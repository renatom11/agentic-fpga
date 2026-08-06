(* WO-0046 §3 — Phase 1's stimulus: "One 64-octet good-FCS frame at a
   lane-0 start." Writes stimulus.txt: one line per cycle, two
   whitespace-separated hex tokens, "<16-hex xgmii_rxd> <2-hex xgmii_rxc>".

   This is NOT the pinned canonical form (canonical.mli) — that is the
   interface with data_wrangler's side. stimulus.txt is test/cosim's own
   internal seam between this file, [ours_run.ml] and [tb_xgmii_rx_64.v],
   each of which reads it independently; its format is this directory's own
   business and carries no obligation to any other worker.

   Frame content: [Dv_xgmii.Frame.stress_frame ~sequence:0 ()] — SPEC-M03
   §8's own frozen stimulus frame (destination MAC 02:00:00:00:00:01, source
   MAC 02:00:00:00:00:02, ethertype 0x0800, a 4-octet sequence number, 42
   filler octets, and the correct FCS from [Dv_golden.Crc32_ref], REQ-305's
   externally-anchored oracle) rather than a pattern invented for this file:
   reusing an already-reviewed, already-anchored content generator is a
   smaller bet than re-deriving 60 octets and a CRC by hand a second time.

   Schedule: [Dv_xgmii.Arrival.create ~first_start:0 [ octets ]] — a single
   frame, start character in lane 0 of octet time 0 (SPEC-M03 §6.1's own
   worked example: "Cycle 0 is the word carrying the start character"),
   trailed by the standard 12-octet minimum inter-frame gap. [Arrival.check]
   is asserted empty before anything is written — an unchecked stimulus
   generator is an unverified assertion about the design (the same rule
   test/xgmii_rx_64/bench.mli's [run] enforces for the main suite, restated
   here because this generator has no bench of its own to enforce it).

   Drain: [drain_cycles] extra idle cycles appended after the schedule's own
   end, so that whichever of the two implementations drains its own pipeline
   more slowly still produces every output word inside stimulus.txt's span.
   REQ-901's comparison is transactional (cycle alignment is not compared),
   so this only has to be generous, never exact (WO-0046 §1). SPEC-M03 §7's
   own drain window is 2 cycles past the terminate word; the reference's is
   unmeasured (this environment has no iverilog, WO-0046's rules, so its
   pipeline depth is not hand-derived here) — 24 cycles is comfortable
   margin over either. *)

let drain_cycles = 24

let build () =
  let octets = Dv_xgmii.Frame.stress_frame ~sequence:0 () in
  let sched = Dv_xgmii.Arrival.create ~first_start:0 [ octets ] in
  (match Dv_xgmii.Arrival.check sched with
   | [] -> ()
   | problems ->
     failwith
       (String.concat
          "\n"
          ("stimulus_gen: Arrival.check found an unconformant schedule:" :: problems)));
  sched
;;

(* AMENDMENT WO-0078-A1 §4 item 2 (RV-C4GAP) -- the per-case word seam.
   [write_stimulus] used to call [Dv_xgmii.Arrival.word_at sched] itself; it
   now takes that function as an explicit argument instead. For case 0, C1,
   C2 and C3 the caller passes exactly [Dv_xgmii.Arrival.word_at sched] --
   their bytes cannot move, and this is a pure factoring of what this
   function already did, not a behaviour change for them. C4 is the one
   case whose word function departs from the raw schedule, on purpose; see
   [c4_word_at] below for what it overrides and how the departure is
   checked before anything is written. *)
let write_stimulus path sched word_at =
  let oc = open_out_bin path in
  Fun.protect
    ~finally:(fun () -> close_out_noerr oc)
    (fun () ->
       let total = Dv_xgmii.Arrival.cycles sched + drain_cycles in
       for cycle = 0 to total - 1 do
         let word = word_at ~cycle in
         let d, c = Dv_xgmii.Xgmii_word.to_wire word in
         Printf.fprintf oc "%016Lx %02x\n" d c
       done)
