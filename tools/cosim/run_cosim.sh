#!/usr/bin/env bash
# run_cosim.sh — THE ENTRY POINT for the differential co-simulation lane
# (WO-0046, Phase 1). Sequences the three artifacts WO-0046 §2.1 splits across
# two workers into the three checks §4 requires, and owns every byte of
# working-directory hygiene ADR-0015/§7 make hard constraints.
#
# CONTRACT (WO-0046 §2.1, verbatim): "The CI job invokes exactly one command:
# tools/cosim/run_cosim.sh. exit 0 = all three checks passed; nonzero =
# failure, with the failing check named on stdout. No arguments, no
# environment beyond PATH reaching iverilog/vvp and a built dune tree."
#
# ROUND 2 (dv_lead's `RV-0046-VERDICT`, `aa51971`, ACCEPTED): tb_writer's
# `test/cosim/**` landed and was reviewed. Two changes here as a result: (1)
# the sidecar's ownership is now RULED, not assumed — §5 below quotes it in
# full; (2) round 1's calling-convention ASSUMPTION for the four pinned entry
# points is now CONFIRMED (and one bug fixed) by reading the landed sources
# directly — see "THE PINNED ENTRY POINTS" below, which replaces round 1's
# speculative section of the same name.
#
# ROUND 3 (`WO-0049` §8, dv_lead's request, routed by the orchestrator as its
# own packet — see `WO-0049`'s own §8 header: "tb_writer: do not act on this,
# and do not open tools/**"; and `RV-0049-VERDICT` §4's measured addendum on
# that same packet): `test/cosim/compare.ml` gained a new exit code this
# round, `3` = "could not read a canonical file" (a `tb_writer`-scoped fix,
# `WO-0049` §5, ACCEPTED). Two changes here as a result:
#   (1) Check 4.1's mapping of `compare`'s exit code now separates a REAL
#       divergence (compare's own `1` -> `EXIT_DIFFERENTIAL(4)`) from NO
#       VERDICT REACHED AT ALL (compare's own `3` -> the new
#       `EXIT_NO_VERDICT(8)`). Before this round both collapsed onto `4` —
#       exactly the mis-classification `WO-0049` was written about: run
#       `30825741565`'s malformed `theirs.canon` was reported as if it were a
#       differential finding, when nothing had actually been compared.
#   (2) `compare`'s own exit `2` is measured, not assumed, to be AMBIGUOUS —
#       it is `compare.ml`'s usage-error code AND the code OCaml's runtime
#       assigns an uncaught exception (dv_lead, `RV-0049-VERDICT` §4,
#       measured: a bare `failwith` alone exits 2 under the system OCaml
#       toolchain). This script always invokes `compare` with exactly the
#       two required arguments at check 4.1's call site, so its usage branch
#       can never legitimately fire there — an observed `2` is therefore
#       never read as "usage" here. It maps to `EXIT_INTERNAL(9)`, the same
#       code any other code `compare`'s documented contract does not name
#       also gets.
# See "EXIT CODES" below for the full, current table, and "THE PINNED ENTRY
# POINTS" for the compare.exe entry's updated note.
#
# THE THREE CHECKS (WO-0046 §4, order followed exactly)
#
#   4.1  DIFFERENTIAL COMPARISON  — one 64-octet good-FCS frame, lane-0 start,
#        driven into both `Xgmii_rx_64` (ours, via ours_run) and
#        `axis_xgmii_rx_64` (theirs, via the vendored reference under
#        `iverilog`/`vvp`), reduced to canonical transaction files and
#        compared under REQ-901. For the FRAME THIS SCRIPT DRIVES the
#        permitted-divergence set is EMPTY, so any divergence is a defect
#        and `compare` exits nonzero.
#
#        CORRECTED 2026-08-09 (dv_lead, J-dv_lead-0132; CD-xgmii_rx_64_cosim.md
#        §0-ter, the dated annotation beside §0-bis). This comment used to say
#        "For M03 the permitted-divergence set is EMPTY", quoting §0-bis's
#        closing sentence. THAT SENTENCE IS STALE AT THE SCOPE IT IS WRITTEN
#        AT, and this file is where the staleness could do damage rather than
#        merely mislead. REQ-901 gained divergence classes (e) and (f) at the
#        M03 boundary by spec diff at ebb3f49, countersigned:
#
#          (e) `tuser`[0] ALONE is excluded on 5-to-63-octet frames — payload
#              octets and the `tkeep` extent are STILL COMPARED, because the
#              reference's FCS check is a lane-indexed residue array with no
#              length gate, so it strips four octets and delivers length-4
#              exactly as we do. A sub-5-octet frame is excluded entirely,
#              its accept-or-discard included.
#          (f) an over-1518-octet frame is excluded ENTIRELY.
#
#        Both exclude NOTHING in the 64-to-1518-octet range, which is why the
#        statement above is scoped to the frame this script drives (64 octets,
#        inside that range) rather than to "M03". A LATER PHASE THAT DRIVES A
#        RUNT OR AN OVERSIZE FRAME THROUGH THIS SAME SCRIPT MUST NOT READ THE
#        OLD SENTENCE AND ADJUDICATE ITS OWN RESULT AGAINST AN EMPTY SET — for
#        those classes the set is not empty, and a `tuser`[0] difference there
#        is a declared divergence, not a defect. Nothing about the check's
#        MECHANICS changes: `compare` still exits nonzero on any difference it
#        finds, and narrowing that verdict is the reader's job, not this
#        script's.
#   4.2  DELIBERATE-MISMATCH SELF-TEST — `compare --self-test`, in the SAME
#        binary as 4.1, so the self-test exercises the production comparison
#        path rather than a parallel harness that proves nothing about it.
#   4.3  TWO-RUN DETERMINISM — the whole pipeline (ours_run + vvp against the
#        SAME recorded stimulus and the SAME built simulator) runs a second
#        time in this job, and both canonical files (ours.canon, theirs.canon)
#        are diffed byte-for-byte between the two runs. This exercises the
#        "pinned-input reproducibility" guarantee named in ADR-0015 D3 and
#        CD-xgmii_rx_64_cosim.md §4 — explicitly NOT REQ-902, which does not
#        extend to this lane.
#
# ARTIFACT HYGIENE — HARD CONSTRAINTS (WO-0046 §7, ADR-0015 R-CI-1/R-CI-5)
#
#   1. Nothing this script produces — iverilog output, vvp output, the
#      compiled sim binary, the stimulus, the canonical files, their sidecars
#      — is ever written inside the repository checkout. Everything lives
#      under one `mktemp -d`. The one exception, and it is deliberate: `dune
#      build` writes its ordinary `_build/` cache inside the checkout, exactly
#      as every other dune invocation in this programme does. `_build/` is
#      already `.gitignore`d repo-wide and is not one of the artifact classes
#      named in §7.1 (iverilog/vvp output, VCDs, logs, the stimulus, the
#      canonical files, the sidecars) — it is the OCaml toolchain's own
#      standard cache, identical in kind to what `dune build @default`
#      already leaves behind in the main `build` job. Isolating it further
#      would buy nothing the existing `.gitignore` does not already give.
#   2. Cleanup runs via `trap … EXIT`, so it fires on every exit path — the
#      happy path, a `die` call from any of the three checks, and a prereq or
#      build failure alike. A harness that tidies only on success strands
#      artifacts on exactly the runs that matter (§7.2); this one does not.
#   3. On failure, the evidence reaches the log BEFORE cleanup: both
#      canonical files and both sidecars for every run implicated are `cat`
#      to stdout (§7.3), because a divergence nobody can see is a divergence
#      nobody can adjudicate.
#
# THE CANONICAL FORM — this script does not interpret it. It treats
# `ours.canon`/`theirs.canon` as opaque byte streams for the determinism diff,
# and defers ALL comparison semantics to `compare` (tb_writer's deliverable,
# reviewed and ACCEPTED under REQ-901 at RV-0046-VERDICT).
#
# THE SIDECAR — SINGLE WRITER, PLACEHOLDERS BARRED
# (dv_lead's ruling, `RV-0046-VERDICT` §5, ACCEPTED — quoted, not paraphrased,
# where it matters)
#
# `run_cosim.sh` is the sidecar's ONLY writer. Neither OCaml producer
# (`stimulus_gen`, `ours_run`) writes one at all. `tb_xgmii_rx_64.v` (read in
# full before this round) DOES still write its own best-effort
# `theirs.canon.meta` as part of the `vvp` run, with the two fields it
# cannot determine from inside Verilog — simulator version, runner image —
# left as literal `unknown (fill in: …)` text; that is what tb_writer's
# landed code does today, predating dv_lead's ruling. This script does not
# edit that file (`test/**` is outside this agent's write scope) — it
# defeats the placeholder mechanically instead: `write_sidecar` always runs
# AFTER `vvp` and always fully OVERWRITES `<name>.canon.meta` (truncate +
# write, never append or merge), so whatever `tb_xgmii_rx_64.v` wrote there
# is replaced before anything downstream — a comparison, a determinism diff,
# an on-failure dump — ever reads it. The still-placeholder-writing Verilog
# code is flagged in this round's Return log for tb_writer's next round, not
# fixed here.
#
# Placeholders are barred, full stop. dv_lead, verbatim: "An 'unknown (fill
# in:)' marker in an evidence artifact is worse than an absent file — it
# reads as a recorded value, and the reproducibility guarantee's entire
# antecedent is those fields being real." So every REQUIRED field below is
# validated non-empty by `require_field` before ANY sidecar is written, for
# BOTH canonical files, on BOTH runs — a field this script cannot determine
# fails the WHOLE RUN (`EXIT_PROVENANCE`), not a sidecar with a hole in it.
#
# The four REQUIRED fields (the reproducibility guarantee's antecedent,
# ADR-0015 D3 / CD §4), and how each is determined here:
#   reference pin SHA   parsed from test/third_party/verilog-ethernet/
#                        PROVENANCE.md at run time (a repository fact).
#   simulator version    `iverilog -V` AND `vvp -V`, each captured at run
#                        time — only the invoker knows which binaries it
#                        actually invoked.
#   runner image         `$ImageOS`/`$RUNNER_NAME` in CI; a well-defined
#                        LOCAL descriptor otherwise — see next section.
#   stimulus identifier  sha256 of the one `stimulus.txt` both runs share.
# Additionally recorded, best-effort and explicitly NOT gated — advisory
# only, R-CI-3's extra forensic detail, not part of the antecedent above —
# the distro package version via `dpkg-query`. Applying the same "no marker
# that reads as a recorded value" principle to this one non-required field
# too: when `dpkg-query` cannot answer, the key is OMITTED from the sidecar
# entirely, never written with placeholder text.
#
# THE RUNNER-IMAGE FIELD OUTSIDE CI — A DECISION, NOT A GAP
#
# In GitHub Actions, `$ImageOS` (and `$RUNNER_NAME` where present) already
# name the runner image losslessly. Outside CI — a developer running the
# full pipeline locally with a real `iverilog`/`vvp`/`dune` on PATH — there
# is no `$ImageOS`, and the fail-if-undeterminable rule, taken naively, would
# make a local full run permanently unable to pass. That is the wrong
# failure mode: ADR-0015 D1 itself measured that "the local lane is
# genuinely usable" (unlike the OCaml lane, which ADR-0005 blocks), and a
# rule that turns a genuinely runnable local lane into one that can never
# succeed would throw away a finding the programme already paid to
# establish, in the name of a rule aimed at fabricated values, not real
# local ones.
#
# So a local run gets a DIFFERENT, but equally REAL, value:
# `local:<hostname> <uname -srm> [<os-release PRETTY_NAME>]`. This is not a
# placeholder and not a guess — every token is a fact this shell can read
# about the machine it is actually running on, exactly as much a genuine
# runner-image identifier as `$ImageOS` is for a GitHub-hosted one. It is
# composed ONLY from the parts that actually succeed: if `hostname` fails but
# `uname` does not (or vice versa), the field is built from whichever
# succeeded, never padded with an "unknown-host"-shaped filler for the one
# that did not — that would smuggle back exactly the kind of marker this
# whole rule exists to bar, just at one remove. It is `require_field`-checked
# exactly like the CI value: only if EVERY part — `hostname`, `uname` AND
# `/etc/os-release` — comes back empty (a machine broken enough that none of
# them works) is that the genuine "cannot determine" case, and the run fails
# rather than record nothing.
#
# THE PINNED ENTRY POINTS' CALLING CONVENTION — CONFIRMED AGAINST THE LANDED
# `test/cosim/` SOURCES (round 2; round 1 built this section from an
# assumption, flagged as such, before these files existed)
#
#   stimulus_gen.exe   ONE optional positional arg: the output path (default
#                      "stimulus.txt", cwd-relative, if omitted) —
#                      `test/cosim/stimulus_gen.ml`'s own `Sys.argv` match.
#                      This script always passes an explicit absolute path.
#   ours_run.exe       TWO optional positional args, filled left to right:
#                      stimulus path (default "stimulus.txt"), output path
#                      (default "ours.canon") — `ours_run.ml`'s own
#                      `Sys.argv` match; more than two args is a usage error,
#                      exit 2. This script always passes both explicitly.
#   compare.exe        REQUIRES exactly two positional args, `<ours.canon>
#                      <theirs.canon>` — NO default, unlike the other two;
#                      any other argument count (including zero) prints
#                      usage and exits 2 without comparing anything —
#                      `compare.ml`'s own `Sys.argv` match. Round 1 called
#                      this binary with ZERO arguments under the since-
#                      corrected assumption that it would default to
#                      cwd-relative filenames like `ours_run` does; that
#                      would have made check 4.1 exit 2 on every run,
#                      never actually comparing anything. Fixed this round
#                      by reading the real source before landing it.
#                      ROUND 3: `compare.ml` also now documents exit `3`
#                      ("could not read a canonical file", `WO-0049` §5) --
#                      still 0 clean / 1 divergence / 2 usage / 3 no-verdict.
#                      This script's check-4.1 call site always passes
#                      exactly the required two arguments, so `compare`'s own
#                      usage branch (exit 2) can never legitimately fire from
#                      THIS call — see EXIT CODES 9 below for what an
#                      observed 2 here actually means (`WO-0049` §8,
#                      `RV-0049-VERDICT` §4).
#   compare.exe --self-test
#                      exactly one argument, the literal `--self-test`.
#                      Unchanged from round 1's assumption; confirmed.
#   tb_xgmii_rx_64.v   NO argv support at all (Verilog, no `$test$plusargs`
#                      parsing) — it hardcodes `$fopen("stimulus.txt","r")`,
#                      `$fopen("theirs.canon","w")` and
#                      `$fopen("theirs.canon.meta","w")`, all relative to
#                      `vvp`'s cwd at invocation time (the file's own
#                      "WORKING DIRECTORY CONTRACT" comment says exactly
#                      this and names this script as the one responsible
#                      for arranging it). This is the one entry point where
#                      cwd, not an argument, IS the interface, so this
#                      script still `cd`s into the run directory — with a
#                      `stimulus.txt` copied there first — only for the
#                      `vvp` invocation.
#
# THE iverilog INVOCATION (ADR-0015 D1, quoted: "iverilog -o sim … && vvp
# sim") — this script adds no flags beyond `-o` and the source list, on
# purpose: the ADR's own quoted shape is the contract, and inventing a
# generation flag (e.g. `-g2012`) neither pinned by the ADR nor requested by
# tb_writer would be exactly the kind of guess this WO- says not to make. If
# `tb_xgmii_rx_64.v` needs one, that is a one-line change here, flagged back
# through the RV- loop, not a silent addition now.
#
# EXIT CODES — the failing check named on stdout AND encoded in the exit
# code, so CI, a human, and a re-run script can all tell which outcome
# occurred without re-reading the log.
#
# WO-0049 §8 (dv_lead's request; routed here by the orchestrator, ACCEPTED at
# `RV-0049-VERDICT`): the codes below are partitioned along one axis — DID
# THE LANE REACH A VERDICT? `2` (PREREQ), `3` (BUILD) and `8` (NO-VERDICT,
# added this round) mean it did NOT; `4` (DIFFERENTIAL), `5` (SELFTEST) and
# `6` (DETERMINISM) mean it ran to completion and the verdict it reached was
# negative. Conflating the two is the concrete hazard §8 names: "a reader, or
# a future automated gate, sees EXIT_DIFFERENTIAL and reads 'our RTL diverged
# from the MIT reference' — a far more consequential claim than 'our own
# testbench wrote a malformed file'." A broken harness must never be
# reportable as an anchor finding.
#
#   0  PASS         — all three checks (4.1, 4.2, 4.3) passed.
#   2  PREREQ       — iverilog, vvp or dune is not on PATH. The lane DID NOT
#                     RUN. Per ADR-0015 D1's standing rule: "A skipped,
#                     absent or failed-to-install simulator is never a
#                     PASS." This code exists so nothing can read exit-
#                     nonzero-therefore-ran-and-found-a-defect from a run
#                     that never started.
#   3  BUILD /      — TWO STAGE NAMES, ONE CODE (`WO-0073-D5`, repaired
#      PRODUCE        2026-08-10; the code's contract is UNCHANGED and is the
#                     one `WO-0049` §8 accepted). Both mean the lane DID NOT
#                     RUN a comparison, and both are distinguished from PREREQ
#                     because the tools were present. They differ in where they
#                     send the reader, which is the whole of what a label is
#                     for:
#                       BUILD   — `dune build` of the three pinned executables,
#                                 the `iverilog` compile of the testbench +
#                                 vendored reference, or a required source file
#                                 that does not exist. Nothing has run yet.
#                       PRODUCE — one of the pinned executables (stimulus_gen,
#                                 ours_run, or vvp against the compiled
#                                 reference) BUILT, RAN, and then exited
#                                 nonzero or exited 0 without writing the file
#                                 it owed. The build succeeded; a driver did
#                                 not. The line names which producer, which
#                                 side, which run, and which of the two failure
#                                 modes it was.
#                     In both cases the failing command's own output is printed
#                     immediately above the "FAILED CHECK:" line.
#                     WHY THE CODE IS NOT SPLIT TOO: §8's axis is "did the lane
#                     reach a verdict?", both answer no, and the exit-code table
#                     is a contract that went through the RV- loop. A label is
#                     free to become more precise; a code is not.
#   4  DIFFERENTIAL — check 4.1: `compare` REACHED a verdict (its own exit 1)
#                     and it was negative — a real disagreement between the
#                     reference and our implementation. As of WO-0049 §8
#                     (ACCEPTED): a run that did NOT reach a verdict is never
#                     reported under this code, however it failed — see
#                     NO-VERDICT(8) below. (Before this round this code's own
#                     description read "reported a divergence, OR could not
#                     be run to a verdict" — precisely the conflation §8
#                     identifies; that wording is gone.)
#   5  SELFTEST     — check 4.2: `compare --self-test` did not confirm the
#                     production comparator has teeth. `compare`'s own
#                     contract (WO-0049 §5.5, ACCEPTED) guarantees
#                     `--self-test`'s aggregate exit is 0 or 1 only — it must
#                     not return 3 (or 2) as its own result, so this code
#                     carries none of check 4.1's ambiguity.
#   6  DETERMINISM  — check 4.3: the two-run byte-for-byte diff of the
#                     canonical files found a difference.
#   7  PROVENANCE   — a sidecar field the reproducibility guarantee's
#                     antecedent depends on (the reference pin, either
#                     simulator's version, the runner image, or the
#                     stimulus's sha256) could not be determined. dv_lead's
#                     ruling (`RV-0046-VERDICT` §5, ACCEPTED): placeholders
#                     are barred, so an undeterminable REQUIRED field fails
#                     the whole run rather than ship an "unknown (fill
#                     in:)" marker in an evidence artifact. Distinct from
#                     INTERNAL because the three checks' own machinery may
#                     be perfectly fine — only the provenance record is not
#                     attestable, and that is reason enough on its own.
#   8  NO-VERDICT   — check 4.1's `compare` invocation could not reach a
#                     verdict AT ALL: it exited 3, its own documented "could
#                     not read a canonical file" code (WO-0049 §5, ACCEPTED)
#                     — a grammar violation (`Canonical.read`'s `Failure`) or
#                     an I/O failure (`Sys_error`) on either producer's
#                     canonical file. NOT a claim that the reference and our
#                     implementation agree OR disagree — neither was
#                     established. This is precisely the class of failure
#                     WO-0049 itself was written about (run `30825741565`: a
#                     malformed `theirs.canon` was reported as
#                     EXIT_DIFFERENTIAL; this code exists so that never
#                     happens again). Distinct from BUILD(3): BUILD is a
#                     failure BEFORE `compare` is even invoked (dune,
#                     iverilog, or a producer's own nonzero exit or missing
#                     output file); NO-VERDICT is specifically `compare`
#                     having run and declared, in its own words, that it
#                     could not read what it was given.
#   9  INTERNAL     — a machinery problem unrelated to the above (bad
#                     invocation, mktemp failure, a build reported success
#                     but the expected binary is missing) — OR check 4.1's
#                     `compare` exiting an AMBIGUOUS or unrecognized code,
#                     most notably its own `2`. `compare.ml` assigns `2` to a
#                     usage error, but this script always invokes it with
#                     exactly the two required positional arguments at that
#                     call site, so that branch can never legitimately fire
#                     here; an observed `2` is therefore the OCaml runtime's
#                     OWN uncaught-exception exit code, which happens to
#                     collide with the usage code `compare.ml` chose
#                     (dv_lead, `RV-0049-VERDICT` §4, measured: a bare
#                     `failwith` alone exits 2 under the system OCaml
#                     toolchain). A bare `2` cannot distinguish "usage" from
#                     "compare crashed internally", so this script never
#                     guesses which — it reports INTERNAL, never
#                     DIFFERENTIAL and never "usage" (WO-0049 §8).
#
# USAGE
#   tools/cosim/run_cosim.sh        run all three checks, no arguments
#   tools/cosim/run_cosim.sh --help print this header and exit 0

