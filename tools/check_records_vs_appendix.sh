#!/usr/bin/env bash
# check_records_vs_appendix.sh — carry-forward C-9.
#
# SPEC-M01 §10 names "the interface compile check" as the mechanism for
# comparing the Status record against requirements.md §12 and the Config
# record against §9.1. An OCaml compile cannot read a markdown table, so the
# hook names an artefact that cannot perform it. This script is the artefact
# that can, and dv_lead owns it (WO-0009 deliverable 5).
#
# It exists because SPEC-M01 §4.2 deliberately declines to restate §12's
# twenty-one strobe names — "a second copy of twenty-one normative names is a
# second place for them to drift". That is the right call, and its consequence
# is that the record IS the only copy, so the record is the thing that has to
# be checked, by script, at every SHA. Twenty-one names is exactly the length
# at which reading is unreliable: error_start_without_terminate versus
# error_start_without_terminator is a defect no amount of care catches by eye.
#
# Four checks:
#   1. SPEC-M01's Status record vs requirements.md §12, as ordered
#      character-for-character sequences (REQ-804).
#   2. SPEC-M01's Config record vs requirements.md §9.1: field count and the
#      width of each field, in order (REQ-802). Field NAMES are not compared:
#      §9.1 writes them in prose ("inter-frame gap", "receive enable") and the
#      record in OCaml (ifg, rx_enable), so the correspondence is a human
#      judgement recorded in SPEC-M01 §4.2, not a mechanical one. Both lists
#      are printed side by side so a reviewer sees the pairing.
#   3. Each frozen spec's §4.1 OCaml block vs its lift under
#      docs/specs/ifc_check/, byte for byte (SPEC-TEMPLATE rule 6).
#   4. The DV library's own copy of §12 (test/monitors/strobes.ml) vs §12.
#      A copy inside the bench machinery is a third place to drift, so it is
#      checked like the other two rather than trusted.
#
# Usage: tools/check_records_vs_appendix.sh
# Exit:  0 all checks pass (or are legitimately not yet applicable), 1 otherwise.

set -uo pipefail

ROOT="$(cd "$(dirname "$0")/.." && pwd)"
REQ="$ROOT/docs/specs/requirements.md"
M01="$ROOT/docs/specs/modules/axi64.md"
STROBES_ML="$ROOT/test/monitors/strobes.ml"

failures=0
checks=0

pass() { printf 'PASS  %s\n' "$1"; checks=$((checks + 1)); }
fail() { printf 'FAIL  %s\n' "$1"; failures=$((failures + 1)); checks=$((checks + 1)); }
skip() { printf 'SKIP  %s\n' "$1"; }

need_file() {
  if [ -f "$1" ]; then return 0; fi
  skip "$2 (missing: ${1#"$ROOT"/})"
  return 1
}

# ---------------------------------------------------------------- check 1
# §12's table rows begin "| `error_...`"; the record's fields are
# "    { error_... : 'a" / "    ; error_... : 'a".
strobes_from_appendix() {
  sed -n '/^## 12\. Strobe appendix/,$p' "$REQ" \
    | grep -oE '^\| `error_[a-z_]+`' | tr -d '|` '
}

strobes_from_record() {
  sed -n "/^module Status = struct/,/deriving hardcaml/p" "$M01" \
    | grep -oE '(error_[a-z_]+) :' | cut -d' ' -f1
}

if need_file "$REQ" "Status record vs requirements.md §12" \
  && need_file "$M01" "Status record vs requirements.md §12"; then
  a=$(strobes_from_appendix)
  b=$(strobes_from_record)
  na=$(printf '%s\n' "$a" | grep -c .)
  nb=$(printf '%s\n' "$b" | grep -c .)
  if [ "$na" -eq 0 ]; then
    fail "Status vs §12: extracted no strobe from requirements.md §12"
  elif [ "$a" = "$b" ]; then
    pass "Status record = requirements.md §12 ($na strobes, same order, REQ-804)"
  else
    fail "Status record != requirements.md §12 (appendix $na, record $nb)"
    diff <(printf '%s\n' "$a") <(printf '%s\n' "$b") | sed 's/^/      /'
  fi
fi

# ---------------------------------------------------------------- check 2
# §9.1's rows are "| local MAC | 48 | 0 | ... |"; the record's fields carry
# [@bits n], or no annotation when one bit wide.
config_widths_from_appendix() {
  sed -n '/^### 9\.1 Configuration fields/,/^---$/p' "$REQ" \
    | grep -E '^\|' | grep -vE '^\| Field|^\|[- ]*\|' \
    | awk -F'|' '{ gsub(/^[ \t]+|[ \t]+$/, "", $3); print $3 }'
}

