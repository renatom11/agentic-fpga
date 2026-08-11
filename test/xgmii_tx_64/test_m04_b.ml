(** Family B — frame octets, [tkeep] and the word cadence (REQ-012, REQ-021,
    REQ-011, REQ-015). Three units: U3 (M04-B1), U4 (M04-B2), U5 (M04-B4,
    M04-B5 — the directed length set, run last in this file because it is
    the expensive one, WO-0080 §16.1). *)

open! Base
open Bench

let fail row msg = failwith (String.concat [ row; ": "; msg ])

(* The raw byte at [lane] of [wire], regardless of whether it is a data or a
   control character — [Xgmii_word.t]'s own "data array" sense (§6.2
   assertion 5's own reading), reached through the accessor function rather
   than the raw record field. *)
let octet_value wire lane =
  match Dv_xgmii.Xgmii_word.lane wire lane with
  | Dv_xgmii.Xgmii_word.Data d -> d
  | Dv_xgmii.Xgmii_word.Control d -> d
;;

(* ---- U3: M04-B1 --------------------------------------------------------- *)
(* One run, P = 60, position-dependent content (WO-0080 §6.3). *)

let run_b1 () =
  let row = "M04-B1" in
  let p = 60 in
  match run_lengths [ p ] with
  | [ (_, t, samples) ] ->
    let c = first_accepted_cycle samples in
    let content = content_octets ~p in
    (* Every (idx, value) pair among the eight consecutive frame/FCS words
       C+2 .. C+9 — the window WO-0080 §6.3 assertion 2 names as
       "all-data". *)
    let positions =
      List.concat_map (List.range (c + 2) (c + 10)) ~f:(fun cyc ->
        match List.find samples ~f:(fun (s : sample) -> s.cycle = cyc) with
        | None -> fail row (String.concat [ "no sample at cycle "; Int.to_string cyc ])
        | Some s ->
          List.init 8 ~f:(fun lane -> (8 * (cyc - (c + 2))) + lane, octet_value s.wire lane))
    in
    (* Assertion 1's uniqueness half is scoped to indices 0..59 — the FCS
       (indices 60..63) is EXCLUDED, because it is a computed value that may
       legitimately equal a content octet by coincidence: the same
       arithmetic-falsifiability reasoning WO-0080 §6.0(c) states for the
       poison scan (trap T5), applied here to content values rather than to
       the poison value, since this row's own uniqueness claim did not name
       that exclusion but the ground is identical. *)
    let frame_positions = List.filter positions ~f:(fun (idx, _) -> idx < 60) in
    List.iteri content ~f:(fun j octet ->
      (match List.find frame_positions ~f:(fun (idx, _) -> idx = j) with
       | None ->
         fail row (String.concat [ "no position recorded for frame octet "; Int.to_string j ])
       | Some (_, got) ->
         if got <> octet
         then
           fail
             row
             (String.concat
                [ "frame octet "
                ; Int.to_string j
                ; " (predicted lane "
                ; Int.to_string (Int.rem j 8)
                ; " of cycle "
                ; Int.to_string (c + 2 + (j / 8))
                ; ") = "
                ; Int.to_string got
                ; ", expected "
                ; Int.to_string octet
                ]));
      let occurrences = List.count frame_positions ~f:(fun (_, v) -> v = octet) in
      if occurrences <> 1
      then
        fail
          row
          (String.concat
             [ "content octet "
             ; Int.to_string octet
             ; " (frame index "
             ; Int.to_string j
             ; ") appears "
             ; Int.to_string occurrences
             ; " times among the frame-octet positions (indices 0..59), expected \
                exactly 1"
             ]));
    (* Assertion 2: control = 0x00 on every word at cycles C+2 .. C+9. *)
    List.iter (List.range (c + 2) (c + 10)) ~f:(fun cyc ->
      match List.find samples ~f:(fun (s : sample) -> s.cycle = cyc) with
      | None -> fail row (String.concat [ "no sample at cycle "; Int.to_string cyc ])
      | Some s ->
        if s.wire.Dv_xgmii.Xgmii_word.control <> 0x00
        then
          fail
            row
            (String.concat
               [ "word at cycle "
               ; Int.to_string cyc
               ; " control = "
               ; Int.to_string s.wire.Dv_xgmii.Xgmii_word.control
               ; ", expected 0"
               ]));
    (* Assertion 3: control = 0xFF on the word at cycle C+10 (/T/ in lane 0,
       /I/ in lanes 1-7 — all control). *)
    (match List.find samples ~f:(fun (s : sample) -> s.cycle = c + 10) with
     | None -> fail row "no sample at cycle C+10"
     | Some s ->
       if s.wire.Dv_xgmii.Xgmii_word.control <> 0xFF
       then
         fail
           row
           (String.concat
              [ "word at C+10 control = "
              ; Int.to_string s.wire.Dv_xgmii.Xgmii_word.control
              ; ", expected 0xFF"
              ]));
    assert_instruments_clean t ~row
  | other ->
    fail
      "M04-B1"
      (String.concat
         [ "Bench.run_lengths [60] returned "
         ; Int.to_string (List.length other)
         ; " entries, expected 1"
         ])
