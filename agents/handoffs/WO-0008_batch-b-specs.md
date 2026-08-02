# WO-0008: Batch B specifications + the accumulated spec-diff backlog
- **State**: ISSUED
- **From** / **To**: orchestrator → architect_docs_lead
- **Spec basis**: architecture.md §4 (M03/M04/M05 rows) and §8 (batch B);
  SPEC-TEMPLATE.md; requirements.md at b4b4cf4; the WO-0006/WO-0007 Return
  logs (ACCEPTED dispositions); the P1-spec-freeze checklist ledger
  (C-1, C-4, C-8, C-10 land in this WO); the board's 2026-08-02 sponsor
  decisions (latency-budget delegation)
- **Deliverables**, in this order of importance:
  1. **§11 reconciliation** (unblocks the batch-A FROZEN flip):
     SPEC-TEMPLATE §11 amended — a FROZEN spec may carry no OPEN
     questions; deferred items must cite a tracked ledger row or WO and
     state what a reader should assume meanwhile. Both batch-A specs'
     §11 sections converted to that form (their eight items each cite
     C-numbers or this WO). Fold in C-10 (restore REQ-013's "solely" in
     SPEC-M01 §6.1) and the template's `Ifc_check_axi64` → `Axi64_ifc`
     naming fix.
  2. **requirements.md diffs** (small, enumerated): the agreed REQ-010
     narrowing to frame-carrying stream ports, naming M02; C-8 (REQ-903's
     quantifier — exclude or split the types-only case, address the .mli
     half); C-4 (REQ-105/110 zero-delivered-octet tuser wording).
  3. **C-1 resolution with dv_lead's proposal as the starting point**
     (compare (L + h)/8, not floor(L/8)) — restate §1.1's comparison
     method and the REQ-006 budget coherently. SPONSOR MANDATE ON RECORD
     (board, 2026-08-02): the sponsor delegated the budget resolution to
     you and dv_lead jointly; whatever you two converge on at the batch-B
     countersignature is sponsor-authorized. State your resolution in the
     spec text and flag it in the Return log for dv_lead's explicit
     judgment.
  4. **Two ADRs**: docs/adr/ADR-0006 (Crc32_eth finished-value port
     convention — the deciding argument is on record in SPEC-M02 and
     WO-0006), docs/adr/ADR-0007 (octet_count 4-bit 1–8 encoding).
  5. **traceability.md** spec-target column: batch-A rows (the eleven
     stale plus any this WO changes) point at their spec sections.
  6. **The three batch-B specs**: docs/specs/modules/xgmii_rx_64.md
     (SPEC-M03), xgmii_tx_64.md (SPEC-M04), eth_mac_10g.md (SPEC-M05),
     DRAFT, template-complete, plus ifc_check lifts. The M03 lift MUST
     name Axi64.Source fields explicitly (settles SPEC-M01 §11.4 in CI).
     Resolve the deferred batch-B design questions from WO-0006
     (XGMII lane-pair type home; whether octet_count = 0 needs a REQ-307
     identity; M03's FCS-check formulation) and record the choices.
  - Journal entry J-architect_docs_lead-0004; Files-in-this-commit =
    exactly what you touched (docs/specs/**, docs/adr/ADR-0006/0007,
    this packet).
  - Return log entry (state → RETURNED) with a deliverable-by-deliverable
    disposition table.
- **Definition of done**: batch-A specs carry zero OPEN §11 items under
  the amended wording; REQ/traceability set equality survives every
  requirements.md change; the C-1 resolution is stated in one place and
  cross-referenced; both ADRs cite their provenance; the three new specs
  are template-complete with lifts byte-identical.
- **Out of scope**: batches C–F; RTL; tests; bench design (dv_lead's
  WO-0009, running in parallel — do not touch test/** or tools/**).
## Task
Batch B plus the backlog the first freeze cycle accumulated. The §11
reconciliation comes first because a signed batch is sitting un-frozen
on its account.
## Return / verdict log
(architect appends on RETURNED)
