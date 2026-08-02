(* Unit tests for the SPEC-M01 §6.1 protocol monitor, on hand-built legal and
   illegal traces. No DUT, no simulator: the traces are OCaml values, so these
   tests fail when the monitor is wrong rather than when a design is.

   ADR-0005 rule 2: every [%expect] block is left EMPTY on purpose and is
   promoted from CI's own diff output. The pass/fail judgement therefore does
   not live in the snapshots — each case states in OCaml which violation kinds
   it expects and prints VERDICT ok or VERDICT WRONG, and a wrong verdict also
   raises, so promoting a red snapshot cannot make a broken monitor look
   green. *)

let all_octets = [ 0x11; 0x22; 0x33; 0x44; 0x55; 0x66; 0x77; 0x88 ]

let run ?max_words_per_frame ~name trace =
  let monitor = Protocol_monitor.create ~name ?max_words_per_frame () in
  List.iteri (fun cycle w -> Protocol_monitor.observe monitor ~cycle w) trace;
  monitor
;;

let kinds monitor =
  List.map
    (fun (v : Protocol_monitor.violation) -> v.Protocol_monitor.kind)
    (Protocol_monitor.violations monitor)
;;

let expect_kinds monitor expected =
  let got = kinds monitor in
  print_string (Protocol_monitor.report monitor);
  print_newline ();
  if got = expected
  then print_endline "VERDICT ok"
  else (
    print_endline "VERDICT WRONG — the monitor did not report what this case injects";
    failwith "protocol monitor verdict mismatch")
;;

let%expect_test "legal traces: the monitor reports nothing" =
  (* A three-word frame with a partial last word, an idle gap, a single-word
     frame (which SPEC-M01 §6.1 makes mandatory for a 1-to-8-octet payload and
     which REQ-015's second sentence would forbid — see protocol_monitor.ml's
     header note and carry-forward C-11), and an aborted frame carrying
     tuser[0] = 1 on its tlast word (REQ-007), which is counted and not
     flagged. *)
  let trace =
    [ Stream_word.of_octets all_octets
    ; Stream_word.of_octets all_octets
    ; Stream_word.idle ()
    ; Stream_word.of_octets ~tlast:true [ 0xaa; 0xbb; 0xcc; 0xdd ]
    ; Stream_word.idle ()
    ; Stream_word.of_octets ~tlast:true [ 0x5a ]
    ; Stream_word.of_octets all_octets
    ; Stream_word.of_octets ~tlast:true ~tuser:1 [ 0x01; 0x02 ]
    ]
  in
  expect_kinds (run ~name:"legal" trace) [];
  [%expect {| |}]
;;

let%expect_test "SPEC-M01 §6.3 item 5: nothing is asserted on a cycle with tvalid = 0" =
  (* [garbage_idle] carries non-contiguous tkeep, tstrb = 0xFF and tlast = 1 —
     every one of them a violation on a valid word. §6.3 item 5 leaves all of
     it unconstrained, so a conformant monitor reports nothing and counts no
     frame. This is the guard the work order names, made falsifiable. *)
  let trace =
    [ Stream_word.garbage_idle ()
    ; Stream_word.garbage_idle ()
    ; Stream_word.of_octets ~tlast:true all_octets
    ; Stream_word.garbage_idle ()
    ]
  in
  expect_kinds (run ~name:"idle-garbage" trace) [];
  [%expect {| |}]
;;

let%expect_test "SPEC-M01 §6.3 item 5: tdata under a cleared tkeep bit is never read" =
  (* A legal four-octet last word whose upper four octet positions hold stale
     nonsense. §6.3 item 5 says the value there is unconstrained; the monitor
     must neither flag it nor let it reach the printed octet list. *)
  let word =
    Stream_word.raw
      ~tvalid:true
      ~tdata:[ 0x01; 0x02; 0x03; 0x04; 0xde; 0xad; 0xbe; 0xef ]
      ~tkeep:0x0f
      ~tstrb:0x00
      ~tlast:true
      ~tuser:0
  in
  Printf.printf "octets read: %s\n"
    (String.concat " " (List.map (Printf.sprintf "%02x") (Stream_word.octets word)));
  Printf.printf "rendered: %s\n" (Stream_word.to_string word);
  Printf.printf "rendered idle: %s\n" (Stream_word.to_string (Stream_word.garbage_idle ()));
  expect_kinds (run ~name:"masked-tdata" [ word ]) [];
  [%expect {| |}]