set -uo pipefail

HERE="$(cd "$(dirname "$0")" && pwd)"
REPO="$(cd "$HERE/../.." && pwd)"

DUNE_DIR="test/cosim"
TP_DIR="test/third_party/verilog-ethernet"
PROVENANCE="$REPO/$TP_DIR/PROVENANCE.md"
TB_FILE="$REPO/$DUNE_DIR/tb_xgmii_rx_64.v"
REF_FILE_1="$REPO/$TP_DIR/axis_xgmii_rx_64.v"
REF_FILE_2="$REPO/$TP_DIR/lfsr.v"

STIMULUS_GEN_BIN="$REPO/_build/default/$DUNE_DIR/stimulus_gen.exe"
OURS_RUN_BIN="$REPO/_build/default/$DUNE_DIR/ours_run.exe"
COMPARE_BIN="$REPO/_build/default/$DUNE_DIR/compare.exe"

EXIT_OK=0
EXIT_PREREQ=2
EXIT_BUILD=3
EXIT_DIFFERENTIAL=4
EXIT_SELFTEST=5
EXIT_DETERMINISM=6
EXIT_PROVENANCE=7
EXIT_NO_VERDICT=8
EXIT_INTERNAL=9

say() { printf '%s\n' "$*"; }
hdr() { printf '\n=== %s ===\n' "$*"; }

