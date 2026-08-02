(* Unit tests for the idle-injection wrapper (WO-0033 X-4).

   No design is present, so what is testable is the wrapper's own contract: that
   §10's three figures produce the schedule they claim, that REQ-016's "delays
   every later octet by exactly 8 octet times per cycle" is what [in_times]
   computes, and — the deliverable as much as the wrapper is — that the M03-N3
   constraint refuses the one boundary per frame SPEC-M03 §6.1 refuses, at both
   start lanes, with C-45's lane-0 instances named separately.

   ADR-0005 rule 2: [%expect] blocks are EMPTY and promoted from CI's own diff
   output; every verdict is asserted in OCaml. *)

let failures = ref 0

let check ~what cond =
  if cond
  then Printf.printf "%s: ok\n" what
  else (
    Printf.printf "%s: FAILED\n" what;
    incr failures)
;;

let verdict wrapper =
  print_string (Idle_injection.report wrapper);
  print_newline ();
  if !failures = 0
  then print_endline "VERDICT ok"
  else (
    failures := 0;
    failwith "idle injection verdict mismatch")
;;

let three_frames () = Arrival.stress ~count:3 ()

(* The invariants that hold at every figure, checked without recomputing the
   wrapper's own site arithmetic — which would make the test a copy of the
   implementation rather than a check on it. *)
let invariants wrapper ~label =
  let sched = Idle_injection.schedule wrapper in
  let n = Arrival.cycles sched in
  check
    ~what:(Printf.sprintf "%s: cycles = source + injected" label)
    (Idle_injection.cycles wrapper = n + Idle_injection.injected wrapper);
  let ordered = ref true
  and preserved = ref true
  and previous = ref (-1) in
  for c = 0 to n - 1 do
    let target = Idle_injection.cycle_of wrapper c in
    if target <= !previous then ordered := false;
    previous := target;
    if not
         (Xgmii_word.equal
            (Idle_injection.word_at wrapper ~cycle:target)
            (Arrival.word_at sched ~cycle:c))
    then preserved := false
  done;
  check ~what:(Printf.sprintf "%s: cycle_of is strictly increasing" label) !ordered;
  check ~what:(Printf.sprintf "%s: every source word survives" label) !preserved;
  let all_idle = ref true in
  for c = 0 to Idle_injection.cycles wrapper - 1 do
    if Idle_injection.is_injected wrapper ~cycle:c
       && not (Xgmii_word.is_idle (Idle_injection.word_at wrapper ~cycle:c))
    then all_idle := false
  done;
  check ~what:(Printf.sprintf "%s: every injected cycle is an idle word" label) !all_idle
;;

let%expect_test "X-4: §10's three figures — 0, 1 and 7 injected cycles" =
  let sched = three_frames () in
  let zero = Idle_injection.uniform sched ~idles:0 in
  check ~what:"0 cycles injects nothing" (Idle_injection.injected zero = 0);
  check
    ~what:"0 cycles is the source schedule unchanged"
    (Idle_injection.cycles zero = Arrival.cycles sched);
  invariants zero ~label:"idles=0";
  check ~what:"0 cycles is constraint-clean" (Idle_injection.is_clean zero);
  let one = Idle_injection.uniform sched ~idles:1 in
  invariants one ~label:"idles=1";
  check ~what:"1 cycle is constraint-clean" (Idle_injection.is_clean one);
  let seven = Idle_injection.uniform sched ~idles:7 in
  invariants seven ~label:"idles=7";
  check ~what:"7 cycles is constraint-clean" (Idle_injection.is_clean seven);
  check
    ~what:"7 injects exactly seven times what 1 injects"
    (Idle_injection.injected seven = 7 * Idle_injection.injected one);
  verdict seven;
  [%expect {|
    0 cycles injects nothing: ok
    0 cycles is the source schedule unchanged: ok
    idles=0: cycles = source + injected: ok
    idles=0: cycle_of is strictly increasing: ok
    idles=0: every source word survives: ok
    idles=0: every injected cycle is an idle word: ok
    0 cycles is constraint-clean: ok
    idles=1: cycles = source + injected: ok
    idles=1: cycle_of is strictly increasing: ok
    idles=1: every source word survives: ok
    idles=1: every injected cycle is an idle word: ok
    1 cycle is constraint-clean: ok
    idles=7: cycles = source + injected: ok
    idles=7: cycle_of is strictly increasing: ok
    idles=7: every source word survives: ok
    idles=7: every injected cycle is an idle word: ok
    7 cycles is constraint-clean: ok
    7 injects exactly seven times what 1 injects: ok
    [idle injection] sites=24 idles=168 source cycles=34 injected cycles=202 allow_c45=false
      idles per site: 7
      C-45 boundaries touched: none
      M03-N3 constraint: SATISFIED (SPEC-M03 §6.1 at 06c1eba)
    VERDICT ok
    |}]
