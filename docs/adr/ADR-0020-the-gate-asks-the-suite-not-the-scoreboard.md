# ADR-0020: the gate asks the suite a question, not the scoreboard

- **Status**: **PROPOSED. NOT IN FORCE.** Nothing in this file amends anything
  at this landing. It is the §11(1) instrument for the `PROTOCOL` §7/§10
  amendment the auditor's `G-1` adjudication commissioned (`J-auditor-0020`,
  routed at `J-orchestrator-0259` Act 2 item 2). The clauses at §3–§7 below are
  **source text**, and each names the act that puts it in force. §0 states, per
  clause, what is and is not in force meanwhile.
- **Deciders**: **orchestrator** — the acceptance act (§11(2)), and the
  application of the §3/§4 hunks to `agents/PROTOCOL.md`, which is its scope and
  not mine (§6). **architect_docs_lead** — this instrument: the clauses' exact
  wording, the reading at §1.2 that makes them an amendment rather than a
  construction, the `G-9` adaptation at §5, the equivalent-mutant standard at §6,
  the disposition of dv_lead's offered rule at §7, and the item-70 ruling at §8.
  **auditor** — the adjudication this transcribes and the four-defect
  specification (`J-auditor-0020` §9), plus the countersignature §9 owes it on
  the two clauses that bind its own future acts. **dv_lead** — the score, the
  five-column reporting practice these clauses codify, **`FINDING REC-3` and the
  unscoreable-seeding clause it offered, which corrected (b.1) mid-draft (§6.4)**,
  the offered countersignature rule at §7, and the countersignature §9 owes it.
  **Not an escalation class.** No requirement is added or dropped, no phase, no
  role, no toolchain lane, no licensing boundary; it states how one gate clause
  is read.
- **Proposed by**: the auditor's `G-1` verdict — *"the measured record does not
  satisfy §7 as written, and the clause must move"* — routed to this seat as a
  §11 act.
- **Work order**: none (orchestrator dispatch, one round) ·
  **Journal**: `J-architect_docs_lead-0045`
- **Affects, if accepted**: `agents/PROTOCOL.md` §7 (the `P<n>-module-ready`
  table row and a new **Mutation record** paragraph) and §10 (the
  mutation-discipline bullet's reporting sentence) — **diffs written at §3 and
  §4, applied by the orchestrator**; `docs/gates/P1-module-ready-checklist.md`
  §0.1, §3.1 and §9 (form only, §10 below); `docs/specs/SPEC-TEMPLATE.md` §13
  and `docs/specs/requirements.md` §13's preamble (§7 below). **No frozen spec's
  normative sentence, no requirement, no interface record, no enforcement
  script, no closed gate checklist, and no gate signature.**

---

## 0. What is in force at this landing, and what is not

Stated first and per clause, because this file contains normative text that does
not yet bind and a reader who meets §3 before §9 must not be able to mistake it.

| clause | status at this commit | what puts it in force |
|---|---|---|
| §3 — `PROTOCOL` §7 table row + **Mutation record** (b.1)–(b.4) | **NOT IN FORCE.** The constitution reads exactly as it did before this commit | the orchestrator's acceptance entry (§11(2)) **and** the hunk applied to `agents/PROTOCOL.md` under `Agent: orchestrator`. Both, not either |
| §4 — `PROTOCOL` §10's reporting sentence | **NOT IN FORCE**, same act | as above |
| §5 — the `G-9` reading | **NOT IN FORCE**; it is (b.4) and rides §3 exactly | as above |
| §6 — the equivalent-mutant standard | **NOT IN FORCE**; it is (b.3) and rides §3. **Prospective when it lands** (§6.3) | as above |
| §7 — the post-freeze countersignature rule | **NOT IN FORCE.** Its dv-limb is dv_lead's own offer and binds nobody until it lands in `SPEC-TEMPLATE` §13; its generalised limb additionally owes rtl_lead a countersignature | the template edit at §10 item 3, after the traffic at §9.2 |
| §8 — the item-70 ruling | **IN FORCE for this seat's own practice from this entry**, and for no one else's. It rules a question on this seat's own ledger about when this seat owes an ADR; it binds no other seat and amends no document | this file |

**Until every one of those acts completes, the governing texts are the ones at
HEAD.** `PROTOCOL` §7 clause (b) still reads *"auditor's seeded mutations all
killed by the DV suite"*; §10 still reads *"every PASS reports kills N/N"*;
`docs/gates/P1-module-ready-checklist.md` §9's `G-1` row is still open and this
file does not close it (§9.4). **A gate item is not closed by an ADR that
proposes its reading.**

---

## 1. Context

### 1.1 The measurement, re-derived at the sources rather than recited

Every figure below was read this round from the artefact that produces it, not
from the dispatch that summarised it.

**M03's class-based mutation era**, `agents/handoffs/SO-xgmii_rx_64.md` §2.2-M:

> **63 sealed / 61 killed / 1 survived / 0 green-by-blindness / 1 void**, and
> **61 + 1 + 0 + 1 = 63**.

**The void**, `docs/reports/audit/WO-0074-mutations/README.md` §3.5: `IC-M5` —
**NOT SEEDED**. Two renderings were shown to move the datapath and a third was
rejected because datapath-silence could not be positively confirmed at a carrier
the allowlist barred the seeder from seeing. No branch was cut and no CI job was
spent. The claim is the **narrow** one — unrenderable *at this design*, not
inherently unrenderable.

**The survivor**, same section plus `J-orchestrator-0259` Act 3: `G-c4` seeded
*the `Discard` state not gated*, survived all twenty-five units at `WO-0055`
because of a real coverage gap in the seeder's own `AP-M03` §4.G text; `WO-0056`
built `M03-G7`/`M03-G8`; the repair was proved by replaying the **unmodified**
diff on branch `mut/wo-0056-gc4-replay` = `c95c9f4`. The auditor re-verified the
replay this round at byte level — *"the diff is unmodified, as claimed"*,
character-identical including its `NEVER MERGE` banner and its
`|: (sm.is State.Discard &: any lanes.is_error)` conjunct — and named CI run
`30852220315` as the one link it had not itself executed. **That link is now
read**: the orchestrator read the run end to end (a seat that owns neither the
score nor the seed), conclusion RED, the promotion block carrying **exactly one
corrected file** (`test/xgmii_rx_64/test_m03_g.ml`), within it **`M03-G8` the
only failing unit**, failure text *"expected exactly one strobe (error_oversize
alone -- NO error_bad_frame ...), observed 2"*. The auditor's survivor half is
**unconditional**.

**The arithmetic that follows, and it is exact**: 63 sealed − 1 never seeded =
**62 seeded** = **61 killed + 1 survived**.

**The one equivalent-mutant exclusion already in the record**, `WO-0041`'s
`D-M3` — measured at §6.2 below, because it is the only instance the new clause
has to be tested against.

**The denominator caveat, resolved mid-round and by explanation rather than by
arithmetic.** The auditor's Open-question 4 recorded that the remote's `mut/`
branch count and the walk's sealed count do not reconcile — 64 branches against
63 sealed, a two-branch surplus it could not resolve without re-walking seven
packets — and routed it to dv_lead at `J-orchestrator-0259` Act 2 item 3. That
round returned mid-draft (§6.4): the surplus is `I-c1`'s void plus `IC-2`'s
negative control, both of the auditor's hypotheses refuted by measurement, **and
the deeper answer is that it was never one count.** A branch is a delivery
vehicle; the record's unit is the class. That is now a sentence of (b.1).
**Nothing in this ADR asserts a denominator**; these clauses say how one is
formed and read, and §6.4 is explicit that the corrected figures are the
score-owner's to publish.

### 1.2 Why this is an amendment and not a construction

