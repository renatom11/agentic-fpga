#!/usr/bin/env bash
# check_rfc1071_anchor.sh — close (or keep visibly open) the external-anchor
# obligation on test/golden/ipv4_ref.ml.
#
# THE OBLIGATION, IN ITS OWN WORDS
#
# test/golden/ipv4_ref.ml embeds RFC 1071's worked example and says of itself
# that no sign-off may cite the oracle as anchored until a reader or a CI step
# with network access has confirmed its constants against the RFC. Charter §3
# makes anchor-before-judge non-negotiable and PROTOCOL §10 makes it a
# programme rule. This script is the confirming step.
#
# WHAT RUN 30764198256 ESTABLISHED, AND WHAT IT COST ME
#
# The first run on an open-egress runner FETCHED the RFC (53,524 bytes, sha256
# e10dfd68…) and returned NOT CONFIRMED — correctly. It found TWO defects, and
# both were mine (WO-0037, J-dv_lead-0021):
#
#   1. EXTRACTOR. §3 prints the byte-by-byte column as `Byte 0/1:    00   01`
#      — column-aligned, THREE spaces. The old matcher looked for the literal
#      "00 01" with one space and found nothing. Its three prose probes failed
#      for the same family of reason: RFC 1071 line-WRAPS its sentences, so no
#      phrase longer than a few words survives a line-oriented grep, and it
#      writes "1's complement" (9 times) where my probe said "one's complement"
#      (which it also uses, 5 times).
#
#   2. THE ORACLE'S QUOTED CLAIM. ipv4_ref.ml said §3 "prints" the checksum
#      0x220d. It does not. **The token 220d does not appear anywhere in RFC
#      1071 — zero occurrences in the whole document.** §3 computes and prints
#      the SUM (ddf2) and stops there. The constant is CORRECT; the citation
#      was an overclaim. 0x220d is DERIVED from the quoted sum by §1's own
#      rule, not quoted.
#
# Both are repaired here. The repair is deliberately not "grep for less until
# it passes": the checksum's confirmation moved from a weaker claim (a token
# appears in §3) to a STRONGER one (an exact defining sentence is quoted from
# §1, and the arithmetic is executed locally), and three fuzzy advisories
# became three gating verbatim quotations.
#
# WHAT IT WILL NOT DO
#
# It will not pass without having matched real fetched text. Exactly one place
# below sets CONFIRMED, inside the branch that compared against a document
# which (a) was fetched, (b) identified itself as RFC 1071, and (c) yielded the
# section slices the claims are scoped to. A network failure is exit 2, not 0.
# "The grep found nothing" is exit 2 or 1, never 0. Vacuous confirmation of an
# anchor is worse than an open obligation, because it looks closed.
#
# THE TWO LANES
#
#   LOCAL    No network. Re-derives RFC 1071's arithmetic over the embedded
#            octets in awk — an implementation sharing no code with the OCaml
#            oracle — and checks the sum, the checksum as the 1's complement
#            of it, the residue form, and byte-swap invariance. Always runs,
#            always has a verdict. It cannot confirm a QUOTATION; it proves
#            the constants are mutually consistent, so a typo is caught with
#            no network at all. Since 0x220d is now DERIVED rather than
#            quoted, this lane is load-bearing for it: the chain is
#            "§3's sum is quoted" (network) + "checksum = 1's complement of
#            the sum" (§1, quoted) + "~0xddf2 = 0x220d" (here).
#
#   NETWORK  Fetches the RFC, checks it identifies itself, slices the sections
#            each claim is scoped to, and gates on FIVE claims — two hex-token
#            claims in §3 and three verbatim sentences in §1 and §2 — plus a
#            negative control and an absence claim. See "THE FIVE CLAIMS".
#
# THE FIVE CLAIMS, EACH WITH ITS OWN SCOPE AND ITS OWN FORM
#
#   C1  §3   the octet string, in BOTH forms §3 prints it: the byte-by-byte
#            column (00 01 / f2 03 / f4 f5 / f6 f7, whitespace-tolerant) and
#            the "Normal Order" halfword column (0001 f203 f4f5 f6f7, as
#            delimited hex tokens). Both, because §3 carries both and a
#            matcher that accepts either is a matcher that has stopped
#            checking one of them.
#   C2  §3   the sum, 0xddf2, as a delimited hex token.
#   C3  §1   the checksum's DEFINITION, verbatim: "the 1's complement of this
#            sum is placed in the checksum field". This is the authority for
#            0x220d being derived, and it replaces the withdrawn "§3 prints
#            it" claim.
#   C4  §1   the residue form, verbatim: "all 1 bits (-0 in 1's complement
#            arithmetic)" together with "including the checksum field" — the
#            form SPEC-M14 §6.1 makes normative and M14 implements.
#   C5  §2   byte-order independence, verbatim: "The sum of 16-bit integers
#            can be computed in either byte order." — §2's property (B), the
#            second of its three, which is exactly what ipv4_ref.ml cites.
#
#   plus  NEGATIVE CONTROL   the deliberately wrong sum token must be ABSENT
#                            from §3, or a match on the right one does not
#                            discriminate.
#   plus  ABSENCE CLAIM      0x220d must appear NOWHERE in the document. This
#                            is the load-bearing fact behind reclassifying the
#                            checksum as derived, so it is gated rather than
#                            noted: if it is ever false, the reclassification
#                            was wrong and I want that loud.
#
# WHY PROSE MAY GATE HERE WHEN IT COULD NOT BEFORE
#
# The old rule — "a keyword search over prose cannot tell 'the RFC says it
# elsewhere' from 'my keywords are wrong', so it may not gate" — was right
# about KEYWORDS and is the reason those probes were advisory. C3/C4/C5 are
# not keywords: they are verbatim sentences of 40+ characters, matched after
# whitespace normalisation, scoped to a named section. A verbatim sentence
# that is absent from its section is a fact about the document, not an
# artefact of my vocabulary. That is what makes them gateable.
#
# WHITESPACE NORMALISATION, AND WHY IT IS THE WHOLE FIX
#
# RFC text is column-aligned and line-wrapped, with page furniture every 50
# lines. Every one of run 30764198256's misses was a whitespace artefact. So
# page furniture is stripped and each slice is collapsed to a single
# space-separated line BEFORE matching. Delimited-hex-token matching is
# unaffected (a space is still a delimiter); phrase matching stops caring
# where the RFC broke its lines.
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
#       read the RFC text from FILE instead of the network. A run this way
#       DISCHARGES the obligation only if FILE's sha256 equals the digest
#       recorded below, which a CI run observed from www.rfc-editor.org;
#       otherwise it confirms against an unvouched copy and says so.
#   tools/check_rfc1071_anchor.sh --self-test
#       prove the EXTRACTOR has teeth without pretending to have seen the RFC.
#       It generates documents at run time — from the oracle's own constants,
#       banner-marked SYNTHETIC and never written into the repo — and
#       requires a well-formed one to CONFIRM and each of ten seeded
#       corruptions to be REJECTED: one per gating claim, plus the negative
#       control, the absence claim, an unsliceable document and an
#       unidentified one.
#
# EXIT
#   0  every claim confirmed against fetched RFC 1071 text (or
#      --tolerate-unreachable was given and the fetch failed)
#   1  MISMATCH — a claim failed against a document that WAS fetched and
#      sliced, or the local arithmetic is inconsistent. Always a real failure.
#   2  OBLIGATION OPEN — the text could not be fetched, identified or sliced.
#      Nothing was confirmed and nothing is claimed.

