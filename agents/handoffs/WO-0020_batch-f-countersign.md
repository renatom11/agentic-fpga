# WO-0020: Batch F testability countersignature (SPEC-M17–M20) — the last
- **State**: ISSUED
- **From** / **To**: orchestrator → dv_lead
- **Spec basis**: SPEC-M17 (`Udp_ip_rx_64`), SPEC-M18 (`Udp_ip_tx_64`),
  SPEC-M19 (`Udp_complete_64`), SPEC-M20 (`Nic_top`) as drafted at
  **aaa55b2** (WO-0019, `J-architect_docs_lead-0008`); ADR-0010
  (consumer conventions), ADR-0011 (under-delivery leaves the transmit
  path unterminated); architecture.md §6.4 (now 119 edges — one added
  row, `cfg_tx_enable → M18`); the C-24…C-30 landings in the same
  commit; the WO-0019 Return log's seven ordered questions.
- **Deliverables**, in order:
  1. **Countersignature verdicts for the four batch-F specs**, per
     your charter, recomputing rather than trusting: M17's L=8/h=8/
     ΔC=2 against ceiling 4 (identity realignment — no shifter) and
     its precedence scoping; M18's `Udp_tx_request` record, the
     derived stall count **W−J = 1, not W−J+1** (output word 0
     accepted same-cycle as first application word — verify the
     derivation), ADR-0008 obligations; M19's ΔC=0, 15 strobes, and
     the frames-not-pulses conservation fact (first scope with two
     double-pulsing modules); M20's **REQ-006 closure at 13 cycles /
     83.2 ns at both start lanes** vs 24 allocated — re-derive by both
     routes (stage sum 3+3+1+4+2 and (L+h)/8 = 104/8 at each lane)
     and check the 11-cycle slack itemisation; C-3's answer
     (`app_rx_hdr_valid` as the zero-payload observable).
  2. **The architect's seven questions, answered in their order**:
     (1) **ADR-0011** — the sharpest: REQ-709's remedy left M18/M15/
     M09 holding an unterminated frame and its own verification
     column failed a conformant design; the decision is
     abandon-in-place + `clear` recovers + REQ-709's column gains the
     `clear`, with the M04 consume-and-discard repair priced and
     deferred (it contradicts REQ-207 and changes a frozen §6).
     Judge the decision AND the pricing. (2) the `cfg_tx_enable → M18`
     edge (one application word slips through otherwise). (3) M18's
     W−J = 1. (4) REQ-006 = 13 at both lanes. (5) M17's ΔC=2.
     (6) M17's precedence scoping sentence. (7) SPEC-M04 §9's "pulse
     together" bullet — frozen batch-B text the architect deliberately
     did not edit; your call whether it needs a §13 diff or stands.
  3. **Reaffirm or contest C-24…C-30 as landed** at aaa55b2 (each a
     §13-recorded diff on frozen text; none touched a lift — verified
     at acceptance). Also the eleven further §11 closures the
     architect made (items whose Closes-by named M18/M20/batch F) and
     ADR-0010's two conventions answers.
  4. New carry-forwards C-31+ with must-land-before gates.
  5. If all four verdicts positive: the countersignature sentence for
     batch F at aaa55b2 for transcription — **this is the last one;
     on it, all twenty Phase-1 specifications are FROZEN and the gate
     goes to the sponsor for signature.** If any negative: the exact
     owed-diff list.
  - Journal **J-dv_lead-0010**; Files-in-this-commit = exactly what
    you touch plus this packet.
- **Definition of done**: four verdicts + seven answers + ledger
  reaffirmation; sentence or owed diffs.
- **Out of scope**: editing specs/requirements/ADRs (architect's);
  docs/gates/ (orchestrator's); RTL; tests.
- **Evidence**: CI `build` run on aaa55b2 (the batch-F lifts' first
  elaboration — id and conclusion appended below before spawn).
## Task
The sixth and final countersign cycle of P1-spec-freeze. Twenty
specifications, six batches, every freeze behind a compile proof and
your adversarial signature. Finish it.
## Return / verdict log
