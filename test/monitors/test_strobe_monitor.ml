(* Unit tests for the strobe monitor (WO-0033 X-3), on hand-built traces: no
   Hardcaml, no DUT, so a failure here is the MONITOR's.

   The four checks the .mli enumerates get one case each, and each case is
   shaped so that the monitor a bench would have written by hand — an edge
   counter, or a pulse counter with no cycle pin — passes it. A monitor test
   that only drives conformant traces proves nothing.

   ADR-0005 rule 2: [%expect] blocks are EMPTY and promoted from CI's own diff
   output; every verdict is asserted in OCaml, so a wrong promotion still
   leaves a red test. *)

let failures = ref 0

let check ~what cond =
  if cond
  then Printf.printf "%s: ok\n" what
  else (
    Printf.printf "%s: FAILED\n" what;
    incr failures)
;;

let verdict monitor =
  print_string (Strobe_monitor.report monitor);
  print_newline ();
  if !failures = 0
  then print_endline "VERDICT ok"
  else (
    failures := 0;
    failwith "strobe monitor verdict mismatch")
;;

let m03 () =
  Strobe_monitor.create
    ~name:"M03"
    ~strobes:
      [ "error_bad_fcs"
      ; "error_bad_frame"
      ; "error_runt"
      ; "error_oversize"
      ; "error_start_without_terminate"
      ]
;;

