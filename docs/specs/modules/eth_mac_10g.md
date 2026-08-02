# SPEC-M05 — `Eth_mac_10g`

- **Status**: **FROZEN** (`P1-spec-freeze`, SHA `f78766e`) — batch B, dv_lead
  countersignature `J-dv_lead-0005`. Changes to §4, §6 or §7 after this point
  are spec diffs recorded in §13 (SPEC-TEMPLATE rule 7)
- **Inventory id**: M05 (architecture.md §4) · **Path**:
  `libs/hardcaml_ethernet/src/eth_mac_10g.ml`
- **Datapath role**: shared/structural (receive-path module **with respect to
  its receive ports only**, requirements.md §0.4)
- **Owns REQs**: REQ-017 and REQ-018 at the MAC boundary, REQ-808
- **Prior-art counterpart**: `eth_mac_10g.v` (MIT) — consulted for
  decomposition and port naming only; behaviour below is stated independently
  and no source was copied
- **Depends on specs**: SPEC-M01 (`Axi64`, `Xgmii`), SPEC-M03
  (`Xgmii_rx_64`), SPEC-M04 (`Xgmii_tx_64`)
- **Author**: architect_docs_lead, journal `J-architect_docs_lead-0004`

## 1. Purpose

M05 binds M03 and M04 to one XGMII port pair and presents the 10G MAC as a
single module: lanes on one side, frame streams on the other. It exists as a
separate module because the two directions share exactly one thing — the wire —
and something has to be the place where that pairing is written down, so that
M20 instantiates one MAC rather than two halves that happen to be adjacent.

It has no upstream and no downstream of its own: its receive port chain is
XGMII → M03 → M06, and its transmit port chain is M07 → M04 → XGMII. It
contains **no datapath logic**; every octet it carries is carried by a child.

## 2. Scope

**In scope.**

- Instantiating M03 and M04 exactly once each, and wiring them to one XGMII
  port pair (`xgmii_rxd`/`xgmii_rxc` in, `xgmii_txd`/`xgmii_txc` out).
- Presenting the receive frame stream, the transmit frame stream and its
  `Dest`, and the six strobes its children raise, unchanged.
- Being the module at which the XGMII boundary is closed for the MAC
  (REQ-017's names, REQ-018's prohibition list) and at which the emitted
  hierarchy shows a `eth_mac_10g` module (REQ-808).

**Not this module's job.**

