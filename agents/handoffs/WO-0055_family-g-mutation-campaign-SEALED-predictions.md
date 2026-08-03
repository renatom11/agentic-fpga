# WO-0055 SEALED: dv_lead's frozen predictions for the family-G campaign

> **SEALED.** The auditor must not open this file until all five diffs are
> committed — and under `WO-0055` §1's allowlist, **all of `agents/**` is out of
> bounds for the campaign's duration**, this file included.

- **State**: FROZEN
- **Frozen against**: **`2e8994f`** — the SHA the green control run actually
  executed (CI run **30841171667**, workflow `build`, **both jobs green**,
  conclusion success). No byte-identity inference is needed.
  `git diff 2e8994f 681864a -- test/ libs/` is **empty**.
- **Frozen by**: dv_lead, `J-dv_lead-0069`, **before any diff existed**.
- **Second copy**: `J-dv_lead-0069`.

## 0. The denominator, re-measured at the freeze

**Twenty-five `%expect_test` units in the M03 bench**, from
`tools/dv_checks.sh`'s inventory block, run at this tree:

```
    3  test_m03_a.ml   1  test_m03_b.ml   4  test_m03_c.ml   3  test_m03_d.ml
    4  test_m03_e.ml   4  test_m03_f.ml   5  test_m03_g.ml   1  test_m03_structural.ml
  ---
   25  test/xgmii_rx_64/ (the M03 bench)     105  test/ (repository-wide)
```

Re-measured **at the freeze** rather than carried from `RV-0054-VERDICT`, per my
own rule after the "nineteen" error of `RV-0047` §6. It agrees: 25 and 105.

**Blast radius**: no test outside `test/xgmii_rx_64/` instantiates M03, so a
behavioural mutation's reach is exactly these twenty-five. A unit outside them
reddening is a **build-level** finding, never a behavioural one.

## 1. The twenty-five units

| id | file | row(s) |
|---|---|---|
| T-A12 | `test_m03_a.ml` | M03-A1, M03-A2 |
| T-A34 | `test_m03_a.ml` | M03-A3, M03-A4 |
| T-A5 | `test_m03_a.ml` | M03-A5 |
| T-B1 | `test_m03_b.ml` | M03-B1 |
| T-C12 | `test_m03_c.ml` | M03-C1, M03-C2 |
| **T-C3** | `test_m03_c.ml` | **M03-C3 — one 1518-octet frame, both lanes** |
| T-C4 | `test_m03_c.ml` | M03-C4 |
| T-C5 | `test_m03_c.ml` | M03-C5 |
| T-D1 / T-D2 / T-D3 | `test_m03_d.ml` | M03-D1 / D2 / D3 |
| T-E1 / T-E2 / T-E4 / T-E5 | `test_m03_e.ml` | M03-E1 / E2 / E4 / E5 |
| T-F1 / T-F2 / T-F3 / T-F4 | `test_m03_f.ml` | M03-F1 / F2 / F3 / F4 |
| **T-G1** | `test_m03_g.ml` | **M03-G1** — 1600-octet frame + a valid 64-octet frame |
| **T-G2** | `test_m03_g.ml` | **M03-G2** — the adjacent pair 1518 and 1519 |
| **T-G3** | `test_m03_g.ml` | **M03-G3** — `/S/` past the truncation point |
| **T-G4** | `test_m03_g.ml` | **M03-G4** — `/E/` past the truncation point |
| **T-G6** | `test_m03_g.ml` | **M03-G6** — no terminate before the next `/S/` |
| T-ST | `test_m03_structural.ml` | M03-L6 |

## 2. The matrix

`R` = REQUIRED red. `G` = MUST STAY GREEN. Anything off-pattern is a **finding**.

