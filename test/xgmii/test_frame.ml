(* Unit tests for the frame builder (SPEC-M03 §8's stimulus table, REQ-202's
   FCS wire order, REQ-203's padding, REQ-103's delivered octets).

   ADR-0005 rule 2: every [%expect] block is left EMPTY and is promoted from
   CI's own diff output. Every number this file cares about is asserted in
   OCaml as well, so a promotion that captured wrong output still leaves a red
   test. *)

let failures = ref 0

let expect_int ~what ~expected got =
  if got = expected
  then Printf.printf "%s = %d\n" what got
  else (
    Printf.printf "%s = %d, EXPECTED %d\n" what got expected;
    incr failures)
;;

let hex octets = String.concat " " (List.map (Printf.sprintf "%02X") octets)

let expect_octets ~what ~expected got =
  if got = expected
  then Printf.printf "%s = %s\n" what (hex got)
  else (
    Printf.printf "%s = %s, EXPECTED %s\n" what (hex got) (hex expected);
    incr failures)
;;

let verdict () =
  if !failures = 0
  then print_endline "VERDICT ok"
  else (
    print_endline "VERDICT WRONG";
    failures := 0;
    failwith "frame builder verdict mismatch")
;;

let sub l pos len = List.filteri (fun i _ -> i >= pos && i < pos + len) l

let%expect_test "SPEC-M03 §8's stimulus frame, octet for octet" =
  let f = Frame.stress_frame ~sequence:0 () in
  (* requirements.md §0.3: a frame length is DA through FCS inclusive, so §8's
     minimum-length frame is 64 octets and delivers 60 (REQ-103). *)
  expect_int ~what:"frame octets, DA through FCS" ~expected:64 (List.length f);
  expect_octets
    ~what:"destination MAC, offsets 0-5"
    ~expected:[ 0x02; 0x00; 0x00; 0x00; 0x00; 0x01 ]
    (sub f 0 6);
  expect_octets
    ~what:"source MAC, offsets 6-11"
    ~expected:[ 0x02; 0x00; 0x00; 0x00; 0x00; 0x02 ]
    (sub f 6 6);
  expect_octets ~what:"ethertype, offsets 12-13" ~expected:[ 0x08; 0x00 ] (sub f 12 2);
  expect_int ~what:"filler octets, offsets 18-59" ~expected:42 (List.length (sub f 18 42));
  expect_octets
    ~what:"the first three filler octets (the default pattern is the offset itself)"
    ~expected:[ 0x12; 0x13; 0x14 ]
    (sub f 18 3);
  expect_int ~what:"delivered octets (REQ-103)" ~expected:60 (List.length (Frame.delivered f));
  Printf.printf "frame 0: %s\n" (hex f);
  verdict ();
  [%expect {| |}]
;;

let%expect_test "REQ-012: the sequence number's most significant octet is at offset 14" =
  let f = Frame.stress_frame ~sequence:0x01020304 () in
  expect_octets
    ~what:"sequence number, offsets 14-17"
    ~expected:[ 0x01; 0x02; 0x03; 0x04 ]
    (sub f 14 4);
  (* REQ-020's order check reads the sequence back out of the delivered octets,
     which is where a bench sees it. *)
  expect_int
    ~what:"sequence read back from the delivered octets"
    ~expected:0x01020304
    (Frame.sequence_of (Frame.delivered f));
  List.iter
    (fun i ->
      let seq = Frame.sequence_of (Frame.delivered (Frame.stress_frame ~sequence:i ())) in
      if seq <> i then failwith "a stress frame's sequence number did not round-trip")
    [ 0; 1; 2; 255; 256; 65_535; 9_999 ];
  verdict ();
  [%expect {| |}]
;;

let%expect_test "REQ-304: every stimulus frame carries a valid FCS, and the wire order matters" =
  (* The frame builder's FCS comes from the REQ-305 bit-serial reference, whose
     own suite anchors it on REQ-303's published 0xCBF43926. Here the property
     that matters to a link partner is REQ-304's: the CRC over the frame
     INCLUDING its own FCS is the residue 0x2144DF1C — which is exactly the
     check M03 performs (SPEC-M03 §6.1), so a frame this model believes valid
     is provably one M03 must accept, before any design exists. *)
  List.iter
    (fun sequence ->
      let f = Frame.stress_frame ~sequence () in
      if not (Frame.residue_ok f)
      then failwith (Printf.sprintf "stimulus frame %d fails REQ-304's residue" sequence))
    [ 0; 1; 2; 3; 4; 5; 6; 7; 8; 9 ];
  let f = Frame.stress_frame ~sequence:0 () in
  let payload = sub f 0 60 in
  let wire_fcs = sub f 60 4 in
  Printf.printf "FCS of frame 0, wire order (REQ-202, least significant first): %s\n" (hex wire_fcs);
  expect_octets ~what:"FCS from the REQ-305 reference" ~expected:wire_fcs (Frame.fcs payload);
  (* REQ-202 pins the wire order because REQ-304's residue is constant only for
     that order (requirements.md §4's provenance note). Reversing the four
     octets must therefore break the residue — if it did not, the residue check
     would be blind to the one convention error this programme has already paid
     for once. *)
  if Frame.residue_ok (payload @ List.rev wire_fcs)
  then failwith "the residue check is insensitive to the FCS octet order";
  (* And one flipped payload bit must break it too — the REQ-104 case. *)
  let corrupted =
    List.mapi (fun i o -> if i = 30 then o lxor 0x01 else o) payload @ wire_fcs
  in
  if Frame.residue_ok corrupted then failwith "the residue check missed a flipped bit";
  verdict ();
  [%expect {| |}]
;;

let%expect_test "REQ-203: padding takes a short frame to 60 octets before the FCS" =
  let short = List.init 20 (fun i -> 0x80 lor i) in
  let padded = Frame.pad_to_60 short in
  expect_int ~what:"padded octets before the FCS" ~expected:60 (List.length padded);
  expect_octets ~what:"the first pad octets, offsets 20-23" ~expected:[ 0; 0; 0; 0 ] (sub padded 20 4);
  expect_octets ~what:"the payload is unchanged" ~expected:short (sub padded 0 20);
  let framed = Frame.with_fcs padded in
  expect_int ~what:"frame octets DA through FCS (§0.3's minimum)" ~expected:64 (List.length framed);
  if not (Frame.residue_ok framed) then failwith "a padded frame's FCS is wrong";
  (* pad_to_60 leaves a frame already at or above 60 octets alone: REQ-203
     pads up to 60 and never truncates. *)
  expect_int
    ~what:"a 1514-octet frame is not shortened"
    ~expected:1514
    (List.length (Frame.pad_to_60 (List.init 1514 (fun _ -> 0xA5))));
  verdict ();
  [%expect {| |}]
;;