set -uo pipefail

HERE="$(cd "$(dirname "$0")" && pwd)"
REPO="$(cd "$HERE/.." && pwd)"
ORACLE="$REPO/test/golden/ipv4_ref.ml"

# Observed by CI run 30764198256 fetching https://www.rfc-editor.org/rfc/rfc1071.txt
# (53,524 bytes). Advisory when it matches — it is provenance, not content —
# and it is what lets a --print-body run discharge the obligation.
RFC1071_KNOWN_SHA256=e10dfd6816447843d47a7f1b990eba756a791a6308fd5b698a6276075a8e4f9b
RFC1071_KNOWN_BYTES=53524
RFC1071_KNOWN_RUN=30764198256

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
# text machinery                                                      #
# ------------------------------------------------------------------ #

# Strip RFC page furniture: form feeds, "[Page N]" footers, and the running
# header. Left in place, any of these can land in the middle of a wrapped
# sentence and defeat a phrase match.
strip_furniture() {
  sed -e 's/\x0c//g' \
      -e '/^.*\[Page [0-9][0-9]*\][ \t]*$/d' \
      -e '/^RFC 1071  *Computing the Internet Checksum/d' "$1"
}

# Collapse a stream to one space-separated line.
normalise() { tr '\n' ' ' | tr -s ' \t' ' ' | sed 's/^ //;s/ $//'; }