The tempting move is to read clause (b) charitably and pass on. It is available:
§7's clause is a present-tense property of the suite, and §10 confirms the tense
with *"`module-ready` merely **re-checks** it"* — a gate that re-checks asks
whether the property holds *at the gate*, not whether every historical campaign
scored perfectly. On that reading the record satisfies clause (b) today.

**The reading is right and it is still not available without moving the clause**,
for two reasons that are independent of each other. Both are the auditor's and I
adopt them because I re-derived them, not because they were routed:

1. **A campaign score is a frozen measurement and correctly is one.** dv_lead's
   rule — *"a campaign's score is what that campaign measured, and it is never
   retro-edited"* — is right, and it means `G-c4`'s `survived` column stays 1
   permanently. A frozen historical score and a present suite capability are
   **different objects**. No reading of *"all killed"* makes one satisfy a test
   written for the other; only an amendment can say which object the gate asks
   about.
2. **§10's *"every PASS reports kills N/N"* is falsified by the honest record,
   in the direction of more information rather than less.** `SO-xgmii_rx_64`
   reports five columns with the survivor's fate stated both ways, on dv's own
   ground that *"collapsing a never-rendered class into 'killed' would overstate
   coverage and into 'survived' would libel a bench that was never given
   anything to catch."* **A rule demanding `N/N` from a reporter whose honest
   answer has four columns is a rule that pressures its reporter to fold
   columns.** The rule is wrong here, not the packet.

To which I add the reason this seat cannot settle it in a checklist. `G-1`'s own
row already names the route — *"an ADR settling the clause — **by amendment, not
by reading**, on A2.1's precedent"* — and A2.1 is this program's own conviction
for the opposite move: `docs/gates/lessons-harvest-block.md` line 5 extended
`PROTOCOL` §7's gate condition to sign-offs *while citing §7 for the extension*,
and the diagnosis was *"the packet quoted its source accurately; the source was
wrong."* A gate file that reads a constitutional clause into compliance repeats
it. So the clause moves, in the constitution, or the gate stays open.

### 1.3 The four defects, verified at their sources

The auditor specified four. I checked each against the artefact rather than the
dispatch, and one of the four is narrower than a first reading suggests.

| id | the defect, as adjudicated | what I measured | disposition |
|---|---|---|---|
| **G1-a** | clause (b) must quantify over the **seeded** set explicitly; the gate record must state sealed and seeded as separate numbers | **The word is already in §7** — the cell reads *"auditor's **seeded** mutations"*; what is missing is the instruction to read the matching column. **And the column headed `sealed` is not the sealed set**: it excludes `I-c1`, which the seeder declared SEEDED before the seal branched, and includes `IC-M5`, which was never rendered (§6.4, measured at the record) | **ADOPTED, and INSUFFICIENT as specified.** Extended on dv_lead's `FINDING REC-3` (§6.4): (b.1) defines both columns, requires the difference **itemised with each member's ground**, names the second ground `UNSCOREABLE`, and fixes the unit as the class rather than the branch |
| **G1-b** | the clause must say **when** it is measured — the suite at the gate SHA — and must require, for any mutation that survived its own campaign, the `G-c4` evidence form: unmodified committed diff, replayed against the current bench, at a run id, with the killing unit named | The evidence exists in exactly that form and is now unconditional (§1.1). **It exists because two seats that own neither the score nor the seed verified its two halves** — the auditor the diff identity, the orchestrator the run | **ADOPTED whole** (b.2). This is the limb that *raises* the bar: no such evidence requirement exists in `PROTOCOL` today |
| **G1-c** | §10's *"reports kills N/N"* becomes *reports the disposition of every seeded mutation, each non-kill named and dispositioned* | `SO-xgmii_rx_64` §2.2-M and `SC-5` already meet the better rule — five columns, never folded, *"never collapsed into a ratio or a percentage"*, every non-kill named individually | **ADOPTED** (§4). The rule moves to where the practice already is. **The practice is not codified as a five-column schema** — see §12.2 |
| **G1-d** | `PROTOCOL` has no equivalent-mutant clause, yet `WO-0041`'s `D-M3` exclusion was made under one — sound practice, unauthorised protocol. Supply the clause; require the exclusion **proven in a committed artefact** | The exclusion is real (`SO-` §2.2-M: *"`D-M3` ruled an equivalent mutant and excluded from the denominator"*), the proof is real and quantifies over the whole legal stimulus space (§6.2), **and the seeder's own artefact never records it** — `docs/reports/audit/WO-0041-mutations/README.md` contains no occurrence of the word *equivalent* | **ADOPTED and sharpened in two respects** (b.3): the proof must quantify over the **specification's legal stimulus space**, never over a bench; and the exclusion takes effect only when the **seeder** records it — which is the standard the auditor named by pointing at its own `IC-M5` §3.5 declaration |

---

## 2. Decision

- **D1.** `PROTOCOL` §7 clause (b) is amended to ask a **present-tense question
  about the suite at the gate SHA**, quantified over the **seeded** set, with the
  dispositions of non-kills required rather than a ratio. Source text at §3.
- **D2.** `PROTOCOL` §10's reporting sentence is amended to match, so that a rule
  and the check it grades do not disagree about what compliance is. Source text
  at §4.
- **D3.** A mutation that survived its own campaign is dispositioned by **one
  evidence form and no other**: the unmodified committed diff, replayed against
  the bench at the gate SHA, at a run id, with the killing unit named. The
  campaign's frozen score is not edited and the two facts stand side by side.
- **D4.** `PROTOCOL` gains its first **equivalent-mutant clause**, with a
  three-part standard (committed proof; quantified over the specification's legal
  stimulus space, never over a bench; recorded by the seeder). §6.
- **D5.** The `G-9` question is answered: an assertion no seeded mutation can
  reach **contributes nothing to a mutation-coverage claim** and still discharges
  its requirement row; the gate record carries the unreachable set beside the
  tally. §5.
- **D6.** dv_lead's offered post-freeze countersignature rule is **ADOPTED**, with
  one adaptation — the signer is *the constrained party*, not dv_lead by name —
  and homed in **`docs/specs/SPEC-TEMPLATE.md` §13**, not in `PROTOCOL`. §7.
- **D7.** Ledger item 70 is **RULED**: an ADR is owed when a change moves a
  **reading rule** — what a figure, a signature or a piece of evidence *means* —
  and is not owed for a figure, a scope or a cure inside an already-ruled rule.
  Size is not the test and never was. §8.
- **D8.** **This ADR touches no file it governs.** No `agents/PROTOCOL.md`, no
  `docs/gates/**`, no `docs/specs/**` edit lands in this commit; every such touch
  is named at §10 with the act that triggers it. Grounds at §9.1 and §10.
- **D9.** dv_lead's **`FINDING REC-3`** is **SUSTAINED** and its offered clause
  **ADOPTED in disposition and word, ADAPTED in subject and site**: an
  unscoreable seeding sits in `sealed`, not in `seeded`, named with its ground
  beside the other exclusion rather than in a clause of its own; its run is a
  scope report supporting no claim about any row; and the record's unit is the
  class, not the branch. §6.4. **This ADR publishes no corrected figure.**

---

## 3. The `PROTOCOL` §7 diff — source text; applied by the orchestrator

**This section is the authority; the edit to `agents/PROTOCOL.md` is clerical.**
The hunks below are authored here and applied to the constitution by the
**orchestrator**, under `Agent: orchestrator`, with its own journal entry citing
this section. They are **not** in this ADR's commit, and the reason is not
deference: `agents/PROTOCOL.md` is outside this seat's write scope (§6), the
enforcement script refuses it mechanically (§9.1 measures this), and ADR-0016 §8
settled that there is no ADR-driven exception — *an agent that can amend the
protocol by citing its own ADR can amend the protocol.* ADR-0018 §8 and §A1.6 are
the two live precedents where this seat authored `PROTOCOL` hunks that another
seat applied.

