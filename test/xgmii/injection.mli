(** The link partner's error-injection catalogue, and the §9 outcome each
    injected frame is owed. WO-0033 item **X-1**; REQ-018's second contract
    clause, deliberately deferred by [Arrival] until an attack plan existed to
    review it for coverage.

    `AP-xgmii_rx_64.md` §7 names this "the largest single item" and lists what
    it must produce: per-frame corruption of one payload bit (bad FCS);
    replacement of a frame's closing character by `/S/` or `/E/` at a chosen
    octet time; placement of `/E/`, `/T/` or `/S/` at a chosen {b preamble}
    position; over-length and under-length frames; and, per injected frame, the
    {b expected §9 outcome} — delivered octet count, `tkeep`, abort bit, strobe
    name and pinned cycle — so a bench compares against a model rather than
    against hand-copied constants. Rows B2–B4, D1, D3, E1–E4, F1–F5, G1–G6,
    H1–H4, M1–M7 and N1 are blocked on it.

    {2 The outcome is computed, not tabulated, and why that matters}

    A catalogue of hand-written expectations is a second copy of §9, and a
    second copy drifts. [outcomes] instead runs SPEC-M03 §6.2's state machine
    and §9's closure list over the octet-time line the catalogue emits, and
    reports what the specification says happens. Three things fall out of that
    choice rather than being programmed:

    - the {b two-events-in-one-word} cases of §6.1's consequence 1 (dv_lead's
      row **M03-N2**, benched at `WO-0065` §3.3) are ordinary: each character
      is evaluated at its own octet time, against the frame open at that octet
      time, so one input word aborting a frame, opening another and closing
      that one too is three events and three outcome entries;
    - a frame the {e stimulus} opens — an injected `/S/` mid-frame opens one —
      gets an outcome even though no entry of the catalogue describes it, which
      is exactly the frame a hand-written table forgets;
    - the strobe cycles are pinned relative to a {b named input word} — REQ-105's,
      REQ-107's and REQ-110's own closing character, or REQ-108's truncating
      octet — which is what makes them survive idle injection (requirements.md
      §0.5's {e deciding input word}), rather than from §7's per-octet constant,
      whose gap-invariance is WITHDRAWN as false (`SCR-M03-I4`, requirements.md
      §0.5 and SPEC-M03 §6.1 at `a77017c`), nor from §6.1's `m + 3`, which is
      qualified to a gapless stimulus (C-14.4). That is what lets these
      outcomes be used inside [Idle_injection] — see below.

    {2 What this model is, and what it may not yet do}

    It is a model of §9's {e reports}, not of the datapath: it computes how many
    octets a frame delivers and when each strobe pulses, and it says nothing
    about the octets' values beyond the count (those come from
    [Arrival.delivered] and [Frame], which already have their own REQ-304
    anchor). It is a golden model in the charter's sense and it has {b not} yet
    met the charter §3 external anchor — the Phase 1 anchor for MAC behaviour
    is the verilog-ethernet differential co-sim, and no `SO-xgmii_rx_64.md` PASS
    may rest on this model until that co-sim has run. What it {e is} anchored
    against today is `AP-xgmii_rx_64.md` itself: the plan's rows carry
    hand-derived delivered counts, `tkeep` values and cycles, derived before
    this file existed and by a different route (§6.1's `m + 3` and §9's table),
    and `test_injection.ml` checks the model against them. Two independent
    derivations agreeing is not an external anchor; it is the cross-check that
    makes the model fit to {e build benches with} while the anchor is pending,
    and the distinction is stated here so no sign-off packet blurs it.

    {2 Under idle injection}

    Outcomes are stated on the {b un-injected} cycle line. A bench running a
    case inside [Idle_injection] maps every [cycle] through
    [Idle_injection.cycle_of]. That is sound because every cycle here is
    pinned relative to a {b named input word}, and for the two-events case
    that word is **W** — the word carrying the aborting `/S/` — in EVERY row
    of §6.1's six-row table, the two whose report is `W + 1` included: an
    aborted frame's last word can be proven last by nothing except the
    character that aborted it, so its own deciding word is W, not the word
    carrying its own last octet (SPEC-M03 §6.1's `D(m)`, re-ruled at
    `1f3c04c`, countersigned `J-dv_lead-0086`). Idle injection before W
    therefore moves BOTH reports TOGETHER, by the same amount, and the
    coincidence column is unchanged at every k (`06c1eba`; `J-dv_lead-0087`).
    *Superseded ground, kept for history rather than deleted*: dv_lead's
    WO-0031 scope note originally read this pinning against the word carrying
    the aborted frame's own last octet, under which injection before that
    word moved the two lane-0-`/S/` rows {b earlier}, widening their
    separation from the new frame's report and never onto it — a conclusion
    that still holds, now for the reason stated above rather than for that
    one (§6.1's own withdrawal notes are the ground; `J-dv_lead-0085`).

    {2 Derived from}

    SPEC-M03 §6.1 (the preamble-position routing, consequence 1 and its cycle
    table, the emission rule), §6.2 (all four states), §7 (the per-octet
    constants L = 16 / 12 and h = 8 / 12), §9 (the nine-row table, the closure
    list, the pinned strobe cycles and the seven co-occurrence rulings), and
    requirements.md §0.6, §0.7, §12 and REQ-101 … REQ-110 — all at `06c1eba`.
    No RTL was read (PROTOCOL §10). *)

