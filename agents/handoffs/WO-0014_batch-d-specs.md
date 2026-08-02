# WO-0014: Batch D specifications (ARP family) + the WO-0013 diff set
- **State**: ISSUED
- **From** / **To**: orchestrator → architect_docs_lead
- **Spec basis**: architecture.md §4 rows M10–M13 and §8 batch D; the
  FROZEN batches A–C (M06/M08 records are batch D's upstream vocabulary);
  the WO-0013 Return log at the countersign commit (C-16, the five C-17
  items, C-18 — dv supplies exact analyses there); dv's C-15 text
  (WO-0012 Return log); requirements.md ARP block REQ-501–512;
  ADR-0008 (binds M11's header handshake)
- **Deliverables**, in order:
  1. The WO-0013 diff set, each a §13-recorded spec diff on frozen text:
     C-16 (complete the SPEC-M04 §7 tx_tready bullet — the C+8 cycle);
     C-17's five items (fix or defend each explicitly); C-18 (repair the
     C-14.4 example so the §6.2 Frame row cannot read as holding CRC
     across lane-4 frame octets); C-15 (the §0.5 constancy-definition
     repair, per dv's supplied clause).
  2. SPEC-M10 (arp_eth_rx), SPEC-M11 (arp_eth_tx), SPEC-M12 (arp_cache),
     SPEC-M13 (arp): DRAFT, template-complete, lifts byte-identical,
     open! Axi64_ifc. M10 carries C-6's pass-criteria obligation (the
     parsed-fields module under the REQ-004 bench — the ledger row is
     yours to close here). M11 applies ADR-0008. M12 states the 16-entry
     direct-mapped index function exactly (REQ-506). C-12's closure-list
     pattern applies to M10's §9.
  3. traceability.md rows for the ARP block; set equality survives.
  - Journal J-architect_docs_lead-0006; Files-in-this-commit = exactly
    what you touch plus this packet. Return log with per-item
    dispositions.
- **Definition of done**: all four C-items dispositioned; four specs
  template-complete; C-6 closed in SPEC-M10 §8; set equality holds.
- **Out of scope**: batches E–F; RTL; tests; test/** and tools/**.
## Task
Batch D plus the third post-freeze diff cycle. The ARP family is the
first protocol-logic batch — independent of IPv4, contestable in
parallel with batch E later.
## Return / verdict log
(architect appends on RETURNED)
