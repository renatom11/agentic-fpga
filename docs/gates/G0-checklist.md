# Gate G0 — Org Ratification

Passing G0 means the org, protocol, and enforcement machinery exist, are
proven, and are ratified by the sponsor. No M1 work order may be issued before
G0 passes. Signatures are journal-entry references (PROTOCOL §7).

| # | Item | Owner | Status | Signature |
|---|---|---|---|---|
| 1 | Operating protocol committed (`agents/PROTOCOL.md`) | orchestrator | ☐ | |
| 2 | All nine charters committed (`agents/charters/`), consistent with PROTOCOL and ORG_CHART | orchestrator | ☐ | |
| 3 | Journals seeded, append-only from birth; INDEX committed | orchestrator | ☐ | |
| 4 | Enforcement self-test green (`bash scripts/test_protocol.sh`, 13 scenarios) | orchestrator | ☐ | |
| 5 | `journal-check` CI green on the pushed branch | orchestrator | ☐ | |
| 6 | Adversarial charter review completed; findings dispositioned | orchestrator | ☐ | |
| 7 | Every M0 commit itself satisfies the commit protocol | orchestrator | ☐ | |
| 8 | **Sponsor**: org chart + charters ratified (critique round closed) | Renato | ☐ | (sponsor approval, recorded in orchestrator journal) |
| 9 | **Sponsor**: branch protection on `main` — no force push, `journal-check` required. Settings → Branches → Add rule for `main`: enable "Require status checks to pass" (select `journal-check`), disable force pushes and deletions | Renato | ☐ | (sponsor confirmation) |
| 10 | Auditor's G0 retro-audit of the M0 commit range committed to `docs/reports/audit/` | auditor | ☐ | |

**Exit**: all items checked → orchestrator declares G0 passed in its journal,
updates `tasks/BOARD.md`, and M1 work orders may issue.
