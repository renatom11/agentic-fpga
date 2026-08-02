#!/usr/bin/env bash
# check_rfc1071_anchor.sh — close (or keep visibly open) the external-anchor
# obligation on test/golden/ipv4_ref.ml.
#
# THE OBLIGATION, IN ITS OWN WORDS
#
# test/golden/ipv4_ref.ml embeds RFC 1071 §3's worked example as three
# constants and says of itself:
#
#     "no sign-off may cite this oracle as anchored until a reader or a CI
#      step with network access has confirmed the three constants against
#      RFC 1071 §3."
#
# Charter §3 makes anchor-before-judge non-negotiable, and PROTOCOL §10 makes
# it a programme rule. dv_lead's two fetches and the orchestrator's three
# (a different egress path) all returned HTTP 403, so the anchor has been
# EMBEDDED AND UNCONFIRMED since WO-0033. This script is the confirming step.
# It is meant to run where egress is open — the CI runner — and to be
# re-executable by the auditor at any SHA.
#
# WHAT IT WILL NOT DO
#
# It will not pass without having matched real fetched text. There is exactly
# one place below that sets the CONFIRMED flag, and it is inside the branch
# that compared the constants against a document that (a) was fetched, (b)
# identified itself as RFC 1071, and (c) yielded a §3 slice. A network failure
# is exit 2, not exit 0. A "the grep found nothing" is exit 2, not exit 0.
# Vacuous confirmation of an anchor is the exact failure ADR-0005 rule 2 and
# this programme's evidence rules exist to prevent, and it would be worse than
# leaving the obligation open, because it would look closed.
#
# THE TWO LANES
#
#   LOCAL    No network. Re-derives RFC 1071's arithmetic over the embedded
#            octets in awk — an implementation that shares no code with the
#            OCaml oracle — and checks four things: the sum, the checksum as
#            the one's complement of it, SPEC-M14 §6.1's residue form, and
#            RFC 1071 §2's byte-swap invariance. This lane always runs and
#            always has a verdict. It cannot confirm the QUOTATION (only the
#            RFC's text can do that); it can and does prove the three
#            constants are mutually consistent under the arithmetic they
#            claim to come from, so a typo in one of them is caught here
#            with no network at all.
#
#   NETWORK  Fetches RFC 1071, verifies the document identifies itself,
#            slices §3, and confirms the three constants appear in it — with
#            a negative control, so "the token is somewhere in the document"
#            cannot be mistaken for "the document says this". The two RFC
#            1071 §2 properties ipv4_ref.ml also cites are located and their
#            enclosing section number REPORTED (advisory: a keyword search
#            over prose cannot tell "the RFC says it elsewhere" from "my
#            keywords are wrong", so it may not gate a build; the three
#            constants are exact hex tokens and may).
#
# USAGE
#
#   tools/check_rfc1071_anchor.sh
#   tools/check_rfc1071_anchor.sh --tolerate-unreachable
#       downgrade "could not fetch" from exit 2 to exit 0, still printing the
#       OBLIGATION-OPEN banner. For the development container, where the 403
#       is known and expected. NEVER for CI: on a runner with open egress a
#       403 is news and must be loud.
#   tools/check_rfc1071_anchor.sh --print-body FILE
#       skip the network and read the RFC text from FILE (for auditing this
#       script's extraction against a locally held copy).
#   tools/check_rfc1071_anchor.sh --self-test
#       prove the EXTRACTOR has teeth without pretending to have seen the RFC.
#       It generates §3-shaped documents at run time — from the oracle's own
#       constants, banner-marked SYNTHETIC and never written into the repo —
#       and requires: a well-formed one to CONFIRM, a corrupted one to be
#       REJECTED, and one carrying both the right and the wrong value to trip
#       the negative control. This says nothing whatever about RFC 1071's
#       real text; it says the machinery that will read it is not a rubber
#       stamp.
#
# EXIT
#   0  the three constants are confirmed against fetched RFC 1071 §3 text
#      (or --tolerate-unreachable was given and the fetch failed)
#   1  MISMATCH — a constant disagrees with the RFC, or the local arithmetic
#      is inconsistent. Always a real failure, everywhere.
#   2  OBLIGATION OPEN — the text could not be fetched or could not be
#      sliced. Nothing was confirmed and nothing is claimed.

set -uo pipefail