;;

(* WO-0078 §3.2/§6.1 — the case SET, Stage 1: exactly one member, case 0,
   its construction expression ([build] above) UNEDITED — the diff of
   [build] and [write_stimulus] above shows nothing touched; what follows
   only NAMES case 0 and dispatches to it. Every later stage adds a case
   BESIDE this one, never edits it (§3.1's whole argument for why a case set
   exists at all rather than a widened single stimulus).

   The table below deliberately carries METADATA only ([id], [describe],
   [idle_counts]) and never a schedule-building function value: [build]'s
   own return type is never named anywhere in this file (it is whatever
   [Dv_xgmii.Arrival.create] returns, inferred structurally), and a record
   field typed against a name this file does not otherwise need to know
   would be the one place that guess could go wrong unnoticed. [build_case]
   below dispatches by a plain [match] instead, so [build ()]'s type is
   inferred locally from its own unedited definition, never written down.

   [idle_counts]: one entry per frame this case's schedule admits, in
   admission order — WO-0078 §5.2 / FINDING RV-0075-2's carried antecedent,
   authored HERE because this is the one place in the lane that actually
   constructs the schedule and so is the only place that can state the
   count from first-hand knowledge rather than inference. Case 0 admits
   exactly one frame with its start character at [~first_start:0] (FI-1),
   the very first driven word — there is no room before it for an injected
   idle, so its count is exactly 0, by construction of case 0 itself, not
   by absence of a feature. *)
type case_meta =
  { id : string
  ; describe : string
  ; idle_counts : int list
  }

let case0_meta : case_meta =
  { id = "0"
  ; describe =
      "WO-0046 §3 -- one 64-octet good-FCS frame, lane-0 start (frozen, byte-identical, \
       never edited, WO-0078 §3.1)"
  ; idle_counts = [ 0 ]
  }
;;

(* WO-0078 §6.2's Stage-2 C1/C2 landing -- a shared conformance-check helper,
   factored so C1's and C2's own builders below do not each re-inline case
   0's own [Arrival.check] boilerplate line for line. Case 0's own [build]
   above is UNEDITED and does not call this: duplicating three lines once,
   rather than routing case 0 through a shared helper too, is what keeps
   case 0's construction expression exactly as WO-0078 §3.1/§10 item 7
   require -- untouched, not merely equivalent after a refactor. *)
let check_conformant ~case_label sched =
  match Dv_xgmii.Arrival.check sched with
  | [] -> sched
  | problems ->
    failwith
      (String.concat
         "\n"
         (Printf.sprintf
            "stimulus_gen: Arrival.check found an unconformant schedule (case %s):"
            case_label
          :: problems))
;;

