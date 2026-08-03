# SPEC-M01 — `Axi64`

- **Status**: **FROZEN** (`P1-spec-freeze`, SHA `f78766e`) — batch A, dv_lead
  countersignature `J-dv_lead-0003` extended over the `Xgmii` addition by
  `J-dv_lead-0005`. Changes to §4, §6 or §7 after this point are spec diffs
  recorded in §13 (SPEC-TEMPLATE rule 7)
- **Inventory id**: M01 (architecture.md §4) · **Path**:
  `libs/hardcaml_ethernet/src/axi64.ml`
- **Datapath role**: shared/structural (types only — no circuit)
- **Owns REQs**: REQ-010, REQ-011, REQ-012, REQ-013, REQ-014, REQ-802
- **Prior-art counterpart**: none. alexforencich/verilog-ethernet (MIT) carries
  frame data on flat Verilog ports (`*_axis_tdata`, `*_axis_tkeep`, …) and has
  no types module to be a counterpart; nothing was consulted for this
  specification beyond the field naming already recorded in architecture.md §10,
  and no source was copied.
- **Depends on specs**: none. M01 is the root of the specification dependency
  order (architecture.md §8 batch A).
- **Author**: architect_docs_lead, journal `J-architect_docs_lead-0003`
  (WO-0006, original) and `J-architect_docs_lead-0004` (WO-0008: the `Xgmii`
  record, C-8, C-9, C-10 and the §11 reconciliation)

## 1. Purpose

M01 turns the five fabric-level agreements of this programme — how a frame's
octets are carried, how the XGMII lane pair is carried, how a header's fields
are presented, how the design is
configured and how its error events are reported — into OCaml types that every
other module's port record is built from. It exists as a separate module because
those agreements are shared by all nineteen other modules: written once they are
one vocabulary, written per module they are nineteen dialects, and REQ-010
prohibits the dialects explicitly.

M01 has no position in the receive or transmit chain: it instantiates no logic
and appears in no instance hierarchy (architecture.md §6.3, REQ-808). It has no
upstream and no downstream module. Its consumers are the `I` and `O` records of
M02 through M20 and, through them, every bench dv_lead writes.

## 2. Scope

**In scope.**

- The programme stream type `Axi64` — `Hardcaml_axi.Stream.Make` applied once at
  `data_bits` = 64 and `user_bits` = 1 (REQ-010), and the rule that receive-path
  ports take `Axi64.Source` alone (REQ-003).
- The meaning of every field of that stream: `tdata` octet order (REQ-012),
  `tkeep` (REQ-011), `tlast` (REQ-015), `tuser`[0] (REQ-013), `tstrb` (REQ-014).
- The `Xgmii` record — one lane pair, one direction — and its lane-to-bit
  mapping (REQ-017, REQ-012), so that the four wire-side port names REQ-017
  fixes are produced by a type rather than by four hand-written restatements
  (§11.1).
- The three header records `Eth_header`, `Ip_header`, `Udp_header`: which fields
  exist, at what width, and in what numeric encoding (REQ-012, REQ-409).
- The `Config` record: exactly the twelve fields of requirements.md §9.1 at the
  widths stated there (REQ-802), and the `cfg_` port prefix that makes REQ-802's
  `cfg_ifg` name true.
- The `Status` record: one field per strobe of requirements.md §12, named exactly
  as §12 names it (REQ-804).

**Not this module's job.**

| Behaviour a reader might expect here | Owner |
|---|---|
| Producing or consuming any stream word; asserting any field | every module M02–M20, in its own specification |
| The timing of a header record's `valid` pulse (one cycle per frame, on or before the first payload word) | the emitting module: M06 (REQ-401), M14 (REQ-606), M17 (REQ-701) |
| Raising any strobe named in the `Status` record | the module named in requirements.md §12's last column |
| Driving `Config`, and holding it stable while a frame is in flight (REQ-803) | M20 `Nic_top` and the bench above it |
| The reset values and permitted ranges of `Config` fields | requirements.md §9.1, which this record's widths follow; a record has no storage and therefore no reset value of its own (REQ-009) |
| The application transmit **request** fields — destination address, ports, payload length (REQ-705) | SPEC-M18 and SPEC-M20, per requirements.md §0.1 |
| *Driving* the XGMII lane pair, decoding its control characters, or deciding what a start, terminate or error character means | SPEC-M03 (receive) and SPEC-M04 (transmit). M01 declares the `Xgmii` **record** that carries the pair (§4.1, decided at §11.1) and fixes nothing about its contents |
| The maximum word count of any particular stream (REQ-015) | the specification of the module that produces that stream, per requirements.md §0.1 |
| The `rtlprefix` used for a stream or header record at a given port | the specification that declares that port (§6.3) |

## 3. Programme invariants that bind this module

M01 is **not** a receive-path module under requirements.md §0.4: §0.4 defines the
receive path as a chain of modules and the streams between them, and M01 is on
no chain because it has no ports at all. The template's receive-path minimum
(REQ-003, REQ-004, REQ-005, REQ-007, REQ-019, REQ-021) therefore does not bind
M01 as behaviour; where such an invariant is nonetheless made *expressible* by a
type declared here, the row below says so.