| unit | G-c1 | G-c2 | G-c3 | G-c4 | G-c5 |
|---|---|---|---|---|---|
| T-A12, T-A34, T-A5 | G | G | G | G | G |
| T-B1 | G | G | G | G | G |
| T-C12 | G | G | G | G | G |
| **T-C3** | G | **R** | G | G | G |
| T-C4, T-C5 | G | G | G | G | G |
| T-D1, T-D2, T-D3 | G | G | G | G | G |
| T-E1, T-E2, T-E4, T-E5 | G | G | G | G | G |
| T-F1, T-F2, T-F3, T-F4 | G | G | G | G | G |
| **T-G1** | **R** | G | **R** | *see §4(d)* | **R** |
| **T-G2** | **R** | **R** | **R** | *see §4(d)* | **R** |
| **T-G3** | **R** | G | **R** | *see §4(d)* | **R** |
| **T-G4** | **R** | G | **R** | *see §4(d)* | **R** |
| **T-G6** | **R** | G | **R** | *see §4(d)* | **R** |
| T-ST | G | G | G | G | G |
| red count | **5** | **2** | **5** | §4(d) | **5** |

## 3. Expected messages

Every message below is the **first** assertion to speak, given each row's
committed assertion order and iteration order (lane 0 before lane 4 everywhere;
M03-G2 runs its **1518 legal** member before its **1519 oversize** member within
each lane).

### G-c1 — five units, and `tkeep` speaks at every one

| unit | message |
|---|---|
| T-G1 | `M03-G1 (lane 0): frame 1: tkeep does not match the 1514-octet truncation constant (0x03)` |
| T-G2 | `M03-G2 (lane 0, 1519 oversize): tlast tkeep does not match the 1514-octet truncation constant` |
| T-G3 | `M03-G3 (lane 0): frame 1: tkeep does not match the 1514-octet truncation constant` |
| T-G4 | `M03-G4 (lane 0): frame 1: tkeep does not match the 1514-octet truncation constant` |
| T-G6 | `M03-G6 (lane 0): frame 1: tkeep does not match the 1514-octet truncation constant` |

**Why `tkeep` and not the word count — worked, not assumed, and it is the same
computation that decides §4(a).** Truncating at 1518 instead of 1514 changes the
delivered extent by four octets, and every one of these rows checks the
**output-word count first**. But `(1514 + 7) / 8 = 190` and `(1518 + 7) / 8 =
190` — **the count is unchanged**. So is the `tlast` cycle: the final delivered
octet moves from index 1513 (octet time 1529, input word 191, lane 1) to index
1517 (octet time 1533, **the same input word 191**, lane 5), and §7's per-octet
constant gives `191 + ⌊(1+16)/8⌋ = 193` and `191 + ⌊(5+16)/8⌋ = 193` — **the same
cycle**. The third assertion, `tkeep` (0x3F observed against 0x03 expected), is
the first to differ, at all five.

### G-c2 — two units

| unit | message |
|---|---|
| **T-C3** | `M03-C3 (lane 0): tuser[0] set unexpectedly` |
| T-G2 | `M03-G2 (lane 0, 1518 legal maximum): tuser[0] set on a legal, maximum-length frame` |

**Why `tuser` and not the extent**: a 1518-octet frame delivers **1514** octets
under REQ-103's removal *and* 1514 under REQ-108's truncation — the two numbers
coincide, which is M03-G2's whole reason for existing. So the word count, the
`tlast` cycle, the `tkeep` and the delivered content are **all unchanged** by
G-c2, and the abort bit is the first thing that moves. In `run_c3` the `tuser`
check precedes the strobe-emptiness check; in `run_g2_legal` likewise.

### G-c3 and G-c5 — the same five units, separated ONLY by which count is printed

| | message |
|---|---|
| **G-c3** | the exact-strobe-set arity arm with **`observed 2`** |
| **G-c5** | the same arm with **`observed 0`** |

Per unit, the arm's own text:

- T-G1 — `M03-G1 (lane 0): expected exactly one strobe (error_oversize alone -- proving no error_bad_fcs, §9 ruling 2, and the following frame intact), observed N`
- T-G2 — `M03-G2 (lane 0, 1519 oversize): expected exactly one strobe (error_oversize alone -- no error_bad_fcs, §9 ruling 2), observed N`
- T-G3 — `M03-G3 (lane 0): expected exactly one strobe (error_oversize alone -- NO error_start_without_terminate, §9's sixth ruling, C-12, this row's own point), observed N`
- T-G4 — `M03-G4 (lane 0): expected exactly one strobe (error_oversize alone -- NO error_bad_frame, §9's seventh ruling, C-12, this row's own point), observed N`
- T-G6 — `M03-G6 (lane 0): expected exactly one strobe (error_oversize alone), observed N`

