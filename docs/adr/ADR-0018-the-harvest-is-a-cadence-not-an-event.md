# ADR-0018: the lessons harvest is a cadence, not an event

- **Status**: **ACCEPTED** on the sponsor's own direction, which is the
  acceptance authority for this ADR and is quoted in full at §1:

  > "not a one time thing we do but something we continually do... build this
  > into our general philosophy."
  > — Renato (sponsor), 2026-08-04, relayed by the orchestrator

  The shape codified below — per-sign-off and per-gate self-mining, three
  refusable criteria, orchestrator collation into the gate record and into the
  generic shell's `LESSONS` file, one shell commit per harvest, sponsor-visible
  at the gate — is the sponsor's, not this ADR's invention. What this ADR adds
  is the exact wording of the bar, the span discipline that makes a skipped
  harvest visible, the enforcement homes, and one extension of the sponsor's
  shape — §3.3's widening of "each lead" to every persistent journal chain —
  which is marked there and at §11(8) as this ADR's own decision, refusable on
  its own without disturbing anything else.
- **Deciders**: **sponsor** (direction and acceptance); **orchestrator** (adoption
  and transcription of §8 and §9's homes). Not an escalation class raised from
  below — it arrives from above. It is nonetheless E2-adjacent in kind (it adds a
  standing duty to every lead), which is why the acceptance authority is quoted
  rather than paraphrased.
- **Proposed by**: sponsor direction, relayed by the orchestrator.
- **Work order**: none · **Journal**: `J-architect_docs_lead-0028`
- **Affects**: `agents/PROTOCOL.md` §7 (§8's diff — **written here, applied by
  the orchestrator**); `docs/gates/lessons-harvest-block.md` (**new, lands with
  this ADR**); `agents/charters/*.md` §8 and `tasks/BOARD.md`'s 2026-08-01
  deferred-intent line (**owed, orchestrator-scope, texts supplied at §7**); the
  generic shell's `LESSONS` file (**another repo; this ADR does not legislate its
  format**). **No frozen spec text, no requirement, no interface record, no
  enforcement script, no closed gate checklist.**

---

## 1. Context — one tier works, the other has never run

The sponsor's direction, in full, is the Status block's quotation. It is a
directive about **cadence**: the practice itself was not in dispute, its
frequency was.

### 1.1 What already works, and is not touched here

This org has a functioning **in-flight accretion tier**: an incident produces a
rule, and the rule becomes binding inside this project within hours. The record
is unambiguous —

- `R-SEAL-1` (ADR-0016) exists because one packet claimed a seal it had not
  committed.
- `R10`/`R11` and the journal chain (ADR-0017) exist because a commit was refused
  by a blob gate whose stated remedy could not apply to the one artefact class
  the protocol requires in every commit.
- The carry-forward ledger `C-1 … C-50` in `docs/gates/P1-spec-freeze-checklist.md`
  is fifty incidents, each carried on a named artefact with a stated closure gate.
- The seal rule minted at `WO-0055` — *a sealed cell grounded on a DUT-state claim
  must cite the stimulus fact establishing that state, or be marked unworked* —
  went from campaign finding to standing rule inside one adjudication.

**None of that changes.** This ADR adds no obligation to the accretion tier and
retracts none of its rules.

### 1.2 What has never run

The **cross-project tier** — the extraction of rules that outlive this program —
exists today as one line on the board, dated 2026-08-01:

> Deferred intent on record: at program end, extract the generic
> (project-agnostic) workflow from this org using accumulated ADRs/journals as
> the lessons-learned source.

Its realised yield to date is measurable, and the measurement is one command:

```sh
# At this ADR's parent commit — before this document starts citing the id itself:
grep -rnoE "L-[A-Z]{1,3}[0-9]{1,3}" agents/ docs/ tasks/ | awk -F: '{print $NF}' | sort | uniq -c
#    1 L-D15

# At this commit the same command counts higher: this ADR and the journal entry
# carrying it now cite the id too, and a self-counting measurement is not stable
# under its own edits. The substantive count — the journal corpus, minus this
# round's own citations — is unchanged, and this form reproduces here:
grep -rl "L-D15" agents/journals/ | grep -v architect_docs_lead
#    agents/journals/claude_orchestrator_agent.md
```

