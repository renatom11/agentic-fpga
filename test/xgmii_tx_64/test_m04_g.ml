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

(** {2 WO-0083 addendum — six of family G's pulse rows ride, over the stall
    schedule and abort law WO-0083 derives}

    The paragraph above, unchanged since WO-0081, said [G1] .. [G8] "assert
    what a PULSE does and need a stall schedule and its own derived oracle,
    neither of which is landed or commissioned this round" — true then, and
    no longer true of the capability that sentence meant: WO-0083 §5.3 builds
    {!Bench.Stall} and {!Bench.run_scheduled}, and WO-0083 §4 derives the
    expected strobe cycle, the [/E/] word's cycle and the truncated octet
    count by hand from SPEC-M04 §9 and §6.1 — [T-3]'s second half, executed.
    Six of the family's eight remaining rows ride on it: [G5] (the earliest
    cycle the condition can hold), [G1]/[G2]/[G8] (a mid-frame underflow of a
    maximum-length frame, driven whole — the pin, the two-cycle separation,
    the resumed tail counted as its own frame), [G3] (four consecutive
    withheld cycles, exactly one pulse), and [G6] (the next frame transmits
    correctly, only the REQ-305 oracle comparison speaking). One further row
    of the family — the faithful implementation read to its own first full
    stop — is held back for one round only, needing nothing built (not named
    further here, per bar M-7); one more is NO-ASSERT and stands, discharged
    already. Family G does NOT complete this round — two rows remain
    outstanding. *)

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

