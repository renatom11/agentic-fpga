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

---

## Amendment A1 (2026-08-04) — the domain tier

**§§1–12 above stand unedited.** This section is an amendment in the sense
ADR-0003 established: what changed is recorded here rather than rewritten
silently upstream, so the original text and the reason it moved are both
readable in one file and one diff.

### A1.0 Authority, and what does not move

The sponsor extended the taxonomy this ADR assumed. Two directions, both relayed
by the orchestrator on 2026-08-04, quoted rather than paraphrased because they
are the acceptance authority for what follows:

> "there are three tiers — general lessons that improve the agent doctrines
> universally, project-specific lessons that rewrite the local project's
> doctrines but never leave it, and **domain-specific lessons** — portable
> across projects that share a technical domain but unstatable without domain
> vocabulary … this program's Ethernet/networking lessons would serve a future
> 25G NIC, and the generic would know to pull them in only if relevant."
> — Renato (sponsor), 2026-08-04

> "Maybe tier 1 general, tier 2 domain, tier 3 project specific makes the most
> sense"
> — Renato (sponsor), 2026-08-04, on the numbering

**Unmoved by this amendment**: LH1 and LH3, verbatim; the span discipline (§3.2);
self-mining and who mines (§3.3, §3.6); war stories being kept and re-offerable
(§3.5); collation as clerical and the collator's bar on editing statements
(§4.1); one shell commit per harvest (§4.2); sponsor refusal (§4.4); the
review-enforced posture and the refusal to mint an `R`-rule (§7.4); every
alternative rejected at §11.

**Reading rule for the original text.** Where §§1–12 say **LH2** they now mean
*LH2-g or LH2-d*, except at §3.4, which is the definition itself and is where
LH2-g's wording still lives verbatim. D3's "all three" reads: LH1, LH3, and LH2
*at one of its two grades*.

**One numbering hazard, named so it is not tripped over**: this ADR's §1.1
describes what is now **tier 3** and §1.2 describes what is now **tier 1**. Those
are section numbers and were never tier numbers; the sponsor's numbering is
descending generality and nothing above is renumbered.

### A1.1 The three tiers

| Tier | Name | The rule statement may name | Destination | Bar |
|---|---|---|---|---|
| **1** | general | nothing proper — no noun of any kind | the shell's `LESSONS`, universal set | LH1 · **LH2-g** · LH3 |
| **2** | domain | domain nouns; no project noun | the shell, in a **named domain pack** (`ethernet-10g`) | LH1 · **LH2-d** · LH3, **pack named** |
| **3** | project-specific | anything, project nouns included | stays here — the accretion tier of §1.1 | this ADR sets none; the tier's own instruments (ADRs, `C-` rows, `R-` rules, spec clauses) are its bar |

Tier 2 is the new one. It exists because the original bar had a dichotomy where
the corpus has a gradient: a rule can be true, useful, and portable to every
project that speaks a given protocol while being unstatable without naming that
protocol. Under the unamended bar such a rule was a war story — refused not for
being parochial but for being *specific*, which is not the same defect. Tier 2 is
the whole of that difference.

The sponsor's selector clause — *"the generic would know to pull them in only if
relevant"* — is what makes tier 2 cost nothing at the far end: a pack that a
later project does not pull in is inert, whereas a domain rule promoted into the
universal set would be noise in every project that does not share the domain. The
grade is therefore not a loosening of the shell's standard. It is a second
destination with its own admission rule, and the universal set's standard is
exactly what it was.

### A1.2 LH2 splits into two grades

**LH2-g (general)** — §3.4's bar, verbatim and unchanged. The rule statement
contains **no proper noun of any kind**: no module id, no requirement id, no
carry-forward id, no signal or port name, no protocol name, no toolchain or
library name; and it reads as a complete instruction to someone building a
different project with different agents. A candidate that passed LH2 before this
amendment passes LH2-g after it, with the same words.

