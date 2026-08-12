# EVALUATION FRAMEWORK — docs/PROCESS.md
### Instrument for three reviewers and a council. Prepared by SAL, independent audit agent, 2026-08-12.

---

## 0. What is being judged, and against what

**The object.** `/home/user/agentic-fpga/docs/PROCESS.md` (4,142 lines; sections: "Read this first", "How to read this", "Contents", §1 The shape of the organization, §2 The constitution and its enforcement, §3 The artifact grammar, §4 The operating disciplines, §5 The failure museum, §6 Adopting this, Annex A substrate parameters, Annex B what this edition owes).

**Its claim.** A complete, PROJECT-AGNOSTIC description of the whole multi-agent engineering organization — sufficient to hand to a stranger or a blank AI to replicate the organization for a different project.

**The standard.** The document is judged against the repository, not against taste. Every probe below is answerable by comparing a passage of PROCESS.md with a named artifact. A finding a reader cannot check against a file and line is not a finding — the same falsifiability rule the org's own auditor charter imposes on itself (`agents/charters/auditor.md` §6.1) applies to this review.

**Severity anchor.** The org has two constitutionally non-negotiable properties (`agents/PROTOCOL.md` §1): **traceability** (every diff carries its reasoning) and **independence** (verification never graded by the designer; auditor graded by no one it audits). Severity of any finding is graded by its distance from these:
- **CRITICAL** — a replicated org following the document as written would silently violate traceability or independence, or would believe a protection exists that does not.
- **MAJOR** — replication would misfire detectably (wrong mechanism, missing artifact class, unbuildable step), costing rework but not silent corruption.
- **MINOR** — friction, imprecision, or style; the mechanism survives.

**Ground-truth inventory (the calibration baseline).** Reviewers sample from this list; it is what "everything the organization is and does" means in practice:

1. Constitution: `agents/PROTOCOL.md` — purpose and the two properties (§1); execution mechanics: orchestrator as sole spawner and sole git operator, logical lead→worker hierarchy, agent statelessness with continuity in the repo (§2); packet system: WO/SO/BUG/RV types, Summarizable vs **Verbatim** relay classes, lifecycle DRAFT→ISSUED→RETURNED→ACCEPTED|BOUNCED, the auditor packet exception with orchestrator clerical transcription (ADR-0003), monotone-per-prefix numbering by the sole committer, R-SEAL-1 (§3); journal system: append-only per-identity journals, the entry grammar (Trigger/Inputs/Reasoning/Actions/Evidence/Outcome/Open-questions/Files-in-this-commit), spawn short-ids for shared worker journals, the column-0 header hazard, structure machine-checked vs narrative audit-enforced (§4); commit protocol R1–R10 incl. journal volume chains (§5 + ADR-0017); write scopes (§6); gates G0/spec-freeze/module-ready/phase-accept, signature transcription, the Mutation record (ADR-0020: sealed vs seeded columns, UNSCOREABLE, negative controls, equivalent mutants, unreachable assertions), Lessons harvest (ADR-0018: LH1–LH3, LH2-g vs LH2-d grades, shell LESSONS routing, sponsor veto) (§7); escalation classes E1–E6, batched and decision-ready (§8); rehydration: `tasks/BOARD.md`, `agents/journals/INDEX.md`, the read-order procedure, the mid-phase kill drill (§9); independence and evidence rules: DV-from-specs-never-RTL, external anchors for golden models, DV-escape ledger, the transient mutation model with sequencing (RV-ACCEPT → campaign → SO-PASS) and ADR-0019's seeder-never-operates-the-repo, licensing boundaries (§10); amendment procedure: ADR + journal entry + `test_protocol.sh` case when enforcement semantics change, canonical statement vs restatements (§11).
2. Enforcement: `scripts/agent_commit.sh` (sole commit path; refusals name the rule broken; blob threshold; active-volume selection), `scripts/check_journals.sh` (CI re-verification over pushed ranges), `scripts/policy.sh`, `scripts/test_protocol.sh` (protocol self-test), `scripts/verify_journal_chain.sh`, `.github/workflows/journal-check.yml`, and the one out-of-repo dependency: sponsor-configured branch protection.
3. Roles: nine charters under `agents/charters/` sharing a structure (identity, mission, responsibilities, interfaces table, inputs/outputs/DoD, evaluation criteria, escalation rules, journaling obligations, context) including honest-enforcement notes; `ORG_CHART.md`; the contingent `rtl_lead_md` seat; Opus-class leads vs Sonnet-class workers; launcher definitions in `.claude/agents/`.
4. Record: journals as volume chains (e.g. `claude_dv_lead_agent.md` through `.v11`), `agents/journals/workers/` shared templates, `INDEX.md`; ~100 packets under `agents/handoffs/` including SEALED-prediction twin files and HT harvest-transit packets; 21 ADRs (several incident-born: 0016, 0017, 0018, 0019, 0020, 0021) with countersignature records; gate checklists under `docs/gates/` signed by journal-entry reference; `docs/reports/audit/` (mutations, dv_escapes), `docs/reports/latency/`, `docs/reports/process-council/`; `docs/SPONSOR.md`; sponsor duties (ratify G0, configure branch protection, plant canaries, receive E1–E6, veto harvest candidates).