| REQ | Consequence for M01 |
|---|---|
| REQ-001 | M01 declares no `clock` port, because it declares no port; each module's own `I` record carries `clock` and this specification fixes nothing about it. |
| REQ-002 | `Axi64_config.data_bits` = 64 is the single place the datapath width is written down; a module that wants another width cannot obtain it from this module. |
| REQ-003 | `Axi64.Source` and `Axi64.Dest` are separate types, so a receive port can be declared with no `tready` in it. This is the type-level half of REQ-003; the behavioural half is REQ-004's stress at the modules that own streams. |
| REQ-009 | M01 declares no state and no register; there is nothing here for `clear` to act on. |
| REQ-010 | **Owned.** This specification is the definition REQ-010 names: one `Stream.Make` application, quoted by every other spec, with ad-hoc per-module stream records prohibited by having a shared one to use. |
| REQ-011 | **Owned.** §6.1 fixes `tkeep`'s width and meaning; the obligation to drive it contiguously falls on each producer. |
| REQ-012 | **Owned.** §6.1 fixes the octet-to-`tdata` mapping and the numeric encoding of every header-record field. |
| REQ-013 | **Owned.** `user_bits` = 1 and §6.1 fixes bit 0's meaning; no module may reuse `tuser` for anything else without a spec diff to this file. |
| REQ-014 | **Owned.** `tstrb` exists in the type because `Hardcaml_axi.Stream.Make` puts it there; §6.1 states it is driven to 0 and ignored. |
| REQ-015 | One `tlast` per frame is a producer obligation; M01 supplies the field and no counting. |
| REQ-016 | Idle words are expressed as `tvalid` = 0 on a `Source`, which needs no separate type; M01 adds nothing further. |
| REQ-017 | The `Xgmii` record (§4.1) is the type the four wire-side ports are declared from. Its field names `d` and `c` under the instantiation prefixes `xgmii_rx` and `xgmii_tx` emit exactly `xgmii_rxd`, `xgmii_rxc`, `xgmii_txd`, `xgmii_txc` — the four names REQ-017's port-list check compares against. M01 declares the type; the port list itself is SPEC-M20's. |
| REQ-021 | Word alignment is a property of what a producer puts in `tdata`[7:0]; M01 supplies the octet-position convention (§6.1) that makes "aligned" mean one thing at every port. |
| REQ-802 | **Owned.** The `Config` record is the record REQ-802 quantifies over; requirements.md §9.1 remains the normative source of widths, reset values and ranges. |
| REQ-804 | The `Status` record is the field list REQ-804 requires. M01 names the twenty-one strobes; it raises none. |
| REQ-808 | M01 is types-only and is excluded by REQ-808's own words from the emitted-Verilog module list; it must not appear in `rtl_snapshots/`. |

## 4. Interface

### 4.1 Interface records

```ocaml
(* SPEC-M01 §4.1, lifted verbatim into docs/specs/ifc_check/axi64_ifc.ml
   (SPEC-TEMPLATE.md rule 6). Records and signatures only — no logic, no
   implementation.

   This file is the programme's single types home: every other module
   spec's lift writes [open! Axi64_ifc] and restates none of these
   records. M01 declares no [I], no [O] and no [module type S], because it
   has no circuit and therefore no ports and no entry points (§4.2, §6.2).

   [open!] rather than [open] on both lines below: this file declares no
   entry point, so neither [Base] nor [Hardcaml] is necessarily referenced
   outside the code [@@deriving hardcaml] generates. *)

open! Base
open! Hardcaml

(* ---- the stream fabric (REQ-002, REQ-010) ----
   [Hardcaml_axi.Stream.Make] yields
     Axi64.Source = { tvalid; tdata; tkeep; tstrb; tlast; tuser }
     Axi64.Dest   = { tready }
   A receive-path port carries [Axi64.Source] alone; the absence of a
   matching [Dest] is how REQ-003 is enforced structurally. *)

module Axi64_config = struct
  let data_bits = 64
  let user_bits = 1
end

module Axi64 = Hardcaml_axi.Stream.Make (Axi64_config)

(* ---- the XGMII lane pair (REQ-017, REQ-018) ----
   One record for one direction. The field names are IEEE 802.3's
   [RXD]/[RXC], lower-cased to [d] and [c], so that the instantiation
   prefixes [@rtlprefix "xgmii_rx"] and [@rtlprefix "xgmii_tx"] emit
   exactly [xgmii_rxd], [xgmii_rxc], [xgmii_txd], [xgmii_txc] — the four
   port names REQ-017 fixes. Longer field names cannot produce them.
   [c] bit k is the control indication for lane k, whose octet is
   [d][8k+7:8k]: the same octet-position convention [tdata] uses
   (REQ-012, §6.1). *)

module Xgmii = struct
  type 'a t =
    { d : 'a [@bits 64]
    ; c : 'a [@bits 8]
    }
  [@@deriving hardcaml]
end

(* ---- header records: numeric values, network byte order already
   decoded (REQ-012, REQ-409) ---- *)

module Eth_header = struct
  type 'a t =
    { valid : 'a
    ; dst_mac : 'a [@bits 48]
    ; src_mac : 'a [@bits 48]
    ; ethertype : 'a [@bits 16]
    }
  [@@deriving hardcaml]
end

module Ip_header = struct
  type 'a t =
    { valid : 'a
    ; src_ip : 'a [@bits 32]
    ; dst_ip : 'a [@bits 32]
    ; protocol : 'a [@bits 8]
    ; ttl : 'a [@bits 8]
    ; dscp : 'a [@bits 6]
    ; total_length : 'a [@bits 16]
    }
  [@@deriving hardcaml]
end

module Udp_header = struct
  type 'a t =
    { valid : 'a
    ; src_port : 'a [@bits 16]
    ; dst_port : 'a [@bits 16]
    ; length : 'a [@bits 16]
    ; checksum : 'a [@bits 16]
    }
  [@@deriving hardcaml]
end

(* ---- configuration (REQ-802). Widths here; reset values and permitted
   ranges are requirements.md §9.1 and are not restated. Instantiated with
   [@rtlprefix "cfg_"], which is what makes REQ-802's [cfg_ifg] name
   true. ---- *)

module Config = struct
  type 'a t =
    { local_mac : 'a [@bits 48]
    ; local_ip : 'a [@bits 32]
    ; subnet_mask : 'a [@bits 32]
    ; gateway_ip : 'a [@bits 32]
    ; multicast_group : 'a [@bits 32]
    ; multicast_enable : 'a
    ; listen_port : 'a [@bits 16]
    ; accept_all_ports : 'a
    ; ttl : 'a [@bits 8]
    ; ifg : 'a [@bits 8]
    ; rx_enable : 'a
    ; tx_enable : 'a
    }
  [@@deriving hardcaml]
end

(* ---- status (REQ-804): one field per strobe of requirements.md §12,
   named exactly as §12 names it, in §12's order. Twenty-one fields for
   twenty-one conditions. ---- *)

module Status = struct
  type 'a t =
    { error_bad_fcs : 'a
    ; error_bad_frame : 'a
    ; error_runt : 'a
    ; error_oversize : 'a
    ; error_start_without_terminate : 'a
    ; error_underflow : 'a
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
```

