# Phase-1 traceability matrix — REQ to specification to test

- **Status**: LIVE — the test column is populated for its first module. **34 of
  110 rows** carry test-side cells (the M03 `Xgmii_rx_64` slice, WO-0079); the
  other **76** are empty and await their own modules' sign-off rounds.
- **Owner**: architect_docs_lead (matrix file) · **Work orders**: WO-0002
  (original), WO-0004 (rows added and retitled for the D-1 … D-16 spec diffs),
  WO-0079 (the M03 test-side rows delivered and transcribed)
- **Test column owner**: dv_lead (charter §4: DV supplies the test-side rows).
  The cells are **transcribed** into this file by architect_docs_lead, the only
  agent that may stage it (PROTOCOL §6) — which is why the test-side rows arrive
  as a packet and not as an edit.
- **Sources**: [`requirements.md`](requirements.md) (REQ text — normative),
  [`architecture.md`](architecture.md) §4 (module inventory)

---

## How this matrix is used

- **One row per REQ, always.** The row set of this file must equal the REQ set
  of `requirements.md` exactly; a REQ with no row, or a row with no REQ, is an
  audit finding. REQ-904 makes currency a gate condition: every REQ has a row
  before its owning module reaches `P1-module-ready`.
- **Spec section** is filled when the owning module's specification is written
  (`docs/specs/modules/<module>.md`, form in
  [`SPEC-TEMPLATE.md`](SPEC-TEMPLATE.md) §10). Until then it reads `pending`
  and the architecture section that establishes the requirement is the
  reference.
- **What the Spec-section column names for a programme invariant**
  (REQ-001 … REQ-021): the section that **fixes the invariant's contract** —
  its definitional home — and not every specification that restates it. Every
  module spec restates the invariants that bind it in its own §3 and §10
  (SPEC-TEMPLATE §3), and those restatements are found from the module, not
  from this column; listing twenty specs per invariant row would make the
  column unreadable and would have to be edited twenty times. A row still
  reading `pending` is one no written specification pins yet.
- **Currency**: batch A (SPEC-M01, SPEC-M02) and batch B (SPEC-M03, SPEC-M04,
  SPEC-M05) rows were filled under WO-0008, in the commit that wrote the batch-B
  specs; batch C (SPEC-M06, SPEC-M07, SPEC-M08, SPEC-M09) under WO-0011, in the
  commit that wrote them — ten rows, REQ-401 through REQ-410; batch D (SPEC-M10,
  SPEC-M11, SPEC-M12, SPEC-M13) under **WO-0014**, in the commit that wrote them
  — twelve rows, REQ-501 through REQ-512; batch E (SPEC-M14, SPEC-M15,
  SPEC-M16) under **WO-0017**, in the commit that wrote them — twelve rows,
  REQ-601 through REQ-612, plus three rows that gained a **second** owning module
  in the same commit (REQ-505, REQ-610, REQ-807; see below); batch F (SPEC-M17,
  SPEC-M18, SPEC-M19, SPEC-M20) under **WO-0019**, in the commit that wrote them
  — twenty rows, REQ-701 through REQ-710 and REQ-801 through REQ-810, plus the
  three invariant rows only a top-level specification can pin (REQ-001, REQ-006,
  REQ-020), plus the two `pending` halves batch E left visible (REQ-610 at M18
  and REQ-807 at M20), plus REQ-805 and REQ-810, which gained further owning
  modules. Matrix and spec in one commit, every time (SPEC-TEMPLATE §10).
- **After batch F, no row's Spec-section cell reads `pending`.** Twenty
  specifications exist and every requirement they own names one. Four rows
  deliberately name a *process* document instead of a module spec — REQ-902
  (the CI determinism step), REQ-904 (this file and its script), REQ-906
  (ADR-0005) and REQ-901 (requirements.md's own class list, with each class's
  module home named) — because no module specification fixes them and
  none should: they are obligations on the programme, and pointing a
  process requirement at a module spec would be a false claim of coverage.
- **REQ set equality survives spec diffs, and that is checked rather than
  assumed.** WO-0011's carry-forward diffs changed the *text* of REQ-010,
  REQ-015, REQ-105 and REQ-108, and WO-0014's changed requirements.md §0.5's
  constant-latency definition (carry-forward C-15); all of them added no
  requirement and retired none, so the 110-row set below is unchanged.
  requirements.md §13 records every one of those diffs and its class. REQ-904's
  CI script is what makes this a continuous check rather than a per-gate one.
- **Some rows name two owning modules for one requirement, deliberately.**
  REQ-503 is split between the module that decides to learn (M13) and the module
  that stores (M12), and REQ-506 between the *retry* half (M13) and the *ageing*
  half (M12) — the split is stated in both specifications' §5 and §10 and in
  SPEC-M12 §11.3, so a sign-off packet can show the whole requirement covered
  without either module claiming the other's part. REQ-502 and REQ-409 are
  two-module rows for the same reason. **dv_lead asked batch E to copy that
  pattern wherever a REQ spans modules** (WO-0015 Return log §4/Q5), and batch E
  adds three instances: **REQ-505** (M13 raises the strobe and issues the
  request; M15 performs the discard and drains the datagram — SPEC-M13 §9,
  SPEC-M15 §6.1 and §11.4), **REQ-610** (M15 emits the IPv4 total length without
  buffering; M18 computes it and owns the UDP length field — SPEC-M15 §5 and
  §11.3) and **REQ-807** (M16 closes the ARP loop structurally; M20 owns the
  XGMII-level observable — SPEC-M16 §10 and §11.4). In each, both specifications
  name their own half **and disclaim the other's**, which is the property that
  lets a sign-off packet show whole coverage with no module claiming another's
  part and no hole between them. **Batch F discharged all three debts and added
  two more rows of the same shape.** REQ-610's second half is now SPEC-M18 §5,
  §6.1 and §10; REQ-807's is SPEC-M20 §8 and §10; REQ-505's M13 side was retiled
  by carry-forward **C-28**, which found that M13's header claimed the
  requirement unqualified and its §10 row disclaimed nothing — the double-claim
  direction of the same defect the pattern exists to prevent. The two new rows
  are **REQ-708** (M19 owns the application-boundary half, M20 the end-to-end
  half) and **REQ-709** (M18 owns the detection and its strobe, M04 the wire
  remedy and `error_underflow`). **No cell in this file now reads `pending`**,
  which was dv_lead's stated condition for the batch-F countersignature
  (WO-0018 Return log §3, answer (iv)).
