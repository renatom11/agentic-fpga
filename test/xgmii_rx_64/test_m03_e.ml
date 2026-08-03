(** Family E — the error character inside a frame (REQ-105, §9). WO-0043,
    plus M03-E5 folded in by WO-0047 §1.2.

    Four rows from WO-0043 (`AP-xgmii_rx_64.md` §4.E): M03-E1 (ASSERT,
    [run_e1]), M03-E2 (ASSERT, [run_e2]), M03-E3 (NO-ASSERT, discharged by
    [run_e2]'s own accounting discipline — see the declaration below
    [run_e2]), M03-E4 (ASSERT, [run_e4]). A fifth, [run_e5], is appended at
    the end of this file by WO-0047: M03-E5 is REQ-105's own row (not
    REQ-107's), folded into the family-F work order rather than given its own
    packet because E5 and F2 are the programme's two no-output-word classes
    and a shared-path defect would have to be scored against both to be
    understood (WO-0047 §1.2) — accounting stays separate, and this row
    discharges M03-E5/REQ-105 exactly as the other four discharge their own
    rows.

    {2 WO-0043 §1's binding instruction, and how this file honours it}

    Every expected value below is derived BY HAND from SPEC-M03 §9 (the
    closure list, the co-occurrence rulings, the "Strobe cycle, pinned"
    paragraph) and §6.1 (the per-octet constant, §7's h/L/ΔC). `Dv_xgmii.
    Injection`'s computed [outcome] is used only as a {b reported cross-check}
    ([cross_check_e1]/[cross_check_e2] below): every hand-derived number is
    algebraically re-derivable from [Injection]'s own [tlast_cycle_of] /
    [no_output_cycle] / [tkeep_of] formulas (verified by hand while writing
    this file, not merely by running it), so the cross-check is expected to
    agree; a disagreement, per WO-0043 §1, is a finding to RETURN, never
    something this file resolves by adopting the model's number.

    {2 WO-0043 §4's three trap questions — answered here, reported in full in
    the WO-0043 Return log}

    1. [Injection.create] passes [~fcs_valid:false] to [Arrival.create]
       UNCONDITIONALLY (`test/xgmii/injection.ml:135`), regardless of whether
       a case's corruptions are [Flip_bit] or [Place]-only. Family E's cases
       are [Place]-only, so their underlying [octets] arrays are untouched and
       genuinely carry a correct FCS, but [Arrival.check]'s residue check is
       switched off for them exactly as WO-0040 §3.2 warned. Every base frame
       below therefore asserts [Dv_xgmii.Frame.residue_ok] BY HAND before it is
       corrupted (M03-E1, M03-E2, M03-E4's two clean frames).
    2. [Arrival.check]'s gap/DIC/overlap arithmetic is a pure function of each
       [Arrival.frame]'s [octets] ARRAY LENGTH via [terminate_octet_time] —
       it has no knowledge of [Injection]'s [overrides] table at all
       (`test/xgmii/arrival.ml`, `test/xgmii/injection.ml:190-200`). For
       family E's [Place] corruptions the underlying [octets] array is
       unmodified, so the schedule's own [terminate_octet_time] still lands at
       the frame's ordinary, un-aborted position and a genuine (if
       DUT-ignored, once the frame has closed early) `/T/` character is still
       emitted there on the wire. [Arrival.check] therefore judges exactly
       that still-present geometry and is unaffected by an early abort placed
       strictly inside it — it accepts every one of M03-E1's and M03-E2's
       schedules cleanly, and this file relies on that (no manual pre-check of
       [Arrival.check] is added on top of [Bench.run]'s own standing-obligation
       5 call).
    3. M03-E4's `/E/` sits in the inter-frame GAP, strictly after one frame's
       terminate character and strictly before the next frame's start
       character. [Injection]'s [placement] type ([At_preamble], [At_octet],
       [At_terminate]) is defined entirely relative to ONE frame's own
       [start_octet_time] (`test/xgmii/injection.mli`); none of its three
       constructors can name an octet time outside every frame's own span, so
       a gap placement is NOT expressible as a [corruption] on either frame.
       [run_e4] below therefore does not use [Injection] at all: it builds two
       ordinary clean frames via {!Bench.frames_at} and reaches into the gap
       with {!Bench.run}'s existing [?word_at] hook (test_m03_b.ml's own
       pattern), which needs no addition to [Injection] or to [bench.ml].

    No bench or [Injection] addition was needed for any of the three answers
    above, so none is made (WO-0043 §4's own condition for returning the
    question first).

    {2 M03-E2's tuser prohibition (WO-0043 §2)}

    [run_e2] asserts NOTHING about [tuser] — not 0, not 1 — because SPEC-M03
    §4.1 makes the bit meaningful only on the [tlast] word and this frame has
    none (asserted first, via [tlast_sample samples = None], per standing
    obligation 6).

    {2 M03-E4's stimulus-verification (WO-0043 §2's residue_ok-both-directions
    lesson, generalised)}

    [run_e4] asserts the `/E/` is present in the driven word at the intended
    gap cycle/lane — from the schedule's own words, both before driving
    ([Injection]-free here, so read directly off the [?word_at] closure) and
    from the sample [run] actually drove — BEFORE asserting that nothing was
    reported. A negative assertion whose stimulus silently failed to land
    would pass against everything.

    {2 Independence}

    Every expected value is read from `docs/specs/modules/xgmii_rx_64.md` §6.1,
    §6.2, §6.3, §9 and `docs/specs/requirements.md` §0.6, §0.7, REQ-007,
    REQ-008, REQ-013, REQ-103, REQ-105, REQ-113 — cited inline — plus
    `test/xgmii/injection.ml`, `test/xgmii/injection.mli` and
    `test/xgmii/arrival.ml` (read for the three trap answers above; all under
    `test/`, not `libs/`). `libs/**`, `top/**`, `bin/**` and `rtl_snapshots/**`
    were not opened. *)

open! Base
open Bench

let fail row msg = failwith (String.concat [ row; ": "; msg ])

let fail_cross row what =
  fail
    row
    (String.concat
       [ "Injection model cross-check disagrees on "
       ; what
       ; " -- report this to dv_lead per WO-0043 section 1; do not silently \
          adopt either derivation"
       ])
;;

(* WO-0043's own accounting note (bench.mli's docstring): family E's frames do
   NOT satisfy the clean-frame identity extent {!Bench.account_clean_frame}
   assumes (input - 8 - 4), because REQ-103 forbids FCS removal on the abort
   path. These two helpers are the family-E-shaped calls the docstring
   anticipates, built from the SAME public primitives {!Bench.account_clean_frame}
   itself uses -- no bench.ml addition. *)

(* An /E/-aborted frame that DID deliver at least one octet (M03-E1): still
   one emitted, aborted frame under section0.6, but its extent is
   [~expected_octets:delivered] rather than the clean-frame identity. *)
let account_aborted_frame bench (frame : Dv_xgmii.Arrival.frame) samples ~expected_octets =
  Dv_monitors.Conservation_monitor.frame_in (conservation bench);
  Dv_monitors.Conservation_monitor.frame_out (conservation bench) ~aborted:true;
  Dv_monitors.Octet_time.Latency.frame_in (latency bench) (Dv_xgmii.Arrival.in_times frame);
  let delivered_pairs = List.map (delivered_samples samples) ~f:(fun s -> s.cycle, s.out) in
  Dv_monitors.Octet_time.Latency.frame_out
    (latency bench)
    ~expected_octets
    (Dv_monitors.Octet_time.of_words delivered_pairs)
;;

(* A frame that delivered ZERO octets (M03-E2, section0.7): section0.6
   accounts for it through its STROBE, never through an "emitted" frame_out --
   this IS M03-E3's bench-side rule, made mechanical. [Latency.frame_dropped]
   pops the input frame without a comparison, exactly the "no tlast word to
   mark" case its own docstring names. *)
let account_dropped_frame bench (frame : Dv_xgmii.Arrival.frame) ~strobe =
  Dv_monitors.Conservation_monitor.frame_in (conservation bench);
  Dv_monitors.Conservation_monitor.discarded (conservation bench) ~strobes:[ strobe ];
  Dv_monitors.Octet_time.Latency.frame_in (latency bench) (Dv_xgmii.Arrival.in_times frame);
  Dv_monitors.Octet_time.Latency.frame_dropped (latency bench)
;;

(* Duplicated from test_m03_d.ml's own local helper of the same shape rather
   than shared, so this file has no dependency on another test file's private
   code -- {!Bench} is the only shared surface WO-0043 authorises. *)
let split_at_first_tlast words =
  let rec go acc = function
    | [] -> List.rev acc, []
    | (s : sample) :: rest ->
      if s.out.Dv_monitors.Stream_word.tlast
      then List.rev (s :: acc), rest
      else go (s :: acc) rest
  in
  go [] words
;;

(* ---- M03-E1 ------------------------------------------------------------ *)
(* "/E/ in each of the eight lanes of a mid-frame word of a 64-octet frame (8
   frames, lane-0 start; repeated at a lane-4 start): the last delivered octet
   is the one immediately preceding the /E/ (REQ-106 rule); tkeep marks
   exactly those octets; tuser[0] = 1 on the tlast word; exactly one
   error_bad_frame on the tlast cycle; no FCS removal." Sixteen cases. *)

(* Octets 24..31 of the 64-octet frame: comfortably inside the payload
   (0..59), eight octets clear of the frame's own first octet (0) and of the
   FCS (60..63) at every one of the eight lane positions below -- "a
   mid-frame word" with no ambiguity about which word that is. *)
let e1_word_octet0 = 24

let cross_check_e1
  ~row
  (o : Dv_xgmii.Injection.outcome)
  ~expected_delivered
  ~expected_words
  ~expected_tkeep
  ~expected_tlast_cycle
  ~expected_not_before
  ~expected_not_after
  =
  if o.Dv_xgmii.Injection.delivered <> expected_delivered then fail_cross row "delivered";
  if o.Dv_xgmii.Injection.words <> expected_words then fail_cross row "words";
  if o.Dv_xgmii.Injection.last_tkeep <> expected_tkeep then fail_cross row "last_tkeep";
  (match o.Dv_xgmii.Injection.tlast_cycle with
   | Some c when c = expected_tlast_cycle -> ()
   | _ -> fail_cross row "tlast_cycle");
  (match o.Dv_xgmii.Injection.reports with
   | [ r ]
     when String.equal r.Dv_xgmii.Injection.strobe "error_bad_frame"
          && r.Dv_xgmii.Injection.cycle = expected_tlast_cycle
          && r.Dv_xgmii.Injection.not_before = expected_not_before
          && r.Dv_xgmii.Injection.not_after = expected_not_after -> ()
   | _ -> fail_cross row "reports")
;;

let run_e1 ~lane ~e_lane =
  let e_octet_index = e1_word_octet0 + e_lane in
  (* REQ-106's rule with /E/ in place of /T/ (REQ-105): the octets strictly
     before the /E/ are delivered, the /E/'s own octet position is not. *)
  let delivered = e_octet_index in
  let final_word_full = Int.rem delivered 8 = 0 in
  let row =
    String.concat
      [ "M03-E1 (start lane "
      ; Int.to_string lane
      ; ", /E/ in lane "
      ; Int.to_string e_lane
      ; " of octets 24-31; final delivered word "
      ; (if final_word_full
         then "FULL -- section3's sampling declaration, R-1's disagreement class"
         else "partial")
      ; ")"
      ]
  in
  let base = directed_frame_octets ~length:64 in
  if not (Dv_xgmii.Frame.residue_ok base)
  then fail row "test bug -- the base 64-octet frame's own FCS does not check out";
  let case =
    Dv_xgmii.Injection.corrupt
      base
      [ Dv_xgmii.Injection.Place
          { placement = Dv_xgmii.Injection.At_octet e_octet_index
          ; character = Dv_xgmii.Xgmii_word.error_char
          }
      ]
  in
  let inj = Dv_xgmii.Injection.create ~first_lane:lane [ case ] in
  if not (Dv_xgmii.Injection.is_clean inj)
  then
    fail
      row
      (String.concat
         ~sep:"; "
         ("Injection construction errors:" :: Dv_xgmii.Injection.errors inj));
  let sched = Dv_xgmii.Injection.schedule inj in
  let frame = (Dv_xgmii.Arrival.frames sched).(0) in
  let start_cycle = Dv_xgmii.Arrival.start_cycle frame in
  let start_ot = frame.Dv_xgmii.Arrival.start_octet_time in
  (* SPEC-M03 section7's per-octet constant (h=8/12, L=16/12, both give
     ΔC=3): output word m leaves on start_cycle+3+m while the frame is being
     delivered gaplessly, which every octet before the /E/ is. The frame's
     tlast word is therefore word (words-1). *)
  let words = (delivered + 7) / 8 in
  let expected_tlast_cycle = start_cycle + 3 + (words - 1) in
  let expected_tkeep =
    if Int.rem delivered 8 = 0 then 0xFF else (1 lsl Int.rem delivered 8) - 1
  in
  (* requirements.md section0.6's strobe window: not earlier than the cycle
     the condition becomes decidable (the input word carrying the /E/), not
     later than ΔC=3 after the input word carrying the frame's LAST octet. *)
  let closing_ot = start_ot + 8 + e_octet_index in
  let closing_cycle = closing_ot / 8 in
  let last_octet_cycle = (start_ot + 8 + delivered - 1) / 8 in
  let expected_not_before = closing_cycle in
  let expected_not_after = last_octet_cycle + 3 in
  let outcome = List.hd_exn (Dv_xgmii.Injection.outcomes inj) in
  cross_check_e1
    ~row
    outcome
    ~expected_delivered:delivered
    ~expected_words:words
    ~expected_tkeep
    ~expected_tlast_cycle
    ~expected_not_before
    ~expected_not_after;
  (* Positive stimulus check before trusting anything below: the /E/ actually
     lands where this row means it to, before a single cycle is driven. *)
  let e_lane_in_word = Int.rem closing_ot 8 in
  let pre_run_word = Dv_xgmii.Injection.word_at inj ~cycle:closing_cycle in
  if (not (Dv_xgmii.Xgmii_word.is_control pre_run_word e_lane_in_word))
     || not
          (Int.equal
             (pre_run_word.Dv_xgmii.Xgmii_word.data).(e_lane_in_word)
             Dv_xgmii.Xgmii_word.error_char)
  then fail row "test bug -- the /E/ does not land at the intended octet time before driving";
  let bench = create () in
  Dv_monitors.Strobe_monitor.expect
    (strobes bench)
    { Dv_monitors.Strobe_monitor.strobe = "error_bad_frame"
    ; frame = 0
    ; cycle = expected_tlast_cycle
    ; not_before = expected_not_before
    ; not_after = expected_not_after
    ; why =
        "REQ-105 (error character while the frame is open, >= 1 octet \
         delivered); SPEC-M03 section 9 'Strobe cycle, pinned' puts it on the \
         frame's own tlast cycle, start_cycle + 3 + (words - 1) via section 7's \
         per-octet constant (gap-invariant up to the /E/, not the section 6.1 \
         m+3 gloss)"
    };
  let samples = run bench sched ~drain:8 ~word_at:(fun ~cycle -> Dv_xgmii.Injection.word_at inj ~cycle) () in
  let out_words = delivered_samples samples in
  if List.length out_words <> words
  then
    fail
      row
      (String.concat
         [ "expected "
         ; Int.to_string words
         ; " output words, got "
         ; Int.to_string (List.length out_words)
         ]);
  let expected_delivered_octets = List.take base delivered in
  let got_octets = delivered_octets samples in
  if not (List.equal Int.equal got_octets expected_delivered_octets)
  then
    fail
      row
      "delivered octets differ from the octets immediately preceding the /E/ \
       (REQ-106 rule); a design applying FCS removal on the abort path would \
       be four octets short here (REQ-103, E-c1)";
  (match tlast_sample samples with
   | None -> fail row "no tlast word observed"
   | Some s ->
     if s.cycle <> expected_tlast_cycle
     then
       fail
         row
         (String.concat
            [ "tlast word arrived on cycle "
            ; Int.to_string s.cycle
            ; ", expected "
            ; Int.to_string expected_tlast_cycle
            ]);
     if s.out.Dv_monitors.Stream_word.tkeep <> expected_tkeep
     then
       fail
         row
         (String.concat
            [ "tlast tkeep = "
            ; Int.to_string s.out.Dv_monitors.Stream_word.tkeep
            ; ", expected "
            ; Int.to_string expected_tkeep
            ]);
     if s.out.Dv_monitors.Stream_word.tuser <> 1
     then fail row "tuser[0] is not set on an /E/-aborted frame (REQ-105)");
  (match error_pulses samples with
   | [ (cycle, name) ] ->
     if not (String.equal name "error_bad_frame")
     then fail row (String.concat [ "expected error_bad_frame, observed "; name ])
     else if cycle <> expected_tlast_cycle
     then
       fail
         row
         (String.concat
            [ "error_bad_frame pulsed on cycle "
            ; Int.to_string cycle
            ; ", expected "
            ; Int.to_string expected_tlast_cycle
            ])
   | pulses ->
     fail
       row
       (String.concat
          [ "expected exactly one strobe pulse (error_bad_frame only), observed "
          ; Int.to_string (List.length pulses)
          ]));
  account_aborted_frame bench frame samples ~expected_octets:delivered;
  Dv_monitors.Conservation_monitor.strobe_pulse (conservation bench) ~name:"error_bad_frame";
  assert_monitors_clean bench ~row
;;

let%expect_test
  "M03-E1: /E/ in each of the eight lanes of a mid-frame word, both start \
   lanes -- sixteen cases (REQ-105, REQ-103's no-removal clause)"
  =
  List.iter [ 0; 4 ] ~f:(fun lane ->
    List.iter (List.range 0 8) ~f:(fun e_lane -> run_e1 ~lane ~e_lane));
  [%expect {||}]
;;

(* ---- M03-E2 (and M03-E3, declared below) -------------------------------- *)
(* "/E/ at exactly the frame's first octet position (zero delivered octets):
   no output word at all; exactly one error_bad_frame, on the cycle two after
   the input word carrying the /E/ -- section9's own no-output-word clause, a
   pin in its own right, not a corollary of m+3." *)

let cross_check_e2
  ~row
  (o : Dv_xgmii.Injection.outcome)
  ~expected_pulse_cycle
  ~expected_not_before
  ~expected_not_after
  =
  if o.Dv_xgmii.Injection.delivered <> 0 then fail_cross row "delivered (expected 0)";
  (match o.Dv_xgmii.Injection.tlast_cycle with
   | None -> ()
   | Some _ -> fail_cross row "tlast_cycle (expected None -- section0.7, no tlast word)");
  (match o.Dv_xgmii.Injection.reports with
   | [ r ]
     when String.equal r.Dv_xgmii.Injection.strobe "error_bad_frame"
          && r.Dv_xgmii.Injection.cycle = expected_pulse_cycle
          && r.Dv_xgmii.Injection.not_before = expected_not_before
          && r.Dv_xgmii.Injection.not_after = expected_not_after -> ()
   | _ -> fail_cross row "reports")
;;

let run_e2 ~lane =
  let row = String.concat [ "M03-E2 (lane "; Int.to_string lane; ")" ] in
  let base = directed_frame_octets ~length:64 in
  if not (Dv_xgmii.Frame.residue_ok base)
  then fail row "test bug -- the base 64-octet frame's own FCS does not check out";
  let case =
    Dv_xgmii.Injection.corrupt
      base
      [ Dv_xgmii.Injection.Place
          { placement = Dv_xgmii.Injection.At_octet 0
          ; character = Dv_xgmii.Xgmii_word.error_char
          }
      ]
  in
  let inj = Dv_xgmii.Injection.create ~first_lane:lane [ case ] in
  if not (Dv_xgmii.Injection.is_clean inj)
  then
    fail
      row
      (String.concat
         ~sep:"; "
         ("Injection construction errors:" :: Dv_xgmii.Injection.errors inj));
  let sched = Dv_xgmii.Injection.schedule inj in
  let frame = (Dv_xgmii.Arrival.frames sched).(0) in
  let start_ot = frame.Dv_xgmii.Arrival.start_octet_time in
  (* The /E/ replaces the frame's own first octet (index 0), which arrives at
     octet time start_ot + 8 at BOTH start lanes (section6.1: the frame's
     first octet is always exactly 8 octet times after the start character).
     section9's no-output-word pin: two cycles after that input word. *)
  let closing_ot = start_ot + 8 in
  let closing_cycle = closing_ot / 8 in
  let expected_pulse_cycle = closing_cycle + 2 in
  let expected_not_before = closing_cycle in
  let expected_not_after = closing_cycle + 3 in
  let outcome = List.hd_exn (Dv_xgmii.Injection.outcomes inj) in
  cross_check_e2 ~row outcome ~expected_pulse_cycle ~expected_not_before ~expected_not_after;
  let e_lane_in_word = Int.rem closing_ot 8 in
  let pre_run_word = Dv_xgmii.Injection.word_at inj ~cycle:closing_cycle in
  if (not (Dv_xgmii.Xgmii_word.is_control pre_run_word e_lane_in_word))
     || not
          (Int.equal
             (pre_run_word.Dv_xgmii.Xgmii_word.data).(e_lane_in_word)
             Dv_xgmii.Xgmii_word.error_char)
  then fail row "test bug -- the /E/ does not land at the intended octet time before driving";
  let bench = create () in
  Dv_monitors.Strobe_monitor.expect
    (strobes bench)
    { Dv_monitors.Strobe_monitor.strobe = "error_bad_frame"
    ; frame = 0
    ; cycle = expected_pulse_cycle
    ; not_before = expected_not_before
    ; not_after = expected_not_after
    ; why =
        "REQ-105 / requirements.md section 0.7 / SPEC-M03 section 9 row 2 and \
         the no-output-word pin (section 9 'Strobe cycle, pinned'): zero \
         delivered octets, so the strobe is two cycles after the input word \
         carrying the /E/, not on any tlast cycle (it has none)"
    };
  let samples =
    run bench sched ~drain:8 ~word_at:(fun ~cycle -> Dv_xgmii.Injection.word_at inj ~cycle) ()
  in
  (* WO-0043 section2's binding instruction: assert NOTHING about tuser[0] --
     not 0, not 1. There is no tlast word for the bit to live on, and this is
     the only thing this row asserts about the output stream's content. *)
  (match tlast_sample samples with
   | Some _ ->
     fail row "a tlast word was observed for a frame that must deliver nothing (section0.7, E-c2)"
   | None -> ());
  if not (List.is_empty (delivered_samples samples))
  then fail row "a tvalid word was observed for a frame that must deliver nothing";
  (match error_pulses samples with
   | [ (cycle, name) ] ->
     if not (String.equal name "error_bad_frame")
     then fail row (String.concat [ "expected error_bad_frame, observed "; name ])
     else if cycle <> expected_pulse_cycle
     then
       fail
         row
         (String.concat
            [ "error_bad_frame pulsed on cycle "
            ; Int.to_string cycle
            ; ", expected "
            ; Int.to_string expected_pulse_cycle
            ])
   | pulses ->
     fail
       row
       (String.concat
          [ "expected exactly one strobe pulse (error_bad_frame only), observed "
          ; Int.to_string (List.length pulses)
          ]));
  (* M03-E3's bench-side rule, made mechanical rather than merely declared:
     this frame is accounted through its STROBE, never through the
     clean-frame/abort-marked path -- see the declaration immediately below
     this test. *)
  account_dropped_frame bench frame ~strobe:"error_bad_frame";
  Dv_monitors.Conservation_monitor.strobe_pulse (conservation bench) ~name:"error_bad_frame";
  assert_monitors_clean bench ~row
;;

let%expect_test
  "M03-E2: /E/ at the frame's first octet position -- no output word, \
   exactly one error_bad_frame two cycles after the /E/'s input word \
   (REQ-105, requirements section 0.7, SPEC-M03 section 9 row 2)"
  =
  run_e2 ~lane:0;
  run_e2 ~lane:4;
  [%expect {||}]
;;

(* ---- M03-E3 (NO-ASSERT) -------------------------------------------------- *)
(* "A monitor asserting 'every abort is marked on a tlast word' must not be
   driven for E2's frame -- REQ-105's own verification column says so, and
   section0.6 accounts for the frame by its strobe instead." (a bench-side
   rule, not a design property).

   Discharged above by [run_e2]'s own accounting DISCIPLINE, not by a
   separate test function: E2's frame is accounted to the conservation
   monitor through [Conservation_monitor.discarded] (the strobe path, via
   [account_dropped_frame]), never through [Conservation_monitor.frame_out
   ~aborted:true] (the clean-frame/abort-marked path {!Bench.account_clean_frame}
   uses for every other row in this suite) -- and [run_e2] never reads a
   [tlast_sample]'s [tuser] field for this frame, because [tlast_sample]
   returns [None] (asserted above) and there is nothing to read. There is
   nothing further to run for this row; a monitor driven the forbidden way
   would be a false green, which is exactly what this file does not build. *)

(* ---- M03-E4 -------------------------------------------------------------- *)
(* "/E/ after a terminate character, in the gap between two frames: nothing
   emitted, no strobe of any kind, and the following frame received intact."
   WO-0043 section4's trap answer 3: not expressible as an [Injection]
   [corruption] (the gap lies outside every frame's own [placement] space), so
   this row is built from two ordinary clean frames plus {!Bench.run}'s
   [?word_at] hook, exactly test_m03_b.ml's own [preamble_override] pattern. *)

let run_e4 ~lane =
  let row = String.concat [ "M03-E4 (lane "; Int.to_string lane; ")" ] in
  let octets0 = directed_frame_octets ~length:64 in
  let octets1 = directed_frame_octets ~length:68 in
  if not (Dv_xgmii.Frame.residue_ok octets0)
  then fail row "test bug -- frame 1's own FCS does not check out";
  if not (Dv_xgmii.Frame.residue_ok octets1)
  then fail row "test bug -- frame 2's own FCS does not check out";
  let sched = frames_at ~lane ~fcs_valid:true [ octets0; octets1 ] in
  let frames = Dv_xgmii.Arrival.frames sched in
  let frame0 = frames.(0) in
  let frame1 = frames.(1) in
  let terminate0 = Dv_xgmii.Arrival.terminate_octet_time frame0 in
  let start1 = frame1.Dv_xgmii.Arrival.start_octet_time in
  (* requirements.md section0.3: the minimum inter-frame gap, counted from the
     terminate character inclusive, is 12 octets, so terminate0 + 5 sits
     strictly inside every gap {!Bench.frames_at}'s default ifg produces --
     with margin from the /T/ at terminate0 and the /S/ at start1 alike. *)
  let e_octet_time = terminate0 + 5 in
  if not (e_octet_time > terminate0 && e_octet_time < start1)
  then fail row "test bug -- the chosen gap octet time is not strictly inside the inter-frame gap";
  let e_cycle = e_octet_time / 8 in
  let gap_lane = Int.rem e_octet_time 8 in
  let word_at ~cycle =
    let base_word = Dv_xgmii.Arrival.word_at sched ~cycle in
    if cycle <> e_cycle
    then base_word
    else
      { Dv_xgmii.Xgmii_word.data =
          Array.mapi base_word.Dv_xgmii.Xgmii_word.data ~f:(fun lane_idx v ->
            if lane_idx = gap_lane then Dv_xgmii.Xgmii_word.error_char else v)
      ; control = base_word.Dv_xgmii.Xgmii_word.control
      }
  in
  (* WO-0043 section2's binding instruction, generalised from the
     residue_ok-both-directions lesson: verify the /E/ actually lands before
     trusting the negative assertion below -- first from the stimulus's own
     words (pre-run), then from the sample {!Bench.run} actually drove. *)
  let pre_run_word = word_at ~cycle:e_cycle in
  if (not (Dv_xgmii.Xgmii_word.is_control pre_run_word gap_lane))
     || not
          (Int.equal (pre_run_word.Dv_xgmii.Xgmii_word.data).(gap_lane) Dv_xgmii.Xgmii_word.error_char)
  then fail row "test bug -- the /E/ does not land at the intended gap cycle/lane before driving";
  let bench = create () in
  let samples = run bench sched ~drain:8 ~word_at () in
  (match List.find samples ~f:(fun s -> s.cycle = e_cycle) with
   | None -> fail row "test bug -- the intended gap cycle was never driven"
   | Some s ->
     if (not (Dv_xgmii.Xgmii_word.is_control s.in_word gap_lane))
        || not (Int.equal (s.in_word.Dv_xgmii.Xgmii_word.data).(gap_lane) Dv_xgmii.Xgmii_word.error_char)
     then
       fail
         row
         "the driven word at the intended cycle does not carry the /E/ this row means to test \
          -- the negative assertion below would be vacuous");
  (* NOW the negative assertion: nothing at all was reported for it (REQ-105's
     closure clause, C-12, E-c4). *)
  if not (List.is_empty (error_pulses samples))
  then
    fail
      row
      "an error strobe pulsed for an /E/ that arrived with no frame open (REQ-105's closure \
       clause, C-12, E-c4)";
  let words0, rest = split_at_first_tlast (delivered_samples samples) in
  let words1, _ = split_at_first_tlast rest in
  if List.is_empty words0 || List.is_empty words1
  then fail row "expected two delivered frames (one tlast word each), got fewer";
  List.iter [ words0; words1 ] ~f:(fun ws ->
    let last = List.last_exn ws in
    if last.out.Dv_monitors.Stream_word.tuser <> 0
    then fail row "tuser[0] set on a frame the gap /E/ must not touch");
  let expected0 = Dv_xgmii.Frame.delivered octets0 in
  let expected1 = Dv_xgmii.Frame.delivered octets1 in
  let got0 = List.concat_map words0 ~f:(fun (s : sample) -> Dv_monitors.Stream_word.octets s.out) in
  let got1 = List.concat_map words1 ~f:(fun (s : sample) -> Dv_monitors.Stream_word.octets s.out) in
  if not (List.equal Int.equal got0 expected0)
  then fail row "frame 1's delivered octets differ from its own 60 -- the gap /E/ must not touch it";
  if not (List.equal Int.equal got1 expected1)
  then fail row "frame 2's delivered octets differ from its own 64 -- it must arrive intact";
  account_clean_frame bench frame0 words0 ~aborted:false;
  account_clean_frame bench frame1 words1 ~aborted:false;
  assert_monitors_clean bench ~row
;;

let%expect_test
  "M03-E4: /E/ after a terminate character, in the inter-frame gap -- \
   nothing emitted, no strobe, following frame intact (REQ-105's closure \
   clause, REQ-113, C-12)"
  =
  run_e4 ~lane:0;
  run_e4 ~lane:4;
  [%expect {||}]
;;

(* ---- M03-E5 (folded in by WO-0047 section1.2) ---------------------------- *)
(* "An /E/ in a preamble position (1..7) at a lane-0 start -- a frame opened
   and closed inside ONE input word, zero delivered octets | No output word
   at all; exactly one error_bad_frame, on section9's no-output-word pin (two
   cycles after the input word carrying the /E/); nothing else asserted
   about tuser[0], which has no tlast word to live on (section4.1, and the
   M03-E2 prohibition applies unchanged)." REQ-105, section9's closure list,
   section6.2's Frame row.

   At a LANE-0 start every preamble position 1..7 lies inside the frame's
   OWN start word (section6.1: "at a lane-0 start all eight preamble
   positions are lanes 0...7 of the start word itself"), so an /E/ at any of
   them is exactly "a frame opened and closed inside one input word" -- the
   WO-0045 seeder's finding (`J-dv_lead-0054`): this stimulus takes an
   in-word path with no payload datapath at all, structurally distinct from
   the epoch-A path M03-E1/E2 exercise, and no family-E row before this one
   drove it. M03-B2 drives a SINGLE preamble-position /E/ at each lane
   (position 3 -- "lane 3 of a lane-0 start word") as part of a different
   argument (REQ-102's routing); this row sweeps every position 1..7 at lane
   0 specifically because that in-word path is what is at issue here, not
   the routing decision B2 makes. Positions 1..7, LANE 0 ONLY -- WO-0047
   section2 names lane 0 explicitly and no other; a lane-4 start's preamble
   spans TWO input words (positions 1-3 in the start word, 4-7 in the next),
   a different, already-two-word shape this row is not about.

   Hand-derived (WO-0047 section1.3): every preamble position 1..7 places the
   /E/ inside octet times [start_ot + 1 .. start_ot + 7], all seven of which
   lie in the SAME cycle as the start character itself (the whole of a
   lane-0 preamble occupies one word, section6.1) -- so section9's
   no-output-word pin and requirements.md section0.6's window are IDENTICAL
   across all seven positions: pulse at start_cycle + 2, window
   [start_cycle, start_cycle + 3]. Cross-checked against
   [Dv_xgmii.Injection]'s own [outcomes] ([cross_check_e5], reusing this
   file's own [fail_cross] wording per WO-0047 section1.3) rather than
   trusted from a single hand computation alone.

   Verified at BOTH failure sites (WO-0047 section6 item7, this file's own
   [run_e4] precedent): the /E/'s presence is checked in the pre-run schedule
   word (construction) and again in the cycle {!run} ACTUALLY drove
   (post-run). Assertion order: is_clean, the model cross-check, the
   pre-run placement check, [run], the post-run placement check, the two
   structural no-output facts ([tlast_sample] = [None], [delivered_samples]
   = []), then the exact strobe set (error_bad_frame alone) --
   construction/landing facts first, structural facts next, the strobe fact
   last. Iteration order: positions 1, 2, ..., 7 ascending, via [List.range]
   (a concrete list, iterated by [List.iter] in order -- WO-0047 section6
   item4). *)

let cross_check_e5
  ~row
  (o : Dv_xgmii.Injection.outcome)
  ~expected_pulse_cycle
  ~expected_not_before
  ~expected_not_after
  =
  if o.Dv_xgmii.Injection.delivered <> 0 then fail_cross row "delivered (expected 0)";
  (match o.Dv_xgmii.Injection.tlast_cycle with
   | None -> ()
   | Some _ -> fail_cross row "tlast_cycle (expected None -- section0.7, no tlast word)");
  (match o.Dv_xgmii.Injection.reports with
   | [ r ]
     when String.equal r.Dv_xgmii.Injection.strobe "error_bad_frame"
          && r.Dv_xgmii.Injection.cycle = expected_pulse_cycle
          && r.Dv_xgmii.Injection.not_before = expected_not_before
          && r.Dv_xgmii.Injection.not_after = expected_not_after -> ()
   | _ -> fail_cross row "reports")
;;

let run_e5 ~position =
  let row =
    String.concat [ "M03-E5 (preamble position "; Int.to_string position; ", lane 0)" ]
  in
  let base = directed_frame_octets ~length:64 in
  if not (Dv_xgmii.Frame.residue_ok base)
  then fail row "test bug -- the base 64-octet frame's own FCS does not check out";
  let case =
    Dv_xgmii.Injection.corrupt
      base
      [ Dv_xgmii.Injection.Place
          { placement = Dv_xgmii.Injection.At_preamble position
          ; character = Dv_xgmii.Xgmii_word.error_char
          }
      ]
  in
  let inj = Dv_xgmii.Injection.create ~first_lane:0 [ case ] in
  if not (Dv_xgmii.Injection.is_clean inj)
  then
    fail
      row
      (String.concat
         ~sep:"; "
         ("Injection construction errors:" :: Dv_xgmii.Injection.errors inj));
  let sched = Dv_xgmii.Injection.schedule inj in
  let frame = (Dv_xgmii.Arrival.frames sched).(0) in
  let start_cycle = Dv_xgmii.Arrival.start_cycle frame in
  let start_ot = frame.Dv_xgmii.Arrival.start_octet_time in
  let closing_ot = start_ot + position in
  let closing_cycle = closing_ot / 8 in
  if closing_cycle <> start_cycle
  then
    fail
      row
      "test bug -- the preamble position does not land in the start word's own cycle \
       (section6.1: every lane-0 preamble position lies in the start word)";
  let expected_pulse_cycle = closing_cycle + 2 in
  let expected_not_before = closing_cycle in
  let expected_not_after = closing_cycle + 3 in
  let outcome = List.hd_exn (Dv_xgmii.Injection.outcomes inj) in
  cross_check_e5 ~row outcome ~expected_pulse_cycle ~expected_not_before ~expected_not_after;
  let e_lane_in_word = Int.rem closing_ot 8 in
  let pre_run_word = Dv_xgmii.Injection.word_at inj ~cycle:closing_cycle in
  if (not (Dv_xgmii.Xgmii_word.is_control pre_run_word e_lane_in_word))
     || not
          (Int.equal
             (pre_run_word.Dv_xgmii.Xgmii_word.data).(e_lane_in_word)
             Dv_xgmii.Xgmii_word.error_char)
  then fail row "test bug -- the /E/ does not land at the intended preamble position before driving";
  let bench = create () in
  Dv_monitors.Strobe_monitor.expect
    (strobes bench)
    { Dv_monitors.Strobe_monitor.strobe = "error_bad_frame"
    ; frame = 0
    ; cycle = expected_pulse_cycle
    ; not_before = expected_not_before
    ; not_after = expected_not_after
    ; why =
        "REQ-105 (error character at or before the frame's first octet, including a \
         preamble position); SPEC-M03 section9 row 3 and the no-output-word pin \
         (section9 'Strobe cycle, pinned'): two cycles after the input word carrying \
         the /E/, which for every preamble position 1..7 at a lane-0 start is the \
         start word itself"
    };
  let samples =
    run bench sched ~drain:8 ~word_at:(fun ~cycle -> Dv_xgmii.Injection.word_at inj ~cycle) ()
  in
  (match List.find samples ~f:(fun s -> s.cycle = closing_cycle) with
   | None -> fail row "test bug -- the intended closing cycle was never driven"
   | Some s ->
     if (not (Dv_xgmii.Xgmii_word.is_control s.in_word e_lane_in_word))
        || not
             (Int.equal
                (s.in_word.Dv_xgmii.Xgmii_word.data).(e_lane_in_word)
                Dv_xgmii.Xgmii_word.error_char)
     then
       fail
         row
         "the driven word at the intended cycle does not carry the /E/ this row means \
          to test -- the no-output-word assertion below would be vacuous");
  (match tlast_sample samples with
   | Some _ ->
     fail row "a tlast word was observed for a frame that must deliver nothing (section0.7, E5)"
   | None -> ());
  if not (List.is_empty (delivered_samples samples))
  then fail row "a tvalid word was observed for a frame that must deliver nothing";
  (match error_pulses samples with
   | [ (cycle, name) ] ->
     if not (String.equal name "error_bad_frame")
     then fail row (String.concat [ "expected error_bad_frame, observed "; name ])
     else if cycle <> expected_pulse_cycle
     then
       fail
         row
         (String.concat
            [ "error_bad_frame pulsed on cycle "
            ; Int.to_string cycle
            ; ", expected "
            ; Int.to_string expected_pulse_cycle
            ])
   | pulses ->
     fail
       row
       (String.concat
          [ "expected exactly one strobe pulse (error_bad_frame only), observed "
          ; Int.to_string (List.length pulses)
          ]));
  account_dropped_frame bench frame ~strobe:"error_bad_frame";
  Dv_monitors.Conservation_monitor.strobe_pulse (conservation bench) ~name:"error_bad_frame";
  assert_monitors_clean bench ~row
;;

let%expect_test
  "M03-E5: /E/ at preamble positions 1..7, lane-0 start -- a frame opened \
   and closed inside one input word, no output word at all, exactly one \
   error_bad_frame at section9's no-output-word pin (REQ-105, WO-0047 \
   section1.2)"
  =
  List.iter (List.range 1 8) ~f:(fun position -> run_e5 ~position);
  [%expect {||}]
;;