**One lesson id, appearing exactly once**, inside an orchestrator journal entry
(`J-orchestrator-0144`) that describes the discipline as *"just woven into my own
shell charter, caught here in the flesh"*. That is the whole visible cross-project
harvest of a program that has produced fifty carry-forward rows, eighteen ADRs and
a quarter of a million words of journal. The tier is not failing — it has not been
scheduled.

### 1.3 Why per-gate, and not per-program

Four arguments, in descending order of force.

1. **The reasoning is hot at the gate and cold at the end.** A lead mining its own
   span days after writing it still holds the model the entry compresses. At
   program end a fresh session reads the same words with none of that model, and
   what it can recover is the prose, not the reasoning the prose was a receipt for.
2. **Volume defeats a single pass.** ADR-0017 §1.1 measured the corpus at
   **2,131,151 bytes across 249 entries** — and that was before Phase 1's benches.
   One end-of-program pass over a corpus that size is a summarisation task, and
   summarisation of one's own reasoning at scale selects for what is *memorable*,
   not for what was *load-bearing*. Twenty small passes select differently from one
   large one, and the difference is the point.
3. **Provenance decays.** LH1 below requires the incident commit. Pinning it is
   trivial twenty entries back and expensive four hundred entries back — expensive
   enough that a deferred harvest quietly drops the criterion, which is exactly how
   a lesson decays into a preference.
4. **A deferred harvest has the shape of an unredeemed promise.** It is not caught
   by `R-SEAL-1` — that rule governs *withheld results*, and a lessons harvest
   withholds nothing that exists yet, so this is a forward commitment in ADR-0016
   §2.3's sense. But the failure mode the rule was written against is the same one:
   value claimed now and produced never. §10 of ADR-0016 names the cure for a
   forward commitment as *the later commit that redeems it*. **A cadence is a
   schedule of redemptions.**

---

## 2. Decision

- **D1.** Every module sign-off (`SO-`) and every phase gate carries a **lessons
  harvest**. It is a precondition of the gate, not a follow-up to it.
- **D2.** Each agent holding a persistent journal chain **mines its own journal**
  over the span since its last harvest. No agent mines another's on its behalf.
- **D3.** A candidate rule is admissible only if it discharges all three of
  **LH1** (provenance-pinned), **LH2** (portable observable), **LH3** (stated
  failure). The criteria are **refusable**: anything failing any of them is
  recorded as a **war story** and goes no further.
- **D4.** The yield is recorded as a **harvest note** inside the mining agent's
  journal entry for the round — no new file class. A **nil yield is declared**,
  never omitted.
- **D5.** The **orchestrator collates**: locally into the gate record, and
  cross-repo into the generic shell's `LESSONS` file with **permalinked
  provenance**. The shell unfreezes for **exactly one commit per harvest**.
- **D6.** The harvest is **sponsor-visible at the gate**, and the sponsor may
  refuse a candidate. The shell commit is not a fait accompli.
- **D7.** Enforcement is **review-enforced**, in three homes: PROTOCOL §7 (§8's
  diff), the instantiable gate block at `docs/gates/lessons-harvest-block.md`
  (§9), and charter §8 obligations (owed, §7 item 3). **No `R`-rule is minted and
  no enforcement script changes** — PROTOCOL §11(3) is therefore not triggered,
  and §7.4 below argues that this is a choice rather than an omission.

---

## 3. The practice, exactly

### 3.1 Triggers

| Trigger | Fires when |
|---|---|
| Module sign-off | The commit carrying an `SO-<module>.md` with a PASS verdict |
| `P<n>-spec-freeze` | Before the checklist's sign-off section may be completed |
| `P<n>-module-ready` | Same |
| `P<n>-phase-accept` | Same; the harvest rides the E1 escalation packet |

`G0` is once and passed; it is not retro-harvested.

### 3.2 The span, and why it is an interval

The span runs from **the entry after the last harvested entry** to **the last
entry before the harvest note**, over the mining agent's own journal *chain* —
volumes are a storage fact (ADR-0017), not a span boundary. The first harvest's
span opens at the agent's first entry.

