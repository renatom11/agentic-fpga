# WO-0074 SEALED: dv_lead's frozen predictions for the family-M mutation campaign

> **SEALED.** The auditor must not open this file until every diff is delivered
> and every scorecard is in hand — and under `WO-0074` §7's allowlist, **all of
> `agents/**` is out of bounds for the campaign's duration**, this file included
> and absolutely.

- **State**: **FROZEN — unopened.**
- **Frozen against**: **the commit that stages this seal and its packet.** Not
  its parent — this is the corrective drafting rule adopted at
  `WO-0073-VERDICT` §7 after `FINDING WO-0073-M1`, and this is its first
  application. I cannot state its hash: I never run git (PROTOCOL §2), and it has
  none until the orchestrator creates it. The auditor quotes the hash it applied
  to (`WO-0074` §7 item 6), and any disagreement is a finding **before** the
  campaign runs.
- **Frozen by**: dv_lead, `J-dv_lead-0136`, **before any diff existed**, in the
  commit that stages this file beside its packet — R-SEAL-1 (PROTOCOL §10,
  ADR-0016).
- **Second copy**: the class → `R!`-carrier **row mapping** (not the message
  strings, not the matrix) is restated in `J-dv_lead-0136`.
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
- **Standing rule 5** (`FINDING WO-0066-3`, retained after it held at
  `WO-0073`): outside the units this seal works cell by cell, a class's predicted
  red set is stated as a **RULE in stimulus terms**, with worked instances named
  beneath it. **Where the rule and the instance list disagree, the RULE
  governs.**
- **Standing rule 6 — NEW THIS ROUND, and it is what a binding family forces**:
  a cell may be scored as qualifying an M row **only** if the message that speaks
  is the carrier's **exact-strobe-set** assertion. Every other message at a
  carrier, however red, qualifies the carrier's own row at most and the M row not
  at all.

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
  139  test/ (repository-wide, OCaml units)
```

**59 M03 units; 139 repository-wide; 80 non-M03.** The census at the same tree:
**78 rows declared, 62 named in a unit title** under both the naive and the
trailing-digit-boundary matcher (the two agree at this tree), with `M03-A4`
subtracted and `M03-F5` added by citation → **62 of 62 ASSERT rows discharged**.

**The 139 is the corrected figure** (`WO-0074` §2, `FINDING M-4`):
`tools/dv_checks.sh`'s repository-wide line matches every file under `test/`, not
only `*.ml`, and reports **140** because `test/attack_plans/AP-xgmii_rx_64.md`
now contains the literal `let%expect_test` inside a quoted command. **No unit was
added; the instrument counted a markdown line.**

**The non-M03 80, by what a red there would mean:**

| set | units | a red there means |
|---|---|---|
| `test/monitors/` 37, `test/xgmii/` 25, `test/golden/` 11, `test/axi64_probe/` 3, `test/xgmii_probe/` 3 | **79** | the manifest reached outside its own file — a **scope finding** |
| `test/hardcaml_ethernet/` | **1** | the mutant **does not compile** — a **build finding**, never behavioural |

**MUST-STAY-GREEN outside M03, every class, every branch: 79 behavioural + 1
build-level.**

**`test/cosim/` — corrected here, per `FINDING WO-0073-D1`, and then declared
blind.** It contributes **zero units** and is *both* a build-finding home (its
`(executables)` stanza links `hardcaml_ethernet`) *and* a behavioural detector
(it reddened under IC-L5 at `WO-0073`). **Under every class in this campaign it
is predicted GREEN, and that green is worth nothing**: the pinned canonical form
carries `tkeep`, `tlast`, `tuser0`, `octets` and an `Accept`/`Discard` decision
and **no strobe field at all**, so a strobe-set mutation is invisible to it by
grammar. §6.1 records this as the campaign's own GREEN-BY-BLINDNESS declaration.

**Family M owns 0 of the 59 units.** Its twelve carriers are worked cell by cell
below; the other **47** are governed by each class's rule (§3.4).

---

## 1. The row prefixes, which are how the scorecard is read

Every message below is `<row prefix>: <body>`, composed by each file's own
`fail row msg = failwith (String.concat [ row; ": "; msg ])`. The prefixes at the
base SHA, for every carrier this seal scores:

| carrier | prefix, character-exact (first member) |
|---|---|
| `M03-B3` | `M03-B3` — **no lane suffix**, one member, lane 0 only |
| `M03-E1` | `M03-E1 (start lane 0, /E/ in lane 0 of octets 24-31; final delivered word FULL -- section3's sampling declaration, R-1's disagreement class)` |
| `M03-F1` | `M03-F1 (lane 0, length 5, delivered 1, final word fill 1)` |
| `M03-F2` | `M03-F2 (lane 0, 0 octets received)` |
| `M03-F3` | `M03-F3 (lane 0)` |
| `M03-G1` | `M03-G1 (lane 0)` |
| `M03-G2` | `M03-G2 (lane 0, 1518 legal maximum)` then `M03-G2 (lane 0, 1519 oversize)` |
| `M03-G3` / `M03-G4` / `M03-G7` / `M03-G8` | `M03-G3 (lane 0)` etc. |
| `M03-H1` / `M03-H3` | `M03-H1 (lane 0)` / `M03-H3 (lane 0)` |

**E1's prefix is content-dependent** and the seal's copy above is derived rather
than transcribed: the row string appends `FULL -- section3's sampling
declaration, R-1's disagreement class` when the delivered count is a multiple of
8 and `partial` otherwise; the first member delivers **24** octets (24 mod 8 = 0),
so the FULL variant is the one that speaks.

---

## 2. The orders every REQUIRED cell depends on

### 2.1 The measured fact this whole seal rests on

**In every one of the twelve carriers the exact-strobe-set assertion is the LAST
assertion before the monitor sweep**, and the per-unit order is, without
exception:

