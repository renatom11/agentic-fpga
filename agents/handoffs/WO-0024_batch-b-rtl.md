# WO-0024: Batch-B RTL — M03 `Xgmii_rx_64`, M04 `Xgmii_tx_64`, M05 `Eth_mac_10g`
- **State**: ISSUED
- **From** / **To**: orchestrator → rtl_lead
- **Spec basis** (PROTOCOL §10): SPEC-M03/M04/M05, FROZEN at f78766e,
  §13 rows since (M03: C-18 + twin; M04: C-14 set, C-16's C+8 rule,
  C-31's ordered-and-unpinned §9 — read every §13 row, the frozen
  text + its recorded diffs IS the spec); ADR-0006/0007 (CRC ports,
  octet_count); ADR-0008 (M04-adjacent handshake context); ADR-0010
  (consumer conventions — `open! Axi64` NORMATIVE, no named module
  type S); your delivered M01/M02 at 189d5b2 (the vocabulary + the
  CRC engine these modules instantiate).
- **Environment**: hardcaml v0.17.1 sources readable at
  /root/.opam/fpga/.opam-switch/sources/hardcaml (your own WO-0016
  finding — bind constructs to real signatures there);
  hardcaml_axi/base sources absent; ADR-0005 blind-write + CI
  round-trip discipline, same as WO-0016 (green first try is the bar
  you set).
- **Deliverables**:
  1. libs/hardcaml_ethernet/src/xgmii_rx_64.ml/.mli — SPEC-M03: XGMII
     decode, start-lane handling (lanes 0/4), FCS check via your
     Crc32_eth, the 21-strobe discipline, one 64-bit word/cycle zero
     backpressure (the line-rate invariant, charter red line).
  2. xgmii_tx_64.ml/.mli — SPEC-M04: encode, IFG, CRC insertion,
     tx_tready per §6.1's cycle table INCLUDING the C-16 C+8 rule and
     C-31's ordered-and-unpinned §9 strobes.
  3. eth_mac_10g.ml/.mli — SPEC-M05: the structural wrapper, total
     wiring per its §6.1.
  4. dune untouched unless needed; RTL emission registration per
     SPEC-M05 §12's expectations if its frozen text names one,
     otherwise return the question.
  - M03 is on your personally-implemented list (charter §2: hard
    receive modules). Decompose M04/M05 to rtl_module_dev workers ONLY
    if you judge the packets writable without ambiguity — otherwise
    implement personally; you cannot spawn (orchestrator is sole
    spawner), so "decompose" means: return the worker packets in your
    Return log and I spawn them under your review. Simpler: implement
    all three personally this wave if that is faster than packet-
    writing; your call, state it.
  - Journal **J-rtl_lead-0002**; Files-in-this-commit exact;
    line-by-line self-review in the Return log (charter §3).
- **Out of scope**: tests (dv-owned, red line); test/**, tools/**,
  docs/** (spec questions return as questions — note C-37's repair is
  in flight at SPEC-M14, does not touch your three specs).
## Task
The MAC layer. Second RTL activation: three modules against the
longest-frozen full-behaviour specs in the programme.
## Return / verdict log
