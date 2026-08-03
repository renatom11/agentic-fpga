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
  let r = Int.rem delivered 8 in
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
   4). C1's own "tuser[0] = 0 ... throughout" already covers every length
   including that subset, so M03-C2's FCS-good fact is discharged by the
   same per-length tuser check rather than a second, narrower one — a length
   in the terminate-lane-k>0 subset that fails FCS fails C1's check too,
   there being nothing C2 asks of the wire that C1 does not already ask of
   every length. *)

(* R5-4 (RV-0038-R5): a fail-fast per-length check aborts the whole row at
   the FIRST mismatch and never reaches the other seven lengths, let alone
   the other lane — exactly what left the provisional finding F-M03-1 with
   one data point (lane 0, length 65) out of the sixteen a conformant run
   produces, in run 30772333717. [length_outcome] below is a pure record
   builder: it never raises, so it cannot itself be the reason a length is
   skipped. [run_c1_c2] builds every (lane, length) outcome first and only
   then decides whether to raise — once, with every line — so the complete
   sixteen-entry signature F-M03-1's falsifiable lane-dependent prediction
   needs (65-67 at lane 0, 69-71 at lane 4, or a different pattern, or none)
   is legible from a single CI run regardless of how many entries fail. *)

type length_outcome =
  { lane : int
  ; length : int
  ; expected_delivered : int
  ; observed_delivered : int
  ; expected_tkeep : int
  ; observed_tkeep : int option (* [None] iff no tlast word was observed *)
  ; observed_tuser : int option
  ; terminate_lane : int
  ; error_pulse_count : int
  }

let outcome_ok (o : length_outcome) =
  o.observed_delivered = o.expected_delivered
  && (match o.observed_tkeep with
      | Some tk -> tk = o.expected_tkeep
      | None -> false)
  && (match o.observed_tuser with
      | Some tu -> tu = 0
      | None -> false)
  && o.error_pulse_count = 0
;;

let outcome_line (o : length_outcome) =
  String.concat
    [ (if outcome_ok o then "PASS  " else "FAIL  ")
    ; "lane "
    ; Int.to_string o.lane
    ; " length "
    ; Int.to_string o.length
    ; ": delivered="
    ; Int.to_string o.observed_delivered
    ; "/"
    ; Int.to_string o.expected_delivered
    ; " tkeep="
    ; (match o.observed_tkeep with
       | Some tk -> Int.to_string tk
       | None -> "none")
    ; "/"
    ; Int.to_string o.expected_tkeep
    ; " tuser="
    ; (match o.observed_tuser with
       | Some tu -> Int.to_string tu
       | None -> "none")
    ; " terminate_lane="
    ; Int.to_string o.terminate_lane
    ; " error_pulses="
    ; Int.to_string o.error_pulse_count
    ]
;;

let length_outcome ~lane ~length (frame : Dv_xgmii.Arrival.frame) samples =
  let expected_delivered = length - 4 in
  let observed_delivered = List.length (delivered_octets samples) in
  let expected_tkeep = expected_tkeep_for ~delivered:expected_delivered in
  let terminate_lane = Int.rem (Dv_xgmii.Arrival.terminate_octet_time frame) 8 in
  let observed_tkeep, observed_tuser =
    match tlast_sample samples with
    | None -> None, None
    | Some s ->
      ( Some s.out.Dv_monitors.Stream_word.tkeep
      , Some s.out.Dv_monitors.Stream_word.tuser )
  in
  { lane
  ; length
  ; expected_delivered
  ; observed_delivered
  ; expected_tkeep
  ; observed_tkeep
  ; observed_tuser
  ; terminate_lane
  ; error_pulse_count = List.length (error_pulses samples)
  }
;;

let run_c1_c2 () =
  let per_lane lane =
    List.map (run_directed_lengths ~lane) ~f:(fun (length, sched, bench, samples) ->
      let frame = (Dv_xgmii.Arrival.frames sched).(0) in
      length_outcome ~lane ~length frame samples, bench, frame, samples)
  in
  let lane0 = per_lane 0 in
  let lane4 = per_lane 4 in
  let all = List.append lane0 lane4 in
  let outcomes = List.map all ~f:(fun (o, _, _, _) -> o) in
  (match List.filter outcomes ~f:(fun o -> not (outcome_ok o)) with
   | [] -> ()
   | _ ->
     failwith
       (String.concat
          ~sep:"\n"
          ("M03-C1/M03-C2: per-length signature, both lanes, one run (RV-0038-R5 R5-4):"
           :: List.map outcomes ~f:outcome_line)));
  (* Content is clean at every one of the sixteen (lane, length) pairs.
     D3 (RV-0038 addendum): "covering all eight lanes" (AP-xgmii_rx_64.md's
     own words for this row) is a property of the STIMULUS, not a DUT
     observable — checked here from the SAME outcomes rather than re-derived,
     worded to name the stimulus as the suspect since that is what a failure
     here would mean. *)
  let sorted xs = List.sort xs ~compare:Int.compare in
  let expected_tkeeps = [ 0x0F; 0x1F; 0x3F; 0x7F; 0xFF; 0x01; 0x03; 0x07 ] in
  let expected_lanes = List.init 8 ~f:(fun i -> i) in
  List.iter [ 0, lane0; 4, lane4 ] ~f:(fun (lane, runs) ->
    let outcomes = List.map runs ~f:(fun (o, _, _, _) -> o) in
    (* Every [observed_tkeep] here is [Some _]: the content check above
       already raised if any were [None]. *)
    let observed_tkeeps = List.filter_map outcomes ~f:(fun o -> o.observed_tkeep) in
    let terminate_lanes = List.map outcomes ~f:(fun o -> o.terminate_lane) in
    if not (List.equal Int.equal (sorted observed_tkeeps) (sorted expected_tkeeps))
    then
      failwith
        (String.concat
           [ "M03-C1 (lane "
           ; Int.to_string lane
           ; "): the eight tkeep patterns were not each observed exactly once"
           ]);
    if not (List.equal Int.equal (sorted terminate_lanes) (sorted expected_lanes))
    then
      failwith
        (String.concat
           [ "M03-C1 (lane "
           ; Int.to_string lane
           ; "): STIMULUS bug, not a DUT finding — directed_lengths' terminate lanes were {"
           ; String.concat ~sep:"," (List.map (sorted terminate_lanes) ~f:Int.to_string)
           ; "}, expected each of 0..7 exactly once"
           ]));
  (* Standing-obligation accounting per (lane, length) — deliberately AFTER
     the content-signature and stimulus-coverage checks above: by this point
     every length's delivered-octet count, tkeep, tuser and terminate lane is
     already known good, so a failure from here on is a different,
     already-unambiguous defect class and is allowed to fail fast rather than
     be folded into R5-4's table. *)
  List.iter all ~f:(fun (o, bench, frame, samples) ->
    let row =
      String.concat
        [ "M03-C1 (lane "; Int.to_string o.lane; ", length "; Int.to_string o.length; ")" ]
    in
    account_clean_frame bench frame samples ~aborted:false;
    assert_monitors_clean bench ~row)
;;

let%expect_test
  "M03-C1, M03-C2: directed lengths 64..71 at both lanes — all eight tkeep \
   patterns once each, FCS good where terminate lands past lane 0"
  =
  run_c1_c2 ();
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
     (* RV-0038-R5 / R5-2: the output word's arrival cycle is [s.out_cycle],
        not [s.cycle] (one cycle early — the input cycle that produced it). *)
     if s.out_cycle <> start_cycle + 3
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
