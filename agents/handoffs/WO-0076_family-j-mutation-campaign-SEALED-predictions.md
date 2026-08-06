# WO-0076 SEALED: dv_lead's frozen predictions for the family-J mutation campaign

> **SEALED.** The auditor must not open this file until every diff is delivered
> and every scorecard is in hand — and under `WO-0076` §7's allowlist, **all of
> `agents/**` is out of bounds for the campaign's duration**, this file included
> and absolutely.

- **State**: **FROZEN — unopened.**
- **Frozen against**: **the commit that stages this seal and its packet.** Not
  its parent — the corrective drafting rule adopted at `WO-0073-VERDICT` §7 after
  `FINDING WO-0073-M1`, applied for the third time. I cannot state its hash: I
  never run git (PROTOCOL §2), and it has none until the orchestrator creates it.
  The auditor quotes the hash it applied to (`WO-0076` §7.3 item 6), and any
  disagreement is a finding **before** the campaign runs.
- **Frozen by**: dv_lead, `J-dv_lead-0140`, **before any diff existed**, in the
  commit that stages this file beside its packet — R-SEAL-1 (PROTOCOL §10,
  ADR-0016).
- **Second copy**: the class → `R!`-unit **row mapping** (not the message
  strings, not the matrix) is restated in `J-dv_lead-0140`.
- **Standing rule 1**, from `RV-0055` FINDING G-1: every sealed cell that rests
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
- **Standing rule 5** (`FINDING WO-0066-3`, retained after it held at `WO-0073`
  and `WO-0074`): outside the units this seal works cell by cell, a class's
  predicted red set is stated as a **RULE in stimulus terms**, with worked
  instances named beneath it. **Where the rule and the instance list disagree,
  the RULE governs.**
- **Standing rule 6** (`FINDING WO-0074-S1`, carried in as a bar): **every rule
  states its complete conjunct list** — including every gate the rendering may
  *not* remove — so no rule describes a class the packet forbids.
- **Standing rule 7 — NEW THIS ROUND, and it is what a capability family
  forces**: a cell may be scored as qualifying a J row **only** if the message
  that speaks is an assertion of **that row's own observable**. A message from a
  monitor arm (`assert_monitors_clean`), from a bench-side stimulus check, from
  the driven-window check or from another family's unit qualifies the J row **not
  at all**, however red.

---

## 0. The denominator, re-measured at the freeze

Measured at this tree, **not carried forward**:

```
    3  test_m03_a.ml    7  test_m03_b.ml    4  test_m03_c.ml    3  test_m03_d.ml
    4  test_m03_e.ml    4  test_m03_f.ml    7  test_m03_g.ml    4  test_m03_h.ml
    5  test_m03_i.ml    3  test_m03_j.ml    2  test_m03_k.ml    2  test_m03_l.ml
    8  test_m03_n.ml    3  test_m03_structural.ml
  ---
   59  test/xgmii_rx_64/ (the M03 bench)
  139  test/ (repository-wide, OCaml units, --include=*.ml)
  141  test/ (the OLD directory-scoped matcher — FINDING M-4's contamination,
             now REPAIRED in tools/dv_checks.sh, and grown from 140 to 141
             because the plan absorbed the family-M campaign)
```

**59 M03 units; 139 repository-wide; 80 non-M03**, by what a red there would
mean:

| set | units | a red there means |
|---|---|---|
| `test/monitors/` 37, `test/xgmii/` 25, `test/golden/` 11, `test/axi64_probe/` 3, `test/xgmii_probe/` 3 | **79** | the manifest reached outside its own file, **or** broke the `cfg_rx_enable` = 1 path — a **scope finding** either way |
| `test/hardcaml_ethernet/` | **1** | the mutant **does not compile** — a **build finding**, never behavioural |
| `test/cosim/` | **0 units** | a build-finding home and a behavioural detector, but **blind by stimulus** here (§6.1) |

**MUST-STAY-GREEN outside M03, every class, every branch: 79 behavioural + 1
build-level.**

**The enable census, measured at this tree and not recalled** (`FINDING K-3`):
of the 59 M03 units, **exactly four drive `cfg_rx_enable` away from
`Enable.high`** — `M03-J1` (`test_m03_j.ml:169`), `M03-J2` (`:279`), `M03-J3`
(`:488`, two lane members) and `M03-N4` (`test_m03_n.ml:1256`, two lane
members). **The other 55 are MUST-STAY-GREEN under every class in this
campaign, and the guarantee is one conjunct: enable-high invariance.**

**Family J owns 3 of the 59.** `M03-N4` is family N's, scored at `WO-0066`, and
every red it takes here is blast radius (§3.3).

---

## 1. The row prefixes, which are how the scorecard is read

Every message below is `<row prefix>: <body>`, composed by each file's own
`fail row msg = failwith (String.concat [ row; ": "; msg ])`. The prefixes at
the base SHA:

| unit | prefix, character-exact |
|---|---|
| `M03-J1` | `M03-J1` — **no lane suffix**, one member |
| `M03-J2` | `M03-J2` — **no lane suffix**, one member |
| `M03-J3` | `M03-J3 (lane 0)`, then `M03-J3 (lane 4)` |
| `M03-N4` | `M03-N4 (lane 0)`, then `M03-N4 (lane 4)` |

**No prefix in this campaign is content-dependent**, unlike `M03-E1`'s at
`WO-0074`: all four are composed from constants and the lane integer. Every
`R!` cell below therefore carries `lane 0` or no suffix at all, and a red
carrying `lane 4` at a two-member unit means every lane-0 member was green —
itself a finding under that class's own rule (§5.3).

**Encoding note, as at `WO-0074`**: the bodies below are the OCaml literals as
the runtime composes them, with line-continuation backslashes elided (as the
compiler elides them). Where a body contains `—` (U+2014) the promoted source
prints the decimal escapes `\226\128\148`; comparison is against the decoded
string.

---

## 2. The orders every REQUIRED cell depends on

### 2.1 The three instrument kinds

