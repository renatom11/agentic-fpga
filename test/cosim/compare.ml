(* WO-0046 §2.1/§4 — the comparator. A thin CLI wrapper around
   [Canonical]'s domain comparison; all REQ-901 logic lives there, not here,
   so that [--self-test] (below) exercises the identical code path as the
   production comparison rather than a second, hand-rolled one.

   Usage:
     compare <ours.canon> <theirs.canon>   REQ-901's comparison; prints its
                                            Verification-column report;
                                            exit 0 iff clean, 1 iff any
                                            divergence (every divergence is a
                                            defect for the M03 pairing —
                                            WO-0046 §1, canonical.mli's
                                            [class_of]), 2 iff a usage error,
                                            3 iff EITHER canonical file could
                                            not be read at all -- a grammar
                                            violation ([Canonical.read]'s own
                                            [Failure]) or an I/O failure
                                            opening it ([Sys_error]). Exit 3
                                            means no verdict was reached and
                                            must never be read as "clean" or
                                            as "divergence" (WO-0049 §5).
     compare --self-test                   WO-0046 §4.2's deliberate-mismatch
                                            check plus WO-0049 §5.4's
                                            malformed-canonical-file check,
                                            all through this same production
                                            path (below).

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
   canonical files, run REQ-901's comparison, print its report, return the
   exit code [compare]'s own contract promises. *)
let run_comparison ~ours_path ~theirs_path =
  match read_canonical_side ~side:"ours" ~path:ours_path with
  | exception Read_failed -> 3
  | ours ->
    (match read_canonical_side ~side:"theirs" ~path:theirs_path with
     | exception Read_failed -> 3
     | theirs ->
       let report = Canonical.compare_transactions ~ours ~theirs in
       print_string (Canonical.report_to_string report);
       if Canonical.is_clean report then 0 else 1)
;;

(* A two-word, two-frame-word sample transaction: frame 0 accepted, one full
   word and one partial [tlast] word. Content is arbitrary — this is a
   comparator self-test, not a co-simulation vector, so nothing here needs to
   trace to a REQ or match Phase 1's actual stimulus. *)
let sample_transaction () : Canonical.transaction =
  [ { Canonical.index = 0
    ; decision = Canonical.Accept
    ; words =
        [ { Canonical.tkeep = 0xff; tlast = false; tuser0 = false
          ; octets = [ 0; 1; 2; 3; 4; 5; 6; 7 ]
          }
        ; { Canonical.tkeep = 0x0f; tlast = true; tuser0 = false
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

(* WO-0049 §5.4: the EXACT defect shape run 30825741565 produced -- a [W]
   line whose octet token is 16 hex digits, not the 2 canonical.mli's
   grammar pins ("hex fields are exactly 2 digits"). Written as raw text,
   never through [Canonical.write]: that function's [word]s carry the octet
   as an OCaml [int] and [write] always emits however many hex digits the
   VALUE needs (never more), so it cannot itself manufacture this malformed
   shape -- only an independent producer speaking the grammar wrong can,
   which is exactly what [tb_xgmii_rx_64.v]'s pre-fix line 155 did. *)
let defect_shape_canon_text = "F 0\nW 0f 1 0 0000000000000002\nD 0 accept\n"

(* WO-0046 §4.2, verbatim: "construct a known-good pair, assert agreement;
   perturb exactly one octet, assert the same comparison reports a
   difference and exits nonzero." WO-0049 §5.4 adds a third: a malformed
   canonical file must report the new "could not read" code (3), not be
   comparable at all. All three assertions call [run_comparison] — the exact
   function [main] calls for a real run — against real files on disk, never
   a bespoke in-memory harness that could pass while the production path is
   broken. *)
let self_test () =
  let good_path = Filename.temp_file "cosim_compare_selftest_good" ".canon" in
  let bad_path = Filename.temp_file "cosim_compare_selftest_bad" ".canon" in
  let malformed_path =
    Filename.temp_file "cosim_compare_selftest_malformed" ".canon"
  in
  let cleanup () =
    (try Sys.remove good_path with
     | Sys_error _ -> ());
    (try Sys.remove bad_path with
     | Sys_error _ -> ());
    (try Sys.remove malformed_path with
     | Sys_error _ -> ())
  in
  Fun.protect ~finally:cleanup (fun () ->
    Canonical.write_file good_path (sample_transaction ());
    Canonical.write_file bad_path (perturbed_transaction ());
    (let oc = open_out_bin malformed_path in
     Fun.protect
       ~finally:(fun () -> close_out_noerr oc)
       (fun () -> output_string oc defect_shape_canon_text));
    Printf.printf "compare --self-test: known-good pair (identical canonical files)\n";
    let agree_exit = run_comparison ~ours_path:good_path ~theirs_path:good_path in
    let agree_ok = agree_exit = 0 in
    Printf.printf
      "  %s: identical canonical files compare clean (exit %d)\n"
      (if agree_ok then "PASS" else "FAIL")
      agree_exit;
    Printf.printf
      "compare --self-test: perturbed pair (exactly one octet changed, real files, real production path)\n";
    let differ_exit = run_comparison ~ours_path:good_path ~theirs_path:bad_path in
    let differ_ok = differ_exit <> 0 in
    Printf.printf
      "  %s: a one-octet perturbation is reported and exits nonzero (exit %d)\n"
      (if differ_ok then "PASS" else "FAIL")
      differ_exit;
    Printf.printf
      "compare --self-test: malformed canonical file (16-hex-digit octet token, the exact defect shape of run 30825741565)\n";
    let noverdict_exit =
      run_comparison ~ours_path:good_path ~theirs_path:malformed_path
    in
    let noverdict_ok = noverdict_exit = 3 in
    Printf.printf
      "  %s: a malformed canonical file reports \"could not read\" (exit 3), not a divergence (exit %d)\n"
      (if noverdict_ok then "PASS" else "FAIL")
      noverdict_exit;
    if agree_ok && differ_ok && noverdict_ok
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
  prerr_endline "exit codes: 0 clean, 1 divergence, 2 usage error,";
  prerr_endline "            3 could not read a canonical file (WO-0049 section 5)"
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
