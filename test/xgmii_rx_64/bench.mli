(** WO-0038 scaffolding: one elaborated {!Hardcaml_ethernet.Xgmii_rx_64}
    instance, wired to the standing obligations AP-xgmii_rx_64.md §2 attaches
    to every M03 bench, plus the drive/sample loop every row in this packet
    reuses.

    {2 Independence, stated because this is the file that touches the DUT}

    [create] names three things from SPEC-M03 alone (WO-0038 §4): the library
    [Hardcaml_ethernet], the module [Xgmii_rx_64], and the entry point
    [create : Scope.t -> Signal.t I.t -> Signal.t O.t]. Every port after that
    is reached by projecting a field off the live [Cyclesim.inputs] /
    [Cyclesim.outputs] record ([i.xgmii_rx.d], [o.rx.tvalid], …) rather than
    by naming the concrete module that defines [Xgmii.t] or [Axi64.Source.t]
    — OCaml's type-directed field disambiguation resolves those projections
    against whatever type [Xgmii_rx_64.I.t] and [.O.t] actually declare, so
    this file takes no position on whether that module is
    [Ifc_check.Axi64_ifc]'s or a structurally identical one of
    [hardcaml_ethernet]'s own. [libs/**] and [rtl_snapshots/**] were not
    opened to write this file (PROTOCOL §10, WO-0038 §5).

    {2 What [create] wires and what a row wires itself}

    Standing obligations 1-4 (AP-xgmii_rx_64.md §2) attach to every bench in
    this packet: a {!Protocol_monitor} (obligation 1,
    [~max_words_per_frame:190]), a {!Conservation_monitor} (obligation 2), an
    {!Octet_time.Latency} tagger (obligation 3,
    [~strip_octets:8 ~tail_octets:4 ~front_offsets:[8; 12] ~ceiling:4]) and a
    {!Strobe_monitor} naming all five §12 M03 strobes (obligation 4) are
    created here and returned by {!protocol}, {!conservation}, {!latency} and
    {!strobes}. [run] feeds every cycle to the protocol and strobe monitors
    automatically. The conservation and latency monitors are *not* fed by
    [run]: only a row knows how many of its frames are exempt, aborted or
    discarded (none, in this packet's clean-frame slice — family J's
    disabled-enable frames are `test_m03_j.ml`'s own rows now (WO-0067 §5),
    which call {!Conservation_monitor.frame_in_exempt} rather than this
    function; family K's [clear]-truncated ones are still out of every row
    here), so {!account_clean_frame} is what a row calls instead, per the charter's
    "wire the calls now" even though every call in this slice but M03-C4's is
    the same [~aborted:false] shape. Every frame in this packet delivers
    exactly the clean-frame identity extent (input − 8 − 4 octets, M03-C4's
    one-octet runt included: 13 input octets − 8 − 4 = 1, its actual
    delivered count) — the truncated/aborted classes [Latency.frame_out]'s
    [?expected_octets] exists for are family E/F/G/H, out of this packet's
    eleven rows — so {!account_clean_frame} never supplies it. Obligation 5
    ([Arrival.check]) and obligation 6 (never read [tdata] where [tkeep] is
    0, never read a field on a [tvalid] = 0 cycle) are the caller's to
    honour: [run] itself discharges obligation 5 (see below), and [run]'s own
    [sample] type carries [Stream_word.t], whose accessors already refuse
    reading tkeep-masked or tvalid=0 fields (test/monitors/stream_word.mli). *)

open! Base

type t

(** Elaborate [Hardcaml_ethernet.Xgmii_rx_64], release [clear] after one
    cycle, driving [cfg_rx_enable] = 1 THROUGH that reset cycle — REQ-009's
    cycle, outside every schedule {!Enable.t} governs (WO-0067 §1.4) — and
    attach the three standing monitors described above. From cycle 0 the
    enable is {!run}'s own [?enable] argument: its default, {!Enable.high},
    is 1 for the whole run and is byte-for-byte what every unit landed
    before WO-0067 was written against. [clear] itself is driven at 1 through
    this same reset cycle and released immediately after — REQ-009's own
    cycle, likewise OUTSIDE every schedule {!Clear.t} governs (WO-0072 §1.4):
    from cycle 0 the clear state is {!run}'s own [?clear] argument, whose
    default {!Clear.never} is 0 for the whole run and is byte-for-byte what
    every unit landed before WO-0072 was written against. *)
val create : unit -> t

val protocol : t -> Dv_monitors.Protocol_monitor.t
val conservation : t -> Dv_monitors.Conservation_monitor.t
val strobes : t -> Dv_monitors.Strobe_monitor.t
val latency : t -> Dv_monitors.Octet_time.Latency.t

(** The five REQ-008 strobe names SPEC-M03 §9 / requirements.md §12 give M03,
    in the [O] record's field order. What {!create}'s {!Strobe_monitor} is
    built with. *)
val strobe_names : string list

(** A [cfg_rx_enable] schedule: the value in force from cycle 0, and the
    cycles at which it changes. The reset cycle {!create} drives is outside
    every schedule and is not governed by this type — see {!create}
    (WO-0067). *)
