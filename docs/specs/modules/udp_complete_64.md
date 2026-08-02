# SPEC-M19 — `Udp_complete_64`

- **Status**: **FROZEN** (`P1-spec-freeze`, SHA `d8df28d`) — batch F, dv_lead
  countersignature `J-dv_lead-0011` (WO-0022), **SIGNED** with every number
  re-derived. Changes to §4, §6 or §7 after this point are spec diffs recorded
  in §13 (SPEC-TEMPLATE rule 7)
- **Inventory id**: M19 (architecture.md §4) · **Path**:
  `libs/hardcaml_ethernet/src/udp_complete_64.ml`
- **Datapath role**: shared/structural (receive-path module **with respect to its
  receive ports only**, requirements.md §0.4)
- **Owns REQs**: REQ-808 at this level, and the **application-boundary half** of
  REQ-708 — M19 is the first module whose ports carry the application receive
  stream, so it is where that stream's line rate can be measured without an
  XGMII driver; the end-to-end half is M20's (§10)
- **Prior-art counterpart**: `udp_complete_64.v` (MIT), with `udp_64.v` folded in
  (architecture.md §5) — consulted for decomposition and port naming only;
  behaviour below is stated independently and no source was copied
- **Depends on specs**: SPEC-M01 (`Axi64`, `Udp_header`), SPEC-M16
  (`Ip_complete_64`), SPEC-M17 (`Udp_ip_rx_64`), SPEC-M18 (`Udp_ip_tx_64`, which
  declares `Udp_tx_request`)
- **Author**: architect_docs_lead, journal `J-architect_docs_lead-0008`

## 1. Purpose

M19 is the whole protocol stack below the application: it binds the
IPv4-with-ARP subsystem (M16), the UDP receiver (M17) and the UDP transmitter
(M18) into one module whose ports are a frame stream in, a frame stream out, the
application receive pair, the application transmit request-and-payload pair with
its `Dest`, and the fifteen strobes its children raise. It exists as a separate
module because that set is exactly what "UDP over IPv4 over Ethernet" means:
everything inside it is required for an application datagram to reach the wire,
and nothing inside it knows what XGMII is.

Its receive port chain is M05 → **M19** → M20 and its transmit port chain is
M20 → **M19** → M05 (architecture.md §6.4). It contains **no datapath logic**:
every octet it carries is carried by a child, and §6.1's wiring table is total.

## 2. Scope

**In scope.**

- Instantiating M16, M17 and M18 exactly once each and wiring them as §6.1's
  table states, with no logic between any pair of ports.
- Presenting the frame stream in and out, the application receive
  header-and-payload pair, the application transmit request-and-payload pair with
  its `Dest`, and the fifteen strobes its children raise, all unchanged.
- Fanning the ten configuration scalars its children read out to M16, M17 and
  M18 (§4.3).
- Being the module at which the **application boundary** first exists as a set of
  ports (REQ-707, REQ-708, REQ-805): everything above M19 relays it, and
  everything below it is protocol.
- Being the module named `udp_complete_64` in the emitted hierarchy (REQ-808).

**Not this module's job.**

| Behaviour a reader might expect here | Owner |
|---|---|
| Any decode, encode, checksum, filtering, resolution, length check or realignment | M16's seven children, M17 and M18 in their own specifications. M19 adds no logic and detects no condition |
| The MAC, the FCS, the preamble, XGMII, the inter-frame gap | M05, M03 and M04 (REQ-101 … REQ-210). M19's frame ports carry destination address through payload, FCS already stripped or not yet added |
| Aggregating strobes into a `Status` record, or declaring `Config` | M20 `Nic_top` (REQ-802, REQ-804). M19 forwards fifteen individual scalars and reads ten, in SPEC-M01 §4.2's convention; the two records appear at exactly one port each in the whole programme, and both are M20's |
| Deciding what the application may send, or when | the application, bounded by REQ-705's contract and by `cfg_tx_enable` at M18 (SPEC-M18 §4.3). M19 relays the request and adds no rule |
| A second application client, a UDP port demultiplexer, a UDP mux | **nobody** — architecture.md §5 folds `udp_mux.v` and `udp_demux.v` away because Phase 1 has one client. Port filtering is a comparison inside M17 (REQ-704) |
| Measuring REQ-006's end-to-end latency | M20 (REQ-006, REQ-806). M19's receive ports carry no XGMII event, so REQ-006's first measurement event is not visible here; §7 states M19's own contribution to the sum and nothing more |

## 3. Programme invariants that bind this module

Per requirements.md §0.4, M19 is a receive-path module **with respect to the
ports on that chain** — its `rx` input and its `app_rx_hdr` / `app_rx_payload`
outputs — and is bound by every receive-path requirement on those ports only. Its
transmit ports are not receive-path ports, and the `Axi64.Dest` it exposes there
does not violate REQ-003; requirements.md §0.4 names this module explicitly when
it makes that point.

