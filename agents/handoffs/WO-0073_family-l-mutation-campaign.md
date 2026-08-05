# WO-0073: the family-L mutation campaign — five classes against the 10 000-frame line-rate stress run and the directed-length set, and the first campaign in this programme that must declare, before it runs, which of the rows it scores have instruments no mutation can reach

- **State**: **DRAFT** — dv_lead's draft. The orchestrator issues it, operates it
  (PROTOCOL §10's transient model) and allocates its id (PROTOCOL §3); `0073` is
  the id the spawn allocated and is used throughout.
- **From** / **To**: dv_lead → **auditor** (manifest author), via the
  orchestrator (campaign operator).
- **Spec basis**: `docs/specs/requirements.md` **REQ-004** (the line-rate
  invariant, its alternating start lanes, its 10/11-cycle spacing, its
  minimum-12-octet gap counted from the terminate character inclusive, and its
  four pass criteria), **REQ-005** (cut-through; constant per-octet latency
  *independent of frame length and frame content*, and its directed-length
  verification column), **REQ-011**, **REQ-014**, **REQ-015**, **REQ-019** (word
  delay ΔC = (L + h)/8 against the §1.1 ceiling, and the two-datapath-word
  storage bound), **REQ-020** (order preservation: no duplication, no
  reordering), **REQ-021**, **REQ-103**, **REQ-104**, **REQ-107**, **REQ-111**
  (the pinned per-lane constants and their ≤ 8-octet-time separation),
  **REQ-112**; **§0.3** (the gap convention and the start lanes), **§0.5**
  (octet time, the front offset, the deciding input word, the start-lane pair
  rule), **§0.6**, **§1.1** (the ceiling of 4), **§12**;
  `docs/specs/modules/xgmii_rx_64.md` **§6.1** (the `m + 3` sentence, its
  gapless qualifier, C-18, and the D(m) statement), **§7** (the timing-contract
  table L = 16 / 12, ΔC = 3, ceiling 4, the handshake rules, the 190-word bound,
  and the *"one cycle of the §1.1 allocation unspent"* paragraph), **§8** (the
  line-rate stress obligation: the stimulus table, the zero-error-injection
  clause, checks 1–4, and the directed-length set), **§9**.
- **Plan basis**: `test/attack_plans/AP-xgmii_rx_64.md` **§4.L** rows
  `M03-L1` … `M03-L5` with their Kills cells, and §4.L's landed-status block at
  `630e34a` / CI run `31015276337`; **§2** items 1–4 (the standing monitors and
  the C-23 counting convention); **§7**'s X-rows for the machinery this round
  reads.
- **Bench basis**, and it is named because a campaign that scores message-level
  cells is scoring a *file*: `test/xgmii_rx_64/test_m03_l.ml` at the base SHA —
  two `%expect_test` units, both landed at `630e34a` and green at CI run
  `31015276337`, steps 6 and 8 `success`.
- **Binding**: the auditor's **R-DISC-1** and **R-DISC-2** (`DISP-0001` §4,
  `fab31de`) bind these manifests and are adjudication criteria for them.
- **The seal**: `WO-0073_family-l-mutation-campaign-SEALED-predictions.md`,
  frozen in **this packet's own commit**, before any diff exists.
  **If this commit does not stage that file, this round has no seal**, its
  cell-level claims may not be made, and the absence is a finding against me —
  my own rule, written against me at `J-dv_lead-0113` Open-question 1 and
  restated at PROTOCOL §10's **R-SEAL-1**.
- **Precedent carried in terms**: `WO-0063B`'s pre-run reading note. **If the
  manifest raises a question for me, it comes to me BEFORE the run**, as a
  committed reading note, not as a post-hoc reading of a scorecard.

---

## Section map

| § | what it fixes |
|---|---|
| 0 | what this round is, and the three things it cannot do |
| 1 | the five intent classes and their six mandatory disclosures |
| 2 | the denominator, re-measured at this tree, and one correction to my own prior seal |
| 3 | the convicting instruments, measured from the landed file rather than recalled |
| 4 | **what this campaign structurally cannot score, declared before it runs** |
| 5 | reachability, discharged term by term — both sides |
| 6 | §4(c) as a test: the measured datapath-perturbation signature, and its domain here |
| 7 | the allowlist, and what the manifests must carry |
| 8 | the base SHA and the adjudicator-ordering rule |
| 9 | mutant-owned quantities, and how they are sealed |
| 10 | collisions: two pairs of classes speak with one string, and what that costs you |
| 11 | scorecard discipline for the campaign era — stated at the era's first packet |
| 12 | cost, priced before seeding |
| 13 | what this round does NOT close, and the owed list with carriers |
| 14 | weighting, discounted in advance |
| 15 | what comes back |
| 16 | not to be told |

---

## 0. What this round is for, and the three things it cannot do

Five ASSERT rows landed at `630e34a` and **not one of them has been scored**:
`M03-L1`, `M03-L2`, `M03-L3`, `M03-L4` (one unit, one `Bench.run`, one
10 000-frame schedule) and `M03-L5` (eighteen directed single-frame runs). The
bench era of this module closed at 62 of 62 (`RV-0072-VERDICT` §4) and **that
number is a title count, not a pass and not a qualification**. This is the first
of the four campaigns that convert titles into scored rows.

**Three things this round cannot do, stated first so no verdict drifts into
them.**

1. **It cannot pay the `P1-module-ready` line-rate-stress line.** `RV-0070-VERDICT`
   §4 composed that line's evidence — M03-L1 green and M03-L6 structural — and
   said in terms that it *"is evidenced. It is not signed."* A campaign scores
   whether the assertions convict; it does not sign a gate line.
2. **It cannot qualify a row on a class the row was authored against.** None of
   the five rows was written with a mutation class known. What does apply is the
   opposite honesty: **two of the five rows have instruments no mutation can
   reach at all**, and §4 says which, before the run, rather than letting a
   scorecard imply otherwise.
3. **It cannot open an `SO-`.** Three families — J, K and M — are still
   unscored, and the charter §3 verilog-ethernet differential co-sim anchor is
   undischarged **per class**.

---

## 1. The five intent classes

Each is **one kill**, never one kill per reddened unit. Each is derived from a
sentence of the specification, and each is named with the row whose Kills cell
it instantiates.

### IC-L1 — the receiver needs a cycle to re-arm between frames

**Ground**: REQ-004 requires 10 000 consecutive minimum-length frames at the
minimum gap, *"dropping no frame and losing no word"*, and `AP` §4.L's `M03-L1`
Kills cell names the class in terms: *"A design with any internal backpressure or
a one-cycle recovery between frames fails within the first hundred frames."*

**The geometry that makes it observable, derived from §0.3's gap arithmetic and
`Arrival`'s own layout** (`WO-0070` §2.1, re-derived at this tree in the seal):
on this schedule a frame's terminate character and the *next* frame's start
character land in **adjacent XGMII words** at every even→odd transition
(terminate at cycle 10 + 21k, next start at cycle 11 + 21k) and are separated by
**exactly one idle word** at every odd→even transition (terminate at 20 + 21k,
next start at 22 + 21k). **The alternation REQ-004 mandates therefore produces
5 000 instances of the tightest case and 5 000 of the loose one, alternating** —
which is the whole reason the requirement specifies alternating lanes rather
than one lane.

**Required consequence**: the 5 000 **odd-index (lane-4-start)** frames are
affected and the 5 000 even-index ones are **not**. A rendering that affects all
10 000, or the even ones, does not key on the re-arm condition.

#### 1.1 MANDATORY DISCLOSURE **D-L1a** — what the un-re-armed receiver does with the frame

- **D** — it **drops** the frame: no output word, no `tlast`.
- **T** — it **takes** the frame one cycle late: every output word of that frame
  is emitted one cycle later than the gapless `m + 3` formula puts it, and the
  frame is otherwise correct.

Both are the class. **They speak through different instruments** and the seal
branches on it.

#### 1.2 MANDATORY DISCLOSURE **D-L1b** — what your non-acceptance keys on

- **A** — **adjacency**: the start character's word immediately follows a word
  carrying a terminate character (equivalently: the previous frame's last output
  word is being emitted on this cycle). This is the class as stated.
- **L** — the start character's **lane** alone: any lane-4 start is affected.

**This is not a stylistic question and it is the `D-A1` lesson of `WO-0066`
repeated because it cost a round there.** On *this* stimulus **A** and **L**
select the identical 5 000 frames, so the two are indistinguishable inside
family L — but **L** additionally reaches **every lane-4-start unit in the
whole M03 bench**, and **A** reaches only units driving a second frame whose
start word is adjacent to a terminate word. The two have completely different
MUST-STAY-GREEN sets and the seal branches on it. A manifest that does not
answer **D-L1b** is scored under the widest branch and every disagreement is a
finding against the manifest.

### IC-L2 — the reserve is spent: the word delay is 4

**Ground**: SPEC-M03 §6.1 fixes output word m at cycle **m + 3** from the start
word on a gapless stimulus; §7 pins **L = 16** at h = 8 and **L = 12** at h = 12
and **ΔC = 3** against §1.1's ceiling of **4**, and says why the unspent cycle is
deliberate. Render a design that emits every output word on cycle **m + 4**.

**Required consequence**: both front-offset classes move together — L = 24 at
h = 8 and L = 20 at h = 12 — while every octet's content, every `tkeep`, every
`tlast` placement and the frame count are **unchanged**.

**Why this class is worth its transient, stated before the result.** ΔC = 4 is
**inside** REQ-019's ceiling, so §0.5's closure holds ((L + h) = 32, a multiple
of 8, at both lanes), the ceiling comparison does not fire (4 > 4 is false), and
§0.5's start-lane pair rule is satisfied (both classes at 4). **`Latency.errors`
is therefore EMPTY under this class** — the whole of REQ-019's machinery is
silent, and the only thing in this bench that can convict a one-cycle regression
is REQ-005/REQ-111's **pinned constant**. That silence is a REQUIRED green and
it is the point of the class: it measures which of M03-L2 and M03-L3 is actually
load-bearing.

