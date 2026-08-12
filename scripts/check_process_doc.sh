#!/usr/bin/env bash
# check_process_doc.sh — the governance job council rounds 4 and 5 graduated
# (round-4 verdict "mechanical closures"; round-5 verdict, Recommendation):
# the process document's self-checks as a script instead of a promise.
#
# What it checks, and what it deliberately does not:
#   1. The split falsifier: zero SUPERSEDED sentinels in the core
#      (docs/PROCESS.md front matter, split rule S1 — archaeology lives in
#      the memoir).
#   2. The two-volume contract: the memoir exists whenever the core names it,
#      and both volumes carry an edition anchor.
#   3. The golden tally closes (docs/process-golden-tally.json): its own two
#      arithmetic invariants, and the core's §3.9 printed figures agree with
#      it — the round-5 Charlie F1 class made structurally unrecurrable.
#   4. Render safety: fence markers pair off in both volumes (an odd count is
#      an unclosed block that corrupts everything after it).
#   NOT checked here: the doc–shell drift check (needs the shell repository —
#   named debt, architect seat, docs/PROCESS.md Annex B); prose truth (that is
#   what councils and the posture census are for); line accounting across the
#   split (the falsifier diffs editions, which needs two committed states —
#   run it at edition boundaries, not per push).
#
# Advisory nothing: every check here REFUSES on failure. These are structural
# invariants of committed artifacts, not testimony — the proportionality that
# makes WARN-STAMP a counter makes a broken tally a red.

set -euo pipefail
cd "$(git rev-parse --show-toplevel)"

CORE=docs/PROCESS.md
MEMOIR=docs/PROCESS-MEMOIR.md
TALLY=docs/process-golden-tally.json

fail() { echo "PROCESS-DOC VIOLATION: $*" >&2; exit 1; }

[ -f "$CORE" ] || fail "$CORE missing"

# 1 — the split falsifier: sentinels never in the core.
n=$(grep -c 'SUPERSEDED — historical record' "$CORE" || true)
[ "$n" -eq 0 ] || fail "$n SUPERSEDED sentinel(s) in the core; archaeology belongs in the memoir (split rule S1)"

# 2 — the two-volume contract.
if grep -q 'PROCESS-MEMOIR' "$CORE"; then
  [ -f "$MEMOIR" ] || fail "core references the memoir but $MEMOIR is missing"
fi
grep -qi 'edition' <(head -40 "$CORE") || fail "core carries no edition anchor in its head"
if [ -f "$MEMOIR" ]; then
  grep -qi 'edition' <(head -40 "$MEMOIR") || fail "memoir carries no edition anchor in its head"
fi

# 3 — the golden tally closes, twice: internally, and against the core's text.
if [ -f "$TALLY" ]; then
  python3 - "$TALLY" "$CORE" <<'PY'
import json, re, sys
tally_path, core_path = sys.argv[1], sys.argv[2]
t = json.load(open(tally_path))['tally']
sealed, seeded, diff = t['sealed'], t['seeded'], t['difference']
killed, survived, gbb = t['killed'], t['survived'], t['green_by_blindness']
if sealed != seeded + diff:
    sys.exit(f"PROCESS-DOC VIOLATION: golden tally does not close: sealed {sealed} != seeded {seeded} + difference {diff}")
if seeded != killed + survived + gbb:
    sys.exit(f"PROCESS-DOC VIOLATION: golden tally does not close: seeded {seeded} != {killed}+{survived}+{gbb}")
core = open(core_path).read()
for name, val in (('sealed', sealed), ('seeded', seeded), ('killed', killed)):
    # the worked tally in §3.9 prints these figures; a document edited alone drifts
    if not re.search(rf'\b{val}\b', core):
        sys.exit(f"PROCESS-DOC VIOLATION: core text nowhere carries the tally's {name} figure {val}; the document must be derived from the golden tally, never edited alone")
PY
fi

# 4 — render safety: fence markers pair off.
for f in "$CORE" "$MEMOIR"; do
  [ -f "$f" ] || continue
  fences=$(grep -c '^```' "$f" || true)
  if [ $((fences % 2)) -ne 0 ]; then
    fail "$f has an odd number of fence markers ($fences); an unclosed block corrupts everything after it"
  fi
done

echo "OK: process document invariants hold (sentinels, volumes, golden tally, fences)"
