# ADR-0022: the warranty and the split — two normative changes to what `docs/PROCESS.md` claims to be

- **Status**: **PROPOSED**. **NOT IN FORCE.** Nothing in this file binds
  anything until the countersignature route of §7 completes. **Both decisions
  it records are already operating** — decision 1 has been operating since the
  fourth edition landed, decision 2 lands with the sixth edition in the same
  commit as this file — and that gap is the point of the record, not an
  embarrassment to be smoothed: §3.6 of `docs/PROCESS.md` names *proposed, and
  the rule it records has been in force since this date* as the shape that makes
  a proposed-but-operating rule measurable instead of quietly true. This is that
  shape, disclosed.
- **Proposed at**: `J-architect_docs_lead-0056`, 2026-08-12.
- **Deciders**:
  - **architect_docs_lead** — this instrument, and both decisions as *authored
    acts*. Decision 1 was taken by this seat, single-seat and uncountersigned,
    inside a document revision; decision 2 was taken by this seat under an
    explicit commission. **Recording them here does not ratify them**; it puts
    them on the route they should have taken.
  - **the fourth council** — the *commissioning* authority for decision 2 and
    the *condition* on decision 1. Its verdict, committed at
    `docs/reports/process-council/round-4/verdict.md`, commissions the split in
    terms ("execute the fork contract once, exporter-side") and accepts the
    re-scoped claim **on one condition**: "the re-scoping itself must be
    governed — it is a normative change to the artifact's central warranty and
    it must get the numbered decision record and countersignature §1.0 demands
    of everything else." This file is that condition being met.
  - **Not an escalation class.** No requirement, phase, role, toolchain lane or
    licensing boundary moves. PROTOCOL §11(1)–(2) is the whole procedure;
    §11(3) is not owed, because no enforcement semantics change and no script
    moves — see §6.
- **Commissioned by**: orchestrator dispatch, one round, the sixth edition of
  the process description. Dispatch-only: no work-order packet exists, which is
  itself an instance of the class `docs/PROCESS.md` §3 names and this file is
  obliged to declare rather than let pass.
- **Affects**: `docs/PROCESS.md` (its central claim, and its scope as a file);
  `docs/PROCESS-MEMOIR.md` (created by decision 2). **No constitution, no
  charter, no enforcement script, no gate checklist, no specification, no
  requirement, no RTL.** Every path this file touches is inside the proposing
  seat's own write scope, which is why §5's failure-mode table has a row about
  exactly that.
- **Countersignature route**: **owed, and named** — §7. Route: **dv_lead** and
  **auditor**, per the precedent of every prior confirmation round on this
  document. To be paid **after this window**; this file lands unsigned and says
  so.

---

## 1. Why one record carries two decisions

They are the same decision seen twice. Decision 1 changed **what the artifact
warrants**; decision 2 changed **what the artifact is**. Neither is
a figure, a scope or a cure inside an already-ruled rule — the three classes
`docs/PROCESS.md` §1.4(a) now names as *not* normative — and both fall squarely
inside its class 4, *this document's own central claim: what the artifact
warrants and to whom.*

Splitting them across two records would have hidden the thing that makes them
one item: **decision 1 narrowed the claim so that decision 2 became possible.**
While the document claimed to be a complete, self-sufficient description, it
could not shed its own archaeology without appearing to shed evidence. Once the
claim was scoped to *the explaining half of an export unit*, the archaeology
became what it always was — provenance for a claim now made elsewhere — and
separable. A reader who meets only the second decision cannot see why it was
available; a reader who meets only the first cannot see what it bought.

## 2. Decision 1 — the warranty re-scoping

### 2.1 The decision

**The claim `docs/PROCESS.md` makes about itself is: it is the *explaining* half
of a two-part export unit whose other half is an executable shell. Read alone it
is a description, not a replication kit. The replication claim belongs to the
unit and not to this half.** It is stated in the document's own opening
paragraph, where a reader meets it first, and it is measured rather than
asserted: two executed cold adoption runs, both by parties that did not write
the document, returned "roughly one hundred percent of the executable layer
invented" and, after the interfaces were printed as facsimiles, some eight
hundred and fifty lines of enforcement logic still written from nothing.

**What the claim used to be**: a complete, project-agnostic description
sufficient for a stranger — in the framework's words, for a blank AI — to
rebuild the organization.

### 2.2 Alternatives considered, and why each was rejected

| Alternative | Rejected because |
|---|---|
| **Keep the original claim and close the gap** — write the executable layer into the document until a stranger could rebuild it from prose | It is the defect the document convicts itself of at its own mechanism-placement rule: a normative prose copy of the shell's rule set drifts from it on the shell's first commit, and there is no instrument binding the two. Two adoption runs measured what prose regenerates; the answer was the interfaces, never the logic. |
| **Keep the original claim and say nothing** | This is what the first three editions did. It is the claim-suppresses-vigilance failure in its purest form: an adopter told the text is sufficient does not go looking for the half that is missing. |
| **Drop the replication claim entirely** — call it a memoir with no export function | False in the other direction, and expensively so. The interfaces *did* transfer: run two's stop count was zero, and every grammar, identifier, threshold and rule number came across as a facsimile. A document that disclaims what it demonstrably does teaches an adopter to build what it already ships. |
| **Re-scope to the unit, and declare the binding instrument owed** | **Chosen.** It is the only option that is true of both measurements at once, and it makes the missing instrument — the doc–shell drift check — a *named debt with a due date* rather than an unnoticed absence. |

