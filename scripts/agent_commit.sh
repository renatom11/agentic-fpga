#!/usr/bin/env bash
# agent_commit.sh — the orchestrator's ONLY path to `git commit`.
# Enforces the commit protocol (agents/PROTOCOL.md §5) mechanically, then
# creates the commit with the required trailers.
#
# Usage:
#   scripts/agent_commit.sh --agent NAME --entry J-NAME-NNNN \
#       --work-order WO-NNNN|none -m "commit title" [--journal-only]
#
# Stage everything for the commit first (git add ...), then run this script.

set -euo pipefail
cd "$(git rev-parse --show-toplevel)"
# shellcheck source=policy.sh
. "$(dirname "$0")/policy.sh"

AGENT="" ENTRY="" WORK_ORDER="" TITLE="" JOURNAL_ONLY=0
EXTRA_TRAILERS=()
while [ $# -gt 0 ]; do
  case "$1" in
    --agent) AGENT="$2"; shift 2 ;;
    --entry) ENTRY="$2"; shift 2 ;;
    --work-order) WORK_ORDER="$2"; shift 2 ;;
    -m) TITLE="$2"; shift 2 ;;
    --journal-only) JOURNAL_ONLY=1; shift ;;
    --extra-trailer) EXTRA_TRAILERS+=("$2"); shift 2 ;;
    *) fail "unknown argument: $1" ;;
  esac
done

[ -n "$AGENT" ] && [ -n "$ENTRY" ] && [ -n "$WORK_ORDER" ] && [ -n "$TITLE" ] \
  || fail "usage: agent_commit.sh --agent NAME --entry J-NAME-NNNN --work-order WO-NNNN|none -m TITLE [--journal-only]"
for t in ${EXTRA_TRAILERS[@]+"${EXTRA_TRAILERS[@]}"}; do
  case "$t" in
    Agent:*|Work-Order:*|Journal-Entry:*|Journal-Only:*)
      fail "--extra-trailer may not use protected key: $t (R6)" ;;
  esac
done
is_known_agent "$AGENT" || fail "unknown agent '$AGENT'"
echo "$ENTRY" | grep -qE "^J-${AGENT}-[0-9]{4}$" \
  || fail "entry '$ENTRY' does not match J-${AGENT}-NNNN"

JOURNAL="$(journal_path_for "$AGENT")"

# ---- Gather staged state -----------------------------------------------------
STATUS_LIST=$(git diff --cached --name-status --no-renames)
[ -n "$STATUS_LIST" ] || fail "nothing staged"

OWN_JOURNAL_STAGED=0
FOREIGN_JOURNAL_SEEDS=()
WORK_PATHS=()
while IFS=$'\t' read -r status path; do
  [ -n "$path" ] || continue
  if is_journal_path "$path"; then
    case "$status" in
      D) fail "journal deletion staged: $path (R3 — journals are never deleted)" ;;
      R*|C*) fail "journal rename/copy staged: $path (R3)" ;;
    esac
    if [ "$path" = "$JOURNAL" ]; then
      OWN_JOURNAL_STAGED=1
    else
      # R8: foreign journals only as brand-new, header-only seeds.
      [ "$status" = "A" ] \
        || fail "commit modifies another agent's journal: $path (R8)"
      FOREIGN_JOURNAL_SEEDS+=("$path")
    fi
  else
    WORK_PATHS+=("$path")
  fi
done <<< "$STATUS_LIST"

# ---- R2: coupling ------------------------------------------------------------
[ "$OWN_JOURNAL_STAGED" -eq 1 ] \
  || fail "no staged append to $JOURNAL (R2 — work without journal)"
if [ "$JOURNAL_ONLY" -eq 1 ]; then
  [ "${#WORK_PATHS[@]}" -eq 0 ] \
    || fail "--journal-only but work products are staged: ${WORK_PATHS[*]}"
else
  [ "${#WORK_PATHS[@]}" -gt 0 ] || [ "${#FOREIGN_JOURNAL_SEEDS[@]}" -gt 0 ] \
    || fail "journal staged with no work products — use --journal-only if intended (R2)"
fi

