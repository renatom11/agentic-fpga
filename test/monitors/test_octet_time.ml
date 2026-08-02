(* Unit tests for octet time and the per-octet latency tagger
   (requirements.md §0.5).

   ADR-0005 rule 2: every [%expect] block is left EMPTY on purpose and is
   promoted from CI's own diff output. Each case states its expected verdict in
   OCaml, prints VERDICT ok or VERDICT WRONG, and raises on a wrong verdict. *)

let verdict tagger ~expect_constant =
  print_string (Octet_time.Latency.report tagger);
  print_newline ();
  let got = Octet_time.Latency.constant tagger in
  let ok =
    match got, expect_constant with
    | Some a, Some b -> a = b
    | None, None -> true
    | Some _, None | None, Some _ -> false
  in
  if ok && Octet_time.Latency.is_clean tagger = (match expect_constant with Some _ -> true | None -> false)
  then print_endline "VERDICT ok"
  else (
    print_endline "VERDICT WRONG — the tagger did not measure what this case builds";
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
     Both halves are asserted here so the finding cannot regress quietly. *)
  List.iter
    (fun start_lane ->
      let input, output = walk ~start_lane ~d:2 ~octets:64 in
      let tagger =
        Octet_time.Latency.create ~name:(Printf.sprintf "lane%d" start_lane) ~strip_octets:0 ()
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
  let tagger0 = Octet_time.Latency.create ~name:"lane0" ~strip_octets:0 () in
  Octet_time.Latency.frame_in tagger0 input0;
  Octet_time.Latency.frame_out tagger0 output0;
  let tagger4 = Octet_time.Latency.create ~name:"lane4" ~strip_octets:0 () in
  Octet_time.Latency.frame_in tagger4 input4;
  Octet_time.Latency.frame_out tagger4 output4;
  (match Octet_time.Latency.constant tagger0, Octet_time.Latency.constant tagger4 with
   | Some a, Some b ->
     Printf.printf "lane-0 L = %d, lane-4 L = %d, difference %d octet times\n" a b (b - a);
     if abs (b - a) > 8 then failwith "the two start-lane constants differ by over one cycle"
   | Some _, None | None, Some _ | None, None ->
     failwith "one of the start lanes did not yield a constant");
  verdict tagger4 ~expect_constant:(Some 20);
  [%expect {|
    start lane 0: octet-time latencies 16; cycle-metric values 2
    start lane 4: octet-time latencies 20; cycle-metric values 2;3
    lane-0 L = 16, lane-4 L = 20, difference 4 octet times
    [lane4] frames=1 octets=64 latency=CONSTANT 20 octet times (cycles_floor=2, word_cycles[h=0]=2)
    VERDICT ok
    |}]
;;

let%expect_test "a stripping stage: constant latency, and C-1's two cycle conversions" =
  (* A stage stripping a 14-octet Ethernet header (REQ-021). Its input frame is
     word-aligned at cycle 3, its first output word leaves at cycle 6. §0.5's
     formula gives L = 8(Co - Ci) - h = 8*3 - 14 = 10 octet times, and the two
     conversions to cycles disagree: §0.5's floor(L/8) is 1, while the
     word-cycle delay Co - Ci that §1.1's ceilings were allocated in is 3. That
     gap is carry-forward C-1, and it is why the tagger reports both figures
     rather than picking one. *)
  let strip = 14 in
  let ci = 3 in
  let co = 6 in
  let octets = 60 in
  let input = Array.init octets (fun k -> (8 * ci) + k) in
  let output =
    Array.init (octets - strip) (fun j -> (8 * (co + (j / 8))) + (j mod 8))
  in
  let tagger = Octet_time.Latency.create ~name:"eth-strip" ~strip_octets:strip () in
  Octet_time.Latency.frame_in tagger input;
  Octet_time.Latency.frame_out tagger output;
  (match Octet_time.Latency.constant tagger with
   | None -> failwith "a stripping stage must still have constant per-octet latency"
   | Some l ->
     Printf.printf
       "L = %d octet times; cycles_floor = %d; word_cycles = %d; 8(Co-Ci)-h = %d\n"
       l
       (Octet_time.cycles_floor l)
       (Octet_time.word_cycles ~strip_octets:strip l)
       ((8 * (co - ci)) - strip));
  verdict tagger ~expect_constant:(Some 10);
  [%expect {|
    L = 10 octet times; cycles_floor = 1; word_cycles = 3; 8(Co-Ci)-h = 10
    [eth-strip] frames=1 octets=46 latency=CONSTANT 10 octet times (cycles_floor=1, word_cycles[h=14]=3)
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
  let tagger = Octet_time.Latency.create ~name:"store-and-forward" ~strip_octets:0 () in
  Octet_time.Latency.frame_in tagger input;
  Octet_time.Latency.frame_out tagger output;
  (match Octet_time.Latency.first_offender tagger with
   | None -> failwith "a non-constant latency must name its first offender"
   | Some o -> Printf.printf "first offender: %s\n" o);
  verdict tagger ~expect_constant:None;
  [%expect {|
    first offender: frame 0 octet 8 has latency 40 octet times; every earlier octet had 32 (REQ-005, requirements.md §0.5)
    [store-and-forward] frames=1 octets=32 latency=NOT CONSTANT distinct=[32; 40]
      first offender: frame 0 octet 8 has latency 40 octet times; every earlier octet had 32 (REQ-005, requirements.md §0.5)
    VERDICT ok
    |}]
;;

let%expect_test "frames are matched in order, and a discarded frame is popped explicitly" =
  let tagger = Octet_time.Latency.create ~name:"ordered" ~strip_octets:0 () in
  let frame ~base ~octets = Array.init octets (fun k -> base + k) in
  Octet_time.Latency.frame_in tagger (frame ~base:0 ~octets:16);
  Octet_time.Latency.frame_in tagger (frame ~base:40 ~octets:16);
  Octet_time.Latency.frame_in tagger (frame ~base:80 ~octets:16);
  Octet_time.Latency.frame_out tagger (frame ~base:24 ~octets:16);
  (* the second frame was discarded under §0.6 — the conservation monitor
     records the strobe, the tagger just stops expecting an output for it *)
  Octet_time.Latency.frame_dropped tagger;
  Octet_time.Latency.frame_out tagger (frame ~base:104 ~octets:16);
  verdict tagger ~expect_constant:(Some 24);
  [%expect {|
    [ordered] frames=2 octets=32 latency=CONSTANT 24 octet times (cycles_floor=3, word_cycles[h=0]=3)
    VERDICT ok
    |}]
;;

let%expect_test "an output frame with no matching input is an error, not a latency" =
  let tagger = Octet_time.Latency.create ~name:"surplus" ~strip_octets:0 () in
  Octet_time.Latency.frame_out tagger (Array.init 8 (fun k -> 100 + k));
  print_string (Octet_time.Latency.report tagger);
  print_newline ();
  (match Octet_time.Latency.errors tagger with
   | [] -> failwith "a surplus output frame must be reported"
   | _ :: _ -> print_endline "VERDICT ok");
  [%expect {|
    [surplus] frames=0 octets=0 latency=(no octet compared)
      ERROR: output frame 0 has no matching input frame (frames out exceed frames in)
    VERDICT ok
    |}]
;;