case "${1:-}" in
  -h | --help)
    sed -n '2,/^set -uo/p' "$0" | sed 's/^# \{0,1\}//;$d'
    exit "$EXIT_OK"
    ;;
esac
if [ "$#" -gt 0 ]; then
  say "run_cosim: unexpected argument(s): $*"
  say "  WO-0046 §2.1: this entry point takes no arguments. Nothing here reads"
  say "  the job's environment beyond PATH; configuration lives in files in the"
  say "  repository, not in argv."
  exit "$EXIT_INTERNAL"
fi

# ------------------------------------------------------------------ #
# working directory — everything this run produces lives here         #
# ------------------------------------------------------------------ #

WORK="$(mktemp -d "${TMPDIR:-/tmp}/run_cosim.XXXXXX")" || {
  say "run_cosim: INTERNAL — mktemp -d failed. Cannot proceed without a"
  say "  working directory outside the checkout (WO-0046 §7.1)."
  exit "$EXIT_INTERNAL"
}
trap 'rm -rf "$WORK"' EXIT

dump_run() {
  # $1 = run directory, $2 = label, for the evidence-on-failure rule (§7.3).
  hdr "EVIDENCE — $2: both canonical files and both sidecars"
  local f
  for f in ours.canon theirs.canon ours.canon.meta theirs.canon.meta; do
    if [ -e "$1/$f" ]; then
      printf -- '--- %s/%s ---\n' "$2" "$f"
      cat "$1/$f"
      printf -- '--- end %s/%s ---\n' "$2" "$f"
    else
      say "  ($2/$f does not exist)"
    fi
  done
}

