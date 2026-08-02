# WO-0007: Batch A testability countersignature (SPEC-M01, SPEC-M02)
- **State**: ISSUED
- **From** / **To**: orchestrator → dv_lead
- **Spec basis**: docs/specs/modules/axi64.md and crc32_eth.md at 22145b5
  (DRAFT, template-complete); their ifc_check lifts (compile evidence: build
  run 30727252770, green — the first ppx elaboration of these records);
  docs/specs/SPEC-TEMPLATE.md; requirements.md at b4b4cf4; the WO-0006
  Return log (architect's open questions and their dispositions in the
  ACCEPTED entry); the carry-forward ledger (C-1/C-4 are batch-B scoped)
- **Deliverables**:
  - A verdict entry in this packet's Return log: per spec, SIGNED or
    CONTESTED (contested = the specific sections a test writer cannot work
    from, phrased as spec-diff requests). Judge each spec as the reader who
    will hand excerpts to a tb_writer who never sees RTL. Explicitly judge:
    (a) SPEC-M02's finished-CRC port convention (constants read directly at
    crc_out, seed 0x00000000) — the convention your own REQ-303/304
    findings made load-bearing; (b) SPEC-M01's Status record vs the §12
    strobe appendix (names, order, completeness); (c) the "not applicable"
    answers — each is honest or it isn't.
  - If both SIGNED: the sentence "I countersign batch A (SPEC-M01,
    SPEC-M02) for P1-spec-freeze at 22145b5" in your journal entry, for
    orchestrator transcription to the gate table.
  - Journal entry J-dv_lead-0003; Files-in-this-commit: exactly this
    packet.
- **Definition of done**: both specs judged; the countersignature decision
  explicit either way; no edits outside this packet + your journal.
- **Out of scope**: re-reviewing requirements.md (signed at b4b4cf4);
  bench construction; the REQ-010/M02 narrowing (already agreed for batch
  B — judge M02 against the agreed future wording, noting that you do so).
## Task
The freeze-or-contest decision for the two foundation specs. Sign only
what you can defend to the auditor.
## Return / verdict log
(dv_lead appends on RETURNED)
