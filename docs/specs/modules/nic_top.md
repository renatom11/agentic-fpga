# SPEC-M20 — `Nic_top`

- **Status**: **FROZEN** (`P1-spec-freeze`, SHA `d8df28d`) — batch F, dv_lead
  countersignature `J-dv_lead-0011` (WO-0022), **SIGNED** with every number
  re-derived. Changes to §4, §6 or §7 after this point are spec diffs recorded
  in §13 (SPEC-TEMPLATE rule 7)
- **Inventory id**: M20 (architecture.md §4) · **Path**:
  `libs/hardcaml_ethernet/src/nic_top.ml`
- **Datapath role**: shared/structural (receive-path module **with respect to its
  receive ports only**, requirements.md §0.4)
- **Owns REQs**: REQ-801, REQ-802, REQ-803, REQ-804, REQ-805, REQ-806, REQ-809,
  REQ-810 (as the configuration source — the three behavioural halves are M03's,
  M04's and M18's, §4.3), the **XGMII-observable half** of REQ-807, the
  **end-to-end half** of REQ-708, and **REQ-006**, whose two measurement events
  are both ports of this module and of no other
- **Prior-art counterpart**: none as a single file. The reference assembles
  `eth_mac_10g` and `udp_complete_64` in its example designs (architecture.md
  §4); what was taken is the assembly, not a source file, and no Verilog was
  copied
- **Depends on specs**: SPEC-M01 (`Axi64`, `Xgmii`, `Udp_header`, `Config`,
  `Status`), SPEC-M05 (`Eth_mac_10g`), SPEC-M19 (`Udp_complete_64`), SPEC-M18
  (which declares `Udp_tx_request`), and — for §7's end-to-end derivation —
  SPEC-M03, SPEC-M06, SPEC-M08, SPEC-M14 and SPEC-M17, whose pinned constants
  the derivation sums
- **Author**: architect_docs_lead, journal `J-architect_docs_lead-0008`

## 1. Purpose

M20 is the Phase-1 design: it binds the MAC (M05) and the protocol stack (M19)
into one module whose only wire-side ports are the four XGMII signals REQ-017
names, whose application-side ports are the two streams Phase 2 attaches to, and
whose remaining ports are one configuration record in and one status record out.
It exists because a design has to end somewhere, and this is the boundary the
programme's three closure requirements are written about: REQ-017 (nothing below
XGMII), REQ-802 and REQ-804 (configuration and status as records, once), and
REQ-006 (the end-to-end latency, whose two measurement events are `xgmii_rx` and
`app_rx_payload` — both ports of this module and of no other).

It contains **no datapath logic**: every octet it carries is carried by a child,
and §6.1's wiring table is total. What it does that no other module does is
**decompose one `Config` record into scalars** and **assemble twenty-one scalars
into one `Status` record** (§6.1).

Its receive port chain is `WIRE` → **M20** → `APP` and its transmit port chain is
`APP` → **M20** → `WIRE` (architecture.md §6.4). It has no parent.

## 2. Scope

**In scope.**

- Instantiating M05 and M19 exactly once each and wiring them as §6.1's table
  states, with no logic between any pair of ports.
- Presenting exactly the ports REQ-801 enumerates, and no others (§4.1, REQ-017).
- Decomposing the twelve-field `Config` record into the scalars its children read
  and fanning them out (§4.3, REQ-802, REQ-803).
- Assembling the twenty-one strobes its children raise into the twenty-one-field
  `Status` record, one field per strobe, one cycle high per event (§6.1,
  REQ-804).
- Being the level at which REQ-006's budget is measured and REQ-806's figures are
  reported (§7).
- Being the level at which REQ-807's XGMII observable, REQ-708's end-to-end line
  rate and REQ-809's both-directions datagram path are exercised (§8).
- Being the module named `nic_top` in the emitted hierarchy (REQ-808, REQ-017's
  port-list check).

**Not this module's job.**

