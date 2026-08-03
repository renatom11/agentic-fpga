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
                                            [class_of]).
     compare --self-test                   WO-0046 §4.2's deliberate-mismatch
                                            check, through this same
                                            production path (below).

   Plain stdlib OCaml — no Base, no Hardcaml. This binary is meant to build
   and run in any environment with a working OCaml toolchain, independent of
   whether iverilog is present (WO-0046 §2.2). *)

(* The one path every real run and the self-test both go through: read two
   canonical files, run REQ-901's comparison, print its report, return the
   exit code [compare]'s own contract promises. *)
let run_comparison ~ours_path ~theirs_path =
  let ours = Canonical.read_file ours_path in
  let theirs = Canonical.read_file theirs_path in
  let report = Canonical.compare_transactions ~ours ~theirs in
  print_string (Canonical.report_to_string report);
  if Canonical.is_clean report then 0 else 1
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

(* WO-0046 §4.2, verbatim: "construct a known-good pair, assert agreement;
   perturb exactly one octet, assert the same comparison reports a
   difference and exits nonzero." Both assertions call [run_comparison] —
   the exact function [main] calls for a real run — against real files on
   disk, never a bespoke in-memory harness that could pass while the
   production path is broken. *)
let self_test () =
  let good_path = Filename.temp_file "cosim_compare_selftest_good" ".canon" in
  let bad_path = Filename.temp_file "cosim_compare_selftest_bad" ".canon" in
  let cleanup () =
    (try Sys.remove good_path with
     | Sys_error _ -> ());
    (try Sys.remove bad_path with
     | Sys_error _ -> ())
  in
  Fun.protect ~finally:cleanup (fun () ->
    Canonical.write_file good_path (sample_transaction ());
    Canonical.write_file bad_path (perturbed_transaction ());
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
    if agree_ok && differ_ok
    then (
      Printf.printf "compare --self-test: OK\n";
      0)
    else (
      Printf.printf "compare --self-test: FAILED\n";
      1))
;;

let usage () =
  prerr_endline "usage: compare <ours.canon> <theirs.canon>";
  prerr_endline "       compare --self-test"
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
