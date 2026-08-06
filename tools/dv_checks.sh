#!/usr/bin/env bash
# dv_checks.sh — run every DV mechanical check in one command.
#
# These are the checks that are neither simulations nor expect tests: they
# compare committed text against committed text (carry-forward C-9), committed
# text against the emitted-Verilog build product (finding X-9), committed
# OCaml against the system compiler (WO-0034), and a committed constant
# against the published standard it claims to quote (WO-0034). They are pure
# bash + awk + sed + ocamlc + curl, and — unlike every other DV artefact in
# this programme — they are runnable in the development container, because
# ADR-0005's blocker is the Hardcaml toolchain and not the shell, and not the
# system compiler either (J-dv_lead-0018's discovery).
#
#   tools/check_records_vs_appendix.sh   C-9: Status vs §12, Config vs §9.1,
#                                        each spec §4.1 vs its ifc_check lift,
#                                        the DV strobe list vs §12
#   tools/check_emitted_verilog.sh       X-9 self-test first (REQ-001 fixtures,
#                                        WO-0028: the negative cases a clean
#                                        snapshot can never exercise), then
#                                        X-9: REQ-001, REQ-017, REQ-018,
#                                        REQ-306, REQ-808, REQ-903 (the last
#                                        landed at WO-0012, once C-8's closure
#                                        gave its M01 half a determinable
#                                        answer)
#   tools/precompile_check.sh            WO-0034: type-check the DV OCaml tree
#                                        with the system ocamlc. Stands down
#                                        automatically where the real
#                                        toolchain is present, because
#                                        `dune build @default` dominates it.
#   tools/check_rfc1071_anchor.sh        WO-0034: confirm
#                                        Ipv4_ref.rfc1071_example_{octets,sum,
#                                        checksum} against RFC 1071 §3's own
#                                        text — the anchor obligation
#                                        SO-ip_eth_rx_64.md carries.
#
# CI WIRING — settled, and this is why the two WO-0034 checks live here.
#
# build.yml runs `tools/dv_checks.sh` as a step (added by the orchestrator
# after WO-0009 recommended it; .github/** is not dv_lead's to stage,
# PROTOCOL §6). That makes this script the DV line's own seam into CI: a
# check added here reaches the runner with no workflow edit and no
# orchestrator round trip, and the auditor re-executes the whole set with one
# command at any SHA. Both WO-0034 checks are therefore wired here rather
# than requested as new workflow steps.
#
# STRICTNESS IS NOT UNIFORM, AND THE ASYMMETRY IS DELIBERATE.
#
# The two environments differ in what a failure MEANS:
#
#   precompile_check.sh   In the development container it is the only compiler
#                         evidence available, so it runs and it gates. On the
#                         runner the real toolchain is installed, so the script
#                         itself stands down (its GATE 2) and prints why —
#                         running a stub-based check beside the authoritative
#                         build could only produce a weaker signal or a false
#                         alarm the programme would learn to ignore.
#
#   check_rfc1071_anchor  A blocked fetch means opposite things in the two
#                         places. Here, five 403s across two egress paths are
#                         already on the record (J-dv_lead-0017, J-dv_lead-0018,
#                         the WO-0033 acceptance block) — a sixth is not news,
#                         and letting it redden every local run would train the
#                         reader to ignore this script. On the runner, whose
#                         egress is open, a 403 IS news: it means the one
#                         cheap closure named for this obligation does not
#                         work either, and that must be loud. So the script is
#                         always invoked in its STRICT form and this file
#                         interprets its exit 2 ("obligation open") by
#                         environment — visibly, in the log, rather than by
#                         passing a flag that would let a reader mistake
#                         "could not check" for "checked and fine". Neither
#                         path can pass vacuously: "confirmed" is printed only
#                         after fetched text has been matched, and an
#                         OBLIGATION-OPEN line is never coverage.
#
# Usage: tools/dv_checks.sh
# Exit:  0 iff every check passes. PENDING lines, and any check that
#        announced SKIPPED or OBLIGATION OPEN, never count as coverage and no
#        sign-off packet may cite one.