**Hunk 1 — the table row.** The cell is edited rather than left standing with a
pointer, because a cell reading *"all killed"* beside a paragraph saying
something else is exactly the defect ADR-0017 §1.2 convicts by name: a rule and
its check disagreeing about what compliance is.

```diff
 | `P<n>-spec-freeze` | Architect's specs complete with REQ-### requirements; interface records compile; dv_lead countersigns testability. |
-| `P<n>-module-ready` | Per-module DV sign-off packets (`SO-*.md`) PASS; auditor's seeded mutations all killed by the DV suite; line-rate stress green for rx-path modules. |
+| `P<n>-module-ready` | Per-module DV sign-off packets (`SO-*.md`) PASS; the auditor's seeded mutations dispositioned per **Mutation record** below; line-rate stress green for rx-path modules. |
 | `P<n>-phase-accept` | System replay clean; latency report committed; audit report committed with no open CRITICAL findings; sponsor approval (escalation class E1). |
```

**Hunk 2 — the paragraph.** It lands in §7 after *Phase hardening* and before
*Lessons harvest*. §7 is the right home because the question is a gate question,
the transcription mechanic it relies on is the one §7 already states, and the
sign-off half reaches `SO-` through §10's own sentence rather than through a
second hunk in §3.

```diff
 **Phase hardening**: "P\<n\> hardening" means the window between
 `P<n>-module-ready` and `P<n>-phase-accept`. It is the activation window for
 `formal_dv` and the overlap trigger for the contingent `rtl_lead_md`.
+
+**Mutation record** (ADR-0020). Clause (b) of the `P<n>-module-ready` row asks
+whether the **DV suite as it stands at the gate SHA** kills what was seeded. It
+does not ask whether every past campaign scored perfectly: a campaign's score is
+a frozen measurement of what that campaign observed and is never retro-edited,
+so the score and the suite's present capability are different objects and only
+the second is this clause's subject. **(b.1) The set, and the two columns.** The
+clause quantifies over the **seeded** mutations. The gate record states two
+numbers and the difference between them: **sealed** is every class the manifest
+sealed, with nothing removed from it for any later reason, and **seeded** is the
+subset rendered against the module **as sealed** and run. The clause is read
+against the seeded number. **Every member of the difference is named at the tally
+with its ground**, and two grounds are known: a class **never rendered**, which is
+not a seeded mutation the suite failed to kill but a mutation that does not
+exist; and a class whose rendering is found **not to render the class as sealed**,
+which is **UNSCOREABLE** — its run is a scope report rather than a bench result
+and supports no claim about any row in either direction. Both sit in `sealed`,
+neither in `seeded`, each named with its ground. **The unit of this record is the
+class, not the branch, ref or file that delivered it**: a ref population is
+monotone by infrastructure accident and cannot be a denominator.
+**(b.2) The disposition.** Every seeded mutation is either killed by
+the suite at the gate SHA or is named individually with its disposition; no
+non-kill is folded into a kill, and no ratio stands in for the dispositions. For
+a mutation that **survived its own campaign** the disposition takes exactly this
+evidence form and no weaker one: the **unmodified** committed diff, replayed
+against the bench as it stands at the gate SHA, at a **run id**, with the
+**killing unit named** — anything weaker lets a survivor be argued dead. The
+campaign's own `survived` count keeps what it measured; the two facts are
+recorded side by side and never folded into one. **(b.3) Equivalent mutants.** A
+mutation that no conformant observation can distinguish from the unmutated
+design is an **equivalent mutant** and leaves the denominator — but only where
+the equivalence is **proven in a committed artefact**, the proof quantifying over
+the **specification's legal stimulus space** and never over a bench (an argument
+that a bench cannot reach the mutation is a coverage gap, and its disposition is
+(b.2)'s), and only once the **seeder records the exclusion in the seeder's own
+committed artefact**. §10's three-class floor is measured on the seeded set
+**before** any such exclusion. **(b.4) Unreachable assertions.** A landed
+assertion that no seeded mutation can reach discharges its requirement row like
+any other assertion and contributes **nothing** to a mutation-coverage claim:
+counting it counts one observation twice. The gate record carries the
+**unreachable set beside the tally**, so that no `N/N` figure is read as
+coverage. *Enforcement*: review-enforced, like §10 — no `R`-rule is minted and
+no script changes, so §11(3) owes no test case.
 
 **Lessons harvest** (ADR-0018). Every module sign-off (`SO-`) and every phase
```

---

## 4. The `PROTOCOL` §10 diff — source text; applied by the orchestrator

§3's rule governs this hunk identically. It is the `G1-c` half: the sentence that
demands `N/N` from a reporter whose honest answer has more columns than one.

```diff
   mutated RTL enter history. Sequencing: for each module, the campaign runs
   **after rtl_lead's `RV-` ACCEPT and before dv_lead may issue `SO-` PASS**,
-  so every PASS reports kills N/N (N ≥ 3, spanning distinct defect classes)
-  and `module-ready` merely re-checks it. No RTL-line or worker agent is
+  so every PASS reports **the disposition of every seeded mutation, each
+  non-kill named and dispositioned** — at least three seeded classes, spanning
+  distinct defect classes — and `module-ready` merely re-checks it against §7's
+  **Mutation record**. No RTL-line or worker agent is
   spawned while a manifest is applied; the "report, never repair a suspected
```

### 4.1 The three hunks, machine-checked against the live file