with **N = 2** under G-c3 and **N = 0** under G-c5.

**This is the fourth campaign with row sets that do not discriminate and messages
that do** — D-M1/D-M4/D-M5, E-c3/E-c5, F-c3/F-c5/F-c6, and now G-c1/G-c3/G-c5, a
**three-way** split over an identical five-unit row set. G-c1 is separated from
the other two by speaking at `tkeep` rather than at the strobe set at all.

### G-c4 — a FUNCTION of the seeder's disclosed choice

**This class's row set is not a set; it is a mapping, and the mapping is the
prediction.** `WO-0055` §2 deliberately leaves the character to the seeder and
requires it disclosed. Frozen here, before any diff exists:

| disclosed character class | REQUIRED | MUST STAY GREEN |
|---|---|---|
| **`/S/`** after the truncation point | **T-G3, T-G6** | 23 |
| **`/E/`** after the truncation point | **T-G4** | 24 |
| **`/T/`** after the truncation point | **T-G1, T-G2** | 23 |
| **any control character** (generic) | **all five G units** | 20 |

**Message in every case**: the same exact-strobe-set arity arm quoted above for
the unit concerned, with **`observed 2`** — the spurious report arriving
alongside the frame's own `error_oversize`.

**The derivation, so the mapping can be checked rather than trusted.** A
character is only "after the truncation point **and still in `Discard`**" if the
receiver has not already left that state. §6.2's `Discard` row exits on the
frame's own terminate character. Therefore:

- **T-G3** injects an `/S/` at content index 1620 while no `/T/` has yet
  arrived — in `Discard`. **T-G6** suppresses the frame's terminate entirely, so
  the *next frame's* `/S/` also arrives in `Discard`.
- **T-G4** injects an `/E/` 100 octets past truncation, in `Discard`.
- **T-G1** and **T-G2**'s oversize frames carry their **own natural `/T/`** past
  the truncation point — 1600 and 1519 octets respectively, both beyond 1514 — so
  a `/T/`-gated mutation reaches exactly those two.
- **T-G1's, T-G3's, T-G4's and T-G6's following frames** open with an `/S/`
  arriving **after** their predecessor's `/T/` has already exited `Discard` —
  except in T-G6, where there is no `/T/`. That asymmetry is why T-G6 appears in
  the `/S/` row and T-G1 does not.

## 4. Reasoning for the cells that are not obvious

**(a) The `Protocol_monitor` cannot see G-c1, and this discharges `WO-0054`
§9.2's rider by computation rather than by caution.** I flagged that
`~max_words_per_frame:190` and REQ-108's 1514 coincide **by construction** and
warned that the monitor must not be credited as an independent detector until
that was checked. **Checked: `(1518 + 7) / 8 = 190 = (1514 + 7) / 8`.** G-c1's
wrong constant produces **exactly the same word count** as the right one, so the
monitor's bound is never exceeded and it stays silent. **The monitor contributes
zero coverage against G-c1**, and the entire detection rests on the `tkeep`
assertion. Had the rider not been checked, this campaign would have credited a
detector that cannot fire.

**(b) T-C3 reddening under G-c2 is expected and is not a flaw in the campaign's
design.** A pre-existing unit catching a family-G class looks odd until the
arithmetic is read: M03-C3 drives **exactly 1518** octets, the one length G-c2
moves across the threshold. **So G-c2 is not a silently-always-pass class and was
never claimed to be** — the same shape as F-c1's kill of T-C4. The two classes
that *are* silently-always-pass here are G-c5 and, for a different reason, G-c1.

**(c) G-c5's blindness, counted: twenty of twenty-five units cannot see it — and
before `test_m03_g.ml` existed, TWENTY-FIVE of twenty-five could not.** Nothing
anywhere in the bench drove a frame above 1518 octets before family G. That is
REQ-108's silently-always-pass closure, and it is the widest such gap any family
in this programme has closed: D-M1 was ten of twelve, E-c5 thirteen of fifteen,
F-c5 nineteen of twenty.

