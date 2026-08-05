open! Base
open Hardcaml
module Xgmii_word = Dv_xgmii.Xgmii_word
module Arrival = Dv_xgmii.Arrival
module Frame = Dv_xgmii.Frame
module Stream_word = Dv_monitors.Stream_word
module Protocol_monitor = Dv_monitors.Protocol_monitor
module Conservation_monitor = Dv_monitors.Conservation_monitor
module Strobe_monitor = Dv_monitors.Strobe_monitor
module Octet_time = Dv_monitors.Octet_time
module Xgmii_probe = Dv_xgmii_probe.Xgmii_probe
module Axi64_probe = Dv_axi64_probe.Axi64_probe

module Sim =
  Cyclesim.With_interface (Hardcaml_ethernet.Xgmii_rx_64.I) (Hardcaml_ethernet.Xgmii_rx_64.O)

(* SPEC-M03 §9 / requirements.md §12, O's field order. *)
let strobe_names =
  [ "error_bad_fcs"
  ; "error_bad_frame"
  ; "error_runt"
  ; "error_oversize"
  ; "error_start_without_terminate"
  ]
;;

type t =
  { sim : Sim.t
  ; protocol : Protocol_monitor.t
  ; conservation : Conservation_monitor.t
  ; strobes : Strobe_monitor.t
  ; latency : Octet_time.Latency.t
  ; mutable cycles_driven : int
        (* RV-0038-R5 / R5-1 (carried from RV-0038-R4-VERDICT): the choke-point
           ordering guard. [sample_cycle] is the one function that touches the
           design, so this is the one place a reversed or skipped drive can be
           caught — unlike R4-2's guard, which only checked the order [run]
           RETURNED its samples in and did not fire on run 30771064764's actual
           reversed drive (Base's [List.init] returns ascending however it
           evaluates [~f]). Starts at 0 in {!create}; incremented on every
           conforming call. *)
  }

let protocol t = t.protocol
let conservation t = t.conservation
let strobes t = t.strobes
let latency t = t.latency

let create () =
  let scope = Scope.create ~flatten_design:true () in
  let sim = Sim.create (Hardcaml_ethernet.Xgmii_rx_64.create scope) in
  let i = Cyclesim.inputs sim in
  (* REQ-009: clear for one cycle, then release. cfg_rx_enable driven at 1
     through this reset cycle only — WO-0067 §1.4: that cycle is outside
     every {!Enable.t} schedule, [run]'s own [?enable] argument governs from
     cycle 0.
     N2 (RV-0038 addendum): drive an idle XGMII word through the reset cycle
     rather than leaving xgmii_rx at Cyclesim's zero default, which is eight
     *data* octets of 0x00 — not idle, and not something REQ-018's link
     partner ever emits. Harmless under clear (no /S/, so no frame opens),
     but standing obligation 5 (Arrival.check) never reaches this cycle
     because it is outside every schedule, so it is worth driving correctly
     rather than relying on clear to paper over it. *)
  Xgmii_probe.to_refs ~d:i.xgmii_rx.d ~c:i.xgmii_rx.c Xgmii_word.idle;
  i.clear := Bits.vdd;
  i.cfg_rx_enable := Bits.vdd;
  Cyclesim.cycle sim;
  i.clear := Bits.gnd;
  { sim
  ; protocol = Protocol_monitor.create ~name:"M03 rx" ~max_words_per_frame:190 ()
  ; conservation = Conservation_monitor.create ~name:"M03 rx"
  ; strobes = Strobe_monitor.create ~name:"M03 rx" ~strobes:strobe_names
  ; latency =
      Octet_time.Latency.create
        ~name:"M03 rx"
        ~strip_octets:8
        ~tail_octets:4
        ~front_offsets:[ 8; 12 ]
        ~ceiling:4
        ()
  ; cycles_driven = 0
  }
;;

(* WO-0067 §1.2: the [cfg_rx_enable] schedule. Kept as [initial] plus an
   ascending, non-redundant [changes] list rather than a closure, so it has a
   [report] and so [change_cycles] is a plain field read rather than a
   re-derivation (§1.3(d) is the shape this rejects). *)
module Enable = struct
  type t =
    { initial : bool
    ; changes : (int * bool) list
    }

  let high = { initial = true; changes = [] }
  let low = { initial = false; changes = [] }

  let changes ~initial cs =
    let fail msg = failwith (String.concat [ "Bench.Enable.changes: "; msg ]) in
    let rec check prev_cycle prev_value = function
      | [] -> ()
      | (cycle, value) :: rest ->
        if cycle <= 0
        then fail (String.concat [ "cycle "; Int.to_string cycle; " is not positive" ]);
        (match prev_cycle with
         | Some pc when cycle <= pc ->
           fail
             (String.concat
                [ "cycle "
                ; Int.to_string cycle
                ; " does not strictly ascend past "
                ; Int.to_string pc
                ])
         | _ -> ());
        if Bool.equal value prev_value
        then
          fail
            (String.concat
               [ "cycle "
               ; Int.to_string cycle
               ; " changes to "
               ; Bool.to_string value
               ; ", which is already the value in force"
               ]);
        check (Some cycle) value rest
    in
    check None initial cs;
    { initial; changes = cs }
  ;;

  (* [changes] is ascending by construction, so the last entry at or before
     [cycle] is the value in force; folding left to right and always
     preferring a later admissible entry finds exactly that. *)
  let value_at t ~cycle =
    List.fold t.changes ~init:t.initial ~f:(fun acc (c, v) -> if c <= cycle then v else acc)
  ;;

  let change_cycles t = if t.initial then t.changes else (0, false) :: t.changes

  let report t =
    String.concat
      ~sep:"\n"
      (String.concat [ "initial "; Bool.to_string t.initial ]
       :: List.map t.changes ~f:(fun (c, v) ->
            String.concat [ "cycle "; Int.to_string c; " -> "; Bool.to_string v ]))
  ;;
end

(* WO-0072 §1.2: the [clear] schedule (REQ-009). A window, not a set of
   changes reached by transplanting {!Enable}'s shape -- see bench.mli's own
   [Clear] docstring and WO-0072 §2 for why the transplant breaks twice at
   this port. [t] is kept as a plain [first]/[last] pair rather than a
   variant: [last < first] encodes {!never} (an empty window), so [value_at]
   and [high_cycles] need no separate case for it and {!is_ever_high} is a
   true projection of {!high_cycles} rather than a second predicate on the
   same two fields (WO-0068 §7.3's rule, reused at §2). *)
module Clear = struct
  type t =
    { first : int
    ; last : int
    }

  let never = { first = 0; last = -1 }

  let window ~first ~last =
    if not (0 <= first && first <= last)
    then
      failwith
        (String.concat
           [ "Bench.Clear.window: first "
           ; Int.to_string first
           ; " must be >= 0 and <= last "
           ; Int.to_string last
           ]);
    { first; last }
  ;;

  let value_at t ~cycle = cycle >= t.first && cycle <= t.last

  let high_cycles t = if t.last < t.first then [] else List.range t.first (t.last + 1)

  (* WO-0072 §2(ii): the entry condition IS this projection, not a
     hand-written predicate ([t.last >= t.first]) that reconstructs it --
     the two happen to agree today, but only [high_cycles] is the guard's
     stated subject (bench.mli). *)
  let is_ever_high t = not (List.is_empty (high_cycles t))

  let report t =
    if t.last < t.first
    then "never"
    else
      String.concat
        [ "window first "; Int.to_string t.first; " last "; Int.to_string t.last ]
  ;;
end

type sample =
  { cycle : int (* schedule cycle whose input word was driven AND whose
                   [Before]-view outputs [out]/[errors_high] belong to —
                   RV-0038-R6 / R6-1, one label for both directions *)
  ; in_word : Xgmii_word.t
  ; enable : bool (* WO-0067: [cfg_rx_enable] as driven on [cycle] — the
                     choke-point reading of [run]'s own [?enable] argument,
                     resolved through {!Enable.value_at} for this cycle *)
  ; clear : bool (* WO-0072: [clear] as driven on [cycle] — the choke-point
                    reading of [run]'s own [?clear] argument, resolved
                    through {!Clear.value_at} for this cycle *)
  ; out : Stream_word.t
  ; after_out : Stream_word.t (* RV-0038-R6 / R6-3: the SAME cycle read from
                                  the default [After] view instead — round
                                  5's own reading, kept as a diagnostic only;
                                  nothing here asserts against it *)
  ; errors_high : string list
  }

(* Drives [in_word] onto xgmii_rx, steps one clock, samples rx and the five
   error strobes, and feeds the standing Protocol_monitor and Strobe_monitor
   (obligations 1 and 4). The Conservation_monitor is deliberately not fed
   here — see bench.mli.

   RV-0038-R5 / R5-1: the choke-point ordering guard. [sample_cycle] is the
   one function that touches the design — drives a register-backed input and
   advances [Cyclesim]'s clock — so it is the one place a stimulus out of
   order can be caught before anything downstream treats its result as a
   statement about M03. Fires on the FIRST out-of-order call, unlike R4-2's
   guard (bench.mli history, withdrawn), which checked the order [run]
   RETURNED its samples in rather than the order the design was actually
   driven in and would not have fired on run 30771064764's reversed drive. *)
let sample_cycle t ~cycle ~enable ~clear (in_word : Xgmii_word.t) : sample =
  if cycle <> t.cycles_driven
  then
    failwith
      (String.concat
         [ "Bench.sample_cycle: driving cycle "
         ; Int.to_string cycle
         ; " after "
         ; Int.to_string t.cycles_driven
         ; " cycles have been driven — the STIMULUS is out of order at the "
         ; "one point that touches the design, so nothing downstream of this "
         ; "is a statement about it"
         ]);
  t.cycles_driven <- t.cycles_driven + 1;
  let i = Cyclesim.inputs t.sim in
  (* RV-0038-R6 / R6-1: [~clock_edge:Side.Before] is [f(regs(cycle),
     word(cycle))] — the design's actual hardware value DURING this cycle,
     for a registered output and one combinational in the current word
     alike (bench.mli's [sample] docstring; BUG-0001/R-1 is why the default
     [After] view — [f(regs(cycle + 1), word(cycle))] — is wrong for M03's
     [rx] stream and its five error strobes, which are combinational in the
     current XGMII word per SPEC-M03 §6.1's one-word lookahead). [Before] is
     this bench's ASSERTED view from this round on. [o_after] is the SAME
     cycle read from the default (After) view instead — round 5's own
     reading — kept only to populate [after_out]'s diagnostic
     (RV-0038-R6 / R6-3); nothing below asserts against it. *)
  let o_before = Cyclesim.outputs ~clock_edge:Side.Before t.sim in
  let o_after = Cyclesim.outputs t.sim in
  Xgmii_probe.to_refs ~d:i.xgmii_rx.d ~c:i.xgmii_rx.c in_word;
  (* WO-0067 §1.1(R-e): [cfg_rx_enable] is driven at the same choke point as
     the XGMII word — the one function that touches the design — so there is
     exactly one place a stimulus port reaches the DUT from. *)
  i.cfg_rx_enable := if enable then Bits.vdd else Bits.gnd;
  (* WO-0072 §1.1(R-e) / §5 clause 4: [clear] reaches the design through the
     SAME choke point, one unconditional ref write per cycle matching
     [cfg_rx_enable]'s own — the default ({!Clear.never}) schedule always
     resolves this to [Bits.gnd], so the write's VALUE is the only thing
     WO-0072 changes about a [?clear]-omitted run, never its presence. *)
  i.clear := if clear then Bits.vdd else Bits.gnd;
  Cyclesim.cycle t.sim;
  let out =
    Axi64_probe.of_refs
      ~tvalid:o_before.rx.tvalid
      ~tdata:o_before.rx.tdata
      ~tkeep:o_before.rx.tkeep
      ~tstrb:o_before.rx.tstrb
      ~tlast:o_before.rx.tlast
      ~tuser:o_before.rx.tuser
      ()
  in
  let after_out =
    Axi64_probe.of_refs
      ~tvalid:o_after.rx.tvalid
      ~tdata:o_after.rx.tdata
      ~tkeep:o_after.rx.tkeep
      ~tstrb:o_after.rx.tstrb
      ~tlast:o_after.rx.tlast
      ~tuser:o_after.rx.tuser
      ()
  in
  let high (name, r) = if Bits.to_int !r <> 0 then Some name else None in
  let errors_high =
    List.filter_map
      [ "error_bad_fcs", o_before.error_bad_fcs
      ; "error_bad_frame", o_before.error_bad_frame
      ; "error_runt", o_before.error_runt
      ; "error_oversize", o_before.error_oversize
      ; "error_start_without_terminate", o_before.error_start_without_terminate
      ]
      ~f:high
  in
  Protocol_monitor.observe t.protocol ~cycle out;
  Strobe_monitor.sample t.strobes ~cycle ~high:errors_high;
  (* WO-0072 §4.2: [on_clear] goes LAST, after both [observe] and [sample] —
     compatibility (a {!Clear.never} run makes zero calls) and, the real
     reason, discrimination: [observe] zeroes [words_this_frame] on a
     [tlast] BEFORE [on_clear] can see it, so a phantom [tlast] on a clear
     cycle reds independently at [cleared_mid_frame] rather than being
     masked by [observe] having already counted it as a completed frame. *)
  if clear then Protocol_monitor.on_clear t.protocol ~cycle;
  { cycle; in_word; enable; clear; out; after_out; errors_high }
;;

let run t sched ~drain ?word_at ?enable ?clear () =
  (match Arrival.check sched with
   | [] -> ()
   | problems ->
     failwith
       (String.concat
          ~sep:"\n"
          ("Bench.run: Arrival.check found an unconformant schedule (standing obligation 5):"
           :: problems)));
  let word_at =
    match word_at with
    | Some f -> f
    | None -> fun ~cycle -> Arrival.word_at sched ~cycle
  in
  let enable = match enable with Some e -> e | None -> Enable.high in
  let clear = match clear with Some c -> c | None -> Clear.never in
  let total = Arrival.cycles sched + drain in
  (* WO-0067 §3, the M03-J4 guard. Entered ONLY when [Enable.change_cycles]
     is non-empty (compatibility bar §2 clause 4: [Enable.high] — [run]'s
     default — has none, so an [?enable]-omitted call enters no new branch
     and evaluates [word_at] exactly as many times as it did before this
     round). Walks every driven cycle and checks the DRIVEN WORD, never
     [Arrival.start_cycles]: M03-N4's injected start character reaches a row
     through [?word_at] and is absent from [Arrival] entirely, so a guard
     built on [Arrival] would report clean on the one stimulus it exists to
     catch (BOUNCE B4). SPEC-M03 §6.3 item 7 / carry-forward C-14.5: a
     [cfg_rx_enable] change landing on a start character's own cycle has no
     determinate outcome, so this REFUSES to drive (raises) rather than
     recording-and-applying the way {!Dv_xgmii.Idle_injection} does for its
     own illegal placements — that module's illegal stimulus produces a
     DETERMINATE wrong answer a bench can assert against; this one produces
     no answer at all, so there is nothing to assert and a recorded-and-
     applied run would certify coverage of a stimulus the specification
     refuses to constrain. *)
  (match Enable.change_cycles enable with
   | [] -> ()
   | _ :: _ ->
     let violations =
       List.filter_map (List.range 0 total) ~f:(fun cycle ->
         let prev_enable = if cycle = 0 then true else Enable.value_at enable ~cycle:(cycle - 1) in
         let this_enable = Enable.value_at enable ~cycle in
         if Bool.equal prev_enable this_enable
         then None
         else (
           match Xgmii_word.start_lane (word_at ~cycle) with
           | None -> None
           | Some lane -> Some (cycle, lane)))
     in
     (match violations with
      | [] -> ()
      | _ :: _ ->
        failwith
          (String.concat
             ~sep:"\n"
             ("Bench.run: cfg_rx_enable changes on the same cycle as a start character \
               (SPEC-M03 §6.3 item 7, carry-forward C-14.5) — the outcome is deliberately \
               unconstrained and SHALL NOT be driven, at:"
              :: List.map violations ~f:(fun (cycle, lane) ->
                   String.concat
                     [ "  cycle "; Int.to_string cycle; ", start lane "; Int.to_string lane ])))));
  (* WO-0072 §3, the K guard. Entered ONLY when [Clear.is_ever_high clear]
     (compatibility bar §5 clause 4: [Clear.never] — [run]'s default — has an
     empty high set, so a [?clear]-omitted call enters no new branch and
     evaluates [word_at] exactly as many times as it did before this round).
     Walks cycles [0 .. total - 1] and, for every cycle at which the DRIVEN
     clear value is [true], checks the DRIVEN WORD -- never
     [Arrival.start_cycles] (§3.3, BOUNCE BK6). REQ-009 / SPEC-M03 §6.2's
     [Idle] row and §7's reset bullet leave a [/S/] under [clear] = 1
     genuinely undetermined (§3.2), so this REFUSES to drive rather than
     recording-and-applying the way {!Dv_xgmii.Idle_injection} does for its
     own illegal placements: that module's illegal stimulus produces a
     DETERMINATE wrong answer a bench can assert against; this one produces
     no answer at all. This is a DIFFERENT subject from the M03-J4 guard
     above -- HIGH CYCLES, never transitions (§2) -- so the two pre-scans are
     independent and neither reads the other's schedule. *)
  (match Clear.is_ever_high clear with
   | false -> ()
   | true ->
     let violations =
       List.filter_map (List.range 0 total) ~f:(fun cycle ->
         if not (Clear.value_at clear ~cycle)
         then None
         else (
           match Xgmii_word.start_lane (word_at ~cycle) with
           | None -> None
           | Some lane -> Some (cycle, lane)))
     in
     (match violations with
      | [] -> ()
      | _ :: _ ->
        failwith
          (String.concat
             ~sep:"\n"
             ("Bench.run: clear is asserted on a cycle carrying a start character \
               (REQ-009, SPEC-M03 section 6.2's Idle row, section 7's reset bullet) \
               — the outcome is deliberately unconstrained and SHALL NOT be driven, at:"
              :: List.map violations ~f:(fun (cycle, lane) ->
                   String.concat
                     [ "  cycle "; Int.to_string cycle; ", start lane "; Int.to_string lane ])))));
  (* Cycles are driven in ASCENDING order by an explicit recursion, never by
     a [List.*] combinator. [sample_cycle] drives the port and steps the
     clock, so its evaluation order IS the stimulus: Base's [List.init]
     applies [~f] from the highest index DOWN to 0 (Stdlib's ascends), and
     under it run 30771064764 played every schedule BACKWARDS — the strobe
     monitor recorded cycles 20, 19, … 0 and M03 saw a terminate before a
     start. This is the hazard test/xgmii/arrival.ml:37-40 already refuses
     [List.mapi] for. The [let] below sequences the sample before the
     recursive call, so the order cannot depend on argument-evaluation order
     either. *)
  let rec drive cycle acc =
    if cycle >= total
    then List.rev acc
    else (
      let s =
        sample_cycle
          t
          ~cycle
          ~enable:(Enable.value_at enable ~cycle)
          ~clear:(Clear.value_at clear ~cycle)
          (word_at ~cycle)
      in
      drive (cycle + 1) (s :: acc))
  in
  (* [run]'s ascending-cycle contract is checked at the choke point inside
     [sample_cycle] (RV-0038-R5 / R5-1), not here. RV-0038-R4-VERDICT's
     original R4-2 guard lived at this call site instead and checked the
     order of the RETURNED list — a different object from the order of the
     side effects that actually drove the design, and one that would not
     have fired on run 30771064764's reversed drive (Base's [List.init]
     returns its list in ascending index order however it evaluates [~f], so
     that guard's own check would have passed even under the original bug).
     Withdrawn in favour of the choke-point guard rather than kept alongside
     it, so there is exactly one true statement about ordering in this file
     rather than one true guard and one guard whose message overreached. *)
  drive 0 []
;;

(* WO-0065 §6.1 debt 2: at a lane-4 start this function's own word count is
   blind by identity to a mis-positioned tlast -- see bench.mli's own
   docstring for the full caveat, paid here at the definition rather than
   only at its call sites. *)
let delivered_samples samples = List.filter samples ~f:(fun s -> s.out.tvalid)

let delivered_octets samples =
  delivered_samples samples |> List.concat_map ~f:(fun s -> Stream_word.octets s.out)
;;

let tlast_sample samples = List.find (delivered_samples samples) ~f:(fun s -> s.out.tlast)

(* RV-0038-R6 / R6-1: [errors_high] is read off the DUT's error OUTPUTS via
   the [Before] view, so the pulse it reports already belongs to [s.cycle] —
   the same cycle whose input word was driven, not a cycle later. *)
let error_pulses samples =
  List.concat_map samples ~f:(fun s ->
    List.map s.errors_high ~f:(fun name -> s.cycle, name))
;;

let account_clean_frame t (frame : Arrival.frame) samples ~aborted =
  Conservation_monitor.frame_in t.conservation;
  Conservation_monitor.frame_out t.conservation ~aborted;
  Octet_time.Latency.frame_in t.latency (Arrival.in_times frame);
  (* RV-0038-R6 / R6-1: this is the call site RV-0038-R5 once named as
     mattering most, and it needs no relabelling any more — [s.cycle] under
     the [Before] view already IS the cycle each delivered word belongs to,
     so pairing it with [s.out] here is exact by construction, not a repair
     of a one-cycle understatement the way round 5's [out_cycle] swap was. *)
  let delivered_pairs =
    List.map (delivered_samples samples) ~f:(fun s -> s.cycle, s.out)
  in
  Octet_time.Latency.frame_out t.latency (Octet_time.of_words delivered_pairs)
;;

(* WO-0064: consolidated from the fourteen file-local copies WO-0062 through
   WO-0059 each left behind (test_m03_b.ml, test_m03_d.ml through
   test_m03_i.ml) into the one home {!account_clean_frame} above already
   established. Bodies moved verbatim; see bench.mli for the naming axis
   (`_frame` carries a genuine {!Arrival.frame} record, `_piece` does not)
   and each function's own precondition. *)
let account_dropped_frame bench (frame : Dv_xgmii.Arrival.frame) ~strobe =
  Dv_monitors.Conservation_monitor.frame_in (conservation bench);
  Dv_monitors.Conservation_monitor.discarded (conservation bench) ~strobes:[ strobe ];
  Dv_monitors.Octet_time.Latency.frame_in (latency bench) (Dv_xgmii.Arrival.in_times frame);
  Dv_monitors.Octet_time.Latency.frame_dropped (latency bench)
;;

let account_forwarded_piece bench ~start_ot ~received ~delivered ~aborted samples =
  Dv_monitors.Conservation_monitor.frame_in (conservation bench);
  Dv_monitors.Conservation_monitor.frame_out (conservation bench) ~aborted;
  let in_times = Array.init (8 + received) ~f:(fun i -> start_ot + i) in
  Dv_monitors.Octet_time.Latency.frame_in (latency bench) in_times;
  let delivered_pairs = List.map samples ~f:(fun s -> s.cycle, s.out) in
  Dv_monitors.Octet_time.Latency.frame_out
    (latency bench)
    ~expected_octets:delivered
    (Dv_monitors.Octet_time.of_words delivered_pairs)
;;

let account_dropped_piece bench ~start_ot ~received ~strobe =
  Dv_monitors.Conservation_monitor.frame_in (conservation bench);
  Dv_monitors.Conservation_monitor.discarded (conservation bench) ~strobes:[ strobe ];
  let in_times = Array.init (8 + received) ~f:(fun i -> start_ot + i) in
  Dv_monitors.Octet_time.Latency.frame_in (latency bench) in_times;
  Dv_monitors.Octet_time.Latency.frame_dropped (latency bench)
;;

(* WO-0072 §8.3: standing obligations 2 and 3 for a frame accepted and then
   abandoned under REQ-009's synchronous clear. [samples] must already be
   THIS frame's own delivered words and no others -- see bench.mli's own
   docstring; this function does not filter or otherwise select from it. *)
let account_cleared_frame t (frame : Arrival.frame) ~delivered samples =
  if delivered < 0
  then
    failwith
      (String.concat
         [ "Bench.account_cleared_frame: delivered must be >= 0, got "
         ; Int.to_string delivered
         ]);
  Conservation_monitor.frame_in_exempt t.conservation ~reason:"clear (REQ-009)";
  Octet_time.Latency.frame_in t.latency (Arrival.in_times frame);
  if delivered = 0
  then Octet_time.Latency.frame_dropped t.latency
  else (
    let delivered_pairs = List.map samples ~f:(fun s -> s.cycle, s.out) in
    Octet_time.Latency.frame_out
      t.latency
      ~expected_octets:delivered
      (Octet_time.of_words delivered_pairs))
;;

let split_at_first_tlast samples =
  let rec go acc = function
    | [] -> List.rev acc, []
    | (s : sample) :: rest ->
      if s.out.Dv_monitors.Stream_word.tlast then List.rev (s :: acc), rest else go (s :: acc) rest
  in
  go [] samples
;;

(* WO-0040 §3.3: the one authorised bench addition. [one_frame] is
   re-expressed through it immediately below so the §0.3 lane mapping
   (lane 0 -> first_start 8, lane 4 -> first_start 12) has exactly one home
   — see the Return log for the line-by-line behaviour-preservation
   argument for that re-expression.

   [?ifg] added by WO-0059 §8.1, passed straight through to [Arrival.create]'s
   own [?ifg] and defaulting to [Arrival]'s own default when omitted — every
   caller before WO-0059 omits it and is therefore unaffected. *)
let frames_at ~lane ~fcs_valid ?ifg octets_lists =
  let first_start =
    match lane with
    | 0 -> 8
    | 4 -> 12
    | _ -> failwith "Bench.frames_at: lane must be 0 or 4 (REQ-101, §6.3 item 3)"
  in
  Arrival.create ~first_start ?ifg ~fcs_valid octets_lists
;;

let one_frame ~lane octets = frames_at ~lane ~fcs_valid:true [ octets ]

let directed_lengths = List.init 8 ~f:(fun i -> 64 + i)

let directed_frame_octets ~length =
  let payload_len = length - 4 in
  let da_through_payload =
    List.init payload_len ~f:(fun j -> (length * 3 + (j * 5) + 7) land 0xFF)
  in
  Frame.with_fcs da_through_payload
;;

(* [List.map] here also has side effects per iteration (each one elaborates
   and runs a fresh simulation), but unlike [run]'s driver above it is
   order-independent BY ARGUMENT: every iteration builds and returns its own
   fresh [bench]/[sched]/[samples] from [length] alone, so no iteration reads
   or mutates anything another iteration wrote. That is what makes today's
   use correct regardless of [List.map]'s evaluation order (RV-0038-R4). A
   future edit that shares state across iterations (e.g. a running [bench]
   or an accumulator) would invalidate this argument and should re-open the
   ordering question this comment closes today. *)
let run_directed_lengths ~lane =
  List.map directed_lengths ~f:(fun length ->
    let octets = directed_frame_octets ~length in
    let sched = one_frame ~lane octets in
    let bench = create () in
    let samples = run bench sched ~drain:8 () in
    length, sched, bench, samples)
;;

let assert_monitors_clean t ~row =
  if not (Protocol_monitor.is_clean t.protocol)
  then
    failwith
      (String.concat
         [ row; ": protocol monitor unclean:\n"; Protocol_monitor.report t.protocol ]);
  if not (Conservation_monitor.is_clean t.conservation)
  then
    failwith
      (String.concat
         [ row
         ; ": conservation monitor unclean:\n"
         ; Conservation_monitor.report t.conservation
         ]);
  if not (Strobe_monitor.is_clean t.strobes)
  then
    failwith
      (String.concat [ row; ": strobe monitor unclean:\n"; Strobe_monitor.report t.strobes ]);
  (* RV-0038-R5 / R5-3: the tagger's ERRORS are always meaningful; its
     CONSTANCY is a claim it can only make once it has compared a frame, and
     it correctly declines to make it over an empty set ([is_constant] is
     false with zero comparisons, by [Octet_time.mli]'s own definition — "at
     least one octet was compared and every front-offset class has a single
     L"). Demanding [is_clean] of a tagger nobody fed anything is the item-5
     bench defect from run 30772333717: the scaffolding smoke test drives no
     frames and then asks a frameless monitor to certify itself clean, and
     [is_clean]'s honest "no" was mistaken for a finding. dv_monitors is not
     changed by this fix — its behaviour was already right. *)
  (match Octet_time.Latency.errors t.latency with
   | [] -> ()
   | errs ->
     failwith
       (String.concat
          [ row; ": latency tagger errors:\n"; String.concat ~sep:"\n" errs ]));
  if Octet_time.Latency.frames_compared t.latency > 0
     && not (Octet_time.Latency.is_clean t.latency)
  then
    failwith
      (String.concat
         [ row; ": latency tagger unclean:\n"; Octet_time.Latency.report t.latency ])
;;
