# EVALUATION FRAMEWORK — docs/PROCESS.md
## Instrument for three reviewers and a council

**Object under review**: `/home/user/agentic-fpga/docs/PROCESS.md` (5,446 lines), which claims to be a complete, PROJECT-AGNOSTIC description of the multi-agent engineering organization in this repository — sufficient for a stranger, or a blank AI with an empty repository, to replicate the organization for a different project.

**What this instrument is**: the criteria, probes, scoring scale, reviewer protocol, and conflict-resolution rules for judging that claim. It is a checklist to be executed, not an essay to be agreed with. Every score requires cited evidence.

---

## PART 0 — REVIEWER PROTOCOL

### 0.1 Ground truth first, document second
The document is judged against the real organization, not against taste. Before opening PROCESS.md, each reviewer builds (or receives) the ground-truth inventory from these artifacts, all under `/home/user/agentic-fpga/`:

- **Constitution**: `agents/PROTOCOL.md` — §1–§11: purpose, execution mechanics, packets (WO/SO/BUG/RV + relay classes), journal grammar (8 sections, Trigger→Files-in-this-commit), commit rules R1–R9 (+R10 volume chains via ADR-0017), write scopes, gates (G0, spec-freeze, module-ready, phase-accept; signature transcription; Mutation record; Lessons harvest LH1–LH3 with LH2-g/LH2-d grades), escalation classes E1–E6, rehydration, independence & evidence rules (external anchors, transient mutation model, R-SEAL-1), amendment procedure.
- **Enforcement**: `scripts/agent_commit.sh` (231 lines), `scripts/check_journals.sh` (256), `scripts/policy.sh` (281), `scripts/test_protocol.sh` (644 — the self-test the amendment procedure obliges), `scripts/verify_journal_chain.sh` (111), plus `.github/workflows/` CI re-verification.
- **Record**: journals under `agents/journals/` (note the **volume chains**: `claude_dv_lead_agent.md` … `.v11.md`; workers' shared template journals; `INDEX.md`); charters under `agents/charters/` (9 seats; note §-structure: Identity/Mission/Responsibilities/Interfaces/DoD/Evaluation criteria/Escalation/Journaling/honesty notes); packets under `agents/handoffs/` (e.g. `WO-0038_tb-m03-first-bench.md` for lifecycle and Context-provided/Out-of-scope discipline; `SO-xgmii_rx_64.md` for multi-round verbatim-class verdicts; `BUG-000x`, `HT-01`); decision records `docs/adr/ADR-0001`…`ADR-0021` (incident-minted, countersigned, with Affects lists); gates `docs/gates/`; live state `tasks/BOARD.md`; `ORG_CHART.md`; `docs/SPONSOR.md`; launcher definitions `.claude/agents/`.

Reviewers do not need to audit these; they need them **open** while reading PROCESS.md, so every claim in the document can be checked against the thing it describes.

### 0.2 Two reading passes
1. **Section-by-section pass**: apply the per-criterion sub-questions below to each section of PROCESS.md as you reach it. Log findings with `(doc §, repo path, claim, observation)`.
2. **Whole-document probes**: the integrative exercises in Part 2, which no single section can pass or fail alone.

### 0.3 Division of labor (recommended)
- **Reviewer A — repo-facing**: C1 (comprehensiveness), C2 (accuracy), C7 (enforcement honesty). Runs Exercise B.
- **Reviewer B — document-facing**: C3 (human readability), C4 (AI readability), C9 (internal consistency). Runs Exercise C.
- **Reviewer C — replication-facing**: C5 (blank-AI replicability), C6 (project-agnosticism), C8 (rationale preservation), C10 (maintainability). Runs Exercise A.

Every reviewer may file findings under any criterion. Reviewers work independently and do not share findings before council.

### 0.4 Scoring scale (per criterion, 0–4)
- **4** — Exemplary: probes found nothing material; a hostile reviewer could not construct a failure.
- **3** — Meets: minor defects, none affecting a replica or a reader's correct understanding.
- **2** — Serviceable with named defects: usable, but a list of specific repairs is required.
- **1** — Major gaps: the criterion's purpose is at risk; a replica or reader would go wrong in identified ways.
- **0** — Defeats the document's purpose on this axis.

**Evidence rule**: a score without cited evidence (doc section + repo artifact or probe result) is invalid. "Feels complete" is not a finding; "the transcription rule for gate signatures (PROTOCOL §7) appears nowhere in the document's gate chapter (§N)" is.

### 0.5 Finding severity (use the program's own grammar)
- **CRITICAL** — would cause a replica to fail to bootstrap, or to silently break an integrity property (false enforcement claim, wrong rule semantics, missing out-of-repo dependency, missing bootstrap ordering).
- **MAJOR** — a load-bearing mechanism missing, materially misdescribed, or unusable by its intended reader.
- **MINOR** — clarity, consistency, or completeness defect with a contained blast radius.
- **NOTE** — observation, improvement opportunity, or praise worth recording.

---

## PART 1 — CRITERIA

### C1. COMPREHENSIVE DOCUMENTATION
**Statement**: The document covers everything the organization actually is and does — anatomy, mechanisms, and full lifecycle including exception paths.

**Why it matters for this class**: This document's entire warrant is the word "complete." The organization is a machine of interlocking parts (a missing transcription rule breaks gates; a missing seeding rule breaks onboarding); a replica built from a description with holes does not degrade gracefully — it silently lacks an organ. Unlike ordinary docs, "the reader can look at the code" is unavailable to the target audience (a blank AI has no repo).

**Sub-questions (checkable)**:
- C1.1 *Anatomy census.* Build the inventory from the repo (Part 0.1), then tick each item off against the document: every seat (incl. contingent ones like `rtl_lead_md` and dormant ones like `formal_dv`), model-tier policy, sole-spawner topology, agent statelessness; every instrument (constitution, charters, journals+chains+INDEX, all four packet types + relay classes, ADRs, gate checklists + lessons-harvest block, board, org chart, launcher definitions, scripts, CI, sponsor doc); every mechanism (R1–R10, trailers + protected-key rule, packet numbering authority, foreign-journal seeding, spawn short-ids, gate-signature transcription, auditor-return transcription, escalation E1–E6, rehydration drill, mutation transient model + sealed predictions + Mutation-record semantics, lessons harvest + shell routing, external-anchor rule, R-SEAL-1, licensing/prior-art boundary, blob/large-data policy, amendment procedure incl. the script-self-test obligation). **Each absent item is a finding; severity by load-bearing-ness.**
- C1.2 *Lifecycle coverage.* Are all four life stages described: bootstrap (G0-equivalent, seed journals, out-of-repo branch protection), steady state (WO round trip lead→orchestrator→worker→review→commit), exception paths, and phase end (gates, harvest, trivial merges to main)?
- C1.3 *Unhappy paths.* For every happy path in the document, is its failure branch present? Specifically: BOUNCED work orders and re-issue; FAIL sign-offs; disputed bugs and adjudication; E5 deadlock; audit CRITICAL flow; DV-escape ledger; commit refused by the enforcement script; CI failing after a locally bypassed check; session loss mid-work (rehydration); an unredeemed seal promise; a surviving mutation at a gate.
- C1.4 *Human interface.* Are the sponsor's duties covered — ratification, branch protection (the one out-of-repo dependency), escalation classes and what arrives batched/decision-ready, the sponsor's right to refuse harvest candidates?
- C1.5 *Depth floor.* For each covered mechanism, is there enough that a reader could *state the rule and its trigger*, not merely know it exists? (A mention is not coverage. "Journals are append-only" without the byte-prefix semantics, volume-chain behavior, and refusal conditions is a mention.)
- C1.6 *Omission honesty.* Where the document deliberately omits (history, project math), does it say so, or does silence masquerade as completeness?

### C2. ACCURACY
**Statement**: What the document says is true of the real mechanisms (scripts, CI, constitution) and the real record (journals, packets, ADRs, gates), as they stand **now** — post-amendment.

**Why it matters**: This class of document is a load-bearing description of an enforcement system. A wrong rule statement is worse than a missing one: the replica will build the wrong machine and trust it. And this org has amended itself repeatedly (ADR-0016 seals, ADR-0017 journal chains/R10, ADR-0018 harvest, ADR-0020 gate semantics) — describing the ratified-at-G0 organization instead of the current one is a systematic failure mode.

**Sub-questions**:
- C2.1 *Claim sampling.* Select ≥12 checkable claims spanning the document (rules, formats, scopes, flows). Verify each against ground truth. Examples of good picks: the exact R4 set-equality semantics (own journal excluded, foreign seeds listed, deletions count) vs `scripts/policy.sh`; R3's byte-prefix + frozen-volume semantics vs `agent_commit.sh`; the protected-trailer-key refusal; the WO lifecycle states vs actual packet headers in `agents/handoffs/`; the journal entry grammar (8 sections, header regex, column-0 rule, zero-padded monotonic IDs) vs live journals; who allocates packet numbers; who transcribes gate signatures and on what authority.
- C2.2 *Currency check.* Does the document describe journal **chains** (volumes, active-volume rule, R10) or the obsolete single-file model? Post-ADR-0020 gate semantics (the suite-at-gate-SHA question, sealed vs seeded columns) or the naive "N/N killed"? If PROCESS.md generalizes these, is the generalization a true statement of the current specific?
- C2.3 *Quantity audit.* Every enumeration with a count (rule count, escalation classes, packet types, gate list, entry sections) — do the counts match the constitution and each other?
- C2.4 *Record conformance.* Do the document's descriptions of practice match at least one real instance? (E.g., its WO description vs `WO-0038`: Context-provided with RTL deliberately omitted, Out-of-scope list, Return log in-packet, DoD template. Its sign-off description vs `SO-xgmii_rx_64.md`: multi-round read-backs, superseded verdicts preserved unedited, verbatim relay class.)
- C2.5 *Fact vs aspiration.* Does the document mark which statements are norms, which are mechanically guaranteed, and which are historical one-offs (e.g., the rehydration drill "exercised once")? Presenting an aspiration as an invariant is an accuracy finding.
- C2.6 *No invented mechanisms.* Does the document describe anything that does not exist in the repo (a rule, artifact, or flow with no counterpart)? Fabricated completeness is a CRITICAL.

### C3. HUMAN READABILITY AND CLARITY
**Statement**: A competent human who has never seen this repository can read the document and come away with a correct working model, in reasonable time, without a guide.

**Why it matters**: The stated use is to hand it to *someone else*. The source material's native prose (see PROTOCOL §7's Mutation record, or the SO packet's verdict prose) is extraordinarily dense, adequate for its adjudicative purpose but hostile to a newcomer. A process description that merely clones the constitution's register fails its distinct job: the constitution is optimized to be ruled on; this document must be optimized to be *understood*.

**Sub-questions**:
- C3.1 *Gestalt test.* After the first ~5% of the document, can a cold reader answer: what is this organization, who is in it, what is the one-sentence integrity model (traceability + independence), and what does a day of work look like? Time-box it.
- C3.2 *Progressive disclosure.* Does structure go overview → mechanism → detail, or does the reader hit adjudicative fine print before the map? Are there tables/diagrams where the repo's own artifacts use tables (packet types, write scopes, interfaces)?
- C3.3 *Term discipline.* Jargon census on 3 sampled sections: every term of art (packet, seal, harvest, gate, bounce, verbatim class, spawn short-id, volume) — defined at or before first use? Is there a glossary or equivalent?
- C3.4 *Retrieval test.* With a stopwatch, answer five operational questions from the document (e.g., "who may edit a gate checklist?", "what happens when a work order is bounced?", "what must a commit message end with?"). A human should find each in minutes via headings/TOC alone.
- C3.5 *Explain-back.* A reviewer reads one mechanism chapter, closes the document, and writes the mechanism in three sentences. Compare against ground truth. Misunderstanding produced by the text (not by inattention) is a clarity finding — and if the text predictably produces a *wrong* model, cross-file it under C2.
- C3.6 *Sentence load.* Sample dense passages: does any sentence carry more than two normative clauses? Is the document's length (it competes with the constitution at 5,446 lines) doing work, or repelling the reader it claims to serve?
- C3.7 *Example coverage.* Is every abstract mechanism accompanied by one concrete worked example (real or synthetic)? Humans learn machines from traces, not from rule lists.

### C4. AI-AGENT READABILITY AND CLARITY
**Statement**: An AI agent can parse, navigate, and *act on* the document — turn its norms into checkable predicates, its formats into valid artifacts, its procedures into ordered steps — including when reading it in windows rather than whole.

**Why it matters**: The primary replication executor is an AI. The real org's formats are checked by unforgiving scripts (regex headers, byte-prefix appends, set-equality lists, zero-padded IDs, a `---` header terminator, a column-0 prohibition). An AI acting on paraphrase where the machine checks bytes will generate artifacts the enforcement layer refuses — or worse, will regenerate a *looser* enforcement layer that accepts them.

**Sub-questions**:
- C4.1 *Normative language.* Sample 3 sections; extract every imperative. Is each an actor + trigger + action + verification condition ("the orchestrator refuses the commit when X"), or hedge-prose ("should generally")? Count unresolvable imperatives (no actor, no trigger, or no way to check compliance).
- C4.2 *Format exactness.* For every artifact grammar the document teaches (journal entry header, trailers, packet header fields, checklist signature format, journal file header): is it specified to the byte where the real scripts check bytes — exact regex/template, padding, ordering, terminators? Test: generate one artifact of each kind *from the document alone* and check it against `scripts/policy.sh` / `check_journals.sh` logic.
- C4.3 *Procedural determinism.* Are multi-step procedures (commit flow, WO round trip, gate passage, rehydration, mutation campaign sequencing) given as ordered steps with explicit preconditions, or as narrative from which order must be inferred?
- C4.4 *Chunk independence.* Open the document at 3 arbitrary sections as if context-windowed: does each section either carry its dependencies or point to them by resolvable anchor? Or does correctness depend on having read 2,000 earlier lines?
- C4.5 *Navigability.* Stable section identifiers/anchors, one canonical statement per rule (duplicated statements WILL diverge and an AI cannot tell which is canonical), internal references that resolve.
- C4.6 *Fresh-model probe.* Give the document (or its relevant chapter) to a fresh model with 10 narrow operational questions ("which trailer keys are protected?", "who writes the auditor's RETURNED state into a packet?", "what may accompany a foreign journal in a commit?"). Score answer fidelity against ground truth. Wrong answers traceable to the text are C4 findings.
- C4.7 *Stop conditions.* Does the document tell an acting agent when to stop and escalate rather than improvise (the real org's E-classes, refusal semantics, "report, never repair" clauses)? Ambiguity about stopping is how autonomous replicas go feral.

### C5. BLANK-AI REPLICABILITY
**Statement**: Given this document and an empty repository, a blank AI could bootstrap the organization for a different project — reconstruct the constitution's function, the enforcement layer, the artifact ecology, and the human interface — without access to this repo.

**Why it matters**: This is the document's own advertised acceptance test, and the apex criterion: it integrates all others. It has a property the others lack — *sufficiency*: not "is what's here true and clear" but "is what's here **enough**."

**Sub-questions**:
- C5.1 *Bootstrap ordering.* Does the document give a day-zero sequence with dependencies — constitution first, scripts + self-test, seed journals (the R8 seeding mechanism exists precisely for this), charters, CI, board, G0-equivalent checklist, sponsor's branch-protection action — and does it flag the chicken-and-egg cases (how is the first commit made before the enforcement script exists? who signs G0 item N before the auditor has a journal?)? The real G0 record (`docs/gates/G0-checklist.md`, orchestrator journal entries 0001–0007, the retro-audit `WO-0001`) is ground truth for what bootstrap actually required.
- C5.2 *Enforcement regenerability.* From the document alone, could the AI rewrite `agent_commit.sh`/`check_journals.sh` with **equivalent refusal semantics**? Checkable by table: for each of R1–R10, does the document state (a) the invariant, (b) the exact check, (c) the refusal condition, (d) which layer checks it (local script vs CI vs review)? Does it transmit the obligation that enforcement changes ship with self-test cases (the `test_protocol.sh` discipline, PROTOCOL §11(3)) — without which a replica's scripts are unverified folklore?
- C5.3 *Template sufficiency.* Are there reusable skeletons (or byte-precise specifications) for: a charter, each packet type, a journal file header + entry, an ADR, a gate checklist, the board? Score by generating one of each from the document and checking it against the real instances' structure.
- C5.4 *Out-of-repo dependency manifest.* Are ALL dependencies that live outside git named: branch protection on both branches (no force-push, required check, no admin bypass) as a **human** action; platform constraints (subagents cannot spawn subagents → sole-spawner topology; no native per-path read denial → read scopes are prompt+audit-enforced); model-tier assignments; the launcher-definition layer; the human sponsor role itself? A replica that doesn't know R9 is "convention only" without branch protection inherits a hole it believes is a wall.
- C5.5 *Parameterization procedure.* Does the document enumerate what must be re-derived per project — role set and write-scope table, phase/gate definitions, external-anchor equivalents, the domain's artifact taxonomy — and give a procedure or worked example for deriving them, rather than assuming this project's answers?
- C5.6 *First-failure recovery.* Day one, the replica's first commit is refused by its own script, or its CI check disagrees with its local check. Does the document prepare it for this (debug order, which artifact is authoritative)?
- C5.7 *Human-in-the-loop setup.* Does it tell the sponsor-equivalent what they must do, decide, and ratify — or does it silently assume an already-trained human?

**Primary probe — the tabletop bootstrap (Exercise A, Part 2)**: score C5 chiefly from that exercise's counts of *blocking unknowns* vs *judgment calls*.

### C6. PROJECT-AGNOSTICISM (invariant/instance separation)
**Statement**: The document cleanly factors the reusable organization from this project's instantiation of it — abstract where the mechanism is general, concrete-as-marked-example where illustration helps, and never abstract in a way that changes semantics.

**Why it matters**: "Project-agnostic" is the document's second explicit claim. The record it describes is saturated with FPGA/trading specifics (Hardcaml, XGMII, ITCH, dune, REQ-1xx, module M03). Two symmetric failure modes: **leakage** (domain facts stated as process — a replica building a compiler will cargo-cult "line-rate stress benches") and **over-abstraction** (generalizing away a load-bearing concrete — "verification derives from specs, never implementation" must survive abstraction intact; ADR-0018's own LH2 grades are the house standard for exactly this distinction, and reviewers should borrow its test).

**Sub-questions**:
- C6.1 *Leakage census.* Scan the document for project nouns (Hardcaml, XGMII, ITCH, MoldUDP64, NASDAQ, verilog-ethernet, dune/opam, OCaml, module names, REQ ids, path names like `libs/hardcaml_ethernet`, person names). Each hit is either (a) inside a clearly marked example/instantiation block, or (b) a finding. Tally (b).
- C6.2 *The stranger test (borrowed from LH2).* Read each process rule with its provenance hidden: does it instruct a stranger to this domain? Rules that only make sense knowing this project fail.
- C6.3 *Over-abstraction check.* Take 6 mechanisms whose force lies in a concrete detail (spec-derived testing with implementation withheld from worker packets; external anchoring of oracles before they judge; transient never-committed mutation trees; verbatim relay classes; seals as committed files; the auditor's single-directory write scope). Has abstraction preserved the semantics, or dissolved them into pablum ("verification should be independent")?
- C6.4 *Instantiation map.* Is there an explicit "what you must replace" parameter list, or must the replicator infer which nouns are variables?
- C6.5 *Role abstraction.* Are the seats presented as functions (designer-line lead, verifier-line lead, independent auditor, document/spec owner, orchestrator, worker templates) with this project's names as bindings — or are `rtl_lead`/`dv_lead` presented as if every project has RTL and DV?

### C7. ENFORCEMENT-HONESTY FIDELITY
**Statement**: The document preserves the organization's own scrupulous distinction between enforcement tiers: (i) machine-enforced locally, (ii) machine-re-verified in CI, (iii) audit/review-enforced, (iv) sponsor-side/out-of-repo, (v) convention only.

**Why it matters**: This is the signature intellectual honesty of the source system — PROTOCOL flags it relentlessly ("honestly documented as such"; R1's attribution for the orchestrator is *audit*-enforced; narrative quality is *sampling*-enforced; R-SEAL-1 is *deliberately not* an R-rule because claim-vs-quotation is not a lexical test; `WARN-SEAL` is advisory and "its absence is not a clearance"; read scopes have no native denial; R9 is convention without branch protection). A description that flattens these tiers into "the system enforces X" produces a replica with **false confidence in its own guarantees** — the most dangerous single defect this document class can have. It is a species of accuracy, but it gets its own criterion because a reviewer not hunting for it will miss it: the flattened version reads *better*.

**Sub-questions**:
- C7.1 *Enforcement matrix.* Build a two-column table from the document: mechanism → claimed enforcement tier. Build the same from PROTOCOL + scripts. Diff them. Every upgrade (claiming mechanical where reality is honor/audit) is CRITICAL; every silent omission of tier is MAJOR; downgrades are MINOR but noted.
- C7.2 *Named honesty notes.* Spot-check that the specific canonical honesty notes survived: orchestrator R1 attribution; read-scope enforcement mechanism; the mutation-record and harvest clauses being review-enforced with "no R-rule minted"; the branch-protection dependency; CI as the backstop for locally bypassed checks.
- C7.3 *Residual-risk statements.* Where the real system documents what a mechanism does NOT catch (e.g., the gate disposition "catches a killing unit deleted or disabled, not one weakened"; "a vacuous seal passes and is caught at adjudication"), does the document carry the limitation with the mechanism?
- C7.4 *Trust-boundary narrative.* Could a reader reconstruct the layered defense (script → CI → auditor sampling → sponsor) and say which layer backstops which?

### C8. RATIONALE PRESERVATION (the why-record)
**Statement**: The document transmits not only the rules but the failure modes they answer — enough that a replica under pressure will defend the mechanisms instead of "simplifying" them away.

**Why it matters**: Nearly every mechanism here was minted or hardened by incident, and the ADR titles are a museum of them (`a seal is a file or it is not a seal`; `a journal is a chain, not a file` — born from a real blob-gate refusal; `the seeder never operates the repo`; `the gate asks the suite, not the scoreboard`). The org's own harvest rule LH3 demands every exported lesson state *what breaks without it*. A rules-only description invites the classic replication failure: the copy discards the fence because nobody told it about the bull. This criterion is what makes replicas *stay* replicas.

**Sub-questions**:
- C8.1 *LH3 sampling.* For 8 sampled mechanisms, does the document state what breaks without each? (Auditor's one-directory write scope → can never fix or touch what it audits; journal-before-commit in the same tree → reasoning inseparable from diff; verbatim relay → orchestrator summarization is a corruption channel; external anchor → an unanchored oracle just encodes the designer's misunderstanding twice; transient mutation trees → mutated RTL must never enter history; sealed predictions → post-hoc "we would have caught it" is unfalsifiable.)
- C8.2 *Threat model.* Is the adversarial model explicit — agents drift, sessions die, narratives go vacuous, graders self-grade, results get claimed-not-shown — or must the reader infer why so much machinery exists?
- C8.3 *Incident provenance.* Where mechanisms have incident origins, does the document either tell the (de-projectized) story or state the general hazard? (It need not cite ADR numbers to a stranger; it must not present rules as arbitrary.)
- C8.4 *Anti-simplification.* Pick the three mechanisms a smart newcomer would most plausibly call over-engineered (e.g., signature transcription, spawn short-ids, files-list set-equality). Does the document give that newcomer the argument that stops them?

### C9. INTERNAL CONSISTENCY AND SELF-COMPLIANCE
**Statement**: The document does not contradict itself, uses terms with one meaning, resolves its own cross-references, and its own examples conform to its own stated grammars.

**Why it matters**: For a human, contradiction costs trust; for an AI executor, contradiction is a fork with no tiebreaker — and for a 5,446-line document with restatements, divergence between restatements is near-certain unless deliberately controlled (the constitution itself has a canonical-statement-plus-restatements amendment rule for exactly this reason).

**Sub-questions**:
- C9.1 *Cross-reference sweep.* Every internal reference ("see §X", named sections, anchors) resolves to something that says what the citer claims.
- C9.2 *Term table.* Build a table of terms of art on first pass; flag any term used with two meanings or two terms for one thing (e.g., is "packet" ever used for non-handoff files? "gate" for both checklist and event?).
- C9.3 *Enumeration equality.* Every "the N kinds of…" matches its own list, and lists repeated in different chapters are identical.
- C9.4 *Example conformance.* Run each of the document's own worked examples through the document's own stated grammar/rules. A non-conforming example is a MAJOR (it will be copied in preference to the rule).
- C9.5 *Normative collision.* Any two imperatives that can both apply and disagree? (Classic spot: who writes what into packets vs write-scope table; orchestrator powers vs one-agent-per-commit.)

### C10. MAINTAINABILITY, VERSIONING, AND SCOPE HONESTY
**Statement**: The document knows it is a snapshot of an amendable constitution: it states its as-of point, its canonical relationship to the artifacts it describes, who maintains it under what obligation, and what it deliberately excludes.

**Why it matters**: This organization amends itself by ADR as a designed behavior — the described system moved under its own documentation at least four times in the existing record. A "complete description" with no version anchor and no precedence rule becomes silently false at the next ADR, and a replica cannot tell whether a divergence between PROCESS.md and its own constitution is drift or intent. Scope honesty is the same virtue pointed at edges: claiming completeness while silently excluding is the failure; excluding *explicitly* is fine.

**Sub-questions**:
- C10.1 Is there an as-of marker (version, date, or commit) and a statement of what supersedes what (constitution canonical, PROCESS.md descriptive — or whatever the intended precedence is)?
- C10.2 Is there an update obligation — whose write scope it lives in (in this repo: `architect_docs_lead` owns `docs/**`), and what events oblige a refresh (amendment ADRs? gates?)?
- C10.3 Are amendment-exposed facts (rule counts, packet lists, scope tables) stated with their canonical source named, so a divergence is detectable rather than latent?
- C10.4 Does the document state its non-goals/exclusions explicitly?

---

## PART 2 — INTEGRATIVE EXERCISES (whole-document probes)

### Exercise A — Tabletop bootstrap (feeds C5, C1, C4; run by Reviewer C)
Choose a deliberately alien project (e.g., "a compiler backend," "a legal-brief pipeline"). Using ONLY PROCESS.md:
1. Write the day-zero plan: first ten commits, in order, with what each contains and who is `Agent:` on it.
2. Draft one charter for the alien project's verifier-line lead.
3. For four synthetic staged-file sets (work without journal; journal edit above EOF; two agents' files together; foreign journal with one entry in it), state exactly what the enforcement layer must do and why.
4. Enumerate the G0-equivalent checklist including every human action.

Log every point where the document cannot answer, classified as: **blocking unknown** (a load-bearing fact the document simply lacks) vs **judgment call** (the document gives the principle and delegates the instance). Score: 4 = no blocking unknowns; 3 = blocking unknowns only on non-load-bearing points; 2 = ≤3 load-bearing blocking unknowns, all repairable; 1 = bootstrap stalls without the source repo; 0 = the exercise is not attemptable from the document.

### Exercise B — Mechanism cross-examination (feeds C2, C7; run by Reviewer A)
Select 12 claims per C2.1 (at least 3 must be enforcement-tier claims per C7.1). For each: quote the document, quote/observe ground truth, verdict TRUE / FALSE / STALE (true of a superseded version) / OVERCLAIMED (true mechanism, inflated enforcement) / UNVERIFIABLE. STALE and OVERCLAIMED are distinct verdicts because they have distinct repairs; both are findings.

### Exercise C — Stranger comprehension battery (feeds C3, C4; run by Reviewer B)
Two arms. **Human arm**: C3.1 gestalt test + C3.4 retrieval test + C3.5 explain-back, performed cold by the reviewer, time-boxed. **AI arm**: C4.6 fresh-model Q&A (10 questions) + C4.2 artifact generation (produce one journal entry, one work order header, one commit-message trailer block from the document alone; check against the real grammars). Report per-question fidelity, and separately note every error that traces to the document rather than the reader.

---

## PART 3 — WEIGHING CONFLICTS BETWEEN CRITERIA (council guidance)

1. **Accuracy beats readability, always.** A lucid falsehood is strictly worse than a dense truth: the reader of the dense truth knows they don't understand; the reader of the lucid falsehood doesn't. Never accept "it reads better this way" as mitigation for a wrong rule statement. BUT: prose so dense it *predictably produces* a wrong model is itself an accuracy hazard — file the C3 finding and cross-file under C2 with the misreading demonstrated (C3.5). Score both; trade neither.
2. **Comprehensiveness is non-negotiable for mechanism, negotiable for narrative.** The document may compress or drop history, module math, and project detail without penalty (indeed C6 rewards it). It may not drop rules, refusal conditions, exception paths, or out-of-repo dependencies. When length pressure and completeness collide, the correct resolution is layering (normative core + appendix), and a document that resolved it by deletion loses C1 points regardless of how clean it reads.
3. **Agnosticism never licenses semantic loss.** Where generalizing a mechanism would blur it, the document must keep the concrete as a *marked example* alongside the general rule. Abstraction that changed the semantics is scored as a C2/C7 accuracy failure, not credited as C6 cleanliness. Conversely, project residue inside normative text is a C6 failure even if accurate — accuracy about the wrong level.
4. **Human vs AI readability are usually allies; when they diverge, layer.** Exact grammars, tables, and numbered steps serve both. Where they genuinely conflict (flowing explanation vs byte-precise templates), the resolution is exact normative blocks embedded in explanatory prose. A document that chose one audience exclusively takes the loss on the other criterion — no averaging the two into "readability overall."
5. **Blank-AI replicability is the apex, and it double-records rather than double-counts.** Most C5 failures have a root cause in C1 (missing), C2 (wrong), C4 (unactionable), or C7 (overclaimed). File the root where it lives and the consequence under C5; severity is assessed once, at the root, but the C5 record is what tells the council whether the document's central claim stands.
6. **Enforcement-honesty findings outrank their apparent size.** A single sentence claiming mechanical enforcement of an honor-system rule is a small diff and a CRITICAL finding: it is the one error class whose damage is invisible until the replica is relied on.
7. **No compensatory averaging across CRITICALs.** Any open CRITICAL caps the overall verdict at *not fit for stated purpose until repaired*, regardless of criterion scores. Otherwise the council issues one of: **FIT** (claims of completeness/agnosticism/replicability substantiated; MINORs only), **FIT WITH REPAIRS** (MAJORs enumerated, each with a concrete repair, none requiring restructuring), **NOT FIT** (structural failure on C1/C2/C5/C7 — the document needs rework, not edits). The council's report lists every finding in the program's own severity grammar with doc-section and repo-path citations, so the repair work orders can be cut directly from it.

### Final report shape (per reviewer, then merged by council)
- Scores table: C1–C10, 0–4 each, one evidence citation minimum per score.
- Findings ledger: `ID | severity | criterion | doc § | ground truth ref | claim | observation | proposed repair`.
- Exercise records (A/B/C) attached verbatim.
- One paragraph: does the document's own central claim — complete, project-agnostic, blank-AI-replicable — survive? Answer plainly.
