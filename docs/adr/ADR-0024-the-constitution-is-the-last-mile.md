# ADR-0024: the constitution is the last mile

- **Status**: **PROPOSED.** Nothing here is self-ratifying. In force per subject
  only on (1) this record, (2) the orchestrator's `PROTOCOL` §11(2) acceptance
  entry, (3) the countersignatures §17 names, and (4) for the subjects that move
  enforcement semantics, the `scripts/test_protocol.sh` cases §19 owes. The
  drafted hunks at §11 and §12 are **written, NOT applied** — `agents/PROTOCOL.md`
  and `agents/charters/**` are the orchestrator's files (`PROTOCOL` §6,
  `scripts/policy.sh`), and `PROCESS` §3.6's rule holds: *the instrument does not
  edit the file it governs.*
- **Deciders**: **orchestrator** (owns `agents/PROTOCOL.md`, `agents/charters/**`
  and the enforcement scripts; sole applier and the §11(2) acceptor);
  **auditor** and **dv_lead** as the constrained and measuring seats per subject
  (§17).
- **Proposed by / drafted by**: `architect_docs_lead`.
- **Work order**: none — dispatch-only round · **Journal**:
  `J-architect_docs_lead-0065`
- **Supersedes nothing. Consolidates**: the amendment batch queued on the board
  since `J-orchestrator-0285` (2026-08-12) and re-stated at `J-orchestrator-0309`
  (2026-08-22), plus the residue the `ADR-0022` verification round routed into it.
