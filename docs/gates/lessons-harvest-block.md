# Gate block: lessons harvest (ADR-0018)

**Reusable — this file is a template, not a gate.** Every phase-gate checklist in
`docs/gates/` instantiates §3's block **verbatim**, filling the bracketed fields.
Every `SO-<module>.md` sign-off section instantiates the same block with **one
prescribed substitution**: Part B's four collation boxes are replaced by the
deferral line §3 carries for that purpose. **A gate is not passed while any box in
the instantiated block is unchecked** (PROTOCOL §7). **A module sign-off
instantiates Part A only** — the seven mining boxes — **and is not complete while
any of them is unchecked**; Part B's four collation boxes are the collator's acts
at the gate that ratifies the harvest, and appear in an `SO-` as a named deferral
line, never as boxes (ADR-0018 §A2.2). *Until 2026-08-11 the first sentence said
"and every `SO-<module>.md` sign-off section instantiates §3's block verbatim",
which the sentence three lines below it contradicts: an `SO-` that copied the
block verbatim would render four boxes ADR-0018 §A2.2 forbids it to render, and
would be incomplete on all four for the life of the packet. "Verbatim" is true of
a gate and false of a packet, and it is now said of each separately* (ledger item
44, `J-architect_docs_lead-0043`). *From 2026-08-17 every destination below is
**local**: tier 1 and tier 2 both land in this repository's own
`docs/LESSONS.md` — the travel copy. The 7/4 partition is unchanged in count —
no Part A box moves, and within Part B the sponsor-visibility box retires with
the transit it observed and its seat is taken by the dedup box (ADR-0023).*

Nothing here is signed. This file never records a harvest; instantiations do.

---

## 1. How to instantiate

1. Copy §3's fenced block into the gate checklist (or the `SO-` packet's sign-off
   section) under the heading `## Lessons harvest — <gate or SO- tag>`.
2. Replace `<harvest-tag>` with the gate name (`P1-module-ready`) or
   `SO-<module>`. **The tag names the harvest in the row; it is not part of a
   candidate id.** Every candidate minted this round carries a **seat-qualified**
   id: `LC-<seat>-H<k>-<n>` for a **general** candidate (tier 1) and
   `LD-<seat>-H<k>-<n>` for a **domain** candidate (tier 2), where `<seat>` is the
   minting journal chain and `<k>` counts that chain's own harvest **spans**. The
   two sequences number **independently**, so a regrade before the note is written
   does not renumber a candidate's neighbours. Ids are never reused, and no landed
   id is renumbered (ADR-0018 §A1.4, §A2.6 — A2-D6, A2-D7).
3. One row of the span table per agent holding a persistent journal chain —
   today: `architect_docs_lead`, `rtl_lead`, `dv_lead`, `auditor`, `orchestrator`.
   Add a row for any persistent journal that exists at the time of the harvest
   (e.g. `rtl_lead_md` once activated).
4. **At a gate the orchestrator** fills the table from each agent's harvest note
   and checks the boxes; **at an `SO-` the round that signs the packet does**
   (A2-D4). **Every cell's authority is the cited `J-<agent>-NNNN` entry at both
   sites** — the transcription is clerical at either site, the gate-checklist edit
   commits under `Agent: orchestrator`, and it is the same transcription rule
   PROTOCOL §7 already uses for signatures.
5. Delete no rows. An agent with nothing to report gets a row reading `nil` with
   its span interval — a nil yield is declared, never omitted (ADR-0018 D4).

## 2. The bar, for the reviewer's convenience

Normative text is ADR-0018 §3.4 as amended by §A1.2; this is the short form.
**Three tiers** (ADR-0018 §A1.1; destinations per ADR-0023): **1 general** — to
the lessons file's general sections (`docs/LESSONS.md`); **2 domain** — to a
domain-titled section of the same file, pulled in by a later reader only if that
domain is theirs; **3 project-specific** — stays here.

| | Criterion | Passes when |
|---|---|---|
| **LH1** | provenance-pinned | Cites the incident commit SHA(s) **and** the entry/packet that adjudicated it; a reader at that SHA can see the thing going wrong |
| **LH2-g** | portable observable, **general** | The **rule statement** carries **no proper noun of any kind** — no module, requirement, carry-forward, signal, protocol, toolchain or library name — and reads as a complete instruction on a different project with different agents. Hide the provenance: it must still teach **a stranger to both the domain and this project** |
| **LH2-d** | portable observable, **domain** | The statement may name **domain** nouns — protocols, interface standards, algorithm families, encodings — but **no project noun** (module, requirement, carry-forward, signal, packet/WO/entry id, or a path in this repo), **and the note names the domain pack**. Hide the provenance: it must still teach **a stranger who knows the domain and not this project** |
| **LH3** | stated failure | Says what **breaks** without it — a concrete outcome a reviewer could recognise in someone else's repo, not a virtue |

