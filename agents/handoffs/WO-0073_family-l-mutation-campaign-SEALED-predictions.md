# WO-0073 SEALED: dv_lead's frozen predictions for the family-L mutation campaign

> **SEALED.** The auditor must not open this file until every diff is delivered
> and every scorecard is in hand — and under `WO-0073` §7's allowlist, **all of
> `agents/**` is out of bounds for the campaign's duration**, this file included
> and absolutely.

- **State**: **FROZEN — unopened.**
- **Frozen against**: **the commit this file's own commit immediately follows** —
  the parent of the commit staging this seal and its packet. I cannot state its
  hash: I never run git (PROTOCOL §2), and it has none until the orchestrator
  creates it. **The orchestrator verifies that identity at commit time**; the
  auditor quotes the hash it applied to (`WO-0073` §7 item 6), and any
  disagreement is a finding **before** the campaign runs.
- **Frozen by**: dv_lead, `J-dv_lead-0133`, **before any diff existed**, in the
  commit that stages this file beside its packet — R-SEAL-1 (PROTOCOL §10,
  ADR-0016).
- **Second copy**: the class → `R!`-unit **row mapping** (not the message
  strings, not the matrix) is restated in `J-dv_lead-0133`.
- **Standing rule 1, from `RV-0055` FINDING G-1**: every sealed cell that rests
  on a claim about the DUT's state cites the stimulus fact that establishes that
  state, or is marked UNWORKED.
- **Standing rule 2**: every message below is the **first assertion to speak**,
  derived from the unit's committed control flow and source order at the base
  SHA — never from what the row is "about". §2 states the orders every cell
  depends on.
- **Standing rule 3**: a quantity the specification does not fix is sealed as an
  **inequality with a named direction**, never as a value.
- **Standing rule 4**: a cell that rests on **two events being distinguishable**
  states the convention by which they are distinguished; where the convention
  cannot distinguish them the cell is **GREEN BY BLINDNESS** and a green there is
  **not** evidence the class fails to reach it.
- **Standing rule 5 — NEW THIS ROUND, and it is `FINDING WO-0066-3`'s own
  lesson**: outside the units this seal works cell by cell, a class's predicted
  red set is stated as a **RULE in stimulus terms**, with worked instances named
  beneath it. **Where the rule and the instance list disagree, the RULE
  governs.** Last round my enumeration was short and the auditor's rule was
  right, and three MUST-STAY-GREEN violations were scored against me for a
  difference of form.

---

## 0. The denominator, re-measured at the freeze

`bash tools/dv_checks.sh` at this tree — the inventory block's own output, **not
carried forward**:

```
    3  test_m03_a.ml    7  test_m03_b.ml    4  test_m03_c.ml    3  test_m03_d.ml
    4  test_m03_e.ml    4  test_m03_f.ml    7  test_m03_g.ml    4  test_m03_h.ml
    5  test_m03_i.ml    3  test_m03_j.ml    2  test_m03_k.ml    2  test_m03_l.ml
    8  test_m03_n.ml    3  test_m03_structural.ml
  ---
   59  test/xgmii_rx_64/ (the M03 bench)
  139  test/ (repository-wide)
```

**59 M03 units; 139 repository-wide; 80 non-M03.** The row-discharge census at
the same tree: **78 rows declared, 62 named in a unit title** under both the
naive and the trailing-digit-boundary matcher, the two agreeing at this tree;
with `M03-A4` subtracted and `M03-F5` added by citation, **62 of 62 ASSERT rows
discharged**.

**Family L is exactly 2 of the 59** — `test_m03_l.ml`'s two units. Those two are
worked cell by cell below. The other **57** are governed by each class's rule
(§3.4).

**The non-M03 80, by what a red there would mean:**

| set | units | a red there means |
|---|---|---|
| `test/monitors/` 37, `test/xgmii/` 25, `test/golden/` 11, `test/axi64_probe/` 3, `test/xgmii_probe/` 3 | **79** | the manifest reached outside its own file — a **scope finding** |
| `test/hardcaml_ethernet/` (declares `hardcaml_ethernet`, names no M03 module) | **1** | the mutant **does not compile** — a **build finding**, never behavioural |

**MUST-STAY-GREEN outside M03, every class, every branch: 79 behavioural + 1
build-level.** `test/cosim/` contributes **zero units** and is nonetheless a
second home for the build-finding class (`WO-0073` §2.1): its `(executables)`
stanza links `hardcaml_ethernet`, so a non-compiling mutant fails the **build
step** there without producing a unit red. **A green `test/cosim/` is not
evidence the mutant compiled**; the build step's own conclusion is.

---

## 1. The row prefixes, which are how the scorecard is read

Every message below is `<row prefix>: <body>`, composed by `test_m03_l.ml`'s own
`fail row msg = failwith (String.concat [ row; ": "; msg ])`. The prefixes at the
base SHA:

| site | prefix, character-exact |
|---|---|
| unit 1, whole-run assertions | `M03-L1/L2/L3/L4` |
| unit 1, inside the per-frame walk | `M03-L1/L2/L3/L4 (frame <i>)` — `<i>` is `frame.index` |
| unit 1, inside `assert_class` | `M03-L1/L2/L3/L4 (h = 8)` and `M03-L1/L2/L3/L4 (h = 12)` |
| unit 2, directed lengths | `M03-L5 (lane 0, length 64)` … `M03-L5 (lane 4, length 71)` |
| unit 2, the 1518 members | `M03-L5 (lane 0, length 1518)` and `M03-L5 (lane 4, length 1518)` |

**The two units are separate `%expect_test`s**, so neither shadows the other and
both are independently observable in the same run. **Inside unit 2 the eighteen
runs shadow one another** — §2.3.

---

## 2. The orders every REQUIRED cell depends on

### 2.1 Unit 1 — `run_l1_l2_l3_l4`, nine items, in this order at the base SHA

1. **stimulus legality** — `Arrival.check`, called by `run` before a cycle is
   driven;
2. **schedule shape** — frame count = 10 000, `Arrival.start_lanes`,
   `Arrival.start_spacings`;