---

## 1. Mechanics of the review

**Reviewer roles.** Reviewers score all criteria but lead different ones:
- **Reviewer A — Record auditor.** Leads C1, C2, C8, C11. Works bidirectionally: doc→repo (is each claim true?) and repo→doc (is each mechanism covered?).
- **Reviewer B — Reader advocate.** Leads C3, C7, C9. Reads as a competent engineer who has never seen this repo.
- **Reviewer C — Replication engineer.** Leads C4, C5, C6, C10. Reads as the blank AI: attempts to execute the document.

**Sampling discipline.** Where a probe says "sample", the reviewer records the sampling frame (what was in scope, what was drawn, what was skipped and why) — mirroring the auditor charter's sampling-disclosure rule. Minimum samples are stated per probe.

**Findings ledger.** Every finding: `[Cn]-[CRITICAL|MAJOR|MINOR] — PROCESS.md §/line — claim — ground-truth citation (path, and SHA or line where it matters) — consequence if left`. Findings without a checkable citation are struck by the council.

**Scoring.** Each criterion scored 0–4:
- **4** — all probes pass or exceptions are trivial and noted.
- **3** — minor gaps; no reader or replicator is materially misled or blocked.
- **2** — at least one MAJOR finding: a competent user would be misled or blocked somewhere load-bearing.
- **1** — systemic weakness; multiple MAJORs or one uncontained CRITICAL.
- **0** — the criterion's core purpose fails.

**Section routing (primary lens per section; every section still gets C2 and C9 spot-checks).**
| PROCESS.md section | Primary criteria |
|---|---|
| Read this first / How to read this / Contents | C3, C4, C9 |
| §1 The shape of the organization | C1, C2, C7 |
| §2 The constitution and its enforcement | C2, C8 |
| §3 The artifact grammar | C4, C2 (byte-precision), C5 |
| §4 The operating disciplines | C7, C1, C2 |
| §5 The failure museum | C11, C3, C7 |
| §6 Adopting this | C5, C6, C8 |
| Annex A substrate parameters | C6, C5 |
| Annex B what this edition owes | C10, C2 |

---

## 2. The criteria

### C1 — COMPREHENSIVE DOCUMENTATION
**Statement.** The document covers everything the organization actually is and does: every mechanism, artifact class, role, cadence, and duty in the ground-truth inventory has a home in the text.

**Why it matters here.** The document's own claim is completeness, and the org is a load-bearing lattice: omit one mechanism (say, packet numbering by the sole committer, or the spawn short-id) and a replicated org develops a hole precisely where the original placed a control. In this document class, an omission is not a shorter book — it is a missing enforcement surface.

**Probes.**
1. *Inventory sweep (repo→doc).* Take the ground-truth inventory of §0 above as a checklist. For each of its ~45 items, find the passage of PROCESS.md that carries it, or record an omission. Items whose absence removes a control (relay classes, auditor write-scope exception, transient mutation sequencing, branch protection, rehydration drill, amendment test-case duty) are MAJOR minimum.
2. *Artifact-class census.* Every artifact species in the repo must be described: journals (incl. volume chains and worker shared journals), all four packet types plus SEALED twins and Return logs, ADRs (with countersignature convention), gate checklists, the harvest block, BOARD.md, INDEX.md, audit reports, mutation manifests, the DV-escape ledger, attack plans, ORG_CHART, charters, launchers. List any species with no description and any described species with no repo instance (feeds C2).
3. *Role census.* All nine charters plus orchestrator and sponsor: does the document state each seat's mission, write scope, and what it may never do? Is the sponsor's duty list complete (G0 ratification, branch protection, canary planting, E-class receipt, harvest veto)? A missing "may never do" is graded higher than a missing "does".
4. *Cadence census.* The recurring clocks: per-commit rules, per-packet lifecycle, per-module sequence (spec → countersign → RTL → RV → mutation campaign → SO), per-gate checklists and harvests, per-phase audits/replays/rehydration drill. Is each cadence stated with its trigger and its precondition relationships?
5. *Edge and exception coverage (sample 5).* The org's texture lives in exceptions: Journal-Only commits, foreign journal seeding (R8), BOUNCED work orders, two-lead deadlock (E5), auditor findings against the orchestrator itself, UNSCOREABLE mutation classes, equivalent mutants. Are exceptions documented, or only the happy path? (Overlaps C11; count coverage here, lesson-transmission there.)

