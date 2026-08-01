# Org Chart — Agentic FPGA Program

Every box below is an agent with a full, version-controlled charter in
[`agents/charters/`](agents/charters/) — open it to see exactly how that agent
operates: responsibilities, interfaces with every other agent, definition of
done, evaluation criteria, and escalation rules. Shared rules live in
[`agents/PROTOCOL.md`](agents/PROTOCOL.md). Every agent's reasoning is
preserved in its append-only journal in
[`agents/journals/`](agents/journals/), committed atomically with its work.

```mermaid
flowchart TD
    H["Renato — Human Sponsor
    final authority: phase gates, scope,
    toolchain & licensing, org changes"]

    O["ORCHESTRATOR — Fable 5
    (main Claude Code session)
    planning · task routing · sole spawner
    sole git/CI custodian · escalation to sponsor"]

    A["ARCHITECT & DOCS LEAD — Opus 5
    specs · ADRs · REQ-### requirements
    interface contracts · all documentation"]

    R["RTL LEAD — Opus 5
    all shipped Hardcaml (libs/, top/)
    hard modules · worker review
    RTL generation & determinism"]

    V["DV LEAD — Opus 5
    verification + validation
    spec-derived tests · golden models
    replays · latency · DV sign-off packets (SO-)"]

    X["AUDITOR — Opus 5, independent
    journal/commit invariants · spec drift
    mutation campaigns · evidence re-execution
    DV-escape ledger · audits everyone"]

    RW["rtl_module_dev — Sonnet ×N
    one module per frozen spec packet"]

    RM["rtl_lead_md — Opus 5
    CONTINGENT: Phase-2 second RTL lead
    (Mold/ITCH/book scope)"]

    TW["tb_writer — Sonnet ×N
    spec-derived tests
    (work orders omit RTL source)"]

    DW["data_wrangler — Sonnet
    ITCH data · packetizer
    golden trajectories"]

    FD["formal_dv — Sonnet, DORMANT
    hardcaml_verify SAT checks
    (activates at Phase-1 hardening)"]

    H --- O
    O --> A
    O --> R
    O --> V
    O --> X
    R -. "logical direction, spawned by O" .-> RW
    O -. "activates via E2 (Phase 2)" .-> RM
    V -. "logical direction, spawned by O" .-> TW
    V -. "logical direction, spawned by O" .-> DW
    V -. "on activation" .-> FD
    X -. audits .-> A
    X -. audits .-> R
    X -. audits .-> V
    X -. audits .-> O

    style X stroke-dasharray: 5 5
    style FD stroke-dasharray: 3 3
    style RM stroke-dasharray: 3 3
```

## Roster

| Agent | Model | Reports to | Charter | Journal | Status |
|---|---|---|---|---|---|
| `orchestrator` | Fable 5 (this session) | Renato | [charter](agents/charters/orchestrator.md) | [journal](agents/journals/claude_orchestrator_agent.md) | Active |
| `architect_docs_lead` | Opus 5 | orchestrator | [charter](agents/charters/architect_docs_lead.md) | [journal](agents/journals/claude_architect_docs_lead_agent.md) | Activates M1 |
| `rtl_lead` | Opus 5 | orchestrator | [charter](agents/charters/rtl_lead.md) | [journal](agents/journals/claude_rtl_lead_agent.md) | Activates M2 |
| `dv_lead` | Opus 5 | orchestrator | [charter](agents/charters/dv_lead.md) | [journal](agents/journals/claude_dv_lead_agent.md) | Activates M2 |
| `auditor` | Opus 5 (independent) | orchestrator → findings verbatim to Renato | [charter](agents/charters/auditor.md) | [journal](agents/journals/claude_auditor_agent.md) | Activates at G0 retro |
| `rtl_module_dev` | Sonnet (×N per WO) | rtl_lead (logical) | [charter](agents/charters/rtl_module_dev.md) | [journal](agents/journals/workers/claude_rtl_module_dev_agent.md) | Worker template |
| `tb_writer` | Sonnet (×N per WO) | dv_lead (logical) | [charter](agents/charters/tb_writer.md) | [journal](agents/journals/workers/claude_tb_writer_agent.md) | Worker template |
| `data_wrangler` | Sonnet | dv_lead (logical) | [charter](agents/charters/data_wrangler.md) | [journal](agents/journals/workers/claude_data_wrangler_agent.md) | Worker template |
| `formal_dv` | Sonnet | dv_lead (logical) | [charter](agents/charters/formal_dv.md) | [journal](agents/journals/workers/claude_formal_dv_agent.md) | Dormant |
| `rtl_lead_md` | Opus 5 | orchestrator | see "Contingent role: rtl_lead_md" in the [rtl_lead charter](agents/charters/rtl_lead.md) | seeded at activation | Contingent (Phase 2) |

Milestones referenced above: M0 org · M1 toolchain + specs · M2 = Phase 1 ·
M3 = Phase 2 · M4 = Phase 3 (stretch) — roadmap in [`tasks/BOARD.md`](tasks/BOARD.md).

## How the hierarchy actually executes

Claude Code subagents cannot spawn subagents, so solid arrows (spawning,
reporting) all terminate at the orchestrator, which is the **sole spawner and
sole git committer**. Dashed arrows are *logical* direction: a lead writes a
work order (`agents/handoffs/WO-*.md`), the orchestrator spawns the worker
with that packet, and the worker's output returns to the lead for review. The
chain of responsibility is reconstructible from packets, journals, and commit
trailers (`git log --grep 'Agent: <name>'`).

## Independence lines

- **DV is never graded by design**: dv_lead derives tests from specs, never
  RTL; tb_writer work orders omit RTL source; RTL-line agents cannot stage
  `test/` paths and DV-line agents cannot stage `libs/`/`top/` (mechanically
  enforced at commit time and in CI).
- **The auditor is graded only by the sponsor**: it audits everyone including
  the orchestrator, owns the DV-escape ledger, writes only to
  `docs/reports/audit/`, and never fixes what it finds. Its findings reach
  Renato unedited.
