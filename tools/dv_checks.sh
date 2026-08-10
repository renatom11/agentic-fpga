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

# ---- RN-6's resolve-check: extractor, classifier, errata, self-test ----
#
# WHY THIS EXISTS, and why it is a tool and not a third note (RULING, RN-6,
# WO-0077 §6; the instance was first ruled at WO-0076 §4).
#
# WO-0077 §9 item 4 admitted `docs/adr/ADR-0014.md`. The file is
# `docs/adr/ADR-0014-an-enable-gates-admission-not-the-wire.md`. The auditor
# resolved the citation by listing the directory, disclosed the listing, and —
# its spawn allowlist omitting the ADR entirely — honoured the narrower
# instrument and did not read it under either name. The error cost that round
# nothing, and that was luck for the second round running: I had ruled the SAME
# broken path at WO-0076 and then copied it forward into the very next packet I
# drafted. The ruling that followed is the reason for this block:
#
#   A note-carrier repaired the INSTANCE and did not bind the DRAFTING. A second
#   occurrence converts the disposition from "clerical" into an obligation to
#   MECHANISE, because the third occurrence would be a habit with two rulings
#   behind it.
#
# The durable carrier RN-6 named, quoted: "a resolve-check in tools/dv_checks.sh
# — at minimum, every docs/** path cited in agents/handoffs/** resolves at the
# tree, and a citation that does not is reported by the same command whose
# output is already this programme's census provenance."
#
# SCOPE IS THE RULED MINIMUM AND IS NOT WIDENED. agents/handoffs/**, *.md.
# Journals are deliberately OUT: they are append-only by PROTOCOL §4, so a
# broken citation in one is unrepairable by construction and a check over them
# could only ever accumulate an allowlist — a bar that can only grow an
# exception list is a bar nobody reads.
#
# THE THREE CLASSES, and the two that are NOT failures — each printed, so a
# reader checks the judgement rather than inheriting it:
#
#   OK      the path resolves at the tree.
#   GLOB    the token carries an INTERIOR `*` — a pattern, not a citation
#           (`docs/reports/*/x.md`). Trailing `*`s are stripped first, because
#           markdown bold (`**docs/x.md**`) is emphasis and not a pattern; that
#           strip is why a bolded broken path is still caught.
#   PREFIX  the token does not resolve, but is a UNIQUE filename prefix inside
#           an existing directory — a citation BY ID (`docs/adr/ADR-0001`),
#           which a reader resolves in one `ls`. Uniqueness is the whole guard:
#           an AMBIGUOUS prefix is reported MISSING, never quietly accepted.
#   MISSING everything else. This is the class RN-6 is about.
#
# WHAT THIS CHECK CANNOT DO, stated rather than papered over: it cannot tell a
# CITATION from a QUOTATION-TO-CONVICT. `SO-xgmii_rx_64.md` quotes the broken
# ADR-0014 path in order to convict it, exactly as PROTOCOL §10's R-SEAL-1 notes
# that quoting a claim is not making it — and that distinction is not a lexical
# test. So it is not a regex here; it is a dispositioned entry in the errata
# table below, where the judgement is signed and diffable.
#
# ERRATA ARE DECLARED, NOT SILENT, AND THEY CANNOT ROT. A known-broken citation
# does not redden — RN-6 ruled the bodies of already-issued instruments are NOT
# rewritten, because silently editing an instrument another agent has already
# worked under makes its compliance statement unverifiable against the text it
# cites. But a declared erratum that NO LONGER FIRES reddens: an allowlist with
# no staleness check is how a bar decays into a comment.

docs_cit_norm() { # $1 = raw token -> trailing markdown/sentence punctuation stripped
  local t="$1" last
  while [ -n "$t" ]; do
    last="${t: -1}"
    case "$last" in
      '.'|','|';'|':'|'!'|'?'|')'|']'|'*'|'_') t="${t%?}" ;;
      *) break ;;
    esac
  done
  printf '%s' "$t"
}

