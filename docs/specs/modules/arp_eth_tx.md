# SPEC-M11 — `Arp_eth_tx`

- **Status**: **FROZEN** (`P1-spec-freeze`, SHA `3f6accc`) — batch D, dv_lead
  countersignature `J-dv_lead-0009` (WO-0018); this specification was already
  **SIGNED** on its own merits at a9993ff (`J-dv_lead-0008`, WO-0015 Return log
  §1). Changes to §4, §6 or §7 after this point are spec diffs recorded in §13
  (SPEC-TEMPLATE rule 7)
- **Inventory id**: M11 (architecture.md §4) · **Path**:
  `libs/hardcaml_ethernet/src/arp_eth_tx.ml`
- **Datapath role**: transmit
- **Owns REQs**: REQ-502 (the packet-construction half)
- **Prior-art counterpart**: `arp_eth_tx.v` (MIT) — consulted for decomposition
  and port naming only; behaviour below is stated independently and no source
  was copied
- **Depends on specs**: SPEC-M01 (`Axi64`, `Eth_header`), SPEC-M10
  (`Arp_eth_rx`, which declares `Arp_packet`), SPEC-M09 (`Eth_arb_mux`, the
  consumer of the frame M11 offers, through M13's relay ports), ADR-0008 (the
  transmit-side header handshake)
- **Author**: architect_docs_lead, journal `J-architect_docs_lead-0006`

## 1. Purpose

M11 is M10 run backwards: it takes an **ARP packet record** and emits an
Ethernet **header record** plus a **payload stream** of exactly 28 octets — the
RFC 826 packet, with the four constant fields written from the requirement
rather than carried in the record. It exists as a separate module so that M13,
which decides *what* to say, never has to know *where the octets go*: the entire
knowledge of ARP's wire format lives in M10 (reading) and M11 (writing), in two
tables that are transposes of each other.

Its upstream is M13 `Arp`, which supplies the packet; its downstream is M09
`Eth_arb_mux` (through M13's `tx_hdr` and `tx_payload` relay ports,
architecture.md §6.4.2), which arbitrates it against the IPv4 transmit source.
It instantiates nothing.

## 2. Scope

**In scope.**

- Emitting the 28 ARP octets in RFC 826 wire order from an `Arp_packet` record:
  the four constant fields as constants and the five carried fields at their
  octet offsets (§6.1, REQ-502).
- Building the `Eth_header` record that accompanies them — destination MAC,
  source MAC, ethertype 0x0806 — and in particular deriving the **destination**
  from the operation: unicast to the target hardware address for a reply,
  broadcast for a request (§6.1, REQ-502, REQ-505).
- The source-side obligations of the transmit-header handshake (ADR-0008
  decisions 1, 2 and 4) at its output, and the consumer side of the same
  discipline at its `arp` input, with the one substitution §7 states.
- Backpressure in both directions: accepting a packet only when it can be
  offered, and offering a payload word only when it can be accepted.

**Not this module's job.**

| Behaviour a reader might expect here | Owner |
|---|---|
| Deciding whether to send a reply or a request, what to put in the fields, and to whom | M13 `Arp` (REQ-502, REQ-505 … REQ-512). M11 puts on the wire exactly what the record says and asks nothing |
| The fourteen Ethernet header octets as *frame octets*, and the realignment they force | M07 `Eth_axis_tx` (REQ-405). M11 emits a header **record** and a payload; the octets appear on a stream two modules later |
| Padding the 42-octet Ethernet frame to 60 octets, the preamble, the FCS, the gap | M04 `Xgmii_tx_64` (REQ-201 … REQ-205). An ARP frame is 14 + 28 = 42 octets and is padded to 60 by M04 (REQ-203); nothing here counts to 60 |
| Choosing between the ARP and IPv4 transmit sources | M09 `Eth_arb_mux` (REQ-406). M11 requests by the handshake of §7 and is granted by having its first payload word accepted (ADR-0008) |
| Dropping a reply that cannot be sent | M13 (REQ-510). M11 holds one packet and refuses the next by `arp_ready` = 0; the *decision* to discard is M13's |
| Reporting anything | nobody: M11 owns no strobe and detects no condition (§9) |

## 3. Programme invariants that bind this module

M11 is **not** a receive-path module under requirements.md §0.4: it is on the
transmit chain, its `arp_ready` towards M13 is legitimate, and §1.1 allocates it
no latency ceiling.

