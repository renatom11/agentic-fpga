# SPEC-M01 — `Axi64`

- **Status**: DRAFT
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

## 1. Purpose

M01 turns the four fabric-level agreements of this programme — how a frame's
octets are carried, how a header's fields are presented, how the design is
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
| The XGMII lane pair `xgmii_rxd`[63:0] / `xgmii_rxc`[7:0] and its transmit twin (REQ-017) | SPEC-M03, SPEC-M04, SPEC-M05 and SPEC-M20, which declare them as plain vectors; architecture.md §4 gives M01 no XGMII record (see §11.1) |
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
- **`create` and `hierarchical` (REQ-903, REQ-808): not applicable.** M01 is
  types-only and instantiates nothing, so there is no entry point to declare and
  no `module type S`. REQ-808's own text excludes it from the emitted-Verilog
  inventory for the same reason.

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
is ignored elsewhere. No Phase-1 module drops or alters a frame because this bit
is set on its input; it is advisory metadata carried to the application, and its
propagation obligation is REQ-007's.

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
| REQ-802 | `Config` carries exactly the twelve fields of requirements.md §9.1 at those widths, with the `cfg_` prefix | §4.1, §4.2 | interface compile check of the record against §9.1, field for field; each field's observable effect is verified by the REQ §9.1 names |
| REQ-804 | `Status` carries one field per strobe of requirements.md §12, named as §12 names it | §4.1, §4.2 | field-set comparison against §12 in the compile check, plus REQ-804's twenty-one directed pulses at M20 |
| REQ-808 | M01 is types-only and is excluded from the emitted-module list by REQ-808's own text | §3 | the `rtl_snapshots/` module-name comparison, with M01 absent |

This table is the source of M01's rows in [`traceability.md`](../traceability.md).
**The matrix is not updated in this commit**: WO-0006 fixes its file set to the
two specs, the two lifts and the packet, so the rows for REQ-010 … REQ-014 and
REQ-802 still read `pending` in the Spec-section column. The update is owed
before `P1-spec-freeze` and is recorded as §11.2 and in the WO-0006 Return log.

## 11. Open questions

| # | Question | Owner | Closed by |
|---|---|---|---|
| 11.1 | **Should M01 also home the XGMII lane pair?** architecture.md §4 gives M01 no XGMII record, so `xgmii_rxd`[63:0]/`xgmii_rxc`[7:0] and their transmit twins will be declared field by field in SPEC-M03, SPEC-M04, SPEC-M05 and SPEC-M20 — four restatements of one pair of widths, which is the duplication REQ-010 rejects for streams. Batch B is where the cost becomes visible. Resolving it in favour of a record is a spec diff to this file and to architecture.md §4's M01 row. | architect_docs_lead | SPEC-M03 (batch B) |
| 11.2 | **Traceability rows for REQ-010 … REQ-014 and REQ-802 still read `pending`.** SPEC-TEMPLATE §10 requires the matrix to be updated in the same commit as the spec; WO-0006's file set excludes `traceability.md`. Either the next spec work order carries the matrix update for batches A and B together, or a small architect work order does batch A alone. | orchestrator (work-order scope), architect_docs_lead (content) | `P1-spec-freeze` |
| 11.3 | **The template's named open target `Ifc_check_axi64` does not exist.** SPEC-TEMPLATE §4.1's comment tells later specs to write `open Ifc_check_axi64`, but rule 6 names the file `<module>_ifc.ml` and `docs/specs/ifc_check/dune` wraps the library as `ifc_check`, so the module other lifts must open is `Axi64_ifc` — which is what this spec and SPEC-M02 use. The template needs a one-line editorial diff; it is not a spec diff to any module. | architect_docs_lead | `P1-spec-freeze` |
| 11.4 | **`Axi64.Source`'s field names are `hardcaml_axi`'s and are so far unverified by compilation.** The names `tvalid`, `tdata`, `tkeep`, `tstrb`, `tlast`, `tuser`, `tready` are transcribed from `stream_intf.ml` as recorded in architecture.md §10; the CI run that proved the template block compiles used the type without naming a field, so a divergence in v0.17.0 would not have been caught. §4.2 and §6.1 quote those names normatively. The first lift that names a field — or rtl_lead's first construction of a `Source` — settles it; a divergence is an editorial diff to §4.2, not a change of meaning. | architect_docs_lead, rtl_lead | SPEC-M03 (batch B) |

## 12. Freeze record

Filled in at `P1-spec-freeze`. All four rows are required (charter §5); this spec
is DRAFT and none is filled.

| Item | Value |
|---|---|
| Interface compile check | pending — CI `build` run `<id>`, conclusion `<success>`, SHA `<sha>`; per ADR-0005 a local build is not acceptable evidence |
| Architect signature | pending |
| dv_lead testability countersignature | pending |
| Frozen at | pending — SHA `<sha>`, gate `docs/gates/P1-spec-freeze-checklist.md` |

## 13. Change log

Post-freeze changes only. This spec is DRAFT and has none.

| Date | Change | Breaking? | ADR | Journal |
|---|---|---|---|---|
| — | — | — | — | — |
