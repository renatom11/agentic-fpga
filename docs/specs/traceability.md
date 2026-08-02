# Phase-1 traceability matrix — REQ to specification to test

- **Status**: DRAFT skeleton — test column pending dv_lead
- **Owner**: architect_docs_lead (matrix file) · **Work orders**: WO-0002
  (original), WO-0004 (rows added and retitled for the D-1 … D-16 spec diffs)
- **Test column owner**: dv_lead (charter §4: DV supplies the test-side rows)
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
  specs. Batches C–F follow the same rule — matrix and spec in one commit
  (SPEC-TEMPLATE §10).
- **Test(s)** is filled by dv_lead with the test name and file, in the same
  commit as the test. Multiple tests per REQ are listed comma separated. A REQ
  covered only by a declared gap says `GAP: <reason>` and that gap must appear
  in the module's sign-off packet.
- **Status** values: `OPEN` (no test yet) · `COVERED` (test exists and passes)
  · `GAP` (declared, with a reason) · `WITHDRAWN` (with the ADR that retired
  the requirement).
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
| REQ-001 | INV | Single clock domain | all modules (programme invariant) | pending | | OPEN |
| REQ-002 | IFC | Datapath width | all modules (programme invariant) | SPEC-M01 §4.1, §5 | | OPEN |
| REQ-003 | INV | No receive-path backpressure | all modules (programme invariant) | SPEC-M01 §4.2; SPEC-M03 §4.1 | | OPEN |
| REQ-004 | PERF | Line-rate invariant | all modules (programme invariant) | SPEC-M03 §8 | | OPEN |
| REQ-005 | INV | Cut-through, not store-and-forward | all modules (programme invariant) | SPEC-M03 §7 | | OPEN |
| REQ-006 | PERF | Receive latency budget | all modules (programme invariant) | pending | | OPEN |
| REQ-007 | INV | Abort propagation | all modules (programme invariant) | SPEC-M03 §9 | | OPEN |
| REQ-008 | ERR | Every discard is observable | all modules (programme invariant) | SPEC-M03 §9; SPEC-M04 §9 | | OPEN |
| REQ-009 | INV | Reset behaviour | all modules (programme invariant) | SPEC-M03 §7; SPEC-M04 §7 | | OPEN |
| REQ-010 | IFC | Typed stream fabric | all modules (programme invariant) | SPEC-M01 §4.1, §6.1 | | OPEN |
| REQ-011 | IFC | tkeep semantics | all modules (programme invariant) | SPEC-M01 §6.1 | | OPEN |
| REQ-012 | IFC | Byte and field order | all modules (programme invariant) | SPEC-M01 §6.1 | | OPEN |
| REQ-013 | IFC | tuser semantics | all modules (programme invariant) | SPEC-M01 §6.1 | | OPEN |
| REQ-014 | IFC | tstrb unused | all modules (programme invariant) | SPEC-M01 §6.1 | | OPEN |
| REQ-015 | IFC | One frame at a time | all modules (programme invariant) | SPEC-M01 §6.1; SPEC-M03 §7 | | OPEN |
| REQ-016 | IFC | Idle words permitted | all modules (programme invariant) | SPEC-M01 §6.1; SPEC-M04 §7 | | OPEN |
| REQ-017 | INV | XGMII closure | all modules (programme invariant) | SPEC-M01 §4.1, §4.2; SPEC-M05 §4.2 | | OPEN |
| REQ-018 | INV | XGMII boundary is simulation-only | all modules (programme invariant) | SPEC-M03 §2; SPEC-M05 §3 | | OPEN |
| REQ-019 | INV | Bounded receive latency, no deep buffering | all modules (programme invariant) | SPEC-M03 §7; SPEC-M05 §7 | | OPEN |
| REQ-020 | FUNC | Order preservation | all modules (programme invariant) | pending | | OPEN |
| REQ-021 | IFC | Producer-side word alignment | all modules (programme invariant) | SPEC-M01 §6.1; SPEC-M03 §6.1 | | OPEN |
| REQ-101 | FUNC | Start lanes | M03 `Xgmii_rx_64` | SPEC-M03 §6.1 | | OPEN |
| REQ-102 | FUNC | Preamble handling | M03 `Xgmii_rx_64` | SPEC-M03 §6.1 | | OPEN |
| REQ-103 | FUNC | Frame extraction | M03 `Xgmii_rx_64` | SPEC-M03 §6.1 | | OPEN |
| REQ-104 | ERR | FCS check | M03 `Xgmii_rx_64` | SPEC-M03 §6.1, §9 | | OPEN |
| REQ-105 | ERR | Error character inside a frame | M03 `Xgmii_rx_64` | SPEC-M03 §9 | | OPEN |
| REQ-106 | FUNC | Terminate in any lane | M03 `Xgmii_rx_64` | SPEC-M03 §6.1 | | OPEN |
| REQ-107 | ERR | Runt frames | M03 `Xgmii_rx_64` | SPEC-M03 §9 | | OPEN |
| REQ-108 | ERR | Oversize frames | M03 `Xgmii_rx_64` | SPEC-M03 §6.2, §9 | | OPEN |
| REQ-109 | FUNC | Idle between frames | M03 `Xgmii_rx_64` | SPEC-M03 §6.1 | | OPEN |
| REQ-110 | ERR | Start without terminate | M03 `Xgmii_rx_64` | SPEC-M03 §9 | | OPEN |
| REQ-111 | PERF | Constant receive latency | M03 `Xgmii_rx_64` | SPEC-M03 §7 | | OPEN |
| REQ-112 | INV | No stall | M03 `Xgmii_rx_64` | SPEC-M03 §4.1 | | OPEN |
| REQ-113 | FUNC | Ordered sets ignored | M03 `Xgmii_rx_64` | SPEC-M03 §6.1 | | OPEN |
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
| REQ-401 | FUNC | Header extraction | M06 `Eth_axis_rx` | pending | | OPEN |
| REQ-402 | ERR | Short frames | M06 `Eth_axis_rx` | pending | | OPEN |
| REQ-403 | ERR | Abort passthrough | M06 `Eth_axis_rx` | pending | | OPEN |
| REQ-404 | FUNC | Ethertype demultiplex | M08 `Eth_demux` | pending | | OPEN |
| REQ-405 | FUNC | Header insertion | M07 `Eth_axis_tx` | pending | | OPEN |
| REQ-406 | FUNC | Frame-atomic arbitration | M09 `Eth_arb_mux` | pending | | OPEN |
| REQ-407 | FUNC | No Ethernet-layer address filtering | M06 `Eth_axis_rx` | pending | | OPEN |
| REQ-408 | FUNC | Payload extent | M06 `Eth_axis_rx` | pending | | OPEN |
| REQ-409 | IFC | Field decoding | M06 `Eth_axis_rx`, M07 `Eth_axis_tx` | pending | | OPEN |
| REQ-410 | PERF | Back-to-back frames | M06 `Eth_axis_rx` | pending | | OPEN |
| REQ-501 | FUNC | Packet acceptance | M10 `Arp_eth_rx` | pending | | OPEN |
| REQ-502 | FUNC | Request response | M13 `Arp`, M11 `Arp_eth_tx` | pending | | OPEN |
| REQ-503 | FUNC | Learning | M13 `Arp`, M12 `Arp_cache` | pending | | OPEN |
| REQ-504 | FUNC | Cache organisation | M12 `Arp_cache` | pending | | OPEN |
| REQ-505 | ERR | Lookup miss | M13 `Arp` | pending | | OPEN |
| REQ-506 | FUNC | Retry and ageing | M12 `Arp_cache`, M13 `Arp` | pending | | OPEN |
| REQ-507 | FUNC | Off-subnet routing | M13 `Arp` | pending | | OPEN |
| REQ-508 | FUNC | Broadcast destinations | M13 `Arp` | pending | | OPEN |
| REQ-509 | FUNC | Multicast destinations | M13 `Arp` | pending | | OPEN |
| REQ-510 | ERR | Reply drop over stall | M13 `Arp` | pending | | OPEN |
| REQ-511 | FUNC | Gratuitous ARP | M13 `Arp` | pending | | OPEN |
| REQ-512 | FUNC | No proxy ARP | M13 `Arp` | pending | | OPEN |
| REQ-601 | ERR | Version and header length | M14 `Ip_eth_rx_64` | pending | | OPEN |
| REQ-602 | ERR | Header checksum | M14 `Ip_eth_rx_64` | pending | | OPEN |
| REQ-603 | ERR | Fragments | M14 `Ip_eth_rx_64` | pending | | OPEN |
| REQ-604 | FUNC | Destination filter | M14 `Ip_eth_rx_64` | pending | | OPEN |
| REQ-605 | FUNC | Length handling | M14 `Ip_eth_rx_64` | pending | | OPEN |
| REQ-606 | FUNC | Header record | M14 `Ip_eth_rx_64` | pending | | OPEN |
| REQ-607 | ERR | Protocol filter | M14 `Ip_eth_rx_64` | pending | | OPEN |
| REQ-608 | FUNC | Header construction | M15 `Ip_eth_tx_64` | pending | | OPEN |
| REQ-609 | FUNC | Transmit checksum | M15 `Ip_eth_tx_64` | pending | | OPEN |
| REQ-610 | FUNC | Transmit length | M15 `Ip_eth_tx_64` | pending | | OPEN |
| REQ-611 | PERF | Constant parse latency | M14 `Ip_eth_rx_64` | pending | | OPEN |
| REQ-612 | ERR | Maximum size | M14 `Ip_eth_rx_64` | pending | | OPEN |
| REQ-701 | FUNC | Header record | M17 `Udp_ip_rx_64` | pending | | OPEN |
| REQ-702 | FUNC | Checksum not verified | M17 `Udp_ip_rx_64` | pending | | OPEN |
| REQ-703 | ERR | Length checks | M17 `Udp_ip_rx_64` | pending | | OPEN |
| REQ-704 | FUNC | Port filter | M17 `Udp_ip_rx_64` | pending | | OPEN |
| REQ-705 | IFC | Transmit request form | M18 `Udp_ip_tx_64` | pending | | OPEN |
| REQ-706 | FUNC | Transmit checksum zero | M18 `Udp_ip_tx_64` | pending | | OPEN |
| REQ-707 | IFC | Application receive stream | M17 `Udp_ip_rx_64` | pending | | OPEN |
| REQ-708 | PERF | Application-boundary line rate | M19 `Udp_complete_64`, M20 `Nic_top` | pending | | OPEN |
| REQ-709 | ERR | Under-delivery of a declared length | M18 `Udp_ip_tx_64`, M04 `Xgmii_tx_64` | pending | | OPEN |
| REQ-710 | ERR | Over-delivery of a declared length | M18 `Udp_ip_tx_64` | pending | | OPEN |
| REQ-801 | IFC | Top-level ports | M20 `Nic_top` | pending | | OPEN |
| REQ-802 | IFC | Configuration record | M20 `Nic_top` | SPEC-M01 §4.1, §4.2 | | OPEN |
| REQ-803 | IFC | Configuration stability | M20 `Nic_top` | pending | | OPEN |
| REQ-804 | ERR | Status aggregation | M20 `Nic_top` | SPEC-M01 §4.1, §4.2 | | OPEN |
| REQ-805 | INV | Application must keep up | M20 `Nic_top` | pending | | OPEN |
| REQ-806 | PERF | End-to-end latency measurement | M20 `Nic_top` | pending | | OPEN |
| REQ-807 | FUNC | ARP connectivity | M20 `Nic_top` | pending | | OPEN |
| REQ-808 | PROC | Hierarchy and naming | M20 `Nic_top` | SPEC-M05 §4.1, §6.1 | | OPEN |
| REQ-809 | FUNC | End-to-end datagram path | M20 `Nic_top` | pending | | OPEN |
| REQ-810 | FUNC | Enable controls | M20 `Nic_top` | SPEC-M03 §4.3; SPEC-M04 §4.3 | | OPEN |
| REQ-901 | PROC | Differential co-simulation | programme (process) | pending | | OPEN |
| REQ-902 | PROC | Deterministic emission | programme (process) | pending | | OPEN |
| REQ-903 | PROC | Module surface | programme (process) | SPEC-M01 §10; SPEC-M02 §4.1; SPEC-M03 §4.1 | | OPEN |
| REQ-904 | PROC | Traceability currency | programme (process) | pending | | OPEN |
| REQ-905 | PROC | Per-module stress | programme (process) | SPEC-M03 §8 | | OPEN |
| REQ-906 | PROC | Evidence form | programme (process) | pending | | OPEN |

---

## Open dependencies

1. **Test column**: empty by design at WO-0002 return. dv_lead fills it from
   the attack plans and benches, in the commit that adds each test
   (dv_lead charter §3).
2. **Spec section**: filled batch by batch as the twenty module specifications
   land (architecture.md §8).
3. **System-level rows**: REQ-001 … REQ-021 and REQ-801 … REQ-810 are expected
   to be covered by `nic_top` system tests plus per-module restatements; the
   architect and dv_lead agree the split at the first module-ready gate.
4. **Partial coverage declared in advance (REQ-019)**: REQ-019's first sentence
   — the per-module latency ceiling of requirements.md §1.1 — is DV-verifiable
   and is what the row's test column must eventually name. Its second sentence
   ("no payload storage deeper than two datapath words") is explicitly design
   guidance with no port-visible symptom, and requirements.md says so; this row
   therefore reaches `COVERED` on the ceiling alone, and no sign-off packet may
   read it as evidence about buffer depth.
