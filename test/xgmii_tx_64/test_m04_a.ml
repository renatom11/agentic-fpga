(** Family A — U2: the preamble word, the frame's first octet, and the
    start-up delay that is NOT asserted (M04-A1, M04-A2, M04-A5). Derived
    from SPEC-M04 §6.1's preamble paragraph, REQ-201, REQ-012, REQ-021, §6.3
    item 4's unconstrained start-up delay, and AP-xgmii_tx_64.md §4.A.
    WO-0080 §6.2.

    Every assertion below is stated relative to [C] — {!Bench.first_accepted_cycle},
    the cycle the first source word is accepted — and never relative to
    cycle 0 or to the release of [clear] (M04-A5, BOUNCE BM7): SPEC-M04 §6.3
    item 4 leaves the idle-word count before the first frame unconstrained,
    and no comparison below names an absolute cycle. *)

(** {2 WO-0083 addendum — M04-A4, the preamble word after an underflowed
    predecessor}

    [M04-A1] above compares the preamble word after [clear] against REQ-201;
    [M04-A3] compares it after a hundred consecutive clean frames. Neither
    reaches the one predecessor family G's own round is the first to build:
    an UNDERFLOWED frame. WO-0083 §5.3's stall schedule and §4's abort law
    make that predecessor drivable for the first time, and [M04-A4] is the
    row that reaches it — three frames, after [clear], a normal frame, and
    an underflowed frame, carrying the identical preamble word, byte for
    byte and control bit for control bit. Family A completes at [A4] if its
    verdict holds, which is dv_lead's own check at the `RV-`, never this
    file's to claim. *)

open! Base
open Bench

let row = "M04-A1, M04-A2, M04-A5"
let fail msg = failwith (String.concat [ row; ": "; msg ])

let run_a () =
  let p = 60 in
  match run_lengths [ p ] with
  | [ (_, t, samples) ] ->
    let c = first_accepted_cycle samples in
    (* M04-A1, assertions 1-5: exactly one word carries a start character;
       it is at cycle C+1, in lane 0, control = 0x01 (bit 0 set, bits 1-7
       clear), data = the eight preamble octets, lane 0 first. *)
    let start_samples =
      List.filter samples ~f:(fun (s : sample) ->
        Option.is_some (Dv_xgmii.Xgmii_word.start_lane s.wire))
    in
    (match start_samples with
     | [ s ] ->
       if s.cycle <> c + 1
       then
         fail
           (String.concat
              [ "start character at cycle "
              ; Int.to_string s.cycle
              ; ", expected C+1 = "
              ; Int.to_string (c + 1)
              ]);
       (match Dv_xgmii.Xgmii_word.start_lane s.wire with
        | Some 0 -> ()
        | Some lane ->
          fail (String.concat [ "start lane "; Int.to_string lane; ", expected 0" ])
        | None -> fail "unreachable: start_samples was filtered on Some");
       if s.wire.Dv_xgmii.Xgmii_word.control <> 0x01
       then
         fail
           (String.concat
              [ "preamble word control = "
              ; Int.to_string s.wire.Dv_xgmii.Xgmii_word.control
              ; ", expected 1 (bit 0 set, bits 1-7 clear)"
              ]);
       let expected_data = [ 0xFB; 0x55; 0x55; 0x55; 0x55; 0x55; 0x55; 0xD5 ] in
       let got_data = Array.to_list s.wire.Dv_xgmii.Xgmii_word.data in
       if not (List.equal Int.equal got_data expected_data)
       then fail "preamble word data does not match [0xFB; 0x55 x6; 0xD5], lane 0 first"
     | [] -> fail "no word carries a start character"
     | _ :: _ :: _ ->
       fail
         (String.concat
            [ "expected exactly one start character in the run, found "
            ; Int.to_string (List.length start_samples)
            ]));
    (* M04-A2, assertions 6-7: frame octet 0 is at lane 0 of the word at
       cycle C+2; that word carries frame octets 0-7 in lanes 0-7 and no
       control character — the preamble occupies exactly one word and no
       frame octet shares it. *)
    let content = content_octets ~p in
    let expected_word0 = List.take content 8 in
    (match List.find samples ~f:(fun (s : sample) -> s.cycle = c + 2) with
     | None -> fail "no sample at cycle C+2"
     | Some s ->
       if s.wire.Dv_xgmii.Xgmii_word.control <> 0x00
       then
         fail
           (String.concat
              [ "word at C+2 control = "
              ; Int.to_string s.wire.Dv_xgmii.Xgmii_word.control
              ; ", expected 0"
              ]);
       let got_word0 = Array.to_list s.wire.Dv_xgmii.Xgmii_word.data in
       if not (List.equal Int.equal got_word0 expected_word0)
       then fail "word at C+2 does not carry frame octets 0-7 in lanes 0-7");
    (* M04-A5 (NO-ASSERT): every comparison above is stated against C — no
       assertion in this unit names cycle 0 or the release of clear. *)
    assert_instruments_clean t ~row
  | other ->
    fail
      (String.concat
         [ "Bench.run_lengths [60] returned "
         ; Int.to_string (List.length other)
         ; " entries, expected 1"
         ])
;;

let%expect_test
  "M04-A1, M04-A2, M04-A5: the preamble word, the frame's first octet, and \
   the start-up delay that is NOT asserted"
  =
  run_a ();
  [%expect {||}]
;;

(* ---- U19: M04-A3 (WO-0082 §5, §6.4) ---------------------------------------- *)
(* One run, a hundred frames — REQ-201's own §10 hook ("decode 100
   transmitted frames"), and the first assertion that the preamble word is
   the same word every time, over a hundred frames rather than one.
   Driven through {!Bench.run_stream}, WO-0082's own multi-frame
   continuous presenter; every run before this round elaborated exactly
   one frame. Run length 1 227 cycles, 800 source words, one
   elaboration. *)

let row_a3 = "M04-A3"
let fail_a3 msg = failwith (String.concat [ row_a3; ": "; msg ])

let run_a3 () =
  let contents = List.init 100 ~f:(fun _ -> content_octets ~p:60) in
  let _, t, samples = run_stream contents in
  (* Assertion 1: REQ-201's "no start character inside a frame" judgement,
     REQ-204's gap judgement at all 99 gaps, and the conservation count,
     in one call. *)
  assert_instruments_clean_n t ~row:row_a3 ~frames:100;
  (* Assertion 2: Tx_decoder.start_cycles has length exactly 100 —
     REQ-201's §10 hook is "decode 100 transmitted frames" and the count
     is the hook. *)
  let start_cycles = Dv_xgmii.Tx_decoder.start_cycles (decoder t) in
  if List.length start_cycles <> 100
  then
    fail_a3
      (String.concat
         [ "Tx_decoder.start_cycles has "
         ; Int.to_string (List.length start_cycles)
         ; " entries, expected 100"
         ]);
  (* Assertion 3: for each of the 100 start cycles, the raw wire word at
     that cycle carries control = 0x01 (bit 0 set, bits 1-7 clear) and the
     eight preamble octets, lane 0 first, compared with List.equal
     Int.equal — the identical assertion M04-A1 makes once, made a hundred
     times (test_m04_a.ml's own idiom, above). Assertion 4: the failure
     message names the frame index. *)
  let expected_data = [ 0xFB; 0x55; 0x55; 0x55; 0x55; 0x55; 0x55; 0xD5 ] in
  List.iteri start_cycles ~f:(fun frame_idx cyc ->
    match List.find samples ~f:(fun (s : sample) -> s.cycle = cyc) with
    | None ->
      fail_a3
        (String.concat
           [ "frame "
           ; Int.to_string frame_idx
           ; ": no sample at its own start cycle "
           ; Int.to_string cyc
           ])
    | Some s ->
      if s.wire.Dv_xgmii.Xgmii_word.control <> 0x01
      then
        fail_a3
          (String.concat
             [ "frame "
             ; Int.to_string frame_idx
             ; ": preamble word control = "
             ; Int.to_string s.wire.Dv_xgmii.Xgmii_word.control
             ; ", expected 1 (bit 0 set, bits 1-7 clear)"
             ]);
      (match Dv_xgmii.Xgmii_word.start_lane s.wire with
       | Some 0 -> ()
       | Some lane ->
         fail_a3
           (String.concat
              [ "frame "
              ; Int.to_string frame_idx
              ; ": start lane "
              ; Int.to_string lane
              ; ", expected 0"
              ])
       | None ->
         fail_a3
           (String.concat
              [ "frame "; Int.to_string frame_idx; ": no start character at its own start cycle" ]));
      let got_data = Array.to_list s.wire.Dv_xgmii.Xgmii_word.data in
      if not (List.equal Int.equal got_data expected_data)
      then
        fail_a3
          (String.concat
             [ "frame "
             ; Int.to_string frame_idx
             ; ": preamble word data does not match [0xFB; 0x55 x6; 0xD5], lane 0 first"
             ]));
  (* What this unit does NOT assert, and this comment says so: the
     spacings. start_spacings may be read and must not be asserted here —
     a hundred frames at an 11-cycle cadence is REQ-209's sustained claim
     and belongs to the uncommissioned family-I rows (BOUNCE BM8, trap
     T15). M04-F1 asserts one spacing as REQ-204's own verification
     figure, which is a different requirement and a different claim. *)
  ()
;;

let%expect_test
  "M04-A3: a hundred consecutive frames — exactly 100 start characters, \
   every one lane 0 with the identical preamble word"
  =
  run_a3 ();
  [%expect {||}]
;;

(* ---- U27: M04-A4 (WO-0083 §4, §6.7) ----------------------------------------- *)
(* The preamble word after three different predecessors — clear, a normal
   frame, and an UNDERFLOWED frame — compared byte for byte and control bit
   for control bit. One elaboration, run length 59 cycles (WO-0083 §10).
   The third predecessor exists for the first time this round. *)

let row_a4 = "M04-A4"
let fail_a4 msg = failwith (String.concat [ row_a4; ": "; msg ])

let run_a4 () =
  let stall : Stall.t = { frame = 1; word = 4; hold = 1; after = Abandon } in
  let contents = [ content_octets ~p:60; content_octets ~p:60; content_octets ~p:60 ] in
  let _, t, samples = run_scheduled contents stall in
  let c = first_accepted_cycle samples in
  let s0 = c + 1 in
  let s1 = c + 12 in
  let s2 = c + 19 in
  let r = c + 15 in
  (* Assertion 1: the strobe's exact pin, three frames, position 1
     underflowed — a LIST and not a count (a count of one would pass a run
     in which the wrong frame aborted, which at three frames is a live
     possibility, §5.3(6) check 4). *)
  assert_instruments_scheduled
    t
    ~row:row_a4
    ~frames:3
    ~underflowed:[ 1 ]
    ~strobe_events:
      [ underflow_event
          ~frame:1
          ~cycle:r
          ~why:
            "SPEC-M04 §9, 'Strobe cycle, pinned': R = S_1 + w - 1 = (C+12) + 4 - 1 = \
             C+15 (§4.2 fact 1), with S_1 = T_0 + g = (C+10) + 2 = C+12 (§7's C-16 \
             consequence 3, measured at 65ba148)"
      ];
  (* Assertion 2: THE ROW'S OWN CLAIM, and it is the whole unit — the raw
     wire words at C+1, C+12 and C+19 are equal to each other, byte for
     byte and control bit for control bit, AND each equals the REQ-201
     literal. Both comparisons: three identical wrong preambles pass the
     first and fail the second. *)
  let expected_data = [ 0xFB; 0x55; 0x55; 0x55; 0x55; 0x55; 0x55; 0xD5 ] in
  let preamble_at cyc =
    match List.find samples ~f:(fun (s : sample) -> s.cycle = cyc) with
    | None -> fail_a4 (String.concat [ "no sample at cycle "; Int.to_string cyc ])
    | Some s -> s.wire
  in
  let w0 = preamble_at s0 in
  let w1 = preamble_at s1 in
  let w2 = preamble_at s2 in
  let data_of (w : Dv_xgmii.Xgmii_word.t) = Array.to_list w.Dv_xgmii.Xgmii_word.data in
  if not
       (List.equal Int.equal (data_of w0) (data_of w1)
        && List.equal Int.equal (data_of w1) (data_of w2))
  then fail_a4 "the three preamble words' data are not identical to each other";
  if not
       (w0.Dv_xgmii.Xgmii_word.control = w1.Dv_xgmii.Xgmii_word.control
        && w1.Dv_xgmii.Xgmii_word.control = w2.Dv_xgmii.Xgmii_word.control)
  then fail_a4 "the three preamble words' control bits are not identical to each other";
  List.iter
    [ "clear", w0; "a normal frame", w1; "an underflowed frame", w2 ]
    ~f:(fun (predecessor, (w : Dv_xgmii.Xgmii_word.t)) ->
      if w.Dv_xgmii.Xgmii_word.control <> 0x01
      then
        fail_a4
          (String.concat
             [ "preamble word after "
             ; predecessor
             ; ": control = "
             ; Int.to_string w.Dv_xgmii.Xgmii_word.control
             ; ", expected 1 (REQ-201)"
             ]);
      if not (List.equal Int.equal (data_of w) expected_data)
      then
        fail_a4
          (String.concat
             [ "preamble word after "
             ; predecessor
             ; ": data does not match the REQ-201 literal [0xFB; 0x55 x6; 0xD5], lane 0 \
                first"
             ]));
  (* Assertion 3: Xgmii_word.start_lane returns Some 0 at each of the
     three. *)
  List.iter
    [ "clear", w0; "a normal frame", w1; "an underflowed frame", w2 ]
    ~f:(fun (predecessor, (w : Dv_xgmii.Xgmii_word.t)) ->
      match Dv_xgmii.Xgmii_word.start_lane w with
      | Some 0 -> ()
      | Some lane ->
        fail_a4
          (String.concat
             [ "preamble word after "
             ; predecessor
             ; ": start lane = "
             ; Int.to_string lane
             ; ", expected 0"
             ])
      | None ->
        fail_a4 (String.concat [ "preamble word after "; predecessor; ": no start character" ]));
  (* Assertion 4: the three start cycles are C+1, C+12, C+19 —
     Tx_decoder.start_cycles has length exactly 3 and equals that list. *)
  let start_cycles = Dv_xgmii.Tx_decoder.start_cycles (decoder t) in
  if not (List.equal Int.equal start_cycles [ s0; s1; s2 ])
  then
    fail_a4
      (String.concat
         [ "Tx_decoder.start_cycles = ["
         ; String.concat ~sep:"; " (List.map start_cycles ~f:Int.to_string)
         ; "], expected [C+1; C+12; C+19] = ["
         ; String.concat ~sep:"; " (List.map [ s0; s1; s2 ] ~f:Int.to_string)
         ; "]"
         ]);
  (* Assertion 5: the middle frame is the underflowed one — position 1's
     underflowed is true, positions 0 and 2 false, and frame 2's decoded
     octets equal Frame.with_fcs (Frame.pad_to_60 (content_octets
     ~p:60)). *)
  let f0, f1, f2 =
    match wire_frames samples with
    | [ f0; f1; f2 ] -> f0, f1, f2
    | fs ->
      fail_a4
        (String.concat
           [ "wire_frames decoded "; Int.to_string (List.length fs); " frames, expected 3" ])
  in
  if f0.Dv_xgmii.Tx_decoder.underflowed
  then fail_a4 "frame 0's underflowed field is true, expected false";
  if not f1.Dv_xgmii.Tx_decoder.underflowed
  then fail_a4 "frame 1's underflowed field is false, expected true";
  if f2.Dv_xgmii.Tx_decoder.underflowed
  then fail_a4 "frame 2's underflowed field is true, expected false";
  let expected_f2 = Dv_xgmii.Frame.with_fcs (Dv_xgmii.Frame.pad_to_60 (content_octets ~p:60)) in
  if not (List.equal Int.equal f2.Dv_xgmii.Tx_decoder.octets expected_f2)
  then
    fail_a4
      "frame 2's decoded octets do not equal Frame.with_fcs (Frame.pad_to_60 \
       (content_octets ~p:60))";
  (* Assertion 6: gaps is [16; 15], asserted whole — the same design
     serves 16 after a clean terminate at lane 0 and 15 after an abort's
     terminate at lane 1, in one run, which the neighbouring family-F
     unit alone cannot show (it drives only the abort's own gap). *)
  let gaps = Dv_xgmii.Tx_decoder.gaps (decoder t) in
  if not (List.equal Int.equal gaps [ 16; 15 ])
  then
    fail_a4
      (String.concat
         [ "gaps = ["
         ; String.concat ~sep:"; " (List.map gaps ~f:Int.to_string)
         ; "], expected [16; 15]"
         ])
(* What this unit does NOT assert (WO-0083 §6.7): the start spacings — a
   cadence claim over a run belongs to the family whose rows own REQ-209,
   and this unit drives past it (BOUNCE BM8, trap T25); and no value of
   tx_tready at C+12 or anywhere else, though this run's own derivation
   cites it — citing a specification clause in a derivation is not
   asserting the value (BOUNCE BM11). *)
;;

let%expect_test
  "M04-A4: the preamble word after three different predecessors — clear, \
   a normal frame, and an underflowed frame — identical byte for byte and \
   control bit for control bit"
  =
  run_a4 ();
  [%expect {||}]
;;
