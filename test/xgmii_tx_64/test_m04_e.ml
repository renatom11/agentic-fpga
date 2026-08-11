(** Family E — terminate placement and fill: REQ-205 (WO-0081 §1.3, §2,
    §6.5-§6.6). Two units: U14 (M04-E1, M04-E2, M04-E3, M04-E5), U15
    (M04-E4), in that order (WO-0081 §16.1).

    {2 What this family adds over the standing decoder (WO-0081 §1.3)}

    Obligation 1's decoder already judges REQ-205's FILL — every lane of the
    terminate word after the terminate character, and every lane of every
    gap word, carries [/I/]. What it does not assert is the terminate
    character's own PLACEMENT at a named cycle and lane derived from the
    bench's own arithmetic: [M04-E1] is that derivation, an eight-member
    sweep at [P] in [60 .. 67] where the terminate CYCLE never moves (all
    eight land at [C+10], trap T3 — SPEC-M04 §4.2(a)) and only the LANE
    does, [t = F mod 8] running [0 .. 7] across the sweep in order.
    [M04-E2] restates REQ-205's fill as a VALUE assertion (control bit set
    AND [xgmii_txd] = [0x07]), which is what §6.3 item 2's normativity of
    [/I/]'s own value asks for and the decoder's control-bit-only judgement
    does not give. [M04-E3] is the empty-fill boundary ([t=7], zero fill
    lanes) beside its opposite ([t=0], seven). [M04-E5] is a NO-ASSERT: see
    the round-wide scoping note at [run_e1_e2_e3_e5]'s own top. *)

open! Base
open Bench

let fail row msg = failwith (String.concat [ row; ": "; msg ])

(* The raw byte at [lane] of [wire], data or control alike — the same
   accessor test_m04_b.ml's and test_m04_d.ml's own [octet_value] use. *)
let octet_value wire lane =
  match Dv_xgmii.Xgmii_word.lane wire lane with
  | Dv_xgmii.Xgmii_word.Data d -> d
  | Dv_xgmii.Xgmii_word.Control d -> d
;;

(* ---- U14: M04-E1, M04-E2, M04-E3, M04-E5 ----------------------------------- *)
(* Eight runs, the eight-lane sweep -- derived from §4's identity and not
   sampled (WO-0081 §6.5). *)

let sweep_lengths = [ 60; 61; 62; 63; 64; 65; 66; 67 ]

