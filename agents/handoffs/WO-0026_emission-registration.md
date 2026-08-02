# WO-0026: RTL emission registration for M03/M04/M05
- **State**: ISSUED
- **From** / **To**: orchestrator → rtl_lead
- **Spec basis**: your own WO-0024 Return log question 1 (emission
  registration deliberately absent, REQ-902 evidence needs a CI
  round-trip by design); SPEC-M03/M04/M05 §12 rows; REQ-902
  (byte-determinism of emitted Verilog); the M0 word_counter emission
  precedent in bin/generate.exe; ADR-0005.
- **Deliverables**:
  1. Register RTL emission for the three MAC modules in the generate
     entry point (bin/) per the word_counter pattern — top-level
     names per each spec's §12 expectations (return the question if a
     spec is silent on the emitted top name rather than inventing).
  2. NO snapshot files hand-written: the first CI run after this
     commit fails the determinism check with the emitted .v as the
     diff — that diff IS the promotion source (ADR-0005 rule 2); I
     promote it verbatim and the second run proves byte-determinism =
     REQ-902's evidence. State this expected-red in your Return log
     so nobody triages it as a defect.
  - Journal **J-rtl_lead-0003**; Files-in-this-commit exact.
- **Out of scope**: tests; test/**, tools/**, docs/**; any change to
  the three modules themselves (emission only).
## Task
Close your own returned question 1: make the MAC layer's Verilog an
artifact CI regenerates and diffs on every push.
## Return / verdict log
