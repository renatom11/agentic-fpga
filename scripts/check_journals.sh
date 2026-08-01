#!/usr/bin/env bash
# check_journals.sh — re-verifies the commit protocol (agents/PROTOCOL.md §5)
# over a commit range. Run by CI on every push; also runnable locally.
#
# Usage:
#   scripts/check_journals.sh --all            # every commit reachable from HEAD
#   scripts/check_journals.sh --range A..B     # commits in A..B
#
# Exits nonzero on the first violating commit, naming the rule broken.

set -euo pipefail
cd "$(git rev-parse --show-toplevel)"
# shellcheck source=policy.sh
. "$(dirname "$0")/policy.sh"

MODE="" RANGE=""
case "${1:-}" in
  --all) MODE=all ;;
  --range) MODE=range; RANGE="${2:-}"; [ -n "$RANGE" ] || fail "--range needs A..B" ;;
  *) fail "usage: check_journals.sh --all | --range A..B" ;;
esac

if [ "$MODE" = all ]; then
  COMMITS=$(git rev-list --reverse HEAD)
else
  COMMITS=$(git rev-list --reverse "$RANGE")
fi
[ -n "$COMMITS" ] || { echo "no commits to check"; exit 0; }

TMP=$(mktemp -d)
trap 'rm -rf "$TMP"' EXIT

