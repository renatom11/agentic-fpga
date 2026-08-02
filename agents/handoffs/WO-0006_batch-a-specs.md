# WO-0006: Batch A module specifications (M01 Axi64, M02 Crc32_eth)
- **State**: RETURNED
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

### RETURNED — architect_docs_lead, 2026-08-02T04:40Z
- **State**: ISSUED → **RETURNED** (awaiting orchestrator commit, then dv_lead
  batch-A testability countersignature)
- **Journal**: `J-architect_docs_lead-0003`
- **Spawn short-id**: WO-0006/2026-08-02T03:45Z

**Deliverables**

| Path | What it is |
|---|---|
| `docs/specs/modules/axi64.md` | SPEC-M01 `Axi64`, DRAFT. Types only: `Axi64_config` (64/1), `Axi64 = Hardcaml_axi.Stream.Make`, `Eth_header`, `Ip_header`, `Udp_header`, `Config` (the twelve §9.1 fields), `Status` (the twenty-one §12 strobes, in §12's order and named as §12 names them). All thirteen template sections present. |
| `docs/specs/modules/crc32_eth.md` | SPEC-M02 `Crc32_eth`, DRAFT. Combinational 1–8-octet update stated as an equation over CRC32(·), two worked examples with real numbers, the REQ-305 oracle relationship including its anchoring obligation, no `clock` and no `clear`. |
| `docs/specs/ifc_check/axi64_ifc.ml` | SPEC-M01 §4.1 lifted verbatim; the programme-wide types home other lifts open. |
| `docs/specs/ifc_check/crc32_eth_ifc.ml` | SPEC-M02 §4.1 lifted verbatim; opens `Axi64_ifc` and restates no shared record. |

**DoD check against this packet**
- Template-complete against every numbered section: yes. Sections answered "not
  applicable" plus one sentence of why — SPEC-M01: §4.1's `create`/`hierarchical`
  clause, §4.2's direction column, §6.2, §7 (all five clauses individually), §8,
  §9; SPEC-M02: §4.1's `Source`-without-`Dest` clause, §5, §6.2, §8, §9, and
  three clauses of §7.
- Every behavioural claim cites a REQ from the b4b4cf4 text: yes. That text was
  confirmed identical to the working tree before writing (`git diff b4b4cf4 --
  docs/specs/requirements.md` empty).
- REQ-303/REQ-304 cite the requirements.md §4 provenance note and do not restate
  its history: yes.
- Lifts compile-plausible: both parse (`ocamlc -stop-after parsing`); type
  checking and ppx elaboration have **not** run — hardcaml is not installed in
  the container, and per ADR-0005 CI on your commit is the only acceptable
  evidence. Both freeze records say `pending` accordingly.
- Carry-forwards: C-1 and C-4 not attempted (batch-B scoped) and not regressed.
  Neither spec pins a latency constant, so C-1's ceiling-unit question has no
  instance in batch A.
- DRAFT status explicit in both, with all four freeze rows `pending`.

**Contested / raised — none applied, per this packet's read-only rule**

1. **REQ-010 versus SPEC-M02's `data` port (spec diff proposed).** REQ-010 binds
   *all* frame-carrying ports to `Axi64.Source`/`Axi64.Dest`. M02's `data` port
   carries frame octets and is deliberately not a stream: REQ-306 forbids it the
   state that would give `tvalid`/`tlast`/`tkeep`/`tuser` meaning, so its
   interface compile check has no `Axi64` port to witness. Read literally, M02 is
   the one Phase-1 module that cannot satisfy an invariant it is bound by.
   Proposed diff: narrow REQ-010's subject to frame-carrying **stream** ports and
   name M02 as the non-stream case. No behaviour changes; it removes a standing
   audit finding. Needs dv_lead's countersignature, since it changes what the
   compile check quantifies over. (SPEC-M02 §11.3.)
2. **Two ADRs owed, requested as work.** This packet's file set excludes
   `docs/adr/`. (a) SPEC-M02's port value convention — the ports carry the
   *finished* CRC-32 (final XOR applied), seeded 0x00000000, rather than the raw
   shift register seeded 0xFFFFFFFF; the alternative and the reason (it removes
   an XOR conversion from REQ-303, REQ-304, the REQ-305 oracle comparison and any
   co-simulation adapter — and requirements.md §4's provenance note records that
   this programme has already lost a cycle to exactly this class of convention
   error) are in the spec and the journal. (b) `octet_count` as a 4-bit count
   with domain 1–8, against a 3-bit count-minus-one that would be total but
   off-by-one-prone at every call site. Charter §3 makes both ADR material.
3. **`traceability.md` is eleven rows stale.** SPEC-TEMPLATE §10 requires the
   matrix to be updated in the same commit as the spec; this packet's file set
   excludes it, so REQ-010…014, REQ-301…306 and REQ-802 still read `pending` in
   the Spec-section column. The work-order file set won. Either batch B's WO
   carries the matrix update for A and B together, or a small architect WO does
   batch A alone. REQ-904's CI check is on the *row set*, not this column, so
   this will not fail loudly. (SPEC-M01 §11.2.)
4. **`SPEC-TEMPLATE.md` names a module that cannot exist.** Its §4.1 comment
   tells later specs to write `open Ifc_check_axi64`; rule 6 names the file
   `<module>_ifc.ml` and `docs/specs/ifc_check/dune` declares `(name ifc_check)`,
   so the module a sibling lift opens is `Axi64_ifc` — which is what both lifts
   use. One-line editorial diff to the template, owed before batch B's authors
   copy the wrong name. (SPEC-M01 §11.3.)

**Open questions carried into batch B**

- Should M01 also home the XGMII lane pair? architecture.md §4 gives it no such
  record, so M03/M04/M05/M20 will each restate `xgmii_rxd`[63:0] /
  `xgmii_rxc`[7:0]. Decide when the fourth restatement is in a diff.
  (SPEC-M01 §11.1.)
- `Axi64.Source`'s field names (`tvalid`, `tdata`, `tkeep`, `tstrb`, `tlast`,
  `tuser`, `tready`) are transcribed from `hardcaml_axi` v0.17.0 via
  architecture.md §10 and are **not yet verified by any compile** — run
  30724505231 used the type without naming a field. SPEC-M01 §4.2 and §6.1 quote
  them normatively. Batch B, or rtl_lead's first `Source` construction, settles
  it; a divergence is editorial, not a change of meaning. (SPEC-M01 §11.4.)
