(* Unit tests for the transmit-side decoder on hand-built word sequences
   (SPEC-M04 §6.1's cycle table, §9's underflow word; REQ-201 … REQ-206,
   REQ-209, requirements.md §0.3).

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
    failwith "transmit decoder verdict mismatch")
;;

let set_lane word ~lane ~to_ =
  Xgmii_word.of_lanes
    (List.init 8 (fun k -> if k = lane then to_ else Xgmii_word.lane word k))
;;

let patch words ~cycle ~lane ~to_ =
  List.map (fun (c, w) -> if c = cycle then c, set_lane w ~lane ~to_ else c, w) words
;;

let decode ?ifg ~name words =
  let d = Tx_decoder.create ~name ?ifg () in
  Tx_decoder.observe_all d words;
  d
;;

(* SPEC-M04 §6.1's wire pattern, produced by the receive-side emitter.

   This is a machinery cross-check and worth naming as one. [Arrival] was
   derived from requirements.md §0.3 and SPEC-M03 §8; [Tx_decoder] was derived
   from SPEC-M04 §6.1 and §9; they were written to different sections and they
   have to agree on the same octets. Parameterised with the gap M04's REQ-204
   rounding produces for a minimum-length frame with the terminate character in
   lane 0 — 16 octets counted from the terminate inclusive — the emitter puts
   every start character in lane 0 and 88 octet times apart, which is REQ-204's
   own verification figure and REQ-209's 11 cycles.

   What this does NOT claim: that the emitter is a model of M04. M04 also pads
   (REQ-203) and generates the FCS (REQ-202); here the frame builder has already
   done both, which is exactly why the decoder's REQ-202 check is meaningful —
   it re-derives the FCS from the REQ-305 oracle and compares wire octets. *)
let m04_like_schedule frames = Arrival.create ~ifg:16 frames

let%expect_test "SPEC-M04 §6.1: two minimum-length frames decode clean at 11 cycles" =
  let injected = [ Frame.stress_frame ~sequence:0 (); Frame.stress_frame ~sequence:1 () ] in
  let schedule = m04_like_schedule injected in
  let d = decode ~name:"xgmii_tx_64 §6.1" (Arrival.words schedule) in
  print_string (Tx_decoder.report d);
  print_newline ();
  expect_int ~what:"frames decoded" ~expected:2 (List.length (Tx_decoder.frames d));
  expect_int ~what:"violations" ~expected:0 (List.length (Tx_decoder.violations d));
  (* REQ-209: one minimum-length frame per 11 cycles, and no spacing differing
     from 11 — the assertion is the bench's because it depends on the lengths
     the bench chose. *)
  expect_ints ~what:"start-to-start cycles (REQ-209)" ~expected:[ 11 ] (Tx_decoder.start_spacings d);
  (* REQ-204's verification figure: a 16-octet gap counted from the terminate
     character inclusive, and 88 octets between start characters. *)
  expect_ints ~what:"gaps, terminate inclusive (REQ-204)" ~expected:[ 16 ] (Tx_decoder.gaps d);
  expect_int
    ~what:"octet times between start characters (REQ-204)"
    ~expected:88
    (8 * List.nth (Tx_decoder.start_spacings d) 0);
  (* REQ-205: the terminate character lands in the lane after the last FCS
     octet — lane 0 of the next word for a 64-octet frame at a lane-0 start. *)
  let decoded = Tx_decoder.frames d in
  List.iter
    (fun (f : Tx_decoder.frame) ->
      expect_int ~what:"terminate lane (REQ-205)" ~expected:0 f.terminate_lane;
      if f.underflowed then failwith "a clean frame was decoded as underflowed")
    decoded;
  (* REQ-012 and REQ-207 in the form the wire can carry them: the octets come
     back in order, once, unchanged. *)
  List.iter2
    (fun sent (got : Tx_decoder.frame) ->
      if sent <> got.octets then failwith "a decoded frame's octets differ from the injected ones")
    injected
    decoded;
  expect_int
    ~what:"octets in the first decoded frame (DA through FCS, §0.3)"
    ~expected:64
    (List.length (List.nth decoded 0).Tx_decoder.octets);
  if not (Tx_decoder.is_clean d) then failwith "a conformant transmit wire was not clean";
  verdict ();
  [%expect {|
    [xgmii_tx_64 §6.1] frames=2 octets=128 underflowed=0 violations=0
      start cycles: 1 12
      start-to-start cycles: 11
      gaps (octets, terminate inclusive): 16
    frames decoded = 2
    violations = 0
    start-to-start cycles (REQ-209) = [11]
    gaps, terminate inclusive (REQ-204) = [16]
    octet times between start characters (REQ-204) = 88
    terminate lane (REQ-205) = 0
    terminate lane (REQ-205) = 0
    octets in the first decoded frame (DA through FCS, §0.3) = 64
    VERDICT ok
    |}]
