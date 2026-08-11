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