Conformance of this block to the template's rules for §4.1:

- Scalar fields carry `[@bits n]` unless one bit wide — held throughout.
- `[@rtlprefix]` is a property of an *instantiation site*, and M01 has none; the
  one prefix this specification fixes for all sites is `Config`'s `cfg_` (see
  §4.2 and REQ-802). Every other prefix is named by the specification declaring
  the port (§6.3).
- Receive-path ports take `Axi64.Source` without `Axi64.Dest`: M01 makes that
  expressible by keeping the two records distinct; it declares no such port
  itself.
- **`create` and `hierarchical`: not applicable. The `.mli` is not.** M01 is
  types-only and instantiates nothing, so there is no entry point to declare and
  no `module type S`; REQ-903's amended text excludes types-only modules from
  the `hierarchical` half by name, and REQ-808's text excludes M01 from the
  emitted-Verilog inventory for the same reason. REQ-903's **`.mli` half is not
  excluded and is not vacuous here**: `libs/hardcaml_ethernet/src/axi64.mli` is
  the file that fixes which of these records are exported and at what widths,
  which is the thing REQ-010 leans on at every other module, so it is required
  and §10 carries the row. This is carry-forward **C-8**, raised by dv_lead
  against the previous wording of this bullet (which cited REQ-808 for an
  exclusion REQ-808 did not make) and closed by the REQ-903 diff in this
  work order.

### 4.2 Port table

**Not applicable as a port table.** M01 declares no module boundary, so no field
below has a direction: direction is fixed where the record is used, and the same
`Eth_header` is an output of M06 and an input of M07. The tables below are the
field tables the template's port table becomes for a types-only module; every
field of every record in §4.1 appears exactly once.

**`Axi64.Source`** (from `Hardcaml_axi.Stream.Make`; the field names are
`hardcaml_axi`'s, not this programme's — see §11.4)

| Field | Width | Meaning | REQ |
|---|---|---|---|
| `tvalid` | 1 | this cycle carries a word of a frame; 0 is an idle cycle | REQ-016 |
| `tdata` | 64 | eight octet positions; octet k of the word occupies `tdata`[8k+7:8k], and the first octet received from the wire is at k = 0 | REQ-012 |
| `tkeep` | 8 | bit k is 1 when octet position k carries a valid octet; contiguous from bit 0, `0xFF` on every word except the one carrying `tlast`, 1 to 8 ones there, never 0 while `tvalid` = 1 | REQ-011 |
| `tstrb` | 8 | reserved and unused in this design: every producer drives 0, every consumer ignores it | REQ-014 |
| `tlast` | 1 | this word carries the final octets of the frame | REQ-015 |
| `tuser` | 1 | bit 0 means "this frame was found invalid; the ultimate consumer must discard it"; meaningful only on the word carrying `tlast` and ignored on every other word | REQ-013 |

**`Axi64.Dest`**

| Field | Width | Meaning | REQ |
|---|---|---|---|
| `tready` | 1 | the consumer accepts a word this cycle. Present on transmit-path streams only; a receive-path port carries no `Dest`, and that absence is REQ-003 | REQ-003, REQ-207 |

