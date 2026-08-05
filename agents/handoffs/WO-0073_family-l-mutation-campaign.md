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
