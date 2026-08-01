# Operating Protocol — Agentic FPGA Program

**Version 1.0 — ratified at G0.** This document is the constitution of the agent
org. Every agent reads it before acting. It defines how work moves, how
reasoning is preserved in git, and how the rules are mechanically enforced.
Amendments require an ADR (`docs/adr/`) and are committed only by the
orchestrator.

Roster, hierarchy, and per-agent duties live in [`ORG_CHART.md`](../ORG_CHART.md)
and [`agents/charters/`](charters/). This file defines the *shared* rules.

---

## 1. Purpose

A phased Hardcaml "low-latency trading NIC" (10G MAC + UDP/IP stack, then
MoldUDP64/ITCH 5.0 feed handler + order book) is designed, verified, validated,
documented, and audited entirely by Claude agents, orchestrated by a Fable 5
session that reports to the human sponsor (Renato). Two properties are
non-negotiable:

1. **Traceability**: for any commit range `A..B`, `git diff A..B` shows both
   the change and, adjacent in the same diff, the responsible agent's appended
   journal entry explaining the reasoning that produced it. No thinking is lost.
2. **Independence**: verification is never graded by the designer, and the
   auditor is never graded by anyone it audits.

## 2. Execution mechanics (ground truth)

- Claude Code subagents **cannot spawn subagents**. Therefore the
  **orchestrator is the sole spawner** of every agent (leads and workers) and
  the **sole operator of git**. No other agent ever runs `git commit` or
  `git push`.
- The lead → worker hierarchy is honored *logically*: a lead writes a work
  order; the orchestrator spawns the worker with that packet; the worker's
  output returns to the lead for review; the lead's verdict goes back through
  the orchestrator. The chain is reconstructible from packets, journals, and
  commit trailers.
- Leads are spawned as Opus-class agents, workers as Sonnet/Haiku-class agents,
  via the launcher definitions in `.claude/agents/`. Each launcher's first
  mandatory action is to read its charter in `agents/charters/` and this
  protocol.
- Agents are stateless between spawns. Continuity lives in the repo:
  charters (who you are), journals (what you did and why), handoff packets
  (what you owe and are owed), `tasks/BOARD.md` (program state).

## 3. Packets (`agents/handoffs/`)

All inter-agent transfers are versioned files, never chat-only. Types:

| Prefix | Name | Written by | Consumed by | Relay class |
|---|---|---|---|---|
| `WO-NNNN_<slug>.md` | Work order | A lead (or orchestrator) | A worker or lead | Summarizable |
| `SO-<module>.md` | DV sign-off packet (PASS/FAIL) | dv_lead | Orchestrator (merge precondition) | **Verbatim** |
| `BUG-NNNN_<slug>.md` | Bug packet | dv_lead | rtl_lead | **Verbatim** |
| `RV-NNNN_<slug>.md` | Review verdict (accept / defect list) | Reviewing lead | Worker (via orchestrator) | Summarizable |

**Relay rule**: the orchestrator may summarize *Summarizable* traffic when
routing it, but must relay *Verbatim*-class packets and all auditor findings
unedited — fidelity is load-bearing there. The auditor spot-checks relay
fidelity on the protected classes.

Work-order lifecycle: `DRAFT → ISSUED → RETURNED → ACCEPTED | BOUNCED`
(state recorded in the packet header; BOUNCED packets carry the defect list and
respawn as a new ISSUED revision). Every work order carries the
definition-of-done template (spec section, tests required, journal obligation,
docs touched).

## 4. Journals — the reasoning record

One append-only journal per agent identity:

- Orchestrator, leads, auditor: `agents/journals/claude_<name>_agent.md`
- Worker templates (shared per template, per-spawn entries):
  `agents/journals/workers/claude_<name>_agent.md`

A journal begins with a frozen header block ending in a `---` line. After the
header, the file grows **only by whole entries appended at end-of-file**.
Nothing above the last byte is ever edited. No agent writes another agent's
journal.

### 4.1 Entry grammar (machine-checked)

