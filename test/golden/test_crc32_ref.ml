(* Anchor and property tests for the REQ-305 bit-serial CRC-32 reference.

   ADR-0005 rule 2: every [%expect] block below is left EMPTY on purpose. The
   snapshots are promoted from CI's own diff output and are never authored by
   hand — a plausible-looking hand-written snapshot is fabricated evidence.
   Consequently the expected values are not in the snapshots: every constant
   this suite anchors is written into the OCaml below, compared there, and a
   mismatch both prints MISMATCH and raises. Promoting a red snapshot cannot
   turn a failure green.

   Everything here derives from requirements.md §4 at b4b4cf4 and SPEC-M02 §6.1
   at 22145b5. No RTL was read. *)

let failures = ref 0
let hex v = Printf.sprintf "0x%08X" v
let start () = failures := 0

let finish () =
  if !failures > 0
  then failwith (Printf.sprintf "%d anchor check(s) failed" !failures)
;;

let check ~name ~expected actual =
  if actual = expected
  then Printf.printf "%-56s %s ok\n" name (hex actual)
  else (
    incr failures;
    Printf.printf "%-56s MISMATCH expected %s got %s\n" name (hex expected) (hex actual))
;;

let check_int ~name ~expected actual =
  if actual = expected
  then Printf.printf "%-56s %d ok\n" name actual
  else (
    incr failures;
    Printf.printf "%-56s MISMATCH expected %d got %d\n" name expected actual)
;;

(* A deterministic generator written out in full rather than taken from
   [Random]: the expect snapshots must be byte-stable across OCaml versions
   and across runs, and [Random]'s algorithm is neither guaranteed nor ours.
   Classic LCG, values kept below 2^30 so the multiply cannot overflow a
   63-bit int. *)
let seed = ref 123456789

let next_octet () =
  seed := ((1103515245 * !seed) + 12345) land 0x3FFFFFFF;
  (!seed lsr 7) land 0xff
;;

let reset_generator () = seed := 123456789

(* An explicit loop rather than [List.init]: the standard library does not
   promise the order in which [List.init] applies its function, and a stateful
   generator inside it would make the snapshot depend on that. *)
let random_octets n =
  let acc = ref [] in
  for _ = 1 to n do
    acc := next_octet () :: !acc
  done;
  List.rev !acc
;;

let random_crc () =
  let a = next_octet () in
  let b = next_octet () in
  let c = next_octet () in
  let d = next_octet () in
  (a lsl 24) lor (b lsl 16) lor (c lsl 8) lor d
;;