**Scoring note.** Comprehensiveness is measured against the inventory, not against page count. A one-line accurate mention with a pointer scores as covered; a page of prose that never states the actual rule does not.

### C2 — ACCURACY
**Statement.** What the document says is true of the real mechanisms (scripts, CI, protocol text) and the real record (journals, packets, ADRs, gates, history).

**Why it matters here.** This document will outlive its authors' memories and be executed literally by agents that cannot ask. In an org whose whole product is a trustworthy record, a description that misstates a rule manufactures false confidence at one remove — the exact failure the org built R-rules and auditors to prevent.

**Probes.**
1. *Claim spot-check (doc→repo, sample 12, stratified across sections).* Draw twelve verifiable claims — at least three about script behavior, three about protocol rules, three about the record, three about templates — and verify each against the artifact. Script-behavior claims are checked against the script text (e.g. does the described commit refusal exist in `agent_commit.sh` with that semantics?), not against the protocol's paraphrase.
2. *Post-amendment currency.* The constitution was amended by incident-born ADRs. Check the document describes the org **as amended**: journals as volume chains with R10 and frozen-volume semantics (ADR-0017), the gate reading the suite-at-SHA rather than campaign scoreboards (ADR-0020), seals as committed files (ADR-0016), harvest as gate precondition (ADR-0018), seeder never operating the repo (ADR-0019). A document describing the pre-amendment org is stale, not agnostic — MAJOR per stale mechanism.
3. *Template fidelity (byte-level, all templates in §3 of the doc).* Diff every reproduced template/grammar (journal entry header, trailer block, packet skeleton, sealed-prediction form) against the enforced originals in PROTOCOL §4–5 and the parsing scripts. The org's parsers are deliberately simple (column-0 `## [J-` counts as a header); a template that is *almost* right will generate commits the real tooling refuses. Any deviation in a machine-parsed form is MAJOR minimum.
4. *Numbers and names.* Rule IDs (R1–R10), escalation classes (E1–E6), gate names, lifecycle states, LH grades, severity ladders: do the document's identifiers match the constitution's exactly? Renamed or renumbered rules break every cross-reference a replicator will make back to this ecosystem's conventions.
5. *Record conformance (sample 3).* Where the document describes what an artifact looks like, hold a real instance next to it: one journal entry vs the described grammar; one work order (e.g. `WO-0038`) vs the described packet anatomy (State header, Spec basis, DoD, Context provided, Out of scope, Return log); one ADR vs the described decision-record form (status, deciders, countersignatures, affects). Note both directions of mismatch: doc promises what the record lacks, or the record contains load-bearing structure the doc never mentions (the latter also feeds C1).
6. *Overclaim hunt.* Flag any sentence asserting more protection, automation, or coverage than the mechanisms provide. (Adjudicate under C8 if the overclaim is about enforcement tier; here if it is about anything else.)

### C3 — HUMAN READABILITY AND CLARITY
**Statement.** A competent engineer outside the project can read the document, build a correct mental model, and locate answers — without the repo open and without the authors present.