set -uo pipefail

HERE="$(cd "$(dirname "$0")" && pwd)"
status=0
open_obligation=0

# ---- self-tests first ------------------------------------------------
#
# Three instruments in this suite judge committed artefacts, and a rule whose
# teeth are never exercised can be blunted by a well-meaning simplification
# without anything going red. Each therefore proves it can still fail before
# it is allowed to say anything passed.
#
#  * check_emitted_verilog --self-test (WO-0028): rtl_snapshots/ will — if the
#    design is right — never contain a gated clock, a second clock domain or a
#    negedge, so nothing in this repository can demonstrate that REQ-001 still
#    CATCHES those; only fixtures can. It needs no snapshot, so its verdict is
#    independent of what generate.exe produced this run.
#  * precompile_check --self-test (WO-0034): seeds the exact WO-0033 escape
#    class (an unbound value) and an unqualified sibling-library reference, and
#    requires both to be caught.
#  * check_rfc1071_anchor --self-test (WO-0034): generates §3-shaped documents
#    and requires the extractor to confirm a good one, reject a corrupted one,
#    and refuse an unidentified one.

# A check that stood down at a gate has not passed; it has said nothing. The
# helper below refuses to print OK over a SKIPPED banner, because "OK" is what
# a reader scans the log for.
run_and_label() { # $1 = human label, $2… = command
  local label="$1"; shift
  local out rc
  out="$("$@" 2>&1)"; rc=$?
  printf '%s\n' "$out"
  if [ "$rc" -ne 0 ]; then
    printf '=== %s: FAILED ===\n\n' "$label"
    status=1
  elif printf '%s' "$out" | grep -q 'SKIPPED'; then
    printf '=== %s: SKIPPED — stood down at a gate, NOT coverage ===\n\n' "$label"
  else
    printf '=== %s: OK ===\n\n' "$label"
  fi
}

for st in check_emitted_verilog precompile_check check_rfc1071_anchor; do
  printf '=== %s.sh --self-test ===\n' "$st"
  run_and_label "$st self-test" bash "$HERE/$st.sh" --self-test
done

# ---- the checks ------------------------------------------------------

for script in check_records_vs_appendix.sh check_emitted_verilog.sh precompile_check.sh; do
  printf '=== %s ===\n' "$script"
  run_and_label "$script" bash "$HERE/$script"
done

# The anchor check, with the environment-dependent strictness the header
# argues for. GITHUB_ACTIONS is set on every GitHub-hosted runner; CI is set
# by essentially every other provider. Anything else is treated as a
# development container.
#
# The script is always run in its STRICT form and dv_checks interprets the
# exit code here, in the open, rather than passing a flag that would let a
# reader of the log below mistake "could not check" for "checked and fine".
printf '=== check_rfc1071_anchor.sh ===\n'
bash "$HERE/check_rfc1071_anchor.sh"
rfc_rc=$?
case "$rfc_rc" in
  0)
    printf '=== check_rfc1071_anchor.sh: OK — anchor CONFIRMED against fetched text ===\n\n'
    ;;
  2)
    if [ -n "${GITHUB_ACTIONS:-}" ] || [ -n "${CI:-}" ]; then
      printf '=== check_rfc1071_anchor.sh: FAILED — unreachable ON A CI RUNNER ===\n'
      printf 'Egress is open here. A 403 at this point means the cheapest closure named\n'
      printf 'for this obligation does not work either, and that is news, not noise.\n\n'
      status=1
    else
      open_obligation=1
      printf '=== check_rfc1071_anchor.sh: OBLIGATION OPEN — NOT coverage, NOT a pass ===\n'
      printf 'Development container: this fetch has been blocked five times already\n'
      printf '(J-dv_lead-0017, J-dv_lead-0018, the WO-0033 acceptance block), so a sixth\n'
      printf 'does not redden the suite. Nothing was confirmed. No sign-off may cite\n'
      printf 'this line. CI is where this obligation gets closed.\n\n'
    fi
    ;;
  *)
    printf '=== check_rfc1071_anchor.sh: FAILED (exit %s) ===\n\n' "$rfc_rc"
    status=1
    ;;
