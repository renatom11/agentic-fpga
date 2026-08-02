# SPEC-M14 — `Ip_eth_rx_64`

- **Status**: **FROZEN** (`P1-spec-freeze`, SHA `3f6accc`) — batch E, dv_lead
  countersignature `J-dv_lead-0009` (WO-0018), **SIGNED** on this specification's
  own merits with every number re-derived. Changes to §4, §6 or §7 after this
  point are spec diffs recorded in §13 (SPEC-TEMPLATE rule 7)
- **Inventory id**: M14 (architecture.md §4) · **Path**:
  `libs/hardcaml_ethernet/src/ip_eth_rx_64.ml`
- **Datapath role**: receive
- **Owns REQs**: REQ-601, REQ-602, REQ-603, REQ-604, REQ-605, REQ-606, REQ-607,
  REQ-611, REQ-612
- **Prior-art counterpart**: `ip_eth_rx_64.v` (MIT) — consulted for decomposition
  and port naming only; behaviour below is stated independently and no source
  was copied. One declared REQ-901 divergence class lives here: **(a)** IPv4
  header checksum verification, which the reference does not perform (REQ-602),
  so co-simulation stimulus is restricted to datagrams with correct header
  checksums
- **Depends on specs**: SPEC-M01 (`Axi64`, `Eth_header`, `Ip_header`), SPEC-M06
  (`Eth_axis_rx`, whose header-record contract this module's producer preserves),
  SPEC-M08 (`Eth_demux`, its immediate producer), SPEC-M10 (the sibling branch,
  for the open/close device §6.1 reuses)
- **Author**: architect_docs_lead, journal `J-architect_docs_lead-0007`

## 1. Purpose

M14 turns the payload stream of an Ethernet frame carrying ethertype 0x0800 into
an IPv4 **header record** plus a **payload stream** carrying exactly the octets
the datagram declares: it validates the six things REQ-601 … REQ-607 and REQ-612
make acceptance criteria, presents the six header fields as decoded numeric
values, strips the 20-octet header, discards the Ethernet padding the datagram's
own length exposes, and realigns what remains (REQ-021). It exists as a separate
module for the same reason M06 does — the IPv4 header is not a multiple of eight
octets, so the realignment REQ-021 demands has to live somewhere, and this is the
second of the three places it does (M06 strips 14, M14 strips 20, M17 strips 8).

Its upstream is M08 `Eth_demux` (through M16's `rx` relay, architecture.md
§6.4.1); its downstream is M17 `Udp_ip_rx_64` (through M16's `ip_rx_*` relay).
It instantiates nothing.

## 2. Scope

**In scope.**

- Validating a received datagram against REQ-601 (version, header length **and
  the total-length lower bound: a declared total length below 20 is REQ-601's
  discard class, ADR-0013**), REQ-602 (header checksum), REQ-603 (fragments),
  REQ-604 (destination filter), REQ-607 (protocol) and REQ-612 (maximum size —
  the upper bound of the same field), and discarding a failing datagram with the
  strobe each REQ names (§9).
- Presenting source address, destination address, protocol, TTL, DSCP and total
  length in an `Ip_header` record whose `valid` pulses for exactly one cycle per
  accepted datagram (REQ-606, REQ-012).
- Delivering exactly (total length − 20) payload octets, discarding any Ethernet
  padding beyond that, and reporting a frame that ends early (REQ-605).
- Realigning that payload so its first octet is at `ip_payload_tdata`[7:0] of the
  payload stream's first word (REQ-021), at every datagram length.
- Carrying an inherited abort through to the payload stream's `tlast` word
  (REQ-007, REQ-013) **on the class that word can still carry it — §6.1's
  D ≤ 0 — and driving a derived 0 on the class it cannot, D ≥ 1 (§6.2, §11.5,
  ADR-0012)**.
- Doing all of that at the single pinned per-octet constant of §7 (REQ-005,
  REQ-611, REQ-019).

**Not this module's job.**

| Behaviour a reader might expect here | Owner |
|---|---|
| Routing on the ethertype, or knowing that 0x0800 means IPv4 | M08 `Eth_demux` (REQ-404). By the time a payload reaches M14 the routing decision is made; M14 never reads `hdr_ethertype` |
| Removing the *Ethernet* padding as such | M14 does remove it, but not as padding: it delivers total length − 20 octets and stops (REQ-605). It is the datagram's own length field that exposes the padding, which is why REQ-408 leaves it in place at M06 |
| Verifying the UDP checksum, filtering on port, or knowing what a port is | M17 `Udp_ip_rx_64` (REQ-701 … REQ-704). M14 checks the protocol number and nothing above it |
| Reassembling fragments | **nobody** — fragments are discarded (REQ-603, requirements.md §11). There is no reassembly buffer and no state that would hold one |
| ICMP, or answering anything | **nobody** in Phase 1 (REQ-607, requirements.md §11). A non-UDP datagram is discarded with a strobe and no reply of any kind |
| Building an IPv4 header for transmission, or computing a checksum to insert | M15 `Ip_eth_tx_64` (REQ-608 … REQ-610). M14 and M15 share the `Ip_header` record and nothing else, and the record's `valid` has a **different discipline** in the two directions (§7, ADR-0008) |
| Resolving the destination MAC, or knowing one exists | M13 `Arp` (REQ-505 … REQ-509). M14 is a receive module and never looks at a MAC address at all |
| Acting on the inherited abort bit `payload_tuser`[0] | M14 relays it to the payload `tlast` word — where §6.1's D ≤ 0 lets that word carry it, and a derived 0 otherwise (§6.2, §11.5) — and acts on nothing (REQ-013, REQ-007). The ultimate consumer on this branch is the application (REQ-707), reached through M17; unlike the ARP branch, this one has one, which is why REQ-013's clause needs no local discharge here (ADR-0009) |

## 3. Programme invariants that bind this module

M14 is a receive-path module under requirements.md §0.4 — the branch M08 routes
IPv4 frames onto — and both its payload input and its payload output are
receive-path streams. It is one of the seven modules owing a line-rate stress
bench (§0.4, REQ-905).

| REQ | Consequence for M14 |
|---|---|
| REQ-001 | One `clock`. Every register in §7's pipeline is synchronous to it. |
| REQ-002 | Input and payload output are 64-bit `Axi64` streams, at most one word per cycle each. |
| REQ-003 | The payload output is `Axi64.Source` **without** `Axi64.Dest`, and the input carries no `tready`: M17 cannot stall M14 and M14 cannot stall M08, structurally (§4.1). |
| REQ-004 | M14 is on requirements.md §0.4's stress-bench list. Its stimulus is what M08 emits on its `ip_*` ports under REQ-004's arrival pattern, derived by construction and never re-invented (§8). |
| REQ-005 | Cut-through: no payload word is withheld to the end of its datagram. The per-octet latency is the single constant **L = 12 octet times** of §7, at every datagram length and content M14 accepts. A rejected datagram is rejected before any word is emitted, so REQ-005 has no instance for it. |
| REQ-007 | An abort inherited on the input `tlast` word is carried to the payload stream's own `tlast` word (§9) **where that word is emitted after the input `tlast` is presented — §6.1's D ≤ 0. §6.1 scopes the copy, §6.2 states what M14 emits otherwise, §11.5 records the consequence for REQ-007's universal and ADR-0012 decides it.** M14 originates no abort of its own except REQ-605's truncation, which it marks the same way and which is always available to it. |
| REQ-008 | M14 owns **seven** of the twenty-one strobes (requirements.md §12) — more than any other Phase-1 module — and §9 pins every pulse cycle. |
| REQ-009 | Synchronous `clear`. On every cycle `clear` = 1 and on the first cycle it is 0: `ip_payload_tvalid` = 0, `ip_hdr_valid` = 0 and all seven strobes are 0. A datagram in flight is abandoned with no `tlast` and no strobe; a datagram whose first word arrives on the first cycle after `clear` returns to 0 is received correctly (§7). |
| REQ-010 | Both streams are the programme `Axi64.Source`; the input header is SPEC-M01's `Eth_header` and the output header is SPEC-M01's `Ip_header`, both unchanged. **M14 declares no record of its own** (§4.1). |
| REQ-011 | `ip_payload_tkeep` is `0xFF` on every payload word except the `tlast` word, where it is 1 to 8 contiguous ones from bit 0. |
| REQ-012 | Input octet position k is `payload_tdata`[8k+7:8k], IPv4 octet 0 at k = 0 of input word 0; every header field is presented as a numeric value with network byte order already decoded (§6.1). |
| REQ-013 | `payload_tuser`[0] is read on the input `tlast` word and written on the payload `tlast` word **where §6.1's D ≤ 0 puts that word after the input `tlast`; on D ≥ 1 that word leaves on or before the input `tlast` is presented and carries a derived 0 (§6.2, §11.5)**. M14 never drops a datagram because it is set, which is REQ-013's own sentence, and it is not the ultimate consumer on this branch — the application is (REQ-707). |
| REQ-014 | `payload_tstrb` is ignored on the input and driven to 0 on the payload output. |
| REQ-015 | One `tlast` per payload frame, the `tlast` word included in the count; at most **185** words between two `tlast` words on the payload stream (1480 octets — the 1500-octet maximum total length less the 20-octet header — is 185 words, 184 full and a final eight-octet word), at least one. |
| REQ-016 | The input may carry idle cycles inside a datagram and M14 tolerates them: k idle cycles before an input word delay every octet that word carries by exactly 8k octet times and change nothing else (§7). §6.1's cycle formulas are stated on a gapless stimulus; §7's **per-octet constant L = 12** holds on every stimulus, while §7's 3-cycle **parse latency** is scoped to a header delivered on consecutive cycles and grows by the injected count when idle lands inside it (carry-forward **C-27**). |
| REQ-017, REQ-018 | No instance: M14 sees no lane, no control character and nothing below XGMII. |
| REQ-019 | Word delay ΔC = (L + h)/8 = (12 + 20)/8 = **4** cycles against a ceiling of **5** (requirements.md §1.1) — M14 holds **one cycle of reserve inside its own allocation**, which §7 and §11.2 state as a decision rather than leave to be discovered. Payload storage is **two** datapath words: payload octets 0–7 span input words 2 and 3, which is the whole reason the depth is two rather than one (REQ-019 permits two). |
| REQ-020 | Datagrams leave in the order they arrived; M14 holds one datagram's header at a time (§6.2), so reordering is not expressible. |
| REQ-021 | **The realignment obligation, second instance.** M14 strips 20 octets, which is not a multiple of 8, so the payload's first octet is at input octet position 4 of input word 2 and must be emitted at `ip_payload_tdata`[7:0] of payload word 0. Every payload word is assembled from two input words (§6.1). |

## 4. Interface

### 4.1 Interface records

```ocaml
(* SPEC-M14 §4.1, lifted verbatim into docs/specs/ifc_check/ip_eth_rx_64_ifc.ml
   (SPEC-TEMPLATE.md rule 6). Records and signatures only — no logic, no
   implementation.

   [Axi64_ifc] is M01's types home (SPEC-M01 §4.1): [Axi64], [Eth_header]
   and [Ip_header] all come from there and are restated nowhere. Batch E
   declares NO new record: the declare-once rule batch D adopted
   (SPEC-M10 §4.1, §11.2) is honoured here by having nothing to declare,
   because M01 froze [Ip_header] at f78766e and this module's two header
   ports are exactly M01's two records. Nothing in a FROZEN §4.1 is
   touched, and the batch-A/B compile evidence still witnesses both.

   Receive-path module: [payload] and [ip_payload] are [Axi64.Source]
   and there is no [Axi64.Dest] anywhere in either record, which is
   REQ-003 structurally. Both header records carry a [valid] and no
   [ready] for the same reason: on this path nothing may stall its
   producer. *)

open! Base
open Hardcaml
open! Axi64_ifc

module I = struct
  type 'a t =
    { clock : 'a
    ; clear : 'a
    ; hdr : 'a Eth_header.t [@rtlprefix "hdr_"]
    ; payload : 'a Axi64.Source.t [@rtlprefix "payload_"]
    ; cfg_local_ip : 'a [@bits 32]
    ; cfg_subnet_mask : 'a [@bits 32]
    ; cfg_multicast_group : 'a [@bits 32]
    ; cfg_multicast_enable : 'a
    }
  [@@deriving hardcaml]
end

module O = struct
  type 'a t =
    { ip_hdr : 'a Ip_header.t [@rtlprefix "ip_hdr_"]
    ; ip_payload : 'a Axi64.Source.t [@rtlprefix "ip_payload_"]
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
  val create : Scope.t -> Signal.t I.t -> Signal.t O.t
  val hierarchical : ?instance:string -> Scope.t -> Signal.t I.t -> Signal.t O.t
end

(* REQ-010 type identity at both stream ports, and the first compile-time
   witness that [Ip_header]'s seven field names are what SPEC-M01 §4.2
   writes — the record was frozen with no user until this batch. *)

let _witness_streams_are_the_programme_type
      (x : Signal.t Axi64.Source.t)
      (y : Signal.t Axi64.Source.t)
  =
  x, y
;;

let _witness_ip_header_field_names (h : Signal.t Ip_header.t) =
  let open Ip_header in
  [ h.valid; h.src_ip; h.dst_ip; h.protocol; h.ttl; h.dscp; h.total_length ]
;;
```

Conformance of this block to the template's rules for §4.1:

- Scalar fields carry `[@bits n]` unless they are one bit wide: `clock`,
  `clear`, `cfg_multicast_enable` and the seven strobes are one bit; the three
  `cfg_` addresses carry 32, and every other field is inside a nested record
  carrying its own widths.
- Nested interfaces carry `[@rtlprefix]`: `hdr` emits `hdr_valid` …
  `hdr_ethertype`, `payload` emits `payload_tvalid` … `payload_tuser`, `ip_hdr`
  emits `ip_hdr_valid` … `ip_hdr_total_length`, and `ip_payload` emits
  `ip_payload_tvalid` … `ip_payload_tuser`. **The output header and payload are
  prefixed `ip_` and the inputs are not**, which is what keeps the emitted port
  names distinct: an output record prefixed `hdr_` would collide with the input's
  `hdr_valid` in the same Verilog module. architecture.md §6.4.1's two rows
  naming M14's outputs are amended to `M14.ip_hdr` and `M14.ip_payload` in the
  same commit as this specification, which is the confirm-or-amend obligation
  §6.4 places on every batch.
- **Receive-path `Source` without `Dest`: held.** Neither record contains an
  `Axi64.Dest` and neither contains a `tready` field. An M14 that wanted
  backpressure could not be written without changing this record, which is a
  spec diff — REQ-003.
- Both `create` and `hierarchical` are declared (REQ-903, REQ-808).

### 4.2 Port table

Every port in §4.1 appears exactly once. Direction is with respect to M14.

| Port | Dir | Width | Meaning | REQ |
|---|---|---|---|---|
| `clock` | in | 1 | 156.25 MHz single domain | REQ-001 |
| `clear` | in | 1 | synchronous clear | REQ-009 |
| `hdr_valid` | in | 1 | a frame routed here begins; this pulse **opens** a datagram (§6.1). The only field of this record M14 reads | REQ-401, REQ-404 |
| `hdr_dst_mac` | in | 48 | present because M08 relays the whole record; **read by nothing** here — REQ-407 forbids Ethernet-layer filtering and REQ-604 filters on the IPv4 destination | REQ-407 |
| `hdr_src_mac` | in | 48 | same; read by nothing. Learning from a source MAC is the ARP branch's business (REQ-503) | REQ-407 |
| `hdr_ethertype` | in | 16 | same; read by nothing — the routing decision was M08's (REQ-404) and is not revisited | REQ-404 |
| `payload_tvalid` | in | 1 | this cycle carries a payload word | REQ-016 |
| `payload_tdata` | in | 64 | payload octets; IPv4 octet 0 at position 0 of payload word 0 | REQ-012, REQ-021 |
| `payload_tkeep` | in | 8 | valid octet positions, contiguous from bit 0; read to count delivered octets against total length | REQ-011 |
| `payload_tstrb` | in | 8 | reserved; ignored | REQ-014 |
| `payload_tlast` | in | 1 | this word carries the frame's final octets; **closes** a datagram (§6.1) | REQ-015 |
| `payload_tuser` | in | 1 | bit 0: inherited abort, meaningful only on the `tlast` word; **copied out where §6.1's D ≤ 0 and dropped where D ≥ 1** (§6.2, §11.5), never acted on | REQ-013, REQ-007 |
| `cfg_local_ip` | in | 32 | the configured local IPv4 address; the first accepted destination and the base of the subnet-broadcast address | REQ-604, REQ-802 |
| `cfg_subnet_mask` | in | 32 | contiguous prefix mask; with `cfg_local_ip` it fixes the subnet-broadcast address REQ-604 accepts | REQ-604, REQ-802 |
| `cfg_multicast_group` | in | 32 | the one multicast group accepted when multicast is enabled | REQ-604, REQ-802 |
| `cfg_multicast_enable` | in | 1 | 0 disables the multicast acceptance case entirely | REQ-604, REQ-802 |
| `ip_hdr_valid` | out | 1 | one cycle high per **accepted** datagram, one cycle before its first payload word; the other six fields are that datagram's | REQ-606 |
| `ip_hdr_src_ip` | out | 32 | source address, first wire octet most significant | REQ-606, REQ-012 |
| `ip_hdr_dst_ip` | out | 32 | destination address, same encoding | REQ-606, REQ-012 |
| `ip_hdr_protocol` | out | 8 | protocol number; **17** on every accepted datagram, because REQ-607 discards the rest | REQ-606, REQ-607 |
| `ip_hdr_ttl` | out | 8 | time to live as received; M14 neither decrements nor checks it — Phase 1 does not forward | REQ-606 |
| `ip_hdr_dscp` | out | 6 | the six DSCP bits of octet 1; the two ECN bits are not carried (SPEC-M01's record has no field for them) | REQ-606 |
| `ip_hdr_total_length` | out | 16 | total length as received, in octets, header included | REQ-606, REQ-605 |
| `ip_payload_tvalid` | out | 1 | this cycle carries a payload word | REQ-016 |
| `ip_payload_tdata` | out | 64 | payload octets, the first octet after the IPv4 header at position 0 | REQ-021, REQ-605 |
| `ip_payload_tkeep` | out | 8 | valid octet positions, contiguous from bit 0 | REQ-011 |
| `ip_payload_tstrb` | out | 8 | reserved; driven to 0 | REQ-014 |
| `ip_payload_tlast` | out | 1 | this word carries the payload's final octets | REQ-015 |
| `ip_payload_tuser` | out | 1 | bit 0: the inherited abort, or REQ-605's truncation, on the `tlast` word — **inherited by copy only where §6.1's D ≤ 0; driven to 0 on the class whose payload `tlast` word leaves on or before the input `tlast` is presented, D ≥ 1 (§6.2, §11.5)**. REQ-605's truncation mark is M14's own and is unaffected | REQ-007, REQ-013, REQ-605 |
| `error_ip_bad_header` | out | 1 | one-cycle strobe: version not 4, header length not 5 words, **or a declared total length below 20** — the third condition is this specification's extension of REQ-601's class and is decided on the same input word (§6.1, §9, ADR-0013) | REQ-601 |
| `error_ip_bad_checksum` | out | 1 | one-cycle strobe: the header checksum does not verify | REQ-602 |
| `error_ip_fragment` | out | 1 | one-cycle strobe: more-fragments set, or a non-zero fragment offset | REQ-603 |
| `error_ip_not_for_us` | out | 1 | one-cycle strobe: the destination is none of REQ-604's four accepted addresses | REQ-604 |
| `error_ip_truncated` | out | 1 | one-cycle strobe: the frame ended before total length was satisfied | REQ-605 |
| `error_ip_bad_protocol` | out | 1 | one-cycle strobe: protocol is not 17 | REQ-607 |
| `error_ip_oversize` | out | 1 | one-cycle strobe: total length above 1500 | REQ-612 |

### 4.3 Configuration inputs

M14 reads **four** fields of the `Config` record (requirements.md §9.1), as
scalars, exactly as architecture.md §6.4.3 routes them.

| Field | Effect | When a change takes effect (REQ-803) |
|---|---|---|
| `cfg_local_ip` | REQ-604's first accepted destination, and with the mask the base of the subnet-broadcast address | sampled on the input word carrying IPv4 octets 16–19 — input word 2 — which is the cycle the destination test is evaluated. A change landing at least one cycle before that word applies to that datagram; a change landing on the word itself is deliberately unconstrained (§6.3 item 6) |
| `cfg_subnet_mask` | with `cfg_local_ip`, the subnet-broadcast address `cfg_local_ip \| ~cfg_subnet_mask` REQ-604 accepts | same word, same rule |
| `cfg_multicast_group` | the one multicast destination accepted when multicast is enabled | same word, same rule |
| `cfg_multicast_enable` | 0 removes the multicast case from REQ-604's list; the group value is then irrelevant | same word, same rule |

**The subnet-broadcast formula is written in two specifications and is one
formula.** SPEC-M13 §6.1's class-2 test — `d` = `l` \| ~`m` — and REQ-604's
subnet-broadcast acceptance here are the same arithmetic on the same two
configuration fields, which is why both modules read both fields and why a mask
change lands on the transmit and receive sides consistently. REQ-803's
receive/transmit independence is unaffected: the two samplings are on different
paths and no frame is in flight across both.

**`cfg_subnet_mask` at M14 is a control edge this batch adds** to
architecture.md §6.4.3, which routed the mask only to M13. REQ-604's
subnet-broadcast clause cannot be evaluated without it, so the row is an
amendment rather than a proposal, made in the same commit as this specification
(§6.4's confirm-or-amend rule). §11.4 tracks the wrapper hops.

## 5. Parameters

**None.** REQ-506's rule — timeouts and ageing intervals must be compile-time
parameters so tests can use short values — has no instance: M14 has no timeout,
no interval and no retry. The numeric constants it contains (4, 5, 20, 17, 1500
and the field offsets of §6.1) are pinned by REQ-601, REQ-607, REQ-612 and by
RFC 791's header format; making any of them overridable would let a test
configure a protocol the programme does not have.

| Parameter | Type | Default | Range | Why a test overrides it |
|---|---|---|---|---|
| (none) | — | — | — | — |

## 6. Behaviour

### 6.1 Normal path

**The IPv4 header M14 reads**, with the octet offsets and widths a test writer
needs to hand-assemble stimulus without RFC 791 open. Offsets are from IPv4
octet 0, which is payload octet 0 — the first octet after the ethertype, which is
where M06 puts it (REQ-408) and where M08 leaves it (SPEC-M08 §6.1).

| Field | Octet offset | Width | Record field | Checked against |
|---|---|---|---|---|
| version | 0, bits 7:4 | 4 bits | — (checked, not carried) | **4** exactly (REQ-601) |
| header length (IHL) | 0, bits 3:0 | 4 bits | — (checked, not carried) | **5** exactly — 20 octets, no options (REQ-601) |
| DSCP | 1, bits 7:2 | 6 bits | `ip_hdr_dscp` | any |
| ECN | 1, bits 1:0 | 2 bits | — (not carried; SPEC-M01's `Ip_header` has no field for it) | any |
| total length | 2–3 | 16 bits | `ip_hdr_total_length` | **20 … 1500 inclusive**: above 1500 is REQ-612's discard class, below 20 is REQ-601's (§9, **ADR-0013**). Nothing constrains this field by construction — see the paragraph below |
| identification | 4–5 | 16 bits | — (not carried; nothing receives on it in Phase 1) | any |
| flags | 6, bits 7:5 | 3 bits | — (checked, not carried) | more-fragments (bit 5) **0** (REQ-603); DF (bit 6) and the reserved bit (bit 7) unconstrained |
| fragment offset | 6 bits 4:0, 7 | 13 bits | — (checked, not carried) | **0** exactly (REQ-603) |
| TTL | 8 | 8 bits | `ip_hdr_ttl` | any — Phase 1 does not forward, so a TTL of 0 is delivered like any other |
| protocol | 9 | 8 bits | `ip_hdr_protocol` | **17** exactly (REQ-607) |
| header checksum | 10–11 | 16 bits | — (checked, not carried) | the one's-complement sum below (REQ-602) |
| source address | 12–15 | 32 bits | `ip_hdr_src_ip` | any |
| destination address | 16–19 | 32 bits | `ip_hdr_dst_ip` | REQ-604's four accepted values |

Every multi-octet field is presented as a **numeric value with the first wire
octet most significant** (REQ-012): destination 192.0.2.1 reads 0xC0000201, and
total length 0x00 0x2E reads 46.

**The total-length field is sixteen adversary-controlled bits, and its whole
domain is decided here** (dv_lead, `AP-ip_eth_rx_64.md` row **M14-K7** and §8
question 1; **ADR-0013**). The row above once read "≥ 20 by construction of
REQ-601's IHL check". **That was false.** IHL fixes the *header* length — 5
words, 20 octets — and constrains the total-length field not at all; the two are
independent fields of the same header. A datagram declaring total length
0 … 19 with version 4, IHL 5, a **correct** header checksum, protocol 17, an
accepted destination, more-fragments clear and fragment offset 0 passed all six
of §9's header conditions as they were written, reached §6.2's `Header` row and
matched **neither** of its branches: its declared payload is not empty (which is
total length 20) and it is not non-empty in any sense the emitting arithmetic can
use, because M = ⌈(N′ − 20)/8⌉ is negative for it and this section's own D is
undefined there. The class is **reachable and adversary-controlled** — the
checksum is computed over whatever header the sender chooses, and a 64-octet
Ethernet frame carries such a datagram with padding to spare.

**The decision**: a declared total length below 20 is a malformed header and
joins REQ-601's discard class — one `error_ip_bad_header` pulse, **no**
`ip_hdr_valid`, no payload word, decided on **input word 0** alongside version
and IHL (octets 2–3 lie in that word) and reported on cycle Ci + 3 with the other
header conditions (§9). With it the field's whole domain is partitioned and every
part names a rule:

| Declared total length N′ | Outcome | Owner |
|---|---|---|
| 0 … 19 | discarded; `error_ip_bad_header`; nothing emitted | REQ-601, as extended here (**ADR-0013**) |
| 20 | accepted; `ip_hdr_valid` pulses and **no payload frame follows** | REQ-605, requirements.md §0.7 |
| 21 … 1500 | accepted; a payload frame of N′ − 20 octets | REQ-605, REQ-021 |
| 1501 … 65 535 | discarded; `error_ip_oversize`; nothing emitted | REQ-612 |

Every arithmetic statement later in this section — M, the cycle deficit D, the
separation formula and the under-fill threshold — is stated on the **accepted**
domain, N′ ≥ 20, and is well defined there **because** of that partition. That
dependence was implicit while the false sentence stood; it is stated now so that
a reader who changes one changes the other.

**The header checksum (REQ-602), stated as arithmetic.** Take the twenty header
octets as ten 16-bit halfwords, first wire octet most significant in each; sum
them in one's-complement arithmetic — that is, add as unsigned 16-bit values and
fold every carry out of bit 15 back into bit 0 — **including** the received
checksum halfword at octets 10–11. The header verifies **iff** that sum is
**0xFFFF**. This is the residue form of RFC 791 §3.1 and it needs no separate
"compute with the checksum field zeroed and compare" step, which is the same
arithmetic said twice; SPEC-M15 §6.1 states the transmit side, where the field
must be produced rather than checked, and the two are inverse by construction.

**Where the fields lie in the input words.** Three words carry the header;
everything after them is payload or padding.

| Input word | Octet positions 0 … 7 |
|---|---|
| 0 | version/IHL (0), DSCP/ECN (1), total length (2–3), identification (4–5), flags/fragment offset (6–7) |
| 1 | TTL (8), protocol (9), header checksum (10–11), source address (12–15) |
| 2 | destination address (16–19) at positions 0–3; **payload octets 0–3** at positions 4–7 |
| m ≥ 3 | payload octets 8m − 20 … 8m − 13 |

The header is complete at **input word 2**, and the payload's first octet lies in
the same word: that overlap is the realignment, and it is why the module needs
two words of payload storage and not one.

**Emitting the payload (REQ-021, REQ-605).** Payload octet j is emitted at
`ip_payload_tdata` position j mod 8 of payload word ⌊j / 8⌋, so payload octet 0
is at `ip_payload_tdata`[7:0] of payload word 0 at every datagram length. Payload
word j is assembled from input words j + 2 (positions 4 to 7 give payload octets
8j … 8j+3) and j + 3 (positions 0 to 3 give 8j+4 … 8j+7). The payload stops at
**total length − 20** octets, whatever the frame carries after that:
`ip_payload_tkeep` marks exactly the octets that exist on the last word, and the
Ethernet padding beyond them is consumed and dropped (REQ-605, REQ-408).

**Opening and closing a datagram.** A datagram is **open** from the cycle M14
sees a `hdr_valid` pulse until the earliest of: the payload `tlast` word; the
next `hdr_valid` pulse; or `clear` (REQ-009). This is SPEC-M03 §9's closure-list
device (carry-forward **C-12**'s pattern) as SPEC-M10 §6.1 applies it on the
sibling branch, and it is what makes each report a function of the datagram
rather than of whatever follows it. The "next `hdr_valid`" clause is not a hedge:
an Ethernet frame of exactly 14 octets has no payload frame at all
(requirements.md §0.7) and SPEC-M08 §6.2 ends such a frame the same way.

**On a gapless stimulus**, with Ci the cycle of the input word carrying IPv4
octet 0 — the first cycle after the opening `hdr_valid` pulse with
`payload_tvalid` = 1:

- input word m is presented on cycle **Ci + m**;
- `ip_hdr_valid` pulses on cycle **Ci + 3** for an accepted datagram, and every
  strobe of a datagram rejected on its header pulses on that same cycle (§9);
- payload word j is emitted on cycle **Ci + 4 + j**.

`ip_hdr_valid` therefore falls **exactly one cycle before** that datagram's first
payload word, which satisfies REQ-606's "on or before" with one cycle to spare
and gives M17 a whole cycle to act on the record — the same lead SPEC-M06 §7
gives M08 and SPEC-M08 §7 preserves for this module. **M17 (batch F) is written
against that contract**, so the lead is normative here and not incidental.

**Cycle by cycle, the datagram a minimum-length Ethernet frame produces.** A
64-octet Ethernet frame carrying an IPv4 datagram of **total length 46** —
REQ-708's own stimulus — reaches M14 as a 46-octet payload in 6 words (five with
`tkeep` = 0xFF, one with `tkeep` = 0x3F and `tlast` = 1), with no Ethernet
padding, and delivers 46 − 20 = **26** payload octets in 4 words.

| Cycle | Input | Output |
|---|---|---|
| H | `hdr_valid` = 1 (the datagram opens) | `ip_hdr_valid` = 0, every strobe 0 |
| Ci = H+1 | input word 0: IPv4 octets 0–7 | nothing yet |
| Ci+1 | input word 1: octets 8–15 | nothing yet |
| Ci+2 | input word 2: octets 16–23 (16–19 header, 20–23 payload 0–3) | nothing yet |
| **Ci+3** | input word 3: octets 24–31 (payload 4–11) | **`ip_hdr_valid` = 1**, all six fields |
| Ci+4 | input word 4: octets 32–39 (payload 12–19) | payload word 0: payload octets 0–7, `tkeep` = 0xFF |
| Ci+5 | input word 5: octets 40–45 (payload 20–25), `tkeep` = 0x3F, `tlast` = 1 | payload word 1: payload octets 8–15 |
| Ci+6 | idle | payload word 2: payload octets 16–23 |
| Ci+7 | idle | payload word 3: payload octets 24–25, `tkeep` = 0x03, `tlast` = 1, `tuser`[0] = the input `tlast` word's `tuser`[0] — **this datagram is fully delivered, D = −1, so the copy below applies unconditionally to it** |
| Ci+8 onward | idle | `ip_payload_tvalid` = 0 |

**The last payload word is not emitted early, and that is REQ-005 rather than
pedantry.** Payload octets 24–25 arrive in input word 5 at Ci + 5, and the word
carrying them leaves at Ci + 7 — two cycles later — because payload octet 24's
input octet time is 8·(Ci+5) + 4 = 8Ci + 44 and constant latency fixes its output
octet time at 8Ci + 56, which is position 0 of cycle Ci + 7. An implementation
that emitted it at Ci + 6 because it happened to hold every octet would have
length-dependent latency and would fail REQ-005's per-octet tagger.

**When the abort bit is available, and what M14 emits when it is not (REQ-007,
REQ-013).** Let N be the octets the Ethernet payload delivers — **Ethernet
padding included**, because REQ-408 leaves the padding in place at M06 and §2
says M14 removes it only by delivering total length − 20 octets and stopping —
and N′ the datagram's own IPv4 total length, with N′ ≤ N (an N′ above N is
REQ-605's truncation and never reaches this question). The input has K = ⌈N/8⌉
words and the payload frame has M = ⌈(N′ − 20)/8⌉ words. The input `tlast` is
presented on cycle **Ci + K − 1** and the payload `tlast` word — index M − 1 —
leaves on **Ci + M + 3**, so the two events are separated by

> (Ci + M + 3) − (Ci + K − 1) = ⌈(N′ − 20)/8⌉ − ⌈N/8⌉ + 4 cycles,

and a **registered** output (§7) can carry the bit only where that number is
**positive**. Writing **D = ⌈N/8⌉ − ⌈(N′ − 20)/8⌉ − 3 = K − M − 3**, M14's
**cycle deficit**, the separation is exactly **1 − D** and three regimes exhaust
the datagrams that produce a payload frame at all (N′ ≥ 21):

| Regime | Payload `tlast` vs input `tlast` | The abort bit |
|---|---|---|
| **D ≤ 0** — D never falls below −1 — which includes every fully delivered datagram (N′ = N, where D is 0 or −1 by N's residue modulo 8) | 1 − D cycles **after** | available; **copied** from the input `tlast` word. At D = 0 the margin is exactly zero |
| **D = 1** | the **same** cycle | not available to a registered output |
| **D ≥ 2** | D − 1 cycles **before** — up to **183** at N = 1500, N′ = 21, which is 184 cycles before the bit is readable by a registered output | not available to any implementation |

**What the paragraph this replaces got wrong, named as the error it was** (ledger
**C-37**, dv_lead; **ADR-0012**). It argued "Since N′ ≤ N,
M + 3 ≥ ⌈(N − 20)/8⌉ + 3 ≥ K". The second inequality holds; **the first runs
backwards** — N′ ≤ N gives M ≤ ⌈(N − 20)/8⌉, *not* ≥ — and it is the same error
SPEC-M17 §6.1 made and repaired at the next stripping stage of this chain
(dv_lead, WO-0020 Return log **F-1**). Its worked example reproduced because that example carries **no padding
at all**: the 64-octet frame of the cycle table above declares total length 46
and fills its 46-octet Ethernet payload exactly (§8 says so in terms), so it is
the N′ = N case, D = −1, and the separation of two cycles it reports is right.
The sentence that followed it — "where padding is stripped the inequality is
slack" — inverted the dependence. **Padding is what closes the window**: every
padding octet raises K and none of them raises M.

**How much under-fill the bit survives, in one number.** The bit is available iff
**N′ ≥ 8⌈N/8⌉ − 11**, so M14 carries it across an under-fill of at most
**11 − (8⌈N/8⌉ − N)** octets — between 4 and 11 octets, by N's residue. Ordinary
Ethernet padding exceeds that at once: REQ-408's own worked example is a 64-octet
frame carrying a 20-octet datagram, which is 26 octets of padding. For the
46-octet Ethernet payload of a minimum-length frame the threshold is N′ ≥ 37, so
**every IPv4 total length from 21 to 36 inside a 64-octet frame is in the
unavailable class** — including the smallest UDP datagram the programme admits
(UDP length 9, total length 29, D = 1, separation exactly 0) and §8's own
directed total lengths 21 … 28.

**D is M14's *cycle* deficit and is not SPEC-M17 §6.1's D.** M17's D is a
**word-count** deficit, ⌈N/8⌉ − ⌈N′/8⌉, and the two definitions agree there only
because M17 strips **eight** octets — a whole datapath word — so that
M = ⌈N′/8⌉ − 1 identically. M14 strips **twenty**, which is not a multiple of 8,
and no such identity exists: writing r = N′ mod 8,

> D = (⌈N/8⌉ − ⌈N′/8⌉) **− 1** for r ∈ {0, 5, 6, 7}, and
> D = ⌈N/8⌉ − ⌈N′/8⌉ for r ∈ {1, 2, 3, 4}.

A bench that computes M14's D from M17's formula is wrong by one at **four
residues in eight**, always in the direction that predicts a derived 0 where a
conformant design must copy. §8 drives the adjacent pair that catches it.

**The rule itself is the same at both modules — copy iff D ≤ 0** — and at M17 it
collapses to D = 0 because M17's D cannot be negative. At M14 it can be −1, which
is why the ordinary fully delivered datagram sits one cycle clear of the boundary
here and exactly on it there. §11.5 and SPEC-M17 §11.4 carry the single
instrument that now covers both modules.

**Outcome for the unavailable class (D ≥ 1): `tuser`[0] = 0 on the payload
`tlast` word.** It is not a copy and it is not a guess. 0 is the value the bit
*has* at the instant that word is emitted — "no abort has been observed for this
datagram so far" — and it is the only value M14 can derive from what it has seen;
marking 1 instead would abort every conformant padded datagram, which is the
commonest small frame on Ethernet. §6.2's `Payload` row states it, §10's hook
asserts it on a directed pair, §11.5 records what it costs REQ-007's universal,
and **ADR-0012** records the decision, the residual and the alternatives it
rejects.

**A truncated frame (N′ > N) never reaches this question.** It is REQ-605's
error: the payload frame is closed on the word carrying the last octet that
arrived and is marked `tuser`[0] = 1 by §9's own rule rather than by inheritance,
and §9's extensional branch fixes which word that is. M14's *own* abort is always
available to it, because M14 detects the condition at the input `tlast` itself.

**Gapped stimulus.** A cycle carrying no payload word holds every state and every
register: it is not a condition, it advances no word index, and it delays every
later octet by exactly 8 octet times per cycle (REQ-016). The cycle formulas
above hold on a gapless stimulus; the **per-octet constant L = 12** of §7 holds
on every stimulus, and that is what a bench asserts — the same distinction
carry-forward C-14.4 fixed in SPEC-M03 §6.1. **§7's *parse-latency* figure of 3
cycles is not in that class**: its two events are an input word and an output
pulse rather than one octet at two ports, so an idle cycle injected inside the
header moves the pulse and not the word and the figure grows by exactly the
injected count (§7, carry-forward **C-27**).

**When `hdr_valid` opens a datagram with no payload frame.** M06 emits a header
record with no payload frame for a 14-octet Ethernet frame (requirements.md
§0.7) and M08 routes it on its ethertype (SPEC-M08 §6.1). Such a frame carries
**zero** IPv4 octets: no header can be decoded, no `ip_hdr_valid` pulses, no
payload word is emitted, and the datagram is closed by the next `hdr_valid`
pulse and reported one cycle after it with a single `error_ip_truncated` pulse
(§9) — the strobe REQ-605 names for a frame that ends before its total length is
satisfied, which a frame of zero IPv4 octets certainly does.

### 6.2 State machine

Reset state and `clear` state are both `Idle`. **The state machine advances on
the input side**; the output is the fixed-delay pipeline of §7 running behind it.

| State | Entered when | Does | Leaves to |
|---|---|---|---|
| `Idle` | reset; `clear`; the input `tlast` of the previous datagram; a `hdr_valid` pulse that ends a payload-less frame | ignores the payload stream; `ip_hdr_valid` = 0, `ip_payload_tvalid` = 0, every strobe 0 | `Header` on a `hdr_valid` pulse (the datagram opens) |
| `Header` | a `hdr_valid` pulse | captures IPv4 octets 0–19 into the field registers as they arrive across input words 0, 1 and 2; accumulates the one's-complement sum; evaluates REQ-601, REQ-603 and REQ-612 on word 0, REQ-607 on word 1, and REQ-602 and REQ-604 on word 2 — **REQ-601's evaluation includes the total-length lower bound and REQ-612 the upper, both from octets 2–3 of word 0, so the whole domain of that field is decided in one word (§6.1, ADR-0013)**; makes the one report of §6.1 on cycle Ci + 3 | `Payload` on the report cycle if the datagram was accepted, its declared payload is non-empty (**N′ ≥ 21; N′ ≤ 19 never reaches this branch — it is rejected on word 0**) and at least one payload octet was delivered; `Idle` on the report cycle if it was rejected, if its **declared** payload is empty (total length 20, requirements.md §0.7 — `ip_hdr_valid` pulses and no payload frame follows), if the frame closed before the header completed, or **if the frame closed before any payload octet was delivered** while the declared payload is non-empty. The last two both give one `error_ip_truncated` and **no** `ip_hdr_valid`, so a header record never promises a payload frame that cannot follow (§9, carry-forward **C-26**) |
| `Payload` | the header was accepted, its declared payload is non-empty **and at least one payload octet was delivered** | forwards payload octets at the fixed delay of §7, realigned, counting them against total length − 20; marks `ip_payload_tlast` on the word carrying the last of them, with `tkeep` marking exactly the octets that exist and `tuser`[0] **copied from the input `tlast` word where that word has already been presented — §6.1's D ≤ 0 class, which includes every fully delivered datagram — and driven to 0 where the payload `tlast` word leaves on or before that cycle (D ≥ 1; §6.1, §11.5). The copy is conditional; the condition is D, and it is neither "the frame carries padding" nor the word deficit `Tail` keys on** — or, where the frame closed early, on the word carrying the last octet that arrived, with `tuser`[0] = 1 (§9, REQ-605); consumes and drops every input octet beyond the count | `Idle` on the input `tlast` — the state leaves immediately and the pipeline drains behind it; `Tail` if the payload count completes while the frame still runs |
| `Tail` | the declared payload has been delivered and the frame has not ended | consumes the Ethernet padding: ignores every remaining input octet, emits nothing, pulses nothing. **`Tail` is entered on the *word* deficit and §6.1's D ≥ 1 class is a proper subset of it, which is where M14 differs from M17 and the difference is deliberate.** Input word ⌈N′/8⌉ − 1 carries the declared count's last octet, so `Tail` is entered exactly when that word precedes the input `tlast` word — ⌈N/8⌉ − ⌈N′/8⌉ ≥ 1 — while the copy is lost only where §6.1's cycle deficit D ≥ 1, and D is the word deficit less one at N′ mod 8 ∈ {0, 5, 6, 7}. So **D ≥ 1 implies `Tail`, and `Tail` does not imply D ≥ 1**: a padded datagram can enter this state and still carry the bit, IPv4 total length **37** in a 64-octet frame being the case §8 drives. SPEC-M17 §6.2 pins its own two names equal; this specification pins them **unequal**, for the reason §6.1 gives — twenty octets is not a whole datapath word and eight is | `Idle` on the input `tlast`; `Header` on a `hdr_valid` pulse |

An input cycle carrying no payload word holds every state and every register: it
is not a condition and it advances nothing (§6.1).

`clear` asserted in any state abandons the datagram: no record, no payload
`tlast`, no strobe, straight to `Idle` (REQ-009, §7).

### 6.3 Deliberately unconstrained

Anything not listed here is constrained by this specification, and a test may
rely on it.

1. **The placement of the register levels** inside the four-cycle pipeline and
   every internal encoding: the FSM state encoding, how the 20-octet realignment
   shift is built, whether the header is captured into one register or seven,
   whether the checksum accumulator is a two-halfword-per-cycle adder tree or a
   wider one. §7's constants are what is fixed.
2. **The value of the six `ip_hdr` fields on cycles where `ip_hdr_valid` = 0**,
   the value of `ip_payload_tdata` at positions where `ip_payload_tkeep` is 0,
   and every output field on a cycle with `ip_payload_tvalid` = 0 (SPEC-M01 §6.3
   item 5). No monitor may read them.
3. **Whether the delivered-octet count is derived from a running counter or from
   the word index together with `tkeep`.** Both compute the same predicate and
   neither is observable; §6.1 pins the payload extent and §9 pins the strobe
   cycles, which is what a bench needs.
4. **The DF flag (octet 6 bit 6) and the reserved flag (bit 7) — their
   *representation*, and nothing else.** REQ-603 constrains more-fragments
   (bit 5) and the fragment offset and deliberately says nothing about these
   two: M14 neither checks them nor carries them, and no port and no
   `Ip_header` field exists for either, so **no monitor may read them out of
   M14** — that is the whole of what is unconstrained here.

   **What is *not* unconstrained is the datagram's outcome, and stating it is
   what makes a flag-bit-position defect killable** (dv_lead,
   `AP-ip_eth_rx_64.md` row **M14-B5** and §8 question 2). Acceptance is a
   function of the conditions §9 lists and of nothing else, so a datagram
   meeting none of them is accepted whatever DF and the reserved bit carry: a
   datagram with **DF set (or the reserved bit set), more-fragments clear and
   fragment offset 0 meets no discard condition and is accepted** — the same
   `ip_hdr_valid` cycle, the same six field values, the same payload frame and
   the same strobes (none) as the otherwise identical datagram with both bits
   clear, and in particular **no `error_ip_fragment`**. DV SHALL assert that.
   The previous wording — "DV SHALL assert nothing about a datagram that sets
   either" — forbade it, and the cost was precise: the only stimulus that
   distinguishes a design reading octet 6 **bit 6** for more-fragments from one
   reading bit 5 is a DF-set datagram, so that defect was **unkillable at M14**.
   §8 drives the pair and §10's REQ-603 hook names it. *Note for the bench
   writer*: setting either bit changes the header checksum, so the stimulus
   recomputes it — otherwise the datagram is rejected by REQ-602 and the
   comparison is vacuous.
5. **M14's response to a payload stream that violates REQ-011 or REQ-015** — a
   word with `tvalid` = 1 and `tkeep` = 0, a `tlast` with no preceding
   `hdr_valid`, a non-contiguous `tkeep`. Its producer is M08, relaying M06,
   neither of which can emit any of them (SPEC-M06 §7, SPEC-M08 §7), so no
   requirement names the case and DV SHALL assert nothing about it.
6. **The outcome of changing any of the four configuration inputs on the exact
   cycle of the input word that samples them** (§4.3, input word 2). §4.3 governs
   a change landing at least one cycle earlier; the same-cycle case is left open
   there and is left open deliberately here. A bench that changes a configuration
   input on the sampling word's own cycle and asserts either outcome is flaky by
   construction and SHALL NOT be written. This is carry-forward **C-14.5**'s rule
   applied to this module.
7. **M14's response to a `hdr_valid` pulse whose `hdr_ethertype` is not 0x0800.**
   M08 routes on the ethertype and this port receives only 0x0800 frames
   (SPEC-M08 §6.1); M14 does not re-check it (§4.2) and DV SHALL assert nothing
   about a frame delivered here with any other value.

## 7. Timing contract

- **Latency.** Front offset **h = 20** octet times: M14 removes twenty octets
  from the front of the frame and its input is word-aligned (REQ-021), so §0.5's
  second term is 0 and h is exactly the header length. The pinned per-octet
  constant is

  | Quantity | Value |
  |---|---|
  | L (octet times) | **12** |
  | h (octet times) | **20** |
  | Word delay ΔC = (L + h)/8 | **4** cycles |
  | §1.1 ceiling | **5** cycles |

  (L + h) = 32, a multiple of 8 as requirements.md §0.5 requires. There is one
  constant and not two: M14 sees no XGMII, so §0.5's start-lane pair has no
  instance here and L is a single value.

  **The two measurement events**, named explicitly: the input event is the octet
  time, on the `payload` stream, of the octet being measured; the output event is
  the octet time of that same octet on the `ip_payload` stream. For the word
  delay the two events are the cycle of the input word carrying IPv4 octet 0 and
  the cycle of the datagram's first payload word — the previous stage's output
  word and this stage's, which is what makes ΔC additive along the chain (§0.5).
  Checked both ways, as §0.5 exists to allow: payload octet j enters at octet
  time 8Ci + 20 + j and leaves at 8Ci + 32 + j, so L = 12 for every octet; and
  ΔC = (Ci + 4) − Ci = 4, which equals (12 + 20)/8. The two routes agree.

  **Four cycles is what the octet mapping produces, and the fifth is reserve.**
  Payload octets 0–7 span input words 2 and 3, input word 3 arrives at Ci + 3,
  and a registered output emits at Ci + 4; nothing cheaper exists without making
  `ip_payload_tdata` a combinational function of `payload_tdata`. requirements.md
  §1.1 allocates M14 a ceiling of **5**, so this specification pins one cycle
  **inside** its own allocation. That cycle is not the architect's slack and
  spending it later would not be a slack release: it is M14's own allocation and
  a revision to ΔC = 5 would be an ordinary spec diff to this bullet, with
  §1.1's table and the seven cycles of programme slack untouched. §11.2 records
  it, in the shape SPEC-M06 §11.2 records the opposite position (pinned exactly
  at its ceiling with no reserve).

- **Parse latency (REQ-611)**, which is a different measurement on the same
  pipeline and is stated separately because REQ-611 asks for it: **3 cycles**
  from the input word carrying the first octet of the IPv4 header to the cycle
  on which `ip_hdr_valid` asserts. The two measurement events are the cycle of
  input word 0 (Ci) and the cycle of the `ip_hdr_valid` pulse (Ci + 3). Both sit
  at octet position 0 of their words, so in requirements.md §0.5's octet times
  the figure is exactly 24 and not a rounding. It is one constant for every
  datagram length and every field content M14 accepts, and it is one cycle less
  than the payload's word delay — which is what puts `ip_hdr_valid` one cycle
  before payload word 0 (§6.1).

  **The parse-latency constant is scoped to a header delivered without internal
  idle cycles, and REQ-611's gap clause is satisfied by L and not by this figure**
  (carry-forward **C-27**, dv_lead). REQ-611 asks for the constant "counted per
  §0.5 so that REQ-016's permitted idle gaps do not break the constant". §0.5's
  device does that for a **per-octet** latency, where an injected idle cycle moves
  the input event and the output event together: that is **L = 12**, and it is
  gap-invariant. This figure's two events are the *input word* carrying IPv4
  octet 0 and the `ip_hdr_valid` *pulse*, and an idle cycle **inside the header** —
  between input words 0 and 2 — moves only the second: one such cycle puts input
  word 2 at Ci + 3 and the pulse at Ci + 4, a parse latency of 4. So:

  > **3 cycles, on a header whose three input words are delivered on consecutive
  > cycles.** Under REQ-016's permitted idle injection inside the header the
  > figure grows by exactly the number of injected cycles, and **L = 12 is the
  > constant that does not move**.

  There are therefore two constants in this section and only one of them is
  gap-invariant; §10's REQ-016 hook names **L** explicitly for that reason, and a
  bench that injects idle inside the header and asserts 3 fails a conformant M14.
  §6.1 states the same scoping from the other side.

- **Throughput.** One input word accepted every cycle, unconditionally and with
  no handshake (REQ-003). At most one payload word emitted per cycle, and never
  more than one per input word: M14 removes twenty octets and therefore emits two
  or three **fewer** words than it consumes for every datagram, which is why no
  backpressure is needed anywhere and why a datagram whose first word arrives on
  the cycle after the previous frame's `tlast` cannot collide at the output.

- **Handshake rules.** `ip_payload_tvalid` = 1 exactly on cycles carrying payload
  octets. `ip_payload_tkeep` is `0xFF` except on the `tlast` word, where it is 1
  to 8 contiguous ones. `ip_payload_tlast` = 1 on the word carrying the payload's
  last octet, that word included in the frame's word count (REQ-015); a one-word
  payload frame is legal and is the mandatory encoding of a payload of 1 to 8
  octets. At most 185 words between successive `ip_payload_tlast` words.
  `ip_payload_tuser`[0] is meaningful only on the `tlast` word.

  `ip_hdr_valid` is high for **exactly one cycle per accepted datagram**, on the
  cycle before that datagram's first payload word, and the six field values are
  valid only on that cycle (§6.3 item 2). For a datagram of total length 20 it
  pulses on the same cycle it would have anyway and **no payload frame follows**:
  every consumer of this record SHALL tolerate a header with no payload frame
  (requirements.md §0.7).

  **The record's `valid` is a one-cycle pulse here, not a level.** This is
  REQ-606's receive-side discipline; on the transmit path the same `Ip_header`
  record's `valid` is a level held until the first payload word is accepted
  (SPEC-M15 §7, ADR-0008). The direction of a port decides which, and every port
  declares its direction. A monitor written for one and attached to the other
  reports a defect that is not there — the third record to which that sentence
  applies, after `Eth_header` (SPEC-M06 §11.3) and `Arp_packet` (SPEC-M10 §7).

  Idle gaps on the input (REQ-016) delay everything by exactly 8 octet times per
  cycle and change nothing else.

- **Reset.** While `clear` = 1 and on the first cycle after it returns to 0:
  `ip_payload_tvalid` = 0, `ip_hdr_valid` = 0, all seven strobes 0, state `Idle`,
  the captured header fields irrelevant because the next datagram overwrites
  them. `clear` asserted inside an open datagram abandons it with **no `tlast`
  and no strobe** — the one place in this specification where a datagram vanishes
  without a report, permitted by REQ-009 and not by REQ-008. A datagram whose
  `hdr_valid` pulse arrives on the first cycle after `clear` returns to 0 is
  parsed correctly.

- **Configuration sampling.** §4.3's table: all four inputs on the input word
  carrying IPv4 octets 16–19, which is input word 2. A change landing on that
  word's own cycle is unconstrained (§6.3 item 6).

## 8. Line-rate stress obligation

**Mandatory: M14 is in requirements.md §0.4's stress-bench list** (M03, M06,
M08, M10, M14, M17, M20).

**Stimulus, derived by construction from the XGMII case and not re-invented**
(REQ-004's own rule for a module that does not see XGMII). Drive M14's `hdr` and
`payload` ports with exactly what M08 emits on its `ip_*` ports when M03 is
driven by SPEC-M03 §8's stress run with the ethertype set to 0x0800:

- 10 000 consecutive frames, each a **64-octet** Ethernet frame, which M06
  delivers as a **46-octet payload in 6 words** (five with `tkeep` = 0xFF, one
  with `tkeep` = 0x3F and `tlast` = 1) and M08 relays unchanged one cycle later;
- one `hdr_valid` pulse per frame, exactly one cycle before that frame's first
  payload word (SPEC-M06 §7, preserved by SPEC-M08 §6.1);
- the six words of a frame occupy **consecutive cycles**, and **between frames 4
  and 5 idle cycles alternately**: M03's start characters alternate lane 0 and
  lane 4 at 10 and 11 cycles apart (REQ-004, requirements.md §0.3) and six of
  those cycles carry payload words, leaving 4 and 5. The figure is counted on the
  payload stream and the header pulse falls inside the idle run, one cycle before
  payload word 0. Idle gaps are preserved rather than closed up — that
  alternation is the stimulus, and a bench that packs the words back to back is
  testing a rate the receive path never sees;
- **datagram contents**, chosen so that a stuck field register cannot pass:
  version 4, IHL 5, DSCP 0, ECN 0, **total length 46** — REQ-708's own figure,
  which fills the 46-octet Ethernet payload exactly and therefore carries **no**
  Ethernet padding — identification n modulo 65 536, flags 0, fragment offset 0,
  TTL 64, **protocol 17**, a correct header checksum recomputed per datagram
  (the identification changes, so a fixed checksum would fail every frame),
  source address `10.0.0.0 + n` as a 32-bit value, destination address the
  configured local IP, then 8 octets of UDP header and 18 octets of UDP payload
  whose **first four octets carry a 32-bit sequence number** (REQ-020,
  REQ-708) — that is, M14 payload octets 8–11;
- `payload_tuser`[0] = 0 on every `tlast` word. **Error injection rate: zero in
  this run** — every rejection class is a directed test below, because REQ-004's
  conservation criterion is stated over the datagrams the module accepts.

Note for the bench writer: the sequence number at M14 payload octets 8–11 lands
in `ip_payload_tdata`[31:0] of **payload word 1**, and the source address at
IPv4 octets 12–15 lands in input word 1 positions 4–7 — a field entirely inside
one word, unlike the destination at 16–19, which is the field whose decode sits
at the head of the word the realignment splits. Both are worth asserting for
that reason.

**Checks.**

1. 10 000 payload frames out for 10 000 frames in, 10 000 `ip_hdr_valid` pulses,
   each exactly one cycle; no word dropped; frame conservation holds
   (requirements.md §0.6), with no strobe pulsing anywhere in the run.

   **The one exemption that monitor needs, and where it bites** (carry-forward
   **C-30**, dv_lead; the wording model is SPEC-M10 §8 criterion 1, which
   carries the same exemption one branch over, and SPEC-M12 §7 before it).
   requirements.md §0.6 says the conservation monitor is active in **every**
   bench, and §10 commissions a mid-datagram `clear` test at this module — in
   which a datagram is opened and, correctly, never reported: §7 states that
   `clear` inside an open datagram abandons it with **no `tlast` and no
   strobe**, the one place in this specification where a datagram vanishes
   without a report, permitted by REQ-009 and not by REQ-008. A monitor
   asserting conservation without a `clear` exemption counts that datagram as a
   silent discard and fails a conformant M14. This is ledger **C-2**'s exemption
   becoming load-bearing at its **second** module. In the stress run itself the
   exemption never fires — `clear` is not asserted — so criterion 1 stands
   exactly as written for all 10 000 datagrams.
2. The 26 delivered payload octets of every datagram compare equal to input
   octets 20–45, and the sequence numbers arrive as 0, 1, 2, … with no gap and
   no repeat (REQ-020).
3. Per-octet latency is constant and equals **12** octet times for every octet of
   all 10 000 datagrams (REQ-005, REQ-019) — one value, not a mean, and converted
   to ΔC = (12 + 20)/8 = 4 against the §1.1 ceiling of 5 in the sign-off packet,
   with the one cycle of reserve reported as reserve rather than as slack (§7).
4. Every `ip_hdr_valid` pulse carries the six fields of the datagram whose first
   payload word follows on the next cycle, and the parse latency from input word
   0 to that pulse equals **3** cycles for all 10 000 (REQ-611).
5. The module exposes no `tready` on either stream under test. This is structural
   (REQ-003, §4.1) — a statement about the type, not an assertion that could
   fail.

**Directed datagrams alongside the stress run**, each inside a 64-octet Ethernet
frame unless its own length forbids it:

- **one per rejection class** (§9): version 6; IHL 6 and IHL 4; **declared total
  lengths 0, 5 and 19** — each otherwise fully acceptable (version 4, IHL 5, a
  correct checksum, protocol 17, the configured local IP, more-fragments clear,
  offset 0) inside a 64-octet frame, asserting exactly one
  `error_ip_bad_header` at Ci + 3, **no** `ip_hdr_valid` and no payload word
  (§6.1, **ADR-0013**); a datagram with
  one header bit flipped so the checksum fails; more-fragments set; a non-zero
  fragment offset; three rejected destinations — a foreign unicast address, the
  configured multicast group **with multicast disabled**, and an address on the
  local subnet that is neither the local IP nor the subnet broadcast; protocol 1
  and protocol 6; total length 1501; and a frame that ends ten octets before its
  declared total length;
- **one per accepted destination** (REQ-604): the configured local IP, the
  subnet-broadcast address `cfg_local_ip | ~cfg_subnet_mask`, 255.255.255.255,
  and the configured multicast group with multicast **enabled**;
- **total lengths 20 through 28 inclusive, plus 1500** (REQ-021, REQ-605,
  REQ-011). Total lengths 20 … 27 give payloads of 0 … 7 octets and cover every
  residue modulo 8; total length **28** is what covers the `0xFF` `tkeep`
  pattern, because a payload of 0 emits no payload word at all (requirements.md
  §0.7) and the full-word pattern needs a payload length that is a positive
  multiple of 8. *This is carry-forward C-17(e)'s lesson applied before the fact
  rather than after it*: at M06 the directed set had to be extended from 14–21 to
  14–22 because the residue claim and the `tkeep`-pattern claim are different
  claims, and the same arithmetic applies here one header down. Total length 1500
  is the maximum REQ-612 admits and gives a 1480-octet payload in 185 words.
  **Note for the bench writer** (ledger **C-37**): inside a 64-octet frame every
  one of total lengths 21 … 28 is in §6.1's **D ≥ 1** class, so this set asserts
  nothing whatever about `ip_payload_tuser`[0] — the two datagrams below are what
  assert it. Total length **1500**, by contrast, is the fully delivered maximum
  and sits at **D = 0**, the tightest point of the copy class, so it exercises the
  copy at zero margin;
- **the abort-bit pair, adjacent by one declared octet and both padded**
  (REQ-007, REQ-013; ledger **C-37**, ADR-0012). Both inside a **64-octet**
  Ethernet frame, so N = 46, K = 6 and the input `tlast` is presented at Ci + 5,
  and both enter §6.2's `Tail` state with a word deficit of exactly 1
  (⌈46/8⌉ = 6 against ⌈36/8⌉ = ⌈37/8⌉ = 5):
  - **IPv4 total length 36 — §6.1's D = 1.** M = ⌈16/8⌉ = 2, so the payload
    `tlast` word leaves at Ci + 5, the **same cycle** the input `tlast` is
    presented. Assert 16 payload octets in two words, `tlast` on word 1 with
    `tkeep` = 0xFF, 10 octets of padding dropped and **no strobe**. **Drive it
    twice, once with `payload_tuser`[0] = 0 on the input `tlast` word and once
    with 1, and assert `ip_payload_tuser`[0] = 0 on the payload `tlast` word both
    times.** The bit is derived, not copied, and this is the assertion that fixes
    it in a test rather than in prose (§6.1, §6.2, §11.5).
  - **IPv4 total length 37 — §6.1's D = 0, and it is the threshold itself.**
    M = ⌈17/8⌉ = 3, so the payload `tlast` word leaves at Ci + 6, **one cycle
    after**. Assert 17 payload octets in three words, `tlast` on word 2 with
    `tkeep` = 0x01, 9 octets of padding dropped, **no strobe**, and
    `ip_payload_tuser`[0] **equal to the input `tlast` word's** — driven 1 on one
    run and 0 on another.

  The pair is what makes the class testable rather than merely named, because the
  two datagrams agree on everything a wrong design is likely to key on. A design
  that copies unconditionally fails 36. A design keyed on "the datagram carries
  padding", or on being in `Tail`, or on SPEC-M17's **word** deficit
  ⌈N/8⌉ − ⌈N′/8⌉ — all three of which hold identically for both — drives 0 on
  both and fails 37. Only a design keyed on §6.1's cycle deficit passes both;
- **the flag-bit pair (REQ-603, §6.3 item 4)**: two datagrams identical to the
  stress run's accepted datagram except that one sets **DF** (octet 6 bit 6) and
  the other sets the **reserved** bit (bit 7), each with the header checksum
  recomputed, more-fragments clear and fragment offset 0. Assert each is
  accepted exactly as the unmodified datagram is — same `ip_hdr_valid` cycle,
  same six field values, the same 26 payload octets in the same words, **no
  strobe of any kind** and in particular no `error_ip_fragment`. This is the
  pair that kills a design reading the wrong bit of octet 6 for more-fragments;
  no other stimulus distinguishes it, which is why §6.3 item 4 now permits the
  assertion (dv_lead, **M14-B5**);
- **a 14-octet Ethernet frame routed here** (requirements.md §0.7): no
  `ip_hdr_valid`, no payload word, exactly one `error_ip_truncated` pulse, and
  the next datagram parsed intact;
- **the truncation band, 21 to 27 delivered IPv4 octets** against a declared
  total length of 46, one frame per delivered count — seven frames covering every
  residue in the band (carry-forward **C-26**). Each emits **one** payload word
  at Ci + 4 carrying the 1 to 7 octets that arrived, with `tkeep` marking exactly
  them, `tlast` = 1, `tuser`[0] = 1, and exactly one `error_ip_truncated` pulse
  at Ci + 3. This is the band the previous branch condition and case list
  disagreed over, and it is where a bench distinguishes the two readings;
- **exactly 20 delivered IPv4 octets with a declared total length of 46**: the
  header is complete and no payload octet exists, so **no** `ip_hdr_valid`, no
  payload word and exactly one `error_ip_truncated` pulse — the boundary case
  §9 decides, and the one a bench most easily confuses with the accepted
  total-length-20 datagram above it, which pulses the record and no strobe;
- **one datagram failing two conditions at once** — protocol 1 *and* a foreign
  destination — asserting that **both** strobes pulse on cycle Ci + 3, which is
  the multiplicity rule §9 states and the one place M14 differs sharply from M10.

## 9. Errors and discards

Strobe names are normative (requirements.md §12). M14 owns seven of the
twenty-one.

| Condition | Strobe (one cycle) | Stream effect | REQ |
|---|---|---|---|
| Version is not 4, header length is not 5, **or the declared total length is below 20** — the third condition is REQ-601's class as this specification extends it (§6.1, **ADR-0013**): the datagram declares a length shorter than the header it declares, so no payload count exists and none of the delivery rules below can be applied to it | `error_ip_bad_header` | **no `ip_hdr_valid` and no payload word**; nothing is emitted for this datagram | REQ-601 |
| The one's-complement sum of the ten header halfwords is not 0xFFFF | `error_ip_bad_checksum` | the same | REQ-602 |
| More-fragments is set, or the fragment offset is non-zero | `error_ip_fragment` | the same | REQ-603 |
| The destination is none of: `cfg_local_ip`, `cfg_local_ip \| ~cfg_subnet_mask`, 255.255.255.255, or `cfg_multicast_group` with `cfg_multicast_enable` = 1 | `error_ip_not_for_us` | the same | REQ-604 |
| The protocol is not 17 | `error_ip_bad_protocol` | the same | REQ-607 |
| Total length is above 1500 | `error_ip_oversize` | the same | REQ-612 |
| The frame ends before total length is satisfied | `error_ip_truncated` | **if the datagram declared payload octets and at least one of them was delivered**, a payload frame is emitted and **aborted**: its last word carries `tuser`[0] = 1 and the `tkeep` the delivered octets imply, and it leaves at its ordinary cycle whether or not it had already left when the frame closed. **If the frame closed before any payload octet was delivered** — a frame ending inside the 20-octet header, a frame ending exactly at its end while the declared payload is non-empty, and a frame with no payload frame at all — **no payload frame is emitted**, `ip_hdr_valid` does not pulse, and the strobe is the only report (requirements.md §0.6, §0.7) | REQ-605 |

Silent discard is prohibited (REQ-008): every row has a strobe. The `clear`
mid-datagram case of §7 is REQ-009's, not REQ-008's.

**Strobe cycles, pinned.** The first six conditions are all decidable from the
header alone, and the header is complete at input word 2, so each pulses for
exactly one cycle on cycle **Ci + 3** — including both bounds on the total-length
field, whose octets 2–3 arrive in input word **0**, so the whole of that field's
domain is decided two words before the report cycle (§6.1, ADR-0013) — the cycle `ip_hdr_valid` would have
occupied, and one cycle before the first payload word would have left. **Every
rejection at M14 is therefore a discard-before-emission**, cleanly, with no
abort interaction: the datagram never reaches the output. `error_ip_truncated`
pulses one cycle after the input word carrying the frame's `tlast`, except for a
frame with no payload frame at all, where the closing event is the next
`hdr_valid` pulse and the strobe pulses one cycle after it (§6.1, the device
SPEC-M10 §9 uses on the sibling branch). All are computable from the input trace
alone and all lie inside requirements.md §0.6's window.

**Which conditions can co-occur on one datagram, and what then pulses — and this
is where M14 differs from M10.** REQ-501 gave all of M10's conditions **one**
strobe name, so a packet failing two criteria pulsed once. Here the seven
conditions have seven names, and requirements.md §0.6's rule applies with its
plain force: *"If two or more locally detected conditions apply to one frame,
each applicable condition's strobe pulses once for that frame."* So:

- **Each of the first six conditions is evaluated independently on the received
  header bits, and every one that holds pulses**, all on cycle Ci + 3. A
  datagram with protocol 1 sent to a foreign address pulses
  `error_ip_bad_protocol` **and** `error_ip_not_for_us`; a datagram with a bad
  checksum and a foreign destination pulses both of those. There is no
  precedence order and no first-match rule, and that is deliberate: a precedence
  order would be unobservable at the port — one strobe looks the same whichever
  rule suppressed the others — so a bench could not tell a conformant design from
  a broken one, and every implementer would have to guess the order. Independent
  evaluation makes the pulse set a **function of the injected bits**, which a
  bench computes.
- **A bad checksum does not suppress the other checks**, which is the corollary
  a reader most often doubts. The other five conditions are evaluated on the
  received bits whether or not the checksum verifies; §8's directed set includes
  the pairing so the reading is fixed in a test.
- **One exception, and it is the only precedence rule in this section**: a frame
  that does not deliver a complete 20-octet IPv4 header pulses
  `error_ip_truncated` **alone**, and none of the other six is evaluated. The
  reason is that evaluating them on a partial header would make the pulse set a
  function of *where the frame ended* rather than of the datagram, and a
  condition that cannot be decided is not "applicable" within §0.6's sentence.
- **`error_ip_truncated` with one of the first six**: cannot occur, by the rule
  above for a short frame, and for a frame that carries a complete header the
  first six are decided at Ci + 3 and reject the datagram there, so nothing is
  emitted and there is no delivery to fall short of. A rejected datagram's
  remaining octets are consumed and dropped and pulse nothing.
- **A rejection with an inherited `payload_tuser`[0] = 1**: the local discard
  wins (requirements.md §0.6), no payload frame is emitted, the local strobes
  pulse, and M14 pulses **nothing** extra for the inherited abort — it did not
  detect it, and re-reporting an inherited abort is forbidden.

**The truncation row's branch condition is extensional, not temporal, and the
reason is REQ-605** (carry-forward **C-26**, dv_lead). The text this replaced
selected the branch on whether "payload words have already been emitted" — a
statement about the *detection cycle* — while enumerating the negative branch by
*cases*, and the two disagree over a band that is reachable and eight octets
wide. A frame delivering **21 to 27** IPv4 octets against a larger declared total
length has 1 to 7 payload octets in hand, but no payload word has **left** at the
detection cycle: the input `tlast` is at Ci + 2, the strobe at Ci + 3, and payload
word 0 is not due until Ci + 4 (§6.1). The temporal reading emits nothing for
that frame; requirements.md **REQ-605** says "the payload's last word SHALL carry
`tuser`[0] = 1", which presupposes a word. The extensional reading emits exactly
one payload word at Ci + 4, with `tkeep` marking the 1 to 7 octets that arrived,
`tlast` = 1 and `tuser`[0] = 1, and satisfies REQ-605 literally. **REQ-605 is
what settles it**, one document up, so this is the specification agreeing with
its requirement rather than a choice between two designs.

**And the boundary case the same row left undecided is decided here.** At exactly
**20** delivered IPv4 octets with a declared total length above 20, the header is
complete and zero payload octets exist. §6.2's `Header` row used to route that
datagram to `Payload` — header accepted, declared payload non-empty — while this
section said the strobe was the only report, so whether `ip_hdr_valid` pulsed was
undecided. It does **not** pulse: `Header` goes to `Idle`, one
`error_ip_truncated` is the whole report, and the rule behind it is worth naming
because it generalises — **a header record is never emitted for a datagram whose
payload frame cannot follow**. The accepted zero-payload case is the *other* one
and is unaffected: a datagram of total length exactly 20 declares no payload
octets, is accepted, pulses `ip_hdr_valid` and emits no payload frame
(requirements.md §0.7). Declared-empty pulses the record; declared-non-empty and
delivered-empty pulses the strobe.

**Aborted-and-forwarded versus discarded-before-emission.** Six of the seven rows
are the second kind. `error_ip_truncated` is the only condition M14 can detect
*after* it has begun emitting, and it is then the first kind: the payload frame
is completed with `tuser`[0] = 1 on its last word, which is REQ-007's own rule
and is why REQ-605 states the marking.

**Counting these strobes** (requirements.md §0.6, carry-forward C-23). Each is
one **high cycle** per datagram. Two or more *different* M14 strobes may be high
on the same cycle, which is the co-occurrence rule above; the *same* strobe
cannot be high on consecutive cycles at M14, because consecutive datagrams are at
least ten cycles apart at REQ-004's arrival rate and each is reported once. A
monitor counts high cycles per strobe.

## 10. REQ coverage

| REQ | How this module satisfies it | Section | Verification hook for DV |
|---|---|---|---|
| REQ-001 | one clock; no gated or derived clock | §3 | the emitted-Verilog edge-expression check |
| REQ-003 | both streams are `Axi64.Source` with no `Dest`; no `tready` in either record | §4.1 | interface compile check |
| REQ-004 | sustains M08's IPv4-port output pattern — 1 header pulse, 6 words, 4 or 5 idle cycles, alternating — for 10 000 datagrams | §8 | line-rate stress bench |
| REQ-005 | fixed-delay pipeline; no payload word withheld to the datagram's end; the last word is not emitted early | §6.1, §7 | per-octet latency tagger inside the stress bench; directed total lengths 20–28 and 1500 |
| REQ-007, REQ-013 | inherited `tuser`[0] reaches the payload `tlast` word and is never acted on — **copied** where that word is emitted after the input `tlast` (§6.1's D ≤ 0), **derived as 0** where it leaves on or before that cycle (D ≥ 1; §6.2, §11.5, ADR-0012). The ultimate consumer is the application (REQ-707), not this module | §3, §6.1, §6.2, §9, §11.5 | drive `tuser`[0] = 1 on an accepted **D ≤ 0** datagram's `tlast` and assert the payload frame is delivered intact with the bit **set** on its last word and no strobe pulses; then drive `tuser`[0] = 1 on a **D ≥ 1** datagram and assert the payload frame is delivered with `tuser`[0] = **0** on its last word and no strobe. The second is the class REQ-007's universal does not reach (§11.5): it is **excluded from the "bit set on its last word" assertion and given its own**, so the exclusion is tested rather than left as a silence. §8's adjacent pair — IPv4 total lengths **36** and **37** inside a 64-octet frame — is the D = 1 and D = 0 boundary pair, each driven twice with opposite input bits |
| REQ-008 | seven conditions, seven strobes, every pulse cycle pinned, co-occurrence stated | §9 | one directed test per rejection class plus the two-condition datagram; frame-conservation monitor |
| REQ-009 | `clear` empties the pipeline; mid-datagram `clear` abandons it silently | §7 | reset test: assert mid-datagram, deassert, open a datagram on the next cycle and assert it parses intact. **The conservation monitor of §0.6 runs with the `clear` exemption of §8 criterion 1 in this test** — without it the abandoned datagram reads as a silent discard and a conformant M14 fails (carry-forward **C-30**) |
| REQ-010 | both streams are the programme `Axi64.Source`; both header records are SPEC-M01's, unchanged; M14 declares no record | §4.1 | interface compile check, including the first witness of `Ip_header`'s seven field names |
| REQ-011 | `ip_payload_tkeep` `0xFF` except on `tlast`, contiguous from bit 0 | §7 | protocol monitor on the payload stream, every bench |
| REQ-012 | every header field decoded to a numeric value, first wire octet most significant | §6.1 | known-datagram directed test comparing all six fields against hand-computed values, including both addresses |
| REQ-014 | `tstrb` ignored in, driven 0 out | §4.2 | protocol monitor; REQ-014's differential run |
| REQ-015 | one `tlast` per payload frame, the `tlast` word included; at most 185 words | §3, §7 | protocol monitor |
| REQ-016 | input idle cycles delay octets and change nothing else; §6.1's cycle formulas are gapless-only | §6.1, §7 | idle-injection wrapper at 0, 1 and 7 cycles, asserting the per-octet constant **L = 12** of §7 — **not** §6.1's cycle formulas and **not** §7's 3-cycle parse latency, which grows by the injected count when the idle lands inside the header (carry-forward **C-27**) |
| REQ-019 | ΔC = 4 against a ceiling of 5, one cycle of reserve inside M14's own allocation; two words of payload storage | §7, §11.2 | ΔC computed from the pinned L and h at freeze; measured ΔC from the stress run in the sign-off packet, quoted against the ceiling of 5 |
| REQ-020 | one datagram at a time; order not expressible otherwise | §6.2 | the sequence numbers in the stress run |
| REQ-021 | payload octet 0 at `ip_payload_tdata`[7:0] at every datagram length | §6.1 | directed total lengths 20–28: 20–27 cover every residue modulo 8, and 28 is what covers the `0xFF` `tkeep` pattern (C-17(e)'s lesson) |
| REQ-401 | consumer side: `hdr_valid` is treated as a one-cycle pulse opening a datagram, and a header with no payload frame is tolerated | §6.1, §7 | inject a 14-octet IPv4-ethertype frame: exactly one `error_ip_truncated`, no `ip_hdr_valid`, next datagram intact |
| REQ-404 | consumer side: M14 does not re-check the ethertype and asserts nothing about a frame delivered here with another value | §4.2, §6.3 item 7 | none — stated so that no sign-off packet claims ethertype coverage here |
| REQ-601 | version 4 and IHL 5 checked on input word 0, **and with them the total-length lower bound** — a declared total length below 20 joins this class (§6.1's partition table, ADR-0013); one strobe, no record, nothing emitted | §6.1, §6.2, §9 | version 6, IHL 6 and IHL 4 datagrams; **declared total lengths 0, 5 and 19**, each otherwise acceptable, asserting one `error_ip_bad_header` at Ci + 3, no `ip_hdr_valid` and no payload word (§8) |
| REQ-602 | the ten header halfwords sum to 0xFFFF in one's-complement arithmetic, checksum halfword included | §6.1, §9 | one header bit flipped. **Declared REQ-901 divergence class (a)**: the reference does not verify this checksum, so co-simulation stimulus is restricted to correct-checksum datagrams and this REQ is verified against the spec by directed test only |
| REQ-603 | more-fragments and fragment offset checked on input word 0; DF and the reserved bit are **not read and not carried**, so their representation is unconstrained while the **outcome** of a datagram that sets them is not (§6.3 item 4) | §6.1, §6.3 item 4, §9 | both fragment forms; plus §8's **flag-bit pair** — one DF-set and one reserved-set datagram, checksums recomputed, MF clear and offset 0, each asserted accepted exactly as the unmodified datagram with no `error_ip_fragment`. That pair is the only stimulus that kills a wrong-bit-position read of octet 6 (**M14-B5**) |
| REQ-604 | four accepted destinations, the subnet broadcast computed as `cfg_local_ip \| ~cfg_subnet_mask`; multicast accepted only when enabled | §4.3, §6.1, §9 | one test per accepted case and three rejected cases, including the configured group with multicast disabled |
| REQ-605 | exactly total length − 20 octets delivered; padding beyond consumed and dropped; a frame ending early aborts the payload **iff at least one payload octet was delivered** and pulses the strobe either way (the extensional branch, C-26); declared total length 20 emits a header record and no payload frame | §6.1, §6.2, §9 | a 64-octet frame carrying total length 28 (18 octets of padding removed, 8 delivered), total length 20, a frame truncated 10 octets early, **the 21-to-27-delivered band** (one payload word, `tuser`[0] = 1, one strobe) and **exactly 20 delivered with total length 46** (no record, no word, one strobe) |
| REQ-606 | six fields in a record whose `valid` is one cycle high, one cycle before the first payload word | §6.1, §7 | known-datagram test comparing every field and the `valid` timing |
| REQ-607 | protocol checked against 17 on input word 1; ICMP is out of scope and gets no reply | §6.1, §9 | protocol 1 and protocol 6 datagrams; plus the two-condition datagram of §8, which is where §0.6's multiplicity rule is asserted |
| REQ-611 | parse latency pinned at 3 cycles from input word 0 to the `ip_hdr_valid` pulse, one constant for every datagram length and every field content, **on a header delivered without internal idle cycles**; REQ-611's gap clause is discharged by the per-octet constant L = 12, which is the gap-invariant one (C-27) | §7 | §8 check 4: the interval equals 3 for all 10 000, one value not a mean — the stress stimulus delivers each header on three consecutive cycles (§8), so the scope condition holds by construction there. Under idle injection the hook is L, not this figure |
| REQ-612 | total length above 1500 rejected on input word 0 | §6.1, §9 | a total-length-1501 datagram |
| REQ-802, REQ-803 | four configuration inputs, each sampled on input word 2; the same-cycle change unconstrained | §4.3, §6.3 item 6 | change `cfg_local_ip` between two datagrams and assert the destination filter follows it at the next datagram, not the one in flight |
| REQ-810 | no instance: REQ-810's receive half is M03's (SPEC-M03 §4.3), and M14 reads no enable | §4.3 | none — stated so that no sign-off packet claims coverage here |
| REQ-901 | declared divergence class **(a)** lives here: the reference performs no header-checksum verification, so co-simulation stimulus carries correct checksums and this comparison boundary excludes REQ-602's rejection path | header, §2 | the co-simulation report names class (a) against this module |
| REQ-903, REQ-808 | `ip_eth_rx_64` is a distinct emitted module with `create`, `hierarchical` and an `.mli` | §4.1 | repository surface check and the `rtl_snapshots/` name comparison |

This table is the source of M14's rows in [`traceability.md`](../traceability.md),
updated in the same commit.

## 11. Deferred items

Item numbers are permanent; a closed item keeps its row (SPEC-TEMPLATE §11).

| # | Item | Status · what a reader assumes meanwhile | Tracked as | Owner | Closes by |
|---|---|---|---|---|---|
| 11.1 | **The `ifc_check` compile evidence for this lift is pending**: `ip_eth_rx_64_ifc.ml` is new in this commit and carries the first compile-time witness of `Ip_header`'s seven field names — the record was frozen at f78766e with no user until batch E. | **CLOSED (WO-0018/WO-0019).** CI `build` run **30739442056** at **3f6accc** reports `success` with all sixteen lifts in it, this one included, and the run's head SHA **is** this specification's commit — so the record froze and elaborated in the same tree and no witnessing argument is owed. The witness of `Ip_header`'s seven field names compiled on its first run. `tools/check_records_vs_appendix.sh` re-passes the byte-identity check on every later commit, this one included. | the `Interface compile check` row of §12 | architect_docs_lead, rtl_lead | closed |
| 11.2 | **M14 pins ΔC = 4 against a §1.1 ceiling of 5**, so it holds one cycle of reserve — the opposite position to SPEC-M06 §11.2, which is pinned exactly at its ceiling with none. | **DEFERRED — the number is decided and buildable, and the reserve is deliberate.** A reader implements ΔC = 4 today, and §7 gives the argument that four is the minimum with a registered output. The reserve is **M14's own allocation** and not the architect's seven cycles of programme slack: a later revision to ΔC = 5 is an ordinary spec diff to §7 with §1.1 and architecture.md §4 untouched, whereas going beyond 5 would be a slack release and would change both copies of the allocation table. Stating which of the two a future cycle would be is the whole point of this row. | this item; requirements.md §1.1 | architect_docs_lead | M14's `P1-module-ready` |
| 11.3 | **REQ-901's divergence class (a) is a restriction on co-simulation stimulus, not only a note**: the reference design does not verify the IPv4 header checksum, so a co-simulation run that injected a bad-checksum datagram would diverge by design at this boundary. | **DEFERRED — the restriction is stated in REQ-602, in REQ-901's class list and in §10, and a reader is not blocked.** Meanwhile: directed tests carry bad checksums, co-simulation stimulus does not. The item closes when the first co-simulation run reports against this boundary and its report names the class, which is what REQ-901's verification column already requires of it. | REQ-901 class (a); this item | dv_lead, architect_docs_lead | the first co-simulation run at this boundary |
| 11.4 | **`cfg_subnet_mask` reaches M14 by a control edge batch E adds** (§4.3), and architecture.md §6.4.3 records the fan-out as one row from the top-level source to the reading module, not as a hop per wrapper. The wrapper hops through M16, M19 and M20 are computed from §4's containment, the same way §6.4.4 treats strobes. | **CLOSED (WO-0019).** SPEC-M19 §6.1 and SPEC-M20 §6.1 write the two hops above M16 — M20 decomposes the twelve-field `Config` record into scalars and fans them to M05 and M19, and M19 fans them on to M16, M17 and M18 — and both confirm architecture.md §6.4.3's rows as source-and-reader pairs with the wrapper hops computed from §4's containment. The `Config` **record** appears at exactly one port in the programme, M20's `cfg`, and every module below it reads scalars; no configuration field is renamed anywhere and no partial record was adopted. | architecture.md §6.4.3; SPEC-M19 §6.1; SPEC-M20 §4.3, §6.1 | architect_docs_lead | closed |
| 11.5 | **REQ-007's universal does not reach the datagram whose Ethernet padding closes M14's copy window** (§6.1's D ≥ 1). REQ-007 reads "every downstream module that emits an output frame for it SHALL mark the corresponding final word of its own output stream `tuser`[0] = 1"; on this class M14's payload `tlast` word leaves on or before the cycle the input `tlast` word is presented, so **no implementation can mark it** and §6.2 makes M14 emit a derived 0. requirements.md states no scope. Raised as ledger **C-37** (dv_lead, WO-0022 Return log §3), decided by **ADR-0012**. | **DEFERRED — the behaviour is decided and stated; what is deferred is whether REQ-007's own text gains the scope.** A reader implements §6.2 today — copy where D ≤ 0, derived 0 where D ≥ 1 — and reads REQ-007 as scoped to the frames a marking module can still mark. **The instrument is not new: it is SPEC-M17 §11.4's carried scoping clause, and this row is its second customer.** §11.4 wrote the clause out, priced it and gated it at `SO-udp_ip_rx_64.md` on a generalisation stated in falsifiable form — "M17 is the only module on the chain whose output frame's extent is fixed by a count declared *inside the data*" — and dv_lead falsified it **here**: M14's extent is fixed by the IPv4 total length, which is such a count, and its `Tail` state exists to consume the Ethernet padding that count exposes. **The corrected generalisation, and the scope of the exception**: it is exactly the modules whose output frame's extent is fixed by an in-data count — **M14 and M17, and those two only**. M10 is safe for a reason §11.4 did not give and which holds independently (SPEC-M10 §3's REQ-007 row: M10 emits no stream, so there is no `tlast` word on which to set the bit); M03, M06, M08, M16 and M19 have no in-data count and end on or after their input frames, as §11.4 says. **The price is unchanged by having two customers and is still flip-invariant**: one normative diff to a FROZEN requirement, `traceability.md`'s REQ-007 row and each implementer's REQ-007 hook, costing the same today and at either closing gate — so there is still nothing bought by taking it early, which is §11.4's own rule applied to §11.4's own item. **What is lost, and it is more than at M17**: M17's class is entered only through a UDP length field that under-declares — in the aborted case, a corrupted one — while M14's is entered by **ordinary Ethernet padding**, so a bad-FCS 64-octet frame carrying a short datagram reaches the application with `tuser`[0] = 0 and cannot be discarded on the bit (REQ-104 → REQ-007 → REQ-707). The event is still reported where it was detected — `error_bad_fcs` at M03 (requirements.md §12) — so nothing is silent at the NIC; what is lost is the **attribution to a frame** at the application port. ADR-0012 records why that residual is carried rather than repaired, and names the repair that would restore attribution (a strobe here, which adds a port and a REQ and is therefore **E2**). | this item; **ADR-0012**; SPEC-M17 §11.4; requirements.md REQ-007; §6.1, §6.2, §8, §10 | architect_docs_lead | **`SO-ip_eth_rx_64.md`** — the packet that would otherwise claim REQ-007 whole at M14 — jointly with `SO-udp_ip_rx_64.md` (SPEC-M17 §11.4). One clause, two gates; whichever comes first decides it for both |

## 12. Freeze record

Filled in at `P1-spec-freeze`. All four rows are required (charter §5).

| Item | Value |
|---|---|
| Interface compile check | CI `build` run **30739442056**, conclusion **`success`**, SHA **3f6accc** — every lift in the single `ifc_check` library elaborates, the three batch-E lifts for the first time; per ADR-0005 a local build is not acceptable evidence. **The run's head SHA is the specification commit**, so no witnessing argument is owed: the text frozen here and the text that elaborated are the same tree. This run is also §11.1's closure record |
| Architect signature | `J-architect_docs_lead-0007`; the C-26, C-27 and C-30 diffs of §13 `J-architect_docs_lead-0008`; the **ADR-0012** revision `J-architect_docs_lead-0010`; the **ADR-0013** revision and the §6.3 item 4 diff `J-architect_docs_lead-0011` |
| dv_lead testability countersignature | **`J-dv_lead-0009`** (WO-0018) — batch E **COUNTERSIGNED at 3f6accc**, this specification **SIGNED** on its own merits: L = 12 / h = 20 / ΔC = 4 re-derived by both of §0.5's routes against the §1.1 ceiling of 5, REQ-611's 3 cycles and the one-cycle header lead re-derived, the six-of-seven decidability verified field offset by field offset, and the abort-bit inequality **⌈(N − 20)/8⌉ + 3 ≥ K** proved for every residue — *that* is what was proved, and it is the second of the two inequalities §6.1 names; the first, M + 3 ≥ K, does **not** follow from it and is false on the D ≥ 1 class, which is why C-37 was reachable at all. The stronger claim was in this row until ledger **C-42** (dv_lead's own self-report, WO-0027) and is corrected here at the first diff to touch this section. Plus **`J-dv_lead-0012`** (WO-0025) — the ADR-0012 revision **RE-COUNTERSIGNED at `8641455`**, quantified rather than re-derived (`tools/check_abort_availability.sh`, 8 720 452 checks, 0 failures) |
| Frozen at | SHA **3f6accc**, gate `docs/gates/P1-spec-freeze-checklist.md` |

## 13. Change log

Post-freeze changes only. Each row cites the ADR that authorised it; a breaking
interface change is counted against post-freeze churn (charter §6). **No row
below is breaking**: §4.1's record is byte-for-byte unchanged since the freeze
SHA, so the `ifc_check` evidence of §12 still witnesses this revision's
interface, and `tools/check_records_vs_appendix.sh` re-passes on this commit.

**Breaking and behavioural are different columns of the same ledger, and this
table now carries one of each class.** The three rows of 2026-08-02 that cite no
ADR are corrections in which no conformant design changes. The **ADR-0012** row
is **behavioural** — a conformant design's output changes on a reachable class of
datagrams — and it is the programme's first post-freeze behavioural spec diff.
It is not breaking, because no record, port, width or pinned constant moves. The
**ADR-0013** row is behavioural in the same sense and breaking in none: it
decides a class the frozen text left with no branch at all, so a design that
implemented one of the three readings changes and no record, port, width or
pinned constant moves. No RTL exists for this module at the date of that row
(WO-0024 delivered M03, M04 and M05 only), so the change is priced against a
specification and a bench, not against a build.

| Date | Change | Breaking? | ADR | Journal |
|---|---|---|---|---|
| 2026-08-02 | §9's truncation row made **extensional** — a payload frame is emitted and aborted iff the datagram declared payload octets and at least one was delivered — with the 21-to-27-delivered band derived; §6.2's `Payload` entry condition and `Header` `Idle` list follow; the exactly-20-delivered boundary decided (no `ip_hdr_valid`, one strobe); §8 gains both directed sets and §10's REQ-605 hook names them (ledger **C-26**) | no | none — **requirements.md REQ-605 settles it one document up** ("the payload's last word SHALL carry `tuser`[0] = 1" presupposes a word), so this is the specification agreeing with its requirement rather than choosing between two designs; no REQ text moves and no other module is affected | `J-architect_docs_lead-0008` |
| 2026-08-02 | §7's 3-cycle **parse latency** scoped to a header delivered without internal idle cycles, with the growth rule stated; §3's REQ-016 row and §6.1's gapless paragraph follow; §10's REQ-016 hook now names **L = 12** as the gap-invariant constant and REQ-611's hook names the scope (ledger **C-27**) | no | none — a scoping correction to a figure REQ-611's own gap clause is discharged by L, not by this figure; the pinned numbers 3, 12, 20 and 4 are all unchanged, and §6.1 already stated the scoping obliquely | `J-architect_docs_lead-0008` |
| 2026-08-02 | §8 criterion 1 gains the **`clear` conservation exemption** (ledger **C-2** at its second module), worded on SPEC-M10 §8's model; §10's REQ-009 hook names it (ledger **C-30**) | no | none — an exemption owed to the *monitor*, not a change to the module: §7 already stated that `clear` abandons an open datagram with no `tlast` and no strobe, and §8's stress run never asserts `clear`, so criterion 1 stands as written for all 10 000 datagrams | `J-architect_docs_lead-0008` |
| 2026-08-02 | **BEHAVIOURAL — the abort bit M14 cannot copy** (ledger **C-37**, dv_lead, WO-0022 Return log §3; F-1's twin at the IPv4 stage). §6.1's availability argument replaced by a **separation formula** — the payload `tlast` word leaves ⌈(N′−20)/8⌉ − ⌈N/8⌉ + 4 cycles after the input `tlast` is presented — keyed on the cycle deficit **D = ⌈N/8⌉ − ⌈(N′−20)/8⌉ − 3**, with the backwards inequality named as the error it was, the padding dependence corrected (padding *closes* the window; the old example carried none), the under-fill threshold **N′ ≥ 8⌈N/8⌉ − 11** derived, the 21 … 36 band inside a 64-octet frame named, and D distinguished from SPEC-M17's **word** deficit at the four residues where they differ. §6.2's `Payload` copy made **conditional on D ≤ 0**, with a derived 0 on D ≥ 1, and `Tail` pinned as a proper **superset** of that class rather than equal to it. §10's REQ-007/REQ-013 hook split so the excluded class carries a **positive assertion** instead of a silence — the previous hook commissioned an assertion no conformant design passes on §8's own directed frames. §8 gains the adjacent boundary pair, IPv4 total lengths **36** and **37** inside a 64-octet frame, each driven twice with opposite input bits, plus a band note on the existing 20 … 28 set. **New §11.5** carries SPEC-M17 §11.4's REQ-007 scoping clause as its **second customer**. §2's in-scope bullet and not-my-job row, §3's REQ-007 and REQ-013 rows and §4.2's two `tuser` rows are qualified in the same sweep, so no site states the copy unconditionally — the sweep C-40 makes at M17, landed here in the same commit so M14 never needs one of its own | no — **behavioural, not breaking**: a conformant design's `ip_payload_tuser`[0] changes on the D ≥ 1 class, and no record, port, width or pinned constant moves (L, h, ΔC, the parse latency and every strobe cycle are untouched) | **ADR-0012** | `J-architect_docs_lead-0010` |
| 2026-08-03 | **BEHAVIOURAL — the declared total length below 20** (dv_lead, `AP-ip_eth_rx_64.md` row **M14-K7**, found by writing the attack plan). §6.1's field table asserted total length "≥ 20 by construction of REQ-601's IHL check", which is **false** — IHL fixes the header length and leaves the total-length field's sixteen bits to the sender — so a datagram declaring 0 … 19 with a correct checksum passed all six header conditions, reached §6.2's `Header` row and matched **neither** of its branches, with M = ⌈(N′ − 20)/8⌉ negative and D undefined. The class joins **REQ-601's** discard class: one `error_ip_bad_header`, no `ip_hdr_valid`, no payload word, decided on input word 0 and reported at Ci + 3. §6.1 gains the derivation and a **partition table** over the whole field domain, and states that every later use of M and D is scoped to N′ ≥ 20 *because* of it; §6.2's `Header` row names both bounds as word-0 decisions and its `Payload` entry condition is pinned at N′ ≥ 21; §9's first row and §4.2's strobe meaning carry the third condition; §2's in-scope bullet, §8's rejection-class set (total lengths 0, 5 and 19) and §10's REQ-601 hook follow | no — **behavioural, not breaking**: a design that implemented one of the three readings the class admitted changes; no record, port, width, strobe name or pinned constant moves, and no other module is affected (M14's producer M08 never reads the field and its consumer M17 sees no datagram for this class) | **ADR-0013** | `J-architect_docs_lead-0011` |
| 2026-08-03 | §6.3 item 4 rewritten: the DF flag and the reserved bit are unconstrained in their **representation** only — M14 has no port and no record field for either, so no monitor may read them out — while the **outcome** of a datagram that sets one is now stated: DF (or reserved) set, more-fragments clear, offset 0 meets no §9 condition and **is accepted**, identically to the datagram with both bits clear and with no `error_ip_fragment`. §8 gains the flag-bit pair (checksums recomputed) and §10's REQ-603 hook names it (dv_lead, **M14-B5**) | no — **not behavioural either**: no conformant design changes, because acceptance was already a function of §9's conditions and those two bits are in none of them. What changes is what DV may assert: the previous blanket "DV SHALL assert nothing about a datagram that sets either" made a wrong-bit-position read of octet 6 **unkillable at M14**, since the only distinguishing stimulus was the one it forbade | none — REQ-603's own text ("DF and the reserved bit are deliberately unconstrained") and §9's condition list already said it between them; this row states it in the one place a bench reads | `J-architect_docs_lead-0011` |
| 2026-08-03 | §12's dv countersignature row: the abort-bit inequality dv_lead proved at WO-0018 corrected from **M + 3 ≥ K** to **⌈(N − 20)/8⌉ + 3 ≥ K**, with the reason the two differ (ledger **C-42**, dv_lead's own self-report). §12's architect-signature row gains the ADR-0012 and ADR-0013 revisions and the row records dv's WO-0025 re-countersignature at `8641455` | no | none — editorial; a claim about what was proved, not about what is required. Landed here because C-42 is gated on "the next SPEC-M14 §12-touching diff" and this is one | `J-architect_docs_lead-0011` |