**The transcriber does not re-derive context by eye.** The patch body below is
extracted from *this ADR's own text*, so the check is against the source of
authority and not against a retyped copy. Headers, in order, applied as one
patch (the third hunk's new-file start reflects the 34 lines the second adds):

| hunk | header | subject |
|---|---|---|
| 1 | `@@ -254,3 +254,3 @@` | §7 table row |
| 2 | `@@ -264,5 +264,48 @@` | §7 **Mutation record** paragraph |
| 3 | `@@ -338,5 +381,7 @@` | §10 reporting sentence |

```sh
awk '/^```diff$/{f=1;n++;next} /^```$/{f=0;next} f{print > ("/tmp/h" n ".diff")}' \
  docs/adr/ADR-0020-the-gate-asks-the-suite-not-the-scoreboard.md
{ printf -- '--- a/agents/PROTOCOL.md\n+++ b/agents/PROTOCOL.md\n@@ -254,3 +254,3 @@\n'
  cat /tmp/h1.diff; printf -- '@@ -264,5 +264,48 @@\n'
  cat /tmp/h2.diff; printf -- '@@ -338,5 +381,7 @@\n'
  cat /tmp/h3.diff; } | git apply --check -v -
# Checking patch agents/PROTOCOL.md...            (exit 0, no offsets)
#  agents/PROTOCOL.md | 51 +++++++++---   1 file changed, 48 insertions(+), 3 deletions(-)
```

Verified at `de3c560` and re-verified at `68ccb6e` after a sibling commit moved
HEAD mid-round (`agents/PROTOCOL.md` byte-identical across the move). **If the check does
not reproduce at the acceptance SHA, the constitution moved underneath this ADR
and the hunks are re-derived before they are applied — not forced.**

**What moves and what does not.** The **N ≥ 3 floor survives verbatim in
substance** and is now explicitly a floor on *seeded* classes, so that (b.3)'s
exclusion cannot shrink a campaign below its own minimum after the fact — a hole
that exists in the current text the moment an equivalent-mutant clause is added,
and which is closed in the same breath that opens it. *"Spanning distinct defect
classes"* is unchanged. The transient model, the sequencing, the
no-worker-while-applied rule and the report-never-repair safety net are
untouched.

---

## 5. `G-9` — the auditor's reading ADOPTED, with one adaptation

**The question**, from `docs/gates/P1-module-ready-checklist.md` §9: five landed
green assertions are unreachable by any mutation (`U-1` … `U-5`, `DECLARATION
WO-0074-D1`), and *"a coverage claim counting such an assertion has counted one
observation twice."* Whatever `G-1`'s amendment says about the denominator, it
must state whether such an assertion counts toward a coverage claim.

**The auditor's offered reading**, quoted rather than paraphrased because it is
the thing being adopted:

> *"My reading, offered and not imposed: it does not, and the gate record should
> carry the unreachable set beside the tally so that no N/N figure is ever read
> as coverage."*

**ADOPTED. One adaptation, and it is not cosmetic.** Read flat, *"it does not
count"* is ambiguous between two claims: (i) such an assertion contributes
nothing to a **mutation-coverage** claim, and (ii) such an assertion is worth
less as **verification**. The record means (i) — dv's own sentence is about a
*coverage claim* counting *one observation twice* — and (ii) is false. `U-1` …
`U-5` are landed, green, and discharge their requirement rows exactly as any
other assertion does; what they cannot do is serve as evidence that the suite
would have caught a defect, because no defect was ever put in front of them.
**(b.4) therefore says both halves in one sentence**, and it says the discharge
half first, because an amendment that demotes five green assertions by accident
would be a worse defect than the one it repairs.

**Why this is a real constraint and not a nicety.** It bites in the direction
that costs something: it forbids the most natural sentence a passing packet
wants to write. A module with 62 seeded mutations, 61 killed, and five
unreachable assertions may not report a coverage figure that includes those five,
and may not report `N/N` without the unreachable set printed beside it.

**One boundary this clause does not cross.** Unreachability has more than one
cause and the clause deliberately does not distinguish them, because the
consequence is identical: `M03-B3` and `M03-N2`'s six sub-cases are green *by
structural unreachability* (`DECLARATION WO-0074-D1` — a property of the design),
while `M03-J4` is `UNQUALIFIABLE BY SPECIFICATION` because §6.3 item 7 and
`C-14.5` leave its case unconstrained, *"so every rendering is an equivalent
mutant by specification."* **`M03-J4` is the one place where (b.3) and (b.4) meet
— the same fact read from two ends**: from the mutation's end nothing
distinguishes mutant from original, from the assertion's end no mutation can
reach the row. Such a case is dispositioned **in both registers** and counted in
neither. They are not the same clause in general — `D-M3` is an equivalent mutant
with no unreachable assertion beside it, and `M03-B3` is structurally unreachable
with no equivalence claim anywhere near it — and merging them would be a false
economy.

---

## 6. `G1-d` — the equivalent-mutant clause, and the one exclusion already in the record

### 6.1 Why the clause needs a proof standard rather than a definition

Every mutation-testing practice has equivalent mutants and every one of them has
the same failure mode: *"equivalent mutant"* is the sentence a party writes when
its suite did not kill something and it would rather not say so. The definition
is not the hard part — a mutation no conformant observation can distinguish from
the original is equivalent, and that is uncontroversial. The hard part is that
the definition is **unfalsifiable from the losing side**: a bench that fails to
kill a mutant produces exactly the same evidence whether the mutant is equivalent
or the bench is blind.

So the clause is written as a **proof standard**, and its middle limb is the one
that does the work:

1. **Proven in a committed artefact.** Not in a verdict sentence, not in a
   journal narrative, not in chat. This is the auditor's own requirement and it
   named the standard by pointing at its own `IC-M5` §3.5 declaration — which is
   also why `IC-M5` could be *dissolved* at `G-1` rather than argued.
2. **Quantified over the specification's legal stimulus space, never over a
   bench.** This is the limb that separates an equivalent mutant from a coverage
   gap, and the record contains one clean instance of each: `D-M3`'s proof
   quantifies over *"every legal combination"* down to the DIC floor, while
   `G-c4` was argued at the bench and turned out to be a real gap in the seeder's
   own attack-plan text. **An argument that a bench cannot reach the mutation is
   a coverage gap and its disposition is (b.2)'s**, which is the expensive one.
3. **Recorded by the seeder in the seeder's own committed artefact.** An
   exclusion shrinks the seeder's own measured yield, so the seeder recording it
   is an admission against interest; and it puts the exclusion in the artefact
   the gate reads (`docs/reports/audit/**`) rather than in the packet of a party
   the clause grades.

### 6.2 `D-M3` measured against the standard it is about to be governed by

The one exclusion in the record, and the clause is worth nothing if it cannot be
run against it. `WO-0041`'s `D-M3` — *read the CRC register at the `tlast` cycle
instead of carrying the verdict*.

**Limb 1 — committed artefact: MET.** `agents/handoffs/WO-0041_family-d-mutation-campaign.md`
§3, committed, titled **"EQUIVALENT MUTANT. Proven, not conceded"**, opening
*"an equivalence claim is a proof obligation rather than a conclusion, so here is
the proof."*

**Limb 2 — quantified over the legal stimulus space: MET, and it is a model of
the limb.** The proof computes the margin `next_frame_start_cycle − tlast_cycle`
over *"**every legal combination** of terminate lane (0–7), start lane (0 and 4),
frame length and inter-frame gap down to §0.3's DIC floor of 9 octets — not
merely the nominal 12 this bench drives"*, and finds the margin never negative,
tightest value exactly 0. Its conclusion states the quantifier explicitly:
*"behaviourally indistinguishable from the correct design **across the whole legal
stimulus space**, not merely across what family D drives."*

**Limb 3 — recorded by the seeder: NOT MET, measured.**
`docs/reports/audit/WO-0041-mutations/README.md` — the seeder's own artefact —
describes `D-M3`'s intent, mechanism and fidelity at §3.3 and **contains no
occurrence of the word *equivalent* anywhere in the file**. The exclusion was
authored and recorded by the graded party, in the campaign packet, and the
seeder's report was never updated to carry it.

### 6.3 The clause is prospective, and `D-M3` is disposed rather than convicted

**(b.3) binds from the acceptance act forward.** Retroactive application would
convict a piece of practice that is substantively sound — a genuine
whole-stimulus-space proof, published under the honest heading *"proven, not
conceded"*, by a party whose own sealed prediction it falsified in the same
breath — and would do it on a limb that did not exist when the act was performed.
That is the `A2.1` error running backwards.

**`D-M3`'s disposition, stated so it can never be mistaken for a wave-through**:
limbs 1 and 2 are met at the level the clause demands; limb 3 is unmet in the
record; the exclusion **stands**; and the missing act is named as an owed item
(§10 item 4) — one paragraph in the auditor's `WO-0041` report recording the
exclusion it already knows about. **The grandfathered set has exactly one member
and is closed**: no later exclusion may cite `D-M3` as precedent for skipping
limb 3, because `D-M3` does not satisfy limb 3 and is recorded here as not
satisfying it.

### 6.4 The second exclusion — dv_lead's `FINDING REC-3`, SUSTAINED, and its clause adapted

**This is a (b.1) act filed inside §6 deliberately**, because §6 is where
denominator exclusions live and this is the second one. It arrived mid-round, by
orchestrator relay, from dv_lead's reconciliation round (`J-dv_lead-0184`), and
it is **a finding against the clause this ADR was drafting** — the auditor's
`G1-a`, and my first draft of (b.1) with it.

**The finding, relayed**: the column labelled `sealed` **excludes a seeded class
and includes an unseeded one**, on two grounds never stated together. Its
consequence for this draft is stated as sharply as I could have wished against
me: *"the auditor's `G1-a` is correct and INSUFFICIENT — under a literal reading
of 'seeded', `I-c1` is a seeded mutation in no column at all, and 62 = 61 + 1
holds only because it was removed from numerator and denominator together on a
ground that appears in `WO-0061` and in no normative instrument."*

**SUSTAINED, verified at the committed record rather than adopted from the
relay.** Three checks, all of which reproduce:

1. **`I-c1` was declared SEEDED by the seeder, in the manifest, before the seal
   branched.** `docs/reports/audit/WO-0061-mutations/DISP-0001_A-1.md`: *"The
   class is **SEEDED**; the one-octet-per-cycle rendering §3 pre-authorises as an
   escape was **not** taken and was not needed."* A branch was cut and it ran —
   five I units green, `T-F1`, `T-F2`, `T-G7` red.
2. **It was then voided under a different word with a different consequence.**
   `agents/handoffs/WO-0061_family-i-mutation-campaign.md` line 738:
   **`VOID` — `NOT SEEDED AS SPECIFIED — scope report, 0 kills`**; and
   `DISP-0001_A-1.md` §5: *"`I-c1` is void: a scope report, zero kills, no claim
   about any row … it does not alter the campaign's headline numbers (verdict
   §11): **9 of 9 scoreable classes killed, `I-c1` excluded**."*
