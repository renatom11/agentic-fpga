(** REQ-016's idle-injection wrapper for the XGMII receive boundary. WO-0033
    item **X-4**; `AP-xgmii_rx_64.md` rows M03-I4, I5 and I6.

    An idle word inserted between two words of a schedule delays every later
    octet by exactly 8 octet times and changes nothing else (REQ-016, SPEC-M03
    §6.1's C-14.4 paragraph, §7's throughput bullet). This wrapper produces
    that stimulus from any [Arrival.t] and, just as importantly, produces the
    {b cycle map} a bench needs to move its expectations with it: the per-octet
    constant of SPEC-M03 §7 survives injection, but every {e cycle} formula in
    §6.1 and §9 is stated on the source's cycle line and has to be translated.

    {2 The constraint is the deliverable as much as the wrapper is}

    SPEC-M03 §6.1, at `541ea43` and unmoved at `06c1eba` — the ruling on
    dv_lead's row **M03-N3**:

    {v
    REQ-016's idle-injection wrapper, which §10 commissions at 0, 1 and 7
    cycles, SHALL NOT place an injected idle cycle between a frame's start
    character and its first octet. Such a cycle occupies preamble positions, so
    the wrapper would be measuring REQ-105's abort rather than REQ-016's
    tolerance, and the frame it claims to carry would no longer have its first
    octet 8 octet times after its start character — the definition this
    paragraph opens with. Injection begins at the frame's first octet.
    v}

    That is a constraint on {e this file}, not on any design, and it is
    enforced here rather than left to each bench: an idle in a preamble
    position is REQ-102's third sentence routing it to REQ-105, so a wrapper
    that placed one would silently convert a REQ-016 tolerance case into an
    abort case and report a conformant module as broken.

    Exactly one inter-word boundary per frame is prohibited, and it is the same
    one at both start lanes: the boundary {b before the word carrying the
    frame's first octet}, i.e. before source cycle [start_cycle + 1]. At a
    lane-0 start the eight preamble positions are lanes 0 … 7 of the start word
    and the first octet is lane 0 of the next; at a lane-4 start the preamble
    runs from lane 4 of the start word through lane 3 of the next, with frame
    octets 0 … 3 in lanes 4 … 7 of that word (SPEC-M03 §6.1). Nothing earlier
    can be prohibited, because a boundary before the start word lies in the gap.

    {2 C-45: the constraint is over-broad at a lane-0 start, and is implemented
    as written anyway}

    dv_lead's ledger row **C-45** (WO-0030, carried at WO-0031, {b confirmed
    untouched} by the injection scope note added at `06c1eba`, which concerns a
    different boundary): at a lane-0 start the prohibition's {e stated ground}
    does not hold. All eight preamble positions lie inside the start word
    itself, so a word inserted after it occupies {b no preamble position} —
    nothing is routed to REQ-105 and REQ-102's third sentence has no instance.
    The constraint's second ground ({e the frame's first octet would no longer
    be 8 octet times after its start character}) does hold at both lanes, which
    is why C-45 is a one-phrase ledger row and not a defect.

    This wrapper therefore {b refuses that boundary at both start lanes}, as
    the specification is written, and names the lane-0 instances separately in
    [c45_sites] so that the residue is visible in a bench's output rather than
    buried in this comment. [?allow_c45] exists to flip it, and defaults to
    [false]: it may be set only if and when C-45 lands as a spec diff, at which
    point M03-I4 gains a case (a lane-0-started frame injected at its first
    inter-word boundary) that no other row reaches. Setting it before that
    would be a bench asserting against text that does not exist.

    {2 What injection does to §6.1's two-events-in-one-word cycles}

    dv_lead, WO-0031, recorded in SPEC-M03 §6.1's consequence 1 and repeated
    here because a bench driving M03-N2 inside this wrapper needs it: of the
    six sub-cases, the two whose aborted-frame report is pinned to the word
    {e before} W — the two lane-0-`/S/` rows — move {b earlier} when an idle is
    injected at that boundary, which widens their separation from the new
    frame's report at W + 2 and never collapses it. The three coinciding rows
    are pinned to W itself or to the closing character's own word and move
    {e with} it, so a coincidence cannot be broken either. Injection therefore
    never turns a "no" into a "yes" or the reverse in that table, and the
    scope note is one-directional: it moves those two rows earlier, and never
    onto the other report.

    {2 Derived from}

    SPEC-M03 §6.1 (the preamble-position paragraph, the C-14.4 gapless
    qualifier, consequence 1's scope note), §7 (throughput and the per-octet
    constants), §10's REQ-016 hook, and requirements.md REQ-016 — all committed
    text at `06c1eba`. No RTL was read. *)