let run_e1_e2_e3_e5 () =
  let base_row = "M04-E1, M04-E2, M04-E3, M04-E5" in
  let runs = run_lengths sweep_lengths in
  (* M04-E5 (NO-ASSERT), in this unit's own title and round-wide (§6.5
     assertion 9, §9.4(3)): every scan below is scoped to THIS run's own
     terminate word and its own post-terminate cycles -- never written as a
     universal over "every terminate character". REQ-205's "immediately
     after the last FCS octet" has NO INSTANCE on an underflowed frame
     (SPEC-M04 §9 appends no FCS to one; its terminate character sits at
     lane 1 of the /E/ word), and every one of this unit's eight runs
     carries an FCS -- a helper written as "for every terminate character,
     ..." would fail a conformant M04 the first time family G drives an
     underflowed one, so no such helper is written; each check below reads
     THIS run's own [terminate_cycle]/[terminate_lane], nothing wider. *)
  List.iter runs ~f:(fun (p, t, samples) ->
    let row = String.concat [ base_row; " (P="; Int.to_string p; ")" ] in
    let c = first_accepted_cycle samples in
    let f = Int.max p 60 + 4 in
    let terminate_cycle = c + 2 + (f / 8) in
    let terminate_lane = Int.rem f 8 in
    (* Assertions 1-2, M04-E1: the terminate character's cycle and lane,
       derived from §4's identity -- all eight members terminate at C+10
       (trap T3), only the lane moves across the sweep. A self-consistency
       check of the bench's own arithmetic; the claim against the design is
       assertions 3-4 below. *)
    if terminate_cycle <> c + 10
    then
      fail
        row
        (String.concat
           [ "derived terminate cycle = "; Int.to_string terminate_cycle
           ; ", expected C+10 (trap T3)"
           ]);
    (match List.find samples ~f:(fun (s : sample) -> s.cycle = terminate_cycle) with
     | None -> fail row "no sample at the predicted terminate cycle"
     | Some s ->
       (* Assertion 3, M04-E1: the lane's content -- control bit t set AND
          xgmii_txd lane t = 0xFD (§6.3 item 2 makes the character's own
          value normative, not only its control bit). *)
       if not (Dv_xgmii.Xgmii_word.is_control s.wire terminate_lane)
       then
         fail
           row
           (String.concat
              [ "lane "; Int.to_string terminate_lane; " of cycle "
              ; Int.to_string terminate_cycle; " does not carry a control character, expected /T/"
              ]);
       let got = octet_value s.wire terminate_lane in
       if got <> 0xFD
       then
         fail
           row
           (String.concat
              [ "lane "; Int.to_string terminate_lane; " of cycle "
              ; Int.to_string terminate_cycle; " = "; Int.to_string got; ", expected 0xFD"
              ]);
       (* Assertion 5, M04-E2: the fill lanes of the terminate word itself
          -- idle scan domain (§6.0(c)): lanes (t+1) .. 7 of the terminate
          word, and no other lane of this word. *)
       let fill_lanes = List.range (terminate_lane + 1) 8 in
       List.iter fill_lanes ~f:(fun lane ->
         if not (Dv_xgmii.Xgmii_word.is_control s.wire lane)
         then
           fail
             row
             (String.concat
                [ "terminate word, lane "; Int.to_string lane
                ; ": not a control character, expected /I/"
                ]);
         let d = octet_value s.wire lane in
         if d <> 0x07
         then
           fail
             row
             (String.concat
                [ "terminate word, lane "; Int.to_string lane; " = "; Int.to_string d
                ; ", expected 0x07 (/I/)"
                ]));
       (* Assertion 7, M04-E3: the boundary counts -- assert the count is 0
          at t=7 rather than letting an empty loop pass silently, and 7 at
          t=0. *)
       let fill_count = List.length fill_lanes in
       if p = 67 && fill_count <> 0
       then
         fail
           row
           (String.concat
              [ "P=67 (t=7): fill-lane count = "; Int.to_string fill_count; ", expected 0" ]);
       if p = 60 && fill_count <> 7
       then
         fail
           row
           (String.concat
              [ "P=60 (t=0): fill-lane count = "; Int.to_string fill_count; ", expected 7" ]));
    (* Assertion 6, M04-E2: everything after the terminate word, to the end
       of THIS run -- idle scan domain (§6.0(c)): every lane of every
       sample at cycles (terminate_cycle+1) .. (run_length-1). Every
       earlier cycle is excluded (it carries the preamble, frame octets,
       pad or FCS -- an idle scan over it fails a conformant design).
       §6.5's own caution: this asserts to the end of a ONE-FRAME run,
       never to a following preamble (no claim about the two-frame round's
       own shape is made here — that round is not named, per bar M-7). *)
    let run_length = List.length samples in
    List.iter (List.range (terminate_cycle + 1) run_length) ~f:(fun cyc ->
      match List.find samples ~f:(fun (s : sample) -> s.cycle = cyc) with
      | None -> fail row (String.concat [ "no sample at cycle "; Int.to_string cyc ])
      | Some s ->
        List.iter (List.range 0 8) ~f:(fun lane ->
          if not (Dv_xgmii.Xgmii_word.is_control s.wire lane)
          then
            fail
              row
              (String.concat
                 [ "cycle "; Int.to_string cyc; ", lane "; Int.to_string lane
                 ; ": not a control character, expected /I/"
                 ]);
          let d = octet_value s.wire lane in
          if d <> 0x07
          then
            fail
              row
              (String.concat
                 [ "cycle "; Int.to_string cyc; ", lane "; Int.to_string lane; " = "
                 ; Int.to_string d; ", expected 0x07 (/I/)"
                 ])));
    (* Assertion 4, M04-E1: cross-check against the decoder -- a SECOND
       reading of the same wire, stated as a cross-check and not as the
       row's own claim (which is assertions 1-3 above, against the bench's
       own arithmetic). *)
    let frame = wire_frame samples in
    if frame.Dv_xgmii.Tx_decoder.terminate_cycle <> terminate_cycle
    then
      fail
        row
        "cross-check: the decoder's own terminate_cycle disagrees with the bench's own \
         arithmetic";
    if frame.Dv_xgmii.Tx_decoder.terminate_lane <> terminate_lane
    then
      fail
        row
        "cross-check: the decoder's own terminate_lane disagrees with the bench's own \
         arithmetic";
    (* Assertion 8: the standing instruments. *)
    assert_instruments_clean t ~row)