;;

let%expect_test "X-4: REQ-016 delays every later octet by exactly 8 octet times" =
  (* The wrapper's own arithmetic against REQ-016's sentence, octet by octet:
     an octet's injected octet time exceeds its source octet time by 8 for each
     idle word inserted before the word that carries it, and by nothing else —
     in particular its lane within its word never moves. *)
  let sched = three_frames () in
  let wrapper = Idle_injection.uniform sched ~idles:7 in
  let frames = Arrival.frames sched in
  let lanes_held = ref true
  and multiples = ref true
  and monotone = ref true in
  Array.iter
    (fun f ->
      let source = Arrival.in_times f in
      let injected = Idle_injection.in_times wrapper f in
      if Array.length source <> Array.length injected then multiples := false;
      Array.iteri
        (fun k source_time ->
          let delta = injected.(k) - source_time in
          if delta mod 8 <> 0 || delta < 0 then multiples := false;
          if injected.(k) mod 8 <> source_time mod 8 then lanes_held := false;
          if k > 0 && injected.(k) <= injected.(k - 1) then monotone := false)
        source)
    frames;
  check ~what:"every shift is a non-negative multiple of 8" !multiples;
  check ~what:"no octet changes lane within its word" !lanes_held;
  check ~what:"octet times stay strictly increasing" !monotone;
  (* and the preamble is untouched: the constraint's whole point is that the
     eight octets from the start character inclusive are contiguous *)
  let preamble_contiguous = ref true in
  Array.iter
    (fun f ->
      let injected = Idle_injection.in_times wrapper f in
      for k = 1 to 8 do
        if injected.(k) <> injected.(0) + k then preamble_contiguous := false
      done)
    frames;
  check
    ~what:"the frame's first octet is still 8 octet times after its start character"
    !preamble_contiguous;
  verdict wrapper;
  [%expect {|
    every shift is a non-negative multiple of 8: ok
    no octet changes lane within its word: ok
    octet times stay strictly increasing: ok
    the frame's first octet is still 8 octet times after its start character: ok
    [idle injection] sites=24 idles=168 source cycles=34 injected cycles=202 allow_c45=false
      idles per site: 7
      C-45 boundaries touched: none
      M03-N3 constraint: SATISFIED (SPEC-M03 §6.1 at 06c1eba)
    VERDICT ok
    |}]
;;

