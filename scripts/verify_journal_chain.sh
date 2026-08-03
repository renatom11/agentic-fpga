#!/usr/bin/env bash
# verify_journal_chain.sh — the standalone journal-chain auditor
# (ADR-0017 §6.5: the from-a-checkout proof). Needs NO history: every check
# is made against the tree alone.
#
# For each agent: walk volumes 01..N in numeric order; assert each volume's
# declared Volume matches its path; re-hash each frozen volume and compare
# with its successor's Previous-volume-sha256 back-link; assert Continues-from
# equals the predecessor's last entry id; then concatenate the chain and
# assert entry-id contiguity from 0001. Exits nonzero at the first break,
# naming the volume and which property broke.
#
# Usage:
#   scripts/verify_journal_chain.sh            # every agent, working tree
#   scripts/verify_journal_chain.sh --at <rev> # every agent, as of a revision
#
# What a green result certifies (ADR-0017 §6.5, as countersigned by dv_lead):
# no entry in a FROZEN volume has been rewritten, and no entry id is missing
# from the chain. It does NOT certify the ACTIVE volume, which has no
# successor to back-link it; its append-only property rests on R3 and history
# exactly as before. A green chain is not a clearance for the volume
# currently being written.

set -euo pipefail
if TOP=$(git rev-parse --show-toplevel 2>/dev/null); then
  cd "$TOP"
fi
# shellcheck source=policy.sh
. "$(dirname "$0")/policy.sh"

LISTER="worktree"
case "${1:-}" in
  "") ;;
  --at)
    LISTER="${2:-}"
    [ -n "$LISTER" ] || fail "--at needs a revision"
    git rev-parse -q --verify "$LISTER^{commit}" > /dev/null \
      || fail "no such revision: $LISTER" ;;
  *) fail "usage: verify_journal_chain.sh [--at <rev>]" ;;
esac

TMP=$(mktemp -d)
trap 'rm -rf "$TMP"' EXIT

agents_checked=0
for agent in $KNOWN_AGENTS; do
  chain=$(journal_chain_for "$agent" "$LISTER")
  [ -n "$chain" ] || continue

  k=0
  prev_path=""
  : > "$TMP/nums"
  for p in $chain; do
    k=$((k + 1))
    suffix=$(journal_volume_of "$p")
    [ "$((10#$suffix))" -eq "$k" ] \
      || fail "$agent: chain gap — expected volume $(printf '%02d' "$k"), found $p (volumes 01..N must have no gap)"
    journal_show "$LISTER" "$p" > "$TMP/vol"
    hdr_vol=$(volume_header_field Volume < "$TMP/vol")
    if [ "$k" -eq 1 ]; then
      # Volume 01 of an existing chain predates ADR-0017 and is append-only,
      # so its header can never gain a Volume field retroactively; the field
      # is checked only where declared.
      if [ -n "$hdr_vol" ] && [ "$hdr_vol" != "$suffix" ]; then
        fail "$agent: $p declares Volume: '$hdr_vol', expected $suffix (Volume field vs path)"
      fi
    else
      [ "$hdr_vol" = "$suffix" ] \
        || fail "$agent: $p declares Volume: '${hdr_vol:-missing}', expected $suffix (Volume field vs path)"
      hdr_prev=$(volume_header_field Previous-volume < "$TMP/vol")
      [ "$hdr_prev" = "$prev_path" ] \
        || fail "$agent: $p declares Previous-volume: '${hdr_prev:-missing}', expected $prev_path (Previous-volume vs chain)"
      want_sha=$(journal_show "$LISTER" "$prev_path" | sha256_hex)
      got_sha=$(volume_header_field Previous-volume-sha256 < "$TMP/vol")
      [ "$got_sha" = "$want_sha" ] \
        || fail "$agent: $p Previous-volume-sha256 '${got_sha:-missing}' does not match sha256 of $prev_path ($want_sha) — a frozen volume was altered or the back-link is forged"
      prev_last=$(journal_show "$LISTER" "$prev_path" | last_entry_num "$agent")
      got_cont=$(volume_header_field Continues-from < "$TMP/vol")
      [ "$got_cont" = "J-${agent}-${prev_last}" ] \
        || fail "$agent: $p Continues-from '${got_cont:-missing}' does not equal $prev_path's last entry id J-${agent}-${prev_last}"
    fi
    { grep -oE "^## \[J-${agent}-[0-9]{4}\]" "$TMP/vol" || true; } \
      | grep -oE '[0-9]{4}' >> "$TMP/nums" || true
    prev_path="$p"
  done

  n=0
  while IFS= read -r num; do
    [ -n "$num" ] || continue
    n=$((n + 1))
    [ "$num" = "$(printf '%04d' "$n")" ] \
      || fail "$agent: entry id $num at chain position $n — ids not contiguous from 0001 (an entry was dropped or renumbered)"
  done < "$TMP/nums"

  agents_checked=$((agents_checked + 1))
  echo "OK: $agent — $k volume(s), $n entries, chain verified"
done

# Sweep: every journal-shaped file must sit inside a known agent's chain.
journal_lister_paths "$LISTER" | while IFS= read -r p; do
  [ -n "$p" ] || continue
  is_journal_path "$p" || continue
  a=$(journal_agent_of "$p")
  is_known_agent "$a" || fail "journal file for unknown agent: $p"
  is_chain_path_of "$a" "$p" || fail "journal file outside its agent's chain location: $p"
done

echo "OK: $agents_checked chain(s) verified — frozen volumes unaltered, back-links intact, entry ids contiguous"
echo "NOTE: a green result certifies the FROZEN volumes and chain completeness only."
echo "NOTE: The ACTIVE volume of each chain is NOT certified — its append-only"
echo "NOTE: property rests on R3 and on history, exactly as before (ADR-0017 §6.5)."