- **Affects (proposed, not performed here)**:
  - `agents/PROTOCOL.md` §3, §5 (R1, the CI paragraph, a new R10/R11
    enumeration), §7 (the transcription premise; (b.2)'s singular), §10, §11 —
    eight subjects, hunks at §11.
  - `agents/charters/auditor.md`, `dv_lead.md`, `tb_writer.md`, `formal_dv.md`
    (the ratio); `agents/charters/orchestrator.md`, `rtl_lead.md`,
    `rtl_module_dev.md`, `formal_dv.md`, `auditor.md` (the campaign model) —
    re-quotes drafted at §12, **two of which cannot lawfully be applied until
    subject A8 lands**.
- **Affects (performed in this commit, inside this seat's scope)**:
  `agents/handoffs/README.md`, `docs/PROCESS.md`, `docs/PROCESS-MEMOIR.md`,
  `docs/PROCESS-STE.md` — §13.

---

## 0. How to read this file

It is one record carrying **eight constitutional subjects**, because they were
queued as one batch, they share one owner, and — this is the substantive reason
rather than the clerical one — **they share one failure class.** Every one of
them is a written diff that was correct when written and was never applied, which
is the class `PROCESS` §5.9 names as this program's most-exercised defect and
which this record is itself the largest single instance of. Splitting them into
eight records would have produced eight rows in the same aging inventory.

Read §2 first: it is the re-measurement, and it is the part that could have made
this record unnecessary. Three of the batch's items were **paid in part** by the
sixth-to-eighth editions and are marked so; none was paid at the authoritative
site, which is the finding.

---

## 1. Context — a batch, re-measured before it was executed

### 1.1 What was queued, and when

The board row at `J-orchestrator-0285` (2026-08-12) reads, verbatim in its queue
clause:

> the architect amendment batch (§11 round: C-40, C-93, F-0022-2, ADR21-1 with
> ADR-0021 §8's cured draft, PROCESS B.2 items 7/10-16, round-5 charter
> re-quotes, the memoir filing fix)

and the same row routes one residue into it:

> One residue routed to the amendment batch: a fifth-edition margin mis-filed in
> the companion's B.1 (in the volume, nothing lost).

Ten days passed. In them `docs/PROCESS.md` moved from its **fifth** edition to
its **eighth**, acquired a companion volume and a derived rendition, and absorbed
a currency-repair round and a probe-repair round. **A batch enumerated against a
superseded state is a batch that may have been partly paid**, and executing it
without re-measuring would have re-litigated closed items and — the worse
direction — let an item the editions *appeared* to close stay open at the site
that actually binds.

### 1.2 The re-measurement rule this record used

For each item: locate the **authoritative statement** in the record, then measure
the **authoritative site** — not a document's description of it. The distinction
did the whole of the work. Three items are described as repaired in
`docs/PROCESS.md`, and the constitution they describe still carries the defect.
That gap is not a bookkeeping error; it is §5.9's class exactly, and this record
exists because a document repairing its own prose is the cheapest available
substitute for repairing the rule.

*The general form, and it is the one to carry out of here:* **a defect is paid at
the artifact that binds, not at the artifact that describes.** A description
corrected while its subject stands is a second true sentence about a false rule.

---

## 2. The batch, item by item, measured at `949b8ab`

| # | Item | Authoritative statement | Measured at this tree | Disposition |
|---|---|---|---|---|
| 1 | **C-40** | `PROCESS-MEMOIR` §Part I, *Anchored at — 2.1*, `[CORRECTED · C-40]`; `PROCESS-MEMOIR` B.2 item 1 | `agents/PROTOCOL.md`:164–168 still reads *"a commit cannot mix two scoped agents' work"* | **OWED** → subject **A1** (§3) |
| 2 | **C-93** | `PROCESS` §3.7, `[CORRECTED · C-93]`; `PROCESS-MEMOIR` B.2 item 2 | `agents/PROTOCOL.md`:258 still reads *"signers cannot stage `docs/gates/**` themselves (§6)"* | **OWED** → subject **A2** (§4) |
| 3 | **F-0022-2** | `docs/reports/audit/ADR-0020-auditor-countersignatures.md`:247; stopped at `J-architect_docs_lead-0056`; `PROCESS-MEMOIR` B.2 item 4 | `agents/PROTOCOL.md`:302, :307 still singular. **Partly paid in description**: `PROCESS` §3.9's worked tally prints *"or units"* and §5's museum carries the exhibit | **OWED at the binding site** → subject **A3** (§5) |
| 4 | **ADR21-1** | `ADR-0021` §3.5, draft at its §8 (cured per `J-dv_lead-0189` §2.1) | `agents/PROTOCOL.md` §5 enumerates `R1`–`R9`; `grep -c -E 'R10\|R11' agents/PROTOCOL.md` = 0; CI paragraph still says *"re-checks R1–R8"* | **OWED** → subject **A4** (§6) |
| 5 | **B.2 item 7** | `PROCESS-MEMOIR` B.2 item 7; the rule it exports is `PROCESS` §2.7(4) | `agents/PROTOCOL.md` §11 carries three requirements; no fourth | **OWED** → subject **A5** (§7) |
| 6 | **B.2 item 10** | `PROCESS-MEMOIR` B.2 item 10; `PROCESS` §1.1's summed residue | no clause in `PROTOCOL` or `agents/charters/orchestrator.md` names a spawn cadence for any routed control | **OWED** → subject **A6** (§8) |
| 7 | **B.2 item 11** | `PROCESS-MEMOIR` B.2 item 11; `PROCESS` §3's blockquote | `PROTOCOL` §3 defines four packet types and a numbering authority; no minting route. The record has minted `HT-` by use and retired it by use | **OWED** → subject **A7** (§9) |
| 8 | **B.2 item 12** | `PROCESS-MEMOIR` B.2 item 12 — *"either an amendment routing the scoring act, or a recorded refusal with grounds — both are outcomes; silence is not"* | unchanged; still silence | **ROUTED AS A DECISION** (§14) — not mine to decide, and no longer silent |
| 9 | **B.2 item 13** | `PROCESS-MEMOIR` B.2 item 13 | `agents/PROTOCOL.md`:404–408 still prescribes transient apply-and-revert; every campaign in the record ran on pushed never-merge references | **OWED** → subject **A8** (§10) |
| 10 | **B.2 item 14** | `PROCESS-MEMOIR` B.2 item 14 — *"Owner: this seat. Closing event: the skeleton's disposition line replaced with the itemized form, in a round commissioned for it"* | `agents/handoffs/README.md`:37 still `<auditor-seeded mutations killed: N/N>`. **This round is the commissioned round** | **DONE THIS ROUND** (§13.1) |
| 11 | **B.2 item 15** | `PROCESS-MEMOIR` B.2 item 15 — owner is the shell's maintainer, in another repository | not reachable from this repository; no first-party observation later than the `9ba1138`/`10d3aec` handbook pin | **BLOCKED — external owner** (§15) |
| 12 | **B.2 item 16** | `PROCESS-MEMOIR` B.2 item 16 — *"Owner: this seat. Closing event: the index landing in the core's §1.3 or as a kit row"* | `PROCESS` §1.3 lists nine charter **sections** and no per-seat clause index | **DONE THIS ROUND** (§13.2) |
| 13 | **round-5 charter re-quotes** | `docs/reports/process-council/round-5/verdict.md` repair 3; `PROCESS` §6.0 auditor-charter row; `PROCESS-MEMOIR` B.13 refusal 4 | the ratio stands at **four** charters (auditor ×4 sites, dv_lead ×3, tb_writer ×1, formal_dv ×1); the campaign model at **five** (orchestrator ×2, auditor ×3, rtl_lead ×2, rtl_module_dev ×2, formal_dv ×1) | **BLOCKED — out of this seat's write scope**; drafted at §12, owner orchestrator. The campaign-model half is **additionally blocked on A8** (§12.2) |
| 14 | **the memoir filing fix / the routed residue** | `PROCESS-MEMOIR` §0.2a's closing note; `J-architect_docs_lead-0057` open-question 6; `docs/reports/audit/ADR-0022-split-verification/README.md`:201–203 | the margin is at `PROCESS-MEMOIR`:1462, inside B.1 | **RULED AND DONE THIS ROUND** (§13.3) — and the ruling is *not to move it*, on a ground the batch did not anticipate |

**One clerical correction to the commission.** The spawn dispatch cites the
routed residue as "board row 66"; it is at `tasks/BOARD.md` row **70**
(`J-orchestrator-0285`). Row 66 is the RV-0083 closure. Recorded because a
citation that resolves to the wrong row is the class this program spends most of
its review budget on, and correcting it costs one sentence.

---

## 3. Subject A1 — `R1`'s disjointness premise is false (`C-40`)

### 3.1 The defect

`agents/PROTOCOL.md`:164–168 currently reads:

> **R1 — One agent per commit.** Mixed-agent changes are split into separate
> sequential commits. *Honesty note*: for scoped agents this is emergent from
> R7+R8 (a commit cannot mix two scoped agents' work); for the orchestrator —
> whose scope is everything — correct attribution and splitting is audit-enforced,
> not mechanical. The mechanical invariant is one journal append per commit.

The parenthesis is false, and it is false for a structural reason rather than an
edge case: **the scope table's rows are not disjoint.** Measured against
`scripts/policy.sh`, `agents/handoffs/*` is inside the write scope of **eight**
seats — `architect_docs_lead`, `rtl_lead`, `rtl_lead_md`, `dv_lead`,
`rtl_module_dev`, `tb_writer`, `data_wrangler`, `formal_dv`. A commit staging two
packets authored by two different scoped seats violates no scope rule and is
refused by nothing. `R2` then forces exactly one journal append, so the commit
acquires **one** seat's attribution — which is the mechanism the honesty note
mistakes for a refusal.

The consequence is precisely the one the memoir's `C-40` margin names: the
sentence tells an adopter it need not audit attribution for scoped seats. It must.

### 3.2 Why the shared arm exists and is not the defect

`PROTOCOL` §3 makes `agents/handoffs/**` shared **deliberately**, so that packet
participants can update their own Return logs. That design is right and this
subject does not touch it. What is wrong is a claim of mechanical disjointness
made over a table with a deliberately shared arm — the check and the rule
disagreeing, which is §2.4's own class.

### 3.3 The cure

Replace the parenthesis with what is true: scope isolation narrows the mixing
surface to the shared arm and does not eliminate it, so R1 is **audit-enforced
for every seat** and mechanical for none. The hunk is at §11, A1.

*The general form:* **a disjointness claim over a table nobody has checked for
overlaps is a claim about the author's mental model of the table.**

---

## 4. Subject A2 — the gate-staging premise is false for exactly one signer (`C-93`)

### 4.1 The defect

`agents/PROTOCOL.md`:258 reads:

> **Signature transcription**: signers cannot stage `docs/gates/**` themselves
> (§6), so the **orchestrator transcribes** all gate-checklist signatures.

The *because* is false. Measured against `scripts/policy.sh`,
`architect_docs_lead`'s arm is `docs/*` with two carve-outs
(`docs/reports/audit/*`, `docs/reports/latency/*`); `docs/gates/*` is inside it.
Among the seats §7 names as signers, the count is exact and worth stating as a
number rather than as a qualifier: **of the gate-signing seats, exactly one can
stage the gate directory, and it is the specification lead.** For `dv_lead` and
`auditor` the sentence is true; for the seat that authored the current open gate
checklist it is not.

### 4.2 Why the conclusion survives its premise

The transcription rule is right. What holds it is **not** the scope table but a
sentence in the gate file plus the reviewing seats — which is the residue
`PROCESS` §3.7 declares and this program has been declaring correctly for four
editions while the constitution stated the stronger, false ground. The cure keeps
the rule and repairs the ground; it does **not** narrow the scope table.

### 4.3 The alternative that would make the premise true, and why it is not recommended here

`PROCESS-MEMOIR` B.2 item 3 offers it: carve `docs/gates/**` out of the
specification lead's arm in `scripts/policy.sh`, converting the convention into a
refusal. It is a real option and this record does **not** take it, for one reason
stated plainly: **it is a different decision, with a different owner and a
different cost** (it would also block this seat from authoring gate checklists at
all, which is a duty its charter §3 carries). Recording the premise honestly is a
precondition of deciding that; deciding it inside a record about the premise would
be the checklist-amending-the-constitution shape from the other end. It stays
B.2 item 3, owner orchestrator, and this record names it so the choice is visible.

---

## 5. Subject A3 — the singular *killing unit* (`F-0022-2`)

### 5.1 The finding, and why it was stopped rather than applied

`F-0022-2` (MAJOR, auditor, at
`docs/reports/audit/ADR-0020-auditor-countersignatures.md`:247) convicted the
phrase *"the named killing unit"* — singular — against a record in which
`WO-0050`'s `F-c1` names four units, `F-c2` nine, and `F-c8` one of three required
together: **three of eight classes with no unique referent.** `dv_lead` sustained
it and withdrew its own competing construction.

The cure is one word. It was **stopped** at `J-architect_docs_lead-0056` on the
ground that the phrase lives in exactly two places which are *the same sentence*
— `ADR-0020`'s source hunk and `PROTOCOL` §7 (b.2) — and by then the constitution
carried it, so curing the record alone would have left authority and constitution
disagreeing about what compliance is. That stop was correct and this record is its
redemption, not its reversal.

### 5.2 What the eighth edition did, and why it is not payment

`PROCESS` §3.9's worked tally now prints *"together with its named killing unit
*or units*"*, and §5's museum carries the exhibit *The killing unit that had no
unique referent*. Both are true. **Neither binds a gate.** The gate record is
adjudicated against `PROTOCOL` §7 (b.2), which is still singular — so the
document now describes a plural practice the constitution does not license, which
is a **second** disagreement rather than the repair of the first. State it exactly:
*a description that runs ahead of its rule creates the drift it was written to
close.*

### 5.3 The cure, and the reading it fixes

Two readings were available and they differ materially: *all named units must
still stand* (wider than the hazard) or *any one suffices* (lets a disposition
pick the most durable unit at gate time). The record's own practice, adopted by
`dv_lead` and unchallenged since, is the auditor's construction: **the referent is
the campaign record's own naming, whatever its cardinality**, and every unit it
names must be present and green. The hunk (§11, A3) writes that, and it is
deliberately the *wider* of the two readings — a counting rule loosened at a gate
is a counting rule that stops counting.

*The general form, already banked in `PROCESS` §5 and repeated here because this
is the clause it came from:* **a singular noun inside a counting rule is a
specification of uniqueness; if the record's instances are plural, the rule has
already been applied to something it does not fit.**

---

## 6. Subject A4 — the constitution enumerates nine of the eleven rules (`FINDING ADR21-1`)

### 6.1 The defect, re-measured

`ADR-0021` §3.5 filed it as MAJOR: the scripts refuse by `R10` (chain integrity,
rotation headers, one-volume-per-commit, the size thresholds) and `R11` (the CI
blob gate); `agents/PROTOCOL.md` §5 enumerates `R1`–`R9` and its CI paragraph says
CI *"re-checks `R1`–`R8`"*. `ADR-0017` §8.2 wrote the `R3`/`R5`/`R10` diffs and
marked them *written, NOT applied*; the scripts landed and the constitution's half
never did. Re-measured at this tree: still true, and now **two ADRs old**.

**A rule no constitution names is a rule a fresh orchestrator cannot find** — which
is not a theoretical harm in an org whose §9 rehydration procedure is a document
read.

### 6.2 The draft is not this record's invention

The text at §11, A4 is `ADR-0021` §8's, **which is already cured**: its first
draft recited a remedy-ground `J-dv_lead-0189` §2.1 refuted, and adopting it would
have written into the constitution a principle `R11` breaks two paragraphs later.
This record carries the cured form and adds nothing to it except the `R11`
sentence and the CI-paragraph edit `ADR-0021` §8 also drafted. **A drafted hunk
that has already survived a countersignature is the cheapest amendment in any
batch**, and it is the reason A4 is the subject most ready to land.

---

## 7. Subject A5 — the amendment clause has no fourth requirement (B.2 item 7)

`PROCESS` §2.7 states four requirements where the constitution states three. The
fourth — *an amendment altering enforcement semantics obliges either a re-edition
of the process description naming the clauses that moved, or a logged waiver
stating that nothing needs to change and why* — is presently written only in the
description, where it binds **one seat**: this document's author.

It belongs in `PROTOCOL` §11, where it binds every seat. B.2 item 7 has said so
since the fourth edition and named the reason it was not enacted there:
*a document declaring a constitutional duty for seats that never agreed to it is
§3.7's checklist-amending-the-constitution defect run from the other end.* This
record is the route that ends that objection — a numbered record, proposed by the
seat that wants it, accepted by the seat that owns the file.

**The waiver limb is load-bearing and must survive into the constitution.** A rule
dischargeable only by editing a six-thousand-line document will be discharged by
not invoking it. The hunk keeps both limbs and keeps both as **dated acts with an
author**.

---

## 8. Subject A6 — a cadence written where it cannot fire (B.2 item 10)

`PROCESS` §1.1's summed compensating-control table lists review-enforced controls
whose intervals live in `agents/charters/auditor.md` — *once per phase*, *per
gate*, *per cycle*. Every one of them is dischargeable only in a round somebody
commissions, and **the seat that commissions rounds is the orchestrator**. So the
interval is written in the charter of the seat that cannot fire it.

§5.5's own test — *a routing rule is enforced by a named owner, a named triggering
event and a visible debt* — is failed on the second limb: the trigger names no
actor. The cure (§11, A6) puts the spawn cadence where the spawning power is, and
its consequence is stated so the change is falsifiable: **§1.1's table gains a
"next due" column instead of a "how often" one**, and a control whose next-due
cell is empty is a control nobody has scheduled.

This is the subject with the largest ratio of consequence to text. It is also the
one most likely to be accepted in principle and left unapplied, which is why its
owed-restatement row (§18) names `docs/PROCESS.md` §1.1 as a target file rather
than as a follow-up.

---

## 9. Subject A7 — four packet types and no minting route (B.2 item 11)

`PROTOCOL` §3 defines `WO-`, `SO-`, `BUG-`, `RV-`, and makes the orchestrator the
numbering authority. It defines **no route by which a fifth type comes to exist**.
The record's answer so far has been minting by use: `HT-` (harvest transit) was
minted by being written, executed once, and retired when the mechanism it carried
was retracted (`ADR-0023`), and the seal artifact
(`<packet>-SEALED-predictions.md`) is a form with no type token at all.

**This record is itself the exhibit.** Routing the charter re-quotes at §12 posed
exactly the question: the natural carrier is a packet, no defined type fits, and
minting one inside a record that convicts unminted types would have been the
defect committing itself. The re-quotes therefore travel as drafted hunks in this
ADR — the `ADR-0017` §8.2 / `ADR-0021` §8 idiom — which is the right answer and
is **also** evidence that the missing route has a cost measured in workarounds.

The cure (§11, A7) is deliberately minimal: a type is minted by a numbered
decision record naming its token, its writer, its consumer and its relay class,
and the type table gains a row. It does not create a registry file, because a
registry is a second copy of the table.

---

## 10. Subject A8 — the campaign clause describes a model no campaign used (B.2 item 13)

### 10.1 The defect

`agents/PROTOCOL.md`:404–408 prescribes that the orchestrator *"applies each
manifest transiently in an uncommitted working tree, runs the DV suite against it,
reverts fully, and never lets mutated RTL enter history."* **Every campaign in
this record ran as commits pushed to `mut/*` references that are never merged**,
for the substrate reason `PROCESS` Annex A.6 states: the only environment that can
run the suite runs on pushed references, so there is no local run to revert.

`PROCESS` §3.9 has disclosed the divergence for five editions and never routed it,
while routing the two directly analogous false premises as B.2 items 1 and 2. By
§5.5's own law, **a disclosed-but-unrouted falsehood is routed to nobody.** This
subject is its route.

### 10.2 What the cure must preserve

The transient model's *purpose* — mutated RTL never enters the mainline; no
RTL-line or worker seat is spawned while a manifest is live; the campaign sits
between `RV-` ACCEPT and `SO-` PASS — is all correct and all preserved. What
changes is the **mechanism**: from *apply-and-revert in an uncommitted tree* to
*render on a marked never-merge reference*, with the never-merge property stated
as the invariant that replaces reversion. The hunk (§11, A8) also keeps the
transient form as the lawful alternative for an adopter whose substrate can run
the suite locally, because `PROCESS` Annex A.6 says that adopter exists and the
constitution should not forbid the simpler thing.

### 10.3 The sequencing consequence, which is the reason A8 is not last

**Five charters teach the transient model** (§12.2). They cannot be "re-quoted to
current law" while the constitution's own clause **is** the stale law. A8 is
therefore a **precondition** of half the round-5 charter re-quote, and the
verdict's repair 3 was unexecutable in that half from the day it was written. That
is stated here rather than discovered later by whoever tries it.

---

## 11. The `PROTOCOL` hunks — written, NOT applied

**Applied by the orchestrator, in its own commit, citing this record.** Each is
given as the current text and the proposed text, not as a patch file, because a
patch against a moving file is stale on arrival and the orchestrator applies these
by reading.

### A1 — §5, `R1`'s honesty note

*Current* (`agents/PROTOCOL.md`:164–168), the parenthesis:

> for scoped agents this is emergent from R7+R8 (a commit cannot mix two scoped
> agents' work)

*Proposed*:

> for scoped agents R7+R8 **narrow** the mixing surface without closing it — the
> scope table's rows are not disjoint, and `agents/handoffs/**` is deliberately
> shared by every packet participant (§3), so a commit staging two seats' packets
> breaks no scope rule; what makes such a commit single-agent is R2's one journal
> append, which assigns attribution rather than refusing the mixture. **R1 is
> therefore audit-enforced for every seat**, and mechanical for none;

### A2 — §7, the transcription premise

*Current* (:258–260): *"signers cannot stage `docs/gates/**` themselves (§6), so
the **orchestrator transcribes** all gate-checklist signatures."*

*Proposed*:

> **Signature transcription**: the **orchestrator transcribes** all
> gate-checklist signatures. **The ground is a rule, not a refusal**: §6 puts
> `docs/gates/**` outside `dv_lead`'s and the auditor's scopes but **inside**
> `architect_docs_lead`'s, so for the specification lead — the seat that authors
> gate checklists — self-signature is prevented by this clause and by the
> declaration in the checklist file itself, and by nothing mechanical. The
> residue is declared rather than closed; narrowing the scope table is available
> and is not taken here.

### A3 — §7 (b.2), the killing unit

*Current* (:300–308), two sites: *"the **killing unit named**"* and *"together
with the named killing unit, present and green at the gate SHA"*.

*Proposed*: both occurrences become **"the killing unit or units named"** /
**"together with the killing unit or units named, each present and green at the
gate SHA"**, with one sentence added after the second:

> **The referent is the campaign record's own naming, at whatever cardinality it
> named**: where a class was killed by several units, every one of them is the
> disposition's subject and every one must be present and green — a disposition
> may not select the most durable member.

### A4 — §5, the rule enumeration and the CI paragraph

Add after `R9` (the text is `ADR-0021` §8's cured draft, unchanged except for
placement):

> - **R10 — Journal chain integrity.** The chain is verified across volumes:
>   rotation headers, back-links, contiguous ids, one volume per commit. **The
>   active volume's size is bounded**: above `JOURNAL_SOFT_MAX` the commit script
>   warns, above `JOURNAL_HARD_MAX` it refuses and names the rotation. CI
>   evaluates the same bound over history and reports it as a warning, because a
>   permanent red is proportionate to harm that persists in every future reader
>   and an oversized volume's harm is bounded by one file's readability, with its
>   cure available prospectively to its owner — where `R11`'s blob gate refuses on
>   exactly the opposite proportionality.
> - **R11 — CI blob gate.** `check_journals.sh` re-verifies ADR-0002's blob
>   threshold over every commit, with journals carved out per `R10`.

And the CI paragraph's *"re-checks R1–R8"* becomes:

> re-checks `R1`–`R8` and `R10`–`R11`, and emits advisory
> `WARN-STAMP`/`WARN-JOURNAL` counters that never affect its verdict.

### A5 — §11, the fourth requirement

Add as item (4) of §11's list:

> (4) if the change alters **enforcement semantics** — what a rule refuses, on
> which surface, under what posture — it obliges either a **re-edition of the
> process description** (`docs/PROCESS.md`) naming the clauses that moved, or a
> **logged waiver** stating that nothing there needs to change and why. Both are
> acts with an author and a date; neither may be silent. The obligation is owned
> by `architect_docs_lead` and discharged in that seat's journal. **Review-enforced
> — no script reads it.**

### A6 — §7 or §2, the cadence owner

Add to §7, after the gate table:

> **Cadenced controls have a spawning owner.** Every review-enforced control whose
> charter states an interval (*once per phase*, *per gate*, *per cycle*) is
> dischargeable only inside a round somebody commissions. The **orchestrator**
> owns the cadence: it is the seat obliged to schedule each such control's next
> occurrence, and `tasks/BOARD.md` carries the next-due date. A control whose
> next-due cell is empty is unscheduled, and that is a visible debt rather than a
> silent one. **Review-enforced.**

### A7 — §3, the minting route

Add after the packet-type table:

> **Minting a packet type.** The four types above are the whole of them. A fifth
> is minted only by a numbered ADR naming its **token**, its **writer**, its
> **consumer**, its **relay class** (§3's Relay rule) and its **retirement
> condition**, accepted by a seat that did not propose it; the table above then
> gains a row in the same amendment. A type minted by use binds nobody and its
> traffic is unrouted. **A type may also be retired**, by the same instrument, and
> retirement is a disposition rather than a deletion: the table keeps the row with
> its dates.

### A8 — §10, the campaign model

*Current* (:404–408): *"the **orchestrator applies each manifest transiently in an
uncommitted working tree**, runs the DV suite against it, reverts fully, and never
lets mutated RTL enter history."*

*Proposed*:

> the **orchestrator renders each manifest onto a marked never-merge reference**
> (`mut/<campaign>-<class>`), runs the DV suite there, and records the run id;
> **the never-merge property replaces reversion** as the guarantee that mutated
> RTL never reaches the working branch or `main`, and it is checkable by a
> stranger from a full clone. **Substrate ground**: the only environment that can
> run this program's suite runs on pushed references, so there is no local run to
> revert (`PROCESS` Annex A.6). **Where an adopter's substrate can run the suite
> locally, the transient apply-and-revert form is lawful and preferred** — it
> leaves no reference to police. Unchanged either way: no RTL-line or worker agent
> is spawned while a manifest is live; the campaign runs after `RV-` ACCEPT and
> before `SO-` PASS; and the "report, never repair a suspected seeded mutation"
> clauses remain the safety net for a sequencing error.

---

## 12. The charter re-quotes — drafted, NOT applied

`agents/charters/**` is outside this seat's write scope by `PROTOCOL` §6, by this
seat's own charter §1, and mechanically by `scripts/policy.sh`, which returns 1
for every path under it. `PROCESS-MEMOIR` B.13 refusal 4 records the same
conclusion for the eighth edition. **This round's dispatch described the charter
directory as inside this seat's write scope; it is not, and the dispatch does not
change it** — a commit staging those files under this seat would be refused by
`R7` before a commit object existed. They are drafted here and applied by the
orchestrator.

### 12.1 The ratio — four charters, nine sites, applicable now

`PROTOCOL` §7 (b.2) already forbids the ratio (*no ratio stands in for the
dispositions*; *no `N/N` figure is read as coverage*), so these re-quotes need no
prior amendment.

| File | Sites | Current | Re-quoted to |
|---|---|---|---|
| `agents/charters/auditor.md` | :22, :35, :40, :53 | *"the DV suite must kill all N and the PASS reports N/N"*; *"gate-checklist rows (mutation kills N/N…)"*; *"`SO-` packets with mutation-kill results N/N"*; *"mutation kills N/N confirmed per module"* | *"the PASS reports the **disposition of every seeded mutation**, each non-kill named individually (`PROTOCOL` §7 b.1–b.4)"*; *"gate-checklist rows (**the seeded-defect dispositions and the unreachable set beside them**…)"*; *"`SO-` packets with **per-class dispositions, two columns and no ratio**"*; *"**every seeded mutation dispositioned** per module"* |
| `agents/charters/dv_lead.md` | :27, :38, :55 | *"mutation kills N/N"* ×2; *"Auditor-seeded mutations killed N/N."* | *"**the seeded-defect dispositions, sealed and seeded stated as two numbers with the difference named**"*; *"**per-class dispositions in the `SO-`**"*; *"**Every auditor-seeded mutation dispositioned; no non-kill folded into a kill.**"* |
| `agents/charters/tb_writer.md` | :59 | *"contribute to the auditor's N/N kills at `P<n>-module-ready`"* | *"contribute to the **seeded-defect dispositions** at `P<n>-module-ready`"* |
| `agents/charters/formal_dv.md` | :24 | *"count toward the auditor's N/N mutation kills"* | *"count toward the **seeded-defect dispositions**"* |

### 12.2 The campaign model — five charters, ten sites, BLOCKED on A8

`agents/charters/orchestrator.md`:27, :41; `auditor.md`:22, :35, :100;
`rtl_lead.md`:41, :68; `rtl_module_dev.md`:26, :36; `formal_dv.md`:24 all teach
*transient application in an uncommitted working tree*, each citing `PROTOCOL`
§10 — **accurately**. Re-quoting them to the pushed-reference model **before** A8
lands would make five charters disagree with the constitution they cite, which is
the exact defect `J-architect_docs_lead-0056` refused to commit for `F-0022-2`.

**They are therefore not drafted as text here, deliberately**, and the reason is
recorded rather than left as an omission: the target wording is A8's own hunk, and
it does not exist until A8 is accepted. Owner: orchestrator. Closing event: the
commit that applies A8, in which the five charters move with it. *A re-quote whose
source clause is itself the stale law is not a re-quote; it is a second
amendment wearing clerical clothes.*

### 12.3 What is not owed

`agents/charters/architect_docs_lead.md` carries neither defect and is not in
either list. The gate checklist's §7.1 re-quote was discharged 2026-08-18
(`J-architect_docs_lead-0060`, `dbbee41`); its §0.1/§3 pre-`ADR-0020` clause quote
is a **separate** open item with its own carrier (`tasks/BOARD.md`, the
`P1-module-ready` row) and is not folded in here.

---

## 13. What this round performed, inside scope

### 13.1 B.2 item 14 — the sign-off skeleton (`agents/handoffs/README.md`)

The kit's packet-forms original demanded `**Mutation kills**: <auditor-seeded
mutations killed: N/N>` — the pre-amendment form `PROTOCOL` §7 (b.2) forbids in
terms, and the one sign-off in this record deliberately refused to produce it.
**An adopter pulling the named original inherited a template whose first use
commits the thing the constitution beside it prohibits.** Replaced with the
two-column, per-class disposition block that `PROCESS` §3's facsimile already
prints, and `PROCESS` §6.0's kit row is re-quoted from *"still teaches the ratio…
until the original is re-quoted"* to the repair with its date.

### 13.2 B.2 item 16 — the per-seat charter-clause index (`PROCESS` §1.3)

The core exports the auditor's charter mechanisms in prose and leans on
charter-carried duties of **other** seats that §1.3's nine-section list does not
regenerate — the external-anchor precondition, the *report, never repair* clause,
the mutation-window operator duty, the blind-execution obligation. An adopter
authoring charters at act 1c from the nine-section list alone puts none of them
in. The repair is an index: one row per seat, naming every clause the core relies
on that seat's charter to carry, so completeness is checkable **at the act that
writes them**. Landed at §1.3, per the item's own stated closing event.

### 13.3 The routed residue — ruled, and the ruling is *do not move it*

The margin — the fifth edition's, at `d96a5b1`:4825, preserved in the companion's
Annex **B.1** — carries a superseded sentence **of Annex B.1 itself**. Part I of the companion is titled *the superseded record, **by core
section***, and the split's **falsifier 2** reads: *every block in the companion's
Part I names a section of this file, and that section exists here.* Annex B is not
a section of the core — it moved to the companion whole at the split, under clause
S2. **So filing this margin under a Part I heading would falsify the split's
second falsifier**: the block would name a section the core does not contain.

The residue is therefore **not a mis-filing**. It is an **unstated exception in
the census**: §0.5 carved out *"1 inside Annex B"* with no rule behind the carve-out,
and §0.2a described the block as belonging somewhere it cannot go. Both are
repaired by writing the rule and enumerating its population — S3's own principle
(*a rule with an enumerated exception list is auditable; a rule with an unstated
exception is not*) applied to the sentinel census. The block stays where it is, at
the row it corrects, which is also where a reader of that row needs it.

**What would overrule this**: a later edition that gives Part I an annex-anchored
division, at which point the population named at §0.5 moves there as a set and
falsifier 2 is restated to quantify over core sections only. That is an edition's
act, not an amendment round's.

*The general form:* **a residue routed as clerical is worth re-deriving before it
is paid — this one's cheapest repair was forbidden by the apparatus that named it.**

---

## 14. B.2 item 12 — routed as a decision, so it is no longer silence

B.2 item 12 asks whether a seeded-defect campaign should be **scored by the
independent seat rather than by the seat that froze the seal**, and closes:
*"either an amendment routing the scoring act, or a recorded refusal with grounds
— both are outcomes; silence is not."* It has been silence for four editions.

**This record does not decide it, and says why**: it is not this seat's decision.
The blind runs against the **auditor** and the cost falls on the **auditor**
(`PROCESS` §1.1 measures it as the most oversubscribed seat in the program); the
scoring practice it would change is **`dv_lead`'s**. A specification lead ruling
on how two other seats divide a measurement is the adjudication power its charter
§7 reserves for **interface contracts between the build and verification lines**,
not a licence to allocate their rounds.

What this record does is convert silence into a **routed question with a named
carrier**: it goes to `auditor` and `dv_lead` jointly, and the outcome is either
an amendment (which this record would carry as a ninth subject on re-proposal) or
a dated refusal with grounds in either seat's journal. **Owner**: auditor and
dv_lead jointly. **Carrier**: the next round in which both are spawned against the
same campaign. **Cadence**, since §5.9's second cure part asks for one and this is
a chance to honour it: it is re-asked at every `P<n>-module-ready` until answered.

---

## 15. B.2 item 15 — outside both this seat and this repository

The shell's core-plus-domain-pack refactor is owned by the shell's maintainer, in
`generic-agentic-fpga-org`. **BLOCKED, and honestly rather than pessimistically**:
this repository holds no first-party observation of the shell later than the
handbook pin (`9ba1138` here, `10d3aec` there, 2026-08-18), and the instrument
that would tell us whether the row has moved is the **doc–shell drift check**,
which is B.0.4a and still unbuilt at six editions. So this record cannot say
whether item 15 is open, and does not guess. Row unchanged; owner unchanged;
**the reason it cannot be measured is itself an entry against B.0.4a**, and that
is the useful thing this line contributes.

---

## 16. Alternatives considered

**16.1 Eight separate ADRs, one per subject.** Rejected. Cleaner per-subject
routing, but the subjects share one owner, one file and one failure class; eight
records would produce eight independently deferrable rows, which is the aging
inventory §5.9 convicts. The batch's *shape* is part of its argument: what makes
these worth accepting together is that they are the same defect eight times.

**16.2 Wait for the posture re-measurement (POSTURE-RE-MEASUREMENT-2) first.**
Rejected. The re-measurement is the auditor's and would re-decide *stamps*; every
subject here is decided against the **artifact**, not against a stamp. Three of
these have now waited through three editions for a round that would make them
easier to write, and none got easier.

**16.3 Apply the charter re-quotes anyway, on the dispatch's statement that the
directory is in scope.** Rejected on three independent grounds, any one
sufficient: `PROTOCOL` §6 and this seat's charter §1 both exclude it;
`scripts/policy.sh` refuses it mechanically, so the commit could not exist; and a
seat widening its own scope on an instruction rather than an amendment is
precisely §1.3's *charters change only by the amendment procedure — a numbered
decision record, not an instruction.* **A dispatch is not an amendment**, and a
round that took one as such would have convicted itself in the record it was
writing about unapplied amendments.

**16.4 Take B.2 item 3 (carve `docs/gates/**` out of this seat's scope) as part of
A2.** Rejected — §4.3. Different decision, different owner, different cost; it
would also foreclose a duty this seat's charter carries.

**16.5 Bump `docs/PROCESS.md` to a ninth edition.** Rejected — §2.7(4)'s
re-edition limb is triggered by a change that **alters enforcement semantics**,
and at this tree **no enforcement semantics move**: every constitutional hunk here
is written and not applied. The edits performed at §13 are one form repair, one
addition, and one archaeology ruling. What §2.7(4) *does* oblige, and what this
round therefore performs, is the re-measurement of the boundary block's figures in
the act that moves them — the rule the eighth edition tightened from *per edition*
to *per act* on 2026-08-18, on the precedent of a currency-repair round that was
not an edition. **The ninth edition's trigger is the commit that applies §11**, and
it is named as owed there rather than pre-paid here.

---

## 17. Countersignatures — owed, by subject

Per `PROTOCOL` §7's convention and `ADR-0021` §9's form: a journal entry of the
signing seat saying which subject it signs and what, if anything, it contests. A
contested subject is redrafted before acceptance. **No signature below may be
written by this seat, and none is assumed.**

| Subject | Countersignature OWED from | On what | Ground for that seat |
|---|---|---|---|
| **A1** | **auditor** | that the shared-arm counterexample is real, and that attribution for scoped seats is in fact audit-enforced in its practice | R1's own honesty note routes attribution to audit; the auditor is the control it names |
| **A2** | **auditor** | that exactly one gate-signing seat's scope contains `docs/gates/**`, measured against `scripts/policy.sh` at this SHA | it owns `C-93`'s row in the posture list |
| **A3** | **auditor** *and* **dv_lead** | the plural reading, and that the wider construction (*every named unit present and green*) is the one both seats operate | `F-0022-2`'s filer and the seat its width falls on; both are constrained parties |
| **A4** | **orchestrator** | that the three-surface table is right and that `R10`/`R11` are what the scripts refuse by | it owns and re-executes the scripts; this also discharges the standing `B.1` row on §2.6's rule table |
| **A5** | **orchestrator** | that the fourth requirement, moved into §11, binds every seat as it reads it — including itself | it is the seat the duty newly reaches |
| **A6** | **orchestrator** *and* **auditor** | that the cadence-ownership reading is one the spawning seat recognises, and that the intervals are the auditor's charter's | exactly the two seats `B.1`'s §1.1 row already names |
| **A7** | **orchestrator** | that the minting route is one it will operate as sole numbering authority | §3 makes it the numbering authority |
| **A8** | **auditor** *and* **orchestrator** | that the pushed-reference model is what actually ran, and that the never-merge invariant is the right replacement for reversion | manifest author; and the seat whose described practice is the false one |

**Adverse-party note.** Six of the eight rows name the orchestrator, which is also
the seat that accepts this record under §11(2) and applies every hunk. That is
§5.7's shape and it is stated rather than smoothed: **acceptance and factual
countersignature are different acts**, and where the same seat performs both, the
independent check on the pair is the auditor's — which is why A1, A2, A3, A6 and
A8 all carry an auditor limb and why A4, A5 and A7 are the three where this record
is weakest. A reviewer who wants one thing to check first should check those three.

---

## 18. The owed-restatement list (`PROCESS` §5.9's cure, part one)

*"An amendment record's owed-restatement list names each target file, and the
record is not accepted until each is either re-quoted or carries a dated
refusal."* This is that list. It is exhaustive over **live text**; historical
records — ADR bodies, journals, council reports — are not rewritten.

| # | Artifact | What restates the amended rule | Owner | Closing event |
|---|---|---|---|---|
| 1 | `agents/PROTOCOL.md` §3, §5, §7, §10, §11 | the eight clauses themselves | **orchestrator** | the commit applying §11's hunks |
| 2 | `agents/charters/auditor.md`, `dv_lead.md`, `tb_writer.md`, `formal_dv.md` | the ratio, nine sites | **orchestrator** | §12.1's table, applicable now — no amendment precondition |
| 3 | `agents/charters/orchestrator.md`, `auditor.md`, `rtl_lead.md`, `rtl_module_dev.md`, `formal_dv.md` | the transient campaign model, ten sites | **orchestrator** | **the same commit as A8**, never before it (§12.2) |
| 4 | `docs/PROCESS.md` §1.1, §2.6, §2.7, §3, §3.7, §3.9, §5.9, §6.0 | the summed-residue table's *how often* column (A6); the rule table's *nine of eleven* (A4); §2.7's four-requirement count over three constitutional ones (A5); §3's minting blockquote, which stops being a proposal (A7); §3.7's residue paragraph (A2); §3.9's campaign-model divergence disclosures (A8) and the *or units* tally (A3); §5.9's exhibit list, three of whose members close | **architect_docs_lead** | **the ninth edition**, triggered by row 1's commit under §2.7(4) — named here as owed, not pre-paid (§16.5) |
| 5 | `docs/PROCESS-MEMOIR.md` B.2 items 1, 2, 4, 7, 10, 11, 13 | seven ledger rows whose status becomes *routed and drafted* rather than *named, not performed* | **architect_docs_lead** | **this commit** — discharged (§13, and the round block appended after B.13) |
| 6 | `docs/PROCESS-STE.md` §1.3, §2.6, §2.7, §3, §5.9, §6.0 | the rendition of every row-4 site | **architect_docs_lead** | **the ninth edition's re-derivation** — the rendition's own rule is *re-derived per edition, or marked stale*. Its §6.0 kit sentence that this round makes **false** is re-derived in this commit (§13.1); the sites this round makes merely **incomplete** are not, and that split is stated at §20 |
| 7 | `docs/gates/P1-module-ready-checklist.md` | its §0.1/§3 quote of `PROTOCOL` clause (b), already open with its own carrier; A3 adds the killing-unit clause to what it must re-quote | **architect_docs_lead** | the round that next opens `G-1`, per the board's own routing — **not folded in here** |
| 8 | `tasks/BOARD.md` | the queue row naming this batch, and the `P1-module-ready` row's open items (2) and (3) | **orchestrator** | the commit applying §11's hunks |
| 9 | `agents/handoffs/README.md` | the sign-off skeleton's disposition line | **architect_docs_lead** | **this commit** — discharged (§13.1) |
| 10 | `scripts/test_protocol.sh` | one case per subject that moves enforcement semantics | **orchestrator** | §19 |

**Row 3 is the one to watch**, because it is the only row in this list that is
**ordered** rather than merely owed: applying it early produces five charters
citing a constitution that says something else. A restatement list that records
ordering is doing something a list of files cannot.

**Row 7 is named and not discharged**, on the same discipline `ADR-0023` §7 rows 6
and 7 used: an open gate checklist edited outside its commission produces a
`Files-in-this-commit` that disagrees with what was commissioned. Dated: owed
2026-08-22, to `architect_docs_lead`, on the round that next opens `G-1`.

---

## 19. `PROTOCOL` §11(3) — what the self-test owes

§11(3) obliges an updated `scripts/test_protocol.sh` case **where enforcement
semantics change**. Measured per subject, because the count matters and a blanket
answer would be wrong in both directions:

| Subject | Enforcement semantics move? | Case owed |
|---|---|---|
| **A1** | **No** — it corrects a description of what R7+R8 already do. No refusal changes | none |
| **A2** | **No** — same shape; the rule stands, the ground is repaired | none |
| **A3** | **No mechanically** — (b.2) is review-enforced at a gate, and §7's own text says the Mutation record mints no `R`-rule | none. **A review-enforced clause owes a gate-record form, not a script case**, and A3's form is already `PROCESS` §3.9's block |
| **A4** | **No** — `R10`/`R11` already refuse; the constitution catches up to the scripts. `S28`–`S38` exist | none. *The absence is the point of the finding* |
| **A5** | **No** — review-enforced by construction, and it says so | none |
| **A6** | **No** — review-enforced | none |
| **A7** | **No** — a minting route governs future amendments, not commits | none |
| **A8** | **No** — §10 is review-enforced throughout (`PROCESS` §5.5's class); no script refuses a transient tree today or a marked reference tomorrow | none. **What A8 does owe is a check nobody has**: nothing verifies that a `mut/*` reference never merges. Named here as a **new** debt this record creates, owner orchestrator, closing event a CI ancestry assertion on the working branch |

**So §11(3) is discharged by measurement, not by exemption**, and the one honest
residue it surfaced — the unenforced never-merge invariant — is named as a debt
rather than folded into a "no case owed" row. *A procedure step answered "not
applicable" eight times without stating the measurement is a step nobody ran.*

---

## 20. What this record does not decide

- **Whether `docs/gates/**` should leave this seat's scope.** B.2 item 3, owner
  orchestrator, untouched (§4.3).
- **Whether campaigns should be scored by the seeding seat.** Routed, not ruled
  (§14).
- **Anything about the shell.** §15.
- **Whether the STE rendition is bound to the source by anything.** It is not, and
  this round does not build the binding. It re-derives the **one** rendition
  sentence this round makes *false* (§6.0's *"the packet forms still teach the
  ratio"*), and leaves the sites this round makes merely *incomplete* — §1.3's
  index has no rendition row yet — to the ninth edition's re-derivation. **The
  split is deliberate and is the rendition's own calibration rule read strictly**:
  *if a sentence here is stronger than its source sentence, this volume is the
  defect*. A false sentence is a defect; a missing one is staleness, which the
  header already declares and dates.
- **Whether the posture list's rows move.** No stamp is re-measured here. `C-40`
  and `C-93` keep indexing the world before their cures, and will still index it
  after the hunks land; re-stamping is the auditor's artifact
  (`PROCESS-MEMOIR` B.2 item 8), and POSTURE-RE-MEASUREMENT-2 is its carrier.
- **Whether this batch should have been eight records.** §16.1 states the choice;
  a reviewer who disagrees is disagreeing with the record's shape and not with any
  subject in it, and can say so in one countersignature line.