HERE="$(cd "$(dirname "$0")" && pwd)"
REPO="$(cd "$HERE/.." && pwd)"
ORACLE="$REPO/test/golden/ipv4_ref.ml"

TOLERATE=0
BODY_FILE=""
SELFTEST=0
while [ "$#" -gt 0 ]; do
  case "$1" in
    --tolerate-unreachable) TOLERATE=1; shift ;;
    --self-test) SELFTEST=1; shift ;;
    --print-body) BODY_FILE="${2:-}"; shift 2 ;;
    -h | --help) sed -n '2,/^set -uo/p' "$0" | sed 's/^# \{0,1\}//;$d'; exit 0 ;;
    *) printf 'check_rfc1071_anchor: unknown argument %s\n' "$1" >&2; exit 1 ;;
  esac
done

URLS="
https://www.rfc-editor.org/rfc/rfc1071.txt
https://www.ietf.org/rfc/rfc1071.txt
https://www.rfc-editor.org/rfc/rfc1071
https://datatracker.ietf.org/doc/html/rfc1071
"

say() { printf '%s\n' "$*"; }
hdr() { printf '\n%s\n' "$*"; }

# ------------------------------------------------------------------ #
# the constants under test — parsed from the oracle, never hard-coded #
# ------------------------------------------------------------------ #

if [ ! -e "$ORACLE" ]; then
  say "check_rfc1071_anchor: MISMATCH — $ORACLE does not exist."
  say "  There is nothing to anchor. This is a failure, not a skip."
  exit 1
fi

OCTETS="$(sed -n 's/^let rfc1071_example_octets *= *\[\(.*\)\].*$/\1/p' "$ORACLE" \
  | tr -d ' ' | tr ';' ' ' | sed 's/0x//g' | tr '[:upper:]' '[:lower:]' \
  | sed 's/^ *//;s/ *$//')"
SUM="$(sed -n 's/^let rfc1071_example_sum *= *0x\([0-9a-fA-F]*\).*$/\1/p' "$ORACLE" \
  | tr '[:upper:]' '[:lower:]')"
CKSUM="$(sed -n 's/^let rfc1071_example_checksum *= *0x\([0-9a-fA-F]*\).*$/\1/p' "$ORACLE" \
  | tr '[:upper:]' '[:lower:]')"

if [ -z "$OCTETS" ] || [ -z "$SUM" ] || [ -z "$CKSUM" ]; then
  say "check_rfc1071_anchor: MISMATCH — could not parse the three constants out of"
  say "  ${ORACLE#"$REPO"/}. This script must never compare empty strings and call"
  say "  it agreement, so it stops here."
  say "  parsed: octets='$OCTETS' sum='$SUM' checksum='$CKSUM'"
  exit 1
fi

NOCTETS="$(printf '%s\n' $OCTETS | grep -c .)"

say "=== check_rfc1071_anchor ==="
say "oracle:    ${ORACLE#"$REPO"/}"
say "authority: RFC 1071, \"Computing the Internet Checksum\", §3 Numerical Examples"
say ""
say "constants under test, parsed from the oracle (never hard-coded here):"
say "  rfc1071_example_octets   = $OCTETS  ($NOCTETS octets)"
say "  rfc1071_example_sum      = 0x$SUM"
say "  rfc1071_example_checksum = 0x$CKSUM"

# ------------------------------------------------------------------ #
# --self-test — does the extractor discriminate?                      #
# ------------------------------------------------------------------ #