**(d) G-c4's mapping is the F-c8 repair in practice, and I want the method on the
record.** At WO-0050 I pinned F-c8's displacement direction to buy an exact
sealed message; the over-specification made half the class unseedable and cost
the campaign its only cross-family claim. The fix is not to specify less and
predict vaguely — it is to **leave the choice to the seeder and seal the
prediction as a function of the disclosed choice.** The freeze is no weaker: the
seeder cannot see the mapping, and every branch of it is exact. If the observed
row set matches none of §3's four rows, that is a **finding** — either the
character class was something I did not enumerate, in which case my enumeration
was incomplete, or the diff reaches further than the class it names.

**(e) The `truncated_tkeep` residual cannot be reached by this campaign, and the
reasoning is worth stating so it is not re-litigated.** `RV-0054-VERDICT` §4
recorded that `test_m03_g.ml`'s `truncated_tkeep` lacks the zero-remainder guard
its sibling carries — correct at 1514 (`rem` = 2) *because of its input's value*
rather than by construction. **That constant lives on the bench side of the
boundary and no RTL mutation can move it.** Under every class here the bench's
*expected* `tkeep` is computed from 1514 and is right; what moves is the
*observed* value. So the fragility is real, is orthogonal to this campaign, and
must not be offered as an explanation for any deviation. **If a `tkeep` message
in this campaign carries an expected value other than `0x03`, that is a finding
about something other than the seeded defect.**

**(f) The embedded model-vs-hand cross-checks are not present in this family, and
that is a difference from E and F worth noting.** `test_m03_g.ml` builds through
`Arrival` and `Bench.run`'s `?word_at` rather than through `Injection`, so there
is no `cross_check_*` / `fail_cross` tripwire in it. **The `fail_cross`
finding-condition of the last three campaigns therefore has no instance here** —
its absence is structural, not an omission, and a `fail_cross` message could only
arrive from `test_m03_e.ml` or `test_m03_f.ml`, where it would mean a
MUST-STAY-GREEN violation with a very specific cause.

**(g) T-G2 is the only unit that reddens under three different classes** (G-c1,
G-c2, G-c3/G-c5) and it does so through **three different members and three
different assertions** — its 1519 member's `tkeep`, its 1518 member's `tuser`,
and its 1519 member's strobe set. That is the row's adjacency construction paying
off: one unit, two frames, and the two frames fail for opposite reasons.

## 5. Bounds this campaign does NOT close, named before the result

1. **The resynchronisation interval is exercised at one offset per row** — index
   1620 for G3's `/S/`, 100 octets past truncation for G4's `/E/` — not swept.
2. **G-c4 is seeded once**, at whatever character class the seeder discloses. The
   other three branches of §3's mapping remain unexercised, and the campaign must
   not be read as having tested them.
3. **No G row drives a frame between 1519 and 1600 octets**, nor above 1700.
   REQ-108's behaviour is exercised at the boundary and at one interior length.
4. **The epoch-A no-output-word class** owed from `J-dv_lead-0065` is **not** in
   this campaign; it rides with family H.

## 6. Weighting

All five carry the family-E/F blinding: intents published in `WO-0054` §7 to the
bench author, row mapping and MUST-STAY-GREEN columns and messages sealed
together. **No discount is available in adjudication and none is claimed.**

## 7. Pass criteria

1. The suite goes red on all five. **No exempt class this round.**
2. Red in the REQUIRED units **with the expected message**, and no
   MUST-STAY-GREEN unit reddens. Either half violated is a **finding**.
3. The unmutated control is green — `2e8994f`, CI run **30841171667**, both jobs
   green.

**G-c5 is the class this family was written for.** A family G that does not die
on G-c5 has closed nothing — twenty-five of twenty-five units were blind to it
before `test_m03_g.ml` existed.

## 8. Not to be told

§1's unit table, §2's matrix — above all its MUST-STAY-GREEN columns — §3's
messages including G-c1's `tkeep`-not-count derivation and **G-c4's mapping**,
§4's reasoning, §5's bounds and §6's weighting.

**Freely told, and told**: the five intents, the minimality and fidelity
requirements, the instruction that G-c4's character choice is the seeder's and
must be disclosed, the allowlist and process bars, the `cosim`-is-expected-red
note, the return format, and the plain warning that G-c5 will look quiet.