**LH2-d (domain)** — the same statement discipline with one class of noun
readmitted.

- **Admissible**: **domain nouns** — protocol and standard names, interface
  standards, algorithm families, encodings and their like. Ethernet, XGMII, CRC,
  lane encoding, AXI-Stream are the sponsor's examples and this ADR's.
- **Still barred**: **project nouns** — module ids (`M03`), requirement ids
  (`REQ-###`), carry-forward ids (`C-##`), signal and port names, packet and
  work-order ids, journal-entry ids, and any path inside this repo.

**The discriminator, for a noun neither list settles.** The lists are examples,
and an example list that has to be exhaustive is a list that will be gamed. The
operative test:

> A **domain noun** is one that a different project, staffed by different agents,
> working in the same domain, would use in its own rule statement **without
> having to learn anything about this program**. A **project noun** cannot be
> understood without this repo.

Toolchain and library names sit on that boundary and the discriminator decides
them, not a standing verdict: such a name is a domain noun when the pack *is*
that ecosystem and the note names it as the pack, and a project noun when what it
actually carries is this program's lane, pin or version choice — which is
ADR-0004's subject and portable to nobody. The residual is at A1.8(4).

**The hide-the-provenance test applies to both grades, with the audience
parameterised.** §3.4's second test is not weakened for a domain candidate; it is
re-aimed. Hide the provenance, read the statement, and ask:

| Grade | The stranger who must still learn something |
|---|---|
| LH2-g | knows neither the domain nor this project |
| LH2-d | **knows the domain and not this project** |

A domain candidate that goes silent once the provenance is hidden has failed in
precisely the way a general one does: the nouns were carrying the meaning. The
only difference is which stranger is holding the page.

### A1.3 The classifier, as a decision procedure

Run on the **rule statement alone**, provenance hidden. LH1 and LH3 are prior —
a candidate failing either is a war story before the classifier is reached.

