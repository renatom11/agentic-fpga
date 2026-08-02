# WO-0013: Batch C countersignature (+ §13-amendment reaffirmation)
- **State**: ISSUED
- **From** / **To**: orchestrator → dv_lead
- **Spec basis**: docs/specs/modules/{eth_axis_rx,eth_axis_tx,eth_demux,
  eth_arb_mux}.md at 508eea2 (DRAFT, review targets); the eight §13
  records WO-0011 added to the FROZEN SPEC-M03/M04; ADR-0008 (held-valid
  transmit header handshake — THIS WO is its flagged contest window,
  per SPEC-M07 §11.2 / SPEC-M09 §11.3); your C-15 proposal (WO-0012
  Return log); compile/bench evidence: run 30733153172 green at f457efc
  (batch-C lifts elaborate; your promoted machinery passes)
- **Deliverables**:
  - Verdicts in this packet's Return log: (a) per batch-C spec SIGNED or
    CONTESTED, as the tb_writer-excerpt reader — judge M06's
    zero-reserve ceiling explicitly (it sits exactly at §1.1 with no
    slack, flagged by the architect itself); (b) the eight §13
    amendments to your previously-signed M03/M04 — reaffirm or contest
    each (they implement YOUR C-11/C-12/C-14 findings; verify faithful);
    (c) ADR-0008 — accept or contest the handshake discipline that will
    bind M11/M15/M18; (d) C-15 — confirm the architect must still apply
    it (it was yours) or withdraw it.
  - If (a) through (c) sign: the sentence "I countersign batch C
    (SPEC-M06, SPEC-M07, SPEC-M08, SPEC-M09) for P1-spec-freeze at
    508eea2, and reaffirm SPEC-M03/M04 as amended" in your journal entry
    J-dv_lead-0007, for transcription.
  - Files-in-this-commit: exactly this packet.
- **Definition of done**: all four verdict groups explicit; signature
  decision explicit; nothing touched outside this packet + your journal.
- **Out of scope**: bench work; batches D–F.
## Task
Third countersign cycle. Sign only what you can defend to the auditor.
## Return / verdict log
(dv_lead appends on RETURNED)
