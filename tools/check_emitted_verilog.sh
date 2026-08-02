#!/usr/bin/env bash
# check_emitted_verilog.sh — the X-9 mechanical inspections.
#
# Six Phase-1 REQs are verified by inspecting a build product rather than by
# simulating anything: REQ-001, REQ-017, REQ-018, REQ-306, REQ-808 and
# REQ-903. WO-0003 finding X-9 asked who executes them; the WO-0003 and
# WO-0007 ACCEPTED rulings settled it — dv_lead owns them as scripts under
# tools/, and those scripts may parse rtl_snapshots/** (emitted Verilog, a
# build product) but never libs/** sources. That boundary is honoured here:
# this script reads rtl_snapshots/*.v and docs/specs/architecture.md, and
# nothing under libs/.
#
# Checks implemented (WO-0009 deliverable 5; REQ-903 added at WO-0012):
#   REQ-001  every edge expression in the emitted Verilog names `clock`
#   REQ-017  nic_top's only wire-side ports are the four XGMII ports
#   REQ-018  no vendor primitive (whitelist), no device constraint file,
#            the XGMII link partner lives under test/
#   REQ-306  the emitted crc32_eth has no clock port and no posedge block
#   REQ-808  emitted module names == architecture.md §4 inventory, M01 excluded
#   REQ-903  (a) an .mli for every inventory module, M01 INCLUDED
#            (b) `hierarchical` exported by every inventory module EXCEPT M01
#
# THE ONE PLACE THIS SCRIPT LOOKS INSIDE libs/, AND WHY (REQ-903).
#
# Every other check here reads rtl_snapshots/ (a build product) and
# docs/specs/. REQ-903's subject is neither: it is the module SURFACE, and the
# artefact that carries it is the `.mli`. So part (a) is a file-existence test
# under libs/hardcaml_ethernet/src/ — the directory architecture.md §4 names —
# and part (b) greps each `.mli` for one declaration. Three limits keep that
# inside PROTOCOL §10's independence rule rather than beside it:
#
#   * only `.mli` files are opened, never a `.ml`. An interface file is the
#     declared surface, which is what the specification pins (SPEC-M03 §4.1's
#     `module type S` is the same two declarations);
#   * the check prints verdicts and module names only, never file contents, so
#     no implementation detail can reach a journal, a packet or a snapshot;
#   * no test in test/** derives anything from these files. This is a
#     repository-surface check with a determinable answer, which is exactly the
#     form REQ-903's own verification column asks for.
#
# C-8 is what unblocked it. REQ-903 used to quantify over the whole inventory
# with no types-only exclusion while SPEC-M01 declared create/hierarchical not
# applicable for M01, citing REQ-808 — whose exclusion is written for the
# emitted-module list. requirements.md now states the split in REQ-903's own
# words: M01 owes the .mli and not the entry point, "the same exclusion REQ-808
# makes … now stated for this requirement in its own words rather than borrowed
# from that one".
#
# The Verilog parsing is coupled to Hardcaml's emitter format, which is
# regular by construction (one instantiation per three lines: module name,
# instance name, then the port map). That coupling is deliberate and stated
# rather than hidden: this script inspects OUR build product, not arbitrary
# Verilog, and if the emitter's format changes the script must be updated with
# it. REQ-902's determinism step is what keeps that format stable.
#
# Usage: tools/check_emitted_verilog.sh
# Exit:  0 all applicable checks pass, 1 otherwise. Checks whose subject does
#        not exist yet print PENDING and do not fail — but they are counted and
#        listed, because a check that silently disappears is worse than one
#        that fails. No sign-off packet may cite a PENDING line as coverage.

set -uo pipefail

ROOT="$(cd "$(dirname "$0")/.." && pwd)"
SNAP="$ROOT/rtl_snapshots"
ARCH="$ROOT/docs/specs/architecture.md"
# architecture.md §4: "Modules live under `libs/hardcaml_ethernet/src/`". The
# path is taken from the specification rather than from a directory listing, so
# a module written somewhere else is a PENDING this script reports, not a hole
# it silently steps around.
SRC="$ROOT/libs/hardcaml_ethernet/src"
EMITTED=""

# Modules that legitimately exist in rtl_snapshots/ without being in the §4
# inventory. This is the bootstrap skeleton from G0, not a design module. It
# MUST be empty at P1-module-ready: an allowance is how a vendor primitive
# would hide from REQ-018's whitelist.
BOOTSTRAP="${DV_BOOTSTRAP_MODULES:-word_counter word_counter_top}"

failures=0
checks=0
pending=0