**Why it matters here.** The real constitution is written in a dense, internally-referential house style (see PROTOCOL §7's Mutation record). That style is affordable when every reader is an agent contractually obliged to re-read it; a process description claims a wider audience — sponsors ratifying gates, engineers deciding whether to adopt, reviewers like this council. A document that only its authors can parse fails its stated purpose even if every sentence is true.

**Probes.**
1. *Cold-open test.* Read only "Read this first" (lines 1–241). Can the reviewer state, unaided: what the organization is, its two non-negotiable properties, who commits, where reasoning lives, and what a gate is? If the opening cannot carry that, score down regardless of later quality.
2. *Question drill (10 questions, closed book then open book).* Answer from the document alone, timing the search: e.g. "Who may edit a journal?", "What happens when a work order is BOUNCED?", "Who applies a mutation patch and why that seat?", "What can the sponsor alone do?", "What happens when the orchestrator's session dies?", "When may the orchestrator summarize a packet?". Record wrong-answer traps: passages a careful reader answers incorrectly from.
3. *Jargon ledger (sample 2 sections).* Every term of art (packet, seal, harvest, bounce, canary, rehydration, vacuity, verbatim-class, campaign, disposition) defined at or before first use, or reachable via a glossary/contents in one hop? Count naked first-uses.
4. *Density audit of the hardest passage.* Take the document's rendering of the most intricate mechanism (the mutation record or the seal rule). Can the reviewer reconstruct the rule's decision procedure as a flowchart from the prose alone? If reconstruction requires the underlying ADR, the passage is a pointer wearing the costume of an explanation.
5. *Narrative/normative separation.* Can a reader always tell binding rule from war story from example? The failure museum (§5) is narrative by design — is it fenced off so nobody mistakes anecdote for obligation, and vice versa?
6. *Length navigability.* 4,142 lines: does "How to read this" give honest role-based paths (sponsor path, adopter path, reference path)? Spot-check one advertised path: does it actually suffice for its promised purpose?

### C4 — AI-AGENT READABILITY AND CLARITY
**Statement.** An AI agent can parse, navigate, quote, and act on the document: unambiguous structure, greppable identifiers, byte-precise templates, and instructions that terminate in checkable actions.

**Why it matters here.** The primary operational readers of the replicated org will be stateless agents rehydrating from files. They will locate rules by search, copy templates verbatim, and follow references literally. The org's own scripts prove the stakes: parsers are deliberately simple, so a document whose forms are only prose-approximate will mint artifacts the enforcement layer rejects — or worse, teach an agent to rebuild the enforcement layer around the approximation.

**Probes.**
1. *Grep test (8 queries).* Simulate an agent mid-task searching for: "BOUNCED", "verbatim", "append-only", "Files-in-this-commit", "branch protection", "spawn short-id", "equivalent mutant", "rehydration". Does search land within one hop of the governing rule? Note synonym drift (a rule stated only in paraphrase is invisible to search).
2. *Template extractability.* Are all copy-target forms in fenced blocks, exact, and complete — no "..." elisions inside machine-parsed regions, no prose-embedded fragments an agent must reassemble? Cross-check against C2.3's fidelity results.
3. *Deterministic reference grammar.* Are internal references resolvable without human judgment ("§3.2's packet skeleton" vs "as discussed earlier")? Sample 10 cross-references; count ambiguous resolutions.
4. *Actionability of imperatives (sample 10).* For ten instructions, classify each as: executable-as-written (an agent knows the exact file, command, or edit), executable-with-bounded-inference, or vibes ("ensure quality", "be rigorous" with no observable). The document class needs the first two; count the third.
5. *Context-budget realism.* Can a role-scoped agent extract its needed subset without ingesting all 4,142 lines? Is there a self-contained normative core an agent could hold, with narrative material clearly skippable? (An agent that must load the failure museum to learn the commit rules has been set up to truncate the wrong half.)
6. *Self-parsing hazards.* The document reproduces journal-entry grammar inside itself (line 1173, 1779). Does it handle the org's own column-0 hazard — i.e., would this document, if placed in-repo, confuse the deliberately-simple parsers it describes, and does it warn its replicator about that class of trap?

### C5 — BLANK-AI REPLICABILITY (the master functional test)
**Statement.** Given this document and an empty repository, a capable but uninformed AI could re-instantiate the organization — constitution, enforcement, seats, artifacts, cadences, human interface — for a different project, and the result would preserve the two non-negotiable properties.

**Why it matters here.** This is the document's explicit reason to exist. Every other criterion is instrumental to this one: comprehensiveness supplies the parts, accuracy makes them the right parts, readability makes them findable, agnosticism makes them portable. The test is executability, not description.

**Probes — the walkthrough.** Reviewer C role-plays the blank AI and attempts each leg on paper, using only the document. Grade each leg: **E** (executable as written) / **I** (recoverable with reasonable inference) / **X** (blocked or would diverge silently).
1. *Day zero and bootstrap order.* What exists before anything can be enforced? Can the replicator determine the sequence: constitution drafted → enforcement scripts + self-test → CI wired → charters and launchers → journals seeded (R8) → G0 checklist → sponsor ratifies and sets branch protection? A document silent on ordering leaves the replicator enforcing rules with no enforcer, or committing history that the later rules retroactively condemn.
2. *Rebuild the enforcement layer.* From the document alone, could the replicator write a functional equivalent of `agent_commit.sh` and `check_journals.sh` — the full R-rule semantics including coupling, append-only-as-byte-prefix, set-equality, monotonic IDs, trailer protection, scope check, seeding, volume chaining — plus a self-test in the spirit of `test_protocol.sh`? The behaviors must be recoverable; verbatim code need not be.
3. *Mint a seat.* Could the replicator produce a charter for a new project's equivalent of dv_lead with all load-bearing sections (identity, scope, interfaces, DoD, evaluation criteria, escalations, journaling duties, honest-enforcement notes)? Does the document convey the charter *form*, or just that charters exist?
4. *Run one full work cycle.* Lead drafts WO → orchestrator spawns worker with packet + short-id → worker returns with journal entry → lead review verdict → commit via the gate with correct trailers → packet lifecycle closed. Every handoff and artifact producible from the document?
5. *Run one audit campaign.* Seeded-defect round end-to-end: manifest authorship by the seeder, sealed predictions committed as files before the run (R-SEAL-1), transient application by the operator with no spawns in the window, disposition of every seeded class, gate re-check per the Mutation record. Independence-critical sequencing intact?
6. *Survive a death.* Kill the replicated orchestrator: does the document teach the rehydration procedure (BOARD → constitution → org chart → journal tails) and the drill that proves it?
7. *Pass a gate with the human.* Could the replicator conduct a phase gate: checklist instantiation, journal-referenced signatures with clerical transcription, harvest block, audit-report precondition, sponsor E1 packet? Is the human's minimal duty set explicit enough that a *new sponsor* could serve from this document alone?
8. *Divergence forecast.* For each leg graded I, ask: would the inferred filling preserve traceability and independence, or is the inference a place two replicators would land differently in ways that matter? Silent-divergence points are CRITICAL; noisy blocks (X) are MAJOR (a blocked replicator at least knows to ask).

**Scoring note.** C5's score is capped by its worst independence-touching leg. A document that replicates everything except, say, the auditor's write-scope isolation has failed at the one place failure is silent.

### C6 — PROJECT-AGNOSTICISM AND LAYER SEPARATION
**Statement.** The document cleanly factors the invariant process from the project instance: every project binding (FPGA, Hardcaml, XGMII, module names, toolchain, licensing specifics, seat names like rtl_lead) is either lifted to a named parameter, marked as an example of a slot, or confined to Annex A.

**Why it matters here.** "Project-agnostic" is half the document's claim, and the org already owns the standard to judge it by: the harvest rules LH2-g/LH2-d (PROTOCOL §7, ADR-0018) — a general rule admits no proper noun; a domain rule admits domain nouns but no project nouns, and names its pack. The document should survive its own portability test. Failure mode one: project residue presented as invariant (a replicator building a compiler team ships a "line-rate stress" gate). Failure mode two: over-abstraction — parameterizing away the mechanism until nothing concrete remains to execute (which would also crater C5).

**Probes.**
1. *Noun scan (sample 3 sections of normative text).* Classify each proper noun: parameterized / marked-as-example / unmarked residue. Unmarked residue inside a stated rule is the LH2 failure; count instances.
2. *Annex A sufficiency.* Does the substrate-parameter annex enumerate every binding a new project must supply — domain, toolchain, seat roster, phase decomposition, external oracles, licensing landscape, CI substrate, blob thresholds, model-tier assignments? Reviewer C lists the parameters an adopting project would actually need (from the walkthrough) and diffs against Annex A.
3. *The missing-analog question.* Some mechanisms lean on project luck: an external reference implementation to anchor golden models, a public data feed for replay. Does the document say what to do when the new project *has no analog* — degrade, substitute, or refuse? Silence here converts a load-bearing independence anchor into an unexamined assumption.
4. *Instance-as-illustration discipline.* Where the document uses this project's record as example (a real WO, a real incident), is the example labeled as instance with the invariant stated beside it? Or must the reader reverse-engineer the rule from the anecdote?
5. *Seat-roster portability.* Is the org shape (orchestrator / leads / workers / independent auditor / sponsor) presented as the invariant with RTL/DV as one instantiation — including which properties force the shape (single committer because subagents cannot spawn; auditor isolation because independence) — so a different domain can re-derive its own roster from the forcing constraints?

### C7 — RATIONALE FIDELITY (why-preservation)
**Statement.** For each load-bearing rule, the document transmits *why it exists* and *what breaks without it* — the org's own LH3 admissibility test, applied to its process description.

**Why it matters here.** This org's founding axiom is that reasoning must travel with the work (PROTOCOL §1: "no thinking is lost"). A rules-only process description would betray that axiom at the meta level — and practically: a replicator (human or AI) holding rules without rationale cannot adapt them safely, will Goodhart them under pressure, and cannot distinguish a rule's essential core from its incidental form. Half these rules exist because something specific went wrong; strip the why and the successor org must re-pay the tuition.

**Probes.**
1. *LH3 sample (8 rules).* For eight load-bearing rules — suggested: R2 coupling, R3 append-only, verbatim relay class, auditor's write-scope exception, transient mutation with seeder/operator split, R-SEAL-1, gate signature transcription, the rehydration drill — does the document state the failure the rule forecloses? Grade each: stated / implied / absent.
2. *Incident linkage.* Several rules are incident-born (the seal rule, the volume chain, the harvest cadence, ADR-0021). Does the document connect rule to originating incident (LH1's citation duty), so the replicator knows these are scars, not ornaments?
3. *The rejected-alternative test (sample 3).* The record shows alternatives were weighed (ADRs record them; journals record rejected standards). Does the document preserve any of that negative space — what was tried or considered and why it lost? A replicator who doesn't know why per-agent branches were rejected will "improve" the process straight into the failure.
4. *Load-bearing vs incidental marking.* Can a reader tell which details are essential (append = byte-prefix; one journal append per commit) and which are tunable (blob threshold, zero-padding width, four-digit packet numbers)? The document need not mark every knob, but where it marks nothing, replicators will either freeze everything or loosen anything.

### C8 — ENFORCEMENT HONESTY (trust-boundary fidelity)
**Statement.** The document reproduces, without inflation or deflation, the org's four-tier enforcement reality: (a) machine-enforced at commit + re-verified in CI (R1–R10, with R1's honesty note for the orchestrator); (b) audit-enforced (narrative quality, read scopes, orchestrator attribution, mutation-window cleanliness); (c) review-enforced (§10 rules, R-SEAL-1, Mutation record, harvest — explicitly no R-rule, no script); (d) human-side, one-time (branch protection, without which R9 "is convention only").

**Why it matters here.** This is the document class's characteristic failure mode, split out from C2 because it deserves its own score: the real protocol is unusually scrupulous about naming what is NOT mechanically enforced (PROTOCOL §5 R1 honesty note, §6 read-access caveat, §10 "review-enforced" markers, the auditor charter's honest-enforcement note calling the auditor "the compensating control the whole org's honesty notes point at"). A summary that rounds "audit-enforced" up to "enforced" replicates a security theater; one that rounds down loses the compensating controls that make the honest gaps safe.

