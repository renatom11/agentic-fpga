# SPEC-M13 — `Arp`

- **Status**: DRAFT — batch D. Template-complete; the `ifc_check` evidence row of
  §12 is **filled** (run 30736107842, `success`, 2f29888). This specification was
  **CONTESTED** at the batch-D countersignature on two behavioural items
  (`J-dv_lead-0008`, WO-0015): **D-1**, repaired here by **R-1** (§6.1, §6.2 (A)),
  and **D-2**, repaired here by **D-2a** (§6.1's validity gate, §6.2 (D),
  ADR-0009). The freeze flip waits on the re-review of those two landing sites
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
  every accepted **and unmarked** packet into M12, addressed to us or not.
- **Consuming REQ-013's validity mark on behalf of the whole ARP branch**
  (REQ-013, ADR-0009): M13 is the branch's ultimate consumer — it is the last
  module that acts on a received packet's content and it forwards nothing — so it
  reads `rx_payload_tuser`[0] at the packet's payload `tlast` and gates both
  actions above on it (§6.1).
- **Replying** (REQ-502, REQ-511, REQ-512): generating exactly one reply for an
  accepted, unmarked request whose target protocol address equals `cfg_local_ip`,
  and none otherwise.
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
| REQ-007, REQ-013 | `rx_payload`'s `tuser`[0] is relayed to M10 unchanged and ignored **by M10** (SPEC-M10 §7); **M13 consumes it** as the ARP branch's ultimate consumer, gating learning and the reply on it at the packet's payload `tlast` (§6.1, ADR-0009). No frame is dropped or altered by that — nothing is forwarded on this branch — and no strobe re-reports the inherited abort. `tx_payload`'s `tuser` is M11's, driven to 0 (SPEC-M11 §4.2). M13 originates no abort. |
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

**The validity gate (REQ-013, REQ-503, ADR-0009) — both receive-side actions
pass through it.** M10 reports a packet at Cp + 4 and takes no notice of
`rx_payload_tuser`[0]: SPEC-M10 §7 shows that bit arriving on the payload
`tlast` word, two or more cycles later, so M10 could not act on it without
making its parse latency a function of the frame length (REQ-005). **M13 can**,
because it relays `rx_payload` into M10 and therefore already has the bit at its
own ports. M13 holds M10's report and acts on the cycle after the **later** of

1. M10's `arp_valid` pulse, and
2. that packet's payload `tlast` word on `rx_payload`,

reading `rx_payload_tuser`[0] of that `tlast` word. Call that the **gating
cycle**. If the bit is **0**, the learning write is presented and the reply
predicate is evaluated, both below. If it is **1**, neither happens — the packet
is not learned from and no reply is generated — **and no strobe pulses here**,
because the condition was detected and reported upstream by the module that
marked the frame (`error_bad_fcs` REQ-104, `error_runt` REQ-107,
`error_bad_frame` REQ-105, `error_oversize` REQ-108 or
`error_start_without_terminate` REQ-110) and requirements.md §0.6 forbids
re-reporting an inherited abort. requirements.md REQ-013 names M13 as the ARP
branch's ultimate consumer and REQ-503 carries the qualifier; **ADR-0009**
records why this owner and not another, and why the alternative of recording the
un-gated behaviour as a programme decision was rejected on merit.

**In the composed chain the rule reduces to `tlast` + 1**, and the "later of"
exists for determinacy rather than for a case that arrives. A legal
minimum-length frame delivers a 46-octet ARP payload in six words, so the payload
`tlast` is at Cp + 5 and M10's report at Cp + 4: (2) is the later event, always.
(1) can be later only for a packet whose payload ends at exactly 28 octets —
four words, `tlast` at Cp + 3 — which is a 42-octet Ethernet frame, that is a
**runt**, which REQ-107 marks; so that packet is excluded by the gate in any
case.