**`Xgmii`** (driven by the DV link-partner model into M03/M05/M20; driven by
M04 outward. One record per direction; instantiated `[@rtlprefix "xgmii_rx"]`
on a receive port and `[@rtlprefix "xgmii_tx"]` on a transmit port, which is
what makes REQ-017's four port names exact.)

| Field | Width | Meaning | REQ |
|---|---|---|---|
| `d` | 64 | eight XGMII lanes; lane k is `d`[8k+7:8k], and lane 0 is the earlier octet on the wire — the same octet-position convention `tdata` uses | REQ-012, REQ-017 |
| `c` | 8 | bit k is 1 when lane k carries a **control** character rather than a data octet; the control characters this programme names are `/I/` 0x07, `/S/` 0xFB, `/T/` 0xFD, `/E/` 0xFE and `/Q/` 0x9C (requirements.md §2) | REQ-017, REQ-113 |

**`Eth_header`** (emitted by M06, consumed by M08; built by M07)

| Field | Width | Meaning | REQ |
|---|---|---|---|
| `valid` | 1 | the other fields of this record are the header of a frame now in progress; its timing is the emitting module's contract, not M01's | REQ-401 |
| `dst_mac` | 48 | destination MAC as a numeric value, first wire octet most significant | REQ-012, REQ-409 |
| `src_mac` | 48 | source MAC, same encoding | REQ-012, REQ-409 |
| `ethertype` | 16 | ethertype as a numeric value; 0x0800 reads as 0x0800 | REQ-012, REQ-404 |

**`Ip_header`** (emitted by M14, consumed by M17; built by M15)

| Field | Width | Meaning | REQ |
|---|---|---|---|
| `valid` | 1 | as `Eth_header.valid`, for an IPv4 datagram | REQ-606 |
| `src_ip` | 32 | source IPv4 address as a numeric value; 192.0.2.1 reads as 0xC0000201 | REQ-012, REQ-606 |
| `dst_ip` | 32 | destination IPv4 address, same encoding | REQ-012, REQ-604 |
| `protocol` | 8 | IPv4 protocol number; 17 is UDP | REQ-607 |
| `ttl` | 8 | time to live, as received | REQ-606 |
| `dscp` | 6 | differentiated services code point — the upper six bits of the type-of-service octet. The two ECN bits are not carried: REQ-606 lists six fields and ECN is not one of them | REQ-606 |
| `total_length` | 16 | IPv4 total length in octets, header included, as received | REQ-605, REQ-612 |

**`Udp_header`** (emitted by M17, consumed by the application; built by M18)

| Field | Width | Meaning | REQ |
|---|---|---|---|
| `valid` | 1 | as `Eth_header.valid`, for a UDP datagram | REQ-701 |
| `src_port` | 16 | UDP source port as a numeric value | REQ-701 |
| `dst_port` | 16 | UDP destination port as a numeric value | REQ-701, REQ-704 |
| `length` | 16 | UDP length field in octets, the 8-octet header included, as received | REQ-703 |
| `checksum` | 16 | UDP checksum field as received, presented and never verified on receive; the transmit path drives 0 | REQ-702, REQ-706 |

**`Config`** — instantiated with `[@rtlprefix "cfg_"]` at every site, so field
`ifg` emits port `cfg_ifg` (REQ-802, REQ-204). Reset values and permitted ranges
are requirements.md §9.1 and are not restated here; the "Behaviour given by"
column of §9.1 names the REQ that gives each field an observable effect.

**Where the whole record travels and where single fields do (programme
convention, established here so batches B–F do not each invent one).** Only
M20 `Nic_top` declares the `Config` record itself: it is the module REQ-802
quantifies over and the only one whose port list REQ-801 fixes. Every other
module declares **exactly the fields it reads**, as scalar inputs named
`cfg_<field>` — `cfg_rx_enable`, `cfg_ifg`, `cfg_tx_enable` and so on — at the
width §9.1 gives that field. The reason is REQ-803: "configuration is static
while a frame is in flight" is checked per module against the fields that
module actually samples, and a module carrying ten fields it never reads makes
that check unanswerable while adding a hundred tied-off port bits at every
level of the hierarchy. The naming rule keeps REQ-802's `cfg_ifg` name true
wherever the field appears, so a bench driving the top level and a bench
driving M04 alone use the same port name.

| Field | Width | Meaning | REQ |
|---|---|---|---|
| `local_mac` | 48 | the MAC this design answers ARP for and sources frames from | REQ-802, REQ-502 |
| `local_ip` | 32 | the IPv4 address this design accepts datagrams for and answers ARP for | REQ-802, REQ-604 |
| `subnet_mask` | 32 | contiguous prefix mask deciding on-subnet versus off-subnet | REQ-802, REQ-507 |
| `gateway_ip` | 32 | resolution target for off-subnet destinations | REQ-802, REQ-507 |
| `multicast_group` | 32 | the single IPv4 multicast group accepted when `multicast_enable` is 1 | REQ-802, REQ-604 |
| `multicast_enable` | 1 | enables acceptance of `multicast_group` | REQ-802, REQ-604 |
| `listen_port` | 16 | accepted UDP destination port | REQ-802, REQ-704 |
| `accept_all_ports` | 1 | accept every UDP destination port | REQ-802, REQ-704 |
| `ttl` | 8 | TTL written into transmitted datagrams | REQ-802, REQ-608 |
| `ifg` | 8 | transmit inter-frame gap in octets, counted from the terminate character inclusive; values below 12 are prohibited | REQ-802, REQ-204 |
| `rx_enable` | 1 | when 0 the receive path accepts no frame | REQ-802, REQ-810 |
| `tx_enable` | 1 | when 0 the transmitter begins no new frame | REQ-802, REQ-810 |

**`Status`** — twenty-one one-bit fields, each named exactly as requirements.md
§12 names the strobe, in §12's order. Each is one cycle high per event of the
condition §12 gives it, raised by the module §12 names, and aggregated at M20
(REQ-804). The field names are normative (requirements.md §0.2); the `rtlprefix`
at M20's instantiation site is SPEC-M20's to fix (§6.3). No field is added,
renamed or removed here — §12 is the list, and it is not restated field by field
in this table because a second copy of twenty-one normative names is a second
place for them to drift.

### 4.3 Configuration inputs

**None.** M01 reads no configuration: it has no ports and no behaviour to
configure. It *declares* the `Config` record other modules read; when a change to
that record takes effect is REQ-803's answer, evaluated independently per path,
and it is restated in each consuming module's specification.

## 5. Parameters

The two functor arguments of `Axi64_config` are compile-time parameters in the
OCaml sense. Neither is overridable by a test: a run at another width is not a
run of this programme.

| Parameter | Type | Default | Range | Why a test overrides it |
|---|---|---|---|---|
| `Axi64_config.data_bits` | `int` | 64 | exactly 64 | Never. REQ-002 fixes the datapath width and REQ-004's arrival rate is derived from it; a different value makes every latency and throughput requirement in requirements.md false. |
| `Axi64_config.user_bits` | `int` | 1 | exactly 1 | Never. REQ-013 gives `tuser` exactly one bit of meaning; a wider `tuser` would carry bits no requirement defines. |

Nothing else in this specification is parameterised: header-record widths are
protocol field widths, and `Config` field widths are requirements.md §9.1's.

## 6. Behaviour

### 6.1 Normal path

M01 has no behaviour in the sense of a datapath: no input becomes an output,
because there is no circuit. There is therefore **no cycle-by-cycle table** — no
sequencing exists to tabulate. What follows is the encoding contract the records
carry, stated once here so that no other specification restates it and so that a
test writer holding only this section can build stimulus and check results.

**Octet positions and octet order (REQ-012, REQ-021).** The first octet of a
frame received from the wire occupies `tdata`[7:0] of the first word of that
frame; the eighth occupies `tdata`[63:56]. Octet position k means `tdata`[8k+7:8k]
for k in 0 to 7. Every stream is word-aligned at its producer: the first octet of
whatever the producer is carrying is at position 0 of the producer's first word,
including after a header of 14, 20 or 8 octets has been stripped (REQ-021). The
octet-time definition of requirements.md §0.5 — 8 × cycle + position — is written
against exactly this mapping.

**`tkeep` (REQ-011).** `tkeep`[k] = 1 exactly when position k carries an octet.
On every word with `tvalid` = 1 the ones are contiguous from bit 0; on every such
word except the one carrying `tlast` the value is `0xFF`; on the `tlast` word it
is 1 to 8 contiguous ones. `tkeep` = 0 with `tvalid` = 1 is never produced, which
is why a zero-octet frame has no encoding and is reported the way
requirements.md §0.7 states instead.

**`tlast` (REQ-015).** One word per frame carries `tlast` = 1, and it is the word
carrying the frame's final octets. The words between two successive `tlast` words
are the words of exactly one frame.

**`tuser`[0] (REQ-013).** 1 means the frame was found invalid and the ultimate
consumer must discard it. It is meaningful only on the word carrying `tlast` and
is ignored elsewhere. No Phase-1 module drops or alters a frame **solely**
because this bit is set on its input; it is advisory metadata carried to the
application, and its propagation obligation is REQ-007's.

*The word "solely" is load-bearing and is REQ-013's own* (carry-forward
**C-10**). It does not say an aborted frame always reaches the application: a
module that detects a discard condition **of its own** on the same frame
discards it under requirements.md §0.6's local-discard rule and pulses its own
strobe, and that is not a reaction to `tuser`[0]. A monitor built from this
paragraph alone must therefore assert "a frame is not dropped *because of*
`tuser`", never "an aborted frame is always delivered" — the second is false at
every stage that owns a discard condition, and asserting it produces a false
failure against a conformant design.