esac

# ---- bench inventory: a REPORT, never a check --------------------------
# Why this exists (J-dv_lead-0042). The M03 bench's unit count circulated
# through four packets as "fifteen", then "eighteen", with no party having
# counted it: `dune runtest` is silent on success, so CI never printed it,
# and each signer assumed the other had measured. It reached a mutation
# campaign's freeze instruction before anyone checked. The fix is not a
# check — an asserted count would go stale every packet and redden the
# suite for doing its job — but a PROVENANCE: a committed tool that prints
# the number, so any packet quoting it can say where it came from.
#
# Deliberately no pass/fail semantics and no effect on $status: this block
# cannot manufacture a green and cannot redden one.
#
# WHAT THIS REPORT COUNTS, AND THE JOIN IT DOES NOT SUPPLY (J-dv_lead-0109,
# from WO-0063B-VERDICT §6.1 / FINDING WO-0063B-1).
#
# It counts `let%expect_test` occurrences per file — units, nothing else. It is
# NOT a per-row or per-unit classification, and the difference has already cost
# a campaign one MUST-STAY-GREEN violation, so the rule is written here rather
# than remembered:
#
#   THE RUNNER -> UNIT RELATION IN THIS BENCH IS MANY-TO-MANY. A helper is
#   called from more than one unit, and a unit calls more than one helper.
#   Therefore ANY per-unit or per-row classification — which units register a
#   given monitor expectation, which rows a seeded class can reach, which units
#   a mutation should redden — MUST be built from CALL SITES, never from the
#   enclosing definition a `grep` result happens to sit inside.
#
# The incident: a pass mapped each `Strobe_monitor.expect` site to the runner
# enclosing it and then to ONE unit. `run_mixed_pair` (test/xgmii_rx_64/
# test_m03_d.ml:266) is called from TWO units — M03-D3's `run_d3` (:455) and
# M03-D2's `run_d2_d1_partner` (:408) — so its tlast-pinned registration
# belongs to both rows. It was assigned to M03-D3 alone, M03-D2 was sealed as
# MUST-STAY-GREEN, and M03-D2 reddened. The file said so IN PROSE at :330; a
# structural pass cannot read prose, which is precisely why the join must be
# measured rather than inferred.
#
# The mechanical form, portable to any later bench: state the relation your
# pass assumes before you use its output. A pass that assumed one-to-one and
# was never checked against the many-to-many case carries the confidence of a
# measurement and the blind spot of an assumption — and the blind spot is
# invisible exactly because the pass ran cleanly.
printf '=== bench inventory (REPORT only — no check, no verdict) ===\n'
inv_total=0
for inv_f in test/xgmii_rx_64/*.ml; do
  [ -e "$inv_f" ] || continue
  # NOT `grep -c ... || printf '0'`: grep -c already prints 0 on no match and
  # then exits 1, so the `||` appends a SECOND zero and the arithmetic below
  # dies on "0\n0". This exact bug was fixed once in this file at WO-0034 and
  # reintroduced here (J-dv_lead-0042) — left commented so it is not a third
  # time.
  inv_n=$(grep -c 'let%expect_test' "$inv_f" 2>/dev/null)
  inv_n="${inv_n:-0}"
  [ "$inv_n" -eq 0 ] && continue
  printf '  %3s  %s\n' "$inv_n" "$inv_f"
  inv_total=$((inv_total + inv_n))
done
# FINDING M-4, REPAIRED HERE (raised `WO-0074` §2, carried unrepaired through
# the whole family-M campaign, carrier declared as "the next commit that opens
# tools/**" at `WO-0074-VERDICT` §13 item 3 — this one).
#
# The matcher below used to read a DIRECTORY and not a FILE TYPE:
#
#   grep -rh 'let%expect_test' test/          -> 140
#   grep -rh --include=*.ml 'let%expect_test' test/  -> 139
#
# The extra unit is not a unit. It is line 865 of
# `test/attack_plans/AP-xgmii_rx_64.md`, where the plan QUOTES a matcher in
# prose — so this report counted a sentence about counting as a thing counted.
# The per-file loop above was never affected (it globs `*.ml` explicitly); only
# the repository-wide figure was, and that is the figure a campaign packet's
# denominator is built from. It over-reported by exactly one for eight
# campaigns.
#
# THE GENERAL FORM, which is why this is a comment and not a silent one-word
# diff: AN INVENTORY OF A LANGUAGE CONSTRUCT MUST BE SCOPED BY FILE TYPE, NEVER
# BY DIRECTORY. A directory-scoped matcher counts every artefact that talks
# ABOUT the construct — plans, packets, journals, review notes — and a project
# whose discipline is to write about its own instruments generates exactly that
# contamination in proportion to how well it is documented. The symptom is
# invisible in the output: the count is a plausible integer either way.
#
# AND A SECOND, DISTINCT REPAIR ON THE SAME LINE, DECLARED RATHER THAN FOLDED
# IN SILENTLY: the trailing `|| printf '0'` was the exact double-zero bug this
# file's own comment eighteen lines above forbids by name ("fixed once at
# WO-0034 and reintroduced here — left commented so it is not a third time").
# It was a third time. `grep -c .` already prints `0` and then exits 1 on no
# match, so the `||` appended a SECOND zero and this report would have printed
# a two-line field. Latent, never fired (the true figure has never been 0), and
# removed here because the line was open and the warning it violates is four
# inches above it.
inv_repo=$(grep -rh --include=*.ml 'let%expect_test' test/ 2>/dev/null | grep -c .)
inv_repo="${inv_repo:-0}"
printf '  ---\n  %3s  test/xgmii_rx_64/ (the M03 bench)\n' "$inv_total"
printf '  %3s  test/**/*.ml (repository-wide, FILE-TYPE scoped — FINDING M-4)\n' "$inv_repo"
printf 'Quote these figures with this command as their provenance, or measure\n'
printf 'your own. Do not quote a unit count nobody has counted.\n'
printf 'These are UNIT COUNTS, not a per-unit classification: runner -> unit is\n'
printf 'MANY-TO-MANY here, so any per-unit or per-row set must be built from CALL\n'
printf 'SITES, never from enclosing definitions (see the note above this block).\n\n'