if [ "$SELFTEST" -eq 1 ]; then
  hdr "SELF-TEST — the extractor, against documents generated here"
  say "  These fixtures are SYNTHETIC and are written to a temporary directory,"
  say "  never into the repository. They prove that the machinery which will"
  say "  read RFC 1071 confirms a well-formed §3, rejects a corrupted one, and"
  say "  refuses one where the negative control fires. They prove NOTHING about"
  say "  RFC 1071's real text — only a fetch can, and that is the network lane."
  ST="$(mktemp -d "${TMPDIR:-/tmp}/rfc1071-selftest.XXXXXX")" || exit 2
  trap 'rm -rf "$ST"' EXIT

  gen() {
    # $1 = output file, $2 = sum token to print, $3 = extra line (may be empty)
    local out_file="$1" sum_token="$2" extra="${3:-}"
    {
      printf '%s\n' "            SYNTHETIC LAYOUT FIXTURE - NOT RFC 1071"
      printf '%s\n' "   Generated by tools/check_rfc1071_anchor.sh --self-test to exercise"
      printf '%s\n' "   its own extractor. Not evidence of anything. Do not quote."
      printf '\n%s\n' "                  Computing the Internet Checksum"
      printf '\n%s\n' "1.  Introduction"
      printf '%s\n' "   Prose."
      printf '\n%s\n' "2.  Properties"
      printf '%s\n' "   The sum is independent of the byte order of the data, and the"
      printf '%s\n' "   checksum is the one's complement of the sum."
      printf '\n%s\n' "3.  Numerical Examples"
      printf '%s\n' "   All numbers are in hex."
      set -- $OCTETS
      i=0
      while [ "$#" -ge 2 ]; do
        printf '   Byte %d/%d:  %s %s\n' "$i" "$((i + 1))" "$1" "$2"
        i=$((i + 2)); shift 2
      done
      printf '   Sum:        %s\n' "$sum_token"
      printf '   Checksum:   %s\n' "$CKSUM"
      [ -n "$extra" ] && printf '   %s\n' "$extra"
      printf '\n%s\n' "4.  Implementation Examples"
      printf '%s\n' "   More prose."
    } > "$out_file"
    return 0
  }

  st_status=0
  st_case() { # $1 label, $2 expected exit, $3 file
    out="$(bash "$0" --print-body "$3" 2>&1)"; rc=$?
    if [ "$rc" -eq "$2" ]; then
      say "  [ok]   $1 -> exit $rc as required"
    else
      say "  [FAIL] $1 -> exit $rc, expected $2"
      printf '%s\n' "$out" | sed 's/^/         /'
      st_status=1
    fi
  }

  gen "$ST/good.txt" "$SUM" ""
  st_case "well-formed §3 carrying the oracle's constants" 0 "$ST/good.txt"

  gen "$ST/wrong.txt" "$(printf '%04x' $((0x$SUM ^ 0x0001)))" ""
  st_case "§3 whose sum is one bit off" 1 "$ST/wrong.txt"

  gen "$ST/ambig.txt" "$SUM" "Also mentioned: $(printf '%04x' $((0x$SUM ^ 0x0001)))"
  st_case "§3 carrying BOTH the right and the wrong sum (negative control)" 1 "$ST/ambig.txt"

  gen "$ST/nosec.txt" "$SUM" ""
  sed -i 's/^3\.  Numerical Examples$/X.  Numerical Examples/' "$ST/nosec.txt"
  st_case "document with no sliceable §3" 2 "$ST/nosec.txt"

  printf 'not a document about checksums at all\n' > "$ST/junk.txt"
  st_case "unidentified document" 2 "$ST/junk.txt"

  hdr "SELF-TEST VERDICT"
  if [ "$st_status" -eq 0 ]; then
    say "  self-test: OK — the extractor confirms, rejects, and refuses as designed."
    say "  It has said nothing about RFC 1071."
  else
    say "  self-test: FAILED — the extractor is not trustworthy; do not read a"
    say "  CONFIRMED from it until this passes."
  fi
  exit "$st_status"
fi

# ------------------------------------------------------------------ #
# LOCAL LANE — the arithmetic, in an implementation that is not the   #
#              oracle's                                               #
# ------------------------------------------------------------------ #

hdr "LOCAL LANE — RFC 1071's arithmetic, re-derived here in awk (no network)"
say "  This is a second implementation. It shares no code with"
say "  Ipv4_ref.sum, so agreement is evidence and not a tautology. It"
say "  confirms the constants are CONSISTENT; only the RFC's own text can"
say "  confirm they are QUOTED correctly, and that is the network lane."

LOCAL_OUT="$(printf '%s\n' "$OCTETS" | awk '
  function fold(v) { while (v > 65535) v = and16(v) + int(v / 65536); return v }
  function and16(v) { return v % 65536 }
  function hex(s,   i, c, n, d) {
    n = 0
    for (i = 1; i <= length(s); i++) {
      c = tolower(substr(s, i, 1))
      d = index("0123456789abcdef", c) - 1
      n = n * 16 + d
    }
    return n
  }
  function sum1(arr, len,   i, hw, t) {
    t = 0
    for (i = 1; i <= len; i += 2) {
      hw = arr[i] * 256 + (i + 1 <= len ? arr[i + 1] : 0)
      t += hw
    }
    return fold(t)
  }
  {
    n = split($0, tok, " ")
    for (i = 1; i <= n; i++) o[i] = hex(tok[i])
    s = sum1(o, n)
    printf "sum=%04x\n", s
    printf "checksum=%04x\n", 65535 - s
    printf "residue_input=%04x\n", s
    # residue: append the checksum as a halfword and re-sum
    o[n + 1] = int((65535 - s) / 256); o[n + 2] = (65535 - s) % 256
    printf "residue=%04x\n", sum1(o, n + 2)
    delete o[n + 1]; delete o[n + 2]
    # byte swap
    for (i = 1; i <= n; i += 2) { t = o[i]; o[i] = o[i + 1]; o[i + 1] = t }
    ss = sum1(o, n)
    printf "swapped=%04x\n", ss
    printf "swap_of_sum=%04x\n", (s % 256) * 256 + int(s / 256)
  }
