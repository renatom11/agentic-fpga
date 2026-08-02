#!/usr/bin/env bash
# dv_checks.sh — run every DV mechanical check in one command.
#
# These are the checks that are neither simulations nor expect tests: they
# compare committed text against committed text (carry-forward C-9) and
# committed text against the emitted-Verilog build product (finding X-9).
# They are pure bash + awk + sed, they take well under a second, and — unlike
# every other DV artefact in this programme — they are runnable in the
# development container, because ADR-0005's blocker is the OCaml toolchain and
# not the shell.
#
#   tools/check_records_vs_appendix.sh   C-9: Status vs §12, Config vs §9.1,
#                                        each spec §4.1 vs its ifc_check lift,
#                                        the DV strobe list vs §12
#   tools/check_emitted_verilog.sh       X-9: REQ-001, REQ-017, REQ-018,
#                                        REQ-306, REQ-808, REQ-903 (the last
#                                        landed at WO-0012, once C-8's closure
#                                        gave its M01 half a determinable
#                                        answer)
#
# CI WIRING — the decision WO-0009 asked to be documented either way.
#
# Recommendation: wire this script into .github/workflows/build.yml as one
# step. It is trivially cheap (sub-second, no dependencies beyond coreutils),
# it guards normative text that drifts silently, and REQ-904 already
# establishes the precedent that a currency check belongs in CI rather than at
# a gate. The step is:
#
#     - name: DV mechanical checks (C-9 record-vs-appendix, X-9 emitted Verilog)
#       run: tools/dv_checks.sh
#
# It is NOT wired here, for two reasons rather than one. First, .github/** is
# the orchestrator's write scope (PROTOCOL §6) and dv_lead cannot stage it, so
# the edit is the orchestrator's to make. Second, the alternative available
# inside my own scope — a dune rule on the runtest alias under test/ — was
# considered and rejected: a dune action runs inside _build, where only files
# some rule depends on are present, so the script would need file-level deps on
# docs/specs/** and rtl_snapshots/**, and a mistake there fails the whole build
# in a way ADR-0005 leaves me unable to test locally. A one-line workflow step
# has none of that risk.
#
# Until the step lands, these checks run on demand and are cited by SHA in
# sign-off packets and journal Evidence sections.
#
# Usage: tools/dv_checks.sh
# Exit:  0 iff every check passes. PENDING lines never fail the run, and no
#        sign-off packet may cite a PENDING line as coverage.

set -uo pipefail

HERE="$(cd "$(dirname "$0")" && pwd)"
status=0

for script in check_records_vs_appendix.sh check_emitted_verilog.sh; do
  printf '=== %s ===\n' "$script"
  if bash "$HERE/$script"; then
    printf '=== %s: OK ===\n\n' "$script"
  else
    printf '=== %s: FAILED ===\n\n' "$script"
    status=1
  fi
done

if [ "$status" -eq 0 ]; then
  printf 'dv_checks: all checks passed\n'
else
  printf 'dv_checks: at least one check FAILED\n'
fi
exit "$status"
