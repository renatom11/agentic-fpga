(** Family A — start detection, alignment and byte order (REQ-101, REQ-012,
    REQ-021, §6.1). *)

open! Base
open Bench

let fail row msg = failwith (String.concat [ row; ": "; msg ])

(* ---- M03-A1, M03-A2 ------------------------------------------------- *)
(* M03-A1: "One 64-octet frame, lane-0 start, gapless, correct FCS | 8
   output words; words 0-6 tkeep = 0xFF, word 7 tkeep = 0x0F carrying octets
   56-59 with tlast = 1 and tuser[0] = 0; output word m on cycle m + 3
   counted from the start word; no strobe."
   M03-A2: the same 64 octets at a lane-4 start — same tuples, word 0 on
   cycle 3, and "FCS verdict good" is the row's own point (the C-18 kill: a
   design holding the CRC register across the second preamble word's four
   frame octets fails the FCS check of every lane-4 frame). *)

let run_a1_a2 ~lane =
  let row = String.concat [ "M03-A1/A2 (lane "; Int.to_string lane; ")" ] in
  let octets = directed_frame_octets ~length:64 in
  let sched = one_frame ~lane octets in
  let frame = (Dv_xgmii.Arrival.frames sched).(0) in
  let start_cycle = Dv_xgmii.Arrival.start_cycle frame in
  let bench = create () in
  let samples = run bench sched ~drain:8 () in
  let words = delivered_samples samples in
  if List.length words <> 8
  then fail row (String.concat [ "expected 8 output words, got "; Int.to_string (List.length words) ]);
  List.iteri words ~f:(fun m s ->
    let expected_cycle = start_cycle + 3 + m in
    (* RV-0038-R6 / R6-1: word m's arrival cycle is an OUTPUT timing fact,
       read from the [Before] view, so it is [s.cycle] directly — no
       relabelling, since [Before]'s [cycle] already is the cycle the word
       belongs to. *)
    if s.cycle <> expected_cycle
    then
      fail
        row
        (String.concat
           [ "word "
           ; Int.to_string m
           ; " expected on cycle "
           ; Int.to_string expected_cycle
           ; ", observed on cycle "
           ; Int.to_string s.cycle
           ]);
    let expected_tkeep = if m = 7 then 0x0F else 0xFF in
    if s.out.Dv_monitors.Stream_word.tkeep <> expected_tkeep
    then
      fail
        row
        (String.concat
           [ "word "
           ; Int.to_string m
           ; " tkeep = "
           ; Int.to_string s.out.Dv_monitors.Stream_word.tkeep
           ; ", expected "
           ; Int.to_string expected_tkeep
           ]);
    if m = 7
    then (
      if not s.out.Dv_monitors.Stream_word.tlast then fail row "word 7 does not carry tlast")
    else if s.out.Dv_monitors.Stream_word.tlast
    then fail row (String.concat [ "word "; Int.to_string m; " unexpectedly carries tlast" ]));
  (match tlast_sample samples with
   | None -> fail row "no tlast word observed"
   | Some s ->
     if s.out.Dv_monitors.Stream_word.tuser <> 0
     then fail row "tuser[0] set — FCS verdict bad (this is the C-18 kill at lane 4)");
  if not (List.is_empty (error_pulses samples)) then fail row "an error strobe pulsed";
  let expected_octets = Dv_xgmii.Frame.delivered octets in
  let got_octets = delivered_octets samples in
  if not (List.equal Int.equal got_octets expected_octets)
  then fail row "delivered octets differ from the injected frame minus its FCS";
  account_clean_frame bench frame samples ~aborted:false;
  assert_monitors_clean bench ~row
;;

let%expect_test
  "M03-A1, M03-A2: 64-octet frame at both start lanes — 8 words, tkeep/tlast \
   pattern, m+3 timing, FCS good at lane 4 (the C-18 kill)"
  =
  run_a1_a2 ~lane:0;
  run_a1_a2 ~lane:4;
  [%expect {||}]
;;

(* ---- M03-A3, M03-A4 --------------------------------------------------- *)
(* M03-A3: the C1 directed-length set (64..71 octets) driven at both start
   lanes; the two runs equal as ordered (tdata, tkeep, tlast, tuser)
   sequences, length by length.
   M03-A4 (NO-ASSERT): "The absolute cycle of the first output word is NOT
   asserted equal between the lanes" (§6.1, §10's REQ-101 hook). This test
   never compares lane 0's absolute cycle against lane 4's; the positive
   fact it asserts instead is that EACH lane independently satisfies its
   own ΔC = 3 from its OWN start cycle (REQ-019) — a true, useful, strictly
   single-lane fact that is not the forbidden cross-lane comparison. *)

let tuple_of_sample (s : sample) =
  ( Dv_monitors.Stream_word.octets s.out
  , s.out.Dv_monitors.Stream_word.tkeep
  , s.out.Dv_monitors.Stream_word.tlast
  , s.out.Dv_monitors.Stream_word.tuser )
;;

let tuple_equal (o1, k1, l1, u1) (o2, k2, l2, u2) =
  List.equal Int.equal o1 o2 && k1 = k2 && Bool.equal l1 l2 && u1 = u2
;;

