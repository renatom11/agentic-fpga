# WO-0045 SEALED: dv_lead's frozen predictions for the family-E campaign

> **SEALED.** The auditor must not open this file until all five diffs are
> committed — and under `WO-0045` §1's allowlist, **all of `agents/**` is out of
> bounds for the campaign's duration**, this file included.

- **State**: FROZEN
- **Frozen against**: **`bc565a6`**. `git diff bc565a6 1e77706 -- test/ libs/`
  is **empty**, so run **1e77706**'s fully-green result is this base's control.
- **Frozen by**: dv_lead, `J-dv_lead-0051`, **before any diff existed**.
- **Second copy**: `J-dv_lead-0051`.

## 0. The denominator, measured

**Fifteen `%expect_test` units in the M03 bench**, from
`tools/dv_checks.sh`'s inventory block — the tool built after "fifteen" and
"eighteen" circulated through four packets with nobody having counted:

```
    3  test_m03_a.ml   1  test_m03_b.ml   4  test_m03_c.ml
    3  test_m03_d.ml   3  test_m03_e.ml   1  test_m03_structural.ml
  ---
   15  test/xgmii_rx_64/ (the M03 bench)      95  test/ (repository-wide)
```

**Blast radius unchanged**: no test outside `test/xgmii_rx_64/` instantiates
M03, so a *behavioural* mutation's reach is exactly these fifteen. A unit
outside them reddening is a **build-level** finding, never a behavioural one.

## 1. The fifteen units

| id | file | row(s) |
|---|---|---|
| T-A12 | `test_m03_a.ml` | A1, A2 |
| T-A34 | `test_m03_a.ml` | A3, A4 |
| T-A5 | `test_m03_a.ml` | A5 |
| T-B1 | `test_m03_b.ml` | B1 |
| T-C12 | `test_m03_c.ml` | C1, C2 |
| T-C3 | `test_m03_c.ml` | C3 |
| T-C4 | `test_m03_c.ml` | C4 |
| T-C5 | `test_m03_c.ml` | C5 |
| T-ST | `test_m03_structural.ml` | L6 |
| T-D1 | `test_m03_d.ml` | D1 |
| T-D2 | `test_m03_d.ml` | D2 |
| T-D3 | `test_m03_d.ml` | D3 |
| **T-E1** | `test_m03_e.ml` | `M03-E1: /E/ in each of the eight lanes of a mid-frame word, both start lanes -- sixteen cases` |
| **T-E2** | `test_m03_e.ml` | `M03-E2: /E/ at the frame's first octet position -- no output word, exactly one error_bad_frame two cycles after the /E/'s input word` |
| **T-E4** | `test_m03_e.ml` | `M03-E4: /E/ after a terminate character, in the inter-frame gap -- nothing emitted, no strobe, following frame intact` |

## 2. The matrix — every class against every unit

`R` = REQUIRED red. `G` = MUST STAY GREEN. Anything off-pattern is a **finding**.

| unit | E-c1 | E-c2 | E-c3 | E-c4 | E-c5 |
|---|---|---|---|---|---|
| T-A12 | G | G | G | G | G |
| T-A34 | G | G | G | G | G |
| T-A5 | G | G | G | G | G |
| T-B1 | G | G | G | G | G |
| T-C12 | G | G | G | G | G |
| T-C3 | G | G | G | G | G |
| T-C4 | G | G | G | G | G |
| T-C5 | G | G | G | G | G |
| T-ST | G | G | G | G | G |
| T-D1 | G | G | G | G | G |
| T-D2 | G | G | G | G | G |
| T-D3 | G | G | G | G | G |
| **T-E1** | **R** | G | **R** | G | **R** |
| **T-E2** | G | **R** | **R** | G | **R** |
| **T-E4** | G | G | G | **R** | G |
| red count | 1 | 1 | 2 | 1 | 2 |

**The twelve pre-family-E units are MUST-STAY-GREEN under all five classes,
without exception.** None of them drives an `/E/`; none exercises the abort
path at all. That is the whole reason family E was written, and this column of
the matrix is the claim it makes.

## 3. Expected messages