**What the gate costs, itemised.** The five captured `Arp_packet` fields — 176
bits — are held from Cp + 4 to the gating cycle, which REQ-019 explicitly does
not count as payload storage ("header fields captured into registers are not
payload storage") and which is bounded by REQ-015's 188-word frame. **No port,
no `Arp_packet` field, and nothing at M10 changes** — not its ports, not §7's
L = 32 / h = 0 / ΔC = 4, not §9's pulse cycle. What it does cost is one cycle of
REQ-502's derived response, which the cycle table at the end of this section
recomputes as **7** against the 64-cycle bound.

**Learning (REQ-503).** On the gating cycle of an accepted, unmarked packet, M13
presents a cache write with `write_ip` = `arp_sender_ip` and
`write_mac` = `arp_sender_mac`. It is otherwise unconditional — "whether or not
the packet is addressed to us" is REQ-503's own clause — and it applies to a
reply exactly as to a request, and to a gratuitous ARP exactly as to either.
Nothing about the Ethernet header is learned; the ARP fields are the source of
truth, which is why M10 does not read `rx_hdr_src_mac` (SPEC-M10 §4.2).

**Replying (REQ-502).** On that same gating cycle, M13 generates a reply **iff**

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
**ends** on the same cycle as the learning write — the gating cycle: the
outstanding register is cleared and no further retry is issued. This is what
"unanswered requests SHALL be retried" means read forwards, and it holds whether
the answer arrived as a reply (operation 2) or as any other accepted packet from
that address — the cache entry is what the resolution wanted, and REQ-503 has
just created it.

**A marked packet ends nothing** (ADR-0009). A packet the gate rejected produces
no cache write, so the entry the resolution wanted does not exist; ending the
resolution on it would abandon a retry sequence on the strength of a frame the
programme has already declared invalid, and the next datagram to that address
would miss with no request outstanding. The resolution therefore stays
outstanding and its retry sequence continues, which is the same rule read
consistently: a resolution ends when the cache can answer it.

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
class 1 rather than a cache lookup, and a multicast address class 3 rather than
class 4 or 5 whether or not it happens to lie inside the configured subnet — the
two cases REQ-507's verification column names.

*The competitor for 255.255.255.255 is class 4, not class 5, and which one it is
depends on the mask* (dv_lead, WO-0015 Return log §6 item 4). With `m` = 0 every
destination satisfies class 4's test — (`d` & 0) = (`l` & 0) is 0 = 0 — so an
implementation that evaluated the classes out of order would resolve
255.255.255.255 **through the cache** as an on-subnet address. With an ordinary
mask the same address fails class 4 and would fall to class 5, the gateway. Both
readings are wrong and the order is what forbids both; the earlier wording of
this paragraph named class 5 as the competitor *when the mask is 0*, which is the
one combination that does not arise.

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

**At most one reply is pending (REQ-510), and "pending" ends when the reply's
frame does.** A reply is **pending** from the cycle it is generated until — and
including — the cycle **M11's payload `tlast` word is accepted**, which is the
cycle the reply's frame leaves the ARP family for M09. M13 observes that event
with no new port: it relays M11's `payload` out on `tx_payload` and M09's
`tready` back on `tx_payload_tready` (§7), so the event is
`tx_payload_tvalid` = 1 **and** `tx_payload_tlast` = 1 **and**
`tx_payload_tready` = 1 at M13's own ports. M11 holds one packet at a time
(SPEC-M11 §6.2), so the first such acceptance after the reply's record was taken
is that reply's frame and no other's.

If a second reply is generated while one is pending — which happens exactly when
a second accepted, unmarked request for `cfg_local_ip` reaches its gating cycle
inside that window — then

> the **newly generated** reply is discarded, `error_arp_reply_dropped` pulses
> for exactly one cycle, and the pending reply is untouched.

**Why the window is the frame and not the record** (dv_lead's owed diff **D-1**,
repair **R-1**, WO-0017). SPEC-M11 §6.2's `Idle` row asserts `arp_ready` = 1
**unconditionally** — it does not depend on `payload_tready`, and only `clear`
or M11 already holding a packet lowers it. So with the transmit path blocked and
M11 idle, M11 accepts reply 1's *record* on the cycle it is offered and then
holds the frame it cannot send. A pending window ending at the record's
acceptance would return machine (A) to `Idle` there, leaving reply 2 to enter
`Pending` and **stay** there with no strobe, and reply 3 the first one dropped:
the ARP family would hold **two** replies where REQ-510's normative sentence says
one, and the four sites that count on it — §8 item 2, §10's REQ-510 and REQ-810
rows and REQ-510's own verification column in requirements.md — would each
commission a strobe a conformant design does not pulse. With the window as
stated, **exactly one reply exists anywhere in the family at a time** and all
four counts are correct as written, with no requirements diff, no port and no
record field. The rejected alternative was to weaken REQ-510's normative sentence
to "one pending at the resolver and one further already accepted for
transmission" and move the four counts from two to three; §11.6 records why that
was not taken.

**The window costs nothing when the transmit path is running.** An unblocked
reply's frame completes five cycles after its record is accepted (SPEC-M11 §6.1:
acceptance at A, payload word 3 at A + 4), while two accepted requests for
`cfg_local_ip` are at least ten cycles apart at REQ-004's own arrival rate. No
reply that would be transmitted today is dropped under this rule.