| REQ | Consequence for M19 |
|---|---|
| REQ-001 | One `clock`, fanned to all three children. |
| REQ-002 | Every frame-carrying port is a 64-bit `Axi64` stream. |
| REQ-003 | The receive ports are `Axi64.Source` with no `Dest` (§4.1). The two `Dest` records present belong to the transmit chain, which §0.4 excludes by name for this module. |
| REQ-004 | M19 is **not** in §0.4's stress-bench list: it is a structural wrapper covered by its children's benches, and it introduces no datapath logic that would put it on the list by spec diff (§8). |
| REQ-005 | M19 adds **zero** octet times. Its receive-port latency constants *are* its children's, unchanged (§7). |
| REQ-007, REQ-013 | `tuser`[0] passes through untouched in both directions. M19 consumes it nowhere; the ultimate consumer on the UDP receive branch is the **application**, one port above (REQ-707, ADR-0009). |
| REQ-008 | M19 detects no condition and raises no strobe of its own; it forwards its children's fifteen (§9). |
| REQ-009 | `clear` is fanned to all three children; M19 holds no state for it to act on. It is also the ADR-0011 recovery path for an under-delivered transmit frame, which reaches M18 through this fan-out like any other `clear`. |
| REQ-010 | Every stream port uses the programme stream types; the application receive header port uses SPEC-M01's `Udp_header` and the transmit request port uses SPEC-M18's `Udp_tx_request`. M19 declares no record. |
| REQ-015, REQ-016, REQ-021 | Bind the relayed streams and are satisfied by relaying: M19 changes no `tkeep`, no octet order, no `tlast` and no alignment, and inserts no idle cycle. |
| REQ-017, REQ-018 | No instance: M19 sees nothing at or below XGMII — M05 is its sibling under M20 and owns that boundary. |
| REQ-019 | M19's receive-port word delay is ΔC = 0 on top of M16's 8 and M17's 2, so the chain figure charged against requirements.md §1.1 is its children's alone: **10** cycles from M19's `rx` to its `app_rx_payload`, which is (3 + 1 + 4) + 2 and is what §1.1's rows for those four stages allocate (3 + 1 + 5) + 4 = 13 to. M19 holds no payload storage at all. |
| REQ-020 | Order is preserved because nothing here reorders: the wiring is one-to-one and the one place two orders merge — M09's arbitration — is inside M16, one level down (REQ-406). |
| REQ-707, REQ-805 | The application receive stream leaves this module as `Axi64.Source` with no `Dest`, which is where REQ-805's obligation on the Phase-2 consumer becomes structural. M19 relays it and claims **no part** of REQ-707, which is M17's whole (SPEC-M17 §5). |
| REQ-708 | The application boundary exists at M19's ports, so the **application-boundary half** of REQ-708 is measurable here: §8 states the run. The **end-to-end half** — the same datagrams driven from XGMII at REQ-004's arrival rate — is M20's, and §10 disclaims it. |
| REQ-808 | `udp_complete_64` SHALL appear as a distinct module in the emitted Verilog with all three children instantiated inside it (architecture.md §6.3). |

## 4. Interface

### 4.1 Interface records

