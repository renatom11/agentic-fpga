# WO-0009: DV bench machinery (DUT-independent layer)
- **State**: ISSUED
- **From** / **To**: orchestrator → dv_lead
- **Spec basis**: your WO-0003 §13.3 bench architecture (accepted); the
  WO-0003/WO-0007 ACCEPTED rulings (X-9 boundary: tools may parse
  rtl_snapshots/**, never libs/** sources; cost probe approved); SPEC-M01
  at 22145b5 (the signed §6.1 protocol contract your monitors encode);
  requirements.md at b4b4cf4 (REQ-301/303/304/305 for the reference CRC;
  §12 strobe appendix; §9.1 config table); ADR-0005 (CI-authoritative —
  every "it works" claim cites a run ID)
- **Deliverables** (all under test/** and tools/**):
  1. **Cyclesim cost probe**: a throwaway-marked bench measuring
     cycles/second on the CI runner (word_counter or a trivial DUT is
     fine); result read from the CI log and recorded in your journal with
     the run ID. This sizes the 10 000-frame stress commitment.
  2. **REQ-305 software reference**: the bit-serial CRC-32 you already
     validated, as a reusable OCaml module under test/ with an expect
     test anchoring REQ-303 (0xCBF43926) and REQ-304 (0x2144DF1C across
     several lengths). This is the oracle every FCS bench will import.
  3. **Protocol monitor**: the SPEC-M01 §6.1 stream-legality checker
     (tkeep contiguity, tlast rules, the §6.3-item-5 must-not-assert
     guards) as a Cyclesim-attachable module with its own unit expect
     test on hand-built legal/illegal traces.
  4. **Conservation monitor + octet-time latency tagger**: per your
     §13.3 design (8×cycle + lane/byte position), DUT-independent,
     unit-tested the same way.
  5. **C-9 + X-9 tools scripts**: record-vs-appendix checks (Status vs
     §12, Config vs §9.1) and the emitted-Verilog structural checks
     (REQ-001/017/018/306/808 now; REQ-903's script lands after C-8
     settles its wording) — plain scripts under tools/, each runnable
     standalone and wired into CI only if trivially cheap (your call;
     document either way).
  - Journal entry J-dv_lead-0004; Files-in-this-commit = exactly what you
    created (test/**, tools/**, this packet).
  - Return log entry (state → RETURNED).
- **Definition of done**: everything compiles and its tests pass in CI
  (expect snapshots follow ADR-0005 promotion if any waveform/output
  snapshot is involved — never hand-author); no RTL read (libs/** stays
  unopened, PROTOCOL §10); monitors encode the SPEC-M01 contract by
  citation, not by reading Hardcaml sources beyond the Axi64 type module
  you must import to attach to streams (that import is the one sanctioned
  exception — it is the signed public interface, not implementation).
- **Out of scope**: per-module benches for M03+ (their specs are not
  frozen); the XGMII link-partner model's implementation if it requires
  M03 spec details still in flight — the interface skeleton and the
  arrival scheduler are fine; golden models beyond CRC.
## Task
The machinery layer every Phase-1 bench stands on. Parallel with the
architect's WO-0008 — do not touch docs/specs/**.
## Return / verdict log
(dv_lead appends on RETURNED)