**`tstrb` (REQ-014).** Present in the type because `Hardcaml_axi.Stream.Make`
defines it; driven to 0 by every producer and ignored by every consumer. The
differential run REQ-014 commissions — same stimulus with `tstrb` = 0x00 and
0xFF, byte-identical output traces — is the test that this stays true.

**Header-record encoding (REQ-012, REQ-409).** Every multi-octet protocol field
in a header record is a numeric value with network byte order already decoded:
the first octet of the field on the wire is the most significant octet of the
value. The three worked examples REQ-012 pins are MAC 00:11:22:33:44:55 reading
as 0x001122334455, IPv4 192.0.2.1 reading as 0xC0000201, and ethertype 0x0800
reading as 0x0800. A consumer of a header record therefore never shuffles octets,
and a bench comparing a field against a hand-computed value compares numbers.

**`valid` in a header record.** The field means "the other fields of this record
describe a frame now in progress". Its *timing* — exactly one cycle per frame, on
or before the cycle carrying that frame's first payload word, and within the
emitting module's pinned latency of the input `tlast` for a frame with no payload
words — is REQ-401, REQ-606 and REQ-701, owned by M06, M14 and M17 respectively.
M01 fixes the meaning; it cannot fix the timing, because timing belongs to a
circuit and M01 has none.

**The XGMII lane pair (REQ-017, REQ-012).** `d` carries eight lanes with lane k
at `d`[8k+7:8k] and lane 0 the earlier octet on the wire, so the octet-time
definition of requirements.md §0.5 — 8 × cycle + lane — reads against `d`
exactly as it reads against `tdata`. `c`[k] = 1 marks lane k as a control
character. M01 fixes the mapping and nothing else: which control characters are
legal where, which lanes may carry a start character, and what any of them mean
are SPEC-M03's and SPEC-M04's (REQ-101 … REQ-113, REQ-201 … REQ-210). There is
no `valid` on this record — an XGMII lane pair carries a value on every cycle
of every clock, which is why it is not a stream and carries no `tvalid`,
`tkeep` or `tready`.

**`Config` (REQ-802, REQ-803).** Twelve fields, widths in §4.2, reset values and
permitted ranges in requirements.md §9.1. A value outside a field's permitted
range is a configuration error whose behaviour is unspecified, and `cfg_ifg`
below 12 is not driven at all. Configuration is static while a frame is in
flight, evaluated independently on the receive and transmit paths (REQ-803).

**`Status` (REQ-804, REQ-008).** Twenty-one one-bit fields, one per condition of
requirements.md §12, each high for exactly one cycle per event, inside the timing
window requirements.md §0.6 fixes. The record is the enumeration REQ-008
quantifies over, which is why it is a record and not a set of loose ports: a
condition with no field here would be a silent discard.

