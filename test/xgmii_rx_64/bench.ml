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
  (* REQ-009: clear for one cycle, then release. cfg_rx_enable held at 1 for
     the whole run — family J (the disable path) is out of this packet's
     eleven rows (WO-0038 §1), so there is no reading to gate here.
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

type sample =
  { cycle : int (* schedule cycle whose INPUT word was driven *)
  ; out_cycle : int (* cycle the sampled OUTPUT belongs to = cycle + 1 *)
  ; in_word : Xgmii_word.t
  ; out : Stream_word.t
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
let sample_cycle t ~cycle (in_word : Xgmii_word.t) : sample =
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
  let o = Cyclesim.outputs t.sim in
  Xgmii_probe.to_refs ~d:i.xgmii_rx.d ~c:i.xgmii_rx.c in_word;
  Cyclesim.cycle t.sim;
  (* RV-0038-R5: [Cyclesim.cycle] returns having recomputed the outputs from
     post-edge register state, so every value read below (rx and the five
     error strobes alike — all of them outputs) belongs to the cycle AFTER
     the one whose input was just driven. This is not read off Hardcaml's
     documentation: it is settled by this repository's own CI-promoted
     waveform, test/hardcaml_ethernet/test_word_counter.ml, whose snapshot
     shows [valid] high during cycle 1 producing [count] = 1 during cycle 2 —
     the ordinary hardware relation, input at cycle N, registered output at
     N + 1. A [drive -> Cyclesim.cycle -> sample] reader that labels what it
     just read with [cycle] is therefore one cycle early; [out_cycle] is the
     corrected label and every OUTPUT observation in this bench uses it.
     [cycle] keeps its meaning as the schedule cycle whose INPUT word was
     driven (and is what the guard above checks). *)
  let out_cycle = cycle + 1 in
  let out =
    Axi64_probe.of_refs
      ~tvalid:o.rx.tvalid
      ~tdata:o.rx.tdata
      ~tkeep:o.rx.tkeep
      ~tstrb:o.rx.tstrb
      ~tlast:o.rx.tlast
      ~tuser:o.rx.tuser
      ()
  in
  let high (name, r) = if Bits.to_int !r <> 0 then Some name else None in
  let errors_high =
    List.filter_map
      [ "error_bad_fcs", o.error_bad_fcs
      ; "error_bad_frame", o.error_bad_frame
      ; "error_runt", o.error_runt
      ; "error_oversize", o.error_oversize
      ; "error_start_without_terminate", o.error_start_without_terminate
      ]
      ~f:high
  in
  Protocol_monitor.observe t.protocol ~cycle:out_cycle out;
  Strobe_monitor.sample t.strobes ~cycle:out_cycle ~high:errors_high;
  { cycle; out_cycle; in_word; out; errors_high }
;;

let run t sched ~drain ?word_at () =
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
  let total = Arrival.cycles sched + drain in
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
      let s = sample_cycle t ~cycle (word_at ~cycle) in
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

let delivered_samples samples = List.filter samples ~f:(fun s -> s.out.tvalid)

let delivered_octets samples =
  delivered_samples samples |> List.concat_map ~f:(fun s -> Stream_word.octets s.out)
;;

let tlast_sample samples = List.find (delivered_samples samples) ~f:(fun s -> s.out.tlast)

(* RV-0038-R5 / R5-2: [errors_high] is read off the DUT's error OUTPUTS, so
   the pulse it reports belongs to [s.out_cycle], not [s.cycle] (the INPUT
   cycle that was driven to produce it). *)
let error_pulses samples =
  List.concat_map samples ~f:(fun s ->
    List.map s.errors_high ~f:(fun name -> s.out_cycle, name))
;;

let account_clean_frame t (frame : Arrival.frame) samples ~aborted =
  Conservation_monitor.frame_in t.conservation;
  Conservation_monitor.frame_out t.conservation ~aborted;
  Octet_time.Latency.frame_in t.latency (Arrival.in_times frame);
  (* RV-0038-R5 / R5-2: this is the call site the ruling names as mattering
     most. The latency tagger derives its output octet times from these
     (cycle, word) pairs (Octet_time.of_words), so pairing a delivered word
     with [s.cycle] rather than [s.out_cycle] would have understated every
     measured word delay by one cycle — exactly the ΔC = 2 vs ΔC = 3
     discrepancy items 1, 2 and 4 of run 30772333717 turned out to be. *)
  let delivered_pairs =
    List.map (delivered_samples samples) ~f:(fun s -> s.out_cycle, s.out)
  in
  Octet_time.Latency.frame_out t.latency (Octet_time.of_words delivered_pairs)
;;

let one_frame ~lane octets =
  let first_start =
    match lane with
    | 0 -> 8
    | 4 -> 12
    | _ -> failwith "Bench.one_frame: lane must be 0 or 4 (REQ-101, §6.3 item 3)"
  in
  Arrival.create ~first_start [ octets ]
;;

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