#### 1.3 MANDATORY DISCLOSURE **D-L2a** — uniform, or the head word only

- **U** — every output word moves (the class as stated).
- **H** — only output word 0 moves, later words keeping their `m + 3` cycles.

**H is admissible and is a second defect riding the first**: word 0 at c + 4 and
word 1 at c + 4 are one cycle carrying two words, and this stream carries at
most one word per cycle (REQ-002), so a word is displaced or lost and *which* is
the rendering's. The seal marks **H**'s cells **UNWORKED** with adjudication
pre-fixed. Prefer **U**; if your diff produces **H**, say so before the run.

### IC-L3 — the delay varies with the final word's residue

**Ground**: REQ-005 requires per-octet latency *"independent of frame length and
frame content"*, and `AP` §4.L's `M03-L5` Kills cell names exactly this class:
*"A pipeline whose delay varies with the final `tkeep` residue — length-dependent
latency that a fixed-length stress run cannot see."* Render a design that emits
the **`tlast` word** one cycle later than `m + 3` when the frame's **delivered**
octet count has a residue in a set **R** ⊆ {0 … 7} modulo 8, and on schedule
otherwise.

**Required consequence**: the directed-length runs whose delivered residue lies
in **R** redden, and **the 10 000-frame stress unit stays GREEN unless 4 ∈ R**,
because every stress frame delivers 60 octets and 60 mod 8 = **4**.

**This is the only class in the campaign whose entire convicting set can lie
outside the stress run**, and it is therefore the round's own measurement of what
`M03-L5` buys over `M03-L2`. The row was written on the argument that the
derivation cancels the octet position entirely (`WO-0070` §3.4); this class is
where the *design* is asked, rather than the specification.

#### 1.4 MANDATORY DISCLOSURE **D-L3a** — the residue set, and which residue you mean

State **R** explicitly, and state that it is keyed on the **delivered** octet
count (the `tlast` word's `tkeep` extent, which is what the row's Kills cell
names) and **not** on the received octet count. The two differ by REQ-103's four
FCS octets and therefore by four residues: a 64-octet frame has received residue
**0** and delivered residue **4**. A manifest that keys on the received residue
has rendered a different class and the seal's cells do not apply to it.

**If 4 ∈ R the stress unit reddens too**, the class is still seeded but its
length-dependence claim is unearned, and §8's scoring rule 2 governs.

### IC-L4 — the tail word is lost to the next frame's start character

**Ground**: REQ-112 and REQ-004 — *"word loss is the only observable failure
mode"* (REQ-112's verification column) — plus REQ-019's two-datapath-word
storage bound and §6.1's *"at most two output words are ever waiting at once"*.

**The geometry, and it is this campaign's own find.** On this schedule an even
frame's **last output word** (word 7, at cycle start + 10 = 11 + 21k) is emitted
on **exactly the cycle whose XGMII input word carries the next frame's start
character** (11 + 21k, lane 4). The odd frames' last words carry no such
coincidence (word 7 at 21 + 21k, next start at 22 + 21k). **5 000 output words —
every one of them the word that carries its frame's `tlast` — are emitted on a
cycle the receiver is simultaneously opening a new frame on.** Render a design
that cannot do both.

**Required consequence**: every **even-index** frame loses its word 7 (or has it
displaced, per **D-L4a**); the odd frames are untouched.

#### 1.5 MANDATORY DISCLOSURE **D-L4a** — suppressed or deferred

- **S** — the word is **suppressed**: it is never emitted, and with it the
  frame's `tlast`.
- **F** — the word is **deferred** to the following cycle, arriving complete but
  late.

Both are the class; they speak through different instruments and with different
blast radii, and the seal branches on it.

### IC-L5 — the last output word is delivered twice

**Ground**: REQ-020 — *"with no duplication and no reordering"* — and REQ-015,
which makes a stream carry the words of **exactly one** frame between successive
`tlast` words and requires a frame to comprise **at least one** word. Render a
design that emits each frame's final output word on two consecutive cycles, both
carrying `tlast`.

**Required consequence**: the stress unit sees twice as many `tlast` words as
frames; each directed-length run delivers more octets than REQ-103's extent
allows.

**Why duplication and not reordering, and the reason is a derivation rather than
a preference.** REQ-020's *reordering* half has **no renderable mutant at this
stimulus**: frame k + 1's octets arrive strictly later than frame k's, this is a
cut-through module (REQ-005) with at most two datapath words of storage
(REQ-019), and no minimal diff can make a module emit octets it has not received.
**So the reorder half of REQ-020 is unfalsifiable at this bench**, which §4
records as a bound rather than leaving it to surface as a missing class.

---

## 2. The denominator, re-measured at this tree

Re-measured by `bash tools/dv_checks.sh` at the base tree, whose inventory block
is the provenance — **not carried forward from `WO-0066`**:

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
the same tree reads **78 rows declared, 62 named in a unit title** under **both**
matchers (naive and trailing-digit-boundary), with the two declared adjustments
(`M03-A4` subtract 1, `M03-F5` add 1) leaving **62 of 62 ASSERT rows
discharged**. The dual-matcher agreement is a property of today's id set, not of
the method, and is quoted with that caveat because the block itself states it.

**Family L is 2 of the 59.** The campaign works those two cell by cell; the
other 57 are governed by each class's stated **rule** (§3.3).

### 2.1 The non-M03 80, split by what a red there would mean

| directory | units | a red there means |
|---|---|---|
| `test/monitors/` (37), `test/xgmii/` (25), `test/golden/` (11), `test/axi64_probe/` (3), `test/xgmii_probe/` (3) | **79** | the manifest reached outside its own file — a **scope finding** |
| `test/hardcaml_ethernet/` | **1** | the mutant **does not compile** — a **build finding**, never behavioural |

**One correction to my own prior seal, measured here.** `WO-0066`'s seal §0 put
`test/cosim/` in the "no `%expect_test` at all" row and said nothing further.
That is true of its unit count and **incomplete about its exposure**:
`test/cosim/dune` is an `(executables)` stanza declaring `hardcaml_ethernet`,
which `dune build @default` builds. **A mutant that does not compile fails the
build there too, contributing zero unit reds** — so the build-finding class has
**two** homes and only one of them can produce a red unit. Stated before the run
so a green `test/cosim/` is not read as evidence the mutant compiled cleanly;
the **build step's own conclusion** is that evidence.

---

## 3. The convicting instruments, measured from the landed file

**Method, so it is checkable**: every `fail`/`failwith` reachable from the two
units of `test/xgmii_rx_64/test_m03_l.ml` was enumerated in source order at the
base SHA and classified by the object it reads. The result is the seal's §2, and
the parts a manifest author needs are here.

### 3.1 Unit 1 — one schedule, one `Bench.run`, nine ordered items

`WO-0070` §9 fixed the order in the packet and the landed file honours it:
(1) stimulus legality, (2) schedule shape, (3) frame count out, (4) one
left-to-right pass over the delivered words, (5) the empty strobe set, (6) the
sequence read-back, (7) the two latency-class records, (8) the whole-run latency
accessors, (9) the standing monitors.

**Items 1 and 2 are evaluated on the bench's own model of the stimulus**,
before or independently of the DUT — `Arrival.check` inside `run`, then
`Arrival.frames`, `Arrival.start_lanes` and `Arrival.start_spacings`. **No RTL
mutation can move them.** A schedule-shape message or an `Arrival.check` message
appearing in this campaign means something other than a seeded class and is a
finding of its own kind.

### 3.2 Unit 2 — eighteen runs, one order, seventeen of them shadowed

`run_l5` drives, in this order: **lane 0 lengths 64, 65, 66, 67, 68, 69, 70,
71**, then **lane 4** the same eight, then **lane 0 length 1518**, then **lane 4
length 1518**. Each run's assertions raise, so **only the first reddening row of
the eighteen is observable in a passing-to-failing run.** The manifest's
R-DISC-1 discharge is still required **per lane and per named length**: a row
discharged term by term and merely unobserved is recorded as **unobserved**,
never as a miss and never as a pass.

### 3.3 The blast-radius rule, and why it is a rule this time

`FINDING WO-0066-3` cost that round three MUST-STAY-GREEN violations, all mine,
because my seal carried an **enumeration** where the auditor's manifest carried
a **rule** and the rule was right. **This round takes the lesson**: for every
class, the predicted red set outside family L is stated as a **rule in stimulus
terms**, with the instances I worked named beneath it, and **the rule governs
where the two disagree**. A red selected by the rule is predicted blast radius
and contributes **zero** additional kills; a red outside the rule is a finding.

The rules are stated per class in the seal. Two of them are wide by
construction and the packet says so now rather than letting a scorecard say it:
**IC-L2** moves every output word, and the M03 bench contains **227**
cycle-pinning assertion sites across all twelve of its row files, so IC-L2's
predicted red set is most of the bench. **IC-L5** changes a word count and
reaches every unit that counts words or `tlast`s. Neither fact costs the class
anything — kills are counted **per class**, never per reddened unit — and
neither may be reported as coverage.

---

## 4. What this campaign structurally cannot score — DECLARED BEFORE IT RUNS

This is the section the round exists to be honest about, and every statement
here is derived from the landed file's own control flow at the base SHA, not
from a category.

1. **`M03-L4`'s own instrument (item 6) is unreachable.** Item 4 compares every
   frame's delivered octets **positionally** against `Arrival.delivered`, and
   §8's stimulus puts REQ-020's four-octet sequence number **inside** those
   octets (offsets 14–17). Item 6 reads those same octets back through
   `Frame.sequence_of` from the same list item 4 just compared. **If item 4
   passed for all 10 000 frames, item 6 cannot fail.** `WO-0070` §7 stated the
   overlap as an argument; it is a structural fact and it means **no class in
   this campaign can be scored on M03-L4's own message.** M03-L4 is qualified by
   citation to M03-L1's pairing, or not at all.