;;

let%expect_test
  "M04-E1, M04-E2, M04-E3: the eight-lane terminate sweep, the fill lanes, \
   and M04-E5's scope"
  =
  run_e1_e2_e3_e5 ();
  [%expect {||}]
;;

(* ---- U15: M04-E4 ------------------------------------------------------------ *)
(* One run, P = 1514 -- its own unit because floor(F/8) = 189 is what adds
   over U14's sweep, not the lane (WO-0081 §6.6). *)

let run_e4 () =
  let row = "M04-E4" in
  let p = 1514 in
  match run_lengths [ p ] with
  | [ (_, t, samples) ] ->
    let c = first_accepted_cycle samples in
    let terminate_cycle = c + 2 + 189 in
    (* Assertion 1: the terminate character -- lane 6 of C+191, control bit
       6 set, data = 0xFD. *)
    (match List.find samples ~f:(fun (s : sample) -> s.cycle = terminate_cycle) with
     | None -> fail row "no sample at the predicted terminate cycle C+191"
     | Some s ->
       if not (Dv_xgmii.Xgmii_word.is_control s.wire 6)
       then fail row "lane 6 of C+191 does not carry a control character, expected /T/";
       let got = octet_value s.wire 6 in
       if got <> 0xFD
       then fail row (String.concat [ "lane 6 of C+191 = "; Int.to_string got; ", expected 0xFD" ]));
    (* Assertion 2: the wire octet count is 1518. *)
    let frame = wire_frame samples in
    let octets = frame.Dv_xgmii.Tx_decoder.octets in
    if List.length octets <> 1518
    then
      fail
        row
        (String.concat
           [ "wire octet count = "; Int.to_string (List.length octets); ", expected 1518" ]);
    (* Assertion 3: the FCS octets at wire indices 1514-1517, lanes 2-5 of
       C+191 -- the same word as the terminate character, which is the
       placement M04-D4's claim generalises. *)
    let content = content_octets ~p in
    let expected_fcs = Dv_xgmii.Frame.fcs (Dv_xgmii.Frame.pad_to_60 content) in
    (match List.find samples ~f:(fun (s : sample) -> s.cycle = terminate_cycle) with
     | None -> fail row "no sample at C+191 for the FCS check"
     | Some s ->
       let got_fcs = List.init 4 ~f:(fun k -> octet_value s.wire (k + 2)) in
       if not (List.equal Int.equal got_fcs expected_fcs)
       then fail row "lanes 2-5 of C+191 do not equal Frame.fcs(pad_to_60(content))");
    (* Cross-check against the decoder, the same shape M04-E1 uses above. *)
    if frame.Dv_xgmii.Tx_decoder.terminate_cycle <> terminate_cycle
    then
      fail
        row
        "cross-check: the decoder's own terminate_cycle disagrees with the bench's own \
         arithmetic";
    if frame.Dv_xgmii.Tx_decoder.terminate_lane <> 6
    then
      fail
        row
        "cross-check: the decoder's own terminate_lane disagrees with the bench's own \
         arithmetic (expected 6)";
    (* Assertion 4: the standing instruments. *)
    assert_instruments_clean t ~row
  | other ->
    fail
      row
      (String.concat
         [ "Bench.run_lengths [1514] returned "; Int.to_string (List.length other)
         ; " entries, expected 1"
         ])
;;

let%expect_test
  "M04-E4: the terminate character at lane 6 of the word at cycle \
   C + 2 + 189, P = 1514"
  =
  run_e4 ();
  [%expect {||}]
;;