```markdown
## [J-<agent>-<NNNN>] <UTC ISO-8601> | task:<WO-id|none> | <one-line title>
### Trigger
Who invoked me and why (work order, review request, audit cycle, escalation).
### Inputs
Exact files/specs/ADRs/journal entries read (paths; SHAs where it matters).
### Reasoning
The decision narrative: options considered, why the winner won, what was
rejected and why. This is the section the commit diff exists to preserve.
### Actions
What was done (modules touched, commands run).
### Evidence
Exact reproducible commands and their observed results (test names, pass/fail,
artifact paths). Claims here must reproduce at this commit's SHA — the auditor
re-executes samples.
### Outcome
DoD status vs the work order (met / partially met + gaps) and the handoff
(packet path or reviewer).
### Open-questions
Escalations or unresolved items, or "none".
### Files-in-this-commit
- path/to/every/staged/non-journal/file  (or `- (none)` for journal-only)
```

Rules:
- `NNNN` is zero-padded and **strictly monotonic per journal** (next = last + 1).
- Worker entries additionally put the work-order ID in the header `task:` field
  and the spawn short-id in Trigger, preserving attribution within the shared
  template journal.
- The entry is written **before** the commit that carries the work, in the same
  working tree, so entry and work are inseparable in the diff.
- Entries that describe WHAT without WHY are an audit finding (vacuity).

### 4.2 `Files-in-this-commit`

The list must **set-equal** the commit's changed paths excluding the
committing agent's own journal (foreign journal seeds under R8 are listed) —
no more, no less. This is the mechanical binding between narrative and diff:
an entry cannot claim files it didn't touch, nor silently touch files it
didn't claim. Deleted paths count as touched and are listed.

## 5. Commit protocol (machine-enforced)

The orchestrator commits exclusively via **`scripts/agent_commit.sh`**, which
enforces, before any commit is created:

- **R1 — One agent per commit.** Mixed-agent changes are split into separate
  sequential commits.
- **R2 — Coupling.** Any commit touching work products must stage a pure
  EOF-append to exactly the responsible agent's journal containing the new
  entry. Work-without-journal is refused. Journal-without-work is allowed only
  with the `Journal-Only: true` trailer and a `- (none)` files list.
- **R3 — Append-only.** The staged journal's previous content (at HEAD) must be
  a byte-prefix of the staged version. Any edit above EOF is refused. Journal
  deletions and renames are always refused.