**The boundary cycle is inside the window.** A reply generated on the very cycle
the pending reply's `tlast` word is accepted is **dropped**: machine (A) is in
`Transmitting` for the whole of that cycle and leaves it at the end of it
(§6.2 (A)). The coincidence is arithmetically unreachable from the composed
chain — the ten-cycle spacing above forbids it — and is pinned here so that a
directed bench which drives it has one predictable answer instead of two
defensible ones.

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
it and REQ-008's discard is about frames, not about intentions. **REQ-510's
window is a rule about replies only**: a request waiting for the M11 port is not
"pending" in REQ-510's sense, is not counted against machine (A), and is never
dropped by it.

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
| 11 | M10 `arp_valid` | SPEC-M10 §7, Cp + 4 with Cp = 7 |
| 12 | the request's payload `tlast` word at M13's `rx_payload` — payload word 5, Cp + 5 | SPEC-M10 §6.1's six-word frame |
| 13 | **the gating cycle**: `rx_payload_tuser`[0] = 0 is read, the cache write is presented, and M13 offers the reply to M11; M11 accepts (idle) | §6.1's validity gate (ADR-0009), rule 1, SPEC-M11 §6.2 |
| 14 | M11 offers `hdr_valid` + payload word 0; M09 grants; M07 accepts | SPEC-M11 §7, SPEC-M09 §6.2 |
| 15 | M07 output word 0; M04 accepts | SPEC-M07 §7 |
| **16** | the reply's start character on XGMII — REQ-502's measurement end | SPEC-M04 §7, §6.1 |

**Seven cycles**, against REQ-502's bound of 64. Every term is a constant
another specification pins, which is why this table is a derivation and not a
measurement; §8's system run measures it and asserts the bound.

**Six of those seven were derived at WO-0014 and are unchanged; the seventh is
the validity gate** (ADR-0009). Cycles 0 through 11 and 14 through 16 are exactly
dv_lead's recomputation at the batch-D countersignature, term by term against the
specification that pins each (`J-dv_lead-0008`, WO-0015 Return log §2). What
D-2a adds is the wait from `arp_valid` at 11 to the payload `tlast` at 12 and the
gating cycle at 13, where the old text acted at 12.

