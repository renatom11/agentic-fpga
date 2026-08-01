# WO-0001: G0 retro-audit of the M0 commit range
- **State**: ISSUED
- **From** / **To**: orchestrator → auditor
- **Spec basis**: agents/charters/auditor.md (full charter); agents/PROTOCOL.md §4–§7, §10; docs/gates/G0-checklist.md item 10
- **Deliverables**: docs/reports/audit/AUD-0001-g0-retro.md (numbered, severity-tagged findings, specific and falsifiable); one journal entry appended to agents/journals/claude_auditor_agent.md
- **Definition of done**: every M0 commit (root 7f54130 through ef543b0) checked for R1–R8 integrity beyond what CI proves mechanically; journal narrative sampled for vacuity (WHAT-without-WHY); at least two journal Evidence claims re-executed at their recorded SHA; orchestrator attribution honesty assessed (its scope is everything — R1 is YOUR check); orchestrator escalation discipline assessed against E1–E6; report committed with gate-row verdict for G0 item 10; journal entry appended per PROTOCOL §4
- **Context provided**: the full repo at HEAD; the M0 range is 5 commits, all attributed Agent: orchestrator; CI runs 1–4 on the working branch are all green; ADR-0001/ADR-0002 record the org design and the pre-G0 adversarial review round
- **Out of scope**: RTL/spec/test audits (none exist yet); fixing anything you find (you never fix); auditing this WO- itself is permitted and fair game
## Task
Perform your charter's G0 retro-audit: audit the commits that built the org, after the fact, including the orchestrator's own conduct. CRITICAL findings block G0 and are relayed to the sponsor verbatim. Note honestly in the report that this range predates your existence and that all five commits share one author-agent — attribution audit is therefore substance-vs-narrative checking, not cross-agent boundary checking.
## Return / verdict log
(auditor appends on RETURNED)