type t

(** One injection site: [idles] idle words inserted immediately before source
    cycle [before_cycle]. [idles] = 0 is legal and is §10's first figure — the
    un-injected run, expressed so that a bench drives all three figures through
    one code path. *)
type site =
  { before_cycle : int
  ; idles : int
  }

(** [create ?allow_c45 schedule ~sites]. Sites are checked against the M03-N3
    constraint at construction; an illegal site is recorded (see [errors]) and
    is {b still applied}, so that a bench which ignores [errors] fails loudly on
    the abort it provoked rather than passing on a stimulus it did not intend.
    Sites are applied in ascending [before_cycle]; two sites at one boundary
    are summed. *)
val create : ?allow_c45:bool -> Arrival.t -> sites:site list -> t

(** §10's commissioned figures applied uniformly: [idles] idle words at
    {e every} legal inter-word boundary of every frame, from the word carrying
    the frame's first octet through the word carrying its terminate character.
    [uniform schedule ~idles:0] is the source schedule unchanged;
    [~idles:1] and [~idles:7] are §10's other two. This is the M03-I4 stimulus:
    the per-octet latency constants of §7 must be unchanged across all three
    runs while every cycle formula in §6.1 moves. *)
val uniform : ?allow_c45:bool -> Arrival.t -> idles:int -> t

val schedule : t -> Arrival.t
val sites : t -> site list

(** Total injected idle words. *)
val injected : t -> int

(** The XGMII word on an injected-line cycle, for any cycle. Total, like
    [Arrival.word_at], so a bench drives it from a plain counter. *)
val word_at : t -> cycle:int -> Xgmii_word.t

(** Cycles the injected schedule occupies. *)
val cycles : t -> int

(** [cycle_of t source_cycle] — where a source cycle lands on the injected
    line. A bench applies this to a SOURCE cycle only — never to an output
    cycle such as `m + 3`, which is not in this function's domain: an output
    word's own timing depends on the LATEST source word it depends on
    (SPEC-M03 §6.1 consequence 1's own dependency octet for an ordinary word,
    or the terminate character's word for the tlast word), and it is THAT
    source cycle a bench translates through [cycle_of] — never the output
    cycle itself. (This corrects the docstring's own former second sentence,
    which named `m + 3` — an output cycle — as an argument this function
    could take; RV-0059-VERDICT FINDING 4, `agents/handoffs/
    WO-0059_tb-m03-family-i-silence-and-ordered-sets.md` §8 states the
    corrected rule a caller applies.) Monotonic and injective. *)
val cycle_of : t -> int -> int

(** True when an injected-line cycle carries an injected idle word rather than
    a source word. A bench asserting REQ-016's "no output word is produced and
    no condition is raised" for such a cycle needs to know which they are. *)
val is_injected : t -> cycle:int -> bool

(** Octet times of every octet of a frame on the {b injected} line, in wire
    order — the array [Dv_monitors.Octet_time.Latency.frame_in] expects.
    [Arrival.in_times] gives the source line and is wrong under injection by
    exactly 8 octet times per idle word inserted inside the frame, which is
    REQ-016's own arithmetic. *)
val in_times : t -> Arrival.frame -> int array

(** Sites this wrapper refused, or would have refused: the M03-N3 constraint's
    violations, with the frame and start lane named. Empty for a conformant
    site list. *)
val errors : t -> string list

(** The subset of [errors]' sites that are refused {e only} by the
    over-breadth C-45 names — a boundary after a lane-0 start word, occupying
    no preamble position. Reported separately so the residue is visible and so
    that, if C-45 lands, the diff to this file is one default. *)
val c45_sites : t -> int list

val is_clean : t -> bool

(** Deterministic summary for an expect block: the figures, the site count, the
    injected total, the cycle stretch, and any constraint violations. *)
val report : t -> string