;;

let%expect_test "REQ-201: a lane-4 start character is a transmit-side violation" =
  (* The receive-side stress schedule is deliberately not a legal transmit
     wire: REQ-004 requires alternating start lanes on receive, REQ-201 forbids
     anything but lane 0 on transmit. Feeding one to the other is the cheapest
     available proof that the decoder's REQ-201 check is not vacuous — and it
     documents the asymmetry that makes the link partner two models rather than
     one loopback. *)
  let d = decode ~name:"receive schedule on a transmit port" (Arrival.words (Arrival.stress ~count:4 ())) in
  print_string (Tx_decoder.report d);
  print_newline ();
  let req201 =
    List.filter (fun (v : Tx_decoder.violation) -> v.req = "REQ-201") (Tx_decoder.violations d)
  in
  expect_int ~what:"REQ-201 violations (one per lane-4 start)" ~expected:2 (List.length req201);
  expect_int ~what:"frames still decoded" ~expected:4 (List.length (Tx_decoder.frames d));
  verdict ();
  [%expect {|
    [receive schedule on a transmit port] frames=4 octets=256 underflowed=0 violations=2
      start cycles: 1 11 22 32
      start-to-start cycles: 10 11 10
      gaps (octets, terminate inclusive): 12 12 12
      VIOLATION cycle 11 REQ-201: start character in lane 4; Phase 1 places every start character in lane 0 (SPEC-M04 §6.1, requirements.md §0.3)
      VIOLATION cycle 32 REQ-201: start character in lane 4; Phase 1 places every start character in lane 0 (SPEC-M04 §6.1, requirements.md §0.3)
    REQ-201 violations (one per lane-4 start) = 2
    frames still decoded = 4
    VERDICT ok
    |}]
;;

let%expect_test "REQ-202: one flipped FCS octet is caught against the REQ-305 oracle" =
  (* The FCS of a 64-octet frame at a lane-0 start occupies octet times 76-79,
     i.e. lanes 4-7 of cycle 9 (SPEC-M04 §6.1's table puts them in the same word
     as octets 56-59). Flipping one must be caught by comparison against the
     bit-serial reference — REQ-202's verification column requires exactly this
     oracle and warns that a loopback through the design's own engine would pass
     a systematically wrong but self-consistent CRC. *)
  let schedule = m04_like_schedule [ Frame.stress_frame ~sequence:0 () ] in
  let words = Arrival.words schedule in
  let original =
    match Xgmii_word.lane (Arrival.word_at schedule ~cycle:9) 7 with
    | Xgmii_word.Data d -> d
    | Xgmii_word.Control _ -> failwith "the last FCS octet is not a data lane"
  in
  let corrupted = patch words ~cycle:9 ~lane:7 ~to_:(Xgmii_word.Data (original lxor 0xFF)) in
  let d = decode ~name:"flipped FCS octet" corrupted in
  print_string (Tx_decoder.report d);
  print_newline ();
  expect_int ~what:"violations" ~expected:1 (List.length (Tx_decoder.violations d));
  expect_int
    ~what:"the violation is REQ-202's"
    ~expected:1
    (List.length
       (List.filter
          (fun (v : Tx_decoder.violation) -> v.req = "REQ-202")
          (Tx_decoder.violations d)));
  if Tx_decoder.is_clean d then failwith "a wrong FCS was accepted";
  verdict ();
  [%expect {|
    [flipped FCS octet] frames=1 octets=64 underflowed=0 violations=1
      start cycles: 1
      start-to-start cycles:
      gaps (octets, terminate inclusive):
      VIOLATION cycle 10 REQ-202: FCS on the wire is [38 C4 DD 30]; the REQ-305 bit-serial reference over the 60 preceding octets gives [38 C4 DD CF], least significant octet first
    violations = 1
    the violation is REQ-202's = 1
    VERDICT ok
    |}]
