(** The strobe monitor: requirements.md §0.6's counting convention, timing
    window and one-report-per-event rule, made mechanical. WO-0033 item
    **X-3**.

    Before this module no monitor counted strobes at all.
    [Conservation_monitor.strobe_pulse] is a call a bench makes {e by hand},
    once per pulse it has already decided happened; it keeps the per-strobe
    histogram REQ-008(a) and REQ-804 need and it is the right instrument for
    that question, but it cannot tell a bench that a strobe pulsed on the wrong
    cycle, that it pulsed twice, or that it pulsed for a frame the stimulus
    never built. Those are the three ways a conformant-looking design gets a
    strobe wrong, and `AP-xgmii_rx_64.md` §7 records all of them as blocked on
    this file.

    Derived from requirements.md §0.6 (the strobe timing window and the C-23
    counting convention), §12 (the twenty-one normative names) and each
    module's own §9. No RTL was read.

    {2 (a) High cycles, never rising edges — carry-forward C-23}

    §0.6, as revised: "The observable is {b one high cycle per reported event}
    … consecutive events produce consecutive high cycles and the strobe does
    {b not} return to 0 between them. A monitor therefore counts {b high
    cycles, never rising edges}: an edge counter sees one event where a
    conformant design reported a hundred, and fails it."

    So [sample] is called {e every cycle} with the set of names that are high,
    and a strobe high on cycles 40 and 41 is {b two} events. That is not a
    convenience: `AP-xgmii_rx_64.md` row **M03-H4** is the first instance on
    the receive chain — back-to-back start characters, each aborting the frame
    the previous one opened — and an edge counter passes it while reporting one
    event where the specification requires several. A bench that samples only
    on cycles it thinks interesting cannot make this check, which is why
    [sample] is total over the run and why [cycles_sampled] is reported.

    {2 (b) The pinned cycle — each module's §9}

    Every strobe in this programme has a {e pinned} cycle, not merely a window:
    SPEC-M03 §9 pins it at the frame's `tlast` cycle, or two cycles after the
    input word carrying the character that ended a frame that emitted nothing;
    SPEC-M14 §9 pins the six header conditions at Ci + 3 and
    `error_ip_truncated` one cycle after the input `tlast` (or after the next
    `hdr_valid`). This monitor does not know those rules — [Module_strobes]
    does, and hands the computed cycle here as an [event]. What this module
    owns is the comparison, and the three failures it separates: the right
    strobe on the wrong cycle, an expected event that never pulsed, and a pulse
    no expected event claims.

    {2 (c) The §0.6 window, checked against the pin itself}

    §0.6 also bounds every strobe: "not earlier than the cycle on which its
    condition first becomes decidable from the module's inputs, and not later
    than the module's latency in cycles (§0.5) after the input word carrying
    the last octet of the offending frame." An [event] carries that window
    alongside its pin, and the monitor checks {b the pin against the window}
    before it checks anything about the design.

    That check is deliberately aimed at the {e specification}, not at the RTL.
    A pinned cycle outside §0.6's window is a defect in the module spec, and it
    is the defect class this programme has already paid for once — SPEC-M03
    §9's withdrawn "the cycle on which that frame's `tlast` word would have
    been emitted" gloss (dv_lead **M03-R2**, repaired at 06c1eba) was exactly a
    pin nobody had reconciled with the window. Finding the next one at bench
    construction rather than at sign-off is the whole return on carrying the
    window here.

    {2 (d) No strobe the stimulus did not create}

    The check a strobe monitor exists for and the easiest to omit: a design
    that pulses `error_runt` on every good frame passes every positive
    assertion in an attack plan. Every high cycle must be claimed by exactly
    one expected event; unclaimed high cycles are reported with their cycle and
    name, and are the monitor's most important output.

    {2 What this module deliberately does not do}

    It does not count frames and it does not balance §0.6's conservation
    equation — [Conservation_monitor] does, on frames rather than pulses
    (carry-forward C-2), and duplicating that here would give a bench two
    answers to one question. A bench runs both: this one says the strobes are
    right, that one says no frame vanished. *)

type t

(** [create ~name ~strobes] for a module whose §9 owns [strobes]. Every name
    must be one of requirements.md §12's twenty-one ([Strobes.mem]); a name
    outside §12 is recorded as an error rather than silently monitored, on the
    same reasoning [Conservation_monitor] rejects an unknown discard
    attribution — an invented name is an invisible way to satisfy a check. *)
val create : name:string -> strobes:string list -> t

(** One expected report, computed by the bench from spec text.

    - [strobe]: the §12 name.
    - [frame]: the index of the frame or datagram this report belongs to, used
      only in messages — a report is a function of {e its} frame (SPEC-M03 §9's
      closure list), so an error that cannot say which frame is half an error.
    - [cycle]: the cycle the module's §9 {b pins}.
    - [not_before] / [not_after]: requirements.md §0.6's window.
    - [why]: the spec clause, quoted or cited, that produced [cycle]. It is
      printed in every message about this event; a bench that cannot fill it in
      has not derived the cycle from the specification. *)
type event =
  { strobe : string
  ; frame : int
  ; cycle : int
  ; not_before : int
  ; not_after : int
  ; why : string
  }

(** Register an expected report. May be called before, during or after
    sampling; the comparison happens in [errors]. *)
val expect : t -> event -> unit

(** [sample t ~cycle ~high] records the strobe names that are high on [cycle].
    Called on {e every} cycle of the run, including cycles where nothing is
    high — [high] is then the empty list — because C-23's counting convention
    is a statement about consecutive cycles and cannot be evaluated on a
    subsample. Sampling the same cycle twice, or sampling out of order, is an
    error: it would double-count a high cycle. *)
val sample : t -> cycle:int -> high:string list -> unit

val name : t -> string
val cycles_sampled : t -> int

(** High cycles observed for one strobe over the whole run — C-23's count, not
    an edge count. *)
val high_cycles : t -> string -> int

(** Every (strobe, cycle) pair observed high, ascending by cycle then name. *)
val observed : t -> (string * int) list

(** Expected events with no matching high cycle, in registration order. *)
val missing : t -> event list

(** High cycles no expected event claims — check (d). *)
val unexpected : t -> (string * int) list

(** Everything wrong, as text: a strobe name outside §12; a sampled name the
    module does not own; a pin outside §0.6's window (a specification defect,
    labelled as one); an expected event that never pulsed; a high cycle nothing
    claims; a duplicate or out-of-order [sample]. *)
val errors : t -> string list

(** True iff [errors] is empty and every expected event pulsed exactly once. *)
val is_clean : t -> bool

(** Deterministic summary for an expect block: the roster with its high-cycle
    counts, the expected/observed totals, and every error. Prints at most
    twelve entries per list so a 10 000-frame run stays reviewable
    (WO-0003 findings §13.2). *)
val report : t -> string
