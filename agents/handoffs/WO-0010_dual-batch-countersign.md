# WO-0010: Dual-batch countersignature (batches A + B freeze together)
- **State**: ISSUED
- **From** / **To**: orchestrator → dv_lead
- **Spec basis**: docs/specs/modules/{xgmii_rx_64,xgmii_tx_64,eth_mac_10g}.md
  at f78766e (DRAFT, the review targets) and the revised
  {axi64,crc32_eth}.md at the same SHA (§11-reconciled + the §4.1 XGMII
  addition); requirements.md as revised by WO-0008; the WO-0008 Return log
  (deliverable dispositions, the architect's six §9 rulings, its C-1
  resolution); the P1-spec-freeze checklist (C-11; the batch-A
  superseded-evidence note); compile evidence: run 30729342467 (all five
  lifts elaborate at f78766e) and run 30730405776 (bench layer + your own
  C-9 record-vs-appendix checks green at 00d7a7f)
- **Deliverables**:
  - Verdicts in this packet's Return log:
    (a) per batch-B spec — SIGNED or CONTESTED, judged as the reader who
    hands excerpts to a tb_writer who never sees RTL;
    (b) the post-signature SPEC-M01 §4.1 addition (the `Xgmii` record
    home) — accept or contest; your batch-A signature stands either way,
    the question is whether it extends to the addition;
    (c) the architect's C-1 resolution — unit change to ΔC = (L + h)/8,
    allocation 4/3/1/5/4 = 17 stands, 7-cycle slack restored. Your
    explicit judgment here SEALS the sponsor's delegated latency-budget
    decision (board, 2026-08-02) — accept, or contest with numbers;
    (d) the six §9 rulings the architect flagged as its own (error
    character closes a frame; start-during-REQ-108-discard is
    resynchronisation; underflow transmits accepted words before /E/;
    and the remaining three in the WO-0008 Return log);
    (e) C-11 — your own REQ-015 wording: propose the deletion or
    restatement, judged against the 190-word figure's counting
    convention.
  - If (a) through (c) all sign: the sentence, in your journal entry,
    "I countersign batches A and B (SPEC-M01, SPEC-M02, SPEC-M03,
    SPEC-M04, SPEC-M05) for P1-spec-freeze at f78766e" — orchestrator
    transcribes it and both batches flip FROZEN in the gate table.
  - Journal entry J-dv_lead-0005; Files-in-this-commit: exactly this
    packet.
- **Definition of done**: all five verdict groups explicit; the signature
  decision explicit either way; no edits outside this packet + your
  journal.
- **Out of scope**: bench work (your machinery is committed and green);
  batches C–F; re-reviewing unchanged batch-A text.
## Task
The largest single freeze decision of Phase 1: five specs, the sealed
latency budget, and the §9 rulings that will bind M03's bench. Sign only
what you can defend to the auditor.
## Return / verdict log
(dv_lead appends on RETURNED)
