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
# THE THREE CHECKS (WO-0046 §4, order followed exactly)
#
#   4.1  DIFFERENTIAL COMPARISON  — one 64-octet good-FCS frame, lane-0 start,
#        driven into both `Xgmii_rx_64` (ours, via ours_run) and
#        `axis_xgmii_rx_64` (theirs, via the vendored reference under
#        `iverilog`/`vvp`), reduced to canonical transaction files and
#        compared under REQ-901. For M03 the permitted-divergence set is
#        EMPTY (CD-xgmii_rx_64_cosim.md §0-bis) — any divergence is a defect
#        and `compare` exits nonzero.
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
# THE CANONICAL FORM AND THE SIDECAR (WO-0046 §2.3) — this script does not
# interpret either. It treats `ours.canon`/`theirs.canon` as opaque byte
# streams for the determinism diff, and defers ALL comparison semantics to
# `compare` (tb_writer's deliverable, reviewed under REQ-901). The one thing
# this script DOES own is the sidecar: `<name>.canon.meta`, written here,
# never inside a compared file, carrying exactly what R-CI-3/ADR-0015 D3 name
# — the vendored reference's pinned SHA, the simulator's version (banner +
# distro package version), a best-effort runner-image identifier, and the
# stimulus's sha256 — so the reproducibility guarantee's antecedent is
# checkable rather than asserted.
#
# WHAT THIS SCRIPT ASSUMES ABOUT THE PINNED ENTRY POINTS — NOT PINNED BY THE
# PACKET, SO IT IS DOCUMENTED HERE AND IN THE RETURN LOG, NOT GUESSED SILENTLY
#
# WO-0046 §2.1 pins the FILE NAMES (`stimulus_gen.ml`, `ours_run.ml`,
# `compare.ml`, `tb_xgmii_rx_64.v`) and §2 pins the FILE-BASED SHAPE of the
# bridge (a stimulus file in, canonical files out), but it does not pin an
# argv/CLI contract for the three OCaml executables or a filename contract for
# the Verilog testbench's I/O. This script commits to the SMALLEST such
# contract, matching this repository's existing zero-argument idiom
# (`bin/generate.exe` takes no arguments and writes fixed, relative paths):
#
#   stimulus_gen.exe   no arguments. Writes `./stimulus.txt` (cwd-relative).
#   ours_run.exe       no arguments. Reads `./stimulus.txt`, writes
#                      `./ours.canon` (both cwd-relative).
#   compare.exe        no arguments. Reads `./ours.canon` and `./theirs.canon`
#                      (cwd-relative), prints REQ-901's report to stdout, exit
#                      0 = no divergence, nonzero = a divergence (or a
#                      malformed input — both are failures of check 4.1).
#   compare.exe --self-test
#                      no other arguments. Exit 0 = the production comparison
#                      path was confirmed to have teeth; nonzero = it was not.
#   tb_xgmii_rx_64.v   reads `./stimulus.txt`, writes `./theirs.canon` (both
#                      cwd-relative), mirroring the OCaml side exactly so the
#                      harness controls every path by controlling cwd alone.
#
# This script places each invocation's cwd itself — never a CLI flag — so
# every one of the four programs lands its I/O inside the current `mktemp -d`
# run directory with no path ever named on their command line. If tb_writer's
# actual executables want a different contract, only the four invocation
# sites below (marked INTERFACE) need to change; the sequencing, hygiene and
# exit-code logic around them do not.
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
# code, so CI, a human, and a re-run script can all tell which of the four
# possible outcomes occurred without re-reading the log:
#
#   0  PASS        — all three checks (4.1, 4.2, 4.3) passed.
#   2  PREREQ      — iverilog, vvp or dune is not on PATH. The lane DID NOT
#                    RUN. Per ADR-0015 D1's standing rule: "A skipped, absent
#                    or failed-to-install simulator is never a PASS." This
#                    code exists so nothing can read exit-nonzero-therefore-
#                    ran-and-found-a-defect from a run that never started.
#   3  BUILD       — `dune build` of the three pinned executables, or the
#                    `iverilog` compile of the testbench + vendored reference,
#                    failed; or one of the pinned executables (stimulus_gen,
#                    ours_run, vvp against the compiled reference) ran but did
#                    not exit 0 / did not produce its named output file. Also
#                    DID NOT RUN a comparison, but distinguished from PREREQ
#                    because the tools were present and something else (a
#                    missing file, a syntax error, a driver crash) is the
#                    story — the failing command's own output is printed
#                    immediately above the "FAILED CHECK: BUILD" line.
#   4  DIFFERENTIAL — check 4.1: `compare` reported a divergence, or could not
#                    be run to a verdict.
#   5  SELFTEST    — check 4.2: `compare --self-test` did not confirm the
#                    production comparator has teeth.
#   6  DETERMINISM — check 4.3: the two-run byte-for-byte diff of the
#                    canonical files found a difference.
#   9  INTERNAL    — a machinery problem unrelated to the three checks (bad
#                    invocation, unparseable PROVENANCE.md, mktemp failure).
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
# provenance inputs — read once, used by every sidecar below           #
# ------------------------------------------------------------------ #

if [ ! -e "$PROVENANCE" ]; then
  say "run_cosim: INTERNAL — $PROVENANCE does not exist."
  say "  Cannot record the vendored reference's pin in the sidecar without it."
  die "$EXIT_INTERNAL" "INTERNAL (missing PROVENANCE.md)"
