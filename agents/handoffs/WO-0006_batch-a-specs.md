# WO-0006: Batch A module specifications (M01 Axi64, M02 Crc32_eth)
- **State**: ISSUED
- **From** / **To**: orchestrator → architect_docs_lead
- **Spec basis**: docs/specs/SPEC-TEMPLATE.md (normative form, verbatim-lift
  rule 6); docs/specs/architecture.md §4 (M01/M02 rows), §8 (batch A);
  docs/specs/requirements.md at b4b4cf4 (SIGNED text — REQ-010…014, 802 for
  M01; REQ-301…306 for M02); the P1-spec-freeze checklist (carry-forwards)
- **Deliverables**:
  - `docs/specs/modules/axi64.md` — SPEC-M01, status DRAFT, every template
    section answered ("not applicable + why" where honest: M01 is types
    only, no circuit, so `create`/`hierarchical` do not apply — say so
    under the template's own rule).
  - `docs/specs/modules/crc32_eth.md` — SPEC-M02, status DRAFT. The
    combinational 1–8-octet update contract, the REQ-303/304 constants
    (cite the provenance note, do not restate history), and the REQ-305
    software-reference oracle relationship.
  - `docs/specs/ifc_check/axi64_ifc.ml` and
    `docs/specs/ifc_check/crc32_eth_ifc.ml` — the §4.1 blocks lifted
    verbatim per template rule 6. M01's file is the programme-wide types
    home the template names (`Ifc_check_axi64` open target); write it so
    later spec lifts can `open` it without restating the records.
  - Journal entry `J-architect_docs_lead-0003`; Files-in-this-commit =
    the four files above + this packet.
  - Return log entry below (state → RETURNED).
- **Definition of done**: template-complete against every numbered section;
  every behavioural claim cites a REQ from the b4b4cf4 text; the two
  ifc_check lifts are compile-plausible v0.17 OCaml (CI proves them after
  the orchestrator commits); no carry-forward items regress (C-1/C-4 are
  batch-B scoped — do not attempt them here); DRAFT status explicit —
  freeze happens later with dv countersign + green run.
- **Out of scope**: batches B–F; RTL; tests; edits to requirements.md or
  architecture.md (contest via Return log if a spec exposes a defect).
## Task
First two per-module specs, setting the form the other eighteen follow.
M01 is the vocabulary every later spec quotes — precision here compounds.
## Return / verdict log
(architect appends on RETURNED)