docs_cit_pairs() { # $1 = handoffs dir -> "<citing file>\t<normalised path>", unique
  local line f tok
  grep -rHoE '(^|[^[:alnum:]_./-])docs/[A-Za-z0-9_./*-]+' "$1" --include='*.md' 2>/dev/null \
    | while IFS= read -r line; do
        f="${line%%:*}"
        tok="${line#*:}"
        case "$tok" in
          *docs/*) tok="docs/${tok#*docs/}" ;;
          *) continue ;;
        esac
        tok="$(docs_cit_norm "$tok")"
        [ -n "$tok" ] || continue
        printf '%s\t%s\n' "$f" "$tok"
      done | sort -u
}

docs_cit_classify() { # $1 = tree root, $2 = path -> "OK" | "GLOB" | "PREFIX <hit>" | "MISSING <why>"
  local root="$1" p="$2" d b n=0 hit='' cand
  case "$p" in *'*'*) printf 'GLOB'; return 0 ;; esac
  if [ -e "$root/$p" ]; then printf 'OK'; return 0; fi
  d="$(dirname "$p")"
  b="$(basename "$p")"
  if [ -d "$root/$d" ]; then
    for cand in "$root/$d/$b"*; do
      [ -e "$cand" ] || continue
      n=$((n + 1))
      hit="${cand#"$root/"}"
    done
  fi
  case "$n" in
    0) printf 'MISSING nothing resolves, and no name in %s/ begins with "%s"' "$d" "$b" ;;
    1) printf 'PREFIX %s' "$hit" ;;
    *) printf 'MISSING AMBIGUOUS prefix — %s names in %s/ begin with "%s"' "$n" "$d" "$b" ;;
  esac
}

# The declared errata, keyed "<citing file>|<cited path>". Every key here MUST
# still fire; a key that stops firing is a FAILURE (staleness), not a saving.
DOCS_CIT_ERRATA_KEYS='agents/handoffs/WO-0008_batch-b-specs.md|docs/adr/ADR-0006/0007
agents/handoffs/WO-0076_family-j-mutation-campaign.md|docs/adr/ADR-0014.md
agents/handoffs/WO-0077_family-k-mutation-campaign.md|docs/adr/ADR-0014.md
agents/handoffs/SO-xgmii_rx_64.md|docs/adr/ADR-0014.md'

docs_cit_erratum() { # $1 = key -> prints the disposition, returns 0 iff declared
  case "$1" in
    'agents/handoffs/WO-0008_batch-b-specs.md|docs/adr/ADR-0006/0007')
      printf 'compressed prose shorthand for TWO ADRs. Both targets resolve — docs/adr/ADR-0006-crc32-finished-value-ports.md and docs/adr/ADR-0007-octet-count-encoding.md — and the SAME packet cites both in full in its own return table. Body not rewritten (RN-6). Carrier: none; the shorthand is legible and the targets exist.' ;;
    'agents/handoffs/WO-0076_family-j-mutation-campaign.md|docs/adr/ADR-0014.md')
      printf 'RN-6 first instance. Target is docs/adr/ADR-0014-an-enable-gates-admission-not-the-wire.md. Ruled ERRATUM OF RECORD at WO-0076 §4: the allowlist body is NOT rewritten, because an instrument another agent has already worked under cannot be silently edited without making its compliance statement unverifiable.' ;;
    'agents/handoffs/WO-0077_family-k-mutation-campaign.md|docs/adr/ADR-0014.md')
      printf 'RN-6 second instance — the same broken path copied forward by the agent that ruled the first. Ruled ERRATUM OF RECORD at WO-0077 §6, same ground. THIS BLOCK IS THAT RULING DISCHARGED: the recurrence is what converted the disposition from clerical into an obligation to mechanise.' ;;
    'agents/handoffs/SO-xgmii_rx_64.md|docs/adr/ADR-0014.md')
      printf 'QUOTATION-TO-CONVICT, not a citation: SO-xgmii_rx_64.md §3.2 quotes the broken path in order to state the defect this check exists for. A reader is not being sent there. Not lexically separable from a citation, which is why it is dispositioned here rather than pattern-matched away.' ;;
    *) return 1 ;;
  esac
  return 0
}

# THE SELF-TEST. A check whose first run is green tells you nothing about the
# check (FINDING K-3's rule, applied to its author's own new bar) — so this bar
# proves it can still fail, and fail for each of five distinct reasons, before
# it is allowed to say anything passed. Fixtures, not the repository: nothing in
# this tree can demonstrate that an AMBIGUOUS prefix is refused, because no such
# ambiguity exists here today.
docs_cit_self_test() {
  local ft rc=0 got
  ft="$(mktemp -d)" || return 1
  mkdir -p "$ft/docs/adr" "$ft/docs/reports/latency" "$ft/agents/handoffs"
  : > "$ft/docs/adr/ADR-0001-org-design.md"
  : > "$ft/docs/adr/ADR-0090-alpha.md"
  : > "$ft/docs/adr/ADR-0090-beta.md"

  expect() { # $1 = label, $2 = expected class, $3 = path
    got="$(docs_cit_classify "$ft" "$3")"
    if [ "${got%% *}" = "$2" ]; then
      printf '  ok    %-34s %s -> %s\n' "$1" "$3" "$got"
    else
      printf '  FAIL  %-34s %s -> %s (expected %s)\n' "$1" "$3" "$got" "$2"
      rc=1
    fi
  }

  expect 'a resolving path is OK'        OK      'docs/adr/ADR-0001-org-design.md'
  expect 'RN-6 shape is caught'          MISSING 'docs/adr/ADR-0001.md'
  expect 'a bolded broken path is caught' MISSING "$(docs_cit_norm 'docs/adr/ADR-0001.md**')"
  expect 'an interior glob is a pattern' GLOB    'docs/reports/*/x.md'
  expect 'a unique id prefix resolves'   PREFIX  'docs/adr/ADR-0001'
  expect 'an AMBIGUOUS prefix is refused' MISSING 'docs/adr/ADR-0090'

  # The extractor's own teeth: it must find the broken citation in a file, and
  # must attribute it to that file. Backticks and bold are in the fixture on
  # purpose — both are how this programme's packets actually write a path.
  cat > "$ft/agents/handoffs/FIXTURE.md" <<'DOCS_CIT_FIXTURE'
see `docs/adr/ADR-0001.md` and **docs/adr/ADR-0001-org-design.md**.
DOCS_CIT_FIXTURE
  if docs_cit_pairs "$ft/agents/handoffs" | grep -qF $'FIXTURE.md\tdocs/adr/ADR-0001.md'; then
    printf '  ok    extractor finds and attributes the broken citation\n'
  else
    printf '  FAIL  extractor did not find/attribute the broken citation\n'
    rc=1
  fi
  if docs_cit_pairs "$ft/agents/handoffs" | grep -qF $'FIXTURE.md\tdocs/adr/ADR-0001-org-design.md'; then
    printf '  ok    extractor strips markdown bold from a good citation\n'
  else
    printf '  FAIL  extractor did not strip markdown bold\n'
    rc=1
  fi

  unset -f expect
  rm -rf "$ft"
  return "$rc"
}

