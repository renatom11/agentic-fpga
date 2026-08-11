# SPEC-M16 — `Ip_complete_64`

- **Status**: **FROZEN** (`P1-spec-freeze`, SHA `3f6accc`) — batch E, dv_lead
  countersignature `J-dv_lead-0009` (WO-0018), **SIGNED** on this specification's
  own merits with §6.1's wiring table checked total in both directions. Changes
  to §4, §6 or §7 after this point are spec diffs recorded in §13
  (SPEC-TEMPLATE rule 7)
- **Inventory id**: M16 (architecture.md §4) · **Path**:
  `libs/hardcaml_ethernet/src/ip_complete_64.ml`
- **Datapath role**: shared/structural (receive-path module **with respect to its
  receive ports only**, requirements.md §0.4)
- **Owns REQs**: REQ-808 at this level, and the **structural half** of REQ-807 —
  M16 is where the ARP request-to-reply loop is closed inside the design; the
  observable half is M20's (§10)
- **Prior-art counterpart**: `ip_complete_64.v` (MIT), with `ip_64.v` folded in
  (architecture.md §5) — consulted for decomposition and port naming only;
  behaviour below is stated independently and no source was copied
- **Depends on specs**: SPEC-M01 (`Axi64`, `Ip_header`), SPEC-M06
  (`Eth_axis_rx`), SPEC-M07 (`Eth_axis_tx`), SPEC-M08 (`Eth_demux`), SPEC-M09
  (`Eth_arb_mux`), SPEC-M13 (`Arp`), SPEC-M14 (`Ip_eth_rx_64`), SPEC-M15
  (`Ip_eth_tx_64`)
- **Author**: architect_docs_lead, journal `J-architect_docs_lead-0007`

## 1. Purpose

M16 is the IPv4-with-ARP subsystem: it binds the Ethernet framing pair (M06,
M07), the two-way Ethernet routing pair (M08, M09), the IPv4 pair (M14, M15) and
the ARP resolver (M13) into one module whose ports are a frame stream in, a frame
stream out, an IPv4 receive pair, an IPv4 transmit pair and the strobes its
children raise. It exists as a separate module because that set is exactly what
"IPv4 over Ethernet, with address resolution" means: everything inside it is
required for a datagram to reach the wire, and nothing inside it knows what a UDP
port is.

Its receive port chain is M05 → **M16** → M17, and its transmit port chain is
M18 → **M16** → M05, in both cases through M19 (architecture.md §6.4). It
contains **no datapath logic**: every octet it carries is carried by a child, and
§6.1's wiring table is total.

## 2. Scope

**In scope.**

- Instantiating M06, M07, M08, M09, M13, M14 and M15 exactly once each and
  wiring them as §6.1's table states, with no logic between any pair of ports.
- Presenting the frame stream in and out, the IPv4 receive header-and-payload
  pair, the IPv4 transmit header-and-payload pair with its `Dest`, and the twelve
  strobes its children raise, all unchanged.
- Fanning the seven configuration scalars its children read out to M13, M14 and
  M15 (§4.3).
- Being the module at which the ARP loop is **structurally closed** (REQ-807):
  the path from a received ARP frame to a transmitted ARP reply lies entirely
  inside M16, so no wrapper above it has to complete it and no wrapper above it
  can break it.
- Being the module named `ip_complete_64` in the emitted hierarchy (REQ-808).

**Not this module's job.**

| Behaviour a reader might expect here | Owner |
|---|---|
| Any decode, encode, checksum, filtering, resolution or realignment | M06, M07, M08, M09, M13, M14, M15 in their own specifications. M16 adds no logic and detects no condition |
| The UDP layer, the application boundary, the ports | M17, M18 and M19 (REQ-701 … REQ-710). M16's receive output is an IPv4 header record plus payload, which is precisely where UDP begins |
| The MAC, the FCS, the preamble, XGMII | M05, M03 and M04 (REQ-101 … REQ-210). M16's frame ports carry destination address through payload, FCS already stripped or not yet added |
| Aggregating strobes into a `Status` record | M20 `Nic_top` (REQ-804). M16 forwards twelve individual scalars; the record is assembled once, at the top (SPEC-M05 §11.1 raises the same question there and this specification answers it the same way) |
| Declaring the `Config` record | M20 (REQ-802). M16 declares the seven fields its children read, as scalars, in SPEC-M01 §4.2's convention |
| Arbitrating between the IPv4 and ARP transmit sources | M09, **inside** M16 (REQ-406). The arbitration is M16's *contents*, not M16's behaviour: M16 exposes one transmit stream because M09 has already merged two |
| A second IPv4 client, or an IP-level demultiplexer | **nobody** — architecture.md §5 folds `ip_arb_mux.v` and `ip_demux.v` away because Phase 1 has one client |

## 3. Programme invariants that bind this module

Per requirements.md §0.4, M16 is a receive-path module **with respect to the
ports on that chain** — its `rx` input and its `ip_rx_hdr` / `ip_rx_payload`
outputs — and is bound by every receive-path requirement on those ports only. Its
transmit ports are not receive-path ports, and the `Axi64.Dest` it exposes there
does not violate REQ-003.

