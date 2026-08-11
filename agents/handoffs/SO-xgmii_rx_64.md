# SO-xgmii_rx_64 — **RE-ISSUED (round 4). VERDICT: PASS.**

- **State**: **RE-ISSUED — RE-VERDICT EXECUTED (round 4)** at `41fead6`. §1 is read back a
  **third** time, criterion by criterion, at the new SHA; §8 carries one token; this
  document is a sign-off packet and is in the **verbatim** relay class (PROTOCOL §3).
  *(Was `DRAFT` through `J-dv_lead-0161`, `-0163` and `-0164`; `ISSUED — EXECUTED` at
  `2183d71` through `J-dv_lead-0165`; `RE-ISSUED — RE-VERDICT EXECUTED` at `14615f8`
  through `J-dv_lead-0167`. Every superseded statement is preserved where it was written
  and none is rewritten into its own outcome; round 2's read-back stands at §1.1 and
  round 3's at §1.2, both unedited.)*
- **Verdict**: **PASS** — §8. **All fourteen criteria of §1 are met**, scored criterion by
  criterion at **§1.4**, with every bound the module has not earned listed inside the
  `PASS` at **§8.R4.4** (SC-14's own requirement — a bound is not a qualifier).
  *(Round 2's verdict was `FAIL` on **two** — `SC-2` and `SC-12`. Round 3's was `FAIL` on
  **one** — `SC-12` — on `FINDING SO-6`. Both prior tokens are preserved and quoted
  beneath the live one at §8; neither is a second live token.)* **`SC-12` moves NOT MET →
  MET** on two acts that landed before this round could read them: the orchestrator's
  successor harvest note (`J-orchestrator-0234`, `b4814b0`), which pays `FINDING SO-6`,
  and **ADR-0018 Amendment A2** (`85753b6`, in force at `41fead6` on the acceptance act
  `J-orchestrator-0235`), which settles `FINDING SO-5`'s wording half **by amendment
  rather than by anyone's reading** — the condition round 3 fixed in advance for exactly
  this round.
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
- **Execution — round 2, FINAL**: `J-dv_lead-0165`, base and **sign-off SHA
  `2183d71`**. §7.1 steps **6–12**: every set claim re-measured with SHA, domain and
  polarity; the CI evidence captured at `build` run **`31444471834`**; §1 read back
  criterion by criterion at **§1.1**; §2's evidence map filled **measured, not
  carried**; the owed ledger closed at **§3.10**; the programme's **first lessons
  harvest** taken at **§4.4–§4.8** by walking `J-dv_lead-0001` → `-0165`; the Stage-3
  statement re-measured at **§6.4** with REQ-901 classes **(g)** and **(h)** now **IN
  FORCE**; the verdict written at **§8**. **The execution changed carried figures and
  one whole tally** — §2.4's seventeen-class disposition moves from *five inside /
  twelve outside* to **nine inside / eight outside**, because the specification moved
  under it — and every difference is recorded as a finding, per §2's own rule.
- **Execution — round 3, THE RE-VERDICT**: `J-dv_lead-0167`, base and **re-verdict SHA
  `14615f8`**. Both acts §8.2 named are paid — act 1 at `a43ac00` (`WO-0079`,
  `J-dv_lead-0166`) and `14615f8` (transcription, `J-architect_docs_lead-0035`); act 2
  across `185ae66`, `d53d795`, `54b2553`, `c55c754` (four harvest notes). §1 is re-read
  criterion by criterion at **§1.2**, the census producers re-measured rather than
  carried (`test/`, `tools/`, `libs/`, `test/cosim/`, `docs/reports/audit/` and
  `docs/specs/requirements.md` all **byte-identical** `2183d71..14615f8` — §1.2's
  identity row), the delivery **verified at the matrix** at §2.8-R and the harvest
  **verified at each seat's own journal** at §4.9. **`SC-2` moves NOT MET → MET.
  `SC-12` stays NOT MET on a ground the previous round could not reach**, and one
  finding is minted: **`FINDING SO-6`**, §4.9.
- **Execution — round 4, THE PASS**: `J-dv_lead-0168`, base and **sign-off SHA
  `41fead6`**. The two things round 3's §8.0.2 named are both paid **and both are measured
  at their artefacts rather than at the dispatch that described them** — §4.9's own
  method, turned on the round that answers §4.9. Act 1: `J-orchestrator-0234` (`b4814b0`),
  the successor harvest note over the same span with the same eighteen ids unrenumbered —
  **18 of 18 now discharge LH3 and 18 of 18 carry a stated LH2 grade**, mechanically
  counted at the journal (§4.10). Act 2: **ADR-0018 Amendment A2** (`85753b6`), which
  partitions the block's eleven boxes **7 / 4** and rules that a sign-off instantiates
  **Part A only** (A2-D1) — and which found the impossibility was minted in
  `docs/gates/lessons-harvest-block.md` line 5, **not** in `SC-12`. §1 is re-read
  criterion by criterion at **§1.4**; `SC-12`'s reading is settled at **§1.3**; the
  harvest block is re-instantiated under A2's partition at **§4.10**; **`FINDING SO-6` is
  DISCHARGED** and **`FINDING SO-5`'s wording half is SETTLED BY AMENDMENT**; one
  observation is minted and deliberately **not** charged — `OBSERVATION SO-O1`, §4.10.
  **No RTL, no test, no tool moved in the interval** (§1.4's identity row).
- **Signed**: **`J-dv_lead-0165`**, dv_lead, at `2183d71` (round 2).
  **Re-signed**: **`J-dv_lead-0167`**, dv_lead, at `14615f8` (round 3).
  **Re-signed**: **`J-dv_lead-0168`**, dv_lead, at `41fead6` (round 4) — **the live
  signature**.

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

### 1.1 THE READ-BACK — the fourteen, criterion by criterion, at `2183d71` (§7.1 step 11)

**Read back against what the packet actually says, not against what the round
intended.** Two values only, because SC-14 admits two: **MET** (bounds, where the
module has not earned something, are listed inside the row and are not a third value)
and **NOT MET**. **Twelve MET, two NOT MET.**

| # | criterion, in one line | verdict | where measured / what bounds it |
|---|---|---|---|
| **SC-1** | attack plan precedes the first test; every row discharged or status-declared, inventory MEASURED | **MET** | §2.1-M. `df3e474` (2026-08-02, AP-M03) is an **ancestor** of `026a71f` (2026-08-02, the first M03 bench), 49 commits earlier — `git merge-base --is-ancestor` exits 0. Status-cell pass at `2183d71`: **78 rows / 62 ASSERT / 7 NO-ASSERT / 4 NO-STIMULUS / 4 STRUCTURAL / 1 GAP**. **62 of 62 ASSERT rows discharged, outstanding set EMPTY**; the one `GAP` is `M03-O2`, declared |
| **SC-2** | every REQ hook mapped or gap-declared; derived from spec not RTL; **test-side traceability rows delivered** | **NOT MET** | §2.8. Clauses (a) and (b) MET — 35/35 hooks carry AP §6 entries; no `libs/**`, `top/**` or `rtl_snapshots/**` path in this packet's derivation chain. **Clause (c) is UNMET and measured**: `docs/specs/traceability.md` carries **110 REQ rows and 110 empty `Test(s)` cells**, `Status` = `OPEN` on every one; **no dv_lead packet has ever delivered test-side rows**, and `WO-0002` §9 recorded the column as *"empty pending DV"* on 2026-08-02 |
| **SC-3** | suite green **and** tree clean at the sign-off SHA, **on a run id**, cosim quoted separately | **MET** | §2.9. `build` run **`31444471834`**, job **`93635620822`**, `head_sha` `2183d71`, conclusion `success` — **all 13 steps `success`**, including step 6 *"Run tests"*, step 8 *"Verify nothing was left unpromoted or non-deterministic"* and step 9 *"DV mechanical checks"*. `cosim` job **`93635620959`**, `success`, **stated separately and load-bearing for nothing outside the classes it drove**. `journal-check` run **`31444471838`**, `success`. **Bound**: `dune runtest` **cannot run in this container** (ADR-0005 — `ppx_hardcaml`/`hardcaml` absent; `opam exec -- dune build @default` fails at library resolution), which is exactly why the criterion makes the run id the evidence |
| **SC-4** | line-rate stress green, zero rx backpressure, frame count + run id, the pinned constants named beside it | **MET** | §2.10. `M03-L1`: **10 000** consecutive 64-octet frames, start lanes alternating 0/4 at the minimum spacing, green in run `31444471834` step 6. **Bound, and it is structural rather than observed**: *"zero rx backpressure asserted"* is discharged by **`M03-L6` (`STRUCTURAL`)** — the module exposes **no `tready`** on the stream under test and no `tready` input exists (REQ-112, REQ-003) — so there is no signal a consumer could assert. The pinned per-octet constants are **`M03-L2`** (L = 16 at h = 8, L = 12 at h = 12, word delay 3), **`M03-L3`** (whole-run word delay 3, ΔC = 3 against the §1.1 ceiling of 4) and **`M03-L5`**; `AP-M03` §7 bar 3 makes them the programme's only detector of a uniform word-delay regression |
| **SC-5** | mutations killed N/N; five columns, never folded; every non-kill named | **MET** | §2.2-M. Class-based era, **ten campaigns `WO-0050` … `WO-0077`**: **63 sealed / 61 killed / 1 survived / 0 green-by-blindness / 1 void**, and 61 + 1 + 0 + 1 = 63. Pre-class era, **four campaigns `WO-0039`/`0041`/`0042`/`0045`**: **15 of 15**, with `D-M3` ruled an equivalent mutant and excluded from the denominator. **The single survivor `G-c4` is named, and its defect is MEASURED DEAD at the repaired bench**: branch `mut/wo-0056-gc4-replay` = `c95c9f4`, the **unmodified** `g-c4.diff`, CI run **`30852220315`**, `runtest` RED with **`M03-G8` the only failing unit of twenty-seven**. Every other non-kill named individually at §2.2 |
| **SC-6** | the anchor stated **per class**, never per module, with each *"does NOT anchor"* list in the same cell | **MET** | §2.3-M. Five classes at their own `build`/`cosim` ids; absolute half and agreement half named separately per class; **the packet states in terms that the charter §3 anchor is UNDISCHARGED as a module-level anchor, and why**; **no sentence of the form *"the co-simulation anchors this module"* appears anywhere in this file** — grep-checkable |
| **SC-7** | the four bars restated in full and honoured in every sentence | **MET** | §5, and §5.8 names each sentence the packet declined to write and the bar that forbade it |
| **SC-8** | the unreachable-instrument register published with its consequence | **MET** | §2.6, unchanged and re-affirmed: `U-1` … `U-5` and `DECLARATION WO-0074-D1`, each with *a coverage claim counting such an assertion has counted one observation twice* |
| **SC-9** | open `BUG-`s listed, or **none** measured over the directory | **MET** | §2.7-M. Measured over `agents/handoffs/BUG-*.md` at `2183d71`: **three packets, three CLOSED, none open** — `BUG-0001` FIX CONFIRMED (`J-dv_lead-0034`), `BUG-0002` **ACCEPT — CLOSED** at `fafb83d` (`J-dv_lead-0089`), `BUG-0003` **FIX ACCEPTED — CLOSED** (`J-dv_lead-0103`) |
| **SC-10** | every set claim carries SHA, domain and polarity | **MET** | throughout, and §2.11 collects the round's own three-dimension record, including **two domain corrections the re-measurement produced against my own instruments** |
| **SC-11** | the owed ledger paid in the declared order, `FINDING K-1` before the family-K rows | **MET** | §3.10. Twelve of twelve closed: 1, 2, 5, 10 at rounds 1/1R; **3, 4, 6, 7, 8, 9, 11, 12 here**. `FINDING K-1` was paid at step 2 (`J-dv_lead-0163`), **two rounds before** family K's rows were written at step 8. **One finding fires under this criterion's own last sentence — `FINDING SO-1`, §2.8** — and SC-11's own remedy for a late-discovered obligation is *a finding*, which is recorded, not a criterion failure |
| **SC-12** | the programme's first lessons harvest is **complete**, block instantiated, **every box checked** | **NOT MET** | §4.8. **My own note is complete and is the fullest thing in this packet** — span `J-dv_lead-0001 … -0165` stated as an entry-id interval, **89 bankings walked at their sources and reconciled to 87 distinct candidates**, worker spans mined, classifier run, LH1/LH2/LH3 discharged per candidate, **nine war stories** recorded with the criterion each failed, **no total quoted that was not walked**. **The HARVEST is not complete, and the gap is substantive rather than clerical**: PROTOCOL §7 makes the harvest a **five-agent** act at every `SO-`, and **four of the five persistent-journal agents have never harvested** — `architect_docs_lead`, `rtl_lead`, `auditor`, `orchestrator` have no note and no commission. Six of the instantiated block's eleven boxes cannot be checked in consequence, four of them being the orchestrator's own later acts |
| **SC-13** | evidence reproduces at the sign-off SHA; the journal entry carries the commands | **MET** | §2.9 and `J-dv_lead-0165` Evidence. Every command in this packet's evidence sections runs from a checkout at `2183d71`; the two that cannot (the suite, the co-simulation) are cited as **CI run and job ids with their conclusions** and are marked as such; the scratch trees of round 1R are declared ephemeral (ADR-0003/F5) |
| **SC-14** | the verdict is one token | **MET** | §8 carries **`FAIL`** and nothing else. No qualifier, no reservation, no *"subject to"* |

**The two failures are stated at §8 with the act each needs, and neither is a defect in
the module.** `SC-2`'s failure is a DV-seat delivery that no step of §7.1 ever
scheduled; `SC-12`'s is a programme-cadence gap four other seats own. **Neither routes
to rtl_lead and neither is an escalation** (charter §7).

**Why neither is written as a bound inside a `PASS`, stated because that is the
tempting move and it is the one this packet's own §0.0 was built to refuse.** SC-14
admits a bound only for *"everything the module has not earned"*. Clause (c) of SC-2 is
not something the module has not earned — it is an act of mine that has never been
performed in one hundred and sixty-five entries. SC-12's gap is not something the
module has not earned — it is four other agents' spans, unmined. **Re-reading either as
administrative, after seeing that it is the thing standing between this packet and a
`PASS`, would be the author discharging a condition by declaring it discharged** —
`RV-C4` §9's defect, committed inside the document whose §0.0 quotes it.

### 1.2 THE RE-READ — the fourteen again, at `14615f8` (round 3, `J-dv_lead-0167`)

**§8.2 fixed the terms of this round in advance and they are honoured literally**:
*"When both are done, this packet is re-issued with its verdict re-read against §1 —
not amended in place. **Every** criterion is re-checked, because a criterion satisfied by
a later act is satisfied at a later SHA."* So all fourteen are re-read here; §1.1's
round-2 table is left **unedited** beside this one, including the two rows this round
moves or re-affirms.

**THE IDENTITY THIS RE-READ RESTS ON, MEASURED FIRST BECAUSE EVERY "UNMOVED" ROW BELOW
DEPENDS ON IT.** Eleven paths changed `2183d71..14615f8` and **none of them is a census
producer**:

```
$ git diff --name-only 2183d71..14615f8
  agents/handoffs/SO-xgmii_rx_64.md · agents/handoffs/WO-0079_m03-traceability-test-rows.md
  agents/journals/{architect_docs_lead.v02,.v03, auditor.v02, dv_lead.v08,
                   orchestrator.v02, rtl_lead, workers/data_wrangler, workers/tb_writer.v03}
  docs/specs/traceability.md
$ for p in test tools libs test/cosim docs/reports/audit docs/specs/requirements.md \
           docs/specs/modules/xgmii_rx_64.md test/attack_plans/AP-xgmii_rx_64.md; do
      [ "$(git rev-parse 2183d71:$p)" = "$(git rev-parse 14615f8:$p)" ] && echo "$p IDENTICAL"; done
  test IDENTICAL          tools IDENTICAL         libs IDENTICAL
  test/cosim IDENTICAL    docs/reports/audit IDENTICAL
  docs/specs/requirements.md IDENTICAL
  docs/specs/modules/xgmii_rx_64.md IDENTICAL (333482659f8f)
  test/attack_plans/AP-xgmii_rx_64.md IDENTICAL (03cc7e7da6f2)
```

**Three dimensions on that claim (§0.2, SC-10).** **SHA**: measured at `14615f8`, not
carried. **DOMAIN**: `test/` includes `test/cosim/` and `test/attack_plans/`, so the
identity covers **every producer that drives the DUT**, not the bench directory alone —
`FINDING WO-0077-A1`'s rule applied to the identity itself. **POLARITY**: the negative
half — *no RTL, no plan, no spec-of-record, no audit manifest moved* — is measured over
the **complete** changed-path list above, not over the paths I expected to be stable.
**Consequence, stated rather than left implicit**: every criterion whose subject is the
suite, the plan, the module or the anchor is re-*measured* below at a new run id, and
its **subject** is provably the same artefact the round-2 row scored.

| # | criterion | round 2 at `2183d71` | **round 3 at `14615f8`** | what moved, and where it is measured |
|---|---|---|---|---|
| **SC-1** | attack-plan precedence + status inventory MEASURED | MET | **MET** | **Unmoved, and re-measured rather than carried.** `AP-M03` blob identical; `git merge-base --is-ancestor df3e474 026a71f` exits **0**, 49 commits. Status-cell pass re-run at `14615f8`: **78 / 62 `ASSERT` / 7 `NO-ASSERT` / 4 `NO-STIMULUS` / 4 `STRUCTURAL` / 1 `GAP`** — identical to §2.1-M cell for cell. Suite inventory **59** M03 units, **139** repo-wide file-type-scoped, **141** contaminated (`FINDING M-4` unmoved and unrepaired) |
| **SC-2** | REQ hooks mapped; spec-derived; **test-side rows delivered** | **NOT MET** | **MET** | **THE ROW THIS ROUND MOVES. §2.8-R.** Clauses (a)/(b) unmoved on identical blobs (35 tokens in SPEC-M03 §10, 34 hooks, `REQ-010` the cross-reference). **Clause (c) is PAID and I measured it at the matrix, not at the dispatch**: `docs/specs/traceability.md` at `14615f8` carries **110 rows / 34 populated / 76 empty / 13 `COVERED` / 97 `OPEN`**; a cell-for-cell string comparison of `WO-0079` §3's 34 `(Test(s), Status)` pairs against the file returns **0 mismatches, 0 rows populated that were not delivered, 0 delivered rows absent**; the 34 rows whose cells changed are **exactly** the delivered set and **every one of them was empty and `OPEN` before**. Independence re-checked over the delivering round's own chain |
| **SC-3** | suite green **and** tree clean at the sign-off SHA, **on a run id** | MET | **MET** | **Re-measured at the NEW sign-off SHA, because SC-3's subject is the SHA the verdict is signed at.** `build` run **`31449924111`**, job **`93651991502`**, `head_sha` `14615f8`, conclusion **`success`** — **all 13 steps `success`**, including step 6 *"Run tests"*, step 8 *"Verify nothing was left unpromoted or non-deterministic"* and step 9 *"DV mechanical checks"*. `cosim` job **`93651991568`**, `success`, **stated separately and load-bearing for nothing outside the classes it drove**. `journal-check` run **`31449924167`**, `success`. `git status --porcelain` at `14615f8`: **zero lines**. Bound unchanged: `dune runtest` cannot run in this container (ADR-0005), which is why the run id is the evidence. **And one red run is named rather than left for a reader to find — §2.9-R** |
| **SC-4** | line-rate stress green, zero rx backpressure | MET | **MET** | **Subject byte-identical, evidence re-taken.** `M03-L1`'s 10 000 consecutive 64-octet frames are the same unit at the same bytes; green in run **`31449924111`** step 6. Backpressure discharge unchanged and still **structural** (`M03-L6`, no `tready` exists). Pinned constants `M03-L2` / `-L3` / `-L5` unchanged; `AP-M03` §7 bar 3 still makes them the only uniform-word-delay detector |
| **SC-5** | mutations killed N/N, five columns, non-kills named | MET | **MET** | **Unmoved, and the negative half is measured**: `docs/reports/audit/` is **byte-identical** across the interval, so **no manifest was authored and no campaign ran** — there is no new class to kill and none to fold. Era tally stands at **63 sealed / 61 killed / 1 survived / 0 green-by-blindness / 1 void**, pre-class era **15 of 15**, survivor `G-c4` measured dead at run `30852220315` |
| **SC-6** | the anchor stated **per class**, never per module | MET | **MET** | **Unmoved on an identical producer, re-observed on a new job.** `test/cosim/` byte-identical and `docs/specs/requirements.md` byte-identical, so REQ-901's class list and the lane's stimulus are the same; `cosim` job **`93651991568`** `success` at `14615f8`. §2.3-M's per-class cells stand; **the packet still states in terms that the charter §3 anchor is UNDISCHARGED as a module-level anchor**, and **no sentence of the form *"the co-simulation anchors this module"* appears anywhere in this file, round 3's text included** |
| **SC-7** | the four bars restated and honoured in every sentence | MET | **MET** | §5 unchanged. **Round 3 adds text and the bars bind it too**: §5.8-R lists the four sentences this round declined to write and the bar that forbade each |
| **SC-8** | unreachable-instrument register published | MET | **MET** | §2.6, unmoved: `U-1` … `U-5` and `DECLARATION WO-0074-D1`, each with its consequence |
| **SC-9** | open `BUG-`s listed, or **none**, measured | MET | **MET** | Re-measured over `agents/handoffs/BUG-*.md` at `14615f8`: **three packets, three CLOSED, none open** (`BUG-0001` FIX CONFIRMED; `BUG-0002` **ACCEPT — CLOSED** at `fafb83d`; `BUG-0003` **FIX ACCEPTED — CLOSED**). **Recalled from nothing; the directory is the domain** |
| **SC-10** | every set claim carries SHA, domain and polarity | MET | **MET** | The identity block above carries all three explicitly; §2.8-R's comparison states its domain (the 34 delivered pairs **and** the 76 undelivered rows, so the negative half is measured); §4.9 states the domain of the harvest claim as **the five persistent-journal chains**, and its polarity — *which boxes cannot be checked* — over **every** box, not the ones I expected to fail |
| **SC-11** | the owed ledger paid in the declared order | MET | **MET** | **§3.11.** Both acts §8.2 named are paid **before** the criteria that read them, not inside the round that grades them — act 1 landed at `a43ac00`/`14615f8`, two and one commits before this read; act 2's four notes landed at `185ae66`, `d53d795`, `54b2553`, `c55c754`. **`FINDING SO-6` is minted by this round**, and SC-11's own remedy for a late-arriving obligation is *a finding*, recorded with a carrier — which §3.11 does |
| **SC-12** | the first lessons harvest is **complete**, every box checked | **NOT MET** | **NOT MET** | **THE ROW THIS ROUND FAILS ON, and the ground is new. §4.9.** Round 2 failed it because four of five spans were unmined; **all four are now mined and three of the four notes are conformant**. It fails now because **the block's boxes 2, 3 and 4 cannot be checked at the orchestrator's row**: of its **18** banked candidates, **0** discharge **LH3**, **0** carry a stated LH2 grade, and the note nowhere states the classifier was run from the most general honest statement. PROTOCOL §7's own admissibility sentence makes LH1+LH2+LH3 the condition of a candidate being admissible at all. **Measured at the journal, not inferred from a dispatch** |
| **SC-13** | evidence reproduces at the sign-off SHA | MET | **MET** | Every command in §1.2, §2.8-R and §4.9 runs from a clean checkout at `14615f8`; the four CI facts are **externally verifiable references** (run id, job id, conclusion) and are marked as such (ADR-0003/F5); `J-dv_lead-0167` carries all of them in Evidence |
| **SC-14** | the verdict is one token | MET | **MET** | §8 carries **`FAIL`** and nothing else. The round-2 token is **quoted** beneath it, which is a retrospective reference to a verdict already in history and not a second live token |

**THIRTEEN MET, ONE NOT MET.** The one is `SC-12`, and **§8's token is `FAIL` because
of it and of nothing else**.

**What this re-read refused to do, said here because it was available and cheap.**
`SC-12`'s remaining failure could have been dissolved three ways: by reading the
orchestrator's eighteen statements as *implying* their own failure modes; by ruling the
harvest complete on a four-of-five substance and calling the fifth clerical; or by
declaring — after a round in which two named acts were both delivered — that the
criterion had been *substantially* met. **All three are the same move**, and it is the
one §0.0 exists to refuse. **The bar that convicted nine of my own candidates into war
stories, sixteen of rtl_lead's, nine of architect_docs_lead's and five of the auditor's
is the bar the eighteen are read against**; applying a softer one to the seat that
dispatches me would make the bar a function of who is being graded.

### 1.3 THE `SC-12` READING — settled by amendment, applied here, and NOT decided here

> **DATED ANNOTATION, 2026-08-11, `J-dv_lead-0168`.** §1's `SC-12` block quote is the
> **draft's** text and is left **UNEDITED**, exactly as §1.1 and §1.2 are. This section is
> the reading, written beside it. **No word of `SC-12` is changed by this packet.**

**Round 3 fixed this round's obligation in advance and the words are its own**: *"A
re-verdict round that finds `SO-6` paid must settle it before it can write `PASS`, **and
it must settle it by amendment, not by reading**"* (§8.0.2). **It is settled, and not by
me.** `ADR-0018` **Amendment A2** landed at `85753b6` under PROTOCOL §11, authored by
architect_docs_lead (`J-architect_docs_lead-0036`) and **in force at `41fead6`** on the
acceptance act A2.0 names — the orchestrator's `J-orchestrator-0235`, commit `41fead6`.
**I am the requester, not the author and not the acceptor** (A2.0 quotes my request from
`J-dv_lead-0167` Open-questions item 1 verbatim), which is the property that makes this
section an application rather than a self-service.

**WHAT A2 DECIDED, in the three lines that reach `SC-12`.**

1. **The impossibility was not in my criterion.** A2.1 measured the two sentences and
   found that PROTOCOL §7's box condition is **gate-only**, and that the clause extending
   it to sign-offs lives at `docs/gates/lessons-harvest-block.md` **line 5** — *"A gate is
   not passed, **and a module sign-off is not complete**, while any box in the
   instantiated block is unchecked (PROTOCOL §7)"* — where the parenthesis cites a source
   that does not contain the clause. `SC-12` quoted the block in good faith and inherited
   the over-reach. **The correction is upstream of me and I did not have to be right for
   it to land.**
2. **The eleven boxes partition 7 / 4** (A2.2), and the four are exactly the four
   `FINDING SO-5` enumerated. **A2-D1: an `SO-` instantiates Part A only**, and carries
   Part B as a **named deferral line naming the gate that owes it** — never as boxes.
   **A2-D2: a gate still instantiates all eleven**, PROTOCOL §7 unchanged behind it.
   **A2-D3: an `SO-`'s Part A check does not discharge the gate's.**
3. **A2 deliberately did not restate `SC-12`** (A2.3, and A2.9's third bullet: *"`SC-12`'s
   own text … dv's document, dv's ruling"*). It supplies the partition and stops.

**THE READING, therefore, in one sentence, and it changes a count of boxes and not a
count of failures.**

> **`SC-12`'s clause *"instantiated in this packet with every box checked"* is read as
> *every box the block gives a sign-off* — Part A's seven — with Part B carried as
> A2-D1's named deferral line.** The criterion's subject is unchanged: **the harvest's
> MINING must be complete, at all five seats, and the packet must instantiate and check
> it.** The word *complete* in §4.2/D5's **collation** sense is a gate-time property that
> no packet in any state of the world can carry (A2.3's own words), and it was never the
> thing `SC-12` could have been measuring.

**WHY THIS IS NOT THE MOVE §0.0 EXISTS TO REFUSE, tested rather than asserted, because it
is precisely the shape of the move.** Four checks:

1. **It does not flip today's token by itself.** A2.0(3) states the test and A2.3 measures
   it: at `14615f8` the three boxes that failed were **all in Part A**, so this reading
   applied at `14615f8` still yields `NOT MET`. **What moves `SC-12` is the successor note
   at `b4814b0`, which is a measurement (§4.10), not a reading.** A reading that cannot
   change a verdict on its own is not the instrument of a discharge-by-declaration.
2. **The author of the reading is not the graded party.** A2.0(2) is explicit that a
   countersignature from me would *"re-admit that seat to the decision §4.9 declined to
   make"*. I did not sign A2, I am not asked to, and I could not have blocked it: A2.0
   chose acceptance route (a) and states that **a contest does not suspend A2**.
3. **The obligation to settle it by amendment was written when it cost me a `FAIL`.**
   Round 3 could have ruled the four boxes out of the criterion, taken the `PASS`, and
   nobody would have had to read a second document. It ruled the opposite, in writing, at
   the cost of the token — **and this round is bound by that text, not released by it.**
4. **I contest nothing, and I say so, because silence would be ambiguous.** A2.0 names the
   contest route — a finding in the contesting seat's own artefact, carried to an
   Amendment A3. **I raise none.** A2's partition is the four-and-seven I asked for, its
   diagnosis is better than mine (my finding blamed my own criterion; A2 found the defect
   one hop upstream and did not spare its own file), and it left the five-seat obligation
   and every LH criterion untouched — which is the half of `FINDING SO-5` that mattered.

**WHAT THE BLOCK FILE SAYS AT `41fead6`, stated because a reader will check it and find
the old sentence.** `docs/gates/lessons-harvest-block.md` is **byte-identical** across
`14615f8..41fead6` (`df304360eb39`) and still carries line 5's over-reach: **A2.4's five
clerical edits are OWED**, their text fixed at A2.4, **carrier: the architect's next
`docs/gates/` round** — the `P1-module-ready` checklist round already owed. **The
partition is nonetheless in force ahead of that edit, on the block's own authority**: the
block states twice that it is the short form and ADR-0018 is the normative text (§2,
§2.1), so a short form disagreeing with its normative text is **stale, not governing**
(A2.4). **I read `SC-12` against the ADR as amended, and I say which file I read and why,
rather than letting a reader assume I read the stale one.** The gate file is outside my
write scope (PROTOCOL §6) and I stage nothing toward it.

### 1.4 THE RE-READ — the fourteen a third time, at `41fead6` (round 4, `J-dv_lead-0168`)

**Same discipline as §1.2 and for the same reason**: a criterion satisfied by a later act
is satisfied at a **later SHA**, so all fourteen are re-read, and §1.1's and §1.2's tables
are left **unedited** beside this one — including the two rows this round moves.

**THE IDENTITY THIS RE-READ RESTS ON, MEASURED FIRST.** **Five** paths changed
`14615f8..41fead6` and **none of them is a census producer, a spec, a plan, a matrix, an
audit manifest, a gate file, the constitution or a charter**:

```
$ git diff --name-only 14615f8..41fead6
  agents/handoffs/SO-xgmii_rx_64.md
  agents/journals/{architect_docs_lead.v03, dv_lead.v08, orchestrator.v02}
  docs/adr/ADR-0018-the-harvest-is-a-cadence-not-an-event.md
$ for p in test tools libs test/cosim test/attack_plans docs/reports/audit \
           docs/specs/requirements.md docs/specs/modules/xgmii_rx_64.md \
           test/attack_plans/AP-xgmii_rx_64.md docs/specs/traceability.md \
           agents/PROTOCOL.md docs/gates/lessons-harvest-block.md \
           agents/charters/dv_lead.md; do
      [ "$(git rev-parse 14615f8:$p)" = "$(git rev-parse 41fead6:$p)" ] && echo "$p IDENTICAL"; done
  test IDENTICAL (9a8871c89d36)      tools IDENTICAL (eebfccde25dd)
  libs IDENTICAL (9714f32260c5)      test/cosim IDENTICAL (9c8125280a5c)
  test/attack_plans IDENTICAL (af79ab920296)
  docs/reports/audit IDENTICAL (0f573595b9ef)
  docs/specs/requirements.md IDENTICAL (405ad8d7fb6a)
  docs/specs/modules/xgmii_rx_64.md IDENTICAL (333482659f8f)
  test/attack_plans/AP-xgmii_rx_64.md IDENTICAL (03cc7e7da6f2)
  docs/specs/traceability.md IDENTICAL (648311e10ccc)
  agents/PROTOCOL.md IDENTICAL (6bd8ade4b74b)
  docs/gates/lessons-harvest-block.md IDENTICAL (df304360eb39)
  agents/charters/dv_lead.md IDENTICAL (b70ef37831d9)
```

**Three dimensions on that claim (§0.2, SC-10).** **SHA**: measured at `41fead6`, not
carried, and not taken from the dispatch's description of the interval. **DOMAIN**:
`test/` is stated **entire** — `test/cosim/` and `test/attack_plans/` included — so the
identity covers **every producer that drives the DUT** (`FINDING WO-0077-A1`'s rule
applied to the identity itself), and it additionally covers the four governing documents
a reader might suspect of having moved under the criterion: the constitution, my charter,
the gate block and the matrix. **POLARITY**: the negative half — *no RTL, no test, no
tool, no plan, no spec, no matrix, no audit manifest, no gate file, no protocol byte and
no charter byte moved* — is measured over the **complete** five-path changed list, not
over the paths I expected to be stable. **The one governing document that DID move is
`docs/adr/ADR-0018…`, and its move is this round's own subject** (§1.3) — stated rather
than buried, because a round that re-reads a criterion against an amended rule owes the
reader the amendment's landing in the same breath as the identity that says nothing else
moved.

| # | criterion | rd 2 `2183d71` | rd 3 `14615f8` | **rd 4 `41fead6`** | what moved, and where it is measured |
|---|---|---|---|---|---|
| **SC-1** | attack-plan precedence + status inventory MEASURED | MET | MET | **MET** | **Unmoved, and re-measured a third time rather than carried.** `AP-M03` blob identical (`03cc7e7da6f2`); `git merge-base --is-ancestor df3e474 026a71f` exits **0**, `git rev-list --count` = **49**. Status-cell pass re-run at `41fead6`: **78 rows / 62 `ASSERT` / 7 `NO-ASSERT` / 4 `NO-STIMULUS` / 4 `STRUCTURAL` / 1 `GAP`** — identical to §2.1-M and to §1.2's re-run, cell for cell. Suite inventory **59** M03 units, **139** file-type-scoped, **141** contaminated (`FINDING M-4` unmoved, unrepaired). §2.12(1) |
| **SC-2** | REQ hooks mapped; spec-derived; test-side rows delivered | **NOT MET** | MET | **MET** | **Subject byte-identical, and re-measured anyway.** `docs/specs/traceability.md` is identical `14615f8..41fead6` (`648311e10ccc`), and the parse re-run at `41fead6` returns **110 rows / 34 populated / 76 empty / 13 `COVERED` / 97 `OPEN`** — the same figures §2.8-R measured against `WO-0079` cell for cell. **Independence re-checked for THIS round**: no `libs/**`, `top/**` or `rtl_snapshots/**` path was opened, and `top/` does not exist in the tree at either SHA. §2.12(3) |
| **SC-3** | suite green **and** tree clean at the sign-off SHA, **on a run id** | MET | MET | **MET** | **Re-measured at the NEW sign-off SHA, because `SC-3`'s subject is the SHA the verdict is signed at.** `build` run **`31453108454`**, job **`93661268366`**, `head_sha` `41fead6…`, conclusion **`success`** — **all 13 steps `success`**, including step 6 *Run tests*, step 8 *Verify nothing was left unpromoted or non-deterministic*, step 9 *DV mechanical checks*. `cosim` job **`93661268386`**, **`success`**, stated **separately** and load-bearing for nothing outside the classes it drove. `journal-check` run **`31453108435`**, **`success`**. `git status --porcelain` at `41fead6`: **zero lines**. Bound unchanged: `dune runtest` cannot run in this container (ADR-0005), which is why the run id is the evidence. **And the whole interval is walked, not just the endpoints — §2.9-R2** |
| **SC-4** | line-rate stress green, zero rx backpressure | MET | MET | **MET** | **Subject byte-identical (`test/` = `9a8871c89d36`), evidence re-taken at a new run.** `M03-L1`'s **10 000** consecutive 64-octet frames are the same unit at the same bytes; green in run **`31453108454`** step 6. Backpressure discharge unchanged and still **STRUCTURAL** (`M03-L6` — no `tready` exists on the stream under test, REQ-112/REQ-003), which is a listed bound of this `PASS` (§8.R4.4). Pinned constants `M03-L2` / `-L3` / `-L5` unchanged; `AP-M03` §7 bar 3 still makes them the programme's only uniform-word-delay detector |
| **SC-5** | mutations killed N/N, five columns, non-kills named | MET | MET | **MET** | **Unmoved, and the negative half is measured**: `docs/reports/audit/` is **byte-identical** (`0f573595b9ef`), so **no manifest was authored and no campaign ran** in the interval — no new class to kill and none to fold. Era tally stands **63 sealed / 61 killed / 1 survived / 0 green-by-blindness / 1 void**; pre-class era **15 of 15** with `D-M3` excluded as an equivalent mutant; survivor **`G-c4`** named, its defect measured dead at run `30852220315`. **The survivor column stays 1 and is a listed bound** (§8.R4.4) |
| **SC-6** | the anchor stated **per class**, never per module | MET | MET | **MET** | **Unmoved on identical producers, re-observed on a new job.** `test/cosim/` and `docs/specs/requirements.md` both byte-identical, so REQ-901's class list and the lane's stimulus are the same artefacts §2.3-M scored; `cosim` job **`93661268386`** `success` at `41fead6`. **The packet still states in terms that the charter §3 anchor is UNDISCHARGED as a module-level anchor** (§2.3-M, §5.1, and §8.R4.4 carries it as the first listed bound). **The barred sentence appears nowhere as an assertion** — grep-checkable and grep-checked: **4** occurrences of the phrase in this file, **all four inside a statement of the prohibition itself** (§0.1 item 2, §1.1's SC-6 row, §1.2's SC-6 row, §5.1 item 1), **and round 4 adds none** |
| **SC-7** | the four bars restated and honoured in every sentence | MET | MET | **MET** | §5 unchanged. **Round 4 adds text and the bars bind it too**: **§5.8-R2** lists the five sentences this round declined to write and the bar that forbade each — including the two the `PASS` itself made available for the first time |
| **SC-8** | unreachable-instrument register published | MET | MET | **MET** | §2.6, unmoved on a byte-identical plan: `U-1` … `U-5` and `DECLARATION WO-0074-D1`, each with its consequence — *a coverage claim counting such an assertion has counted one observation twice*. **Carried into the `PASS` as a listed bound** (§8.R4.4) |
| **SC-9** | open `BUG-`s listed, or **none**, measured | MET | MET | **MET** | Re-measured over `agents/handoffs/BUG-*.md` at `41fead6`: **three packets, three CLOSED, none open** — `BUG-0001` **FIX CONFIRMED**, `BUG-0002` **ACCEPT — CLOSED**, `BUG-0003` **FIX ACCEPTED — CLOSED**, each string read out of its own packet. **The domain is the glob and the claim is an absence**, recalled from nothing. §2.12(4) |
| **SC-10** | every set claim carries SHA, domain and polarity | MET | MET | **MET** | The identity block above carries all three explicitly and names the four governing documents it additionally measured; §2.9-R2's CI claim states its domain as **every run on the branch in the interval** and its polarity as *no red on `build` or `journal-check`*, measured over the complete run list rather than over the runs I expected; §4.10's harvest claims state their domain as **the five persistent-journal chains** and their polarity over **every** box. **§2.12 collects the round's three-dimension record** |
| **SC-11** | the owed ledger paid in the declared order | MET | MET | **MET** | **§3.12.** Both acts §8.0.2 named landed **before** this round could read them — `b4814b0` (the successor note) and `85753b6` + `41fead6` (the amendment and its acceptance) — so neither was paid inside the round that grades it. **`FINDING SO-6` DISCHARGED** by the carrier it named; **`FINDING SO-5`'s wording half SETTLED BY AMENDMENT**, the disposition `SC-11`'s own machinery required. **One new item enters the standing set with its carrier named** — A2.4's five clerical gate-file edits, carrier the architect's next `docs/gates/` round — and it is **not mine**, which is why it is carried and not paid |
| **SC-12** | the first lessons harvest is **complete**, every box checked | **NOT MET** | **NOT MET** | **MET** | **THE ROW THIS ROUND MOVES, and it moves on a measurement plus a landed amendment. §4.10.** Read against the block **as amended by A2** (§1.3): a sign-off instantiates **Part A's seven boxes**, Part B is the named deferral line. **All seven are CHECKED at `41fead6`.** The three that failed in round 3 — boxes 2, 3, 4, **all of them Part A and none of them relieved by A2** — are paid by `J-orchestrator-0234` (`b4814b0`): **18 of 18 candidates now carry a stated `LH2-g` grade AND an LH3 clause naming a concrete failure**, the classifier is stated as run from step 0 on all eighteen, the ids `LC-orchestrator-H1-1 … -18` are unrenumbered, war stories keep their criteria and the worker-span nil is declared with its cause. **Counted mechanically at the journal, not read off the dispatch.** My own note's obligations under `SC-12`'s second half are discharged at `J-dv_lead-0168` — span as an entry-id interval under A2-D10, an explicit **nil** declared, worker spans **nil** declared |
| **SC-13** | evidence reproduces at the sign-off SHA | MET | MET | **MET** | Every command in §1.4, §2.12 and §4.10 runs from a clean checkout at `41fead6`; the CI facts are **externally verifiable references** (run id, job id, conclusion) and are marked as such (ADR-0003/F5); `J-dv_lead-0168` carries all of them in Evidence, including the mechanical counts over another agent's journal that §4.10 rests on |
| **SC-14** | the verdict is one token | MET | MET | **MET** | §8 carries **`PASS`** and nothing else. **No qualifier, no reservation, no *"subject to"*.** Everything the module has not earned is a **listed bound inside the `PASS`** at **§8.R4.4** — twelve of them, each naming what it bounds — which is what `SC-14`'s own second sentence requires of a `PASS`. Both prior tokens are **quoted** beneath it as retrospective references to verdicts already in history (PROTOCOL §10's carve-out), **and the file carries exactly one bare token**, verified by grep |

**FOURTEEN MET, NONE NOT MET.** **§8's token is `PASS`.**

**WHAT THIS RE-READ REFUSED TO DO, said here because §0.0 predicted this exact round.**
§1.2's closing note named the three ways `SC-12` could have been dissolved and refused all
three. **This round had a fourth temptation available, and it is the mirror image**: with
the two named acts paid and nothing else outstanding, the only way to keep a `FAIL` alive
was to **find a new ground** — and one was in reach. `OBSERVATION SO-O1` (§4.10) records
that **two of the orchestrator's eighteen statements carry a version-control tool noun
under a stated `LH2-g`**, which round 3 predicted almost exactly. **I did not convert it
into a box failure, and the reason is that round 3 already ruled it, in writing, when
ruling it cost me nothing**: *"None of that can be decided from outside the note: the
classifier is run by the miner … and a reader who re-grades another seat's statements has
become the selector the block's §4 forbids."* **A bar that a grader may raise at the last
obstacle is as much a function of who is being graded as one he may lower.** So the
observation is recorded, measured, given an owner and a route, and **not charged** —
§4.10.

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

#### 2.1-M MEASURED AT `2183d71` (§7.1 step 6) — the census holds, and the domain dimension moves it

**Command, and it is the changed script** (`RN-6`'s resolver landed at `2183d71`;
§3.2's ordering consequence honoured — the census is taken **after** the tool changed,
not before):

```
$ bash tools/dv_checks.sh
```

**THE ROW CENSUS — MEASURED, not carried.** Status-cell pass over every row table of
`test/attack_plans/AP-xgmii_rx_64.md` at `2183d71`:

```
$ awk -F'|' '/^\| \*\*M03-[A-Z]+[0-9]+\*\* \|/ { id=$2; gsub(/[* ]/,"",id);
      st=$(NF-1); gsub(/[* `]/,"",st); print id"\t"st }' \
    test/attack_plans/AP-xgmii_rx_64.md | sort | cut -f2 | sort | uniq -c
```

| quantity | measured at `2183d71` | carried figure | difference |
|---|---|---|---|
| rows declared | **78** | 78 | none |
| `ASSERT` | **62** | 62 | none |
| `NO-ASSERT` | **7** | 7 | none |
| `NO-STIMULUS` | **4** | 4 | none |
| `STRUCTURAL` | **4** | 4 | none |
| `GAP` | **1** (`M03-O2`) | 1 | none |
| ASSERT rows discharged | **62 of 62; outstanding set EMPTY** | 62 of 62 | none |
| M03 suite inventory | **59** units | 59 | none |
| repository-wide, file-type scoped | **139** | 139 | none |
| repository-wide, contaminated matcher | **141** | *140* | **+1 — the measurement governs** |

**THE DOMAIN DIMENSION, APPLIED TO THE CENSUS ITSELF, AND IT MOVES A NUMBER
(`FINDING WO-0077-A1`'s rule, turned on my own instrument).** `tools/dv_checks.sh`
scopes its title pass to **`test/xgmii_rx_64/*.ml`** — **one producer directory**. Run
over **every tracked `test/**/*.ml`**, the boundary matcher returns **63**, not 62. The
extra row is **`M03-N3`**, named in a unit title at
`test/xgmii/test_idle_injection.ml:168` (*"X-4: the M03-N3 constraint refuses one
boundary per frame"*) — a **`NO-STIMULUS`** row named by a harness unit outside the
bench directory.

> **`FINDING SO-2` (MINOR, mine, against my own census block).** The row-discharge
> census is a universal over *"unit titles"* measured over one producer directory, and
> its printed provenance does not say so. **The conclusion is invariant** — `M03-N3` is
> `NO-STIMULUS`, so the ASSERT-row discharge set is **62 of 62 under either domain** —
> but the count a reader would quote is domain-dependent and the block does not warn
> them. **Disposition**: recorded here with both figures; the repair (printing the
> producer set beside the count) rides the next round that opens `tools/`, and **no
> figure in this packet is quoted without its domain**.

**The two declared adjustments, re-checked rather than inherited**: the ASSERT rows
**not** named in any title are exactly `{M03-F5}` — discharged **by citation** at
`test/xgmii_rx_64/test_m03_f.ml:811`, *"M03-F5 — DISCHARGED BY CITATION, not built
(WO-0047 §3.3)"* — and the titled rows that are **not** `ASSERT` are exactly
`{M03-A4 (NO-ASSERT)}` in the bench domain, `{M03-A4, M03-N3 (NO-STIMULUS)}` in the
wide domain. **Both adjustments are judgements and both are shown, not asserted.**

**`FINDING M-4` re-measured, and the contaminated figure MOVED while the honest one did
not.** `grep -rh 'let%expect_test' test/ | grep -c .` → **141**;
`grep -rh --include=*.ml …` → **139**. The two contaminating files are
**`test/cosim/dune`** (1) and **`test/attack_plans/AP-xgmii_rx_64.md`** (1). The draft
carried **140**. **The measurement governs and the difference is a finding** — and it is
the most economical possible demonstration of why `M-4` matters: *the number that is
wrong is the one that moved.* `M-4` stays **unrepaired**, carrier unchanged.

**THE 22-ASSERTION BREADTH FIGURE — RE-MEASURED, DOES NOT REPRODUCE, AND THE DIRECTION
OF THE ERROR IS THE USEFUL PART.**

`AP-M03` §4.J states *"The three J units carry **22 DUT-observable assertions**; this
campaign's five classes reached **7** … **Fifteen are probed by nothing here**"*,
carried from `a8d6140` §8 and flagged as the one figure of that round not re-derived.

**Counting rule, stated because the figure is not reproducible without one**: an
assertion site is a `fail`-raising site or an `assert_monitors_clean` call **inside one
of the three J units' own bodies**, whose subject is a **DUT output** — a delivered
word, a strobe, a monitor fed from delivered words. **Excluded**: sites in the shared
stimulus helper (pre-DUT), sites whose subject is the *schedule* rather than the design,
and the two `s.enable` read-backs, whose subject is a **bench-driven** value.

```
$ sed -n '165,258p;275,364p;385,573p' test/xgmii_rx_64/test_m03_j.ml \
    | grep -c '^\s*fail\b\|fail row'            -> 35
$ sed -n '165,258p;275,364p;385,573p' test/xgmii_rx_64/test_m03_j.ml \
    | grep -c 'assert_monitors_clean'           ->  5
```

35 − **9** stimulus-integrity sites (all in `run_j3`: `is_clean`, frame count, lane,
`start_cycle0`, `terminate_cycle0`, `terminate_lane0`, `start_cycle1`, the change
cycle's position, the change cycle's start lane) − **2** enable read-backs + **5**
monitor assertions = **29**.

| | carried | measured at `2183d71` |
|---|---|---|
| DUT-observable assertions in the three J units | 22 | **29** |
| reached by the campaign's five classes | 7 | **7** (unchanged, and each is in the measured set) |
| probed by nothing in that campaign | 15 | **22** |

> **`FINDING SO-3` (MATERIAL, mine, against `AP-M03` §4.J's carried figure).** The
> figure does not reproduce. **The denominator was UNDERSTATED by seven**, so the
> breadth the campaign bought was **smaller** than the figure said, not larger.
> **`AP-M03` §4.J's conclusion — *"Five kills at four units is not breadth"* — survives
> a fortiori and is strengthened by the correction.** **Disposition**: the packet
> quotes **7 of 29 under the rule above**, never *22*; `AP-M03` §4.J's figure is
> **superseded by this measurement** and its repair rides the next `AP-` opener, which
> is not this round (`J-dv_lead-0112`: a plan round is not where a carrier is
> improved, and an `SO-` round is not a plan round). **Ledger item 11 is closed by
> re-measurement, which is one of the two outcomes §3 authorised for it.**

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

#### 2.2-M MEASURED AT `2183d71` (§7.1 step 6) — the tally re-walked, and the survivor's defect is dead at a run id

**Method: the tally is re-derived by walking the campaign verdicts, never quoted from
the last one.** Each campaign's own era table is read at its own packet:

> **DATED ANNOTATION, 2026-08-11, `J-dv_lead-0187` — `FINDING REC-1`'s cure (MINOR,
> materially void, mine, filed at `J-dv_lead-0184`). The method sentence above stands
> UNEDITED and is corrected here, not rewritten.** **The claim is broader than the
> method this block performed**: the walk covered **three campaigns of ten**, and the
> table's own first row — the **41** entering family M — is **quoted**, from `WO-0074`
> §12, which quotes it in turn, so the sentence's *"never quoted from the last one"* is
> false of the row directly beneath it. **The seven-campaign figure was first derived
> campaign by campaign at `J-dv_lead-0184`** — `8 + 5 + 7 + 9 + 1 + 6 + 5 = 41` sealed
> and `8 + 4 + 7 + 9 + 1 + 6 + 5 = 40` killed, from each campaign's own committed
> verdict — **after** this block was written; **the figure is correct and no column
> moves**, so this corrects a method claim and not a number.

| step | source | sealed | killed | survived | green-by-blindness | void |
|---|---|---|---|---|---|---|
| era entering family M | `WO-0073-VERDICT`, quoted at `WO-0074` §12 | 41 | 40 | 1 | 0 | 0 |
| **+ family M** (`WO-0074` §12) | `WO-0074` §12's own table | +8 | +7 | +0 | +0 | **+1** |
| after family M | | 49 | 47 | 1 | 0 | 1 |
| **+ family J** (`WO-0076` §12) | `WO-0076` §12's own table | +5 | +5 | +0 | +0 | +0 |
| after family J | | 54 | 52 | 1 | 0 | 1 |
| **+ family K/N** (`WO-0077` §12) | `WO-0077` §12's own table | +9 | +9 | +0 | +0 | +0 |
| **ERA AT CLOSE** | | **63** | **61** | **1** | **0** | **1** |

**61 + 1 + 0 + 1 = 63.** The ceiling of 61 was fixed **before** the last campaign ran
(`WO-0077` §14) and is reached exactly.

**THE DOMAIN OF THE TALLY, WHICH THE CARRIED FIGURE DOES NOT STATE AND SC-10 REQUIRES.**
Every one of those tables says *"class-based, `WO-0050` onward"*. **The five columns
quantify over the TEN class-based campaigns** — `WO-0050`, `0055`, `0058`, `0061`,
`0063B`, `0066`, `0073`, `0074`, `0076`, `0077` — **and over no other.** **Four earlier
campaigns exist and are outside those columns**, scored in a different unit (the
mutation, not the class):

| campaign | scored |
|---|---|
| `WO-0039` — the first M03 campaign | **5 / 5 killed** |
| `WO-0041` — family D | **4 / 4** on the killable set; **`D-M3` ruled an EQUIVALENT MUTANT and excluded from the denominator**; one dv_lead prediction falsified and left standing in the freeze |
| `WO-0042` — family D mini-round | **`D-M6` KILLED, exact** — 2/2 required cells, both messages character-for-character as sealed |
| `WO-0045` — family E | **5 / 5 killed** |

**So the honest statement of SC-5's "N/N", with its domain, is two sentences and not
one**: *fourteen campaigns have been run against this module; the ten class-based ones
close at 63 sealed / 61 killed / 1 survived / 0 green-by-blindness / 1 void, and the
four earlier ones killed 15 of 15 with one equivalent mutant excluded from the
denominator by ruling.* **A single ratio over the fourteen does not exist and this
packet does not manufacture one.**

**THE SURVIVOR — `G-c4` — AND THE ONE THING ABOUT IT THAT WAS NEVER PUT IN THE TALLY.**

`G-c4` seeded *the `Discard` state not gated* and **survived all twenty-five units** at
`WO-0055`. `RV-0055-VERDICT` `FINDING G-2` established why, and the reason was a real
coverage gap in my own plan text rather than a seeding accident: `M03-G3` and `M03-G4`
place their injected character **100 octets past the truncation point**, i.e. content
index **1618**, where REQ-108's first epoch for a 1600-octet frame is **82 octets
wide** (indices 1518 … 1599). **An offset of 81 or less lands inside it; 100 overshoots
by nineteen.** The *"100 octets"* figure is `AP-M03` §4.G's own text, written by me at
`WO-0027`.

**`WO-0056` repaired it — `M03-G7` and `M03-G8` — and the repair was PROVED BY THE
MUTATION, not by the landing:**

> Branch `mut/wo-0056-gc4-replay` = `c95c9f4` = `e7657e3` + the **unmodified**
> `g-c4.diff`. **CI run `30852220315`**, `build` step `success`, **`runtest` RED** —
> **`M03-G8` alone, out of twenty-seven units**, on the exact assertion the row was
> written to make: *"expected exactly one strobe (error_oversize alone — NO
> error_bad_frame, §9's seventh ruling, C-12, in the epoch M03-G4's character never
> reaches), observed 2"*. `M03-G7` green, the five existing G rows green, as predicted
> in advance (`LIFT RULING`, `J-dv_lead-0075`).

**So the five columns and the defect's fate are two different facts and the packet
states both.** The tally's `survived` column stays at **1**, permanently and correctly:
*a campaign's score is what that campaign measured, and it is never retro-edited* — the
same rule that keeps `WO-0076`'s and `WO-0077`'s tables unedited. **And the defect
`G-c4` renders is dead at the bench as it stands at `2183d71`, measured on an unmodified
diff against a bench that had never seen it.** **Neither sentence may be quoted without
the other**: quoting only the column understates the suite; quoting only the replay
erases the campaign that found the gap.

**THREE BOUNDS THE REPLAY DOES NOT CARRY, lifted verbatim from `WO-0056` §4 so no
reader widens it:**

1. **`M03-G7` is benched but NOT mutation-qualified.** No mutation in any campaign has
   reddened it; the replay's diff is error-character-gated. **A start character in
   REQ-108's first epoch is driven and asserted, and nothing has yet proved the row
   would notice a defect there.**
2. **The `cosim` job went GREEN under the mutated design**, and that is the exclusion
   behaving as written, not a gap in it: `g-c4`'s defect fires only **after** REQ-108's
   truncation, and the anchor's stimulus never gets there. **This is the programme's
   one concrete demonstration — rather than argument — that a green co-simulation is
   not evidence about REQ-108.**
3. **Family G may now be cited for REQ-108's first-epoch behaviour under an error
   character, and for nothing wider.**

#### 2.2-D THE DISPOSITION TABLE — the `T-`/`M03-` naming-era mapping per class, measured at `49f04c0`

> **DATED ANNOTATION, 2026-08-11, `J-dv_lead-0187`.** This section is **NEW** and is
> written **beside** §2.2-M, which stands **UNEDITED**. **It is not a re-measurement of
> the era tally and it moves no column**: §2.2-M's `63 / 61 / 1 / 0 / 1` is a frozen
> measurement at `2183d71` and nothing here touches it. It discharges **one
> precondition** of one clause, and §2.2-D.6 names what it does **not** discharge.

**Why this table exists.** `ADR-0020` — **IN FORCE**, `PROTOCOL` §7 amended at `a76e485`,
status flipped at `f67a57a` — disposes a class killed in its own campaign by *"that
campaign's record **together with the named killing unit, present and green at the gate
SHA**"*. **`FINDING REC-7` (MAJOR, `J-dv_lead-0186`, filed by me against the limb I
myself offered)** measured that the unit names four of the ten class-era campaign
records carry **do not exist at the gate SHA**: `WO-0050`, `WO-0055`, `WO-0058` and
`WO-0061` name their killing units in the retired **`T-`** namespace, so a **literal**
application of the limb fails at every class of those four campaigns — *not because an
instrument was deleted, but because the record and the bench speak different
namespaces*. The cure REC-7 named is this table, and REC-7's own rule governs it:
**a class whose mapping cannot be established is a DISPOSITION FAILURE, not a
footnote.**

##### 2.2-D.1 Where this table lives, and why here rather than anywhere else

**Named, per the three candidates put to me.** It lives **here, in `SO-xgmii_rx_64.md`,
immediately beneath the tally it disposes** — not in a separate handoffs annex and not
in my journal. Four grounds, in order of force:

1. **`(b.1)` and `(b.2)` require the itemisation to sit *at the tally*** — *"each named
   **at the tally** with its ground"*, a movement I signed for at `J-dv_lead-0186` and
   which strengthens the clause precisely by refusing the split. A disposition table
   filed away from the tally it disposes is the defect that clause was redrafted to
   forbid.
2. **`docs/reports/audit/**` was never available to me.** `PROTOCOL` §6 gives that path
   to the auditor **exclusively** (`ADR-0003`); dv_lead may stage `test/**`, `tools/**`,
   `docs/reports/latency/**` and `agents/handoffs/**`. A table of mine under the
   auditor's tree is not a placement choice I could have made, and I record the ground
   rather than let the option look declined on taste.
3. **A new handoffs file would need a packet prefix and an orchestrator-allocated
   number** (`PROTOCOL` §3). Minting a packet id for a table whose whole content is a
   column of an existing packet's section buys a filename and costs the adjacency that
   makes the column readable.
4. **`J-dv_lead-0186` routed it to "my own packet"**, and this is it. **No file outside
   `agents/handoffs/**` and my own journal is written for this table**, so no
   confirmation was owed and none was sought.

##### 2.2-D.2 The mapping rule, and the two measurements that ground it

**The rule**: the retired label `T-<X><n>` and the present label `M03-<X><n>` denote the
same bench unit; the three **composite** retired labels (`T-A12`, `T-A34`, `T-C12`)
denote the three composite present units, each one `let%expect_test` head covering two
plan rows. **The rule is not asserted — it is measured, twice, at `49f04c0`:**

- **M1 — the `T-` namespace is not a bench namespace at this tree at all.** `grep -rn
  '"T-' test/` returns **zero** string literals, and **zero** of the 59
  `let%expect_test` heads under `test/xgmii_rx_64/` begin `T-`. **No mapping below can
  be a collision between two live namespaces**, because only one of the two is live.
  (**Four `T-` labels do survive as text under `test/`** — `T-A34`, `T-D2`, `T-D3`,
  `T-I2`, on four lines — and **all four are historical prose**: three in
  `test/attack_plans/AP-xgmii_rx_64.md`'s change log (`:3756`, `:3875`, `:3880`) and one
  in a comment at `test/xgmii_rx_64/test_m03_i.ml:574` quoting `WO-0061`. **None is a
  unit label.** Recorded because a careless grep returns them and would read as a
  counter-example.)
- **M2 — each campaign's own declared M03 denominator reproduces exactly from the tree
  at that campaign's own base SHA.** This is the check that makes the mapping a
  statement about *populations* and not about *spelling*:

  | campaign | base SHA | `let%expect_test` heads at that base | `M03-`-labelled heads | the campaign's own declared figure |
  |---|---|---|---|---|
  | `WO-0050` | `616686f` | **20** | 19 | *"a frozen matrix of 21 REQUIRED and 139 MUST-STAY-GREEN over **20 units**"* (verdict §0) |
  | `WO-0055` | `2e8994f` | **25** | 24 | 5 red + **20/20** MUST-STAY-GREEN = **25** (verdict §1) |
  | `WO-0058` | `a2d090d` | **31** | 30 | *"M03-H4 **alone out of all 31 M03 units**"*; *"confirmed empirically at **30** M03 units"* (verdict §2) |
  | `WO-0061` | `42b9df3` | **36** | **35** | I-c10's REQUIRED cell set = **35** (verdict §1, §11) |

  Four campaigns, four exact reconciliations, no residue. **The set the record scores in
  `T-` names and the set the tree carries in `M03-` names are the same set, at every
  base**, and that is measured rather than inferred from the labels.

##### 2.2-D.3 Evidence grades — stated so no row's strength is guessed

- **`E1` — in-record, class-local.** The campaign packet's **own text for that class**
  names the present unit — typically by quoting the observed failing message, which the
  bench emits in the `M03-` namespace. **The record performs the mapping itself**; I
  perform nothing.
- **`E2` — in-record, campaign-level.** The packet's own scope or subject declaration
  names the scored set in the present namespace, and it is the same set its scorecard
  scores in `T-`. Still in-record, one level wider.
- **`E3` — bench registry.** No present-namespace naming for that unit exists in that
  packet; the unit is resolved at its `let%expect_test` head at `49f04c0` under the rule
  of §2.2-D.2, with `M1` and `M2` carrying it.
- **`D` — derived.** The mapping is computed, not transcribed. **The derivation and its
  checks are stated in the row**, and if the derivation is ever falsified the row
  becomes a **disposition failure** until re-derived. Exactly one row is `D`.

##### 2.2-D.4 The table — thirty classes, four campaigns, plural where the record is plural

`R→G` = a cell the seal made REQUIRED that **stayed green**: named beside the killing
unit, **never folded into it**.

| campaign | class | campaign verdict | the record's named killing unit(s), **verbatim in its own namespace** | present name(s) at `49f04c0` | evidence |
|---|---|---|---|---|---|
| `WO-0050` | **F-c1** | KILL, exact | **T-C4, T-F1, T-F3, T-F4** (4/4) | M03-C4, M03-F1, M03-F3, M03-F4 | **E1** — verdict §2 quotes all four observed messages, `M03-`-named |
| `WO-0050` | **F-c2** | KILL; `F-1` | **T-A12, T-A34, T-A5, T-B1, T-C12, T-D1, T-D2, T-D3, T-F4** (9/9) | M03-A1 *(head "M03-A1, M03-A2")*, M03-A3 *(head "M03-A3 …; M03-A4 …")*, M03-A5, M03-B1, M03-C1 *(head "M03-C1, M03-C2")*, M03-D1, M03-D2, M03-D3, M03-F4 | **E1** for T-A34 (§3 quotes `M03-A3 (length 64) lane 0: strobe monitor unclean`); **E2** for T-F4; **E3** for the rest — the three composites at `test_m03_a.ml:80-82`, `:153-155`, `test_m03_c.ml:338-340` |
| `WO-0050` | **F-c3** | KILL; `F-2` | **T-F2** | M03-F2 | **E1** — §4 quotes `M03-F2 (lane 0, 1 octets received): a tlast word was observed…` |
| `WO-0050` | **F-c4** | KILL, exact | **T-F3** | M03-F3 | **E1** — §5 quotes `M03-F3 (lane 0): expected exactly {error_runt, error_bad_fcs}…` |
| `WO-0050` | **F-c5** | KILL, exact | **T-F2** | M03-F2 | **E1** — §4 quotes `M03-F2 (lane 0, 0 octets received)…` |
| `WO-0050` | **F-c6** | KILL, admissible | **T-F2** | M03-F2 | **E1** — §4, byte-identical corrected file to F-c3 |
| `WO-0050` | **F-c7** | KILL, exact | **T-E5** | M03-E5 | **E1** — §5 quotes `M03-E5 (preamble position 1, lane 0): expected exactly one strobe pulse…` |
| `WO-0050` | **F-c8** | KILL; `F-4` | **T-E5 alone** — 1 of 3 sealed; **T-E2 `R→G`, T-F2 `R→G`** | M03-E5 *(killing)*; M03-E2, M03-F2 *(named, not folded)* | **E1** — §6 quotes `M03-E5 (…): error_bad_frame pulsed on cycle 2, expected 3` |
| `WO-0055` | **G-c1** | KILL, exact | **all five G rows: T-G1, T-G2, T-G3, T-G4, T-G6** (5/5) | M03-G1, M03-G2, M03-G3, M03-G4, M03-G6 | **E2** — the packet's own subject line: *"(`test_m03_g.ml`, rows **M03-G1, G2, G3, G4, G6**)"* |
| `WO-0055` | **G-c2** | KILL, exact | **T-G2, T-C3** (2/2) | M03-G2, M03-C3 | **E2** for T-G2 (subject line); **E3** for T-C3 — `test_m03_c.ml:467`, head *"M03-C3: one 1518-octet frame, both lanes"* |
| `WO-0055` | **G-c3** | KILL, exact | **all five G rows** (5/5) | as G-c1 | **E2** — subject line |
| `WO-0055` | **G-c4** | **SURVIVED** | **none — no unit killed it.** T-G4 predicted, `R→G` | **n/a** | **NOT a frozen-kill row.** `(b.2)`'s **survivor** limb governs and is discharged at §2.2-M above: the **unmodified** `g-c4.diff`, branch `mut/wo-0056-gc4-replay` = `c95c9f4`, CI run **`30852220315`**, killing unit **`M03-G8`** — landed at `WO-0056`, **after** the rename, so already in the present namespace and present at `49f04c0`. **No mapping is owed and none is performed** |
| `WO-0055` | **G-c5** | KILL, exact | **all five G rows** (5/5) | as G-c1 | **E2** — subject line |
| `WO-0058` | **GH-c1** | KILL | **T-G7, T-G6** (2/2) | M03-G7, M03-G6 | **E2** for T-G7 (§1's scope table names it with its file); **E1** for T-G6 — §7 is titled *"The **M03-G6** disposition"* |
| `WO-0058` | **GH-c2** | KILL | **T-H3** | M03-H3 | **E2** — §1 scope table |
| `WO-0058` | **GH-c3** | KILL | **T-H1, T-H2** (2/2) | M03-H1, M03-H2 | **E1/E2** — §1 scope table; §2 speaks of *"the same `M03-H1` lane label"* for this very collision test |
| `WO-0058` | **GH-c4** | KILL; `GH-1` | **T-H2 alone** — 1 of 2 sealed; **T-H1 `R→G`** | M03-H2 *(killing)*; M03-H1 *(named, not folded)* | **E1** — §2: *"GH-c4 speaks at **M03-H2** with `delivered octets differ…`"*; §3 quotes M03-H1's green |
| `WO-0058` | **GH-c5** | KILL; `GH-2` | **T-H1, T-H2, T-H4** (3 red; T-H4 wrong message, still red) | M03-H1, M03-H2, M03-H4 | **E2** — §1 scope table; §4 quotes M03-H4's observed text |
| `WO-0058` | **GH-c6** | KILL | **T-H1, T-H2, T-H4** (3/3) | M03-H1, M03-H2, M03-H4 | **E2** — §1 scope table |
| `WO-0058` | **GH-c7** | KILL | **T-H4** | M03-H4 | **E1** — §2: *"GH-c7 reddened **M03-H4** alone out of all 31 M03 units"* |
| `WO-0061` | **I-c1** | **VOID — NOT SEEDED AS SPECIFIED**, 0 kills | **none — no unit killed it.** Sealed wide cells T-I6, T-I4 both green; T-F1, T-F2, T-G7 red on a bench the seal was not written against | **n/a** | **NOT a frozen-kill row.** `(b.1)`'s **second ground** governs — a rendering found **not to render the class as sealed** is **UNSCOREABLE**, its run a scope report supporting no claim in either direction. Ground disclosed pre-run and ruled at `WO-0061` (`FINDING A-1`, `DISP-0001`). **No mapping is owed** |
| `WO-0061` | **I-c2** | KILL | **T-I4, T-I6** (2/2) | M03-I4, M03-I6 | **E2** — §1's scope table names all five scored units `M03-` with their rows |
| `WO-0061` | **I-c3** | KILL | **T-I4, T-I6** (2/2) | M03-I4, M03-I6 | **E2** — §1 scope table |
| `WO-0061` | **I-c4** | KILL | **T-I4, T-I6** (2/2) | M03-I4, M03-I6 | **E2** — §1 scope table |
| `WO-0061` | **I-c5** | KILL | **T-I4, T-I6** (2/2) | M03-I4, M03-I6 | **E2** — §1 scope table |
| `WO-0061` | **I-c6** | KILL; `S-4` | **T-I4, T-I6** (2/2 rows; member field falsified) | M03-I4, M03-I6 | **E2** — §1 scope table |
| `WO-0061` | **I-c7** | KILL | **T-I4, T-I6** (2/2) | M03-I4, M03-I6 | **E2** — §1 scope table |
| `WO-0061` | **I-c8** | KILL; `S-1` | **T-I1 alone** — 1 of 2 sealed; **T-I6 `R→G`** | M03-I1 *(killing)*; M03-I6 *(named, not folded)* | **E2** — §1 scope table |
| `WO-0061` | **I-c9** | KILL, monitor-caught, counted **once** | **T-I3** | M03-I3 | **E2** — §1 scope table |
| `WO-0061` | **I-c10** | KILL; `S-2`, `S-3` | **28 of 35.** The record names the **35**-cell set and names the **seven greens individually** — **T-C4, T-E1, T-E2, T-E5, T-F1, T-F2, T-F3** (§11) — so **the killing units are the complement, and they are plural to a degree no other class in the era reaches** | the **28** `M03-` heads at `42b9df3` less those seven's counterparts: **M03-A1, A3, A5, B1, C1, C3, C5, D1, D2, D3, E4, F4, G1, G2, G3, G4, G6, G7, G8, H1, H2, H3, H4, I1, I2, I3, I4, I6** | **D** — derived. **Method**: enumerate the `M03-` heads at the campaign's own base `42b9df3` and subtract the seven the record names green. **Two independent checks, both exact**: the enumeration returns **35** heads, matching the record's 35-cell REQUIRED set; and `35 − 7 = 28`, matching the record's *"28 red, 7 green"*. **E1** for the seven greens (§11 names them). If the 35-cell set is ever shown to be a different population, **this row is a disposition failure until re-derived** |

##### 2.2-D.5 The plural naming, discharged — and the shape it exposes

`J-dv_lead-0186` sustained the auditor's construction of *"the named killing unit"*
against my own withdrawn C3: **the phrase points at the campaign record's own naming,
plural where the record is plural, never a gate-time selection** — both constrained
parties signing under one reading, with the non-blocking cure *"the named killing unit
**or units**"*. The column above is written to that construction and **not one row
selects**. Three shapes appear, and the third is the one worth naming:

1. **Plural sealed, plural killed** — **17** rows, from two units (I-c2…I-c7) to
   twenty-eight (I-c10). Every unit the record names is carried; none is dropped for
   being redundant.
2. **Singular** — 8 rows (F-c3…F-c7, GH-c2, GH-c7, I-c9). Singular because the record is
   singular, not because a set was narrowed.
3. **Plural sealed, singular killed — three rows, and they are the reason C3 had to
   go**: `F-c8` (1 of 3, T-E2 and T-F2 `R→G`), `GH-c4` (1 of 2, T-H1 `R→G`), `I-c8`
   (1 of 2, T-I6 `R→G`). **Under C3 these would have been a gate-time pick from a set
   the campaign never ranked; under the adopted reading the killing unit and the
   sealed-but-green cells are both named, side by side, and the `R→G` cell is never
   folded into the kill.** All three greens are falsified seal predictions standing
   unedited in their SEALED files, which is where they belong.

##### 2.2-D.6 Result, and the four things this table does NOT do

**Result: thirty classes examined, twenty-eight take the frozen-kill form, twenty-eight
mappings established, ZERO disposition failures.** The two that do not take that form
are `G-c4` (survivor limb, discharged at §2.2-M by replay, killing unit `M03-G8`
already in the present namespace) and `I-c1` (unscoreable under `(b.1)`'s second
ground). **The remaining six class-era campaigns need no mapping at all**: `WO-0063B`,
`WO-0066`, `WO-0073`, `WO-0074`, `WO-0076` and `WO-0077` carry **zero** `T-` names —
measured, not assumed — and name their units in the present namespace throughout.

**And what it does not do, named so nobody reads it wider:**

1. **It does not measure GREEN.** `(b.2)` asks for the named unit **present *and* green
   at the gate SHA**. This table measures **presence**, at `49f04c0`, which is the half
   `REC-7` proved undischargeable. **Green is CI's verdict and is taken at the gate
   SHA**, which does not yet exist — §8 of this packet carries `FAIL`. **A reader who
   treats this table as half a disposition and stops has done the arithmetic
   `REC-7` was filed to prevent.**
2. **It does not cure `F-0022-1`.** The auditor's finding — that the kill form cannot
   notice a class whose **rendering** no longer applies to the design — is the *same
   hazard from the other end*, verified at two instances (`f-c3.diff` and `f-c6.diff`
   **no longer apply** at HEAD, *patch failed … `xgmii_rx_64.ml:725`*; `f-c1.diff`
   applies clean). **A name that resolves does not make a diff that applies.** Both
   residues are routed to §12.8's narrative, and neither is cured by text.
3. **It does not re-run, re-score or rehabilitate anything.** Every campaign score above
   is quoted from its own committed verdict and stands unedited, including the five
   falsified seal cells. **A kill's disposition preserves its campaign's measurement and
   asks only that its instrument still stands** — that is the whole of what is done
   here.
4. **It does not move §2.2-M's columns**, which are frozen at `2183d71`, nor pre-empt
   the movement `(b.1)` will make to the `sealed` figure (63 → 65) — a **definition
   change with no measurement behind it**, which lands on its own carrier and must say
   so in the same sentence.

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

#### 2.3-M MEASURED AT `2183d71` (§7.1 steps 6–7) — the five classes re-observed, the agreed value now PRINTED, and bar 1's set claim re-measured over both producers

**(1) THE FIVE CLASSES' LIFT IDS ARE THE CELLS' OWN AND ARE NOT RENEWED HERE.** The
table above governs. **`§5.1 item 5` binds this round**: run `31444471834` **re-observes**
all five classes and **that is not a lift and renews none**. No class is added, no
class's status moves, and **no requirement is anchored by anything in this round**.

**(2) THE RE-OBSERVATION, at the sign-off SHA.** `cosim` job **`93635620959`** of `build`
run **`31444471834`**, `head_sha` `2183d71`, conclusion **`success`**. Its own printed
case set:

```
=== CASE SET (WO-0078 §6.2 Stage 2: 5 case(s) — 0 C1 C3 C2 C4) ===
CASE 0 : compare_exit=0 tier=CLEAN     C1: compare_exit=0 tier=CLEAN
CASE C3: compare_exit=0 tier=CLEAN     C2: compare_exit=0 tier=CLEAN
CASE C4: compare_exit=0 tier=CLEAN
=== AGGREGATE === every case in the set reached a verdict and every verdict was clean.
```

**Case-to-class mapping is off by one and the packet states it rather than assuming
it**: case 0 → class 1, C1 → class 2, C2 → class 3, C3 → class 4, C4 → class 5.

**(3) `FINDING RV-0078-S2-11`'s REPAIR IS LIVE ON A RUNNER, AND REQ-104's ROW MAY NOW
QUOTE A PRINTED VALUE.** §3.5's `RULED` block promised that the agreed value becomes
quotable **only from step 7's own `cosim` job**. It does. Job `93635620959`, case **C3**
(class 4 — one 64-octet **bad-FCS** frame), verbatim:

```
frames compared: 1
frames matching: 1
divergences: none
agreed values (what REQ-901's comparison found EQUAL; this lane asserts no figure
  of its own -- FINDING RV-0078-S2-11)
  frame 0: decision = accept, 8 word(s), 60 octet(s)
    ...
    word 7: tkeep = 0f  tlast = 1  tuser0 = 1  octets = 38 39 3a 3b
```

**REQ-104's row, written under §5.5 and under `FINDING RV-0078-S2-2`, and it is a
PAIR:**

> **The AGREEMENT half**: at `build` run `31444471834` / `cosim` job `93635620959`,
> case C3, the two implementations **agreed** that frame 0 is accepted, eight words,
> sixty delivered octets, and that its `tlast` word carries **`tuser0 = 1`** with
> `tkeep = 0f`. **This lane asserts no figure of its own and the log says so on the
> line above the value.**
> **The ABSOLUTE half**: `M03-D1` asserts those figures **at the receiver**, against
> SPEC-M03, in the bench.
> **α never stands for both, and the row is written as the pair or not at all.**
> **This does not anchor REQ-104** — §5.1 item 2: class 4 is anchored, REQ-104 is not.

**The line the packet may NOT write, and does not**: that the co-simulation established
`tuser`[0] = 1. It established **equality**; `M03-D1` established the **value**; the
conjunction is what the record now carries, and before `ee3da9c` the log could not have
supported even that.

**(4) BAR 1's SET CLAIM — RE-MEASURED AT `2183d71`, OVER BOTH PRODUCERS, IN MECHANISM
FORM (`FINDING ECS-6`).** `AP-M03` §7's five commands, re-run:

| | command | result at `2183d71` | at `e51ca52` |
|---|---|---|---|
| **(a)** | `grep -rn "expected_strobes" --include=*.ml --include=*.mli test` | **ZERO call sites outside `test/xgmii/`** — three hits, all the model's own `.ml`, `.mli` and unit test | ZERO |
| **(b)** | `grep -rn "Injection\.outcomes" test --include=*.ml \| grep -v "^test/xgmii/"` | **24 raw matches in 6 files; 17 EXECUTABLE call sites** — `test_m03_b.ml` 5, `_e` 3, `_f` 1, `_g` 2, `_h` 4, `_n` 2. The other **7 are mentions inside comments** | 17 executable, same 6 files |
| **(c)** | `grep -rEn "let +[a-z_']+ *= *[a-z0-9_']+\.Dv_xgmii\.Injection\." test/xgmii_rx_64 --include=*.ml` | **ZERO** — no outcome field is ever bound to a name | ZERO |
| **(d)** | `grep -n "Injection\.[a-z_]*" test/xgmii_rx_64/test_m03_i.ml` | **X-1(i) only** — `corrupt`, `create`, `errors`, `is_clean`, `schedule`, `word_at` | X-1(i) only |
| **(e)** | `grep -rn "Injection" test/cosim` | **ONE line, a docstring saying the model is absent** — `stimulus_gen.ml:309` | one line |

**RESULT: THE CLAIM SURVIVES RE-MEASUREMENT AT `2183d71`, over both producers.** **No
benched row takes an expected value from X-1(ii)'s computed outcome model**, and the
ground is the structural pair (a) + (c) — *the model's oracle join is called by nothing
outside its own test, and no bench binds an outcome field to a name* — **not** the
call-site count.

> **`FINDING SO-4` (MINOR, mine, against `AP-M03` §7's own measurement block).**
> Row (b)'s result column reads *"17 call sites in 6 files"* beside a command whose raw
> output at its own stated SHA is **24 lines**. The **17 is right** — it is the
> executable count, and the column says *"every executable call"* — but **the command
> as quoted does not produce it**, so a reader re-running it gets a different integer
> and cannot tell whether the tree moved or the figure was wrong. `git diff e51ca52
> HEAD -- test/` shows the six files **unchanged**, so the tree did not move. **This is
> `FINDING ECS-6`'s own mention-versus-mechanism distinction, committed inside the
> block that mints it.** **Disposition**: this packet quotes **24 raw / 17 executable /
> 7 comment mentions**, all three, so the command and the figure agree; the repair to
> `AP-M03` §7's cell rides the next `AP-` opener.

**POLARITY, discharged explicitly (`FINDING RV-0078-S2-13`).** The claim is that a
mechanism **does not exist**. It is measured over **every landed construction of the
thing in question** — not over the modules that would naturally host one: (a) is the
oracle join's whole call graph, (c) is every binding form in the bench directory, and
(e) is the second producer in full. **Three constructions, three zeroes.**

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

#### 2.4-M MEASURED AT `2183d71` (§7.1 step 6) — THE TALLY DOES NOT SURVIVE, BECAUSE THE SPECIFICATION MOVED UNDER IT

**This is the largest single correction the executing round produced, and it is not a
correction of the sweep.** `RV-SWEEP` §2.3 measured seventeen classes against REQ-901 as
REQ-901 stood at `c1f98ff`. **Between that reading and this SHA, REQ-901 gained two
declared divergence classes** — **(g)** abort-truncation **extent** and **(h)** the
zero-delivered abort's **decision** — countersigned by me at `3526e79`, transcribed **IN
FORCE at `4e7331b`**, and corrected twice at `ce5674d` by `FINDING CSG-1` (the lane-4
abort the recital missed, with its sign) and `FINDING CSG-2` ((g)'s carve-out bound to
lane 0 of the **output** word, not the XGMII word).

**So the carried tally is stale by construction, and re-measuring it is exactly what
§0.2's SHA dimension exists for.** Source of truth: `docs/specs/requirements.md`
REQ-901, REQ-105 and REQ-110 **at `2183d71`**. The seventeen classes and their row sets
are the sweep's and are unchanged; only the **disposition column** moves.

| class | disposition at `c1f98ff` | **disposition at `2183d71`** | why it moved |
|---|---|---|---|
| **E-1** error character mid-frame, ≥ 1 delivered octet | OUTSIDE | **INSIDE (g), partially** | (g) excludes the delivered octet count, the `tkeep` extent and the `tlast` position **where the aborting character is not in lane 0 of the OUTPUT word**; `tuser`[0] and the decision stay compared. **Two of its sixteen members remain fully comparable** — XGMII lane 0 in a lane-0-started frame, XGMII lane 4 in a lane-4-started frame, and in each case only where the injected word is not the frame's first payload word (`FINDING CSG-2`'s repaired projection, REQ-105's verification column) |
| **E-2** error character at or before the first octet, zero delivered | OUTSIDE | **INSIDE (h), excluded ENTIRELY, decision included** | (h) names *"an error character at or before the frame's first octet"* |
| **E-3** error character inside the preamble at a lane-0 start, zero delivered | OUTSIDE | **INSIDE (h), excluded ENTIRELY** | (h) names *"including one in a preamble position"*; this is (h)'s **start-word path**, where the reference *"never acts on it at all"* and delivers the frame whole and unmarked |
| **E-4** error character outside any open frame | OUTSIDE | **OUTSIDE** | (g) and (h) are *"keyed on the abort"*; there is no open frame to abort |
| **F-1, F-2, F-3** | INSIDE (e) | **INSIDE (e)** | unchanged |
| **F-4** exactly 64 octets, clean | OUTSIDE | **OUTSIDE** | unchanged; still the **only anchored class** |
| **G-1, G-2** | INSIDE (f) | **INSIDE (f)** | unchanged |
| **G-3** exactly 1518, clean · **G-4** legal frame after an oversize | OUTSIDE | **OUTSIDE** | unchanged |
| **H-1** `/S/` replacing `/T/`, lane 0, ≥ 1 delivered octet | OUTSIDE | **OUTSIDE — and now BARRED AS STIMULUS** | REQ-901: *"until a class is declared, co-simulation stimulus SHALL NOT present a start character inside an open frame that has already delivered an octet"* |
| **H-2** `/S/` in lane 4 of a mid-frame word, partial-word delivery | OUTSIDE | **OUTSIDE — and now BARRED AS STIMULUS** | same sentence; `FINDING CSG-1` records that the reference **does** abort here, one cycle later than `:390` alone suggests, and the divergence is the aborted frame's last word |
| **H-3** the frame an aborting `/S/` opens | OUTSIDE | **OUTSIDE; reachable only through barred stimulus for its `M03-H1`/`H2` members** | its `M03-H4` member rides a zero-delivered abort and is reachable in principle |
| **H-4** `/S/` after an `/E/` has already closed the frame | OUTSIDE | **OUTSIDE** | the frame is closed; no open frame is aborted by the `/S/` |
| **H-5** two `/S/` aborting strictly inside preambles, zero delivered | OUTSIDE | **INSIDE (h), excluded ENTIRELY, decision included** | (h) names *"a start character leaving the aborted frame zero delivered octets (REQ-110)"* |

**THE TALLY, RE-MEASURED, AND IT IS THE SENTENCE THE PACKET WRITES:**

| | at `c1f98ff` | **at `2183d71`** |
|---|---|---|
| INSIDE a declared divergence class | 5 | **9** — F-1, F-2, F-3 in **(e)**; G-1, G-2 in **(f)**; **E-1 in (g)**; **E-2, E-3, H-5 in (h)** |
| OUTSIDE every declared class | 12 | **8** — E-4, F-4, G-3, G-4, H-1, H-2, H-3, H-4 |
| unreachable at the comparison today | 9 | **9** — four on the capture bound (all of G), five on admission (all of H); **and for H-1 and H-2 the unreachability is now a SPECIFICATION BAR as well as an instrument property** |
| **anchored today** | **1** | **1 — F-4, and only F-4** |

**9 + 8 = 17.** Every row of §4.E–§4.H still lands in exactly one class, none unassigned,
none twice.

> **The sentence this table licenses at `2183d71`, and the packet writes this one:**
> *"Of the seventeen error classes families E–H assert, **nine** are inside a declared
> REQ-901 divergence class, **eight** are outside every declared class, and **nine**
> cannot be presented to the comparison at this tree — two of them because REQ-901 now
> forbids the stimulus outright. **Exactly one is anchored: F-4.**"*

> **The sentence it does not license, in either reading, and the packet writes no form
> of it:** ~~*"the co-simulation covers family E"*~~. **Four of E-1's sixteen-member
> sweep and the whole of E-2 and E-3 are now inside an exclusion, which anchors LESS
> than the stale tally implied, not more** — *inside an exclusion the comparison anchors
> nothing* is REQ-901's own sentence.

**THE DIRECTION OF THE CHANGE, said plainly because it is unflattering to the lane.**
Declaring (g) and (h) **moved four classes from *"a divergence here is a defect"* into
*"a divergence here is excluded"***. That is a **reduction** in what the co-simulation
can ever anchor at this boundary, bought in exchange for the two classes' behaviour
being *understood and written down* instead of unknown. **`FINDING ECS-4` and
`FINDING ECS-5` are therefore closed as predictions and open as exclusions**, and any
later packet reading the (g)/(h) landing as an expansion of the anchor has read it
backwards.

**And one thing the landing DID buy, stated with its own bound**: REQ-901 now names
**one place an abort still anchors** — *"an aborting character in lane 0 of an output
word other than the frame's first payload word"* — which is E-1's two comparable
members. **No case has ever driven them.** They are anchorable and unanchored, and the
distinction is the whole of `§5.1 item 3`.

**TWO MINOR CORRECTIONS OF RECORD against `RV-SWEEP` §2.3's prose, neither of which
moves a class or a disposition**, measured by the same status-cell pass as §2.1-M:

- **`M03-G5` is `NO-ASSERT`, not "structural".** §2.3's row-set column writes
  *"(`M03-G5` structural)"*; the plan's own status cell reads **`NO-ASSERT`**. **The
  plan's cell governs** (§1's vocabulary is a closed set of six values).
- **`M03-E3` is `NO-ASSERT`** and is listed in class E-2's *"rows asserting it"* column
  beside `M03-E2`. **A `NO-ASSERT` row asserts nothing**; read the column as *rows that
  address the class*. **Neither correction changes the seventeen, the tally, or any
  disposition above.**

### 2.5 REQ-901's bars, as they stand

Restated in full at §5, which is where the packet's own prohibitions live. **Summary
of movement since they were written: bar 4's precondition (1) became MET for
`error_bad_fcs` and for no other strobe (`J-dv_lead-0159`), which is movement inside a
standing refusal and is NOT a lift. Bars 1, 2 and 3 are unmoved.**

**RE-CHECKED AT `2183d71`, and the (g)/(h) landing does not touch any of the four.**
Bar 2 is stated as a property of the frozen requirement and REQ-901's (e)/(f) text is
byte-unchanged by the (g)/(h) diff. Bar 3's subject — cycle alignment, internal
pipelining and latency constants — is excluded by REQ-901's own closing sentence, which
the diff did not amend; the `cosim` job's `T2` block at run `31444471834` still prints
the reference's cycles under the header *"RECORDED, NEVER ADJUDICATED"*. Bar 4's split
by strobe is unchanged. **Bar 1 is re-measured at §2.3-M(4) and still gates no benched
row.**

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

#### 2.7-M MEASURED AT `2183d71` (§7.1 step 6)

**Domain**: `agents/handoffs/BUG-*.md`, enumerated from the tracked tree — **three
packets, and the set is the glob's, not a recollection.**

| packet | state field / `Fix verdict`, read at `2183d71` | closing entry |
|---|---|---|
| `BUG-0001_m03-final-word-over-delivery.md` | **`FIX CONFIRMED`** at CI run `30779035676` (`b89358b`); all six conditions of the deferred verdict met | `J-dv_lead-0034` |
| `BUG-0002_m03-idle-injection-tlast-on-a-non-final-word.md` | **`ACCEPT — CLOSED`** at `fafb83d`; two fix commits, one defect; root-cause requirement satisfied at `J-rtl_lead-0009`/`-0010` | `J-dv_lead-0089` |
| `BUG-0003_m03-lane-4-injected-word-cycle.md` | **`FIX ACCEPTED — CLOSED`** at §V.10 | `J-dv_lead-0103` |

**OPEN `BUG-` COUNT AGAINST THIS MODULE AT `2183d71`: ZERO.** **Polarity discharged**:
the claim is that no open defect exists, so it is measured over **every landed packet of
the class** — the glob — rather than over the ones I remember filing.

### 2.8 THE TRACEABILITY MATRIX — SC-2's third clause, and it is the criterion this packet fails on

**Measured, at `2183d71`, over `docs/specs/traceability.md`:**

```
$ awk -F'|' '/^\| REQ-/{n++; t=$7; gsub(/^[ \t]+|[ \t]+$/,"",t);
             if(t=="") e++; else ne++} END{print n, e, ne}'
    docs/specs/traceability.md
110 110            (110 REQ rows; 110 empty Test(s) cells; 0 populated)
```

**Every one of the 110 rows carries an empty `Test(s)` cell and `Status` = `OPEN`.** The
column has been empty since it was created: `WO-0002` §9 describes the skeleton as
*"matrix skeleton (REQ → spec § → test), rows for every REQ, **test column empty pending
DV**"*, committed 2026-08-02; `docs/specs/traceability.md` last moved on 2026-08-03 at
`62c39a7` for a REQ-901 cascade repair, by architect_docs_lead. **No dv_lead packet in
`agents/handoffs/` has ever delivered test-side rows**, and no dv_lead journal entry
records the delivery.

> **`FINDING SO-1` (MAJOR, mine, against this packet's own design round).**
> **`SC-2`'s third clause names an obligation that NO STEP OF §7.1 PAYS.** The draft
> wrote fourteen criteria at `J-dv_lead-0161` and a twelve-step execution order in the
> same file, and the order has no step for *"deliver the test-side rows of the
> traceability matrix"* — nor is the obligation on §3's twelve-item ledger, whose whole
> purpose is that nothing owed is discovered by the round that needs it. **It was
> discovered at step 8, by the round being graded on it.** That is `SC-11`'s named
> failure mode, quoted against its own author: *"An owed item discovered by the round
> that needed it, rather than paid in the order §7 fixes, is a finding against this
> packet."*
>
> **WHY IT IS NOT PAID HERE, and this is the load-bearing decision of the round.** The
> rows could be manufactured now: `agents/handoffs/**` is inside my write scope, and a
> §2.8 table of 34 REQ→row mappings would let this packet assert its own clause
> discharged. **Refused, on the ground this packet's own §0.0 was written on.** A
> deliverable produced **inside the document that is graded by its existence**, at the
> moment the grading discovers it missing, is *"a condition whose author may discharge
> it by declaring it discharged"* — `RV-C4` §9, quoted at §0.0. The delivery is real
> work with a real reviewer: it is a mapping architect_docs_lead must be able to check
> against the plan and the suite, and it is owed **before** the packet that cites it,
> not inside it.
>
> **CARRIER, named rather than left open**: a dv_lead round that drafts the test-side
> rows for SPEC-M03 §10's hooks — REQ id, the `M03-` rows that attack it, the landed
> unit each row is discharged by — as a packet in `agents/handoffs/`, delivered to
> architect_docs_lead for transcription into `docs/specs/traceability.md`, which
> dv_lead cannot stage (PROTOCOL §6). **It is a bounded round and it is the shorter of
> the two acts §8 names.**

**What IS measured and MET, so the failure is not read wider than it is.** SC-2's first
two clauses hold at `2183d71`:

```
$ awk '/^## 10\./{f=1} f&&/^## 11\./{f=0} f' docs/specs/modules/xgmii_rx_64.md \
    | grep -oE 'REQ-[0-9]+' | sort -u | wc -l          -> 35
$ awk '/^## 6\. Coverage map/{f=1} f&&/^## 7\./{f=0} f' \
    test/attack_plans/AP-xgmii_rx_64.md | grep -oE 'REQ-[0-9]+' | sort -u | wc -l -> 35
```

**Symmetric difference: two tokens, both explained and neither a gap.** `REQ-010`
appears in SPEC-M03 §10 **only inside REQ-014's own cell** as a cross-reference
(*"M03's input is an XGMII lane pair, which has no `tstrb` to vary (REQ-010 class (b))"*)
and is not a hook of its own; `REQ-803` appears in `AP-M03` §6 and not in §10, which is
the plan covering **more** than the spec hooks, never less. **So every REQ-### hooked by
SPEC-M03 §10 carries an `AP-M03` §6 coverage entry, every `ASSERT` row those entries
name is discharged (§2.1-M), and the one undischargeable attack is carried as the
declared `GAP` row `M03-O2` rather than dropped.**

**And the independence clause, measured over this packet's own derivation chain**: no
`libs/**`, `top/**` or `rtl_snapshots/**` path appears in it. The RTL path in the header
**names the module the verdict is about**; it is not a document this packet derives
from, and no round of this packet's execution opened it.

#### 2.8-R PAID AND MEASURED AT `14615f8` (round 3) — the rows delivered, transcribed, and checked against the file rather than against the report of it

> **DATED ANNOTATION, 2026-08-11, `J-dv_lead-0167` — §2.8 above is round 2's measurement
> and is left UNEDITED, `FINDING SO-1` included.** The finding is not falsified by this
> block; it is **discharged by the carrier it named**. A dated claim is annotated beside
> itself, never rewritten into its own outcome.

**The carrier §2.8 named ran, and it ran outside the document graded by it — which was
the whole point of the refusal.** `WO-0079_m03-traceability-test-rows.md`, drafted by
dv_lead at `a851948` and landed at **`a43ac00`** (`J-dv_lead-0166`); transcribed into
`docs/specs/traceability.md` by architect_docs_lead at **`14615f8`**
(`J-architect_docs_lead-0035`), the only seat that may stage that file (PROTOCOL §6).
**The mapping therefore had a reviewer who is not me, and the reviewer returned two
precisions and refused nothing.**

**MEASURED AT THE MATRIX, AT `14615f8`. Round 2's own command, re-run, plus the status
column it did not need:**

```
$ awk -F'|' '/^\| REQ-/{n++; t=$7; gsub(/^[ \t]+|[ \t]+$/,"",t);
             s=$8; gsub(/^[ \t]+|[ \t]+$/,"",s);
             if(t=="") e++; else p++; c[s]++}
     END{print n" rows: "p" populated, "e" empty"; for(k in c) print "  "k": "c[k]}' \
    docs/specs/traceability.md
110 rows: 34 populated, 76 empty
  OPEN: 97
  COVERED: 13
```

**And the check that matters is not the count — it is the string comparison, which I ran
myself rather than accepting the transcriber's report of it.** Both files were parsed on
the pipe character, the delivered `(Test(s), Status)` pair taken from `WO-0079` §3's
columns 2–3 and the transcribed pair from `traceability.md`'s columns 6–7, and compared
**exactly**:

| check | domain | result at `14615f8` |
|---|---|---|
| delivered pairs vs transcribed pairs, **string equality** | the 34 rows of `WO-0079` §3.A/§3.B/§3.C | **0 mismatches** |
| rows delivered but **absent** from the matrix | the same 34 | **0** |
| rows **populated** in the matrix that no packet delivered | all 110 rows — *the negative half, measured* | **0** |
| rows whose cells changed `c55c754 → 14615f8` | all 110 rows | **exactly the 34**, and **every one was `Test(s)`-empty and `Status` `OPEN` before** |
| `COVERED` set | all 110 rows | `REQ-101 … REQ-113` — **exactly tier A**, the thirteen rows M03 owns whole |

**The domain of the delivery, re-derived from the spec rather than from the packet
that delivered it.** SPEC-M03 §10 yields **35** `REQ-` tokens; the delivered set is
**34**; the symmetric difference is **`REQ-010` alone**, which §2.8 already explained as
a cross-reference living inside REQ-014's cell and not a hook of its own. Independently:
every row of `traceability.md` naming **M03** in `Owning module(s)` — **14** of them — is
in the delivered set, none missing.

**Every citation in the transcribed cells resolves, and the one exception declares
itself.** Over the **49 distinct `test/**.ml:<line>` citations** the populated cells
carry, **48 land on a `let%expect_test` line**; the single non-unit citation is
`test/xgmii_rx_64/test_m03_f.ml:811`, which is the comment
`(* ---- M03-F5 — DISCHARGED BY CITATION, not built (WO-0047 §3.3) ----------- *)` —
**the cell says so in its own text rather than passing it off as a unit.**

**THE TWO PRECISIONS THE TRANSCRIBER RETURNED, RE-MEASURED HERE RATHER THAN ACCEPTED.**

- **`P-1` — UPHELD, and refined by my own measurement.** The transcriber found that
  `M03-M10 → test_m03_f.ml:492` names a unit whose title carries `M03-F2` and not
  `M03-M10`, against `WO-0079` §2.1's rule that a cited line names *"the unit whose title
  carries that row id"*. **Verified**: line 492 is a `let%expect_test` whose title reads
  *"M03-F2: 0, 1 and 4 octets between start and terminate …"*, and the string `M03-M10`
  occurs in that file **exactly once, at line 324** — inside the **prose of a different
  unit**, the one beginning at line 304. So the id is in the file and not in the cited
  unit. **The cell is substantively right and stays unchanged**: `AP-M03` §6 homes
  `M03-M10` on `M03-F2` *"ON `M03-F2` ALONE"*, and 492 **is** `M03-F2`'s unit. **What is
  imprecise is `WO-0079` §2.1's generalisation, not the transcription** — and a reader
  following §2.1 literally at that one entry will not find the id. **Carrier**: the same
  round that repairs `AP-M03` §6's homing under `FINDING SO-1-A`.
- **`P-2` — ACCEPTED, no cell affected.** `WO-0079` §1.2 grounded the tier-B/C `OPEN`
  disposition on ranges that reach 19 of its 21 rows; `REQ-901` and `REQ-903` are process
  rows in neither range and reach the same disposition on a different ground. **The
  transcriber wrote the process-row ground into the file's own `Status` bullets.**
  Correct, and the correction is in the file that owns the vocabulary rather than in a
  cell.

**WHAT THIS BLOCK DOES NOT CLAIM, and each omission is deliberate.** It does **not**
claim the matrix is complete: **76 of 110 rows remain empty**, and they are other
modules' sign-off rounds, not this one's gap. It does **not** claim a `COVERED` row is a
gate signature: `P1-module-ready` reads the `SO-`, not the matrix. It does **not** claim
the 13 `COVERED` cells rest on a run this round executed — they rest on run
`31449924111` at `14615f8`, an **externally verifiable reference** (ADR-0003/F5), over a
`test/` tree byte-identical to the one round 2 scored. And it does **not** upgrade
`M03-L6` or the four other `STRUCTURAL` entries into behavioural coverage: they are
compile-time and script checks, named as such **inside the cells**, which is `SC-4`'s own
declared bound carried into the file that a later reader will quote.

### 2.9 THE CI EVIDENCE (SC-3, SC-13) — captured at `2183d71`, build and cosim separately

**`build` run `31444471834`**, `head_sha` **`2183d71834b6cd5d077c6d7059de4bd7c8fc1f82`**,
run number 530, event `push`, conclusion **`success`**, started 2026-08-11T00:00:21Z.

**Job `93635620822` (`build`) — conclusion `success`, all thirteen steps `success`.**
The five that carry evidence:

| step | name | conclusion |
|---|---|---|
| 5 | Build | **success** |
| 6 | Run tests (expect tests, waveform snapshots) | **success** |
| 8 | Verify nothing was left unpromoted or non-deterministic | **success** |
| 9 | DV mechanical checks (C-9 record-vs-appendix, X-9 emitted Verilog) | **success** |
| 10 | Abort-bit availability quantifier (C-37/ADR-0012, 8.7M pairs) | **success** |

**Step 8 is the runner-side half of `git add -A && git diff --cached --exit-code`**, and
step 9 is `RN-6`'s resolve-check **green on a runner for the first time** — the check
whose first runner execution reddened `31442295998` and opened round 1R. Locally at
`2183d71`, `git status --porcelain` returns **zero lines**.

**Job `93635620959` (`cosim`) — conclusion `success`**, quoted **separately and
deliberately**: a `cosim` green is evidence of nothing outside the classes it drove
(§2.3-M(2), SC-6).

**`journal-check` run `31444471838`** at the same `head_sha`, conclusion **`success`**.

**THE BOUND ON THE LOCAL HALF, declared rather than glossed.** `opam exec -- dune
runtest` **cannot be executed in this container**: ADR-0005 keeps the Hardcaml toolchain
out of it, and `opam exec -- dune build @default` fails at `Library "ppx_hardcaml" not
found` / `Library "hardcaml" not found` before any test runs. **This is exactly why
`SC-3` makes the run id the evidence** (`WO-0072` §4: *"It is a TITLE count, not a pass.
The pass is the run id"*), and it is an **externally verifiable reference** in
ADR-0003/F5's sense, marked as such.

#### 2.9-R THE CI EVIDENCE AT `14615f8` (round 3) — and the one red run between the two sign-off SHAs, named rather than left to be found

**`build` run `31449924111`**, `head_sha` **`14615f8856918bfc97fe3408523f593c6d7f3467`**,
run number 538, event `push`, conclusion **`success`**, started 2026-08-11T01:38:29Z.

**Job `93651991502` (`build`) — conclusion `success`, all thirteen steps `success`**,
including step 5 *Build*, step 6 *Run tests (expect tests, waveform snapshots)*, step 8
*Verify nothing was left unpromoted or non-deterministic*, step 9 *DV mechanical checks*
and step 10 *Abort-bit availability quantifier*. **Job `93651991568` (`cosim`) —
conclusion `success`**, quoted **separately and deliberately** (§2.3-M(2), SC-6).
**`journal-check` run `31449924167`** at the same `head_sha`, conclusion **`success`**.
Locally at `14615f8`, `git status --porcelain` returns **zero lines**.

> **THE RED RUN, DISCLOSED BECAUSE A READER WILL FIND IT AND MUST NOT MISREAD IT.**
> **`build` run `31447385249` at `a851948` — the commit that CARRIES round 2's `FAIL`
> — concluded `failure`.** Measured at the job: `build` job `93644410367` failed at
> **step 4, *"Install dependencies"***, with steps **5–10 `skipped`**; the `cosim` job
> `93644410325` of the same run concluded **`success`**. **So the suite did not fail:
> it did not run.** This is a dependency-resolution failure in the runner's own setup,
> not a test result, and it **did not recur** — runs 532 … 538 (`2d47871`, `185ae66`,
> `a43ac00`, `d53d795`, `54b2553`, `c55c754`, `14615f8`) are all `success`.
>
> **What it does and does not touch.** It touches **no** criterion: `SC-3`'s subject is
> the **sign-off SHA**, which was `2183d71` for round 2 (run `31444471834`, green) and is
> `14615f8` for round 3 (run `31449924111`, green). `a851948` is neither. **But a packet
> that quotes run ids as its evidence owes the reader the run ids that sit between
> them**, including the ones that are red and the reason they are — otherwise the first
> auditor to walk the branch finds a red conclusion at the packet's own carrying commit
> and no sentence anywhere explaining it. **Polarity (§0.2): this is a claim that a red
> run is NOT a suite failure, and it is measured over every step of both jobs of that
> run, not over the run's summary line.**

#### 2.9-R2 THE CI EVIDENCE AT `41fead6` (round 4) — and the whole interval walked, because that is the rule this packet's own last harvest banked

**`build` run `31453108454`**, `head_sha` **`41fead67b9fa7ec22f54e807f830c0b64faefb9c`**,
event `push`, conclusion **`success`**, started 2026-08-11T02:41:06Z.

**Job `93661268366` (`build`) — conclusion `success`, all thirteen steps `success`**:
1 *Set up job*, 2 *checkout*, 3 *Set up OCaml*, 4 *Install dependencies*, 5 *Build*,
6 *Run tests (expect tests, waveform snapshots)*, 7 *Generate RTL*, 8 *Verify nothing was
left unpromoted or non-deterministic*, 9 *DV mechanical checks (C-9 record-vs-appendix,
X-9 emitted Verilog)*, 10 *Abort-bit availability quantifier (C-37/ADR-0012, 8.7M pairs)*,
19–21 the post/complete steps. **Job `93661268386` (`cosim`) — conclusion `success`**, its
nine steps all `success`, **quoted separately and deliberately** (§2.3-M(2), SC-6).
**`journal-check` run `31453108435`** at the same `head_sha`, conclusion **`success`**.
Locally at `41fead6`, `git status --porcelain` returns **zero lines**.

**THE INTERVAL, WALKED RATHER THAN SAMPLED — and this is `LC-dv_lead-H2-2` applied to the
round that banked it.** My own second harvest note (`J-dv_lead-0167`) banked the rule
*"when a record's evidence is references to external executions, it accounts for the
failed executions falling between the ones it cites"*. **A rule banked and then not
applied by its own author in the very next round is a rule nobody has ever run.** So every
run on the branch between the two sign-off SHAs is listed, with its conclusion:

| commit | `build` | `journal-check` | `site-deploy` |
|---|---|---|---|
| `5d50ab7` (round 3's own `FAIL` lands) | `31451461231` **success** | `31451461221` **success** | `31451461201` success |
| `b4814b0` (the successor harvest note) | `31451519563` **success** | `31451519546` **success** | `31451519542` success |
| `85753b6` (Amendment A2) | **no run of any workflow exists** | — | — |
| `41fead6` (acceptance act; **the sign-off SHA**) | `31453108454` **success** | `31453108435` **success** | `31453108441` success |

**The one anomaly is named rather than left to be found.** **`85753b6` has no CI run at
all**, and the reason is mechanical rather than interesting: it and `41fead6` were pushed
in one push, and a push event creates one run per workflow **on the head commit**. So the
amendment's own commit was never independently built. **What that does and does not
mean**: it does **not** weaken `SC-3`, whose subject is the sign-off SHA `41fead6`, which
has its own green run over the identical tree-plus-one-journal-append; and the amendment
touches no buildable artefact (`docs/adr/**` and a journal). **But a packet whose evidence
is run ids owes the reader the commits in its interval that have none**, or the first
auditor to walk the branch finds a governing document that landed with no green beside it
and no sentence explaining why.

**Three dimensions (§0.2, SC-10).** **SHA**: every id above read at `41fead6` from the
branch's own run list, not carried from round 3. **DOMAIN**: **every workflow run on
`claude/fpga-hardcaml-agent-orchestration-37ceyf` in the window `14615f8` (exclusive) →
`41fead6` (inclusive)** — all three workflows, not the `build` job alone. **POLARITY**:
the claim is an **absence** — *no red conclusion on `build` or `journal-check` anywhere in
this interval* — and it is measured over the complete run list, which is also how the
`85753b6` hole was found. **The two `cancelled` `site-deploy` runs visible in the same
listing (`d53d795`, `185ae66`) are BEFORE `14615f8`**, inside round 3's window and outside
this one; they are named so the reader does not have to work out that they are out of
scope.

### 2.10 THE LINE-RATE STRESS (SC-4) — at `2183d71`

**`M03-L1`** drives §8's stress run: **10 000** consecutive 64-octet frames, start lanes
alternating 0 and 4, start-to-start spacing alternating 10/11 cycles — the minimum
inter-frame gap — with every frame's eight output words asserted (`tkeep` 0xFF on words
0–6, 0x0F on word 7, `tlast` on word 7 alone, `tuser`[0] = 0), its sixty delivered octets
read **positionally**, and the empty strobe set. **Green in `build` run `31444471834`,
job `93635620822`, step 6.** The unit's own guard asserts the schedule carries exactly
`10_000` frames before the DUT is read.

**ZERO RX BACKPRESSURE — and the discharge is STRUCTURAL, which is stated rather than
dressed up as an observation.** **`M03-L6` (`STRUCTURAL`, REQ-112 and REQ-003)**: the
module exposes **no `tready`** on the stream under test and **no `tready` input exists**.
There is no signal a consumer could assert, so *"zero backpressure asserted"* is
discharged by the interface and by a script check, **not by a waveform** — which is
precisely what the `STRUCTURAL` status exists to prevent an `SO-` from claiming
otherwise (§1's vocabulary: *"Recorded so no `SO-` claims a behavioural test that does
not exist"*).

**THE PINNED PER-OCTET CONSTANTS, NAMED BESIDE THE STRESS ROW BECAUSE `AP-M03` §7 BAR 3
MAKES THEM LOAD-BEARING IN A WAY NO OTHER ROW'S CONSTANTS ARE.** With the cross-side
timing comparison **barred** (§5.3), these are **the programme's only detector of a
uniform word-delay regression**:

- **`M03-L2`** — one latency class per start lane over the same run: **L = 16 at h = 8**
  and **L = 12 at h = 12**, both with word delay **`Some 3`**, 5 000 frames and 300 000
  octets in each class, each matched by its own front-offset field and asserted whole.
- **`M03-L3`** — the whole-run word delay **`Some 3`**, a clean tagger, 10 000 frames
  and 600 000 octets; **ΔC = 3 against the §1.1 ceiling of 4**, M03's one-cycle reserve.
  **Its ΔC content is discharged by `WO-0070` §6's derivation about the specification
  and by no run** (`U-2`, §2.6) — stated here so the stress row's green is not read as
  covering it.
- **`M03-L5`** — the same two constants over the directed set, frames of 64 … 71 and
  1518 octets at both start lanes.

**`M03-L4` is `U-1`-marked**: its sequence read-back is preceded, positionally, by
`M03-L1`'s own octet comparison, **so it is qualified by citation to `M03-L1`'s pairing
or not at all**, and **no claim in this packet counts the two as two observations.**

### 2.11 THE THREE-DIMENSION RECORD (SC-10) — what this round measured, and what it refused to quote

| claim | SHA | DOMAIN | POLARITY |
|---|---|---|---|
| row inventory 78/62/7/4/4/1 | `2183d71` | every row table of `AP-M03` | positive; a status-cell pass, not a recollection |
| 62 of 62 ASSERT rows discharged | `2183d71` | **stated twice** — `test/xgmii_rx_64/*.ml` (62 titled) and every tracked `test/**/*.ml` (63 titled, the extra being `NO-ASSERT`ing `M03-N3`) | the outstanding set is an **absence** claim and is measured as the complement of the titled set over the whole `ASSERT` set |
| era tally 63/61/1/0/1 | walked at `2183d71` over the campaign packets | **the ten class-based campaigns `WO-0050` … `WO-0077`, and no others**; the four earlier campaigns are stated separately | the survivor and the void are named individually; no ratio is formed |
| no benched row is gated by bar 1 | `2183d71` | **both producers** — `test/xgmii_rx_64/**` and `test/cosim/**` | an **absence** claim, measured over every landed construction: the oracle join's call graph, every binding form, the second producer in full |
| no open `BUG-` | `2183d71` | the `agents/handoffs/BUG-*.md` glob | an **absence** claim, measured over the directory |
| seventeen error classes, 9 inside / 8 outside / 9 unreachable / 1 anchored | `2183d71`, against REQ-901 **with (g) and (h) in force** | every row of `AP-M03` §4.E–§4.H | the *"outside every declared class"* half is an absence claim over REQ-901's **whole** lettered list, re-read at this SHA rather than at the sweep's |
| **no total for the harvest bank** | — | — | **quoted nowhere until §4.4's walk produced one; the walk is the provenance and there is no other** |

**And two numbers this round refused to quote**: the *22-assertion* breadth figure
(superseded, §2.1-M) and any single kill ratio over the fourteen campaigns (**no such
denominator exists**, §2.2-M).

### 2.12 THE ROUND-4 RE-MEASUREMENT (`41fead6`) — every set claim re-taken, with its three dimensions

**Nothing below is carried from §1.2 or §2.x-M.** Each figure is the output of a command
re-run at `41fead6`, and where it equals a prior round's figure that equality is the
result, not the method.

| # | claim | figure at `41fead6` | SHA | DOMAIN | POLARITY |
|---|---|---|---|---|---|
| 1 | `AP-M03` row inventory | **78 rows / 62 `ASSERT` / 7 `NO-ASSERT` / 4 `NO-STIMULUS` / 4 `STRUCTURAL` / 1 `GAP`** | re-run at `41fead6` on blob `03cc7e7da6f2` | every row table of `AP-M03`, matched on the row-id cell | positive; a status-cell pass, not a recollection |
| 2 | suite inventory | **59** M03 units · **139** file-type-scoped repo-wide · **141** contaminated | `41fead6` | stated in **all three** domains, so the contaminated matcher's excess is visible rather than hidden in one number | `FINDING M-4` is an **unrepaired** defect and is reported as such; the honest and the contaminated figures are both quoted |
| 3 | traceability matrix | **110 rows / 34 populated / 76 empty / 13 `COVERED` / 97 `OPEN`** | `41fead6`, blob `648311e10ccc` (identical to `14615f8`) | all 110 rows, not the 34 delivered | the **negative** half is quoted first — **76 rows are still empty**, and they are other modules' rows, not this packet's to deliver |
| 4 | open `BUG-`s | **3 packets, 3 CLOSED, 0 open** | `41fead6` | the `agents/handoffs/BUG-*.md` glob | an **absence** claim, measured over the directory, each state string read out of its own packet |
| 5 | attack-plan precedence | `merge-base --is-ancestor df3e474 026a71f` → **0**; **49** commits | `41fead6` | the two commits themselves | positive; an ancestry test, not a date comparison |
| 6 | the barred anchor sentence | **4** occurrences, **4 of 4 inside a statement of the prohibition** | `41fead6`, this file | the whole file, round 4's own text included | an **absence-of-assertion** claim, measured by reading every occurrence rather than by counting to zero |
| 7 | CI in the interval | **9 runs over 4 commits** (3 workflows × 3 commits; **`85753b6` has none**); **0 red on `build` or `journal-check`** | `41fead6` | **every** workflow run on the branch in the window | an **absence** claim over the complete list — which is how the `85753b6` hole was found (§2.9-R2) |
| 8 | `J-orchestrator-0234`'s discharges | **18 of 18** carry a stated grade **and** an LH3 clause; **18** numbered items matching `<n>. LH2-g. LH3:` | `41fead6` | the entry sliced at its own header to the next `## [J-` header — **the note, not the summary line** | both halves measured: the **positive** (18 present) and the **negative** (0 items missing either), and the prior round's counts re-run on `-0233` to confirm they still return LH1=18 / LH3=1 |

**What this round refused to quote.** (a) **A re-derived total for any seat's harvest
bank**: every per-seat count in §4.10 is the count that seat's own note states, read at
that note, and any sum is shown with its addends — `SC-12`'s *"no total is quoted that was
not measured by walking the chain"* applies to **my** walk, and I did not re-walk 232, 94,
50 or 18 entries of another agent's chain. (b) **Any grade I did not read stated.**
`OBSERVATION SO-O1` reports a lexical measurement over eighteen statements and assigns no
grade and no pack (§4.10).

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

> **DATED ANNOTATION, 2026-08-11, `J-dv_lead-0165`, and it is this block's own rule
> turned on the sentence above.** *"304 is the figure at the sign-off SHA"* is **true at
> `2183d71`** — the check re-run there returns 304 — and **round 2's own text moves it
> to 305**, because §6.4 adds one further `docs/specs/**` citation that resolves.
> Verified after the edits: **`305 / 296 / 0 / 5 / 4 / 0 / 0`, exit 0, 0
> `PENDING-COMMIT`**, so the counts are a fresh clone's counts and nothing is
> conditional on the commit. **The sentence is annotated rather than rewritten**, and
> the `+1` is declared for the same reason round 1R declared its `+2`: a citation count
> that moves because the counting document grew is drift unless its author says which
> text grew it.

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

#### 3.9-M RE-MEASURED AT `2183d71` (§7.1 step 9) — the standing set, checked rather than recopied

**§3.0 raised a finding against this list once already** (`FINDING RV-0075-1` carried as
standing while CLOSED). **The list is therefore re-checked here, not recopied**, and
three entries move:

| entry | state at `2183d71` | evidence |
|---|---|---|
| **`FINDING RV-0075-1`** | **CLOSED**, and struck from the standing set | absorbed into Stage 1 by `WO-0078` §5.1; the repair is landed in `test/cosim/canonical.ml`'s `timing_report_to_string`, which cites it by name |
| **`FINDING ECS-4` / `ECS-5`** *(carried at §6.3 as pending)* | **CLOSED AS PREDICTIONS, OPEN AS EXCLUSIONS** | REQ-901 classes **(g)** and **(h)** are IN FORCE at `4e7331b`, with `FINDING CSG-1` and `CSG-2` repaired at `ce5674d`. §6.4 |
| **`FINDING M-4`** | **UNREPAIRED, and its figure MOVED** | 141 contaminated / 139 honest at `2183d71`; the contaminating files are `test/cosim/dune` and `AP-M03` itself (§2.1-M) |
| **`FINDING RV-0078-S2-3`** — §7's exhaustiveness claim, one carrier: the co-sim Phase 3 CD instance round | **STILL `SCOPED, NOT AUTHORISED`, AND THE CONDITION IT WARNED OF IS NOW TRUE** | §6.4 measures Stage 3 **refused on three of five conditions**, so Phase 3 does not open before this packet lands. **The defect therefore outlives this packet's active life with no owner in flight** — the draft required this round to *"check and record that"*, and this row is that check |
| everything else at §3.9 | **carried unchanged, with the carriers named there** | `S2-9`, `S2-10`, `S2-12`, `S2-15`, `S1-3`, `S1-4`, `WO-0078-1`, `CD-P2-1`, `CD-P2-2`, `RV-0075-2`'s residual limb, `ECS-3`/`ECS-6`/`ECS-7`/`ECS-8`, `WO-0047` §2's 4-octet member, `OBSERVATION L-O1`, `WO-0073-D3`'s `M03-I4` mislabel, `OBSERVATION K-O1`, `DVC-1a`/`DVC-1b`, `AP-M14` §6's invariant, the RFC 1071 anchor, X-10/X-11 |

**Four findings are MINTED by this round and join the standing set with their
carriers**: `FINDING SO-1` (the traceability delivery — carrier named at §2.8, and it is
one of the two acts §8 requires), `FINDING SO-2` (the census block's undeclared producer
domain — carrier: the next round opening `tools/`), `FINDING SO-3` (the 22-assertion
figure superseded — carrier: the next `AP-` opener), `FINDING SO-4` (`AP-M03` §7 row
(b)'s command/figure mismatch — carrier: the next `AP-` opener).

### 3.10 EXECUTION RECORD — round 2, §7.1 steps 6–12 (`J-dv_lead-0165`, sign-off SHA `2183d71`)

**THE LEDGER IS CLOSED. Twelve of twelve.**

| # | item | state | where |
|---|---|---|---|
| **1** | `FINDING K-1` — message repair | **PAID**, round 1 step 2 | `test/xgmii_rx_64/test_m03_k.ml`. **Paid two rounds before family K's rows were written at step 8** — SC-11's ordering requirement met in the strongest available form |
| **2** | `RN-6` — the `docs/**` resolve-check | **PAID**, round 1 step 3; **REPAIRED**, round 1R; **GREEN ON A RUNNER**, this round | `tools/dv_checks.sh`; run `31444471834` step 9 `success`. Every SC-1/SC-10 census quote in this packet is taken with **this** script (§2.1-M) |
| **3** | `FINDING RV-0078-S2-2` — per-class absolute/agreement accounting | **PAID**, step 8 | §2.3-M(3) writes REQ-104's row **as the pair**, with the instrument for each half named, and §2.3's cells carry the same shape per class. **α stands for both nowhere in this packet** |
| **4** | `FINDING RV-0078-S2-7` — the residue statement | **PAID**, step 9 | §3.4's residue is stated **as a residue** and re-affirmed by item 6: the repaired no-result branch's correctness rests on a harness property CI has still never executed |
| **5** | `FINDING RV-0078-S2-11` — the binding rule | **RULED**, round 1 step 4; **REDEEMED**, this round | the comparator prints the agreed values on the passing path, and the print is **quoted from step 7's own job** at §2.3-M(3). The forward commitment of §3.5's `RULED` block is discharged by a run id rather than by a promise |
| **6** | criterion 3's unexercised plural property | **RECORDED**, step 9 | §3.6 unchanged in substance and re-measured here: run `31444471834`'s `cosim` job prints *"every case in the set reached a verdict and every verdict was clean"* — **five clean cases, so the aggregate-continuation path did not fire this round either.** The property remains **undemonstrated**, the closing condition is unchanged, and **the acceptability question stays routed to the auditor and is NOT self-adjudicated here** (`J-dv_lead-0159` Open-question 1, still unanswered) |
| **7** | `FINDING WO-0077-A1` — census-repair ownership | **PAID AND OWNED**, step 6 | §2.11 applies the rule to **this packet's own universals** with the producer set named on each — and §2.1-M is the rule **firing against my own census block**, producing `FINDING SO-2`. **This packet is the rule's owner and no later artefact inherits the obligation by default** |
| **8** | `FINDING ECS-1` — the corrected F-1 disposition | **PAID**, step 6 | §2.4-M writes every disposition **from the sweep's table re-read against REQ-901 at this SHA**, never from `AP-M03` §4.F's stale family note. F-1 stays **INSIDE (e) on `tuser`[0] alone**, its five octets inside (e)'s 5-to-63 band, with the delivered octet and the `tkeep` extent **inside** the comparison domain |
| **9** | `FINDING ECS-2` — the reachable-window sentence | **PAID**, steps 6 and 9 | `MAX_WORDS_PER_FRAME = 16` re-measured at `test/cosim/tb_xgmii_rx_64.v:258`; the reachable window is **64 ≤ n ≤ 132**, and §5.6 carries it beside **every** citation of REQ-901's 64-to-1518 range in this packet |
| **10** | `U-1`/`U-2` pricing | **ANSWERED**, round 1 step 5 | §3.8's `RULED` block — form (b), refused with a price, a bound and a three-trigger expiry. The bound is honoured at §2.10 and §5.7 |
| **11** | the 22-assertion breadth figure | **CLOSED BY RE-MEASUREMENT**, step 6 | §2.1-M. It does **not** reproduce; the measured figure is **7 of 29**; `FINDING SO-3` records it and the conclusion it supported survives a fortiori |
| **12** | the programme's first lessons harvest | **dv_lead's HALF COMPLETE; the HARVEST IS NOT**, step 10 | §4.4–§4.8. My span is walked end to end and my note is complete; **four of five persistent-journal agents have never harvested**, which is why `SC-12` is NOT MET (§1.1, §8) |

**Nothing on this ledger was discovered by the round that needed it.** **One obligation
NOT on this ledger was** — SC-2's third clause — and that is `FINDING SO-1`, §2.8.

### 3.11 EXECUTION RECORD — round 3, THE RE-VERDICT (`J-dv_lead-0167`, re-verdict SHA `14615f8`)

**The round-2 ledger is closed and stays closed; this round has a two-item ledger of its
own, and it is §8.2's own list.** Both items were paid **in commits that precede this
read**, which is the ordering `SC-11` exists to enforce — neither was manufactured inside
the document that grades it.

| # | item (`§8.2`'s own words) | state at `14615f8` | evidence, measured |
|---|---|---|---|
| **A1** | *"Deliver the test-side traceability rows."* | **PAID, and TRANSCRIBED** | `WO-0079` at **`a43ac00`** (`J-dv_lead-0166`), transcribed at **`14615f8`** (`J-architect_docs_lead-0035`). §2.8-R: 34/34 cells string-identical, 0 rows populated that were not delivered, 34 changed rows = the delivered set. **`SC-2` moves NOT MET → MET, and `FINDING SO-1` is DISCHARGED by the carrier it named** |
| **A2** | *"Commission the other four harvests."* | **COMMISSIONED, FOUR NOTES LANDED, ONE NOT ADMISSIBLE** | `J-auditor-0019` (`185ae66`, 54), `J-orchestrator-0233` (`d53d795`, 18), `J-architect_docs_lead-0034` (`54b2553`, 94), `J-rtl_lead-0013` (`c55c754`, 50). **Three of four conform; the orchestrator's does not discharge LH3 on any candidate** — §4.9, `FINDING SO-6`. **`SC-12` stays NOT MET, on this ground and not on round 2's** |

**THE STANDING SET, RE-CHECKED RATHER THAN RECOPIED (§3.9-M's discipline, applied to
this round).** Three entries move and the rest are unmoved on a byte-identical tree:

| entry | state at `14615f8` | evidence |
|---|---|---|
| **`FINDING SO-1`** | **CLOSED**, struck from the standing set | §2.8-R; the delivery landed at `a43ac00` and was transcribed at `14615f8` |
| **`FINDING SO-5`** | **HALF DISCHARGED, HALF STANDING** | its **substance** half — four unmined spans — is paid; its **wording** half is untouched: `SC-12` still imports a **gate** condition onto a **packet**, and four of the block's eleven boxes remain acts no `SO-` author can perform. **This round does not rule on that half** — see §4.9's closing note — because ruling it would decide, inside the graded document, a clause that is not load-bearing for today's token |
| **`FINDING SO-1-A`** | **STANDING, and it gains a second instance** | `AP-M03` §6's homing gap now also carries `P-1` (§2.8-R): `WO-0079` §2.1's *"the unit whose title carries that row id"* is false at exactly one of 49 citations. **Same carrier: the next round opening `AP-M03`** |
| **`FINDING SO-6`** | **MINTED HERE**, carrier named | §4.9. Carrier: **the orchestrator's own next harvest round**, which is the only seat that may append to that journal (PROTOCOL §4) |
| `SO-2`, `SO-3`, `SO-4`, `M-4`, `RV-0078-S2-3`, `S2-9`, `S2-10`, `S2-12`, `S2-15`, `S1-3`, `S1-4`, `WO-0078-1`, `CD-P2-1`, `CD-P2-2`, `RV-0075-2`, `ECS-3`/`6`/`7`/`8`, `WO-0047` §2's 4-octet member, `OBSERVATION L-O1`, `WO-0073-D3`'s `M03-I4` mislabel, `OBSERVATION K-O1`, `DVC-1a`/`DVC-1b`, `AP-M14` §6, RFC 1071, X-10/X-11 | **carried unchanged, carriers as named at §3.9/§3.9-M** | none of their subjects moved: `test/`, `tools/`, `libs/`, `test/cosim/`, `docs/reports/audit/` and `docs/specs/requirements.md` are **byte-identical** `2183d71..14615f8` (§1.2) |

**And the ordering claim this round must make about itself.** `FINDING SO-6` was
**discovered by the round that reads the criterion it bears on** — which is the shape
`SC-11`'s last sentence names. It is recorded as a **finding with a carrier**, exactly as
`SC-11`'s §1.1 row ruled for `FINDING SO-1`, and it is **not** an obligation of mine that
I failed to schedule: it is the measurement `SC-12` asks for, returning a result. **The
distinction is load-bearing and is stated rather than assumed**: a criterion that says
*"measure whether X is complete"* cannot be failed by the measurement discovering that X
is not.

### 3.12 EXECUTION RECORD — round 4, THE PASS (`J-dv_lead-0168`, sign-off SHA `41fead6`)

**The round's ledger is three items and I paid none of them**, which is the property that
makes this round's `PASS` a reading of other seats' acts rather than a self-service.

| # | item | state at `41fead6` | where it landed | measured at |
|---|---|---|---|---|
| **1** | **`FINDING SO-6`** (MAJOR, mine, against `J-orchestrator-0233`'s contents) — the successor note discharging **LH3** per candidate, running the classifier from step 0, recording each candidate's **grade**, **no renumbering** | **DISCHARGED** | `J-orchestrator-0234`, commit **`b4814b0`** | §4.10, at the journal — 18/18 grade, 18/18 LH3, ids `LC-orchestrator-H1-1 … -18` unrenumbered |
| **2** | **`FINDING SO-5`, wording half** — `SC-12` demanding *"every box checked"* of a packet while four boxes are the collator's later acts; carrier named by round 3 as *"an ADR-0018 amendment (PROTOCOL §11)"* | **SETTLED BY AMENDMENT** | **ADR-0018 Amendment A2**, commit **`85753b6`** (`J-architect_docs_lead-0036`), **in force at `41fead6`** on acceptance act `J-orchestrator-0235` | §1.3 — read at the ADR in full, and at PROTOCOL §11's three limbs |
| **3** | **`FINDING SO-5`, substantive half** — the harvest is a **five-agent** act and four spans were unmined | **DISCHARGED at round 3 and re-verified here**; A2.3 states in terms that the five-seat obligation is **untouched** by the partition, and boxes 1 and 2 stay in Part A precisely so it cannot be reduced quietly | `185ae66`, `d53d795`, `54b2553`, `c55c754`, + `b4814b0` | §4.10's five rows |

**NEW ON THE STANDING SET, with its carrier named and NOT paid here.**

- **A2.4's five clerical edits to `docs/gates/lessons-harvest-block.md`** — the preamble's
  line-5 over-reach, §1 item 4's site qualifier, §1 item 2's id form, §3's checklist
  splitting into Part A / Part B with **all eleven box texts unchanged**, and §4's two new
  transcriber lines. **Text fixed at A2.4; carrier: the architect's next `docs/gates/`
  round**, which A2.4 and `J-orchestrator-0235` both identify as the `P1-module-ready`
  checklist round already owed. **Not mine**: `docs/gates/**` is outside my write scope
  (PROTOCOL §6) and I stage nothing toward it. **Until it lands the block reaches the
  correct rule by its own deference clause** (§1.3's last paragraph).
- **`OBSERVATION SO-O1`** (§4.10) — recorded, **not charged**, owner and route named.

**THE STANDING SET, RE-CHECKED RATHER THAN RECOPIED.** Every item of §3.9 / §3.9-M and
§3.11 was re-read at `41fead6` against the paths that would have moved it, and the
producers are byte-identical (§1.4's identity block), so **not one subject moved and not
one carrier opened**: `FINDING SO-2` (the census block's undeclared producer domain, wide
pass returns 63), `FINDING SO-3` (the 22-assertion breadth figure does not reproduce;
measured **7 of 29**), `FINDING SO-4` (`AP-M03` §7 row (b), 24 raw vs 17 executable),
`FINDING M-4` (**141** contaminated vs **139** honest), `P-1`'s residue (`WO-0079` §2.1's
citation rule false at 1 of 49), `FINDING RV-0078-S2-3` and the rest. **`FINDING J-1`
remains closed.** **All of them ride into the `PASS` as listed bounds** (§8.R4.4) rather
than being retired by it — a `PASS` that closed a finding by being a `PASS` would be the
verdict grading its own inputs.

**ORDER, because `SC-11` grades order and not only payment.** Both acts this round reads
landed **before** the round opened: `b4814b0` and `85753b6`/`41fead6` are ancestors of the
sign-off SHA, and the sign-off SHA **is** the acceptance act's own commit. **No obligation
of this round was discovered by the section that needed it**, and nothing was paid inside
the document graded by it — which is the failure mode `FINDING SO-1` recorded against
round 2 and the one §7.1 step ordering exists to prevent.

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

### 4.4 THE WALK — executed (§7.1 step 10)

**Method, executed exactly as §4.3 specified it and not otherwise.** The chain was
walked from `J-dv_lead-0001` forward across all eight volumes, every harvest note read
**at its own entry**, every banked candidate extracted **at its source**, the whole bank
re-labelled **once** into a single `LC-`/`LD-` sequence allocated **in entry order**, and
the old label recorded beside each so every prior citation still resolves.

**Reproducible enumeration of the surface walked** (the extraction of rule statements
from prose is a reading, not a one-liner, and §4.5 is its product — `SC-10`'s *"described
as a method with the reason it cannot be a one-liner"* clause, applied):

```
$ for f in agents/journals/claude_dv_lead_agent.md \
           agents/journals/claude_dv_lead_agent.v0{2,3,4,5,6,7,8}.md; do
    echo "$f $(grep -c '^## \[J-dv_lead-' $f) $(grep -c 'LH2-g\|LH2-d\|LH-cand-\|LH1\|LH3' $f)"; done
  claude_dv_lead_agent.md      72   0
  claude_dv_lead_agent.v02.md  18   0
  claude_dv_lead_agent.v03.md  19  38
  claude_dv_lead_agent.v04.md  15  77
  claude_dv_lead_agent.v05.md  12  29
  claude_dv_lead_agent.v06.md  12  31
  claude_dv_lead_agent.v07.md  12  62
  claude_dv_lead_agent.v08.md   4  43     (+ this signing entry = 5)
```

**FOUR FACTS THE WALK ESTABLISHED THAT NO NOTE IN THE CHAIN STATES:**

**(1) The first ninety entries yield NOTHING, and the reason is not negligence.**
`J-dv_lead-0001 … -0090` — volumes 01 and 02, ninety entries — carry **zero** harvest
markers. `ADR-0018` landed **2026-08-04** at `ec5d906`; the first dv_lead harvest note is
at **`J-dv_lead-0098`**, and the first banked candidate at **`J-dv_lead-0099`**. **The
"harvest" occurrences in volumes 01–02 are the OTHER sense of the word** — a
mutation-campaign promotion harvest — which is `ADR-0018` §7.5's own named hazard,
observed here in my own chain. **Yield over `J-dv_lead-0001 … -0097`: NIL, declared, with
its cause.**

**(2) The bank is FOUR labelling regimes and the draft's reconstruction of them is
confirmed at every cited entry**, with **one regime under-counted by the draft itself**:
§4.3 records regime 3 as banked at *"`-0126` (three), `-0127` (two), `-0128` (two),
`-0129` (one), `-0130` (one), `-0131`, `-0132` (two), `-0133` (one), `-0134` (two),
`-0135` (one further)"* — leaving `-0131` without a count. **`J-dv_lead-0131` banks
TWO**, so regime 3 is **seventeen**, not the sixteen a reader would total.

**(3) A FIFTH accounting defect, which no prior note names: THE SAME RULE IS BANKED
TWICE UNDER TWO REGIMES, NINE ENTRIES APART.** `J-dv_lead-0107` banks *"a disclosure
question with n values must state the dimension it ranges over"*; `J-dv_lead-0116` banks
*"a question offered as a choice between n values asserts that the answer lies among
them; state the quantity the values range over"* — **as a new candidate, called *"the
sharpest candidate this round"***, and `J-dv_lead-0117` then refers to it as
*"`J-dv_lead-0116`'s malformed-question candidate"*. **They are one rule.** The
re-labelling **merges them with both provenances** and the merged candidate is
**stronger for it: four incidents, at `-0107`, `-0108`, `-0109` and `-0117`.**

**(4) A SIXTH, in the other direction: A RULE BANKED AS NEW WAS ALREADY THE SET-CLAIM
RULE.** `J-dv_lead-0120` banks *"a measurement is a claim about a tree, not about a
program"* as *"a new candidate"*; `J-dv_lead-0118` had already restated
`J-dv_lead-0117`'s census rule as *"re-measure at every re-statement, **or quote the
measurement with the state it was taken at**"*, and `J-dv_lead-0124` closes the loop
itself — *"a second confirming instance for the set-claim rule … the rule's second half
earned its keep here: not 'measure it' but 'state what state the measurement was taken
in'"*. **One rule, five incidents, banked twice.** Merged, both provenances kept.

**(5) THE WAR-STORY SET WAS SILENTLY REPLACED, NEVER EXTENDED.** At `J-dv_lead-0103`
the carried set is `{the six-versus-seven miscount, the operator-precedence
reproduction}`; from `J-dv_lead-0119` onward every note says *"both war stories"* and
means `{Idle_injection, the strike notation}`. **Two different pairs, the same phrase,
no note recording the substitution.** Four further war-story-shaped items were recorded
once each and never entered the carried set at all. **The walk recovers all nine (§4.6);
none was ever lost, but none of the four was findable from the carried phrase.**

### 4.5 THE YIELD — the reconciled bank, in entry order, with old labels beside

**THE COUNT IS THE PRODUCT OF THE WALK AND OF NOTHING ELSE.**

| | measured |
|---|---|
| bankings walked, dv_lead's chain, `J-dv_lead-0001 … -0165` | **89** |
| bankings walked, the worker spans I commissioned | **9** |
| **gross bankings walked** | **98** |
| merges applied — **same rule, both provenances kept**, never merely a shared letter | **3** (defects (3) and (4) above, plus one cross-seat merge, §4.7) |
| **DISTINCT CANDIDATES** | **95** |
| grade `LC-` (tier 1, general) | **94** |
| grade `LD-` (tier 2, domain) | **1**, pack `version-control` |
| war stories (tier 3, kept and re-offerable) | **9** (§4.6) |

**No prior figure in this chain equals 95, and none was consulted to produce it.** The
regime-4 tildes (*"~19 … ~20 … ~24 … ~25"*) ran only to `J-dv_lead-0124` and over one
regime; the *"nine"* of `WO-0077` §13 and the *"eleven"* of `J-dv_lead-0159` each counted
one regime. **This is the first measured total, and it is measured over the span the
harvest block's own checklist fixes: the agent's first entry to the signing entry.**

**THE CLASSIFIER (§2.1, run on every candidate from the most general honest
statement).** Step 0 was attempted for all 95. **Ninety-four survived step 1 with no
proper noun**; one — `LH-cand-Q` — went hollow when its store-shaped noun was removed
(*"a container that holds nothing cannot be recorded"* is false of most stores), which
is the tie-break's own evidence that the domain noun was load-bearing, so it is graded
**`LD-`**, pack **`version-control`**, exactly as its author graded it.

**Ids are `LC-SO-xgmii_rx_64-<n>` and `LD-SO-xgmii_rx_64-<n>`, numbered independently
and never reused.** Statements are abridged to their first clause; **the cited entry
carries each whole and is the authority**.

| new id | old label | entry(s) | rule statement, abridged |
|---|---|---|---|
| `LC-…-1` | — | `0099` | an idiom that partitions a stream by its own terminator presumes every partition is non-empty |
| `LC-…-2` | — | `0100` | a helper lifted out of its first caller inherits that caller's name, so the name describes the situation rather than the obligation |
| `LC-…-3` | — | `0101`, `0104`, `0105` | an instruction that exempts an artefact from review by asserting it correct; **extended**: a change proposal states which existing claims its own instructions make false |
| `LC-…-4` | — | `0102` | a negative claim about an instrument must be derived from its **matching rule**, never from its documentation |
| `LC-…-5` | — | `0103` | a precaution vindicated because the number was right must record **both** the confirmation and the price the precaution charged |
| `LC-…-6` | — | `0104`, `0105`, `0108`, `0109` | search an open enumeration by the **defect** it enumerates, never by the string its known instances share |
| `LC-…-7` | — | `0106`, `0107`, `0109` | a correction to an enumeration must be produced by the method that would have produced the enumeration correctly, never derived from the erroneous version |
| `LC-…-8` | **(merge)** | `0107`, `0108`, `0109`, `0116`, `0117` | a question offered as a choice between n values asserts the answer lies among them; state the dimension the values range over |
| `LC-…-9` | — | `0108`, `0109` | a set built by a mechanical pass must state the relation its pass assumes, and a one-to-one assumption is checked against the many-to-many case |
| `LC-…-10` | — | `0111`, `0113`, `0115` | a bound stated as a conjunction is discharged only by a stimulus containing every conjunct |
| `LC-…-11` | — | `0112`, `0113` | a list of pre-committed reject conditions guarantees the reviewer's independence, never coverage |
| `LC-…-12` | — | `0113`, `0115` | when a repair is defended on a property of the objects it handles, check whether the same site handles an object lacking it |
| `LC-…-13` | — | `0114` | when identifiers are matched into free text, require a boundary wherever one is a prefix of another |
| `LC-…-14` | — | `0115`, `0117` | a stimulus pinning two events to one instant is an instrument for one defect class and a blindfold for another |
| `LC-…-15` | — | `0116` | when a prediction and an independent derivation disagree, resolve it from the shared source both claim to derive from |
| `LC-…-16` | **(merge)** | `0117`, `0118`, `0119`, `0120`, `0124` | a sentence asserting the result of a census is not the census; re-measure at every re-statement, **or state what state the measurement was taken in** |
| `LC-…-17` | — | `0117` | predict a set by stating the rule that generates it, not by listing its known members |
| `LC-…-18` | — | `0118` | a tool commissioned in response to a failure must be checked against the instances that commissioned it |
| `LC-…-19` | — | `0118` | keep the counter that measures an instrument separate from the counter that measures obligations discharged |
| `LC-…-20` | — | `0119` | where a stimulus is generated by two mechanisms, a coincidence constraint is checked against the stimulus **as delivered** |
| `LC-…-21` | — | `0119` | a stated kill is a claim about a stimulus and is re-derived from that stimulus each time the row is commissioned |
| `LC-…-22` | — | `0120` | count a construct by the element its grammar makes mandatory, never by the identifiers its authors chose |
| `LC-…-23` | — | `0121` | when a specification states an outcome as covering two alternatives, check each against the same document's own exclusions |
| `LC-…-24` | — | `0122` | every instruction in a review bar must be executable, as written, by the party the bar assigns it to |
| `LC-…-25` | **(cross-seat merge)** | `0122`, `J-tb_writer-0028` | when a specification orders a set of values checked, it must derive **every** value in that set |
| `LC-…-26` | — | `0123` | an authorised deviation from a pre-committed check must name the check and state the exception in that check's instrument's terms |
| `LC-…-27` | — | `0123` | a rule minted inside a document must be run over the rest of that same document before the document ships |
| `LC-…-28` | — | `0124` | when a reviewer's instruction characterises a source document, open the source before writing the characterisation down |
| `LC-…-29` | — | `0124` | a round with an enumerated scope repairs what it was given and **reports what it finds**, with its class named |
| `LC-…-30` | — | `0126` | score a prediction by the provenance of its dominant term, not by its subject |
| `LC-…-31` | — | `0126` | a rule stated as bands must be shown exhaustive **and** disjoint before it is committed |
| `LC-…-32` | — | `0126` | a tool that captures a subprocess's output and replays it stamps the replay, not the execution |
| `LC-…-33` | — | `0127` | where a seat is obliged to state a fact it has no instrument to measure, name the substitute |
| `LC-…-34` | — | `0127` | a disclosure that lives only in a channel the record does not keep is a disclosure the next reviewer will not have |
| `LC-…-35` | — | `0128` | prefer a discharge the instrument can see over a discharge the reader must be told about |
| `LC-…-36` | — | `0128` | when a claim is repaired by adding a second witness, re-point every index that names the first |
| `LC-…-37` | — | `0129` | a review instrument's stated expected value is a claim and must be derived from the same source the work is |
| `LC-…-38` | — | `0130` | a guard's entry condition must project the guard's own subject, re-derived for each thing guarded |
| `LC-…-39` | — | `0131` | a review bar quantifying over a whole tree must be executed against the unchanged baseline before it is issued, or restated as a delta |
| `LC-…-40` | — | `0131` | a table of derived quantities and a list of required assertions are different objects; mark each quantity required or carried **at the quantity** |
| `LC-…-41` | — | `0132` | a self-deleting artefact needs a named executor as well as a named condition |
| `LC-…-42` | — | `0132` | a function whose branches are selected by a caller-supplied value owes a witness of **which branch ran** |
| `LC-…-43` | — | `0133` | an assertion whose subject a sibling already compares, positionally and earlier, is unreachable, and its green is evidence about the sibling |
| `LC-…-44` | — | `0134` | a packet defining its own frozen baseline must name the commit that stages it, never that commit's parent |
| `LC-…-45` | — | `0134` | a claim that two events cannot be told apart must state the scope at which it holds |
| `LC-…-46` | — | `0135` | a prediction of which tests detect a defect must be keyed on the condition the defect fires on, never on the category the tests belong to |
| `LC-…-47` | `(i)` | `0137` | a rule naming the condition a class keys on must also name every gate the rendering may **not** remove |
| `LC-…-48` | `(ii)` | `0137` | a collision inventory is derived from the cross product of predictions with observations |
| `LC-…-49` | `(iii)` | `0137` | where a condition has more than one reporter, a coverage claim names which reporter each bound assertion observes |
| `LC-…-50` | — | `0139` | an inventory of a language construct must be scoped by file type, never by directory |
| `LC-…-51` | — | `0139` | where one exit code covers several stages, the stage must be named in the text |
| `LC-…-52` | `(A)` | `0140` | an observable expressed as an absence cannot distinguish never-produced from produced-and-suppressed |
| `LC-…-53` | `(B)` | `0140` | a harness's own refusal guard is evaluated before the component under test is read, so no mutation of it can score the guard |
| `LC-…-54` | `(C)` | `0141`, **`RN-6`** | a path cited in a normative instrument is verified to resolve at the tree the instrument governs, before the instrument is issued |
| `LC-…-55` | `(D)` | `0142` | an artefact quoting a component's diagnostic message derives it from that component's source at the frozen revision |
| `LC-…-56` | `(E)` | `0142` | when a document asserts a count of its own marked cells, the count is re-derived from the table |
| `LC-…-57` | `(F)` | `0143` | a document absorbing another's result re-derives every quantity it carries forward, and marks any it could not |
| `LC-…-58` | `(G)` | `0144` | a test case that is the only exerciser of a branch may not be specified as optional |
| `LC-…-59` | `(H)` | `0144` | a guard specified against a condition of the input cannot be implemented by a detector reading the output unless the mapping is injective |
| `LC-…-60` | `(I)` | `0145` | an assertion that names its expected value without reporting the observed one collapses every distinct cause into one indistinguishable effect |
| `LC-…-61` | `(I)` **dup label** | `0147` | a universal asserted over one stimulus producer is measured over **every** producer that drives the unit under test |
| `LC-…-62` | `(J)` | `0148` | a set enumerated from how its members are **named** is a different set from the one a rule selects |
| `LC-…-63` | `(K)` | `0148` | a silence assertion over an interval where a conformant component is already silent measures only defects that **add** |
| `LC-…-64` | `(J)` **dup label** | `0149` | when an instrument is measured capable on exactly one configuration, freeze it and add new ones beside it |
| `LC-…-65` | `LH-cand-A` | `0152` | a census of refusal guards records, per guard, the state variable it tests and the interval over which it is true — never the condition its message names |
| `LC-…-66` | `LH-cand-B` | `0152` | in a differential harness the bookkeeping layers on the two sides are common-mode |
| `LC-…-67` | `LH-cand-C` | `0153` | when a review recommends a settlement on a stated ground, the round that executes it re-measures that ground at the source |
| `LC-…-68` | `LH-cand-D` | `0154` | a repair that changes which inputs a component **accepts** also changes which outputs it **produces** |
| `LC-…-69` | `LH-cand-E` | `0154` | a record format in which the owner is implied by position is unambiguous only while one owner can be open at a time |
| `LC-…-70` | `LH-cand-F` | `0155` | a bound introduced to make a buffer finite is sized against the workload in front of its author; state the range it must cover in the same change |
| `LC-…-71` | `LH-cand-G` | `0155` | when a format loses a fact, move the fix upstream to where the fact is still observable |
| `LC-…-72` | `LH-cand-H` | `0155` | a frozen prediction is spent by a comparison that could have falsified it — count comparisons, not runs |
| `LC-…-73` | `LH-cand-I` | `0156` | where the interesting fact is a value rather than a relation, print the agreed value on the passing path |
| `LC-…-74` | `LH-cand-J` | `0156` | a quantity whose comparison is barred does not become assertable by reproducing; reproduction earns confidence, never jurisdiction |
| `LC-…-75` | `LH-cand-K` | `0156` | when the reason a standing refusal rested on expires, replace the reason before restating the conclusion, and attach a condition |
| `LC-…-76` | — | `0157` | a readiness census over the layers that **consume** an input is not a readiness census; "no mechanism exists" is a measurement over a stated set or a guess |
| `LC-…-77` | — | `0158` | an answered question re-asked without citing its answer is a new question to everyone downstream |
| `LC-…-78` | — | `0158` | a per-unit cost claim is read on a per-unit measurement, never on a total containing a unit-invariant part |
| `LC-…-79` | — | `0160` | a divergence-class question is answered per equivalence class of the exclusion's own axes, never per family and never per case |
| `LC-…-80` | `LH-cand-L` | `0163` | a bar over a corpus whose entries may not be edited needs a declared exception list, and an exception that no longer fires must fail |
| `LC-…-81` | `LH-cand-M` | `0163` | a carried-obligation list is a claim about the present and goes stale like any other measurement |
| `LC-…-82` | `LH-cand-N` | `0163` | a record of what two implementations agreed on may contain only the quantities that were compared |
| `LC-…-83` | `LH-cand-O` | `0163` | where a change is cheap but the instrument that would give it meaning is expensive, the refusal is priced by the instrument |
| `LC-…-84` | `LH-cand-P` | `0164` | a check that judges committed artefacts must resolve every reference against the version-controlled tree, never the working filesystem |
| **`LD-…-1`** | `LH-cand-Q` | `0164` | a store that records only leaf objects cannot represent an empty container, so a namespace that must be citable needs a committed leaf inside it. **Pack: `version-control`** |
| `LC-…-85` | `LH-cand-R` | `0164` | an exception-list entry whose expiry is already fixed by a scheduled obligation is a deferred failure with a known date, not a disposition |
| `LC-…-86` | `LH-cand-S` | `0164` | an instrument that grades documents by a rule may not itself violate that rule |
| `LC-…-87` | — | `J-tb_writer-0022` | a blind text-pattern equivalence check cannot distinguish payload from prose; enumerate what the check **cannot** match, not only what it does |
| `LC-…-88` | — | `J-tb_writer-0023` | where an upstream instruction would skip a standing onboarding step, the standing rule wins by default |
| `LC-…-89` | — | `J-tb_writer-0024` | route a call to the sibling helper whose **stated precondition** it satisfies, not to the one whose type signature it fits |
| `LC-…-90` | — | `J-tb_writer-0025` | a guard asserting a negative property is at highest risk of encoding the inverse of its own table; prefer a positive, table-keyed assertion |
| `LC-…-91` | — | `J-tb_writer-0026` | a checker that stops before name resolution cannot see an unbound name; compare the token against a corpus known to run |
| `LC-…-92` | — | `J-tb_writer-0027` | an absolute prohibition is crossed in a task's opening moves, by habit, before its text has been read in full |
| `LC-…-93` | — | `J-tb_writer-0029` | weight precedents by their **unanimity**, not by their existence |
| `LC-…-94` | — | `J-tb_writer-0030` | intake and application are two separate acts; satisfying the first is not evidence the second happened |

**LH1 and LH3 are discharged per candidate at the cited entry** — every one of the 98
bankings carries an incident and a stated failure in its own note, and the walk
confirmed the pair at each. **Not one candidate was admitted on a note that lacked
either**, which is the check the block's fourth box asks the transcriber to make against
the note rather than against the summary line.

**THREE OVERLAP CLUSTERS, declared to the collator rather than resolved here** — each
is *related* rather than *the same rule*, so the merge rule (`same rule`, never `shared
subject`) forbids collapsing them, and a collator should nevertheless read them
together: **the census cluster** `-16` / `-56` / `-57` / `-76`; **the exception-list
cluster** `-80` / `-85` / `-86` / `-54` (the overlap `J-dv_lead-0164` itself declared);
**the boundary-application pair** `-92` / `-94`.

### 4.6 THE WAR STORIES — nine, each with the criterion it failed

| # | war story | entry | criterion failed | why |
|---|---|---|---|---|
| **W1** | *a count taken from the artefacts an investigation happened to open is a sample, not a census* | `0100`, closed `0101` | superseded | the miscount was corrected from the tree; **its portable content survives inside `LC-…-16`** |
| **W2** | parenthesise mixed bitwise and arithmetic operators | `0103` | **LH2** (both grades) | the portable content is a coding convention, not a process rule |
| **W3** | *agreement between two methods is not corroboration when neither was checked against the thing being counted* | `0114` | **LH2** as written | could not be stated without leaning on the round's coincidence |
| **W4** | *a claim about what a test suite depends on must be re-measured, not carried, when the suite grows* | `0115` | **LH2-g and LH2-d** | reads as project hygiene rather than as a portable rule |
| **W5** | *an adversary's contradiction of your own prediction is stronger evidence of independence than any assurance* | `0116` | **LH2** | could not be stated without the round's particulars |
| **W6** | *the red-presentation taxonomy needs a third column* | `0117`, **retired** | superseded | five presentations appeared in one round; **folded into `LC-…-17`** |
| **W7** | the plan's two strike notations | `0118` | **LH2** (both grades) | a notation choice inside one document |
| **W8** | *determinate-wrong-answer versus no-determinate-answer* (the injection/refusal split) | `0119` | **LH2-g** | every attempt to state it named a stimulus generator or a specification's own vocabulary |
| **W9** | the anti-vacuity plan that dispositioned its findings before wiring its own gate, so the first gating run was green and proved nothing | `0163` | **subsumed** | generalises only into `LC-…-80`, which already carries it |

**W1 and W6 are RETIRED** (superseded, their content folded into named candidates);
**W2, W3, W4, W5, W7, W8 and W9 are kept and re-offerable at a later harvest with new
provenance.** **The war-stories table is not empty, and the number is the bar's own
evidence**: **nine refusals against ninety-eight bankings**, roughly one item in eleven
offered, refused **by its author before any collator saw it**.

**And the mirror line the block's §4 asks for, applied honestly against myself.** A yield
of **94 `LC-` to one `LD-`** is the inverse of the *"all `LD-` says something about the
miner"* warning, and it deserves the same suspicion. **My reading**: this chain's
discipline pushed every candidate through step 0 at banking time, so the general
statement was written first, every time, and the domain grade almost never got a chance
to be a shortcut. **The bar's discriminating power in this chain lives in the war
stories, not in the `LC-`/`LD-` split** — the nine refusals are where the bar bit.

### 4.7 THE WORKER SPANS I COMMISSIONED (PROTOCOL §7), mined and measured

| worker journal | span, MEASURED by entry-header count at `2183d71` | harvest notes | yield |
|---|---|---|---|
| `workers/claude_tb_writer_agent.md` (16) + `.v02.md` (18) + `.v03.md` (6) | **`J-tb_writer-0001` … `-0040`**, three volumes, chain headers verified | **ten**, at `-0021` … `-0030` **only** | `-0021` **nil, declared**; `-0022` … `-0030` **nine candidates**, one per entry, all self-graded `LH2-g` |
| `workers/claude_data_wrangler_agent.md` | **`J-data_wrangler-0001` … `-0008`** | **zero** | **NIL, declared** |
| `workers/claude_formal_dv_agent.md` | **zero entries** — dormant, never activated | — | **NIL, declared** |
| `workers/claude_rtl_module_dev_agent.md` | zero entries | — | **not mine to mine** (rtl_lead's) |

**THE CROSS-SEAT MERGE, and it is the most interesting thing the worker span produced.**
`J-tb_writer-0028` banks *"quietly reusing an already-supplied value to stand in for one
that was never derived converts a gap in the instructions into an assertion nobody
actually checked"* — **the executor's side of the rule my own `J-dv_lead-0122` banked
from the reviewer's side** on the same incident. My own note said the candidate was
*"ripened by the worker's own conduct disclosure"* and never merged them. **Merged here
as `LC-…-25`, with both provenances**, because the same rule taught from both ends of an
instruction is stronger evidence than either half.

**A MEASURED GAP IN THE WORKER CHAIN, reported rather than smoothed.** Of forty
tb_writer entries, **ten carry a harvest note and thirty do not** — `-0001 … -0020` and
`-0031 … -0040` carry none. The worker template's harvest discipline **started at
`-0021` and stopped at `-0030`**. `J-tb_writer-0021` itself declares the shape of the
first gap in terms — *"a full retrospective harvest over `0001..0020` is NOT attempted
here and is a gap for a lead- or orchestrator-level pass, not claimed as closed by this
note"* — **and this is that lead-level pass, which finds the gap real and does not close
it either**: I can mine what the entries recorded, and no note exists to mine for thirty
of them. **Declared, with its span, so it tiles as a visible gap rather than as silence.**

### 4.8 THE INSTANTIATED BLOCK — and why six boxes cannot be checked

## Lessons harvest — SO-xgmii_rx_64

Per ADR-0018 / PROTOCOL §7. Spans are entry-id intervals over each agent's own
journal chain and must tile with that agent's previous harvest. Transcribed by
the orchestrator; each row's authority is the cited journal entry.

### Spans mined

| Agent | Span (entry-id interval) | Harvest note | T1 general | T2 domain | T3 |
|---|---|---|---|---|---|
| architect_docs_lead | **NOT MINED — no harvest note exists** | — | — | — | — |
| rtl_lead | **NOT MINED — no harvest note exists** | — | — | — | — |
| dv_lead | **J-dv_lead-0001 … J-dv_lead-0165** (first harvest; span opens at the first entry) | **J-dv_lead-0165** | **94** | **1** | **9** |
| auditor | **NOT MINED — no harvest note exists** | — | — | — | — |
| orchestrator | **NOT MINED — no harvest note exists** | — | — | — | — |
| _(worker spans, by commissioning lead)_ | `J-tb_writer-0001 … -0040`; `J-data_wrangler-0001 … -0008`; `formal_dv` **nil (zero entries)** | in dv_lead's note (§4.7) | 8 + 1 merged | 0 | 0 |

### Checklist

- [ ] **Every persistent-journal agent has a row above**, and every span tiles —
      **UNCHECKABLE. Four of five agents have not harvested.** dv_lead's span tiles
      by construction (first harvest, opens at the first entry).
- [ ] **Each row's harvest note exists** — **UNCHECKABLE for four of five rows.**
      dv_lead's exists and carries its span, its candidates with LH1–LH3, its war
      stories with the criterion each failed, and its nil-yield declarations.
- [x] **The classifier was run on every candidate** (§2.1), starting from the most
      general honest statement — **run on all 95; §4.5.**
- [x] **Every candidate discharges LH1, LH3 and LH2 at its stated grade**, checked
      against the notes and not against a summary line — **§4.5.**
- [x] **Every `LD-` row names a domain pack** — **one `LD-`, pack `version-control`.**
- [x] **Pack names checked against those already in use** — **none are in use; this is
      the programme's first harvest.** Normalisation: `none`.
- [x] **No candidate was edited in transcription** — the statements above are their
      authors' own, abridged to a first clause with the entry cited as the authority.
- [ ] **Shell transcription: exactly one commit** — **NOT DONE. The orchestrator's
      act, and it happens after this packet lands (§4.1, §7.2 item 2).** Commit: `—`
- [ ] **`LC-`/`LD-` → `L-` pairs recorded** — **NOT DONE; there are no `L-` ids yet.**
- [ ] **Sponsor-visible** — **NOT DONE. It happens at `P1-module-ready`.**
- [ ] **Harvest declared complete by the orchestrator** — **NOT DONE.**

**FIVE CHECKED, SIX UNCHECKED, AND THE SPLIT IS THE FINDING.** The five checked boxes
are the ones whose subject is **this agent's own mining**, and every one of them is met.
**The six unchecked boxes are not mine to check**: four are the orchestrator's later
acts by §4.1's own text, and two require harvest notes from four agents who have never
been asked for one.

> **`FINDING SO-5` (MAJOR, mine, against this packet's own §1).** **`SC-12` demands of
> this packet a thing this packet's author cannot do.** It requires the block
> *"instantiated in this packet with **every box checked**"*, which imports PROTOCOL
> §7's **gate** condition — *"A gate is not passed while any box … is unchecked"* — onto
> a **packet**. §4.1, in the same document, states the opposite: the block is *"filled
> by the orchestrator from each agent's note"* and the shell transit *"is the
> orchestrator's"*. **The draft contradicted itself and the executing round is the one
> that discovers it**, which is the same shape as `FINDING SO-1` and has the same
> cause: criteria written in one sitting, and an execution order that never asked
> whether each was reachable by its own executor.
>
> **AND THE CRITERION FAILS ON SUBSTANCE, NOT ONLY ON ITS WORDING — which is why it is
> not waived.** PROTOCOL §7 makes the lessons harvest a **five-agent** act at *"every
> module sign-off"*: each agent holding a persistent journal mines **its own** span, and
> the spans tile so that a skipped harvest is a visible gap. **Four spans are unmined
> and no round has been commissioned to mine them.** The programme's first harvest is
> therefore **one fifth complete**, and the four gaps are exactly what the tiling rule
> exists to make visible. **A `PASS` here would be the first harvest declaring itself
> complete at one agent of five**, in the packet that the gate reads to decide whether
> the harvest happened.

### 4.9 THE BLOCK RE-INSTANTIATED AT `14615f8` (round 3) — four notes landed, and the boxes read at each seat's own journal

> **DATED ANNOTATION, 2026-08-11, `J-dv_lead-0167` — §4.8 above is round 2's
> instantiation and is left UNEDITED, `FINDING SO-5` included.** Its four `NOT MINED`
> rows were true when written and are false now; the correction is **beside** them, not
> **over** them.

**HOW I READ THESE FOUR, stated before the result, because the method is the only thing
that makes the result checkable.** I opened each seat's journal at `14615f8` and read the
harvest entry itself — not the dispatch's summary of it, not the commit subject line. For
each I asked the block's own eleven boxes, in the block's own words, and I counted the
things the boxes count: does the note state its span as an **entry-id interval**; does
every banked candidate carry **LH1**, **LH3** and a stated **LH2 grade**; is the
**classifier** stated as run from the most general honest statement; do **war stories**
carry the criterion each failed; is a **nil** declared rather than omitted. **Where a note
puts LH1/LH3 in table columns rather than in labelled prose, that discharges the box** —
the box asks for the discharge, not for the token. **I graded notes, never seats**, and
the finding below is written against a note's contents with the repair named.

**THE FOUR, MEASURED AT THEIR OWN JOURNALS:**

| seat | note | span, as stated | banked | LH1 per candidate | LH3 per candidate | LH2 grade stated | classifier stated as run | war stories with criterion | verdict on the note |
|---|---|---|---|---|---|---|---|---|---|
| **auditor** | `J-auditor-0019` (`185ae66`) | `J-auditor-0001 … -0018`, first harvest, opens at first entry | **54** | **yes** — SHA + entry, inline per candidate | **yes** — *"LH3 without it …"* per candidate | **yes**, all `LH2-g`, declared with its cause | **yes** — step 0 attempted for all 64, none reached step 2 | **yes**, 5, each with the criterion | **CONFORMANT** |
| **architect_docs_lead** | `J-architect_docs_lead-0034` (`54b2553`) | `J-architect_docs_lead-0001 … -0034` | **94** | **yes** — an *"LH1: incident SHA(s) · entry"* column, populated on all 94 | **yes** — a *"what breaks without it"* column, populated on all 94 | **yes**, all tier 1, with the nil-`LD-` declared and its cause | **yes** — step 0 run on all 94, with the nine role-noun rewrites counted | **yes**, 9, each with the criterion | **CONFORMANT** |
| **rtl_lead** | `J-rtl_lead-0013` (`c55c754`) | `J-rtl_lead-0001 … -0012`; next opens at `-0013` | **50** | **yes** — SHA column plus an (F)/(C) visibility grade the note defines and defends | **yes** — an *"LH3 — what breaks without it"* column on all 50 | **yes**, all `LH2-g`, `LD-` reserved and unused | **yes**, from the most general honest statement | **yes**, 16, each with the criterion | **CONFORMANT** |
| **orchestrator** | `J-orchestrator-0233` (`d53d795`) | `J-orchestrator-0001 … -0232`, 232 entries, walk method declared | **18** | **partly** — every candidate carries an `LH1:` line, but most cite **entry ids** rather than commit SHAs (resolvable via `git log --grep`, so pinned indirectly) | **NO — 0 of 18** | **NO — none stated**; a blanket *"No `LD-`"* stands in for a grade | **NO — the note does not state the classifier was run**, and step 0 appears nowhere | **yes**, 2, each with the criterion it failed | **NOT ADMISSIBLE AS BANKED** |

**The orchestrator row is the finding, and it is measured rather than characterised.**
Across that entry the token `LH1` occurs **18** times — once per candidate — and the token
`LH3` occurs **once**, inside a **war story** (*"Fails LH3: ordinary debugging
judgement"*). So the seat knows the criterion and applies it to the two statements it
**refused**, and to none of the eighteen it **banked**. At most three or four of the
eighteen carry a consequence clause embedded in the rule itself (*"a buffered transcript
is a known false-positive"*; *"so an ephemeral container never holds the only copy"*);
the rest state a rule and its provenance and stop.

> **`FINDING SO-6` (MAJOR, mine, against `J-orchestrator-0233` as an artefact — not
> against the seat, and not against the dispatch that produced it).**
> **PROTOCOL §7 states the admissibility test in one sentence**: *"A candidate rule is
> admissible only if it **(LH1)** cites the incident commit(s) that taught it, **(LH2)**
> states its observable in terms portable beyond this project, and **(LH3)** says what
> breaks without it."* **Eighteen of eighteen banked candidates do not discharge LH3, and
> none carries a stated LH2 grade.** The block's box — *"Every candidate in the Yield
> table discharges LH1, LH3 and LH2 at its stated grade, **checked by the transcriber
> against the note, not against the summary line**"* — cannot be checked at that row, and
> box 3 (the classifier) and box 2 (the note carries its candidates with LH1–LH3
> discharged) fail with it.
>
> **AND THE GRADE QUESTION IS NOT COSMETIC, which is why a blanket nil cannot stand in
> for it.** `LH2-g` bars **every** proper noun. Read against that bar, several of the
> eighteen carry nouns a stranger cannot resolve: one names a version-control command
> outright, two more turn on push and merge-base semantics, and at least two name
> artefacts that exist only in this repository. **Some of those are very likely `LD-`
> candidates in a `version-control` pack** — the pack this programme has already opened —
> and one is likely tier 3. **None of that can be decided from outside the note**: the
> classifier is run by the miner, from the most general honest statement, and a reader
> who re-grades another seat's statements has become the selector the block's §4 forbids
> (*"You are not the selector … you may not improve one"*).
>
> **REPAIR, bounded and owned.** The orchestrator's own next harvest round appends a
> successor note discharging **LH3** per candidate, running the classifier from step 0
> and recording each candidate's **grade** — with `LD-` rows naming their pack — for the
> same span. **No renumbering is needed**: `RULING O-1` (that entry's own ruling) already
> fixes the id space, and the eighteen ids `LC-orchestrator-H1-1 … -18` are conformant to
> it. **I cannot write that note** — PROTOCOL §4: no agent writes another agent's journal
> — which is exactly why this is a finding with a carrier and not a repair I withheld.

**THE BLOCK, RE-INSTANTIATED. Five of eleven boxes checked, six unchecked — the same
count as round 2 and a different set, which is the informative part.**

## Lessons harvest — SO-xgmii_rx_64 (RE-INSTANTIATED at `14615f8`, round 3)

Per ADR-0018 / PROTOCOL §7. Spans are entry-id intervals over each agent's own
journal chain and must tile with that agent's previous harvest. Transcribed by
the orchestrator; each row's authority is the cited journal entry.

### Spans mined

| Agent | Span (entry-id interval) | Harvest note | T1 general | T2 domain | T3 |
|---|---|---|---|---|---|
| architect_docs_lead | **`J-architect_docs_lead-0001 … -0034`** | **`J-architect_docs_lead-0034`** (`54b2553`) | **94** | **0** (nil declared, with cause) | **9** |
| rtl_lead | **`J-rtl_lead-0001 … -0012`** | **`J-rtl_lead-0013`** (`c55c754`) | **50** | **0** (reserved, unused) | **16** |
| dv_lead | `J-dv_lead-0001 … J-dv_lead-0165` (first harvest; span opens at the first entry) | `J-dv_lead-0165` | **94** | **1** | **9** |
| auditor | **`J-auditor-0001 … -0018`** | **`J-auditor-0019`** (`185ae66`) | **54** | **0** (nil declared, with cause) | **5** |
| orchestrator | **`J-orchestrator-0001 … -0232`** | **`J-orchestrator-0233`** (`d53d795`) | **18 offered, 0 admissible as banked** — `FINDING SO-6` | **0** (undetermined: the classifier was not run) | **2** |
| _(worker spans, by commissioning lead)_ | `J-tb_writer-0001 … -0040`; `J-data_wrangler-0001 … -0008`; `formal_dv` **nil (zero entries)** | in dv_lead's note (§4.7); **and, additionally, the workers' own notes `J-tb_writer-0041` and `J-data_wrangler-0009` landed this arc** | 8 + 1 merged (lead-mined) | 0 | 0 |

### Checklist

- [x] **Every persistent-journal agent has a row above**, and every span tiles —
      **CHECKED at `14615f8`.** All five rows are populated and every span **opens at
      its agent's first entry**, which is the block's own first-harvest rule; there is
      no previous harvest for any of the five to tile against. **One forward
      observation, recorded not charged**: the auditor's note declares its next span
      opening at `-0020`, which would leave `-0019` — its own note entry — inside
      neither interval. The other three place their note entry on one side or the
      other. **A prospective one-entry gap, declared in its own note and therefore
      visible, which is what the tiling rule is for.**
- [ ] **Each row's harvest note exists** and carries its span, its candidates with
      LH1–LH3 discharged, its war stories with the criterion each failed —
      **UNCHECKABLE at one of five rows.** Four notes exist and carry all of it;
      `J-orchestrator-0233` carries its span and its war stories but **not** its
      candidates with LH3 discharged (`FINDING SO-6`).
- [ ] **The classifier was run on every candidate** (§2.1), starting from the most
      general honest statement — **UNCHECKABLE at one of five rows.** Stated and
      evidenced in the dv, auditor, architect and rtl notes; **absent** from the
      orchestrator's.
- [ ] **Every candidate discharges LH1, LH3 and LH2 at its stated grade** —
      **UNCHECKABLE at one of five rows**, for 18 candidates. **The other 293 — 54 +
      94 + 50 + 95 across the four conformant notes — discharge all three.**
- [x] **Every `LD-` row names a domain pack** — **one `LD-` across all five notes**
      (dv's), pack `version-control`. The other four declare a nil `LD-` with a cause.
- [x] **Pack names checked against those already in use** — one pack in use
      (`version-control`); no second pack minted, so no near-duplicate is possible.
      Normalisation: `none`.
- [x] **No candidate was edited in transcription** — **and this round is where that box
      earned its keep.** Re-grading the orchestrator's eighteen statements myself was
      available and is refused at `FINDING SO-6`: a reader who repairs another miner's
      statements has become the selector.
- [ ] **Shell transcription: exactly one commit** — **NOT DONE.** No `L-` id exists in
      any artefact at `14615f8`, and the shell is another repository. Commit: `—`
- [ ] **`LC-`/`LD-` → `L-` pairs recorded** — **NOT DONE; there are no `L-` ids yet.**
- [ ] **Sponsor-visible** — **NOT DONE. It happens at `P1-module-ready`.**
- [ ] **Harvest declared complete by the orchestrator** — **NOT DONE.**

**FIVE CHECKED, SIX UNCHECKED — and the split has moved, which is the measurement this
round adds.** Round 2's six unchecked were *two* mining boxes (four seats had never
harvested) and *four* collation boxes. Round 3's six are **three** mining boxes, all
failing at **one** row for **one** reason, and the **same four** collation boxes.
**Three seats' notes closed two boxes and opened none.**

> **WHAT THIS ROUND DELIBERATELY DOES NOT RULE, and the refusal is the discipline, not
> an evasion.** `FINDING SO-5`'s **wording** half stands: `SC-12` demands *"every box
> checked"* in a **packet**, while §4.1 and the block's own §1 item 4 make the last four
> boxes the **orchestrator's later acts** — so on a literal reading no `SO-` could ever
> satisfy `SC-12`. **I do not resolve that here.** It is not load-bearing for today's
> token: `SC-12` fails on `FINDING SO-6`, which is a box that **is** the packet's to
> check and which fails on measurement. Ruling the four collation boxes out of the
> criterion **while they are the only thing left standing** would be the author
> discharging a condition by declaring it discharged — and ruling them *in* forever
> would freeze an unmeetable criterion by the same unilateral act. **Both are amendments
> to a criterion, and an amendment belongs in an ADR under PROTOCOL §11, raised by the
> round that needs it, not asserted inside the packet the criterion grades.** Carrier:
> an ADR-0018 amendment reconciling the block's gate condition with a packet
> instantiation, raised at Open-questions in `J-dv_lead-0167`.

### 4.10 THE BLOCK RE-INSTANTIATED AT `41fead6` (round 4) — under A2's partition, with the successor note measured at the journal that carries it

> **DATED ANNOTATION, 2026-08-11, `J-dv_lead-0168` — §4.8 and §4.9 above are rounds 2 and
> 3's instantiations and are left UNEDITED, `FINDING SO-5` and `FINDING SO-6` included.**
> §4.9's `NOT ADMISSIBLE AS BANKED` verdict on `J-orchestrator-0233` was true of the
> artefact it read and stays where it was written; the successor note is a **different
> artefact** and is graded here, beside it. **A2.3 forbids nothing here and orders
> nothing**: it states in terms that it *"does not edit `agents/handoffs/SO-xgmii_rx_64.md`
> and orders no edit to it"*, and that §4.8's and §4.9's landed instantiations *"are dated
> records and are not migrated or re-instantiated"*. **This is a new instantiation for a
> new round, not a migration of an old one.**

**HOW I READ THE SUCCESSOR NOTE, stated before the result, because it is the same method
§4.9 published and the point of publishing a method is to be held to it next time.** I
opened `agents/journals/claude_orchestrator_agent.v02.md` at `41fead6` and read
`J-orchestrator-0234` **in full, at the journal** — not the dispatch's description of it,
not the commit subject line, not `J-orchestrator-0235`'s relay of it. I sliced the entry
at its own header to the next `## [J-` header and counted the things the boxes count. **I
also re-ran the round-3 counts on `J-orchestrator-0233`** — they still return `LH1`=18,
`LH3`=1 (inside a war story), classifier=0 — because a repair is only a repair against a
defect that reproduces, and a finding whose measurement no longer reproduces should be
withdrawn rather than discharged.

**THE SUCCESSOR NOTE, MEASURED.**

| what the boxes count | `J-orchestrator-0233` (round 3's subject) | **`J-orchestrator-0234` (`b4814b0`)** |
|---|---|---|
| span, as an entry-id interval | `J-orchestrator-0001 … -0232`, walk method declared | **same interval, restated**, with the walk explicitly **not** repeated and the reason given (*"what was missing was the discharge, not the walk"*) |
| candidates | **18**, `LC-orchestrator-H1-1 … -18` | **the same 18, unrenumbered**, `RULING O-1` cited — and **A2-D6(1) independently confirms this is correct**: `<k>` counts **spans, not notes**, so a successor note over one span keeps `H1` |
| **LH1** per candidate | 18 `LH1:` labels | **kept from `-0233` by explicit reference**, which is the structure round 3's own repair text asked for (*"a successor note … that discharges **LH3** per candidate"*) |
| **LH3** per candidate | **1 occurrence, and it is inside a war story** | **18 of 18** — every numbered item matches `<n>. LH2-g. LH3: <consequence>`, and every consequence names a concrete breakage, not a virtue |
| **LH2 grade** stated | **none**; a blanket *"No `LD-`"* stood in for eighteen classifications | **18 of 18 stated `LH2-g`**, with the nil-`LD-` declared **and its cause given** (*"this seat owns no domain artifact"*) |
| **classifier** stated as run from step 0 | **absent**; step 0 appears nowhere | **stated twice**, in the note's standing paragraph and again in its own *Classifier and box record* section: *"Classifier run from step 0 on all 18"* |
| war stories with the criterion each failed | 2, each with its criterion | **2, unchanged and carried forward** with their criteria (`LH3`; `LH2-g`) |
| worker spans | nil, with cause | **nil, with the same cause** (*"this seat commissions leads, not workers"*) |
| **verdict on the note** | **NOT ADMISSIBLE AS BANKED** (§4.9) | **CONFORMANT** |

**The measurement, so a reader re-runs it rather than trusting it** (`SC-13`):

```
$ python3 - <<'EOF'   # slice each entry at its own header to the next '## [J-'
… J-orchestrator-0233:  LH1=18  LH3=1   LH2-g=1  classifier=0
… J-orchestrator-0234:  LH1=2   LH3=21  LH2-g=19 classifier=4
… J-orchestrator-0234:  numbered items matching '^\s*\d+\. (LH2-[a-z]+)\. (LH3:)'  → 18
…                       ids present: 1 … 18, none missing, none duplicated
… J-orchestrator-0233:  numbered candidate statements → 18 ; 'LH1:' labels → 18
EOF
```

**Three dimensions (§0.2, SC-10).** **SHA**: `41fead6`. **DOMAIN**: the **entry**, sliced
at its own header — *"checked by the transcriber against the note, not against the summary
line"* is the box's own wording and it is the domain I used. **POLARITY**: both halves
measured — the positive (**18 present**) and the negative (**0 of the 18 missing either a
grade or an LH3 clause**), the second being the one that decides the box.

**`FINDING SO-6` — DISCHARGED**, by the carrier it named, in the form it named, at the
commit that carries it. **The finding is closed as a finding and stays in the record as
history**: §4.9 is unedited, and this is the disposition written beside it.

> **`OBSERVATION SO-O1` — recorded, MEASURED, and deliberately NOT CHARGED.** Running the
> hide-the-provenance test myself, which the block's §4 obliges of whoever fills a table
> (*"Run the hide-the-provenance test yourself … use the right stranger"*), **two of the
> eighteen statements carry a version-control TOOL noun inside the rule statement while
> the stated grade is `LH2-g`**, whose bar is *"no proper noun of any kind … no toolchain
> or library name"*:
>
> - **`LC-orchestrator-H1-8`** — the statement names `git show HEAD:<journal>` outright:
>   a tool name and a ref name.
> - **`LC-orchestrator-H1-2`** — the statement turns on `HEAD`, `merge-base`, `ancestor`
>   and `descendant`: a ref, a subcommand and its DAG vocabulary.
>
> Measured by a token scan over **all eighteen** statements, not over the two I noticed:
> **the other sixteen carry no tool name at all** — **seven** carry only common
> version-control verbs (`commit`, `diff`, `push`), which are not tool names and which a
> stranger to the domain resolves without help, and **nine** carry no such token
> whatsoever. **Both halves are stated because the negative half is what makes the claim a
> measurement rather than a complaint.**
>
> **WHY THIS IS NOT A BOX FAILURE, and the reason is not that it is small.** Three
> grounds, and the first is the only one that would matter if the other two were absent:
>
> 1. **Round 3 pre-committed the disposition, in writing, when doing so cost it
>    nothing.** §4.9: *"Some of those are very likely `LD-` candidates in a
>    `version-control` pack … **None of that can be decided from outside the note**: the
>    classifier is run by the miner, from the most general honest statement, and a reader
>    who re-grades another seat's statements has become the selector the block's §4
>    forbids."* **The miner has now run the classifier and ruled.** For me to overturn
>    that ruling **in the round where it is the last thing standing between this packet
>    and a `PASS`** would be the discharge-by-declaration move inverted — a bar raised at
>    the graded party rather than lowered for it, which is the same defect wearing the
>    opposite coat.
> 2. **A2-D4 codified that refusal as the behaviour it preserves**, naming §4.9's refusal
>    against these exact eighteen: *"a party who re-grades another miner's statement has
>    become the selector §4.1 forbids — which is the refusal `SO-xgmii_rx_64.md` §4.9
>    already executed."*
> 3. **The two defects differ in kind, in the constitution's own words.** PROTOCOL §7
>    makes LH1 **and** LH2 **and** LH3 the condition of a candidate being *"admissible at
>    all"* — so eighteen candidates with no LH3 were **nothing banked**, which is why
>    round 3 failed a harvest-level box. A **grade** decides which destination an
>    admissible candidate routes to — the shell's universal set or a named pack — and
>    routing is a **collation** act (§7's own routing sentence; block §4's pack rules),
>    whose remedy is per-candidate and already written: the collator *"may bounce a
>    candidate to its author"* at transcription, and A1.4 fixes what happens after a note
>    is committed — *"a later regrade is a **new** candidate at a later harvest, citing
>    the old id"*. **A mis-grade removes or reroutes one candidate; it does not unbank a
>    harvest.**
>
> **OWNER AND ROUTE, named so this is an observation with a carrier and not a shrug.**
> **Owner: the miner** (`orchestrator`), whose ruling it is. **Route: the collator's own
> hide test at gate-time transcription** (block §4, third bullet) — the last point before
> a rule leaves this repo — with A1.4's later-harvest regrade as the instrument if the
> test agrees with me. **I name no pack and assign no grade**, because naming the pack is
> the half of the act that would make me the selector. **This observation carries into
> `P1-module-ready` as an input to the gate's own Part A re-check** (A2-D3), which is
> exactly the site A2 built for it.

**THE BLOCK, RE-INSTANTIATED UNDER A2's PARTITION. Part A: seven boxes, SEVEN CHECKED.
Part B: the named deferral line, not boxes (A2-D1).**

## Lessons harvest — SO-xgmii_rx_64 (RE-INSTANTIATED at `41fead6`, round 4, **Part A** per ADR-0018 §A2.2)

Per ADR-0018 as amended by A2 / PROTOCOL §7. Spans are entry-id intervals over each
agent's own journal chain and must tile with that agent's previous harvest. **At a
sign-off the round that signs the packet fills and checks this table** (A2-D4); each
row's authority is the cited journal entry, and whoever fills it is transcribing, never
selecting.

### Spans mined

| Agent | Span (entry-id interval) | Harvest note | T1 general | T2 domain | T3 |
|---|---|---|---|---|---|
| architect_docs_lead | `J-architect_docs_lead-0001 … -0034` | `J-architect_docs_lead-0034` (`54b2553`) | **94** | **0** (nil declared, with cause) | **9** |
| rtl_lead | `J-rtl_lead-0001 … -0012` | `J-rtl_lead-0013` (`c55c754`) | **50** | **0** (reserved, unused) | **16** |
| dv_lead | `J-dv_lead-0001 … -0165`; `-0166 … -0167`; **nil** at this round — **cumulatively `-0001 … -0167`, no gap, no overlap** | `J-dv_lead-0165`; `J-dv_lead-0167`; `J-dv_lead-0168` (**nil, declared**) | **94 + 3 + 0 = 97** | **1** (pack `version-control`) | **9 + 1 + 0 = 10** |
| auditor | `J-auditor-0001 … -0018` | `J-auditor-0019` (`185ae66`) | **54** | **0** (nil declared, with cause) | **5** |
| orchestrator | `J-orchestrator-0001 … -0232` | `J-orchestrator-0233` (`d53d795`, the walk) **+ `J-orchestrator-0234` (`b4814b0`, the admissibility record)** — one span, two notes, `H1` kept per A2-D6(1) | **18** | **0** (nil declared, with cause) | **2** |
| _(worker spans, by commissioning lead)_ | `J-tb_writer-0001 … -0040`; `J-data_wrangler-0001 … -0008`; `formal_dv` **nil (zero entries)** | in dv_lead's note (§4.7); the workers' own notes `J-tb_writer-0041` and `J-data_wrangler-0009` landed this arc | 8 + 1 merged (lead-mined) | 0 | 0 |

**Sum, with its addends shown because `SC-12` bars a total that was not walked**: tier 1
**97 + 94 + 50 + 54 + 18 = 313**; tier 2 **1**; tier 3 **10 + 9 + 16 + 5 + 2 = 42**. **Each
addend is the count its own note states, read at that note.** I re-walked no other seat's
chain and quote no figure that would require one.

### Checklist — **Part A (mining)**, the seven boxes a sign-off carries (A2-D1)

- [x] **Every persistent-journal agent has a row above**, and every span tiles with that
      agent's previous harvest — no gap, no overlap. **CHECKED at `41fead6`, and better
      than at round 3.** All five rows populated; every first harvest opens at its agent's
      first entry. **Round 3's one forward observation is CLOSED without any journal being
      edited**: it recorded the auditor's declared next opening at `-0020` leaving `-0019`
      in neither interval. **A2-D10** makes the opening *"the first entry not already
      inside a mined span"*, which yields `-0019` for the auditor and `-0233` for the
      orchestrator; **A2-D11** makes a declared next opening a prediction that *"consumes
      nothing"*; **A2-D12** grandfathers every landed note. **The gap I could only report
      is now structurally impossible, and the repair reached it from a chain that was not
      mine** — rtl_lead measured it, the architect ruled it, the collator accepted it.
- [x] **Each row's harvest note exists** in the named journal entry and carries its span
      interval, its candidates with LH1–LH3 discharged, its war stories with the criterion
      each failed — or an explicit nil yield. **CHECKED at five of five rows.** Four were
      conformant at round 3 and their blobs did not move. **The fifth is now conformant on
      the pair `-0233` + `-0234`**, which is the structure `FINDING SO-6`'s own repair text
      specified (*"a successor note … for the same span"*) and which **A2.7's census table
      independently reads as one seat's note** (*"`J-orchestrator-0233` (walk) + `-0234`
      (admissibility)"*). Measured above, at the journal.
- [x] **The classifier was run on every candidate** (§2.1), starting from the most general
      honest statement — no candidate reached `LD-` without a general statement having been
      attempted and found hollow. **CHECKED at five of five rows.** Stated and evidenced in
      the dv, auditor, architect and rtl notes; **now stated twice in the orchestrator's**
      (*"Classifier run from step 0 on all 18"*). The `LD-` sub-clause is satisfied at four
      rows **vacuously** — they minted no `LD-` — and at mine by the general statement I
      recorded as hollow.
- [x] **Every candidate in the Yield table discharges LH1, LH3 and LH2 at its stated
      grade**, checked by the transcriber against the note, not against the summary line.
      **CHECKED at five of five rows.** The row that failed at round 3 is measured above:
      **18/18 LH1** (kept from `-0233` and unchallenged by `FINDING SO-6`, which charged
      LH3, grade and classifier and not LH1), **18/18 LH3**, **18/18 stated grade**. **One
      observation rides beside this box and does not defeat it — `OBSERVATION SO-O1`**,
      with its owner, its route and the three grounds for not charging it.
- [x] **Every `LD-` row names a domain pack**, as a slug naming the technical domain and
      not this program. **CHECKED.** **One `LD-` across all five notes** — mine, pack
      `version-control` — and the other four declare a nil `LD-`, each with a cause rather
      than a silence.
- [x] **Pack names checked against those already in use** in previous harvests; an existing
      name was reused rather than a near-duplicate minted. **CHECKED.** One pack in use
      (`version-control`); **no second pack minted this round, so no near-duplicate is
      possible.** Normalisation: `none`.
- [x] **No candidate was edited in transcription.** A defective statement is bounced to its
      author, never rewritten by the collator. **CHECKED — and this is the second
      consecutive round in which this box did real work.** At round 3 it stopped me writing
      eighteen missing LH3 clauses. **At round 4 it stopped me re-grading two statements
      whose grade I would have set differently**, which would have converted a reader into
      a selector at the exact moment a selection favoured the outcome I wanted. **The
      observation is recorded; not one statement is touched.**

### **Part B — collation, deferred to `P1-module-ready`** (A2-D1)

> **Part B — collation, deferred to `P1-module-ready`.** Shell transcription, the
> `LC-`/`LD-` → `L-` pairing, sponsor visibility and the completeness declaration are the
> collator's acts at the gate that ratifies this harvest (ADR-0018 §4.2, §4.4, D6; A2.2).

**Named, not silent, because A2.8's second failure mode is Part B going quiet once it
stops being a box.** The gate that owes it is **`P1-module-ready`**; at that gate the
block is instantiated with **all eleven** boxes (A2-D2), **Part A is re-checked over the
gate's own spans and does not inherit this table** (A2-D3), and the shell transit is
**one commit per harvest**, never one per gate (A2-D5). **Nothing in this section is a
gate signature**: dv_lead cannot stage `docs/gates/**` and the orchestrator transcribes
every signature (PROTOCOL §7, §0.3).

**SEVEN OF SEVEN CHECKED, AND WHAT THAT DOES AND DOES NOT MEAN.** It means the harvest's
**mining** is complete at all five seats and is checkable from committed journals by any
later reader. **It does not mean the harvest is collated**: no `L-` id exists in any
artefact at `41fead6`, no shell commit has been opened, the sponsor has not seen the table,
and no completeness declaration exists — **all four of which are Part B and are listed
bounds of this `PASS`** (§8.R4.4). **A `PASS` here is not the harvest declaring itself
finished; it is the packet's own half of it, measured.**

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

### 5.8 THE SENTENCES THIS PACKET DECLINED TO WRITE, AND THE BAR THAT FORBADE EACH (SC-7)

**A prohibition register that never records a refusal is a list nobody consulted.** Each
row below is a sentence the measured evidence would have supported in a looser packet:

| the sentence not written | forbidden by |
|---|---|
| *"the differential co-simulation anchors `xgmii_rx_64`"* | **§5.1 item 1.** A class is anchored; a requirement is not; a module never is. Five classes are anchored and the module is not |
| *"REQ-104 is anchored by the co-simulation, which observed `tuser`[0] = 1"* | **§5.1 item 2 and §5.5.** Class 4 is anchored, REQ-104 is not; and the value is written as the **pair** at §2.3-M(3), because the lane established equality and `M03-D1` established the figure |
| *"the five classes were re-lifted at the sign-off SHA"* | **§5.1 item 5.** Run `31444471834` re-observes them; a re-observation is not a lift and renews none |
| *"REQ-107 and REQ-108 rest partly on the anchor, since the lane now covers the 64-to-1518 range"* | **§5.2 (bar 2, permanent) and §5.6.** No stage of any phase can make a co-simulation result admissible for (e) or (f); and the lane's reachable window is **64 ≤ n ≤ 132**, one twelfth of the range |
| *"the co-simulation confirms M03's latency constants, since `T2` showed zero cross-side delta on case 0"* | **§5.3 (bar 3).** The reference's cycles are **recorded and never adjudicated**; a cross-side timing comparison is **barred**, not un-built, and run `31444471834` printing `theirs - ours = [0 …]` changes nothing about that |
| *"no strobe diverged at any of the five classes"* | **§5.4 (bar 4).** **No strobe of either side was compared at any of the five landed classes, and none could have been** — a claim of agreement over an uncompared quantity |
| *"family E's error classes are now inside declared classes, so the anchor covers more of family E"* | **§5.1 item 1 and §2.4-M.** *Inside an exclusion the comparison anchors nothing* — (g) and (h) **reduce** what the lane can anchor |
| *"the era killed 61 of 63 — a 96.8% kill rate"* | **SC-5.** Five columns, never a ratio; the void column and the green-by-blindness column are destroyed by one |
| *"`G-c4` is killed"* — flat, without its two halves | **SC-5 and §2.2-M.** The campaign's `survived` column is 1 and stays 1; the **defect** is dead at run `30852220315`. Neither sentence may be quoted without the other |
| *"`M03-L4` and `M03-L1` both confirm delivery order"* | **§5.7 (`U-1`).** A coverage claim counting both has counted one observation twice |
| *"the family-J campaign probed 7 of 22 assertions"* | **§2.1-M.** The figure does not reproduce; the measured statement is **7 of 29** |
| *"the harvest is complete"* | **§4.8.** One agent of five has mined its span |


#### 5.8-R THE SENTENCES ROUND 3 DECLINED TO WRITE (SC-7 at `14615f8`)

**Round 3 added text, so it owes this table too.** Each row is a sentence the material
this round measured would have supported in a looser packet.

| the sentence not written | forbidden by |
|---|---|
| *"the traceability rows are delivered, so the module's coverage is now traceable end to end"* | **§5.1 item 1's shape, applied to coverage.** A cell records which unit attacks which requirement; it anchors, proves and covers nothing on its own. **76 of 110 rows are still empty and 21 populated rows still read `OPEN`** |
| *"the matrix carries 13 `COVERED` rows, so 13 requirements are signed off"* | **PROTOCOL §7 and §0.3.** `P1-module-ready` reads the `SO-`, never the matrix; and `COVERED` is a claim about a row's own subject, not a gate signature |
| *"the transcription was verified by architect_docs_lead, so the cells are correct"* | **§0.2's SHA dimension.** A reviewer's report of a comparison is not the comparison. §2.8-R re-ran it at `14615f8` against the file, and **that** is the evidence |
| *"the harvest is four-fifths complete, which is substantially complete"* | **SC-14 and §4.9.** A criterion has two values; *substantially* is the qualifier SC-14 names as the mark of an unadmitted `FAIL` |
| *"the orchestrator's eighteen candidates are general, since none names a domain"* | **§4.9 and the block's §4.** The classifier is the miner's to run; a reader who grades another seat's statements has become the selector |
| *"run `31447385249` shows the suite red at `a851948`"* | **§2.9-R.** The `build` job failed at *"Install dependencies"* with the test steps **skipped** — the suite did not fail, it did not run |

#### 5.8-R2 THE SENTENCES ROUND 4 DECLINED TO WRITE (SC-7 at `41fead6`)

**A `PASS` makes sentences available that a `FAIL` does not, which is why this table is
longer on the round that writes one.** Each row is a sentence the material this round
measured would have supported in a looser packet.

| the sentence not written | forbidden by |
|---|---|
| *"`SC-12` is met, so the programme's first lessons harvest is complete"* | **A2.3 and §4.10.** *Complete* has two senses and only one is a packet's: the **mining** is complete at five of five seats; the **collation** — shell commit, `L-` pairs, sponsor sight, the declaration — has not happened and cannot happen here. The bound is listed, not elided |
| *"the co-simulation lane is green at `41fead6`, so the module is anchored"* | **§0.1 item 2 and §5.1.** A class is anchored; a requirement is not; a module never is. The `cosim` job's green is evidence for the classes it drove and for nothing else, and §8.R4.4 carries the undischarged module-level anchor as this `PASS`'s first bound |
| *"two of the orchestrator's candidates are domain candidates and belong in a `version-control` pack"* | **Block §4, A2-D4, and §4.9's own pre-commitment.** The classifier is the miner's to run. I measured the tool nouns and stopped there; naming the pack is the half of the act that makes a reader a selector (`OBSERVATION SO-O1`) |
| *"`FINDING SO-6` was overtaken by A2, so it needed no repair"* | **A2.0(3) and A2.3.** All three boxes it failed are in **Part A** and A2 relieved none of them. **The successor note paid it**; the amendment did not, and a packet that let an amendment absorb a measured failure would be reading a rule change as a retro-active discharge |
| *"a `PASS` closes the findings this packet carries"* | **§3.12 and `SC-14`.** `FINDING SO-2`, `SO-3`, `SO-4`, `M-4` and `P-1`'s residue are unrepaired, their carriers unopened. A verdict that retired its own inputs would be grading itself; they ride as listed bounds |
| *"the module is signed off, so `P1-module-ready` is met"* | **PROTOCOL §7 and §0.3.** This packet supplies that gate's DV rows; the checklist lives in `docs/gates/`, which I cannot stage, and its signatures are the orchestrator's transcription. A `PASS` is a **merge precondition**, not a gate and not the sponsor's approval |

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

### 6.4 RE-MEASURED AT `2183d71` (§7.1 step 9) — the ruling landed, and Stage 3 is still refused

**§6.3's "PENDING" is superseded by an event, not by a re-reading.** The predictions
were spent while this packet was a draft, and the packet records the outcome rather
than its own earlier expectation:

- **REQ-901 classes (g) and (h) are IN FORCE.** Countersigned by dv_lead at `3526e79`
  **under three checks rather than the one the ruling nominated**; transcribed into
  `docs/specs/requirements.md`'s change log **at `4e7331b`** — *"Countersignature
  transcribed — classes (g) and (h), the boundary sentence and the stimulus restriction
  are IN FORCE from this row."*
- **Two corrections landed at `ce5674d`, both against the recitals and both verified
  rather than inherited**: **`FINDING CSG-1`** — Amendment 3's recital narrowed to the
  lane it is true of; at XGMII lane 4 the reference **does** abort, one cycle later than
  `:390` alone suggests, because `:346` recomputes the framing error from `swap_rxc`.
  **`FINDING CSG-2`** — (g)'s carve-out bound to lane 0 of the **output** word, so the
  XGMII-lane-0 member of a **lane-4-started** frame is **inside** the exclusion, not
  outside it.
- **`FINDING ECS-4` and `FINDING ECS-5` are closed as predictions and open as
  exclusions**, and §2.4-M measures what that cost: four of the seventeen error classes
  moved **from comparable into excluded**.

**THE GATE, RE-MEASURED CONDITION BY CONDITION AT `2183d71`:**

| | condition | state at `c1f98ff` | **state at `2183d71`** | evidence |
|---|---|---|---|---|
| **(a)** | Stage 2 landed, every case green or every divergence adjudicated to a named branch | SATISFIED (four cases) | **SATISFIED** | run `31444471834`, job `93635620959`: **five cases — 0, C1, C3, C2, C4 — all `compare_exit=0 tier=CLEAN`**, aggregate *"every case in the set reached a verdict and every verdict was clean"* |
| **(b)** | the CD carries a co-sim **Phase 3** domain instance | UNMET | **UNMET** | `test/attack_plans/CD-xgmii_rx_64_cosim.md` §10 carries **C1, C2, C3, C4 and nothing else**; §10.7 item 3 states in terms *"It adds no co-sim Phase 3 instance"* |
| **(c)** | C9's admission rule written as spec text before either producer is opened | UNMET, and reshaped by `FINDING ECS-3` | **UNMET — and RESHAPED AGAIN, by the (g)/(h) landing** | no span-closing rule exists in `docs/specs/**`. **And C9 is now barred at a deeper level**: its **zero-delivered** half is class **(h)**, *excluded entirely, the accept-or-discard decision included*; its **delivered-octet** half is barred as **stimulus** — *"until a class is declared, co-simulation stimulus SHALL NOT present a start character inside an open frame that has already delivered an octet"* |
| **(d)** | a second static census on three axes | MET | **MET** | `RV-SWEEP` §4, unmoved |
| **(e)** | `MAX_WORDS_PER_FRAME` raised to cover the longest frame either producer can deliver, with the covering range stated beside the bound | UNMET | **UNMET** | `test/cosim/tb_xgmii_rx_64.v:258`: `localparam MAX_WORDS_PER_FRAME = 16;` — 128 delivered octets, frames to **132** DA-through-FCS, against a 64-to-1518 requirement range |

**THREE OF FIVE STILL UNMET. Stage 3 remains REFUSED, and this packet does not lift the
refusal.** What changed is the *character* of (c): it is no longer only an unwritten
admission rule, it is a stimulus REQ-901 now forbids in one half and excludes in the
other. **C9 cannot be built at all in its delivered-octet form** until a class is
declared for it — which is a spec diff to architect_docs_lead, not a comparator's to
grant itself.

**AND THE HONEST ANSWER TO "WHAT WOULD STAGE 3 BUY", updated by the ruling and less
flattering than the draft's.** §6.3 predicted that if (g) and (h) held, C8 and C9 would
*"select branch γ, and γ lifts nothing"*. **They held, and the outcome is worse than γ,
not better**: with the classes declared, C8's non-lane-0-of-output-word members and all
of C9 now select **branch β — declared, expected, excluded — which anchors nothing by
REQ-901's own sentence and cannot be escalated into a defect either.** The one place an
abort still anchors is **(g)'s carve-out**, E-1's two lane-aligned members, **which no
case has driven**. **The run is not blocked; the citation is** — and it is now blocked
by a class list that says so explicitly rather than by silence.

**§6.2's off-the-critical-path measurement, RE-MEASURED and unchanged**: bar 1 gates a
row **iff** its expected values come from X-1(ii)'s computed outcome model, and **no
benched row does** at `2183d71`, over both producers, by the five commands re-run at
§2.3-M(4) and stated in their **mechanism** form (`FINDING ECS-6`). **So no row of this
plan is waiting on a class Stage 3 would drive, and Stage 3 is not on this packet's
critical path.** The expiry is unchanged and restated: *the moment a row takes an
expected value from X-1(ii), this measurement is stale and is re-measured before it is
quoted again.*

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

### 8.R4 THE LIVE VERDICT — RE-ISSUED at `41fead6`, round 4

# PASS

**One token. No qualifier, no reservation, no "subject to" (SC-14).**

**Re-signed `J-dv_lead-0168`, dv_lead, at sign-off SHA `41fead6`.**
**Fourteen of fourteen criteria MET** (§1.4). **The bounds are listed at §8.R4.4 and a
bound is not a qualifier** — `SC-14`'s own second sentence: *"Everything the module has
not earned is a listed bound inside a `PASS`, or it is a `FAIL`."*

#### 8.R4.1 The ground, in one paragraph

**`SC-12` was the sole unmet criterion at `14615f8` and it needed two things; both landed
before this round could read them, and neither was mine to perform.** **The first is a
measurement.** `FINDING SO-6` convicted `J-orchestrator-0233` of banking eighteen
candidates while discharging **LH3** on none, stating no grade, and never saying the
classifier had run — against PROTOCOL §7's own sentence making LH1 **and** LH2 **and** LH3
the condition of a candidate being *admissible at all*. The successor note
`J-orchestrator-0234` (`b4814b0`) pays exactly that, over the same span, with the same
eighteen ids **unrenumbered**: measured at the journal and not at the dispatch, **18 of 18
now carry a stated `LH2-g` grade and an `LH3` clause naming a concrete breakage**, the
classifier is stated as run from step 0 on all eighteen, the war stories keep their
criteria, and the worker-span nil is declared with its cause. **The second is a rule
change, and round 3 fixed its form in advance**: *"it must settle it by amendment, not by
reading."* **ADR-0018 Amendment A2** (`85753b6`, in force at `41fead6` on the acceptance
act `J-orchestrator-0235`) settles it — and settles it against my own diagnosis rather
than with it: `FINDING SO-5` blamed my criterion, and A2.1 measured the two sentences and
found the impossibility was minted one hop upstream, at
`docs/gates/lessons-harvest-block.md` **line 5**, in a clause citing PROTOCOL §7 for
something §7 does not contain. **The packet quoted its source accurately; the source was
wrong.** A2 partitions the eleven boxes **7 / 4**, rules that a sign-off instantiates
**Part A only** with Part B as a named deferral line (A2-D1), and pointedly **restates
nothing of `SC-12`** — leaving the reading to this document, which §1.3 makes and shows
its working for. **Under that reading Part A's seven boxes are all checked at `41fead6`
(§4.10), and — the test that matters — the three boxes that failed in round 3 are all in
Part A, so the amendment relieved none of them and could not have flipped this token by
itself.** **Every other criterion is re-measured at the new SHA and holds**: the suite and
the tree green and clean on `build` run **`31453108454`** with all thirteen steps
`success`, the `cosim` job green and quoted separately, the census unmoved at 78/62/7/4/4/1
over a byte-identical plan, the mutation era unmoved over a byte-identical audit directory,
the ten-thousand-frame line-rate stress green, the matrix unmoved at 110/34/76, no `BUG-`
open. **And the thing that made this round hard is the mirror of the thing that made round
3 hard: with everything else paid, the only way to keep a `FAIL` alive was to find a new
ground, and one was in reach** — two of the eighteen statements carry a version-control
tool noun under a stated `LH2-g`. **I measured it, recorded it as `OBSERVATION SO-O1` with
an owner and a route, and did not charge it**, because round 3 ruled that grade allocation
belongs to the miner at a time when ruling so cost it nothing, and a bar a grader may raise
at the last obstacle is as much a function of who is graded as one he may lower.

#### 8.R4.2 What this `PASS` is, and what it is not

**It is a merge precondition and nothing larger** (PROTOCOL §3, charter §3). Concretely:

- **It is the DV rows of `P1-module-ready`, supplied as satisfied.** It is **not** that
  gate's decision, and it is not a gate signature: `docs/gates/**` is outside my write
  scope and the orchestrator transcribes every signature (PROTOCOL §6, §7, §0.3).
- **It is not the sponsor's approval.** That is E1 and it lands at `P1-phase-accept`
  (§7.3), behind replay, the latency report and an audit report with no open CRITICAL
  findings.
- **It is not an escalation and it opens no packet.** No `BUG-` is opened, nothing routes
  to rtl_lead, and nothing here is E-class.
- **It does not lift, move or renew anything.** **No bar lifted, no class anchored, no row
  re-statused, no count carried, no finding closed by being inside a `PASS`.** The two
  things this round changed in the programme's standing knowledge are **`SC-12`'s status**
  and **`FINDING SO-6`'s disposition**, and both changed because other seats performed
  acts, not because this packet decided anything.

#### 8.R4.3 What this `PASS` owes onward, with each carrier named

1. **A2.4's five clerical edits to `docs/gates/lessons-harvest-block.md`** — text fixed at
   A2.4; **carrier: the architect's next `docs/gates/` round**, the `P1-module-ready`
   checklist round already owed. Until it lands, the block's line 5 still carries the
   over-reach and a reader reaches the correct rule by the block's own deference clause
   (§1.3). **Not mine to stage.**
2. **Part B of the harvest** — shell transcription (one commit **per harvest**, A2-D5),
   the `LC-`/`LD-` → `L-` pairs, sponsor visibility, and the completeness declaration.
   **Carrier: the orchestrator as collator, at `P1-module-ready`** (§4.10's deferral line).
   **The gate re-checks Part A over its own spans and inherits nothing from this table**
   (A2-D3).
3. **`OBSERVATION SO-O1`** — owner the miner, route the collator's hide test at gate-time
   transcription, instrument A1.4's later-harvest regrade. **Recorded, not charged.**
4. **The standing findings** — `SO-2`, `SO-3`, `SO-4`, `M-4`, `P-1`'s residue and §3.9's
   set — unrepaired, carriers unopened, and listed as bounds below.

#### 8.R4.4 THE BOUNDS INSIDE THIS `PASS` — twelve, each naming what it bounds (SC-14)

**`SC-14` admits a bound inside a `PASS` for *"everything the module has not earned"*, and
this is that list.** None of these is a qualifier on the token; each is a statement of
what the evidence does **not** reach.

| # | the bound | where it is measured |
|---|---|---|
| 1 | **The charter §3 external anchor is UNDISCHARGED as a module-level anchor.** The differential co-simulation anchors **classes**, one of them (`F-4`), and the packet says so in terms and never otherwise | §2.3-M, §5.1, `SC-6` |
| 2 | **`opam exec -- dune runtest` cannot execute in this container** (ADR-0005), so the suite's evidence is a **CI run id**, not a local green | §2.9-R2, `SC-3` |
| 3 | **"Zero rx backpressure asserted" is discharged STRUCTURALLY, not observed** — `M03-L6`: the stream under test exposes no `tready` and none exists, so there is no signal a consumer could assert | §2.10, `SC-4` |
| 4 | **The mutation era has one survivor, `G-c4`.** The column stays **1**; its defect is measured dead at the repaired bench (run `30852220315`), and the two facts are reported side by side rather than folded | §2.2-M, `SC-5` |
| 5 | **One attack-plan row is a declared `GAP`** — `M03-O2` — and four are `NO-STIMULUS`, four `STRUCTURAL`, seven `NO-ASSERT` | §2.1-M, `SC-1` |
| 6 | **Five landed green assertions are unreachable by any mutation** — `U-1` … `U-5` and `DECLARATION WO-0074-D1`. **A coverage claim counting such an assertion has counted one observation twice** | §2.6, `SC-8` |
| 7 | **Stage 3 of the co-simulation lane is REFUSED**, and REQ-901's classes (g)/(h) landing **reduces** what the lane can anchor and bars C9's stimulus outright | §6.4 |
| 8 | **The traceability matrix is 34 of 110 populated.** The 34 are this module's hooks; **76 rows remain empty and 97 read `OPEN`**, and they are other modules' rows | §2.8-R, §2.12(3) |
| 9 | **Five findings are unrepaired with their carriers unopened** — `SO-2` (census producer domain), `SO-3` (the 22-assertion figure does not reproduce; measured 7 of 29), `SO-4` (`AP-M03` §7 row (b), 24 vs 17), `M-4` (141 contaminated vs 139 honest), `P-1`'s residue (`WO-0079` §2.1 false at 1 of 49 citations) | §3.12 |
| 10 | **The harvest's COLLATION has not happened.** No `L-` id exists in any artefact at `41fead6`; no shell commit; no sponsor sight; no completeness declaration. **Part B, deferred to `P1-module-ready` by name** | §4.10 |
| 11 | **`OBSERVATION SO-O1`** — two of eighteen candidates in one seat's note carry a version-control tool noun under a stated `LH2-g`. **Measured, owned by the miner, routed to the collator's hide test** | §4.10 |
| 12 | **Thirty of forty tb_writer entries carry no harvest note** (`-0001 … -0020`, `-0031 … -0040`), a gap this lead-level pass found real and did **not** close | §4.7 |

**Read the twelve together and they say one thing**: this module's behavioural evidence is
the strongest in the programme and it is bounded in ways the packet names rather than
hides. **That is what a `PASS` with a bound list is for, and it is the only shape in which
`SC-14` permits one.**

---

> ### THE ROUND-3 VERDICT, PRESERVED AND QUOTED — §8.0 … §8.0.3 below are round 3's text at `14615f8`, left UNEDITED
>
> **`J-dv_lead-0167`, dv_lead, at re-verdict SHA `14615f8`, wrote:**
>
> > # FAIL
> >
> > **One token. No qualifier, no reservation, no "subject to" (SC-14).**
> >
> > **Re-signed `J-dv_lead-0167`, dv_lead, at re-verdict SHA `14615f8`.**
> > **Thirteen of fourteen criteria MET; the one not met is `SC-12`** (§1.2).
>
> **That token stood on ONE criterion — `SC-12` — and on `FINDING SO-6` inside it. It is
> paid** (§4.10). Quoting it here is a **retrospective reference to a verdict already in
> history** (PROTOCOL §10's own carve-out), not a second live token: §8.R4 carries the
> only live verdict this packet has. **Round 3's own text at §8.0.1 … §8.0.3 stands
> exactly as written**, including its routing instruction and its refusal to rule the
> wording question — the instruction this round obeyed and the refusal this round did not
> reverse. **This is precisely the move round 3 made on round 2's token at this same
> position**, and it is disclosed for the same reason: the words are unchanged, only the
> quoting is.

### 8.0 RE-ISSUED at `14615f8` — round 3, the re-verdict — *round 3's, at `14615f8`, unedited; its token quoted above*

> **DATED ANNOTATION, 2026-08-11, `J-dv_lead-0168`.** Round 3's token block stood here and
> is carried **verbatim** into the quote immediately above, so that this file holds
> **exactly one bare token** as `SC-14` requires. **Not one word of it is altered**, and
> §8.0.1 … §8.0.3 below are untouched.

#### 8.0.1 The ground, in one paragraph

**Both acts §8.2 required were performed, one of them completely.** **Act 1 is paid in
full**: the test-side traceability rows were drafted as `WO-0079` at `a43ac00`, delivered
to a reviewer who is not me, and transcribed into `docs/specs/traceability.md` at
`14615f8`; measured at the file rather than at the report of it, **34 of 34 cells are
string-identical to what was delivered, no row was populated that was not delivered, and
the 34 rows that changed were every one of them empty and `OPEN` before** — so **`SC-2`
moves NOT MET → MET** and `FINDING SO-1` is discharged by the carrier it named. **Act 2
is performed and one of its four products does not meet the bar.** All four previously
unmined spans are now mined — `J-auditor-0019`, `J-orchestrator-0233`,
`J-architect_docs_lead-0034`, `J-rtl_lead-0013` — and **three of the four notes are
conformant**, carrying their span as an interval, their candidates with LH1 and LH3
discharged at a stated grade, their classifier run from the most general honest
statement, and their war stories with the criterion each failed. **The fourth does not.**
Of the eighteen candidates banked at `J-orchestrator-0233`, **zero discharge LH3**, none
carries a stated LH2 grade, and the note nowhere states the classifier was run — while
PROTOCOL §7 makes LH1 **and** LH2 **and** LH3 the condition of a candidate being
*admissible at all*. **Three of the instantiated block's eleven boxes therefore cannot be
checked, all three at that one row** (`FINDING SO-6`, §4.9), and `SC-12` is **NOT MET** on
a ground round 2 could not reach, because round 2 had no note to read. **Every other
criterion is re-measured at the new SHA and holds**: the suite and the tree are green and
clean at `14615f8` on `build` run **`31449924111`** with all thirteen steps `success`, the
`cosim` job green and quoted separately, the census unmoved at 78/62/7/4/4/1 over a
byte-identical plan, the mutation era unmoved over a byte-identical audit directory, the
line-rate stress green, no `BUG-` open. **And the thing that made this round hard is worth
naming: with `SC-2` paid, `SC-12` became the only obstacle to a `PASS` — which is exactly
the condition under which §0.0 predicted a packet would start reading its own clauses
generously.** It did not.

#### 8.0.2 What this `FAIL` routes to — one act, and it is not rtl_lead's and not mine

**Still normal packet flow, still not an escalation** (charter §7, §0.3). **No `BUG-` is
opened by this verdict and none is owed.** **One act clears it:**

1. **The orchestrator's harvest note is completed for the span it already walked.** A
   successor note over `J-orchestrator-0001 … -0232` that discharges **LH3** per
   candidate, runs the classifier from step 0, and records each candidate's **grade** —
   `LD-` rows naming their pack. **No renumbering**: `RULING O-1` already fixes the id
   space and `LC-orchestrator-H1-1 … -18` conform to it. **It is a bounded round over a
   chain already walked, and it is the only SUBSTANTIVE thing between this packet and a
   `PASS`** — the qualifier is exact, because the wording question below must also be
   settled, and by amendment rather than by anyone's reading.
   **I cannot perform it** — no agent writes another agent's journal (PROTOCOL §4) — and
   I spawn no one (charter §7), so it is the orchestrator's own round to run.

**One thing this round refused to decide, and the refusal is named so it is not mistaken
for an oversight.** `FINDING SO-5`'s wording half is unrepaired: `SC-12` demands *"every
box checked"* of a **packet**, while four of the eleven boxes are the orchestrator's
**later** acts by §4.1's own text — collation, `L-` pairs, sponsor-visibility, the
completeness declaration. On a literal reading no `SO-` can ever satisfy `SC-12`. **This
round does not rule on it, in either direction**, because it is not load-bearing for this
token and because both possible rulings would amend a criterion inside the document the
criterion grades. **Carrier: an ADR-0018 amendment (PROTOCOL §11), raised at
Open-questions in `J-dv_lead-0167`.** **A re-verdict round that finds `SO-6` paid must
settle it before it can write `PASS`, and it must settle it by amendment, not by
reading.**

#### 8.0.3 What a reader should NOT take from this token

- **It is not a statement that `xgmii_rx_64` is defective.** Nothing in §2 convicts the
  design; `libs/` is byte-identical to the tree round 2 scored, and thirteen of fourteen
  criteria are met.
- **It is not a finding against the orchestrator as a seat.** `FINDING SO-6` is written
  against **a note's contents**, its repair is bounded, and the note it convicts is the
  first harvest of a chain of 232 entries that had never been mined — mined, moreover,
  because that same seat commissioned the round that convicts it.
- **It is not a `P1-module-ready` decision, and it is not the sponsor's approval.** The
  gate reads a `PASS`; on this verdict the DV rows are supplied as **not yet satisfied**.
- **It does not lift, move or renew anything.** No bar lifted, no class anchored, no row
  re-statused, no count carried. **The two things this round changed in the programme's
  standing knowledge are `SC-2`'s status and the harvest's measured completeness**, and
  both changed because an act was performed, not because this packet decided anything.

---

> ### THE ROUND-2 VERDICT, PRESERVED AND QUOTED — §8.1 … §8.3 below are round 2's text at `2183d71` and are left UNEDITED
>
> **`J-dv_lead-0165`, dv_lead, at sign-off SHA `2183d71`, wrote:**
>
> > # FAIL
> >
> > **One token. No qualifier, no reservation, no "subject to" (SC-14).**
> >
> > **Signed `J-dv_lead-0165`, dv_lead, at sign-off SHA `2183d71`.**
>
> **That token stood on TWO criteria — `SC-2` and `SC-12`. One of the two is paid.**
> Quoting it here is a **retrospective reference to a verdict already in history**
> (PROTOCOL §10's own carve-out), not a second live token: §8.0 carries the only live
> verdict this packet has. **`SC-2`'s round-2 row at §1.1 and its measurement at §2.8 are
> left standing exactly as written**, annotated beside themselves at §2.8-R, because a
> dated claim is never rewritten into its own outcome.

### 8.1 The ground, in one paragraph — *round 2's, at `2183d71`, unedited*

**Twelve of the fourteen criteria at §1 are met and the module's behavioural evidence is
complete**: the attack plan preceded the first test by forty-nine commits, all
sixty-two `ASSERT` rows are discharged with an empty outstanding set, every REQ-###
SPEC-M03 §10 hooks carries a coverage entry, the suite and the tree are green and clean
at `2183d71` on `build` run `31444471834`, the ten-thousand-frame line-rate stress is
green, the mutation era is reported unfolded in all five of its columns with every
non-kill named and the era's single survivor's defect measured dead at a run id, the
anchor is stated per class with its bars intact and no requirement claimed, the
unreachable-instrument register is published, and **no `BUG-` against this module is
open**. **Two criteria are not met, and neither is a defect in the module.**
**`SC-2`** requires the test-side rows of the traceability matrix to have been delivered
to architect_docs_lead; measured at `2183d71`, `docs/specs/traceability.md` carries
**110 REQ rows and 110 empty `Test(s)` cells**, the column has been empty since it was
created *"pending DV"* on 2026-08-02, and **no dv_lead artefact has ever delivered
those rows** — an obligation this packet's own twelve-step execution order never
scheduled, discovered at step 8 by the round being graded on it (`FINDING SO-1`).
**`SC-12`** requires the programme's first lessons harvest to be complete; my own span
is walked end to end — `J-dv_lead-0001 … -0165`, ninety-eight bankings reconciled to
ninety-five distinct candidates, nine war stories, worker spans mined, no total quoted
that was not walked — but PROTOCOL §7 makes the harvest a **five-agent** act at every
sign-off, and **four of the five persistent-journal agents have never harvested and
have never been asked to** (`FINDING SO-5`). **Both failures could have been dissolved
by reading a clause as administrative after seeing that it was the only thing standing
between this packet and a `PASS`** — and that is precisely the move §0.0 was written to
refuse: *a condition whose author may discharge it by declaring it discharged is not a
condition.*

### 8.2 What this `FAIL` routes to — and it is not rtl_lead — *round 2's, at `2183d71`, unedited*

**This is normal packet flow and it is not an escalation** (charter §7, §0.3). **But it
does not route to rtl_lead**, because neither failure names anything rtl_lead can fix,
and the packet says so rather than letting the default routing carry it to the wrong
seat. **No `BUG-` is opened by this verdict and none is owed.**

**Two acts clear it, and both are bounded:**

1. **Deliver the test-side traceability rows.** A dv_lead round drafts them for
   SPEC-M03 §10's hooks — REQ id, the `M03-` rows that attack it, the landed unit each
   is discharged by — as a packet in `agents/handoffs/`, delivered to
   architect_docs_lead for transcription into `docs/specs/traceability.md`, which
   dv_lead cannot stage (PROTOCOL §6). **Carrier named at §2.8.**
2. **Commission the other four harvests.** `architect_docs_lead`, `rtl_lead`, `auditor`
   and `orchestrator` each mine their own span for this sign-off, per PROTOCOL §7. The
   orchestrator then collates the five notes into §4.8's block, and the boxes that are
   unchecked there become checkable. **This is the orchestrator's dispatch to make, not
   mine** (charter §7: I spawn no one).

**When both are done, this packet is re-issued with its verdict re-read against §1** —
**not amended in place**. Every criterion is re-checked, because a criterion satisfied
by a later act is satisfied at a later SHA, and §0.2's SHA dimension applies to this
packet's own verdict as much as to its counts.

### 8.3 What a reader should NOT take from this token — *round 2's, at `2183d71`, unedited*

- **It is not a statement that `xgmii_rx_64` is defective.** Nothing in §2 convicts the
  design; the module's evidence is the strongest in the programme and §1.1 scores it.
- **It is not a `P1-module-ready` decision.** That gate is `docs/gates/`', the
  orchestrator transcribes its signatures, and this packet supplies its DV rows —
  which, on this verdict, it supplies as **not yet satisfied** (PROTOCOL §7: the gate's
  precondition is per-module `SO-` **PASS**).
- **It is not the sponsor's business as an escalation.** A `FAIL` is inside-the-org
  packet flow; what reaches the sponsor is the E1 gate packet, and this verdict is one
  input to it (§7.3).
- **It does not lift, move or renew anything.** No bar lifted, no class anchored, no row
  re-statused, no count carried. **The one thing this round changed in the programme's
  standing knowledge is §2.4-M's tally**, and that changed because the specification
  moved, not because the packet decided anything.

---

## 9. What this draft deliberately does not do

> **DATED ANNOTATION, 2026-08-11, `J-dv_lead-0165` — this section is the DRAFT round's
> statement about itself and is left UNEDITED.** Every item below was true of the round
> that wrote it, and items 1 and 5 are now discharged **by later rounds** rather than
> falsified: the verdict this section declined to open is opened at §8, and the five
> carriers it declined to pay are paid at §3.0, §3.0.1 and §3.10. **A dated claim is
> annotated beside itself, never rewritten into its own outcome** (`J-dv_lead-0143`
> item 12's rule, applied here to my own text). Items 2, 3, 4 and 6 remain true of
> every round of this packet's execution: **no `docs/**` byte, no `WO-0078` amendment,
> no CD edit — the tenth consecutive refusal — and, in this round, nothing run that
> builds or simulates.**

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
| 2026-08-11 | **RE-VERDICT ROUND 4 — §1 re-read criterion by criterion at `41fead6`; the packet is RE-ISSUED and §8.R4 carries `PASS`.** State moves `RE-ISSUED — RE-VERDICT EXECUTED` → the same at the new SHA; **Verdict moves `FAIL` → `PASS`**. **§1.4 reads the fourteen back a third time: FOURTEEN MET, NONE NOT MET** — §1.1's and §1.2's tables left unedited beside it. The re-read rests on a measured identity: **five** paths moved `14615f8..41fead6` and none is a census producer, spec, plan, matrix, audit manifest, gate file, constitution or charter — `test/`, `tools/`, `libs/`, `test/cosim/`, `test/attack_plans/`, `docs/reports/audit/`, `docs/specs/requirements.md`, SPEC-M03, `AP-M03`, `docs/specs/traceability.md`, `agents/PROTOCOL.md`, `docs/gates/lessons-harvest-block.md` and `agents/charters/dv_lead.md` all **byte-identical** — stated with SHA, domain and polarity, and naming the one governing document that DID move (this ADR) rather than burying it. **§1.3 settles `SC-12`'s reading, and settles it by applying an amendment rather than by making one**: **ADR-0018 Amendment A2** (`85753b6`, `J-architect_docs_lead-0036`) is **in force at `41fead6`** on the acceptance act `J-orchestrator-0235`; it partitions the block's eleven boxes **7 / 4**, rules an `SO-` instantiates **Part A only** with Part B as a named deferral line (A2-D1), keeps all eleven at a gate (A2-D2), bars inheritance (A2-D3), and **restates no word of `SC-12`** (A2.3, A2.9) — so the reading is written here, with four checks that it is not the discharge-by-declaration move, including A2's own test that it cannot flip a token (all three round-3 failures are Part A). **A2 also relocates the defect: the impossibility was minted at `docs/gates/lessons-harvest-block.md` line 5, not in `SC-12`** — the packet quoted its source accurately and the source was wrong. **§4.10 re-instantiates the block under the partition, with `J-orchestrator-0234` (`b4814b0`) measured at its own journal**: the same span, the same eighteen ids **unrenumbered** (A2-D6(1) confirming spans-not-notes), **18/18 stated `LH2-g` grade, 18/18 `LH3` naming a concrete breakage, the classifier stated as run from step 0**, war stories with criteria, worker-span nil with cause — counted mechanically, with the round-3 counts re-run on `-0233` to confirm the defect reproduced before calling it repaired. **`FINDING SO-6` DISCHARGED**; **`FINDING SO-5`'s wording half SETTLED BY AMENDMENT**, its substantive half untouched by A2 and re-verified. **Part A: seven of seven CHECKED** — including box 1, whose round-3 forward observation (the auditor's prospective one-entry gap) is **closed by A2-D10/D11/D12 with no journal edited**. **`OBSERVATION SO-O1` minted and deliberately NOT CHARGED**: two of the eighteen statements carry a version-control tool noun under a stated `LH2-g`, measured by a token scan over all eighteen, with three grounds for not charging it — round 3's own pre-commitment that grade allocation is the miner's, A2-D4's codification of that refusal, and the constitutional difference between an admissibility failure (LH3 absent → nothing banked) and a routing question (grade → per-candidate bounce, A1.4 later-harvest regrade). **§2.9-R2 walks the whole CI interval rather than the endpoints** — applying `LC-dv_lead-H2-2`, the rule this packet's own last harvest banked — capturing `build` **`31453108454`** (job `93661268366`, **all 13 steps `success`**), `cosim` job `93661268386` `success` quoted separately, `journal-check` `31453108435` `success`, **and disclosing that `85753b6` has no CI run at all** because it was pushed with its successor. **§2.12** re-takes every set claim with its three dimensions and names the two things the round refused to quote. **§3.12** records the ledger — three items, **none of them paid by me**, all landed before the round opened — and adds A2.4's five clerical gate-file edits to the standing set with the architect's next `docs/gates/` round as carrier. **§5.8-R2** lists six sentences this round declined to write, including the two a `PASS` made available for the first time. **§8.R4 carries the live `PASS` with twelve listed bounds (§8.R4.4)**, `SC-14`'s own requirement that everything unearned be a bound and not a qualifier; **round 3's token is preserved verbatim and quoted, round 2's quotation is untouched, and the file holds exactly one bare token.** **No finding closed by being inside a `PASS`. No bar lifted, no class anchored, no row re-statused, no count carried, no `BUG-` opened, no other agent's candidate re-graded, nothing outside `agents/handoffs/**` and my own journal written.** | dv_lead, `J-dv_lead-0168` |
| 2026-08-11 | **RE-VERDICT ROUND 3 — §1 re-read criterion by criterion at `14615f8`; the packet is RE-ISSUED and §8.0 carries `FAIL` on ONE criterion.** State moves `ISSUED — EXECUTED` → **`RE-ISSUED — RE-VERDICT EXECUTED`**. **§1.2 reads the fourteen back a second time: THIRTEEN MET, ONE NOT MET (`SC-12`)** — round 2's §1.1 table left unedited beside it. The re-read rests on a measured identity: eleven paths moved `2183d71..14615f8` and **none is a census producer** — `test/`, `tools/`, `libs/`, `test/cosim/`, `docs/reports/audit/`, `docs/specs/requirements.md`, SPEC-M03 and `AP-M03` all **byte-identical** — stated with SHA, domain and polarity. **`SC-2` moves NOT MET → MET at §2.8-R**: `WO-0079` delivered at `a43ac00` (`J-dv_lead-0166`) and transcribed at `14615f8` (`J-architect_docs_lead-0035`); measured at the matrix rather than at the report of it — **110 rows / 34 populated / 76 empty / 13 `COVERED`**, a cell-for-cell **string comparison returning 0 mismatches**, 0 rows populated that were not delivered, the 34 changed rows every one of them previously empty and `OPEN`, the `COVERED` set exactly tier A, 48 of 49 citations landing on a `let%expect_test` with the one exception self-declaring; hook-set equality re-derived from the spec (35 tokens − `REQ-010` = the 34 delivered) and all 14 M03-owned rows present. **`FINDING SO-1` DISCHARGED by the carrier it named.** The transcriber's two precisions re-measured, not accepted: **`P-1` UPHELD and refined** (the cited unit at `test_m03_f.ml:492` carries `M03-F2`, and `M03-M10` occurs in that file only at line 324, inside a different unit — the cell stays, `WO-0079` §2.1's generalisation is what is imprecise), **`P-2` ACCEPTED**, neither changing a cell. **§2.9-R** captures the CI evidence at the new SHA — `build` run **`31449924111`**, job `93651991502`, **all 13 steps `success`**, `cosim` job `93651991568` `success` quoted separately, `journal-check` `31449924167` `success` — **and discloses the one red run between the two sign-off SHAs**: `31447385249` at `a851948`, the commit carrying round 2's own `FAIL`, failed at step 4 *Install dependencies* with the test steps **skipped**, so the suite did not fail, it did not run, and it did not recur across runs 532–538. **§3.11** records the round's two-item ledger — both of §8.2's acts paid in commits preceding this read — re-checks the standing set rather than recopying it, and closes `FINDING SO-1`. **§4.9 re-instantiates the harvest block at the new SHA, with every seat's note read at its own journal rather than from the dispatch**: `J-auditor-0019` (54), `J-architect_docs_lead-0034` (94), `J-rtl_lead-0013` (50) are **CONFORMANT** on span, LH1, LH3, grade, classifier and war stories; **`J-orchestrator-0233` (18) is NOT ADMISSIBLE AS BANKED** — **0 of 18 discharge LH3**, none carries a stated LH2 grade, and the classifier is nowhere stated as run, against PROTOCOL §7's own admissibility sentence. **`FINDING SO-6` (MAJOR) minted**, written against a note's contents and not against a seat, with a bounded repair owned by the only agent that may append to that journal. **Block: five boxes checked, six unchecked — the same count as round 2 and a different set**, three mining boxes now failing at one row for one reason plus the same four collation boxes. **`FINDING SO-5`'s wording half is left UNRULED in either direction**, with an ADR-0018 amendment named as its carrier, because both possible rulings would amend a criterion inside the document it grades. §5.8-R lists six further sentences the round declined to write with the bar that forbade each. **One finding minted, mine, against another agent's artefact with the repair named and no edit made to it. No bar lifted, no class anchored, no row re-statused, no `BUG-` opened, nothing outside `agents/handoffs/**` and my own journal written.** | dv_lead, `J-dv_lead-0167` |
| 2026-08-11 | **EXECUTION ROUND 2 — §7.1 steps 6–12 EXECUTED; the packet is ISSUED and §8 carries `FAIL`.** State moves `DRAFT` → `ISSUED — EXECUTED` at sign-off SHA `2183d71`. **§1.1 reads the fourteen criteria back: twelve MET, two NOT MET (`SC-2`, `SC-12`).** §2 gains six measured blocks and four new sections, every figure re-measured with SHA, domain and polarity: **§2.1-M** the census (78/62/7/4/4/1 unmoved, 62 of 62 discharged) with **`FINDING SO-2`** — the census block's producer domain is undeclared and a wide-domain pass returns 63 — and **`FINDING SO-3`** — the 22-assertion breadth figure does **not** reproduce, the measured figure is **7 of 29**, ledger item 11 closed by re-measurement; `FINDING M-4` re-measured at **141** contaminated against 139 honest, the contaminated figure having moved while the honest one did not. **§2.2-M** re-walks the era tally to **63 / 61 / 1 / 0 / 1** over the **ten class-based campaigns**, states the four earlier campaigns' **15 of 15** separately with `D-M3`'s equivalent-mutant exclusion, and records the survivor `G-c4` **both ways**: the column stays 1, and the defect is measured dead at CI run **`30852220315`** with `M03-G8` the only failing unit of twenty-seven. **§2.3-M** re-observes the five classes at run `31444471834` / job `93635620959` (**not a lift**), **quotes the agreed-value print** the round-1 comparator repair produces — `word 7: tkeep = 0f tlast = 1 tuser0 = 1` at case C3 — and writes REQ-104's row **as the pair**; bar 1's set claim re-measured over both producers, surviving, with **`FINDING SO-4`** against `AP-M03` §7 row (b)'s command/figure mismatch (24 raw, 17 executable). **§2.4-M is the round's largest correction: the seventeen-class tally does NOT survive**, because REQ-901 gained classes **(g)** and **(h)** in force at `4e7331b` with `CSG-1`/`CSG-2` repaired at `ce5674d` — **five inside / twelve outside becomes NINE inside / EIGHT outside**, E-1 into (g), E-2/E-3/H-5 into (h), H-1/H-2 additionally **barred as stimulus**; anchored classes still **one**, F-4. **§2.8** measures SC-2's third clause **UNMET** — 110 rows, 110 empty `Test(s)` cells — and mints **`FINDING SO-1`**, refusing to manufacture the deliverable inside the document graded by it. §2.9–§2.11 carry the CI evidence, the stress row with its structural backpressure discharge, and the three-dimension record. **§3.10 closes the owed ledger, twelve of twelve.** **§4.4–§4.8 take the programme's first lessons harvest**: the chain walked from `J-dv_lead-0001`, **89 dv_lead bankings + 9 worker bankings = 98 walked, 3 merged, 95 distinct** (94 `LC-`, 1 `LD-` pack `version-control`), **9 war stories** with the criterion each failed, worker spans mined with a declared thirty-entry gap in the tb_writer chain, and **two further accounting defects found that no prior note names** — one rule banked twice across regimes, one banked as new that was already the set-claim rule. §4.8 instantiates the block: **five boxes checked, six unchecked**, and **`FINDING SO-5`** records that `SC-12` demands of this packet what its author cannot do **and** that the harvest is one-fifth complete on substance. §5.8 lists twelve sentences the packet declined to write with the bar that forbade each. **§6.4 re-measures Stage 3: still REFUSED on (b), (c), (e); (g)/(h) landing REDUCES what the lane can anchor and bars C9's stimulus outright.** **Five findings minted, all mine, all against my own artefacts.** No bar lifted, no class anchored, no row re-statused, no `BUG-` opened, nothing outside `agents/handoffs/**` and my own journal written. | dv_lead, `J-dv_lead-0165` |
| 2026-08-10 | **EXECUTION ROUND 1R — the round-1 payment's own CI verdict, and its repair, at base `ee3da9c`.** `RN-6`'s check failed its first runner execution (`build` `31442295998`): 4 UNDECLARED broken citations, all citing `docs/reports/latency/`, **this packet among the four citers**, against 0 locally. **Two findings, both mine, both paid**: `FINDING RN-6-CI-1` — the catch is a TRUE POSITIVE, the directory existed only as an empty untracked directory that git cannot carry, so the path is absent from every fresh clone; `FINDING RN-6-CI-2` — the resolver measured the FILESYSTEM where the honest test is the TRACKED TREE. Repairs: the resolver is rebuilt on `git ls-files` over two universes (tracked / committable), neither of which can contain an empty directory, with `PENDING-COMMIT` printed for a citation resolving only through an uncommitted path; the four citations are dispositioned as **one tracked file, zero errata** (`docs/reports/latency/README.md`), so this packet's own citation ends the round RESOLVING rather than declared-broken (`SC-10`). Header gains an Execution bullet; §3.0.1 records the round; §3.2.1 carries the repair, the dispositions and seven evidence rows including a constructed fresh checkout and three negative controls. **No §7.1 step executed, no ledger item moved, State still DRAFT, §8 still UNSET, no criterion of §1 adjudicated.** | dv_lead, `J-dv_lead-0164` |
| 2026-08-10 | **EXECUTION ROUND 1 — §7.1 steps 1–5, at base `4e7331b`.** Header gains an Execution bullet; §3.0 records the four ledger items paid (`FINDING K-1`'s message repair in `test_m03_k.ml`; `RN-6`'s gating `docs/**` resolve-check in `tools/dv_checks.sh`, with a self-test, a declared-errata table and a staleness guard; `FINDING RV-0078-S2-11` ruled and executed; `U-1`/`U-2` answered) and raises one finding against this packet's own §3.9 — `FINDING RV-0075-1` is listed as standing and is CLOSED. §3.5 and §3.8 gain their `RULED` blocks: the comparator is opened and prints the agreed values on the passing path; the `U-1`/`U-2` pricing is refused with a price, a bound and a three-trigger expiry. **State still DRAFT, §8 still UNSET, no criterion of §1 adjudicated, no bar lifted, no count asserted, no harvest taken.** | dv_lead, `J-dv_lead-0163` |
| 2026-08-10 | **Document created as a DRAFT at `49d87af`.** Fourteen sign-off criteria (`SC-1` … `SC-14`); the evidence map over the bench era with its five riders, the ten-campaign mutation era in five columns, the anchor's five classes at run and job ids, the seventeen-class error table, the four bars and the five unreachable instruments; a twelve-item owed ledger with `FINDING K-1` positioned before the family-K rows; the first lessons harvest designed — span opened at `J-dv_lead-0001`, the bank enumerated at its sources across four labelling regimes with three accounting defects named, and a re-labelling method rather than a total; the prohibition register; the Stage-3 statement with its expiry and its (g)/(h) dependency recorded as pending; a twelve-step execution order and the sponsor's gate. **No verdict, no lift, no carrier paid, nothing run.** | dv_lead, `J-dv_lead-0161` |