')"

lget() { printf '%s\n' "$LOCAL_OUT" | sed -n "s/^$1=//p"; }
L_SUM="$(lget sum)"; L_CK="$(lget checksum)"; L_RES="$(lget residue)"
L_SW="$(lget swapped)"; L_SWS="$(lget swap_of_sum)"

local_status=0
if [ "$L_SUM" = "$SUM" ]; then
  say "  [ok]   one's-complement sum of the octets = 0x$L_SUM, matches rfc1071_example_sum"
else
  say "  [FAIL] one's-complement sum of the octets = 0x$L_SUM, but the oracle says 0x$SUM"
  local_status=1
fi
if [ "$L_CK" = "$CKSUM" ]; then
  say "  [ok]   its one's complement = 0x$L_CK, matches rfc1071_example_checksum"
else
  say "  [FAIL] its one's complement = 0x$L_CK, but the oracle says 0x$CKSUM"
  local_status=1
fi
if [ "$L_RES" = "ffff" ]; then
  say "  [ok]   SPEC-M14 §6.1 residue form: octets + their checksum sum to 0xFFFF"
else
  say "  [FAIL] residue form: octets + their checksum sum to 0x$L_RES, not 0xFFFF"
  local_status=1
fi
if [ "$L_SW" = "$L_SWS" ]; then
  say "  [ok]   RFC 1071 §2 byte-swap invariance: sum(swap(octets)) = 0x$L_SW = swap(sum)"
else
  say "  [FAIL] byte-swap invariance: sum(swap(octets)) = 0x$L_SW, swap(sum) = 0x$L_SWS"
  local_status=1
fi

if [ "$local_status" -ne 0 ]; then
  hdr "VERDICT: MISMATCH (local)"
  say "  The three constants are not even self-consistent under the arithmetic"
  say "  they claim. This is a defect in the oracle and no fetch is needed to"
  say "  say so."
  exit 1
fi

# ------------------------------------------------------------------ #
# NETWORK LANE                                                        #
# ------------------------------------------------------------------ #

hdr "NETWORK LANE — RFC 1071's own text"

TMP="$(mktemp -d "${TMPDIR:-/tmp}/rfc1071.XXXXXX")" || exit 2
trap 'rm -rf "$TMP"' EXIT
BODY="$TMP/rfc1071.txt"
SOURCE=""

identity_ok() {
  grep -qi 'Computing the Internet Checksum' "$1" && grep -qi 'Numerical Examples' "$1"
}

if [ -n "$BODY_FILE" ]; then
  if [ ! -e "$BODY_FILE" ]; then
    say "  --print-body: $BODY_FILE does not exist."
    exit 2
  fi
  if ! identity_ok "$BODY_FILE"; then
    hdr "VERDICT: OBLIGATION OPEN — the supplied file is not RFC 1071"
    say "  $BODY_FILE does not carry 'Computing the Internet Checksum' and"
    say "  'Numerical Examples'. The identity gate applies to --print-body exactly"
    say "  as it applies to a fetch: an audit path that greps an unidentified"
    say "  document would be a way of confirming the anchor against anything."
    [ "$TOLERATE" -eq 1 ] && exit 0
    exit 2
  fi
  cp "$BODY_FILE" "$BODY"
  SOURCE="file://$BODY_FILE"
  say "  reading from $SOURCE (network skipped by request)"
