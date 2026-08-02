(** Family C — frame extraction, terminate lanes and tkeep (REQ-103,
    REQ-106, REQ-011, REQ-015). *)

open! Base
open Bench

let fail row msg = failwith (String.concat [ row; ": "; msg ])

(* The tkeep pattern on a frame's tlast word is determined entirely by its
   delivered-octet count (REQ-011: contiguous from bit 0, 1 to 8 ones): a
   run of ((delivered - 1) mod 8) + 1 ones. This is the same fact for
   M03-C1's 60..67 delivered octets, M03-C3's 1514 and M03-C4's 1 — computed
   once here rather than re-derived per row. *)
let expected_tkeep_for ~delivered =
  let r = delivered mod 8 in
  let last_word_octets = if r = 0 then 8 else r in
  (1 lsl last_word_octets) - 1
;;

(* ---- M03-C1, M03-C2 --------------------------------------------------- *)
(* M03-C1: "Lengths 64..71 at both lanes (16 frames) | Delivered octets =
   length - 4 (60..67); the eight tlast tkeep patterns 0x0F, 0x1F, 0x3F,
   0x7F, 0xFF, 0x01, 0x03, 0x07 occur exactly once each; ... tuser[0] = 0
   and no strobe throughout." "Terminate covers all eight lanes" is a fact
   about the stimulus (Arrival lays consecutive lengths at consecutive
   terminate lanes, checked once via Arrival.check per run) rather than a
   separate DUT-observable this test re-derives from the wire: a wrong
   terminate decoder is what a wrong delivered-count or tkeep already kills
   (AP-xgmii_rx_64.md's own Kills cell for this row), which this test
   checks directly at every length.
   M03-C2: "The subset of M03-C1 whose terminate character lands in lane
   k > 0: the k octets are delivered and FCS is good (the C-18 twin)."
   Which lengths are in that subset differs by lane (terminate lane =
   (Arrival.terminate_octet_time frame) mod 8, read from the schedule
   itself rather than re-derived by hand) — exactly one length per lane
   lands its terminate in lane 0 and is excluded (64 at lane 0, 68 at lane
   4), so the FCS-good re-check below runs on 7 of every lane's 8 frames. *)

(* N1 (RV-0038 addendum): returns the OBSERVED tkeep (what the DUT actually
   produced on the tlast word), not the bench's own expected_tkeep_for
   computation — the caller's eight-pattern multiset check compares this
   against expected_tkeeps, and that comparison is only true as its failure
   message claims ("were not each observed exactly once") if what is
   collected really was observed on the wire. The DUT-vs-expected comparison
   below is unchanged and still uses expected_tkeep; only the return value
   changes. *)
let check_directed_length_frame ~row ~length bench (frame : Dv_xgmii.Arrival.frame) samples =
  let expected_delivered = length - 4 in
  let got_octets = delivered_octets samples in
  if List.length got_octets <> expected_delivered
  then
    fail
      row
      (String.concat
         [ "expected "
         ; Int.to_string expected_delivered
         ; " delivered octets, got "
         ; Int.to_string (List.length got_octets)
         ]);
  let expected_tkeep = expected_tkeep_for ~delivered:expected_delivered in
  let observed_tkeep =
    match tlast_sample samples with
    | None -> fail row "no tlast word observed"
    | Some s ->
      if s.out.Dv_monitors.Stream_word.tkeep <> expected_tkeep
      then
        fail
          row
          (String.concat
             [ "tlast word tkeep = "
             ; Int.to_string s.out.Dv_monitors.Stream_word.tkeep
             ; ", expected "
             ; Int.to_string expected_tkeep
             ]);
      if s.out.Dv_monitors.Stream_word.tuser <> 0
      then fail row "tuser[0] set on a legal, standard-FCS frame";
      s.out.Dv_monitors.Stream_word.tkeep
  in
  if not (List.is_empty (error_pulses samples)) then fail row "an error strobe pulsed";
  account_clean_frame bench frame samples ~aborted:false;
  assert_monitors_clean bench ~row;
  observed_tkeep
;;

let run_c1_c2 ~lane =
  let runs = run_directed_lengths ~lane in
  (* [results] pairs each length's observed tkeep with its terminate lane —
     computed once per length, in one pass, rather than re-running
     check_directed_length_frame (which itself drives the standing-monitor
     assertions) a second time to recover the second component. *)
  let results =
    List.map runs ~f:(fun (length, sched, bench, samples) ->
      let row1 =
        String.concat
          [ "M03-C1 (lane "; Int.to_string lane; ", length "; Int.to_string length; ")" ]
      in
      let frame = (Dv_xgmii.Arrival.frames sched).(0) in
      let tkeep = check_directed_length_frame ~row:row1 ~length bench frame samples in
      let terminate_lane = Dv_xgmii.Arrival.terminate_octet_time frame mod 8 in
      if terminate_lane > 0
      then (
        let row2 =
          String.concat
            [ "M03-C2 (lane "; Int.to_string lane; ", length "; Int.to_string length; ")" ]
        in
        match tlast_sample samples with
        | None -> fail row2 "no tlast word observed"
        | Some s ->
          if s.out.Dv_monitors.Stream_word.tuser <> 0
          then fail row2 "FCS verdict bad on a terminate-lane-k>0 frame (the C-18 twin)");
      tkeep, terminate_lane)
  in
  let observed_tkeeps = List.map results ~f:fst in
  let terminate_lanes = List.map results ~f:snd in
  let sorted xs = List.sort xs ~compare:Int.compare in
  let expected_tkeeps = [ 0x0F; 0x1F; 0x3F; 0x7F; 0xFF; 0x01; 0x03; 0x07 ] in
  if not (List.equal Int.equal (sorted observed_tkeeps) (sorted expected_tkeeps))
  then
    failwith
      (String.concat
         [ "M03-C1 (lane "
         ; Int.to_string lane
         ; "): the eight tkeep patterns were not each observed exactly once"
         ]);
  (* D3 (RV-0038 addendum): "covering all eight lanes" (AP-xgmii_rx_64.md's
     own words for this row) is a property of the STIMULUS, not a DUT
     observable — Arrival lays consecutive directed lengths at consecutive
     terminate lanes, and until this assertion nothing noticed if
     directed_lengths or Arrival's gap arithmetic drifted so that fewer than
     eight distinct terminate lanes were actually driven. Worded to name the
     stimulus as the suspect, not the design, since that is what a failure
     here would mean. *)
  let expected_lanes = List.init 8 ~f:(fun i -> i) in
  if not (List.equal Int.equal (sorted terminate_lanes) (sorted expected_lanes))
  then
    failwith
      (String.concat
         [ "M03-C1 (lane "
         ; Int.to_string lane
         ; "): STIMULUS bug, not a DUT finding — directed_lengths' terminate lanes were {"
         ; String.concat ~sep:"," (List.map (sorted terminate_lanes) ~f:Int.to_string)
         ; "}, expected each of 0..7 exactly once"
         ])
;;

let%expect_test
  "M03-C1, M03-C2: directed lengths 64..71 at both lanes — all eight tkeep \
   patterns once each, FCS good where terminate lands past lane 0"
  =
  run_c1_c2 ~lane:0;
  run_c1_c2 ~lane:4;
  [%expect {||}]
;;

(* ---- M03-C3 ------------------------------------------------------------- *)
(* "One 1518-octet frame, both lanes: 1514 octets in 190 words, final tkeep
   0x03." 1514 = 189 full words (1512 octets) + one 2-octet word;
   [expected_tkeep_for ~delivered:1514] gives (1 lsl 2) - 1 = 0x03. *)

let run_c3 ~lane =
  let row = String.concat [ "M03-C3 (lane "; Int.to_string lane; ")" ] in
  let octets = directed_frame_octets ~length:1518 in
  let sched = one_frame ~lane octets in
  let bench = create () in
  let samples = run bench sched ~drain:8 () in
  let words = delivered_samples samples in
  if List.length words <> 190
  then
    fail
      row
      (String.concat [ "expected 190 output words, got "; Int.to_string (List.length words) ]);
  let expected_tkeep = expected_tkeep_for ~delivered:1514 in
  List.iteri words ~f:(fun m s ->
    let is_last = m = 189 in
    let expected = if is_last then expected_tkeep else 0xFF in
    if s.out.Dv_monitors.Stream_word.tkeep <> expected
    then
      fail
        row
        (String.concat
           [ "word "
           ; Int.to_string m
           ; " tkeep = "
           ; Int.to_string s.out.Dv_monitors.Stream_word.tkeep
           ; ", expected "
           ; Int.to_string expected
           ]);
    if is_last
    then (if not s.out.Dv_monitors.Stream_word.tlast then fail row "word 189 does not carry tlast")
    else if s.out.Dv_monitors.Stream_word.tlast
    then fail row (String.concat [ "word "; Int.to_string m; " unexpectedly carries tlast" ]));
  (match tlast_sample samples with
   | None -> fail row "no tlast word observed"
   | Some s ->
     if s.out.Dv_monitors.Stream_word.tuser <> 0 then fail row "tuser[0] set unexpectedly");
  if not (List.is_empty (error_pulses samples)) then fail row "an error strobe pulsed";
  let expected_octets = Dv_xgmii.Frame.delivered octets in
  let got_octets = delivered_octets samples in
  if not (List.equal Int.equal got_octets expected_octets)
  then fail row "delivered octets differ from the injected frame minus its FCS";
  let frame = (Dv_xgmii.Arrival.frames sched).(0) in
  account_clean_frame bench frame samples ~aborted:false;
  assert_monitors_clean bench ~row
;;

let%expect_test "M03-C3: one 1518-octet frame, both lanes — 1514 octets in 190 words" =
  run_c3 ~lane:0;
  run_c3 ~lane:4;
  [%expect {||}]
;;

(* ---- M03-C4 -------------------------------------------------------------- *)
(* "The 5-octet runt: a one-word frame, tkeep 0x01, tlast — legal, and the
   sentence C-11 deleted would have forbidden it." A 5-octet frame is also,
   independently, REQ-107's 5-to-63-octet runt class (this is not a family-F
   row, but the frame it drives cannot help being one): it is forwarded with
   tuser[0] = 1 and exactly one error_runt pulse on its (only) word's cycle
   (SPEC-M03 §9's pinned cycle, "the cycle M03 emits that frame's tlast
   word"). Both facts are asserted; the row's own point — one word, no word
   before it, tkeep = 0x01 — is the first block below. *)

let run_c4 ~lane =
  let row = String.concat [ "M03-C4 (lane "; Int.to_string lane; ")" ] in
  let octets = directed_frame_octets ~length:5 in
  let sched = one_frame ~lane octets in
  let frame = (Dv_xgmii.Arrival.frames sched).(0) in
  let start_cycle = Dv_xgmii.Arrival.start_cycle frame in
  let terminate_cycle = Dv_xgmii.Arrival.terminate_octet_time frame / 8 in
  let expected_pulse_cycle = start_cycle + 3 in
  let bench = create () in
  Dv_monitors.Strobe_monitor.expect
    (strobes bench)
    { Dv_monitors.Strobe_monitor.strobe = "error_runt"
    ; frame = 0
    ; cycle = expected_pulse_cycle
    ; not_before = terminate_cycle
    ; not_after = terminate_cycle + 3
    ; why =
        "REQ-107 (5 octets is a runt, forwarded); SPEC-M03 section 9 'Strobe cycle, \
         pinned' pins it to the cycle the frame's tlast word is emitted, which \
         for this one-word frame is start_cycle + 3"
    };
  let samples = run bench sched ~drain:8 () in
  let words = delivered_samples samples in
  (match words with
   | [ s ] ->
     if s.cycle <> start_cycle + 3
     then fail row "the single output word did not arrive on start_cycle + 3 (REQ-019)";
     if s.out.Dv_monitors.Stream_word.tkeep <> 0x01
     then fail row "tkeep is not 0x01 on the one-word frame";
     if not s.out.Dv_monitors.Stream_word.tlast
     then fail row "the single word does not carry tlast";
     if s.out.Dv_monitors.Stream_word.tuser <> 1
     then fail row "tuser[0] is not set on a runt (REQ-107 forwards it marked invalid)"
   | _ ->
     fail
       row
       (String.concat
          [ "expected exactly one output word (the C-11 legal one-word frame), got "
          ; Int.to_string (List.length words)
          ]));
  let expected_octets = Dv_xgmii.Frame.delivered octets in
  let got_octets = delivered_octets samples in
  if not (List.equal Int.equal got_octets expected_octets)
  then fail row "the delivered octet does not match the injected frame minus its FCS";
  (match error_pulses samples with
   | [ (cycle, name) ] ->
     if not (String.equal name "error_runt")
     then fail row (String.concat [ "expected error_runt, observed "; name ])
     else if cycle <> expected_pulse_cycle
     then
       fail
         row
         (String.concat
            [ "error_runt pulsed on cycle "
            ; Int.to_string cycle
            ; ", expected "
            ; Int.to_string expected_pulse_cycle
            ])
   | pulses ->
     fail
       row
       (String.concat
          [ "expected exactly one strobe pulse (error_runt only), observed "
          ; Int.to_string (List.length pulses)
          ]));
  account_clean_frame bench frame samples ~aborted:true;
  Dv_monitors.Conservation_monitor.strobe_pulse (conservation bench) ~name:"error_runt";
  assert_monitors_clean bench ~row
;;

let%expect_test "M03-C4: the 5-octet runt is a legal one-word frame (C-11)" =
  run_c4 ~lane:0;
  run_c4 ~lane:4;
  [%expect {||}]
;;
