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

BLOB_MAX="${AGENT_COMMIT_BLOB_MAX:-1000000}"

TMP=$(mktemp -d)
trap 'rm -rf "$TMP"' EXIT

# ---- WARN-STAMP / WARN-JOURNAL accounting (ADR-0021 §2–§3) -------------------
# Advisory counters, never a verdict: nothing here touches the exit code, and
# every warning line goes to stderr (J-dv_lead-0189 §1.4). Single pass, one
# integer per chain, zero state files (ADR-0021 §2.4; auditor constraint iii).
GNU_DATE=0
if have_gnu_date; then GNU_DATE=1; else
  echo "WARN-STAMP: stamp checking unavailable (no GNU date -d); skipped" >&2
fi
# =() makes each SET-but-empty: a declared-but-unassigned array trips set -u
# at ${#arr[@]} on the empty-history path (found by S43's own-repo fixture).
declare -A st_entries=() st_out=() st_latest=() st_run=()
declare -A sz_over_s=() sz_over_h=() sz_h_max=()
stamp_listed=0 stamp_suppressed=0

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

  # %at on the first line, message body after: the stamp check's reference
  # clock rides the call the loop already makes (J-dv_lead-0189 §1.5 — zero
  # added git invocations; author time per ADR-0021 §2.2).
  git show -s --format='%at%n%B' "$C" > "$TMP/msg_at"
  AT=$(head -n 1 "$TMP/msg_at")
  tail -n +2 "$TMP/msg_at" > "$TMP/msg"
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

  # The journal is a volume CHAIN (ADR-0017 §4); the ACTIVE volume is the
  # highest-numbered volume in THIS COMMIT's tree (§6.1: the chain is
  # enumerated from the state being checked — never the worktree, which would
  # credit old commits with volumes they never contained).
  JOURNAL="$(active_journal_for "$AGENT" "$C")"

  # R10 size limb on the CI surface (ADR-0021 §3): the ACTIVE volume at this
  # commit, warning not refusal — history is immutable, and a permanent red is
  # proportionate to harm that persists in every future reader, not to harm
  # bounded by one file's readability (J-dv_lead-0189 §2.1's ground).
  jsz=$(git cat-file -s "$C:$JOURNAL" 2>/dev/null || echo 0)
  if [ "$jsz" -gt "$JOURNAL_SOFT_MAX" ]; then
    sz_over_s["$AGENT:$JOURNAL"]=1
  fi
  if [ "$jsz" -gt "$JOURNAL_HARD_MAX" ]; then
    sz_over_h["$AGENT:$JOURNAL"]=1
    if [ "$jsz" -gt "${sz_h_max[$AGENT:$JOURNAL]:-0}" ]; then
      sz_h_max["$AGENT:$JOURNAL"]="$jsz"
    fi
  fi

  if [ "$nwords" -eq 2 ]; then
    PARENT=$(git rev-parse "$C^")
    git diff-tree -r --no-renames --no-commit-id --name-status "$PARENT" "$C" > "$TMP/changes"
  else
    PARENT=""
    git diff-tree --root -r --no-renames --no-commit-id --name-status "$C" > "$TMP/changes"
  fi

  : > "$TMP/own_chain"
  : > "$TMP/work_paths"
  : > "$TMP/seeds"
  while IFS=$'\t' read -r status path; do
    [ -n "$path" ] || continue
    if is_journal_path "$path"; then
      case "$status" in
        D) fail "$short: journal deleted: $path (R3)" ;;
        R*|C*) fail "$short: journal renamed/copied: $path (R3)" ;;
      esac
      if is_chain_path_of "$AGENT" "$path"; then
        echo "$path" >> "$TMP/own_chain"
      else
        # R8 (tightened, ADR-0017 §6.2): a foreign journal may only appear as
        # volume 01 of an agent with no chain at the parent commit.
        [ "$status" = "A" ] || fail "$short: modifies another agent's journal: $path (R8)"
        seed_agent=$(journal_agent_of "$path")
        is_known_agent "$seed_agent" || fail "$short: seed journal for unknown agent: $path (R8)"
        chainless=1
        if [ -n "$PARENT" ] && [ -n "$(journal_chain_for "$seed_agent" "$PARENT")" ]; then
          chainless=0
        fi
        { [ "$(journal_path_for "$seed_agent")" = "$path" ] && [ "$chainless" -eq 1 ]; } \
          || fail "$short: foreign volume seed: $path (R8 — only volume 01 of a chainless agent may be seeded)"
        n=$(git show "$C:$path" | count_entries "$seed_agent")
        [ "${n:-0}" -eq 0 ] || fail "$short: foreign journal seed contains entries: $path (R8)"
        echo "$path" >> "$TMP/seeds"
      fi
    else
      echo "$path" >> "$TMP/work_paths"
    fi
  done < "$TMP/changes"

  # R10/R3: at most one own-chain volume changes, and only the active one —
  # every non-active volume must be byte-identical to its parent version
  # (frozen against appends as well as edits).
  own_n=$(grep -c . "$TMP/own_chain" || true)
  [ "$own_n" -le 1 ] \
    || fail "$short: two volumes of $AGENT's journal changed: $(tr '\n' ' ' < "$TMP/own_chain")(R10 — one journal append per commit)"
  OWN_JOURNAL=0
  if [ "$own_n" -eq 1 ]; then
    own_p=$(cat "$TMP/own_chain")
    [ "$own_p" = "$JOURNAL" ] \
      || fail "$short: change to frozen journal volume: $own_p (R3 — a frozen volume is frozen against appends as well as edits; the active volume is $JOURNAL)"
    OWN_JOURNAL=1
  fi

  [ "$OWN_JOURNAL" -eq 1 ] || fail "$short: no append to $JOURNAL (R2)"

  if [ "$JOURNAL_ONLY" = "true" ]; then
    [ ! -s "$TMP/work_paths" ] \
      || fail "$short: Journal-Only commit stages work products (R2)"
  else
    [ -s "$TMP/work_paths" ] || [ -s "$TMP/seeds" ] \
      || fail "$short: work-less commit lacks 'Journal-Only: true' trailer (R2)"
  fi

  # R3: pure EOF-append relative to parent (active volume; a brand-new volume
  # passes trivially against an empty parent copy — ADR-0017 §2.2).
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

  # R5: exactly one new entry, matching trailer, monotonic across the CHAIN at
  # the parent (ADR-0017 §6.3: when the active volume is new in this commit,
  # the last id comes from the predecessor volume).
  new_headers=$(grep -cE "^## \[J-${AGENT}-[0-9]{4}\]" "$TMP/appended" || true)
  [ "$new_headers" -eq 1 ] \
    || fail "$short: appended region has $new_headers entry headers, expected 1 (R5)"
  grep -qF "## [$ENTRY]" "$TMP/appended" \
    || fail "$short: appended entry does not match trailer $ENTRY (R6)"
  if [ -n "$PARENT" ]; then
    last=$(chain_last_entry_num "$AGENT" "$PARENT")
  else
    last="0000"
  fi
  expected=$(printf '%04d' "$((10#$last + 1))")
  actual=$(echo "$ENTRY" | grep -oE '[0-9]{4}$')
  [ "$actual" = "$expected" ] \
    || fail "$short: entry $actual not monotonic (last $last, expected $expected) (R5)"

  # WARN-STAMP accounting (ADR-0021 §2): the ONE appended entry's stamp against
  # this commit's author time. F3: an unparseable stamp is testimony too —
  # warned, never refused. F7/S50: on a rotation the appended region opens with
  # the volume header; extraction keys on the entry-header line, not position.
  if [ "$GNU_DATE" -eq 1 ]; then
    st_entries["$AGENT"]=$(( ${st_entries[$AGENT]:-0} + 1 ))
    stamp_tok=$(stamp_of_entry_header "$AGENT" < "$TMP/appended")
    stamp_epoch=""
    if [ -n "$stamp_tok" ]; then
      if ! stamp_epoch=$(date -u -d "$stamp_tok" +%s 2>/dev/null); then
        stamp_epoch=""
      fi
    fi
    if [ -z "$stamp_epoch" ]; then
      echo "WARN-STAMP: $short $ENTRY unparseable stamp (advisory)" >&2
      st_run["$AGENT"]=0
    else
      drift=$((stamp_epoch - AT))
      if [ "$drift" -gt "$JOURNAL_STAMP_FAST_MAX" ] || [ "$drift" -lt "$((-JOURNAL_STAMP_SLOW_MAX))" ]; then
        drift_m=$(awk "BEGIN{printf \"%+.1f\", $drift/60}")
        st_out["$AGENT"]=$(( ${st_out[$AGENT]:-0} + 1 ))
        st_latest["$AGENT"]="$ENTRY (${drift_m}m)"
        st_run["$AGENT"]=0
        if [ "$MODE" = range ]; then
          if [ "$stamp_listed" -lt "$JOURNAL_STAMP_LIST_MAX" ]; then
            stamp_listed=$((stamp_listed + 1))
            echo "WARN-STAMP: $short $ENTRY header stamp drifts ${drift_m}m from its commit (advisory — a warning is not a verdict)" >&2
          else
            stamp_suppressed=$((stamp_suppressed + 1))
          fi
        fi
      else
        st_run["$AGENT"]=$(( ${st_run[$AGENT]:-0} + 1 ))
      fi
    fi
  fi

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

  # R11: the ADR-0002 blob gate, re-verified in CI with the journal carve-out
  # (ADR-0017 §6.6, D6). A commit made outside agent_commit.sh — or with its
  # threshold overridden — no longer lands an oversized blob unnoticed.
  while IFS=$'\t' read -r status path; do
    [ -n "$path" ] || continue
    [ "$status" = "D" ] && continue
    is_journal_path "$path" && continue
    sz=$(git cat-file -s "$C:$path" 2>/dev/null || echo 0)
    [ "$sz" -le "$BLOB_MAX" ] \
      || fail "$short: file exceeds blob threshold: $path (${sz} > ${BLOB_MAX} bytes; large data ships as fetch script + checksum manifest — blob gate, ADR-0002, R11)"
  done < "$TMP/changes"

  # R10 tree check, once per commit (ADR-0017 §6.4): the committing agent's
  # chain at $C must be gapless 01..N, every k>1 header must back-link volume
  # k-1 (Previous-volume path, Previous-volume-sha256 over the bytes at $C,
  # Continues-from equal to k-1's last entry id, Volume equal to the path
  # suffix), and entry ids must be contiguous across the concatenated chain.
  k=0
  prev_p=""
  : > "$TMP/chain_nums"
  for p in $(journal_chain_for "$AGENT" "$C"); do
    k=$((k + 1))
    vol_suffix=$(journal_volume_of "$p")
    [ "$((10#$vol_suffix))" -eq "$k" ] \
      || fail "$short: journal chain for $AGENT has a gap: position $k is $p (R10 — volumes 01..N with no gap)"
    if [ "$k" -ge 2 ]; then
      hdr_vol=$(git show "$C:$p" | volume_header_field Volume)
      [ "$hdr_vol" = "$vol_suffix" ] \
        || fail "$short: $p declares Volume: '${hdr_vol:-missing}', expected $vol_suffix (R10)"
      hdr_prev=$(git show "$C:$p" | volume_header_field Previous-volume)
      [ "$hdr_prev" = "$prev_p" ] \
        || fail "$short: $p declares Previous-volume: '${hdr_prev:-missing}', expected $prev_p (R10)"
      want_sha=$(git show "$C:$prev_p" | sha256_hex)
      got_sha=$(git show "$C:$p" | volume_header_field Previous-volume-sha256)
      [ "$got_sha" = "$want_sha" ] \
        || fail "$short: $p Previous-volume-sha256 '${got_sha:-missing}' does not match sha256 of $prev_p at $short ($want_sha) (R10)"
      prev_last=$(git show "$C:$prev_p" | last_entry_num "$AGENT")
      got_cont=$(git show "$C:$p" | volume_header_field Continues-from)
      [ "$got_cont" = "J-${AGENT}-${prev_last}" ] \
        || fail "$short: $p Continues-from '${got_cont:-missing}' does not equal $prev_p's last entry id J-${AGENT}-${prev_last} (R10)"
    fi
    git show "$C:$p" | { grep -oE "^## \[J-${AGENT}-[0-9]{4}\]" || true; } \
      | grep -oE '[0-9]{4}' >> "$TMP/chain_nums" || true
    prev_p="$p"
  done
  n=0
  while IFS= read -r num; do
    [ -n "$num" ] || continue
    n=$((n + 1))
    [ "$num" = "$(printf '%04d' "$n")" ] \
      || fail "$short: chain for $AGENT: entry $num at position $n — ids not contiguous across the chain (R10)"
  done < "$TMP/chain_nums"

  checked=$((checked + 1))