fi
REF_SHA="$(grep -m1 'Pinned commit SHA' "$PROVENANCE" 2>/dev/null | grep -oE '[0-9a-fA-F]{40}' | head -1)"
if [ -z "$REF_SHA" ]; then
  say "run_cosim: INTERNAL — could not extract a 40-hex pinned commit SHA from"
  say "  $PROVENANCE."
  die "$EXIT_INTERNAL" "INTERNAL (unparseable PROVENANCE.md)"
fi
say "  reference pin (from PROVENANCE.md): $REF_SHA"

IVERILOG_VERSION_BANNER="$(iverilog -V 2>&1 | head -1)"
IVERILOG_PKG_VERSION="$(dpkg-query -W -f='${Version}' iverilog 2>/dev/null)"
if [ -z "$IVERILOG_PKG_VERSION" ]; then
  IVERILOG_PKG_VERSION="unknown (dpkg-query unavailable, or iverilog was not apt-installed)"
fi
RUNNER_IMAGE="${ImageOS:-${RUNNER_NAME:-unidentified}} ($(uname -srm 2>/dev/null))"
say "  simulator: $IVERILOG_VERSION_BANNER"
say "  simulator package version: $IVERILOG_PKG_VERSION"
say "  runner image (best effort): $RUNNER_IMAGE"

write_sidecar() {
  # $1 = path to write, $2 = canon_role (ours|theirs), $3 = run_label
  {
    printf '# provenance sidecar — NEVER compared (WO-0046 §2.3 / ADR-0015 D3)\n'
    printf 'canon_role=%s\n' "$2"
    printf 'run_label=%s\n' "$3"
    printf 'reference_repo=https://github.com/alexforencich/verilog-ethernet\n'
    printf 'reference_pin_sha=%s\n' "$REF_SHA"
    printf 'reference_files=axis_xgmii_rx_64.v,lfsr.v (test/third_party/verilog-ethernet/, verbatim, ADR-0015 D2)\n'
    printf 'simulator=iverilog\n'
    printf 'simulator_version_banner=%s\n' "$IVERILOG_VERSION_BANNER"
    printf 'simulator_package_version=%s\n' "$IVERILOG_PKG_VERSION"
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
    die "$EXIT_BUILD" "BUILD (expected executable missing: $bin)"
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
STIM_OUT="$(cd "$WORK/stim" && "$STIMULUS_GEN_BIN" 2>&1)"   # INTERFACE: no-arg, writes ./stimulus.txt
STIM_RC=$?
if [ "$STIM_RC" -ne 0 ] || [ ! -e "$WORK/stim/stimulus.txt" ]; then
  say "$STIM_OUT"
  die "$EXIT_BUILD" "BUILD (stimulus_gen failed, rc=$STIM_RC)"
fi
[ -n "$STIM_OUT" ] && say "$STIM_OUT"
STIMULUS_SHA="$(sha256sum "$WORK/stim/stimulus.txt" | cut -d' ' -f1)"
say "  stimulus.txt sha256: $STIMULUS_SHA"

run_pipeline() {
  # $1 = run directory (created by the caller). Copies in the recorded
  # stimulus, drives our side and the reference side from that same cwd
  # (INTERFACE: both sides read ./stimulus.txt and write their own
  # ./{ours,theirs}.canon), and writes both sidecars. Does not compare —
  # that is the caller's job, per which check is running.
  local dir="$1" label="$2" out rc
  cp "$WORK/stim/stimulus.txt" "$dir/stimulus.txt"

  out="$(cd "$dir" && "$OURS_RUN_BIN" 2>&1)"
  rc=$?
  if [ "$rc" -ne 0 ] || [ ! -e "$dir/ours.canon" ]; then
    say "$out"
    die "$EXIT_BUILD" "BUILD (ours_run failed in $label, rc=$rc)"
  fi
  [ -n "$out" ] && say "  [$label] ours_run: $out"

  out="$(cd "$dir" && vvp "$SIMBIN" 2>&1)"
  rc=$?
  if [ "$rc" -ne 0 ] || [ ! -e "$dir/theirs.canon" ]; then
    say "$out"
    die "$EXIT_BUILD" "BUILD (vvp failed in $label, rc=$rc)"
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

DIFF_OUT="$(cd "$WORK/run1" && "$COMPARE_BIN" 2>&1)"   # INTERFACE: no-arg, reads ./{ours,theirs}.canon
DIFF_RC=$?
say "$DIFF_OUT"
if [ "$DIFF_RC" -ne 0 ]; then
  dump_run "$WORK/run1" "run1"
  die "$EXIT_DIFFERENTIAL" "DIFFERENTIAL COMPARISON (compare exited $DIFF_RC)"
fi
say "  CHECK 1/3: PASSED"

# ------------------------------------------------------------------ #
# CHECK 2/3 — DELIBERATE-MISMATCH SELF-TEST (§4.2)                    #
# ------------------------------------------------------------------ #

hdr "CHECK 2/3 — DELIBERATE-MISMATCH SELF-TEST (WO-0046 §4.2)"
mkdir -p "$WORK/selftest"
SELFTEST_OUT="$(cd "$WORK/selftest" && "$COMPARE_BIN" --self-test 2>&1)"
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
say "  simulator: $IVERILOG_VERSION_BANNER ($IVERILOG_PKG_VERSION)"
say "  stimulus sha256: $STIMULUS_SHA"
exit "$EXIT_OK"