**E-c3 and E-c5 share the row set {T-E1, T-E2} and are separated ONLY by which
assertion speaks** — the same structure D-M1/D-M4/D-M5 had, where the sealed
messages did all the discriminating work.

| | T-E1 speaks | T-E2 speaks |
|---|---|---|
| **E-c1** | the delivered-octet comparison — four octets short at every one of the sixteen cases | — (green) |
| **E-c2** | — (green) | `a tlast word was observed for a frame that must deliver nothing (section0.7, E-c2)` |
| **E-c3** | `error_bad_frame pulsed on cycle X, expected Y` | `error_bad_frame pulsed on cycle X, expected Y` |
| **E-c4** | — (green) | — (green) |
| **E-c5** | `expected exactly one strobe pulse (error_bad_frame only), observed 0` | `expected exactly one strobe pulse (error_bad_frame only), observed 0` |

**E-c4** speaks in T-E4 only:
`an error strobe pulsed for an /E/ that arrived with no frame open (REQ-105's closure clause, C-12, E-c4)`.

**E-c2's two admissible messages.** The intent's natural implementation is a
`tkeep` = 0 or preamble-octet word emitted **carrying `tlast`**, since the stated
motive is "somewhere to put the abort bit" — and `run_e2` matches
`tlast_sample` first, so that is the message above. **If the mutant emits a
`tvalid` word without `tlast`**, `tlast_sample` returns `None` and the next
assertion speaks instead: `a tvalid word was observed for a frame that must
deliver nothing`. **Both are admissible; neither is a finding.** Any *third*
shape is.

## 4. Reasoning for the cells that are not obvious

**E-c1 kills T-E1 alone.** T-E2's frame delivers zero octets, and removing four
from zero still yields no output word — so E2 cannot see it. No pre-E unit takes
the abort path at all: M03-C4's runt is REQ-107's disposition, where the FCS
*is* legitimately removed, so C4 stays green. **A single-unit kill, and the unit
is the one the row was written for.**

**E-c4 kills T-E4 alone, and T-E1/T-E2 must stay green under it.** Their `/E/`s
arrive while a frame is open, so a gating defect changes nothing for them. E4 is
the only row in the suite that drives an `/E/` with no frame open.

**E-c5 leaves T-E4 GREEN, and that is the cell to read carefully.** E4 asserts
that **no** strobe pulses; a mutation that suppresses strobes entirely satisfies
that assertion. So E-c5 is invisible to E4 — and, before family E existed, it
would have been invisible to the **entire suite**. Thirteen of fifteen units
cannot see it. **That is REQ-105's silently-always-pass closure, and it is this
campaign's central claim.**

**The embedded model-vs-hand cross-checks must stay silent under all five.**
`cross_check_e1`/`cross_check_e2` compare hand-derived values against
`Injection`'s model — **both of which live in `test/`** and neither of which an
RTL mutation can touch. **A `fail_cross` message anywhere in this campaign is a
FINDING**, and would mean something other than the seeded defect moved.

## 5. Weighting — stronger than family D's, and here is why

Family D's campaign was weakened by `WO-0040` §9 publishing the mutation → row
table. **This campaign published only the defect classes**, so for all five the
row mapping, the MUST-STAY-GREEN columns and the messages are sealed together.
**Every one of these five carries the blinding that only D-M5 carried last
time.**

The corollary: there is no discount to apply in adjudication, and equally no
excuse available. A class that fails to land is a bench finding, full stop.

## 6. Pass criteria

1. The suite goes red.
2. Red in the REQUIRED units **with the expected message**, and no
   MUST-STAY-GREEN unit reddens. Either half violated is a **finding**,
   adjudicated, never silently scored as a pass.
3. The unmutated control is green — established at `1e77706` for this exact
   compiled surface.

**E-c5 is the class this family was written for.** A family E that does not die
on E-c5 has closed nothing, exactly as a family D that survived D-M1 would have.

## 7. Not to be told

§1's unit table, §2's matrix — above all its MUST-STAY-GREEN columns — §3's
messages including E-c2's two admissible shapes, §4's reasoning, §5's weighting,
and the cross-check finding condition.

**Freely told, and told**: the five intents, the minimality and fidelity
requirements, the allowlist and process bars, the return format, and the plain
warning that E-c5 will look quiet.
