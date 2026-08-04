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

    Repeated here because a bench driving M03-N2 (benched at `WO-0065` §3.3)
    inside this wrapper needs it: every cycle in §6.1's six-row table is
    pinned relative to a {b named input word}, and that word is **W** — the
    word carrying the aborting `/S/` — in EVERY row, the two whose report is
    `W + 1` included: an aborted frame's last word can be proven last by
    nothing except the character that aborted it, so its own deciding word is
    W and not the word carrying its own last octet (SPEC-M03 §6.1's `D(m)`,
    re-ruled at `1f3c04c`, countersigned `J-dv_lead-0086`). Idle injection
    before W therefore moves BOTH reports of every row TOGETHER, by the same
    amount — the new frame's report at `W + 2` included — so the coincidence
    column is unchanged at every k (`06c1eba`; `J-dv_lead-0087`). The three
    coinciding rows are pinned to W itself and move {e with} it for the same
    reason, not a different one. Injection therefore never turns a "no" into
    a "yes" or the reverse in that table.

    *Superseded ground, kept for history rather than deleted* (dv_lead,
    WO-0031's own scope note): this paragraph originally pinned the two
    non-coinciding rows against the word carrying the aborted frame's own
    LAST OCTET, under which injection before that word moved those two rows
    {b earlier}, widening their separation from the new frame's report and
    never onto it. The conclusion is unchanged; the ground it now rests on is
    the named word W above, not that one (§6.1's own withdrawal note,
    `J-dv_lead-0085`).

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
    could take; RV-0059-VERDICT FINDING 4.) The corrected rule a caller
    applies is SPEC-M03 §6.1's D(m) as re-ruled at `1f3c04c`:
    [baseline_cycle(m) + (cycle_of(D m) - D m)], with D(m) always a SOURCE
    cycle. (Citation repaired at `J-dv_lead-0105`: this docstring credited
    "`agents/handoffs/WO-0059_…md` §8", and that packet's §8 is titled
    "`test/xgmii_rx_64/bench.mli`, `bench.ml` and `dune`" and states no
    cycle rule at all. The section meant was `RV-0059-VERDICT` §8 -- which
    is appended inside that same file, so the path was right and only the
    packet name was dropped -- but RV-0059-VERDICT §8 is the rule that was
    REFUTED and re-based, so re-citing it would preserve a dead pointer's
    aim rather than repair it. History kept, authority moved: WO-0060 §3.6's
    own rule, applied here as it was to the three sites in
    `test/xgmii_rx_64/test_m03_i.ml`.) Monotonic and injective. *)
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
