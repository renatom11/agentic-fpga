# BOB audit: docs/PROCESS.md vs the record

Scope: /home/user/agentic-fpga/docs/PROCESS.md checked against agents/PROTOCOL.md, scripts/ (agent_commit.sh, check_journals.sh, policy.sh, test_protocol.sh, verify_journal_chain.sh), .github/workflows/, agents/journals/ (25 volumes + workers), docs/adr/ (ADR-0001..0020), docs/gates/, agents/charters/, agents/handoffs/, docs/reports/audit/, tasks/BOARD.md, docs/SPONSOR.md, and git history. Anonymization is not treated as a finding. Findings ranked by severity.

---

## F1 (MAJOR) — "Signers cannot stage the checklist. Because write scopes forbid it" is false, mechanically and in practice

PROCESS §3.7: "**Signers cannot stage the checklist.** Because write scopes forbid it, the orchestrator transcribes every signature." (echoing PROTOCOL §7: "signers cannot stage `docs/gates/**` themselves (§6)").

The record contradicts both halves:

- **Mechanically**: /home/user/agentic-fpga/scripts/policy.sh `agent_may_write` gives architect_docs_lead `docs/*` with only `docs/reports/audit/*` and `docs/reports/latency/*` carved out. `docs/gates/**` is inside the architect's write scope, and the architect is a gate signer (P1-spec-freeze conditions are its own deliverables; it also owns rows on P1-module-ready).
- **In practice**: `git log -- docs/gates/` shows four commits trailered `Agent: architect_docs_lead` staging gate files, including commit `61e0c76` which stages **docs/gates/P1-module-ready-checklist.md itself** plus lessons-harvest-block.md, and `ec5d906`/`8734c10`/`43c0087` staging lessons-harvest-block.md.

The real control is a convention written inside the checklist ("no box in this file is checked by its author", P1-module-ready-checklist.md top) — review-enforced, not scope-enforced. PROCESS's own §2.1 states the standard this violates: "A control that is claimed to be mechanical and is not is worse than a control known to be advisory, because the claim suppresses the compensating vigilance." §6.1 likewise: "any statement in this document that a control is mechanically enforced — check it in your own machinery before you repeat it." This claim was repeated unchecked from PROTOCOL §7, whose claim is itself false against policy.sh.

## F2 (MAJOR) — The audit backstop is presented as operating reality; the record shows it ran once, ten days and ~85% of the record ago

PROCESS leans on auditor sampling as the compensating control for every non-mechanical rule: §1.5 "It re-executes evidence... the auditor re-runs samples. This is what makes the evidence sections falsifiable rather than decorative"; §4.3 "The auditor spot-checks relay fidelity on the protected classes"; §2.1 orchestrator splitting "enforced by audit and not by machine"; §1.4(c) blinding enforced by "audit of the 'inputs' section of each reasoning log"; §3.1 narrative quality "enforced by audit sampling."

The record (agents/journals/claude_auditor_agent*.md, all 23 entries; docs/reports/audit/):

