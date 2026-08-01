# Gate G0 — Org Ratification

Passing G0 means the org, protocol, and enforcement machinery exist, are
proven, and are ratified by the sponsor. No M1 work order may be issued before
G0 passes. Signatures are journal-entry references (PROTOCOL §7).

| # | Item | Owner | Status | Signature |
|---|---|---|---|---|
| 1 | Operating protocol committed (`agents/PROTOCOL.md`) | orchestrator | ☐ | |
| 2 | All nine charters committed (`agents/charters/`), consistent with PROTOCOL and ORG_CHART | orchestrator | ☐ | |
| 3 | Journals seeded, append-only from birth; INDEX committed | orchestrator | ☐ | |
| 4 | Enforcement self-test green (`bash scripts/test_protocol.sh`, 24 scenarios) | orchestrator | ☐ | |
| 5 | `journal-check` CI green on the pushed branch | orchestrator | ☐ | |
| 6 | Adversarial charter review completed; findings dispositioned | orchestrator | ☐ | |
| 7 | Every M0 commit itself satisfies the commit protocol | orchestrator | ☐ | |
| 8 | **Sponsor**: org chart + charters ratified (critique round closed) | Renato | ☐ | (sponsor approval, recorded in orchestrator journal) |
| 9 | **Sponsor**: branch protection on `main` AND the working branch (`claude/fpga-hardcaml-agent-orchestration-37ceyf` — daily commits land there; `main` receives milestone PRs only). Exact click-path below. | Renato | ☐ | (sponsor confirmation) |
| 10 | Auditor's G0 retro-audit of the M0 commit range committed to `docs/reports/audit/` | auditor | ☐ | |

## Item 9 click-path (branch protection)

Do this **only after item 5 is green** — the `journal-check` status check must
have run at least once before GitHub will list it. Then, for **each** of
`main` and `claude/fpga-hardcaml-agent-orchestration-37ceyf`:

1. GitHub → repo → **Settings** → **Branches** → **Add branch protection rule**.
2. *Branch name pattern*: the branch name (one rule per branch).
3. Check **"Require status checks to pass before merging"** and select
   `journal-check` from the picker.
4. Leave **"Allow force pushes"** and **"Allow deletions"** UNCHECKED (they
   are off by default — there is no "disable" toggle to find).
5. Check **"Do not allow bypassing the above settings"** — without this, the
   admin account (the same one this session pushes with) can still
   force-push, which voids the append-only guarantee this item exists for
   (ADR-0001).
6. **Save**.

**Exit**: all items checked → orchestrator declares G0 passed in its journal,
updates `tasks/BOARD.md`, and M1 work orders may issue.
