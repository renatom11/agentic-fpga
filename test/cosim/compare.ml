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
                                            and WO-0075 §7's six timing-tier
                                            cases, all through this same
                                            production path (below).

   Exit codes (WO-0075 §6 pins 4 and 5; 0-3 are WO-0046/WO-0049's, unchanged):
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
        (canonical.mli's own decimal-grammar contract) -- never as a silent 0.
     4  T1 reached a verdict and it was negative: our own side's output
        landed on a cycle other than the one SPEC-M03 §6.1 pins for it, on a
        stimulus whose content both sides agree on. **This is a defect
        against OUR spec (REQ-005/REQ-111), never a disagreement with the
        MIT reference** -- WO-0075 §3.2's own distinction, restated here
        because it decides how the failure is triaged, not just how it is
        printed.
     5  T0 unaligned: the two producers are not indexing the same stimulus
        the same way, so no timing verdict (T1 or T2) was reached at all.
        A defect in the harness, never in either design (WO-0075 §3.1).

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

(* The one path every real run and the self-test both go through: read two
   canonical files, run REQ-901's comparison AND WO-0075 §3's timing tiers,
   print both reports, return the exit code [compare]'s own contract
   promises.

   WO-0075 §6's precedence, pinned there so it is not invented here: content
   wins outright (exit 1 whatever the timing tiers found); otherwise T0
   (exit 5); otherwise T1 (exit 4); otherwise 0. Both reports are always
   printed in full regardless of which exit is taken -- a divergence a
   reader cannot see because a different tier already decided the exit code
   is exactly the failure mode WO-0074-VERDICT §11 item 1 named. *)
let run_comparison ~ours_path ~theirs_path =
  match read_canonical_side ~side:"ours" ~path:ours_path with
  | exception Read_failed -> 3
  | ours ->
    (match read_canonical_side ~side:"theirs" ~path:theirs_path with
     | exception Read_failed -> 3
     | theirs ->
       let report = Canonical.compare_transactions ~ours ~theirs in
       let timing = Canonical.check_timing ~ours ~theirs in
       print_string (Canonical.report_to_string report);
       print_string (Canonical.timing_report_to_string timing);
       if not (Canonical.is_clean report)
       then 1
       else if not timing.base_aligned
       then 5
       else if timing.spec_divergences <> []
       then 4
       else 0)
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
   must NOT trip the guard in canonical.ml's [first_broken_delta] -- it must
   fall through to a genuine, asserted [Spec_cycle_mismatch] on both words.
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

(* WO-0075 §7 case (e): "exactly one word's cycle shifted by +1." Only the
   [tlast] word's cycle moves (4 -> 5); word 0 is untouched at cycle 3.
   Content is untouched, same as case (d).

   Where this lands in canonical.ml's own tiering, stated because it is a
   real disagreement rather than a silent choice: with only two words in
   this frame, shifting the LAST one by +1 breaks the ONE inter-word delta
   there is to break (3 -> 5 is two cycles, not one), which trips
   [first_broken_delta]'s guard exactly as a genuine mid-frame idle would —
   the two are structurally identical in a two-word frame, and canonical.ml
   cannot tell them apart from cycles alone (there being no strobe/idle
   field to consult, WO-0075 §9's own refusal). So this case is reported as
   [Unassertable] rather than [Spec_cycle_mismatch] under this
   implementation. WO-0075 §6's own exit-code table has no third bucket for
   "T1 refused, no other divergence" — only "reached a verdict, negative"
   (4) and "T0 unaligned" (5) — so this file counts a non-empty
   [spec_divergences] under an aligned T0 as exit 4 regardless of which
   constructor produced it, on a fail-closed reading: a tier that declines
   to certify clean is not clean. This is flagged in the Return log as a
   question for dv_lead's ruling, not resolved here (WO-0075 §7 does not
   pin the required INTERNAL classification of this case, only its exit
   code, and the exit code is what this assertion below checks). *)
let shifted_one_transaction () : Canonical.transaction =
  match sample_transaction () with
  | [ frame ] ->
    (match frame.words with
     | [ w0; w1 ] ->
       [ { frame with Canonical.words = [ w0; { w1 with Canonical.cycle = w1.cycle + 1 } ] } ]
     | _ -> failwith "compare.ml: sample_transaction's frame does not have exactly two words")
  | _ -> failwith "compare.ml: sample_transaction does not have exactly one frame"
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
   the guard's own [first_broken_delta] logic was drafted to make sure it
   would not — the ordering this note claims, not a red run this environment
   cannot produce. *)
let self_test () =
  let good_path = Filename.temp_file "cosim_compare_selftest_good" ".canon" in
  let bad_path = Filename.temp_file "cosim_compare_selftest_bad" ".canon" in
  let malformed_path = Filename.temp_file "cosim_compare_selftest_malformed" ".canon" in
  let shifted_all_path = Filename.temp_file "cosim_compare_selftest_shifted_all" ".canon" in
  let shifted_one_path = Filename.temp_file "cosim_compare_selftest_shifted_one" ".canon" in
  let old_format_path = Filename.temp_file "cosim_compare_selftest_old_format" ".canon" in
  let misaligned_path = Filename.temp_file "cosim_compare_selftest_misaligned" ".canon" in
  let cleanup () =
    List.iter
      (fun path ->
         try Sys.remove path with
         | Sys_error _ -> ())
      [ good_path
      ; bad_path
      ; malformed_path
      ; shifted_all_path
      ; shifted_one_path
      ; old_format_path
      ; misaligned_path
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
    Canonical.write_file shifted_one_path (shifted_one_transaction ());
    (let oc = open_out_bin old_format_path in
     Fun.protect
       ~finally:(fun () -> close_out_noerr oc)
       (fun () -> output_string oc old_format_canon_text));
    Canonical.write_file misaligned_path (misaligned_admit_transaction ());
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
    (* (e) *)
    let e_ok =
      check
        ~title:"(e) exactly one word's cycle shifted by +1"
        ~expect:4
        ~expect_label:"a single-word cycle shift is reported as a T1 timing defect"
        (run_comparison ~ours_path:shifted_one_path ~theirs_path:good_path)
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
    if a_ok && b_ok && c_ok && d_ok && e_ok && f_ok && t0_ok
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
  prerr_endline "            3 could not read a canonical file (WO-0049 section 5),";
  prerr_endline "            4 T1 timing verdict negative -- defect against OUR spec,";
  prerr_endline "              never the MIT reference (WO-0075 section 6),";
  prerr_endline "            5 T0 unaligned -- no timing verdict reached (WO-0075 section 6)"
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
