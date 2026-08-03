(** Family G — oversize frames (REQ-108, §6.2's [Discard], §9). WO-0054.

    Six rows (`AP-xgmii_rx_64.md` §4.G): M03-G1 (ASSERT, [run_g1]), M03-G2
    (ASSERT, [run_g2_legal] / [run_g2_oversize]), M03-G3 (ASSERT, [run_g3]),
    M03-G4 (ASSERT, [run_g4]), M03-G5 (NO-ASSERT, declared at the bottom of
    this file, nothing to run), M03-G6 (ASSERT, [run_g6]).

    {2 The governance declaration (WO-0054 §2's own deliverable, stated once
    here and repeated at each row)}

    `Dv_xgmii.Frame.delivered` implements REQ-103's FCS-removal identity
    (input octets minus the trailing four FCS octets) and is the RIGHT oracle
    only for a frame that closes on its own genuine terminate character
    within the first 1518 octets. REQ-108's truncation is a DIFFERENT
    function: exactly 1514 delivered octets, always, regardless of how long
    the received frame actually is. Calling [Frame.delivered] on any member
    that exceeds 1518 octets gives the WRONG answer (1515 for a 1519-octet
    frame, 1596 for a 1600-octet one) while looking exactly like a correct
    REQ-103 computation. Per member, governed by:

    - M03-G1's first (1600-octet) frame — REQ-108's truncation, 1514 exactly.
      Its second (64-octet) frame — REQ-103's removal, [Frame.delivered].
    - M03-G2's 1518-octet member — REQ-103's removal ([Frame.delivered]
      octets1518, which is 1514 — coinciding NUMERICALLY with REQ-108's
      constant is the row's own sharp point, WO-0054 §2). Its 1519-octet
      member — REQ-108's truncation, the literal 1514 constant, NEVER
      [Frame.delivered] (which would give 1515, one too many).
    - M03-G3's first (1600-octet) frame — REQ-108's truncation, 1514. Its
      second (a genuinely separate, ordinary 64-octet frame opened by its own
      start character) — REQ-103's removal.
    - M03-G4's first (1600-octet) frame — REQ-108's truncation, 1514. Its
      second (following) frame — REQ-103's removal.
    - M03-G6's first (1600-octet) frame — REQ-108's truncation, 1514. Its
      second (following) frame — REQ-103's removal.

    Every truncated member below asserts delivered content as [List.take
    octets 1514] (the frame's own first 1514 octets, exactly REQ-108's "no
    FCS stripping is attempted" text) and NEVER as [Frame.delivered octets].
    [truncated_delivered]/[truncated_words]/[truncated_tkeep] below are the
    one place the 1514/190/0x03 constants are derived, so every row cites the
    same computation rather than five independent copies of it.

    {2 The §0.6 window — WO-0054's own open question, ANSWERED before this
    spawn began (WO-0054 §8 deliverable 3)}

    `docs/specs/modules/xgmii_rx_64.md` §9 gained three paragraphs on
    2026-08-04 (`J-architect_docs_lead-0021`), explicitly captioned as
    answering "dv_lead's row M03-G6, raised as `WO-0054` §9.1 open question
    1": the §0.6 window's reference word for a frame no terminate character
    closes is the input word on which REQ-108's OWN truncation closed it —
    fixed at the truncation cycle, independent of whatever follows, and not a
    genuine vacuity (carry-forward C-5's shape, which this explicitly is
    not). This is TIGHTER than WO-0054 §3.6's own fallback instruction ("use
    the widest defensible upper bound"), and every row below uses this exact,
    now-normative reference word rather than the fallback — stated once here
    because it changes what WO-0054 §3.6 asked for, not because any row's own
    citation needs restating. [closing_ot]/[not_before]/[not_after] are
    computed identically at every row below: not_before = the cycle of the
    input word carrying the 1519th received octet (array index 1518,
    zero-based — the octet whose arrival passes 1518 and triggers
    REQ-108); not_after = that same cycle + ΔC (3, §7), because the frame's
    last octet WHILE OPEN is that same octet (its "last octet" in §0.6's
    sense, per the ruling above, is not extended by whatever arrives after
    closure).

    {2 §3.5's answer (WO-0054 §8 deliverable 2): Dv_xgmii.Injection CAN
    express M03-G6's unterminated-frame stimulus, and this file does not use
    it to do so}

    [Injection.create]'s validation places NO restriction on
    [Place{placement = At_terminate; character}] beyond [is_control_char
    character] (`test/xgmii/injection.ml:102-124` — the [At_terminate] arm of
    the placement match is a bare [()], unlike [At_octet]'s lane-open
    restriction and [At_preamble]'s range check). [Xgmii_word.idle_char] is
    one of requirements.md §2's five control characters, so
    [Place{placement=At_terminate; character=Xgmii_word.idle_char}] is
    accepted by [Injection.create] without complaint: it replaces the wire
    octet at exactly the frame's own natural terminate position with an idle
    character instead, so no `/T/` character ever appears on the wire for
    that frame at all — precisely "a frame exceeding 1518 octets that is not
    closed by a terminate character before the next start character arrives"
    (WO-0054 §3.5's own specification-terms restatement). This is established
    by reading `test/xgmii/injection.ml`'s own committed source (already
    sanctioned reading, `test/`, not `libs/`), not invented.

    Established, and NOT what [run_g6] below builds with. [run_g6] instead
    overrides the SAME single octet time — [Dv_xgmii.Arrival.terminate_octet_time
    frame1], a value {!Dv_xgmii.Arrival} already computes with no need for
    [Injection] at all — via {!Bench.run}'s own [?word_at] hook
    (`test_m03_e.ml`'s [run_e4] precedent, generalised from "a stray character
    in an inter-frame gap" to "a stray character AT a frame's own would-be
    terminate position"). Both routes produce the IDENTICAL wire trace at
    that one octet time; [run_g6] takes the one that needs no [Injection]
    object, no [Injection.create] validation pass and no cross-check idiom
    for a fact ([Arrival.terminate_octet_time]) this file already has to hand
    from the schedule it built directly. This is a "simpler machinery already
    suffices" finding, the same shape M03-E4's own §4 trap answer 3 recorded,
    not a finding that [Injection] cannot do it — the capability is
    established above precisely so that claim is not conflated with this
    file's own implementation choice.

    {2 M03-G3/G4's construction — considered and rejected alternatives, stated
    because WO-0054 asks for stimulus choices to be reported (§4, WO-0043 §1
    precedent)}

    Both rows need a character to land some distance past the truncation
    point. Three routes were considered:

    - {b Splice a self-contained second frame inside the SAME, longer, array}
      (an `At_terminate`-shaped construction extended with a fake preamble and
      a genuine [Frame.with_fcs] tail). Rejected for M03-G3: workable in
      principle, but it makes the "new frame"'s own FCS correctness a fact
      about exactly where the splice lands rather than about an ordinary,
      independently-schedulable frame, which is more moving parts than the
      row needs.
    - {b `Place` an injected character at `At_octet k` on a longer array, via
      [Injection.create]}. This is what M03-G3's `/S/` would need if built
      through [Injection] — `At_octet` additionally checks that a placed
      [start_char] lands in lane 0 or lane 4 (`injection.ml:165-175`), which
      content-index 1618 (literally "100 octets past truncation") does NOT
      satisfy (1618 mod 8 = 2) at either start lane — REQ-101 forbids a start
      character there regardless of mechanism, so 100 exactly is not a legal
      landing point and some rounding is unavoidable whichever route is
      taken. M03-G4's `/E/` has no such lane restriction, so this route
      WOULD work for G4 alone, at the cost of extending the base array well
      past 1600 octets purely to make index 1618 addressable (`At_octet`
      requires [k < Array.length octets]).
    - {b An ordinary, separately-scheduled second [Arrival] frame, with a
      custom [ifg] chosen so its own start lands at (or, for M03-G3, near)
      the target octet time, plus (for M03-G4 only) a single [?word_at]
      override for the stray `/E/` — no [Injection] at all.} This is what
      both rows use. It needs no array extension (M03-G4's octets stay
      literally 1600, matching the row's own words) and, for M03-G3, the
      "new frame" is a genuinely independent, ordinarily-scheduled,
      already-well-tested [Arrival] frame — its FCS correctness is a
      structural fact about [Frame.with_fcs], not about where a splice
      landed.

    M03-G3's own /S/ therefore lands at the NEAREST REQ-101-legal offset to
    "100 octets past truncation" — content-index 1620 (102 octets past),
    since 1618 (100 past) and 1616 (98 past) are equidistant and 1620 mod 8 =
    4 is the one this file picked; stated and verified in [run_g3], not
    assumed. M03-G4's /E/ lands at the LITERAL 100-octets-past-truncation
    octet time, since `/E/` carries no lane restriction at all.

    {2 X-5 confirmed (WO-0054 §5's deliverable)}

    `Dv_monitors.Octet_time.Latency.frame_out`'s [?expected_octets] parameter
    (`test/monitors/octet_time.mli`, WO-0033 items X-5/X-9) already names
    M03's own rows E1, F1, G1, G2, H1, H2 as its intended customers in its own
    committed docstring, and `test_m03_e.ml`'s [account_aborted_frame]
    already exercises it for a partially-delivered, non-identity extent
    (M03-E1). [account_truncated_frame] below is the SAME primitive, called
    with the literal constant [truncated_delivered] (1514) rather than a
    per-row-computed one, confirming it accepts a 1514-octet extent from an
    input trace many hundreds of octets longer (1519 up to 1700, across this
    file's rows) exactly as its own docstring predicts. Nothing needed
    building or changing to get this; it is reported as a confirmation, per
    WO-0054 §5's own instruction, not a discovery.

    {2 Assertion order (WO-0054 §4 item 1), stated once and followed by every
    row below}

    Structural first, specific after, the strobe set last where it is the
    row's own point (WO-0054 §4 item 3): output-word COUNT → the truncated
    frame's own `tlast` CYCLE → its `tkeep` → its `tuser` → the delivered
    CONTENT (the 1514-octet trap, first for M03-G1/G2/G3/G4/G6's truncated
    member) → the SAME five facts for the row's second (following/new)
    frame, where one exists → the EXACT strobe set, across the whole run,
    last. Iteration: lane 0 then lane 4 (outer, every row below), with no
    inner loop (each row has one stimulus per lane) except M03-G2, whose
    inner order is 1518 then 1519 ascending (the row's own "adjacent pair"
    wording).

    {2 M03-G1's own free note, answered (WO-0054 §8 deliverable 6)}

    `Protocol_monitor`'s standing `~max_words_per_frame:190` is a second,
    independent detector of the SAME headline kill (truncation at 1518
    delivered rather than 1514). In every row below, THIS FILE's own explicit
    word-count check speaks first: it is asserted directly in each row
    function, which raises via [fail] and stops that function before
    [assert_monitors_clean] (which is what reaches the protocol monitor) is
    ever called. Stated because it settles which message a mutation
    campaign would see first, not because the ordering was chosen for that
    reason — it falls out of "structural checks first" (WO-0054 §4 item 3)
    applied literally.

    {2 Independence}

    Every expected value is read from `docs/specs/modules/xgmii_rx_64.md`
    §6.1, §6.2 (the `Discard` row and its exits), §6.3 item 6, §7, §9 (the
    oversize row, the second/sixth/seventh co-occurrence rulings, the
    "Strobe cycle, pinned" no-terminate-character-closure ruling of
    2026-08-04), §10's REQ-108 hook and its REQ-901 row, and
    `docs/specs/requirements.md` REQ-108, REQ-103, REQ-104, REQ-105, REQ-110,
    REQ-008, REQ-011, REQ-015, §0.3, §0.6, §0.7 — cited inline. Plus
    `test/xgmii/injection.ml`/`.mli` and `test/xgmii/arrival.ml`/`.mli` (read
    for the §3.5 capability question and the M03-G3/G4 construction choices
    above; both under `test/`, never `libs/`), `test/xgmii_rx_64/bench.mli`,
    `test_m03_c.ml`, `test_m03_e.ml` and `test_m03_f.ml` (read as idiom
    reference, named where a pattern is reused). `libs/**`, `top/**`,
    `bin/**` and `rtl_snapshots/**` were not opened. *)

open! Base
open Bench

let fail row msg = failwith (String.concat [ row; ": "; msg ])

(* REQ-108's own constant, derived once so every row cites the same
   computation (see the module docstring's governance section). 1514 = 189
   full words (1512 octets) plus one final two-octet word, giving tkeep =
   (1 lsl 2) - 1 = 0x03 on that final word. *)
let truncated_delivered = 1514
let truncated_words = (truncated_delivered + 7) / 8
let truncated_tkeep = (1 lsl Int.rem truncated_delivered 8) - 1

(* The general REQ-103 tkeep formula, for M03-G2's 1518-octet (REQ-103
   governed) member — kept distinct from [truncated_tkeep] even though the
   two numbers coincide at 1518, so the governance distinction stays visible
   in the code and not just in prose. *)
let expected_tkeep_for ~delivered =
  if Int.rem delivered 8 = 0 then 0xFF else (1 lsl Int.rem delivered 8) - 1
;;

(* WO-0054 §5's X-5 confirmation, made mechanical: the SAME shape as
   test_m03_e.ml's [account_aborted_frame], with [~expected_octets] fixed at
   the literal REQ-108 constant rather than taken as a parameter, because
   every truncated frame in this family delivers exactly 1514 regardless of
   how long its own input trace is. [samples] is the frame's own, already
   tlast-delimited, delivered-sample slice (obligation 6: [delivered_samples]
   is applied again inside, which is idempotent on an already-filtered list —
   the same safety argument test_m03_f.ml's [account_clean_frame] calls rely
   on for a pre-split per-frame slice). *)
let account_truncated_frame bench (frame : Dv_xgmii.Arrival.frame) samples =
  Dv_monitors.Conservation_monitor.frame_in (conservation bench);
  Dv_monitors.Conservation_monitor.frame_out (conservation bench) ~aborted:true;
  Dv_monitors.Octet_time.Latency.frame_in (latency bench) (Dv_xgmii.Arrival.in_times frame);
  let delivered_pairs = List.map (delivered_samples samples) ~f:(fun s -> s.cycle, s.out) in
  Dv_monitors.Octet_time.Latency.frame_out
    (latency bench)
    ~expected_octets:truncated_delivered
    (Dv_monitors.Octet_time.of_words delivered_pairs)
;;

(* Duplicated from test_m03_e.ml's/test_m03_f.ml's own file-local helper of
   the same shape, per this packet's own convention: {!Bench} is the only
   shared surface, so every family file carries its own copy rather than
   reaching into a sibling file's private code. *)
let split_at_first_tlast samples =
  let rec go acc = function
    | [] -> List.rev acc, []
    | (s : sample) :: rest ->
      if s.out.Dv_monitors.Stream_word.tlast then List.rev (s :: acc), rest else go (s :: acc) rest
  in
  go [] samples
;;

(* ---- M03-G1 ---------------------------------------------------------- *)
(* "A 1600-octet frame followed immediately by a valid 64-octet frame |
   Exactly 1514 octets delivered; tuser[0]=1 on the tlast word; exactly one
   error_oversize; no error_bad_fcs; the following frame received intact."
   REQ-108, REQ-103.

   Kills: truncation at 1518 delivered (the received-count constant used as
   the delivered-count constant); a design that resynchronises only on `/T/`
   and loses the next frame.

   No Dv_xgmii.Injection and no corruption at all: two ordinary clean
   frame_case arrays via {!Bench.frames_at} (test_m03_f.ml's [run_f4] /
   test_m03_e.ml's [run_e4] two-frame precedent), at the default inter-frame
   gap -- "followed immediately" is §0.3's own minimum-gap convention, which
   [frames_at]'s ifg:12 default already is. REQ-108's truncation triggers
   purely off the first frame's own declared length (1600 > 1518); nothing
   about the second frame needs to be built specially. [fcs_valid:true] is
   used for both (unlike M03-D-family's bad-FCS rows): both octets1 and
   octets2 are genuinely [Frame.with_fcs]-correct at their own declared
   lengths, so Arrival's own residue check (run inside {!Bench.run}'s
   standing obligation 5) has nothing to complain about at either.

   Assertion order: two-frame SPLIT (structural) -> frame 1 (truncated):
   word count -> tlast cycle -> tkeep -> tuser -> delivered content (the
   1514-octet trap) -> frame 2 (following): word count -> tlast cycle ->
   tkeep -> tuser -> delivered content -> exact strobe set (across the whole
   run, this row's own §9-ruling-2 point -- no error_bad_fcs -- last).
   Iteration: lane 0 then lane 4, no inner loop. *)

let run_g1 ~lane =
  let row = String.concat [ "M03-G1 (lane "; Int.to_string lane; ")" ] in
  let octets1 = directed_frame_octets ~length:1600 in
  let octets2 = directed_frame_octets ~length:64 in
  if not (Dv_xgmii.Frame.residue_ok octets1)
  then fail row "test bug -- the 1600-octet frame's own FCS does not check out";
  if not (Dv_xgmii.Frame.residue_ok octets2)
  then fail row "test bug -- the following frame's own FCS does not check out";
  let sched = frames_at ~lane ~fcs_valid:true [ octets1; octets2 ] in
  let frames = Dv_xgmii.Arrival.frames sched in
  let frame1 = frames.(0) in
  let frame2 = frames.(1) in
  let start_ot1 = frame1.Dv_xgmii.Arrival.start_octet_time in
  let start_cycle1 = start_ot1 / 8 in
  (* SPEC-M03 §9's oversize row triggers on the 1519th received octet --
     array index 1518, zero-based -- whatever the array's own declared
     length (the module docstring's governance section). *)
  let closing_ot1 = start_ot1 + 8 + 1518 in
  let closing_cycle1 = closing_ot1 / 8 in
  let expected_tlast_cycle1 = start_cycle1 + 3 + (truncated_words - 1) in
  let expected_not_before1 = closing_cycle1 in
  let expected_not_after1 = closing_cycle1 + 3 in
  let bench = create () in
  Dv_monitors.Strobe_monitor.expect
    (strobes bench)
    { Dv_monitors.Strobe_monitor.strobe = "error_oversize"
    ; frame = 0
    ; cycle = expected_tlast_cycle1
    ; not_before = expected_not_before1
    ; not_after = expected_not_after1
    ; why =
        "REQ-108 (more than 1518 octets between start and terminate); SPEC-M03 \
         §9's 'Strobe cycle, pinned' puts it on the truncated frame's own tlast \
         cycle, start_cycle + 3 + 189 via §7's per-octet constant; §9's \
         2026-08-04 addition (J-architect_docs_lead-0021) fixes the §0.6 window \
         at the truncation cycle"
    };
  let samples = run bench sched ~drain:8 () in
  let words1, rest = split_at_first_tlast (delivered_samples samples) in
  let words2, _ = split_at_first_tlast rest in
  if List.is_empty words1 || List.is_empty words2
  then fail row "expected two delivered frames (one tlast word each), got fewer";
  (* frame 1 -- the truncated 1600-octet frame *)
  if List.length words1 <> truncated_words
  then
    fail
      row
      (String.concat
         [ "frame 1: expected "
         ; Int.to_string truncated_words
         ; " output words, got "
         ; Int.to_string (List.length words1)
         ]);
  let tlast1 = List.last_exn words1 in
  if tlast1.cycle <> expected_tlast_cycle1
  then fail row "frame 1: tlast word did not arrive on the truncation's own pinned cycle";
  if tlast1.out.Dv_monitors.Stream_word.tkeep <> truncated_tkeep
  then fail row "frame 1: tkeep does not match the 1514-octet truncation constant (0x03)";
  if tlast1.out.Dv_monitors.Stream_word.tuser <> 1
  then fail row "frame 1: tuser[0] is not set on a truncated frame (REQ-007, REQ-108)";
  let got1 = List.concat_map words1 ~f:(fun (s : sample) -> Dv_monitors.Stream_word.octets s.out) in
  let expected1 = List.take octets1 truncated_delivered in
  if not (List.equal Int.equal got1 expected1)
  then
    fail
      row
      "frame 1: delivered octets are not the frame's own first 1514 octets -- REQ-108's \
       truncation delivers the RECEIVED prefix, never Frame.delivered's FCS-removal \
       identity (this row's own trap, WO-0054 §2)";
  (* frame 2 -- the following, ordinary frame: the anti-vacuity partner *)
  let delivered2 = 64 - 4 in
  let words2_expected = (delivered2 + 7) / 8 in
  let expected_tkeep2 = expected_tkeep_for ~delivered:delivered2 in
  if List.length words2 <> words2_expected
  then
    fail
      row
      (String.concat
         [ "frame 2: expected "
         ; Int.to_string words2_expected
         ; " output words, got "
         ; Int.to_string (List.length words2)
         ]);
  let tlast2 = List.last_exn words2 in
  if tlast2.out.Dv_monitors.Stream_word.tkeep <> expected_tkeep2
  then fail row "frame 2: tkeep does not match its own 60 delivered octets (0x0F, a 4-octet final word)";
  if tlast2.out.Dv_monitors.Stream_word.tuser <> 0
  then fail row "frame 2: tuser[0] set -- this is a LEGAL, intact frame";
  let got2 = List.concat_map words2 ~f:(fun (s : sample) -> Dv_monitors.Stream_word.octets s.out) in
  if not (List.equal Int.equal got2 (Dv_xgmii.Frame.delivered octets2))
  then fail row "frame 2: delivered octets differ from its own 60 -- REQ-103's ordinary removal";
  (match error_pulses samples with
   | [ (cycle, name) ] ->
     if not (String.equal name "error_oversize")
     then fail row (String.concat [ "expected error_oversize alone, observed "; name ])
     else if cycle <> expected_tlast_cycle1
     then fail row "error_oversize pulsed on the wrong cycle"
   | pulses ->
     fail
       row
       (String.concat
          [ "expected exactly one strobe (error_oversize alone -- proving no \
             error_bad_fcs, §9 ruling 2, and the following frame intact), observed "
          ; Int.to_string (List.length pulses)
          ]));
  account_truncated_frame bench frame1 words1;
  account_clean_frame bench frame2 words2 ~aborted:false;
  Dv_monitors.Conservation_monitor.strobe_pulse (conservation bench) ~name:"error_oversize";
  assert_monitors_clean bench ~row
;;

let%expect_test
  "M03-G1: a 1600-octet frame followed immediately by a valid 64-octet frame \
   -- 1514 octets delivered, exactly one error_oversize, no error_bad_fcs, \
   following frame intact (REQ-108, REQ-103)"
  =
  run_g1 ~lane:0;
  run_g1 ~lane:4;
  [%expect {||}]
;;

(* ---- M03-G2 ---------------------------------------------------------- *)
(* "The adjacent pair 1518 and 1519 octets, each with a correct FCS over its
   own length | Both deliver exactly 1514 octets. 1518: no strobe, tuser[0]=0,
   FCS verdict good. 1519: one error_oversize, tuser[0]=1, no error_bad_fcs."
   REQ-108, REQ-103, §0.3. The strongest row in the family (WO-0054 §3.2):
   only the strobe, the abort bit and the FCS verdict separate a legal
   maximum frame from an oversize one, since both deliver the SAME 1514
   octets.

   Governance, per member (module docstring): 1518 is REQ-103's removal
   (Frame.delivered, which happens to equal 1514 -- the coincidence this row
   is built to expose); 1519 is REQ-108's truncation, the literal 1514
   constant, NEVER Frame.delivered (which would give 1515).

   Cross-check taken, not imported (WO-0054 §3.2): the 1518 member's own
   190-words/tkeep=0x03 figures are derived independently below from §6.1/§7
   and compared, in the Return log, against test_m03_c.ml's [run_c3] (which
   drives the identical 1518-octet frame and asserts 190 words, final tkeep
   0x03) -- this file calls nothing in test_m03_c.ml.

   Assertion order: word count -> tlast cycle -> tkeep -> tuser -> delivered
   content -> exact strobe set (this row's own boundary point, last).
   Iteration: lane 0 then lane 4 (outer), 1518 then 1519 ascending (inner,
   the row's own "adjacent pair" order). *)

let run_g2_legal ~lane =
  let row = String.concat [ "M03-G2 (lane "; Int.to_string lane; ", 1518 legal maximum)" ] in
  let octets = directed_frame_octets ~length:1518 in
  if not (Dv_xgmii.Frame.residue_ok octets)
  then fail row "test bug -- the 1518-octet frame's own FCS does not check out";
  let sched = one_frame ~lane octets in
  let frame = (Dv_xgmii.Arrival.frames sched).(0) in
  let start_cycle = Dv_xgmii.Arrival.start_cycle frame in
  let delivered = 1518 - 4 in
  let words = (delivered + 7) / 8 in
  let expected_tlast_cycle = start_cycle + 3 + (words - 1) in
  let expected_tkeep = expected_tkeep_for ~delivered in
  let bench = create () in
  let samples = run bench sched ~drain:8 () in
  let out_words = delivered_samples samples in
  if List.length out_words <> words
  then
    fail
      row
      (String.concat
         [ "expected "; Int.to_string words; " output words, got "
         ; Int.to_string (List.length out_words)
         ]);
  (match tlast_sample samples with
   | None -> fail row "no tlast word observed"
   | Some s ->
     if s.cycle <> expected_tlast_cycle
     then fail row "tlast word did not arrive on start_cycle + 3 + 189 (REQ-019)";
     if s.out.Dv_monitors.Stream_word.tkeep <> expected_tkeep
     then fail row "tlast tkeep does not match 1514 delivered octets (expected 0x03)";
     if s.out.Dv_monitors.Stream_word.tuser <> 0
     then fail row "tuser[0] set on a legal, maximum-length frame");
  let expected_octets = Dv_xgmii.Frame.delivered octets in
  let got_octets = delivered_octets samples in
  if not (List.equal Int.equal got_octets expected_octets)
  then
    fail
      row
      "delivered octets differ from the injected frame minus its FCS (REQ-103: this \
       member closes normally, on its own genuine /T/, at exactly the legal maximum)";
  if not (List.is_empty (error_pulses samples))
  then fail row "a strobe pulsed on a legal, maximum-length frame -- G2's own boundary point";
  account_clean_frame bench frame samples ~aborted:false;
  assert_monitors_clean bench ~row
;;

let run_g2_oversize ~lane =
  let row = String.concat [ "M03-G2 (lane "; Int.to_string lane; ", 1519 oversize)" ] in
  let octets = directed_frame_octets ~length:1519 in
  if not (Dv_xgmii.Frame.residue_ok octets)
  then fail row "test bug -- the 1519-octet frame's own FCS (over its own length) does not check out";
  let sched = one_frame ~lane octets in
  let frame = (Dv_xgmii.Arrival.frames sched).(0) in
  let start_ot = frame.Dv_xgmii.Arrival.start_octet_time in
  let start_cycle = start_ot / 8 in
  let closing_ot = start_ot + 8 + 1518 in
  let closing_cycle = closing_ot / 8 in
  let expected_tlast_cycle = start_cycle + 3 + (truncated_words - 1) in
  let expected_not_before = closing_cycle in
  let expected_not_after = closing_cycle + 3 in
  let bench = create () in
  Dv_monitors.Strobe_monitor.expect
    (strobes bench)
    { Dv_monitors.Strobe_monitor.strobe = "error_oversize"
    ; frame = 0
    ; cycle = expected_tlast_cycle
    ; not_before = expected_not_before
    ; not_after = expected_not_after
    ; why =
        "REQ-108 (1519 octets, one past the 1518-octet legal maximum); SPEC-M03 \
         §9's 2026-08-04 reference-word ruling (J-architect_docs_lead-0021) fixes \
         the window at the truncation cycle"
    };
  let samples = run bench sched ~drain:8 () in
  let out_words = delivered_samples samples in
  if List.length out_words <> truncated_words
  then fail row "expected 190 output words (the 1514-octet truncation), got a different count";
  (match tlast_sample samples with
   | None -> fail row "no tlast word observed"
   | Some s ->
     if s.cycle <> expected_tlast_cycle
     then fail row "tlast word did not arrive on the truncation's own pinned cycle";
     if s.out.Dv_monitors.Stream_word.tkeep <> truncated_tkeep
     then fail row "tlast tkeep does not match the 1514-octet truncation constant";
     if s.out.Dv_monitors.Stream_word.tuser <> 1
     then fail row "tuser[0] is not set on a truncated (oversize) frame");
  let got_octets = delivered_octets samples in
  let expected_octets = List.take octets truncated_delivered in
  if not (List.equal Int.equal got_octets expected_octets)
  then
    fail
      row
      "delivered octets are not the frame's own first 1514 octets -- REQ-108's \
       truncation, NEVER Frame.delivered's FCS-removal identity (which would give \
       1515 here -- this row's own headline trap, WO-0054 §2)";
  (match error_pulses samples with
   | [ (cycle, name) ] ->
     if not (String.equal name "error_oversize")
     then fail row (String.concat [ "expected error_oversize alone, observed "; name ])
     else if cycle <> expected_tlast_cycle
     then fail row "error_oversize pulsed on the wrong cycle"
   | pulses ->
     fail
       row
       (String.concat
          [ "expected exactly one strobe (error_oversize alone -- no error_bad_fcs, §9 \
             ruling 2), observed "
          ; Int.to_string (List.length pulses)
          ]));
  account_truncated_frame bench frame out_words;
  Dv_monitors.Conservation_monitor.strobe_pulse (conservation bench) ~name:"error_oversize";
  assert_monitors_clean bench ~row
;;

let%expect_test
  "M03-G2: the adjacent pair 1518 and 1519 octets, both lanes -- 1518 is \
   legal (no strobe), 1519 is oversize (exactly one error_oversize, no \
   error_bad_fcs); both deliver exactly 1514 octets (REQ-108, REQ-103, §0.3)"
  =
  List.iter [ 0; 4 ] ~f:(fun lane ->
    run_g2_legal ~lane;
    run_g2_oversize ~lane);
  [%expect {||}]
;;

(* ---- M03-G3 ---------------------------------------------------------- *)
(* "A 1600-octet frame in which a new /S/ arrives 100 octets past the
   truncation point | Exactly one error_oversize and no
   error_start_without_terminate; the new frame is received normally."
   REQ-108, REQ-110, §9's sixth ruling, C-12.

   Kills: a design that treats the resynchronising start character as a
   second abort -- it would double-count the frame against §0.6.

   Construction (module docstring's "considered and rejected" section): two
   ordinary Arrival frame_cases, laid out via Dv_xgmii.Arrival.create called
   DIRECTLY (not Bench.frames_at, which fixes ifg at Arrival.create's own
   12-octet default) with an EXPLICIT ifg chosen so the second frame's own
   genuinely self-contained, correctly-FCS'd /S/ lands at the nearest
   REQ-101-legal (lane 0 or lane 4) octet time to "100 octets past the
   truncation point" -- content-index 1620 (mod 8 = 4), 102 octets past
   truncation (index 1618, the literal 100, is index-mod-8 = 2, a lane
   REQ-101 forbids a start character from ever occupying, at EITHER start
   lane -- the preamble's own 8 octets are themselves a multiple of 8, so the
   parity condition on the content index is the same regardless of start
   lane). No Dv_xgmii.Injection and no Place corruption at all: REQ-018's
   link partner never injects a bare control character detached from a
   frame, and the row's own "/S/ arrives" describes a genuinely separate
   frame's own start character, not a corruption of the first frame's body. *)

let run_g3 ~lane =
  let row = String.concat [ "M03-G3 (lane "; Int.to_string lane; ")" ] in
  let octets1 = directed_frame_octets ~length:1600 in
  let octets2 = directed_frame_octets ~length:64 in
  if not (Dv_xgmii.Frame.residue_ok octets1)
  then fail row "test bug -- the 1600-octet frame's own FCS does not check out";
  if not (Dv_xgmii.Frame.residue_ok octets2)
  then fail row "test bug -- the following frame's own FCS does not check out";
  let first_start = if lane = 0 then 8 else 12 in
  (* Solve for the ifg that lands the second frame at content-index 1620:
     terminate1 = first_start + 8 + 1600; target_start2 = first_start + 8 +
     1620; ifg = target_start2 - terminate1 = 20, which is already a
     multiple of 4 past terminate1 (1628 = first_start + 1628's own
     remainder mod 4 is 0, since 1628 is a multiple of 4), so
     Arrival.create's own round_up_4 is a no-op here -- checked below by
     comparing the schedule's own numbers, not assumed. *)
  let terminate1 = first_start + 8 + 1600 in
  let target_start2 = first_start + 8 + 1620 in
  let ifg = target_start2 - terminate1 in
  if ifg < 9
  then fail row "test bug -- the computed ifg is below requirements.md §0.3's 9-octet DIC floor";
  let sched = Dv_xgmii.Arrival.create ~ifg ~first_start ~fcs_valid:true [ octets1; octets2 ] in
  if not (Dv_xgmii.Arrival.is_clean sched)
  then
    fail
      row
      (String.concat ~sep:"; " ("Arrival construction errors:" :: Dv_xgmii.Arrival.check sched));
  let frames = Dv_xgmii.Arrival.frames sched in
  let frame1 = frames.(0) in
  let frame2 = frames.(1) in
  let start_ot1 = frame1.Dv_xgmii.Arrival.start_octet_time in
  let start_cycle1 = start_ot1 / 8 in
  let start_ot2 = frame2.Dv_xgmii.Arrival.start_octet_time in
  (* Verify the stimulus actually lands where this row means it to, BEFORE
     trusting anything below (WO-0047 §6 item 7's two-site discipline,
     applied to a scheduling computation rather than a Place placement). *)
  if start_ot2 <> start_ot1 + 8 + 1620
  then fail row "test bug -- the second frame's start octet time is not 1620 content-octets past the first frame's start";
  let content_offset_past_truncation = start_ot2 - start_ot1 - 8 - 1518 in
  if content_offset_past_truncation <> 102
  then fail row "test bug -- the second frame does not land 102 octets past the truncation point";
  if Int.rem start_ot2 8 <> 0 && Int.rem start_ot2 8 <> 4
  then fail row "test bug -- the second frame's start octet time is not in lane 0 or lane 4";
  let closing_ot1 = start_ot1 + 8 + 1518 in
  let closing_cycle1 = closing_ot1 / 8 in
  let expected_tlast_cycle1 = start_cycle1 + 3 + (truncated_words - 1) in
  let expected_not_before1 = closing_cycle1 in
  let expected_not_after1 = closing_cycle1 + 3 in
  let bench = create () in
  Dv_monitors.Strobe_monitor.expect
    (strobes bench)
    { Dv_monitors.Strobe_monitor.strobe = "error_oversize"
    ; frame = 0
    ; cycle = expected_tlast_cycle1
    ; not_before = expected_not_before1
    ; not_after = expected_not_after1
    ; why =
        "REQ-108; SPEC-M03 §9's 2026-08-04 reference-word ruling \
         (J-architect_docs_lead-0021) fixes the window at the truncation cycle, \
         independent of the resynchronising /S/ that follows"
    };
  let samples = run bench sched ~drain:8 () in
  let words1, rest = split_at_first_tlast (delivered_samples samples) in
  let words2, _ = split_at_first_tlast rest in
  if List.is_empty words1 || List.is_empty words2
  then fail row "expected two delivered frames (one tlast word each), got fewer";
  if List.length words1 <> truncated_words
  then fail row "frame 1: expected 190 output words (the 1514-octet truncation)";
  let tlast1 = List.last_exn words1 in
  if tlast1.cycle <> expected_tlast_cycle1
  then fail row "frame 1: tlast word did not arrive on the truncation's own pinned cycle";
  if tlast1.out.Dv_monitors.Stream_word.tkeep <> truncated_tkeep
  then fail row "frame 1: tkeep does not match the 1514-octet truncation constant";
  if tlast1.out.Dv_monitors.Stream_word.tuser <> 1
  then fail row "frame 1: tuser[0] is not set on a truncated frame";
  let got1 = List.concat_map words1 ~f:(fun (s : sample) -> Dv_monitors.Stream_word.octets s.out) in
  if not (List.equal Int.equal got1 (List.take octets1 truncated_delivered))
  then fail row "frame 1: delivered octets are not the frame's own first 1514 octets";
  (* frame 2 -- the resynchronised, ordinary new frame: this row's whole
     point, asserted structurally rather than assumed. *)
  let delivered2 = 64 - 4 in
  let words2_expected = (delivered2 + 7) / 8 in
  let expected_tkeep2 = expected_tkeep_for ~delivered:delivered2 in
  if List.length words2 <> words2_expected
  then fail row "frame 2: expected 8 output words, got a different count";
  let tlast2 = List.last_exn words2 in
  if tlast2.out.Dv_monitors.Stream_word.tkeep <> expected_tkeep2
  then fail row "frame 2: tkeep does not match its own 60 delivered octets (0x0F, a 4-octet final word)";
  if tlast2.out.Dv_monitors.Stream_word.tuser <> 0
  then fail row "frame 2: tuser[0] set -- the resynchronised frame is legal, not aborted";
  let got2 = List.concat_map words2 ~f:(fun (s : sample) -> Dv_monitors.Stream_word.octets s.out) in
  if not (List.equal Int.equal got2 (Dv_xgmii.Frame.delivered octets2))
  then fail row "frame 2: delivered octets differ from its own 60 -- must arrive intact";
  (match error_pulses samples with
   | [ (cycle, name) ] ->
     if not (String.equal name "error_oversize")
     then fail row (String.concat [ "expected error_oversize alone, observed "; name ])
     else if cycle <> expected_tlast_cycle1
     then fail row "error_oversize pulsed on the wrong cycle"
   | pulses ->
     fail
       row
       (String.concat
          [ "expected exactly one strobe (error_oversize alone -- NO \
             error_start_without_terminate, §9's sixth ruling, C-12, this row's \
             own point), observed "
          ; Int.to_string (List.length pulses)
          ]));
  account_truncated_frame bench frame1 words1;
  account_clean_frame bench frame2 words2 ~aborted:false;
  Dv_monitors.Conservation_monitor.strobe_pulse (conservation bench) ~name:"error_oversize";
  assert_monitors_clean bench ~row
;;

let%expect_test
  "M03-G3: a 1600-octet frame, then a new /S/ (a genuinely separate, \
   ordinary frame) 102 octets past the truncation point -- exactly one \
   error_oversize, no error_start_without_terminate, the new frame received \
   normally (REQ-108, REQ-110, §9's sixth ruling, C-12)"
  =
  run_g3 ~lane:0;
  run_g3 ~lane:4;
  [%expect {||}]
;;

(* ---- M03-G4 ---------------------------------------------------------- *)
(* "The same 1600-octet frame with an /E/ injected 100 octets past the
   truncation point | Exactly one error_oversize, no error_bad_frame,
   nothing emitted after the truncation, following frame intact." REQ-108,
   REQ-105, §9's seventh ruling, C-12.

   Kills: the reading §9 row 2's condition text invited before C-12 landed --
   an /E/ handler that reads "between the start and terminate characters"
   literally and pulses for a frame already closed and already reported.

   Construction (module docstring's "considered and rejected" section): an
   ordinary two-frame Arrival schedule (the 1600-octet oversize frame, then a
   clean 64-octet frame) at a generously widened ifg, plus a single
   {!Bench.run} [?word_at] override placing the /E/ at the LITERAL octet time
   100 past the truncation point (no lane restriction applies to /E/, unlike
   M03-G3's /S/) -- test_m03_e.ml's [run_e4] precedent, generalised from "a
   stray character right after a terminate" to "a stray character 100 octets
   into a widened gap". No Dv_xgmii.Injection: the array stays literally
   1600 octets (matching the row's own words), since this route needs no
   Place target inside a frame's own declared span at all. *)

let run_g4 ~lane =
  let row = String.concat [ "M03-G4 (lane "; Int.to_string lane; ")" ] in
  let octets1 = directed_frame_octets ~length:1600 in
  let octets2 = directed_frame_octets ~length:64 in
  if not (Dv_xgmii.Frame.residue_ok octets1)
  then fail row "test bug -- frame 1's own FCS does not check out";
  if not (Dv_xgmii.Frame.residue_ok octets2)
  then fail row "test bug -- frame 2's own FCS does not check out";
  let first_start = if lane = 0 then 8 else 12 in
  (* A generous ifg (40 octets, comfortably above requirements.md §0.3's
     9-octet DIC floor and the 12-octet default) so the injected /E/, 100
     octets past the truncation point, lands strictly inside the gap and
     never touches frame 2's own preamble -- verified below, not assumed. *)
  let ifg = 40 in
  let sched = Dv_xgmii.Arrival.create ~ifg ~first_start ~fcs_valid:true [ octets1; octets2 ] in
  if not (Dv_xgmii.Arrival.is_clean sched)
  then
    fail
      row
      (String.concat ~sep:"; " ("Arrival construction errors:" :: Dv_xgmii.Arrival.check sched));
  let frames = Dv_xgmii.Arrival.frames sched in
  let frame1 = frames.(0) in
  let frame2 = frames.(1) in
  let start_ot1 = frame1.Dv_xgmii.Arrival.start_octet_time in
  let start_cycle1 = start_ot1 / 8 in
  let terminate1 = Dv_xgmii.Arrival.terminate_octet_time frame1 in
  let start_ot2 = frame2.Dv_xgmii.Arrival.start_octet_time in
  let inject_ot = start_ot1 + 8 + 1518 + 100 in
  if not (inject_ot > terminate1 && inject_ot < start_ot2)
  then fail row "test bug -- the chosen /E/ octet time is not strictly inside the inter-frame gap";
  let inject_cycle = inject_ot / 8 in
  let inject_lane = Int.rem inject_ot 8 in
  let word_at ~cycle =
    let base_word = Dv_xgmii.Arrival.word_at sched ~cycle in
    if cycle <> inject_cycle
    then base_word
    else
      { Dv_xgmii.Xgmii_word.data =
          Array.mapi base_word.Dv_xgmii.Xgmii_word.data ~f:(fun lane_idx v ->
            if lane_idx = inject_lane then Dv_xgmii.Xgmii_word.error_char else v)
      ; control = base_word.Dv_xgmii.Xgmii_word.control
      }
  in
  (* WO-0043 §2's two-site discipline: verify the /E/ lands where this row
     means it to, in the schedule's own words, BEFORE trusting anything
     below. *)
  let pre_run_word = word_at ~cycle:inject_cycle in
  if (not (Dv_xgmii.Xgmii_word.is_control pre_run_word inject_lane))
     || not
          (Int.equal
             (pre_run_word.Dv_xgmii.Xgmii_word.data).(inject_lane)
             Dv_xgmii.Xgmii_word.error_char)
  then fail row "test bug -- the /E/ does not land at the intended octet time before driving";
  let closing_ot1 = start_ot1 + 8 + 1518 in
  let closing_cycle1 = closing_ot1 / 8 in
  let expected_tlast_cycle1 = start_cycle1 + 3 + (truncated_words - 1) in
  let expected_not_before1 = closing_cycle1 in
  let expected_not_after1 = closing_cycle1 + 3 in
  let bench = create () in
  Dv_monitors.Strobe_monitor.expect
    (strobes bench)
    { Dv_monitors.Strobe_monitor.strobe = "error_oversize"
    ; frame = 0
    ; cycle = expected_tlast_cycle1
    ; not_before = expected_not_before1
    ; not_after = expected_not_after1
    ; why =
        "REQ-108; SPEC-M03 §9's 2026-08-04 reference-word ruling \
         (J-architect_docs_lead-0021) fixes the window at the truncation cycle, \
         independent of the /E/ absorbed after it"
    };
  let samples = run bench sched ~drain:8 ~word_at () in
  (* Site 2 (WO-0047 §6 item 7): the cycle {!run} ACTUALLY drove carries the
     /E/ this row means to test. *)
  (match List.find samples ~f:(fun s -> s.cycle = inject_cycle) with
   | None -> fail row "test bug -- the intended /E/ cycle was never driven"
   | Some s ->
     if (not (Dv_xgmii.Xgmii_word.is_control s.in_word inject_lane))
        || not
             (Int.equal
                (s.in_word.Dv_xgmii.Xgmii_word.data).(inject_lane)
                Dv_xgmii.Xgmii_word.error_char)
     then
       fail
         row
         "the driven word at the intended cycle does not carry the /E/ this row means \
          to test -- the negative assertion below would be vacuous");
  let words1, rest = split_at_first_tlast (delivered_samples samples) in
  let words2, _ = split_at_first_tlast rest in
  if List.is_empty words1 || List.is_empty words2
  then fail row "expected two delivered frames (one tlast word each), got fewer";
  if List.length words1 <> truncated_words
  then fail row "frame 1: expected 190 output words (the 1514-octet truncation)";
  let tlast1 = List.last_exn words1 in
  if tlast1.cycle <> expected_tlast_cycle1
  then fail row "frame 1: tlast word did not arrive on the truncation's own pinned cycle";
  if tlast1.out.Dv_monitors.Stream_word.tkeep <> truncated_tkeep
  then fail row "frame 1: tkeep does not match the 1514-octet truncation constant";
  if tlast1.out.Dv_monitors.Stream_word.tuser <> 1
  then fail row "frame 1: tuser[0] is not set on a truncated frame";
  let got1 = List.concat_map words1 ~f:(fun (s : sample) -> Dv_monitors.Stream_word.octets s.out) in
  if not (List.equal Int.equal got1 (List.take octets1 truncated_delivered))
  then fail row "frame 1: delivered octets are not the frame's own first 1514 octets";
  let delivered2 = 64 - 4 in
  let words2_expected = (delivered2 + 7) / 8 in
  let expected_tkeep2 = expected_tkeep_for ~delivered:delivered2 in
  if List.length words2 <> words2_expected
  then fail row "frame 2: expected 8 output words, got a different count";
  let tlast2 = List.last_exn words2 in
  if tlast2.out.Dv_monitors.Stream_word.tkeep <> expected_tkeep2
  then fail row "frame 2: tkeep does not match its own 60 delivered octets (0x0F, a 4-octet final word)";
  if tlast2.out.Dv_monitors.Stream_word.tuser <> 0
  then fail row "frame 2: tuser[0] set -- the following frame is legal, untouched by the /E/";
  let got2 = List.concat_map words2 ~f:(fun (s : sample) -> Dv_monitors.Stream_word.octets s.out) in
  if not (List.equal Int.equal got2 (Dv_xgmii.Frame.delivered octets2))
  then fail row "frame 2: delivered octets differ from its own 60 -- must arrive intact";
  (match error_pulses samples with
   | [ (cycle, name) ] ->
     if not (String.equal name "error_oversize")
     then fail row (String.concat [ "expected error_oversize alone, observed "; name ])
     else if cycle <> expected_tlast_cycle1
     then fail row "error_oversize pulsed on the wrong cycle"
   | pulses ->
     fail
       row
       (String.concat
          [ "expected exactly one strobe (error_oversize alone -- NO error_bad_frame, \
             §9's seventh ruling, C-12, this row's own point), observed "
          ; Int.to_string (List.length pulses)
          ]));
  account_truncated_frame bench frame1 words1;
  account_clean_frame bench frame2 words2 ~aborted:false;
  Dv_monitors.Conservation_monitor.strobe_pulse (conservation bench) ~name:"error_oversize";
  assert_monitors_clean bench ~row
;;

let%expect_test
  "M03-G4: the same 1600-octet frame, with an /E/ absorbed 100 octets past \
   the truncation point -- exactly one error_oversize, no error_bad_frame, \
   nothing else emitted, following frame intact (REQ-108, REQ-105, §9's \
   seventh ruling, C-12)"
  =
  run_g4 ~lane:0;
  run_g4 ~lane:4;
  [%expect {||}]
;;

(* ---- M03-G5 (NO-ASSERT) ------------------------------------------------ *)
(* "§6.3 item 6, C-12 | (same as M03-G4) | The internal state after
   absorbing the /E/ in Discard is not asserted; both encodings produce the
   pinned observable identically | -- | NO-ASSERT."

   Declared and asserted nothing, in the shape M03-D4 (test_m03_d.ml) and
   M03-A4 (test_m03_a.ml) already use: no code in this file tests WHICH
   internal encoding M03's design holds after absorbing the /E/ in Discard --
   staying in Discard, or falling to Idle, as SPEC-M03 §6.2's own Discard row
   says explicitly ("whether the implementation stays in Discard or falls to
   Idle on it is unobservable and is §6.3 item 6"). Every assertion M03-G4
   makes reaches only the pinned OBSERVABLE (exactly one error_oversize, no
   error_bad_frame, the following frame intact) -- which is exactly what §6.3
   item 6 permits a bench to observe, and is identical whichever encoding the
   design holds. There is no test function for this row and none is owed:
   like M03-D4 (whose AP Stimulus cell is also "--") this row has no
   stimulus of its own -- it reuses M03-G4's -- and nothing further is
   asserted in its place. *)

(* ---- M03-G6 ---------------------------------------------------------- *)
(* "A 1600-octet frame with no further character until the next /S/ (no
   /T/ at all) | No output word and no strobe of any kind between the
   truncation point and the next start character, whatever arrives."
   REQ-108.

   Kills: a design that emits the tail of the discarded frame, or that
   pulses a second strobe on the eventual /T/.

   Construction: Dv_xgmii.Injection CAN express this (module docstring's
   §3.5 section, established from test/xgmii/injection.ml's own committed
   source), via Place{placement=At_terminate; character=Xgmii_word.idle_char}
   -- but this row does not build through Injection. It overrides the SAME
   single octet time, Dv_xgmii.Arrival.terminate_octet_time frame1 -- a value
   Arrival already computes with no Injection object at all -- via
   {!Bench.run}'s own [?word_at] hook, replacing what would be frame 1's own
   natural /T/ with an idle character so no terminate character ever appears
   on the wire for it. Unlike M03-G1 (whose 1600-octet frame's own natural
   /T/ genuinely appears, silently and harmlessly, per §6.2's Discard row),
   this row removes even that -- the sharper, "no /T/ at all" case the row's
   own text asks for. *)

let run_g6 ~lane =
  let row = String.concat [ "M03-G6 (lane "; Int.to_string lane; ")" ] in
  let octets1 = directed_frame_octets ~length:1600 in
  let octets2 = directed_frame_octets ~length:64 in
  if not (Dv_xgmii.Frame.residue_ok octets1)
  then fail row "test bug -- frame 1's own FCS does not check out";
  if not (Dv_xgmii.Frame.residue_ok octets2)
  then fail row "test bug -- frame 2's own FCS does not check out";
  let first_start = if lane = 0 then 8 else 12 in
  let sched = Dv_xgmii.Arrival.create ~first_start ~fcs_valid:true [ octets1; octets2 ] in
  if not (Dv_xgmii.Arrival.is_clean sched)
  then
    fail
      row
      (String.concat ~sep:"; " ("Arrival construction errors:" :: Dv_xgmii.Arrival.check sched));
  let frames = Dv_xgmii.Arrival.frames sched in
  let frame1 = frames.(0) in
  let frame2 = frames.(1) in
  let start_ot1 = frame1.Dv_xgmii.Arrival.start_octet_time in
  let start_cycle1 = start_ot1 / 8 in
  let terminate1 = Dv_xgmii.Arrival.terminate_octet_time frame1 in
  let suppress_cycle = terminate1 / 8 in
  let suppress_lane = Int.rem terminate1 8 in
  let word_at ~cycle =
    let base_word = Dv_xgmii.Arrival.word_at sched ~cycle in
    if cycle <> suppress_cycle
    then base_word
    else
      { Dv_xgmii.Xgmii_word.data =
          Array.mapi base_word.Dv_xgmii.Xgmii_word.data ~f:(fun lane_idx v ->
            if lane_idx = suppress_lane then Dv_xgmii.Xgmii_word.idle_char else v)
      ; control = base_word.Dv_xgmii.Xgmii_word.control
      }
  in
  let pre_run_word = word_at ~cycle:suppress_cycle in
  if (not (Dv_xgmii.Xgmii_word.is_control pre_run_word suppress_lane))
     || not
          (Int.equal
             (pre_run_word.Dv_xgmii.Xgmii_word.data).(suppress_lane)
             Dv_xgmii.Xgmii_word.idle_char)
  then
    fail
      row
      "test bug -- the substitute idle character does not land at frame 1's own \
       terminate octet time";
  let closing_ot1 = start_ot1 + 8 + 1518 in
  let closing_cycle1 = closing_ot1 / 8 in
  let expected_tlast_cycle1 = start_cycle1 + 3 + (truncated_words - 1) in
  let expected_not_before1 = closing_cycle1 in
  let expected_not_after1 = closing_cycle1 + 3 in
  let bench = create () in
  Dv_monitors.Strobe_monitor.expect
    (strobes bench)
    { Dv_monitors.Strobe_monitor.strobe = "error_oversize"
    ; frame = 0
    ; cycle = expected_tlast_cycle1
    ; not_before = expected_not_before1
    ; not_after = expected_not_after1
    ; why =
        "REQ-108; SPEC-M03 §9's 2026-08-04 reference-word ruling fixes the window \
         at the truncation cycle, independent of there being no /T/ at all"
    };
  let samples = run bench sched ~drain:8 ~word_at () in
  (match List.find samples ~f:(fun s -> s.cycle = suppress_cycle) with
   | None -> fail row "test bug -- the intended terminate cycle was never driven"
   | Some s ->
     if (not (Dv_xgmii.Xgmii_word.is_control s.in_word suppress_lane))
        || not
             (Int.equal
                (s.in_word.Dv_xgmii.Xgmii_word.data).(suppress_lane)
                Dv_xgmii.Xgmii_word.idle_char)
     then
       fail
         row
         "the driven word at the intended cycle does not carry the substitute idle \
          character -- the no-terminate-at-all claim below would be vacuous");
  let words1, rest = split_at_first_tlast (delivered_samples samples) in
  let words2, _ = split_at_first_tlast rest in
  if List.is_empty words1 || List.is_empty words2
  then fail row "expected two delivered frames (one tlast word each), got fewer";
  if List.length words1 <> truncated_words
  then fail row "frame 1: expected 190 output words (the 1514-octet truncation)";
  let tlast1 = List.last_exn words1 in
  if tlast1.cycle <> expected_tlast_cycle1
  then fail row "frame 1: tlast word did not arrive on the truncation's own pinned cycle";
  if tlast1.out.Dv_monitors.Stream_word.tkeep <> truncated_tkeep
  then fail row "frame 1: tkeep does not match the 1514-octet truncation constant";
  if tlast1.out.Dv_monitors.Stream_word.tuser <> 1
  then fail row "frame 1: tuser[0] is not set on a truncated frame";
  let got1 = List.concat_map words1 ~f:(fun (s : sample) -> Dv_monitors.Stream_word.octets s.out) in
  if not (List.equal Int.equal got1 (List.take octets1 truncated_delivered))
  then fail row "frame 1: delivered octets are not the frame's own first 1514 octets";
  let delivered2 = 64 - 4 in
  let words2_expected = (delivered2 + 7) / 8 in
  let expected_tkeep2 = expected_tkeep_for ~delivered:delivered2 in
  if List.length words2 <> words2_expected
  then fail row "frame 2: expected 8 output words, got a different count";
  let tlast2 = List.last_exn words2 in
  if tlast2.out.Dv_monitors.Stream_word.tkeep <> expected_tkeep2
  then fail row "frame 2: tkeep does not match its own 60 delivered octets (0x0F, a 4-octet final word)";
  if tlast2.out.Dv_monitors.Stream_word.tuser <> 0
  then fail row "frame 2: tuser[0] set -- the following frame is legal";
  let got2 = List.concat_map words2 ~f:(fun (s : sample) -> Dv_monitors.Stream_word.octets s.out) in
  if not (List.equal Int.equal got2 (Dv_xgmii.Frame.delivered octets2))
  then fail row "frame 2: delivered octets differ from its own 60 -- must arrive intact";
  (* This row's own point, asserted LAST: no output word and no strobe of
     any kind between the truncation point and frame 2's own /S/. The
     delivered-sample count check restates it structurally (the only
     delivered words anywhere in the run are exactly words1 and words2, so
     nothing was emitted in the gap where a /T/ would otherwise have sat). *)
  if List.length (delivered_samples samples) <> List.length words1 + List.length words2
  then fail row "an output word was observed outside the two accounted-for frames";
  (match error_pulses samples with
   | [ (cycle, name) ] ->
     if not (String.equal name "error_oversize")
     then fail row (String.concat [ "expected error_oversize alone, observed "; name ])
     else if cycle <> expected_tlast_cycle1
     then fail row "error_oversize pulsed on the wrong cycle"
   | pulses ->
     fail
       row
       (String.concat
          [ "expected exactly one strobe (error_oversize alone), observed "
          ; Int.to_string (List.length pulses)
          ]));
  account_truncated_frame bench frame1 words1;
  account_clean_frame bench frame2 words2 ~aborted:false;
  Dv_monitors.Conservation_monitor.strobe_pulse (conservation bench) ~name:"error_oversize";
  assert_monitors_clean bench ~row
;;

let%expect_test
  "M03-G6: a 1600-octet frame with no terminate character at all before the \
   next /S/ -- no output word and no strobe of any kind in between (REQ-108)"
  =
  run_g6 ~lane:0;
  run_g6 ~lane:4;
  [%expect {||}]
;;