| REQ | Consequence for M16 |
|---|---|
| REQ-001 | One `clock`, fanned to all seven children. |
| REQ-002 | Every frame-carrying port is a 64-bit `Axi64` stream. |
| REQ-003 | The receive ports are `Axi64.Source` with no `Dest` (§4.1). The two `Dest` records present belong to the transmit chain, which §0.4 excludes by name for this module. |
| REQ-004 | M16 is **not** in §0.4's stress-bench list: it is a structural wrapper covered by its children's benches, and it introduces no datapath logic that would put it on the list by spec diff (§8). |
| REQ-005 | M16 adds **zero** octet times. Its receive-port latency constants *are* its children's, unchanged (§7). |
| REQ-007, REQ-013 | `tuser`[0] passes through untouched in both directions. M16 consumes it nowhere; on the ARP branch M13 does (ADR-0009), which is inside M16 and is M13's behaviour, not M16's. |
| REQ-008 | M16 detects no condition and raises no strobe of its own; it forwards its children's twelve (§9). |
| REQ-009 | `clear` is fanned to all seven children; M16 holds no state for it to act on. |
| REQ-010 | Every stream port uses the programme stream types; both IPv4 header ports use SPEC-M01's `Ip_header`. M16 declares no record. |
| REQ-015, REQ-016, REQ-021 | Bind the relayed streams and are satisfied by relaying: M16 changes no `tkeep`, no octet order, no `tlast` and no alignment, and inserts no idle cycle. |
| REQ-017, REQ-018 | No instance: M16 sees nothing at or below XGMII — M05 is above it in the hierarchy and owns that boundary. |
| REQ-019 | M16's receive-port word delay is ΔC = 0 on top of M06's 3, M08's 1 and M14's 4, so the chain figure charged against requirements.md §1.1 is its children's alone: **8** cycles from M16's `rx` to its `ip_rx_payload`, which is 3 + 1 + 4 and is what §1.1's rows for those three stages allocate 3 + 1 + 5 to. M16 holds no payload storage at all. |
| REQ-020 | Order is preserved because nothing here reorders: the wiring is one-to-one and M09's arbitration — the one place two orders merge — is frame-atomic inside M16 (REQ-406). |
| REQ-807 | The ARP request-to-reply path lies entirely inside M16: `rx` → M06 → M08 → M13 (→ M10, M11) → M09 → M07 → `tx`. Nothing above M16 participates, which is why a break in that loop is localisable to this module's contents rather than to the top level. |
| REQ-808 | `ip_complete_64` SHALL appear as a distinct module in the emitted Verilog with all seven children instantiated inside it (architecture.md §6.3). |

## 4. Interface

### 4.1 Interface records

```ocaml
(* SPEC-M16 §4.1, lifted verbatim into
   docs/specs/ifc_check/ip_complete_64_ifc.ml (SPEC-TEMPLATE.md rule 6).
   Records and signatures only — no logic, no implementation.

   [Axi64_ifc] is M01's types home (SPEC-M01 §4.1): [Axi64] and
   [Ip_header] come from there. M16 restates nothing from SPEC-M06,
   M07, M08, M09, M13, M14 or M15 either: its ports are a subset of
   theirs, and the only thing this record adds is that seven children
   share one clock, one clear and one configuration fan-out.

   Batch E declares NO record, here as at M14 and M15: the declare-once
   rule (SPEC-M10 §4.1, §11.2) is honoured by having nothing to declare.
   M16 does not [open! Arp_ifc] or [open! Ip_eth_rx_64_ifc] either,
   because no record of theirs appears at ITS ports — the ARP query and
   response, the [Arp_packet] and the three cache records are all
   internal signals of M16's hierarchy (§6.1), exactly as M13's own
   children's edges are internal to M13 (architecture.md §6.4). A lift
   that opened a module it does not use would compile and would still be
   a lie about the dependency (SPEC-M12 §4.1's rule).

   [rx], [ip_rx_hdr] and [ip_rx_payload] are the receive ports: [Source]
   with no [Dest] anywhere for them, REQ-003 structurally, inherited
   from M06 and M14. [ip_tx_*] and [tx] are the transmit chain, [Source]
   one way and [Dest] the other, as in SPEC-M07 and SPEC-M09. *)

open! Base
open Hardcaml
open! Axi64_ifc

module I = struct
  type 'a t =
    { clock : 'a
    ; clear : 'a
    ; rx : 'a Axi64.Source.t [@rtlprefix "rx_"]
    ; ip_tx_hdr : 'a Ip_header.t [@rtlprefix "ip_tx_hdr_"]
    ; ip_tx_payload : 'a Axi64.Source.t [@rtlprefix "ip_tx_payload_"]
    ; tx_dest : 'a Axi64.Dest.t [@rtlprefix "tx_"]
    ; cfg_local_mac : 'a [@bits 48]
    ; cfg_local_ip : 'a [@bits 32]
    ; cfg_subnet_mask : 'a [@bits 32]
    ; cfg_gateway_ip : 'a [@bits 32]
    ; cfg_multicast_group : 'a [@bits 32]
    ; cfg_multicast_enable : 'a
    ; cfg_ttl : 'a [@bits 8]
    }
  [@@deriving hardcaml]
end

module O = struct
  type 'a t =
    { ip_rx_hdr : 'a Ip_header.t [@rtlprefix "ip_rx_hdr_"]
    ; ip_rx_payload : 'a Axi64.Source.t [@rtlprefix "ip_rx_payload_"]
    ; ip_tx_payload_dest : 'a Axi64.Dest.t [@rtlprefix "ip_tx_payload_"]
    ; tx : 'a Axi64.Source.t [@rtlprefix "tx_"]
    ; error_short_frame : 'a
    ; error_unknown_ethertype : 'a
    ; error_arp_unsupported : 'a
    ; error_arp_miss : 'a
    ; error_arp_reply_dropped : 'a
    ; error_ip_bad_header : 'a
    ; error_ip_bad_checksum : 'a
    ; error_ip_fragment : 'a
    ; error_ip_not_for_us : 'a
    ; error_ip_truncated : 'a
    ; error_ip_bad_protocol : 'a
    ; error_ip_oversize : 'a
    }
  [@@deriving hardcaml]
end

module type S = sig
  val create
    :  ?retry_count:int
    -> ?retry_interval_cycles:int
    -> ?entry_lifetime_cycles:int
    -> Scope.t
    -> Signal.t I.t
    -> Signal.t O.t

  val hierarchical
    :  ?instance:string
    -> ?retry_count:int
    -> ?retry_interval_cycles:int
    -> ?entry_lifetime_cycles:int
    -> Scope.t
    -> Signal.t I.t
    -> Signal.t O.t
end
```