done

# ---- WARN-STAMP summary (ADR-0021 §2.3–§2.4): last output before the verdict
# line, all on stderr. --all aggregates per CHAIN (bounded by the roster, never
# by history); --range itemised above, so here it only accounts a surplus.
# The "latest" cell is the most recent OUT-OF-BAND entry of that chain
# (J-dv_lead-0189 §1.2 — the column that forces the reading).
if [ "$GNU_DATE" -eq 1 ]; then
  if [ "$MODE" = all ]; then
    tot=0; out_tot=0
    for a in "${!st_entries[@]}"; do
      tot=$((tot + st_entries[$a])); out_tot=$((out_tot + ${st_out[$a]:-0}))
    done
    if [ "$tot" -gt 0 ]; then
      {
        echo "WARN-STAMP: $out_tot of $tot checked entries carry a header stamp outside the band"
        echo "WARN-STAMP: (fast > +$((JOURNAL_STAMP_FAST_MAX / 60))m, slow < -$((JOURNAL_STAMP_SLOW_MAX / 60))m, vs their own commit's author time). Advisory:"
        echo "WARN-STAMP: a warning is not a verdict and its absence is not a clearance."
        for a in "${!st_entries[@]}"; do
          printf '%s %s\n' "${st_entries[$a]}" "$a"
        done | sort -rn | while read -r n a; do
          printf 'WARN-STAMP: %-20s %4d entries %4d out  latest %s  compliant-run %d\n' \
            "$a" "$n" "${st_out[$a]:-0}" "${st_latest[$a]:--}" "${st_run[$a]:-0}"
        done
      } >&2
    fi
  elif [ "$stamp_suppressed" -gt 0 ]; then
    echo "WARN-STAMP: and $stamp_suppressed more out-of-band entr(ies) in this range (cap $JOURNAL_STAMP_LIST_MAX; advisory)" >&2
  fi
