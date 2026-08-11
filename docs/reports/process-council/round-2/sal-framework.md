# EVALUATION FRAMEWORK — docs/PROCESS.md
### Instrument for three reviewers and a council judging whether PROCESS.md is a complete, accurate, project-agnostic, replication-grade description of the agent organization

---

## 0. How to use this instrument

**The Document** = `/home/user/agentic-fpga/docs/PROCESS.md` (2,973 lines, sections "Read this first" through "Annex B"). **The Organization** = the real mechanisms and record in the repository. You are judging the Document against the Organization and against its own stated ambition: a project-agnostic description sufficient to hand to a stranger — human or blank AI — to replicate the process for a different project.

**You are not auditing the Organization.** Where the repo itself is internally inconsistent (and it is, in at least one known place — see Probe C2.7), the question is whether the Document *handles* that reality honestly, not whether the reality is good.

### 0.1 Mandatory calibration set — open these before scoring anything

| Reality | Path |
|---|---|
| Constitution | `agents/PROTOCOL.md` (§1–§11; rules R1–R9 as written) |
| Enforcement | `scripts/agent_commit.sh`, `scripts/check_journals.sh`, `scripts/policy.sh`, `scripts/test_protocol.sh`, `scripts/verify_journal_chain.sh` |
| CI | `.github/workflows/journal-check.yml` (plus `build.yml`, `site-deploy.yml`) |
| Charters | `agents/charters/auditor.md` and one lead + one worker charter; launchers in `.claude/agents/` |
| Journals | tail 100 lines of `agents/journals/claude_orchestrator_agent.md` and `claude_dv_lead_agent.md`; one worker journal; `agents/journals/INDEX.md` |
| Packets | `agents/handoffs/README.md`; `WO-0039_m03-mutation-campaign.md` + its `-SEALED-predictions` companion; `SO-xgmii_rx_64.md`; one `BUG-`; one `HT-` |
| Decisions | `docs/adr/ADR-0016`, `ADR-0017`, `ADR-0018`, `ADR-0020` |
| Gates | `docs/gates/` (G0, P1 checklists, `lessons-harvest-block.md`) |
| State & export | `tasks/BOARD.md`, `ORG_CHART.md`, `docs/SPONSOR.md`, `docs/federation/outbox/` |

### 0.2 Evidence rules (binding on reviewers)

