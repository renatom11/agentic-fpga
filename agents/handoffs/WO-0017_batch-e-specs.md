# WO-0017: Batch E specifications (M14–M16) + the WO-0015 owed-diff set
- **State**: ISSUED
- **From** / **To**: orchestrator → architect_docs_lead
- **Spec basis**: architecture.md §4 rows M14–M16 and §8 batch E; the
  FROZEN batches A–C; batch D at a9993ff (M10/M11/M12 SIGNED, M13
  CONTESTED — the WO-0015 Return log at 619afa7 is the authority for
  everything below); requirements.md IPv4/UDP blocks; ADR-0008.
  dv_lead explicitly cleared batch-E drafting in parallel with the
  batch-D repairs: neither owed diff moves a port, a record, or a
  latency constant.
- **Deliverables**, in order:
  1. **The D-1 repair** (SPEC-M13, blocking): the ARP module retains
     two replies where REQ-510's normative sentence says one, and
     SPEC-M13 §8 item 2, §10's REQ-510/REQ-810 rows, and REQ-510's own
     verification column all commission a strobe a conformant design
     does not pulse. dv recommends **R-1** (extend the pending window
     to the reply frame's completion — no port, no record, no
     requirements diff; verified free in the unblocked case) over R-2
     (weaken REQ-510 to match the mechanism). The choice is yours; the
     divergence must close. If R-1: machine (A) gains a state or
     `Pending`'s exit changes, §6.1's pending paragraph changes one
     clause, and the four counting sites become correct as written.
  2. **The D-2 repair** (SPEC-M10 §11.3 + SPEC-M13 + requirements.md,
     blocking): REQ-013's "the ultimate consumer must discard it" is
     discharged by nobody on the ARP branch — a bad-FCS frame commits a
     wrong IP→MAC binding for `entry_lifetime_cycles` with no strobe.
     First, **correct §11.3's cost estimate whichever repair you
     choose**: the repair needs no `Arp_packet` field (the bit arrives
     ≥2 cycles after the record; M13 already owns `rx_payload_tuser`).
     Then choose: **D-2a** (recommended — M13 gates the REQ-503
     learning write and the reply on `tuser`[0] = 0 observed at the
     payload `tlast`; learning moves to `tlast` + 1; REQ-503 gains the
     "and not marked invalid" qualifier; no interface change anywhere)
     or **D-2b** (keep the behaviour as a recorded programme decision:
     §11.3 becomes a decision citing REQ-013's first clause, and
     requirements.md REQ-013 gains the exemption sentence). Under D-2a,
     SPEC-M10 §2's abort row and §11.3 move (owner becomes M13).
  3. **The five §11 closures owed regardless of verdicts** (SPEC-
     TEMPLATE §11 — closure recorded in place, row kept): SPEC-M10
     §11.3 (per D-2), SPEC-M11 §11.3 (Q1: instantiation, closes
     affirmatively), SPEC-M12 §11.3 (Q5: agreed, closes affirmatively),
     SPEC-M13 §11.2 (Q3: consequence clause, no `cfg_tx_enable`, NOT
     breaking — closes affirmatively), SPEC-M13 §11.3 (Q4: closes
     affirmatively **with dv's required sentence added**: alternating
     unresolved destinations defeat REQ-505's suppression — one request
     per miss — conformant in Phase 1; the per-slot-table trigger is
     >1 concurrent application destination).
  4. **§12 fills for all four batch-D specs**: Interface compile check
     = run **30736107842**, conclusion **success**, SHA **2f29888**
     (witnessing verified: `git diff a9993ff 2f29888 -- docs/specs/`
     empty); the four §11.1 items close on it.
  5. **C-19…C-23 dispositions** (ledger rows on the gate checklist;
     full statements in the WO-0015 Return log §5): C-19 (M11 §8
     item 2's loopback gains the one-cycle header lead — do NOT widen
     M10's Cp); C-20 (M10 §6.3 item 4's word-0 constant corrected to
     0x0406_0008_0100 / full word 0x0100_0406_0008_0100); C-21 (M10
     §6.1's XOR gains the `clear` exception §7 already mandates); C-22
     (ADR-0008's C-17(d) bullet gains dv's precedence clause: the
     prohibition binds a monitor built from the ADR alone unless the
     source's spec commits to a stronger discipline, whose cycle table
     then governs); C-23 (the strobe counting convention — one high
     cycle per event, monitors count high cycles not edges — in §0.6
     or SPEC-M13 §9, your call on the home; plus the REQ-502
     measurement-start disambiguation before any latency artifact
     quotes it). Also dv's non-blocking editorial: REQ-810's ARP
     clause wording ("is dropped under REQ-510" is false of the first
     reply); the §6 below-threshold readings are yours to take or
     leave, none commissions a failing assertion.
  6. **SPEC-M14 (`Ip_eth_rx_64` — IPv4 parse/validation/padding
     strip/realignment, REQ-601–607/611/612/021), SPEC-M15
     (`Ip_eth_tx_64` — IPv4 header construction + checksum,
     REQ-608–610), SPEC-M16 (`Ip_complete_64` — the structural
     IPv4-with-ARP wrapper, REQ-807/808)** per architecture.md §4's
     batch-E rows: DRAFT, template-complete,
     lifts byte-identical, `open! Axi64_ifc` (and batch-D lifts where
     their records are the vocabulary — the declare-once rule from
     WO-0014 §6.4 applies). REQ-506's two-half ownership pattern
     (SPEC-M12/M13 §5 + §10 mutual disclaimers) is the model dv wants
     batch E to copy where a REQ spans modules. ADR-0008 binds M15's
     header handshake — SPEC-M15 restates the source obligations as
     SPEC-M11 §7 did, and note C-22's precedence clause when you write
     the monitor-facing text.
  7. traceability.md rows for batch E; set equality survives.
  - Journal **J-architect_docs_lead-0007**; Files-in-this-commit =
    exactly what you touch plus this packet. Return log with per-item
    dispositions, and the D-1/D-2 choices stated with reasons.
- **Definition of done**: D-1 and D-2 landed (each a §13-recorded diff
  where it touches DRAFT text — batch D is NOT frozen, so these are
  pre-freeze corrections, the cheap kind); five §11 closures recorded
  in place; §12 rows filled; C-19…C-23 landed; batch-E specs template-
  complete; set equality holds. The batch-D re-review then re-checks
  only the D-1/D-2 landing sites + byte-identity/set-equality + a
  green run at the new SHA (dv's stated re-review surface).
- **Out of scope**: batch F; RTL (`libs/**` has in-flight rtl_lead
  work — do not touch, do not read for spec purposes); tests;
  `test/**`, `tools/**`; `docs/gates/` (orchestrator transcribes).
## Task
Batch E plus the first contested-verdict repair cycle. dv withheld the
batch-D countersignature on two derivable behavioural defects and
pre-worded the signature for the commit carrying your repairs — land
them well and batch D freezes at the re-review without re-litigation.
## Return / verdict log
