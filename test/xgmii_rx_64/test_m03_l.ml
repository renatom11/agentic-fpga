(** Family L — line rate, constancy and order (M03-L1 … M03-L5), the
    10 000-frame REQ-004 stress run and the length-independence check on top
    of it (WO-0070; ruling BAND A, dv_lead, 2026-08-09T12:10Z, that packet's
    Return log). REQ-004, REQ-005, REQ-019, REQ-020, REQ-103, REQ-111,
    REQ-112, §0.3, §0.5, §0.6; SPEC-M03 §6.1 (the m + 3 formula and its
    gapless qualifier), §7 (the timing contract), §8 (the line-rate stress
    obligation), §9.

    {2 Independence}

    Every expected value below is derived in WO-0070 §§2-8 from
    [test/xgmii_rx_64/bench.mli], [test/xgmii/arrival.mli],
    [test/xgmii/frame.mli] and [test/monitors/octet_time.mli] — the packet's
    own context list — and from the spec sections named above. No
    [libs/**], [top/**] or [rtl_snapshots/**] path was opened to write this
    file (PROTOCOL §10, WO-0070's own context clause). Nothing here takes an
    expected value from [Dv_xgmii.Injection]'s computed outcome model or any
    other model — Family L is not gated by the §7 X-1 bar.

    {2 One run, forced}

    WO-0070 §9: the round's cost is dominated by the drive/sample loop over
    105 010 cycles, and a second unit built on the same 10 000-frame
    schedule would pay that cost again for nothing the first unit did not
    already observe. So M03-L1 through M03-L4 share exactly one schedule and
    one drive/sample call, and their assertions interleave in the fixed
    order WO-0070 §9 states rather than four independent bodies. M03-L5 is a
    different stimulus — 18 short, directed single-frame runs — and gets its
    own unit. *)

open! Base
open Bench

let fail row msg = failwith (String.concat [ row; ": "; msg ])

(* ---- M03-L1, M03-L2, M03-L3, M03-L4 ------------------------------------- *)
(* M03-L1 (REQ-004, §8 checks 1-2): the whole 10 000-frame stress schedule —
   REQ-004's alternating start lanes and 10/11-cycle spacings checked
   against the schedule's own arithmetic, every frame's 8 output words
   (tkeep 0xFF on words 0-6, 0x0F on word 7, tlast on word 7 only,
   tuser[0] = 0), its 60 delivered octets read positionally against
   Arrival's own delivered-octet accessor, and the empty strobe set
   (WO-0070 §4.2: none of the five REQ-008 strobes has a condition able to
   fire on this stimulus).

   M03-L2 (REQ-005, REQ-111, §8 check 3, §0.5): one latency class per start
   lane over the same run — h = 8 with a single latency of 16, h = 12 with a
   single latency of 12, both word delay Some 3, 5 000 frames and 300 000
   octets in each class — matched by its own front-offset field and asserted
   whole, never by list position (WO-0070 §5).

   M03-L3 (REQ-019, §1.1, §7): the whole-run word delay (Some 3), a clean
   tagger, 10 000 frames and 600 000 octets compared. ΔC = 3 against the
   ceiling of 4 is M03's one-cycle reserve (SPEC-M03 §7); WO-0070 §6
   discharges that sentence in the packet itself — it is not a printed
   report and nothing here prints it. This unit's two assertions below pin
   its two operands: the word delay, and the ceiling comparison the tagger
   itself performs against the [~ceiling:4] it was built with.

   M03-L4 (REQ-020, §8 check 2): the delivered frames' own sequence numbers
   (octets 14-17, read back through the frame builder's own decoder), taken
   in tlast order across the run, are exactly 0 .. 9999. WO-0070 §7: on this
   stimulus M03-L4 is implied by M03-L1's own positional content check, and
   this file asserts it directly anyway because REQ-020's own reading is the
   field decoder in delivery order, which is not the octet-equality M03-L1
   already performs.

   Assertion order is WO-0070 §9's own, fixed there rather than chosen here:
   stimulus legality (automatic), schedule shape, frame count out, one
   left-to-right pass over the delivered words asserting each frame's
   content and feeding the standing accounting, the empty strobe set, the
   sequence read-back, the two latency-class records, the whole-run latency
   items, then the standing monitors. *)

let row_l1234 = "M03-L1/L2/L3/L4"

let run_l1_l2_l3_l4 () =
  let sched = Dv_xgmii.Arrival.stress () in
  let bench = create () in
  (* item 1 -- stimulus legality: the drive/sample entry point calls
     Arrival's own conformance check itself and fails before driving a
     single cycle if it is non-empty (bench.mli); no separate call is made
     here. *)
  let samples = run bench sched ~drain:8 () in
  (* item 2 -- schedule shape: frame count, start lanes, start spacings
     (WO-0070 §2.1, §4.1 items 12-13), checked against the schedule's own
     arithmetic rather than assumed. *)
  let frames = Dv_xgmii.Arrival.frames sched in
  if Array.length frames <> 10_000
  then
    fail
      row_l1234
      (String.concat
         [ "schedule carries "; Int.to_string (Array.length frames); " frames, expected 10 000" ]);
  let expected_lanes = List.init 10_000 ~f:(fun i -> if Int.rem i 2 = 0 then 0 else 4) in
  if not (List.equal Int.equal (Dv_xgmii.Arrival.start_lanes sched) expected_lanes)
  then
    fail
      row_l1234
      "start lanes do not alternate 0, 4, 0, 4, ... across all 10 000 frames (REQ-004)";
  let expected_spacings = List.init 9_999 ~f:(fun i -> if Int.rem i 2 = 0 then 10 else 11) in
  if not (List.equal Int.equal (Dv_xgmii.Arrival.start_spacings sched) expected_spacings)
  then fail row_l1234 "start spacings do not alternate 10, 11, 10, 11, ... (REQ-004)";
  (* item 3 -- frame count out: 10 000 tlast words (§4.1 item 2). *)
  let delivered = delivered_samples samples in
  let tlast_count = List.count delivered ~f:(fun s -> s.out.Dv_monitors.Stream_word.tlast) in
  if tlast_count <> 10_000
  then
    fail
      row_l1234
      (String.concat
         [ "10 000 frames presented, "; Int.to_string tlast_count; " tlast words observed" ]);
  (* item 4 -- one left-to-right pass over the delivered words: split the
     shrinking remainder at each frame's own tlast (never re-scan from the
     head), assert its content, feed the standing accounting. Mirrors
     WO-0070 Appendix A's own Φ5 loop shape. *)
  let remainder = ref delivered in
  let sequences = ref [] in
  Array.iter frames ~f:(fun (frame : Dv_xgmii.Arrival.frame) ->
    let group, rest = split_at_first_tlast !remainder in
    remainder := rest;
    let frame_row =
      String.concat [ row_l1234; " (frame "; Int.to_string frame.Dv_xgmii.Arrival.index; ")" ]
    in
    if List.is_empty group then fail frame_row "no output words delivered for this frame";
    if List.length group <> 8
    then
      fail
        frame_row
        (String.concat
           [ "delivered "; Int.to_string (List.length group); " output words, expected 8" ]);
    List.iteri group ~f:(fun m s ->
      let expected_tkeep = if m = 7 then 0x0F else 0xFF in
      if s.out.Dv_monitors.Stream_word.tkeep <> expected_tkeep
      then
        fail
          frame_row
          (String.concat
             [ "word "
             ; Int.to_string m
             ; " tkeep = "
             ; Int.to_string s.out.Dv_monitors.Stream_word.tkeep
             ; ", expected "
             ; Int.to_string expected_tkeep
             ]);
      if m = 7
      then (if not s.out.Dv_monitors.Stream_word.tlast then fail frame_row "word 7 does not carry tlast")
      else if s.out.Dv_monitors.Stream_word.tlast
      then fail frame_row (String.concat [ "word "; Int.to_string m; " unexpectedly carries tlast" ]));
    let last = List.last_exn group in
    if last.out.Dv_monitors.Stream_word.tuser <> 0
    then fail frame_row "tuser[0] set on the tlast word";
    let got = delivered_octets group in
    let expected = Array.to_list (Dv_xgmii.Arrival.delivered frame) in
    if List.length got <> 60
    then
      fail frame_row (String.concat [ "delivered "; Int.to_string (List.length got); " octets, expected 60" ]);
    if not (List.equal Int.equal got expected)
    then fail frame_row "delivered octets do not match Arrival's own delivered-octet accessor, positionally (REQ-103)";
    sequences := Dv_xgmii.Frame.sequence_of got :: !sequences;
    account_clean_frame bench frame group ~aborted:false);
  if not (List.is_empty !remainder)
  then
    fail
      row_l1234
      (String.concat
         [ "test bug -- "
         ; Int.to_string (List.length !remainder)
         ; " output words left over after 10 000 frames"
         ]);
  (* item 5 -- the empty strobe set (WO-0070 §4.2). *)
  if not (List.is_empty (error_pulses samples))
  then fail row_l1234 "an error strobe pulsed on a clean, gapless 10 000-frame run";
  (* item 6 -- M03-L4: the sequence read-back, in tlast order across the
     run, is exactly 0 .. 9999 (REQ-020). *)
  let seq_readback = List.rev !sequences in
  let expected_sequence = List.init 10_000 ~f:(fun i -> i) in
  if not (List.equal Int.equal seq_readback expected_sequence)
  then fail row_l1234 "the delivered frames' own sequence numbers are not exactly 0 .. 9999 in order (REQ-020)";
  (* item 7 -- M03-L2: one latency class per start lane, matched by its own
     front_offset field and asserted whole. *)
  let classes = Dv_monitors.Octet_time.Latency.observed (latency bench) in
  if List.length classes <> 2
  then
    fail
      row_l1234
      (String.concat
         [ "observed "; Int.to_string (List.length classes); " front-offset classes, expected 2" ]);
  let find_class h =
    match
      List.find classes ~f:(fun (c : Dv_monitors.Octet_time.Latency.observed) ->
        c.Dv_monitors.Octet_time.Latency.front_offset = h)
    with
    | Some c -> c
    | None -> fail row_l1234 (String.concat [ "no front-offset class observed for h = "; Int.to_string h ])
  in
  let assert_class ~front_offset ~latency ~frames_n ~octets_n (c : Dv_monitors.Octet_time.Latency.observed) =
    let crow = String.concat [ row_l1234; " (h = "; Int.to_string front_offset; ")" ] in
    if not (List.equal Int.equal c.Dv_monitors.Octet_time.Latency.latencies [ latency ])
    then fail crow "latencies is not the single value this front-offset class must carry (§0.5 Start lanes)";
    (match c.Dv_monitors.Octet_time.Latency.word_delay with
     | Some 3 -> ()
     | Some d -> fail crow (String.concat [ "word_delay = Some "; Int.to_string d; ", expected Some 3" ])
     | None -> fail crow "word_delay = None, expected Some 3");
    if c.Dv_monitors.Octet_time.Latency.frames <> frames_n
    then
      fail
        crow
        (String.concat
           [ "frames = "
           ; Int.to_string c.Dv_monitors.Octet_time.Latency.frames
           ; ", expected "
           ; Int.to_string frames_n
           ]);
    if c.Dv_monitors.Octet_time.Latency.octets <> octets_n
    then
      fail
        crow
        (String.concat
           [ "octets = "
           ; Int.to_string c.Dv_monitors.Octet_time.Latency.octets
           ; ", expected "
           ; Int.to_string octets_n
           ])
  in
  assert_class ~front_offset:8 ~latency:16 ~frames_n:5_000 ~octets_n:300_000 (find_class 8);
  assert_class ~front_offset:12 ~latency:12 ~frames_n:5_000 ~octets_n:300_000 (find_class 12);
  (* item 8 -- M03-L3: the whole-run accessors (REQ-019, §1.1, §7). *)
  (match Dv_monitors.Octet_time.Latency.word_delay (latency bench) with
   | Some 3 -> ()
   | Some d -> fail row_l1234 (String.concat [ "whole-run word_delay = Some "; Int.to_string d; ", expected Some 3" ])
   | None -> fail row_l1234 "whole-run word_delay = None, expected Some 3");
  (match Dv_monitors.Octet_time.Latency.errors (latency bench) with
   | [] -> ()
   | errs -> fail row_l1234 (String.concat [ "latency tagger errors:\n"; String.concat ~sep:"\n" errs ]));
  if Dv_monitors.Octet_time.Latency.frames_compared (latency bench) <> 10_000
  then
    fail
      row_l1234
      (String.concat
         [ "frames_compared = "
         ; Int.to_string (Dv_monitors.Octet_time.Latency.frames_compared (latency bench))
         ; ", expected 10 000"
         ]);
  if Dv_monitors.Octet_time.Latency.octets_compared (latency bench) <> 600_000
  then
    fail
      row_l1234
      (String.concat
         [ "octets_compared = "
         ; Int.to_string (Dv_monitors.Octet_time.Latency.octets_compared (latency bench))
         ; ", expected 600 000"
         ]);
  (* item 9 -- the standing monitors. *)
  assert_monitors_clean bench ~row:row_l1234
;;

let%expect_test
  "M03-L1, M03-L2, M03-L3, M03-L4: 10 000-frame line-rate stress -- sequence \
   order, per-lane latency, the ΔC reserve"
  =
  run_l1_l2_l3_l4 ();
  [%expect {||}]
;;

(* ---- M03-L5 --------------------------------------------------------------- *)
(* "Directed lengths 64 through 71 inclusive (covering all eight tlast
   tkeep patterns) plus 1518, at both start lanes" (REQ-005's verification
   column) through the standing latency tagger — nine lengths times two
   lanes, eighteen independent single-frame runs, each on its own bench
   instance. WO-0070 §3.4: L = 16/12 and word delay 3 hold at every length
   for which the stimulus is gapless and the frame closes cleanly, because
   the derivation cancels the octet position entirely and never mentions
   the frame length — so this row asserts the SAME two constants M03-L2
   pins, at nine lengths instead of one, and its value is in the design
   being asked whether its own delay varies with the final word's residue,
   which a fixed-length stress run cannot see.

   WO-0070 §8.2: this row does NOT re-assert the tkeep pattern or word
   count per length -- those are M03-C1's and M03-C3's own rows, landed
   already, and re-asserting them here would put the same observable under
   two row ids. Per run: the tagger's own errors are empty, it has compared
   exactly one frame, and its single front-offset class carries this lane's
   own h, single latency and word delay -- then the standing monitors. *)

let assert_l5_run ~row bench ~expect_front_offset ~expect_latency =
  (match Dv_monitors.Octet_time.Latency.errors (latency bench) with
   | [] -> ()
   | errs -> fail row (String.concat [ "latency tagger errors:\n"; String.concat ~sep:"\n" errs ]));
  if Dv_monitors.Octet_time.Latency.frames_compared (latency bench) <> 1
  then fail row "frames_compared <> 1 -- the tagger was not fed exactly one frame";
  (match Dv_monitors.Octet_time.Latency.observed (latency bench) with
   | [ c ] ->
     if c.Dv_monitors.Octet_time.Latency.front_offset <> expect_front_offset
     then
       fail
         row
         (String.concat
            [ "front_offset = "
            ; Int.to_string c.Dv_monitors.Octet_time.Latency.front_offset
            ; ", expected "
            ; Int.to_string expect_front_offset
            ]);
     if not (List.equal Int.equal c.Dv_monitors.Octet_time.Latency.latencies [ expect_latency ])
     then
       fail
         row
         (String.concat
            [ "latencies = ["
            ; String.concat ~sep:"; " (List.map c.Dv_monitors.Octet_time.Latency.latencies ~f:Int.to_string)
            ; "], expected ["
            ; Int.to_string expect_latency
            ; "]"
            ]);
     (match c.Dv_monitors.Octet_time.Latency.word_delay with
      | Some 3 -> ()
      | Some d -> fail row (String.concat [ "word_delay = Some "; Int.to_string d; ", expected Some 3" ])
      | None -> fail row "word_delay = None, expected Some 3")
   | classes ->
     fail
       row
       (String.concat
          [ "expected exactly one front-offset class for a single-frame run, observed "
          ; Int.to_string (List.length classes)
          ]));
  assert_monitors_clean bench ~row
;;

let l5_lane_expectation ~lane = if lane = 0 then 8, 16 else 12, 12

let run_l5_directed ~lane =
  let expect_front_offset, expect_latency = l5_lane_expectation ~lane in
  List.iter (run_directed_lengths ~lane) ~f:(fun (length, sched, bench, samples) ->
    let row =
      String.concat [ "M03-L5 (lane "; Int.to_string lane; ", length "; Int.to_string length; ")" ]
    in
    let frame = (Dv_xgmii.Arrival.frames sched).(0) in
    account_clean_frame bench frame samples ~aborted:false;
    assert_l5_run ~row bench ~expect_front_offset ~expect_latency)
;;

let run_l5_1518 ~lane =
  let expect_front_offset, expect_latency = l5_lane_expectation ~lane in
  let row = String.concat [ "M03-L5 (lane "; Int.to_string lane; ", length 1518)" ] in
  let octets = directed_frame_octets ~length:1518 in
  let sched = one_frame ~lane octets in
  let bench = create () in
  let samples = run bench sched ~drain:8 () in
  let frame = (Dv_xgmii.Arrival.frames sched).(0) in
  account_clean_frame bench frame samples ~aborted:false;
  assert_l5_run ~row bench ~expect_front_offset ~expect_latency
;;

let run_l5 () =
  run_l5_directed ~lane:0;
  run_l5_directed ~lane:4;
  run_l5_1518 ~lane:0;
  run_l5_1518 ~lane:4
;;

let%expect_test
  "M03-L5: directed lengths 64 .. 71 and 1518, both start lanes, through the \
   latency tagger"
  =
  run_l5 ();
  [%expect {||}]
;;