1. **Every finding is falsifiable** — it cites a Document section/line AND, where the claim is about reality, a repo path, commit, `J-<agent>-NNNN`, or script line. A finding a council member cannot check is not a finding. (This is the Organization's own audit standard; hold yourselves to it.)
2. **Severity tags**: CRITICAL (would mislead an adopter into building a broken or dishonest replica), MAJOR (material gap or error, workaround discoverable), MINOR (friction, cosmetic).
3. **Sampling is disclosed**: for any probe that samples (entries, packets, claims), record what the frame was, what you drew, what you skipped.
4. **Score each criterion 0–4**: 0 = absent/false; 1 = gestured at, unusable; 2 = present with MAJOR defects; 3 = solid with MINOR defects; 4 = passes every probe you ran. Score per criterion, not per section — but run the probes section by section and keep the per-section notes for the council.

---

## C1. COMPREHENSIVE DOCUMENTATION

**Statement.** The Document covers everything the Organization actually is and does — every seat, artifact class, mechanism, lifecycle, and dependency, including the unglamorous ones (out-of-repo settings, contingent roles, recovery drills).

**Why it matters here.** This document class fails silently: an omission does not read as an error, it reads as simplicity. An adopter cannot ask about a mechanism they were never told exists — so a missing 5% (say, the sealed-prediction companion-file discipline, or the sponsor-side branch protection) yields a replica that looks right and lacks the exact load-bearing part. Coverage must be checked against an inventory built from the repo, not from the Document's own table of contents.

**Probes.** Build the inventory below from the repo (it is seeded from what actually exists as of this review); for each item mark: covered / mentioned-without-mechanism / absent. "Covered" means an adopter could recognize the item AND state its trigger, owner, and consumer.

- C1.1 **Seats**: orchestrator, four leads (architect_docs_lead, rtl_lead, dv_lead, auditor), four worker templates (rtl_module_dev, tb_writer, data_wrangler, formal_dv), the *contingent* seat (rtl_lead_md), the human sponsor. Model-tier assignment (Opus-class leads, Sonnet-class workers), launcher files in `.claude/agents/`, the fact the orchestrator is the session itself and has no launcher.
- C1.2 **Constitutional mechanisms**: all commit rules (the PROTOCOL's R1–R9 *and* the scripts' R10/volume-chain regime); write scopes incl. the auditor's `docs/reports/audit/**`-only exception and workers' Return-log carve-out; one-agent-per-commit's honesty note (emergent for scoped agents, audit-enforced for the orchestrator); trailers and the protected-key rejection; serialized single-branch history; CI re-verification of pushed ranges; the ONE out-of-repo dependency (sponsor-configured branch protection on both branches).
- C1.3 **Artifact grammar**: journal entry grammar (header regex, eight sections, Files-in-this-commit set-equality, spawn short-ids in worker entries, the no-column-0-header rule); journal *chains/volumes*; packet types — not just the PROTOCOL §3 four (WO/SO/BUG/RV) but the observed extensions: `HT-` harvest transit, `-SEALED-predictions` companions, pre-run reading notes, adjudication addenda, attack plans (`test/attack_plans/AP-*`), co-sim design docs (`CD-*`); packet lifecycle states as actually practiced (the repo shows `CLOSED`, `RE-ISSUED — RE-VERDICT EXECUTED`, preserved superseded verdicts — richer than `DRAFT→ISSUED→RETURNED→ACCEPTED|BOUNCED`); ADRs with countersignature and status-flip mechanics; gate checklists with clerical signature transcription; sign-off packets that preserve prior FAIL rounds unedited.
- C1.4 **Operating disciplines**: relay classes (Summarizable vs Verbatim) and relay-fidelity spot-checks; escalation classes E1–E6 and "batched, decision-ready"; rehydration (BOARD.md → protocol → ORG_CHART → journal tails) and the kill-and-rehydrate drill; seeded-defect campaigns end to end (auditor authors manifests, orchestrator applies transiently, sequencing between `RV-` ACCEPT and `SO-` PASS, blinding, the Mutation-record disposition calculus incl. equivalent mutants, unreachable assertions, negative controls); sealed predictions (R-SEAL-1: a seal is a file); lessons harvest (LH1–LH3, LH2-g vs LH2-d grades, tiling spans, nil-yield declarations, export to the shell's LESSONS file); sponsor-planted canaries; refusal as a first-class outcome; the DV-escape ledger; independence rules (tests-from-specs, external anchors for golden models, licensing boundaries).
- C1.5 **Lifecycle and edges**: genesis/bootstrap (who commits before the rules exist; R8 journal seeding; G0), phase cadence, incident recovery, federation/outbox, what happens when the constitution and scripts disagree, amendment procedure (ADR + journal entry + test_protocol case).
- C1.6 **The negative space**: does the Document *say what it excludes* and why (it claims to, in "What this document contains, and what it deliberately excludes") — and is every exclusion actually recoverable from the declared export unit (§6.0) rather than simply lost?

**Scoring note.** Weight items by load: a missing worker-charter nuance is MINOR; a missing enforcement mechanism, sponsor duty, or artifact class an adopter must produce is MAJOR-to-CRITICAL.

---

## C2. ACCURACY

**Statement.** What the Document says is true of the real mechanisms (scripts, CI, protocol text) and the real record (journals, packets, ADRs, gates) — including where reality is messier than the rule.

**Why it matters here.** The Document is the export vehicle for a system whose entire value proposition is evidence discipline. An inaccuracy here is not a typo; it is a false claim inside a document teaching falsifiability, and every error is *inherited by the replica*. Accuracy must be sampled the way the Organization's own auditor samples: re-execute, don't re-read.

**Probes.**

- C2.1 **Mechanism spot-checks (minimum 10 claims).** Take the Document's description of the commit gate and diff it against `agent_commit.sh`/`check_journals.sh` behavior: which refusals exist, in what order, with what semantics (journal deletion/rename refusal, foreign-seed volume-01-only rule, blob-size gate, protected-trailer rejection, frozen-volume append refusal). Every check the Document claims that the script lacks — or vice versa — is a finding.
- C2.2 **Grammar-vs-record.** Take the Document's journal-entry grammar and validate it against three real entries from three different seats. Does the stated header format match (`## [J-<agent>-NNNN] <UTC> | task:<id> | <title>`)? Are the sections it names the sections that exist?
- C2.3 **Story-vs-history.** The Document has a "failure museum" (§5) and worked examples. For each narrated incident, locate the underlying commit/journal/ADR (e.g., ADR-0017's blob-gate refusal incident at `J-orchestrator-0137`; WO-0039's blinding restriction; the SO-M03 multi-round FAIL→PASS record). A museum exhibit with no locatable incident is a CRITICAL finding (fabricated provenance in a document about provenance).
- C2.4 **Counts and enumerations.** Escalation classes (six, E1–E6), packet prefixes, gate names (G0, `P<n>-spec-freeze`, `P<n>-module-ready`, `P<n>-phase-accept`), scripts (five), the number of separations claimed in §1.4 — check each enumeration against source.
- C2.5 **CI claims.** Does the Document's account of what CI adjudicates match `journal-check.yml` + `check_journals.sh` (range re-verification, trivial-merge check, duplicate-trailer rejection)? Does it correctly state what CI does NOT check (narrative quality, read restrictions, orchestrator attribution)?
- C2.6 **Practiced-vs-prescribed.** Where the record exceeds the rule (packet states richer than the lifecycle table; sign-off packets preserving superseded verdicts), does the Document describe the practice, the rule, or both? Describing only the idealized rule is a MAJOR accuracy finding for a document claiming to describe "everything that happens."
- C2.7 **The known divergence (mandatory).** As of this review, `agents/PROTOCOL.md` §4–§5 describes single-file journals and rules R1–R9, while `scripts/agent_commit.sh` enforces journal *volume chains* and an **R10** per ADR-0017 (whose own text says the PROTOCOL diffs were "written, not applied" at acceptance). Determine which state the Document describes. Best: it describes the enforced (script) state AND flags the constitution's lag. Acceptable: describes the enforced state. CRITICAL: describes the stale PROTOCOL text as the enforced mechanism, proving it was written from the constitution rather than from reality.

---

## C3. HUMAN READABILITY AND CLARITY

**Statement.** A competent human who has never seen this repository — an engineer, a prospective sponsor — can read the Document, build a correct mental model, and find answers to role-specific questions without a guide.

**Why it matters here.** The Organization's house dialect is dense and self-referential ("a seal is a file, not a sentence"; "the gate asks the suite, not the scoreboard"). That dialect is precise for insiders and opaque for arrivals. The Document is the *only* artifact whose primary audience is outsiders; if it merely transplants the dialect, it documents nothing — it initiates.

**Probes.**

- C3.1 **Cold-read test.** A reviewer who has NOT read the repo (or simulating it honestly) reads only "Read this first" + §1, then answers from memory: Who commits? Who can spawn? Why can't the auditor fix anything? What is a journal for? What does the sponsor do? Wrong or absent answers are findings against the sections read.
- C3.2 **Jargon gradient.** Sample 15 terms of art (seat, packet, seal, harvest, countersignature, verbatim class, transient model, canary, chain/volume, disposition, negative control...). Is each defined at or before first load-bearing use? Does the Document's own "dialect" section (it has one) actually discharge this?
- C3.3 **Role-lookup drill.** Pick three personas — new sponsor, incoming lead, curious outsider — and one question each ("what am I obliged to do at a gate?", "what may I write?", "why so much ceremony?"). Time-box five minutes with the Contents; record whether the answer was findable and correct.
- C3.4 **Why-before-what.** For five arbitrary rules, does the surrounding prose let a reader answer "what goes wrong without this?" — or is the rule bare? (The Document's §5 failure museum should be doing this work; check that §2–§4 actually link into it.)
- C3.5 **Pathology scan.** Flag sections where sentence structure requires three reads (the Organization's own Mutation-record clause in PROTOCOL §7 is the calibration for "too dense"); flag any section over ~150 lines with no internal signposting.
- C3.6 **Honesty of tone.** Does prose distinguish "we do X" (record-backed) from "one should X" (aspiration)? A reader must be able to tell narrative from norm.

---

## C4. AI-AGENT READABILITY AND CLARITY

**Statement.** An AI agent can parse, navigate, quote, and act on the Document: unambiguous normative language, machine-recognizable grammars, literal path templates, stable identifiers, and sections that survive being retrieved out of context.

**Why it matters here.** The Document's operational consumers are stateless agents that will be *spawned into* it, often receiving fragments via retrieval or excerpted work orders. The real system already engineers for this (journal grammars with column-0 rules "because the structural parsers are deliberately simple"; spawn short-ids; verbatim relay classes). A process description that agents must interpret rather than execute reintroduces exactly the ambiguity the Organization's file formats were built to remove.

**Probes.**

- C4.1 **Fragment survival.** Extract three sections in isolation (e.g., the journal-entry grammar, the commit procedure, the gate procedure). Could an agent act on each without the rest of the file? Count unresolved references ("as above", "the earlier rule", pronouns whose antecedent is in another section) — each is a finding.
- C4.2 **Actor-trigger-check lint.** Sample 20 normative statements. Each must have an explicit actor (which seat), an explicit trigger (when/what event), and a checkable satisfaction condition. "Journals must be kept carefully" fails; "the committing agent's entry's Files-in-this-commit list must set-equal the commit's non-journal changed paths" passes.
- C4.3 **Grammar executability.** Do the Document's formal blocks (entry header, trailer block, packet header fields, checklist signature format) actually match the real record — i.e., would a regex written from the Document match real entries in `agents/journals/`? Test one.
- C4.4 **Canonical naming.** One name per artifact class throughout (is it always "work order", or sometimes "packet", "task", "assignment" interchangeably?). Synonym drift is cheap for humans and expensive for agents; count instances.
- C4.5 **Path and ID templates.** Every file-producing rule states its literal path template (`agents/handoffs/WO-NNNN_<slug>.md`, `J-<agent>-NNNN`, `docs/reports/audit/audit-NNNN_<slug>.md`) with placeholder conventions defined once. Sample five.
- C4.6 **Ordering explicitness.** For multi-step procedures (commit sequence: write entry → stage → run script; mutation campaign sequencing; gate signing), is the order stated as an ordered list an agent can execute, or prose it must infer from?
- C4.7 **Normative/descriptive separation.** Can an agent mechanically distinguish "this is the rule" from "this is a story about the rule"? (Matters because §5's museum contains *violations* — an agent must not pattern-match a narrated failure as an instruction.)

---

## C5. BLANK-AI REPLICABILITY

**Statement.** Given the Document (plus whatever export unit it declares, per its §6.0) and an empty repository, a blank AI could stand up a working instance of this organization for a *different* project: right seats, right files, right enforcement, right order — and could tell whether it succeeded.

**Why it matters here.** This is the Document's stated purpose and the criterion everything else serves. It is also where documents of this class habitually fail: they describe the running system's steady state and omit genesis (who commits before the commit rules exist?), the out-of-repo acts (branch protection is sponsor-side; without it R9 "is convention only" — the PROTOCOL says so itself), and the acceptance test (how do I know my replica enforces?).

**Probes.** Run these as a tabletop bootstrap — reviewers simulate day zero using only the Document.

- C5.1 **Export-unit clarity.** What exactly ships? The Document claims "this document plus the shell" (§6.0). Is the shell's content enumerated? Is everything NOT shipped either derivable from the Document or explicitly declared re-earnable (§6.1)? Anything neither shipped, derivable, nor flagged is a CRITICAL gap.
- C5.2 **Genesis order.** From §6.2 (or wherever), write the first ten commits of a new instance: who authors the constitution, how are journals seeded (the R8 header-only mechanism), when do scripts start gating, when does CI arrive, what is G0 and who signs it. Every step you had to invent, note; every invented step the Document doesn't flag as adopter-owned is a finding.
- C5.3 **Enforcement reconstruction.** From the Document alone, list the checks a replica's `agent_commit.sh` must perform. Diff your list against the real script's refusals. The Document need not contain the code (if the shell ships it — see C5.1), but it must specify behavior completely enough that a reimplementation would refuse the same commits. Count the missed refusals.
- C5.4 **Sponsor-side checklist.** Can you extract, verbatim, the list of human acts no agent can perform (branch protection on both branches with journal-check required and no admin bypass; gate ratifications; canary planting; escalation availability)? If the human duties are diffused through the text rather than collectible, replication fails at the first out-of-repo dependency.
- C5.5 **Substrate separation.** Annex A ("substrate parameters") should isolate what is Claude-Code-specific (subagents cannot spawn subagents → sole-spawner design; no native read denial → audit-compensated read restrictions; model tiers). Test: for two substrate facts, does the Document say what the *invariant* is versus what the *current mechanism* is, so an adopter on a different substrate knows what to preserve?
- C5.6 **Acceptance test.** Does the Document give the adopter an equivalent of `scripts/test_protocol.sh` — a way to prove the replica's enforcement actually refuses what it must refuse — or at least state that such a self-test is mandatory before first real work (G0 requires "protocol self-test green")? A replica with untested enforcement is the Document's own §5.1 failure ("remedies decay without mechanical checks") reborn.
- C5.7 **First-week trace.** Can you script, from the Document, one full loop for a fictional project: charter a seat → issue WO → spawn worker → return → review → commit via script → sign a gate item? Every point where the Document under-determines the next action, record it.
- C5.8 **Anti-cargo-cult check.** §6.3 ("the failure of exporting rules alone") should tell the adopter which parts are ceremony-shaped but load-bearing and which are genuinely local. Does it? An adopter who cannot distinguish them will either drop a load-bearing rite or fossilize a local accident.

---

## C6. PROJECT-AGNOSTICISM AND QUARANTINE DISCIPLINE

**Statement.** Project-specific content (Hardcaml, NIC, ITCH/MoldUDP64, module names, 156.25 MHz, repo paths-as-content, "Renato") appears only where quarantined and labeled as instantiation examples or substrate parameters — never woven into normative statements — while the abstraction never hollows out the mechanism.

**Why it matters here.** The claim under test is "PROJECT-AGNOSTIC." The Organization already owns the right yardstick: the lessons-harvest grades (ADR-0018) — **LH2-g** admits no proper noun in a rule statement; **LH2-d** admits domain nouns but no project nouns. Apply the Organization's own portability grammar to the Document that exports it. Failure in either direction is fatal to reuse: leakage means the adopter inherits FPGA-shaped rules; over-abstraction means "at least three seeded defect classes spanning distinct classes" degrades into "test thoroughly."

**Probes.**

- C6.1 **Leak scan.** Grep-style pass over §1–§5 (the normative core) for project nouns: Hardcaml, XGMII, ITCH, MoldUDP64, verilog-ethernet, module IDs (M03, M14), REQ-numbers, the working branch name, the sponsor's name. Each hit outside a marked example block or Annex A is a finding; classify LH2-d-acceptable (domain noun, labeled) vs LH2-fail (project noun in a rule).
- C6.2 **Rule-statement grading.** Sample 10 normative rules; grade each LH2-g / LH2-d / fail, reading with provenance hidden: would it instruct a stranger to the domain?
- C6.3 **Hollowing check.** For five mechanisms with sharp project-shaped teeth in reality (mutation defect-class floor, line-rate stress evidence in sign-offs, external-anchor rule for golden models, blob-size gate, replay manifests), verify the generalized statement kept the *quantified* obligation (numbers, floors, sequencing) and states how an adopter re-derives the project-specific instance.
- C6.4 **Annex A integrity.** Is every parameter the normative text depends on actually present in Annex A (or equivalent), and does the normative text reference the parameter rather than the value?
- C6.5 **Example marking.** Where project material appears as illustration (legitimately — worked examples aid C3/C5), is it unambiguously marked as instance-not-norm, such that C4.7's mechanical separation holds?

---

## C7. ENFORCEMENT-POSTURE HONESTY

**Statement.** Every "this is enforced" claim in the Document carries its true posture: machine-refused (script + CI), review/audit-enforced (auditor sampling, countersignature), sponsor-side (branch protection, ratification), or convention. The Document itself promises this ("Every enforcement claim carries its posture", §0). Verify the promise.

**Why it matters here.** This is the single most dangerous failure mode of the document class. The Organization is scrupulous about the distinction — PROTOCOL §5 admits R1 is only audit-enforced for the orchestrator; §6 admits read restrictions are prompt+audit, "Claude Code has no native per-path read denial"; R-SEAL-1 is deliberately NOT a commit rule "because distinguishing a claim from a quotation is not a lexical test"; R9 without branch protection "is convention only." A description that flattens these into uniform "the system enforces" produces adopters with unwarranted trust in unenforced boundaries — the precise dishonesty the Organization was built to prevent. This deserves its own criterion because it can score catastrophically while C2's general accuracy scores well.

**Probes.**

- C7.1 **Posture audit.** Sample 15 enforcement claims across the Document. For each: what posture does it state, and does it match reality (script check present? CI job re-checks? auditor charter names it? sponsor checklist item?)? Any review-enforced or conventional control presented as mechanical is CRITICAL.
- C7.2 **The honest-notes inventory.** The real corpus contains explicit honesty notes (orchestrator R1, read restrictions, no-force-push dependency, WARN-SEAL being advisory, transient-mutation leakage stopped only by audit). Does the Document reproduce *each* of these confessions? Every one silently dropped is MAJOR.
- C7.3 **Compensating controls.** Where a control is non-mechanical, does the Document name the compensating control and its residual risk (e.g., auditor sampling of journal Inputs as the enforcement of tests-from-specs), rather than leaving "audit-enforced" as a magic word?
- C7.4 **Adjudicator-of-last-resort.** Is it stated plainly where the enforcement chain bottoms out in a human act (branch protection settings, gate ratification) — i.e., that the machine guarantees are conditional on one sponsor-side configuration?

---

## C8. RATIONALE AND THREAT-MODEL PRESERVATION

**Statement.** The Document preserves *why* each mechanism exists — the temptation, failure, or attack it is drawn against — with the incident provenance that taught it, so an adopter can adapt rules without breaking invariants and can re-derive rules for situations the Document never saw.

**Why it matters here.** Rules transfer; judgment doesn't — unless the rationale ships with the rule. The Organization encodes this belief everywhere: separations "each drawn against a specific temptation" (§1.4), harvest admissibility requiring LH1 (incident citation) and LH3 (what breaks without it), ADRs recording alternatives. A rationale-free export produces cargo-cult replicas that keep the ceremony and lose the protection — and cannot safely amend anything, because amendment requires knowing which property each rule serves.

**Probes.**

- C8.1 **LH1/LH3 applied to the Document.** Sample 10 rules: does each carry (or link to) what breaks without it and, where the rule was learned, the incident that taught it? Grade against the harvest criteria the Organization uses on its own lessons.
- C8.2 **Temptation mapping.** For each stated separation of duties, is the adversarial scenario concrete (who would be tempted to do what, and what artifact catches it) — e.g., seeder-blinding in WO-0039 exists so the campaign tests the bench, not the prediction? Check the Document tells that class of story, not just the org chart.
- C8.3 **Root-class identification.** The Document claims a root failure class (§5.7, "the author grading its own homework"). Does the text actually connect the individual mechanisms back to the root class(es), so an adopter facing a novel situation can ask the right question ("who grades this?") rather than searching for a matching rule?
- C8.4 **Amendment safety.** Given the rationale as documented, could an adopter correctly decide which of two candidate simplifications is safe (e.g., dropping the spawn short-id vs dropping journal append-only)? Construct one such pair and test whether the Document's rationale settles it.

---

## C9. INTERNAL CONSISTENCY AND SELF-EXEMPLIFICATION

**Statement.** The Document does not contradict itself; its cross-references resolve; its Contents matches its headings; its terminology is stable; and it practices the norms it exports (claims carry postures, examples are marked, narrative is distinguished from rule, provenance is cited).

**Why it matters here.** Reviewers of both prior criteria classes will read the Document non-linearly; internal contradictions poison every downstream use, and are especially damaging for AI consumers (C4) who cannot weigh which of two conflicting passages is "more intended." Self-exemplification matters for a subtler reason: this document teaches a culture of falsifiable claims, and a document that violates its own standard undermines the export at the level of demonstration — the Organization itself records that "a relay can demonstrate the hazard it reports" (§5.3).

**Probes.**

- C9.1 **Cross-reference sweep.** Sample 20 internal references (section numbers, "see §x.y", named annexes) and 10 outward references (file paths, ADR numbers, script names): do they resolve, and to the claimed content?
- C9.2 **Contradiction hunt.** For three mechanisms described in more than one place (commit rules in §2.1/§2.6; sealing in §3.3 vs relay in §4.3; gates in §3.7 vs adoption order in §6.2), diff the descriptions.
- C9.3 **Contents integrity.** The "Contents" section against the actual heading tree — omissions or orderings that lie about the structure.
- C9.4 **Self-compliance.** Does §0's promise ("every enforcement claim carries its posture") hold in §2–§4 (feed from C7.1)? Are Annex B's provenance debts ("what this edition owes") actually discharged as citations in-body?
- C9.5 **Terminology ledger.** From C4.4's synonym scan: any term that changes meaning between sections (e.g., "seal" as withheld-result-file vs "SEALED" as finalized-decision — a distinction PROTOCOL §10 draws explicitly; does the Document keep it drawn?).

---

## C10. MAINTAINABILITY, EDITION CONTROL, AND DRIFT RESISTANCE

**Statement.** The Document knows what it is an edition *of*: it states its own version/date/commit anchor, which repo state it describes, who owns updating it, what events oblige a re-edition (protocol amendments, new ADRs, new artifact classes), and it avoids embedding volatile facts that rot (live branch names, current counts) without marking them as snapshots.

**Why it matters here.** The Organization amends itself constantly by ADR — 21 ADRs already, one of which (ADR-0017) restructured the journal substrate after the constitution was ratified, and the constitution text demonstrably lags the scripts today. A process description with no update contract is guaranteed false within weeks, and — worse for this class — will be *exported* in its false state. Drift resistance is what separates a living instrument from a commemorative essay.

**Probes.**

- C10.1 **Edition anchor.** Does the Document state the commit/date/protocol-version it describes? Can a reader tell whether it predates or postdates ADR-0017/ADR-0020?
- C10.2 **Update trigger.** Is there a stated rule binding PROCESS.md into the amendment procedure (does an ADR that changes enforcement semantics oblige a PROCESS edition, the way §11 obliges a test_protocol case)? Who owns it (write scope says architect_docs_lead)?
- C10.3 **Volatility scan.** Find embedded facts with short half-lives (branch names — the PROTOCOL itself says the current name lives in BOARD.md precisely because it changes; entry counts; "currently"-statements). Each unmarked snapshot is a finding.
- C10.4 **Annex B as a mechanism.** Does "what this edition owes" function as a real debt ledger (checkable items) or as acknowledgments prose?

---

## Weighing conflicts between criteria — council guidance

**1. Truth outranks everything.** C2 (Accuracy) and C7 (Posture honesty) are **veto-class**: a Document scoring below 3 on either cannot pass overall regardless of other scores, because its consumers replicate — an elegant false description is a defect *factory*, and a control described as mechanical when it is conventional is the worst single sentence this document class can contain. Never average a veto away.

**2. The mission criterion is C5.** Replicability is what the Document is *for*; C1 (coverage) and C6 (agnosticism) are its supply lines. When C1 and C5 point in different directions — exhaustive coverage that buries the bootstrap path — rule for C5 and file the excess as a layering (C3) finding, not a comprehensiveness virtue.

**3. Accuracy vs readability: keep the precision, fix the architecture.** Where a passage is dense *because the mechanism is dense* (the mutation-record disposition calculus is irreducibly intricate), do not score C3 down for precision that C2/C5 require; score C3 down only if the Document failed to *layer* it (summary first, full calculus behind it, example alongside). The remedy for unreadable truth is progressive disclosure, never simplification-by-falsification. A reviewer proposing to fix C3 by weakening a claim's truth is proposing a C2 CRITICAL.

**4. Agnosticism vs completeness: quarantine, never delete.** Project-specific material that carries load (a worked example, a defect-class list) belongs in marked example blocks or Annex A — its *presence* is not a C6 finding; its *leakage into rule statements* is. Conversely, project material excised entirely, hollowing a mechanism (C6.3), is the graver finding: charge it to C1/C5, and prefer a Document that leaks slightly over one that abstracted its teeth away.

**5. Human vs AI readability: both audiences are real; the tiebreak is structure.** Where they conflict (humans want flowing narrative; agents want actor-trigger-check lists), the Document should serve agents in the normative blocks and humans in the surrounding rationale — that is how the Organization's own best artifacts (charters, WO packets) already resolve it. Score against that pattern, not against either audience's purist preference.

**6. Rationale (C8) vs concision.** A rule stripped of its why to save space fails C8 and endangers C5.8; the acceptable compression is a *link* to the museum exhibit, not deletion of the causal story.

**7. Aggregation mechanics.** Per criterion: take the three reviewers' scores; if the spread exceeds 1 point, the divergent reviewers re-run the disputed probes jointly with evidence on the table before the council sees a number — scores converge on evidence, not on negotiation. Council verdict is one of: **PASS**, **PASS WITH CONDITIONS** (enumerated findings, each falsifiable, each with a criterion tag and severity), **FAIL** (any veto-class criterion below 3, or C5 below 2). The council's report should meet the standard this repository sets for its own auditor: every finding carries a citation a stranger could check, sampling frames are disclosed, and severity is argued from consequence to an adopter, not from taste.