# Slice a top-level section by number. A heading is a line whose WHOLE content
# is a short numbered title — which excludes prose that merely happens to wrap
# onto a line beginning "8." (RFC 1071 line 133 does exactly that, and a looser
# regex reads it as a section heading). RFC 1071 indents its §2 heading by five
# spaces where §1, §3 and §4 sit at column 0, so leading space is tolerated.
slice_section() {
  # $1 = furniture-stripped file, $2 = section number.
  # A heading is tested by explicit conditions rather than one interval regex:
  # mawk and gawk disagree about {n,m} passed through -v, and the conditions
  # are easier to read than the regex that would replace them anyway.
  awk -v want="$2" '
    function is_heading(line,   n, f) {
      if (length(line) > 60) return 0                       # a title, not prose
      if (line !~ /^[ ]*[0-9]+(\.[0-9]+)?\.?[ ]+[A-Z]/) return 0
      if (split(line, f, " ") > 7) return 0
      match(line, /^[ ]*/)
      if (RLENGTH > 5) return 0        # RFC 1071 indents §2 by five spaces
      return 1
    }
    {
      if (is_heading($0)) {
        n = $1; sub(/\.$/, "", n)
        if (n == want) { on = 1; print; next }
        if (on) { exit }
      }
      if (on) print
    }
  ' "$1"
}

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
say "authority: RFC 1071, \"Computing the Internet Checksum\" (Braden, Borman,"
say "           Partridge, September 1988) — §3 for the worked example, §1 for"
say "           the checksum's definition and the residue form, §2 for"
say "           byte-order independence."
say ""
say "constants under test, parsed from the oracle (never hard-coded here):"
say "  rfc1071_example_octets   = $OCTETS  ($NOCTETS octets)   [QUOTED from §3]"
say "  rfc1071_example_sum      = 0x$SUM                     [QUOTED from §3]"
say "  rfc1071_example_checksum = 0x$CKSUM                     [DERIVED — see C3]"

# ------------------------------------------------------------------ #
# --self-test                                                         #
# ------------------------------------------------------------------ #