| Behaviour a reader might expect here | Owner |
|---|---|
| Any decode, encode, FCS, padding, gap or error detection | M03 (REQ-101 … REQ-113) and M04 (REQ-201 … REQ-210). M05 adds no logic and detects no condition |
| Aggregating strobes into a `Status` record | M20 `Nic_top` (REQ-804). M05 forwards six individual strobes; the record is assembled once, at the top |
| Declaring the `Config` record | M20 (REQ-802). M05 declares the three fields its children read, as scalars (SPEC-M01 §4.2's convention) |
| Cross-connecting receive to transmit — loopback, flow control, pause frames | nobody in Phase 1. No path exists between M05's two halves, which is REQ-208's structural half at this module |
| A second XGMII port pair, or channel bonding | nobody; out of scope |
| Anything below XGMII | nobody in Phase 1 — Phase 3 attaches here (REQ-018, architecture.md §9) |

## 3. Programme invariants that bind this module

Per requirements.md §0.4, M05 is a receive-path module **with respect to the
ports on that chain** — its XGMII receive pair and its receive frame stream —
and is bound by every receive-path requirement on those ports only. Its
transmit ports are not receive-path ports, and the `Axi64.Dest` it exposes
there does not violate REQ-003.

| REQ | Consequence for M05 |
|---|---|
| REQ-001 | One `clock`, fanned to both children. |
| REQ-002 | Both frame streams are 64-bit `Axi64`; both lane pairs are 64 + 8. |
| REQ-003 | The receive frame stream is `Axi64.Source` with no `Dest` (§4.1). The transmit stream's `Dest` is on the transmit side and §0.4 excludes it explicitly. |
| REQ-004 | M05 is **not** in §0.4's stress-bench list: it is a structural wrapper covered by its children's benches, and it introduces no datapath logic that would put it on the list by spec diff (§8). |
| REQ-005 | M05 adds **zero** octet times. Its receive-port latency constants *are* M03's, unchanged (§7). |
| REQ-007 | `tuser`[0] passes through untouched in both directions. |
| REQ-008 | M05 detects no condition and raises no strobe of its own; it forwards its children's six (§9). |
| REQ-009 | `clear` is fanned to both children; M05 holds no state for it to act on. |
| REQ-010 | Both frame ports use the programme stream types; both lane pairs use SPEC-M01's `Xgmii` record. |
| REQ-017 | M05 is where the four REQ-017 port names first appear together on one module. At the top level they are M20's, and the port-list check runs there; M05's contribution is that they are one pair of records, wired to one receive child and one transmit child. |
| REQ-018 | The prohibition list — PMA, serdes, PCS, 64b/66b, scrambler, auto-negotiation, link training, PTP — binds M05 as it binds its children, and M05 is the module where a future Phase-3 PCS would be tempted to appear. It SHALL NOT: Phase 3 attaches *below* these ports, not inside this module. |
| REQ-019 | M05's receive-port word delay is ΔC = 0 on top of M03's 3, so the chain figure charged against requirements.md §1.1 is M03's alone. M05 holds no payload storage at all. |
| REQ-020 | Order is preserved because nothing here reorders: the wiring is one-to-one. |
| REQ-021 | Word alignment is its children's; M05 relays words untouched. |
| REQ-808 | `eth_mac_10g` SHALL appear as a distinct module in the emitted Verilog, with `xgmii_rx_64` and `xgmii_tx_64` instantiated inside it (architecture.md §6.3). |

## 4. Interface

### 4.1 Interface records

```ocaml
(* SPEC-M05 §4.1, lifted verbatim into docs/specs/ifc_check/eth_mac_10g_ifc.ml
   (SPEC-TEMPLATE.md rule 6). Records and signatures only — no logic, no
   implementation.

   [Axi64_ifc] is M01's types home (SPEC-M01 §4.1). M05 restates nothing
   from SPEC-M03 or SPEC-M04 either: its ports are their ports, and the
   only thing this record adds is that the two children share one clock,
   one clear and one wire.

   [rx] carries [Axi64.Source] with no [Axi64.Dest] anywhere in scope of
   it — REQ-003 structurally, inherited from M03. [tx] and [tx_dest] are
   the transmit stream's two directions, as in SPEC-M04. *)

open! Base
open Hardcaml
open! Axi64_ifc

module I = struct
  type 'a t =
    { clock : 'a
    ; clear : 'a
    ; xgmii_rx : 'a Xgmii.t [@rtlprefix "xgmii_rx"]
    ; tx : 'a Axi64.Source.t [@rtlprefix "tx_"]
    ; cfg_rx_enable : 'a
    ; cfg_tx_enable : 'a
    ; cfg_ifg : 'a [@bits 8]
    }
  [@@deriving hardcaml]
end

module O = struct
  type 'a t =
    { rx : 'a Axi64.Source.t [@rtlprefix "rx_"]
    ; tx_dest : 'a Axi64.Dest.t [@rtlprefix "tx_"]
    ; xgmii_tx : 'a Xgmii.t [@rtlprefix "xgmii_tx"]
    ; error_bad_fcs : 'a
    ; error_bad_frame : 'a
    ; error_runt : 'a
    ; error_oversize : 'a
    ; error_start_without_terminate : 'a
    ; error_underflow : 'a
    }
  [@@deriving hardcaml]
end

module type S = sig
  val create : Scope.t -> Signal.t I.t -> Signal.t O.t
  val hierarchical : ?instance:string -> Scope.t -> Signal.t I.t -> Signal.t O.t
end
```

Conformance of this block to the template's rules for §4.1:

- Scalar fields carry `[@bits n]` unless one bit wide: `cfg_ifg` is 8 bits;
  everything else scalar is one bit.
- Nested interfaces carry `[@rtlprefix]`; the four wire-side names are
  REQ-017's exactly.
- **Receive-path `Source` without `Dest`: held** on `rx`. The `Dest` that does
  appear, `tx_dest`, belongs to the transmit stream, which requirements.md
  §0.4 excludes from the receive path by name for exactly this module.
- Both `create` and `hierarchical` are declared (REQ-903, REQ-808).
- No field-name witness is repeated here: SPEC-M03's lift names the six
  `Source` fields and SPEC-M04's names `Dest.tready`, which settles SPEC-M01
  §11.4 once. A third copy would add nothing a compile could fail on.

### 4.2 Port table

Every port in §4.1 appears exactly once. Direction is with respect to M05.

| Port | Dir | Width | Meaning | REQ |
|---|---|---|---|---|
| `clock` | in | 1 | 156.25 MHz single domain, fanned to both children | REQ-001 |
| `clear` | in | 1 | synchronous clear, fanned to both children | REQ-009 |
| `xgmii_rxd` | in | 64 | receive lanes, to M03 unchanged | REQ-017 |
| `xgmii_rxc` | in | 8 | receive control indications, to M03 unchanged | REQ-017 |
| `tx_tvalid` … `tx_tuser` | in | 1/64/8/8/1/1 | transmit frame stream from M07, to M04 unchanged | REQ-010 |
| `cfg_rx_enable` | in | 1 | to M03 (REQ-810) | REQ-802 |
| `cfg_tx_enable` | in | 1 | to M04 (REQ-810) | REQ-802 |
| `cfg_ifg` | in | 8 | to M04 (REQ-204) | REQ-802 |
| `rx_tvalid` … `rx_tuser` | out | 1/64/8/8/1/1 | received frame stream from M03, to M06 unchanged | REQ-010 |
| `tx_tready` | out | 1 | from M04, to M07 unchanged | REQ-207 |
| `xgmii_txd` | out | 64 | transmit lanes from M04 | REQ-017 |
| `xgmii_txc` | out | 8 | transmit control indications from M04 | REQ-017 |
| `error_bad_fcs`, `error_bad_frame`, `error_runt`, `error_oversize`, `error_start_without_terminate` | out | 1 each | from M03, unchanged | REQ-104, REQ-105, REQ-107, REQ-108, REQ-110 |
| `error_underflow` | out | 1 | from M04, unchanged | REQ-206 |

### 4.3 Configuration inputs

Three fields, all pass-through: `rx_enable` to M03, `tx_enable` and `ifg` to
M04, each as the scalar `cfg_<field>` input of SPEC-M01 §4.2's convention. M05
samples none of them itself and holds no register, so REQ-803's "when a change
takes effect" is answered entirely by SPEC-M03 §4.3 and SPEC-M04 §4.3 and is
not restated here — restating it would create a second place for it to drift.

## 5. Parameters

**None**, and none is possible: M05 has no logic to parameterise, and its
children have no parameters (SPEC-M03 §5, SPEC-M04 §5). REQ-506 has no instance.

| Parameter | Type | Default | Range | Why a test overrides it |
|---|---|---|---|---|
| (none) | — | — | — | — |

## 6. Behaviour

### 6.1 Normal path

M05's behaviour is its wiring, and the wiring is total: every port of §4.2 is
connected to exactly one child port or to both children, with no logic between.

| M05 port | Connected to |
|---|---|
| `clock`, `clear` | both children |
| `xgmii_rxd`, `xgmii_rxc` | M03 `xgmii_rx` |
| `cfg_rx_enable` | M03 `cfg_rx_enable` |
| M03 `rx` | M05 `rx` |
| M03's five strobes | M05's five identically named outputs |
| `tx_tvalid` … `tx_tuser` | M04 `tx` |
| `cfg_ifg`, `cfg_tx_enable` | M04 |
| M04 `tx_dest` | M05 `tx_dest` |
| M04 `xgmii_tx` | M05 `xgmii_txd`, `xgmii_txc` |
| M04 `error_underflow` | M05 `error_underflow` |

There is **no connection between the receive half and the transmit half**. That
is worth stating rather than leaving to the reader's inspection: it is REQ-208's
structural half at this module (no transmit condition can reach the receive
datapath because no wire does), and it is why loopback, pause frames and flow
control are absent rather than disabled.

No cycle-by-cycle table appears here because no sequencing exists to tabulate:
every octet's timing is its child's, and SPEC-M03 §6.1 and SPEC-M04 §6.1 carry
the tables.

### 6.2 State machine

**Not applicable: M05 is purely structural.** It holds no register and has no
state, so it has no reset state and nothing happens to it on `clear` beyond the
fan-out of §6.1 — the same shape SPEC-M02 §6.2 states for a combinational
module, one level further removed: M02 is a function of its inputs, M05 is not
a function at all, it is a wiring diagram.

### 6.3 Deliberately unconstrained

Anything not listed here is constrained by this specification.

1. **The instance names** M05 gives its two children (`hierarchical`'s
   `?instance` argument). The *module* names are normative — `xgmii_rx_64` and
   `xgmii_tx_64`, REQ-808 — and the instance labels are not.
2. **Whether M05 declares its own `.mli` re-exports** of the child modules'
   types. REQ-903 requires the `.mli`; what it re-exports is rtl_lead's.
3. **Nothing else.** A structural module with an unconstrained region larger
   than this is a module doing something it has not admitted to, and §6.1's
   wiring table is deliberately total so that any additional logic is a visible
   diff against it.

## 7. Timing contract

- **Latency.** **Zero octet times added, in both directions.** M05's
  receive-port constants are M03's exactly — L = 16 octet times at a lane-0
  start, 12 at a lane-4 start, front offset h = 8 and 12, word delay ΔC = 3
  (SPEC-M03 §7) — and its transmit-port constant is M04's, 8 octet times
  (SPEC-M04 §7). The measurement events are M03's and M04's; M05 introduces
  none of its own because a wire is not a measurement event.

  Consequently M05 consumes **none** of requirements.md §1.1's allocation: the
  4-cycle ceiling on `Xgmii_rx_64` is charged against M03's 3 and M05 adds 0.
  A future revision of M05 that added a register would change that and would be
  a spec diff to this section plus a §1.1 re-allocation, which is the point of
  stating a zero rather than leaving the row out.

- **Throughput.** One word per cycle in each direction, set entirely by the
  children.

- **Handshake rules.** Relayed unchanged. `rx` never carries a `tready`
  (REQ-003); `tx_tready` is M04's and REQ-016's idle tolerance does not extend
  to it (SPEC-M04 §7).

- **Reset.** `clear` reaches both children on the same cycle. Within one cycle
  of `clear` deasserting, M05's outputs are its children's outputs, which
  REQ-009 already constrains at M03 and M04. M05 adds no reset behaviour of its
  own because it has no state to reset.

- **Configuration sampling.** None here; §4.3.

## 8. Line-rate stress obligation

**Not applicable.** M05 is not in requirements.md §0.4's stress-bench list, and
§0.4's rule for structural wrappers applies exactly: *"Structural wrappers M05,
M16 and M19 are covered by their children's benches unless the wrapper
introduces datapath logic of its own, in which case it joins this list by a
spec diff."* M05 introduces none — §6.1's wiring table is total and §6.3 leaves
no room for any — so M03's REQ-004 stress bench (SPEC-M03 §8) is the bench that
covers M05's receive path, and M04's REQ-209 sustained bench covers its
transmit path.

The condition under which that changes is written down rather than implied: if
a later revision puts a register, a mux or a counter between M05's ports and
its children's, M05 joins §0.4's list by spec diff and owes its own bench.

## 9. Errors and discards

**Not applicable as a detection table.** M05 detects no condition: it forwards
no frame of its own, holds none in flight, and has no logic that could observe
one. The six strobes it exposes are its children's, relayed unchanged.

| Condition | Strobe (one cycle) | Stream effect | REQ |
|---|---|---|---|
| (none detected here — the six strobes below are relayed, not raised) | `error_bad_fcs`, `error_bad_frame`, `error_runt`, `error_oversize`, `error_start_without_terminate` (M03); `error_underflow` (M04) | none: M05 alters no stream | REQ-104, REQ-105, REQ-107, REQ-108, REQ-110, REQ-206 |

Co-occurrence, precedence and multiplicity (requirements.md §0.6) are its
children's and are stated in SPEC-M03 §9 and SPEC-M04 §9. M05 has no instance
of §0.6's "a module SHALL NOT re-report an inherited abort" either — relaying a
strobe on a wire is not re-reporting it, because M05 raises nothing: the pulse
that leaves M05 *is* the pulse M03 or M04 raised, one cycle wide, on the same
cycle.

REQ-008's prohibition on silent discard is not weakened: every condition
detectable at this boundary is detected by a child and reported by a strobe M05
exposes, and the frame-conservation monitor of §0.6 run at M05's ports is
arithmetically the same monitor run at M03's.

## 10. REQ coverage

| REQ | How this module satisfies it | Section | Verification hook for DV |
|---|---|---|---|
| REQ-001 | one clock, fanned to both children | §6.1 | the emitted-Verilog edge-expression check |
| REQ-003 | `rx` is `Source` with no `Dest`; the `Dest` present is on the transmit port §0.4 excludes | §4.1 | interface compile check |
| REQ-005 | adds zero octet times | §7 | the per-octet latency measurement in M03's bench, taken at M05's ports: identical values |
| REQ-007 | `tuser`[0] relayed untouched | §6.1 | error injection at M03, observed at M05's `rx` |
| REQ-008 | six strobes relayed; none suppressed | §9 | frame conservation at M05's ports equals frame conservation at M03's |
| REQ-009 | `clear` fanned; no state of its own | §7 | the reset tests of M03 and M04, run through M05 |
| REQ-017 | the four wire-side names appear together on one module, from SPEC-M01's `Xgmii` record | §4.1, §4.2 | emitted-Verilog port-list check at M05, and again at M20 where REQ-017 binds |
| REQ-018 | no PMA/PCS/serdes/PTP; instantiates only M03 and M04 | §3, §6.1 | the emitted-module whitelist check: M05 instantiates exactly `xgmii_rx_64` and `xgmii_tx_64` |
| REQ-019 | ΔC = 0 added; no payload storage | §7 | the §1.1 arithmetic at freeze; the measured chain figure in the sign-off packet |
| REQ-208 | no wire connects the receive half to the transmit half | §6.1 | REQ-208's test at the top level, plus inspection of the emitted `eth_mac_10g` netlist for any receive-to-transmit connection |
| REQ-808 | `eth_mac_10g` is a distinct emitted module containing both children | §4.1, §6.1 | the `rtl_snapshots/` module-name comparison and the instance hierarchy |
| REQ-903 | `.mli` plus a `hierarchical` entry point taking a `Scope.t` | §4.1 | repository surface check at `P1-module-ready` |

This table is the source of M05's rows in [`traceability.md`](../traceability.md),
updated in the same commit.

## 11. Deferred items

| # | Item | Status · what a reader assumes meanwhile | Tracked as | Owner | Closes by |
|---|---|---|---|---|---|
| 11.1 | **Whether the six strobes should reach M20 individually or as a partial `Status` record.** M05 forwards six scalars; M20 assembles the twenty-one-field record (REQ-804). At M16, M19 and M20 the same question recurs with more strobes, and a wrapper carrying nineteen scalars is a wide port list. | **DEFERRED — this specification commits to six scalars and nothing downstream is blocked.** A reader wiring M05 today connects six named outputs, and every name is normative (requirements.md §12) whichever container later carries it. If batch E or F adopts a partial-record convention, changing M05 to match is a §4 spec diff plus an ADR, and it renames no strobe. | WO for batch E/F (SPEC-M16, M19, M20) | architect_docs_lead | SPEC-M20 |
| 11.2 | **REQ-017's port-list check runs at M20, not here**, so M05's four wire-side names are checked only by the compile lane until batch F. | **DEFERRED — the names are fixed by the type, not by this module.** SPEC-M01's `Xgmii` record plus the two `rtlprefix` values determine them, so M05, M20 and any future user emit the same four names by construction; the M20 check confirms rather than establishes them. | SPEC-M20 (batch F) | architect_docs_lead | SPEC-M20 |

## 12. Freeze record

Filled in at `P1-spec-freeze`. All four rows are required (charter §5).

| Item | Value |
|---|---|
| Interface compile check | CI `build` run **30729342467**, conclusion **`success`**, SHA **f78766e**; per ADR-0005 a local build is not acceptable evidence |
| Architect signature | `J-architect_docs_lead-0004` |
| dv_lead testability countersignature | `J-dv_lead-0005` (WO-0010) — **SIGNED**, batch B |
| Frozen at | SHA **f78766e**, gate `docs/gates/P1-spec-freeze-checklist.md` |

## 13. Change log

Post-freeze changes only. This spec has none. The WO-0011 diff cycle changed
SPEC-M03 §6.1, §6.2, §6.3, §7 and §9 and SPEC-M04 §4.3, §6.2, §6.3 and §7;
every one of those diffs is editorial and none moves a port, so §4.1's wiring,
§6.1's connection table and §7's "zero octet times added" are unaffected. M05's
receive-port constants remain M03's unchanged (L = 16 / 12, h = 8 / 12, ΔC = 3).

| Date | Change | Breaking? | ADR | Journal |
|---|---|---|---|---|
| — | — | — | — | — |
