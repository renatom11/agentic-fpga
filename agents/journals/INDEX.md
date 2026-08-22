# Journal Index

One row per journal. Updated by the orchestrator at gate boundaries — this is
a best-effort rehydration aid; `tasks/BOARD.md` is the live program state, and
each journal's tail is its own source of truth.

Volume chains (ADR-0017): the links below point at each chain's SEED volume;
the active volume is the highest `vNN` suffix beside it, and the tail entry
lives there. Refreshed 2026-08-22 (J-orchestrator-0311, paying FINDING
F-0030-7 — the previous refresh was 2026-08-01 and five rows had gone false).

| Agent | Journal (seed volume) | Active volume | Last entry | State |
|---|---|---|---|---|
| orchestrator | [claude_orchestrator_agent.md](claude_orchestrator_agent.md) | v03 | J-orchestrator-0310 | M1 open; M04 (xgmii_tx_64) mid-qualification, 41/83 discharged; ADR-0024 countersignature round pending |
| architect_docs_lead | [claude_architect_docs_lead_agent.md](claude_architect_docs_lead_agent.md) | v06 | J-architect_docs_lead-0065 | Active; eighth-edition custodian; ADR-0024 authored (PROPOSED) |
| rtl_lead | [claude_rtl_lead_agent.md](claude_rtl_lead_agent.md) | v03 | J-rtl_lead-0026 | Active; M03 SIGNED PASS 14/14; M04 RTL under DV qualification |
| dv_lead | [claude_dv_lead_agent.md](claude_dv_lead_agent.md) | v12 | J-dv_lead-0201 | Active; RV-0083 fully paid; WO-0085 ACCEPTED; JOINT-M04-1 queued |
| auditor | [claude_auditor_agent.md](claude_auditor_agent.md) | v03 | J-auditor-0030 | Active; POSTURE-RE-MEASUREMENT-2 delivered (1 MAJOR, 7 MINOR) |
| rtl_module_dev (workers) | [workers/claude_rtl_module_dev_agent.md](workers/claude_rtl_module_dev_agent.md) | seed | — | Worker, spawned per WO |
| tb_writer (workers) | [workers/claude_tb_writer_agent.md](workers/claude_tb_writer_agent.md) | v03 | J-tb_writer-0047 | Worker, spawned per WO; last: WO-0085 cfg_ifg axis |
| data_wrangler (workers) | [workers/claude_data_wrangler_agent.md](workers/claude_data_wrangler_agent.md) | seed | — | Worker, spawned per WO |
| formal_dv (workers) | [workers/claude_formal_dv_agent.md](workers/claude_formal_dv_agent.md) | seed | — | Dormant until Phase 1 hardening |

`rtl_lead_md` (contingent second RTL lead for Phase 2 overlap) has no journal
yet; it is seeded at activation per its note in `agents/charters/rtl_lead.md`.