fi

# ---- WARN-JOURNAL size summary (ADR-0021 §3.3): --all only. Aggregate what no
# one can act on (frozen history), itemise what someone can (an active volume
# at HEAD over a threshold — its owner rotates at the next entry).
if [ "$MODE" = all ]; then
  s_n=${#sz_over_s[@]}; h_n=${#sz_over_h[@]}
  h_detail="."
  if [ "$h_n" -gt 0 ]; then
    h_worst=""; h_worst_sz=0
    for k in "${!sz_h_max[@]}"; do
      if [ "${sz_h_max[$k]}" -gt "$h_worst_sz" ]; then h_worst_sz="${sz_h_max[$k]}"; h_worst="${k#*:}"; fi
    done
    h_detail=" ($h_worst, max ${h_worst_sz} B, frozen)."
  fi
  {
    echo "WARN-JOURNAL: R10 history: $s_n volume(s) exceeded S while active over $checked commits;"
    echo "WARN-JOURNAL: $h_n exceeded H$h_detail"
    head_over=0
    for a in "${!st_entries[@]}"; do
      hj=$(active_journal_for "$a" HEAD 2>/dev/null || true)
      [ -n "$hj" ] || continue
      hsz=$(git cat-file -s "HEAD:$hj" 2>/dev/null || echo 0)
      if [ "$hsz" -gt "$JOURNAL_SOFT_MAX" ]; then
        head_over=$((head_over + 1))
        echo "WARN-JOURNAL: active volume over S at HEAD: $hj (${hsz} B); rotate at next entry (R10)"
      fi
    done
    if [ "$head_over" -eq 0 ]; then
      echo "WARN-JOURNAL: active volumes at HEAD: all within S."
    fi
  } >&2
fi

echo "OK: $checked commit(s) satisfy the journal/commit protocol"