It is **stated in the note as an entry-id interval** — `J-<agent>-NNNN …
J-<agent>-MMMM`. This is the whole span discipline and it buys two things:
consecutive harvests **tile** (no entry is mined twice, none is skipped), and a
**skipped harvest is a visible gap** rather than an absence nobody can see. An
agent that produced no entries in a window says so with an empty interval; that
is different from not harvesting.

### 3.3 Who mines

**The sponsor's floor**: each lead, over its own journal.

**This ADR extends the floor** to every agent holding a persistent journal chain —
the three leads **plus the auditor and the orchestrator**. Marked as this ADR's own
decision so it is refusable separately from the sponsor's shape. Three reasons:

1. **The one lesson id in the repo came from an orchestrator entry.** `L-D15` was
   mined out of `J-orchestrator-0144`'s lane. A rule that exempts the orchestrator
   exempts the source of the only datum we have.
2. **The auditor's journal is where method lessons live** — the mutation-campaign
   discipline, the seal-scoring rules, the relay-fidelity checks. Those are the
   most portable material in the corpus, because the auditor's subject matter is
   the *process*, which is precisely what the shell is.
3. **§3.6's rationale applies to them identically.** If self-mining is right
   because only the author knows what was load-bearing, that is not a property of
   being a lead.

**Workers do not self-mine.** Worker journals are shared per template with
per-spawn entries (PROTOCOL §4) and no continuous identity, so there is no "span
since my last harvest" for a worker to hold. **The commissioning lead mines the
worker spans it commissioned**, and says in its note which spawn short-ids it
covered.

### 3.4 The bar — three refusable criteria

**LH1 — provenance-pinned.** The candidate cites **the incident commit(s) that
taught it**: a SHA, plus the journal entry or packet that adjudicated it.
*Test*: a reader at the cited SHA can see the thing going wrong. A rule whose
teaching incident cannot be named is not a lesson, it is a preference — and a
preference in a shell is worse than nothing, because the next project inherits it
without the argument.

**LH2 — portable observable.** The rule statement says **what is observable**, in
terms that survive translation out of this project. This is the sponsor's standing
generality guard for the shell, applied **at minting rather than at transcription**
— cheaper, and it keeps the shell's file clean by construction instead of by
cleanup.

*Operational test, deliberately mechanical enough to argue with*: the **rule
statement** contains **no proper noun of this program** — no module id (`M03`), no
requirement id (`REQ-###`), no carry-forward id, no signal or port name, no
protocol name (XGMII, ARP, MoldUDP64, ITCH), no toolchain or library name — and
reads as a complete instruction to someone building a **different** FPGA project
with **different** agents. The project-specific detail belongs in LH1's citation;
provenance is where the nouns live.

*Second test, for the paraphrase attack*: read the statement **with the provenance
hidden**. If it no longer says anything, the nouns were carrying the meaning and
swapping them out did not generalise the rule — it hollowed it.

**LH3 — stated failure.** The candidate says **what breaks without it**: the
concrete bad outcome the rule prevents, not the virtue it embodies. "Be careful
with counters" fails. "Without this, a frame's report is a function of the
characters that happen to follow it rather than of the frame" passes — the failure
is one a reviewer could recognise in someone else's repo, which is the test.

### 3.5 What a failure is, and why war stories are kept

Anything failing any of LH1–LH3 is recorded in the harvest note under a
**war stories** heading, one line each, **naming which criterion it failed**, and
is not transcribed to the shell.

They are **kept, not deleted**. A candidate that fails LH2 at its first incident
frequently passes at its second, because the second provenance shows which half of
the statement was project-specific — the half that did not recur. Guidance, not
law: a war story may be re-offered at any later harvest with its new provenance
attached, and the re-offer cites the harvest that refused it.

**A bar nothing fails does not select.** A harvest note whose war-stories section
is empty at every round is a signal about the bar, not about the span.

### 3.6 Why self-mining, and why it is not marking your own homework

Two reasons, and the second is the load-bearing one.