module Enable : sig
  type t

  (** 1 for the whole run. The DEFAULT, and byte-for-byte the behaviour every
      unit landed before WO-0067 was written against. *)
  val high : t

  (** 0 for the whole run — M03-J1's own stimulus before its re-enable. *)
  val low : t

  (** [changes ~initial cs] — [initial] from cycle 0, then the value of each
      [(cycle, value)] of [cs] from that cycle inclusive. Cycles must be
      strictly ascending and positive; a repeated or descending cycle, or a
      change to the value already in force, raises at construction, because
      a schedule that says nothing at a cycle it names is a schedule its
      author did not mean. *)
  val changes : initial:bool -> (int * bool) list -> t

  (** The value driven on [cycle]. Total, like [Arrival.word_at]. *)
  val value_at : t -> cycle:int -> bool

  (** The cycles at which the driven value differs from the previous cycle's,
      with the value taken -- including the boundary transition against the
      value {!create} drives through the reset cycle, taken as the value in
      force immediately before cycle 0 (WO-0068 §7): a schedule whose
      [initial] is [false] therefore reports [(0, false)] as its own first
      entry, and [high] -- [initial] [true], no further changes -- still
      reports [[]]. [changes] and [change_cycles] are NOT inverse:
      [changes] refuses a cycle-0 entry ([cycle <= 0] raises), so a value
      this function returns cannot always be fed back to it. [changes] is
      the author's DECLARATION; this is the derived OBSERVATION, including
      the boundary transition no author declares because [~initial] is how
      it is expressed (WO-0068 §7.3). *)
  val change_cycles : t -> (int * bool) list

  (** A deterministic diagnostic rendering of a schedule, for failure
      messages and for a future row that needs to print one -- not for an
      expect block: `WO-0067` §5.5 forbids that use, and the docstring that
      once named it is withdrawn (WO-0068 §8). The {!Enable.t} shape was
      chosen on the five-call-sites-hand-computing-an-off-by-one ground
      alone (`WO-0067` §1.3(d)'s (R-b)); the [report] half of that argument
      was falsified by the same packet's own §5.5 and is withdrawn here. *)
  val report : t -> string
end

(** A [clear] schedule: which cycles of a run drive REQ-009's synchronous
    clear. The reset cycle {!create} drives is OUTSIDE every schedule and is
    not governed by this type — see {!create} (WO-0072 §1.4).

    {2 Why this shape and not {!Enable.t}'s (WO-0072 §1.3, §2)}

    A literal transplant of {!Enable}'s [changes ~initial [(cycle, value)]]
    shape breaks twice at this port. First, [~initial] expresses a cycle-0
    transition no author declares, and for [clear] the value in force before
    cycle 0 is 1 ({!create} drives it through the reset cycle) — so [never],
    the default, would itself carry a real 1 -> 0 boundary transition and a
    guard entered on a non-empty transition set would enter on EVERY landed
    run in this suite (BOUNCE BK4). Second, the guard's subject here is a
    HIGH CYCLE coinciding with a start character, not a CHANGE coinciding
    with one — [cfg_rx_enable]'s guard fires on a change because §6.3 item 7
    leaves a same-cycle change undetermined; this port's guard must not fire
    on the release cycle, which REQ-009's last sentence blesses in terms, and
    a transition-set guard would refuse M03-K2's own commissioned stimulus
    (BOUNCE BK5). The reusable form: a guard's entry condition must project
    the guard's OWN subject, and that subject is re-derived per port — two
    ports of the same module can share a schedule's shape and have different
    subjects, different reset polarities and opposite verdicts on the same
    coincidence. *)
module Clear : sig
  type t

  (** 0 for the whole run. The DEFAULT, and byte-for-byte the behaviour every
      unit landed before WO-0072 was written against. *)
  val never : t

  (** [window ~first ~last] — 1 on cycles [first] .. [last] INCLUSIVE, 0 on
      every other cycle. Raises unless [0 <= first] and [first <= last],
      because a window whose end precedes its start is a window its author
      did not mean. [first = 0] is legal and means "extend the reset":
      {!create}'s own reset cycle already drove [clear] = 1, so a window
      opening at cycle 0 is a longer reset and nothing else. *)
  val window : first:int -> last:int -> t

  (** The value driven on [cycle]. Total, like [Arrival.word_at]. *)
  val value_at : t -> cycle:int -> bool

  (** The cycles at which the driven value is 1, ascending; [[]] for
      {!never}. This is the SUBJECT of {!run}'s pre-scan guard, and {!run}
      enters that guard on this set being non-empty — a projection of the
      subject, never a separate predicate that reconstructs it (WO-0068
      §7.3's rule, applied at the design rather than at a repair). *)
  val high_cycles : t -> int list

  (** [not (List.is_empty (high_cycles t))] — the guard's entry condition,
      named so the condition and its subject are the same object. *)
  val is_ever_high : t -> bool

  (** A deterministic diagnostic rendering, for failure messages. NOT for an
      expect block — [WO-0067] §5.5's rule still governs and this docstring
      does not withdraw it. *)
  val report : t -> string
end

(** One driven-and-sampled cycle: the XGMII word presented to [xgmii_rx] on
    [cycle], the [cfg_rx_enable] value driven that same cycle ({!Enable},
    WO-0067 — [true] is enabled), and the [rx] word the standing
    {!Axi64_probe} sampled from [cycle]'s own outputs, plus the names of
    every error strobe high that same cycle (a subset of {!strobe_names},
    read directly off the DUT's error outputs — never inferred). [after_out]
    is a second, diagnostic-only reading of that same cycle, described below.

    {2 [Before], not the default [After] (RV-0038-R6 / R6-1)}

    [Cyclesim.cycle] runs check -> comb -> seq -> comb, and [Cyclesim.outputs]
    can read either side of the seq step. The default, [~clock_edge:After],
    returns [f(regs(cycle + 1), word(cycle))] — the design's combinational
    logic evaluated against the NEW, post-edge register state, still paired
    with the word just driven. [~clock_edge:Before] returns
    [f(regs(cycle), word(cycle))] — the design's actual hardware value
    DURING [cycle], for a registered output and one combinational in the
    current word alike.

    Round 5 (RV-0038-R5) read the default [After] view and labelled it
    [out_cycle = cycle + 1]. {b That relation is still exactly right for a
    REGISTERED output, and the evidence for it has not changed}:
    [test/hardcaml_ethernet/test_word_counter.ml]'s promoted waveform shows
    [valid] high during cycle 1 producing [count] = 1 during cycle 2, and
    every ΔC = 3 / [start_cycle + 3] figure this bench asserts is exactly
    what that relation predicts — under [Before] those same figures read at
    [cycle], not [cycle + 1], because there is no relabelling left to do.
    What round 5 got wrong was generalising a fact about one registered
    signal ([word_counter]'s [count]) to every M03 output. [BUG-0001]'s R-1
    finding (`agents/handoffs/BUG-0001_m03-final-word-over-delivery.md`,
    accepted at `RV-0038-R7` / [J-dv_lead-0032]) is the counter-example it
    missed: M03's [rx] stream and its five error strobes are combinational
    in the CURRENT XGMII word (SPEC-M03 §6.1's one-word lookahead), and at a
    lane-4 start whose terminate character lands alone in lane 0 of its own
    word, the age-0 closure record that produces [tlast] is gone by the
    time [After]'s post-edge state is read — a state that exists in no
    hardware cycle at all for that signal. [Before] has no such gap: it is
    the SAME cycle's state the design actually held on the wire, for every
    field of [O.t], registered or not, so it needs one label ([cycle])
    rather than two. {b Every timing NUMBER this bench asserts is unchanged
    by the switch} — [Before]'s [cycle] reads exactly the value [After]'s
    retired [out_cycle] used to — which is what makes this a bench repair,
    not a spec revision.

    {2 [after_out] (RV-0038-R6 / R6-3)}

    [after_out] is [cycle]'s [rx] stream read from the default [After] view
    instead of [Before] — the exact reading round 5 used, kept solely to
    demonstrate the sampling artefact in a run rather than assume it. No
    behavioural assertion in this bench reads it: every content, monitor and
    timing check uses [out]. A row comparing [after_out] against [out] is
    comparing this bench's own two conventions against each other, never
    asserting a fact about M03. *)
type sample =
  { cycle : int
  ; in_word : Dv_xgmii.Xgmii_word.t
  ; enable : bool
      (** [cfg_rx_enable] as driven on [cycle] (WO-0067) — the choke-point
          reading of whatever {!run}'s own [?enable] resolved to for this
          cycle, never the schedule's memory of the argument passed in
          (M03-I2 member (iii)'s "construction and landing checked at both
          sites", applied to this port a second time). *)
  ; clear : bool
      (** [clear] as driven on [cycle] (WO-0072 §1.2) — the choke-point
          reading of whatever {!run}'s own [?clear] resolved to for this
          cycle, never the schedule's memory of the argument passed in
          (M03-I2 member (iii)'s "construction and landing checked at both
          sites", applied to this port a third time). Both K rows assert
          "this cycle was a clear cycle and the design was silent on it";
          without this field a row whose window landed one cycle off has no
          instrument that can say so (WO-0072 §1.2). *)
  ; out : Dv_monitors.Stream_word.t
  ; after_out : Dv_monitors.Stream_word.t
  ; errors_high : string list
  }

(** [run t sched ~drain ()] first calls [Arrival.check sched] (standing
    obligation 5) and [failwith]s naming every returned description if it is
    non-empty — a stimulus generator nobody has checked is an unverified
    assertion about the design, so this happens before a single cycle is
    driven. It then drives cycles [0 .. Arrival.cycles sched - 1] of [sched]
    via {!Xgmii_probe.to_refs}, then [drain] further idle (all-/I/) cycles so
    a frame still draining through the two-word pipeline is fully observed
    (§6.1's drain window is at most 2 cycles after the terminate word;
    [drain] should comfortably exceed that — every row in this packet uses
    8). Every cycle, in schedule order and including the [drain] tail, is
    driven and sampled through an internal choke-point ordering guard
    (RV-0038-R5 / R5-1: [failwith]s naming the out-of-order cycle the instant
    one is driven, since that one function is the only place a reversed or
    skipped drive can be caught before anything downstream treats the result
    as a statement about the design), then (a) turned into a {!sample}, (b)
    fed to the standing {!Protocol_monitor} and (c) fed to the standing
    {!Strobe_monitor} via [sample ~cycle ~high:errors_high], then (d), when
    the driven [clear] is 1, fed to the standing {!Protocol_monitor}'s
    [on_clear] (WO-0072 §4) — [cycle] is the sample's only cycle label
    (RV-0038-R6 / R6-1: the [Before] view read into {!sample}'s [out] already
    belongs to this same cycle, so there is no second, later cycle for a
    monitor call to name). C-23's counting convention requires every cycle,
    including ones where nothing is high, so [run] is the only place that
    call is allowed to happen. [on_clear]'s own call goes LAST, after both
    (d) follows (b) and (c): a run with {!Clear.never} makes zero [on_clear]
    calls, so the landed call sequence stays byte-identical rather than
    merely equivalent, and reading [observe] before [on_clear] is what lets a
    phantom [tlast] on a clear cycle be caught twice, independently, rather
    than masked by [observe] having already zeroed the frame-in-progress
    count [on_clear] would otherwise find (WO-0072 §4.2). A row never calls
    [on_clear] itself — {!bench.mli}'s own "wire the calls where the schedule
    is in scope" rule, one port over.

    [?word_at] overrides the word driven on a single cycle (identity is
    [Arrival.word_at sched]): M03-B1 uses it to substitute a non-standard
    preamble/SFD data pattern into the schedule's own start word while
    leaving [Arrival]'s control-character placement, frame content and FCS
    untouched — [Arrival]'s own contract fixes the preamble at 0x55/0xD5 and
    exposes no parameter to vary it (test/xgmii/arrival.mli, "What the model
    does not decide"), so overriding the word after [Arrival] builds the
    schedule is the only way to drive that stimulus without hand-deriving
    the rest of the cycle table.

    [?enable] is the per-cycle [cfg_rx_enable] schedule (WO-0067), defaulting
    to {!Enable.high} — 1 for the whole run, byte-for-byte what every unit
    landed before WO-0067 drove. It reaches the design through the same
    choke point as the XGMII word: {!sample_cycle} drives [cfg_rx_enable] on
    the same cycle it drives the word, and the value driven is recorded in
    {!sample}'s [enable] field, never left to a caller's memory of the
    schedule it built.

    [?clear] is the per-cycle synchronous-clear schedule (WO-0072, REQ-009),
    defaulting to {!Clear.never} — 0 for the whole run, byte-for-byte what
    every unit landed before WO-0072 drove. It reaches the design through the
    SAME choke point as the XGMII word and [cfg_rx_enable]: {!sample_cycle}
    drives [clear] on the same cycle it drives the word, and the value driven
    is recorded in {!sample}'s [clear] field, never left to a caller's memory
    of the schedule it built (R-c, WO-0072 §1.1).

    {2 The M03-J4 guard}

    When, and only when, [Enable.change_cycles enable] is non-empty, [run]
    walks every cycle it is about to drive — BEFORE driving any of them —
    and compares the enable value that cycle would carry against the
    previous cycle's, with the pre-run value {!create} drives through the
    reset cycle taken as [true] for cycle 0's own comparison (WO-0067 §1.4).
    Where that comparison is a change AND the word this call would actually
    drive that cycle carries a start character
    ([Dv_xgmii.Xgmii_word.start_lane] returns [Some _]) — read from the
    DRIVEN word, through the very [word_at] this function drives from, and
    never from [Arrival.start_cycles]: an injected start character (M03-N4's
    own stimulus) reaches a row through [?word_at] and is absent from
    [Arrival] entirely, so a guard built on [Arrival] would report clean on
    the one stimulus it exists to catch — [run] [failwith]s naming every
    such cycle and its start lane, citing SPEC-M03 §6.3 item 7 and
    carry-forward C-14.5. It REFUSES to drive rather than recording the
    violation and driving it anyway, unlike {!Dv_xgmii.Idle_injection}'s own
    illegal-placement guard: that guard's illegal stimulus produces a
    DETERMINATE wrong answer (REQ-105's abort) a bench can assert against via
    [errors]; a [cfg_rx_enable] change on a start character's own cycle has
    no determinate outcome at all (§6.3 item 7's own words), so there is
    nothing for a recorded-and-applied run to assert and a green result would
    certify coverage of a stimulus this specification refuses to constrain.
    [Enable.high]'s empty [change_cycles] means an [?enable]-omitted call
    enters none of this: it evaluates [word_at] exactly as many times as it
    did before WO-0067 and can raise no exception this guard introduces. A
    schedule whose value at cycle 0 is [false] now enters the pre-scan
    through this same condition, because its boundary transition with the
    reset cycle is one of the cycles [change_cycles] reports (WO-0068 §7).

    {2 The K guard (WO-0072 §3) — refuse-to-drive, not record-and-apply}

    When, and only when, [Clear.is_ever_high clear], [run] walks cycles
    [0 .. total - 1] BEFORE driving any of them, and for every cycle [c] at
    which [Clear.value_at clear ~cycle:c] is [true] it evaluates the word
    this call would actually drive on [c] — through this same [word_at], and
    NEVER through [Arrival.start_cycles]: an injected start character is
    absent from [Arrival] entirely (§3.3, BOUNCE BK6) — and tests
    [Dv_xgmii.Xgmii_word.start_lane]. Every cycle at which that returns
    [Some lane] is collected; if the collection is non-empty, [run]
    [failwith]s naming every such cycle and its start lane, citing REQ-009,
    SPEC-M03 §6.2's [Idle] row and §7's reset bullet.

    This is not prudence, it mechanises a genuine ambiguity: SPEC-M03 §6.2's
    [Idle] row admits a [/S/] with no [clear] = 0 qualifier, while §7's reset
    bullet holds the state in [Idle] while [clear] = 1 — the two cannot both
    be applied literally to a cycle carrying both a [/S/] and [clear] = 1,
    and neither reading is asserted here because there is no determinate
    answer to assert against (unlike {!Dv_xgmii.Idle_injection}'s own
    illegal-placement guard, whose illegal stimulus produces a DETERMINATE
    wrong answer a bench can assert via [errors] — REFUSE-TO-DRIVE is this
    guard's own inverse of that shape, and for the reason stated, not by
    convention).

    The guard's SUBJECT is [Clear.high_cycles] — a high cycle, never a
    transition — which is why {!Enable}'s own transition-set guard cannot be
    transplanted here (WO-0072 §2): [clear]'s reset-cycle polarity is
    inverted against [cfg_rx_enable]'s, so [Clear.never] would report a
    boundary transition under a copied guard and every landed run would enter
    a walk it does not today (BOUNCE BK4); and a transition-set guard fires
    on M03-K2's own release-cycle stimulus, which REQ-009's last sentence
    blesses in terms and which the guard above therefore must NOT refuse
    (BOUNCE BK5) — the guard tests HIGH CYCLES, and the release cycle is
    never one. Three cases this guard must not refuse, named so they are not
    rediscovered: a clear window whose release cycle carries a start
    character (M03-K2's own stimulus); a clear window opening at cycle 0
    (an ordinary longer reset — {!create}'s own reset cycle already drove
    [clear] = 1); and a terminate or error character on a clear cycle (§6.2's
    [Idle] row is unambiguous for [/T/] and [/E/] — the guard tests
    [start_lane] and nothing else).

    [Clear.never]'s empty [high_cycles] means a [?clear]-omitted call enters
    none of this: it evaluates [word_at] exactly as many times as it did
    before WO-0072 and can raise no exception this guard introduces. This
    walk sits after the M03-J4 guard above and before the first
    [sample_cycle] — the two pre-scans are independent and neither reads the
    other's schedule. *)
val run
  :  t
  -> Dv_xgmii.Arrival.t
  -> drain:int
  -> ?word_at:(cycle:int -> Dv_xgmii.Xgmii_word.t)
  -> ?enable:Enable.t
  -> ?clear:Clear.t
  -> unit
  -> sample list

(** [samples] restricted to cycles with [tvalid] = 1, in cycle order — the
    frame's delivered stream with idle cycles dropped. Obligation 6: this is
    the only sanctioned way to read [out] across a run, because it never
    looks at a [tvalid] = 0 cycle's fields.

    {2 The count-blindness caveat (WO-0065 §6.1 debt 2)}

    At a lane-4 start the emitted word count equals the input word count W
    by identity, so a disagreement in the count this function's own
    [List.length] exposes is IMPOSSIBLE there, and a [tlast]-position check
    built on that count alone is blind with it. The instrument is present
    and blind at one lane, not missing — a row driven only at a lane-4 start
    needs its per-word cycle/tkeep checks to carry the weight this guard
    cannot, and no packet may cite "the count was right" as evidence about
    word integrity at that lane. First owed at the count guard's own call
    sites (`J-dv_lead-0094`; landed at those sites, `WO-0062` §6.1(i)); paid
    here, at the definition itself, because the rule belongs where the NEXT
    reader will meet the instrument, not only where the last incident was
    journalled (`J-dv_lead-0108`'s banked rule, applied a second time). *)
val delivered_samples : sample list -> sample list

(** The concatenation of every delivered sample's [Stream_word.octets], in
    order — the full delivered octet string for a run carrying exactly one
    frame. *)
val delivered_octets : sample list -> int list

(** The single delivered sample carrying [tlast] = 1, if any. [None] means no
    output word was ever produced (the zero-delivered §0.7 case) — distinct
    from "a frame is still in flight", which a test never observes because
    [run]'s [drain] always exceeds §6.1's 2-cycle window. *)
val tlast_sample : sample list -> sample option

(** Every (cycle, strobe name) pair that was high anywhere in the run, in
    cycle order — an error strobe is a DUT output, read from the [Before]
    view at the cycle whose input word produced it (RV-0038-R6 / R6-1: under
    [Before] that is the same cycle the strobe belongs to, so no relabelling
    is needed). *)
val error_pulses : sample list -> (int * string) list

(** Standing obligations 2 and 3 for the common case in this packet: one
    frame presented, one clean or [~aborted] frame emitted, nothing exempt.
    Calls [Conservation_monitor.frame_in], [.frame_out ~aborted], then feeds
    the standing {!Octet_time.Latency} tagger [frame.Arrival.octets]'s
    preamble-inclusive input octet times ([Arrival.in_times frame]) against
    the delivered samples' octet times ([Octet_time.of_words] over each
    sample's [cycle] — RV-0038-R6 / R6-1: the [Before] view already reads
    [cycle]'s own output, so this is the call site RV-0038-R5 once named as
    mattering most and it needs no relabelling any more; no
    [?expected_octets] override — see the module docstring for why every
    frame in this packet satisfies the clean-frame identity extent). A row
    driving more than one frame calls this once per frame. *)
val account_clean_frame : t -> Dv_xgmii.Arrival.frame -> sample list -> aborted:bool -> unit

(** WO-0064: the family's other three conservation-plus-latency accounting
    cases, consolidated here from fourteen file-local copies (`bench.ml`'s own
    comment above {!account_dropped_frame} names every source). The naming
    axis below is what a caller must get right, and is the one thing this
    consolidation exists to make impossible to miss (`RV-0062-VERDICT`
    FINDING B-1 and `RV-0057-VERDICT` Finding 1 are the two incidents that
    paid for it):

    - {!account_clean_frame} above and {!account_dropped_frame} below both
      take a genuine {!Dv_xgmii.Arrival.frame} — their input trace is
      [Arrival.in_times frame], built by the schedule itself.
    - {!account_forwarded_piece} and {!account_dropped_piece} below take no
      such record: the caller sizes the input trace by hand, from
      [~start_ot] and [~received], because the piece they account for is one
      {!Dv_xgmii.Injection} opens mid-array rather than laying out as its own
      declared frame case.
    - The axis is NOT "does a record exist", and reading it that way
      convicts a correct call site: a genuine {!Dv_xgmii.Arrival.frame} whose
      RECEIVED extent is shorter than its DECLARED array still takes the
      [_piece] entry points, because {!account_clean_frame} would size
      [Latency.frame_in]'s input trace from the declared array while the
      frame received less, with no [?expected_octets] override to correct
      it — {!account_forwarded_piece}'s own [~received]-not-[~delivered]
      precondition is what actually carries the weight, and this bullet is
      what routes a caller to it. The rule, in one sentence: read the axis
      as [_frame] where the declared array IS the received extent, [_piece]
      wherever it is not — whether or not a record exists
      (`J-dv_lead-0113` §8). The class is "every frame REQ-110 aborts", and
      it is not only REQ-110's: REQ-105's and REQ-108's early closures
      produce it too. Instance: `test/xgmii_rx_64/test_m03_n.ml`'s six
      sub-cases each build frame A's schedule array as
      [List.init (max 5 (sc.t_idx + 1))] — declared 11, 7 or 5 octets against
      a RECEIVED extent ([sc.a_delivered]) of 8, 4 or 0 — so frame A has a
      record in every sub-case and still takes
      {!account_forwarded_piece}/{!account_dropped_piece} throughout. *)

(** Standing obligations 2 and 3 for a frame that delivered ZERO octets and
    has a genuine {!Dv_xgmii.Arrival.frame} record of its own (M03-E2/E3's
    own rule: requirements.md §0.6/§0.7 account for such a frame through its
    STROBE, never through an emitted [frame_out]). Calls
    [Conservation_monitor.frame_in], [.discarded ~strobes:[ strobe ]],
    [Latency.frame_in] fed [Arrival.in_times frame] exactly as
    {!account_clean_frame} does, then [Latency.frame_dropped], which pops the
    pending input frame without a comparison — there is no delivered [tlast]
    word to compare it against, and none is ever claimed. *)
val account_dropped_frame : t -> Dv_xgmii.Arrival.frame -> strobe:string -> unit

(** Standing obligations 2 and 3 for a piece that delivers content but has no
    genuine {!Dv_xgmii.Arrival.frame} record of its own: [Injection] opens it
    mid-array rather than laying it out as its own declared frame case (the
    shape M03-G7's resynchronised runt and family H's splices both need), so
    [Latency.frame_in]'s usual [Arrival.in_times frame] source does not exist
    for it. [in_times] is instead built by hand from [~start_ot]: 8 preamble
    octet times, then [~received] content octet times.

    {2 [~received], not [~delivered] — the precondition this function and
    {!account_dropped_piece} share (`RV-0057-VERDICT` Finding 1, WO-0059 §7.3
    — the incident this precondition exists to close)}

    The input trace must be sized by what the piece RECEIVED while it was
    open (requirements.md §0.6's own window definition), not by what it
    DELIVERED at the output. For an aborted (REQ-110/REQ-105-governed) piece
    the two coincide, because no FCS removal is attempted (REQ-103's
    no-removal clause); but for an ordinary, cleanly-closed piece, received is
    delivered PLUS the four FCS octets REQ-103 strips. Building the trace
    from [delivered] alone is four octet times short of the true received
    extent, and sits exactly on [frame_out]'s own stated bound — per
    `octet_time.mli`, output octet j is still input octet j + strip_octets —
    so the shortfall is harmless only by cancellation: [frame_out]'s own
    per-octet walk reads [in_times.(j + strip_octets)] for j in
    [0, delivered - 1], an index range whose values [Array.init] never lets
    depend on the array's own length. [received] is therefore the honest size
    for [in_times]; [delivered] stays the separate [~expected_octets]
    override below, unchanged.

    Calls [Conservation_monitor.frame_in], [.frame_out ~aborted], [Latency.
    frame_in] fed the hand-built [in_times], then [Latency.frame_out
    ~expected_octets:delivered] against [samples]'s own delivered octet
    times. *)
val account_forwarded_piece
  :  t
  -> start_ot:int
  -> received:int
  -> delivered:int
  -> aborted:bool
  -> sample list
  -> unit

(** The zero-delivered counterpart of {!account_forwarded_piece}, for a piece
    that delivers no content at all: accounted through its STROBE alone,
    never through an emitted [frame_out] — [Conservation_monitor.frame_in],
    then [.discarded ~strobes:[ strobe ]], [Latency.frame_in] fed the same
    kind of hand-built [in_times] {!account_forwarded_piece} builds, then
    [Latency.frame_dropped], which pops the pending input frame without a
    comparison. The [~received]-not-[~delivered] precondition documented at
    {!account_forwarded_piece} governs this function identically: for a
    zero-delivered piece, [received] is simply the octet count observed
    before the closing character — never a delivered count, which does not
    exist here.

    And here that precondition is unenforced by construction, which is the
    reason to state it rather than rely on it being caught:
    [Latency.frame_dropped] only pops the pending queue and does not inspect
    the array it was handed (confirmed against `test/monitors/octet_time.ml`'s
    own implementation), so an [in_times] this function sized from a
    delivered count would go unpunished here and the error would surface only
    when the same habit reached {!account_forwarded_piece}, where the array
    IS read. An honestly-derived array costs nothing beyond honesty itself. *)
val account_dropped_piece : t -> start_ot:int -> received:int -> strobe:string -> unit

(** Standing obligations 2 and 3 for a frame the module ACCEPTED and then
    ABANDONED under REQ-009's synchronous clear: presented, partially emitted
    or not emitted at all, with no output [tlast] and — REQ-009's own
    explicit licence, the one place in SPEC-M03 where a frame vanishes
    without a report — no strobe (WO-0072 §8.3).

    Conservation: [frame_in_exempt ~reason:"clear (REQ-009)"], NEVER
    [frame_in] and never [discarded]. The §0.6 equation has no term for such
    a frame: counting it as presented reports the silent-discard hole
    REQ-009 disclaims, and attributing it to a strobe requires a strobe that
    specification forbids ({!Dv_monitors.Conservation_monitor}'s own
    deviation 3, WO-0072 §10.1).

    Latency: [frame_in] fed [Arrival.in_times frame], then — on [delivered] —
    either [frame_out ~expected_octets:delivered] against [samples]'s own
    delivered octet times, or, at [delivered = 0], [frame_dropped], which
    pops the pending input frame without a comparison because there is no
    output frame to compare.

    [samples] must be THIS frame's own delivered words and no others, and
    [delivered] must be a value the caller has already ASSERTED rather than
    observed — the branch above is selected by that number, so a number
    taken from the run it is meant to judge would let a wrong observation
    choose its own accounting. [delivered < 0] raises. *)
val account_cleared_frame
  :  t
  -> Dv_xgmii.Arrival.frame
  -> delivered:int
  -> sample list
  -> unit

(** [split_at_first_tlast samples] returns the prefix of [samples] through and
    including the first sample whose [tlast] is 1, paired with the
    remainder — extensionally, and only extensionally: whether the first
    element of the pair equals one frame's own words and the second the next
    frame's depends on the precondition below, which this function does not
    check. [samples] should already be [tvalid]-filtered (obligation 6; every
    landed call site passes it {!delivered_samples}'s own output).

    {2 The two-group reading's precondition}

    Reading the first element of the returned pair as one frame's words and
    the second as the next frame's is correct only if the FIRST frame
    delivers at least one word. Where a frame may deliver none (requirements.
    md §0.7: an abort at or before its own first octet), this function still
    returns a well-formed pair — but the first group it returns is the NEXT
    frame's own words, and the second group is empty, because there is no
    earlier [tlast] to stop at. A guard written to prove the silent first
    frame's absence by inspecting this function's own first group therefore
    convicts the frame that is actually present.

    The reading also fails where the first frame delivers words and never
    closes: [clear] asserted mid-frame (REQ-009) truncates with no [tlast],
    so the first group returned is the two frames' words concatenated and the
    second is empty, and both groups being non-empty is not the guard a
    caller needs. Where a frame may deliver without closing, partition by an
    asserted cycle set, not by [tlast] (WO-0072 §10.2).

    {2 The incident (FINDING B-1, `RV-0062-VERDICT` §2)}

    Two rows built directly on the two-group reading without checking this
    precondition went red against a conforming design at commit `88da20e`
    (CI `build` run 30937558341), each with a message accusing the design of
    violating §0.7 — the design was innocent; the two-group reading's own
    precondition was silently false for that run's first frame.

    {2 What a caller must do}

    Either establish that both groups this function returns are non-empty
    before reading them as two frames' own words — every landed two-group
    call site in this suite does so with its own [List.is_empty] guard on
    each group — or do not use the two-group reading at all when the first
    frame may deliver nothing, which is what the repaired M03-B2/M03-B3 call
    sites do instead (repair R-1, `RV-0062-VERDICT`). *)
val split_at_first_tlast : sample list -> sample list * sample list

(** [frames_at ~lane ~fcs_valid ?ifg octets_lists] — {!Dv_xgmii.Arrival.create}
    at the §0.3 lane mapping (lane 0 -> [first_start:8], lane 4 ->
    [first_start:12]), passing [octets_lists] straight through as the frame
    list, [fcs_valid] straight through as [Arrival.create]'s [?fcs_valid],
    and [?ifg] straight through as [Arrival.create]'s own [?ifg] (defaulting
    to [Arrival]'s own default, §0.3's minimum 12 octets, when omitted).
    WO-0040 §3.3: the one bench addition that packet authorises, added so
    M03-D3's two-frame, mixed-FCS schedule needs no new scheduling primitive.
    {!one_frame} is re-expressed through this function so the lane mapping
    has exactly one home.

    [?ifg] added by WO-0059 §8.1: M03-I3 needs the same lane mapping with a
    non-default inter-frame gap (824 octets, so that a 100-cycle ordered set
    fits strictly inside the gap between two frames), and [frames_at] is
    where that mapping already lives — its own docstring says so. Every
    existing caller is unaffected: the parameter is optional and every call
    site before this one omits it, so [Arrival.create]'s own default (12
    octets) governs exactly as before. *)
val frames_at
  :  lane:int
  -> fcs_valid:bool
  -> ?ifg:int
  -> int list list
  -> Dv_xgmii.Arrival.t

(** A single-frame link-partner schedule: [octets] (DA through FCS) preceded
    by the standard preamble, at start lane 0 ([first_start:8]) or lane 4
    ([first_start:12]), with a correct FCS assumed ([fcs_valid:true] — every
    row before WO-0040 only ever scheduled good-FCS frames). Thin wrapper
    over {!frames_at} (WO-0040 §3.3: [one_frame ~lane octets] is now exactly
    [frames_at ~lane ~fcs_valid:true [ octets ]]) fixing the one-frame,
    one-schedule shape every row but M03-C1/M03-C2/M03-A3 (which each build
    several) needs directly. *)
val one_frame : lane:int -> int list -> Dv_xgmii.Arrival.t

(** The directed length set M03-C1 and M03-A3 share: one entry per length in
    64 .. 71 octets DA through FCS. Ordered ascending by length, i.e. by
    terminate lane 0 .. 7 (length mod 8). *)
val directed_lengths : int list

(** [length] - 4 octets of deterministic, length-dependent (never all-zero,
    never equal across two lengths) DA-through-payload content, with the
    correct FCS appended by [Dv_xgmii.Frame.with_fcs]. Not
    [Frame.stress_frame]: that builder is fixed at 64 octets DA through FCS
    (SPEC-M03 §8's own stimulus frame) and has no length parameter, so the
    directed set builds its own content rather than truncating or padding
    stress_frame's. *)
val directed_frame_octets : length:int -> int list

(** [run_directed_lengths ~lane] drives every length of {!directed_lengths}
    as its own one-frame schedule at [lane], each on a fresh {!t}
    (independent instances — nothing here tests back-to-back framing, which
    is family L's job), with [drain:8]. Returned in ascending-length order,
    as (length, schedule, bench, samples) — the schedule is kept so a caller
    can recover its own start cycle via [Arrival.start_cycle] /
    [Arrival.frames] without re-building it, [bench] for a caller's own
    monitor-clean assertions. Shared by M03-A3/A4 (the two-lane tuple
    comparison, and A4's per-lane-only ΔC check) and M03-C1/C2 (the eight
    tkeep-pattern and terminate-lane coverage), so all four derive from
    exactly the same stimulus. *)
val run_directed_lengths : lane:int -> (int * Dv_xgmii.Arrival.t * t * sample list) list

(** Fails with [failwith] naming [row] and the mismatch when the standing
    {!Protocol_monitor}, {!Conservation_monitor} or {!Strobe_monitor}
    attached to [t] is not clean. Every row calls this; it checks nothing
    about frame content (delivered octets, tkeep, tlast, tuser), which stays
    each row's own assertion because the expected values differ row by row.

    The {!Octet_time.Latency} tagger is checked in two parts (RV-0038-R5 /
    R5-3): its [errors] are always meaningful and fail this call the moment
    any exist, but its [is_constant]/[is_clean] verdict is only demanded once
    [frames_compared] is positive — a tagger nobody has fed a frame correctly
    declines to claim constancy over zero comparisons, and a frameless run
    (the scaffolding smoke test; family I's idle-only rows later) must not be
    asked to prove a claim it was never given the means to make.
    [Dv_monitors] is unchanged by this rule; the rule is in how this bench
    reads it. *)
val assert_monitors_clean : t -> row:string -> unit