3. **`IC-M5`, which was never rendered at all, sits inside the `sealed` column**,
   and `WO-0074` §12 calls it *"the era's first VOID class"* — nine days after
   `I-c1` was voided under a different word.

**So `sealed` is not the set of sealed classes**, and the finding is exactly
right. It also lands on the same fault line as `G1-d`: **the word "scoreable" is
already the campaign verdict's own denominator** (*"9 of 9 scoreable classes"*),
so this is a second instance of the family `G1-d` named — sound practice,
unauthorised protocol — and it would have been codified *wrong* by this ADR had
it not been filed. I record that plainly: my first (b.1) said *"the gate record
states sealed and seeded as separate numbers"* and would have frozen a `sealed`
column that omits a class the seeder itself declared seeded.

**The relay checked against its source.** `J-dv_lead-0184` was uncommitted when
the finding reached me, so the three checks above were made at the artefacts it
cites and not at it. It landed mid-round at `68ccb6e`, and the relay was then
compared to dv's own committed words: **faithful, with one word dropped** — dv
wrote *"dispositioned **as** UNSCOREABLE"* and the relay wrote *"dispositioned
UNSCOREABLE"*. Nothing turns on it and the clause below is quoted from the
source, not from the relay, because a constitutional instrument quoting a MAJOR
finding's offered text should quote the text.

**dv's offered third clause, from `J-dv_lead-0184` Open-question 1, verbatim:**

> *"a seeded mutation whose seeding is found not to render the sealed class is
> dispositioned as UNSCOREABLE, counted in neither numerator nor denominator, and
> named at the tally with its ground."*

**And the finding's own ground for unscoreability, which the offered clause does
not carry**: *"the seeder's disclosure was falsified, so the class is
unscoreable."* That is the sentence that makes the disposition principled rather
than convenient, and §12.5 builds its second guard on it.

**ADOPTED in its disposition and in its word; ADAPTED in its subject and its
site. Three changes, each with its ground.**

**(i) Not "neither numerator nor denominator" — `sealed` yes, `seeded` no.** The
clause as offered leaves `I-c1` in **no column**, which is the very state the
finding convicts. **The finding's diagnosis and the finding's proposed clause
point in slightly different directions, and this ADR follows the diagnosis**: the
diagnosis is that `I-c1` was *"removed from the sealed denominator entirely,
appearing in none of the five columns"* and that *"a reader of '63 sealed' cannot
recover either treatment"* — a complaint that the record is **unrecoverable**,
whose repair is to make it recoverable. A clause counting the class in neither
column leaves it exactly as unrecoverable as before, under a better name. The two objects here are a class that *was* sealed and a
rendering that did not render it; the sealed fact is true and permanent and the
column that records sealing must record it. Excluding it from `seeded` is the
whole of the exclusion, and it is enough. **Under the adapted clause the two
grounds cannot be stated apart, because they are the same subtraction** — the
difference `sealed − seeded`, itemised — which is precisely what the finding says
was missing.

**(ii) It lands inside (b.1) rather than as a standalone third clause.** A
separate clause for an identical disposition (in `sealed`, not in `seeded`, named
with its ground) invites the defect to recur in a new form: two clauses, two
vocabularies, two dispositions that drift. The grounds differ; the disposition
does not; so the grounds are listed under one disposition.

**(iii) It gains the scope-report sentence, from the record's own words.** An
unscoreable seeding *ran*, and its reds and greens exist. `WO-0061`'s own
disposition says what they are worth — *"a scope report, not a bench result — and
no claim about any row in either direction"* — and without that sentence a later
party could harvest a red from an unscoreable seeding as evidence. The deep
reason is the blinding discipline: the seal branched on a disclosure that turned
out to be false, so the property that makes a mutation result scoreable did not
hold for what actually ran.

**And one sentence adopted from the same round, on its own ground**: *the unit is
the class, not the branch.* dv's argument — a ref population is monotone by
infrastructure accident (branches accumulate, get re-cut, and carry negative
controls such as `IC-2`) and cannot be a denominator — is right, and it
**disposes of the auditor's Open-question 4** by explaining rather than
reconciling: 64 refs against a 63-row tally was never an arithmetic discrepancy,
it was two different kinds of object being counted. The relay reports the surplus
fully reconciled — `I-c1`'s void plus `IC-2`'s negative control — with both of
the auditor's hypotheses refuted by measurement.

**What this ADR does NOT do with the finding: it states no corrected figure.**
The repaired columns imply that `sealed` gains at least `I-c1`, and the relay's
reconciliation implies the seeded set is unchanged at 62 = 61 + 1. **I assert
neither.** The score is dv_lead's, the reconciliation is dv_lead's, and I have
not re-walked ten campaign packets. This clause says what the columns *are*; the
numbers that go in them are the score-owner's and land at the gate record.

---

## 7. dv_lead's offered post-freeze countersignature rule — ADOPTED, adapted, and homed

### 7.1 The offer, quoted

`J-dv_lead-0183` §4, routed here for codification at `J-orchestrator-0260`:

> **A post-freeze §7 diff owes dv_lead no countersignature when every figure it
> lands is the signer's own derivation or another specification's countersigned
> figure relayed unchanged — that is `Q-5`'s precedent and it is right. It owes one
> when the diff lands a clause that constrains a party other than its author: a
> prohibition, a licence, or a scope on what a bench may assert. The value of the
> countersignature there is not arithmetic, which the filing already did, but
> whether the guard is *exactly* the rule rather than wider than it — and that is a
> question only the constrained party can answer.**

### 7.2 ADOPTED, on the ground rather than on the offer

The rule is better than the precedent it refines, and the reason is in its last
clause. `Q-5`'s test asks **where a figure came from**; this one asks **whom the
clause binds**. The first is a provenance test that a diff can satisfy while
landing a prohibition nobody checked; the second is a test on the class of the
sentence. And the value it identifies is the right one: a countersignature on the
author's own arithmetic returned to the author verifies nothing the filing did
not already verify, and *"manufacturing one would make the signature a formality —
which is the thing that destroys it as an instrument."*

**The program has a conviction on record for the exact failure the rule guards.**
`J-dv_lead-0176`'s `W = 2` conversion rule was convicted for being **wider than
the rule it guarded**. A guard's width is not checkable by its author, who wrote
the width he meant; it is checkable by the party who has to live inside it. That
is an argument from a measured incident, not from symmetry, and it is why the
rule is worth minting rather than waving at.

### 7.3 One adaptation: the signer is the constrained party, not dv_lead