Only the **DUT-observable** assertions can convict a design. The **bench-side
stimulus derivations** (schedule checks, frame counts, the derived change cycle,
the lane split, `Injection.outcomes`, both landing checks) and the
**driven-window checks** (`sample.enable` against an independently written
predicate) are evaluated on the bench's own model of the run and **no RTL
mutation can move them** (§5.5). The `Bench.Enable` pre-scan guard and its
structural witness are the same kind and are unreachable twice over (§6.3).

### 2.2 `M03-J1` — `run_j1`, in order

> stimulus derivation (bench-side: `Arrival.check`; 101 frames; frame 100's start
> cycle **1051**; change cycle **1050**; no start character at 1050; the 50/50
> lane split; both lanes present) → **(A) the disabled-window silence scan** —
> for every sample with `cycle ≤ 1050`, in cycle order, **`tvalid` checked
> before the strobe list** → **(B) the driven-window check** (bench-supplied) →
> the accounting calls (100 × `frame_in_exempt`, then `account_clean_frame`
> frame 100) → **(C) the control run at `Enable.high`**: 101 `tlast` words → 101
> segmented frames → sequence numbers 0 … 100 in order → **(D)
> `assert_monitors_clean`** on the disabled bench, then on the control bench.

**(A) is the FIRST DUT-observable assertion in the unit**, so a red there is not
a compound statement and (C) is shadowed by it. **The unit contains no assertion
that reads frame 100's delivered stream**: the only instrument that sees frame
100 refused is the **latency tagger**, fed by `account_clean_frame` and reported
by (D)'s tagger arm.

### 2.3 `M03-J2` — `run_j2`, in order

> the same shared stimulus derivation → **(A) the delivered-word count** (`= 8`)
> → per word: **cycle** (`start_cycle_100 + 3 + m`) → **`tkeep`** → **`tlast` /
> `tuser`** → **(B) the delivered octets** → **(C) the sequence number**
> (provenance) → **(D) the empty strobe set** → accounting →
> `assert_monitors_clean`.

### 2.4 `M03-J3` — `run_j3 ~lane`, lane 0 then lane 4, in order

> construction and schedule checks (bench-side: `start_cycle0` **1**,
> `terminate_cycle0` **10**, the terminate lane, `start_cycle1` **11** at lane 0
> and **12** at lane 4, the change cycle **5** strictly inside frame 0, no start
> character at 5) → **(A) the REFERENCE run at `Enable.high`**: 2 `tlast` words
> → 16 delivered words → delivered octets → empty strobe set → **(B) the
> disabled run's word count** (`= 8`) → **(C) the tuple comparison** against the
> reference's first eight words, over `(octets, tkeep, tlast, tuser)` → **(D)
> the cycle comparison** against the same → **(E) the disabled run's `tlast`
> count** (`= 1`) → **(F) the refusal check** (no delivered word at or after
> `start_cycle1 + 3`) → **(G) the empty strobe set** → the driven-window check
> (bench-supplied) → accounting → `assert_monitors_clean` on the disabled bench,
> then the reference bench.

**(A) runs at `Enable.high` and speaks first.** Every scored cell in this unit
is therefore a **compound statement**: the class's own effect **and** the entire
enable-high path unmoved on the same schedule in the same unit. **(C) is the
only assertion in the whole bench that compares a disabled run against a
reference run**, and exactly one class in this campaign reaches it.

### 2.5 `M03-N4` — `run_n4`, lane 0 then lane 4, in order

> `Injection.outcomes` cross-check and both landing checks (bench-side) → the
> three named enable facts and the driven-window check (bench-supplied) →
> **(A) the delivered-sample cycle list** → frame A's word count, `tkeep`,
> `tlast`, `tuser`[0] = 1, content → frame C's words, content, sequence →
> **(B) the exact strobe set over the whole run** → accounting → the `ΔC = 3`
> check → `assert_monitors_clean`.

**`M03-N4` is family N's row.** Every red it takes in this campaign is blast
radius (§3.3) and qualifies no J row in either direction.

### 2.6 The derived numbers every REQUIRED cell prints

| number | derivation | fixed by |
|---|---|---|
| `M03-J1`'s **cycle 4** | frame 0's start octet time is **8** (`frames_at ~lane:0`), so its start cycle is **1**; §6.1's first output word is at `start_cycle + 3` | **specification**, not the mutant |
| frame 0's report span at `M03-J1`, **cycles 1 … 11** | start cycle 1; 60 delivered octets in 8 words; the last at `1 + 3 + 7` | **bench-supplied**; bounds a mutant-owned cycle |
| `M03-J2`'s **8** and `M03-J3`'s **8** and **16** | 60 delivered octets per frame → 8 words; two frames → 16 | **specification** |
| **808** | 101 frames × 8 words | **specification**, given IC-J1's own consequence |
| `M03-J3`'s frame-0 word cycles, **4 … 11**; the change at **5** | `start_cycle0` 1 + 3 + m; the unit's own derived change cycle | **bench-supplied** |

---

## 3. The matrix

`R!` = REQUIRED red **and scored**. `G` = MUST STAY GREEN. **`G!`** = a
**load-bearing** required green — the cell carries a measurement, and a red there
changes what may be claimed (§8 disposition 2). `G✱` = green by blindness (§6).
`r` = predicted red by the class's own **rule**, **UNWORKED or worked-but-
unscored**, contributing **zero** kills. `M` = a predicted red arriving through a
**monitor arm**, qualifying nothing (standing rule 7). Anything off-pattern is a
**finding**.

### 3.1 The four units, worked

| unit (row it carries) | IC-J1 | IC-J2 | IC-J3 | IC-J4 | IC-J5 |
|---|---|---|---|---|---|
| **M03-J1** (M03-J1) | **R!** | **R!** | **G!** | **M** | **G!** |
| **M03-J2** (M03-J2) | *r* | *r* | **G!** | **R!** | **G** |
| **M03-J3** (M03-J3) | *r* | *r* | **R!** | **G!** | **R!** |
| **M03-N4** (M03-N4, family N) | *r* | *r* | *r* | *r* | **G!** |