| REQ | Consequence for M11 |
|---|---|
| REQ-001 | One `clock`, shared with the receive path (REQ-018 keeps the XGMII boundary simulation-only, so there is no second domain). |
| REQ-002 | The payload output is a 64-bit `Axi64` stream, at most one word per cycle. |
| REQ-003 | Does not bind M11's ports — but REQ-208 does: nothing here may reach back into the receive datapath, and nothing does, because M11 has no receive-side port. Its `arp_ready` reaches M13's *transmit* logic only, and M13 §7 states that the receive relay through it is untouched. |
| REQ-005 | Does not bind M11 (not a receive-path module). Its analogue is §7's pinned one-cycle constant, which no requirement obliges but which is stated so that REQ-502's response deadline composes from named numbers. |
| REQ-007, REQ-013 | No instance: M11 **originates** every frame it emits, so there is no inherited `tuser`[0] to carry. `payload_tuser` is driven to 0 on every word, `tlast` included (§4.2). |
| REQ-008 | M11 owns **no** strobe: it detects no condition (§9). |
| REQ-009 | Synchronous `clear`: `hdr_valid` = 0, `payload_tvalid` = 0 and `arp_ready` = 0 while `clear` = 1 and on the first cycle after; a frame in flight is abandoned with no `tlast` (§7). |
| REQ-010 | The payload output is the programme `Axi64.Source` with the matching `Axi64.Dest` in the other direction — the transmit-path pattern of architecture.md §2.3. The header is SPEC-M01's `Eth_header` and the packet is SPEC-M10's `Arp_packet`, both unchanged. |
| REQ-011 | `payload_tkeep` is `0xFF` on words 0 to 2 and **`0x0F`** on word 3, which carries ARP octets 24–27 — four contiguous ones from bit 0. Never 0 with `tvalid` = 1. |
| REQ-012 | Every field is emitted first wire octet first: `sender_mac`[47:40] is ARP octet 8, `sender_ip`[31:24] is ARP octet 14. The four constants are emitted in the same order (§6.1). |
| REQ-014 | `payload_tstrb` is driven to 0. |
| REQ-015 | One `tlast` per frame, on payload word 3. Exactly **four words per packet**, the `tlast` word included in that count (REQ-015's own counting convention, carry-forward C-11) — an ARP payload has no variable length. Not four *intervening* words between two `tlast` words, which is what the earlier wording read as and which §6.1's table and §10's REQ-015 hook have always contradicted (dv_lead, WO-0015 Return log §6 item 3). |
| REQ-016 | M11 **never** deasserts `payload_tvalid` inside a frame: all 28 octets are in registers before the offer is asserted (§6.1), so there is nothing to wait for. REQ-016's tolerance is therefore never exercised on this port, which is a property a bench may assert rather than a promise it must allow for. |
| REQ-019 | No instance: M11 is not on the chain REQ-006 measures and §1.1 allocates it nothing. Its storage is the 28 octets of one packet, which is the packet itself and not a buffer of frames. |
| REQ-020 | Packets leave in the order M13 offered them; M11 holds one at a time (§6.2), so reordering is not expressible. |
| REQ-021 | Producer-side word alignment: ARP octet 0 is at `payload_tdata`[7:0] of payload word 0, always. M11 performs no realignment — the misalignment the Ethernet header causes is M07's, one module downstream (SPEC-M07 §6.1). |

## 4. Interface

### 4.1 Interface records

```ocaml
(* SPEC-M11 §4.1, lifted verbatim into docs/specs/ifc_check/arp_eth_tx_ifc.ml
   (SPEC-TEMPLATE.md rule 6). Records and signatures only — no logic, no
   implementation.

   [Axi64_ifc] is M01's types home (SPEC-M01 §4.1): [Axi64] and
   [Eth_header] come from there. [Arp_eth_rx_ifc] is where SPEC-M10 §4.1
   declares [Arp_packet], because M01 is FROZEN and a record added there
   would be a breaking post-freeze interface change; the rule batch D
   adopts is that such a record is declared once, at the module that
   produces it, and opened by every consumer (SPEC-M10 §4.1, §11.2).
   M11 restates nothing.

   Transmit-path module, so [Source] one way and [Dest] the other on the
   one logical stream: the payload stream's [Source] is an output and
   its [Dest] an input. Both directions share the "payload_" prefix with
   no collision, because [Source]'s field names and [Dest]'s are
   disjoint (SPEC-M04 §4.1 fixes that pattern).

   [arp_ready] is a bare output bit and not a field of a [Dest] record.
   ADR-0008's acceptance event — the acceptance of the frame's first
   payload word — does not exist at this port, because the [Arp_packet]
   M11 consumes has no payload stream travelling with it: M11 GENERATES
   the payload. §7 states the substitution and §11.3 flags it for
   dv_lead. [hdr] carries no [ready] for ADR-0008's own reason. *)

open! Base
open Hardcaml
open! Axi64_ifc
open! Arp_eth_rx_ifc

module I = struct
  type 'a t =
    { clock : 'a
    ; clear : 'a
    ; arp : 'a Arp_packet.t [@rtlprefix "arp_"]
    ; payload_dest : 'a Axi64.Dest.t [@rtlprefix "payload_"]
    }
  [@@deriving hardcaml]
end

module O = struct
  type 'a t =
    { arp_ready : 'a
    ; hdr : 'a Eth_header.t [@rtlprefix "hdr_"]
    ; payload : 'a Axi64.Source.t [@rtlprefix "payload_"]
    }
  [@@deriving hardcaml]
end

module type S = sig
  val create : Scope.t -> Signal.t I.t -> Signal.t O.t
  val hierarchical : ?instance:string -> Scope.t -> Signal.t I.t -> Signal.t O.t
end

(* REQ-010 type identity in both directions of the one stream, and that
   [Arp_packet] here is the same type SPEC-M10 §4.1 declares. *)

let _witness_both_directions
      (s : Signal.t Axi64.Source.t)
      (d : Signal.t Axi64.Dest.t)
  =
  s, d
;;

let _witness_arp_packet_is_m10s (p : Signal.t Arp_packet.t) = p
```

Conformance of this block to the template's rules for §4.1:

- Scalar fields carry `[@bits n]` unless one bit wide: `clock`, `clear` and
  `arp_ready` are one bit; every other field is inside a nested record carrying
  its own widths.
- Nested interfaces carry `[@rtlprefix]`: `arp` emits `arp_valid` …
  `arp_target_ip`, `hdr` emits `hdr_valid` … `hdr_ethertype`, and `payload` and
  `payload_dest` emit `payload_tvalid` … `payload_tuser` and `payload_tready`.
- **`Source` one way and `Dest` the other, on the one logical stream**: held.
  M11 is allowed both because it is not a receive-path module (requirements.md
  §0.4); REQ-208, not REQ-003, is what keeps its backpressure away from the
  receive datapath, and REQ-208 holds structurally because M11 has no receive
  port at all.
- Both `create` and `hierarchical` are declared (REQ-903, REQ-808).

### 4.2 Port table

Every port in §4.1 appears exactly once. Direction is with respect to M11.

| Port | Dir | Width | Meaning | REQ |
|---|---|---|---|---|
| `clock` | in | 1 | 156.25 MHz single domain | REQ-001 |
| `clear` | in | 1 | synchronous clear | REQ-009 |
| `arp_valid` | in | 1 | a packet is offered; **held** until `arp_ready` = 1 (§7) | REQ-502 |
| `arp_operation` | in | 16 | 1 request or 2 reply; emitted at ARP octets 6–7 **and** used to derive the Ethernet destination (§6.1) | REQ-502, REQ-505 |
| `arp_sender_mac` | in | 48 | emitted at ARP octets 8–13 **and** as `hdr_src_mac` | REQ-502, REQ-012 |
| `arp_sender_ip` | in | 32 | emitted at ARP octets 14–17 | REQ-502, REQ-012 |
| `arp_target_mac` | in | 48 | emitted at ARP octets 18–23; also `hdr_dst_mac` when the operation is 2 | REQ-502, REQ-012 |
| `arp_target_ip` | in | 32 | emitted at ARP octets 24–27 | REQ-502, REQ-012 |
| `payload_tready` | in | 1 | the consumer accepts a payload word this cycle | REQ-207 (one stage up) |
| `arp_ready` | out | 1 | M11 accepts the offered packet this cycle; an accepted packet is always transmitted | REQ-502 |
| `hdr_valid` | out | 1 | a frame is offered; asserted together with payload word 0's `tvalid` and held until that word is accepted (ADR-0008) | REQ-405, ADR-0008 |
| `hdr_dst_mac` | out | 48 | `arp_target_mac` for operation 2, `ff:ff:ff:ff:ff:ff` for operation 1 (§6.1) | REQ-502, REQ-505 |
| `hdr_src_mac` | out | 48 | `arp_sender_mac`, which M13 has already set to the configured local MAC | REQ-502 |
| `hdr_ethertype` | out | 16 | constant **0x0806** | REQ-404, REQ-502 |
| `payload_tvalid` | out | 1 | this cycle carries a payload word; never deasserted inside a frame (§3, REQ-016) | REQ-016 |
| `payload_tdata` | out | 64 | ARP octets, octet 0 at position 0 of word 0 | REQ-012, REQ-021 |
| `payload_tkeep` | out | 8 | `0xFF` on words 0–2, `0x0F` on word 3 | REQ-011 |
| `payload_tstrb` | out | 8 | reserved; driven to 0 | REQ-014 |
| `payload_tlast` | out | 1 | 1 on word 3 only | REQ-015 |
| `payload_tuser` | out | 1 | driven to **0** on every word: M11 originates the frame and inherits no abort | REQ-013, REQ-007 |

### 4.3 Configuration inputs

**None.** M11 reads no field of the `Config` record. Every value it puts on the
wire arrives in the `Arp_packet` record: the configured local MAC reaches the
frame as `arp_sender_mac`, filled in by M13, which is the module that holds
`cfg_local_mac` (architecture.md §6.4.3). Concentrating configuration at the
module that *decides* a field rather than at the module that *emits* it is the
convention SPEC-M07 §4.3 states for the same reason — and it means REQ-803 has
no instance here, since there is no configuration input whose change could land
inside a frame.

## 5. Parameters

**None.** REQ-506's rule has no instance: M11 has no timeout, no ageing interval
and no retry. Its numeric constants — 1, 0x0800, 6, 4, 0x0806, 28 — are pinned
by REQ-501 and REQ-502, and making any of them overridable would let a test
configure a packet format the programme does not have.

| Parameter | Type | Default | Range | Why a test overrides it |
|---|---|---|---|---|
| (none) | — | — | — | — |

## 6. Behaviour

### 6.1 Normal path

**The ARP packet M11 writes**, with the octet offsets a test writer needs to
hand-assemble the reference packet REQ-502 compares against. Offsets are from
the first octet M11 emits, which is the first octet after the ethertype on the
wire. This table is the transpose of SPEC-M10 §6.1's.

| Field | Octet offset | Width | Source | Wire order |
|---|---|---|---|---|
| hardware type | 0–1 | 16 bits | **constant 1** (REQ-501) | 0x00 then 0x01 |
| protocol type | 2–3 | 16 bits | **constant 0x0800** (REQ-501) | 0x08 then 0x00 |
| hardware address length | 4 | 8 bits | **constant 6** (REQ-501) | 0x06 |
| protocol address length | 5 | 8 bits | **constant 4** (REQ-501) | 0x04 |
| operation | 6–7 | 16 bits | `arp_operation` | most significant octet first: operation 2 emits 0x00 then 0x02 |
| sender hardware address | 8–13 | 48 bits | `arp_sender_mac` | `arp_sender_mac`[47:40] is octet 8 |
| sender protocol address | 14–17 | 32 bits | `arp_sender_ip` | `arp_sender_ip`[31:24] is octet 14 |
| target hardware address | 18–23 | 48 bits | `arp_target_mac` | `arp_target_mac`[47:40] is octet 18 |
| target protocol address | 24–27 | 32 bits | `arp_target_ip` | `arp_target_ip`[31:24] is octet 24 |

**The four constants are written here and not carried in the record**, which is
SPEC-M10 §4.1's decision seen from the other side: REQ-501 fixes each to one
value, so a packet M11 builds is REQ-501-acceptable by construction and a
loopback through M10 must accept it. That loopback is the cheapest test of both
tables at once (§10).

**The Ethernet header M11 builds**, and the one derivation in this module that
is not a copy:

| Field | Value | Why |
|---|---|---|
| `hdr_dst_mac` | `arp_target_mac` when `arp_operation` = **2**; `ff:ff:ff:ff:ff:ff` when `arp_operation` = **1** | REQ-502 requires a reply to be unicast to the requester's hardware address, which M13 puts in `target_mac`; REQ-505 requires a request to be broadcast, and RFC 826 leaves a request's target hardware address unused — M13 sets it to `00:00:00:00:00:00` (SPEC-M13 §6.1), which is not an address a frame may be sent to |
| `hdr_src_mac` | `arp_sender_mac` | REQ-502: the sender hardware address of a reply is the configured local MAC, and M13 has already put it there |
| `hdr_ethertype` | 0x0806 | REQ-404's ARP ethertype; a constant, never read from the record |

No other operation value can reach this port: an `Arp_packet` M13 offers carries
1 or 2 (SPEC-M13 §6.1), and on the receive side REQ-501 admits no other. §6.3
item 3 records what M11 does with anything else — nothing that a bench may
assert.

**Where the octets land.** Four payload words, always:

| Payload word | Positions 0 … 7 | `tkeep` | `tlast` |
|---|---|---|---|
| 0 | 0x00, 0x01, 0x08, 0x00, 0x06, 0x04, operation[15:8], operation[7:0] | 0xFF | 0 |
| 1 | `sender_mac` octets 0–5, `sender_ip`[31:24], `sender_ip`[23:16] | 0xFF | 0 |
| 2 | `sender_ip`[15:8], `sender_ip`[7:0], `target_mac` octets 0–5 | 0xFF | 0 |
| 3 | `target_ip`[31:24], `target_ip`[23:16], `target_ip`[15:8], `target_ip`[7:0] | **0x0F** | **1** |

**The offer (ADR-0008, source side).** A frame is offered by asserting
`hdr_valid` = 1 **and** `payload_tvalid` = 1 for payload word 0 **on the same
cycle**, and holding both — with all three header fields and word 0's contents
stable — until that word is accepted (`payload_tready` = 1). M11 may drop
`hdr_valid` on the next cycle and does. This is ADR-0008 decisions 1 and 2
restated as that ADR's Consequences require of every batch-D source, and
decision 4 is satisfied structurally: an ARP frame always carries 28 payload
octets, so M11 can never offer a header with no payload word.

**On an unstalled frame** (`payload_tready` = 1 throughout), with A the cycle on
which M11 accepts the packet (`arp_valid` = 1 and `arp_ready` = 1):

| Cycle | `arp_ready` | Input | Output |
|---|---|---|---|
| A | 1 | `arp_valid` = 1, five fields stable | `hdr_valid` = 0, `payload_tvalid` = 0 |
| A+1 | 0 | — | **offer**: `hdr_valid` = 1 with the three header fields; payload word 0 (ARP octets 0–7); accepted this cycle |
| A+2 | 0 | — | payload word 1 (ARP octets 8–15); `hdr_valid` = 0 |
| A+3 | 0 | — | payload word 2 (ARP octets 16–23) |
| A+4 | 0 | — | payload word 3 (ARP octets 24–27), `tkeep` = 0x0F, `tlast` = 1, `tuser` = 0 |
| A+5 | 1 | the next packet may be offered | `payload_tvalid` = 0 |

Five cycles from acceptance to acceptance at best, which is what §7's REQ-502
derivation composes with M09, M07 and M04.

**When the consumer stalls.** M09 grants by accepting payload word 0; until
then M11 holds the offer unchanged, which is exactly ADR-0008 decision 2's
requirement on a source and is why an arbiter can make a port wait without
losing its header. A cycle with `payload_tready` = 0 holds every word index and
every register: nothing is dropped and nothing is duplicated, and every cycle
formula above shifts by exactly the number of stalled cycles. `arp_ready`
remains 0 throughout, so M13 cannot lose a packet by presenting it while M11 is
busy — it simply is not accepted, and M13 holds the offer (§7's substitution).

**What `arp_ready` is not.** It is **not** the event REQ-510 keys on. M13's
pending window runs from the cycle a reply is generated to the cycle **this
module's payload `tlast` word is accepted** — the reply's frame completing, not
its record being taken (SPEC-M13 §6.1, repair **R-1** under WO-0017). A reader
who inferred the drop rule from `arp_ready` alone would count one reply pending
where in fact M13 holds one and M11 holds another, which is the two-deep reading
dv_lead raised as owed diff **D-1**. M11's own behaviour is untouched by that
repair: it accepts a packet when it is free, refuses while it is busy, and
decides nothing about a reply.

### 6.2 State machine

Reset state and `clear` state are both `Idle`.

| State | Entered when | Does | Leaves to |
|---|---|---|---|
| `Idle` | reset; `clear`; the cycle after payload word 3 is accepted | `arp_ready` = 1; `hdr_valid` = 0; `payload_tvalid` = 0 | `Offer` on the cycle a packet is accepted (`arp_valid` = 1 and `arp_ready` = 1), capturing the five fields and computing the three header fields |
| `Offer` | a packet is accepted | asserts `hdr_valid` and payload word 0 together and holds both, with every field stable, until word 0 is accepted (ADR-0008); `arp_ready` = 0 | `Body` on the cycle payload word 0 is accepted |
| `Body` | payload word 0 has been accepted | emits payload words 1, 2 and 3 on the cycles they are accepted, word 3 carrying `tkeep` = 0x0F and `tlast` = 1; `hdr_valid` = 0; `arp_ready` = 0 | `Idle` on the cycle after payload word 3 is accepted |

A cycle on which `payload_tready` = 0 holds every state and every register: it
is not a condition and it advances nothing (§6.1).

### 6.3 Deliberately unconstrained

Anything not listed here is constrained by this specification, and a test may
rely on it.

1. **The placement of the register levels** inside the one-cycle delay, and
   every internal encoding: the FSM encoding, whether the packet is held as one
   224-bit register or five, whether the four words are selected by a multiplexer
   or shifted. §7's constant is what is fixed.
2. **The value of `payload_tdata` at positions where `payload_tkeep` is 0** —
   positions 4 to 7 of word 3 — and every output field on a cycle with
   `payload_tvalid` = 0, and the three header fields on a cycle with
   `hdr_valid` = 0 (SPEC-M01 §6.3 item 5). No monitor may read them.
3. **M11's behaviour when `arp_operation` is neither 1 nor 2.** No conformant
   source offers one: M13 emits 1 for a request and 2 for a reply and nothing
   else (SPEC-M13 §6.1), and on the receive side REQ-501 rejects every other
   value before it can be learned from. The case is unreachable rather than
   undefined, no requirement names it, and DV SHALL assert nothing about the
   destination MAC M11 would then emit. This is the wording SPEC-M07 §6.3
   item 3 and SPEC-M09 §6.3 item 4 use, and SPEC-M08 §6.3 item 5 adopted at
   carry-forward C-17(c).
4. **M11's behaviour when a source violates ADR-0008** — changing a field while
   `arp_valid` is held, or deasserting `arp_valid` before `arp_ready` = 1. No
   conformant source does either (SPEC-M13 §7 restates the obligation), no
   requirement names the case, and DV SHALL assert nothing about it.

## 7. Timing contract

- **Latency.** Pinned at **1 cycle**: the frame is offered on the cycle after
  M11 accepts the packet. In requirements.md §0.5's octet times, with the two
  measurement events named explicitly:

  > **input event** — the octet time of ARP octet 0 at the `arp` port, which is
  > position 0 of the acceptance cycle A, that is 8·A;
  > **output event** — the octet time of ARP octet 0 on the `payload` stream,
  > which is position 0 of payload word 0's cycle, that is 8·(A + 1).

  | Quantity | Value |
  |---|---|
  | L (octet times) | **8** |
  | h (octet times) | **0** |
  | Word delay ΔC = (L + h)/8 | **1** cycle |
  | §1.1 ceiling | **none** — M11 is a transmit-path module |

  h is 0 because M11 removes nothing from the front of what it measures and its
  output is word-aligned (REQ-021), so both of §0.5's terms are 0. (L + h) = 8,
  a multiple of 8. The fourteen Ethernet header octets M11 causes to exist are
  **not** an insertion at this port: they leave on the `hdr` record, and they
  become frame octets two modules later at M07, whose §7 owns their arithmetic.

  Measured with `payload_tready` held 1 throughout, exactly as SPEC-M07 §7
  measures its own constant. A downstream stall delays everything by the number
  of stalled cycles and is outside this constant's domain. **No requirement
  constrains the value** — only that this specification states one, so that
  REQ-502's deadline composes from named numbers rather than from a simulation.

- **Throughput.** One payload word emitted per cycle while `payload_tready` is
  1, four words per packet, always. One packet accepted per five cycles at best
  (§6.1). M11 never emits two words in one cycle and never accepts two packets.

- **Handshake rules — the ADR-0008 substitution, stated here and nowhere else.**
  ADR-0008's acceptance event for a header record is "the acceptance of the
  frame's first payload word". At M11's **output** that event exists and the ADR
  binds verbatim: decisions 1, 2 and 4 are restated in §6.1 and are M11's
  obligation as a source.

  At M11's **input** it does not exist: the `Arp_packet` M13 offers has **no
  payload stream travelling with it**, because M11 is what generates the
  payload. The ADR's discipline is therefore applied with one substitution:

  > the acceptance event at the `arp` port is **`arp_valid` = 1 and
  > `arp_ready` = 1**, and ADR-0008 decisions 2 and 3 apply against that event
  > verbatim — M13 holds `arp_valid` and all five fields stable until the
  > acceptance cycle and may drop `arp_valid` on the next; M11 captures on the
  > acceptance cycle.

  Decision 1 — "offered together with the first payload word" — has no instance
  and is not claimed. Decision 4 — no header without a payload word — is
  satisfied on the output side structurally and needs no restatement on the
  input side, where there is no header. §11.3 flags the substitution for
  dv_lead: this specification reads it as an *instantiation* of ADR-0008 in a
  place the ADR anticipated ("SPEC-M11, SPEC-M15 and SPEC-M18 must each restate
  decisions 1, 2 and 4 in their own §7"), not as a supersession of it.

  **`Arp_packet`'s `valid` is a level here, not a pulse.** This is the opposite
  discipline to SPEC-M10 §7, where REQ-401's receive-side rule makes it a
  one-cycle pulse. Both are correct for their direction — a receive-path record
  cannot carry a `ready` without violating REQ-003, and a transmit-path record
  needs an acceptance event — and the direction of a port is what says which
  applies. A monitor written for one and attached to the other reports a defect
  that is not there. **A transmit-side monitor keys on the acceptance event and
  never on a `valid` edge** (ADR-0008's Consequences, carry-forward C-17(d)).

- **Reset.** While `clear` = 1 and on the first cycle after it returns to 0:
  `hdr_valid` = 0, `payload_tvalid` = 0 and `arp_ready` = 0. `clear` asserted
  mid-frame abandons the frame with **no** `tlast` word — the frame simply
  stops, which is REQ-009's explicit permission and is the only silent frame
  loss in this specification; M04 is in the same reset and emits idle
  (SPEC-M04 §7). A packet **presented** on the first cycle after `clear` returns
  to 0 is transmitted correctly: it is not *accepted* on that cycle, M13 holds
  `arp_valid` and the fields until acceptance (the substitution above), and M11
  accepts on the following cycle.

- **Configuration sampling.** None; M11 reads no configuration (§4.3).

## 8. Line-rate stress obligation

**Not applicable.** M11 is not in requirements.md §0.4's stress-bench list (M03,
M06, M08, M10, M14, M17, M20), which enumerates *receive-path* modules —
REQ-004's invariant is about surviving an arrival rate the module cannot slow
down, and M11 sets its own pace through `arp_ready`. Nothing upstream of it can
be stalled by that: M13's receive relay into M10 carries no `tready` at all
(SPEC-M13 §7), which is why REQ-510 discards a *reply* rather than a packet and
why an M11 that is busy is never a receive-path hazard.

Its equivalent obligations are two, both stated so that no sign-off packet has
to invent them:

1. **REQ-502's response test**, which is a system-level run (REQ-807): inject an
   ARP request for the configured local IP and decode the transmitted frame
   field by field against all six address fields and the ethertype, measuring
   the response delay against the 64-cycle bound §7 derives.
2. **The M10 loopback**, which is the cheapest check of both wire-format tables
   at once: drive M11 with a packet, feed its payload stream and header record
   into M10, and assert that M10 accepts it (no `error_arp_unsupported`) and
   reproduces all five carried fields exactly. A transposition error in either
   table fails this in one cycle, and it needs no XGMII and no reference model.

   **The loopback SHALL present `hdr_valid` one cycle before payload word 0**,
   as M08 does — the harness delays M11's `hdr_valid` by one cycle, or holds
   payload word 0 for one cycle, and drives M10 with the pair so separated
   (carry-forward **C-19**, dv_lead). Wired naively the run fails a conformant
   pair: with `payload_tready` held 1, M11 asserts `hdr_valid` and payload word 0
   on the **same** cycle (ADR-0008 decision 1, §6.1's offer) and drops
   `hdr_valid` the next, which is a **zero-lead** producer; SPEC-M10 §6.1 defines
   Cp as "the first cycle **after** the opening `hdr_valid` pulse with
   `payload_tvalid` = 1", so M10 would take M11's word **1** as its word 0, count
   20 delivered ARP octets and pulse `error_arp_unsupported` — the exact opposite
   of what this item asserts. The repair belongs in the harness and **not** in
   M10: widening M10's Cp to admit a zero-lead producer would commission
   behaviour for a stimulus no producer in this programme emits, which is what
   carry-forward C-17(c) withdrew at M08 for the same reason. The one-cycle lead
   is the receive-side discipline every M10 producer has (SPEC-M06 §7, preserved
   by SPEC-M08 §6.1), and the loopback's job is to look like that producer.

## 9. Errors and discards

**Not applicable as a detection table.** M11 detects no abnormal condition and
raises no strobe. Every condition on this path is owned elsewhere: an
unresolvable destination is M13's `error_arp_miss` (REQ-505), a reply that
cannot be held is M13's `error_arp_reply_dropped` (REQ-510), a missing word on
the wire is M04's `error_underflow` (REQ-206) and cannot originate here because
M11 holds every octet in a register before it offers the frame (§3, REQ-016).

| Condition | Strobe (one cycle) | Stream effect | REQ |
|---|---|---|---|
| (none detected here — see above) | — | — | — |

**REQ-008 is not weakened by an empty table.** M11 discards nothing: every
packet it accepts is transmitted, and a frame it has begun is completed unless
`clear` truncates it, which is REQ-009's permission and not a silent discard.
Frame conservation (requirements.md §0.6) at M11's ports is the identity — one
accepted packet, one emitted frame — and that is exactly what a monitor should
assert here.

**Inherited aborts.** There are none: M11 originates every frame it emits and
drives `payload_tuser` to 0 on every word (§4.2). §0.6's "a module SHALL NOT
re-report an inherited abort" has no instance.

## 10. REQ coverage

| REQ | How this module satisfies it | Section | Verification hook for DV |
|---|---|---|---|
| REQ-001 | one clock; no gated or derived clock | §3 | the emitted-Verilog edge-expression check |
| REQ-007, REQ-013 | no instance: M11 originates the frame; `payload_tuser` is 0 on every word | §3, §9 | protocol monitor asserting `tuser` = 0 on every emitted `tlast` |
| REQ-008 | no strobe, and none is owed: nothing is discarded here | §9 | none — stated so that no sign-off packet claims a strobe row for M11 |
| REQ-009 | `clear` abandons the frame and holds `arp_ready`, `hdr_valid` and `tvalid` low | §7 | reset test: assert mid-frame, deassert, present a packet on the next cycle and assert it is accepted on the **second** and transmits intact |
| REQ-010 | `Source` and `Dest` on the one stream, from the programme types; `Arp_packet` is SPEC-M10's | §4.1 | interface compile check |
| REQ-011 | `tkeep` `0xFF` on words 0–2 and `0x0F` on word 3; never 0 with `tvalid` = 1 | §6.1 | protocol monitor on the payload stream |
| REQ-012 | every field emitted first wire octet first; the operation's octet order is the one most often got wrong | §6.1 | REQ-502's octet-for-octet decode, which includes the operation and both MAC fields |
| REQ-014 | `tstrb` driven 0 | §4.2 | protocol monitor; REQ-014's differential run |
| REQ-015 | one `tlast` per frame, on word 3; exactly four words per packet | §3, §6.1 | protocol monitor asserting the word count is 4 for every frame |
| REQ-016 | `payload_tvalid` is never deasserted inside a frame | §3, §6.1 | assert on the emitted stream that no frame contains a bubble, over the REQ-807 system run |
| REQ-021 | ARP octet 0 at `payload_tdata`[7:0] of word 0, always | §3, §6.1 | the M10 loopback of §8 item 2 |
| REQ-207 | an accepted packet is always transmitted; `arp_ready` is 0 whenever M11 cannot accept | §6.1, §7 | drive a continuous packet source; assert one emitted frame per accepted packet, in order, with no duplicate |
| REQ-208 | M11 has no receive-side port, so no path from here into the receive datapath exists | §3 | inspection of the emitted netlist; REQ-208's top-level test |
| REQ-405 | **not** M11's: M11 emits a header *record*; the fourteen frame octets are M07's | §2 | none — stated so that no sign-off packet claims header-insertion coverage here |
| REQ-406 | no instance: M11 has one output port and requests by the ADR-0008 handshake | §2 | none — stated so that no sign-off packet claims arbitration coverage here |
| REQ-501 | the four constant fields are emitted as the constants REQ-501 accepts, so an M11 packet is acceptable to M10 by construction | §6.1 | the M10 loopback of §8 item 2 |
| REQ-502 | packet-construction half: operation, all four address fields at their offsets, unicast destination MAC from `target_mac`, source MAC from `sender_mac`, ethertype 0x0806 | §6.1 | REQ-502's field-by-field decode of the transmitted frame, plus the response-delay measurement against §7's derivation |
| REQ-505 | emitter side: a request (operation 1) is sent to the broadcast MAC | §6.1 | transmit to an unknown host and assert the request's Ethernet destination is `ff:ff:ff:ff:ff:ff` while its ARP target hardware address is `00:00:00:00:00:00` |
| REQ-802, REQ-803, REQ-810 | no instance: M11 reads no configuration; REQ-810's transmit half is M04's, and its ARP clause is realised at M13 (SPEC-M13 §10) | §4.3 | none — stated so that no sign-off packet claims coverage here |
| REQ-903, REQ-808 | `arp_eth_tx` is a distinct emitted module with `create`, `hierarchical` and an `.mli` | §4.1 | repository surface check and the `rtl_snapshots/` name comparison |

This table is the source of M11's rows in [`traceability.md`](../traceability.md),
updated in the same commit.

## 11. Deferred items

Item numbers are permanent; a closed item keeps its row (SPEC-TEMPLATE §11).

| # | Item | Status · what a reader assumes meanwhile | Tracked as | Owner | Closes by |
|---|---|---|---|---|---|
| 11.1 | **The `ifc_check` compile evidence for this lift is pending**: `arp_eth_tx_ifc.ml` is new in this commit and is the first lift to `open!` another module's lift (`Arp_eth_rx_ifc`, SPEC-M10 §4.1). | **CLOSED (WO-0017).** CI `build` run **30736107842** at 2f29888 reports `success` with all four batch-D lifts in it, and `git diff a9993ff 2f29888 -- docs/specs/` is **empty**, so the run elaborated byte-identically the text drafted at a9993ff. The cross-lift `open!` is proven by a run rather than by argument, which is what mattered: it is what batches E and F now build on (SPEC-M15's lift opens `Arp_ifc`). | the `Interface compile check` row of §12 | architect_docs_lead, rtl_lead | closed |
| 11.2 | **The transmit-side header handshake is a programme convention, not this module's invention** (ADR-0008): header and first payload word offered together, held until that word is accepted. M09 consumes it, and M15 and M18 must restate it in batches E and F. | **CLOSED (WO-0017), affirmatively.** SPEC-M15 §7 (batch E) restates decisions 1, 2 and 4 as its own obligation towards M09, with decision 4 satisfied structurally exactly as it is here — an IPv4 transmit frame always carries at least 28 body octets, an ARP frame always exactly 28 payload octets — so the convention holds at both of M09's request ports and needed no exception at either. ADR-0008 gained one clause under this work order, C-22's precedence rule, which permits a monitor attached to **this** module to assert the `hdr_valid` fall §6.1 commits to; that is a rule about tests and changes nothing M11 does. SPEC-M18 (batch F) is the last source and restates it in its own §7. | ADR-0008; SPEC-M07 §11.2; SPEC-M09 §11.3 | architect_docs_lead | closed |
| 11.3 | **The `arp_ready` substitution of §7 is this specification's reading of ADR-0008, not a sentence the ADR contains.** ADR-0008 names the acceptance of the first payload word as the acceptance event; at M11's `arp` port there is no payload stream to accept, because M11 generates the payload. | **CLOSED (WO-0017), affirmatively: INSTANTIATION, not supersession. No ADR-0008 amendment is owed.** dv_lead's answer (`J-dv_lead-0008`, WO-0015 Return log §4/Q1): ADR-0008's Context states its own problem as "what is a transmit-side header record's acceptance event, **given a record that cannot carry a `ready`**", and that problem does not arise here — `arp_ready` is a real output bit in §4.1's `O`, not a field of a record M01 froze, so this port has a native acceptance event and is a case the ADR never governed rather than one it governs and departs from. What the ADR contributes is decisions 2 and 3's discipline, which is the ordinary valid/ready contract it *specialises* for records lacking a `ready`; applying it against a native `ready` is the general case. Two confirmations dv ran rather than assumed: the substitution is **two-sided** (SPEC-M13 §7 states M13's half, so a bench has both sides without inventing either), and it is consistent with §6.2's `Idle` → `Offer` transition, which captures on the acceptance cycle — decision 3 against the substituted event, exactly. The residue is a **DV action and not a spec gap**: batch D adds a third header-record monitor case — a record with a native `ready`, selected by neither of ADR-0008's two direction-chosen disciplines — which is machinery in `test/monitors/`, dv_lead's, derivable from this §7 plus SPEC-M13 §7. | this item; ADR-0008 | architect_docs_lead, dv_lead | closed |

## 12. Freeze record

Filled in at `P1-spec-freeze`. All four rows are required (charter §5); this
spec is DRAFT.

| Item | Value |
|---|---|
| Interface compile check | CI `build` run **30736107842**, conclusion **`success`**, SHA **2f29888** — all thirteen lifts elaborate, the four batch-D lifts for the first time; per ADR-0005 a local build is not acceptable evidence. `git diff a9993ff 2f29888 -- docs/specs/` is empty, so the run witnesses the text drafted at a9993ff. CI `build` run **30739442056** at the freeze SHA **3f6accc** is likewise **`success`** with every lift in it (dv_lead fetched it through the GitHub API rather than taking it from the packet, `J-dv_lead-0009` §0), so the **frozen** text carries compile evidence at its own SHA and no witnessing argument is owed for this row either. This run is also §11.1's closure record |
| Architect signature | `J-architect_docs_lead-0006`; the C-19 and REQ-015 diffs `J-architect_docs_lead-0007` |
| dv_lead testability countersignature | **`J-dv_lead-0009`** (WO-0018) — batch D **COUNTERSIGNED at 3f6accc**. This spec was SIGNED on its own merits at a9993ff (`J-dv_lead-0008`, WO-0015 Return log §1) — L = 8 / h = 0 / ΔC = 1 re-derived, the five-cycle packet period confirmed, ADR-0008 decisions 1, 2 and 4 discharged at the output and decision 1 correctly not claimed at the input, Q1 answered affirmatively |
| Frozen at | SHA **3f6accc**, gate `docs/gates/P1-spec-freeze-checklist.md` |

## 13. Change log

Post-freeze changes only. This spec is DRAFT and has none: the WO-0017 diffs —
§3's REQ-015 counting wording, §6.1's `arp_ready` clarification, §8 item 2's
one-cycle lead (**C-19**), §11.1 and §11.3's closures and §12's evidence row —
are pre-freeze corrections on DRAFT text. **No port, no cycle and no constant
moves**: §7's L = 8 / h = 0 / ΔC = 1 and the five-cycle packet period are exactly
what dv_lead re-derived and signed.

| Date | Change | Breaking? | ADR | Journal |
|---|---|---|---|---|
| — | — | — | — | — |
