(* Unit tests for octet time and the per-octet latency tagger
   (requirements.md §0.5, FROZEN at f78766e).

   ADR-0005 rule 2: every [%expect] block whose text changed under WO-0012 is
   left EMPTY on purpose and is promoted from CI's own diff output. Each case
   states its expected numbers in OCaml — [expect_int] raises on a mismatch —
   so the verdict does not depend on a promoted snapshot: a promotion that
   captured wrong output would still leave a red test. *)

let failures = ref 0

let expect_int ~what ~expected got =
  if got = expected
  then Printf.printf "%s = %d\n" what got
  else (
    Printf.printf "%s = %d, EXPECTED %d\n" what got expected;
    incr failures)
;;

let verdict tagger ~expect_clean =
  print_string (Octet_time.Latency.report tagger);
  print_newline ();
  if Octet_time.Latency.is_clean tagger = expect_clean && !failures = 0
  then print_endline "VERDICT ok"
  else (
    print_endline "VERDICT WRONG — the tagger did not measure what this case builds";
    failures := 0;
    failwith "latency tagger verdict mismatch")
;;

(* The XGMII arrival walk of J-dv_lead-0002's Evidence item 1, rewritten in
   OCaml so that the D-4 finding is a regression test rather than a paragraph.

   A frame's start character sits at [start_lane] of word [word], so its first
   frame octet (after the eight preamble octets) has octet time
   [8*word + start_lane + 8]. The module emits its first output word [d] cycles
   after the last input word it needs, and its output stream is word-aligned
   (REQ-021), so output octet k has octet time [8*(co + k/8) + (k mod 8)]. *)
let walk ~start_lane ~d ~octets =
  let word = 10 in
  let t0 = (8 * word) + start_lane + 8 in
  let co = ((t0 + 7) / 8) + d in
  let input = Array.init octets (fun k -> t0 + k) in
  let output = Array.init octets (fun k -> (8 * (co + (k / 8))) + (k mod 8)) in
  input, output
;;

let cycle_metric input output =
  let distinct = ref [] in
  Array.iteri
    (fun k out_time ->
      let value = (out_time / 8) - (input.(k) / 8) in
      if not (List.exists (fun v -> v = value) !distinct) then distinct := value :: !distinct)
    output;
  List.sort compare !distinct
;;