# ---- row-discharge census: BOUNDARY-MATCHED, and a REPORT, never a check ----
#
# Why this exists (RV-0065B-VERDICT §5, J-dv_lead-0113; commissioned into the
# family-B/N campaign packet). The discharge figure "N of 62" is the number a
# sign-off packet quotes and a campaign denominator is built from, and until
# now it was measured by hand at each round. Twice now the hand measurement had
# to be defended against a matcher defect that is invisible in its output:
#
#   A ROW ID THAT IS A PREFIX OF ANOTHER ROW ID IS DISCHARGED BY THE LONGER
#   ROW'S OWN TEXT UNDER A PLAIN SUBSTRING MATCH. Here `M03-M1` is a prefix of
#   `M03-M10`, and `M03-M10` shares a unit title with `M03-B3`; a substring
#   matcher therefore reports `M03-M1` discharged by a unit that has never
#   driven it, and reports one row too many with no visible symptom.
#
# The fix is a TRAILING-DIGIT BOUNDARY: a row id counts as named only where the
# character following it is not a digit (or the id ends the line). Both
# matchers are run below and both figures printed, because the naive figure is
# the one every reader's own `grep` would produce and the difference is the
# whole point of the block. The rows the naive matcher over-discharges are
# named, so the discrepancy is readable rather than merely counted.
#
# The mechanical form, portable past this bench: WHEN A SET OF IDENTIFIERS IS
# MATCHED INTO FREE TEXT, THE MATCH NEEDS A BOUNDARY WHENEVER ANY IDENTIFIER IS
# A PREFIX OF ANOTHER. Check the id set for prefix pairs before trusting a
# substring pass; a pass with no prefix pairs is correct by accident, and stays
# correct only until an id is added.
#
# Deliberately no pass/fail semantics and no effect on $status, for the same
# reason as the inventory block above: an asserted census goes stale every
# packet and would redden the suite for doing its job. This block cannot
# manufacture a green and cannot redden one.
#
# WHAT IT DOES NOT DO. It counts rows NAMED IN UNIT TITLES. It does not know
# which plan rows are ASSERT and which are NO-ASSERT, and it does not see a row
# discharged by a CITATION rather than a title. Both adjustments are judgements
# and are printed as DECLARED, with their provenance, so a reader checks them
# rather than inherits them.
census_plan='test/attack_plans/AP-xgmii_rx_64.md'
printf '=== row-discharge census (REPORT only — no check, no verdict) ===\n'
if [ ! -f "$census_plan" ]; then
  printf '  plan not found at %s — census skipped, NOT coverage\n\n' "$census_plan"