> stimulus/schedule guards (bench-side, DUT-independent) → construction and
> `Injection.outcomes` cross-checks (bench-side) → the driven-word guards → the
> delivered-frame **split** → per frame: **output-word count → `tlast` cycle →
> `tkeep` → `tuser`[0] → delivered octet content** → (where a second frame
> exists) the same five → (where the row has one) the no-extra-output guard →
> **the EXACT STROBE SET, over the whole run** → the accounting calls →
> `assert_monitors_clean`.

Two of the five files state that order as a stated convention in their own
headers. **Consequence, and it is standing rule 6 in mechanical form**: a class
that moves any delivered quantity raises a datapath message and the strobe-set
assertion never runs — so every `R!` cell below is a compound statement, *the
strobe set changed AND the entire delivered stream is byte- and cycle-identical
to the conformant one*.

### 2.2 The shape of every strobe-set assertion

Eleven of the twelve carriers match on `error_pulses samples` with two arms:

- a **singleton/pair arm** that checks the name and then the cycle, raising a
  message that **names** the observed strobe or the wrong cycle;
- a **catch-all arm** that raises a message printing only **the number of
  pulses**.

`M03-F3` is the tenth and is different: it **sorts** the observed list and
compares it against a sorted two-element expected list, raising a single message
printing the count. **Its header says in terms that the physical order of two
simultaneous strobes is a bench-probe artefact and is deliberately not encoded**
— which is §6.4's blindness declaration and is correct.

**Every class in this campaign changes the pulse COUNT, so every scored cell is
raised by a count-shaped arm.** That is why §9 seals the added strobe's *name*
and *cycle* as **unread**, and it is the direct cause of §7's collisions.

### 2.3 `error_pulses`, and the C-23 convention it implements

`error_pulses` maps each driven sample's high-strobe list to `(cycle, name)`
pairs, in the interface's own field order (`error_bad_fcs`, `error_bad_frame`,
`error_runt`, `error_oversize`, `error_start_without_terminate`). Therefore:

- two **different** strobes on one cycle are **two** entries — which is what every
  class here produces;
- the same strobe twice **within** one cycle is **one** entry — C-23's convention,
  and under `WO-0069`'s ruling (a level per cycle, both events discharged) **the
  module has conformed**, so this is an equivalent mutant and not a blindness
  costing coverage;
- the same strobe on two **consecutive** cycles is **two** entries and would be
  visible — no class here renders it.

### 2.4 Iteration and shadowing, per carrier

| carrier | order | members | observable |
|---|---|---|---|
| `M03-E1` | `List.iter [0;4]` outer, `List.range 0 8` inner | 16 | **(lane 0, /E/ lane 0)** first; 15 shadowed |
| `M03-F1` | `[0;4]` outer, `[5;16;60;63]` inner | 8 | (lane 0, length 5) first |
| `M03-F2` | `[0;4]` outer, `[0;1;4]` inner | 6 | **(lane 0, 0 octets)** first; 5 shadowed |
| `M03-F3`, `M03-G1`, `M03-G3`, `M03-G4`, `M03-G7`, `M03-G8`, `M03-H1`, `M03-H3` | lane 0 then lane 4 | 2 | lane 0 first |
| `M03-G2` | lane 0 (1518 then 1519), then lane 4 | 4 | 1518 first, 1519 second |
| `M03-B3` | single call | 1 | itself |

**Every carrier is its own `%expect_test`, so no carrier shadows another** and all
ten are independently observable in one run. **Inside a carrier the members
shadow.**

### 2.5 The one derived cycle any REQUIRED cell prints

`M03-F3`'s message prints the frame's `tlast` cycle. Derived at this tree:
`frames_at` puts the first start at octet time **8** (lane 0) and **12**
(lane 4), so `start_cycle = start_octet_time / 8 = 1` at **both** lanes; the
63-octet frame delivers 59 octets in 8 words; §7's per-octet constant gives
`start_cycle + 3 + (words - 1)` = **11**, at both lanes. **The cycle is
specification-fixed, not mutant-owned**, and appears verbatim in §4.1.

---

## 3. The matrix

`R!` = REQUIRED red **and scored**. `G` = MUST STAY GREEN. **`G!`** = a
**load-bearing** required green — the cell carries a measurement, and a red there
changes what may be claimed (§8 disposition 2). `G✱` = green by blindness (§6).
`r` = predicted red by the class's own **rule**, **UNWORKED**, contributing
**zero** kills. `U` = UNWORKED cell with adjudication pre-fixed. Anything
off-pattern is a **finding**.

### 3.1 The twelve carriers, worked

| carrier (M row it binds) | IC-M1 | IC-M2 | IC-M3 | IC-M4 | IC-M5 | IC-M6 | IC-M7 | IC-M10 |
|---|---|---|---|---|---|---|---|---|
| **M03-F3** (M1) | **R!** | G | G | G | G | G | G | G |
| **M03-F1** (M1, 2nd) | **G!** | G | G | G | G | G | G | **G!** |
| **M03-G1** (M2) | G | **R!** | G | G | G | G | G | G |
| **M03-E1** (M3) | G | G | **R!** | G | **G!** | G | G | G |
| **M03-H1** (M4) | G | G | G | **R!** | G | G | G | G |
| **M03-H3** (M5) | G | G | *r* | G | **R!** | G | G | G |
| **M03-G3** (M6, 2nd epoch) | G | *r* | G | G | G | **G!** | G | G |
| **M03-G7** (M6, 1st epoch) | G | *r* | G | G | **G!** / **U** | **R!** | G | *r* |
| **M03-G4** (M7, 2nd epoch) | G | *r* | G | G | G | G | **G!** | G |
| **M03-G8** (M7, 1st epoch) | G | *r* | G | G | G | G | **R!** | G |
| **M03-F2** (M10) | G | G | G | G | G | G | G | **R!** |
| **M03-B3** (M10, 2nd) | G | G | G | G | G | G | G | **R!** |

**The `G!` cells are the round's own measurements and there are seven of them.**
`M03-G3` green under IC-M6 and `M03-G4` green under IC-M7 are `FINDING M-1` and
`FINDING M-2` **measured**; `M03-F1` green under IC-M1 is ruling 1's second
sentence holding while its first is broken; `M03-F1` green under IC-M10 is
ruling 9's boundary at exactly five received octets; `M03-E1` green under IC-M5
separates a report-path defect from a residue defect; `M03-G7` green under IC-M5
separates IC-M5's narrow branch from IC-M6.

