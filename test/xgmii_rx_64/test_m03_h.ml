(** Family H — start without terminate (REQ-110, §9). WO-0057.

    Four rows (`AP-xgmii_rx_64.md` §4.H), built in the packet's own
    risk-ranked order (WO-0057 §2), M03-H4 LAST: M03-H1 (ASSERT, [run_h1]),
    M03-H3 (ASSERT, [run_h3]), M03-H2 (ASSERT, [run_h2]), M03-H4 (ASSERT,
    [run_h4]).

    {2 The construction this whole file shares, and why the obvious two-frame
    [Injection.create] shape is wrong for it}

    REQ-110 says a new `/S/` "SHALL begin a new frame AT THAT START
    CHARACTER" — the second frame's own preamble starts immediately, with NO
    idle gap. [Injection.create [case1; case2]]'s ordinary two-[frame_case]
    layout does not produce that: it schedules [case2] at its own
    independent position ([case1]'s declared terminate octet time plus
    [ifg]), with an inter-frame gap of idle characters in between — the
    stimulus M03-B4 already uses for an ordinary two-frame run, and the wrong
    shape here.

    Every row below instead builds ONE [Injection] [frame_case] whose own
    declared array is a SPLICE: some octets that are delivered before an
    injected `/S/` (or, for M03-H3, an `/E/`), then a placeholder octet that
    the `Place` corruption turns into the closing/aborting character, then —
    with no gap — 7 more octets that serve as the OPENED frame's own preamble
    positions 1-7 (REQ-102, values unchecked), then that frame's own real
    content, closing on the ARRAY's OWN NATURAL terminate character, which
    [Arrival] places automatically right after the declared array ends. This
    is exactly `test_m03_g.ml`'s M03-G7 device (“a frame the STIMULUS itself
    opens mid-array has no [Arrival.frame] record”), generalised from a
    runt-sized leftover to a full, independently-chosen following frame by
    making the array long enough to hold one. [Injection]'s own per-octet
    walker (`injection.ml`'s [outcomes]) evaluates every character at its own
    octet time regardless of which [frame_case] it nominally belongs to, so
    the model correctly reports the SECOND (and, at M03-H4, third) frame it
    finds mid-array — confirmed by hand-tracing [outcomes]'s own state
    machine against every row below before trusting [fail_cross] on it, not
    merely by running it.

    {2 Per-member governance (WO-0057 §3.1's own deliverable)}

    Every FIRST (aborted) frame in every row below is governed by REQ-110's
    no-removal clause: the last delivered octet is the one immediately
    preceding the new `/S/` (or, at M03-H3, REQ-105's own no-removal clause
    for the `/E/`-closed frame), and `Frame.delivered` is never used for it —
    the family-G/H trap restated (WO-0054 §2, WO-0057 §1). Every SECOND (or,
    at M03-H4, THIRD) frame in every row is an ordinary frame closing on a
    genuine terminate character, governed by REQ-103's ordinary removal, and
    is checked against `Dv_xgmii.Frame.delivered` of its own declared
    content. M03-H4's frame A and frame B both deliver ZERO octets (REQ-110's
    §0.7 zero-delivered clause) and have no delivered content to govern at
    all.

    {2 The §0.6 window for a zero-delivered frame, and where the "received =
    0" branch of that window comes from}

    Every zero-delivered frame in this file (M03-H4's frame A and frame B)
    uses `requirements.md` §0.6's window computed from the CLOSING character's
    own word at both ends — `not_before` = that word's own cycle, `not_after`
    = that SAME cycle + 3 — which is `test_m03_f.ml`'s [run_f2] `k = 0`
    form, itself grounded in the architect's ruling on M03-G6 (SPEC-M03 §9,
    2026-08-04, `J-architect_docs_lead-0021`): for a frame with no referent
    for "the input word carrying its last octet", the reference word is the
    input word carrying the character that CLOSED it. WO-0057 §3.2 raises
    whether that ruling's principle generalises to every zero-delivered
    closure as an open question for the architect; it blocks no row here,
    because the exact pin — not the window — carries every assertion below,
    exactly as `RV-0047` ruling 2 holds standing.

    {2 M03-H4's C-23 instrument (WO-0057 §2.4)}

    Frame A's and frame B's own `error_start_without_terminate` reports land
    on CONSECUTIVE cycles (c + 2, c + 3). [Dv_monitors.Strobe_monitor] is
    registered with TWO separate [expect] events, one cycle each, and
    [error_pulses] is asserted to be exactly those two (cycle, name) pairs —
    never hand-counted, never collapsed into "the strobe went high" as a
    single fact. This is what makes a rising-edge counter fail this row where
    a high-cycle counter (the monitor's own C-23 implementation) passes a
    conformant M03.

    {2 X-5 (WO-0054 §5's entry point), on the abort extent this family adds}

    Every aborted (REQ-110-governed) frame below is accounted through
    {!account_spliced_forwarded} `~aborted:true`, which supplies
    [Dv_monitors.Octet_time.Latency.frame_out]'s own `~expected_octets`
    override at the frame's actual delivered count rather than the
    clean-frame identity — X-5's own documented customer list already names
    M03-H1 and M03-H2 and this is their first exercise, alongside M03-H3's
    (folded in here since it shares the identical construction).

    {2 Octet times and lanes — every constant here is a derivation with a
    guard, per WO-0057 §4}

    Every row's own function opens with a `test bug` guard checking the
    closing/aborting character's own octet time and lane against what the
    row's text requires — never trusted from the arithmetic alone. M03-H2's
    `k` is chosen per start lane specifically because REQ-101's lane rule
    binds the CHARACTER's own absolute lane (4), not the frame it interrupts:
    at a lane-0 start `k mod 8` must be 4, at a lane-4 start it must be 0 —
    both derived and guarded, not assumed symmetric. M03-H3's `/S/` is placed
    exactly 16 octet times (two cycles) after the `/E/`, both landing on lane
    0, so "two cycles later" is an exact, checked claim. M03-H4 is driven at
    a single, fixed geometry (frame A always starts at lane 0) because that
    is the only start lane at which "both `/S/` in one word" (the row's own
    text) is reachable — starting frame A at lane 4 puts its own preamble
    position 4 in the NEXT cycle, not the same word, which is a different
    stimulus REQ-110's own commissioned case already covers (M03-B4, cited
    but not built by this packet — WO-0057 §1).

    {2 Assertion order (WO-0047 §4.2, restated here since this is a new file)}

    Every row: construction-site guards (lane/cycle checks) → the model
    cross-check ([fail_cross]) → stimulus-landing checks (pre-run then
    post-run, WO-0047 §6 item 7) → structural facts (word count, `tlast`
    cycle, `tkeep`, `tuser`) → delivered CONTENT (M03-H2's own whole point,
    still in its usual place per WO-0057 §5) → the EXACT strobe set, last.
    Iteration: M03-H1/H2/H3 at both start lanes (lane 0 then lane 4); M03-H4
    at its own single fixed geometry.

    {2 Independence}

    Every expected value is read from `docs/specs/modules/xgmii_rx_64.md`
    §6.1, §6.2, §6.3 items 6 and 8, §7, §9 (the closure list, the fifth
    co-occurrence ruling, rows 8 and 9, the "Strobe cycle, pinned" section
    including its no-output-word clause and its 2026-08-04 zero-referent
    paragraphs), §10's REQ-110 hook, and `docs/specs/requirements.md`
    REQ-110, REQ-101, REQ-103, REQ-105, REQ-021, REQ-008, REQ-007, §0.6
    (including its C-23 counting-convention paragraph), §0.3, §0.7 — cited
    inline. Plus `test/xgmii/injection.ml`/`.mli` (read in full, including
    [outcomes]'s own implementation, to confirm the splice construction is
    evaluated correctly by the model before trusting [fail_cross] on it —
    the [At_preamble]/[At_octet] placement-to-octet-time arithmetic at
    `injection.ml:159-166` and the per-octet-time walker at
    `injection.ml:284-446` both read directly, not assumed from the `.mli`
    alone), `test/xgmii/arrival.mli`, `test/xgmii/xgmii_word.mli`,
    `test/xgmii_rx_64/bench.mli`, `test/monitors/strobe_monitor.mli`,
    `test/monitors/octet_time.mli`, `test/monitors/conservation_monitor.mli`.
    `test/xgmii_rx_64/test_m03_e.ml`, `test_m03_f.ml` and `test_m03_g.ml`
    read as idiom reference (`fail_cross`, `split_at_first_tlast`, the
    zero-delivered accounting shape, M03-G7's splice precedent — named where
    reused). `agents/handoffs/WO-0057_tb-m03-family-h-start-without-terminate.md`
    in full. `libs/**`, `top/**`, `bin/**`, `rtl_snapshots/**` and every path
    under `docs/reports/audit/**` were not opened, at any point in this
    spawn. *)

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

(* Duplicated from every other family file's own local helper of the same
   shape rather than shared, per this packet's own convention: {!Bench} is
   the only shared surface. *)
let split_at_first_tlast samples =
  let rec go acc = function
    | [] -> List.rev acc, []
    | (s : sample) :: rest ->
      if s.out.Dv_monitors.Stream_word.tlast then List.rev (s :: acc), rest else go (s :: acc) rest
  in
  go [] samples
;;

(* [n] deterministic, position-dependent filler octets -- distinguishable by
   construction from {!Bench.directed_frame_octets}'s own pattern, so a
   defect that delivered the WRONG piece's octets (this row's neighbour's,
   say) is visible as a content mismatch rather than an accidental match. *)
let filler n = List.init n ~f:(fun j -> (j * 13 + 5) land 0xFF)

(* The 7 preamble-position filler octets (REQ-102: values unchecked) that
   follow every spliced closing/opening character in this file -- position 0
   of the opened frame's own preamble IS that character itself; positions
   1..7 are these. *)
let preamble_tail = List.init 7 ~f:(fun j -> 0xC0 + j)

(* Accounting for a piece that delivers content but has no genuine
   [Arrival.frame] record of its own -- every frame in this file's rows is
   spliced inside a single, longer [Injection] [frame_case] (module
   docstring's construction note), so [Latency.frame_in]'s usual
   [Arrival.in_times frame] source does not exist for any of them. Hand-built
   from octet times instead, generalising `test_m03_g.ml`'s own
   [account_resync_runt_frame] (there, zero-delivered only) to the forwarded
   case X-5 names for this family.

   [~received] versus [~delivered] (WO-0059 §7.3, `RV-0057-VERDICT` Finding 1
   -- the first of this packet's two owed, outcome-neutral repairs). The
   INPUT TRACE must be sized by what the frame RECEIVED while open
   (requirements.md §0.6's own window definition), not by what it DELIVERED
   at the output: for an aborted (REQ-110/REQ-105-governed) frame the two
   coincide because no FCS removal is attempted (REQ-103's no-removal
   clause), but for an ordinary, cleanly-closed frame -- every second/third
   piece in this file -- received is delivered PLUS the four FCS octets
   REQ-103 strips. Building the trace from [delivered] alone was four octet
   times short for every clean piece and sat exactly on [frame_out]'s own
   stated bound (octet_time.mli: "output octet j is still input octet
   j + strip_octets"); it was harmless only by cancellation, because
   [frame_out]'s own per-octet walk reads [in_times.(j + strip_octets)] for
   j in 0 .. delivered - 1, an index range [Array.init]'s VALUES never
   depend on the array's own length -- [received] is therefore the honest
   size and [delivered] stays the extent override, unchanged. *)
let account_spliced_forwarded bench ~start_ot ~received ~delivered ~aborted samples =
  Dv_monitors.Conservation_monitor.frame_in (conservation bench);
  Dv_monitors.Conservation_monitor.frame_out (conservation bench) ~aborted;
  let in_times = Array.init (8 + received) ~f:(fun i -> start_ot + i) in
  Dv_monitors.Octet_time.Latency.frame_in (latency bench) in_times;
  let delivered_pairs = List.map samples ~f:(fun s -> s.cycle, s.out) in
  Dv_monitors.Octet_time.Latency.frame_out
    (latency bench)
    ~expected_octets:delivered
    (Dv_monitors.Octet_time.of_words delivered_pairs)
;;

(* The zero-delivered shape (M03-H4's frame A and frame B): §0.6 accounts for
   it through its STROBE alone, never through an emitted [frame_out] --
   `test_m03_e.ml`'s/`test_m03_f.ml`'s/`test_m03_g.ml`'s own
   [account_dropped_frame]/[account_resync_runt_frame] shape, duplicated here
   per this packet's own file-local convention. *)
let account_spliced_dropped bench ~start_ot ~received ~strobe =
  Dv_monitors.Conservation_monitor.frame_in (conservation bench);
  Dv_monitors.Conservation_monitor.discarded (conservation bench) ~strobes:[ strobe ];
  let in_times = Array.init (8 + received) ~f:(fun i -> start_ot + i) in
  Dv_monitors.Octet_time.Latency.frame_in (latency bench) in_times;
  Dv_monitors.Octet_time.Latency.frame_dropped (latency bench)
;;

(* ---- M03-H1 ------------------------------------------------------------ *)
(* "A 64-octet frame whose terminate character is replaced by a new /S/ in
   lane 0, followed by a complete frame | The aborted frame's last delivered
   octet is the one immediately preceding the new /S/; tuser[0]=1; exactly
   one error_start_without_terminate; no FCS removed (four octets more
   delivered than a clean frame of the same length); the second frame
   received intact." REQ-110, REQ-103.

   Splice: 64 filler octets (all delivered -- the /S/ replaces what would be
   the terminate position, so REQ-110's last-delivered-octet rule is octet
   63, all 64 of the frame's own octets), then the /S/ (At_octet 64), then 7
   preamble-filler octets, then a clean 64-octet frame. At_octet 64's own
   octet time is start_ot + 8 + 64, and since 72 is a multiple of 8 this
   always lands in the SAME lane as the outer frame's own start -- lane 0 at
   a lane-0 start, lane 4 at a lane-4 start -- so driving both lanes
   exercises exactly REQ-110's own verification column ("in lane 0 and in
   lane 4"), even though this row's own AP text only spells out "lane 0". *)

let run_h1 ~lane =
  let row = String.concat [ "M03-H1 (lane "; Int.to_string lane; ")" ] in
  let frame1_len = 64 in
  let frame2_octets = directed_frame_octets ~length:64 in
  let close_idx = frame1_len in
  let base = filler frame1_len @ [ 0x00 ] @ preamble_tail @ frame2_octets in
  let case =
    Dv_xgmii.Injection.corrupt
      base
      [ Dv_xgmii.Injection.Place
          { placement = Dv_xgmii.Injection.At_octet close_idx
          ; character = Dv_xgmii.Xgmii_word.start_char
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
  let outer = (Dv_xgmii.Arrival.frames sched).(0) in
  let start_ot1 = outer.Dv_xgmii.Arrival.start_octet_time in
  let start_cycle1 = Dv_xgmii.Arrival.start_cycle outer in
  let close_ot = start_ot1 + 8 + close_idx in
  if Int.rem close_ot 8 <> 0 && Int.rem close_ot 8 <> 4
  then fail row "test bug -- the spliced /S/ does not land in lane 0 or lane 4";
  let close_cycle = close_ot / 8 in
  let delivered1 = close_idx in
  let words1 = (delivered1 + 7) / 8 in
  let expected_tlast_cycle1 = start_cycle1 + 3 + (words1 - 1) in
  let expected_not_before1 = close_ot / 8 in
  let expected_not_after1 = ((close_ot - 1) / 8) + 3 in
  let resync_start_ot = close_ot in
  let resync_start_cycle = resync_start_ot / 8 in
  let delivered2 = 64 - 4 in
  let words2 = (delivered2 + 7) / 8 in
  let expected_tlast_cycle2 = resync_start_cycle + 3 + (words2 - 1) in
  let expected_tkeep2 =
    if Int.rem delivered2 8 = 0 then 0xFF else (1 lsl Int.rem delivered2 8) - 1
  in
  (match Dv_xgmii.Injection.outcomes inj with
   | [ o1; o2 ] ->
     if o1.Dv_xgmii.Injection.delivered <> delivered1 then fail_cross row "frame 1 delivered";
     (match o1.Dv_xgmii.Injection.reports with
      | [ r ]
        when String.equal r.Dv_xgmii.Injection.strobe "error_start_without_terminate"
             && r.Dv_xgmii.Injection.cycle = expected_tlast_cycle1
             && r.Dv_xgmii.Injection.not_before = expected_not_before1
             && r.Dv_xgmii.Injection.not_after = expected_not_after1 -> ()
      | _ -> fail_cross row "frame 1 reports");
     if o2.Dv_xgmii.Injection.delivered <> delivered2 then fail_cross row "frame 2 delivered";
     if not (List.is_empty o2.Dv_xgmii.Injection.reports) then fail_cross row "frame 2 reports"
   | outcomes ->
     fail_cross
       row
       (String.concat
          [ "outcome count (expected 2, got "; Int.to_string (List.length outcomes); ")" ]));
  let close_lane = Int.rem close_ot 8 in
  let pre_run_word = Dv_xgmii.Injection.word_at inj ~cycle:close_cycle in
  if (not (Dv_xgmii.Xgmii_word.is_control pre_run_word close_lane))
     || not
          (Int.equal
             (pre_run_word.Dv_xgmii.Xgmii_word.data).(close_lane)
             Dv_xgmii.Xgmii_word.start_char)
  then fail row "test bug -- the spliced /S/ does not land at the intended octet time before driving";
  let bench = create () in
  Dv_monitors.Strobe_monitor.expect
    (strobes bench)
    { Dv_monitors.Strobe_monitor.strobe = "error_start_without_terminate"
    ; frame = 0
    ; cycle = expected_tlast_cycle1
    ; not_before = expected_not_before1
    ; not_after = expected_not_after1
    ; why =
        "REQ-110 (new /S/ replacing the terminate character, all 64 octets delivered); \
         SPEC-M03 §9 'Strobe cycle, pinned' puts it on the aborted frame's own tlast \
         cycle, start_cycle + 3 + 7 via §7's per-octet constant"
    };
  let samples =
    run bench sched ~drain:8 ~word_at:(fun ~cycle -> Dv_xgmii.Injection.word_at inj ~cycle) ()
  in
  (match List.find samples ~f:(fun s -> s.cycle = close_cycle) with
   | None -> fail row "test bug -- the intended /S/ cycle was never driven"
   | Some s ->
     if (not (Dv_xgmii.Xgmii_word.is_control s.in_word close_lane))
        || not
             (Int.equal
                (s.in_word.Dv_xgmii.Xgmii_word.data).(close_lane)
                Dv_xgmii.Xgmii_word.start_char)
     then
       fail
         row
         "the driven word at the intended cycle does not carry the spliced /S/ -- the \
          assertions below would be vacuous");
  let words1_out, rest = split_at_first_tlast (delivered_samples samples) in
  let words2_out, _ = split_at_first_tlast rest in
  if List.is_empty words1_out || List.is_empty words2_out
  then fail row "expected two delivered frames (one tlast word each), got fewer";
  if List.length words1_out <> words1
  then
    fail
      row
      (String.concat
         [ "frame 1: expected "
         ; Int.to_string words1
         ; " output words, got "
         ; Int.to_string (List.length words1_out)
         ]);
  let tlast1 = List.last_exn words1_out in
  if tlast1.cycle <> expected_tlast_cycle1
  then fail row "frame 1: tlast word did not arrive on start_cycle + 3 + 7 (REQ-019)";
  if tlast1.out.Dv_monitors.Stream_word.tkeep <> 0xFF
  then
    fail
      row
      "frame 1: tkeep is not 0xFF -- all 64 octets are delivered, no FCS removed \
       (REQ-103's no-removal clause)";
  if tlast1.out.Dv_monitors.Stream_word.tuser <> 1
  then fail row "frame 1: tuser[0] is not set on an aborted frame (REQ-007, REQ-110)";
  let got1 = List.concat_map words1_out ~f:(fun (s : sample) -> Dv_monitors.Stream_word.octets s.out) in
  if not (List.equal Int.equal got1 (filler frame1_len))
  then
    fail
      row
      "frame 1: delivered octets differ from the 64 octets injected before the /S/ -- \
       REQ-110's no-removal clause, not Frame.delivered's FCS-removal identity (WO-0057 §2.1)";
  if List.length words2_out <> words2
  then fail row "frame 2: expected 8 output words, got a different count";
  let tlast2 = List.last_exn words2_out in
  if tlast2.cycle <> expected_tlast_cycle2
  then fail row "frame 2: tlast word did not arrive on its own start_cycle + 3 + 7 (REQ-019)";
  if tlast2.out.Dv_monitors.Stream_word.tkeep <> expected_tkeep2
  then fail row "frame 2: tkeep does not match its own 60 delivered octets (0x0F)";
  if tlast2.out.Dv_monitors.Stream_word.tuser <> 0
  then fail row "frame 2: tuser[0] set -- the second frame is legal and intact";
  let got2 = List.concat_map words2_out ~f:(fun (s : sample) -> Dv_monitors.Stream_word.octets s.out) in
  if not (List.equal Int.equal got2 (Dv_xgmii.Frame.delivered frame2_octets))
  then fail row "frame 2: delivered octets differ from its own 60 -- must arrive intact";
  (match error_pulses samples with
   | [ (cycle, name) ] ->
     if not (String.equal name "error_start_without_terminate")
     then fail row (String.concat [ "expected error_start_without_terminate alone, observed "; name ])
     else if cycle <> expected_tlast_cycle1
     then fail row "error_start_without_terminate pulsed on the wrong cycle"
   | pulses ->
     fail
       row
       (String.concat
          [ "expected exactly one strobe (error_start_without_terminate alone -- no \
             error_bad_fcs, §9 ruling 4), observed "
          ; Int.to_string (List.length pulses)
          ]));
  (* WO-0059 §7.3 Finding 1: frame 1 is REQ-110-aborted, so received =
     delivered (no FCS removal is attempted, REQ-103); frame 2 is an
     ordinary clean frame, so received is its own 64 octets DA through FCS,
     four more than the 60 it delivers. *)
  account_spliced_forwarded
    bench
    ~start_ot:start_ot1
    ~received:delivered1
    ~delivered:delivered1
    ~aborted:true
    words1_out;
  account_spliced_forwarded
    bench
    ~start_ot:resync_start_ot
    ~received:(List.length frame2_octets)
    ~delivered:delivered2
    ~aborted:false
    words2_out;
  Dv_monitors.Conservation_monitor.strobe_pulse (conservation bench) ~name:"error_start_without_terminate";
  assert_monitors_clean bench ~row
;;

let%expect_test
  "M03-H1: terminate replaced by a new /S/, both start lanes -- all 64 \
   octets delivered (no FCS removed), exactly one \
   error_start_without_terminate, the second frame received intact \
   (REQ-110, REQ-103)"
  =
  run_h1 ~lane:0;
  run_h1 ~lane:4;
  [%expect {||}]
;;

(* ---- M03-H3 -------------------------------------------------------------- *)
(* "/E/ mid-frame, then a /S/ two cycles later | Exactly one error_bad_frame
   and no error_start_without_terminate; the frame the /S/ opens is received
   normally." REQ-110, REQ-105, §9's fifth ruling.

   Since the /E/ CLOSES the first frame (§9's closure list; REQ-105: "a frame
   the receiver has already closed... is not reopened by a later error
   character"), the /S/ two cycles later is simply an ordinary new frame's
   own start -- not a REQ-110 event at all. Splice: e_idx filler octets
   (delivered), the /E/ (At_octet e_idx), 15 filler octets, the /S/ (At_octet
   e_idx + 16), 7 preamble-filler octets, a clean 64-octet frame. e_idx is
   chosen per start lane so the /E/'s own octet time lands at lane 0 -- which
   makes "two cycles later" (16 octet times) land the /S/ at lane 0 too, an
   exact, guarded claim rather than an approximation.

   WO-0059 §7.3 Finding 4 (`RV-0057-VERDICT` Finding 4): this row's exact
   strobe set rests on those 15 filler octets between the /E/ and the /S/
   pulsing nothing and opening nothing while no frame is open over them --
   and the ground for that is SPEC-M03 §6.2's `Idle` row itself: "ignores
   every lane; tvalid = 0", leaving to `Preamble` only on /S/ (§9's own
   closure list and REQ-105 pin what happens AT the /E/ and AT the /S/, but
   it is §6.2's `Idle` row that governs the fifteen data-valued octets
   strictly between them). M03-I1 and M03-I3 (`test/xgmii_rx_64/
   test_m03_i.ml`, WO-0059) rest on the identical clause -- REQ-109's silent
   pipeline and REQ-113's ordered set are both instances of the same `Idle`
   row governing a stretch of octets between two frames -- which is why the
   three land together at this packet's one touch of family H. *)

let run_h3 ~lane =
  let row = String.concat [ "M03-H3 (lane "; Int.to_string lane; ")" ] in
  let e_idx = if lane = 0 then 24 else 20 in
  let gap_idx = 16 in
  let s_idx = e_idx + gap_idx in
  let frame2_octets = directed_frame_octets ~length:64 in
  let base =
    filler e_idx
    @ [ 0x00 ]
    @ List.init (gap_idx - 1) ~f:(fun j -> 0x80 + j)
    @ [ 0x00 ]
    @ preamble_tail
    @ frame2_octets
  in
  let case =
    Dv_xgmii.Injection.corrupt
      base
      [ Dv_xgmii.Injection.Place
          { placement = Dv_xgmii.Injection.At_octet e_idx; character = Dv_xgmii.Xgmii_word.error_char }
      ; Dv_xgmii.Injection.Place
          { placement = Dv_xgmii.Injection.At_octet s_idx; character = Dv_xgmii.Xgmii_word.start_char }
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
  let outer = (Dv_xgmii.Arrival.frames sched).(0) in
  let start_ot1 = outer.Dv_xgmii.Arrival.start_octet_time in
  let start_cycle1 = Dv_xgmii.Arrival.start_cycle outer in
  let e_ot = start_ot1 + 8 + e_idx in
  let e_cycle = e_ot / 8 in
  let s_ot = start_ot1 + 8 + s_idx in
  let s_cycle = s_ot / 8 in
  if s_cycle <> e_cycle + 2
  then fail row "test bug -- the spliced /S/ does not land exactly two cycles after the /E/";
  if Int.rem s_ot 8 <> 0 && Int.rem s_ot 8 <> 4
  then fail row "test bug -- the spliced /S/ does not land in lane 0 or lane 4";
  let delivered1 = e_idx in
  let words1 = (delivered1 + 7) / 8 in
  let expected_tkeep1 =
    if Int.rem delivered1 8 = 0 then 0xFF else (1 lsl Int.rem delivered1 8) - 1
  in
  let expected_tlast_cycle1 = start_cycle1 + 3 + (words1 - 1) in
  let expected_not_before1 = e_ot / 8 in
  let expected_not_after1 = ((e_ot - 1) / 8) + 3 in
  let resync_start_ot = s_ot in
  let resync_start_cycle = resync_start_ot / 8 in
  let delivered2 = 64 - 4 in
  let words2 = (delivered2 + 7) / 8 in
  let expected_tlast_cycle2 = resync_start_cycle + 3 + (words2 - 1) in
  let expected_tkeep2 =
    if Int.rem delivered2 8 = 0 then 0xFF else (1 lsl Int.rem delivered2 8) - 1
  in
  (match Dv_xgmii.Injection.outcomes inj with
   | [ o1; o2 ] ->
     if o1.Dv_xgmii.Injection.delivered <> delivered1 then fail_cross row "frame 1 delivered";
     (match o1.Dv_xgmii.Injection.reports with
      | [ r ]
        when String.equal r.Dv_xgmii.Injection.strobe "error_bad_frame"
             && r.Dv_xgmii.Injection.cycle = expected_tlast_cycle1
             && r.Dv_xgmii.Injection.not_before = expected_not_before1
             && r.Dv_xgmii.Injection.not_after = expected_not_after1 -> ()
      | _ -> fail_cross row "frame 1 reports");
     if o2.Dv_xgmii.Injection.delivered <> delivered2 then fail_cross row "frame 2 delivered";
     if not (List.is_empty o2.Dv_xgmii.Injection.reports) then fail_cross row "frame 2 reports"
   | outcomes ->
     fail_cross
       row
       (String.concat
          [ "outcome count (expected 2, got "; Int.to_string (List.length outcomes); ")" ]));
  let e_lane = Int.rem e_ot 8 in
  let s_lane = Int.rem s_ot 8 in
  let pre_run_e = Dv_xgmii.Injection.word_at inj ~cycle:e_cycle in
  if (not (Dv_xgmii.Xgmii_word.is_control pre_run_e e_lane))
     || not
          (Int.equal
             (pre_run_e.Dv_xgmii.Xgmii_word.data).(e_lane)
             Dv_xgmii.Xgmii_word.error_char)
  then fail row "test bug -- the /E/ does not land at the intended octet time before driving";
  let pre_run_s = Dv_xgmii.Injection.word_at inj ~cycle:s_cycle in
  if (not (Dv_xgmii.Xgmii_word.is_control pre_run_s s_lane))
     || not
          (Int.equal
             (pre_run_s.Dv_xgmii.Xgmii_word.data).(s_lane)
             Dv_xgmii.Xgmii_word.start_char)
  then fail row "test bug -- the /S/ does not land at the intended octet time before driving";
  let bench = create () in
  Dv_monitors.Strobe_monitor.expect
    (strobes bench)
    { Dv_monitors.Strobe_monitor.strobe = "error_bad_frame"
    ; frame = 0
    ; cycle = expected_tlast_cycle1
    ; not_before = expected_not_before1
    ; not_after = expected_not_after1
    ; why =
        "REQ-105 (error character while the frame is open, >= 1 octet delivered); \
         SPEC-M03 §9 'Strobe cycle, pinned' puts it on the aborted frame's own tlast cycle"
    };
  let samples =
    run bench sched ~drain:8 ~word_at:(fun ~cycle -> Dv_xgmii.Injection.word_at inj ~cycle) ()
  in
  (match List.find samples ~f:(fun s -> s.cycle = e_cycle) with
   | None -> fail row "test bug -- the intended /E/ cycle was never driven"
   | Some s ->
     if (not (Dv_xgmii.Xgmii_word.is_control s.in_word e_lane))
        || not
             (Int.equal (s.in_word.Dv_xgmii.Xgmii_word.data).(e_lane) Dv_xgmii.Xgmii_word.error_char)
     then
       fail
         row
         "the driven word at the intended cycle does not carry the /E/ -- the assertions \
          below would be vacuous");
  (match List.find samples ~f:(fun s -> s.cycle = s_cycle) with
   | None -> fail row "test bug -- the intended /S/ cycle was never driven"
   | Some s ->
     if (not (Dv_xgmii.Xgmii_word.is_control s.in_word s_lane))
        || not
             (Int.equal (s.in_word.Dv_xgmii.Xgmii_word.data).(s_lane) Dv_xgmii.Xgmii_word.start_char)
     then
       fail
         row
         "the driven word at the intended cycle does not carry the /S/ -- the assertions \
          below would be vacuous");
  let words1_out, rest = split_at_first_tlast (delivered_samples samples) in
  let words2_out, _ = split_at_first_tlast rest in
  if List.is_empty words1_out || List.is_empty words2_out
  then fail row "expected two delivered frames (one tlast word each), got fewer";
  if List.length words1_out <> words1 then fail row "frame 1: unexpected output word count";
  let tlast1 = List.last_exn words1_out in
  if tlast1.cycle <> expected_tlast_cycle1
  then fail row "frame 1: tlast word did not arrive on its own pinned cycle";
  if tlast1.out.Dv_monitors.Stream_word.tkeep <> expected_tkeep1
  then fail row "frame 1: tkeep does not match its own delivered octets";
  if tlast1.out.Dv_monitors.Stream_word.tuser <> 1
  then fail row "frame 1: tuser[0] is not set on an /E/-aborted frame (REQ-105)";
  let got1 = List.concat_map words1_out ~f:(fun (s : sample) -> Dv_monitors.Stream_word.octets s.out) in
  if not (List.equal Int.equal got1 (filler e_idx))
  then fail row "frame 1: delivered octets differ from the octets immediately preceding the /E/";
  if List.length words2_out <> words2 then fail row "frame 2: unexpected output word count";
  let tlast2 = List.last_exn words2_out in
  if tlast2.cycle <> expected_tlast_cycle2
  then fail row "frame 2: tlast word did not arrive on its own start_cycle + 3 + 7 (REQ-019)";
  if tlast2.out.Dv_monitors.Stream_word.tkeep <> expected_tkeep2
  then fail row "frame 2: tkeep does not match its own 60 delivered octets";
  if tlast2.out.Dv_monitors.Stream_word.tuser <> 0
  then fail row "frame 2: tuser[0] set -- the frame the /S/ opens is received normally";
  let got2 = List.concat_map words2_out ~f:(fun (s : sample) -> Dv_monitors.Stream_word.octets s.out) in
  if not (List.equal Int.equal got2 (Dv_xgmii.Frame.delivered frame2_octets))
  then fail row "frame 2: delivered octets differ from its own 60 -- must arrive intact";
  (match error_pulses samples with
   | [ (cycle, name) ] ->
     if not (String.equal name "error_bad_frame")
     then fail row (String.concat [ "expected error_bad_frame alone, observed "; name ])
     else if cycle <> expected_tlast_cycle1
     then fail row "error_bad_frame pulsed on the wrong cycle"
   | pulses ->
     fail
       row
       (String.concat
          [ "expected exactly one strobe (error_bad_frame alone -- NO \
             error_start_without_terminate, §9's fifth ruling, since the /E/ already \
             closed the frame before the /S/ arrives), observed "
          ; Int.to_string (List.length pulses)
          ]));
  (* WO-0059 §7.3 Finding 1: frame 1 is REQ-105-aborted (no FCS removal
     attempted), so received = delivered; frame 2 is an ordinary clean
     frame, received = its own 64 octets DA through FCS. *)
  account_spliced_forwarded
    bench
    ~start_ot:start_ot1
    ~received:delivered1
    ~delivered:delivered1
    ~aborted:true
    words1_out;
  account_spliced_forwarded
    bench
    ~start_ot:resync_start_ot
    ~received:(List.length frame2_octets)
    ~delivered:delivered2
    ~aborted:false
    words2_out;
  Dv_monitors.Conservation_monitor.strobe_pulse (conservation bench) ~name:"error_bad_frame";
  assert_monitors_clean bench ~row
;;

let%expect_test
  "M03-H3: /E/ mid-frame, then a /S/ exactly two cycles later, both start \
   lanes -- exactly one error_bad_frame and no \
   error_start_without_terminate, the frame the /S/ opens received normally \
   (REQ-110, REQ-105, §9's fifth ruling)"
  =
  run_h3 ~lane:0;
  run_h3 ~lane:4;
  [%expect {||}]
;;

(* ---- M03-H2 -------------------------------------------------------------- *)
(* "A new /S/ in lane 4 of a mid-frame word, i.e. lanes 0-3 of that word
   still belong to the aborted frame | Those four octets are delivered as
   part of the aborted frame (tkeep and the delivered count prove it); one
   strobe; the new frame begins at lane 4 and is received intact and
   correctly aligned." REQ-110, REQ-101, REQ-021.

   The highest-value row in the family (WO-0057 §2.3): a design that
   switches its alignment offset on the SAME cycle it accepts the new /S/
   rotates the aborted frame's trailing four octets by the NEW offset and
   loses them silently -- a REQ-008 hole with no strobe and a plausible
   tkeep. Caught only by asserting the delivered CONTENT, which this row
   does (not just tkeep and the count).

   Splice: k filler octets (delivered), the /S/ (At_octet k), 7
   preamble-filler octets, a clean 64-octet frame. k is chosen PER START
   LANE so the /S/'s own ABSOLUTE lane is always 4 -- REQ-101's lane rule
   binds the character, not the frame it interrupts: at a lane-0 start (start
   octet time mod 8 = 0) that needs k mod 8 = 4; at a lane-4 start (mod 8 =
   4) it needs k mod 8 = 0. Both are guarded below, not assumed symmetric. *)

let run_h2 ~lane =
  let row = String.concat [ "M03-H2 (lane "; Int.to_string lane; ")" ] in
  let k = if lane = 0 then 12 else 16 in
  let frame2_octets = directed_frame_octets ~length:64 in
  let base = filler k @ [ 0x00 ] @ preamble_tail @ frame2_octets in
  let case =
    Dv_xgmii.Injection.corrupt
      base
      [ Dv_xgmii.Injection.Place
          { placement = Dv_xgmii.Injection.At_octet k; character = Dv_xgmii.Xgmii_word.start_char }
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
  let outer = (Dv_xgmii.Arrival.frames sched).(0) in
  let start_ot1 = outer.Dv_xgmii.Arrival.start_octet_time in
  let start_cycle1 = Dv_xgmii.Arrival.start_cycle outer in
  let close_ot = start_ot1 + 8 + k in
  if Int.rem close_ot 8 <> 4
  then fail row "test bug -- the spliced /S/ does not land in lane 4 (this row's own point)";
  let close_cycle = close_ot / 8 in
  let delivered1 = k in
  let words1 = (delivered1 + 7) / 8 in
  let expected_tkeep1 =
    if Int.rem delivered1 8 = 0 then 0xFF else (1 lsl Int.rem delivered1 8) - 1
  in
  let expected_tlast_cycle1 = start_cycle1 + 3 + (words1 - 1) in
  let expected_not_before1 = close_ot / 8 in
  let expected_not_after1 = ((close_ot - 1) / 8) + 3 in
  let resync_start_ot = close_ot in
  let resync_start_cycle = resync_start_ot / 8 in
  let delivered2 = 64 - 4 in
  let words2 = (delivered2 + 7) / 8 in
  let expected_tlast_cycle2 = resync_start_cycle + 3 + (words2 - 1) in
  let expected_tkeep2 =
    if Int.rem delivered2 8 = 0 then 0xFF else (1 lsl Int.rem delivered2 8) - 1
  in
  (match Dv_xgmii.Injection.outcomes inj with
   | [ o1; o2 ] ->
     if o1.Dv_xgmii.Injection.delivered <> delivered1 then fail_cross row "frame 1 delivered";
     (match o1.Dv_xgmii.Injection.reports with
      | [ r ]
        when String.equal r.Dv_xgmii.Injection.strobe "error_start_without_terminate"
             && r.Dv_xgmii.Injection.cycle = expected_tlast_cycle1
             && r.Dv_xgmii.Injection.not_before = expected_not_before1
             && r.Dv_xgmii.Injection.not_after = expected_not_after1 -> ()
      | _ -> fail_cross row "frame 1 reports");
     if o2.Dv_xgmii.Injection.delivered <> delivered2 then fail_cross row "frame 2 delivered";
     if not (List.is_empty o2.Dv_xgmii.Injection.reports) then fail_cross row "frame 2 reports"
   | outcomes ->
     fail_cross
       row
       (String.concat
          [ "outcome count (expected 2, got "; Int.to_string (List.length outcomes); ")" ]));
  let close_lane = Int.rem close_ot 8 in
  let pre_run_word = Dv_xgmii.Injection.word_at inj ~cycle:close_cycle in
  if (not (Dv_xgmii.Xgmii_word.is_control pre_run_word close_lane))
     || not
          (Int.equal
             (pre_run_word.Dv_xgmii.Xgmii_word.data).(close_lane)
             Dv_xgmii.Xgmii_word.start_char)
  then fail row "test bug -- the spliced /S/ does not land at the intended octet time before driving";
  let bench = create () in
  Dv_monitors.Strobe_monitor.expect
    (strobes bench)
    { Dv_monitors.Strobe_monitor.strobe = "error_start_without_terminate"
    ; frame = 0
    ; cycle = expected_tlast_cycle1
    ; not_before = expected_not_before1
    ; not_after = expected_not_after1
    ; why =
        "REQ-110 (new /S/ in lane 4 of a mid-frame word, >= 1 octet delivered); SPEC-M03 \
         §9 'Strobe cycle, pinned' puts it on the aborted frame's own tlast cycle"
    };
  let samples =
    run bench sched ~drain:8 ~word_at:(fun ~cycle -> Dv_xgmii.Injection.word_at inj ~cycle) ()
  in
  (match List.find samples ~f:(fun s -> s.cycle = close_cycle) with
   | None -> fail row "test bug -- the intended /S/ cycle was never driven"
   | Some s ->
     if (not (Dv_xgmii.Xgmii_word.is_control s.in_word close_lane))
        || not
             (Int.equal
                (s.in_word.Dv_xgmii.Xgmii_word.data).(close_lane)
                Dv_xgmii.Xgmii_word.start_char)
     then
       fail
         row
         "the driven word at the intended cycle does not carry the spliced /S/ -- the \
          assertions below would be vacuous");
  let words1_out, rest = split_at_first_tlast (delivered_samples samples) in
  let words2_out, _ = split_at_first_tlast rest in
  if List.is_empty words1_out || List.is_empty words2_out
  then fail row "expected two delivered frames (one tlast word each), got fewer";
  if List.length words1_out <> words1 then fail row "frame 1: unexpected output word count";
  let tlast1 = List.last_exn words1_out in
  if tlast1.cycle <> expected_tlast_cycle1
  then fail row "frame 1: tlast word did not arrive on its own pinned cycle";
  if tlast1.out.Dv_monitors.Stream_word.tkeep <> expected_tkeep1
  then fail row "frame 1: tkeep does not match its own delivered octets";
  if tlast1.out.Dv_monitors.Stream_word.tuser <> 1
  then fail row "frame 1: tuser[0] is not set on an aborted frame (REQ-007, REQ-110)";
  (* This row's own point (WO-0057 §2.3, §5): assert the CONTENT, not just
     tkeep and the count. *)
  let got1 = List.concat_map words1_out ~f:(fun (s : sample) -> Dv_monitors.Stream_word.octets s.out) in
  if not (List.equal Int.equal got1 (filler k))
  then
    fail
      row
      "frame 1: delivered octets differ from the k octets injected before the /S/ -- the \
       silent-rotation/silent-drop defect this row exists to kill (WO-0057 §2.3)";
  if List.length words2_out <> words2 then fail row "frame 2: unexpected output word count";
  let tlast2 = List.last_exn words2_out in
  if tlast2.cycle <> expected_tlast_cycle2
  then fail row "frame 2: tlast word did not arrive on its own start_cycle + 3 + 7 (REQ-019)";
  if tlast2.out.Dv_monitors.Stream_word.tkeep <> expected_tkeep2
  then fail row "frame 2: tkeep does not match its own 60 delivered octets";
  if tlast2.out.Dv_monitors.Stream_word.tuser <> 0
  then fail row "frame 2: tuser[0] set -- the new frame is received intact";
  let got2 = List.concat_map words2_out ~f:(fun (s : sample) -> Dv_monitors.Stream_word.octets s.out) in
  if not (List.equal Int.equal got2 (Dv_xgmii.Frame.delivered frame2_octets))
  then
    fail
      row
      "frame 2: delivered octets differ from its own 60 -- the new frame must arrive \
       intact and correctly aligned";
  (match error_pulses samples with
   | [ (cycle, name) ] ->
     if not (String.equal name "error_start_without_terminate")
     then fail row (String.concat [ "expected error_start_without_terminate alone, observed "; name ])
     else if cycle <> expected_tlast_cycle1
     then fail row "error_start_without_terminate pulsed on the wrong cycle"
   | pulses ->
     fail
       row
       (String.concat
          [ "expected exactly one strobe (error_start_without_terminate alone), observed "
          ; Int.to_string (List.length pulses)
          ]));
  (* WO-0059 §7.3 Finding 1: frame 1 is REQ-110-aborted (no FCS removal
     attempted), so received = delivered; frame 2 is an ordinary clean
     frame, received = its own 64 octets DA through FCS. *)
  account_spliced_forwarded
    bench
    ~start_ot:start_ot1
    ~received:delivered1
    ~delivered:delivered1
    ~aborted:true
    words1_out;
  account_spliced_forwarded
    bench
    ~start_ot:resync_start_ot
    ~received:(List.length frame2_octets)
    ~delivered:delivered2
    ~aborted:false
    words2_out;
  Dv_monitors.Conservation_monitor.strobe_pulse (conservation bench) ~name:"error_start_without_terminate";
  assert_monitors_clean bench ~row
;;

let%expect_test
  "M03-H2: a new /S/ in lane 4 of a mid-frame word, both start lanes -- the \
   four preceding octets delivered as part of the aborted frame (content \
   asserted, not just tkeep and count), one strobe, the new frame received \
   intact and correctly aligned (REQ-110, REQ-101, REQ-021)"
  =
  run_h2 ~lane:0;
  run_h2 ~lane:4;
  [%expect {||}]
;;

(* ---- M03-H4 -------------------------------------------------------------- *)
(* "/S/ in lane 0 and lane 4 of one word (cycle c), then /S/ in lane 0 of the
   next word (cycle c + 1), then a complete frame | Two zero-delivered
   aborts... their error_start_without_terminate high cycles at c + 2 and
   c + 3, consecutively; no output word for either; the final frame received
   intact." REQ-110, §0.7, §0.6's counting convention, C-23.

   Driven at a SINGLE, fixed geometry -- frame A always starts at lane 0 --
   because that is the only start lane at which "both /S/ in one word" is
   reachable: starting frame A at lane 4 puts its own preamble position 4 in
   the NEXT cycle, a different stimulus (REQ-110's own commissioned
   lane-4-of-an-S-word case, M03-B4, cited by WO-0057 §1 but not built by
   this packet).

   Splice: ONE Injection frame_case, a 72-octet array (1 placeholder + 7
   preamble filler + a clean 64-octet frame), with TWO corruptions: [Place
   {At_preamble 4; start_char}] (frame A's own preamble position 4 -- the
   SECOND /S/, at octet time start_ot_a + 4, lane 4 of cycle c) and [Place
   {At_octet 0; start_char}] (frame A's own declared content index 0, which
   is ALSO frame B's own preamble position 4, since frame B opens at
   start_ot_a + 4 -- the THIRD /S/, at octet time start_ot_a + 8, lane 0 of
   cycle c + 1). Both are legal at every start lane by construction (REQ-101
   §0.5's own arithmetic: an 8-octet preamble is a multiple of 8, so a
   position-4 or position-8 offset from ANY multiple-of-4 start octet time
   always lands on lane 0 or lane 4), and the array's own genuine terminate
   character, auto-placed by Arrival right after all 72 array octets, is
   exactly where the final, complete frame's own terminate belongs (its
   first real octet is array index 8, 64 octets later is array index 72).
   [Injection.outcomes]'s own per-octet-time walker was hand-traced against
   this construction before trusting [fail_cross] on it (module docstring's
   Independence section) and agrees exactly with the cycle/window arithmetic
   below, derived independently from §9's own no-output-word pin and
   requirements.md §0.6's window. *)

let run_h4 () =
  let row = "M03-H4" in
  let frame_c_octets = directed_frame_octets ~length:64 in
  let base = [ 0x00 ] @ preamble_tail @ frame_c_octets in
  let case =
    Dv_xgmii.Injection.corrupt
      base
      [ Dv_xgmii.Injection.Place
          { placement = Dv_xgmii.Injection.At_preamble 4; character = Dv_xgmii.Xgmii_word.start_char }
      ; Dv_xgmii.Injection.Place
          { placement = Dv_xgmii.Injection.At_octet 0; character = Dv_xgmii.Xgmii_word.start_char }
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
  let outer = (Dv_xgmii.Arrival.frames sched).(0) in
  let start_ot_a = outer.Dv_xgmii.Arrival.start_octet_time in
  let c = Dv_xgmii.Arrival.start_cycle outer in
  if Int.rem start_ot_a 8 <> 0
  then fail row "test bug -- frame A's own start is not lane 0 -- this row's geometry only holds there";
  let ot_2 = start_ot_a + 4 in
  let ot_3 = start_ot_a + 8 in
  if ot_2 / 8 <> c then fail row "test bug -- the second /S/ is not in the same word as frame A (cycle c)";
  if Int.rem ot_2 8 <> 4 then fail row "test bug -- the second /S/ is not in lane 4";
  if ot_3 / 8 <> c + 1 then fail row "test bug -- the third /S/ is not in the next word (cycle c + 1)";
  if Int.rem ot_3 8 <> 0 then fail row "test bug -- the third /S/ is not in lane 0";
  let expected_not_before_a = ot_2 / 8 in
  let expected_not_after_a = expected_not_before_a + 3 in
  let expected_cycle_a = expected_not_before_a + 2 in
  let expected_not_before_b = ot_3 / 8 in
  let expected_not_after_b = expected_not_before_b + 3 in
  let expected_cycle_b = expected_not_before_b + 2 in
  let start_ot_c = ot_3 in
  let start_cycle_c = start_ot_c / 8 in
  let delivered_c = 64 - 4 in
  let words_c = (delivered_c + 7) / 8 in
  let expected_tlast_cycle_c = start_cycle_c + 3 + (words_c - 1) in
  let expected_tkeep_c =
    if Int.rem delivered_c 8 = 0 then 0xFF else (1 lsl Int.rem delivered_c 8) - 1
  in
  (match Dv_xgmii.Injection.outcomes inj with
   | [ oa; ob; oc ] ->
     if oa.Dv_xgmii.Injection.delivered <> 0 then fail_cross row "frame A delivered (expected 0)";
     (match oa.Dv_xgmii.Injection.reports with
      | [ r ]
        when String.equal r.Dv_xgmii.Injection.strobe "error_start_without_terminate"
             && r.Dv_xgmii.Injection.cycle = expected_cycle_a
             && r.Dv_xgmii.Injection.not_before = expected_not_before_a
             && r.Dv_xgmii.Injection.not_after = expected_not_after_a -> ()
      | _ -> fail_cross row "frame A reports");
     if ob.Dv_xgmii.Injection.delivered <> 0 then fail_cross row "frame B delivered (expected 0)";
     (match ob.Dv_xgmii.Injection.reports with
      | [ r ]
        when String.equal r.Dv_xgmii.Injection.strobe "error_start_without_terminate"
             && r.Dv_xgmii.Injection.cycle = expected_cycle_b
             && r.Dv_xgmii.Injection.not_before = expected_not_before_b
             && r.Dv_xgmii.Injection.not_after = expected_not_after_b -> ()
      | _ -> fail_cross row "frame B reports");
     if oc.Dv_xgmii.Injection.delivered <> delivered_c then fail_cross row "frame C delivered";
     if not (List.is_empty oc.Dv_xgmii.Injection.reports) then fail_cross row "frame C reports"
   | outcomes ->
     fail_cross
       row
       (String.concat
          [ "outcome count (expected 3: frame A, frame B, frame C; got "
          ; Int.to_string (List.length outcomes)
          ; ")"
          ]));
  let pre_run_c = Dv_xgmii.Injection.word_at inj ~cycle:c in
  if (not (Dv_xgmii.Xgmii_word.is_control pre_run_c 0))
     || not (Int.equal (pre_run_c.Dv_xgmii.Xgmii_word.data).(0) Dv_xgmii.Xgmii_word.start_char)
  then fail row "test bug -- frame A's own /S/ does not land at lane 0 of cycle c before driving";
  if (not (Dv_xgmii.Xgmii_word.is_control pre_run_c 4))
     || not (Int.equal (pre_run_c.Dv_xgmii.Xgmii_word.data).(4) Dv_xgmii.Xgmii_word.start_char)
  then fail row "test bug -- the second /S/ does not land at lane 4 of cycle c before driving";
  let pre_run_c1 = Dv_xgmii.Injection.word_at inj ~cycle:(c + 1) in
  if (not (Dv_xgmii.Xgmii_word.is_control pre_run_c1 0))
     || not (Int.equal (pre_run_c1.Dv_xgmii.Xgmii_word.data).(0) Dv_xgmii.Xgmii_word.start_char)
  then fail row "test bug -- the third /S/ does not land at lane 0 of cycle c + 1 before driving";
  let bench = create () in
  Dv_monitors.Strobe_monitor.expect
    (strobes bench)
    { Dv_monitors.Strobe_monitor.strobe = "error_start_without_terminate"
    ; frame = 0
    ; cycle = expected_cycle_a
    ; not_before = expected_not_before_a
    ; not_after = expected_not_after_a
    ; why =
        "REQ-110 (frame A aborted strictly inside its own preamble, zero delivered); \
         SPEC-M03 §9's no-output-word pin: two cycles after the input word carrying the \
         closing character (the second /S/, cycle c)"
    };
  Dv_monitors.Strobe_monitor.expect
    (strobes bench)
    { Dv_monitors.Strobe_monitor.strobe = "error_start_without_terminate"
    ; frame = 1
    ; cycle = expected_cycle_b
    ; not_before = expected_not_before_b
    ; not_after = expected_not_after_b
    ; why =
        "REQ-110 (frame B, opened by the second /S/, aborted strictly inside its own \
         preamble by the third /S/, zero delivered); SPEC-M03 §9's no-output-word pin: \
         two cycles after the input word carrying the closing character (the third /S/, \
         cycle c + 1) -- consecutive with frame A's own report, C-23's counting \
         convention (two high cycles, not one edge)"
    };
  let samples =
    run bench sched ~drain:8 ~word_at:(fun ~cycle -> Dv_xgmii.Injection.word_at inj ~cycle) ()
  in
  (match List.find samples ~f:(fun s -> s.cycle = c) with
   | None -> fail row "test bug -- cycle c was never driven"
   | Some s ->
     if (not (Dv_xgmii.Xgmii_word.is_control s.in_word 0))
        || not (Int.equal (s.in_word.Dv_xgmii.Xgmii_word.data).(0) Dv_xgmii.Xgmii_word.start_char)
     then fail row "the driven word at cycle c does not carry frame A's own /S/ in lane 0";
     if (not (Dv_xgmii.Xgmii_word.is_control s.in_word 4))
        || not (Int.equal (s.in_word.Dv_xgmii.Xgmii_word.data).(4) Dv_xgmii.Xgmii_word.start_char)
     then
       fail
         row
         "the driven word at cycle c does not carry the second /S/ in lane 4 -- the \
          assertions below would be vacuous");
  (match List.find samples ~f:(fun s -> s.cycle = c + 1) with
   | None -> fail row "test bug -- cycle c + 1 was never driven"
   | Some s ->
     if (not (Dv_xgmii.Xgmii_word.is_control s.in_word 0))
        || not (Int.equal (s.in_word.Dv_xgmii.Xgmii_word.data).(0) Dv_xgmii.Xgmii_word.start_char)
     then
       fail
         row
         "the driven word at cycle c + 1 does not carry the third /S/ in lane 0 -- the \
          assertions below would be vacuous");
  let words_c_out, _ = split_at_first_tlast (delivered_samples samples) in
  if List.is_empty words_c_out
  then fail row "expected one delivered frame (frame C's own tlast word), got none";
  if List.length (delivered_samples samples) <> List.length words_c_out
  then
    fail
      row
      "an output word was observed outside frame C -- frame A and frame B must each \
       deliver nothing (REQ-110, §0.7)";
  if List.length words_c_out <> words_c then fail row "frame C: unexpected output word count";
  let tlast_c = List.last_exn words_c_out in
  if tlast_c.cycle <> expected_tlast_cycle_c
  then fail row "frame C: tlast word did not arrive on its own start_cycle + 3 + 7 (REQ-019)";
  if tlast_c.out.Dv_monitors.Stream_word.tkeep <> expected_tkeep_c
  then fail row "frame C: tkeep does not match its own 60 delivered octets";
  if tlast_c.out.Dv_monitors.Stream_word.tuser <> 0
  then fail row "frame C: tuser[0] set -- the final frame is legal and intact";
  let got_c = List.concat_map words_c_out ~f:(fun (s : sample) -> Dv_monitors.Stream_word.octets s.out) in
  if not (List.equal Int.equal got_c (Dv_xgmii.Frame.delivered frame_c_octets))
  then fail row "frame C: delivered octets differ from its own 60 -- the final frame must arrive intact";
  (* This row's own point, last: TWO error_start_without_terminate high
     cycles, consecutive -- two events under C-23's counting convention,
     which a rising-edge counter would report as one. *)
  (match error_pulses samples with
   | [ (c1, n1); (c2, n2) ] ->
     if not (String.equal n1 "error_start_without_terminate" && c1 = expected_cycle_a)
     then fail row "the first strobe is not error_start_without_terminate on frame A's own pinned cycle (c + 2)";
     if not (String.equal n2 "error_start_without_terminate" && c2 = expected_cycle_b)
     then fail row "the second strobe is not error_start_without_terminate on frame B's own pinned cycle (c + 3)";
     if c2 <> c1 + 1
     then fail row "the two strobe cycles are not consecutive -- this row's own point (C-23)"
   | pulses ->
     fail
       row
       (String.concat
          [ "expected exactly two error_start_without_terminate high cycles, consecutive \
             (c + 2 and c + 3) -- observed "
          ; Int.to_string (List.length pulses)
          ]));
  account_spliced_dropped bench ~start_ot:start_ot_a ~received:0 ~strobe:"error_start_without_terminate";
  account_spliced_dropped bench ~start_ot:ot_2 ~received:0 ~strobe:"error_start_without_terminate";
  (* WO-0059 §7.3 Finding 1: frame C is an ordinary clean frame, received =
     its own 64 octets DA through FCS, four more than the 60 it delivers. *)
  account_spliced_forwarded
    bench
    ~start_ot:start_ot_c
    ~received:(List.length frame_c_octets)
    ~delivered:delivered_c
    ~aborted:false
    words_c_out;
  Dv_monitors.Conservation_monitor.strobe_pulse (conservation bench) ~name:"error_start_without_terminate";
  Dv_monitors.Conservation_monitor.strobe_pulse (conservation bench) ~name:"error_start_without_terminate";
  assert_monitors_clean bench ~row
;;

let%expect_test
  "M03-H4: /S/ in lane 0 and lane 4 of one word (cycle c), then /S/ in lane \
   0 of the next word (cycle c + 1), then a complete frame -- two \
   zero-delivered aborts at c + 2 and c + 3 (consecutive high cycles, C-23), \
   no output word for either, the final frame received intact (REQ-110, \
   §0.7, §0.6's counting convention, C-23)"
  =
  run_h4 ();
  [%expect {||}]
;;
