# WO-0002: Phase-1 requirements and top-level architecture
- **State**: ISSUED
- **From** / **To**: orchestrator → architect_docs_lead
- **Spec basis**: agents/charters/architect_docs_lead.md; agents/PROTOCOL.md §1, §7, §10; docs/adr/ADR-0001 (project scope), ADR-0004 (toolchain lane: released Hardcaml v0.17.x)
- **Deliverables**:
  - `docs/specs/requirements.md` — REQ-### numbered requirements for Phase 1 (program-level invariants + the 10G Ethernet subsystem: XGMII-level MAC rx/tx, CRC-32 FCS, IFG, ARP, IPv4, UDP). One testable statement per REQ; each will later map to tests in the traceability matrix.
  - `docs/specs/architecture.md` — top-level Phase-1 architecture: module inventory (mirroring verilog-ethernet's decomposition as prior art, MIT), internal streaming fabric choice, single-clock story (156.25 MHz), the XGMII attach boundary and its stub, dataflow diagram (Mermaid), and the ordered list of per-module specs to be written next (each a future WO).
  - `docs/specs/SPEC-TEMPLATE.md` — the per-module spec template: Interface record block (OCaml, compilable), timing contract section, REQ coverage table, line-rate stress obligation for rx-path modules.
  - `docs/specs/traceability.md` — matrix skeleton (REQ → spec § → test), rows for every REQ, test column empty pending DV.
- **Definition of done**: all four files committed-ready; every requirement individually testable (dv_lead will countersign testability at P1-spec-freeze — write for that reader); line-rate invariant (one 64-bit word/cycle, zero rx backpressure, back-to-back 64 B frames) and the XGMII sim-only boundary appear as REQs, not prose; module inventory names every Phase-1 RTL deliverable; journal entry appended per PROTOCOL §4; docs are runnable-truthful (no commands that don't work).
- **Context provided**: repo at HEAD (read anything; your write scope is docs/** except audit/latency, plus this packet's Return log). Datapath facts on record: 64-bit @ 156.25 MHz = 10G; worst case back-to-back 64 B frames ≈ one frame per 10–11 cycles; PMA/serdes out of scope, XGMII is the hardware attach point. Toolchain is Hardcaml v0.17.x (ADR-0004); the ifc_check scratch-lib dune wiring arrives from the orchestrator with the M1 skeleton — write Interface records to that target, compile-check happens before freeze, not in this WO.
- **Out of scope**: per-module frozen specs (next WOs); Phase-2/3 requirements beyond forward-looking notes; any file outside your write scope; RTL or tests.
## Task
First activation of the architecture function. Produce the four deliverables at the quality bar the charters set: specs precise enough that an implementer and a test-writer who never speak converge on the same module. Where you make a non-obvious architectural choice (fabric style, module split, ARP placement), record the alternatives in your journal Reasoning — an ADR may be extracted later.
## Return / verdict log
(architect appends on RETURNED)