die() {
  # $1 = exit code, $2 = check name — printed exactly once, so "the failing
  # check named on stdout" (WO-0046 §2.1) is never ambiguous.
  printf '\nrun_cosim: FAILED CHECK: %s\n' "$2"
  exit "$1"
}

produce_reason() {
  # $1 = the producer's exit code, $2 = the output file it owed. Names WHICH of
  # the two PRODUCE failure modes occurred, because they send a reader to
  # different places and the old wording named neither.
  #
  # `WO-0073-D5` (MINOR, against `tools/`, mine; measured `J-dv_lead-0134`,
  # `WO-0073-VERDICT` §10, carrier declared as this round): under IC-L5 the lane
  # printed
  #
  #   Fatal error: exception Failure("ours_run: M03 produced an output word
  #     with no admitted frame open")
  #     ... test/cosim/ours_run.ml, line 119
  #   run_cosim: FAILED CHECK: BUILD (ours_run failed in run1, rc=2)
  #
  # on a run whose build had already printed `dune build: ok` eight lines
  # earlier. The exit CODE was right — 3's contract has always covered "one of
  # the pinned executables ran but did not exit 0", and that contract went
  # through the RV- loop at `WO-0049` §8, so it is not changed here. The LABEL
  # was wrong, and a label is what a reader acts on: "BUILD" sends them to dune
  # and iverilog, and the story was a guard raising inside a driver.
  #
  # Repair: code 3 keeps its meaning and gains a second STAGE NAME. `BUILD` now
  # means compilation and its inputs (dune, iverilog, a missing source file);
  # `PRODUCE` means a pinned executable that BUILT, RAN, and then failed or did
  # not write the file it owed. Same code, same axis (§8: the lane did not reach
  # a verdict), different pointer.
  #
  # The general form: WHERE ONE EXIT CODE COVERS SEVERAL STAGES, THE STAGE MUST
  # BE NAMED IN THE TEXT, BECAUSE THE CODE IS READ BY A MACHINE AND THE TEXT IS
  # READ BY THE PERSON WHO HAS TO FIX IT. Widening a code's contract is free;
  # widening its label silently is how the two drift apart.
  if [ "$1" -ne 0 ]; then
    printf 'ran and exited %d -- the build had already succeeded' "$1"
  else
    printf 'ran and exited 0 but did not write %s' "$2"
  fi
}

