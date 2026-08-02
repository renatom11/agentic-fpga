#!/usr/bin/env bash
# check_abort_availability.sh — exhaustive re-derivation of the abort-bit
# availability algebra at the two modules that have one: M14 `Ip_eth_rx_64`
# (SPEC-M14 §6.1, §6.2, ADR-0012) and M17 `Udp_ip_rx_64` (SPEC-M17 §6.1, §6.2).
#
# WHY THIS EXISTS (ledger C-37, dv_lead; J-dv_lead-0011, J-dv_lead-0012).
# The same algebra produced the same defect twice — F-1 at M17 (WO-0020) and
# C-37 at M14 (WO-0022) — and both times the specification's argument reproduced
# on its own worked example and failed off it. The worked example is the one
# point in the space where checking is worthless. So this script quantifies over
# the WHOLE admissible space instead: every (N, N') pair each module accepts.
#
# It checks committed spec text against arithmetic, in the class of
# tools/check_records_vs_appendix.sh — pure bash + awk, sub-second, no
# toolchain, runnable in the development container (ADR-0005's blocker is the
# OCaml toolchain, not the shell).
#
# WHAT IT IS NOT. It is not a bench and it judges no RTL: it re-derives the
# specifications' own claims from the specifications' own cycle rules. Every
# formula below is transcribed from spec text and cited inline; this script is
# derived from specs and never from RTL (PROTOCOL §10). A failure here means a
# specification claim is false, not that a design is wrong.
#
# NOT WIRED INTO tools/dv_checks.sh. dv_checks.sh is the record-vs-text currency
# suite whose recommended CI step is the orchestrator's to make; this is an
# on-demand oracle cited by SHA in sign-off packets and journal Evidence.
# Wiring it in is a separate decision and would be dv_checks.sh's own diff.
#
# Usage: tools/check_abort_availability.sh
# Exit:  0 iff every claim holds over the whole space.

set -uo pipefail