checked=0
for C in $COMMITS; do
  short=$(git rev-parse --short "$C")

  # Merge commits (R9): constituent commits are checked individually, so a
  # merge itself must be TRIVIAL — its tree must equal one parent's tree,
  # proving it introduces no content of its own (no conflict resolutions).
  nwords=$(git rev-list --parents -n 1 "$C" | wc -w)   # 1 + parent count
  if [ "$nwords" -gt 3 ]; then
    fail "$short: octopus merge commits are forbidden (R9)"
  fi
  if [ "$nwords" -eq 3 ]; then
    t=$(git rev-parse "$C^{tree}")
    p1=$(git rev-parse "$C^1^{tree}")
    p2=$(git rev-parse "$C^2^{tree}")
    if [ "$t" = "$p1" ] || [ "$t" = "$p2" ]; then
      echo "OK: merge $short is content-free (tree equals a parent); constituents checked individually (R9)"
      checked=$((checked + 1))
      continue
    fi
    fail "$short: merge commit introduces content found in neither parent (conflict resolution or divergent auto-merge) (R9)"
  fi

  git show -s --format=%B "$C" > "$TMP/msg"
  # Trailer parsing: only the message's final trailer block counts, and the
  # protected keys must be unique — a crafted body line or duplicate trailer
  # cannot shadow the real one (R6).
  git interpret-trailers --parse < "$TMP/msg" > "$TMP/trailers"
  for key in Agent Journal-Entry Work-Order Journal-Only; do
    n=$(grep -cE "^$key: " "$TMP/trailers" || true)
    [ "$n" -le 1 ] || fail "$short: duplicate '$key:' trailer (R6)"
  done
  get_trailer() { grep -E "^$2: " "$1" | sed -E "s/^$2: //" || true; }
  AGENT=$(get_trailer "$TMP/trailers" Agent)
  ENTRY=$(get_trailer "$TMP/trailers" Journal-Entry)
  WORK_ORDER=$(get_trailer "$TMP/trailers" Work-Order)
  JOURNAL_ONLY=$(get_trailer "$TMP/trailers" Journal-Only)

  [ -n "$AGENT" ] || fail "$short: missing 'Agent:' trailer (R6)"
  is_known_agent "$AGENT" || fail "$short: unknown agent '$AGENT' (R6)"
  [ -n "$ENTRY" ] || fail "$short: missing 'Journal-Entry:' trailer (R6)"
  [ -n "$WORK_ORDER" ] || fail "$short: missing 'Work-Order:' trailer (R6)"
  echo "$ENTRY" | grep -qE "^J-${AGENT}-[0-9]{4}$" \
    || fail "$short: Journal-Entry '$ENTRY' malformed for agent $AGENT (R6)"

  JOURNAL="$(journal_path_for "$AGENT")"

  if [ "$nwords" -eq 2 ]; then
    PARENT=$(git rev-parse "$C^")
    git diff-tree -r --no-renames --no-commit-id --name-status "$PARENT" "$C" > "$TMP/changes"
  else
    PARENT=""
    git diff-tree --root -r --no-renames --no-commit-id --name-status "$C" > "$TMP/changes"
  fi

  OWN_JOURNAL=0
  : > "$TMP/work_paths"
  : > "$TMP/seeds"
  while IFS=$'\t' read -r status path; do
    [ -n "$path" ] || continue
    if is_journal_path "$path"; then
      case "$status" in
        D) fail "$short: journal deleted: $path (R3)" ;;
        R*|C*) fail "$short: journal renamed/copied: $path (R3)" ;;
      esac
      if [ "$path" = "$JOURNAL" ]; then
        OWN_JOURNAL=1
      else
        [ "$status" = "A" ] || fail "$short: modifies another agent's journal: $path (R8)"
        seed_agent=$(basename "$path" | sed -E 's/^claude_(.*)_agent\.md$/\1/')
        is_known_agent "$seed_agent" || fail "$short: seed journal for unknown agent: $path"
        [ "$(journal_path_for "$seed_agent")" = "$path" ] \
          || fail "$short: seed journal at wrong location: $path"
        n=$(git show "$C:$path" | count_entries "$seed_agent")
        [ "${n:-0}" -eq 0 ] || fail "$short: foreign journal seed contains entries: $path (R8)"
        echo "$path" >> "$TMP/seeds"
      fi
    else
      echo "$path" >> "$TMP/work_paths"
    fi
  done < "$TMP/changes"

  [ "$OWN_JOURNAL" -eq 1 ] || fail "$short: no append to $JOURNAL (R2)"

  if [ "$JOURNAL_ONLY" = "true" ]; then
    [ ! -s "$TMP/work_paths" ] \
      || fail "$short: Journal-Only commit stages work products (R2)"
  else
    [ -s "$TMP/work_paths" ] || [ -s "$TMP/seeds" ] \
      || fail "$short: work-less commit lacks 'Journal-Only: true' trailer (R2)"
  fi

  # R3: pure EOF-append relative to parent.
  git show "$C:$JOURNAL" > "$TMP/new"
  if [ -n "$PARENT" ] && git cat-file -e "$PARENT:$JOURNAL" 2>/dev/null; then
    git show "$PARENT:$JOURNAL" > "$TMP/old"
  else
    : > "$TMP/old"
  fi
  is_byte_prefix "$TMP/old" "$TMP/new" \
    || fail "$short: $JOURNAL is not a pure EOF-append (R3)"
  old_size=$(wc -c < "$TMP/old")
  tail -c +"$((old_size + 1))" "$TMP/new" > "$TMP/appended"
  [ -s "$TMP/appended" ] || fail "$short: journal staged with no appended content (R2)"

  # R5: exactly one new entry, matching trailer, monotonic.
  new_headers=$(grep -cE "^## \[J-${AGENT}-[0-9]{4}\]" "$TMP/appended" || true)
  [ "$new_headers" -eq 1 ] \
    || fail "$short: appended region has $new_headers entry headers, expected 1 (R5)"
  grep -qF "## [$ENTRY]" "$TMP/appended" \
    || fail "$short: appended entry does not match trailer $ENTRY (R6)"
  last=$(last_entry_num "$AGENT" < "$TMP/old")
  expected=$(printf '%04d' "$((10#$last + 1))")
  actual=$(echo "$ENTRY" | grep -oE '[0-9]{4}$')
  [ "$actual" = "$expected" ] \
    || fail "$short: entry $actual not monotonic (last $last, expected $expected) (R5)"

  # R4: Files-in-this-commit set-equality (work paths + foreign seeds).
  has_files_section < "$TMP/appended" \
    || fail "$short: entry lacks '### Files-in-this-commit' (R4)"
  extract_files_list < "$TMP/appended" | LC_ALL=C sort -u > "$TMP/claimed"
  cat "$TMP/work_paths" "$TMP/seeds" | LC_ALL=C sort -u > "$TMP/actual_list"
  if ! diff -u "$TMP/claimed" "$TMP/actual_list" > "$TMP/files_diff"; then
    cat "$TMP/files_diff" >&2
    fail "$short: Files-in-this-commit != changed non-journal set (R4)"
  fi

  # R7: path isolation.
  while IFS= read -r p; do
    [ -n "$p" ] || continue
    agent_may_write "$AGENT" "$p" \
      || fail "$short: path outside $AGENT's write scope: $p (R7)"
  done < "$TMP/work_paths"

  checked=$((checked + 1))
done

echo "OK: $checked commit(s) satisfy the journal/commit protocol"
