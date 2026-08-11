(** Family F — the first gap this programme has ever measured at a
    transmit port (WO-0082 §0, §1.3). Two units: U17 (M04-F1), U18
    (M04-F2). Derived from SPEC-M04 §6.1's inter-frame-gap paragraph
    ([g = ceil((cfg_ifg + t)/8)], actual gap [8g - t], "gaps are only ever
    rounded up"), §7's C-16 bullet, and requirements.md §0.3 (the gap
    convention, and the *Against deficit idle count* paragraph). Every run
    here is driven through {!Bench.run_stream}, WO-0082's own capability —
    the standing wire decoder has judged REQ-204 since the first M04 run,
    but never once seen a gap: {!Dv_xgmii.Tx_decoder.gaps} is "octets from
    each terminate character inclusive to the next start character
    exclusive, one per completed gap", and a one-frame run completes none.

    {2 M04-F5 — NO-ASSERT, round-wide (WO-0082 §1.3, §6.2)}

    Stated here because both units below share the discharge: no unit in
    this file asserts an average gap; no unit asserts a gap of exactly 12
    octets at [t = 0]; no unit imports requirements.md §0.3's RECEIVE-side
    spacing (a DIC-capable partner alternating lane-0 and lane-4 starts at
    10-and-11-cycle spacing). §0.3 describes two opposite behaviours one
    paragraph apart, and the receive one is the one this programme has
    been living in for nine campaigns — the mis-import is the default this
    round guards against, not a hypothetical. The gap at [t = 0] is
    SIXTEEN octets (REQ-204's own verification figure); 12 is [cfg_ifg],
    the MINIMUM, not the gap.

    {2 What this file does NOT claim (WO-0082 §1.4, §9.8, BOUNCE BM8)}

    Neither unit asserts [start_spacings] as REQ-209's sustained cadence
    claim (that belongs to an uncommissioned family-I row); neither names
    nor drives the [cfg_ifg] parameterisation, the abort gap, or the
    10 000-frame DIC sweep that three of this family's other rows need —
    all three need capabilities this round does not build (WO-0082 §1.4),
    and none of those rows is named here even to disclaim them, per bar
    M-7. *)

open! Base
open Bench

let fail row msg = failwith (String.concat [ row; ": "; msg ])

let lane_value wire lane =
  match Dv_xgmii.Xgmii_word.lane wire lane with
  | Dv_xgmii.Xgmii_word.Data d -> d
  | Dv_xgmii.Xgmii_word.Control d -> d
;;

(* ---- U17: M04-F1 ---------------------------------------------------------- *)
(* Two P = 60 frames, one run, driven through {!Bench.run_stream} — WO-0082
   §6.2. Run length 51 cycles. *)

let run_f1 () =
  let row = "M04-F1" in
  let p = 60 in
  let _, t, samples = run_stream [ content_octets ~p; content_octets ~p ] in
  let c = first_accepted_cycle samples in
  (* Assertion 1: decoder clean (REQ-201/202/203/204/205's judgement on
     both frames), strobe set empty, exactly two frames begun and
     completed, neither underflowed. *)
  assert_instruments_clean_n t ~row ~frames:2;
  (* Assertion 2: two decoded frames, at the run law's own cycles
     (WO-0082 §4.2, §6.2's table). *)
  let f1, f2 =
    match wire_frames samples with
    | [ f1; f2 ] -> f1, f2
    | fs ->
      fail
        row
        (String.concat
           [ "wire_frames decoded "; Int.to_string (List.length fs); " frames, expected 2" ])
  in
  if f1.Dv_xgmii.Tx_decoder.terminate_cycle <> c + 10
  then
    fail
      row
      (String.concat
         [ "frame 1 terminate cycle = "
         ; Int.to_string f1.Dv_xgmii.Tx_decoder.terminate_cycle
         ; ", expected C+10"
         ]);
  if f1.Dv_xgmii.Tx_decoder.terminate_lane <> 0
  then
    fail
      row
      (String.concat
         [ "frame 1 terminate lane = "
         ; Int.to_string f1.Dv_xgmii.Tx_decoder.terminate_lane
         ; ", expected 0"
         ]);
  if f2.Dv_xgmii.Tx_decoder.start_cycle <> c + 12
  then
    fail
      row
      (String.concat
         [ "frame 2 start cycle = "
         ; Int.to_string f2.Dv_xgmii.Tx_decoder.start_cycle
         ; ", expected C+12 (run law S_2 = T_1 + g_1)"
         ]);
  if f2.Dv_xgmii.Tx_decoder.terminate_cycle <> c + 21
  then
    fail
      row
      (String.concat
         [ "frame 2 terminate cycle = "
         ; Int.to_string f2.Dv_xgmii.Tx_decoder.terminate_cycle
         ; ", expected C+21"
         ]);
  if f2.Dv_xgmii.Tx_decoder.terminate_lane <> 0
  then
    fail
      row
      (String.concat
         [ "frame 2 terminate lane = "
         ; Int.to_string f2.Dv_xgmii.Tx_decoder.terminate_lane
         ; ", expected 0"
         ]);
  (* Assertion 3: Tx_decoder.gaps has exactly one entry, and it is 16 —
     the list length is asserted first and by itself: a one-element
     assertion on a list not yet measured is how a two-gap run passes a
     one-gap check. *)
  let gaps = Dv_xgmii.Tx_decoder.gaps (decoder t) in
  if List.length gaps <> 1
  then
    fail
      row
      (String.concat
         [ "Tx_decoder.gaps has "; Int.to_string (List.length gaps); " entries, expected 1" ]);
  (match gaps with
   | [ g ] -> if g <> 16 then fail row (String.concat [ "the one gap = "; Int.to_string g; ", expected 16" ])
   | _ -> fail row "unreachable: gaps length already checked to be 1");
  (* Assertion 4: Tx_decoder.start_spacings has exactly one entry and it is
     11; 8 x 11 = 88 octets between successive start characters, asserted
     as the figure REQ-204's own verification column states, with the
     multiplication written out. *)
  let spacings = Dv_xgmii.Tx_decoder.start_spacings (decoder t) in
  if List.length spacings <> 1
  then
    fail
      row
      (String.concat
         [ "Tx_decoder.start_spacings has "
         ; Int.to_string (List.length spacings)
         ; " entries, expected 1"
         ]);
  (match spacings with
   | [ sp ] ->
     if sp <> 11
     then fail row (String.concat [ "the one spacing = "; Int.to_string sp; ", expected 11 cycles" ]);
     let octets_between = 8 * sp in
     if octets_between <> 88
     then
       fail
         row
         (String.concat
            [ "8 x "
            ; Int.to_string sp
            ; " = "
            ; Int.to_string octets_between
            ; " octets between successive start characters, expected 88 (REQ-204's own \
               verification figure)"
            ])
   | _ -> fail row "unreachable: start_spacings length already checked to be 1");
  (* Assertion 5: the fill residue (§6.0(c)) — the terminate word's fill
     lanes 1..7 carry /I/ as a VALUE (control bit set AND xgmii_txd =
     0x07, not just a control-bit check), and every lane of the gap word
     at cycle C+11 (the only cycle in T_1+1 .. S_2-1, since S_2 = C+12) is
     idle. The scan STOPS BEFORE S_2 = C+12: the next preamble word is not
     a gap word (the residue WO-0081 §19.2 item 4 named). *)
  (match List.find samples ~f:(fun (s : sample) -> s.cycle = c + 10) with
   | None -> fail row "no sample at the terminate cycle C+10"
   | Some s ->
     List.iter (List.range 1 8) ~f:(fun lane ->
       if not (Dv_xgmii.Xgmii_word.is_control s.wire lane)
       then
         fail
           row
           (String.concat
              [ "terminate word lane "; Int.to_string lane; " is not a control character" ]);
       let v = lane_value s.wire lane in
       if v <> Dv_xgmii.Xgmii_word.idle_char
       then
         fail
           row
           (String.concat
              [ "terminate word lane "
              ; Int.to_string lane
              ; " = "
              ; Int.to_string v
              ; ", expected /I/ = 0x07"
              ])));
  (match List.find samples ~f:(fun (s : sample) -> s.cycle = c + 11) with
   | None -> fail row "no sample at the gap cycle C+11"
   | Some s ->
     if not (Dv_xgmii.Xgmii_word.is_idle s.wire) then fail row "gap word at C+11 is not all-idle");
  (* Assertion 6: each frame's decoded octets equal the padded content plus
     its FCS, 64 octets each. *)
  let expected = Dv_xgmii.Frame.with_fcs (Dv_xgmii.Frame.pad_to_60 (content_octets ~p:60)) in
  if List.length f1.Dv_xgmii.Tx_decoder.octets <> 64
  then
    fail
      row
      (String.concat
         [ "frame 1 wire octet count = "
         ; Int.to_string (List.length f1.Dv_xgmii.Tx_decoder.octets)
         ; ", expected 64"
         ]);
  if not (List.equal Int.equal f1.Dv_xgmii.Tx_decoder.octets expected)
  then fail row "frame 1's decoded octets do not equal Frame.with_fcs (Frame.pad_to_60 content)";
  if List.length f2.Dv_xgmii.Tx_decoder.octets <> 64
  then
    fail
      row
      (String.concat
         [ "frame 2 wire octet count = "
         ; Int.to_string (List.length f2.Dv_xgmii.Tx_decoder.octets)
         ; ", expected 64"
         ]);
  if not (List.equal Int.equal f2.Dv_xgmii.Tx_decoder.octets expected)
  then fail row "frame 2's decoded octets do not equal Frame.with_fcs (Frame.pad_to_60 content)";
  (* M04-F5 (NO-ASSERT, round-wide, WO-0082 §1.3, §6.2): nothing above
     asserts an average gap, and nothing asserts "12 octets at t = 0" —
     the value at t = 0 is 16, and 12 is cfg_ifg, the MINIMUM, not the
     gap. requirements.md §0.3's RECEIVE-side spacing is not imported
     anywhere; a transmit bench built from that paragraph fails a
     conformant M04 on every frame. *)
  ()
;;

let%expect_test
  "M04-F1: the first gap this programme has measured at a transmit port \
   — 16 octets from the terminate character inclusive, 88 octets between \
   start characters"
  =
  run_f1 ();
  [%expect {||}]
;;

(* ---- U18: M04-F2 ----------------------------------------------------------- *)
(* The eight-member terminate-lane sweep — WO-0082 §6.3's own table,
   transcribed literally rather than recomputed from the run law here: the
   table IS the expectation this unit checks the bench against, not a
   formula this unit shares with the runner. Eight elaborations, run
   length 51 each. *)

type f2_member =
  { p1 : int
  ; t1 : int
  ; gap : int
  ; s2_off : int
  }

let f2_members =
  [ { p1 = 60; t1 = 0; gap = 16; s2_off = 12 }
  ; { p1 = 61; t1 = 1; gap = 15; s2_off = 12 }
  ; { p1 = 62; t1 = 2; gap = 14; s2_off = 12 }
  ; { p1 = 63; t1 = 3; gap = 13; s2_off = 12 }
  ; (* p1 = 64, t1 = 4: the DISCRIMINATING member. §0.3's convention and
       the convention §0.3 rejects give the SAME answer at every other
       residue in this sweep and differ ONLY here: 12 octets by this
       specification's inclusive-from-the-terminate-character convention,
       20 by the rejected reading (twelve idle octets AFTER the terminate
       character). SPEC-M04 §6.1 names exactly these two numbers, and the
       sweep is driven whole because sampling it has a seven-in-eight
       chance of missing this one member. *)
    { p1 = 64; t1 = 4; gap = 12; s2_off = 12 }
  ; { p1 = 65; t1 = 5; gap = 19; s2_off = 13 }
  ; { p1 = 66; t1 = 6; gap = 18; s2_off = 13 }
  ; { p1 = 67; t1 = 7; gap = 17; s2_off = 13 }
  ]
;;

let run_f2_member (m : f2_member) =
  let row = String.concat [ "M04-F2 (P1="; Int.to_string m.p1; ")" ] in
  let _, t, samples = run_stream [ content_octets ~p:m.p1; content_octets ~p:60 ] in
  let c = first_accepted_cycle samples in
  (* instruments clean at frames:2. *)
  assert_instruments_clean_n t ~row ~frames:2;
  let f1, f2 =
    match wire_frames samples with
    | [ f1; f2 ] -> f1, f2
    | fs ->
      fail
        row
        (String.concat
           [ "wire_frames decoded "; Int.to_string (List.length fs); " frames, expected 2" ])
  in
  (* T1 at C+10, and t1 at its own lane. *)
  if f1.Dv_xgmii.Tx_decoder.terminate_cycle <> c + 10
  then
    fail
      row
      (String.concat
         [ "T1 = "; Int.to_string f1.Dv_xgmii.Tx_decoder.terminate_cycle; ", expected C+10" ]);
  if f1.Dv_xgmii.Tx_decoder.terminate_lane <> m.t1
  then
    fail
      row
      (String.concat
         [ "t1 = "; Int.to_string f1.Dv_xgmii.Tx_decoder.terminate_lane; ", expected "
         ; Int.to_string m.t1
         ]);
  (* the single gap, equal to its own value from the table. *)
  let gaps = Dv_xgmii.Tx_decoder.gaps (decoder t) in
  if List.length gaps <> 1
  then
    fail
      row
      (String.concat
         [ "Tx_decoder.gaps has "; Int.to_string (List.length gaps); " entries, expected 1" ]);
  (match gaps with
   | [ g ] ->
     if g <> m.gap
     then
       fail
         row
         (String.concat [ "the one gap = "; Int.to_string g; ", expected "; Int.to_string m.gap ])
   | _ -> fail row "unreachable: gaps length already checked to be 1");
  (* S2 at its own cycle. *)
  if f2.Dv_xgmii.Tx_decoder.start_cycle <> c + m.s2_off
  then
    fail
      row
      (String.concat
         [ "S2 = "; Int.to_string f2.Dv_xgmii.Tx_decoder.start_cycle; ", expected C+"
         ; Int.to_string m.s2_off
         ]);
  (* every start character in lane 0 (both of them), read through
     Xgmii_word.start_lane on the raw sample, not only through the
     decoder. *)
  let start_samples =
    List.filter samples ~f:(fun (s : sample) ->
      Option.is_some (Dv_xgmii.Xgmii_word.start_lane s.wire))
  in
  (match start_samples with
   | [ s1; s2 ] ->
     (match Dv_xgmii.Xgmii_word.start_lane s1.wire, Dv_xgmii.Xgmii_word.start_lane s2.wire with
      | Some 0, Some 0 -> ()
      | Some l1, Some l2 ->
        fail
          row
          (String.concat
             [ "start lanes = ("; Int.to_string l1; ", "; Int.to_string l2; "), expected (0, 0)" ])
      | _ -> fail row "unreachable: start_samples was filtered on Some")
   | other ->
     fail
       row
       (String.concat
          [ "expected exactly two start characters in the run, found "
          ; Int.to_string (List.length other)
          ]));
  (* M04-F5 (NO-ASSERT, round-wide): the t = 4 member's own gap is 12, not
     20 — 20 is what the rejected receive-side convention would give.
     Nothing in this sweep asserts an average gap or imports that
     convention. *)
  ()
;;

let run_f2 () = List.iter f2_members ~f:run_f2_member

let%expect_test
  "M04-F2: the eight-member terminate-lane sweep of the gap, \
   12 octets at t = 4 and 16 at t = 0"
  =
  run_f2 ();
  [%expect {||}]
;;