pass() { printf 'PASS     %s\n' "$1"; checks=$((checks + 1)); }
fail() { printf 'FAIL     %s\n' "$1"; failures=$((failures + 1)); checks=$((checks + 1)); }
note() { printf '         %s\n' "$1"; }
pend() { printf 'PENDING  %s\n' "$1"; pending=$((pending + 1)); }

in_list() { # in_list needle "space separated haystack"
  local item
  for item in $2; do [ "$item" = "$1" ] && return 0; done
  return 1
}

# ------------------------------------------------------------------ inventory
# architecture.md §4 rows look like:  | M03 | `Xgmii_rx_64` | R | ... |
# One parser, two consumers: REQ-903 quantifies over the whole inventory
# (M01 included, by its own text), REQ-808 and REQ-018's whitelist over the
# inventory minus M01 (types-only, no circuit). Two parsers would be two places
# for the same table to be read differently.
inventory_rows() { # "M01 axi64" per line, in §4's order
  [ -f "$ARCH" ] || return 0
  sed -n '/^## 4\. Module inventory/,/^## 5\./p' "$ARCH" \
    | grep -E '^\| M[0-9]+ \|' \
    | awk -F'|' '{ id = $2; name = $3; gsub(/[ `]/, "", id); gsub(/[ `]/, "", name);
                   print id " " tolower(name) }' \
    | grep -E '^M[0-9]+ [a-z][a-z0-9_]*$'
}

inventory_modules() { inventory_rows | grep -v '^M01 ' | awk '{ print $2 }'; }

INVENTORY_ROWS=$(inventory_rows)
INVENTORY=$(inventory_modules | tr '\n' ' ')

# ------------------------------------------------------------------- REQ-903
# Part (a): an .mli for every inventory module, M01 included — "that file is
# what fixes which of M01's records are exported and at what widths, which is
# the surface every other module's REQ-010 compile check binds to".
# Part (b): `hierarchical` exported by every inventory module except M01.
#
# A module with no .mli is a FAIL when its Verilog has been emitted (it is
# built, and shipped without a surface) and a PENDING when it has not (rtl_lead
# has not written it yet). That split is what keeps the check honest before any
# RTL exists without letting it stay silent afterwards.
check_req903() {
  if [ -z "$INVENTORY_ROWS" ]; then
    pend "REQ-903: architecture.md §4 inventory could not be read"
    return
  fi
  if [ ! -d "$SRC" ]; then
    pend "REQ-903: $SRC does not exist yet — no module surface to inspect"
    note "architecture.md §4 names that directory; a module written elsewhere leaves this"
    note "line PENDING, which is a visible gap rather than a silent pass"
    return
  fi
  local id name mli
  local missing_mli="" unbuilt="" no_hier="" m01_hier=""
  local have=0 total=0
  while read -r id name; do
    [ -n "$id" ] || continue
    total=$((total + 1))
    mli="$SRC/$name.mli"
    if [ -f "$mli" ]; then
      have=$((have + 1))
      if grep -qE '^[[:space:]]*val[[:space:]]+hierarchical\b' "$mli"; then
        [ "$id" = "M01" ] && m01_hier="$m01_hier $name"
      else
        [ "$id" = "M01" ] || no_hier="$no_hier $name"
      fi
    elif printf '%s' "$EMITTED" | grep -qw "$name"; then
      missing_mli="$missing_mli $name"
    else
      unbuilt="$unbuilt $name"
    fi
  done <<EOF
$INVENTORY_ROWS
EOF
  [ -n "$missing_mli" ] && fail "REQ-903(a): emitted module(s) with no .mli:$missing_mli"
  [ -n "$no_hier" ] &&
    fail "REQ-903(b): .mli(s) not exporting hierarchical:$no_hier"
  if [ -n "$unbuilt" ]; then
    pend "REQ-903: $have of $total inventory module(s) have an .mli; not written yet:$unbuilt"
    note "REQ-903 passes only when this list is empty; that is a P1-module-ready condition"
  elif [ -z "$missing_mli" ] && [ -z "$no_hier" ]; then
    pass "REQ-903: .mli for all $total inventory module(s), M01 included; hierarchical exported by all but M01"
  fi
  [ -n "$m01_hier" ] &&
    note "REQ-903: M01 also exports hierarchical ($m01_hier). Not a failure — REQ-903 excuses M01 from the entry point, it does not forbid one — but M01 is types-only (architecture.md §6.3) and an entry point there would be worth a spec diff"
  return 0
}

