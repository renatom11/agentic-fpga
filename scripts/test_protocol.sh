#!/usr/bin/env bash
# test_protocol.sh — scenario suite proving agent_commit.sh and
# check_journals.sh enforce the commit protocol (agents/PROTOCOL.md §5).
# Builds a scratch repo in a temp dir; never touches the real repo.
#
# Usage: scripts/test_protocol.sh

set -euo pipefail
REPO_ROOT=$(git rev-parse --show-toplevel)
SANDBOX=$(mktemp -d)
trap 'rm -rf "$SANDBOX"' EXIT

PASS=0 FAIL=0

say()  { printf '%s\n' "$*"; }
ok()   { PASS=$((PASS + 1)); say "  PASS: $*"; }
bad()  { FAIL=$((FAIL + 1)); say "  FAIL: $*"; }

# expect_ok / expect_fail run a command and check its exit status.
expect_ok()   { local d="$1"; shift; if "$@" > /dev/null 2>&1; then ok "$d"; else bad "$d (unexpectedly rejected)"; fi; }
expect_fail() { local d="$1"; shift; if "$@" > /dev/null 2>&1; then bad "$d (unexpectedly accepted)"; else ok "$d"; fi; }

# ---- scratch repo -----------------------------------------------------------
cd "$SANDBOX"
git init -q -b scratch .
git config user.email test@example.invalid
git config user.name protocol-test
mkdir -p scripts
cp "$REPO_ROOT"/scripts/policy.sh "$REPO_ROOT"/scripts/agent_commit.sh \
   "$REPO_ROOT"/scripts/check_journals.sh scripts/