for st in check_emitted_verilog precompile_check check_rfc1071_anchor; do
  printf '=== %s.sh --self-test ===\n' "$st"
  run_and_label "$st self-test" bash "$HERE/$st.sh" --self-test
done

# Invoked directly rather than through run_and_label, for two reasons: this
# self-test has no gate it can stand down at (so the SKIPPED branch would be
# unreachable and misleading), and an indirectly-invoked function reads to a
# static analyser as dead code — the file was shellcheck-clean before this block
# and stays so.
printf '=== docs/** citation resolve-check --self-test (RN-6) ===\n'
if docs_cit_self_test; then
  printf '=== docs-citation resolve-check self-test: OK ===\n\n'
else
  printf '=== docs-citation resolve-check self-test: FAILED ===\n\n'
  status=1
fi

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

# ---- RN-6: the docs/** citation resolve-check — a CHECK, and it gates ----
#
# Why this one GATES where the two blocks below only REPORT: an asserted count
# goes stale every packet and would redden the suite for doing its job, which is
# why the inventory and the census cannot manufacture a green or redden one. A
# path either resolves or it does not. That is an invariant, not a count, so it
# belongs in the check class — and RN-6's own second occurrence is the evidence
# that a non-gating disposition does not bind the next drafting.
printf '=== docs/** citation resolve-check (RN-6) ===\n'
docs_cit_root="$(cd "$HERE/.." && pwd)"
docs_cit_dir="$docs_cit_root/agents/handoffs"
if [ ! -d "$docs_cit_dir" ]; then
  printf '  agents/handoffs/ not found at %s — check FAILED (it cannot stand down)\n\n' "$docs_cit_dir"
  status=1