1. **Only the author knows which entries were load-bearing.** A third-party miner
   reads the same prose without the model that produced it, and selects for what
   reads dramatically. The entries that taught the most in this corpus are not the
   dramatic ones.
2. **These agents have demonstrated willingness to convict their own work, and
   that willingness is the quality gate.** It is not a hope; it is in the record.
   `C-42`, `C-44` and `C-48` are labelled *dv self-report*. Family G's `G-2` — the
   round's most valuable finding — is a **forty-entry-old verification error in
   dv's own benches**, surfaced by dv's own blinded seeder and reported by dv.
   `J-architect_docs_lead-0025` **sustains rtl_lead's E5 against the architect's
   own ruling**. An org that does that on its own artefacts can be trusted to mine
   its own journal; an org that does not, could not be trusted to mine anyone's.

**The countervailing risk is real and is named**: an agent may not mine the lesson
that convicts it. The answer is not to move the mining — it is the **auditor**,
which already samples journals and may file a finding naming a harvest that missed
a lesson its own span contains. That is the existing sampling duty pointed at a new
artefact, not a new duty.

---

## 4. Collation — two destinations, one authority

### 4.1 Locally, into the gate record

The orchestrator collates every agent's harvest note into the gate record — the
gate checklist for a phase gate, the sign-off section for an `SO-` — as one table:
candidate id, one-line statement, mining agent, journal entry, disposition
(transcribed / war story / sponsor-refused).

This is **clerical transcription in exactly PROTOCOL §7's sense**. Authority is the
mining agent's own journal entry; the checklist edit commits under
`Agent: orchestrator`; the collator adds no candidates of its own to another
agent's note. (It mines its own span in its own note, under §3.3, and that note is
collated like everyone else's.)

### 4.2 Cross-repo, into the generic shell

Admissible candidates are transcribed by the orchestrator into the generic shell's
`LESSONS` file with **permalinked provenance** — each entry carries a permalink to
the incident commit in this repo, so a reader of the shell reaches the evidence
without this repo attached. LH1 is what makes that link possible; a shell entry
whose provenance is a bare assertion is the thing this ADR exists to prevent.

**The shell is frozen between harvests and unfreezes for exactly one commit per
harvest.** One commit is what makes the shell's history *a list of harvests*
rather than a stream of edits — and what makes the sponsor's review tractable: at
the gate, one diff.

### 4.3 Ids

The shell's `L-` scheme is the **shell's**, allocated there by the orchestrator at
transcription time. Candidates carry a local id `LC-<harvest-tag>-<n>` (harvest tag
= the gate name or `SO-<module>`) until then, and the gate record records the
**pair** once the shell commit lands, so a reader can travel in either direction.

**This ADR does not define the shell's id scheme or file format.** Defining it here
would be this repo legislating for a repo it does not own, and the shell's own
history is its authority.

### 4.4 Sponsor ratification

At `P<n>-phase-accept` the harvest rides inside an E1 packet the sponsor already
signs. At gates the sponsor does not personally sign, the harvest table is in the
checklist and the shell diff is one commit — ratification means the sponsor **may
refuse a candidate**, and a refusal is recorded in the gate record's disposition
column. What a refusal converts the candidate into is left open at §13.

---

## 5. Who does what

| Actor | Does | Does not |
|---|---|---|
| Each lead; auditor; orchestrator | Mines **its own** span; writes the harvest note in its own journal entry; discharges LH1–LH3 per candidate; declares nil yield explicitly; a lead additionally mines the worker spans it commissioned | Transcribe to the shell; edit the gate record; mine another persistent journal |
| orchestrator (as collator) | Collates notes into the gate record; transcribes admissible rules to the shell in **one** commit with permalinks; allocates the shell's `L-` ids; records the `LC-`/`L-` pair; declares the harvest complete | Add candidates of its own to another agent's note; edit a candidate's statement (a defective statement is bounced to its author) |
| sponsor | Ratifies at the gate; may refuse a candidate | — |
| auditor | Mines its own span; **samples** harvests for lessons a span contains and its note missed, and for candidates transcribed despite failing the bar | Edit any harvest note or gate record — PROTOCOL §6 keeps it to `docs/reports/audit/**` |

