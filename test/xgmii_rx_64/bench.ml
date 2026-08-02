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
  }
;;

type sample =
  { cycle : int
  ; in_word : Xgmii_word.t
  ; out : Stream_word.t
  ; errors_high : string list
  }

(* Drives [in_word] onto xgmii_rx, steps one clock, samples rx and the five
   error strobes, and feeds the standing Protocol_monitor and Strobe_monitor
   (obligations 1 and 4). The Conservation_monitor is deliberately not fed
   here — see bench.mli. *)
let sample_cycle t ~cycle (in_word : Xgmii_word.t) : sample =
  let i = Cyclesim.inputs t.sim in
  let o = Cyclesim.outputs t.sim in
  Xgmii_probe.to_refs ~d:i.xgmii_rx.d ~c:i.xgmii_rx.c in_word;
  Cyclesim.cycle t.sim;
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
  Protocol_monitor.observe t.protocol ~cycle out;
  Strobe_monitor.sample t.strobes ~cycle ~high:errors_high;
  { cycle; in_word; out; errors_high }
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
  let samples = drive 0 [] in
  (* [run]'s own contract, checked rather than promised (RV-0038-R4). *)
  List.iteri samples ~f:(fun i s ->
    if s.cycle <> i
    then
      failwith
        (String.concat
           [ "Bench.run: cycle "
           ; Int.to_string s.cycle
           ; " was driven at position "
           ; Int.to_string i
           ; " — the stimulus is not in ascending cycle order, so nothing "
           ; "downstream of this is a statement about the design"
           ]));
  samples
;;

let delivered_samples samples = List.filter samples ~f:(fun s -> s.out.tvalid)

let delivered_octets samples =
  delivered_samples samples |> List.concat_map ~f:(fun s -> Stream_word.octets s.out)
;;

let tlast_sample samples = List.find (delivered_samples samples) ~f:(fun s -> s.out.tlast)

let error_pulses samples =
  List.concat_map samples ~f:(fun s ->
    List.map s.errors_high ~f:(fun name -> s.cycle, name))
;;

let account_clean_frame t (frame : Arrival.frame) samples ~aborted =
  Conservation_monitor.frame_in t.conservation;
  Conservation_monitor.frame_out t.conservation ~aborted;
  Octet_time.Latency.frame_in t.latency (Arrival.in_times frame);
  let delivered_pairs =
    List.map (delivered_samples samples) ~f:(fun s -> s.cycle, s.out)
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
  if not (Octet_time.Latency.is_clean t.latency)
  then
    failwith
      (String.concat
         [ row; ": latency tagger unclean:\n"; Octet_time.Latency.report t.latency ])
;;