PROG=$(cat <<'AWKEOF'
function ceil8(x) { return int((x + 7) / 8) }
function ok(cond, what) {
  checks++
  if (!cond) { fails++; printf("  FAIL: %s\n", what) }
}

BEGIN {
  checks = 0; fails = 0

  # ---------------------------------------------------------------------
  # M14 — SPEC-M14 §6.1, as moved by ADR-0012 at 8641455.
  #
  #   N   = octets the Ethernet payload delivers, Ethernet PADDING INCLUDED
  #         (REQ-408 leaves padding in place at M06), 46 .. 1500.
  #   N'  = the IPv4 total length, 21 .. N.  N' = 20 declares an empty payload
  #         and emits no payload frame (requirements.md §0.7); N' > N is
  #         REQ-605 truncation and never reaches this question.
  #   K   = ceil(N/8) input words; the input tlast is presented on Ci + K - 1.
  #   M   = ceil((N'-20)/8) payload words; the payload tlast word, index M-1,
  #         leaves on Ci + M + 3.
  #   D   = K - M - 3, the CYCLE deficit.  M14 copies iff D <= 0.
  #   W   = ceil(N/8) - ceil(N'/8), SPEC-M17's WORD deficit.  `Tail` is entered
  #         on W >= 1: input word ceil(N'/8)-1 carries the declared count's last
  #         octet and must precede input word K-1.
  # ---------------------------------------------------------------------
  m14_dmin = 999999; m14_dmax = -999999; m14_sup = 0; m14_sup_n = 0
  for (N = 46; N <= 1500; N++) {
    K = ceil8(N)
    for (Np = 21; Np <= N; Np++) {
      M = ceil8(Np - 20)
      D = K - M - 3
      sep = (M + 3) - (K - 1)          # payload tlast cycle - input tlast cycle

      # §6.1: "the separation is exactly 1 - D".
      ok(sep == 1 - D, sprintf("M14 separation != 1-D at N=%d Np=%d", N, Np))

      # §6.1: "The bit is available iff N' >= 8*ceil(N/8) - 11".
      ok((D <= 0) == (Np >= 8 * K - 11), \
         sprintf("M14 under-fill threshold at N=%d Np=%d", N, Np))

      if (D < m14_dmin) m14_dmin = D
      if (D > m14_dmax) m14_dmax = D

      # §6.1: D = W - 1 for N' mod 8 in {0,5,6,7}; D = W for {1,2,3,4}.
      W = K - ceil8(Np)
      r = Np % 8
      if (r == 0 || r >= 5) ok(D == W - 1, sprintf("M14 D!=W-1 at N=%d Np=%d", N, Np))
      else                  ok(D == W,     sprintf("M14 D!=W at N=%d Np=%d", N, Np))

      # §6.2 Tail row: "D >= 1 implies Tail, and Tail does not imply D >= 1".
      tail = (W >= 1)
      ok(!(D >= 1) || tail, sprintf("M14 D>=1 without Tail at N=%d Np=%d", N, Np))
      if (tail && D <= 0) {
        m14_sup++
        if (m14_sup_n == 0) { m14_sup_n = N; m14_sup_np = Np }
      }
    }
  }
  ok(m14_dmin == -1, sprintf("M14 min D is %d, §6.1 says it never falls below -1", m14_dmin))
  ok(m14_dmax == 184, sprintf("M14 max D is %d, §6.1's worst case implies 184", m14_dmax))
  ok(m14_sup > 0, "M14 Tail is NOT a proper superset of the D>=1 class")
  printf("M14  D over the whole admissible space: %d .. %d   (§6.1: never below -1; worst 184)\n", \
         m14_dmin, m14_dmax)
  printf("M14  in-Tail-but-still-copies witnesses: %d, first (N=%d, total length %d)\n", \
         m14_sup, m14_sup_n, m14_sup_np)
  printf("       -> §6.2's Tail is a PROPER superset of the derived-0 class\n")

  # §6.1: at N' = N, D is 0 or -1 by N mod 8.
  for (N = 46; N <= 1500; N++) {
    D = ceil8(N) - ceil8(N - 20) - 3
    r = N % 8
    if (r == 0 || r >= 5) ok(D == -1, sprintf("M14 full-delivery D!=-1 at N=%d", N))
    else                  ok(D == 0,  sprintf("M14 full-delivery D!=0 at N=%d", N))
  }

  # §6.1: the minimum-length frame, N = 46 -> threshold 37, band 21..36.
  N = 46; K = ceil8(N); lo = 0; hi = 0
  for (Np = 21; Np <= N; Np++) {
    if (K - ceil8(Np - 20) - 3 >= 1) { if (lo == 0) lo = Np; hi = Np }
  }
  ok(lo == 21 && hi == 36, sprintf("M14 band is %d..%d, §6.1 says 21..36", lo, hi))
  ok(8 * K - 11 == 37, "M14 minimum-frame threshold is not 37")
  printf("M14  N=46 (64-octet frame): threshold total length >= %d, unavailable band %d .. %d\n", \
         8 * K - 11, lo, hi)

  # §6.1: surviving under-fill is 11 - (8*ceil(N/8) - N), i.e. 4 .. 11 octets.
  tmin = 99; tmax = -99
  for (N = 46; N <= 1500; N++) {
    t = 11 - (8 * ceil8(N) - N)
    if (t < tmin) tmin = t
    if (t > tmax) tmax = t
  }
  ok(tmin == 4 && tmax == 11, \
     sprintf("M14 under-fill tolerance %d..%d, §6.1 says 4..11", tmin, tmax))
  printf("M14  surviving under-fill by residue: %d .. %d octets\n", tmin, tmax)

  # §6.1 regime table, worst case: N = 1500, N' = 21.
  N = 1500; Np = 21; K = ceil8(N); M = ceil8(Np - 20); D = K - M - 3
  ok(D == 184, sprintf("M14 worst-case D is %d, expected 184", D))
  printf("M14  worst case N=1500, total length 21: payload tlast Ci+%d, input tlast Ci+%d, readable Ci+%d\n", \
         M + 3, K - 1, K)
  printf("       -> %d cycles before the input tlast is PRESENTED   (§6.1, the M17 convention)\n", D - 1)
  printf("       -> %d cycles before the bit is READABLE by a registered output (dv_lead, WO-0022)\n", D)
  ok(D - 1 == 183, "M14 worst case is not 183 cycles before the input tlast")

  # §8's adjacent pair: total lengths 36 and 37 inside a 64-octet frame.
  N = 46; K = ceil8(N)
  split("36 37", pair, " ")
  for (i = 1; i <= 2; i++) {
    Np = pair[i] + 0
    M = ceil8(Np - 20); D = K - M - 3; W = K - ceil8(Np)
    printf("M14  §8 pair, total length %d: D=%d  W=%d  Tail=%s  payload=%d octets in %d words, tlast Ci+%d, padding=%d\n", \
           Np, D, W, (W >= 1 ? "yes" : "no"), Np - 20, M, M + 3, N - Np)
    ok(W == 1, sprintf("M14 §8 pair total length %d: word deficit %d, expected 1", Np, W))
    ok(N - Np > 0, sprintf("M14 §8 pair total length %d carries no padding", Np))
    if (Np == 36) {
      ok(D == 1, "M14 §8 total length 36 is not D=1")
      ok(M + 3 == K - 1, "M14 §8 total length 36 does not leave on the input tlast cycle")
      ok(Np - 20 == 16 && M == 2, "M14 §8 total length 36 is not 16 octets in 2 words")
    } else {
      ok(D == 0, "M14 §8 total length 37 is not D=0")
      ok(M + 3 == K, "M14 §8 total length 37 does not leave one cycle after")
      ok(Np - 20 == 17 && M == 3, "M14 §8 total length 37 is not 17 octets in 3 words")
    }
  }
  # The pair kills the three wrong keys named in §8 and ADR-0012 §3: both
  # datagrams agree on padding, on Tail and on the word deficit and disagree
  # only on D, so any key other than D answers the two identically.
  d36 = ceil8(46) - ceil8(16) - 3; d37 = ceil8(46) - ceil8(17) - 3
  ok(d36 != d37, "M14 §8 pair does not separate on D")
  ok((ceil8(46) - ceil8(36)) == (ceil8(46) - ceil8(37)), \
     "M14 §8 pair separates on the word deficit — it must not")
  printf("M14  §8 pair: padding, Tail and word deficit agree; only D differs\n")
  printf("       -> kills unconditional-copy (fails 36), padding-keyed, Tail-keyed and M17-word-deficit-keyed (all fail 37)\n")

  # §8: total length 1500 fully delivered sits at D = 0, zero margin.
  D = ceil8(1500) - ceil8(1480) - 3
  ok(D == 0, sprintf("M14 total length 1500 is D=%d, §8 says 0 (zero margin)", D))

  # ---------------------------------------------------------------------
  # M17 — SPEC-M17 §6.1, as repaired by F-1 at d8df28d.
  #   N   = IPv4 payload octets delivered to M17, 1 .. 1480.
  #   N'  = the UDP length, 9 .. N.  Length 8 declares no payload frame.
  #   M   = ceil((N'-8)/8) = ceil(N'/8) - 1; application tlast at Ci + M + 1.
  #   D   = ceil(N/8) - ceil(N'/8), the WORD deficit.  M17 copies iff D = 0.
  # ---------------------------------------------------------------------
  m17_dmin = 999999; m17_dmax = -999999
  for (N = 1; N <= 1480; N++) {
    K = ceil8(N)
    for (Np = 9; Np <= N; Np++) {
      M = ceil8(Np - 8)
      D = K - ceil8(Np)
      sep = (M + 1) - (K - 1)

      ok(M == ceil8(Np) - 1, sprintf("M17 M != ceil(Np/8)-1 at Np=%d", Np))
      ok(sep == 1 - D, sprintf("M17 separation != 1-D at N=%d Np=%d", N, Np))
      ok(D >= 0, sprintf("M17 D negative at N=%d Np=%d", N, Np))
      # §6.2: "This state and §6.1's D >= 1 are the same class" — EQUALITY,
      # where SPEC-M14 §6.2 pins its own two names UNEQUAL.
      ok((M + 1 < K) == (D >= 1), sprintf("M17 Tail != D>=1 at N=%d Np=%d", N, Np))
      if (D < m17_dmin) m17_dmin = D
      if (D > m17_dmax) m17_dmax = D
    }
  }
  ok(m17_dmin == 0, sprintf("M17 min D is %d, §6.1 says D >= 0", m17_dmin))
  printf("M17  D over the whole admissible space: %d .. %d   (§6.1: D >= 0)\n", m17_dmin, m17_dmax)
  D = ceil8(1480) - ceil8(9)
  ok(D == 183, sprintf("M17 worst case D=%d, §6.1 says 183", D))
  printf("M17  worst case N=1480, UDP length 9: D=%d, %d cycles before the input tlast\n", D, D - 1)
  printf("M17  Tail == D>=1 EXACTLY, against M14's proper superset — the cross-module trap §8 drives\n")

  # ---------------------------------------------------------------------
  # The composite ADR-0012's Consequences states and which neither
  # specification can state alone: the application sees the inherited mark iff
  # BOTH stages can carry it.  Enumerated over the 64-octet minimum frame,
  # where M14's class is entered by ordinary Ethernet padding.
  # ---------------------------------------------------------------------
  marked = 0; lost14 = 0; lost17 = 0; nopayload = 0
  for (Np = 21; Np <= 46; Np++) {                # IPv4 total length
    d14 = ceil8(46) - ceil8(Np - 20) - 3
    n17 = Np - 20                                # octets M14 delivers to M17
    for (u17 = 9; u17 <= n17; u17++) {           # UDP length, 9 = one payload octet
      d17 = ceil8(n17) - ceil8(u17)
      if (d14 <= 0 && d17 == 0) marked++
      else if (d14 >= 1) lost14++
      else lost17++
    }
    if (n17 < 9) nopayload++
  }
  printf("Composite over the 64-octet minimum frame, inherited bit = 1:\n")
  printf("  (total length, UDP length) pairs emitting an application frame: %d marked, %d lost at M14, %d lost at M17\n", \
         marked, lost14, lost17)
  printf("  total lengths with no application payload frame at all: %d\n", nopayload)
  ok(lost14 > 0, "no M14-side loss at the minimum frame — the residual claim would be moot")
  ok(marked > 0, "no marked case at the minimum frame — the copy class would be empty here")

  printf("\n%d check(s) run, %d failure(s)\n", checks, fails)
  exit (fails == 0 ? 0 : 1)
}
AWKEOF
)

awk "$PROG" </dev/null