**`M03-G7` under IC-M5 is `G!` at D-M5b's narrow branch and `U` at its wide
one** — §5.2.

### 3.2 Kills, per class

| class | kills if §8 disposition 1 holds |
|---|---|
| IC-M1 | **1** |
| IC-M2 | **1** |
| IC-M3 | **1** |
| IC-M4 | **1** |
| IC-M5 | **1** |
| IC-M6 | **1** |
| IC-M7 | **1** |
| IC-M10 | **1** |
| **campaign maximum** | **8** |

**Kills are counted per class.** IC-M2's predicted reds across seven oversize
units are **one** kill, never seven; IC-M10's across ten are one.

### 3.3 The rows these kills qualify — and the carrier reds that qualify nothing

| class | qualifies (one kill, both rows named) | carrier reds that are BLAST RADIUS and qualify nothing |
|---|---|---|
| **IC-M1** | **`M03-M1`** and its carrier `M03-F3` | — (the rule selects one unit) |
| **IC-M2** | **`M03-M2`** and its carrier `M03-G1` | `M03-G2`(1519), `M03-G3`, `M03-G4`, `M03-G6`, `M03-G7`, `M03-G8` — every one reddens through **ruling 2**, so **`M03-M6` and `M03-M7` are NOT qualified** by any of them, and neither are the G rows themselves |
| **IC-M3** | **`M03-M3`** and its carrier `M03-E1` | `M03-E2`, `M03-E5`, `M03-B2`, and **`M03-H3` — the M5 carrier**, reddening through ruling 3, so **`M03-M5` is NOT qualified** |
| **IC-M4** | **`M03-M4`** and its carrier `M03-H1` | `M03-H2`, `M03-H4`, `M03-B4`, `M03-B4(b)`, `M03-N2` ×6, `M03-N4` |
| **IC-M5** | **`M03-M5`** and its carrier `M03-H3` | `M03-B2` |
| **IC-M6** | **`M03-M6`**, on `M03-G7` **alone** | `M03-G6` (a start character in `Discard` at an unterminated frame) |
| **IC-M7** | **`M03-M7`**, on `M03-G8` **alone** | — (the rule selects one unit) |
| **IC-M10** | **`M03-M10`** and its carriers `M03-F2`, `M03-B3` | `M03-N2` ×6, `M03-I2`(3rd member), and **`M03-G7` — the M6 carrier**, reddening through ruling 9, so **`M03-M6` is NOT qualified** by it |

**No class in this campaign qualifies `M03-M8` or `M03-M9`, and none can**
(`WO-0074` §4 items 1–2). Any verdict that says otherwise is convicted by this
table.

### 3.4 The rules governing the other 47 M03 units