**The noun discriminator**, for anything the lists above do not settle: a *domain*
noun is one that a different project, staffed by different agents, in the same
domain, would use in its own rule statement without having to learn anything
about this program; a *project* noun cannot be understood without this repo.

Passing neither grade → **tier 3**, which forks (see §2.1): **war story**
(recorded with the criterion or step it failed, binding nowhere, re-offerable at
a later harvest with new provenance) or **local accretion** (adopted here by its
own ADR / `C-` row / `R-` rule / spec clause — the note records the choice, the
adoption is a separate artefact and commit).

## 2.1 The classifier — three ways, in order

Normative text is ADR-0018 §A1.3. Run it on the **rule statement alone**, with
the provenance hidden; LH1 and LH3 are prior, and a candidate failing either is a
war story before the classifier is reached.

> **0.** Write the **most general honest statement** — fewest proper nouns that
> still says what happened. This step is not optional: the domain grade is
> reached only *through* a general statement that was attempted and went hollow.
>
> **1.** Any proper noun left? **No** → **general candidate**, `LC-`, tier 1.
>
> **2.** Is *every* surviving noun a domain noun? **No** → **tier 3**.
>
> **3.** Can the domain be **named** as a pack a stranger would recognise as a
> domain rather than as this program? **No** → **tier 3**.
>
> **4.** Provenance hidden, does it teach a stranger who knows that domain and
> not this project? **No** → **tier 3**. **Yes** → **domain candidate**, `LD-`,
> tier 2, pack recorded.

**Tie-break**: if the general statement of step 0 survives the hide test, the
candidate is **general** and the domain noun was decoration. If it goes hollow,
that hollowness *is* the evidence the domain noun was load-bearing — which is
what routes the candidate to tier 2 rather than refusing it.

---

## 3. The block

```markdown
## Lessons harvest — <harvest-tag>

Per ADR-0018 / PROTOCOL §7. Spans are entry-id intervals over each agent's own
journal chain and must tile with that agent's previous harvest. Transcribed by
the orchestrator; each row's authority is the cited journal entry.

### Spans mined

| Agent | Span (entry-id interval) | Harvest note | T1 general | T2 domain | T3 |
|---|---|---|---|---|---|
| architect_docs_lead | J-architect_docs_lead-NNNN … -MMMM | J-architect_docs_lead-MMMM | n | n | n |
| rtl_lead | … | … | n | n | n |
| dv_lead | … | … | n | n | n |
| auditor | … | … | n | n | n |
| orchestrator | … | … | n | n | n |
| _(worker spans, by commissioning lead)_ | spawn short-ids covered | (in that lead's note) | n | n | n |

### Yield — tiers 1 and 2

`LC-` = tier 1, general, to the lessons file's general sections. `LD-` = tier 2,
domain, to a domain-titled section of the same file, grade noted on the entry.
The two prefixes number independently.

| id | Rule statement (one line) | Grade | Domain pack | Mined by | Note entry | LH1 provenance | Disposition |
|---|---|---|---|---|---|---|---|
| LC-<seat>-H<k>-1 | | LH2-g | — | | J-…-NNNN | `<sha>` | landed as `L-…` in `docs/LESSONS.md` / deduped against `<L-…>` |
| LD-<seat>-H<k>-1 | | LH2-d | `<pack-slug>` | | J-…-NNNN | `<sha>` | landed as `L-…` in the `<pack-slug>` section / deduped against `<L-…>` |

### Tier 3 — war stories and local accretions (not transcribed to the lessons file)

| Candidate | Mined by | Failed | Why | Tier-3 disposition |
|---|---|---|---|---|
| | | LH1 / LH2-g+LH2-d / LH3 / step 2 / step 3 / step 4 | | war story (kept, re-offerable) / local accretion → `<ADR / C-row / R-rule / spec clause>` |

### Checklist

#### Part A — mining (carried by a sign-off **and** by a gate)

- [ ] **Every persistent-journal agent has a row above**, and every span tiles
      with that agent's previous harvest — no gap, no overlap. (First harvest:
      the span opens at the agent's first entry.)
- [ ] **Each row's harvest note exists** in the named journal entry and carries
      its span interval, its candidates with LH1–LH3 discharged, its war stories
      with the criterion each failed — or an explicit nil yield.
- [ ] **The classifier was run on every candidate** (§2.1), starting from the
      most general honest statement — no candidate reached `LD-` without a
      general statement having been attempted and found hollow.
- [ ] **Every candidate in the Yield table discharges LH1, LH3 and LH2 at its
      stated grade**, checked by the transcriber against the note, not against
      the summary line.
- [ ] **Every `LD-` row names a domain pack**, as a slug naming the technical
      domain and not this program.
- [ ] **Pack names checked against those already in use** in previous harvests;
      an existing name was reused rather than a near-duplicate minted, and any
      normalisation is noted here: `<none / LD-… : "<as offered>" → "<in use>">`
- [ ] **No candidate was edited in transcription.** A defective statement is
      bounced to its author, never rewritten by the collator. (Normalising a
      *pack name* is metadata, permitted, and noted on the line above.)

#### Part B — collation (a gate)

- [ ] **Local landing: exactly one commit**, transcribing this harvest's
      admissible candidates — general and domain — into `docs/LESSONS.md`, and
      nothing else. Commit: `<sha>`
- [ ] **`LC-`/`LD-` → `L-` pairs recorded** in the Yield table's Disposition
      column, with **ids local, seat-qualified and unrenumbered** (A2-D6,
      A2-D7), so each landed entry is traceable back to the note that minted it.
- [ ] **Dedup against the file recorded**: every candidate checked against what
      `docs/LESSONS.md` already holds, and the outcome recorded on its row.
      Dedup is clerical — a drop carries its reason; composition is selection
      and is never performed (A2-D8, §4.1).
- [ ] **Harvest declared complete** by the orchestrator: `J-orchestrator-NNNN`.

**The landing rides the gate-closing commits the sponsor already signs**, which
is the sponsor's whole lessons touchpoint: nothing leaves this repository, so
there is no diff to surface for refusal and no refusal column to fill
(ADR-0023 D4).

**In an `SO-` instantiation Part B's four boxes are not rendered as boxes** —
this line stands in their place, and it names the gate that owes them (A2-D1):

> **Part B — collation, deferred to `<gate>`.** The local landing, the
> `LC-`/`LD-` → `L-` pairing, the dedup record and the completeness declaration
> are the collator's acts at the gate that ratifies this harvest (ADR-0018 §4.2,
> A2.2; ADR-0023 D1, D3).
```

