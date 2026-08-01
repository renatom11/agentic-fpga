# WO-0002: Phase-1 requirements and top-level architecture
- **State**: RETURNED (2026-08-01, spawn #2; see Return log)
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
- 2026-08-01T23:20Z (orchestrator): INCIDENT — spawn #1 (WO-0002/2026-08-01T20:58Z)
  was killed ~5 minutes in by a session interruption at 20:57Z and never
  resumed; no deliverables were written (docs/specs/ empty, working tree
  clean, subagent transcript ends at the interruption). No partial state to
  clean up. Re-spawning with the identical packet as spawn #2
  (WO-0002/2026-08-01T23:20Z); the only prompt change is factual: the
  toolchain note now cites ADR-0005 (CI is the authoritative build
  environment; build lane green at run 30721584772) instead of "being
  installed in parallel". State remains ISSUED until spawn #2 RETURNS.
- 2026-08-01T23:48Z (architect_docs_lead): **RETURNED** — spawn #2
  (WO-0002/2026-08-01T23:20Z) complete; journal `J-architect_docs_lead-0001`.
  Four deliverables, all new files, nothing else in `docs/specs/` touched:
  - `docs/specs/requirements.md` — **108 numbered requirements** in ten blocks
    (21 programme invariants, 13 XGMII rx, 10 XGMII tx, 6 CRC-32, 10 Ethernet
    framing, 12 ARP, 12 IPv4, 9 UDP, 9 top-level/config, 6 process). Each row
    is one testable SHALL with a Kind tag and a named verification method,
    written for dv_lead's countersignature and for tb_writer excerpts. The
    line-rate invariant is REQ-004 (min frames, 12-octet IFG, alternating
    lane-0/lane-4 starts, one frame per 10.5 cycles, 10 000 frames, zero drop,
    zero backpressure) and the XGMII boundary is REQ-017 (port closure) plus
    REQ-018 (simulation-only, no PMA/PCS/serdes/vendor primitives) — numbered,
    not prose, per the DoD. A closing table records 14 explicit
    non-requirements so every absence is a decision.
  - `docs/specs/architecture.md` — canonical Phase-1 scope parameters
    (PROTOCOL §11), datapath arithmetic, eight architectural decisions each
    with its rejected alternative, the XGMII attach boundary and the contract
    for its DV-owned stub, a **20-module inventory** (M01–M20) mapped to
    verilog-ethernet counterparts and REQ ranges, the 24-cycle receive latency
    budget with per-stage ceilings, deliberate deviations from the reference
    decomposition, three Mermaid diagrams, freeze prerequisites, and the
    dependency-ordered six-batch plan for the twenty per-module specs.
  - `docs/specs/SPEC-TEMPLATE.md` — 13-section per-module form: compilable
    Hardcaml v0.17 Interface block (`[@@deriving hardcaml]`, `[@bits n]`,
    `[@rtlprefix]`, entry points inside a `module type S`), port table, timing
    contract, mandatory line-rate stress section for rx-path modules,
    errors/strobes table, REQ-coverage table, freeze record demanding a CI run
    id per ADR-0005, and a post-freeze change log requiring an ADR.
  - `docs/specs/traceability.md` — 108 rows, one per REQ, with owning module
    and empty test column; row set proven equal to the REQ set of
    requirements.md by a command quoted in the journal Evidence.
  **DoD**: met as scoped. The charter §5 interface compile check is open by the
  packet's own terms — no OCaml was compiled, `docs/specs/ifc_check/` does not
  exist, and per ADR-0005 the only acceptable evidence is a CI `build` run at
  freeze time.
  **Open questions for the orchestrator** (detail in the journal entry):
  (1) add `hardcaml_axi` to `agentic_fpga.opam` and the ethernet lib's dune
  `libraries` — blocking, it pulls `hardcaml_circuits` + `hardcaml_handshake`,
  fallback is a local stream record plus an ADR; (2) `docs/specs/ifc_check/`
  dune wiring — blocking for batch A freeze; (3) UDP transmit checksum is
  specified as zero and receive checksums are not verified — judged in-role,
  not E2, but flagged; (4) spec batching (six work orders proposed, ordering
  fixed); (5) README's phase table is now a restatement of architecture.md §1
  and should be pointed at it by a small follow-up doc work order; (6) the
  24-cycle latency budget is the architect's figure, not a sponsor
  requirement; (7) dv_lead testability review should land before the
  `P1-spec-freeze` checklist is opened.
- 2026-08-01T23:55Z (orchestrator): ACCEPTED at 08899d3. Issuer review:
  four deliverables present; REQ set (108) provably equals the traceability
  row set (diff of extracted ID sets — empty); line-rate and XGMII
  closure/sim-only are REQ-004/017/018 with verification methods; module
  inventory M01–M20 named with verilog-ethernet counterparts; Return log
  and journal grammar verified mechanically at commit. dv_lead testability
  countersign remains a P1-spec-freeze precondition (architect's own Q7 —
  agreed). Follow-ups opened on the board: hardcaml_axi dependency +
  ifc_check dune wiring (orchestrator, blocking batch A), spec batching
  decision, README phase-table pointer, 24-cycle budget confirmation with
  sponsor.