> **0.** Write the candidate's **most general honest statement**: the version
> with the fewest proper nouns that still says what happened.
>
> **1.** Does that statement contain a proper noun?
> **No** → **general candidate.** LH2-g passes. Id `LC-`. Stop.
> **Yes** → step 2.
>
> **2.** Is **every** surviving proper noun a domain noun (A1.2's discriminator)?
> **No** — at least one project noun is load-bearing → **tier 3.** Stop (A1.3.1).
> **Yes** → step 3.
>
> **3.** **Name the domain**, as a pack slug. Would a stranger recognise the name
> as a technical domain rather than as this program?
> **No** → **tier 3.** A candidate whose domain cannot be named is a project
> lesson in domain clothes. Stop.
> **Yes** → step 4.
>
> **4.** Hide the provenance and read it as a stranger who knows **that domain
> and not this project**. Does it still teach?
> **No** → **tier 3.** Stop.
> **Yes** → **domain candidate.** LH2-d passes. Id `LD-`, pack recorded. Stop.

**The routing tie-break, which is §7.3 doing double duty.** Step 0 is not
ceremony. Attempt the general statement first and run the hide test on *it*: if
the general statement survives, the candidate is **general** and the domain noun
was decoration. If the general statement goes hollow, that is §7.3's paraphrase
attack self-inflicted — and the hollowness *is the evidence* that the domain noun
was load-bearing, which is what routes the candidate to tier 2. The same test
that refuses a fake general statement is the test that promotes an honest domain
one. **LH2-d is reached only through a failed general statement, never instead of
attempting one.**

#### A1.3.1 Tier 3's fork: war story or local accretion

Tier 3 has two outcomes and they are not the same thing.

- **War story** — the rule binds nowhere. Kept, one line, naming the criterion or
  the classifier step it failed; re-offerable at a later harvest with new
  provenance (§3.5, unchanged).
- **Local accretion** — the rule is **adopted here**, as an ADR, a `C-` row, an
  `R-` rule or a spec clause, and binds this project. §1.1's tier, which this ADR
  did not touch then and does not touch now.

The fork is one question: **does this project want the rule?** A candidate that is
true and useful and simply cannot leave should be adopted locally, not filed as a
war story; a war story is what you write when the rule is not yet worth binding
anywhere. The harvest note **records** which — and the note does not itself
perform the adoption, which needs its own artefact and its own commit, under the
tier's existing instruments.

#### A1.3.2 What tier 2 rescues from the predicted refusals, and what it does not

The prediction the sponsor cites — *"the first refusals will be candidates that
are true, useful and unstatable without a module name"* — is recorded at
`J-architect_docs_lead-0028`'s Open-questions (this ADR's §11 is Alternatives;
the prediction's home is the journal entry that carried the ADR). It named the
class tier 2 exists for, and the class splits in three, worth being exact about:

1. **Unstatable without a *domain* noun** — a protocol's framing rule, a
   standard's alignment constraint, an encoding's error semantics. **Rescued**;
   this is exactly what LH2-d admits.
2. **Unstatable without a *module id*** — **not rescued.** A module id names this
   program's decomposition, not the domain, and step 2 refuses it. That was true
   before this amendment and is true after; the prediction's own wording names a
   project noun, and tier 2 does not reach it.
3. **The interesting middle** — candidates that look unstatable without a module
   id but are only unstatable without the module's **role**: *the block that
   terminates a frame*, *the stage that realigns a message across a word
   boundary*. A role is a domain noun, not a project one. Step 0's honest rewrite
   converts some predicted refusals into tier-2 passes by this route, and **the
   note should say when it did** — that count is the measurement of what the
   grade actually bought, and without it the amendment is unscoreable.

### A1.4 `LD-` — the domain-candidate id class

- A domain candidate carries the local id **`LD-<harvest-tag>-<n>`**, minted
  exactly as `LC-` is (§4.3), from a **sequence independent of `LC-`'s**, so that
  regrading one candidate before the note is written does not renumber its
  neighbours. `LC-SO-M03-1` and `LD-SO-M03-1` may coexist and are different
  candidates.
- **Regrade**: before the note is committed, a regraded candidate takes a fresh id
  from the other sequence and the note says so; ids are never reused. After the
  note is committed the id is fixed — the note lives in an append-only journal, so
  a later regrade is a **new** candidate at a later harvest, citing the old id.
- **The shell side stays the shell's.** §4.3's and §12's refusal is unamended and
  now covers one more thing: this repo does not legislate the shell's `L-` scheme,
  its `LESSONS` format, **or how packs are stored** — files, directories, tags,
  front-matter, all of it shell-side, and the shell's own history is its
  authority.
- **What this repo owes the shell for tier 2 is exactly one new field: the pack
  name.** The harvest note states it as a lowercase slug naming the **technical
  domain, not the program** — `ethernet-10g`, never `phase1-mac`. It is the only
  thing the sponsor's "pull in only if relevant" selector has to select on, which
  is what makes it the interface, and it is a bare name because a name is the
  smallest thing that can be one.
- **Against pack fragmentation**: the collator keeps the pack names already in use
  in the gate record and **reuses an existing name rather than minting a
  near-duplicate** (`ethernet-10g` / `10g-ethernet` / `ethernet` are one pack with
  three spellings and no selector can tell). Naming a pack is metadata, not the
  statement, so this sits inside the collator's clerical role and clear of §4.1's
  bar on editing candidates; when it normalises a name it says so in the gate
  record.
- **The gate record holds the pair**, `LD-…` ↔ `L-…`, plus the pack — §4.3's
  travel-in-either-direction property with one more column.
- **Near-collision, named because §10 claimed none.** The shell's existing id
  `L-D15` and the new local prefix `LD-` differ only in hyphen position. They do
  not actually collide: shell ids begin `L-`, local ids begin `LC-` or `LD-`, and
  §1.2's measurement command is unaffected —

  ```sh
  printf 'LD-SO-M03-1 LC-SO-M03-2 L-D15\n' | grep -oE "L-[A-Z]{1,3}[0-9]{1,3}"
  #    L-D15
  ```

  §10's "no collisions" line is therefore still true and is now also *checked*.

### A1.5 The checklist block gains a third disposition

`docs/gates/lessons-harvest-block.md` is amended in this commit, keeping its
copyable §3 block self-contained as before — a reader who copies the fence gets a
three-way classification without needing this ADR open. What changed there:

1. §2's bar table splits its LH2 row into **LH2-g** and **LH2-d**, with the
   parameterised hide-the-provenance test stated on each.
2. A new §2.1 carries A1.3's decision procedure in short form, so the classifier
   travels with the block.
3. The block's **Yield** table gains a **Grade** column (`LH2-g` / `LH2-d`) and a
   **Domain pack** column, and takes `LD-` ids alongside `LC-`.
4. The **War stories** table gains a **Tier-3 disposition** column separating *war
   story (kept, re-offerable)* from *local accretion (bound here, by its own
   artefact)* — A1.3.1's fork, made visible rather than inferred.
5. Three checklist boxes: the classifier was run on every candidate; every `LD-`
   names a pack; pack names were checked against those already in use.
6. §4's transcriber notes gain the grade-inflation signal and the pack-name rule.

**The first instantiation is `SO-M03`**, and it therefore classifies three ways
from the outset. No instantiation exists under the two-way form — verified: the
block file is the only file in the repo carrying the `Lessons harvest —` heading —
so **nothing is migrated and no committed harvest is regraded.** §9's statement
that `P1-module-ready` would be the first instantiation is superseded only as to
*which* trigger comes first; its reasoning (a new file, never an edit to a closed
gate) is untouched, and the closed gates are still not retro-harvested.

### A1.6 The PROTOCOL §7 diff — source text; applied by the orchestrator

**§8's rule governs this hunk too**: authored here, applied by the orchestrator
under its own identity and journal entry citing this section, **not** in this
commit — `agents/PROTOCOL.md` is outside the architect's write scope and ADR-0016
§8 settled that an ADR is not an exception to that.

§8's original hunk **is applied** at this commit; the paragraph is live at
`agents/PROTOCOL.md:268-286`. This diff therefore applies to the live text, and
it supersedes §8 **only** as to the LH2 clause and the sentence after the
collation sentence. Verbatim:

```diff
 the round; a lead also mines the worker spans it commissioned. A candidate rule
 is admissible only if it **(LH1)** cites the incident commit(s) that taught it,
-**(LH2)** states its observable in terms portable beyond this project — no
-module, requirement, signal, protocol or toolchain name inside the rule
-statement — and **(LH3)** says what breaks without it. Anything failing the bar
-is recorded as a war story and goes no further; a nil yield is declared, never
+**(LH2)** states its observable in terms portable beyond this project, and
+**(LH3)** says what breaks without it. **LH2 has two grades** (ADR-0018 §A1):
+**LH2-g** (general) admits no proper noun of any kind inside the rule statement;
+**LH2-d** (domain) admits domain nouns — protocol names, interface standards,
+algorithm families — but still bars every project noun (module, requirement,
+carry-forward, signal, or a path in this repo), and obliges the harvest note to
+name the domain pack the rule belongs to. Both grades are read with the
+provenance hidden: a general candidate must teach a stranger to the domain, a
+domain candidate a stranger to this project. Anything passing neither grade is
+recorded as a war story and goes no further; a nil yield is declared, never
 omitted. The **orchestrator collates**: into the gate record locally, and into
 the generic shell's `LESSONS` file with permalinked provenance, the shell
 unfreezing for **exactly one commit per harvest**, sponsor-visible at the gate —
-the sponsor may refuse a candidate. A gate is not passed while any box of the
-instantiated `docs/gates/lessons-harvest-block.md` is unchecked. *Enforcement*:
+the sponsor may refuse a candidate. **Routing**: a general candidate goes to the
+shell's universal set, a domain candidate to the pack its note named, which a
+later project pulls in only if that domain is its own. A gate is not passed
+while any box of the instantiated `docs/gates/lessons-harvest-block.md` is
+unchecked. *Enforcement*:
 review-enforced, like §10 — no `R`-rule is minted and no script changes, so
 §11(3) owes no test case (ADR-0018 §7.4).
```

**The hunk is machine-checked against the live file**, so the transcriber is not
re-deriving context by eye. Its header is `@@ -274,13 +274,22 @@`, and this
reproduces at this commit — the patch body is extracted from *this section*, so
the check is against the ADR's own text and not a retyped copy:

```sh
sed -n '/^### A1.6/,/^### A1.7/p' docs/adr/ADR-0018-*.md \
  | sed -n '/^```diff$/,/^```$/p' | sed '1d;$d' > /tmp/body.diff
{ printf -- '--- a/agents/PROTOCOL.md\n+++ b/agents/PROTOCOL.md\n@@ -274,13 +274,22 @@\n'
  cat /tmp/body.diff; } | git apply --check -v -
# Checking patch agents/PROTOCOL.md...   (exit 0)
```

**Still no test case owed.** No `R`-rule is minted, no script changes, no
enforcement semantics move — PROTOCOL §11(3) is untriggered for the same reason
§7.4 gave, and a grade split inside a review-enforced criterion is not a new
enforcement mechanism.

**Charters are not owed an edit.** §6 item 3's clause reads *"candidates with
LH1–LH3 discharged"*, which is still exactly true — the grades live inside LH2.
The five charter texts already supplied stand as written; nothing about this
amendment adds to the orchestrator's owed-transcription list except this hunk.

### A1.7 Downstream — for the board

1. **Owed, orchestrator-scope**: A1.6's hunk. It is the only new item. The three
   items already owed at `J-architect_docs_lead-0028` are unchanged in substance,
   and (a) — §8's hunk — is **discharged**: the paragraph is live, which is why
   A1.6 diffs against it rather than replacing it.
2. **`tasks/BOARD.md`**'s 2026-08-01 deferred-intent line, already owed a
   superseded-as-to-cadence clause (§10), should also record that the shell now
   has **two destinations**, universal and per-domain, so the end-of-program
   consolidation knows it is consolidating more than one set.
3. **§12 gains two items**: how packs are stored shell-side (the shell's, A1.4);
   and the parked question below.
4. **PARKED SPONSOR DECISION — federation governance. Recorded, not decided.**
   When the shell acquires contributors outside this org, lessons will arrive
   whose **provenance is not re-executable by us**: a permalink into a repo we
   cannot read, a SHA in a history we do not have, an incident no reader here can
   witness. LH1's operative test is *"a reader at the cited SHA can see the thing
   going wrong"* — and for a foreign lesson that reader may be nobody. The
   acceptance policy for foreign lessons is **the sponsor's**: whether an
   unreachable permalink satisfies LH1 at all; whether foreign lessons sit in a
   quarantined set until a second project reproduces the incident; who may refuse
   one; and whether a domain pack accepts contributions from projects outside the
   one that opened it. **Owed before the shell's first outside contributor, not
   before our harvests** — every harvest this program runs writes provenance we
   can re-execute, so no harvest, gate or sign-off is blocked on it. It is
   recorded now for one reason: tier 2 is what makes the question live, because a
   domain pack is the artefact most likely to attract outside contribution — a
   domain contains more projects than this program does — so the first foreign
   lesson will very probably arrive at a pack rather than at the universal set.

   **The sponsor's intended shape, recorded as shape and not as decision**
   (2026-08-04, relayed): downstream use of the generic shell **carries a
   mandatory lessons harvest** — already this org's law under D1 and PROTOCOL §7,
   and the sponsor's analogy for extending it outward is *"agree to send data
   back"*. Transmission upstream is **default-on via a staged pipeline**:

   > "the changes could be staged, reviewed by an agent to make sure its all
   > relevant to improving the agents, and then committed to the generic"
   > — Renato (sponsor), 2026-08-04

   Four properties the sponsor attaches to that pipeline, recorded verbatim in
   substance so the eventual decision starts from them rather than from scratch:

   - **(a) Automated up to, but never through, the merge.** `LESSONS` is
     **constitution-adjacent text that future agents obey** — a foreign
     contribution to it is therefore a **prompt-injection surface**, not merely a
     quality risk, and an agent reviewer is exactly the wrong last line against an
     input designed to address agent reviewers. **The final merge stays human.**
     This is the same principle the org already runs on at sponsor-signed gates:
     machinery prepares, a human admits.
   - **(b) Self-contained incident description in lieu of permalinks.** Foreign
     provenance will often be a private repo, so the permalink mechanism of §4.2
     cannot cross the boundary. **LH1's test survives; its mechanism is
     substituted**: the foreign lesson carries an incident description complete
     enough that *a reader of the description* can see the thing going wrong,
     where our own lessons make *a reader at the SHA* do it. The cost is stated
     plainly: a description can be read but not re-executed, so the
     quarantine-until-reproduced option above becomes **more** load-bearing under
     (b), not less — and it is one of the things the pipeline's agent reviewer
     provably cannot check, which is (a)'s argument again from the other side.
   - **(c) The generality bar doubles as the outbound disclosure filter.**
     Tier 1's noun-stripping is already an anonymisation: a statement with no
     proper noun of any kind discloses no employer, product, module or customer.
     **Tier 2 reveals exactly one thing — the domain** — which is the minimum a
     selector needs to decide relevance. LH2-g and LH2-d were minted as a
     generality bar (A1.2) and turn out to be a disclosure bar on the same test;
     that coincidence is not an accident but it is also not yet a guarantee, and
     the sponsor's decision is where it becomes one.
   - **(d) An exception path for shops that cannot share.** Default-on is not
     mandatory-on: some downstream users will be unable to transmit anything, for
     policy reasons that have nothing to do with the lesson's quality. The
     exception path is owed a shape — opt-out, hold-local, or harvest-without-
     transmit — and which of those it is, is part of this same parked decision.

   Named here so the first outside contribution meets a decision instead of an
   improvisation. **Nothing in this sub-item is in force**; it is the sponsor's
   sketch of an answer to a question he has parked, and this ADR neither adopts
   nor amends anything by recording it.

### A1.8 Failure modes new to the domain grade

1. **The domain that is one project wide.** A pack named for a domain only this
   program inhabits is tier 3 with a slug on it. The sharpened form of step 3:
   **name a plausible second project in the domain.** The sponsor's own example
   does exactly this ("a future 25G NIC"). A pack whose second project cannot be
   named is a finding shape for the auditor, not automatically a finding.
2. **Grade inflation.** LH2-d is easier to pass than LH2-g and will therefore
   attract candidates that should have been generalised. The guards are step 0
   and the routing tie-break: the domain grade is reachable only *through* a
   general statement that was attempted and went hollow. The signal, symmetric to
   §3.5's *"a bar nothing fails does not select"*: **a harvest whose yield is all
   `LD-` and no `LC-` says something about the miner, not about the domain.**
3. **Pack fragmentation.** A1.4's collator rule is the guard; residual risk
   accepted, since a duplicate pack name is a shell-side cleanup and not a reason
   to refuse a rule at minting.
4. **The domain noun that is a project fact in disguise.** A protocol named where
   what is really meant is *this repo's interpretation of that protocol at a spec
   section*. Step 4 is aimed here and is the reason its stranger holds the
   standard but not our specs: a rule that only makes sense against our spec goes
   silent for a reader who has the standard, which is the refusal we want.
5. **Federation** — A1.7(4), parked with the sponsor, and the only failure mode
   here whose answer is not in this document.
