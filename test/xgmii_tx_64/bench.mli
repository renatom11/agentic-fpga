(** WO-0080 scaffolding: one elaborated {!Hardcaml_ethernet.Xgmii_tx_64}
    instance, wired to the standing obligations AP-xgmii_tx_64.md §2 attaches
    to every M04 bench, plus the reactive drive/sample loop every row in this
    round shares.

    {2 Independence, stated because this is the file that touches the DUT}

    {!create} names three things from SPEC-M04 alone (WO-0080 §7): the
    library [Hardcaml_ethernet], the module [Xgmii_tx_64], and the entry
    point [create : Scope.t -> Signal.t I.t -> Signal.t O.t]. Every port
    after that is reached by projecting a field off the live
    [Cyclesim.inputs] / [Cyclesim.outputs] record ([i.tx.tvalid],
    [o.xgmii_tx.d], …) rather than by naming the concrete module that
    defines [Axi64.Source.t] or [Xgmii.t] — OCaml's type-directed field
    disambiguation resolves those projections against whatever type
    [Xgmii_tx_64.I.t] and [.O.t] actually declare, so this file takes no
    position on whether that module's records are [Ifc_check.Axi64_ifc]'s or
    structurally identical ones of [hardcaml_ethernet]'s own.
    [libs/hardcaml_ethernet/src/xgmii_tx_64.ml] and [rtl_snapshots/**] were
    not opened to write this file (PROTOCOL §10, WO-0080 §8). If the
    implementation's ports diverge from the lift at
    [docs/specs/ifc_check/xgmii_tx_64_ifc.ml], this file fails to compile —
    that failure is REQ-010's type-identity check doing its job, and it is a
    finding for dv_lead, never a bench repair (WO-0080 §7).

    {2 The one structural fact that makes this bench's shape unlike
    [test/xgmii_rx_64]'s (WO-0080 §0)}

    At M03 the stimulus is a wire with no handshake: a schedule is
    precomputed before a single cycle is driven. At M04 the stimulus is a
    handshaken source stream — whether a word is accepted on a cycle depends
    on [tx_tready], a DUT OUTPUT — so there is no precomputable schedule and
    no [Arrival] equivalent. The presenter here is REACTIVE: it offers a
    word, observes the handshake, and advances only on acceptance ({!present},
    internal, driven by {!run_lengths}). Four consequences bind every row
    built on this file (WO-0080 §0):

    + [C] — the cycle the frame's first source word is accepted — is
      OBSERVED, never assumed. {!first_accepted_cycle} is the ONE definition
      of it: the first cycle at which a returned {!sample}'s own [accepted]
      field is [true]. Every expected value a row derives is stated relative
      to it, and no row may assert an absolute cycle measured from cycle 0 or
      from the release of [clear] (SPEC-M04 §6.3 item 4; M04-A5 forbids it).
    + The read of [tx_tready] that decides acceptance MUST come from the same
      cycle's [Before] view, taken after [Cyclesim.cycle] — see {!sample_cycle}
      below. An [After] read shifts [C] by one cycle and every constant a row
      derives from it becomes silently wrong (trap T1, BOUNCE BM2).
    + The presenter never withholds a word mid-frame: SPEC-M04 §7's handshake
      bullet says REQ-016's idle tolerance "does not apply to this
      interface", and a missing word on a required cycle is REQ-206's
      underflow, not a gap. This round drives no stall and no idle injection
      at the source (family G is excluded, WO-0080 §1.2, §9.4, BOUNCE BM6).
    + After the frame's [tlast] word is accepted, the presenter offers
      nothing — legally: SPEC-M04 §7's C-16 bullet says this is the one cycle
      in a frame's life where [tx_tready] = 1 with [tx_tvalid] = 0 means
      nothing at all. It is not an underflow and the strobe must stay 0,
      which {!assert_instruments_clean} asserts.

    {2 What [create] wires and what a row wires itself}

    {!create} elaborates the DUT, releases [clear] after exactly one cycle
    (driving [cfg_tx_enable] = 1 and [cfg_ifg] = 12 THROUGH that cycle,
    SPEC-M04 §7.1), and attaches obligation 1's wire decoder
    ({!Dv_xgmii.Tx_decoder}, [~ifg:12]) and obligation 4's strobe monitor
    ({!Dv_monitors.Strobe_monitor}, naming M04's one strobe,
    ["error_underflow"]). {!sample_cycle} feeds both of them on every cycle,
    including idle ones (C-23's counting convention). No [Clear] or [Enable]
    schedule type is built here (WO-0080 §7.1, §1.2, BOUNCE BM5): [clear] is
    1 on cycle 0 alone and 0 for the rest of every run in this round;
    [cfg_tx_enable] is 1 and [cfg_ifg] is 12 throughout — both capabilities
    land with their first consumer (families K and L), not here.

    Obligation 3 (transmit-side frame conservation) has no committed monitor
    for this port (AP-xgmii_tx_64.md §7 item T-2: the committed
    {!Dv_monitors.Conservation_monitor} takes a frame STREAM as its subject,
    and M04's output is a lane pair). {!assert_instruments_clean} carries the
    counting rule itself instead, KEYED ON THE FIRST ACCEPTED WORD rather
    than on [tlast] — an underflowed frame's [tlast] word is never accepted
    (SPEC-M04 §9's condition ends at that acceptance), so a rule keyed on
    [tlast] would silently exempt the one class of frame this module can
    lose. Every run in this round begins and cleanly completes exactly one
    frame (WO-0080 §1.2's scope rule), so the instance {!assert_instruments_clean}
    checks is trivial here; family G's round inherits the same keying.

    {2 Why [Before], not the default [After] (WO-0080 §5.2, trap T1)}

    [Cyclesim.cycle] runs check -> comb -> seq -> comb, and [Cyclesim.outputs]
    can read either side of the seq step. The default, [~clock_edge:After],
    returns [f(regs(cycle + 1), word(cycle))]; [~clock_edge:Before] returns
    [f(regs(cycle), word(cycle))] — the design's actual hardware value DURING
    [cycle], for a registered output and a combinational one alike. At M03
    this was a labelling question (RV-0038-R6); at M04 it is worse: [tx_tready]
    under [Before] is read to DECIDE ACCEPTANCE, so an [After] read shifts
    [C] by one cycle and silently corrupts every constant a row derives from
    it against a conformant design, at every length. {!sample_cycle} therefore
    takes [~clock_edge:Side.Before] once, before [Cyclesim.cycle], and reads
    every output field — [tx_dest.tready], [xgmii_tx.d], [xgmii_tx.c],
    [error_underflow] — from that same view afterward. There is no second,
    [After] view kept in this round's {!sample} (unlike
    [test/xgmii_rx_64/bench.ml]'s diagnostic [after_out]): no row here reads
    one, and family H, which asserts values of [tx_tready], is the first
    consumer for which a second view would matter at all. *)

open! Base

type t

(** Elaborate {!Hardcaml_ethernet.Xgmii_tx_64}, release [clear] after one
    cycle, and attach the standing wire decoder (obligation 1) and strobe
    monitor (obligation 4). See the module docstring above for the full
    reset-drive and monitor-attachment contract. *)
val create : unit -> t

val decoder : t -> Dv_xgmii.Tx_decoder.t
val strobes : t -> Dv_monitors.Strobe_monitor.t

(** One driven-and-sampled cycle. [offered] is the word this call actually
    drove, read back from what {!sample_cycle} resolved — never from a
    caller's memory of the presenter's own schedule (M03-I2 member (iii)'s
    discipline, applied here). [wire] and [underflow] are the
    [Before]-view sample of [xgmii_tx] and [error_underflow] respectively.
    [accepted] is [offered.tvalid && (the Before-view tx_tready)] — the
    acceptance decision this whole round's arithmetic is stated against. *)
type sample =
  { cycle : int
  ; offered : Dv_monitors.Stream_word.t
  ; accepted : bool
  ; wire : Dv_xgmii.Xgmii_word.t
  ; underflow : bool
  }

(** Drive one cycle: the choke-point ordering guard, then the eight steps of
    WO-0080 §5.2 in order — take the [Before] output view, drive the six
    source refs plus [clear]/[cfg_ifg]/[cfg_tx_enable] at the SAME choke
    point (never a second site — WO-0067 §1.1(R-e)'s rule, carried to this
    port), cycle the clock, read the [Before] view, decide acceptance, feed
    the standing decoder and strobe monitor, and return the sample. [clear]
    is always driven 0 here — the one reset cycle is {!create}'s own, outside
    this function's own numbering (WO-0080 §7.1; the choke-point guard below
    [failwith]s if a caller's own cycle numbering disagrees with how many
    cycles have actually been driven). *)
val sample_cycle : t -> cycle:int -> Dv_monitors.Stream_word.t -> sample

(** The poison value used for every [tkeep]-0 [tdata] position this round
    drives (obligation 7, M04-C4's own value). Defined exactly once, here;
    every scan for its absence elsewhere in this packet refers to this value
    rather than restating [0xA5] (bar M-14). *)
val poison : int

(** [content_octets ~p] — the round's ONE content builder (WO-0080 §6.0(b)):
    octet [j] is [1 + (j mod 127)], for [j] in [0 .. p - 1]. Range
    [0x01 .. 0x7F] (never [0x00], which is what keeps a padding claim honest)
    and never [0xA5] (165 > 127, which is what keeps a poison scan
    non-vacuous), position-dependent with period 127 (coprime with 8, so a
    lane reversal, a byte swap or a rotation by 4 all change the string). *)
val content_octets : p:int -> int list

(** [source_words octets] cuts [octets] into 8-octet source words: [tkeep] =
    0xFF on every word but the last, 1 to 8 contiguous ones on the last;
    [tlast] on the last word only; [tkeep]-0 [tdata] positions on the last
    word driven with {!poison}, never with zero (obligation 7 — SPEC-M01
    §6.3 item 5 leaves those positions unconstrained, and REQ-203's own pad
    octets ARE zero, so a zero-filled don't-care position would be
    indistinguishable from correct padding at exactly the place M04-C4
    exists to catch); [tstrb] = 0 and [tuser] = 0 uniformly on every word
    (§5.5's own rule — family M's differential runs are the ones that vary
    them, and this round does not half-perform that stimulus). Built with
    {!Dv_monitors.Stream_word.raw} for the poisoned word (T6: [of_octets]
    zero-fills rather than poisoning) and {!Dv_monitors.Stream_word.of_octets}
    for every full word. *)
val source_words : int list -> Dv_monitors.Stream_word.t list

(** [run_frames contents] — the general runner (WO-0081 §5.3): each element of
    [contents] is one frame's DA-through-payload octet string. Checks the
    result against obligation 6's source contract ([failwith]ing, naming
    every violation, BEFORE a single cycle is driven), elaborates a FRESH
    {!t} per frame (independent instances, exactly as {!run_lengths}), and
    drives it for [27 + (max (List.length content) 60 + 4) / 8] cycles
    through the reactive presenter of the module docstring's second section
    — the SAME liveness bound and [P-ACCEPT] precondition {!run_lengths}
    enforces, because both runners share this one presenter rather than
    each carrying its own copy of the guards. Returned in the order
    [contents] was given, each entry carrying THE CONTENT STRING IT DROVE
    (never a caller's memory of it — the M03-I2 member (iii) discipline
    {!sample}'s own [offered] field already applies per cycle, applied here
    per frame) so a row can compare against what was actually presented.

    {!run_lengths} is a thin wrapper over this function:
    [run_lengths ps = run_frames (List.map ps ~f:(fun p -> content_octets
    ~p)) |> List.map ~f:(fun (content, t, samples) -> (List.length content,
    t, samples))] — the run-length formula lives in exactly one expression,
    shared by both callers rather than duplicated (WO-0081 §5.3, bar
    M-8). *)
val run_frames : int list list -> (int list * t * sample list) list

(** [run_lengths ps] — the one shared runner (WO-0080 §5.7, on [WO-0038]'s
    own [run_directed_lengths] precedent): for each [p] in [ps], builds
    [content_octets ~p] and {!source_words} of it, checks the result against
    obligation 6's source contract ([failwith]ing, naming every violation,
    BEFORE a single cycle is driven — a stimulus generator nobody has
    checked is an unverified assertion about the design), elaborates a FRESH
    {!t} (independent instances — nothing here tests back-to-back framing,
    which is family F's job), and drives it for
    [27 + (max p 60 + 4) / 8] cycles (WO-0080 §6.0(a)) through the reactive
    presenter of the module docstring's second section. Returned in the
    order [ps] was given.

    The presenter itself enforces, before returning: the liveness bound (if
    no word is accepted by cycle 16, [failwith], naming the fact and stating
    explicitly that this is a BENCH-LIVENESS bound and not a timing
    assertion about [C] — WO-0080 §5.6, M04-A5's own prohibition) and
    [P-ACCEPT] (the accepted cycles are exactly [C, C+1, .., C+W-1],
    contiguous — WO-0080 §5.6's precondition of every row's own arithmetic;
    its failure is disposition class D3, routed to dv_lead, and is NOT a
    bounce, but every row assertion downstream of a [P-ACCEPT] failure is
    meaningless and the [failwith] says so). *)
val run_lengths : int list -> (int * t * sample list) list

(** WO-0080 §5.6's [C]: the first cycle at which a sample in [samples] has
    [accepted = true]. The ONE definition every row uses — never re-derived
    by scanning [samples] again at a call site, so a row cannot silently
    drift onto a different (wire-observed, say) notion of [C] than the
    handshake-observed one this round's whole arithmetic is stated against.
    [failwith]s if no sample is accepted, which {!run_lengths}'s own liveness
    bound should already have caught upstream. *)
val first_accepted_cycle : sample list -> int

(** [wire_frame samples] decodes [samples]' own [wire] words through a FRESH
    {!Dv_xgmii.Tx_decoder} instance (WO-0080 §5.7's own signature: a reader
    over a sample list, independent of any [t]'s standing decoder) and
    returns the one completed frame. [failwith]s naming the reason if the
    decoded frame count is not exactly one — no completed frame (trap T9:
    the run was too short, or the design never terminated) or more than one
    (this round drives exactly one frame per run, WO-0080 §1.2). This is a
    CONTENT READER, not the obligation-1 instrument: {!assert_instruments_clean}
    below is what asserts the standing decoder [t] itself carries is clean;
    this function exists so a row can read the decoded octet string, its
    start/terminate cycle and its terminate lane without threading [t]
    through every content assertion. *)
val wire_frame : sample list -> Dv_xgmii.Tx_decoder.frame

(** [(wire_frame samples).octets] — the decoded frame's octets, DA through
    FCS, in wire order. *)
val wire_octets : sample list -> int list

(** Fails with [failwith] naming [row] and the mismatch when: the standing
    wire decoder is not clean (obligation 1); the standing strobe monitor is
    not clean, OR [high_cycles "error_underflow"] is not 0 (obligation 4 —
    this round expects zero events, so both halves of the instrument are
    exercised here rather than only the exact-set half); or the standing
    decoder's own frame count is not exactly one clean (non-underflowed)
    frame (obligation 3, carried by the bench per the module docstring's
    conservation paragraph — T-2, no committed monitor exists for this
    port). Every row-bearing unit (U2 through U10) calls this once per
    elaboration; the scaffolding smoke unit (U1) does not — it drives no
    frame at all and asserts the seam directly instead (WO-0080 §6.11). This
    checks nothing about frame CONTENT (octet values, pad, FCS), which stays
    each row's own assertion. *)
val assert_instruments_clean : t -> row:string -> unit
