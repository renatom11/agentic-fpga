(** Family F — the first gap this programme has ever measured at a
    transmit port (WO-0082 §0, §1.3). Two units: U17 (M04-F1), U18
    (M04-F2). Derived from SPEC-M04 §6.1's inter-frame-gap paragraph
    ([g = ceil((cfg_ifg + t)/8)], actual gap [8g - t], "gaps are only ever
    rounded up"), §7's C-16 bullet, and requirements.md §0.3 (the gap
    convention, and the *Against deficit idle count* paragraph). Every run
    here is driven through {!Bench.run_stream}, WO-0082's own capability —
    the standing wire decoder has judged REQ-204 since the first M04 run,
    but never once seen a gap: {!Dv_xgmii.Tx_decoder.gaps} is "octets from
    each terminate character inclusive to the next start character
    exclusive, one per completed gap", and a one-frame run completes none.

    {2 M04-F5 — NO-ASSERT, round-wide (WO-0082 §1.3, §6.2)}

    Stated here because both units below share the discharge: no unit in
    this file asserts an average gap; no unit asserts a gap of exactly 12
    octets at [t = 0]; no unit imports requirements.md §0.3's RECEIVE-side
    spacing (a DIC-capable partner alternating lane-0 and lane-4 starts at
    10-and-11-cycle spacing). §0.3 describes two opposite behaviours one
    paragraph apart, and the receive one is the one this programme has
    been living in for nine campaigns — the mis-import is the default this
    round guards against, not a hypothetical. The gap at [t = 0] is
    SIXTEEN octets (REQ-204's own verification figure); 12 is [cfg_ifg],
    the MINIMUM, not the gap.

    {2 What this file does NOT claim (WO-0082 §1.4, §9.8, BOUNCE BM8)}

    Neither unit asserts [start_spacings] as REQ-209's sustained cadence
    claim (that belongs to an uncommissioned family-I row); neither names
    nor drives the [cfg_ifg] parameterisation, the abort gap, or the
    10 000-frame DIC sweep that three of this family's other rows need —
    all three need capabilities this round does not build (WO-0082 §1.4),
    and none of those rows is named here even to disclaim them, per bar
    M-7. *)

(** {2 WO-0083 addendum — M04-F6, the gap after an abort}

    The abort gap named above as needing a capability this round does not
    build now has one: WO-0083 §5.3 builds {!Bench.Stall} and
    {!Bench.run_scheduled}, and §4.2 fact 5 derives the gap after an abort —
    [t = 1] (the terminate character is the [/T/] at lane 1, never the
    [/E/] at lane 0), [g = 2], the actual gap **15** octets. **Corrected
    2026-08-22 (WO-0084-S1, WO-0085; see `AP-xgmii_tx_64.md`'s corrected
    `M04-F6` row): the defect this row's exact [= 15] assertion kills is a
    WHOLE-WORD error** — a recorded gap of **7** or **23** rather than 15 —
    **never a one-octet error**. Every gap this decoder can record after an
    abort is [8k - 1] octets, i.e. [≡ 7 (mod 8)] (7, 15, 23, and so on), and
    **16 is not a value this decoder can ever produce**. The [/E/]-vs-[/T/] design
    (the sealed `IC-10`) is **invisible** at this row's own [cfg_ifg = 12] —
    both readings place the next start character in the same word and the
    decoder records 15 either way — and its own coverage is `M04-F7`'s,
    swept over [cfg_ifg ∈ {12, 16, 24}] where the two readings separate by a
    whole word. The observable here is the EXACT placement and never the
    minimum — the same discipline the two units above already carry, applied
    to this round's own new terminate-character source. Family F does NOT
    complete this round: the [cfg_ifg] parameterisation and the 10 000-frame
    DIC sweep named above still need capabilities this round does not
    build. *)

open! Base
open Bench

let fail row msg = failwith (String.concat [ row; ": "; msg ])

let lane_value wire lane =
  match Dv_xgmii.Xgmii_word.lane wire lane with
  | Dv_xgmii.Xgmii_word.Data d -> d
  | Dv_xgmii.Xgmii_word.Control d -> d
;;

(* ---- U17: M04-F1 ---------------------------------------------------------- *)
(* Two P = 60 frames, one run, driven through {!Bench.run_stream} — WO-0082
   §6.2. Run length 51 cycles. *)

let run_f1 () =
  let row = "M04-F1" in
  let p = 60 in
  let _, t, samples = run_stream [ content_octets ~p; content_octets ~p ] in
  let c = first_accepted_cycle samples in
  (* Assertion 1: decoder clean (REQ-201/202/203/204/205's judgement on
     both frames), strobe set empty, exactly two frames begun and
     completed, neither underflowed. *)
  assert_instruments_clean_n t ~row ~frames:2;
  (* Assertion 2: two decoded frames, at the run law's own cycles
     (WO-0082 §4.2, §6.2's table). *)
  let f1, f2 =
    match wire_frames samples with
    | [ f1; f2 ] -> f1, f2
    | fs ->
      fail
        row
        (String.concat
           [ "wire_frames decoded "; Int.to_string (List.length fs); " frames, expected 2" ])
  in
  if f1.Dv_xgmii.Tx_decoder.terminate_cycle <> c + 10
  then
    fail
      row
      (String.concat
         [ "frame 1 terminate cycle = "
         ; Int.to_string f1.Dv_xgmii.Tx_decoder.terminate_cycle
         ; ", expected C+10"
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
  if f2.Dv_xgmii.Tx_decoder.start_cycle <> c + 12
  then
    fail
      row
      (String.concat
         [ "frame 2 start cycle = "
         ; Int.to_string f2.Dv_xgmii.Tx_decoder.start_cycle
         ; ", expected C+12 (run law S_2 = T_1 + g_1)"
         ]);
  if f2.Dv_xgmii.Tx_decoder.terminate_cycle <> c + 21
  then
    fail
      row
      (String.concat
         [ "frame 2 terminate cycle = "
         ; Int.to_string f2.Dv_xgmii.Tx_decoder.terminate_cycle
         ; ", expected C+21"
         ]);
  if f2.Dv_xgmii.Tx_decoder.terminate_lane <> 0
  then
    fail
      row
      (String.concat
         [ "frame 2 terminate lane = "
         ; Int.to_string f2.Dv_xgmii.Tx_decoder.terminate_lane
         ; ", expected 0"
         ]);
  (* Assertion 3: Tx_decoder.gaps has exactly one entry, and it is 16 —
     the list length is asserted first and by itself: a one-element
     assertion on a list not yet measured is how a two-gap run passes a
     one-gap check. *)
  let gaps = Dv_xgmii.Tx_decoder.gaps (decoder t) in
  if List.length gaps <> 1
  then
    fail
      row
      (String.concat
         [ "Tx_decoder.gaps has "; Int.to_string (List.length gaps); " entries, expected 1" ]);
  (match gaps with
   | [ g ] -> if g <> 16 then fail row (String.concat [ "the one gap = "; Int.to_string g; ", expected 16" ])
   | _ -> fail row "unreachable: gaps length already checked to be 1");
  (* Assertion 4: Tx_decoder.start_spacings has exactly one entry and it is
     11; 8 x 11 = 88 octets between successive start characters, asserted
     as the figure REQ-204's own verification column states, with the
     multiplication written out. *)
  let spacings = Dv_xgmii.Tx_decoder.start_spacings (decoder t) in
  if List.length spacings <> 1
  then
    fail
      row
      (String.concat
         [ "Tx_decoder.start_spacings has "
         ; Int.to_string (List.length spacings)
         ; " entries, expected 1"
         ]);
  (match spacings with
   | [ sp ] ->
     if sp <> 11
     then fail row (String.concat [ "the one spacing = "; Int.to_string sp; ", expected 11 cycles" ]);
     let octets_between = 8 * sp in
     if octets_between <> 88
     then
       fail
         row
         (String.concat
            [ "8 x "
            ; Int.to_string sp
            ; " = "
            ; Int.to_string octets_between
            ; " octets between successive start characters, expected 88 (REQ-204's own \
               verification figure)"
            ])
   | _ -> fail row "unreachable: start_spacings length already checked to be 1");
  (* Assertion 5: the fill residue (§6.0(c)) — the terminate word's fill
     lanes 1..7 carry /I/ as a VALUE (control bit set AND xgmii_txd =
     0x07, not just a control-bit check), and every lane of the gap word
     at cycle C+11 (the only cycle in T_1+1 .. S_2-1, since S_2 = C+12) is
     idle. The scan STOPS BEFORE S_2 = C+12: the next preamble word is not
     a gap word (the residue WO-0081 §19.2 item 4 named). *)
  (match List.find samples ~f:(fun (s : sample) -> s.cycle = c + 10) with
   | None -> fail row "no sample at the terminate cycle C+10"
   | Some s ->
     List.iter (List.range 1 8) ~f:(fun lane ->
       if not (Dv_xgmii.Xgmii_word.is_control s.wire lane)
       then
         fail
           row
           (String.concat
              [ "terminate word lane "; Int.to_string lane; " is not a control character" ]);
       let v = lane_value s.wire lane in
       if v <> Dv_xgmii.Xgmii_word.idle_char
       then
         fail
           row
           (String.concat
              [ "terminate word lane "
              ; Int.to_string lane
              ; " = "
              ; Int.to_string v
              ; ", expected /I/ = 0x07"
              ])));
  (match List.find samples ~f:(fun (s : sample) -> s.cycle = c + 11) with
   | None -> fail row "no sample at the gap cycle C+11"
   | Some s ->
     if not (Dv_xgmii.Xgmii_word.is_idle s.wire) then fail row "gap word at C+11 is not all-idle");
  (* Assertion 6: each frame's decoded octets equal the padded content plus
     its FCS, 64 octets each. *)
  let expected = Dv_xgmii.Frame.with_fcs (Dv_xgmii.Frame.pad_to_60 (content_octets ~p:60)) in
  if List.length f1.Dv_xgmii.Tx_decoder.octets <> 64
  then
    fail
      row
      (String.concat
         [ "frame 1 wire octet count = "
         ; Int.to_string (List.length f1.Dv_xgmii.Tx_decoder.octets)
         ; ", expected 64"
         ]);
  if not (List.equal Int.equal f1.Dv_xgmii.Tx_decoder.octets expected)
  then fail row "frame 1's decoded octets do not equal Frame.with_fcs (Frame.pad_to_60 content)";
  if List.length f2.Dv_xgmii.Tx_decoder.octets <> 64
  then
    fail
      row
      (String.concat
         [ "frame 2 wire octet count = "
         ; Int.to_string (List.length f2.Dv_xgmii.Tx_decoder.octets)
         ; ", expected 64"
         ]);
  if not (List.equal Int.equal f2.Dv_xgmii.Tx_decoder.octets expected)
  then fail row "frame 2's decoded octets do not equal Frame.with_fcs (Frame.pad_to_60 content)";
  (* M04-F5 (NO-ASSERT, round-wide, WO-0082 §1.3, §6.2): nothing above
     asserts an average gap, and nothing asserts "12 octets at t = 0" —
     the value at t = 0 is 16, and 12 is cfg_ifg, the MINIMUM, not the
     gap. requirements.md §0.3's RECEIVE-side spacing is not imported
     anywhere; a transmit bench built from that paragraph fails a
     conformant M04 on every frame. *)
  ()
;;

let%expect_test
  "M04-F1: the first gap this programme has measured at a transmit port \
   — 16 octets from the terminate character inclusive, 88 octets between \
   start characters"
  =
  run_f1 ();
  [%expect {||}]
;;

(* ---- U18: M04-F2 ----------------------------------------------------------- *)
(* The eight-member terminate-lane sweep — WO-0082 §6.3's own table,
   transcribed literally rather than recomputed from the run law here: the
   table IS the expectation this unit checks the bench against, not a
   formula this unit shares with the runner. Eight elaborations, run
   length 51 each. *)

type f2_member =
  { p1 : int
  ; t1 : int
  ; gap : int
  ; s2_off : int
  }

let f2_members =
  [ { p1 = 60; t1 = 0; gap = 16; s2_off = 12 }
  ; { p1 = 61; t1 = 1; gap = 15; s2_off = 12 }
  ; { p1 = 62; t1 = 2; gap = 14; s2_off = 12 }
  ; { p1 = 63; t1 = 3; gap = 13; s2_off = 12 }
  ; (* p1 = 64, t1 = 4: the DISCRIMINATING member. §0.3's convention and
       the convention §0.3 rejects give the SAME answer at every other
       residue in this sweep and differ ONLY here: 12 octets by this
       specification's inclusive-from-the-terminate-character convention,
       20 by the rejected reading (twelve idle octets AFTER the terminate
       character). SPEC-M04 §6.1 names exactly these two numbers, and the
       sweep is driven whole because sampling it has a seven-in-eight
       chance of missing this one member. *)
    { p1 = 64; t1 = 4; gap = 12; s2_off = 12 }
  ; { p1 = 65; t1 = 5; gap = 19; s2_off = 13 }
  ; { p1 = 66; t1 = 6; gap = 18; s2_off = 13 }
  ; { p1 = 67; t1 = 7; gap = 17; s2_off = 13 }
  ]
;;

let run_f2_member (m : f2_member) =
  let row = String.concat [ "M04-F2 (P1="; Int.to_string m.p1; ")" ] in
  let _, t, samples = run_stream [ content_octets ~p:m.p1; content_octets ~p:60 ] in
  let c = first_accepted_cycle samples in
  (* instruments clean at frames:2. *)
  assert_instruments_clean_n t ~row ~frames:2;
  let f1, f2 =
    match wire_frames samples with
    | [ f1; f2 ] -> f1, f2
    | fs ->
      fail
        row
        (String.concat
           [ "wire_frames decoded "; Int.to_string (List.length fs); " frames, expected 2" ])
  in
  (* T1 at C+10, and t1 at its own lane. *)
  if f1.Dv_xgmii.Tx_decoder.terminate_cycle <> c + 10
  then
    fail
      row
      (String.concat
         [ "T1 = "; Int.to_string f1.Dv_xgmii.Tx_decoder.terminate_cycle; ", expected C+10" ]);
  if f1.Dv_xgmii.Tx_decoder.terminate_lane <> m.t1
  then
    fail
      row
      (String.concat
         [ "t1 = "; Int.to_string f1.Dv_xgmii.Tx_decoder.terminate_lane; ", expected "
         ; Int.to_string m.t1
         ]);
  (* the single gap, equal to its own value from the table. *)
  let gaps = Dv_xgmii.Tx_decoder.gaps (decoder t) in
  if List.length gaps <> 1
  then
    fail
      row
      (String.concat
         [ "Tx_decoder.gaps has "; Int.to_string (List.length gaps); " entries, expected 1" ]);
  (match gaps with
   | [ g ] ->
     if g <> m.gap
     then
       fail
         row
         (String.concat [ "the one gap = "; Int.to_string g; ", expected "; Int.to_string m.gap ])
   | _ -> fail row "unreachable: gaps length already checked to be 1");
  (* S2 at its own cycle. *)
  if f2.Dv_xgmii.Tx_decoder.start_cycle <> c + m.s2_off
  then
    fail
      row
      (String.concat
         [ "S2 = "; Int.to_string f2.Dv_xgmii.Tx_decoder.start_cycle; ", expected C+"
         ; Int.to_string m.s2_off
         ]);
  (* every start character in lane 0 (both of them), read through
     Xgmii_word.start_lane on the raw sample, not only through the
     decoder. *)
  let start_samples =
    List.filter samples ~f:(fun (s : sample) ->
      Option.is_some (Dv_xgmii.Xgmii_word.start_lane s.wire))
  in
  (match start_samples with
   | [ s1; s2 ] ->
     (match Dv_xgmii.Xgmii_word.start_lane s1.wire, Dv_xgmii.Xgmii_word.start_lane s2.wire with
      | Some 0, Some 0 -> ()
      | Some l1, Some l2 ->
        fail
          row
          (String.concat
             [ "start lanes = ("; Int.to_string l1; ", "; Int.to_string l2; "), expected (0, 0)" ])
      | _ -> fail row "unreachable: start_samples was filtered on Some")
   | other ->
     fail
       row
       (String.concat
          [ "expected exactly two start characters in the run, found "
          ; Int.to_string (List.length other)
          ]));
  (* M04-F5 (NO-ASSERT, round-wide): the t = 4 member's own gap is 12, not
     20 — 20 is what the rejected receive-side convention would give.
     Nothing in this sweep asserts an average gap or imports that
     convention. *)
  ()
;;

let run_f2 () = List.iter f2_members ~f:run_f2_member

let%expect_test
  "M04-F2: the eight-member terminate-lane sweep of the gap, \
   12 octets at t = 4 and 16 at t = 0"
  =
  run_f2 ();
  [%expect {||}]
;;

(* ---- U26: M04-F6 (WO-0083 §4, §6.6) ----------------------------------------- *)
(* The gap after an abort: 15 octets from the /T/ in lane 1 — the one
   octet that separates conformant from not. One elaboration, run length
   47 cycles (WO-0083 §10). A second run at nearly the same stimulus as
   the neighbouring family-G unit that also drives an abort ahead of a
   second frame, deliberately: the two units assert disjoint things on
   different frames, filed in different families' files, and this row's
   claim must not ride on that unit's passing. *)

let run_f6 () =
  let row = "M04-F6" in
  let stall : Stall.t = { frame = 0; word = 4; hold = 1; after = Abandon } in
  let _, t, samples = run_scheduled [ content_octets ~p:60; content_octets ~p:60 ] stall in
  let c = first_accepted_cycle samples in
  let r = c + 4 in
  let a = r + 2 in
  (* Assertion 1. *)
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
  (* Assertion 2: Tx_decoder.gaps has exactly one entry, as its own
     statement. *)
  let gaps = Dv_xgmii.Tx_decoder.gaps (decoder t) in
  if List.length gaps <> 1
  then
    fail
      row
      (String.concat
         [ "Tx_decoder.gaps has "; Int.to_string (List.length gaps); " entries, expected 1" ]);
  (* Assertion 3: the exactness IS the row — 15 is asserted, not >= 12. The
     defect this exact assertion kills is a WHOLE-WORD error (a recorded
     gap of 7 or 23), never a one-octet error: every gap this decoder can
     record after an abort is 8k - 1 octets, i.e. congruent to 7 mod 8, so
     16 is not a value this decoder can ever produce (corrected 2026-08-22,
     WO-0084-S1, WO-0085; AP-xgmii_tx_64.md's corrected M04-F6). The
     /E/-vs-/T/ design (the sealed IC-10) is INVISIBLE at this row's own
     cfg_ifg = 12 — both readings place the next start character in the
     same word and the decoder records 15 either way — and its own coverage
     is M04-F7's, at cfg_ifg in {16, 24} where the two readings separate by
     a whole word (§4.2 fact 5, trap T13). *)
  (match gaps with
   | [ g ] ->
     if g <> 15
     then
       fail
         row
         (String.concat
            [ "the one gap = "
            ; Int.to_string g
            ; ", expected EXACTLY 15 (§4.2 fact 5: t = 1, g = 2 words, 8g - t = 15 \
               octets — the defect this exact assertion kills is a WHOLE-WORD error \
               (a recorded gap of 7 or 23), never a one-octet error: every abort gap \
               this decoder can record is 8k - 1 octets, i.e. congruent to 7 mod 8, so \
               16 is not a value this decoder can ever produce (corrected 2026-08-22, \
               WO-0084-S1, WO-0085; AP-xgmii_tx_64.md's corrected M04-F6); trap T13)"
            ])
   | _ -> fail row "unreachable: gaps length already checked to be 1");
  (* Assertion 4: the terminate character is at lane 1 of the abort word,
     read directly from samples' own raw wire at C+6 AS WELL AS through
     the decoder's terminate_lane — two readings of the same fact,
     deliberately: this round is the first to measure a gap whose
     terminate character comes from an aborted frame (class D2, §15). *)
  (match List.find samples ~f:(fun (s : sample) -> s.cycle = a) with
   | None -> fail row "no sample at the abort word cycle C+6"
   | Some s ->
     (match Dv_xgmii.Xgmii_word.lane s.wire 1 with
      | Dv_xgmii.Xgmii_word.Control v when v = Dv_xgmii.Xgmii_word.terminate_char -> ()
      | Dv_xgmii.Xgmii_word.Control v ->
        fail
          row
          (String.concat
             [ "raw wire lane 1 at C+6 = control "; Int.to_string v; ", expected /T/ (0xFD)" ])
      | Dv_xgmii.Xgmii_word.Data v ->
        fail
          row
          (String.concat
             [ "raw wire lane 1 at C+6 = data "; Int.to_string v; ", expected control /T/" ])));
  let f0 =
    match wire_frames samples with
    | [ f0; _ ] -> f0
    | fs ->
      fail
        row
        (String.concat
           [ "wire_frames decoded "; Int.to_string (List.length fs); " frames, expected 2" ])
  in
  if f0.Dv_xgmii.Tx_decoder.terminate_lane <> 1
  then
    fail
      row
      (String.concat
         [ "decoder's terminate_lane = "
         ; Int.to_string f0.Dv_xgmii.Tx_decoder.terminate_lane
         ; ", expected 1"
         ]);
  (* Assertion 5: the next start character is in lane 0, at C+8, via
     Xgmii_word.start_lane on the raw sample. *)
  match List.find samples ~f:(fun (s : sample) -> s.cycle = c + 8) with
  | None -> fail row "no sample at cycle C+8"
  | Some s ->
    (match Dv_xgmii.Xgmii_word.start_lane s.wire with
     | Some 0 -> ()
     | Some lane ->
       fail row (String.concat [ "start character at lane "; Int.to_string lane; ", expected 0" ])
     | None -> fail row "no start character at C+8")
(* What this unit does NOT assert (WO-0083 §6.6): no average gap, no gap
   of 12 at any lane, and no import of §0.3's RECEIVE-side spacing — the
   round-wide prohibition of the family's own NO-ASSERT row (the one
   about §0.6's window on error_underflow, already dispositioned and not
   named further here per bar M-7), restated here because this file is
   where it lives. *)
;;

let%expect_test
  "M04-F6: the gap after an abort — 15 octets from the /T/ in lane 1, the \
   next start character in lane 0"
  =
  run_f6 ();
  [%expect {||}]
;;

(* ---- U28: M04-F3 (WO-0085 §T-8) --------------------------------------------- *)
(* The normal-gap cfg_ifg sweep — the capability §T-8 names and WO-0085
   builds: {!Bench.run_stream}'s [?ifg], threaded to the DUT's own cfg_ifg
   port and to the standing decoder's REQ-204 arm alike. Two P = 60 frames
   (t = 0, fixed) per member, driven through {!Bench.run_stream}. Every
   expected value below is re-derived from SPEC-M04 §6.1's identity
   [g = ceil(cfg_ifg/8)], gap [8g] octets, at THIS row's own members — none
   of M04-F1/F2/F6's cfg_ifg = 12 figures is carried forward (WO-0085's own
   instruction). Kills (AP-xgmii_tx_64.md M04-F3): a design reading cfg_ifg
   as a WORD count (at 20 it would serve 160 octets); a design ignoring
   cfg_ifg and hard-wiring 16 (12, 13 and 16 all give 16, so the default
   value alone cannot distinguish a configurable design from a fixed one —
   20 is the smallest member that can); a design saturating an 8-bit
   accumulator at 255. *)

type f3_member =
  { ifg : int
  ; gap : int (* 8 * ceil(ifg / 8) *)
  ; s2_off : int (* the next start character, at C + 10 + g *)
  }

let f3_members : f3_member list =
  [ { ifg = 12; gap = 16; s2_off = 12 }
  ; { ifg = 13; gap = 16; s2_off = 12 }
  ; { ifg = 16; gap = 16; s2_off = 12 }
  ; { ifg = 20; gap = 24; s2_off = 13 }
  ; { ifg = 255; gap = 256; s2_off = 42 }
  ]
;;

let run_f3_member (m : f3_member) =
  let row = String.concat [ "M04-F3 (cfg_ifg="; Int.to_string m.ifg; ")" ] in
  let _, t, samples = run_stream ~ifg:m.ifg [ content_octets ~p:60; content_octets ~p:60 ] in
  let c = first_accepted_cycle samples in
  (* Assertion 1: instruments clean — the standing decoder's own REQ-204 arm
     now tracks m.ifg (WO-0085's own T-8 wiring), so a design under-serving
     the configured gap fails here as well as at assertion 3 below. Two
     frames begun and completed, neither underflowed. *)
  assert_instruments_clean_n t ~row ~frames:2;
  (* Assertion 2: both frames terminate at t = 0 — the stimulus precondition
     the row's identity (g = ceil(cfg_ifg/8), the t = 0 case) is stated
     against. Corroboration, not the row's own claim (M04-F2's own p1 = 60
     row already establishes p = 60 gives t = 0). *)
  let f1, f2 =
    match wire_frames samples with
    | [ f1; f2 ] -> f1, f2
    | fs ->
      fail
        row
        (String.concat
           [ "wire_frames decoded "; Int.to_string (List.length fs); " frames, expected 2" ])
  in
  if f1.Dv_xgmii.Tx_decoder.terminate_lane <> 0
  then
    fail
      row
      (String.concat
         [ "frame 1 terminate lane = "
         ; Int.to_string f1.Dv_xgmii.Tx_decoder.terminate_lane
         ; ", expected 0"
         ]);
  (* Assertion 3: Tx_decoder.gaps has exactly one entry — the list length
     asserted first, so a two-gap run cannot pass a one-gap check — and it
     is EXACTLY this member's gap, never >= cfg_ifg (a >=-only check is
     green against every design this row's Kills cell names). *)
  let gaps = Dv_xgmii.Tx_decoder.gaps (decoder t) in
  if List.length gaps <> 1
  then
    fail
      row
      (String.concat
         [ "Tx_decoder.gaps has "; Int.to_string (List.length gaps); " entries, expected 1" ]);
  (match gaps with
   | [ g ] ->
     if g <> m.gap
     then
       fail
         row
         (String.concat
            [ "the one gap = "
            ; Int.to_string g
            ; ", expected EXACTLY "
            ; Int.to_string m.gap
            ; " (g = ceil("
            ; Int.to_string m.ifg
            ; "/8) words, gap = 8g octets, SPEC-M04 §6.1's identity at t = 0)"
            ])
   | _ -> fail row "unreachable: gaps length already checked to be 1");
  (* Assertion 4: the next start character at its own cycle, C + 10 + g — a
     second, independent reading of the same fact (start_cycle against the
     terminate-to-gap arithmetic), catching a design that gets the gap
     octet count right but the word rounding wrong. *)
  if f2.Dv_xgmii.Tx_decoder.start_cycle <> c + m.s2_off
  then
    fail
      row
      (String.concat
         [ "frame 2 start cycle = "
         ; Int.to_string f2.Dv_xgmii.Tx_decoder.start_cycle
         ; ", expected C+"
         ; Int.to_string m.s2_off
         ])
;;

let run_f3 () = List.iter f3_members ~f:run_f3_member

let%expect_test
  "M04-F3: the normal-gap cfg_ifg sweep — g = ceil(cfg_ifg/8) words, gap 8g \
   octets, at cfg_ifg in {12, 13, 16, 20, 255}"
  =
  run_f3 ();
  [%expect {||}]
;;

(* ---- U29: M04-F7 (WO-0085 §T-8, WO-0084-S2) --------------------------------- *)
(* The abort-gap cfg_ifg sweep, mirroring M04-F6's own stall shape exactly
   (frame 0, word 4, hold 1, Abandon) — the same stimulus, deliberately
   (AP-xgmii_tx_64.md's rejection (c) of widening M04-F6 itself: that row
   stays pinned at cfg_ifg = 12 and its own = 15 assertion is undisturbed;
   this is a distinct instrument in its own row, so the two rows' kills stay
   separable). g = ceil((cfg_ifg + 1)/8) words (t = 1, the /T/ in lane 1),
   actual gap 8g - 1 octets. cfg_ifg = 12 is the control that shows the
   IC-10 / class-11 pair is invisible there (both readings give 15); 16 and
   24 are the discriminating members, where the two readings separate by a
   whole word (AP-xgmii_tx_64.md M04-F7, rejections (a) and (b)). *)

type f7_member =
  { ifg : int
  ; gap : int (* 8g - 1 *)
  ; g : int (* ceil((ifg + 1) / 8) *)
  }

let f7_members : f7_member list =
  [ { ifg = 12; gap = 15; g = 2 }; { ifg = 16; gap = 23; g = 3 }; { ifg = 24; gap = 31; g = 4 } ]
;;

let run_f7_member (m : f7_member) =
  let row = String.concat [ "M04-F7 (cfg_ifg="; Int.to_string m.ifg; ")" ] in
  let stall : Stall.t = { frame = 0; word = 4; hold = 1; after = Abandon } in
  let _, t, samples =
    run_scheduled ~ifg:m.ifg [ content_octets ~p:60; content_octets ~p:60 ] stall
  in
  let c = first_accepted_cycle samples in
  let r = c + 4 in
  let a = r + 2 in
  (* Assertion 1: instruments clean, one strobe at its own pin, frame 0
     underflowed, two frames begun and completed — M04-F6's own shape,
     unaffected by cfg_ifg (the strobe cycle and the abort word's own cycle
     turn on the stall schedule, never on the gap that follows it). *)
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
             (§4.2 fact 1) — independent of cfg_ifg"
      ];
  (* Assertion 2: Tx_decoder.gaps has exactly one entry — the list length
     asserted first, so a two-gap run cannot pass a one-gap check
     (WO-0085's own instruction). *)
  let gaps = Dv_xgmii.Tx_decoder.gaps (decoder t) in
  if List.length gaps <> 1
  then
    fail
      row
      (String.concat
         [ "Tx_decoder.gaps has "; Int.to_string (List.length gaps); " entries, expected 1" ]);
  (* Assertion 3: the exactness IS the row, at this member's own value —
     never >= cfg_ifg. The IC-10 (/E/-vs-/T/) design under-serves by a
     whole word rather than falling below the minimum, so a >=-only check
     is green against it at every member here. *)
  (match gaps with
   | [ g ] ->
     if g <> m.gap
     then
       fail
         row
         (String.concat
            [ "the one gap = "
            ; Int.to_string g
            ; ", expected EXACTLY "
            ; Int.to_string m.gap
            ; " (g = ceil(("
            ; Int.to_string m.ifg
            ; "+1)/8) = "
            ; Int.to_string m.g
            ; " words, 8g - 1 octets, t = 1 — the IC-10 design, measuring from the /E/ \
               in lane 0 rather than the /T/ in lane 1, records 8*ceil("
            ; Int.to_string m.ifg
            ; "/8) - 1 octets instead: identical to conformant at cfg_ifg = 12, and a \
               whole word short here)"
            ])
   | _ -> fail row "unreachable: gaps length already checked to be 1");
  (* Assertion 4: the abort word's own terminate character, at lane 1 of
     cycle A — the terminate-character source this row's identity is stated
     against, read from the raw wire, independent of cfg_ifg. *)
  (match List.find samples ~f:(fun (s : sample) -> s.cycle = a) with
   | None -> fail row "no sample at the abort word cycle C+6"
   | Some s ->
     (match Dv_xgmii.Xgmii_word.lane s.wire 1 with
      | Dv_xgmii.Xgmii_word.Control v when v = Dv_xgmii.Xgmii_word.terminate_char -> ()
      | Dv_xgmii.Xgmii_word.Control v ->
        fail
          row
          (String.concat
             [ "raw wire lane 1 at C+6 = control "; Int.to_string v; ", expected /T/ (0xFD)" ])
      | Dv_xgmii.Xgmii_word.Data v ->
        fail
          row
          (String.concat
             [ "raw wire lane 1 at C+6 = data "; Int.to_string v; ", expected control /T/" ])));
  (* Assertion 5: the next start character in lane 0, at cycle A + g — this
     member's own cycle, re-derived from the identity rather than carried
     forward from M04-F6's cfg_ifg = 12 figure. *)
  let s2 = a + m.g in
  match List.find samples ~f:(fun (s : sample) -> s.cycle = s2) with
  | None -> fail row (String.concat [ "no sample at cycle C+"; Int.to_string (s2 - c) ])
  | Some s ->
    (match Dv_xgmii.Xgmii_word.start_lane s.wire with
     | Some 0 -> ()
     | Some lane ->
       fail row (String.concat [ "start character at lane "; Int.to_string lane; ", expected 0" ])
     | None -> fail row (String.concat [ "no start character at C+"; Int.to_string (s2 - c) ]))
;;

let run_f7 () = List.iter f7_members ~f:run_f7_member

let%expect_test
  "M04-F7: the abort-gap cfg_ifg sweep — g = ceil((cfg_ifg + 1)/8) words, \
   gap 8g - 1 octets, at cfg_ifg in {12, 16, 24}"
  =
  run_f7 ();
  [%expect {||}]
;;