**Probes.**
1. *Tier table reconstruction.* Build the four-tier table from PROTOCOL + scripts + charters (ground truth). For each of ~15 controls, mark which tier the document assigns it. Every tier misassignment is a finding; upgrading an audit- or review-enforced control to "mechanical" is CRITICAL (it teaches the replicator to skip building the compensating control).
2. *Compensating-control pairing.* Wherever the document admits a gap (read scopes unenforceable, orchestrator R1 unattributable mechanically, transient-tree leakage), does it also name the compensating control (WO context omission, auditor sampling, canary plants, mutation-window commit checks)? A named gap without its named compensation is half the truth.
3. *The out-of-repo dependency.* Is the sponsor's branch-protection duty stated with its full weight — that a whole rule class rests on a setting no script can see, checked once at G0? (ADR-0021's "a check is only where it runs" is the org's own articulation; does the document carry that idea?)
4. *Advisory vs verdict.* Does the document preserve distinctions like WARN-SEAL ("a warning is not a verdict and its absence is not a clearance")? Sample any place the document describes a warning, lint, or best-effort aid (INDEX.md is "best-effort... not the live source of truth") and check the epistemic status survived.

### C9 — INTERNAL COHERENCE AND NAVIGATIONAL INTEGRITY
**Statement.** The document agrees with itself: contents match sections; templates match prose; §3's grammar matches §2's rules; terminology is one-to-one (one name per concept, one concept per name); cross-references resolve.