;;

let%expect_test
  "M04-B1: position-dependent content pins lane and cycle placement, and no \
   other placement"
  =
  run_b1 ();
  [%expect {||}]
;;

(* ---- U4: M04-B2 --------------------------------------------------------- *)
(* One run, P = 20, the poisoned tlast word — tkeep = 0x0F, positions 4-7 of
   the final source word poisoned by Bench.source_words itself (WO-0080
   §6.4). *)

let run_b2 () =
  let row = "M04-B2" in
  let p = 20 in
  match run_lengths [ p ] with
  | [ (_, t, samples) ] ->
    let c = first_accepted_cycle samples in
    (* Assertion 1: 3 words accepted, at cycles C, C+1, C+2 — P-ACCEPT
       already guarantees this; checked directly here as the row's own
       observable. *)
    let accepted = List.filter samples ~f:(fun (s : sample) -> s.accepted) in
    if List.length accepted <> 3
    then
      fail
        row
        (String.concat
           [ "accepted word count = "
           ; Int.to_string (List.length accepted)
           ; ", expected 3"
           ]);
    List.iteri accepted ~f:(fun m (s : sample) ->
      if s.cycle <> c + m
      then
        fail
          row
          (String.concat
             [ "accepted word "
             ; Int.to_string m
             ; " at cycle "
             ; Int.to_string s.cycle
             ; ", expected C+"
             ; Int.to_string m
             ]));
    (* Assertions 2-3: wire octets 16-19 = content 16..19 at lanes 0-3, and
       wire octets 20-23 = 0x00 (pad) at lanes 4-7, of the SAME word C+4 —
       the sharp case, since the tlast word's kept octets and the first four
       pad octets share this one word. *)
    let content = content_octets ~p in
    (match List.find samples ~f:(fun (s : sample) -> s.cycle = c + 4) with
     | None -> fail row "no sample at cycle C+4"
     | Some s ->
       let kept = List.init 4 ~f:(fun lane -> octet_value s.wire lane) in
       let expected_kept = List.sub content ~pos:16 ~len:4 in
       if not (List.equal Int.equal kept expected_kept)
       then fail row "wire octets 16-19 (lanes 0-3 of C+4) do not equal the source content";
       let pad = List.init 4 ~f:(fun lane -> octet_value s.wire (lane + 4)) in
       if not (List.for_all pad ~f:(fun o -> o = 0))
       then fail row "wire octets 20-23 (lanes 4-7 of C+4) are not all 0x00");
    (* Assertion 4: the poison value appears nowhere among wire octets
       0..F-5 (F = 64 here; §6.0(c) excludes the four FCS octets). *)
    let frame = wire_frame samples in
    let scan = List.sub frame.Dv_xgmii.Tx_decoder.octets ~pos:0 ~len:60 in
    if List.exists scan ~f:(fun o -> o = poison)
    then fail row "poison value present among wire octets 0..59";
    (* Assertion 5: 64 octets DA through FCS. *)
    if List.length frame.Dv_xgmii.Tx_decoder.octets <> 64
    then
      fail
        row
        (String.concat
           [ "wire octet count = "
           ; Int.to_string (List.length frame.Dv_xgmii.Tx_decoder.octets)
           ; ", expected 64"
           ]);
    assert_instruments_clean t ~row
  | other ->
    fail
      "M04-B2"
      (String.concat
         [ "Bench.run_lengths [20] returned "
         ; Int.to_string (List.length other)
         ; " entries, expected 1"
         ])
