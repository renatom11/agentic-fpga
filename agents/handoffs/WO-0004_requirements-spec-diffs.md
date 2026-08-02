# WO-0004: Apply the WO-0003 spec diffs (D-1 … D-16)
- **State**: ISSUED
- **From** / **To**: orchestrator → architect_docs_lead
- **Spec basis**: agents/handoffs/WO-0003_testability-findings.md at 9a6195a
  (the sixteen diffs D-1…D-16, §14.3, and the cross-cutting findings
  X-1…X-10 that motivate them); docs/specs/requirements.md at 08899d3 (your
  file under revision); WO-0003's ACCEPTED entry (orchestrator rulings,
  including the confirmed CRC constants)
- **Deliverables**:
  - Revised `docs/specs/requirements.md` — all sixteen diffs applied or
    individually contested (see Task). The two constants are already
    adjudicated: REQ-303 check value → `0xCBF43926`, REQ-304 residue →
    `0x2144DF1C` under REQ-301's stated convention (independently confirmed
    by the orchestrator with zlib; do not re-litigate, do cite).
  - Revised `docs/specs/traceability.md` — rows updated wherever a diff
    renumbers, splits, adds, or deletes a REQ; the REQ-set/row-set equality
    must survive (the orchestrator re-checks it at acceptance).
  - `docs/specs/architecture.md` and/or `docs/specs/SPEC-TEMPLATE.md` edits
    ONLY where a diff explicitly requires transcription or reconciliation
    (e.g. the D-3 IFG/line-rate convention must end up stated identically in
    §0 and REQ-004/REQ-204 — one convention, both documents).
  - A `## Spec-diff record — WO-0004` section appended to the findings
    file? NO — the findings file is dv_lead's; instead record the
    disposition table (D-n → applied/contested, one line each) in the
    Return log below and the detail in your journal entry.
  - Journal entry `J-architect_docs_lead-0002` per PROTOCOL §4;
    Files-in-this-commit listing exactly the docs/specs files you touched
    plus this packet.
  - Return log entry below (state → RETURNED).
- **Definition of done**: every one of D-1…D-16 either applied or contested
  with a stated technical reason (a contest is not a veto — it goes back to
  dv_lead with the orchestrator arbitrating); the D-3 convention collision is
  resolved to ONE stated IFG/line-rate convention used consistently
  everywhere (your §0 derivation and REQ-204 currently disagree — pick the
  one you can defend against IEEE 802.3 deficit-idle-count behavior and
  restate the other); the four UNTESTABLE rows (REQ-019, REQ-510, REQ-802,
  REQ-901) each end up testable, deleted, or explicitly re-scoped; the two
  arithmetic slips (REQ-408 "50 octets"→46; REQ-605 padding example) fixed;
  REQ/traceability set equality holds.
- **Context provided**: dv_lead judged 55 rows immediately workable and
  called the document good — this is a surgical revision, not a rewrite.
  Most diffs are one sentence; several are transcriptions of material
  already in architecture.md. dv_lead's countersignature will be sought
  against your post-diff text (follow-up WO), so precision here shortens
  the loop.
- **Out of scope**: new requirements beyond what the diffs demand; RTL;
  tests; per-module specs; edits outside docs/specs/** and this packet.
## Task
Apply the review. Where you disagree with a diff, contest it explicitly in
the Return log with the technical reason — silent partial application is the
one unacceptable outcome, because dv_lead re-reviews against the diff list.
## Return / verdict log
(architect appends on RETURNED)
