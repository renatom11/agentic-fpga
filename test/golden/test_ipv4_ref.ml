(* Unit tests for the IPv4 header builder and checksum oracle (WO-0033 X-8).

   The anchor first, then the builder, then the finding. Everything here runs
   with no Hardcaml, no simulator and no design: this is an oracle's own test
   suite, and it fails when the ORACLE is wrong.

   ADR-0005 rule 2: [%expect] blocks are EMPTY and promoted from CI's own diff
   output; every verdict is asserted in OCaml, so a promotion that captured
   wrong output would still leave a red test. *)

let failures = ref 0

let check ~what cond =
  if cond
  then Printf.printf "%s: ok\n" what
  else (
    Printf.printf "%s: FAILED\n" what;
    incr failures)
;;

let verdict () =
  if !failures = 0
  then print_endline "VERDICT ok"
  else (
    failures := 0;
    failwith "ipv4 oracle verdict mismatch")
;;

let%expect_test "X-8 anchor: RFC 1071 §3's numerical example" =
  (* The external authority named in ipv4_ref.ml's header. The octet string and
     the two results are RFC 1071 §3's; the arithmetic below is this file's, so
     agreement is the oracle meeting the published example rather than agreeing
     with itself. The anchor is EMBEDDED and UNCONFIRMED at this SHA — the
     proxy in this environment refuses rfc-editor.org and datatracker.ietf.org
     with 403, so the quotation has not been re-fetched. That obligation is
     carried in J-dv_lead-0017 and on SO-ip_eth_rx_64.md, not discharged here. *)
  let os = Ipv4_ref.rfc1071_example_octets in
  check ~what:"the vector is eight octets" (List.length os = 8);
  check
    ~what:"one's-complement sum = RFC 1071 §3's 0xddf2"
    (Ipv4_ref.sum os = Ipv4_ref.rfc1071_example_sum);
  check
    ~what:"checksum = RFC 1071 §3's 0x220d"
    (Ipv4_ref.checksum os = Ipv4_ref.rfc1071_example_checksum);
  check
    ~what:"sum and checksum are one's complements of each other"
    (Ipv4_ref.rfc1071_example_sum + Ipv4_ref.rfc1071_example_checksum = 0xffff);
  (* the residue form, on the same vector: the octets together with their own
     checksum sum to 0xFFFF — SPEC-M14 §6.1's normative check *)
  let with_checksum = os @ [ Ipv4_ref.checksum os lsr 8; Ipv4_ref.checksum os land 0xff ] in
  check ~what:"SPEC-M14 §6.1's residue form holds on the anchor" (Ipv4_ref.residue_ok with_checksum);
  (* RFC 1071 §2's byte-order property: the sum of the swapped string is the
     swapped sum. A halfword endianness error survives every palindrome and
     dies here. *)
  check
    ~what:"RFC 1071 §2: byte-swapped octets give the byte-swapped sum"
    (Ipv4_ref.sum (Ipv4_ref.byte_swap os) = Ipv4_ref.swap16 Ipv4_ref.rfc1071_example_sum);
  check
    ~what:"the two internal implementations agree on the anchor"
    (Ipv4_ref.sum_folding os = Ipv4_ref.sum_accumulate os);
  verdict ();
  [%expect {| |}]
;;

let%expect_test "X-8: the builder's headers verify, and its field layout is SPEC-M14 §6.1's" =
  let h = Ipv4_ref.accepted () in
  let os = Ipv4_ref.octets h in
  check ~what:"twenty octets, no options (IHL 5)" (List.length os = 20);
  check ~what:"the built header verifies by the residue form" (Ipv4_ref.residue_ok os);
  let at k = List.nth os k in
  check ~what:"octet 0 is version 4, IHL 5" (at 0 = 0x45);
  check ~what:"octet 1 is DSCP 0x2A with ECN 0b11" (at 1 = 0xAB);
  check ~what:"octets 2-3 are total length 46 = 0x00 0x2E" (at 2 = 0x00 && at 3 = 0x2E);
  check ~what:"octet 6 has flags 0 and offset 0" (at 6 = 0x00 && at 7 = 0x00);
  check ~what:"octet 8 is TTL 64" (at 8 = 64);
  check ~what:"octet 9 is protocol 17" (at 9 = 17);
  check
    ~what:"REQ-012: source 10.1.2.3 lands most-significant octet first"
    (at 12 = 0x0A && at 13 = 0x01 && at 14 = 0x02 && at 15 = 0x03);
  check
    ~what:"REQ-012: destination 192.0.2.1 reads 0xC0000201 on the wire"
    (at 16 = 0xC0 && at 17 = 0x00 && at 18 = 0x02 && at 19 = 0x01);
  (* M14-C1's trap, stated as a property of the builder: ip_hdr_dscp is octet 1
     bits 7:2 only, so a decode that carried octet 1 whole would report 0xAB. *)
  check ~what:"DSCP is the top six bits of octet 1" (at 1 lsr 2 = 0x2A);
  check ~what:"ECN is the bottom two, and no port carries it" (at 1 land 0x3 = 0b11);
  print_endline (Ipv4_ref.to_string h);
  verdict ();
  [%expect {| |}]
;;

let%expect_test "X-8: M14-B2 — one flipped bit breaks the residue and nothing else" =
  let h = Ipv4_ref.accepted () in
  let good = Ipv4_ref.octets h in
  let broken = Ipv4_ref.flip_bit h ~octet:8 ~bit:0 in
  check ~what:"the intact header verifies" (Ipv4_ref.residue_ok good);
  check ~what:"the flipped one does not" (not (Ipv4_ref.residue_ok broken));
  check
    ~what:"exactly one octet differs"
    (List.length (List.filter (fun x -> x) (List.map2 ( <> ) good broken)) = 1);
  check
    ~what:"and the checksum FIELD is untouched — the corruption is in the data, \
           not in the field, which is what row M14-B2 requires"
    (Ipv4_ref.header_checksum_of good = Ipv4_ref.header_checksum_of broken);
  verdict ();
  [%expect {| |}]
;;

let%expect_test "X-8: M14-B3 — (b) is constructible; (a) is not, and C-48 says why" =
  (* (b) A header whose folded sum reaches 0xFFFF by way of an end-around carry:
     the raw ten-halfword total exceeds 0xFFFF and the header still verifies.
     This separates the correct arithmetic from a design that adds modulo 2^16
     with NO fold at all — a real and reachable defect. *)
  (match Ipv4_ref.end_around_carry () with
   | Some h ->
     let os = Ipv4_ref.octets h in
     check ~what:"(b) exists and verifies" (Ipv4_ref.residue_ok os);
     check
       ~what:"(b) really does carry: the unfolded total exceeds 0xFFFF"
       (List.fold_left ( + ) 0 (Ipv4_ref.halfwords os) > 0xffff);
     check
       ~what:"(b) kills a no-fold design: plain modulo-2^16 addition is not 0xFFFF"
       (List.fold_left ( + ) 0 (Ipv4_ref.halfwords os) land 0xffff <> 0xffff)
   | None -> check ~what:"(b) was found by search" false);
  (* (a) The stimulus row M14-B3(a) commissions does not exist. ipv4_ref.ml's
     header comment carries the three-line proof; this is the search that
     confirms it over the whole identification field, on accepted and rejected
     headers alike. A None here is the finding, not an omission — ledger C-48. *)
  check
    ~what:"C-48: no 20-octet header separates fold-once from the fixpoint fold"
    (Ipv4_ref.fold_once_divergence () = None);
  (* and the defect is still implemented, so the claim above is falsifiable:
     fold_once is genuinely a different function, it just never differs in its
     VERDICT on ten halfwords. *)
  (* halfwords 0xFFFF, 0xFFFF, 0xFFFF, 0x0002 — raw total 0x2FFFF, so the
     once-folded value is 0xFFFF + 2 = 0x10001 and still carries, while the
     fixpoint fold reaches 0x0002. The two functions differ in their VALUE
     here, and C-48 is careful to claim only that they never differ in their
     VERDICT: both of these are ≠ 0xFFFF, so both reject, which is exactly the
     shape of the proof. A test that showed only "the values differ" would be
     evidence for a killability the verdicts do not support — the mistake
     C-48 exists to record. *)
  let carries_twice = [ 0xFF; 0xFF; 0xFF; 0xFF; 0xFF; 0xFF; 0x00; 0x02 ] in
  check
    ~what:"fold_once really is a different function where the fold can carry twice"
    (Ipv4_ref.fold_once carries_twice <> Ipv4_ref.sum carries_twice);
  check ~what:"and the correct answer there is 0x0002" (Ipv4_ref.sum carries_twice = 0x0002);
  verdict ();
  [%expect {| |}]
;;

let%expect_test "X-8: the rejection classes of SPEC-M14 §9, built and checked" =
  (* Every header below is one AP-ip_eth_rx_64 family B drives. The oracle's job
     is to build them with a CORRECT checksum, so that the condition under test
     is the only thing wrong — the architect's own addition to M14-B5 (WO-0029
     Return §2), without which REQ-602 rejects the stimulus and the comparison
     is vacuous. *)
  let base = Ipv4_ref.accepted () in
  let verify label h =
    let os = Ipv4_ref.octets h in
    check ~what:(Printf.sprintf "%s: checksum recomputed, so REQ-602 accepts it" label)
      (Ipv4_ref.residue_ok os)
  in
  verify "B1 version 6" { base with Ipv4_ref.version = 6 };
  verify "B1 IHL 6" { base with Ipv4_ref.ihl = 6 };
  verify "B4 more-fragments set" { base with Ipv4_ref.flags = 0b001 };
  verify "B4 fragment offset 0x0100" { base with Ipv4_ref.fragment_offset = 0x0100 };
  verify "B5 DF set" { base with Ipv4_ref.flags = 0b010 };
  verify "B5 reserved bit set" { base with Ipv4_ref.flags = 0b100 };
  verify "B7 foreign destination" { base with Ipv4_ref.dst_ip = 0x0A0A0A0A };
  verify "B8 protocol 1" { base with Ipv4_ref.protocol = 1 };
  verify "B9 total length 1501" { base with Ipv4_ref.total_length = 1501 };
  verify "K7/ADR-0013 total length 0" { base with Ipv4_ref.total_length = 0 };
  (* M14-B5's whole point: DF and the reserved bit change the flags octet, so a
     bench that did NOT recompute would be driving a bad checksum and testing
     REQ-602 instead of REQ-603. *)
  let df = { base with Ipv4_ref.flags = 0b010 } in
  check
    ~what:"B5: the DF datagram differs from the accepted one in octet 6 and the checksum"
    (List.nth (Ipv4_ref.octets df) 6 <> List.nth (Ipv4_ref.octets base) 6
     && Ipv4_ref.header_checksum df <> Ipv4_ref.header_checksum base);
  verdict ();
  [%expect {| |}]
;;