**The `G!` cells are this round's own measurements and there are six of them.**

- `M03-J1` green under **IC-J3** is `DECLARATION J-D1`: a silence assertion
  cannot separate *never admitted* from *admitted and muted*.
- `M03-J2` green under **IC-J3** is **`WO-0067` §6's honest-kill withdrawal,
  measured** — the reason this campaign exists in the form it has.
- `M03-J3` green under **IC-J4** separates a re-enable defect from a
  continuous-sampling one, in the direction the plan's correction asserts.
- `M03-J1` and `M03-J2` green under **IC-J5** say the class keys on a **1 → 0**
  change with a frame **open**, and not on a change as such.
- `M03-N4` green under **IC-J5** says the marking is not sticky and does not
  reach a frame admitted after the change.

**`M03-J1` under IC-J4 is `M`**, not `R!` and not `G`: the row's own assertions
are all predicted green and the unit is predicted to redden **only** through
`assert_monitors_clean`'s latency-tagger arm. §5.6 fixes the adjudication for all
three outcomes.

### 3.2 Kills, per class

| class | kills if §8 disposition 1 holds |
|---|---|
| IC-J1 | **1** |
| IC-J2 | **1** |
| IC-J3 | **1** |
| IC-J4 | **1** |
| IC-J5 | **1** |
| **campaign maximum** | **5** |

**Kills are counted per class.** IC-J1's predicted reds across four units are
**one** kill, never four.

### 3.3 The rows these kills qualify — and the reds that qualify nothing

| class | qualifies | reds that are BLAST RADIUS and qualify nothing |
|---|---|---|
| **IC-J1** | **`M03-J1`**, on its no-output-word clause (REQ-810's first sentence) | `M03-J2`, `M03-J3`, `M03-N4` — all three reddening through the **same** ungated admission, so **`M03-J2` and `M03-J3` are NOT qualified** by any of them, and neither is `M03-N4` |
| **IC-J2** | **`M03-J1`**, on its no-strobe clause | `M03-J2`, `M03-J3`, `M03-N4` — and the `M03-J3` red is at that row's own strobe clause, which **still qualifies nothing**, because the class was seeded against `M03-J1`'s geometry (§11 of the packet) |
| **IC-J3** | **`M03-J3`** | `M03-N4` |
| **IC-J4** | **`M03-J2`**, on its honest kill and on nothing else | `M03-N4`; and `M03-J1`'s monitor-arm red, which qualifies nothing by standing rule 7 |
| **IC-J5** | **`M03-J3`**, on its tuple comparison | — (the rule selects one unit) |

**No class in this campaign qualifies `M03-J4`, and none can** (§6.2). **No class
qualifies `M03-J2` on the withdrawn continuous-sampling cell**, whatever a
scorecard shows — the plan's prohibition (`J-dv_lead-0124`) is absolute and this
table is where it is enforced.

### 3.4 The rules, with their COMPLETE conjunct lists (standing rule 6)

Every rule's **first conjunct** is the same and is measured (§0): *the unit
drives `cfg_rx_enable` low at some cycle of its run*. Four units satisfy it and
**no rule here can select a fifth.**

| class | RULE — the class reddens a unit iff … | conjuncts the rendering may NOT remove |
|---|---|---|
| **IC-J1** | … the unit drives the enable low **across a start character** the specification requires refused, **and** the unit asserts either the absence of output words in that window or a delivered-word count over the whole run | the `cfg_rx_enable` = 1 path **entire**; the report path (no strobe is added or removed); the emission path's timing (`m + 3`); every frame the specification requires delivered |
| **IC-J2** | … the unit drives the enable low **across a start character** the specification requires refused, **and** the unit asserts an exact strobe set or the absence of strobes over a window containing it | the admission gate (**retained** — no word may appear); the `cfg_rx_enable` = 1 path entire; every strobe of an **admitted** frame |
| **IC-J3** | … the unit drives a **1 → 0** change while a frame is **open**, **and** the unit asserts that frame's delivered words | the `cfg_rx_enable` = 1 path entire; every frame whose whole extent lies inside an enabled window; the report path |
| **IC-J4** | … the unit drives a **0 → 1** change **exactly one cycle** before a start character it requires admitted, **and** the unit asserts that frame's delivery (directly or through the latency tagger) | the `cfg_rx_enable` = 1 path entire; every frame admitted two or more cycles after a change; every refused frame's refusal |
| **IC-J5** | … the unit drives a **1 → 0** change while a frame is **open**, **and** the unit asserts that frame's `tuser`[0] against a reference run or against a pinned value | the `cfg_rx_enable` = 1 path entire; that frame's word count, cycles, `tkeep` and octets; the report path; **and the marking must not be sticky** — no frame admitted after the change may be marked |

### 3.5 Worked instances beneath the rules

- **IC-J1** — the rule's set is **`{M03-J1, M03-J2, M03-J3, M03-N4}`**, measured.
  **All 55 other M03 units and all 79 non-M03 behavioural units are
  MUST-STAY-GREEN**, and the guarantee is the first conjunct of the retained
  column: a unit that never drives the enable low cannot see a defect in the
  enable's gate.
- **IC-J2** — the same four, for the same reason; the class adds a report only
  where a refusal happens.
- **IC-J3** — the rule's set is **`{M03-J3, M03-N4}`**: they are the only units
  in the bench that drive a **1 → 0** change with a frame open. **`M03-J1` and
  `M03-J2` are WORKED and predicted GREEN, and they are the boundary**: their
  only change is **0 → 1**, in a gap between frames, with nothing in flight —
  measured from the unit's own derivation (frame 99 closes at cycle **1049**;
  the change is at **1050**; frame 100 starts at **1051**).
- **IC-J4** — the rule's set is **`{M03-J2, M03-N4}`** for its own assertions,
  plus **`M03-J1`** through the latency tagger. **`M03-J3` is WORKED and
  predicted GREEN**: its schedule is `changes ~initial:true [(5, false)]` and
  contains **no** 0 → 1 change at all, so there is no re-enable for the class to
  mishandle. That is a stimulus fact, not a category.