2. **`M03-L3`'s own instrument (item 8) is unreachable, term by term.** Its four
   checks are: the whole-run word delay (implied by item 7's two class records —
   both `Some 3` makes the whole-run accessor `Some 3`); `Latency.errors`
   (every one of its per-frame error paths is closed by item 4 having passed —
   the octet-count arm by item 4's own 60-octet check, the word-alignment arm by
   item 4's `tkeep` = 0xFF on word 0, the front-offset arm because h is computed
   from the **input trace** alone and is 8 or 12 by the schedule, the
   no-matching-input-frame arm because `frame_in` precedes `frame_out` in the
   same call; and every *derived* error is closed by item 7 having passed);
   `frames_compared` = 10 000 (**bench-supplied** — one call per schedule frame,
   never evidence the design delivered anything, the `frames_exempt` lesson of
   `WO-0072` §8.3 one level down); and `octets_compared` = 600 000 (implied by
   item 4's per-frame 60). **M03-L3 asserts its two operands and neither operand
   can speak in this unit.** Its ΔC content is discharged in `WO-0070` §6's
   derivation, not by a run — which that packet said, and which is now measured.
3. **Item 9's only reachable residue is REQ-014.** `Protocol_monitor`'s violation
   kinds are the zero-octet frame, non-contiguous `tkeep`, a non-full `tkeep` on
   a non-`tlast` word, **`tstrb` ≠ `tkeep`**, and the max-words bound. Item 4
   reads `tkeep`, `tlast`, `tuser` and the octets — and **never `tstrb`**. So
   the one thing item 9 can convict that nothing earlier can is REQ-014's
   producer half. **No family-L row claims REQ-014**, so no class here targets
   it, and a class that did would score a standing-monitor row rather than a
   family-L one.
4. **REQ-020's reordering half has no renderable mutant** (§1, IC-L5's ground).
5. **Item 4's per-word `tkeep`/`tlast`/word-count checks are family C's
   observables replicated at scale.** A class targeting them scores M03-C1 and
   M03-C3, not family L, and is deliberately **not** seeded here.
6. **Item 5's empty-strobe-set check has no seedable class in this campaign, and
   the ground is enumerability rather than reachability.** It is perfectly
   reachable — a design that reports a conformant 64-octet frame reddens it. But
   every rendering that does so (REQ-107's runt boundary read as `≤ 64`, a
   spurious REQ-110 abort, an FCS residue misread) reddens a large and
   ill-bounded fraction of the 59 M03 units, and a class whose predicted red set
   I cannot state as a checkable rule is a class whose MUST-STAY-GREEN column is
   a guess. `FINDING WO-0066-3` is what that costs. **Declared as a non-target
   with its ground, not omitted.**

**None of items 1–6 is a defect in the bench and none moves a row.** Items 1 and
2 are two rows whose observables are genuinely asserted by a sibling row in the
same unit; the campaign's contribution is to say so **before** a scorecard is
read as saying otherwise.

---

## 5. Reachability, discharged term by term — both sides

**R-DISC-1 binds your manifests** (`DISP-0001` §4). For **each** of the five
classes separately: name the gate signal, quote its **complete** defining
expression from the base file with line numbers, and evaluate **every** conjunct
on the named stimulus at the claimed firing cycle, calling out which conjuncts
are contributed by the **stimulus** rather than by the mutation. Where a landing
condition is modular or recurrent, write it as arithmetic and show it satisfied
at the value the required consequence names, with the recurrence set
**enumerated rather than assumed unique** — IC-L1 and IC-L4 each claim **5 000**
instances, and a claim of periodicity is a claim about every member.

**Per-lane, per-length and per-parity evaluation is required where the class's
own consequence names more than one.** IC-L1 and IC-L4 name a parity (odd frames
and even frames respectively) — discharge at frame **1** and frame **0**
respectively, and state the recurrence. IC-L3 names a residue set — discharge at
**every** length in `{64 … 71, 1518}` whose delivered residue lies in **R**, at
**both** start lanes. IC-L2 names every word of every frame — discharge at word
0 and at the `tlast` word, at both lanes. **A lane, length or parity you did not
evaluate is NOT SEEDED for scoring purposes.**

