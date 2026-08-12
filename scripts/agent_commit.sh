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

# The journal is a volume CHAIN (ADR-0017 §4): the append lands on the ACTIVE
# volume — the highest-numbered volume in the STAGED INDEX (§6.1: the chain is
# enumerated from the state being checked, never the filesystem). Falls back
# to the chain root when the agent has no chain yet (§6.2).
JOURNAL="$(active_journal_for "$AGENT" index)"
ACTIVE_VOL="$(journal_volume_of "$JOURNAL")"
ACTIVE_VOL_N=$((10#$ACTIVE_VOL))
NEXT_VOL="$(printf '%02d' "$((ACTIVE_VOL_N + 1))")"

# ---- Gather staged state -----------------------------------------------------
STATUS_LIST=$(git diff --cached --name-status --no-renames)
[ -n "$STATUS_LIST" ] || fail "nothing staged"

OWN_CHAIN_STAGED=()
FOREIGN_JOURNAL_SEEDS=()
WORK_PATHS=()
while IFS=$'\t' read -r status path; do
  [ -n "$path" ] || continue
  if is_journal_path "$path"; then
    case "$status" in
      D) fail "journal deletion staged: $path (R3 — journals are never deleted)" ;;
      R*|C*) fail "journal rename/copy staged: $path (R3)" ;;
    esac
    if is_chain_path_of "$AGENT" "$path"; then
      OWN_CHAIN_STAGED+=("$path")
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

# ---- R10/R3: exactly one own-chain path staged, and only the active volume ---
# Two staged volumes of the committing agent's chain are refused HERE, before
# the second one is misclassified as foreign and refused with R8's misleading
# message (ADR-0017 §6.2). A single staged non-active volume is a write into a
# frozen volume (R3 as amended — frozen against appends as well as edits).
[ "${#OWN_CHAIN_STAGED[@]}" -le 1 ] \
  || fail "two volumes of $AGENT's journal staged: ${OWN_CHAIN_STAGED[*]} (R10 — one journal append per commit)"
OWN_JOURNAL_STAGED=0
if [ "${#OWN_CHAIN_STAGED[@]}" -eq 1 ]; then
  [ "${OWN_CHAIN_STAGED[0]}" = "$JOURNAL" ] \
    || fail "staged change to frozen journal volume: ${OWN_CHAIN_STAGED[0]} (R3 — a frozen volume is frozen against appends as well as edits; the active volume is $JOURNAL)"
  OWN_JOURNAL_STAGED=1
fi

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

# ---- R8: validate foreign seeds (tightened, ADR-0017 §6.2) -------------------
# A foreign journal may enter a commit only as volume 01 of an agent that has
# no chain at HEAD — anything else pre-empts another agent's next volume or
# splices an empty volume into a live chain.
for seed in ${FOREIGN_JOURNAL_SEEDS[@]+"${FOREIGN_JOURNAL_SEEDS[@]}"}; do
  seed_agent=$(journal_agent_of "$seed")
  is_known_agent "$seed_agent" || fail "seed journal for unknown agent: $seed (R8)"
  { [ "$(journal_path_for "$seed_agent")" = "$seed" ] \
      && [ -z "$(journal_chain_for "$seed_agent" HEAD)" ]; } \
    || fail "foreign volume seed: $seed (R8 — only volume 01 of a chainless agent may be seeded)"
  n=$(git show ":$seed" | count_entries "$seed_agent")
  [ "${n:-0}" -eq 0 ] || fail "foreign journal seed contains entries: $seed (R8)"
done

