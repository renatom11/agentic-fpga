(* WO-0046 §2.1 — our-side co-simulation driver. Reads stimulus_gen.ml's
   stimulus.txt, drives Hardcaml_ethernet.Xgmii_rx_64 (M03) — REQ-901's
   parameter list maps to nothing here; SPEC-M03 §5 pins M03 at zero
   compile-time parameters, so there is nothing to set at instantiation
   (WO-0046 §6 question 1 names the same finding for the Verilog side) —
   and writes ours.canon in canonical.mli's pinned grammar.

   {2 Independence}

   This file elaborates M03 exactly as test/xgmii_rx_64/bench.ml does: through
   the published [Cyclesim.With_interface (Xgmii_rx_64.I) (Xgmii_rx_64.O)]
   entry point, reaching every port by field-name projection off the live
   [Cyclesim.inputs]/[outputs] records ([i.xgmii_rx.d], [o.rx.tvalid], …)
   rather than by naming or reading any concrete implementation.
   [libs/hardcaml_ethernet/src/] and [rtl_snapshots/**] were not opened to
   write this file (PROTOCOL §10). The [~clock_edge:Side.Before] sampling
   convention and the one-cycle [clear] pulse are carried from that same
   file's own reviewed and corrected reasoning (RV-0038-R6/BUG-0001: M03's
   [rx] stream and its strobes are combinational in the CURRENT XGMII word,
   SPEC-M03 §6.1's one-word lookahead, so [Before] is the view that reads a
   cycle's actual wire value; the default [After] view reads the state one
   edge later).

   {2 The accept-or-discard decision (WO-0046 §6 question 4)}

   REQ-901's [D] line is derived identically for both this driver and
   [tb_xgmii_rx_64.v]: a frame is admitted when its start character is
   recognised (REQ-101, lane 0 or lane 4) on the word about to be driven;
   an admitted frame is [Accept] iff a [tlast] word is observed for it before
   the stimulus (which already carries its own drain margin,
   stimulus_gen.ml) is exhausted, and [Discard] otherwise — the "no output
   word at all" case WO-0046 §2.3 and SPEC-M03 §9's zero-delivered rows both
   describe. This turned out to be a SYMMETRIC rule rather than one derived
   differently per side, because both M03 and the reference present an
   AXI-Stream-shaped [tvalid]/[tlast] output; see the Return log for the
   scope this does not cover (a second start character while a frame's
   ADMISSION span is still open — REQ-110's abort case — is out of Phase
   1's authorised stimulus, WO-0046 §9, and is deliberately not implemented:
   this file [failwith]s rather than guess at it, so a future phase that
   needs it is told to write it rather than silently mishandling it).

   {2 Two spans, tracked separately (WO-0078 §14, `FINDING RV-0078-S2-1`'s
   repair)}

   [accumulate] used to test ONE piece of state — [open_frame] — for BOTH
   the REQ-110 refusal (a second start character) and the orphan-output
   refusal (an output word with nothing admitted). That state's own span ran
   from the input start character to the OUTPUT [tlast], which at SPEC-M03
   §6.1's ΔC = 3 outlives the input frame's own terminate character by
   exactly the pipeline latency — so a lawful minimum-inter-frame-gap
   second frame (requirements.md §0.3's own minimum IFG) landed its start
   character on precisely the cycle the first frame's UNION span was still
   open, and was refused as if it were REQ-110's abort case, which it is
   not: on the INPUT side a full cycle separates the two frames and
   [Arrival.check] returns [[]] on the schedule that trips it (measured at
   `WO-0078` §14, `RV-C1C2` §4, against CD §10.2's frozen C2 instance).

   The repair is two spans, each tested by exactly one guard, derived from
   REQ-110's own condition and SPEC-M03 §6.1's ΔC, and from no RTL and no
   reference behaviour (REQ-901's closing sentence):

   - [admission_open]: true from the cycle a start character is recognised
     on the INPUT word to the cycle that SAME frame's own terminate
     character is recognised on the INPUT word (or forever, if the
     stimulus ends first). REQ-110's guard below tests ONLY this span —
     narrowed to REQ-110's own condition, not implementing abort handling,
     which stays out of Phase 1's authorised stimulus and is owed to a
     future co-sim Phase 3 (C9, `WO-0078` §6.3).
   - a FIFO of frames admitted but not yet closed by their OUTPUT [tlast],
     in admission order: an output word always attaches to the OLDEST
     not-yet-closed admitted frame, and [tlast] closes it. The
     orphan-output guard (FI-5) tests ONLY this FIFO's emptiness — never
     [admission_open], which may already be closed for the very frame
     still occupying the FIFO's head (its own admission span closed at its
     own [/T/], cycles before its last output word is delivered, at
     ΔC = 3).

   A second start character AFTER the first frame's own input terminate is
   therefore lawful (the FIFO carries the overlap); a second start
   character WHILE the first frame's admission span is still open —
   REQ-110's actual condition — still refuses, with the same message. Both
   producers implement this identically, from this text, never from each
   other's code and never from the reference's behaviour
   ([tb_xgmii_rx_64.v]'s own comment on its mirrored guard says so in
   terms). The two regression fixtures this repair owes — a passing
   minimum-IFG two-frame trace and a still-refusing genuine-REQ-110-shape
   trace — are [self_test] below, exercising [accumulate] directly rather
   than through any canonical file, since the guard fires (or does not)
   BEFORE either canonical file exists.

   {2 The idle-count sidecar (WO-0078 §5.2, FINDING RV-0075-2)}

   This file is the middle hop of a three-file relay: [stimulus_gen.ml]
   authors, per case, how many idle XGMII words its own schedule injected at
   or before each frame's first octet D(0) (only it knows this, by
   construction of the schedule); this file reads that record from
   [<stimulus_path>.idle] (absent for every case this packet's Stage 1
   ships, read as "0 for every frame") and forwards it, unchanged, to
   [<output_path>.idle]; [compare.ml] reads it from there and passes it to
   [Canonical.check_timing] as the antecedent FINDING RV-0075-2 requires be
   CARRIED rather than inferred from either canonical file's own cycles.
   This file performs no computation on the counts beyond a length
   cross-check against the number of frames it actually admitted — it does
   not, and structurally cannot, derive the count itself, since nothing
   about the DUT's own cycles reveals how many idle words the SCHEDULE
   chose to inject before a frame started. *)

open Hardcaml
module Xgmii_word = Dv_xgmii.Xgmii_word
module Stream_word = Dv_monitors.Stream_word
module Xgmii_probe = Dv_xgmii_probe.Xgmii_probe
module Axi64_probe = Dv_axi64_probe.Axi64_probe

module Sim =
  Cyclesim.With_interface (Hardcaml_ethernet.Xgmii_rx_64.I) (Hardcaml_ethernet.Xgmii_rx_64.O)

(* stimulus.txt: one line per cycle, "<16-hex xgmii_rxd> <2-hex xgmii_rxc>" —
   stimulus_gen.ml's format, not the pinned canonical form. *)
let read_stimulus path =
  let ic = open_in_bin path in
  let rec loop acc =
    match input_line ic with
    | line ->
      (match String.split_on_char ' ' line |> List.filter (fun s -> String.length s > 0) with
       | [ d_hex; c_hex ] ->
         let d = Int64.of_string ("0x" ^ d_hex) in
         let c = int_of_string ("0x" ^ c_hex) in
         loop (Xgmii_word.of_wire d c :: acc)
       | _ -> failwith (Printf.sprintf "ours_run: malformed stimulus line %S" line))
    | exception End_of_file -> List.rev acc
  in
  let words = loop [] in
  close_in ic;
  words
;;

(* WO-0078 §5.2 / FINDING RV-0075-2: [<stimulus_path>.idle], read here if
   present -- [stimulus_gen.ml]'s own per-case record of how many idle
   XGMII words its schedule injected at or before each frame's first octet
   D(0), one decimal integer per line, line order = frame ADMISSION order
   (0-based) -- the same order this file's own [accumulate] discovers
   frames in, since both walk the identical stimulus in the identical
   direction. Absent for every case this packet's Stage 1 ships (including
   case 0): [None] then, read by [run] below as "0 for every frame",
   unchanged from before this sidecar existed. *)
let read_idle_sidecar path =
  if not (Sys.file_exists path)
  then None
  else (
    let ic = open_in_bin path in
    let rec loop acc =
      match input_line ic with
      | line -> loop (int_of_string (String.trim line) :: acc)
      | exception End_of_file -> List.rev acc
    in
    let counts = loop [] in
    close_in ic;
    Some counts)
;;

(* Forwards [idle_counts] (one per frame, admission order) to
   [<output_path>.idle], for [compare.ml] to pick up as [check_timing]'s
   carried antecedent -- the second hop of the same relay ([stimulus_gen.ml]
   authors it; this file only forwards what it read, or an all-zero default
   it manufactures itself when nothing was to forward, never inventing a
   nonzero value on its own account). *)
let write_idle_sidecar path idle_counts =
  let oc = open_out_bin path in
  Fun.protect
    ~finally:(fun () -> close_out_noerr oc)
    (fun () -> List.iter (fun n -> Printf.fprintf oc "%d\n" n) idle_counts)
;;

(* [cycle] (WO-0075 §2): the shared time base's (§3.0) index of the
   stimulus line whose driving produced this word -- the SAME [line_index]
   [accumulate] below is folding over, passed in by its one caller rather
   than re-derived here. *)
let word_of_stream_word ~cycle (w : Stream_word.t) : Canonical.word =
  { Canonical.tkeep = w.tkeep
  ; tlast = w.tlast
  ; tuser0 = w.tuser land 1 = 1
  ; cycle
  ; octets = Stream_word.octets w
  }
;;

(* WO-0078 §14, `FINDING RV-0078-S2-1`'s successor rule: the admission
   span's own closing condition -- a terminate character anywhere in the
   INPUT word currently being driven, scanned across all eight lanes
   exactly as [Xgmii_word.start_lane] scans for the start character (same
   shape, different target character), never derived from the DUT's own
   output. Only one frame's admission span can be open at a time (the
   guard below enforces it), so any terminate character seen while one is
   open belongs to that frame by construction; a terminate character with
   no admission span open is a no-op, since conformant idle/gap traffic
   never carries one. *)
let has_terminate (w : Xgmii_word.t) =
  let rec find k =
    k < 8 && (Xgmii_word.lane w k = Xgmii_word.Control Xgmii_word.terminate_char || find (k + 1))
  in
  find 0
;;

(* The bookkeeping half of WO-0046 §6 question 4, pulled out of the Cyclesim
   driving loop below so it is a plain function over [Xgmii_word.t] and
   [Stream_word.t] -- neither of which carries a Hardcaml dependency -- and
   is therefore exercisable on a hand-built trace with no DUT, no simulator
   and no elaboration, same as every DUT-independent model in dv_xgmii and
   dv_monitors. [trace] is one entry per driven cycle, in order: the
   stimulus line's own 0-based index (WO-0075 §3.0's shared time base --
   carried here from [run]'s [List.mapi] below rather than re-derived, so
   this stays "a third component ... your call", WO-0075 §5.2), the input
   word driven that cycle, and the DUT's own [rx] stream reading for that
   SAME cycle (the [~clock_edge:Side.Before] view [run] samples below).
   [tb_xgmii_rx_64.v] implements the identical algorithm independently in
   Verilog, over its own per-cycle input/output/line-index triple
   ([stimulus_lines - 1]).

   WO-0078 §14, `FINDING RV-0078-S2-1`: two spans, tracked separately (see
   this file's own header comment for the full derivation).
   [admission_open] is REQ-110's guard's own state, closed at THIS frame's
   own input terminate character, never at its output [tlast].
   [delivery_queue] is a FIFO, admission order, of frames admitted but not
   yet closed by their OUTPUT [tlast] -- the orphan-output guard (FI-5)
   tests ONLY its emptiness, and an output word always attaches to its
   head (the oldest not-yet-closed frame). *)
let accumulate (trace : (int * Xgmii_word.t * Stream_word.t) list) : Canonical.transaction =
  let frames_rev = ref [] in
  let next_index = ref 0 in
  let admission_open = ref false in
  (* FIFO, admission order: (frame-index, admit_cycle, words-so-far in
     reverse), oldest at the head (list front). *)
  let delivery_queue = ref [] in
  let close_head ~decision =
    match !delivery_queue with
    | [] -> ()
    | (index, admit_cycle, words_rev) :: rest ->
      frames_rev
      := { Canonical.index; admit_cycle; decision; words = List.rev words_rev }
         :: !frames_rev;
      delivery_queue := rest
  in
  List.iter
    (fun (line_index, word, out) ->
       (* Admission side: REQ-110's guard, testing ONLY [admission_open] --
          narrowed to the ADMISSION span, never the delivery FIFO. *)
       (match Xgmii_word.start_lane word with
        | Some (0 | 4) ->
          if !admission_open
          then
            failwith
              "ours_run: a second start character arrived while a frame's \
               admission span was open \
               -- REQ-110 abort handling is out of Phase 1's authorised stimulus \
               (WO-0046 section 9)"
          else (
            (* WO-0075 §2: [admit_cycle] is recorded at the exact point
               [Xgmii_word.start_lane] recognises the start character --
               this SAME [line_index], the stimulus line carrying it. *)
            admission_open := true;
            delivery_queue := !delivery_queue @ [ !next_index, line_index, [] ];
            next_index := !next_index + 1)
        | Some _ | None -> ());
       (* The admission span's own closing condition -- THIS SAME input
          word's terminate character (WO-0078 §14, `FINDING RV-0078-S2-1`).
          Checked after the start-character arm, mirroring that arm's own
          fold order (the start check runs before the output word is
          attached, this file's own established convention); under
          requirements.md §0.3's minimum IFG (12 octets, more than one
          8-lane word) a terminate character and a later start character
          can never land in the same word for conformant stimulus, so this
          ordering is never actually exercised both ways at once. *)
       if !admission_open && has_terminate word then admission_open := false;
       (* Delivery side: FI-5's guard, testing ONLY [delivery_queue]'s
          emptiness -- unchanged in meaning from before this repair. *)
       if out.Stream_word.tvalid
       then (
         match !delivery_queue with
         | [] -> failwith "ours_run: M03 produced an output word with no admitted frame open"
         | (index, admit_cycle, words_rev) :: rest ->
           delivery_queue
           := (index, admit_cycle, word_of_stream_word ~cycle:line_index out :: words_rev)
              :: rest;
           if out.tlast then close_head ~decision:Canonical.Accept))
    trace;
  (* End of trace (which already includes Phase 1's drain margin,
     stimulus_gen.ml): any frame(s) still in the delivery FIFO were
     admitted but never produced a [tlast] word -- REQ-901's discard case,
     closed oldest first (FIFO order), which is admission order. *)
  let rec drain () =
    if !delivery_queue <> []
    then (
      close_head ~decision:Canonical.Discard;
      drain ())
  in
  drain ();
  List.rev !frames_rev
;;

(* WO-0078 §14, `FINDING RV-0078-S2-1` §4 item 5: the fixture PAIR the
   repair owes, run directly against [accumulate] -- the exact function the
   finding convicts -- never against a canonical file, since the guard
   fires (or does not) BEFORE either canonical file exists. Every word
   below is built through [Xgmii_word.of_lanes]/[Stream_word.of_octets] and
   [Stream_word.idle], none of which carries a Hardcaml dependency (both
   modules' own header comments), so this mode needs no DUT, no simulator
   and no [Cyclesim.create] -- runnable with the bare system [ocamlc],
   exactly as [compare.ml --self-test] is. Content (octets, tuser) is
   arbitrary, as it is for every fixture in that self-test (its own
   [sample_transaction] comment: "this is a comparator self-test, not a
   co-simulation vector") -- this proves the ADMISSION/DELIVERY
   bookkeeping, never a REQ-901 observable. *)

let self_test_start_word lane =
  Xgmii_word.of_lanes
    (List.init 8 (fun k ->
       if k = lane
       then Xgmii_word.Control Xgmii_word.start_char
       else Xgmii_word.Control Xgmii_word.idle_char))
;;

let self_test_terminate_word lane =
  Xgmii_word.of_lanes
    (List.init 8 (fun k ->
       if k = lane
       then Xgmii_word.Control Xgmii_word.terminate_char
       else Xgmii_word.Control Xgmii_word.idle_char))
;;

let self_test_idle_out = Stream_word.idle ()
let self_test_tlast_out octets = Stream_word.of_octets ~tlast:true octets

(* (i) — the minimum-IFG two-frame shape `RV-0078-S2-1` names: frame 0's
   OWN input terminate character (line 1) closes its admission span BEFORE
   frame 1's start character (line 3); frame 0's own OUTPUT [tlast] is not
   delivered until line 3 -- the SAME line frame 1's start character is
   driven, the exact one-cycle union-span overlap the finding measured at
   C2. Under the repaired rule this is lawful: [admission_open] tests only
   the INPUT side and is already false by line 3, and the delivery FIFO
   attaches line 3's output word to frame 0 (its head) before frame 1 is
   ever pushed onto it in the same iteration. Must NOT raise; must produce
   two [Accept] frames. *)
let min_ifg_two_frame_trace =
  [ 0, self_test_start_word 0, self_test_idle_out
  ; 1, self_test_terminate_word 0, self_test_idle_out
  ; 2, Xgmii_word.idle, self_test_idle_out
  ; 3, self_test_start_word 4, self_test_tlast_out [ 0; 1; 2; 3; 4; 5; 6; 7 ]
  ; 4, self_test_terminate_word 4, self_test_idle_out
  ; 5, Xgmii_word.idle, self_test_tlast_out [ 8; 9; 10; 11; 12; 13; 14; 15 ]
  ]
;;

(* (ii) — the genuine REQ-110 abort shape: a second start character while
   frame 0's admission span is STILL OPEN (no terminate character has been
   seen on the input side at all). Must still refuse, with the same guard
   and the same reason, under the repaired rule -- the negative control
   without which the narrowing in (i) would be unfalsifiable in the
   direction that matters (`RV-C1C2` §4 item 5's own words). *)
let req110_abort_trace =
  [ 0, self_test_start_word 0, self_test_idle_out
  ; 1, self_test_start_word 0, self_test_idle_out
  ]
;;

let self_test_check ~title ~pass ~detail =
  Printf.printf "ours_run --self-test: %s\n" title;
  Printf.printf "  %s: %s\n" (if pass then "PASS" else "FAIL") detail;
  pass
;;

let self_test () =
  let ok1 =
    match accumulate min_ifg_two_frame_trace with
    | [ { Canonical.index = 0; decision = Canonical.Accept; _ }
      ; { Canonical.index = 1; decision = Canonical.Accept; _ }
      ] ->
      self_test_check
        ~title:
          "(FINDING RV-0078-S2-1, i) minimum-IFG two frames -- second start AFTER \
           frame 0's own input terminate"
        ~pass:true
        ~detail:
          "accumulate did not raise; both frames closed Accept -- a lawful \
           minimum-IFG schedule is admitted, and the FIFO correctly attributes the \
           overlapping output word to frame 0"
    | frames ->
      self_test_check
        ~title:
          "(FINDING RV-0078-S2-1, i) minimum-IFG two frames -- second start AFTER \
           frame 0's own input terminate"
        ~pass:false
        ~detail:
          (Printf.sprintf
             "accumulate did not raise, but produced %d frame(s) instead of two Accepts \
              -- the delivery FIFO mis-attributed the overlapping output word"
             (List.length frames))
    | exception Failure msg ->
      self_test_check
        ~title:
          "(FINDING RV-0078-S2-1, i) minimum-IFG two frames -- second start AFTER \
           frame 0's own input terminate"
        ~pass:false
        ~detail:
          (Printf.sprintf
             "accumulate raised %S -- a lawful minimum-IFG schedule must NOT refuse \
              (this IS the finding's own defect, unrepaired)"
             msg)
  in
  let ok2 =
    match accumulate req110_abort_trace with
    | _ ->
      self_test_check
        ~title:
          "(FINDING RV-0078-S2-1, ii) genuine REQ-110 abort -- second start WHILE \
           frame 0's admission span is open"
        ~pass:false
        ~detail:
          "accumulate did NOT raise -- a second start character while frame 0's \
           admission span was open must still refuse (the negative control: the \
           narrowing must not have deleted the guard)"
    | exception Failure msg ->
      let needle = "admission span was open" in
      let contains =
        let n = String.length msg
        and m = String.length needle in
        let rec find i = i + m <= n && (String.sub msg i m = needle || find (i + 1)) in
        find 0
      in
      self_test_check
        ~title:
          "(FINDING RV-0078-S2-1, ii) genuine REQ-110 abort -- second start WHILE \
           frame 0's admission span is open"
        ~pass:contains
        ~detail:(Printf.sprintf "accumulate raised %S" msg)
  in
  if ok1 && ok2
  then (
    Printf.printf "ours_run --self-test: OK\n";
    0)
  else (
    Printf.printf "ours_run --self-test: FAILED\n";
    1)
;;

let run ~stimulus_path ~output_path =
  let stimulus = read_stimulus stimulus_path in
  let scope = Scope.create ~flatten_design:true () in
  let sim = Sim.create (Hardcaml_ethernet.Xgmii_rx_64.create scope) in
  let i = Cyclesim.inputs sim in
  (* REQ-009: one clear cycle, matching test/xgmii_rx_64/bench.ml's own
     convention; cfg_rx_enable held at 1 for the whole run (Phase 1 drives no
     REQ-810 case, WO-0046 §9). *)
  Xgmii_probe.to_refs ~d:i.xgmii_rx.d ~c:i.xgmii_rx.c Xgmii_word.idle;
  i.clear := Bits.vdd;
  i.cfg_rx_enable := Bits.vdd;
  Cyclesim.cycle sim;
  i.clear := Bits.gnd;
  let trace =
    (* WO-0075 §2/§3.0: [List.mapi] rather than [List.map] -- the ONLY change
       this WO makes to this loop -- so each entry carries the 0-based
       stimulus-line index of the word it drives, the shared time base both
       producers now write into the pinned grammar. Sampling itself
       (convention and order below) is untouched (WO-0075 §8 item 2). *)
    List.mapi
      (fun idx word ->
         (* RV-0038-R6/R6-1's [Before] convention (this file's own header
            comment): obtain the ref before driving the next word and
            stepping the clock, dereference it (inside [Axi64_probe.of_refs])
            only after -- the same order test/xgmii_rx_64/bench.ml's
            [sample_cycle] uses. *)
         let o_before = Cyclesim.outputs ~clock_edge:Side.Before sim in
         Xgmii_probe.to_refs ~d:i.xgmii_rx.d ~c:i.xgmii_rx.c word;
         Cyclesim.cycle sim;
         let out =
           Axi64_probe.of_refs
             ~tvalid:o_before.rx.tvalid
             ~tdata:o_before.rx.tdata
             ~tkeep:o_before.rx.tkeep
             ~tstrb:o_before.rx.tstrb
             ~tlast:o_before.rx.tlast
             ~tuser:o_before.rx.tuser
             ()
         in
         idx, word, out)
      stimulus
  in
  let transaction = accumulate trace in
  Canonical.write_file output_path transaction;
  (* WO-0078 §5.2 / FINDING RV-0075-2: forward the idle-count sidecar,
     frame for frame. [frame_count] is EVERY frame [accumulate] recorded
     (Accept or Discard alike, admission order) -- the same count
     [stimulus_gen.ml]'s sidecar was written against, since both walk the
     identical stimulus. A sidecar present but of the WRONG length is a NEW
     harness-defect refusal (WO-0078 §2.3's census is about producer
     refusals reaching a distinct non-zero code; this extends that census
     by one entry this file itself introduces, flagged as such in the
     Return log rather than silently folded into the original six) --
     `failwith`, exactly like this file's existing refusals, rather than
     silently truncating or padding a count that no longer corresponds to
     the frames actually admitted. *)
  let frame_count = List.length transaction in
  let idle_counts =
    match read_idle_sidecar (stimulus_path ^ ".idle") with
    | None -> List.init frame_count (fun _ -> 0)
    | Some counts ->
      if List.length counts <> frame_count
      then
        failwith
          (Printf.sprintf
             "ours_run: stimulus idle sidecar %s declares %d frame(s) but %d were admitted \
              -- the sidecar and the stimulus it accompanies have drifted apart"
             (stimulus_path ^ ".idle")
             (List.length counts)
             frame_count);
      counts
  in
  write_idle_sidecar (output_path ^ ".idle") idle_counts
;;

let () =
  match Sys.argv with
  (* WO-0078 §14, `FINDING RV-0078-S2-1` §4 item 5: [self_test] needs no
     Hardcaml toolchain and elaborates no DUT (it calls [accumulate]
     directly on a hand-built trace), so it is dispatched BEFORE [run] --
     which does need both -- rather than folded into [run]'s own argument
     handling. Mirrors [compare.ml --self-test]'s own CLI convention. *)
  | [| _; "--self-test" |] -> exit (self_test ())
  | _ ->
    let stimulus_path, output_path =
      match Sys.argv with
      | [| _ |] -> "stimulus.txt", "ours.canon"
      | [| _; s |] -> s, "ours.canon"
      | [| _; s; o |] -> s, o
      | _ ->
        prerr_endline "usage: ours_run [stimulus.txt] [ours.canon] | ours_run --self-test";
        exit 2
    in
    run ~stimulus_path ~output_path
;;