require_field() {
  # $1 = human field name, $2 = value. dv_lead's ruling (`RV-0046-VERDICT`
  # §5, ACCEPTED): placeholders are barred. A REQUIRED field this script
  # cannot determine fails the run outright rather than ship an "unknown
  # (fill in:)" marker in an evidence artifact.
  local name="$1" value="$2"
  if [ -z "$value" ]; then
    say "run_cosim: PROVENANCE — required sidecar field could not be determined: $name"
    say "  dv_lead, RV-0046-VERDICT §5: \"An 'unknown (fill in:)' marker in an"
    say "  evidence artifact is worse than an absent file — it reads as a"
    say "  recorded value, and the reproducibility guarantee's entire"
    say "  antecedent is those fields being real.\" This run fails rather than"
    say "  record one."
    die "$EXIT_PROVENANCE" "PROVENANCE (undeterminable field: $name)"
  fi
}

runner_image() {
  # Prints a runner-image identifier and returns 0; prints nothing and
  # returns 1 only if truly nothing is determinable (header note: "THE
  # RUNNER-IMAGE FIELD OUTSIDE CI"). CI is detected by `$ImageOS` (GitHub
  # Actions' own runner-image variable); outside CI, a well-defined LOCAL
  # descriptor is built instead — a real fact about this machine, not a
  # placeholder.
  if [ -n "${ImageOS:-}" ]; then
    if [ -n "${RUNNER_NAME:-}" ]; then
      printf 'ci:%s (%s)' "$ImageOS" "$RUNNER_NAME"
    else
      printf 'ci:%s' "$ImageOS"
    fi
    return 0
  fi
  # Composed ONLY from parts that actually succeeded -- never a placeholder
  # standing in for one that did not. A partial failure (e.g. `hostname`
  # unavailable but `uname` fine) must not embed an "unknown-host"-shaped
  # token into a field this same function's caller then treats as real; that
  # would be exactly the marker-that-reads-as-a-recorded-value dv_lead's
  # ruling bars, self-inflicted. Only if EVERY part is unavailable is the
  # field genuinely undeterminable (returns 1, caller fails via
  # require_field) -- there is no in-between "half-known" value.
  local host unamestr osline parts=""
  host="$(hostname 2>/dev/null)"
  unamestr="$(uname -srm 2>/dev/null)"
  osline=""
  if [ -r /etc/os-release ]; then
    osline="$(sed -n 's/^PRETTY_NAME="\{0,1\}\([^"]*\)"\{0,1\}$/\1/p' /etc/os-release | head -1)"
  fi
  [ -n "$host" ] && parts="$host"
  if [ -n "$unamestr" ]; then
    [ -n "$parts" ] && parts="$parts $unamestr" || parts="$unamestr"
  fi
  if [ -n "$osline" ]; then
    [ -n "$parts" ] && parts="$parts ($osline)" || parts="($osline)"
  fi
  if [ -z "$parts" ]; then
    return 1
  fi
  printf 'local:%s' "$parts"
  return 0
}

# ------------------------------------------------------------------ #
# PREREQUISITES — iverilog, vvp, dune. Absence is never a PASS.        #
# ------------------------------------------------------------------ #

hdr "PREREQUISITES"
PREREQ_MISSING=""
for tool in iverilog vvp dune; do
  if command -v "$tool" >/dev/null 2>&1; then
    say "  [ok]   $tool -> $(command -v "$tool")"
  else
    say "  [FAIL] $tool not found on PATH"
    PREREQ_MISSING="$PREREQ_MISSING $tool"
  fi
done
if [ -n "$PREREQ_MISSING" ]; then
  say ""
  say "  ADR-0015 D1's standing rule: \"A skipped, absent or failed-to-install"
  say "  simulator is never a PASS. No SO- packet may cite a run in which the"
  say "  co-simulation lane did not execute, and a run summary must distinguish"
  say "  *ran and agreed* from *did not run*.\" This is *did not run*: missing"
  say "  tool(s):$PREREQ_MISSING"
  die "$EXIT_PREREQ" "PREREQUISITES (missing:$PREREQ_MISSING)"
fi

# ------------------------------------------------------------------ #
# PROVENANCE — the four REQUIRED sidecar fields, determined once,      #
# validated non-empty once, reused by every sidecar write below.       #
# Placeholders are barred (dv_lead, RV-0046-VERDICT §5): any of these   #
# missing fails the run here, before a single check runs.              #
# ------------------------------------------------------------------ #

hdr "PROVENANCE"

if [ ! -e "$PROVENANCE" ]; then
  say "run_cosim: PROVENANCE — $PROVENANCE does not exist."
  say "  Cannot determine the vendored reference's pinned SHA without it, and"
  say "  a run that cannot determine it must not claim the reproducibility"
  say "  guarantee (dv_lead, RV-0046-VERDICT §5)."
  die "$EXIT_PROVENANCE" "PROVENANCE (missing PROVENANCE.md)"
fi
REF_SHA="$(grep -m1 'Pinned commit SHA' "$PROVENANCE" 2>/dev/null | grep -oE '[0-9a-fA-F]{40}' | head -1)"
require_field "reference_pin_sha" "$REF_SHA"
say "  [ok]   reference pin (from PROVENANCE.md): $REF_SHA"

IVERILOG_VERSION_BANNER="$(iverilog -V 2>&1 | head -1)"
require_field "simulator_iverilog_version" "$IVERILOG_VERSION_BANNER"
say "  [ok]   iverilog: $IVERILOG_VERSION_BANNER"

VVP_VERSION_BANNER="$(vvp -V 2>&1 | head -1)"
require_field "simulator_vvp_version" "$VVP_VERSION_BANNER"
say "  [ok]   vvp: $VVP_VERSION_BANNER"

# Advisory only — NOT gated, NOT part of the reproducibility guarantee's
# antecedent (R-CI-3's extra forensic detail). Left empty, never given
# placeholder text, if dpkg-query cannot answer (e.g. iverilog was not
# apt-installed, or this is not a Debian-derived system); write_sidecar
# omits the key entirely in that case rather than write one.
IVERILOG_PKG_VERSION="$(dpkg-query -W -f='${Version}' iverilog 2>/dev/null)"
say "  [--]   iverilog package version (advisory, not gated): ${IVERILOG_PKG_VERSION:-not available}"

RUNNER_IMAGE="$(runner_image)" || RUNNER_IMAGE=""
require_field "runner_image" "$RUNNER_IMAGE"
say "  [ok]   runner image: $RUNNER_IMAGE"

write_sidecar() {
  # $1 = path to write, $2 = canon_role (ours|theirs), $3 = run_label.
  # SINGLE WRITER (RV-0046-VERDICT §5, ACCEPTED): always called AFTER both
  # producers for a run have finished, and always FULLY OVERWRITES $1
  # (truncate + write via `>`, never append) — see the header note on
  # tb_xgmii_rx_64.v's own still-present placeholder-writing code, which
  # this defeats mechanically rather than by editing test/**. Every
  # REQUIRED field below was validated non-empty by require_field before
  # this function was ever reachable; none is a placeholder.
  {
    printf '# provenance sidecar — NEVER compared (WO-0046 §2.3). Sole writer:\n'
    printf '# tools/cosim/run_cosim.sh (dv_lead ruling, RV-0046-VERDICT §5, ACCEPTED).\n'
    printf 'canon_role=%s\n' "$2"
    printf 'run_label=%s\n' "$3"
    printf 'reference_repo=https://github.com/alexforencich/verilog-ethernet\n'
    printf 'reference_pin_sha=%s\n' "$REF_SHA"
    printf 'reference_files=axis_xgmii_rx_64.v,lfsr.v (test/third_party/verilog-ethernet/, verbatim, ADR-0015 D2)\n'
    printf 'simulator_iverilog_version=%s\n' "$IVERILOG_VERSION_BANNER"
    printf 'simulator_vvp_version=%s\n' "$VVP_VERSION_BANNER"
    if [ -n "$IVERILOG_PKG_VERSION" ]; then
      printf 'simulator_package_version_advisory=%s\n' "$IVERILOG_PKG_VERSION"
    fi
    printf 'runner_image=%s\n' "$RUNNER_IMAGE"
    printf 'stimulus_sha256=%s\n' "$STIMULUS_SHA"
  } >"$1"
}

# ------------------------------------------------------------------ #
# BUILD — the three OCaml executables, and the reference simulator    #
# ------------------------------------------------------------------ #

hdr "BUILD"
say "  dune build (writes to $REPO/_build/, gitignored — see header note)"
BUILD_OUT="$(cd "$REPO" && dune build \
  "$DUNE_DIR/stimulus_gen.exe" "$DUNE_DIR/ours_run.exe" "$DUNE_DIR/compare.exe" 2>&1)"
BUILD_RC=$?
if [ "$BUILD_RC" -ne 0 ]; then
  say "$BUILD_OUT"
  die "$EXIT_BUILD" "BUILD (dune build failed, rc=$BUILD_RC)"
fi
for bin in "$STIMULUS_GEN_BIN" "$OURS_RUN_BIN" "$COMPARE_BIN"; do
  if [ ! -x "$bin" ]; then
    say "run_cosim: INTERNAL — dune build reported success but $bin is not executable."
    die "$EXIT_INTERNAL" "INTERNAL (expected executable missing: $bin)"
  fi
done
say "  dune build: ok — stimulus_gen.exe, ours_run.exe, compare.exe"

for f in "$TB_FILE" "$REF_FILE_1" "$REF_FILE_2"; do
  if [ ! -e "$f" ]; then
    say "run_cosim: BUILD — required source file does not exist: $f"
    die "$EXIT_BUILD" "BUILD (missing source: $f)"
  fi
done
SIMBIN="$WORK/sim"
IVERILOG_OUT="$(iverilog -o "$SIMBIN" "$TB_FILE" "$REF_FILE_1" "$REF_FILE_2" 2>&1)"
IVERILOG_RC=$?
if [ "$IVERILOG_RC" -ne 0 ]; then
  say "$IVERILOG_OUT"
  die "$EXIT_BUILD" "BUILD (iverilog compile failed, rc=$IVERILOG_RC)"
fi
[ -n "$IVERILOG_OUT" ] && say "$IVERILOG_OUT"
say "  iverilog compile: ok -> $SIMBIN"

# ------------------------------------------------------------------ #
# STIMULUS — generated once, the SAME recorded stimulus reused by      #
# both runs (the determinism guarantee's antecedent names "the         #
# recorded stimulus", singular — not "a freshly generated one").       #
# ------------------------------------------------------------------ #

hdr "STIMULUS (recorded once, WO-0046 §3: one 64-octet good-FCS frame, lane-0 start)"
mkdir -p "$WORK/stim"
# stimulus_gen.ml: one optional positional arg, the output path (confirmed
# against the landed source — see header). Passed explicitly, absolute, so
# no cwd juggling is needed for this call at all.
STIM_OUT="$("$STIMULUS_GEN_BIN" "$WORK/stim/stimulus.txt" 2>&1)"
STIM_RC=$?
if [ "$STIM_RC" -ne 0 ] || [ ! -e "$WORK/stim/stimulus.txt" ]; then
  say "$STIM_OUT"
  # PRODUCE, not BUILD: stimulus_gen compiled (the BUILD block above printed
  # `dune build: ok`) and then failed at run time — `WO-0073-D5`, see
  # produce_reason's note. Its most likely raise is its own `Arrival.check`
  # assertion, which is a stimulus defect and not a compilation one.
  die "$EXIT_BUILD" "PRODUCE (stimulus_gen: $(produce_reason "$STIM_RC" "$WORK/stim/stimulus.txt"))"
fi
[ -n "$STIM_OUT" ] && say "$STIM_OUT"
STIMULUS_SHA="$(sha256sum "$WORK/stim/stimulus.txt" | cut -d' ' -f1)"
require_field "stimulus_sha256" "$STIMULUS_SHA"
say "  [ok]   stimulus.txt sha256: $STIMULUS_SHA"

run_pipeline() {
  # $1 = run directory (created by the caller). Drives our side with
  # explicit absolute paths (ours_run.ml takes two optional positional
  # args, confirmed against the landed source), then drives the reference
  # side via vvp, which has NO argv support at all and hardcodes
  # "stimulus.txt"/"theirs.canon"/"theirs.canon.meta" relative to its own
  # cwd (tb_xgmii_rx_64.v's own "WORKING DIRECTORY CONTRACT" comment) — so
  # only that invocation needs a cwd change and a copied-in stimulus file.
  # Writes both sidecars last, overwriting whatever tb_xgmii_rx_64.v wrote.
  local dir="$1" label="$2" out rc

  out="$("$OURS_RUN_BIN" "$WORK/stim/stimulus.txt" "$dir/ours.canon" 2>&1)"
  rc=$?
  if [ "$rc" -ne 0 ] || [ ! -e "$dir/ours.canon" ]; then
    say "$out"
    die "$EXIT_BUILD" "PRODUCE (ours_run, our side, $label: $(produce_reason "$rc" "$dir/ours.canon"))"
  fi
  [ -n "$out" ] && say "  [$label] ours_run: $out"

  cp "$WORK/stim/stimulus.txt" "$dir/stimulus.txt"
  out="$(cd "$dir" && vvp "$SIMBIN" 2>&1)"
  rc=$?
  if [ "$rc" -ne 0 ] || [ ! -e "$dir/theirs.canon" ]; then
    say "$out"
    die "$EXIT_BUILD" "PRODUCE (vvp, the reference side, $label: $(produce_reason "$rc" "$dir/theirs.canon"))"
  fi
  [ -n "$out" ] && say "  [$label] vvp: $out"

  write_sidecar "$dir/ours.canon.meta" ours "$label"
  write_sidecar "$dir/theirs.canon.meta" theirs "$label"
}

# ------------------------------------------------------------------ #
# CHECK 1/3 — DIFFERENTIAL COMPARISON (§4.1)                          #
# ------------------------------------------------------------------ #

hdr "CHECK 1/3 — DIFFERENTIAL COMPARISON (WO-0046 §4.1)"
mkdir -p "$WORK/run1"
run_pipeline "$WORK/run1" "run1"

# compare.ml REQUIRES exactly two positional args -- no cwd-default, unlike
# ours_run (confirmed against the landed source; see header). Round 1 called
# this with zero arguments under the assumption it defaulted like ours_run
# does; it does not, and that call would always have hit compare's own
# usage branch (exit 2) without comparing anything. Fixed in round 2.
DIFF_OUT="$("$COMPARE_BIN" "$WORK/run1/ours.canon" "$WORK/run1/theirs.canon" 2>&1)"
DIFF_RC=$?
say "$DIFF_OUT"

# ROUND 3 (WO-0049 §8, ACCEPTED at RV-0049-VERDICT): classify compare's exit
# code along the "did the lane reach a verdict?" axis instead of collapsing
# every nonzero onto EXIT_DIFFERENTIAL(4). compare's own contract
# (test/cosim/compare.ml, WO-0049 §5): 0 clean, 1 divergence, 2 usage error,
# 3 could not read a canonical file (no verdict reached at all). This call
# site always passes exactly the two required positional arguments above, so
# compare's own usage branch can NEVER legitimately fire here -- an observed
# 2 is therefore never "usage"; it is the OCaml runtime's OWN
# uncaught-exception exit code, which happens to collide with the usage code
# compare.ml chose (dv_lead, RV-0049-VERDICT §4, measured: a bare `failwith`
# alone exits 2 under the system OCaml toolchain). A bare 2 cannot
# distinguish "usage" from "compare crashed internally", so this script
# never guesses which -- an unrecognized/ambiguous code (2, or anything else
# outside {0,1,3}) is fail-closed as INTERNAL(9), never as DIFFERENTIAL(4)
# and never read as "usage".
case "$DIFF_RC" in
  0)
    say "  CHECK 1/3: PASSED"
    ;;
  1)
    # A verdict WAS reached, and it was negative: compare actually read and
    # compared both canonical files and found a real divergence.
    dump_run "$WORK/run1" "run1"
    die "$EXIT_DIFFERENTIAL" "DIFFERENTIAL COMPARISON (compare reported a divergence, exit 1)"
    ;;
  3)
    # NO VERDICT: compare could not even read one of the two canonical
    # files (a grammar violation or an I/O failure -- WO-0049 §5). This is
    # NOT a claim that the reference and our implementation agree or
    # disagree -- neither was established. WO-0049 §8: "a broken harness
    # must never be reportable as an anchor finding" -- this is the class
    # that keeps that claim from ever being made under DIFFERENTIAL's name
    # again (run 30825741565 is the case this exists for).
    dump_run "$WORK/run1" "run1"
    die "$EXIT_NO_VERDICT" "NO-VERDICT (compare could not read a canonical file, exit 3)"
    ;;
  *)
    # Ambiguous or unrecognized -- most notably compare's own 2, which this
    # call site's fixed, always-correct two-argument invocation can never
    # legitimately produce via compare's usage branch (see the comment
    # above). Fails closed as INTERNAL rather than guessing which of
    # "usage" or "compare crashed internally" occurred.
    dump_run "$WORK/run1" "run1"
    die "$EXIT_INTERNAL" "INTERNAL (compare exited ambiguous/unrecognized code $DIFF_RC)"
    ;;