**Stated as offered, the rule banks a general ground and keeps a narrow
instance.** Its justification is *"a question only the constrained party can
answer"* — which quantifies over constrained parties — while its operative text
names `dv_lead`. A clause landing in a spec that constrains the RTL line (*"no
implementation may …"*) owes rtl_lead's countersignature by the identical
argument, and a rule whose own ground refutes its own scope is the defect this
chain sustained at `FINDING Q-4` one round ago: *the diff convicts its own ground
in its own words.* Adopting the narrow form here would repeat it at the moment of
codification.

**So the operative text reads *the constrained party*, with dv_lead as its
commonest instance rather than its definition.** Three bounds come with it:

1. **A clause that constrains only its own author owes nothing.** That is dv's
   own first limb, generalised: your own derivation returned to you verifies
   nothing.
2. **This rule does not touch the `P<n>-spec-freeze` countersignature.**
   `PROTOCOL` §7 requires dv_lead's testability countersignature at freeze; that
   is a gate signature over a whole specification and it is **unmoved, unqualified
   and unreduced** by anything here. This rule governs which *post-freeze diffs*
   owe traffic. A rule that quietly shrank a gate signature would be `A2.1` in a
   third place, and it is refused explicitly so that no later reader can find the
   reduction by implication.
3. **It reduces no obligation that a finding created.** A diff answering a
   finding owes whatever the finding's own contest window owes, independently of
   this rule.

### 7.4 Where it lives: `SPEC-TEMPLATE` §13, not `PROTOCOL`, not this ADR alone

Three candidate homes were considered and two are refused with grounds.

**Refused — `PROTOCOL`.** Its subject is post-freeze spec-diff traffic, which is
spec process, not constitution. `PROTOCOL` §7 names exactly one countersignature
and putting a second, differently-shaped one beside it invites the reading that
the first is qualified by the second (§7.3 bound 2 exists precisely because that
reading is available). It would also make every later refinement of a
spec-process rule a §11 act with a full amendment round behind it — a cost with
no matching benefit, since no `R`-rule and no script reads this.

**Refused — this ADR alone.** An ADR records *why*; it is not where the next
author meets a rule. ADR-0018 §9 made this argument for the harvest block landing
as its own file and it holds identically: a rule readable only by someone who
already knows to look for it will be followed by its author and by nobody else.

**Adopted — `docs/specs/SPEC-TEMPLATE.md` §13**, the post-freeze change log. It
is the section every post-freeze diff already touches; it already carries the
adjacent rule (*"Each row cites the ADR that authorised it"*); and a rule about
whether a row owes a countersignature belongs beside the row that would carry the
signature. `docs/specs/requirements.md` §13 — which is not a module spec and says
so — gains a one-line pointer, because its own preamble already establishes that
it is *"the requirements-side counterpart of a spec diff"* and a rule that binds
one and not the other would be discovered the hard way.

**Source text**, to land in `SPEC-TEMPLATE` §13 at the act named in §10 item 3:

> **Countersignature on a post-freeze diff** (ADR-0020 §7). A post-freeze diff
> owes **no** countersignature when every figure it lands is the signer's own
> derivation, or another specification's already-countersigned figure relayed
> unchanged. It **owes one from the constrained party** when it lands a clause
> that constrains a party other than its author — a prohibition, a licence, or a
> scope on what another line may build or assert. The countersignature's value
> there is not arithmetic, which the filing already did, but whether the guard is
> *exactly* the rule rather than wider than it, which only the constrained party
> can answer. A clause constraining only its own author owes nothing. **This rule
> does not touch the `P<n>-spec-freeze` testability countersignature**
> (`PROTOCOL` §7), which is unmoved.

### 7.5 The rule applied to itself, which is how its route is derived

**The dv-limb** — *no countersignature for own-derivation figures* — was authored
and offered by dv_lead, the party whose signature it waives. The waiver is the
signer's own, which is the correct authority for a waiver, and this seat's
adoption is the counterpart signature from the party it binds (me: it tells me
when I must seek one). Nothing further is owed on that limb.

**The generalised limb** — *the constrained party signs* — lands a clause that
constrains a party other than its author. Its author is this seat; it newly makes
**rtl_lead** a possible signer. **By the rule's own test it therefore owes
rtl_lead a countersignature**, and this ADR does not pretend otherwise: §9.2
routes it. The rule generating its own route is not a rhetorical flourish; it is
the first check that the rule is operable, and it passes.

---

## 8. Ledger item 70, RULED — the test is which authority moves, not how big the change is

**The question**, carried on this seat's ledger since `J-architect_docs_lead-0043`
and re-carried at `-0044`:

> **Whether a requirements-level rule change of this size owes an ADR.** … No ADR
> is written, on the parent's precedent: the `C-RL-8` term-versus-scope ruling
> recorded its refused alternative in §13 rather than in `docs/adr/` … **A
> precedent is not an argument.** The next rule change of this size should either
> follow it knowingly or break it with an ADR, and this row exists so that choice
> is made rather than inherited.

**Ruled, in three parts.**

**(1) For this round the question does not arise, and saying so is not evasion.**
`PROTOCOL` §11(1) requires *a numbered ADR in `docs/adr/`* for **any** change to
the protocol, a charter, or the enforcement scripts. No judgement is available:
this round owes an ADR by the constitution's own words, which is why this file
exists. Item 70's live subject is the **requirements-level** change, where §11
does not reach.

**(2) Size was always the wrong test, and the row's own wording shows it.** *"A
change of this size"* has no measurable referent — a one-word diff to §0.5's
default retired a rule that convicted three conformant wrappers, while a
forty-row table edit can be pure transcription. The record already carries a
better test at `requirements.md` §13's preamble: a row is **editorial** (no
conformant design and no existing test changes meaning) or **behavioural**, and
*"a behavioural row additionally names its ADR."*

**(3) The gap that test leaves, and the ruling that closes it.** The
editorial/behavioural split classifies changes to *requirements*. It does not
classify a change to a **reading rule** — §0.5's default, the identity, `q`'s
subject, the ΔC-additivity carry — because such a change alters no requirement's
content while altering what every figure derived under it *means*. Every one of
those changes was recorded as editorial-in-effect with an explicit *no ADR*
ground, and each time the ground was the same precedent rather than an argument.

> **RULING (item 70, CLOSED).** An ADR is owed when a change moves a **reading
> rule** — what a figure, a signature, or a piece of evidence *means*, or what a
> silence assigns. It is not owed for a figure, a scope, or a cure applied inside
> a rule already ruled, which the revision record carries. The test is **which
> authority moves**, not how many bytes move: a change that makes a previously
> conformant artefact non-conformant without any artefact changing has moved a
> reading rule, whatever its size.

**Applied backwards as a check, because a rule that convicts nothing is not a
rule.** Under it, `§0.5`'s halved default **owed an ADR and did not take one** —
it changed what silence assigns, which is a reading rule by the test's own words,
and its consequence table is the proof (three wrapper port pairs answer 2 where
silence previously answered 0). That is recorded here as a **finding against this
seat's own prior round**, not repaired retroactively: the change is countersigned,
in force, and correct on its merits, and rewriting a frozen revision record to
manufacture an ADR reference would be worse than the gap. **Item 70 closes as
ruled, with one conviction, and this seat's next reading-rule change takes an
ADR.**

---

## 9. The §11 route, the countersignature traffic, and the contest windows

### 9.1 Why this commit contains no `agents/PROTOCOL.md`

The dispatch commissioning this round listed `agents/PROTOCOL.md` among the
writes allowed. **It is declined, and the decline is recorded rather than
silently performed**, because a permission granted in a dispatch and a write
scope are different objects and only one of them is the constitution.

1. **`PROTOCOL` §6's table gives `agents/PROTOCOL.md` to the orchestrator**, and
   §6 changes by §11 like everything else — not by a dispatch, and not by this
   seat accepting one.