- **One row is deliberately *not* split, and the distinction is worth keeping.**
  REQ-707 is owned **whole** by M17: M19 and M20 relay the application receive
  stream and change no field of it, so neither claims any part of the
  requirement and both say so in their own §10. A relay is not a half. The test
  of the difference is whether a sign-off packet could show whole coverage
  without the other module's packet — for REQ-610 and REQ-807 it could not, and
  for REQ-707 `SO-udp_ip_rx_64.md` alone can.
- **Test(s)** is derived by dv_lead from the attack plans and benches and
  transcribed here by architect_docs_lead. **The citation atom is
  `<row-id> → <path>:<line>`**, where `<path>:<line>` names the `let%expect_test`
  unit discharging that attack-plan row. **Entries are separated by semicolons**;
  a comma *inside* an entry groups row ids or line numbers sharing one unit, so
  the separator is not the comma the WO-0002 draft of this bullet assumed. Unit
  titles run to several lines and are therefore **not** repeated in the cell —
  the delivering packet's unit register prints them in full, once, and a reader
  checks a cell by reading the row id in the plan, the `file:line` in the suite,
  and the register's title to see they name the same unit. Two entry forms are
  not `file:line`, and both say so in the cell: **`— STRUCTURAL: <what checks
  it>`**, discharged by a compile-time or script check rather than by a waveform,
  named so no reader takes it for a behavioural test; and **`GAP: <reason>`**.
- **Provenance of a filled cell is readable from the cell itself.** Every entry
  carries its module's attack-plan row prefix — `M03-…` for `Xgmii_rx_64` — and
  that prefix names the delivery it was transcribed from: the `M03-` cells are
  **WO-0079**'s, measured by dv_lead at `a851948` and transcribed unchanged.
  A **partial** cell — one module's contribution to a row that module does not
  own whole — additionally opens with that module's prefix and a colon (`M03: …`),
  which is what keeps a partial cell from reading as a whole one. Later modules
  fill their own rows from their own sign-off rounds on this same form; **no cell
  is ever back-filled from another module's packet**.
- **Status** values: `OPEN` (no test yet) · `COVERED` (test exists and passes)
  · `GAP` (declared, with a reason) · `WITHDRAWN` (with the ADR that retired
  the requirement). A REQ covered *only* by a declared gap says `GAP: <reason>`
  and takes `Status` `GAP`. A gap named **inside an otherwise populated cell** is
  a declared hole in that cell and **not** the row's status; either way the gap
  must appear in the owning module's sign-off packet.
- **What `OPEN` means on a row whose cell is populated** — the case a
  multi-owner row reaches first, and the reason there is no `PARTIAL` value.
  `Status` is a claim about **the row's own subject**, not a measure of how much
  evidence its cell holds. That subject is: for a programme invariant, the
  *system-level* test (next bullet); for a row owned by several modules, the
  whole requirement; for a process row, the programme's own discharge, which no
  module closes — pointing one at a module's evidence would be the same false
  claim of coverage this file already refuses in the Spec-section column. **A
  single module's bench can make none of those three claims, however much it puts
  in the cell.** Such a row therefore reads `OPEN` beside a populated,
  module-prefixed cell, and that is not a contradiction: it records that the
  module-side contributions exist and that the row's own test does not, yet.
  **Ruled at WO-0079 rather than answered with a new `Status` value**: a
  `PARTIAL` would have to define when it becomes `COVERED`, which is precisely
  the split `Open dependencies` item 3 defers to the first module-ready gate, so
  minting the value now would freeze half that decision into the vocabulary
  before the gate meets it. The **21** rows the rule currently governs are the M03
  slice's programme-invariant and owned-elsewhere rows; should the gate later want
  `PARTIAL`, they are its candidate set.
- Programme invariants (REQ-001 … REQ-021) are owned by every module; their
  row records the *system-level* test, and each module spec restates the
  invariant in its own REQ-coverage table (SPEC-TEMPLATE §3, §10).

## Counts

| Block | REQs | Range |
|---|---|---|
| Programme invariants | 21 | REQ-001 … REQ-021 |
| XGMII receive | 13 | REQ-101 … REQ-113 |
| XGMII transmit | 10 | REQ-201 … REQ-210 |
| CRC-32 / FCS | 6 | REQ-301 … REQ-306 |
| Ethernet framing | 10 | REQ-401 … REQ-410 |
| ARP | 12 | REQ-501 … REQ-512 |
| IPv4 | 12 | REQ-601 … REQ-612 |
| UDP | 10 | REQ-701 … REQ-710 |
| Top level and configuration | 10 | REQ-801 … REQ-810 |
| Verification and process | 6 | REQ-901 … REQ-906 |
| **Total** | **110** | |