esac

# ------------------------------------------------------------------ #
# CHECK 2/3 — DELIBERATE-MISMATCH SELF-TEST (§4.2)                    #
# ------------------------------------------------------------------ #

hdr "CHECK 2/3 — DELIBERATE-MISMATCH SELF-TEST (WO-0046 §4.2)"
SELFTEST_OUT="$("$COMPARE_BIN" --self-test 2>&1)"
SELFTEST_RC=$?
say "$SELFTEST_OUT"
if [ "$SELFTEST_RC" -ne 0 ]; then
  die "$EXIT_SELFTEST" "SELF-TEST (compare --self-test exited $SELFTEST_RC)"
fi
say "  CHECK 2/3: PASSED — the production comparison path was confirmed to"
say "  report a difference when one is seeded, via the same binary as check 1."

# ------------------------------------------------------------------ #
# CHECK 3/3 — TWO-RUN DETERMINISM (§4.3)                              #
# ------------------------------------------------------------------ #

hdr "CHECK 3/3 — TWO-RUN DETERMINISM (WO-0046 §4.3 / ADR-0015 D3)"
mkdir -p "$WORK/run2"
run_pipeline "$WORK/run2" "run2"

DET_STATUS=0
OURS_DIFF="$(diff -u "$WORK/run1/ours.canon" "$WORK/run2/ours.canon" 2>&1)" || DET_STATUS=1
THEIRS_DIFF="$(diff -u "$WORK/run1/theirs.canon" "$WORK/run2/theirs.canon" 2>&1)" || DET_STATUS=1

if [ "$DET_STATUS" -ne 0 ]; then
  say "  ours.canon differs between run1 and run2:"
  say "$OURS_DIFF"
  say "  theirs.canon differs between run1 and run2:"
  say "$THEIRS_DIFF"
  dump_run "$WORK/run1" "run1"
  dump_run "$WORK/run2" "run2"
  die "$EXIT_DETERMINISM" "DETERMINISM (canonical files differ between run1 and run2)"
fi
say "  ours.canon:   byte-identical between run1 and run2"
say "  theirs.canon: byte-identical between run1 and run2"
say "  CHECK 3/3: PASSED"

# ------------------------------------------------------------------ #
# SUMMARY                                                              #
# ------------------------------------------------------------------ #

hdr "SUMMARY"
say "  run_cosim: ALL THREE CHECKS PASSED"
say "  reference pin: $REF_SHA"
say "  simulator: $IVERILOG_VERSION_BANNER / $VVP_VERSION_BANNER"
say "  runner image: $RUNNER_IMAGE"
say "  stimulus sha256: $STIMULUS_SHA"
exit "$EXIT_OK"
