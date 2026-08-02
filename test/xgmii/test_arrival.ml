(* Unit tests for the arrival scheduler and XGMII emitter, on hand-built
   schedules (requirements.md §0.3, REQ-004, REQ-101, REQ-102; SPEC-M03 §8).

   ADR-0005 rule 2: every [%expect] block is left EMPTY and is promoted from
   CI's own diff output; every number is additionally asserted in OCaml. *)

let failures = ref 0

let expect_int ~what ~expected got =
  if got = expected
  then Printf.printf "%s = %d\n" what got
  else (
    Printf.printf "%s = %d, EXPECTED %d\n" what got expected;
    incr failures)
;;

let ints values = String.concat " " (List.map string_of_int values)

let expect_ints ~what ~expected got =
  if got = expected
  then Printf.printf "%s = [%s]\n" what (ints got)
  else (
    Printf.printf "%s = [%s], EXPECTED [%s]\n" what (ints got) (ints expected);
    incr failures)
;;

let verdict () =
  if !failures = 0
  then print_endline "VERDICT ok"
  else (
    print_endline "VERDICT WRONG";
    failures := 0;
    failwith "arrival scheduler verdict mismatch")
;;

let%expect_test "SPEC-M03 §8: the alternation and the 10/11 cadence are consequences, not policy" =
  (* Nothing in the scheduler is told to alternate start lanes. §0.3's gap
     convention — 12 octets counted from the terminate character INCLUSIVE —
     puts 8 + 64 + 12 = 84 octet times between start characters, and 84 is
     neither a multiple of 8 (so the lane alternates 0, 4, 0, 4) nor an integer
     number of cycles (so the spacing alternates 10 and 11). Both are REQ-004's
     figures and both are asserted here against the requirement rather than
     against the code that produced them. Six frames stand in for REQ-004's
     10 000: the arithmetic does not change with the count. *)
  let s = Arrival.stress ~count:6 () in
  print_string (Arrival.report s);
  print_newline ();
  expect_ints ~what:"start lanes (REQ-004, REQ-101)" ~expected:[ 0; 4; 0; 4; 0; 4 ] (Arrival.start_lanes s);
  expect_ints
    ~what:"start-to-start cycles (REQ-004: alternating 10 and 11)"
    ~expected:[ 10; 11; 10; 11; 10 ]
    (Arrival.start_spacings s);
  expect_ints
    ~what:"gaps in octets, terminate inclusive (§0.3's minimum 12)"
    ~expected:[ 12; 12; 12; 12; 12 ]
    (Arrival.gaps s);
  let frames = Arrival.frames s in
  expect_int
    ~what:"octet times between start characters (§0.3's 84-octet budget)"
    ~expected:84
    (frames.(1).Arrival.start_octet_time - frames.(0).Arrival.start_octet_time);
  (* 84 octet times is 10.5 cycles = 67.2 ns, the 14.88 Mpps minimum-frame rate
     §0.3 fixes; over an even number of frames the mean spacing is exactly
     10.5 cycles, which is what "one frame per 10.5 cycles average" means. *)
  expect_int
    ~what:"cycles for five inter-arrival intervals (5 x 10.5 = 52.5, i.e. 52 or 53)"
    ~expected:52
    (List.fold_left ( + ) 0 (Arrival.start_spacings s));
  if not (Arrival.is_clean s)
  then failwith "the model's own §0.3 contract check failed on its §8 schedule";
  verdict ();
  [%expect {| |}]
;;

let%expect_test "the emitted words are the schedule the model describes" =
  let s = Arrival.stress ~count:3 () in
  let frame0 = (Arrival.frames s).(0) in
  let at cycle = Arrival.word_at s ~cycle in
  (* Before the first start character: idle in every lane (REQ-109's
     precondition, and REQ-113's "control characters outside a frame"). *)
  if not (Xgmii_word.is_idle (at 0)) then failwith "the wire is not idle before the first frame";
  expect_int ~what:"first start cycle" ~expected:1 (Arrival.start_cycle frame0);
  expect_int
    ~what:"first start lane"
    ~expected:0
    (match Xgmii_word.start_lane (at 1) with
     | Some l -> l
     | None -> -1);
  Printf.printf "cycle 0: %s\n" (Xgmii_word.to_string (at 0));
  Printf.printf "cycle 1: %s\n" (Xgmii_word.to_string (at 1));
  Printf.printf "cycle 2: %s\n" (Xgmii_word.to_string (at 2));
  Printf.printf "cycle 10: %s\n" (Xgmii_word.to_string (at 10));
  Printf.printf "cycle 11: %s\n" (Xgmii_word.to_string (at 11));
  (* REQ-102 / SPEC-M03 §6.1: eight octets from the start character inclusive
     are preamble — six 0x55 then the 0xD5 SFD — and the receiver may not
     validate those values, which is why this test is the model's obligation
     and not a bench's assertion. *)
  let preamble = at 1 in
  List.iter
    (fun k ->
      match Xgmii_word.lane preamble k with
      | Xgmii_word.Data d when d = (if k = 7 then 0xD5 else 0x55) -> ()
      | _ -> failwith (Printf.sprintf "preamble lane %d is not what SPEC-M03 §6.1 writes" k))
    [ 1; 2; 3; 4; 5; 6; 7 ];
  (* The frame's first octet is the destination address, one octet time after
     the eight preamble octets, i.e. lane 0 of the next cycle at a lane-0
     start. *)
  expect_int
    ~what:"frame octet 0 (destination MAC 02:..) at cycle 2 lane 0"
    ~expected:0x02
    (match Xgmii_word.lane (at 2) 0 with
     | Xgmii_word.Data d -> d
     | Xgmii_word.Control _ -> -1);
  (* REQ-106: the terminate character sits immediately after the last FCS
     octet — octet time 8 + 8 + 64 = 80, which is lane 0 of cycle 10. *)
  expect_int ~what:"terminate octet time" ~expected:80 (Arrival.terminate_octet_time frame0);
  (match Xgmii_word.lane (at 10) 0 with
   | Xgmii_word.Control c when c = Xgmii_word.terminate_char -> ()
   | _ -> failwith "the terminate character is not where §0.3's arithmetic puts it");
  (* and the rest of that word, plus the gap, is idle until the lane-4 start of
     the next frame at octet time 92 = cycle 11 lane 4 *)
  List.iter
    (fun k ->
      match Xgmii_word.lane (at 10) k with
      | Xgmii_word.Control c when c = Xgmii_word.idle_char -> ()
      | _ -> failwith "a lane after the terminate character is not idle")
    [ 1; 2; 3; 4; 5; 6; 7 ];
  expect_int
    ~what:"second start lane (the alternation)"
    ~expected:4
    (match Xgmii_word.start_lane (at 11) with
     | Some l -> l
     | None -> -1);
  (* The wire seam, pinned once: REQ-012 puts lane k at bits [8k+7:8k]. *)
  let data, control = Xgmii_word.to_wire (at 1) in
  Printf.printf "cycle 1 on the wire: xgmii_rxd=0x%016LX xgmii_rxc=0x%02X\n" data control;
  expect_int ~what:"control bits of the preamble word (start character in lane 0 only)" ~expected:0x01 control;
  if not (Xgmii_word.equal (Xgmii_word.of_wire data control) (at 1))
  then failwith "the wire packing does not round-trip";
  verdict ();
  [%expect {| |}]
;;

let%expect_test "the model's octet-time trace shows SPEC-M03 §7's front offsets, 8 and 12" =
  (* This is where the two WO-0012 deliverables meet. The scheduler produces the
     input trace; the WO-0012 latency tagger observes the front offset from that
     trace; and what it observes must be SPEC-M03 §7's pinned h — 8 at a lane-0
     start, 12 at a lane-4 start — with a single word delay of 3 at both, one
     cycle inside §1.1's ceiling of 4.

     The output side is a model of a CONFORMANT M03 (SPEC-M03 §6.1: "output word
     m is emitted on the cycle m + 3 counted from the word carrying the start
     character", word-aligned by REQ-021). No design is involved: this test
     asserts that the machinery agrees with the specification's own numbers, so
     that when a design does arrive, a disagreement is the design's. *)
  let s = Arrival.stress ~count:4 () in
  let tagger =
    Dv_monitors.Octet_time.Latency.create
      ~name:"conformant M03"
      ~strip_octets:8 (* REQ-102 *)
      ~tail_octets:4 (* REQ-103 *)
      ~front_offsets:[ 8; 12 ] (* SPEC-M03 §7 *)
      ~ceiling:4 (* requirements.md §1.1 *)
      ()
  in
  Array.iter
    (fun f ->
      let delivered = Arrival.delivered f in
      let co = Arrival.start_cycle f + 3 in
      let out_times =
        Array.init (Array.length delivered) (fun j ->
          Dv_monitors.Octet_time.of_axi64 ~cycle:(co + (j / 8)) ~byte_position:(j mod 8))
      in
      Dv_monitors.Octet_time.Latency.frame_in tagger (Arrival.in_times f);
      Dv_monitors.Octet_time.Latency.frame_out tagger out_times)
    (Arrival.frames s);
  print_string (Dv_monitors.Octet_time.Latency.report tagger);
  print_newline ();
  List.iter
    (fun (o : Dv_monitors.Octet_time.Latency.observed) ->
      expect_int
        ~what:(Printf.sprintf "word delay at front offset %d" o.front_offset)
        ~expected:3
        (match o.word_delay with
         | Some d -> d
         | None -> -1);
      expect_ints
        ~what:(Printf.sprintf "L at front offset %d" o.front_offset)
        ~expected:(if o.front_offset = 8 then [ 16 ] else [ 12 ])
        o.latencies)
    (Dv_monitors.Octet_time.Latency.observed tagger);
  expect_int
    ~what:"front-offset classes over an alternating-lane run"
    ~expected:2
    (List.length (Dv_monitors.Octet_time.Latency.observed tagger));
  if not (Dv_monitors.Octet_time.Latency.is_clean tagger)
  then failwith "the model's own trace does not satisfy SPEC-M03 §7";
  verdict ();
  [%expect {| |}]
;;

let%expect_test "§0.3's deficit idle count: rounding credit is banked and spent, never below 9" =
  (* §0.3 gives the receive-side partner two constraints and this model
     implements exactly those two: a start character may occupy only lane 0 or
     lane 4, so a gap is rounded UP to a multiple of four octets; and the
     partner is DIC-capable, so it may shorten a later gap — never below 9
     octets — to keep the average at 12.

     SPEC-M03 §8's schedule never exercises it (84 is already a multiple of 4,
     so the credit never moves), which is precisely why it needs its own case:
     an odd frame length forces a rounding on every frame. 65 octets DA through
     FCS puts the terminate character at octet time 81, so a 12-octet gap would
     land the next start at 93 — not a legal start position — and the schedule
     rounds to 96, banking 3 octets to spend on the following gap. *)
  let odd = Frame.with_fcs (List.init 61 (fun i -> i land 0xFF)) in
  expect_int ~what:"frame octets DA through FCS" ~expected:65 (List.length odd);
  let s = Arrival.create (List.init 6 (fun _ -> odd)) in
  print_string (Arrival.report s);
  print_newline ();
  (* Start octet times 8, 96, 180, 264, 348, 436 — every one a multiple of 4,
     so every start character is legal; the lane pattern is whatever the
     arithmetic gives and is not required to alternate here (REQ-004's
     alternation is a property of the minimum-length schedule, not of every
     schedule). *)
  expect_ints
    ~what:"start lanes (only 0 and 4 are legal)"
    ~expected:[ 0; 0; 4; 0; 4; 4 ]
    (Arrival.start_lanes s);
  expect_ints
    ~what:"gaps: one rounded up to 15, then three shortened to 11 against the credit"
    ~expected:[ 15; 11; 11; 11; 15 ]
    (Arrival.gaps s);
  List.iter
    (fun gap -> if gap < 9 then failwith "a gap fell below §0.3's 9-octet DIC floor")
    (Arrival.gaps s);
  expect_int
    ~what:"total gap over five intervals (5 x 12 = 60 minimum on average)"
    ~expected:63
    (List.fold_left ( + ) 0 (Arrival.gaps s));
  if not (Arrival.is_clean s) then failwith "the DIC schedule fails the model's own check";
  verdict ();
  [%expect {| |}]
;;

let%expect_test "the model checks its own frames: a bad FCS is reported, not emitted silently" =
  (* SPEC-M03 §8: "Every frame is one M03 accepts and forwards, so frames-out
     equals frames-in is well defined." A stress schedule that quietly contained
     an invalid frame would make that criterion false and would look like a
     design defect. [check] is what makes the claim falsifiable — and the
     [~fcs_valid:false] path is what an injection schedule will use, so the
     check is narrowed deliberately rather than weakened for everyone. *)
  let good = Frame.stress_frame ~sequence:0 () in
  let bad = List.mapi (fun i o -> if i = 20 then o lxor 0xFF else o) good in
  let s = Arrival.create [ good; bad ] in
  print_string (Arrival.report s);
  print_newline ();
  expect_int ~what:"contract violations reported" ~expected:1 (List.length (Arrival.check s));
  let injected = Arrival.create ~fcs_valid:false [ good; bad ] in
  expect_int
    ~what:"violations once the schedule declares its frames deliberately corrupt"
    ~expected:0
    (List.length (Arrival.check injected));
  verdict ();
  [%expect {| |}]
;;