- **R4 — Files-list equality.** §4.2, checked by set comparison.
- **R5 — Monotonic entry IDs.** The new entry's `NNNN` = last `NNNN` in HEAD
  version + 1 (0001 for a journal's first entry).
- **R6 — Trailers.** The commit message ends with:

  ```
  Agent: <agent-name>
  Work-Order: <WO-id or none>
  Journal-Entry: J-<agent>-<NNNN>
  ```
  plus `Journal-Only: true` when applicable.
- **R7 — Path isolation.** Every staged non-journal path must be inside the
  committing agent's write scope (§6).
- **R8 — Foreign journal seeding only.** A commit may additionally stage
  another agent's journal *only* as a newly created file containing a header
  and zero entries (bootstrap/onboarding). Modifying another agent's existing
  journal is always refused.
- **R9 — Serialized history.** All commits land sequentially on the single
  working branch. No per-agent branches, no rebases of pushed history, no
  force pushes. Merges to `main` happen only at milestone boundaries via PR.

**CI re-verification**: `.github/workflows/journal-check.yml` runs
`scripts/check_journals.sh` over the entire pushed range and re-checks
R1–R8 for every commit (append-only across the range, monotonic IDs,
files-list equality, trailer well-formedness, path isolation). A locally
bypassed check (`git commit --no-verify` outside the script) still fails on
GitHub before merge. **One out-of-repo dependency**: branch protection on
`main` (no force push, `journal-check` required) must be configured once by
the human sponsor — G0 checklist item.

Result: `git log --grep 'Agent: rtl_lead'` reconstructs any agent's thread;
`git diff A..B` always contains the reasoning for what changed.

## 6. Path isolation (write scopes)

Enforced by R7 at commit time and re-checked in CI. Read access is unrestricted
except where a charter says otherwise (e.g. tb_writer must not read RTL —
enforced by prompt + work-order content + audit, and honestly documented as
such; Claude Code has no native per-path read denial).

| Agent | May stage (non-journal) |
|---|---|
| `orchestrator` | Everything. Sole owner of `scripts/`, `.github/`, `.claude/`, `tasks/`, `agents/PROTOCOL.md`, `agents/charters/`, dune/opam project files. |
| `architect_docs_lead` | `docs/**` (except `docs/reports/audit/`, `docs/reports/latency/`), `README.md`, `ORG_CHART.md`, `agents/handoffs/**` |
| `rtl_lead` | `libs/**`, `top/**`, `bin/**`, `rtl_snapshots/**`, `agents/handoffs/**` |
| `dv_lead` | `test/**`, `tools/**`, `docs/reports/latency/**`, `agents/handoffs/**` |
| `auditor` | `docs/reports/audit/**` only |
| `rtl_module_dev` | `libs/**`, `top/**` (narrowed further by its work order) |
| `tb_writer` | `test/**` |
| `data_wrangler` | `tools/**` |
| `formal_dv` | `test/**` |

Key consequences: RTL-line agents can never stage tests or golden models;
DV-line agents can never stage RTL; the auditor can never fix what it finds.

## 7. Gates

Three committed gate checklists per phase, in `docs/gates/`, plus G0.
A gate is passed when its checklist file is fully signed — every signature is a
journal-entry reference (`J-<agent>-NNNN`), so governance itself is diffable.

| Gate | Precondition to pass |
|---|---|
| `G0` (once) | Org ratified by sponsor; protocol self-test green; CI journal-check green; branch protection configured by sponsor. |
| `P<n>-spec-freeze` | Architect's specs complete with REQ-### requirements; interface records compile; dv_lead countersigns testability. |
| `P<n>-module-ready` | Per-module DV sign-off packets (`SO-*.md`) PASS; auditor's seeded mutations all killed by the DV suite; line-rate stress green for rx-path modules. |
| `P<n>-phase-accept` | System replay clean; latency report committed; audit report committed with no open CRITICAL findings; sponsor approval (escalation class E1). |

## 8. Escalation to the human sponsor

The orchestrator escalates **only** these classes, batched and decision-ready
(options + recommendation + cost):

- **E1** — Phase-gate approval.
- **E2** — Scope changes (adding/dropping requirements, phases, or roles).
- **E3** — Toolchain lane and licensing decisions.
- **E4** — Auditor CRITICAL findings (relayed verbatim, never summarized away).
- **E5** — Two-lead deadlock surviving one round of written argument.
- **E6** — Budget/schedule anomalies (e.g. a phase tracking >2× its estimate).

Everything else is decided inside the org and recorded in journals/ADRs.

## 9. Rehydration

The org must survive the loss of any session, including the orchestrator's:

- `tasks/BOARD.md` — live program state: current milestone, open work orders,
  gate status, pending escalations. The orchestrator updates it in the same
  commit as any state change it describes.
- `agents/journals/INDEX.md` — journal directory: one row per journal with
  last entry ID and a one-line current-state summary. Updated at gate
  boundaries (best-effort aid, not the live source of truth).
- **Procedure**: a fresh orchestrator session reads `BOARD.md` → this protocol
  → `ORG_CHART.md` → the journal tails of agents with open work. This is
  deliberately exercised once mid-Phase 1 (kill and rehydrate) as a drill.

## 10. Independence & evidence rules

- DV derives all tests from **specs, never from RTL**; tb_writer work orders
  deliberately omit RTL source. Journal Inputs sections are the audit evidence.
- Golden models must agree with an **external anchor** before they may judge
  RTL (Phase 2 book model vs a published reference implementation; Phase 1
  MAC/UDP vs verilog-ethernet differential co-sim).
- The **auditor owns the DV-escape ledger** (`docs/reports/audit/`): any
  post-sign-off divergence found later is recorded there, not by DV.
- Mutation discipline: per module, the auditor plants N seeded RTL mutations;
  the DV suite must kill all N before `module-ready` is signed.
- Licensing: `verilog-ethernet` (MIT) may be read and co-simulated freely.
  `Essenceia/Nasdaq-HFT-FPGA` (CC BY-NC) is prior art to *consult only* —
  never port code. All shipped RTL is written from specs.

## 11. Amendment procedure

Any change to this protocol, a charter, or the enforcement scripts requires:
(1) a numbered ADR in `docs/adr/` recording alternatives and rationale,
(2) an orchestrator journal entry, (3) if the change alters enforcement
semantics, an updated `scripts/test_protocol.sh` case proving the new behavior.
