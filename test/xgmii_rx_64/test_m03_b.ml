(** M03-B1 (ASSERT, REQ-102, AP-xgmii_rx_64.md family B):

    "64-octet frame whose six filler octets and SFD octet are arbitrary
    non-standard data values, both start lanes... The frame is delivered
    unchanged: same 60 octets, same tkeep, tuser[0] = 0, no strobe."

    [Dv_xgmii.Arrival] fixes its preamble filler at 0x55 with an 0xD5 SFD and
    exposes no parameter to vary it (test/xgmii/arrival.mli, "What the model
    does not decide") — REQ-102 is precisely why it does not need one for
    every *other* row. This row needs the opposite value on purpose, so it
    builds a normal schedule and then substitutes a non-standard data
    pattern into exactly the preamble-position lanes of the schedule's own
    start word(s) before driving — [Arrival]'s /S/ placement, frame content
    and FCS are untouched; only the six filler octets and the SFD octet
    Arrival would otherwise drive as 0x55/0xD5 change value. This is
    machinery composition, not a new capability: {!Bench.run}'s [?word_at]
    exists for exactly this substitution (bench.mli).

    Preamble-position lanes, per SPEC-M03 §6.1 ("Where the preamble
    positions lie"): at a lane-0 start, lanes 1-7 of the start word; at a
    lane-4 start, lanes 5-7 of the start word *and* lanes 0-3 of the next
    word (frame octets 0-3 live in lanes 4-7 of that next word and are left
    alone). *)

open! Base
open Bench

let nonstandard_preamble_octet lane = 0xA0 + lane

let preamble_override sched (frame : Dv_xgmii.Arrival.frame) ~start_cycle
  : cycle:int -> Dv_xgmii.Xgmii_word.t
  =
  let start_lane = frame.Dv_xgmii.Arrival.start_lane in
  fun ~cycle ->
    let word = Dv_xgmii.Arrival.word_at sched ~cycle in
    let is_preamble_lane lane =
      if start_lane = 0
      then cycle = start_cycle && lane >= 1 && lane <= 7
      else
        (cycle = start_cycle && lane >= 5 && lane <= 7)
        || (cycle = start_cycle + 1 && lane >= 0 && lane <= 3)
    in
    if cycle <> start_cycle && cycle <> start_cycle + 1
    then word
    else
      { Dv_xgmii.Xgmii_word.data =
          Array.mapi word.Dv_xgmii.Xgmii_word.data ~f:(fun lane v ->
            if is_preamble_lane lane then nonstandard_preamble_octet lane else v)
      ; control = word.Dv_xgmii.Xgmii_word.control
      }
;;

let run_b1 ~lane =
  let payload = List.init 60 ~f:(fun j -> (j * 7 + 3) land 0xFF) in
  let octets = Dv_xgmii.Frame.with_fcs payload in
  if not (Dv_xgmii.Frame.residue_ok octets)
  then failwith "M03-B1: test bug — the frame's own FCS does not check out";
  let sched = one_frame ~lane octets in
  let frame = (Dv_xgmii.Arrival.frames sched).(0) in
  let start_cycle = Dv_xgmii.Arrival.start_cycle frame in
  let bench = create () in
  let samples = run bench sched ~drain:8 ~word_at:(preamble_override sched frame ~start_cycle) () in
  let expected = Dv_xgmii.Frame.delivered octets in
  let got = delivered_octets samples in
  if not (List.equal Int.equal got expected)
  then
    failwith
      (String.concat
         [ "M03-B1 (lane "
         ; Int.to_string lane
         ; "): delivered octets differ from the injected frame minus its FCS"
         ]);
  (match tlast_sample samples with
   | None -> failwith (String.concat [ "M03-B1 (lane "; Int.to_string lane; "): no tlast word" ])
   | Some s ->
     if s.out.Dv_monitors.Stream_word.tuser <> 0
     then
       failwith
         (String.concat
            [ "M03-B1 (lane "
            ; Int.to_string lane
            ; "): tuser[0] set on a legal, standard-FCS frame"
            ]));
  if not (List.is_empty (error_pulses samples))
  then
    failwith
      (String.concat
         [ "M03-B1 (lane "; Int.to_string lane; "): an error strobe pulsed on a legal frame" ]);
  account_clean_frame bench frame samples ~aborted:false;
  assert_monitors_clean bench ~row:(String.concat [ "M03-B1 (lane "; Int.to_string lane; ")" ])
;;

let%expect_test "M03-B1: nonstandard preamble filler and SFD octets, both start lanes" =
  run_b1 ~lane:0;
  run_b1 ~lane:4;
  [%expect {||}]
;;
