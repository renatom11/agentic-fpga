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
    discarded (none, in this packet's clean-frame slice — no row here drives
    family J's disabled-enable frames or family K's [clear]-truncated ones),
    so {!account_clean_frame} is what a row calls instead, per the charter's
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
    cycle and hold [cfg_rx_enable] at 1 for the rest of the run — family J
    (the disable path) is out of this packet's eleven rows (WO-0038 §1) — and
    attach the three standing monitors described above. *)
val create : unit -> t

val protocol : t -> Dv_monitors.Protocol_monitor.t
val conservation : t -> Dv_monitors.Conservation_monitor.t
val strobes : t -> Dv_monitors.Strobe_monitor.t
val latency : t -> Dv_monitors.Octet_time.Latency.t

(** The five REQ-008 strobe names SPEC-M03 §9 / requirements.md §12 give M03,
    in the [O] record's field order. What {!create}'s {!Strobe_monitor} is
    built with. *)
val strobe_names : string list

(** One driven-and-sampled cycle: the XGMII word presented to [xgmii_rx] on
    [cycle], and the [rx] word the standing {!Axi64_probe} sampled from
    [cycle]'s own outputs, plus the names of every error strobe high that
    same cycle (a subset of {!strobe_names}, read directly off the DUT's
    error outputs — never inferred). [after_out] is a second, diagnostic-only
    reading of that same cycle, described below.

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
    {!Strobe_monitor} via [sample ~cycle ~high:errors_high] — [cycle] is the
    sample's only cycle label (RV-0038-R6 / R6-1: the [Before] view read into
    {!sample}'s [out] already belongs to this same cycle, so there is no
    second, later cycle for a monitor call to name). C-23's counting
    convention requires every cycle, including ones where nothing is high,
    so [run] is the only place that call is allowed to happen.

    [?word_at] overrides the word driven on a single cycle (identity is
    [Arrival.word_at sched]): M03-B1 uses it to substitute a non-standard
    preamble/SFD data pattern into the schedule's own start word while
    leaving [Arrival]'s control-character placement, frame content and FCS
    untouched — [Arrival]'s own contract fixes the preamble at 0x55/0xD5 and
    exposes no parameter to vary it (test/xgmii/arrival.mli, "What the model
    does not decide"), so overriding the word after [Arrival] builds the
    schedule is the only way to drive that stimulus without hand-deriving
    the rest of the cycle table. *)
val run
  :  t
  -> Dv_xgmii.Arrival.t
  -> drain:int
  -> ?word_at:(cycle:int -> Dv_xgmii.Xgmii_word.t)
  -> unit
  -> sample list

(** [samples] restricted to cycles with [tvalid] = 1, in cycle order — the
    frame's delivered stream with idle cycles dropped. Obligation 6: this is
    the only sanctioned way to read [out] across a run, because it never
    looks at a [tvalid] = 0 cycle's fields. *)
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

(** [frames_at ~lane ~fcs_valid octets_lists] — {!Dv_xgmii.Arrival.create} at
    the §0.3 lane mapping (lane 0 -> [first_start:8], lane 4 ->
    [first_start:12]), passing [octets_lists] straight through as the frame
    list and [fcs_valid] straight through as [Arrival.create]'s
    [?fcs_valid] ([ifg] is left at [Arrival.create]'s own default, §0.3's
    minimum 12 octets). WO-0040 §3.3: the one bench addition that packet
    authorises, added so M03-D3's two-frame, mixed-FCS schedule needs no new
    scheduling primitive. {!one_frame} is re-expressed through this
    function so the lane mapping has exactly one home. *)
val frames_at : lane:int -> fcs_valid:bool -> int list list -> Dv_xgmii.Arrival.t

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
