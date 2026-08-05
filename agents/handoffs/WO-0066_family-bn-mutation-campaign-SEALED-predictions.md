# WO-0066 SEALED: dv_lead's frozen predictions for the family-B/N mutation campaign

> **SEALED.** The auditor must not open this file until every diff is delivered
> and the scorecard is in hand — and under `WO-0066` §7's allowlist, **all of
> `agents/**` is out of bounds for the campaign's duration**, this file included
> and absolutely.

- **State**: **FROZEN — unopened.**
- **Frozen against**: **the commit this file's own commit immediately follows** —
  the commit carrying the `tools/dv_checks.sh` boundary-matched row census
  (`J-dv_lead-0114`), which is the parent of the commit staging this seal and its
  packet. I cannot state its hash: I never run git (PROTOCOL §2), and it has none
  until the orchestrator creates it. **The orchestrator verifies that identity at
  commit time**; the auditor quotes the hash it applied to (`WO-0066` §7 item 6),
  and any disagreement is a finding **before** the campaign runs.
- **Frozen by**: dv_lead, `J-dv_lead-0115`, **before any diff existed**, in the
  commit that stages this file beside its packet — R-SEAL-1 (PROTOCOL §10,
  ADR-0016), redeeming `RV-0065B-VERDICT` §7.1's forward commitment, which by its
  own terms falls due **here or the round has no seal**.
- **Second copy**: the class → `R!`-unit **row mapping** (not the message
  strings) is restated in `J-dv_lead-0115`.
- **Standing rule of this file, from `RV-0055` FINDING G-1**: **every sealed cell
  that rests on a claim about the DUT's state cites the stimulus fact that
  establishes that state, or is marked UNWORKED.**
- **Second standing rule, this file's own**: every message below is the **first
  assertion to speak**, derived from the row's committed control flow and source
  order at the base SHA — never from what the row is "about". §2 states the orders
  every cell depends on.
- **Third standing rule**: a quantity the specification does not fix is sealed as
  an **inequality with a named direction**, never as a value.
- **Fourth standing rule, new this round and the reason §6 exists**: a cell that
  rests on **two events being distinguishable** must state the convention by which
  they are distinguished. Where the convention cannot distinguish them, the cell
  is **GREEN BY BLINDNESS**, sealed as such, and a green there is **not** evidence
  the class does not reach it.

---

## 0. The denominator, re-measured at the freeze

`bash tools/dv_checks.sh` at this tree — the inventory block's own output:

```
    3  test_m03_a.ml    7  test_m03_b.ml    4  test_m03_c.ml    3  test_m03_d.ml
    4  test_m03_e.ml    4  test_m03_f.ml    7  test_m03_g.ml    4  test_m03_h.ml
    5  test_m03_i.ml    6  test_m03_n.ml    1  test_m03_structural.ml
  ---
   48  test/xgmii_rx_64/ (the M03 bench)
  128  test/ (repository-wide)
```

**48 M03 units; 128 repository-wide; 80 non-M03.** The non-M03 80 is the same 80
five prior campaigns measured; the repo-wide figure moved from `WO-0063B`'s 119 by
exactly the nine units family B's completion and family N's first file added.

**The non-M03 80 is not uniform, and `WO-0063B`'s seal §0 said it was.**
Corrected here by measurement:

| set | units | a red there means |
|---|---|---|
| `test/monitors/`, `test/xgmii/`, `test/golden/`, `test/axi64_probe/`, `test/xgmii_probe/` | **79** | the manifest reached outside its own file — a **scope finding** |
| `test/hardcaml_ethernet/` (1 unit, declares `hardcaml_ethernet`, names no M03 module) | **1** | the mutant **does not compile** — a **build finding**, never behavioural |

Both are MUST-STAY-GREEN under every class; they are **different findings** and
the old sentence would have scored the second as the first.

---

## 1. The row prefixes, which are how the scorecard is read

Every message below is `<row prefix>: <body>`, composed by each file's own
`fail row msg`. The prefixes at the base SHA:

| unit | prefix, character-exact |
|---|---|
| M03-N2 sub-case 1 | `M03-N2 (S lane 0, A lane 0, delivered)` |
| M03-N2 sub-case 2 | `M03-N2 (S lane 0, A lane 4, delivered)` |
| M03-N2 sub-case 3 | `M03-N2 (S lane 0, A lane 0, zero-delivered)` |
| M03-N2 sub-case 4 | `M03-N2 (S lane 4, A lane 0, delivered)` |
| M03-N2 sub-case 5 | `M03-N2 (S lane 4, A lane 4, delivered)` |
| M03-N2 sub-case 6 | `M03-N2 (S lane 4, A lane 4, zero-delivered)` |
| M03-B2 `/E/` (landed) | `M03-B2 (lane 0)` / `M03-B2 (lane 4)` |
| M03-B2 `/I/` | `M03-B2 (/I/, lane 0)` / `M03-B2 (/I/, lane 4)` |
| M03-B2 `/Q/` | `M03-B2 (/Q/, lane 0)` / `M03-B2 (/Q/, lane 4)` |
| M03-B4 member (a) | `M03-B4` |
| M03-B4 member (b) | `M03-B4 (b)` |
| M03-H4 | `M03-H4` |