;;

let%expect_test "REQ-205 and REQ-204: a non-idle gap lane and a short gap are caught" =
  let schedule = m04_like_schedule [ Frame.stress_frame ~sequence:0 () ] in
  (* REQ-205: every remaining lane of the terminate word and every lane of every
     gap word carries idle. The terminate is at lane 0 of cycle 10, so lane 3 of
     that word is a gap lane. *)
  let words = patch (Arrival.words schedule) ~cycle:10 ~lane:3 ~to_:(Xgmii_word.Data 0xAA) in
  let d = decode ~name:"data in a gap lane" words in
  print_string (Tx_decoder.report d);
  print_newline ();
  expect_int
    ~what:"REQ-205 violations"
    ~expected:1
    (List.length
       (List.filter
          (fun (v : Tx_decoder.violation) -> v.req = "REQ-205")
          (Tx_decoder.violations d)));
  (* REQ-204: a gap below cfg_ifg counted from the terminate inclusive. An
     8-octet gap still lands the next start on lane 0, so this is a gap-length
     failure and not a lane failure — the two are separate rows of REQ-204 and
     the decoder must not conflate them. *)
  let short = Arrival.create ~ifg:8 [ Frame.stress_frame ~sequence:0 (); Frame.stress_frame ~sequence:1 () ] in
  let d2 = decode ~name:"gap below cfg_ifg" (Arrival.words short) in
  print_string (Tx_decoder.report d2);
  print_newline ();
  expect_ints ~what:"the emitted gap" ~expected:[ 8 ] (Arrival.gaps short);
  expect_ints ~what:"start lanes are still legal" ~expected:[ 0; 0 ] (Arrival.start_lanes short);
  expect_int
    ~what:"REQ-204 violations"
    ~expected:1
    (List.length
       (List.filter
          (fun (v : Tx_decoder.violation) -> v.req = "REQ-204")
          (Tx_decoder.violations d2)));
  expect_int ~what:"other violations" ~expected:0 (List.length (Tx_decoder.violations d2) - 1);
  verdict ();
  [%expect {|
    [data in a gap lane] frames=1 octets=64 underflowed=0 violations=1
      start cycles: 1
      start-to-start cycles:
      gaps (octets, terminate inclusive):
      VIOLATION cycle 10 REQ-205: lane 3 carries data 0xAA between frames; every remaining lane of the terminate word and every lane of every gap word carries an idle character
    REQ-205 violations = 1
    [gap below cfg_ifg] frames=2 octets=128 underflowed=0 violations=1
      start cycles: 1 11
      start-to-start cycles: 10
      gaps (octets, terminate inclusive): 8
      VIOLATION cycle 11 REQ-204: gap of 8 octets counted from the terminate character inclusive, below the 12 cfg_ifg requires; gaps are only ever rounded up (requirements.md §0.3, §11)
    the emitted gap = [8]
    start lanes are still legal = [0 0]
    REQ-204 violations = 1
    other violations = 0
    VERDICT ok
    |}]
;;