**Why it matters here.** At 4,142 lines assembled across an evolving program, self-contradiction is the default outcome, and it is uniquely damaging for this class: a replicator hitting two inconsistent statements of one rule must guess, and two replicators will guess differently — manufacturing divergence even where the underlying org was coherent. Coherence is also the cheapest proxy reviewers have for whether the document was maintained or accreted.

**Probes.**
1. *Contents audit.* Diff the "Contents" section against actual headings and coverage.
2. *One-concept-one-name.* Track five central terms (packet, seal, gate, campaign, entry) across all sections; flag drift (same word, shifted meaning) and aliasing (two words, one meaning, unannounced).
3. *Template-vs-prose agreement.* Where a form appears both as template (§3) and as prose description (§2 or §4), diff them. (Distinct from C2.3, which diffs against the repo; here the document against itself.)
4. *Cross-reference resolution (sample 12).* Follow twelve internal references; count danglers and mis-targets.
5. *Contradiction hunt on the routing seams.* The likeliest contradictions sit where sections restate each other's territory: §1's overview vs §2's rules; §4's disciplines vs §3's grammar; §6's adoption steps vs everything. Read the seams specifically.

### C10 — MAINTAINABILITY, AUTHORITY, AND PROVENANCE
**Statement.** The document states its own relationship to the living sources — which artifact wins on conflict (PROTOCOL.md is the ratified constitution; is PROCESS.md a description, a mirror, or a rival?), what edition this is, what it was derived from, and how it stays true as the org amends itself (§11's amendment machinery vs this document's update duty).

