(** Family D — the FCS check (REQ-104, REQ-304, §6.1). WO-0040.

    Four rows (AP-xgmii_rx_64.md §4.D, as corrected by WO-0040 §4):
    M03-D1 (ASSERT, this file's [run_d1]), M03-D2 (ASSERT, [run_d2_d1_partner]
    / [run_d2_d3_good_member]), M03-D3 (ASSERT, [run_d3]), M03-D4
    (NO-ASSERT, declared at the bottom of this file, nothing to run).

    {2 WO-0040 §3.2's trap, and how every row below avoids it}

    [Dv_xgmii.Arrival.create]'s [?fcs_valid] defaults to [true], and
    [Bench.run] discharges standing obligation 5 by calling [Arrival.check],
    which verifies the REQ-304 residue over every frame in the schedule when
    [fcs_valid] is set. A bad-FCS frame scheduled through {!Bench.one_frame}
    (which fixes [fcs_valid:true]) would therefore fail the STIMULUS's own
    self-check before a single cycle is driven, and that failure reads
    exactly like a DUT finding while being nothing of the kind. Every row
    below that schedules a bad-FCS frame uses {!frames_at}
    [~fcs_valid:false] instead — and, per WO-0040 §3.2, asserts
    [Frame.residue_ok] BY HAND in both directions at construction, since
    [~fcs_valid:false] switches the check off for every frame in that
    schedule, including a good one riding alongside a bad one. The negative
    direction ([residue_ok] of the corrupted octets must be [false]) is the
    one that matters: if the bit flip below silently failed to land, the
    resulting frame would still be good, and M03-D1 would then assert
    [tuser]\[0\] = 1 against a conformant design for a reason that has
    nothing to do with M03. *)

open! Base
open Bench

let fail row msg = failwith (String.concat [ row; ": "; msg ])

(* WO-0040 §6: M03-D1's construction, reused by M03-D3's bad-FCS member —
   bit 0 of the octet at index 20 (inside the payload: DA 0-5, SA 6-11,
   length/type 12-13, payload 14-59, FCS 60-63), flipped AFTER
   [Frame.with_fcs] so the frame's length is unchanged, every other octet is
   unchanged, and the FCS itself is now wrong. *)
let flip_bit0_at ~idx octets = List.mapi octets ~f:(fun i v -> if i = idx then v lxor 1 else v)
let corrupt_payload_bit octets = flip_bit0_at ~idx:20 octets

(* Shared by every row below that needs a 64-octet good/bad-FCS pair
   (M03-D1 directly; M03-D3 and M03-D2's D3-partner check via
   {!run_mixed_pair}). WO-0040 §3.2's "both directions" requirement: the
   base frame's own FCS must check out BEFORE corruption (the positive
   direction — M03-B1's own pattern, "test bug" rather than an M03 finding),
   and the corruption must actually change the residue (the negative,
   anti-vacuity direction §3.2 calls out explicitly). *)
let good_and_bad_64 ~row =
  let good = directed_frame_octets ~length:64 in
  if not (Dv_xgmii.Frame.residue_ok good)
  then fail row "test bug — the base 64-octet frame's own FCS does not check out";
  let bad = corrupt_payload_bit good in
  if Dv_xgmii.Frame.residue_ok bad
  then fail row "test bug — the payload-bit flip did not change the frame's FCS residue";
  good, bad
;;

(* ---- M03-D1 --------------------------------------------------------------- *)
(* "A 64-octet frame with one payload bit flipped after the FCS was
   computed, both start lanes: the same 60 octets still delivered (the
   frame is forwarded in full, REQ-005), tuser[0] = 1 on the tlast word,
   exactly one error_bad_fcs high cycle on the tlast cycle (§9's pinned
   cycle), no other strobe of any kind." WO-0040 §6 pins the expected
   cycle: 8 output words, word m on cycle start_cycle + 3 + m (as every
   other clean-frame row in this suite), so the tlast word (word 7) is on
   start_cycle + 10 at BOTH start lanes — WO-0040 §5's age-0 declaration:
   the terminate character arrives one cycle earlier, at cycle 10 (an
   absolute cycle number, since first_start puts start_cycle = 1 at both
   lanes for a single-frame schedule), so the strobe's own pinned cycle is
   never co-timed with the closing input word in this row.

   §3.1: a bad-FCS frame is forwarded in full (§9 row 1), so its delivered
   extent is the ordinary clean-frame identity extent and
   account_clean_frame's ~aborted:false is correct — this is NOT the
   truncated-frame path M03-C4 uses for its runt.

   WHAT THIS ROW ASSERTS DIRECTLY, AND WHAT IT CARRIES (RV-0040-VERDICT §3
   — recorded because a reader must not believe this row asserts more than
   it does). WO-0040 §6 lists five expected values. Asserted DIRECTLY
   below: the output-word COUNT (8), the tlast word's own CYCLE
   (start_cycle + 10), tuser[0] = 1, the delivered octet SEQUENCE against
   the CORRUPTED frame's own sixty, and the exact strobe SET. NOT asserted
   directly: the per-word tkeep pattern (0xFF x7 then 0x0F), "tlast on word
   7 only", and the intermediate words' cycles (start_cycle + 3 + m for
   m < 7). Those three are CARRIED, and by argument rather than by hope:

   - a wrong tkeep changes the delivered octet stream, because
     Stream_word.octets is tkeep-MASKED and directed_frame_octets' filler
     is position-dependent — so the octet-sequence assertion below catches
     it;
   - a tlast on an earlier word is what tlast_sample finds FIRST, so its
     cycle then fails the start_cycle + 10 check below;
   - the intermediate word cycles transfer from M03-A1/A2 (which assert
     start_cycle + 3 + m for every m on this same 64-octet shape) because
     REQ-005 is CUT-THROUGH: no word is withheld, so no word's timing may
     depend on a verdict that is not known until closure. A bad-FCS frame
     cannot have different intermediate timing without violating REQ-005 —
     and were it to, the accumulated displacement would surface in this
     row's own word-7 cycle assertion. *)

let run_d1 ~lane =
  let row = String.concat [ "M03-D1 (lane "; Int.to_string lane; ")" ] in
  let _good, bad = good_and_bad_64 ~row in
  let sched = frames_at ~lane ~fcs_valid:false [ bad ] in
  let frame = (Dv_xgmii.Arrival.frames sched).(0) in
  let start_cycle = Dv_xgmii.Arrival.start_cycle frame in
  let terminate_cycle = Dv_xgmii.Arrival.terminate_octet_time frame / 8 in
  let expected_pulse_cycle = start_cycle + 10 in
  let bench = create () in
  Dv_monitors.Strobe_monitor.expect
    (strobes bench)
    { Dv_monitors.Strobe_monitor.strobe = "error_bad_fcs"
    ; frame = 0
    ; cycle = expected_pulse_cycle
    ; not_before = terminate_cycle
    ; not_after = terminate_cycle + 3
    ; why =
        "REQ-104 (bad FCS, forwarded per REQ-005); SPEC-M03 section 9 'Strobe \
         cycle, pinned' pins it to the frame's tlast cycle, which for this \
         64-octet frame's 8-word output is start_cycle + 3 + 7 = start_cycle + 10 \
         (WO-0040 section 6)"
    };
  let samples = run bench sched ~drain:8 () in
  let words = delivered_samples samples in
  if List.length words <> 8
  then fail row (String.concat [ "expected 8 output words, got "; Int.to_string (List.length words) ]);
  (match tlast_sample samples with
   | None -> fail row "no tlast word observed"
   | Some s ->
     if s.cycle <> expected_pulse_cycle
     then
       fail
         row
         (String.concat
            [ "tlast word arrived on cycle "
            ; Int.to_string s.cycle
            ; ", expected "
            ; Int.to_string expected_pulse_cycle
            ]);
     if s.out.Dv_monitors.Stream_word.tuser <> 1
     then fail row "tuser[0] is not set on a bad-FCS frame (REQ-104)");
  let expected_octets = Dv_xgmii.Frame.delivered bad in
  let got_octets = delivered_octets samples in
  if not (List.equal Int.equal got_octets expected_octets)
  then
    fail
      row
      "delivered octets differ from the corrupted frame's own 60 octets (REQ-005: \
       forwarded in full, corruption included)";
  (match error_pulses samples with
   | [ (cycle, name) ] ->
     if not (String.equal name "error_bad_fcs")
     then fail row (String.concat [ "expected error_bad_fcs, observed "; name ])
     else if cycle <> expected_pulse_cycle
     then
       fail
         row
         (String.concat
            [ "error_bad_fcs pulsed on cycle "
            ; Int.to_string cycle
            ; ", expected "
            ; Int.to_string expected_pulse_cycle
            ])
   | pulses ->
     fail
       row
       (String.concat
          [ "expected exactly one strobe pulse (error_bad_fcs only), observed "
          ; Int.to_string (List.length pulses)
          ]));
  account_clean_frame bench frame samples ~aborted:false;
  Dv_monitors.Conservation_monitor.strobe_pulse (conservation bench) ~name:"error_bad_fcs";
  assert_monitors_clean bench ~row
;;

let%expect_test
  "M03-D1: 64-octet frame, one payload bit flipped post-FCS, both start \
   lanes — forwarded in full, tuser[0] set, exactly one error_bad_fcs on \
   the tlast cycle"
  =
  run_d1 ~lane:0;
  run_d1 ~lane:4;
  [%expect {||}]
;;

(* ---- Machinery shared by M03-D2's D3-partner check and M03-D3 ------------ *)
(* WO-0040 §4 corrects AP-xgmii_rx_64.md row M03-D3: the killing ordering is
   good-then-bad (pair A), not the plan's original bad-then-good (pair B).
   Both orderings are driven — pair A kills a design that reads the CRC
   register at the tlast cycle instead of carrying the verdict with the
   frame; pair B kills a design that latches the abort bit and fails to
   clear it between frames. *)

type d3_ordering =
  | Good_then_bad
  | Bad_then_good

let d3_ordering_label = function
  | Good_then_bad -> "pair A (good-then-bad)"
  | Bad_then_good -> "pair B (bad-then-good)"
;;

(* {!Bench.split_at_first_tlast}: the boundary between a two-frame
   schedule's first and second delivered frame. *)

type mixed_pair_frame =
  { sample_words : sample list (* this frame's own delivered words, in
                                   cycle order, [tlast] on the last one *)
  ; expected_tuser : int
  ; octets : int list (* this frame's own DA-through-FCS octets, as
                          scheduled — the flipped-bit copy for the bad
                          member *)
  ; tlast_cycle : int
  }

type mixed_pair_result =
  { bench : t
  ; sched : Dv_xgmii.Arrival.t
  ; frame0 : mixed_pair_frame
  ; frame1 : mixed_pair_frame
  ; bad_index : int (* 0 or 1 — which of frame0/frame1 carries the bad FCS *)
  ; bad_pulse_cycle : int
  }

(* Builds and drives ONE of M03-D3's four schedules: two 64-octet frames at
   {!frames_at}'s default (§0.3 minimum, 12-octet) gap, [good_first]
   determining the ordering. [good_and_bad_64]'s residue_ok checks (WO-0040
   §3.2, both directions) are re-derived here rather than inherited from
   {!run_d1} — a fresh call, on this row's own construction. The
   [error_bad_fcs] pin registered below is WO-0040 §6's same formula as
   M03-D1 (start_cycle + 10 for a 64-octet frame's tlast word), read off
   the bad frame's OWN [Arrival.frame] record — never off the other frame
   in the schedule, and never derived by arithmetic on octet times by hand
   (WO-0040 §6: "The second frame's start_cycle comes from
   Arrival.frames sched).(1), not from arithmetic you do by hand").

   WHY THAT FORMULA SURVIVES A TWO-FRAME SCHEDULE (RV-0040-VERDICT §5,
   ruling on this file's open question 1 — the extension was flagged, and
   this is the ground dv_lead confirmed it on, which is NOT the ground it
   was first argued from).

   SPEC-M03 §6.1 states the m + 3 cycle formula under a gapless qualifier,
   and that qualifier is defined PER FRAME: "On a gapless stimulus — one in
   which THE FRAME'S OCTETS occupy consecutive octet times from the start
   character onward, so that no XGMII word between the start word and the
   word carrying the terminate character is an idle word — output word m is
   emitted on the cycle m + 3 counted from the word carrying the start
   character." The span it constrains runs from THAT frame's start word to
   THAT frame's terminate word, so an INTER-frame gap lies entirely outside
   it. Both frames of a pair below are internally contiguous, so m + 3
   applies to each from its own start word and start_cycle + 10 is the
   frame-local consequence. (The qualifier exists for REQ-016's idle
   injection, which puts an idle word INSIDE an open frame; §6.1's own
   following paragraph makes the scoping explicit, noting that a /T/ in
   lane 0 carries no frame octet "yet that table is the gapless case the
   m + 3 formula is derived from … both words fall outside the span it
   constrains".)

   Second, independent route, kept because it is not wrong and reaches the
   same answer from the datapath rather than from the formula's scope:
   REQ-004/§8's zero-backpressure one-word-per-cycle invariant and
   REQ-019's fixed ΔC = (L + h)/8 mean the datapath has no internal
   buffering and a fixed per-octet delay, so each frame's output timing is
   a pure function of its own input octet times, independent of a
   neighbouring frame's presence. *)
let run_mixed_pair ~row ~lane ~good_first =
  let good, bad = good_and_bad_64 ~row in
  let octets_list = if good_first then [ good; bad ] else [ bad; good ] in
  let sched = frames_at ~lane ~fcs_valid:false octets_list in
  let frames = Dv_xgmii.Arrival.frames sched in
  let bad_index = if good_first then 1 else 0 in
  let bad_frame = frames.(bad_index) in
  let bad_start_cycle = Dv_xgmii.Arrival.start_cycle bad_frame in
  let bad_terminate_cycle = Dv_xgmii.Arrival.terminate_octet_time bad_frame / 8 in
  let bad_pulse_cycle = bad_start_cycle + 10 in
  let bench = create () in
  Dv_monitors.Strobe_monitor.expect
    (strobes bench)
    { Dv_monitors.Strobe_monitor.strobe = "error_bad_fcs"
    ; frame = bad_index
    ; cycle = bad_pulse_cycle
    ; not_before = bad_terminate_cycle
    ; not_after = bad_terminate_cycle + 3
    ; why =
        "REQ-104; SPEC-M03 section 9 pins error_bad_fcs to the frame's OWN \
         tlast cycle (start_cycle + 10 for a 64-octet frame), read off \
         Arrival.frames sched).(bad_index) rather than derived by hand \
         (WO-0040 section 6 — the whole point of this row is that the two \
         frames' verdicts must not be confused with each other)"
    };
  let samples = run bench sched ~drain:8 () in
  let words0, words1 = split_at_first_tlast (delivered_samples samples) in
  if List.is_empty words0 || List.is_empty words1
  then fail row "expected two delivered frames (one tlast word each), got fewer";
  let tlast_cycle0 = (List.last_exn words0).cycle in
  let tlast_cycle1 = (List.last_exn words1).cycle in
  let octets0, octets1 =
    match octets_list with
    | [ a; b ] -> a, b
    | _ -> fail row "internal: octets_list is not a pair"
  in
  let expected_tuser0 = if good_first then 0 else 1 in
  let expected_tuser1 = if good_first then 1 else 0 in
  (* Attribution: a strobe pulses only on its OWN frame's pinned cycle
     (§9), and frame 2's cycles all strictly follow frame 1's tlast cycle —
     even under the coincidence WO-0040 §4 works out (frame 2's START
     character arriving the very cycle frame 1's tlast word is emitted),
     frame 2's OWN tlast/pulse cycle is still several cycles later. Cycle
     <= tlast_cycle0 therefore reliably means "frame 1's own", regardless
     of which design under test produced it — this is the partition a
     wrong design (D-M3: reads the CRC register at the tlast cycle) would
     violate by producing a pulse attributed to the WRONG frame, which is
     exactly what this split is built to catch. *)
  let all_pulses = error_pulses samples in
  let pulses0, pulses1 =
    List.partition_tf all_pulses ~f:(fun (cycle, _) -> cycle <= tlast_cycle0)
  in
  { bench
  ; sched
  ; frame0 =
      { sample_words = words0; expected_tuser = expected_tuser0; octets = octets0; tlast_cycle = tlast_cycle0 }
  ; frame1 =
      { sample_words = words1; expected_tuser = expected_tuser1; octets = octets1; tlast_cycle = tlast_cycle1 }
  ; bad_index
  ; bad_pulse_cycle
  }, pulses0, pulses1
;;

(* Content, tuser and exact-strobe-set assertion for one frame of a
   {!run_mixed_pair} result — shared by M03-D3 (both frames) and M03-D2's
   D3-partner check (the good frame only). *)
let assert_frame ~row ~label ~expected_pulses (f : mixed_pair_frame) (pulses : (int * string) list) =
  let expected_octets = Dv_xgmii.Frame.delivered f.octets in
  let got_octets =
    List.concat_map f.sample_words ~f:(fun (s : sample) -> Dv_monitors.Stream_word.octets s.out)
  in
  if not (List.equal Int.equal got_octets expected_octets)
  then fail row (String.concat [ label; ": delivered octets differ from its own 60 octets" ]);
  let tlast_s = List.last_exn f.sample_words in
  if tlast_s.out.Dv_monitors.Stream_word.tuser <> f.expected_tuser
  then fail row (String.concat [ label; ": tuser[0] does not match its own FCS status" ]);
  let pulse_equal (c1, n1) (c2, n2) = c1 = c2 && String.equal n1 n2 in
  if not (List.equal pulse_equal pulses expected_pulses)
  then fail row (String.concat [ label; ": strobe set is not exactly what its own FCS status implies" ])
;;

(* ---- M03-D2 ----------------------------------------------------------- *)
(* "The anti-vacuity partner: good-FCS frames carry tuser[0] = 0 and no
   error_bad_fcs. Largely discharged by citation."

   CITATION (WO-0040 §2) — already asserted by the existing suite, NOT
   re-driven here:
   - lengths 64..71 at both lanes: M03-C1/C2 (outcome_ok requires
     observed_tuser = Some 0 and error_pulse_count = 0) and M03-A3/A4.
   - 64 octets at both lanes: M03-A1/A2 (explicit tuser check and
     error_pulses empty) and M03-A5 (position-dependent filler).
   - a 60-octet payload with nonstandard preamble filler, both lanes:
     M03-B1.
   - 1518 octets at both lanes: M03-C3.
   - 1513 and 1516 octets at both lanes: M03-C5.
   Excluded from the citation, deliberately: M03-C4's 5-octet runt (carries
   tuser[0] = 1 by REQ-107, not a good-FCS clean case), and every frame
   below 5 received octets (§9 ruling 9 puts error_bad_fcs out of reach
   there regardless).

   WHAT D2 ADDS ON TOP (WO-0040 §2) — the good-FCS partners of D1's and
   D3's OWN frames, asserted here rather than inherited from those rows'
   own tests, because without this D1 and D3 rest on the unverified claim
   that their construction produces a bad frame and ONLY a bad frame. *)

let run_d2_d1_partner ~lane =
  let row = String.concat [ "M03-D2 (D1's own frame, uncorrupted, lane "; Int.to_string lane; ")" ] in
  let good, _bad = good_and_bad_64 ~row in
  let sched = one_frame ~lane good in
  let frame = (Dv_xgmii.Arrival.frames sched).(0) in
  let bench = create () in
  let samples = run bench sched ~drain:8 () in
  (match tlast_sample samples with
   | None -> fail row "no tlast word observed"
   | Some s ->
     if s.out.Dv_monitors.Stream_word.tuser <> 0
     then fail row "tuser[0] set on a legal, good-FCS frame");
  if not (List.is_empty (error_pulses samples))
  then fail row "an error strobe pulsed on a legal, good-FCS frame";
  let expected_octets = Dv_xgmii.Frame.delivered good in
  let got_octets = delivered_octets samples in
  if not (List.equal Int.equal got_octets expected_octets)
  then fail row "delivered octets differ from the injected frame minus its FCS";
  account_clean_frame bench frame samples ~aborted:false;
  assert_monitors_clean bench ~row
;;

let run_d2_d3_good_member ~lane ~ordering =
  let good_first =
    match ordering with
    | Good_then_bad -> true
    | Bad_then_good -> false
  in
  let row =
    String.concat
      [ "M03-D2 (D3's good member, "
      ; d3_ordering_label ordering
      ; ", lane "
      ; Int.to_string lane
      ; ")"
      ]
  in
  let r, pulses0, pulses1 = run_mixed_pair ~row ~lane ~good_first in
  if good_first
  then assert_frame ~row ~label:"frame 1" ~expected_pulses:[] r.frame0 pulses0
  else assert_frame ~row ~label:"frame 2" ~expected_pulses:[] r.frame1 pulses1
;;

let%expect_test
  "M03-D2: good-FCS frames stay clean — D1's and D3's own good-FCS members, \
   asserted independently of those rows' tests (the citation extent for the \
   rest of this row is documented above, not re-driven)"
  =
  run_d2_d1_partner ~lane:0;
  run_d2_d1_partner ~lane:4;
  (* RV-0040-R2, ruling this file's open question 2: all four (lane,
     ordering) combinations, not lane 0 only. On COVERAGE these four are
     redundant — run_d3 below already asserts every good member clean at
     both lanes and both orderings, via assert_frame with
     ~expected_pulses:[]. Their value is FAULT ISOLATION: in this separate
     %expect_test the good-member claim still reports when run_d3 fails for
     some other reason and aborts before reaching it — the same principle
     that put RV-0038-R5's R5-4 batched table in test_m03_c.ml. That value
     is symmetric in lane, so lane 0 alone had no justification. *)
  run_d2_d3_good_member ~lane:0 ~ordering:Good_then_bad;
  run_d2_d3_good_member ~lane:0 ~ordering:Bad_then_good;
  run_d2_d3_good_member ~lane:4 ~ordering:Good_then_bad;
  run_d2_d3_good_member ~lane:4 ~ordering:Bad_then_good;
  [%expect {||}]
;;

(* ---- M03-D3 ------------------------------------------------------------- *)
(* "Two frames at the §0.3 minimum gap, in both orderings, killing a design
   that reads the CRC register at the tlast cycle instead of carrying the
   verdict with the frame." WO-0040 §4's correction: pair A (good-then-bad)
   carries that kill; pair B (bad-then-good, the attack plan's original
   ordering) is retained because it kills a design that latches the abort
   bit and fails to clear it between frames. Four schedules: both orderings
   at both start lanes. *)

let run_d3 ~lane ~ordering =
  let good_first =
    match ordering with
    | Good_then_bad -> true
    | Bad_then_good -> false
  in
  let row =
    String.concat [ "M03-D3 "; d3_ordering_label ordering; ", lane "; Int.to_string lane ]
  in
  let r, pulses0, pulses1 = run_mixed_pair ~row ~lane ~good_first in
  let expected_pulses_for idx =
    if idx = r.bad_index then [ r.bad_pulse_cycle, "error_bad_fcs" ] else []
  in
  assert_frame ~row ~label:"frame 1" ~expected_pulses:(expected_pulses_for 0) r.frame0 pulses0;
  assert_frame ~row ~label:"frame 2" ~expected_pulses:(expected_pulses_for 1) r.frame1 pulses1;
  let frames = Dv_xgmii.Arrival.frames r.sched in
  account_clean_frame r.bench frames.(0) r.frame0.sample_words ~aborted:false;
  account_clean_frame r.bench frames.(1) r.frame1.sample_words ~aborted:false;
  Dv_monitors.Conservation_monitor.strobe_pulse (conservation r.bench) ~name:"error_bad_fcs";
  assert_monitors_clean r.bench ~row
;;

let%expect_test
  "M03-D3: two 64-octet frames at the minimum gap, both orderings, both \
   start lanes — pair A (good-then-bad) kills the register-read design, \
   pair B (bad-then-good) kills a latched abort bit"
  =
  run_d3 ~lane:0 ~ordering:Good_then_bad;
  run_d3 ~lane:0 ~ordering:Bad_then_good;
  run_d3 ~lane:4 ~ordering:Good_then_bad;
  run_d3 ~lane:4 ~ordering:Bad_then_good;
  [%expect {||}]
;;

(* ---- M03-D4 (NO-ASSERT) --------------------------------------------------- *)
(* "REQ-104, §6.3 item 1 | -- | The realisation is not asserted.
   Residue-versus-capture is unobservable (§6.3 item 1); a bench asserts the
   verdict, never the mechanism | -- | NO-ASSERT."

   Declared and asserted nothing, in the shape M03-A4 (test_m03_a.ml) and
   M03-L6 (test_m03_structural.ml) already use: no code in this file tests
   WHICH FCS realisation M03 uses (a running residue carried alongside the
   frame versus a captured CRC compared once at closure, or any other
   internal mechanism) — every assertion above reaches only the verdict
   (tuser[0], error_bad_fcs) and its pinned cycle, which is what §6.3 item 1
   permits a bench to observe. There is no test function for this row and
   none is owed: unlike M03-A4 (which pairs its NO-ASSERT with a positive,
   permitted fact about the same stimulus — the per-lane ΔC check) and
   M03-L6 (a compile-time witness), M03-D4 has no stimulus of its own
   (AP-xgmii_rx_64.md's Stimulus cell is "—") and nothing else to assert in
   its place. *)