config_names_from_appendix() {
  sed -n '/^### 9\.1 Configuration fields/,/^---$/p' "$REQ" \
    | grep -E '^\|' | grep -vE '^\| Field|^\|[- ]*\|' \
    | awk -F'|' '{ gsub(/^[ \t]+|[ \t]+$/, "", $2); print $2 }'
}

config_from_record() {
  sed -n "/^module Config = struct/,/deriving hardcaml/p" "$M01" \
    | grep -E "^ *[{;] [a-z_]+ : 'a" \
    | awk '{ name = $2; width = 1
             if (match($0, /\[@bits [0-9]+\]/)) {
               w = substr($0, RSTART, RLENGTH); gsub(/[^0-9]/, "", w); width = w
             }
             print name " " width }'
}

if need_file "$REQ" "Config record vs requirements.md §9.1" \
  && need_file "$M01" "Config record vs requirements.md §9.1"; then
  spec_widths=$(config_widths_from_appendix)
  spec_names=$(config_names_from_appendix)
  record=$(config_from_record)
  record_widths=$(printf '%s\n' "$record" | awk '{ print $2 }')
  record_names=$(printf '%s\n' "$record" | awk '{ print $1 }')
  n_spec=$(printf '%s\n' "$spec_widths" | grep -c .)
  n_record=$(printf '%s\n' "$record_widths" | grep -c .)
  if [ "$n_spec" -ne 12 ]; then
    fail "Config vs §9.1: §9.1 has $n_spec rows, REQ-802 requires exactly twelve"
  elif [ "$n_spec" -ne "$n_record" ]; then
    fail "Config vs §9.1: §9.1 has $n_spec fields, the record has $n_record"
  elif [ "$spec_widths" = "$record_widths" ]; then
    pass "Config record = requirements.md §9.1 (12 fields, widths equal in order, REQ-802)"
    paste <(printf '%s\n' "$spec_names") <(printf '%s\n' "$record_names") \
      <(printf '%s\n' "$record_widths") | sed 's/^/      §9.1 /'
  else
    fail "Config record widths differ from requirements.md §9.1"
    diff <(printf '%s\n' "$spec_widths") <(printf '%s\n' "$record_widths") | sed 's/^/      /'
  fi
fi

# ---------------------------------------------------------------- check 3
# SPEC-TEMPLATE rule 6: each spec's §4.1 block is lifted verbatim into
# docs/specs/ifc_check/<module>_ifc.ml. The pairs are DISCOVERED, not listed:
# a hardcoded batch-A pair list would silently stop checking the moment batch B
# lands, which is the failure mode a currency check exists to prevent.
#
# Only the FIRST fenced ocaml block is taken. §4.1 is the lifted one, and a
# spec is free to show further OCaml later (an example, a witness); a naive
# range extraction would concatenate them and report a false difference.
first_ocaml_block() {
  awk '/^```ocaml$/ { if (!seen) { seen = 1; inblock = 1; next } }
       /^```$/      { if (inblock) { inblock = 0; exit } }
       inblock      { print }' "$1"
}

specs=$(find "$ROOT/docs/specs/modules" -name '*.md' -type f 2>/dev/null | sort)
if [ -z "$specs" ]; then
  skip "spec §4.1 vs ifc_check lift (no module specs found)"
fi
for spec_file in $specs; do
  base=$(basename "$spec_file" .md)
  lift_file="$ROOT/docs/specs/ifc_check/${base}_ifc.ml"
  label="modules/$base.md §4.1 == ifc_check/${base}_ifc.ml"
  if [ ! -f "$lift_file" ]; then
    fail "$label — the lift does not exist (SPEC-TEMPLATE rule 6)"
    continue
  fi
  if diff -q <(first_ocaml_block "$spec_file") "$lift_file" >/dev/null 2>&1; then
    pass "$label (byte identical, SPEC-TEMPLATE rule 6)"
  else
    fail "$label differs"
    diff <(first_ocaml_block "$spec_file") "$lift_file" | sed 's/^/      /'
  fi
done

# ---------------------------------------------------------------- check 4
if need_file "$STROBES_ML" "DV strobe list vs requirements.md §12" \
  && [ -f "$REQ" ]; then
  a=$(strobes_from_appendix)
  c=$(grep -oE '"error_[a-z_]+"' "$STROBES_ML" | tr -d '"')
  if [ "$a" = "$c" ]; then
    pass "test/monitors/strobes.ml = requirements.md §12 (same names, same order)"
  else
    fail "test/monitors/strobes.ml differs from requirements.md §12"
    diff <(printf '%s\n' "$a") <(printf '%s\n' "$c") | sed 's/^/      /'
  fi
fi

# ----------------------------------------------------------------- verdict
printf '\n%d check(s) run, %d failure(s)\n' "$checks" "$failures"
[ "$failures" -eq 0 ]