;;

let%expect_test "REQ-011: tkeep = 0 with tvalid = 1" =
  let word =
    Stream_word.raw ~tvalid:true ~tdata:[] ~tkeep:0x00 ~tstrb:0 ~tlast:true ~tuser:0
  in
  expect_kinds (run ~name:"tkeep-zero" [ word ]) [ Protocol_monitor.Tkeep_zero ];
  [%expect {| |}]
;;

let%expect_test "REQ-011: tkeep not contiguous from bit 0" =
  let word =
    Stream_word.raw
      ~tvalid:true
      ~tdata:all_octets
      ~tkeep:0x0d
      ~tstrb:0
      ~tlast:true
      ~tuser:0
  in
  expect_kinds (run ~name:"tkeep-hole" [ word ]) [ Protocol_monitor.Tkeep_not_contiguous ];
  [%expect {| |}]
;;

let%expect_test "REQ-011: a partial tkeep on a word that does not carry tlast" =
  let trace =
    [ Stream_word.raw
        ~tvalid:true
        ~tdata:all_octets
        ~tkeep:0x3f
        ~tstrb:0
        ~tlast:false
        ~tuser:0
    ; Stream_word.of_octets ~tlast:true [ 0x01 ]
    ]
  in
  expect_kinds
    (run ~name:"partial-mid-frame" trace)
    [ Protocol_monitor.Tkeep_partial_on_non_last ];
  [%expect {| |}]
;;

let%expect_test "REQ-014: a producer driving tstrb non-zero" =
  let trace =
    [ Stream_word.of_octets ~tstrb:0xff all_octets
    ; Stream_word.of_octets ~tstrb:0x01 ~tlast:true [ 0x01; 0x02 ]
    ]
  in
  expect_kinds
    (run ~name:"tstrb" trace)
    [ Protocol_monitor.Tstrb_nonzero; Protocol_monitor.Tstrb_nonzero ];
  [%expect {| |}]
;;

let%expect_test "REQ-015 residue: a frame longer than the stream's pinned maximum" =
  (* Pinned maxima are the producing module's, not this monitor's (SPEC-M01
     §6.1), so the rule only exists when a bench supplies one. Three words with
     a maximum of two: the violation fires once, on the third word, not once
     per word beyond. *)
  let trace =
    [ Stream_word.of_octets all_octets
    ; Stream_word.of_octets all_octets
    ; Stream_word.of_octets all_octets
    ; Stream_word.of_octets ~tlast:true all_octets
    ]
  in
  expect_kinds
    (run ~name:"too-long" ~max_words_per_frame:2 trace)
    [ Protocol_monitor.Frame_exceeds_max_words ];
  [%expect {| |}]
;;

let%expect_test "REQ-015: with no pinned maximum the length rule is not invented" =
  let long_frame =
    let rec build n acc = if n = 0 then acc else build (n - 1) (Stream_word.of_octets all_octets :: acc) in
    build 300 [ Stream_word.of_octets ~tlast:true all_octets ]
  in
  expect_kinds (run ~name:"unpinned" long_frame) [];
  [%expect {| |}]
;;

let%expect_test "REQ-009: clear drops the frame in progress and asserts nothing across it" =
  (* requirements.md REQ-009: clear mid-frame truncates the in-flight output
     frame without a terminating word, and no tlast and no strobe is emitted
     for it. REQ-015 requires the monitor to reset its frame-in-progress state
     on clear and make no assertion across it (spec diff D-8). The frame that
     starts on the first cycle after clear returns to 0 must be received
     correctly, so the monitor must be able to count it. *)
  let monitor = Protocol_monitor.create ~name:"clear" ~max_words_per_frame:2 () in
  Protocol_monitor.observe monitor ~cycle:0 (Stream_word.of_octets all_octets);
  Protocol_monitor.observe monitor ~cycle:1 (Stream_word.of_octets all_octets);
  Protocol_monitor.on_clear monitor ~cycle:2;
  Protocol_monitor.observe monitor ~cycle:3 (Stream_word.of_octets all_octets);
  Protocol_monitor.observe monitor ~cycle:4 (Stream_word.of_octets ~tlast:true [ 0x77 ]);
  expect_kinds monitor [];
  [%expect {| |}]
;;
