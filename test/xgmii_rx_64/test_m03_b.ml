(** M03-B1 (ASSERT, REQ-102, AP-xgmii_rx_64.md family B):

    "64-octet frame whose six filler octets and SFD octet are arbitrary
    non-standard data values, both start lanes... The frame is delivered
    unchanged: same 60 octets, same tkeep, tuser[0] = 0, no strobe."

    [Dv_xgmii.Arrival] fixes its preamble filler at 0x55 with an 0xD5 SFD and
    exposes no parameter to vary it (test/xgmii/arrival.mli, "What the model
    does not decide") — REQ-102 is precisely why it does not need one for
    every *other* row. This row needs the opposite value on purpose, so it
    builds a normal schedule and then substitutes a non-standard data
    pattern into exactly the preamble-position lanes of the schedule's own
    start word(s) before driving — [Arrival]'s /S/ placement, frame content
    and FCS are untouched; only the six filler octets and the SFD octet
    Arrival would otherwise drive as 0x55/0xD5 change value. This is
    machinery composition, not a new capability: {!Bench.run}'s [?word_at]
    exists for exactly this substitution (bench.mli).

    Preamble-position lanes, per SPEC-M03 §6.1 ("Where the preamble
    positions lie"): at a lane-0 start, lanes 1-7 of the start word; at a
    lane-4 start, lanes 5-7 of the start word *and* lanes 0-3 of the next
    word (frame octets 0-3 live in lanes 4-7 of that next word and are left
    alone). *)

open! Base
open Bench

let nonstandard_preamble_octet lane = 0xA0 + lane

let preamble_override sched (frame : Dv_xgmii.Arrival.frame) ~start_cycle
  : cycle:int -> Dv_xgmii.Xgmii_word.t
  =
  let start_lane = frame.Dv_xgmii.Arrival.start_lane in
  fun ~cycle ->
    let word = Dv_xgmii.Arrival.word_at sched ~cycle in
    let is_preamble_lane lane =
      if start_lane = 0
      then cycle = start_cycle && lane >= 1 && lane <= 7
      else
        (cycle = start_cycle && lane >= 5 && lane <= 7)
        || (cycle = start_cycle + 1 && lane >= 0 && lane <= 3)
    in
    if cycle <> start_cycle && cycle <> start_cycle + 1
    then word
    else
      { Dv_xgmii.Xgmii_word.data =
          Array.mapi word.Dv_xgmii.Xgmii_word.data ~f:(fun lane v ->
            if is_preamble_lane lane then nonstandard_preamble_octet lane else v)
      ; control = word.Dv_xgmii.Xgmii_word.control
      }
;;

let run_b1 ~lane =
  let payload = List.init 60 ~f:(fun j -> (j * 7 + 3) land 0xFF) in
  let octets = Dv_xgmii.Frame.with_fcs payload in
  if not (Dv_xgmii.Frame.residue_ok octets)
  then failwith "M03-B1: test bug — the frame's own FCS does not check out";
  let sched = one_frame ~lane octets in
  let frame = (Dv_xgmii.Arrival.frames sched).(0) in
  let start_cycle = Dv_xgmii.Arrival.start_cycle frame in
  let bench = create () in
  let samples = run bench sched ~drain:8 ~word_at:(preamble_override sched frame ~start_cycle) () in
  let expected = Dv_xgmii.Frame.delivered octets in
  let got = delivered_octets samples in
  if not (List.equal Int.equal got expected)
  then
    failwith
      (String.concat
         [ "M03-B1 (lane "
         ; Int.to_string lane
         ; "): delivered octets differ from the injected frame minus its FCS"
         ]);
  (match tlast_sample samples with
   | None -> failwith (String.concat [ "M03-B1 (lane "; Int.to_string lane; "): no tlast word" ])
   | Some s ->
     if s.out.Dv_monitors.Stream_word.tuser <> 0
     then
       failwith
         (String.concat
            [ "M03-B1 (lane "
            ; Int.to_string lane
            ; "): tuser[0] set on a legal, standard-FCS frame"
            ]));
  if not (List.is_empty (error_pulses samples))
  then
    failwith
      (String.concat
         [ "M03-B1 (lane "; Int.to_string lane; "): an error strobe pulsed on a legal frame" ]);
  account_clean_frame bench frame samples ~aborted:false;
  assert_monitors_clean bench ~row:(String.concat [ "M03-B1 (lane "; Int.to_string lane; ")" ])
;;

let%expect_test "M03-B1: nonstandard preamble filler and SFD octets, both start lanes" =
  run_b1 ~lane:0;
  run_b1 ~lane:4;
  [%expect {||}]
;;

(* ==================================================================== *)
(* Family B, continued (WO-0062): M03-B4, M03-B3, M03-B2.                  *)
(* ==================================================================== *)
(* M03-B4 ("/S/" in lane 4 of a word whose lane 0 carried "/S/", REQ-110,
   REQ-102, §0.7), M03-B3 ("/T/" in a preamble position, REQ-102, REQ-107,
   §0.7, §9 ruling 9), M03-B2 ("/E/" in a preamble position, REQ-102,
   REQ-105, §0.7, §9 row 3). Built in the packet's own risk-ranked review
   order (WO-0062 §4): M03-B4 first ([run_b4]), M03-B3 second ([run_b3]),
   M03-B2 third ([run_b2]) -- test_m03_h.ml's own precedent for writing a
   family file in risk order rather than row-number order, restated here
   since it is this file's first departure from M03-B1's own shape. B1's own
   code above this banner is untouched (WO-0062 §1 deliverable list).

   What all three rows share: every row aborts a frame strictly inside its
   own preamble (REQ-102's third sentence routes a control character at or
   before the frame's first octet to whichever closure REQ-106/107 governs
   for "/T/", REQ-110 for "/S/", REQ-105 for anything else), so every row's
   own aborted frame delivers ZERO octets under §0.7 and has no [tlast] word
   (§9's no-output-word pin) -- never a [tuser] claim on it (M03-E2's
   prohibition, `AP` §4.1, WO-0062 §2 bar 12, WO-0062 T8). All three pinned
   reports land in the START WORD (cycle 3, window [1, 4],
   requirements.md §0.6), because every corrupted preamble position this
   packet drives (4, 5, 3) lies in the start word at the lane it is driven
   at (WO-0062 §5 T6).

   The aborted frame keeps arriving (WO-0062 §5 T2): once a frame closes
   with no new frame opened, [Dv_xgmii.Injection]'s own per-octet walker
   (hand-traced against `injection.ml`'s state machine before trusting
   [fail_cross] on it, WO-0062 §2 bar 2) treats every further octet time as
   ordinary Idle/Discard traffic until the next genuine "/S/" -- so the
   run-wide exact strobe set asserted below, taken over the WHOLE run,
   proves for free that neither the aborted frame's own remaining declared
   octets nor its own auto-placed terminate character (M03-B3) produces
   anything once no frame is open over them. Stated once, here, per
   WO-0062 §3.2's own "trap that is free coverage" -- not re-derived at
   M03-B2's identically-shaped construction, and not banked as either row's
   own separate claim.

   The following frame's start lane is Arrival's, not a guess (WO-0062 §5
   T3): M03-B2 and M03-B3 each drive a SECOND, ordinary [Injection.clean]
   frame case so "the next frame is received intact" has a subject. Its own
   start octet time is [Arrival]'s gap arithmetic applied to the FIRST
   case's own DECLARED array length (test_m03_e.ml's WO-0043 trap answer 2:
   [Arrival.check]'s gap logic has no knowledge of [Injection]'s overrides
   table), not any lane a row might assume by REQ-004 alternation or by
   symmetry with the first case's own lane -- with a 64-octet first declared
   frame and the default 12-octet IFG, the second frame's own start octet
   time is NOT always the opposite lane. [assert_following_frame_intact]
   below therefore always reads [(Dv_xgmii.Arrival.frames sched).(1)]'s own
   [start_octet_time], never assumes one.

   Local helpers, duplicated rather than added to `bench.ml` (WO-0062 §2 bar
   10): [account_dropped_frame] is test_m03_e.ml:139's / test_m03_f.ml:145's
   own helper, in the same shape, for each row's own aborted, genuinely
   [Dv_xgmii.Arrival.frame]-backed first case. [account_forwarded_frame] is
   test_m03_h.ml's own [account_spliced_forwarded], in the same shape, for
   M03-B4's frame B -- the one frame in this file's three rows that
   [Injection] opens from inside the array rather than laying out as its own
   declared frame case, so it has no [Dv_xgmii.Arrival.frame] record for
   {!Bench.account_clean_frame} to read (bench.mli's own docstring names
   this the "frame the stimulus opens" case). Neither is moved into
   `bench.ml`; a machinery consolidation inside a row round is out of scope
   (WO-0062 §2 bar 10), flagged in the Return log, not taken. *)

let fail row msg = failwith (String.concat [ row; ": "; msg ])

let fail_cross row what =
  fail
    row
    (String.concat
       [ "Injection model cross-check disagrees on "
       ; what
       ; " -- report this to dv_lead per WO-0043 section 1; do not silently \
          adopt either derivation"
       ])
;;

(* Duplicated from every other family file's own local helper of the same
   shape rather than shared, per this packet's own convention. *)
let split_at_first_tlast samples =
  let rec go acc = function
    | [] -> List.rev acc, []
    | (s : sample) :: rest ->
      if s.out.Dv_monitors.Stream_word.tlast then List.rev (s :: acc), rest else go (s :: acc) rest
  in
  go [] samples
;;

(* test_m03_e.ml:139 / test_m03_f.ml:145's own shape, duplicated per
   WO-0062 §2 bar 10: a frame that delivers ZERO octets is accounted through
   its STROBE, never through an "emitted" frame_out. *)
let account_dropped_frame bench (frame : Dv_xgmii.Arrival.frame) ~strobe =
  Dv_monitors.Conservation_monitor.frame_in (conservation bench);
  Dv_monitors.Conservation_monitor.discarded (conservation bench) ~strobes:[ strobe ];
  Dv_monitors.Octet_time.Latency.frame_in (latency bench) (Dv_xgmii.Arrival.in_times frame);
  Dv_monitors.Octet_time.Latency.frame_dropped (latency bench)
;;

(* test_m03_h.ml's own [account_spliced_forwarded], duplicated per WO-0062
   §2 bar 10: accounting for a piece that delivers content but has no
   genuine [Arrival.frame] record of its own -- M03-B4's frame B, which
   [Injection] opens from inside the array (module comment above).
   [~received] is the octet count the frame actually RECEIVED while open
   (WO-0059 §7.3 Finding 1 / RV-0057-VERDICT Finding 1: [in_times] must be
   sized by what was received, not by what was delivered). *)
let account_forwarded_frame bench ~start_ot ~received ~delivered ~aborted samples =
  Dv_monitors.Conservation_monitor.frame_in (conservation bench);
  Dv_monitors.Conservation_monitor.frame_out (conservation bench) ~aborted;
  let in_times = Array.init (8 + received) ~f:(fun i -> start_ot + i) in
  Dv_monitors.Octet_time.Latency.frame_in (latency bench) in_times;
  let delivered_pairs = List.map samples ~f:(fun s -> s.cycle, s.out) in
  Dv_monitors.Octet_time.Latency.frame_out
    (latency bench)
    ~expected_octets:delivered
    (Dv_monitors.Octet_time.of_words delivered_pairs)
;;

(* WO-0062 §5 T3: read the second, ordinary frame's own start lane/cycle
   from Arrival, never assume it. Shared by M03-B3 (one lane) and M03-B2
   (two lanes) -- the same four checks (word count, per-word cycle/tkeep,
   content, tuser) every ordinary clean-frame row in this suite makes,
   factored out because this file drives it identically at up to three call
   sites (test_m03_i.ml's own [assert_clean_frame_structure] is the
   precedent for factoring this shape out locally). *)
let assert_following_frame_intact ~row ~label (frame : Dv_xgmii.Arrival.frame) samples octets =
  let start_cycle = Dv_xgmii.Arrival.start_cycle frame in
  let delivered = List.length octets - 4 in
  let words = (delivered + 7) / 8 in
  let expected_tkeep_last =
    if Int.rem delivered 8 = 0 then 0xFF else (1 lsl Int.rem delivered 8) - 1
  in
  if List.length samples <> words
  then
    fail
      row
      (String.concat
         [ label
         ; ": expected "
         ; Int.to_string words
         ; " output words, got "
         ; Int.to_string (List.length samples)
         ]);
  List.iteri samples ~f:(fun m s ->
    let expected_cycle = start_cycle + 3 + m in
    if s.cycle <> expected_cycle
    then fail row (String.concat [ label; ": word "; Int.to_string m; " arrived on the wrong cycle (REQ-019)" ]);
    let expected_tkeep = if m = words - 1 then expected_tkeep_last else 0xFF in
    if s.out.Dv_monitors.Stream_word.tkeep <> expected_tkeep
    then fail row (String.concat [ label; ": word "; Int.to_string m; " tkeep mismatch" ]);
    if m = words - 1
    then
      (if not s.out.Dv_monitors.Stream_word.tlast
       then fail row (String.concat [ label; ": the last word does not carry tlast" ]))
    else if s.out.Dv_monitors.Stream_word.tlast
    then fail row (String.concat [ label; ": word "; Int.to_string m; " unexpectedly carries tlast" ]));
  let tlast_s = List.last_exn samples in
  if tlast_s.out.Dv_monitors.Stream_word.tuser <> 0
  then fail row (String.concat [ label; ": tuser[0] set -- the following frame must be received intact" ]);
  let expected_octets = Dv_xgmii.Frame.delivered octets in
  let got_octets = List.concat_map samples ~f:(fun s -> Dv_monitors.Stream_word.octets s.out) in
  if not (List.equal Int.equal got_octets expected_octets)
  then fail row (String.concat [ label; ": delivered octets differ from its own content minus its FCS" ])
;;

(* ---- M03-B4 -- "/S/" in lane 4 of the word whose lane 0 carried "/S/" -- *)
(* (REQ-110, REQ-102, §0.7; WO-0062 §3.1, ranked 1st, WO-0058 §9 bound 6) *)
(* "No output word for the first frame; exactly one
   error_start_without_terminate; the second frame is received intact and
   correct." Kills: a design that ignores "/S/" while in Preamble -- it
   would mis-align the second frame by four octet times and deliver a
   corrupt frame with a good-looking tkeep.

   Driven at a LANE-0 start ONLY -- position 4 is in-word only at a lane-0
   start (WO-0062 §5 T6); at a lane-4 start, "/S/" at preamble position 4
   lands in lane 0 of the NEXT word, a cross-word abort with the opposite
   offset transition to this row's own -- earned by derivation but not
   commissioned here (WO-0062 §6.2 item 1, dv_lead's own plan edit).

   Construction: ONE Injection frame case, array = 4 filler octets followed
   by a clean 64-octet frame (68 array octets total -- T4's own trap: a
   64-octet array here silently turns this row into a runt test with a
   completely different observable, guarded below before anything is
   asserted), corruption = Place {At_preamble 4; start_char}. At a lane-0
   start (start_ot = 8) this lands at octet time 12, lane 4 -- the SAME
   input word as the outer frame's own "/S/" (lane 0), which is this row's
   whole geometry, and legal under T7 ("/S/" refused only outside lane 0/4;
   [Injection.create]'s own guard, unexercised here since lane 4 is
   allowed). *)

let b4_filler = List.init 4 ~f:(fun j -> 0x70 + j)

let run_b4 () =
  let row = "M03-B4" in
  let frame_b_octets = directed_frame_octets ~length:64 in
  if not (Dv_xgmii.Frame.residue_ok frame_b_octets)
  then fail row "test bug -- frame B's own 64-octet content does not check out";
  let base = b4_filler @ frame_b_octets in
  if List.length base <> 68
  then fail row "test bug -- the array is not 68 octets (4 filler + a 64-octet frame, WO-0062 T4)";
  let case =
    Dv_xgmii.Injection.corrupt
      base
      [ Dv_xgmii.Injection.Place
          { placement = Dv_xgmii.Injection.At_preamble 4
          ; character = Dv_xgmii.Xgmii_word.start_char
          }
      ]
  in
  let inj = Dv_xgmii.Injection.create ~first_lane:0 [ case ] in
  if not (Dv_xgmii.Injection.is_clean inj)
  then
    fail
      row
      (String.concat
         ~sep:"; "
         ("Injection construction errors:" :: Dv_xgmii.Injection.errors inj));
  let sched = Dv_xgmii.Injection.schedule inj in
  let frame_a = (Dv_xgmii.Arrival.frames sched).(0) in
  let start_ot_a = frame_a.Dv_xgmii.Arrival.start_octet_time in
  let start_cycle_a = Dv_xgmii.Arrival.start_cycle frame_a in
  if start_ot_a <> 8
  then fail row "test bug -- frame A's own start is not octet time 8 (lane 0, WO-0062 T6)";
  let close_ot = start_ot_a + 4 in
  if close_ot <> 12 || Int.rem close_ot 8 <> 4
  then fail row "test bug -- the injected \"/S/\" does not land at octet time 12, lane 4";
  let close_cycle = close_ot / 8 in
  if close_cycle <> start_cycle_a
  then fail row "test bug -- the injected \"/S/\" does not land in the start word (WO-0062 T6)";
  let start_ot_b = close_ot in
  let expected_pulse_cycle = close_cycle + 2 in
  let expected_not_before = close_cycle in
  let expected_not_after = close_cycle + 3 in
  let delivered_b = 60 in
  let words_b = 8 in
  let expected_tkeep_b = 0x0F in
  let start_cycle_b = start_ot_b / 8 in
  let expected_tlast_cycle_b = start_cycle_b + 3 + (words_b - 1) in
  (* Two independent derivations agreeing is the cross-check (WO-0062 §2 bar
     2) -- including T4's own guard, restated against the model's own
     number: frame B's RECEIVED count must be 64, not 60. *)
  (match Dv_xgmii.Injection.outcomes inj with
   | [ oa; ob ] ->
     if oa.Dv_xgmii.Injection.delivered <> 0 then fail_cross row "frame A delivered (expected 0)";
     (match oa.Dv_xgmii.Injection.reports with
      | [ r ]
        when String.equal r.Dv_xgmii.Injection.strobe "error_start_without_terminate"
             && r.Dv_xgmii.Injection.cycle = expected_pulse_cycle
             && r.Dv_xgmii.Injection.not_before = expected_not_before
             && r.Dv_xgmii.Injection.not_after = expected_not_after -> ()
      | _ -> fail_cross row "frame A reports");
     if ob.Dv_xgmii.Injection.received <> 64
     then
       fail_cross
         row
         "frame B received (expected 64 -- WO-0062 T4: a 64-octet array would give 60, a \
          runt, a different row entirely)";
     if ob.Dv_xgmii.Injection.delivered <> delivered_b then fail_cross row "frame B delivered";
     if ob.Dv_xgmii.Injection.words <> words_b then fail_cross row "frame B words";
     if ob.Dv_xgmii.Injection.last_tkeep <> expected_tkeep_b then fail_cross row "frame B last_tkeep";
     (match ob.Dv_xgmii.Injection.tlast_cycle with
      | Some c when c = expected_tlast_cycle_b -> ()
      | _ -> fail_cross row "frame B tlast_cycle");
     if not (List.is_empty ob.Dv_xgmii.Injection.reports) then fail_cross row "frame B reports"
   | outcomes ->
     fail_cross
       row
       (String.concat
          [ "outcome count (expected 2: frame A, frame B; got "
          ; Int.to_string (List.length outcomes)
          ; ")"
          ]));
  (* Landing, site 1 (WO-0062 §2 bar 3): the injected "/S/" in the
     SCHEDULE's own word, before a single cycle is driven. *)
  let pre_run_word = Dv_xgmii.Injection.word_at inj ~cycle:close_cycle in
  if (not (Dv_xgmii.Xgmii_word.is_control pre_run_word 4))
     || not (Int.equal (pre_run_word.Dv_xgmii.Xgmii_word.data).(4) Dv_xgmii.Xgmii_word.start_char)
  then fail row "test bug -- the injected \"/S/\" does not land at lane 4 of the intended cycle before driving";
  let bench = create () in
  Dv_monitors.Strobe_monitor.expect
    (strobes bench)
    { Dv_monitors.Strobe_monitor.strobe = "error_start_without_terminate"
    ; frame = 0
    ; cycle = expected_pulse_cycle
    ; not_before = expected_not_before
    ; not_after = expected_not_after
    ; why =
        "REQ-110 (new /S/ while frame A is still inside its own preamble, zero \
         delivered); SPEC-M03 §9's no-output-word pin: two cycles after the input word \
         carrying the closing character, the start word itself (WO-0062 §3.1)"
    };
  let samples =
    run bench sched ~drain:8 ~word_at:(fun ~cycle -> Dv_xgmii.Injection.word_at inj ~cycle) ()
  in
  (* Landing, site 2: the cycle {!run} ACTUALLY drove. *)
  (match List.find samples ~f:(fun s -> s.cycle = close_cycle) with
   | None -> fail row "test bug -- the intended \"/S/\" cycle was never driven"
   | Some s ->
     if (not (Dv_xgmii.Xgmii_word.is_control s.in_word 4))
        || not (Int.equal (s.in_word.Dv_xgmii.Xgmii_word.data).(4) Dv_xgmii.Xgmii_word.start_char)
     then
       fail
         row
         "the driven word at the intended cycle does not carry the injected \"/S/\" in \
          lane 4 -- the assertions below would be vacuous");
  (* Structural, before frame B's own content is trusted (WO-0062 §2 bar 6):
     frame A delivers no word at all -- the run's ONLY delivered words are
     frame B's own. *)
  let words_out = delivered_samples samples in
  if List.length words_out <> words_b
  then
    fail
      row
      (String.concat
         [ "expected frame A to deliver nothing and frame B exactly "
         ; Int.to_string words_b
         ; " output words, got "
         ; Int.to_string (List.length words_out)
         ; " words total"
         ]);
  (* Frame B's delivered CONTENT, compared content for content against
     Frame.delivered of its own 64 octets -- not just tkeep and the count
     (WO-0057 §2.3 / AP §4.H's M03-H2 footnote, restated at WO-0062 §3.1:
     the mis-aligning design this row exists to kill delivers a DIFFERENT
     64-octet run at a different offset, and count/tkeep may not move). *)
  let expected_octets_b = Dv_xgmii.Frame.delivered frame_b_octets in
  let got_octets_b = delivered_octets samples in
  if not (List.equal Int.equal got_octets_b expected_octets_b)
  then
    fail
      row
      "frame B: delivered octets differ from its own 60 -- the row's own kill (WO-0062 \
       §3.1, WO-0057 §2.3)";
  (* Frame B's per-word tkeep, tlast and cycles. *)
  List.iteri words_out ~f:(fun m s ->
    let expected_cycle = start_cycle_b + 3 + m in
    if s.cycle <> expected_cycle
    then fail row (String.concat [ "frame B: word "; Int.to_string m; " arrived on the wrong cycle (REQ-019)" ]);
    let expected_tkeep = if m = words_b - 1 then expected_tkeep_b else 0xFF in
    if s.out.Dv_monitors.Stream_word.tkeep <> expected_tkeep
    then fail row (String.concat [ "frame B: word "; Int.to_string m; " tkeep mismatch" ]);
    if m = words_b - 1
    then
      (if not s.out.Dv_monitors.Stream_word.tlast
       then fail row "frame B: the last word does not carry tlast")
    else if s.out.Dv_monitors.Stream_word.tlast
    then fail row (String.concat [ "frame B: word "; Int.to_string m; " unexpectedly carries tlast" ]));
  (match tlast_sample samples with
   | None -> fail row "frame B: no tlast word observed"
   | Some s ->
     if s.cycle <> expected_tlast_cycle_b
     then fail row "frame B: tlast word did not arrive on its own pinned cycle";
     if s.out.Dv_monitors.Stream_word.tuser <> 0
     then fail row "frame B: tuser[0] set -- the second frame is legal and intact");
  (* The run-wide exact strobe set, last (WO-0062 T2/T5): exactly one pulse,
     that name, that cycle -- over the WHOLE run, drain included, which also
     proves frame A's own report fired (the early structural check above
     already proved nothing else did). *)
  (match error_pulses samples with
   | [ (cycle, name) ] ->
     if not (String.equal name "error_start_without_terminate")
     then fail row (String.concat [ "expected error_start_without_terminate alone, observed "; name ])
     else if cycle <> expected_pulse_cycle
     then fail row "error_start_without_terminate pulsed on the wrong cycle"
   | pulses ->
     fail
       row
       (String.concat
          [ "expected exactly one strobe pulse (error_start_without_terminate alone) over \
             the WHOLE run -- frame A's own declared octets and its own auto-terminate \
             carry frame B, not a leftover event (WO-0062 T2); observed "
          ; Int.to_string (List.length pulses)
          ; " pulse(s)"
          ]));
  (* Conservation: frame A dropped, frame B forwarded/clean (WO-0062 §2 bar
     13). *)
  account_dropped_frame bench frame_a ~strobe:"error_start_without_terminate";
  account_forwarded_frame
    bench
    ~start_ot:start_ot_b
    ~received:64
    ~delivered:delivered_b
    ~aborted:false
    words_out;
  Dv_monitors.Conservation_monitor.strobe_pulse
    (conservation bench)
    ~name:"error_start_without_terminate";
  assert_monitors_clean bench ~row
;;

let%expect_test
  "M03-B4: /S/ in lane 4 of the word whose lane 0 carried the outer frame's \
   own /S/ -- no output word for frame A, exactly one \
   error_start_without_terminate, frame B received intact and correct, \
   content-compared (REQ-110, REQ-102, §0.7, WO-0058 §9 bound 6)"
  =
  run_b4 ();
  [%expect {||}]
;;

(* ---- M03-B3 -- "/T/" in a preamble position (lane 5, lane-0 start) ----- *)
(* (REQ-102, REQ-107, §0.7, §9 ruling 9; WO-0062 §3.2, ranked 2nd) *)
(* "/T/" in lane 5 of a lane-0 start word: no output word; exactly one
   error_runt and no other strobe of any kind -- an exact set -- at the
   pinned cycle; next frame intact. M03-M10's second carrier (WO-0062 §3.2,
   §4): M10 claims two carriers (REQ-106/107's routing and REQ-102's) and
   today only the first is driven; this row is the second.

   Construction: one Injection frame case (a clean 64-octet frame's own
   content, irrelevant to what is delivered since the abort happens
   strictly inside the preamble -- REQ-102 makes it free), corruption =
   Place {At_preamble 5; terminate_char}, first_lane:0, followed by a
   second, ordinary clean Injection frame case so "next frame intact" has a
   subject (WO-0062 §5 T3, [assert_following_frame_intact] above). *)

let run_b3 () =
  let row = "M03-B3" in
  let frame1_octets = directed_frame_octets ~length:64 in
  let frame2_octets = directed_frame_octets ~length:64 in
  if not (Dv_xgmii.Frame.residue_ok frame1_octets)
  then fail row "test bug -- frame 1's own content does not check out";
  if not (Dv_xgmii.Frame.residue_ok frame2_octets)
  then fail row "test bug -- frame 2's own content does not check out";
  let case1 =
    Dv_xgmii.Injection.corrupt
      frame1_octets
      [ Dv_xgmii.Injection.Place
          { placement = Dv_xgmii.Injection.At_preamble 5
          ; character = Dv_xgmii.Xgmii_word.terminate_char
          }
      ]
  in
  let case2 = Dv_xgmii.Injection.clean frame2_octets in
  let inj = Dv_xgmii.Injection.create ~first_lane:0 [ case1; case2 ] in
  if not (Dv_xgmii.Injection.is_clean inj)
  then
    fail
      row
      (String.concat
         ~sep:"; "
         ("Injection construction errors:" :: Dv_xgmii.Injection.errors inj));
  let sched = Dv_xgmii.Injection.schedule inj in
  let frame1 = (Dv_xgmii.Arrival.frames sched).(0) in
  let frame2 = (Dv_xgmii.Arrival.frames sched).(1) in
  let start_ot1 = frame1.Dv_xgmii.Arrival.start_octet_time in
  let start_cycle1 = Dv_xgmii.Arrival.start_cycle frame1 in
  if start_ot1 <> 8
  then fail row "test bug -- frame 1's own start is not octet time 8 (lane 0)";
  let close_ot = start_ot1 + 5 in
  if close_ot <> 13 || Int.rem close_ot 8 <> 5
  then fail row "test bug -- the injected \"/T/\" does not land at octet time 13, lane 5";
  let close_cycle = close_ot / 8 in
  if close_cycle <> start_cycle1
  then fail row "test bug -- the injected \"/T/\" does not land in the start word (WO-0062 T6)";
  let expected_pulse_cycle = close_cycle + 2 in
  let expected_not_before = close_cycle in
  let expected_not_after = close_cycle + 3 in
  (match Dv_xgmii.Injection.outcomes inj with
   | [ o1; o2 ] ->
     if o1.Dv_xgmii.Injection.delivered <> 0 then fail_cross row "frame 1 delivered (expected 0)";
     (match o1.Dv_xgmii.Injection.reports with
      | [ r ]
        when String.equal r.Dv_xgmii.Injection.strobe "error_runt"
             && r.Dv_xgmii.Injection.cycle = expected_pulse_cycle
             && r.Dv_xgmii.Injection.not_before = expected_not_before
             && r.Dv_xgmii.Injection.not_after = expected_not_after -> ()
      | _ -> fail_cross row "frame 1 reports");
     if o2.Dv_xgmii.Injection.delivered <> List.length frame2_octets - 4
     then fail_cross row "frame 2 delivered";
     if not (List.is_empty o2.Dv_xgmii.Injection.reports) then fail_cross row "frame 2 reports"
   | outcomes ->
     fail_cross
       row
       (String.concat
          [ "outcome count (expected 2: frame 1, frame 2; got "
          ; Int.to_string (List.length outcomes)
          ; ")"
          ]));
  (* Landing, site 1. *)
  let pre_run_word = Dv_xgmii.Injection.word_at inj ~cycle:close_cycle in
  if (not (Dv_xgmii.Xgmii_word.is_control pre_run_word 5))
     || not (Int.equal (pre_run_word.Dv_xgmii.Xgmii_word.data).(5) Dv_xgmii.Xgmii_word.terminate_char)
  then fail row "test bug -- the injected \"/T/\" does not land at lane 5 of the intended cycle before driving";
  let bench = create () in
  Dv_monitors.Strobe_monitor.expect
    (strobes bench)
    { Dv_monitors.Strobe_monitor.strobe = "error_runt"
    ; frame = 0
    ; cycle = expected_pulse_cycle
    ; not_before = expected_not_before
    ; not_after = expected_not_after
    ; why =
        "REQ-102's third sentence routes a /T/ in a preamble position to REQ-106/107's \
         closure with zero octets received; SPEC-M03 §9 ruling 9's sub-5 class gives \
         error_runt alone, two cycles after the input word carrying it (WO-0062 §3.2)"
    };
  let samples =
    run bench sched ~drain:8 ~word_at:(fun ~cycle -> Dv_xgmii.Injection.word_at inj ~cycle) ()
  in
  (* Landing, site 2. *)
  (match List.find samples ~f:(fun s -> s.cycle = close_cycle) with
   | None -> fail row "test bug -- the intended \"/T/\" cycle was never driven"
   | Some s ->
     if (not (Dv_xgmii.Xgmii_word.is_control s.in_word 5))
        || not (Int.equal (s.in_word.Dv_xgmii.Xgmii_word.data).(5) Dv_xgmii.Xgmii_word.terminate_char)
     then
       fail
         row
         "the driven word at the intended cycle does not carry the injected \"/T/\" in \
          lane 5 -- the assertions below would be vacuous");
  (* Structural: frame 1 delivers no word at all (no tlast, no tvalid word
     of its own); the run's only delivered frame is frame 2. T8: no tuser
     claim is made on frame 1, which has no tlast word to carry one. *)
  let words1_out, rest = split_at_first_tlast (delivered_samples samples) in
  let words2_out, _ = split_at_first_tlast rest in
  if not (List.is_empty words1_out)
  then fail row "frame 1: an output word was observed for a frame that must deliver nothing (§0.7)";
  if List.is_empty words2_out
  then fail row "expected frame 2's own delivered words, got none";
  (* Frame 2 -- the anti-vacuity partner: "next frame intact" has a
     subject, at whatever lane/cycle Arrival actually gave it (WO-0062 T3). *)
  assert_following_frame_intact ~row ~label:"frame 2" frame2 words2_out frame2_octets;
  (* The exact strobe set, over the WHOLE run, is the row: error_runt
     alone, with an EXPLICIT no-error_bad_fcs assertion (WO-0062 §3.2 /
     M03-M10's own kill, reached through REQ-102's routing rather than
     REQ-106/107's): at zero received octets the CRC register still holds
     SPEC-M03 §6.1's 0x00000000 seed, which is not REQ-304's residue, so a
     design running the residue comparison at every terminate character --
     including one it never opened a payload for -- would pulse
     error_bad_fcs here and this check would catch it. This same check also
     covers, for free, T2's own trap: frame 1's own declared octets
     (16 .. 79) and its own auto-placed "/T/" (80) arrive with no frame open
     and must produce nothing, which they do here -- not a separate row's
     claim (WO-0062 §3.2). *)
  (match error_pulses samples with
   | [ (cycle, name) ] ->
     if not (String.equal name "error_runt")
     then fail row (String.concat [ "expected error_runt alone, observed "; name ])
     else if cycle <> expected_pulse_cycle
     then fail row "error_runt pulsed on the wrong cycle"
   | pulses ->
     fail
       row
       (String.concat
          [ "expected exactly one strobe pulse (error_runt alone -- no error_bad_fcs, \
             M03-M10's own kill) over the WHOLE run, observed "
          ; Int.to_string (List.length pulses)
          ; " pulse(s)"
          ]));
  account_dropped_frame bench frame1 ~strobe:"error_runt";
  account_clean_frame bench frame2 words2_out ~aborted:false;
  Dv_monitors.Conservation_monitor.strobe_pulse (conservation bench) ~name:"error_runt";
  assert_monitors_clean bench ~row
;;

let%expect_test
  "M03-B3: /T/ in lane 5 of a lane-0 start word -- no output word, exactly \
   one error_runt and no other strobe of any kind (an exact set, no \
   error_bad_fcs), next frame received intact (REQ-102, REQ-107, §0.7, §9 \
   ruling 9, M03-M10's second carrier)"
  =
  run_b3 ();
  [%expect {||}]
;;

(* ---- M03-B2 -- "/E/" in a preamble position, both start lanes --------- *)
(* (REQ-102, REQ-105, §0.7, §9 row 3; WO-0062 §3.3, ranked 3rd) *)
(* "/E/" in lane 3 of a lane-0 start word AND lane 7 of the start word at a
   lane-4 start: no output word at all; exactly one error_bad_frame on the
   cycle two after the input word carrying the "/E/"; the next frame is
   received intact.

   test_m03_e.ml's own [run_e5] already sweeps preamble positions 1 .. 7
   with an "/E/" at a LANE-0 start (this row's own lane-0 member is E5's
   position-3 unit, cited here and NOT re-derived; [run_e5] is NOT touched
   -- it is sealed into a closed campaign, F-c7, RV-0050-VERDICT). This
   row's own new content is exactly two things (WO-0062 §3.3): (a) the
   LANE-4 start, which E5 has no member for and where position 3 is
   derived -- not assumed -- to still lie in the start word (WO-0062 T6:
   only positions 4-7 cross into the next word at a lane-4 start); (b) the
   FOLLOWING frame, which no preamble-abort unit in this bench drives at
   either lane.

   Construction: Place {At_preamble 3; error_char}, at BOTH start lanes,
   each followed by a second, ordinary clean Injection frame case (WO-0062
   §5 T3, [assert_following_frame_intact] above). *)

let run_b2 ~lane =
  let row = String.concat [ "M03-B2 (lane "; Int.to_string lane; ")" ] in
  let frame1_octets = directed_frame_octets ~length:64 in
  let frame2_octets = directed_frame_octets ~length:64 in
  if not (Dv_xgmii.Frame.residue_ok frame1_octets)
  then fail row "test bug -- frame 1's own content does not check out";
  if not (Dv_xgmii.Frame.residue_ok frame2_octets)
  then fail row "test bug -- frame 2's own content does not check out";
  let case1 =
    Dv_xgmii.Injection.corrupt
      frame1_octets
      [ Dv_xgmii.Injection.Place
          { placement = Dv_xgmii.Injection.At_preamble 3
          ; character = Dv_xgmii.Xgmii_word.error_char
          }
      ]
  in
  let case2 = Dv_xgmii.Injection.clean frame2_octets in
  let inj = Dv_xgmii.Injection.create ~first_lane:lane [ case1; case2 ] in
  if not (Dv_xgmii.Injection.is_clean inj)
  then
    fail
      row
      (String.concat
         ~sep:"; "
         ("Injection construction errors:" :: Dv_xgmii.Injection.errors inj));
  let sched = Dv_xgmii.Injection.schedule inj in
  let frame1 = (Dv_xgmii.Arrival.frames sched).(0) in
  let frame2 = (Dv_xgmii.Arrival.frames sched).(1) in
  let start_ot1 = frame1.Dv_xgmii.Arrival.start_octet_time in
  let start_cycle1 = Dv_xgmii.Arrival.start_cycle frame1 in
  let expected_start_ot1 = if lane = 0 then 8 else 12 in
  if start_ot1 <> expected_start_ot1
  then fail row "test bug -- frame 1's own start does not match this lane's §0.3 mapping";
  let close_ot = start_ot1 + 3 in
  let close_lane = Int.rem close_ot 8 in
  let expected_close_lane = if lane = 0 then 3 else 7 in
  if close_lane <> expected_close_lane
  then fail row "test bug -- the injected \"/E/\" does not land at this row's own intended lane";
  let close_cycle = close_ot / 8 in
  if close_cycle <> start_cycle1
  then fail row "test bug -- the injected \"/E/\" does not land in the start word (WO-0062 T6)";
  let expected_pulse_cycle = close_cycle + 2 in
  let expected_not_before = close_cycle in
  let expected_not_after = close_cycle + 3 in
  (match Dv_xgmii.Injection.outcomes inj with
   | [ o1; o2 ] ->
     if o1.Dv_xgmii.Injection.delivered <> 0 then fail_cross row "frame 1 delivered (expected 0)";
     (match o1.Dv_xgmii.Injection.reports with
      | [ r ]
        when String.equal r.Dv_xgmii.Injection.strobe "error_bad_frame"
             && r.Dv_xgmii.Injection.cycle = expected_pulse_cycle
             && r.Dv_xgmii.Injection.not_before = expected_not_before
             && r.Dv_xgmii.Injection.not_after = expected_not_after -> ()
      | _ -> fail_cross row "frame 1 reports");
     if o2.Dv_xgmii.Injection.delivered <> List.length frame2_octets - 4
     then fail_cross row "frame 2 delivered";
     if not (List.is_empty o2.Dv_xgmii.Injection.reports) then fail_cross row "frame 2 reports"
   | outcomes ->
     fail_cross
       row
       (String.concat
          [ "outcome count (expected 2: frame 1, frame 2; got "
          ; Int.to_string (List.length outcomes)
          ; ")"
          ]));
  (* Landing, site 1. *)
  let pre_run_word = Dv_xgmii.Injection.word_at inj ~cycle:close_cycle in
  if (not (Dv_xgmii.Xgmii_word.is_control pre_run_word close_lane))
     || not
          (Int.equal
             (pre_run_word.Dv_xgmii.Xgmii_word.data).(close_lane)
             Dv_xgmii.Xgmii_word.error_char)
  then fail row "test bug -- the injected \"/E/\" does not land at the intended octet time before driving";
  let bench = create () in
  Dv_monitors.Strobe_monitor.expect
    (strobes bench)
    { Dv_monitors.Strobe_monitor.strobe = "error_bad_frame"
    ; frame = 0
    ; cycle = expected_pulse_cycle
    ; not_before = expected_not_before
    ; not_after = expected_not_after
    ; why =
        "REQ-105 (error character at or before the frame's first octet, including a \
         preamble position); SPEC-M03 §9 row 3 and the no-output-word pin: two cycles \
         after the input word carrying the /E/, the start word itself at both start \
         lanes (WO-0062 §3.3, citing test_m03_e.ml's run_e5 for the lane-0 arithmetic)"
    };
  let samples =
    run bench sched ~drain:8 ~word_at:(fun ~cycle -> Dv_xgmii.Injection.word_at inj ~cycle) ()
  in
  (* Landing, site 2. *)
  (match List.find samples ~f:(fun s -> s.cycle = close_cycle) with
   | None -> fail row "test bug -- the intended \"/E/\" cycle was never driven"
   | Some s ->
     if (not (Dv_xgmii.Xgmii_word.is_control s.in_word close_lane))
        || not
             (Int.equal (s.in_word.Dv_xgmii.Xgmii_word.data).(close_lane) Dv_xgmii.Xgmii_word.error_char)
     then
       fail
         row
         "the driven word at the intended cycle does not carry the injected \"/E/\" -- \
          the assertions below would be vacuous");
  let words1_out, rest = split_at_first_tlast (delivered_samples samples) in
  let words2_out, _ = split_at_first_tlast rest in
  if not (List.is_empty words1_out)
  then fail row "frame 1: an output word was observed for a frame that must deliver nothing (§0.7)";
  if List.is_empty words2_out
  then fail row "expected frame 2's own delivered words, got none";
  assert_following_frame_intact ~row ~label:"frame 2" frame2 words2_out frame2_octets;
  (match error_pulses samples with
   | [ (cycle, name) ] ->
     if not (String.equal name "error_bad_frame")
     then fail row (String.concat [ "expected error_bad_frame alone, observed "; name ])
     else if cycle <> expected_pulse_cycle
     then fail row "error_bad_frame pulsed on the wrong cycle"
   | pulses ->
     fail
       row
       (String.concat
          [ "expected exactly one strobe pulse (error_bad_frame alone) over the WHOLE \
             run, observed "
          ; Int.to_string (List.length pulses)
          ; " pulse(s)"
          ]));
  account_dropped_frame bench frame1 ~strobe:"error_bad_frame";
  account_clean_frame bench frame2 words2_out ~aborted:false;
  Dv_monitors.Conservation_monitor.strobe_pulse (conservation bench) ~name:"error_bad_frame";
  assert_monitors_clean bench ~row
;;

let%expect_test
  "M03-B2: /E/ in a preamble position, both start lanes (lane 3 of a \
   lane-0 start, lane 7 of a lane-4 start) -- no output word at all, \
   exactly one error_bad_frame two cycles after the input word carrying \
   the /E/, next frame received intact (REQ-102, REQ-105, §0.7, §9 row 3, \
   citing test_m03_e.ml's run_e5 for the lane-0 arithmetic)"
  =
  List.iter [ 0; 4 ] ~f:(fun lane -> run_b2 ~lane);
  [%expect {||}]
;;