### 2.3 Failure modes this creates or leaves open

- **The unit has never been assembled and tested.** The re-scoped claim relocates
  to a composite — document plus shell plus a drift check that does not exist
  plus a with-shell adoption path never executed. **The honest verdict at the
  unit level is UNTESTED, not FIT**, and this record does not upgrade it.
- **The two halves are bound by nothing but a sentence.** Until the drift check
  exists, every facsimile in the document is an unverified claim about another
  repository. That is disclosed in the document at the point of use, and the
  disclosure is not a repair.
- **The re-scoping is a claim a later seat can quietly widen back.** Nothing
  mechanical holds a document's scope. The compensating control is that the
  claim now sits in the opening paragraph, where a widening is visible in a diff
  a reviewer reads first.
- **This record does not cure the original defect, which was procedural.**
  Decision 1 was taken single-seat and uncountersigned by the seat whose work it
  scoped. Recording it late is the available repair; it is not the same artifact
  as having taken it correctly, and §7 is what closes the difference.

### 2.4 What this explicitly does not decide

It does not decide whether the unit-level replication claim is true — that is
gated on the drift check and on a with-shell, alien-domain adoption run by a
party this program did not commission. It does not decide the shell's contents,
its law, or its maintainer's obligations. It does not certify any edition. And
it does not decide that a document may re-scope its own warranty in future
without this route: **the opposite is the rule this record establishes.**

## 3. Decision 2 — the core/memoir split

### 3.1 The decision

**`docs/PROCESS.md` becomes two files.** The core keeps the name and carries
**current law only**: the seats, the constitution and its enforcement, the
artifact grammar, the operating disciplines, the failure museum, the adoption
chapter, the substrate annex, every facsimile, and the rule-plus-failure-class
dual statement. A companion volume, **`docs/PROCESS-MEMOIR.md`**, carries the
revision archaeology: every preserved superseded claim, the stamps' own history,
the edition-by-edition ledgers and the name map.

Three properties are load-bearing and are the decision, not its packaging:

1. **The core governs where the two disagree**, stated in both files.
2. **The split loses nothing.** Every stripped byte lands in the companion under
   the core section it was anchored to. First-edition preservation — the
   discipline that a corrected claim is kept beside its correction, never
   deleted — **continues, in the companion.**
3. **The derivation is stated in both files** so that a reviewer can *verify*
   the split rather than trust it: the rule that moved each passage, the
   counts, and the falsifier.

### 3.2 Alternatives considered, and why each was rejected

| Alternative | Rejected because |
|---|---|
| **Refuse again, for a third edition** | Refused twice already, on grounds that were real both times (a single seat should not restructure its own artifact ungoverned; a revision round should not widen into a structural act). Both grounds are answered here: a council commissioned it, and this record governs it. The document's own ledger had already recorded the endorsement as *overdue*. |
| **Keep one file and strip harder** — more pointerization, more demotion | Tried, in the fifth edition, and measured: readability B−, conciseness C+, with a cold reader returning that the current law "is not extractable without processing five editions of archaeology." Per-claim editing of a document this size **does not converge**; the document says so about itself and two consecutive editions proved it. |
| **Delete the archaeology** | Forbidden by the discipline the archaeology exists to serve, and it would destroy the document's single most-cited asset: the record of its own false claims and what refuted them. **A document that deletes its corrections is asking to be trusted rather than checked.** |
| **Split by audience** — an adopter edition and an auditor edition, each self-contained | Two self-contained copies of the same rules is the drift hazard one level up: the exact defect the mechanism-placement rule was written against. The chosen split is by **tense**, not by audience — current law in one file, history in the other — so no rule is stated twice. |
| **Split into three or more** (law, memoir, annexes) | Rejected on the same ground the document gives for the seam: each additional file is another boundary claim that decays. Two files, one governing rule, one derivation. |

### 3.3 Failure modes this creates or leaves open

- **A reader of the core alone cannot see which rules were once wrong.** That is
  the cost, and it is the point: the core carries a pointer wherever a rule's
  history bears on the rule, and the companion carries the rest. **A pointer
  followed by nobody is a loss the split accepts deliberately** — weighed
  against a memoir processed by everybody.
- **Two files drift.** Nothing mechanical binds them. This is the same class as
  the doc–shell drift check, one level down, and it is not cured here: the
  compensating control is that the companion states no rule of its own, so a
  drift can only be a *stale history*, never a *competing law*.
- **The split can hide a deletion.** A byte dropped in the move is invisible to
  a reader of either file. The compensating control is the stated derivation
  plus a mechanical falsifier — a search for the sentinel token returning
  non-zero against the core — and it is weaker than a script. **Verifying the
  split against the fifth edition's committed text is a reviewer's act this
  record cannot perform for itself.**