if [ ! -d "$SNAP" ]; then
  pend "rtl_snapshots/ does not exist — no emitted Verilog to inspect"
  check_req903
  printf '\n%d check(s) run, %d failure(s), %d pending\n' "$checks" "$failures" "$pending"
  [ "$failures" -eq 0 ]
  exit
fi

VFILES=$(find "$SNAP" -name '*.v' -type f | sort)
if [ -z "$VFILES" ]; then
  pend "rtl_snapshots/ holds no .v file — no emitted Verilog to inspect"
  check_req903
  printf '\n%d check(s) run, %d failure(s), %d pending\n' "$checks" "$failures" "$pending"
  [ "$failures" -eq 0 ]
  exit
fi

if [ -z "$INVENTORY" ]; then
  pend "architecture.md §4 inventory could not be read — REQ-808 and REQ-018 whitelist skipped"
fi

# --------------------------------------------------------- emitted module set
EMITTED=$(grep -hoE '^module [a-zA-Z_][a-zA-Z0-9_]*' $VFILES | awk '{ print $2 }' | sort -u \
  | tr '\n' ' ')
note "emitted modules: ${EMITTED:-(none)}"
note "inventory (M01 excluded): ${INVENTORY:-(unreadable)}"
[ -n "$BOOTSTRAP" ] && note "bootstrap allowance ACTIVE: $BOOTSTRAP  (must be empty at P1-module-ready)"