---

## 6. Enforcement homes

1. **`agents/PROTOCOL.md` §7** — the obligation itself. §8 carries the exact text;
   the orchestrator transcribes it (ADR-0016 §8's mechanic).
2. **`docs/gates/lessons-harvest-block.md`** — the instantiable checklist block,
   landing with this ADR (§9). A gate checklist that omits it is visibly missing a
   section; a gate whose instantiated block has an unchecked box is not passed.
3. **Charters** — each persistent-journal agent's §8 gains the harvest-note
   obligation. **Not in this commit**: `agents/charters/**` is orchestrator-scope
   (PROTOCOL §6, R7). The text owed, identical for each of the five:

   > - **Harvest notes**: at every `SO-` and every phase gate, the journal entry
   >   for the round carries a lessons-harvest note — span as an entry-id
   >   interval, candidates with LH1–LH3 discharged, war stories with the
   >   criterion each failed, or an explicit nil yield (ADR-0018, PROTOCOL §7).

   `tasks/BOARD.md`'s 2026-08-01 deferred-intent line is also owed a clause; §11
   states what it should say.
4. **Not mechanical, deliberately.** See §7.4.

---

## 7. Failure modes

### 7.1 The theatre harvest

Candidates minted to fill a table. Three things push against it: LH1–LH3 make a
candidate **expensive** (a provenance SHA must actually show the incident); a
**nil yield is explicitly legitimate**, so there is no pressure to produce; and the
auditor samples. Residual risk accepted — a program that cannot tell a lesson from
a sentence has a larger problem than this ADR.

### 7.2 The self-exculpating harvest

The lead does not mine the lesson that convicts it. §3.6's answer, plus a shape
worth naming for the auditor: **a span containing a self-reported defect, whose
harvest note contains no self-critical candidate, is a finding shape.** Not
automatically a finding — the defect may have taught nothing portable — but the
note should say which.

### 7.3 LH2 gamed by paraphrase

A project-specific rule with the nouns swapped for placeholders. §3.4's second test
(read it with the provenance hidden) is aimed exactly here, and it is the test the
transcriber should run, because the transcriber is the reader who has the shell's
audience in mind.

### 7.4 The temptation to make it countable

A script could count harvest notes per gate. It **could not tell a harvest from a
shrug** — the same reason `R-SEAL-1` is review-enforced (ADR-0016 §6.3), stated
there as *the rule makes seals countable, not good*. Worse, a count creates an
incentive to produce **candidates** rather than lessons, which is the precise
incentive LH1–LH3 exist to remove. So: no `R12`, no `test_protocol.sh` case, and
PROTOCOL §11(3) is not triggered because no enforcement semantics move. An
advisory count remains possible for a future ADR to propose; it is **not** proposed
here, and its absence is not an oversight.

### 7.5 The word "harvest" is already taken

In this repo "harvest" means a mutation-campaign or promotion-block harvest
(`J-orchestrator-0106`, the family-G board row). The collision is real. **Every use
of the new sense is qualified "lessons harvest"; the bare word keeps its old
meaning.** Named here so a future reader finds a decision rather than an ambiguity.

### 7.6 The shell and the local record diverge

A rule transcribed and later edited in the shell. The permalink runs one way, so
the gate record holds the **pair** (§4.3) and the shell entry is always traceable
back to the note that minted it. Editing a shell entry is a shell-side matter this
ADR does not reach.

---

## 8. The PROTOCOL diff — the source text; applied by the orchestrator

**This section is the authority; the edit to `agents/PROTOCOL.md` is clerical.**
The hunk below is authored here and applied to the constitution by the
**orchestrator**, under `Agent: orchestrator` with its own journal entry citing
this section as the source. It is **not** in this ADR's commit — `agents/PROTOCOL.md`
is outside the architect's write scope, and ADR-0016 §8 settled that there is no
ADR-driven exception to that: *an agent that can amend the protocol by citing its
own ADR can amend the protocol.*

One addition, at the end of **§7 (Gates)**, after the "Phase hardening" paragraph
at `agents/PROTOCOL.md:266`. §7 is the right home because both triggers are gate
triggers, the transcription mechanic it already states is the one §4.1 reuses, and
the sign-off half reaches `SO-` by naming it rather than by a second hunk in §3.

```diff
 **Phase hardening**: "P\<n\> hardening" means the window between
 `P<n>-module-ready` and `P<n>-phase-accept`. It is the activation window for
 `formal_dv` and the overlap trigger for the contingent `rtl_lead_md`.
+
+**Lessons harvest** (ADR-0018). Every module sign-off (`SO-`) and every phase
+gate carries one; it is a precondition of the gate, not a follow-up to it. Each
+agent holding a persistent journal chain — the leads, the auditor, the
+orchestrator — mines **its own** journal over the span since its last harvest,
+stated as an entry-id interval so that spans tile and a skipped harvest is a
+visible gap, and records the yield as a harvest note in its journal entry for
+the round; a lead also mines the worker spans it commissioned. A candidate rule
+is admissible only if it **(LH1)** cites the incident commit(s) that taught it,
+**(LH2)** states its observable in terms portable beyond this project — no
+module, requirement, signal, protocol or toolchain name inside the rule
+statement — and **(LH3)** says what breaks without it. Anything failing the bar
+is recorded as a war story and goes no further; a nil yield is declared, never
+omitted. The **orchestrator collates**: into the gate record locally, and into
+the generic shell's `LESSONS` file with permalinked provenance, the shell
+unfreezing for **exactly one commit per harvest**, sponsor-visible at the gate —
+the sponsor may refuse a candidate. A gate is not passed while any box of the
+instantiated `docs/gates/lessons-harvest-block.md` is unchecked. *Enforcement*:
+review-enforced, like §10 — no `R`-rule is minted and no script changes, so
+§11(3) owes no test case (ADR-0018 §7.4).
 
 ## 8. Escalation to the human sponsor
```

**Nothing here makes this ADR self-ratifying**: the sponsor's direction is the
acceptance authority for the *practice*, an accepted ADR is a precondition of the
*amendment*, and neither is a substitute for the orchestrator making it. The pair
must be read together in `git show` — the rule and its argument land in the
architect's commit, the constitution's text in the orchestrator's next one. That
is the cost ADR-0016 §8 chose, and it is still worth paying.

---

## 9. The gate-checklist hook — where it lands, and why not where it doesn't

**Where it lands**: a **new** file, `docs/gates/lessons-harvest-block.md`,
committed with this ADR — a reusable block that every future gate checklist and
every `SO-` sign-off section instantiates verbatim, with the boxes a gate cannot be
declared passed without.

**Why not an edit to an existing checklist.** `docs/gates/` holds exactly two files
and **both are closed**:

- `G0-checklist.md` — *"G0: PASSED — 2026-08-01. All 11 items signed."*
- `P1-spec-freeze-checklist.md` — *"P1-spec-freeze: CLOSED 2026-08-02T16:53Z"*,
  with the sponsor's verbatim signature transcribed above it.

Adding a harvest box to either would land one of two ways, and both are worse than
a new file: **unchecked**, which retroactively un-passes a gate the sponsor signed
and whose evidence is complete; or **pre-checked**, which records a harvest nobody
ran. So the hook is an **addition to `docs/gates/`, not an edit to a closed gate** —
exactly the disposition the dispatch anticipated, stated here so it is on the
record rather than inferred.

**The next instantiation is `P1-module-ready`**, whose checklist does not exist yet;
it is authored with the block in it. Every `SO-<module>.md` sign-off section
instantiates it too. Retroactive harvesting of the closed gates is **not** ordered:
their spans are mined at the *next* harvest by the interval rule of §3.2, because
each agent's first span opens at its first entry. Nothing is lost by not reopening
them — which is the argument for the interval discipline in miniature.

---

## 10. Consequences

- **A real recurring cost, stated plainly.** One journal section per persistent-
  journal agent per trigger, plus one orchestrator collation and one shell commit
  per harvest. Phase 1's shape (20 modules → up to 20 `SO-` plus three gates) makes
  that dozens of rounds. That cost **is the directive**: "something we continually
  do" priced honestly is a per-gate obligation, and pretending otherwise would be
  the accretion tier wearing a new name.
- **The board's deferred intent is superseded as to cadence, not as to goal.** The
  end-of-program extraction still happens; it now consolidates a shell already
  populated by dozens of provenance-pinned rules instead of building one from a
  cold two-megabyte corpus. `tasks/BOARD.md`'s 2026-08-01 line should gain: *"—
  superseded as to cadence by ADR-0018: harvested per gate and per sign-off; the
  end-of-program pass consolidates rather than extracts."* Orchestrator-scope, owed.
- **The shell's `LESSONS` file becomes the org's only artefact with a cross-project
  audience.** LH2 is what keeps it that way, and it is the criterion most likely to
  be argued about — which is the correct place for the argument to happen.
- **New vocabulary, no collisions**: `LC-` candidate ids and `LH1`–`LH3` are new;
  `R`, `C-`, `REQ-`, `AUD-`, `SO-`, `X-` and the shell's `L-` are untouched. The one
  collision that exists is on the English word, and §7.5 disposes of it.
- **A gate acquires a precondition that can fail.** That is intended: a gate whose
  every precondition always passes is not a gate.

---

## 11. Alternatives considered

1. **Per-program harvest** (the status quo ante — the board's deferred intent).
   **Rejected**: it is the thing the directive names. §1.3's four decay arguments
   are the substance; the sponsor's sentence is the authority.
2. **Cross-mining — each lead mines another lead's journal.** **Rejected.** It
   *looks* more independent and is worse: the miner reads prose without the model
   that produced it and selects for the memorable (§3.6.1). Independence is bought
   instead where this org already buys it — the auditor's sampling — which costs
   nothing extra and grades no one's own work.
3. **The orchestrator mines everyone.** **Rejected** for (2)'s reason, plus a
   structural one: it makes the **collator the selector**, and collation is the one
   role in this design that must stay clerical (§4.1). A selector-collator can
   shape the shell without anyone's note showing it.
4. **A new file class in this repo (`docs/lessons/`, or `LESSONS-candidates.md`).**
   **Rejected**: a new file class needs a write scope, a numbering authority and a
   lifecycle. The journal already has all three, and `R2` already binds the note to
   the commit that carries the work. The harvest note rides for free.
5. **Continuous harvest — mine at every commit.** **Rejected**: per-round yield
   falls below the noise floor, and an obligation that fires constantly becomes
   ceremonial. The criteria are what make a candidate expensive; firing them
   hourly makes them cheap.
6. **A mechanical gate (`R12`, or a `test_protocol.sh` case).** **Rejected** —
   §7.4. Countable is not good, and counting creates the incentive the bar exists
   to remove.
7. **Keep the shell continuously unfrozen.** **Rejected**: one commit per harvest is
   what makes the shell's history readable as a list of harvests and the sponsor's
   review a single diff. A stream of edits is reviewable by no one.
8. **Mine only the leads (the sponsor's floor, unextended).** **Rejected** at §3.3,
   and marked there as this ADR's own decision so the sponsor can put it back.

---

## 12. What this ADR does not decide

- **The shell's `L-` id scheme, its `LESSONS` file format, or its organisation.**
  The shell's, not this repo's (§4.3).
- **Whether a refused candidate becomes a war story or is refused outright.** The
  first sponsor refusal sets the precedent; the disposition column records what
  happened either way (§4.4).
- **Whether a nil-yield harvest is itself a finding shape for the auditor.** Named
  at §7.1/§7.2, not decided. It plausibly depends on span length, and no one has
  the data yet.
- **Retroactive promotion of war stories** beyond §3.5's guidance — the re-offer
  path is stated as practice, not as an obligation on anyone to revisit the pile.
- **Whether the contingent Phase-2 `rtl_lead_md` is bound.** It would be, as a lead,
  by §3.3's rule the moment it is activated; no separate decision is needed, and its
  charter text rides with §6 item 3's owed charter edits.
- **Anything about the accretion tier** — carry-forward rows, ADRs, in-flight rule
  minting. §1.1 is a description, not a re-ratification.