if [ "$SELFTEST" -eq 1 ]; then
  hdr "SELF-TEST — the extractor, against documents generated here"
  say "  These fixtures are SYNTHETIC and are written to a temporary directory,"
  say "  never into the repository. They prove the machinery confirms a"
  say "  well-formed document and rejects each way it can be wrong. They prove"
  say "  NOTHING about RFC 1071's real text — only a fetch can, and that is the"
  say "  network lane."
  ST="$(mktemp -d "${TMPDIR:-/tmp}/rfc1071-selftest.XXXXXX")" || exit 2
  trap 'rm -rf "$ST"' EXIT

  gen() {
    # $1 out, $2 sum token, $3 drop-claim ("c1col"|"c1hw"|"c3"|"c4"|"c5"|""),
    # $4 extra line
    local out_file="$1" sum_token="$2" drop="${3:-}" extra="${4:-}"
    {
      printf '%s\n' "            SYNTHETIC LAYOUT FIXTURE - NOT RFC 1071"
      printf '%s\n' "   Generated by tools/check_rfc1071_anchor.sh --self-test to exercise"
      printf '%s\n' "   its own extractor. Not evidence of anything. Do not quote."
      printf '\n%s\n' "                  Computing the Internet Checksum"
      printf '\n%s\n' "1.  Introduction"
      printf '%s\n' "   This memo discusses methods for computing the Internet checksum."
      printf '%s\n' "   In outline, the algorithm is very simple."
      printf '%s\n' "   (1)  Adjacent octets are paired to form 16-bit integers."
      printf '%s\n' "   (2)  To generate a checksum, the checksum field itself is cleared,"
      if [ "$drop" != c3 ]; then
        printf '%s\n' "        the 16-bit 1's complement sum is computed over the octets"
        printf '%s\n' "        concerned, and the 1's complement of this sum is placed in the"
        printf '%s\n' "        checksum field."
      fi
      printf '%s\n' "   (3)  To check a checksum, the 1's complement sum is computed over"
      if [ "$drop" != c4 ]; then
        printf '%s\n' "        the same set of octets, including the checksum field.  If the"
        printf '%s\n' "        result is all 1 bits (-0 in 1's complement arithmetic), the"
        printf '%s\n' "        check succeeds."
      fi
      printf '\n%s\n' "     2.  Calculating the Checksum"
      printf '%s\n' "        This simple checksum has mathematical properties."
      printf '%s\n' "   (A)  Commutative and Associative"
      printf '%s\n' "        The sum can be done in any order."
      printf '%s\n' "   (B)  Byte Order Independence"
      if [ "$drop" != c5 ]; then
        printf '%s\n' "        The sum of 16-bit integers can be computed in either byte order."
      fi
      printf '\n%s\n' "3. Numerical Examples"
      printf '%s\n' "   We now present explicit examples of calculating a simple sum."
      printf '%s\n' "   All numbers are in hex."
      printf '%s\n' "                  Byte-by-byte    \"Normal\"  Swapped"
      set -- $OCTETS
      i=0
      while [ "$#" -ge 2 ]; do
        # column-aligned, exactly as the RFC does it: multiple spaces
        if [ "$drop" = c1col ]; then
          printf '        Byte %d/%d:    XX   YY        %s%s      swap\n' "$i" "$((i + 1))" "$1" "$2"
        elif [ "$drop" = c1hw ]; then
          printf '        Byte %d/%d:    %s   %s        zzzz      swap\n' "$i" "$((i + 1))" "$1" "$2"
        else
          printf '        Byte %d/%d:    %s   %s        %s%s      swap\n' \
            "$i" "$((i + 1))" "$1" "$2" "$1" "$2"
        fi
        i=$((i + 2)); shift 2
      done
      printf '        Sum2:        dd   f2        %s      swap\n' "$sum_token"
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

  gen "$ST/good.txt" "$SUM" "" ""
  st_case "well-formed document carrying every claim" 0 "$ST/good.txt"

  gen "$ST/wrongsum.txt" "$(printf '%04x' $((0x$SUM ^ 0x0001)))" "" ""
  st_case "C2: sum one bit off" 1 "$ST/wrongsum.txt"

  gen "$ST/ambig.txt" "$SUM" "" "Also mentioned: $(printf '%04x' $((0x$SUM ^ 0x0001)))"
  st_case "negative control: both the right and the wrong sum present" 1 "$ST/ambig.txt"

  gen "$ST/nocol.txt" "$SUM" c1col ""
  st_case "C1: byte-by-byte column absent" 1 "$ST/nocol.txt"

  gen "$ST/nohw.txt" "$SUM" c1hw ""
  st_case "C1: Normal-Order halfword column absent" 1 "$ST/nohw.txt"

  gen "$ST/noc3.txt" "$SUM" c3 ""
  st_case "C3: the checksum's defining sentence absent from §1" 1 "$ST/noc3.txt"

  gen "$ST/noc4.txt" "$SUM" c4 ""
  st_case "C4: the residue sentence absent from §1" 1 "$ST/noc4.txt"

  gen "$ST/noc5.txt" "$SUM" c5 ""
  st_case "C5: the byte-order sentence absent from §2" 1 "$ST/noc5.txt"

  gen "$ST/has220d.txt" "$SUM" "" "Checksum: $CKSUM"
  st_case "absence claim: the derived checksum printed in the document" 1 "$ST/has220d.txt"

  gen "$ST/nosec.txt" "$SUM" "" ""
  sed -i 's/^3\. Numerical Examples$/X. Numerical Examples/' "$ST/nosec.txt"
  st_case "document with no sliceable §3" 2 "$ST/nosec.txt"

  printf 'not a document about checksums at all\n' > "$ST/junk.txt"
  st_case "unidentified document" 2 "$ST/junk.txt"

  hdr "SELF-TEST VERDICT"
  if [ "$st_status" -eq 0 ]; then
    say "  self-test: OK — the extractor confirms a good document and rejects"
    say "  every seeded corruption, including one per gating claim."
    say "  It has said nothing about RFC 1071."
  else
    say "  self-test: FAILED — the extractor is not trustworthy; do not read a"
    say "  CONFIRMED from it until this passes."
  fi
  exit "$st_status"
fi

# ------------------------------------------------------------------ #
# LOCAL LANE                                                          #
# ------------------------------------------------------------------ #

hdr "LOCAL LANE — RFC 1071's arithmetic, re-derived here in awk (no network)"
say "  A second implementation, sharing no code with Ipv4_ref.sum. It confirms"
say "  the constants are CONSISTENT. Since 0x$CKSUM is DERIVED rather than"
say "  quoted, this lane is one of the three links that establish it: §3's sum"
say "  (network C2) + §1's rule (network C3) + this arithmetic."

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
    o[n + 1] = int((65535 - s) / 256); o[n + 2] = (65535 - s) % 256
    printf "residue=%04x\n", sum1(o, n + 2)
    delete o[n + 1]; delete o[n + 2]
    for (i = 1; i <= n; i += 2) { t = o[i]; o[i] = o[i + 1]; o[i + 1] = t }
    printf "swapped=%04x\n", sum1(o, n)
    printf "swap_of_sum=%04x\n", (s % 256) * 256 + int(s / 256)
    # the Normal-Order halfword column §3 also prints
    line = ""
    for (i = 1; i <= n; i += 2) line = line sprintf("%02x%02x ", o[i + 1], o[i])
    printf "halfwords=%s\n", line
  }
')"

lget() { printf '%s\n' "$LOCAL_OUT" | sed -n "s/^$1=//p"; }
L_SUM="$(lget sum)"; L_CK="$(lget checksum)"; L_RES="$(lget residue)"
L_SW="$(lget swapped)"; L_SWS="$(lget swap_of_sum)"; HALFWORDS="$(lget halfwords)"

local_status=0
if [ "$L_SUM" = "$SUM" ]; then
  say "  [ok]   1's complement sum of the octets = 0x$L_SUM, matches rfc1071_example_sum"
else
  say "  [FAIL] 1's complement sum of the octets = 0x$L_SUM, but the oracle says 0x$SUM"
  local_status=1
fi
if [ "$L_CK" = "$CKSUM" ]; then
  say "  [ok]   its 1's complement = 0x$L_CK, matches rfc1071_example_checksum"
else
  say "  [FAIL] its 1's complement = 0x$L_CK, but the oracle says 0x$CKSUM"
  local_status=1
fi
if [ "$L_RES" = "ffff" ]; then
  say "  [ok]   residue form: octets + their checksum sum to 0xFFFF (all 1 bits)"
else
  say "  [FAIL] residue form: octets + their checksum sum to 0x$L_RES, not 0xFFFF"
  local_status=1
fi
if [ "$L_SW" = "$L_SWS" ]; then
  say "  [ok]   byte-swap invariance: sum(swap(octets)) = 0x$L_SW = swap(sum)"
else
  say "  [FAIL] byte-swap invariance: sum(swap(octets)) = 0x$L_SW, swap(sum) = 0x$L_SWS"
  local_status=1
fi

if [ "$local_status" -ne 0 ]; then
  hdr "VERDICT: MISMATCH (local)"
  say "  The constants are not even self-consistent under the arithmetic they"
  say "  claim. That is a defect in the oracle and no fetch is needed to say so."
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
FETCHED=0

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
      say "  $u -> HTTP 200 but the body does not identify itself as RFC 1071."
      say "        Refusing to grep an unidentified document."
      continue
    fi
    cp "$TMP/candidate" "$BODY"
    SOURCE="$u"
    FETCHED=1
    say "  $u -> HTTP 200, identified as RFC 1071"
    break
  done
fi

if [ -z "$SOURCE" ]; then
  hdr "VERDICT: OBLIGATION OPEN — RFC 1071 could not be fetched"
  say "  Every source above failed. NOTHING WAS CONFIRMED."
  say "  test/golden/ipv4_ref.ml's anchor stays unconfirmed at this SHA. The"
  say "  local lane's four checks passed, which means the constants are"
  say "  self-consistent — it does NOT mean they are RFC 1071's."
  say ""
  say "  If this ran on a CI runner, blocked egress here is NEWS: run"
  say "  $RFC1071_KNOWN_RUN proved the runner CAN reach rfc-editor.org."
  if [ "$TOLERATE" -eq 1 ]; then
    say ""
    say "  --tolerate-unreachable given: exiting 0 so a known-blocked development"
    say "  container does not mask other checks. The obligation is open, and this"
    say "  run is not coverage."
    exit 0
  fi
  exit 2
fi

BYTES="$(wc -c < "$BODY" | tr -d ' ')"
DIGEST="$(sha256sum "$BODY" 2>/dev/null | cut -d' ' -f1)"
say "  provenance: $SOURCE"
say "  bytes: $BYTES   sha256: ${DIGEST:-<no sha256sum>}"
if [ "$DIGEST" = "$RFC1071_KNOWN_SHA256" ]; then
  DIGEST_KNOWN=1
  say "  digest MATCHES the copy CI fetched from www.rfc-editor.org at run"
  say "  $RFC1071_KNOWN_RUN ($RFC1071_KNOWN_BYTES bytes). Byte-identical document."
else
  DIGEST_KNOWN=0
  say "  digest DIFFERS from run $RFC1071_KNOWN_RUN's copy (expected"
  say "  $RFC1071_KNOWN_SHA256). Not fatal — the claims below are matched"
  say "  against content, not against a digest — but it is recorded."
fi

STRIPPED="$TMP/stripped.txt"
strip_furniture "$BODY" > "$STRIPPED"

for n in 1 2 3; do
  slice_section "$STRIPPED" "$n" > "$TMP/sec$n"
done
SEC3_LINES="$(grep -c . "$TMP/sec3" 2>/dev/null)"; SEC3_LINES="${SEC3_LINES:-0}"
SEC1_LINES="$(grep -c . "$TMP/sec1" 2>/dev/null)"; SEC1_LINES="${SEC1_LINES:-0}"
SEC2_LINES="$(grep -c . "$TMP/sec2" 2>/dev/null)"; SEC2_LINES="${SEC2_LINES:-0}"

if [ "$SEC3_LINES" -lt 5 ] || [ "$SEC1_LINES" -lt 5 ] || [ "$SEC2_LINES" -lt 5 ]; then
  hdr "VERDICT: OBLIGATION OPEN — the sections could not be sliced"
  say "  Fetched and identified, but slicing gave §1=$SEC1_LINES §2=$SEC2_LINES"
  say "  §3=$SEC3_LINES non-empty lines. It deliberately does NOT fall back to"
  say "  grepping the whole document: 'the token appears somewhere in RFC 1071'"
  say "  is not the claim the oracle makes, and confirming the weaker claim would"
  say "  be the vacuous pass this script exists to refuse."
  [ "$TOLERATE" -eq 1 ] && exit 0
  exit 2
fi
say "  sliced: §1 = $SEC1_LINES lines, §2 = $SEC2_LINES lines, §3 = $SEC3_LINES lines"

N1="$(normalise < "$TMP/sec1")"
N2="$(normalise < "$TMP/sec2")"
N3="$(normalise < "$TMP/sec3")"
NALL="$(normalise < "$STRIPPED")"

status=0
in_norm() { case "$2" in *"$1"*) return 0 ;; *) return 1 ;; esac; }
tok_in() { printf '%s' "$2" | grep -Eqi "(^|[^0-9a-fA-F])$1([^0-9a-fA-F]|$)"; }