---

## 4. Notes for the transcriber

- **"Harvest" alone means something else in this repo** — a mutation-campaign or
  promotion-block harvest. Always write **lessons harvest** in the new sense
  (ADR-0018 §7.5).
- **An `SO-`'s Part A check does not discharge the gate's** (A2-D3). A gate's
  harvest is a different trigger over different spans, so a gate re-checks Part A
  over its **own** spans and inherits no box from a sign-off — and **several
  harvests ratified at one gate land as several local landing commits, one per
  harvest, in harvest order**, never one commit per gate (A2-D5 as restated by
  ADR-0023 D3).
- **You are not the selector.** Collation is clerical: you may bounce a candidate
  to its author for a defective statement, and you may not improve one. A collator
  who edits statements shapes the corpus without any note showing it.
- **Run the hide-the-provenance test yourself** at transcription — you are the
  reader who has the travel copy's audience in mind, and it is the last point
  before the rule enters the file a human may hand onward (ADR-0023 D2). Use the
  right stranger: for `LC-`, someone who knows
  neither the domain nor this project; for `LD-`, someone who knows the domain and
  not this project.
- **A harvest whose war-stories table is empty at every round** says something
  about the bar, not about the span. Worth a line in the note when it happens.
- **A harvest whose yield is all `LD-` and no `LC-`** says something about the
  miner, not about the domain — the domain grade is a rescue for statements that
  cannot generalise, not a shortcut past the attempt. Worth the same line.
- **Pack names are an interface, not a label.** The slug is the only thing a later
  project's "pull this in only if relevant" selector can select on, so reuse an
  existing name rather than minting a near-duplicate (`ethernet-10g` /
  `10g-ethernet` / `ethernet` are one pack no selector can reconcile). Naming and
  normalising a pack is metadata and is inside your clerical role; editing a
  candidate's statement never is.
- **A pack whose second project cannot be named** — "this would also serve …" —
  is a domain one project wide, which is a project lesson with a slug on it.
  A finding shape for the auditor, not automatically a finding.
- **Closed gates are not retro-harvested.** `G0-checklist.md` (PASSED 2026-08-01)
  and `P1-spec-freeze-checklist.md` (CLOSED 2026-08-02) predate this practice and
  are not reopened; their spans are covered by the interval rule, since each
  agent's first harvest opens at its first entry (ADR-0018 §9).