3. **frame count out** — `tlast` samples = 10 000;
4. **the per-frame walk**, over the shrinking remainder, in this inner order:
   group non-empty → group length = 8 → per word `tkeep` (0xFF, 0x0F at m = 7) →
   per word `tlast` placement → `tuser` on the group's last word → delivered
   octet **count** = 60 → delivered octet **content** positionally →
   `account_clean_frame`; then, after the loop, **the leftover-word guard**
   (message prefix `test bug --`);
5. **the empty strobe set** — `Bench.error_pulses samples = []`;
6. **the sequence read-back** — `[0 … 9999]`;
7. **the two latency-class records** — `List.length classes = 2`, then
   `find_class 8` and `assert_class` at **h = 8 first**, then h = 12; and inside
   `assert_class`: `latencies` → `word_delay` → `frames` → `octets`;
8. **the whole-run latency accessors** — `word_delay` → `errors` →
   `frames_compared` → `octets_compared`;
9. **`assert_monitors_clean`** — protocol → conservation → strobe → tagger
   errors → tagger constancy.

**Items 1 and 2 are evaluated on the bench's own model of the stimulus** and no
RTL mutation can move them. **Items 6, 8 and (almost all of) 9 are structurally
unreachable** — §6.1, §6.2, §6.3. **The reachable instruments of unit 1 are
exactly items 3, 4, 5 and 7.**

### 2.2 The derived numbers, re-derived at this tree from `Arrival`'s own layout

`Arrival.stress ()` lays out 10 000 × 64-octet frames at `ifg = 12`,
`first_start = 8`; `round_up_4` makes the credit path dead, so
`start_octet_time(i) = 8 + 84 i` exactly.

| quantity | even frame `i = 2k` | odd frame `i = 2k + 1` |
|---|---|---|
| start octet time | 8 + 168k | 92 + 168k |
| start lane | **0** | **4** |
| start cycle | **1 + 21k** | **11 + 21k** |
| front offset h | **8** | **12** |
| terminate octet time | 80 + 168k | 164 + 168k |
| **terminate word cycle** | **10 + 21k** | **20 + 21k** |
| output words (gapless `m + 3`) | cycles **4 + 21k … 11 + 21k** | cycles **14 + 21k … 21 + 21k** |
| **the NEXT frame's start word cycle** | **11 + 21k** | **22 + 21k** |
| L | **16** | **12** |
| ΔC | **3** | **3** |

**Two coincidences carry three of the five classes, and both are consequences of
REQ-004's own alternation:**

- **Adjacency.** After an **even** frame the terminate word (10 + 21k) and the
  next start word (11 + 21k) are **consecutive cycles** — no idle word between
  them. After an **odd** frame they are 20 + 21k and 22 + 21k — **exactly one**
  idle word between. **5 000 of each, alternating.** This is IC-L1's whole
  instrument.
- **Collision.** An **even** frame's output word 7 is emitted at **11 + 21k**,
  which **is** the cycle of the input word carrying the next frame's start
  character. An **odd** frame's word 7 is at 21 + 21k and the next start is at
  22 + 21k — no collision. **5 000 collisions, all at even frames, and every
  colliding word is the one that carries its frame's `tlast`.** This is IC-L4's
  whole instrument.

Checked at `k = 0`: frame 0 starts ot 8 (cycle 1, lane 0), terminates ot 80
(cycle 10), emits words at cycles 4 … 11; frame 1 starts ot 92 = 8·11 + 4
(cycle 11, lane 4), terminates ot 164 (cycle 20), emits at 14 … 21; frame 2
starts ot 176 (cycle 22). Both coincidences hold as stated.

**Drain headroom, and it is load-bearing for every timing class**:
`Arrival.cycles` = 105 002 and `run … ~drain:8` drives cycles 0 … **105 009**.
Frame 9999 (odd, k = 4999) starts at cycle 104 990 and emits word 7 at
**105 000**. **Nine cycles of headroom.** No class in this campaign delays a
word out of the observed window, so **no timing class changes the frame count**
— which is what keeps items 3 and 7 discriminating rather than collapsing onto
each other.

### 2.3 Unit 2 — `run_l5`, eighteen runs, seventeen shadowed

`run_l5` calls, in order: `run_l5_directed ~lane:0`, `run_l5_directed ~lane:4`,
`run_l5_1518 ~lane:0`, `run_l5_1518 ~lane:4`. `run_directed_lengths` returns its
list in ascending length order and `List.iter` asserts in that order, so **the
observation order is**:

```
(0,64) (0,65) (0,66) (0,67) (0,68) (0,69) (0,70) (0,71)
(4,64) (4,65) (4,66) (4,67) (4,68) (4,69) (4,70) (4,71)
(0,1518) (4,1518)
```

**Only the first reddening member is observable in a passing-to-failing run.**

**The order inside `assert_l5_run`**: `Latency.errors` → `frames_compared = 1` →
`observed` is a single class → `front_offset` → `latencies` → `word_delay` →
`assert_monitors_clean`. **This order is INVERTED relative to unit 1**: at L5 the
tagger's own per-frame errors — the octet-count arm, the alignment arm, the
front-offset arm — speak **before** any latency comparison, where in unit 1 the
bench's own datapath assertions speak first. **That inversion is the whole of
§6.5's discriminator and it is why IC-L5's two cells read completely
differently.**

### 2.4 The residue map, on which IC-L3's cells turn

`tkeep` residue = (delivered) mod 8 = (ℓ − 4) mod 8, REQ-103 stripping four FCS
octets:

| length ℓ | delivered | residue | words | `tlast` `tkeep` |
|---|---|---|---|---|
| 64 | 60 | **4** | 8 | 0x0F |
| 65 | 61 | **5** | 8 | 0x1F |
| 66 | 62 | **6** | 8 | 0x3F |
| 67 | 63 | **7** | 8 | 0x7F |
| 68 | 64 | **0** | 8 | 0xFF |
| 69 | 65 | **1** | 9 | 0x01 |
| 70 | 66 | **2** | 9 | 0x03 |
| 71 | 67 | **3** | 9 | 0x07 |
| **1518** | 1514 | **2** | 190 | 0x03 |
| **the stress frame** | 60 | **4** | 8 | 0x0F |