- **The core's stamp apparatus now cites rows in a file whose narrative lives in
  the companion.** The posture stamps stay in the core, because a posture
  declaration is current law under the document's own §5.5. Only the *story of
  how a claim was found false* moves. A reader who over-reads a stamp is a
  reader the boundary block still has to catch, and the boundary block stayed.

### 3.4 What this explicitly does not decide

It does not decide the companion's future — whether it is maintained per
edition, frozen, or eventually archived. It does not decide that any other
artifact in this program splits. It does not delete or supersede any committed
report, verdict or halt log. It does not change a single rule of the process it
describes: **no clause of the core says anything different after the split than
it said before**, and any place it does is a defect of the split, reportable as
one.

## 4. The one judgement inside the split, declared rather than buried

The commissioning verdict enumerates the core as "§1–§4, §6, Annex A, the
facsimiles, the failure classes" — an enumeration that does not name §5, the
failure museum. **§5 was kept in the core.** The grounds, stated so the decision
is reviewable rather than assumed:

- the verdict's own parenthesis names *the failure classes* as a core asset, and
  §5 is the failure classes collected and generalized;
- the same verdict's fence, carried from round 3, holds the museum and the
  rule-plus-failure-class dual statement **untouched**, which reads oddly as an
  instruction to relocate them;
- every reviewer of the first edition, including the hostile ones, certified §5
  as the part that transfers whole, and the adoption chapter's closing argument
  depends on it in terms: *the failure classes are not commentary on the rules,
  they are the export.*

**If the council meant §5 to move, this is the sentence to overrule**, and
moving it later costs one act, because the split's mechanism is stated and
repeatable. Recording the judgement here is the alternative to letting a
one-section scope difference pass as though nobody noticed it.

## 5. Failure modes shared by both decisions

- **The proposing seat is the constrained seat.** Both decisions are about this
  seat's own artifact, taken by this seat, recorded by this seat, in a file this
  seat can stage. That is the root class in one act, and the only structural
  answer is §7's route: the acceptance is not this seat's, and neither is the
  countersignature.
- **A record that arrives after the act it records normalizes the order.** The
  compensating control is that this file states, in its own status block, that
  both rules were already operating — which is what makes the lateness a
  measurable property rather than an invisible one.
- **Neither decision has a mechanical check, and none is proposed.** Both are
  claims about what an artifact is. There is no predicate a script could decide,
  which is `docs/PROCESS.md` §2.4(a)'s case exactly, so the posture is
  **review-enforced** and is declared here rather than implied.

## 6. Why no self-test case is owed

PROTOCOL §11(3) requires a new `scripts/test_protocol.sh` case only where a
change **alters enforcement semantics**. Nothing here does: no rule refuses
anything new, no rule refuses on a new surface, no posture moves, no script or
workflow is touched, and the scope table is unchanged. The two files this record
affects are documentation inside one seat's existing scope. **Stated explicitly
because an amendment record that is silent about §11(3) is indistinguishable
from one that forgot it.**

## 7. Countersignatures — owed, named, and the ledger that carries them

Per `docs/PROCESS.md` §3.5, a normative change is signed by a seat that did not
write it, the signature is asked of the constrained party, and refusal is a
legitimate outcome. **This file lands with both signatures OWED**, and the
acceptance act — which flips this record from proposed to in force — is the
orchestrator's, not this seat's.

| # | Signature owed from | On what, exactly | Status |
|---|---|---|---|
| 1 | **dv_lead** | Decision 1: that the re-scoped warranty is one the verification line recognizes as true of the artifact it has read, and that the *unit-level UNTESTED* statement in §2.3 is neither too strong nor too weak | **OWED** |
| 2 | **auditor** | Decision 2: that the split as executed loses nothing — verified against the fifth edition's committed text — and that the core's remaining stamp apparatus is not weakened by the move of its archaeology | **OWED** |
| 3 | **orchestrator** | The acceptance act itself (§3.6: a record proposes, a different seat accepts) | **OWED** |

**The precedent for rows 1 and 2** is every prior confirmation round on this
document: the seats whose disciplines a passage describes confirm that passage,
and their confirmations are recorded as entry ids. The difference this time,
stated because it matters: those were confirmations *of description*. **These are
countersignatures of a normative change**, and the question asked is §3.5's —
*is the guard exactly the rule, or is it wider?* — not *is this accurate*.

### 7.1 Owed-signature ledger

Per §3.5's ledger rule, this section is where movement in this record's own
clauses is tracked. It is opened empty, deliberately, so that its absence later
cannot be read as *nothing moved*.

| clause | what moved | whose signature the movement re-owes |
|---|---|---|
| — | nothing has moved since proposal | — |

## 8. Owed acts — the file touches this record does not make

1. **The status flip.** When the route of §7 completes, the status block is
   updated by an act of its own, citing the accepting and signing entries, with
   the original status preserved rather than rewritten.
2. **Nothing else.** This record amends no file it does not name, and proposes
   no text for any file outside the proposing seat's scope. That is unusual for
   a record in this program and is stated so that the absence of a
   *routed-not-performed* section is read as a fact rather than an omission.
