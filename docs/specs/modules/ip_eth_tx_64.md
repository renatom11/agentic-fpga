# SPEC-M15 — `Ip_eth_tx_64`

- **Status**: **FROZEN** (`P1-spec-freeze`, SHA `3f6accc`) — batch E, dv_lead
  countersignature `J-dv_lead-0009` (WO-0018), **SIGNED** on this specification's
  own merits with every number recomputed and reproducing. Changes to §4, §6 or
  §7 after this point are spec diffs recorded in §13 (SPEC-TEMPLATE rule 7)
- **Inventory id**: M15 (architecture.md §4) · **Path**:
  `libs/hardcaml_ethernet/src/ip_eth_tx_64.ml`
- **Datapath role**: transmit
- **Owns REQs**: REQ-608, REQ-609, REQ-610 (the IPv4 half — see §5), and the
  *discard* half of REQ-505
- **Prior-art counterpart**: `ip_eth_tx_64.v` (MIT) — consulted for
  decomposition and port naming only; behaviour below is stated independently
  and no source was copied. One declared REQ-901 divergence class is visible
  here: **(c)** discard-on-miss versus the reference's queued resolution
  (REQ-505), so transmit behaviour after a cache miss is not compared
- **Depends on specs**: SPEC-M01 (`Axi64`, `Eth_header`, `Ip_header`), SPEC-M13
  (`Arp`, which declares `Arp_query` and `Arp_response` and answers at Q + 2),
  SPEC-M09 (`Eth_arb_mux`, the consumer of the frame M15 offers, through M16's
  relay ports), SPEC-M14 (the receive counterpart, whose checksum arithmetic
  this one inverts), ADR-0008 (the transmit-side header handshake)
- **Author**: architect_docs_lead, journal `J-architect_docs_lead-0007`

## 1. Purpose

M15 is M14 run backwards, with one thing M14 never has to do: it takes an IPv4
**header record** and a **payload stream**, resolves the datagram's destination
to a MAC address through M13, builds the twenty-octet IPv4 header — including the
checksum it must *compute* rather than check — and emits an Ethernet **header
record** plus a frame-body stream for M09 to arbitrate. It exists as a separate
module for the same reason M07 does: the 20-octet header is not a multiple of
eight, so something has to own the realignment, and putting it here means neither
the UDP transmitter above nor the Ethernet transmitter below has to know that
IPv4 framing is misaligned with a 64-bit datapath.

Its upstream is M18 `Udp_ip_tx_64` (through M16's `ip_tx_*` relay ports,
architecture.md §6.4.2); its downstream is M09 `Eth_arb_mux`, which arbitrates it
against the ARP transmit source; and its control counterpart is M13 `Arp`, which
answers `arp_query` with a MAC or a miss. It instantiates nothing.

## 2. Scope

**In scope.**

- Emitting the twenty IPv4 header octets in RFC 791 wire order, with version,
  IHL, DSCP, ECN, flags, fragment offset and protocol written as the constants
  REQ-608 fixes, TTL from configuration, and an identification field that starts
  at 0 after `clear` and increments by 1 per **transmitted** datagram (REQ-608).
- Computing and inserting the header checksum (REQ-609), which is M14's
  verification arithmetic run in the other direction (§6.1).
- Emitting the record's `total_length` into header octets 2–3 without buffering
  the payload to derive it (REQ-610, the IPv4 half; §5 states the split).
- Building the `Eth_header` record — destination MAC from the ARP resolution,
  source MAC from configuration, ethertype 0x0800 — and offering it with the
  frame's first payload word under ADR-0008.
- Resolving the destination through M13 (`arp_query` / `arp_response`) and, on a
  miss, **discarding the datagram without buffering while continuing to accept
  every one of its payload words**, so a resolution failure never stalls the
  application (REQ-505's discard half).
- The realignment that follows from a 20-octet header on a 64-bit datapath:
  every output word from the third onward is assembled from two payload words
  (§6.1).

**Not this module's job.**

| Behaviour a reader might expect here | Owner |
|---|---|
| Deciding *how* a destination resolves — the class precedence of REQ-507, broadcast, multicast, on-subnet, gateway | M13 `Arp` (REQ-507 … REQ-509). M15 asks about the datagram's destination and is answered with a MAC or a miss; it never sees a subnet mask or a gateway and holds no cache |
| Pulsing `error_arp_miss` | M13 (REQ-505). M15 performs the discard the strobe reports; the strobe is M13's and pulses on the same cycle as the response (SPEC-M13 §9). M15 owns **no** strobe (§9) |
| The UDP header, the application's payload length, or the "+ 8" arithmetic | M18 `Udp_ip_tx_64` (REQ-705, REQ-610's UDP half). M15 receives a `total_length` already computed and a payload stream that already carries the UDP header as its first eight octets |
| The fourteen Ethernet header octets as *frame octets* | M07 `Eth_axis_tx` (REQ-405). M15 emits a header **record** and a body stream; those octets appear on a stream two modules later |
| Choosing between the IPv4 and ARP transmit sources | M09 `Eth_arb_mux` (REQ-406). M15 requests by the ADR-0008 handshake of §7 and is granted by having its first body word accepted |
| Padding to 60 octets, the preamble, the FCS, the gap | M04 `Xgmii_tx_64` (REQ-201 … REQ-205). A minimum IPv4/UDP frame is 14 + 20 + 8 = 42 octets before payload and is padded by M04 (REQ-203); nothing here counts to 60 |
| Fragmenting a datagram that will not fit | **nobody** — Phase 1 never produces one. REQ-610 makes total length the application's declared payload plus 28, and REQ-612 caps what the receive side accepts at 1500; flags and fragment offset are emitted as constant 0 (REQ-608) |
| Decrementing TTL, or forwarding anything | **nobody**: Phase 1 originates every datagram it transmits, so REQ-608's "TTL from configuration" is the whole of TTL's behaviour |

## 3. Programme invariants that bind this module

M15 is **not** a receive-path module under requirements.md §0.4: it is on the
transmit chain, its `payload_tready` towards M18 is legitimate, and §1.1
allocates it no latency ceiling.

| REQ | Consequence for M15 |
|---|---|
| REQ-001 | One `clock`, shared with the receive path (REQ-018 keeps the XGMII boundary simulation-only, so there is no second domain). |
| REQ-002 | Payload input and body output are 64-bit `Axi64` streams, at most one word per cycle each. |
| REQ-003 | Does not bind M15's ports — but REQ-208 does: nothing here may reach back into the receive datapath, and nothing does, because M15 has no receive-side port. Its `arp_query` reaches M13's *transmit* logic only, and SPEC-M13 §7 states that the receive relay through M13 is untouched. |
| REQ-005 | Does not bind M15 (not a receive-path module). Its analogue is §7's **two** pinned constants — the 1-cycle event delay to body word 0 and the per-octet latency L = 28 — plus the fixed two-cycle resolution wait, all stated so that REQ-502's and REQ-209's cadences compose from named numbers. M15's per-octet constant is single-valued on a **gapless** stimulus only: §7 records that M15 fails §0.5's straddle test, so REQ-005's tagger assertion would fail a conformant design under injection and is not available here even by analogy. |
| REQ-007, REQ-013 | `tuser`[0] on the payload's `tlast` word is copied to the body stream's `tlast` word and is **not** acted on: M15 transmits the frame regardless, which is REQ-013's "no module drops a frame solely because this bit is set". M15 originates no abort. |
| REQ-008 | M15 owns **no** strobe. Its one discard — a datagram whose destination misses — is reported by M13's `error_arp_miss` on the cycle M15 learns of it, one pulse per discarded datagram (§9). |
| REQ-009 | Synchronous `clear`: `eth_hdr_valid` = 0, `eth_payload_tvalid` = 0, `payload_tready` = 0 and `arp_query_valid` = 0 while `clear` = 1 and on the first cycle after; a frame in flight is abandoned with no `tlast`, and the identification counter returns to 0 (REQ-608). |
| REQ-010 | Payload in and body out are the programme `Axi64.Source`, each with the matching `Axi64.Dest` in the other direction — the transmit-path pattern of architecture.md §2.3. `Ip_header` and `Eth_header` are SPEC-M01's; `Arp_query` and `Arp_response` are SPEC-M13's, opened and not restated (§4.1). |
| REQ-011 | `tkeep` on the incoming payload `tlast` word says how many octets of that word are payload; `tkeep` on the emitted `tlast` word marks exactly the octets the body carries. |
| REQ-012 | Header octets are emitted first wire octet first: `total_length`[15:8] is IPv4 octet 2, `cfg_local_ip`[31:24] is octet 12. Payload octet position k maps to body octet 20 + k (§6.1). |
| REQ-014 | `tstrb` on the payload input is ignored; `tstrb` on the body output is driven to 0. |
| REQ-015 | One `tlast` per frame in each direction. At most **188** words between two `tlast` words on the body stream (1500 octets: a 20-octet header plus a 1480-octet maximum payload), the `tlast` word included. |
| REQ-016 | The payload source **may** deassert `tvalid` between words and M15 tolerates it without corrupting the frame — M15 simply does not advance. REQ-016's tolerance ends two modules later, at M04's source port (REQ-206), and M15 never presents a word downstream that it has not already accepted. |
| REQ-019 | No instance: M15 is not on the chain REQ-006 measures and §1.1 allocates it nothing. Its storage is **two** payload words, which is the realignment and not a buffer of frames — the same depth M07 holds for the same reason, and the reason REQ-610's "SHALL NOT buffer the payload" is structural here rather than promised (§7). |
| REQ-020 | Datagrams leave in the order M18 offered them; M15 holds one at a time (§6.2), so reordering is not expressible. |
| REQ-021 | Producer-side word alignment holds at M15's output — body octet 0, the first IPv4 header octet, is at `eth_payload_tdata`[7:0] of body word 0 — but the *work* is M14's realignment in reverse, and §6.1 states it rather than letting the trivial reading hide it. |