Two requirements were added at WO-0004: **REQ-710** (over-delivery of a declared
transmit length, split out of REQ-709 per diff D-15, because a frame already
terminated on the wire cannot take REQ-206's remedy) and **REQ-810** (behaviour
of `receive enable` and `transmit enable`, per diff D-12, which required the two
fields to gain a behavioural requirement or be deleted). No REQ was renumbered
or withdrawn; ids remain permanent.

---

## Matrix

| REQ | Kind | Requirement (short) | Owning module(s) | Spec section | Test(s) | Status |
|---|---|---|---|---|---|---|
| REQ-001 | INV | Single clock domain | all modules (programme invariant) | SPEC-M20 §3, §6.1 | | OPEN |
| REQ-002 | IFC | Datapath width | all modules (programme invariant) | SPEC-M01 §4.1, §5 | | OPEN |
| REQ-003 | INV | No receive-path backpressure | all modules (programme invariant) | SPEC-M01 §4.2; SPEC-M03 §4.1 | M03: M03-L6, M03-O1 — STRUCTURAL: interface compile check — the output carries `Axi64.Source` with no `Dest` and the input carries no `tready` (SPEC-M03 §4.1) | OPEN |
| REQ-004 | PERF | Line-rate invariant | all modules (programme invariant) | SPEC-M03 §8 | M03: M03-L1 → test/xgmii_rx_64/test_m03_l.ml:258 (10 000 consecutive 64-octet frames, start lanes alternating, minimum spacing) | OPEN |
| REQ-005 | INV | Cut-through, not store-and-forward | all modules (programme invariant) | SPEC-M03 §7 | M03: M03-L2 → test/xgmii_rx_64/test_m03_l.ml:258; M03-L5 → test/xgmii_rx_64/test_m03_l.ml:361 | OPEN |
| REQ-006 | PERF | Receive latency budget | all modules (programme invariant) | SPEC-M20 §7 (the derivation: 13 cycles at both start lanes), §8 check 4 | | OPEN |
| REQ-007 | INV | Abort propagation | all modules (programme invariant) | SPEC-M03 §9 | M03: M03-D1 → test/xgmii_rx_64/test_m03_d.ml:176; M03-E1 → test/xgmii_rx_64/test_m03_e.ml:353; M03-F1 → test/xgmii_rx_64/test_m03_f.ml:304; M03-G1 → test/xgmii_rx_64/test_m03_g.ml:534; M03-H1 → test/xgmii_rx_64/test_m03_h.ml:378; the zero-delivered cases, where the abort bit has no word to ride on — M03-B2 → test/xgmii_rx_64/test_m03_b.ml:1089, :1331, :1343; M03-B4 → test/xgmii_rx_64/test_m03_b.ml:459, :717; M03-F2 → test/xgmii_rx_64/test_m03_f.ml:492 | OPEN |
| REQ-008 | ERR | Every discard is observable | all modules (programme invariant) | SPEC-M03 §9; SPEC-M04 §9 | M03: M03-B2 → test/xgmii_rx_64/test_m03_b.ml:1089, :1331, :1343; M03-B3 → test/xgmii_rx_64/test_m03_b.ml:907; M03-B4 → test/xgmii_rx_64/test_m03_b.ml:459, :717; M03-E2 → test/xgmii_rx_64/test_m03_e.ml:490; M03-F2 → test/xgmii_rx_64/test_m03_f.ml:492; M03-G6 → test/xgmii_rx_64/test_m03_g.ml:1186; M03-H4 → test/xgmii_rx_64/test_m03_h.ml:1047; plus the frame-conservation monitor standing on every M03 bench (AP-M03 §2 obligation 2) | OPEN |
| REQ-009 | INV | Reset behaviour | all modules (programme invariant) | SPEC-M03 §7; SPEC-M04 §7 | M03: M03-K1 → test/xgmii_rx_64/test_m03_k.ml:371; M03-K2 → test/xgmii_rx_64/test_m03_k.ml:688 | OPEN |
| REQ-010 | IFC | Typed stream fabric | all modules (programme invariant) | SPEC-M01 §4.1, §6.1 | | OPEN |
| REQ-011 | IFC | tkeep semantics | all modules (programme invariant) | SPEC-M01 §6.1 | M03: M03-C1 → test/xgmii_rx_64/test_m03_c.ml:338; M03-C3 → test/xgmii_rx_64/test_m03_c.ml:467; M03-C4 → test/xgmii_rx_64/test_m03_c.ml:556; M03-C5 → test/xgmii_rx_64/test_m03_c.ml:408; plus the protocol monitor standing on every M03 bench with `~max_words_per_frame:190` (AP-M03 §2 obligation 1) | OPEN |
| REQ-012 | IFC | Byte and field order | all modules (programme invariant) | SPEC-M01 §6.1 | M03: M03-A5 → test/xgmii_rx_64/test_m03_a.ml:203 | OPEN |
| REQ-013 | IFC | tuser semantics | all modules (programme invariant) | SPEC-M01 §6.1 | | OPEN |
| REQ-014 | IFC | tstrb unused | all modules (programme invariant) | SPEC-M01 §6.1 | M03: producer half — the protocol monitor standing on every M03 bench asserts `tstrb` driven 0 on every output word (AP-M03 §2 obligation 1). GAP: REQ-014's differential run has no instance at M03 — the verification column commissions the same stimulus at `tstrb` = 0x00 and 0xFF, and M03's input is an XGMII lane pair, which has no `tstrb` to vary (SPEC-M03 §10 REQ-014 hook; AP-M03 M03-O2); the consumer half is M06's | OPEN |
| REQ-015 | IFC | One frame at a time | all modules (programme invariant) | SPEC-M01 §6.1; SPEC-M03 §7 | M03: M03-C3 → test/xgmii_rx_64/test_m03_c.ml:467; M03-C4 → test/xgmii_rx_64/test_m03_c.ml:556; plus the protocol monitor's one-`tlast`-per-frame and 190-word rules on every M03 bench (AP-M03 §2 obligation 1) | OPEN |
| REQ-016 | IFC | Idle words permitted | all modules (programme invariant) | SPEC-M01 §6.1; SPEC-M04 §7 | M03: M03-I4 → test/xgmii_rx_64/test_m03_i.ml:1781; M03-I6 → test/xgmii_rx_64/test_m03_i.ml:2106 | OPEN |
| REQ-017 | INV | XGMII closure | all modules (programme invariant) | SPEC-M01 §4.1, §4.2; SPEC-M05 §4.2 | M03: M03-O3 — STRUCTURAL: the emitted-Verilog port names `xgmii_rxd` / `xgmii_rxc`, checked by `tools/check_emitted_verilog.sh` (run from `tools/dv_checks.sh`, CI `build` step 9) | OPEN |
| REQ-018 | INV | XGMII boundary is simulation-only | all modules (programme invariant) | SPEC-M03 §2; SPEC-M05 §3 | M03: M03-O3 — STRUCTURAL: the emitted-module whitelist, `tools/check_emitted_verilog.sh` (run from `tools/dv_checks.sh`, CI `build` step 9) | OPEN |
| REQ-019 | INV | Bounded receive latency, no deep buffering | all modules (programme invariant) | SPEC-M03 §7; SPEC-M05 §7 | M03: M03-L3 → test/xgmii_rx_64/test_m03_l.ml:258 (ΔC = 3 against the §1.1 ceiling of 4) | OPEN |
| REQ-020 | FUNC | Order preservation | all modules (programme invariant) | SPEC-M20 §3, §8 check 2 | M03: M03-L4 → test/xgmii_rx_64/test_m03_l.ml:258 | OPEN |
| REQ-021 | IFC | Producer-side word alignment | all modules (programme invariant) | SPEC-M01 §6.1; SPEC-M03 §6.1 | M03: M03-A2 → test/xgmii_rx_64/test_m03_a.ml:80; M03-A5 → test/xgmii_rx_64/test_m03_a.ml:203; M03-H2 → test/xgmii_rx_64/test_m03_h.ml:808 | OPEN |
| REQ-101 | FUNC | Start lanes | M03 `Xgmii_rx_64` | SPEC-M03 §6.1 | M03-A1, M03-A2 → test/xgmii_rx_64/test_m03_a.ml:80; M03-A3 → test/xgmii_rx_64/test_m03_a.ml:153 | COVERED |
| REQ-102 | FUNC | Preamble handling | M03 `Xgmii_rx_64` | SPEC-M03 §6.1 | M03-B1 → test/xgmii_rx_64/test_m03_b.ml:93; M03-B2 → test/xgmii_rx_64/test_m03_b.ml:1089, :1331, :1343; M03-B3 → test/xgmii_rx_64/test_m03_b.ml:907; M03-B4 → test/xgmii_rx_64/test_m03_b.ml:459, :717; M03-N2 → test/xgmii_rx_64/test_m03_n.ml:698, :708, :718, :728, :739, :749 | COVERED |
| REQ-103 | FUNC | Frame extraction | M03 `Xgmii_rx_64` | SPEC-M03 §6.1 | M03-C1 → test/xgmii_rx_64/test_m03_c.ml:338; M03-C3 → test/xgmii_rx_64/test_m03_c.ml:467; M03-C5 → test/xgmii_rx_64/test_m03_c.ml:408; M03-E1 → test/xgmii_rx_64/test_m03_e.ml:353; M03-F1 → test/xgmii_rx_64/test_m03_f.ml:304; M03-G1 → test/xgmii_rx_64/test_m03_g.ml:534; M03-H1 → test/xgmii_rx_64/test_m03_h.ml:378 | COVERED |
| REQ-104 | ERR | FCS check | M03 `Xgmii_rx_64` | SPEC-M03 §6.1, §9 | M03-D1 → test/xgmii_rx_64/test_m03_d.ml:176; M03-D2 → test/xgmii_rx_64/test_m03_d.ml:414; M03-D3 → test/xgmii_rx_64/test_m03_d.ml:468; M03-M2 → test/xgmii_rx_64/test_m03_g.ml:534; M03-M3 → test/xgmii_rx_64/test_m03_e.ml:353; M03-M4 → test/xgmii_rx_64/test_m03_h.ml:378; M03-M10 → test/xgmii_rx_64/test_m03_f.ml:492, test/xgmii_rx_64/test_m03_b.ml:907 | COVERED |
| REQ-105 | ERR | Error character inside a frame | M03 `Xgmii_rx_64` | SPEC-M03 §9 | M03-B2 → test/xgmii_rx_64/test_m03_b.ml:1089, :1331, :1343; M03-E1 → test/xgmii_rx_64/test_m03_e.ml:353; M03-E2 → test/xgmii_rx_64/test_m03_e.ml:490; M03-E4 → test/xgmii_rx_64/test_m03_e.ml:609; M03-E5 → test/xgmii_rx_64/test_m03_e.ml:799; M03-G4 → test/xgmii_rx_64/test_m03_g.ml:1003; M03-G8 → test/xgmii_rx_64/test_m03_g.ml:1696; M03-M5 → test/xgmii_rx_64/test_m03_h.ml:609; M03-M7 → test/xgmii_rx_64/test_m03_g.ml:1003, :1696; M03-N1 → test/xgmii_rx_64/test_m03_n.ml:959 | COVERED |
| REQ-106 | FUNC | Terminate in any lane | M03 `Xgmii_rx_64` | SPEC-M03 §6.1 | M03-C1, M03-C2 → test/xgmii_rx_64/test_m03_c.ml:338 | COVERED |
| REQ-107 | ERR | Runt frames | M03 `Xgmii_rx_64` | SPEC-M03 §9 | M03-B3 → test/xgmii_rx_64/test_m03_b.ml:907; M03-F1 → test/xgmii_rx_64/test_m03_f.ml:304; M03-F2 → test/xgmii_rx_64/test_m03_f.ml:492; M03-F3 → test/xgmii_rx_64/test_m03_f.ml:653; M03-F4 → test/xgmii_rx_64/test_m03_f.ml:801; M03-F5 → discharged by citation to M03-C4 (test/xgmii_rx_64/test_m03_c.ml:556) and M03-F1's 5-octet member, recorded at test/xgmii_rx_64/test_m03_f.ml:811; M03-M1 → test/xgmii_rx_64/test_m03_f.ml:304, :653; M03-M10 → test/xgmii_rx_64/test_m03_f.ml:492, test/xgmii_rx_64/test_m03_b.ml:907 | COVERED |
| REQ-108 | ERR | Oversize frames | M03 `Xgmii_rx_64` | SPEC-M03 §6.2, §9 | M03-G1 → test/xgmii_rx_64/test_m03_g.ml:534; M03-G2 → test/xgmii_rx_64/test_m03_g.ml:684; M03-G3 → test/xgmii_rx_64/test_m03_g.ml:834; M03-G4 → test/xgmii_rx_64/test_m03_g.ml:1003; M03-G6 → test/xgmii_rx_64/test_m03_g.ml:1186; M03-G7 → test/xgmii_rx_64/test_m03_g.ml:1490; M03-G8 → test/xgmii_rx_64/test_m03_g.ml:1696; M03-M2 → test/xgmii_rx_64/test_m03_g.ml:534; M03-M6 → test/xgmii_rx_64/test_m03_g.ml:834, :1490; M03-M7 → test/xgmii_rx_64/test_m03_g.ml:1003, :1696 | COVERED |
| REQ-109 | FUNC | Idle between frames | M03 `Xgmii_rx_64` | SPEC-M03 §6.1 | M03-I1 → test/xgmii_rx_64/test_m03_i.ml:397; M03-I2 → test/xgmii_rx_64/test_m03_i.ml:977 | COVERED |
| REQ-110 | ERR | Start without terminate | M03 `Xgmii_rx_64` | SPEC-M03 §9 | M03-B4 → test/xgmii_rx_64/test_m03_b.ml:459, :717; M03-G3 → test/xgmii_rx_64/test_m03_g.ml:834; M03-G7 → test/xgmii_rx_64/test_m03_g.ml:1490; M03-H1 → test/xgmii_rx_64/test_m03_h.ml:378; M03-H2 → test/xgmii_rx_64/test_m03_h.ml:808; M03-H3 → test/xgmii_rx_64/test_m03_h.ml:609; M03-H4 → test/xgmii_rx_64/test_m03_h.ml:1047; M03-M4 → test/xgmii_rx_64/test_m03_h.ml:378; M03-M5 → test/xgmii_rx_64/test_m03_h.ml:609; M03-M6 → test/xgmii_rx_64/test_m03_g.ml:834, :1490; M03-N2 → test/xgmii_rx_64/test_m03_n.ml:698, :708, :718, :728, :739, :749; M03-N4 → test/xgmii_rx_64/test_m03_n.ml:1450 | COVERED |
| REQ-111 | PERF | Constant receive latency | M03 `Xgmii_rx_64` | SPEC-M03 §7 | M03-L2 → test/xgmii_rx_64/test_m03_l.ml:258; M03-L5 → test/xgmii_rx_64/test_m03_l.ml:361 | COVERED |
| REQ-112 | INV | No stall | M03 `Xgmii_rx_64` | SPEC-M03 §4.1 | M03-L1 → test/xgmii_rx_64/test_m03_l.ml:258; M03-L6 → STRUCTURAL: no `tready` input exists on the stream under test (SPEC-M03 §4.1, interface compile check) | COVERED |
| REQ-113 | FUNC | Ordered sets ignored | M03 `Xgmii_rx_64` | SPEC-M03 §6.1 | M03-E4 → test/xgmii_rx_64/test_m03_e.ml:609; M03-I3 → test/xgmii_rx_64/test_m03_i.ml:1266 | COVERED |
| REQ-201 | FUNC | Preamble and start lane | M04 `Xgmii_tx_64` | SPEC-M04 §6.1 | | OPEN |
| REQ-202 | FUNC | FCS generation | M04 `Xgmii_tx_64` | SPEC-M04 §6.1 | | OPEN |
| REQ-203 | FUNC | Padding | M04 `Xgmii_tx_64` | SPEC-M04 §6.1 | | OPEN |
| REQ-204 | FUNC | Inter-frame gap | M04 `Xgmii_tx_64` | SPEC-M04 §6.1 | | OPEN |
| REQ-205 | FUNC | Terminate and fill | M04 `Xgmii_tx_64` | SPEC-M04 §6.1 | | OPEN |
| REQ-206 | ERR | Underflow | M04 `Xgmii_tx_64` | SPEC-M04 §9 | | OPEN |
| REQ-207 | IFC | Transmit-side backpressure | M04 `Xgmii_tx_64` | SPEC-M04 §6.1, §7 | | OPEN |
| REQ-208 | INV | Backpressure containment | M04 `Xgmii_tx_64` | SPEC-M04 §3; SPEC-M05 §6.1 | | OPEN |
| REQ-209 | PERF | Transmit throughput | M04 `Xgmii_tx_64` | SPEC-M04 §7 | | OPEN |
| REQ-210 | PERF | Constant transmit latency | M04 `Xgmii_tx_64` | SPEC-M04 §7 | | OPEN |
| REQ-301 | FUNC | Algorithm | M02 `Crc32_eth` | SPEC-M02 §6.1 | | OPEN |
| REQ-302 | FUNC | Parallel update | M02 `Crc32_eth` | SPEC-M02 §6.1 | | OPEN |
| REQ-303 | FUNC | Check value | M02 `Crc32_eth` | SPEC-M02 §6.1 | | OPEN |
| REQ-304 | FUNC | Residue property | M02 `Crc32_eth` | SPEC-M02 §6.1 | | OPEN |
| REQ-305 | FUNC | Reference equivalence | M02 `Crc32_eth` | SPEC-M02 §6.1 | | OPEN |
| REQ-306 | IFC | Stateless function | M02 `Crc32_eth` | SPEC-M02 §4.1, §6.2 | | OPEN |
| REQ-401 | FUNC | Header extraction | M06 `Eth_axis_rx` | SPEC-M06 §6.1, §7 | | OPEN |
| REQ-402 | ERR | Short frames | M06 `Eth_axis_rx` | SPEC-M06 §9 | | OPEN |
| REQ-403 | ERR | Abort passthrough | M06 `Eth_axis_rx` | SPEC-M06 §9 | | OPEN |
| REQ-404 | FUNC | Ethertype demultiplex | M08 `Eth_demux` | SPEC-M08 §6.1, §9 | | OPEN |
| REQ-405 | FUNC | Header insertion | M07 `Eth_axis_tx` | SPEC-M07 §6.1 | | OPEN |
| REQ-406 | FUNC | Frame-atomic arbitration | M09 `Eth_arb_mux` | SPEC-M09 §6.1, §6.2, §6.3 | | OPEN |
| REQ-407 | FUNC | No Ethernet-layer address filtering | M06 `Eth_axis_rx` | SPEC-M06 §2, §4.3 | | OPEN |
| REQ-408 | FUNC | Payload extent | M06 `Eth_axis_rx` | SPEC-M06 §6.1, §8 | | OPEN |
| REQ-409 | IFC | Field decoding | M06 `Eth_axis_rx`, M07 `Eth_axis_tx` | SPEC-M06 §6.1; SPEC-M07 §6.1 | | OPEN |
| REQ-410 | PERF | Back-to-back frames | M06 `Eth_axis_rx` | SPEC-M06 §6.1, §6.2 | | OPEN |
| REQ-501 | FUNC | Packet acceptance | M10 `Arp_eth_rx` | SPEC-M10 §6.1, §9 | | OPEN |
| REQ-502 | FUNC | Request response | M13 `Arp`, M11 `Arp_eth_tx` | SPEC-M13 §6.1, §7; SPEC-M11 §6.1 | | OPEN |
| REQ-503 | FUNC | Learning | M13 `Arp`, M12 `Arp_cache` | SPEC-M13 §6.1, §6.2 (D) (the validity gate, ADR-0009); SPEC-M12 §6.1 | | OPEN |
| REQ-504 | FUNC | Cache organisation | M12 `Arp_cache` | SPEC-M12 §6.1 | | OPEN |
| REQ-505 | ERR | Lookup miss | M13 `Arp`, M15 `Ip_eth_tx_64` | SPEC-M13 §6.1, §9 (the strobe and the request); SPEC-M15 §6.1, §6.2 (the discard and the drain) | | OPEN |
| REQ-506 | FUNC | Retry and ageing | M12 `Arp_cache`, M13 `Arp` | SPEC-M12 §5, §6.1 (ageing); SPEC-M13 §5, §6.2 (retry) | | OPEN |
| REQ-507 | FUNC | Destination class precedence and off-subnet routing | M13 `Arp` | SPEC-M13 §6.1 | | OPEN |
| REQ-508 | FUNC | Broadcast destinations | M13 `Arp` | SPEC-M13 §6.1 | | OPEN |
| REQ-509 | FUNC | Multicast destinations | M13 `Arp` | SPEC-M13 §6.1 | | OPEN |
| REQ-510 | ERR | Reply drop over stall | M13 `Arp` | SPEC-M13 §6.1, §6.2 (A), §9 | | OPEN |
| REQ-511 | FUNC | Gratuitous ARP | M13 `Arp` | SPEC-M13 §6.1 | | OPEN |
| REQ-512 | FUNC | No proxy ARP | M13 `Arp` | SPEC-M13 §6.1 | | OPEN |
| REQ-601 | ERR | Version and header length | M14 `Ip_eth_rx_64` | SPEC-M14 §6.1, §9 | | OPEN |
| REQ-602 | ERR | Header checksum | M14 `Ip_eth_rx_64` | SPEC-M14 §6.1, §9 | | OPEN |
| REQ-603 | ERR | Fragments | M14 `Ip_eth_rx_64` | SPEC-M14 §6.1, §6.3 item 4, §9 | | OPEN |
| REQ-604 | FUNC | Destination filter | M14 `Ip_eth_rx_64` | SPEC-M14 §4.3, §6.1, §9 | | OPEN |
| REQ-605 | FUNC | Length handling | M14 `Ip_eth_rx_64` | SPEC-M14 §6.1, §6.2, §9 | | OPEN |
| REQ-606 | FUNC | Header record | M14 `Ip_eth_rx_64` | SPEC-M14 §6.1, §7 | | OPEN |
| REQ-607 | ERR | Protocol filter | M14 `Ip_eth_rx_64` | SPEC-M14 §6.1, §9 | | OPEN |
| REQ-608 | FUNC | Header construction | M15 `Ip_eth_tx_64` | SPEC-M15 §6.1 | | OPEN |
| REQ-609 | FUNC | Transmit checksum | M15 `Ip_eth_tx_64` | SPEC-M15 §6.1 | | OPEN |
| REQ-610 | FUNC | Transmit length | M15 `Ip_eth_tx_64`, M18 `Udp_ip_tx_64` | SPEC-M15 §5, §6.1, §7 (the IPv4 total length emitted into octets 2–3, no buffering at that port); SPEC-M18 §5, §6.1, §10 (the application payload length, the "+ 28" and "+ 8" arithmetic, the UDP length field) | | OPEN |
| REQ-611 | PERF | Constant parse latency | M14 `Ip_eth_rx_64` | SPEC-M14 §7 | | OPEN |
| REQ-612 | ERR | Maximum size | M14 `Ip_eth_rx_64` | SPEC-M14 §6.1, §9 | | OPEN |
| REQ-701 | FUNC | Header record | M17 `Udp_ip_rx_64` | SPEC-M17 §6.1, §7 | | OPEN |
| REQ-702 | FUNC | Checksum not verified | M17 `Udp_ip_rx_64` | SPEC-M17 §6.1, §6.3 item 3 | | OPEN |
| REQ-703 | ERR | Length checks | M17 `Udp_ip_rx_64` | SPEC-M17 §6.1, §6.2, §9 | | OPEN |
| REQ-704 | FUNC | Port filter | M17 `Udp_ip_rx_64` | SPEC-M17 §4.3, §6.1, §9 | | OPEN |
| REQ-705 | IFC | Transmit request form | M18 `Udp_ip_tx_64` | SPEC-M18 §4.1, §6.1, §7 | | OPEN |
| REQ-706 | FUNC | Transmit checksum zero | M18 `Udp_ip_tx_64` | SPEC-M18 §6.1 | | OPEN |
| REQ-707 | IFC | Application receive stream | M17 `Udp_ip_rx_64` | SPEC-M17 §4.1, §5, §6.1 — owned **whole** by M17; M19 and M20 relay the stream and claim no part of it (SPEC-M19 §10, SPEC-M20 §4.2), which is why this is a one-owner row and not a two-half one | | OPEN |
| REQ-708 | PERF | Application-boundary line rate | M19 `Udp_complete_64`, M20 `Nic_top` | SPEC-M19 §8 item 1, §10 (the application-boundary half: 10 000 datagrams measured at `app_rx_*`); SPEC-M20 §8, §10 (the end-to-end half: the same payloads driven at XGMII at REQ-004's alternating 10-and-11-cycle spacing) | | OPEN |
| REQ-709 | ERR | Under-delivery of a declared length | M18 `Udp_ip_tx_64`, M04 `Xgmii_tx_64` | SPEC-M18 §6.2 (`Short`), §9 (the detection and `error_tx_length_mismatch`); SPEC-M04 §9 (the `/E/` + `/T/` remedy and `error_underflow`); **ADR-0011** (what the transmit path is left holding, and that `clear` recovers it) | | OPEN |
| REQ-710 | ERR | Over-delivery of a declared length | M18 `Udp_ip_tx_64` | SPEC-M18 §6.2 (`Excess`), §9 | | OPEN |
| REQ-801 | IFC | Top-level ports | M20 `Nic_top` | SPEC-M20 §4.1, §4.2 | | OPEN |
| REQ-802 | IFC | Configuration record | M20 `Nic_top` | SPEC-M01 §4.1, §4.2 (the record); SPEC-M20 §4.1, §4.3 (its only port, and the decomposition) | M03 (the `cfg_rx_enable` sampling half): M03-J1 → test/xgmii_rx_64/test_m03_j.ml:259; M03-J2 → test/xgmii_rx_64/test_m03_j.ml:365; M03-J3 → test/xgmii_rx_64/test_m03_j.ml:574; M03-N4 → test/xgmii_rx_64/test_m03_n.ml:1450 | OPEN |
| REQ-803 | IFC | Configuration stability | M20 `Nic_top` | SPEC-M20 §4.3 (M20 holds no configuration register, so every reader sees a change on the same cycle); the per-reader sampling rules are SPEC-M03 §4.3, SPEC-M04 §4.3, SPEC-M13 §4.3, SPEC-M14 §4.3, SPEC-M15 §4.3, SPEC-M17 §4.3, SPEC-M18 §4.3 | | OPEN |
| REQ-804 | ERR | Status aggregation | M20 `Nic_top` | SPEC-M01 §4.1, §4.2 (the record); SPEC-M20 §6.1, §9 (six from M05 plus fifteen from M19 = twenty-one, a rename and not a reduction) | | OPEN |
| REQ-805 | INV | Application must keep up | M20 `Nic_top`, M17 `Udp_ip_rx_64` | SPEC-M17 §4.1 (the producer's type, where the absence of `tready` originates); SPEC-M20 §4.1, §11.4 (the top-level port; the second sentence binds Phase 2 and has no Phase-1 observable) | | OPEN |
| REQ-806 | PERF | End-to-end latency measurement | M20 `Nic_top` | SPEC-M20 §7, §8 check 5, §12's fifth row, §11.2 | | OPEN |
| REQ-807 | FUNC | ARP connectivity | M20 `Nic_top`, M16 `Ip_complete_64` | SPEC-M16 §6.1, §8, §10 (the loop, closed structurally); SPEC-M20 §8, §10 (the XGMII-level observable: preamble, every ARP field, FCS, gap, and the REQ-502 interval measured from the terminate character) | | OPEN |
| REQ-808 | PROC | Hierarchy and naming | M20 `Nic_top` | SPEC-M05 §4.1, §6.1; SPEC-M20 §4.1, §6.1, §10 (the root the module-name comparison walks) | M03: M03-O3 — STRUCTURAL: `.mli`, `create` and `hierarchical` present, and the module name appears in `rtl_snapshots/`; `tools/check_emitted_verilog.sh` (run from `tools/dv_checks.sh`, CI `build` step 9) | OPEN |
| REQ-809 | FUNC | End-to-end datagram path | M20 `Nic_top` | SPEC-M20 §8, §10 | | OPEN |
| REQ-810 | FUNC | Enable controls | M20 `Nic_top`, M03 `Xgmii_rx_64`, M04 `Xgmii_tx_64`, M18 `Udp_ip_tx_64` | SPEC-M20 §4.3, §6.1 (the configuration source, and the one field with two readers); SPEC-M03 §4.3 (the receive half); SPEC-M04 §4.3 (the XGMII transmit half); SPEC-M18 §4.3, §6.1 (the application-interface `tready` half); SPEC-M13 §11.2 (the ARP clause, which needs no enable) | M03 (the receive half): M03-J1 → test/xgmii_rx_64/test_m03_j.ml:259; M03-J2 → test/xgmii_rx_64/test_m03_j.ml:365; M03-J3 → test/xgmii_rx_64/test_m03_j.ml:574; M03-N4 → test/xgmii_rx_64/test_m03_n.ml:1450 | OPEN |
| REQ-901 | PROC | Differential co-simulation | programme (process) | requirements.md REQ-901 (the declared divergence classes, lettered and appended-to, never renumbered); their module homes are SPEC-M14 header/§11.3 (a), SPEC-M12 §5 with SPEC-M13 §6.1 (b), SPEC-M15 header/§10 (c), SPEC-M18 header/§10 (d) and SPEC-M03 header/§10 (e), (f) | M03: no behavioural row, and none is owed — REQ-901 is a process obligation on the differential co-simulation lane, not a property of M03's ports. The lane's producer is `test/cosim/` (`stimulus_gen.ml`, `ours_run.ml`, `compare.ml`, `tb_xgmii_rx_64.v`), run as CI job `cosim`; its five **stimulus classes** and their per-class `build` / `cosim` run ids are listed in SO-xgmii_rx_64.md §2.3 and §2.3-M. Declared divergence classes (e) and (f) are homed at this module | OPEN |
| REQ-902 | PROC | Deterministic emission | programme (process) | **no module spec pins it, by design** — it is a property of the build, fixed by the CI `build` workflow's determinism step and ADR-0005 | | OPEN |
| REQ-903 | PROC | Module surface | programme (process) | SPEC-M01 §10; SPEC-M02 §4.1; SPEC-M03 §4.1 | M03: M03-O3 — STRUCTURAL: `xgmii_rx_64` is a distinct emitted module with `create`, `hierarchical` and an `.mli`; repository-surface check plus the `rtl_snapshots/` name comparison, `tools/check_emitted_verilog.sh` (run from `tools/dv_checks.sh`, CI `build` step 9) | OPEN |
| REQ-904 | PROC | Traceability currency | programme (process) | **this file**, plus the CI set-equality script requirements.md REQ-904's verification column commissions | | OPEN |
| REQ-905 | PROC | Per-module stress | programme (process) | SPEC-M03 §8 | | OPEN |
| REQ-906 | PROC | Evidence form | programme (process) | **no module spec pins it, by design** — ADR-0005 fixes it and every module spec's §12 `Interface compile check` row is an instance of it | | OPEN |

---

## Open dependencies

1. **Test column**: no longer empty, and no longer wholly filled either. It was
   empty by design at WO-0002 return; the **first module slice landed at
   WO-0079** — the 34 rows SPEC-M03 §10 hooks, delivered by dv_lead as `Test(s)`
   and `Status` cells and transcribed here. **76 rows remain empty**, each
   awaiting its own module's sign-off round on the same form; that count is the
   live measure of how much of this column is owed. dv_lead derives the cells
   from the attack plans and benches (dv_lead charter §3).
2. **Spec section**: filled batch by batch as the twenty module specifications
   land (architecture.md §8).
3. **System-level rows**: REQ-001 … REQ-021 and REQ-801 … REQ-810 are expected
   to be covered by `nic_top` system tests plus per-module restatements; the
   architect and dv_lead agree the split at the first module-ready gate.
   **WO-0079 is this item's first occasion**: M03's half of the split is now on
   the record per row — 16 programme-invariant rows and REQ-802, REQ-808,
   REQ-810 carry an `M03:`-prefixed cell and stay `OPEN` — so the gate ratifies a
   measured thing rather than negotiating one. The rows' `nic_top` half is
   M20's to deliver and none of these cells claims it. **Two of the 21 rows sit
   outside this item's ranges** — REQ-901 and REQ-903 are process rows, not
   system-level ones — and they hold `OPEN` on the process-row ground stated in
   the `Status` bullets above, not on this item's.
4. **Partial coverage declared in advance (REQ-019)**: REQ-019's first sentence
   — the per-module latency ceiling of requirements.md §1.1 — is DV-verifiable
   and is what the row's test column must eventually name. Its second sentence
   ("no payload storage deeper than two datapath words") is explicitly design
   guidance with no port-visible symptom, and requirements.md says so; this row
   therefore reaches `COVERED` on the ceiling alone, and no sign-off packet may
   read it as evidence about buffer depth.