let assert_own_deltac ~row (sched : Dv_xgmii.Arrival.t) samples =
  let frame = (Dv_xgmii.Arrival.frames sched).(0) in
  let start_cycle = Dv_xgmii.Arrival.start_cycle frame in
  match delivered_samples samples with
  | [] -> fail row "no output word to check ΔC against"
  | first :: _ ->
    (* RV-0038-R6 / R6-1: ΔC is measured against the OUTPUT word's true
       arrival cycle, [cycle], read from the [Before] view — no relabelling
       is needed, since [Before]'s [cycle] already is that arrival cycle. *)
    let observed = first.cycle - start_cycle in
    if observed <> 3
    then
      fail
        row
        (String.concat
           [ "word 0 arrived ΔC = "
           ; Int.to_string observed
           ; " cycles after this lane's OWN start cycle, expected 3 (REQ-019)"
           ])
;;

let run_a3_a4 () =
  let lane0 = run_directed_lengths ~lane:0 in
  let lane4 = run_directed_lengths ~lane:4 in
  List.iter2_exn lane0 lane4 ~f:(fun (len0, sched0, bench0, samples0) (len4, sched4, bench4, samples4) ->
    if len0 <> len4 then failwith "M03-A3: directed length sets diverged between the two lanes";
    let row3 = String.concat [ "M03-A3 (length "; Int.to_string len0; ")" ] in
    let seq0 = List.map (delivered_samples samples0) ~f:tuple_of_sample in
    let seq4 = List.map (delivered_samples samples4) ~f:tuple_of_sample in
    if not (List.equal tuple_equal seq0 seq4)
    then fail row3 "lane-0 and lane-4 (octets, tkeep, tlast, tuser) sequences differ";
    let frame0 = (Dv_xgmii.Arrival.frames sched0).(0) in
    let frame4 = (Dv_xgmii.Arrival.frames sched4).(0) in
    account_clean_frame bench0 frame0 samples0 ~aborted:false;
    account_clean_frame bench4 frame4 samples4 ~aborted:false;
    assert_monitors_clean bench0 ~row:(String.concat [ row3; " lane 0" ]);
    assert_monitors_clean bench4 ~row:(String.concat [ row3; " lane 4" ]);
    let row4 = String.concat [ "M03-A4 (length "; Int.to_string len0; ")" ] in
    assert_own_deltac ~row:(String.concat [ row4; " lane 0" ]) sched0 samples0;
    assert_own_deltac ~row:(String.concat [ row4; " lane 4" ]) sched4 samples4)
;;

let%expect_test
  "M03-A3: directed lengths 64..71 equal as tuple sequences at both lanes; \
   M03-A4: no cross-lane absolute-cycle comparison is made"
  =
  run_a3_a4 ();
  [%expect {||}]
;;

(* ---- M03-A5 ------------------------------------------------------------ *)
(* "A 64-octet frame whose octets are position-dependent (Frame.stress_frame's
   default filler), at both start lanes | Frame octet j appears at
   tdata[8*(j mod 8)+7 : 8*(j mod 8)] of word floor(j/8); octet 0 at
   tdata[7:0] of word 0." Position-dependent filler is the point: a lane
   reversal, a byte-swapped word or a rotation by 4 at a lane-0 start are all
   invisible under uniform filler (AP-xgmii_rx_64.md's own reasoning), which
   is exactly why this row does not reuse M03-A1/A2's simpler content. *)

let run_a5 ~lane =
  let row = String.concat [ "M03-A5 (lane "; Int.to_string lane; ")" ] in
  let octets = Dv_xgmii.Frame.stress_frame ~sequence:lane () in
  let sched = one_frame ~lane octets in
  let bench = create () in
  let samples = run bench sched ~drain:8 () in
  let expected = Dv_xgmii.Frame.delivered octets in
  let got = delivered_octets samples in
  if not (List.equal Int.equal got expected)
  then fail row "delivered octet j is not the position-dependent filler's octet j";
  (* REQ-012/REQ-021 restated per word: word m's kept octets, in ascending
     tdata position order, are exactly expected octets [8m .. 8m+keep-1] —
     the same fact as above, checked word by word so a lane rotation inside
     one word (invisible in the concatenated form only if it happened to
     rotate onto an equal-valued neighbour, which the position-dependent
     filler makes impossible) is caught at the word it occurs in. *)
  List.iteri (delivered_samples samples) ~f:(fun m s ->
    let word_octets = Dv_monitors.Stream_word.octets s.out in
    let expected_word =
      List.take (List.drop expected (8 * m)) (List.length word_octets)
    in
    if not (List.equal Int.equal word_octets expected_word)
    then fail row (String.concat [ "word "; Int.to_string m; " byte order is wrong" ]));
  (match tlast_sample samples with
   | None -> fail row "no tlast word observed"
   | Some s ->
     if s.out.Dv_monitors.Stream_word.tuser <> 0 then fail row "tuser[0] set unexpectedly");
  if not (List.is_empty (error_pulses samples)) then fail row "an error strobe pulsed";
  let frame = (Dv_xgmii.Arrival.frames sched).(0) in
  account_clean_frame bench frame samples ~aborted:false;
  assert_monitors_clean bench ~row
;;

let%expect_test "M03-A5: position-dependent filler pins byte order and lane placement" =
  run_a5 ~lane:0;
  run_a5 ~lane:4;
  [%expect {||}]
;;
