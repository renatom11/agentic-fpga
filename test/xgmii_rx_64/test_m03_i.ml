(** Family I — silence, ordered sets and idle (REQ-109, REQ-113, REQ-016).
    WO-0059.

    Six rows (`AP-xgmii_rx_64.md` §4.I), built in the packet's own build
    order M03-I1 -> M03-I2 -> M03-I3 -> M03-I4 -> M03-I5 -> M03-I6: M03-I1
    (ASSERT, [run_i1]), M03-I2 (ASSERT, two members x two lanes, [run_i2]),
    M03-I3 (ASSERT, both lanes, [run_i3]), M03-I4 (ASSERT, 48 runs,
    [run_i4]), M03-I5 (NO-ASSERT, declared below rather than built), M03-I6
    (ASSERT, four runs, [run_i6]).

    {2 This family's characteristic failure is vacuity, not wrongness
    (WO-0059 §2.1)}

    Every row here asserts an ABSENCE: no output word, no strobe, no change.
    An absence is satisfied by a design that does nothing at all, and by a
    bench that drove nothing at all. Every row below therefore carries its
    own POSITIVE companion assertion, in its own unit, named at the row:

    - M03-I1: the frame driven AFTER the 1000-cycle idle window, delivered
      correct and complete (word count, per-word cycle and tkeep, tuser,
      content) -- and {!Bench.assert_monitors_clean}'s latency [is_constant]
      verdict IS demanded here (unlike the frameless scaffolding smoke test,
      `test_m03_structural.ml`), because a frame is in this run.
    - M03-I2: the frame's own delivered words, tkeep, tlast cycle and a
      clean FCS verdict, for BOTH members at BOTH start lanes.
    - M03-I3: the frame after the ordered set, checked structurally on its
      own terms AND compared cycle for cycle against the SAME frame received
      after idles only (two runs of one schedule, `?word_at` substitution).
    - M03-I4: the word sequence (translated through [Idle_injection.cycle_of],
      never m + 3), the per-octet DELAY IDENTITY against an actual,
      separately-driven un-injected baseline run of the same (length, lane)
      -- WO-0059 §3.4 item 2's own form, derived from raw octet times rather
      than from [cycle_of] a second time, so a bug in the translator could
      not silently validate itself -- and the per-octet constant of §7,
      MEASURED both per run via each bench's own standing
      {!Octet_time.Latency} tagger and across all 48 runs via one extra,
      standalone tagger this file builds and feeds independently
      ([cross_latency]), which is the strong form of "one value per start
      lane across every run" REQ-005 / REQ-111 actually ask for, rather than
      a single-frame tautology.
    - M03-I6: the delivered content and clean FCS verdict of both the
      64-octet and the 1518-octet member, at both lanes -- the 64-octet
      member is stimulus M03-I4 already drives at 7 idles (WO-0059 §3.5),
      and its value here is as the anti-vacuity partner to the 1518-octet
      member's silence, not as new coverage.

    {2 §6 item 1 -- what this family's strobe assurance is, and is not}

    Every row asserts that NO strobe pulses, so no expected event is ever
    registered here: no [Dv_monitors.Strobe_monitor.expect] call appears
    anywhere in this file. C-23's "one high cycle per reported event"
    counting rule has no positive instance to count (checks (a)/(b)/(c) of
    `test/monitors/strobe_monitor.mli`'s own three-way split are vacuous on
    an expectation-free run); this family's entire strobe assurance is
    check (d) -- "no strobe the stimulus did not create" -- read both
    directly ([error_pulses samples] asserted empty, in every row) and
    through {!Bench.assert_monitors_clean}'s own [Strobe_monitor.is_clean]
    call, which reduces to exactly the same check once no event is expected.

    {2 M03-I2 -- the repaired row (WO-0059 §1.1)}

    `AP-xgmii_rx_64.md`'s M03-I2 row was corrected in this packet's own
    commit, before this file was written: a single 64-octet member cannot
    reach its own declared kill (a real one-cycle-long drain defect), because
    a conformant lane-0-or-lane-4 64-octet frame's own `tlast` lands only ONE
    cycle after its terminate word while the row asserted silence from
    THREE. The repair is a second member -- a 69-octet frame at a lane-0
    start (already in {!Bench.directed_lengths}, chosen for its residue
    r = 5) -- whose conformant `tlast` lands exactly on the last legal drain
    cycle, so the same one-cycle-long defect now emits inside the asserted
    window and dies. [run_i2] drives BOTH members at BOTH start lanes (the
    AP text names lane 0 for the 69-octet member and permits lane 4 as a
    witness of the other half of the derivation, WO-0059 §3.2 -- driven here
    because it is cheap and it independently confirms member (i)'s own
    lane-4 boundary, which the AP text does not itself state). The two
    members do NOT share a silence boundary at lane 4 (13 for member (i),
    14 for member (ii)); each is derived and guarded on its own.

    {2 M03-I3 -- the one authorised bench addition it needs}

    [Bench.frames_at]'s new [?ifg] parameter (WO-0059 §8.1) is used here, and
    only here, to lay out two frames 824 octets apart (from the terminate
    character inclusive, requirements.md §0.3's own convention) so that
    exactly 100 whole cycles of gap lie between M03-I2's own drain-safe
    boundary and the second frame's own start character, at BOTH start
    lanes. The comparison is between two runs of ONE schedule, driven twice
    on two fresh {!Bench.t} instances -- once unmodified, once with the
    window's words substituted through [?word_at] -- so the two runs are
    cycle-identical by construction and the comparison is made cycle for
    cycle (this file's own [outputs_equal]), not as a re-ordered tuple
    sequence. `Bench.run`'s own [Arrival.check] (standing obligation 5) sees
    only the SOURCE schedule; the overlay's own legality -- every substituted
    word's control mask, and the window lying strictly inside the gap -- is
    this row's own responsibility and is guarded before either run is
    driven.

    {2 M03-I4 / M03-I6 -- the wrapper's first customer against a DUT}

    `Bench.account_clean_frame` is the WRONG helper on an injected line
    (WO-0059 §2.2, the family-H trap in a new dress): it feeds
    [Arrival.in_times frame] to the standing latency tagger, which is false
    about the input under injection by exactly 8 octet times per idle word
    inserted before each octet -- REQ-016's own arithmetic, and exactly what
    [Idle_injection.in_times] exists to correct. [account_injected_frame]
    below is this file's own, file-local replacement (mirroring
    [Bench.account_clean_frame]'s own shape with [Idle_injection.in_times]
    in place of [Arrival.in_times]), used by both M03-I4 and M03-I6 -- no
    change to `bench.ml`/`bench.mli` is needed or made beyond the one
    authorised [?ifg] addition M03-I3 uses; `RV-0043-VERDICT` §7's bar on
    widening [Bench]'s exported surface stands (WO-0059 §8.1).

    Every run through {!Dv_xgmii.Idle_injection.uniform} is checked against
    its OWN stimulus before being trusted (WO-0059 §2.3): [errors] and
    [c45_sites] are asserted EMPTY, not merely printed, for the two different
    reasons `idle_injection.mli` gives (the M03-N3 constraint is satisfied by
    construction; [uniform] never proposes the C-45 boundary because it
    begins one boundary later). Both were observed empty on every one of the
    52 runs this file drives through the wrapper (48 at M03-I4, 4 at
    M03-I6). Where a cycle from §6.1 or §9 is needed on an injected line it
    is translated through [Idle_injection.cycle_of] -- never recomputed from
    the gapless `m + 3` formula, which §6.1 itself scopes to a gapless
    stimulus and which M03-I5 exists to bar (below).

    {2 M03-I5 -- declared, not built}

    `AP-xgmii_rx_64.md`'s M03-I5 is NO-ASSERT: "§6.1's `m + 3` cycle formula
    is NOT asserted under injection... The gap-invariant quantity is the
    per-octet constant, and that is what M03-I4 asserts." Declared in the
    shape `test_m03_d.ml` uses for M03-D4 (a comment naming the row, the
    clause, what is not asserted and what is asserted instead, with no test
    function of its own) rather than the shape `test_m03_a.ml` uses for
    M03-A4 (a real assertion woven into the SAME unit as its neighbour).
    WO-0059 §3.4 left the choice open ("I have not decided whether I5 earns
    the same [as A4]"); the reasoning for D4's shape over A4's is at the
    declaration site below and in this packet's Return log.

    {2 Independence}

    Every expected value is read from `docs/specs/modules/xgmii_rx_64.md`
    §6.1 (the preamble-position paragraph, the gapless qualifier and its
    C-14.4 hold rule, the two C-18 non-instances, the cycle table, the
    "Between frames" paragraph and its two-cycle drain derivation C-14.3),
    §6.2 (the `Idle` and `Frame` rows), §6.3 items 2, 4, 5 and 6, §7 (h = 8 /
    12, L = 16 / 12, ΔC = 3), §9 (the closure list and the strobe table),
    §10 (the REQ-109, REQ-113 and REQ-016 hooks) and `docs/specs/
    requirements.md` §0.3 (the gap convention), §0.5 (octet time, the front
    offset h, the word delay ΔC, the "Start lanes" paragraph), §0.6 (the
    strobe window and C-23's counting convention), §2 (the five control
    characters) and REQ-005, REQ-011, REQ-016, REQ-101, REQ-102, REQ-103,
    REQ-104, REQ-107, REQ-108, REQ-109, REQ-111, REQ-113 themselves --
    cited inline. Plus `test/xgmii/idle_injection.mli` AND `.ml` (read in
    full: the M03-N3 constraint's own implementation, [uniform]'s own site
    range, [in_times]'s own arithmetic, [cycle_of]'s own array), `test/xgmii/
    arrival.mli` AND `.ml` (read in full: [check]'s own gap logic, confirmed
    to impose nothing on the gap BEFORE a schedule's first frame, which
    M03-I1's 1000-cycle prefix depends on), `test/xgmii/xgmii_word.mli`,
    `test/xgmii/frame.mli`, `test/xgmii_rx_64/bench.mli` AND `.ml` (in full),
    `test/monitors/strobe_monitor.mli`, `test/monitors/octet_time.mli` AND
    `.ml` (read in full: [frame_out]'s own per-octet walk, confirmed to read
    [in_times] only at indices [j + strip_octets] for j in
    [0, got - 1] -- the fact WO-0059 §7.3 Finding 1's repair to
    `test_m03_h.ml` rests on), `test/monitors/conservation_monitor.mli`.
    `test/xgmii_rx_64/test_m03_structural.ml` (the ten-cycle scaffolding
    precedent M03-I1 is scaled from), `test_m03_a.ml` (M03-A4's shape),
    `test_m03_d.ml` (M03-D4's shape, and [good_and_bad_64]'s
    both-directions-checked idiom, referenced but not needed here since
    no row in this family corrupts an FCS), `test_m03_g.ml` (in part --
    [account_resync_runt_frame]'s own [~received] naming, the precedent
    Finding 1's repair follows) and `test_m03_h.ml` (in full, as the most
    recent family and the file this packet also repairs -- [fail],
    [split_at_first_tlast], the "test bug" construction-guard idiom, the
    per-row docstring shape, all reused). `agents/handoffs/
    WO-0059_tb-m03-family-i-silence-and-ordered-sets.md` in full.
    `test/attack_plans/AP-xgmii_rx_64.md` §4.I (the repaired M03-I2 cells)
    and its §9 change log. No path under `libs/**`, `top/**`, `bin/**` or
    `rtl_snapshots/**` was opened, targeted or swept, at any point in this
    spawn. No path under `docs/reports/audit/**` was opened. No path under
    `test/third_party/verilog-ethernet/**` was opened (WO-0059 §9: this
    family's ordered-set shape is derived from requirements.md §2 and §6.2
    alone, never imported from a reference). *)

open! Base
open Bench

let fail row msg = failwith (String.concat [ row; ": "; msg ])

(* Duplicated from every other family file's own local helper of the same
   shape rather than shared, per this packet's own convention: {!Bench} is
   the only shared surface (test_m03_h.ml's own docstring states the same
   rule). *)
let split_at_first_tlast samples =
  let rec go acc = function
    | [] -> List.rev acc, []
    | (s : sample) :: rest ->
      if s.out.Dv_monitors.Stream_word.tlast then List.rev (s :: acc), rest else go (s :: acc) rest
  in
  go [] samples
;;

(* ==================================================================== *)
(* ---- M03-I1 -- silence with nothing in flight (REQ-109) -------------- *)
(* ==================================================================== *)
(* "1000 idle cycles with no frame in flight | tvalid = 0 and all five
   strobes 0 on every one of them | A design that emits a spurious word or
   strobe out of an empty pipeline."

   test_m03_structural.ml's own scaffolding run drives the same shape (all
   idle, nothing asserted but the simulation built) at TEN cycles, and its
   own comment already says the ten-cycle figure is not REQ-109's. M03-I1 is
   that run at REQ-109's own verification-column figure (1000), and the
   SCALE is this row's whole point: a pipeline that emits spuriously after
   sixty-odd idle cycles (a counter wrapping, a state that ages) is
   invisible at ten and visible at a thousand.

   Derivation (WO-0059 §3.1, checked, not merely quoted): one schedule, one
   run, no overlay. Arrival.create's own first_start must be a multiple of 4
   (requirements.md §0.3); 8 + 8 * 1000 = 8008 is (8008 / 4 = 2002), and
   8008 mod 8 = 0, so the frame's own start character lands in lane 0 at
   cycle 1001 -- one idle word precedes every schedule by construction
   (arrival.mli, first_start's own default-8 rationale), so cycles
   0 .. 1000 (1001 of them) are idle before the liveness frame. Arrival.ml's
   own [check] imposes no gap requirement on the space BEFORE a schedule's
   first frame ([gaps t] only ever considers INTER-frame gaps, and a
   one-frame schedule has none), so this stimulus is legal by construction
   and needs no [?ifg] override. *)

let run_i1 () =
  let row = "M03-I1" in
  let idle_cycles = 1000 in
  let first_start = 8 + (8 * idle_cycles) in
  if Int.rem first_start 4 <> 0
  then
    fail
      row
      "test bug -- first_start is not a legal start octet time (requirements.md \
       §0.3: a multiple of 4)";
  let octets = directed_frame_octets ~length:64 in
  let sched = Dv_xgmii.Arrival.create ~first_start [ octets ] in
  let frame = (Dv_xgmii.Arrival.frames sched).(0) in
  let start_cycle = Dv_xgmii.Arrival.start_cycle frame in
  if frame.Dv_xgmii.Arrival.start_octet_time <> first_start
  then fail row "test bug -- the frame did not land at the intended start octet time";
  if start_cycle <> idle_cycles + 1
  then
    fail
      row
      "test bug -- start cycle is not idle_cycles + 1 (one idle word precedes every \
       schedule by construction, arrival.mli)";
  let bench = create () in
  let samples = run bench sched ~drain:8 () in
  let idle_prefix = List.filter samples ~f:(fun s -> s.cycle < start_cycle) in
  if List.length idle_prefix <> idle_cycles + 1
  then fail row "test bug -- the idle prefix observed is not the intended length";
  let delivered = 64 - 4 in
  let words = (delivered + 7) / 8 in
  let expected_tkeep_last =
    if Int.rem delivered 8 = 0 then 0xFF else (1 lsl Int.rem delivered 8) - 1
  in
  let words_out = delivered_samples samples in
  if List.length words_out <> words
  then
    fail
      row
      (String.concat
         [ "expected "
         ; Int.to_string words
         ; " output words after the idle window, got "
         ; Int.to_string (List.length words_out)
         ]);
  List.iteri words_out ~f:(fun m s ->
    let expected_cycle = start_cycle + 3 + m in
    if s.cycle <> expected_cycle
    then
      fail
        row
        (String.concat
           [ "word "
           ; Int.to_string m
           ; " arrived on cycle "
           ; Int.to_string s.cycle
           ; ", expected "
           ; Int.to_string expected_cycle
           ; " (REQ-019)"
           ]);
    let expected_tkeep = if m = words - 1 then expected_tkeep_last else 0xFF in
    if s.out.Dv_monitors.Stream_word.tkeep <> expected_tkeep
    then fail row (String.concat [ "word "; Int.to_string m; " tkeep does not match the expected pattern" ]);
    if m = words - 1
    then (if not s.out.Dv_monitors.Stream_word.tlast then fail row "the last word does not carry tlast")
    else if s.out.Dv_monitors.Stream_word.tlast
    then fail row (String.concat [ "word "; Int.to_string m; " unexpectedly carries tlast" ]));
  (match tlast_sample samples with
   | None -> fail row "no tlast word observed"
   | Some s ->
     if s.out.Dv_monitors.Stream_word.tuser <> 0
     then fail row "tuser[0] set -- expected a clean FCS verdict after a long idle window");
  let expected_octets = Dv_xgmii.Frame.delivered octets in
  let got_octets = delivered_octets samples in
  if not (List.equal Int.equal got_octets expected_octets)
  then fail row "delivered octets differ from the injected frame minus its FCS";
  (* The absence, last (WO-0059 §5): a spurious word or strobe out of an
     empty pipeline, over every one of the 1001 idle cycles that precede the
     liveness frame -- REQ-109's own figure at REQ-109's own scale. *)
  if List.exists idle_prefix ~f:(fun s -> s.out.Dv_monitors.Stream_word.tvalid)
  then
    fail
      row
      "a spurious output word was emitted during the 1000+ idle-cycle window with \
       nothing in flight (REQ-109)";
  if List.exists idle_prefix ~f:(fun s -> not (List.is_empty s.errors_high))
  then
    fail
      row
      "a strobe pulsed during the 1000+ idle-cycle window with nothing in flight \
       (REQ-109)";
  if not (List.is_empty (error_pulses samples))
  then
    fail
      row
      "an error strobe pulsed somewhere in this run -- a long idle window followed by \
       a clean frame must not trip one";
  (* WO-0059 §2.1: once a frame is in the run, assert_monitors_clean's
     is_constant demand on the latency tagger IS live (unlike the frameless
     scaffolding smoke test, which assert_monitors_clean's own docstring
     carves out) -- this is the trade that makes M03-I1's positive companion
     cost something, and it is paid here. *)
  account_clean_frame bench frame samples ~aborted:false;
  assert_monitors_clean bench ~row
;;

let%expect_test
  "M03-I1: 1000+ idle cycles with nothing in flight, then a frame driven after \
   the window -- tvalid and all five strobes stay 0 throughout the window, the \
   frame after it delivered correct and complete (REQ-109)"
  =
  run_i1 ();
  [%expect {||}]
;;

(* ==================================================================== *)
(* ---- M03-I2 -- the drain window (REQ-109, §6.1's drain derivation, --- *)
(* ----            C-14.3), the repaired row ---------------------------- *)
(* ==================================================================== *)
(* "Two members, each followed by idle, driven separately. (i) A 64-octet
   frame, both start lanes. (ii) A 69-octet frame at a lane-0 start | No
   output activity of any kind from 3 cycles after the terminate word onward
   -- the tight ΔC - 1 = 2-cycle drain window §6.1 derives, not ΔC... | A
   real drain defect one cycle long."

   See this file's own module docstring and WO-0059 §1.1 for why member (ii)
   exists (the repair) and why the two members' boundaries are derived, not
   assumed. [run_i2_member] takes the packet's own hand-derived expectations
   as guard parameters -- "a derivation to check, not an instruction"
   (WO-0059 §4 item 3) -- and fails loudly if this file's own Arrival-based
   computation disagrees with them, rather than silently trusting either. *)

let run_i2_member
      ~member
      ~lane
      ~octets
      ~expected_terminate_cycle
      ~expected_tlast_cycle
      ~expected_boundary
      ~expected_words
  =
  let row = String.concat [ "M03-I2 ("; member; ", lane "; Int.to_string lane; ")" ] in
  let sched = one_frame ~lane octets in
  let frame = (Dv_xgmii.Arrival.frames sched).(0) in
  let start_cycle = Dv_xgmii.Arrival.start_cycle frame in
  let terminate_ot = Dv_xgmii.Arrival.terminate_octet_time frame in
  let terminate_cycle = terminate_ot / 8 in
  (* §6.1's own no-later-than bound: silence from 3 cycles after the
     terminate word onward. *)
  let boundary = terminate_cycle + 3 in
  let delivered = List.length octets - 4 in
  let words = (delivered + 7) / 8 in
  let expected_tkeep_last =
    if Int.rem delivered 8 = 0 then 0xFF else (1 lsl Int.rem delivered 8) - 1
  in
  let tlast_cycle = start_cycle + 3 + (words - 1) in
  if terminate_cycle <> expected_terminate_cycle
  then
    fail
      row
      "test bug -- the terminate character's own cycle does not match this packet's \
       own derivation (WO-0059 §1.1 / §3.2)";
  if tlast_cycle <> expected_tlast_cycle
  then
    fail
      row
      "test bug -- the conformant tlast cycle does not match this packet's own \
       derivation";
  if boundary <> expected_boundary
  then
    fail
      row
      "test bug -- the silence boundary (terminate_cycle + 3) does not match this \
       packet's own derivation";
  if words <> expected_words
  then fail row "test bug -- the output word count does not match this packet's own derivation";
  let bench = create () in
  let samples = run bench sched ~drain:8 () in
  let tail_cycle =
    match List.last samples with
    | Some s -> s.cycle
    | None -> fail row "no samples driven"
  in
  if tail_cycle < boundary
  then
    fail
      row
      "test bug -- the run's own drain does not reach the asserted silence boundary; \
       the absence check below would be vacuous (WO-0059 §3.2)";
  let words_out = delivered_samples samples in
  if List.length words_out <> words
  then
    fail
      row
      (String.concat
         [ "expected "
         ; Int.to_string words
         ; " output words, got "
         ; Int.to_string (List.length words_out)
         ]);
  List.iteri words_out ~f:(fun m s ->
    let expected_cycle = start_cycle + 3 + m in
    if s.cycle <> expected_cycle
    then
      fail
        row
        (String.concat
           [ "word "; Int.to_string m; " arrived on cycle "; Int.to_string s.cycle; ", expected "
           ; Int.to_string expected_cycle
           ]);
    let expected_tkeep = if m = words - 1 then expected_tkeep_last else 0xFF in
    if s.out.Dv_monitors.Stream_word.tkeep <> expected_tkeep
    then fail row (String.concat [ "word "; Int.to_string m; " tkeep does not match the expected pattern" ]);
    if m = words - 1
    then (if not s.out.Dv_monitors.Stream_word.tlast then fail row "the last word does not carry tlast")
    else if s.out.Dv_monitors.Stream_word.tlast
    then fail row (String.concat [ "word "; Int.to_string m; " unexpectedly carries tlast" ]));
  let tlast_s = List.last_exn words_out in
  if tlast_s.out.Dv_monitors.Stream_word.tuser <> 0
  then fail row "tuser[0] set -- expected a clean FCS verdict";
  let expected_octets = Dv_xgmii.Frame.delivered octets in
  let got_octets = delivered_octets samples in
  if not (List.equal Int.equal got_octets expected_octets)
  then fail row "delivered octets differ from the injected frame minus its FCS";
  (* The absence, last: no output activity of any kind from 3 cycles after
     the terminate word onward -- §6.1's tight ΔC - 1 = 2-cycle drain
     window, not the looser ΔC a real drain defect this row exists to kill
     would slip through. *)
  let silent_tail = List.filter samples ~f:(fun s -> s.cycle >= boundary) in
  if List.is_empty silent_tail
  then
    fail
      row
      "test bug -- the observed silent tail is empty; this assertion would be vacuous \
       (WO-0059 §3.2)";
  if List.exists silent_tail ~f:(fun s -> s.out.Dv_monitors.Stream_word.tvalid)
  then
    fail
      row
      (String.concat
         [ "an output word was emitted at or after cycle "
         ; Int.to_string boundary
         ; ", the silence boundary 3 cycles after the terminate word (REQ-109, C-14.3)"
         ]);
  if List.exists silent_tail ~f:(fun s -> not (List.is_empty s.errors_high))
  then
    fail
      row
      (String.concat
         [ "a strobe pulsed at or after cycle "; Int.to_string boundary; " (REQ-109, C-14.3)" ]);
  if not (List.is_empty (error_pulses samples))
  then fail row "an error strobe pulsed on a clean frame";
  account_clean_frame bench frame samples ~aborted:false;
  assert_monitors_clean bench ~row
;;

let run_i2 () =
  let member_i = directed_frame_octets ~length:64 in
  let member_ii = directed_frame_octets ~length:69 in
  (* Member (i), both lanes. N = 64 = 8q + 0 (q = 8, r = 0): the same
     terminate octet time (80 at lane 0's first_start:8, 84 at lane 4's
     first_start:12) both land in cycle 10 -- the extra 4 octet times of
     first_start exactly offset N's own multiple-of-8 length -- so both
     lanes share terminate_cycle 10, conformant tlast 11 (r <= 4: one cycle
     after the terminate word, both lanes) and boundary 13. The AP row's own
     text states this coincidence for lane 0; lane 4's own value is derived
     independently here rather than assumed symmetric. *)
  run_i2_member
    ~member:"member i, 64 octets"
    ~lane:0
    ~octets:member_i
    ~expected_terminate_cycle:10
    ~expected_tlast_cycle:11
    ~expected_boundary:13
    ~expected_words:8;
  run_i2_member
    ~member:"member i, 64 octets"
    ~lane:4
    ~octets:member_i
    ~expected_terminate_cycle:10
    ~expected_tlast_cycle:11
    ~expected_boundary:13
    ~expected_words:8;
  (* Member (ii), both lanes. N = 69 = 8q + 5 (q = 8, r = 5): at lane 0 the
     terminate octet time is 85, cycle 10 (coincides with member (i)'s own
     terminate cycle, which is why the AP text can state one boundary, 13,
     for both members at lane 0); at lane 4 it is 89, cycle 11 -- ONE cycle
     later than lane 0, so the boundary is 14, not 13. r >= 5 puts the
     conformant tlast two cycles after the terminate word at BOTH lanes
     here (12 either way via the m + 3 formula), so the two lanes do NOT
     share a boundary even though they share the same tlast-to-boundary
     slack -- exactly the fact WO-0059 §3.2 warns a bench must not collapse. *)
  run_i2_member
    ~member:"member ii, 69 octets"
    ~lane:0
    ~octets:member_ii
    ~expected_terminate_cycle:10
    ~expected_tlast_cycle:12
    ~expected_boundary:13
    ~expected_words:9;
  run_i2_member
    ~member:"member ii, 69 octets"
    ~lane:4
    ~octets:member_ii
    ~expected_terminate_cycle:11
    ~expected_tlast_cycle:12
    ~expected_boundary:14
    ~expected_words:9
;;

let%expect_test
  "M03-I2: the drain window, two members (64 and 69 octets) at both start \
   lanes -- silence from 3 cycles after the terminate word onward, the \
   frame's own delivered words / tkeep / tlast cycle / clean FCS verdict as \
   the positive companion, per-member per-lane boundaries derived and \
   guarded independently (REQ-109, §6.1, C-14.3)"
  =
  run_i2 ();
  [%expect {||}]
;;

(* ==================================================================== *)
(* ---- M03-I3 -- the ordered set (REQ-113) ------------------------------ *)
(* ==================================================================== *)
(* "100 cycles of a /Q/ sequence ordered set between two frames, then a
   frame | No tvalid, no strobe during the ordered set; the frame after it
   compares word for word against the same frame received after idles only
   | A decoder that treats an unrecognised control character as data."

   Construction (WO-0059 §3.3, this file's own module docstring): ONE
   schedule, {!Bench.frames_at}'s new [?ifg] parameter set to 824 octets,
   driven TWICE on two fresh {!Bench.t} instances -- once unmodified (the
   gap is idle, [Arrival.word_at]'s own default), once with the window's
   100 cycles substituted for a pure /Q/ word through [?word_at]. The two
   runs are cycle-identical by construction, so the comparison in
   [outputs_equal] is made cycle for cycle.

   Derivation to check (WO-0059 §3.3's own, worked here): frame 1 is 64
   octets (r = 0), so its own terminate character lands in cycle 10 at BOTH
   start lanes (M03-I2's own coincidence, reused) and its own drain-safe
   boundary -- the window's own opening bound, M03-I2's derived bound reused
   rather than re-derived -- is cycle 13. With ifg = 824 (a multiple of 4,
   so no DIC rounding credit moves) counted from the terminate character
   inclusive (§0.3's own convention), the second frame's start octet time is
   terminate_ot + 824, rounded up to the next multiple of 4 (already one):
   904 at a lane-0 start (mod 8 = 0, lane 0) and 908 at a lane-4 start
   (mod 8 = 4, lane 4) -- both cycle 113, in the correct lane at both. So
   cycles 13 .. 112 are exactly 100 whole gap cycles at both lanes, and the
   window ends strictly before the second frame's own preamble (113). *)

let sequence_word =
  Dv_xgmii.Xgmii_word.of_lanes
    (List.init 8 ~f:(fun _ -> Dv_xgmii.Xgmii_word.Control Dv_xgmii.Xgmii_word.sequence_char))
;;

(* Full-cycle comparator (WO-0059 §3.3 item 2): every field {!Bench.sample}
   exposes about the DUT's own output for one cycle, field by field rather
   than by polymorphic structural equality (Stream_word.octets is the only
   sanctioned read of tdata, §6.3 item 5, so tdata itself is never compared
   directly). *)
let outputs_equal (a : sample) (b : sample) =
  Bool.equal a.out.Dv_monitors.Stream_word.tvalid b.out.Dv_monitors.Stream_word.tvalid
  && a.out.Dv_monitors.Stream_word.tkeep = b.out.Dv_monitors.Stream_word.tkeep
  && Bool.equal a.out.Dv_monitors.Stream_word.tlast b.out.Dv_monitors.Stream_word.tlast
  && a.out.Dv_monitors.Stream_word.tuser = b.out.Dv_monitors.Stream_word.tuser
  && List.equal
       Int.equal
       (Dv_monitors.Stream_word.octets a.out)
       (Dv_monitors.Stream_word.octets b.out)
  && List.equal String.equal a.errors_high b.errors_high
;;

(* Structural facts for one already-delivered frame (word count, per-word
   cycle and tkeep, tuser, content) -- factored out because M03-I3 needs it
   applied to two frames (1 and 2) across two runs (baseline and overlay),
   the same four expected values every time. *)
let assert_clean_frame_structure ~row ~label ~start_cycle octets (samples : sample list) =
  let delivered = List.length octets - 4 in
  let words = (delivered + 7) / 8 in
  let expected_tkeep_last =
    if Int.rem delivered 8 = 0 then 0xFF else (1 lsl Int.rem delivered 8) - 1
  in
  if List.length samples <> words
  then
    fail
      row
      (String.concat
         [ label
         ; ": expected "
         ; Int.to_string words
         ; " output words, got "
         ; Int.to_string (List.length samples)
         ]);
  List.iteri samples ~f:(fun m s ->
    let expected_cycle = start_cycle + 3 + m in
    if s.cycle <> expected_cycle
    then
      fail
        row
        (String.concat
           [ label; ": word "; Int.to_string m; " arrived on the wrong cycle (REQ-019)" ]);
    let expected_tkeep = if m = words - 1 then expected_tkeep_last else 0xFF in
    if s.out.Dv_monitors.Stream_word.tkeep <> expected_tkeep
    then fail row (String.concat [ label; ": word "; Int.to_string m; " tkeep mismatch" ]);
    if m = words - 1
    then
      (if not s.out.Dv_monitors.Stream_word.tlast
       then fail row (String.concat [ label; ": the last word does not carry tlast" ]))
    else if s.out.Dv_monitors.Stream_word.tlast
    then fail row (String.concat [ label; ": word "; Int.to_string m; " unexpectedly carries tlast" ]));
  (match List.last samples with
   | None -> fail row (String.concat [ label; ": no words to check tuser on" ])
   | Some s ->
     if s.out.Dv_monitors.Stream_word.tuser <> 0
     then fail row (String.concat [ label; ": tuser[0] set -- expected a clean FCS verdict" ]));
  let expected_octets = Dv_xgmii.Frame.delivered octets in
  let got_octets = List.concat_map samples ~f:(fun s -> Dv_monitors.Stream_word.octets s.out) in
  if not (List.equal Int.equal got_octets expected_octets)
  then fail row (String.concat [ label; ": delivered octets differ from its own content minus its FCS" ])
;;

let run_i3 ~lane =
  let row = String.concat [ "M03-I3 (lane "; Int.to_string lane; ")" ] in
  let frame1_octets = directed_frame_octets ~length:64 in
  let frame2_octets = directed_frame_octets ~length:68 in
  let ifg = 824 in
  let sched = frames_at ~lane ~fcs_valid:true ~ifg [ frame1_octets; frame2_octets ] in
  let frames = Dv_xgmii.Arrival.frames sched in
  let frame1 = frames.(0)
  and frame2 = frames.(1) in
  let start_cycle1 = Dv_xgmii.Arrival.start_cycle frame1 in
  let start_cycle2 = Dv_xgmii.Arrival.start_cycle frame2 in
  let terminate_cycle1 = Dv_xgmii.Arrival.terminate_octet_time frame1 / 8 in
  (* stimulus guards, checked before either run is driven (WO-0059 §2.3) *)
  if terminate_cycle1 <> 10
  then
    fail
      row
      "test bug -- frame 1's terminate character is not on cycle 10 (64-octet frame, \
       r = 0, both lanes -- M03-I2's own coincidence)";
  if start_cycle2 <> 113
  then
    fail
      row
      "test bug -- frame 2's start character is not on cycle 113 (ifg:824's own \
       derivation, WO-0059 §3.3)";
  let window_start = terminate_cycle1 + 3 in
  let window_length = 100 in
  let window_end = window_start + window_length - 1 in
  if window_start <> 13
  then fail row "test bug -- the window's own opening bound is not cycle 13 (M03-I2's own boundary, reused)";
  if window_end <> 112
  then fail row "test bug -- the window's own closing bound is not cycle 112";
  (* window_start is DEFINED as terminate_cycle1 + 3 above -- M03-I2's own
     drain-safe boundary, reused rather than re-derived (WO-0059 §3.3 item
     3) -- so that clause is guaranteed by construction; the guard below is
     the one that can actually fail: the window's own extent must still fit
     strictly before frame 2's preamble once window_length is fixed. *)
  if window_end >= start_cycle2
  then fail row "test bug -- the window reaches frame 2's own preamble";
  (* stimulus legality: the overlay's own word is a legal /Q/ ordered set on
     every lane (requirements.md §2), checked once, before either run is
     driven. *)
  if sequence_word.Dv_xgmii.Xgmii_word.control <> 0xFF
  then fail row "test bug -- the ordered-set word's control mask is not 0xFF";
  Array.iter sequence_word.Dv_xgmii.Xgmii_word.data ~f:(fun v ->
    if v <> Dv_xgmii.Xgmii_word.sequence_char
    then fail row "test bug -- the ordered-set word carries a lane that is not /Q/ (0x9C)");
  let overlay_word_at ~cycle =
    if cycle >= window_start && cycle <= window_end then sequence_word else Dv_xgmii.Arrival.word_at sched ~cycle
  in
  (* baseline run: idles fill the gap, unmodified -- the "same frame
     received after idles only" this row's own comparison is against. *)
  let baseline_bench = create () in
  let baseline_samples = run baseline_bench sched ~drain:8 () in
  let baseline_words1, baseline_rest = split_at_first_tlast (delivered_samples baseline_samples) in
  let baseline_words2, _ = split_at_first_tlast baseline_rest in
  if List.is_empty baseline_words1 || List.is_empty baseline_words2
  then fail row "baseline: expected two delivered frames (one tlast word each), got fewer";
  assert_clean_frame_structure
    ~row
    ~label:"baseline frame 1"
    ~start_cycle:start_cycle1
    frame1_octets
    baseline_words1;
  assert_clean_frame_structure
    ~row
    ~label:"baseline frame 2"
    ~start_cycle:start_cycle2
    frame2_octets
    baseline_words2;
  if not (List.is_empty (error_pulses baseline_samples))
  then fail row "baseline: an error strobe pulsed on an idle-only gap";
  account_clean_frame baseline_bench frame1 baseline_words1 ~aborted:false;
  account_clean_frame baseline_bench frame2 baseline_words2 ~aborted:false;
  assert_monitors_clean baseline_bench ~row:(row ^ " baseline");
  (* overlay run: the window's words substituted for the ordered set. *)
  let overlay_bench = create () in
  let overlay_samples =
    run overlay_bench sched ~drain:8 ~word_at:(fun ~cycle -> overlay_word_at ~cycle) ()
  in
  (* stimulus-landing check, post-run: the ordered set actually reached the
     DUT's own input on every cycle of the window, not merely the override
     function's own return value. *)
  List.iter overlay_samples ~f:(fun s ->
    if s.cycle >= window_start
       && s.cycle <= window_end
       && not (Dv_xgmii.Xgmii_word.equal s.in_word sequence_word)
    then
      fail
        row
        (String.concat
           [ "the driven word at cycle "
           ; Int.to_string s.cycle
           ; " does not carry the ordered set -- the assertions below would be vacuous"
           ]));
  let overlay_words1, overlay_rest = split_at_first_tlast (delivered_samples overlay_samples) in
  let overlay_words2, _ = split_at_first_tlast overlay_rest in
  if List.is_empty overlay_words1 || List.is_empty overlay_words2
  then fail row "overlay: expected two delivered frames (one tlast word each), got fewer";
  assert_clean_frame_structure
    ~row
    ~label:"overlay frame 1"
    ~start_cycle:start_cycle1
    frame1_octets
    overlay_words1;
  assert_clean_frame_structure
    ~row
    ~label:"overlay frame 2"
    ~start_cycle:start_cycle2
    frame2_octets
    overlay_words2;
  account_clean_frame overlay_bench frame1 overlay_words1 ~aborted:false;
  account_clean_frame overlay_bench frame2 overlay_words2 ~aborted:false;
  assert_monitors_clean overlay_bench ~row:(row ^ " overlay");
  (* the absence, next-to-last: no tvalid and no strobe during the ordered
     set, in the overlay run, checked directly (not merely inferred from
     the comparison below). *)
  List.iter overlay_samples ~f:(fun s ->
    if s.cycle >= window_start && s.cycle <= window_end
    then (
      if s.out.Dv_monitors.Stream_word.tvalid
      then
        fail
          row
          (String.concat
             [ "an output word was emitted at cycle "
             ; Int.to_string s.cycle
             ; ", inside the 100-cycle ordered set (REQ-113)"
             ]);
      if not (List.is_empty s.errors_high)
      then
        fail
          row
          (String.concat
             [ "a strobe pulsed at cycle "; Int.to_string s.cycle; ", inside the ordered set (REQ-113)" ])));
  if not (List.is_empty (error_pulses overlay_samples))
  then fail row "overlay: an error strobe pulsed -- the ordered set must not open or corrupt a frame";
  (* the exact strobe set having already been checked empty in both runs,
     last: the cycle-for-cycle comparison against the idle-only baseline,
     legitimate here because the SAME frame starts at the SAME octet time in
     both runs (WO-0059 §3.3 item 2 -- REQ-113's own "ignored" is what makes
     the gap's content irrelevant to §7's per-octet constant, not M03-A4's
     silence on cross-lane comparison, which this is not an instance of). *)
  if not (Int.equal (List.length baseline_samples) (List.length overlay_samples))
  then fail row "test bug -- the two runs drove a different number of cycles";
  List.iter2_exn baseline_samples overlay_samples ~f:(fun sb so ->
    if sb.cycle <> so.cycle
    then fail row "test bug -- cycle numbering diverged between the two runs";
    if not (outputs_equal sb so)
    then
      fail
        row
        (String.concat
           [ "cycle "
           ; Int.to_string sb.cycle
           ; ": the ordered-set run diverges from the idle-only run (REQ-113)"
           ]))
;;

let%expect_test
  "M03-I3: 100 cycles of a /Q/ ordered set between two frames, both start \
   lanes -- no tvalid and no strobe during it, the following frame checked \
   structurally on its own terms and compared cycle for cycle against the \
   same frame received after idles only (REQ-113)"
  =
  run_i3 ~lane:0;
  run_i3 ~lane:4;
  [%expect {||}]
;;

(* ==================================================================== *)
(* ---- M03-I4 -- the idle-injection wrapper (REQ-016, §6.1's gapless --- *)
(* ----            qualifier, C-14.4, C-18), highest risk --------------- *)
(* ==================================================================== *)
(* "The directed set of M03-C1 driven through an idle-injection wrapper at
   0, 1 and 7 idle cycles inside the frame | The output word sequence is
   unchanged; the per-octet constant of §7 is unchanged (16 at lane 0, 12 at
   lane 4); every octet is delayed by exactly 8 octet times per injected
   cycle; FCS verdicts unchanged | A design that decodes an idle word inside
   an open frame as eight data octets."

   {!Bench.directed_lengths} (64 .. 71 octets) x {0; 4} start lanes x
   {0; 1; 7} idle figures = 48 runs, plus one plain, un-injected baseline
   run per (length, lane) -- 16 more, 64 simulations total -- that never
   touches [Idle_injection] and exists solely to supply WO-0059 §3.4 item
   2's own delay-identity check with ground-truth octet times
   ([run_i4_length_lane]). Outer loop: lane (0 then 4). Middle loop: length,
   ascending (64 .. 71, {!Bench.directed_lengths}'s own order) -- this is
   also where each length's own baseline run is built, once, ahead of its
   three idle figures. Inner loop: idles, in §10's own figure order
   (0, 1, 7) -- named here per WO-0059 §5, since the first failing
   assertion is what a mutation campaign is sealed against and this row
   loops 48 times. *)

(* WO-0059 §2.2's own replacement for {!Bench.account_clean_frame} on an
   injected line -- see this file's module docstring. Mirrors
   [Bench.account_clean_frame]'s own shape exactly, with
   [Idle_injection.in_times] in place of [Arrival.in_times]; no
   [~expected_octets] override is needed because [Idle_injection.in_times]
   preserves the source array's own length (REQ-016 delays octets, it does
   not add or remove any), so the clean-frame identity extent
   [Bench.account_clean_frame] itself relies on still holds. *)
let account_injected_frame bench ~inj (frame : Dv_xgmii.Arrival.frame) samples ~aborted =
  Dv_monitors.Conservation_monitor.frame_in (conservation bench);
  Dv_monitors.Conservation_monitor.frame_out (conservation bench) ~aborted;
  let in_times = Dv_xgmii.Idle_injection.in_times inj frame in
  Dv_monitors.Octet_time.Latency.frame_in (latency bench) in_times;
  let delivered_pairs = List.map (delivered_samples samples) ~f:(fun s -> s.cycle, s.out) in
  Dv_monitors.Octet_time.Latency.frame_out (latency bench) (Dv_monitors.Octet_time.of_words delivered_pairs)
;;

let run_i4_case
      ~cross_latency
      ~lane
      ~length
      ~idles
      ~octets
      ~words
      ~expected_tkeep_last
      ~start_cycle
      ~baseline_tlast_cycle
      ~in_baseline
      ~out_baseline
  =
  let row =
    String.concat
      [ "M03-I4 (length "
      ; Int.to_string length
      ; ", lane "
      ; Int.to_string lane
      ; ", idles "
      ; Int.to_string idles
      ; ")"
      ]
  in
  let sched = one_frame ~lane octets in
  let frame = (Dv_xgmii.Arrival.frames sched).(0) in
  let delivered = length - 4 in
  let expected_h = if lane = 0 then 8 else 12 in
  let expected_l = if lane = 0 then 16 else 12 in
  (* stimulus legality (WO-0059 §2.3): checked before this case's own run
     is driven. *)
  let inj = Dv_xgmii.Idle_injection.uniform sched ~idles in
  if not (Dv_xgmii.Idle_injection.is_clean inj)
  then
    fail
      row
      (String.concat
         ~sep:"; "
         ("stimulus rejected by the M03-N3 constraint:" :: Dv_xgmii.Idle_injection.errors inj));
  if not (List.is_empty (Dv_xgmii.Idle_injection.errors inj))
  then fail row "test bug -- Idle_injection.errors is non-empty although is_clean reported true";
  if not (List.is_empty (Dv_xgmii.Idle_injection.c45_sites inj))
  then
    fail
      row
      "test bug -- uniform proposed a C-45 boundary; idle_injection.ml's own [uniform] \
       begins one boundary later and should never do this (WO-0059 §2.3)";
  (* §2.4: the tlast cycle is translated through Idle_injection.cycle_of,
     never recomputed from the gapless m + 3 formula (M03-I5). *)
  let injected_tlast_cycle = Dv_xgmii.Idle_injection.cycle_of inj baseline_tlast_cycle in
  let bench = create () in
  let drain = Dv_xgmii.Idle_injection.injected inj + 8 in
  let samples =
    run bench sched ~drain ~word_at:(fun ~cycle -> Dv_xgmii.Idle_injection.word_at inj ~cycle) ()
  in
  let words_out = delivered_samples samples in
  if List.length words_out <> words
  then
    fail
      row
      (String.concat
         [ "expected "
         ; Int.to_string words
         ; " output words, got "
         ; Int.to_string (List.length words_out)
         ]);
  (* the output word SEQUENCE is unchanged: every word's own cycle is the
     baseline's own translated through cycle_of, not m + 3. *)
  List.iteri words_out ~f:(fun m s ->
    let expected_baseline_cycle = start_cycle + 3 + m in
    let expected_cycle = Dv_xgmii.Idle_injection.cycle_of inj expected_baseline_cycle in
    if s.cycle <> expected_cycle
    then
      fail
        row
        (String.concat
           [ "word "
           ; Int.to_string m
           ; " arrived on cycle "
           ; Int.to_string s.cycle
           ; ", expected "
           ; Int.to_string expected_cycle
           ; " (Idle_injection.cycle_of the baseline cycle, not m + 3 -- M03-I5)"
           ]);
    let expected_tkeep = if m = words - 1 then expected_tkeep_last else 0xFF in
    if s.out.Dv_monitors.Stream_word.tkeep <> expected_tkeep
    then fail row (String.concat [ "word "; Int.to_string m; " tkeep does not match the expected pattern" ]);
    if m = words - 1
    then (if not s.out.Dv_monitors.Stream_word.tlast then fail row "the last word does not carry tlast")
    else if s.out.Dv_monitors.Stream_word.tlast
    then fail row (String.concat [ "word "; Int.to_string m; " unexpectedly carries tlast" ]));
  let tlast_s = List.last_exn words_out in
  if tlast_s.cycle <> injected_tlast_cycle
  then fail row "test bug -- the last word's own cycle does not match Idle_injection.cycle_of's own value";
  if tlast_s.out.Dv_monitors.Stream_word.tuser <> 0
  then fail row "tuser[0] set -- FCS content is unchanged by injection, expected a clean verdict";
  let expected_octets = Dv_xgmii.Frame.delivered octets in
  let got_octets = delivered_octets samples in
  if not (List.equal Int.equal got_octets expected_octets)
  then fail row "delivered octets differ -- REQ-016 must not alter frame content";
  (* WO-0059 §3.4 item 2, the delay identity in the form the packet itself
     specifies -- stronger than "L is unchanged" and independent of
     Idle_injection.cycle_of (the word-sequence check above already used
     that translator; this check is a SEPARATE derivation, off raw octet
     times, so a bug in cycle_of could not silently validate itself here).
     out_baseline/in_baseline come from an actual, separately-driven
     un-injected simulation of this same (length, lane) -- not from the
     m + 3 formula -- so this is ground truth, not a repeated prediction. *)
  let in_injected = Dv_xgmii.Idle_injection.in_times inj frame in
  let out_injected =
    Dv_monitors.Octet_time.of_words (List.map words_out ~f:(fun s -> s.cycle, s.out))
  in
  if Array.length out_injected <> delivered
  then fail row "test bug -- the injected run's own delivered octet-time array has the wrong length";
  if Array.length out_baseline <> delivered
  then fail row "test bug -- the baseline's own delivered octet-time array has the wrong length";
  for j = 0 to delivered - 1 do
    let lhs = out_injected.(j) - out_baseline.(j) in
    let rhs = in_injected.(j + 8) - in_baseline.(j + 8) in
    if lhs <> rhs
    then
      fail
        row
        (String.concat
           [ "octet "
           ; Int.to_string j
           ; ": out_injected - out_baseline = "
           ; Int.to_string lhs
           ; " but in_injected - in_baseline = "
           ; Int.to_string rhs
           ; " (REQ-016's delay identity, WO-0059 §3.4 item 2)"
           ])
  done;
  if not (List.is_empty (error_pulses samples))
  then fail row "an error strobe pulsed -- an idle-injected clean frame must not trip one";
  account_injected_frame bench ~inj frame samples ~aborted:false;
  (* the per-octet constant of §7, MEASURED for this one run, via this
     bench's own standing latency tagger -- not merely self-consistent
     (a single-frame class is trivially "constant"), but checked against
     the declared h and L for this lane. *)
  (match Dv_monitors.Octet_time.Latency.observed (latency bench) with
   | [ c ] ->
     if c.Dv_monitors.Octet_time.Latency.front_offset <> expected_h
     then
       fail
         row
         "observed front offset h is not this lane's own pinned value (§7) -- the \
          M03-N3 constraint's own measurable consequence (WO-0059 §3.4 item 3)";
     (match c.Dv_monitors.Octet_time.Latency.latencies with
      | [ l ] ->
        if l <> expected_l
        then fail row "observed per-octet constant L differs from §7's own pinned value for this lane"
      | _ -> fail row "test bug -- more than one L observed for a single-frame run")
   | _ -> fail row "test bug -- expected exactly one front-offset class for a single-frame run");
  assert_monitors_clean bench ~row;
  (* fed into the cross-run tracker too, so the "measured, at every figure"
     claim is a real multi-frame constancy demonstration and not 48
     single-frame tautologies (this file's own module docstring). *)
  Dv_monitors.Octet_time.Latency.frame_in cross_latency (Dv_xgmii.Idle_injection.in_times inj frame);
  Dv_monitors.Octet_time.Latency.frame_out
    cross_latency
    (Dv_monitors.Octet_time.of_words (List.map (delivered_samples samples) ~f:(fun s -> s.cycle, s.out)))
;;

(* One plain, un-injected simulation per (length, lane) -- shared ground
   truth for all three idle figures' own delay-identity check (WO-0059
   §3.4 item 2). Separate from the wrapper entirely: this run never touches
   [Idle_injection]. *)
let run_i4_length_lane ~cross_latency ~lane ~length =
  let row = String.concat [ "M03-I4 baseline (length "; Int.to_string length; ", lane "; Int.to_string lane; ")" ] in
  let octets = directed_frame_octets ~length in
  let delivered = length - 4 in
  let words = (delivered + 7) / 8 in
  let expected_tkeep_last =
    if Int.rem delivered 8 = 0 then 0xFF else (1 lsl Int.rem delivered 8) - 1
  in
  let baseline_sched = one_frame ~lane octets in
  let baseline_frame = (Dv_xgmii.Arrival.frames baseline_sched).(0) in
  let start_cycle = Dv_xgmii.Arrival.start_cycle baseline_frame in
  let baseline_bench = create () in
  let baseline_samples = run baseline_bench baseline_sched ~drain:8 () in
  let baseline_words = delivered_samples baseline_samples in
  if List.length baseline_words <> words
  then fail row "test bug -- the baseline run's own word count does not match the formula";
  let baseline_tlast_cycle = (List.last_exn baseline_words).cycle in
  if baseline_tlast_cycle <> start_cycle + 3 + (words - 1)
  then fail row "test bug -- the baseline's own tlast cycle does not match the gapless m + 3 formula";
  let in_baseline = Dv_xgmii.Arrival.in_times baseline_frame in
  let out_baseline =
    Dv_monitors.Octet_time.of_words (List.map baseline_words ~f:(fun s -> s.cycle, s.out))
  in
  if not (List.is_empty (error_pulses baseline_samples))
  then fail row "an error strobe pulsed on the plain, un-injected baseline run";
  account_clean_frame baseline_bench baseline_frame baseline_samples ~aborted:false;
  assert_monitors_clean baseline_bench ~row;
  List.iter [ 0; 1; 7 ] ~f:(fun idles ->
    run_i4_case
      ~cross_latency
      ~lane
      ~length
      ~idles
      ~octets
      ~words
      ~expected_tkeep_last
      ~start_cycle
      ~baseline_tlast_cycle
      ~in_baseline
      ~out_baseline)
;;

let run_i4 () =
  let cross_latency =
    Dv_monitors.Octet_time.Latency.create
      ~name:"M03-I4 cross-run"
      ~strip_octets:8
      ~tail_octets:4
      ~front_offsets:[ 8; 12 ]
      ~ceiling:4
      ()
  in
  List.iter [ 0; 4 ] ~f:(fun lane ->
    List.iter directed_lengths ~f:(fun length -> run_i4_length_lane ~cross_latency ~lane ~length));
  let row = "M03-I4 (cross-run, 48 runs)" in
  (match Dv_monitors.Octet_time.Latency.errors cross_latency with
   | [] -> ()
   | errs -> fail row (String.concat ~sep:"\n" errs));
  if not (Dv_monitors.Octet_time.Latency.is_constant cross_latency)
  then
    fail
      row
      "the per-octet constant of §7 is NOT constant across the 48 injected runs -- \
       REQ-005/REQ-111's own claim, measured";
  let classes =
    List.sort
      (Dv_monitors.Octet_time.Latency.observed cross_latency)
      ~compare:(fun (a : Dv_monitors.Octet_time.Latency.observed) b -> Int.compare a.front_offset b.front_offset)
  in
  (match classes with
   | [ c0; c4 ] ->
     if c0.Dv_monitors.Octet_time.Latency.front_offset <> 8
        || not (List.equal Int.equal c0.Dv_monitors.Octet_time.Latency.latencies [ 16 ])
     then fail row "the lane-0 class is not exactly h = 8, L = 16 across all 24 runs";
     if c0.Dv_monitors.Octet_time.Latency.frames <> 24
     then fail row "the lane-0 class did not accumulate all 24 runs";
     if c4.Dv_monitors.Octet_time.Latency.front_offset <> 12
        || not (List.equal Int.equal c4.Dv_monitors.Octet_time.Latency.latencies [ 12 ])
     then fail row "the lane-4 class is not exactly h = 12, L = 12 across all 24 runs";
     if c4.Dv_monitors.Octet_time.Latency.frames <> 24
     then fail row "the lane-4 class did not accumulate all 24 runs"
   | _ -> fail row "expected exactly two front-offset classes (lane 0 and lane 4)")
;;

let%expect_test
  "M03-I4: the M03-C1 directed set (64..71 octets) through the idle-injection \
   wrapper at 0/1/7 idle cycles, both start lanes -- 48 injected runs plus \
   16 un-injected baselines; word sequence unchanged (Idle_injection.cycle_of, \
   not m + 3), per-octet delay identity against each length/lane's own \
   baseline (raw octet times, independent of cycle_of), per-octet constant \
   unchanged and MEASURED both per run and across all 48, FCS verdicts \
   unchanged, Idle_injection.errors and c45_sites empty on every run \
   (REQ-016, §6.1's gapless qualifier, C-14.4, C-18)"
  =
  run_i4 ();
  [%expect {||}]
;;

(* ==================================================================== *)
(* ---- M03-I5 -- declared, not built (NO-ASSERT) ------------------------ *)
(* ==================================================================== *)
(* "(same runs as M03-I4) | §6.1's `m + 3` cycle formula is NOT asserted
   under injection. It is scoped to a gapless stimulus in octet times; a
   bench asserting it under idle injection fails a conformant design. The
   gap-invariant quantity is the per-octet constant, and that is what
   M03-I4 asserts | -- | NO-ASSERT."

   §6.1's own qualifier: "On a gapless stimulus ... output word m is emitted
   on the cycle m + 3 counted from the word carrying the start character."
   REQ-016's idle-injection wrapper (§10, commissioned at 0, 1 and 7 cycles
   against this very module) is not a gapless stimulus once idles > 0, so
   asserting m + 3 against an injected run would fail a design [run_i4]
   itself has already shown conformant. NOT asserted anywhere in this file:
   the m + 3 formula, applied to an injected cycle. Asserted INSTEAD,
   throughout [run_i4]: every cycle needed on the injected line is
   [Idle_injection.cycle_of] of the corresponding un-injected (gapless)
   cycle, and separately, the gap-invariant quantity §6.1 itself names --
   the per-octet constant L of §7 -- MEASURED per run and across all 48
   runs via [cross_latency].

   Discharge shape (WO-0059 §2.4, §3, item 7 of §10's own Return-log list):
   this comment, naming the row and the clause, what is not asserted and
   what is asserted instead -- `test_m03_d.ml`'s own M03-D4 shape, with no
   test function of its own. NOT `test_m03_a.ml`'s M03-A4 shape (a real
   assertion woven into the SAME unit as its positive neighbour), and the
   reason is the one WO-0059 §2.4 itself asks to be stated: A4 earns a unit
   because its own positive fact -- each lane's own ΔC = 3, independently
   asserted in [assert_own_deltac] -- is DISTINCT from A3's own assertion
   (the two-lane tuple-sequence equality) and would otherwise go
   unasserted. M03-I5's own "asserted instead" fact is not distinct from
   M03-I4's: it is M03-I4's OWN per-octet-constant assertion, verbatim, not
   a second fact I5 needs its own code to construct. Giving I5 an
   [assert_own_deltac]-shaped unit here would either duplicate [run_i4]'s
   own cross-run check under a different name, or assert nothing I5 does
   not already borrow from I4 wholesale -- neither is a positive companion
   in M03-I4's own sense (WO-0059 §2.1: "something the SAME run proves the
   receiver DID"), so D4's shape, not A4's, is the discharge this row earns.
   Recorded in this packet's Return log as a judgement call WO-0059 §3.4
   left open rather than a instruction followed. *)

(* ==================================================================== *)
(* ---- M03-I6 -- the thresholds under injection (REQ-016, REQ-107, ----- *)
(* ----            REQ-108, §6.2's Frame row) ---------------------------- *)
(* ==================================================================== *)
(* "A 64-octet frame and a 1518-octet frame, each with 7 idle cycles
   injected between every pair of words | No strobe pulses at all: the
   octet counts governing REQ-107 and REQ-108 are unchanged by idle cycles,
   so neither frame changes class | A design that counts cycles rather than
   octets toward the runt and oversize thresholds."

   Complements M03-I4 rather than repeating it (this file's own module
   docstring, WO-0059 §3.5): M03-I4 attacks the CRC half of §6.2's `Frame`
   row hold rule (a design decoding the idle word as data corrupts the
   residue); M03-I6 attacks the COUNT half (a design advancing the received
   count across an idle cycle crosses REQ-108's 1518 threshold and pulses
   `error_oversize` on a legal maximum-length frame, or crosses REQ-107's
   5-octet floor the other way). Both members driven at BOTH start lanes
   (WO-0059 §3.5's third reach fact: a design that counts CYCLES rather than
   octets toward REQ-108's 1518 is lane-asymmetric -- it overshoots by
   roughly 3 cycles' worth of octets at a lane-0 start and undershoots by
   the same margin at a lane-4 start, so driving one lane only would miss
   half of that defect's own reach). *)

let run_i6_case ~lane ~length =
  let row = String.concat [ "M03-I6 (length "; Int.to_string length; ", lane "; Int.to_string lane; ")" ] in
  let octets = directed_frame_octets ~length in
  let sched = one_frame ~lane octets in
  let frame = (Dv_xgmii.Arrival.frames sched).(0) in
  let start_cycle = Dv_xgmii.Arrival.start_cycle frame in
  let delivered = length - 4 in
  let words = (delivered + 7) / 8 in
  let expected_tkeep_last =
    if Int.rem delivered 8 = 0 then 0xFF else (1 lsl Int.rem delivered 8) - 1
  in
  let baseline_tlast_cycle = start_cycle + 3 + (words - 1) in
  let idles = 7 in
  let inj = Dv_xgmii.Idle_injection.uniform sched ~idles in
  if not (Dv_xgmii.Idle_injection.is_clean inj)
  then
    fail
      row
      (String.concat
         ~sep:"; "
         ("stimulus rejected by the M03-N3 constraint:" :: Dv_xgmii.Idle_injection.errors inj));
  if not (List.is_empty (Dv_xgmii.Idle_injection.errors inj))
  then fail row "test bug -- Idle_injection.errors is non-empty although is_clean reported true";
  if not (List.is_empty (Dv_xgmii.Idle_injection.c45_sites inj))
  then fail row "test bug -- uniform proposed a C-45 boundary";
  let injected_tlast_cycle = Dv_xgmii.Idle_injection.cycle_of inj baseline_tlast_cycle in
  let bench = create () in
  let drain = Dv_xgmii.Idle_injection.injected inj + 8 in
  let samples =
    run bench sched ~drain ~word_at:(fun ~cycle -> Dv_xgmii.Idle_injection.word_at inj ~cycle) ()
  in
  let words_out = delivered_samples samples in
  if List.length words_out <> words
  then
    fail
      row
      (String.concat
         [ "expected "
         ; Int.to_string words
         ; " output words, got "
         ; Int.to_string (List.length words_out)
         ]);
  List.iteri words_out ~f:(fun m s ->
    let expected_cycle = Dv_xgmii.Idle_injection.cycle_of inj (start_cycle + 3 + m) in
    if s.cycle <> expected_cycle
    then
      fail
        row
        (String.concat [ "word "; Int.to_string m; " arrived on the wrong cycle (Idle_injection.cycle_of)" ]);
    let expected_tkeep = if m = words - 1 then expected_tkeep_last else 0xFF in
    if s.out.Dv_monitors.Stream_word.tkeep <> expected_tkeep
    then fail row (String.concat [ "word "; Int.to_string m; " tkeep does not match the expected pattern" ]);
    if m = words - 1
    then (if not s.out.Dv_monitors.Stream_word.tlast then fail row "the last word does not carry tlast")
    else if s.out.Dv_monitors.Stream_word.tlast
    then fail row (String.concat [ "word "; Int.to_string m; " unexpectedly carries tlast" ]));
  let tlast_s = List.last_exn words_out in
  if tlast_s.cycle <> injected_tlast_cycle
  then fail row "test bug -- the last word's own cycle does not match Idle_injection.cycle_of's own value";
  if tlast_s.out.Dv_monitors.Stream_word.tuser <> 0
  then fail row "tuser[0] set -- expected a clean FCS verdict, this frame's own class is unchanged";
  let expected_octets = Dv_xgmii.Frame.delivered octets in
  let got_octets = delivered_octets samples in
  if not (List.equal Int.equal got_octets expected_octets)
  then fail row "delivered octets differ -- REQ-016 must not alter frame content";
  (* the row's own headline, last: no strobe pulses at all -- neither
     error_runt (the 64-octet member, REQ-107) nor error_oversize (the
     1518-octet member, REQ-108) fires, because the octet COUNT governing
     each threshold is unchanged by an idle cycle (REQ-016, §6.2's Frame
     row: an idle word "holds" the octet count, it does not advance it). *)
  if not (List.is_empty (error_pulses samples))
  then
    fail
      row
      "an error strobe pulsed -- idle injection must not change which REQ-107/REQ-108 \
       class this frame falls into";
  account_injected_frame bench ~inj frame samples ~aborted:false;
  assert_monitors_clean bench ~row
;;

let run_i6 () =
  List.iter [ 0; 4 ] ~f:(fun lane ->
    (* the 64-octet member: stimulus M03-I4 already drives at idles:7
       (WO-0059 §3.5) -- its value here is as the anti-vacuity companion to
       the 1518-octet member's own silence, not as new coverage. *)
    run_i6_case ~lane ~length:64;
    run_i6_case ~lane ~length:1518)
;;

let%expect_test
  "M03-I6: a 64-octet frame and a 1518-octet frame, each with 7 idle cycles \
   injected between every pair of words, both start lanes -- no strobe \
   pulses at all, delivered content and clean FCS verdict unchanged \
   (REQ-016, REQ-107, REQ-108, §6.2's Frame row)"
  =
  run_i6 ();
  [%expect {||}]
;;