**The stress run's residue is 4**, so `4 ∈ R` is exactly the condition under
which IC-L3 also reddens unit 1. The **first-speaking** L5 member for a residue
set **R** is the smallest lane-0 length in the map whose residue lies in R:

```
r = 0 → ℓ = 68     r = 4 → ℓ = 64
r = 1 → ℓ = 69     r = 5 → ℓ = 65
r = 2 → ℓ = 70     r = 6 → ℓ = 66
r = 3 → ℓ = 71     r = 7 → ℓ = 67
```

---

## 3. The matrix

`R!` = REQUIRED red **and scored**. `G` = MUST STAY GREEN. `G✱` = **green by
blindness** (§6) — required green, and **not** evidence the class fails to reach
it. `r` = predicted red by the class's own **rule**, **UNWORKED**, contributing
**zero** kills. `U` = UNWORKED cell with adjudication pre-fixed. Anything
off-pattern is a **finding**.

### 3.1 The two family-L units, worked

| | IC-L1 **D** | IC-L1 **T** | IC-L2 **U** | IC-L2 **H** | IC-L3 (4 ∉ R) | IC-L3 (4 ∈ R) | IC-L4 **S** | IC-L4 **F** | IC-L5 |
|---|---|---|---|---|---|---|---|---|---|
| **unit 1** (M03-L1/L2/L3/L4) | **R!** item 3 | **R!** item 7, h = 12 | **R!** item 7, h = 8 | **U** (§5.2) | **G** | **R!** item 7, h = 8 | **R!** item 3 | **R!** item 7, h = 8 | **R!** item 3 |
| **unit 2** (M03-L5) | **G** | **G** | **R!** first member | **U** | **R!** first member in R | **R!** member ℓ = 64 | **G** | **G** | **R!** first member |

**The greens in that table are not decoration and three of them are the whole
measurement.** IC-L1 and IC-L4 must leave unit 2 green (no L5 run has a
preceding frame, so neither the adjacency nor the collision condition exists
there); IC-L3 at 4 ∉ R must leave unit 1 green (the stress frame's residue is
4). A red at any of those three means the rendering keys on something other than
the class, the reds elsewhere are blast radius, and §8 disposition 2 governs.

### 3.2 Kills, per class

| class | kills if §8 disposition 1 holds |
|---|---|
| IC-L1 | **1** |
| IC-L2 | **1** |
| IC-L3 | **1** |
| IC-L4 | **1** |
| IC-L5 | **1** |
| **campaign maximum** | **5** |

**Kills are counted per class.** IC-L2's and IC-L5's predicted reds across the
rest of the M03 bench are **one** kill each, never dozens.

### 3.3 The rows these kills qualify

| class | qualifies | on nothing else |
|---|---|---|
| IC-L1 **D** | **M03-L1** (§8 check 1: frames out = frames in) | — |
| IC-L1 **T** | **M03-L2** (the h = 12 class record) | — |
| IC-L2 | **M03-L2** (both class records; the L5 members corroborate) | **not M03-L3** — §6.2 |
| IC-L3 | **M03-L5**, and this is the only class that does | — |
| IC-L4 **S** | **M03-L1** | — |
| IC-L4 **F** | **M03-L2** (the h = 8 class record) | — |
| IC-L5 | **M03-L1** (the frame count) | **not M03-L4** — §6.1 |

**No class in this campaign qualifies `M03-L3` or `M03-L4` on its own
instrument, and none can** — §6.1 and §6.2. Any verdict that says otherwise is
convicted by this table.

### 3.4 The rules governing the other 57 M03 units