- Evidence re-execution happened exactly once: AUD-0001-g0-retro.md §5 (2026-08-01, 4/6 claims re-executed). Nothing since — J-auditor-0004 through 0018 are mutation-seeding rounds; 0019 is a harvest; 0020 a timestamp census; 0021–0023 ADR-0020 countersignatures. No sampling audit of Inputs/blinding, no orchestrator-split audit, no narrative-vacuity round has ever run over the build-phase record.
- Relay-fidelity spot-checks: zero instances. The auditor's own journal (claude_auditor_agent.md:252) records "Relay fidelity is untestable so far — no verbatim-class packet has ever been [relayed]" — and no spot-check followed once verbatim-class packets existed (BUG-0001..0004, SO-xgmii_rx_64).
- The auditor's charter names itself "the compensating control the whole org's honesty notes point at" (agents/charters/auditor.md, honest-enforcement note) — and schedules re-execution per phase gate, which has not arrived.
- What that gap costs is in the record: J-auditor-0020 (2026-08-11), "the census nobody took returns 234 wrong dates" — a decayed remedy that accumulated across the majority of the record because no audit cycle was looking (PROCESS §5.1 narrates this very incident as a museum piece without conceding that the sampling regime §1.5 describes was the thing that wasn't running).

PROCESS describes the auditor's charter; the record shows the auditor spent the entire build phase as a mutation seeder.

## F3 (MAJOR) — "Every rule the commit script enforces is re-verified by continuous integration" is false for the journal size cap — an asymmetry the document itself declares to be a defect

PROCESS §2.5: "Every rule the commit script enforces is re-verified by continuous integration over the entire pushed history." PROCESS §2.4 corollary: "If a check exists on one surface — the local commit path — and not on the other... the asymmetry is itself the defect. Both surfaces or neither."

The record: scripts/agent_commit.sh refuses appends beyond `JOURNAL_HARD_MAX` (R10 limb, lines 177–179); scripts/check_journals.sh contains **no size check at all** (no JOURNAL_HARD_MAX/JOURNAL_SOFT_MAX reference). A `git commit --no-verify` over-append passes CI clean. ADR-0017 applied the both-surfaces corollary to the blob gate (minting R11, §6.6) but never put H into check_journals.sh, and neither PROTOCOL §5 nor ADR-0017 declares the residue. PROCESS's blanket claim is exactly the "guarantee cited for the life of the program and never true" its own §2.5 warns about.

## F4 (MEDIUM) — The recovery drill is asserted as performed; it has never happened

PROCESS §1.6: "This is exercised once mid-program as a drill — killed and rehydrated on purpose... The drill exists because an untested recovery procedure is a hypothesis."

The record: zero occurrences of any drill in all 25 journal volumes, tasks/BOARD.md, or docs/gates/. PROTOCOL §9 schedules it ("deliberately exercised once mid-Phase 1") — future tense. Phase 1 has reached its first module PASS (SO-xgmii_rx_64.md, 2026-08-11) with no drill. By the document's own sentence, the recovery procedure remains a hypothesis, and §1.6 states it as an exercised fact.

## F5 (MEDIUM) — "Everything that moves between seats is a versioned file" — the record institutionalized packet-less "dispatch-only" work orders

PROCESS §3 preamble and §3.2 present the work-order packet (state machine, DoD, context, out-of-scope) as the universal transfer form. The record contains WO ids with **no packet file at any commit**: `git log --all -- 'agents/handoffs/WO-0048*' 'WO-0051*' 'WO-0052*' 'WO-0053*'` returns empty, yet these ids are live in journal `task:` headers and board rows — WO-0048 was a repo-wide REQ-901 cascade (board note: "dispatch-only, noted as such"), WO-0051/0052 the ADR-0016/0017 constitutional-amendment rounds, WO-0053 the first journal rotation. The orchestrator's own board census also records WO-0044 as "a real packet round never rowed" — the "live picture" board (§1.6, "updates it in the same commit as any state change") demonstrably drifted and needed a census to repair. PROCESS acknowledges neither the dispatch-only class nor the board decay.

## F6 (MEDIUM) — §3.9's separations are described as settled machinery; the record shows a constitution still contradicting the practice, and a rule one day old at the document's writing

- PROTOCOL §10 (current text, lines 399–402) still says the orchestrator "applies each manifest transiently in an **uncommitted working tree**... reverts fully, and never lets mutated RTL enter history." The measured reality (ADR-0019 §1.1): all fifteen campaigns ran as **plain `git commit` + push of never-merged `mut/*` refs — 85 refs, none deleted** — because the CI-only toolchain (ADR-0005) makes a local run impossible. ADR-0019, the authorizing instrument, is still **PROPOSED** with its §7 protocol diffs owed; PROTOCOL contains zero references to ADR-0019. PROCESS §3.9 narrates the pushed-ref model as the program's considered design while the constitution it praises for rule/check coherence still states the abandoned model — the precise "rule and its check that disagree about what compliance is" of PROCESS §2.4.
- "The seeder never operates the repository... because it does not push" — in force only since J-orchestrator-0218 (2026-08-10), after the auditor **did** cut, commit and push branches at WO-0073 on the orchestrator's own instruction, plus "three prior deviations" (ADR-0019 §1.2). PROCESS presents a day-old, not-yet-ratified rule as standing discipline.
- Side effect neither document names: journal-check runs `on: push` with no branch filter, so every mut-ref push produced a red journal-check run (plain commits, no trailers) — ~85 tolerated red runs.
- Also §3.9's "on a fixed cadence" — the record's cadence is per-module event sequencing (after RV-ACCEPT, before SO-PASS), not a fixed cadence.

## F7 (MEDIUM-MINOR) — The sealed-prediction file's described structure does not match the record's seals, and could not exist as described

PROCESS §3.3: the seal file carries "the commit at which it was frozen, **and its own hash at that commit** — so that byte equality between freeze and unsealing is checkable by anyone."

The record: WO-0039_..._SEALED-predictions.md's header carries base bench SHA + freezing journal entry, no freeze-commit id, no self-hash. WO-0077's header states outright: "**Frozen against**: the commit that stages this seal... **I cannot state its hash: I never run git, and it has none until the orchestrator creates it.**" A file cannot contain its own hash; byte equality is checked by `git diff` against the staging commit under R3 — a different (and sound) mechanism than the one PROCESS describes. The document invents a field the artifact grammar neither has nor could have.

## F8 (MINOR) — The RV review-verdict packet type has never existed as a file

PROCESS §3.2 "The review verdict itself is a packet," matching PROTOCOL §3's `RV-NNNN_<slug>.md` row ("Written by: reviewing lead"). No RV-*.md file exists in agents/handoffs/ or anywhere in history. Verdicts are `RV-XXXX-VERDICT` sections appended to the WO packet's own Return log (e.g. WO-0040_tb-m03-family-d-fcs.md line 489, signed `J-dv_lead-0039`). The practice is defensible; the described form is fictional.

## F9 (MINOR) — "Severities are fixed — critical, major, minor" omits the scale actually used

PROCESS §3.4. The auditor's record uses four grades: AUD-0001 is titled "1 CRITICAL, 5 MAJOR, 7 MINOR, **4 NOTE**" (J-auditor-0001, docs/reports/audit/AUD-0001-g0-retro.md).

## F10 (MINOR) — The advisory-warning layer §2.4 describes is mostly unbuilt

The only warning in the machinery is WARN-JOURNAL (a size/structure rule, agent_commit.sh:181). WARN-SEAL exists only as a "may emit" in PROTOCOL §10 — no script emits it. No timestamp/testimony warning was added after the census that motivated §5.1's "the warning buys latency" corollary (scripts/ untouched since 2026-08-04; census 2026-08-11). §2.4(b)'s "A warning is right there" describes a designed class with zero implemented members.

## F11 (MINOR) — "each worker is narrowed further by its packet" sits inside the mechanically-checked scope section, but the narrowing is not mechanical

PROCESS §2.3 presents scopes as "checked at commit time and re-checked in continuous integration," then lists per-packet worker narrowing among the consequences. policy.sh grants each worker its full class scope (`rtl_module_dev`: all of `libs/*`,`top/*`); per-WO narrowing is prompt/review-enforced. A document that prides itself on naming residues (read access, orchestrator splitting) leaves this one unnamed.

## F12 (MINOR) — The journal index is described as a maintained navigation aid; it is dead

PROCESS §1.6: "a journal index — one row per log with its last entry and a one-line summary, refreshed at boundaries." agents/journals/INDEX.md was written at G0 (2026-08-01) and never touched: it still lists rtl_lead/dv_lead as "Not yet activated" while dv_lead is eleven volumes deep, and predates the volume-chain era entirely. Letter-compliant (only one boundary has passed) but materially misleading about the artifact's usefulness.

## F13 (MINOR) — Small overstatements, collected

- §1.1/§3.2 packet numbering "monotonic by construction": the record contains letter-suffixed ids outside the NNNN scheme (WO-0063A, WO-0063B — agents/handoffs/) and gaps; construction required improvisation.
- §4.7 "spot-check the whole program by hand in four commands": docs/SPONSOR.md gives three git commands plus an ORG_CHART walk plus a CI-tab check.
- PROTOCOL §10 names `docs/reports/audit/mutations/`; actual manifests live in per-campaign `docs/reports/audit/WO-*-mutations/` dirs (constitutional drift PROCESS inherits silently via "the manifests" framing).

## Real mechanisms the document omits

- **The blob gate (ADR-0002/R11)**: a machine-enforced rule in both agent_commit.sh and check_journals.sh (1 MB cap, journal carve-out per ADR-0017 D1) — absent from §2.6's rule table and the whole document.
- **verify_journal_chain.sh**: a third enforcement surface (from-a-checkout chain auditor, ADR-0017 §6.5) with an unusually honest limit statement — "a green chain is not a clearance for the volume currently being written" — exactly the kind of named-residue discipline PROCESS elsewhere celebrates, unmentioned.
- **The seal's second-copy discipline**: freezes are committed twice (seal file + the freezing journal entry, WO-0039 SEALED §0 "if either is later edited to fit a result, the other exposes it") — a real anti-tamper mechanism §3.3 does not mention.
- **The unchecked byte-count field**: volume headers carry `Previous-volume-bytes` (§2.2's "byte count"), but no script verifies it — only path, sha256, Volume, and Continues-from are checked (agent_commit.sh:121–141, check_journals.sh:213–239). The document lists the field among the chain's freight without noting it is testimony, in a document that elsewhere insists records "say which of its fields is testimony and which is structure" (§5.4).
- **A live-fire proof the document undersells**: §2.5 calls branch protection an unverified external dependency and §6.2 demands live-fire verification; the record actually has the live fire — a `git push --force-with-lease` refused on a transient ref (ADR-0019 §1.2, J-auditor-0015). The strongest evidence for the document's own claim goes uncited.

## Summary judgment

The mechanical core PROCESS describes (R1–R10 coupling, append-only, files-list equality, path isolation, chain rotation, full-history CI re-check, trailer protection, merge triviality) is real, implemented, and self-tested (42 cases in scripts/test_protocol.sh) — the document is accurate where it describes scripts. It is least accurate exactly where it praises its own honesty: two mechanical claims are false against the machinery (gate staging, F1; CI size re-verification, F3), the audit backstop it repeatedly invokes has been dormant for the entire build phase (F2), one asserted event never occurred (F4), and several described forms (RV packets, seal self-hash, three-grade severities, advisory warnings) are the constitution's aspirations rather than the record's practice.