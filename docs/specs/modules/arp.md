# SPEC-M13 — `Arp`

- **Status**: DRAFT — batch D. Template-complete; the two evidence rows of §12
  are what the freeze flip waits on
- **Inventory id**: M13 (architecture.md §4) · **Path**:
  `libs/hardcaml_ethernet/src/arp.ml`
- **Datapath role**: shared/structural — a wrapper over M10, M11 and M12 that
  also carries logic of its own. Receive-path module **with respect to its
  `rx_hdr` and `rx_payload` ports only** (requirements.md §0.4), which are pure
  relays into M10
- **Owns REQs**: REQ-502 (the decision half), REQ-503, REQ-505, REQ-506 (the
  retry half), REQ-507, REQ-508, REQ-509, REQ-510, REQ-511, REQ-512
- **Prior-art counterpart**: `arp.v` (MIT) — consulted for decomposition and
  port naming only; behaviour below is stated independently and no source was
  copied. Two declared REQ-901 divergence classes live here: **(b)**
  direct-mapped cache versus the reference's LRU, and **(c)** discard-on-miss
  versus the reference's queued resolution
- **Depends on specs**: SPEC-M01 (`Axi64`, `Eth_header`), SPEC-M10
  (`Arp_eth_rx`, which declares `Arp_packet`), SPEC-M11 (`Arp_eth_tx`),
  SPEC-M12 (`Arp_cache`, which declares the three cache records), SPEC-M08
  (`Eth_demux`, its receive producer), SPEC-M09 (`Eth_arb_mux`, its transmit
  consumer), ADR-0008
- **Author**: architect_docs_lead, journal `J-architect_docs_lead-0006`

## 1. Purpose

M13 is the ARP resolver: the module that decides. It contains M10 (parse), M11
(build) and M12 (remember), relays the receive stream into M10 and M11's frame
out to M09, and holds the only state in the ARP family that is neither a table
nor a packet — whether a reply is pending, and whether a resolution is
outstanding. Everything a reader might call "the ARP protocol" is here:
answering a request for our address (REQ-502), learning from every accepted
packet (REQ-503), resolving a transmit-side destination through the class
precedence of REQ-507, discarding on a miss and requesting (REQ-505), retrying
(REQ-506) and dropping a reply rather than stalling (REQ-510).

Its receive upstream is M08 `Eth_demux`; its transmit downstream is M09
`Eth_arb_mux`; its control counterpart is M15 `Ip_eth_tx_64` (batch E), which
asks it to resolve a destination. It instantiates M10, M11 and M12 and nothing
else.

## 2. Scope

**In scope.**

- Relaying `rx_hdr` and `rx_payload` into M10 unchanged and at zero cycles' cost
  (§7), and relaying M11's frame out on `tx_hdr` and `tx_payload` with
  `tx_payload_dest` back, likewise.
- **Learning** (REQ-503): writing the sender protocol and hardware addresses of
  every accepted packet into M12, addressed to us or not.
- **Replying** (REQ-502, REQ-511, REQ-512): generating exactly one reply for an
  accepted request whose target protocol address equals `cfg_local_ip`, and none
  otherwise.
- **Resolving** (REQ-507 … REQ-509): evaluating a transmit-side query's
  destination class in the fixed order REQ-507 states, answering broadcast,
  subnet-broadcast and multicast arithmetically without consulting the cache,
  and resolving on-subnet and off-subnet destinations through M12.
- **Requesting and retrying** (REQ-505, REQ-506): broadcasting a request on a
  miss, suppressing duplicates while a resolution for the same target is
  outstanding, retrying at the configured interval up to the configured count
  and then abandoning without negatively caching.
- **Dropping a reply rather than stalling** (REQ-510), which is the only
  discard of a reply in this programme and is reachable by construction.
- Relaying M10's `error_arp_unsupported` and raising its own two strobes (§9).

**Not this module's job.**