## 4. Interface

### 4.1 Interface records

```ocaml
(* SPEC-M15 §4.1, lifted verbatim into docs/specs/ifc_check/ip_eth_tx_64_ifc.ml
   (SPEC-TEMPLATE.md rule 6). Records and signatures only — no logic, no
   implementation.

   [Axi64_ifc] is M01's types home (SPEC-M01 §4.1): [Axi64], [Eth_header]
   and [Ip_header] come from there. [Arp_ifc] is where SPEC-M13 §4.1
   declares [Arp_query] and [Arp_response], because M01 is FROZEN at
   f78766e and a record added there would be a breaking post-freeze
   interface change; the declare-once rule batch D adopted is that such a
   record is declared at the module that owns it and OPENED by every
   counterpart (SPEC-M10 §4.1, §11.2; SPEC-M13 §11.5). This is that
   rule's first cross-batch instance and M15 restates neither record.

   Batch E declares NO record of its own. Opening [Arp_ifc] does not
   re-export what THAT file opened, so [Axi64_ifc] is opened here too;
   there is no cycle, because M13's lift references nothing of M15's.

   Transmit-path module, so [Source] one way and [Dest] the other on each
   of the two logical streams: the payload stream's [Source] is an input
   and its [Dest] an output; the body stream's [Source] is an output and
   its [Dest] an input. Each stream's two directions share a prefix with
   no collision, because [Source]'s field names and [Dest]'s are disjoint
   (SPEC-M04 §4.1 fixes that pattern).

   Neither header record carries a [ready]: [hdr]'s acceptance event is
   the acceptance of the frame's first payload word by THIS module, and
   [eth_hdr]'s is the acceptance of the frame's first body word by M09
   (ADR-0008). [arp_query] and [arp_response] carry neither a [ready] nor
   an acceptance event: M13 can never refuse a query (SPEC-M13 §7). *)

open! Base
open Hardcaml
open! Axi64_ifc
open! Arp_ifc

module I = struct
  type 'a t =
    { clock : 'a
    ; clear : 'a
    ; hdr : 'a Ip_header.t [@rtlprefix "hdr_"]
    ; payload : 'a Axi64.Source.t [@rtlprefix "payload_"]
    ; eth_payload_dest : 'a Axi64.Dest.t [@rtlprefix "eth_payload_"]
    ; arp_response : 'a Arp_response.t [@rtlprefix "arp_response_"]
    ; cfg_local_mac : 'a [@bits 48]
    ; cfg_local_ip : 'a [@bits 32]
    ; cfg_ttl : 'a [@bits 8]
    }
  [@@deriving hardcaml]
end

module O = struct
  type 'a t =
    { payload_dest : 'a Axi64.Dest.t [@rtlprefix "payload_"]
    ; eth_hdr : 'a Eth_header.t [@rtlprefix "eth_hdr_"]
    ; eth_payload : 'a Axi64.Source.t [@rtlprefix "eth_payload_"]
    ; arp_query : 'a Arp_query.t [@rtlprefix "arp_query_"]
    }
  [@@deriving hardcaml]
end

module type S = sig
  val create : Scope.t -> Signal.t I.t -> Signal.t O.t
  val hierarchical : ?instance:string -> Scope.t -> Signal.t I.t -> Signal.t O.t
end

(* REQ-010 type identity in both directions of both streams, and a
   compile-time witness that the two resolution records here are the same
   types SPEC-M13 §4.1 declares — the check that the declare-once rule
   held across a batch boundary. *)

let _witness_both_directions
      (s : Signal.t Axi64.Source.t)
      (d : Signal.t Axi64.Dest.t)
  =
  s, d
;;

let _witness_resolution_records_are_m13s
      (q : Signal.t Arp_query.t)
      (r : Signal.t Arp_response.t)
  =
  q, r
;;
```

Conformance of this block to the template's rules for §4.1:

- Scalar fields carry `[@bits n]` unless they are one bit wide: `clock` and
  `clear` are one bit; `cfg_local_mac`, `cfg_local_ip` and `cfg_ttl` carry 48,
  32 and 8, and every other field is inside a nested record carrying its own
  widths.
- Nested interfaces carry `[@rtlprefix]`: `hdr` emits `hdr_valid` …
  `hdr_total_length`, `payload` and `payload_dest` emit `payload_tvalid` …
  `payload_tuser` and `payload_tready`, `eth_hdr` emits `eth_hdr_valid` …
  `eth_hdr_ethertype`, `eth_payload` and `eth_payload_dest` emit
  `eth_payload_tvalid` … `eth_payload_tuser` and `eth_payload_tready`, and the
  two resolution records emit `arp_query_valid`, `arp_query_ip`,
  `arp_response_valid`, `arp_response_found` and `arp_response_mac`. Every name
  is architecture.md §6.4.2's and §6.4.3's, confirmed unchanged by this batch.
- **`Source` one way and `Dest` the other, on each logical stream**: held. M15
  is allowed both because it is not a receive-path module (requirements.md
  §0.4); REQ-208, not REQ-003, is what keeps its backpressure away from the
  receive datapath, and REQ-208 holds structurally because M15 has no receive
  port at all.
- Both `create` and `hierarchical` are declared (REQ-903, REQ-808).

### 4.2 Port table

Every port in §4.1 appears exactly once. Direction is with respect to M15.