# ---- C1: the octet string, in both of §3's forms
hdr "  C1 — the octet string, in BOTH forms §3 prints it"
missing_col=""
set -- $OCTETS
while [ "$#" -ge 2 ]; do
  in_norm "$1 $2" "$N3" || missing_col="$missing_col '$1 $2'"
  shift 2
done
if [ -z "$missing_col" ]; then
  say "    [ok]   byte-by-byte column: all $((NOCTETS / 2)) pairs present"
  say "           (matched after whitespace normalisation — §3 column-aligns them)"
else
  say "    [FAIL] byte-by-byte column: pairs not found:$missing_col"
  status=1
fi
missing_hw=""
for hw in $HALFWORDS; do
  tok_in "$hw" "$N3" || missing_hw="$missing_hw $hw"
done
if [ -z "$missing_hw" ]; then
  say "    [ok]   \"Normal\" Order halfword column: $HALFWORDS all present as tokens"
else
  say "    [FAIL] halfword column: not found as delimited tokens:$missing_hw"
  status=1
fi

# ---- C2: the sum
hdr "  C2 — the sum, as a delimited hex token in §3"
if tok_in "$SUM" "$N3"; then
  say "    [ok]   0x$SUM present in §3"
else
  say "    [FAIL] 0x$SUM NOT present in §3"
  status=1
