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

(** {2 WO-0082 addendum — M04-G10 rides after all, and not via family G's
    own machinery}

    The paragraph above, unchanged since WO-0081, said [G10] "needs a
    stall schedule and its own derived oracle, neither of which is landed
    or commissioned this round" — true then, and still true of the
    capability that sentence meant: no stall schedule exists yet, and none
    is commissioned by WO-0082 either (BOUNCE BM5 still applies). What
    changed is that [M04-G10]'s own stimulus — the next frame's first word
    presented and accepted at [C + 8] — needs no stall schedule at all: a
    CONTINUOUS multi-frame source ({!Bench.run_stream}, WO-0082 §5.3)
    offers the next frame's word 0 on the cycle after the previous frame's
    last word was accepted, which lands it at [C + 8] by construction
    (SPEC-M04 §7's C-16 consequence 2). [BUG-0004]'s routes 2 and 3 are
    therefore reachable with no schedule at all, which is a fact about the
    routes and not a convenience (WO-0082 §5.4). [G1] .. [G8] remain
    outstanding for exactly the reason the paragraph above states — they
    assert what a PULSE does, over a stall schedule that still does not
    exist. *)

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

(* ---- U21: M04-G10 (WO-0082 §5, §6.6) --------------------------------------- *)
(* Four runs: the pre-loaded handover at C+8, shapes (a) W=1 (BUG-0004
   route 2) and (b) W=2 (route 3, fully pre-loaded) — BUG-0004's routes 2
   and 3, measured for the first time in either design. Driven through
   {!Bench.run_stream}, the multi-frame continuous presenter WO-0082 §5.3
   builds and §5.4 explains is exactly the half M04-G10 needs: a
   CONTINUOUS source presents frame B's word 0 on the cycle after frame
   A's last word was accepted, which lands it at C+8 by construction
   (SPEC-M04 §7's C-16 consequence 2) — no release schedule is built or
   needed (§5.4). Both ends of each shape are driven for the reason
   M04-G9's own round drove P in {1, 8}: within a shape the members differ
   in exactly the thing that made BUG-0004 reachable — how much of the
   accepting word is frame. Four elaborations, run length 51 each. *)

type g10_run =
  { shape : string
  ; b : int
  ; accepted_offsets : int list
  ; strobe_cycle_off : int
  ; route : int
  }

(* WO-0082 §6.6's own derived-cycle table, transcribed literally. *)
let g10_runs =
  [ { shape = "(a)"; b = 1; accepted_offsets = [ 0; 1; 2; 3; 4; 5; 6; 7; 8 ]; strobe_cycle_off = 12; route = 2 }
  ; { shape = "(a)"; b = 8; accepted_offsets = [ 0; 1; 2; 3; 4; 5; 6; 7; 8 ]; strobe_cycle_off = 12; route = 2 }
  ; { shape = "(b)"
    ; b = 9
    ; accepted_offsets = [ 0; 1; 2; 3; 4; 5; 6; 7; 8; 11 ]
    ; strobe_cycle_off = 13
    ; route = 3
    }
  ; { shape = "(b)"
    ; b = 16
    ; accepted_offsets = [ 0; 1; 2; 3; 4; 5; 6; 7; 8; 11 ]
    ; strobe_cycle_off = 13
    ; route = 3
    }
  ]
;;

let run_g10_one (r : g10_run) =
  let row = String.concat [ "M04-G10 "; r.shape; " (B="; Int.to_string r.b; ")" ] in
  let _, t, samples = run_stream [ content_octets ~p:60; content_octets ~p:r.b ] in
  let c = first_accepted_cycle samples in
  (* Assertion 1: THE ROUTE'S OWN PRECONDITION, FIRST AND BY ITSELF. If
     this fails, the run is not route 2 or route 3 and no later assertion
     in this unit is evidence about anything (class D3c, trap T14). *)
  let accepted_cycles =
    List.filter_map samples ~f:(fun (s : sample) -> if s.accepted then Some s.cycle else None)
  in
  let expected_accepted = List.map r.accepted_offsets ~f:(fun off -> c + off) in
  if not (List.equal Int.equal accepted_cycles expected_accepted)
  then
    fail
      row
      (String.concat
         [ "route precondition failed — accepted cycles were ["
         ; String.concat ~sep:"; " (List.map accepted_cycles ~f:Int.to_string)
         ; "], expected exactly ["
         ; String.concat ~sep:"; " (List.map expected_accepted ~f:Int.to_string)
         ; "] — this run is NOT route "
         ; Int.to_string r.route
         ; " and no assertion after this one in this unit is evidence about anything (class \
            D3c, trap T14)"
         ]);
  (* Assertion 2: the named silence, at the named cycle route 2/3's own
     derivation strobed at — THEN the whole-run silence. *)
  let strobe_cycle = c + r.strobe_cycle_off in
  (match List.find samples ~f:(fun (s : sample) -> s.cycle = strobe_cycle) with
   | None ->
     fail row (String.concat [ "no sample at the named cycle C+"; Int.to_string r.strobe_cycle_off ])
   | Some s ->
     if s.underflow
     then
       fail
         row
         (String.concat
            [ "error_underflow is high at cycle C+"
            ; Int.to_string r.strobe_cycle_off
            ; " — the cycle route "
            ; Int.to_string r.route
            ; "'s unfixed design strobed at, by BUG-0004 §9.3's own derivation"
            ]));
  assert_instruments_clean_n t ~row ~frames:2;
  (* Assertion 3: S_B = C+12, the start character where SPEC-M04 §7's
     C-16 consequence 3 puts it — not moved by the early acceptance. *)
  let f_a, f_b =
    match wire_frames samples with
    | [ f_a; f_b ] -> f_a, f_b
    | fs ->
      fail
        row
        (String.concat
           [ "wire_frames decoded "; Int.to_string (List.length fs); " frames, expected 2" ])
  in
  if f_b.Dv_xgmii.Tx_decoder.start_cycle <> c + 12
  then
    fail
      row
      (String.concat
         [ "S_B = "
         ; Int.to_string f_b.Dv_xgmii.Tx_decoder.start_cycle
         ; ", expected C+12 (SPEC-M04 §7's C-16 consequence 3 — unmoved by the early \
            acceptance)"
         ]);
  (* Assertion 4: both frames intact. Frame B is r.b octets of content and
     60 - r.b pad octets — 59 pad octets at B=1 — and the pad is inside
     the FCS computation (trap T9: Frame.pad_to_60 composed inside
     Frame.with_fcs is what makes this a single whole-list comparison
     rather than a separate pad-count scan). *)
  if f_a.Dv_xgmii.Tx_decoder.terminate_cycle <> c + 10
  then
    fail
      row
      (String.concat
         [ "frame A terminate cycle = "
         ; Int.to_string f_a.Dv_xgmii.Tx_decoder.terminate_cycle
         ; ", expected C+10"
         ]);
  if f_a.Dv_xgmii.Tx_decoder.terminate_lane <> 0
  then
    fail
      row
      (String.concat
         [ "frame A terminate lane = "
         ; Int.to_string f_a.Dv_xgmii.Tx_decoder.terminate_lane
         ; ", expected 0"
         ]);
  let expected_a = Dv_xgmii.Frame.with_fcs (Dv_xgmii.Frame.pad_to_60 (content_octets ~p:60)) in
  if not (List.equal Int.equal f_a.Dv_xgmii.Tx_decoder.octets expected_a)
  then
    fail
      row
      "frame A's decoded octets do not equal Frame.with_fcs (Frame.pad_to_60 (content_octets \
       ~p:60))";
  if f_b.Dv_xgmii.Tx_decoder.terminate_cycle <> c + 21
  then
    fail
      row
      (String.concat
         [ "frame B terminate cycle = "
         ; Int.to_string f_b.Dv_xgmii.Tx_decoder.terminate_cycle
         ; ", expected C+21"
         ]);
  if f_b.Dv_xgmii.Tx_decoder.terminate_lane <> 0
  then
    fail
      row
      (String.concat
         [ "frame B terminate lane = "
         ; Int.to_string f_b.Dv_xgmii.Tx_decoder.terminate_lane
         ; ", expected 0"
         ]);
  let expected_b = Dv_xgmii.Frame.with_fcs (Dv_xgmii.Frame.pad_to_60 (content_octets ~p:r.b)) in
  if not (List.equal Int.equal f_b.Dv_xgmii.Tx_decoder.octets expected_b)
  then
    fail
      row
      "frame B's decoded octets do not equal Frame.with_fcs (Frame.pad_to_60 (content_octets \
       ~p:B))"
  (* Assertion 5 (conservation — two frames begun, two on the wire, neither
     underflowed) is carried by assertion 2's assert_instruments_clean_n
     call above.

     What this unit does NOT assert (WO-0082 §6.6): no value of tx_tready
     on any cycle (BOUNCE BM11 — the bench exposes none; asserting an
     ACCEPTANCE, assertion 1 above, is asserting the handshake's outcome,
     which is this row's own stimulus); the transmit cycle of the C+8 word
     (C+13) is consequence 2's other half and belongs to the
     uncommissioned family-H row that owns it — not asserted and not named
     here (BOUNCE BM8, bar M-7); the alternative handover at C+11 is not
     driven at all — no release schedule exists (§5.4). *)
;;

let run_g10 () = List.iter g10_runs ~f:run_g10_one

let%expect_test
  "M04-G10: the pre-loaded handover at C+8, shapes (a) W=1 and (b) W=2 — \
   error_underflow silent on every cycle, both frames intact"
  =
  run_g10 ();
  [%expect {||}]
;;
