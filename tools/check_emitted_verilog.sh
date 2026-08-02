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
#   REQ-001  every edge expression resolves to the module's own clock input
#            port through the emitter's port-copy renames, and every
#            instantiated `.clock()` connection does too (repaired at WO-0028;
#            see req001_scan below for why the original rule was unsound in
#            both directions, and `--self-test` for the cases that pin it)
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
# Usage: tools/check_emitted_verilog.sh              inspect rtl_snapshots/
#        tools/check_emitted_verilog.sh --self-test  run the REQ-001 fixtures
#
# The self-test needs no snapshot and no toolchain: it drives req001_scan over
# synthetic modules, six that must come back clean and eleven that must be
# flagged. It exists because a checker's NEGATIVE cases are otherwise
# unobservable — rtl_snapshots/ will (correctly) never contain a gated clock,
# so nothing in this repository would ever demonstrate that the rule still
# catches one. dv_checks.sh runs it on every push for exactly that reason.
#
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

# --------------------------------------------------------- REQ-001 edge scanner
# req001_scan <file>... — prints one line per finding, nothing when clean.
#
# WHY THIS IS NOT A ONE-LINE GREP (WO-0028; supersedes the WO-0009 resolver).
#
# REQ-001's verification column asks that "every `always @(posedge …)` edge
# expression names `clock`". Hardcaml's Verilog backend never emits that text:
# it wire-copies EVERY input port and drives the logic from the copy, so the
# literal emission is `assign _6 = clock;` … `always @(posedge _6)`. The
# committed `rtl_snapshots/word_counter.v` has shown exactly that since G0.
# The check therefore has to resolve the copy before it can witness the
# requirement at all.
#
# The original resolver did that in a single awk pass with a one-level table,
# and passed on word_counter. Run 30750975120 failed all 27 always blocks of
# the three MAC snapshots. Two of the original resolver's assumptions are not
# properties of anything:
#
#   * DEPTH — one hop. Nothing bounds the emitter to a single copy.
#   * ORDER — the `assign` precedes its use. Verilog continuous assignments are
#     order-independent, so the emitter owes the reader no such ordering; on
#     word_counter it happened to hold, which is a coincidence of that module,
#     not a rule the check may lean on.
#
# A rule whose verdict depends on unspecified statement order is not a sound
# witness for an invariant, whichever way it lands. So the scan is now:
#
#   1. per MODULE, not per file — `_20` in one module is not `_20` in the next,
#      and the old file-global table let a rename in module A whitewash an edge
#      in module B (self-test case "cross-module alias leak" is that regression);
#   2. two passes — every rename in the module is collected before any edge is
#      judged, so order cannot matter;
#   3. transitive — the rename relation is followed to its root, so depth
#      cannot matter;
#   4. renames ONLY — `assign <wire> = <wire>;` and nothing else. A gate, a
#      concatenation, a bit-select, a multi-line RHS or a register output is not
#      a rename and never enters the relation, so `assign _20 = clock & en;`
#      still FAILs. This is where REQ-001's "no gated clocks, no derived clocks"
#      is actually enforced, and the self-test pins it;
#   5. rooted at the module's own `clock` INPUT PORT — a module with no `clock`
#      port, or one where `clock` is itself assigned inside the module, resolves
#      nothing and FAILs;
#   6. extended to instantiation port maps — `.clock(<expr>)` must resolve in
#      the PARENT the same way. A parent that gates the clock on the way into a
#      child would otherwise be invisible: the child body reads clean against
#      its own port. The old rule could not see this class at all.
#
# Findings name the module and print the resolution chain and the offending
# driver expression, because the diagnosis cost of the original FAIL — a bare
# "_20 is not clock", 27 times, with the emitted file unpromoted — is what made
# this a two-agent dispute instead of a one-line fix.
req001_scan() {
  awk '
    function trim(s) { sub(/^[ \t]+/, "", s); sub(/[ \t]+$/, "", s); return s }

    function reset_module() {
      split("", body); split("", drv); split("", expr)
      nbody = 0; has_clock_port = 0; clock_driven = 0
      modname = "(outside any module)"
    }

    # Follow the rename relation from sig to its root. Sets the globals
    # `chain` (the resolution path, for the report) and `why` (the reason it
    # did not resolve). Returns 1 only when the root is the module clock port.
    function resolve(sig,   cur, hops, seen) {
      chain = sig; why = ""
      if (!has_clock_port) {
        why = "module " modname " declares no clock input port"; return 0
      }
      if (clock_driven) {
        why = "clock is assigned inside module " modname ", so it is not the input port"
        return 0
      }
      cur = sig
      for (hops = 0; hops < 128; hops++) {
        if (cur == "clock") return 1
        if (cur in seen) { why = "rename cycle at " cur; return 0 }
        seen[cur] = 1
        if (cur in drv) { cur = drv[cur]; chain = chain " -> " cur; continue }
        if (cur in expr) {
          why = cur " is driven by `" expr[cur] "`, which is not a rename of clock"
        } else {
          why = cur " has no driver in module " modname
        }
        return 0
      }
      why = "rename chain deeper than 128 hops"
      return 0
    }

    function report(line, msg) {
      printf "%s [%s]: %s   (%s)\n", FILENAME, modname, line, msg
    }

    # Pass 2 over one module: judge every edge expression and clock port map
    # against the rename closure collected in pass 1.
    function flush_module(   i, line, tmp, n, sig, rest, q, arg) {
      for (i = 1; i <= nbody; i++) {
        line = body[i]
        if (line ~ /posedge|negedge/) {
          if (line ~ /negedge/) { report(line, "negedge in an edge position"); continue }
          tmp = line
          n = gsub(/posedge|negedge/, "&", tmp)
          if (n > 1) { report(line, "more than one edge term"); continue }
          if (match(line, /posedge[ \t]+[A-Za-z_][A-Za-z0-9_]*/)) {
            sig = substr(line, RSTART, RLENGTH)
            sub(/posedge[ \t]+/, "", sig)
            if (!resolve(sig))
              report(line, "edge signal " sig " does not resolve to clock: " why \
                           "  [chain: " chain "]")
          } else {
            report(line, "unparsed edge expression")
          }
        } else if (match(line, /\.clock[ \t]*\(/)) {
          rest = substr(line, RSTART + RLENGTH)
          q = index(rest, ")")
          if (q == 0) { report(line, "unparsed .clock() port connection"); continue }
          arg = trim(substr(rest, 1, q - 1))
          if (arg !~ /^[A-Za-z_][A-Za-z0-9_]*$/) {
            report(line, "instantiated .clock() is driven by `" arg "`, not a plain signal")
          } else if (!resolve(arg)) {
            report(line, "instantiated .clock() signal " arg " does not resolve to clock: " \
                         why "  [chain: " chain "]")
          }
        }
      }
    }

    BEGIN { reset_module() }

    FNR == 1 && NR > 1 { if (nbody > 0) flush_module(); reset_module() }

    /^module[ \t]+[A-Za-z_][A-Za-z0-9_]*/ {
      if (nbody > 0) flush_module()
      reset_module()
      modname = $2
      sub(/\(.*$/, "", modname)
      next
    }

    /^endmodule/ { if (nbody > 0) flush_module(); reset_module(); next }

    # Pass 1: buffer the module body and collect its rename relation.
    {
      nbody++; body[nbody] = $0

      if ($0 ~ /^[ \t]*input[ \t]/) {
        d = $0
        sub(/^[ \t]*input[ \t]+/, "", d)
        sub(/\[[^]]*\][ \t]*/, "", d)
        sub(/[ \t]*;.*$/, "", d)
        if (trim(d) == "clock") has_clock_port = 1
      } else if ($0 ~ /^[ \t]*assign[ \t]+[A-Za-z_][A-Za-z0-9_]*[ \t]*=/) {
        lhs = $0
        sub(/^[ \t]*assign[ \t]+/, "", lhs)
        sub(/[ \t]*=.*$/, "", lhs)
        lhs = trim(lhs)
        rhs = substr($0, index($0, "=") + 1)
        if (lhs == "clock") clock_driven = 1
        if (rhs ~ /;[ \t]*$/) {
          sub(/;[ \t]*$/, "", rhs)
          rhs = trim(rhs)
          expr[lhs] = rhs
          # THE teeth: only a bare identifier is a rename. Anything else — a
          # gate, a concatenation, a bit-select — stays out of the relation.
          if (rhs ~ /^[A-Za-z_][A-Za-z0-9_]*$/) drv[lhs] = rhs
        } else {
          expr[lhs] = trim(rhs) " …"   # continued below; never a rename
        }
      }
    }

    END { if (nbody > 0) flush_module() }
  ' "$@"
}

# ------------------------------------------------------------ REQ-001 self-test
# `tools/check_emitted_verilog.sh --self-test` — fixtures, not snapshots, so the
# NEGATIVE cases are executable. Every fixture below is a claim about what
# REQ-001 must and must not accept; dv_checks.sh runs them on every push, so a
# future "simplification" of the resolver that re-admits a gated clock is a red
# build rather than a silent loss of teeth.
st_dir=""
st_total=0

st_case() { # st_case pass|fail <name> <substring the finding must contain>; fixture on stdin
  local expect="$1" name="$2" want="$3" f out
  st_total=$((st_total + 1))
  f="$st_dir/case_$st_total.v"
  cat > "$f"
  out=$(req001_scan "$f")
  if [ "$expect" = pass ]; then
    if [ -z "$out" ]; then pass "self-test: $name — clean, as required"; return 0; fi
    fail "self-test: $name — expected NO finding, got one (false positive):"
    printf '%s\n' "$out" | sed 's/^/         /'
    return 1
  fi
  if [ -z "$out" ]; then
    fail "self-test: $name — expected a REQ-001 finding, got none (the rule lost its teeth)"
    return 1
  fi
  if [ -n "$want" ] && ! printf '%s' "$out" | grep -qF -- "$want"; then
    fail "self-test: $name — flagged, but not for the expected reason ('$want'):"
    printf '%s\n' "$out" | sed 's/^/         /'
    return 1
  fi
  pass "self-test: $name — flagged, as required"
}

selftest() {
  st_dir=$(mktemp -d) || { fail "self-test: mktemp failed"; return 1; }

  # ---------------------------------------------------------------- positives
  st_case pass "one-hop port copy, assign above its use (the word_counter shape)" '' <<'FIXTURE'
module m (
    clock,
    q
);
    input clock;
    output q;
    wire _6;
    reg _11;
    assign _6 = clock;
    always @(posedge _6) begin
        _11 <= 1'b1;
    end
    assign q = _11;
endmodule
FIXTURE

  st_case pass "two-hop rename chain (the DEPTH case the old resolver missed)" '' <<'FIXTURE'
module m (
    clock,
    q
);
    input clock;
    output q;
    wire _19;
    wire _20;
    reg _11;
    assign _19 = clock;
    assign _20 = _19;
    always @(posedge _20) begin
        _11 <= 1'b1;
    end
    assign q = _11;
endmodule
FIXTURE

  st_case pass "port copy BELOW its use (the ORDER case the old resolver missed)" '' <<'FIXTURE'
module m (
    clock,
    q
);
    input clock;
    output q;
    wire _20;
    reg _11;
    always @(posedge _20) begin
        _11 <= 1'b1;
    end
    assign _20 = clock;
    assign q = _11;
endmodule
FIXTURE

  st_case pass "three-hop chain declared out of order, below its use" '' <<'FIXTURE'
module m (
    clock,
    q
);
    input clock;
    output q;
    reg _11;
    always @(posedge _22) begin
        _11 <= 1'b1;
    end
    assign _22 = _21;
    assign _20 = clock;
    assign _21 = _20;
    assign q = _11;
endmodule
FIXTURE

  st_case pass "hierarchical parent fans the clock port unmodified into a child" '' <<'FIXTURE'
module child (
    clock,
    q
);
    input clock;
    output q;
    wire _6;
    reg _11;
    assign _6 = clock;
    always @(posedge _6) begin
        _11 <= 1'b1;
    end
    assign q = _11;
endmodule
module parent (
    clock,
    q
);
    input clock;
    output q;
    wire _6;
    wire _10;
    assign _6 = clock;
    child
        the_child
        ( .clock(_6),
          .q(_10) );
    assign q = _10;
endmodule
FIXTURE

  st_case pass "combinational module: no clock port, no edge (the crc32_eth shape)" '' <<'FIXTURE'
module comb (
    d,
    q
);
    input [7:0] d;
    output [7:0] q;
    wire [7:0] _3;
    assign _3 = d ^ 8'b10101010;
    assign q = _3;
endmodule
FIXTURE

  # ---------------------------------------------------------------- negatives
  st_case fail "GATED clock: assign _20 = clock & en;" "not a rename of clock" <<'FIXTURE'
module m (
    clock,
    en,
    q
);
    input clock;
    input en;
    output q;
    wire _20;
    reg _11;
    assign _20 = clock & en;
    always @(posedge _20) begin
        _11 <= 1'b1;
    end
    assign q = _11;
endmodule
FIXTURE

  st_case fail "gated clock reached through a rename chain" "not a rename of clock" <<'FIXTURE'
module m (
    clock,
    en,
    q
);
    input clock;
    input en;
    output q;
    reg _11;
    assign _19 = clock & en;
    assign _20 = _19;
    always @(posedge _20) begin
        _11 <= 1'b1;
    end
    assign q = _11;
endmodule
FIXTURE

  st_case fail "SECOND clock domain: alias renames a different input port" "does not resolve to clock" <<'FIXTURE'
module m (
    clock,
    clock2,
    q
);
    input clock;
    input clock2;
    output q;
    wire _20;
    reg _11;
    assign _20 = clock2;
    always @(posedge _20) begin
        _11 <= 1'b1;
    end
    assign q = _11;
endmodule
FIXTURE

  st_case fail "DERIVED clock: edge on a register output (a divider)" "has no driver" <<'FIXTURE'
module m (
    clock,
    q
);
    input clock;
    output q;
    wire _6;
    reg _20;
    reg _11;
    assign _6 = clock;
    always @(posedge _6) begin
        _20 <= ~_20;
    end
    always @(posedge _20) begin
        _11 <= 1'b1;
    end
    assign q = _11;
endmodule
FIXTURE

  st_case fail "negedge on an otherwise well-resolved alias" "negedge" <<'FIXTURE'
module m (
    clock,
    q
);
    input clock;
    output q;
    wire _6;
    reg _11;
    assign _6 = clock;
    always @(negedge _6) begin
        _11 <= 1'b1;
    end
    assign q = _11;
endmodule
FIXTURE

  st_case fail "two edge terms in one sensitivity list" "more than one edge term" <<'FIXTURE'
module m (
    clock,
    rst,
    q
);
    input clock;
    input rst;
    output q;
    wire _6;
    wire _7;
    reg _11;
    assign _6 = clock;
    assign _7 = rst;
    always @(posedge _6 or posedge _7) begin
        _11 <= 1'b1;
    end
    assign q = _11;
endmodule
FIXTURE

  st_case fail "CROSS-MODULE alias leak: _20 renames clock in a, is gated in b" "not a rename of clock" <<'FIXTURE'
module a (
    clock,
    q
);
    input clock;
    output q;
    wire _20;
    reg _11;
    assign _20 = clock;
    always @(posedge _20) begin
        _11 <= 1'b1;
    end
    assign q = _11;
endmodule
module b (
    clock,
    en,
    q
);
    input clock;
    input en;
    output q;
    wire _20;
    reg _11;
    assign _20 = clock & en;
    always @(posedge _20) begin
        _11 <= 1'b1;
    end
    assign q = _11;
endmodule
FIXTURE

  st_case fail "clock GATED AT THE INSTANTIATION, child body clean" "instantiated .clock()" <<'FIXTURE'
module child (
    clock,
    q
);
    input clock;
    output q;
    wire _6;
    reg _11;
    assign _6 = clock;
    always @(posedge _6) begin
        _11 <= 1'b1;
    end
    assign q = _11;
endmodule
module parent (
    clock,
    en,
    q
);
    input clock;
    input en;
    output q;
    wire _6;
    wire _10;
    assign _6 = clock & en;
    child
        the_child
        ( .clock(_6),
          .q(_10) );
    assign q = _10;
endmodule
FIXTURE

  st_case fail "edge in a module that declares no clock input port" "no clock input port" <<'FIXTURE'
module m (
    tick,
    q
);
    input tick;
    output q;
    wire _6;
    reg _11;
    assign _6 = tick;
    always @(posedge _6) begin
        _11 <= 1'b1;
    end
    assign q = _11;
endmodule
FIXTURE

  # The realistic form of "clock is not the port": an internally generated wire
  # that merely carries the name. The no-port guard is what catches it — the
  # name `clock` is never a root on its own, only the declared input port is.
  st_case fail "a local wire named clock, generated inside the module" "no clock input port" <<'FIXTURE'
module m (
    osc,
    en,
    q
);
    input osc;
    input en;
    output q;
    wire clock;
    wire _6;
    reg _11;
    assign clock = osc & en;
    assign _6 = clock;
    always @(posedge _6) begin
        _11 <= 1'b1;
    end
    assign q = _11;
endmodule
FIXTURE

  # Belt and braces for the second guard: the port exists AND is re-driven.
  # Malformed Verilog, which is the point — the resolver must not root on the
  # name when the name is being assigned to.
  st_case fail "clock port present but also assigned inside the module" "assigned inside module" <<'FIXTURE'
module m (
    clock,
    en,
    q
);
    input clock;
    input en;
    output q;
    wire _6;
    reg _11;
    assign clock = clock & en;
    assign _6 = clock;
    always @(posedge _6) begin
        _11 <= 1'b1;
    end
    assign q = _11;
endmodule
FIXTURE

  rm -rf "$st_dir"
}

if [ "${1:-}" = "--self-test" ]; then
  printf 'REQ-001 edge-resolution self-test (WO-0028)\n'
  selftest
  printf '\n%d self-test case(s) run, %d failure(s)\n' "$checks" "$failures"
  [ "$failures" -eq 0 ]
  exit
fi

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
# The scan itself is req001_scan() above — shared verbatim with --self-test, so
# the cases the self-test pins are the cases that run here. It reports both
# halves of REQ-001's verification column: an edge expression that does not
# resolve to that module's own clock port, and any other signal in an edge
# position (negedge, or more than one edge term).
req001_bad=$(req001_scan $VFILES)
edge_count=$(grep -hcE 'posedge|negedge' $VFILES | awk '{ s += $1 } END { print s + 0 }')
clock_conn=$(grep -hcE '\.clock[ \t]*\(' $VFILES | awk '{ s += $1 } END { print s + 0 }')
if [ -n "$req001_bad" ]; then
  fail "REQ-001 single clock domain: an edge expression does not resolve to clock"
  printf '%s\n' "$req001_bad" | sed 's/^/      /'
  note "resolution follows pure renames (assign <wire> = <wire>;) only, per module, transitively"
  note "from that module's own clock input port — a gate or a derived signal cannot resolve"
else
  pass "REQ-001 single clock domain: all $edge_count edge expression(s) and $clock_conn instantiated .clock() connection(s) resolve to the clock port"
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