let%expect_test "REQ-303 anchor: the reference reproduces the published check value" =
  start ();
  reset_generator ();
  (* PROTOCOL §10 and charter §3: this is the external anchor, and it is
     asserted before the reference is allowed to judge anything. 0xCBF43926 is
     the canonical CRC-32/ISO-HDLC check value; requirements.md §4's provenance
     note records that the WO-0002 text said 0xCBF43F26 and was corrected. *)
  check ~name:"REQ-303 CRC32(\"123456789\")" ~expected:Crc32_ref.check_value
    (Crc32_ref.of_string "123456789");
  (* The seed premise the whole port convention rests on: the identity element
     of the running value is 0x00000000, not REQ-301's 0xFFFFFFFF. *)
  check ~name:"CRC32(empty) — the port seed (SPEC-M02 §6.1 note 1)" ~expected:0x00000000
    (Crc32_ref.of_string "");
  check ~name:"register_of_running 0 — REQ-301's initial value"
    ~expected:Crc32_ref.init_register (Crc32_ref.register_of_running 0);
  check ~name:"running_of_register 0xFFFFFFFF" ~expected:0x00000000
    (Crc32_ref.running_of_register 0xFFFFFFFF);
  check ~name:"reflect ~bits:8 0x01" ~expected:0x80 (Crc32_ref.reflect ~bits:8 0x01);
  check ~name:"reflect ~bits:32 0x00000001" ~expected:0x80000000
    (Crc32_ref.reflect ~bits:32 0x00000001);
  finish ();
  [%expect {| |}]
;;

let%expect_test "SPEC-M02 §6.1 worked example 1 — two updates, eight octets then one" =
  start ();
  reset_generator ();
  let after_8 = Crc32_ref.update_string ~crc_in:0x00000000 "12345678" in
  (* 0x9AE0DAAF is derived, not a requirement: it follows from REQ-301's
     parameterisation and any implementation of it reproduces it. It is checked
     because SPEC-M02 §6.1 states it and a bench author will copy it. *)
  check ~name:"update 1: crc_in=0, 8 octets \"12345678\"" ~expected:0x9AE0DAAF after_8;
  check ~name:"update 2: crc_in=0x9AE0DAAF, 1 octet \"9\"" ~expected:Crc32_ref.check_value
    (Crc32_ref.update_string ~crc_in:after_8 "9");
  (* REQ-012's octet order, which is wrong under any other mapping. *)
  let packed = Crc32_ref.tdata_of_octets (Crc32_ref.octets_of_string "12345678") in
  let expected_packed = 0x3837363534333231L in
  if Int64.equal packed expected_packed
  then Printf.printf "%-56s 0x%016LX ok\n" "tdata packing of \"12345678\" (REQ-012)" packed
  else (
    incr failures;
    Printf.printf "%-56s MISMATCH expected 0x%016LX got 0x%016LX\n"
      "tdata packing of \"12345678\" (REQ-012)" expected_packed packed);
  (* SPEC-M02 §6.1: crc_out does not depend on data[63:8n]. The reference takes
     only the covered octets, so the property is structural here; the directed
     test that matters runs against the RTL. *)
  check ~name:"one-octet update ignores uncovered positions" ~expected:Crc32_ref.check_value
    (Crc32_ref.update ~crc_in:after_8 [ Char.code '9' ]);
  finish ();
  [%expect {| |}]
;;

let%expect_test "REQ-304 residue over several frame lengths" =
  start ();
  reset_generator ();
  let lengths = [ 1; 9; 26; 46; 60; 64; 100; 1500 ] in
  List.iter
    (fun n ->
      let frame = random_octets n in
      let fcs = Crc32_ref.of_octets frame in
      let received = frame @ Crc32_ref.fcs_octets fcs in
      check
        ~name:(Printf.sprintf "REQ-304 residue over %d-octet frame + its FCS" n)
        ~expected:Crc32_ref.residue
        (Crc32_ref.of_octets received))
    lengths;
  (* The residue is constant only because REQ-202 fixes the wire order. Reverse
     it and the constant is gone — which is what makes the two requirements one
     decision seen from two sides, and is worth a check so a bench that packs
     the FCS most-significant-first fails here rather than at the RTL. *)
  let frame = random_octets 60 in
  let fcs = Crc32_ref.of_octets frame in
  let wrong_order = frame @ List.rev (Crc32_ref.fcs_octets fcs) in
  let residue_wrong = Crc32_ref.of_octets wrong_order in
  if residue_wrong <> Crc32_ref.residue
  then
    Printf.printf "%-56s differs from the residue, as REQ-202 requires\n"
      "FCS appended most-significant-octet-first"
  else (
    incr failures;
    Printf.printf "%-56s UNEXPECTEDLY equals the residue\n"
      "FCS appended most-significant-octet-first");
  finish ();
  [%expect {| |}]
;;

let%expect_test "REQ-302 serial decomposition and the second bit-serial formulation" =
  start ();
  reset_generator ();
  let cases = 3000 in
  let serial_mismatches = ref 0 in
  let cross_mismatches = ref 0 in
  for _ = 1 to cases do
    let n = (next_octet () mod 8) + 1 in
    let crc_in = random_crc () in
    let octets = random_octets n in
    let one_at_a_time =
      List.fold_left (fun acc octet -> Crc32_ref.update ~crc_in:acc [ octet ]) crc_in octets
    in
    if Crc32_ref.update ~crc_in octets <> one_at_a_time then incr serial_mismatches;
    if Crc32_ref.update ~crc_in octets <> Crc32_ref.update_lsb_first ~crc_in octets
    then incr cross_mismatches
  done;
  (* REQ-302's property, evaluated on the reference itself. It is the same
     property the RTL will be judged on, so a reference that failed it would be
     an oracle that cannot express the requirement. *)
  check_int ~name:(Printf.sprintf "serial-decomposition mismatches over %d cases" cases)
    ~expected:0 !serial_mismatches;
  (* Two structurally different bit-serial arrangements of REQ-301: a
     cross-check of my arithmetic, NOT the external anchor. *)
  check_int ~name:(Printf.sprintf "cross-formulation mismatches over %d cases" cases)
    ~expected:0 !cross_mismatches;
  finish ();
  [%expect {| |}]
;;

let%expect_test "SPEC-M02 §6.1 worked example 2 — the M03 and M04 update decompositions" =
  start ();
  reset_generator ();
  let frame = random_octets 60 in
  let take_from list start count =
    List.filteri (fun i _ -> i >= start && i < start + count) list
  in
  (* M04: seven updates of eight octets then one of four over the 60 octets
     before the FCS. *)
  let tx = ref 0x00000000 in
  for word = 0 to 6 do
    tx := Crc32_ref.update ~crc_in:!tx (take_from frame (8 * word) 8)
  done;
  tx := Crc32_ref.update ~crc_in:!tx (take_from frame 56 4);
  check ~name:"M04: 7x8 + 1x4 equals the whole-frame CRC" ~expected:(Crc32_ref.of_octets frame)
    !tx;
  (* M03: eight updates of eight over all 64 received octets reaches the
     residue. *)
  let received = frame @ Crc32_ref.fcs_octets !tx in
  let rx = ref 0x00000000 in
  for word = 0 to 7 do
    rx := Crc32_ref.update ~crc_in:!rx (take_from received (8 * word) 8)
  done;
  check ~name:"M03: 8x8 over frame+FCS reaches REQ-304's residue"
    ~expected:Crc32_ref.residue !rx;
  finish ();
  [%expect {| |}]
;;

let%expect_test "raw-register conversions (SPEC-M02 §6.1 note 3) and §4's provenance value" =
  start ();
  (* Note 3's two conversions, which a reader comparing against Verilog prior
     art needs and which are arithmetic on the REQ constants, not requirements
     of their own. *)
  check ~name:"REQ-303 in the raw-register convention" ~expected:0x340BC6D9
    (Crc32_ref.check_value lxor Crc32_ref.final_xor);
  check ~name:"REQ-304 in the raw-register convention" ~expected:0xDEBB20E3
    (Crc32_ref.residue lxor Crc32_ref.final_xor);
  (* requirements.md §4's provenance note: 0xC704DD7B is the same residue in
     the non-reflected register convention. This is the constant the WO-0002
     text carried and that one careful reading after another failed to catch. *)
  check ~name:"§4 provenance: register_of_running(residue)" ~expected:0xC704DD7B
    (Crc32_ref.register_of_running Crc32_ref.residue);
  check ~name:"round trip running -> register -> running" ~expected:Crc32_ref.residue
    (Crc32_ref.running_of_register (Crc32_ref.register_of_running Crc32_ref.residue));
  finish ();
  [%expect {| |}]
;;