(* A run driven from a cycle-indexed list of high names: [sample] is total over
   the run, which is what C-23's counting convention requires. *)
let drive monitor ~cycles ~high_at =
  for cycle = 0 to cycles - 1 do
    Strobe_monitor.sample monitor ~cycle ~high:(high_at cycle)
  done
;;

let event ?(frame = 0) ?why strobe ~cycle ~not_before ~not_after =
  { Strobe_monitor.strobe
  ; frame
  ; cycle
  ; not_before
  ; not_after
  ; why =
      (match why with
       | Some w -> w
       | None -> "SPEC-M03 §9, strobe cycle pinned")
  }
;;

let%expect_test "X-3 (a): C-23 counts high cycles, so consecutive events are two" =
  (* AP-xgmii_rx_64 row M03-H4: back-to-back start characters, each aborting
     the frame the previous one opened. The strobe stays high across cycles 20
     and 21 and never returns to 0 between them; an edge counter sees ONE
     event. requirements.md §0.6: "a monitor therefore counts high cycles,
     never rising edges". *)
  let monitor = m03 () in
  Strobe_monitor.expect
    monitor
    (event ~frame:0 "error_start_without_terminate" ~cycle:20 ~not_before:19 ~not_after:22);
  Strobe_monitor.expect
    monitor
    (event ~frame:1 "error_start_without_terminate" ~cycle:21 ~not_before:20 ~not_after:23);
  drive monitor ~cycles:30 ~high_at:(fun c ->
    if c = 20 || c = 21 then [ "error_start_without_terminate" ] else []);
  check
    ~what:"two consecutive high cycles are two events"
    (Strobe_monitor.high_cycles monitor "error_start_without_terminate" = 2);
  check ~what:"clean" (Strobe_monitor.is_clean monitor);
  check ~what:"sampled every cycle" (Strobe_monitor.cycles_sampled monitor = 30);
  verdict monitor;
  [%expect {|
    two consecutive high cycles are two events: ok
    clean: ok
    sampled every cycle: ok
    [M03 strobes] cycles=30 expected=2 high-cycles=2
      high cycles per strobe (C-23, never edges): error_bad_fcs=0 error_bad_frame=0 error_runt=0 error_oversize=0 error_start_without_terminate=2
      observed: error_start_without_terminate@20 error_start_without_terminate@21
      strobes: CLEAN (requirements.md §0.6, §12, the module's §9)
    VERDICT ok
    |}]
;;

let%expect_test "X-3 (b): the right strobe on the wrong cycle is a failure" =
  let monitor = m03 () in
  Strobe_monitor.expect monitor (event "error_runt" ~cycle:47 ~not_before:45 ~not_after:49);
  drive monitor ~cycles:60 ~high_at:(fun c -> if c = 48 then [ "error_runt" ] else []);
  check ~what:"one high cycle was seen" (Strobe_monitor.high_cycles monitor "error_runt" = 1);
  check ~what:"but the pin is missed" (not (Strobe_monitor.is_clean monitor));
  check
    ~what:"reported as one missing event and one unclaimed pulse"
    (List.length (Strobe_monitor.missing monitor) = 1
     && List.length (Strobe_monitor.unexpected monitor) = 1);
  print_string (Strobe_monitor.report monitor);
  print_newline ();
  if !failures = 0
  then print_endline "VERDICT ok"
  else (
    failures := 0;
    failwith "strobe monitor verdict mismatch");
  [%expect {|
    one high cycle was seen: ok
    but the pin is missed: ok
    reported as one missing event and one unclaimed pulse: ok
    [M03 strobes] cycles=60 expected=1 high-cycles=1
      high cycles per strobe (C-23, never edges): error_bad_fcs=0 error_bad_frame=0 error_runt=1 error_oversize=0 error_start_without_terminate=0
      observed: error_runt@48
      ERROR: frame 0: error_runt was expected on cycle 47 and was not high there (SPEC-M03 §9, strobe cycle pinned); high cycles for this strobe over the run: 48
      ERROR: cycle 48: M03 pulsed "error_runt" and no expected event claims it — a strobe the stimulus did not create (requirements.md §0.6, REQ-008)
    VERDICT ok
    |}]
;;

let%expect_test "X-3 (c): a pin outside §0.6's window is a SPECIFICATION defect" =
  (* The M03-R2 class, caught at bench construction. §0.6 bounds a strobe at
     the module's latency in cycles after the input word carrying the last
     octet of the offending frame; a bench that computes a pin outside that
     bound has found a spec defect, and the message says so rather than
     blaming a design that has not run yet. *)
  let monitor = m03 () in
  Strobe_monitor.expect
    monitor
    (event
       "error_bad_frame"
       ~cycle:12
       ~not_before:5
       ~not_after:9
       ~why:"a pin deliberately built outside the window");
  check ~what:"the window violation is reported" (not (Strobe_monitor.is_clean monitor));
  check
    ~what:"and it is reported before any sampling has happened"
    (Strobe_monitor.cycles_sampled monitor = 0);
  print_string (Strobe_monitor.report monitor);
  print_newline ();
  if !failures = 0
  then print_endline "VERDICT ok"
  else (
    failures := 0;
    failwith "strobe monitor verdict mismatch");
  [%expect {|
    the window violation is reported: ok
    and it is reported before any sampling has happened: ok
    [M03 strobes] cycles=0 expected=1 high-cycles=0
      high cycles per strobe (C-23, never edges): error_bad_fcs=0 error_bad_frame=0 error_runt=0 error_oversize=0 error_start_without_terminate=0
      observed: none
      ERROR: frame 0: error_bad_frame is pinned at cycle 12, outside requirements.md §0.6's window [5, 9] — this is a defect in the module specification, not in a design (a pin deliberately built outside the window)
      ERROR: frame 0: error_bad_frame was expected on cycle 12 and was not high there (a pin deliberately built outside the window); high cycles for this strobe over the run: none
    VERDICT ok
    |}]
;;

let%expect_test "X-3 (d): a strobe the stimulus did not create" =
  (* The design that pulses error_runt on every good frame passes every
     positive assertion an attack plan makes. Nothing else in the DV machinery
     catches it: the conservation equation balances, because a discard strobe
     with no discarded frame is not a frame. *)
  let monitor = m03 () in
  Strobe_monitor.expect monitor (event "error_runt" ~cycle:30 ~not_before:28 ~not_after:32);
  drive monitor ~cycles:60 ~high_at:(fun c ->
    if c = 30 then [ "error_runt" ] else if c mod 11 = 0 then [ "error_bad_fcs" ] else []);
  check ~what:"the expected report matched" (Strobe_monitor.missing monitor = []);
  check
    ~what:"the six invented pulses are all reported"
    (List.length (Strobe_monitor.unexpected monitor) = 6);
  check ~what:"and the run is not clean" (not (Strobe_monitor.is_clean monitor));
  print_string (Strobe_monitor.report monitor);
  print_newline ();
  if !failures = 0
  then print_endline "VERDICT ok"
  else (
    failures := 0;
    failwith "strobe monitor verdict mismatch");
  [%expect {|
    the expected report matched: ok
    the six invented pulses are all reported: ok
    and the run is not clean: ok
    [M03 strobes] cycles=60 expected=1 high-cycles=7
      high cycles per strobe (C-23, never edges): error_bad_fcs=6 error_bad_frame=0 error_runt=1 error_oversize=0 error_start_without_terminate=0
      observed: error_bad_fcs@0 error_bad_fcs@11 error_bad_fcs@22 error_bad_fcs@33 error_bad_fcs@44 error_bad_fcs@55 error_runt@30
      ERROR: cycle 0: M03 pulsed "error_bad_fcs" and no expected event claims it — a strobe the stimulus did not create (requirements.md §0.6, REQ-008)
      ERROR: cycle 11: M03 pulsed "error_bad_fcs" and no expected event claims it — a strobe the stimulus did not create (requirements.md §0.6, REQ-008)
      ERROR: cycle 22: M03 pulsed "error_bad_fcs" and no expected event claims it — a strobe the stimulus did not create (requirements.md §0.6, REQ-008)
      ERROR: cycle 33: M03 pulsed "error_bad_fcs" and no expected event claims it — a strobe the stimulus did not create (requirements.md §0.6, REQ-008)
      ERROR: cycle 44: M03 pulsed "error_bad_fcs" and no expected event claims it — a strobe the stimulus did not create (requirements.md §0.6, REQ-008)
      ERROR: cycle 55: M03 pulsed "error_bad_fcs" and no expected event claims it — a strobe the stimulus did not create (requirements.md §0.6, REQ-008)
    VERDICT ok
    |}]
;;

let%expect_test "X-3: a name outside §12, and a name outside this module's §9" =
  let monitor = Strobe_monitor.create ~name:"M03" ~strobes:[ "error_runt"; "error_oops" ] in
  Strobe_monitor.sample monitor ~cycle:0 ~high:[ "error_ip_fragment" ];
  check ~what:"an invented roster name is rejected" (not (Strobe_monitor.is_clean monitor));
  check
    ~what:"two errors: the roster name and the foreign strobe"
    (List.length (Strobe_monitor.errors monitor) >= 2);
  print_string (Strobe_monitor.report monitor);
  print_newline ();
  if !failures = 0
  then print_endline "VERDICT ok"
  else (
    failures := 0;
    failwith "strobe monitor verdict mismatch");
  [%expect {|
    an invented roster name is rejected: ok
    two errors: the roster name and the foreign strobe: ok
    [M03 strobes] cycles=1 expected=0 high-cycles=1
      high cycles per strobe (C-23, never edges): error_runt=0 error_oops=0
      observed: error_ip_fragment@0
      ERROR: roster names "error_oops", which requirements.md §12 does not define; a strobe outside §12 is an invisible way to satisfy a check
      ERROR: cycle 0: M03 pulsed "error_ip_fragment", which its §9 does not own
      ERROR: cycle 0: M03 pulsed "error_ip_fragment" and no expected event claims it — a strobe the stimulus did not create (requirements.md §0.6, REQ-008)
    VERDICT ok
    |}]
;;
