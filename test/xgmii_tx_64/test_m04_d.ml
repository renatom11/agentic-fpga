(** Family D — the FCS: REQ-202, REQ-304, REQ-305, SPEC-M02 §6.1 (WO-0081
    §1.3, §2, §6.2-§6.4). Three units: U11 (M04-D1, M04-D2, M04-D4, M04-D5),
    U12 (M04-D3), U13 (M04-D6), in that order (WO-0081 §16.1).

    {2 Why this family is a round and not a paragraph (WO-0081 §0)}

    Obligation 1's standing wire decoder has judged REQ-202 on every M04
    frame since the first unit: it compares the four octets before the
    terminate character, in wire order, against [Frame.fcs] of EVERYTHING
    BEFORE THEM ON THE WIRE. That is a SELF-CONSISTENCY check — it asks
    whether the wire agrees with itself, and it says nothing about whether
    the covered range is the SOURCE FRAME this bench built. [M04-D1] is the
    difference: it compares the wire's FCS against [Frame.fcs] of
    [Frame.pad_to_60 (content_octets ~p)], the octet string the bench
    actually handed to the source stream — which the decoder has never
    seen. A design that corrupted the payload and then computed a correct
    FCS OVER THE CORRUPTION would pass the decoder on every frame this
    suite has ever driven and fail [M04-D1] on its first vector. Every FCS
    expectation in this file, and in [test_m04_g.ml]'s M04-G9, is the
    REQ-305 bit-serial reference reached through [Dv_xgmii.Frame.fcs] —
    never the design's own output, never a loopback, never the standing
    decoder's own verdict (WO-0081 §9.5, trap T5, BOUNCE BM12). *)

open! Base
open Bench

let fail row msg = failwith (String.concat [ row; ": "; msg ])

(* The raw byte at [lane] of [wire], data or control alike — the same
   accessor test_m04_b.ml's own [octet_value] uses. *)
let octet_value wire lane =
  match Dv_xgmii.Xgmii_word.lane wire lane with
  | Dv_xgmii.Xgmii_word.Data d -> d
  | Dv_xgmii.Xgmii_word.Control d -> d
;;

(* ---- U11: M04-D1, M04-D2, M04-D4, M04-D5 ---------------------------------- *)
(* Eight runs, M04-B4's own directed set (WO-0081 §6.2). *)

let directed_lengths = [ 1; 20; 59; 60; 61; 64; 67; 1514 ]

let run_d1_d2_d4_d5 () =
  let base_row = "M04-D1, M04-D2, M04-D4, M04-D5" in
  let runs = run_lengths directed_lengths in
  List.iter runs ~f:(fun (p, t, samples) ->
    let row = String.concat [ base_row; " (P="; Int.to_string p; ")" ] in
    let c = first_accepted_cycle samples in
    let content = content_octets ~p in
    let padded = Dv_xgmii.Frame.pad_to_60 content in
    let expected_fcs = Dv_xgmii.Frame.fcs padded in
    let f = Int.max p 60 + 4 in
    let frame = wire_frame samples in
    let octets = frame.Dv_xgmii.Tx_decoder.octets in
    (* Assertion 1: the decoded wire frame's octet count is F. *)
    if List.length octets <> f
    then
      fail
        row
        (String.concat
           [ "wire octet count = "; Int.to_string (List.length octets); ", expected F = "
           ; Int.to_string f
           ]);
    (* Assertion 3, stated first so a length mismatch is not read as a value
       mismatch (WO-0081 §6.2 row 3): Frame.fcs returns exactly 4 octets. *)
    if List.length expected_fcs <> 4
    then
      fail
        row
        (String.concat
           [ "Frame.fcs (pad_to_60 content) returned "
           ; Int.to_string (List.length expected_fcs)
           ; " octets, expected 4"
           ]);
    (* Assertion 2, M04-D1: the four wire octets at F-4..F-1 equal
       Frame.fcs(pad_to_60(content)), octet for octet, in wire (list)
       order — REQ-202's least-significant-octet-first order (trap T6: the
       pad is INSIDE the FCS computation, never appended after it). This is
       the whole difference from the standing decoder's own
       self-consistency check (see this file's own header). *)
    let got_fcs = List.sub octets ~pos:(f - 4) ~len:4 in
    if not (List.equal Int.equal got_fcs expected_fcs)
    then
      fail
        row
        (String.concat
           [ "wire FCS octets = ["
           ; String.concat ~sep:"; " (List.map got_fcs ~f:Int.to_string)
           ; "], expected Frame.fcs(pad_to_60(content)) = ["
           ; String.concat ~sep:"; " (List.map expected_fcs ~f:Int.to_string)
           ; "]"
           ]);
    (* Assertion 4, M04-D2: Frame.residue_ok over the WHOLE decoded frame
       (DA through FCS) — corroboration only, reading the same Crc32_ref
       oracle a second time, and never reported as a second REQ-202 anchor
       beside M04-D1 (WO-0081 §1.3, BOUNCE BM8). *)
    if not (Dv_xgmii.Frame.residue_ok octets)
    then
      fail
        row
        "Frame.residue_ok over the decoded frame (DA through FCS) is false — \
         corroboration only, never a second REQ-202 anchor (M04-D2)";
    (* Assertion 5, M04-D4: each of the four FCS octets' own (cycle, lane) —
       wire index k (k in F-4..F-1) at lane (Int.rem k 8) of the sample at
       cycle (C + 2 + k/8), read directly off the raw sample, which the
       decoder cannot give (WO-0081 §6.2 row 5). *)
    List.iteri expected_fcs ~f:(fun j expected_octet ->
      let k = f - 4 + j in
      let lane = Int.rem k 8 in
      let cyc = c + 2 + (k / 8) in
      match List.find samples ~f:(fun (s : sample) -> s.cycle = cyc) with
      | None ->
        fail
          row
          (String.concat
             [ "no sample at cycle "; Int.to_string cyc; " for FCS octet "; Int.to_string j ])
      | Some s ->
        let got = octet_value s.wire lane in
        if got <> expected_octet
        then
          fail
            row
            (String.concat
               [ "FCS octet "; Int.to_string j; " (wire index "; Int.to_string k
               ; "): lane "; Int.to_string lane; " of cycle "; Int.to_string cyc; " = "
               ; Int.to_string got; ", expected "; Int.to_string expected_octet
               ]));
    (* M04-D5 (NO-ASSERT), in this unit's own title and round-wide (WO-0081
       §6.2 row 8, §9.5): nothing above, or anywhere in this file, asserts
       the CRC register's ENABLE or its octet_count — both are internal
       (§6.3 item 1), and a design driving octet_count = 0 on a held cycle
       is convicted at M02's own domain check, not here. *)
    assert_instruments_clean t ~row);
  (* Assertion 6, M04-D4's contrast, asserted explicitly at P=60 and P=64
     (WO-0081 §6.2 row 6).

     DISAGREEMENT WITH THE PACKET, reported per BM3/class D5 rather than
     adopted: WO-0081 §6.1's prose and §6.2 row 6 both state that at P=60,
     "lane 3 of C+9 carries pad octet 59 (0x00)". P=60 has PAD COUNT 0 —
     the packet's own §6.1 master table row for P=60 states "pad" = 0 — so
     wire octet 59 is the LAST CONTENT OCTET, not a pad octet, and its
     value is content_octets ~p:60 at index 59 = 1 + Int.rem 59 127 = 60
     (0x3C), never 0x00 by the content builder's own documented invariant
     (bench.mli's content_octets: "never 0x00, which is what keeps a
     padding claim honest"). The PLACEMENT claim (lane 3 of C+9) is
     unaffected and is what this assertion checks; the VALUE it is checked
     against is derived from content_octets, not hand-adopted as 0x00. *)
  (match List.find runs ~f:(fun (p, _, _) -> p = 60) with
   | None -> fail base_row "no P=60 run found among the directed set"
   | Some (p, _, samples) ->
     let row = String.concat [ base_row; " (P=60 contrast, M04-D4)" ] in
     let c = first_accepted_cycle samples in
     let content = content_octets ~p in
     let expected_fcs = Dv_xgmii.Frame.fcs (Dv_xgmii.Frame.pad_to_60 content) in
     (match List.find samples ~f:(fun (s : sample) -> s.cycle = c + 9) with
      | None -> fail row "no sample at C+9"
      | Some s ->
        let last_content_octet = List.nth_exn content 59 in
        let got_lane3 = octet_value s.wire 3 in
        if got_lane3 <> last_content_octet
        then
          fail
            row
            (String.concat
               [ "lane 3 of C+9 = "; Int.to_string got_lane3
               ; ", expected content octet 59 = "; Int.to_string last_content_octet
               ]);
        let got_fcs = List.init 4 ~f:(fun k -> octet_value s.wire (k + 4)) in
        if not (List.equal Int.equal got_fcs expected_fcs)
        then fail row "lanes 4-7 of C+9 do not equal Frame.fcs(pad_to_60(content))"));
  (match List.find runs ~f:(fun (p, _, _) -> p = 64) with
   | None -> fail base_row "no P=64 run found among the directed set"
   | Some (p, _, samples) ->
     let row = String.concat [ base_row; " (P=64 contrast, M04-D4)" ] in
     let c = first_accepted_cycle samples in
     let content = content_octets ~p in
     let expected_fcs = Dv_xgmii.Frame.fcs (Dv_xgmii.Frame.pad_to_60 content) in
     (match List.find samples ~f:(fun (s : sample) -> s.cycle = c + 9) with
      | None -> fail row "no sample at C+9"
      | Some s ->
        let last_content_octet = List.nth_exn content 63 in
        let got_lane7 = octet_value s.wire 7 in
        if got_lane7 <> last_content_octet
        then
          fail
            row
            (String.concat
               [ "lane 7 of C+9 = "; Int.to_string got_lane7
               ; ", expected content octet 63 = "; Int.to_string last_content_octet
               ]));
     (match List.find samples ~f:(fun (s : sample) -> s.cycle = c + 10) with
      | None -> fail row "no sample at C+10"
      | Some s ->
        let got_fcs = List.init 4 ~f:(fun k -> octet_value s.wire k) in
        if not (List.equal Int.equal got_fcs expected_fcs)
        then fail row "lanes 0-3 of C+10 do not equal Frame.fcs(pad_to_60(content))"))
;;

let%expect_test
  "M04-D1, M04-D2, M04-D4: the four wire FCS octets against the REQ-305 \
   oracle over the padded source frame and their lane/cycle placement at \
   eight lengths; M04-D5: the CRC enable and its octet_count are NOT \
   asserted"
  =
  run_d1_d2_d4_d5 ();
  [%expect {||}]
;;

(* ---- U12: M04-D3 ----------------------------------------------------------- *)
(* Two runs, P = 60, differing only in octet 0 (WO-0081 §6.3). *)

let run_d3 () =
  let row = "M04-D3" in
  let base = content_octets ~p:60 in
  let frame_a = base in
  let frame_b = List.mapi base ~f:(fun i o -> if i = 0 then 2 else o) in
  match run_frames [ frame_a; frame_b ] with
  | [ (content_a, t_a, samples_a); (content_b, t_b, samples_b) ] ->
    (* Assertion 1, anti-vacuity, first and by itself: the two content
       strings have the same length, differ at index 0, and agree
       everywhere else. If this fails, nothing below means anything. *)
    if List.length content_a <> List.length content_b
    then fail row "the two driven content strings differ in length";
    (match content_a, content_b with
     | a0 :: rest_a, b0 :: rest_b ->
       if a0 = b0
       then fail row "octet 0 is identical in both frames — the row is vacuous by construction";
       if a0 <> 1 || b0 <> 2
       then
         fail
           row
           (String.concat
              [ "octet 0: frame A = "; Int.to_string a0; ", frame B = "; Int.to_string b0
              ; ", expected 1 and 2"
              ]);
       if not (List.equal Int.equal rest_a rest_b)
       then fail row "octets 1..59 differ between the two frames — expected identical"
     | _ -> fail row "a driven content string is shorter than 1 octet");
    let frame_a_wire = wire_frame samples_a in
    let frame_b_wire = wire_frame samples_b in
    let fcs_a = List.sub frame_a_wire.Dv_xgmii.Tx_decoder.octets ~pos:60 ~len:4 in
    let fcs_b = List.sub frame_b_wire.Dv_xgmii.Tx_decoder.octets ~pos:60 ~len:4 in
    (* Assertion 2, M04-D3: the two FCS quadruples differ. *)
    if List.equal Int.equal fcs_a fcs_b
    then fail row "the two frames' FCS quadruples are equal, expected different";
    (* Assertion 3: each frame's FCS equals its OWN oracle value (P=60, so
       Frame.pad_to_60 is the identity — applied anyway, the same shape
       every other family-D assertion uses). *)
    let expected_a = Dv_xgmii.Frame.fcs (Dv_xgmii.Frame.pad_to_60 content_a) in
    let expected_b = Dv_xgmii.Frame.fcs (Dv_xgmii.Frame.pad_to_60 content_b) in
    if not (List.equal Int.equal fcs_a expected_a)
    then fail row "frame A's wire FCS does not equal Frame.fcs(pad_to_60(frame A))";
    if not (List.equal Int.equal fcs_b expected_b)
    then fail row "frame B's wire FCS does not equal Frame.fcs(pad_to_60(frame B))";
    (* Assertion 4: the two frames' wire octets outside the FCS (indices
       0..59) equal their own content — a difference in the FCS cannot be a
       side effect of a difference the design introduced elsewhere. *)
    let prefix_a = List.take frame_a_wire.Dv_xgmii.Tx_decoder.octets 60 in
    let prefix_b = List.take frame_b_wire.Dv_xgmii.Tx_decoder.octets 60 in
    if not (List.equal Int.equal prefix_a content_a)
    then fail row "frame A's wire octets 0..59 do not equal its own content";
    if not (List.equal Int.equal prefix_b content_b)
    then fail row "frame B's wire octets 0..59 do not equal its own content";
    (* Assertion 5: the standing instruments, on both runs. *)
    assert_instruments_clean t_a ~row;
    assert_instruments_clean t_b ~row
  | other ->
    fail
      row
      (String.concat
         [ "Bench.run_frames [frame_a; frame_b] returned "
         ; Int.to_string (List.length other)
         ; " entries, expected 2"
         ])
;;

let%expect_test
  "M04-D3: two P=60 frames differing only in octet 0 produce different FCS \
   values, each against its own oracle"
  =
  run_d3 ();
  [%expect {||}]
;;

(* ---- U13: M04-D6 ------------------------------------------------------------ *)
(* One run, P = 60, all-zero content — the anti-vacuity member, driven
   BESIDE U11's position-dependent frames and never instead of them
   (WO-0081 §6.4). *)

let hex_digit n =
  if n < 10
  then Char.of_int_exn (Char.to_int '0' + n)
  else Char.of_int_exn (Char.to_int 'A' + n - 10)
;;

let hex_of_int ~digits n =
  String.of_char_list
    (List.init digits ~f:(fun i ->
       let shift = 4 * (digits - 1 - i) in
       hex_digit ((n lsr shift) land 0xF)))
;;

let run_d6 () =
  let row = "M04-D6" in
  let zeros_60 = List.init 60 ~f:(fun (_ : int) -> 0) in
  match run_frames [ zeros_60 ] with
  | [ (content, t, samples) ] ->
    if not (List.equal Int.equal content zeros_60)
    then fail row "the driven content is not the all-zero 60-octet frame";
    (* The oracle's value, computed at run time and never written as a
       literal (§6.0(d), BOUNCE BM12). *)
    let expected_fcs = Dv_xgmii.Frame.fcs zeros_60 in
    (* Assertion 1, M04-D6: the four wire FCS octets equal the oracle's
       value for the all-zero frame. *)
    let frame = wire_frame samples in
    let got_fcs = List.sub frame.Dv_xgmii.Tx_decoder.octets ~pos:60 ~len:4 in
    if not (List.equal Int.equal got_fcs expected_fcs)
    then
      fail
        row
        (String.concat
           [ "wire FCS octets = ["
           ; String.concat ~sep:"; " (List.map got_fcs ~f:Int.to_string)
           ; "], expected Frame.fcs(zeros_60) = ["
           ; String.concat ~sep:"; " (List.map expected_fcs ~f:Int.to_string)
           ; "]"
           ]);
    (* Assertion 2, the anti-vacuity half: the ORACLE's four octets are NOT
       [0; 0; 0; 0] — the kill is a design that emits the CRC SEED
       (0x00000000, SPEC-M04 §6.1 item 1) instead of the finished value
       (trap T5). Computed and asserted, never assumed (§6.4's own
       derivation note). *)
    if List.equal Int.equal expected_fcs [ 0; 0; 0; 0 ]
    then
      fail
        row
        "Frame.fcs zeros_60 = [0;0;0;0] — the row is vacuous by construction against the \
         seed-vs-finished-value defect it exists to catch";
    (* Assertion 3, the print (§6.0(d) rule 3, bar M-18): the ORACLE's four
       octets and their 32-bit value, printed once, deterministic, lane
       order stated — never a design or a decoded-frame value (trap T13).
       [Stdlib.print_string], not the bare name: [open! Base] shadows
       [print_string] with a [@deprecated]-alerted alias to
       [Base.print_string] (this project's build profile promotes that
       alert to a hard error — test/xgmii_rx_64/test_m03_i.ml's own
       precedent, at its own print_string call), and this file's dune
       stanza does not depend on [stdio], so
       [Stdio.Out_channel.output_string] is not available without a dune
       edit this WO does not authorise (§11.2 item 3: the (library …)
       stanza does not change). [Stdlib.print_string] reaches the
       compiler's own un-shadowed primitive directly and needs no new
       library dependency. *)
    let value32 =
      match expected_fcs with
      | [ a; b; c; d ] -> a + (b lsl 8) + (c lsl 16) + (d lsl 24)
      | _ -> fail row "Frame.fcs zeros_60 did not return exactly 4 octets"
    in
    let octets_str =
      String.concat
        ~sep:" "
        (List.map expected_fcs ~f:(fun o -> String.concat [ "0x"; hex_of_int ~digits:2 o ]))
    in
    Stdlib.print_string
      (String.concat
         [ "M04-D6 oracle FCS, Frame.fcs (List.init 60 ~f:(fun _ -> 0)), least \
            significant octet first: "
         ; octets_str
         ; " = 0x"
         ; hex_of_int ~digits:8 value32
         ; "\n"
         ]);
    (* Assertion 4: there is no pad region at P = 60 — stated rather than
       scanned over an empty range. *)
    if List.length content <> 60
    then fail row "the driven content is not 60 octets long, so there is no P=60 to speak of";
    (* Assertion 5: the standing instruments. *)
    assert_instruments_clean t ~row
  | other ->
    fail
      row
      (String.concat
         [ "Bench.run_frames [zeros_60] returned "
         ; Int.to_string (List.length other)
         ; " entries, expected 1"
         ])
;;

let%expect_test
  "M04-D6: the all-zero 60-octet frame's FCS equals the oracle's printed \
   value, and it is not 0x00000000"
  =
  run_d6 ();
  [%expect {| M04-D6 oracle FCS, Frame.fcs (List.init 60 ~f:(fun _ -> 0)), least significant octet first: 0x08 0x89 0x12 0x04 = 0x04128908 |}]
;;
