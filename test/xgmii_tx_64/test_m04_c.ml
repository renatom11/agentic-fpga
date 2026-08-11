(** Family C — padding (REQ-203), and the pad's CRC coverage (REQ-202 at
    REQ-203's stimulus, M04-C3 only — WO-0080 §1.3). Five units: U6
    (M04-C1, M04-C6), U7 (M04-C2), U8 (M04-C3), U9 (M04-C4), U10 (M04-C5),
    in that order (WO-0080 §16.1). *)

open! Base
open Bench

let fail row msg = failwith (String.concat [ row; ": "; msg ])

(* ---- U6: M04-C1, M04-C6 -------------------------------------------------- *)
(* One run, P = 20 (WO-0080 §6.6). *)

let run_c1_c6 () =
  let row = "M04-C1, M04-C6" in
  let p = 20 in
  match run_lengths [ p ] with
  | [ (_, t, samples) ] ->
    let frame = wire_frame samples in
    let octets = frame.Dv_xgmii.Tx_decoder.octets in
    (* Assertions 1 and 4: 60 octets before the first FCS octet, i.e. 64
       octets DA through FCS. Stated as the total count, which is the
       single most likely arithmetic error in this module to catch — a
       design padding to 64 rather than 60 would also read 64 here were it
       not for assertion 2's own scan of the pad region. *)
    if List.length octets <> 64
    then
      fail
        row
        (String.concat
           [ "wire octet count = "; Int.to_string (List.length octets); ", expected 64" ]);
    (* Assertion 3: wire octets 0..19 = content 0..19. *)
    let content = content_octets ~p in
    let prefix = List.take octets 20 in
    if not (List.equal Int.equal prefix content)
    then fail row "wire octets 0..19 do not equal the source content";
    (* Assertion 2: wire octets 20..59 are all 0x00, 40 of them — the check
       that actually distinguishes "padded to 60" from "padded to 64" or
       "padded after the FCS", which the total-count check alone cannot. *)
    let pad_region = List.sub octets ~pos:20 ~len:40 in
    if not (List.for_all pad_region ~f:(fun o -> o = 0))
    then fail row "wire octets 20..59 are not all 0x00";
    (* M04-C6 (NO-ASSERT): the standing decoder's own REQ-203 verdict — a
       frame below 64 octets DA through FCS — is a NECESSARY condition only
       (Tx_decoder.mli's own words: "which octets are pad is not decidable
       from the wire alone"). Assertions 1-3 above, which know the source
       frame, are what discharge REQ-203; assert_instruments_clean below
       (which reads the standing decoder's is_clean) is never reported as
       REQ-203 coverage in this unit's own name or in the Return log. *)
    assert_instruments_clean t ~row
  | other ->
    fail
      "M04-C1, M04-C6"
      (String.concat
         [ "Bench.run_lengths [20] returned "
         ; Int.to_string (List.length other)
         ; " entries, expected 1"
         ])
;;

let%expect_test
  "M04-C1: sixty octets before the FCS, zero pad; M04-C6: the decoder's \
   REQ-203 verdict is NOT reported as coverage"
  =
  run_c1_c6 ();
  [%expect {||}]
;;

(* ---- U7: M04-C2 ----------------------------------------------------------- *)
(* Four runs, P in {1, 59, 60, 61} — REQ-203's "below 60" predicate, both
   directions (WO-0080 §6.7). *)

let run_c2 () =
  let ps = [ 1; 59; 60; 61 ] in
  let runs = run_lengths ps in
  List.iter runs ~f:(fun (p, t, samples) ->
    let row = String.concat [ "M04-C2 (P="; Int.to_string p; ")" ] in
    let f = Int.max p 60 + 4 in
    let pad = Int.max 0 (60 - p) in
    let frame = wire_frame samples in
    let octets = frame.Dv_xgmii.Tx_decoder.octets in
    if List.length octets <> f
    then
      fail
        row
        (String.concat
           [ "wire octet count = "; Int.to_string (List.length octets); ", expected F = "
           ; Int.to_string f
           ]);
    let content = content_octets ~p in
    let prefix = List.take octets p in
    if not (List.equal Int.equal prefix content)
    then fail row "wire octets 0..P-1 do not equal the source content";
    if pad > 0
    then (
      let pad_region = List.sub octets ~pos:p ~len:pad in
      if not (List.for_all pad_region ~f:(fun o -> o = 0))
      then
        fail
          row
          (String.concat
             [ "pad region ("; Int.to_string pad; " octets from index "; Int.to_string p
             ; ") is not all 0x00"
             ]));
    assert_instruments_clean t ~row)
;;

let%expect_test
  "M04-C2: the below-60 predicate at P in {1, 59, 60, 61} — pad counts 59, \
   1, 0, 0 and F = 64, 64, 64, 65, both directions of the off-by-one"
  =
  run_c2 ();
  [%expect {||}]
;;

(* ---- U8: M04-C3 ------------------------------------------------------------ *)
(* One run, P = 20 — the pad's CRC coverage (WO-0080 §6.8). *)

let run_c3 () =
  let row = "M04-C3" in
  let p = 20 in
  match run_lengths [ p ] with
  | [ (_, t, samples) ] ->
    let content = content_octets ~p in
    let padded = Dv_xgmii.Frame.pad_to_60 content in
    let expected = Dv_xgmii.Frame.fcs padded in
    let unpadded = Dv_xgmii.Frame.fcs content in
    (* Assertion 0 (construction-time, before either is compared against the
       wire): expected <> unpadded, or the row is vacuous by construction —
       reported, not silently proceeded past. *)
    if List.equal Int.equal expected unpadded
    then
      fail
        row
        "construction-time check failed: Frame.fcs of the padded and unpadded content \
         agree, which makes this row vacuous by construction — reported per WO-0080 \
         §6.8, not proceeded past";
    let c = first_accepted_cycle samples in
    let fcs_cycle = c + 9 in
    (match List.find samples ~f:(fun (s : sample) -> s.cycle = fcs_cycle) with
     | None -> fail row "no sample at cycle C+9"
     | Some s ->
       let lanes_4_7 =
         List.init 4 ~f:(fun k ->
           match Dv_xgmii.Xgmii_word.lane s.wire (k + 4) with
           | Dv_xgmii.Xgmii_word.Data d -> d
           | Dv_xgmii.Xgmii_word.Control d -> d)
       in
       (* Assertion 1: the wire FCS equals the padded oracle. *)
       if not (List.equal Int.equal lanes_4_7 expected)
       then
         fail row "wire octets (lanes 4-7 of C+9) do not equal Frame.fcs(pad_to_60(content))";
       (* Assertion 2: and does NOT equal the unpadded oracle — both halves
          are required; the positive comparison alone is satisfied by a
          design that pads correctly, and this is what proves the row could
          have failed. *)
       if List.equal Int.equal lanes_4_7 unpadded
       then fail row "wire octets equal the UNPADDED oracle — the pad is not covered by the CRC");
    assert_instruments_clean t ~row
  | other ->
    fail
      "M04-C3"
      (String.concat
         [ "Bench.run_lengths [20] returned "
         ; Int.to_string (List.length other)
         ; " entries, expected 1"
         ])
;;

let%expect_test
  "M04-C3: the four wire FCS octets equal the oracle over the padded 60 \
   octets and do not equal it over the unpadded 20 (REQ-202's pad-coverage \
   clause at REQ-203's stimulus — not REQ-202 coverage, WO-0080 §1.3)"
  =
  run_c3 ();
  [%expect {||}]
;;

(* ---- U9: M04-C4 -------------------------------------------------------------- *)
(* One run, P = 20, poison 0xA5 (WO-0080 §6.9 — the row obligation 7 exists
   for). *)

let run_c4 () =
  let row = "M04-C4" in
  let p = 20 in
  match run_lengths [ p ] with
  | [ (_, t, samples) ] ->
    let frame = wire_frame samples in
    let octets = frame.Dv_xgmii.Tx_decoder.octets in
    let f = 64 in
    (* Assertion 1: the poison value appears nowhere among wire octets
       0..F-5 — the four FCS octets (§6.0(c)) are excluded, since they are a
       computed value that may legitimately equal the poison byte. *)
    let scan = List.sub octets ~pos:0 ~len:(f - 4) in
    if List.exists scan ~f:(fun o -> o = poison)
    then fail row "poison 0xA5 present among wire octets 0..F-5";
    (* Assertion 3: wire octets 0..19 = content 0..19. *)
    let content = content_octets ~p in
    let prefix = List.take octets 20 in
    if not (List.equal Int.equal prefix content)
    then fail row "wire octets 0..19 do not equal the source content";
    (* Assertion 2: wire octets 20..59 are all 0x00 — under a zero-filled
       stimulus this is byte-identical to a design that transmits its final
       word whole; obligation 7's own poisoned filler is the entire
       instrument that makes this check non-vacuous. *)
    let pad_region = List.sub octets ~pos:20 ~len:40 in
    if not (List.for_all pad_region ~f:(fun o -> o = 0))
    then fail row "wire octets 20..59 are not all 0x00";
    assert_instruments_clean t ~row
  | other ->
    fail
      "M04-C4"
      (String.concat
         [ "Bench.run_lengths [20] returned "
         ; Int.to_string (List.length other)
         ; " entries, expected 1"
         ])
;;

let%expect_test
  "M04-C4: poison 0xA5 at the tlast word's tkeep-0 positions appears \
   nowhere on the wire, and the pad region is all 0x00"
  =
  run_c4 ();
  [%expect {||}]
;;

(* ---- U10: M04-C5 ---------------------------------------------------------------- *)
(* Three runs, P in {1, 20, 59} — one, three and eight source words, all
   padding to the same 60 (WO-0080 §6.10 — the pad counter's key). *)

let run_c5 () =
  let ps = [ 1; 20; 59 ] in
  let runs = run_lengths ps in
  List.iter runs ~f:(fun (p, t, samples) ->
    let row = String.concat [ "M04-C5 (P="; Int.to_string p; ")" ] in
    (* Assert W — the accepted SOURCE WORD count — separately from the pad
       octet count below, since the row's whole point is that the two are
       different quantities: a pad counter keyed on the wrong one passes
       every single-length bench. *)
    let w_expected = (p + 7) / 8 in
    let w_observed = List.count samples ~f:(fun (s : sample) -> s.accepted) in
    if w_observed <> w_expected
    then
      fail
        row
        (String.concat
           [ "accepted source word count W = "
           ; Int.to_string w_observed
           ; ", expected ceil(P/8) = "
           ; Int.to_string w_expected
           ]);
    let frame = wire_frame samples in
    if frame.Dv_xgmii.Tx_decoder.terminate_lane <> 0
    then
      fail
        row
        (String.concat
           [ "terminate lane = "
           ; Int.to_string frame.Dv_xgmii.Tx_decoder.terminate_lane
           ; ", expected 0"
           ]);
    let octets = frame.Dv_xgmii.Tx_decoder.octets in
    if List.length octets <> 64
    then fail row (String.concat [ "wire octet count = "; Int.to_string (List.length octets); ", expected F = 64" ]);
    let content = content_octets ~p in
    let prefix = List.take octets p in
    if not (List.equal Int.equal prefix content)
    then fail row "wire octets 0..P-1 do not equal the source content";
    let pad = 60 - p in
    let pad_region = List.sub octets ~pos:p ~len:pad in
    if not (List.for_all pad_region ~f:(fun o -> o = 0))
    then
      fail
        row
        (String.concat
           [ "pad region ("; Int.to_string pad; " octets from index "; Int.to_string p
           ; ") is not all 0x00"
           ]);
    assert_instruments_clean t ~row)
;;

let%expect_test
  "M04-C5: P in {1, 20, 59} — one, three and eight source words, all \
   padding to the same 60; W and the pad octet count both asserted, so the \
   row makes its own word-count-vs-octet-count distinction"
  =
  run_c5 ();
  [%expect {||}]
;;