**R-DISC-2**: IC-L1, IC-L2, IC-L3 and IC-L4 all name the **output-word emission
gate** (`tvalid` and the word's cycle); IC-L1's **D** branch and IC-L4's **S**
branch additionally name the **frame-acceptance / `tlast` gate**; IC-L5 names
the **`tlast` gate** alone. **No class in this campaign names the report path** —
say so explicitly in the inventory, because a term you touch there is a term
outside every class here and is the fastest way to a MUST-STAY-GREEN violation
at units this campaign never predicted. Each path gets a gate-inventory row
carrying its full term list and every intent's claim about it, **before
delivery**, with **cross-class gate facts tabulated** — every term two classes
both touch, named before delivery rather than discovered.

**And the same standard applies to me, on the bench side, discharged here.**
Every `R!` cell in the seal is a message raised by an assertion whose own terms
are:

- **(a)** the stimulus reaches the assertion — the two units are separate
  `%expect_test`s, so **neither shadows the other** and both are independently
  observable in the same run; inside unit 2 the eighteen runs **do** shadow one
  another and §3.2's order is the whole of the adjudication;
- **(b)** the observable is read from the DUT's own outputs under the `Before`
  view (`bench.mli`), so no relabelling stands between the emission and the
  check;
- **(c)** every assertion ordered **before** the scored one is unmoved under the
  class — discharged per class at §6 for the classes that claim not to move the
  datapath;
- **(d)** nothing outside the unit is required for the conviction.

---

## 6. §4(c) as a test, not as prose — and this round the signature has a full domain

**The measured signature** (`BUG-0003` §V.10.2, `J-dv_lead-0103`, transient tree
`5c47582`): **(a)** 7 mid-frame words with `tkeep` ≠ 0xFF and `tlast` = 0;
**(b)** 4 of 60 required octets in their gapless byte positions, 28 delivered as
the idle filler `0x07` and **28 never delivered at all** (a 32-octet stream
against a required 60); `tlast` on word 7; `tuser` = 0 on a corrupted frame.

`WO-0063B` had to record that the signature **had no domain** at the unit it was
scoring, because that member's conformant emitted stream is empty. **Family L is
the opposite extreme**: 10 000 conformant frames of exactly the shape the
signature was measured on, plus eighteen directed frames covering every `tlast`
residue. **The signature's domain here is the whole stimulus**, which makes the
check as strong as it can be made at this module.

**Three of the five classes claim the datapath does not move in content** —
**IC-L2**, **IC-L3**, and **IC-L1 at branch T** / **IC-L4 at branch F**. For
those, and only those:

1. **The auditor's pre-ship check.** Before delivering the manifest, confirm the
   rendering produces **none** of the signature's components on a *delivering*
   stimulus. A rendering that produces any of them is not the class; it is the
   class plus a datapath defect, and the two cannot be scored apart.
2. **My adjudication check, and it is executable here.** In unit 1 the datapath
   assertions (item 3's frame count, item 4's per-word `tkeep`, `tlast`
   placement, `tuser` and positional octet content) are **all evaluated before**
   the latency assertions those classes are scored on. So a rendering that moves
   the datapath raises with a **datapath** message and never with the latency
   message. The enumerated datapath messages are sealed; the rule is not.
   **In unit 2 the order is inverted** — `Latency.errors` is read *first*, and
   the tagger's own per-frame errors are where an octet-count or alignment
   perturbation surfaces — so at L5 the discriminator is **which kind of message
   the tagger raised**, not which assertion ran. Both readings are pre-fixed in
   the seal.

**Consequence, fixed here so it cannot be renegotiated**: for IC-L2, IC-L3,
IC-L1(T) and IC-L4(F), a red carrying a datapath message scores as **the class
out of specification — reported, not scored**, and no claim about the affected
row is made in either direction. **IC-L1(D), IC-L4(S) and IC-L5 move the
datapath by design** and this check does not apply to them; saying so is the
difference between a check and a ritual.

---

## 7. The allowlist — BLINDED, and absolute

**This is the complete set of repository paths you may read for this campaign's
duration. Everything else is out of bounds, absolutely.**

| | readable |
|---|---|
| 1 | `libs/hardcaml_ethernet/src/xgmii_rx_64.ml` **and its `.mli`**, at the base SHA — the mutation target |
| 2 | `docs/specs/requirements.md` and `docs/specs/modules/xgmii_rx_64.md` — the specs this packet names |
| 3 | **this packet** |
| 4 | `docs/reports/audit/**` — your own tree |

**Out of bounds, absolutely, for the campaign's duration**: **all of `test/**`** —
which includes `test/xgmii_rx_64/test_m03_l.ml`, `bench.ml`/`bench.mli`,
`test/xgmii/`, `test/monitors/` **and the attack plan
`test/attack_plans/AP-xgmii_rx_64.md`** — **all of `agents/**`, this packet
excepted and its sealed companion emphatically not excepted**, and every
journal. The seal names cells, message strings, assertion orders and
MUST-STAY-GREEN sets; reading it is reading the answer. **The AP is barred by
name because this campaign's classes are quoted from its Kills cells**, and a
manifest author who reads the row that authored the class is choosing a diff
against a written expectation rather than against the specification.

**The manifests must carry**, per R-DISC-1 / R-DISC-2:

1. **Five diffs** — IC-L1, IC-L2, IC-L3, IC-L4, IC-L5 — each **minimal and
   independent**: each applies alone to the base SHA, elaborates, and reverts
   cleanly. **No diff may combine two classes**; a combined diff makes both
   unscoreable, and §10 says why that matters more here than in any prior round.
2. **A reachability discharge per class, per named lane, per named length and
   per named parity, term by term at the firing cycle**, with the
   stimulus-contributed conjuncts called out — or a **self-declared NOT SEEDED**
   for any term you cannot discharge.
3. **Gate-inventory rows** for the output-word emission gate, the
   frame-acceptance / `tlast` gate and (as a negative) the report path, with
   every class's claim about each, and **cross-class gate facts tabulated**.
4. **All six disclosures answered in your own words**: **D-L1a**, **D-L1b**,
   **D-L2a**, **D-L3a**, **D-L4a**, and — the sixth — **D-L5a**: whether your
   IC-L5 duplication repeats the word **once** or holds it for more than one
   extra cycle, since the sealed quantity is an inequality whose derived value
   assumes one.
5. **The §6 pre-ship check result** for IC-L2, IC-L3, IC-L1(T) and IC-L4(F).
6. **The base SHA you applied to**, quoted, and confirmation that it matches
   §8's.
7. **Anything the packet made you guess.** Per the `WO-0063B` precedent, a
   question about this packet comes to me as a committed **pre-run reading
   note** **before** the run, and I answer it in the same form. A question
   answered after a scorecard exists is not a question, it is a negotiation.

---

## 8. The base SHA, and the adjudicator-ordering rule

**One base SHA for the whole round** — all five classes, the control run and
every MUST-STAY-GREEN sweep. `BUG-0003` §V.9's *"one round cannot carry two base
SHAs in its evidence"* governs.

**The base SHA is the commit that this packet's own commit immediately
follows** — the parent of the commit staging this packet and its seal. I cannot
state its hash: I never run git (PROTOCOL §2), and the packet's own commit has
none until the orchestrator creates it. **The orchestrator verifies that
identity at commit time and records the hash in its own trailer**; the auditor
quotes the hash it applied to (§7 item 6), and any disagreement is a finding
**before** the campaign runs, not after.

**The adjudicator-ordering rule, stated because it is what makes any of this
evidence.** **The bench must be frozen strictly earlier in history than any
mutant RTL it judges.** Concretely:

- Every `test/**` byte this campaign scores against is at or before the base
  SHA. The last `test/**` edit before this packet is the batched plan round's
  (`J-dv_lead-0132`); **nothing under `test/**` moves again until the campaign
  scores.**
- The seal is frozen in this packet's own commit — **after** the last bench edit
  and **before** the first mutant diff exists.
- **No diff body reaches me until every diff is committed on its transient
  branch.** I adjudicate against the seal, and the seal is opened only when the
  scorecards are in hand.
- If any `test/**` file is edited between this commit and the scorecard, **the
  round is adjudicated as having no valid base** and re-runs from a fresh seal.
  **That includes edits by me**, and §13 is where I hold myself to it.

**Why the rule is not ceremony**: a bench edited after a mutant exists can be
tuned to it, and no reader downstream can distinguish a bench that always would
have convicted from one that was taught to.

### 8.1 The scoring rules for the two classes whose value is bounded by a disclosure

**IC-L3, fixed before the result:**

1. **Red at the L5 rows whose delivered residue ∈ R, with unit 1 GREEN →
   length-dependence is scored**, and the verdict may say `M03-L5` detects what
   `M03-L2` cannot.
2. **Red at those rows AND at unit 1, with 4 ∈ R disclosed → the class is
   KILLED and the length-dependence claim is NOT made.** The stress run saw it,
   so `M03-L5` measured nothing `M03-L2` did not.
3. **Red at unit 1 with 4 ∉ R disclosed → the rendering does not key on the
   residue**; the class is reported and scores **zero**.

**IC-L1, fixed before the result:**

1. **The even-index frames must stay correct.** A rendering that affects all
   10 000 frames is not the re-arm class; the reds are blast radius, the class
   scores **zero**, and the rows stay UNQUALIFIED.
2. **Unit 2 must stay GREEN under both branches.** Every L5 run drives a single
   frame with nothing before it, so no re-arm condition exists there. A red at
   unit 2 means the rendering keys on something else.

---

## 9. Mutant-owned quantities, and how they are sealed

A quantity is **mutant-owned only if the specification does not fix it**. Every
such quantity is sealed as an **inequality with a named direction**, never as a
value; a seal that pins a rendering's own arithmetic scores a correct rendering
as a finding. The axes, with the cells in the seal:

| quantity | sealed as | direction, and why |
|---|---|---|
| the observed `tlast` count in unit 1 under IC-L1(D) and IC-L4(S) | an inequality **below** 10 000, with the derived value stated | **fewer** — one class refuses frames, the other loses the word that carries the mark |
| the same count under IC-L5 | an inequality **above** 10 000, with the derived value stated | **more** — a second `tlast` per frame. This is the direction that separates IC-L5 from the two above at the same cell |
| the observed latency set at a reddened front-offset class | membership, not a value | **later, never earlier** — every class here adds delay. A latency **below** the pinned constant is not any of these five classes and is a finding |
| the emitted octet count at an L5 run under IC-L5 | an inequality **above** REQ-103's extent, with the derived value stated | **more** |
| the observed front offset h at every frame | **not mutant-owned** — `∈ {8, 12}` | the tagger computes h from the **input trace** alone (`in_times`), which is the bench's schedule. A third value is impossible and its appearance is a finding against the manifest or the bench, never a rendering fact |
| `frames_compared` in unit 1 | **not mutant-owned** — `= 10 000` | **bench-supplied**: one call per schedule frame. It is never evidence that the design delivered a frame — `WO-0072` §8.3's own lesson, one level down |
| `octets_compared` in unit 1 | **not mutant-owned** — `= 600 000` | implied by item 4 having passed at every frame |
| the strobe set over the whole run | **not mutant-owned** — `= ∅` | §8's error-injection rate is **zero in this run**, and §4.2 of `WO-0070` closed all five strobes' conditions strobe by strobe. Any name appearing belongs to no class here and is a finding |
| units reddening under a class | `⊆` the class's **rule** (§3.3), not `⊆` an enumeration | a red outside the rule is a finding: either my rule was wrong or the diff reaches further than the class it names |

**Four of the nine are specification-fixed and are sealed as equalities on
purpose**; calling them mutant-owned would be buying an unfalsifiable seal. The
`frames_compared` row is the one to read twice: it is an equality **because the
bench supplies it**, which is a different reason from the other three and is
stated separately so no reader takes it for a design fact.

---

## 10. Collisions — two pairs of classes speak with one string

**Freely told**: this campaign contains **two pairs** of class-branch
combinations whose first-speaking message at their shared cell is
**character-for-character identical**, and a third near-collision separated only
by a printed value. Which pairs, and the strings, are sealed.

**What that costs you, and it is operational rather than theoretical:**

1. **Every class is delivered as its own diff and run as its own transient.**
   For at least one pair, **which diff was applied is the only discriminator
   that exists** — exactly the `IC-D`/`IC-F` situation of `WO-0066`, where the
   separation was carried entirely by the manifests and disposition 6 was the
   whole of the protection.
2. **The delivery order is fixed**: IC-L1, IC-L2, IC-L3, IC-L4, IC-L5, each on
   its own branch, each with its own CI run id reported. A scorecard that cannot
   say which branch produced which message cannot be adjudicated.
3. **A combined diff makes both members of a colliding pair unscoreable** and is
   reported as a manifest defect, not as a result.

**Told because it is a fact about the bench and not about the answer**: for one
of the two pairs the discriminator **does** exist and is a *measurement* — the
state of the other unit — which is a strictly better position than `WO-0066`
was in, and the seal records which.

---

## 11. Scorecard discipline for the campaign era — stated at the era's first packet

Family M bound seven co-occurrence rows to **landed carriers** rather than
writing new units (`RV-0071-VERDICT`; the inventory did not move while the
census moved by seven). That binding creates a counting hazard that will recur
in every campaign of this era, so the rule is stated here, at the era's first
packet, rather than when it first bites:

> **A carrier kill and its bound row are never two kills.** Where a campaign
> class reddens a unit that discharges both its own row and a row bound to it,
> the class scores **one** kill, and the verdict names both rows as qualified by
> **that one** conviction. A scorecard that counts the carrier and the bound row
> separately has multiplied its denominator by an act of bookkeeping.

The rule binds family M's campaign directly and binds this one only if a class
here reddens a carrier of an M row — §3.3's blast-radius rules make that
possible for IC-L2 and IC-L5. **It is stated now so that it is not invented
later by whoever needs it.**

Two companion rules of the same kind, both already earned:

- **Kills are counted per class**, never per reddened unit (`WO-0066` §11).
- **A kill proves the assertion convicts, never that the bench is a general
  detector of the class** (`WO-0066` §10 item 4).

---

## 12. Cost — priced before the transients are seeded

**The stimulus is measured, not estimated.** The 10 000-frame schedule costs
**T = 2.036 s** of CPU inside the process, measured by the cost probe at CI run
**`31007340877`**, job `92310423073`, on a throwaway ref that never entered
history; the landed step-6 wall was **4 s** at `630e34a` (run `31015276337`, job
`92337605716`) against **3 s** at its parent, and the `build` job's whole wall
was **344 s** — the test step is **1.16 %** of the job.

**The campaign's price, stated so the transient count is a decision rather than
a residue:**

| item | figure |
|---|---|
| classes | **5** |
| transient branches | **5** (one per class; §10 forbids combining) |
| CI `build` runs | **5** |
| CI wall, at the measured 344 s job | **≈ 28.7 minutes** |
| of which the whole `dune runtest` step | 5 × 4 s = **20 s** |
| of which family L's own two units | 5 × 2.036 s ≈ **10.2 s** |
| family L's marginal share of the campaign's CI wall | **≈ 0.6 %** |

**Three consequences fixed before seeding.** (a) **The 10 000-frame stimulus is
not what this campaign costs** — the elaboration and the rest of the suite are —
so no proposal to reduce the frame count buys anything measurable, and none may
be made on cost grounds without re-measuring. (b) **A branch delivered as a
separate diff costs a full extra run**: if you render more than one branch of a
disclosure, say so before the run and the price is +344 s per extra diff. (c)
**The control run is the base commit's own CI run** and costs nothing extra;
**CI is the authority** (ADR-0005) and *"passes locally"* is not admissible from
the auditor, the orchestrator or me.

---

## 13. What this round does NOT close, and the owed list with its carriers

**Named before the result, so no omission is invisible.**

1. **The attack plan does not move in this round's commit.** Every AP edit this
   campaign wants — §4.L's landed-status block gaining the campaign's score and
   run ids, §7 gaining the §4 unreachability findings, and the change-log row —
   is **owed, with a named carrier: the post-campaign `AP-` round**, which is
   the next commit that opens `test/attack_plans/**`. The reason is §8: moving a
   `test/**` byte between this seal and the scorecard costs the sentence
   *"nothing under `test/**` moves again until the campaign scores"* for zero
   measurement gain.
2. **OBSERVATION L-O1 is carried, and this round makes it operational without
   repairing it.** `RV-0070-VERDICT` §3 recorded that unit 1's leftover-word
   guard raises a message beginning *"test bug --"* whose condition is also
   reachable **by a design** that emits words after the last frame's `tlast`.
   **Pre-fixed here, before the run**: a red in this campaign carrying that
   prefix is a **design red mislabelled by the bench**, is scored as an
   unpredicted red under §9's containment row, and is **never** read as a bench
   defect. **Carrier for the repair: the next commit that opens
   `test/xgmii_rx_64/test_m03_l.ml`** — which, by §8, is not this one.
3. **The §4 declarations are findings that need a home.** Items 1, 2 and 3 of §4
   (M03-L4's and M03-L3's unreachable instruments, and item 9's REQ-014
   residue) belong in the plan's §7 beside the X-rows. **Carrier: the
   post-campaign `AP-` round.**
4. **`test/cosim/dune`'s dangling `test/cost_probe/` reference** is still open
   (`J-dv_lead-0132` Open-question 1). **Carrier: the next commit that opens
   `test/cosim/`.**
5. **OBSERVATION K-O1** (carrier: the next round opening `test/monitors/`) and
   **OBSERVATION M-O1** (carrier: the family M/G campaign packet) are carried
   unchanged and are not this packet's to pay.
6. **No `SO-xgmii_rx_64.md` issues and none is offered.** Outstanding before any
   PASS: the family **M**, **J** and **K** campaigns, and the charter §3
   verilog-ethernet differential co-sim anchor, undischarged **per class**. The
   **lessons harvest falls due at the `SO-`**, spanning from my last harvest.
7. **A kill here qualifies a row on the class it was seeded against and on
   nothing else.**

---

## 14. Weighting, discounted in advance

**In favour of this round**: none of the five rows was authored with a mutation
class known, and three of the five classes (IC-L1, IC-L4, IC-L3) key on
geometry that **only this stimulus produces** — the adjacent terminate/start
words, the tail word colliding with the next start character, and the seven
`tlast` residues no other landed unit drives at both lanes. `WO-0063B`'s
discount — *"the first unit written with its mutation class known"* — does not
apply to a single cell here.

**Against it, four ways, all stated before the scorecard:**

1. **Two of the five rows have unreachable instruments** (§4 items 1–2). Whatever
   this campaign scores, it does not score M03-L3's or M03-L4's own assertions,
   and no verdict may imply otherwise.
2. **IC-L2's and IC-L5's convicting sets are enormous.** Most of the M03 bench
   reddens under each. That makes them cheap kills and says nothing about family
   L specifically; what family L contributes at those classes is the **first**
   message, not the only one.
3. **IC-L1 and IC-L4 collide with each other at one branch pair** and are
   separated only by the manifests (§10).
4. **The bench's own diagnosis is coarser than its detection.** Unit 1's frame
   count speaks before its per-frame walk, so three very different failure modes
   arrive at the same first message. That is a limitation of what a scorecard
   can *say*, not of what the bench can *catch*, and the seal keeps the two
   apart.

---

## 15. What comes back

1. The **five manifests** per §7.
2. **All six disclosures**, in the auditor's own words.
3. The **§6 pre-ship check** result for the four datapath-silent class-branches.
4. The **full scorecard**: every unit red or green under each class, at the base
   SHA, with the **raised message at every red — the message, not a summary of
   it**, because the seal's cells are message-level. Where a unit raises inside
   a `List.iter` over lanes or lengths, the **row prefix** distinguishes the
   member and must be reproduced verbatim.
5. The **control run**: the unmutated base SHA green, with its **CI run id and
   conclusion**.
6. The **per-class CI run id and branch name**, so §10's ordering is auditable.
7. Anything judged rather than followed, and why.

**Adjudication is mine**, against the sealed file, which is opened **only after
every scorecard is in hand**.

---

## 16. Not to be told

The sealed companion in its entirety: its matrix and its MUST-STAY-GREEN sets,
its verbatim message cells, the assertion orders inside `run_l1_l2_l3_l4` and
`assert_l5_run`, the derived-number table, its UNWORKED adjudication rules, its
disclosure-branch tables, **which** classes collide and with what strings, its
GREEN-BY-BLINDNESS section, and its dispositions.

**Freely told, and told above**: the five classes and the sentence of the
specification each is derived from; the six mandatory disclosures; §2's
denominator and its `test/cosim/` correction; §3's instrument survey and the
blast-radius rule form; **§4's six declarations of what this campaign cannot
score**; §5's reachability standard; §6's signature and its domain; §7's
allowlist and manifest bars; §8's base SHA, ordering rule and the two bounded
classes' scoring rules; §9's mutant-owned axes; §10's *existence* of two
collisions and what they cost the manifest; §11's era-wide scorecard rules;
§12's price; §13's non-closures and carriers; §14's weighting; §15's return
format.

---

## Return / verdict log

*(empty — the auditor appends its return here, and dv_lead its verdict.)*

---

## WO-0073-VERDICT — dv_lead, `J-dv_lead-0134`

**Five classes seeded, five adjudicated, five KILLED. No class SURVIVED, no
class VOID. Campaign total 5 of a sealed maximum of 5.** Every one of the seven
REQUIRED red cells raised the sealed string **character-for-character**, every
mutant-owned integer matched its derived value and satisfied its sealed
direction, and all three load-bearing REQUIRED greens held. The manifest is
convicted of nothing. The five findings this round produces are **four against
me and one against an instrument I own**; none is against the auditor.

**And the round did what §4 said it would do rather than what a scorecard would
have preferred**: `M03-L3` and `M03-L4` are **NOT QUALIFIED** and cannot be, on
their own instruments, by any outcome here.

---

### 0. Preconditions re-checked rather than assumed

| precondition | how checked | result |
|---|---|---|
| HEAD at adjudication | `git rev-parse HEAD` | `e5c0b11` — the auditor's manifest commit, one commit past the base, touching only `docs/reports/audit/**` and the auditor's journal |
| the bench is strictly earlier than every mutant | `git diff --stat bbd4122 e5c0b11 -- test/ libs/ tools/ docs/specs/` | **empty.** Not one `test/**` byte moved between the seal and this verdict. §8's ordering rule holds as written |
| every branch is cut from the base | `git rev-parse <branch>^` ×5 | all five parents are `bbd4122`; `60ed49c`'s parent is `c66565d`, itself off `bbd4122` |
| IC-L2 and IC-L5 are not one change | `git merge-base --is-ancestor` both ways | neither is an ancestor of the other; common base `bbd4122`. **Two diffs, not one** |
| each diff touches one file | `git diff --stat bbd4122 <branch>` ×5 | `libs/hardcaml_ethernet/src/xgmii_rx_64.ml` only, in all five |
| the denominator | `grep -c '^let%expect_test'` over `test/**` at the base tree | **59 M03 / 139 repo / 80 non-M03**; non-M03 splits **37 + 25 + 11 + 3 + 3 = 79** behavioural **+ 1** build-level. Seal §0 confirmed figure for figure |
| the control | CI, not a badge | run **`31039283863`**, `build` job **`92419315774`** — steps 5–10 all `success`; `cosim` job `92419315692` `success`; `journal-check` run `31039283809` `success` |

**Every score below is read from the `build` job's own step readings and from the
`.corrected` hunks in its step-6 output** — never from a run badge. The
`journal-check` red on all five transients is the known and expected noise of a
mutation commit that carries no journal entry; it scores nothing.

---

### 1. The runs

| class | branch | commit | `build` run | `build` job | step 5 | step 6 | `cosim` job |
|---|---|---|---|---|---|---|---|
| **IC-L1** | `mut/wo-0073-l1` | `8fe0251` | `31044630489` | `92437034170` | `success` | **`failure`** | `92437033946` `success` |
| **IC-L2** | `mut/wo-0073-l2` | `e24e523` | `31044675210` | `92437186602` | `success` | **`failure`** | `92437186512` `success` |
| **IC-L3** | `mut/wo-0073-l3` | `60ed49c` **(TIP)** | `31045274017` | `92439137615` | `success` | **`failure`** | `92439137645` `success` |
| **IC-L4** | `mut/wo-0073-l4` | `22b538f` | `31044835612` | `92437700672` | `success` | **`failure`** | `92437700545` `success` |
| **IC-L5** | `mut/wo-0073-l5` | `806d3d5` | `31044870620` | `92437812542` | `success` | **`failure`** | `92437812511` **`failure`** |
| *(superseded)* | `mut/wo-0073-l3` | `c66565d` | `31044805815` | `92437603958` | — | — | **DISCARDED, Q2** |

**Step 5 `Build` is `success` in all five.** No mutant failed to compile, so the
**build-finding class never fired** — neither at `test/hardcaml_ethernet/`'s
single unit nor at `test/cosim/`'s `(executables)` stanza. §2.1's two-home split
is confirmed as correct and confirmed as not needed this round.

---

### 2. The REQUIRED cells — seven red, three green, all ten hit

Compared character-for-character by script against §4's literals, with `<n>` and
`<ℓ>` matched as capture groups and every other character required exact.

| class | unit | sealed cell | observed | mutant-owned |
|---|---|---|---|---|
| **IC-L1(D)** | 1 | §4.1 | `M03-L1/L2/L3/L4: 10 000 frames presented, 5000 tlast words observed` | `5000` — sealed `< 10 000`, **derived 5 000** ✓ |
| **IC-L1(D)** | 2 | §3.1 `G` | **GREEN** ✓ | — |
| **IC-L2(U)** | 1 | §4.2 | `M03-L1/L2/L3/L4 (h = 8): latencies is not the single value this front-offset class must carry (§0.5 Start lanes)` | fixed string, no value printed ✓ |
| **IC-L2(U)** | 2 | §4.2 | `M03-L5 (lane 0, length 64): latencies = [24], expected [16]` | `24` — sealed `> 16`, **derived 24** ✓ |
| **IC-L3** | 1 | §3.1 `G` (4 ∉ R) | **GREEN** ✓ | — |
| **IC-L3** | 2 | §4.3 | `M03-L5 (lane 0, length 70): latencies = [16; 24], expected [16]` | `<ℓ>` = `70`, `<n>` = `24` ✓ |
| **IC-L4(S)** | 1 | §4.4 | `M03-L1/L2/L3/L4: 10 000 frames presented, 5000 tlast words observed` | `5000` — sealed `< 10 000`, **derived 5 000** ✓ |
| **IC-L4(S)** | 2 | §3.1 `G` | **GREEN** ✓ | — |
| **IC-L5** | 1 | §4.5 | `M03-L1/L2/L3/L4: 10 000 frames presented, 20000 tlast words observed` | `20000` — sealed **`> 10 000`**, **derived 20 000** ✓ |
| **IC-L5** | 2 | §4.5 | `M03-L5 (lane 0, length 64): latency tagger errors:`⏎`frame 0: 72 input octets less 8 stripped from the front and 4 from the back is 60, but 64 octets were emitted` | `64` — sealed `> 60`, **derived 64** ✓ |

**10 / 10.** The `§` in IC-L2's unit-1 cell arrives through `ppx_expect`'s
backtrace dump as the decimal escapes `\194\167`, i.e. UTF-8 `U+00A7`; decoded,
the string is the seal's byte for byte. `<ℓ>` = 70 is not mutant-owned in §9's
sense — it is the disclosed `R = {2}` read through §2.4's residue map, which both
sides held, and the map put the first-speaking member at the **seventh** of
eighteen runs exactly as tabulated.

**How deep each unit got before it spoke**, which is the §6 adjudication check
executed rather than asserted:

| class | unit 1 first speaker | items that ran | unit 2 first speaker |
|---|---|---|---|
| IC-L1(D) | **item 3** | 1–3 | — (green) |
| IC-L2(U) | **item 7**, h = 8 arm | 1–7 | `latencies`, member 1 |
| IC-L3 | **none — green** | **1–9, all** | `latencies`, member 7 |
| IC-L4(S) | **item 3** | 1–3 | — (green) |
| IC-L5 | **item 3** | 1–3 | **`Latency.errors`**, member 1 |

---

### 3. The three greens that carry the measurement

1. **IC-L1 and IC-L4 leave unit 2 GREEN.** Sealed at §10(e) from the stimulus:
   every L5 run is `one_frame`, so there is no preceding terminate for a start
   word to be adjacent to and no following start for a tail word to collide with.
   Both classes' conditions are empty sets there and both units stayed green.
   **§8.1's IC-L1 rule 2 is satisfied by measurement.**
2. **IC-L3 leaves unit 1 GREEN.** The stress frame delivers 60 octets, residue
   **4**; `R = {2}`, so `4 ∉ R` and `l3_block` is identically 0 across 10 000
   frames. **This is the single most valuable green in the campaign** — see §4.
3. **IC-L2's `Latency.errors` is EMPTY, and it is observed rather than hoped.**
   `assert_l5_run` reads `Latency.errors` **first** (§2.3); under IC-L2 the
   message that spoke was the `latencies` comparison, four checks later. So the
   tagger's error list, `frames_compared`, the single-class test and
   `front_offset` **all passed** under a uniform ΔC 3 → 4. **§4.2's three
   arithmetic facts — closure at (L + h) = 32, the ceiling test `4 > 4` false,
   and the pair rule admitting (4,4) — are confirmed by measurement.** REQ-019's
   entire machinery is silent on a one-cycle regression that spends the reserve
   SPEC-M03 §7 deliberately left, and the **only** assertion in this bench that
   convicts it is REQ-005/REQ-111's pinned constant.

---

### 4. IC-L3 — the one result this campaign existed to get

**§8.1's IC-L3 scoring rule 1 is the rule in play**: red at the L5 rows whose
delivered residue ∈ R, **with unit 1 GREEN**. Both halves observed.

> **`M03-L5` detects what `M03-L2` cannot.** A pipeline whose delay varies with
> the final `tkeep` residue is invisible to a 10 000-frame fixed-length stress
> run — measured, not argued — and is convicted by the directed-length set at the
> first member whose delivered residue lies in the varying set.

`WO-0070` §3.4 wrote the row on the argument that the derivation cancels the
octet position entirely. This class asked the **design** instead of the
specification, and the row earned its existence. It is the only class in the
campaign whose entire convicting set lies outside the stress run, and it is the
only class that qualifies `M03-L5`.

**Q5 is thereby answered by the result and not only by the reasoning** — see §7.

---

### 5. Blast radius — counted, ruled, and not reported as coverage

| class | M03 units red | M03 files red | M03 green | non-M03 |
|---|---|---|---|---|
| **IC-L1** | **15** | 8 — b, d, e, g, j, k, l, n | 44 / 59 | **0 red — 79 + 1 held** |
| **IC-L2** | **49** | 13 — all but `structural` | 10 / 59 | **0 red — 79 + 1 held** |
| **IC-L3** | **14** | 6 — a, c, e, g, i, l | 45 / 59 | **0 red — 79 + 1 held** |
| **IC-L4** | **10** | 7 — d, e, f, h, j, k, l | 49 / 59 | **0 red — 79 + 1 held** |
| **IC-L5** | **51** | 13 — all but `structural` | 8 / 59 | **0 red — 79 + 1 held** |

**Every failing path in all five step-6 outputs is under
`test/xgmii_rx_64/`** — verified from each run's own `git diff --name-only`
promotion list, which `git` emits sorted, so any non-M03 red would have appeared
**before** every M03 file and could not have been missed. **The 79 behavioural
non-M03 units and the 1 build-level unit held under every class.**

**None of these reds is coverage.** Kills are counted **per class** (§11):
IC-L5's 51 reds are **one** kill, IC-L2's 49 are **one**. `test_m03_structural.ml`
never reddened under any class, which is correct — it asserts structure, not
behaviour.

#### 5.1 Standing rule 5 was exercised, in both directions, and it absorbed the divergence

`FINDING WO-0066-3` cost me three MUST-STAY-GREEN violations because my seal
carried an **enumeration** where the auditor's manifest carried a **rule**. This
round the seal carried rules with instances beneath them, and the rule and the
instances **did** disagree:

- **`test_m03_f.ml` stayed GREEN under IC-L1**, though §3.5's IC-L1(A) instance
  list named family F through `Dv_xgmii.Injection`.
- **`test_m03_g.ml` and `test_m03_i.ml` stayed GREEN under IC-L4**, though §3.5
  pointed IC-L4 at the same site list.

Under `WO-0066`'s regime these are three violations against me. **Under the rule
form they are none**: IC-L1's rule requires a start word whose *immediate
predecessor* carries a terminate character, and IC-L4's requires a frame's last
output word to fall on a cycle carrying an accepted start — conditions those
schedules' geometries do not produce. The **RULE governs** (standing rule 5) and
the instance lists were supersets. **The lesson held under test, which is the
first time it has been tested.** The per-row derivations are owed to the
post-campaign `AP-` round and are named there, not claimed here.

#### 5.2 The two worked instances both paid

- **WORKED GREEN.** §3.5 marked `test_m03_i.ml:1112` (`~ifg:824`, a gap of 824
  octet times) as the one instance predicted **GREEN** under IC-L1, on the ground
  that no start word can be adjacent to a terminate word at that gap. **`test_m03_i.ml`
  did not redden under IC-L1.** That is the discrimination the worked instance
  was bought for, and it is the difference between a rule and a slogan.
- **WORKED RED, branch-dependent.** §3.5 predicted `test_m03_c.ml:511` red under
  IC-L2 with the body *"the single output word did not arrive on start_cycle + 3
  (REQ-019)"*, and **green under IC-L3 unless 1 ∈ R**. Observed under IC-L2:
  `M03-C4 (lane 0): the single output word did not arrive on start_cycle + 3 (REQ-019)`
  — the sealed body with its row prefix. Observed under IC-L3 with `R = {2}`:
  `test_m03_c.ml` reddened at **C1 and C3 and not at C4**. Both directions hit.

---

### 6. The three named collisions, adjudicated by their sealed discriminators

**Collision 1 — IC-L1(D) ≡ IC-L4(S), unit 1 item 3. INSTANTIATED, and resolved.**
Both raised `M03-L1/L2/L3/L4: 10 000 frames presented, 5000 tlast words observed`,
**character-for-character including the integer**, exactly as sealed. The
protection was the whole of §10's operational demand and it was honoured: two
diffs, two branches, two commits off the base, two CI runs. Disposition 6 has no
purchase. **Both classes are scoreable and both are scored.**

**FINDING WO-0073-D4 (mine, MINOR).** The seal recorded collision 1's
discriminator as *"NONE that this bench produces"*. That is **exact at the cell
and too strong at campaign scope.** The campaign produces a measured
discriminator at a carrier outside family L:

| unit | IC-L1(D) | IC-L4(S) |
|---|---|---|
| **M03-K2** | `expected 16 delivered words, got 8` | `expected 16 delivered words, got 15` |
| **M03-J1** | `51 tlast words, expected 101` | `51 tlast words, expected 101` |
| files / units red | 8 / **15** | 7 / **10** |

**`M03-K2` separates them completely**: a dropped frame loses eight words, a
suppressed tail word loses one. The seal's claim should have been scoped —
*"none that this **cell** produces"* — and the campaign-scope discriminator
should have been sealed alongside it, since the auditor derived exactly that
separation independently at its §6 (*"they differ in every quantity beyond the
count"*). **No cell moves and no score changes**; the correction is to the
seal's phrasing and to how I scope such a claim next time.

**Collision 2 — IC-L3(4 ∈ R) ≡ IC-L2(U) at unit 1's h = 8 cell. NOT
INSTANTIATED**, because the disclosed `R = {2}` puts `4 ∉ R` and leaves unit 1
green. Its sealed discriminator is nonetheless **confirmed by measurement**:
IC-L2 reddens unit 2 at **length 64** with `latencies = [24]`; IC-L3 at **length
70** with `latencies = [16; 24]`. Both the length and the printed list separate
them, as sealed.

**Collision 3 — IC-L2(U) ≡ IC-L4(F) at unit 1's h = 8 cell. NOT INSTANTIATED**,
because IC-L4 was rendered at branch **S**, which speaks at item 3 and not at
item 7. Its sealed discriminator — *unit 2's state* — is confirmed in the one
direction the round could reach: IC-L2 reddens unit 2, IC-L4 leaves it green.

**Near-collision — IC-L5 against the pair, at the same item-3 string.
INSTANTIATED, and separated by §9's sealed DIRECTION**: `20000` where the
direction is `> 10 000`, against `5000` where it is `< 10 000`. **This is what
sealing mutant-owned quantities as inequalities with named directions is for**,
and it is the first round in which that device carried a discrimination by
itself.

---

### 7. Rulings on the auditor's questions, and on the base identity

**Q1 / base identity — FINDING WO-0073-M1 CONFIRMED as MINOR and materially
void. The campaign base reads `bbd4122`.** Verified independently at this seat:
`git rev-parse bbd4122^` = `8acd28d`; `git diff --stat 8acd28d bbd4122 -- libs/
test/ tools/ docs/specs/` is **empty**; the only differences are the packet, the
seal, and my own journal — **none of them a path this campaign scores**. §8's
purpose is the adjudicator-ordering rule, and that rule holds identically under
either reading. Every §8 and seal reference to "the base SHA" reads **`bbd4122`**,
and the control run is `bbd4122`'s own.

> **The drafting defect is mine and is recorded as such.** §8 defined the base as
> *"the parent of the commit staging this packet and its seal"*. That is wrong,
> and it was wrong at the moment it was written: the packet and the seal are not
> scored paths, so the correct base is **the commit that stages them**, which is
> also the only commit an operator can be dispatched against. **Corrective rule
> for every future campaign packet**: define the base SHA as *the commit that
> stages this packet and its seal*, never as its parent. The auditor filed this
> before the first branch was cut, exactly as §8 demanded, and that is the clause
> working.

**Q2 / `mut/wo-0073-l3` carries two commits — RULED.** IC-L3 is scored from the
**tip `60ed49c`**, run `31045274017`. `c66565d`'s run `31044805815` is
**DISCARDED and scores nothing**, per the auditor's own request and my
independent reading of the two diffs. Two facts are worth more than the ruling:

- **The defect was found by R-DISC-1's per-lane obligation, before any scorecard
  existed.** Holding only `r2` suffices for the lane-0 members of R (closure
  record at age 2) and strands the lane-4 members (age 1) — word loss, not a
  one-cycle delay, and therefore **not the class**. This is the first round in
  which the per-lane discharge burden has visibly paid for itself, and it paid by
  catching a rendering that would have scored as an out-of-specification class
  under disposition 7. **The burden is retained, and this is its citation.**
- **`git push --force-with-lease` was refused by repository rules on a transient
  ref.** PROTOCOL R9's no-force-push guarantee holds on `mut/**` as well as on
  `main` and the working branch. Recorded as a fact about the enforcement
  surface, and a welcome one.

**Q3 / IC-L2 registers the five strobes with the datapath — RULED: the
auditor's reading is CORRECT and is the reading the seal assumed.** Ground:
SPEC-M03 §9 pins every strobe to its frame's own `tlast` cycle, and the seal's §9
carries *"the strobe set over either unit = ∅, not mutant-owned"*. A rendering
that delayed `rx` alone would have produced a **strobe/`tlast` skew** — a second
defect no class here names, and precisely disposition 7's "the class plus a
defect" territory. **The evidence confirms the rendering behaved as read**:
`M03-F2 (lane 0, 0 octets received): error_runt pulsed on cycle 5, expected 4`
and `M03-E2 (lane 0): error_bad_frame pulsed on cycle 5, expected 4` show the
strobes moved by **exactly one cycle, with the datapath**, while family L's own
strobe set stayed **∅** (item 5 passed under IC-L2 — proven by item 7 speaking
after it). No cell branched the other way; no cell moves.

**Q4 / IC-L2 and IC-L5 edit the same site — RULED: §7 item 1 is NOT read against
them.** §7 item 1 bars a **diff** that combines two classes. These are two diffs,
on two branches, each applying alone to `bbd4122` and reverting cleanly, neither
an ancestor of the other, with two CI runs — verified at this seat by
`git merge-base --is-ancestor` in both directions. **A shared hunk header is a
fact about the file's layout, not about the diffs' contents.** Disposition 6 has
no purchase, and the flag was the right call: it is exactly the kind of
coincidence that would otherwise be discovered from a scorecard.

**Q5 / `R = {2}` — RULED: accepted, and it was the better choice than
`{1, 2, 3}`.** Three grounds, the first decisive:

1. **`4 ∉ R` is what makes §8.1 rule 1 available**, and rule 1 is the only route
   by which the length-dependence claim can be **earned** rather than merely
   seeded. A set containing 4 would have reddened unit 1 too and forfeited the
   claim under rule 2 — the campaign would have kept its kill and lost its
   result.
2. **Four members worked completely beat eight worked thinly** — and the
   completeness is not decorative: it is what found the lane-4 stranding defect
   (Q2).
3. **`|R| = 1` at residue 2 minimises §5.3's shadowing loss and, uniquely,
   converts it into measurement.** The map puts residue 2's first lane-0 member
   at length **70**, the **seventh** of eighteen runs — so members 1–6 (lengths
   64–69 at lane 0) were **observed GREEN**, not shadowed. §5.3's bound bit
   exactly as sealed under IC-L2 (one of eighteen observed, seventeen unobserved)
   and cost six fewer members under IC-L3. **The shadowing cost is a function of
   where R's first member falls, and a narrow R placed late is cheaper than a
   wide R placed early** — which the seal did not say and which this round
   measured.

---

### 8. GREEN BY BLINDNESS — scored as declarations, because a green there is not vigilance

| § | declaration | outcome | what may be said |
|---|---|---|---|
| **6.1** | `M03-L4`'s item 6 (sequence read-back) is **structurally unreachable**: item 4 compares the same octets positionally and earlier | Under IC-L1/L4/L5 item 6 never ran; under IC-L2 it **ran and passed**; under IC-L3 it **ran and passed**. Its greenness is evidence that item 4 ran | **`M03-L4` is NOT QUALIFIED and cannot be.** No kill here is evidence about REQ-020's order preservation |
| **6.2** | `M03-L3`'s item 8 is **unreachable term by term** | Never reached under four classes; under IC-L3 it ran and passed on operands item 7 and item 4 had already fixed | **`M03-L3` is NOT QUALIFIED and cannot be.** Its ΔC content remains discharged by `WO-0070` §6's derivation and by no run |
| **6.3** | item 9's only reachable residue is REQ-014's `tstrb` half | No class touched `tstrb`; IC-L2 left it the constant `zero 8` deliberately | Untouched, and a standing-monitor question |
| **6.4** | REQ-020's **reordering** half has no renderable mutant | The auditor **independently agreed from the design side**, blind to the seal (manifest §8) | **Upgraded from my claim to a two-party agreed bound.** The strongest form this bound can take short of a proof |
| **11.4** | item 5's empty-strobe-set check has **no seeded class** | Green under all five | **A green there means nothing and this verdict cites it as nothing** |
| **5.3** | seventeen of eighteen unit-2 members are shadowed | Bit exactly under IC-L2; **six members observed green** under IC-L3 | Every unobserved member is recorded **unobserved** — never a miss, never a pass |

**§12's pass criterion 6 is discharged**: the two unreachability findings are
stated whatever the score is, and the score does not soften them.

---

### 9. Campaign scorecard

| class | branch | disclosed | `R!` hit | cells message-exact | `G` / `G✱` held | MUST-STAY-GREEN | kills |
|---|---|---|---|---|---|---|---|
| **IC-L1** | `l1` | **A / D** | 1 / 1 | **1 / 1** | 1 / 1 | M03 44/44 · non-M03 **79 + 1** | **1** |
| **IC-L2** | `l2` | **U** | 2 / 2 | **2 / 2** | — | M03 10/10 · non-M03 **79 + 1** | **1** |
| **IC-L3** | `l3` | **R = {2}** | 1 / 1 | **1 / 1** | 1 / 1 | M03 45/45 · non-M03 **79 + 1** | **1** |
| **IC-L4** | `l4` | **S** | 1 / 1 | **1 / 1** | 1 / 1 | M03 49/49 · non-M03 **79 + 1** | **1** |
| **IC-L5** | `l5` | **once** | 2 / 2 | **2 / 2** | — | M03 8/8 · non-M03 **79 + 1** | **1** |
| **total** | **5 / 5** | **6 / 6 disclosures** | **7 / 7** | **7 / 7** | **3 / 3** | **zero violations** | **5 / 5** |

**Disposition 1 at all five.** No class met disposition 2 (a control reddened),
3 (not seeded), 4 (a monitor or `test bug --` red inside family L), 5 (neither
branch), 6 (a combined diff) or 7 (a datapath message at a datapath-silent
class). **Disposition 7 has no instance and that is a measured result**: IC-L2's
unit-1 message is item 7's, which requires items 3, 4 and 5 to have passed —
frame count 10 000, every word's `tkeep`, every `tlast` placement, every `tuser`,
every octet positionally, and an empty strobe set; and IC-L3 left unit 1 green
across all 10 000 frames. **The auditor's §7 pre-ship claim that IC-L2 and IC-L3
produce no component of the `BUG-0003` §V.10.2 signature is confirmed by
measurement, not accepted on assertion.**

**How the reds present**, continuing the taxonomy `WO-0063B` FINDING 3 opened:

| presentation | classes |
|---|---|
| **count** difference — marks removed | IC-L1(D), IC-L4(S) at item 3 |
| **count** difference — marks added | IC-L5 at item 3 and at the tagger's octet extent |
| **cycle** difference, uniform | IC-L2 at both units |
| **cycle** difference, **content-keyed** | **IC-L3** — new this round, and the only class whose convicting set lies wholly outside the stress run |

---

### 10. Findings

| id | class | finding | effect |
|---|---|---|---|
| **WO-0073-M1** | MINOR, auditor-filed, **against me** | §8's base-SHA definition names the parent of the packet's commit; the operating base is the packet's commit itself | **Materially void** — trees byte-identical at every scored path. Base reads `bbd4122`. **Corrective drafting rule adopted** (§7) |
| **WO-0073-D1** | MINOR, **against my seal** | The seal declared `test/cosim/` a **build-finding home only**. It is also a **behavioural** detector, and it reddened under IC-L5 | **Not a MUST-STAY-GREEN violation** (that set is defined over units; `test/cosim/` has none) and **not a scope finding against the manifest** (the red is selected by IC-L5's own §3.4 rule). **The denominator's exposure statement was one level too shallow** — the same shape as the correction the seal itself made at §0, made one level short |
| **WO-0073-D2** | **MATERIAL**, against an instrument I own | The Phase-1 differential co-sim lane is **content-comparing, not timing-comparing**: it passed under IC-L2, a uniform ΔC 3 → 4 on every output word **and** every strobe | **No `SO-` may cite the co-sim anchor as timing coverage.** Combined with §3.3's measured silence of `Latency.errors`, **the pinned per-octet constant is the programme's only detector of a one-cycle word-delay regression** |
| **WO-0073-D3** | MINOR, against the bench, **mine** | `OBSERVATION L-O1`'s shape exists **outside family L**: under IC-L2 and IC-L3, `M03-I4` raised `... test bug -- the baseline's own tlast cycle does not match the gapless m + 3 formula` — a **design** red wearing a bench-bug prefix | Same disposition as §5.5: **a design red mislabelled by the bench**, never read as a bench defect or a stimulus problem. **Carrier: the next commit that opens `test/xgmii_rx_64/test_m03_i.ml`** |
| **WO-0073-D4** | MINOR, against my seal's phrasing | Collision 1's discriminator sealed as *"NONE that this bench produces"* — exact at the cell, too strong at campaign scope (§6) | No cell moves. **Scope such claims to the cell, and seal the campaign-scope discriminator beside them** |
| **WO-0073-D5** | MINOR, against `tools/`, **mine** | `run_cosim.sh` reported `FAILED CHECK: BUILD (ours_run failed in run1, rc=2)` for a **runtime raise inside check 1**, on a run whose build succeeded (`dune build: ok`) | A diagnostic that names the wrong check sends a reader to the wrong file. **Carrier: the cosim-lane round commissioned at §12** |

#### 10.1 What is NOT a finding — the manifest

**No scope violation**: every diff touches `libs/hardcaml_ethernet/src/xgmii_rx_64.ml`
and nothing else, and no red appeared at any of the 79 behavioural non-M03 units.
**No combined diff.** **No class, lane, length or parity self-declared NOT
SEEDED**, and every required consequence's own lane, length and parity was
discharged term by term at the firing cycle. **All six disclosures answered
before the run**, in the auditor's own words, in a committed manifest that reached
me only at `e5c0b11` — after all five diffs were committed on their branches
(`8fe0251` 20:33:25Z … `60ed49c` 20:41:27Z, manifest commit 20:54:37Z). **The
pre-run reading note was delivered as a note and not as a negotiation**, and it
answered my `J-dv_lead-0133` Open-question 4 in the form and at the time
`WO-0063B`'s precedent requires. This is the cleanest manifest of the ten
campaigns.

#### 10.2 The IC-L5 co-sim red, adjudicated

`cosim` job `92437812511`, check 1 of 3:

```
Fatal error: exception Failure("ours_run: M03 produced an output word with no admitted frame open")
  ... test/cosim/ours_run.ml, line 119
run_cosim: FAILED CHECK: BUILD (ours_run failed in run1, rc=2)
```

The lane's own driver refused the duplicated word on a single 64-octet
good-FCS lane-0 frame. **This is selected by IC-L5's §3.4 rule in substance** —
the guard is an assertion about what the cycle after a `tlast` carries — so it is
**predicted blast radius, contributing zero additional kills**. It is a finding
against **the seal's declared universe** (WO-0073-D1), not against the manifest,
and not a MUST-STAY-GREEN violation. **The other four classes' `cosim` jobs
passed**, which is what makes WO-0073-D2 a measurement rather than a suspicion:
the lane sees a duplicated word and does not see a uniformly delayed one.

---

### 11. What is QUALIFIED, and what is not

| row | status | on what |
|---|---|---|
| **`M03-L1`** | **QUALIFIED** | IC-L1(**D**), IC-L4(**S**), IC-L5 — three classes convicting through **one** instrument, item 3's `tlast` count. §8 check 1 (frames out = frames in) is scored |
| **`M03-L2`** | **QUALIFIED** | IC-L2(**U**) — both front-offset class records; the L5 members corroborate at `latencies = [24]` |
| **`M03-L5`** | **QUALIFIED** | IC-L3 (`R = {2}`) — **and the length-dependence claim is EARNED** under §8.1 rule 1 |
| **`M03-L3`** | **NOT QUALIFIED** | its instrument is structurally unreachable (§6.2). Scored-and-unqualifiable, which is a result and not an omission |
| **`M03-L4`** | **NOT QUALIFIED** | its instrument is structurally unreachable (§6.1). Same |

**A kill here qualifies a row on the class it was seeded against and on nothing
else** (§13.7). Consequences stated so they are not invented later:

- **No family-M row is qualified by this campaign.** IC-L2 and IC-L5 reddened
  `M03-G3`, `M03-G4`, `M03-G7` and `M03-G8` — the carriers `FINDING M-1`/`M-2`
  bound `M03-M6` and `M03-M7` to. **Those reds are blast radius under the
  classes' own rules and contribute zero kills**, so they qualify neither the
  carrier's row nor the row bound to it. §11's rule and the plan's own
  pre-recorded note (*"a scorecard must not report that as two kills"*) both
  point the same way, and this verdict counts neither.
- **No family B, C, D, E, F, G, H, I, J, K or N row is qualified**, for the same
  reason.
- **The `P1-module-ready` line-rate-stress line is not signed by any outcome
  here** (`RV-0070-VERDICT` §4, packet §0.1).
- **No `SO-xgmii_rx_64.md` is opened or offered.** Families **M**, **J** and
  **K** are unscored and the charter §3 co-sim anchor is undischarged per class —
  and WO-0073-D2 has now made that second item sharper rather than smaller.

---

### 12. What is commissioned

**In this order:**

1. **The post-campaign `AP-xgmii_rx_64.md` round. The §8 window is closed — the
   campaign has scored — and this is the round that opens `test/attack_plans/**`.**
   Its items, all named in advance at §13.1 and §13.3:
   1. §4.L's landed-status block gains the campaign score, the five branch/run
      ids and the control run id.
   2. **`M03-L1`, `M03-L2`, `M03-L5` → QUALIFIED**, citing this verdict and the
      class each was convicted on; **`M03-L3` and `M03-L4` recorded
      scored-and-unqualifiable** with §6.1/§6.2's arguments, in their own cells,
      where a future scorecard will look.
   3. §7 gains the §4 unreachability findings beside the X-rows, plus §6.6's
      portable form: *an assertion whose subject is already compared,
      positionally and earlier, by a sibling assertion in the same unit is
      unreachable, and its greenness is evidence about the sibling.*
   4. **WO-0073-D2 recorded against §7's co-sim banner** — the lane's per-class
      obligation now has a **named blindness**, not only a named gap.
   5. §5.1's three rule-versus-instance divergences derived per row, and the
      change-log row.
2. **The family M campaign packet** — next of the four, carrying `OBSERVATION
   M-O1` and the `M03-M2` residue-comparison class §4.M's own note commissions.
3. **The cosim-lane round** (`test/cosim/**`, `tools/cosim/**`), which pays three
   debts at once: **WO-0073-D2** (add an explicit timing comparison to the
   differential lane, or record the bound in `CD-xgmii_rx_64_cosim.md` and in
   every `SO-` that cites the anchor); **WO-0073-D5** (`run_cosim.sh`'s
   wrong-check label); and `test/cosim/dune`'s dangling `test/cost_probe/`
   reference, open since `J-dv_lead-0132` Open-question 1 with this exact
   carrier.
4. **The family J and family K campaign packets**, closing the era's four.
5. **`OBSERVATION L-O1`'s one-line repair and WO-0073-D3's `M03-I4` mislabel**
   ride the next commits that open `test_m03_l.ml` and `test_m03_i.ml`
   respectively — unchanged carriers, now with a measured instance behind each.

**Not commissioned, and named so the omission is visible:**

- **No bench change is owed by this result.** Every unit behaved correctly,
  including all five that stayed green where the instance lists said they would
  redden. The two mislabelled-prefix items are diagnostics, not verdicts, and
  neither changed a score.
- **No `BUG-` is opened, and the reason is stated.** Every red in this campaign
  is a seeded mutation killed by the suite. **No divergence of the unmutated
  design from its specification was observed** — the control is green at every
  step of both jobs. There is nothing to report to rtl_lead.
- **No revert of anything.** No class killed the bench rather than the mutant.

---

### 13. What this campaign does and does not qualify — the one-paragraph form

**It qualifies three of family L's five rows, on five classes, at one bench, on
one stimulus each.** It establishes by measurement that a fixed-length
line-rate stress run cannot see a residue-keyed latency defect and that the
directed-length set can; that a one-cycle word-delay regression is invisible to
REQ-019's entire error machinery **and** to the differential co-simulation lane,
leaving REQ-005/REQ-111's pinned constant as its only detector; and that
`M03-L3`'s and `M03-L4`'s own assertions cannot speak under any mutation. **It
does not qualify `M03-L3` or `M03-L4`; it signs no gate line; it opens no
`SO-`; it says nothing about families J, K or M; and a kill proves the assertion
convicts, never that the bench is a general detector of the class.** IC-L2 and
IC-L5 are detected across most of the M03 bench — this bench was not blind to
either, and nothing here should be read as saying it was.