;;

let%expect_test
  "M04-B2: the poisoned tlast word — exactly four kept octets, poison nowhere"
  =
  run_b2 ();
  [%expect {||}]
;;

(* ---- U5: M04-B4, M04-B5 -------------------------------------------------- *)
(* Eight runs, the directed set P in {1, 20, 59, 60, 61, 64, 67, 1514}, each
   on a fresh Bench.t via Bench.run_lengths (WO-0080 §6.5, §5.7's shared
   runner). *)

let directed_lengths = [ 1; 20; 59; 60; 61; 64; 67; 1514 ]

let run_b4_b5 () =
  let runs = run_lengths directed_lengths in
  List.iter runs ~f:(fun (p, t, samples) ->
    let row = String.concat [ "M04-B4/B5 (P="; Int.to_string p; ")" ] in
    let c = first_accepted_cycle samples in
    let f = Int.max p 60 + 4 in
    let terminate_cycle = c + 2 + (f / 8) in
    let terminate_lane = Int.rem f 8 in
    let frame = wire_frame samples in
    (* Assertions 1-3: the terminate character's octet index (F, implicit in
       the wire-octet-count check below), its cycle, and its lane. *)
    if frame.Dv_xgmii.Tx_decoder.terminate_cycle <> terminate_cycle
    then
      fail
        row
        (String.concat
           [ "terminate cycle = "
           ; Int.to_string frame.Dv_xgmii.Tx_decoder.terminate_cycle
           ; ", expected C+2+floor(F/8) = "
           ; Int.to_string terminate_cycle
           ]);
    if frame.Dv_xgmii.Tx_decoder.terminate_lane <> terminate_lane
    then
      fail
        row
        (String.concat
           [ "terminate lane = "
           ; Int.to_string frame.Dv_xgmii.Tx_decoder.terminate_lane
           ; ", expected F mod 8 = "
           ; Int.to_string terminate_lane
           ]);
    (* Assertion 4: the control bit for the terminate lane is set on the
       terminate word, read directly off the sample rather than trusted
       solely from the decoder's own detection. *)
    (match List.find samples ~f:(fun (s : sample) -> s.cycle = terminate_cycle) with
     | None -> fail row "no sample at the predicted terminate cycle"
     | Some s ->
       if not (Dv_xgmii.Xgmii_word.is_control s.wire terminate_lane)
       then fail row "the predicted terminate lane does not carry a control character");
    (* Assertion 5: List.length frame.octets = F. *)
    if List.length frame.Dv_xgmii.Tx_decoder.octets <> f
    then
      fail
        row
        (String.concat
           [ "wire octet count = "
           ; Int.to_string (List.length frame.Dv_xgmii.Tx_decoder.octets)
           ; ", expected F = "
           ; Int.to_string f
           ]);
    (* Assertion 6: wire octets 0..F-5 = pad_to_60(content_octets ~p). *)
    let expected_prefix = Dv_xgmii.Frame.pad_to_60 (content_octets ~p) in
    let got_prefix = List.take frame.Dv_xgmii.Tx_decoder.octets (f - 4) in
    if not (List.equal Int.equal got_prefix expected_prefix)
    then fail row "wire octets 0..F-5 do not equal pad_to_60(content) (REQ-011, REQ-015, §6.1)";
    (* M04-B5's own three claims land at the P = 1514 member by
       construction: 1514 frame octets and no pad octet follow from the
       prefix check above (Frame.pad_to_60 is the identity at 1514 >= 60
       octets, so the comparison above already proves no padding was
       inserted); terminate lane 6 is the general terminate_lane check.
       WO-0080 §6.5's own caution: this round makes NO length-threshold
       claim — nothing here asserts a maximum frame length or a
       truncation. *)
    assert_instruments_clean t ~row)
