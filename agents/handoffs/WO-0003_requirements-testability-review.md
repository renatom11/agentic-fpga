# WO-0003: Requirements testability review (pre-freeze)
- **State**: ISSUED
- **From** / **To**: orchestrator → dv_lead
- **Spec basis**: agents/charters/dv_lead.md; agents/PROTOCOL.md §4, §6, §7, §10; docs/specs/requirements.md at 08899d3 (the review target); docs/specs/architecture.md, SPEC-TEMPLATE.md, traceability.md (context); ADR-0004 (toolchain), ADR-0005 (CI-authoritative builds)
- **Deliverables**:
  - `agents/handoffs/WO-0003_testability-findings.md` — a disposition for
    **every one of the 108 REQs**: `TESTABLE` (with one line naming the test
    shape you'd build), `AMBIGUOUS` (with the exact wording that two
    reasonable test writers would read differently, and the reading you'd
    enforce), or `UNTESTABLE` (with what observable is missing). Group by the
    ten REQ blocks; per-block one-paragraph summary. End with an overall
    verdict: whether requirements.md, as written, can anchor the
    P1-spec-freeze countersignature you will be asked for, and the list of
    findings that MUST become spec diffs first.
  - Feasibility note (a section of the same file): the REQ-004 line-rate
    stress obligation (10 000 back-to-back 64 B frames, DIC-alternating start
    lanes) and REQ-005 constant-latency evidence — are they practical in
    Cyclesim, or do they force the Verilator lane early? State the bench
    architecture you intend, in prose, so the orchestrator can size the
    tooling work.
  - Journal entry `J-dv_lead-0001` in
    `agents/journals/claude_dv_lead_agent.md` (your journal's first entry) per
    PROTOCOL §4 grammar, Files-in-this-commit listing exactly:
    `agents/handoffs/WO-0003_testability-findings.md` and
    `agents/handoffs/WO-0003_requirements-testability-review.md`.
  - Return log entry below (state → RETURNED).
- **Definition of done**: all 108 REQs dispositioned (no sampling); every
  AMBIGUOUS/UNTESTABLE finding phrased as a concrete, actionable spec-diff
  request the architect can apply without asking you anything; no RTL, no
  test code, no golden models written; nothing touched outside
  `agents/handoffs/**` and your own journal.
- **Context provided**: this review lands BEFORE the P1-spec-freeze checklist
  opens (the architect's own proposal, accepted) so your objections arrive as
  spec diffs, not gate blockers. Your later freeze countersignature (charter,
  PROTOCOL §7) will be against the post-diff requirements.md — this WO is
  what makes that signature honest. The tb_writer workers you will later
  direct see spec excerpts only, never RTL (PROTOCOL §10): review with that
  reader in mind.
- **Out of scope**: fixing requirements.md yourself (architect's file — your
  scope does not include docs/specs and the protocol will reject the commit);
  per-module spec review (those arrive in batches A–F later); test
  implementation; tooling decisions beyond the feasibility note.
## Task
First activation of the verification function. The 108 requirements at
08899d3 were written for you as the countersigning reader; find every place
where that promise fails. Judge each REQ as the person who must later either
build the test or reject a worker's test against it. Where the verification
method column already names a method, judge the method too — a REQ whose
stated method cannot detect its own violation is AMBIGUOUS at best.
## Return / verdict log
(dv_lead appends on RETURNED)