else
  dc_total=0; dc_ok=0; dc_glob=0; dc_prefix=0; dc_errata=0; dc_new=0
  dc_fired=''
  dc_prefix_lines=''
  while IFS=$'\t' read -r dc_file dc_path; do
    [ -n "${dc_path:-}" ] || continue
    dc_total=$((dc_total + 1))
    dc_rel="${dc_file#"$docs_cit_root/"}"
    dc_class="$(docs_cit_classify "$docs_cit_root" "$dc_path")"
    case "$dc_class" in
      OK) dc_ok=$((dc_ok + 1)) ;;
      GLOB) dc_glob=$((dc_glob + 1)) ;;
      PREFIX*)
        dc_prefix=$((dc_prefix + 1))
        dc_prefix_lines="$dc_prefix_lines  PREFIX   $dc_rel
             cites $dc_path -> ${dc_class#PREFIX }
"
        ;;
      MISSING*)
        dc_key="$dc_rel|$dc_path"
        if dc_reason="$(docs_cit_erratum "$dc_key")"; then
          dc_errata=$((dc_errata + 1))
          dc_fired="$dc_fired$dc_key
"
          printf '  ERRATUM  %s\n           cites %s\n           %s\n           %s\n' \
            "$dc_rel" "$dc_path" "${dc_class#MISSING }" "$dc_reason"
        else
          dc_new=$((dc_new + 1))
          printf '  BROKEN   %s\n           cites %s\n           %s\n' \
            "$dc_rel" "$dc_path" "${dc_class#MISSING }"
        fi
        ;;
    esac
  done <<EOF
$(docs_cit_pairs "$docs_cit_dir")
EOF

  # Citations by id, accepted on a UNIQUE prefix and listed so the acceptance is
  # checkable rather than inherited.
  [ -n "$dc_prefix_lines" ] && printf '%s' "$dc_prefix_lines"

  # Staleness: a declared erratum that no longer fires is a FAILURE. Either the
  # path was repaired (delete the entry) or the packet stopped citing it (delete
  # the entry) — both are edits somebody must make deliberately.
  dc_stale=0
  while IFS= read -r dc_k; do
    [ -n "$dc_k" ] || continue
    case "$dc_fired" in
      *"$dc_k"$'\n'*) ;;
      *)
        dc_stale=$((dc_stale + 1))
        printf '  STALE ERRATUM — declared and did not fire: %s\n' "$dc_k"
        ;;
    esac
  done <<EOF
$DOCS_CIT_ERRATA_KEYS
EOF

  printf '  ---\n'
  printf '  %3s  docs/** citations in agents/handoffs/**/*.md (file x path, unique)\n' "$dc_total"
  printf '  %3s  resolve at the tree\n' "$dc_ok"
  printf '  %3s  patterns (interior glob) — not citations, not checked\n' "$dc_glob"
  printf '  %3s  resolve by UNIQUE id prefix (listed above)\n' "$dc_prefix"
  printf '  %3s  declared errata (listed above; each ruled, none rewritten)\n' "$dc_errata"
  printf '  %3s  UNDECLARED broken citations\n' "$dc_new"
  printf '  %3s  stale errata (declared, did not fire)\n' "$dc_stale"
  if [ "$dc_new" -ne 0 ] || [ "$dc_stale" -ne 0 ]; then
    printf '=== docs/** citation resolve-check: FAILED ===\n'
    printf 'A docs/** path cited in a handoff packet must resolve at the tree, or be a\n'
    printf 'declared erratum with its ruling. RN-6, WO-0077 §6.\n\n'
    status=1
  else
    printf '=== docs/** citation resolve-check: OK ===\n\n'
  fi
fi

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