```ocaml
(* SPEC-M19 §4.1, lifted verbatim into
   docs/specs/ifc_check/udp_complete_64_ifc.ml (SPEC-TEMPLATE.md rule 6).
   Records and signatures only — no logic, no implementation.

   [Axi64_ifc] is M01's types home (SPEC-M01 §4.1): [Axi64] and
   [Udp_header] come from there. [Udp_ip_tx_64_ifc] is where SPEC-M18
   §4.1 declares [Udp_tx_request], because M01 is FROZEN at f78766e and a
   record added there would be a breaking post-freeze interface change;
   the declare-once rule batch D adopted is that such a record is declared
   at the module that owns it and OPENED by every counterpart (SPEC-M10
   §4.1, §11.2; SPEC-M15 §4.1 is its first cross-batch instance). Opening
   [Udp_ip_tx_64_ifc] does not re-export what THAT file opened, so
   [Axi64_ifc] is opened here too; there is no cycle, because M18's lift
   references nothing of M19's.

   M19 restates nothing from SPEC-M16 or SPEC-M17 either: its ports are a
   subset of theirs, and the only thing this record adds is that three
   children share one clock, one clear and one configuration fan-out.
   M19 does NOT open [Ip_complete_64_ifc] or [Udp_ip_rx_64_ifc], because
   no record of theirs appears at ITS ports — the IPv4 header pair between
   M16 and M17, and the IPv4 pair between M18 and M16, are internal
   signals of M19's hierarchy (§6.1), exactly as M13's and M16's own
   children's edges are internal to them (architecture.md §6.4). A lift
   that opened a module it does not use would compile and would still be
   a lie about the dependency (SPEC-M12 §4.1's rule).

   [rx], [app_rx_hdr] and [app_rx_payload] are the receive ports:
   [Source] with no [Dest] anywhere for them, REQ-003 structurally,
   inherited from M16 and M17 — and at [app_rx_payload] this is also
   REQ-707 and REQ-805. [app_tx_*] and [tx] are the transmit chain,
   [Source] one way and [Dest] the other, as in SPEC-M16 and SPEC-M18. *)

open! Base
open Hardcaml
open! Axi64_ifc
open! Udp_ip_tx_64_ifc

module I = struct
  type 'a t =
    { clock : 'a
    ; clear : 'a
    ; rx : 'a Axi64.Source.t [@rtlprefix "rx_"]
    ; app_tx_request : 'a Udp_tx_request.t [@rtlprefix "app_tx_request_"]
    ; app_tx_payload : 'a Axi64.Source.t [@rtlprefix "app_tx_payload_"]
    ; tx_dest : 'a Axi64.Dest.t [@rtlprefix "tx_"]
    ; cfg_local_mac : 'a [@bits 48]
    ; cfg_local_ip : 'a [@bits 32]
    ; cfg_subnet_mask : 'a [@bits 32]
    ; cfg_gateway_ip : 'a [@bits 32]
    ; cfg_multicast_group : 'a [@bits 32]
    ; cfg_multicast_enable : 'a
    ; cfg_listen_port : 'a [@bits 16]
    ; cfg_accept_all_ports : 'a
    ; cfg_ttl : 'a [@bits 8]
    ; cfg_tx_enable : 'a
    }
  [@@deriving hardcaml]
end

module O = struct
  type 'a t =
    { app_rx_hdr : 'a Udp_header.t [@rtlprefix "app_rx_hdr_"]
    ; app_rx_payload : 'a Axi64.Source.t [@rtlprefix "app_rx_payload_"]
    ; app_tx_payload_dest : 'a Axi64.Dest.t [@rtlprefix "app_tx_payload_"]
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
    ; error_udp_bad_length : 'a
    ; error_udp_port : 'a
    ; error_tx_length_mismatch : 'a
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
  `clear`, `cfg_multicast_enable`, `cfg_accept_all_ports`, `cfg_tx_enable` and
  the fifteen strobes are one bit; the four `cfg_` addresses, `cfg_local_mac`,
  `cfg_listen_port` and `cfg_ttl` carry their widths.
- Nested interfaces carry `[@rtlprefix]`, and each transmit stream's two
  directions share its prefix with no collision, because `Source`'s field names
  and `Dest`'s are disjoint (SPEC-M04 §4.1 fixes that pattern):
  `app_tx_payload_tvalid` … beside `app_tx_payload_tready`, and `tx_tvalid` …
  beside `tx_tready`.
- **Receive-path `Source` without `Dest`: held** on `rx`, `app_rx_payload` and
  the `Udp_header` output. The two `Dest` records present belong to the transmit
  chain, which requirements.md §0.4 excludes from the receive path by name for
  exactly this module.
- Both `create` and `hierarchical` are declared (REQ-903, REQ-808), each taking
  the three REQ-506 parameters, which M19 **forwards to its M16 instance and
  reads for nothing itself** (§5).
- No field-name witness is repeated here: SPEC-M17's lift names `Udp_header`'s
  five fields, SPEC-M14's names `Ip_header`'s seven and SPEC-M06's names
  `Eth_header`'s four, which settles them once. A second copy would add nothing
  a compile could fail on — the reasoning SPEC-M05 §4.1 and SPEC-M16 §4.1 state
  for the same omission.

### 4.2 Port table

Every port in §4.1 appears exactly once. Direction is with respect to M19.

| Port | Dir | Width | Meaning | REQ |
|---|---|---|---|---|
| `clock` | in | 1 | 156.25 MHz single domain, fanned to all three children | REQ-001 |
| `clear` | in | 1 | synchronous clear, fanned to all three children | REQ-009 |
| `rx_tvalid` … `rx_tuser` | in | 1/64/8/8/1/1 | received frame stream from M05, to M16 unchanged | REQ-010 |
| `app_tx_request_valid` … `app_tx_request_payload_length` | in | 1/32/16/16/16 | the application's transmit request from M20, to M18 unchanged; `valid` is a level held until the frame's first payload word is accepted (ADR-0008) | REQ-705, ADR-0008 |
| `app_tx_payload_tvalid` … `app_tx_payload_tuser` | in | 1/64/8/8/1/1 | application transmit payload stream from M20, to M18 unchanged | REQ-010 |
| `tx_tready` | in | 1 | from M05, to M16 unchanged | REQ-207 |
| `cfg_local_mac` | in | 48 | to M16 | REQ-802 |
| `cfg_local_ip` | in | 32 | to M16 | REQ-802 |
| `cfg_subnet_mask` | in | 32 | to M16 | REQ-802 |
| `cfg_gateway_ip` | in | 32 | to M16 | REQ-802 |
| `cfg_multicast_group` | in | 32 | to M16 | REQ-802 |
| `cfg_multicast_enable` | in | 1 | to M16 | REQ-802 |
| `cfg_listen_port` | in | 16 | to M17 | REQ-802 |
| `cfg_accept_all_ports` | in | 1 | to M17 | REQ-802 |
| `cfg_ttl` | in | 8 | to M16 | REQ-802 |
| `cfg_tx_enable` | in | 1 | to M18 (SPEC-M18 §4.3's added edge). **Not** to M05: M04's copy of the same field is routed directly from M20 (architecture.md §6.4.3), and the two readers are on different branches of the hierarchy | REQ-810, REQ-802 |
| `app_rx_hdr_valid` … `app_rx_hdr_checksum` | out | 1/16/16/16/16 | UDP header record from M17, to M20 unchanged; `valid` is a one-cycle pulse, one cycle before the first application word (REQ-701, SPEC-M17 §7) | REQ-701 |
| `app_rx_payload_tvalid` … `app_rx_payload_tuser` | out | 1/64/8/8/1/1 | application receive stream from M17, to M20 unchanged. **No `Dest`** — REQ-707, REQ-805 | REQ-707 |
| `app_tx_payload_tready` | out | 1 | from M18, to M20 unchanged | REQ-207, REQ-810 |
| `tx_tvalid` … `tx_tuser` | out | 1/64/8/8/1/1 | frame stream from M16, to M05 unchanged | REQ-010 |
| `error_short_frame`, `error_unknown_ethertype`, `error_arp_unsupported`, `error_arp_miss`, `error_arp_reply_dropped`, `error_ip_bad_header`, `error_ip_bad_checksum`, `error_ip_fragment`, `error_ip_not_for_us`, `error_ip_truncated`, `error_ip_bad_protocol`, `error_ip_oversize` | out | 1 each | from M16, unchanged (which relays M06's, M08's, M13's three and M14's seven) | REQ-402, REQ-404, REQ-501, REQ-505, REQ-510, REQ-601 … REQ-607, REQ-612 |
| `error_udp_bad_length`, `error_udp_port` | out | 1 each | from M17, unchanged | REQ-703, REQ-704 |
| `error_tx_length_mismatch` | out | 1 | from M18, unchanged | REQ-709, REQ-710 |

### 4.3 Configuration inputs

Ten fields, all pass-through, each as the scalar `cfg_<field>` input of SPEC-M01
§4.2's convention. M19 samples none of them itself and holds no register, so
REQ-803's "when a change takes effect" is answered entirely by SPEC-M13 §4.3,
SPEC-M14 §4.3, SPEC-M15 §4.3, SPEC-M17 §4.3 and SPEC-M18 §4.3 and is **not**
restated here — restating it would create a second place for it to drift, which
is the reasoning SPEC-M05 §4.3 and SPEC-M16 §4.3 give for the same omission.

| Field | Fanned to | Governing sampling rule |
|---|---|---|
| `cfg_local_mac` | M16 (→ M13, M15) | SPEC-M13 §4.3; SPEC-M15 §4.3 |
| `cfg_local_ip` | M16 (→ M13, M14, M15) | SPEC-M13 §4.3; SPEC-M14 §4.3; SPEC-M15 §4.3 |
| `cfg_subnet_mask` | M16 (→ M13, M14) | SPEC-M13 §4.3; SPEC-M14 §4.3 |
| `cfg_gateway_ip` | M16 (→ M13) | SPEC-M13 §4.3 |
| `cfg_multicast_group` | M16 (→ M14) | SPEC-M14 §4.3 |
| `cfg_multicast_enable` | M16 (→ M14) | SPEC-M14 §4.3 |
| `cfg_ttl` | M16 (→ M15) | SPEC-M15 §4.3 |
| `cfg_listen_port` | M17 | SPEC-M17 §4.3 |
| `cfg_accept_all_ports` | M17 | SPEC-M17 §4.3 |
| `cfg_tx_enable` | M18 | SPEC-M18 §4.3 |

**This is the second wrapper hop of the configuration fan-out and it is written
down here** (SPEC-M14 §11.4, SPEC-M16 §11.3). architecture.md §6.4.3 tabulates
`cfg_` edges as source-and-reader pairs — `M20.cfg_local_ip → M14.cfg_local_ip` —
and the intermediate hops are computed from §4's containment, the same summary
§6.4.4 applies to strobes. The table above is M19's hop, stated explicitly so
that the computation is checkable rather than merely possible; SPEC-M16 §6.1
states M16's and SPEC-M20 §6.1 states M20's, and between the three every hop of
every configuration field is now written at the module that performs it.

One field is **not** in the table and its absence is deliberate:
`cfg_rx_enable` and `cfg_ifg` reach M03 and M04 through M05, not through M19, and
`cfg_tx_enable` reaches **both** M04 (through M05) and M18 (through here). A
reader wiring M20 takes the fan-out from SPEC-M20 §4.3, which is the one place
both branches appear together.

## 5. Parameters

| Parameter | Type | Default | Range | Why a test overrides it |
|---|---|---|---|---|
| `retry_count` | `int` | **4** | 0 to 15 | REQ-506 requires it; M19 forwards it to its M16 instance, which forwards it to M13 (SPEC-M16 §5, SPEC-M13 §5), and reads it for nothing itself |
| `retry_interval_cycles` | `int` | **156 250 000** (1.0 s) | 1 to 2^32 − 1 | the same; any ARP run reached through this wrapper needs short values |
| `entry_lifetime_cycles` | `int` | **3 125 000 000** (20 s) | 1 to 2^32 − 1 | the same; M13 forwards it again to M12 (SPEC-M12 §5) |

**M19 has no parameter of its own**, and these three exist here only so that a
bench instantiating the stack can reach M13's — and M12's — without reaching
inside the hierarchy. This is the **third** level they have been forwarded
through (M16, and M13 before it); the defaults are restated because a defaulted
optional argument must have one, the **normative** statement of each default and
range is SPEC-M13 §5, and a change to any of them is a spec diff at M13, M16, M19
and M20 together. Four copies of a default is the cost of reaching a leaf
parameter from the top without a configuration port, and it is recorded here so
that nobody mistakes the count for an accident.

## 6. Behaviour

### 6.1 Normal path

M19's behaviour is its wiring, and the wiring is total: every port of §4.2 is
connected to exactly one child port, and every child port is connected either to
an M19 port or to another child, with **no logic between**.

**Receive chain.**

| Source | Sink |
|---|---|
| M19 `rx` | M16 `rx` |
| M16 `ip_rx_hdr`, M16 `ip_rx_payload` | M17 `ip_hdr`, M17 `ip_payload` |
| M17 `hdr`, M17 `payload` | M19 `app_rx_hdr`, M19 `app_rx_payload` |

**Transmit chain.**

| Source | Sink |
|---|---|
| M19 `app_tx_request`, M19 `app_tx_payload` | M18 `request`, M18 `payload` |
| M18 `payload_dest` | M19 `app_tx_payload_dest` |
| M18 `ip_hdr`, M18 `ip_payload` | M16 `ip_tx_hdr`, M16 `ip_tx_payload` |
| M16 `ip_tx_payload_dest` | M18 `ip_payload_dest` |
| M16 `tx` | M19 `tx` |
| M19 `tx_dest` | M16 `tx_dest` |

**Configuration and clock.**

| Source | Sink |
|---|---|
| `clock`, `clear` | all three children |
| `cfg_local_mac`, `cfg_local_ip`, `cfg_subnet_mask`, `cfg_gateway_ip`, `cfg_multicast_group`, `cfg_multicast_enable`, `cfg_ttl` | M16 |
| `cfg_listen_port`, `cfg_accept_all_ports` | M17 |
| `cfg_tx_enable` | M18 |

**Strobes.** M16's twelve, M17's two and M18's one reach M19's fifteen
identically named outputs. Twelve plus two plus one is fifteen, and the six that
are missing from requirements.md §12's twenty-one are M03's five and M04's one,
which M05 relays on the other branch of M20's hierarchy (SPEC-M05 §9). **Fifteen
plus six is twenty-one**, and SPEC-M20 §9 is where that sum is asserted rather
than assumed.

**The receive path forks once inside this module and once inside M16, and a
conservation monitor needs both** (SPEC-M16 §9 fact 1 states the inner one). At
M19's ports, a frame presented at `rx` is accounted for by one of: an application
payload frame at `app_rx_payload`; an `app_rx_hdr` pulse with no payload frame
(requirements.md §0.7); a strobe among the fifteen; or **the ARP branch**, whose
frames are consumed inside M16 and never reach `app_rx_payload` at all. That
last term is the one a monitor most easily forgets, and it is why this paragraph
repeats SPEC-M16 §9's fact one level up rather than pointing at it: the fork is
two levels down from here and the symptom — every ARP frame reported as a silent
discard — appears at *this* module's ports.

No cycle-by-cycle table appears here because no sequencing exists to tabulate:
every octet's timing is its children's, and SPEC-M16 §7, SPEC-M17 §6.1 and
SPEC-M18 §6.1 carry the tables.

### 6.2 State machine

**Not applicable: M19 is purely structural.** It holds no register and has no
state, so it has no reset state and nothing happens to it on `clear` beyond the
fan-out of §6.1 — the same shape SPEC-M05 §6.2 and SPEC-M16 §6.2 state for the
wrappers below it. M19 is not a function of its inputs at all; it is a wiring
diagram.

### 6.3 Deliberately unconstrained

Anything not listed here is constrained by this specification.

1. **The instance names** M19 gives its three children (`hierarchical`'s
   `?instance` argument). The *module* names are normative — `ip_complete_64`,
   `udp_ip_rx_64`, `udp_ip_tx_64` (REQ-808) — and the instance labels are not.
2. **Whether M19 declares its own `.mli` re-exports** of the child modules'
   types. REQ-903 requires the `.mli`; what it re-exports is rtl_lead's.
3. **Nothing else.** A structural module with an unconstrained region larger than
   this is a module doing something it has not admitted to, and §6.1's wiring
   tables are deliberately total so that any additional logic is a visible diff
   against them — SPEC-M05 §6.3's rule, restated because the temptation to put a
   register between M16 and M17 "to help timing" is exactly the change that would
   move REQ-006's end-to-end figure without moving any module's own constant.

## 7. Timing contract

- **Latency.** **Zero octet times added, in both directions.** M19's receive-port
  constants are its children's exactly: from `rx` to `app_rx_payload` the chain is
  M16 (8 cycles, front offset 34 — itself M06's 3, M08's 1 and M14's 4) and M17
  (L = 8, h = 8, ΔC = 2), so the word delay across M19's receive ports is
  **10 cycles** and the front offset is **42 octets**. On the transmit side the
  chain is M18 (1 cycle), then M16's own transmit chain (M15's 1, M09's 0 and
  M07's 1, which SPEC-M16 §7 sums to two cycles from the acceptance of M15's
  first payload word). The measurement events are the children's; M19 introduces
  none of its own, because a wire is not a measurement event.

  Consequently M19 consumes **none** of requirements.md §1.1's allocation: the
  (3 + 1 + 5) + 4 = **13** cycles allocated to `Eth_axis_rx`, `Eth_demux`,
  `Ip_eth_rx_64` and `Udp_ip_rx_64` are charged against (3 + 1 + 4) + 2 = **10**
  actually spent, with M14's one cycle of reserve and M17's two the whole of the
  difference and M19 adding 0. A future revision of M19 that added a register
  would change that and would be a spec diff to this section plus a §1.1
  re-allocation, which is the point of stating a zero rather than leaving the row
  out (SPEC-M05 §7's rule, SPEC-M16 §7's restatement).

- **Throughput.** One word per cycle in each direction, set entirely by the
  children. M19 introduces no bubble and removes none.

- **Handshake rules.** Relayed unchanged, in both disciplines. `rx`,
  `app_rx_payload` and `app_rx_hdr` never carry a `tready` (REQ-003, REQ-707,
  REQ-805), and `app_rx_hdr_valid` is a one-cycle pulse one cycle before its
  payload word (REQ-701, SPEC-M17 §7). `app_tx_request_valid` is a **level** held
  by the application until the frame's first payload word is accepted (ADR-0008),
  and `tx_tready` is M05's, whose idle tolerance stops at M04 (REQ-206, SPEC-M04
  §7). **Both disciplines cross this module's ports**, in opposite directions,
  which is what ADR-0008 means when it says the direction of a port decides: a
  monitor attached to M19 takes the discipline from the port, and the port names
  say which is which. This is the same statement SPEC-M16 §7 makes one level
  down, and it is worth repeating here because at M19 the *transmit* level is
  carried by a `Udp_tx_request` rather than by a header record — the discipline
  is ADR-0008's all the same, and SPEC-M18 §7 states it at the port that owns it.

- **Reset.** `clear` reaches all three children on the same cycle. Within one
  cycle of `clear` deasserting, M19's outputs are its children's outputs, which
  REQ-009 already constrains at each of them. M19 adds no reset behaviour of its
  own because it has no state to reset. Two consequences worth naming: the ARP
  cache is emptied by the same `clear` (SPEC-M12 §7), so the first transmit
  datagram after a reset **misses** and is discarded with `error_arp_miss`
  (SPEC-M16 §7 says the same); and `clear` is the specified recovery from an
  under-delivered transmit frame (ADR-0011, SPEC-M18 §9), which reaches M18
  through this fan-out and requires nothing of M19.

- **Configuration sampling.** None here; §4.3.

## 8. Line-rate stress obligation

**Not applicable as a REQ-004 obligation.** M19 is not in requirements.md §0.4's
stress-bench list, and §0.4's rule for structural wrappers applies exactly:
*"Structural wrappers M05, M16 and M19 are covered by their children's benches
unless the wrapper introduces datapath logic of its own, in which case it joins
this list by a spec diff."* M19 introduces none — §6.1's wiring tables are total
and §6.3 leaves no room for any — so the benches that cover M19's receive path
are M06's, M08's, M14's and M17's REQ-004 stress runs, and the bench that covers
its transmit path is M04's REQ-209 sustained run driven through M18, M15, M09 and
M07 (SPEC-M15 §8 item 5, extended by one module).

The condition under which that changes is written down rather than implied: if a
later revision puts a register, a mux or a counter between M19's ports and its
children's, M19 joins §0.4's list by spec diff and owes its own bench.

**Two obligations are M19's own**, because this is the first level at which each
can be run and no child's bench contains either.

1. **REQ-708's application-boundary half, exercised at this module's ports.**
   Drive `rx` with the frame stream 10 000 minimum-length Ethernet frames produce
   at the REQ-004 arrival rate — each carrying an IPv4 datagram of total length
   46 and a UDP datagram of length 26, i.e. **18 octets of UDP payload**, with a
   32-bit sequence number in the first four (REQ-020) — and assert at
   `app_rx_hdr` and `app_rx_payload`: 10 000 header pulses each exactly one
   cycle; 10 000 payload frames of 18 octets in 3 words; every payload compared
   equal; the sequence numbers arriving 0, 1, 2, … with no gap and no repeat; and
   frame conservation over §6.1's four terms, the ARP-branch term being zero in
   this stimulus because every frame is IPv4. **The `clear` exemption of ledger
   C-2 applies to this monitor as it does at every module** (SPEC-M17 §8
   criterion 1), and is not exercised by this run.

   **This run is a *precondition* for REQ-708's system-level test at M20 and not
   a substitute for it** (§10). What it cannot show is that the frames arrive at
   `rx` at REQ-004's rate in the first place: at M19's ports the stimulus is a
   stream a bench constructs, and only at M20 is it XGMII driven by the
   link-partner model at the alternating 10-and-11-cycle spacing REQ-004
   actually specifies. The two runs use the same payloads on purpose, so a
   divergence between them localises to M05 or to the driver.
2. **The transmit direction end to end below XGMII**: offer 1 000 application
   datagrams of 18 octets each to a destination already in the ARP cache and
   assert that 1 000 well-formed frames appear at `tx` — Ethernet header, IPv4
   header with correct total length and checksum, UDP header with length 26 and
   checksum 0x0000, and the payload — with `app_tx_payload_tready` following
   §7's cadence. This is the first level at which the whole transmit stack is in
   one scope, and it is where SPEC-M18 §8 item 1's invariance test and SPEC-M15
   §8 item 1's header walk compose into one observable.

## 9. Errors and discards

**Not applicable as a detection table.** M19 detects no condition: it forwards no
frame of its own, holds none in flight, and has no logic that could observe one.
The fifteen strobes it exposes are its children's, relayed unchanged.

| Condition | Strobe (one cycle) | Stream effect | REQ |
|---|---|---|---|
| (none detected here — the fifteen strobes below are relayed, not raised) | M16's twelve (`error_short_frame`, `error_unknown_ethertype`, `error_arp_unsupported`, `error_arp_miss`, `error_arp_reply_dropped`, `error_ip_bad_header`, `error_ip_bad_checksum`, `error_ip_fragment`, `error_ip_not_for_us`, `error_ip_truncated`, `error_ip_bad_protocol`, `error_ip_oversize`); M17's two (`error_udp_bad_length`, `error_udp_port`); M18's one (`error_tx_length_mismatch`) | none: M19 alters no stream | REQ-402, REQ-404, REQ-501, REQ-505, REQ-510, REQ-601 … REQ-607, REQ-612, REQ-703, REQ-704, REQ-709, REQ-710 |

Co-occurrence, precedence and multiplicity (requirements.md §0.6) are its
children's and are stated in each child's §9. M19 has no instance of §0.6's "a
module SHALL NOT re-report an inherited abort" either — relaying a strobe on a
wire is not re-reporting it, because M19 raises nothing: the pulse that leaves
M19 **is** the pulse its child raised, one cycle wide, on the same cycle
(SPEC-M05 §9's rule, SPEC-M16 §9's restatement).

**Three conservation facts a monitor attached here needs.**

1. **Frames presented at `rx` are conserved against four things**, not one:
   application payload frames at `app_rx_payload`, `app_rx_hdr` pulses with no
   payload frame (requirements.md §0.7), the fifteen discard strobes, and **the
   ARP branch**, whose frames are consumed inside M16 and appear at no output of
   this module. §6.1 states it; it is repeated in the errors section because it
   is the equation a bench actually writes.
2. **The receive path drops a frame at four different modules inside here** — M06
   (short frame), M08 (unknown ethertype), M14 (seven IPv4 conditions) and M17
   (two UDP conditions) — and a frame may legitimately be reported by **two**
   strobes at the same module (SPEC-M14 §9's independent evaluation, SPEC-M17
   §9's copy of it). A conservation monitor at M19's ports must therefore count
   **frames discarded**, not **strobe pulses**: two strobes on one frame is one
   discard. This is ledger **C-2**'s first clause, and M19 is the first module at
   which the difference between the two counts is reachable by a single frame,
   because it is the first scope containing two modules that can each double-pulse.
3. **`error_tx_length_mismatch` belongs to the transmit direction and appears in
   the same fifteen** as the receive-side strobes. A conservation monitor over
   the receive path must exclude it, and a monitor over the transmit path must
   pair it with the absence of a well-formed frame at `tx` — or, for REQ-710's
   over-delivery, with the *presence* of one (SPEC-M18 §9). Mixing the two
   directions in one equation is the mistake this fact exists to prevent, and it
   is reachable here for the first time because M19 is the first module whose
   strobe list spans both.

REQ-008's prohibition on silent discard is not weakened: every condition
detectable inside this subsystem is detected by a child and reported by a strobe
M19 exposes.

## 10. REQ coverage

| REQ | How this module satisfies it | Section | Verification hook for DV |
|---|---|---|---|
| REQ-001 | one clock, fanned to all three children | §6.1 | the emitted-Verilog edge-expression check |
| REQ-003 | `rx`, `app_rx_payload` and `app_rx_hdr` are `Source`/record with no `Dest`; the two `Dest` records present are on transmit ports §0.4 excludes | §4.1 | interface compile check |
| REQ-005 | adds zero octet times in both directions | §7 | the per-octet latency measurements in M14's and M17's benches, taken at M19's ports: identical values |
| REQ-007, REQ-013 | `tuser`[0] relayed untouched in both directions; the ultimate consumer is the application, one port above | §3, §6.1 | error injection at M03, observed at M19's `app_rx_payload` |
| REQ-008 | fifteen strobes relayed; none suppressed; §9's three conservation facts stated | §9 | frame conservation at M19's ports over §9 fact 1's four terms, counting discards rather than pulses (fact 2) and excluding the transmit strobe (fact 3) |
| REQ-009 | `clear` fanned; no state of its own; the emptied ARP cache makes the first post-reset transmit datagram miss; `clear` is also ADR-0011's recovery, reaching M18 through this fan-out | §7 | the reset tests of the three children, run through M19 |
| REQ-010 | every stream port uses the programme types; the receive header port is SPEC-M01's `Udp_header` and the transmit request port is SPEC-M18's `Udp_tx_request`, opened and not restated | §4.1 | interface compile check; this lift and SPEC-M20's are the two cross-module witnesses that the declare-once rule held for batch F's record |
| REQ-019 | ΔC = 0 added; the receive chain across M19 is (3 + 1 + 4) + 2 = 10 cycles against (3 + 1 + 5) + 4 = 13 allocated | §7 | the §1.1 arithmetic at freeze; the measured chain figure in the sign-off packet |
| REQ-020 | nothing reorders; the one merge point is M09, inside M16 | §3, §6.1 | REQ-020's sequence-number run, end to end |
| REQ-406 | no instance of its own: M09 arbitrates two levels down, inside M16 | §2 | none — stated so that no sign-off packet claims arbitration coverage at this level; SPEC-M09 §8 owns it |
| REQ-505 | no instance of its own: the discard is M15's, the strobe is M13's, and both are inside M16 (SPEC-M16 §9 fact 2) | §9 | none — stated so that no sign-off packet claims miss coverage at this level |
| REQ-707 | no instance of its own: M19 **relays** the application receive stream and claims **no part** of REQ-707, which is M17's whole (SPEC-M17 §5) | §3, §6.1 | none — stated so that `SO-udp_complete_64.md` cannot claim what `SO-udp_ip_rx_64.md` claims |
| REQ-708 (application-boundary half) | the application boundary exists at M19's ports, so the delivery of REQ-708's datagrams without loss is measurable here, at the payloads and the sequence numbers | §8 item 1 | §8 item 1's 10 000-datagram run at `app_rx_*`. **The end-to-end half is M20's**: the REQ-004 arrival rate is an XGMII property and is not observable at this module's ports, so no sign-off packet may cite this run as full REQ-708 coverage |
| REQ-805 | the obligation on the consumer is visible in this module's output type, relayed from M17 | §4.1 | interface compile check |
| REQ-808 | `udp_complete_64` is a distinct emitted module containing all three children | §4.1, §6.1 | the `rtl_snapshots/` module-name comparison and the instance hierarchy |
| REQ-810 | no instance of its own: `cfg_tx_enable` is relayed to M18 and read nowhere here | §4.3 | none — stated so that no sign-off packet claims enable coverage at this level |
| REQ-903 | `.mli` plus a `hierarchical` entry point taking a `Scope.t` | §4.1 | repository surface check at `P1-module-ready` |

This table is the source of M19's rows in [`traceability.md`](../traceability.md),
updated in the same commit.

## 11. Deferred items

Item numbers are permanent; a closed item keeps its row (SPEC-TEMPLATE §11).

| # | Item | Status · what a reader assumes meanwhile | Tracked as | Owner | Closes by |
|---|---|---|---|---|---|
| 11.1 | **The `ifc_check` compile evidence for this lift is pending**: `udp_complete_64_ifc.ml` is new in this commit and is the first lift to `open!` a record declared **in its own batch** by a sibling module (`Udp_tx_request`, SPEC-M18 §4.1). | **CLOSED (WO-0022).** CI `build` run **30744579228** at **d8df28d** reports `success` with all twenty lifts in it, this one included, and the run's head SHA **is** this specification's freeze SHA. The first lift to `open!` a record declared by a sibling **in its own batch** elaborated on its first run, with no cycle, as §4.1 argued it would. | the `Interface compile check` row of §12 | architect_docs_lead, rtl_lead | closed |
| 11.2 | **Fifteen strobes as fifteen scalars**, which SPEC-M05 §11.1 raised at six and SPEC-M16 §11.2 at twelve. | **DEFERRED — this specification commits to fifteen scalars and nothing downstream is blocked.** A reader wiring M19 today connects fifteen named outputs, and every name is normative (requirements.md §12) whichever container carries it. The programme's rule, settled by batch F, is that **strobes travel as named scalars and are aggregated exactly once, at M20** (SPEC-M20 §4.1), so this row is the last restatement of it and not a new question. Changing M19 to a partial record would be a §4 spec diff plus an ADR and would rename no strobe. | SPEC-M05 §11.1; SPEC-M16 §11.2; SPEC-M20 §4.1 | architect_docs_lead | M19's `P1-module-ready` |
| 11.3 | **The three REQ-506 parameters are forwarded through four levels** — M20, M19, M16, M13 — and their defaults are restated at each, because a defaulted optional argument must have one. | **DEFERRED — the normative statement is SPEC-M13 §5 and every restatement names it.** A reader implements the defaults as written and changes all four together if any changes. The alternative — a parameter record threaded from the top, or a configuration port — was not taken because it would make three compile-time constants into runtime state at every level, and REQ-506 says explicitly that they are compile-time parameters so tests can use short values. Recorded so that a fifth restatement is noticed as a cost rather than added silently. | SPEC-M13 §5; SPEC-M16 §5; SPEC-M20 §5 | architect_docs_lead | M19's `P1-module-ready` |

## 12. Freeze record

Filled in at `P1-spec-freeze`. All four rows are required (charter §5).

| Item | Value |
|---|---|
| Interface compile check | CI `build` run **30744579228**, conclusion **`success`**, SHA **d8df28d** — every lift in the single `ifc_check` library elaborates, the four batch-F lifts among them; per ADR-0005 a local build is not acceptable evidence. **The run's head SHA is this specification's freeze SHA**, so no witnessing argument is owed. This run is also §11.1's closure record |
| Architect signature | `J-architect_docs_lead-0008` |
| dv_lead testability countersignature | **`J-dv_lead-0011`** (WO-0022) — batch F **COUNTERSIGNED at d8df28d**. This specification was **SIGNED on its own merits at WO-0020** (`J-dv_lead-0010`) and is unchanged since; nothing in the batch-F re-review surface touched it |
| Frozen at | SHA **d8df28d**, gate `docs/gates/P1-spec-freeze-checklist.md` |

## 13. Change log

Post-freeze changes only. Each row cites the ADR that authorised it; a breaking
interface change is counted against post-freeze churn (charter §6). §4.1's
records are byte-for-byte unchanged since the freeze SHA, so the `ifc_check`
evidence of §12 witnesses this revision's interface and
`tools/check_records_vs_appendix.sh` re-passes on every commit. This
specification has no post-freeze change yet.

| Date | Change | Breaking? | ADR | Journal |
|---|---|---|---|---|
| — | — | — | — | — |