(* WO-0078 §6.2 C1 (CD §10.1) -- "lane-4 start on cycle 0 -- ~first_start:4,
   otherwise case 0's frame." Same [Frame.stress_frame ~sequence:0] as case
   0, same default [?ifg] (12, requirements.md §0.3's minimum), only
   [~first_start] moves from case 0's 0 to 4.

   [Arrival.create]'s own contract (arrival.mli) requires [?first_start] be a
   multiple of 4; 4 is therefore a lane-4 start ON CYCLE 0 -- the SIGHTED
   PLACEMENT WO-0078 §4.2 item 2 requires preserved ("a placement
   the M03 bench does not contain at all"), where the naive [~first_start:12]
   would have been a lane-4 start on cycle 3 (REQ-101's other start lane, but
   off the reset-release cycle) and silently traded the one measured
   capability this lane has ever had (§3.1) for the lane-4 coverage alone.
   CD §10.1 states the same reasoning and freezes the same instance; this is
   that instance, constructed.

   No idle is injected before this frame's own D(0) -- this schedule uses no
   injection mechanism at all, only [Arrival.create] directly, exactly as
   case 0 does -- so [idle_counts] below is [ [ 0 ] ], the same construction
   argument case 0's own comment makes for its own single frame. *)
let build_c1 () =
  let octets = Dv_xgmii.Frame.stress_frame ~sequence:0 () in
  let sched = Dv_xgmii.Arrival.create ~first_start:4 [ octets ] in
  check_conformant ~case_label:"C1" sched
;;

let c1_meta : case_meta =
  { id = "C1"
  ; describe =
      "WO-0078 §6.2 C1 (CD §10.1) -- lane-4 start on cycle 0, otherwise case 0's frame; \
       sighted placement preserved"
  ; idle_counts = [ 0 ]
  }
;;

(* WO-0078 §6.2 C2 (CD §10.2) -- "two clean frames, minimum IFG, frame 0 at
   ~first_start:0." Two [Frame.stress_frame] calls, [~sequence:0] and
   [~sequence:1] -- two DISTINCT frames rather than one repeated, the same
   idiom already landed at [test/xgmii/test_tx_decoder.ml:215]
   ([Arrival.create ~ifg:8 [ Frame.stress_frame ~sequence:0 (); Frame.stress_frame
   ~sequence:1 () ]]), not a pattern invented here -- passed to
   [Arrival.create] as a two-entry frame list, exactly the affordance FI-2
   names ("[create] takes an [int list list] -- a frame LIST -- so a second
   clean frame needs no new machinery").

   [~ifg:12] is passed EXPLICITLY rather than left to [Arrival.create]'s own
   default (which is also 12) -- CD §10.2's instance is stated in terms of
   "the minimum inter-frame gap of requirements.md §0.3: 12 octets", and
   writing the figure into this call ties the constant to that spec citation
   directly in the source, rather than resting on a library default a later
   reader would have to go read [arrival.mli] to recover. It is not a
   behavioural change from case 0's own style (which leaves [?ifg] implicit)
   -- both resolve to 12 -- only a documentation choice for the one case
   whose entire subject is that figure.

   [~first_start:0] on frame 0 preserves the sighted placement for frame 0,
   per CD §10.2's own instance ("the sighted placement preserved for frame
   0"). WO-0078 §4.2 item 2's multiple-of-4 preservation applies to frame 0
   only, by construction: [Arrival.create] places every later frame from the
   gap arithmetic in [arrival.mli]'s own header, not from a second
   [~first_start], so there is exactly one placement decision made here, not
   two -- frame 1's own start lane (lane 4, a consequence of the 84-octet
   spacing not dividing 8, CD §10.2's own recorded consequence) falls out of
   that arithmetic rather than being chosen.

   Needs NO accumulator change (WO-0078 §2.2's own finding, restated in this
   packet's own dispatch): both refusal guards this lane's two producers
   carry (FI-4, FI-6) fire only on a second start character arriving WHILE A
   FRAME IS OPEN, and this schedule's second frame starts only after
   [Arrival.create]'s own gap arithmetic has closed the first -- confirmed by
   construction here (this builder calls nothing but [Arrival.create] and
   [Frame.stress_frame], exactly as case 0 and C1 do), not merely asserted.

   Neither frame has an idle injected before its own D(0) -- no injection
   mechanism is used here either -- so [idle_counts] is [ [ 0; 0 ] ], one
   entry per admitted frame in admission order (WO-0078 §5.2's own ordering
   rule), both zero for the same reason case 0's and C1's single entries
   are. *)
let build_c2 () =
  let octets0 = Dv_xgmii.Frame.stress_frame ~sequence:0 () in
  let octets1 = Dv_xgmii.Frame.stress_frame ~sequence:1 () in
  let sched = Dv_xgmii.Arrival.create ~ifg:12 ~first_start:0 [ octets0; octets1 ] in
  check_conformant ~case_label:"C2" sched
;;

let c2_meta : case_meta =
  { id = "C2"
  ; describe =
      "WO-0078 §6.2 C2 (CD §10.2) -- two clean frames, minimum IFG, frame 0 at lane-0 start \
       on cycle 0; sighted placement preserved for frame 0"
  ; idle_counts = [ 0; 0 ]
  }
;;

(* WO-0078 §6.2 C3 (CD §10.3) -- "one 64-octet frame, bad FCS -- `~fcs_valid:false`
   plus a corrupted octet"; lane-0 start on cycle 0, sighted placement
   preserved. CD §6 names this V7, "the one to watch": REQ-005 forbids
   store-and-forward, so our side, by spec, forwards the frame in full with
   tuser[0] = 1 on tlast (CD §10.3's own frozen instance, §9 row 1, REQ-104)
   -- while the reference may DROP it (CD §6: "the commonest store-and-forward
   instinct"), the predicted branch-gamma divergence WO-0078 §7's C3 row
   names, whose expected resolution -- if the prediction fails -- is a
   REQ-901 spec diff adding a class, never a `BUG-` (WO-0078 §7; CD §10.3's
   closing paragraph). This builder constructs the STIMULUS that prediction
   is read against; it asserts nothing about what either producer does with
   it -- that is `compare.ml`'s job, untouched this round.

   Same base content as case 0/C1/C2 -- [Frame.stress_frame ~sequence:0 ()]
   -- corrupted by ONE bit flip AFTER the correct FCS is appended, reusing
   the identical technique test/xgmii_rx_64/test_m03_d.ml's family D already
   established and had reviewed for this exact shape (a 64-octet frame, bad
   FCS, otherwise clean, WO-0040 §6's M03-D1): bit 0 of the octet at index
   20, inside the payload (stress_frame's filler region, offsets 18-59), so
   DA, SA, ethertype and the sequence number are all untouched and only the
   one corrupted octet and the now-wrong FCS distinguish this frame from
   case 0's own. WO-0040 §3.2's "both directions" residue check is asserted
   here BY HAND, for the reason test_m03_d.ml's own header states:
   [Arrival.create]'s own [check] verifies the REQ-304 residue only when
   [fcs_valid] is set, and this case sets it [false] ON PURPOSE (it IS a
   bad-FCS frame) -- so nothing else in this generator would ever catch a
   corruption that silently failed to land, or a base frame whose own FCS
   was wrong for an unrelated reason. *)
let flip_bit0_at ~idx octets =
  List.mapi (fun i v -> if i = idx then v lxor 1 else v) octets
;;

let build_c3 () =
  let good = Dv_xgmii.Frame.stress_frame ~sequence:0 () in
  if not (Dv_xgmii.Frame.residue_ok good)
  then failwith "stimulus_gen: case C3's base 64-octet frame's own FCS does not check out";
  let bad = flip_bit0_at ~idx:20 good in
  if Dv_xgmii.Frame.residue_ok bad
  then failwith "stimulus_gen: case C3's bit flip did not change the frame's FCS residue";
  let sched = Dv_xgmii.Arrival.create ~first_start:0 ~fcs_valid:false [ bad ] in
  check_conformant ~case_label:"C3" sched
;;

let c3_meta : case_meta =
  { id = "C3"
  ; describe =
      "WO-0078 §6.2 C3 (CD §10.3) -- one 64-octet frame, bad FCS (~fcs_valid:false plus a \
       corrupted octet), lane-0 start on cycle 0; sighted placement preserved; predicted \
       branch-gamma divergence, WO-0078 §7"
  ; idle_counts = [ 0 ]
  }
;;

(* WO-0078 §6.2 C4 (CD §10.4) -- "one 64-octet good-FCS frame whose six
   preamble filler octets and SFD octet carry arbitrary nonstandard data
   values, otherwise clean; lane-0 start on cycle 0."

   Construction authorised by AMENDMENT WO-0078-A1 (RV-C4GAP §3/§4), after
   RV-C4GAP found the hook this case needs was landed one directory over
   from where C4's own dispatch looked: [test/xgmii_rx_64/test_m03_b.ml]
   (M03-B1, ASSERT, REQ-102, AP-xgmii_rx_64.md family B), which builds this
   exact stimulus for the receiver bench, reviewed and mutation-scored.
   RV-C4GAP §3 considered and REFUSED two other paths -- extending
   [Arrival.create] with a [?preamble] parameter (capability creep against
   a landed mechanism, fourteen consumers of blast radius bought for
   nothing) and hand-splicing [Xgmii_word.of_lanes] with a re-derived
   [preamble_octets] constant (a second copy of a geometry that can drift
   silently) -- and AUTHORISED a third: the M03-B1 idiom's SECOND INSTANCE,
   confined to this file, reading the geometry through [Arrival]'s own
   public contract rather than around it. What follows is that instance.

   The schedule is case 0's own: [Frame.stress_frame ~sequence:0 ()],
   [Arrival.create ~first_start:0 [ octets ]], [?fcs_valid] and [?ifg] left
   at their defaults (true, 12), [check_conformant ~case_label:"C4"] -- the
   same three lines C1 and C3 use. The only thing that differs from case 0
   anywhere in this case is seven preamble octets in the WORD STREAM
   WRITTEN OUT, never in the schedule [Arrival] itself computes or checks:
   [check_conformant] still runs REQ-304's residue check over C4's frame,
   meaningfully, because [fcs_valid] defaults true and the override below
   never touches a frame octet.

   No [Injection] or [Idle_injection] anywhere in this builder's call
   graph -- only [Frame.stress_frame], [Arrival.create], [check_conformant]
   -- the same construction argument case 0/C1/C3's own comments make, so
   [idle_counts] below is [ [ 0 ] ]: one admitted frame, [~first_start:0],
   no room before its own D(0) for an injected idle. *)
let build_c4 () =
  let octets = Dv_xgmii.Frame.stress_frame ~sequence:0 () in
  let sched = Dv_xgmii.Arrival.create ~first_start:0 [ octets ] in
  check_conformant ~case_label:"C4" sched
;;

(* The override values -- FROZEN at RV-C4GAP §4 before any C4 stimulus
   existed. [0xA0 lor d] for [d] = 1..7, i.e. A1 A2 A3 A4 A5 A6 A7, the SFD
   position (d = 7) carrying 0xA7. Two derivations, both required by
   AMENDMENT WO-0078-A1 §4 item 4:
   - Nonstandard, from SPEC-M03 §6.1's own table: the table writes 0x55 at
     the six filler positions and 0xD5 at the SFD ([arrival.ml]'s own
     [lane_at] emits exactly those two values at an unoverridden preamble
     lane). Every one of these seven values differs from what the table
     writes at its own position, and 0xA7 <> 0xD5 is the octet this case is
     actually about.
   - Provenance, from [test_m03_b.ml:28]: [nonstandard_preamble_octet lane
     = 0xA0 + lane], which at a lane-0 start (this case's start lane) is
     [0xA0 lor d]. C4 drives the IDENTICAL nonstandard pattern as the
     landed M03-B1 bench, so the two instruments differ in the design under
     test and not in the stimulus -- which is what makes a divergence
     between them attributable to the design rather than to two different
     stimuli that merely resemble each other.
   Not from the reference: no line of [test/third_party/verilog-ethernet/**]
   was read to choose these, and none may be (REQ-901's closing sentence
   applies to a stimulus value exactly as it applies to an expected one). *)
let c4_nonstandard_octet d = 0xA0 lor d

(* The per-case word function for C4 (AMENDMENT WO-0078-A1 §4 items 2/3/5).

   Geometry: read from [Arrival.in_times frame] -- the public contract
   (arrival.mli: "Octet times of every octet of the frame at M03's input,
   in wire order: the eight preamble octets from the start character
   inclusive...") -- never re-derived. Entry 0 is the start character and
   is left alone; entries 1 through 7 are the six filler octets and the
   SFD, at octet times [in_times.(1) .. in_times.(7)]. No literal 8 is
   copied and no lane arithmetic is re-invented: this reaches THROUGH
   [Arrival]'s public contract, not around it, exactly as RV-C4GAP §3
   requires.

   REQ-102's length tripwire (mandatory, a [failwith] naming REQ-102, not
   an [assert]): checked before the first eight entries of [in_times] are
   used. If [Arrival]'s preamble ever moved off eight octets, this case
   fails at construction with a message naming REQ-102, instead of
   silently overriding the wrong octets.

   The departure check (RV-C4GAP §3's third distinguishing property; not
   merely trusted by construction, the way M03-B1's own override -- which
   has its own receiver assertions to catch a misplacement -- can afford to
   be): before anything is written, the overridden word stream is compared
   against [Arrival.word_at sched] over the schedule's full written span,
   and it must show exactly seven differing octet positions, at exactly
   the seven octet times [in_times] names, the [control] field
   bit-identical to the unmodified schedule on every cycle, and the start
   character still intact at lane 0 of the start cycle. C4 has no receiver
   assertions of its own to catch a misplacement -- its whole output is a
   comparison between two implementations that would happily agree about
   the wrong stimulus -- so this check is what stands in their place. *)
let c4_word_at sched =
  let frame = (Dv_xgmii.Arrival.frames sched).(0) in
  let times = Dv_xgmii.Arrival.in_times frame in
  if Array.length times <> 8 + Array.length frame.Dv_xgmii.Arrival.octets
  then
    failwith
      "stimulus_gen: case C4 -- Arrival.in_times does not publish REQ-102's eight-octet \
       preamble; refusing rather than overriding the wrong octets";
  let overrides =
    List.init 7 (fun k ->
      let d = k + 1 in
      times.(d), c4_nonstandard_octet d)
  in
  let base_word = Dv_xgmii.Arrival.word_at sched in
  let override_at ~cycle =
    let word = base_word ~cycle in
    let word_start = cycle * 8 in
    { Dv_xgmii.Xgmii_word.data =
        Array.init 8 (fun lane ->
          match List.assoc_opt (word_start + lane) overrides with
          | Some v -> v
          | None -> word.Dv_xgmii.Xgmii_word.data.(lane))
    ; control = word.Dv_xgmii.Xgmii_word.control
    }
  in
  let total = Dv_xgmii.Arrival.cycles sched + drain_cycles in
  let diff_positions = ref [] in
  for cycle = 0 to total - 1 do
    let orig = base_word ~cycle in
    let ovr = override_at ~cycle in
    if ovr.Dv_xgmii.Xgmii_word.control <> orig.Dv_xgmii.Xgmii_word.control
    then
      failwith
        (Printf.sprintf
           "stimulus_gen: case C4's departure check failed at cycle %d -- the control field \
            moved; the departure must be data-only"
           cycle);
    for lane = 0 to 7 do
      if ovr.Dv_xgmii.Xgmii_word.data.(lane) <> orig.Dv_xgmii.Xgmii_word.data.(lane)
      then diff_positions := ((cycle * 8) + lane) :: !diff_positions
    done
  done;
  let observed = List.sort compare !diff_positions in
  let expected = List.sort compare (List.map fst overrides) in
  if observed <> expected
  then
    failwith
      (Printf.sprintf
         "stimulus_gen: case C4's departure check failed -- expected exactly the seven octet \
          positions [%s] to differ from Arrival.word_at, observed [%s]"
         (String.concat "; " (List.map string_of_int expected))
         (String.concat "; " (List.map string_of_int observed)));
  let start_cycle = Dv_xgmii.Arrival.start_cycle frame in
  (match Dv_xgmii.Xgmii_word.start_lane (override_at ~cycle:start_cycle) with
   | Some 0 -> ()
   | _ ->
     failwith
       "stimulus_gen: case C4's departure check failed -- the start character is not intact \
        at lane 0 of the start cycle after the override");
  override_at
;;

let c4_meta : case_meta =
  { id = "C4"
  ; describe =
      "WO-0078 §6.2 C4 (CD §10.4) -- one 64-octet good-FCS frame, six nonstandard preamble \
       filler octets and SFD octet (0xA1..0xA7, the M03-B1 idiom's second instance per \
       test_m03_b.ml), lane-0 start on cycle 0; construction authorised by AMENDMENT \
       WO-0078-A1 (RV-C4GAP)"
  ; idle_counts = [ 0 ]
  }
;;

let known_cases = [ case0_meta; c1_meta; c2_meta; c3_meta; c4_meta ]

let find_case_meta id =
  match List.find_opt (fun c -> String.equal c.id id) known_cases with
  | Some c -> c
  | None ->
    failwith
      (Printf.sprintf
         "stimulus_gen: unknown case id %S (known: %s)"
         id
         (String.concat ", " (List.map (fun c -> c.id) known_cases)))
;;

(* Dispatches to the case's own schedule-builder, paired with that case's
   own word function (AMENDMENT WO-0078-A1 §4 item 2's seam). For 0, C1, C2
   and C3 the word function is [Dv_xgmii.Arrival.word_at sched] itself --
   unchanged from what [write_stimulus] called directly before this seam
   existed, so their bytes cannot move. C4 pairs its schedule with
   [c4_word_at sched], which departs from the raw schedule on exactly seven
   octet positions and checks that departure before returning (see
   [c4_word_at]'s own comment). Never called on an id [find_case_meta] has
   not already validated (see [main] below), so the final arm is
   unreachable in normal use and names that explicitly rather than
   silently returning a wrong schedule. *)
let build_case id =
  match id with
  | "0" ->
    let sched = build () in
    sched, Dv_xgmii.Arrival.word_at sched
  | "C1" ->
    let sched = build_c1 () in
    sched, Dv_xgmii.Arrival.word_at sched
  | "C2" ->
    let sched = build_c2 () in
    sched, Dv_xgmii.Arrival.word_at sched
  | "C3" ->
    let sched = build_c3 () in
    sched, Dv_xgmii.Arrival.word_at sched
  | "C4" ->
    let sched = build_c4 () in
    sched, c4_word_at sched
  | _ ->
    failwith
      (Printf.sprintf
         "stimulus_gen: case %S is listed in known_cases but build_case has no rule for it \
          -- a bug in this file, not in the caller"
         id)
;;

(* WO-0078 §5.2: the idle-count sidecar this case's [idle_counts] authors,
   forwarded by [ours_run.ml] to [compare.ml] -- see ours_run.ml's own header
   note for the full three-file relay. One decimal integer per line, line
   order = frame admission order, matching [Canonical]'s own [F]-line
   ordering convention. *)
let write_idle_sidecar path idle_counts =
  let oc = open_out_bin path in
  Fun.protect
    ~finally:(fun () -> close_out_noerr oc)
    (fun () -> List.iter (fun n -> Printf.fprintf oc "%d\n" n) idle_counts)
;;

let () =
  (* WO-0078 §6.1's landing-order constraint, honoured here rather than
     merely stated: [tools/cosim/run_cosim.sh] (not this packet's to touch
     in Stage 1) invokes this binary with exactly ONE positional argument
     today, the output path -- that call keeps working unchanged, defaulting
     to case 0, for exactly as long as data_wrangler's own round has not yet
     landed a case argument. The case id is therefore the SECOND, optional,
     argument, never the first. *)
  let output_path, case_id =
    match Sys.argv with
    | [| _ |] -> "stimulus.txt", "0"
    | [| _; p |] -> p, "0"
    | [| _; p; c |] -> p, c
    | _ -> failwith "usage: stimulus_gen [output_path] [case_id]"
  in
  let meta = find_case_meta case_id in
  let sched, word_at = build_case case_id in
  write_stimulus output_path sched word_at;
  write_idle_sidecar (output_path ^ ".idle") meta.idle_counts
;;