Conformance of this block to the template's rules for §4.1:

- Scalar fields carry `[@bits n]` unless they are one bit wide: `clock`,
  `clear`, `cfg_multicast_enable` and the twelve strobes are one bit; the five
  `cfg_` addresses and `cfg_ttl` carry their widths.
- Nested interfaces carry `[@rtlprefix]`, and each transmit stream's two
  directions share its prefix with no collision, because `Source`'s field names
  and `Dest`'s are disjoint (SPEC-M04 §4.1 fixes that pattern):
  `ip_tx_payload_tvalid` … beside `ip_tx_payload_tready`, and `tx_tvalid` …
  beside `tx_tready`.
- **Receive-path `Source` without `Dest`: held** on `rx`, `ip_rx_payload` and
  the `Ip_header` output. The two `Dest` records present belong to the transmit
  chain, which requirements.md §0.4 excludes from the receive path by name for
  exactly this module.
- Both `create` and `hierarchical` are declared (REQ-903, REQ-808), each taking
  the three REQ-506 parameters, which M16 **forwards to its M13 instance and
  reads for nothing itself** (§5).
- No field-name witness is repeated here: SPEC-M14's lift names `Ip_header`'s
  seven fields and SPEC-M06's names `Eth_header`'s four, which settles them once.
  A third copy would add nothing a compile could fail on — the reasoning SPEC-M05
  §4.1 states for the same omission.

### 4.2 Port table

Every port in §4.1 appears exactly once. Direction is with respect to M16.

| Port | Dir | Width | Meaning | REQ |
|---|---|---|---|---|
| `clock` | in | 1 | 156.25 MHz single domain, fanned to all seven children | REQ-001 |
| `clear` | in | 1 | synchronous clear, fanned to all seven children | REQ-009 |
| `rx_tvalid` … `rx_tuser` | in | 1/64/8/8/1/1 | received frame stream from M05 (through M19), to M06 unchanged | REQ-010 |
| `ip_tx_hdr_valid` … `ip_tx_hdr_total_length` | in | 1/32/32/8/8/6/16 | IPv4 header record from M18, to M15 unchanged; `valid` is a level held until the frame's first payload word is accepted (ADR-0008) | REQ-610, ADR-0008 |
| `ip_tx_payload_tvalid` … `ip_tx_payload_tuser` | in | 1/64/8/8/1/1 | transmit payload stream from M18, to M15 unchanged | REQ-010 |
| `tx_tready` | in | 1 | from M05 (through M19), to M07 unchanged | REQ-207 |
| `cfg_local_mac` | in | 48 | to M13 and M15 | REQ-802 |
| `cfg_local_ip` | in | 32 | to M13, M14 and M15 | REQ-802 |
| `cfg_subnet_mask` | in | 32 | to M13 and M14 | REQ-802 |
| `cfg_gateway_ip` | in | 32 | to M13 | REQ-802 |
| `cfg_multicast_group` | in | 32 | to M14 | REQ-802 |
| `cfg_multicast_enable` | in | 1 | to M14 | REQ-802 |
| `cfg_ttl` | in | 8 | to M15 | REQ-802 |
| `ip_rx_hdr_valid` … `ip_rx_hdr_total_length` | out | 1/32/32/8/8/6/16 | IPv4 header record from M14, to M17 unchanged; `valid` is a one-cycle pulse, one cycle before the first payload word (REQ-606, SPEC-M14 §7) | REQ-606 |
| `ip_rx_payload_tvalid` … `ip_rx_payload_tuser` | out | 1/64/8/8/1/1 | IPv4 payload stream from M14, to M17 unchanged | REQ-010 |
| `ip_tx_payload_tready` | out | 1 | from M15, to M18 unchanged | REQ-207 |
| `tx_tvalid` … `tx_tuser` | out | 1/64/8/8/1/1 | frame stream from M07, to M05 unchanged | REQ-010 |
| `error_short_frame` | out | 1 | from M06, unchanged | REQ-402 |
| `error_unknown_ethertype` | out | 1 | from M08, unchanged | REQ-404 |
| `error_arp_unsupported` | out | 1 | from M13, which relays M10's (SPEC-M13 §9) | REQ-501 |
| `error_arp_miss`, `error_arp_reply_dropped` | out | 1 each | from M13, unchanged | REQ-505, REQ-510 |
| `error_ip_bad_header`, `error_ip_bad_checksum`, `error_ip_fragment`, `error_ip_not_for_us`, `error_ip_truncated`, `error_ip_bad_protocol`, `error_ip_oversize` | out | 1 each | from M14, unchanged | REQ-601 … REQ-607, REQ-612 |

### 4.3 Configuration inputs

Seven fields, all pass-through, each as the scalar `cfg_<field>` input of
SPEC-M01 §4.2's convention. M16 samples none of them itself and holds no
register, so REQ-803's "when a change takes effect" is answered entirely by
SPEC-M13 §4.3, SPEC-M14 §4.3 and SPEC-M15 §4.3 and is **not** restated here —
restating it would create a second place for it to drift, which is the reasoning
SPEC-M05 §4.3 gives for the same omission.