**Measurement start, pinned** (carry-forward **C-23**). Cycle 9 is the word
carrying the request's **terminate character**: eight preamble octets occupy
cycle 0, frame octets 0–63 occupy cycles 1–8, and `/T/` lands in lane 0 of cycle
9 (SPEC-M03's 64-octet table). The other reading of REQ-502's "the request's last
XGMII word" — the last word carrying *frame octets*, cycle 8 — gives **eight**
cycles for the same conformant design. requirements.md REQ-502's verification
column now names the terminate reading, and a latency artifact quoting this
figure states which cycle it started from.

**The figure is constant at every accepted request length, and that is what
makes it a derivation rather than an example.** The payload `tlast` word sits a
fixed number of cycles after the frame's terminate character — three, at a lane-0
terminate — because every stage between XGMII and M13's `rx_payload` has constant
per-octet latency (requirements.md §0.5): the last delivered octet's octet time is
the terminate character's minus five (the four FCS octets are stripped, REQ-103),
plus M03's 16 and M06's 10 and M08's 8. A longer request moves cycle 9 and cycle
12 together and the difference of seven does not move.

### 6.2 State machine

Reset state and `clear` state are `Idle` in all three machines below. M13 holds
**three** small machines and no other sequencing; they interact only where §6.1
rule 2 says they do, at the M11 port.

**(A) Reply** — two states before WO-0017, three after it: repair **R-1** for
dv_lead's owed diff **D-1** ends the pending window at the reply's *frame*
completing rather than at its *record* being accepted (§6.1).

| State | Entered when | Does | Leaves to |
|---|---|---|---|
| `Idle` | reset; `clear`; the cycle M11's payload `tlast` word for the pending reply is accepted | nothing; no reply is pending | `Pending` on the **gating cycle** of an accepted, unmarked packet satisfying §6.1's reply predicate, capturing the five reply fields |
| `Pending` | a reply is generated | offers the reply to M11 and holds it with every field stable until `arp_ready` = 1 (§7); a second reply generated here is **discarded** with one `error_arp_reply_dropped` pulse (REQ-510) and this state does not change | `Transmitting` on the cycle M11 accepts the reply record (`arp_valid` = 1 and `arp_ready` = 1) |
| `Transmitting` | M11 accepted the reply record | nothing of its own — M11 is emitting the frame and M13 is relaying it — except that **the reply is still pending**: a reply generated here is discarded with one `error_arp_reply_dropped` pulse (REQ-510) | `Idle` on the cycle `tx_payload_tvalid` = 1, `tx_payload_tlast` = 1 and `tx_payload_tready` = 1 — the reply frame's last word accepted by M09 |

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

**(D) Validate** — the receive-side gate of §6.1 (ADR-0009), a holding stage
rather than a machine, tabulated here because machines (A) and (B) are both fed
by its output and a bench needs its cycles.

| Stage | On cycle | Does |
|---|---|---|
| 0 | M10's `arp_valid` pulse | captures the five `Arp_packet` fields; marks a report outstanding |
| 1 | every cycle from there until the packet's payload `tlast` word on `rx_payload` | holds them; changes nothing else. Empty when the `tlast` word has already passed (an exactly-28-octet ARP payload, §6.1) |
| 2 | the **gating cycle** — one cycle after the later of the `arp_valid` pulse and the payload `tlast` word | reads `rx_payload_tuser`[0] of that `tlast` word. On 0: presents the cache write, evaluates the reply predicate and feeds machine (A), and ends a matching outstanding resolution in machine (B). On 1: does none of those and pulses nothing |

`clear` in any stage abandons the held fields with no write, no reply and no
strobe (REQ-009, §7).

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
7. **M13's behaviour when an accepted packet's payload `tlast` word never
   arrives**, so that §6.1's gating cycle never occurs and the captured fields
   are held indefinitely. No conformant producer does it: M06 ends every payload
   frame with `tlast` (SPEC-M06 §7), M08 relays it (SPEC-M08 §7), and a frame
   with no payload frame at all carries zero ARP octets and is rejected by M10
   before anything reaches this stage (SPEC-M10 §9). The case is **unreachable
   rather than undefined**, no requirement names it, and DV SHALL assert nothing
   about the held fields or about a later packet's report. This is the wording
   SPEC-M07 §6.3 item 3 and SPEC-M11 §6.3 item 3 use, and carry-forward C-17(c)
   is the precedent for not specifying output behaviour for a stimulus the
   programme has decided not to produce.

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
  is a property of the whole chain, and §6.1's cycle table derives **7 cycles**
  from six other specifications' constants against REQ-502's 64. M13's own
  contribution is **two cycles** for the minimum-length request of that table —
  the offer to M11 is asserted on the **gating cycle**, one cycle after the
  packet's payload `tlast` word at Cp + 5 and therefore two cycles after M10's
  `arp_valid` at Cp + 4 (§6.1's validity gate, ADR-0009) — plus however long M11
  takes to be free, which is 0 when nothing else is in flight and is bounded by
  REQ-510 when something is: a reply cannot queue behind another reply, because a
  second reply is dropped rather than held.

  **Measured from `arp_valid` the contribution is frame-length dependent;
  measured from REQ-502's own start it is not.** The gating cycle follows the
  packet's payload `tlast`, so a longer request holds the fields longer — but
  REQ-502 measures from the request's terminate character, and the payload
  `tlast` sits a fixed number of cycles after that character (three, at a lane-0
  terminate) because every stage between has constant per-octet latency
  (requirements.md §0.5). The seven-cycle figure is therefore constant at every
  accepted request length, which is what keeps §6.1's table a derivation.

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
    `arp_ready` = 1. That acceptance ends the *offer*; it does not end the
    reply's **pending window**, which runs to the frame's `tlast` acceptance
    (§6.1, R-1).
  - **The three events a REQ-510 monitor keys on**, all visible at M13's own
    ports and all computable from the trace: the gating cycle (a reply is
    generated), `arp_valid` & `arp_ready` towards M11 (the record is accepted),
    and `tx_payload_tvalid` & `tx_payload_tlast` & `tx_payload_tready` (the frame
    completes, and the window closes). No `valid` edge is one of them, which is
    ADR-0008's C-17(d) rule and its C-22 precedence clause read together.

- **Reset.** While `clear` = 1 and on the first cycle after it returns to 0:
  `tx_hdr_valid` = 0, `tx_payload_tvalid` = 0, `tx_response_valid` = 0 and all
  three strobes are 0; machines (A) and (B) are in `Idle` — machine (A) from
  `Transmitting` as readily as from `Pending` — so no reply is pending and no
  resolution is outstanding; stage (D) holds nothing, so a packet reported by M10
  but not yet gated is abandoned with no cache write, no reply and no strobe; and
  the cache is empty, because M12 is in the same reset (SPEC-M12 §7). A frame in
  flight out of M11 is abandoned with no `tlast` (SPEC-M11 §7) — its pending
  window ends with the reset rather than with an acceptance, and no strobe
  reports that (REQ-009, not REQ-008); a query in flight loses its response. A query
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
   transmit to an unknown host, then present **100 further** queries for the same
   destination inside one retry interval, and assert **exactly one** request on
   the wire, every application word accepted rather than stalled, and — counted
   over the whole run — **101** responses with `found` = 0 at Q + 2 and **101**
   `error_arp_miss` high cycles: one for the datagram that started the
   resolution plus one for each of the 100 further ones. REQ-505's verification
   column says "100 strobes" counting only the *further* datagrams; both texts
   are consistent under the word "further", and a bench counting over the whole
   run must assert **101 and not 100** (dv_lead, WO-0015 Return log §6 item 5).

   **Count high cycles, not rising edges** (requirements.md §0.6's counting
   convention, carry-forward **C-23**). `tx_query` accepts one query per cycle
   (§7) and back-to-back queries produce back-to-back responses (§6.2 (C)), so
   this run can legitimately drive `error_arp_miss` high for 100 consecutive
   cycles. An edge counter sees **1** and fails a conformant design; a high-cycle
   counter sees 100. M13 is the first module in this programme whose strobe can
   legitimately be high on consecutive cycles, which is why the convention is
   stated in §0.6 rather than here.
2. **REQ-510's collision**, which is the reply-drop case and is reachable by
   construction: hold M09 busy with a maximum-length IPv4 frame while injecting
   two back-to-back ARP requests for `cfg_local_ip`; assert exactly one
   `error_arp_reply_dropped` pulse, that the **first** reply is transmitted once
   M09 frees, and that REQ-004 still holds on the receive path throughout —
   which it must, because `rx_payload` has no `tready` to assert (§3).

   **Two requests is the right number, and it is right because of R-1** (§6.1).
   M11's `arp_ready` is 1 while it is idle, so reply 1's *record* is accepted at
   once and reply 1 then sits inside M11 waiting for M09; the pending window runs
   to the frame's `tlast` acceptance, which never comes while M09 is held, so
   reply 2 is the first drop and there is exactly one strobe. A bench built
   against the pre-R-1 text would have had to inject **three** requests to see
   one pulse, which is precisely the divergence dv_lead raised as D-1. The run
   also fixes the residual REQ-810 case: with `cfg_tx_enable` = 0 instead of a
   busy M09 the same three assertions hold, and the first reply transmits late,
   on re-enable (§11.2).
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
| A reply is generated while a reply is already pending — **pending** meaning generated and not yet completely transmitted, the window ending on the cycle M11's payload `tlast` word is accepted (§6.1, repair R-1) | `error_arp_reply_dropped` | the **newly generated** reply is discarded and never reaches M11; the pending reply is untouched and is transmitted; nothing on the receive path is stalled | REQ-510 |

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
- **A packet whose frame was marked invalid** (REQ-013, REQ-503, ADR-0009): the
  validity gate of §6.1 declines to learn from it and declines to reply to it,
  and **no strobe pulses**. The condition was detected and reported upstream by
  the module that marked the frame — `error_bad_fcs`, `error_runt`,
  `error_bad_frame`, `error_oversize` or `error_start_without_terminate` — and
  requirements.md §0.6 forbids a module from re-reporting an abort it merely
  inherited. Nor is anything discarded here in §0.6's sense: no frame is
  forwarded on this branch, and M10 still reported that packet exactly once
  (SPEC-M10 §6.1), which is where the branch's conservation equation is computed.
  A conservation monitor that counted a gated packet as a discard at M13 would
  find a discrepancy that does not exist.

**Counting these strobes** (requirements.md §0.6, carry-forward **C-23**). Both
of M13's strobes are one **high cycle** per event, and `error_arp_miss` may be
high on consecutive cycles because back-to-back queries produce back-to-back
responses (§6.2 (C), §8 item 1). A monitor counts high cycles and never rising
edges. `error_arp_reply_dropped` cannot be high on consecutive cycles in the
composed chain — two accepted requests are at least ten cycles apart at REQ-004's
arrival rate — but the same convention governs it, so one rule covers this module.

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
| REQ-007, REQ-013 | relays `tuser`[0] unchanged into M10 **and consumes it**: M13 is the ARP branch's ultimate consumer (REQ-013, ADR-0009) and gates the learning write and the reply on it at the packet's payload `tlast`. It originates no abort and re-reports none — the gate pulses nothing | §6.1, §6.2 (D), §9 | protocol monitor across the relay, plus the directed pair: an accepted request whose frame carries `tuser`[0] = 0 learns and replies; the same request with `tuser`[0] = 1 on its payload `tlast` does neither and pulses **no** M13 strobe |
| REQ-008 | two strobes, both pulse cycles pinned; the two non-discards named so a monitor does not count them | §9 | directed miss and reply-drop tests plus the conservation monitor |
| REQ-009 | `clear` empties the cache, abandons the pending reply and the outstanding resolution, and zeroes all three strobes | §7 | assert `clear` with a reply pending and a resolution outstanding; deassert; assert no reply is transmitted, no retry appears, and the next query misses |
| REQ-010 | programme stream and header types; `Arp_query` / `Arp_response` declared here; `Arp_packet` and the cache records opened from M10 and M12 | §4.1 | interface compile check |
| REQ-020 | responses in query order; packets learned in arrival order; the one deliberate overtake (reply before waiting request) stated | §3, §6.1 | back-to-back queries in §8 item 1, asserting response order |
| REQ-501 | **not** M13's: it consumes a record whose `valid` already means accepted, and re-checks nothing | §2 | none — stated so that no sign-off packet claims REQ-501 coverage here |
| REQ-502 | decision half: reply iff operation 1 and `target_ip` = `cfg_local_ip`, evaluated at the validity gate; five fields filled per §6.1; the **7**-cycle derivation against the 64-cycle bound | §6.1, §7 | inject a request; decode the transmitted frame field by field against all six address fields; measure from the request's **terminate character** (requirements.md REQ-502, C-23) to the reply's start character |
| REQ-503 | every accepted **and unmarked** packet produces a cache write on its gating cycle — one cycle after the later of `arp_valid` and the packet's payload `tlast` — addressed to us or not; a marked packet produces none (REQ-013, ADR-0009) | §6.1, §6.2 (D) | inject a request from a new host, then transmit to that host: no new request appears and the frame carries the learned MAC. Then inject the same request with a corrupted FCS: assert no cache entry, no reply, and no ARP-side strobe |
| REQ-505 | miss → `found` = 0, one strobe, one broadcast request, suppressed while the same target is outstanding; no buffering anywhere | §6.1, §9 | §8 item 1: one request, 100 strobes, 100 responses, every application word accepted |
| REQ-506 (retry half) | one initial request plus up to `retry_count` retries at `retry_interval_cycles`, measured from acceptance; then abandonment with nothing negatively cached | §5, §6.1, §6.2 (B) | §8 item 3: five requests at interval 16, sequence stops, a later query starts a fresh five |
| REQ-506 (ageing half) | **not** M13's: forwarded to M12 as a parameter and read for nothing here | §5 | none — stated so that no sign-off packet claims ageing coverage here |
| REQ-507 | five classes in the stated order, first match wins; off-subnet resolves the gateway, not the destination | §6.1 | §8 item 4's class walk, including the off-subnet case asserting both the request's and the frame's target |
| REQ-508 | 255.255.255.255 and `cfg_local_ip \| ~cfg_subnet_mask` both answer `ff:ff:ff:ff:ff:ff` with no cache query and no request | §6.1 | both destinations driven; destination MAC checked and `cache_query_valid` = 0 asserted at M12's port |
| REQ-509 | 224.0.0.0/4 answers 01:00:5E, bit 23 forced 0, low 23 bits from the address; no cache query, no request | §6.1 | 239.1.2.3 → 01:00:5E:01:02:03 and 239.129.2.3 → the same MAC, which is what exercises the 23-bit mask |
| REQ-510 | at most one pending reply **anywhere in the ARP family**: the window runs from generation to the acceptance of the reply frame's `tlast` word, so a reply held inside M11 is still pending here (repair R-1). A second is discarded with one strobe; the receive path cannot be stalled because it has no `tready` | §6.1, §6.2 (A), §9 | §8 item 2's collision run — **two** requests, exactly one `error_arp_reply_dropped` high cycle, the first reply transmitted when M09 frees. A bench SHALL NOT assert that a third request is needed to produce the first drop: that is the pre-R-1 mechanism and no conformant design has it |
| REQ-511 | no separate rule: the reply predicate fires for a gratuitous ARP exactly when its address is `cfg_local_ip`, and REQ-503 learns from it either way | §6.1 | gratuitous ARPs for a foreign address and for the local address: cache updated in both, reply only in the second |
| REQ-512 | the same predicate in the negative: a request for any other address gets no reply, while learning still happens | §6.1 | three foreign-address requests: no transmit activity, cache entries present |
| REQ-802, REQ-803 | four configuration inputs, each with its sampling event named; receive and transmit sampled independently | §4.3 | change `cfg_local_ip` between two requests and assert the reply predicate follows it at the next packet, not the one in flight |
| REQ-810 | no instance at M13's ports — `cfg_tx_enable` is M04's — and REQ-810's ARP clause is a **consequence clause**, not an independent obligation (§11.2, dv_lead's Q3 answer). It is realised through the backpressure chain: with transmit disabled M04 holds `tx_tready` low, M09 never grants, M11's first payload word is never accepted, so under R-1 the first reply stays pending inside M11 and **every later reply** is dropped under REQ-510 | §11.2 | drive `cfg_tx_enable` = 0, inject **two** requests, assert exactly one `error_arp_reply_dropped` high cycle; re-enable and assert the first reply transmits, late. The residual is disclosed rather than hidden: that first reply **is** transmitted after re-enable, which is REQ-810's plain reading minus a single frame |
| REQ-901 | declared divergence classes **(b)** and **(c)** live here: direct-mapped versus LRU (eviction order not compared) and discard-on-miss versus queued resolution (post-miss transmit behaviour not compared) | header, §2 | the co-simulation report names both classes against this module |
| REQ-903, REQ-808 | `arp` is a distinct emitted module with `create`, `hierarchical` and an `.mli`, and it instantiates `arp_eth_rx`, `arp_eth_tx` and `arp_cache` as distinct hierarchical modules | §4.1 | repository surface check and the `rtl_snapshots/` name comparison |

This table is the source of M13's rows in [`traceability.md`](../traceability.md),
updated in the same commit.

## 11. Deferred items

Item numbers are permanent; a closed item keeps its row (SPEC-TEMPLATE §11).

| # | Item | Status · what a reader assumes meanwhile | Tracked as | Owner | Closes by |
|---|---|---|---|---|---|
| 11.1 | **The `ifc_check` compile evidence for this lift is pending**: `arp_ifc.ml` is new in this commit, declares two records, opens three other lifts and is the widest record batch D adds. | **CLOSED (WO-0017).** CI `build` run **30736107842** at 2f29888 reports `success` with all four batch-D lifts in it, and `git diff a9993ff 2f29888 -- docs/specs/` is **empty**, so the run elaborated byte-identically the text drafted at a9993ff. The three-deep `open!` chain and the two-record declaration are established by a run, and SPEC-M15's lift now opens this one for `Arp_query` and `Arp_response` (batch E). | the `Interface compile check` row of §12 | architect_docs_lead, rtl_lead | closed |
| 11.2 | **REQ-810's ARP clause reads as though every reply generated while transmit is disabled is dropped**, and the mechanism this specification states drops the **second and later** ones while the first waits inside M11 until transmit is re-enabled. Dropping the first would need a `cfg_tx_enable` input at M13 that architecture.md §6.4.3 does not route here. | **CLOSED (WO-0017), affirmatively: CONSEQUENCE CLAUSE, NOT AN INDEPENDENT OBLIGATION. No `cfg_tx_enable` at M13. NOT breaking.** dv_lead answered it decisively at the batch-D countersignature (`J-dv_lead-0008`, WO-0015 Return log §4/Q3) on three grounds. (i) **REQ-810's own verification column does not test it** — it drives `transmit enable` = 0, issues an *application* transmit request and checks the wire and `tready`, with not one word about ARP replies or `error_arp_reply_dropped`; under requirements.md §0.2 the verification column is where a REQ's testable fact lives, so a clause with no test in its own column, in a document where every other clause has one, is an explanatory pointer — and this one points, by naming REQ-510 as the governing requirement. (ii) **The alternative does not work as a port addition**: `cfg_tx_enable` at M13 cannot retract a reply already inside M11, so the drop-all reading would need a second port at M11 or a rule that M13 refuses to *generate* while disabled — a larger change than "one input", and one that would have to be re-derived for M15 and M18. (iii) **The residual hazard is nil**: a late ARP reply carries our own MAC for our own IP and cannot go stale the way a buffered *datagram* can, which is what architecture.md §2.5 and REQ-505 exist to prevent. **The residual is stated so nobody can later say it was hidden**: with transmit disabled, exactly one reply survives — held inside M11 — and it **is transmitted, late, when transmit is re-enabled**; every reply generated meanwhile is dropped with `error_arp_reply_dropped` under R-1's window, which is REQ-810's plain reading minus a single frame, obtained with no port. requirements.md REQ-810's clause is reworded to say that rather than "is dropped under REQ-510", which was false of the first reply. | this item; requirements.md REQ-810 | architect_docs_lead, dv_lead | closed |
| 11.3 | **A miss for a target different from the outstanding one replaces the resolution**, and no REQ decides that case: REQ-505 constrains only the same-target case. §6.1 states the rule and its rejected alternative (a per-slot table of outstanding resolutions). | **CLOSED (WO-0017), affirmatively: SPECIFICATION DECISION, correctly made and correctly placed. No requirements.md diff is owed.** dv_lead's answer (`J-dv_lead-0008`, WO-0015 Return log §4/Q4): REQ-505's testable fact is duplicate suppression for the **same** target, a different-target rule is a second fact that would need its own REQ, so REQ-505's silence is correct scope rather than omission (requirements.md §0.2); the programme already has the device for an unconstrained corner in every spec's §6.3 opening sentence; and the decision is fully derivable here — §6.2 machine (B)'s three rows are complete for it and §6.3 item 4 states explicitly that which target ends up outstanding is *constrained*, not free. **The one sentence dv_lead requires added, because a bench writer needs it and it was not in the document:** replacement means an application alternating between two unresolved destinations defeats REQ-505's suppression entirely — every miss replaces the outstanding target, so **every miss issues a request**, bounded only by M11's five-cycle packet period. That is **not** a defect in Phase 1: architecture.md §5 has one application client and REQ-505's and REQ-809's stimuli each use one destination. But a test writer who sees one broadcast request per datagram must be able to tell that it is **conformant**, which is what this sentence is for. It is also the precise trigger for revisiting the per-slot table rejected in §6.1: **more than one concurrent application destination**, which is a Phase-2/3 condition and not a Phase-1 one. | this item; requirements.md REQ-505 | architect_docs_lead, dv_lead | closed |
| 11.4 | **Both transmit relays are combinational** (§7), so the M11 → M13 → M09 → M07 path and the `payload_tready` path back through it are longer than SPEC-M09 §11.2's estimate, which counted M09's mux alone. | **DEFERRED — nothing in Phase 1 depends on closing them.** REQ-018 keeps the XGMII boundary simulation-only and no static timing closure at 6.4 ns is required, so a reader builds the combinational relay today. If a later phase cannot close the path, the remedy is SPEC-M09 §11.2's: a spec diff plus an ADR restating the cadence, never a quiet register — a register here would change REQ-406's measured grant delay and REQ-502's derivation in §6.1 at the same time. | this item; SPEC-M09 §11.2 | architect_docs_lead, rtl_lead | Phase-3 attach, or the first synthesis attempt |
| 11.5 | **`Arp_query` and `Arp_response` are declared here rather than in M01**, for the reason SPEC-M10 §11.2 states, and M15 (batch E) will open this module for them. | **DEFERRED — the placement is decided, buildable and now exercised.** A reader implements exactly that. SPEC-M15 §4.1 (batch E, WO-0017) writes `open! Arp_ifc` and restates neither record, and the RTL references `Arp.Arp_query`; the declare-once rule therefore has its first cross-batch instance and it needed no change. If a later phase reopens M01, the batch-D records may be promoted there by one spec diff plus an ADR, which is a rename and not a behavioural change. | SPEC-M10 §11.2; SPEC-M01 §4.1 | architect_docs_lead, rtl_lead | SPEC-M20 (batch F) |
| 11.6 | **R-2 was the rejected repair for D-1**, and the appeal record belongs in the specification rather than only in a journal: keep the drop-second-hold-first mechanism and move the four counts from two to three, weakening REQ-510's normative sentence to "at most one reply pending at the resolver **and** at most one further reply already accepted for transmission". | **CLOSED at the moment it was opened (WO-0017) — recorded, not deferred.** R-2 was rejected on dv_lead's ground and on one of the architect's. dv's: it weakens a normative **ERR** requirement to match a decomposition, and leaves the module holding a stale reply two deep. The architect's: R-2 costs a requirements.md **behavioural** diff to REQ-510 (normative sentence and verification column) plus four spec-side count changes, where R-1 costs one state and one clause and makes all four counting sites correct **as written** — so the cheaper repair is also the one that leaves fewer documents to keep in step. R-1 was verified free in the unblocked case by dv_lead before recommending it (an unblocked reply's frame completes five cycles after acceptance; two accepted requests are ≥ 10 cycles apart at REQ-004's rate) and re-derived here in §6.1. Recorded permanently because a countersignature and a work-order log both cite D-1 by name, and a reader who finds only the winner cannot check the choice. | this item; WO-0015 Return log §3 | architect_docs_lead | closed |

## 12. Freeze record

Filled in at `P1-spec-freeze`. All four rows are required (charter §5); this
spec is DRAFT.

| Item | Value |
|---|---|
| Interface compile check | CI `build` run **30736107842**, conclusion **`success`**, SHA **2f29888** — all thirteen lifts elaborate, the four batch-D lifts for the first time; per ADR-0005 a local build is not acceptable evidence. `git diff a9993ff 2f29888 -- docs/specs/` is empty, so the run witnesses the text drafted at a9993ff, and **§4.1 is byte-for-byte unchanged by the D-1 and D-2 repairs**, so it still witnesses this revision's interface. This run is also §11.1's closure record |
| Architect signature | `J-architect_docs_lead-0006`; the D-1 (R-1) and D-2 (D-2a) repairs `J-architect_docs_lead-0007` |
| dv_lead testability countersignature | pending — **CONTESTED at a9993ff** (`J-dv_lead-0008`, WO-0015 Return log §1, §3) on D-1 and D-2, both repaired in the commit carrying this row. dv_lead's re-review surface, stated in advance: the D-1 and D-2 landing sites, the byte-identity and set-equality checks, and a green `ifc_check` run at the new SHA. It will **not** re-derive §2's arithmetic — Q + 2, the REQ-502 chain, the multicast masking, the class precedence and the retry counts are recomputed, correct and signed off there, and only the chain's total moves, by the one cycle §6.1 derives |
| Frozen at | pending — SHA `<sha>`, gate `docs/gates/P1-spec-freeze-checklist.md` |

## 13. Change log

Post-freeze changes only. This spec is DRAFT and has none — which is the whole
point of the cycle that produced this revision. **D-1 and D-2 both change state
and both change an observable**, so freezing batch D first and repairing after
would have converted two pre-freeze corrections into the programme's first
behavioural post-freeze diffs, which is precisely what the countersignature gate
exists to prevent (`J-dv_lead-0008`). The repairs are recorded in §11.2, §11.3
and §11.6 and in requirements.md §13's revision rows; ADR-0009 carries D-2's
decision and its rejected alternative.

| Date | Change | Breaking? | ADR | Journal |
|---|---|---|---|---|
| — | — | — | — | — |