| Behaviour a reader might expect here | Owner |
|---|---|
| Reading ARP octets out of a payload stream, or checking REQ-501's six criteria | M10 `Arp_eth_rx`. M13 sees a record whose `valid` = 1 is already a REQ-501 acceptance (SPEC-M10 §4.1) and re-checks nothing |
| Writing ARP octets onto a payload stream, or choosing the frame's destination MAC | M11 `Arp_eth_tx` (§6.1 there). M13 fills five fields and lets M11 derive the Ethernet header from them |
| The index function, the eviction rule, the entry lifetime | M12 `Arp_cache` (REQ-504, REQ-506's ageing half). M13 asks about one address and is answered about that address |
| Buffering a datagram until its destination resolves | **nobody** — architecture.md §2.5 and REQ-505 forbid it. The datagram is discarded and the application is told by `found` = 0 and `error_arp_miss` |
| Deciding whether the IPv4 destination is acceptable, or filtering | M14 `Ip_eth_rx_64` (REQ-604). M13's destination classes are about *how to reach* an address, never about whether to accept one |
| Arbitrating M13's frame against the IPv4 transmit frame | M09 `Eth_arb_mux` (REQ-406). M13 requests by the ADR-0008 handshake M11 performs and is granted by having its first payload word accepted |
| Holding `tready` low at the application when transmit is disabled | M04 and M18 (REQ-810). M13 has no `cfg_tx_enable` port; §11.2 records what REQ-810's ARP clause then means here |

## 3. Programme invariants that bind this module

M13 is a receive-path module **with respect to `rx_hdr` and `rx_payload` only**
(requirements.md §0.4's structural-module rule); its transmit ports, its query
port and its cache edges are not receive-path ports.

| REQ | Consequence for M13 |
|---|---|
| REQ-001 | One `clock`, shared by every child. |
| REQ-002 | `rx_payload` and `tx_payload` are 64-bit `Axi64` streams, at most one word per cycle each. |
| REQ-003 | The receive relay carries **no** `tready` in either direction — `rx_payload` is `Axi64.Source` with no matching `Dest` anywhere in §4.1 — so nothing M13 does can stall M08, and M10 cannot stall M13. This is the structural fact REQ-510 rests on: when a reply cannot be sent, the only thing M13 can drop is the reply. |
| REQ-004 | M13 is not on §0.4's stress-bench list; M10 is, and M13's relay is what makes M10's bench a bench of this branch (§8). The relay adds no logic and no cycle, so M10's stimulus at M13's ports **is** M10's stimulus. |
| REQ-005 | Binds the relay, trivially and exactly: a combinational relay has L = 0 and h = 0 at every octet, so M10's constants are the same measured at M13's ports as at M10's own (§7). |
| REQ-007, REQ-013 | `rx_payload`'s `tuser`[0] is relayed to M10 unchanged and acted on by neither (SPEC-M10 §7, §11.3). `tx_payload`'s `tuser` is M11's, driven to 0 (SPEC-M11 §4.2). M13 originates and re-reports no abort. |
| REQ-008 | M13 owns two strobes (`error_arp_miss`, `error_arp_reply_dropped`) and relays a third (`error_arp_unsupported`, M10's). §9 states which discards each reports and pins both pulse cycles. |
| REQ-009 | Synchronous `clear`: every child is cleared, the cache is emptied (SPEC-M12 §7), any pending reply and any outstanding resolution are abandoned, and all three strobe outputs are 0 while `clear` = 1 and on the first cycle after (§7). |
| REQ-010 | Both streams are the programme `Axi64` types; both header records are SPEC-M01's `Eth_header`. `Arp_query` and `Arp_response` are declared here (§4.1); `Arp_packet` is SPEC-M10's and the three cache records are SPEC-M12's, opened and not restated. |
| REQ-011, REQ-012, REQ-014, REQ-015, REQ-016, REQ-021 | Bind the relayed streams and are satisfied by relaying: M13 changes no `tkeep`, no octet order, no `tstrb`, no `tlast` and no alignment, and it inserts no idle cycle. Every one of them is M10's, M11's or M08's property seen through a wire. REQ-012's byte order does bind M13's own field arithmetic, and §6.1 states it wherever an address is compared or constructed. |
| REQ-017, REQ-018 | No instance: M13 sees nothing at or below XGMII. |
| REQ-019 | The relay's ΔC is 0, so M13 adds nothing to REQ-006's budget and §1.1 allocates it nothing — and it could not, because this branch is not the chain REQ-006 measures (requirements.md §1.1's closing paragraph). M13 buffers **no** frame: REQ-505's discard-without-buffering is the whole architecture of the transmit side (architecture.md §2.5). |
| REQ-020 | Packets are learned in arrival order, replies are generated in arrival order, and M11 emits in offer order. The one place order is *not* preserved is deliberate and stated: a reply overtakes a waiting request at the M11 port (§6.1), because a reply has REQ-502's deadline and a request has a retry interval. |

## 4. Interface

### 4.1 Interface records

```ocaml
(* SPEC-M13 §4.1, lifted verbatim into docs/specs/ifc_check/arp_ifc.ml
   (SPEC-TEMPLATE.md rule 6). Records and signatures only — no logic, no
   implementation.

   [Axi64_ifc] is M01's types home. [Arp_eth_rx_ifc] declares
   [Arp_packet] (SPEC-M10 §4.1) and [Arp_cache_ifc] declares the three
   cache records (SPEC-M12 §4.1); M01 is FROZEN at f78766e, so batch D
   declares each new record once at the module that owns it and opens it
   everywhere else (SPEC-M10 §11.2). M13 restates none of them.

   [Arp_query] and [Arp_response] are declared HERE because M13 is what
   answers them: they are the M15 -> M13 -> M15 resolution interface of
   architecture.md §6.4.3, and M15 (batch E) will open this module.

   [Arp_query] has the same SHAPE as [Arp_cache_query] and is a
   different type on purpose. Its [ip] is the datagram's DESTINATION,
   which M13 has not yet classified; [Arp_cache_query]'s [ip] is the
   RESOLUTION TARGET, which is the destination for an on-subnet
   datagram and the gateway for an off-subnet one (REQ-507). Merging
   them would let a future edit connect M15 straight to M12 and skip the
   class evaluation, which is the one thing REQ-507 exists to prevent.

   Receive ports: [rx_payload] is [Axi64.Source] with no [Axi64.Dest]
   anywhere for it, which is REQ-003 structurally and is what REQ-510
   rests on. Transmit ports: [Source] out and [Dest] in on the one
   transmit stream. [tx_hdr] carries no [ready] (ADR-0008). *)

open! Base
open Hardcaml
open! Axi64_ifc
open! Arp_eth_rx_ifc
open! Arp_cache_ifc

module Arp_query = struct
  type 'a t =
    { valid : 'a
    ; ip : 'a [@bits 32]
    }
  [@@deriving hardcaml]
end

module Arp_response = struct
  type 'a t =
    { valid : 'a
    ; found : 'a
    ; mac : 'a [@bits 48]
    }
  [@@deriving hardcaml]
end

module I = struct
  type 'a t =
    { clock : 'a
    ; clear : 'a
    ; rx_hdr : 'a Eth_header.t [@rtlprefix "rx_hdr_"]
    ; rx_payload : 'a Axi64.Source.t [@rtlprefix "rx_payload_"]
    ; tx_payload_dest : 'a Axi64.Dest.t [@rtlprefix "tx_payload_"]
    ; tx_query : 'a Arp_query.t [@rtlprefix "tx_query_"]
    ; cfg_local_mac : 'a [@bits 48]
    ; cfg_local_ip : 'a [@bits 32]
    ; cfg_subnet_mask : 'a [@bits 32]
    ; cfg_gateway_ip : 'a [@bits 32]
    }
  [@@deriving hardcaml]
end

module O = struct
  type 'a t =
    { tx_hdr : 'a Eth_header.t [@rtlprefix "tx_hdr_"]
    ; tx_payload : 'a Axi64.Source.t [@rtlprefix "tx_payload_"]
    ; tx_response : 'a Arp_response.t [@rtlprefix "tx_response_"]
    ; error_arp_unsupported : 'a
    ; error_arp_miss : 'a
    ; error_arp_reply_dropped : 'a
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

(* REQ-010 type identity on both streams, and a compile-time witness of
   the records on M13's INTERNAL edges (architecture.md §6.4): M10's
   [Arp_packet] on [arp_rx] and [arp_tx], and M12's three records on
   [cache_query], [cache_result] and [cache_write]. Those are signals
   inside M13's hierarchy, not ports, so they appear in neither [I] nor
   [O]; this is what ties the internal vocabulary to the specifications
   that declare it. *)

let _witness_both_directions
      (s : Signal.t Axi64.Source.t)
      (d : Signal.t Axi64.Dest.t)
  =
  s, d
;;

let _witness_internal_edge_types
      (p : Signal.t Arp_packet.t)
      (q : Signal.t Arp_cache_query.t)
      (r : Signal.t Arp_cache_result.t)
      (w : Signal.t Arp_cache_write.t)
  =
  p, q, r, w
;;
```

Conformance of this block to the template's rules for §4.1:

- Scalar fields carry `[@bits n]` unless one bit wide: `clock`, `clear` and the
  three strobes are one bit; the four `cfg_` inputs and every nested record
  field carry their widths.
- Nested interfaces carry `[@rtlprefix]`, so the emitted names are
  `rx_hdr_valid` …, `rx_payload_tvalid` …, `tx_payload_tready`,
  `tx_query_valid`, `tx_query_ip`, `tx_hdr_valid` …, `tx_payload_tvalid` …,
  `tx_response_valid`, `tx_response_found`, `tx_response_mac`. The four
  configuration inputs are scalars named exactly as architecture.md §6.4.3
  names them.
- **Receive-path `Source` without `Dest`: held** for `rx_payload`. The one
  `Axi64.Dest` in these records is `tx_payload_dest`, which belongs to the
  transmit stream; a reader can tell them apart by the prefix, and REQ-003's
  structural check — a receive-path port exposes `Source` with no matching
  `Dest` — passes on the `rx_` pair.
- Both `create` and `hierarchical` are declared (REQ-903, REQ-808), each taking
  the three REQ-506 parameters of §5.

### 4.2 Port table

Every port in §4.1 appears exactly once. Direction is with respect to M13.

| Port | Dir | Width | Meaning | REQ |
|---|---|---|---|---|
| `clock` | in | 1 | 156.25 MHz single domain | REQ-001 |
| `clear` | in | 1 | synchronous clear; empties the cache and abandons every pending item | REQ-009 |
| `rx_hdr_valid` | in | 1 | M08's ARP-port header pulse; relayed to M10 | REQ-401, REQ-404 |
| `rx_hdr_dst_mac`, `rx_hdr_src_mac`, `rx_hdr_ethertype` | in | 48, 48, 16 | relayed to M10 and read by neither module (SPEC-M10 §4.2) | REQ-407 |
| `rx_payload_tvalid` … `rx_payload_tuser` | in | 1, 64, 8, 8, 1, 1 | M08's ARP-port payload stream; relayed to M10 unchanged | REQ-011 … REQ-016 |
| `tx_query_valid` | in | 1 | a transmit-side resolution is asked this cycle; M13 always accepts it | REQ-507 |
| `tx_query_ip` | in | 32 | the datagram's **destination** IPv4 address, numeric with the first wire octet most significant. Not the resolution target — M13 computes that (§6.1) | REQ-507, REQ-012 |
| `tx_payload_tready` | in | 1 | M09 accepts a payload word this cycle; relayed to M11 | REQ-207 |
| `cfg_local_mac` | in | 48 | the configured local MAC; the sender hardware address of every packet M13 generates | REQ-502, REQ-802 |
| `cfg_local_ip` | in | 32 | the configured local IPv4 address; the reply predicate and the sender protocol address | REQ-502, REQ-507, REQ-802 |
| `cfg_subnet_mask` | in | 32 | contiguous prefix mask; decides the subnet-broadcast address and the on-subnet test | REQ-507, REQ-508, REQ-802 |
| `cfg_gateway_ip` | in | 32 | the resolution target for an off-subnet destination | REQ-507, REQ-802 |
| `tx_hdr_valid` … `tx_hdr_ethertype` | out | 1, 48, 48, 16 | M11's Ethernet header record, relayed to M09; held until the first payload word is accepted (ADR-0008) | REQ-405, ADR-0008 |
| `tx_payload_tvalid` … `tx_payload_tuser` | out | 1, 64, 8, 8, 1, 1 | M11's 28-octet ARP payload, relayed to M09 | REQ-011 … REQ-015 |
| `tx_response_valid` | out | 1 | one cycle high per query, exactly two cycles after it (§7) | REQ-507 |
| `tx_response_found` | out | 1 | on that cycle: 1 if the destination resolved, 0 if it missed. Meaningful only then | REQ-505, REQ-507 |
| `tx_response_mac` | out | 48 | on `found` = 1, the MAC to send the datagram to. Meaningful only on a `tx_response_valid` cycle with `found` = 1 | REQ-507 … REQ-509 |
| `error_arp_unsupported` | out | 1 | **relayed** from M10 unchanged; M13 never asserts it of its own accord | REQ-501 |
| `error_arp_miss` | out | 1 | one-cycle strobe: a resolution found no live cache entry | REQ-505 |
| `error_arp_reply_dropped` | out | 1 | one-cycle strobe: a reply was generated while one was already pending | REQ-510 |

### 4.3 Configuration inputs

M13 reads **four** fields of the `Config` record (requirements.md §9.1), as
scalars, exactly as architecture.md §6.4.3 routes them.

| Field | Effect | When a change takes effect (REQ-803) |
|---|---|---|
| `cfg_local_mac` | the sender hardware address of every packet M13 generates (REQ-502) | sampled when a packet is generated — the cycle after the `arp_rx` pulse for a reply, and the cycle a request is generated. A change landing at least one cycle before that sampling event applies; a change landing on the sampling cycle itself is deliberately unconstrained (§6.3 item 5) |
| `cfg_local_ip` | the reply predicate `target_ip = cfg_local_ip` (REQ-502, REQ-511, REQ-512); the sender protocol address; the on-subnet and subnet-broadcast comparisons (REQ-507, REQ-508) | the reply predicate is sampled on the `arp_rx` pulse; the class comparisons on the `tx_query_valid` cycle. Same one-cycle rule |
| `cfg_subnet_mask` | the subnet-broadcast address `cfg_local_ip \| ~cfg_subnet_mask` (REQ-508) and the on-subnet test (REQ-507) | sampled on the `tx_query_valid` cycle. Same one-cycle rule |
| `cfg_gateway_ip` | the resolution target for an off-subnet destination (REQ-507) | sampled on the `tx_query_valid` cycle. Same one-cycle rule |

REQ-803's receive/transmit independence is satisfied structurally here: the
reply predicate is sampled on a receive-side event and the class comparisons on
a transmit-side one, and no frame is in flight across both.

## 5. Parameters

| Parameter | Type | Default | Range | Why a test overrides it |
|---|---|---|---|---|
| `retry_count` | `int` | **4** | 0 to 15 | REQ-506 requires it. `retry_count` = n means one initial request and up to **n** retries, so at most **n + 1** requests appear on the wire per resolution (§6.1). The retry test counts them |
| `retry_interval_cycles` | `int` | **156 250 000** (1.0 s at 156.25 MHz) | 1 to 2^32 − 1 | REQ-506 requires it: a bench cannot simulate four seconds. §8's retry run uses 16 |
| `entry_lifetime_cycles` | `int` | **3 125 000 000** (20 s) | 1 to 2^32 − 1 | REQ-506 requires it; M13 forwards it to its M12 instance and reads it for nothing itself (SPEC-M12 §5) |

**REQ-506 is owned in two halves.** The two above that concern unanswered
*requests* are M13's; the entry lifetime is M12's and M13 only passes it
through. Both specifications say so and `traceability.md`'s REQ-506 row lists
both modules, so a sign-off packet can show the whole requirement covered
without either module claiming the other's part (SPEC-M12 §11.3).

**Nothing else is a parameter.** The sixteen cache entries (REQ-504), the
28-octet packet (REQ-501) and the destination-class boundaries — 255.255.255.255,
224.0.0.0/4 — are fixed by requirements and by RFC 826 and RFC 1112, and making
any of them overridable would let a test configure a protocol the programme does
not have.

## 6. Behaviour

### 6.1 Normal path

M13 reads no octet offset: it sees M10's decoded record and fills M11's. The
five fields of an `Arp_packet` and their meanings are SPEC-M10 §6.1's table,
and this section never repeats an offset.

**Address arithmetic, stated once.** Every IPv4 address here is a 32-bit numeric
value whose **first wire octet is most significant** (REQ-012), so
192.168.1.10 is 0xC0A8010A. Every MAC is 48 bits, first wire octet most
significant.

---

#### The receive side

**Relay.** `rx_hdr` and `rx_payload` are presented to M10 **combinationally and
unchanged**: no register, no cycle, no re-encoding (§7). M10's constants
therefore hold measured at M13's ports.

**Learning (REQ-503).** On every cycle M10 pulses `arp_valid`, M13 presents a
cache write on the **next** cycle, with `write_ip` = `arp_sender_ip` and
`write_mac` = `arp_sender_mac`. This is unconditional — "whether or not the
packet is addressed to us" is REQ-503's own clause — and it applies to a reply
exactly as to a request, and to a gratuitous ARP exactly as to either. Nothing
about the Ethernet header is learned; the ARP fields are the source of truth,
which is why M10 does not read `rx_hdr_src_mac` (SPEC-M10 §4.2).

**Replying (REQ-502).** On the same cycle as the learning write, M13 generates a
reply **iff**

> `arp_operation` = 1 **and** `arp_target_ip` = `cfg_local_ip`,

with these fields:

| `Arp_packet` field offered to M11 | Value |
|---|---|
| `operation` | **2** |
| `sender_mac` | `cfg_local_mac` |
| `sender_ip` | `cfg_local_ip` |
| `target_mac` | the request's `sender_mac` — RFC 826's rule, and REQ-502's "target hardware address is the request's sender hardware address" |
| `target_ip` | the request's `sender_ip` |

M11 then makes the frame unicast to `target_mac` (SPEC-M11 §6.1), which is
REQ-502's "unicast to the requester's hardware address".

**REQ-511 and REQ-512 need no rule of their own, and that is worth stating.** A
gratuitous ARP is operation 1 with target protocol address equal to sender
protocol address; the predicate above fires exactly when that address is
`cfg_local_ip`, which is REQ-511's condition word for word, and the learning
half is REQ-503's, which applies to every accepted packet including this one.
REQ-512 is the same predicate read in the negative: a request for any other
address fails it and no reply is generated, while REQ-503 still learns. **M13
therefore contains no `gratuitous` predicate and no `proxy` predicate**, and a
bench SHALL NOT look for one — it asserts REQ-511 and REQ-512 by driving the
packets and observing the reply or its absence, which is what their verification
columns already say.

**An accepted reply ends a matching resolution.** If the accepted packet's
`sender_ip` equals the outstanding resolution's target (below), the resolution
**ends** on the same cycle as the learning write: the outstanding register is
cleared and no further retry is issued. This is what "unanswered requests SHALL
be retried" means read forwards, and it holds whether the answer arrived as a
reply (operation 2) or as any other accepted packet from that address — the
cache entry is what the resolution wanted, and REQ-503 has just created it.

---

#### The transmit side

**Destination classes (REQ-507), evaluated in this order, first match wins.**
`d` is `tx_query_ip`, `l` is `cfg_local_ip`, `m` is `cfg_subnet_mask`, `g` is
`cfg_gateway_ip`.

| # | Class | Test | Answer | Cache consulted? | Request possible? |
|---|---|---|---|---|---|
| 1 | limited broadcast (REQ-508) | `d` = 0xFFFFFFFF | MAC `ff:ff:ff:ff:ff:ff`, `found` = 1 | **no** | no |
| 2 | subnet broadcast (REQ-508) | `d` = `l` \| ~`m` | MAC `ff:ff:ff:ff:ff:ff`, `found` = 1 | **no** | no |
| 3 | multicast (REQ-509) | `d`[31:28] = 0b1110, that is 224.0.0.0/4 | MAC below, `found` = 1 | **no** | no |
| 4 | on-subnet | (`d` & `m`) = (`l` & `m`) | resolution target **`d`**, resolved through M12 | yes | yes |
| 5 | off-subnet | anything else | resolution target **`g`**, resolved through M12 | yes | yes |

The order is normative and is REQ-507's own. It is what makes 255.255.255.255
class 1 rather than class 5 when the mask is 0, and a multicast address class 3
rather than class 4 or 5 whether or not it happens to lie inside the configured
subnet — the two cases REQ-507's verification column names.

**The multicast MAC (REQ-509), stated as bits.** For a class-3 destination `d`:

> `mac`[47:24] = 0x01005E · `mac`[23] = **0** · `mac`[22:0] = `d`[22:0]

Worked: 239.1.2.3 = 0xEF010203 gives `d`[22:0] = 0x010203 and
`mac` = 01:00:5E:01:02:03. 239.129.2.3 = 0xEF810203 has bit 23 set and gives the
**same** MAC, because bit 23 is discarded — which is the case REQ-509's
verification column says "actually exercises the 23-bit mask".

**Resolving through the cache (classes 4 and 5).** On the cycle a query with
`tx_query_valid` = 1 arrives, M13 evaluates the class combinationally and, for
classes 4 and 5 only, presents `cache_query` to M12 on that same cycle with
`ip` = the resolution target. M12 answers on the next cycle (SPEC-M12 §7), and
M13 registers the answer, so:

> **`tx_response_valid` pulses on cycle Q + 2 for every query, in every class.**

For classes 1 to 3 no cache query is issued at all — `cache_query.valid` = 0,
which is REQ-508's and REQ-509's "without consulting the cache" made
**observable** at M12's port and therefore assertable — and the response is
computed at Q and delayed to Q + 2 so that the constant holds. *A uniform
constant is deliberate*: M15 (batch E) must not have to know which class its
destination fell into, and a class-dependent delay would make its own timing a
function of the network configuration. It is the same reasoning SPEC-M06 §6.1
gives for not emitting a short frame's payload word early.

**A miss (REQ-505).** If the class is 4 or 5 and M12 answers `hit` = 0, then on
cycle Q + 2:

1. `tx_response_valid` = 1 with **`found` = 0**;
2. `error_arp_miss` pulses for exactly one cycle;
3. a request for the resolution target is issued, **unless** a resolution for
   that same target is already outstanding, in which case no request is issued
   and steps 1 and 2 still happen.

M15 discards the datagram without buffering and continues to accept and discard
its remaining payload words, so a resolution failure never stalls the
application — REQ-505's own sentence, and an obligation on M15 rather than on
M13, restated here because a reader of this specification needs to know why M13
does nothing further.

**A request (REQ-505).** The `Arp_packet` M13 offers M11 for a request is:

| Field | Value |
|---|---|
| `operation` | **1** |
| `sender_mac` | `cfg_local_mac` |
| `sender_ip` | `cfg_local_ip` |
| `target_mac` | **`00:00:00:00:00:00`** — RFC 826 leaves a request's target hardware address unused, and M11 keys the broadcast Ethernet destination off `operation` = 1 rather than off this field (SPEC-M11 §6.1) |
| `target_ip` | the resolution target — the destination for class 4, the **gateway** for class 5, which is REQ-507's off-subnet clause |

**The outstanding resolution, and what ends it** (the closure list REQ-505's
duplicate-suppression clause refers to, in the form SPEC-M03 §9 uses for an open
frame). M13 tracks **one** outstanding resolution: a target address, a retry
counter and an interval counter. A resolution is outstanding from the cycle its
first request is generated until the earliest of:

- an accepted ARP packet whose `sender_ip` equals the target (the answer);
- the retry counter reaching `retry_count` and the interval expiring again
  (abandonment — REQ-506's "the resolution is abandoned and nothing is
  negatively cached");
- a miss for a **different** target, which replaces it (below);
- `clear` (REQ-009).

While a resolution for target t is outstanding, a further miss for t discards
and pulses `error_arp_miss` **without** issuing an additional request — REQ-505
word for word, and the property its 100-datagram test asserts.

**A miss for a different target replaces the outstanding resolution.** REQ-505
constrains only the same-target case, so this specification decides the other
one: the previous resolution is abandoned, the new target becomes outstanding
with its retry counter at 0, and a request for it is generated. Abandonment
costs nothing, because REQ-506 states that nothing is negatively cached and a
later datagram to the abandoned address starts a fresh sequence. The rejected
alternative is a table of outstanding resolutions, one per cache slot: it would
buy suppression for interleaved destinations at the cost of sixteen retry
timers and a second eviction policy, and Phase 1 has one application client
(architecture.md §5). §11.3 raises this for dv_lead, because it is a decision
no REQ makes.

**Retrying (REQ-506).** The interval counter starts on the cycle a request is
**accepted by M11**, not on the cycle it is generated, so a request delayed by a
busy M11 does not shorten its own interval. When the counter reaches
`retry_interval_cycles`:

- if the retry counter is below `retry_count`, it is incremented and another
  request for the same target is generated;
- otherwise the resolution is abandoned: the outstanding register is cleared,
  nothing is cached, and no strobe pulses — abandoning a resolution is not a
  discard, because the datagram that caused it was discarded and reported at
  the time (REQ-505).

At most `retry_count` + 1 requests appear on the wire per resolution.

---

#### The one M11 port, and REQ-510

M13 has two things it may want to send — a **reply** and a **request** — and one
M11. The rules are three:

1. **M13 asserts an offer** (`arp_tx.valid` towards M11) when it has something
   to send and is not already holding one.
2. **A reply is chosen over a request** on the cycle the offer is asserted. A
   reply has REQ-502's response deadline; a request has a retry interval and can
   afford to wait. The selection is made once and is not revisited.
3. **An asserted offer is held unchanged until M11 accepts it** — every field
   stable, `valid` high — which is ADR-0008 decision 2 as SPEC-M11 §7
   instantiates it for a record with no payload stream. A reply generated while
   a *request* offer is outstanding therefore waits for that acceptance rather
   than preempting it, which costs at most the few cycles §7 accounts for.

**At most one reply is pending (REQ-510).** A reply is **pending** from the
cycle it is generated until the cycle M11 accepts it. If a second reply is
generated while one is pending — which happens exactly when a second accepted
request for `cfg_local_ip` arrives inside that window — then

> the **newly generated** reply is discarded, `error_arp_reply_dropped` pulses
> for exactly one cycle, and the pending reply is untouched.

Nothing on the receive path is stalled, and nothing could be: `rx_payload`
carries no `tready` at all (§3, §4.1). REQ-510's "this is the only condition
under which a reply is dropped" holds here literally — §9's table has exactly
one reply-dropping row — and its "reachable by construction" is REQ-510's own
test: hold M09 busy with a maximum-length IPv4 frame and inject two back-to-back
ARP requests.

**A request is never dropped.** If M11 is busy when a request is generated, the
request waits for the port; if the resolution is abandoned or replaced while it
waits, the waiting request is superseded by the new one rather than sent. No
strobe reports either, because REQ-505 has already reported the miss that caused
it and REQ-008's discard is about frames, not about intentions.

---

**Cycle by cycle, REQ-502's response through the whole chain.** Cycle 0 is the
XGMII word carrying the request frame's start character, at a lane-0 start; the
request is a 64-octet ARP frame for `cfg_local_ip`; the transmit path is idle
with its gap obligation served.

| Cycle | Event | From |
|---|---|---|
| 0 | request's start character on XGMII | stimulus |
| 3 | M03 output word 0 | SPEC-M03 §7, ΔC = 3 |
| 5 / 6 | M06 `hdr_valid` / payload word 0 | SPEC-M06 §7, ΔC = 3 |
| 6 / 7 | M08 `arp_hdr_valid` / `arp_payload` word 0 | SPEC-M08 §7, ΔC = 1 |
| 6 / 7 | the same at M10's ports | M13's relay, 0 cycles (§7) |
| **9** | the request's terminate character on XGMII — REQ-502's measurement start | stimulus |
| 11 | M10 `arp_valid` | SPEC-M10 §7, Cp + 4 |
| 12 | M13 offers the reply to M11; M11 accepts (idle) | §6.1 rule 1, SPEC-M11 §6.2 |
| 13 | M11 offers `hdr_valid` + payload word 0; M09 grants; M07 accepts | SPEC-M11 §7, SPEC-M09 §6.2 |
| 14 | M07 output word 0; M04 accepts | SPEC-M07 §7 |
| **15** | the reply's start character on XGMII — REQ-502's measurement end | SPEC-M04 §7 |

**Six cycles**, against REQ-502's bound of 64. Every term is a constant another
specification pins, which is why this table is a derivation and not a
measurement; §8's system run measures it and asserts the bound.

### 6.2 State machine

Reset state and `clear` state are `Idle` in all three machines below. M13 holds
**three** small machines and no other sequencing; they interact only where §6.1
rule 2 says they do, at the M11 port.

**(A) Reply**

| State | Entered when | Does | Leaves to |
|---|---|---|---|
| `Idle` | reset; `clear`; M11 accepts the pending reply | nothing; no reply is pending | `Pending` on the cycle after an `arp_rx` pulse satisfying §6.1's reply predicate, capturing the five reply fields |
| `Pending` | a reply is generated | keeps the reply available for the M11 port; a second reply generated here is **discarded** with one `error_arp_reply_dropped` pulse (REQ-510) and this state does not change | `Idle` on the cycle M11 accepts the reply |

**(B) Resolve**

| State | Entered when | Does | Leaves to |
|---|---|---|---|
| `Idle` | reset; `clear`; the resolution ends (answered, abandoned or replaced) | no resolution is outstanding; a miss here starts one | `Requesting` on a class-4 or class-5 miss, capturing the target and setting the retry counter to 0 |
| `Requesting` | a request is generated | keeps the request available for the M11 port; a further miss for the **same** target pulses `error_arp_miss` and issues nothing (REQ-505); a miss for a **different** target replaces the target and resets the retry counter, staying here | `Waiting` on the cycle M11 accepts the request; `Idle` on an accepted packet whose `sender_ip` equals the target |
| `Waiting` | M11 accepted a request | counts `retry_interval_cycles`; a further miss for the same target pulses `error_arp_miss` and issues nothing | `Requesting` when the interval expires and the retry counter is below `retry_count`, incrementing it; `Idle` when it expires with the counter at `retry_count` (abandonment, REQ-506), or on an accepted packet whose `sender_ip` equals the target, or on a miss for a different target — which re-enters `Requesting` with the new target |

**(C) Respond** — a two-stage pipeline rather than a state machine, kept here
because §7's constant is what it exists to guarantee.

| Stage | On cycle | Does |
|---|---|---|
| 0 | Q, a query arrives | evaluates the class (§6.1); for classes 4 and 5 presents `cache_query` to M12 on this cycle; for classes 1 to 3 computes the MAC and issues no cache query |
| 1 | Q + 1 | receives M12's `result` for a class-4/5 query; holds the class-1/2/3 answer |
| 2 | Q + 2 | drives `tx_response_valid` = 1 with `found` and `mac`; pulses `error_arp_miss` if `found` = 0; feeds machine (B) if it does |

A cycle with `tx_query_valid` = 0 puts nothing into stage 0 and produces no
response two cycles later. Back-to-back queries are pipelined and produce
back-to-back responses, in order (REQ-020).

### 6.3 Deliberately unconstrained

Anything not listed here is constrained by this specification, and a test may
rely on it.

1. **Every internal encoding**: the three FSM encodings, whether the retry and
   interval counters are one register or two, whether the reply fields are held
   in one register or five, whether the class evaluation is a priority
   multiplexer or a set of masked comparisons. §7's constants are what is fixed.
2. **The value of `tx_response_mac` on a cycle with `found` = 0**, and of every
   output field on a cycle with its `valid` low (SPEC-M01 §6.3 item 5). No
   monitor may read them.
3. **Which of two conditions is evaluated first inside one cycle** when a
   learning write and a class-4/5 cache query address the same slot on the same
   cycle. This is **not** unconstrained after all and is listed here only to say
   so: SPEC-M12 §6.1's ordering rule decides it — the query sees the pre-write
   contents — so a resolution asked on the very cycle its answer is being
   learned **misses**, deterministically, and REQ-505's remedy applies. A bench
   may assert exactly that.
4. **M13's behaviour when `tx_query_valid` is asserted on consecutive cycles for
   more targets than one resolution can track.** The responses are all produced,
   in order, at Q + 2 (§6.2 (C)); which of several missed targets ends up
   outstanding follows §6.1's replacement rule and is therefore constrained, not
   free. Listed so that a reader does not assume a queue: there is none.
5. **The outcome of changing any of the four configuration inputs on the exact
   cycle of the event that samples it** (§4.3): the `arp_rx` pulse for the reply
   predicate and `cfg_local_mac`, the `tx_query_valid` cycle for the class
   comparisons. §4.3 governs a change landing at least one cycle before its
   sampling event; the same-cycle case is left open there and is left open
   deliberately here. A bench that changes a configuration input on the sampling
   event's own cycle and asserts either outcome is flaky by construction and
   SHALL NOT be written. This is carry-forward **C-14.5**'s rule applied to this
   module.
6. **M13's behaviour when a source violates ADR-0008 at the `tx_query` port** —
   there is nothing to violate: `tx_query_valid` is a one-cycle pulse with no
   acceptance event, because M13 can never refuse a query (§7). Listed so that
   no bench looks for a handshake that does not exist.

## 7. Timing contract

- **Latency, the receive relay.** **Zero.** `rx_hdr` and `rx_payload` reach M10
  combinationally, so L = 0 octet times, h = 0 and ΔC = 0 for that path. M10's
  constants (SPEC-M10 §7: L = 32, h = 0, ΔC = 4) are therefore the same measured
  at M13's `rx_` ports as at M10's own, and a bench may attach to either. This
  is the same relay property SPEC-M05 §6.1 states for the MAC wrapper, and it is
  what makes M10's §8 bench a bench of this whole branch.

- **Latency, the transmit relay.** **Zero**, in both directions: M11's `hdr` and
  `payload` reach `tx_hdr` and `tx_payload` combinationally, and
  `tx_payload_tready` reaches M11's `payload_tready` combinationally. §11.4
  records that this lengthens the combinational path SPEC-M09 §11.2 already
  tracks.

- **Latency, the resolution response.** Pinned at **2 cycles**, uniform across
  all five destination classes: a query on cycle Q is answered on cycle Q + 2
  (§6.2 (C)). The two measurement events are the cycle on which
  `tx_query_valid` = 1 and the cycle on which `tx_response_valid` = 1 for that
  query.

  requirements.md §0.5's octet times have **no instance** on this port and none
  is claimed: neither a query nor a response carries an octet of a frame, so
  there is no octet time to difference and no front offset h. §1.1 allocates M13
  nothing, both because this branch is not the chain REQ-006 measures and
  because a control port is not on any datapath. The figure is stated in cycles
  because that is the unit the port has — the same honesty SPEC-M12 §7 applies
  to its own one-cycle lookup.

- **Latency, the reply.** Not a constant of this module alone: REQ-502's bound
  is a property of the whole chain, and §6.1's cycle table derives **6 cycles**
  from six other specifications' constants against REQ-502's 64. M13's own
  contribution is **1 cycle** — the offer to M11 is asserted on the cycle after
  M10's `arp_valid` pulse — plus however long M11 takes to be free, which is 0
  when nothing else is in flight and is bounded by REQ-510 when something is:
  a reply cannot queue behind another reply, because a second reply is dropped
  rather than held.

- **Throughput.** One query accepted per cycle, unconditionally and
  indefinitely: M13 can never refuse a query, because `tx_query` carries no
  `ready` (§4.1) and M12 can never refuse a lookup (SPEC-M12 §7). One response
  per query, in order. One receive-path word relayed per cycle, unconditionally
  (REQ-003). At most one `arp_tx` acceptance per five cycles, which is M11's
  packet period (SPEC-M11 §6.1) and not a limit of M13's.

- **Handshake rules.**
  - `tx_query_valid`, `tx_response_valid` and all three strobes are **one-cycle
    pulses**; the fields beside each are meaningful only on their `valid` cycle.
  - `rx_hdr_valid` is a one-cycle pulse, REQ-401's receive-side discipline,
    relayed unchanged (SPEC-M10 §7).
  - `tx_hdr_valid` is a **level held until the frame's first payload word is
    accepted**, ADR-0008's transmit-side discipline, relayed unchanged from M11.
    M13 restates ADR-0008's decisions 1, 2 and 4 as its own obligation towards
    M09, because on this edge M13 is the source that M09 sees: header and first
    payload word asserted together, held with every field stable until that word
    is accepted, and never a header without a payload word. M11 is what
    satisfies all three (SPEC-M11 §6.1); M13 relays and adds nothing.
  - **A transmit-side header monitor keys on the acceptance of the first payload
    word and never on a `valid` edge** (ADR-0008's Consequences, carry-forward
    C-17(d)).
  - Towards M11, M13 is the source of an `Arp_packet` and carries SPEC-M11 §7's
    substituted obligation: `arp_valid` and all five fields held stable until
    `arp_ready` = 1.

- **Reset.** While `clear` = 1 and on the first cycle after it returns to 0:
  `tx_hdr_valid` = 0, `tx_payload_tvalid` = 0, `tx_response_valid` = 0 and all
  three strobes are 0; machines (A) and (B) are in `Idle`, so no reply is
  pending and no resolution is outstanding; and the cache is empty, because M12
  is in the same reset (SPEC-M12 §7). A frame in flight out of M11 is abandoned
  with no `tlast` (SPEC-M11 §7); a query in flight loses its response. A query
  presented on the first cycle after `clear` returns to 0 is answered normally
  two cycles later, and it misses, because the cache is empty — which pulses
  `error_arp_miss` and issues a request, and is exactly right.

- **Configuration sampling.** §4.3's table: `cfg_local_mac` and the reply
  predicate's `cfg_local_ip` on the `arp_rx` pulse; the three class-comparison
  inputs on the `tx_query_valid` cycle. A change landing on its own sampling
  cycle is unconstrained (§6.3 item 5).

## 8. Line-rate stress obligation

**Not applicable.** M13 is not in requirements.md §0.4's stress-bench list (M03,
M06, M08, M10, M14, M17, M20), and the reason is precise rather than
conventional: its receive-path ports are **pure combinational relays** into M10,
adding no logic and no cycle (§7), so SPEC-M10 §8's stress bench measured at
M13's `rx_` ports is the line-rate bench for this branch — the same wrapper rule
§0.4 states for M05, M16 and M19. The logic M13 does add is not on a receive-path
stream and cannot be stressed by a frame arrival rate: no arrival rate makes the
resolver run out of anything, because it refuses nothing and buffers nothing.

§0.4's escape clause — a wrapper joins the list by spec diff if it introduces
datapath logic of its own — is checked and does not fire: between `rx_hdr` /
`rx_payload` and M10's ports there is wire, and between M11's ports and
`tx_hdr` / `tx_payload` there is wire.

Its equivalent obligations, specified here so no sign-off packet has to invent
them:

1. **REQ-505's burst**, which is the closest thing M13 has to a rate test:
   transmit to an unknown host, then present **100** further queries for the
   same destination inside one retry interval, and assert **exactly one** request
   on the wire, **100** `error_arp_miss` pulses, 100 responses with `found` = 0
   at Q + 2, and every application word accepted rather than stalled.
2. **REQ-510's collision**, which is the reply-drop case and is reachable by
   construction: hold M09 busy with a maximum-length IPv4 frame while injecting
   two back-to-back ARP requests for `cfg_local_ip`; assert exactly one
   `error_arp_reply_dropped` pulse, that the **first** reply is transmitted once
   M09 frees, and that REQ-004 still holds on the receive path throughout —
   which it must, because `rx_payload` has no `tready` to assert (§3).
3. **REQ-506's retry sequence**, with `retry_interval_cycles` overridden to 16
   and `retry_count` to its default 4: count the requests on the wire (expect
   **5** — one initial plus four retries), assert the interval between
   consecutive requests is 16 cycles measured from acceptance to generation,
   assert the sequence stops, and then assert that a later query for the same
   address starts a **fresh** sequence of five (REQ-506's "nothing is negatively
   cached").
4. **REQ-507's class walk**: one query per class, including 255.255.255.255 and
   a multicast address chosen to lie **outside** the configured subnet, plus an
   off-subnet destination whose request and resulting frame must both target the
   gateway. For classes 1 to 3 additionally assert `cache_query_valid` = 0 at
   M12's port, which is how "without consulting the cache" is checked rather
   than assumed.

## 9. Errors and discards

Strobe names are normative (requirements.md §12).

| Condition | Strobe (one cycle) | Effect | REQ |
|---|---|---|---|
| A class-4 or class-5 resolution whose target has no live cache entry | `error_arp_miss` | `tx_response_valid` = 1 with `found` = 0 on the same cycle; M15 discards the datagram without buffering and keeps accepting its payload words; a request is broadcast unless a resolution for the same target is outstanding | REQ-505 |
| A reply is generated while a reply is already pending | `error_arp_reply_dropped` | the **newly generated** reply is discarded and never reaches M11; the pending reply is untouched and is transmitted; nothing on the receive path is stalled | REQ-510 |

Silent discard is prohibited (REQ-008): both rows have a strobe. The `clear`
cases of §7 are REQ-009's, not REQ-008's.

**`error_arp_unsupported` is relayed, not raised.** M10 detects REQ-501's
rejection and pulses it; M13 passes the wire through and pulses **nothing** of
its own for that packet, because requirements.md §0.6 forbids a module from
re-reporting a condition it merely inherited. A rejected packet is not learned
from and generates no reply, which follows without a rule: M10 emits no
`arp_valid` for it, and every receive-side action of §6.1 is keyed on that pulse.

**Two events that are not discards, stated because a conservation monitor must
not count them.**

- **An entry expiring** (REQ-506): nothing was in flight. Its consequence is a
  later miss, which is reported then (SPEC-M12 §9).
- **A resolution being abandoned or replaced** (REQ-506, §6.1): the datagram
  that caused it was discarded and reported at the time, and an unsent *request*
  is an intention rather than a frame. No strobe, and REQ-008 is not weakened.

**Which conditions can co-occur on one cycle, and what then pulses.**

- **`error_arp_miss` with `error_arp_reply_dropped`**: yes, and both pulse. They
  belong to independent machines fed by independent events — a transmit-side
  query and a receive-side request — and a cycle can carry one of each. A bench
  that assumes at most one strobe per cycle at this module is wrong.
- **`error_arp_miss` with the relayed `error_arp_unsupported`**: yes, same
  reason, and M13 raises neither jointly — one is M13's, one is M10's.
- **Two `error_arp_miss` pulses for one query**: never. One query, one response,
  at most one strobe.
- **`error_arp_miss` on a class-1, class-2 or class-3 query**: never. Those
  classes resolve arithmetically, consult no cache and cannot miss — REQ-508 and
  REQ-509 say so and §6.1's table is the enumeration.
- **100 misses for one target**: 100 pulses and **one** request (REQ-505, §8
  item 1). The strobe counts *datagrams discarded*, not resolutions started.

**Aborted-and-forwarded versus discarded-before-emission.** Both rows are the
second kind: nothing is emitted for the datagram a miss discards (M15 emits
nothing), and nothing is emitted for a dropped reply. requirements.md §0.6's
abort rule has no instance at M13 and no `tuser`[0] is ever set here.

## 10. REQ coverage

| REQ | How this module satisfies it | Section | Verification hook for DV |
|---|---|---|---|
| REQ-001 | one clock, shared by all three children | §3 | the emitted-Verilog edge-expression check |
| REQ-003 | `rx_payload` is `Axi64.Source` with no `Dest`; nothing M13 does can stall M08 | §4.1 | interface compile check |
| REQ-004 | no instance of its own: the relay is combinational, so M10's §8 bench measured at M13's `rx_` ports covers this branch | §8 | SPEC-M10 §8's bench attached at M13's ports rather than M10's, asserting the same four criteria |
| REQ-005 | relay latency 0 at every octet; response latency a single constant across all five classes | §7 | the class walk of §8 item 4, asserting Q + 2 for every class |
| REQ-007, REQ-013 | relays `tuser`[0] unchanged; originates and re-reports no abort | §3, §9 | protocol monitor across the relay |
| REQ-008 | two strobes, both pulse cycles pinned; the two non-discards named so a monitor does not count them | §9 | directed miss and reply-drop tests plus the conservation monitor |
| REQ-009 | `clear` empties the cache, abandons the pending reply and the outstanding resolution, and zeroes all three strobes | §7 | assert `clear` with a reply pending and a resolution outstanding; deassert; assert no reply is transmitted, no retry appears, and the next query misses |
| REQ-010 | programme stream and header types; `Arp_query` / `Arp_response` declared here; `Arp_packet` and the cache records opened from M10 and M12 | §4.1 | interface compile check |
| REQ-020 | responses in query order; packets learned in arrival order; the one deliberate overtake (reply before waiting request) stated | §3, §6.1 | back-to-back queries in §8 item 1, asserting response order |
| REQ-501 | **not** M13's: it consumes a record whose `valid` already means accepted, and re-checks nothing | §2 | none — stated so that no sign-off packet claims REQ-501 coverage here |
| REQ-502 | decision half: reply iff operation 1 and `target_ip` = `cfg_local_ip`; five fields filled per §6.1; the 6-cycle derivation against the 64-cycle bound | §6.1, §7 | inject a request; decode the transmitted frame field by field against all six address fields; measure from the request's last XGMII word to the reply's start character |
| REQ-503 | every `arp_valid` pulse produces a cache write on the next cycle, addressed to us or not | §6.1 | inject a request from a new host, then transmit to that host: no new request appears and the frame carries the learned MAC |
| REQ-505 | miss → `found` = 0, one strobe, one broadcast request, suppressed while the same target is outstanding; no buffering anywhere | §6.1, §9 | §8 item 1: one request, 100 strobes, 100 responses, every application word accepted |
| REQ-506 (retry half) | one initial request plus up to `retry_count` retries at `retry_interval_cycles`, measured from acceptance; then abandonment with nothing negatively cached | §5, §6.1, §6.2 (B) | §8 item 3: five requests at interval 16, sequence stops, a later query starts a fresh five |
| REQ-506 (ageing half) | **not** M13's: forwarded to M12 as a parameter and read for nothing here | §5 | none — stated so that no sign-off packet claims ageing coverage here |
| REQ-507 | five classes in the stated order, first match wins; off-subnet resolves the gateway, not the destination | §6.1 | §8 item 4's class walk, including the off-subnet case asserting both the request's and the frame's target |
| REQ-508 | 255.255.255.255 and `cfg_local_ip \| ~cfg_subnet_mask` both answer `ff:ff:ff:ff:ff:ff` with no cache query and no request | §6.1 | both destinations driven; destination MAC checked and `cache_query_valid` = 0 asserted at M12's port |
| REQ-509 | 224.0.0.0/4 answers 01:00:5E, bit 23 forced 0, low 23 bits from the address; no cache query, no request | §6.1 | 239.1.2.3 → 01:00:5E:01:02:03 and 239.129.2.3 → the same MAC, which is what exercises the 23-bit mask |
| REQ-510 | at most one pending reply; a second is discarded with one strobe; the receive path cannot be stalled because it has no `tready` | §6.1, §9 | §8 item 2's collision run |
| REQ-511 | no separate rule: the reply predicate fires for a gratuitous ARP exactly when its address is `cfg_local_ip`, and REQ-503 learns from it either way | §6.1 | gratuitous ARPs for a foreign address and for the local address: cache updated in both, reply only in the second |
| REQ-512 | the same predicate in the negative: a request for any other address gets no reply, while learning still happens | §6.1 | three foreign-address requests: no transmit activity, cache entries present |
| REQ-802, REQ-803 | four configuration inputs, each with its sampling event named; receive and transmit sampled independently | §4.3 | change `cfg_local_ip` between two requests and assert the reply predicate follows it at the next packet, not the one in flight |
| REQ-810 | no instance at M13's ports — `cfg_tx_enable` is M04's — and REQ-810's ARP clause is realised through the backpressure chain: with transmit disabled M04 holds `tx_tready` low, M09 never grants, M11 never has its first payload word accepted, so `arp_ready` stays 0 and a **second** reply is dropped under REQ-510 | §11.2 | drive `cfg_tx_enable` = 0, inject two requests, assert one `error_arp_reply_dropped`; re-enable and assert the first reply transmits |
| REQ-901 | declared divergence classes **(b)** and **(c)** live here: direct-mapped versus LRU (eviction order not compared) and discard-on-miss versus queued resolution (post-miss transmit behaviour not compared) | header, §2 | the co-simulation report names both classes against this module |
| REQ-903, REQ-808 | `arp` is a distinct emitted module with `create`, `hierarchical` and an `.mli`, and it instantiates `arp_eth_rx`, `arp_eth_tx` and `arp_cache` as distinct hierarchical modules | §4.1 | repository surface check and the `rtl_snapshots/` name comparison |

This table is the source of M13's rows in [`traceability.md`](../traceability.md),
updated in the same commit.

## 11. Deferred items

Item numbers are permanent; a closed item keeps its row (SPEC-TEMPLATE §11).

| # | Item | Status · what a reader assumes meanwhile | Tracked as | Owner | Closes by |
|---|---|---|---|---|---|
| 11.1 | **The `ifc_check` compile evidence for this lift is pending**: `arp_ifc.ml` is new in this commit, declares two records, opens three other lifts and is the widest record batch D adds. | **DEFERRED — the record is written, the run is pending.** Meanwhile a reader assumes it exactly as §4.1 writes it. The three `open!`s are ordinary intra-library references within the single `ifc_check` library and there is no cycle: M10's and M12's lifts reference nothing of M13's. A divergence is a red CI run on this commit and an editorial diff. | the `Interface compile check` row of §12 | architect_docs_lead, rtl_lead | the batch-D `ifc_check` run |
| 11.2 | **REQ-810's ARP clause reads as though every reply generated while transmit is disabled is dropped**, and the mechanism this specification states drops the **second and later** ones while the first waits inside M11 until transmit is re-enabled. Dropping the first would need a `cfg_tx_enable` input at M13 that architecture.md §6.4.3 does not route here. | **DEFERRED — the behaviour is decided and benchable, and nothing waits.** Meanwhile a reader assumes: the first reply waits, later ones are dropped with `error_arp_reply_dropped` (§10's REQ-810 row is written against exactly that). If the programme wants the first dropped too, the repair is a requirements.md diff to REQ-810 plus a new `cfg_tx_enable` input here and a new row in architecture.md §6.4.3 — a port addition, so a **breaking** interface change if it lands after this spec freezes. Raised for dv_lead at the batch-D countersignature for that reason. | this item; requirements.md REQ-810 | architect_docs_lead, dv_lead | batch-D countersignature |
| 11.3 | **A miss for a target different from the outstanding one replaces the resolution**, and no REQ decides that case: REQ-505 constrains only the same-target case. §6.1 states the rule and its rejected alternative (a per-slot table of outstanding resolutions). | **DEFERRED — the rule is stated normatively and a bench is derivable today.** Meanwhile a reader assumes replacement: the previous target is abandoned, the new one starts at retry 0, and a request for it is issued. This is safe under REQ-506's own "nothing is negatively cached", which makes an abandoned resolution costless. If dv_lead judges it a missing requirement rather than a specification decision, the repair is a requirements.md diff to REQ-505 plus a spec diff here; no port changes either way. | this item; requirements.md REQ-505 | architect_docs_lead, dv_lead | batch-D countersignature |
| 11.4 | **Both transmit relays are combinational** (§7), so the M11 → M13 → M09 → M07 path and the `payload_tready` path back through it are longer than SPEC-M09 §11.2's estimate, which counted M09's mux alone. | **DEFERRED — nothing in Phase 1 depends on closing them.** REQ-018 keeps the XGMII boundary simulation-only and no static timing closure at 6.4 ns is required, so a reader builds the combinational relay today. If a later phase cannot close the path, the remedy is SPEC-M09 §11.2's: a spec diff plus an ADR restating the cadence, never a quiet register — a register here would change REQ-406's measured grant delay and REQ-502's derivation in §6.1 at the same time. | this item; SPEC-M09 §11.2 | architect_docs_lead, rtl_lead | Phase-3 attach, or the first synthesis attempt |
| 11.5 | **`Arp_query` and `Arp_response` are declared here rather than in M01**, for the reason SPEC-M10 §11.2 states, and M15 (batch E) will open this module for them. | **DEFERRED — the placement is decided and buildable.** A reader implements exactly that; SPEC-M15 opens `Arp_ifc` in its lift and the RTL references `Arp.Arp_query`. If a later phase reopens M01, the batch-D records may be promoted there by one spec diff plus an ADR, which is a rename and not a behavioural change. | SPEC-M10 §11.2; SPEC-M01 §4.1 | architect_docs_lead, rtl_lead | SPEC-M20 (batch F) |

## 12. Freeze record

Filled in at `P1-spec-freeze`. All four rows are required (charter §5); this
spec is DRAFT.

| Item | Value |
|---|---|
| Interface compile check | pending — CI `build` run `<id>`, conclusion `<success>`, SHA `<sha>`; per ADR-0005 a local build is not acceptable evidence. This run is also §11.1's closure record |
| Architect signature | `J-architect_docs_lead-0006` |
| dv_lead testability countersignature | pending — batch D (SPEC-M10, M11, M12, M13) |
| Frozen at | pending — SHA `<sha>`, gate `docs/gates/P1-spec-freeze-checklist.md` |

## 13. Change log

Post-freeze changes only. This spec is DRAFT and has none.

| Date | Change | Breaking? | ADR | Journal |
|---|---|---|---|---|
| — | — | — | — | — |