**The `/E/` unit is distinguishable from the `/I/` and `/Q/` units by prefix
alone**, which is what makes IC-D's and IC-F's control cells scoreable from a
scorecard rather than from a re-read of the file.

---

## 2. The orders every REQUIRED cell depends on

### 2.1 M03-N2 — six units, no shadowing between them

Each of the six sub-cases is its **own** `%expect_test` unit calling
`run_subcase` **exactly once**. **No sub-case shadows any other**, and all six are
independently observable in the same run. This is the structural difference from
`WO-0063B`, whose six simulations shared one unit, and it is why no N cell needs
that round's shadowing carve-out.

**The order inside `run_subcase`, at the base SHA**, because every REQUIRED cell
is an ordering claim:

1. construction + `Injection.is_clean` guard
2. start-lane guard → **W** guard → lane guard → preamble-position guard →
   A-cycle guard → B-cycle guard → `coincides` guard
3. `Injection.outcomes` cross-check (`fail_cross …`)
4. landing site 1 (the schedule's own word W)
5. `Strobe_monitor.expect` ×2, then `run … ~drain:8`
6. landing site 2 (the word `run` actually drove)
7. `words_out = delivered_samples samples`
8. **`if sc.a_delivered = 0`** → **(a)** the no-output-word check → **(b)** the
   two-pulse / same-cycle / different-names check
   **else** → **(a)** the `words_out` match (count, then cycle, `tkeep`, `tlast`,
   `tuser`) → **(b)** the two-pulse cycle-and-name check
9. conservation accounting
10. **`assert_monitors_clean`, last**

**Steps 1–4 are evaluated on the bench's own model of the stimulus, before or
independently of the DUT.** No RTL mutation can move them. **A `test bug --`
message or a `fail_cross` message appearing in this campaign means something other
than a seeded class and is a finding of its own kind.**

**Step 10 is shadowed at every REQUIRED cell below**: step 8 raises first in every
predicted red. A red arriving through `assert_monitors_clean` — a message of the
form `<prefix>: strobe monitor unclean:` followed by the monitor's report — means
step 8 did **not** speak, and §7 disposition 4 governs.

### 2.2 M03-B2's `/I/` and `/Q/` units — lane 0 shadows lane 4

Each unit is `List.iter [ 0; 4 ] ~f:(fun lane -> run_b2_new ~lane …)`. **Lane 0
runs first**, so within a unit the lane-4 cell is **not independently observable**.
§5.3 pre-fixes the adjudication.

**The order inside `run_b2_new`**: construction and content guards →
`Injection.is_clean` → start/lane/close-cycle/pin guards → `Injection.outcomes`
cross-check → landing site 1 → `Strobe_monitor.expect` → `run` → landing site 2 →
**(i)** `List.hd words_out`'s *before-frame-2* check → **(ii)** the
second-`tlast`-group check → **(iii)** `assert_following_frame_intact` on frame 2
→ **(iv)** the exactly-one-pulse check → conservation →
**`assert_monitors_clean`, last**.

### 2.3 The eight derived numbers at M03-N2, verified green at `eb1e06a` (CI run `30963617198`)

`start_ot` = 8 at a lane-0 start, 12 at a lane-4 start; octet time `t` lies at
lane `t mod 8` of word `t / 8`.

| sub-case | A start ot | `/S/` ot (word, lane) | `/T/` ot (word, lane) | A delivered | A's cycle | B's cycle | A's §0.6 window | B's §0.6 window |
|---|---|---|---|---|---|---|---|---|
| 1 | 8 | 24 (W=3, lane 0) | 26 (W, lane 2) | 8 | 4 | 5 | [3, 5] | [3, 6] |
| 2 | 12 | 24 (W=3, lane 0) | 26 (W, lane 2) | 4 | 4 | 5 | [3, 5] | [3, 6] |
| 3 | 8 | 16 (W=2, lane 0) | 18 (W, lane 2) | 0 | 4 | **4** | [2, 5] | [2, 5] |
| 4 | 8 | 20 (W=2, lane 4) | 22 (W, lane 6) | 4 | 4 | **4** | [2, 5] | [2, 5] |
| 5 | 12 | 28 (W=3, lane 4) | 30 (W, lane 6) | 8 | 4 | 5 | [3, 6] | [3, 6] |
| 6 | 12 | 20 (W=2, lane 4) | 22 (W, lane 6) | 0 | 4 | **4** | [2, 5] | [2, 5] |

**Sub-cases 3, 4 and 6 coincide** (`a_cycle` = `b_cycle` = 4); 1, 2 and 5 do not.
**That coincidence is IC-C's whole instrument and IC-B(W)'s and IC-E's whole
blindfold** — §6.

---

## 3. The matrix

`R!` = REQUIRED red **and scored**. `G` = MUST STAY GREEN. `G✱` = **green by
blindness** (§6) — required green, and **not** evidence the class fails to reach
it. `r` = predicted red, **UNWORKED**, contributing **zero** kills (§5.4's rule
governs). `U` = UNWORKED cell with adjudication pre-fixed. Anything off-pattern is
a **finding**.

### 3.1 IC-A — branching on **D-A1**, at **D-A2 = E**

| unit | D-A1 = **L** | D-A1 = **O** | D-A1 = **F** |
|---|---|---|---|
| **M03-N2 sub-case 4** (`Frame` on entry) | **R!** | **R!** | **R!** |
| **M03-N2 sub-case 5** (`Frame` on entry) | **R!** | **R!** | **R!** |
| **M03-N2 sub-case 6** (`Preamble` on entry) | **R!** | **R!** | **G** |
| M03-B4 member (a) | **r** | G | G |
| M03-H4 | **r** | G | G |
| M03-N2 sub-cases 1, 2, 3; M03-B4 (b); all other M03 | G | G | G |
| **REQUIRED-red (M03)** | **5** | **3** | **2** |
| **MUST-STAY-GREEN (M03)** | **43** | **45** | **46** |
| **bound 7 scored** | **3 of 3** | **3 of 3** | **2 of 3, SHORT** |

**At D-A2 = P every cell above becomes `U`** — §5.1's rule governs, and the
predicted-red *set* is unchanged.

### 3.2 IC-B — branching on **D-B1** (which half) and **D-B2** (scope)

| unit | B(W) narrow | B(W) wide | B(R) narrow | B(R) wide |
|---|---|---|---|---|
| M03-N2 sub-cases 1, 2, 5 | **R!** | **R!** | **R!** | **R!** |
| M03-N2 sub-cases 3, 6 | **R!** | **R!** | **R!** | **R!** |
| **M03-N2 sub-case 4** | **U** (§6.2) | **U** | **R!** | **R!** |
| M03-B3, M03-F2, M03-G7, M03-I2 | r | r | r | r |
| M03-B2 `/E/`, `/I/`, `/Q/`; M03-B4 (a), (b); M03-E2, M03-E5, M03-H4 | G | r | G | r |
| every other M03 unit | G | G | G | G |
| **REQUIRED-red (M03)** | **5** (+1 `U`) | **5** (+1 `U`) | **6** | **6** |
| **MUST-STAY-GREEN (M03)** | **38** | **30** | **38** | **30** |

### 3.3 IC-C, IC-D, IC-E, IC-F

| unit | IC-C | IC-D narrow | IC-D wide | IC-E (`<5`) | IC-E (`0<d<5`) | IC-F |
|---|---|---|---|---|---|---|
| M03-N2 sub-case 1 | **G** | G | G | **G** | **G** | G |
| **M03-N2 sub-case 2** | **G** | G | G | **R!** | **R!** | G |
| M03-N2 sub-case 3 | **R!** | G | G | **G✱** | **G** | G |
| M03-N2 sub-case 4 | **R!** | G | G | **G✱** | **G✱** | G |
| M03-N2 sub-case 5 | **G** | G | G | **G** | **G** | G |
| M03-N2 sub-case 6 | **R!** | G | G | **G✱** | **G** | G |
| M03-B2 `/E/` | G | **G** | **G** | G | G | **G** |
| **M03-B2 `/I/`** | G | **R!** | **R!** | G | G | **G** |
| **M03-B2 `/Q/`** | G | **G** | **R!** | G | G | **R!** |
| M03-B4 (a), M03-B4 (b), M03-H4 | G | G | G | **r** | G | G |
| every other M03 unit | G | G | G | G | G | G |
| **REQUIRED-red (M03)** | **3** | **1** | **2** | **1** | **1** | **1** |
| **MUST-STAY-GREEN (M03)** | **45** | **47** | **46** | **44** | **47** | **47** |

**MUST-STAY-GREEN outside M03, every class, every branch**: **79** behavioural +
**1** build-level (§0).

**Kills are counted per class**: IC-B(W) wide's eighteen predicted reds are
**one** possible kill, never eighteen.

---

## 4. The REQUIRED cells, verbatim

The message bodies below are the OCaml literals at the base SHA with their
line-continuation whitespace folded, as the runtime composes them. Quoted in
blocks because the exactness is character-level and the text carries its own
punctuation. `<n>` marks a **mutant-owned** integer, sealed at §8 as an
inequality; every other character is exact and specification-fixed.

### 4.1 IC-A — the scored cells (D-A2 = E)

```
M03-N2 (S lane 4, A lane 0, delivered): expected exactly one delivered word for frame A, got <n>
M03-N2 (S lane 4, A lane 4, delivered): expected exactly one delivered word for frame A, got <n>
M03-N2 (S lane 4, A lane 4, zero-delivered): expected exactly two strobe pulses over the WHOLE run, observed <n>
```

**Derivation, per cell.** Under IC-A the lane-4 `/S/` is not decoded as a start, so
**frame B is never opened** at sub-cases 4, 5 and 6 — that single consequence
carries all three cells and it is the class's own definition, not a rendering
guess.

- **Sub-case 4** (`s_ot` 20, A's `start_cycle` 1, first output word owed at
  `start_cycle + 3` = **4**): under **E** the character routes to REQ-105 at
  **cycle 2**, two cycles *before* A's only word could leave, so A emits none.
  `words_out` is empty, `List.length words <> 1`, and step 8(a)'s count arm
  speaks. Derived `<n>` = **0**.
- **Sub-case 5** (`s_ot` 28 → **cycle 3**; A's `start_cycle` 1, first word owed at
  **4**): identical structure, one cycle of margin instead of two. Derived
  `<n>` = **0**.
- **Sub-case 6** (A delivers nothing under *both* readings, so step 8 takes the
  **zero-delivered** branch): `words_out` is empty and step 8(a) **passes** — the
  no-output-word check cannot see this class. Step 8(b) sees one pulse where two
  are required (A's REQ-105 report; B's `error_runt` does not exist because B does
  not exist) and the count arm speaks. Derived `<n>` = **1**.

**The bound-7 cell is sub-case 6, and it is the one that decides 2-of-3 from
3-of-3.** Sub-cases 4 and 5 enter W in `Frame` state; sub-case 6 enters in
`Preamble` state, because at a lane-4 start A's SFD lands at lane 3 of W itself
(`start_ot` 12, preamble positions 1…7 at octet times 13…19, W = word 2). **A
rendering that reaches only 4 and 5 scores 2 of 3 and the verdict says SHORT**
(`WO-0066` §4 rule 2). It may not be rounded up.

### 4.2 IC-B — both halves

**B(W) — the close emits an output word.**

```
M03-N2 (S lane 0, A lane 0, delivered): expected exactly one delivered word for frame A, got <n>
M03-N2 (S lane 0, A lane 4, delivered): expected exactly one delivered word for frame A, got <n>
M03-N2 (S lane 4, A lane 4, delivered): expected exactly one delivered word for frame A, got <n>
M03-N2 (S lane 0, A lane 0, zero-delivered): expected NO output word at all (both frames zero-delivered, §0.7), got some
M03-N2 (S lane 4, A lane 4, zero-delivered): expected NO output word at all (both frames zero-delivered, §0.7), got some
```

At sub-cases 1, 2 and 5 frame B's spurious word lands at `b_cycle` = **5**, one
cycle after A's own `tlast` at **4**, so both are in `delivered_samples` and the
count arm speaks with derived `<n>` = **2**. At sub-cases 3 and 6 frame A emits
nothing, so B's word is the run's only one and the zero-delivered branch's
**first** check speaks — a different message from a different branch, which is
why the two are sealed separately rather than as one row.

**B(R) — the close's report is suppressed.** All six carry the **identical body**,
differing only in prefix:

```
M03-N2 (S lane 0, A lane 0, delivered): expected exactly two strobe pulses over the WHOLE run, observed <n>
M03-N2 (S lane 0, A lane 4, delivered): expected exactly two strobe pulses over the WHOLE run, observed <n>
M03-N2 (S lane 0, A lane 0, zero-delivered): expected exactly two strobe pulses over the WHOLE run, observed <n>
M03-N2 (S lane 4, A lane 0, delivered): expected exactly two strobe pulses over the WHOLE run, observed <n>
M03-N2 (S lane 4, A lane 4, delivered): expected exactly two strobe pulses over the WHOLE run, observed <n>
M03-N2 (S lane 4, A lane 4, zero-delivered): expected exactly two strobe pulses over the WHOLE run, observed <n>
```

Derived `<n>` = **1** at all six: frame A's `error_start_without_terminate`
survives, frame B's `error_runt` does not. **The datapath is untouched**, so at the
four delivering sub-cases every check in step 8's `words_out` match passes and the
pulse arm is reached — which is exactly what `WO-0066` §6's discriminator relies
on.

### 4.3 IC-C — the coincidence serialised

```
M03-N2 (S lane 0, A lane 0, zero-delivered): expected exactly error_start_without_terminate and error_runt, both on the same cycle, under DIFFERENT names (T10) -- no error_bad_fcs (T9)
M03-N2 (S lane 4, A lane 4, zero-delivered): expected exactly error_start_without_terminate and error_runt, both on the same cycle, under DIFFERENT names (T10) -- no error_bad_fcs (T9)
M03-N2 (S lane 4, A lane 0, delivered): expected error_start_without_terminate at A's own cycle and error_runt at B's, and nothing else (T8/T9)
```

**Two different messages for one class, and the split is the branch, not the
defect**: sub-cases 3 and 6 take step 8's **zero-delivered** branch, whose check
demands both pulses on `sc.a_cycle`; sub-case 4 takes the **delivered** branch,
whose check pins `(cycle, name)` for each pulse in either order. A seal that
quoted one string for all three would score a correct rendering as a finding at
two cells.

**The three REQUIRED greens are IC-C's whole point**, and they rest on stimulus
arithmetic, not on a category: at sub-cases **1, 2 and 5** `a_cycle` = 4 and
`b_cycle` = 5 (§2.3), so there is no coincidence to serialise. **A red at any of
those three means the rendering defers reports generally rather than coincident
ones, the reds at 3/4/6 are blast radius, and IC-C measures nothing** — §7
disposition 2.

### 4.4 IC-D and IC-F — branching on **D-DF1**

**D-DF1 = C (the preamble continues and the frame delivers):**

```
M03-B2 (/I/, lane 0): frame 1: an output word was observed for a frame that must deliver nothing (§0.7) -- the run's first delivered word arrives before frame 2's own first word could
M03-B2 (/Q/, lane 0): frame 1: an output word was observed for a frame that must deliver nothing (§0.7) -- the run's first delivered word arrives before frame 2's own first word could
```

**D-DF1 = S (the frame stops silently, with no report):**

```
M03-B2 (/I/, lane 0): expected exactly one strobe pulse (error_bad_frame alone) over the WHOLE run, observed <n> pulse(s)
M03-B2 (/Q/, lane 0): expected exactly one strobe pulse (error_bad_frame alone) over the WHOLE run, observed <n> pulse(s)
```

Derived `<n>` = **0** — REQ-008's silent-discard hole, which is the shape
`M03-B2`'s row text was written against.

**Under branch C the first three assertions of §2.2's order are the ones that can
speak**, and step (i) speaks: frame 1's own first delivered word arrives at
`start_cycle + 3` = **cycle 4**, and `frame2_first_cycle` is
`Arrival.start_cycle frame2 + 3`, far later — so the run's first `tvalid` word is
frame 1's and the comparison `s.cycle < frame2_first_cycle` holds. **Under branch S
nothing reaches the datapath at all**, steps (i)–(iii) pass on frame 2's own
intact stream, and step (iv) speaks.

**IC-D takes the `/I/` line** (both branches) and, at **D-D2 = wide**, the `/Q/`
line as well. **IC-F takes the `/Q/` line alone.** The strings are identical
between the two classes because the *bench* cannot tell them apart — which is
precisely why they are separate classes with separate diffs, and why a scorecard
that shows `/Q/` red and `/I/` green is **IC-F**, while both red is **IC-D wide**.
**That discrimination is carried entirely by which diff was applied**, and §7
disposition 6 fixes what happens if the manifests are combined.

### 4.5 IC-E — one cell, and the reason it is only one

```
M03-N2 (S lane 0, A lane 4, delivered): expected exactly two strobe pulses over the WHOLE run, observed <n>
```

Derived `<n>` = **3**: `error_start_without_terminate` at cycle 4,
`error_runt` (frame A's spurious one) at cycle 4, `error_runt` (frame B's genuine
one) at cycle 5 — three `(cycle, name)` pairs. **Frame A delivers four octets**
(the octet immediately before the aborting `/S/` is its last, REQ-110), which is
below any sub-five floor, and A's report cycle is **4** while B's is **5**, so the
two runts are separable.

**Sub-case 4 is the other member that asserts T8, and it CANNOT convict this
class.** See §6.1 — it is `G✱`, and the seal says so before the run.

---

## 5. The UNWORKED cells, with adjudication pre-fixed

### 5.1 IC-A at **D-A2 = P** — every cell

If the unrecognised `/S/` is consumed as a **data octet** rather than routed to
REQ-105, frame A continues to the injected `/T/` and closes with a different
octet count, a different `tkeep` and possibly a different `tlast` cycle. The
predicted-red **set** is unchanged; **which of step 8's messages speaks is not**,
and I decline to derive it because the answer depends on how the design strips
REQ-103's FCS from a frame whose length the mutation itself changed — a rendering
fact I would be inventing.

**Adjudication, fixed here**: at D-A2 = P, sub-cases 4, 5 and 6 are scored on the
**row prefix plus membership in this enumerated set**, and on nothing finer:

```
expected exactly one delivered word for frame A, got <n>
frame A's own tlast word did not arrive on its own pinned cycle
frame A's own tlast word tkeep does not match the delivered count
frame A's own single delivered word does not carry tlast
frame A's own tlast word does not carry tuser[0] = 1 (REQ-110)
expected exactly two strobe pulses over the WHOLE run, observed <n>
expected error_start_without_terminate at A's own cycle and error_runt at B's, and nothing else (T8/T9)
expected exactly error_start_without_terminate and error_runt, both on the same cycle, under DIFFERENT names (T10) -- no error_bad_fcs (T9)
expected NO output word at all (both frames zero-delivered, §0.7), got some
```

A message **inside** the set scores the cell; a message **outside** it is a
finding. **Bound 7 is still scored** under §3.1's `R!` set at P, because the set is
what the bound turns on and the message is not.

### 5.2 IC-B(W) at sub-case 4

**UNWORKED, and the reason is a datapath convention, not a shortfall of effort.**
At sub-case 4 `a_cycle` = `b_cycle` = **4** (§2.3), so frame A's `tlast` word and
frame B's spurious word are owed on **one cycle**, and the stream carries at most
one word per cycle. Whether the rendering emits B's word at a later cycle,
displaces A's, or drops one is the rendering's, and each produces a different
message — or none.

**Adjudication, fixed here**: at sub-case 4 under IC-B(W), a **red contributes
zero additional kills** and is not an unnamed-unit finding; **a green is NOT a
coverage finding either** — it is the one-word-per-cycle convention, and recording
it as a coverage gap would be recording a property of the observation as a
property of the bench. Either outcome is reported as a **rendering fact**. IC-B(W)
is scored on the other five.

### 5.3 M03-B2's lane-4 cells — shadowed within their own unit

`List.iter [ 0; 4 ]` runs **lane 0 first** (§2.2), so at IC-D and IC-F the lane-4
string is **not independently observable** in a passing-to-failing run.

**Adjudication, fixed here**: the unit's cell is scored on the **lane-0** string;
the lane-4 string is scored **only** if the scorecard reports it, which requires
lane 0 to have been green — itself a finding. The auditor's R-DISC-1 discharge is
still required **per lane** (`WO-0066` §5): a lane discharged term-by-term and
merely unobserved is recorded as **unobserved**, never as a miss and never as a
pass.

### 5.4 The `r` cells — eleven units across four classes

M03-B3, M03-F2, M03-G7, M03-I2 (IC-B narrow); plus M03-B2 `/E/`, `/I/`, `/Q/`,
M03-B4 (a), M03-B4 (b), M03-E2, M03-E5, M03-H4 (IC-B wide); plus M03-B4 (a) and
M03-H4 (IC-A at **L**); plus M03-B4 (a), M03-B4 (b), M03-H4 (IC-E at **`<5`**).

Each has its own assertion order and its own message idiom. **Eight worked
derivations bought with an afternoon would be eight chances to make FINDING G-1's
error again**, and none of them is a scored cell.

**Adjudication rule, fixed here**: at those units a **red is predicted blast
radius, contributes zero additional kills, and is not an unnamed-unit finding**; a
**green is a FINDING** — it would mean a unit that registers the very expectation
the class moves cannot see it move, which is a coverage fact worth having and is
adjudicated per row rather than scored against the class.

---

## 6. GREEN BY BLINDNESS — the coincidence cuts both ways, and this is the round's own discovery

**`error_pulses` (`bench.ml:237`) maps each sample's `errors_high` — the set of
strobe names high at that cycle — to `(cycle, name)` pairs.** A strobe is a
signal, not a counter: **two logical reports of the same name on the same cycle
are one observation.** That is `requirements.md` §0.6's C-23 counting convention
doing exactly what it says, and it decides three cells.

### 6.1 IC-E at sub-cases 3, 4 and 6 — `G✱`

Under IC-E at **D-E1 = `< 5`**, frame A (delivered 0, 4 and 0) additionally owes
`error_runt` at **A's own report cycle**. At sub-cases 3, 4 and 6 that cycle is
**4** — and frame B's genuine `error_runt` is **also** at cycle 4 (§2.3). **The
spurious report and the required one are the same name on the same cycle**, so
`errors_high` carries `error_runt` once and `error_pulses` returns exactly
`[(4, "error_start_without_terminate"); (4, "error_runt")]` — precisely what both
branches of step 8 require. **All three sub-cases pass.**

At **D-E1 = `0 < d < 5`**, sub-cases 3 and 6 are green for the ordinary reason
(A delivered nothing, so the floor excludes it) and **sub-case 4 is still green by
blindness**. The seal marks the branch-dependent reason because **a green with two
possible causes that a scorecard cannot separate is exactly what a seal is for**.

**Consequence, stated at full strength**: `test_m03_n.ml`'s trap T8 is asserted at
**two** members — sub-cases 2 and 4 — and **only sub-case 2 can convict its
class.** Sub-case 4 asserts the fact and cannot detect its violation. **That is a
real coverage limitation of the landed bench, it is mine, and it is on the record
before the campaign runs rather than discovered from a scorecard.** No verdict of
this round may report IC-E's kill as evidence that T8 is instrumented at two
members.

### 6.2 IC-B(W) at sub-case 4 — the same coincidence, the other direction

§5.2. The coincidence that makes sub-cases 3, 4 and 6 IC-C's instrument is what
makes sub-case 4 unable to see a second output word.

### 6.3 The portable form, recorded here because it is not about this bench

**A stimulus that pins two events to one instant is an instrument for any defect
that moves an event in time, and a blindfold for any defect that duplicates one.**
The same design property is the reason for both, and a coverage claim that names
the first without the second has counted its instrument twice.

---

## 7. Pre-committed dispositions

1. **A class red at exactly its `R!` set, with §4's verbatim cells, and green at
   every `G` and `G✱`** → **the class is KILLED, one kill**, and the units in its
   `R!` set are **QUALIFIED on that class and on nothing else**.
2. **A class red at its `R!` set but also red at a `G` its own §4 derivation calls
   a control** — IC-C at sub-cases 1/2/5, IC-D or IC-F at the `/E/` unit, IC-E at
   sub-cases 1/5 — → **the reds are blast radius, the class scores ZERO, and the
   rows stay UNQUALIFIED.** A campaign that seeds only the class it hopes will
   convict cannot tell a working instrument from a loud one.
3. **A class not reachable at its `R!` set** (a `NOT SEEDED` self-declaration, or a
   sub-case or lane undischarged under `WO-0066` §5) → the class is **void**: zero
   kills, **no claim about any row in either direction** (`WO-0061` `SEALED`
   §5.8(iv), applied to my own campaign).
4. **A class red at an `R!` unit but through `assert_monitors_clean`** — a message
   `<prefix>: strobe monitor unclean: …` — → the row-local instrument did **not**
   speak, the cell scores **UNQUALIFIED, structurally shadowed**, and **it may not
   be re-read as a qualification after the fact**.
5. **IC-C, IC-B(R) or IC-E red at an `R!` unit carrying one of `WO-0066` §6's five
   datapath messages** → the rendering perturbed the datapath, the class is **out
   of specification — reported, not scored**, and disposition 3's "no claim in
   either direction" governs.
6. **Two classes delivered in one diff, or IC-D and IC-F rendered by the same
   change** → **both are unscoreable**, because §4.4's strings are identical
   between them and the only discriminator is which diff was applied. Reported as
   a manifest defect, not as a result.
7. **Bound 7** is scored under `WO-0066` §4's four rules, on IC-A's outcome alone.
   **No other class scores it**, and no green anywhere is evidence about it.

---

## 8. Mutant-owned quantities — inequalities with named directions

| quantity | sealed | direction |
|---|---|---|
| `<n>` in `expected exactly one delivered word for frame A, got <n>` under **IC-A** | `< 1`, derived **0** | **fewer** — REQ-105's routing suppresses A's only word. A value `> 1` is not IC-A |
| the same `<n>` under **IC-B(W)** | `> 1`, derived **2** | **more** — B emits a word A's cell counts |
| `<n>` in `… observed <n>` (pulse count) under **IC-A** at sub-case 6 | `< 2`, derived **1** | **fewer** — B never opens, so B's report cannot exist |
| the same under **IC-B(R)** | `< 2`, derived **1** | **fewer** — the report is suppressed |
| the same under **IC-E** at sub-case 2 | `> 2`, derived **3** | **more** — a report is added, not moved |
| `<n>` in `… observed <n> pulse(s)` under **IC-D/IC-F** branch **S** | `= 0` | **not mutant-owned** — REQ-008's silent discard is the branch's definition; a nonzero value means the frame was reported and the branch is **C** |
| the deferred pulse's cycle under **IC-C** | `observed ≠ the pinned cycle` | **later** — IC-C defers; an earlier pulse is not this class |
| the strobe **names** at every N sub-case | `⊆ {error_start_without_terminate, error_runt}` | **not mutant-owned** — §9's closure list and ruling 9's sub-5 class fix both. A third name, `error_bad_fcs` above all (T9), is a finding |
| frame B's **output words** at every N sub-case | `= 0` | **not mutant-owned** — §0.7. Nonzero **is** IC-B(W) and is out of specification for every other class |
| units reddening under a class | `⊆` §3's predicted set for the disclosed branch | a red **outside** it is a finding: either my enumeration was incomplete or the diff reaches further than the class it names |

**Four of the ten are specification-fixed and sealed as equalities on purpose.**
Calling them mutant-owned would be buying an unfalsifiable seal.

---

## 9. Reasoning for the cells that are not obvious

**(a) Why the thirty-odd untouched M03 units are GREEN under every class, derived
from the registration inventory rather than from a category.** The
`Strobe_monitor.expect` sites under `test/xgmii_rx_64/` were enumerated and
classified by their own `cycle` field and `why` text (`WO-0066` §3's table). A
unit that registers **nothing** cannot lose an expected event, and a unit whose
rows assert `error_pulses samples` is empty is asserting an **absence over the
whole run** that none of these six classes can disturb — each of the six either
adds a report to a frame that already owes one, removes one that is owed, moves
one in time, or changes a preamble-exit decision on a stimulus that has no
preamble-position control character. **The untouched units have none of those
stimuli**, and that is a fact about their stimuli, not about their family.

**(b) Why M03-H4 is green under IC-C, named rather than left to surface.** M03-H4
is the only other unit in the bench that registers **two** no-output-word reports.
They are pinned at `c + 2` and `c + 3` — **adjacent, never equal** — because frame
A is aborted by the second `/S/` in word `c` and frame B by the third `/S/` in word
`c + 1`. IC-C moves **coincident** reports; H4 has none. M03-G7's two are further
apart still: an `error_oversize` at the truncation cycle
(`start_cycle + 3 + 189`) and an `error_runt` two cycles after a terminate that
follows the whole 1600-octet frame. **IC-C's entire convicting set is inside
M03-N2**, and that is what makes it this round's own measurement.

**(c) Why the `/E/` unit is the control IC-D and IC-F cannot do without.** An `/E/`
in a preamble position routes to REQ-105 under REQ-102's third sentence **and**
under a design that simply treats preamble positions as frame positions — same
observable, both readings. So the `/E/` unit tests the **outcome** and not the
**rule**, and a rendering that reddens it has changed the outcome for every
character rather than the routing for the ones REQ-113 or a closed table would
miss. **Disposition 2, and it is the reason the landed `/E/` members are in this
campaign at all.**

**(d) Why `M03-B3` is green under IC-D and IC-F.** M03-B3 places a `/T/` at
preamble position 5, and `/T/` is in **every** closed code table and is **not**
a character REQ-113 ignores. Its greenness is a stimulus fact — the character's
identity — not a category.

**(e) The stimulus guards cannot fire under any class, and their silence is not
coverage.** `Injection.is_clean`, both landing sites, the seven derivation guards
and the `Injection.outcomes` cross-check are evaluated on the **bench's own
model**, before or independently of the DUT (§2.1 steps 1–4). **No RTL mutation
can move them.** A `test bug --` or `Injection model cross-check disagrees on …`
message in this campaign means something other than a seeded class.

**(f) The `%expect` blocks do not move and no cell is scored on one.** All six N
units and both new B2 units carry `[%expect {||}]` and are empty by construction —
they assert, they do not print. A raise leaves the block untouched, so the diff is
silent and **the raised message alone scores the cell**.

**(g) The instrument families this campaign probes, stated because the scorecard
must state it.** Three, and only three: the **exact-pulse-set check** (`error_pulses`
matched against a derived `(cycle, name)` pair list — IC-A at sub-case 6, IC-B(R),
IC-C, IC-E), the **output-word count-and-shape check** (`delivered_samples` matched
against a derived word count and `tkeep`/`tlast`/`tuser` — IC-A at sub-cases 4/5,
IC-B(W), IC-D/IC-F branch C), and the **exactly-one-pulse check** (IC-D/IC-F branch
S). **The standing `Strobe_monitor` is shadowed at every predicted cell and is
expected to speak nowhere** — the same result `WO-0063B-VERDICT` §5 measured, now
predicted in advance rather than discovered.

---

## 10. Bounds this campaign does NOT close, named before the result

1. **`WO-0058` bound 7 is scored, never closed.** Even at 3 of 3 the bound leaves
   my carried list only when the plan records both the payment and the score.
2. **T8 is instrumented at two members and detectable at one** (§6.1). The
   coverage limitation is real, it is the bench's, and it survives any outcome of
   this round.
3. **A kill proves the assertion convicts, never that the bench is a general
   detector of the class.** IC-B is detected at eight units outside family N under
   the wide branch; **this bench was not blind to it** and no verdict may imply it
   was.
4. **IC-D and IC-F cannot be told apart by any observation this bench makes**
   (§4.4). Their separation is carried entirely by the manifests, and disposition
   6 is the whole of the protection.
5. **Sub-case 4 is inert under IC-B(W)** (§5.2/§6.2), so the campaign's IC-B(W)
   evidence rests on five members, not six.
6. **M03-B2's lane-4 cells are shadowed by lane 0** within their own unit (§5.3)
   and are not independently observed in a passing-to-failing run.
7. **SPEC-M03 §6.3 item 8 is untouched, and is a closed question rather than an
   open coverage item** (`RV-0065B-VERDICT` §6 item 3). All three coincidences are
   different-name; the carve-out forbids the same-name stimulus in terms.
8. **Nothing here bears on family J, on `M03-N1`/`M03-N3`/`M03-N4`, or on the
   nineteen outstanding ASSERT rows.**

---

## 11. Pass criteria

1. **Each class reddens exactly its `R!` set**, with §4's verbatim cells for the
   branch its manifest disclosed, and **stays green at every `G` and `G✱`**.
2. **No MUST-STAY-GREEN unit reddens** under any class and **no unit outside §3's
   predicted sets reddens** — except at the cells §5 marks `U` or `r`, where §5's
   rules govern instead. Outside M03: the **79** behavioural units hold, and a red
   at `test/hardcaml_ethernet/`'s single unit is read as a **build** finding (§0).
3. **The unmutated control is green at the base SHA**, with its CI run id and
   conclusion quoted. **CI is the authority** (ADR-0005).
4. **Kills are counted per class**: six classes, at most **six** kills. IC-B(W)
   wide's eighteen reds are **one**.
5. **Bound 7 is scored under `WO-0066` §4's rules and reported with its instances
   distinguished** — `Frame`-state and `Preamble`-state named separately, or the
   round has recorded a count rather than a coverage.
6. **All seven disclosures are answered before the run.** A branch inferred by me
   from a scorecard is not a disclosure and the affected cells score as `U`.

---

## 12. Not to be told

§1's row prefixes, §2's assertion orders and the eight-number table, §3's matrix —
above all its MUST-STAY-GREEN columns and its `G✱` cells — §4's verbatim strings,
§5's UNWORKED adjudication rules, §6's blindness argument in its entirety, §7's
dispositions, §8's inequality table, §9's reasoning, §10's bounds.

**Freely told, and told in `WO-0066`**: the six classes and why two of the five
foreseen were split; the seven mandatory disclosures; the denominator and its
blast-radius correction; the measured convicting sets; bound 7's scoring rule and
the three instances' state split; the reachability standard; the datapath
signature, its domain and its five messages; the allowlist and manifest bars; the
base SHA and the ordering rule; the mutant-owned inequality principle; the
non-closures and their carriers; the weighting; the return format.