(** Where a control character is placed, relative to the frame's own start
    character. *)
type placement =
  | At_preamble of int
      (** preamble position 1 … 7 — the octets after the start character and
          before the frame's first octet (REQ-102). Position 0 is the start
          character itself and is not a placement. *)
  | At_octet of int
      (** frame octet offset: 0 is the frame's first octet, so the character
          {e replaces} that octet. SPEC-M03 §9's "at or before the frame's
          first octet" is [At_octet 0] and [At_preamble _]. *)
  | At_terminate
      (** the octet time the frame's own terminate character would occupy —
          §7's "replacement of the terminate character by `/S/` or `/E/`". *)

type corruption =
  | Flip_bit of
      { octet : int
      ; bit : int
      }
      (** flip bit [bit] of the frame's octet [octet] (DA-through-FCS index)
          {e after} its FCS was computed, so the REQ-304 residue fails and
          nothing else changes. REQ-104, rows D1 and D3. *)
  | Place of
      { placement : placement
      ; character : int
      }
      (** put an XGMII control character ([Xgmii_word.start_char],
          [terminate_char] or [error_char]) at [placement]. A `/S/` must land in
          lane 0 or lane 4 — SPEC-M03 §6.3 item 3 leaves any other lane
          deliberately unconstrained {e because} the link-partner contract never
          produces it, so [create] refuses it rather than commissioning a test
          for a stimulus the programme decided not to make. An `/I/` or `/Q/` is
          accepted only at [At_preamble] (REQ-102's third sentence routes it to
          REQ-105); inside an open frame it is outside the specified space and
          is refused. *)

type frame_case =
  { octets : int list (** DA through FCS, requirements.md §0.3's length *)
  ; corruptions : corruption list
  }

(** A frame with a correct FCS and nothing done to it. *)
val clean : int list -> frame_case

(** [corrupt octets cs] — the same frame with [cs] applied. *)
val corrupt : int list -> corruption list -> frame_case

(** A frame of [octets] octets DA through FCS carrying a correct FCS, built
    from [Frame.stress_frame] where the length allows and from filler plus a
    computed FCS otherwise. [octets] below 5 has no FCS at all — REQ-107's
    fewer-than-five-octet runt — and is built as raw octets. *)
val frame_of_length : ?sequence:int -> int -> int list

type t

(** [create ?ifg ?first_start ?first_lane cases]. Frames are laid out by
    [Arrival] at the REQ-004 arrival rate, so start lanes alternate exactly as
    SPEC-M03 §8 requires and the schedule's own §0.3 contract is checked.
    [first_lane] selects the first frame's start lane (0 or 4) so a case may be
    driven at both alignments, which REQ-101 requires of every row. *)
val create
  :  ?ifg:int
  -> ?first_start:int
  -> ?first_lane:int
  -> frame_case list
  -> t

val schedule : t -> Arrival.t
val word_at : t -> cycle:int -> Xgmii_word.t
val cycles : t -> int

(** One strobe report: a requirements.md §12 name, the cycle SPEC-M03 §9 pins
    it to, and requirements.md §0.6's window around that pin. The window is
    carried here rather than recomputed by each bench because it is what makes
    a {e specification} defect visible — a pin outside its own window is the
    class M03-R2 already was (SPEC-M03 §9's withdrawn gloss, repaired at
    06c1eba). *)
type report =
  { strobe : string
  ; cycle : int
  ; not_before : int
  ; not_after : int
  }

(** What §9 says becomes of one frame the receiver opened. Frames are numbered
    in the order the {b receiver} opens them, which is not the catalogue's
    order when an injected `/S/` opens a frame of its own. *)
type outcome =
  { frame : int
  ; start_cycle : int
  ; start_lane : int (** 0 or 4 *)
  ; received : int (** octets between the start and closing characters *)
  ; delivered : int (** octets emitted, REQ-103 — 0 for a §0.7 frame *)
  ; words : int (** output words, [ceil (delivered / 8)] *)
  ; last_tkeep : int (** `tkeep` on the `tlast` word; 0 when no word is emitted *)
  ; tlast_cycle : int option (** the cycle the `tlast` word leaves, if any *)
  ; abort : bool (** `tuser`[0] on the `tlast` word (REQ-007) *)
  ; reports : report list (** every strobe this frame owes, in §12 order *)
  ; note : string (** the §9 row, named *)
  }

(** Every frame the receiver opens over the whole schedule, in opening order. *)
val outcomes : t -> outcome list

(** Every report of every frame, flattened into the events
    [Dv_monitors.Strobe_monitor.expect] consumes, ordered within each frame by
    requirements.md §12. This is the whole join between X-1 and X-3: a bench
    registers these, samples the design's strobes every cycle, and the monitor
    reports the three failures separately (wrong cycle, missing report, a
    strobe the stimulus did not create). *)
val expected_strobes : t -> Dv_monitors.Strobe_monitor.event list

(** Stimulus the catalogue could not build or the specification does not cover:
    a `/S/` outside lanes 0 and 4, an `/I/` inside an open frame, a placement
    off the end of the frame, a schedule whose §0.3 contract [Arrival] rejects.
    A bench must treat a non-empty list as a construction failure, not as a
    result. *)
val errors : t -> string list

val is_clean : t -> bool

(** Deterministic summary for an expect block: one line per outcome with its
    counts, `tkeep`, abort bit and reports, then any construction errors. *)
val report : t -> string