| Field | Fanned to | Governing sampling rule |
|---|---|---|
| `cfg_local_mac` | M13, M15 | SPEC-M13 §4.3; SPEC-M15 §4.3 |
| `cfg_local_ip` | M13, M14, M15 | SPEC-M13 §4.3; SPEC-M14 §4.3; SPEC-M15 §4.3 |
| `cfg_subnet_mask` | M13, M14 | SPEC-M13 §4.3; SPEC-M14 §4.3 |
| `cfg_gateway_ip` | M13 | SPEC-M13 §4.3 |
| `cfg_multicast_group` | M14 | SPEC-M14 §4.3 |
| `cfg_multicast_enable` | M14 | SPEC-M14 §4.3 |
| `cfg_ttl` | M15 | SPEC-M15 §4.3 |

**Three of these fan out to more than one child, and that is why they are seven
scalars rather than three.** `cfg_local_ip` reaches M13 (the reply predicate and
the on-subnet test), M14 (REQ-604's first accepted destination) and M15 (the
transmitted source address); `cfg_local_mac` reaches M13 and M15;
`cfg_subnet_mask` reaches M13 (REQ-507, REQ-508) and M14 (REQ-604's subnet
broadcast). One wire per field, fanned inside M16, is what makes a configuration
change land on every reader in the same cycle — a property REQ-803 depends on
and which a per-child port would not guarantee.

## 5. Parameters

| Parameter | Type | Default | Range | Why a test overrides it |
|---|---|---|---|---|
| `retry_count` | `int` | **4** | 0 to 15 | REQ-506 requires it; M16 forwards it to its M13 instance and reads it for nothing itself (SPEC-M13 §5) |
| `retry_interval_cycles` | `int` | **156 250 000** (1.0 s) | 1 to 2^32 − 1 | the same; §8's ARP runs are M13's and need short values |
| `entry_lifetime_cycles` | `int` | **3 125 000 000** (20 s) | 1 to 2^32 − 1 | the same; M13 forwards it again to M12 (SPEC-M12 §5) |

**M16 has no parameter of its own**, and these three exist here only so that a
bench instantiating the subsystem can reach M13's — and M12's — without reaching
inside the hierarchy. The defaults are M13's, restated here because a defaulted
optional argument must have one; the **normative** statement of each default and
range is SPEC-M13 §5, and a change to any of them is a spec diff there and here
together.

## 6. Behaviour

### 6.1 Normal path

M16's behaviour is its wiring, and the wiring is total: every port of §4.2 is
connected to exactly one child port, and every child port is connected either to
an M16 port or to another child, with **no logic between**.

**Receive chain.**

| Source | Sink |
|---|---|
| M16 `rx` | M06 `rx` |
| M06 `hdr`, M06 `payload` | M08 `hdr`, M08 `payload` |
| M08 `ip_hdr`, M08 `ip_payload` | M14 `hdr`, M14 `payload` |
| M08 `arp_hdr`, M08 `arp_payload` | M13 `rx_hdr`, M13 `rx_payload` |
| M14 `ip_hdr`, M14 `ip_payload` | M16 `ip_rx_hdr`, M16 `ip_rx_payload` |

**Transmit chain.**

| Source | Sink |
|---|---|
| M16 `ip_tx_hdr`, M16 `ip_tx_payload` | M15 `hdr`, M15 `payload` |
| M15 `payload_dest` | M16 `ip_tx_payload_dest` |
| M15 `eth_hdr`, M15 `eth_payload` | M09 `ip_hdr`, M09 `ip_payload` |
| M09 `ip_payload_dest` | M15 `eth_payload_dest` |
| M13 `tx_hdr`, M13 `tx_payload` | M09 `arp_hdr`, M09 `arp_payload` |
| M09 `arp_payload_dest` | M13 `tx_payload_dest` |
| M09 `hdr`, M09 `payload` | M07 `hdr`, M07 `payload` |
| M07 `payload_dest` | M09 `payload_dest` |
| M07 `tx` | M16 `tx` |
| M16 `tx_dest` | M07 `tx_dest` |

**Resolution.**

| Source | Sink |
|---|---|
| M15 `arp_query` | M13 `tx_query` |
| M13 `tx_response` | M15 `arp_response` |

**Configuration and clock.**

| Source | Sink |
|---|---|
| `clock`, `clear` | all seven children |
| `cfg_local_mac` | M13, M15 |
| `cfg_local_ip` | M13, M14, M15 |
| `cfg_subnet_mask` | M13, M14 |
| `cfg_gateway_ip` | M13 |
| `cfg_multicast_group`, `cfg_multicast_enable` | M14 |
| `cfg_ttl` | M15 |

**Strobes.** M06's `error_short_frame`, M08's `error_unknown_ethertype`, M13's
three (`error_arp_unsupported` relayed from M10, `error_arp_miss`,
`error_arp_reply_dropped`) and M14's seven reach M16's twelve identically named
outputs. M07, M09 and M15 raise none (SPEC-M07 §9, SPEC-M09 §9, SPEC-M15 §9).

**The ARP loop is closed here, and that is worth stating rather than leaving to
inspection** (REQ-807). A received ARP frame enters at `rx`, is framed by M06,
routed by M08, parsed and answered inside M13, arbitrated by M09 against the IPv4
transmit source and framed by M07, and leaves at `tx` — **every hop in that list
is inside M16**. Nothing above this module participates in it: M19 and M20 relay
`rx` and `tx` and nothing else (architecture.md §6.4). So REQ-807's system-level
observable at M20 is a test *of M16's contents*, and a failure of it localises
here before it localises anywhere else. The same is true of the resolution loop
M15 and M13 form, which is the two-row table above and touches no port of M16 at
all.