# ---- R8: validate foreign seeds ---------------------------------------------
for seed in ${FOREIGN_JOURNAL_SEEDS[@]+"${FOREIGN_JOURNAL_SEEDS[@]}"}; do
  seed_agent=$(basename "$seed" | sed -E 's/^claude_(.*)_agent\.md$/\1/')
  is_known_agent "$seed_agent" || fail "seed journal for unknown agent: $seed"
  [ "$(journal_path_for "$seed_agent")" = "$seed" ] \
    || fail "seed journal at wrong location: $seed"
  n=$(git show ":$seed" | count_entries "$seed_agent")
  [ "${n:-0}" -eq 0 ] || fail "foreign journal seed contains entries: $seed (R8)"
done

# ---- R3: pure EOF-append on own journal -------------------------------------
TMPDIR_P=$(mktemp -d)
trap 'rm -rf "$TMPDIR_P"' EXIT
git show ":$JOURNAL" > "$TMPDIR_P/staged"
if git cat-file -e "HEAD:$JOURNAL" 2>/dev/null; then
  git show "HEAD:$JOURNAL" > "$TMPDIR_P/head"
else
  : > "$TMPDIR_P/head"   # journal is new in this commit
fi
is_byte_prefix "$TMPDIR_P/head" "$TMPDIR_P/staged" \
  || fail "$JOURNAL is not a pure EOF-append of its previous content (R3)"
head_size=$(wc -c < "$TMPDIR_P/head")
tail -c +"$((head_size + 1))" "$TMPDIR_P/staged" > "$TMPDIR_P/appended"
[ -s "$TMPDIR_P/appended" ] || fail "no appended journal content (R2)"

# ---- R5: exactly one new entry, monotonic -----------------------------------
new_headers=$(grep -cE "^## \[J-${AGENT}-[0-9]{4}\]" "$TMPDIR_P/appended" || true)
[ "$new_headers" -eq 1 ] \
  || fail "appended region must contain exactly one new entry header, found $new_headers"
grep -qF "## [$ENTRY]" "$TMPDIR_P/appended" \
  || fail "appended entry header does not match --entry $ENTRY"
last=$(last_entry_num "$AGENT" < "$TMPDIR_P/head")
expected=$(printf '%04d' "$((10#$last + 1))")
actual=$(echo "$ENTRY" | grep -oE '[0-9]{4}$')
[ "$actual" = "$expected" ] \
  || fail "entry number $actual is not monotonic (last was $last, expected $expected) (R5)"

# ---- R4: Files-in-this-commit set-equality ----------------------------------
has_files_section < "$TMPDIR_P/appended" \
  || fail "new entry lacks a '### Files-in-this-commit' section (R4)"
extract_files_list < "$TMPDIR_P/appended" | LC_ALL=C sort -u > "$TMPDIR_P/claimed"
{
  printf '%s\n' ${WORK_PATHS[@]+"${WORK_PATHS[@]}"}
  printf '%s\n' ${FOREIGN_JOURNAL_SEEDS[@]+"${FOREIGN_JOURNAL_SEEDS[@]}"}
} | grep -v '^$' | LC_ALL=C sort -u > "$TMPDIR_P/staged_list" || true
if ! diff -u "$TMPDIR_P/claimed" "$TMPDIR_P/staged_list" > "$TMPDIR_P/files_diff"; then
  echo "--- claimed vs staged ---" >&2
  cat "$TMPDIR_P/files_diff" >&2
  fail "Files-in-this-commit list does not equal the staged non-journal set (R4)"
fi

# ---- R7: path isolation ------------------------------------------------------
for p in ${WORK_PATHS[@]+"${WORK_PATHS[@]}"}; do
  agent_may_write "$AGENT" "$p" \
    || fail "path outside $AGENT's write scope: $p (R7)"
done

# ---- Commit ------------------------------------------------------------------
{
  echo "$TITLE"
  echo
  echo "Agent: $AGENT"
  echo "Work-Order: $WORK_ORDER"
  echo "Journal-Entry: $ENTRY"
  [ "$JOURNAL_ONLY" -eq 1 ] && echo "Journal-Only: true"
  for t in ${EXTRA_TRAILERS[@]+"${EXTRA_TRAILERS[@]}"}; do echo "$t"; done
} > "$TMPDIR_P/msg"

git commit -F "$TMPDIR_P/msg" --quiet
echo "OK: committed $(git rev-parse --short HEAD) as $AGENT ($ENTRY)"