;;

let%expect_test
  "M04-B4, M04-B5: the directed length set — terminate octet index, cycle \
   and lane; wire octets 0..F-5 equal the padded content; the maximum \
   frame, no pad octet, no length threshold claimed"
  =
  run_b4_b5 ();
  [%expect {||}]
;;

(* ---- U20: M04-B3 (WO-0082 §5, §6.5) ---------------------------------------- *)
(* Two runs, both orders. Per-frame length independence: a design whose
   length counter or CRC register is not re-seeded between frames produces
   a wrong FCS or a wrong terminate lane on the SECOND frame, and the
   Kills cell says in terms that a bench driving one order tests one of
   the two defects: long-then-short is the direction a stale counter
   produces a conformant-looking SHORT frame, short-then-long the
   direction it produces a visible OVER-RUN. Driven through
   {!Bench.run_stream}, WO-0082's own multi-frame continuous presenter.
   Two elaborations, run length 232 each. This unit does not re-discharge
   family D: M04-D1 is discharged and stays discharged, nothing here is
   described as adding to it (BOUNCE BM8). *)

type b3_run =
  { name : string
  ; p1 : int
  ; p2 : int
  ; t1_cycle_off : int
  ; t1_lane : int
  ; s2_off : int
  ; t2_cycle_off : int
  ; t2_lane : int
  }

