(** Family F — runt frames (REQ-107, §0.7). WO-0047.

    Five rows named (`AP-xgmii_rx_64.md` §4.F): M03-F1 (ASSERT, [run_f1]),
    M03-F2 (ASSERT, [run_f2]), M03-F3 (ASSERT, [run_f3]), M03-F4 (ASSERT,
    [run_f4]), M03-F5 — **discharged by citation to M03-C4, not built here**
    (WO-0047 §3.3; see the note at the bottom of this file). M03-E5 is folded
    into this packet by WO-0047 §1.2 but lives in `test_m03_e.ml`, beside its
    own family (REQ-105), not here.

    {2 What is actually unverified, and what this family closes (WO-0047 §1.1)}

    M03-C4 already drives the 5-octet runt at both start lanes and asserts
    strictly more than a dedicated F5 row would (§3.3 below). REQ-107's report
    path is therefore already verified at five octets. What this family closes
    is the sub-five-octet class the WO's own **F-c5** defect names: a frame
    below five octets silently dropped with no strobe at all — REQ-008
    forbids it and §9's sixth row requires `error_runt`, and nothing in the
    suite before this packet would have noticed.

    {2 WO-0047 §1.3's binding instruction, and how this file honours it}

    Every expected value below is derived BY HAND from SPEC-M03 §6.1, §7, §9
    (the closure list, the co-occurrence rulings, the "Strobe cycle, pinned"
    paragraph and its no-output-word clause) and requirements.md §0.3, §0.6,
    §0.7, REQ-103, REQ-104, REQ-107, REQ-008. `Dv_xgmii.Injection`'s computed
    [outcome] is used only as a {b reported cross-check} ([cross_check_f2]
    below, for the one row here built through [Injection]) — following the
    same rule WO-0043 (`test_m03_e.ml`) established: a row hand-derived this
    way is not co-sim-gated and a row resting on the model's own number would
    be. M03-F1, F3 and F4 need no [Injection] cross-check for the same reason
    `test_m03_e.ml`'s M03-E4 needed none — they are built directly through
    {!Bench.frames_at}/{!Bench.one_frame}, never through [Injection], so there
    is no model output to cross-check against; only M03-F2 touches
    [Injection] and only M03-F2 gets one.

    {2 WO-0047 §4.1's trap — established empirically, not merely read}

    The comment at `test/xgmii/injection.ml`'s `Arrival.create` call
    (`test/xgmii/injection.ml:136-139`) says `Arrival.check`'s sub-five-octet
    complaint — {e "a frame below five octets delivers nothing (REQ-107) and
    is an injection case, not a schedule case"} (`test/xgmii/arrival.ml:160-166`)
    — is filtered "here and nowhere else", naming rows **F2 and F5**.

    {b The predicate itself} (`test/xgmii/arrival.ml:160`,
    [Array.length f.octets < 5]) is exactly REQ-107's own boundary — strictly
    {e fewer} than five, not "five or fewer" — confirmed directly: a bare
    5-octet frame array raises zero complaints from [Arrival.check] (verified
    against `test/xgmii`'s own, Hardcaml-free sources with the system
    `ocamlc`, standalone, before this file was written — see the Return log
    for the exact commands and output). {b So the comment naming F5 is
    LOOSE, not the predicate}: F5's frame is five octets, `5 < 5` is false,
    and the sub-five complaint is never raised for it in the first place —
    there is nothing there for [Injection]'s filter to catch. The predicate
    is not looser than REQ-107's own line; the comment's own naming of "F2
    {b and F5}" over-states what actually needs filtering.

    {b A second, load-bearing finding, beyond the comment/predicate question
    the packet asked}: even for F2 (whose frames genuinely ARE below five
    octets), building the schedule via [Injection.create]
    ([Injection.clean (Injection.frame_of_length n)] for [n < 5], the reading
    `frame_of_length`'s own doc invites and `test_injection.ml`'s own X-1 unit
    test exercises at [n = 4]) does {b not} make that schedule drivable
    through {!Bench.run}. [Injection.create]'s filtering is local to ITS OWN
    [errors]/[is_clean] — it never touches the underlying [Arrival.t] a
    schedule carries. {!Bench.run} calls [Arrival.check] a SECOND time,
    independently and unfiltered (`bench.ml`'s own standing-obligation-5
    gate), and that second call reproduces the identical "is an injection
    case, not a schedule case" complaint — which {!Bench.run} then reports as
    "Bench.run: Arrival.check found an unconformant schedule", indistinguishable
    from a genuine stimulus defect. Confirmed empirically (Return log): the
    exact same [Injection.create] call that reports [is_clean = true] hands
    back a schedule on which a second, independent [Arrival.check] call finds
    one problem, verbatim.

    M03-F2 below is therefore built the OTHER way [Injection] supports: a
    [Place { placement = At_octet k; character = Xgmii_word.terminate_char }]
    corruption replaces octet [k] of a normal, {e Arrival-legal} (>= 5 octet)
    base frame with an early `/T/`. This leaves the schedule's own recorded
    frame length untouched — [Arrival.check] has nothing to complain about,
    confirmed clean both at construction and under a second, independent
    check — while the WIRE the DUT actually sees closes the frame after
    exactly [k] received octets, [k] = 0, 1 or 4. This is still "built through
    Injection" in the sense WO-0047 §4.1 requires (the placement machinery is
    [Injection]'s), and it is the one construction of the three that
    {!Bench.run} actually accepts. [k] = "received octets before the
    injected `/T/`" is exactly REQ-107's own count, confirmed against
    [Injection.outcomes]' own [received] field.

    {2 WO-0047 §6 item 7 — verified at BOTH failure sites}

    M03-F2 checks the injected `/T/`'s presence twice: once in the pre-run
    schedule word (construction), and once in the sample {!Bench.run}
    ACTUALLY drove (post-run) — `test_m03_e.ml`'s [run_e4] precedent, applied
    here because [Injection]'s placement machinery is new territory for this
    row and a silently-unlanded override would read exactly like a genuine
    F-c5 kill while being nothing of the kind.

    {2 M03-F2's tuser prohibition (WO-0047 §2, generalised from M03-E2)}

    [run_f2] asserts NOTHING about [tuser] — not 0, not 1: SPEC-M03 §4.1
    makes the bit meaningful only on the [tlast] word and this frame has
    none. The structural facts are asserted instead ([tlast_sample] is
    [None], [delivered_samples] is empty), and the frame is accounted for
    through its STROBE ({!Bench.account_dropped_frame}).

    {2 Independence}

    Every expected value is read from `docs/specs/modules/xgmii_rx_64.md`
    §6.1, §6.2, §6.3, §7, §9 and `docs/specs/requirements.md` §0.3, §0.6,
    §0.7, REQ-008, REQ-013, REQ-103, REQ-104, REQ-107 — cited inline — plus
    `test/xgmii/injection.ml`, `test/xgmii/injection.mli` and
    `test/xgmii/arrival.ml`/`.mli` (read for the §4.1 trap and the
    construction this file uses; all under `test/`, not `libs/`).
    `test/attack_plans/AP-xgmii_rx_64.md` §4.F and `test/xgmii_rx_64/bench.ml`
    /`.mli`, `test_m03_c.ml` and `test_m03_d.ml` (read as idiom reference,
    named where a pattern is reused). `libs/**`, `top/**`, `bin/**` and
    `rtl_snapshots/**` were not opened. *)

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

(* {!Bench.account_dropped_frame}: a frame that delivered ZERO octets is
   accounted for through its STROBE, never through an "emitted" frame_out --
   this is M03-E3's rule, restated as binding for every no-output-word frame
   by WO-0047 section2. *)
(* ---- M03-F1 ---------------------------------------------------------- *)
(* "Frames of 5, 16, 60 and 63 octets DA through FCS, correct FCS, both start
   lanes | Delivered 1, 12, 56 and 59; tuser[0] = 1 on each tlast word;
   exactly one error_runt per frame on the tlast cycle and no other strobe;
   the FCS is removed and checked -- these frames end with /T/, so REQ-103
   applies." REQ-107, REQ-103.

   5, 16, 60 and 63 octets give final-word fills 1, 4, 8 and 3 (WO-0047 §2's
   own sampling declaration) -- 56 delivered (length 60) is therefore the
   FULL-final-word member and, at lane 4 only (its terminate lands in lane 0
   there: (12 + 60) mod 8 = 0, the "C-18 twin" terminate-lane-0 shape), it is
   a second instance of BUG-0001/R-1's Before/After sampling-view disagreement
   class `test_m03_c.ml` already demonstrates and asserts for M03-C1/C2's
   68-octet/lane-4 entry and M03-C5's 1516-octet/lane-4 entry
   ([views_disagree_on_tlast]/[check_disagreement_matches_r1]). Stated here
   because WO-0047 §2 asks it stated, not re-asserted: every check below
   reads the [Before] view exclusively (`bench.ml`'s own asserted convention,
   RV-0038-R6), which the disagreement is specifically ABOUT the [After] view
   missing, so it does not touch anything this row asserts.

   Assertion order (WO-0047 §4.2): output-word COUNT, the [tlast] word's own
   CYCLE, its [tkeep], its [tuser] (single bit, forwarded and marked
   invalid), the delivered-octet CONTENT (proves REQ-103's FCS removal
   happened at every length), then the EXACT strobe set (error_runt alone --
   proves the FCS was actually CHECKED, at this 5-63-octet length, and found
   good, since a correct-FCS runt pulses no error_bad_fcs). Structural facts
   first, the FCS-removed-and-checked claim (this row's own text) last.
   Iteration order: lane 0 then lane 4 (outer), lengths 5, 16, 60, 63
   ascending (inner) -- the packet's own stated order, via [List.iter] over
   literal lists (never [List.init]), so evaluation order is exactly
   left-to-right as written (WO-0047 §6 item 4). *)

let f1_lengths = [ 5; 16; 60; 63 ]

let run_f1 ~lane ~length =
  let delivered = length - 4 in
  let words = (delivered + 7) / 8 in
  let final_fill =
    let r = Int.rem delivered 8 in
    if r = 0 then 8 else r
  in
  let row =
    String.concat
      [ "M03-F1 (lane "
      ; Int.to_string lane
      ; ", length "
      ; Int.to_string length
      ; ", delivered "
      ; Int.to_string delivered
      ; ", final word fill "
      ; Int.to_string final_fill
      ; if length = 60 && lane = 4
        then
          " -- R-1's disagreement class: terminate_lane 0, full final word \
           (BUG-0001, RV-0038-R7), harmless here (Before-view only)"
        else ""
      ; ")"
      ]
  in
  let octets = directed_frame_octets ~length in
  if not (Dv_xgmii.Frame.residue_ok octets)
  then fail row "test bug -- the frame's own FCS does not check out";
  let sched = one_frame ~lane octets in
  let frame = (Dv_xgmii.Arrival.frames sched).(0) in
  let start_cycle = Dv_xgmii.Arrival.start_cycle frame in
  let closing_ot = Dv_xgmii.Arrival.terminate_octet_time frame in
  (* requirements.md §0.6's strobe window: not earlier than the cycle the
     condition becomes decidable (the input word carrying the closing
     character); not later than ΔC = 3 after the input word carrying the
     LAST RECEIVED octet of the frame (the four FCS octets included, §6.1
     item 3) -- which for this fully-received (never truncated) 5..63-octet
     class is the octet immediately before the closing character, i.e.
     closing_ot - 1. *)
  let expected_not_before = closing_ot / 8 in
  let expected_not_after = ((closing_ot - 1) / 8) + 3 in
  let expected_tlast_cycle = start_cycle + 3 + (words - 1) in
  let expected_tkeep =
    if Int.rem delivered 8 = 0 then 0xFF else (1 lsl Int.rem delivered 8) - 1
  in
  let bench = create () in
  Dv_monitors.Strobe_monitor.expect
    (strobes bench)
    { Dv_monitors.Strobe_monitor.strobe = "error_runt"
    ; frame = 0
    ; cycle = expected_tlast_cycle
    ; not_before = expected_not_before
    ; not_after = expected_not_after
    ; why =
        "REQ-107 (5-63 octets is a runt, forwarded); SPEC-M03 section 9 'Strobe \
         cycle, pinned' pins it to the frame's own tlast cycle, \
         start_cycle + 3 + (words - 1) via section 7's per-octet constant"
    };
  let samples = run bench sched ~drain:8 () in
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
     then fail row "tuser[0] is not set on a runt (REQ-107 forwards it marked invalid)");
  let expected_octets = Dv_xgmii.Frame.delivered octets in
  let got_octets = delivered_octets samples in
  if not (List.equal Int.equal got_octets expected_octets)
  then
    fail
      row
      "delivered octets differ from the injected frame minus its FCS (REQ-103: FCS \
       removed and checked)";
  (match error_pulses samples with
   | [ (cycle, name) ] ->
     if not (String.equal name "error_runt")
     then fail row (String.concat [ "expected error_runt, observed "; name ])
     else if cycle <> expected_tlast_cycle
     then
       fail
         row
         (String.concat
            [ "error_runt pulsed on cycle "
            ; Int.to_string cycle
            ; ", expected "
            ; Int.to_string expected_tlast_cycle
            ])
   | pulses ->
     fail
       row
       (String.concat
          [ "expected exactly one strobe pulse (error_runt alone -- proving the FCS \
             WAS checked and found good, section9's first co-occurrence ruling), \
             observed "
          ; Int.to_string (List.length pulses)
          ]));
  account_clean_frame bench frame samples ~aborted:true;
  Dv_monitors.Conservation_monitor.strobe_pulse (conservation bench) ~name:"error_runt";
  assert_monitors_clean bench ~row
;;

let%expect_test
  "M03-F1: 5, 16, 60 and 63-octet runts, both start lanes -- forwarded, \
   marked, FCS removed and checked (REQ-107, REQ-103)"
  =
  List.iter [ 0; 4 ] ~f:(fun lane -> List.iter f1_lengths ~f:(fun length -> run_f1 ~lane ~length));
  [%expect {||}]
;;

(* ---- M03-F2 ---------------------------------------------------------- *)
(* "Frames of 0, 1 and 4 octets between start and terminate | No output word
   at all; exactly one error_runt and no other strobe of any kind, at
   section9's no-output-word pin." REQ-107, section 0.7, section 9 ruling 9.
   See this file's header for the WO-0047 section4.1 trap this row's
   construction is built around, and the empirical finding that motivates it.

   The 4-octet member's filler is {!Bench.directed_frame_octets}'s own
   length- and position-dependent, {b never all-zero} content (its own
   docstring) -- read off the first four octets of the 64-octet base this
   row corrupts. That discharges M03-M10's anti-vacuity requirement (a
   design running the residue comparison anyway must not pass by accident on
   an all-zero 4-octet frame, zlib.crc32(bytes(4)) being REQ-304's own
   residue) without needing to drive a second, all-zero frame alongside it --
   the first disjunct of WO-0047 §2's "SHALL NOT be 00 00 00 00 -- or both
   fillers are driven" is what is satisfied here.

   [k] = received octets before the injected `/T/` (0, 1 or 4 -- the
   packet's own three lengths). Both start lanes, though NEITHER the AP row
   nor WO-0047 §2's own F2 section names a lane (unlike F1 and F4's explicit
   "both start lanes"/"both lanes") -- extended to both here for the same
   REQ-101 coverage every other row in this family gets, at no machinery
   cost ([Injection.create]'s own [?first_lane]); flagged as a considered
   extension in the Return log, not a silent scope change.

   Assertion order (WO-0047 §4.2): [Injection.is_clean] (construction-site
   check), the model cross-check ([cross_check_f2]), the pre-run placement
   check (site 1, WO-0047 §6 item 7), [run], the post-run placement check
   (site 2), the two STRUCTURAL no-output facts ([tlast_sample] = [None],
   [delivered_samples] = []), then the exact strobe set (error_runt alone,
   at the no-output-word pin) -- construction and stimulus-landing facts
   first, the structural facts next, the strobe fact (this row's whole
   point, and F-c5's own kill) last. NOTHING is asserted about [tuser] (see
   this file's header). Iteration order: lane 0 then lane 4 (outer), k = 0,
   1, 4 ascending (inner), the packet's own stated order. *)

let f2_received_counts = [ 0; 1; 4 ]

let cross_check_f2
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
     when String.equal r.Dv_xgmii.Injection.strobe "error_runt"
          && r.Dv_xgmii.Injection.cycle = expected_pulse_cycle
          && r.Dv_xgmii.Injection.not_before = expected_not_before
          && r.Dv_xgmii.Injection.not_after = expected_not_after -> ()
   | _ -> fail_cross row "reports")
;;

let run_f2 ~lane ~k =
  let row =
    String.concat
      [ "M03-F2 (lane "; Int.to_string lane; ", "; Int.to_string k; " octets received)" ]
  in
  let base = directed_frame_octets ~length:64 in
  let case =
    Dv_xgmii.Injection.corrupt
      base
      [ Dv_xgmii.Injection.Place
          { placement = Dv_xgmii.Injection.At_octet k
          ; character = Dv_xgmii.Xgmii_word.terminate_char
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
  (* At_octet k lands the /T/ at start_ot + 8 + k (test/xgmii/injection.ml's
     own placement-to-octet-time map). section9's no-output-word pin: two
     cycles after that closing word, at both start lanes -- gap-invariant,
     not a corollary of m + 3 (M03-R2). The window's upper bound is
     requirements.md section0.6's: not later than ΔC = 3 after the input
     word carrying the frame's LAST RECEIVED octet where it received one
     (start_ot + 8 + k - 1, i.e. closing_ot - 1), or after the closing
     word itself where it received none (k = 0, section0.7). *)
  let closing_ot = start_ot + 8 + k in
  let closing_cycle = closing_ot / 8 in
  let expected_pulse_cycle = closing_cycle + 2 in
  let expected_not_before = closing_cycle in
  let expected_not_after =
    if k = 0 then closing_cycle + 3 else ((closing_ot - 1) / 8) + 3
  in
  let outcome = List.hd_exn (Dv_xgmii.Injection.outcomes inj) in
  cross_check_f2 ~row outcome ~expected_pulse_cycle ~expected_not_before ~expected_not_after;
  (* Site 1 (WO-0047 §6 item 7): the /T/ lands at the intended octet/lane in
     the SCHEDULE's own words, before a single cycle is driven. *)
  let closing_lane = Int.rem closing_ot 8 in
  let pre_run_word = Dv_xgmii.Injection.word_at inj ~cycle:closing_cycle in
  if (not (Dv_xgmii.Xgmii_word.is_control pre_run_word closing_lane))
     || not
          (Int.equal
             (pre_run_word.Dv_xgmii.Xgmii_word.data).(closing_lane)
             Dv_xgmii.Xgmii_word.terminate_char)
  then
    fail row "test bug -- the injected /T/ does not land at the intended octet time before driving";
  let bench = create () in
  Dv_monitors.Strobe_monitor.expect
    (strobes bench)
    { Dv_monitors.Strobe_monitor.strobe = "error_runt"
    ; frame = 0
    ; cycle = expected_pulse_cycle
    ; not_before = expected_not_before
    ; not_after = expected_not_after
    ; why =
        "REQ-107 / requirements.md section 0.7 / SPEC-M03 section 9 row 6 and the \
         no-output-word pin (section 9 'Strobe cycle, pinned'): fewer than 5 octets \
         between start and terminate, so the strobe is two cycles after the input \
         word carrying the closing character, not on any tlast cycle (it has none)"
    };
  let samples =
    run bench sched ~drain:8 ~word_at:(fun ~cycle -> Dv_xgmii.Injection.word_at inj ~cycle) ()
  in
  (* Site 2 (WO-0047 §6 item 7): the cycle {!run} ACTUALLY drove carries the
     /T/ this row means to test. *)
  (match List.find samples ~f:(fun s -> s.cycle = closing_cycle) with
   | None -> fail row "test bug -- the intended closing cycle was never driven"
   | Some s ->
     if (not (Dv_xgmii.Xgmii_word.is_control s.in_word closing_lane))
        || not
             (Int.equal
                (s.in_word.Dv_xgmii.Xgmii_word.data).(closing_lane)
                Dv_xgmii.Xgmii_word.terminate_char)
     then
       fail
         row
         "the driven word at the intended cycle does not carry the /T/ this row means \
          to test -- the no-output-word assertion below would be vacuous");
  (* WO-0047 §2's discipline: assert NOTHING about tuser[0]. *)
  (match tlast_sample samples with
   | Some _ ->
     fail row "a tlast word was observed for a frame that must deliver nothing (section0.7, F-c5)"
   | None -> ());
  if not (List.is_empty (delivered_samples samples))
  then fail row "a tvalid word was observed for a frame that must deliver nothing";
  (match error_pulses samples with
   | [ (cycle, name) ] ->
     if not (String.equal name "error_runt")
     then fail row (String.concat [ "expected error_runt, observed "; name ])
     else if cycle <> expected_pulse_cycle
     then
       fail
         row
         (String.concat
            [ "error_runt pulsed on cycle "
            ; Int.to_string cycle
            ; ", expected "
            ; Int.to_string expected_pulse_cycle
            ])
   | pulses ->
     fail
       row
       (String.concat
          [ "expected exactly one strobe pulse (error_runt only -- F-c5's own kill), \
             observed "
          ; Int.to_string (List.length pulses)
          ]));
  account_dropped_frame bench frame ~strobe:"error_runt";
  Dv_monitors.Conservation_monitor.strobe_pulse (conservation bench) ~name:"error_runt";
  assert_monitors_clean bench ~row
;;

let%expect_test
  "M03-F2: 0, 1 and 4 octets between start and terminate, both start lanes \
   -- no output word at all, exactly one error_runt at section9's \
   no-output-word pin (REQ-107, section0.7, section9 ruling 9, F-c5)"
  =
  List.iter [ 0; 4 ] ~f:(fun lane ->
    List.iter f2_received_counts ~f:(fun k -> run_f2 ~lane ~k));
  [%expect {||}]
;;

(* ---- M03-F3 ------------------------------------------------------------ *)
(* "A 63-octet frame with a wrong FCS | Both error_runt and error_bad_fcs
   pulse once; tuser[0] is set once -- one bit on one word, not one bit per
   condition." REQ-107, REQ-104, section9's first co-occurrence ruling.

   WO-0047 §3.2's finding, binding here: this row's teeth are the PRECEDENCE
   kill (a first-match design reports only the runt) and the WIDENED-PULSE
   kill (a design that widens either strobe to more than one cycle, which
   C-23's high-cycle counting -- Strobe_monitor's own [expect]/[errors] --
   catches via the exact (cycle, name) pair set). "Sets the bit twice" is
   NOT asserted: tuser[0] is one bit on one word and has no distinct
   "twice" manifestation short of a second tlast word, a different defect
   already caught by the output-word-count check below.

   Assertion order (WO-0047 §4.2): output-word COUNT, [tlast] CYCLE, its
   [tkeep], the SINGLE tuser bit, delivered CONTENT, then the EXACT strobe
   SET -- {error_runt, error_bad_fcs}, each exactly once, both on the tlast
   cycle, compared as a SET (sorted by name) rather than as an ordered list:
   which physical error output {!Bench}'s own port-sampling loop happens to
   read first (bench.ml's [strobe_names] field order, error_bad_fcs before
   error_runt) is a bench-probe artefact, not something section9 pins, so
   this row does not encode it as a fact. Structural facts first, the
   co-occurrence claim (this row's whole point) last. *)

let f3_flip_idx = 20

let f3_corrupt_payload_bit octets =
  List.mapi octets ~f:(fun i v -> if i = f3_flip_idx then v lxor 1 else v)
;;

let strobe_pair_compare (c1, n1) (c2, n2) =
  match Int.compare c1 c2 with
  | 0 -> String.compare n1 n2
  | n -> n
;;

let run_f3 ~lane =
  let row = String.concat [ "M03-F3 (lane "; Int.to_string lane; ")" ] in
  let good = directed_frame_octets ~length:63 in
  if not (Dv_xgmii.Frame.residue_ok good)
  then fail row "test bug -- the base 63-octet frame's own FCS does not check out";
  let bad = f3_corrupt_payload_bit good in
  if Dv_xgmii.Frame.residue_ok bad
  then fail row "test bug -- the payload-bit flip did not change the frame's FCS residue";
  let sched = frames_at ~lane ~fcs_valid:false [ bad ] in
  let frame = (Dv_xgmii.Arrival.frames sched).(0) in
  let start_cycle = Dv_xgmii.Arrival.start_cycle frame in
  let closing_ot = Dv_xgmii.Arrival.terminate_octet_time frame in
  let delivered = 63 - 4 in
  let words = (delivered + 7) / 8 in
  let expected_tlast_cycle = start_cycle + 3 + (words - 1) in
  let expected_tkeep =
    if Int.rem delivered 8 = 0 then 0xFF else (1 lsl Int.rem delivered 8) - 1
  in
  let expected_not_before = closing_ot / 8 in
  let expected_not_after = ((closing_ot - 1) / 8) + 3 in
  let bench = create () in
  Dv_monitors.Strobe_monitor.expect
    (strobes bench)
    { Dv_monitors.Strobe_monitor.strobe = "error_runt"
    ; frame = 0
    ; cycle = expected_tlast_cycle
    ; not_before = expected_not_before
    ; not_after = expected_not_after
    ; why =
        "REQ-107 (63 octets is a runt); section9's first co-occurrence ruling admits \
         error_runt WITH error_bad_fcs at 5-63 octets, both pinned to the tlast cycle"
    };
  Dv_monitors.Strobe_monitor.expect
    (strobes bench)
    { Dv_monitors.Strobe_monitor.strobe = "error_bad_fcs"
    ; frame = 0
    ; cycle = expected_tlast_cycle
    ; not_before = expected_not_before
    ; not_after = expected_not_after
    ; why =
        "REQ-104 (wrong FCS); section9's first co-occurrence ruling: pulses \
         ALONGSIDE error_runt, not instead of it, on the same tlast cycle -- the \
         precedence kill this row exists for"
    };
  let samples = run bench sched ~drain:8 () in
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
     then
       fail
         row
         "tuser[0] is not set -- both conditions mark the frame invalid once (REQ-007)");
  let expected_octets = Dv_xgmii.Frame.delivered bad in
  let got_octets = delivered_octets samples in
  if not (List.equal Int.equal got_octets expected_octets)
  then fail row "delivered octets differ from the corrupted frame's own 59 octets";
  let observed_pulses = List.sort (error_pulses samples) ~compare:strobe_pair_compare in
  let expected_pulses =
    List.sort
      [ expected_tlast_cycle, "error_bad_fcs"; expected_tlast_cycle, "error_runt" ]
      ~compare:strobe_pair_compare
  in
  if not
       (List.equal
          (fun (c1, n1) (c2, n2) -> c1 = c2 && String.equal n1 n2)
          observed_pulses
          expected_pulses)
  then
    fail
      row
      (String.concat
         [ "expected exactly {error_runt, error_bad_fcs}, each once, both on cycle "
         ; Int.to_string expected_tlast_cycle
         ; " -- the precedence/widened-pulse kill this row exists for; observed "
         ; Int.to_string (List.length observed_pulses)
         ; " pulse(s)"
         ]);
  account_clean_frame bench frame samples ~aborted:true;
  Dv_monitors.Conservation_monitor.strobe_pulse (conservation bench) ~name:"error_runt";
  Dv_monitors.Conservation_monitor.strobe_pulse (conservation bench) ~name:"error_bad_fcs";
  assert_monitors_clean bench ~row
;;

let%expect_test
  "M03-F3: a 63-octet frame with a wrong FCS, both start lanes -- \
   error_runt AND error_bad_fcs pulse once each, tuser[0] set once (REQ-107, \
   REQ-104, section9's first co-occurrence ruling)"
  =
  run_f3 ~lane:0;
  run_f3 ~lane:4;
  [%expect {||}]
;;

(* ---- M03-F4 -------------------------------------------------------------- *)
(* "The adjacent pair 63 and 64, both lanes | 63 -> error_runt, tuser[0]=1,
   59 delivered. 64 -> no strobe, tuser[0]=0, 60 delivered." REQ-107,
   section0.3. WO-0047 §2: the strongest row in the family -- two frames
   differing by ONE octet and by everything else, driven back to back at
   section0.3's minimum gap so the ADJACENCY itself is the stimulus. This
   kills both a "< 64" -> "<= 64" threshold AND a threshold applied to the
   DELIVERED count (60, after FCS removal, on both sides of the boundary)
   rather than the RECEIVED count (63 vs 64, which is what actually decides
   REQ-107).

   Assertion order (WO-0047 §4.2): the two-frame SPLIT (structural: both
   non-empty), then per frame in arrival order -- frame 1 (the runt) first:
   word count, tlast cycle, tkeep, delivered content, tuser (single bit),
   exact strobe set; then frame 2 (the legal minimum): word count, tlast
   cycle, tkeep, delivered content, tuser, exact strobe set (empty). tuser
   and strobe-presence/absence are the LAST check on EACH frame -- they are
   this row's whole point (the off-by-one and delivered-vs-received kills). *)

let run_f4 ~lane =
  let row = String.concat [ "M03-F4 (lane "; Int.to_string lane; ")" ] in
  let octets63 = directed_frame_octets ~length:63 in
  let octets64 = directed_frame_octets ~length:64 in
  let sched = frames_at ~lane ~fcs_valid:true [ octets63; octets64 ] in
  let frames = Dv_xgmii.Arrival.frames sched in
  let frame0 = frames.(0) in
  let frame1 = frames.(1) in
  let start_cycle0 = Dv_xgmii.Arrival.start_cycle frame0 in
  let start_cycle1 = Dv_xgmii.Arrival.start_cycle frame1 in
  let closing_ot0 = Dv_xgmii.Arrival.terminate_octet_time frame0 in
  let delivered0 = 63 - 4 in
  let words0 = (delivered0 + 7) / 8 in
  let expected_tlast_cycle0 = start_cycle0 + 3 + (words0 - 1) in
  let expected_tkeep0 =
    if Int.rem delivered0 8 = 0 then 0xFF else (1 lsl Int.rem delivered0 8) - 1
  in
  let expected_not_before0 = closing_ot0 / 8 in
  let expected_not_after0 = ((closing_ot0 - 1) / 8) + 3 in
  let delivered1 = 64 - 4 in
  let words1 = (delivered1 + 7) / 8 in
  let expected_tlast_cycle1 = start_cycle1 + 3 + (words1 - 1) in
  let expected_tkeep1 =
    if Int.rem delivered1 8 = 0 then 0xFF else (1 lsl Int.rem delivered1 8) - 1
  in
  let bench = create () in
  Dv_monitors.Strobe_monitor.expect
    (strobes bench)
    { Dv_monitors.Strobe_monitor.strobe = "error_runt"
    ; frame = 0
    ; cycle = expected_tlast_cycle0
    ; not_before = expected_not_before0
    ; not_after = expected_not_after0
    ; why = "REQ-107: 63 octets is inside 5-63, the runt band, pinned to its own tlast cycle"
    };
  let samples = run bench sched ~drain:8 () in
  let words_delivered0, rest = split_at_first_tlast (delivered_samples samples) in
  let words_delivered1, _ = split_at_first_tlast rest in
  if List.is_empty words_delivered0 || List.is_empty words_delivered1
  then fail row "expected two delivered frames (one tlast word each), got fewer";
  (* frame 1 -- the 63-octet runt *)
  if List.length words_delivered0 <> words0
  then
    fail
      row
      (String.concat
         [ "frame 1: expected "
         ; Int.to_string words0
         ; " output words, got "
         ; Int.to_string (List.length words_delivered0)
         ]);
  let tlast0 = List.last_exn words_delivered0 in
  if tlast0.cycle <> expected_tlast_cycle0
  then
    fail
      row
      (String.concat
         [ "frame 1: tlast word arrived on cycle "
         ; Int.to_string tlast0.cycle
         ; ", expected "
         ; Int.to_string expected_tlast_cycle0
         ]);
  if tlast0.out.Dv_monitors.Stream_word.tkeep <> expected_tkeep0
  then fail row "frame 1: tkeep does not match its own 59 delivered octets";
  let got0 =
    List.concat_map words_delivered0 ~f:(fun (s : sample) -> Dv_monitors.Stream_word.octets s.out)
  in
  if not (List.equal Int.equal got0 (Dv_xgmii.Frame.delivered octets63))
  then fail row "frame 1: delivered octets differ from its own 59";
  if tlast0.out.Dv_monitors.Stream_word.tuser <> 1
  then fail row "frame 1 (63 octets): tuser[0] not set -- REQ-107 marks a runt invalid";
  let all_pulses = error_pulses samples in
  let pulses0, pulses1 =
    List.partition_tf all_pulses ~f:(fun (cycle, _) -> cycle <= tlast0.cycle)
  in
  (match pulses0 with
   | [ (cycle, name) ] ->
     if not (String.equal name "error_runt")
     then fail row (String.concat [ "frame 1: expected error_runt, observed "; name ])
     else if cycle <> expected_tlast_cycle0
     then fail row "frame 1: error_runt pulsed on the wrong cycle"
   | _ ->
     fail
       row
       (String.concat
          [ "frame 1: expected exactly one strobe pulse (error_runt), observed "
          ; Int.to_string (List.length pulses0)
          ]));
  (* frame 2 -- the 64-octet legal minimum: the anti-vacuity partner *)
  let tlast1 = List.last_exn words_delivered1 in
  if List.length words_delivered1 <> words1
  then
    fail
      row
      (String.concat
         [ "frame 2: expected "
         ; Int.to_string words1
         ; " output words, got "
         ; Int.to_string (List.length words_delivered1)
         ]);
  if tlast1.cycle <> expected_tlast_cycle1
  then fail row "frame 2: tlast word did not arrive on start_cycle + 3 + 7 (REQ-019)";
  if tlast1.out.Dv_monitors.Stream_word.tkeep <> expected_tkeep1
  then fail row "frame 2: tkeep does not match its own 60 delivered octets";
  let got1 =
    List.concat_map words_delivered1 ~f:(fun (s : sample) -> Dv_monitors.Stream_word.octets s.out)
  in
  if not (List.equal Int.equal got1 (Dv_xgmii.Frame.delivered octets64))
  then fail row "frame 2: delivered octets differ from its own 60";
  if tlast1.out.Dv_monitors.Stream_word.tuser <> 0
  then fail row "frame 2 (64 octets): tuser[0] set -- this is a LEGAL frame, not a runt";
  if not (List.is_empty pulses1)
  then fail row "frame 2 (64 octets): a strobe pulsed on a legal, minimum-length frame";
  account_clean_frame bench frame0 words_delivered0 ~aborted:true;
  account_clean_frame bench frame1 words_delivered1 ~aborted:false;
  Dv_monitors.Conservation_monitor.strobe_pulse (conservation bench) ~name:"error_runt";
  assert_monitors_clean bench ~row
;;

let%expect_test
  "M03-F4: the adjacent pair 63 and 64 octets, both lanes -- 63 is a runt, \
   64 is legal, differing by one octet and by everything else (REQ-107, \
   section0.3)"
  =
  run_f4 ~lane:0;
  run_f4 ~lane:4;
  [%expect {||}]
;;

(* ---- M03-F5 — DISCHARGED BY CITATION, not built (WO-0047 §3.3) ----------- *)
(* AP-xgmii_rx_64.md M03-F5: "The 5-octet frame of M03-F1 | Exactly one
   delivered octet in one word (tkeep = 0x01, tlast = 1)." This is a proper
   subset of what M03-C4 (`test_m03_c.ml`, [run_c4]) ALREADY drives at both
   start lanes and asserts: the same three facts (one word, tkeep = 0x01,
   tlast = 1) PLUS tuser[0] = 1, the delivered octet's own value, the word's
   arrival cycle (start_cycle + 3, asserted via [Bench.tlast_sample]/
   [Bench.delivered_octets]), and exactly one error_runt on the pinned
   cycle (asserted via [Dv_monitors.Strobe_monitor.expect] and
   [Bench.error_pulses]) -- named exactly, per WO-0040 §2's own citation
   discipline for M03-D2. F5's own declared kill ("fewer than 5" read as
   "<= 5", emitting nothing for the boundary frame) would die at C4, which
   asserts a word EXISTS for this exact frame. M03-F1's own 5-octet member
   (this file, [run_f1] with [length = 5]) re-drives the same frame at both
   lanes again, so the boundary is exercised twice over without a dedicated
   F5 row. Nothing is built here for it. *)