| class | RULE (governs where §3.5's instances are short) |
|---|---|
| **IC-L1 at D-L1b = A** | a unit reddens iff its schedule contains a frame whose **start word's cycle is exactly one more** than the cycle of a word carrying the previous frame's terminate character, **and** the unit asserts something about that frame |
| **IC-L1 at D-L1b = L** | a unit reddens iff it drives **any lane-4 start** and asserts anything about that frame. This branch's MUST-STAY-GREEN inside M03 is the lane-0-only units and nothing else |
| **IC-L2** | a unit reddens iff it pins **any** output word's cycle, any strobe's cycle, or any per-octet latency. **227 such sites exist across all twelve M03 row files** (measured at this tree), so the predicted red set is most of the bench |
| **IC-L3** | a unit reddens iff it drives a frame whose **delivered** octet count ≡ r (mod 8) for some r ∈ **R**, **and** pins that frame's `tlast`-word cycle, its strobe cycle or its per-octet latency |
| **IC-L4** | a unit reddens iff a frame's **last output word cycle equals the cycle of an input word carrying a start character**, and the unit asserts that frame's `tlast`, word count or latency |
| **IC-L5** | a unit reddens iff it asserts a **word count**, a **`tlast` count**, a **delivered octet count**, or feeds the latency tagger a clean-frame extent — i.e. essentially every unit that delivers a frame |

### 3.5 Worked instances beneath the rules — `r` unless marked

- **IC-L1(A)** — the multi-frame schedule sites measured at this tree are
  `test_m03_d.ml:269`, `test_m03_e.ml:533`, `test_m03_f.ml:686`,
  `test_m03_g.ml:431/:741/:881/:1064`, `test_m03_i.ml:1112`,
  `test_m03_j.ml:84/:389`, `test_m03_k.ml:393`, plus every schedule built through
  `Dv_xgmii.Injection` (families B, E, F, G, I, N). All are `r`. **One is
  WORKED and predicted GREEN**: `test_m03_i.ml:1112` passes `~ifg:824`, a gap
  of 824 octet times, so no start word can be adjacent to a terminate word. **A
  red there is a finding against the rule, which is exactly the discrimination
  the worked instance buys.**
- **IC-L2** — **WORKED red**: `test_m03_c.ml:511` asserts
  `s.cycle <> start_cycle + 3` for M03-C4's single output word and raises *"the
  single output word did not arrive on start_cycle + 3 (REQ-019)"*. Everything
  else selected by the rule is `r`.
- **IC-L3** — **WORKED, branch-dependent**: M03-C4's 5-octet runt delivers **1**
  octet, residue **1**, and pins `start_cycle + 3` at the same site, so it is
  **red iff 1 ∈ R** and green otherwise. Family C's directed-length units
  (`test_m03_c.ml`, 4 units) drive the same 64 … 71 and 1518 set and are `r`.
- **IC-L4** — every unit driving two consecutive 64-octet frames from a **lane-0**
  first start has the same collision by the same arithmetic (word 7 at cycle 11,
  next start at cycle 11); the sites above are `r`.
- **IC-L5** — `r` across essentially the whole M03 bench.

**Adjudication for every `r` cell, fixed here**: a **red is predicted blast
radius, contributes zero additional kills, and is not an unnamed-unit finding**;
a **green is a FINDING** — it would mean a unit selected by the class's own rule
cannot see the class — and is adjudicated per row rather than scored against the
class.

---

## 4. The REQUIRED cells, verbatim

The bodies below are the OCaml literals at the base SHA as the runtime composes
them. `<n>` marks a **mutant-owned** integer, sealed at §9 as an inequality;
every other character is exact.

### 4.1 IC-L1

**Branch D — the frame is dropped.** Unit 1, item 3:

```
M03-L1/L2/L3/L4: 10 000 frames presented, <n> tlast words observed
```

**Derived `<n>` = 5 000.** The 5 000 odd-index frames are the ones whose start
word is adjacent to a terminate word (§2.2), so only the 5 000 even-index frames
deliver, each with one `tlast`. Item 3 is the **first DUT-observable check in the
unit** — items 1 and 2 read the schedule, not the design — so nothing earlier can
speak. **Unit 2 is GREEN**: an L5 run drives one frame with nothing before it.

**Branch T — the frame is taken one cycle late.** Unit 1, item 7, the **h = 12**
class:

```
M03-L1/L2/L3/L4 (h = 12): latencies is not the single value this front-offset class must carry (§0.5 Start lanes)
```

Derivation, and it is an ordering claim as much as a value claim. The odd frames
deliver correctly, one cycle late, so item 3 sees 10 000 (§2.2's nine cycles of
headroom keep frame 9999's word 7 inside the window at 105 001), item 4's
content, `tkeep`, `tlast` and `tuser` checks are all unmoved, item 5 sees no
strobe and item 6 is unreachable. At item 7 the **h = 8 class is asserted first
and passes whole** — latencies `[16]`, `word_delay` `Some 3`, frames 5 000,
octets 300 000, because the even frames are untouched — and the h = 12 class then
carries a single latency of **20** (12 + 8 octet times for one cycle) against a
required `[12]`. **This message prints no value**, which §7 turns into a
collision. **Unit 2 is GREEN.**

### 4.2 IC-L2 — branch U

Unit 1, item 7, the **h = 8** class:

```
M03-L1/L2/L3/L4 (h = 8): latencies is not the single value this front-offset class must carry (§0.5 Start lanes)
```

Unit 2, the **first** member of §2.3's order:

```
M03-L5 (lane 0, length 64): latencies = [<n>], expected [16]
```

**Derived `<n>` = 24.** Every output word moves to `m + 4`, so every octet's
latency rises by 8 octet times: L = **24** at h = 8 and **20** at h = 12, a
single value in each class.

**The REQUIRED GREEN that carries the class's whole point.** `Latency.errors` is
**empty** under IC-L2, at both units, and that is derived rather than hoped:
(L + h) = 32 at both lanes, a multiple of 8, so §0.5's closure produces
`word_delay = Some 4` rather than `None`; the ceiling test is `d > ceiling`, and
4 > 4 is false; and §0.5's start-lane pair rule admits `db = da`, which 4 and 4
satisfy. **REQ-019's entire machinery is silent on a one-cycle regression that
spends the reserve SPEC-M03 §7 deliberately left**, and the only assertion in
this bench that convicts it is REQ-005/REQ-111's pinned constant. That silence is
a **required green**: a non-empty `Latency.errors` under IC-L2 means the
rendering did something else as well.

### 4.3 IC-L3

Unit 2, the first member whose delivered residue lies in **R** (§2.4's map):

```
M03-L5 (lane 0, length <ℓ>): latencies = [16; <n>], expected [16]
```

**Derived `<n>` = 24**; `<ℓ>` is fixed by R and the map, **not** mutant-owned in
the §9 sense — it is the rendering's disclosed R read through a table both sides
hold. At the natural minimal choice **R = {0}** the cell is:

```
M03-L5 (lane 0, length 68): latencies = [16; 24], expected [16]
```

Derivation. Only the `tlast` word moves, so the frame's earlier octets keep
L = 16 and its final word's octets take L = 24; `c.ls` accumulates both and
`observed` sorts ascending, so the printed list is `[16; 24]`. `Latency.errors`
is empty: two latencies make the closure arm return nothing at all (it matches
only a singleton list), a single class makes the pair rule vacuous, and the
per-frame arms are closed because the octet count, the front offset and the
word-0 alignment are all unchanged. `frames_compared` = 1 and `front_offset` = 8
both pass, so the `latencies` comparison is the first to speak.

**Unit 1 is GREEN at 4 ∉ R and R! at 4 ∈ R** — the stress frame delivers 60
octets, residue 4 (§2.4). At 4 ∈ R the unit-1 cell is IC-L2's §4.2 string
character-for-character, because the delayed final word gives the h = 8 class
latencies `[16; 24]` and the message prints no value: **§7 collision 2.**

### 4.4 IC-L4

**Branch S — the colliding word is suppressed.** Unit 1, item 3:

```
M03-L1/L2/L3/L4: 10 000 frames presented, <n> tlast words observed
```

**Derived `<n>` = 5 000**, and **this is IC-L1(D)'s §4.1 cell character-for-
character, integer included** — §7 collision 1. The 5 000 even frames each lose
word 7, which is the word carrying their `tlast`; the 5 000 odd frames keep
theirs. **The delivered-word totals differ enormously between the two classes**
(40 000 words under IC-L1(D), 75 000 under IC-L4(S)) **and the bench never reads
that number**, because item 3 counts `tlast`s and speaks before the per-frame
walk that would have counted words. **Unit 2 is GREEN.**

**Branch F — the colliding word is deferred one cycle.** Unit 1, item 7, the
**h = 8** class:

```
M03-L1/L2/L3/L4 (h = 8): latencies is not the single value this front-offset class must carry (§0.5 Start lanes)
```

**This is IC-L2(U)'s unit-1 cell character-for-character** — §7 collision 3. The
even frames' final four octets take L = 24 while their first 56 keep 16, so the
h = 8 class carries `[16; 24]`; every earlier item passes (the deferred word
lands at cycle 12 + 21k, free, and arrives complete, so the count, the `tkeep`,
the `tlast` placement, the `tuser` and the content are all unmoved). **Unit 2 is
GREEN — and that green is the discriminator against IC-L2, by measurement rather
than by assertion.**

### 4.5 IC-L5

Unit 1, item 3:

```
M03-L1/L2/L3/L4: 10 000 frames presented, <n> tlast words observed
```

**Derived `<n>` = 20 000**, at the disclosed one-extra-cycle rendering
(**D-L5a**). **The string form is §4.1's and §4.4's; the DIRECTION is the
discriminator** — sealed `> 10 000` where the other two are sealed `< 10 000`.

Unit 2, the first member, through the **tagger's own error list** rather than
through a bench comparison:

```
M03-L5 (lane 0, length 64): latency tagger errors:
frame 0: 72 input octets less 8 stripped from the front and 4 from the back is 60, but <n> octets were emitted
```

**Derived `<n>` = 64.** The frame's input trace is 8 preamble + 64 frame octets =
**72** entries; the tagger's configured extents are 8 and 4, so it requires 60;
the delivered stream is words 0 … 6 (56 octets) plus word 7 twice (4 + 4), so
**64**. `assert_l5_run` reads `Latency.errors` **first** (§2.3), and this is a
`rev_errors` entry raised inside `frame_out`, so it speaks before
`frames_compared`, before `observed`, and before any latency comparison. The
`\n` between the two lines is the literal in `assert_l5_run`'s own
`String.concat`, and the second line is the tagger's, not the bench's.

---

## 5. The UNWORKED cells, with adjudication pre-fixed

### 5.1 IC-L1 and IC-L4 at their unworked branch pairs

Only **one** branch of each disclosure is rendered. If the manifest delivers
both branches of a disclosure as separate diffs, each is scored against its own
column above and the **cost is priced** (`WO-0073` §12(b)); if it delivers a
rendering that is neither branch — e.g. IC-L1 accepting the frame but corrupting
it — every cell is `U` and disposition 5 governs.

### 5.2 IC-L2 at **D-L2a = H** — every cell

If only output word 0 moves, word 0 and word 1 are owed on **one cycle** and this
stream carries at most one word per cycle (REQ-002). Whether the rendering drops
one, displaces one, or serialises them is the rendering's, and each produces a
different first-speaking message — item 4's word-count arm, item 4's `tkeep` arm,
item 3, or item 7. **I decline to derive it**, because the answer depends on a
storage decision the specification does not constrain.

**Adjudication, fixed here**: at **H**, the cells are scored on **membership in
this enumerated set** and on nothing finer:

```
M03-L1/L2/L3/L4: 10 000 frames presented, <n> tlast words observed
M03-L1/L2/L3/L4 (frame <i>): delivered <n> output words, expected 8
M03-L1/L2/L3/L4 (frame <i>): word <m> tkeep = <n>, expected <n>
M03-L1/L2/L3/L4 (frame <i>): word <m> unexpectedly carries tlast
M03-L1/L2/L3/L4 (frame <i>): word 7 does not carry tlast
M03-L1/L2/L3/L4 (frame <i>): delivered <n> octets, expected 60
M03-L1/L2/L3/L4 (frame <i>): delivered octets do not match Arrival's own delivered-octet accessor, positionally (REQ-103)
M03-L1/L2/L3/L4 (h = 8): latencies is not the single value this front-offset class must carry (§0.5 Start lanes)
```

A message **inside** the set scores the cell as a red of the class; a message
**outside** it is a finding. The kill still counts, because the class's
consequence — the word delay is not 3 — is what is being scored, not the shape
of the wreckage.

### 5.3 Unit 2's shadowed members — seventeen of eighteen

§2.3's order runs lane 0 lengths 64 … 71, then lane 4, then the two 1518
members. **Every member after the first reddening one is structurally
unobservable in a passing-to-failing run.**

**Adjudication, fixed here**: unit 2's cell is scored on the **first** member the
order reaches; a later member's string is scored **only** if the scorecard
reports it, which requires every earlier member to have been green — itself a
finding under the class's own rule. The auditor's R-DISC-1 discharge is still
required **per lane and per length** (`WO-0073` §5): a member discharged term by
term and merely unobserved is recorded as **unobserved**, never as a miss and
never as a pass.

**This bites hardest at IC-L2**, whose predicted red set is all eighteen members
and whose observable is one; and at **IC-L3 with |R| > 1**, where the residues
above the first are unobserved rather than unreached.

### 5.4 A red arriving through `assert_monitors_clean`

A message of the form `<prefix>: protocol monitor unclean:`,
`<prefix>: conservation monitor unclean:`, `<prefix>: strobe monitor unclean:`,
`<prefix>: latency tagger errors:` **in unit 1**, or `<prefix>: latency tagger
unclean:` means item 9 spoke and **every reachable earlier item passed**. Given
§6.3 that is a REQ-014 `tstrb` finding or a defect in my own ordering
derivation. **The cell scores UNQUALIFIED, structurally shadowed**, it may not be
re-read as a qualification after the fact, and the class's own kill is not
counted from it.

### 5.5 A red carrying `test bug --`

`OBSERVATION L-O1` (`RV-0070-VERDICT` §3): unit 1's leftover-word guard raises
`M03-L1/L2/L3/L4: test bug -- <n> output words left over after 10 000 frames`,
and its condition is **also reachable by a design** that emits words after the
last frame's `tlast`. **Fixed here, before the run**: such a red is a **design
red mislabelled by the bench**, is scored as an unpredicted red under §9's
containment row, and is **never** read as a bench defect or as a stimulus
problem. No class in this campaign predicts it.

---

## 6. GREEN BY BLINDNESS, and the structural unreachability this round measures

This is the section the round exists to be honest about. Every claim is derived
from the landed file's control flow at the base SHA.

### 6.1 `M03-L4`'s own instrument (item 6) is UNREACHABLE — `G✱` under every class

Item 4 compares each frame's delivered octets **positionally** against
`Arrival.delivered frames.(k)`, and §8's stimulus puts REQ-020's four-octet
sequence number at offsets **14 … 17 inside those octets**. Item 6 then reads the
sequence back with `Frame.sequence_of` **from the very list item 4 just
compared**. So:

> **If item 4 passed at every frame, item 6 cannot fail.** And if item 4 failed
> anywhere, item 6 is never reached.

**M03-L4's assertion can never speak, under any mutation.** `WO-0070` §7 called
the overlap *"implied by M03-L1"*; it is stronger than implication — it is
structural, and it means **no class in this campaign may be scored on M03-L4's
own message.** The row is qualified by citation to M03-L1's pairing or not at
all. **A green at item 6 is not evidence of order preservation** — it is evidence
that item 4 ran.

### 6.2 `M03-L3`'s own instrument (item 8) is UNREACHABLE, term by term — `G✱`

| item 8's check | why it cannot speak |
|---|---|
| whole-run `word_delay` = `Some 3` | the accessor returns the common value of the classes' own `word_delay`s; item 7 has already required both to be `Some 3` |
| `Latency.errors` = `[]` | **derived** errors are closed by item 7 (single latency per class, the right one, `word_delay` `Some 3` ⇒ closure holds, 3 ≤ 4, pair rule (3,3) admitted). **Per-frame** errors are closed by item 4: the octet-count arm by item 4's 60-octet check, the word-alignment arm by item 4's `tkeep` = 0xFF on word 0, the front-offset arm because h is computed from `in_times` — the bench's own schedule — and is 8 or 12 by construction, the no-matching-input-frame arm because `frame_in` immediately precedes `frame_out` in `account_clean_frame`, and the zero-octet arm by item 4's count |
| `frames_compared` = 10 000 | **bench-supplied**: one `frame_out` call per schedule frame, incremented unconditionally. It is a count of the bench's own calls and **never evidence that the design delivered a frame** |
| `octets_compared` = 600 000 | the accumulator sums each frame's emitted octet count, which item 4 has already required to be 60 at every frame |

**M03-L3 asserts its two operands and neither operand can speak in this unit.**
Its ΔC content is discharged by `WO-0070` §6's derivation — a statement about the
specification — and by no run. **That is a real limitation of the landed bench,
it is mine, and it is on the record before the campaign runs rather than
discovered from a scorecard.** No verdict of this round may report any kill as
evidence that M03-L3's assertions convict anything.

### 6.3 Item 9's only reachable residue is REQ-014 — and no class here targets it

`Protocol_monitor`'s violation kinds are: the zero-octet frame, non-contiguous
`tkeep`, a non-full `tkeep` on a non-`tlast` word, **`tstrb` ≠ `tkeep`**
(REQ-014's producer half), and the max-words bound. Item 4 reads `tkeep`,
`tlast`, `tuser` and the octets — and **never `tstrb`**. The conservation monitor
is fed only by the bench's own `account_clean_frame` calls and is
design-independent. The strobe monitor carries **no registration** in either L
unit and is shadowed by item 5 in any case.

> **The one thing item 9 can convict that nothing earlier can is REQ-014.** No
> family-L row claims REQ-014, so no class here targets it; a class that did
> would score a standing-monitor row, not a family-L row.

### 6.4 REQ-020's reordering half has NO renderable mutant

Frame k + 1's octets arrive strictly later than frame k's; this is a cut-through
module (REQ-005) whose payload storage is bounded at two datapath words
(REQ-019, SPEC-M03 §6.1's *"at most two output words are ever waiting at once"*).
**No minimal diff can make it emit octets it has not received.** So the reorder
half of REQ-020 is **unfalsifiable at this stimulus**, and IC-L5 seeds the
duplication half alone. **A campaign that seeded a reorder class here would be
seeding a class the auditor must declare NOT SEEDED**, and the declaration would
have been the only result.

### 6.5 The unit-1 latency message prints no value — the instrument convicts without reporting

`assert_class`'s first arm raises a fixed string; its `word_delay`, `frames` and
`octets` arms all print the observed value, and its `latencies` arm does not.
**So a single-value shift (`[24]`) and a two-value split (`[16; 24]`) are
message-identical at that cell**, and an adjudicator reading a scorecard cannot
tell them apart. That is why §7's collisions exist and why unit 2 — whose L5
message **does** print the list — carries the discrimination.

### 6.6 The portable form, recorded because it is not about this bench

**An assertion whose subject is already compared, positionally and earlier, by a
sibling assertion in the same unit is unreachable, and its greenness is evidence
about the sibling.** Two rows of this family are in that position. The general
consequence: a coverage claim that counts both rows has counted one observation
twice, and the only way to find that out is to derive the unit's first-speaking
order **before** a campaign scores it.

---

## 7. Collisions — named, with their discriminators

**Collision 1 — IC-L1(D) ≡ IC-L4(S)**, unit 1's item-3 cell, **character-for-
character including the integer 5 000** (§4.1, §4.4).

- **Discriminator: NONE that this bench produces.** The two classes differ in
  40 000 versus 75 000 delivered words and the bench never reads that number,
  because item 3 counts `tlast`s and speaks first.
- **Carried entirely by which diff was applied.** Separate diffs and separate
  transients are mandatory; a combined diff makes **both** unscoreable
  (disposition 6). This is `WO-0066`'s IC-D/IC-F situation repeated with a
  different pair, and the protection is the same and is the whole of it.

**Collision 2 — IC-L3(4 ∈ R) ≡ IC-L2(U) at unit 1**, the h = 8 cell
(§4.2, §4.3).

- **Discriminator: unit 2's reddening member.** IC-L2 reddens at length **64**
  with `latencies = [24]`; IC-L3 reddens at the first length whose residue ∈ R
  with `latencies = [16; 24]`. **Both the length and the printed list separate
  them**, and both are measurements.

**Collision 3 — IC-L2(U) ≡ IC-L4(F) at unit 1**, the h = 8 cell (§4.2, §4.4).

- **Discriminator: unit 2's STATE.** IC-L2 reddens unit 2; IC-L4(F) leaves it
  **green**, because no L5 run has a next frame whose start character can
  collide with a tail word. **This is a measured discriminator, not a manifest
  one**, and it is a strictly better position than collision 1.

**Near-collision — IC-L5 at unit 1's item-3 cell** shares the string form of
collision 1 and is separated by the **direction** of its mutant-owned integer
(20 000 above, 5 000 below). §9's directions are what make that separation a
seal rather than a hope.

---

## 8. Pre-committed dispositions

1. **A class red at exactly its `R!` cells, with §4's verbatim strings for the
   branch its manifest disclosed, and green at every `G` and `G✱`** → **the class
   is KILLED, one kill**, and the rows §3.3 names are **QUALIFIED on that class
   and on nothing else**.
2. **A class red at its `R!` cells but also red at a `G` its own derivation calls
   a control** — IC-L1 or IC-L4 at unit 2, IC-L3 at unit 1 with 4 ∉ R disclosed,
   or IC-L1/IC-L4 at the wrong frame parity — → **the reds are blast radius, the
   class scores ZERO, and the rows stay UNQUALIFIED.** A campaign that seeds only
   the class it hopes will convict cannot tell a working instrument from a loud
   one.
3. **A class not reachable at its `R!` cells** (a `NOT SEEDED` self-declaration,
   or a lane, length or parity undischarged under `WO-0073` §5) → the class is
   **void**: zero kills, **no claim about any row in either direction**.
4. **A class red at an `R!` unit but through `assert_monitors_clean` or through
   `test bug --`** → §5.4 and §5.5 govern; the class's kill is not counted from
   that red.
5. **A rendering that is neither disclosed branch of its disclosure** → every
   cell of that class is `U`, scored on §5.2's membership rule where one applies
   and otherwise reported rather than scored.
6. **Two classes delivered in one diff, or the members of collision 1 rendered by
   the same change** → **both are unscoreable**, reported as a manifest defect
   and not as a result.
7. **IC-L2, IC-L3, IC-L1(T) or IC-L4(F) red at an `R!` cell carrying a datapath
   message** — item 3's count, or any of item 4's word-count, `tkeep`, `tlast`,
   `tuser` or positional-content messages, or at unit 2 a tagger error naming an
   octet count, an alignment or a front offset — → the rendering perturbed the
   datapath, the class is **out of specification: reported, not scored**, and
   disposition 3's "no claim in either direction" governs.
8. **A red at any of the 79 non-M03 behavioural units** → a **scope finding**
   against the manifest. **A red at `test/hardcaml_ethernet/`'s single unit, or a
   failing build step** → a **build finding**, never behavioural.
9. **No kill anywhere is evidence about M03-L3's or M03-L4's own assertions**
   (§6.1, §6.2). This disposition binds the verdict, not the manifest.

---

## 9. Mutant-owned quantities — inequalities with named directions

| quantity | sealed | direction |
|---|---|---|
| `<n>` in `… <n> tlast words observed` under **IC-L1(D)** | `< 10 000`, derived **5 000** | **fewer** — the odd frames are never accepted |
| the same under **IC-L4(S)** | `< 10 000`, derived **5 000** | **fewer** — each even frame loses the word carrying its mark |
| the same under **IC-L5** | `> 10 000`, derived **20 000** | **more** — a second `tlast` per frame. **This direction is the only thing separating IC-L5 from the pair above at a shared cell** |
| `<n>` in `latencies = [<n>], expected [16]` under **IC-L2** | `> 16`, derived **24** | **later** — the class adds a cycle; a value below 16 is not this class |
| `<n>` in `latencies = [16; <n>], expected [16]` under **IC-L3** | `> 16`, derived **24** | **later**, and the leading `16` is **not** mutant-owned: it is REQ-005's own constant surviving on the octets the class does not touch |
| `<n>` in `… but <n> octets were emitted` under **IC-L5** at unit 2 | `> 60`, derived **64** | **more** — a duplicated word adds exactly its own `tkeep` extent |
| the observed **front offset** h at every frame | **not mutant-owned** — `∈ {8, 12}` | the tagger computes h from `in_times`, the bench's own schedule; a third value is impossible and its appearance is a finding, never a rendering fact |
| `frames_compared` in unit 1 | **not mutant-owned** — `= 10 000` | **bench-supplied**: one call per schedule frame. Never evidence the design delivered a frame |
| `octets_compared` in unit 1 | **not mutant-owned** — `= 600 000` | implied by item 4 having passed at every frame |
| the **strobe set** over either unit | **not mutant-owned** — `= ∅` | §8 fixes the error-injection rate at **zero in this run** and `WO-0070` §4.2 closed all five strobes' conditions strobe by strobe. Any name appearing belongs to no class here |
| the **number of `%expect` block bytes** | **not mutant-owned** — `= 0` | both blocks are `[%expect {||}]`; these units assert, they do not print. A raise leaves the block untouched, **the diff is silent, and the raised message alone scores the cell** |
| **units reddening under a class** | `⊆` the class's **RULE** at §3.4 | a red outside the rule is a finding: either my rule was wrong or the diff reaches further than the class it names |

**Five of the twelve are specification-fixed or bench-supplied and are sealed as
equalities on purpose**; calling them mutant-owned would be buying an
unfalsifiable seal. **The `frames_compared` row is an equality for a different
reason from the others** — the bench supplies it — and is stated separately so no
reader takes it for a design fact.

---

## 10. Reasoning for the cells that are not obvious

**(a) Why the 57 non-L M03 units are not enumerated, and why that is the
improvement rather than the shortfall.** `FINDING WO-0066-3` scored three
MUST-STAY-GREEN violations against me because my seal enumerated where the
auditor's manifest ruled, and the rule was right. §3.4 states a rule per class in
stimulus terms and §3.5 names the instances I worked. **Where they disagree the
rule governs**, and a red the rule selects is blast radius rather than a finding
against either side.

**(b) Why item 3 is the first DUT-observable check, stated because three classes
depend on it.** `run` calls `Arrival.check` before driving; the frame count,
`start_lanes` and `start_spacings` comparisons read the **schedule**. Not one of
those four reads a DUT output. **The first byte of design behaviour any
assertion in unit 1 touches is `delivered_samples`' `tlast` count.**

**(c) Why no timing class in this campaign changes the frame count.** §2.2's
nine cycles of drain headroom. A one-cycle delay leaves frame 9999's word 7 at
cycle 105 001 against a last driven cycle of 105 009, so item 3 still sees
10 000 and the count cell and the latency cell stay independent. **A class
delaying by ten or more cycles would collapse them**, and that is not any of
these five.

**(d) Why the h = 8 class is asserted before the h = 12 class, and why it
matters.** `assert_class … (find_class 8)` is sequenced before
`assert_class … (find_class 12)` by `;`. IC-L1(T) touches **only** the odd,
lane-4 frames, so h = 8 passes whole and the h = 12 message speaks — which is
what distinguishes IC-L1(T) from IC-L2 and IC-L4(F) at the same item.
**`find_class` itself raises only if a class is absent**, and no class can be
absent: h is schedule-derived and both lanes deliver.

**(e) Why unit 2 is green under IC-L1 and IC-L4, derived from the stimulus and
not from a category.** Every L5 run is `one_frame` — a single frame on its own
`Bench.t`. There is no preceding terminate character for a start word to be
adjacent to, and no following start character for a tail word to collide with.
**Both classes' conditions are empty sets there.** That is a stimulus fact, and
it is what makes those greens load-bearing.

**(f) Why the `%expect` blocks do not move and no cell is scored on one.** Both
units carry `[%expect {||}]` and are empty by construction. A raise leaves the
block untouched, so the promotion-loop signature (`RV-0070-VERDICT` §2) does not
arise: **a red here fails step 6, never step 8**, and the raised message alone
scores the cell.

**(g) The instrument families this campaign probes, stated because the scorecard
must state it.** Four, and only four: the **`tlast`-count check** (IC-L1(D),
IC-L4(S), IC-L5 at unit 1); the **per-front-offset-class record check**
(IC-L1(T), IC-L2, IC-L3 at 4 ∈ R, IC-L4(F)); the **per-run latency-class check**
at L5 (IC-L2, IC-L3); and the **tagger's own per-frame error list** (IC-L5 at
unit 2). **The empty-strobe-set check, the sequence read-back, the whole-run
accessors and the standing monitors are probed by nothing** — the first by
choice (`WO-0073` §4 item 6), the other three because nothing can reach them.

**(h) Why `Latency.errors` being empty under IC-L2 is a prediction and not an
absence.** It is three separate arithmetic facts — closure, ceiling, pair rule —
each evaluated in §4.2 at the class's own derived values. **A campaign that
merely expected silence there would have no way to tell a correct silence from a
rendering that also broke the tagger.**

---

## 11. Bounds this campaign does NOT close, named before the result

1. **`M03-L3` and `M03-L4` are not scored on their own instruments and cannot
   be** (§6.1, §6.2). This survives any outcome of this round.
2. **REQ-014's `tstrb` half is untouched** (§6.3) and is a standing-monitor
   question, not a family-L one.
3. **REQ-020's reordering half is unfalsifiable at this stimulus** (§6.4).
4. **Item 5's empty-strobe-set check has no seeded class**, on enumerability
   grounds stated in `WO-0073` §4 item 6. **A green there this round means
   nothing**, and no verdict may cite it.
5. **A kill proves the assertion convicts, never that the bench is a general
   detector of the class.** IC-L2 and IC-L5 are detected across most of the M03
   bench; **this bench was not blind to either** and no verdict may imply it was.
6. **Seventeen of unit 2's eighteen members are shadowed** (§5.3) and are not
   independently observed in a passing-to-failing run.
7. **The `P1-module-ready` line-rate-stress line is not signed by any outcome
   here** (`RV-0070-VERDICT` §4).
8. **Nothing here bears on families J, K or M, on the co-simulation anchor, or on
   the four campaigns still owed before any `SO-`.**

---

## 12. Pass criteria

1. **Each class reddens exactly its `R!` cells**, with §4's verbatim strings for
   the branch its manifest disclosed, and **stays green at every `G` and `G✱`**.
2. **No unit outside the class's own RULE (§3.4) reddens** — except at the cells
   §5 marks `U`, where §5's rules govern. Outside M03: the **79** behavioural
   units hold, and a red at `test/hardcaml_ethernet/` or a failing build step is
   read as a **build** finding (§0).
3. **The unmutated control is green at the base SHA**, with its CI run id and
   conclusion quoted. **CI is the authority** (ADR-0005).
4. **Kills are counted per class**: five classes, at most **five** kills; and a
   carrier kill and a row bound to that carrier are **one** kill
   (`WO-0073` §11).
5. **All six disclosures are answered before the run.** A branch inferred by me
   from a scorecard is not a disclosure and the affected cells score as `U`.
6. **The verdict states §6.1's and §6.2's unreachability findings whatever the
   score is.** They are the round's own contribution and they are not contingent
   on a kill.

---

## 13. Not to be told

§0's MUST-STAY-GREEN sets, §1's row prefixes, §2's orders, derived-number table,
observation order and residue map, §3's matrix and its rules, §4's verbatim
strings, §5's UNWORKED adjudication rules, §6's blindness and unreachability
arguments in their entirety, §7's named collisions and their discriminators,
§8's dispositions, §9's inequality table, §10's reasoning, §11's bounds.

**Freely told, and told in `WO-0073`**: the five classes and the specification
sentence each is derived from; the six mandatory disclosures; the denominator and
the `test/cosim/` correction; the instrument survey and the rule form; the six
declarations of what the campaign cannot score; the reachability standard; the
datapath signature and its domain; the allowlist and manifest bars; the base SHA
and the ordering rule; the two bounded classes' scoring rules; the mutant-owned
axes; the *existence* of two collisions and what they cost the manifest; the
era-wide scorecard rules; the price; the non-closures and carriers; the
weighting; the return format.