2. **The enforcement script refuses it mechanically**, so the write is not merely
   improper but uncommittable under this seat's identity:

   ```sh
   $ source scripts/policy.sh; agent_may_write architect_docs_lead agents/PROTOCOL.md
   REFUSED (exit 1)
   ```

   `R7` would fail the commit; `R2` couples the work to *this* seat's journal, so
   there is no trailer under which the pair could land.
3. **ADR-0016 §8 settled the general point** and ADR-0018 §8 / §A1.6 and ADR-0019
   are the three precedents where this seat authored constitutional text that
   another seat applied. Making an exception here — for an amendment about
   evidence standards, of all subjects — would be the most quotable possible
   contradiction.

The cost is real and is the one ADR-0016 §8 chose knowingly: the rule and its
argument land in this commit, the constitution's bytes in the orchestrator's next
one, and the pair must be read together in `git show`. It is still worth paying.

### 9.2 The route, act by act

| # | act | seat | effect |
|---|---|---|---|
| 1 | this file lands | architect_docs_lead | §11(1) satisfied. **Nothing is in force** (§0) |
| 2 | **countersignature — auditor**, on (b.2) and (b.3) | auditor | these two clauses bind the auditor's own future acts: the survivor evidence form, and the seeder-records limb of the equivalence standard. The constrained party checks the guard is *exactly* the rule (§7's own test, applied) |
| 3 | **countersignature — dv_lead**, on **(b.1)**, (b.2), (b.4) and §4 | dv_lead | these bind what a `SO-` must report and what a coverage claim may count. dv's practice already exceeds the written rule, so what is asked is whether the codification is exactly the practice, not wider. **(b.1) is on the list because dv's own `FINDING REC-3` shaped it and this ADR adapted the offered clause in three respects** (§6.4) — the adaptation is exactly the seat that filed it to check |
| 4 | **countersignature — rtl_lead**, on §7.3's generalised limb only | rtl_lead | that limb newly makes rtl_lead a possible signer of post-freeze spec diffs. Owed by the rule's own test (§7.5) |
| 5 | **acceptance** — orchestrator journal entry | orchestrator | §11(2). This is the act that flips §3–§6 from PROPOSED to in force |
| 6 | the §3/§4 hunks applied to `agents/PROTOCOL.md` | orchestrator | the constitution's text moves, clerically, citing §3/§4 |
| 7 | the §7.4 text applied to `SPEC-TEMPLATE` §13 + the `requirements.md` §13 pointer | architect_docs_lead | after act 4. **Separable from acts 5–6** |
| 8 | the gate-record form touches (§10 items 1–2) | architect_docs_lead | after acts 5–6, never before |

**Acts 2, 3 and 4 do not gate act 5 in one direction only.** A countersignature
that arrives as a **refusal or a narrowing** is a contest and is dealt with under
§9.3; a countersignature that has not yet arrived leaves the orchestrator free to
accept §3–§6 with the traffic stated as owed, exactly as `FINDING Q-3`'s repair
was accepted in force with dv's countersignature outstanding. **What the
orchestrator may not do is record the traffic as paid before it is.**

**§11(3) owes nothing, and the reason is measured, not asserted.** No `R`-rule is
minted; no script changes; nothing here is read by `agent_commit.sh`,
`check_journals.sh` or `policy.sh`, which key on `R1`–`R10` and on write scopes
and never on a gate's content. The posture is review-enforced, like the whole of
§10 and like ADR-0018 §7.4 — and the same asymmetry ADR-0017 §1.2 convicts is
avoided by having *no* mechanical surface at all rather than one.

### 9.3 Contest windows

**Before acceptance** the window is open by right and the instrument is the
countersignature: any of acts 2–4 may refuse a clause, narrow it, or file a
finding against it, and the refusal lands in that seat's own committed artefact.
A refusal received before act 5 **blocks the clause it names** and returns it to
this seat for a redraft. The window on each clause closes when its named
countersigner has answered or when act 5 lands with the traffic recorded as owed,
whichever is first.

**After acceptance** a contest routes as a finding in the contesting seat's own
committed artefact, carried to an **Amendment A1 to this ADR**, drafted by this
seat under §11. **A contest does not suspend an accepted clause.** A gate clause
any graded party can suspend by objecting is not a gate clause, and this is stated
in advance so a contesting seat knows it argues against a live rule rather than
against a proposal — A2.0's rule, adopted here for the identical reason.

**One asymmetry, deliberate.** (b.2)'s evidence form and (b.4)'s coverage bar
raise the bar; (b.1) and (b.3) can *relieve* a record. A contest against a
relieving clause is therefore heard against a live rule that may already have let
a gate pass, and against that risk the answer is §9.4: this ADR passes no gate.

### 9.4 What acceptance does not do

**Acceptance does not close `G-1`, and does not pass anything.** It supplies the
reading `G-1` asked for. Whether M03's record satisfies the *read* clause is a
gate act, performed by the orchestrator against the record, in the checklist,
under the signature discipline §7 already states. This file performs no such act
and states no verdict on M03's record. `G-9` likewise closes only when the gate
record carries the unreachable set beside its tally — a form act, not a reading.

**And the flip is named rather than skated over, because it is real.** Under the
clause as written the record fails clause (b) (61 killed of 62 seeded); under the
amended clause the record can satisfy it. **An amendment that converts a failing
token to a passing one is the definition of a self-serving amendment**, so here
are the four things that distinguish this one, offered as checks a later reader
can run rather than as assurances:

1. **It was adjudicated by the seat that owns neither the score nor the gate**,
   which cannot repair what it finds (auditor charter), reached at the sources,
   and specified before this seat wrote a line.
2. **Its load-bearing evidence was verified by two seats, neither of which owns
   the score**: the diff identity by the auditor at byte level, CI run
   `30852220315` by the orchestrator. dv_lead — whose suite is the graded party —
   supplied neither verification.
3. **Three of the four limbs raise the bar and one narrows it.** (b.2) adds an
   evidence requirement that does not exist in `PROTOCOL` today; (b.3) adds a
   proof standard to a practice currently performed with none; (b.4) subtracts
   from what a coverage claim may count. Only (b.1) narrows, and it narrows to
   the word the clause already contains.
4. **It flips no other token.** The one other thing it reaches — `D-M3`'s
   exclusion — it finds **short of the new standard** on limb 3 and says so
   (§6.2), rather than blessing it. An amendment that relieved everything it
   touched would be the one to distrust.

---

## 10. Owed acts — the file touches this ADR does not make

Named with the act that triggers each, so that a debt cannot be discharged
silently or forgotten. **None is performed in this commit** (D8).

1. **`docs/gates/P1-module-ready-checklist.md` §0.1** — its verbatim quotation of
   §7's `P<n>-module-ready` cell goes stale the moment §3 hunk 1 is applied.
   *Trigger*: acts 5–6. *Owner*: architect_docs_lead. **Not done now**, because a
   checklist quoting a constitutional cell that does not yet say that is the
   `A2.1` defect precisely.
2. **`docs/gates/P1-module-ready-checklist.md` §3.1 and §9** — the gate record's
   form gains (b.1)'s explicit `seeded` number beside `sealed` (today it is
   derivable, not stated) and (b.4)'s unreachable set beside the tally; `G-1`'s
   and `G-9`'s rows gain their closing events. *Trigger*: acts 5–6. **This is the
   only template touch the amendment's gate-record form requires, and it is
   named rather than taken**: §0.2 of that file forbids it from carrying a
   condition its cited source does not contain, and until act 6 the source does
   not contain it.
3. **`docs/specs/SPEC-TEMPLATE.md` §13 + `docs/specs/requirements.md` §13
   preamble pointer** — §7.4's source text. *Trigger*: act 4 (rtl_lead's
   countersignature on the generalised limb). *Owner*: architect_docs_lead.