No cycle-by-cycle table appears here because no sequencing exists to tabulate:
every octet's timing is its children's, and SPEC-M06 §6.1, SPEC-M08 §6.1,
SPEC-M14 §6.1, SPEC-M15 §6.1, SPEC-M13 §6.1, SPEC-M09 §6.1 and SPEC-M07 §6.1
carry the tables.

### 6.2 State machine

**Not applicable: M16 is purely structural.** It holds no register and has no
state, so it has no reset state and nothing happens to it on `clear` beyond the
fan-out of §6.1 — the same shape SPEC-M05 §6.2 states for the MAC wrapper. M16 is
not a function of its inputs at all; it is a wiring diagram.

### 6.3 Deliberately unconstrained

Anything not listed here is constrained by this specification.

1. **The instance names** M16 gives its seven children (`hierarchical`'s
   `?instance` argument). The *module* names are normative — `eth_axis_rx`,
   `eth_axis_tx`, `eth_demux`, `eth_arb_mux`, `arp`, `ip_eth_rx_64`,
   `ip_eth_tx_64` (REQ-808) — and the instance labels are not.
2. **Whether M16 declares its own `.mli` re-exports** of the child modules'
   types. REQ-903 requires the `.mli`; what it re-exports is rtl_lead's.
3. **Nothing else.** A structural module with an unconstrained region larger than
   this is a module doing something it has not admitted to, and §6.1's wiring
   tables are deliberately total so that any additional logic is a visible diff
   against them — SPEC-M05 §6.3's rule, restated because M16 has seven children
   where M05 has two and the temptation to put "just one register" between them
   is correspondingly larger.

## 7. Timing contract