# ------------------------------------------------------------------- REQ-001
# Hardcaml emits `always @(posedge _6)` with `assign _6 = clock;` above it, so
# the check resolves one level of aliasing rather than pattern-matching the
# literal name.
req001_bad=""
for f in $VFILES; do
  bad=$(awk '
    /^[ \t]*assign [_a-zA-Z0-9]+ = clock;[ \t]*$/ {
      split($2, a, " "); alias[$2] = 1; next
    }
    /posedge|negedge/ {
      line = $0
      n = gsub(/posedge|negedge/, "&", line)
      if (line ~ /negedge/) { print FILENAME ": " $0 "   (negedge)"; next }
      if (n > 1)            { print FILENAME ": " $0 "   (multiple edge terms)"; next }
      if (match($0, /posedge[ \t]+[_a-zA-Z0-9]+/)) {
        sig = substr($0, RSTART, RLENGTH)
        sub(/posedge[ \t]+/, "", sig)
        if (sig != "clock" && !(sig in alias)) {
          print FILENAME ": " $0 "   (edge signal " sig " is not clock)"
        }
      } else {
        print FILENAME ": " $0 "   (unparsed edge expression)"
      }
    }
  ' "$f")
  [ -n "$bad" ] && req001_bad="$req001_bad$bad"$'\n'
done
edge_count=$(grep -hcE 'posedge|negedge' $VFILES | awk '{ s += $1 } END { print s + 0 }')
if [ -n "$req001_bad" ]; then
  fail "REQ-001 single clock domain: an edge expression does not name clock"
  printf '%s' "$req001_bad" | sed 's/^/      /'
else
  pass "REQ-001 single clock domain: all $edge_count edge expression(s) resolve to clock"
fi

# ------------------------------------------------------------------- REQ-306
if printf '%s' "$EMITTED" | grep -qw 'crc32_eth'; then
  body=$(awk '/^module crc32_eth[ (]/ { on = 1 } on { print } /^endmodule/ { on = 0 }' $VFILES)
  bad=0
  if printf '%s\n' "$body" | grep -qE '^[ \t]*(input|output).*\bclock\b'; then
    fail "REQ-306: emitted crc32_eth declares a clock port"
    bad=1
  fi
  if printf '%s\n' "$body" | grep -q 'posedge'; then
    fail "REQ-306: emitted crc32_eth contains an always @(posedge ...) block"
    bad=1
  fi
  [ "$bad" -eq 0 ] && pass "REQ-306: emitted crc32_eth is combinational (no clock port, no posedge)"
else
  pend "REQ-306: crc32_eth is not in rtl_snapshots/ yet (M02 unbuilt)"
fi

# ------------------------------------------------------------------- REQ-808
if [ -n "$INVENTORY" ]; then
  missing=""
  for m in $INVENTORY; do
    printf '%s' "$EMITTED" | grep -qw "$m" || missing="$missing $m"
  done
  extra=""
  for m in $EMITTED; do
    in_list "$m" "$INVENTORY" && continue
    in_list "$m" "$BOOTSTRAP" && continue
    extra="$extra $m"
  done
  if [ -n "$extra" ]; then
    fail "REQ-808: emitted module(s) not in the architecture.md §4 inventory:$extra"
  elif [ -n "$missing" ]; then
    pend "REQ-808: inventory module(s) not yet emitted:$missing"
    note "REQ-808 passes only when this list is empty; that is a P1-module-ready condition"
  else
    pass "REQ-808: emitted module names == §4 inventory with M01 excluded"
  fi
fi

# ------------------------------------------------------------------- REQ-018
# (a) whitelist: every instantiated module is an inventory module. Hardcaml's
#     emitter writes the module name, then the instance name, then the port
#     map, one per line.
instantiated=$(awk '
  BEGIN {
    split("module endmodule function endfunction task endtask always initial assign \
           input output inout wire reg integer parameter localparam generate endgenerate \
           begin end if else case casex casez endcase for while repeat forever posedge \
           negedge default", kw, " ")
    for (k in kw) keyword[kw[k]] = 1
  }
  { l3 = l2; l2 = l1; l1 = $0 }
  /^[ \t]*\(/ {
    if (l2 ~ /^[ \t]*[a-zA-Z_][a-zA-Z0-9_]*[ \t]*$/ && l3 ~ /^[ \t]*[a-zA-Z_][a-zA-Z0-9_]*[ \t]*$/) {
      name = l3; gsub(/[ \t]/, "", name)
      if (!(name in keyword)) print name
    }
  }
  /^[ \t]*[a-zA-Z_][a-zA-Z0-9_]*[ \t]+[a-zA-Z_][a-zA-Z0-9_]*[ \t]*\([ \t]*$/ {
    name = $1; gsub(/[ \t]/, "", name)
    if (!(name in keyword)) print name
  }
' $VFILES | sort -u | tr '\n' ' ')
note "instantiated modules: ${instantiated:-(none)}"
if [ -n "$INVENTORY" ]; then
  foreign=""
  for m in $instantiated; do
    in_list "$m" "$INVENTORY" && continue
    in_list "$m" "$BOOTSTRAP" && continue
    foreign="$foreign $m"
  done
  if [ -n "$foreign" ]; then
    fail "REQ-018 whitelist: instantiation(s) outside the §4 inventory:$foreign"
    note "REQ-018 is a whitelist, not a blacklist, precisely so this catches every vendor primitive"
  else
    pass "REQ-018 whitelist: every instantiation is an inventory or bootstrap-allowed module"
  fi
fi

# (b) no device constraint file anywhere in the repository
constraints=$(find "$ROOT" -path "$ROOT/.git" -prune -o \
  \( -name '*.xdc' -o -name '*.sdc' -o -name '*.qsf' -o -name '*.ucf' \) -print 2>/dev/null)
if [ -n "$constraints" ]; then
  fail "REQ-018: device constraint file(s) present"
  printf '%s\n' "$constraints" | sed "s|^$ROOT/|      |"
else
  pass "REQ-018: no .xdc/.sdc/.qsf/.ucf constraint file in the repository"
fi

# (c) the XGMII link partner is a DV-owned simulation model under test/
if [ -d "$ROOT/test/xgmii" ]; then
  pass "REQ-018: the XGMII link-partner model lives under test/ (test/xgmii/)"
else
  pend "REQ-018: test/xgmii/ does not exist yet — the link-partner model is unwritten"
fi

# ------------------------------------------------------------------- REQ-017
if printf '%s' "$EMITTED" | grep -qw 'nic_top'; then
  ports=$(awk '/^module nic_top[ (]/ { on = 1 } on { print } /^endmodule/ { on = 0 }' $VFILES \
    | grep -E '^[ \t]*(input|output)' \
    | sed -E 's/^[ \t]*(input|output)[ \t]*(\[[0-9]+:[0-9]+\])?[ \t]*//; s/;[ \t]*$//' \
    | sort -u)
  wire_side=$(printf '%s\n' "$ports" | grep -E '^xgmii_' | tr '\n' ' ')
  expected="xgmii_rxc xgmii_rxd xgmii_txc xgmii_txd "
  if [ "$wire_side" = "$expected" ]; then
    pass "REQ-017: nic_top's wire-side ports are exactly the four XGMII ports"
  else
    fail "REQ-017: nic_top's xgmii_* ports are [$wire_side], expected [$expected]"
  fi
  note "nic_top's remaining ports, for the SPEC-M20 §4.1 set comparison:"
  printf '%s\n' "$ports" | grep -vE '^xgmii_' | sed 's/^/         /'
else
  pend "REQ-017: nic_top is not in rtl_snapshots/ yet (M20 unbuilt)"
fi

# ------------------------------------------------------------------- REQ-903
check_req903

printf '\n%d check(s) run, %d failure(s), %d pending\n' "$checks" "$failures" "$pending"
[ "$failures" -eq 0 ]
