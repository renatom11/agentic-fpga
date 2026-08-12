#!/usr/bin/env bash
# policy.sh — shared policy + helpers for the journal/commit protocol.
# Sourced by agent_commit.sh, check_journals.sh and verify_journal_chain.sh.
# See agents/PROTOCOL.md §5-6 and ADR-0017 (journal volume chains).

KNOWN_AGENTS="orchestrator architect_docs_lead rtl_lead rtl_lead_md dv_lead auditor rtl_module_dev tb_writer data_wrangler formal_dv"
WORKER_AGENTS="rtl_module_dev tb_writer data_wrangler formal_dv"

# ADR-0017 D4: size thresholds on the ACTIVE volume. S (soft, warn) is
# anchored to the 256 KiB Read-tool limit (§5.1: one volume should be one
# readable unit); H (hard, refuse) is 2S. Both are parameters: changing them
# is a policy edit, not an ADR, provided the anchor is restated.
JOURNAL_SOFT_MAX="${JOURNAL_SOFT_MAX:-262144}"
JOURNAL_HARD_MAX="${JOURNAL_HARD_MAX:-524288}"

# ADR-0021 §6: WARN-STAMP band (advisory, never a refusal, both surfaces).
# FAST anchor: the auditor's measured band — 0 of 16 false positives on
# known-good behaviour; 369 of 371 measured violations are on this side.
# SLOW anchor: the decided ±60 symmetric ONLY — FINDING F-0024-1 (auditor)
# records that no slow-side measurement anchors this default; a correction is
# a policy edit that restates this anchor. LIST_MAX: per-entry listing cap in
# --range mode, sized so an ordinary push (1–5 commits) always itemises.
JOURNAL_STAMP_FAST_MAX="${JOURNAL_STAMP_FAST_MAX:-3600}"
JOURNAL_STAMP_SLOW_MAX="${JOURNAL_STAMP_SLOW_MAX:-3600}"
JOURNAL_STAMP_LIST_MAX="${JOURNAL_STAMP_LIST_MAX:-20}"

# ADR-0021 §2.2: extract the leading ISO-8601 token of the single appended
# entry header. Strip through the FIRST "] " (a title containing "]" breaks a
# greedy strip — J-dv_lead-0189 §1.7), then match the leading token only;
# never hand the whole field to date(1). Prints the token, or nothing.
stamp_of_entry_header() { # reads the appended region on stdin; args: agent
  local hdr rest
  hdr=$(grep -m1 -E "^## \[J-$1-[0-9]{4}\]" || true)
  [ -n "$hdr" ] || return 0
  rest="${hdr#*\] }"
  printf '%s' "$rest" | grep -oE '^[0-9]{4}-[0-9]{2}-[0-9]{2}T[0-9]{2}:[0-9]{2}(:[0-9]{2})?Z' || true
}

# ADR-0021 §2.5 F4: probe GNU date -d once per run; advisory checks degrade
# gracefully rather than redden a build on a portability difference.
have_gnu_date() {
  date -u -d '2026-01-01T00:00Z' +%s > /dev/null 2>&1
}

is_known_agent() {
  local a
  for a in $KNOWN_AGENTS; do [ "$a" = "$1" ] && return 0; done
  return 1
}

is_worker_agent() {
  local a
  for a in $WORKER_AGENTS; do [ "$a" = "$1" ] && return 0; done
  return 1
}

# ---- Journal volume chains (ADR-0017 §4, §6.1) -------------------------------
# A journal is a CHAIN of volumes. Volume 01 is the historic, unsuffixed path
# (the chain root); volume NN >= 02 is a sibling named
# claude_<agent>_agent.vNN.md. The ACTIVE volume is the highest-numbered one;
# every lower volume is FROZEN. Ordering is numeric on the volume number
# (§4.1: two-digit zero-padding is convention, not the sort key, so a third
# digit never breaks the ordering).

# Chain ROOT (volume 01) for an agent identity — the stable identity of an
# agent's journal. Retained unchanged per ADR-0017 §6.1.
journal_path_for() {
  if is_worker_agent "$1"; then
    echo "agents/journals/workers/claude_$1_agent.md"
  else
    echo "agents/journals/claude_$1_agent.md"
  fi
}