# ---- R10: rotation commit — a new active volume must chain correctly ---------
# There is no "rotation mode" (ADR-0017 §4.4): a commit whose active volume is
# NEW simply gets its §4.3 header verified against the predecessor at HEAD.
if [ "$ACTIVE_VOL_N" -ge 2 ] && ! git cat-file -e "HEAD:$JOURNAL" 2>/dev/null; then
  PREV_PATH="$(journal_volume_path_for "$AGENT" "$((ACTIVE_VOL_N - 1))")"
  git cat-file -e "HEAD:$PREV_PATH" 2>/dev/null \
    || fail "rotation creates $JOURNAL but $PREV_PATH does not exist at HEAD (R10 — volumes 01..N with no gap)"
  [ "$(git rev-parse "HEAD:$PREV_PATH")" = "$(git rev-parse ":$PREV_PATH")" ] \
    || fail "rotation commit alters $PREV_PATH (R10 — the predecessor freezes at rotation)"
  hdr_vol=$(git show ":$JOURNAL" | volume_header_field Volume)
  [ "$hdr_vol" = "$ACTIVE_VOL" ] \
    || fail "$JOURNAL declares Volume: '${hdr_vol:-missing}', expected $ACTIVE_VOL (R10)"
  hdr_prev=$(git show ":$JOURNAL" | volume_header_field Previous-volume)
  [ "$hdr_prev" = "$PREV_PATH" ] \
    || fail "$JOURNAL declares Previous-volume: '${hdr_prev:-missing}', expected $PREV_PATH (R10)"
  prev_sha=$(git show "HEAD:$PREV_PATH" | sha256_hex)
  hdr_sha=$(git show ":$JOURNAL" | volume_header_field Previous-volume-sha256)
  [ "$hdr_sha" = "$prev_sha" ] \
    || fail "$JOURNAL Previous-volume-sha256 '${hdr_sha:-missing}' does not match sha256 of $PREV_PATH at HEAD ($prev_sha) (R10)"
  prev_last=$(git show "HEAD:$PREV_PATH" | last_entry_num "$AGENT")
  hdr_cont=$(git show ":$JOURNAL" | volume_header_field Continues-from)
  [ "$hdr_cont" = "J-${AGENT}-${prev_last}" ] \
    || fail "$JOURNAL Continues-from '${hdr_cont:-missing}' must equal the predecessor's last entry id J-${AGENT}-${prev_last} (R10, ADR-0017 §6.3)"
fi

# ---- R3: pure EOF-append on own journal (active volume) ----------------------
TMPDIR_P=$(mktemp -d)
trap 'rm -rf "$TMPDIR_P"' EXIT
git show ":$JOURNAL" > "$TMPDIR_P/staged"
if git cat-file -e "HEAD:$JOURNAL" 2>/dev/null; then
  git show "HEAD:$JOURNAL" > "$TMPDIR_P/head"
else
  : > "$TMPDIR_P/head"   # journal volume is new in this commit
fi
is_byte_prefix "$TMPDIR_P/head" "$TMPDIR_P/staged" \
  || fail "$JOURNAL is not a pure EOF-append of its previous content (R3)"
head_size=$(wc -c < "$TMPDIR_P/head")
tail -c +"$((head_size + 1))" "$TMPDIR_P/staged" > "$TMPDIR_P/appended"
[ -s "$TMPDIR_P/appended" ] || fail "no appended journal content (R2)"

# ---- R5: exactly one new entry, monotonic across the chain -------------------
# The last entry id is read from the CHAIN at HEAD (ADR-0017 §6.3): active
# volume unchanged -> its own last id (unchanged behaviour); active volume new
# in this commit -> the predecessor volume's last id.
new_headers=$(grep -cE "^## \[J-${AGENT}-[0-9]{4}\]" "$TMPDIR_P/appended" || true)
[ "$new_headers" -eq 1 ] \
  || fail "appended region must contain exactly one new entry header, found $new_headers"
grep -qF "## [$ENTRY]" "$TMPDIR_P/appended" \
  || fail "appended entry header does not match --entry $ENTRY"
last=$(chain_last_entry_num "$AGENT" HEAD)
expected=$(printf '%04d' "$((10#$last + 1))")
actual=$(echo "$ENTRY" | grep -oE '[0-9]{4}$')
[ "$actual" = "$expected" ] \
  || fail "entry number $actual is not monotonic (last was $last, expected $expected) (R5)"