| Port | Dir | Width | Meaning | REQ |
|---|---|---|---|---|
| `clock` | in | 1 | 156.25 MHz single domain | REQ-001 |
| `clear` | in | 1 | synchronous clear; the identification counter returns to 0 | REQ-009, REQ-608 |
| `hdr_valid` | in | 1 | a datagram is offered; **held** until its first payload word is accepted (ADR-0008) | REQ-610, ADR-0008 |
| `hdr_dst_ip` | in | 32 | the datagram's destination address: emitted at IPv4 octets 16–19 **and** presented to M13 as `arp_query_ip` | REQ-507, REQ-610, REQ-012 |
| `hdr_total_length` | in | 16 | the datagram's total length in octets, header included, computed by M18 as the application's payload length + 28 (REQ-610); emitted at IPv4 octets 2–3 and used to size the body | REQ-610 |
| `hdr_src_ip` | in | 32 | **read by nothing**: REQ-608 fixes the source address as `cfg_local_ip`, so carrying it here would create a second place for it to differ (§6.1) | REQ-608 |
| `hdr_protocol` | in | 8 | **read by nothing**: REQ-608 fixes protocol 17 as a constant | REQ-608 |
| `hdr_ttl` | in | 8 | **read by nothing**: REQ-608 takes TTL from `cfg_ttl` | REQ-608 |
| `hdr_dscp` | in | 6 | **read by nothing**: REQ-608 fixes DSCP and ECN to 0 | REQ-608 |
| `payload_tvalid` | in | 1 | the source presents a payload word this cycle | REQ-016 |
| `payload_tdata` | in | 64 | payload octets, word-aligned at the producer (REQ-021); octet 0 is the first UDP header octet | REQ-012 |
| `payload_tkeep` | in | 8 | valid octet positions; 1 to 8 contiguous ones on the `tlast` word | REQ-011 |
| `payload_tstrb` | in | 8 | reserved; ignored | REQ-014 |
| `payload_tlast` | in | 1 | this word carries the payload's final octets | REQ-015 |
| `payload_tuser` | in | 1 | bit 0 advisory abort; copied out, never acted on | REQ-013, REQ-007 |
| `eth_payload_tready` | in | 1 | M09 accepts a body word this cycle; its first acceptance is the grant (ADR-0008) | REQ-207 (two stages up), REQ-406 |
| `arp_response_valid` | in | 1 | M13 answers this cycle — always exactly two cycles after the query (SPEC-M13 §7) | REQ-505, REQ-507 |
| `arp_response_found` | in | 1 | on that cycle: 1 if the destination resolved, 0 if it missed. Meaningful only then | REQ-505, REQ-507 |
| `arp_response_mac` | in | 48 | on `found` = 1, the MAC to send this datagram to. Meaningful only on a `valid` cycle with `found` = 1 | REQ-507 … REQ-509 |
| `cfg_local_mac` | in | 48 | the configured local MAC; `eth_hdr_src_mac` on every frame | REQ-608, REQ-802 |
| `cfg_local_ip` | in | 32 | the configured local IPv4 address; IPv4 octets 12–15 on every datagram | REQ-608, REQ-802 |
| `cfg_ttl` | in | 8 | the TTL emitted at IPv4 octet 8 (default 64) | REQ-608, REQ-802 |
| `payload_tready` | out | 1 | M15 accepts a payload word this cycle; an accepted word is transmitted **or**, on a miss, accepted and discarded (REQ-505) | REQ-207 (one stage up), REQ-505 |
| `eth_hdr_valid` | out | 1 | a frame is offered to M09; asserted together with body word 0's `tvalid` and held until that word is accepted (ADR-0008) | REQ-405, ADR-0008 |
| `eth_hdr_dst_mac` | out | 48 | `arp_response_mac` from this datagram's resolution | REQ-507 … REQ-509 |
| `eth_hdr_src_mac` | out | 48 | `cfg_local_mac` | REQ-608 |
| `eth_hdr_ethertype` | out | 16 | constant **0x0800** | REQ-404, REQ-608 |
| `eth_payload_tvalid` | out | 1 | this cycle carries a body word | REQ-016 |
| `eth_payload_tdata` | out | 64 | IPv4 header octets then payload octets, header octet 0 at position 0 of word 0 | REQ-012, REQ-021 |
| `eth_payload_tkeep` | out | 8 | valid octet positions, contiguous from bit 0 | REQ-011 |
| `eth_payload_tstrb` | out | 8 | reserved; driven to 0 | REQ-014 |
| `eth_payload_tlast` | out | 1 | this word carries the body's final octets | REQ-015 |
| `eth_payload_tuser` | out | 1 | bit 0: the inherited advisory abort, on the `tlast` word | REQ-013, REQ-007 |
| `arp_query_valid` | out | 1 | one-cycle pulse: resolve this datagram's destination. One per offered datagram, on the cycle the offer is first seen (§6.1) | REQ-505, REQ-507 |
| `arp_query_ip` | out | 32 | `hdr_dst_ip` — the datagram's **destination**, not a resolution target: choosing the target is M13's job (SPEC-M13 §4.1's note on the two record types) | REQ-507, REQ-012 |

### 4.3 Configuration inputs

M15 reads **three** fields of the `Config` record (requirements.md §9.1), as
scalars, exactly as architecture.md §6.4.3 routes them.

| Field | Effect | When a change takes effect (REQ-803) |
|---|---|---|
| `cfg_local_mac` | `eth_hdr_src_mac` on every frame M15 offers | sampled on the cycle the header is built — the cycle the frame's first payload word is accepted (§6.1). A change landing at least one cycle earlier applies to that frame; a change landing on that cycle itself is deliberately unconstrained (§6.3 item 5) |
| `cfg_local_ip` | IPv4 octets 12–15, the source address, on every datagram (REQ-608) | same cycle, same rule |
| `cfg_ttl` | IPv4 octet 8 (REQ-608, default 64) | same cycle, same rule |

All three are sampled on **one** cycle and all three enter the checksum computed
on that cycle, so a configuration change can never land inside a header: either
the whole header is built from the old values or the whole header is built from
the new ones, and the checksum agrees with whichever it was. That is REQ-803's
"static while a frame is in flight" made structural rather than promised, and it
is why this specification needs no per-field sampling rule.

## 5. Parameters

**None.** REQ-506's rule has no instance: M15 has no timeout, no ageing interval
and no retry — the retry sequence for an unresolved destination belongs to M13
(REQ-506's retry half, SPEC-M13 §5). Its numeric constants — 4, 5, 20, 17, 0,
0x0800 and 28's absence — are fixed by REQ-608 and REQ-610, and making any of
them overridable would let a test configure a protocol the programme does not
have.

| Parameter | Type | Default | Range | Why a test overrides it |
|---|---|---|---|---|
| (none) | — | — | — | — |

**REQ-610 is owned in two halves, and this is the IPv4 half.** REQ-610 states two
arithmetic facts and one prohibition: *total length* is the application's payload
length plus 28, the *UDP length field* is that payload length plus 8, and neither
may be derived by buffering the payload. The two lengths are computed where the
payload length is known — at **M18**, which receives it in the application's
transmit request (REQ-705) — and M18 delivers the first as `hdr_total_length` in
the `Ip_header` record it offers here. **M15's half** is therefore: it emits that
field into IPv4 octets 2–3 in network byte order, it sizes the body from it, and
it buffers **nothing** to do either — §7's structural argument is that M15 holds
exactly two payload words and emits its first body word after accepting exactly
one, at every payload length. **M15 claims no coverage of the UDP length field
and no coverage of the "+ 28" arithmetic**, and SPEC-M18 (batch F) states the
converse; `traceability.md`'s REQ-610 row lists both modules. This is the
two-half ownership pattern SPEC-M12 §11.3 and SPEC-M13 §5 established for
REQ-506 and REQ-503, applied here because dv_lead asked batch E to copy it
wherever a REQ spans modules (WO-0015 Return log §4/Q5).

## 6. Behaviour

### 6.1 Normal path

**The IPv4 header M15 writes**, with the octet offsets a test writer needs to
hand-assemble the reference datagram REQ-608 compares against. Offsets are from
the first octet M15 emits, which is the first octet after the Ethernet header on
the wire. This table is the transpose of SPEC-M14 §6.1's.

| Field | Octet offset | Width | Source | Wire order |
|---|---|---|---|---|
| version | 0, bits 7:4 | 4 bits | **constant 4** (REQ-608) | octet 0 is 0x45 for every datagram |
| header length (IHL) | 0, bits 3:0 | 4 bits | **constant 5** (REQ-608) | — no options are ever emitted |
| DSCP | 1, bits 7:2 | 6 bits | **constant 0** (REQ-608) | octet 1 is 0x00 for every datagram |
| ECN | 1, bits 1:0 | 2 bits | **constant 0** (REQ-608) | — |
| total length | 2–3 | 16 bits | `hdr_total_length` | most significant octet first: total length 46 emits 0x00 then 0x2E |
| identification | 4–5 | 16 bits | the **counter** below (REQ-608) | most significant octet first |
| flags | 6, bits 7:5 | 3 bits | **constant 0** (REQ-608) | octets 6–7 are 0x0000 for every datagram |
| fragment offset | 6 bits 4:0, 7 | 13 bits | **constant 0** (REQ-608) | — |
| TTL | 8 | 8 bits | `cfg_ttl` (default 64) | 0x40 at the default |
| protocol | 9 | 8 bits | **constant 17** (REQ-608) | 0x11 |
| header checksum | 10–11 | 16 bits | computed below (REQ-609) | most significant octet first |
| source address | 12–15 | 32 bits | `cfg_local_ip` | `cfg_local_ip`[31:24] is octet 12 |
| destination address | 16–19 | 32 bits | `hdr_dst_ip` | `hdr_dst_ip`[31:24] is octet 16 |

**Four fields of the incoming record are read and four are not**, which is
SPEC-M14 §6.1's decision seen from the other side. M15 reads `valid`, `dst_ip`
and `total_length`, and it reads them for the three purposes above. It does
**not** read `src_ip`, `protocol`, `ttl` or `dscp`: REQ-608 fixes each of those
to a constant or to a configuration input, so taking them from the record would
create a second place where a wrong value could enter the design and would oblige
every bench to assert that M18 relayed four constants unchanged. DV SHALL assert
nothing about what M15 emits when those four fields carry anything in particular
— the emitted header is a function of `cfg_local_ip`, `cfg_ttl`, `hdr_dst_ip`,
`hdr_total_length` and the counter, and of nothing else.

**The identification counter (REQ-608).** A 16-bit counter, 0 after `clear`,
incremented by 1 **per transmitted datagram** — REQ-608's own words. A datagram
discarded on an ARP miss is not transmitted and does **not** consume a value, so
REQ-608's verification ("transmit three datagrams; check the identification
sequence 0, 1, 2") holds even in a run where a resolution failed in the middle.
The value emitted is the counter's value at the cycle the header is built, and
the increment takes effect for the next frame; it wraps modulo 65 536 with no
special case.

**The header checksum (REQ-609), stated as arithmetic.** Take the twenty header
octets as ten 16-bit halfwords, first wire octet most significant in each, with
the checksum halfword at octets 10–11 taken as **0x0000**; sum them in
one's-complement arithmetic — add as unsigned 16-bit values and fold every carry
out of bit 15 back into bit 0 — and emit the **one's complement** of that sum at
octets 10–11. Every input is available at header-build time, so no payload octet
is ever needed and REQ-610's no-buffering prohibition is not even approached.

*Worked, so a test writer can hand-compute one and so the loopback has an
anchor.* Local IP 192.0.2.1, destination 192.0.2.9, TTL 64, identification 0,
total length 46 (an 18-octet UDP payload, REQ-708's stimulus). The ten halfwords
are 0x4500, 0x002E, 0x0000, 0x0000, 0x4011, 0x0000, 0xC000, 0x0201, 0xC000,
0x0209; their one's-complement sum is 0x094B; the emitted checksum is
**0xF6B4**. The check that ties the two directions together: summing all ten
halfwords of the **emitted** header, checksum included, gives 0x094B + 0xF6B4 =
**0xFFFF**, which is exactly the residue SPEC-M14 §6.1 verifies. A loopback
through M14 (REQ-602) therefore checks REQ-609 without a second reference
implementation — and REQ-609's verification column also requires an
**independently computed** checksum, because a shared-arithmetic loopback would
pass a systematically wrong but self-consistent implementation, which is the same
argument REQ-202 makes for the FCS.

**The Ethernet header M15 builds**, and the one field of it that is not a
constant or a configuration value:

| Field | Value | Why |
|---|---|---|
| `eth_hdr_dst_mac` | `arp_response_mac`, captured on this datagram's `arp_response_valid` cycle with `found` = 1 | REQ-507 … REQ-509: the resolution is M13's answer, whether it came from the cache, from a broadcast rule or from the multicast arithmetic. M15 does not know which and must not |
| `eth_hdr_src_mac` | `cfg_local_mac` | REQ-608's companion at the Ethernet layer; M07 emits it as frame octets 6–11 (SPEC-M07 §6.1) |
| `eth_hdr_ethertype` | 0x0800 | REQ-404's IPv4 ethertype; a constant, never read from anywhere |

**The offer and the resolution, in the order they happen.** With Q the first
cycle on which M15 sees `hdr_valid` = 1 while it is idle — the cycle M18's offer
appears, ADR-0008 having obliged M18 to assert `hdr_valid` and payload word 0's
`tvalid` together and hold both:

1. **Cycle Q**: M15 pulses `arp_query_valid` = 1 with `arp_query_ip` =
   `hdr_dst_ip`. It holds `payload_tready` = 0. Nothing is captured and nothing
   is committed.
2. **Cycles Q and Q + 1**: `payload_tready` = 0. M18 holds the offer; this is
   ADR-0008 decision 2 doing exactly the job it exists for.
3. **Cycle Q + 2**: M13 answers (`arp_response_valid` = 1 — always at Q + 2,
   uniformly across all five destination classes, SPEC-M13 §7). M15 accepts the
   frame's first payload word on this cycle, **whichever answer arrives**, and
   the two answers diverge only in what it does with it:
   - **`found` = 1**: the header is built — `cfg_local_mac`, `cfg_local_ip`,
     `cfg_ttl` and the counter are sampled here (§4.3), the checksum is computed
     here, and `arp_response_mac` is captured here — and the frame is offered to
     M09 from cycle Q + 3;
   - **`found` = 0**: the datagram is **discarded**. M15 emits nothing at all —
     no `eth_hdr_valid`, no body word — and holds `payload_tready` = 1 until it
     has accepted the payload's `tlast` word, so the application is never
     stalled (REQ-505). M13 pulses `error_arp_miss` on this same cycle (SPEC-M13
     §9); M15 pulses nothing, because the strobe already exists and §0.6 gives
     one condition one strobe.
4. **Cycle Q + 3 onward** (on a hit): body word 0 is offered with
   `eth_hdr_valid` = 1 and held until M09 accepts it (ADR-0008 decisions 1 and
   2); the rest of the body follows as it is accepted.

**Two cycles of `payload_tready` = 0 at the head of every datagram is the whole
cost of resolution**, and it is a constant. SPEC-M13 §7 pins the response at
Q + 2 for *every* destination class precisely so that this figure does not become
a function of the network configuration — a broadcast destination and a
cache-missing off-subnet destination cost M15 the same two cycles. A bench may
assert the two cycles directly.

**Where the octets land.** Body octet 20 + k is payload octet k, so body word 0
and body word 1 are header only (IPv4 octets 0–15), body word 2 carries header
octets 16–19 plus payload octets 0–3, and body word n ≥ 3 carries payload octets
8n − 20 through 8n − 13 — which lie in payload words n − 3 (positions 4 to 7) and
n − 2 (positions 0 to 3). That is the realignment, and it is why M15 holds
**two** payload words.

**On an unstalled frame** (`eth_payload_tready` = 1 throughout), with C the cycle
on which M15 accepts the frame's first payload word — which is Q + 2 above:

- body word 0 is emitted on cycle **C + 1**, and body word n on cycle
  **C + 1 + n**;
- payload word j is accepted on cycle **C + j**, so the payload word a body word
  needs is always accepted at least one cycle before that word leaves.

**Cycle by cycle, an 18-octet UDP payload** — REQ-708's datagram, the one a
minimum-length frame carries. The payload M15 receives is the 8-octet UDP header
plus 18 octets = 26 octets in 4 words (three full, one carrying 2 octets); the
body is 20 + 26 = 46 octets in 6 words (five full, one carrying 6 octets).

| Cycle | `payload_tready` | Payload input | Body output (`eth_payload`) |
|---|---|---|---|
| Q | **0** | offer seen: `hdr_valid` = 1 with payload word 0 held | `arp_query_valid` = 1; `eth_payload_tvalid` = 0 |
| Q+1 | **0** | offer still held (ADR-0008) | nothing |
| C = Q+2 | 1 | payload word 0 accepted (payload octets 0–7) | `arp_response_valid` = 1, `found` = 1; header built and checksum computed |
| C+1 | 1 | payload word 1 accepted | body word 0: IPv4 octets 0–7, offered with `eth_hdr_valid` = 1 |
| C+2 | 1 | payload word 2 accepted | body word 1: IPv4 octets 8–15 |
| C+3 | 1 | payload word 3 accepted (2 octets, `tlast` = 1) | body word 2: IPv4 octets 16–19 and payload octets 0–3 |
| C+4 | **0** | — | body word 3: payload octets 4–11 |
| C+5 | **0** | — | body word 4: payload octets 12–19 |
| C+6 | **0** | — | body word 5: payload octets 20–25, `tkeep` = 0x3F, `tlast` = 1, `tuser`[0] copied from the payload's `tlast` word |
| C+7 | 1 if a datagram is offered | the next datagram's offer | `eth_payload_tvalid` = 0 |

`payload_tready` falls for the last **three** cycles of this frame because M15
emits **more** words than it consumes: it adds twenty octets, so
W = ⌈(20 + P)/8⌉ body words come from J = ⌈P/8⌉ payload words, and the word
surplus W − J is **2** for payload lengths P ≡ 1, 2, 3 or 4 (mod 8) and **3**
for P ≡ 0, 5, 6 or 7 (mod 8). The count of zero cycles is **W − J + 1**, so it is
**three or four** and not two or three: the frame's last payload word is accepted
on cycle C + J − 1 and its last body word leaves on cycle C + W, and
`payload_tready` is 0 on every cycle between, inclusive — C+4, C+5 and C+6 in the
table above, where J = 4 and W = 6.

*The `+ 1` is carry-forward **C-17(b)**'s lesson applied before the fact rather
than after it.* At M07 the same count was written as W − J in three places and
was wrong in all three, because a throughput assertion built from the word
surplus fails **every** conformant design at every payload length. The two
quantities are different and are named separately here for that reason: W − J is
the number of extra words the module emits, and W − J + 1 is the number of
stalled cycles, one more because the cycle on which the last payload word is
accepted is not itself a stalled cycle while the cycle on which the last body
word leaves is.

**When the consumer stalls.** `payload_tready` is 1 only when
`eth_payload_tready` is 1 and the frame still needs payload words, so a cycle on
which M09 cannot accept a word is a cycle on which M15 accepts none either: the
two words in flight are held in their registers, nothing is dropped and nothing
is duplicated (REQ-207's discipline, two stages before M04). Every cycle formula
above shifts by exactly the number of stalled cycles. Until M09 grants — that is,
until body word 0 is accepted — M15 holds the offer unchanged, which is ADR-0008
decision 2's requirement on a source and is what lets an arbiter make a port wait
without losing its header.

**When the source stalls.** M18 may deassert `payload_tvalid` between words
(REQ-016) and M15 simply does not advance: it emits no body word that cycle.
Nothing downstream breaks, because M15 never presents a word to M09 it has not
already accepted.

**On a miss, in full** (REQ-505's discard half). M15 emits **no** body word and
**no** `eth_hdr_valid` — the datagram never reaches M09, so M09 never grants and
no partial frame can appear on the wire — and it accepts every remaining payload
word at one per cycle until `tlast`, discarding each. `payload_tready` is
therefore **1** on every cycle from C to the `tlast` acceptance, which is the
*opposite* of the hit case's drain and is the observable REQ-505's "the transmit
path SHALL continue to accept and discard the remaining payload words" names. The
datagram consumes no identification value. M13 reports it with one
`error_arp_miss` high cycle at C (SPEC-M13 §9) and issues the ARP request if none
is outstanding for that target; M15 does none of that and knows none of it.

### 6.2 State machine

Reset state and `clear` state are both `Idle`.

| State | Entered when | Does | Leaves to |
|---|---|---|---|
| `Idle` | reset; `clear`; the frame's `tlast` body word is accepted; a discarded datagram's payload `tlast` is accepted | `eth_payload_tvalid` = 0, `eth_hdr_valid` = 0, `payload_tready` = 0, `arp_query_valid` = 0 | `Resolving` on the first cycle `hdr_valid` = 1, pulsing `arp_query_valid` with `arp_query_ip` = `hdr_dst_ip` on that cycle |
| `Resolving` | a datagram was offered and the query was issued | `payload_tready` = 0; waits exactly two cycles; nothing is captured | `Header` on the `arp_response_valid` cycle with `found` = 1 — accepting payload word 0, sampling the three configuration inputs, capturing the MAC, computing the checksum; `Discard` on that cycle with `found` = 0 |
| `Header` | the destination resolved | emits body word 0 (header only) with `eth_hdr_valid` = 1 and holds both until word 0 is accepted (ADR-0008), then body word 1; keeps accepting payload words while `eth_payload_tready` = 1 | `Body`, always, after body word 1 |
| `Body` | body word 1 has been emitted | emits body word n from payload words n − 3 and n − 2; accepts a payload word on every cycle `eth_payload_tready` = 1 until the payload's `tlast` word has been accepted | `Drain` on accepting the payload `tlast` word |
| `Drain` | the payload `tlast` word has been accepted | emits the remaining **three or four** body words — W − J + 1 of them, §6.1 — the last carrying `eth_payload_tlast` = 1, the `tkeep` the payload length implies and the inherited `tuser`[0]; holds `payload_tready` = 0 throughout | `Idle` when that word is accepted |
| `Discard` | the destination missed (REQ-505) | emits nothing anywhere; holds `payload_tready` = **1** and accepts and drops every remaining payload word; pulses nothing — the strobe is M13's | `Idle` on accepting the payload `tlast` word |

A cycle on which `eth_payload_tready` = 0, or on which the source presents no
payload word, holds every state and every register: it is not a condition and it
advances nothing (§6.1). `clear` in any state returns to `Idle`, abandoning a
frame in flight with no `tlast` and resetting the identification counter to 0.

### 6.3 Deliberately unconstrained

Anything not listed here is constrained by this specification, and a test may
rely on it.

1. **The placement of the register levels** inside the one-cycle delay, and every
   internal encoding: the FSM encoding, how the 20-octet realignment shift is
   built, whether the header is held in one register or eight, whether the
   checksum is an adder tree or a two-halfword accumulator running during
   `Resolving`. §7's constants are what is fixed.
2. **The value of `eth_payload_tdata` at positions where `eth_payload_tkeep` is
   0**, the three `eth_hdr` fields on a cycle with `eth_hdr_valid` = 0, and
   `arp_query_ip` on a cycle with `arp_query_valid` = 0 (SPEC-M01 §6.3 item 5).
   No monitor may read them.
3. **What M15 emits for the four `Ip_header` fields it does not read** —
   `src_ip`, `protocol`, `ttl`, `dscp` (§6.1). The emitted header is a function
   of the configuration and of two record fields; DV SHALL assert nothing about
   the effect of the other four, and SPEC-M18 is free to drive them to whatever
   is convenient.
4. **M15's behaviour when a header is offered with no payload word**, or when
   `hdr_valid` is asserted without `payload_tvalid`. ADR-0008 decision 4 forbids
   it and Phase 1 produces none: every transmit datagram carries at least the
   8-octet UDP header (REQ-610), so the case is **unreachable rather than
   undefined**, no requirement names it, and DV SHALL assert nothing about it.
   This is the wording SPEC-M07 §6.3 item 3 uses.
5. **The outcome of changing `cfg_local_mac`, `cfg_local_ip` or `cfg_ttl` on the
   exact cycle the header is built** (§4.3). A change landing at least one cycle
   earlier is governed; the same-cycle case is left open deliberately, and a
   bench that drives it and asserts either outcome is flaky by construction and
   SHALL NOT be written. This is carry-forward **C-14.5**'s rule applied to this
   module.
6. **M15's behaviour if `arp_response_valid` arrives on a cycle other than
   Q + 2**, or twice for one query. M13 answers every query exactly once, exactly
   two cycles later (SPEC-M13 §7), and can never refuse or defer one; the case is
   unreachable, no requirement names it, and DV SHALL assert nothing about it.

## 7. Timing contract

- **Latency. Two constants, and naming which is which is the requirement.** M15
  inserts twenty octets ahead of a payload that arrives word-aligned, so the delay
  to the word it **inserted** and the delay of an octet that **entered** are
  different quantities with different values (requirements.md §0.5's
  inserting-module clause and its output offset q). Both are pinned here; neither
  may be measured against the other's figure.

  | Quantity | Value | The two events it is measured between |
  |---|---|---|
  | **Event delay** | **1 cycle = 8 octet times** | the cycle on which `payload_tvalid` and `payload_tready` are both 1 for the frame's first payload word, and the cycle on which `eth_payload_tvalid` is 1 for **body word 0** |
  | L (octet times), §0.5 | **28** | the octet time of a payload octet at the `payload` port, and the octet time of that same octet on the `eth_payload` stream |
  | h (octet times) | **0** | — |
  | q (octet times), §0.5's output offset | **4** | the position of the datagram's first *input-derived* octet within the body word ΔC names; 20 mod 8 |
  | Word delay ΔC = (L + h − q)/8 | **3** cycles | the cycle of the payload word named by the measurement event, and the cycle of the first body word carrying an octet **of the frame** — **body word 2**, not body word 0 |

  **Why h = 0 and why ΔC counts to body word 2.** M15 removes nothing from the
  front, and the twenty octets it inserts entered on no input, have no input octet
  time and are not octets of the frame — so §0.5's front offset is 0 and its output
  event is the first body word carrying an octet of the frame. Body words 0 and 1
  carry none: §6.1 makes them IPv4 header octets 0–15, a function of the header
  build alone. The first body word carrying an octet that entered at the `payload`
  port is **body word 2**, at cycle C + 3, and its first such octet sits at byte
  position 4, which is q.

  **L = 28, derived, and constant at every octet, every length and every content.**
  Payload octet k is accepted in payload word ⌊k/8⌋ at cycle C + ⌊k/8⌋ at byte
  position k mod 8, so its input octet time is 8C + k. It leaves as body octet
  20 + k, in body word ⌊(20 + k)/8⌋ at byte position (20 + k) mod 8 (§6.1), and body
  word n leaves at C + 1 + n — so its output octet time is
  8·(C + 1 + ⌊(20 + k)/8⌋) + ((20 + k) mod 8) = 8C + 8 + 20 + k, and the difference
  is **28** for every k. By the identity, 8·3 − 0 + 4 = 28; and (L + h − q) = 24 is
  a multiple of 8, which is what §0.5 requires of every conformant module. Read
  without the output offset the identity returns 24 and contradicts the derivation
  — the term exists because M15's insertion is 20 and not a whole number of words.

  M15 is not a receive-path module: requirements.md §1.1 allocates it no ceiling
  and REQ-006's budget does not contain it, so REQ-019 has no instance here and
  neither figure is compared against anything. **No requirement constrains the
  value of either constant** — only that this specification states each, so that
  M09's grant cadence, M04's 11-cycle frame period and REQ-502's derivation
  compose against known figures. The event delay is 1 cycle because body word 0 is
  a function of the header alone and a registered output cannot do better; L moves
  with it by 8 octet times per cycle.

  Both are measured with `eth_payload_tready` held 1 throughout and the resolution
  already answered, exactly as SPEC-M07 §7 measures its own two constants. A
  downstream stall delays everything by the number of stalled cycles and is outside
  both constants' domain.

  **A bench SHALL NOT assert 8 octet times *per octet* at this port.** A conformant
  M15 delivers 28 at every payload octet of every datagram, so that assertion fails
  every conformant design. Where the per-octet latency is asserted at all it is
  asserted against **28**, and the tagger's domain is the **payload** octets only:
  the twenty IPv4 header octets entered on no input and have no input octet time.

- **What survives idle injection, and what does not** (§0.5). M15 **passes** the
  late-decision test — its input carries `tkeep`, `tlast` and `tuser`[0] in band,
  so the evidence word and the last-octet word name the same input word at every
  stimulus — and **fails** the straddle test: (h − q) = −4 ≢ 0 (mod 8), which is
  §6.1's own statement that body word n ≥ 3 is assembled from payload words n − 3
  and n − 2. **So L = 28 is a gapless constant only, and a monitor SHALL NOT demand
  a single per-octet L on an injected run at this module**: k idles injected
  between two payload words give one body word two latencies, 28 and 28 + 8k, and
  REQ-011 forbids resolving that by splitting the word. M07 carries the same
  verdict for the same structural reason (SPEC-M07 §7); a realignment straddles
  whichever direction it runs in.

  What is gap-invariant is the delay from each output event's **deciding input
  word** D, and that is what REQ-016's wrapper asserts here (§10). With
  J = ⌈P/8⌉ and W = ⌈(20 + P)/8⌉ as §6.1 defines them:

  | Output event | D — deciding input word | Delay from D |
  |---|---|---|
  | body word 0, and `eth_hdr_valid` with it | payload word 0 (the acceptance, which is also the header-build cycle) | 1 cycle |
  | body word 1 | payload word 0 | 2 cycles |
  | body word n, 2 ≤ n ≤ J + 1 | payload word n − 2 | 3 cycles |
  | body word J + 2 (exists iff W = J + 3) | payload word J − 1 | 4 cycles |

  D is payload word n − 2 and not n − 3 because §6.1 fixes a body word's `tkeep`,
  `tlast` and `tuser`[0] from the **later** of the two payload words it draws on,
  which is §6.1's residue rule (W − J = 2 for P ≡ 1, 2, 3 or 4 mod 8 and 3
  otherwise) seen from the deciding side. `arp_query_valid` at Q and
  `arp_response_valid` at Q + 2 are outside this table: neither is decided by a
  payload word at all, and the two resolution cycles are stated in their own bullet
  below.

- **Resolution wait.** **Exactly two cycles** of `payload_tready` = 0 at the head
  of every datagram, hit or miss, every destination class (§6.1). This is
  SPEC-M13 §7's Q + 2 seen from the asking side, and it is stated as a separate
  figure rather than folded into the latency above because the two have different
  domains: the latency is measured from an acceptance, and this is measured from
  the offer. From the offer at Q to the first body word is therefore **three**
  cycles on a hit.

- **Throughput.** One payload word accepted per cycle while `payload_tready` is
  1; one body word emitted per cycle while `eth_payload_tready` is 1. Over a
  frame M15 emits **two or three more** words than it consumes — W − J, which is
  the twenty header octets — so it costs the transmit path two or three cycles
  per frame that M04's inter-frame gap absorbs, plus the two resolution cycles at
  the head. `payload_tready` is 0 for the frame's last **W − J + 1 = three or
  four** cycles, one more than the word surplus (§6.1, the C-17(b) distinction).
  M15 never emits two words in one cycle and never accepts two.

  **REQ-610's no-buffering prohibition is structural here, not promised.** M15
  accepts exactly **one** payload word before its first body word leaves, at
  every payload length — which is the invariance criterion REQ-705 states for the
  application boundary, holding at this port too. A store-and-forward
  implementation would have to accept a length-dependent number of words first,
  and the invariance fails immediately at short lengths, which is why REQ-705
  prefers it to an ordering criterion.

- **Handshake rules.** A payload word is accepted on a cycle with
  `payload_tvalid` = 1 and `payload_tready` = 1; an accepted word is transmitted,
  or — in `Discard` — accepted and dropped, which is REQ-505's own instruction
  and the one case in this programme where "accepted" does not mean
  "transmitted". A body word is accepted on a cycle with
  `eth_payload_tvalid` = 1 and `eth_payload_tready` = 1; M15 holds
  `eth_payload_tvalid` and the word's contents stable until that happens.

  **ADR-0008's source obligations, restated as that ADR's Consequences require of
  every transmit-side source** (SPEC-M07 §11.2, SPEC-M09 §11.3 and SPEC-M11
  §11.2 all track this restatement, and it closes them):
  - **Decision 1** — M15 asserts `eth_hdr_valid` = 1 **and** body word 0's
    `eth_payload_tvalid` = 1 **on the same cycle**, never one before the other.
  - **Decision 2** — it holds both, with all three header fields and body word
    0's contents stable, until that word is accepted.
  - **Decision 4** — it never offers a header for a frame with no body word: a
    frame's body is at least the 20-octet IPv4 header plus the 8-octet UDP header
    (REQ-610), so the case is unreachable structurally rather than tolerated,
    exactly as it is at M11 (SPEC-M11 §6.1).
  - **Decision 3** is the consumer's half and M09 performs it (SPEC-M09 §6.1);
    M15 may drop `eth_hdr_valid` on the cycle after acceptance **and does**,
    which is a stronger commitment than the ADR requires of a source. Under
    ADR-0008's C-22 precedence clause that stronger commitment governs a monitor
    attached to *this* port, and such a monitor may assert the fall — while a
    monitor built from the ADR alone SHALL NOT.

  **On the input side the discipline is the same ADR's, one port up.**
  `hdr_valid` is a level M18 holds until M15 accepts the frame's first payload
  word; M15 captures nothing until that cycle. The `Ip_header` record's `valid`
  is therefore a **level here and a one-cycle pulse at M14** (SPEC-M14 §7,
  REQ-606) — the direction of a port decides which, and a monitor written for one
  and attached to the other reports a defect that is not there.

  **`arp_query` and `arp_response` have neither discipline and need none**:
  both are one-cycle pulses with no acceptance event, because M13 can never
  refuse a query (SPEC-M13 §7). ADR-0008 governs a header record travelling with
  a payload stream and neither of these is one. A monitor keys on the pulses,
  and on the invariant that exactly one response follows each query two cycles
  later.

  Idle gaps on the payload input (REQ-016) are tolerated: M15 does not advance and
  emits nothing that cycle. **Not "everything is delayed by the number of idle
  cycles"** — that is true only of the output events whose deciding input word the
  idles fall at or before, which is why the latency bullet's D table states the
  delay per event rather than one figure for the module (§0.5, *What survives idle
  injection*).

- **Reset.** While `clear` = 1 and on the first cycle after it returns to 0:
  `eth_payload_tvalid` = 0, `eth_hdr_valid` = 0, `payload_tready` = 0,
  `arp_query_valid` = 0, and the identification counter is 0 (REQ-608). `clear`
  asserted mid-frame abandons the frame with **no** `tlast` word — the frame
  simply stops, which is REQ-009's explicit permission and is the only silent
  frame loss in this specification; M09, M07 and M04 abandon the same frame on
  the same cycle (SPEC-M09 §7, SPEC-M07 §7, SPEC-M04 §7). A datagram offered on
  the first cycle after `clear` returns to 0 is transmitted correctly: its query
  is issued on that cycle, M18 holds the offer (ADR-0008), and the frame follows
  two cycles later.

- **Configuration sampling.** §4.3: all three inputs on the one cycle the header
  is built. A change landing on that cycle is unconstrained (§6.3 item 5).

## 8. Line-rate stress obligation

**Not applicable.** M15 is not in requirements.md §0.4's stress-bench list (M03,
M06, M08, M10, M14, M17, M20), which enumerates *receive-path* modules —
REQ-004's invariant is about surviving an arrival rate the module cannot slow
down, and M15 can slow its source down, by the two resolution cycles and the
three or four drain cycles §7 states.

Its equivalent obligations are five, stated so that no sign-off packet has to
invent them:

1. **REQ-608's header walk**: transmit three datagrams and decode every field of
   each against the table of §6.1 — version, IHL, DSCP, ECN, total length,
   identification, flags, fragment offset, TTL, protocol, source and destination
   — asserting the identification sequence **0, 1, 2**. Then repeat with a
   resolution failure between the second and third: the sequence is still
   0, 1, 2, because a discarded datagram consumes no value (§6.1).
2. **REQ-609's checksum, twice over**: against an **independently computed**
   one's-complement checksum (the DV software reference, not the design's own
   arithmetic), and by loopback through M14, asserting that the ten halfwords of
   the emitted header sum to 0xFFFF (REQ-602). The first is what makes the second
   more than a self-consistency check, which is REQ-202's argument for the FCS
   applied here.
3. **REQ-610's invariance**: transmit datagrams whose payload lengths cover every
   residue modulo 8 plus the 1480-octet maximum, and assert that the number of
   payload words accepted before the first body word leaves is **1** for every
   one of them, and that the drain is **W − J + 1** cycles — three or four, never
   two. Both figures are §7's and a bench that asserts the word surplus instead
   of the stall count fails every conformant design (C-17(b)).
4. **REQ-505's miss drain**: hold the ARP cache empty and transmit a datagram to
   an unresolvable destination; assert that no body word and no `eth_hdr_valid`
   appear, that `payload_tready` is **1** on every cycle from the response to the
   payload `tlast`, that exactly one `error_arp_miss` high cycle appears at
   M13's port on the response cycle, and that the next datagram — to a resolvable
   destination — transmits correctly with the **same** identification value the
   discarded one would have used.
5. **The composed transmit run**: M04's REQ-209 bench of 10 000 minimum-length
   frames driven **through** M09 and M07 from this module, asserting a mean of 11
   cycles per frame and no spacing other than 11. That run is what proves M15's
   resolution wait and drain fit inside M04's inter-frame gap rather than
   lengthening the frame period. The stimulus is REQ-708's datagram: total length
   46, an 8-octet UDP header and 18 octets of UDP payload, to a destination
   already in the ARP cache — because a run that missed would test REQ-505 rather
   than REQ-209.

## 9. Errors and discards

**Not applicable as a detection table.** M15 detects no abnormal condition and
raises no strobe.

| Condition | Strobe (one cycle) | Stream effect | REQ |
|---|---|---|---|
| (none raised here — the one discard M15 performs is reported by M13's `error_arp_miss`, see below) | — | — | — |

**M15 performs a discard it does not report, and that is deliberate and is not a
REQ-008 hole.** REQ-505 gives the miss **one** strobe, `error_arp_miss`, and
requirements.md §12 assigns it to **M13**, which is the module that detects the
condition — M15 is told the answer, it does not decide it. The two events are
tied on the cycle: M13 pulses `error_arp_miss` on the same cycle it drives
`tx_response_valid` with `found` = 0, which is the cycle M15 enters `Discard`
(§6.1, SPEC-M13 §9). So the pairing is one strobe per discarded datagram,
observable, and adding a second strobe here would report one event twice — which
§0.6 forbids for an inherited condition and which REQ-008 does not ask for.

**REQ-008 is not weakened by an empty table.** Every payload word M15 accepts is
either transmitted or accounted for by that strobe; a frame it has begun is
completed unless `clear` truncates it, which is REQ-009's permission and not a
silent discard. Frame conservation (requirements.md §0.6) at M15's ports is:

> datagrams offered = frames emitted + `error_arp_miss` pulses observed at M13
> during the same run,

which a monitor can compute with both modules in scope and which is the form the
conservation equation takes wherever a discard and its report sit in different
modules.

**Inherited aborts.** `payload_tuser`[0] on the payload's `tlast` word is copied
to the body's `tlast` word and nothing else happens (REQ-013, REQ-007). M15
pulses nothing for it — it has nothing to pulse — and it does not discard the
datagram: REQ-013 forbids dropping a frame solely for that bit, and unlike the
ARP branch this path has an ultimate consumer downstream of the wire rather than
inside the design (ADR-0009 names them per branch).

## 10. REQ coverage

| REQ | How this module satisfies it | Section | Verification hook for DV |
|---|---|---|---|
| REQ-001 | one clock; no gated or derived clock | §3 | the emitted-Verilog edge-expression check |
| REQ-007, REQ-013 | inherited `tuser`[0] copied to the body `tlast` word and never acted on | §9 | drive `tuser`[0] = 1 on a payload `tlast` word; assert the frame is transmitted unchanged with the bit set |
| REQ-008 | no strobe, and none is owed: M15's one discard is REQ-505's and is reported by M13 on the same cycle | §9 | none of its own — the pairing is asserted in §8 item 4 |
| REQ-009 | `clear` abandons the frame, holds every output low and returns the identification counter to 0 | §7 | reset test: assert mid-frame, deassert, offer a datagram on the next cycle and assert it transmits intact with identification 0 |
| REQ-010 | `Source` and `Dest` on both streams from the programme types; both header records are SPEC-M01's and both resolution records are SPEC-M13's, opened and not restated | §4.1 | interface compile check; the lift's witness that `Arp_query` and `Arp_response` are M13's types is the declare-once cross-check |
| REQ-011 | `eth_payload_tkeep` `0xFF` except on `tlast`; the payload's `tkeep` decides the body's last-word extent | §6.1 | protocol monitor on both streams |
| REQ-012 | every header field emitted first wire octet first; total length's and the addresses' octet order is what a hand-assembled reference pins | §6.1 | REQ-608's field-by-field decode |
| REQ-014 | `tstrb` ignored in, driven 0 out | §4.2 | protocol monitor; REQ-014's differential run |
| REQ-015 | one `tlast` per frame; at most 188 body words, the `tlast` word included | §3, §7 | protocol monitor |
| REQ-016 | payload idle cycles tolerated; M15 does not advance and emits nothing | §6.1, §7 | idle-injection wrapper at 0, 1 and 7 cycles on the payload stream, asserting **(a)** the body octet sequence is unchanged — the ordered (`tdata`, `tkeep`, `tlast`, `tuser`) tuples, each octet in its own byte position — and **(b)** each output event delayed by exactly the idle cycles injected at or before its deciding input word, against §7's D table. A bench **SHALL NOT** assert a single per-octet latency here: M15 fails §0.5's straddle test (§7), so that assertion fails every conformant design at k ≥ 1 |
| REQ-021 | body octet 0 at `eth_payload_tdata`[7:0]; the payload realignment is the inverse of M14's | §6.1 | payload lengths covering every residue modulo 8, asserting the octet string |
| REQ-207 | an accepted payload word is transmitted, or accepted and dropped under REQ-505; `payload_tready` is 0 when M15 cannot accept | §6.1, §7 | drive a continuous source; assert the transmitted octet sequence equals the accepted-word octet sequence exactly once, in order, and that the run of 0 cycles at each frame's end is **W − J + 1** — three or four, never two (C-17(b)) |
| REQ-208 | M15 has no receive-side port, so no path from here into the receive datapath exists; `arp_query` reaches M13's transmit logic only | §3 | inspection of the emitted netlist; REQ-208's top-level test |
| REQ-405 | **not** M15's: M15 emits a header *record*; the fourteen frame octets are M07's | §2 | none — stated so that no sign-off packet claims header-insertion coverage here |
| REQ-406 | no instance: M15 has one output port and requests by the ADR-0008 handshake | §2, §7 | none — stated so that no sign-off packet claims arbitration coverage here |
| REQ-505 (discard half) | on `found` = 0 nothing is emitted, every remaining payload word is accepted and dropped, and no datagram is ever buffered awaiting resolution | §6.1, §6.2, §9 | §8 item 4's miss drain. **The strobe and the ARP request are M13's** and are claimed there, not here |
| REQ-507 … REQ-509 | consumer side: M15 asks about the datagram's **destination** and uses whatever MAC comes back; it never evaluates a class | §4.2, §6.1 | none — stated so that no sign-off packet claims class-precedence coverage here. The class walk is SPEC-M13 §8 item 4 |
| REQ-608 | version 4, IHL 5, DSCP/ECN 0, flags 0, fragment offset 0, protocol 17 as constants; TTL from `cfg_ttl`; identification 0 after clear, +1 per **transmitted** datagram | §6.1 | §8 item 1's header walk, including the resolution-failure case that proves the counter tracks transmissions and not offers |
| REQ-609 | the one's-complement sum of the ten halfwords with the checksum field zeroed, complemented and emitted at octets 10–11 | §6.1 | §8 item 2: an independently computed checksum **and** the M14 loopback residue of 0xFFFF |
| REQ-610 (IPv4 half) | `hdr_total_length` emitted at octets 2–3 and used to size the body, with **no** payload buffering — one payload word accepted before the first body word leaves, at every length | §5, §6.1, §7 | §8 item 3's invariance test. **The "+ 28" arithmetic and the UDP length field are M18's** and are claimed there, not here (§5) |
| REQ-802, REQ-803 | three configuration inputs, all sampled on the one cycle the header is built, so a change can never land inside a header | §4.3 | change `cfg_ttl` between two datagrams and assert the second carries the new value and the first the old |
| REQ-810 | no instance: REQ-810's transmit half is M04's, and its ARP clause is M13's (SPEC-M13 §11.2). M15 reads no enable | §4.3 | none — stated so that no sign-off packet claims coverage here |
| REQ-901 | declared divergence class **(c)** is visible here: this module discards on a miss where the reference queues the datagram until resolution, so post-miss transmit behaviour is excluded from co-simulation | header, §2 | the co-simulation report names class (c) against this module and M13 |
| REQ-903, REQ-808 | `ip_eth_tx_64` is a distinct emitted module with `create`, `hierarchical` and an `.mli` | §4.1 | repository surface check and the `rtl_snapshots/` name comparison |

This table is the source of M15's rows in [`traceability.md`](../traceability.md),
updated in the same commit.

## 11. Deferred items

Item numbers are permanent; a closed item keeps its row (SPEC-TEMPLATE §11).

| # | Item | Status · what a reader assumes meanwhile | Tracked as | Owner | Closes by |
|---|---|---|---|---|---|
| 11.1 | **The `ifc_check` compile evidence for this lift is pending**: `ip_eth_tx_64_ifc.ml` is new in this commit and is the first lift to `open!` a lift from a **different batch** (`Arp_ifc`, SPEC-M13 §4.1). | **CLOSED (WO-0018/WO-0019).** CI `build` run **30739442056** at **3f6accc** reports `success` with this lift in it, and the run's head SHA **is** this specification's commit. The cross-batch `open!` compiled on its first attempt, which settles the declare-once rule's scalability question as well as this row: batch F then did it twice more (`Udp_ip_tx_64_ifc` opened by SPEC-M19 and SPEC-M20). | the `Interface compile check` row of §12 | architect_docs_lead, rtl_lead | closed |
| 11.2 | **The two-cycle resolution wait is charged to every datagram, including one whose destination is a broadcast address that needs no cache at all.** SPEC-M13 §7 answers every class at Q + 2 by design, so M15 pays two cycles even for the classes REQ-508 and REQ-509 resolve arithmetically. | **DEFERRED — the cost is decided, stated and benchable, and it is deliberately uniform.** A reader implements the two cycles unconditionally. The uniformity is what keeps M15's timing independent of the network configuration (SPEC-M13 §6.1's own argument), and the cost is absorbed by M04's inter-frame gap — §8 item 5's composed run is what demonstrates that rather than assuming it. If a later phase needs the cycles back, the repair is a spec diff to SPEC-M13 §7 and to this §7 **together**, because a class-dependent response would change both, and it would need an ADR for the same reason. | this item; SPEC-M13 §7 | architect_docs_lead | M15's `P1-module-ready` |
| 11.3 | **REQ-610 is owned in two halves by two modules** — the IPv4 total length here, the "+ 28" arithmetic and the UDP length field at M18 — and requirements.md states it as one requirement. | **CLOSED (WO-0019): the second side exists and the two halves tile.** SPEC-M18 §5 names its half — the application's payload length, the "+ 28" and "+ 8" arithmetic and the UDP length field — and disclaims this one in the same words this specification uses for it ("the IPv4 total length and the no-buffering property at this port are M15's and are claimed there, not here"), SPEC-M18 §10's REQ-610 row carries the disclaimer, and `traceability.md`'s REQ-610 row now names a written specification and a section on both sides with no `pending` cell. The check dv_lead set at WO-0018 answer (iv) — that it would not countersign batch F while REQ-610, REQ-807 or REQ-505 stayed one-sided — is what this closure is written against. | `traceability.md` REQ-610; SPEC-M18 §5, §10; SPEC-M12 §11.3's pattern | architect_docs_lead, dv_lead | closed |
| 11.4 | **M15 discards a datagram that M13 reports**, so REQ-008's "every discard is observable" is satisfied across a module boundary rather than inside one, and §9's conservation equation needs both modules in scope. | **DEFERRED — the pairing is stated, cycle-exact and assertable today.** Meanwhile a bench monitors `error_arp_miss` at M13's port and the absence of a frame at M15's, on the same cycle, and §8 item 4 commissions exactly that. This is the first place in Phase 1 where the two halves of REQ-008 sit in different modules; if the auditor's DV-escape ledger or a sign-off packet needs the equation stated once for the programme rather than per module, the repair is a clause in requirements.md §0.6 and not a strobe here — a second strobe would report one event twice. | this item; requirements.md §0.6 | architect_docs_lead, dv_lead | M15's first `SO-` packet |

## 12. Freeze record

Filled in at `P1-spec-freeze`. All four rows are required (charter §5).

| Item | Value |
|---|---|
| Interface compile check | CI `build` run **30739442056**, conclusion **`success`**, SHA **3f6accc** — every lift in the single `ifc_check` library elaborates, this one being the first to `open!` a lift from a different batch (`Arp_ifc`); per ADR-0005 a local build is not acceptable evidence. **The run's head SHA is the specification commit**, so no witnessing argument is owed. This run is also §11.1's closure record |
| Architect signature | `J-architect_docs_lead-0007` |
| dv_lead testability countersignature | **`J-dv_lead-0009`** (WO-0018) — batch E **COUNTERSIGNED at 3f6accc**, this specification **SIGNED**: the 0xF6B4 checksum recomputed halfword by halfword, the 0xFFFF loopback residue confirmed, W − J evaluated for every payload length 1 … 39 against its stated mod-8 classes with no exception, the stall count W − J + 1 = 3 or 4 confirmed term by term, and the 1-cycle latency and 2-cycle resolution wait each checked against their two named events |
| Frozen at | SHA **3f6accc**, gate `docs/gates/P1-spec-freeze-checklist.md` |

## 13. Change log

Post-freeze changes only. Each row cites the ADR that authorised it, or states
why none is owed; a breaking interface change is counted against post-freeze
churn (charter §6). **No row below is breaking**: §4.1's records are
byte-for-byte unchanged since the freeze SHA, so the `ifc_check` evidence of §12
still witnesses this revision's interface. *(The preamble this replaces read
"This spec is DRAFT and has none", which was already false against §12 and this
file's own header — SPEC-M15 has been **FROZEN** at `3f6accc` since batch E. It
is corrected in the diff that gives this table its first row.)*

| Date | Change | Breaking? | ADR | Journal |
|---|---|---|---|---|
| 2026-08-11 | **The `C-RL-8` class at its second site — §7 pinned an event delay and printed it as a latency, in the same words SPEC-M07 §7 used, at a 20-octet insertion.** §7's latency bullet read *"Pinned at **1 cycle**: the frame's first body word is emitted on the cycle after M15 accepts the frame's first payload word … Both sit at octet position 0 of their words, so the figure is exactly 8 octet times and not a rounding"* — and that closing sentence is the one requirements.md §0.5 uses to explain why a delay pinned to an **inserted** word is an event delay and *not* a latency. Body words 0 and 1 carry no octet that entered at any port (§6.1: *"body word 0 and body word 1 are header only"*), so the figure was the event delay throughout. §7 now carries a five-row table: the **event delay** of 1 cycle (8 octet times) to body word 0, unchanged in value; **L = 28** octet times per payload octet, derived from §6.1's own mapping; **h = 0**; §0.5's new **output offset q = 4**; and **ΔC = 3** counted to **body word 2**, the first body word carrying an octet of the frame. §7 gains a second bullet with the two §0.5 verdicts — M15 **passes** the late-decision test (framing in band) and **fails** the straddle test, (h − q) = −4 ≢ 0 (mod 8), which is §6.1's own *"assembled from payload words n − 3 and n − 2"* — so L = 28 is gapless-only, plus a table of each output event's **deciding input word** D and its gap-invariant delay (1, 2, 3, 4 cycles), with `arp_query_valid` and `arp_response_valid` excluded by name because no payload word decides them. Three dependent sites repaired in the same diff: §7's handshake bullet, whose *"delay everything by the number of idle cycles"* is true only of events whose D the idles precede; §3's REQ-005 row; and §10's REQ-016 hook, which named no assertion at all and now names both halves of REQ-016's verification column and the prohibition. This table's stale DRAFT preamble is corrected with them. **This site was named by rtl_lead as a measured adjacency, not derived** (`J-rtl_lead-0020` §5: *"I name M15 as an adjacency read from its §7 and §6.1 rather than as a finding I have derived end to end"*); the end-to-end derivation above is the architect's and is the half rtl_lead declined to claim | no — **editorial by requirements.md §13's own test.** No port, record, state, cycle, cycle-table row, residue class, drain count, checksum, identification rule, strobe or resolution figure moves: §6.1's C + 1 + n, the two-cycle resolution wait, W − J + 1 = three or four, and §4.1's records are untouched. M15 has **no RTL** — `libs/hardcaml_ethernet/src/ip_eth_tx_64.ml` does not exist — and no committed test names `ip_eth_tx`, so nothing built to the old sentence exists in either line. The event delay dv_lead re-derived and signed at `J-dv_lead-0009` is the same number, so §12's countersignature record is a true record of that act and is not edited | none — the reading removed is arithmetically unsatisfiable rather than rejected among live alternatives; the alternative that *was* live is §0.5's (a term versus a scope) and is recorded and refused in requirements.md §13's row of the same date | `J-architect_docs_lead-0041` |