# Is this path a journal file (any volume of any chain)? (INDEX.md and other
# files under agents/journals/ are ordinary work products.)
is_journal_path() {
  case "$1" in
    agents/journals/claude_*_agent.md|agents/journals/workers/claude_*_agent.md) return 0 ;;
    agents/journals/claude_*_agent.v[0-9][0-9].md) return 0 ;;
    agents/journals/workers/claude_*_agent.v[0-9][0-9].md) return 0 ;;
    agents/journals/claude_*_agent.v[0-9][0-9][0-9].md) return 0 ;;
    agents/journals/workers/claude_*_agent.v[0-9][0-9][0-9].md) return 0 ;;
    *) return 1 ;;
  esac
}

# Agent identity from any volume of a chain.
journal_agent_of() {
  basename "$1" | sed -E 's/^claude_(.*)_agent(\.v[0-9]{2,3})?\.md$/\1/'
}

# Volume number (as written in the path, e.g. "02") — "01" for the unsuffixed
# chain root.
journal_volume_of() {
  case "$1" in
    *.v[0-9][0-9].md|*.v[0-9][0-9][0-9].md)
      basename "$1" | sed -E 's/.*\.v([0-9]{2,3})\.md$/\1/' ;;
    *) echo "01" ;;
  esac
}

# Path of volume $2 (decimal, 1-based) of <agent> $1's chain: the root for
# volume 1, else the .vNN sibling.
journal_volume_path_for() {
  local root k
  root=$(journal_path_for "$1")
  k=$((10#$2))
  if [ "$k" -le 1 ]; then
    echo "$root"
  else
    printf '%s.v%02d.md\n' "${root%.md}" "$k"
  fi
}

# Does <path> belong to <agent> $1's volume chain (any volume)?
is_chain_path_of() {
  local root base
  root=$(journal_path_for "$1")
  base="${root%.md}"
  case "$2" in
    "$root"|"$base".v[0-9][0-9].md|"$base".v[0-9][0-9][0-9].md) return 0 ;;
    *) return 1 ;;
  esac
}

# Enumerate the paths under agents/journals/ in the state named by <lister>:
#   index    -> the staged index            (agent_commit.sh)
#   worktree -> the checked-out files       (verify_journal_chain.sh ONLY)
#   <rev>    -> the tree of that commit     (check_journals.sh)
# The enforcement scripts must NEVER enumerate from the filesystem (ADR-0017
# §6.1): a worktree glob in check_journals.sh would validate old commits
# against today's worktree, crediting history with volumes it never
# contained. The worktree lister exists solely for the §6.5 auditor, whose
# subject IS the checkout.
journal_lister_paths() {
  case "$1" in
    index)    git ls-files --cached -- 'agents/journals/' ;;
    worktree) find agents/journals -maxdepth 2 -type f -name 'claude_*_agent*.md' 2>/dev/null | LC_ALL=C sort ;;
    *)        git ls-tree -r --name-only "$1" -- agents/journals/ 2>/dev/null || true ;;
  esac
}

# Content of <path> $2 in the state named by <lister> $1.
journal_show() {
  case "$1" in
    index)    git show ":$2" ;;
    worktree) cat "$2" ;;
    *)        git show "$1:$2" ;;
  esac
}

# journal_chain_for <agent> <lister> — the agent's volume paths, volume 01
# first, ordered NUMERICALLY on the volume number (not a lexicographic path
# sort). Empty output = the agent has no chain in that state.
journal_chain_for() {
  local agent="$1" lister="$2" p
  journal_lister_paths "$lister" | while IFS= read -r p; do
    [ -n "$p" ] || continue
    if is_chain_path_of "$agent" "$p"; then
      printf '%s\t%s\n' "$((10#$(journal_volume_of "$p")))" "$p"
    fi
  done | LC_ALL=C sort -k1,1n | cut -f2
}

# active_journal_for <agent> <lister> — the highest-numbered volume of the
# chain; falls back to the chain root when the agent has no chain yet
# (ADR-0017 §6.2).
active_journal_for() {
  local last
  last=$(journal_chain_for "$1" "$2" | tail -n 1)
  if [ -n "$last" ]; then echo "$last"; else journal_path_for "$1"; fi
}

# From a volume's content on stdin, print the value its frozen header block
# (above the first `---` line) declares for field $1 — e.g. Volume,
# Continues-from, Previous-volume, Previous-volume-sha256 (ADR-0017 §4.3).
# Empty if absent. Drains stdin to EOF instead of exiting at the first `---`:
# an early exit SIGPIPEs a `git show` producer once the volume outgrows the
# pipe buffer, and under `set -o pipefail` that 141 is a scheduling race, not
# a verdict (first seen as journal-check red at 1c3a89d when a 79 KB active
# volume crossed the 64 KB pipe capacity — green locally, red in CI).
volume_header_field() {
  awk -v f="$1" '
    done { next }
    /^---$/ { done = 1; next }
    index($0, "- **" f "**: ") == 1 { print substr($0, length("- **" f "**: ") + 1); done = 1 }
  '
}