- Whether `octet_count` = 0 should be given the identity meaning as a new
  REQ-307 depends on whether M03 or M04 actually sequences an update-by-zero
  cycle; unconstrained until they say. (SPEC-M02 §11.2.)
- Which FCS-check formulation M03 uses — compare against the received FCS, or
  continue over it and check REQ-304's residue — is left to SPEC-M03 so that the
  choice is specified rather than discovered in RTL. (SPEC-M02 §11.4.)

**For dv_lead's countersignature, the three places to look hardest**: SPEC-M02
§6.1's value convention and its two worked examples (every number there was
computed, not recalled — journal Evidence item 4 gives the commands); SPEC-M02
§6.3's unconstrained region and the instruction that DV assert nothing there and
that formal assume 1 ≤ `octet_count` ≤ 8; and SPEC-M01 §4.2's `Status` paragraph,
which fixes the twenty-one field names but deliberately leaves M20's `rtlprefix`
unconstrained.

### ACCEPTED — orchestrator, 2026-08-02T04:45Z, journal `J-orchestrator-0036`

DoD met at 22145b5, subject to the one evidence item only CI can supply.
Mechanical checks at acceptance: staged set = the five declared paths;
both §4.1 blocks byte-identical to their ifc_check lifts (re-verified,
not trusted); Status record carries exactly the twenty-one §12 strobes.
The ifc_check compile on this push is the first ppx elaboration of these
records anywhere (ADR-0005) — the freeze table stays `pending` until
that run ID lands. Dispositions of the open questions:
1. REQ-010 vs M02's `data` port: AGREED in principle — the proposed
   narrowing (frame-carrying *stream* ports) goes to batch B as a spec
   diff with dv_lead's countersignature covering it.
2. The two owed ADRs (CRC port convention; octet_count encoding):
   assigned to batch B's packet.
3. traceability.md spec-target column (11 rows): batch B packet.
4. SPEC-TEMPLATE `Ifc_check_axi64` → `Axi64_ifc` naming fix: batch B
   packet (one line, before batch-B authors copy the template).
5. Source field-name verification: noted — the batch-B M03 lift will
   name Source fields and settle it in CI.
6. Batch-B design questions: carried into that packet as written.
Next: green ifc_check run → WO-0007 (dv_lead batch-A countersign) →
batch A FROZEN in the gate table.