4. **`docs/reports/audit/WO-0041-mutations/README.md`** — one paragraph recording
   the `D-M3` equivalence exclusion in the seeder's own artefact, closing §6.2's
   limb 3. *Owner*: **auditor** (that path is its exclusive scope and nobody
   else's). *Trigger*: its next round; not a precondition of anything here.
5. **`tasks/BOARD.md`** — the `G-1`/`G-9` rows and the amendment's route.
   *Owner*: orchestrator, in its own flip.

---

## 11. Alternatives considered

1. **Read clause (b) charitably and pass the gate.** Rejected at §1.2: the
   reading is right, and it is not available without moving the clause, because a
   frozen campaign score and a present suite capability are different objects.
   `G-1`'s own row already forecloses it — *"by amendment, not by reading"*.
2. **Settle it in the gate checklist.** Rejected: `A2.1` is this program's
   conviction for exactly that move, and `docs/gates/P1-module-ready-checklist.md`
   §0.2 was written by this seat to forbid it.
3. **Amend only §10, leaving §7's cell alone.** Rejected: it would leave the
   constitution saying *all killed* in one section and *dispositioned* in
   another, which is the rule/check disagreement ADR-0017 §1.2 convicts.
4. **Amend only §7's cell, without the paragraph.** Rejected: a table cell cannot
   carry an evidence form, a proof standard and a coverage bar without becoming
   unreadable, and §7's existing structure (cell + `Signature transcription` +
   `Phase hardening` + `Lessons harvest`) already puts the operative detail in
   paragraphs.
5. **Write the equivalent-mutant clause as a definition without a proof
   standard.** Rejected at §6.1: the definition is not the hard part and an
   unfalsifiable exclusion is worse than none.
6. **Require an equivalence exclusion to be countersigned by a seat that does not
   own the score.** Considered and rejected as scope beyond the commissioned
   specification: limb 3 (the seeder records it) already carries the independence
   property, since the seeder is not the graded party and the exclusion is an
   admission against its own yield. Recorded so a later round can mint it if
   limb 3 proves insufficient.
7. **Codify dv's countersignature rule in `PROTOCOL`.** Rejected at §7.4.
8. **Adopt dv's rule verbatim, naming dv_lead.** Rejected at §7.3: its own ground
   quantifies over constrained parties and its text did not.
9. **Write the `PROTOCOL` bytes in this commit, on the dispatch's authority.**
   Rejected at §9.1, mechanically as well as constitutionally.
10. **`REC-3`'s clause adopted verbatim** — *counted in neither numerator nor
    denominator*. Rejected at §6.4(i): it leaves the class in no column, which is
    the state the finding itself convicts.
11. **A standalone third clause for the unscoreable seeding.** Rejected at
    §6.4(ii): one disposition with two grounds, stated once, is what makes the
    finding's *"two grounds never stated together"* structurally impossible.
12. **Publishing the corrected `sealed`/`seeded` figures in this ADR.** Rejected:
    the score is dv_lead's and this seat has not re-walked the campaigns. A rule
    author who also publishes the numbers the rule produces has graded his own
    instrument.
13. **Defer item 70 one more round.** Rejected: it has been carried twice, this
    round is a change that *does* owe an ADR by §11(1), and a row that exists so
    a choice *"is made rather than inherited"* is discredited by a third
    inheritance.

---

## 12. Failure modes this amendment creates or leaves open

### 12.1 The survivor-replay theatre

(b.2)'s evidence form is a run id and a named unit, and a party under pressure can
produce both from a bench built to kill exactly one diff and nothing near it. The
form is a floor, not a virtue: it makes a survivor's rehabilitation *checkable*,
not *good*. It is `R-SEAL-1`'s own honest bound in a new place — *"the rule makes
seals countable, not good"* — and the catch is the same one: at adjudication,
where a repair that kills only its own diff is visible as such.

### 12.2 Freezing a reporting schema into the constitution

(b.2) deliberately requires **dispositions**, not dv's five columns. Writing
*sealed / killed / survived / green-by-blindness / void* into `PROTOCOL` would
make every improvement to the reporting form a §11 amendment, and dv's fifth
column exists because a fourth was found insufficient one campaign earlier. The
constitution says what must be answerable; the packet chooses how to answer it.
**The cost is that a packet can satisfy (b.2) with a worse schema than dv's
current one**, and the compensating control is review, not text.

### 12.3 The equivalence escape hatch

(b.3) is the clause most likely to be misused, because it is the only one that
*removes* something from a denominator. Three guards: the stimulus-space
quantifier (which converts most misuse attempts into coverage gaps by their own
wording), the seeder's record (which puts the act in the artefact of a party
whose yield it shrinks), and §10's floor being measured **before** exclusions
(which stops a campaign from being shrunk below its own minimum after the fact).
If it is misused anyway, the evidence will be an equivalence proof that quantifies
over a bench, and that is a one-line audit check.

### 12.4 The unreachable set grows to swallow the tally

(b.4) creates an incentive that did not exist: an assertion declared unreachable
is exempt from the coverage claim. A module could accumulate unreachable
assertions and report a small clean tally beside a large exemption list. The
clause's answer is that the exemption list is **printed beside the tally**, so the
ratio between them is visible to the reader at the moment the tally is read;
`DECLARATION WO-0074-D1`'s register is the existing instance of that discipline
and it is why the clause requires publication rather than merely permitting it.

### 12.5 The unscoreable escape hatch

(b.1)'s `UNSCOREABLE` ground is the second way to leave a denominator, and it is
cheaper than (b.3)'s: *"the seeding did not render the class as sealed"* needs no
whole-stimulus-space proof. A party wanting an inconvenient result to disappear
declares the seeding off-spec and the result becomes a scope report. Two guards,
neither of them decisive alone. **The ground must be named at the tally**, so the
claim is in front of the reader who reads the number rather than in a packet
appendix. And **the evidence is already written before the result is known**: the
disposition turns on the disclosure the seal branched on, which is frozen in the
manifest pre-run — `WO-0061`'s `I-c1` is exactly this shape, and the reason it is
convictable now is that its pre-run disclosure is on the record to be checked
against. **A disposition made where no pre-run disclosure exists to check it
against deserves no confidence**, and this is written down so a later auditor
knows where to look first.

### 12.6 The two-object distinction gets forgotten

The whole amendment rests on *score ≠ suite capability*. The first time someone
"helpfully" updates a campaign's frozen `survived` column to reflect a later
repair, the distinction dies and the record becomes unauditable. (b.2)'s last
sentence — *the campaign's own count keeps what it measured* — is there for that,
and it restates dv's rule rather than inventing one.

---

## 13. What this ADR does not decide

- **Whether M03's record passes clause (b).** §9.4. That is the gate's act.
- **`G-10`** (the external-anchor question) and every other `G-` item except
  `G-1` and `G-9`, which are untouched.
- **The corrected `sealed` and `seeded` figures** that (b.1) implies. §6.4: the
  score is dv_lead's. This file publishes no number.
- **Whether `WO-0061`'s `I-c1` disposition was substantively right.** §6.4 takes
  it as the record states it and rules only on where it belongs in a tally; the
  disposition itself was made in the seeder's own committed artefact and is not
  reopened here.
- **The `WARN-STAMP` recommendation** and everything about timestamps: a separate
  enforcement round with its own ADR, accepted at `J-orchestrator-0259` Act 2
  item 1.
- **Whether `SO-` packets should report five columns**, or any other reporting
  schema. §12.2.
- **Any charter text.** No charter changes; the auditor's charter §3 duty to
  record `N/N` results in the gate checklist is satisfied by (b.2)'s dispositions
  and needs no edit, but if a later reading finds *"N/N"* in that charter text
  now stale against §10, that is an owed charter diff and it is the
  orchestrator's, not this file's.
- **The retroactive status of any campaign score.** All frozen, all unedited.