chmod +x scripts/*.sh
mkdir -p agents/journals/workers libs docs/reports/audit test

seed_journal() { # path agent
  mkdir -p "$(dirname "$1")"
  cat > "$1" <<EOF
# Journal: claude_$2_agent
Charter: agents/charters/$2.md
Format: v1 (agents/PROTOCOL.md §4). Append-only below the --- line.
---
EOF
}

entry() { # agent NNNN title files...
  local agent="$1" num="$2" title="$3"; shift 3
  cat <<EOF

## [J-$agent-$num] 2026-08-01T00:00:00Z | task:none | $title
### Trigger
test scenario
### Inputs
none
### Reasoning
test reasoning
### Actions
test actions
### Evidence
none
### Outcome
done
### Open-questions
none
### Files-in-this-commit
EOF
  if [ $# -eq 0 ]; then
    echo "- (none)"
  else
    local f; for f in "$@"; do echo "- $f"; done
  fi
}

J_ORCH=agents/journals/claude_orchestrator_agent.md
J_RTL=agents/journals/claude_rtl_lead_agent.md
J_AUD=agents/journals/claude_auditor_agent.md

# ---- S1: bootstrap commit (work + own entry + foreign seeds) ----------------
say "S1: bootstrap commit with foreign journal seeds"
seed_journal "$J_ORCH" orchestrator
seed_journal "$J_RTL" rtl_lead
seed_journal "$J_AUD" auditor
echo hello > README.md
entry orchestrator 0001 "bootstrap" README.md \
  scripts/agent_commit.sh scripts/check_journals.sh scripts/policy.sh \
  "$J_RTL" "$J_AUD" >> "$J_ORCH"
git add -A
expect_ok "bootstrap commit accepted" \
  scripts/agent_commit.sh --agent orchestrator --entry J-orchestrator-0001 --work-order none -m "bootstrap"

# ---- S2: work without journal -----------------------------------------------
say "S2: work without journal append"
echo x > libs/mod.ml
git add libs/mod.ml
expect_fail "work-only commit rejected (R2)" \
  scripts/agent_commit.sh --agent rtl_lead --entry J-rtl_lead-0001 --work-order WO-0001 -m "no journal"
git reset -q

# ---- S3: valid rtl_lead commit ----------------------------------------------
say "S3: valid rtl_lead commit"
entry rtl_lead 0001 "add module" libs/mod.ml >> "$J_RTL"
git add libs/mod.ml "$J_RTL"
expect_ok "rtl_lead commit accepted" \
  scripts/agent_commit.sh --agent rtl_lead --entry J-rtl_lead-0001 --work-order WO-0001 -m "add module"

# ---- S4: journal tamper (edit above EOF) ------------------------------------
say "S4: tampering with an existing journal entry"
sed -i 's/test reasoning/REVISED HISTORY/' "$J_RTL"
entry rtl_lead 0002 "tamper attempt" libs/mod.ml >> "$J_RTL"
echo y >> libs/mod.ml
git add libs/mod.ml "$J_RTL"
expect_fail "non-append journal edit rejected (R3)" \
  scripts/agent_commit.sh --agent rtl_lead --entry J-rtl_lead-0002 --work-order WO-0001 -m "tamper"
git checkout -q -- "$J_RTL"; git reset -q; git checkout -q -- libs/mod.ml

# ---- S5: files-list mismatch ------------------------------------------------
say "S5: Files-in-this-commit mismatch"
echo y >> libs/mod.ml
echo z > libs/other.ml
entry rtl_lead 0002 "claims one file, stages two" libs/mod.ml >> "$J_RTL"
git add libs/mod.ml libs/other.ml "$J_RTL"
expect_fail "files-list mismatch rejected (R4)" \
  scripts/agent_commit.sh --agent rtl_lead --entry J-rtl_lead-0002 --work-order WO-0001 -m "mismatch"
git reset -q; git checkout -q -- "$J_RTL" libs/mod.ml; rm -f libs/other.ml

# ---- S6: path isolation -----------------------------------------------------
say "S6: rtl_lead staging a test file"
echo t > test/mod_test.ml
entry rtl_lead 0002 "rtl touches tests" test/mod_test.ml >> "$J_RTL"
git add test/mod_test.ml "$J_RTL"
expect_fail "rtl_lead writing test/ rejected (R7)" \
  scripts/agent_commit.sh --agent rtl_lead --entry J-rtl_lead-0002 --work-order WO-0001 -m "cross-scope"
git reset -q; git checkout -q -- "$J_RTL"; rm -f test/mod_test.ml

say "S6b: auditor staging outside docs/reports/audit/"
echo a > libs/hack.ml
entry auditor 0001 "auditor fixes code" libs/hack.ml >> "$J_AUD"
git add libs/hack.ml "$J_AUD"
expect_fail "auditor writing libs/ rejected (R7)" \
  scripts/agent_commit.sh --agent auditor --entry J-auditor-0001 --work-order none -m "auditor-fix"
git reset -q; git checkout -q -- "$J_AUD"; rm -f libs/hack.ml

# ---- S7: non-monotonic entry id ---------------------------------------------
say "S7: non-monotonic entry number"
echo w >> libs/mod.ml
entry rtl_lead 0005 "skips ahead" libs/mod.ml >> "$J_RTL"
git add libs/mod.ml "$J_RTL"
expect_fail "entry 0005 after 0001 rejected (R5)" \
  scripts/agent_commit.sh --agent rtl_lead --entry J-rtl_lead-0005 --work-order WO-0001 -m "skip"
git reset -q; git checkout -q -- "$J_RTL" libs/mod.ml

# ---- S8: modifying another agent's journal ----------------------------------
say "S8: commit touching a foreign journal with entries"
echo w >> libs/mod.ml
entry rtl_lead 0002 "also edits orchestrator journal" libs/mod.ml >> "$J_RTL"
echo "sneaky line" >> "$J_ORCH"
git add libs/mod.ml "$J_RTL" "$J_ORCH"
expect_fail "foreign journal modification rejected (R8)" \
  scripts/agent_commit.sh --agent rtl_lead --entry J-rtl_lead-0002 --work-order WO-0001 -m "sneak"
git reset -q; git checkout -q -- "$J_RTL" "$J_ORCH" libs/mod.ml

# ---- S9: journal-only commit ------------------------------------------------
say "S9: journal-only commit"
entry rtl_lead 0002 "investigation notes, no work" >> "$J_RTL"
git add "$J_RTL"
expect_ok "journal-only commit accepted" \
  scripts/agent_commit.sh --agent rtl_lead --entry J-rtl_lead-0002 --work-order none -m "notes" --journal-only

# ---- S10: range checker over accumulated history ----------------------------
say "S10: check_journals.sh over the whole scratch history"
expect_ok "range check passes on protocol-compliant history" \
  scripts/check_journals.sh --all

# ---- S11: range checker catches a hand-made bad commit ----------------------
say "S11: hand-made non-compliant commit is caught by CI checker"
echo bad > libs/bad.ml
git add libs/bad.ml
git commit -q -m "raw commit, no protocol"
expect_fail "raw git commit caught by check_journals.sh" \
  scripts/check_journals.sh --all
git reset -q --hard HEAD~1

# ---- S12: history rewrite of a journal is caught ----------------------------
say "S12: rewriting journal history is caught by range check"
git checkout -q -b rewrite
sed -i 's/test reasoning/SCRUBBED/' "$J_ORCH"
git add "$J_ORCH"
git commit -q -m "scrub"
expect_fail "journal rewrite caught (R3/R8)" scripts/check_journals.sh --all
git checkout -q scratch
git branch -q -D rewrite

# ---- summary ----------------------------------------------------------------
say ""
say "protocol self-test: $PASS passed, $FAIL failed"
[ "$FAIL" -eq 0 ]