| Behaviour a reader might expect here | Owner |
|---|---|
| Any decode, encode, checksum, filtering, resolution, length check, arbitration or realignment | the seventeen modules below it, in their own specifications. M20 adds no logic and detects no condition |
| Anything below XGMII — PMA, serdes, 64b/66b, link training, fault signalling, PTP | **nobody in Phase 1** (REQ-018, requirements.md §11). The link partner is a simulation model owned by dv_lead under `test/` (architecture.md §3); Phase 3 attaches here |
| Driving the application, or knowing what the payload means | the application. Phase 2's MoldUDP64/ITCH feed handler attaches at `app_rx_payload` (architecture.md §9) and is bound by REQ-805 |
| Registering configuration, or arbitrating between two configuration sources | **nobody** — M20 holds no configuration register (§4.3). One `Config` record enters, is decomposed, and reaches every reader on the same cycle; REQ-803 is satisfied by each reader's own sampling rule |
| Counting frames, packets or errors | **nobody** — REQ-804 gives one-cycle strobes, not counters. A counter would be state with no requirement behind it, and the bench counts high cycles (requirements.md §0.6's convention) |
| A management interface, a register file, an AXI-Lite port | **nobody** in Phase 1. `Config` and `Status` are flat records at ports; requirements.md §9.1 fixes the fields and REQ-802 fixes the widths |

## 3. Programme invariants that bind this module

Per requirements.md §0.4, M20 is a receive-path module **with respect to the
ports on that chain** — `xgmii_rx`, `app_rx_hdr` and `app_rx_payload` — and is
bound by every receive-path requirement on those ports only. Its application
*transmit* stream carries an `Axi64.Dest` and does not violate REQ-003;
requirements.md §0.4 names this module explicitly when it makes that point. M20
**is** in §0.4's stress-bench list (REQ-905), which is the one respect in which
it differs from the two wrappers below it.

| REQ | Consequence for M20 |
|---|---|
| REQ-001 | One `clock`, fanned to both children and thence to all nineteen modules. There is no second domain anywhere (architecture.md §2.8). |
| REQ-002 | Every frame-carrying stream port is a 64-bit `Axi64` stream. The two XGMII lane pairs are **not** stream ports and are outside REQ-010's subject by its own class (b) — REQ-017 and REQ-012 govern them. |
| REQ-003 | The receive ports are `Axi64.Source` with no `Dest` (§4.1); `app_rx_payload` is where REQ-805's obligation on the Phase-2 consumer becomes structural at the top level. The `Dest` present belongs to the application *transmit* stream, which §0.4 excludes by name. |
| REQ-004 | M20 is on §0.4's stress-bench list: REQ-004 is exercised "again at `nic_top`", at the XGMII boundary with the link-partner model driving the alternating 10-and-11-cycle spacing (§8). This is the **only** level at which that arrival pattern is real rather than reconstructed. |
| REQ-005 | M20 adds **zero** octet times. Its receive-port constants *are* its children's, unchanged (§7). |
| REQ-006 | **This module owns the measurement.** The two events REQ-006 names — the cycle of the XGMII word carrying a frame's start character, and the cycle of that frame's first application payload word — are `xgmii_rx` and `app_rx_payload`, both M20 ports. §7 derives the figure from five pinned constants and §8 measures it. |
| REQ-007, REQ-013 | `tuser`[0] passes through untouched in both directions. The ultimate consumer on the UDP receive branch is the **application**, one port outside this module (REQ-707, ADR-0009); on the ARP branch it is M13, four levels down. |
| REQ-008 | M20 detects no condition and raises no strobe of its own; it aggregates its children's twenty-one into `Status` (§9). |
| REQ-009 | `clear` is fanned to both children; M20 holds no state for it to act on. It is a top-level port, which is what makes ADR-0011's recovery from an under-delivered transmit frame available to the bench and to the platform without a new port anywhere. |
| REQ-010 | Every frame-carrying stream port uses the programme types. The **six** non-stream frame-carrying ports of REQ-010's class (b) include two of M20's — `xgmii_rx` and `xgmii_tx`, declared from SPEC-M01's `Xgmii` record — and REQ-010's census counts them. |
| REQ-015, REQ-016, REQ-021 | Bind the relayed streams and are satisfied by relaying: M20 changes no `tkeep`, no octet order, no `tlast` and no alignment, and inserts no idle cycle. |
| REQ-017 | **M20 is the module REQ-017 is about.** Its only wire-side ports are `xgmii_rxd`[63:0], `xgmii_rxc`[7:0], `xgmii_txd`[63:0] and `xgmii_txc`[7:0], emitted from two `Xgmii` records with the two `rtlprefix` values SPEC-M01 §4.1 fixes; every other port is clock, clear, configuration, an application stream or status (§4.1, §4.2). |
| REQ-018 | The XGMII boundary is simulation-only: no PMA, serdes, PCS, scrambler, link-training, fault-signalling or PTP logic exists anywhere below this module, and the whitelist check `tools/check_emitted_verilog.sh` runs over the emitted hierarchy rooted here. |
| REQ-019 | M20's receive-port word delay is ΔC = 0 on top of its children's, so the end-to-end figure charged against requirements.md §1.1 is theirs alone: **13** cycles from `xgmii_rx`'s start-character word to `app_rx_payload`'s first word, against 17 allocated and REQ-006's 24 (§7). M20 holds no payload storage at all. |
| REQ-020 | Order is preserved because nothing here reorders; the sequence-number run of REQ-020's verification column is a top-level run and is §8's. |
| REQ-805 | The application receive stream leaves this module as `Axi64.Source` with no `Dest`, which is REQ-805's first sentence made structural. Its second sentence binds the Phase-2 consumer and has no Phase-1 observable, which requirements.md states rather than pretends away (§11.4). |
| REQ-808 | `nic_top` SHALL appear as a distinct module in the emitted Verilog with both children instantiated inside it (architecture.md §6.3), and it is the root the module-name comparison walks from. |

## 4. Interface

### 4.1 Interface records

```ocaml
(* SPEC-M20 §4.1, lifted verbatim into docs/specs/ifc_check/nic_top_ifc.ml
   (SPEC-TEMPLATE.md rule 6). Records and signatures only — no logic, no
   implementation.

   [Axi64_ifc] is M01's types home (SPEC-M01 §4.1): [Axi64], [Xgmii],
   [Udp_header], [Config] and [Status] all come from there and are
   restated nowhere. This is the ONLY module in the programme whose ports
   carry [Config] and [Status]: REQ-802 and REQ-804 make the records
   top-level, every module below reads scalars, and one port each is what
   keeps requirements.md §9.1 and §12 single statements.
   [Udp_ip_tx_64_ifc] is where SPEC-M18 §4.1 declares [Udp_tx_request];
   opening it does not re-export what THAT file opened, so [Axi64_ifc] is
   opened here too, and there is no cycle because M18's lift references
   nothing of M20's.

   M20 does NOT open [Eth_mac_10g_ifc] or [Udp_complete_64_ifc]: no
   record of theirs appears at ITS ports, because both children's ports
   are a subset of the types above (SPEC-M12 §4.1's rule — a lift that
   opened a module it does not use would compile and would still be a lie
   about the dependency).

   REQ-017 is a property of THIS record and is checkable by reading it:
   the only wire-side ports are the two [Xgmii] lane pairs, whose
   [@rtlprefix] values emit exactly [xgmii_rxd], [xgmii_rxc],
   [xgmii_txd] and [xgmii_txc]. Every other field is clock, clear,
   configuration, an application stream or status.

   [app_rx_hdr] and [app_rx_payload] are [Source] with no [Dest]
   anywhere — REQ-003, REQ-707 and REQ-805 structurally, at the port the
   Phase-2 feed handler attaches to. [app_tx_*] is the transmit
   direction, [Source] one way and [Dest] the other. *)

open! Base
open Hardcaml
open! Axi64_ifc
open! Udp_ip_tx_64_ifc

module I = struct
  type 'a t =
    { clock : 'a
    ; clear : 'a
    ; xgmii_rx : 'a Xgmii.t [@rtlprefix "xgmii_rx"]
    ; cfg : 'a Config.t [@rtlprefix "cfg_"]
    ; app_tx_request : 'a Udp_tx_request.t [@rtlprefix "app_tx_request_"]
    ; app_tx_payload : 'a Axi64.Source.t [@rtlprefix "app_tx_payload_"]
    }
  [@@deriving hardcaml]
end

module O = struct
  type 'a t =
    { xgmii_tx : 'a Xgmii.t [@rtlprefix "xgmii_tx"]
    ; app_rx_hdr : 'a Udp_header.t [@rtlprefix "app_rx_hdr_"]
    ; app_rx_payload : 'a Axi64.Source.t [@rtlprefix "app_rx_payload_"]
    ; app_tx_payload_dest : 'a Axi64.Dest.t [@rtlprefix "app_tx_payload_"]
    ; status : 'a Status.t [@rtlprefix "status_"]
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

(* REQ-802 and REQ-804 compile-time witnesses: [Config]'s twelve field
   names in requirements.md §9.1's order and [Status]'s twenty-one in
   §12's order, neither of which had a user until this module — the same
   position [Ip_header] was in until batch E and [Udp_header] until
   SPEC-M17. tools/check_records_vs_appendix.sh checks both lists against
   the requirements document; these two functions are what make a rename
   in SPEC-M01 §4.1 fail to COMPILE as well. *)

let _witness_config_field_names (c : Signal.t Config.t) =
  let open Config in
  [ c.local_mac
  ; c.local_ip
  ; c.subnet_mask
  ; c.gateway_ip
  ; c.multicast_group
  ; c.multicast_enable
  ; c.listen_port
  ; c.accept_all_ports
  ; c.ttl
  ; c.ifg
  ; c.rx_enable
  ; c.tx_enable
  ]
;;

let _witness_status_field_names (s : Signal.t Status.t) =
  let open Status in
  [ s.error_bad_fcs
  ; s.error_bad_frame
  ; s.error_runt
  ; s.error_oversize
  ; s.error_start_without_terminate
  ; s.error_underflow
  ; s.error_short_frame
  ; s.error_unknown_ethertype
  ; s.error_arp_unsupported
  ; s.error_arp_miss
  ; s.error_arp_reply_dropped
  ; s.error_ip_bad_header
  ; s.error_ip_bad_checksum
  ; s.error_ip_fragment
  ; s.error_ip_not_for_us
  ; s.error_ip_truncated
  ; s.error_ip_bad_protocol
  ; s.error_ip_oversize
  ; s.error_udp_bad_length
  ; s.error_udp_port
  ; s.error_tx_length_mismatch
  ]
;;
```

Conformance of this block to the template's rules for §4.1:

- Scalar fields carry `[@bits n]` unless they are one bit wide: `clock` and
  `clear` are one bit, and every other field is inside a nested record carrying
  its own widths. M20 is the only module in the programme with **no** bare
  multi-bit scalar port, because every value it carries belongs to a record.
- Nested interfaces carry `[@rtlprefix]`. The two XGMII prefixes are
  `"xgmii_rx"` and `"xgmii_tx"` **without a trailing underscore**, which is what
  makes `Xgmii`'s one-letter fields `d` and `c` emit exactly `xgmii_rxd`,
  `xgmii_rxc`, `xgmii_txd` and `xgmii_txc` — the four names REQ-017 fixes.
  SPEC-M05 §4.1 uses the same two values for the same reason, so M05 and M20 emit
  identical wire-side names by construction and the port-list check confirms
  rather than establishes them (SPEC-M05 §11.2).
- `cfg` emits `cfg_local_mac` … `cfg_tx_enable` and `status` emits
  `status_error_bad_fcs` … `status_error_tx_length_mismatch`, which are exactly
  the names architecture.md §6.4.3 and §6.4.4 use for M20's endpoints.
- **Receive-path `Source` without `Dest`: held** on `app_rx_payload` and the
  `Udp_header` output. The one `Dest` record present is the application transmit
  stream's, which requirements.md §0.4 excludes from the receive path by name for
  exactly this module.
- Both `create` and `hierarchical` are declared (REQ-903, REQ-808), each taking
  the three REQ-506 parameters, which M20 **forwards to its M19 instance and
  reads for nothing itself** (§5).

### 4.2 Port table

Every port in §4.1 appears exactly once. Direction is with respect to M20.
**This table is REQ-017's and REQ-801's enumeration**, and the emitted-Verilog
port-list check of §10 set-compares against it.

| Port | Dir | Width | Meaning | REQ |
|---|---|---|---|---|
| `clock` | in | 1 | 156.25 MHz single domain, fanned to both children | REQ-001 |
| `clear` | in | 1 | synchronous clear, fanned to both children; also ADR-0011's recovery path | REQ-009 |
| `xgmii_rxd` | in | 64 | XGMII receive lanes; lane k's octet is bits [8k+7:8k] | REQ-017, REQ-012 |
| `xgmii_rxc` | in | 8 | XGMII receive control indications; bit k is lane k's | REQ-017 |
| `cfg_local_mac` | in | 48 | the twelve `Config` fields, at requirements.md §9.1's widths, reset values and permitted ranges. M20 registers none of them (§4.3) | REQ-802 |
| `cfg_local_ip` | in | 32 | " | REQ-802 |
| `cfg_subnet_mask` | in | 32 | " | REQ-802 |
| `cfg_gateway_ip` | in | 32 | " | REQ-802 |
| `cfg_multicast_group` | in | 32 | " | REQ-802 |
| `cfg_multicast_enable` | in | 1 | " | REQ-802 |
| `cfg_listen_port` | in | 16 | " | REQ-802 |
| `cfg_accept_all_ports` | in | 1 | " | REQ-802 |
| `cfg_ttl` | in | 8 | " | REQ-802 |
| `cfg_ifg` | in | 8 | " — values below 12 SHALL NOT be driven (requirements.md §0.3, REQ-802) | REQ-802, REQ-204 |
| `cfg_rx_enable` | in | 1 | " | REQ-802, REQ-810 |
| `cfg_tx_enable` | in | 1 | " — the one field with **two** readers, M04 and M18 (§4.3) | REQ-802, REQ-810 |
| `app_tx_request_valid` | in | 1 | the application offers a transmit datagram; a **level** held until the frame's first payload word is accepted (ADR-0008) | REQ-705, ADR-0008 |
| `app_tx_request_dst_ip` | in | 32 | the datagram's destination IPv4 address | REQ-705 |
| `app_tx_request_dst_port` | in | 16 | the destination UDP port | REQ-705 |
| `app_tx_request_src_port` | in | 16 | the source UDP port | REQ-705 |
| `app_tx_request_payload_length` | in | 16 | the number of **UDP payload octets** the application will supply (REQ-705); its practical range is SPEC-M18 §11.3's | REQ-705, REQ-610 |
| `app_tx_payload_tvalid` … `app_tx_payload_tuser` | in | 1/64/8/8/1/1 | the application transmit payload stream, word-aligned at its producer (REQ-021) | REQ-705, REQ-010 |
| `xgmii_txd` | out | 64 | XGMII transmit lanes | REQ-017, REQ-012 |
| `xgmii_txc` | out | 8 | XGMII transmit control indications | REQ-017 |
| `app_rx_hdr_valid` … `app_rx_hdr_checksum` | out | 1/16/16/16/16 | the received datagram's UDP header record; `valid` is a one-cycle pulse, one cycle before the first application word (REQ-701, SPEC-M17 §7). **A pulse with no payload frame following it is the accounting observable for a zero-payload datagram** (§9, requirements.md §0.7) | REQ-701, REQ-707 |
| `app_rx_payload_tvalid` … `app_rx_payload_tuser` | out | 1/64/8/8/1/1 | the application receive stream: UDP payload octets only, word-aligned, `tuser`[0] carried, **no `tready`** (REQ-707, REQ-805). This is Phase 2's attach point | REQ-707, REQ-805 |
| `app_tx_payload_tready` | out | 1 | M18 accepts an application word this cycle; **0 on every cycle while `cfg_tx_enable` = 0** (REQ-810, SPEC-M18 §4.3) | REQ-207, REQ-810 |
| `status_error_bad_fcs` … `status_error_tx_length_mismatch` | out | 1 each | the twenty-one strobes of requirements.md §12, one field per strobe, in §12's order, each one cycle high per event (REQ-804, §9) | REQ-804, REQ-008 |

### 4.3 Configuration inputs

M20 reads the **whole** `Config` record and holds **no register**: it decomposes
the twelve fields into the scalars its children read and fans them out
combinationally (§6.1). Every reader therefore sees a configuration change on the
same cycle, which is the property REQ-803 depends on and which SPEC-M16 §4.3
argues for at its own level.

| Field | Fanned to | Governing sampling rule |
|---|---|---|
| `local_mac` | M19 → M16 → M13, M15 | SPEC-M13 §4.3; SPEC-M15 §4.3 |
| `local_ip` | M19 → M16 → M13, M14, M15 | SPEC-M13 §4.3; SPEC-M14 §4.3; SPEC-M15 §4.3 |
| `subnet_mask` | M19 → M16 → M13, M14 | SPEC-M13 §4.3; SPEC-M14 §4.3 |
| `gateway_ip` | M19 → M16 → M13 | SPEC-M13 §4.3 |
| `multicast_group` | M19 → M16 → M14 | SPEC-M14 §4.3 |
| `multicast_enable` | M19 → M16 → M14 | SPEC-M14 §4.3 |
| `listen_port` | M19 → M17 | SPEC-M17 §4.3 |
| `accept_all_ports` | M19 → M17 | SPEC-M17 §4.3 |
| `ttl` | M19 → M16 → M15 | SPEC-M15 §4.3 |
| `ifg` | M05 → M04 | SPEC-M04 §4.3 |
| `rx_enable` | M05 → M03 | SPEC-M03 §4.3 |
| `tx_enable` | **M05 → M04** *and* **M19 → M18** | SPEC-M04 §4.3 (the XGMII half); SPEC-M18 §4.3 (the application-interface half) |

**`tx_enable` is the one field with two readers, and that is REQ-810's shape
rather than a duplication.** REQ-810's transmit clause has two observables in one
sentence: "it emits only idle characters" is M04's and "holds `tready`
deasserted at the application transmit interface" is a statement about a port
three modules away, which M18 owns (SPEC-M18 §4.3 argues the edge and records the
rejected alternative). Each observable is enforced by the module whose port it
names, which is what makes each independently testable; §8 item 6 drives both at
once and asserts both.

**REQ-803 is satisfied here by holding no state, and that is a decision.** M20
could have registered the configuration record once and fanned the registered
copy, which would give every reader a value that changes on a known cycle. It
does not, for two reasons. First, a register here would put configuration one
cycle behind the port at every reader, so each child's §4.3 sampling rule — all
of which are written against the *port* — would have to be restated with an
offset, in six specifications. Second, REQ-803's own verification column changes
configuration **between** frames and asserts the in-flight frame completes under
the old value, which is a property of each reader's sampling rule and not of when
the value arrived. M20 therefore adds nothing REQ-803 needs, and §10's REQ-803
hook is stated at the readers.

## 5. Parameters

| Parameter | Type | Default | Range | Why a test overrides it |
|---|---|---|---|---|
| `retry_count` | `int` | **4** | 0 to 15 | REQ-506 requires it; M20 forwards it to its M19 instance, which forwards it to M16 and thence to M13 (SPEC-M19 §5, SPEC-M16 §5, SPEC-M13 §5), and reads it for nothing itself |
| `retry_interval_cycles` | `int` | **156 250 000** (1.0 s) | 1 to 2^32 − 1 | the same; **every** top-level ARP test needs a short value, because the default is 1.0 s = 156 250 000 cycles and no simulation runs that long |
| `entry_lifetime_cycles` | `int` | **3 125 000 000** (20 s) | 1 to 2^32 − 1 | the same; M13 forwards it again to M12 (SPEC-M12 §5) |

**M20 has no parameter of its own.** These three exist here because they are the
only way a top-level bench can reach M13's and M12's timing without reaching
inside the hierarchy, and REQ-506 makes them compile-time parameters precisely so
that tests can shorten them. This is the **fourth and last** level they are
forwarded through; the normative statement of each default and range is SPEC-M13
§5, and a change to any of them is a spec diff at M13, M16, M19 and M20 together
(SPEC-M19 §11.3 records the cost).

**Everything else that a test might want to vary is a `Config` field, not a
parameter**, and the boundary is worth stating once: a value that changes the
*hardware* is a parameter (the three above), and a value that changes the
*behaviour of fixed hardware* is configuration (requirements.md §9.1's twelve).
`cfg_ifg` is the case that tests the rule and lands on the configuration side —
the transmitter's gap logic is the same logic at 12 as at 255.

## 6. Behaviour

### 6.1 Normal path

M20's behaviour is its wiring, and the wiring is total: every port of §4.2 is
connected to exactly one child port or to one field of a record it decomposes or
assembles, and every child port is connected either to an M20 port or to the
other child, with **no logic between**.

**Receive chain.**

| Source | Sink |
|---|---|
| M20 `xgmii_rx` | M05 `xgmii_rx` |
| M05 `rx` | M19 `rx` |
| M19 `app_rx_hdr`, M19 `app_rx_payload` | M20 `app_rx_hdr`, M20 `app_rx_payload` |

**Transmit chain.**

| Source | Sink |
|---|---|
| M20 `app_tx_request`, M20 `app_tx_payload` | M19 `app_tx_request`, M19 `app_tx_payload` |
| M19 `app_tx_payload_dest` | M20 `app_tx_payload_dest` |
| M19 `tx` | M05 `tx` |
| M05 `tx_dest` | M19 `tx_dest` |
| M05 `xgmii_tx` | M20 `xgmii_tx` |

**Configuration — the one decomposition in the programme.** The `Config` record
enters at one port and leaves as scalars, per §4.3's table:

| Source | Sink |
|---|---|
| `clock`, `clear` | both children |
| `cfg.rx_enable`, `cfg.tx_enable`, `cfg.ifg` | M05 |
| `cfg.local_mac`, `cfg.local_ip`, `cfg.subnet_mask`, `cfg.gateway_ip`, `cfg.multicast_group`, `cfg.multicast_enable`, `cfg.ttl`, `cfg.listen_port`, `cfg.accept_all_ports`, `cfg.tx_enable` | M19 |

Ten scalars to M19, three to M05, twelve fields, one of them (`tx_enable`) going
both ways: 10 + 3 = 13 wires from 12 fields, and the extra one is REQ-810's two
observables (§4.3).

**Status — the one assembly in the programme.** Twenty-one scalars enter from two
children and leave as one record, in requirements.md §12's order:

| Source | `Status` field |
|---|---|
| M05's six (M03's `error_bad_fcs`, `error_bad_frame`, `error_runt`, `error_oversize`, `error_start_without_terminate`; M04's `error_underflow`) | the first six fields, in §12's order |
| M19's fifteen (M16's twelve, M17's two, M18's one) | the remaining fifteen, in §12's order |

**Six plus fifteen is twenty-one, and twenty-one is the whole of
requirements.md §12** — which is the arithmetic REQ-804 turns on and which is
asserted here rather than assumed. The assembly is a **rename, not a reduction**:
requirements.md §12 assigns each of the twenty-one strobes to exactly one raising
module, so no two children ever drive the same `Status` field and there is no OR
gate, no priority and no cycle on which two events could collide into one field.
That is the property that makes REQ-804's "one cycle high per event" true at the
top level given only that it is true at each child, and it is why §9 can state
that M20 introduces no error behaviour of its own.

`tools/check_records_vs_appendix.sh` already compares `Status`'s field list
against requirements.md §12 in both name and order, and §4.1's
`_witness_status_field_names` makes the same comparison fail to **compile** if a
field is renamed in SPEC-M01. The two checks are deliberately different in kind:
one reads the documents, the other reads the types.

No cycle-by-cycle table appears here because no sequencing exists to tabulate:
every octet's timing is its children's, and SPEC-M03 §6.1, SPEC-M04 §6.1,
SPEC-M14 §6.1, SPEC-M17 §6.1 and SPEC-M18 §6.1 carry the tables. §7 sums their
constants, which is the one arithmetic M20 owns.

### 6.2 State machine

**Not applicable: M20 is purely structural.** It holds no register and has no
state, so it has no reset state and nothing happens to it on `clear` beyond the
fan-out of §6.1 — the same shape SPEC-M05 §6.2, SPEC-M16 §6.2 and SPEC-M19 §6.2
state for the wrappers below it. M20 is not a function of its inputs at all; it is
a wiring diagram with one record taken apart and one record put together.

### 6.3 Deliberately unconstrained

Anything not listed here is constrained by this specification.

1. **The instance names** M20 gives its two children (`hierarchical`'s
   `?instance` argument). The *module* names are normative — `eth_mac_10g` and
   `udp_complete_64` (REQ-808) — and the instance labels are not.
2. **Whether M20 declares its own `.mli` re-exports** of the child modules'
   types. REQ-903 requires the `.mli`; what it re-exports is rtl_lead's.
3. **The behaviour for a `Config` field driven outside its permitted range**
   (requirements.md §9.1). REQ-802 says in terms that such a value is a
   configuration error whose behaviour is unspecified, with one prohibition that
   is not unspecified: `cfg_ifg` below 12 SHALL NOT be driven. DV asserts nothing
   about an out-of-range field and SHALL NOT drive one except to demonstrate the
   prohibition is a prohibition.
4. **Nothing else.** A structural module with an unconstrained region larger than
   this is a module doing something it has not admitted to, and §6.1's wiring
   tables are deliberately total so that any additional logic is a visible diff
   against them — SPEC-M05 §6.3's rule. At the top level the temptation is
   specific and worth naming: a status **counter**, or a configuration
   **register**, or a reset synchroniser. All three are logic; all three would put
   M20 on §0.4's stress-bench list for a second reason and would need their own
   REQ.

## 7. Timing contract

- **Latency: zero octet times added**, in both directions. M20's receive-port
  constants are its children's exactly, and its transmit-port constants likewise.
  The measurement events are the children's; M20 introduces none of its own,
  because a wire is not a measurement event.

- **REQ-006's end-to-end budget, derived — this is where the receive chain
  closes.** REQ-006 measures from the XGMII word carrying a frame's start
  character to the first word of that frame's UDP payload on the application
  receive stream, and requires ≤ **24 cycles** (153.6 ns). Both events are M20
  ports (§3). The delay is the sum of the **word delays** ΔC of the five modules
  on requirements.md §0.4's receive chain, because each module's input
  measurement event is the previous module's first output word — which is what
  makes ΔC additive and is §0.5's whole argument:

  | Stage | h (octets) | L (octet times) | ΔC = (L + h)/8 | §1.1 ceiling | Spec |
  |---|---|---|---|---|---|
  | M03 `Xgmii_rx_64` (lane-0 start) | 8 | 16 | **3** | 4 | SPEC-M03 §7 |
  | M03 `Xgmii_rx_64` (lane-4 start) | 12 | 12 | **3** | 4 | SPEC-M03 §7 |
  | M06 `Eth_axis_rx` | 14 | 10 | **3** | 3 | SPEC-M06 §7 |
  | M08 `Eth_demux` | 0 | 8 | **1** | 1 | SPEC-M08 §7 |
  | M14 `Ip_eth_rx_64` | 20 | 12 | **4** | 5 | SPEC-M14 §7 |
  | M17 `Udp_ip_rx_64` | 8 | 8 | **2** | 4 | SPEC-M17 §7 |
  | **Total, either start lane** | **50 / 54** | **54 / 50** | **13** | 17 | this section |

  > **REQ-006's end-to-end word delay is 13 cycles at both start lanes**, which
  > at 6.4 ns per cycle is **83.2 ns**, against a budget of 24 cycles (153.6 ns).

  **Checked by both of §0.5's routes, which is what makes it a derivation rather
  than a sum of numbers.** Per-octet latency is additive along a chain, so the
  end-to-end constant is L = 16 + 10 + 8 + 12 + 8 = **54** octet times at a
  lane-0 start and 12 + 10 + 8 + 12 + 8 = **50** at a lane-4 start; the front
  offsets add to h = 8 + 14 + 0 + 20 + 8 = **50** and 12 + 14 + 0 + 20 + 8 =
  **54**. Then ΔC = (L + h)/8 = (54 + 50)/8 = 13 at lane 0 and (50 + 54)/8 = 13
  at lane 4. The two routes agree at both lanes, and (L + h) = 104 is a multiple
  of 8 in both — which requirements.md §0.5 says a conformant chain's arithmetic
  must satisfy.

  **The two start lanes give the same cycle figure, and that is worth stating
  because REQ-006 permits them to differ.** REQ-806 requires the figure to be
  reported per start lane and REQ-006's verification column says the two "may
  legitimately differ by one cycle". They do not: M03 pins ΔC = 3 at both lanes
  (SPEC-M03 §7), so the whole chain is lane-independent in cycles even though its
  per-octet constant differs by 4 octet times between them. A bench that measures
  13 at one lane and 14 at the other has found a defect, not a legitimate
  difference — and that is a sharper assertion than REQ-006 alone permits, so it
  is stated here where it is derived rather than left to be inferred.

  **Where the 11 unspent cycles are, itemised, because "under budget" is not an
  accounting.** 24 = 13 spent + 4 module reserve + 7 architect's slack:

  | Holder | Cycles | Where it is recorded |
  |---|---|---|
  | M03 `Xgmii_rx_64` | 1 | SPEC-M03 §7 — deliberate, the hardest receive module |
  | M14 `Ip_eth_rx_64` | 1 | SPEC-M14 §7, §11.2 |
  | M17 `Udp_ip_rx_64` | 2 | SPEC-M17 §7, §11.2 — the UDP header is the one header on the chain that is a whole number of words |
  | Architect's programme slack | 7 | requirements.md §1.1, architecture.md §4 |
  | **Total unspent** | **11** | |

  M06 and M08 are pinned **exactly at their ceilings** and hold no reserve
  (SPEC-M06 §11.2 records that as its own decision). A module's reserve is that
  module's to spend by an ordinary spec diff to its own §7; the architect's seven
  cycles are released only by a diff to requirements.md §1.1 **and**
  architecture.md §4 together, which is what makes an over-budget module a visible
  decision rather than an accumulation. §11.3 records why the eleven are not
  being re-allocated now.

- **Throughput.** One word per cycle in each direction, set entirely by the
  children. M20 introduces no bubble and removes none. The receive path accepts an
  XGMII word on every cycle unconditionally (REQ-112, REQ-003); the transmit path
  emits one minimum-length frame per 11 cycles at the default gap (REQ-209,
  SPEC-M04 §7).

- **Handshake rules.** Relayed unchanged, in both disciplines. `xgmii_rx`,
  `app_rx_payload` and `app_rx_hdr` never carry a `tready` (REQ-003, REQ-707,
  REQ-805), and `app_rx_hdr_valid` is a one-cycle pulse one cycle before its
  payload word (REQ-701, SPEC-M17 §7). `app_tx_request_valid` is a **level** the
  application holds until the frame's first payload word is accepted (ADR-0008).

  **The application is a source under ADR-0008 and is bound by its decisions 1, 2
  and 4** — assert `app_tx_request_valid` and `app_tx_payload_tvalid` for the
  frame's first word on the same cycle; hold both, with every request field and
  that word's contents stable, until the word is accepted; never offer a request
  for a frame with no payload word. SPEC-M18 §7 states the obligation at the port
  that owns it and this paragraph states it at the port the application actually
  sees, because a bench driving M20 is writing the source half of that contract
  and needs to be told so in the top-level specification rather than three
  modules down.

- **Reset.** `clear` reaches both children on the same cycle and thence every
  module. Within one cycle of `clear` deasserting, M20's outputs are its
  children's outputs, which REQ-009 already constrains at each of them. M20 adds
  no reset behaviour of its own because it has no state to reset. Three
  consequences worth naming at the top level: the ARP cache is emptied, so the
  **first** transmit datagram after a reset misses and is discarded with
  `error_arp_miss` (SPEC-M16 §7, SPEC-M19 §7, and REQ-809's verification column's
  "the transmit direction primes the ARP cache first" is about exactly this);
  M04's `tx_tready` is 0 while `clear` = 1 and on the first cycle after,
  overriding `cfg_tx_enable` (SPEC-M04 §6.2's `Idle` row, carry-forward C-14.2);
  and `clear` is the specified recovery from an under-delivered transmit frame
  (ADR-0011, SPEC-M18 §9), which is available at this port and needs nothing else.

- **Configuration sampling.** None here; §4.3. M20 holds no configuration
  register, so every reader's own rule governs and REQ-803's independence of the
  receive and transmit paths is a property of the readers.

## 8. Line-rate stress obligation

**Mandatory: M20 is in requirements.md §0.4's stress-bench list** (M03, M06,
M08, M10, M14, M17, M20) — the only structural module on it, and the only level
at which REQ-004's arrival pattern is **real** rather than reconstructed at a
module boundary.

**Stimulus, at the XGMII boundary, driven by the DV link-partner model**
(REQ-018, architecture.md §3):

- 10 000 consecutive **64-octet** Ethernet frames (destination address through
  FCS, requirements.md §0.3), separated by the minimum 12-octet inter-frame gap
  counted from the terminate character inclusive, with start characters
  **alternating between lane 0 and lane 4** — start-to-start spacing alternating
  **10 and 11 cycles**, 10.5 average (REQ-004). Every gap octet is idle and the
  preamble is exact (REQ-102);
- each frame carries an IPv4 datagram of **total length 46** — version 4, IHL 5,
  DSCP 0, ECN 0, identification n modulo 65 536, flags 0, fragment offset 0,
  TTL 64, protocol 17, a header checksum recomputed per datagram, source address
  `10.0.0.0 + n`, destination address `cfg_local_ip` — carrying a UDP datagram of
  **length 26**: source port n modulo 65 536, destination port `cfg_listen_port`,
  a deliberately wrong non-zero checksum, and **18 octets of UDP payload** whose
  first four carry a 32-bit sequence number. This is REQ-708's stimulus exactly,
  and it is the same payload SPEC-M19 §8 item 1 uses at the application boundary,
  so a divergence between the two runs localises to M05 or to the driver;
- a valid FCS on every frame, `cfg_rx_enable` = 1, `cfg_accept_all_ports` = 0.
  **Error injection rate: zero in this run** — every rejection class is a
  directed test at the module that owns it, because REQ-004's conservation
  criterion is stated over the frames the design accepts.

**Checks, which are REQ-004's four criteria plus the three requirements only this
level can discharge.**

1. **Conservation and delivery** (REQ-004, REQ-008): 10 000 application payload
   frames at `app_rx_payload` for 10 000 start characters at `xgmii_rx`; 10 000
   `app_rx_hdr_valid` pulses, each exactly one cycle; no word dropped; the
   top-level conservation equation of §9 balancing with every strobe term zero.
   The `clear` exemption of ledger **C-2** applies to this monitor as it does at
   every module and is not exercised by this run.
2. **Payload equality and order** (REQ-004, REQ-020): the 18 delivered octets of
   every datagram compare equal to the injected ones, and the sequence numbers
   arrive as 0, 1, 2, … with no gap and no repeat.
3. **Per-octet latency is constant** (REQ-005, REQ-111): **54** octet times for
   every octet of every lane-0-start frame and **50** for every lane-4-start
   frame, one value per lane and not a mean — the end-to-end constants §7
   derives, measured here for the first time.
4. **REQ-006's end-to-end word delay**: **13 cycles at each start lane**,
   measured between the two events REQ-006 names, for every one of the 10 000
   frames. Converted, **83.2 ns**. §7 derives 13 from five pinned constants and
   this run is what confirms the derivation against a design; a disagreement is a
   defect in whichever of the two the evidence contradicts, and the sign-off
   packet says which (REQ-019's own rule).
5. **REQ-806's report**: the measured figures from check 4, in cycles and in
   nanoseconds, for each start lane, transcribed into §12's freeze record and
   into the Phase-1 latency report. dv_lead produces and commits the numbers
   under `docs/reports/latency/`; the architect transcribes them (§11.2).
6. **No `tready` on the receive path**: structural (REQ-003, REQ-707, REQ-805,
   §4.1) — a statement about the type, not an assertion that could fail.

**Directed system tests alongside the stress run**, each owned by this level
because no lower one can run it:

- **REQ-807's XGMII observable half**: inject an ARP request for `cfg_local_ip`
  at `xgmii_rx` and decode `xgmii_tx`, asserting a well-formed ARP reply — the
  eight preamble octets exact and the start character in lane 0 (REQ-201), all
  six ARP address fields per REQ-502, a **valid FCS** (REQ-202), the terminate
  character in the lane after the last FCS octet (REQ-205), and a conforming
  inter-frame gap before the next frame (REQ-204, requirements.md §0.3). Measure
  the response interval from the request's **terminate character** to the reply's
  **start character** (requirements.md REQ-502's own reading, carry-forward
  C-23) and assert it is **7 or 8 cycles by the request's length residue**
  (SPEC-M13 §6.1's C-24 rule: 7 for N ≡ 0, 1, 2 (mod 8), else 8) and in every
  case within REQ-502's bound of 64. **The structural half of REQ-807 — that the
  request-to-reply loop is closed inside the design — is M16's** (SPEC-M16 §8,
  §10) and is claimed there, not here; this run adds the preamble, the FCS and
  the gap, which are M04's and are visible only at this boundary.
- **REQ-708's end-to-end half**: the stress run above **is** it. What makes it
  REQ-708's rather than REQ-004's is the boundary the loss is measured at —
  `app_rx_payload` — and the datagram it carries: 18 octets of UDP payload, the
  largest a minimum-length frame carries with no Ethernet padding. **The
  application-boundary half is M19's** (SPEC-M19 §8 item 1, §10) and is claimed
  there, not here; that run drives a stream a bench constructs, and this one
  drives XGMII at the arrival rate REQ-004 actually specifies.
- **REQ-809, both directions**: a UDP datagram addressed to `cfg_local_ip` and
  `cfg_listen_port` appears at `app_rx_payload` as its payload octets; and an
  application transmit request appears at `xgmii_tx` as a well-formed
  Ethernet/IPv4/UDP frame with a valid FCS. **The transmit direction primes the
  ARP cache first** — by injecting an ARP reply from the destination, or by
  transmitting once and accepting the REQ-505 discard — because the cache is
  empty after `clear` and the first datagram to an unresolved destination is
  discarded with `error_arp_miss` (§7).
- **REQ-810, all three halves at once**: drive `cfg_rx_enable` = 0 and inject 100
  frames, asserting no application word, no `app_rx_hdr_valid` and **no status
  pulse of any kind**; re-enable and assert the next frame is received. Then
  drive `cfg_tx_enable` = 0 and offer a transmit request, asserting no start
  character at `xgmii_tx` and `app_tx_payload_tready` = **0 on every cycle**
  (SPEC-M18 §4.3); re-enable and assert the held request transmits. Then, with
  transmit still disabled, inject two ARP requests for `cfg_local_ip` and assert
  that exactly one `status_error_arp_reply_dropped` pulse appears and that the
  **first** reply transmits, late, on re-enable (SPEC-M13 §11.2, requirements.md
  REQ-810).
- **REQ-804's twenty-one**: for each of the twenty-one strobes, drive its
  condition at this boundary and assert exactly that `Status` field pulses for
  exactly one cycle. This is the enumeration REQ-008 quantifies over and the one
  test that proves the aggregation of §6.1 is a rename rather than a reduction:
  no other field may pulse.
- **REQ-802 and REQ-803**: change `cfg_local_ip` mid-frame on the receive path
  and again mid-frame on the transmit path, asserting each in-flight frame
  completes under the old value and the next frame on **that path** uses the new
  one — the independence REQ-803 states in terms.
- **REQ-017's port list**: not a simulation but a repository check, listed here
  so it is not lost — parse the emitted `nic_top` module in `rtl_snapshots/` and
  set-compare its port list against §4.2. `tools/check_emitted_verilog.sh`
  already carries the check as a PENDING row until M20 is emitted.

## 9. Errors and discards

**Not applicable as a detection table.** M20 detects no condition: it forwards no
frame of its own, holds none in flight, and has no logic that could observe one.
The twenty-one `Status` fields are its children's strobes, relayed unchanged and
renamed into one record (§6.1).

| Condition | Strobe (one cycle) | Stream effect | REQ |
|---|---|---|---|
| (none detected here — the twenty-one `Status` fields below are relayed, not raised) | `status_error_bad_fcs`, `status_error_bad_frame`, `status_error_runt`, `status_error_oversize`, `status_error_start_without_terminate` (M03 via M05); `status_error_underflow` (M04 via M05); `status_error_short_frame` (M06), `status_error_unknown_ethertype` (M08), `status_error_arp_unsupported` (M10 via M13), `status_error_arp_miss`, `status_error_arp_reply_dropped` (M13), the seven `status_error_ip_*` (M14), `status_error_udp_bad_length`, `status_error_udp_port` (M17), `status_error_tx_length_mismatch` (M18) — all via M19 | none: M20 alters no stream | REQ-804, REQ-008, and each strobe's own REQ per requirements.md §12 |

Co-occurrence, precedence and multiplicity (requirements.md §0.6) are its
children's and are stated in each child's §9. M20 has no instance of §0.6's "a
module SHALL NOT re-report an inherited abort" either — renaming a strobe into a
record field is not re-reporting it, because M20 raises nothing: the pulse in a
`Status` field **is** the pulse its child raised, one cycle wide, on the same
cycle (SPEC-M05 §9's rule).

### The top-level conservation equation (carry-forward C-3, answered here for every discard on the chain at once)

Ledger item **C-3** observed that a zero-payload datagram has no accounting
observable at `nic_top`, and SPEC-M08 §11.2 deferred the top-level form of the
same question to this specification. Here is the equation, with every term named
and its observability stated:

> **frames whose start character is accepted at `xgmii_rx`**
> = (application payload frames at `app_rx_payload`)
> + (`app_rx_hdr_valid` pulses **not** followed by a payload frame)
> + (frames discarded, each reported by at least one `Status` pulse)
> + (frames consumed on the **ARP branch**)

- **Term 2 answers C-3.** A datagram whose UDP payload is zero octets emits no
  payload frame (requirements.md §0.7, REQ-011 forbids `tkeep` = 0) and is
  accounted for by its `app_rx_hdr_valid` pulse — which **is** a top-level port
  (§4.2). The observable C-3 said was missing exists; what was missing was a
  document saying which port it is. The same is true one layer down for an IPv4
  datagram of total length 20, which produces no UDP octets at all and is
  reported by `status_error_udp_bad_length` instead (SPEC-M17 §9) — so the two
  zero-payload cases land in **different** terms of this equation, and a bench
  must not expect a header pulse for the second.
- **Term 3 counts frames, not pulses.** A single frame may legitimately raise
  **two** strobes at one module — M14's seven conditions are evaluated
  independently (SPEC-M14 §9) and M17's two likewise (SPEC-M17 §9) — so a monitor
  that adds pulse counts will over-count discards and report a conservation
  failure on a conformant design. This is ledger **C-2**'s first clause, and this
  equation is where it becomes load-bearing for the whole design rather than for
  one module.
- **Term 4 is supplied by the stimulus, not observed, and that is stated rather
  than hidden.** A received ARP packet is **consumed** by M13 — learned from,
  possibly replied to — and produces no application frame and no strobe when it
  is accepted (SPEC-M10 §9, SPEC-M13 §9). It therefore has no observable at M20's
  ports at all, and a bench supplies the term from its own stimulus: it knows how
  many frames it injected with ethertype 0x0806. **This is not a REQ-008
  weakness.** REQ-008 is about *discards*, and a consumed frame is not a
  discarded one; conflating the two is what would make this equation look broken.
  An ARP packet that is **rejected** does have a strobe
  (`status_error_arp_unsupported`) and lands in term 3 like any other discard.
- **Two terms belong to the transmit direction and are not in this equation at
  all**: `status_error_underflow` and `status_error_tx_length_mismatch` report
  application transmit frames, and mixing them into a receive-path conservation
  count is the mistake SPEC-M19 §9 fact 3 exists to prevent. The transmit-side
  equation is: application datagrams offered = frames on `xgmii_tx` +
  `status_error_arp_miss` pulses + under-delivered frames (one
  `status_error_tx_length_mismatch` **and** one `status_error_underflow` each,
  ADR-0011).
- **`clear` exempts both equations** for any frame in flight when it is asserted
  (REQ-009, ledger **C-2**), which every module's §8 states for its own bench and
  which is stated once more here because the top-level monitor is the one that
  runs in every system test.

REQ-008's prohibition on silent discard is not weakened: every condition
detectable anywhere in the design is detected by some module and reported by a
`Status` field M20 exposes.

## 10. REQ coverage

| REQ | How this module satisfies it | Section | Verification hook for DV |
|---|---|---|---|
| REQ-001 | one clock, fanned to both children and thence to all nineteen modules | §6.1 | the emitted-Verilog edge-expression check over the whole hierarchy |
| REQ-003 | `xgmii_rx`, `app_rx_payload` and `app_rx_hdr` carry no `tready`; the one `Dest` is on the application transmit stream §0.4 excludes | §4.1 | interface compile check |
| REQ-004 | the top-level stress run at the XGMII boundary, 10 000 frames at the alternating 10-and-11-cycle spacing | §8 | line-rate stress bench at `nic_top` — the only one where the arrival pattern is real |
| REQ-005, REQ-111 | adds zero octet times; the end-to-end per-octet constants are 54 (lane 0) and 50 (lane 4) | §7 | §8 check 3's per-octet tagger across the whole design |
| **REQ-006** | **13 cycles at both start lanes**, derived as the sum of five pinned word delays and checked by both of §0.5's routes; 83.2 ns against a 153.6 ns budget | §7 | §8 check 4, measured between the two events REQ-006 names, both of which are M20 ports. A per-lane difference is a defect, not a legitimate variation (§7) |
| REQ-007, REQ-013 | `tuser`[0] relayed untouched in both directions | §3, §6.1 | inject a bad-FCS frame at `xgmii_rx`; assert the application frame arrives with `tuser`[0] = 1 on its last word and `status_error_bad_fcs` pulses once |
| REQ-008 | twenty-one strobes aggregated, none suppressed, none added; §9's conservation equation with its four terms | §9 | the top-level conservation monitor, counting **frames discarded** rather than pulses (C-2) and supplying the ARP term from the stimulus |
| REQ-009 | `clear` fanned to both children; no state of its own; the emptied ARP cache makes the first post-reset transmit datagram miss | §7 | the reset tests of both children, run through M20, plus REQ-809's cache-priming step |
| REQ-010 | every frame-carrying stream port uses the programme types; the two `Xgmii` lane pairs are REQ-010's class (b) and are governed by REQ-017 and REQ-012 | §4.1 | interface compile check |
| REQ-017 | the only wire-side ports are `xgmii_rxd`, `xgmii_rxc`, `xgmii_txd`, `xgmii_txc`, emitted from two `Xgmii` records with SPEC-M01's two prefixes | §4.1, §4.2 | the emitted-`nic_top` port-list check, set-compared against §4.2 (`tools/check_emitted_verilog.sh`) |
| REQ-018 | no PMA, serdes, PCS, 64b/66b, scrambler, link-training, fault-signalling or PTP logic below this module; the link partner is dv-owned under `test/` | §2, §3 | the whitelist check over the emitted hierarchy rooted here, plus the constraint-file inspection |
| REQ-019 | ΔC = 0 added; the chain is 13 cycles against 17 allocated and 24 budgeted, with the 11 unspent cycles itemised by holder | §7 | the §1.1 arithmetic at freeze; the measured chain figure in the sign-off packet, compared against the same table |
| REQ-020 | nothing reorders anywhere; the sequence-number run is a top-level run | §8 | §8 check 2 |
| **REQ-801** | exactly the ports §4.2 enumerates: clock, clear, four XGMII signals, a `Config` record, an application receive stream (`Source` only), an application transmit stream (`Source` and `Dest`) with its request fields, and a `Status` record | §4.1, §4.2 | interface compile check plus REQ-017's port-list check |
| **REQ-802** | the `Config` record carries exactly requirements.md §9.1's twelve fields at its widths; M20 is the only module whose ports carry it | §4.1, §4.3 | `tools/check_records_vs_appendix.sh` against §9.1, plus §4.1's `_witness_config_field_names`, which makes a rename fail to compile. Each field's observable effect is verified by the REQ §9.1's last column names |
| **REQ-803** | M20 holds **no** configuration register, so a change reaches every reader on the same cycle and each reader's own §4.3 rule governs; receive and transmit are independent because their readers are different modules | §4.3 | §8's mid-frame change on each path separately; the per-reader rules are SPEC-M03 §4.3, SPEC-M04 §4.3, SPEC-M13 §4.3, SPEC-M14 §4.3, SPEC-M15 §4.3, SPEC-M17 §4.3 and SPEC-M18 §4.3 |
| **REQ-804** | twenty-one `Status` fields, one per strobe, in requirements.md §12's order; the aggregation is a rename, not a reduction, because §12 gives each strobe exactly one raising module | §6.1, §9 | §8's twenty-one directed conditions, each asserting exactly one field pulses for exactly one cycle and no other field pulses |
| **REQ-805** | the application receive stream has no `tready` in the type, at the top-level port | §4.1 | interface compile check. The second sentence binds the Phase-2 consumer and has no Phase-1 observable (§11.4) |
| **REQ-806** | the REQ-006 figures are reported in cycles **and** nanoseconds, per start lane, in §12's freeze record and in the Phase-1 report | §7, §8 check 5 | process check: the numbers dv_lead commits under `docs/reports/latency/` appear in both places (§11.2) |
| REQ-807 (XGMII-observable half) | the reply's preamble, all six ARP fields, its FCS and the following gap, decoded at `xgmii_tx`, plus the REQ-502 interval measured from the request's terminate character | §8 | §8's ARP system test. **The structural half — that the loop is closed inside M16 — is M16's** (SPEC-M16 §8, §10) and is claimed there, not here |
| REQ-808 | `nic_top` is a distinct emitted module containing both children, and is the root the module-name comparison walks | §4.1, §6.1 | the `rtl_snapshots/` module-name comparison against architecture.md §4's inventory, M01 excluded |
| REQ-708 (end-to-end half) | the stress run drives XGMII at REQ-004's arrival rate and measures loss at `app_rx_payload`, with REQ-708's own 18-octet payload | §8 | §8 checks 1 and 2. **The application-boundary half is M19's** (SPEC-M19 §8 item 1, §10) and is claimed there, not here |
| **REQ-809** | a received UDP datagram appears at `app_rx_payload` as its payload octets, and an application request appears at `xgmii_tx` as a well-formed frame with a valid FCS | §8 | §8's both-directions test, with the ARP cache primed first |
| REQ-810 (configuration source) | the two enable fields enter here and are fanned to their three implementing modules | §4.3, §6.1 | §8's three-half test. **The receive half is M03's, the XGMII transmit half is M04's and the application-interface half is M18's**; all three are claimed at those modules and none here |
| REQ-903 | `.mli` plus a `hierarchical` entry point taking a `Scope.t` | §4.1 | repository surface check at `P1-module-ready` |
| REQ-901 | no divergence class of its own; the four declared classes live at M14, M12/M13, M15/M13 and M18, and the top-level comparison inherits all four | header | the co-simulation report's per-boundary table |

This table is the source of M20's rows in [`traceability.md`](../traceability.md),
updated in the same commit.

## 11. Deferred items

Item numbers are permanent; a closed item keeps its row (SPEC-TEMPLATE §11).

| # | Item | Status · what a reader assumes meanwhile | Tracked as | Owner | Closes by |
|---|---|---|---|---|---|
| 11.1 | **The `ifc_check` compile evidence for this lift is pending**: `nic_top_ifc.ml` is new in this commit and carries the first compile-time witnesses of `Config`'s twelve field names and `Status`'s twenty-one — both records were frozen at f78766e with no user until this module. | **CLOSED (WO-0022).** CI `build` run **30744579228** at **d8df28d** reports `success` with all twenty lifts in it, this one included, and the run's head SHA **is** this specification's freeze SHA. The first compile-time witnesses of `Config`'s twelve field names and `Status`'s twenty-one both elaborated on their first run, and `tools/check_records_vs_appendix.sh` continues to check the same two field lists against requirements.md §9.1 and §12 on every commit — the compile and the script now agree from two directions. | the `Interface compile check` row of §12 | architect_docs_lead, rtl_lead | closed |
| 11.2 | **REQ-806 requires *measured* end-to-end figures in this specification's freeze record, and no RTL exists at spec freeze.** §7 derives 13 cycles / 83.2 ns at both start lanes from five pinned constants; the measured figures come from dv_lead's REQ-006 bench. | **DEFERRED — the derived figures are stated, sourced and reproducible today, and nothing downstream is blocked.** A reader designing to this specification implements against 13 cycles and knows exactly which five constants it is the sum of. The measured pair is transcribed into §12's freeze record and into the Phase-1 latency report when dv_lead commits it under `docs/reports/latency/` (REQ-806's own process split: dv produces, the architect transcribes). **A measured figure that differs from 13 is a defect, not a correction** — REQ-019's rule says the packet names which of the two the evidence contradicts — and the derivation is here so that the comparison has something to be against. | REQ-806; `docs/reports/latency/` | architect_docs_lead, dv_lead | M20's `P1-module-ready` |
| 11.3 | **Eleven of REQ-006's twenty-four cycles are unspent** — 7 the architect's slack, 4 held as module reserve at M03, M14 and M17 (§7) — and requirements.md §1.1 still allocates 17 where 13 are used. | **DEFERRED, and deliberately not re-allocated at this gate.** A reader takes §1.1's ceilings as binding and §7's table as the actual chain; the two disagree by 4 cycles and that is a *reserve*, which is a different thing from slack and is recorded as such at each module. Re-allocating now would move numbers in **three** documents (requirements.md §1.1, architecture.md §4, and each module's §7) to give cycles to stages that have not asked for them, immediately before a freeze gate, and would destroy the property that makes the table useful: that a module which later needs a cycle can take it from its own reserve by an ordinary spec diff instead of a slack release. The right moment to tighten §1.1 is after the first `P1-module-ready`, when measured word delays exist for all five stages. | requirements.md §1.1; architecture.md §4 | architect_docs_lead | first `P1-module-ready`, or a spec diff that needs the slack |
| 11.4 | **REQ-805's second sentence has no Phase-1 observable.** "The consumer is required to accept one word per cycle indefinitely" binds the Phase-2 feed handler; Phase 1 has no consumer to test and the absence of `tready` is structural rather than behavioural. | **DEFERRED — requirements.md REQ-805 states this in terms and `traceability.md`'s row reaches COVERED on the interface check alone.** Meanwhile a reader implements the port with no `tready` and a bench asserts the type, not the behaviour. The item closes when a Phase-2 consumer exists and can be stalled deliberately to show what breaks — which is a Phase-2 test and not a Phase-1 gap. Recorded so that no sign-off packet claims behavioural coverage of the second sentence. | REQ-805; `traceability.md` | architect_docs_lead, dv_lead | Phase-2 attach |
| 11.5 | **No management interface exists**: `Config` and `Status` are flat records at ports, so a platform that wants register access must build the adapter outside this module. | **DEFERRED — Phase 1 needs none and nothing is blocked.** A reader drives `cfg_*` from the bench or from constants and observes `status_*` directly, which is what every Phase-1 test does. REQ-802 and REQ-804 specify records and not registers, deliberately: a register file would be state at the top level with no requirement behind it (§6.3 item 4). If a later phase attaches real hardware, the adapter is a new module above this one and is a scope change (E2), not a diff here — which is why this row exists rather than a placeholder port. | this item; requirements.md §9.1 | architect_docs_lead | Phase-3 attach (E2) |

## 12. Freeze record

Filled in at `P1-spec-freeze`. All four rows are required (charter §5).

| Item | Value |
|---|---|
| Interface compile check | CI `build` run **30744579228**, conclusion **`success`**, SHA **d8df28d** — every lift in the single `ifc_check` library elaborates, the four batch-F lifts among them; per ADR-0005 a local build is not acceptable evidence. **The run's head SHA is this specification's freeze SHA**, so no witnessing argument is owed. This run is also §11.1's closure record |
| Architect signature | `J-architect_docs_lead-0008` |
| dv_lead testability countersignature | **`J-dv_lead-0011`** (WO-0022) — batch F **COUNTERSIGNED at d8df28d**. This specification was **SIGNED on its own merits at WO-0020** (`J-dv_lead-0010`) — REQ-006's 13-cycle close at both lanes re-derived — and is unchanged since |
| Frozen at | SHA **d8df28d**, gate `docs/gates/P1-spec-freeze-checklist.md` |
| **REQ-806 measured end-to-end latency** | pending — lane-0 start: `<n>` cycles / `<t>` ns; lane-4 start: `<n>` cycles / `<t>` ns. §7 derives **13 cycles / 83.2 ns at both lanes**; the measured pair is transcribed here from `docs/reports/latency/` (REQ-806, §11.2). This is a fifth row required by REQ-806 in addition to the template's four |

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