# sha256 hex digest of stdin.
sha256_hex() {
  sha256sum | awk '{print $1}'
}

# Path isolation (PROTOCOL §6): may <agent> stage <path> as a work product?
agent_may_write() {
  local agent="$1" path="$2"
  case "$agent" in
    orchestrator)
      return 0 ;;
    architect_docs_lead)
      case "$path" in
        docs/reports/audit/*|docs/reports/latency/*) return 1 ;;
        docs/*|README.md|ORG_CHART.md|agents/handoffs/*) return 0 ;;
        *) return 1 ;;
      esac ;;
    rtl_lead|rtl_lead_md)
      case "$path" in
        libs/*|top/*|bin/*|rtl_snapshots/*|agents/handoffs/*) return 0 ;;
        *) return 1 ;;
      esac ;;
    dv_lead)
      case "$path" in
        test/*|tools/*|docs/reports/latency/*|agents/handoffs/*) return 0 ;;
        *) return 1 ;;
      esac ;;
    auditor)
      case "$path" in
        docs/reports/audit/*) return 0 ;;
        *) return 1 ;;
      esac ;;
    rtl_module_dev)
      case "$path" in
        libs/*|top/*|agents/handoffs/*) return 0 ;;
        *) return 1 ;;
      esac ;;
    tb_writer)
      case "$path" in
        test/*|agents/handoffs/*) return 0 ;;
        *) return 1 ;;
      esac ;;
    data_wrangler)
      case "$path" in
        tools/*|agents/handoffs/*) return 0 ;;
        *) return 1 ;;
      esac ;;
    formal_dv)
      case "$path" in
        test/*|agents/handoffs/*) return 0 ;;
        *) return 1 ;;
      esac ;;
    *)
      return 1 ;;
  esac
}

# Print the last (highest) 4-digit entry number found in journal content on
# stdin, for the given agent; prints 0000 if none. Single-volume primitive —
# for chain-wide answers use chain_last_entry_num.
last_entry_num() {
  local agent="$1"
  local last
  last=$(grep -oE "^## \[J-${agent}-[0-9]{4}\]" | grep -oE '[0-9]{4}' | tail -n 1 || true)
  if [ -z "$last" ]; then echo "0000"; else echo "$last"; fi
}

# Highest entry number across ALL volumes of <agent>'s chain in the state
# named by <lister>; 0000 when the chain is empty. This is what R5 reads
# (ADR-0017 §6.3 — R5 reads the chain, not the file).
chain_last_entry_num() {
  local agent="$1" lister="$2"
  local p last best="0000"
  for p in $(journal_chain_for "$agent" "$lister"); do
    last=$(journal_show "$lister" "$p" | last_entry_num "$agent")
    if [ "$((10#$last))" -gt "$((10#$best))" ]; then best="$last"; fi
  done
  echo "$best"
}

# Count entry headers for the given agent in content on stdin.
count_entries() {
  local agent="$1"
  grep -cE "^## \[J-${agent}-[0-9]{4}\]" || true
}

# From appended journal text on stdin, print the Files-in-this-commit list
# (one path per line; empty output means the list was `- (none)` or absent).
extract_files_list() {
  awk '
    /^### Files-in-this-commit[[:space:]]*$/ { grab = 1; next }
    grab && /^#/ { grab = 0 }
    grab && /^- / {
      p = substr($0, 3)
      gsub(/^[[:space:]]+|[[:space:]]+$/, "", p)
      if (p != "(none)") print p
    }
  '
}

# Does the appended journal text on stdin contain a Files-in-this-commit
# section at all?
has_files_section() {
  grep -qE '^### Files-in-this-commit[[:space:]]*$'
}

# Byte-prefix check: is file $1 a byte-prefix of file $2?
is_byte_prefix() {
  local old="$1" new="$2"
  local old_size new_size
  old_size=$(wc -c < "$old")
  new_size=$(wc -c < "$new")
  [ "$old_size" -le "$new_size" ] || return 1
  head -c "$old_size" "$new" | cmp -s - "$old"
}

fail() {
  echo "PROTOCOL VIOLATION: $*" >&2
  exit 1
}