(* ---- WO-0083: the abort word's eight lanes, shared by U22/U23/U24 --------- *)
(* SPEC-M04 §9's shape: /E/ (0xFE) lane 0, /T/ (0xFD) lane 1, /I/ (0x07)
   lanes 2-7, xgmii_txc = 0xFF. Asserted lane by lane (not just the two)
   because xgmii_txc = 0xFF is part of the shape, and the control-field
   check first makes a wrong-lane failure and a wrong-value failure two
   different, readable messages. *)

let assert_abort_word row (wire : Dv_xgmii.Xgmii_word.t) =
  if wire.Dv_xgmii.Xgmii_word.control <> 0xFF
  then
    fail
      row
      (String.concat
         [ "abort word control = "
         ; Int.to_string wire.Dv_xgmii.Xgmii_word.control
         ; ", expected 0xFF (all eight lanes are control characters, SPEC-M04 §9)"
         ]);
  let check lane expected_char name =
    match Dv_xgmii.Xgmii_word.lane wire lane with
    | Dv_xgmii.Xgmii_word.Control v when v = expected_char -> ()
    | Dv_xgmii.Xgmii_word.Control v ->
      fail
        row
        (String.concat
           [ "abort word lane "; Int.to_string lane; " = control "; Int.to_string v
           ; ", expected "; name
           ])
    | Dv_xgmii.Xgmii_word.Data v ->
      fail
        row
        (String.concat
           [ "abort word lane "; Int.to_string lane; " = data "; Int.to_string v
           ; ", expected control "; name
           ])
  in
  check 0 Dv_xgmii.Xgmii_word.error_char "/E/ (0xFE)";
  check 1 Dv_xgmii.Xgmii_word.terminate_char "/T/ (0xFD)";
  List.iter (List.range 2 8) ~f:(fun lane -> check lane Dv_xgmii.Xgmii_word.idle_char "/I/ (0x07)")
;;

(* ---- U22: M04-G5 (WO-0083 §4, §6.2) ---------------------------------------- *)
(* The earliest cycle REQ-206's condition can hold: word >= 1 is §4.4's
   floor, so w = 1 is the earliest legal withholding, and M04-G5's own row
   is stated at exactly that word. One elaboration, run length 32 cycles
   (WO-0083 §10). *)

let run_g5 () =
  let row = "M04-G5" in
  let stall : Stall.t = { frame = 0; word = 1; hold = 1; after = Abandon } in
  let _, t, samples = run_scheduled [ content_octets ~p:60 ] stall in
  let c = first_accepted_cycle samples in
  let r = c + 1 in
  (* §4.2 fact 1: R = S_0 + w - 1 = (C+1) + 1 - 1 = C+1. *)
  let a = r + 2 in
  (* §4.2 fact 3: A = R + 2. *)
  (* Assertion 1: the strobe's exact pin, the frame count, and which frame
     underflowed — one call, obligation 4's both halves and obligation 3
     together. *)
  assert_instruments_scheduled
    t
    ~row
    ~frames:1
    ~underflowed:[ 0 ]
    ~strobe_events:
      [ underflow_event
          ~frame:0
          ~cycle:r
          ~why:
            "SPEC-M04 §9, 'Strobe cycle, pinned': error_underflow pulses on the cycle \
             the word was required and not presented; §4.2 fact 1 derives R = S_0 + w \
             - 1 = C+1 at w=1"
      ];
  (* Assertion 2: the abort word's eight lanes at A = C+3 — all eight, not
     just the two (xgmii_txc = 0xFF is part of §9's shape). *)
  (match List.find samples ~f:(fun (s : sample) -> s.cycle = a) with
   | None -> fail row "no sample at the abort word cycle C+3"
   | Some s -> assert_abort_word row s.wire);
  (* Assertions 3-4: the decoded (aborted) frame — 8 octets on the wire
     (§4.2 fact 4: 8w = 8, NOT 60 and NOT 64 — trap T21), terminate lane 1,
     terminate cycle C+3. *)
  let frame = wire_frame samples in
  let octets = frame.Dv_xgmii.Tx_decoder.octets in
  if List.length octets <> 8
  then
    fail
      row
      (String.concat
         [ "aborted frame wire octet count = "
         ; Int.to_string (List.length octets)
         ; ", expected 8 (§4.2 fact 4: 8w octets, not 60 and not 64 — trap T21)"
         ]);
  let expected = List.take (content_octets ~p:60) 8 in
  if not (List.equal Int.equal octets expected)
  then fail row "aborted frame's wire octets are not the first 8 octets of content_octets ~p:60";
  if not frame.Dv_xgmii.Tx_decoder.underflowed
  then fail row "decoded frame's underflowed field is false, expected true";
  if frame.Dv_xgmii.Tx_decoder.terminate_lane <> 1
  then
    fail
      row
      (String.concat
         [ "terminate lane = "
         ; Int.to_string frame.Dv_xgmii.Tx_decoder.terminate_lane
         ; ", expected 1"
         ]);
  if frame.Dv_xgmii.Tx_decoder.terminate_cycle <> a
  then
    fail
      row
      (String.concat
         [ "terminate cycle = "
         ; Int.to_string frame.Dv_xgmii.Tx_decoder.terminate_cycle
         ; ", expected C+3"
         ]);
  (* Assertion 5: gaps is the empty list, as its own statement — no next
     start character follows an ABANDONED abort, so the decoder's own "one
     entry per completed gap" rule lists none. This is the one place this
     round asserts an absence of gaps, read against U26's [15]. *)
  let gaps = Dv_xgmii.Tx_decoder.gaps (decoder t) in
  if not (List.is_empty gaps)
  then
    fail
      row
      (String.concat
         [ "gaps = ["
         ; String.concat ~sep:"; " (List.map gaps ~f:Int.to_string)
         ; "], expected [] (no next start character — the run ends in Gap, not Idle)"
         ])
(* What this unit does NOT assert (WO-0083 §6.2): no value of tx_tready on
   any cycle (BOUNCE BM11); nothing about the cycles after C+3 beyond the
   strobe-set emptiness assertion 1's exact-event-set check already
   carries; and it does not describe REQ-206 as covered — six rows of the
   family remain outstanding after this round (§9.8). *)
;;

let%expect_test
  "M04-G5: withhold at C + 1, the earliest cycle REQ-206's condition can \
   hold — the strobe there, the /E/ /T/ word at C + 3, and source word \
   0's eight octets on the wire and nothing else"
  =
  run_g5 ();
  [%expect {||}]
;;

(* ---- U23: M04-G1, M04-G2, M04-G8 (WO-0083 §4, §6.3) ------------------------ *)
(* Mid-frame, maximum length, resumed — §9's row driven whole. One
   elaboration, run length 224 cycles (WO-0083 §10). *)

let run_g1_g2_g8 () =
  let row = "M04-G1, M04-G2, M04-G8" in
  let p = 1514 in
  let stall : Stall.t = { frame = 0; word = 95; hold = 1; after = Resume } in
  let _, t, samples = run_scheduled [ content_octets ~p ] stall in
  let c = first_accepted_cycle samples in
  let r = c + 95 in
  let a = r + 2 in
  (* Assertion 1: the strobe's exact pin, two frames, position 0
     underflowed. *)
  assert_instruments_scheduled
    t
    ~row
    ~frames:2
    ~underflowed:[ 0 ]
    ~strobe_events:
      [ underflow_event
          ~frame:0
          ~cycle:r
          ~why:
            "SPEC-M04 §9, 'Strobe cycle, pinned': R = S_0 + w - 1 = (C+1) + 95 - 1 = \
             C+95 (§4.2 fact 1)"
      ];
  let content = content_octets ~p in
  let f0, f1 =
    match wire_frames samples with
    | [ f0; f1 ] -> f0, f1
    | fs ->
      fail
        row
        (String.concat
           [ "wire_frames decoded "; Int.to_string (List.length fs); " frames, expected 2" ])
  in
  (* Assertion 2, M04-G1: the aborted frame's content — length asserted
     first (760, NOT 764 and not any padded figure — §4.2 fact 4: no FCS,
     no pad), then equality against the element's own first 760 octets. *)
  let aborted_octets = f0.Dv_xgmii.Tx_decoder.octets in
  if List.length aborted_octets <> 760
  then
    fail
      row
      (String.concat
         [ "aborted frame wire octet count = "
         ; Int.to_string (List.length aborted_octets)
         ; ", expected 760 (8w, NOT padded, NOT FCS'd — §4.2 fact 4)"
         ]);
  if not (List.equal Int.equal aborted_octets (List.take content 760))
  then
    fail
      row
      "aborted frame's wire octets are not the first 760 octets of the element's own \
       content";
  if not f0.Dv_xgmii.Tx_decoder.underflowed
  then fail row "the aborted frame's underflowed field is false, expected true";
  (* Assertion 3, M04-G2: the separation — read independently from
     [samples] (the strobe cycle from error_underflow high cycles, the
     abort word's cycle from a lane-0 /E/ scan), asserted as two named
     cycles and then as their difference. A design pulsing the strobe at
     the wire consequence (this row's own Kills cell) is one pulse, one
     /E/ word, and INSIDE §0.6's window (§4.2 fact 6) — a bench asserting
     only that both happened passes it; this assertion is why that design
     still fails here. *)
  let observed_strobe_cycles =
    List.filter_map samples ~f:(fun (s : sample) -> if s.underflow then Some s.cycle else None)
  in
  (match observed_strobe_cycles with
   | [ cyc ] ->
     if cyc <> r
     then
       fail
         row
         (String.concat
            [ "error_underflow high at cycle "; Int.to_string cyc; ", expected C+95 = "
            ; Int.to_string r
            ])
   | other ->
     fail
       row
       (String.concat
          [ "expected exactly one cycle with error_underflow high, found "
          ; Int.to_string (List.length other)
          ]));
  let observed_abort_cycle =
    match
      List.find samples ~f:(fun (s : sample) ->
        match Dv_xgmii.Xgmii_word.lane s.wire 0 with
        | Dv_xgmii.Xgmii_word.Control v -> v = Dv_xgmii.Xgmii_word.error_char
        | Dv_xgmii.Xgmii_word.Data _ -> false)
    with
    | Some s -> s.cycle
    | None -> fail row "no cycle in the run carries /E/ in lane 0"
  in
  if observed_abort_cycle <> a
  then
    fail
      row
      (String.concat
         [ "the /E/ word is at cycle "; Int.to_string observed_abort_cycle; ", expected C+97 \
            = "
         ; Int.to_string a
         ]);
  let separation = observed_abort_cycle - r in
  if separation <> 2
  then
    fail
      row
      (String.concat
         [ "the strobe-to-/E/ separation is "
         ; Int.to_string separation
         ; " cycles, expected 2 (§4.2 fact 3 — a design pulsing at the wire consequence \
            is late by this measure, and M04-G2 exists to catch it)"
         ]);
  (* Assertion 4: the abort word's eight lanes at A = C+97. *)
  (match List.find samples ~f:(fun (s : sample) -> s.cycle = a) with
   | None -> fail row "no sample at the abort word cycle C+97"
   | Some s -> assert_abort_word row s.wire);
  (* Assertion 5: the gap — exactly one entry, and it is 15 (§4.2 fact 5:
     t = 1, g = 2, gap = 15). *)
  let gaps = Dv_xgmii.Tx_decoder.gaps (decoder t) in
  if List.length gaps <> 1
  then
    fail
      row
      (String.concat
         [ "Tx_decoder.gaps has "; Int.to_string (List.length gaps); " entries, expected 1" ]);
  (match gaps with
   | [ g ] ->
     if g <> 15
     then fail row (String.concat [ "the one gap = "; Int.to_string g; ", expected 15" ])
   | _ -> fail row "unreachable: gaps length already checked to be 1");
  (* Assertion 6: the tail-frame — S' at C+99, terminate at C+194 lane 6,
     decoded octets equal Frame.with_fcs of the SUFFIX of the element's own
     content beginning at octet 760 (trap T23 — NOT content_octets
     ~p:754), underflowed = false. *)
  if f1.Dv_xgmii.Tx_decoder.start_cycle <> c + 99
  then
    fail
      row
      (String.concat
         [ "tail start cycle = "
         ; Int.to_string f1.Dv_xgmii.Tx_decoder.start_cycle
         ; ", expected C+99"
         ]);
  if f1.Dv_xgmii.Tx_decoder.terminate_cycle <> c + 194
  then
    fail
      row
      (String.concat
         [ "tail terminate cycle = "
         ; Int.to_string f1.Dv_xgmii.Tx_decoder.terminate_cycle
         ; ", expected C+194"
         ]);
  if f1.Dv_xgmii.Tx_decoder.terminate_lane <> 6
  then
    fail
      row
      (String.concat
         [ "tail terminate lane = "
         ; Int.to_string f1.Dv_xgmii.Tx_decoder.terminate_lane
         ; ", expected 6"
         ]);
  if f1.Dv_xgmii.Tx_decoder.underflowed
  then fail row "the tail frame's underflowed field is true, expected false";
  let tail_suffix = List.drop content 760 in
  let expected_tail = Dv_xgmii.Frame.with_fcs tail_suffix in
  if not (List.equal Int.equal f1.Dv_xgmii.Tx_decoder.octets expected_tail)
  then
    fail
      row
      "tail frame's decoded octets do not equal Frame.with_fcs (the suffix of the \
       element's own content beginning at octet 760 — trap T23)";
  (* Assertion 7, M04-G8: (a) two frames, exactly one underflowed at
     position 0 — carried by assertion 1 above. (b) the run's tlast
     acceptances are exactly one, and its cycle is greater than the
     aborted frame's own terminate cycle C+97 — a conservation rule keyed
     on tlast would attribute this ONE acceptance to the tail and count
     one frame where two reached the wire (§4.3, trap T24). *)
  let tlast_acceptances =
    List.filter samples ~f:(fun (s : sample) -> s.accepted && s.offered.tlast)
  in
  match tlast_acceptances with
  | [ s ] ->
    if s.cycle <= a
    then
      fail
        row
        (String.concat
           [ "the run's one tlast acceptance is at cycle "
           ; Int.to_string s.cycle
           ; ", expected > C+97 = "
           ; Int.to_string a
           ; " (the aborted frame's own terminate cycle — this acceptance belongs to the \
              TAIL, §4.3, trap T24)"
           ])
  | other ->
    fail
      row
      (String.concat
         [ "expected exactly one tlast acceptance in the run, found "
         ; Int.to_string (List.length other)
         ])
;;

let%expect_test
  "M04-G1, M04-G2, M04-G8: a mid-frame underflow of a maximum-length \
   frame — one pulse at the pin, the /E/ /T/ word two cycles later, and \
   the resumed tail counted as its own frame"
  =
  run_g1_g2_g8 ();
  [%expect {||}]
;;

(* ---- U24: M04-G3 (WO-0083 §4, §6.4) ----------------------------------------- *)
(* Four consecutive withheld cycles: exactly one pulse. One elaboration,
   run length 229 cycles (WO-0083 §10). *)

let run_g3 () =
  let row = "M04-G3" in
  let p = 1514 in
  let stall : Stall.t = { frame = 0; word = 185; hold = 4; after = Resume } in
  let _, t, samples = run_scheduled [ content_octets ~p ] stall in
  let c = first_accepted_cycle samples in
  let r = c + 185 in
  let a = r + 2 in
  (* Assertion 1: the strobe's exact pin — and THIS SINGLE CALL is the
     whole of the row's "exactly one pulse" claim, because the monitor's
     exact-event-set check (obligation 4) is what makes "no other pulse"
     an assertion rather than an absence. *)
  assert_instruments_scheduled
    t
    ~row
    ~frames:2
    ~underflowed:[ 0 ]
    ~strobe_events:
      [ underflow_event
          ~frame:0
          ~cycle:r
          ~why:
            "SPEC-M04 §9, 'Strobe cycle, pinned': R = S_0 + w - 1 = (C+1) + 185 - 1 = \
             C+185 (§4.2 fact 1); §9 also states 'two underflows on one frame: \
             impossible — the first ends the frame', which is why the three later \
             withheld cycles (C+186..C+188) carry no further event"
      ];
  (* Assertion 2: the named silences — underflow is false at each of the
     three LATER withheld cycles, at each named cycle, with a message
     saying why: no open frame remains to underflow. Assertion 1 already
     covers them (the exact-event-set check); this names them so a
     failure is diagnosable by cycle. *)
  List.iter [ c + 186; c + 187; c + 188 ] ~f:(fun cyc ->
    match List.find samples ~f:(fun (s : sample) -> s.cycle = cyc) with
    | None -> fail row (String.concat [ "no sample at cycle "; Int.to_string cyc ])
    | Some s ->
      if s.underflow
      then
        fail
          row
          (String.concat
             [ "error_underflow is high at cycle "
             ; Int.to_string cyc
             ; " — one of the three later withheld cycles, at which there is no open \
                frame to underflow (SPEC-M04 §9: 'two underflows on one frame: \
                impossible')"
             ]));
  (* Assertion 3: exactly one abort word in the run — the word at A =
     C+187 carries §9's shape, and no other cycle carries an error
     character in any lane. *)
  let error_cycles =
    List.filter_map samples ~f:(fun (s : sample) ->
      let has_error =
        List.exists (List.range 0 8) ~f:(fun lane ->
          match Dv_xgmii.Xgmii_word.lane s.wire lane with
          | Dv_xgmii.Xgmii_word.Control v -> v = Dv_xgmii.Xgmii_word.error_char
          | Dv_xgmii.Xgmii_word.Data _ -> false)
      in
      if has_error then Some s.cycle else None)
  in
  (match error_cycles with
   | [ cyc ] ->
     if cyc <> a
     then
       fail
         row
         (String.concat
            [ "the one cycle carrying an error character is "
            ; Int.to_string cyc
            ; ", expected C+187 = "
            ; Int.to_string a
            ])
   | other ->
     fail
       row
       (String.concat
          [ "expected exactly one cycle carrying an error character in any lane, found "
          ; Int.to_string (List.length other)
          ]));
  (match List.find samples ~f:(fun (s : sample) -> s.cycle = a) with
   | None -> fail row "no sample at the abort word cycle C+187"
   | Some s -> assert_abort_word row s.wire);
  (* Assertion 4: the gap — 23 octets, exactly one completed gap. NOT 15:
     hold = 4 puts the resume past the gap's own last cycle (A+1 = C+188),
     so §4.2 fact 7 branch (b) applies rather than branch (a) — importing
     the neighbouring family-F unit's 15-octet abort gap here would be
     importing another row's figure into a run whose schedule forbids it
     (trap T26). *)
  let gaps = Dv_xgmii.Tx_decoder.gaps (decoder t) in
  if List.length gaps <> 1
  then
    fail
      row
      (String.concat
         [ "Tx_decoder.gaps has "; Int.to_string (List.length gaps); " entries, expected 1" ]);
  (match gaps with
   | [ g ] ->
     if g <> 23
     then
       fail
         row
         (String.concat
            [ "the one gap = "
            ; Int.to_string g
            ; ", expected 23 (§4.2 fact 7 branch (b) — NOT 15, trap T26)"
            ])
   | _ -> fail row "unreachable: gaps length already checked to be 1");
  (* Assertion 5: the tail-frame — S' at C+190, terminate at C+199 lane 0,
     26 pad octets, decoded octets equal Frame.with_fcs (Frame.pad_to_60
     (the suffix beginning at octet 1480)). *)
  let f0, f1 =
    match wire_frames samples with
    | [ f0; f1 ] -> f0, f1
    | fs ->
      fail
        row
        (String.concat
           [ "wire_frames decoded "; Int.to_string (List.length fs); " frames, expected 2" ])
  in
  if not f0.Dv_xgmii.Tx_decoder.underflowed
  then fail row "the aborted frame's underflowed field is false, expected true";
  if f1.Dv_xgmii.Tx_decoder.start_cycle <> c + 190
  then
    fail
      row
      (String.concat
         [ "tail start cycle = "
         ; Int.to_string f1.Dv_xgmii.Tx_decoder.start_cycle
         ; ", expected C+190"
         ]);
  if f1.Dv_xgmii.Tx_decoder.terminate_cycle <> c + 199
  then
    fail
      row
      (String.concat
         [ "tail terminate cycle = "
         ; Int.to_string f1.Dv_xgmii.Tx_decoder.terminate_cycle
         ; ", expected C+199"
         ]);
  if f1.Dv_xgmii.Tx_decoder.terminate_lane <> 0
  then
    fail
      row
      (String.concat
         [ "tail terminate lane = "
         ; Int.to_string f1.Dv_xgmii.Tx_decoder.terminate_lane
         ; ", expected 0"
         ]);
  if f1.Dv_xgmii.Tx_decoder.underflowed
  then fail row "the tail frame's underflowed field is true, expected false";
  let content = content_octets ~p in
  let tail_suffix = List.drop content 1480 in
  if List.length tail_suffix <> 34
  then
    fail
      row
      (String.concat
         [ "tail suffix length = "; Int.to_string (List.length tail_suffix); ", expected 34" ]);
  let expected_tail = Dv_xgmii.Frame.with_fcs (Dv_xgmii.Frame.pad_to_60 tail_suffix) in
  if List.length expected_tail <> 64
  then fail row "unreachable: with_fcs (pad_to_60 (34-octet suffix)) is not 64 octets";
  if not (List.equal Int.equal f1.Dv_xgmii.Tx_decoder.octets expected_tail)
  then
    fail
      row
      "tail frame's decoded octets do not equal Frame.with_fcs (Frame.pad_to_60 (the \
       suffix beginning at octet 1480))"
;;

let%expect_test
  "M04-G3: four consecutive withheld cycles produce exactly one pulse, at \
   the first of them, and nothing at the other three"
  =
  run_g3 ();
  [%expect {||}]
;;

(* ---- U25: M04-G6 (WO-0083 §4, §6.5) ----------------------------------------- *)
(* An underflowed frame followed by a P = 20 frame: REQ-206's "and that the
   next frame transmits correctly". One elaboration, run length 47 cycles
   (WO-0083 §10). *)

let run_g6 () =
  let row = "M04-G6" in
  let stall : Stall.t = { frame = 0; word = 4; hold = 1; after = Abandon } in
  let _, t, samples = run_scheduled [ content_octets ~p:60; content_octets ~p:20 ] stall in
  let c = first_accepted_cycle samples in
  let r = c + 4 in
  (* Assertion 1: the strobe's exact pin, two frames, position 0
     underflowed. *)
  assert_instruments_scheduled
    t
    ~row
    ~frames:2
    ~underflowed:[ 0 ]
    ~strobe_events:
      [ underflow_event
          ~frame:0
          ~cycle:r
          ~why:
            "SPEC-M04 §9, 'Strobe cycle, pinned': R = S_0 + w - 1 = (C+1) + 4 - 1 = C+4 \
             (§4.2 fact 1)"
      ];
  let f0, f1 =
    match wire_frames samples with
    | [ f0; f1 ] -> f0, f1
    | fs ->
      fail
        row
        (String.concat
           [ "wire_frames decoded "; Int.to_string (List.length fs); " frames, expected 2" ])
  in
  (* Assertion 2: frame 1's preamble word at C+8 — raw wire control =
     0x01, data = the eight preamble octets lane 0 first; start_lane
     returns Some 0. The row's own words: "the second frame carries the
     full preamble word". *)
  (match List.find samples ~f:(fun (s : sample) -> s.cycle = c + 8) with
   | None -> fail row "no sample at cycle C+8"
   | Some s ->
     if s.wire.Dv_xgmii.Xgmii_word.control <> 0x01
     then
       fail
         row
         (String.concat
            [ "preamble word control = "
            ; Int.to_string s.wire.Dv_xgmii.Xgmii_word.control
            ; ", expected 1 (bit 0 set, bits 1-7 clear)"
            ]);
     let expected_data = [ 0xFB; 0x55; 0x55; 0x55; 0x55; 0x55; 0x55; 0xD5 ] in
     let got_data = Array.to_list s.wire.Dv_xgmii.Xgmii_word.data in
     if not (List.equal Int.equal got_data expected_data)
     then fail row "preamble word data does not match [0xFB; 0x55 x6; 0xD5], lane 0 first";
     match Dv_xgmii.Xgmii_word.start_lane s.wire with
     | Some 0 -> ()
     | Some lane ->
       fail
         row
         (String.concat [ "start character at lane "; Int.to_string lane; ", expected 0" ])
     | None -> fail row "no start character at C+8");
  (* Assertion 3: frame 1's content, the row's central claim — 64 octets,
     20 of content, 40 of pad, four of FCS, the pad INSIDE the FCS
     computation (trap T9). A design whose CRC register is not re-seeded
     after an abort produces a frame with the right length, the right pad
     count and the right terminate lane, and ONLY this comparison
     speaks. *)
  let expected_frame1 =
    Dv_xgmii.Frame.with_fcs (Dv_xgmii.Frame.pad_to_60 (content_octets ~p:20))
  in
  if List.length f1.Dv_xgmii.Tx_decoder.octets <> 64
  then
    fail
      row
      (String.concat
         [ "frame 1 wire octet count = "
         ; Int.to_string (List.length f1.Dv_xgmii.Tx_decoder.octets)
         ; ", expected 64"
         ]);
  if not (List.equal Int.equal f1.Dv_xgmii.Tx_decoder.octets expected_frame1)
  then
    fail
      row
      "frame 1's decoded octets do not equal Frame.with_fcs (Frame.pad_to_60 \
       (content_octets ~p:20)) — a design whose CRC register is not re-seeded after an \
       abort would still pass the length and pad count and fail only here";
  if f1.Dv_xgmii.Tx_decoder.underflowed
  then fail row "frame 1's underflowed field is true, expected false";
  (* Assertion 4: frame 1's terminate character at C+17, lane 0. *)
  if f1.Dv_xgmii.Tx_decoder.terminate_cycle <> c + 17
  then
    fail
      row
      (String.concat
         [ "frame 1 terminate cycle = "
         ; Int.to_string f1.Dv_xgmii.Tx_decoder.terminate_cycle
         ; ", expected C+17"
         ]);
  if f1.Dv_xgmii.Tx_decoder.terminate_lane <> 0
  then
    fail
      row
      (String.concat
         [ "frame 1 terminate lane = "
         ; Int.to_string f1.Dv_xgmii.Tx_decoder.terminate_lane
         ; ", expected 0"
         ]);
  (* Assertion 5: the aborted frame's 32 octets, length first, no FCS, no
     pad (§4.2 fact 4). *)
  if not f0.Dv_xgmii.Tx_decoder.underflowed
  then fail row "the aborted frame's underflowed field is false, expected true";
  let aborted_octets = f0.Dv_xgmii.Tx_decoder.octets in
  if List.length aborted_octets <> 32
  then
    fail
      row
      (String.concat
         [ "aborted frame wire octet count = "
         ; Int.to_string (List.length aborted_octets)
         ; ", expected 32 (8w, not padded, no FCS — §4.2 fact 4)"
         ]);
  if not (List.equal Int.equal aborted_octets (List.take (content_octets ~p:60) 32))
  then
    fail row "aborted frame's wire octets are not the first 32 octets of content_octets ~p:60"
;;

let%expect_test
  "M04-G6: an underflowed frame followed by a P = 20 frame — the next \
   frame transmits with a correctly re-seeded FCS"
  =
  run_g6 ();
  [%expect {||}]
;;