else
  for u in $URLS; do
    code="$(curl -sS -L --max-time 30 --retry 2 --retry-delay 2 \
      -o "$TMP/candidate" -w '%{http_code}' "$u" 2>"$TMP/curlerr")"
    rc=$?
    if [ "$rc" -ne 0 ]; then
      say "  $u -> transport error: $(tr -d '\n' < "$TMP/curlerr" | cut -c1-160)"
      continue
    fi
    if [ "$code" != "200" ]; then
      say "  $u -> HTTP $code"
      continue
    fi
    if ! identity_ok "$TMP/candidate"; then
      say "  $u -> HTTP 200 but the body does not identify itself as RFC 1071"
      say "        (no 'Computing the Internet Checksum' + 'Numerical Examples')."
      say "        Refusing to grep an unidentified document."
      continue
    fi
    cp "$TMP/candidate" "$BODY"
    SOURCE="$u"
    say "  $u -> HTTP 200, identified as RFC 1071"
    break
  done
fi

if [ -z "$SOURCE" ]; then
  hdr "VERDICT: OBLIGATION OPEN — RFC 1071 could not be fetched"
  say "  Every source above failed. NOTHING WAS CONFIRMED."
  say "  test/golden/ipv4_ref.ml's anchor stays EMBEDDED AND UNCONFIRMED, and"
  say "  SO-ip_eth_rx_64.md's open obligation stays open. The local lane's"
  say "  four checks passed, which means the constants are self-consistent —"
  say "  it does NOT mean they are RFC 1071's."
  say ""
  say "  If this ran on a CI runner, a 403/blocked egress here is NEWS: the"
  say "  runner is the open-egress path this check was written for. Report it"
  say "  rather than re-running until it goes away."
  if [ "$TOLERATE" -eq 1 ]; then
    say ""
    say "  --tolerate-unreachable given: exiting 0 so a known-blocked"
    say "  development container does not mask other checks. The obligation is"
    say "  open, and this run is not coverage."
    exit 0
  fi
  exit 2
fi

BYTES="$(wc -c < "$BODY" | tr -d ' ')"
DIGEST="$(sha256sum "$BODY" 2>/dev/null | cut -d' ' -f1)"
say "  provenance: $SOURCE"
say "  bytes: $BYTES   sha256: ${DIGEST:-<no sha256sum>}"

# ---- slice §3
awk '
  /^[ \t]*3\.[ \t]+[Nn]umerical[ \t]+[Ee]xamples/ { on = 1 }
  on && /^[ \t]*4\.[ \t]+[A-Za-z]/ && !/^[ \t]*3\./ { exit }
  on { print }
' "$BODY" > "$TMP/sec3"
SEC3_LINES="$(grep -c . "$TMP/sec3" 2>/dev/null)"
SEC3_LINES="${SEC3_LINES:-0}"

if [ "$SEC3_LINES" -lt 5 ]; then
  hdr "VERDICT: OBLIGATION OPEN — §3 could not be sliced out of the fetched text"
  say "  The document was fetched and identified, but the heading"
  say "  '3.  Numerical Examples' was not found in a form this script can cut on"
  say "  (got $SEC3_LINES lines). It deliberately does NOT fall back to grepping"
  say "  the whole document: 'the token appears somewhere in RFC 1071' is not"
  say "  the claim the oracle makes, and confirming the weaker claim would be"
  say "  the vacuous pass this script exists to refuse."
  say "  Fix the slice, or confirm by hand and record it in a journal entry."
  [ "$TOLERATE" -eq 1 ] && exit 0
  exit 2
fi
say "  §3 sliced: $SEC3_LINES non-empty lines"

# ---- the octet string, as consecutive wire pairs
missing=""
prev_line=0
order_ok=1
set -- $OCTETS
while [ "$#" -ge 2 ]; do
  pair="$1 $2"
  hit="$(grep -in -- "$pair" "$TMP/sec3" | head -1 | cut -d: -f1)"
  if [ -z "$hit" ]; then
    missing="$missing '$pair'"
  else
    [ "$hit" -lt "$prev_line" ] && order_ok=0
    prev_line="$hit"
  fi
  shift 2
done

CONFIRMED=0
status=0

if [ -n "$missing" ]; then
  say "  [FAIL] octet pairs not found in §3:$missing"
  status=1
else
  say "  [ok]   all $((NOCTETS / 2)) octet pairs of rfc1071_example_octets appear in §3"
  if [ "$order_ok" -eq 1 ]; then
    say "  [ok]   and they appear in wire order"
  else
    say "  [warn] they appear, but not in increasing line order — inspect §3 by hand"
  fi
fi