### 6.2 State machine

**Not applicable.** M01 declares types and no logic, so it has no state, no reset
state and no behaviour on `clear`: there is nothing for `clear` to act on
(REQ-009). This is the same statelessness REQ-306 states for M02, one level
further removed — M02 is a function with no state, M01 is not a function at all.

### 6.3 Deliberately unconstrained

Anything not listed here is constrained by this specification, and a test may
rely on it.

1. **The `rtlprefix` of every stream and header-record port**, except `Config`'s
   `cfg_` (§4.2). Each specification names the prefixes of its own ports; the
   template's example uses `rx_`, `payload_` and `hdr_`, and those are
   illustrations, not reservations.
2. **The `rtlprefix` M20 applies to the `Status` record.** The *field* names are
   normative (REQ-804, requirements.md §0.2); the emitted port names at the top
   level are SPEC-M20's to fix.
3. **The order of fields within each record.** It is fixed in §4.1 for
   readability and for diff stability, and Hardcaml addresses fields by name; a
   test must not depend on declaration order, bit packing or any flattened
   layout.
4. **Whether a module passes a whole record or its fields individually inside its
   own implementation.** The port record is the contract; internal plumbing is
   rtl_lead's.
5. **The value of `tdata` at octet positions where `tkeep` is 0**, and the value
   of every field of a `Source` on a cycle with `tvalid` = 0. No requirement
   constrains them and no monitor may assert on them; REQ-011's monitor is
   evaluated only on words with `tvalid` = 1.

## 7. Timing contract

**Not applicable in every clause, for one reason: M01 declares no circuit, so it
has no port at which an event could be timed.** The template's five clauses are
answered individually below, each naming where the contract does live, so that a
reader who came here looking for one is not left to guess.

- **Latency**: not applicable. M01 is not a receive-path module (§3) and adds no
  octet times to any path; the per-octet constants REQ-005 and REQ-111 require
  are pinned in the specifications of the modules that have ports.
- **Throughput**: not applicable. M01 accepts nothing. The one-word-per-cycle
  property is a property of the *type* (REQ-002) and the arrival rate is
  REQ-004's, checked at the modules in requirements.md §0.4's list.
- **Handshake rules**: not applicable. `tvalid`/`tready` behaviour, field
  stability and idle-gap tolerance (REQ-016) are stated per port in the
  specification declaring it. M01 fixes only what the fields *mean* (§6.1).
- **Reset**: not applicable. No state (§6.2). REQ-009's obligations fall on
  modules that hold registers.
- **Configuration sampling**: not applicable. M01 reads no configuration (§4.3);
  REQ-803's sampling rule binds each consumer of the `Config` record.

## 8. Line-rate stress obligation

**Not applicable.** M01 is not in requirements.md §0.4's stress-bench list (M03,
M06, M08, M10, M14, M17, M20), and it could not be: a bench drives ports, and M01
has none. Its content is exercised in every one of those benches, because every
stream and header record they drive and check is an instance of these types, and
the REQ-011/013/014 protocol monitors that run inside them are written against
§6.1.

## 9. Errors and discards

**Not applicable.** M01 forwards no frame and can therefore discard, truncate or
abort none; there is no abnormal condition it could detect and no strobe it could
raise, so the table below is empty rather than merely unfilled. REQ-008's
prohibition on silent discard is not weakened by this: M01 *declares* the
`Status` record that makes every discard in the design observable (§6.1), and the
twenty-one conditions are owned by the modules requirements.md §12 names.

| Condition | Strobe (one cycle) | Stream effect | REQ |
|---|---|---|---|
| (none — see above) | — | — | — |

Co-occurrence, precedence and multiplicity (requirements.md §0.6) likewise have
no instance here: with no condition detected locally, there is nothing to order.

## 10. REQ coverage

Every REQ this module owns, plus every programme invariant from §3. The
verification hook column names what dv_lead derives from the row; where M01's
contribution is a type rather than a behaviour, the hook is the interface compile
check (`docs/specs/ifc_check/axi64_ifc.ml`, ADR-0005: a green CI run is the
evidence) and the row says which module's bench carries the behavioural half.

