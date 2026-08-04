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
- Leads are spawned as Opus-class agents, workers as Sonnet-class agents,
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
docs touched). Packet participants update their packet's Return log directly —
`agents/handoffs/` is inside every agent's write scope (§6) **except the
auditor's**, precisely so the packet lifecycle is executable by its
participants.

**Auditor exception (ADR-0003)**: the auditor stages `docs/reports/audit/**`
and nothing else, ever — deliberately, so it can never modify an artifact it
audits, including other agents' packets. Its `RETURNED` verdicts are therefore
recorded in its committed report and journal entry, and the **orchestrator
transcribes** them into the packet's Return log under its own trailer — the
same clerical-transcription rule §7 uses for gate signatures, with authority
living in the auditor's own committed artifacts.

**Packet numbering**: the orchestrator — as sole committer — allocates the
next `NNNN` per prefix when a packet is first committed; drafts circulating
before commit use a placeholder id. This makes monotonic-per-prefix numbering
enforceable by a single authority.

**Withheld results**: a packet that says it is holding a sealed prediction, a
sealed sweep or an undisclosed mapping must ship that seal as a file in the same
commit — §10's **R-SEAL-1**.

## 4. Journals — the reasoning record

One append-only journal per agent identity:

- Orchestrator, leads, auditor: `agents/journals/claude_<name>_agent.md`
- Worker templates (shared per template, per-spawn entries):
  `agents/journals/workers/claude_<name>_agent.md`

A journal begins with a frozen header block ending in a `---` line. After the
header, the file grows **only by whole entries appended at end-of-file**.
Nothing above the last byte is ever edited. No agent writes another agent's
journal.

### 4.1 Entry grammar (structure machine-checked; narrative audit-enforced)

Only the entry's *structure* is mechanically verified: the header line, the
one-entry-per-commit rule, monotonic IDs, and the `Files-in-this-commit`
section (presence + set-equality). The presence and quality of the narrative
sections (Trigger through Open-questions) are enforced by auditor sampling,
not by script.

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
re-executes samples. Cite only (a) commands runnable from a repo checkout, or
(b) externally verifiable references (e.g. a CI run ID and its conclusion);
mentions of ephemeral artifacts must say so explicitly (ADR-0003/F5).
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
  template journal. **Spawn short-id**: a unique token the orchestrator mints
  into every worker spawn prompt — work-order id + spawn UTC timestamp, e.g.
  `WO-0012/2026-08-01T16:00Z` — which the worker copies verbatim into Trigger.
- The entry is written **before** the commit that carries the work, in the same
  working tree, so entry and work are inseparable in the diff.
