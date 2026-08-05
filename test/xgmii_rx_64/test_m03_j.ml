(** Family J — the `cfg_rx_enable` disable path (REQ-810, REQ-803, REQ-802;
    SPEC-M03 §4.3, §6.1's "When `cfg_rx_enable` is 0" paragraph, §6.2's
    `Idle`/`Preamble`/`Frame` rows, §6.3 item 7, §7's configuration-sampling
    bullet, §9's closure-list clause (b), §10's REQ-802/REQ-810 hook;
    requirements.md §0.6, §0.7, §12; ADR-0014 in full). WO-0067.

    Three rows, three units, over the {!Bench.Enable} capability WO-0067
    adds: M03-J1 (the disable window's silence, [run_j1]), M03-J2 (the
    frame admitted after re-enable, [run_j2]), M03-J3 (the in-flight frame
    completing under the old value, both start lanes, [run_j3]).

    {2 J1 and J2 share one stimulus (§5.1)}

    requirements.md REQ-810's own verification column commissions ONE
    experiment for both rows: drive the enable to 0 with no frame in
    flight, inject 100 frames, assert silence; re-enable and check the next
    frame. [j1_j2_stimulus] derives and checks the schedule, frame 100 and
    the disable-then-re-enable {!Bench.Enable.t} ONCE, so the one number
    both rows must agree on (the change cycle) cannot drift between two
    independent hand-derivations — the failure mode §1.3(d) of WO-0067
    rejects a closure argument for.

    {2 What this file does NOT claim (WO-0067 §6)}

    M03-J2's Kills cell in `AP-xgmii_rx_64.md` ("a design that samples the
    enable continuously and truncates the frame it just admitted") is
    unreachable under M03-J2's own stimulus: the enable is 1 for the whole
    of frame 100's admitted extent, so a continuously-sampling design
    truncates nothing. That class is M03-J3's, not this row's, and neither
    an assertion, a comment nor this docstring claims otherwise anywhere in
    this file. The honest kill for M03-J2 is named at [run_j2]'s own site.

    {2 Traps this file guards against}

    - The pre-scan guard (WO-0067 §3) lives in {!Bench.run}, not here — this
      file never re-derives it, and never places an enable change on a
      cycle carrying a start character.
    - Frame 100 IS a genuine {!Dv_xgmii.Arrival.frame}, so it is accounted
      through {!Bench.account_clean_frame} exactly as every other admitted
      frame in this suite is; the 100 refused frames are accounted through
      {!Dv_monitors.Conservation_monitor.frame_in_exempt}, never [.frame_in]
      (REQ-810's own "creates no silent-discard hole", `conservation_monitor.mli`
      deviation 3).
    - The exempt count is bench-supplied, not independent evidence that 100
      frames reached the wire — see the comment at each call site.

    Derived from the spec sections named above, `test/xgmii_rx_64/bench.mli`
    and `test/xgmii/{arrival,xgmii_word,frame}.mli`, all read as spec text.
    No `libs/**`, `top/**` or `rtl_snapshots/**` was opened (PROTOCOL §10,
    WO-0067's own independence clause). *)

open! Base
open Bench

let fail row msg = failwith (String.concat [ row; ": "; msg ])

(* Splits a delivered-sample list into per-frame groups at each [tlast]
   boundary — used only by M03-J1's control run, which delivers all 101
   frames back to back and needs each one's own octets to recover its
   sequence number ({!Dv_xgmii.Frame.sequence_of}). Not
   {!Bench.split_at_first_tlast}: that returns exactly TWO groups and its
   precondition is about a first group that may legitimately be empty (a
   zero-delivered frame) — neither applies here, where every one of the 101
   frames delivers and all 101 groups are wanted. *)
let split_into_frames samples =
  let rec go acc cur = function
    | [] -> List.rev (if List.is_empty cur then acc else List.rev cur :: acc)
    | (s : sample) :: rest ->
      let cur = s :: cur in
      if s.out.Dv_monitors.Stream_word.tlast
      then go (List.rev cur :: acc) [] rest
      else go acc cur rest
  in
  go [] [] samples
;;

(* ---- Shared by M03-J1 and M03-J2 (§5.1) --------------------------------- *)

(* The 101-frame schedule, frame 100 and the disable-then-re-enable
   {!Bench.Enable.t} built from it — every number here is derived and
   checked, never taken. *)
let j1_j2_stimulus ~row =
  let frames = List.init 101 ~f:(fun n -> Dv_xgmii.Frame.stress_frame ~sequence:n ()) in
  let sched = frames_at ~lane:0 ~fcs_valid:true frames in
  if not (Dv_xgmii.Arrival.is_clean sched)
  then
    fail
      row
      (String.concat
         ~sep:"\n"
         ("Arrival.check found problems with the 101-frame schedule:"
          :: Dv_xgmii.Arrival.check sched));
  let all_frames = Dv_xgmii.Arrival.frames sched in
  if Array.length all_frames <> 101
  then
    fail
      row
      (String.concat
         [ "expected 101 frames in the schedule, got "; Int.to_string (Array.length all_frames) ]);
  let frame_100 = all_frames.(100) in
  let start_cycle_100 = Dv_xgmii.Arrival.start_cycle frame_100 in
  if start_cycle_100 <> 1051
  then
    fail
      row
      (String.concat
         [ "frame 100's own start cycle is "
         ; Int.to_string start_cycle_100
         ; ", expected 1051 (84 * 100 + 8 = 8408 octet times = cycle 1051 exactly, WO-0067 §5.1)"
         ]);
  let change_cycle = start_cycle_100 - 1 in
  if change_cycle <> 1050
  then
    fail
      row
      (String.concat [ "the change cycle is "; Int.to_string change_cycle; ", expected 1050" ]);
  (match Dv_xgmii.Xgmii_word.start_lane (Dv_xgmii.Arrival.word_at sched ~cycle:change_cycle) with
   | None -> ()
   | Some lane ->
     fail
       row
       (String.concat
          [ "the change cycle ("
          ; Int.to_string change_cycle
          ; ") carries a start character at lane "
          ; Int.to_string lane
          ; " — the derivation assumed cycle 1050 is entirely inside frame 99's own gap"
          ]));
  (* The refusal path's two-lane coverage is a BY-PRODUCT of 84 not being a
     multiple of 8 (frames alternate lane 0 / lane 4) — a claim nobody
     measured is not a coverage, so it is measured here rather than
     assumed. *)
  let frames_0_99 = Array.sub all_frames ~pos:0 ~len:100 |> Array.to_list in
  let lane0_count =
    List.count frames_0_99 ~f:(fun (f : Dv_xgmii.Arrival.frame) ->
      Int.equal f.Dv_xgmii.Arrival.start_lane 0)
  in
  let lane4_count =
    List.count frames_0_99 ~f:(fun (f : Dv_xgmii.Arrival.frame) ->
      Int.equal f.Dv_xgmii.Arrival.start_lane 4)
  in
  if lane0_count <> 50 || lane4_count <> 50
  then
    fail
      row
      (String.concat
         [ "the refused frames' lane split is "
         ; Int.to_string lane0_count
         ; " lane-0 / "
         ; Int.to_string lane4_count
         ; " lane-4 across frames 0 .. 99, expected 50/50"
         ]);
  let all_lanes = Dv_xgmii.Arrival.start_lanes sched in
  if (not (List.mem all_lanes 0 ~equal:Int.equal)) || not (List.mem all_lanes 4 ~equal:Int.equal)
  then fail row "Arrival.start_lanes sched does not contain both 0 and 4";
  let enable = Enable.changes ~initial:false [ (change_cycle, true) ] in
  sched, frame_100, change_cycle, enable
;;

(* ---- M03-J1 -------------------------------------------------------------- *)
(* "cfg_rx_enable = 0 held, 100 frames injected (REQ-810's own figure). No
   output word, no header effect and no strobe anywhere; the conservation
   monitor records all 100 as frame_in_exempt (C-2), not as discards." *)

let run_j1 () =
  let row = "M03-J1" in
  let sched, frame_100, change_cycle, enable = j1_j2_stimulus ~row in
  let bench = create () in
  let samples = run bench sched ~drain:8 ~enable () in
  (* 2. The silence: no output word, no strobe, across the whole disabled
     window (cycle <= 1050, the change cycle itself included — cfg_rx_enable
     is still 0 driven ON that cycle, {!Bench.Enable.value_at}). *)
  List.iter samples ~f:(fun s ->
    if s.cycle <= change_cycle
    then (
      if s.out.Dv_monitors.Stream_word.tvalid
      then
        fail
          row
          (String.concat [ "cycle "; Int.to_string s.cycle; ": tvalid high during the disabled window" ]);
      if not (List.is_empty s.errors_high)
      then
        fail
          row
          (String.concat
             [ "cycle "; Int.to_string s.cycle; ": an error strobe pulsed during the disabled window" ])));
  (* 3. The driven window, read off sample.enable — the field exists for
     exactly this (bench.mli §1.2). *)
  List.iter samples ~f:(fun s ->
    let expected = s.cycle >= change_cycle in
    if not (Bool.equal s.enable expected)
    then
      fail
        row
        (String.concat
           [ "cycle "
           ; Int.to_string s.cycle
           ; ": enable = "
           ; Bool.to_string s.enable
           ; ", expected "
           ; Bool.to_string expected
           ]));
  (* 4. Accounting. frame_in_exempt, never frame_in (SPEC-M03 §6.1: "a
     bench's frame-conservation monitor counts no frame presented across the
     disabled window") — BOUNCE B9 if this were frame_in. This count is
     BENCH-SUPPLIED, not independent evidence that 100 frames reached the
     wire: it counts the calls THIS unit made, not anything the DUT did. The
     honest evidence for that is the schedule's own 101-entry frame array
     and the control run below (item 5), which is why that control is
     mandatory rather than decorative. *)
  List.iter (List.range 0 100) ~f:(fun _ ->
    Dv_monitors.Conservation_monitor.frame_in_exempt
      (conservation bench)
      ~reason:"cfg_rx_enable = 0 (REQ-810)");
  account_clean_frame bench frame_100 samples ~aborted:false;
  (* 5. The anti-vacuity control (mandatory, BOUNCE B7): the SAME schedule
     on a FRESH bench with Enable.high. Without this, a schedule that
     carried no start characters at all — a construction error, not a
     design fact — would make M03-J1 green. Frame 100 alone does not
     discharge this: it proves frame 100 is well-formed and says nothing
     about frames 0 .. 99. *)
  let control_bench = create () in
  let control_samples = run control_bench sched ~drain:8 ~enable:Enable.high () in
  let control_delivered = delivered_samples control_samples in
  let control_tlasts =
    List.filter control_delivered ~f:(fun s -> s.out.Dv_monitors.Stream_word.tlast)
  in
  if List.length control_tlasts <> 101
  then
    fail
      row
      (String.concat
         [ "control run (Enable.high): "
         ; Int.to_string (List.length control_tlasts)
         ; " tlast words, expected 101"
         ]);
  let frame_chunks = split_into_frames control_delivered in
  if List.length frame_chunks <> 101
  then
    fail
      row
      (String.concat
         [ "control run: segmented "
         ; Int.to_string (List.length frame_chunks)
         ; " frames from the delivered stream, expected 101"
         ]);
  let seqs =
    List.map frame_chunks ~f:(fun chunk ->
      Dv_xgmii.Frame.sequence_of
        (List.concat_map chunk ~f:(fun s -> Dv_monitors.Stream_word.octets s.out)))
  in
  if not (List.equal Int.equal seqs (List.init 101 ~f:Fn.id))
  then fail row "control run: delivered sequence numbers are not 0 .. 100 in order";
  (* 6. *)
  assert_monitors_clean bench ~row;
  assert_monitors_clean control_bench ~row
;;

let%expect_test
  "M03-J1: cfg_rx_enable = 0 held across 100 refused frames — no output \
   word, no header effect, no strobe anywhere; frame_in_exempt accounts all \
   100, the re-enabled frame 100 is received correctly; a control run at \
   Enable.high proves the schedule itself carries 101 well-formed frames \
   (REQ-810)"
  =
  run_j1 ();
  [%expect {||}]
;;

(* ---- M03-J2 -------------------------------------------------------------- *)
(* "cfg_rx_enable 0 -> 1 at least one cycle before a start character; then
   frames. The first frame whose start character is accepted at least one
   cycle after the change is received correctly and completely." *)

let run_j2 () =
  let row = "M03-J2" in
  let sched, frame_100, _change_cycle, enable = j1_j2_stimulus ~row in
  let bench = create () in
  let samples = run bench sched ~drain:8 ~enable () in
  (* This row's stimulus does NOT separate a design that samples the enable
     CONTINUOUSLY from a conformant one — WO-0067 §6, a finding against my
     own attack plan, made while authoring the packet rather than after a
     bench existed. The enable goes 0 -> 1 at least one cycle before frame
     100's own start character and stays 1 for the whole of its admitted
     extent, so a continuously-sampling design sees 1 throughout and
     truncates nothing: there is no design in that class this stimulus
     separates from a conformant one, and no assertion, comment or
     Return-log sentence in this file claims that it does (BOUNCE B8). The
     class THIS stimulus DOES separate, and the one this row's assertions
     below actually check for: a design that REFUSES the first frame after
     a re-enable — one that latches the enable to a frame boundary that
     never arrives while the line is idle, or that needs more than one
     cycle of settling before a start character is admitted. §4.3's own
     "at least one cycle after" and this row's tightest-legal placement
     (change at 1050, start at 1051) are what make that class reachable at
     all. *)
  let start_cycle_100 = Dv_xgmii.Arrival.start_cycle frame_100 in
  let words = delivered_samples samples in
  if List.length words <> 8
  then
    fail
      row
      (String.concat
         [ "expected 8 delivered words for frame 100, got "; Int.to_string (List.length words) ]);
  List.iteri words ~f:(fun m s ->
    let expected_cycle = start_cycle_100 + 3 + m in
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
      if not s.out.Dv_monitors.Stream_word.tlast then fail row "word 7 does not carry tlast";
      if s.out.Dv_monitors.Stream_word.tuser <> 0
      then fail row "word 7 (tlast) carries tuser[0] = 1 unexpectedly")
    else if s.out.Dv_monitors.Stream_word.tlast
    then fail row (String.concat [ "word "; Int.to_string m; " unexpectedly carries tlast" ]));
  let expected_octets = Dv_xgmii.Frame.delivered (Array.to_list frame_100.Dv_xgmii.Arrival.octets) in
  let got_octets = delivered_octets samples in
  if not (List.equal Int.equal got_octets expected_octets)
  then fail row "delivered octets for frame 100 differ from the injected frame minus its FCS";
  let got_seq = Dv_xgmii.Frame.sequence_of got_octets in
  if got_seq <> 100
  then
    fail
      row
      (String.concat
         [ "delivered frame's own sequence number is "
         ; Int.to_string got_seq
         ; ", expected 100 (provenance — this proves it IS frame 100, not merely A frame)"
         ]);
  if not (List.is_empty (error_pulses samples)) then fail row "an error strobe pulsed";
  (* Accounting — same shape as M03-J1's, since this unit drives the same
     101-frame run and its own equation must balance too (bench-supplied,
     not independent evidence — see M03-J1's own call site above). *)
  List.iter (List.range 0 100) ~f:(fun _ ->
    Dv_monitors.Conservation_monitor.frame_in_exempt
      (conservation bench)
      ~reason:"cfg_rx_enable = 0 (REQ-810)");
  account_clean_frame bench frame_100 samples ~aborted:false;
  assert_monitors_clean bench ~row
;;

let%expect_test
  "M03-J2: cfg_rx_enable 0 -> 1 at least one cycle before a start character \
   — the first frame admitted after re-enable (frame 100) is received \
   correctly and completely, at its own start_cycle + 3 + m, provenance \
   confirmed by its own sequence number (REQ-803, REQ-810)"
  =
  run_j2 ();
  [%expect {||}]
;;

(* ---- M03-J3 -------------------------------------------------------------- *)
(* "cfg_rx_enable 1 -> 0 mid-frame, at least one cycle away from any start
   character; the frame ends with /T/. The in-flight frame completes under
   the old value: its words, its tlast, its FCS/runt verdict and its
   strobes are exactly those of the same frame with the enable held at 1.
   The next frame's start character is not accepted." ADR-0014 clause 3
   made executable; its kill is "a design that gates the datapath rather
   than the start character" — the silent discard REQ-810's own next
   clause disclaims. *)

let run_j3 ~lane =
  let row = String.concat [ "M03-J3 (lane "; Int.to_string lane; ")" ] in
  let f0 = Dv_xgmii.Frame.stress_frame ~sequence:0 () in
  let f1 = Dv_xgmii.Frame.stress_frame ~sequence:1 () in
  let sched = frames_at ~lane ~fcs_valid:true [ f0; f1 ] in
  if not (Dv_xgmii.Arrival.is_clean sched)
  then
    fail
      row
      (String.concat
         ~sep:"\n"
         ("Arrival.check found problems with the two-frame schedule:" :: Dv_xgmii.Arrival.check sched));
  let frames = Dv_xgmii.Arrival.frames sched in
  if Array.length frames <> 2
  then fail row (String.concat [ "expected 2 frames in the schedule, got "; Int.to_string (Array.length frames) ]);
  let frame0 = frames.(0) in
  let frame1 = frames.(1) in
  (* 1. Construction: start cycles/lanes and the terminate cycle, as
     tabulated (WO-0067 §5.4). *)
  let start_cycle0 = Dv_xgmii.Arrival.start_cycle frame0 in
  let start_cycle1 = Dv_xgmii.Arrival.start_cycle frame1 in
  let terminate_ot0 = Dv_xgmii.Arrival.terminate_octet_time frame0 in
  let terminate_cycle0 = terminate_ot0 / 8 in
  let terminate_lane0 = Int.rem terminate_ot0 8 in
  let expected_start_cycle1, expected_terminate_lane0 =
    match lane with
    | 0 -> 11, 0
    | 4 -> 12, 4
    | _ -> fail row "test bug — lane must be 0 or 4"
  in
  if start_cycle0 <> 1
  then fail row (String.concat [ "frame 0's own start cycle is "; Int.to_string start_cycle0; ", expected 1" ]);
  if terminate_cycle0 <> 10
  then
    fail
      row
      (String.concat [ "frame 0's own terminate cycle is "; Int.to_string terminate_cycle0; ", expected 10" ]);
  if terminate_lane0 <> expected_terminate_lane0
  then
    fail
      row
      (String.concat
         [ "frame 0's own terminate lane is "
         ; Int.to_string terminate_lane0
         ; ", expected "
         ; Int.to_string expected_terminate_lane0
         ]);
  if start_cycle1 <> expected_start_cycle1
  then
    fail
      row
      (String.concat
         [ "frame 1's own start cycle is "
         ; Int.to_string start_cycle1
         ; ", expected "
         ; Int.to_string expected_start_cycle1
         ]);
  let change_cycle = 5 in
  if change_cycle <= start_cycle0 || change_cycle >= start_cycle1
  then fail row "test bug — the change cycle does not lie strictly inside frame 0";
  (match Dv_xgmii.Xgmii_word.start_lane (Dv_xgmii.Arrival.word_at sched ~cycle:change_cycle) with
   | None -> ()
   | Some l ->
     fail
       row
       (String.concat
          [ "the change cycle ("; Int.to_string change_cycle; ") carries a start character at lane "; Int.to_string l ]));
  let enable = Enable.changes ~initial:true [ (change_cycle, false) ] in
  (* 2. The reference run: the SAME schedule at Enable.high. Two tlast
     words, both frames' delivered octets equal Arrival.delivered, no
     strobe. *)
  let ref_bench = create () in
  let ref_samples = run ref_bench sched ~drain:8 ~enable:Enable.high () in
  let ref_delivered = delivered_samples ref_samples in
  let ref_tlasts = List.filter ref_delivered ~f:(fun s -> s.out.Dv_monitors.Stream_word.tlast) in
  if List.length ref_tlasts <> 2
  then
    fail
      row
      (String.concat
         [ "reference run: "; Int.to_string (List.length ref_tlasts); " tlast words, expected 2" ]);
  if List.length ref_delivered <> 16
  then
    fail
      row
      (String.concat
         [ "reference run: "
         ; Int.to_string (List.length ref_delivered)
         ; " delivered words, expected 16 (two 8-word frames)"
         ]);
  let ref_frame0_words = List.take ref_delivered 8 in
  let ref_frame1_words = List.drop ref_delivered 8 in
  let expected_ref_octets =
    List.append
      (Dv_xgmii.Frame.delivered (Array.to_list frame0.Dv_xgmii.Arrival.octets))
      (Dv_xgmii.Frame.delivered (Array.to_list frame1.Dv_xgmii.Arrival.octets))
  in
  let got_ref_octets = delivered_octets ref_samples in
  if not (List.equal Int.equal got_ref_octets expected_ref_octets)
  then fail row "reference run: delivered octets differ from the two injected frames";
  if not (List.is_empty (error_pulses ref_samples)) then fail row "reference run: an error strobe pulsed";
  (* 3. The disabled run. *)
  let bench = create () in
  let samples = run bench sched ~drain:8 ~enable () in
  let disabled_words = delivered_samples samples in
  if List.length disabled_words <> 8
  then
    fail
      row
      (String.concat
         [ "disabled run: expected exactly 8 delivered words (frame 0 only), got "
         ; Int.to_string (List.length disabled_words)
         ]);
  (* The comparison — this row's own instrument. test_m03_a.ml's
     tuple_of_sample / tuple_equal are the landed shape (do not invent a
     second one); the comparison is over cycles as well as tuples, which
     that pair does not carry, so cycle equality is asserted alongside it
     and not folded into it. Not {!Bench.split_at_first_tlast} — its
     two-group precondition is a different concern from a straight
     8-word/8-word slice comparison the counts above already establish. *)
  let tuples_equal =
    List.equal
      (fun a b -> Test_m03_a.tuple_equal (Test_m03_a.tuple_of_sample a) (Test_m03_a.tuple_of_sample b))
      disabled_words
      ref_frame0_words
  in
  if not tuples_equal
  then
    fail
      row
      "frame 0's delivered (octets, tkeep, tlast, tuser) tuples differ between the disabled and \
       reference runs";
  let cycles_equal =
    List.equal
      Int.equal
      (List.map disabled_words ~f:(fun s -> s.cycle))
      (List.map ref_frame0_words ~f:(fun s -> s.cycle))
  in
  if not cycles_equal
  then fail row "frame 0's delivered word cycles differ between the disabled and reference runs";
  (* 4. The refusal. *)
  let disabled_tlasts = List.filter disabled_words ~f:(fun s -> s.out.Dv_monitors.Stream_word.tlast) in
  if List.length disabled_tlasts <> 1
  then
    fail
      row
      (String.concat
         [ "disabled run: "; Int.to_string (List.length disabled_tlasts); " tlast words, expected 1" ]);
  let frame1_would_start = start_cycle1 + 3 in
  if List.exists disabled_words ~f:(fun s -> s.cycle >= frame1_would_start)
  then
    fail
      row
      "disabled run: a delivered word appeared at or after frame 1's own start_cycle + 3 — frame 1 was \
       not refused";
  (* 5. No strobe anywhere in the disabled run. *)
  if not (List.is_empty (error_pulses samples))
  then
    fail
      row
      "disabled run: an error strobe pulsed — frame 0 should close cleanly on its own /T/ and REQ-810 \
       gives the refused frame 1 no strobe at all";
  (* 6. The driven window. *)
  List.iter samples ~f:(fun s ->
    let expected = s.cycle < change_cycle in
    if not (Bool.equal s.enable expected)
    then
      fail
        row
        (String.concat
           [ "cycle "
           ; Int.to_string s.cycle
           ; ": enable = "
           ; Bool.to_string s.enable
           ; ", expected "
           ; Bool.to_string expected
           ]));
  (* 7. Accounting. *)
  account_clean_frame bench frame0 samples ~aborted:false;
  Dv_monitors.Conservation_monitor.frame_in_exempt
    (conservation bench)
    ~reason:"cfg_rx_enable = 0 (REQ-810)";
  account_clean_frame ref_bench frame0 ref_frame0_words ~aborted:false;
  account_clean_frame ref_bench frame1 ref_frame1_words ~aborted:false;
  (* 8. *)
  assert_monitors_clean bench ~row;
  assert_monitors_clean ref_bench ~row
;;

let%expect_test
  "M03-J3: cfg_rx_enable 1 -> 0 mid-frame, at both start lanes — the \
   in-flight frame (frame 0) completes under the old value byte-for-byte \
   against an Enable.high reference run, cycles included; the refused \
   frame 1's start character is not accepted; no strobe anywhere \
   (REQ-803, REQ-810, ADR-0014)"
  =
  run_j3 ~lane:0;
  run_j3 ~lane:4;
  [%expect {||}]
;;