hex_token_in_sec3() {
  grep -Eiqc "(^|[^0-9a-fA-F])$1([^0-9a-fA-F]|$)" "$TMP/sec3" >/dev/null 2>&1 &&
    grep -Eiq "(^|[^0-9a-fA-F])$1([^0-9a-fA-F]|$)" "$TMP/sec3"
}

for pair in "sum:$SUM" "checksum:$CKSUM"; do
  what="${pair%%:*}"; val="${pair#*:}"
  if hex_token_in_sec3 "$val"; then
    say "  [ok]   $what 0x$val appears in §3 as a delimited hex token"
  else
    say "  [FAIL] $what 0x$val does NOT appear in §3"
    status=1
  fi
done

# ---- negative control: the search must be able to say no
neg_sum="$(printf '%04x' $(( 0x$SUM ^ 0x0001 )))"
neg_ck="$(printf '%04x' $(( 0x$CKSUM ^ 0x0001 )))"
neg_bad=0
for pair in "sum:$neg_sum" "checksum:$neg_ck"; do
  what="${pair%%:*}"; val="${pair#*:}"
  if hex_token_in_sec3 "$val"; then
    say "  [!!]   NEGATIVE CONTROL FAILED: the deliberately wrong $what 0x$val also"
    say "         appears in §3, so a match on the real value is not discriminating."
    neg_bad=1
  fi
done
if [ "$neg_bad" -eq 0 ]; then
  say "  [ok]   negative control: neither 0x$neg_sum nor 0x$neg_ck appears in §3,"
  say "         so the matches above discriminate rather than merely occur"
fi

# ---- advisory: where does the RFC state the two §2 properties ipv4_ref cites?
section_of() {
  awk -v pat="$1" '
    /^[ \t]*[0-9]+\.[ \t]+[A-Za-z]/ { sec = $1 }
    tolower($0) ~ tolower(pat) { print (sec == "" ? "(before §1)" : sec); exit }
  ' "$BODY"
}
say ""
say "  ADVISORY — the two further RFC 1071 claims ipv4_ref.ml cites as §2's."
say "  A keyword search over prose cannot distinguish 'the RFC says it"
say "  elsewhere' from 'my keywords are wrong', so these are REPORTED and do"
say "  not gate the verdict."
for probe in "byte order:byte order" "one's complement of the sum:complement of the sum"; do
  label="${probe%%:*}"; pat="${probe#*:}"
  where="$(section_of "$pat")"
  if [ -n "$where" ]; then
    say "    \"$label\" first stated in section $where"
    [ "$where" != "2." ] && say "      note: ipv4_ref.ml cites §2 for this. CITATION DRIFT — worth a"
    [ "$where" != "2." ] && say "      one-line correction in a later packet; not a build failure."
  else
    say "    \"$label\" NOT located by keyword — inspect by hand."
  fi
done

# ---- the one place that may set CONFIRMED
if [ "$status" -eq 0 ] && [ "$neg_bad" -eq 0 ]; then
  CONFIRMED=1
fi

hdr "VERDICT"
if [ "$CONFIRMED" -eq 1 ]; then
  say "  All three of Ipv4_ref.rfc1071_example_{octets,sum,checksum} were matched"
  say "  against a §3 slice, with a negative control, and the local lane"
  say "  re-derived the arithmetic independently."
  say "  source: $SOURCE"
  say "  sha256: ${DIGEST:-unknown}"
  say ""
  case "$SOURCE" in
    file://*)
      say "  CONFIRMED AGAINST A LOCAL COPY — the obligation is NOT discharged by"
      say "  this run. --print-body was used, so this script did not fetch the"
      say "  document and cannot vouch for where it came from; the sha256 above is"
      say "  all it can offer. Discharge needs either a run that fetched the text"
      say "  itself, or a human confirmation journaled against that sha256."
      ;;
    *)
      say "  ANCHOR CONFIRMED, from a document this script fetched and identified."
      say "  This discharges the open obligation test/golden/ipv4_ref.ml records and"
      say "  that SO-ip_eth_rx_64.md carries. A sign-off citing the anchor must cite"
      say "  a RUN of this script — its CI run id — not this script's existence."
      ;;
  esac
  exit 0
fi

say "  NOT CONFIRMED — the fetched text does not carry the constants as quoted."
say "  This is a MISMATCH, not a network problem: RFC 1071 was fetched and §3 was"
say "  sliced. Either the oracle's constants are wrong or this script's"
say "  extraction is. Both are defects and both belong in a packet."
exit 1