(* SPEC-M03 §6.1, §7 and §8 made executable: one conformant frame at the XGMII
   receive boundary. Eight preamble octets from the start character inclusive
   (REQ-102), then [frame_octets] octets DA through FCS (requirements.md §0.3),
   of which the last four are the FCS M03 removes (REQ-103). The first output
   word leaves [delta_c] cycles after the word carrying the start character
   (SPEC-M03 §7's measurement events) and is word-aligned (REQ-021).

   This is the input trace a bench hands to [frame_in]: every octet of the
   frame at the module's input, in wire order, preamble included. *)
let m03_frame ~start_cycle ~start_lane ~frame_octets ~delta_c =
  let s = Octet_time.of_xgmii ~cycle:start_cycle ~lane:start_lane in
  let in_times = Array.init (8 + frame_octets) (fun k -> s + k) in
  let co = start_cycle + delta_c in
  let out_times =
    Array.init (frame_octets - 4) (fun j ->
      Octet_time.of_axi64 ~cycle:(co + (j / 8)) ~byte_position:(j mod 8))
  in
  in_times, out_times
;;

let m03_tagger ~name ~front_offsets =
  Octet_time.Latency.create
    ~name
    ~strip_octets:8 (* REQ-102: the eight preamble octets *)
    ~tail_octets:4 (* REQ-103: the four FCS octets *)
    ~front_offsets
    ~ceiling:4 (* requirements.md §1.1 *)
    ()
;;

let%expect_test "octet time is 8 x cycle + position, on both port kinds" =
  Printf.printf "xgmii cycle 10 lane 0 -> %d\n" (Octet_time.of_xgmii ~cycle:10 ~lane:0);
  Printf.printf "xgmii cycle 10 lane 4 -> %d\n" (Octet_time.of_xgmii ~cycle:10 ~lane:4);
  Printf.printf "axi64 cycle 10 byte 0 -> %d\n" (Octet_time.of_axi64 ~cycle:10 ~byte_position:0);
  Printf.printf "axi64 cycle 10 byte 7 -> %d\n" (Octet_time.of_axi64 ~cycle:10 ~byte_position:7);
  (* SPEC-M01 §6.3 item 5 again: a word with tvalid = 0 contributes no octet
     time, and only positions whose tkeep bit is set contribute one. *)
  let words =
    [ 3, Stream_word.of_octets [ 1; 2; 3; 4; 5; 6; 7; 8 ]
    ; 4, Stream_word.garbage_idle ()
    ; 5, Stream_word.of_octets ~tlast:true [ 9; 10; 11 ]
    ]
  in
  let times = Octet_time.of_words words in
  Printf.printf
    "octet times: %s\n"
    (String.concat " " (List.map string_of_int (Array.to_list times)));
  if Array.length times <> 11 then failwith "an idle word contributed octet times";
  [%expect {|
    xgmii cycle 10 lane 0 -> 80
    xgmii cycle 10 lane 4 -> 84
    axi64 cycle 10 byte 0 -> 80
    axi64 cycle 10 byte 7 -> 87
    octet times: 24 25 26 27 28 29 30 31 40 41 42
    |}]
;;

let%expect_test "D-4: the cycle metric takes two values at a lane-4 start, octet time one" =
  (* This is the defect that survived my own WO-0003 review and that the
     architect caught: the word-in-to-word-out metric names no single event at
     a lane-4 start, so a monitor built on it fails a conformant Xgmii_rx_64 on
     its first lane-4 frame. In octet times the realignment cancels exactly.
     Both halves are asserted here so the finding cannot regress quietly.

     The input trace here begins at the frame's first octet rather than at the
     start character, so the §0.5 front offset of this walk is 0 at a lane-0
     start and 4 at a lane-4 start — "the position, within the input word named
     by the measurement event, of the frame's first octet", with nothing
     stripped. [Octet_time.front_offset] is that sum. *)
  List.iter
    (fun start_lane ->
      let input, output = walk ~start_lane ~d:2 ~octets:64 in
      let tagger =
        Octet_time.Latency.create
          ~name:(Printf.sprintf "lane%d" start_lane)
          ~strip_octets:0
          ~tail_octets:0
          ~front_offsets:[ Octet_time.front_offset ~strip_octets:0 ~start_lane ]
          ()
      in
      Octet_time.Latency.frame_in tagger input;
      Octet_time.Latency.frame_out tagger output;
      Printf.printf
        "start lane %d: octet-time latencies %s; cycle-metric values %s\n"
        start_lane
        (String.concat ";" (List.map string_of_int (Octet_time.Latency.distinct tagger)))
        (String.concat ";" (List.map string_of_int (cycle_metric input output))))
    [ 0; 4 ];
  let input0, output0 = walk ~start_lane:0 ~d:2 ~octets:64 in
  let input4, output4 = walk ~start_lane:4 ~d:2 ~octets:64 in
  let lane0 = cycle_metric input0 output0 in
  let lane4 = cycle_metric input4 output4 in
  if List.length lane0 <> 1 || List.length lane4 <> 2
  then failwith "the D-4 walk no longer reproduces the defect it documents";
  (* §0.5: the two start lanes yield two constants and SHALL differ by no more
     than 8 octet times (one cycle). *)
  let tagger0 =
    Octet_time.Latency.create
      ~name:"lane0"
      ~strip_octets:0
      ~tail_octets:0
      ~front_offsets:[ 0 ]
      ()
  in
  Octet_time.Latency.frame_in tagger0 input0;
  Octet_time.Latency.frame_out tagger0 output0;
  let tagger4 =
    Octet_time.Latency.create
      ~name:"lane4"
      ~strip_octets:0
      ~tail_octets:0
      ~front_offsets:[ 4 ]
      ()
  in
  Octet_time.Latency.frame_in tagger4 input4;
  Octet_time.Latency.frame_out tagger4 output4;
  (match Octet_time.Latency.constant tagger0, Octet_time.Latency.constant tagger4 with
   | Some a, Some b ->
     Printf.printf "lane-0 L = %d, lane-4 L = %d, difference %d octet times\n" a b (b - a);
     if abs (b - a) > 8 then failwith "the two start-lane constants differ by over one cycle"
   | Some _, None | None, Some _ | None, None ->
     failwith "one of the start lanes did not yield a constant");
  expect_int ~what:"lane-4 L" ~expected:20 (Option.value ~default:(-1) (Octet_time.Latency.constant tagger4));
  expect_int
    ~what:"lane-4 word delay"
    ~expected:3
    (Option.value ~default:(-1) (Octet_time.Latency.word_delay tagger4));
  verdict tagger4 ~expect_clean:true;
  [%expect {|
    start lane 0: octet-time latencies 16; cycle-metric values 2
    start lane 4: octet-time latencies 20; cycle-metric values 2;3
    lane-0 L = 16, lane-4 L = 20, difference 4 octet times
    lane-4 L = 20
    lane-4 word delay = 3
    [lane4] frames=1 octets=64 latency=CONSTANT per front offset (1 class)
      h=4 L=20 word_delay=3 frames=1 octets=64
    VERDICT ok
    |}]
;;

let%expect_test "WO-0010's divergent case: the conflated parameter reports word delay 2" =
  (* The exact trace named in the WO-0010 Return log and in J-dv_lead-0005
     Evidence item 8. A CONFORMANT minimum-length frame at M03's lane-4 start:
     SPEC-M03 §7 pins h = 12, L = 12, word delay 3 against §1.1's ceiling of 4.

     Before WO-0012 [Latency.create] took one [~strip_octets] and used it both
     for octet correspondence (8, the preamble M03 strips under REQ-102) and as
     §0.5's front offset h (12 at a lane-4 start), so [report] printed
     (12 + 8)/8 = 2 for this frame — understating the hardest receive module by
     a cycle in its own sign-off packet, against a figure the specification
     pins. Both formulations are computed here from the same trace: the old one
     is wrong, the new one is right, and the test fails if either changes.

     Note WHY this hid: at a lane-0 start the two quantities coincide at 8, so
     the old formulation is correct there. The conflation was wrong for exactly
     one start lane of one module — which is the module the machinery exists
     for. *)
  expect_int ~what:"SPEC-M03 §7 h at a lane-0 start" ~expected:8
    (Octet_time.front_offset ~strip_octets:8 ~start_lane:0);
  expect_int ~what:"SPEC-M03 §7 h at a lane-4 start" ~expected:12
    (Octet_time.front_offset ~strip_octets:8 ~start_lane:4);
  let check_lane ~start_lane ~expected_l ~expected_old ~expected_refusals =
    let h = Octet_time.front_offset ~strip_octets:8 ~start_lane in
    let in_times, out_times =
      m03_frame ~start_cycle:10 ~start_lane ~frame_octets:64 ~delta_c:3
    in
    let tagger =
      m03_tagger ~name:(Printf.sprintf "xgmii_rx_64 lane %d" start_lane) ~front_offsets:[ h ]
    in
    Octet_time.Latency.frame_in tagger in_times;
    Octet_time.Latency.frame_out tagger out_times;
    let l = Option.value ~default:(-1) (Octet_time.Latency.constant tagger) in
    let fixed = Option.value ~default:(-1) (Octet_time.Latency.word_delay tagger) in
    (* The formulation this work order removes, restated verbatim so that both
       numbers come off one trace rather than out of two runs of two versions:
       (L + strip_octets) / 8, with the octet-correspondence term in h's place
       AND with the truncation that hid the mismatch. Both halves of the defect
       are visible below — the wrong quotient, and the fact that nothing
       objected to a division that did not close. *)
    let conflated = (l + 8) / 8 in
    let refusals =
      match Octet_time.word_cycles ~front_offset:8 l with
      | None -> 1 (* the fixed helper refuses (L + h) mod 8 <> 0 (§0.5) *)
      | Some _ -> 0
    in
    Printf.printf
      "lane %d: h=%d L=%d word delay: conflated=%d fixed=%d (SPEC-M03 §7 pins 3); the \
       fixed helper refuses the conflated pairing: %s\n"
      start_lane
      h
      l
      conflated
      fixed
      (if refusals = 1 then "yes" else "no");
    expect_int ~what:(Printf.sprintf "lane %d L" start_lane) ~expected:expected_l l;
    expect_int ~what:(Printf.sprintf "lane %d word delay (fixed)" start_lane) ~expected:3 fixed;
    expect_int
      ~what:(Printf.sprintf "lane %d word delay (conflated, truncating)" start_lane)
      ~expected:expected_old
      conflated;
    expect_int
      ~what:(Printf.sprintf "lane %d: (L + 8) refused as not closing mod 8" start_lane)
      ~expected:expected_refusals
      refusals;
    tagger
  in
  (* At a lane-0 start the two quantities coincide, the division closes, and
     the old formulation is right — which is why nothing caught this. *)
  let _lane0 = check_lane ~start_lane:0 ~expected_l:16 ~expected_old:3 ~expected_refusals:0 in
  let lane4 = check_lane ~start_lane:4 ~expected_l:12 ~expected_old:2 ~expected_refusals:1 in
  (* (L + h) = 24 in both rows, which is what makes the word delay a whole
     number (requirements.md §0.5); the superseded floor(L/8) gives 1 at a
     lane-4 start and is why C-1 existed at all. *)
  expect_int ~what:"lane-4 (L + h)" ~expected:24 (12 + 12);
  expect_int ~what:"lane-4 floor(L/8), the superseded unit" ~expected:1 (Octet_time.cycles_floor 12);
  verdict lane4 ~expect_clean:true;
  [%expect {|
    SPEC-M03 §7 h at a lane-0 start = 8
    SPEC-M03 §7 h at a lane-4 start = 12
    lane 0: h=8 L=16 word delay: conflated=3 fixed=3 (SPEC-M03 §7 pins 3); the fixed helper refuses the conflated pairing: no
    lane 0 L = 16
    lane 0 word delay (fixed) = 3
    lane 0 word delay (conflated, truncating) = 3
    lane 0: (L + 8) refused as not closing mod 8 = 0
    lane 4: h=12 L=12 word delay: conflated=2 fixed=3 (SPEC-M03 §7 pins 3); the fixed helper refuses the conflated pairing: yes
    lane 4 L = 12
    lane 4 word delay (fixed) = 3
    lane 4 word delay (conflated, truncating) = 2
    lane 4: (L + 8) refused as not closing mod 8 = 1
    lane-4 (L + h) = 24
    lane-4 floor(L/8), the superseded unit = 1
    [xgmii_rx_64 lane 4] frames=1 octets=60 latency=CONSTANT per front offset (1 class)
      h=12 L=12 word_delay=3 <= ceiling 4 frames=1 octets=60
    VERDICT ok
    |}]
;;

let%expect_test "SPEC-M03 §8: alternating start lanes give one L per lane, one word delay" =
  (* §8's stress schedule drives 10 000 minimum-length frames with the start
     character alternating lane 0 and lane 4, and check 3 asks for per-octet
     latency "constant and equal to 16 octet times for every lane-0-start frame
     and 12 for every lane-4-start frame — one value per start lane across all
     10 000 frames, not a mean". A tagger demanding a single L over that run
     would fail a conformant M03 on its second frame; §0.5's "Start lanes"
     paragraph is what makes two constants correct. Six frames stand in for
     10 000 — the arithmetic does not change with the count. *)
  let tagger = m03_tagger ~name:"xgmii_rx_64 §8" ~front_offsets:[ 8; 12 ] in
  let start = ref (Octet_time.of_xgmii ~cycle:10 ~lane:0) in
  let lanes = ref [] in
  for _ = 1 to 6 do
    let start_cycle = !start / 8 in
    let start_lane = !start mod 8 in
    lanes := start_lane :: !lanes;
    let in_times, out_times =
      m03_frame ~start_cycle ~start_lane ~frame_octets:64 ~delta_c:3
    in
    Octet_time.Latency.frame_in tagger in_times;
    Octet_time.Latency.frame_out tagger out_times;
    (* §0.3: 8 preamble + 64 frame octets + a 12-octet gap counted from the
       terminate character inclusive = 84 octet times between start characters,
       so the start lane alternates by arithmetic rather than by instruction. *)
    start := !start + 84
  done;
  Printf.printf
    "start lanes: %s\n"
    (String.concat " " (List.map string_of_int (List.rev !lanes)));
  List.iter
    (fun (o : Octet_time.Latency.observed) ->
      Printf.printf
        "h=%d L=%s word delay=%s frames=%d\n"
        o.front_offset
        (String.concat ";" (List.map string_of_int o.latencies))
        (match o.word_delay with
         | None -> "(undefined)"
         | Some d -> string_of_int d)
        o.frames)
    (Octet_time.Latency.observed tagger);
  expect_int ~what:"front-offset classes" ~expected:2
    (List.length (Octet_time.Latency.observed tagger));
  expect_int ~what:"distinct L values over the run" ~expected:2
    (List.length (Octet_time.Latency.distinct tagger));
  expect_int ~what:"the single word delay both lanes agree on" ~expected:3
    (Option.value ~default:(-1) (Octet_time.Latency.word_delay tagger));
  if not (Octet_time.Latency.is_constant tagger)
  then failwith "a conformant alternating-lane run was reported as non-constant";
  (* [constant] is None here and that is correct: there is no single L. A
     sign-off packet quotes [word_delay] and the per-class table. *)
  (match Octet_time.Latency.constant tagger with
   | None -> ()
   | Some _ -> failwith "two start-lane constants were collapsed into one");
  verdict tagger ~expect_clean:true;
  [%expect {|
    start lanes: 0 4 0 4 0 4
    h=8 L=16 word delay=3 frames=3
    h=12 L=12 word delay=3 frames=3
    front-offset classes = 2
    distinct L values over the run = 2
    the single word delay both lanes agree on = 3
    [xgmii_rx_64 §8] frames=6 octets=360 latency=CONSTANT per front offset (2 classes)
      h=8 L=16 word_delay=3 <= ceiling 4 frames=3 octets=180
      h=12 L=12 word_delay=3 <= ceiling 4 frames=3 octets=180
    VERDICT ok
    |}]
;;

let%expect_test "§0.5's start-lane bound: a lane-4 word delay two cycles longer is caught" =
  (* §0.5 in word-delay terms: ΔC(lane 4) ∈ { ΔC(lane 0), ΔC(lane 0) + 1 }.
     Anything else makes the two latency constants differ by 12 octet times or
     more, over the 8-octet-time bound REQ-111 states. This is a defect a
     per-lane bench cannot see — each lane on its own is perfectly constant —
     so it belongs to the tagger that holds both. *)
  let tagger = m03_tagger ~name:"lane-skew" ~front_offsets:[ 8; 12 ] in
  let in0, out0 = m03_frame ~start_cycle:10 ~start_lane:0 ~frame_octets:64 ~delta_c:3 in
  let in4, out4 = m03_frame ~start_cycle:21 ~start_lane:4 ~frame_octets:64 ~delta_c:5 in
  Octet_time.Latency.frame_in tagger in0;
  Octet_time.Latency.frame_out tagger out0;
  Octet_time.Latency.frame_in tagger in4;
  Octet_time.Latency.frame_out tagger out4;
  List.iter print_endline (Octet_time.Latency.errors tagger);
  expect_int ~what:"errors reported" ~expected:2 (List.length (Octet_time.Latency.errors tagger));
  if Octet_time.Latency.is_constant tagger = false
  then failwith "each start lane is individually constant here; the defect is between them";
  verdict tagger ~expect_clean:false;
  [%expect {|
    front offset 12: word delay 5 exceeds the requirements.md §1.1 ceiling of 4 (REQ-019)
    front offsets 8 and 12 have word delays 3 and 5; requirements.md §0.5 admits only the same value or one more for the larger front offset (the two latency constants would differ by 12 octet times, over the 8-octet-time bound)
    errors reported = 2
    [lane-skew] frames=2 octets=120 latency=CONSTANT per front offset (2 classes)
      h=8 L=16 word_delay=3 <= ceiling 4 frames=1 octets=60
      h=12 L=28 word_delay=5 > ceiling 4 frames=1 octets=60
      ERROR: front offset 12: word delay 5 exceeds the requirements.md §1.1 ceiling of 4 (REQ-019)
      ERROR: front offsets 8 and 12 have word delays 3 and 5; requirements.md §0.5 admits only the same value or one more for the larger front offset (the two latency constants would differ by 12 octet times, over the 8-octet-time bound)
    VERDICT ok
    |}]
;;

let%expect_test "a producer that does not realign is caught by §0.5's output offset (REQ-021)" =
  (* A 14-octet stripping stage (REQ-021: Ethernet strips 14) whose first
     output octet lands at byte position 4 instead of 0. It declares the output
     offsets its spec §7 pins — [[0]], the default, because it inserts nothing —
     and its observed q of 4 is outside that set. At a module declaring [[0]]
     that report IS REQ-021's producer-side alignment failing; §0.5's q
     paragraph is why the two are one check and not two.

     What this case also shows, and could not before q existed: the DERIVED
     closure error is not a second, independent conviction here, and never was.
     With h and q both computed from the trace,
     (L + h − q) = 8·(⌊out(0)/8⌋ − ⌊in(0)/8⌋) identically — an arithmetic
     identity, not a property of this stimulus — so the closure cannot fail on
     any materialised trace, and before q it was the alignment condition
     reported a second time in different words (that is why this block used to
     print two errors for one defect). The live closure check is [word_cycles]
     applied to figures a specification PINS, asserted directly below; that is
     where the M07/M15 false refusal lived and where it is repaired. *)
  let ci = 3 in
  let co = 6 in
  let strip = 14 in
  let octets = 60 in
  let input = Array.init octets (fun k -> (8 * ci) + k) in
  let output =
    Array.init (octets - strip) (fun j -> (8 * (co + ((j + 4) / 8))) + ((j + 4) mod 8))
  in
  let tagger =
    Octet_time.Latency.create
      ~name:"eth-strip-misaligned"
      ~strip_octets:strip
      ~tail_octets:0
      ~front_offsets:[ 14 ]
      ~ceiling:3
      ()
  in
  Octet_time.Latency.frame_in tagger input;
  Octet_time.Latency.frame_out tagger output;
  List.iter print_endline (Octet_time.Latency.errors tagger);
  expect_int
    ~what:"word_cycles at q = 0 refuses (L + h − q) = 28"
    ~expected:(-1)
    (Option.value ~default:(-1) (Octet_time.word_cycles ~front_offset:14 14));
  expect_int ~what:"errors reported" ~expected:1 (List.length (Octet_time.Latency.errors tagger));
  expect_int
    ~what:"the observed word delay is still measured and reported"
    ~expected:3
    (Option.value ~default:(-1) (Octet_time.Latency.word_delay tagger));
  verdict tagger ~expect_clean:false;
  [%expect {|
    frame 0: the frame's first octet at the output has octet time 52, i.e. byte position 4 of its word, which is not an output offset this module's spec §7 pins (declared: 0) — at a module that inserts nothing this is REQ-021's producer-side alignment failing; at one that inserts, q is (the octets inserted ahead of the frame) mod 8 and, like h, is a property of the module and the start lane and not a free choice (requirements.md §0.5)
    word_cycles at q = 0 refuses (L + h − q) = 28 = -1
    errors reported = 1
    the observed word delay is still measured and reported = 3
    [eth-strip-misaligned] frames=1 octets=46 latency=CONSTANT per front offset (1 class)
      h=14 q=4 L=14 word_delay=3 <= ceiling 3 frames=1 octets=46
      ERROR: frame 0: the frame's first octet at the output has octet time 52, i.e. byte position 4 of its word, which is not an output offset this module's spec §7 pins (declared: 0) — at a module that inserts nothing this is REQ-021's producer-side alignment failing; at one that inserts, q is (the octets inserted ahead of the frame) mod 8 and, like h, is a property of the module and the start lane and not a free choice (requirements.md §0.5)
    VERDICT ok
    |}]
;;

let%expect_test "§0.5's output offset: M07's and M15's pairs are MEASURED, not refused" =
  (* The repair FINDING Q-1's consequence in this lane commissioned
     (J-dv_lead-0180 §6, Open-question 2). Both traces are built from the two
     specifications' own derivations and from no RTL: SPEC-M07 §7 has payload
     octet k accepted at octet time 8C + k and leaving at 8C + 8 + 14 + k, so
     L = 22 with h = 0, q = 14 mod 8 = 6 and ΔC = (22 + 0 − 6)/8 = 2;
     SPEC-M15 §7 is the same at 20 octets, L = 28, q = 4, ΔC = 3. Keyed on h
     alone this tagger returned None for both and printed "no conformant module
     has this pair" — refusing two conformant designs in those words. *)
  let case ~name ~insertion ~expected_l ~expected_q ~expected_delta =
    let c = 5 in
    let payload = 24 in
    let input = Array.init payload (fun k -> (8 * c) + k) in
    let output = Array.init payload (fun k -> (8 * c) + 8 + insertion + k) in
    let tagger =
      Octet_time.Latency.create
        ~name
        ~strip_octets:0
        ~tail_octets:0
        ~front_offsets:[ 0 ]
        ~output_offsets:[ expected_q ]
        ()
    in
    Octet_time.Latency.frame_in tagger input;
    Octet_time.Latency.frame_out tagger output;
    (match Octet_time.Latency.observed tagger with
     | [ (o : Octet_time.Latency.observed) ] ->
       expect_int ~what:(name ^ " h") ~expected:0 o.front_offset;
       expect_int ~what:(name ^ " q") ~expected:expected_q o.output_offset
     | [] | _ :: _ :: _ ->
       print_endline (name ^ ": EXPECTED exactly one front-offset class");
       incr failures);
    expect_int
      ~what:(name ^ " L")
      ~expected:expected_l
      (Option.value ~default:(-1) (Octet_time.Latency.constant tagger));
    expect_int
      ~what:(name ^ " word delay")
      ~expected:expected_delta
      (Option.value ~default:(-1) (Octet_time.Latency.word_delay tagger));
    expect_int
      ~what:(name ^ " errors")
      ~expected:0
      (List.length (Octet_time.Latency.errors tagger));
    tagger
  in
  let m07 = case ~name:"M07" ~insertion:14 ~expected_l:22 ~expected_q:6 ~expected_delta:2 in
  let _m15 = case ~name:"M15" ~insertion:20 ~expected_l:28 ~expected_q:4 ~expected_delta:3 in
  (* The refusal that is removed, and the two that are NOT. A repair that made
     the conversion accept everything would be worse than the defect it cures,
     so the retired default is shown still refusing M07's pair — which is
     correct arithmetic about the pair (h = 0, L = 22) and wrong only when that
     pair is read as a conformant module's whole story — and a triple that does
     not close is shown still refused with q present. *)
  expect_int
    ~what:"the q-free default still refuses M07's (h = 0, L = 22)"
    ~expected:(-1)
    (Option.value ~default:(-1) (Octet_time.word_cycles ~front_offset:0 22));
  expect_int
    ~what:"with q = 6 it returns SPEC-M07 §7's own ΔC"
    ~expected:2
    (Option.value ~default:(-1) (Octet_time.word_cycles ~output_offset:6 ~front_offset:0 22));
  expect_int
    ~what:"with q = 4 it returns SPEC-M15 §7's own ΔC"
    ~expected:3
    (Option.value ~default:(-1) (Octet_time.word_cycles ~output_offset:4 ~front_offset:0 28));
  expect_int
    ~what:"the closure still bites with q present: L = 23, h = 0, q = 6"
    ~expected:(-1)
    (Option.value ~default:(-1) (Octet_time.word_cycles ~output_offset:6 ~front_offset:0 23));
  (* And the case §0.5 makes a SPECIFICATION defect rather than a module one: a
     module that inserts fourteen octets and states no q. The tagger convicts
     the declaration — not the design — and measures ΔC = 2 all the same,
     because the word delay is a property of the trace. *)
  let undeclared =
    let c = 5 in
    let payload = 24 in
    let input = Array.init payload (fun k -> (8 * c) + k) in
    let output = Array.init payload (fun k -> (8 * c) + 8 + 14 + k) in
    let tagger =
      Octet_time.Latency.create
        ~name:"M07 with no q declared"
        ~strip_octets:0
        ~tail_octets:0
        ~front_offsets:[ 0 ]
        ()
    in
    Octet_time.Latency.frame_in tagger input;
    Octet_time.Latency.frame_out tagger output;
    tagger
  in
  List.iter print_endline (Octet_time.Latency.errors undeclared);
  expect_int
    ~what:"undeclared q: errors reported"
    ~expected:1
    (List.length (Octet_time.Latency.errors undeclared));
  expect_int
    ~what:"undeclared q: the word delay is measured anyway"
    ~expected:2
    (Option.value ~default:(-1) (Octet_time.Latency.word_delay undeclared));
  verdict m07 ~expect_clean:true;
  [%expect {|
    M07 h = 0
    M07 q = 6
    M07 L = 22
    M07 word delay = 2
    M07 errors = 0
    M15 h = 0
    M15 q = 4
    M15 L = 28
    M15 word delay = 3
    M15 errors = 0
    the q-free default still refuses M07's (h = 0, L = 22) = -1
    with q = 6 it returns SPEC-M07 §7's own ΔC = 2
    with q = 4 it returns SPEC-M15 §7's own ΔC = 3
    the closure still bites with q present: L = 23, h = 0, q = 6 = -1
    frame 0: the frame's first octet at the output has octet time 62, i.e. byte position 6 of its word, which is not an output offset this module's spec §7 pins (declared: 0) — at a module that inserts nothing this is REQ-021's producer-side alignment failing; at one that inserts, q is (the octets inserted ahead of the frame) mod 8 and, like h, is a property of the module and the start lane and not a free choice (requirements.md §0.5)
    undeclared q: errors reported = 1
    undeclared q: the word delay is measured anyway = 2
    [M07] frames=1 octets=24 latency=CONSTANT per front offset (1 class)
      h=0 q=6 L=22 word_delay=2 frames=1 octets=24
    VERDICT ok
    |}]
;;

let%expect_test "a front offset the spec does not pin is reported, not silently classified" =
  (* The mistake this catches is a bench author's, not a design's: an M03
     tagger built for one start lane and then driven with the other. §0.5 says
     h "is a property of the module and the start lane, is stated in the
     module's specification §7, and is not a free choice", so an observed value
     outside the declared set is a defect in the bench or in the design and
     must not be absorbed into a new class. *)
  let tagger = m03_tagger ~name:"lane-0 only" ~front_offsets:[ 8 ] in
  let in_times, out_times = m03_frame ~start_cycle:10 ~start_lane:4 ~frame_octets:64 ~delta_c:3 in
  Octet_time.Latency.frame_in tagger in_times;
  Octet_time.Latency.frame_out tagger out_times;
  List.iter print_endline (Octet_time.Latency.errors tagger);
  expect_int ~what:"errors reported" ~expected:1 (List.length (Octet_time.Latency.errors tagger));
  verdict tagger ~expect_clean:false;
  [%expect {|
    frame 0: observed front offset h = 12 is not one this module's spec §7 pins (declared: 8) — h is a property of the module and the start lane and is not a free choice (requirements.md §0.5)
    errors reported = 1
    [lane-0 only] frames=1 octets=60 latency=CONSTANT per front offset (1 class)
      h=12 L=12 word_delay=3 <= ceiling 4 frames=1 octets=60
      ERROR: frame 0: observed front offset h = 12 is not one this module's spec §7 pins (declared: 8) — h is a property of the module and the start lane and is not a free choice (requirements.md §0.5)
    VERDICT ok
    |}]
;;

let%expect_test "a stripping stage: constant latency and the word delay §1.1 is in" =
  (* A stage stripping a 14-octet Ethernet header (REQ-021). Its input frame is
     word-aligned at cycle 3, its first output word leaves at cycle 6. §0.5's
     identity gives L = 8(Co - Ci) - h = 8*3 - 14 = 10 octet times, and the word
     delay is (10 + 14)/8 = 3 — M06's §1.1 ceiling exactly. The superseded
     floor(L/8) reads 1 for the same stage, which is the understatement C-1 was
     raised about and the reason §1.1's ceilings are now stated in word delays. *)
  let strip = 14 in
  let ci = 3 in
  let co = 6 in
  let octets = 60 in
  let input = Array.init octets (fun k -> (8 * ci) + k) in
  let output = Array.init (octets - strip) (fun j -> (8 * (co + (j / 8))) + (j mod 8)) in
  let tagger =
    Octet_time.Latency.create
      ~name:"eth-strip"
      ~strip_octets:strip
      ~tail_octets:0
      ~front_offsets:[ 14 ]
      ~ceiling:3
      ()
  in
  Octet_time.Latency.frame_in tagger input;
  Octet_time.Latency.frame_out tagger output;
  expect_int ~what:"L" ~expected:10
    (Option.value ~default:(-1) (Octet_time.Latency.constant tagger));
  expect_int ~what:"word delay" ~expected:3
    (Option.value ~default:(-1) (Octet_time.Latency.word_delay tagger));
  expect_int ~what:"floor(L/8), superseded" ~expected:1 (Octet_time.cycles_floor 10);
  expect_int ~what:"8(Co-Ci)-h" ~expected:10 ((8 * (co - ci)) - strip);
  verdict tagger ~expect_clean:true;
  [%expect {|
    L = 10
    word delay = 3
    floor(L/8), superseded = 1
    8(Co-Ci)-h = 10
    [eth-strip] frames=1 octets=46 latency=CONSTANT per front offset (1 class)
      h=14 L=10 word_delay=3 <= ceiling 3 frames=1 octets=46
    VERDICT ok
    |}]
;;

let%expect_test "a store-and-forward stage is caught: latency grows with the frame" =
  (* REQ-005 prohibits withholding a payload word until the end of its frame.
     A stage that buffers the whole frame before emitting it has a latency that
     grows with frame length, so the tagger must report NOT CONSTANT and name
     the first offending octet rather than averaging the effect away. *)
  let octets = 32 in
  let input = Array.init octets (fun k -> 24 + k) in
  let output = Array.init octets (fun k -> 24 + octets + k) in
  let output = Array.mapi (fun k t -> if k >= 8 then t + 8 else t) output in
  let tagger =
    Octet_time.Latency.create
      ~name:"store-and-forward"
      ~strip_octets:0
      ~tail_octets:0
      ~front_offsets:[ 0 ]
      ()
  in
  Octet_time.Latency.frame_in tagger input;
  Octet_time.Latency.frame_out tagger output;
  (match Octet_time.Latency.first_offender tagger with
   | None -> failwith "a non-constant latency must name its first offender"
   | Some o -> Printf.printf "first offender: %s\n" o);
  verdict tagger ~expect_clean:false;
  [%expect {|
    first offender: frame 0 octet 8 has latency 40 octet times; every earlier octet at front offset 0 had 32 (REQ-005, requirements.md §0.5)
    [store-and-forward] frames=1 octets=32 latency=NOT CONSTANT
      h=0 L=NOT CONSTANT distinct=[32; 40] word_delay=(undefined) frames=1 octets=32
      first offender: frame 0 octet 8 has latency 40 octet times; every earlier octet at front offset 0 had 32 (REQ-005, requirements.md §0.5)
    VERDICT ok
    |}]
;;

let%expect_test "frames are matched in order, and a discarded frame is popped explicitly" =
  let tagger =
    Octet_time.Latency.create
      ~name:"ordered"
      ~strip_octets:0
      ~tail_octets:0
      ~front_offsets:[ 0 ]
      ()
  in
  let frame ~base ~octets = Array.init octets (fun k -> base + k) in
  Octet_time.Latency.frame_in tagger (frame ~base:0 ~octets:16);
  Octet_time.Latency.frame_in tagger (frame ~base:40 ~octets:16);
  Octet_time.Latency.frame_in tagger (frame ~base:80 ~octets:16);
  Octet_time.Latency.frame_out tagger (frame ~base:24 ~octets:16);
  (* the second frame was discarded under §0.6 — the conservation monitor
     records the strobe, the tagger just stops expecting an output for it *)
  Octet_time.Latency.frame_dropped tagger;
  Octet_time.Latency.frame_out tagger (frame ~base:104 ~octets:16);
  expect_int ~what:"L" ~expected:24
    (Option.value ~default:(-1) (Octet_time.Latency.constant tagger));
  verdict tagger ~expect_clean:true;
  [%expect {|
    L = 24
    [ordered] frames=2 octets=32 latency=CONSTANT per front offset (1 class)
      h=0 L=24 word_delay=3 frames=2 octets=32
    VERDICT ok
    |}]
;;

let%expect_test "an output frame with no matching input is an error, not a latency" =
  let tagger =
    Octet_time.Latency.create
      ~name:"surplus"
      ~strip_octets:0
      ~tail_octets:0
      ~front_offsets:[ 0 ]
      ()
  in
  Octet_time.Latency.frame_out tagger (Array.init 8 (fun k -> 100 + k));
  print_string (Octet_time.Latency.report tagger);
  print_newline ();
  (match Octet_time.Latency.errors tagger with
   | [] -> failwith "a surplus output frame must be reported"
   | _ :: _ -> print_endline "VERDICT ok");
  [%expect {|
    [surplus] frames=1 octets=0 latency=(no octet compared)
      ERROR: output frame 0 has no matching input frame (frames out exceed frames in)
    VERDICT ok
    |}]
;;

(* ------------------------------------------------------------------ *)
(* WO-0033 X-5 / X-9 — the per-frame output extent.                    *)
(*                                                                     *)
(* The clean-frame identity (input − strip − tail) is what the WO-0009  *)
(* tagger could express and it is false for every frame either receive  *)
(* module cuts short. These three tests pin the three behaviours the    *)
(* repair has to have: the identity still governs when nothing is       *)
(* declared, a declared extent replaces it without touching the         *)
(* per-octet correspondence, and an impossible extent is an error       *)
(* rather than a silent clamp.                                         *)

let%expect_test "X-5: an M03 frame aborted at octet 12 keeps its FCS octets" =
  (* SPEC-M03 §9 row 2: `/E/` while the frame is open with ≥ 1 octet
     delivered truncates at the octet before the error character and removes
     NO FCS. Twelve frame octets arrived, twelve are delivered — the identity
     would demand 20 − 8 − 4 = 8 and fail a conformant design. Lane-0 start:
     h = 8, L = 16, so output octet j leaves at octet time (8 + j) + 16. *)
  let tagger =
    Octet_time.Latency.create
      ~name:"m03-abort"
      ~strip_octets:8
      ~tail_octets:4
      ~front_offsets:[ 8; 12 ]
      ~ceiling:4
      ()
  in
  Octet_time.Latency.frame_in tagger (Array.init 20 (fun k -> k));
  Octet_time.Latency.frame_out tagger ~expected_octets:12 (Array.init 12 (fun j -> 24 + j));
  expect_int ~what:"octets compared" ~expected:12 (Octet_time.Latency.octets_compared tagger);
  expect_int
    ~what:"L"
    ~expected:16
    (Option.value ~default:(-1) (Octet_time.Latency.constant tagger));
  verdict tagger ~expect_clean:true;
  [%expect {|
    octets compared = 12
    L = 16
    [m03-abort] frames=1 octets=12 latency=CONSTANT per front offset (1 class)
      h=8 L=16 word_delay=3 <= ceiling 4 frames=1 octets=12
    VERDICT ok
    |}]
;;

let%expect_test "X-5: a declared extent equal to the identity is the old behaviour" =
  (* The repair may not change a clean frame's verdict. Same 64-octet frame
     twice: once with the identity, once with the extent stated. *)
  (* The same name for both runs, so the two reports are comparable strings and
     the equality below is the assertion rather than a pair of eyeballed
     snapshots. *)
  let run _label expected_octets =
    let tagger =
      Octet_time.Latency.create
        ~name:"clean"
        ~strip_octets:8
        ~tail_octets:4
        ~front_offsets:[ 8 ]
        ~ceiling:4
        ()
    in
    Octet_time.Latency.frame_in tagger (Array.init 72 (fun k -> k));
    (match expected_octets with
     | None -> Octet_time.Latency.frame_out tagger (Array.init 60 (fun j -> 24 + j))
     | Some e ->
       Octet_time.Latency.frame_out
         tagger
         ~expected_octets:e
         (Array.init 60 (fun j -> 24 + j)));
    verdict tagger ~expect_clean:true;
    Octet_time.Latency.report tagger
  in
  let identity = run "identity" None in
  let declared = run "declared" (Some 60) in
  if identity = declared
  then print_endline "IDENTITY-EQUALITY ok"
  else failwith "X-5: a declared extent equal to the identity changed the verdict";
  [%expect {|
    [clean] frames=1 octets=60 latency=CONSTANT per front offset (1 class)
      h=8 L=16 word_delay=3 <= ceiling 4 frames=1 octets=60
    VERDICT ok
    [clean] frames=1 octets=60 latency=CONSTANT per front offset (1 class)
      h=8 L=16 word_delay=3 <= ceiling 4 frames=1 octets=60
    VERDICT ok
    IDENTITY-EQUALITY ok
    |}]
;;

let%expect_test "X-9: M14's padding varies per datagram, and an impossible extent is an error" =
  (* N = 46 Ethernet payload octets, IPv4 total length N′ = 36: twenty header
     octets stripped, sixteen payload octets delivered, ten octets of padding
     consumed and dropped (SPEC-M14 §6.1). [tail_octets] is a run constant and
     cannot express "ten here, nine at the next datagram". *)
  let tagger =
    Octet_time.Latency.create
      ~name:"m14-padding"
      ~strip_octets:20
      ~tail_octets:0
      ~front_offsets:[ 20 ]
      ()
  in
  Octet_time.Latency.frame_in tagger (Array.init 46 (fun k -> k));
  Octet_time.Latency.frame_out tagger ~expected_octets:16 (Array.init 16 (fun j -> 32 + j));
  (* and the same datagram claiming more octets than its input trace holds *)
  Octet_time.Latency.frame_in tagger (Array.init 46 (fun k -> 64 + k));
  Octet_time.Latency.frame_out tagger ~expected_octets:40 (Array.init 16 (fun j -> 96 + j));
  expect_int ~what:"octets compared" ~expected:16 (Octet_time.Latency.octets_compared tagger);
  expect_int
    ~what:"errors"
    ~expected:2
    (List.length (Octet_time.Latency.errors tagger));
  print_string (Octet_time.Latency.report tagger);
  print_newline ();
  if !failures = 0
  then print_endline "VERDICT ok"
  else (
    failures := 0;
    failwith "X-9: the impossible extent was not reported");
  [%expect {|
    octets compared = 16
    errors = 2
    [m14-padding] frames=2 octets=16 latency=CONSTANT per front offset (1 class)
      h=20 L=12 word_delay=4 frames=1 octets=16
      ERROR: frame 1: a per-frame output extent of 40 octet(s) is outside 0 .. 26, the octets this frame's input trace can supply after the 20 stripped from the front (WO-0033 X-5/X-9)
      ERROR: frame 1: 46 input octets less 20 stripped from the front and 0 from the back is 26, but 16 octets were emitted
    VERDICT ok
    |}]
;;
