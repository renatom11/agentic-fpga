# Gate G0 — Org Ratification

Passing G0 means the org, protocol, and enforcement machinery exist, are
proven, and are ratified by the sponsor. No M1 work order may be issued before
G0 passes. Signatures are journal-entry references (PROTOCOL §7).

| # | Item | Owner | Status | Signature |
|---|---|---|---|---|
| 1 | Operating protocol committed (`agents/PROTOCOL.md`) | orchestrator | ✅ | J-orchestrator-0001, J-orchestrator-0004 |
| 2 | All nine charters committed (`agents/charters/`), consistent with PROTOCOL and ORG_CHART | orchestrator | ✅ | J-orchestrator-0003, J-orchestrator-0004 |
| 3 | Journals seeded, append-only from birth; INDEX committed | orchestrator | ✅ | J-orchestrator-0001 |
| 4 | Enforcement self-test green (`bash scripts/test_protocol.sh`, 26 scenarios, each rejection asserting its rule) | orchestrator | ✅ | J-orchestrator-0009 (re-signed; 24→26 per AUD-0001-F1/F2) |
| 5 | `journal-check` CI green on the pushed branch | orchestrator | ✅ | J-orchestrator-0005 (runs 1–3 all green) |
| 6 | Adversarial charter review completed; findings dispositioned | orchestrator | ✅ | J-orchestrator-0004, ADR-0002 |
| 7 | Every M0 commit itself satisfies the commit protocol | orchestrator | ✅ | J-orchestrator-0005 (CI range checks over full history) |
| 8 | **Sponsor**: org chart + charters ratified (critique round closed) | Renato | ✅ | Sponsor approval 2026-08-01, recorded in J-orchestrator-0007 |
| 9 | **Sponsor**: branch protection on `main` AND the working branch (`claude/fpga-hardcaml-agent-orchestration-37ceyf` — daily commits land there; `main` receives milestone PRs only). Exact click-path below. | Renato | ✅ | Sponsor configured 2026-08-01 (rulesets protect-history all-branches + main-requires-ci); rejection verified by live fire on both branches — J-orchestrator-0011 |
| 10 | Auditor's G0 retro-audit of the M0 commit range committed to `docs/reports/audit/` | auditor | ✅ | J-auditor-0001 — **PASS WITH FINDINGS** ([AUD-0001](../reports/audit/AUD-0001-g0-retro.md)) |
| 11 | **Gate release**: AUD-0001 CRITICAL (F17) dispositioned by ADR **and re-verified by the auditor** | auditor | ✅ | J-auditor-0003 — F17 **CLOSED**, block lifted ([AUD-0002](../reports/audit/AUD-0002-g0-reverification.md)); transcribed per ADR-0003 auditor exception |

## Item 9 click-path (branch rulesets)

Use GitHub's **rulesets** (Settings → Rules → Rulesets), not classic branch
protection — an empty bypass list makes a ruleset admin-proof by default.
Do this **only after item 5 is green** — the `journal-check` status check must
have run at least once before GitHub will list it in the picker.

**Ruleset 1 — "protect-history"** (guards git history on both branches):
1. **New ruleset → New branch ruleset**; name it `protect-history`.
2. *Enforcement status*: **Active**.
3. *Bypass list*: leave **empty** — this is what stops the admin account
   (the same one this session pushes with) from force-pushing history away
   (ADR-0001's append-only guarantee depends on it).
4. *Target branches* → Include by pattern → add `main`, then add
   `claude/fpga-hardcaml-agent-orchestration-37ceyf`.
5. *Rules*: check **Restrict deletions** and **Block force pushes**.
6. **Create**.

**Ruleset 2 — "main-requires-ci"** (`main` only):
1. New branch ruleset, name `main-requires-ci`, Active, empty bypass list.
2. *Target branches*: `main` only.
3. *Rules*: **Require status checks to pass** → add `journal-check`.
   Optionally also **Require a pull request before merging** (R9: `main`
   receives milestone PRs only).
4. **Create**.

**Why the split**: GitHub rejects direct pushes to any branch with required
status checks (new commits can't have passing checks yet). The orchestrator
pushes directly to the working branch, so the check requirement must bind
`main` only; the working branch is guarded by force-push/deletion blocking,
with CI failing publicly on every push as the detection mechanism.

**Exit**: all items checked → orchestrator declares G0 passed in its journal,
updates `tasks/BOARD.md`, and M1 work orders may issue.

---

## G0: PASSED — 2026-08-01

All 11 items signed. Declared in `J-orchestrator-0012`; the org is ratified,
mechanically enforced end-to-end, audited, and re-verified. M1 is open.