fi
neg_sum="$(printf '%04x' $(( 0x$SUM ^ 0x0001 )))"
if tok_in "$neg_sum" "$N3"; then
  say "    [!!]   NEGATIVE CONTROL FAILED: the deliberately wrong 0x$neg_sum is"
  say "           also in §3, so a match on the right value does not discriminate."
  status=1
else
  say "    [ok]   negative control: 0x$neg_sum absent, so the match discriminates"
fi

# ---- C3/C4/C5: verbatim sentences, each scoped to its section
C3='the 1'"'"'s complement of this sum is placed in the checksum field'
C4A='including the checksum field'
C4B='all 1 bits (-0 in 1'"'"'s complement arithmetic)'
C5='The sum of 16-bit integers can be computed in either byte order.'

hdr "  C3 — §1: the checksum's DEFINITION (the authority for 0x$CKSUM)"
if in_norm "$C3" "$N1"; then
  say "    [ok]   §1 states verbatim: \"…$C3\""
  say "           This, not §3, is where 0x$CKSUM comes from. §3 stops at the sum."
else
  say "    [FAIL] §1 does not carry that sentence."
  status=1
fi

hdr "  C4 — §1: the residue form (what M14 actually implements)"
if in_norm "$C4A" "$N1" && in_norm "$C4B" "$N1"; then
  say "    [ok]   §1 states verbatim: \"…$C4A…\" and \"…$C4B\""