let%expect_test "SPEC-M04 §9: the underflow word is /E/ in lane 0 then /T/ in lane 1" =
  (* §9: "the words already accepted are transmitted (REQ-207 forbids dropping
     them), then one XGMII word carrying /E/ in lane 0 and /T/ in lane 1, /I/ in
     lanes 2-7; no FCS is appended". No FCS therefore means REQ-202 and REQ-203
     are NOT asserted on this frame — asserting them would be the bench
     demanding the well-formed short frame that clause exists to prevent (§9,
     "stated because the alternative is worse"), and it is what M03 detects as
     REQ-105 at the other end of a loopback. *)
  let frame = Frame.stress_frame ~sequence:7 () in
  let octet i = List.nth frame i in
  let preamble =
    Xgmii_word.of_lanes
      (Xgmii_word.Control Xgmii_word.start_char
       :: List.init 7 (fun k -> Xgmii_word.Data (if k = 6 then 0xD5 else 0x55)))
  in
  let words =
    [ 0, Xgmii_word.idle
    ; 1, preamble
    ; 2, Xgmii_word.of_data (List.init 8 (fun k -> octet k))
    ; 3, Xgmii_word.of_data (List.init 8 (fun k -> octet (8 + k)))
    ; ( 4
      , Xgmii_word.of_lanes
          (Xgmii_word.Control Xgmii_word.error_char
           :: Xgmii_word.Control Xgmii_word.terminate_char
           :: List.init 6 (fun _ -> Xgmii_word.Control Xgmii_word.idle_char)) )
    ; 5, Xgmii_word.idle
    ; 6, Xgmii_word.idle
    ]
  in
  let d = decode ~name:"underflow" words in
  print_string (Tx_decoder.report d);
  print_newline ();
  expect_int ~what:"frames decoded" ~expected:1 (List.length (Tx_decoder.frames d));
  let f = List.nth (Tx_decoder.frames d) 0 in
  expect_int ~what:"octets transmitted before the error character" ~expected:16 (List.length f.Tx_decoder.octets);
  expect_int ~what:"terminate lane (§9)" ~expected:1 f.Tx_decoder.terminate_lane;
  if not f.Tx_decoder.underflowed then failwith "the underflow was not recorded";
  expect_int ~what:"violations (a truncated frame is not itself a violation)" ~expected:0
    (List.length (Tx_decoder.violations d));
  (* An error character anywhere but lane 0 is not §9's word: §9 pins the
     underflow remedy to one word carrying /E/ in lane 0 and /T/ in lane 1, so
     a truncation that begins mid-word is a transmitter defect and not the
     specified behaviour. Two more octets are transmitted here before the /E/,
     which is what makes the error character land in lane 2. *)
  let misplaced =
    let w = patch words ~cycle:4 ~lane:0 ~to_:(Xgmii_word.Data (octet 16)) in
    let w = patch w ~cycle:4 ~lane:1 ~to_:(Xgmii_word.Data (octet 17)) in
    let w = patch w ~cycle:4 ~lane:2 ~to_:(Xgmii_word.Control Xgmii_word.error_char) in
    patch w ~cycle:4 ~lane:3 ~to_:(Xgmii_word.Control Xgmii_word.terminate_char)
  in
  let d2 = decode ~name:"error character in lane 2" misplaced in
  expect_int
    ~what:"REQ-206 violations for a misplaced error character"
    ~expected:1
    (List.length
       (List.filter
          (fun (v : Tx_decoder.violation) -> v.req = "REQ-206")
          (Tx_decoder.violations d2)));
  verdict ();
  [%expect {|
    [underflow] frames=1 octets=16 underflowed=1 violations=0
      start cycles: 1
      start-to-start cycles:
      gaps (octets, terminate inclusive):
    frames decoded = 1
    octets transmitted before the error character = 16
    terminate lane (§9) = 1
    violations (a truncated frame is not itself a violation) = 0
    REQ-206 violations for a misplaced error character = 1
    VERDICT ok
    |}]
;;
