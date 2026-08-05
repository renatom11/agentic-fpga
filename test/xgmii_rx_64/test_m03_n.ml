(** M03-N2, first unit (ASSERT; REQ-102, REQ-105, REQ-107, REQ-110, REQ-101;
    AP-xgmii_rx_64.md family N; WO-0065 §3.3): two closure characters in one
    input word W, where the second falls inside the new frame B's own
    preamble -- a `/S/` in lane 0 or lane 4 of W (aborting frame A and
    opening B), and a `/T/` in a HIGHER lane of the SAME W (closing B with
    zero delivered octets).

    {2 Why this is a new file (WO-0065 §3.3.1)}

    Family N has no file yet, and M03-N1 and M03-N4 are also outstanding
    ASSERT rows this creates the eventual home for. `test/xgmii_rx_64/dune`'s
    stanza is a [library] with [(inline_tests)] and no [modules] field, so a
    new module needs no dune change, only the header comment's own
    per-packet line. And filing this row inside `test_m03_b.ml` would repeat
    a mistake this programme has already paid for once: `M03-M10` shares
    `M03-B3`'s own `%expect_test` title in that file, and that sharing is
    exactly why `WO-0063B-VERDICT` §9 item 1.1 attributed a discharge
    count's move to the wrong cause (`J-dv_lead-0109` §7) -- a row filed
    under another family's title is a row a mechanical census miscounts.

    {2 Reading (i), ruled}

    (WO-0029 §3a, endorsed on a second independent ground at REQ-101,
    converted at `06c1eba`.) The `/S/` aborts the open frame A -- one
    `error_start_without_terminate`, `tuser`[0] = 1 on its `tlast` word
    where it emitted one, no FCS removed (REQ-103, REQ-110) -- and the
    `/T/` closes the frame that same `/S/` opened (frame B), with ZERO
    delivered octets: no output word, one `error_runt` (REQ-107, §9 ruling
    9's sub-5 class).

    Both closure characters are placed as corruptions on frame A's own
    declared array, because B is opened by the STIMULUS itself and has no
    catalogue entry of its own (`test/xgmii/injection.mli`: "a frame the
    stimulus opens ... gets an outcome even though no entry of the
    catalogue describes it"). B's own preamble position for the `/T/` is
    (the `/T/`'s octet time) minus (the `/S/`'s octet time), which this
    file's own six sub-cases all place at 2 -- always inside 1 .. 7 and
    always in the SAME input word W, guarded explicitly per sub-case (T12).

    This packet commissions `/T/` at all six sub-cases -- the character
    SPEC-M03 §6.1's landed cycle table is written for. An `/E/` as B's
    second closure character is earned but NOT commissioned here (WO-0065
    §6.2 item 1): it buys no REQ-105 coverage this suite lacks (family E
    and M03-B2 both already drive it) and creates no SPEC-M03 §6.3 item 8
    instance either (B's strobe merely changes name from `error_runt` to
    `error_bad_frame`, so the coincidences stay different-name).

    {2 Six sub-cases, not four}

    (SPEC-M03 §6.1's landed cycle table, matching `AP-xgmii_rx_64.md` §4.N
    row for row -- re-derived independently below from requirements.md
    §0.5's "deciding input word" and §0.6's window, never from
    `test/xgmii/injection.mli`'s or `idle_injection.mli`'s docstrings,
    which carried a WITHDRAWN gap-invariance ground before this packet's
    own §6.1 debt 4 repair -- T11.) The discriminators are the ABORTING
    `/S/`'s own lane, the ABORTED frame A's own start lane, and whether A
    delivered an octet:

    {v
    # | /S/ lane | A start lane | A delivered | A's report | B's report | same cycle? | pays bound 7?
    1 |    0     |      0       |   >= 1      |    W+1     |    W+2     |     no      | no
    2 |    0     |      4       |   >= 1      |    W+1     |    W+2     |     no      | no
    3 |    0     |    either    |     0       |    W+2     |    W+2     |    yes      | no
    4 |    4     |      0       |   >= 1      |    W+2     |    W+2     |    yes      | YES
    5 |    4     |      4       |   >= 1      |    W+1     |    W+2     |     no      | YES
    6 |    4     |    either    |     0       |    W+2     |    W+2     |    yes      | lane-4-start instance only
    v}

    {2 WO-0058 bound 7, paid here in full for the first time}

    (WO-0065 §3.3.3.) Bound 7 wants an IN-WORD REQ-110 abort with a frame
    ALREADY OPEN on entry to that word. Sub-cases 4 and 5 both have the
    aborting `/S/` in LANE 4 -- mid-word, never a word boundary -- with
    frame A already an open frame (accepted its own `/S/`, not yet closed)
    well before this word began. Neither M03-B4 member pays it (WO-0065
    T1): both have the aborting `/S/` in lane 0, a word-boundary landing,
    never in-word. Sub-cases 1, 2 and 3 of THIS row are also lane-0-`/S/`
    and do not pay it either, for the identical reason, stated once here.

    Sub-case 6 is SPLIT, derived rather than assumed (WO-0065 §3.3.2). At a
    LANE-0-START A the aborting `/S/` in lane 4 lands at A's OWN preamble
    position 4, in the SAME word A itself opened -- nothing was open on
    entry (M03-B4 member (a)'s own geometry) -- so it does NOT pay bound 7.
    At a LANE-4-START A there is no preamble-range placement that reaches
    lane 4 at all: lane 4 of A's own start word is A's own `/S/`, and A's
    remaining preamble positions (4 .. 7) occupy lanes 0 .. 3 of the
    FOLLOWING word, never lane 4 of it -- the only way to land the
    aborting `/S/` at lane 4 for a lane-4-start A is to replace A's own
    first FRAME octet (`At_octet 0`), one octet-time later. A had already
    accepted its own `/S/` in the PRECEDING word, so A was an open frame
    entering this one, and the landing itself is lane 4 -- in-word. This
    file builds the LANE-4-START instance of sub-case 6, the one that pays
    bound 7 -- a THIRD bound-7 instance, in the zero-delivered form. The
    lane-0-start instance is derived above and not built.

    {2 The traps this file exists to guard}

    T7: `tuser`[0] exists on sub-cases 1, 2, 4, 5 (A delivered, has a
    `tlast` word) and does NOT exist on 3, 6 (A delivered nothing, no
    `tlast` word to carry it -- M03-E2's prohibition, `WO-0062` §2 bar 12).

    T8: A's strobe set on the delivered sub-cases is
    `error_start_without_terminate` ALONE, even where A delivers FEWER
    than five octets (sub-cases 2 and 4, four octets each): the runt check
    (§9 ruling 9) is sequenced at REQ-106's own `/T/` exit, which an
    `/S/`-aborted frame never takes, so `error_runt` is never owed for A
    regardless of its delivered count.

    T9: `error_bad_fcs` pulses for NEITHER frame, in EVERY sub-case -- no
    FCS removal is attempted on a frame with nothing to remove it from
    (REQ-103, REQ-110), and B's zero-delivered close never reaches
    REQ-104's residue comparison either (§9's sixth row).

    T10: the three coinciding sub-cases (3, 4, 6) put both strobes on the
    SAME cycle under DIFFERENT names (`error_start_without_terminate` for
    A, `error_runt` for B, always). This is ordinary and fully observable
    per requirements.md §0.6, and SPEC-M03 §6.3 item 8 -- which excludes
    only a SAME-name coincidence -- has NO instance in this file; no
    comment, message or Return-log sentence here claims otherwise.

    T12: both landing sites, for both characters, with W guarded explicitly
    for agreement between the two -- a sub-case whose two characters
    silently land in different input words is a different row with a
    different table.

    Derived from requirements.md REQ-101, REQ-102, REQ-105, REQ-107,
    REQ-110, REQ-018, §0.3, §0.5, §0.6, §0.7, §2, §12; SPEC-M03 §6.1's
    landed cycle table, §6.2, §6.3 items 3 and 8, §7, §9's closure list and
    nine-row table, §10; `AP-xgmii_rx_64.md` §4.N; `agents/handoffs/
    WO-0065_tb-m03-family-b-completion-and-n2.md` §3.3 -- all read as spec
    text. No `libs/**`, `top/**` or `rtl_snapshots/**` was opened
    (PROTOCOL §10). *)

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

(* requirements.md §0.6's window, re-derived directly from its own text (not
   from test/xgmii/injection.mli's docstring -- T11): not earlier than the
   cycle the closing character's own word supplies, not later than
   SPEC-M03 §7's ΔC = 3 cycles after the input word carrying the offending
   frame's last RECEIVED octet -- or, where it received none, after the
   word carrying the character that closed it (§0.6's third clause). *)
let window ~start_ot ~received ~closing_ot =
  let last_octet_ot = if received > 0 then start_ot + 8 + (received - 1) else closing_ot in
  (closing_ot / 8), (last_octet_ot / 8) + 3
;;

(* SPEC-M03 §9's "Strobe cycle, pinned" rule for a frame closed by an abort,
   in its two branches (WO-0068 §1): the frame's own tlast cycle where it
   delivered an octet (§7's per-octet constant, L = 16 at a lane-0 start and
   12 at a lane-4 one -- AP §4.N's Route 2, the route that makes the
   ABORTED frame's own start lane a discriminator), and two cycles after the
   input word carrying the CLOSING character where it delivered none.

   [~closing_ot] is the octet time of the character that CLOSED the frame,
   not the octet time of the frame's own last octet -- SPEC-M03 §6.1's
   D(m) re-ruling at 1f3c04c, countersigned J-dv_lead-0086: "an aborted
   frame's last word can be proven last by nothing except the character
   that aborted it". This is the sentence that makes the figure survive
   idle injection, and it is why the parameter is named for the closing
   character, never for the frame's own last octet.

   Every row that needs an aborted frame's own report cycle calls this. A
   second expression computing it anywhere in test/** is BOUNCE B5. *)
let aborted_report_cycle ~a_lane ~start_ot ~delivered ~closing_ot =
  if delivered > 0
  then (
    let l = if a_lane = 0 then 16 else 12 in
    let last_in = start_ot + 8 + (delivered - 1) in
    (last_in + l) / 8)
  else (closing_ot / 8) + 2
;;

type subcase =
  { s_lane : int (* the aborting /S/'s own lane in W: 0 or 4 *)
  ; a_lane : int (* frame A's own start lane: 0 or 4 *)
  ; s_idx : int (* A-relative array index the /S/ replaces (At_octet s_idx) *)
  ; t_idx : int (* A-relative array index the /T/ replaces (At_octet t_idx) *)
  ; a_delivered : int
  ; w : int (* the shared input word carrying both characters *)
  ; a_cycle : int (* frame A's own report cycle *)
  ; b_cycle : int (* frame B's own report cycle *)
  ; coincides : bool
      (* DEFECT N-2 (RV-0065-VERDICT §2): whether A's and B's own report
         cycles coincide -- a STATED fact of this sub-case's own §4.N
         table cell, asserted below against (a_cycle = b_cycle) rather
         than left inferable only from those two fields agreeing by
         accident. *)
  }

(* Sub-case 1: /S/ lane 0, A lane 0, A delivered >= 1. Lane-0 landings occur
   only at octet times = 0 mod 8; the first one past A's own first frame
   octet (octet time 16) is octet time 24 (index 8), giving A EXACTLY one
   full word (8 octets) delivered before the abort -- forced by the lane
   granularity, not chosen. /T/ two lanes higher, index 10, octet time 26,
   B's own preamble position 2. Derived tuple: (W=3, /S/ lane 0, /T/ lane
   2, A delivered 8, A's cycle 4, B's cycle 5). *)
let sc1 =
  { s_lane = 0
  ; a_lane = 0
  ; s_idx = 8
  ; t_idx = 10
  ; a_delivered = 8
  ; w = 3
  ; a_cycle = 4
  ; b_cycle = 5
  ; coincides = false
  }

(* Sub-case 2: /S/ lane 0, A lane 4, A delivered >= 1. A's own first frame
   octet is octet time 20, lane 4 (frame octets 0 .. 3 occupy lanes 4 .. 7
   of the word after A's start word at a lane-4 start); the first LANE-0
   landing past it is octet time 24 (index 4), giving A four octets
   delivered. /T/ at index 6, octet time 26, B's own preamble position 2.
   Derived tuple: (W=3, /S/ lane 0, /T/ lane 2, A delivered 4, A's cycle 4,
   B's cycle 5). *)
let sc2 =
  { s_lane = 0
  ; a_lane = 4
  ; s_idx = 4
  ; t_idx = 6
  ; a_delivered = 4
  ; w = 3
  ; a_cycle = 4
  ; b_cycle = 5
  ; coincides = false
  }

(* Sub-case 3: /S/ lane 0, A delivered 0 (built at A lane 0 -- the lane-4
   instance is B4 member (b)'s own geometry exactly, At_preamble 4, and is
   left to that member rather than duplicated here). No preamble position
   of a lane-0-start A reaches lane 0 (lane 0 of the start word is A's own
   /S/), so the only way to land the aborting /S/ at lane 0 with A
   delivered 0 is to replace A's own first frame octet, index 0, octet
   time 16 -- REQ-110's "at ... the frame's first octet" clause exactly.
   /T/ at index 2, octet time 18, B's own preamble position 2. Derived
   tuple: (W=2, /S/ lane 0, /T/ lane 2, A delivered 0, A's cycle 4, B's
   cycle 4 -- coincide, different names, T10). *)
let sc3 =
  { s_lane = 0
  ; a_lane = 0
  ; s_idx = 0
  ; t_idx = 2
  ; a_delivered = 0
  ; w = 2
  ; a_cycle = 4
  ; b_cycle = 4
  ; coincides = true
  }

(* Sub-case 4 -- the plan's own minimal witness for defect M03-R1 (AP
   §4.N): /S/ lane 4, A lane 0, A delivered >= 1. A's own first frame
   octet is at index 0, octet time 16; the first LANE-4 landing past it is
   octet time 20 (index 4), giving A four octets delivered -- A was
   already delivering (in Frame state) throughout the word the abort
   lands in, so this pays bound 7. /T/ at index 6, octet time 22, B's own
   preamble position 2. Derived tuple: (W=2, /S/ lane 4, /T/ lane 6, A
   delivered 4, A's cycle 4, B's cycle 4 -- coincide, T10; pays bound 7). *)
let sc4 =
  { s_lane = 4
  ; a_lane = 0
  ; s_idx = 4
  ; t_idx = 6
  ; a_delivered = 4
  ; w = 2
  ; a_cycle = 4
  ; b_cycle = 4
  ; coincides = true
  }

(* Sub-case 5: /S/ lane 4, A lane 4, A delivered >= 1. A's own first frame
   octet is octet time 20, lane 4 -- that IS a lane-4 landing, but at
   delivered 0 (sub-case 6's own geometry); the NEXT lane-4 landing is a
   full word later, octet time 28 (index 8), giving A eight octets
   delivered, already open and delivering well before this word began --
   pays bound 7. /T/ at index 10, octet time 30, B's own preamble position
   2. Derived tuple: (W=3, /S/ lane 4, /T/ lane 6, A delivered 8, A's
   cycle 4, B's cycle 5; pays bound 7). *)
let sc5 =
  { s_lane = 4
  ; a_lane = 4
  ; s_idx = 8
  ; t_idx = 10
  ; a_delivered = 8
  ; w = 3
  ; a_cycle = 4
  ; b_cycle = 5
  ; coincides = false
  }

(* Sub-case 6, the LANE-4-START instance of the split derived above: /S/
   lane 4, A delivered 0, built at A lane 4. The aborting /S/ replaces A's
   own first frame octet, index 0, octet time 20, lane 4 (frame octet 0's
   own lane at a lane-4 start) -- the only way to reach lane 4 with A
   delivered 0 there. A had already accepted its own /S/ in the PRECEDING
   word and had not yet delivered anything, so A was an open frame
   entering this word, and the landing is in-word -- pays bound 7, a
   THIRD instance, in the zero-delivered form. /T/ at index 2, octet time
   22, B's own preamble position 2. Derived tuple: (W=2, /S/ lane 4, /T/
   lane 6, A delivered 0, A's cycle 4, B's cycle 4 -- coincide, T10; pays
   bound 7 at this instance only). *)
let sc6 =
  { s_lane = 4
  ; a_lane = 4
  ; s_idx = 0
  ; t_idx = 2
  ; a_delivered = 0
  ; w = 2
  ; a_cycle = 4
  ; b_cycle = 4
  ; coincides = true
  }

let run_subcase ~row sc =
  (* DEFECT N-1 repair (RV-0065-VERDICT §2): test/xgmii/arrival.ml's own
     standing obligation 5 refuses any declared frame under five octets
     ("a frame below five octets delivers nothing (REQ-107) and is an
     injection case, not a schedule case"), so sc3/sc6's own t_idx = 2
     (giving array_len 3 without the floor) must be padded to it; every
     other sub-case's own t_idx (6 or 10) already clears the floor and is
     left untouched by the [max]. Derived, not assumed: the two trailing
     filler octets this padding adds at sc3/sc6 (array indices 3 and 4)
     arrive strictly AFTER the /T/ that closes frame B with zero
     delivered octets at index sc.t_idx = 2 -- by which point A is
     already aborted (at index sc.s_idx = 0) and B is already closed, so
     no frame is open to receive them. SPEC-M03 §6.2's `Idle` row governs
     what M03 does with them: it "ignores every lane" regardless of
     value, so Arrival's own auto-terminate simply lands with nothing
     open -- these are plain (non-control) filler octets, not REQ-113's
     out-of-frame control characters, but `Idle`'s "ignores every lane"
     covers both alike. The [ oa; ob ] two-outcome match below is what
     PROVES no third frame's outcome appears from this padding -- left
     unwidened to absorb one, per the verdict's own instruction.

     The post-closure geometry in full, re-derived at RV-0065B-VERDICT §2
     from requirements.md §0.3/§0.5's lane mapping (octet time t lies at
     lane t mod 8 of word t / 8) -- because TWO characters cross the word
     boundary at sc6, not the one the return flagged, and the second of
     them is a CONTROL character the "plain filler octets" sentence above
     does not reach:

       sc3 (a_lane 0, start_ot 8): /S/ at ot 16 = W(2) lane 0; /T/ at 18 =
       W lane 2; filler at 19, 20 = W lanes 3, 4; then Arrival's own
       auto-terminate at start_ot + 8 + array_len = 21 = W lane 5, and
       /I/ from 22. Everything stays inside W.

       sc6 (a_lane 4, start_ot 12): /S/ at ot 20 = W(2) lane 4; /T/ at 22 =
       W lane 6; filler at 23 = W lane 7 and at 24 = W+1(3) lane 0; then
       the auto-terminate at 25 = W+1 lane 1, and /I/ from 26. The second
       filler octet AND the auto-terminate both land in W+1.

     The crossing changes nothing, on three properties of §6.2's `Idle`
     row and not on the filler octets' plainness: (i) the row states its
     behaviour PER LANE, with no word index and no lane index -- lane 0 of
     W+1 is the same case as lane 3 of W; (ii) it states it over EVERY
     lane, so it covers the control characters (the auto-terminate, the
     trailing /I/) exactly as it covers data -- which is the citation that
     actually carries the auto-terminate, since REQ-113 and the
     plain-octet distinction do not; (iii) `Idle` holds no state a word
     boundary could disturb (tvalid = 0, CRC register held), and its ONLY
     exit is /S/ in lane 0 or lane 4 -- none of the crossing characters is
     a /S/. What is genuinely new at sc3/sc6 is therefore only the
     crossing: all four delivered sub-cases already put the auto-terminate
     in `Idle` one octet after the injected /T/ (t_idx = array_len - 1 at
     each), and were green at 88413b9 before this floor existed. *)
  let array_len = max 5 (sc.t_idx + 1) in
  let octets = List.init array_len ~f:(fun j -> j land 0xFF) in
  let case =
    Dv_xgmii.Injection.corrupt
      octets
      [ Dv_xgmii.Injection.Place
          { placement = Dv_xgmii.Injection.At_octet sc.s_idx
          ; character = Dv_xgmii.Xgmii_word.start_char
          }
      ; Dv_xgmii.Injection.Place
          { placement = Dv_xgmii.Injection.At_octet sc.t_idx
          ; character = Dv_xgmii.Xgmii_word.terminate_char
          }
      ]
  in
  let inj = Dv_xgmii.Injection.create ~first_lane:sc.a_lane [ case ] in
  if not (Dv_xgmii.Injection.is_clean inj)
  then
    (* item 2: a non-empty errors list is a construction failure, not a
       result (injection.mli). *)
    fail
      row
      (String.concat
         ~sep:"; "
         ("Injection construction errors:" :: Dv_xgmii.Injection.errors inj));
  let sched = Dv_xgmii.Injection.schedule inj in
  let frame_a = (Dv_xgmii.Arrival.frames sched).(0) in
  let start_ot_a = frame_a.Dv_xgmii.Arrival.start_octet_time in
  let expected_start_ot_a = if sc.a_lane = 0 then 8 else 12 in
  if start_ot_a <> expected_start_ot_a
  then fail row "test bug -- frame A's own start does not match this sub-case's own start lane";
  let s_ot = start_ot_a + 8 + sc.s_idx in
  let t_ot = start_ot_a + 8 + sc.t_idx in
  let s_lane = Int.rem s_ot 8 in
  let t_lane = Int.rem t_ot 8 in
  (* T12, two independent guards, each alone sufficient to catch a geometry
     error, in the order below -- the guard-ordering note WO-0065 §6.1
     debt 3 commissions, carried into this new file: an earlier
     fail-raising guard prevents a later, independently sufficient
     instrument from ever speaking. First, that W agrees between the two
     characters; second, that both land at their own declared lanes with
     /T/ strictly above /S/ in the SAME word. *)
  if s_ot / 8 <> sc.w || t_ot / 8 <> sc.w
  then fail row "test bug -- the two characters do not land in this sub-case's own word W (T12)";
  if s_lane <> sc.s_lane || t_lane <= s_lane
  then
    fail
      row
      "test bug -- the /S/ is not at its own declared lane, or the /T/ is not strictly \
       above it in the same word (T12)";
  let b_preamble_position = t_ot - s_ot in
  if b_preamble_position < 1 || b_preamble_position > 7
  then fail row "test bug -- B's own preamble position for the /T/ is outside 1 .. 7";
  let expected_a_cycle =
    aborted_report_cycle
      ~a_lane:sc.a_lane
      ~start_ot:start_ot_a
      ~delivered:sc.a_delivered
      ~closing_ot:s_ot
  in
  let expected_a_not_before, expected_a_not_after =
    window ~start_ot:start_ot_a ~received:sc.a_delivered ~closing_ot:s_ot
  in
  if expected_a_cycle <> sc.a_cycle
  then fail row "test bug -- frame A's own derived report cycle disagrees with this sub-case's stated one";
  let expected_b_not_before, expected_b_not_after = window ~start_ot:s_ot ~received:0 ~closing_ot:t_ot in
  let expected_b_cycle = (t_ot / 8) + 2 in
  if expected_b_cycle <> sc.b_cycle
  then fail row "test bug -- frame B's own derived report cycle disagrees with this sub-case's stated one";
  (* DEFECT N-2, the coincidence half (RV-0065-VERDICT §2): whether A's and
     B's own report cycles coincide is this sub-case's own STATED fact
     (sc.coincides), checked here against the two derived cycles rather
     than left inferable only from them agreeing by accident -- the
     property the table at AP §4.N / WO-0065 §3.3.2 lists in its own
     "same cycle?" column. *)
  if not (Bool.equal (sc.a_cycle = sc.b_cycle) sc.coincides)
  then
    fail
      row
      "test bug -- this sub-case's own coincides flag disagrees with a_cycle = b_cycle";
  (* Two derivations, in this order (WO-0062 §2 bar 2): the figures above
     are derived from the spec text; here they are cross-checked against
     Dv_xgmii.Injection.outcomes, never taken from it. *)
  (match Dv_xgmii.Injection.outcomes inj with
   | [ oa; ob ] ->
     if oa.Dv_xgmii.Injection.received <> sc.a_delivered then fail_cross row "frame A received";
     if oa.Dv_xgmii.Injection.delivered <> sc.a_delivered then fail_cross row "frame A delivered";
     (* BAR B-2 fold-in (RV-0065-VERDICT §4/§12 item 3): the suite's
        standing cross-check depth for a piece that delivers is
        received/delivered/words/last_tkeep/tlast_cycle/reports (M03-B4's
        own depth, `run_b4b`); frame A here had received/delivered/reports
        only. [words] = ceil(delivered / 8) and [last_tkeep] follow
        REQ-011 (0 when no word is emitted; 1 .. 8 contiguous ones from
        bit 0 otherwise) -- one shared pair of formulas that covers the
        zero-delivered sub-cases (3, 6) exactly as well as the delivered
        ones (1, 2, 4, 5), rather than one check per branch. *)
     let expected_a_words = (sc.a_delivered + 7) / 8 in
     let expected_a_last_tkeep =
       if sc.a_delivered = 0
       then 0
       else if Int.rem sc.a_delivered 8 = 0
       then 0xFF
       else (1 lsl Int.rem sc.a_delivered 8) - 1
     in
     if oa.Dv_xgmii.Injection.words <> expected_a_words then fail_cross row "frame A words";
     if oa.Dv_xgmii.Injection.last_tkeep <> expected_a_last_tkeep
     then fail_cross row "frame A last_tkeep";
     (match oa.Dv_xgmii.Injection.tlast_cycle with
      | Some c when sc.a_delivered > 0 && c = sc.a_cycle -> ()
      | None when sc.a_delivered = 0 -> ()
      | _ -> fail_cross row "frame A tlast_cycle");
     (match oa.Dv_xgmii.Injection.reports with
      | [ r ]
        when String.equal r.Dv_xgmii.Injection.strobe "error_start_without_terminate"
             && r.Dv_xgmii.Injection.cycle = sc.a_cycle
             && r.Dv_xgmii.Injection.not_before = expected_a_not_before
             && r.Dv_xgmii.Injection.not_after = expected_a_not_after -> ()
      | _ -> fail_cross row "frame A reports");
     if ob.Dv_xgmii.Injection.received <> 0 then fail_cross row "frame B received";
     if ob.Dv_xgmii.Injection.delivered <> 0 then fail_cross row "frame B delivered";
     (match ob.Dv_xgmii.Injection.reports with
      | [ r ]
        when String.equal r.Dv_xgmii.Injection.strobe "error_runt"
             && r.Dv_xgmii.Injection.cycle = sc.b_cycle
             && r.Dv_xgmii.Injection.not_before = expected_b_not_before
             && r.Dv_xgmii.Injection.not_after = expected_b_not_after -> ()
      | _ -> fail_cross row "frame B reports")
   | outcomes ->
     fail_cross
       row
       (String.concat
          [ "outcome count (expected 2: frame A, frame B; got "
          ; Int.to_string (List.length outcomes)
          ; ")"
          ]));
  (* Landing, site 1 (WO-0062 §2 bar 3): both characters in the SCHEDULE's
     own word W, before a single cycle is driven. *)
  let pre_run_word = Dv_xgmii.Injection.word_at inj ~cycle:sc.w in
  if (not (Dv_xgmii.Xgmii_word.is_control pre_run_word s_lane))
     || not (Int.equal (pre_run_word.Dv_xgmii.Xgmii_word.data).(s_lane) Dv_xgmii.Xgmii_word.start_char)
  then fail row "test bug -- the injected \"/S/\" does not land at its own lane of W before driving";
  if (not (Dv_xgmii.Xgmii_word.is_control pre_run_word t_lane))
     || not
          (Int.equal (pre_run_word.Dv_xgmii.Xgmii_word.data).(t_lane) Dv_xgmii.Xgmii_word.terminate_char)
  then fail row "test bug -- the injected \"/T/\" does not land at its own lane of W before driving";
  let bench = create () in
  Dv_monitors.Strobe_monitor.expect
    (strobes bench)
    { Dv_monitors.Strobe_monitor.strobe = "error_start_without_terminate"
    ; frame = 0
    ; cycle = sc.a_cycle
    ; not_before = expected_a_not_before
    ; not_after = expected_a_not_after
    ; why =
        "REQ-110: the /S/ in W aborts frame A, which is still open when W arrives \
         (SPEC-M03 §6.1's two-events-in-one-word paragraph, its landed cycle table; \
         WO-0065 §3.3)"
    };
  Dv_monitors.Strobe_monitor.expect
    (strobes bench)
    { Dv_monitors.Strobe_monitor.strobe = "error_runt"
    ; frame = 1
    ; cycle = sc.b_cycle
    ; not_before = expected_b_not_before
    ; not_after = expected_b_not_after
    ; why =
        "REQ-107: the /T/ in the SAME word W closes frame B, which that /S/ opened, with \
         zero delivered octets (§9 ruling 9's sub-5 class); §9's no-output-word pin, two \
         cycles after W (WO-0065 §3.3)"
    };
  let samples =
    run bench sched ~drain:8 ~word_at:(fun ~cycle -> Dv_xgmii.Injection.word_at inj ~cycle) ()
  in
  (* Landing, site 2: the cycle {!run} ACTUALLY drove. *)
  (match List.find samples ~f:(fun s -> s.cycle = sc.w) with
   | None -> fail row "test bug -- W was never driven"
   | Some s ->
     if (not (Dv_xgmii.Xgmii_word.is_control s.in_word s_lane))
        || not (Int.equal (s.in_word.Dv_xgmii.Xgmii_word.data).(s_lane) Dv_xgmii.Xgmii_word.start_char)
     then fail row "the driven word W does not carry the injected \"/S/\" -- assertions below would be vacuous";
     if (not (Dv_xgmii.Xgmii_word.is_control s.in_word t_lane))
        || not
             (Int.equal (s.in_word.Dv_xgmii.Xgmii_word.data).(t_lane) Dv_xgmii.Xgmii_word.terminate_char)
     then fail row "the driven word W does not carry the injected \"/T/\" -- assertions below would be vacuous");
  (* Structural (item 3): B produces no output word at all, ever; on the
     zero-delivered sub-cases A produces none either. *)
  let words_out = delivered_samples samples in
  if sc.a_delivered = 0
  then (
    if not (List.is_empty words_out)
    then fail row "expected NO output word at all (both frames zero-delivered, §0.7), got some";
    (* Both zero-delivered sub-cases (3, 6) have sc.coincides = true --
       already asserted against a_cycle = b_cycle above -- so both pulses
       are required to land on sc.a_cycle here by construction, not by a
       fresh derivation. *)
    (match error_pulses samples with
     | [ (c1, n1); (c2, n2) ] ->
       let names_ok =
         (String.equal n1 "error_start_without_terminate" && String.equal n2 "error_runt")
         || (String.equal n1 "error_runt" && String.equal n2 "error_start_without_terminate")
       in
       if (not names_ok) || c1 <> sc.a_cycle || c2 <> sc.a_cycle
       then
         fail
           row
           "expected exactly error_start_without_terminate and error_runt, both on the \
            same cycle, under DIFFERENT names (T10) -- no error_bad_fcs (T9)"
     | pulses ->
       fail
         row
         (String.concat
            [ "expected exactly two strobe pulses over the WHOLE run, observed "
            ; Int.to_string (List.length pulses)
            ]));
    account_dropped_frame bench frame_a ~strobe:"error_start_without_terminate")
  else (
    (match words_out with
     | [ s ] ->
       let expected_tkeep =
         if Int.rem sc.a_delivered 8 = 0 then 0xFF else (1 lsl Int.rem sc.a_delivered 8) - 1
       in
       if s.cycle <> sc.a_cycle
       then fail row "frame A's own tlast word did not arrive on its own pinned cycle";
       if s.out.Dv_monitors.Stream_word.tkeep <> expected_tkeep
       then fail row "frame A's own tlast word tkeep does not match the delivered count";
       if not s.out.Dv_monitors.Stream_word.tlast
       then fail row "frame A's own single delivered word does not carry tlast";
       (* T7: tuser[0] = 1 on A's own tlast word (REQ-110's main clause) --
          never asserted on sub-cases 3/6, which have no tlast word. *)
       if s.out.Dv_monitors.Stream_word.tuser <> 1
       then fail row "frame A's own tlast word does not carry tuser[0] = 1 (REQ-110)";
       (* Fold-in 3 (WO-0068 §6, BOUNCE B2, its last carrier): frame A's own
          delivered CONTENT, not merely its count -- compared against THIS
          SUB-CASE'S OWN DECLARED-ARRAY PREFIX, built with the SAME
          generator [octets] itself uses above, never against
          [Arrival.delivered] or [Frame.delivered] (both strip an FCS this
          aborted frame never reaches, REQ-103/REQ-110 -- the trap is LIVE:
          Arrival.delivered on sc1's own array drops its last four entries
          and returns 7 octets against the 8 this check expects, wrong in
          length AND in content). [tkeep] above already pins the length, so
          this is a pure content check. *)
       let expected_a_octets = List.init sc.a_delivered ~f:(fun j -> j land 0xFF) in
       if not (List.equal Int.equal (Dv_monitors.Stream_word.octets s.out) expected_a_octets)
       then
         fail
           row
           (String.concat
              [ "frame A's own tlast word content differs from sub-case "
              ; row
              ; "'s own declared-array prefix: expected "
              ; Int.to_string (List.length expected_a_octets)
              ; " octets, observed "
              ; Int.to_string (List.length (Dv_monitors.Stream_word.octets s.out))
              ; " octets"
              ])
     | words ->
       fail
         row
         (String.concat
            [ "expected exactly one delivered word for frame A, got "
            ; Int.to_string (List.length words)
            ]));
    (* T8: error_start_without_terminate ALONE for A, even at four
       delivered octets (sub-cases 2 and 4) -- REQ-107's runt check is
       sequenced at REQ-106's own /T/ exit, which an /S/-aborted frame
       never takes.

       DEFECT N-2 repair (RV-0065-VERDICT §2): this branch used to
       fail(!) when c1 = c2 -- the exact inverse of sub-case 4's own
       table row (a_cycle = b_cycle = 4, sc.coincides = true), asserting
       the ABSENCE of the same-cycle coincidence its own tuple predicts.
       The disjunct below is the whole check: it pins (cycle, name) for
       both pulses in either order and is correct whether or not the
       cycles coincide, so a coinciding sub-case (4, if ever built with
       a_delivered > 0) is SUPPOSED to hit c1 = c2 here, not be failed by
       it. Whether the cycles coincide is now sc.coincides's own asserted
       fact, above -- T10's rule stands unchanged: same cycle, DIFFERENT
       strobe names, never a SPEC-M03 §6.3 item 8 instance (never a
       same-NAME coincidence, and no sentence here claims one). *)
    (match error_pulses samples with
     | [ (c1, n1); (c2, n2) ] ->
       if not
            ((c1 = sc.a_cycle && String.equal n1 "error_start_without_terminate" && c2 = sc.b_cycle
              && String.equal n2 "error_runt")
             || (c2 = sc.a_cycle && String.equal n2 "error_start_without_terminate" && c1 = sc.b_cycle
                 && String.equal n1 "error_runt"))
       then
         fail
           row
           "expected error_start_without_terminate at A's own cycle and error_runt at \
            B's, and nothing else (T8/T9)"
     | pulses ->
       fail
         row
         (String.concat
            [ "expected exactly two strobe pulses over the WHOLE run, observed "
            ; Int.to_string (List.length pulses)
            ]));
    account_forwarded_piece
      bench
      ~start_ot:start_ot_a
      ~received:sc.a_delivered
      ~delivered:sc.a_delivered
      ~aborted:true
      words_out);
  account_dropped_piece bench ~start_ot:s_ot ~received:0 ~strobe:"error_runt";
  (* Conservation (item 7): A dropped or aborted-but-forwarded, B dropped
     -- both frames reported under a strobe, neither is a clean frame.
     account_dropped_frame/account_forwarded_piece above already call
     Conservation_monitor.frame_in/frame_out or .discarded; the raw
     per-strobe histogram (REQ-008(a)/REQ-804) is independent and always
     needed on top of it (Dv_monitors.Conservation_monitor.mli). *)
  Dv_monitors.Conservation_monitor.strobe_pulse
    (conservation bench)
    ~name:"error_start_without_terminate";
  Dv_monitors.Conservation_monitor.strobe_pulse (conservation bench) ~name:"error_runt";
  assert_monitors_clean bench ~row
;;

let%expect_test
  "M03-N2 sub-case 1 (§4.N row 1): /S/ lane 0, A lane 0, A delivered -- \
   error_start_without_terminate \
   at A's own cycle, error_runt at B's, on different cycles (REQ-102, REQ-105, REQ-107, \
   REQ-110, WO-0065 §3.3)"
  =
  run_subcase ~row:"M03-N2 (S lane 0, A lane 0, delivered)" sc1;
  [%expect {||}]
;;

let%expect_test
  "M03-N2 sub-case 2 (§4.N row 2): /S/ lane 0, A lane 4, A delivered -- \
   error_start_without_terminate \
   at A's own cycle, error_runt at B's, on different cycles; A's four delivered octets \
   are NOT classified as a runt (T8) (REQ-102, REQ-105, REQ-107, REQ-110, WO-0065 §3.3)"
  =
  run_subcase ~row:"M03-N2 (S lane 0, A lane 4, delivered)" sc2;
  [%expect {||}]
;;

let%expect_test
  "M03-N2 sub-case 3 (§4.N row 3): /S/ lane 0, A zero-delivered -- both frames' reports \
   coincide, \
   different names (T10); does NOT pay WO-0058 bound 7 (a word-boundary landing) \
   (REQ-102, REQ-105, REQ-107, REQ-110, WO-0065 §3.3)"
  =
  run_subcase ~row:"M03-N2 (S lane 0, A lane 0, zero-delivered)" sc3;
  [%expect {||}]
;;

let%expect_test
  "M03-N2 sub-case 4 (§4.N row 4) -- the plan's own minimal witness for defect M03-R1: \
   /S/ lane 4, A \
   lane 0, A delivered -- both frames' reports coincide, different names (T10); A's four \
   delivered octets are NOT classified as a runt (T8); PAYS WO-0058 bound 7 for the first \
   time (REQ-102, REQ-105, REQ-107, REQ-110, WO-0065 §3.3.3)"
  =
  run_subcase ~row:"M03-N2 (S lane 4, A lane 0, delivered)" sc4;
  [%expect {||}]
;;

let%expect_test
  "M03-N2 sub-case 5 (§4.N row 5): /S/ lane 4, A lane 4, A delivered -- \
   error_start_without_terminate \
   at A's own cycle, error_runt at B's, on different cycles; PAYS WO-0058 bound 7 \
   (REQ-102, REQ-105, REQ-107, REQ-110, WO-0065 §3.3.3)"
  =
  run_subcase ~row:"M03-N2 (S lane 4, A lane 4, delivered)" sc5;
  [%expect {||}]
;;

let%expect_test
  "M03-N2 sub-case 6 (§4.N row 6; lane-4-start instance of the derived split, WO-0065 \
   §3.3.2): /S/ \
   lane 4, A zero-delivered -- both frames' reports coincide, different names (T10); \
   PAYS WO-0058 bound 7, a THIRD instance, in the zero-delivered form (REQ-102, REQ-105, \
   REQ-107, REQ-110, WO-0065 §3.3.2/§3.3.3)"
  =
  run_subcase ~row:"M03-N2 (S lane 4, A lane 4, zero-delivered)" sc6;
  [%expect {||}]
;;

(* ---- M03-N1 (WO-0068 §3) ---------------------------------------------------

   Two closure characters in one input word where the SECOND arrives AFTER
   the frame is already closed and no frame is open: a /T/ in lane 0 (the
   frame's own terminate character, unmoved) and an /E/ in lane 5 of the
   SAME word -- five octet times later on the wire, strictly inside the
   inter-frame gap. The /T/ closes the frame normally (REQ-106, FCS
   checked); the /E/ finds NO open frame and produces nothing and pulses
   nothing (§9's third row, C-12).

   The /E/ is driven through [run]'s own [?word_at] override (T6), never
   through [Dv_xgmii.Injection]: every one of that catalogue's three
   placements sits INSIDE the frame or on its own terminate octet time, and
   this row's /E/ is outside both -- inside the inter-frame gap, which is
   [Arrival]'s business, not the injection catalogue's. [overlay_e] REBUILDS
   the schedule's own word from its own eight lanes
   ([Xgmii_word.lane]/[of_lanes]) with lane 5 alone replaced -- a word built
   from scratch would destroy the /T/ in lane 0 and turn this row into a
   different one (T6, T7).

   Both members are necessarily a lane-0-/T/ hold (§6.2's [Frame] row: a
   /T/ in lane 0 covers no frame octet) -- the row's own stimulus fixes
   that; it is not a member-level discriminator:

   - (a), a lane-0 start: terminate at octet time 80 (word 10, lane 0),
     /E/ at word 10 lane 5 = octet time 85; 60 delivered octets (REQ-103),
     8 output words at cycles 4 .. 11, final tkeep 0x0F.
   - (b), a lane-4 start, a 68-octet frame (the directed set's own length
     whose terminate index, 88 mod 8 = 0, still lands /T/ in lane 0):
     terminate at octet time 88 (word 11, lane 0), /E/ at word 11 lane 5 =
     octet time 93; 64 delivered octets, 8 output words at cycles 4 .. 11,
     final tkeep 0xFF.

   The derived asymmetry that is member (b)'s whole justification: at (a)
   the /E/'s own input word (cycle 10) and the frame's own last output
   word (cycle 11) are ONE APART; at (b) they are the SAME cycle, 11. A
   design that mishandled the out-of-frame /E/ by suppressing or
   corrupting the output word on that cycle shows at (b) as a coincidence
   and at (a) not at all, so the row's verdict is proved not to depend on
   the coincidence by holding at both (WO-0068 §3.3). *)

let overlay_e sched ~e_cycle ~cycle =
  if cycle <> e_cycle
  then Dv_xgmii.Arrival.word_at sched ~cycle
  else (
    let w = Dv_xgmii.Arrival.word_at sched ~cycle in
    let lanes =
      List.init 8 ~f:(fun k ->
        if k = 5
        then Dv_xgmii.Xgmii_word.Control Dv_xgmii.Xgmii_word.error_char
        else Dv_xgmii.Xgmii_word.lane w k)
    in
    Dv_xgmii.Xgmii_word.of_lanes lanes)
;;

let run_n1
      ~row
      ~lane
      ~octets
      ~expected_terminate_ot
      ~expected_e_ot
      ~expected_delivered
      ~expected_final_tkeep
  =
  let sched = one_frame ~lane octets in
  if not (Dv_xgmii.Arrival.is_clean sched)
  then
    fail
      row
      (String.concat
         ~sep:"\n"
         ("Arrival.check found problems with the schedule:" :: Dv_xgmii.Arrival.check sched));
  let frame = (Dv_xgmii.Arrival.frames sched).(0) in
  let expected_start_ot = if lane = 0 then 8 else 12 in
  if frame.Dv_xgmii.Arrival.start_octet_time <> expected_start_ot
     || frame.Dv_xgmii.Arrival.start_lane <> lane
  then fail row "test bug -- frame's own start does not match this member's own lane";
  if not (Dv_xgmii.Frame.residue_ok octets)
  then fail row "test bug -- the stimulus frame's own FCS is not correct (Frame.residue_ok)";
  let terminate_ot = Dv_xgmii.Arrival.terminate_octet_time frame in
  if terminate_ot <> expected_terminate_ot
  then
    fail
      row
      (String.concat
         [ "frame's own terminate octet time is "
         ; Int.to_string terminate_ot
         ; ", expected "
         ; Int.to_string expected_terminate_ot
         ]);
  let terminate_word = terminate_ot / 8 in
  let terminate_lane = Int.rem terminate_ot 8 in
  if terminate_lane <> 0
  then fail row "test bug -- the frame's own terminate character is not at lane 0";
  let e_ot = (terminate_word * 8) + 5 in
  if e_ot <> expected_e_ot
  then
    fail
      row
      (String.concat
         [ "the /E/'s own derived octet time is "
         ; Int.to_string e_ot
         ; ", expected "
         ; Int.to_string expected_e_ot
         ]);
  let word_at ~cycle = overlay_e sched ~e_cycle:terminate_word ~cycle in
  (* Landing, site 1 -- before a cycle is driven (T6, T7): the OVERLAID
     word at the terminate cycle carries /T/ at lane 0 and /E/ at lane 5,
     both control, /T/'s lane strictly below /E/'s, and no start character
     shares the word. *)
  let w = word_at ~cycle:terminate_word in
  if (not (Dv_xgmii.Xgmii_word.is_control w 0))
     || not (Int.equal (w.Dv_xgmii.Xgmii_word.data).(0) Dv_xgmii.Xgmii_word.terminate_char)
  then fail row "test bug -- the overlaid word's own lane 0 does not carry /T/ before driving";
  if (not (Dv_xgmii.Xgmii_word.is_control w 5))
     || not (Int.equal (w.Dv_xgmii.Xgmii_word.data).(5) Dv_xgmii.Xgmii_word.error_char)
  then fail row "test bug -- the overlaid word's own lane 5 does not carry /E/ before driving";
  (match Dv_xgmii.Xgmii_word.start_lane w with
   | None -> ()
   | Some l ->
     fail
       row
       (String.concat
          [ "test bug -- the overlaid word unexpectedly carries a start character at lane "
          ; Int.to_string l
          ]));
  let bench = create () in
  let samples = run bench sched ~drain:8 ~word_at () in
  (* Landing, site 2 -- the cycle run actually drove. *)
  (match List.find samples ~f:(fun s -> s.cycle = terminate_word) with
   | None -> fail row "test bug -- the terminate word was never driven"
   | Some s ->
     if (not (Dv_xgmii.Xgmii_word.is_control s.in_word 0))
        || not
             (Int.equal (s.in_word.Dv_xgmii.Xgmii_word.data).(0) Dv_xgmii.Xgmii_word.terminate_char)
     then fail row "the driven word does not carry /T/ at lane 0 -- assertions below would be vacuous";
     if (not (Dv_xgmii.Xgmii_word.is_control s.in_word 5))
        || not (Int.equal (s.in_word.Dv_xgmii.Xgmii_word.data).(5) Dv_xgmii.Xgmii_word.error_char)
     then fail row "the driven word does not carry /E/ at lane 5 -- assertions below would be vacuous");
  let words_out = delivered_samples samples in
  let expected_words = (expected_delivered + 7) / 8 in
  if List.length words_out <> expected_words
  then
    fail
      row
      (String.concat
         [ "expected "
         ; Int.to_string expected_words
         ; " delivered words, got "
         ; Int.to_string (List.length words_out)
         ]);
  let expected_start_cycle = expected_start_ot / 8 in
  List.iteri words_out ~f:(fun m s ->
    let expected_cycle = expected_start_cycle + 3 + m in
    if s.cycle <> expected_cycle
    then
      fail
        row
        (String.concat
           [ "word "
           ; Int.to_string m
           ; " expected on cycle "
           ; Int.to_string expected_cycle
           ; ", observed on cycle "
           ; Int.to_string s.cycle
           ]);
    let is_last = m = expected_words - 1 in
    if not (Bool.equal s.out.Dv_monitors.Stream_word.tlast is_last)
    then
      fail
        row
        (String.concat [ "word "; Int.to_string m; ": tlast does not match its expected position" ]);
    if is_last
    then (
      if s.out.Dv_monitors.Stream_word.tkeep <> expected_final_tkeep
      then fail row "the frame's own final tkeep does not match the delivered count";
      if s.out.Dv_monitors.Stream_word.tuser <> 0
      then
        fail
          row
          "the frame's own tlast word unexpectedly carries tuser[0] = 1 -- a clean frame is not \
           aborted"));
  (* T4: this frame closes on its own /T/, so Arrival.delivered IS the
     right source here (REQ-103's four FCS octets are stripped) -- the
     OPPOSITE rule from M03-N4's frame A, below. *)
  let expected_octets = Array.to_list (Dv_xgmii.Arrival.delivered frame) in
  let got_octets = delivered_octets samples in
  if not (List.equal Int.equal got_octets expected_octets)
  then fail row "delivered octets differ from Arrival.delivered frame";
  (* The row's own kill (§9's third row, C-12): a design evaluating lane 5
     against the state the word STARTED in sees Frame, routes the /E/ to
     REQ-105 and pulses error_bad_frame. Over the WHOLE run, nothing
     pulses. *)
  if not (List.is_empty (error_pulses samples))
  then fail row "the out-of-frame /E/ unexpectedly produced a strobe";
  account_clean_frame bench frame samples ~aborted:false;
  assert_monitors_clean bench ~row
;;

let%expect_test
  "M03-N1: an /E/ five octet times after the frame's own /T/, overlaid onto \
   the schedule's own terminate word via ?word_at -- the /T/ closes the frame \
   normally (FCS checked), the /E/ finds no open frame and produces nothing \
   and pulses nothing (REQ-101, REQ-105, REQ-106, REQ-107, §9's third row / \
   C-12; WO-0068 §3)"
  =
  run_n1
    ~row:"M03-N1 (lane 0)"
    ~lane:0
    ~octets:(Dv_xgmii.Frame.stress_frame ~sequence:0 ())
    ~expected_terminate_ot:80
    ~expected_e_ot:85
    ~expected_delivered:60
    ~expected_final_tkeep:0x0F;
  run_n1
    ~row:"M03-N1 (lane 4)"
    ~lane:4
    ~octets:(directed_frame_octets ~length:68)
    ~expected_terminate_ot:88
    ~expected_e_ot:93
    ~expected_delivered:64
    ~expected_final_tkeep:0xFF;
  [%expect {||}]
;;

(* ---- M03-N4 (WO-0068 §4) ----------------------------------------------------

   REQ-802/REQ-810's mid-frame case: open a frame with cfg_rx_enable = 1,
   drop it to 0 strictly inside that frame, at least one cycle before a
   start character that arrives while it is still open; the in-flight
   frame -- frame A -- is aborted at the octet before that refused start,
   exactly ONE error_start_without_terminate, no output word for the frame
   the refused start would have begun, and the NEXT declared frame -- frame
   C -- received normally after the enable returns to 1 (ADR-0014, SPEC-M03
   §4.3, §6.2's [Frame] row).

   Three named objects, deliberately NOT "frame B" (T2, WO-0068 §4.1):
   frame A (in-flight, admitted under enable = 1, aborted by the refused
   start); the refused start (an injected /S/ that opens NOTHING under the
   real enable and is accounted NOWHERE -- not frame_in, not
   frame_in_exempt, not discarded); frame C (the next declared frame,
   admitted after re-enable).

   The mechanism (WO-0068 §4.2): [Dv_xgmii.Injection.create ~first_lane
   [ case_a; case_c ]], where [case_a] is frame A's own 64-octet declared
   array ([Frame.stress_frame]) corrupted with ONE [Place (At_octet k,
   start_char)] -- the refused start -- and [case_c] is
   [Injection.clean (Frame.stress_frame ~sequence:1 ())]. The model is
   enable-blind by construction (T1): it opens a frame at the refused
   start that the DUT must not, so [Injection.outcomes] returns THREE
   outcomes where the DUT admits only two; the middle one is asserted
   against nothing the DUT did (B7), floored only at [delivered > 0] so the
   contrast stays non-vacuous.

   Both change cycles are derived from the schedule, then checked against
   this member's own stated constants (WO-0067 §5.1's rule): the disable
   cycle as [w - 1] with [w] the word carrying the refused start, the
   enable cycle as [frame_c's own start_cycle - 1].

   Member (a): refused start at [At_octet 8] (frame A delivers 8 octets, 1
   word); member (b): [At_octet 16] (16 octets, 2 words -- the first
   member of this family to place tuser[0] on a SECOND word rather than a
   first, and to place the aborting refused start at lane 4). *)

let run_n4
      ~row
      ~lane
      ~s_idx
      ~expected_w_cycle
      ~expected_w_lane
      ~expected_a_delivered
      ~expected_disable_cycle
      ~expected_enable_cycle
      ~expected_c_start_cycle
      ~expected_c_start_lane
      ~expected_delivered_cycles
  =
  let frame_a_octets = Dv_xgmii.Frame.stress_frame ~sequence:0 () in
  let case_a =
    Dv_xgmii.Injection.corrupt
      frame_a_octets
      [ Dv_xgmii.Injection.Place
          { placement = Dv_xgmii.Injection.At_octet s_idx
          ; character = Dv_xgmii.Xgmii_word.start_char
          }
      ]
  in
  let frame_c_octets = Dv_xgmii.Frame.stress_frame ~sequence:1 () in
  let case_c = Dv_xgmii.Injection.clean frame_c_octets in
  let inj = Dv_xgmii.Injection.create ~first_lane:lane [ case_a; case_c ] in
  if not (Dv_xgmii.Injection.is_clean inj)
  then
    fail
      row
      (String.concat
         ~sep:"; "
         ("Injection construction errors:" :: Dv_xgmii.Injection.errors inj));
  let sched = Dv_xgmii.Injection.schedule inj in
  if not (Dv_xgmii.Arrival.is_clean sched)
  then
    fail
      row
      (String.concat
         ~sep:"\n"
         ("Arrival.check found problems with the schedule:" :: Dv_xgmii.Arrival.check sched));
  let frames = Dv_xgmii.Arrival.frames sched in
  if Array.length frames <> 2
  then fail row "test bug -- expected exactly 2 declared frames in the schedule";
  let frame_a = frames.(0) in
  let frame_c = frames.(1) in
  (* 1. Construction. *)
  let expected_start_ot = if lane = 0 then 8 else 12 in
  if frame_a.Dv_xgmii.Arrival.start_octet_time <> expected_start_ot
     || frame_a.Dv_xgmii.Arrival.start_lane <> lane
  then fail row "test bug -- frame A's own start does not match this member's own lane";
  let a_start_cycle = Dv_xgmii.Arrival.start_cycle frame_a in
  if not (Dv_xgmii.Frame.residue_ok frame_c_octets)
  then fail row "test bug -- frame C's own FCS is not correct (Frame.residue_ok)";
  let w_ot = frame_a.Dv_xgmii.Arrival.start_octet_time + 8 + s_idx in
  let w_cycle = w_ot / 8 in
  let w_lane = Int.rem w_ot 8 in
  if w_lane <> 0 && w_lane <> 4
  then fail row "test bug -- the refused start's own derived lane is not 0 or 4";
  if w_cycle <> expected_w_cycle || w_lane <> expected_w_lane
  then
    fail
      row
      (String.concat
         [ "the refused start's own word is cycle "
         ; Int.to_string w_cycle
         ; " lane "
         ; Int.to_string w_lane
         ; ", expected cycle "
         ; Int.to_string expected_w_cycle
         ; " lane "
         ; Int.to_string expected_w_lane
         ]);
  let a_delivered = s_idx in
  if a_delivered <> expected_a_delivered
  then
    fail row "test bug -- frame A's own derived delivered count disagrees with this member's stated one";
  let a_words = (a_delivered + 7) / 8 in
  (* 3. The two report-cycle routes agree: the shared aborted_report_cycle
     function (Route 2, WO-0068 §1) against start_cycle + 3 + (words - 1)
     (§6.1's m + 3 -- legitimate here and only here because this stimulus
     is gapless, C-14.4's qualifier). *)
  let a_cycle_route2 =
    aborted_report_cycle
      ~a_lane:lane
      ~start_ot:frame_a.Dv_xgmii.Arrival.start_octet_time
      ~delivered:a_delivered
      ~closing_ot:w_ot
  in
  let a_cycle_route_m3 = a_start_cycle + 3 + (a_words - 1) in
  if a_cycle_route2 <> a_cycle_route_m3
  then
    fail
      row
      (String.concat
         [ "the two report-cycle routes disagree: aborted_report_cycle gives "
         ; Int.to_string a_cycle_route2
         ; ", start_cycle + 3 + (words - 1) gives "
         ; Int.to_string a_cycle_route_m3
         ]);
  let a_cycle = a_cycle_route2 in
  let a_not_before, a_not_after =
    window ~start_ot:frame_a.Dv_xgmii.Arrival.start_octet_time ~received:a_delivered ~closing_ot:w_ot
  in
  let disable_cycle = w_cycle - 1 in
  let c_start_cycle = Dv_xgmii.Arrival.start_cycle frame_c in
  let enable_cycle = c_start_cycle - 1 in
  if disable_cycle <> expected_disable_cycle || enable_cycle <> expected_enable_cycle
  then
    fail
      row
      (String.concat
         [ "derived enable change cycles are ("
         ; Int.to_string disable_cycle
         ; ", "
         ; Int.to_string enable_cycle
         ; "), expected ("
         ; Int.to_string expected_disable_cycle
         ; ", "
         ; Int.to_string expected_enable_cycle
         ; ")"
         ]);
  if c_start_cycle <> expected_c_start_cycle
     || frame_c.Dv_xgmii.Arrival.start_lane <> expected_c_start_lane
  then fail row "test bug -- frame C's own start cycle/lane disagrees with this member's stated one";
  if disable_cycle <= a_start_cycle || disable_cycle >= w_cycle
  then fail row "test bug -- the disable cycle does not lie strictly inside frame A, before W";
  if enable_cycle >= c_start_cycle
  then fail row "test bug -- the enable cycle is not strictly before frame C's own start cycle";
  (* 2. T9: neither change cycle carries a start character, AT THE SITE --
     from the DRIVEN word (Injection.word_at), never Arrival. *)
  (match Dv_xgmii.Xgmii_word.start_lane (Dv_xgmii.Injection.word_at inj ~cycle:disable_cycle) with
   | None -> ()
   | Some l ->
     fail
       row
       (String.concat
          [ "the disable cycle ("
          ; Int.to_string disable_cycle
          ; ") carries a start character at lane "
          ; Int.to_string l
          ]));
  (match Dv_xgmii.Xgmii_word.start_lane (Dv_xgmii.Injection.word_at inj ~cycle:enable_cycle) with
   | None -> ()
   | Some l ->
     fail
       row
       (String.concat
          [ "the enable cycle ("
          ; Int.to_string enable_cycle
          ; ") carries a start character at lane "
          ; Int.to_string l
          ]));
  let enable = Enable.changes ~initial:true [ (disable_cycle, false); (enable_cycle, true) ] in
  (* 5. T1: the model cross-check, with its one exclusion. *)
  (match Dv_xgmii.Injection.outcomes inj with
   | [ oa; ob; oc ] ->
     if oa.Dv_xgmii.Injection.received <> a_delivered then fail_cross row "frame A received";
     if oa.Dv_xgmii.Injection.delivered <> a_delivered then fail_cross row "frame A delivered";
     if oa.Dv_xgmii.Injection.words <> a_words then fail_cross row "frame A words";
     let expected_a_last_tkeep =
       if Int.rem a_delivered 8 = 0 then 0xFF else (1 lsl Int.rem a_delivered 8) - 1
     in
     if oa.Dv_xgmii.Injection.last_tkeep <> expected_a_last_tkeep
     then fail_cross row "frame A last_tkeep";
     (match oa.Dv_xgmii.Injection.tlast_cycle with
      | Some c when c = a_cycle -> ()
      | _ -> fail_cross row "frame A tlast_cycle");
     (match oa.Dv_xgmii.Injection.reports with
      | [ r ]
        when String.equal r.Dv_xgmii.Injection.strobe "error_start_without_terminate"
             && r.Dv_xgmii.Injection.cycle = a_cycle
             && r.Dv_xgmii.Injection.not_before = a_not_before
             && r.Dv_xgmii.Injection.not_after = a_not_after -> ()
      | _ -> fail_cross row "frame A reports");
     (* B7: the named contrast, floored at delivered > 0 and asserted
        against NOTHING the DUT did -- exactly what an enable-ignoring or
        datapath-gating design would emit and what this row asserts the
        DUT does not. *)
     if not (ob.Dv_xgmii.Injection.delivered > 0)
     then
       fail
         row
         "test bug -- the model's own middle outcome (the refused start) must deliver > 0 to \
          be a non-vacuous contrast";
     (* RV-0068-VERDICT §2, §9.2: received counts octets between the start
        and closing characters (test/xgmii/injection.mli); delivered is
        received MINUS the four FCS octets REQ-103 strips. Frame C closes
        cleanly on its own /T/, so the strip applies -- same trap named at
        test_m03_b.ml:320. *)
     if oc.Dv_xgmii.Injection.received <> 64
     then
       fail_cross
         row
         "frame C received (expected 64 -- RV-0068-VERDICT §2: a cleanly closed 64-octet \
          frame's received count is NOT delivered's 60; the four FCS octets are absent from \
          delivered, not from received)";
     if oc.Dv_xgmii.Injection.delivered <> 60 then fail_cross row "frame C delivered";
     if oc.Dv_xgmii.Injection.words <> 8 then fail_cross row "frame C words";
     if oc.Dv_xgmii.Injection.last_tkeep <> 0x0F then fail_cross row "frame C last_tkeep"
   | outcomes ->
     fail_cross
       row
       (String.concat
          [ "outcome count (expected 3: frame A, the refused start, frame C; got "
          ; Int.to_string (List.length outcomes)
          ; ")"
          ]));
  (* 4. Landing, site 1 -- before a cycle is driven. *)
  let pre_run_w = Dv_xgmii.Injection.word_at inj ~cycle:w_cycle in
  if (not (Dv_xgmii.Xgmii_word.is_control pre_run_w w_lane))
     || not (Int.equal (pre_run_w.Dv_xgmii.Xgmii_word.data).(w_lane) Dv_xgmii.Xgmii_word.start_char)
  then fail row "test bug -- the refused start does not land at its own lane of W before driving";
  let bench = create () in
  Dv_monitors.Strobe_monitor.expect
    (strobes bench)
    { Dv_monitors.Strobe_monitor.strobe = "error_start_without_terminate"
    ; frame = 0
    ; cycle = a_cycle
    ; not_before = a_not_before
    ; not_after = a_not_after
    ; why =
        "REQ-110/REQ-802/REQ-810, ADR-0014 clause 3: the refused start aborts frame A exactly \
         as it would under enable = 1 -- the abort and its report are identical under either \
         enable value (WO-0068 §4)"
    };
  let samples =
    run
      bench
      sched
      ~drain:8
      ~word_at:(fun ~cycle -> Dv_xgmii.Injection.word_at inj ~cycle)
      ~enable
      ()
  in
  (* 6. Landing, site 2 -- the cycle run actually drove. *)
  (match List.find samples ~f:(fun s -> s.cycle = w_cycle) with
   | None -> fail row "test bug -- W was never driven"
   | Some s ->
     if (not (Dv_xgmii.Xgmii_word.is_control s.in_word w_lane))
        || not (Int.equal (s.in_word.Dv_xgmii.Xgmii_word.data).(w_lane) Dv_xgmii.Xgmii_word.start_char)
     then fail row "the driven word W does not carry the refused start -- assertions below would be vacuous");
  (* 7. The three named enable facts, each its own assertion. *)
  (match List.find samples ~f:(fun s -> s.cycle = a_start_cycle) with
   | None -> fail row "test bug -- A's own start cycle was never driven"
   | Some s -> if not s.enable then fail row "enable was not true on A's own start cycle");
  (match List.find samples ~f:(fun s -> s.cycle = w_cycle) with
   | None -> fail row "test bug -- W was never driven"
   | Some s -> if s.enable then fail row "enable was not false on W (the refused start's own cycle)");
  (match List.find samples ~f:(fun s -> s.cycle = c_start_cycle) with
   | None -> fail row "test bug -- C's own start cycle was never driven"
   | Some s -> if not s.enable then fail row "enable was not true on C's own start cycle");
  (* 8. The whole driven window, from an INDEPENDENTLY written predicate
     (T10) -- never sample.enable against Enable.value_at, which is the
     schedule against itself. Enable.report used here (WO-0068 §8). *)
  List.iter samples ~f:(fun s ->
    let expected = s.cycle < disable_cycle || s.cycle >= enable_cycle in
    if not (Bool.equal s.enable expected)
    then
      fail
        row
        (String.concat
           [ "cycle "
           ; Int.to_string s.cycle
           ; ": enable = "
           ; Bool.to_string s.enable
           ; ", expected "
           ; Bool.to_string expected
           ; "\n"
           ; Enable.report enable
           ]));
  (* 9. The delivered stream, whole run -- one assertion pinning A's own
     words, C's own words, and the ABSENCE of any output word for the
     refused start. Enable.report used here too (WO-0068 §8). *)
  let words_out = delivered_samples samples in
  let got_cycles = List.map words_out ~f:(fun s -> s.cycle) in
  if not (List.equal Int.equal got_cycles expected_delivered_cycles)
  then
    fail
      row
      (String.concat
         [ "delivered-sample cycles are ["
         ; String.concat ~sep:"; " (List.map got_cycles ~f:Int.to_string)
         ; "], expected ["
         ; String.concat ~sep:"; " (List.map expected_delivered_cycles ~f:Int.to_string)
         ; "]\n"
         ; Enable.report enable
         ]);
  let group_a, group_c = split_at_first_tlast words_out in
  if List.is_empty group_a
  then fail row "test bug -- frame A's own group is empty (split_at_first_tlast's own precondition)";
  if List.is_empty group_c
  then fail row "test bug -- frame C's own group is empty (split_at_first_tlast's own precondition)";
  (* 10. Frame A's own words. *)
  if List.length group_a <> a_words
  then
    fail
      row
      (String.concat
         [ "frame A's own word count is "
         ; Int.to_string (List.length group_a)
         ; ", expected "
         ; Int.to_string a_words
         ]);
  List.iteri group_a ~f:(fun m s ->
    let is_last = m = a_words - 1 in
    let expected_tkeep =
      if Int.rem a_delivered 8 = 0 then 0xFF else (1 lsl Int.rem a_delivered 8) - 1
    in
    if is_last
    then (
      if s.cycle <> a_cycle
      then fail row "frame A's own tlast word did not arrive on its own report cycle";
      if not s.out.Dv_monitors.Stream_word.tlast
      then fail row "frame A's own last word does not carry tlast";
      if s.out.Dv_monitors.Stream_word.tkeep <> expected_tkeep
      then fail row "frame A's own last word tkeep does not match the delivered count";
      if s.out.Dv_monitors.Stream_word.tuser <> 1
      then fail row "frame A's own tlast word does not carry tuser[0] = 1 (REQ-110)")
    else (
      if s.out.Dv_monitors.Stream_word.tlast
      then
        fail
          row
          (String.concat [ "frame A's own word "; Int.to_string m; " unexpectedly carries tlast" ]);
      if s.out.Dv_monitors.Stream_word.tkeep <> 0xFF
      then fail row (String.concat [ "frame A's own word "; Int.to_string m; " tkeep is not 0xFF" ]);
      if s.out.Dv_monitors.Stream_word.tuser <> 0
      then
        fail
          row
          (String.concat
             [ "frame A's own word "; Int.to_string m; " unexpectedly carries tuser[0] = 1" ])));
  (* T4: frame A's own content is the FIRST a_delivered octets of its own
     DECLARED array -- the list case_a was built from -- never
     Arrival.delivered/Frame.delivered, both of which strip four FCS
     octets this aborted frame never reaches. *)
  let expected_a_content = List.take frame_a_octets a_delivered in
  let got_a_content = List.concat_map group_a ~f:(fun s -> Dv_monitors.Stream_word.octets s.out) in
  if not (List.equal Int.equal got_a_content expected_a_content)
  then fail row "frame A's own delivered content differs from its own declared array's prefix (T4)";
  (* 11. Frame C's own words -- the OTHER content rule (T4): C closes on
     its own /T/, so Arrival.delivered IS the right source (REQ-103's four
     FCS octets are stripped). *)
  if List.length group_c <> 8
  then
    fail
      row
      (String.concat
         [ "frame C's own word count is "; Int.to_string (List.length group_c); ", expected 8" ]);
  List.iteri group_c ~f:(fun m s ->
    let expected_cycle = c_start_cycle + 3 + m in
    if s.cycle <> expected_cycle
    then
      fail
        row
        (String.concat
           [ "frame C's own word "
           ; Int.to_string m
           ; " expected on cycle "
           ; Int.to_string expected_cycle
           ; ", observed on cycle "
           ; Int.to_string s.cycle
           ]);
    let is_last = m = 7 in
    if is_last
    then (
      if not s.out.Dv_monitors.Stream_word.tlast then fail row "frame C's own word 7 does not carry tlast";
      if s.out.Dv_monitors.Stream_word.tkeep <> 0x0F then fail row "frame C's own final tkeep is not 0x0F";
      if s.out.Dv_monitors.Stream_word.tuser <> 0
      then fail row "frame C's own tlast word unexpectedly carries tuser[0] = 1")
    else if s.out.Dv_monitors.Stream_word.tlast
    then
      fail row (String.concat [ "frame C's own word "; Int.to_string m; " unexpectedly carries tlast" ]));
  let expected_c_content = Array.to_list (Dv_xgmii.Arrival.delivered frame_c) in
  let got_c_content = List.concat_map group_c ~f:(fun s -> Dv_monitors.Stream_word.octets s.out) in
  if not (List.equal Int.equal got_c_content expected_c_content)
  then fail row "frame C's own delivered content differs from Arrival.delivered frame_c";
  let got_c_seq = Dv_xgmii.Frame.sequence_of got_c_content in
  if got_c_seq <> 1
  then
    fail
      row
      (String.concat
         [ "frame C's own delivered sequence number is "
         ; Int.to_string got_c_seq
         ; ", expected 1 (provenance -- this proves it IS frame C, not merely a frame)"
         ]);
  (* 12. Exactly one strobe over the whole run (T5): no error_runt for A
     even though A delivers fewer than 64 octets (the runt check is
     sequenced at REQ-106's own /T/ exit, which an aborted frame never
     takes); no error_bad_fcs (no FCS removed); nothing for the refused
     start (ADR-0014 clause 1, REQ-810); nothing for A's own auto-terminate
     arriving in Idle (REQ-113, §6.2's Idle row). *)
  (match error_pulses samples with
   | [ (c, n) ] when c = a_cycle && String.equal n "error_start_without_terminate" -> ()
   | pulses ->
     fail
       row
       (String.concat
          [ "expected exactly one strobe (error_start_without_terminate at A's own report \
             cycle), observed "
          ; Int.to_string (List.length pulses)
          ]));
  (* 13. Accounting, in arrival order -- A first, then C (T2, T3). *)
  account_forwarded_piece
    bench
    ~start_ot:frame_a.Dv_xgmii.Arrival.start_octet_time
    ~received:a_delivered
    ~delivered:a_delivered
    ~aborted:true
    group_a;
  account_clean_frame bench frame_c group_c ~aborted:false;
  Dv_monitors.Conservation_monitor.strobe_pulse
    (conservation bench)
    ~name:"error_start_without_terminate";
  (* The by-product: A and C start at DIFFERENT lanes, so this one run
     exercises BOTH front-offset classes and both must report ΔC = 3. *)
  (match Dv_monitors.Octet_time.Latency.word_delay (latency bench) with
   | Some 3 -> ()
   | Some d -> fail row (String.concat [ "word_delay = "; Int.to_string d; ", expected Some 3" ])
   | None -> fail row "word_delay is None, expected Some 3");
  (* 14. *)
  assert_monitors_clean bench ~row
;;

let%expect_test
  "M03-N4: cfg_rx_enable 1 -> 0 strictly inside frame A, at least one cycle \
   before a refused start character -- frame A is aborted at the octet before \
   it with tuser[0] = 1 on its own tlast word, exactly one \
   error_start_without_terminate, no output word for the refused start, and \
   frame C received normally after the enable returns to 1 (REQ-105, REQ-110, \
   REQ-113, REQ-802, REQ-803, REQ-810, ADR-0014; WO-0068 §4)"
  =
  run_n4
    ~row:"M03-N4 (lane 0)"
    ~lane:0
    ~s_idx:8
    ~expected_w_cycle:3
    ~expected_w_lane:0
    ~expected_a_delivered:8
    ~expected_disable_cycle:2
    ~expected_enable_cycle:10
    ~expected_c_start_cycle:11
    ~expected_c_start_lane:4
    ~expected_delivered_cycles:[ 4; 14; 15; 16; 17; 18; 19; 20; 21 ];
  run_n4
    ~row:"M03-N4 (lane 4)"
    ~lane:4
    ~s_idx:16
    ~expected_w_cycle:4
    ~expected_w_lane:4
    ~expected_a_delivered:16
    ~expected_disable_cycle:3
    ~expected_enable_cycle:11
    ~expected_c_start_cycle:12
    ~expected_c_start_lane:0
    ~expected_delivered_cycles:[ 4; 5; 15; 16; 17; 18; 19; 20; 21; 22 ];
  [%expect {||}]
;;