(* WO-0082 §6.5's own table, transcribed literally. *)
let b3_runs =
  [ { name = "long -> short"
    ; p1 = 1514
    ; p2 = 20
    ; t1_cycle_off = 191
    ; t1_lane = 6
    ; s2_off = 194
    ; t2_cycle_off = 203
    ; t2_lane = 0
    }
  ; { name = "short -> long"
    ; p1 = 20
    ; p2 = 1514
    ; t1_cycle_off = 10
    ; t1_lane = 0
    ; s2_off = 12
    ; t2_cycle_off = 202
    ; t2_lane = 6
    }
  ]
;;

let run_b3_one (r : b3_run) =
  let row = String.concat [ "M04-B3 ("; r.name; ")" ] in
  let _, t, samples = run_stream [ content_octets ~p:r.p1; content_octets ~p:r.p2 ] in
  let c = first_accepted_cycle samples in
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
  let f1_expected_len = Int.max r.p1 60 + 4 in
  let f2_expected_len = Int.max r.p2 60 + 4 in
  (* Each frame's decoded octet count equals its own F. *)
  if List.length f1.Dv_xgmii.Tx_decoder.octets <> f1_expected_len
  then
    fail
      row
      (String.concat
         [ "frame 1 wire octet count = "
         ; Int.to_string (List.length f1.Dv_xgmii.Tx_decoder.octets)
         ; ", expected F1 = "
         ; Int.to_string f1_expected_len
         ]);
  if List.length f2.Dv_xgmii.Tx_decoder.octets <> f2_expected_len
  then
    fail
      row
      (String.concat
         [ "frame 2 wire octet count = "
         ; Int.to_string (List.length f2.Dv_xgmii.Tx_decoder.octets)
         ; ", expected F2 = "
         ; Int.to_string f2_expected_len
         ]);
  (* Each terminate character is at its own F mod 8. *)
  if f1.Dv_xgmii.Tx_decoder.terminate_lane <> Int.rem f1_expected_len 8
  then
    fail
      row
      (String.concat
         [ "frame 1 terminate lane = "
         ; Int.to_string f1.Dv_xgmii.Tx_decoder.terminate_lane
         ; ", expected F1 mod 8 = "
         ; Int.to_string (Int.rem f1_expected_len 8)
         ]);
  if f2.Dv_xgmii.Tx_decoder.terminate_lane <> Int.rem f2_expected_len 8
  then
    fail
      row
      (String.concat
         [ "frame 2 terminate lane = "
         ; Int.to_string f2.Dv_xgmii.Tx_decoder.terminate_lane
         ; ", expected F2 mod 8 = "
         ; Int.to_string (Int.rem f2_expected_len 8)
         ]);
  (* The run law's own cycles (WO-0082 §6.5's table), cross-checked
     against the packet's derivation rather than re-derived from a
     formula here. *)
  if f1.Dv_xgmii.Tx_decoder.terminate_cycle <> c + r.t1_cycle_off
  then
    fail
      row
      (String.concat
         [ "frame 1 terminate cycle = "
         ; Int.to_string f1.Dv_xgmii.Tx_decoder.terminate_cycle
         ; ", expected C+"
         ; Int.to_string r.t1_cycle_off
         ]);
  if f1.Dv_xgmii.Tx_decoder.terminate_lane <> r.t1_lane
  then
    fail
      row
      (String.concat
         [ "frame 1 terminate lane = "
         ; Int.to_string f1.Dv_xgmii.Tx_decoder.terminate_lane
         ; ", expected "
         ; Int.to_string r.t1_lane
         ]);
  if f2.Dv_xgmii.Tx_decoder.start_cycle <> c + r.s2_off
  then
    fail
      row
      (String.concat
         [ "frame 2 start cycle = "
         ; Int.to_string f2.Dv_xgmii.Tx_decoder.start_cycle
         ; ", expected C+"
         ; Int.to_string r.s2_off
         ]);
  if f2.Dv_xgmii.Tx_decoder.terminate_cycle <> c + r.t2_cycle_off
  then
    fail
      row
      (String.concat
         [ "frame 2 terminate cycle = "
         ; Int.to_string f2.Dv_xgmii.Tx_decoder.terminate_cycle
         ; ", expected C+"
         ; Int.to_string r.t2_cycle_off
         ]);
  if f2.Dv_xgmii.Tx_decoder.terminate_lane <> r.t2_lane
  then
    fail
      row
      (String.concat
         [ "frame 2 terminate lane = "
         ; Int.to_string f2.Dv_xgmii.Tx_decoder.terminate_lane
         ; ", expected "
         ; Int.to_string r.t2_lane
         ]);
  (* Each frame's decoded octets equal Frame.with_fcs (Frame.pad_to_60
     content) for its OWN p — M04-B3's second-frame independence claim: a
     design whose CRC register or length counter is not re-seeded between
     frames produces a wrong FCS on frame 2, and the row's Kills cell
     names exactly that. *)
  let expected1 = Dv_xgmii.Frame.with_fcs (Dv_xgmii.Frame.pad_to_60 (content_octets ~p:r.p1)) in
  let expected2 = Dv_xgmii.Frame.with_fcs (Dv_xgmii.Frame.pad_to_60 (content_octets ~p:r.p2)) in
  if not (List.equal Int.equal f1.Dv_xgmii.Tx_decoder.octets expected1)
  then
    fail
      row
      "frame 1's decoded octets do not equal Frame.with_fcs (Frame.pad_to_60 content) for its \
       own P";
  if not (List.equal Int.equal f2.Dv_xgmii.Tx_decoder.octets expected2)
  then
    fail
      row
      "frame 2's decoded octets do not equal Frame.with_fcs (Frame.pad_to_60 content) for its \
       own P"
;;

let run_b3 () = List.iter b3_runs ~f:run_b3_one

let%expect_test
  "M04-B3: per-frame length independence, both orders — each frame's own \
   F octet count and its own terminate lane"
  =
  run_b3 ();
  [%expect {||}]
;;