- **IC-J5** — the rule's set is **`{M03-J3}`**, measured: `M03-N4` also drives a
  1 → 0 change with frame A open, but **frame A's `tlast` word already carries
  `tuser`[0] = 1** (REQ-110's abort), so the class's own marking changes nothing
  observable there. That green is the `G!` that proves the marking is not
  sticky.

**Adjudication for every `r` cell, fixed here**: a **red is predicted blast
radius, contributes zero additional kills, and is not an unnamed-unit finding**;
a **green is a FINDING** — a unit selected by the class's own rule cannot see the
class — and is adjudicated per row rather than scored against the class.

---

## 4. The REQUIRED cells, verbatim

`<n>` marks a **mutant-owned** integer, sealed at §9 as an inequality; every
other character is exact.

### 4.1 IC-J1 — `M03-J1`, the disabled-window silence scan, `tvalid` arm

```
M03-J1: cycle 4: tvalid high during the disabled window
```

**`4` is SPECIFICATION-FIXED, not mutant-owned** (§2.6): frame 0's start octet
time is 8, its start cycle is 1, and §6.1 puts the first output word at
`start_cycle + 3`. The scan raises at the **first** violating sample and `tvalid`
is checked **before** the strobe list within each sample, so this message —
and not §4.2's — is the one that speaks under this class.

### 4.2 IC-J2 — `M03-J1`, the same scan, strobe arm

```
M03-J1: cycle <n>: an error strobe pulsed during the disabled window
```

`<n>` is **mutant-owned**, sealed `1 ≤ n ≤ 11` — frame 0's own span (§2.6) —
with **two named derivations**: a rendering that reports at the refused start
character's own cycle gives **1**; one that reports at that frame's would-be
report cycle gives **11**. **D-J2a is what distinguishes them**, and a value
outside the span means the rendering does not report per refused frame at all.
**No output word appears anywhere in the window under this class**, so §4.1's
message cannot precede it.

### 4.3 IC-J3 — `M03-J3`, the disabled run's word count

```
M03-J3 (lane 0): disabled run: expected exactly 8 delivered words (frame 0 only), got <n>
```

`<n>` is **mutant-owned**, sealed `< 8`, derived **1** — frame 0's words fall on
cycles 4 … 11 and the change is at cycle 5, so a gate on emission leaves the
cycle-4 word alone (a rendering with one cycle of gate latency gives **2**).
**Direction: fewer.** The whole reference run (§2.4 (A)) is predicted green under
this class, so this red is the compound statement §2.4 describes.

### 4.4 IC-J4 — `M03-J2`, the delivered-word count

```
M03-J2: expected 8 delivered words for frame 100, got <n>
```

`<n>` is **mutant-owned**, sealed `< 8`, derived **0** — frames 0 … 99 stay
refused (the class does not touch the disable) and frame 100 is refused too, so
the run delivers nothing at all. **Direction: fewer.**

### 4.5 IC-J5 — `M03-J3`, the tuple comparison

```
M03-J3 (lane 0): frame 0's delivered (octets, tkeep, tlast, tuser) tuples differ between the disabled and reference runs
```

**No integer: this cell is exact in every character.** It is reached only
because the class changes nothing the three assertions before it read — the
reference run, the disabled run's word count (**8**) — and it is the only cell
in this campaign raised by an assertion that compares two runs of the same
schedule. The differing element is `tuser` on the eighth word, which
`Test_m03_a.tuple_of_sample` carries as its fourth component.

---

## 5. The UNWORKED and unscored cells, with adjudication pre-fixed

### 5.1 A rendering that is neither disclosed branch

If a manifest delivers a rendering that is neither branch of a disclosure — an
IC-J1 that also changes the emission timing, an IC-J4 that also delays the
disable (D-J4b), an IC-J5 that marks by strobe alone (D-J5a) — every cell of
that class is `U` and disposition 5 governs.

### 5.2 The blast-radius cells, worked where they are worth working

| class | unit | message |
|---|---|---|
| IC-J1 | `M03-J2` | `M03-J2: expected 8 delivered words for frame 100, got <n>`, `<n>` sealed **`> 8`, derived 808** (101 × 8) — **§7 collision 1** |
| IC-J1 | `M03-J3` | `M03-J3 (lane 0): disabled run: expected exactly 8 delivered words (frame 0 only), got <n>`, `<n>` sealed **`> 8`, derived 16** — **§7 collision 2** |
| IC-J2 | `M03-J2` | `M03-J2: an error strobe pulsed` |
| IC-J2 | `M03-J3` | `M03-J3 (lane 0): disabled run: an error strobe pulsed — frame 0 should close cleanly on its own /T/ and REQ-810 gives the refused frame 1 no strobe at all` |
| IC-J2 | `M03-N4` | `M03-N4 (lane 0): expected exactly one strobe (error_start_without_terminate at A's own report cycle), observed <n>`, `<n>` sealed **`> 1`, derived 2** |
| IC-J1, IC-J3, IC-J4 | `M03-N4` | `M03-N4 (lane 0): delivered-sample cycles are [...], expected [...]` — **UNWORKED**: the printed list is mutant-owned and no cell reads it |

**Every one of these qualifies nothing** (§3.3). A green at any of them is a
finding under standing rule 5, adjudicated per row.

### 5.3 Shadowed members and shadowed assertions

`M03-J3`'s and `M03-N4`'s **lane-4 members** are structurally unobservable in a
passing-to-failing run: `run_j3 ~lane:0` and `run_n4 ~row:"M03-N4 (lane 0)"` are
called first and raise first. **Adjudication, fixed here**: a unit's cell is
scored on the **lane-0** member; a lane-4 string is scored **only** if the
scorecard reports it, which requires lane 0 to have been green — itself a finding
under the class's own rule. R-DISC-1's per-lane discharge is still required: **a
lane discharged term by term and merely unobserved is recorded as unobserved,
never as a miss and never as a pass.**

**Assertions shadowed in every class of this campaign**, recorded so that no
scorecard implies they were probed: `M03-J1`'s control run (its three
assertions); `M03-J2`'s per-word cycle, `tkeep`, `tlast`/`tuser`, octet and
sequence-number assertions; `M03-J3`'s reference-run four, its cycle comparison,
its `tlast` count and its refusal check. **Counted at the base tree: the three J
units carry 22 DUT-observable assertions and this campaign's five classes reach
7 of them** (§10(g)).

