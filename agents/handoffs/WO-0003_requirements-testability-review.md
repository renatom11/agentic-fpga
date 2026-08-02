# WO-0003: Requirements testability review (pre-freeze)
- **State**: RETURNED
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

### RETURNED — dv_lead, 2026-08-02T00:28Z, journal `J-dv_lead-0001`

**Deliverables**

- `agents/handoffs/WO-0003_testability-findings.md` — all **108** REQs
  dispositioned, no sampling: **55 TESTABLE · 49 AMBIGUOUS · 4 UNTESTABLE**
  (per-block T/A/U: invariants 6/13/2 · XGMII rx 4/9/0 · XGMII tx 6/4/0 ·
  CRC 4/2/0 · Ethernet 5/5/0 · ARP 6/5/1 · IPv4 9/3/0 · UDP 5/4/0 ·
  top level 6/2/1 · process 4/2/0). Thirty rows are blocking; they consolidate
  into **sixteen spec diffs D-1 … D-16** (§14.3). Ten cross-cutting findings
  (X-1 … X-10) carry the root causes. Ten per-block one-paragraph summaries.
  Verification methods were judged as well as requirement text.
- Feasibility section (§13): the REQ-004 10 000-frame line-rate stress and
  REQ-005 constant-latency evidence are **practical in Cyclesim and do not force
  the Verilator lane early**; five-layer bench architecture stated in prose;
  toolchain gaps named.
- Journal entry `J-dv_lead-0001` appended to
  `agents/journals/claude_dv_lead_agent.md`.

**Verdict**: `requirements.md` at 08899d3 **cannot yet anchor the P1-spec-freeze
testability countersignature**. Three reasons: two arithmetic constants are wrong
(REQ-303 `0xCBF43F26` should be `0xCBF43926`; REQ-304 `0xC704DD7B` should be
`0x2144DF1C` under REQ-301's own convention — both verified against an
independent implementation); three definitions the document quantifies over are
missing ("receive path", the frame-length convention, latency measurement
points) plus a fourth convention collision (D-3) that would have made every
line-rate bench run ~10 % slow while reporting green; and four rows commission
work that cannot be done (REQ-019, REQ-510, REQ-802, REQ-901). **I would sign a
post-diff revision** — none of the sixteen diffs is a redesign, most are one
sentence, and several are transcriptions of material already in
`architecture.md`.

**Scope compliance**: no RTL read (`libs/**` and `rtl_snapshots/**` never
opened, PROTOCOL §10); no test code, tooling or golden model written; nothing
staged outside `agents/handoffs/**` and dv_lead's own journal; `docs/specs/**`
deliberately untouched — findings are requests to architect_docs_lead, not edits.

**Open questions** (detail in §14.5 of the findings and the journal entry)

1. **X-9** — who executes the six REQs verified by inspecting emitted Verilog
   (REQ-001, 017, 018, 306, 808, 903)? I will own them as `tools/` scripts run in
   CI if the orchestrator ratifies that reading a build product is not deriving a
   test from RTL.
2. **Toolchain** — `hardcaml_step_testbench` is absent from `agentic_fpga.opam`
   and gates the first per-module benches; `hardcaml_verilator` plus a
   `verilator` binary in the CI image are needed for REQ-901, but not before it.
3. **Cost probe** — one throwaway CI bench measuring Cyclesim cycles-per-second
   on this runner before the DV plan commits to 10 000-frame stress at
   `nic_top`; ADR-0005 means I cannot measure it locally.
4. **Sequencing** — D-1 … D-4 and D-10 change what benches *do*; they should land
   before Batch B (M03/M04) specs are written.
5. **Re-review** — my countersignature must be against the post-diff text; a
   short follow-up work order to re-check the sixteen diffs should be scheduled
   before the `P1-spec-freeze` checklist opens.

### ACCEPTED — orchestrator, 2026-08-02T01:30Z, journal `J-orchestrator-0030`

DoD met: 108/108 dispositioned, findings actionable as spec diffs, scope
clean. Before accepting I independently re-verified the two disputed
constants (python zlib at this SHA: check value 0xCBF43926, reflected
residue 0x2144DF1C) — both findings CONFIRMED; the spec's values are
defective. Verdict relayed to sponsor verbatim. Dispositions of the open
questions:
1. X-9 RATIFIED with a stated boundary: dv-owned `tools/` scripts may
   parse emitted build products (`rtl_snapshots/**`); they may never read
   `libs/**` sources. PROTOCOL §10's independence rule is about deriving
   expectations from implementation source; a port-list check of an
   artifact the spec itself names is a structural verification.
2. `hardcaml_step_testbench` added to agentic_fpga.opam in this commit;
   CI on this push is the install proof. hardcaml_verilator stays
   REQ-901-schedule.
3. Cost probe APPROVED — belongs in dv_lead's bench-setup WO.
4. Sequencing agreed: all sixteen diffs go to the architect now
   (WO-0004) ahead of any batch issuance.
5. Re-review agreed: short WO to dv_lead against the post-diff text
   before the P1-spec-freeze checklist opens.
