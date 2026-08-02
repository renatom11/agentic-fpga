# WO-0019: Batch F specifications (M17–M20, the last four) + closeout diffs
- **State**: ISSUED
- **From** / **To**: orchestrator → architect_docs_lead
- **Spec basis**: architecture.md §4 rows M17–M20 and §8 batch F; the
  FROZEN batches A–E (D and E countersigned at 3f6accc, J-dv_lead-0009,
  WO-0018 — the gate checklist records both flips); the WO-0018 Return
  log (dv's five answers and C-24…C-30, your primary input for the
  diff set); the WO-0016 Return log §5 (rtl_lead's two conventions
  questions); requirements.md UDP + top-level blocks; ADR-0008/0009.
- **Deliverables**, in order:
  1. **Batch-D/E spec Status-line flips** (the batch-C precedent, done
     at WO-0014): SPEC-M10…M13 and SPEC-M14…M16 flip from DRAFT to
     **FROZEN at 3f6accc**, each §12 completed — batch D's four rows
     already carry run 30736107842/2f29888; batch E's three rows fill
     with run **30739442056 / success / 3f6accc** (head SHA = spec
     commit, no witnessing sentence owed) and their §11.1 items close.
     dv countersignature reference: `J-dv_lead-0009` for both batches.
  2. **The C-24…C-30 diff set** (each now a §13-recorded spec diff on
     frozen text — none touches a §4.1 lift; full statements in the
     WO-0018 Return log §5): C-24 (REQ-502's figure becomes "7 or 8 by
     residue" in SPEC-M13 §6.1/§7 and REQ-502's verification column);
     C-25 (the "later of" branch: five lengths not one, 46–50-octet
     pricing, and the §6.2 (D) stage-model note); C-26 (M14 §9
     truncation branch goes extensional per REQ-605 + the `Header`
     row's Idle-list addition for the zero-payload-octets case); C-27
     (M14 §7 scopes the parse-latency constant to gap-free headers;
     §10's REQ-016 hook names L); C-28 (M13's REQ-505 header gains
     "(the strobe and request half)", §10 row gains the disclaimer,
     §8 item 1 names its assertion level); C-29 (M16 §7's transmit
     anchor: 1 cycle after M15 emits, 2 after acceptance); C-30 (M14
     §8 gains the `clear` conservation exemption, M10 §8's new
     paragraph as the wording model). dv's answer (iii) also asks one
     scoping sentence so M17 copies the independent-evaluation rule.
  3. **Answers to rtl_lead's two conventions questions** (WO-0016
     Return log §5; both block batch-B RTL issuance): (a) is
     `open! Axi64` the house consumer convention for the `Axi64.Axi64`
     nesting — rtl_lead proposes yes; state it normatively where
     future rtl_module_dev packets can cite it (SPEC-M01 §4
     conformance note or an ADR, your call); (b) should SPEC-M02's
     `module type S` exist as a named library artifact (e.g. for
     functorising M03/M04 over the CRC engine)? Decide and record.
  4. **SPEC-M17 (`Udp_ip_rx_64` — UDP parse/length checks/port
     filter/realignment, REQ-701–704/707/021), SPEC-M18
     (`Udp_ip_tx_64` — UDP header construction, REQ-705/706/709; the
     parked REQ-810 tready semantics question from the board resolves
     here or is explicitly §11'd), SPEC-M19 (`Udp_complete_64` —
     structural, M16+M17+M18, REQ-708), SPEC-M20 (`Nic_top` — Phase-1
     top, M05+M19, config/status aggregation, application streams,
     REQ-801–809 + REQ-006's end-to-end budget)**: DRAFT,
     template-complete, lifts byte-identical, declare-once records,
     the REQ-506 two-half pattern where REQs span modules (note C-28's
     tiling lesson: name the half in the header AND disclaim in §10).
     M20 §1.1: the receive-chain budget closes here — the five-stage
     allocation 4/3/1/5/4 = 17 of 24 plus M14's reserve; state the
     end-to-end derivation. M17 copies M14's independent-evaluation
     rule with dv's scoping sentence. ADR-0008 binds M18's header
     handshake (restate source obligations as SPEC-M11/M15 did).
  5. traceability.md rows for batch F; set equality survives —
     after this batch every REQ row names its owning spec.
  - Journal **J-architect_docs_lead-0008**; Files-in-this-commit =
    exactly what you touch plus this packet. Return log with per-item
    dispositions and the two conventions answers stated for rtl_lead.
- **Definition of done**: D/E flips + §12 fills recorded; C-24…C-30
  landed as §13-recorded diffs; both conventions questions answered;
  four batch-F specs template-complete; set equality holds; the
  20-module inventory fully drafted.
- **Out of scope**: RTL (`libs/**`); tests; `test/**`, `tools/**`;
  `docs/gates/` (orchestrator transcribes).
## Task
The last spec batch. When this returns and dv countersigns it, all
twenty Phase-1 specifications are FROZEN and the P1-spec-freeze gate
needs exactly one thing: the sponsor's signature.
## Return / verdict log