### 5.4 A red arriving through `assert_monitors_clean`

A message of the form `<prefix>: protocol monitor unclean:`,
`<prefix>: conservation monitor unclean:`, `<prefix>: strobe monitor unclean:`
or `<prefix>: latency tagger unclean:` means the unit's **own** assertions all
passed and a monitor spoke afterwards. **By standing rule 7 such a red qualifies
no J row.** It is reported, it may carry a measurement (§5.6), and the class's
kill is never counted from it.

### 5.5 A red at a bench-side check

`M03-J1`/`M03-J2`'s stimulus derivation (the 101-frame count, frame 100's start
cycle **1051**, the change cycle **1050**, the no-start-character check, the
50/50 lane split, `start_lanes`), `M03-J3`'s construction block, `M03-N4`'s
`Injection.outcomes` cross-check and both landing checks, every
`test bug —` message, and **both driven-window checks** (`cycle <n>: enable =
<b>, expected <b>`) are evaluated on the bench's own model of the run, before or
independently of the DUT. **No RTL mutation can move them.** Such a message in
this campaign therefore means something other than a seeded class: it is
reported, it scores nothing in either direction, and it is a finding of its own
kind. **The `Bench.run` M03-J4 guard's refusal message
(`Bench.run: cfg_rx_enable changes on the same cycle as a start character …`) is
the same kind and is doubly unreachable** (§6.3).

### 5.6 `M03-J1` under IC-J4 — the three outcomes, pre-fixed

1. **Red at `M03-J1: latency tagger unclean:` with every one of the row's own
   assertions green** → **PREDICTED**. It measures `WO-0076` §4 item 8: the unit
   asserts nothing about frame 100 and the catch belongs to a bench-supplied
   expectation. **Qualifies nothing**; IC-J4's kill is `M03-J2`'s. The tagger's
   **report body is UNWORKED** and no cell reads it.
2. **Red at one of `M03-J1`'s own assertions** → §4 item 8's derivation is wrong;
   the verdict records which assertion spoke and corrects it. The kill is still
   `M03-J2`'s.
3. **Fully green** → the unit is blind to the refusal of the frame its own title
   names, which is a **stronger** form of item 8 and is reported as such. **No
   claim about `M03-J1` is made in either direction from that green.**

---

## 6. GREEN BY BLINDNESS, and the structural unreachability this round declares

Every claim here is derived from committed text at the base SHA. **A green at
any of these is not vigilance and no verdict may cite it as evidence.**

### 6.1 The differential co-simulation anchor is blind by STIMULUS

Both producers hold `cfg_rx_enable` at **1 for the whole run** —
`test/cosim/ours_run.ml:142` (`i.cfg_rx_enable := Bits.vdd`) and
`test/cosim/tb_xgmii_rx_64.v:63` (`reg cfg_rx_enable = 1'b1`) — and the lane
drives one 64-octet good-FCS frame with no configuration change anywhere.
**Not one of the five classes is rendered at that stimulus**, so **the `cosim`
job is predicted `success` under all five and that green is worth nothing.**

This is `WO-0075`'s **bar 4** at its second instance and its purest: at family M
the blindness had three candidate causes (stimulus, mapping, grammar) and the
verdict named the wrong one; here there is only one, because the port under test
is never driven. **A strobe field, a cycle column or a wider canonical form would
change nothing.** Discharged only by a co-simulation stimulus that drives the
enable — which REQ-901's own class list does not contain.

### 6.2 `M03-J4` has no mutant — unconstrained, not merely unstimulated

SPEC-M03 §6.3 item 7 and carry-forward **C-14.5** leave the outcome of a
`cfg_rx_enable` change landing on a start character's own cycle **deliberately
unconstrained**, and §4.3's governing sentence covers only a start character
accepted *at least one cycle after* the change. **Every behaviour there is
conformant**, so every rendering is an **equivalent mutant by specification** —
a stronger disposition than `M03-M8`'s (no stimulus exists) and `M03-M9`'s (no
instance exists). Recorded so that a full scorecard is not read as full coverage
of §4.J.

### 6.3 The `Bench.Enable` guard and its witness are unreachable, twice

The M03-J4 pre-scan guard walks the driven cycles, compares `Enable.value_at`
against itself and reads the **driven word**, all **before** the DUT's outputs
are examined; the structural witness compares `Enable.change_cycles` against
literals and **drives no design at all**. **No RTL mutation can make either fire
or not fire.** And the standing fact stands unchanged by this round: the guard's
**entry** condition is mechanically witnessed, its **refusal** has never fired on
a real violation, so it remains a half-measured instrument.

### 6.4 REQ-802 / §9.1's reset value for `receive enable` is never observed

`Bench.create` drives `cfg_rx_enable` = 1 through the reset cycle and `run`
drives a value **every** cycle from cycle 0, so no run in this suite observes the
configuration field's own reset behaviour. A mutation of it is invisible here and
**no `SO-` may count §9.1's reset column as covered by family J.**

### 6.5 REQ-810's header-record prohibition has no instance at M03

M03 emits **no header record** — §4.1's output record is the `rx` stream and
five error strobes. `M03-J1`'s Observable carries the clause (*"no header
effect"*) and it is discharged **by the interface, not by a test**. Same
disposition as `M03-M9`'s.

### 6.6 The two plan cells this campaign convicts before it runs

- **`FINDING J-1`** — `M03-J1`'s Kills cell (*"gates the output but leaves the
  strobe path live"*) is **unreachable in its narrow reading**: the hundred
  refused frames are clean 64-octet good-FCS frames that owe no strobe under any
  rendering that merely leaves the detection machinery running. Only the cell's
  parenthetical — a design that **reports** refusal — is separable, and that is
  IC-J2. **Second half**: the row's no-output-word clause, which is REQ-810's
  first sentence and IC-J1's whole ground, has **no Kills cell at all**.
