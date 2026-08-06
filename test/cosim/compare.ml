(* WO-0046 §2.1/§4 — the comparator. A thin CLI wrapper around
   [Canonical]'s domain comparison; all REQ-901 logic lives there, not here,
   so that [--self-test] (below) exercises the identical code path as the
   production comparison rather than a second, hand-rolled one.

   Usage:
     compare <ours.canon> <theirs.canon>   REQ-901's comparison, PLUS
                                            WO-0075 §3's three timing tiers
                                            (T0/T1/T2, run after REQ-901's
                                            comparison and printed after its
                                            report); prints both reports;
                                            exit code below.
     compare --self-test                   WO-0046 §4.2's deliberate-mismatch
                                            check, WO-0049 §5.4's
                                            malformed-canonical-file check,
                                            WO-0075 §7's timing-tier cases,
                                            WO-0078 §5.4/§2.3's rebuilt and
                                            added cases, and the WO-0078
                                            Stage-1-repair round's two
                                            further cases (`FINDING
                                            RV-0078-S1-1`'s regression fixture,
                                            `FINDING RV-0078-S1-2` limb (b)'s
                                            two-frame case), and the C2-repair
                                            round's `FINDING RV-0078-S2-8`
                                            golden-file fixture (the reference
                                            writer's own intended two-frame
                                            buffered output, hand-authored),
                                            all through this same production
                                            path (below).

   [<ours.canon>.idle] (WO-0078 §5.2, FINDING RV-0075-2, read if present, an
   optional SIDECAR never part of the pinned canonical grammar): one decimal
   integer per line, frame index implied by line order, the count of idle
   XGMII words the STIMULUS recorded as injected at or before that frame's
   D(0) -- forwarded here from [stimulus_gen.ml] via [ours_run.ml], never
   derived from either canonical file's own cycles (that is exactly what the
   finding rules out). Absent for every case this packet's Stage 1 ships
   (including case 0): every frame then reads as carrying 0, unchanged from
   before this sidecar existed.

   Exit codes (WO-0078 §5.3 pins 6; WO-0075 §6 pinned 4 and 5; 0-3 are
   WO-0046/WO-0049's, unchanged):
     0  clean: REQ-901's comparison agrees, T0 aligned, T1 met (or withheld
        because the frame it would cover was not accepted -- T1 has nothing
        to say about a Discard).
     1  REQ-901's comparison found a divergence. Content wins over timing:
        this is returned whatever T0/T1 found, and both reports still print
        in full so nothing is hidden (WO-0075 §6's precedence).
     2  usage error.
     3  EITHER canonical file could not be read at all -- a grammar violation
        ([Canonical.read]'s own [Failure]) or an I/O failure opening it
        ([Sys_error]). Exit 3 means no verdict was reached and must never be
        read as "clean" or as "divergence" (WO-0049 §5). An old-format file
        predating WO-0075's [admit_cycle]/[cycle] fields lands here too
        (canonical.mli's own decimal-grammar contract), and so does a
        reference-side producer refusal (WO-0078 §2.3, FINDING WO-0078-1: the
        [E] sentinel record [tb_xgmii_rx_64.v] now writes before a
        guard-triggered [$finish]) -- never as a silent 0 or a false 1.
     4  T1 reached a verdict and it was negative: our own side's output
        landed on a cycle other than the one SPEC-M03 §6.1 pins for it, on a
        stimulus whose content both sides agree on. **This is a defect
        against OUR spec (REQ-005/REQ-111), never a disagreement with the
        MIT reference** -- WO-0075 §3.2's own distinction, restated here
        because it decides how the failure is triaged, not just how it is
        printed. Never returned for a frame T1 refused (see 6 below) even
        when OTHER frames in the same transaction assert cleanly or
        negatively -- a refusal outranks a verdict (WO-0078 §3.3's own
        aggregate precedence, restated at this binary's own scale).
     5  T0 unaligned: the two producers are not indexing the same stimulus
        the same way, so no timing verdict (T1 or T2) was reached at all.
        A defect in the harness, never in either design (WO-0075 §3.1).
     6  T1 REFUSED for at least one frame -- [Canonical.Unassertable], under
        either of its two triggers (WO-0078 §5.2/§5.4): a carried nonzero
        idle count, or exactly one broken inter-word delta with cycle
        evidence alone unable to tell a defect from a legitimate injection.
        **Not a defect against our spec and not a differential finding** --
        it is T1 declining to certify, which ranks ABOVE a reached-and-
        negative verdict (4) on the "did the lane reach a verdict?" axis
        WO-0049 §8 built this table around, intended to map onto
        tools/cosim/run_cosim.sh's `EXIT_TIMING_UNASSERTABLE(12)` (WO-0078
        §5.3; that mapping is data_wrangler's own change, not made here).

   Plain stdlib OCaml — no Base, no Hardcaml. This binary is meant to build
   and run in any environment with a working OCaml toolchain, independent of
   whether iverilog is present (WO-0046 §2.2). *)

(* WO-0049 §5: run 30825741565 died with [Canonical.read]'s own [Failure]
   propagating all the way to an uncaught-exception exit (2), the same code
   [usage]'s branch already used for something else entirely -- a caller had
   no way to tell "malformed producer file" apart from "bad command line"
   from the exit code alone. Exit 3 is the third, distinct outcome: no
   verdict was reached because a canonical file could not even be read, which
   is neither "clean" (0) nor "a divergence" (1). Wrapped around ONLY the two
   [Canonical.read_file] calls below, never around [compare_transactions]:
   [--self-test] calls this exact function (WO-0046 §4.2's principle,
   extended to the new path), so the new code is exercised by the production
   comparator rather than by a parallel hand-rolled one; and a genuine bug
   inside [compare_transactions] itself must keep crashing loudly rather than
   being relabelled a read failure (WO-0049 §5.2). *)
exception Read_failed

let read_canonical_side ~side ~path =
  try Canonical.read_file path with
  | Failure msg | Sys_error msg ->
    (* stderr, one line, names which side and which path -- the CI message
       run 30825741565 produced named neither (WO-0049 §5.3). No OCaml
       "Fatal error:" prefix: this is a caught exception we report in our
       own words, not an uncaught one the runtime reports in its own. *)
    Printf.eprintf "compare: could not read %s canonical file %s: %s\n" side path msg;
    raise Read_failed
;;

(* WO-0078 §5.2 / FINDING RV-0075-2: [<path>.idle], read here if present --
   the sidecar [ours_run.ml] forwards from [stimulus_gen.ml]'s own per-case
   idle-count record (never written for [theirs_path]; T1 takes no argument
   from [theirs], canonical.mli's own contract, unchanged by this addition).
   One decimal integer per line, line order = frame index (0-based, the same
   admission order every producer already writes). Absent file (every case
   this packet's Stage 1 ships) reads as "no carried data at all" -- [[]],
   which [Canonical.check_timing] treats identically to a count of 0 for
   every frame, i.e. exactly today's behaviour. A malformed line is reported
   the same way a malformed canonical file is (WO-0049 §5's own principle,
   applied to this sidecar): caught, named, folded into exit 3, never crashed
   past as an uncaught exception and never silently ignored as if the file
   had not existed. *)
let read_idle_sidecar path =
  if not (Sys.file_exists path)
  then []
  else (
    let ic = open_in_bin path in
    Fun.protect
      ~finally:(fun () -> close_in_noerr ic)
      (fun () ->
         let rec loop index acc =
           match input_line ic with
           | line ->
             let trimmed = String.trim line in
             (match int_of_string_opt trimmed with
              | Some n -> loop (index + 1) ((index, n) :: acc)
              | None ->
                Printf.eprintf
                  "compare: could not read idle sidecar %s: line %d is not a decimal integer \
                   (%S)\n"
                  path
                  (index + 1)
                  line;
                raise Read_failed)
           | exception End_of_file -> List.rev acc
         in
         loop 0 []))
;;

(* The one path every real run and the self-test both go through: read two
   canonical files (and, WO-0078 §5.2, [ours]'s own optional idle sidecar),
   run REQ-901's comparison AND WO-0075/WO-0078 §3/§5's timing tiers, print
   both reports, return the exit code [compare]'s own contract promises.

   WO-0075 §6's precedence, pinned there so it is not invented here and
   extended at WO-0078 §5.3/§3.3: content wins outright (exit 1 whatever the
   timing tiers found); otherwise T0 (exit 5); otherwise T1 REFUSED for any
   frame (exit 6 -- a refusal outranks a reached-and-negative verdict, the
   same "did the lane reach a verdict?" axis WO-0049 §8 built this table
   around); otherwise T1 reached-and-negative (exit 4); otherwise 0. Both
   reports are always printed in full regardless of which exit is taken -- a
   divergence a reader cannot see because a different tier already decided
   the exit code is exactly the failure mode WO-0074-VERDICT §11 item 1
   named. *)
let run_comparison ~ours_path ~theirs_path =
  match read_canonical_side ~side:"ours" ~path:ours_path with
  | exception Read_failed -> 3
  | ours ->
    (match read_canonical_side ~side:"theirs" ~path:theirs_path with
     | exception Read_failed -> 3
     | theirs ->
       (match read_idle_sidecar (ours_path ^ ".idle") with
        | exception Read_failed -> 3
        | injected_idle_before_d0 ->
          let report = Canonical.compare_transactions ~ours ~theirs in
          let timing = Canonical.check_timing ~ours ~theirs ~injected_idle_before_d0 () in
          print_string (Canonical.report_to_string report);
          print_string (Canonical.timing_report_to_string timing);
          let has_unassertable =
            List.exists
              (function
                | Canonical.Unassertable _ -> true
                | Canonical.Admit_cycle_mismatch _ | Canonical.Spec_cycle_mismatch _ -> false)
              timing.spec_divergences
          in
          if not (Canonical.is_clean report)
          then 1
          else if not timing.base_aligned
          then 5
          else if has_unassertable
          then 6
          else if timing.spec_divergences <> []
          then 4
          else 0))
;;

(* A two-word, two-frame-word sample transaction: frame 0 accepted, one full
   word and one partial [tlast] word. Content is arbitrary — this is a
   comparator self-test, not a co-simulation vector, so nothing here needs to
   trace to a REQ or match Phase 1's actual stimulus (WO-0046 §4.2's original
   choice, unchanged by WO-0075).

   The two [cycle]s ARE load-bearing, unlike the content fields: they are
   chosen to satisfy SPEC-M03 §6.1's gapless [admit_cycle + m + 3] formula at
   [admit_cycle] = 0 exactly — word 0 (m=0) at cycle 3, word 1 (m=1, [tlast])
   at cycle 4 — so that case (a) below is genuinely T1-clean and not merely
   T1-untested. *)
let sample_transaction () : Canonical.transaction =
  [ { Canonical.index = 0
    ; admit_cycle = 0
    ; decision = Canonical.Accept
    ; words =
        [ { Canonical.tkeep = 0xff; tlast = false; tuser0 = false; cycle = 3
          ; octets = [ 0; 1; 2; 3; 4; 5; 6; 7 ]
          }
        ; { Canonical.tkeep = 0x0f; tlast = true; tuser0 = false; cycle = 4
          ; octets = [ 8; 9; 10; 11 ]
          }
        ]
    }
  ]
;;

(* [sample_transaction] with exactly one octet perturbed: the first delivered
   octet of the [tlast] word, 8 -> 9. Everything else — tkeep, tlast, tuser0,
   frame count, word count, the OTHER three octets of that word — is
   untouched, so a comparator that passed by coincidentally tripping on some
   other field would not be exonerated by this test. *)
let perturbed_transaction () : Canonical.transaction =
  match sample_transaction () with
  | [ frame ] ->
    (match frame.words with
     | [ w0; w1 ] ->
       let w1' =
         { w1 with
           Canonical.octets =
             (match w1.octets with
              | first :: rest -> (first + 1) :: rest
              | [] -> failwith "compare.ml: sample_transaction's tlast word has no octets")
         }
       in
       [ { frame with Canonical.words = [ w0; w1' ] } ]
     | _ -> failwith "compare.ml: sample_transaction's frame does not have exactly two words")
  | _ -> failwith "compare.ml: sample_transaction does not have exactly one frame"
;;

(* WO-0075 §7 case (d): "every word's cycle shifted by +1 on our side,
   content untouched -- the exact shape of IC-L2." Content (tkeep, tlast,
   tuser0, octets) is byte-for-byte [sample_transaction]'s; [admit_cycle] is
   unchanged (so T0 stays aligned and T1 actually runs); only the two word
   [cycle]s move, both by the same +1, which is exactly IC-L2's "a uniform
   one-cycle word delay ... on every output word" (WO-0075 §0) and exactly
   the shape that "preserves every inter-word delta" (WO-0075 §7) and so
   must NOT trip the guard in canonical.ml's [classify_frame] (`FINDING
   RV-0078-S1-1`'s successor rule, replacing the broken-inter-word-delta
   COUNT WO-0078 §5.4 built; [d_0 = 1 <> 0] here, so this shape is asserted
   under the successor rule too) -- it must fall through to a genuine,
   asserted [Spec_cycle_mismatch] on both words.
   This is the case WO-0075 §7 calls "the most important test in this
   packet," and per its own instruction it was reasoned through, by hand,
   against SPEC-M03 §6.1's formula BEFORE the tier that must catch it was
   written (this file's own journal entry Evidence records the derivation;
   no iverilog or dune exists in this environment to run it red-then-green,
   WO-0075 §10). *)
let shifted_all_transaction () : Canonical.transaction =
  match sample_transaction () with
  | [ frame ] ->
    let shift (w : Canonical.word) = { w with Canonical.cycle = w.cycle + 1 } in
    [ { frame with Canonical.words = List.map shift frame.words } ]
  | _ -> failwith "compare.ml: sample_transaction does not have exactly one frame"
;;

(* WO-0078 §5.4 / RV-0075-VERDICT §4.1: WO-0075 §7's original case (e) --
   "exactly one word's cycle shifted by +1" on the TWO-word [sample_transaction]
   -- is retired here, not merely edited: dv_lead's own diagnosis is quoted in
   the work order verbatim -- "the case cannot distinguish the two
   constructors by construction" -- and a case diagnosed as unable to
   distinguish two things by construction is repaired by changing what it is
   built on, not by re-reading its old result. The two-word frame can only
   ever produce ZERO or ONE broken inter-word delta (there being only one
   delta to break), so it could only ever exercise canonical.ml's
   [Unassertable] branch for a single-word shift, never the (equally real)
   branch where a single-word shift is NOT ambiguous with an idle injection.
   A THREE-word frame produces both shapes: shifting the INTERIOR word breaks
   TWO adjacent deltas (no single idle injection -- which shifts a contiguous
   SUFFIX of the frame uniformly -- can produce that shape, so it is
   assertable); shifting the BOUNDARY (last) word breaks exactly ONE, the
   same ambiguous shape the old two-word case exercised. [admit_cycle] = 0,
   so this frame's three words' gapless SPEC-M03 §6.1 cycles are 3, 4, 5
   (m = 0, 1, 2). Content is arbitrary, as for [sample_transaction] -- this is
   a comparator self-test, not a co-simulation vector. *)
let sample_transaction_3w () : Canonical.transaction =
  [ { Canonical.index = 0
    ; admit_cycle = 0
    ; decision = Canonical.Accept
    ; words =
        [ { Canonical.tkeep = 0xff; tlast = false; tuser0 = false; cycle = 3
          ; octets = [ 0; 1; 2; 3; 4; 5; 6; 7 ]
          }
        ; { Canonical.tkeep = 0xff; tlast = false; tuser0 = false; cycle = 4
          ; octets = [ 8; 9; 10; 11; 12; 13; 14; 15 ]
          }
        ; { Canonical.tkeep = 0x0f; tlast = true; tuser0 = false; cycle = 5
          ; octets = [ 16; 17; 18; 19 ]
          }
        ]
    }
  ]
;;

(* WO-0078 §5.4 case (e): the INTERIOR word (word_index 1, m = 1) shifted by
   +1 (4 -> 5); words 0 and 2 untouched. Breaks BOTH adjacent deltas
   (word 0 -> 1 becomes 2, word 1 -> 2 becomes 0) -- TWO broken deltas, the
   shape canonical.ml's guard now reads as NOT plausibly a single idle
   injection (which can only ever break one, wherever it sits), so it is
   asserted normally, word by word, as [Spec_cycle_mismatch]. *)
let shifted_interior_transaction () : Canonical.transaction =
  match sample_transaction_3w () with
  | [ frame ] ->
    (match frame.words with
     | [ w0; w1; w2 ] ->
       [ { frame with
           Canonical.words = [ w0; { w1 with Canonical.cycle = w1.cycle + 1 }; w2 ]
         }
       ]
     | _ ->
       failwith "compare.ml: sample_transaction_3w's frame does not have exactly three words")
  | _ -> failwith "compare.ml: sample_transaction_3w does not have exactly one frame"
;;

(* WO-0078 §5.4 case (e'): the BOUNDARY word (the last, word_index 2)
   shifted by +1 (5 -> 6); words 0 and 1 untouched. Breaks exactly ONE delta
   (word 1 -> 2 becomes 2) -- structurally identical, from cycle evidence
   alone, to a single legitimate idle injected at that position, which is
   exactly the ambiguity canonical.ml's guard is built to refuse on rather
   than assert past (WO-0075 §3.2's original reasoning, now demonstrated at
   three words rather than two, where it can be told apart from case (e)
   above). *)
let shifted_boundary_transaction () : Canonical.transaction =
  match sample_transaction_3w () with
  | [ frame ] ->
    (match frame.words with
     | [ w0; w1; w2 ] ->
       [ { frame with
           Canonical.words = [ w0; w1; { w2 with Canonical.cycle = w2.cycle + 1 } ]
         }
       ]
     | _ ->
       failwith "compare.ml: sample_transaction_3w's frame does not have exactly three words")
  | _ -> failwith "compare.ml: sample_transaction_3w does not have exactly one frame"
;;

(* `FINDING RV-0078-S1-1`: TWO idles injected at two DISTINCT interior
   positions of a >= 3-word frame -- word 1 delayed by one idle (before it),
   word 2 delayed by a SECOND, cumulative idle (before it) -- produces a
   per-word departure sequence [d = (0; 1; 2)] (SPEC-M03 section 6.1's
   [admit_cycle + m + 3] formula gives 3/4/5; observed here is 3/5/7): zero
   at word 0 (no idle before D(0), consistent with a carried count of 0) and
   NON-DECREASING (delay only ever accumulates). This is EXACTLY the shape a
   legitimate two-idle injection schedule produces, and EXACTLY the shape
   WO-0078 §5.4's own broken-inter-word-delta COUNT got wrong: TWO broken
   deltas (word0->word1 is 2 cycles apart, not 1; word1->word2 is likewise 2,
   not 1) read as "two or more -> assert" under the retired rule, reddening
   a conformant design at [Spec_cycle_mismatch] -- exit 4 -- for a property
   of the stimulus. `FINDING RV-0078-S1-1`'s successor rule reads the SAME
   frame as [Unassertable] -- exit 6 -- instead, which is the regression this
   fixture exists to prove closed. *)
let two_idle_positions_transaction () : Canonical.transaction =
  match sample_transaction_3w () with
  | [ frame ] ->
    (match frame.words with
     | [ w0; w1; w2 ] ->
       [ { frame with
           Canonical.words =
             [ w0
             ; { w1 with Canonical.cycle = w1.cycle + 1 } (* 4 -> 5: d_1 = 1 *)
             ; { w2 with Canonical.cycle = w2.cycle + 2 } (* 5 -> 7: d_2 = 2 *)
             ]
         }
       ]
     | _ ->
       failwith "compare.ml: sample_transaction_3w's frame does not have exactly three words")
  | _ -> failwith "compare.ml: sample_transaction_3w does not have exactly one frame"
;;

(* `FINDING RV-0078-S1-2` limb (b): a TWO-FRAME transaction -- frame 0
   byte-for-byte [sample_transaction]'s own clean, gapless frame
   (admit_cycle 0, cycles 3/4, [d = (0; 0)]); frame 1 a SEPARATE accepted
   frame (admit_cycle 8) whose own cycles are shifted +1 on both words, the
   exact IC-L2 shape ([d = (1; 1)]), so it asserts a T1 timing defect. This
   is the shape unreachable at Stage 1's one-frame case 0 and reachable for
   the first time at Stage 2's C2 (two clean frames): before this repair,
   [Canonical.timing_report_to_string] gated [own_profile]'s ENTIRE print on
   the whole transaction's [spec_divergences] being empty, so frame 1's
   unrelated divergence hid frame 0's own clean numbers along with it. Both
   sides of the comparison use this SAME transaction (as case (a) does with
   [good_path] twice): [compare_transactions] never looks at [cycle], and T0
   only needs the two sides' [admit_cycle]s to agree, which they trivially
   do against themselves. *)
let two_frame_transaction () : Canonical.transaction =
  let frame0 =
    match sample_transaction () with
    | [ f ] -> f
    | _ -> failwith "compare.ml: sample_transaction does not have exactly one frame"
  in
  let frame1 =
    { Canonical.index = 1
    ; admit_cycle = 8
    ; decision = Canonical.Accept
    ; words =
        [ { Canonical.tkeep = 0xff
          ; tlast = false
          ; tuser0 = false
          ; cycle = 12 (* expected 8 + 0 + 3 = 11: d_0 = 1 *)
          ; octets = [ 20; 21; 22; 23; 24; 25; 26; 27 ]
          }
        ; { Canonical.tkeep = 0x0f
          ; tlast = true
          ; tuser0 = false
          ; cycle = 13 (* expected 8 + 1 + 3 = 12: d_1 = 1 *)
          ; octets = [ 28; 29; 30; 31 ]
          }
        ]
    }
  in
  [ frame0; frame1 ]
;;

(* `FINDING RV-0078-S2-8` (rides with the `S2-6` repair, WO-0078 §14): the
   golden-file fixture -- the canonical file tb_writer INTENDS
   [tb_xgmii_rx_64.v]'s repaired (buffered) writer to emit for a two-frame,
   minimum-IFG, overlapping-spans schedule shaped exactly like CD §10.2's C2
   instance -- frame 0 admit_cycle 0, frame 1 admit_cycle 10 (`RV-C2RERUN`
   §4: "at C2 frame 1 is admitted on cycle 10"), eight full 64-bit words
   each (a 64-octet frame at REQ-102's own minimum length, 8 octets/word,
   `RV-C2RERUN` §1: "two frames, eight words each, both Accept"), both
   [Accept]. [reference_two_frame_golden_canon_text] below is written BY
   HAND, as raw text, deliberately never through [Canonical.write] -- the
   same reasoning [reference_refusal_canon_text]/[old_format_canon_text]/
   [defect_shape_canon_text] above use: this simulates what an INDEPENDENT
   VERILOG producer writes, and the entire point of a golden file per
   `FINDING RV-0078-S2-8` is that it is diffable, by a reviewer, against
   [tb_xgmii_rx_64.v]'s own $fwrite call sites -- generating it through
   [Canonical.write] instead would only prove the OCaml writer agrees with
   itself, never say anything about the Verilog writer's intended shape.
   Each frame's block is F, then its eight W lines in emission order, then
   D, CONTIGUOUS -- exactly the grouping the pinned grammar requires and the
   pre-repair real-time writer violated (`FINDING RV-0078-S2-6`). Cycles are
   SPEC-M03 §6.1's own gapless [admit_cycle + m + 3] formula for both
   frames (word m of frame 0: [m + 3]; word m of frame 1: [10 + m + 3]),
   because a golden file exercising only [Canonical.read]'s grammar
   acceptance while carrying self-inconsistent timing would be a weaker
   artefact than one a T1-clean comparison can also certify.
   [two_frame_golden_transaction] is the SAME content, constructed through
   [Canonical.write_file] as every other "ours" fixture in this self-test
   is, so the check below is (b)'s own shape -- "construct a known-good
   pair, assert agreement" -- applied to this two-frame shape: it proves
   BOTH that the hand-authored file reads (the core `S2-8` check, converting
   the writer's record order from an unstated assumption into a stated,
   diffable artefact) AND that it is byte-for-byte the content and cycles
   this packet's own two-frame case intends, not merely well-formed. It does
   NOT execute [tb_xgmii_rx_64.v] (ADR-0005; this environment has no
   iverilog) and is only as good as the hand that wrote the text below --
   it does not discharge `FINDING RV-0078-S1-4`, which needs a real
   reference-side guard trip (C9). *)
let two_frame_golden_transaction () : Canonical.transaction =
  let word ~cycle ~tlast octets =
    { Canonical.tkeep = 0xff; tlast; tuser0 = false; cycle; octets }
  in
  let frame0_words =
    List.init 8 (fun m ->
      word ~cycle:(m + 3) ~tlast:(m = 7) (List.init 8 (fun k -> (m * 8) + k)))
  in
  let frame1_words =
    List.init 8 (fun m ->
      word ~cycle:(10 + m + 3) ~tlast:(m = 7) (List.init 8 (fun k -> 64 + (m * 8) + k)))
  in
  [ { Canonical.index = 0; admit_cycle = 0; decision = Canonical.Accept; words = frame0_words }
  ; { Canonical.index = 1; admit_cycle = 10; decision = Canonical.Accept; words = frame1_words }
  ]
;;

let reference_two_frame_golden_canon_text =
  "F 0 0\n\
   W ff 0 0 3 00 01 02 03 04 05 06 07\n\
   W ff 0 0 4 08 09 0a 0b 0c 0d 0e 0f\n\
   W ff 0 0 5 10 11 12 13 14 15 16 17\n\
   W ff 0 0 6 18 19 1a 1b 1c 1d 1e 1f\n\
   W ff 0 0 7 20 21 22 23 24 25 26 27\n\
   W ff 0 0 8 28 29 2a 2b 2c 2d 2e 2f\n\
   W ff 0 0 9 30 31 32 33 34 35 36 37\n\
   W ff 1 0 10 38 39 3a 3b 3c 3d 3e 3f\n\
   D 0 accept\n\
   F 1 10\n\
   W ff 0 0 13 40 41 42 43 44 45 46 47\n\
   W ff 0 0 14 48 49 4a 4b 4c 4d 4e 4f\n\
   W ff 0 0 15 50 51 52 53 54 55 56 57\n\
   W ff 0 0 16 58 59 5a 5b 5c 5d 5e 5f\n\
   W ff 0 0 17 60 61 62 63 64 65 66 67\n\
   W ff 0 0 18 68 69 6a 6b 6c 6d 6e 6f\n\
   W ff 0 0 19 70 71 72 73 74 75 76 77\n\
   W ff 1 0 20 78 79 7a 7b 7c 7d 7e 7f\n\
   D 1 accept\n"
;;

(* WO-0078 §5.2 / FINDING RV-0075-2: [sample_transaction ()], UNMODIFIED --
   its cycles (3, 4) are already perfectly gapless, zero broken deltas, and
   would be reported CLEAN (exit 0) by cycle evidence alone. The point of
   this fixture is exactly that: it demonstrates the antecedent is CARRIED,
   not inferred, by pairing this untouched-clean transaction with an
   [.idle] sidecar declaring a nonzero count for frame 0 and asserting the
   verdict flips to [Unassertable] (exit 6) anyway -- a result inference
   from cycles alone could never produce, since there is nothing in the
   cycles themselves to infer it from. *)
let idle_carried_ok_transaction () : Canonical.transaction = sample_transaction ()

(* WO-0078 §2.3 / FINDING WO-0078-1: the EXACT shape [tb_xgmii_rx_64.v] now
   writes to [theirs.canon] upon tripping its no-open-frame guard (FI-7) --
   one COMPLETE, well-formed frame (this is what makes THIS refusal shape
   the dangerous one of the two named in the finding: without the sentinel
   line, the file parses as a short-but-valid transaction and a divergence
   against it would misreport a harness malfunction as a genuine content
   finding, exactly the miscategorisation WO-0049 was written about) followed
   by the "E" sentinel line [Canonical.read] now recognises and rejects
   explicitly, regardless of the open/closed frame state at the point it
   appears. Written as raw text, like [old_format_canon_text] and
   [defect_shape_canon_text] above and for the identical reason: this
   simulates what an INDEPENDENT VERILOG producer writes, which
   [Canonical.write] cannot itself manufacture. "Tripped deliberately" in
   the sense every other hand-built fixture in this self-test already is --
   reasoned from the producer's own source text and its guard placement,
   never executed (iverilog is not available in this environment, WO-0078
   §2.3's own disclosed limit, ADR-0005). *)
let reference_refusal_canon_text =
  "F 0 0\nW ff 1 0 3 00 01 02 03 04 05 06 07\nD 0 accept\nE word-with-no-open-frame\n"
;;

(* WO-0075 §7's own optional addition ("if it costs you nothing"): two files
   whose [admit_cycle]s disagree. Content and word cycles are otherwise
   [sample_transaction]'s, so a T0 exit is attributable to [admit_cycle]
   alone. *)
let misaligned_admit_transaction () : Canonical.transaction =
  match sample_transaction () with
  | [ frame ] -> [ { frame with Canonical.admit_cycle = frame.admit_cycle + 5 } ]
  | _ -> failwith "compare.ml: sample_transaction does not have exactly one frame"
;;

(* WO-0075 §7 case (f): an old-format file, predating the [admit_cycle]/
   [cycle] grammar amendment (WO-0046 §2.3's ORIGINAL grammar, verbatim) —
   content-equal to [sample_transaction] but written by a producer nobody
   has updated. canonical.mli's own contract (§2) is that this MUST fail to
   read (exit 3) rather than being silently misread as agreement (as a
   clean 0) or as a content disagreement (a spurious 1). Built as raw text,
   deliberately never through [Canonical.write] — the same reasoning
   [defect_shape_canon_text] below uses: [write] can only ever emit the
   CURRENT grammar, so the OLD grammar has to be spelled out by hand to
   exist as a fixture at all. *)
let old_format_canon_text =
  "F 0\nW ff 0 0 00 01 02 03 04 05 06 07\nW 0f 1 0 08 09 0a 0b\nD 0 accept\n"
;;

(* WO-0049 §5.4: the EXACT defect shape run 30825741565 produced -- a [W]
   line whose octet token is 16 hex digits, not the 2 canonical.mli's
   grammar pins ("hex fields are exactly 2 digits"). Written as raw text,
   never through [Canonical.write]: that function's [word]s carry the octet
   as an OCaml [int] and [write] always emits however many hex digits the
   VALUE needs (never more), so it cannot itself manufacture this malformed
   shape -- only an independent producer speaking the grammar wrong can,
   which is exactly what [tb_xgmii_rx_64.v]'s pre-fix line 155 did. Updated
   for WO-0075's grammar: the [F] line now carries its [admit-cycle] and the
   [W] line its [cycle], both well-formed, so the ONLY defect this fixture
   still exercises is the 16-hex-digit octet token -- the same isolation
   principle [perturbed_transaction] uses for content. *)
let defect_shape_canon_text = "F 0 0\nW 0f 1 0 3 0000000000000002\nD 0 accept\n"

(* WO-0046 §4.2, verbatim: "construct a known-good pair, assert agreement;
   perturb exactly one octet, assert the same comparison reports a
   difference and exits nonzero." WO-0049 §5.4 adds a third: a malformed
   canonical file must report the new "could not read" code (3), not be
   comparable at all. WO-0075 §7 adds three more (d, e, f) plus one optional
   T0 case, all through this same production path. Every assertion below
   calls [run_comparison] — the exact function [main] calls for a real run —
   against real files on disk, never a bespoke in-memory harness that could
   pass while the production path is broken.

   WO-0075 §7: "Case (d) is the most important test in this packet ... Write
   (d) first and make sure it fails before the tier is implemented." Read
   literally this instruction assumes an environment that can run the suite
   red-then-green; this one cannot (no dune, no Hardcaml toolchain, WO-0075
   §10's own Evidence section says so for both assignees). What was done
   instead, in the order the instruction asks for: case (d)'s expected
   values were derived BY HAND against SPEC-M03 §6.1's [admit_cycle + m + 3]
   formula and [shifted_all_transaction]'s +1 shift before
   [Canonical.check_timing] was written, confirming the shift must read as a
   [Spec_cycle_mismatch] on both words (not fall through the guard) before
   the guard's own logic was drafted to make sure it would not — the
   ordering this note claims, not a red run this environment cannot produce.
   (The guard's own implementation has since been replaced wholesale by
   `FINDING RV-0078-S1-1`'s successor rule, [Canonical.classify_frame]; this
   note describes WO-0075's original derivation and is left as history, not
   updated to name the current function.) *)
let self_test () =
  let good_path = Filename.temp_file "cosim_compare_selftest_good" ".canon" in
  let bad_path = Filename.temp_file "cosim_compare_selftest_bad" ".canon" in
  let malformed_path = Filename.temp_file "cosim_compare_selftest_malformed" ".canon" in
  let shifted_all_path = Filename.temp_file "cosim_compare_selftest_shifted_all" ".canon" in
  let good_3w_path = Filename.temp_file "cosim_compare_selftest_good_3w" ".canon" in
  let shifted_interior_path = Filename.temp_file "cosim_compare_selftest_shifted_interior" ".canon" in
  let shifted_boundary_path = Filename.temp_file "cosim_compare_selftest_shifted_boundary" ".canon" in
  let old_format_path = Filename.temp_file "cosim_compare_selftest_old_format" ".canon" in
  let misaligned_path = Filename.temp_file "cosim_compare_selftest_misaligned" ".canon" in
  let idle_carried_path = Filename.temp_file "cosim_compare_selftest_idle_carried" ".canon" in
  let refusal_path = Filename.temp_file "cosim_compare_selftest_refusal" ".canon" in
  let two_idle_positions_path =
    Filename.temp_file "cosim_compare_selftest_two_idle_positions" ".canon"
  in
  let two_frame_path = Filename.temp_file "cosim_compare_selftest_two_frame" ".canon" in
  let two_frame_golden_ours_path =
    Filename.temp_file "cosim_compare_selftest_two_frame_golden_ours" ".canon"
  in
  let two_frame_golden_reference_path =
    Filename.temp_file "cosim_compare_selftest_two_frame_golden_reference" ".canon"
  in
  let cleanup () =
    List.iter
      (fun path ->
         try Sys.remove path with
         | Sys_error _ -> ())
      [ good_path
      ; bad_path
      ; malformed_path
      ; shifted_all_path
      ; good_3w_path
      ; shifted_interior_path
      ; shifted_boundary_path
      ; old_format_path
      ; misaligned_path
      ; idle_carried_path
      ; idle_carried_path ^ ".idle" (* WO-0078 §5.2 -- the sidecar, cleaned up alongside *)
      ; refusal_path
      ; two_idle_positions_path (* FINDING RV-0078-S1-1 *)
      ; two_frame_path (* FINDING RV-0078-S1-2 limb (b) *)
      ; two_frame_golden_ours_path (* FINDING RV-0078-S2-8 *)
      ; two_frame_golden_reference_path (* FINDING RV-0078-S2-8 *)
      ]
  in
  Fun.protect ~finally:cleanup (fun () ->
    Canonical.write_file good_path (sample_transaction ());
    Canonical.write_file bad_path (perturbed_transaction ());
    (let oc = open_out_bin malformed_path in
     Fun.protect
       ~finally:(fun () -> close_out_noerr oc)
       (fun () -> output_string oc defect_shape_canon_text));
    Canonical.write_file shifted_all_path (shifted_all_transaction ());
    Canonical.write_file good_3w_path (sample_transaction_3w ());
    Canonical.write_file shifted_interior_path (shifted_interior_transaction ());
    Canonical.write_file shifted_boundary_path (shifted_boundary_transaction ());
    (let oc = open_out_bin old_format_path in
     Fun.protect
       ~finally:(fun () -> close_out_noerr oc)
       (fun () -> output_string oc old_format_canon_text));
    Canonical.write_file misaligned_path (misaligned_admit_transaction ());
    Canonical.write_file idle_carried_path (idle_carried_ok_transaction ());
    (* WO-0078 §5.2: the sidecar declares 1 injected idle for frame 0, even
       though [idle_carried_path]'s own cycles are perfectly gapless -- the
       whole point of this fixture (see [idle_carried_ok_transaction]'s own
       comment). *)
    (let oc = open_out_bin (idle_carried_path ^ ".idle") in
     Fun.protect ~finally:(fun () -> close_out_noerr oc) (fun () -> Printf.fprintf oc "1\n"));
    (let oc = open_out_bin refusal_path in
     Fun.protect
       ~finally:(fun () -> close_out_noerr oc)
       (fun () -> output_string oc reference_refusal_canon_text));
    Canonical.write_file two_idle_positions_path (two_idle_positions_transaction ());
    Canonical.write_file two_frame_path (two_frame_transaction ());
    (* `FINDING RV-0078-S2-8`: the golden-file fixture. [ours] is the SAME
       content constructed through [Canonical.write_file], like every other
       "ours" side in this self-test; [theirs] is the hand-authored text
       simulating the repaired reference writer's intended buffered output
       -- see [reference_two_frame_golden_canon_text]'s own comment for the
       full reasoning. *)
    Canonical.write_file two_frame_golden_ours_path (two_frame_golden_transaction ());
    (let oc = open_out_bin two_frame_golden_reference_path in
     Fun.protect
       ~finally:(fun () -> close_out_noerr oc)
       (fun () -> output_string oc reference_two_frame_golden_canon_text));
    let check ~title ~expect ~expect_label exit_code =
      let ok = exit_code = expect in
      Printf.printf "compare --self-test: %s\n" title;
      Printf.printf
        "  %s: %s (exit %d)\n"
        (if ok then "PASS" else "FAIL")
        expect_label
        exit_code;
      ok
    in
    (* (a) *)
    let a_ok =
      check
        ~title:"(a) identical canonical files, cycles correct"
        ~expect:0
        ~expect_label:"identical canonical files compare clean"
        (run_comparison ~ours_path:good_path ~theirs_path:good_path)
    in
    (* (b) *)
    let b_ok =
      check
        ~title:"(b) one octet perturbed (existing WO-0046 case)"
        ~expect:1
        ~expect_label:"a one-octet perturbation is reported as a content divergence"
        (run_comparison ~ours_path:good_path ~theirs_path:bad_path)
    in
    (* (c) *)
    let c_ok =
      check
        ~title:
          "(c) malformed file (16-hex-digit octet token, the defect shape of run \
           30825741565, existing WO-0049 case)"
        ~expect:3
        ~expect_label:"a malformed canonical file reports \"could not read\", not a verdict"
        (run_comparison ~ours_path:good_path ~theirs_path:malformed_path)
    in
    (* (d) — WO-0075 §7: "the most important test in this packet." *)
    let d_ok =
      check
        ~title:
          "(d) every word's cycle shifted by +1 on our side, content untouched -- the \
           exact shape of IC-L2"
        ~expect:4
        ~expect_label:
          "a uniform +1 shift is reported as a T1 timing defect against SPEC-M03 \
           section 6.1, not silently absorbed by an inter-word-delta-only check"
        (run_comparison ~ours_path:shifted_all_path ~theirs_path:good_path)
    in
    (* (e) — WO-0078 §5.4: rebuilt on a >= 3-word frame, interior shift. *)
    let e_ok =
      check
        ~title:
          "(e) an INTERIOR word's cycle shifted by +1 on a >= 3-word frame (rebuilt, \
           WO-0078 section 5.4)"
        ~expect:4
        ~expect_label:
          "two broken inter-word deltas are NOT the shape a single idle injection \
           produces, so this is asserted as an ordinary T1 timing defect"
        (run_comparison ~ours_path:shifted_interior_path ~theirs_path:good_3w_path)
    in
    (* (e') — WO-0078 §5.4: the boundary shift, the shape the old two-word (e)
       could only ever produce; now separately testable from (e) above. *)
    let e'_ok =
      check
        ~title:
          "(e') a BOUNDARY word's cycle shifted by +1 on the SAME >= 3-word frame \
           (added, WO-0078 section 5.4)"
        ~expect:6
        ~expect_label:
          "exactly one broken inter-word delta is indistinguishable, from cycle \
           evidence alone, from a legitimate idle injection, so T1 refuses \
           (Unassertable) rather than asserting past it"
        (run_comparison ~ours_path:shifted_boundary_path ~theirs_path:good_3w_path)
    in
    (* (f) *)
    let f_ok =
      check
        ~title:"(f) an old-format file (no cycle fields)"
        ~expect:3
        ~expect_label:
          "an old-format file fails to read (never 0, never 1 -- canonical.mli's own \
           decimal-grammar contract, WO-0075 section 2)"
        (run_comparison ~ours_path:good_path ~theirs_path:old_format_path)
    in
    (* WO-0075 §7's optional T0 addition. *)
    let t0_ok =
      check
        ~title:"(T0, optional) two files whose admit_cycles disagree"
        ~expect:5
        ~expect_label:"a T0 misalignment is reported with T1 and T2 withheld"
        (run_comparison ~ours_path:misaligned_path ~theirs_path:good_path)
    in
    (* WO-0078 §5.2 / FINDING RV-0075-2: the antecedent is CARRIED, not
       inferred -- a transaction whose cycles alone would read as CLEAN
       (exit 0) is reported Unassertable (exit 6) purely because its sidecar
       says so. FINDING RV-0075-3: this is the sole exerciser of the
       carried-antecedent branch and is not marked optional. *)
    let idle_carried_ok =
      check
        ~title:
          "(WO-0078 5.2) a transaction with perfectly gapless cycles, but an idle \
           sidecar declaring 1 injected idle for frame 0"
        ~expect:6
        ~expect_label:
          "the CARRIED count alone flips the verdict to Unassertable; cycle evidence \
           alone would have read this transaction as clean, proving the antecedent is \
           carried rather than inferred"
        (run_comparison ~ours_path:idle_carried_path ~theirs_path:good_path)
    in
    (* WO-0078 §2.3 / FINDING WO-0078-1: at least one reference-side refusal,
       tripped deliberately (see [reference_refusal_canon_text]'s own
       comment for what "deliberately" means in an iverilog-less
       environment, ADR-0005) and its code observed. *)
    let refusal_ok =
      check
        ~title:
          "(WO-0078-1) a reference-side refusal sentinel (the E record \
           tb_xgmii_rx_64.v now writes before $finish on its no-open-frame guard, \
           FI-7), tripped deliberately"
        ~expect:3
        ~expect_label:
          "a producer-refusal sentinel fails to read outright -- never silently \
           short-but-valid, and never a false differential finding"
        (run_comparison ~ours_path:good_path ~theirs_path:refusal_path)
    in
    (* `FINDING RV-0078-S1-1`: the regression this repair round exists to
       close -- a >= 3-word frame with TWO broken inter-word deltas from TWO
       idles injected at two distinct interior positions ([d = (0; 1; 2)],
       zero at word 0, non-decreasing) used to ASSERT under WO-0078 §5.4's
       broken-delta COUNT ("two or more -> assert"); the successor rule
       reads the SAME shape as consistent with a legitimate injection
       schedule and refuses instead. Not marked optional: this is the sole
       exerciser of the regression this finding names. *)
    let two_idle_positions_ok =
      check
        ~title:
          "(FINDING RV-0078-S1-1) two idles at two distinct interior positions of a \
           >= 3-word frame (d = 0, 1, 2 -- zero at word 0, non-decreasing)"
        ~expect:6
        ~expect_label:
          "a non-decreasing, D(0)-anchored departure sequence is consistent with a \
           legitimate two-idle injection schedule, so T1 refuses (Unassertable) rather \
           than asserting past it -- WO-0078 section 5.4's retired rule asserted this \
           exact shape (exit 4), reddening a conformant design"
        (run_comparison
           ~ours_path:two_idle_positions_path
           ~theirs_path:two_idle_positions_path)
    in
    (* `FINDING RV-0078-S1-2` limb (b): a two-frame case, frame 0 clean and
       frame 1 asserting -- frame 0's own numbers must still print (verified
       by eyeball against the printed report below, not by this exit-code
       check alone: see the journal entry's Evidence). Not marked optional:
       this is the sole exerciser of a multi-frame case in this self-test,
       and it is the exact shape Stage 2's C2 (two clean frames) will land. *)
    let two_frame_ok =
      check
        ~title:
          "(FINDING RV-0078-S1-2 limb b) a two-frame case: frame 0 clean, frame 1 \
           asserting a uniform +1 shift"
        ~expect:4
        ~expect_label:
          "T1 reaches a negative verdict from frame 1's own divergence; frame 0's own \
           clean per-word numbers must still be present in the printed report, not \
           hidden behind frame 1's unrelated divergence"
        (run_comparison ~ours_path:two_frame_path ~theirs_path:two_frame_path)
    in
    (* `FINDING RV-0078-S2-8`: the reference writer's own golden file (hand-
       authored, diffable against tb_xgmii_rx_64.v's $fwrite call sites --
       never generated through [Canonical.write]) fed to [Canonical.read]
       via the exact production path [run_comparison] uses for a real run.
       Two frames, eight words each, both Accept, gapless SPEC-M03 section
       6.1 cycles on both sides (matching this packet's own C2 shape:
       frame 0 admit_cycle 0, frame 1 admit_cycle 10) -- expect a fully
       clean comparison (exit 0), which certifies both that the CONTIGUOUS,
       per-frame-grouped shape the `S2-6` repair now writes reads at all
       (the core check this finding exists for) and that its content and
       timing are what this packet's own two-frame case intends, not merely
       well-formed. Not marked optional: this is the sole exerciser of a
       hand-authored two-frame reference-side file in this self-test, and
       the check `FINDING RV-0078-S2-8` says would have caught `S2-6`
       statically, with no simulator, had it existed before this repair. *)
    let two_frame_golden_ok =
      check
        ~title:
          "(FINDING RV-0078-S2-8) the reference writer's intended two-frame, \
           minimum-IFG buffered output (hand-authored golden file)"
        ~expect:0
        ~expect_label:
          "the golden file's per-frame CONTIGUOUS blocks (F, its 8 W lines, D) read \
           cleanly and agree with our own side's identical content and gapless \
           SPEC-M03 section 6.1 cycles"
        (run_comparison
           ~ours_path:two_frame_golden_ours_path
           ~theirs_path:two_frame_golden_reference_path)
    in
    if a_ok
       && b_ok
       && c_ok
       && d_ok
       && e_ok
       && e'_ok
       && f_ok
       && t0_ok
       && idle_carried_ok
       && refusal_ok
       && two_idle_positions_ok
       && two_frame_ok
       && two_frame_golden_ok
    then (
      Printf.printf "compare --self-test: OK\n";
      0)
    else (
      Printf.printf "compare --self-test: FAILED\n";
      1))
;;

let usage () =
  prerr_endline "usage: compare <ours.canon> <theirs.canon>";
  prerr_endline "       compare --self-test";
  prerr_endline "exit codes: 0 clean, 1 content divergence, 2 usage error,";
  prerr_endline "            3 could not read a canonical file, or its idle sidecar";
  prerr_endline "              (WO-0049 section 5; WO-0078 section 5.2),";
  prerr_endline "            4 T1 timing verdict negative -- defect against OUR spec,";
  prerr_endline "              never the MIT reference (WO-0075 section 6),";
  prerr_endline "            5 T0 unaligned -- no timing verdict reached (WO-0075 section 6),";
  prerr_endline "            6 T1 refused (Unassertable) for at least one frame -- not a";
  prerr_endline "              defect, not a differential finding (WO-0078 section 5.3)"
;;

let () =
  let code =
    match Sys.argv with
    | [| _; "--self-test" |] -> self_test ()
    | [| _; ours_path; theirs_path |] -> run_comparison ~ours_path ~theirs_path
    | _ ->
      usage ();
      2
  in
  exit code
;;
