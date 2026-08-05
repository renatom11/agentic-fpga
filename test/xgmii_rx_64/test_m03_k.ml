(** Family K -- `clear` (REQ-009; SPEC-M03 §6.2's `Idle` row, §7's reset
    bullet, §9's "one real exception … is `clear` asserted mid-frame";
    requirements.md §0.6, §0.7, §12, REQ-009, REQ-011, REQ-015; `Bench.Clear`,
    `Bench.run`'s `?clear` plumbing and K guard, `Bench.account_cleared_frame`
    -- all WO-0072). The LAST bench round of this module, and the first to
    drive `clear`.

    Two rows (AP-xgmii_rx_64.md §4.K): M03-K1 (ASSERT, this file's [run_k1])
    and M03-K2 (ASSERT, [run_k2]). M03-K3 is NO-ASSERT and is not in this
    round -- no title in this file names it (WO-0072 §13.1, BOUNCE BK12).

    {2 What this file does NOT claim (WO-0072 §7.5)}

    M03-K1's own Kills cell names two classes and only one is reachable by
    this row's stimulus: "a design whose strobe registers survive [clear]"
    (REACHABLE, tightly, because the window opens the cycle immediately after
    the frame's own strobe) and "or that needs a second cycle to settle" (NOT
    separated by this row -- worked through at WO-0072 §7.5). No assertion,
    comment or Return-log sentence in this file claims M03-K1 detects a
    design that needs a second cycle to settle; that class lives at M03-K2's
    own release-cycle assertion instead (BOUNCE BK9).

    {2 Traps this file guards against (WO-0072 §16)}

    - T1: {!Bench.split_at_first_tlast} is never called on M03-K2's samples
      -- frame A delivers words and never closes, so "the first tlast" would
      be B's and the function would silently merge A's words into B's. K2
      partitions by its own asserted delivered-cycle list instead (§8.4 step
      3).
    - T2: {!Dv_xgmii.Frame.sequence_of} is never called on frame A's 16-octet
      prefix (it raises below 18 octets) -- only on B's 60 octets and the
      control run's two 60s.
    - T3: the clear window is asserted from each sample's own [clear] field,
      never reconstructed from the schedule this file built.
    - T5: M03-K2's [account_clean_frame] call for frame B is handed frame
      B's OWN delivered words, never the whole run's samples -- handing it
      the whole run would feed frame A's two escaped words into frame B's
      latency comparison.
    - T7: [?clear] is passed by label, so its declaration position in
      {!Bench.run} (after [?enable]) never affects a call site here.
    - T8: family D's own bad-FCS call takes [~aborted:false] in this suite
      (`conservation_monitor.mli`'s wording notwithstanding) -- WO-0072
      §10.3 records why that is not this round's to change, and M03-K1's
      `account_clean_frame` call below copies it unchanged.

    Derived from the spec sections named above, `test/xgmii_rx_64/bench.mli`
    and `test/xgmii/{arrival,xgmii_word,frame}.mli`, all read as spec text.
    No `libs/**`, `top/**` or `rtl_snapshots/**` was opened (PROTOCOL §10,
    WO-0072's own independence clause). *)

open! Base
open Bench

let fail row msg = failwith (String.concat [ row; ": "; msg ])

(* Shared by M03-K1 (both its clear and control runs) and M03-K2's B frame
   (both its clear and control runs): the per-word cycle/tkeep/tlast/tuser
   check family D's [run_d1] and family J's [run_j2] already use, generalised
   over [expected_tlast_tuser] since K1's frame carries a bad FCS (tuser = 1)
   and K2's frame B is clean (tuser = 0). Assumes [words] is exactly one
   clean-through-its-own-closure 64-octet frame's delivered words -- 8 of
   them, tlast on the last -- which every call site below has already
   checked the length of before calling this. *)
let assert_delivered_words row words ~start_cycle ~expected_tlast_tuser =
  List.iteri words ~f:(fun m (s : sample) ->
    let expected_cycle = start_cycle + 3 + m in
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
      if s.out.Dv_monitors.Stream_word.tuser <> expected_tlast_tuser
      then
        fail
          row
          (String.concat
             [ "word 7 (tlast) carries tuser[0] = "
             ; Int.to_string s.out.Dv_monitors.Stream_word.tuser
             ; ", expected "
             ; Int.to_string expected_tlast_tuser
             ]))
    else if s.out.Dv_monitors.Stream_word.tlast
    then fail row (String.concat [ "word "; Int.to_string m; " unexpectedly carries tlast" ]))
;;

(* ---- M03-K1 --------------------------------------------------------------- *)
(* AP-xgmii_rx_64.md M03-K1: "clear = 1 for 5 cycles while no frame is in
   flight." WO-0072 §7.1: the row's declared kill (strobe residue) is only
   reachable if a strobe pulses immediately before the window, so the
   stimulus is a bad-FCS 64-octet frame whose error_bad_fcs pulses on its
   own tlast cycle, with the clear window opening the very next cycle
   (WO-0072 §7.2). *)

let run_k1 () =
  let row = "M03-K1" in
  (* WO-0072 §7.1: family D's own construction (test_m03_d.ml:33-56),
     REPRODUCED here rather than imported -- duplicating four lines with a
     citation beats a cross-row dependency between two test files that
     share no other subject. *)
  let flip_bit0_at ~idx octets =
    List.mapi octets ~f:(fun i v -> if i = idx then v lxor 1 else v)
  in
  let good = directed_frame_octets ~length:64 in
  if not (Dv_xgmii.Frame.residue_ok good)
  then fail row "test bug -- the base 64-octet frame's own FCS does not check out";
  let bad = flip_bit0_at ~idx:20 good in
  if Dv_xgmii.Frame.residue_ok bad
  then fail row "test bug -- the payload-bit flip did not change the frame's FCS residue";
  let sched = frames_at ~lane:0 ~fcs_valid:false [ bad ] in
  let frames = Dv_xgmii.Arrival.frames sched in
  if Array.length frames <> 1
  then
    fail
      row
      (String.concat [ "expected 1 frame in the schedule, got "; Int.to_string (Array.length frames) ]);
  let frame = frames.(0) in
  if frame.Dv_xgmii.Arrival.start_octet_time <> 8
  then
    fail
      row
      (String.concat
         [ "frame 0's start_octet_time is "
         ; Int.to_string frame.Dv_xgmii.Arrival.start_octet_time
         ; ", expected 8"
         ]);
  if frame.Dv_xgmii.Arrival.start_lane <> 0
  then
    fail
      row
      (String.concat
         [ "frame 0's start_lane is "; Int.to_string frame.Dv_xgmii.Arrival.start_lane; ", expected 0" ]);
  let start_cycle = Dv_xgmii.Arrival.start_cycle frame in
  if start_cycle <> 1
  then fail row (String.concat [ "frame 0's start_cycle is "; Int.to_string start_cycle; ", expected 1" ]);
  let terminate_ot = Dv_xgmii.Arrival.terminate_octet_time frame in
  if terminate_ot <> 80
  then
    fail
      row
      (String.concat [ "frame 0's terminate_octet_time is "; Int.to_string terminate_ot; ", expected 80" ]);
  let terminate_cycle = terminate_ot / 8 in
  if terminate_cycle <> 10
  then
    fail
      row
      (String.concat [ "frame 0's terminate cycle is "; Int.to_string terminate_cycle; ", expected 10" ]);
  let sched_cycles = Dv_xgmii.Arrival.cycles sched in
  if sched_cycles <> 13
  then fail row (String.concat [ "Arrival.cycles sched is "; Int.to_string sched_cycles; ", expected 13" ]);
  (* WO-0072 §7.2 item 13: the tlast cycle, start_cycle + 3 + 7 (WO-0040 §6's
     own formula, one clear round over). *)
  let expected_pulse_cycle = start_cycle + 10 in
  (* WO-0072 §7.2 item 19: the window opens the cycle after the strobe and
     is 5 cycles long (§4.K's own figure); item 20: the release cycle is the
     cycle after the window's last. *)
  let clear_first = expected_pulse_cycle + 1 in
  let clear_last = clear_first + 4 in
  let release_cycle = clear_last + 1 in
  if clear_first <> 12 || clear_last <> 16 || release_cycle <> 17
  then fail row "test bug -- the derived clear window is not 12 .. 16 (release 17)";
  (* No cycle in the intended window carries a start character -- the
     schedule's only start character is at cycle 1 (WO-0072 §7.2, the note
     after the table). Checking this in the row makes the intent explicit
     rather than relying on the absence of an exception from {!Bench.run}'s
     own K guard. *)
  List.iter
    (List.range clear_first (clear_last + 1))
    ~f:(fun cycle ->
      match Dv_xgmii.Xgmii_word.start_lane (Dv_xgmii.Arrival.word_at sched ~cycle) with
      | None -> ()
      | Some lane ->
        fail
          row
          (String.concat
             [ "cycle "
             ; Int.to_string cycle
             ; " (inside the intended clear window) carries a start character at lane "
             ; Int.to_string lane
             ]));
  let bench = create () in
  Dv_monitors.Strobe_monitor.expect
    (strobes bench)
    { Dv_monitors.Strobe_monitor.strobe = "error_bad_fcs"
    ; frame = 0
    ; cycle = expected_pulse_cycle
    ; not_before = terminate_cycle
    ; not_after = terminate_cycle + 3
    ; why =
        "REQ-104 (bad FCS, forwarded per REQ-005); SPEC-M03 section 9 'Strobe \
         cycle, pinned' pins it to the frame's tlast cycle, start_cycle + 3 + 7 \
         = 11 (WO-0072 section 7.2 item 13, reusing WO-0040 section 6's formula)"
    };
  let samples =
    run bench sched ~drain:8 ~clear:(Clear.window ~first:clear_first ~last:clear_last) ()
  in
  let words = delivered_samples samples in
  if List.length words <> 8
  then fail row (String.concat [ "expected 8 output words, got "; Int.to_string (List.length words) ]);
  assert_delivered_words row words ~start_cycle ~expected_tlast_tuser:1;
  let expected_octets = Dv_xgmii.Frame.delivered bad in
  let got_octets = delivered_octets samples in
  if not (List.equal Int.equal got_octets expected_octets)
  then
    fail
      row
      "delivered octets differ from the corrupted frame's own 60 octets (REQ-005: \
       forwarded in full, corruption included)";
  (match error_pulses samples with
   | [ (cycle, name) ] ->
     if not (String.equal name "error_bad_fcs")
     then fail row (String.concat [ "expected error_bad_fcs, observed "; name ])
     else if cycle <> expected_pulse_cycle
     then
       fail
         row
         (String.concat
            [ "error_bad_fcs pulsed on cycle "
            ; Int.to_string cycle
            ; ", expected "
            ; Int.to_string expected_pulse_cycle
            ])
   | pulses ->
     fail
       row
       (String.concat
          [ "expected exactly one strobe pulse (error_bad_fcs only), observed "
          ; Int.to_string (List.length pulses)
          ]));
  (* The clear window AS DRIVEN -- T3: read s.clear, never the schedule this
     row built. *)
  List.iter samples ~f:(fun s ->
    let expected = clear_first <= s.cycle && s.cycle <= clear_last in
    if not (Bool.equal s.clear expected)
    then
      fail
        row
        (String.concat
           [ "cycle "
           ; Int.to_string s.cycle
           ; ": clear = "
           ; Bool.to_string s.clear
           ; ", expected "
           ; Bool.to_string expected
           ]));
  (* The silence: the five clear cycles AND the release cycle. *)
  List.iter samples ~f:(fun s ->
    if s.cycle >= clear_first && s.cycle <= release_cycle
    then (
      if s.out.Dv_monitors.Stream_word.tvalid
      then
        fail
          row
          (String.concat
             [ "cycle "; Int.to_string s.cycle; ": tvalid high during/after the clear window" ]);
      if not (List.is_empty s.errors_high)
      then
        fail
          row
          (String.concat
             [ "cycle "
             ; Int.to_string s.cycle
             ; ": an error strobe pulsed during/after the clear window"
             ])));
  (* T8: family D's own call, copied unchanged (WO-0072 §10.3). *)
  account_clean_frame bench frame samples ~aborted:false;
  Dv_monitors.Conservation_monitor.strobe_pulse (conservation bench) ~name:"error_bad_fcs";
  if Dv_monitors.Protocol_monitor.cleared_mid_frame (protocol bench) <> 0
  then
    fail
      row
      "cleared_mid_frame is not 0 -- the clear window opened after the frame's own tlast, so no \
       on_clear call should find a frame in progress";
  let c = conservation bench in
  if Dv_monitors.Conservation_monitor.frames_in c <> 1 then fail row "conservation frames_in is not 1";
  if Dv_monitors.Conservation_monitor.frames_out c <> 1 then fail row "conservation frames_out is not 1";
  if Dv_monitors.Conservation_monitor.frames_exempt c <> 0
  then fail row "conservation frames_exempt is not 0";
  if Dv_monitors.Conservation_monitor.discards c <> 0 then fail row "conservation discards is not 0";
  if Dv_monitors.Conservation_monitor.residual c <> 0 then fail row "conservation residual is not 0";
  (match Dv_monitors.Octet_time.Latency.word_delay (latency bench) with
   | Some 3 -> ()
   | Some n ->
     fail row (String.concat [ "latency word_delay is Some "; Int.to_string n; ", expected Some 3" ])
   | None -> fail row "latency word_delay is None, expected Some 3");
  (* WO-0072 §7.4: the mandatory control run. NOT M03-J1's purpose -- K1's
     own frame is already received inside the clear run above. This control
     pins the window's LEADING boundary, and shows cycles 12 .. 17 are
     silent in the control run too: not a defect in the row, but the exact
     content of "while no frame is in flight". *)
  let control_bench = create () in
  Dv_monitors.Strobe_monitor.expect
    (strobes control_bench)
    { Dv_monitors.Strobe_monitor.strobe = "error_bad_fcs"
    ; frame = 0
    ; cycle = expected_pulse_cycle
    ; not_before = terminate_cycle
    ; not_after = terminate_cycle + 3
    ; why = "REQ-104; the control run's own schedule is byte-identical to the clear run's (WO-0072 §7.4)"
    };
  let control_samples = run control_bench sched ~drain:8 () in
  let control_words = delivered_samples control_samples in
  if List.length control_words <> 8
  then
    fail
      row
      (String.concat
         [ "control run: expected 8 output words, got "; Int.to_string (List.length control_words) ]);
  assert_delivered_words row control_words ~start_cycle ~expected_tlast_tuser:1;
  let control_octets = delivered_octets control_samples in
  if not (List.equal Int.equal control_octets expected_octets)
  then fail row "control run: delivered octets differ from the clear run's own";
  (match error_pulses control_samples with
   | [ (cycle, name) ] ->
     if (not (String.equal name "error_bad_fcs")) || cycle <> expected_pulse_cycle
     then fail row "control run: strobe set differs from the clear run's own"
   | pulses ->
     fail
       row
       (String.concat
          [ "control run: expected exactly one strobe pulse, observed "
          ; Int.to_string (List.length pulses)
          ]));
  List.iter control_samples ~f:(fun s ->
    if s.cycle >= clear_first && s.cycle <= release_cycle
    then (
      if s.out.Dv_monitors.Stream_word.tvalid
      then fail row (String.concat [ "control run cycle "; Int.to_string s.cycle; ": tvalid high" ]);
      if not (List.is_empty s.errors_high)
      then
        fail row (String.concat [ "control run cycle "; Int.to_string s.cycle; ": an error strobe pulsed" ])));
  account_clean_frame control_bench frame control_samples ~aborted:false;
  Dv_monitors.Conservation_monitor.strobe_pulse (conservation control_bench) ~name:"error_bad_fcs";
  assert_monitors_clean bench ~row;
  assert_monitors_clean control_bench ~row
;;

let%expect_test
  "M03-K1: clear held for five cycles with no frame in flight -- the \
   bad-FCS strobe on the preceding cycle does not survive into the window, \
   and the window's five cycles plus the release cycle are silent; a \
   control run at the default schedule shows the delivered stream is \
   unchanged (REQ-009)"
  =
  run_k1 ();
  [%expect {||}]
;;

(* ---- M03-K2 --------------------------------------------------------------- *)
(* AP-xgmii_rx_64.md M03-K2: "clear asserted mid-frame, deasserted, and a
   new frame whose start character arrives on the first cycle after clear
   returns to 0." WO-0072 §8.1: at the default 12-octet gap frame B's start
   character lands exactly one cycle after a five-cycle window closing at
   cycle 10 -- no [?ifg] is needed. *)

let run_k2 () =
  let row = "M03-K2" in
  let a = Dv_xgmii.Frame.stress_frame ~sequence:0 () in
  let b = Dv_xgmii.Frame.stress_frame ~sequence:1 () in
  let sched = frames_at ~lane:0 ~fcs_valid:true [ a; b ] in
  if not (Dv_xgmii.Arrival.is_clean sched)
  then
    fail
      row
      (String.concat
         ~sep:"\n"
         ("Arrival.check found problems with the two-frame schedule:" :: Dv_xgmii.Arrival.check sched));
  let frames = Dv_xgmii.Arrival.frames sched in
  if Array.length frames <> 2
  then
    fail
      row
      (String.concat [ "expected 2 frames in the schedule, got "; Int.to_string (Array.length frames) ]);
  let frame_a = frames.(0) in
  let frame_b = frames.(1) in
  if frame_a.Dv_xgmii.Arrival.start_octet_time <> 8 then fail row "frame A's start_octet_time is not 8";
  if frame_a.Dv_xgmii.Arrival.start_lane <> 0 then fail row "frame A's start_lane is not 0";
  let start_cycle_a = Dv_xgmii.Arrival.start_cycle frame_a in
  if start_cycle_a <> 1 then fail row "frame A's start_cycle is not 1";
  let terminate_ot_a = Dv_xgmii.Arrival.terminate_octet_time frame_a in
  if terminate_ot_a <> 80 then fail row "frame A's terminate_octet_time is not 80";
  let terminate_cycle_a = terminate_ot_a / 8 in
  if terminate_cycle_a <> 10 then fail row "frame A's terminate cycle is not 10";
  if frame_b.Dv_xgmii.Arrival.start_octet_time <> 92 then fail row "frame B's start_octet_time is not 92";
  if frame_b.Dv_xgmii.Arrival.start_lane <> 4 then fail row "frame B's start_lane is not 4";
  (* WO-0072 §8.4 step 1: item 4's start_cycle = 11 is the number the whole
     row rests on; if it is not 11, stop. *)
  let start_cycle_b = Dv_xgmii.Arrival.start_cycle frame_b in
  if start_cycle_b <> 11 then fail row "frame B's start_cycle is not 11 -- the whole row rests on this";
  let terminate_ot_b = Dv_xgmii.Arrival.terminate_octet_time frame_b in
  if terminate_ot_b <> 164 then fail row "frame B's terminate_octet_time is not 164";
  let terminate_cycle_b = terminate_ot_b / 8 in
  if terminate_cycle_b <> 20 then fail row "frame B's terminate cycle is not 20";
  let spacings = Dv_xgmii.Arrival.start_spacings sched in
  if not (List.equal Int.equal spacings [ 10 ]) then fail row "Arrival.start_spacings sched is not [10]";
  let gaps = Dv_xgmii.Arrival.gaps sched in
  if not (List.equal Int.equal gaps [ 12 ]) then fail row "Arrival.gaps sched is not [12]";
  let sched_cycles = Dv_xgmii.Arrival.cycles sched in
  if sched_cycles <> 23 then fail row "Arrival.cycles sched is not 23";
  (* WO-0072 §8.3: last = 10 is forced (the release cycle must be B's start
     cycle, 11); first = 6 is chosen so exactly two of A's eight words
     escape, and the window stays 5 cycles long like M03-K1's own. *)
  let clear_first = 6 in
  let clear_last = 10 in
  if start_cycle_b <> clear_last + 1
  then fail row "frame B's start_cycle does not equal the release cycle (clear_last + 1)";
  (* Confirm no cycle in 6 .. 10 carries a start character (WO-0072 §8.4
     step 2) -- the schedule's two start characters are at cycles 1 and 11,
     neither of which is high. *)
  List.iter
    (List.range clear_first (clear_last + 1))
    ~f:(fun cycle ->
      match Dv_xgmii.Xgmii_word.start_lane (Dv_xgmii.Arrival.word_at sched ~cycle) with
      | None -> ()
      | Some lane ->
        fail
          row
          (String.concat
             [ "cycle "
             ; Int.to_string cycle
             ; " (inside the intended clear window) carries a start character at lane "
             ; Int.to_string lane
             ]));
  let bench = create () in
  let samples =
    run bench sched ~drain:8 ~clear:(Clear.window ~first:clear_first ~last:clear_last) ()
  in
  (* WO-0072 §8.4 step 3: the delivered-cycle list of the whole run, asserted
     BEFORE any partition is taken -- the precondition every partition below
     depends on. *)
  let delivered = delivered_samples samples in
  let delivered_cycles = List.map delivered ~f:(fun s -> s.cycle) in
  if not (List.equal Int.equal delivered_cycles [ 4; 5; 14; 15; 16; 17; 18; 19; 20; 21 ])
  then
    fail
      row
      "the delivered-cycle list is not [4;5;14;15;16;17;18;19;20;21] -- the precondition every \
       partition below depends on";
  (* T1: partition by this asserted cycle list, NEVER by
     {!Bench.split_at_first_tlast} -- frame A delivers words and never
     closes, so "the first tlast" would be B's own and the function would
     silently merge A's words into B's. *)
  let a_words, b_words = List.split_n delivered 2 in
  if List.length a_words <> 2 then fail row "expected exactly 2 delivered words for frame A";
  if List.length b_words <> 8 then fail row "expected exactly 8 delivered words for frame B";
  List.iter a_words ~f:(fun (s : sample) ->
    if s.out.Dv_monitors.Stream_word.tkeep <> 0xFF
    then fail row "frame A's delivered word does not carry tkeep = 0xFF";
    if s.out.Dv_monitors.Stream_word.tlast
    then fail row "frame A carries a tlast word -- REQ-009 licenses none");
  let a_octets = List.concat_map a_words ~f:(fun (s : sample) -> Dv_monitors.Stream_word.octets s.out) in
  let expected_a_octets = List.take (Dv_xgmii.Frame.delivered a) 16 in
  if not (List.equal Int.equal a_octets expected_a_octets)
  then fail row "frame A's delivered octets are not the first 16 of Frame.delivered a";
  assert_delivered_words row b_words ~start_cycle:start_cycle_b ~expected_tlast_tuser:0;
  let b_octets = List.concat_map b_words ~f:(fun (s : sample) -> Dv_monitors.Stream_word.octets s.out) in
  let expected_b_octets = Dv_xgmii.Frame.delivered b in
  if not (List.equal Int.equal b_octets expected_b_octets)
  then fail row "frame B's delivered octets differ from Frame.delivered b";
  (* T2: sequence_of is never called on A's 16-octet prefix (it raises below
     18 octets) -- only on B's own 60. *)
  let b_seq = Dv_xgmii.Frame.sequence_of b_octets in
  if b_seq <> 1
  then fail row (String.concat [ "frame B's own sequence number is "; Int.to_string b_seq; ", expected 1" ]);
  (* No tlast anywhere before B's: the only sample in the run with tlast = 1
     is the one at cycle 21. *)
  let tlast_samples = List.filter delivered ~f:(fun s -> s.out.Dv_monitors.Stream_word.tlast) in
  (match tlast_samples with
   | [ s ] -> if s.cycle <> 21 then fail row "the run's only tlast sample is not at cycle 21"
   | _ ->
     fail
       row
       (String.concat
          [ "expected exactly one tlast sample in the whole run, observed "
          ; Int.to_string (List.length tlast_samples)
          ]));
  if not (List.is_empty (error_pulses samples))
  then fail row "error_pulses is not empty -- A vanishes with no strobe (REQ-009) and B is clean";
  (* The clear window AS DRIVEN -- T3. *)
  List.iter samples ~f:(fun s ->
    let expected = clear_first <= s.cycle && s.cycle <= clear_last in
    if not (Bool.equal s.clear expected)
    then
      fail
        row
        (String.concat
           [ "cycle "
           ; Int.to_string s.cycle
           ; ": clear = "
           ; Bool.to_string s.clear
           ; ", expected "
           ; Bool.to_string expected
           ]));
  (* The silence across the window AND the release cycle (6 .. 11): the five
     clear cycles, frame A's own terminate character at cycle 10, and the
     release cycle 11. *)
  List.iter samples ~f:(fun s ->
    if s.cycle >= clear_first && s.cycle <= start_cycle_b
    then (
      if s.out.Dv_monitors.Stream_word.tvalid
      then
        fail
          row
          (String.concat
             [ "cycle "; Int.to_string s.cycle; ": tvalid high across the clear window/release cycle" ]);
      if not (List.is_empty s.errors_high)
      then
        fail
          row
          (String.concat
             [ "cycle "
             ; Int.to_string s.cycle
             ; ": an error strobe pulsed across the clear window/release cycle"
             ])));
  (* Accounting, in this order (WO-0072 §8.4 step 9). T5: frame B's call is
     handed b_words -- ITS OWN delivered words -- never the whole run's
     samples. *)
  account_cleared_frame bench frame_a ~delivered:16 a_words;
  account_clean_frame bench frame_b b_words ~aborted:false;
  if Dv_monitors.Protocol_monitor.cleared_mid_frame (protocol bench) <> 1
  then fail row "cleared_mid_frame is not 1";
  let p = protocol bench in
  if Dv_monitors.Protocol_monitor.frames p <> 1 then fail row "protocol frames is not 1";
  if Dv_monitors.Protocol_monitor.words p <> 10 then fail row "protocol words is not 10";
  if Dv_monitors.Protocol_monitor.aborts p <> 0 then fail row "protocol aborts is not 0";
  let c = conservation bench in
  if Dv_monitors.Conservation_monitor.frames_in c <> 1 then fail row "conservation frames_in is not 1";
  if Dv_monitors.Conservation_monitor.frames_out c <> 1 then fail row "conservation frames_out is not 1";
  if Dv_monitors.Conservation_monitor.frames_exempt c <> 1
  then fail row "conservation frames_exempt is not 1";
  if Dv_monitors.Conservation_monitor.discards c <> 0 then fail row "conservation discards is not 0";
  if Dv_monitors.Conservation_monitor.residual c <> 0 then fail row "conservation residual is not 0";
  (match Dv_monitors.Octet_time.Latency.word_delay (latency bench) with
   | Some 3 -> ()
   | Some n ->
     fail row (String.concat [ "latency word_delay is Some "; Int.to_string n; ", expected Some 3" ])
   | None -> fail row "latency word_delay is None, expected Some 3");
  (* WO-0072 §8.5: the mandatory control run, charged exactly as M03-J1's
     was -- without it, a schedule that never carried a well-formed frame A
     at all (a construction error, not a design fact) would make K2 green,
     because "A vanished" and "A was never there" look identical from A's
     own two escaped words alone. *)
  let control_bench = create () in
  let control_samples = run control_bench sched ~drain:8 () in
  let control_delivered = delivered_samples control_samples in
  if List.length control_delivered <> 16
  then
    fail
      row
      (String.concat
         [ "control run: expected 16 delivered words, got "
         ; Int.to_string (List.length control_delivered)
         ]);
  let control_tlasts =
    List.filter control_delivered ~f:(fun s -> s.out.Dv_monitors.Stream_word.tlast)
  in
  let control_tlast_cycles = List.map control_tlasts ~f:(fun s -> s.cycle) in
  if not (List.equal Int.equal control_tlast_cycles [ 11; 21 ])
  then fail row "control run: tlast cycles are not [11; 21]";
  (* Note the coincidence, and do not read it as an error (T6): A's tlast
     is at cycle 11 and B's start character is at cycle 11 too -- opposite
     directions of the same cycle. *)
  let control_a_words, control_b_words = List.split_n control_delivered 8 in
  let control_a_octets =
    List.concat_map control_a_words ~f:(fun (s : sample) -> Dv_monitors.Stream_word.octets s.out)
  in
  let control_b_octets =
    List.concat_map control_b_words ~f:(fun (s : sample) -> Dv_monitors.Stream_word.octets s.out)
  in
  if not (List.equal Int.equal control_a_octets (Dv_xgmii.Frame.delivered a))
  then fail row "control run: frame A's delivered octets differ from Frame.delivered a";
  if not (List.equal Int.equal control_b_octets (Dv_xgmii.Frame.delivered b))
  then fail row "control run: frame B's delivered octets differ from Frame.delivered b";
  let control_seq_a = Dv_xgmii.Frame.sequence_of control_a_octets in
  let control_seq_b = Dv_xgmii.Frame.sequence_of control_b_octets in
  if control_seq_a <> 0 || control_seq_b <> 1
  then fail row "control run: delivered sequence numbers are not 0 then 1";
  if not (List.is_empty (error_pulses control_samples)) then fail row "control run: an error strobe pulsed";
  if Dv_monitors.Protocol_monitor.cleared_mid_frame (protocol control_bench) <> 0
  then fail row "control run: cleared_mid_frame is not 0";
  account_clean_frame control_bench frame_a control_a_words ~aborted:false;
  account_clean_frame control_bench frame_b control_b_words ~aborted:false;
  let cc = conservation control_bench in
  if Dv_monitors.Conservation_monitor.frames_in cc <> 2
  then fail row "control run: conservation frames_in is not 2";
  if Dv_monitors.Conservation_monitor.frames_out cc <> 2
  then fail row "control run: conservation frames_out is not 2";
  if Dv_monitors.Conservation_monitor.frames_exempt cc <> 0
  then fail row "control run: conservation frames_exempt is not 0";
  if Dv_monitors.Conservation_monitor.residual cc <> 0
  then fail row "control run: conservation residual is not 0";
  (match Dv_monitors.Octet_time.Latency.word_delay (latency control_bench) with
   | Some 3 -> ()
   | Some n ->
     fail
       row
       (String.concat
          [ "control run: latency word_delay is Some "; Int.to_string n; ", expected Some 3" ])
   | None -> fail row "control run: latency word_delay is None, expected Some 3");
  assert_monitors_clean bench ~row;
  assert_monitors_clean control_bench ~row
;;

let%expect_test
  "M03-K2: clear asserted mid-frame and released onto the next frame's \
   start character -- the in-flight frame vanishes with two words \
   delivered, no tlast and no strobe, frame_in_exempt accounts it (C-2), \
   and the frame starting on the release cycle is received correctly and \
   completely; a control run at the default schedule proves the schedule \
   carries two well-formed frames (REQ-009)"
  =
  run_k2 ();
  [%expect {||}]
;;