- An entry body must never contain a line beginning `## [J-<own-agent>-NNNN]`
  (quote prior headers indented or inside a sentence, never at column 0) —
  the structural parsers are deliberately simple and count such lines as
  entry headers.
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
  sequential commits. *Honesty note*: for scoped agents this is emergent from
  R7+R8 (a commit cannot mix two scoped agents' work); for the orchestrator —
  whose scope is everything — correct attribution and splitting is
  audit-enforced, not mechanical. The mechanical invariant is one journal
  append per commit.
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
  plus `Journal-Only: true` when applicable. Additional informational
  trailers (e.g. `Co-Authored-By:`, `Claude-Session:`) may be appended via
  the script's `--extra-trailer` flag; the four protected keys above are
  rejected as extra trailers, and CI rejects duplicate protected trailers so
  none can be shadowed.
- **R7 — Path isolation.** Every staged non-journal path must be inside the
  committing agent's write scope (§6).
- **R8 — Foreign journal seeding only.** A commit may additionally stage
  another agent's journal *only* as a newly created file containing a header
  and zero entries (bootstrap/onboarding). Modifying another agent's existing
  journal is always refused.
- **R9 — Serialized history.** All commits land sequentially on the single
  working branch (currently `claude/fpga-hardcaml-agent-orchestration-37ceyf`;
  the current name is always recorded in `tasks/BOARD.md`). No per-agent
  branches, no rebases of pushed history, no force pushes. Merges to `main`
  happen only at milestone boundaries via PR and must be **trivial**: CI
  verifies a merge commit's tree equals one of its parents' trees (it
  introduces no content of its own — constituent commits are checked
  individually); octopus merges are rejected outright. No-force-push is
  ultimately guaranteed by GitHub branch protection on *both* `main` and the
  working branch — a sponsor-side setting (G0 checklist), without which R9 is
  convention only.

**CI re-verification**: `.github/workflows/journal-check.yml` runs
`scripts/check_journals.sh` over the entire pushed range and re-checks
R1–R8 for every commit (append-only across the range, monotonic IDs,
files-list equality, trailer well-formedness, path isolation). A locally
bypassed check (`git commit --no-verify` outside the script) still fails on
GitHub before merge. **One out-of-repo dependency**: branch protection on
`main` **and the working branch** (no force push, no deletion, `journal-check`
required, no admin bypass) must be configured once by the human sponsor — G0
checklist item.

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
| `rtl_module_dev` | `libs/**`, `top/**` (narrowed further by its work order), `agents/handoffs/**` (its packet's Return log) |
| `tb_writer` | `test/**`, `agents/handoffs/**` (its packet's Return log) |
| `data_wrangler` | `tools/**`, `agents/handoffs/**` (its packet's Return log) |
| `formal_dv` | `test/**`, `agents/handoffs/**` (its packet's Return log) |

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

**Signature transcription**: signers cannot stage `docs/gates/**` themselves
(§6), so the **orchestrator transcribes** all gate-checklist signatures. A
signature's authority is the referenced `J-<agent>-NNNN` entry, which must
itself state "I sign gate X item Y" in the signer's own journal — the
checklist edit is clerical and commits under `Agent: orchestrator`.

**Phase hardening**: "P\<n\> hardening" means the window between
`P<n>-module-ready` and `P<n>-phase-accept`. It is the activation window for
`formal_dv` and the overlap trigger for the contingent `rtl_lead_md`.

**Lessons harvest** (ADR-0018). Every module sign-off (`SO-`) and every phase
gate carries one; it is a precondition of the gate, not a follow-up to it. Each
agent holding a persistent journal chain — the leads, the auditor, the
orchestrator — mines **its own** journal over the span since its last harvest,
stated as an entry-id interval so that spans tile and a skipped harvest is a
visible gap, and records the yield as a harvest note in its journal entry for
the round; a lead also mines the worker spans it commissioned. A candidate rule
is admissible only if it **(LH1)** cites the incident commit(s) that taught it,
**(LH2)** states its observable in terms portable beyond this project — no
module, requirement, signal, protocol or toolchain name inside the rule
statement — and **(LH3)** says what breaks without it. Anything failing the bar
is recorded as a war story and goes no further; a nil yield is declared, never
omitted. The **orchestrator collates**: into the gate record locally, and into
the generic shell's `LESSONS` file with permalinked provenance, the shell
unfreezing for **exactly one commit per harvest**, sponsor-visible at the gate —
the sponsor may refuse a candidate. A gate is not passed while any box of the
instantiated `docs/gates/lessons-harvest-block.md` is unchecked. *Enforcement*:
review-enforced, like §10 — no `R`-rule is minted and no script changes, so
§11(3) owes no test case (ADR-0018 §7.4).

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
- Mutation discipline — the **transient model**, sequenced: the auditor
  authors mutation manifests (patches) under `docs/reports/audit/mutations/`;
  the **orchestrator applies each manifest transiently in an uncommitted
  working tree**, runs the DV suite against it, reverts fully, and never lets
  mutated RTL enter history. Sequencing: for each module, the campaign runs
  **after rtl_lead's `RV-` ACCEPT and before dv_lead may issue `SO-` PASS**,
  so every PASS reports kills N/N (N ≥ 3, spanning distinct defect classes)
  and `module-ready` merely re-checks it. No RTL-line or worker agent is
  spawned while a manifest is applied; the "report, never repair a suspected
  seeded mutation" clauses in RTL-line charters are the safety net for a
  sequencing error, not the normal case.
- **R-SEAL-1 — a seal is a file, not a sentence** (ADR-0016). A commit may not
  **introduce** a claim that a result already exists and is being withheld from
  the reader — a sealed prediction, a sealed sweep, an undisclosed mapping, any
  "I hold this and am not showing you yet" — unless that same commit also stages
  the artifact holding the withheld result, so that the seal appears in the
  commit's own `Files-in-this-commit` list. **A withheld result that is not a
  committed artefact is not a seal, it is a claim.** Three things this rule does
  not reach. A **forward commitment** ("the mapping will be sealed before any
  diff exists") is a promise, redeemed by the later commit that freezes the
  seal, which is itself bound. **An unredeemed promise is not cured by this
  exclusion**: if no commit has staged the seal by the time the result it seals
  against exists, the round is adjudicated as having no seal — the claim it was
  supposed to support may not be made, and the absence is a finding. A
  **retrospective reference** to a seal already in history ("the mutation died
  where the seal said it would"), including quoting the claim in order to convict
  it, is not a new claim. And **sealing in the finalise-a-decision sense** (a
  countersignature "CLOSED and SEALED") withholds nothing and is outside the rule
  entirely. *Enforcement*: **review-enforced**, like the rest of §10 — it is
  deliberately **not** an `R1`–`R9` commit rule, because distinguishing a claim
  from a quotation is not a lexical test. The scripts may emit an advisory
  `WARN-SEAL`; a warning is not a verdict and its absence is not a clearance. The
  rule makes seals countable, not good: a vacuous seal passes it and is caught at
  adjudication, where a prediction that selects nothing cannot be scored.
- Licensing: `verilog-ethernet` (MIT) may be read and co-simulated freely.
  `Essenceia/Nasdaq-HFT-FPGA` (CC BY-NC) is prior art to *consult only* —
  never port code. All shipped RTL is written from specs.

## 11. Amendment procedure

Any change to this protocol, a charter, or the enforcement scripts requires:
(1) a numbered ADR in `docs/adr/` recording alternatives and rationale,
(2) an orchestrator journal entry, (3) if the change alters enforcement
semantics, an updated `scripts/test_protocol.sh` case proving the new behavior.

Program-scope parameters (phase decomposition, clock/datapath figures,
book depth, message subsets) are canonically stated in README's phase table
(from M1: the top-level spec in `docs/specs/`); charters restate them only
for convenience. A scope-parameter change updates the canonical statement
AND every restatement — the amending ADR lists the touched files (grep for
the changed value).
