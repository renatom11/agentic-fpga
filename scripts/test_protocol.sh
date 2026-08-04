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
# expect_fail asserts BOTH that the command failed AND that it failed for the
# named reason — a non-zero exit alone would let a scenario pass on an
# unrelated rejection (AUD-0001-F1).
expect_fail() {
  local d="$1" pat="$2"; shift 2
  local out
  if out=$("$@" 2>&1); then
    bad "$d (unexpectedly accepted)"
  elif [ -n "$pat" ] && ! printf '%s\n' "$out" | grep -qE "$pat"; then
    bad "$d (rejected, but for the wrong reason: $(printf '%s\n' "$out" | grep -i 'VIOLATION\|fatal' | tail -1))"
  else
    ok "$d"
  fi
}

# ---- scratch repo -----------------------------------------------------------
cd "$SANDBOX"
git init -q -b scratch .
git config user.email test@example.invalid
git config user.name protocol-test
mkdir -p scripts
cp "$REPO_ROOT"/scripts/policy.sh "$REPO_ROOT"/scripts/agent_commit.sh \
   "$REPO_ROOT"/scripts/check_journals.sh \
   "$REPO_ROOT"/scripts/verify_journal_chain.sh scripts/
chmod +x scripts/*.sh
mkdir -p agents/journals/workers agents/handoffs libs docs/reports/audit test

seed_journal() { # path agent
  mkdir -p "$(dirname "$1")"
  cat > "$1" <<EOF
# Journal: claude_$2_agent
Charter: agents/charters/$2.md
Format: v1 (agents/PROTOCOL.md §4). Append-only below the --- line.
---
EOF
}

# Continuation-volume seed with the ADR-0017 §4.3 frozen header block.
seed_volume() { # path agent volnum continues_from prev_path prev_sha prev_bytes
  mkdir -p "$(dirname "$1")"
  cat > "$1" <<EOF
# Journal: claude_$2_agent — volume $3

- **Agent**: $2 (test)
- **Charter**: agents/charters/$2.md
- **Format**: v1 — entry grammar in agents/PROTOCOL.md §4
- **Volume**: $3
- **Continues-from**: $4
- **Previous-volume**: $5
- **Previous-volume-sha256**: $6
- **Previous-volume-bytes**: $7

This file is APPEND-ONLY. Volume $3 of a chain (ADR-0017 §4.3).
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
  scripts/verify_journal_chain.sh \
  "$J_RTL" "$J_AUD" >> "$J_ORCH"
git add -A
expect_ok "bootstrap commit accepted" \
  scripts/agent_commit.sh --agent orchestrator --entry J-orchestrator-0001 --work-order none -m "bootstrap"

# ---- S2: work without journal -----------------------------------------------
say "S2: work without journal append"
echo x > libs/mod.ml
git add libs/mod.ml
expect_fail "work-only commit rejected (R2)" "R2" \
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
expect_fail "non-append journal edit rejected (R3)" "R3" \
  scripts/agent_commit.sh --agent rtl_lead --entry J-rtl_lead-0002 --work-order WO-0001 -m "tamper"
git reset -q; git checkout -q HEAD -- "$J_RTL" libs/mod.ml

# ---- S5: files-list mismatch ------------------------------------------------
say "S5: Files-in-this-commit mismatch"
echo y >> libs/mod.ml
echo z > libs/other.ml
entry rtl_lead 0002 "claims one file, stages two" libs/mod.ml >> "$J_RTL"
git add libs/mod.ml libs/other.ml "$J_RTL"
expect_fail "files-list mismatch rejected (R4)" "R4" \
  scripts/agent_commit.sh --agent rtl_lead --entry J-rtl_lead-0002 --work-order WO-0001 -m "mismatch"
git reset -q; git checkout -q -- "$J_RTL" libs/mod.ml; rm -f libs/other.ml

# ---- S6: path isolation -----------------------------------------------------
say "S6: rtl_lead staging a test file"
echo t > test/mod_test.ml
entry rtl_lead 0002 "rtl touches tests" test/mod_test.ml >> "$J_RTL"
git add test/mod_test.ml "$J_RTL"
expect_fail "rtl_lead writing test/ rejected (R7)" "R7" \
  scripts/agent_commit.sh --agent rtl_lead --entry J-rtl_lead-0002 --work-order WO-0001 -m "cross-scope"
git reset -q; git checkout -q -- "$J_RTL"; rm -f test/mod_test.ml

say "S6b: auditor staging outside docs/reports/audit/"
echo a > libs/hack.ml
entry auditor 0001 "auditor fixes code" libs/hack.ml >> "$J_AUD"
git add libs/hack.ml "$J_AUD"
expect_fail "auditor writing libs/ rejected (R7)" "R7" \
  scripts/agent_commit.sh --agent auditor --entry J-auditor-0001 --work-order none -m "auditor-fix"
git reset -q; git checkout -q -- "$J_AUD"; rm -f libs/hack.ml

# ---- S7: non-monotonic entry id ---------------------------------------------
say "S7: non-monotonic entry number"
echo w >> libs/mod.ml
entry rtl_lead 0005 "skips ahead" libs/mod.ml >> "$J_RTL"
git add libs/mod.ml "$J_RTL"
expect_fail "entry 0005 after 0001 rejected (R5)" "R5" \
  scripts/agent_commit.sh --agent rtl_lead --entry J-rtl_lead-0005 --work-order WO-0001 -m "skip"
git reset -q; git checkout -q -- "$J_RTL" libs/mod.ml

# ---- S8: modifying another agent's journal ----------------------------------
say "S8: commit touching a foreign journal with entries"
echo w >> libs/mod.ml
entry rtl_lead 0002 "also edits orchestrator journal" libs/mod.ml >> "$J_RTL"
echo "sneaky line" >> "$J_ORCH"
git add libs/mod.ml "$J_RTL" "$J_ORCH"
expect_fail "foreign journal modification rejected (R8)" "R8" \
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
expect_fail "raw git commit caught by check_journals.sh" "R2|R6" \
  scripts/check_journals.sh --all
git reset -q --hard HEAD~1

# ---- S12: history rewrite of a journal is caught ----------------------------
say "S12: rewriting journal history is caught by range check"
git checkout -q -b rewrite
sed -i 's/test reasoning/SCRUBBED/' "$J_ORCH"
entry orchestrator 0002 "well-formed entry riding a scrubbed journal" >> "$J_ORCH"
git add "$J_ORCH"
# Trailers are deliberately well-formed so R6 cannot fire first — this must be
# caught by the append-only byte-prefix check (R3) and nothing else.
git commit -q -F - <<'MSG'
scrub with valid trailers

Agent: orchestrator
Work-Order: none
Journal-Entry: J-orchestrator-0002
Journal-Only: true
MSG
expect_fail "journal rewrite caught by append-only check (R3)" "R3" scripts/check_journals.sh --all
git checkout -q scratch
git branch -q -D rewrite

# ---- S13: foreign journal seed that already contains entries ----------------
say "S13: foreign seed containing entries"
J_DV=agents/journals/claude_dv_lead_agent.md
seed_journal "$J_DV" dv_lead
entry dv_lead 0001 "smuggled entry inside a seed" >> "$J_DV"
echo n1 > docs/reports/audit/note.md
entry auditor 0001 "audit note with dirty seed" docs/reports/audit/note.md "$J_DV" >> "$J_AUD"
git add docs/reports/audit/note.md "$J_DV" "$J_AUD"
expect_fail "entry-bearing foreign seed rejected (R8)" "R8" \
  scripts/agent_commit.sh --agent auditor --entry J-auditor-0001 --work-order none -m "dirty seed"
git reset -q; git checkout -q -- "$J_AUD"; rm -f "$J_DV" docs/reports/audit/note.md

# ---- S14: journal deletion --------------------------------------------------
say "S14: staged journal deletion"
git rm -q -f "$J_RTL"
entry orchestrator 0002 "delete a journal" "$J_RTL" >> "$J_ORCH"
git add "$J_ORCH"
expect_fail "journal deletion rejected (R3)" "R3" \
  scripts/agent_commit.sh --agent orchestrator --entry J-orchestrator-0002 --work-order none -m "delete"
git reset -q --hard HEAD

# ---- S15: two entry headers in one append -----------------------------------
say "S15: two entries appended in one commit"
echo m >> libs/mod.ml
entry rtl_lead 0003 "first of two" libs/mod.ml >> "$J_RTL"
entry rtl_lead 0004 "second of two" >> "$J_RTL"
git add libs/mod.ml "$J_RTL"
expect_fail "multi-entry append rejected (R5)" "exactly one new entry" \
  scripts/agent_commit.sh --agent rtl_lead --entry J-rtl_lead-0003 --work-order WO-0001 -m "two entries"
git reset -q; git checkout -q -- "$J_RTL" libs/mod.ml

# ---- S16: --entry does not match the appended header ------------------------
say "S16: trailer/entry vs appended-header mismatch"
echo m >> libs/mod.ml
entry rtl_lead 0003 "header says 0003" libs/mod.ml >> "$J_RTL"
git add libs/mod.ml "$J_RTL"
expect_fail "mismatched --entry rejected (R6)" "does not match --entry" \
  scripts/agent_commit.sh --agent rtl_lead --entry J-rtl_lead-0004 --work-order WO-0001 -m "mismatch"
git reset -q; git checkout -q -- "$J_RTL" libs/mod.ml

# ---- S17: --journal-only with staged work products --------------------------
say "S17: journal-only flag with work staged"
echo m >> libs/mod.ml
entry rtl_lead 0003 "claims journal-only" >> "$J_RTL"
git add libs/mod.ml "$J_RTL"
expect_fail "journal-only with work rejected (R2)" "journal-only" \
  scripts/agent_commit.sh --agent rtl_lead --entry J-rtl_lead-0003 --work-order none -m "jo" --journal-only
git reset -q; git checkout -q -- "$J_RTL" libs/mod.ml

# ---- S18: entry missing Files-in-this-commit section ------------------------
say "S18: entry without Files-in-this-commit"
echo m >> libs/mod.ml
cat >> "$J_RTL" <<'EOF'

## [J-rtl_lead-0003] 2026-08-01T00:00:00Z | task:none | no files section
### Trigger
x
### Reasoning
x
EOF
git add libs/mod.ml "$J_RTL"
expect_fail "missing files section rejected (R4)" "R4" \
  scripts/agent_commit.sh --agent rtl_lead --entry J-rtl_lead-0003 --work-order none -m "nofiles"
git reset -q; git checkout -q -- "$J_RTL" libs/mod.ml

# ---- S19: architect deny-inside-allow ordering ------------------------------
say "S19: architect_docs_lead staging docs/reports/audit/"
J_ARCH=agents/journals/claude_architect_docs_lead_agent.md
seed_journal "$J_ARCH" architect_docs_lead
echo x > docs/reports/audit/fake.md
entry architect_docs_lead 0001 "architect writes into audit dir" docs/reports/audit/fake.md >> "$J_ARCH"
git add docs/reports/audit/fake.md "$J_ARCH"
expect_fail "architect blocked from docs/reports/audit (R7)" "R7" \
  scripts/agent_commit.sh --agent architect_docs_lead --entry J-architect_docs_lead-0001 --work-order none -m "deny-order"
git reset -q; rm -f "$J_ARCH" docs/reports/audit/fake.md

# ---- S20: worker may stage its WO- Return log -------------------------------
say "S20: worker commit touching agents/handoffs/"
J_TBW=agents/journals/workers/claude_tb_writer_agent.md
seed_journal "$J_TBW" tb_writer
echo bench > test/bench.ml
echo "RETURNED" > agents/handoffs/WO-0002_bench.md
entry tb_writer 0001 "bench + WO return log" test/bench.ml agents/handoffs/WO-0002_bench.md >> "$J_TBW"
git add test/bench.ml agents/handoffs/WO-0002_bench.md "$J_TBW"
expect_ok "tb_writer WO- return accepted (COH-1 fix)" \
  scripts/agent_commit.sh --agent tb_writer --entry J-tb_writer-0001 --work-order WO-0002 -m "bench return"

# ---- S21: protected key via --extra-trailer ---------------------------------
say "S21: --extra-trailer with protected key"
entry orchestrator 0002 "extra trailer abuse" >> "$J_ORCH"
git add "$J_ORCH"
expect_fail "protected extra trailer rejected (R6)" "R6" \
  scripts/agent_commit.sh --agent orchestrator --entry J-orchestrator-0002 --work-order none \
    -m "abuse" --journal-only --extra-trailer "Agent: auditor"
git reset -q; git checkout -q -- "$J_ORCH"

# ---- S22: merge commits — trivial passes, content-bearing fails --------------
say "S22: merge-commit handling in range check"
git checkout -q -b side
echo side > libs/side.ml
entry rtl_lead 0003 "side branch work" libs/side.ml >> "$J_RTL"
git add libs/side.ml "$J_RTL"
scripts/agent_commit.sh --agent rtl_lead --entry J-rtl_lead-0003 --work-order WO-0001 -m "side work" > /dev/null
git checkout -q scratch
git merge -q --no-ff side -m "milestone merge" > /dev/null 2>&1
expect_ok "trivial (content-free) merge accepted (R9)" scripts/check_journals.sh --all
git cat-file blob "HEAD:libs/side.ml" > /dev/null   # sanity: merged content present
echo sneak > libs/sneak.ml
git add libs/sneak.ml
git commit -q --amend --no-edit
expect_fail "content-bearing merge rejected (R9)" "R9" scripts/check_journals.sh --all
git reset -q --hard HEAD~1
git branch -q -D side

# ---- S23: duplicate protected trailer (AUD-0001-F2) -------------------------
say "S23: duplicate Agent: trailer in a hand-made commit"
echo dup > libs/dup.ml
entry rtl_lead 0004 "dup trailer" libs/dup.ml >> "$J_RTL"
git add libs/dup.ml "$J_RTL"
git commit -q -F - <<'MSG'
duplicate agent trailer

Agent: rtl_lead
Agent: auditor
Work-Order: none
Journal-Entry: J-rtl_lead-0004
MSG
expect_fail "duplicate protected trailer rejected (R6)" "duplicate" \
  scripts/check_journals.sh --all
git reset -q --hard HEAD~1

# ---- S24: octopus merge is refused outright (AUD-0001-F2) -------------------
say "S24: octopus merge commit"
# Two branches touching DIFFERENT journals so the merge itself is conflict-free
# and an actual 3-parent commit gets created for the checker to reject.
RL_LAST=$(grep -oE "^## \[J-rtl_lead-[0-9]{4}\]" "$J_RTL" | grep -oE "[0-9]{4}" | tail -1)
RL_NEXT=$(printf "%04d" $((10#$RL_LAST + 1)))
OR_LAST=$(grep -oE "^## \[J-orchestrator-[0-9]{4}\]" "$J_ORCH" | grep -oE "[0-9]{4}" | tail -1)
OR_NEXT=$(printf "%04d" $((10#$OR_LAST + 1)))
git checkout -q -b oct1
echo o1 > libs/o1.ml
entry rtl_lead "$RL_NEXT" "oct1" libs/o1.ml >> "$J_RTL"
git add libs/o1.ml "$J_RTL"
scripts/agent_commit.sh --agent rtl_lead --entry "J-rtl_lead-$RL_NEXT" --work-order none -m "oct1" > /dev/null
git checkout -q scratch
git checkout -q -b oct2
echo o2 > libs/o2.ml
entry orchestrator "$OR_NEXT" "oct2" libs/o2.ml >> "$J_ORCH"
git add libs/o2.ml "$J_ORCH"
scripts/agent_commit.sh --agent orchestrator --entry "J-orchestrator-$OR_NEXT" --work-order none -m "oct2" > /dev/null
git checkout -q scratch
if git merge -q --no-ff oct1 oct2 -m "octopus" > /dev/null 2>&1; then
  expect_fail "octopus merge rejected (R9)" "octopus" scripts/check_journals.sh --all
  git reset -q --hard HEAD~1
else
  bad "octopus merge could not be created (scenario setup failed)"
  git merge --abort 2>/dev/null || true
fi
git branch -q -D oct1 oct2 2>/dev/null || true

# ---- S25: auditor denied on agents/handoffs (AUD-0002 N4a) ------------------
say "S25: auditor staging a handoff packet"
AUD_NEXT=$( { grep -oE "^## \\[J-auditor-[0-9]{4}\\]" "$J_AUD" || true; } | { grep -oE "[0-9]{4}" || true; } | tail -1 )
AUD_NEXT=$(printf "%04d" $((10#${AUD_NEXT:-0} + 1)))
echo "sneaky verdict edit" >> agents/handoffs/WO-0002_bench.md 2>/dev/null || echo "sneak" > agents/handoffs/WO-0002_bench.md
entry auditor "$AUD_NEXT" "auditor edits a packet" agents/handoffs/WO-0002_bench.md >> "$J_AUD"
git add agents/handoffs/WO-0002_bench.md "$J_AUD"
expect_fail "auditor writing agents/handoffs rejected (R7)" "R7" \
  scripts/agent_commit.sh --agent auditor --entry "J-auditor-$AUD_NEXT" --work-order none -m "packet edit"
git reset -q; git checkout -q HEAD -- "$J_AUD" agents/handoffs/WO-0002_bench.md 2>/dev/null || git checkout -q HEAD -- "$J_AUD"

# ---- S26: body text cannot shadow the final trailer block (AUD-0002 N4b) ----
say "S26: trailer parsing uses the final block only"
OR_LAST=$(grep -oE "^## \\[J-orchestrator-[0-9]{4}\\]" "$J_ORCH" | grep -oE "[0-9]{4}" | tail -1)
OR_NEXT=$(printf "%04d" $((10#$OR_LAST + 1)))
echo trailertest > libs/trailertest.ml
entry orchestrator "$OR_NEXT" "body-line decoy" libs/trailertest.ml >> "$J_ORCH"
git add libs/trailertest.ml "$J_ORCH"
git commit -q -F - <<MSG
decoy commit body mentions
Agent: auditor
mid-message, which must NOT shadow the real trailers below

Agent: orchestrator
Work-Order: none
Journal-Entry: J-orchestrator-$OR_NEXT
MSG
expect_ok "final trailer block wins over body decoy" scripts/check_journals.sh --all

# ---- S27: blob gate (ADR-0002 debt) -----------------------------------------
say "S27: oversized staged file"
OR_LAST=$(grep -oE "^## \\[J-orchestrator-[0-9]{4}\\]" "$J_ORCH" | grep -oE "[0-9]{4}" | tail -1)
OR_NEXT=$(printf "%04d" $((10#$OR_LAST + 1)))
head -c 1500000 /dev/zero > libs/big.bin
entry orchestrator "$OR_NEXT" "big blob" libs/big.bin >> "$J_ORCH"
git add libs/big.bin "$J_ORCH"
expect_fail "1.5MB staged file rejected (blob gate)" "blob threshold" \
  scripts/agent_commit.sh --agent orchestrator --entry "J-orchestrator-$OR_NEXT" --work-order none -m "big"
git reset -q; git checkout -q HEAD -- "$J_ORCH"; rm -f libs/big.bin

# ---- S28: journal carve-out from the blob gate (ADR-0017 D1) -----------------
# A journal past BLOB_MAX commits WITHOUT an override, with WARN-JOURNAL on
# stderr; the gate still refuses non-journal blobs (S27 holds that side).
# JOURNAL_HARD_MAX is raised for this one commit so the property under test
# stays the BLOB-GATE carve-out; the R10 hard threshold has its own scenario
# (S37), which reuses the oversized journal this fixture leaves behind.
say "S28: oversized journal passes the gate with a warning"
OR_LAST=$(grep -oE "^## \\[J-orchestrator-[0-9]{4}\\]" "$J_ORCH" | grep -oE "[0-9]{4}" | tail -1)
OR_NEXT=$(printf "%04d" $((10#$OR_LAST + 1)))
# grow the journal itself past BLOB_MAX with entry padding, then a valid entry
{ printf '%s\n' "### Padding (S28 fixture)"; head -c 1100000 /dev/zero | tr '\0' 'x'; printf '\n'; } >> "$J_ORCH"
entry orchestrator "$OR_NEXT" "oversized journal entry" >> "$J_ORCH"
git add "$J_ORCH"
S28_OUT=$(JOURNAL_HARD_MAX=2000000 scripts/agent_commit.sh --agent orchestrator --entry "J-orchestrator-$OR_NEXT" --work-order none --journal-only -m "S28 oversized journal" 2>&1) \
  && printf '%s\n' "$S28_OUT" | grep -q "WARN-JOURNAL" \
  && ok "oversized journal accepted with WARN-JOURNAL (ADR-0017 D1)" \
  || bad "oversized journal handling (out: $(printf '%s\n' "$S28_OUT" | tail -1))"

# ---- S29: valid rotation commit (ADR-0017 §9a) -------------------------------
# New volume with a well-formed §4.3 header, one entry = predecessor's last
# + 1, predecessor untouched. No rotation mode: an ordinary commit.
say "S29: valid rotation to volume 02"
J_RTL2=agents/journals/claude_rtl_lead_agent.v02.md
RL_LAST=$(grep -oE "^## \[J-rtl_lead-[0-9]{4}\]" "$J_RTL" | grep -oE "[0-9]{4}" | tail -1)
RL_NEXT=$(printf "%04d" $((10#$RL_LAST + 1)))
PREV_SHA=$(git show "HEAD:$J_RTL" | sha256sum | awk '{print $1}')
PREV_BYTES=$(git show "HEAD:$J_RTL" | wc -c)
seed_volume "$J_RTL2" rtl_lead 02 "J-rtl_lead-$RL_LAST" "$J_RTL" "$PREV_SHA" "$PREV_BYTES"
echo r > libs/roll.ml
entry rtl_lead "$RL_NEXT" "rotation to volume 02" libs/roll.ml >> "$J_RTL2"
git add libs/roll.ml "$J_RTL2"
expect_ok "rotation commit accepted (R10, ADR-0017 §4.4)" \
  scripts/agent_commit.sh --agent rtl_lead --entry "J-rtl_lead-$RL_NEXT" --work-order none -m "rotation"
expect_ok "check_journals green over history containing a rotation (R10)" \
  scripts/check_journals.sh --all

# ---- S30: new volume restarting entry ids at 0001 (ADR-0017 §9b) -------------
say "S30: per-volume renumbering"
J_RTL3=agents/journals/claude_rtl_lead_agent.v03.md
RL2_LAST=$(grep -oE "^## \[J-rtl_lead-[0-9]{4}\]" "$J_RTL2" | grep -oE "[0-9]{4}" | tail -1)
SHA2=$(git show "HEAD:$J_RTL2" | sha256sum | awk '{print $1}')
BYTES2=$(git show "HEAD:$J_RTL2" | wc -c)
seed_volume "$J_RTL3" rtl_lead 03 "J-rtl_lead-$RL2_LAST" "$J_RTL2" "$SHA2" "$BYTES2"
entry rtl_lead 0001 "renumbered volume" >> "$J_RTL3"
git add "$J_RTL3"
expect_fail "entry restart at 0001 rejected (R5)" "R5" \
  scripts/agent_commit.sh --agent rtl_lead --entry J-rtl_lead-0001 --work-order none -m "renumber" --journal-only
git reset -q; rm -f "$J_RTL3"

# ---- S31: rotation with a wrong back-link hash (ADR-0017 §9c) ----------------
say "S31: rotation with wrong Previous-volume-sha256"
BOGUS_SHA=0000000000000000000000000000000000000000000000000000000000000000
RL2_NEXT=$(printf "%04d" $((10#$RL2_LAST + 1)))
seed_volume "$J_RTL3" rtl_lead 03 "J-rtl_lead-$RL2_LAST" "$J_RTL2" "$BOGUS_SHA" "$BYTES2"
entry rtl_lead "$RL2_NEXT" "forged back-link" >> "$J_RTL3"
git add "$J_RTL3"
expect_fail "wrong back-link hash rejected (R10)" "Previous-volume-sha256" \
  scripts/agent_commit.sh --agent rtl_lead --entry "J-rtl_lead-$RL2_NEXT" --work-order none -m "bad link" --journal-only
git reset -q; rm -f "$J_RTL3"

# ---- S32: append to a frozen volume (ADR-0017 §9d) ---------------------------
# The regression test for a future "simplification" of volume resolution —
# under the pre-ADR R3 this would pass silently as an ordinary EOF-append.
say "S32: append to a frozen volume"
entry rtl_lead "$RL2_NEXT" "write into frozen volume 01" >> "$J_RTL"
git add "$J_RTL"
expect_fail "append to frozen volume rejected (R3)" "frozen" \
  scripts/agent_commit.sh --agent rtl_lead --entry "J-rtl_lead-$RL2_NEXT" --work-order none -m "frozen" --journal-only
git reset -q; git checkout -q HEAD -- "$J_RTL"

# ---- S33: two own-chain volumes staged (ADR-0017 §9e) ------------------------
say "S33: two volumes of the committing agent's chain staged"
entry rtl_lead "$RL2_NEXT" "active append" >> "$J_RTL2"
echo "late line into frozen volume" >> "$J_RTL"
git add "$J_RTL" "$J_RTL2"
expect_fail "two staged volumes rejected with the R10 message, not R8's" "one journal append per commit" \
  scripts/agent_commit.sh --agent rtl_lead --entry "J-rtl_lead-$RL2_NEXT" --work-order none -m "two vols" --journal-only
git reset -q; git checkout -q HEAD -- "$J_RTL" "$J_RTL2"

# ---- S34: foreign .v02.md seed (ADR-0017 §9f) --------------------------------
say "S34: foreign volume seed"
J_DV2=agents/journals/claude_dv_lead_agent.v02.md
AUD_NEXT=$( { grep -oE "^## \\[J-auditor-[0-9]{4}\\]" "$J_AUD" || true; } | { grep -oE "[0-9]{4}" || true; } | tail -1 )
AUD_NEXT=$(printf "%04d" $((10#${AUD_NEXT:-0} + 1)))
seed_volume "$J_DV2" dv_lead 02 "J-dv_lead-0000" "agents/journals/claude_dv_lead_agent.md" "$BOGUS_SHA" 0
entry auditor "$AUD_NEXT" "pre-empting dv_lead's next volume" "$J_DV2" >> "$J_AUD"
git add "$J_DV2" "$J_AUD"
expect_fail "foreign volume seed rejected (R8 tightened)" "only volume 01 of a chainless agent" \
  scripts/agent_commit.sh --agent auditor --entry "J-auditor-$AUD_NEXT" --work-order none -m "foreign v02"
git reset -q; git checkout -q HEAD -- "$J_AUD"; rm -f "$J_DV2"

# ---- S35: 1.5 MB journal accepted, 1.5 MB blob refused (ADR-0017 §9g) --------
# The carve-out and its boundary in one pair (S27 must also keep passing
# unchanged). H is parameterised out on the journal side so the property
# under test stays the BLOB gate; H itself is S37's subject.
say "S35: the carve-out boundary pair"
RL2_NEXT=$(printf "%04d" $((10#$RL2_LAST + 1)))
head -c 1500000 /dev/zero > libs/big2.bin
entry rtl_lead "$RL2_NEXT" "pair blob" libs/big2.bin >> "$J_RTL2"
git add libs/big2.bin "$J_RTL2"
expect_fail "1.5 MB non-journal blob still refused (blob gate)" "blob threshold" \
  scripts/agent_commit.sh --agent rtl_lead --entry "J-rtl_lead-$RL2_NEXT" --work-order none -m "pair blob"
git reset -q; git checkout -q HEAD -- "$J_RTL2"; rm -f libs/big2.bin
OR_LAST=$(grep -oE "^## \\[J-orchestrator-[0-9]{4}\\]" "$J_ORCH" | grep -oE "[0-9]{4}" | tail -1)
OR_NEXT=$(printf "%04d" $((10#$OR_LAST + 1)))
{ printf '%s\n' "### Padding (S35 fixture)"; head -c 400000 /dev/zero | tr '\0' 'y'; printf '\n'; } >> "$J_ORCH"
entry orchestrator "$OR_NEXT" "1.5 MB journal" >> "$J_ORCH"
git add "$J_ORCH"
S35_OUT=$(JOURNAL_HARD_MAX=2000000 scripts/agent_commit.sh --agent orchestrator --entry "J-orchestrator-$OR_NEXT" --work-order none --journal-only -m "S35 1.5MB journal" 2>&1) \
  && printf '%s\n' "$S35_OUT" | grep -q "WARN-JOURNAL" \
  && ok "1.5 MB journal accepted by the commit gate (D1 carve-out)" \
  || bad "1.5 MB journal handling (out: $(printf '%s\n' "$S35_OUT" | tail -1))"
expect_ok "CI green with 1.5 MB journals in history (R11 journal carve-out, ADR-0017 §6.6)" \
  scripts/check_journals.sh --all

# ---- S36: chain verification, and one flipped byte turning it red (§9h) ------
say "S36: verify_journal_chain green; a flipped frozen byte turns both checks red"
expect_ok "verify_journal_chain green on a tree containing a rotation" \
  scripts/verify_journal_chain.sh
expect_ok "verify_journal_chain --at HEAD green" \
  scripts/verify_journal_chain.sh --at HEAD
sed -i '0,/test reasoning/s//test reasoninh/' "$J_RTL"
expect_fail "flipped byte in a frozen volume caught by the auditor" "Previous-volume-sha256" \
  scripts/verify_journal_chain.sh
git checkout -q HEAD -- "$J_RTL"
sed -i '0,/test reasoning/s//test reasoninh/' "$J_RTL"
git add "$J_RTL"
git commit -q -F - <<MSG
flip a frozen byte with valid trailers

Agent: rtl_lead
Work-Order: none
Journal-Entry: J-rtl_lead-$RL2_NEXT
Journal-Only: true
MSG
expect_fail "the same flip landed as a commit caught by CI (R3)" "frozen" \
  scripts/check_journals.sh --all
git reset -q --hard HEAD~1

# ---- S37: H binds the staged active volume; rotation is the way out ----------
# ADR-0017 §5.2/§6.2 transition semantics: a further append to an over-H
# active volume is refused, naming the rotation procedure; the rotation
# commit of that same oversized journal passes under the DEFAULT H, because
# its staged active volume is the new, small one.
say "S37: hard threshold refuses appends, passes the rotation"
J_ORCH2=agents/journals/claude_orchestrator_agent.v02.md
OR_LAST=$(grep -oE "^## \\[J-orchestrator-[0-9]{4}\\]" "$J_ORCH" | grep -oE "[0-9]{4}" | tail -1)
OR_NEXT=$(printf "%04d" $((10#$OR_LAST + 1)))
entry orchestrator "$OR_NEXT" "append past H" >> "$J_ORCH"
git add "$J_ORCH"
expect_fail "append to over-H journal refused with the rotation message (R10)" \
  "rotate to volume 02 \(R10, ADR-0017 §4.4\)" \
  scripts/agent_commit.sh --agent orchestrator --entry "J-orchestrator-$OR_NEXT" --work-order none -m "past H" --journal-only
git reset -q; git checkout -q HEAD -- "$J_ORCH"
OR_SHA=$(git show "HEAD:$J_ORCH" | sha256sum | awk '{print $1}')
OR_BYTES=$(git show "HEAD:$J_ORCH" | wc -c)
seed_volume "$J_ORCH2" orchestrator 02 "J-orchestrator-$OR_LAST" "$J_ORCH" "$OR_SHA" "$OR_BYTES"
entry orchestrator "$OR_NEXT" "rotation of the oversized journal" >> "$J_ORCH2"
git add "$J_ORCH2"
expect_ok "rotation of the oversized journal accepted under default H (R10)" \
  scripts/agent_commit.sh --agent orchestrator --entry "J-orchestrator-$OR_NEXT" --work-order none -m "rotate orch" --journal-only
expect_ok "check_journals green after the forced rotation" \
  scripts/check_journals.sh --all
expect_ok "verify_journal_chain green with two rotated chains" \
  scripts/verify_journal_chain.sh

# ---- S38: CI blob gate with the journal carve-out (R11, ADR-0017 §6.6) -------
# The §1.2 hole closed: a commit that evades the local gate via its own
# parameterisation no longer lands an oversized blob past CI.
say "S38: CI re-checks the blob gate (R11)"
RL2_LAST=$(grep -oE "^## \[J-rtl_lead-[0-9]{4}\]" "$J_RTL2" | grep -oE "[0-9]{4}" | tail -1)
RL2_NEXT=$(printf "%04d" $((10#$RL2_LAST + 1)))
head -c 1500000 /dev/zero > libs/huge.bin
entry rtl_lead "$RL2_NEXT" "blob past the local gate" libs/huge.bin >> "$J_RTL2"
git add libs/huge.bin "$J_RTL2"
expect_ok "fixture: local gate evaded via its own parameter" \
  env AGENT_COMMIT_BLOB_MAX=2000000 scripts/agent_commit.sh --agent rtl_lead --entry "J-rtl_lead-$RL2_NEXT" --work-order none -m "huge"
expect_fail "CI refuses the oversized blob (R11)" "R11" \
  scripts/check_journals.sh --all
git reset -q --hard HEAD~1

# ---- S39: header-field helper drains its pipe (no SIGPIPE race) --------------
# volume_header_field once exited at the header's end; a `git show` producer
# of a volume larger than the pipe buffer then took SIGPIPE, and pipefail
# turned that scheduling race into journal-check red — green locally, red in
# CI, first seen at 1c3a89d when an active volume crossed 64 KB. The helper
# must consume its whole stream so the pipeline's status is a verdict, never
# a race. The fixture is deterministic: the field sits in the first line and
# 200 KB of body follows, so an early-exit helper always strands the producer.
say "S39: header-field extraction survives an over-buffer volume"
{
  printf -- '- **Volume**: 02\n'
  printf -- '- **Continues-from**: J-x-0001\n'
  printf -- '---\n'
  head -c 200000 /dev/zero | tr '\0' 'x'
  printf '\n'
} > s39_volume.md
if S39_VAL=$(set -o pipefail; . scripts/policy.sh; cat s39_volume.md | volume_header_field Volume) \
   && [ "$S39_VAL" = "02" ]; then
  ok "over-buffer volume read clean: pipeline status 0, field value intact"
else
  bad "header-field pipeline raced or misread (got '${S39_VAL:-}'; SIGPIPE regression)"
fi
rm -f s39_volume.md

# ---- summary ----------------------------------------------------------------
say ""
say "protocol self-test: $PASS passed, $FAIL failed"
[ "$FAIL" -eq 0 ]
