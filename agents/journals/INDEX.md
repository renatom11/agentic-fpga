# Journal Index

One row per journal. Updated by the orchestrator at gate boundaries — this is
a best-effort rehydration aid; `tasks/BOARD.md` is the live program state, and
each journal's tail is its own source of truth.

| Agent | Journal | Last entry | State |
|---|---|---|---|
| orchestrator | [claude_orchestrator_agent.md](claude_orchestrator_agent.md) | J-orchestrator-0012 | G0 PASSED; M1 open (E3 toolchain escalation with sponsor) |
| architect_docs_lead | [claude_architect_docs_lead_agent.md](claude_architect_docs_lead_agent.md) | — | Not yet activated (first spawn: M1) |
| rtl_lead | [claude_rtl_lead_agent.md](claude_rtl_lead_agent.md) | — | Not yet activated (first spawn: M2) |
| dv_lead | [claude_dv_lead_agent.md](claude_dv_lead_agent.md) | — | Not yet activated (first spawn: M2) |
| auditor | [claude_auditor_agent.md](claude_auditor_agent.md) | J-auditor-0003 | Active; AUD-0001/0002 delivered, WO-0001 cycle complete |
| rtl_module_dev (workers) | [workers/claude_rtl_module_dev_agent.md](workers/claude_rtl_module_dev_agent.md) | — | Worker template, spawned per WO |
| tb_writer (workers) | [workers/claude_tb_writer_agent.md](workers/claude_tb_writer_agent.md) | — | Worker template, spawned per WO |
| data_wrangler (workers) | [workers/claude_data_wrangler_agent.md](workers/claude_data_wrangler_agent.md) | — | Worker template, spawned per WO |
| formal_dv (workers) | [workers/claude_formal_dv_agent.md](workers/claude_formal_dv_agent.md) | — | Dormant until Phase 1 hardening |

`rtl_lead_md` (contingent second RTL lead for Phase 2 overlap) has no journal
yet; it is seeded at activation per its note in `agents/charters/rtl_lead.md`.
