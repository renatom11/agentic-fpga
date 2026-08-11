# SO-xgmii_rx_64 — **DRAFT. VERDICT FIELD UNSET.**

- **State**: **DRAFT** — this document *designs* the sign-off. A later round
  *executes* it. Nothing here is a sign-off and nothing here may be relayed as one.
- **Verdict**: **UNSET** — neither `PASS` nor `FAIL`. §1's criteria are the terms on
  which the verdict will be written; not one of them is adjudicated in this file.
- **Module / spec**: `libs/hardcaml_ethernet/src/xgmii_rx_64.ml` (M03) against
  `docs/specs/modules/xgmii_rx_64.md` (SPEC-M03) and `docs/specs/requirements.md`.
  **This seat does not read that RTL** (PROTOCOL §10); the path names the module the
  verdict is about, never a document this packet derives from.
- **Attack plan**: `test/attack_plans/AP-xgmii_rx_64.md` (AP-M03).
- **Co-sim design document**: `test/attack_plans/CD-xgmii_rx_64_cosim.md` (CD).
- **From / To**: dv_lead → orchestrator (merge precondition; **verbatim** relay class,
  PROTOCOL §3 — *when it is issued*; a DRAFT is not yet in that class).
- **Drafted at**: `49d87af`, 2026-08-10. **Drafting entry**: `J-dv_lead-0161`.
- **Execution — round 1 of 2**: §7.1 steps **1–5** executed at `J-dv_lead-0163`,
  base `4e7331b`. Steps **6–12** follow in a second round (step 7's CI run needs
  steps 2–3 landed first — §7.1's own 3→6 edge). **The State field above is
  unchanged and §8's verdict is still UNSET.** What round 1 paid are §3 ledger
  items — carriers — and **a carrier payment adjudicates no criterion of §1**.
  The execution record is §3.0.
- **Execution — round 1R (repair)**: `J-dv_lead-0164`, base `ee3da9c`. Round 1's
  `RN-6` check reached a runner and **failed** — `build` run `31442295998`,
  4 UNDECLARED broken citations, all citing `docs/reports/latency/`, this packet
  among the four citers. **The catch was a true positive AND the instrument was
  measuring the filesystem instead of the tracked tree.** Both repaired: §3.0.1
  records the round, §3.2.1 the resolver, the four dispositions and the evidence.
  **Not a §7.1 step; no ledger item moves; State stays DRAFT and §8 stays UNSET.**
- **Signed**: *(unsigned — the executing round signs `J-dv_lead-NNNN` here)*

---

## 0. What this document is, and the four things a draft of it may not do

### 0.0 Why a draft at all

The `SO-` is the document the whole programme has been building toward, and it is the
first document in this programme that **may not discover its own shape while writing
it**. Every round that fed it — sixteen bench rounds, ten mutation campaigns, two
co-simulation stages, one error-class sweep — left it a named obligation with a named
carrier, and the terminal carrier for a dozen of them is *this packet*. A round that
opened a blank `SO-` and started writing would meet those obligations in the order it
happened to remember them, which is exactly the failure mode this programme has paid
for at `RV-0039-VERDICT` F-2, at `AP-M03` §0.1's two minting instances, and at
`FINDING WO-0077-A1`.

So the design is separated from the execution **by one commit**, and the separation is
the same one `RV-C4` §9 made when it withheld Stage 2's completion for exactly one
round: *a condition whose author may discharge it by declaring it discharged is not a
condition.* This draft writes the criteria, the evidence map, the owed ledger, the
prohibitions, the harvest's form and the execution order. **It adjudicates nothing.**

### 0.1 The four prohibitions this draft inherits and obeys in its own text

1. **No verdict.** No sentence of this file asserts that any criterion is met. Where a
   figure appears it is quoted **with the SHA and the entry that measured it**, as
   material the executing round must **re-measure**, never as a finding of this one.
2. **No claim of the form *"the co-simulation anchors this module"*** — `WO-0078` §8,
   `AP-M03` §7. A class is anchored; a requirement is not; a module never is.
3. **No lift of any bar, and no implication that one moved.** `AP-M03` §7's bars 1–4
   stand exactly as `J-dv_lead-0159` left them, and §5 below restates them rather than
   summarising them.
4. **No set claim without its three dimensions** — §0.2.

### 0.2 The census rule at full width, which this packet is bound by and which its own §1 makes a criterion

Three findings mint one rule in three dimensions, and the `SO-` is the document all
three were routed to:

| dimension | source | obligation |
|---|---|---|
| **SHA** | `AP-M03` §0.1 (`FINDING WO-0066-3`, `FINDING WO-0066-6`) | a claim quantifying over a set is **re-measured at the point of citation**, or quoted **with the SHA and the command it was measured at** |
| **DOMAIN** | `FINDING WO-0077-A1` (MAJOR), filed at `AP-M03` §7 | any universal quantified over *"the bench"* is measured over **every producer that drives the DUT** — `test/cosim/` included — or it is quoted with the producer set it was measured over |
| **POLARITY** | `FINDING RV-0078-S2-13`, filed at `AP-M03` §7 | a claim that a mechanism **does not exist** is measured over **every landed construction of the thing in question**, not only over the modules that would naturally host one |

**A set claim carrying none of the three is not evidence, and an `SO-` resting on one
is adjudicated as resting on nothing.** Every count in this file is therefore either
(a) quoted with its measuring entry and marked `RE-MEASURE`, or (b) absent on purpose.

### 0.3 What this packet is NOT the carrier for

- It is **not** the `P1-module-ready` gate checklist. It supplies that gate's DV rows;
  the checklist lives in `docs/gates/`, which dv_lead cannot stage (PROTOCOL §6), and
  the orchestrator transcribes every signature (PROTOCOL §7).
- It is **not** an escalation. A `FAIL` here would be normal packet flow to rtl_lead,
  not an E-class item (charter §7).
- It is **not** the sponsor's approval. That is E1 and it lands at
  `P1-phase-accept` (§7.3).

---

## 1. THE SIGN-OFF CRITERIA

**Fourteen, numbered `SC-1` … `SC-14`, each stated so a reader who was not here can
check it.** They are the union of charter §5's DoD checklist, PROTOCOL §7's
`P<n>-module-ready` precondition, and the module-specific obligations this programme's
own verdicts minted. **The verdict is `PASS` iff every one of the fourteen is met;
`FAIL` otherwise.** There is no third value and no criterion is waivable in the
packet that is graded by it.

> **SC-1 — ATTACK-PLAN PRECEDENCE AND ROW ACCOUNTING.**
> `test/attack_plans/AP-xgmii_rx_64.md` was committed before this module's first test,
> and at the sign-off SHA every row of it is either discharged by a landed unit or
> carries an explicitly declared status token. **The declared-status inventory — total
> rows, `ASSERT`, `NO-ASSERT`, `NO-STIMULUS`, `STRUCTURAL`, `GAP` — is stated as
> MEASURED at the sign-off SHA by a status-cell pass over every row table, and is
> never carried forward from a prior round.**

> **SC-2 — SPEC-DERIVED COVERAGE, PER REQUIREMENT, WITH GAPS DECLARED.**
> Every `REQ-###` named in `docs/specs/modules/xgmii_rx_64.md` §10 maps to at least one
> named landed unit, or carries a declared gap stating what is missing and why. **The
> mapping is derived from the spec, never from the RTL**, and the packet's `Inputs`
> record shows it: no `libs/**`, `top/**` or `rtl_snapshots/**` path appears in this
> packet's derivation chain. The test-side rows of the traceability matrix are
> delivered to architect_docs_lead (charter §4).

> **SC-3 — SUITE GREEN AND TREE CLEAN AT THE SIGN-OFF SHA, ON A RUN ID.**
> `opam exec -- dune runtest` green **and** `git add -A && git diff --cached
> --exit-code` clean at the sign-off SHA, with both commands quoted verbatim and with
> the CI `build` run id and the conclusion of each step it covers. **A local green is
> not the evidence; the run id is** (`WO-0072` §4: *"It is a TITLE count, not a pass.
> The pass is the run id, and the two are quoted together or not at all"*). The
> `cosim` job's id and conclusion are quoted beside it and are **separately** stated,
> because a `cosim` green is evidence of nothing outside the classes it drove (SC-6).

> **SC-4 — LINE-RATE STRESS, WITH ZERO BACKPRESSURE ASSERTED.**
> The back-to-back minimum-frame stress is green at the sign-off SHA: consecutive
> 64-octet frames at the minimum inter-frame gap, one 64-bit word per cycle, **zero rx
> backpressure asserted**, conservation held, with the frame count and the run id
> quoted. **The row that carries it and the rows whose pinned per-octet latency
> constants are the programme's only detector of a uniform word-delay regression are
> named together**, because `AP-M03` §7 bar 3 makes the second load-bearing in a way
> no other row's constants are.

> **SC-5 — MUTATION KILLS N/N, WITH EVERY NON-KILL COLUMN NAMED RATHER THAN FOLDED.**
> Every auditor-seeded mutation class in every campaign against this module is killed
> by the DV suite. **The era tally is reported in all five of its columns — sealed /
> killed / survived / green-by-blindness / void — and never collapsed into a ratio or
> a percentage.** Every class that is not a kill is named individually with its reason
> and its disposition, and every row that no campaign has qualified is named as such.
> **A qualification measures an instrument; it discharges no row and moves no count**
> (`J-dv_lead-0138`), and `QUALIFIED` is not a status (`J-dv_lead-0109`).

> **SC-6 — THE CHARTER §3 EXTERNAL ANCHOR, STATED PER CLASS AND NEVER PER MODULE.**
> The differential co-simulation against `verilog-ethernet` is reported **per stimulus
> class**: each anchored class at its `build` run id and `cosim` job id, with its
> *"does NOT anchor"* list **in the same cell**, and with the instrument that
> discharges the **absolute** half named separately from the instrument that discharges
> the **agreement** half. **The packet states, in terms, that the anchor is
> undischarged as a module-level anchor and why** — REQ-901's class list is unchanged
> and the lane's stimulus is what it is. **No sentence of the form *"the co-simulation
> anchors this module"* appears anywhere in the packet.**

> **SC-7 — THE BAR REGISTER IS RESTATED IN FULL AND HONOURED IN EVERY SENTENCE.**
> `AP-M03` §7's four bars are restated — bar 1 per **row**, bar 2 per **requirement**,
> bar 3 per **quantity (time)**, bar 4 per **quantity (strobes)** — with bar 2's
> permanence stated as a property of the frozen requirement rather than as a current
> state, and with bar 3's cross-side limb stated as **barred, not un-built**. **The
> packet contains no sentence any of the four forbids**, and it says which bar forbade
> each sentence it declined to write.

> **SC-8 — THE UNREACHABLE-INSTRUMENT REGISTER IS PUBLISHED.**
> Every landed, green assertion this module's coverage rests on that **no mutation can
> reach** is listed with what the plan may say about it — `AP-M03` §7's `U-1` … `U-5`
> and `DECLARATION WO-0074-D1` — and the packet states the consequence each carries:
> *a coverage claim counting such an assertion has counted one observation twice.*

> **SC-9 — OPEN DEFECTS.**
> Every open `BUG-` against this module is listed with its state, or the packet says
> **none** and the claim is measured over `agents/handoffs/BUG-*.md` at the sign-off
> SHA rather than recalled.

> **SC-10 — EVERY SET CLAIM CARRIES SHA, DOMAIN AND POLARITY.**
> §0.2's three-dimension rule holds over every count, every *"the only…"*, every
> *"no row…"*, every *"never"* and every threshold in the packet. **A count whose
> command cannot be quoted is described as a method with the reason it cannot be a
> one-liner, never quoted as a number without provenance.**

> **SC-11 — THE OWED LEDGER IS PAID, IN THE DECLARED ORDER, BEFORE THE SECTION THAT
> DEPENDS ON IT.**
> Every item whose **terminal** carrier is this round is paid in this round; every item
> whose carrier is elsewhere is listed with that carrier and its state. **`FINDING K-1`'s
> message repair is paid BEFORE the family-K rows of this packet are written**, not
> after (`RV-C4` §11). An owed item discovered by the round that needed it, rather than
> paid in the order §7 fixes, is a finding against this packet.

> **SC-12 — THE PROGRAMME'S FIRST LESSONS HARVEST IS COMPLETE.**
> `docs/gates/lessons-harvest-block.md` §3's block is instantiated in this packet with
> **every box checked**; my own harvest note in the signing journal entry states the
> span as an **entry-id interval**, enumerates the banked candidates **at their
> sources**, runs §2.1's classifier on each from the most general honest statement,
> discharges LH1/LH2/LH3 per candidate, records war stories with the criterion each
> failed, and declares a nil yield explicitly if that is the result. **The worker spans
> I commissioned are mined in the same note.** **No total is quoted that was not
> measured by walking the chain** (`J-dv_lead-0159` §9(b)).

> **SC-13 — EVIDENCE REPRODUCES AT THE SIGN-OFF SHA, AND THE JOURNAL ENTRY CARRIES IT.**
> Every command in the packet's evidence sections runs from a clean checkout at the
> sign-off SHA, or is an externally verifiable reference (a CI run id and its
> conclusion) marked as such; ephemeral artefacts are declared ephemeral
> (ADR-0003/F5). The accompanying journal entry carries the exact suite commands and
> observed results (charter §8). **A `PASS` whose evidence does not reproduce is a
> CRITICAL finding against me** and the packet says so in its own text.

> **SC-14 — THE VERDICT IS ONE TOKEN.**
> `PASS` or `FAIL`. **No third value, no "PASS with reservations", no "PASS subject
> to".** Everything the module has not earned is a listed bound inside a `PASS`, or it
> is a `FAIL`. A verdict that needs a qualifier in the same sentence is a `FAIL` whose
> author has not admitted it.

---

## 2. THE EVIDENCE MAP

**Every figure below is quoted with the entry that measured it and is marked
`RE-MEASURE` — this draft asserts none of them.** The executing round re-measures each
at the sign-off SHA per SC-10, and where a re-measurement differs, **the measurement
governs and the difference is a finding**.

### 2.0 Map at a glance

| criterion | primary instrument | evidence artefact | this draft's status |
|---|---|---|---|
| SC-1 | `AP-M03` row tables + `tools/dv_checks.sh` | §2.1 | `RE-MEASURE` |
| SC-2 | SPEC-M03 §10 ↔ `AP-M03` §6 coverage map | §2.1 | `RE-MEASURE` |
| SC-3 | CI `build` job | §2.1 | run id owed |
| SC-4 | family-L stress row + the pinned per-octet constants | §2.1 | `RE-MEASURE` |
| SC-5 | ten mutation campaigns | §2.2 | `RE-MEASURE` |
| SC-6 | differential co-sim, five classes | §2.3 | lift cells landed |
| SC-7 | `AP-M03` §7 bars 1–4 | §2.5 / §5 | restated, unmoved |
| SC-8 | `AP-M03` §7 `U-1` … `U-5` | §2.6 | listed |
| SC-9 | `agents/handoffs/BUG-*.md` | §2.7 | `RE-MEASURE` |
| SC-10 | §0.2's three-dimension rule | throughout | binding |
| SC-11 | §3's ledger | §3 | ordered at §7 |
| SC-12 | §4's harvest design | §4 | span open |
| SC-13 | the signing journal entry | §7 step 12 | owed |
| SC-14 | §8 | §8 | UNSET |

### 2.1 The bench era — the row census, and the five riders that ride with it

**The figure** (`RE-MEASURE`): **62 of 62 ASSERT rows discharged, outstanding set
EMPTY**, measured by a boundary-matched title census — 78 declared rows, 62
boundary-matched, minus `M03-A4` (a `NO-ASSERT` row named in a title) plus `M03-F5`
(an `ASSERT` row discharged by citation) — with `build` run **`31032021108`** beside
it, steps 6 and 8 `success`. Source: `WO-0072` §4, `J-dv_lead-0131`; unmoved through
the whole campaign era at `J-dv_lead-0138`, `-0143`, `-0148`, each re-measuring rather
than carrying. Inventory at the same measurement: **78 rows / 62 `ASSERT` / 7
`NO-ASSERT` / 4 `NO-STIMULUS` / 4 `STRUCTURAL` / 1 `GAP`**; suite inventory **59** M03
units / **139** repository-wide (**140** by the contaminated matcher — `FINDING M-4`,
unrepaired).

**Command**: `bash tools/dv_checks.sh`. **It must be re-run at the sign-off SHA**, and
per §7 step 3 the script itself changes in this round (RN-6), so the census is taken
**after** that change, not before.

**THE FIVE RIDERS — `WO-0072` §4, and they travel with the number wherever it goes:**

1. **It is not a `PASS` and does not open one.**
2. **It is a TITLE count, not a pass.** The pass is the run id; the two are quoted
   together or not at all.
3. **`M03-K3` is NOT discharged.** It stays `NO-ASSERT`; no title in any round names it.
4. **The row-level riders continue, all of them**: no packet may cite `M03-K1` as
   detecting a design that needs a second cycle to settle; `M03-K2`'s third kill is a
   monitor-precondition, not a design kill; the `frames_exempt` count is
   **bench-supplied** and is never evidence that a frame was driven; `~aborted:false`
   on a bad-FCS frame remains family D's landed call, copied unchanged
   (`OBSERVATION K-O1`).
5. **Neither pre-scan guard has ever fired on a real violation.** Both the `Enable`
   (X-6) and `Clear` (X-7) guards have their **entry** conditions mechanically
   witnessed and their **refusals** only argued. That is a standing fact about both
   guards and it belongs beside them, never inside a coverage claim.

**And one figure carried but not re-derived, whose carrier is this round**: the
**22-assertion breadth figure** of the family-J block, carried under `AP-M03` §0.1 with
its SHA and flagged at `J-dv_lead-0143` as *the one figure of that round not
re-derived*. **`RE-MEASURE` or drop.**

### 2.2 The mutation era — ten campaigns, five columns, and what the columns mean

**The figure** (`RE-MEASURE`): the class-based era closes at **63 sealed / 61 killed /
1 survived / 0 green-by-blindness / 1 void**, and **61 + 1 + 0 + 1 = 63**. Source:
`WO-0077-VERDICT` §14, `J-dv_lead-0147`; the ceiling of 61 was fixed **before** the
last campaign ran (`WO-0077` §14) and is reached exactly.

**The trajectory, so the arithmetic is checkable rather than trusted**: 41/40/1 →
49/47/1/1 (family M, `J-dv_lead-0137`) → 54/52/1/1 (family J, `J-dv_lead-0142`) →
**63/61/1/0/1** (family K/N, `J-dv_lead-0147`).

**Why the fourth and fifth columns exist, and why the packet may not fold them.** The
void column opened at `IC-M5` because *collapsing a never-rendered class into "killed"
would overstate coverage and into "survived" would libel a bench that was never given
anything to catch* (`J-dv_lead-0137`). The green-by-blindness column exists for the
same reason in the other direction. **A ratio destroys both.**

**The named non-kills, each of which the packet lists individually under SC-5:**

- **The single survivor**: `G-c4` (`FINDING G-1`).
- **The single void**: `IC-M5`, and the claim is the **narrow** one — unrenderable *at
  this design*, not inherently unrenderable.
- **`M03-J4`** — `NOT QUALIFIED` and **UNQUALIFIABLE BY SPECIFICATION**: §6.3 item 7
  and `C-14.5` leave the same-cycle case unconstrained, so every rendering is an
  equivalent mutant by specification. **A five-of-five family-J scorecard is therefore
  not full coverage of §4.J**, and the packet says so rather than letting the score
  imply it.
- **`M03-M8`, `M03-M9`** — unscoreable, unscored, surviving any outcome: no mutant
  exists and none is expressible. **A full family-M scorecard is not full coverage of
  §4.M.**
- **`M03-B3` and `M03-N2`'s six sub-cases** — green **by structural unreachability**
  under `DECLARATION WO-0074-D1`, and **never** countable as coverage of §9's ruling 9.
- **`M03-K3`** — `NO-ASSERT`, not scoreable, declared rather than omitted.

**The era's own two largest findings, both mine, both against my own artefacts, both
of which the packet carries rather than buries:**

- **`FINDING K-1` (MAJOR)** — the pre-committed disposition table asks the adjudicator
  to tell three defect classes apart from what a scorecard prints, and at `M03-K2` four
  classes produced not one identical message but one **byte-identical promoted file**
  (blob `373f32a` under `IC-K1`, `IC-K3`, `IC-K5`, `IC-K6`). §3 pays it.
- **`FINDING WO-0077-A1` (MAJOR)** — a blindness declaration grounded in a
  bench-scoped census, refuted by the co-simulation lane convicting two classes the
  seal predicted it could not see. **Its positive half belongs in this packet's anchor
  accounting BESIDE the bar that says the anchor is undischarged, never in place of
  it**: the lane is blind to seven of nine and **sighted for exactly the two whose
  defect lands on a start character sitting on a reset-release cycle** — a placement
  the M03 bench does not contain at all. **It does not discharge the anchor.**

### 2.3 The differential co-simulation anchor — five classes, at run and job ids

**Source: `AP-M03` §7's lift cells, landed `J-dv_lead-0159`.** The packet lifts these
**verbatim, with each cell's *"does NOT anchor"* list in the same cell**. Reproduced
here in skeleton so the executing round knows what it is lifting and does not re-derive
it; **the plan's cells govern**, and case number and class number are **off by one**
(case 0 drove class 1, C1 class 2, C2 class 3, C3 class 4, C4 class 5).

| class | stimulus | anchored at | absolute half | agreement half |
|---|---|---|---|---|
| **1** | one 64-octet good-FCS frame, lane-0 start on the reset-release cycle | `30988038809` / `92247281222` — **lifted at Phase 1, NOT re-lifted** | `M03-A1` | this lane at case 0 |
| **2** | the same 64 octets, **lane-4** start | `31096150983` / `92598555141`; five byte-identical observations | `M03-A2` (+`M03-A3`, `M03-A5`) | this lane at C1 |
| **3** | **two** good-FCS frames at the minimum inter-frame gap, across the re-arm path | `31103977231` / `92624287637` | `M03-L1` (+`M03-D3`) — **a superset and a neighbour, not a twin** | this lane at C2 |
| **4** | one 64-octet **bad-FCS** frame, delivered rather than dropped | `31108528759` / `92639903296` | `M03-D1` (+`M03-D2`) | this lane at C3 |
| **5** | one 64-octet good-FCS frame with **nonstandard preamble + SFD data** (`A1…A7`), accepted rather than rejected | `31431123022` / `93594520735` — **one observation, and the cell says so** | `M03-B1` | this lane at C4 |

**The structure the cells enforce, and it is `FINDING RV-0078-S2-2`'s shape**: each
cell names **which instrument discharges the ABSOLUTE half** (a bench row asserting
figures at the receiver) and **which discharges the AGREEMENT half** (this lane, which
asserts that two independent implementations produced the same four REQ-901 observables
and asserts **no figure of its own**). **α never stands for both.** For REQ-104 the
measured fact **is the pair** — this lane's `tuser`[0] agreement together with
`M03-D1`'s absolute assertion — **and it is written as a pair or not at all.**

**What the four lifts change today, measured rather than assumed**: bar 1 gates a row
**iff** its expected values come from X-1(ii)'s computed outcome model; **no benched
row does** (re-measured at `e51ca52`, `J-dv_lead-0159`, over **both** producers, by
five commands recorded at `AP-M03` §7). **So the lifts discharge a condition that gates
no row at that tree.** Their value is prospective and formal. **A lift that changes no
row's status is still a lift, and saying so is what stops it being read as more.**

**`RE-MEASURE` obligation, and it is dated**: that set claim goes stale *"the moment a
row takes an expected value from X-1(ii) — which a fuzz campaign would do on its first
day"* (`J-dv_lead-0159` Open-question 2). The executing round re-measures it, and
**states the evidence in its MECHANISM form, never in its mention-count form**
(`FINDING ECS-6`).

### 2.4 The per-class error table — seventeen classes over families E–H

**Source: `RV-SWEEP` §2.3 (`WO-0078` §14), `J-dv_lead-0160`.** The packet lifts the
table **whole**, and lifts it **from the sweep, never from `AP-M03` §4.F's family
note** (`FINDING ECS-1`).

**The unit is the class**, defined by the axes REQ-901's own exclusions are written in
— the character that closes the frame, the delivered extent, the frame's length band.
**A family is not the unit** (`AP-M03` §7 convicted that once) and **a row is not the
unit** (22 rows, nine repetitions). Seventeen classes; **every one of the 22 rows of
§4.E–§4.H lands in exactly one, none unassigned, none twice.**

**The tally the packet states** (`RE-MEASURE` against the table, which governs):
**five INSIDE a declared divergence class** (F-1, F-2, F-3 inside (e); G-1, G-2 inside
(f)); **twelve OUTSIDE every declared class**; **nine UNREACHABLE at the comparison
today** — four on the capture bound (all of G), five on admission (all of H);
**exactly one anchored today**, F-4, and it is anchored because it is the clean
64-octet frame case 0 and C1 already drove.

**The sentence the table licenses**, and the packet writes this one:
> *"Of the seventeen error classes families E–H assert, five are inside a declared
> REQ-901 divergence class, twelve are outside every declared class, and nine cannot be
> presented to the comparison at this tree."*

**The sentence it does not license**, and the packet writes no form of it:
> ~~*"the co-simulation covers family E"*~~ — no class in the table is anchored except
> F-4.

**Two corrections the packet must carry, not lift around:**

- **`FINDING ECS-1`** — `AP-M03` §4.F's family note places `M03-F5` among frames
  *"below five octets"*; **F5's frame is FIVE octets**, which is inside (e)'s 5-to-63
  band where the exclusion is `tuser`[0] **alone** and the delivered octet and the
  `tkeep` extent stay **inside** the comparison domain. **The packet writes F-1's
  disposition from the sweep's table, citing the sweep and not the note.** A lift of
  the stale bullet without the repair is a finding whose class is **NOT MINOR**.
- **`FINDING ECS-2`** — `MAX_WORDS_PER_FRAME = 16` bounds reference-side capture at
  128 delivered octets, i.e. frames to **132 octets** DA through FCS
  (`ceil((n−4)/8) ≤ 16 ⟺ n ≤ 132`). **The lane's reachable window is 64 ≤ n ≤ 132.**
  REQ-901 says classes (e) and (f) *"exclude nothing in the 64-to-1518-octet range,
  which is where this boundary still anchors"* — **and the instrument reaches one
  twelfth of it** (the legal maximum-length frame needs 190 output words). **The
  reachable-window sentence ACCOMPANIES every citation of REQ-901's 64-to-1518 range
  in this packet.** The bound is **one-sided**: our side carries no per-frame bound, so
  an overflow reddens one producer through a refusal sentinel rather than the
  comparison.

### 2.5 REQ-901's bars, as they stand

Restated in full at §5, which is where the packet's own prohibitions live. **Summary
of movement since they were written: bar 4's precondition (1) became MET for
`error_bad_fcs` and for no other strobe (`J-dv_lead-0159`), which is movement inside a
standing refusal and is NOT a lift. Bars 1, 2 and 3 are unmoved.**

### 2.6 The unreachable-instrument register (SC-8)

| # | kind | instrument | what the packet may say |
|---|---|---|---|
| **U-1** | bench-side, sibling ordering | `M03-L4`'s sequence read-back | qualified by citation to `M03-L1`'s pairing **or not at all**; a green there is evidence the sibling ran |
| **U-2** | bench-side, sibling ordering | `M03-L3`'s whole-run ΔC and `Latency.errors` | its ΔC content is discharged by a derivation about the specification and **by no run** |
| **U-3** | design-side, report grammar | `M03-B3` and `M03-N2`'s six sub-cases against ruling 9 | **never** coverage of ruling 9; that coverage is the three epoch-A closures alone |
| **U-4** | shape of the observable | `M03-J1`'s silence scan | its green **cannot** say frames were not admitted; the separating instrument is `M03-J3`'s positive comparison |
| **U-5** | placement of the stimulus | `M03-K1`'s window | convictable only by a defect that **carries** an observable into the window, never by one that fails to suppress |

**The portable form the packet carries with them**: *an assertion whose subject is
already compared, positionally and earlier, by a sibling assertion in the same unit is
unreachable, and its greenness is evidence about the sibling* — **a coverage claim
counting both has counted one observation twice.**

**And `U-1`/`U-2`'s open question, whose carrier is this round: §3 item 9.**

### 2.7 Open defects (SC-9)

`BUG-0001`, `BUG-0002`, `BUG-0003` exist in `agents/handoffs/`. **`RE-MEASURE`**: the
executing round reads each packet's `Fix verdict` field at the sign-off SHA and lists
state per bug. **The claim "none open" is measured over the directory, never recalled.**

---

## 3. THE OWED LEDGER — what pays AT this packet, and the plan for each

**Twelve items whose terminal or fallback carrier is this round, plus the standing set
that is carried with its carrier named.** Ordering is §7's; this section states *what*
each is and *how* it is paid.

| # | item | class | carrier status | pays how |
|---|---|---|---|---|
| **1** | `FINDING K-1` — message repair | MAJOR | **TERMINAL, this round; BEFORE the family-K rows** | §3.1 |
| **2** | `RN-6` — `docs/**` resolve-check in `tools/` | errata → mechanised | first commit opening `tools/` after the campaign scored = this round | §3.2 |
| **3** | `FINDING RV-0078-S2-2` — per-class absolute/agreement accounting | MINOR | this round | §3.3 |
| **4** | `FINDING RV-0078-S2-7` — residue statement | MINOR (closed at its limb) | this round | §3.4 |
| **5** | `FINDING RV-0078-S2-11` — binding rule | MINOR | binding **now**; repair's carrier conditional | §3.5 |
| **6** | criterion 3's unexercised plural property | harness criterion | this round records it | §3.6 |
| **7** | `FINDING WO-0077-A1` — census-repair ownership | MAJOR | *"the next campaign seal and, if none is drafted, the `SO-` round's own accounting"* — **none is drafted** | §3.7 |
| **8** | `FINDING ECS-1` — corrected F-1 disposition | MATERIAL | this round (disposition); note's repair rides the next `AP-` opener | §2.4 |
| **9** | `FINDING ECS-2` — reachable-window sentence | MATERIAL | this round, **beside every 64-to-1518 citation** | §2.4 |
| **10** | `U-1`/`U-2` pricing | standing | *"a question for the round that opens `test_m03_l.ml` or for the `SO-`"* | §3.8 |
| **11** | the 22-assertion breadth figure | figure carried unre-derived | this round | §2.1 |
| **12** | the programme's first lessons harvest | gate precondition | this round | §4 |

### 3.0 EXECUTION RECORD — round 1, §7.1 steps 1–5 (`J-dv_lead-0163`, base `4e7331b`)

**Four of the twelve are PAID. The other eight are untouched and stay owed.** Nothing
below adjudicates a criterion; each is a carrier discharged in the order §7.1 fixes.

| # | item | state after round 1 | where |
|---|---|---|---|
| **1** | `FINDING K-1` — message repair | **PAID**, step 2 | `test/xgmii_rx_64/test_m03_k.ml` — the expected list is bound once and read by both the comparison and the message, and the message now prints the **observed** list beside it. Verdict, condition and `M03-K2`'s `ASSERT` status unchanged |
| **2** | `RN-6` — `docs/**` resolve-check | **PAID**, step 3 | `tools/dv_checks.sh` — a gating check over every `docs/**` path cited in `agents/handoffs/**/*.md`, with a self-test, a declared-errata table and a staleness guard. §3.2's ordering consequence stands: **every SC-1 and SC-10 census quote is taken with THIS script**, at step 6 |
| **5** | `FINDING RV-0078-S2-11` — the repair | **RULED and EXECUTED**, step 4 | §3.5's `RULED` block below — the comparator was opened |
| **10** | `U-1`/`U-2` pricing | **ANSWERED**, step 5 | §3.8's `RULED` block below — refused, with a bound and a three-trigger expiry |
| 3, 4, 6, 7, 8, 9, 11, 12 | — | **OWED, unchanged** | round 2, §7.1 steps 6–12 |

**AND ONE FINDING AGAINST THIS PACKET'S OWN §3.9, raised by the round that needed the
answer.** §3.9 lists `FINDING RV-0075-1` (T1's printer) in the standing set with
carrier *"the next commit opening `test/cosim/**`"*. **It is CLOSED**, and was closed
before this document was drafted: `WO-0078` §5.1 absorbed it into **Stage 1**, the
repair is landed in `test/cosim/canonical.ml`'s `timing_report_to_string` — which
cites it by name, extended by `FINDING RV-0078-S1-2` limb (b) — and the Stage-1
verdict records it **CLOSED** (`J-dv_lead-0155` era, `WO-0078` Return log). Carrying it
as standing mispriced step 4: opening the comparator looked as though it would fire a
second carrier, and it fires none. **`FINDING RV-0075-2` is closed only *for the class
it named*** and its residual limb is a separate question; §3.9 is **RE-MEASURE at step
9**, not corrected here, because rewriting a standing set from one spot-check is the
defect this packet convicts elsewhere.

#### 3.0.1 EXECUTION RECORD — round 1R: the round-1 payment reddened CI, and the red was RIGHT (`J-dv_lead-0164`, base `ee3da9c`)

**Not a step of §7.1. A repair round, opened by the runner's verdict on ledger item 2.**
`RN-6`'s check reached a runner for the first time at `build` run **`31442295998`**,
step *"DV mechanical checks"*, and **FAILED**: **4 UNDECLARED broken citations**, all
four citing `docs/reports/latency/` — **this packet**, `WO-0003_testability-findings.md`,
`WO-0015_batch-d-countersign.md`, `WO-0018_batch-de-countersign.md`. The same command
at the same commit in the development container reported **0**. Both numbers were true
about the tree they measured; only one was true about the **artefact**.

**Two findings, both against me, and both paid here.**

| id | finding | disposition |
|---|---|---|
| **`FINDING RN-6-CI-1`** | **The catch is a TRUE POSITIVE.** `docs/reports/latency/` existed in the container as an **empty, untracked** directory (`git ls-files docs/reports/latency` → **0** entries). Git cannot track an empty directory, so the path is absent from **every fresh clone**, and the four citations were broken for every reader who was not sitting in that one container | **ONE TRACKED FILE, NOT FOUR ERRATA** — `docs/reports/latency/README.md`. §3.2's ruling |
| **`FINDING RN-6-CI-2`** | **The instrument resolved against the FILESYSTEM where the honest test is the TRACKED TREE.** A `-e` test answers a question about the machine the check runs on; the thing the check governs is committed text. **Same species as this programme's circular-pin lesson**: a check that measures the environment it runs in rather than the artefact it governs can be green for a reason that ships with nothing — and its symptom is never a wrong answer, it is a **local/CI divergence** that stays invisible until the day the two environments differ | **RESOLVER REBUILT ON `git ls-files`.** §3.2's `REPAIRED` block |

**Consequence for `SC-13`, stated because it is a criterion this packet is graded by.**
SC-13 requires every command in the evidence sections to run **from a clean checkout at
the sign-off SHA**. Run `31442295998` is the proof that `tools/dv_checks.sh` did *not*
satisfy that at the round-1 SHA: the local answer and the runner answer differed by
four. It does now, and §3.2 records **how that was verified rather than asserted** — a
fresh checkout was constructed and the check was run inside it.

**This packet's own citation is REPAIRED, not dispositioned, and the distinction is
`SC-10`'s.** The `SO-` is one of the four citers. An erratum would have recorded its
citation of `docs/reports/latency/` as **permanently broken** inside the same document
that demands every set claim carry provenance — a sign-off packet shipping a
declared-broken citation of its own. It resolves instead, against the tracked tree, at
the commit that carries this round.

**Ledger state unchanged: items 3, 4, 6, 7, 8, 9, 11 and 12 remain OWED to round 2.**
No criterion of §1 is adjudicated here, no bar lifted, no count asserted, no anchor
claimed, no harvest taken. **State stays DRAFT and §8 stays UNSET.**

### 3.1 `FINDING K-1` — the repair, and why its position in the round is load-bearing

**The defect**: `WO-0072` §9 fixes three *distinct* dispositions (D1, D2, D3) with three
*distinct* `BUG-` citations and three different tells — but all three move which cycles
carry a delivered word, so all three raise the unit's **first** DUT-observable
assertion, the whole run's delivered-cycle list, **and that assertion's message names
the expected list and does not report the observed one**. `test_m03_k.ml:468` names its
expected list `[4;5;14;15;16;17;18;19;20;21]` and prints nothing it saw. Measured under
run: four classes produced one **byte-identical promoted file** (blob `373f32a`).

**The ruling that fixes its carrier** (`J-orchestrator-0225` ruling 2, re-affirmed at
`RV-C4` §11): *the repair rides the `SO-` round, because the `SO-` owns the next commit
that opens `test_m03_k.ml` and the carrier rule names the next opener, not a
manufactured one.* **This round is K-1's TERMINAL carrier: there is no further deferral
available, and if this round does not pay it, that is a finding.**

**The repair**: print the **observed** delivered-cycle list beside the expected one, as
`M03-N4`'s own equivalent assertion already does. **Comment-free behaviour change: none
— the assertion's verdict is unchanged; only its message gains the relatum.**

**Why it pays first (§7 step 2, before step 8):** *the whole point of the repair is
that the reader writing the family-K rows can see what the assertion observed.* A
packet that writes family-K's coverage rows and *then* repairs the message has written
those rows against the defect the repair exists to remove.

**And the constraint on the payment**: the repair changes `test/**`, so the suite must
be **re-run after it** and the run id quoted at SC-3 must be **that** run — not an
earlier green.

### 3.2 `RN-6` — the resolve-check, and why it is a tool and not a third note

**The fact**: `WO-0077` §9 item 4 admitted `docs/adr/ADR-0014.md`; the file is
`docs/adr/ADR-0014-an-enable-gates-admission-not-the-wire.md`. **The same broken path
was ruled once at `WO-0076` and then copied forward into the very next packet I
drafted** — *"a second occurrence converts the disposition from clerical into an
obligation to mechanise, because the third occurrence would be a habit with two rulings
behind it."*

**The durable carrier, by ruling**: a resolve-check in `tools/dv_checks.sh` — at
minimum, **every `docs/**` path cited in `agents/handoffs/**` resolves at the tree, and
a citation that does not is reported by the same command whose output is already this
programme's census provenance.** Owed to *"the FIRST commit that opens `tools/` after
this campaign scores — in practice the `SO-` round's own accounting, which re-runs that
script anyway."*

**Consequence for this round's ordering, and it is not cosmetic**: the script changes,
so **every census SC-1 and SC-10 quote is taken with the CHANGED script**, at §7 step 6,
after step 3. Taking the census first and patching the tool afterwards would quote a
figure from a tool that no longer exists at the sign-off SHA.

**Expect the check to report failures on first run.** They are data, not a blocker: the
packet records what it found, and each unresolved citation is dispositioned (repair in
scope, or a finding with a carrier). **A check whose first run is green tells you
nothing about the check** — `FINDING K-3`'s rule, applied to its author's own new bar.

#### 3.2.1 REPAIRED at round 1R — the first CI run caught something real, through an instrument that was itself wrong

The paragraph above expected failures on first run and got four. **It did not expect the
instrument to be wrong at the same time, and it was.** Run `31442295998`; §3.0.1 states
the two findings; this block states the repair, the four dispositions and the evidence.

**(1) THE RESOLVER REPAIR — the citation resolver measures the TRACKED TREE.**

The resolver no longer asks the filesystem anything. Its universe is what **git can
carry in a commit**, built in two forms, and every classification — exact path,
directory, unique-id prefix, ambiguous prefix — is a pure function over that list:

| universe | built from | used for |
|---|---|---|
| **TRACKED** | `git ls-files --cached` | in a clean tree this **is** HEAD's tree, which is exactly what a fresh checkout materialises — so this half reproduces the runner's answer from any machine |
| **COMMITTABLE** | TRACKED + `git ls-files --others --exclude-standard` | what the check **gates on**, because a round that repairs a citation writes the target file *before* the orchestrator commits it, and gating on TRACKED alone would redden every repair round for having done the repair |

**Neither universe can contain an empty directory** — `--cached` lists blobs,
`--others` lists files. **The defect that reddened `31442295998` is no longer
expressible, in either environment, by construction.** A directory citation resolves
iff something git carries lives under it, which is precisely the condition under which
a checkout creates that directory. The **citing** side is enumerated from git too, so a
stray or ignored `.md` in `agents/handoffs/` cannot inject a citation CI will never see.

**The residual gap is printed rather than papered over.** A citation resolving *only*
through the COMMITTABLE half is reported `PENDING-COMMIT` with its path: it resolves on
the runner **iff** that path is in the round's commit. It is a notice, not a failure —
but it is **computed every run**, so unlike a declared exception it cannot rot, and it
names the one remaining way a local green can differ from a runner green.

**(2) THE FOUR DISPOSITIONS — one tracked file, zero errata.**

All four citations name the **space**, not a document: a write-scope directory
`PROTOCOL` §6 and charter §1 both name, which had no tracked content and therefore no
existence in any clone. **None is the `RN-6` defect** (a pointer to a document living
under another name), so none is an erratum of that class.

| citer | what it cites the space for | disposition |
|---|---|---|
| `agents/handoffs/WO-0003_testability-findings.md` | REQ-806's split of duties — dv produces and commits the numbers here, the architect transcribes them | **RESOLVES** |
| `agents/handoffs/WO-0015_batch-d-countersign.md` | carry-forward **C-23**'s gate: *before any `docs/reports/latency/` artifact quotes* REQ-502's figure | **RESOLVES** |
| `agents/handoffs/WO-0018_batch-de-countersign.md` | carry-forward **C-24**, C-23's sequel, same gate | **RESOLVES** |
| `agents/handoffs/SO-xgmii_rx_64.md` (**this packet**) | §7.1's write scope; §7.2's `P1-phase-accept` ladder | **RESOLVES** |

All four are made to resolve **truthfully** by one committed file,
`docs/reports/latency/README.md`, which states the space's purpose, its owner, that
**no latency report has yet been written**, and where latency figures live today: the
REQ-005 per-octet constancy asserted inside the **REQ-004 line-rate stress rows**
(`AP-M03` §4.L — `M03-L2`, `M03-L3`, `M03-L5`) and the REQ-019 ΔC arithmetic done on the
specifications at `P1-spec-freeze`. **REQ-006's end-to-end budget is a different
quantity and no bench has produced it.** The README lists the four citers' obligations
so the first report's author inherits them, and **quotes no latency figure at all** —
C-23 and C-24 gate on the first artefact there that quotes REQ-502's number, and a
README quoting one would discharge neither and trip both.

**Why not four errata**, since the errata table exists and would have been cheaper: an
erratum declares a citation *permanently broken by ruling*, and this one is **repairable
by a file inside my own write scope**. Worse, it would rot on a schedule already fixed —
`P1-phase-accept` requires a latency report **committed under this exact path**, so the
moment that report lands, four declared errata stop firing and this same check reddens
on **staleness**. A disposition whose expiry is already on the gate ladder is not a
disposition. And the fourth citer is this packet, whose `SC-10` forbids exactly that.

**(3) THE PROVENANCE, UPDATED WITH THE COUNTS IT PRINTS.** The census block now prints
the universe it measured — tracked-path count, uncommitted-path count — above the
citation counts, plus a `PENDING-COMMIT` line and a closing sentence stating whether
this run's counts *are* a fresh clone's counts or are conditional on the commit. **Every
`SC-1`/`SC-10` census quote at step 6 is taken from THIS script**, unchanged in that
ordering.

**(4) EVIDENCE — the local/CI divergence closed, verified rather than asserted.**

Counts are quoted in the block's own printed order — *total / OK / GLOB / PREFIX /
errata / UNDECLARED-BROKEN / STALE*.

| # | what was run | result |
|---|---|---|
| 1 | repaired check, **locally, on the tree exactly as `31442295998` saw it** | **302 / 289 / 0 / 5 / 4 / 4 / 0** — *character-for-character the counts that run printed.* The divergence is closed at its source: the same command now gives the runner's answer inside the container |
| 2 | repaired check, locally, at this round's final content | **304 / 295 / 0 / 5 / 4 / 0 / 0**, exit 0, **6 `PENDING-COMMIT`**, each naming `docs/reports/latency/README.md` as its condition |
| 3 | **a fresh checkout, constructed**: `git archive HEAD \| tar -x` (which contains **no `docs/reports/latency/` at all** — the root cause, shown rather than argued), this round's three payments applied and made tracked, check re-run inside it | **304 / 295 / 0 / 5 / 4 / 0 / 0**, exit 0, **0 `PENDING-COMMIT`** — *citation counts identical to run 2* |
| 4 | **NEGCTL C** — the CI condition rebuilt at that same content: README removed from git **and** from disk, the empty directory left present on disk | **6 UNDECLARED BROKEN**, FAILED. The repaired instrument still catches the true positive, in the exact shape the runner saw it, and is **not** fooled by the directory being on disk |
| 5 | **NEGCTL A** — one declared erratum entry deleted | 3 errata, **1 UNDECLARED BROKEN**, FAILED |
| 6 | **NEGCTL B** — a declared key that can never fire | **1 STALE ERRATUM**, FAILED |
| 7 | self-test | **21 assertions**, in two halves. The second half runs in a **throwaway git repository**: the empty directory is built on disk, a filesystem resolver is *shown* to answer "exists" for it, and the check is then required to answer MISSING — a control that fails the moment anybody reintroduces a `-e` |
| 8 | `bash -n tools/dv_checks.sh`; `shellcheck tools/dv_checks.sh` | clean; **exit 0**, matching the file's pre-round baseline |

**The `+2` between run 1's total and run 2's is this round's own text** and is stated
rather than left as drift: §3.0.1 and §3.2.1 introduce two new `docs/**` citations,
`docs/reports/latency` and `docs/reports/latency/README.md`, **both of which resolve**.
The 302 in run 1 is the figure comparable to `31442295998`; **304 is the figure at the
sign-off SHA**, and step 6's census quotes are taken there, not here.

Runs 2 and 3 answer *"does a local run now report what a fresh checkout reports"* — they
agree — and run 4 is the proof that the agreement is not vacuous. Run 3 is also the
form `SC-13` asks for: a command executed from a checkout rather than from a container.

### 3.3 `FINDING RV-0078-S2-2` — the per-class absolute/agreement accounting

**The defect**: this lane checks **agreement**; the CD's instances state **absolute**
values; nothing in the lane compares our side to them. **A common-mode error satisfies
branch α and violates the instance.**

**The payment**: the packet states, **per class**, which instrument discharges the
absolute half (the X-1 bench family) and which discharges the agreement half (this
lane), **and does not let α stand in for both.** `AP-M03` §7's lift cells were written
in exactly this shape so the packet can lift them **without repair** — but the cells'
shape **does not re-home the finding**; its carrier is this round and the packet is
where it is discharged, not where it is quoted.

**Two honesty riders lifted with it**: class 3's absolute half is covered by **a
superset and a neighbour, not a twin** (`M03-L1` runs 10 000 frames and alternates
lanes; `M03-D3`'s minimum-gap pairs each carry a bad-FCS member), and class 5's decision
half rests on a **printed line** read against a grammar invariant, **not on a second
instrument**.

### 3.4 `FINDING RV-0078-S2-7` — the residue statement

The finding is **CLOSED at the limb it repairs**, on production evidence (`RV-C3ALPHA`
§5). **What is owed here is the residue**: the repaired no-result branch's own
correctness rests on a harness property **CI has never executed** — the property
criterion 3 protects, *a red case does not cost a LATER case its line*, has never been
demonstrated because the failing case was last in the array both times. **The packet
states the residue as a residue**: a closure whose re-arm condition is named, not a
discharge.

### 3.5 `FINDING RV-0078-S2-11` — the binding rule, which binds now

**The defect**: the clean-path comparison record is **relational, never absolute** —
`canonical.ml:447–451` prints `frames compared` / `frames matching` / `divergences:
none` and **never prints an agreed value**. C3 is the first case whose interesting fact
is a **value** (REQ-104's `tuser`[0] = 1), and for it the record establishes equality
without establishing what was equal.

**The rule, binding immediately and without waiting for a repair, and the packet obeys
it in its own text:**
> **No document may state a co-simulated value that the log does not print; a value
> established by pairing this lane's agreement with another instrument's assertion is
> written as the pair, with both cited.**

**Carrier of the repair**: *the next round that opens `test/cosim/compare.ml` or
`canonical.ml` — and if none opens before the `SO-`, the `SO-` round, which will need
exactly this value to write REQ-104's row honestly.* **Decision owed at §7 step 4**:
either the round opens the comparator and prints the agreed decision and `tuser`[0] on
the clean path, or it writes REQ-104's row **as the pair** and says which instrument
supplies the relatum. **Both are lawful; silently doing the second while wording it
like the first is not.**

> **RULED, step 4 (`J-dv_lead-0163`): THE COMPARATOR IS OPENED. The first limb.**
>
> `test/cosim/canonical.ml` + `.mli`: `compare_transactions` now carries an `agreed`
> field and `report_to_string` prints, **on the passing path**, the values REQ-901's
> comparison found equal — per frame the agreed decision, per word the agreed `tkeep`,
> `tlast`, **`tuser0`** and octets. This is `LH-cand-I` applied to its own author:
> *where the interesting fact is a value rather than a relation, print the agreed value
> on the passing path.*
>
> **Three properties of the repair, each chosen against a defect this programme has
> already paid for, and each checkable in the diff:**
>
> 1. **`cycle` is absent from the agreed record, deliberately.** `WO-0075` §4 bars a
>    cross-side cycle comparison as the quantity REQ-901's closing sentence excludes by
>    name, so `compare_words` never reads it — and **a quantity that was not compared may
>    not appear inside a record of what was agreed**, where a reader would take it for
>    one. That is why `agreed_word` is a type of its own and not a `word list`. **Bar 3
>    is untouched and this repair does not approach it.**
> 2. **The block prints PER FRAME and is never gated on the transaction's divergence
>    list.** Gating a per-frame print on the whole transaction is exactly
>    `FINDING RV-0078-S1-2` limb (b)'s defect in the sibling printer — unreachable at a
>    one-frame case, reachable from the first multi-frame case on. It is not
>    reintroduced.
> 3. **`agreed` is accumulated in the same branch, off the same predicate, that
>    increments `frames_matching`**, so the count and the values cannot drift; and it is
>    taken from *ours*, which **is** *theirs* on every compared field by that predicate.
>
> **WHAT THIS DOES NOT DO, and the packet obeys all four.** It is **not a lift** (§5.1
> item 4): no row's status, no coverage-map line and no discharge count moves. It
> creates **no anchored class**. It makes this lane assert **no figure of its own** —
> the absolute half of any claim about these values is still discharged by an X-1 bench
> row asserting them at the receiver and never by this block (`FINDING RV-0078-S2-2`).
> And it **does not retroactively improve the landed logs**: the five lift runs were
> produced by the old printer and are not re-run, so **the agreed value becomes
> quotable only from step 7's own `cosim` job at the sign-off SHA**, and a
> re-observation there is **not a lift and renews none** (§5.1 item 5).
>
> **Consequence for §2.3's REQ-104 row at step 8, stated now so the row cannot be
> written loosely later**: the row may cite the printed agreed `tuser`[0] **only** at
> step 7's own run and job ids, quoted together; if that job does not produce the line,
> **the row falls back to the pair form** — this lane's agreement together with
> `M03-D1`'s absolute assertion, both cited. §5.5 binds either way.

### 3.6 Criterion 3's unexercised plural property

`WO-0078` §12 criterion 3 — *every case reaches a verdict or names why not* — is
**partially discharged and twice deferred**: the property it protects has never been
demonstrated, because the case that reached no verdict was **last in the array** on both
occasions. **The closing condition, unchanged**: the first landing in which a case that
does not reach a clean verdict is followed by another case in the array.

**What the packet does with it**: records it as an **unexercised aggregate-continuation
path** in a sign-off, states that no Stage-2 case is not-clean so it never fired, and
**routes the acceptability question to the auditor rather than answering it with my own
charitable reading** (`J-dv_lead-0159` Open-question 1, unanswered). **It is not
self-adjudicated in the packet that benefits from the answer.**

### 3.7 `FINDING WO-0077-A1` — the census repair's ownership

**The standing rule, filed at `AP-M03` §7**:
> **Any universal quantified over "the bench" in a seal, a campaign packet or an `SO-`
> is measured over EVERY PRODUCER that drives the DUT — `test/cosim/` included — or it
> is quoted with the producer set it was measured over.**

**Its own text names this round as the fallback owner**: *owed to the next campaign
seal and, if none is drafted, to the `SO-` round's own accounting.* **No campaign seal
is drafted and none is scheduled — the class-based era closed at `WO-0077`.** So
**ownership lands here**, and the payment is not a sentence quoting the rule: it is the
rule **applied to this packet's own universals**, with the producer set named on each
(SC-10). The packet says explicitly that it is the rule's owner and that no later
artefact inherits the obligation by default.

### 3.8 `U-1` / `U-2` pricing

`AP-M03` §7 records that neither is blocked on machinery — what `U-1` needs is a unit
whose sequence check is **not preceded** by a positional octet comparison of the same
octets, and what `U-2` needs is a latency-record assertion **not preceded** by per-class
records that fix its operands — *"both of them changes to assertion ordering or stimulus
separation, not new capability"* — and that **whether either is worth a unit of its own
is a question for the round that opens `test_m03_l.ml` or for the `SO-`.** No bench
change was owed by the campaign that measured them.

**This round answers the question rather than passing it on**, in one of exactly two
forms: **(a) commissioned** — a `WO-` drafted for the ordering change, with its cost;
or **(b) refused with a stated reason and a bound** — the two rows keep their `U-`
dispositions, no packet may count both assertions as two observations, and the refusal
carries an expiry condition. **`LH-cand-K`'s own rule applies to me here: a repeated
"not yet" with no condition attached becomes a permanent "no" that nobody decided.**

> **RULED, step 5 (`J-dv_lead-0163`): FORM (b) — REFUSED, PRICED, BOUNDED, AND WITH AN
> EXPIRY THAT IS NOT A DATE.**
>
> **The price, stated so the refusal is checkable rather than merely asserted.** Neither
> is blocked on machinery; both are assertion-ordering or stimulus-separation changes.
> The bench half is small — a `WO-` to tb_writer for two units, one whose sequence
> read-back is **not preceded** by a positional octet comparison of the same octets, one
> whose latency-record assertion is **not preceded** by the per-class records that fix
> its operands — call it one bench round: one worker spawn, one `RV-`, one landing.
> **The bench half is not the price.**
>
> **The price is the campaign, and it is what decides this.** The value of the change is
> that the two assertions become **reachable by mutation**. Reachability is a
> **measurement**, and the only instrument that takes it is a seeded campaign. **The
> class-based campaign era CLOSED at `WO-0077`; no seal is drafted and none is
> scheduled** (§3.7 measures this and owns it). So a unit landed now would arrive
> **unqualified**, and the packet's claim would move from
>
> - *"this assertion is unreachable, MEASURED under five classes"* — which is what
>   `U-1`'s own cell records today — to
> - *"this assertion should now be reachable, DERIVED from an ordering argument."*
>
> **That is a worse position for a sign-off, not a better one**, and it is the exact
> trade this programme convicts elsewhere: `FINDING K-3`'s rule that a bar unmeasured
> against its own tree is a hope, and `LH-cand-J`'s that reproduction earns confidence
> and never jurisdiction. **A published, measured blindness is more useful to a reader
> than an unmeasured repair** — which is why `SC-8` publishes the register instead of
> emptying it.
>
> **THE BOUND, which rides with the refusal and is not softened by it.** `U-1` and `U-2`
> keep their dispositions exactly as `AP-M03` §7 states them, and §5.7 carries them as
> prohibitions: **`M03-L4` is qualified by citation to `M03-L1`'s pairing or not at
> all**; **`M03-L3`'s ΔC content is discharged by `WO-0070` §6's derivation — a statement
> about the specification — and by no run**; and **no packet, campaign or scorecard may
> count a `U-`-marked assertion and its preceding sibling as two observations**, because
> a coverage claim that counts both has counted one observation twice.
>
> **THE EXPIRY — three triggers, whichever fires first, none of them a date.**
>
> 1. **The next seeded-mutation campaign commissioned against this module.** The
>    separation is commissioned **in that order**, not after it, so the new units are
>    qualified by the campaign that measures them rather than waiting for a later one.
>    This is the trigger the refusal's own reasoning creates: the refusal rests entirely
>    on there being no instrument in flight, so the instrument's return revokes it.
> 2. **The next round that opens `test/xgmii_rx_64/test_m03_l.ml` for any other
>    reason.** The marginal cost of an ordering change collapses when the file is already
>    open — the same carrier logic `J-orchestrator-0225` ruling 2 used to make
>    `FINDING K-1` ride this round rather than a commit manufactured to carry it.
> 3. **`P1-phase-accept`, as a backstop.** If neither of the first two has fired by that
>    gate, **the refusal expires there and is re-decided in the open**, with this block
>    cited as the prior decision. **This is the trigger that stops a "not yet" becoming a
>    "no" nobody decided** — it does not let the question lapse into silence, which is
>    the failure mode `AP-M03` §7 recorded the question against in the first place.
>
> **This answer is given, not passed on.** No later artefact inherits the question by
> default; a later round that wants a different answer overturns this one in writing.

### 3.9 The standing set, carried with carriers named (NOT paid here)

`FINDING RV-0078-S2-3` (§7's exhaustiveness claim; **one carrier, the co-sim Phase 3
CD instance round, `SCOPED, NOT AUTHORISED` — if Phase 3 is deferred past this packet
the defect outlives the packet's active life with no owner in flight, and this round
checks and records that**), `S2-9` (gate (e)), `S2-10`, `S2-12`, `S2-15`,
`RV-0078-S1-3`, `S1-4` (five never-fired reference-side guards; first dischargeable at
C9), `WO-0078-1`, `FINDING CD-P2-1` (standing as to C8/C9), `FINDING CD-P2-2` (date
inconsistency; nothing rests on it), `FINDING M-4` (contaminated matcher),
`FINDING RV-0075-1` (T1's printer; carrier the next commit opening `test/cosim/**`),
`FINDING RV-0075-2` (carried antecedent; carrier the order lifting `WO-0075` §8 item 1),
`FINDING ECS-3` / `ECS-6` / `ECS-7` / `ECS-8` (Stage-3 re-authorisation packet),
`WO-0047` §2's 4-octet anti-vacuity member (`test_m03_f.ml`), `OBSERVATION L-O1`
(`test_m03_l.ml`), `WO-0073-D3`'s `M03-I4` mislabel (`test_m03_i.ml`),
`OBSERVATION K-O1` (`test/monitors/`), `DVC-1a`/`DVC-1b` (commissioned, unbuilt),
`AP-M14` §6's invariant, the RFC 1071 anchor, X-10/X-11 deferred.

**`FINDING J-1` is CLOSED in both halves** (`J-dv_lead-0148`) and is listed here only
so a reader does not go looking for it.

---

## 4. THE PROGRAMME'S FIRST LESSONS HARVEST

### 4.1 Its form, and the two destinations

Per ADR-0018 and PROTOCOL §7, **the harvest is a precondition of the sign-off, not a
follow-up to it**. It has two destinations and one authority:

- **Locally** — `docs/gates/lessons-harvest-block.md` §3's block, instantiated in this
  packet's own sign-off section under `## Lessons harvest — SO-xgmii_rx_64`, filled by
  the orchestrator from each agent's note. **Each cell's authority is the cited
  `J-<agent>-NNNN` entry**; the checklist edit is clerical.
- **Cross-repo** — into the generic shell's `LESSONS` file, **with permalinked
  provenance**, the shell unfreezing for **exactly one commit per harvest**. That
  transit is **the orchestrator's** (dv_lead stages nothing outside its scope and
  nothing outside this repo); **the content is mine**. The shell commit is an inbox PR
  against a repo this programme does not own, and **it is not a fait accompli**: the
  sponsor may refuse a candidate, and a refusal is recorded in the disposition column.

**Ids**: `LC-SO-xgmii_rx_64-<n>` for a **tier-1 general** candidate,
`LD-SO-xgmii_rx_64-<n>` for a **tier-2 domain** candidate, numbering independently, ids
never reused. Tier 3 forks into **war story** (kept, re-offerable with new provenance)
or **local accretion** (adopted here by its own ADR / `C-` row / `R-` rule / spec
clause, as a separate artefact and commit).

### 4.2 The span — and it is longer than any recent note says

**Every agent's first harvest opens at that agent's first entry** (harvest block §3
checklist, ADR-0018 §9; closed gates are not retro-harvested). **No dv_lead harvest has
ever fired.** So:

> **dv_lead's span: `J-dv_lead-0001` … `J-dv_lead-<the signing entry>`.**

This is the interval `J-dv_lead-0121` … `-0124` state in their own notes — *"cumulative
untiled span J-dv_lead-0001 … 0124, first harvest still firing at `SO-M03`"* — and it
is **not** the interval the v07 notes have been repeating. Those say *"open since
`J-dv_lead-0148`"*, which is the span since the **last banking note**, not since the
last **harvest**. **The two are different and only one of them tiles.** Recording that
here is the point of drafting the harvest before writing it.

**Worker spans I commissioned** (PROTOCOL §7: *a lead also mines the worker spans it
commissioned*), each `RE-MEASURE` at the sign-off SHA by counting entry headers:

| worker journal | span | note |
|---|---|---|
| `workers/claude_tb_writer_agent.md` + `.v02` + `.v03` | `J-tb_writer-0001` … `-0040` | three volumes; chain headers verified before mining |
| `workers/claude_data_wrangler_agent.md` | `J-data_wrangler-0001` … `-0008` | |
| `workers/claude_formal_dv_agent.md` | **zero entries** | dormant — **nil, declared** |
| `workers/claude_rtl_module_dev_agent.md` | **zero entries** | not mine to mine (rtl_lead's) |

### 4.3 The bank, enumerated AT THE SOURCE — and the reconciliation it forces

**No total is quoted here.** `J-dv_lead-0159` §9(b) refused to quote one and routed the
enumeration to this document; the enumeration below is that routing paid, and it turns
up **more than the near-miss note described**.

**The near-miss note said**: *"my own journal holds eleven labelled candidates
`LH-cand-A` … `LH-cand-K` alongside a later note calling one 'a tenth'. The totals
disagree."* **Measured over the chain, the disagreement is not two schemes but FOUR
regimes, and at least three separate accounting defects.**

**REGIME 1 — the labelled `LH-cand-*` bank, volume 07.** Eleven, each at its source,
each `LH2-g` on its face:

| id | entry | rule statement, at its source (abridged to its first clause; the entry carries it whole) |
|---|---|---|
| `LH-cand-A` | `J-dv_lead-0152` | *a census of a system's refusal guards records, for each guard, the state variable it tests and the interval over which that variable is true — never the condition its message names* |
| `LH-cand-B` | `J-dv_lead-0152` | *in a differential harness the bookkeeping layers on the two sides are common-mode; the independence that makes the comparison worth having is a property of the two implementations under test, never of the two harness halves* |
| `LH-cand-C` | `J-dv_lead-0153` | *when a review recommends a settlement on a stated ground, the round that executes it re-measures that ground at the source before acting on it* |
| `LH-cand-D` | `J-dv_lead-0154` | *a repair that changes which inputs a component ACCEPTS also changes which outputs it PRODUCES; a fixture pair checking only the accept-or-refuse decision has verified half the repair* |
| `LH-cand-E` | `J-dv_lead-0154` | *a record format in which a record's owner is implied by position rather than named is unambiguous only while one owner can be open at a time* |
| `LH-cand-F` | `J-dv_lead-0155` | *a bound introduced to make a buffer finite is sized against the workload in front of its author; state the range the bound must cover in the same change that introduces it — the number is not the defect, the missing range is* |
| `LH-cand-G` | `J-dv_lead-0155` | *the same attribution rule can be sound in a probe and unsound in a parser; when a format loses a fact, move the fix upstream to where the fact is still observable* |
| `LH-cand-H` | `J-dv_lead-0155` | *a frozen prediction is spent by a comparison that could have falsified it — never by a run happening; count comparisons, not runs* |
| `LH-cand-I` | `J-dv_lead-0156` | *a comparison that reports only whether two sides agree cannot tell you what they agreed on; where the interesting fact is a value rather than a relation, print the agreed value on the passing path* |
| `LH-cand-J` | `J-dv_lead-0156` | *a quantity whose comparison is barred does not become assertable by reproducing; reproduction earns confidence, never jurisdiction* |
| `LH-cand-K` | `J-dv_lead-0156` | *when the reason a standing refusal rested on expires, say so and replace the reason before restating the conclusion — and attach a condition, or a repeated "not yet" becomes a permanent "no" that nobody ever decided* |

**REGIME 2 — the parenthesised `(A)` … `(J)` bank, volumes 06–07**, a *different*
sequence that also starts at `(A)` and whose letters collide with regime 1's throughout:

| label | entry | subject |
|---|---|---|
| *(three, unlabelled: (i)(ii)(iii))* | `J-dv_lead-0137` | class-gate naming; collision inventories from cross products; per-reporter attribution |
| *(two, unlabelled)* | `J-dv_lead-0139` | (banked, unlettered — the later enumerations omit them) |
| `(A)` | `J-dv_lead-0140` | *an observable expressed as an absence cannot distinguish never-produced from produced-and-suppressed* |
| `(B)` | `J-dv_lead-0140` | *a harness's own refusal guard is evaluated before the component under test is read, so no mutation of that component can score it* |
| `(C)` | `J-dv_lead-0141` | *a path cited in a normative instrument is verified to resolve at the tree the instrument governs, before the instrument is issued* — **second incident at `RN-6`, observable strengthened** |
| `(D)`, `(E)` | `J-dv_lead-0142` | |
| `(F)` | `J-dv_lead-0143` | |
| `(G)`, `(H)` | `J-dv_lead-0144` | |
| `(I)` | `J-dv_lead-0145` | *an assertion that names its expected value without reporting the observed one collapses every distinct cause into one indistinguishable effect* |
| `(I)` **again — DUPLICATE LABEL, DIFFERENT RULE** | `J-dv_lead-0147` | *a universal asserted over one stimulus producer is measured over every producer that drives the unit under test* |
| `(J)` — *"the tenth"* | `J-dv_lead-0149` | *when an instrument is measured capable on exactly one configuration, that configuration is frozen and new ones are added beside it* |
| *(unlabelled, called "a tenth")* | `J-dv_lead-0157` | *a readiness census over the layers that consume an input is not a readiness census; "no mechanism exists" is a measurement over a stated set or it is a guess* |
| *(unlabelled)* | `J-dv_lead-0160` | *a divergence-class question is answered per equivalence class of the exclusion's own axes, never per test family and never per test case* |

**REGIME 3 — the unlabelled `(LH2-g)` bullets of volume 05**, banked at
`J-dv_lead-0126` (three), `-0127` (two), `-0128` (two), `-0129` (one), `-0130` (one),
`-0131`, `-0132` (two), `-0133` (one), `-0134` (two), `-0135` (one further). **None of
them appears in any regime-2 enumeration.**

**REGIME 4 — the running inventory figures of volumes 03–04**, carried as
*"~19 LH2-g candidates plus the war stories"* → *"~20"* → *"~24"* → *"~25"* at
`J-dv_lead-0121` … `-0124`, over the span `J-dv_lead-0001 … 0124`. **A tilde is not a
measurement**, and the entries say so by using one.

**THE THREE ACCOUNTING DEFECTS, each checkable by a reader at the cited entries:**

1. **A duplicated label.** `(I)` names two different rules, at `J-dv_lead-0145` and
   `J-dv_lead-0147`.
2. **A running total that is internally inconsistent at its own enumeration.**
   `J-dv_lead-0145` writes *"the eight candidates banked against it"* and then lists
   nine (three + `(C)` + `(D)`,`(E)` + `(F)` + `(G)`,`(H)`); `J-dv_lead-0147` writes
   *"nine"* over the same list plus one more.
3. **Silent truncation of the bank at each volume boundary.** The regime-2
   enumerations begin at `J-dv_lead-0137` and omit both the two banked at
   `J-dv_lead-0139` and the whole of regime 3; the regime-1 scheme restarts at `A` and
   declares its span *"open since `J-dv_lead-0148`"*, which is not the harvest's span
   (§4.2).

**THE RECONCILIATION THIS PACKET OWES, stated as a method rather than a number:**

> The executing round **walks the journal chain from `J-dv_lead-0001` forward**,
> extracting every banked candidate at its own entry, **re-labels the whole bank once
> into a single `LC-`/`LD-` sequence** allocated in **entry order**, and records the
> old label beside each so every prior citation still resolves. **The count is a
> product of that walk and is stated as measured, with the command; it is not carried
> from any note.** Duplicates are merged only where **two entries state the same rule**
> — never where they merely share a letter — and a merge is recorded with both
> provenances, because a candidate that gained a second incident is stronger, not
> shorter.

**And the harvest's own bar applies to the bar**: a harvest whose war-stories table is
empty says something about the bar, not about the span; **a yield that is all `LD-` and
no `LC-` says something about the miner.** The executing round runs the §2.1 classifier
**from the most general honest statement** on every candidate — the domain grade is
reached only *through* a general statement that was attempted and went hollow.

**This draft admits nothing and refuses nothing.** Admissibility is the harvest's to
rule, and the harvest is the executing round's.

---

## 5. WHAT THE `SO-` MAY NOT CLAIM — the prohibition register

**Each is quoted from the verdict that barred it. A sentence violating any of these is
a finding against the packet, whatever its verdict.**

### 5.1 On the anchor

1. **No sentence of the form *"the co-simulation anchors this module."*** A class is
   anchored; a requirement is not; a module never is. (`WO-0078` §8, `AP-M03` §7.)
2. **The anchor anchors five classes on their four REQ-901 observables and no
   requirement.** REQ-102 is not anchored — class 5 is. REQ-104 is not anchored —
   class 4 is.
3. **No claim about a class the case set did not drive.**
4. **A lift is not a row discharged**: no row's status, no coverage-map line and no
   discharge count moves on a lift.
5. **A re-observation is not a lift and does not renew one.**

### 5.2 Bar 2 — permanent by specification

> For **REQ-107** and **REQ-108** — REQ-901's declared divergence classes **(e)** and
> **(f)** — **a co-simulation result is not an admissible external anchor at all, and a
> sign-off packet SHALL NOT offer one.**

**Stated as permanence, not as "it has not moved yet": no stage of any phase can alter
this**, five landed classes included and any future class included. It is a property of
the frozen requirement, not of how much stimulus the lane has driven. **Bar 2 reaches
their strobes too.** Families F and G are not *waiting* on this lane; their directed
rows are the whole of their verification.

### 5.3 Bar 3 — timing, barred rather than un-built

**No `SO-xgmii_rx_64.md` may cite the co-simulation anchor as timing coverage of any
stimulus class**, the five driven ones included. The lane **records** time on both
sides, **asserts our side against SPEC-M03 §6.1's own `admit_cycle + m + 3`**, and
**reports the reference's cycles as data, never adjudicated**. An assertion against
one's own specification is not an anchor; a tier that may never be adjudicated is not
coverage. **REQ-901 excludes cycle alignment, internal pipelining and latency constants
by name, so a cross-side timing comparison is BARRED, not un-built** — a later phase
that wants one takes a REQ-901 spec diff to architect_docs_lead; a comparator does not
grant itself one.

### 5.4 Bar 4 — strobes, outside the comparison domain

**NO `SO-xgmii_rx_64.md` MAY CITE THE CO-SIMULATION ANCHOR AS STROBE COVERAGE OF ANY
STIMULUS CLASS.** **The reason it must give is now split by strobe**: for
`error_bad_fcs` the reason is the **MAPPING and the GRAMMAR** (precondition (1),
stimulus, became MET at C3); for **every other strobe** the reason is still the
**STIMULUS**. `error_runt` and `error_oversize` are unreachable **by specification**
(bar 2); `error_start_without_terminate` has **no counterpart output** on the
reference's published port list; `error_bad_frame` exists on both sides **and is a
different signal** — the reference raises it on a bad FCS, where §9's table gives that
event to `error_bad_fcs` alone, so a name-keyed comparison would **red a conformant
M03**. **No strobe of either side was compared at any of the five landed classes, and
none could have been.**

### 5.5 `FINDING RV-0078-S2-11` — relational records

**No document may state a co-simulated value that the log does not print.** A value
established by pairing this lane's agreement with another instrument's assertion is
**written as the pair, with both cited.**

### 5.6 `FINDING ECS-2` — the reachable window

**REQ-901's *"classes (e) and (f) exclude nothing in the 64-to-1518-octet range"*
sentence is never lifted without the reachable-window sentence beside it.** The lane's
reachable window is **64 ≤ n ≤ 132**. A packet lifting the range alone would be claiming
eleven twelfths of a range no run can enter.

### 5.7 The bench-side prohibitions

Every rider at §2.1 item 4 and every `U-` disposition at §2.6 is a prohibition in this
register: **a coverage claim counting a `U-`-marked assertion has counted one
observation twice**, `frames_exempt` is never evidence a frame was driven, `M03-B3` and
`M03-N2`'s sub-cases are never ruling-9 coverage, `M03-J1`'s silence never says frames
were not admitted, and `M03-L3`'s ΔC content is discharged by a derivation about the
specification and by no run.

---

## 6. THE STAGE-3 STATEMENT

**Stage 3 of the co-simulation lane is REFUSED, and it is OFF THE `SO-`'s CRITICAL
PATH. Those are two different statements and the packet makes both.**

### 6.1 Refused — a reading of its own gate, not a judgement about appetite

Gate state at `c1f98ff` (`RV-SWEEP` §5), `RE-MEASURE` at the sign-off SHA:

| | condition | state | owner |
|---|---|---|---|
| **(a)** | Stage 2 landed, all cases green or every divergence adjudicated to a named branch | **SATISFIED** — four cases, four at branch α | closed |
| **(b)** | CD carries a co-sim **Phase 3** domain instance | **UNMET** — not one instance exists | dv_lead |
| **(c)** | C9's admission rule written as spec text before either producer is opened | **UNMET**, and **reshaped**: what must be written is the **span-closing rule**, not *"REQ-110's abort rule"*, and its scope is **five classes, not one case** (`FINDING ECS-3`) | architect_docs_lead, routed by dv_lead |
| **(d)** | a second static census on three axes | **MET** (`RV-SWEEP` §4) | closed |
| **(e)** | `MAX_WORDS_PER_FRAME` raised to cover the longest frame either producer can deliver, with the covering range stated beside the bound | **UNMET** — 16 words = 128 delivered octets = frames to 132, against a 64-to-1518 requirement range | dv_lead |

**Three of five unmet.** The refusal is not this packet's to lift and the packet does
not lift it.

### 6.2 Off the critical path — and the measurement that decides it, with its expiry

**The consequence `RV-C4` §13 item 4 routed to the `AP-` round and `J-dv_lead-0159`
paid**: bar 1 gates a row **iff** its expected values come from X-1(ii)'s computed
outcome model; **no benched row does**, re-measured at `e51ca52` over **both**
producers by five recorded commands; **therefore no row of this plan is waiting on a
class Stage 3 would drive, and Stage 3 is not on the `SO-`'s critical path.**

**Four things that does NOT say**, quoted so a reader cannot widen it: it does not say
Stage 3 is worthless — it says the `SO-` does not wait for it; it does not lift bars 2,
3 or 4, which are per requirement and per quantity and are untouched by any measurement
of rows; it does not discharge the charter §3 anchor, which stays undischarged with
REQ-901's class list unchanged; and **it does not survive its own future.**

**THE EXPIRY, stated so nobody has to guess**: *the moment a row takes an expected value
from X-1(ii) — which a fuzz campaign would do on its first day — this measurement is
stale and the claim is re-measured before it is quoted again.* **It is not a standing
fact; it is a fact about a tree.** **The executing round re-measures it at the sign-off
SHA and does not inherit it from this draft.** And per `FINDING ECS-6` it states the
evidence in its **mechanism** form — no `Injection.outcomes` and no
`Injection.expected_strobes` call site in `test/cosim/` — **never** in its mention-count
form.

### 6.3 The (g)/(h) dependency for C8 and C9 — recorded as PENDING, not predicted

`RV-SWEEP` §3 read two **candidate divergence classes** off the reference's own source,
on paths no run has ever driven:

- **candidate (g)** — the **extent**: the reference's abort path leaves `tkeep` at
  `STATE_PAYLOAD`'s all-ones default and strips no FCS, where ours truncates at the
  octet preceding the aborting character. (`FINDING ECS-4`.)
- **candidate (h)** — the **decision**: `STATE_PAYLOAD` asserts `tvalid` unconditionally
  before its framing-error branch, so a frame the reference opens and immediately finds
  in error still emits at least one output word, where §0.7 requires ours to emit none.
  (`FINDING ECS-5`.)

**Both are predictions until a run spends them, both are stated as *kind* of divergence
and never as a figure**, and **two are not one class stated twice** — a single class
wide enough for both would exclude the decision on frames where the decision agrees.

**The consequence for Stage 3's worth, said plainly because the honest answer is
unflattering**: if (g) and (h) hold, **C8 and C9 select branch γ, and γ lifts nothing**
— so the two cases the sweep makes most interesting anchor nothing until a spec diff
lands. **The run is not blocked; the citation is.**

**The dependency's status in this packet: PENDING, and the packet says so rather than
predicting it.** REQ-901's class list is `docs/specs/requirements.md`'s, its amendment
carries the countersignature discipline, and **the spec-diff request for (g)/(h) is
concurrently before architect_docs_lead. This packet records the request as routed and
its ruling as not yet made. No sentence here anticipates the ruling, and no criterion
at §1 is contingent on it** — which is what makes it safe for the two documents to be
in flight at once.

---

## 7. SEQUENCING — the execution order, and the gate at the end

### 7.1 The `SO-` round's own execution order

**Twelve steps. The order is load-bearing at steps 2→8, 3→6 and 10→11; elsewhere it is
merely sensible.** Each step names what it changes and what would be wrong about doing
it later.

| # | step | writes | why here |
|---|---|---|---|
| **1** | **Abort-first head check**; declare the base; verify `git diff --name-only <base> HEAD -- test/ libs/ tools/` and record the result | — | every denominator below is measured against a tree; an unverified base is what voids a round |
| **2** | **Pay `FINDING K-1`** — `test_m03_k.ml` prints the observed delivered-cycle list beside the expected | `test/xgmii_rx_64/test_m03_k.ml` | **terminal carrier; must precede step 8**, because the reader writing family-K's rows must be able to see what the assertion observed |
| **3** | **Pay `RN-6`** — the `docs/**` resolve-check in `tools/dv_checks.sh`; run it; disposition every unresolved citation | `tools/dv_checks.sh` | **must precede step 6**: the census is quoted from the script as it exists at the sign-off SHA |
| **4** | **Rule `S2-11`'s repair**: open the comparator and print the agreed decision and `tuser`[0] on the clean path, **or** decline and write REQ-104's row as the pair | `test/cosim/**` (conditional) | the decision determines how §2.3's REQ-104 row may be worded; making it after writing the row inverts the dependency |
| **5** | **Answer `U-1`/`U-2`'s pricing** — commission with cost, or refuse with a reason **and an expiry** | a `WO-` draft, or a recorded refusal | `LH-cand-K`'s rule applied to me: an unconditioned "not yet" becomes a "no" nobody decided |
| **6** | **Re-measure every set claim** — row census and inventory, suite inventory, era tally, bar 1's set claim, the 22-assertion breadth figure, the open-`BUG-` set — each with **SHA, domain and polarity** | — | §0.2; nothing quoted from this draft survives without it |
| **7** | **Trigger CI at the candidate sign-off SHA**; capture the `build` run id and step conclusions and the `cosim` job id and conclusion, **separately** | — | SC-3; the pass is the run id |
| **8** | **Write §1 criteria, §2 evidence map and the per-family coverage rows** — family K's rows only now | the packet | steps 2 and 6 are its inputs |
| **9** | **Write the owed ledger, the prohibition register and the Stage-3 statement** | the packet | §3, §5, §6 |
| **10** | **Do the harvest**: walk `J-dv_lead-0001` forward, enumerate at source, re-label once, run the classifier, discharge LH1–LH3, record war stories, mine the worker spans, instantiate the block | the packet + the journal note | **must precede step 11**: the harvest is a precondition of the sign-off, not a follow-up |
| **11** | **Write the verdict** — one token — and read §1 back criterion by criterion against what the packet actually says | the packet | SC-14 |
| **12** | **Write `J-dv_lead-NNNN`** with the exact suite commands and observed results in Evidence, and the harvest note in full; hand the staged-ready file set to the orchestrator | the journal | charter §8; PROTOCOL §5 R2 |

**What the round may NOT do**: stage anything outside `test/**`, `tools/**`,
`docs/reports/latency/**`, `agents/handoffs/**`; edit the CD; edit
`docs/specs/**` or `docs/adr/**`; run `git commit` or `git push`; or write any sentence
§5 forbids.

### 7.2 After the packet lands — the gate ladder

1. **The orchestrator commits** the packet, the journal entry and the `test/`/`tools/`
   payments under `Agent: dv_lead`, one journal append per commit, and relays the
   packet **verbatim** (PROTOCOL §3).
2. **The harvest transits**: the orchestrator collates every persistent-journal agent's
   note into the instantiated block, allocates the shell's `L-` ids, and opens the
   inbox PR against the generic shell — **exactly one commit, containing the admissible
   candidates with permalinked provenance and nothing else**. The `LC-`/`LD-` → `L-`
   pairs are recorded so a reader can travel in either direction.
3. **`P1-module-ready`** — the DV rows are this packet plus the mutation-kill record
   plus the line-rate stress result. **Signatures are journal-entry references and the
   orchestrator transcribes them** (PROTOCOL §7); dv_lead cannot stage `docs/gates/**`.
   **The gate is not passed while any box of the instantiated harvest block is
   unchecked.**
4. **`P1-phase-accept`** — replay clean, latency report committed under
   `docs/reports/latency/`, audit report committed with no open CRITICAL findings, and
   **sponsor approval, escalation class E1**.

### 7.3 The sponsor's sign-off gate, and what it looks like

The sponsor's role in his own words — *sets vision and direction, **final sign off at
each stage*** — and in `ORG_CHART.md`: **final authority on phase gates, scope,
toolchain and licensing, org changes.** Concretely, at the end of this arc:

- **He does not receive this packet directly.** dv_lead has no direct sponsor contact
  (charter §4); everything reaches him through the orchestrator, batched and
  decision-ready with options, a recommendation and a cost (PROTOCOL §8).
- **What he sees is one E1 packet and one shell diff.** The harvest table rides inside
  the checklist; the shell transcription is **one commit**, which is what makes his
  review tractable. **Ratification means he may refuse a candidate**, and a refusal is
  recorded in the disposition column — the shell commit is not a fait accompli.
- **What he is being asked for is approval of the phase gate, not of the verdict.** A
  `PASS` here is a *merge precondition* the org enforces on itself; the sponsor's
  authority is over the gate the evidence feeds. **A `FAIL` is not an escalation** — it
  is normal packet flow to rtl_lead (charter §7).
- **What he should be able to check without reading the whole record**: that the
  verdict is one token; that every non-kill column is named rather than folded; that
  the anchor is stated per class with its bars; that every span in the harvest block
  tiles with no gap and no overlap; and that the packet's own set claims carry their
  SHA. **Those five are deliberately the cheapest things in this document to check and
  the most expensive to fake.**

---

## 8. VERDICT

**UNSET. This is a draft.**

No criterion at §1 is adjudicated here, no bar is lifted, no anchor is claimed, no
count is asserted, no harvest is taken and no signature is given. **The executing round
writes one token in this section and signs it with its journal entry.**

---

## 9. What this draft deliberately does not do

1. **It opens no verdict and adjudicates no criterion.** §1 is the contract the
   executing round is graded against, written before the round can see its own result —
   which is the same discipline every campaign seal in this programme was written under.
2. **It touches no `docs/**` path.** The ECS-4/ECS-5 spec-diff request and the operator
   ADR are architect_docs_lead's, concurrently in flight; §6.3 records the (g)/(h)
   dependency as **pending** and predicts no ruling.
3. **It does not amend `WO-0078`.** That packet's `State` field, its Return log and its
   `RV-SWEEP` entry are untouched; this document is new and disjoint.
4. **It edits the CD nowhere.** The ninth consecutive refusal, on `CD` §10.7 item 3's
   own ground: *this document freezes the questions; it answers none of them.*
5. **It pays no carrier.** `FINDING K-1`, `RN-6`, `S2-11`'s repair and `U-1`/`U-2`'s
   pricing are all **designed** here and **paid** at §7's steps — because a design round
   that pays a carrier has widened its own write set mid-round, which is the thing this
   programme's reviewers convict others for (`RV-C4` §12).
6. **It runs nothing.** No `dune`, no `iverilog`, no `vvp`, no CI trigger. Every figure
   quoted is marked `RE-MEASURE` and carries the entry that measured it.

---

## 10. Change log

| date | change | by |
|---|---|---|
| 2026-08-10 | **EXECUTION ROUND 1R — the round-1 payment's own CI verdict, and its repair, at base `ee3da9c`.** `RN-6`'s check failed its first runner execution (`build` `31442295998`): 4 UNDECLARED broken citations, all citing `docs/reports/latency/`, **this packet among the four citers**, against 0 locally. **Two findings, both mine, both paid**: `FINDING RN-6-CI-1` — the catch is a TRUE POSITIVE, the directory existed only as an empty untracked directory that git cannot carry, so the path is absent from every fresh clone; `FINDING RN-6-CI-2` — the resolver measured the FILESYSTEM where the honest test is the TRACKED TREE. Repairs: the resolver is rebuilt on `git ls-files` over two universes (tracked / committable), neither of which can contain an empty directory, with `PENDING-COMMIT` printed for a citation resolving only through an uncommitted path; the four citations are dispositioned as **one tracked file, zero errata** (`docs/reports/latency/README.md`), so this packet's own citation ends the round RESOLVING rather than declared-broken (`SC-10`). Header gains an Execution bullet; §3.0.1 records the round; §3.2.1 carries the repair, the dispositions and seven evidence rows including a constructed fresh checkout and three negative controls. **No §7.1 step executed, no ledger item moved, State still DRAFT, §8 still UNSET, no criterion of §1 adjudicated.** | dv_lead, `J-dv_lead-0164` |
| 2026-08-10 | **EXECUTION ROUND 1 — §7.1 steps 1–5, at base `4e7331b`.** Header gains an Execution bullet; §3.0 records the four ledger items paid (`FINDING K-1`'s message repair in `test_m03_k.ml`; `RN-6`'s gating `docs/**` resolve-check in `tools/dv_checks.sh`, with a self-test, a declared-errata table and a staleness guard; `FINDING RV-0078-S2-11` ruled and executed; `U-1`/`U-2` answered) and raises one finding against this packet's own §3.9 — `FINDING RV-0075-1` is listed as standing and is CLOSED. §3.5 and §3.8 gain their `RULED` blocks: the comparator is opened and prints the agreed values on the passing path; the `U-1`/`U-2` pricing is refused with a price, a bound and a three-trigger expiry. **State still DRAFT, §8 still UNSET, no criterion of §1 adjudicated, no bar lifted, no count asserted, no harvest taken.** | dv_lead, `J-dv_lead-0163` |
| 2026-08-10 | **Document created as a DRAFT at `49d87af`.** Fourteen sign-off criteria (`SC-1` … `SC-14`); the evidence map over the bench era with its five riders, the ten-campaign mutation era in five columns, the anchor's five classes at run and job ids, the seventeen-class error table, the four bars and the five unreachable instruments; a twelve-item owed ledger with `FINDING K-1` positioned before the family-K rows; the first lessons harvest designed — span opened at `J-dv_lead-0001`, the bank enumerated at its sources across four labelling regimes with three accounting defects named, and a re-labelling method rather than a total; the prohibition register; the Stage-3 statement with its expiry and its (g)/(h) dependency recorded as pending; a twelve-step execution order and the sponsor's gate. **No verdict, no lift, no carrier paid, nothing run.** | dv_lead, `J-dv_lead-0161` |