- **`FINDING J-2`** — `M03-J3`'s strobe clause is unfalsifiable in the
  **subtractive** direction: the in-flight frame is clean and owes no strobe, so
  a design **suppressing** an in-flight frame's own report is invisible there.
  The row convicts a design that **adds** one (IC-J2's radius), and the asymmetry
  is the finding. The carrier that convicts the suppressing design is `M03-N4`,
  family N's row, and **not** a family J qualification in either direction.

Neither finding moves a row; both are `ASSERT` and both stay `ASSERT`.

### 6.7 `DECLARATION J-D1`, stated before the run and measured by IC-J3

> **An observable expressed as an ABSENCE cannot distinguish a component that
> never produced the event from one that produced it and suppressed it.**
> `M03-J1` asserts that no output word appears while the enable is 0. A design
> that **admits** every refused frame and **mutes** its output satisfies that
> assertion exactly. Only a **positive comparison against a reference run** —
> `M03-J3`'s (C) — separates the two.

If `M03-J1` is green under IC-J3, this is measured; if it reddens, it is
withdrawn (§8 disposition 2). Either way **no verdict may cite `M03-J1`'s green
as evidence that frames were not admitted.**

### 6.8 The portable form, recorded because it is not about this bench

**When a family's rows drive a configuration input away from its default, the
family's whole convicting power is bounded by the number of tests that drive it
— and that number is invisible in a coverage count, because every other test
still exercises the module.** Four units of fifty-nine here. A coverage claim
over a configuration requirement must therefore state how many stimuli reach the
non-default value, or it is reporting the size of the suite instead of the size
of the evidence.

---

## 7. Collisions — derived by the cross product, with their discriminators

**Method (`FINDING WO-0074-S4`, carried in as a bar)**: the inventory below is
the cross product of **every class's predicted red set** (§3.5) with **every
scored cell** (§4), not an enumeration over the marked cells. **Both collisions
it found are cases where one class's blast radius lands on another class's
scored cell, and neither is visible from the scored cells alone** — the shape
`WO-0074`'s fourth collision had.

**Collision 1 — IC-J1's blast radius at `M03-J2` ≡ IC-J4's scored cell §4.4**,
character for character up to `<n>`.

- **Discriminator 1 — the DIRECTION of `<n>`**: `> 8` (derived 808) under IC-J1,
  `< 8` (derived 0) under IC-J4. This is the `WO-0073` IC-L1/IC-L4-versus-IC-L5
  situation repeated, and it is why §9 seals both.
- **Discriminator 2 — a MEASUREMENT**: `M03-J1` reddens under IC-J1 at §4.1 and
  is green at its own assertions under IC-J4 (§5.6).

**Collision 2 — IC-J1's blast radius at `M03-J3` ≡ IC-J3's scored cell §4.3**,
character for character up to `<n>`.

- **Discriminator 1 — the DIRECTION of `<n>`**: `> 8` (derived 16) under IC-J1,
  `< 8` (derived 1) under IC-J3.
- **Discriminator 2 — a MEASUREMENT**: `M03-J1` reddens under IC-J1 and is
  **green** under IC-J3 (the `G!` of §6.7); `M03-J2` reddens under IC-J1 and is
  green under IC-J3.

**Collision 3 — IC-J3's two disclosed branches (D-J3a: the gate MOVED versus the
gate ADDED)** at §4.3's cell, character for character **including the derived
integer 1**.

- **Discriminator: NONE that this bench produces.** Under *moved*, `M03-J3`'s
  frame 1 is admitted and muted; under *added*, it is refused. **Both deliver
  zero words for it**, so the count, the `tlast` count and the refusal check all
  read the same, and `M03-J1` and `M03-J2` are green under both.
- **Carried entirely by D-J3a.** This is `WO-0066`'s IC-D/IC-F situation,
  `WO-0073`'s collision 1 and `WO-0074`'s collision 1 at their **fourth**
  instance, and the protection is the same and is the whole of it.

**Near-collisions, named and costing nothing**: IC-J1, IC-J3 and IC-J4 all raise
`M03-N4`'s delivered-cycles message, with different lists, at a cell **no class
scores** (§5.2); IC-J2's `M03-J2` and `M03-J3` strobe messages are scored by no
class. **No two classes share a scored cell in a way the seal cannot separate.**

---

## 8. Pre-committed dispositions

1. **A class red at exactly its `R!` cells, with §4's verbatim strings for the
   branch its manifest disclosed, and green at every `G`, `G!` and `G✱`** → **the
   class is KILLED, one kill**, and the row §3.3 names is **QUALIFIED on that
   class and on nothing else**.
