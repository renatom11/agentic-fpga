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
  [%expect {| |}]
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
  [%expect {| |}]
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
  [%expect {| |}]
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
  [%expect {| |}]
;;

let%expect_test "a producer that does not realign is caught by REQ-021 and by §0.5's closure" =
  (* A 14-octet stripping stage (REQ-021: Ethernet strips 14) whose first
     output octet lands at byte position 4 instead of 0. Two things follow and
     both are reported: the output stream is not word-aligned at its producer,
     and (L + h) is no longer a multiple of 8, so the word delay does not
     exist. Before WO-0012 [word_cycles] truncated that quotient and printed a
     plausible number for a design that cannot exist (requirements.md §0.5). *)
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
  expect_int ~what:"word_cycles refuses (L + h) = 28" ~expected:(-1)
    (Option.value ~default:(-1) (Octet_time.word_cycles ~front_offset:14 14));
  expect_int ~what:"errors reported" ~expected:2 (List.length (Octet_time.Latency.errors tagger));
  verdict tagger ~expect_clean:false;
  [%expect {| |}]
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
  [%expect {| |}]
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
  [%expect {| |}]
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
  [%expect {| |}]
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
  [%expect {| |}]
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
  [%expect {| |}]
;;
