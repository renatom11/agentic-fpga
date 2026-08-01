# ADR-0001: Agent org design — "Lean Five" with enforcement grafts

- **Status**: Accepted (sponsor decisions 2026-08-01; org ratification pending
  at G0)
- **Deciders**: Renato (sponsor), orchestrator
- **Provenance**: 7-agent design workflow — parallel research (Hardcaml
  ecosystem, candidate project scoping, Claude Code agent mechanics), three
  independent org designs, adversarial judging.

## Context

The full FPGA lifecycle (architecture → RTL → verification/validation → docs →
audit) is to be executed by Claude agents under a Fable 5 orchestrator, with
every agent's instructions user-openable and every agent's reasoning preserved
in version-controlled append-only journals. Two hard mechanical constraints:
Claude Code subagents cannot spawn subagents, and concurrent agents share one
working directory — any org design that assumes nested spawning or parallel
per-agent branches cannot execute as written.

Sponsor decisions fixed before design: phased NIC→feed-handler project,
simulation-first target, M0 = org + charter only, direct-commit git flow.

## Decision

Adopt the **"Lean Five"** org (scored 86/100 by the design judge): five
long-lived minds — orchestrator (Fable 5), architect_docs_lead, rtl_lead,
dv_lead, auditor (Opus 5) — plus three worker templates (rtl_module_dev,
tb_writer — Sonnet; data_wrangler — Haiku/Sonnet). The orchestrator is the
sole spawner and sole git committer; lead→worker hierarchy is honored
logically via versioned work-order packets. Architecture+docs are one role
(eliminates spec/doc drift); verification+validation are one role (one owner
for stimulus, golden models, and replay).

Graft onto it the strongest elements of the two runner-up designs:

1. **Mechanical journal↔diff binding** (from "Twin-Ladder", 81/100): commits
   only via `scripts/agent_commit.sh`; each entry's `Files-in-this-commit`
   list must set-equal the staged non-journal paths; pure EOF-append checked
   byte-wise; trailers bind commit→entry; CI re-verifies the whole pushed
   range; path-isolation rules per agent.
2. **Evidence falsifiability** (Twin-Ladder): journal Evidence sections carry
   exact reproducible commands; the auditor re-executes samples at the
   recorded SHA — unreproducible claims are CRITICAL findings.
3. **Minimal gate ladder** (from "Silicon-Team Mirror", 74/100, reduced from
   its six gates to three): spec-freeze → module-ready → phase-accept, as
   committed checklists whose signatures are journal-entry references.
4. **Closing the merged-DV self-grading hole**: the auditor (not DV) owns the
   DV-escape ledger; golden models require external anchors before judging
   RTL; the auditor runs systematic seeded-mutation campaigns that the DV
   suite must kill, plus one independent replay re-run per phase.
5. **Traceability & formal** (Silicon-Team Mirror): REQ-### requirements with
   a requirement→test matrix; a dormant `formal_dv` worker for
   hardcaml_verify SAT checks on CRC/checksum/64b66b blocks.
6. **Pressure-relief valve**: contingent `rtl_lead_md` (Phase-2-scoped second
   RTL lead) if Phase 1 hardening overlaps Phase 2 development.
7. **Rehydration artifacts**: `tasks/BOARD.md` + `agents/journals/INDEX.md`;
   a fresh-orchestrator resume drill is scheduled mid-Phase 1.

## Alternatives considered

- **"Silicon-Team Mirror"** — 18 agents mirroring a real silicon org with six
  sign-off gates. Rejected: ceremony disproportionate to ~10k lines of OCaml;
  a lone sponsor cannot track 18 agents; its parallel-branch mechanics don't
  survive Claude Code's shared working directory.
- **"Twin-Ladder"** — verification-sovereign twin hierarchies meeting only at
  the orchestrator, ~19 agents, universal verbatim relay. Rejected as a whole:
  relay tax consumes the orchestrator; its ff-only + no-rebase parallel-branch
  model is internally incoherent. Its enforcement core and falsifiability
  ideas are adopted (grafts 1-2).
- **Single do-everything agent per phase** — rejected: no independence between
  design and verification, no audit surface, and the sponsor's explicit goal
  is a full breadth-of-lifecycle org.

## Consequences

- Positive: an org one human can hold in their head; git mechanics that
  actually execute; the strongest available guarantee that any commit range
  carries its reasoning; verification independence despite the lean roster.
- Negative / accepted risks: the orchestrator is a single point of failure
  (mitigated by rehydration artifacts + drill); merged DV role concentrates
  judgment (mitigated by graft 4); serialized commits limit parallel file
  mutation (worktrees may be introduced later if genuinely needed — a future
  ADR).
- One out-of-repo dependency: sponsor-configured branch protection on `main`
  (G0 checklist item) — without it the append-only guarantee is voidable by
  force push.