2. **A class red at its `R!` cell but also red at a `G!`** → the class's kill
   still counts where its own mechanism is unchanged, **but the measurement the
   green carried is NOT claimed**, and `WO-0076` §8.1 fixes which claim is lost
   per class: IC-J3 at `M03-J2` costs the honest-kill measurement (and opens a
   restoration question in `M03-J2`'s favour); IC-J3 at `M03-J1` withdraws
   `DECLARATION J-D1`; IC-J4 at `M03-J3` and IC-J5 at `M03-N4` mean the
   rendering keys wider than the class, **the reds are blast radius, the class
   scores ZERO, and the row stays UNQUALIFIED.**
3. **A class not reachable at its `R!` cell** (a `NOT SEEDED` self-declaration,
   or a lane undischarged under `WO-0076` §5) → the class is **void**: zero
   kills, **no claim about any row in either direction**. A self-declaration with
   the shared term quoted is a **result** in the register `WO-0074` used for
   `M03-M5`, not a void.
4. **A class red at an `R!` unit through `assert_monitors_clean`, through a
   bench-side check, or through the driven-window check** → §5.4 and §5.5 govern;
   the class's kill is not counted from that red and standing rule 7 forbids the
   qualification.
5. **A rendering that is neither disclosed branch** → §5.1: every cell of that
   class is `U`, reported rather than scored.
6. **Two classes delivered in one diff, or the two branches of collision 3
   rendered by one change** → **both are unscoreable**, reported as a manifest
   defect and not as a result. **A shared admission term across IC-J1 and IC-J3
   is NOT this case** (`WO-0073-VERDICT` §7 Q4).
7. **ANY class red at a cell outside its own §6 permission list** — a moved word
   count, cycle, `tkeep`, `tuser` or octet at a frame the class may not touch, or
   any red at a unit that never drives the enable low — → the rendering reached
   further than the class, **it is out of specification: reported, not scored**,
   and disposition 3's "no claim in either direction" governs.
8. **A red at any of the 79 non-M03 behavioural units, or at any of the 55 M03
   units that never drive the enable** → a **scope finding** against the
   manifest, and specifically a failure of **enable-high invariance** (D-J1b).
   **A red at `test/hardcaml_ethernet/`'s single unit, or a failing build step**
   → a **build finding**, never behavioural. **A red in `test/cosim/`** → a
   finding against §6.1's derivation, and a very interesting one, since no class
   here is rendered at a stimulus that holds the enable at 1.
9. **No kill anywhere is evidence about `M03-J4`, about the `Enable` guard or its
   witness, about REQ-802/§9.1's reset value, about REQ-810's header-record
   clause, or about the `frames_exempt` count's independence** (§6.2–§6.5). This
   disposition binds the verdict, not the manifest.

---

## 9. Mutant-owned quantities — inequalities with named directions

| quantity | sealed | direction |
|---|---|---|
| `<n>` at `M03-J1` under **IC-J2** (§4.2) | `1 ≤ n ≤ 11`, two derivations named (**1** or **11**) | **earliest violating sample**; the span is bench-supplied, the choice inside it is D-J2a's |
| `<n>` at `M03-J3` under **IC-J3** (§4.3) | `< 8`, derived **1** | **fewer** — a mute cannot add a word |
| `<n>` at `M03-J2` under **IC-J4** (§4.4) | `< 8`, derived **0** | **fewer** — a refused frame delivers nothing |
| `<n>` at `M03-J2` under **IC-J1** (§5.2) | `> 8`, derived **808** | **more** — **this direction is the only bench-side discriminator at collision 1** |
| `<n>` at `M03-J3` under **IC-J1** (§5.2) | `> 8`, derived **16** | **more** — **and at collision 2** |
| `<n>` at `M03-N4` under **IC-J2** (§5.2) | `> 1`, derived **2** | **more** — one added report beside frame A's own |
| `M03-J1`'s printed cycle **4** under IC-J1 (§4.1) | **not mutant-owned** — spec-fixed | §6.1's `m + 3` over the schedule's own first start cycle; a different value means the rendering also moved the fixed delay, and the verdict says which |
| the **name** of the strobe IC-J2 adds | **class-fixed and UNPRINTED at every `R!` cell** | REQ-810 forbids all five equally; the scored messages print a cycle or a count, never a name — which is why D-J2a exists |
| `M03-N4`'s printed delivered-cycle list | **mutant-owned and deliberately UNREAD** | no `R!` cell reads it; its appearance in a scorecard is information, never a cell, and a disagreement about it is not a finding |
| the latency tagger's report body under IC-J4 (§5.6) | **UNREAD** | the arm's *prefix* is the observation; the body is a diagnostic |
| every delivered word count, cycle, `tkeep`, `tuser` and octet outside a class's permission list | **not mutant-owned** — spec-fixed by REQ-016, REQ-103, §6.1, §7 | §6 of the packet as a seal: any movement is out of specification, not a rendering's prerogative |
| `sample.enable`, the derived cycles **1051**/**1050**/**5**/**11**/**12**, the 50/50 lane split, `Injection.outcomes`, both landing checks, the guard | **not mutant-owned** — bench-supplied | evaluated on the bench's own model before or independently of the DUT (§5.5) |
| **units reddening under a class** | `⊆` the class's **RULE** at §3.4, first conjunct included | a red outside the rule is a finding: either my rule was wrong or the diff reaches further than the class it names |

**Six of the thirteen rows are specification-fixed or bench-supplied and are
sealed as equalities on purpose**; calling them mutant-owned would be buying an
unfalsifiable seal. **Rows four and five are the ones to read twice**: they exist
only because the cross-product method found the two collisions, and without their
directions two of this campaign's five scored cells would have had **no
bench-side discriminator at all**.

---

## 10. Reasoning for the cells that are not obvious

**(a) Why `M03-J1`'s cell is `cycle 4` and not a mutant-owned integer.** The
silence scan raises at the first violating sample. Under IC-J1 the violation is a
delivered word, and the first delivered word of the first admitted frame is fixed
by §6.1 at `start_cycle + 3`; the schedule's own first start cycle is 1
(`frames_at ~lane:0` puts the first start at octet time 8). The rendering does
not choose that number — it chooses only *whether* the frame is admitted. Sealing
it as an equality is therefore not a pin on the rendering's arithmetic, and if it
prints something else the rendering moved a second thing.

**(b) Why IC-J2's integer is a span rather than a value.** The class adds a
report; **where** a design reports a refusal is not fixed by any sentence of the
specification, because the specification forbids the report entirely. A seal that
pinned it would score a correct rendering as a finding. The span is bench-supplied
(frame 0's own extent) and the two endpoints are the two designs a reasonable
implementer would write.

**(c) Why `M03-J2`'s green under IC-J3 is the round's centrepiece.** `WO-0067`
§6 withdrew a Kills cell from `M03-J2` on a derivation: the enable is 1 for the
whole of frame 100's admitted extent, so a continuously-sampling design truncates
nothing there. **IC-J3 is a continuously-sampling design.** If it reddens
`M03-J3` and leaves `M03-J2` green, the withdrawal is established from a run
rather than from an argument — the `FINDING M-1`/`M-2` pattern one family over,
and the reason this campaign is worth its five jobs even if every kill were
predictable.

**(d) Why `M03-J3`'s green under IC-J4 is derived from the stimulus and not from
a category.** `run_j3` builds `Enable.changes ~initial:true [(5, false)]`. Its
`change_cycles` therefore contains **one** entry and it is a 1 → 0 transition:
there is **no re-enable anywhere in that unit's run**, so a class about
honouring one has nothing to meet. The condition is an empty set there, which is
what makes the green load-bearing rather than lucky.

**(e) Why `M03-N4`'s green under IC-J5 is a measurement and not an accident.**
Frame A at `M03-N4` is aborted by REQ-110 and its `tlast` word **already**
carries `tuser`[0] = 1. A rendering that marks an in-flight frame therefore
changes nothing observable there — **unless** the marking is sticky and reaches
frame C, which is admitted after the enable returns. The green is the test of
stickiness, and §3.4's conjunct list names it.

**(f) Why the `%expect` blocks do not move and no cell is scored on one.** Every
unit carries `[%expect {||}]` and is empty by construction. A raise leaves the
block untouched, so **a red here fails step 6, never step 8**, and the raised
message alone scores the cell. No promotion-loop signature can arise.

**(g) The instrument families this campaign probes, stated because the scorecard
must state it.** Counted at the base tree, the three J units carry **22
DUT-observable assertions**; this campaign's five classes reach **7**: `M03-J1`'s
two silence arms, `M03-J2`'s word count and empty-strobe check, and `M03-J3`'s
word count, tuple comparison and empty-strobe check. **Fifteen are probed by
nothing here** — including every per-word assertion in `M03-J2`, the whole
reference run in `M03-J3`, its cycle comparison and its refusal check, and the
control run in `M03-J1`. The verdict must say this in terms rather than let a
four-unit scorecard imply breadth.

**(h) Why `M03-J1`'s IC-J4 cell is `M` and not `R!`.** The unit contains no
assertion that reads frame 100's delivered stream (§2.2). Sealing it `R!` would
be sealing a prediction about an instrument the row does not have; sealing it `G`
would claim the refusal is invisible, which the latency tagger contradicts.
**A third symbol is the honest one**, and §5.6 fixes all three outcomes rather
than letting the scorecard decide which was meant.

---

## 11. Bounds this campaign does NOT close, named before the result

1. **`M03-J4` is unscoreable and stays unscored** (§6.2). Survives any outcome.
2. **The differential co-simulation anchor is blind to every class here by
   stimulus** (§6.1), and remains undischarged besides.
3. **REQ-802/§9.1's reset value and REQ-810's header-record clause are not
   testable at this module or this bench** (§6.4, §6.5).
4. **The `Bench.Enable` guard is unreachable by any mutation and its refusal path
   remains unfired** (§6.3).
5. **Every lane-4 member is unobserved, not tested**, and fifteen of the three
   units' twenty-two DUT-observable assertions are probed by nothing (§5.3,
   §10(g)).
6. **`FINDING J-1` and `FINDING J-2` are raised and unrepaired**; both are plan
   text and both have the post-campaign `AP-` round as their carrier.
7. **A kill proves the assertion convicts, never that the bench is a general
   detector of the class.** IC-J1 is detected at four units; **this bench was not
   blind to it** and no verdict may imply it was.
8. **Nothing here bears on family K, on the fifty-five M03 units that never drive
   the enable, or on the `SO-` those still gate.**

---

## 12. Pass criteria

1. **Each class reddens exactly its `R!` cells**, with §4's verbatim strings for
   the branch its manifest disclosed, and **stays green at every `G`, `G!` and
   `G✱`**.
2. **No unit outside the class's own RULE (§3.4) reddens** — and in particular
   **all 55 enable-free M03 units, all 79 non-M03 behavioural units and
   `test/cosim/` hold under every class**. A red at `test/hardcaml_ethernet/` or
   a failing build step is read as a **build** finding.
3. **The unmutated control is green at the base SHA**, with its CI run id and
   conclusion quoted. **CI is the authority** (ADR-0005).
4. **Kills are counted per class**: five classes, at most **five** kills; two
   classes qualifying one row is two kills and one qualification.
5. **All nine disclosures are answered before the run.** A branch inferred by me
   from a scorecard is not a disclosure and the affected cells score as `U`.
6. **The verdict states §6's declarations whatever the score is** — the anchor's
   stimulus blindness, M03-J4's unconstrained-by-specification status, the
   guard's unreachability, the reset value's and the header clause's
   non-instances, `FINDING J-1`, `FINDING J-2` and `DECLARATION J-D1`'s outcome.
   They are the round's own contribution and they are not contingent on a kill.
7. **The verdict states, per class, which reds are blast radius** (§3.3), names
   no J row qualified by any of them, and states explicitly that **`M03-N4` is
   qualified by nothing here**.
8. **The verdict states §10(g)'s figure** — seven of twenty-two — rather than
   letting a four-unit scorecard imply breadth.

---

## 13. Not to be told

§0's MUST-STAY-GREEN sets and the enable census's consequences, §1's row
prefixes, §2's orders and derived numbers, §3's matrix, kill table,
qualification/blast-radius table, rules with their conjunct lists and worked
instances, §4's verbatim strings, §5's blast-radius cells and pre-fixed
adjudications, §6's blindness declarations in their entirety, §7's named
collisions and their discriminators, §8's dispositions, §9's inequality table,
§10's reasoning, §11's bounds, §12's pass criteria.

**Freely told, and told in `WO-0076`**: the five classes and the sentence each is
derived from; the nine mandatory disclosures; the denominator and the enable
census; the structural fact of enable-high invariance and the three instrument
kinds; the ten declarations of what the campaign cannot score, including both
findings against my own plan text; the reachability standard and the three-path
gate inventory; the per-class permission lists; the allowlist, the manifest-only
rule and the abort-first HEAD check; the base SHA, the ordering rule, the
`WO-0075` hazard and the bounded classes' scoring rules; the mutant-owned axes;
the *existence* of two scored-cell collisions and one branch pair and the fact
that the cross product is what found them; the qualification rule; the price; the
non-closures and carriers; the weighting; the return format and the two
questions.