# ---- R10: size thresholds on the ACTIVE volume (ADR-0017 D4, §5) -------------
# H binds the STAGED ACTIVE volume, so a rotation commit — whose active volume
# is the new, small one — always passes; what H refuses is a further append to
# an oversized volume. The remedy is named in the message (§6.2).
staged_bytes=$(wc -c < "$TMPDIR_P/staged")
[ "$staged_bytes" -le "$JOURNAL_HARD_MAX" ] \
  || fail "$JOURNAL is ${staged_bytes} bytes (> $((JOURNAL_HARD_MAX / 1024)) KiB): rotate to volume ${NEXT_VOL} (R10, ADR-0017 §4.4)"
if [ "$staged_bytes" -gt "$JOURNAL_SOFT_MAX" ]; then
  echo "WARN-JOURNAL: $JOURNAL is ${staged_bytes} bytes (> $((JOURNAL_SOFT_MAX / 1024)) KiB); rotate to volume ${NEXT_VOL} at your next entry (R10, ADR-0017)" >&2
fi

# ---- WARN-STAMP: advisory drift counter (ADR-0021 §2) ------------------------
# A warning, never a refusal: R3 freezes committed stamps, and a blocking check
# pays its subject to lie (J-dv_lead-0189 §1). Exit code untouched in every
# branch; all output on stderr (ADR-0021 §2.4 as narrowed at J-dv_lead-0189
# §1.4). Shell-form per ADR-0016 §6.4: if/then, never `[ … ] && …`, so the
# compliant path cannot kill a `set -e` script.
if have_gnu_date; then
  stamp_tok=$(stamp_of_entry_header "$AGENT" < "$TMPDIR_P/appended")
  if [ -z "$stamp_tok" ]; then
    echo "WARN-STAMP: $ENTRY unparseable stamp '$(grep -m1 -E "^## \[J-${AGENT}-[0-9]{4}\]" "$TMPDIR_P/appended" | cut -c1-80)' (advisory)" >&2
  else
    stamp_epoch=""
    if ! stamp_epoch=$(date -u -d "$stamp_tok" +%s 2>/dev/null); then
      echo "WARN-STAMP: $ENTRY unparseable stamp '$stamp_tok' (advisory)" >&2
    else
      ref_epoch=$(date -u +%s)
      drift=$((stamp_epoch - ref_epoch))
      if [ "$drift" -gt "$JOURNAL_STAMP_FAST_MAX" ] || [ "$drift" -lt "$((-JOURNAL_STAMP_SLOW_MAX))" ]; then
        drift_m=$(awk "BEGIN{printf \"%+.1f\", $drift/60}")
        echo "WARN-STAMP: $ENTRY header stamp drifts ${drift_m}m from now (band +$((JOURNAL_STAMP_FAST_MAX / 60))m/-$((JOURNAL_STAMP_SLOW_MAX / 60))m; advisory — a warning is not a verdict)" >&2
      fi
    fi
  fi
else
  echo "WARN-STAMP: stamp checking unavailable (no GNU date -d); skipped" >&2
fi

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

# ---- Blob gate (ADR-0002 accepted debt, closed in M1) ------------------------
# Journals are carved out per ADR-0017 D1: the gate's remedy (fetch script +
# checksum manifest) cannot apply to a file R2 requires in every commit and R3
# requires to continue its own bytes. Journal size is governed by R10's
# rotation thresholds above instead. CI re-checks this gate as R11 (§6.6).
BLOB_MAX="${AGENT_COMMIT_BLOB_MAX:-1000000}"
while IFS=$'\t' read -r status path; do
  [ -n "$path" ] || continue
  [ "$status" = "D" ] && continue
  is_journal_path "$path" && continue
  sz=$(git cat-file -s ":$path" 2>/dev/null || echo 0)
  [ "$sz" -le "$BLOB_MAX" ] \
    || fail "staged file exceeds blob threshold: $path (${sz} > ${BLOB_MAX} bytes; large data ships as fetch script + checksum manifest — blob gate, ADR-0002)"
done <<< "$STATUS_LIST"

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