| class | RULE (governs where §3.5's instances are short) |
|---|---|
| **IC-M1** | a unit reddens iff its stimulus drives a frame of **5–63 received octets between start and terminate whose received FCS does not match**, and the unit asserts the strobe set. **Measured at this tree: exactly ONE such unit exists.** Every bad-FCS stimulus elsewhere is 64 octets and every runt elsewhere has a correct FCS |
| **IC-M2** | a unit reddens iff a frame **receives more than 1518 octets between start and terminate** (REQ-108's truncation fires) and the unit asserts the strobe set or a strobe count over that run |
| **IC-M3** | a unit reddens iff an **error character closes an open frame** (§9's closure list) and the unit asserts the strobe set — **whatever the delivered count, zero included** |
| **IC-M4** | a unit reddens iff a **new start character closes an open frame** and the unit asserts the strobe set — zero-delivered aborts included |
| **IC-M5** | a unit reddens iff a frame is **closed by an error character** and a **start character arrives before any terminate character** does, and the unit asserts the strobe set |
| **IC-M6** | a unit reddens iff a **start character arrives while the module is in `Discard`** — after REQ-108's truncation and before that frame's own terminate character — and the unit asserts the strobe set |
| **IC-M7** | a unit reddens iff an **error character arrives while the module is in `Discard`**, same window, and the unit asserts the strobe set |
| **IC-M10** | a unit reddens iff a frame is **closed by a terminate character after fewer than five received octets** and the unit asserts the strobe set |

### 3.5 Worked instances beneath the rules — `r` unless marked

- **IC-M1** — the rule's set is **`{M03-F3}`**, measured: the bad-FCS
  constructions at this tree are `test_m03_d.ml` (64 octets, twice),
  `test_m03_f.ml` (63 octets — this one) and `test_m03_k.ml` (64 octets). **58 of
  59 M03 units are MUST-STAY-GREEN under this class**, which is the narrowest
  predicted red set of any class in this era.
- **IC-M2** — `r` at `M03-G2`, `M03-G3`, `M03-G4`, `M03-G6`, `M03-G7`, `M03-G8`.
  **WORKED and predicted GREEN, and it is the boundary**: `M03-C3` (one
  1518-octet frame), `M03-C5` (1513 and 1516), `M03-I6`'s 1518 member and
  `M03-L5`'s 1518 members all receive **at most** 1518 octets, so REQ-108 never
  fires and no comparison is added. **A red at any of them means the rendering
  keys on frame length rather than on the truncation event**, and §8 disposition
  2 governs. **Constrained-prefix cell**: `M03-G2`'s red must carry the
  `(lane 0, 1519 oversize)` prefix; a red carrying `(lane 0, 1518 legal maximum)`
  is a finding of the same kind.
- **IC-M3** — `r` at `M03-E2`, `M03-E5`, `M03-B2` (all zero-delivered `/E/`
  closures — the seed is compared and mismatches) and at `M03-H3`. **WORKED and
  predicted GREEN**: `M03-E4` and `M03-N1` drive an `/E/` **after** a terminate
  character, where §9's third table row and C-12 say no frame is open, so no
  closure event occurs and nothing is added; `M03-G4` and `M03-G8` likewise.
- **IC-M4** — `r` at `M03-H2`, `M03-H4`, `M03-B4`, `M03-B4 (b)`, `M03-N2`'s six
  sub-cases and `M03-N4`. **WORKED and predicted GREEN**: every ordinary
  terminate-closed unit (families A and C in their entirety), plus `M03-G3` and
  `M03-G7`, whose start characters find **no open frame** — which is the same
  fact rulings 6 and 4 both rest on.
- **IC-M5** — `r` at `M03-B2` (frame 1 closed by an `/E/` in a preamble
  position, frame 2 following). **WORKED and predicted GREEN**: `M03-E1`,
  `M03-E2` and `M03-E5` drive a **single frame** — there is no later start
  character for a stale open flag to meet, and that is a stimulus fact, not a
  category; `M03-E4` and `M03-N1` have no `/E/` closure at all; `M03-G7` is
  green **iff** D-M5b's narrow branch is disclosed (§5.2).
- **IC-M6** — `r` at `M03-G6` alone (its oversize frame reaches the next start
  character with no terminate character in between, so that `/S/` arrives in
  `Discard`). **Everything else in the bench is MUST-STAY-GREEN**, `M03-G1`,
  `M03-G2`, `M03-G3`, `M03-G4` and `M03-G8` emphatically included.
- **IC-M7** — the rule's set is **`{M03-G8}`**, measured: it is the only unit in
  the bench that places an error character strictly inside the first epoch.
  `M03-G4`'s `/E/` lands past the oversize frame's own terminate character and is
  the `G!` that proves it.
- **IC-M10** — `r` at `M03-N2`'s six sub-cases (frame B receives **zero** octets
  and is closed by the terminate character in the same word — §9 ruling 9's sub-5
  class, stated in that file's own header), at `M03-I2`'s third member (closed by
  its own `/T/` with zero octets received) and at `M03-G7` (its resynchronised
  frame receives four octets and is closed by the shared terminate character).
  **WORKED and predicted GREEN, and it is the boundary**: `M03-C4`'s 5-octet
  runt and `M03-F1`'s 5-octet member sit at exactly five received octets, where a
  conformant design **already** performs the comparison and finds it good, so the
  mutant is identical there.

**Adjudication for every `r` cell, fixed here**: a **red is predicted blast
radius, contributes zero additional kills, and is not an unnamed-unit finding**;
a **green is a FINDING** — a unit selected by the class's own rule cannot see the
class — and is adjudicated per row rather than scored against the class.

---

## 4. The REQUIRED cells, verbatim

The bodies below are the OCaml literals at the base SHA as the runtime composes
them (line-continuation backslashes elided, as the compiler elides them).
`<n>` marks a **mutant-owned** integer, sealed at §9 as an inequality; every
other character is exact.

### 4.1 IC-M1 — `M03-F3`, the sorted-pair comparison

```
M03-F3 (lane 0): expected exactly {error_runt, error_bad_fcs}, each once, both on cycle 11 -- the precedence/widened-pulse kill this row exists for; observed <n> pulse(s)
```

`11` is derived at §2.5 and is **specification-fixed**. `<n>` is `< 2`, derived
**1**. **Both branches of D-M1a produce this string character for character** —
§7 collision 1.

### 4.2 IC-M2 — `M03-G1`, the catch-all arm

```
M03-G1 (lane 0): expected exactly one strobe (error_oversize alone -- proving no error_bad_fcs, §9 ruling 2, and the following frame intact), observed <n>
```

`<n>` is `> 1`, derived **2**.

**The `G!` this class does not have, and why the cell is still load-bearing**:
IC-M2's own carrier is the cell, and the class's discrimination is carried by
§3.5's boundary greens (`M03-C3`, `M03-C5`, the 1518 members) rather than by a
green at a carrier. **`OBSERVATION M-O1`'s whole question is whether this cell
fires at all**, and `WO-0074` §8.1 fixes both outcomes before the run.

### 4.3 IC-M3 — `M03-E1`, the catch-all arm

```
M03-E1 (start lane 0, /E/ in lane 0 of octets 24-31; final delivered word FULL -- section3's sampling declaration, R-1's disagreement class): expected exactly one strobe pulse (error_bad_frame ALONE -- no error_bad_fcs: section 9 ruling 3, a frame ended by an error character has no terminate character, so REQ-103 attempts no FCS removal and there is no comparison to report; M03-M3's own kill), observed <n>
```

`<n>` is `> 1`, derived **2**. The first member delivers **24** octets, so this
class's residue operand is a 24-octet prefix; the remaining fifteen members
supply seven further distinct contents and are **shadowed** (§2.4).

### 4.4 IC-M4 — `M03-H1`, the catch-all arm

```
M03-H1 (lane 0): expected exactly one strobe (error_start_without_terminate alone -- no error_bad_fcs, §9 ruling 4), observed <n>
```

`<n>` is `> 1`, derived **2**. **This carrier's two members deliver the identical
64-octet filler at both lanes**, so this class has **one** independent residue
trial — `FINDING M-O1a`, and the reason `WO-0074` §8.1 rule 2 covers IC-M4 as
well as IC-M2.

### 4.5 IC-M5 — `M03-H3`, the catch-all arm

```
M03-H3 (lane 0): expected exactly one strobe (error_bad_frame alone -- NO error_start_without_terminate, §9's fifth ruling, since the /E/ already closed the frame before the /S/ arrives), observed <n>
```

`<n>` is `> 1`, derived **2**. **IC-M3 produces this identical string at this
identical cell as blast radius** — §7 collision 2, discriminated by `M03-E1`'s
state.

### 4.6 IC-M6 — `M03-G7`, the catch-all arm

```
M03-G7 (lane 0): expected exactly two strobes (error_oversize then error_runt -- NO error_start_without_terminate, §9's sixth ruling, C-12, WO-0056's own point), observed <n>
```

`<n>` is `> 2`, derived **3**. **IC-M2 and IC-M10 produce this identical string
at this identical cell as blast radius** — §7 collision 3.

**The `G!` that makes this cell a measurement**: `M03-G3` — same family, same
1600-octet frame, same ruling, same assertion — **stays green**, because its start
character arrives 102 octets past the truncation point and **after** the frame's
own terminate character, where `Discard` has already been left. That is
`FINDING M-1`'s claim, and this pairing is the first run that tests it.

### 4.7 IC-M7 — `M03-G8`, the catch-all arm

```
M03-G8 (lane 0): expected exactly one strobe (error_oversize alone -- NO error_bad_frame, §9's seventh ruling, C-12, in the epoch M03-G4's character never reaches), observed <n>
```

`<n>` is `> 1`, derived **2**.

**The `G!`**: `M03-G4` stays green, its `/E/` landing 100 octets past truncation
and past the frame's own `/T/`. **The carrier's own title already names the
epoch distinction; this cell measures it.**

### 4.8 IC-M10 — `M03-F2` and `M03-B3`, two carriers, both catch-all arms

```
M03-F2 (lane 0, 0 octets received): expected exactly one strobe pulse (error_runt only -- F-c5's own kill), observed <n>
```

```
M03-B3: expected exactly one strobe pulse (error_runt alone -- no error_bad_fcs, M03-M10's own kill) over the WHOLE run, observed <n> pulse(s)
```

`<n>` is `> 1`, derived **2** at both. **Both are REQUIRED**: they are separate
`%expect_test`s and neither shadows the other, so the class must convict at both
or explain the difference. At both, the compared operand is §6.1 item 1's
**0x00000000 seed** (zero received octets, so item 2 never updates the register),
which is not REQ-304's `0x2144DF1C` — which is why the cell does not depend on
D-M10a's answer for its firing, only for its explanation.

---

## 5. The UNWORKED cells, with adjudication pre-fixed

### 5.1 A rendering that is neither disclosed branch

If a manifest delivers a rendering that is neither branch of a disclosure — a
precedence design that suppresses *both* strobes at IC-M1, a residue class that
also removes REQ-103's extent, an IC-M6 that pulses on every start character —
every cell of that class is `U` and disposition 5 governs.

### 5.2 IC-M5 at D-M5b's wide branch — `M03-G7`

If the rendering's clear set also drops REQ-108's truncation member, then
`M03-G7`'s start character finds a stale open flag and the unit reddens with
§4.6's string, `observed 3`. **Adjudication, fixed here**: the class's own `R!`
at `M03-H3` still scores (its mechanism is unchanged there), `M03-M5` is still
QUALIFIED, **the `G!` is not claimed**, and the `M03-G7` red is scored as blast
radius that **qualifies neither `M03-M6` nor `M03-G7`'s own row** — because
under this branch the mechanism at `M03-G7` runs through *ruling 5's* term, not
ruling 6's. IC-M6's own cell is unaffected and is scored from its own diff.

### 5.3 Shadowed members

`M03-E1` 15 of 16, `M03-F2` 5 of 6, `M03-F1` 7 of 8, `M03-G2` 3 of 4, and the
lane-4 member of every two-member carrier are **structurally unobservable in a
passing-to-failing run**. **Adjudication, fixed here**: a carrier's cell is
scored on the **first** member the order reaches; a later member's string is
scored **only** if the scorecard reports it, which requires every earlier member
to have been green — itself a finding under the class's own rule. R-DISC-1's
per-lane, per-member discharge is still required: **a member discharged term by
term and merely unobserved is recorded as unobserved, never as a miss and never
as a pass.**

**This bites hardest at `M03-F2` under IC-M10**, where the 4-octet member —
`WO-0047` §2's anti-vacuity member, the one whose non-all-zero filler was chosen
precisely so a wrong design could not pass by accident — is shadowed by the
zero-octet member. **That discipline is therefore NOT measured by this campaign**
(`WO-0074` §4 item 6) and no verdict may say it was.

### 5.4 A red arriving through `assert_monitors_clean`

A message of the form `<prefix>: protocol monitor unclean:`,
`<prefix>: conservation monitor unclean:`, `<prefix>: strobe monitor unclean:`
or `<prefix>: latency tagger …` at a carrier means the strobe-set assertion
**passed** and a monitor spoke afterwards. Given that every class here changes
the strobe set, that combination means the class did not fire at that carrier and
something else did. **The cell scores UNQUALIFIED**, it may not be re-read as a
qualification after the fact, and the class's kill is not counted from it.

### 5.5 A red carrying `test bug --`

Several carriers guard their own stimulus with messages beginning
`test bug --` (the injected character landing where the row means it to, the
frame's own FCS checking out, the schedule's own lane legality). **All of them
are evaluated on the bench's own model of the stimulus, before or independently
of the DUT** — `Injection`'s `word_at`, `Arrival`'s octet times,
`Frame.residue_ok`. **No RTL mutation can move them.** A `test bug --` message in
this campaign therefore means something other than a seeded class: it is reported,
it scores nothing in either direction, and it is a finding of its own kind.

---

## 6. GREEN BY BLINDNESS, and the structural unreachability this round declares

Every claim here is derived from committed text at the base SHA. **A green at any
of these is not vigilance and no verdict may cite it as evidence.**

### 6.1 The differential co-simulation anchor is blind to this entire campaign

The pinned canonical transaction form is, per word,
`{ tkeep; tlast; tuser0; octets }`, plus an `Accept`/`Discard` decision per input
frame. **There is no strobe field.** Every class here changes only which strobes
pulse; none changes a delivered word, a `tkeep`, a `tlast`, a `tuser0` or a
frame's accept/discard decision (that is §6 of the packet, enforced as a
precondition of scoring). **So the co-simulation lane cannot convict any of the
eight, and a green `cosim` job is evidence of nothing.**

This is a **third** blindness beside `WO-0073-D2`'s, and it is stronger in kind:
D-2's is a property of the current comparison (content, not timing), this one is a
property of the **grammar** (no strobe record exists to compare). It survives any
future stimulus and is discharged only by changing the canonical form.

### 6.2 `M03-M8` has no mutant — non-existence, not blindness

Ruling 8 is about two conditions whose octet ranges are disjoint: 0–63 for
REQ-107 (with §9's sixth row below 5) and > 1518 for REQ-108. **One frame's
received count cannot satisfy both**, so there is no stimulus, no cell and no
kill. A design that pulsed both would be mis-evaluating a count — a REQ-107 or
REQ-108 defect that families F and G already score — and not a co-occurrence
defect. **Recorded so that a full scorecard is not read as full coverage of
§4.M.**

### 6.3 `M03-M9` has no mutant — the interface forbids it

M03 is the origin of `tuser`[0] on this chain. §0.6's *"a module SHALL NOT
re-report an inherited abort"* quantifies over an input bit this module does not
have, so **no mutation can make it re-report something it cannot receive.** The
row exists so no `SO-` claims §0.6's inheritance clause as tested coverage here.

### 6.4 `tuser`[0] "set once" and simultaneous-strobe order are unfalsifiable

`M03-M1`'s observable includes *"`tuser`[0] is set once"*. It is one bit on one
word: **"twice" has no rendering**, and no kill in this campaign may be reported
as evidence for that clause. Likewise §9 pins each strobe's *cycle* and not its
position among simultaneous strobes; the two-strobe carrier sorts before
comparing and its own header records the physical order as a bench-probe
artefact. **A mutation that reorders simultaneous strobes is invisible, and under
§9 it is also not a defect.**

### 6.5 C-23's counting convention, and why it costs nothing here

`error_pulses` reports **presence per name per cycle** (§2.3). A rendering that
raised the same strobe twice inside one cycle would be invisible — and
`WO-0069`'s ruling settles that such a design **has conformed** (each event's
obligation is a level; the shortfall is in the decoding, never in the design).
**So this blindness is an equivalent-mutant fact, not a coverage gap**, and it is
recorded here rather than left for a scorecard to discover.

### 6.6 The portable form, recorded because it is not about this bench

**When a family of requirements is discharged by *bindings* onto assertions that
live inside other units, the binding is only as strong as the position of that
assertion in its host's order.** Bind to the last assertion in a unit and every
earlier failure hides it; bind to the first and it hides everything else. **A
coverage claim over bound rows must therefore state where in its host each bound
assertion sits, or it is claiming an observation the host may never make.** This
campaign's entire design — datapath-silent classes only — is that sentence
applied.

---

## 7. Collisions — named, with their discriminators

**Collision 1 — IC-M1 branch **R** ≡ IC-M1 branch **B**** at `M03-F3`'s cell
(§4.1), **character for character, including the derived integer 1**.

- **Discriminator: NONE that this bench produces.** The message prints the pulse
  *count* and not the surviving *name*, and the surviving name is the whole of
  the difference between the branches.
- **Carried entirely by D-M1a.** This is `WO-0066`'s IC-D/IC-F situation and
  `WO-0073`'s collision 1 repeated a third time, and the protection is the same
  and is the whole of it. A rendering that delivers both branches as separate
  diffs is priced at one extra job.

**Collision 2 — IC-M3 ≡ IC-M5 at `M03-H3`'s cell** (§4.5), character for
character, `observed 2` in both.

- **Discriminator: `M03-E1`'s state — a MEASUREMENT.** IC-M3 reddens `M03-E1`
  (its own `R!`); IC-M5 leaves it green, because that carrier drives a single
  frame with no following start character. `M03-B2` reddens under both and
  discriminates nothing.
- **This is the collision that matters for the commission's question.** Under
  IC-M3 the `M03-H3` red is **blast radius through ruling 3** and qualifies
  **neither** `M03-M5` nor `M03-H3`'s own row; under IC-M5 the identical string is
  the `R!` that qualifies `M03-M5`. **The same characters mean opposite things,
  and only the diff identity plus `M03-E1`'s state tells them apart.**

**Collision 3 — IC-M2 ≡ IC-M6 ≡ IC-M10 at `M03-G7`'s cell** (§4.6), character
for character, `observed 3` in all three.

- **Discriminators, all measurements.** `M03-G1` reddens under IC-M2 alone;
  `M03-F2` and `M03-B3` redden under IC-M10 alone; `M03-G3` is green under IC-M6
  and IC-M10 and **red under IC-M2**; `M03-G6` reddens under IC-M2 and IC-M6 and
  is green under IC-M10.
- **Under IC-M2 and IC-M10 the `M03-G7` red is blast radius and qualifies
  `M03-M6` not at all.** Only IC-M6's is the row's kill.

**Near-collision — IC-M5's wide branch joins collision 3** at `M03-G7` (§5.2),
separated from IC-M6 by `M03-H3`'s state and by the disclosure. §9's directions
and §5.2's pre-fixed adjudication are what keep that a seal rather than a hope.

---

## 8. Pre-committed dispositions

1. **A class red at exactly its `R!` cells, with §4's verbatim strings for the
   branch its manifest disclosed, and green at every `G`, `G!` and `G✱`** → **the
   class is KILLED, one kill**, and the rows §3.3 names are **QUALIFIED on that
   class and on nothing else** — one kill covering both the M row and its
   carrier's row (`WO-0073` §11, corrected at `WO-0074` §11).
2. **A class red at its `R!` cells but also red at a `G!` its own derivation
   calls a control** — IC-M6 at `M03-G3`, IC-M7 at `M03-G4`, IC-M1 at `M03-F1`,
   IC-M2 at a 1518-or-below unit, IC-M10 at a five-octet frame — → the class's
   kill still counts where its own mechanism is unchanged, **but the measurement
   the green carried is NOT claimed**, and `WO-0074` §8.1 fixes which claim is
   lost per class. Where the green's failure shows the rendering keys on
   something other than the class (IC-M2 at `M03-C3`, IC-M6/IC-M7 at their
   second-epoch carriers under a *narrow* disclosure), **the reds are blast
   radius, the class scores ZERO, and the rows stay UNQUALIFIED.**
3. **A class not reachable at its `R!` cells** (a `NOT SEEDED` self-declaration,
   or a lane or member undischarged under `WO-0074` §5) → the class is **void**:
   zero kills, **no claim about any row in either direction**. **IC-M5's
   declared-unrenderable case is the exception with its own rule**: `WO-0074`
   §8.1 records `M03-M5` as SCORED AND UNQUALIFIABLE at this design, with the
   shared term quoted, which is a result and not a void.
4. **A class red at an `R!` carrier through `assert_monitors_clean` or through a
   `test bug --` message** → §5.4 and §5.5 govern; the class's kill is not
   counted from that red.
5. **A rendering that is neither disclosed branch** → §5.1: every cell of that
   class is `U`, reported rather than scored.
6. **Two classes delivered in one diff, or the two branches of collision 1
   rendered by one change** → **both are unscoreable**, reported as a manifest
   defect and not as a result. **A shared enable term across the four residue
   classes is NOT this case** (`WO-0073-VERDICT` §7 Q4).
7. **ANY class red at an `R!` carrier carrying a DATAPATH message** — an
   output-word count, a `tlast` cycle, a `tkeep`, a `tuser`[0], a delivered-octet
   content, a frame-split message, or a following-frame message — → the rendering
   perturbed the datapath, **the class is out of specification: reported, not
   scored**, and disposition 3's "no claim in either direction" governs. **This
   disposition applies to every class in this campaign without exception**,
   because a datapath message means the strobe-set assertion never ran and the M
   row's own observable was never evaluated (standing rule 6).
8. **A red at any of the 79 non-M03 behavioural units** → a **scope finding**
   against the manifest. **A red at `test/hardcaml_ethernet/`'s single unit, or a
   failing build step** → a **build finding**, never behavioural. **A red in
   `test/cosim/`** → a finding against §6.1's derivation, and a very interesting
   one, since no class here writes a field that form carries.
9. **No kill anywhere is evidence about `M03-M8`, `M03-M9`, `tuser`[0]'s
   set-once clause, or `WO-0047` §2's 4-octet anti-vacuity member** (§6.2, §6.3,
   §6.4, §5.3). This disposition binds the verdict, not the manifest.

---

## 9. Mutant-owned quantities — inequalities with named directions

| quantity | sealed | direction |
|---|---|---|
| `<n>` at `M03-F3` under **IC-M1** | `< 2`, derived **1** | **fewer** — a precedence design reports one of two conditions. **This direction is the only thing separating IC-M1 from every other class at a count-shaped cell** |
| `<n>` at `M03-G1` (IC-M2), `M03-E1` (IC-M3), `M03-H1` (IC-M4), `M03-H3` (IC-M5), `M03-G8` (IC-M7), `M03-F2`/`M03-B3` (IC-M10) | `> 1`, derived **2** | **more** — a second strobe beside the first |
| `<n>` at `M03-G7` under **IC-M6** | `> 2`, derived **3** | **more** — the carrier's conformant set already has two members |
| the **cycle** the added or surviving strobe pulses on | **mutant-owned and UNREAD** | no `R!` cell reads it: every scored message is raised by a count-shaped arm. Its appearance in a scorecard is information, never a cell, and a disagreement about it is not a finding |
| the **name** of the added strobe | **class-fixed and UNPRINTED at every `R!` cell** | §9 of the specification fixes which strobe each rendering can add; the count-shaped messages do not name it — which is the direct cause of all three collisions |
| `M03-F3`'s printed cycle **11** | **not mutant-owned** — spec-fixed | §7's per-octet constant over the schedule's own start octet time, identical at both lanes (§2.5) |
| `tuser`[0] at every carrier frame this campaign touches | **not mutant-owned** — `= 1` | each such frame is already marked by its own primary condition (REQ-007); a rendering that clears it has moved the datapath (disposition 7) |
| every delivered word count, `tkeep`, `tlast` cycle and delivered octet at every carrier | **not mutant-owned** — spec-fixed by REQ-103, REQ-108, REQ-110, §0.7, §7 | §6 of the packet as a seal: any movement is a datapath perturbation, not a rendering's prerogative |
| the stimulus guards, `Injection.outcomes` cross-checks and schedule facts | **not mutant-owned** — bench-supplied | evaluated on the bench's own model before or independently of the DUT; a message from one means something other than a seeded class (§5.5) |
| **units reddening under a class** | `⊆` the class's **RULE** at §3.4 | a red outside the rule is a finding: either my rule was wrong or the diff reaches further than the class it names |

**Five of the ten rows are specification-fixed or bench-supplied and are sealed as
equalities on purpose**; calling them mutant-owned would be buying an
unfalsifiable seal. **The fourth and fifth rows are the ones to read twice**:
they seal two quantities as *unread*, which is a third disposition beside
mutant-owned and spec-fixed, and it is honest only because §2.2's measured
match-arm shapes say which arm speaks.

---

## 10. Reasoning for the cells that are not obvious

**(a) Why every `R!` cell is a compound statement, and why that is this
campaign's strength rather than a complication.** The strobe-set assertion is
last in every carrier (§2.1), so it runs only if the output-word count, the
`tlast` cycle, the `tkeep`, the `tuser`[0] and every delivered octet of every
frame in the unit have already matched. **A red at a strobe-set assertion is
therefore simultaneously a positive report on the whole delivered stream.** No
other family in this bench has that property, and it is a consequence of the
files' stated ordering convention rather than of anything family M did.

**(b) Why the four residue classes are four diffs and not one.** The AP's own
`M03-M4` Kills cell says *"(as M03-M3)"*, and the widest rendering — compare at
every closure — would redden `M03-G1`, `M03-E1` and `M03-H1` together and score
**one** kill for three rows. That is a worse outcome in two ways: it forfeits
per-row attribution, and it collapses `OBSERVATION M-O1`'s question, which is
specifically about **one carrier's one content**. Four gates, four diffs, four
kills, and the vacuity question asked separately at the two carriers whose ground
is thin.

**(c) Why `M03-F1` is a `G!` under IC-M1 and not merely a `G`.** Ruling 1 has two
sentences: both strobes pulse when both conditions hold, and *"a runt with a
correct FCS pulses `error_runt` alone"*. `M03-F1` is the second sentence's
carrier. A precedence design that broke the first sentence while leaving the
second intact is the class; **a rendering that reddens `M03-F1` has broken the
second sentence too and is not keying on the co-occurrence at all.** The green is
what makes the kill specific to ruling 1.

**(d) Why `M03-E1`'s green under IC-M5 is derived from the stimulus and not from
a category.** That carrier builds **one** `frame_case`: a single 64-octet frame
with an injected error character. There is no later start character in the
schedule, so a stale open-frame flag has nothing to meet. **The condition is an
empty set there**, which is what makes the green load-bearing rather than lucky.

**(e) Why zero-delivered aborts redden under IC-M3 and IC-M4.** §6.1 item 2 never
updates the residue register for a frame that receives no octet, so item 4's
"final value" is item 1's `0x00000000` seed, which is not REQ-304's `0x2144DF1C`.
**A comparison that runs at all therefore mismatches**, and the rendering's own
extent choice (D-M3a, D-M4a) does not change that. The same arithmetic is what
makes §4.8's two cells independent of D-M10a's answer.

**(f) Why the `%expect` blocks do not move and no cell is scored on one.** Every
carrier carries `[%expect {||}]` and is empty by construction. A raise leaves the
block untouched, so **a red here fails step 6, never step 8**, and the raised
message alone scores the cell. No promotion-loop signature can arise.

**(g) The instrument families this campaign probes, stated because the scorecard
must state it.** **One, and only one**: the exact-strobe-set check, at ten
instances of it. Every datapath assertion in the same twelve units is probed by
nothing here — deliberately, since a class that probed one could not qualify a
family-M row (standing rule 6). The verdict must say this in terms rather than
let a 12-carrier scorecard imply breadth.

**(h) Why `M03-G6` is `r` and not `R!` under IC-M6.** It reddens by the rule —
its oversize frame reaches the next start character with no terminate character
in between — but it is **not** a carrier of `M03-M6`, and `WO-0074` §11's
corrected rule means a red there qualifies `M03-G6`'s own row at most. Its value
here is as a discriminator in collision 3, not as a cell.

---

## 11. Bounds this campaign does NOT close, named before the result

1. **`M03-M8` and `M03-M9` are unscoreable and stay unscored** (§6.2, §6.3). This
   survives any outcome.
2. **The differential co-simulation anchor is blind to every class here** (§6.1),
   and remains undischarged per class besides.
3. **`tuser`[0]'s "set once" clause and simultaneous-strobe order are
   unfalsifiable** (§6.4); C-23's same-cycle convention is an equivalent-mutant
   fact, not a gap (§6.5).
4. **`WO-0047` §2's 4-octet anti-vacuity member is shadowed, not measured**
   (§5.3).
5. **Every non-first member of every multi-member carrier is unobserved**, not
   tested (§5.3, §2.4).
6. **A kill proves the assertion convicts, never that the bench is a general
   detector of the class.** IC-M2 and IC-M10 are detected across many units;
   **this bench was not blind to either** and no verdict may imply it was.
7. **Nothing here bears on families J or K, on the datapath assertions of the twelve
   carriers, or on the two campaigns still owed before any `SO-`.**
8. **`FINDING M-3`'s plan repair, `FINDING M-O1a`'s widening and `FINDING M-4`'s
   tooling repair are raised and unpaid**, with the carriers `WO-0074` §13 names.

---

## 12. Pass criteria

1. **Each class reddens exactly its `R!` cells**, with §4's verbatim strings for
   the branch its manifest disclosed, and **stays green at every `G`, `G!` and
   `G✱`**.
2. **No unit outside the class's own RULE (§3.4) reddens** — except at the cells
   §5 marks `U`. Outside M03: the **79** behavioural units hold, `test/cosim/`
   holds, and a red at `test/hardcaml_ethernet/` or a failing build step is read
   as a **build** finding (§0).
3. **The unmutated control is green at the base SHA**, with its CI run id and
   conclusion quoted. **CI is the authority** (ADR-0005).
4. **Kills are counted per class**: eight classes, at most **eight** kills; and a
   carrier kill and the M row bound to that carrier are **one** kill — and are
   counted together **only** where the strobe-set assertion is what spoke
   (standing rule 6, `WO-0074` §11).
5. **All ten disclosures are answered before the run.** A branch inferred by me
   from a scorecard is not a disclosure and the affected cells score as `U`.
6. **The verdict states §6's declarations whatever the score is** — the anchor's
   grammatical blindness, M8's and M9's unscoreability, the unfalsifiable clauses
   and F2's shadowed member. They are the round's own contribution and they are
   not contingent on a kill.
7. **The verdict states, per class, which carrier reds are blast radius** (§3.3),
   and names no M row qualified by any of them.

---

## 13. Not to be told

§0's MUST-STAY-GREEN sets and the `test/cosim/` correction, §1's row prefixes,
§2's orders and match-arm shapes and derived cycle, §3's matrix, kill table,
qualification/blast-radius table, rules and worked instances, §4's verbatim
strings, §5's UNWORKED adjudication rules, §6's blindness declarations in their
entirety, §7's named collisions and their discriminators, §8's dispositions,
§9's inequality table, §10's reasoning, §11's bounds, §12's pass criteria.

**Freely told, and told in `WO-0074`**: the eight classes and the sentence of §9
each is derived from; the ten mandatory disclosures; the denominator and
`FINDING M-4`; the structural fact that the strobe-set assertion is last in every
carrier, and the rule form; the seven declarations of what the campaign cannot
score; the reachability standard and the inverted gate inventory; the datapath
signature and the identity of the check with the qualification criterion; the
allowlist and manifest bars; the base SHA, the ordering rule and the three bounded
classes' scoring rules; the mutant-owned axes; the *existence* of two collision
pairs and one triple and what they cost the manifest; the corrected
carrier/bound-row rule; the price; the non-closures and carriers; the weighting;
the return format.
