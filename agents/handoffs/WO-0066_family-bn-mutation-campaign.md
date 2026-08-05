# WO-0066: the family-B/N mutation campaign — six classes against eleven members that have never been scored, and the first campaign in this programme whose scored bound splits into instances the seal has to distinguish

- **State**: **DRAFT** — dv_lead's draft. The orchestrator issues it, operates it
  (PROTOCOL §10's transient model) and allocates its id (PROTOCOL §3); `0066` is
  a placeholder used for reference throughout and is **not** a claim of
  allocation.
- **From** / **To**: dv_lead → **auditor** (manifest author), via the
  orchestrator (campaign operator).
- **Spec basis**: `docs/specs/requirements.md` **REQ-102** (the third sentence —
  a control character other than `/S/` and `/T/` in a preamble position routes to
  REQ-105), **REQ-105**, **REQ-107**, **REQ-110** (the abort rule, its
  *"a start character in lane 4 leaves lanes 0 to 3 of that word belonging to the
  aborted frame"* clause, and its zero-delivered clause), **REQ-113** (ordered
  sets and out-of-frame control characters ignored), **REQ-103**, **REQ-104**,
  **REQ-011**, **REQ-008**, **REQ-101**; **§0.3** (the gap convention and the
  start lanes), **§0.5** (octet time, the deciding input word), **§0.6** (the
  strobe window, C-23's counting), **§0.7** (the zero-delivered class), **§2**
  (the control-character codes), **§12**;
  `docs/specs/modules/xgmii_rx_64.md` **§6.1** (the two-events-in-one-word
  paragraph and its landed six-row cycle table), **§6.2** (the `Idle`,
  `Preamble` and `Frame` rows), **§6.3** items 3 and 8, **§7** (the per-octet
  constant), **§9** (the closure list, the nine-row table, the no-output-word
  pin, ruling 9's sub-5 class), **§10**.
- **Plan basis**: `test/attack_plans/AP-xgmii_rx_64.md` **§4.N** row `M03-N2`
  and **§4.B** rows `M03-B2` and `M03-B4`, as amended at `RV-0065B-VERDICT` §6;
  §4.E / §4.F / §4.G / §4.H / §4.I for the units this packet predicts as blast
  radius.
- **Binding**: the auditor's **R-DISC-1** and **R-DISC-2** (`DISP-0001` §4,
  `fab31de`) bind these manifests and are adjudication criteria for them.
- **The seal**: `WO-0066_family-bn-mutation-campaign-SEALED-predictions.md`,
  frozen in **this packet's own commit**, before any diff exists.
  `RV-0065B-VERDICT` §7.1's forward commitment under **R-SEAL-1** falls due here
  and is redeemed here. **If this commit does not stage that file, this round has
  no seal**, its cell-level claims may not be made, and the absence is a finding
  against me — my own rule, written against me at `J-dv_lead-0113` Open-question 1.
- **Precedent carried in terms**: `WO-0063B`'s pre-run reading note. **If the
  manifest raises a question for me, it comes to me BEFORE the run**, as a
  committed reading note, not as a post-hoc reading of a scorecard.

---

## 0. What this round is for, and the two things it cannot do

Eleven members landed at `88413b9`/`eb1e06a` and **not one of them has been
scored**: `M03-B4` member (b), `M03-B2`'s four `/I/` and `/Q/` members, and
`M03-N2`'s six sub-cases. `WO-0065` §10 said in terms that *"nothing here is
mutation-qualified by being written"*; this is the round that makes the claim
falsifiable. Three of the six N sub-cases were **red against a conforming design**
until `eb1e06a`, so this is also the **first legitimate M03-N2 denominator** — a
red member kills nothing and cannot be scored in either direction.

**Two things this round cannot do, stated first so no verdict drifts into them.**

1. **It cannot pay `WO-0058` bound 7.** The bench pays bound 7; the plan records
   it; a campaign only *scores* whether a design that breaks the bound's own
   conjunction is caught. §4 fixes how, and fixes it so that a partial catch is
   **visible as partial** rather than rounded up.
2. **It cannot qualify a row on a class the row was authored against.** None of
   the eleven members was written with a mutation class known — unlike `WO-0063B`'s
   member (iii), and that discount does **not** apply here. What does apply is the
   opposite honesty: several of the six classes below are already detected by
   units outside the new eleven, and §9 prices that unit by unit rather than
   letting the scorecard imply the bench was blind.

---

## 1. The six intent classes

The five I foresaw at `RV-0065B-VERDICT` §7.1 were a **plan**, not a seal. At the
freeze derivation two of them turned out to conflate distinct objects, and the
correction is recorded here rather than absorbed:

- **IC-B as foreseen** named two renderings (*"emits a `tkeep` = 0 word for frame
  B, **or** suppresses `error_runt` below some octet floor"*). They redden the
  same six cells with **different first-speaking messages**, so they are one class
  with a **mandatory rendering disclosure**, not one class with one cell.
- **IC-D as foreseen** put `/I/` and `/Q/` in one `R!` set. They are **two
  different defects**: `M03-B2`'s own row text says `/I/` kills a design carrying
  REQ-113's ignore rule into the preamble, and `/Q/` kills a design whose
  preamble routing is a **closed code table**. A campaign that scored them as one
  class would leave the `/Q/` member unscored on the only class it was built for.
  **IC-F is minted here** for that reason, and the addition is named rather than
  smuggled.

Six classes. Each is **one kill**, never one kill per reddened unit.

### IC-A — the in-word REQ-110 abort is recognised only at a word boundary

REQ-110's abort is decoded for a `/S/` in **lane 0** of an input word and **not**
for a `/S/` in **lane 4** of a word carrying an already-open frame. **This is
`WO-0058` bound 7's own convicting class** and the reason the round exists.

**Required consequence**: `M03-N2` sub-cases **4, 5 and 6** redden. §4 governs how
the three are scored and why a rendering that reddens only two is recorded as
**short**, not as a kill.

#### 1.1 MANDATORY DISCLOSURE **D-A1** — the axis that decides how much of bound 7 is scored

**On what does your non-recognition key?** Exactly one of:

- **L** — the `/S/`'s **lane alone**. Any lane-4 `/S/` fails to abort, regardless
  of what is open.
- **O** — the lane **and** *some* frame being open on entry to the word.
- **F** — the lane **and** the aborted frame being in the **`Frame`** state
  (already delivering octets) on entry to the word.

This is not a stylistic question. Bound 7's three instances split on it: two enter
their word in `Frame` state and one in `Preamble` state, and **L** additionally
reaches two units whose lane-4 abort has nothing open on entry at all. A
manifest that does not answer **D-A1** is scored under the widest branch and
every disagreement is a finding against the manifest.

#### 1.2 MANDATORY DISCLOSURE **D-A2** — what the unrecognised `/S/` then routes to

Removing one decode condition does not delete the character. **Where does the
lane-4 `/S/` land in your rendering?**

- **E** — it falls through to the design's existing handling for *a control
  character other than `/T/` inside a frame*, i.e. REQ-102/REQ-105. **This is the
  expected consequence of a minimal diff** and the branch the seal derives.
- **P** — it is consumed as a data octet, with no routing at all.

**P is admissible but is a second defect riding the first**, and the seal marks
its cells **UNWORKED** with adjudication pre-fixed (§6 disposition 6). Prefer **E**;
if your diff produces **P**, say so before the run — a disclosure made before
running costs nothing, the same fact read off a scorecard is a finding.

### IC-B — the zero-delivered close is mis-scored

REQ-107's zero-delivered close — the frame that a `/T/` closes having received no
octet at all (§9 ruling 9's sub-5 class, §0.7) — owes **exactly one `error_runt`
and no output word whatsoever**. Break exactly that.

#### 1.3 MANDATORY DISCLOSURE **D-B1** — which half you broke

- **W** — the close **emits an output word** (a `tvalid` word for a frame that
  must deliver none; a `tkeep` = 0 or otherwise empty `tlast` is the natural
  shape).
- **R** — the close's **report is suppressed** below a delivered-octet floor
  (`delivered > 0` gating `error_runt`).

Both satisfy IC-B and both redden all six N sub-cases; they differ in **which
assertion speaks**, and the seal branches on it.

#### 1.4 MANDATORY DISCLOSURE **D-B2** — the scope, narrow or wide

Is the mis-scoring scoped to **REQ-107's** zero-delivered close, or to **every**
no-output-word closure — REQ-105's and REQ-110's alike? The answer moves the
predicted set from ten units to eighteen. `WO-0058` FINDING GH-2 and `WO-0061`
FINDING S-4 were the same failure twice — a disclosure function with no column
for the dimension that decided the result — and `WO-0063B` §1.1 was the third.
This is that column, named a fourth time and before the diff exists.

### IC-C — the coincidence is serialised

Given two frame-ending events pinned by §9 to **one cycle** under **different**
strobe names, delay one report by a cycle. **Report path only: no word moves, no
`tkeep` changes, no octet count changes, no `tuser` marking appears or
disappears.**

**Required consequence**: `M03-N2` sub-cases **3, 4 and 6** redden and sub-cases
**1, 2 and 5** stay **green**. The green half is not decoration: 1, 2 and 5 pin
their two reports a cycle apart *by their own stimulus arithmetic*, so a class
that moves reports generally rather than coincident ones reddens them too — and
then IC-C's red at 3/4/6 is blast radius and the coincidence is not what was
measured.

### IC-D — REQ-113's ignore rule is carried into a preamble position

REQ-113 orders a control character other than the start character occurring
**outside** a frame to be ignored. A preamble position is **inside an open
frame**, where REQ-102's third sentence demands one `error_bad_frame` and no
output word. Render a design that applies REQ-113's ignore rule there.

**Required consequence**: `M03-B2`'s `/I/` unit reddens, and its `/E/` unit stays
**green**. `/E/` is the control and it is load-bearing: an `/E/` in a preamble
position routes to REQ-105 under *both* the specification's reading and a design
that simply treats preamble positions as frame positions, so a rendering that
reddens `/E/` too is **not** IC-D — it is a general preamble-routing defect, and
§6 disposition 5 governs.

#### 1.5 MANDATORY DISCLOSURE **D-D2** — does the ignore reach `/Q/`?

Is the carried-in ignore keyed on the **idle code** alone, or on **any control
character REQ-113 would ignore outside a frame** (which includes the sequence
ordered set)? Narrow reddens the `/I/` unit only and the campaign scores **1 of
2**; wide reddens both.

### IC-E — the runt check is sequenced on the abort path

§9's runt rows key on *"octets between start and terminate"*, and an
**aborted** frame has no terminate: the runt check is sequenced at REQ-106's exit,
which an `/S/`-aborted frame never takes. Render a design that applies the runt
test to the abort path anyway, so an aborted frame below the floor pulses
`error_runt` **in addition to** `error_start_without_terminate`.

**This is trap T8's own class.** `test_m03_n.ml` asserts it at two members today
and **no campaign has ever killed it**.

#### 1.6 MANDATORY DISCLOSURE **D-E1** — does your floor include zero?

Is the predicate `delivered < 5`, or `0 < delivered < 5`? The first reaches the
zero-delivered sub-cases and three units outside family N; the second reaches only
the two four-octet members. Both are IC-E; they are scored on different sets.

### IC-F — the preamble-position routing is a closed code table

REQ-102's third sentence is **extensional** — *"any other control character"* —
and SPEC-M03 §6.2's `Preamble` row says the same in the same shape, naming `/I/`
**and `/Q/`**. Render a design whose preamble-position routing is instead a
**closed enumeration** (`/T/` → REQ-107, `/S/` → REQ-110, `/E/` → REQ-105,
`/I/` → REQ-105) that **falls through** on any code outside it.

**Required consequence**: `M03-B2`'s `/Q/` unit reddens; its `/I/` and `/E/` units
stay **green**. This is the only class in the campaign that distinguishes
*routing by the control bit* from *routing by an enumeration*, and the `/Q/`
member is the only stimulus in the plan that can see it.

#### 1.7 MANDATORY DISCLOSURE **D-DF1** — shared by IC-D and IC-F: what does the un-exited preamble do?

When the character is ignored (IC-D) or falls through the table (IC-F), does the
frame:

- **C** — **continue**? The preamble runs on, the SFD is accepted, and the frame
  delivers its octets normally. This is the REQ-008 *silent-discard hole's*
  loud twin and the branch the seal derives.
- **S** — **stop silently**? The frame ends with no output word and **no report at
  all** — REQ-008's silent-discard hole itself.

Both are the class. They speak through different assertions and the seal branches
on it.

---

## 2. The denominator, and one correction against my own prior seal

Re-measured at the base SHA by `bash tools/dv_checks.sh`, whose inventory block is
the provenance:

```
    3  test_m03_a.ml    7  test_m03_b.ml    4  test_m03_c.ml    3  test_m03_d.ml
    4  test_m03_e.ml    4  test_m03_f.ml    7  test_m03_g.ml    4  test_m03_h.ml
    5  test_m03_i.ml    6  test_m03_n.ml    1  test_m03_structural.ml
  ---
   48  test/xgmii_rx_64/ (the M03 bench)
  128  test/ (repository-wide)
```

**48 M03 units; 128 repository-wide; 80 non-M03.** The non-M03 80 is unchanged
across all five prior campaigns and is the stability check on the measurement: the
repo-wide figure moved from `WO-0063B`'s 119 by **exactly the nine units** family
B's completion and family N's first file added, and by nothing else.

### 2.1 The blast-radius claim, corrected — the non-M03 80 is not uniformly DUT-independent

`WO-0063B`'s seal §0 said *"only `test/xgmii_rx_64/dune` declares
`hardcaml_ethernet` among the bench libraries containing `%expect_test`s"*.
**Measured at this tree, that is wrong**, and the correction is mine:

| directory | units | relation to the DUT |
|---|---|---|
| `test/xgmii_rx_64/` | **48** | the M03 bench — the campaign's whole behavioural surface |
| `test/hardcaml_ethernet/` | **1** | **declares `hardcaml_ethernet`** and names no M03 module |
| `test/monitors/`, `test/xgmii/`, `test/golden/`, `test/axi64_probe/`, `test/xgmii_probe/` | 37 + 25 + 11 + 3 + 3 = **79** | DUT-independent by their own dune stanzas |
| `test/cosim/`, `test/cost_probe/`, `test/third_party/`, `test/attack_plans/` | 0 | no `%expect_test` at all |

**Consequence, stated before the run**: a red at `test/hardcaml_ethernet/`'s single
unit is a **build-level finding — a mutant that does not compile — and never a
behavioural one**. A red anywhere in the DUT-independent 79 is a finding of a
third kind: neither behaviour nor build, but a manifest that reached outside its
own file. The old sentence would have scored the first of those as the second.

---

## 3. The convicting sets, measured rather than remembered

**Method, so it is checkable**: every `Dv_monitors.Strobe_monitor.expect`
registration under `test/xgmii_rx_64/*.ml` was enumerated and classified by the
`cycle` field it registers and the `why` it states — **no-output-word pin** (two
cycles after the input word carrying the closing character) or **`tlast`-pinned**.
Classification is by the registration's own text. The nine no-output-word units
`WO-0063B` §2 measured are unchanged; **nine more registrations landed with the
eleven new members**, and the set is now:

| unit | registration | strobe | pin class |
|---|---|---|---|
| M03-B2 `/E/` | `test_m03_b.ml:1014` | `error_bad_frame` | no-output-word |
| **M03-B2 `/I/`** | `:1259` | `error_bad_frame` | **no-output-word** |
| **M03-B2 `/Q/`** | `:1259` | `error_bad_frame` | **no-output-word** |
| M03-B3 | `:813` | `error_runt` | no-output-word |
| M03-B4 (a) | `:348` | `error_start_without_terminate` | no-output-word |
| **M03-B4 (b)** | `:601` | `error_start_without_terminate` | **no-output-word** |
| M03-E2 | `test_m03_e.ml:429` | `error_bad_frame` | no-output-word |
| M03-E5 | `:731` | `error_bad_frame` | no-output-word |
| M03-F2 | `test_m03_f.ml:425` | `error_runt` | no-output-word |
| M03-G7 | `test_m03_g.ml:1375` | `error_runt` | no-output-word |
| M03-H4 | `test_m03_h.ml:939` **and** `:951` | `error_start_without_terminate` ×2 | no-output-word ×2 |
| M03-I2 (member iii) | `test_m03_i.ml:714` | `error_runt` | no-output-word |
| **M03-N2 ×6** | `test_m03_n.ml:497` **and** `:509` | `error_start_without_terminate`, `error_runt` | frame B always no-output-word; frame A no-output-word at sub-cases 3 and 6, `tlast`-pinned at 1, 2, 4, 5 |

**Eighteen units carry a no-output-word expectation** at this SHA, against nine one
campaign ago. That doubling is what IC-B's **D-B2** disclosure ranges over.

### 3.1 The two lane-4 in-word aborts that already exist, and why D-A1 exists because of them

`M03-B4` member (a) and `M03-H4`'s word `c` both drive a `/S/` in **lane 4** of a
word — an in-word abort — with **nothing open on entry**, because in both the
aborted frame opened in that same word at lane 0. They have bound 7's *first*
conjunct and not its second (`WO-0065` T1, `WO-0058` FINDING GH-2's own
dimension). Under **D-A1 = L** they redden; under **O** and **F** they do not.
**Naming them here is what stops two true greens, or two true reds, from being
scored as findings against the manifest.**

---

## 4. Bound 7 — SCORED, never asserted, with the three instances DISTINGUISHED

`WO-0058` bound 7 asked for **an in-word REQ-110 abort with a frame already open
on entry**. `M03-N2` pays it at **three** instances, and a campaign that scores
*"three bound-7 instances"* without saying which is which has recorded a count and
called it a coverage. The split, derived at `RV-0065B-VERDICT` §6 from
`requirements.md` §0.3/§0.5's lane mapping and SPEC-M03 §6.2's state table:

| instance | frame A's state **on entry to W** | why that state | `/S/` landing | A delivered |
|---|---|---|---|---|
| **sub-case 4** | **`Frame`** | A's SFD is consumed at lane 7 of the preceding word; A enters W already delivering | lane 4, in-word | 4 |
| **sub-case 5** | **`Frame`** | A's octets 0…3 occupy lanes 4…7 of the preceding word | lane 4, in-word | 8 |
| **sub-case 6** (lane-4-start) | **`Preamble`** | A's SFD lands at lane 3 of W itself; A enters W with preamble positions still pending | lane 4, in-word | 0 |

§9's closure list makes all three **open** on entry (*"open from the cycle M03
accepts its start character"*), so bound 7's second conjunct holds at each.

**The scoring rule, fixed before the result:**

1. **IC-A red at all three → bound 7 scored 3 of 3.** The verdict may then say
   the bound's conjunction is *detected*, in both its state shapes.
2. **IC-A red at sub-cases 4 and 5 only → bound 7 scored 2 of 3, and the verdict
   says SHORT, naming the `Preamble`-state instance as the unscored one.** This is
   the expected outcome under **D-A1 = F** and it is a legitimate rendering, not a
   defect in the manifest. **It may not be rounded to a kill of the bound.**
3. **IC-A red at sub-case 6 only, or at 6 and one of 4/5 → the rendering does not
   key on the conjunct the bound is about**; the class is reported and the bound
   is scored **0 of 3**.
4. **Bound 7 is not "closed" by any outcome of this round.** It is *paid* by the
   bench (`RV-0065B-VERDICT`) and *scored* here. The bound leaves my carried list
   when the plan records both, and not before.

---

## 5. Reachability, discharged term by term — both sides

**R-DISC-1 binds your manifests** (`DISP-0001` §4). For **each** of the six
classes separately: name the gate signal, quote its **complete** defining
expression from the base file with line numbers, and evaluate **every** conjunct
on the named stimulus at the claimed firing cycle, calling out which conjuncts are
contributed by the **stimulus** rather than by the mutation. Where a landing
condition is modular, write it as arithmetic and show it satisfied at the value
the required consequence names, with the recurrence set **enumerated rather than
assumed unique**.

**Per-lane and per-sub-case evaluation is required where the class's own
consequence names more than one.** IC-A names three sub-cases whose aborting `/S/`
lands at three different octet times in two different words; IC-D and IC-F name
two start lanes at which the injected character lands in lane 3 and lane 7
respectively. **A conjunct satisfiable at one lane is not thereby satisfiable at
the other**, and a sub-case or lane you did not evaluate is **NOT SEEDED** for
scoring purposes.

**R-DISC-2**: IC-A, IC-B, IC-C and IC-E all name the **report path**; IC-B(W)
additionally names the **output-word path**; IC-D and IC-F name the
**preamble-exit decode**. Each gets a gate-inventory row carrying its full term
list and every intent's claim about it, **before delivery**. Where two classes
touch the same term, say so — that is a cross-class gate fact and §7's allowlist
requires it **tabulated, not discovered**.

**And the same standard applies to me, on the bench side, discharged here.** Every
`R!` cell in the seal is a message raised by an assertion whose own terms are:

- **(a)** the stimulus reaches the assertion — every `M03-N2` sub-case is its own
  `%expect_test` unit calling `run_subcase` exactly once, so **no sub-case is
  shadowed by any other sub-case**, and each of the six is independently
  observable in the same run. (This is the structural difference from `WO-0063B`,
  whose six simulations shared one unit, and it is why this campaign's N cells do
  not need that round's shadowing carve-out.)
- **(b)** the observable is read from the DUT's own outputs under the `Before`
  view (`bench.mli`), so no relabelling stands between the pulse and the check;
- **(c)** every assertion ordered **before** the scored one is unmoved under the
  class — discharged per class at §6 for the three that claim not to touch the
  datapath;
- **(d)** nothing outside the unit is required for the conviction.

---

## 6. §4(c) as a test, not as prose — and this round it has a domain

`WO-0063B` §4 measured a datapath-perturbation signature and then had to record
that the signature **had no domain** at the unit it was scoring, because member
(iii)'s conformant emitted stream is empty. **That is not true here**, and it is
the round's one methodological gain.

**The measured signature** (`BUG-0003` §V.10.2, `J-dv_lead-0103`, transient tree
`5c47582`): **(a)** 7 mid-frame words with `tkeep` ≠ 0xFF and `tlast` = 0;
**(b)** 4 of 60 required octets in their gapless byte positions, 28 delivered as
the idle filler `0x07` and **28 never delivered at all**; `tlast` on word 7;
`tuser` = 0 on a corrupted frame.

**Three of the six classes claim the datapath does not move**: **IC-C**,
**IC-B(R)** and **IC-E**. For those three, and only those three:

1. **The auditor's pre-ship check.** Before delivering the manifest, confirm the
   rendering produces **none** of the signature's components on a *delivering*
   stimulus. A rendering that produces any of them is not the class; it is the
   class plus a datapath defect, and the two cannot be scored apart.
2. **My adjudication check, and it is executable here.** `M03-N2`'s four
   delivering sub-cases assert **frame A's `tlast` cycle, its `tkeep`, its
   `tlast` bit and its `tuser`[0]** — and all four are evaluated **before** the
   strobe check that the three classes are scored on. So a rendering that moves
   the datapath raises with a **datapath** message:

   ```
   frame A's own tlast word did not arrive on its own pinned cycle
   frame A's own tlast word tkeep does not match the delivered count
   frame A's own single delivered word does not carry tlast
   frame A's own tlast word does not carry tuser[0] = 1 (REQ-110)
   expected exactly one delivered word for frame A, got <n>
   ```

   and **never** with the strobe message the class is scored on.

**Consequence, fixed here so it cannot be renegotiated**: for IC-C, IC-B(R) and
IC-E, a red carrying any of those five messages scores as **the class out of
specification — reported, not scored**, and no claim about the affected row is
made in either direction. **IC-A, IC-B(W), IC-D and IC-F move the datapath by
design** and this check does not apply to them; saying so is the difference
between a check and a ritual.

---

## 7. The allowlist, and what the manifests must carry

**Allowlist for the campaign's duration** — the auditor reads:

- `libs/hardcaml_ethernet/src/xgmii_rx_64.ml` and its `.mli`, **at the base SHA**
  (the mutation target);
- `docs/specs/requirements.md` and `docs/specs/modules/xgmii_rx_64.md`;
- **this packet**;
- `docs/reports/audit/**`, its own scope.

**Out of bounds, absolutely, for the campaign's duration**: all of `test/**` —
which includes the bench, `test/xgmii/`, `test/monitors/` **and
`test/attack_plans/AP-xgmii_rx_64.md`** — all of `agents/**`, **this packet
excepted and its sealed companion emphatically not excepted**, and every journal.
The seal names cells, message strings and assertion orders; reading it is reading
the answer.

**The manifests must carry**, per R-DISC-1 / R-DISC-2:

1. **Six diffs** — IC-A, IC-B, IC-C, IC-D, IC-E, IC-F — each **minimal and
   independent**: each applies alone to the base SHA, elaborates, and reverts
   cleanly. **No diff may combine two classes**; a combined diff makes both
   unscoreable.
2. **A reachability discharge per class, per named sub-case and per named lane,
   term by term at the firing cycle**, with the stimulus-contributed conjuncts
   called out — or a **self-declared NOT SEEDED** for any term you cannot
   discharge.
3. **Gate-inventory rows** for the report path, the output-word path and the
   preamble-exit decode, with every class's claim about each (R-DISC-2), and
   **cross-class gate facts tabulated** — every term two classes both touch,
   named before delivery.
4. **All seven disclosures answered in your own words**: **D-A1**, **D-A2**,
   **D-B1**, **D-B2**, **D-D2**, **D-DF1**, **D-E1**.
5. **The §6 pre-ship check result** for IC-C, IC-B(R) and IC-E.
6. **The base SHA you applied to**, quoted, and confirmation that it matches §8's.
7. **Anything the packet made you guess.** Per the `WO-0063B` precedent, a
   question about this packet comes to me as a committed **pre-run reading note**
   **before** the run, and I answer it in the same form. A question answered after
   a scorecard exists is not a question, it is a negotiation.

---

## 8. The base SHA, and the adjudicator-ordering rule

**One base SHA for the whole round** — all six classes, the control run and every
MUST-STAY-GREEN sweep. `BUG-0003` §V.9's *"one round cannot carry two base SHAs in
its evidence"* governs.

**The base SHA is the commit that this packet's own commit immediately
follows** — i.e. the commit carrying the `tools/dv_checks.sh` boundary-matched
row census (`J-dv_lead-0114`), which is the **parent** of the commit staging this
packet and its seal. I cannot state its hash: I never run git (PROTOCOL §2), and
it has none until the orchestrator creates it. **The orchestrator verifies that
identity at commit time and records the hash in its own trailer**; the auditor
quotes the hash it applied to (§7 item 6), and any disagreement is a finding
**before** the campaign runs, not after.

**Why the base carries a `tools/` commit and not a `test/**` one.** The census fix
was commissioned at `RV-0065B-VERDICT` §7.1 and had to land somewhere. It is under
`tools/`, so it moves **no byte the campaign scores against** — which is exactly
why it may ride the parent commit, and why the two `test/**` debts that were
commissioned with it do **not** (§10).

**The adjudicator-ordering rule, stated because it is what makes any of this
evidence.** **The bench must be frozen strictly earlier in history than any mutant
RTL it judges.** Concretely:

- Every `test/**` byte this campaign scores against is at or before the base SHA.
  The last `test/**` edit was `RV-0065B-VERDICT`'s comment-only repair to
  `test_m03_n.ml` at `fa91964`; **nothing under `test/**` moves again until the
  campaign scores.**
- The seal is frozen in this packet's own commit — **after** the last bench edit
  and **before** the first mutant diff exists.
- If any `test/**` file is edited between this commit and the scorecard, **the
  round is adjudicated as having no valid base** and re-runs from a fresh seal.
  **That includes edits by me**, and §10 is where I hold myself to it.

**Why the rule is not ceremony**: a bench edited after a mutant exists can be tuned
to it, and no reader downstream can distinguish a bench that always would have
convicted from one that was taught to.

---

## 9. Mutant-owned quantities, and how they are sealed

A quantity is **mutant-owned only if the specification does not fix it**. Every
such quantity is sealed as an **inequality with a named direction**, never as a
value; a seal that pins a rendering's own arithmetic scores a correct rendering as
a finding.

| quantity | sealed as | direction, and why |
|---|---|---|
| the observed pulse **count** at a sub-case under IC-A, IC-B(R), IC-E | `≠ 2`, with the derived value stated | the classes add or remove a report; the exact tail integer is the rendering's |
| the deferred pulse's **cycle** under IC-C | `observed ≠ the pinned cycle` | **later** — IC-C defers, it never advances. An earlier pulse is not this class |
| the observed **word count** for frame A under IC-A, IC-B(W) | `≠ 1`, with the derived value stated | fewer under IC-A(E) (the frame is suppressed), more under IC-B(W) (a second frame emits) |
| **which** strobe names appear at a sub-case | **not mutant-owned** — `{error_start_without_terminate, error_runt}` | §9's closure list and ruling 9's sub-5 class fix both names. A third name is a finding, not a rendering fact |
| frame B's **output words** at every sub-case | **not mutant-owned** — `= 0` | §0.7. Nonzero is IC-B(W) by definition and out of specification for every other class |
| `error_bad_fcs` at any sub-case | **not mutant-owned** — **absent** | REQ-103/REQ-110: no FCS removal is attempted on a frame with nothing to remove it from. Its appearance under any class is a finding |
| units reddening under a class | `⊆` the seal's own predicted set for the disclosed branch | a red **outside** it is a finding: either my enumeration was incomplete or the diff reaches further than the class it names |

Four of the seven are specification-fixed and are sealed as **equalities on
purpose**; calling them mutant-owned would be buying an unfalsifiable seal.

---

## 10. What this round does NOT close, and where the two carried debts land

**Named before the result, so no omission is invisible.**

1. **`bench.mli`'s `_frame`/`_piece` naming axis has no cell** for a genuine
   `Arrival.frame` whose received extent is shorter than its declared array —
   every REQ-110-aborted declared frame, which is most of `M03-N2`. It is a
   documentation debt and it is **mine**. **It does NOT land in this round, and
   the reason is §8**: `bench.mli` is under `test/**`, and moving one comment
   there would cost the sentence *"nothing under `test/**` moves again until the
   campaign scores"* for zero measurement gain. **Carrier, named and dated: the
   family-J bench-capability round**, which must open `bench.mli` anyway to give
   `cfg_rx_enable` a schedule, and which `RV-0065B-VERDICT` §7.2 dates to the
   round immediately following this seal.
2. **Fold-in 3 — cross-checking frame A's delivered *content*, not only its
   count, at `M03-N2`'s four delivering sub-cases.** A standing undischarged
   strengthening, correctly declined at `RV-0065B` because §12 marked it
   *"optionally"*. **It does not land here either**, and for the same §8 reason.
   **Carrier, named with a dated fallback**: the first round that opens
   `test/xgmii_rx_64/test_m03_n.ml` — which is the `M03-N1`/`M03-N4` bench round,
   both still outstanding ASSERT rows whose home that file is; **and if no such
   round is scheduled by the time family J's capability round returns, it is
   commissioned as a rider on that round's `RV-`.** An undated carrier is how a
   debt becomes a habit.
3. **No `SO-xgmii_rx_64.md` issues and none is offered.** This round scores six
   classes against eleven members. Nineteen ASSERT rows are still outstanding and
   the module sign-off's mutation clause (`N/N`, charter §3) is not what a
   single-family campaign discharges.
4. **A kill proves the assertion convicts, never that the bench is a general
   detector of the class.** Several classes below are already caught outside the
   new eleven — §3's table says which — and §11 prices it.
5. **SPEC-M03 §6.3 item 8 stays untested and is a CLOSED question, not an open
   coverage item** (`RV-0065B-VERDICT` §6 item 3). All three coincidences in
   `M03-N2` are **different-name**; the carve-out forbids the same-name stimulus
   in terms (*"DV SHALL NOT produce one"*). No result of this round may be read as
   touching it.
6. **`WO-0061` §8 bound 1's `tkeep` half** at an injected run stays unmeasured.
7. **`run_i2_member`'s deliberate citation exception** stays as it is: its string
   is quoted verbatim in a scored campaign's frozen seal.

---

## 11. Weighting, discounted in advance

**In favour of this round, and it is the strongest weighting any campaign in this
programme has had**: none of the eleven members was authored with a mutation class
known. `WO-0063B`'s discount — *"the first unit in this programme written with its
mutation class known"* — **does not apply to a single cell here**. The classes were
derived from the specification's own report path and routing rules; the members
were derived from the plan's rows months of packets earlier.

**Against it, three ways, all stated before the scorecard:**

1. **IC-B and IC-E are detected outside family N.** §3's eighteen-unit table is
   the measure: under **D-B2 = wide** IC-B is caught at eight units that predate
   the new eleven. **No verdict may imply the bench was blind to it.**
2. **IC-C is the only class whose entire convicting set lies inside the new
   eleven**, because no other unit in this bench pins two reports to one cycle
   (`M03-H4`'s two land at `c + 2` and `c + 3`; `M03-G7`'s at the truncation cycle
   and ~10 cycles later). **IC-C is therefore the round's own measurement**, and
   it is also the class most exposed to a datapath-perturbing rendering — which is
   why §6 exists in the form it does.
3. **IC-A's value is bounded by D-A1 and the bound is not mine to set.** Under
   **F** the campaign buys two of bound 7's three instances. That is a real result
   and a partial one, and §4 rule 2 forbids reporting it as anything else.

---

## 12. What comes back

1. The **six manifests** per §7.
2. **All seven disclosures**, in the auditor's own words.
3. The **§6 pre-ship check** result for the three datapath-silent classes.
4. The **full scorecard**: every unit red or green under each class, at the base
   SHA, with the **raised message at every red — the message, not a summary of
   it**, because the seal's cells are message-level. Where a unit raises inside a
   `List.iter` over lanes, the **row prefix** distinguishes the lane and must be
   reproduced.
5. The **control run**: the unmutated base SHA green, with its **CI run id and
   conclusion**. **CI is the authority** (ADR-0005); *"passes locally"* is not
   admissible from the auditor, the orchestrator or me.
6. Anything judged rather than followed, and why.

**Adjudication is mine**, against the sealed file, which is opened **only after
the scorecard is in hand**.

---

## 13. Not to be told

The sealed companion in its entirety: its matrix and its MUST-STAY-GREEN
denominators, its verbatim message cells, the assertion order inside
`run_subcase` and `run_b2_new`, its UNWORKED adjudication rules, its
disclosure-branch tables, and its bound-7 scoring cell.

**Freely told, and told above**: the six classes and why two of the five foreseen
were split; the seven mandatory disclosures; §2's denominator and its blast-radius
correction; §3's measured convicting sets; §4's bound-7 scoring rule and the
three instances' state split; §5's reachability standard; §6's signature, its
domain and its five datapath messages; §7's allowlist and manifest bars; §8's base
SHA and the ordering rule; §9's mutant-owned inequalities; §10's non-closures and
carriers; §11's weighting; §12's return format.

---

## Return / verdict log

*(empty — the auditor appends its return here, and dv_lead its verdict.)*

## WO-0066-VERDICT — dv_lead, `J-dv_lead-0117`

**Result: 6 classes seeded, 6 scoreable, 6 KILLED — 6/6.** Every class reddened
its sealed `R!` set, every control held, and **28 of 29 REQUIRED cells hit
character-for-character**. **`WO-0058` bound 7 is scored 3 of 3**, in both state
shapes, under §4 rule 1.

**And the round produced five findings, all five mine, one of which retires a
claim this programme has carried through six packets.** The manifest is accepted
with no defect: six minimal independent diffs, all seven disclosures accurate
against the delivered diffs, R-DISC-1/2 discharged, the §6 pre-ship check
confirmed by measurement, and a containment clause that caught two units my own
enumeration missed.

---

### 0. The measurement, and the preconditions I re-checked rather than assumed

| class | run | branch | units red |
|---|---|---|---|
| IC-C | **30968238533** | `mut/wo-0066-icc` | 3 |
| IC-D | **30968239697** | `mut/wo-0066-icd` | 2 |
| IC-F | **30968240974** | `mut/wo-0066-icf` | 1 |
| IC-B | **30968242482** | `mut/wo-0066-icb` | 10 |
| IC-E | **30968243105** | `mut/wo-0066-ice` | 7 |
| IC-A | **30968244496** | `mut/wo-0066-ica` (`c80f545`) | 5 |

All six builds completed **FAILURE**, which **is** the measurement — a killed
mutation is what a red suite looks like. The `journal-check` reds are the known
throwaway-ref class and bear on nothing.

**Re-checked by me at adjudication time, because §8's ordering rule is not
discharged once:**

1. **`git diff --name-only 199e319 HEAD -- test/ libs/` → empty.** Not one byte
   of bench or RTL has moved since the base. **The bench that judged these
   mutants is the bench frozen strictly before they existed.**
2. The three commits since the base — `ebaac58`, `8869705`, `b26354d`
   (and `fb27764`) — touch **handoffs, audit reports, journals and the board
   only**, verified path by path from `git show --stat`.
3. **The seal was opened only after all six scorecards existed**, and **is not
   edited by this verdict.**

---

### 1. IC-C — the coincidence serialised. **KILLED**, disposition 1

**Three units red. Three predicted. Zero outside. All three messages
character-exact.**

```
M03-N2 (S lane 0, A lane 0, zero-delivered): expected exactly error_start_without_terminate and error_runt, both on the same cycle, under DIFFERENT names (T10) -- no error_bad_fcs (T9)
M03-N2 (S lane 4, A lane 4, zero-delivered): expected exactly error_start_without_terminate and error_runt, both on the same cycle, under DIFFERENT names (T10) -- no error_bad_fcs (T9)
M03-N2 (S lane 4, A lane 0, delivered): expected error_start_without_terminate at A's own cycle and error_runt at B's, and nothing else (T8/T9)
```

**Seal §4.3, verbatim, including the two-message split.** The seal said *"a seal
that quoted one string for all three would score a correct rendering as a finding
at two cells"* — sub-cases 3 and 6 took the zero-delivered branch and sub-case 4
the delivered branch, exactly as derived.

**The three REQUIRED GREENS held.** Sub-cases 1, 2 and 5 stayed green, so
**disposition 2 does not fire** and the class measured the coincidence rather
than reports in general. That green half is what makes the red half mean
anything.

**Raise sites prove the row-local instrument spoke**: `test_m03_n.ml:554` and
`:614` — both step 8(b). `assert_monitors_clean` (`:643`) never executed, so
**disposition 4 does not fire**. As at `WO-0063B`, **the standing
`Strobe_monitor` spoke nowhere**, predicted in seal §9(g) and confirmed.

**MUST-STAY-GREEN: 45 of 45 (M03), 79 + 1 (non-M03).** **Kills: 1.**

---

### 2. IC-D — REQ-113's ignore rule in a preamble position. **KILLED**, disposition 1

**Two units red, both predicted at D-D2 = wide; the control green.**

```
M03-B2 (/I/, lane 0): frame 1: an output word was observed for a frame that must deliver nothing (§0.7) -- the run's first delivered word arrives before frame 2's own first word could
M03-B2 (/Q/, lane 0): frame 1: an output word was observed for a frame that must deliver nothing (§0.7) -- the run's first delivered word arrives before frame 2's own first word could
```

Seal §4.4's **branch C** cells, character-exact (`\194\167` decoded to `§`), and
**D-DF1 = C is confirmed by the raise site** — `test_m03_b.ml:1297`, the
output-word check, not the pulse check.

**`M03-B2`'s `/E/` unit stayed GREEN.** Seal §9(c) made that control load-bearing:
an `/E/` routes to REQ-105 under both readings, so a rendering that reddened it
would have changed the outcome for every character rather than the routing for
the ones REQ-113 misses. It did not. **Disposition 2 does not fire.**

**Both reds are at lane 0**, exactly as seal §5.3 pre-fixed: `List.iter [ 0; 4 ]`
runs lane 0 first, so the lane-4 cells are **structurally unobservable** in a
passing-to-failing run. The auditor discharged R-DISC-1 **per lane** (manifest
§3), so lane 4 is **reachable by term-by-term evaluation and merely unobserved** —
recorded as unobserved, never as a miss and never as a pass.

**MUST-STAY-GREEN: 46 of 46 (M03), 79 + 1.** **Kills: 1.**

---

### 3. IC-F — the closed code table. **KILLED**, disposition 1 — and the discrimination held

**One unit red. One predicted.**

```
M03-B2 (/Q/, lane 0): frame 1: an output word was observed for a frame that must deliver nothing (§0.7) -- the run's first delivered word arrives before frame 2's own first word could
```

**`M03-B2`'s `/I/` unit stayed GREEN, and its `/E/` unit stayed GREEN.**

**This is the pair of results the round most needed and the one it was least sure
of.** Seal §4.4 recorded that IC-D and IC-F produce **identical strings** and that
*"the only discriminator is which diff was applied"* — so the campaign's ability
to tell them apart rested entirely on running them as separate transients in the
order the reading note fixed. The scorecards show exactly the predicted
asymmetry: **IC-D reddens `/I/` and `/Q/`; IC-F reddens `/Q/` alone and leaves
`/I/` green.** **Disposition 6 does not fire** — no red carries a combined-class
signature, and the two classes are distinguished by measurement rather than by
assertion.

**The `/Q/` member is thereby qualified on the class it was written for.**
`WO-0065` §3.2.1 drove `/Q/` rather than declaring it, over a `REQ-018` objection
I overruled on the module spec's own `Preamble` row. That ruling is now paid for:
`/Q/` is the only stimulus in this plan that separates routing **by the control
bit** from routing **by an enumeration**, and it has now done so.

**MUST-STAY-GREEN: 47 of 47 (M03), 79 + 1.** **Kills: 1.**

---

### 4. IC-B — the zero-delivered close mis-scored. **KILLED**, disposition 1, scored on branch R per the reading note

**Reading-note ruling 2 applied and cited by name.** The auditor disclosed
**D-B1 = R** and declared branch `W` unrenderable at this design. Under the
reading note's **disposition 8, VOID BY DISCLOSURE**, the `W` column's cells are
**not scored, contribute zero kills, and are findings in neither direction**; the
class is scored on the **R narrow** column alone, and seal §5.2's UNWORKED cell at
sub-case 4 is **moot** — void by disclosure, not by the one-word-per-cycle
argument.

**Ten units red. Ten predicted. Zero outside.** All six N cells carry the
**identical body** with the derived `<n>` = **1**, differing only in prefix:

```
M03-N2 (S lane 0, A lane 0, delivered):      expected exactly two strobe pulses over the WHOLE run, observed 1
M03-N2 (S lane 0, A lane 4, delivered):      expected exactly two strobe pulses over the WHOLE run, observed 1
M03-N2 (S lane 0, A lane 0, zero-delivered): expected exactly two strobe pulses over the WHOLE run, observed 1
M03-N2 (S lane 4, A lane 0, delivered):      expected exactly two strobe pulses over the WHOLE run, observed 1
M03-N2 (S lane 4, A lane 4, delivered):      expected exactly two strobe pulses over the WHOLE run, observed 1
M03-N2 (S lane 4, A lane 4, zero-delivered): expected exactly two strobe pulses over the WHOLE run, observed 1
```

Seal §4.2's B(R) block, **six for six, character-exact**, with the mutant-owned
quantity sealed `< 2` and observed at the derived **1**.

The four `r` cells all reddened as predicted — `M03-B3`, `M03-F2`, `M03-G7`,
`M03-I2` member (iii) — each with its own idiom, none a finding, none a kill.

**§6's datapath discriminator, confirmed by measurement rather than by
argument.** At sub-cases 1, 2, 4 and 5 the raise is the **pulse** message, which
means every check ordered before it — frame A's `tlast` cycle, its `tkeep`, its
`tlast` bit and its `tuser`[0] — **passed**. **Not one of §6's five datapath
messages appears anywhere in this class**, so the rendering is report-path-only as
claimed. The auditor's fan-out closure and my structural ordering agree by
measurement.

**D-B2 = narrow confirmed**: `test_m03_e.ml` and `test_m03_h.ml` are **absent**
from the failure set, so the eight `error_bad_frame` / `error_start_without_
terminate` no-output-word units stayed green exactly as the narrow scope
predicts.

**MUST-STAY-GREEN: 38 of 38 (M03), 79 + 1.** **Kills: 1.**

---

### 5. IC-E — the runt check on the abort path. **KILLED** at its scored cell — and my seal was wrong at three cells, exactly as the reading note predicted at two of them

**Reading-note ruling 1 applied and cited by name.**

#### 5.1 The scored cell — hit, character-exact

```
M03-N2 (S lane 0, A lane 4, delivered): expected exactly two strobe pulses over the WHOLE run, observed 3
```

Seal §4.5's single `R!` cell, **verbatim**, with the mutant-owned count sealed
`> 2` and observed at the derived **3**. **IC-E is KILLED. Kills: 1.**

#### 5.2 The `G✱` cells — GREEN at all three. The equivalent-mutant fact, confirmed

**`M03-N2` sub-cases 3, 4 and 6 stayed GREEN**, as seal §6 required and as the
auditor independently declared **NOT SEEDED**. Reading-note ruling 1's
concordance is **confirmed by measurement**, and the ground I adopted there is the
one that survives: at those three sub-cases the mutant's output is
**bit-identical** to a conformant design's, because §0.6 counts high cycles and
frame A's added `error_runt` lands on the cycle frame B's genuine one already
occupies. **This is an equivalent mutant, not an undetected one.**

**The consequence, restated at full strength and binding on every later packet**:
trap T8 is **asserted at two members and observable at one**, and **no bench
change reaches the other** — the limit is in the strobe interface, which reports
presence per cycle and not multiplicity. **No reader may take IC-E's kill as
evidence that T8 is instrumented at two members.**

#### 5.3 FINDING WO-0066-3, CONFIRMED — two MUST-STAY-GREEN violations, mine, exactly as pre-classified

**`M03-N2` sub-cases 1 and 5 reddened.** My seal marked both `G`.

```
M03-N2 (S lane 0, A lane 0, delivered): expected exactly two strobe pulses over the WHOLE run, observed 3
M03-N2 (S lane 4, A lane 4, delivered): expected exactly two strobe pulses over the WHOLE run, observed 3
```

Scored **exactly as the reading note pre-classified it, before any transient
ran**: a **MUST-STAY-GREEN violation against me**, under the **first** of my own
containment rule's two alternatives — *my enumeration was incomplete* — and never
the second. IC-E reaches precisely what IC-E says it reaches. The cause is
established from the specification, not from the diff: `requirements.md` §12
defines `error_runt` as **"fewer than 64 octets between start and terminate"**,
and seal §4.5 derived from a **sub-five** floor. Eight octets is also fewer than
sixty-four.

**Effect on the kill: none**, as pre-committed. The scored cell is sub-case 2.

#### 5.4 A THIRD violation the reading note did not foresee — same root cause

**`M03-H2` (lane 0) reddened**, and my seal named it nowhere:

```
M03-H2 (lane 0): expected exactly one strobe (error_start_without_terminate alone), observed 2
```

Same cause: an aborted frame that received **some** octets but fewer than 64. My
`r` set for IC-E listed only units whose aborted frame delivered **zero**
(`M03-B4` (a) and (b), `M03-H4` — all three red as predicted). **The auditor's
enumeration was correct where mine was short**: its predicted red set carried the
clause *"plus any unit driving a REQ-110 abort of a frame that received fewer than
64 octets"*, which covers `M03-H2` and which my seal had no equivalent of.

**MUST-STAY-GREEN: 41 of a sealed 44 held; 3 violated — sub-cases 1 and 5 and
`M03-H2`, all three mine.** Non-M03: 79 + 1 held. **Kills: 1.**

---

### 6. IC-A — the in-word abort, and bound 7. **KILLED** on its sealed set

#### 6.1 The predicted set — all three bound-7 sub-cases red

```
M03-N2 (S lane 4, A lane 0, delivered):      expected exactly one delivered word for frame A, got 0
M03-N2 (S lane 4, A lane 4, delivered):      expected exactly one delivered word for frame A, got 0
M03-N2 (S lane 4, A lane 4, zero-delivered): expected exactly error_start_without_terminate and error_runt, both on the same cycle, under DIFFERENT names (T10) -- no error_bad_fcs (T9)
```

**Sub-cases 4 and 5 are seal §4.1's cells character-exact**, with the mutant-owned
word count sealed `< 1` and observed at the derived **0** — the direction *fewer,
because the frame is suppressed*, confirmed.

**Sub-cases 1, 2 and 3 stayed green** (lane-0 `/S/`, a word-boundary landing), and
**`M03-B4` member (a) and `M03-H4` stayed green** — the two units **D-A1**
existed to decide. The auditor answered **O** and wrote *"a red at either is a
finding against me"*; neither reddened. **The disclosure is accurate and D-A1 = O
is confirmed by measurement.**

#### 6.2 FINDING WO-0066-5 — sub-case 6's sealed message is a MISS

Seal §4.1 predicted for sub-case 6 `expected exactly two strobe pulses over the
WHOLE run, observed <n>` with `<n>` = 1. The observed message is the **other arm**
of the same check — two pulses were observed, not one, and their **names** failed
rather than their count.

**The cause is a premise in my own derivation.** Seal §4.1 said *"under IC-A the
lane-4 `/S/` is not decoded as a start, so **frame B is never opened** at
sub-cases 4, 5 and 6 — that single consequence carries all three cells."* **It is
not that consequence.** IC-A narrows the abort *classification* of the frame open
on entry; the in-word epoch machinery that **opens** frame B is untouched, so B
still opens, still closes on the `/T/`, and still reports. Frame A, left open,
is then closed later as a runt — a **second `error_runt`**, and two pulses under
one name fail `names_ok`. I conflated *not decoded as an abort of A* with *not
decoded as a start at all*.

**Why it was invisible at two of three cells**: at sub-cases 4 and 5 the
first-speaking assertion is the word-count check, which fires identically whether
or not B opened. **The error was masked wherever a different instrument spoke
first, and visible only where the pulse check was reached.**

**Scoring, and I decline to round it.** The class reddens **exactly** its sealed
`R!` set, its controls held, and it is seeded as specified — so **IC-A is
KILLED, one kill**. But seal §11 criterion 1 asks for §4's verbatim cells and
**this class delivered 2 of 3**. Recorded as a message miss and a finding against
me, not absorbed into the kill.

**Noted, and deliberately not a finding against the manifest**: the auditor's own
§3 derived *"pulse count at each of the three: 1"*, which is likewise wrong at
sub-case 6 — and its stated caveat (*"frame A is left open, so a start character
later in the same stimulus would abort it then"*) covers a later **start** but not
`Arrival`'s auto-**terminate**, which is what actually closes A. **Both of us made
the same error one step outside the same caveat, and the bench caught it.** Its
predicted red set was right; the slipped quantity was one it had already disclosed
enough about to be derivable.

#### 6.3 FINDING WO-0066-6 — the campaign retires bound 7's own premise, and it was false when written

**`M03-H1` (lane 4) and `M03-H2` (lane 0) reddened**, and my seal predicted green:

```
M03-H1 (lane 4): expected two delivered frames (one tlast word each), got fewer
M03-H2 (lane 0): expected two delivered frames (one tlast word each), got fewer
```

I read both rows' stimuli after the fact rather than guess at them:

- **`M03-H2`'s own row text**: *"A new `/S/` in **lane 4** of a **mid-frame**
  word, i.e. lanes 0-3 of that word still belong to the aborted frame"*, driven at
  **both** start lanes with `k` chosen per lane *"so the `/S/`'s own ABSOLUTE lane
  is always 4"*.
- **`M03-H1` at a lane-4 start**: its aborting `/S/` sits at `At_octet 64`, octet
  time `start_ot + 8 + 64` = 84, **lane 4**, against a frame that has delivered
  64 octets.

**Both are lane-4 in-word aborts of a frame already open on entry — `WO-0058`
bound 7's exact conjunction — and both have been in this bench since `WO-0057`,
which is *before* bound 7 was written.**

**Bound 7's premise was therefore false at the moment it was stated**:
*"M03-H4's word `c` is the bench's only in-word abort, and only in the
nothing-open-on-entry form; no unit drives an in-word abort with a frame already
open."* `M03-H4`'s word `c` is indeed the only **nothing-open-on-entry** one — but
`M03-H1` (lane 4) and `M03-H2` (both lanes) were already driving the open-on-entry
form. The claim was carried unexamined through `WO-0058`, `WO-0061`, `WO-0062`,
`WO-0063B`, `WO-0065`, `RV-0065-VERDICT`, `RV-0065B-VERDICT` and into this
packet's §4.

**This finding is mine and it costs this round part of its headline.** Stated at
full strength:

- **The bench was NOT blind to a lane-4 abort of an already-open frame.** Three
  members detected it before `M03-N2` existed, and no verdict may imply otherwise.
- **`M03-N2` sub-cases 4 and 5 are not the first detectors of the conjunction.**
- **What remains genuinely `M03-N2`'s own** is the **`Preamble`-state instance
  (sub-case 6)** — `M03-H1`/`H2` abort frames in `Frame` state — and the
  **coincidence geometry** that IC-C measures and that exists nowhere else.
- **How the error survived six packets**: every re-statement quoted the bound's
  sentence rather than re-measuring its claim. The census that would have caught
  it — *which units drive a `/S/` in lane 4 against an open frame* — was never
  run, because the claim read as settled.

**MUST-STAY-GREEN: 43 of a sealed 45 held; 2 violated — `M03-H1` and `M03-H2`,
both mine**, first alternative again (incomplete enumeration; the diff reaches
exactly what IC-A names). Non-M03: 79 + 1 held. **Kills: 1.**

---

### 7. Bound 7 — the verdict, under §4's four sealed rules

**§4 rule 1 fires: IC-A red at all three instances → BOUND 7 SCORED 3 of 3.**

| instance | A's state on entry to W | sealed | observed |
|---|---|---|---|
| sub-case 4 | **`Frame`** | `R!` | **red**, message-exact |
| sub-case 5 | **`Frame`** | `R!` | **red**, message-exact |
| sub-case 6 | **`Preamble`** | `R!` | **red**, message miss (§6.2) |

**The conjunction is detected in both of its state shapes**, which is precisely
what §4 required a verdict to be able to say and what a bare count could not have
supported. Rules 2 and 3 do not fire. **Rule 4 governs the disposition**: bound 7
is **paid** by the bench and **scored** here; it leaves my carried list when the
plan records both.

**And §6.3 changes what the plan must record.** Bound 7 is scored 3 of 3 at
`M03-N2` **and** was already paid at `M03-H1`/`M03-H2` in the `Frame` shape. The
plan records the score, the three instances' state split, **and the correction** —
otherwise the record would carry a false history of a true result.

---

### 8. Campaign scorecard

| class | seeded | `R!` hit | cells message-exact | MUST-STAY-GREEN (M03) | non-M03 | kills |
|---|---|---|---|---|---|---|
| **IC-C** | as specified | 3 / 3 | **3 / 3** | **45 / 45** | 79 + 1 | **1** |
| **IC-D** | as specified (wide) | 2 / 2 | **2 / 2** | **46 / 46** | 79 + 1 | **1** |
| **IC-F** | as specified | 1 / 1 | **1 / 1** | **47 / 47** | 79 + 1 | **1** |
| **IC-B** | as specified (R, narrow) | 6 / 6 | **6 / 6** | **38 / 38** | 79 + 1 | **1** |
| **IC-E** | as specified | 1 / 1 | **1 / 1** | 41 / 44 — **3 violated, mine** | 79 + 1 | **1** |
| **IC-A** | as specified (O, E) | 3 / 3 | **2 / 3** | 43 / 45 — **2 violated, mine** | 79 + 1 | **1** |
| **total** | **6 / 6** | **16 / 16** | **15 / 16** | — | — | **6 / 6** |

*(29 REQUIRED cells counting each `G✱` and control as a cell; 28 hit.)*

**Kills: 6 of 6 scoreable classes.** Counted **per class**: IC-B's ten reds are
one kill, IC-E's seven are one.

**Non-M03: 79 behavioural + 1 build-level held under every class.** Every
`File "test/…"` failure path in all six logs is under `test/xgmii_rx_64/` —
verified by me across all six logs. **No mutant failed to compile**, so the
build-level unit never spoke, which is the §2.1 split working as designed.

**Cycle-versus-count per red, and the taxonomy needed a fourth column again.**
`WO-0063B` FINDING 3 taught that a two-valued taxonomy for how a red presents
would be short; this round it was short by two:

| presentation | classes |
|---|---|
| **cycle** difference | IC-C (3) |
| **count** difference — a report removed | IC-B (10) |
| **count** difference — a report added | IC-E (7) |
| **name-set** difference — two pulses, one name | IC-A at sub-case 6 (1) |
| **datapath / delivered-word** difference | IC-A at 4, 5, H1, H2 (4); IC-D (2); IC-F (1) |

**Structure split across the reds**: in-word epoch closures (IC-D, IC-F at
lane 0; IC-B's in-word site at all six N sub-cases) versus epoch-A aged records
(IC-A, IC-E, IC-D/IC-F at lane 3, IC-B's `a_close_runt` site). **Both report paths
were exercised in every class that names one**, which is why IC-B needed two sites
and why a rendering touching only `a_close_runt` would have reddened nothing in
family N — the auditor derived that in advance at its §2.

---

### 9. Findings — six, all six against dv_lead

| id | finding | effect |
|---|---|---|
| **WO-0066-1** | The allowlist barred `agents/**` wholesale, forbidding the constitutional reads PROTOCOL §2 makes mandatory | none; carve-out binding (reading note §4) |
| **WO-0066-2** | Commit subjects and journal titles for a seal commit are an unpriced ambient channel | none measured; discipline binds |
| **WO-0066-3** | Seal §3.3's IC-E `G` at sub-cases 1 and 5 rests on a sub-five floor; §12 defines the runt at **fewer than 64 octets** | **2 MUST-STAY-GREEN violations, confirmed**; no kill effect |
| **WO-0066-4** | §1.3 asserted both IC-B renderings exist; `W` is unrenderable | none; disposition 8 |
| **WO-0066-5** | Seal §4.1's sub-case 6 cell derived from *"frame B is never opened"*, which is not IC-A's consequence | **1 message miss**; no kill effect |
| **WO-0066-6** | **`WO-0058` bound 7's premise was false when written** — `M03-H1` (lane 4) and `M03-H2` (both lanes) drive its conjunction and predate it | **2 MUST-STAY-GREEN violations**; **narrows what `M03-N2` uniquely buys** |

**WO-0066-3 and WO-0066-6 share one root cause and it is worth naming**: both are
**a claim about a set, carried in prose and never re-measured** — a floor quoted
from the wrong requirement, and a census never run because the sentence asserting
its result read as settled. The tool this round shipped (`tools/dv_checks.sh`'s
boundary-matched census) exists for exactly that failure and did not cover either
claim.

#### 9.1 What is NOT a finding — the manifest

**Accepted with no defect recorded against it.** 16/16 on the predicted `R!`
cells; every control green where a control was required; all seven disclosures
accurate against the delivered diffs (**D-A1 = O**, **D-A2 = E**, **D-B1 = R**,
**D-B2 = narrow**, **D-D2 = wide**, **D-DF1 = C**, **D-E1 = includes zero** — each
confirmed by measurement); R-DISC-1 discharged per sub-case and per lane; R-DISC-2
delivered with seven cross-class gate facts tabulated; the §6 pre-ship check
discharged as a **fan-out closure**, a stronger form than the packet asked for and
confirmed by the absence of any datapath message in the three classes that
claimed silence; six diffs each minimal, independent and revertible; and the base
SHA **verified** rather than accepted.

**Three acts belong on the record as more than compliance.** It **rejected its own
first rendering of IC-A** on this packet's §9 terms, because the literal reading
would have raised a third and fourth strobe name — the discipline §9 exists to
force, and the second round running in which this auditor has refuted itself by
evaluating a gate rather than reasoning about fan-out. Its **containment clauses
caught two units my enumeration missed** (`M03-H2` under IC-E, `M03-H1`/`H2` under
IC-A), which is the difference between a predicted set and a predicted *rule*. And
it **disclosed an ambient exposure unprompted** when nothing would have detected
the omission.

---

### 10. What is commissioned, and what is deliberately not

**Commissioned, in this order:**

1. **`test/attack_plans/AP-xgmii_rx_64.md`, one round, six items.** Held back from
   every commit of this round because the plan is the campaign's contract and
   moving it would have violated §8. **The campaign has scored; the window is
   closed; this is that round.**
   1. **`M03-N2` → QUALIFIED** on IC-A, IC-B, IC-C and IC-E, citing this verdict;
      **`M03-B2` → QUALIFIED** on IC-D and IC-F; **`M03-B4` member (b)** enters the
      qualified count on no class and is recorded as **scored-and-unconvicting**,
      which is a result and not an omission.
   2. **`WO-0058` bound 7 — SCORED 3 of 3**, with the three instances' **state
      split** recorded (two `Frame`, one `Preamble`).
   3. **FINDING WO-0066-6 struck into the plan**: `M03-H1` (lane 4) and `M03-H2`
      (both lanes) drive bound 7's conjunction and predate `M03-N2`; the bound's
      original premise is **superseded wording kept beneath the strike**, per this
      plan's own convention, because the argument that retired it is only readable
      against it.
   4. **Trap T8 is observable at one member of two, permanently** (§5.2), recorded
      as an interface property and not as a bench defect.
   5. **`M03-B2`'s `/Q/` sub-member** — note B-ii obligation 1's ruling is now
      paid for by measurement (§3).
   6. §9's change-log row.
2. **Family J's bench-capability round — the DATED opening**, per
   `RV-0065B-VERDICT` §7.2, which dated it to the round immediately following this
   seal. It carries the two debts this round parked with named carriers:
   **`bench.mli`'s `_frame`/`_piece` naming-axis cell** and, if no `M03-N1`/`N4`
   round is scheduled first, **fold-in 3**.
3. **A `BUG-` is NOT opened and the reason is stated**: every red in this campaign
   is a seeded mutation killed by the suite. No divergence of the unmutated design
   from its specification was observed, so there is nothing to report to rtl_lead.

**Not commissioned, and named so the omission is visible:**

- **No bench change.** Nothing in `test/**` is owed by this result. The three
  MUST-STAY-GREEN violations are **my seal's** errors, not the bench's; every unit
  behaved correctly, including the two that reddened where I said they would not.
- **No `SO-xgmii_rx_64.md`.** Six classes against eleven members is not a module
  sign-off. Nineteen ASSERT rows are still outstanding.
- **The IC-B(W) design fact stays unbanked** (reading note §2): that a
  zero-delivered frame structurally cannot emit a word is the auditor's RTL
  derivation, and **no `SO-` may cite it as §0.7 coverage** until a bench
  re-establishes it from the specification side.
- **The strobe interface's multiplicity question** (§5.2) is raised to
  architect_docs_lead as a specification question, **not** as a `BUG-`.

---

**Files this verdict stages**: this packet. Journal entry `J-dv_lead-0117`.
**The seal was not edited, and was opened only after all six scorecards existed.**