**Why it matters here.** The org's canonical-statement rule (PROTOCOL §11: one canonical statement, restatements listed and updated by the amending ADR) exists precisely because duplicated normative text rots. PROCESS.md is the largest restatement in the repo. If it does not declare its precedence and its refresh mechanism, it will drift, and a future replicator handed only this document will replicate the org as of an unknown date — with no way to know what it is missing. Annex B ("what this edition owes") suggests the authors saw this; the probe is whether the treatment is complete.

**Probes.**
1. *Precedence declaration.* Does the document state, unambiguously, that on any conflict the constitution/scripts/record win? Silence is MAJOR; a claim of self-authority is CRITICAL.
2. *Edition anchoring.* Is the document tied to a state of the org (SHA, date, ADR high-water mark — "current through ADR-0021")? Can a reader determine what has changed since?
3. *Update duty.* Is there a stated trigger for revising this document (e.g., amendment ADRs list it as a touched restatement per §11)? Check the record: did recent ADRs that changed described mechanisms actually touch it, or is it already stale (feeds C2.2)?
4. *Provenance.* Annex B: does it honestly state sources and derivation (whose journals, which ADRs, which incidents), so a future maintainer can re-derive rather than re-invent? Was the document itself produced under the process it describes (committed with journal coupling, in write scope)? If the process description was made outside the process, the document should say so and say why.

### C11 — FAILURE-MODE COVERAGE (negative knowledge)
**Statement.** The document transmits what went wrong and what almost went wrong: the incidents, escapes, near-misses, seeded-defect and canary disciplines, and the repairs — the org's accumulated immune system, not just its anatomy.

**Why it matters here.** Process documents default to the happy path; this org is unusual in that its most distinctive machinery (seals, volume chains, escape ledger, harvest, canaries) is crystallized failure-response. A replicator given only the anatomy will meet the same failures naked. The document has a "failure museum" section — the criterion tests whether it is a working museum (each exhibit: incident → mechanism it forced → how the successor org would catch it) or a trophy case.

**Probes.**
1. *Exhibit completeness (sample 4 incident-born mechanisms).* For the seal rule (ADR-0016), the volume chain (ADR-0017), the seeder/operator split (ADR-0019), and the gate-asks-the-suite rule (ADR-0020): does the museum (or wherever the doc carries them) present incident, diagnosis, and mechanism as a causal chain a stranger could learn from?
2. *Adversarial disciplines as first-class process.* Are seeded-defect campaigns, sponsor canaries, evidence re-execution, and relay-fidelity spot-checks presented as mandatory organs of the process (with their sequencing and preconditions), not as colorful history?
3. *Escape honesty.* Does the document describe the DV-escape ledger and the principle that post-sign-off divergences are recorded by the auditor, not by DV — i.e., that the org plans for its own verification to be wrong?
4. *Transferability of the lesson.* For two exhibits, ask C6's question: is the lesson stated portably (the LH2 discipline) so a non-FPGA replicator can recognize its own version of the failure?