else
  say "    [FAIL] §1 does not carry both residue phrases."
  status=1
fi

hdr "  C5 — §2: byte-order independence (property (B), §2's second)"
if in_norm "$C5" "$N2"; then
  say "    [ok]   §2 states verbatim: \"$C5\""
  say "           ipv4_ref.ml's \"§2's second property\" citation is CORRECT."
else
  say "    [FAIL] §2 does not carry that sentence."
  status=1
fi

# ---- the absence claim behind the reclassification
hdr "  ABSENCE — 0x$CKSUM must appear NOWHERE in RFC 1071"
ck_hits="$(printf '%s' "$NALL" | grep -Eoi "(^|[^0-9a-fA-F])$CKSUM([^0-9a-fA-F]|$)" | grep -c . || true)"
ck_hits="${ck_hits:-0}"
if [ "$ck_hits" -eq 0 ]; then
  say "    [ok]   0 occurrences document-wide. This is the fact that forced the"
  say "           checksum's reclassification from QUOTED to DERIVED at WO-0037."
else
  say "    [FAIL] $ck_hits occurrence(s) found. If RFC 1071 does print 0x$CKSUM,"
  say "           the WO-0037 reclassification was wrong and ipv4_ref.ml's"
  say "           provenance text must be revisited. This is deliberately loud."
  status=1