- **Latency.** **Zero octet times added, in both directions.** M16's receive-port
  constants are its children's exactly: from `rx` to `ip_rx_payload` the chain is
  M06 (L = 10, h = 14, ΔC = 3), M08 (L = 8, h = 0, ΔC = 1) and M14 (L = 12,
  h = 20, ΔC = 4), so the word delay across M16's receive ports is **8 cycles**
  and the front offset is 34 octets.

  On the transmit side the chain is M15 (1 cycle), M09 (0) and M07 (1), and every
  one of those figures is an **event delay** rather than a latency: M15's and
  M07's are each pinned to a word their own module **inserted**, which carries no
  octet that entered at any input (requirements.md §0.5's inserting-module clause;
  SPEC-M15 §7 and SPEC-M07 §7 each pin two constants and name which is which).
  The three sum to **two cycles from the cycle M15 accepts the frame's
  first payload word** — not from the cycle M15 emits body word 0 (carry-forward
  **C-29**, dv_lead; the text this replaces anchored the figure to the wrong
  event). Written out, with C the cycle M15 accepts the frame's first payload
  word: M15 emits body word 0 at **C + 1** (SPEC-M15 §7's **event delay** of
  1 cycle), M09 relays it combinationally so M07 accepts it on that same cycle
  (SPEC-M09 §7, ΔC = 0), and M07 emits its first output word at **C + 2**
  (SPEC-M07 §7's **event delay** of 1 cycle from the acceptance of its own first
  payload word). So M16 presents its **first `tx` word**

  > **one cycle after M15 emits its first body word, and two cycles after M15
  > accepts the frame's first payload word.**

  Both readings are stated because a monitor is built from one of them: a monitor
  measuring M15's `eth_payload` against M16's `tx` asserts **1**, and one
  measuring from the payload acceptance asserts **2**. The same convention is
  visible in SPEC-M13 §6.1's REQ-502 table, where M11 offers at cycle 14 and M07
  outputs at cycle 15. The measurement events are the children's; M16 introduces
  none of its own, because a wire is not a measurement event.

  **Neither figure is the transit of any word's octets, and this section pins no
  per-octet constant across M16's transmit ports.** Until 2026-08-11 this
  paragraph said *"a datagram's first body word reaches `tx` one cycle after M15
  emits it"*, which is false of the octets: M07 inserts fourteen octets ahead of
  its payload, so the octets of M15's body word 0 leave M16 spread across `tx`
  words 1 and 2, at C + 3 and C + 4. A monitor may therefore **not** convert
  either cycle figure above into a per-octet latency, a front offset or an output
  offset. The composite *is* derivable from the children, and §13's 2026-08-11
  row derives it and records why it is deliberately not pinned here.

  Consequently M16 consumes **none** of requirements.md §1.1's allocation: the
  3 + 1 + 5 = 9 cycles allocated to `Eth_axis_rx`, `Eth_demux` and
  `Ip_eth_rx_64` are charged against 3 + 1 + 4 = 8 actually spent, with M14's
  one cycle of reserve (SPEC-M14 §7) the whole of the difference and M16 adding
  0. A future revision of M16 that added a register would change that and would
  be a spec diff to this section plus a §1.1 re-allocation, which is the point of
  stating a zero rather than leaving the row out (SPEC-M05 §7's rule).

- **Throughput.** One word per cycle in each direction, set entirely by the
  children. M16 introduces no bubble and removes none.

- **Handshake rules.** Relayed unchanged, in both disciplines. `rx`,
  `ip_rx_payload` and `ip_rx_hdr` never carry a `tready` (REQ-003), and
  `ip_rx_hdr_valid` is a one-cycle pulse one cycle before its payload word
  (REQ-606, SPEC-M14 §7). `ip_tx_hdr_valid` is a **level** held until the frame's
  first payload word is accepted (ADR-0008), and `tx_tready` is M05's, whose
  idle tolerance stops at M04 (REQ-206, SPEC-M04 §7). **Both disciplines cross
  this module's ports**, in opposite directions, which is the clearest statement
  of why ADR-0008 makes the direction of a port decide: a monitor attached to
  M16 must take the discipline from the port, and the port names say which is
  which.

- **Reset.** `clear` reaches all seven children on the same cycle. Within one
  cycle of `clear` deasserting, M16's outputs are its children's outputs, which
  REQ-009 already constrains at each of them. M16 adds no reset behaviour of its
  own because it has no state to reset. One consequence worth naming: the ARP
  cache is emptied by the same `clear` (SPEC-M12 §7), so the first transmit
  datagram after a reset **misses** and is discarded with `error_arp_miss` — that
  is correct, is SPEC-M13 §7's own statement, and is what REQ-809's verification
  column means when it says the transmit direction primes the cache first.

- **Configuration sampling.** None here; §4.3.

## 8. Line-rate stress obligation

**Not applicable.** M16 is not in requirements.md §0.4's stress-bench list, and
§0.4's rule for structural wrappers applies exactly: *"Structural wrappers M05,
M16 and M19 are covered by their children's benches unless the wrapper
introduces datapath logic of its own, in which case it joins this list by a spec
diff."* M16 introduces none — §6.1's wiring tables are total and §6.3 leaves no
room for any — so the benches that cover M16's receive path are M06's, M08's and
M14's REQ-004 stress runs (SPEC-M06 §8, SPEC-M08 §8, SPEC-M14 §8), and the bench
that covers its transmit path is M04's REQ-209 sustained run driven through
M15, M09 and M07 (SPEC-M15 §8 item 5).

The condition under which that changes is written down rather than implied: if a
later revision puts a register, a mux or a counter between M16's ports and its
children's, M16 joins §0.4's list by spec diff and owes its own bench.

**One obligation is M16's own**, because it is the first level at which it can be
run and no child's bench contains it: **REQ-807's loop, exercised at this
module's ports.** Drive `rx` with the frame stream a received ARP request
produces (the stimulus SPEC-M10 §8 derives, one frame rather than 10 000) and
assert that a well-formed ARP reply appears at `tx` — every ARP field per
REQ-502, the Ethernet header unicast to the requester, ethertype 0x0806 — within
the cycle count SPEC-M13 §6.1 derives, measured at M16's ports rather than at
XGMII. That run is a *precondition* for REQ-807's system-level test at M20 and
not a substitute for it: the FCS, the preamble and the inter-frame gap are M04's
and are not visible here (§10).

## 9. Errors and discards

**Not applicable as a detection table.** M16 detects no condition: it forwards no
frame of its own, holds none in flight, and has no logic that could observe one.
The twelve strobes it exposes are its children's, relayed unchanged.

| Condition | Strobe (one cycle) | Stream effect | REQ |
|---|---|---|---|
| (none detected here — the twelve strobes below are relayed, not raised) | `error_short_frame` (M06); `error_unknown_ethertype` (M08); `error_arp_unsupported`, `error_arp_miss`, `error_arp_reply_dropped` (M13); `error_ip_bad_header`, `error_ip_bad_checksum`, `error_ip_fragment`, `error_ip_not_for_us`, `error_ip_truncated`, `error_ip_bad_protocol`, `error_ip_oversize` (M14) | none: M16 alters no stream | REQ-402, REQ-404, REQ-501, REQ-505, REQ-510, REQ-601 … REQ-607, REQ-612 |

Co-occurrence, precedence and multiplicity (requirements.md §0.6) are its
children's and are stated in each child's §9. M16 has no instance of §0.6's "a
module SHALL NOT re-report an inherited abort" either — relaying a strobe on a
wire is not re-reporting it, because M16 raises nothing: the pulse that leaves
M16 **is** the pulse its child raised, one cycle wide, on the same cycle
(SPEC-M05 §9's rule).

**Two conservation facts a monitor attached here needs.**

1. **Frames presented at `rx` are conserved against three things, not one**:
   frames emitted at `ip_rx_payload`, header-record pulses with no payload frame
   (requirements.md §0.7), and the discard strobes above. A frame routed to the
   ARP branch is *not* emitted at `ip_rx_payload` at all and is accounted for
   inside M13 (SPEC-M10 §8's criterion 1, computed at M13's `rx_` ports) — so a
   conservation monitor at M16's ports must count the ARP branch separately or it
   will report every ARP frame as a silent discard. This is the first wrapper in
   the programme whose receive path **forks**, and it is why the statement is
   here rather than left to §0.6's general form.
2. **`error_arp_miss` pairs with a transmit-side discard at M15, not with a
   receive-side one** (SPEC-M15 §9, SPEC-M15 §11.4). Both modules are inside
   M16, so at this level the pairing is observable in one scope for the first
   time: one `error_arp_miss` high cycle for each datagram offered at
   `ip_tx_hdr` that produces no frame at `tx`.

REQ-008's prohibition on silent discard is not weakened: every condition
detectable inside this subsystem is detected by a child and reported by a strobe
M16 exposes.

## 10. REQ coverage

| REQ | How this module satisfies it | Section | Verification hook for DV |
|---|---|---|---|
| REQ-001 | one clock, fanned to all seven children | §6.1 | the emitted-Verilog edge-expression check |
| REQ-003 | `rx`, `ip_rx_payload` and `ip_rx_hdr` are `Source`/record with no `Dest`; the two `Dest` records present are on transmit ports §0.4 excludes | §4.1 | interface compile check |
| REQ-005 | adds zero octet times in both directions | §7 | the per-octet latency measurements in M06's, M08's and M14's benches, taken at M16's ports: identical values |
| REQ-007, REQ-013 | `tuser`[0] relayed untouched in both directions | §3, §6.1 | error injection at M03, observed at M16's `ip_rx_payload` |
| REQ-008 | twelve strobes relayed; none suppressed; the two conservation facts of §9 stated | §9 | frame conservation at M16's ports, counting the ARP fork separately |
| REQ-009 | `clear` fanned; no state of its own; the emptied ARP cache makes the first post-reset datagram miss | §7 | the reset tests of the seven children, run through M16 |
| REQ-010 | every stream port uses the programme types; both `Ip_header` ports are SPEC-M01's | §4.1 | interface compile check |
| REQ-019 | ΔC = 0 added; the receive chain across M16 is 3 + 1 + 4 = 8 cycles against 3 + 1 + 5 = 9 allocated | §7 | the §1.1 arithmetic at freeze; the measured chain figure in the sign-off packet |
| REQ-020 | nothing reorders; M09's arbitration is frame-atomic and is inside M16 | §3, §6.1 | REQ-020's sequence-number run, end to end |
| REQ-406 | no instance of its own: M09 arbitrates **inside** M16, which is why M16 exposes one transmit stream | §2, §6.1 | none — stated so that no sign-off packet claims arbitration coverage at this level; SPEC-M09 §8 owns it |
| REQ-505 | no instance of its own: the discard is M15's and the strobe is M13's, and M16 is the first level at which both are in one scope (§9) | §9 | the pairing assertion of §9 fact 2 |
| REQ-807 (structural half) | the whole ARP request-to-reply path lies inside M16 — `rx` → M06 → M08 → M13 → M09 → M07 → `tx` — so nothing above this module participates in it and a break localises here | §3, §6.1, §8 | §8's loop run at M16's ports: an ARP request in at `rx`, a well-formed reply out at `tx`. **The observable half is M20's**: the preamble, the FCS and the inter-frame gap REQ-807 also names are M04's and are not visible at this module's ports, so no sign-off packet may cite this run as full REQ-807 coverage |
| REQ-808 | `ip_complete_64` is a distinct emitted module containing all seven children | §4.1, §6.1 | the `rtl_snapshots/` module-name comparison and the instance hierarchy |
| REQ-903 | `.mli` plus a `hierarchical` entry point taking a `Scope.t` | §4.1 | repository surface check at `P1-module-ready` |

This table is the source of M16's rows in [`traceability.md`](../traceability.md),
updated in the same commit.

## 11. Deferred items

Item numbers are permanent; a closed item keeps its row (SPEC-TEMPLATE §11).

| # | Item | Status · what a reader assumes meanwhile | Tracked as | Owner | Closes by |
|---|---|---|---|---|---|
| 11.1 | **The `ifc_check` compile evidence for this lift is pending**: `ip_complete_64_ifc.ml` is new in this commit and is the widest port record in the programme so far — twelve strobes and seven configuration scalars. | **CLOSED (WO-0018/WO-0019).** CI `build` run **30739442056** at **3f6accc** reports `success` with this lift in it, and the run's head SHA **is** this specification's commit. The widest record in the batch elaborated on its first attempt, three optional parameters and all. | the `Interface compile check` row of §12 | architect_docs_lead, rtl_lead | closed |
| 11.2 | **Twelve strobes as twelve scalars**, which SPEC-M05 §11.1 raised at six and which recurs here at twice the width; M19 and M20 will carry more still. | **CLOSED (WO-0019): batch F kept the convention and no partial record was adopted.** SPEC-M19 §4.1 carries **fifteen** strobe scalars (this module's twelve plus M17's two and M18's one) and SPEC-M20 §4.1 is where the twenty-one become a record — one `status` port carrying SPEC-M01's `Status`, assembled once, at the only level at which the enumeration is complete (REQ-804). So the rule across the programme is: **strobes travel as named scalars and are aggregated exactly once, at M20**, which is the answer SPEC-M05 §11.1 gave at six and this row gave at twelve. No strobe is renamed anywhere, and `tools/check_records_vs_appendix.sh` already checks `Status`'s field list against requirements.md §12 in both name and order. | SPEC-M05 §11.1; SPEC-M19 §4.1; SPEC-M20 §4.1 | architect_docs_lead | closed |
| 11.3 | **The configuration fan-out crosses three wrapper levels and architecture.md §6.4.3 enumerates only the top-level source and the reading module**, not the hop through M19 and M16. §6.4's summary rule now says so explicitly, but the rows themselves still read `M20.cfg_* → M13.cfg_*`. | **CLOSED (WO-0019).** SPEC-M19 §6.1 and SPEC-M20 §6.1 state their own hops in their own wiring tables, exactly as this specification's §6.1 does, so every hop of every configuration field is now written down at the module that performs it even though architecture.md §6.4.3 still tabulates source-and-reader pairs. The convention is stated in §6.4 and the hops are computable from §4's containment; a renderer that wants them enumerated gets a §6.4.3 expansion of about thirty rows and no port, type or module changes. Batch F added exactly one `cfg_` row to §6.4.3 — `M20.cfg_tx_enable → M18.cfg_tx_enable`, SPEC-M18 §4.3 — and renamed none. | architecture.md §6.4; SPEC-M14 §11.4; SPEC-M19 §6.1; SPEC-M20 §6.1 | architect_docs_lead | closed |
| 11.4 | **REQ-807 is covered in two halves by two modules** — the structural loop here, the XGMII-level observable at M20 — and requirements.md states it as one requirement whose verification column is a system-level test. | **CLOSED (WO-0019): the second side exists and the two halves tile.** SPEC-M20 §8 owns REQ-807's **XGMII-level observable** — the preamble, every ARP field per REQ-502, a valid FCS and a conforming inter-frame gap, decoded at `xgmii_tx` — and SPEC-M20 §10's REQ-807 row disclaims the structural half in the same words this specification uses to disclaim the observable one ("the loop is closed inside M16 and is claimed there, not here"). `traceability.md`'s REQ-807 row names a written specification and a section on both sides with no `pending` cell. A reader still runs §8's loop at M16's ports and still does not claim REQ-807 coverage from it. | `traceability.md` REQ-807; SPEC-M20 §8, §10; SPEC-M12 §11.3's pattern | architect_docs_lead, dv_lead | closed |

## 12. Freeze record

Filled in at `P1-spec-freeze`. All four rows are required (charter §5).

| Item | Value |
|---|---|
| Interface compile check | CI `build` run **30739442056**, conclusion **`success`**, SHA **3f6accc** — every lift in the single `ifc_check` library elaborates, this one the widest record of the batch (twelve strobes, seven configuration scalars, three optional parameters on both entry points); per ADR-0005 a local build is not acceptable evidence. **The run's head SHA is the specification commit**, so no witnessing argument is owed. This run is also §11.1's closure record |
| Architect signature | `J-architect_docs_lead-0007`; the C-29 diff of §13 `J-architect_docs_lead-0008` |
| dv_lead testability countersignature | **`J-dv_lead-0009`** (WO-0018) — batch E **COUNTERSIGNED at 3f6accc**, this specification **SIGNED**: §6.1's wiring table checked total in both directions with no orphan either way, the twelve relayed strobes verified against requirements.md §12's owner column, the receive chain 3 + 1 + 4 = 8 confirmed against 3 + 1 + 5 = 9 allocated, and REQ-807's loop confirmed closed inside this module. Carry-forward **C-29** was raised against §7's transmit anchor and is repaired in §13 below |
| Frozen at | SHA **3f6accc**, gate `docs/gates/P1-spec-freeze-checklist.md` |

## 13. Change log

Post-freeze changes only. Each row cites the ADR that authorised it; a breaking
interface change is counted against post-freeze churn (charter §6). **No row
below is breaking**: §4.1's record is byte-for-byte unchanged since the freeze
SHA, so the `ifc_check` evidence of §12 still witnesses this revision's
interface, and `tools/check_records_vs_appendix.sh` re-passes on this commit.

| Date | Change | Breaking? | ADR | Journal |
|---|---|---|---|---|
| 2026-08-02 | §7's transmit-chain figure re-anchored: `tx` carries a datagram's first body word **one** cycle after M15 emits it and **two** cycles after M15 accepts the frame's first payload word, with the three children's constants written out cycle by cycle and both readings named so a monitor can be built from either (ledger **C-29**) | no | none — the three constants (M15's 1, M09's 0, M07's 1) are unchanged and correct; only the event they were summed from was wrong, and a §7-built monitor would have asserted 2 where it observes 1 | `J-architect_docs_lead-0008` |
| 2026-08-11 | **§7's transmit paragraph: the word-transit reading struck, the three composed figures named as event delays, and the composite per-octet constant derived here but deliberately not pinned.** The paragraph claimed *"a datagram's first body word reaches `tx` one cycle after M15 emits it"* — true of the **events** (M15's body word 0 at C + 1, M16's first `tx` word at C + 2) and **false of the octets**: M07 inserts fourteen octets ahead of its payload (SPEC-M07 §6.1), so the octets of M15's body word 0 leave as `tx` words 1 and 2, at C + 3 and C + 4. Both composed 1-cycle figures are pinned to words their own modules *inserted* and are therefore event delays, which requirements.md §0.5's inserting-module clause distinguishes from latencies and which SPEC-M15 §7 and SPEC-M07 §7 now each name explicitly; the wrapper's paragraph had inherited the pre-`C-RL-8` reading in which a module had one constant. **The composite, derived from the children and stated so this finding is checkable at its own site**: per-octet latency is additive along a chain, so from M16's transmit payload port to `tx` it is L = 28 (M15) + 22 (M07) = **50** octet times with h = **0**; the chain inserts 20 + 14 = **34** octets ahead of the frame, so its output offset is 34 mod 8 = **2** and ΔC = (50 + 0 − 2)/8 = **6** — the frame's first octet is at position 2 of `tx` word 4, at C + 6. **Not pinned in §7**, because under §0.5's default (*"a specification stating no q is stating q = 0"*) a wrapper that states nothing is read as q = 0, which at this module is false and would make the composite fail §0.5's whole-number test (50/8 is not an integer) — a freeze-time check convicting a conformant wrapper, the `C-RL-8` shape one level up. That default is under `FINDING Q-3` (requirements.md §13's 2026-08-11 row, architect_docs_lead); a wrapper's transmit constants are pinned in the round that rules it, not in the round that finds it. **No cycle, no child figure and no receive-side constant moves**: §7's receive chain (8 cycles, front offset 34) is untouched, and the two transmit cycle figures are unchanged in value and only renamed | no — **editorial**: one false sentence struck, three figures renamed to the quantity they always were, nothing pinned and nothing built here (M16 has no RTL and no bench names it) | none — a false reading of the octets is corrected rather than chosen among live alternatives; requirements.md §13's 2026-08-11 `C-RL-8` row carries the ruling the renaming follows | `J-architect_docs_lead-0042` |