let%expect_test "X-4: the M03-N3 constraint refuses one boundary per frame" =
  (* SPEC-M03 §6.1 at 06c1eba. The stress schedule alternates start lanes, so
     frame 0 starts at lane 0 and frame 1 at lane 4 — one instance of each
     ground in one schedule. *)
  let sched = three_frames () in
  let frames = Arrival.frames sched in
  check
    ~what:"frame 0 starts in lane 0 and frame 1 in lane 4"
    (frames.(0).Arrival.start_lane = 0
     && frames.(1).Arrival.start_lane = 4);
  let site f =
    { Idle_injection.before_cycle = Arrival.start_cycle f + 1; idles = 1 }
  in
  let lane0 = Idle_injection.create sched ~sites:[ site frames.(0) ] in
  check ~what:"the lane-0 boundary is refused" (not (Idle_injection.is_clean lane0));
  check
    ~what:"and it is named as a C-45 instance"
    (Idle_injection.c45_sites lane0
     = [ Arrival.start_cycle frames.(0) + 1 ]);
  let lane4 = Idle_injection.create sched ~sites:[ site frames.(1) ] in
  check ~what:"the lane-4 boundary is refused" (not (Idle_injection.is_clean lane4));
  check
    ~what:"and it is NOT a C-45 instance — it really does occupy preamble positions"
    (Idle_injection.c45_sites lane4 = []);
  (* ~allow_c45 releases the lane-0 boundary and nothing else. It is false by
     default and may be set only once C-45 lands as a spec diff. *)
  let released = Idle_injection.create ~allow_c45:true sched ~sites:[ site frames.(0) ] in
  check ~what:"~allow_c45:true admits the lane-0 boundary" (Idle_injection.is_clean released);
  let still_refused =
    Idle_injection.create ~allow_c45:true sched ~sites:[ site frames.(1) ]
  in
  check
    ~what:"~allow_c45:true does NOT admit the lane-4 boundary"
    (not (Idle_injection.is_clean still_refused));
  print_string (Idle_injection.report lane0);
  print_newline ();
  print_string (Idle_injection.report lane4);
  print_newline ();
  if !failures = 0
  then print_endline "VERDICT ok"
  else (
    failures := 0;
    failwith "idle injection verdict mismatch");
  [%expect {|
    frame 0 starts in lane 0 and frame 1 in lane 4: ok
    the lane-0 boundary is refused: ok
    and it is named as a C-45 instance: ok
    the lane-4 boundary is refused: ok
    and it is NOT a C-45 instance — it really does occupy preamble positions: ok
    ~allow_c45:true admits the lane-0 boundary: ok
    ~allow_c45:true does NOT admit the lane-4 boundary: ok
    [idle injection] sites=1 idles=1 source cycles=34 injected cycles=35 allow_c45=false
      idles per site: 1
      C-45 boundaries touched: 2
      VIOLATION: site before cycle 2 lies between frame 0's start character (lane 0, cycle 1) and its first octet. SPEC-M03 §6.1 refuses it — 'injection begins at the frame's first octet' — and this wrapper implements the constraint AS WRITTEN. Ledger row C-45 records that the prohibition's stated ground does not hold here, since all eight preamble positions lie inside the start word and this boundary occupies none of them; the second ground (the first octet would no longer be 8 octet times after the start character) does hold. Pass ~allow_c45:true only once C-45 has landed as a spec diff
    [idle injection] sites=1 idles=1 source cycles=34 injected cycles=35 allow_c45=false
      idles per site: 1
      C-45 boundaries touched: none
      VIOLATION: site before cycle 12 lies inside frame 1's preamble (lane-4 start at cycle 11): an injected idle there occupies a preamble position, which REQ-102's third sentence routes to REQ-105, so the wrapper would be measuring an abort rather than REQ-016's tolerance (SPEC-M03 §6.1, M03-N3 at 06c1eba)
    VERDICT ok
    |}]
;;

let%expect_test "X-4: an illegal site is applied as well as reported" =
  (* A wrapper that quietly dropped the prohibited site would let a bench pass
     while driving a stimulus it did not intend. It is applied, so the abort it
     provokes is visible, AND reported, so the bench knows why. *)
  let sched = three_frames () in
  let frames = Arrival.frames sched in
  let boundary = Arrival.start_cycle frames.(1) + 1 in
  let wrapper =
    Idle_injection.create sched ~sites:[ { Idle_injection.before_cycle = boundary; idles = 3 } ]
  in
  check ~what:"reported" (not (Idle_injection.is_clean wrapper));
  check ~what:"and applied" (Idle_injection.injected wrapper = 3);
  check
    ~what:"the three injected cycles are where the site put them"
    (Idle_injection.is_injected wrapper ~cycle:boundary
     && Idle_injection.is_injected wrapper ~cycle:(boundary + 2)
     && not (Idle_injection.is_injected wrapper ~cycle:(boundary + 3)));
  (* a site outside the schedule is dropped, and says so *)
  let outside =
    Idle_injection.create
      sched
      ~sites:[ { Idle_injection.before_cycle = 10_000; idles = 1 } ]
  in
  check ~what:"an out-of-range site is reported" (not (Idle_injection.is_clean outside));
  check ~what:"and injects nothing" (Idle_injection.injected outside = 0);
  verdict wrapper;
  [%expect {|
    reported: ok
    and applied: ok
    the three injected cycles are where the site put them: ok
    an out-of-range site is reported: ok
    and injects nothing: ok
    [idle injection] sites=1 idles=3 source cycles=34 injected cycles=37 allow_c45=false
      idles per site: 3
      C-45 boundaries touched: none
      VIOLATION: site before cycle 12 lies inside frame 1's preamble (lane-4 start at cycle 11): an injected idle there occupies a preamble position, which REQ-102's third sentence routes to REQ-105, so the wrapper would be measuring an abort rather than REQ-016's tolerance (SPEC-M03 §6.1, M03-N3 at 06c1eba)
    VERDICT ok
    |}]
;;