| REQ | How this module satisfies it | Section | Verification hook for DV |
|---|---|---|---|
| REQ-002 | `Axi64_config.data_bits` = 64, applied once; no other width is obtainable | §4.1, §5 | interface compile check |
| REQ-003 | `Source` and `Dest` are distinct records, so a receive port can be declared without `tready` | §4.2 | interface compile check per receive-path port, in each such module's spec; behavioural half is REQ-004's stress |
| REQ-009 | no state declared | §6.2 | not applicable — the reset test runs at modules that hold registers |
| REQ-010 | one `Hardcaml_axi.Stream.Make` application, quoted by every other spec's `I`/`O` | §4.1 | interface compile check, including REQ-010's type-identity witness `let _check (x : Signal.t Axi64.Source.t) = x` at each stream port in the *consuming* spec's lift |
| REQ-011 | `tkeep` width and contiguity meaning fixed | §6.1 | protocol monitor on every stream in every bench, evaluated on `tvalid` = 1 words |
| REQ-012 | octet-position mapping and header numeric encoding fixed, with REQ-012's three worked examples | §6.1 | known-frame directed test at M06/M14/M17 comparing a MAC and an IPv4 field |
| REQ-013 | `user_bits` = 1; bit 0's meaning and its `tlast`-only significance fixed | §6.1 | monitor plus REQ-013's two directed tests, run at the modules that produce streams |
| REQ-014 | `tstrb` declared, driven 0, ignored | §6.1 | REQ-014's differential run (`tstrb` 0x00 versus 0xFF, byte-identical traces) |
| REQ-015 | `tlast` declared with one-frame-between-`tlast`s meaning; per-stream maxima deferred to the producing spec | §6.1 | protocol monitor on every stream |
| REQ-016 | idle expressed as `tvalid` = 0; no extra type needed | §6.1 | idle-injection wrapper at 0, 1 and 7 cycles, at each module boundary |
| REQ-021 | octet-position convention makes "word-aligned" mean one thing at every port | §6.1 | directed realignment tests at M06, M14, M17 |
| REQ-017 | the `Xgmii` record's field names, under the two instantiation prefixes, emit exactly the four wire-side port names REQ-017 fixes | §4.1, §4.2, §6.1 | REQ-017's emitted-Verilog port-list check at `nic_top`, set-compared against SPEC-M20 §4.1; the compile check witnesses only the widths |
| REQ-802 | `Config` carries exactly the twelve fields of requirements.md §9.1 at those widths, with the `cfg_` prefix | §4.1, §4.2 | **two mechanisms, because one cannot do it.** The interface compile check witnesses that the record exists and that each field has the width written here. The equality of the *field list and order* against requirements.md §9.1 is a text comparison an OCaml compile cannot perform — it is the dv-owned `tools/` record-versus-appendix script of carry-forward **C-9** (WO-0009), run in CI. Each field's observable effect is verified by the REQ §9.1's last column names |
| REQ-804 | `Status` carries one field per strobe of requirements.md §12, named as §12 names it | §4.1, §4.2 | same two mechanisms as REQ-802: widths and existence by compile check, the twenty-one-name set-and-order equality against §12 by the C-9 script (WO-0009); plus REQ-804's twenty-one directed pulses at M20 |
| REQ-808 | M01 is types-only and is excluded from the emitted-module list by REQ-808's own text | §3 | the `rtl_snapshots/` module-name comparison, with M01 absent |
| REQ-903 | **`.mli` half only.** `axi64.mli` exports these records and their widths and is required; the `hierarchical` half does not apply, and REQ-903's amended text excludes types-only modules from it by name (C-8) | §4.1 | the repository-surface check at `P1-module-ready`, in its two parts: `.mli` present for every inventory module including M01; `hierarchical` exported by every module except M01 |

This table is the source of M01's rows in [`traceability.md`](../traceability.md),
whose Spec-section column is filled for every row above in the same commit as
this revision (WO-0008, closing §11.2).

## 11. Deferred items

Under the amended SPEC-TEMPLATE §11: item numbers are permanent, closed items
keep their row, and no item below is an open question — each states what a
reader assumes today.

| # | Item | Status · what a reader assumes meanwhile | Tracked as | Owner | Closes by |
|---|---|---|---|---|---|
| 11.1 | **Should M01 also home the XGMII lane pair?** The alternative was four field-by-field restatements of one pair of widths in SPEC-M03, SPEC-M04, SPEC-M05 and SPEC-M20 — the duplication REQ-010 rejects for streams. | **CLOSED (WO-0008), in favour of the record.** Batch B made the cost visible on schedule: M03, M04 and M05 all needed the pair, M20 would have been the fourth. The `Xgmii` record is declared in §4.1 with fields `d` and `c`, and the two instantiation prefixes `xgmii_rx` / `xgmii_tx` emit REQ-017's four port names exactly — a longer field name could not. architecture.md §4's M01 row is amended in the same commit. | WO-0008 | architect_docs_lead | closed |
| 11.2 | **Traceability rows for the REQs this spec covers read `pending` in the Spec-section column**, against SPEC-TEMPLATE §10's same-commit rule, because WO-0006's file set excluded the matrix. | **CLOSED (WO-0008).** `traceability.md`'s Spec-section column now names a section of this specification for every row in §10. | WO-0008 | architect_docs_lead | closed |
| 11.3 | **The template named an open target, `Ifc_check_axi64`, that cannot exist**: rule 6 names lifts `<module>_ifc.ml` and `docs/specs/ifc_check/dune` declares `(name ifc_check)`, so the module a sibling lift opens is `Axi64_ifc`. | **CLOSED (WO-0008).** SPEC-TEMPLATE §4.1 and its lift `template_ifc.ml` now both say `open! Axi64_ifc`, which is what every real lift already used. Editorial; no module's contract changed. | WO-0008 | architect_docs_lead | closed |
| 11.4 | **`Axi64.Source`'s and `Axi64.Dest`'s field names are `hardcaml_axi`'s and were unverified by any compile.** `tvalid`, `tdata`, `tkeep`, `tstrb`, `tlast`, `tuser`, `tready` were transcribed from `stream_intf.ml` via architecture.md §10; run 30727252770 elaborated the functor application without naming a field, so a v0.17.0 divergence would not have been caught, and §4.2 and §6.1 quote the names normatively. | **CLOSED (WO-0010).** CI `build` run **30729342467** at **f78766e** reports `success`, and that build contains both witnesses — `xgmii_rx_64_ifc.ml` names all six `Source` fields, `xgmii_tx_64_ifc.ml` names `Dest.tready`. A v0.17.0 spelling divergence would have failed it. §4.2's names are now established by a run, not by transcription. **CORROBORATED at WO-0044, and the routed premise corrected — annotation, not rewrite.** `J-dv_lead-0025` routed this item to me as though it were still open, quoting it as "SPEC-M01 §11.4 has carried `Axi64.Source`'s six field names as *transcribed and unverified by compilation* since M01", and offering CI `build` run **30769770945** at **5c37b22** as its **first** discharge. **The premise is stale and this row's closure date does not move.** The quoted phrase is this row's *Item* cell, which states the original problem in the past tense and is permanent under SPEC-TEMPLATE §11; the *Status* cell has read CLOSED since **f78766e**, which is the freeze SHA itself. What run 30769770945 genuinely adds is recorded rather than discarded: it resolves all six labels **at an independent site** — `test/xgmii_rx_64/bench.ml`, a DV-side library with its own `dune`, its own opens and the `ppx_jane` path a real bench compiles through, projecting the fields off a port of an **instantiated** M03 — whereas the WO-0010 witness is `docs/specs/ifc_check/xgmii_rx_64_ifc.ml`, a library that is compiled but never instantiated and that belongs to the same file family which transcribed the names in the first place. As *name checks* the two are equal in force: both resolve the labels against the real `Hardcaml_axi.Stream.Make (…) .Source`, so a v0.17.0 spelling divergence fails either one. The increment is **site independence, not proof strength**, and it is recorded here as corroboration rather than as a discharge of something that was open. One consequential item, in another agent's scope: `tools/precompile_stubs/ifc_check.ml` quotes this row's *Item* cell as if it were its *Status* ("SPEC-M01 §11.4 already records as transcribed and unverified by compilation") — that note has been stale since **f78766e**, not since 30769770945, and it is dv_lead's file to correct. | WO-0008; the `Interface compile check` row of §12 is the closure record; corroboration routed by `J-dv_lead-0025` under WO-0044 | architect_docs_lead, rtl_lead | closed |
| 11.5 | **§10's REQ-802 and REQ-804 hooks named the interface compile check as the mechanism for comparing these records against requirements.md §9.1 and §12** — an OCaml compile cannot read a markdown table (dv_lead, WO-0007). | **CLOSED (WO-0010) on both halves.** §10 names the two mechanisms separately; dv_lead's `tools/check_records_vs_appendix.sh` exists, is wired into the `build` workflow (00d7a7f) and runs green — `Status = §12 (21 strobes, same order)` and `Config = §9.1 (12 fields, widths in order)` — reported at f44a296 in the WO-0010 Return log and re-run in run 30730405776. The records in §4.1 remain the authority and the appendices the source; the equality is now machine-checked at every SHA rather than by review. | ledger **C-9**, script under WO-0009 | dv_lead (script), architect_docs_lead (hook wording) | closed |