else
  census_titles="$(
    awk 'FNR==1{inh=0} /let%expect_test/{inh=1} inh{print} inh && /=[ \t]*$/{inh=0}' \
      test/xgmii_rx_64/*.ml 2>/dev/null
  )"
  census_rows="$(
    grep -oE '^\|[^|]*M03-[A-Z]+[0-9]+' "$census_plan" 2>/dev/null \
      | grep -oE 'M03-[A-Z]+[0-9]+' | sort -u
  )"
  census_total=0
  census_naive=0
  census_bound=0
  census_over=''
  for census_r in $census_rows; do
    census_total=$((census_total + 1))
    if printf '%s' "$census_titles" | grep -q -- "$census_r"; then
      census_naive=$((census_naive + 1))
      if printf '%s' "$census_titles" | grep -qE -- "${census_r}([^0-9]|\$)"; then
        census_bound=$((census_bound + 1))
      else
        census_over="$census_over $census_r"
      fi
    fi
  done
  printf '  %3s  row ids declared in the plan\n' "$census_total"
  printf '  %3s  named in a unit title — NAIVE substring match\n' "$census_naive"
  printf '  %3s  named in a unit title — TRAILING-DIGIT BOUNDARY match (use this one)\n' \
    "$census_bound"
  if [ -n "$census_over" ]; then
    printf '  over-discharged by the naive matcher:%s\n' "$census_over"
    printf '  (each is a PREFIX of a longer row id that a unit title does name)\n'
  else
    printf '  the two matchers agree at this tree — no row id is a prefix of a\n'
    printf '  named longer one TODAY. That is a property of the current id set,\n'
    printf '  not of the method: adding one id can reintroduce the divergence.\n'
  fi
  printf '  DECLARED adjustments, judgements and not measurements — check them:\n'
  printf '    - M03-A4 is a NO-ASSERT row and is named in a title: subtract 1.\n'
  printf '    - M03-F5 is discharged BY CITATION, not by a title\n'
  printf '      (test/xgmii_rx_64/test_m03_f.ml, the M03-F5 block): add 1.\n'
  printf '  Quote the BOUNDARY figure with this command as its provenance, apply\n'
  printf '  the two declared adjustments in the open, and state the ASSERT-row\n'
  printf '  denominator from the plan rather than from this block.\n\n'
fi


if [ "$status" -ne 0 ]; then
  printf 'dv_checks: at least one check FAILED\n'
elif [ "$open_obligation" -ne 0 ]; then
  printf 'dv_checks: every check that COULD run passed, and %d obligation is still OPEN\n' "$open_obligation"
  printf '           (see the OBLIGATION OPEN line above). This run is a green light for\n'
  printf '           the checks it ran and for nothing else.\n'
else
  printf 'dv_checks: all checks passed\n'
fi
exit "$status"
