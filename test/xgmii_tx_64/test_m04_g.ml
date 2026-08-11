(** Family G — underflow: REQ-206 (WO-0081 §1.4, §2, §6.7, §9.4). One unit,
    U16 (M04-G9), and it is deliberately the only family-G row this file
    carries: [G1] .. [G8] and [G10] assert what a PULSE does and need a
    stall schedule and its own derived oracle, neither of which is landed
    or commissioned this round (WO-0081 §1.2's scope rule, BOUNCE BM5).
    [M04-G9] asserts a SILENCE on a clean single-word frame nobody stalls,
    which needs no family-G machinery at all — only family D's own FCS
    instrument, landed in this same round, which is why this row rides
    THIS round and not before it (WO-0081 §1.4 item 2).

    {2 What this unit may NOT claim (WO-0081 §1.4, §9.4(3), BOUNCE BM8)}

    This unit does not discharge the neighbouring family-G row that
    additionally asserts [tx_tready] = 1 at the post-[tlast] cycle — this
    round asserts no value of [tx_tready] anywhere, BOUNCE BM11 — nor the
    row that needs the pre-loaded-handover machinery not yet mountable at
    this commit (both left unnamed here on purpose: bar M-7 and BOUNCE BM8
    forbid naming either row, even to disclaim it), and it does not make
    REQ-206 "covered": the attack plan bars an [SO-] from claiming that
    while the neighbouring row is neither measured nor declared a gap, and
    that bar is not this round's to lift. Family G's own
    round appends further units to THIS file; putting [M04-G9] anywhere
    else would put a family-G row where no family-G round would look for
    it (WO-0081 §11.1). *)

open! Base
open Bench

let fail row msg = failwith (String.concat [ row; ": "; msg ])

(* ---- U16: M04-G9 ---------------------------------------------------------- *)
(* Two runs, P in {1, 8} -- W = 1 at both, the one source word carrying the
   frame's first octet and its tlast. Both ends of the single-word class are
   driven because they differ in exactly the thing that made BUG-0004
   reachable: how much of the accepting word is frame (WO-0081 §6.7). *)

let run_g9 () =
  let row = "M04-G9" in
  let ps = [ 1; 8 ] in
  let runs = run_lengths ps in
  List.iter runs ~f:(fun (p, t, samples) ->
    let row = String.concat [ row; " (P="; Int.to_string p; ")" ] in
    (* Assertions 1 and 8 together, one call: the row's own LOAD-BEARING
       half (assertion 1) is the strobe -- assert_instruments_clean asserts
       both that high_cycles "error_underflow" = 0 over the whole run AND
       that the strobe monitor's own exact expected-event set is empty
       (obligation 4's own exact-set discipline). It is ALSO "the standing
       instruments" (assertion 8), every other unit's own final item — the
       two are the SAME call and are not repeated. Called here, first, and
       named as THIS ROW'S assertion rather than a background check
       (WO-0081 §6.7 assertions 1 and 8). This is the row BUG-0004's fix has
       been resting on without: a MAJOR design defect at exactly this
       shape, found by a standing instrument on stimuli commissioned for a
       different purpose, closed before this row ever existed to discharge
       it (WO-0081 §1.4 item 3). *)
    assert_instruments_clean t ~row;
    (* Assertion 2: acceptance -- exactly one accepted cycle, at C;
       P-ACCEPT holds trivially (already enforced inside
       Bench.run_lengths). Nothing is asserted about tx_tready at C+1, the
       post-tlast cycle SPEC-M04 §7's C-16 consequence authorises as
       meaning nothing at all (BOUNCE BM11 -- this bench never even
       exposes a per-cycle tx_tready value to a unit; only [accepted],
       which already folds tvalid and tready together). *)
    match List.filter samples ~f:(fun (s : sample) -> s.accepted) with
    | [ s ] ->
      let c = s.cycle in
      (* Assertion 3: the frame transmits intact -- the preamble, one start
         character, lane 0, cycle C+1. *)
      (match List.find samples ~f:(fun (s : sample) -> s.cycle = c + 1) with
       | None -> fail row "no sample at C+1"
       | Some s ->
         (match Dv_xgmii.Xgmii_word.start_lane s.wire with
          | Some 0 -> ()
          | Some lane ->
            fail
              row
              (String.concat [ "start character at lane "; Int.to_string lane; ", expected 0" ])
          | None -> fail row "no start character at C+1"));
      let frame = wire_frame samples in
      let octets = frame.Dv_xgmii.Tx_decoder.octets in
      (* Assertion 4: its content -- wire octets 0..P-1 equal content_octets ~p. *)
      let content = content_octets ~p in
      let prefix = List.take octets p in
      if not (List.equal Int.equal prefix content)
      then fail row "wire octets 0..P-1 do not equal the source content";
      (* Assertion 5: its pad -- wire octets P..59 are all 0x00. *)
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
      (* Assertion 6: its FCS -- family D's own instrument, which is why
         this row rides THIS round (WO-0081 §1.4). *)
      let expected_fcs = Dv_xgmii.Frame.fcs (Dv_xgmii.Frame.pad_to_60 content) in
      let got_fcs = List.sub octets ~pos:60 ~len:4 in
      if not (List.equal Int.equal got_fcs expected_fcs)
      then fail row "wire octets 60-63 do not equal Frame.fcs(pad_to_60(content))";
      (* Assertion 7: its terminate character -- octet index F=64, lane 0,
         cycle C+10. *)
      if List.length octets <> 64
      then
        fail
          row
          (String.concat
             [ "wire octet count = "; Int.to_string (List.length octets); ", expected F = 64" ]);
      if frame.Dv_xgmii.Tx_decoder.terminate_cycle <> c + 10
      then
        fail
          row
          (String.concat
             [ "terminate cycle = "; Int.to_string frame.Dv_xgmii.Tx_decoder.terminate_cycle
             ; ", expected C+10"
             ]);
      if frame.Dv_xgmii.Tx_decoder.terminate_lane <> 0
      then
        fail
          row
          (String.concat
             [ "terminate lane = "; Int.to_string frame.Dv_xgmii.Tx_decoder.terminate_lane
             ; ", expected 0"
             ])
    | other ->
      fail
        row
        (String.concat
           [ "expected exactly one accepted cycle, found "; Int.to_string (List.length other) ]))
;;

let%expect_test
  "M04-G9: a single-word frame transmits intact and error_underflow is 0 \
   on every cycle"
  =
  run_g9 ();
  [%expect {||}]
;;