## 12. Freeze record

Filled in at `P1-spec-freeze`. All four rows are required (charter §5).

| Item | Value |
|---|---|
| Interface compile check | CI `build` run **30729342467**, conclusion **`success`**, SHA **f78766e** — this revision's §4.1, `Xgmii` record included, elaborated together with the four lifts that quote it. Per ADR-0005 a local build is not acceptable evidence. This row is also §11.4's closure record |
| Architect signature | `J-architect_docs_lead-0004` — signed for freeze conditional on the row above reporting `success`, which it does |
| dv_lead testability countersignature | `J-dv_lead-0003` (WO-0007, at 22145b5), **extended to the `Xgmii` addition and this revision's other diffs by `J-dv_lead-0005`** (WO-0010, verdict (b) ACCEPTED after diffing 22145b5..f78766e over both batch-A specs and both lifts) |
| Frozen at | SHA **f78766e**, gate `docs/gates/P1-spec-freeze-checklist.md` |

**How this spec reached FROZEN.** The §11 blocker dv_lead raised at WO-0007 was
cleared under the amended SPEC-TEMPLATE §11 (WO-0008); the remaining two rows
were evidence rather than reconciliation, and both arrived at WO-0010 — run
30729342467 green at f78766e, and dv_lead's dual-batch countersignature over
that same SHA. The Status line and this table are the transcription of those
two facts; nothing was decided here.

## 13. Change log

Post-freeze changes only. Each row cites the ADR that authorised it; a breaking
interface change is counted against post-freeze churn (charter §6). This spec
has had **no breaking change and no change to any record in §4.1**; the single
row below annotates a *closed* §11 item and moves no normative text. The
sentence this paragraph used to carry — "this spec has had none" — was true
when written and is corrected rather than left standing, because a frozen
specification asserting a count that its own change log contradicts is the
failure this section exists to prevent. The WO-0011 diff cycle touched
requirements.md, SPEC-M03 and SPEC-M04 and left every record in §4.1
byte-for-byte unchanged, which is why the four batch-C lifts could open
`Axi64_ifc` without a re-freeze.

| Date | Change | Breaking? | ADR | Journal |
|---|---|---|---|---|
| 2026-08-03 | **§11.4 annotated with a second, independent compile witness** — `J-dv_lead-0025` routed CI `build` run **30769770945** at **5c37b22** as this item's first discharge, on a reading of the row's permanent *Item* cell rather than its *Status* cell. The run is recorded as **corroboration at an independent site** (`test/xgmii_rx_64/bench.ml`, an instantiated M03 port in a DV-side library) and the stale premise is corrected in place; the closure record, its run id (**30729342467**) and its SHA (**f78766e**) are untouched, and §12's `Interface compile check` row still governs. The consequential stale note in `tools/precompile_stubs/ifc_check.ml` is named in the row and left to its owner | no — **record-only**: no record, port, width, requirement hook or normative sentence moves, and §11.4 was already `closed` before and after | none — recorded-miss convention, annotate and do not erase; the underlying decision was made at WO-0008/WO-0010 and needs no new authority. **ADR-0015** is the work order's ADR and does not authorise this row | `J-architect_docs_lead-0014` |
