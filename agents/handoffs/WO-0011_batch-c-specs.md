# WO-0011: Batch C specifications + the WO-0010 diff set + topology table
- **State**: ISSUED
- **From** / **To**: orchestrator → architect_docs_lead
- **Spec basis**: architecture.md §4 rows M06–M09 and §8 batch C;
  SPEC-TEMPLATE.md; the FROZEN batch A+B specs at f78766e (their records
  are your vocabulary — SPEC-M06+ lifts write `open! Axi64_ifc`);
  requirements.md as revised by WO-0008; the WO-0010 Return log
  (C-11 replacement text, the C-12 ruling dv_lead supplied, C-13, the
  five C-14 readings); the gate-checklist ledger (all four due at your
  return)
- **Deliverables**:
  1. The four WO-0010 diff sets, FIRST (they touch FROZEN specs, so each
     is a spec diff under SPEC-TEMPLATE rule 7 with a §13 record):
     C-11 (REQ-015 deletion + counting-convention clause per dv's
     replacement text; SPEC-M03 §7 restatement moves in the same diff);
     C-12 (adopt or counter dv's ruling for /E/ during Discard; the
     ruling must land in SPEC-M03 §9 and, if needed, requirements.md);
     C-13 (REQ-010's census corrected for the Xgmii record's six ports,
     honouring the row's own spec-diff clause this time); C-14 (fix the
     tx_tready-during-gap contradiction; judge the other four readings —
     fix or defend each explicitly in the Return log).
  2. SPEC-M06 (eth_axis_rx), SPEC-M07 (eth_axis_tx), SPEC-M08
     (eth_demux), SPEC-M09 (eth_arb_mux): DRAFT, template-complete,
     ifc_check lifts byte-identical, opening Axi64_ifc rather than
     restating records. These introduce the header-record convention and
     the REQ-021 realignment obligation — state the realignment latency
     in octet times per §0.5 and keep §1.1's ceilings arithmetic under
     the sealed ΔC = (L + h)/8 unit.
  3. **Topology connection table** (new, block-diagram source): a
     machine-readable section `## 6.4 Connection table` in
     architecture.md — one row per edge: source module.port → sink
     module.port, stream/record type, path class (rx/tx/control/status).
     Cover every edge in the §6 diagrams for ALL twenty modules (the
     diagrams already commit you to the topology; this is its
     table form). The orchestrator renders a generated block diagram
     from this table plus the ifc_check records — keep column syntax
     rigidly regular (it will be parsed).
  4. traceability.md updated for any REQ changes; set equality survives.
  - Journal J-architect_docs_lead-0005; Files-in-this-commit = exactly
    what you touch (docs/specs/**, this packet).
  - Return log entry with per-deliverable dispositions.
- **Definition of done**: all four C-items dispositioned explicitly;
  frozen-spec edits carry §13 records; four new specs template-complete;
  the connection table parses regularly and covers all diagram edges;
  set equality holds.
- **Out of scope**: batches D–F; RTL; tests; test/** and tools/**
  (dv_lead is working there in parallel).
## Task
Batch C plus the freeze's first post-freeze diff cycle — the §13 spec-diff
machinery gets its first real exercise. The connection table is new
permanent infrastructure: the org's block diagram derives from it.
## Return / verdict log
(architect appends on RETURNED)