---

## 3. Weighing conflicts between criteria

Reviewers will find tensions. Resolve them with these rules, in order:

**Rule 1 — Truth beats charm; specifically, C2 and C8 cap everything.** A beautiful, readable, well-structured falsehood is worse than an ugly truth, because this document's readers include agents that will execute it without skepticism. No overall verdict may exceed "conditionally fit" while any CRITICAL under C2 or C8 is open. When a passage must choose between a precise-but-dense statement of a rule and a smooth approximation, the precise statement wins — the remedy for density is structure (C3/C4 techniques), never approximation.

**Rule 2 — C5 is the master functional test; C1 serves it.** Comprehensiveness disputes ("should X have been included?") are settled by asking whether the walkthrough (C5) or an independence property needs X. A document may summarize or pointer-ize mechanisms the replicator can safely rebuild from stated principles; it may not summarize away anything whose absence would be filled silently and divergently (C5.8). Conversely, do not reward encyclopedic bulk that degrades C3/C4 navigation without adding replicability: coverage that cannot be found is not coverage.

**Rule 3 — Agnosticism yields to accuracy and executability.** Where C6 pulls toward abstraction and C2/C5 pull toward the concrete, follow the org's own two-grade solution: state the invariant rule without project nouns, then bind it to a concrete worked instance clearly marked as instance (LH2-d's pattern). A document that abstracted a mechanism into unexecutability has traded a C6 point for a C5 failure — a bad trade. Penalize under C5, not C6, when the abstraction is the cause of the block.

**Rule 4 — Human vs AI readability is a partition, not a compromise.** Normative and machine-facing material (rules, templates, grammars, checklists) optimizes for C4 first: exact, fenced, greppable, deterministic. Narrative and motivational material (rationale, museum, adoption guidance) optimizes for C3 first. Findings that a normative section is "dry" or a narrative section is "not machine-parseable" are category errors — strike them. The genuine conflict is a section serving both masters at once; the fix to recommend is separation, not blending.

**Rule 5 — Rationale is load-bearing, not decorative, but it never substitutes for the rule.** If C7 pressure (tell the why) bloats a passage past C3/C4 usability, the recommended structure is rule-first, rationale-adjacent (the constitution's own pattern: rule, then honesty note). A rationale without a crisp rule fails C2/C4; a rule without rationale fails C7; neither failure excuses the other.

**Rule 6 — No double counting; one defect, one home.** Every defect is scored under exactly one primary criterion (its root cause) and cross-referenced from others it manifests in. Canonical assignments: wrong enforcement tier → C8 (not C2); stale post-amendment description → C2 (not C10, unless the missing update *duty* is the finding); template mismatch with repo → C2; template mismatch within the doc → C9; unexecutable abstraction → C5; unfindable rule → C4 (if search fails) or C9 (if references fail).

**Rule 7 — Severity outranks count.** One CRITICAL outweighs any number of MINORs; scores are anchored to the worst material finding, then adjusted by breadth. Reviewers must resist averaging a section's brilliance against its one dangerous sentence.

---

## 4. Council procedure and verdict

1. **Independent pass.** Three reviewers score all eleven criteria (leading their assigned ones), each producing a findings ledger with citations and their sampling frames. No conferring before ledgers are filed.
2. **Falsifiability screen.** The council verifies every finding's citation against the repo. Uncheckable findings are struck; confirmed findings are deduplicated under Rule 6.
3. **Divergence handling.** Where two reviewers' scores on a criterion differ by more than one point, the council re-runs that criterion's decisive probe jointly. Divergences are resolved by evidence, never averaged.
4. **Verdict shape.** (a) Per-criterion scores 0–4 with the anchoring finding for any score below 4; (b) the blocking list — all CRITICALs and the MAJORs the council judges must be fixed before the document's replication claim can stand; (c) a separate, explicit verdict on the headline claim, in three grades: **replication-grade** (a blank AI plus this document plus a sponsor yields a faithful org), **adoption-grade** (sufficient for a competent team with access to this repo, not for a blank AI), **description-grade** (a true account, not an executable one); (d) the council's own sampling disclosure — what was not checked, so the verdict states its coverage honestly.
5. **Standing rule.** The council reviews the document, never repairs it: recommendations name the defect and the acceptance test a fix must pass (usually the probe that caught it), not the wording of the fix — the same never-fix-what-you-find discipline the org's auditor charter imposes, for the same reason.