fi

# ---- diagnostics: on failure, ship the evidence the NEXT run needs
if [ "$status" -ne 0 ]; then
  hdr "  §3 AS FETCHED (first 40 non-empty lines) — so the next repair needs no fetch"
  grep . "$TMP/sec3" | head -40 | sed 's/^/    | /'
fi

# ---- the one place that may set CONFIRMED
CONFIRMED=0
[ "$status" -eq 0 ] && CONFIRMED=1

hdr "VERDICT"
if [ "$CONFIRMED" -eq 1 ]; then
  say "  Five claims confirmed against the fetched text, with a negative control"
  say "  and an absence claim:"
  say "    C1 §3  the octet string, in both printed forms"
  say "    C2 §3  the sum 0x$SUM"
  say "    C3 §1  the checksum is the 1's complement of that sum  -> 0x$CKSUM"
  say "    C4 §1  the residue form (all 1 bits, checksum field included)"
  say "    C5 §2  byte-order independence"
  say "  source: $SOURCE"
  say "  sha256: ${DIGEST:-unknown}"
  say ""
  if [ "$FETCHED" -eq 1 ]; then
    say "  ANCHOR CONFIRMED, from a document this script fetched and identified."
    say "  This discharges the obligation test/golden/ipv4_ref.ml records. A"
    say "  sign-off citing the anchor must cite a RUN of this script — its CI run"
    say "  id — not this script's existence."
  elif [ "$DIGEST_KNOWN" -eq 1 ]; then
    say "  ANCHOR CONFIRMED against a LOCAL COPY that is BYTE-IDENTICAL to the one"
    say "  CI fetched from www.rfc-editor.org at run $RFC1071_KNOWN_RUN (sha256"
    say "  matches). Provenance is therefore not this operator's word: it is a"
    say "  digest a fetch already observed. This is a valid discharge, and it is"
    say "  the form a journal entry may cite."
  else
    say "  CONFIRMED AGAINST AN UNVOUCHED LOCAL COPY — the obligation is NOT"
    say "  discharged by this run. --print-body was used and the digest does not"
    say "  match the one a fetch observed, so this script cannot say where the"
    say "  document came from."
  fi
  exit 0
fi

say "  NOT CONFIRMED — the fetched text does not carry the claims as stated."
say "  This is a MISMATCH, not a network problem: RFC 1071 was fetched and its"
say "  sections were sliced. Either the oracle's claims are wrong or this"
say "  script's extraction is. Both are defects and both belong in a packet."
say "  The §3 excerpt above is printed precisely so the repair needs no fetch."
exit 1
