# SPEC-M10 — `Arp_eth_rx`

- **Status**: **FROZEN** (`P1-spec-freeze`, SHA `3f6accc`) — batch D, dv_lead
  countersignature `J-dv_lead-0009` (WO-0018, granted at the commit carrying the
  D-1 and D-2 repairs after `J-dv_lead-0008` withheld it at a9993ff). Changes to
  §4, §6 or §7 after this point are spec diffs recorded in §13 (SPEC-TEMPLATE
  rule 7)
- **Inventory id**: M10 (architecture.md §4) · **Path**:
  `libs/hardcaml_ethernet/src/arp_eth_rx.ml`
- **Datapath role**: receive
- **Owns REQs**: REQ-501
- **Prior-art counterpart**: `arp_eth_rx.v` (MIT) — consulted for decomposition
  and port naming only; behaviour below is stated independently and no source
  was copied
- **Depends on specs**: SPEC-M01 (`Axi64`, `Eth_header`), SPEC-M06
  (`Eth_axis_rx`, whose header-record contract this module's producer
  preserves), SPEC-M08 (`Eth_demux`, its immediate producer)
- **Author**: architect_docs_lead, journal `J-architect_docs_lead-0006`

## 1. Purpose

M10 turns the payload stream of an Ethernet frame carrying ethertype 0x0806
into a decoded **ARP packet record**: it checks the six field values REQ-501
makes the acceptance criteria, captures the four address fields and the
operation, and reports each packet exactly once — as an `arp` record with
`valid` = 1, or as a single `error_arp_unsupported` pulse. It exists as a
separate module for the same reason M06 does: it is where an octet string stops
being a frame and starts being a protocol object, and separating the parse from
the resolver (M13) means the resolver never sees an octet position.

Its upstream is M08 `Eth_demux` (through M13's relay ports, architecture.md
§6.4.1); its downstream is M13 `Arp`, which owns the state — the cache, the
reply and the resolution — that M10 deliberately does not. It instantiates
nothing.

## 2. Scope

**In scope.**

- Decoding the nine ARP fields at their octet offsets and checking the six that
  REQ-501 makes acceptance criteria: hardware type 1, protocol type 0x0800,
  hardware length 6, protocol length 4, operation 1 or 2, and at least 28 octets
  present (§6.1).
- Presenting `operation`, sender hardware address, sender protocol address,
  target hardware address and target protocol address as decoded numeric fields
  in an `Arp_packet` record whose `valid` pulses for exactly one cycle
  (§4.1, §7).
- Reporting an unacceptable packet with exactly one `error_arp_unsupported`
  pulse and no record (REQ-501, §9).
- Reporting every opened packet **exactly once**, so that requirements.md §0.6's
  conservation equation is computable at this module's ports (§9, §8).

**Not this module's job.**

| Behaviour a reader might expect here | Owner |
|---|---|
| Learning — writing sender addresses into the cache | M13 `Arp` (REQ-503) and M12 `Arp_cache` (REQ-504). M10 decodes and never stores |
| Deciding whether a request is addressed to us, and generating the reply | M13 (REQ-502, REQ-511, REQ-512). M10 does not read the configured local IP and has no configuration input at all (§4.3) |
| Building an ARP packet for transmission | M11 `Arp_eth_tx` (REQ-502). M10 and M11 share the `Arp_packet` record and nothing else, and the record's `valid` has a **different discipline** in the two directions (§7, ADR-0008) |
| Routing on the ethertype, or knowing that 0x0806 means ARP | M08 `Eth_demux` (REQ-404). By the time a payload reaches M10 the routing decision is made; M10 never reads `hdr_ethertype` |
| The Ethernet padding after the 28th ARP octet | nobody removes it — M10 counts it, ignores it and reports nothing about it (§6.1) |
| Acting on the inherited abort bit `payload_tuser`[0] | M13 `Arp` (REQ-013's ultimate-consumer clause, REQ-503, **ADR-0009**). M10 does not read the bit and could not usefully: §7 shows it arriving two or more cycles after M10's pinned report, so acting on it here would make the parse latency a function of the frame length and fail REQ-005. M13 gates the learning write and the reply on it at the packet's payload `tlast` (SPEC-M13 §6.1); §11.3 records how that owner was settled |

## 3. Programme invariants that bind this module

M10 is a receive-path module under requirements.md §0.4 — the branch M08 routes
ARP frames onto — and both its payload input and the `arp` record it emits are
receive-path ports. It is one of the seven modules owing a line-rate stress
bench (§0.4, REQ-905).

| REQ | Consequence for M10 |
|---|---|
| REQ-001 | One `clock`. Every register in §7's pipeline is synchronous to it. |
| REQ-002 | The payload input is a 64-bit `Axi64` stream, at most one word per cycle. |
| REQ-003 | The payload input carries no `tready` and the `arp` record carries no `ready`: M13 cannot stall M10 and M10 cannot stall M08, structurally (§4.1). This is what makes REQ-510 — dropping a *reply* rather than stalling — the only available remedy at M13, and REQ-510 says so. |
| REQ-004 | M10 is on requirements.md §0.4's stress-bench list. Its stimulus is 10 000 minimum-length ARP packets at the REQ-004 arrival rate, expressed at M10's own ports and derived by construction from the XGMII case (§8). |
| REQ-005 | Constant latency, in the only form a module with no octet-carrying output can have one: the **parse latency** of §7 is a single constant for every packet, at every frame length and every field content M10 accepts. No packet is reported early because its fields happened to be available early, and none late because padding followed. |
| REQ-007 | No instance in the forwarding sense: M10 emits no stream, so there is no `tlast` word on which to set `tuser`[0]. It originates no abort and re-reports none (requirements.md §0.6). |
| REQ-008 | M10's discard condition — REQ-501's rejection — has a strobe, and §9 pins its cycle. It owns one of the twenty-one strobes (requirements.md §12). |
| REQ-009 | Synchronous `clear`. On every cycle `clear` = 1 and on the first cycle it is 0: `arp_valid` = 0 and `error_arp_unsupported` = 0. A packet in flight is abandoned with no record and **no strobe** — the one place in this specification where a packet vanishes silently, permitted by REQ-009 and not by REQ-008 (§7). |
| REQ-010 | The payload input is the programme `Axi64.Source` and the header input is SPEC-M01's `Eth_header`, both unchanged. `Arp_packet` is a new record and §4.1 states where it lives and why. |
| REQ-011 | `payload_tkeep` on the `tlast` word says how many octets of that word are payload; M10 reads it to count delivered octets against REQ-501's 28. |
| REQ-012 | Payload octet position k is `payload_tdata`[8k+7:8k]; every ARP field is presented as a numeric value with network byte order already decoded (§6.1). |
| REQ-013 | `payload_tuser`[0] is read by nothing here. M10 does not drop a packet because it is set, which is REQ-013's own sentence; §7 shows the bit arrives after the decision and §11.3 records what follows. |
| REQ-014 | `payload_tstrb` is ignored. |
| REQ-015 | One `tlast` per payload frame. M10 needs no upper bound on the word count — it stops reading at ARP octet 27 — but the input obeys REQ-015's 188-word bound (SPEC-M06 §7). |
| REQ-016 | The payload input may carry idle cycles and M10 tolerates them: k idle cycles before a payload word delay every octet that word carries by exactly 8k octet times and change nothing else on the input side. §6.1's cycle formulas are stated on a gapless stimulus, and so is §7's constant L = 32 — **M10's report is decided by a later input word than the one its latency is measured from, so L does not survive injection** (requirements.md §0.5's late-decision test, which names M10 as its worked instance). What survives is the delay from the report's **deciding input word**, pinned in §7. |
| REQ-017, REQ-018 | No instance: M10 sees no lane, no control character and nothing below XGMII. |
| REQ-019 | M10 is a receive-path module but is **not** on the application receive chain REQ-006 measures, so requirements.md §1.1 allocates it no ceiling and it consumes none of the architect's seven cycles of slack — §1.1 says so in its own words. Its constant is pinned in §7 and is bounded only by REQ-005. Storage is **four** payload words' worth of captured fields, which is 28 octets and not a buffer: M10 never re-emits an octet. |
| REQ-020 | Packets are reported in the order they arrived; M10 holds one packet at a time (§6.2), so reordering is not expressible. |
| REQ-021 | The producer-side alignment M06 established is what makes this specification simple: ARP octet 0 is at `payload_tdata`[7:0] of payload word 0 at every frame length, so the nine field offsets of §6.1 are fixed positions and not a function of the start lane. M10 performs no realignment of its own and strips nothing. |

## 4. Interface

### 4.1 Interface records

```ocaml
(* SPEC-M10 §4.1, lifted verbatim into docs/specs/ifc_check/arp_eth_rx_ifc.ml
   (SPEC-TEMPLATE.md rule 6). Records and signatures only — no logic, no
   implementation.

   [Axi64_ifc] is M01's types home (SPEC-M01 §4.1): [Axi64] and
   [Eth_header] come from there and are restated nowhere.

   [Arp_packet] is declared HERE and not in M01. M01 is FROZEN at
   f78766e; adding a record to its §4.1 would be a breaking interface
   change to a frozen specification and would invalidate the compile
   evidence five freeze records cite (SPEC-TEMPLATE rule 7, charter §6).
   The rule batch D adopts for a record M01 does not carry is therefore:
   it is declared once, in the specification of the module that
   PRODUCES it, and every consumer opens that module. M10 produces
   [Arp_packet] (architecture.md §6.4.1), so SPEC-M11 §4.1 and SPEC-M13
   §4.1 write [open! Arp_eth_rx_ifc] and restate nothing. §11.2 tracks
   the promotion of the batch-D records into M01 if a later phase
   reopens it.

   Receive-path module: [payload] is [Axi64.Source] with no [Axi64.Dest]
   anywhere, and [Arp_packet] carries a [valid] and no [ready] — both
   for the same reason, that nothing on this path may stall its producer
   (REQ-003). That is also why REQ-510's remedy for a reply that cannot
   be sent is to drop the reply and never the packet. *)

open! Base
open Hardcaml
open! Axi64_ifc

module Arp_packet = struct
  type 'a t =
    { valid : 'a
    ; operation : 'a [@bits 16]
    ; sender_mac : 'a [@bits 48]
    ; sender_ip : 'a [@bits 32]
    ; target_mac : 'a [@bits 48]
    ; target_ip : 'a [@bits 32]
    }
  [@@deriving hardcaml]
end

module I = struct
  type 'a t =
    { clock : 'a
    ; clear : 'a
    ; hdr : 'a Eth_header.t [@rtlprefix "hdr_"]
    ; payload : 'a Axi64.Source.t [@rtlprefix "payload_"]
    }
  [@@deriving hardcaml]
end

module O = struct
  type 'a t =
    { arp : 'a Arp_packet.t [@rtlprefix "arp_"]
    ; error_arp_unsupported : 'a
    }
  [@@deriving hardcaml]
end

module type S = sig
  val create : Scope.t -> Signal.t I.t -> Signal.t O.t
  val hierarchical : ?instance:string -> Scope.t -> Signal.t I.t -> Signal.t O.t
end

(* REQ-010 type identity at the one stream port, and the first
   compile-time witness of [Arp_packet]'s six field names. *)

let _witness_stream_is_the_programme_type (x : Signal.t Axi64.Source.t) = x

let _witness_arp_packet_field_names (p : Signal.t Arp_packet.t) =
  let open Arp_packet in
  [ p.valid; p.operation; p.sender_mac; p.sender_ip; p.target_mac; p.target_ip ]
;;
```

Conformance of this block to the template's rules for §4.1:

- Scalar fields carry `[@bits n]` unless one bit wide: `clock`, `clear`,
  `error_arp_unsupported` and `Arp_packet`'s `valid` are one bit; every other
  field carries its width.
- Nested interfaces carry `[@rtlprefix]`: `hdr` emits `hdr_valid` …
  `hdr_ethertype`, `payload` emits `payload_tvalid` … `payload_tuser`, and `arp`
  emits `arp_valid`, `arp_operation`, `arp_sender_mac`, `arp_sender_ip`,
  `arp_target_mac`, `arp_target_ip`.
- **Receive-path `Source` without `Dest`: held.** Neither record contains an
  `Axi64.Dest` and neither contains a `tready` field. An M10 that wanted
  backpressure could not be written without changing this record, which is a
  spec diff — REQ-003.
- Both `create` and `hierarchical` are declared (REQ-903, REQ-808).

**Why `Arp_packet` carries five fields and not nine.** Hardware type, protocol
type, hardware length and protocol length are *acceptance criteria*, not data:
REQ-501 fixes each to one value, and a record whose `valid` is 1 has already
been checked against all four (§6.1). Carrying them downstream would create a
second place where a wrong constant could enter the design and would oblige
every bench to assert that M13 relayed four constants unchanged. On the
transmit side the same four are emitted as constants by M11 (SPEC-M11 §6.1),
fixed by REQ-502. The invariant a reader may rely on is therefore: **an
`Arp_packet` with `valid` = 1 is by construction a REQ-501-accepted packet**,
and nothing downstream re-checks it.

### 4.2 Port table

Every port in §4.1 appears exactly once. Direction is with respect to M10.

| Port | Dir | Width | Meaning | REQ |
|---|---|---|---|---|
| `clock` | in | 1 | 156.25 MHz single domain | REQ-001 |
| `clear` | in | 1 | synchronous clear | REQ-009 |
| `hdr_valid` | in | 1 | a frame routed here begins; this pulse **opens** a packet (§6.1). The only field of this record M10 reads | REQ-401, REQ-404 |
| `hdr_dst_mac` | in | 48 | present because M08 relays the whole record; **read by nothing** here — REQ-407 forbids Ethernet-layer filtering and REQ-503 learns from the ARP fields, not from the frame header | REQ-407 |
| `hdr_src_mac` | in | 48 | same; read by nothing | REQ-407 |
| `hdr_ethertype` | in | 16 | same; read by nothing — the routing decision was M08's (REQ-404) and is not revisited | REQ-404 |
| `payload_tvalid` | in | 1 | this cycle carries a payload word | REQ-016 |
| `payload_tdata` | in | 64 | payload octets; ARP octet 0 at position 0 of payload word 0 | REQ-012, REQ-021 |
| `payload_tkeep` | in | 8 | valid octet positions, contiguous from bit 0; read to count delivered octets against REQ-501's 28 | REQ-011 |
| `payload_tstrb` | in | 8 | reserved; ignored | REQ-014 |
| `payload_tlast` | in | 1 | this word carries the payload's final octets; **closes** a packet (§6.1) | REQ-015 |
| `payload_tuser` | in | 1 | bit 0: inherited abort. Read by nothing (§2, §7, §11.3) | REQ-013 |
| `arp_valid` | out | 1 | one cycle high per **accepted** packet; the other five fields are that packet's | REQ-501 |
| `arp_operation` | out | 16 | ARP operation as a numeric value: 1 request, 2 reply. No other value can appear with `valid` = 1 | REQ-501 |
| `arp_sender_mac` | out | 48 | sender hardware address, first wire octet most significant | REQ-501, REQ-012 |
| `arp_sender_ip` | out | 32 | sender protocol address, first wire octet most significant | REQ-501, REQ-012 |
| `arp_target_mac` | out | 48 | target hardware address, same encoding | REQ-501, REQ-012 |
| `arp_target_ip` | out | 32 | target protocol address, same encoding | REQ-501, REQ-012 |
| `error_arp_unsupported` | out | 1 | one-cycle strobe: the packet failed REQ-501 | REQ-501 |

### 4.3 Configuration inputs

**None.** M10 reads no field of the `Config` record, and that is a consequence
of the decomposition rather than an omission: every acceptance criterion in
REQ-501 is a constant fixed by the requirement, and every criterion that
depends on a configured value — is this request for us (REQ-502), which subnet
is this (REQ-507) — belongs to M13, which is where `cfg_local_ip`,
`cfg_local_mac`, `cfg_subnet_mask` and `cfg_gateway_ip` arrive
(architecture.md §6.4.3). REQ-803 therefore has no instance at M10: there is no
configuration input whose change could land inside a packet.

## 5. Parameters

**None.** REQ-506's rule — timeouts and ageing intervals must be compile-time
parameters so tests can use short values — has no instance: M10 has no timeout,
no interval and no retry. The numeric constants it contains (1, 0x0800, 6, 4,
28 and the nine field offsets) are pinned by REQ-501 and by RFC 826's packet
format; making any of them overridable would let a test configure a packet
format the programme does not have.

| Parameter | Type | Default | Range | Why a test overrides it |
|---|---|---|---|---|
| (none) | — | — | — | — |

## 6. Behaviour

### 6.1 Normal path

**The ARP packet M10 reads**, with the octet offsets and widths a test writer
needs to hand-assemble stimulus without RFC 826 open. Offsets are from ARP
octet 0, which is payload octet 0 — the first octet after the ethertype, which
is where M06 puts it (REQ-408) and where M08 leaves it (SPEC-M08 §6.1).

| Field | Octet offset | Width | Record field | Accepted value (REQ-501) |
|---|---|---|---|---|
| hardware type | 0–1 | 16 bits | — (checked, not carried) | **1** exactly |
| protocol type | 2–3 | 16 bits | — (checked, not carried) | **0x0800** exactly |
| hardware address length | 4 | 8 bits | — (checked, not carried) | **6** exactly |
| protocol address length | 5 | 8 bits | — (checked, not carried) | **4** exactly |
| operation | 6–7 | 16 bits | `arp_operation` | **1** (request) or **2** (reply) |
| sender hardware address | 8–13 | 48 bits | `arp_sender_mac` | any |
| sender protocol address | 14–17 | 32 bits | `arp_sender_ip` | any |
| target hardware address | 18–23 | 48 bits | `arp_target_mac` | any |
| target protocol address | 24–27 | 32 bits | `arp_target_ip` | any |

Every multi-octet field is presented as a **numeric value with the first wire
octet most significant** (REQ-012): sender hardware address 02:00:00:00:00:02
reads 0x020000000002, sender protocol address 192.168.1.10 reads 0xC0A8010A.
An IPv4 address's *least significant octet* — the one REQ-504's index function
uses — is therefore bits [7:0] of the 32-bit value, which is 10 in that example.

**Where the fields lie in the payload words.** Four words carry the packet;
anything beyond them is Ethernet padding and is ignored.

| Payload word | Octet positions 0 … 7 |
|---|---|
| 0 | hardware type (0–1), protocol type (2–3), hardware length (4), protocol length (5), operation (6–7) |
| 1 | sender hardware address (0–5 of the word = ARP 8–13), sender protocol address's two most significant octets (ARP 14–15) |
| 2 | sender protocol address's two least significant octets (ARP 16–17), target hardware address (ARP 18–23) |
| 3 | target protocol address (ARP 24–27) at positions 0–3; positions 4–7 are padding when they exist |

The packet is complete at **payload word 3**, and every acceptance criterion
except the length one is decidable at payload word 0.

**Opening and closing a packet.** A packet is **open** from the cycle M10 sees a
`hdr_valid` pulse until the earliest of: the payload `tlast` word; the next
`hdr_valid` pulse; or `clear` (REQ-009). This is SPEC-M03 §9's closure-list
device applied here (carry-forward **C-12**'s pattern), and it is what makes
each report a function of the packet rather than of whatever follows it. The
"next `hdr_valid`" clause is not a hedge: a frame whose Ethernet payload is
zero octets has no `tlast` to end it (requirements.md §0.7), and SPEC-M08 §6.2
ends such a frame the same way and for the same reason.

**The first payload word.** Cp is the cycle of the first payload word of an open
packet — the first cycle after the opening `hdr_valid` pulse with
`payload_tvalid` = 1. In the composed chain Cp is exactly one cycle after that
pulse (SPEC-M06 §7, preserved by SPEC-M08 §6.1); M10 nevertheless defines Cp by
the payload word and not by the header pulse, so that REQ-016's idle-injection
wrapper — which §10 commissions at 0, 1 and 7 cycles — cannot move the constant
of §7.

**One report per opened packet, on one pinned cycle.** M10 reports each opened
packet **exactly once**, on the cycle after the earliest of

1. the payload word carrying ARP octet 27 — payload word 3, at Cp + 3 on a
   gapless stimulus; and
2. the event that closed the packet.

If the packet satisfied every REQ-501 criterion the report is `arp_valid` = 1
with the five fields; otherwise it is one `error_arp_unsupported` pulse and no
record. Never both, and never neither. That sentence is the whole of §9's
timing and the whole of §8's conservation criterion, and it is computable from
the input trace alone.

**One exception, and it is the one §3, §6.2 and §7 already mandate**
(carry-forward **C-21**, dv_lead). A packet closed by **`clear`** is reported by
**neither**: no record and no strobe, straight to `Idle` (REQ-009, §6.2's
`Parse` and `Tail` rows, §7's reset bullet, which also forecloses the pulse
mechanically). Read without this clause the sentence above commissions a report
at `clear` + 1, which every conformant design fails to produce. The XOR
therefore holds over the three closures that are *events on the input stream* —
the payload `tlast` word, the next `hdr_valid` pulse, and the packet completing
at ARP octet 27 — and not over the fourth, which is a reset. `clear` is the one
place in this specification where a packet vanishes without a report; REQ-009
permits it and REQ-008 does not reach it.

**On a gapless stimulus**, for a packet of at least 28 octets:

- payload word m is presented on cycle **Cp + m**;
- the report — `arp_valid` — is on cycle **Cp + 4**.

**Cycle by cycle, the packet a minimum-length ARP frame produces.** A 64-octet
Ethernet frame carrying ARP is 14 header octets + 28 ARP octets + 18 padding
octets + 4 FCS octets, so M06 delivers a 46-octet payload in 6 words and M08
routes all six here (SPEC-M06 §8's arithmetic, with ethertype 0x0806).

| Cycle | Input | Output |
|---|---|---|
| H | `hdr_valid` = 1 (the packet opens) | `arp_valid` = 0, strobe = 0 |
| Cp = H+1 | payload word 0: ARP octets 0–7 | `arp_valid` = 0 |
| Cp+1 | payload word 1: ARP octets 8–15 | `arp_valid` = 0 |
| Cp+2 | payload word 2: ARP octets 16–23 | `arp_valid` = 0 |
| Cp+3 | payload word 3: ARP octets 24–31 (24–27 are the packet, 28–31 padding) | `arp_valid` = 0 |
| **Cp+4** | payload word 4: padding | **`arp_valid` = 1**, all five fields |
| Cp+5 | payload word 5: padding, `tkeep` = 0x3F, `tlast` = 1 (the packet closes) | `arp_valid` = 0 |
| Cp+6 onward | idle | `arp_valid` = 0 |

**The report is not moved by the padding, and that is REQ-005 rather than
pedantry.** The two words of padding after word 3 change nothing: the record
was complete at Cp+3 and is emitted at Cp+4 whether the frame is 42 octets long
or 1514. Equally, a packet whose *fields* are wrong at word 0 is not reported at
Cp+1 — it is reported at Cp+4, the cycle its record would have occupied — so
the report cycle is a function of the packet's length alone and a bench computes
it without decoding the fields.

*Exactly, for a packet closed by its own `tlast`; and the load-bearing half holds
in every case* (dv_lead, WO-0015 Return log §6 item 2). A packet closed instead
by the **next** `hdr_valid` — the payload-less frame of the paragraph below — has
a report cycle that is a function of the *next* frame's arrival rather than of
its own length. What is true without qualification, and what a bench actually
relies on, is that the report cycle is computable from the input trace **without
decoding any field**: §6.1's rule names only word counts and closure events.

**Gapped stimulus.** A cycle carrying no payload word holds every state and
every register: it is not a condition, it advances no word index, and it delays
every later octet by exactly 8 octet times per cycle on the **input** side
(REQ-016). The cycle formulas above hold on a gapless stimulus, and a bench
asserting them under injection would fail a conformant design — the distinction
carry-forward C-14.4 fixed in SPEC-M03 §6.1 and C-18 sharpened at WO-0014.

*This paragraph said until 2026-08-11 that "the constant of §7 holds on every
stimulus, and that is what a bench asserts". It does not, and §7's own
measurement events are why: M10's report is decided by the payload word carrying
ARP octet 27 while L is measured from ARP octet 0's octet time, so an idle
injected between those two words moves the report and not the measurement's input
event. That is requirements.md §0.5's **late-decision** test, which names M10 as
its worked instance, and §0.5's closing paragraph forbids a monitor to demand a
single per-octet L here. What a bench asserts instead is §7's per-output-event
delay from the report's deciding input word — for M10 exactly one cycle, at every
stimulus.*

**When `hdr_valid` opens a packet with no payload frame.** M06 emits a header
record with no payload frame for a 14-octet Ethernet frame (requirements.md
§0.7) and M08 routes it on its ethertype (SPEC-M08 §6.1). Such a frame carries
**zero** ARP octets, which fails REQ-501's length criterion; the packet is
closed by the next `hdr_valid` pulse and reported one cycle after it, with one
`error_arp_unsupported` pulse (§9). Nothing is emitted and nothing is learned.

### 6.2 State machine

Reset state and `clear` state are both `Idle`.

| State | Entered when | Does | Leaves to |
|---|---|---|---|
| `Idle` | reset; `clear`; a packet's `tlast` with the report already made | ignores the payload stream; `arp_valid` = 0, `error_arp_unsupported` = 0 | `Parse` on a `hdr_valid` pulse |
| `Parse` | a `hdr_valid` pulse (the packet opens) | counts payload words from Cp and captures ARP octets 0–27 into the field registers as they arrive; evaluates REQ-501's four constant checks on payload word 0, the operation check on payload word 0 and the length check continuously against `tkeep`; makes the one report of §6.1 on its pinned cycle | `Tail` on the report cycle if the packet is still open; `Idle` on the report cycle if the closing event made it; `Parse` again on a `hdr_valid` pulse arriving before the report, which closes this packet, reports it and opens the new one |
| `Tail` | the report has been made and the packet is still open | ignores every remaining payload word and every remaining octet; `arp_valid` = 0, `error_arp_unsupported` = 0. This is where Ethernet padding goes | `Idle` on the payload `tlast`; `Parse` on a `hdr_valid` pulse |

A cycle carrying no payload word holds every state and every register: it is not
a condition and it advances nothing (§6.1).

`clear` asserted in `Parse` or `Tail` abandons the packet: no record, no strobe,
straight to `Idle` (REQ-009, §7).

### 6.3 Deliberately unconstrained

Anything not listed here is constrained by this specification, and a test may
rely on it.

1. **The placement of the register levels** inside the pipeline and every
   internal encoding: the FSM state encoding, whether the field registers are
   one register or five, whether the word index is a counter or a shift.
   §7's constant is what is fixed.
2. **The value of the five `arp` fields on cycles where `arp_valid` = 0**
   (SPEC-M01 §6.3 item 5). No monitor may read them.
3. **Whether the length check is derived from a running octet count or from the
   word index together with the `tkeep` of the `tlast` word.** Both compute the
   same predicate — at least 28 octets delivered — and neither is observable;
   §6.1 pins the report cycle, which is what a bench needs.
4. **Whether the four constant checks are evaluated as one comparison against a
   64-bit pattern or as four.** Payload word 0 carries hardware type, protocol
   type and both lengths in positions 0–5, so the whole check is

   > `payload_tdata`[47:0] = **0x0406_0008_0100**

   — position 0 is `[7:0]` = 0x00 and position 5 is `[47:40]` = 0x04, giving the
   wire octet string `00 01 08 00 06 04` of §6.1's field table read through
   REQ-012. Written as the full 64-bit word of an accepted **request**, whose
   operation octets 6–7 are `00 01`, that is
   **`payload_tdata` = 0x0100_0406_0008_0100**. An implementation may do it as
   one comparison or as four and no bench can tell.

   *This item carried a wrong constant and it is corrected here* (carry-forward
   **C-20**, dv_lead). It read `payload_tdata`[47:0] = 0x000406000800_0001 —
   a 64-bit literal assigned to a 48-bit slice, and not a permutation of the
   correct octets under either reading its own sentence supports (as a numeric
   value the pattern is 0x0406_0008_0100; as a wire octet string ARP octets 0–5
   are `00 01 08 00 06 04`, i.e. 0x000108000604 read most-significant-first).
   SPEC-M11 §6.1's word-0 row states the same pattern **correctly** and always
   did, so the two batch-D tables disagreed and M11's was right. The governing
   statement here is §6.1's field table, which is also right; this section is the
   *unconstrained* list, from which a careful reader takes no stimulus, which is
   why the defect was a carry-forward rather than a contest.
5. **M10's response to a payload stream that violates REQ-011 or REQ-015** — a
   word with `tvalid` = 1 and `tkeep` = 0, a `tlast` with no preceding
   `hdr_valid`, a non-contiguous `tkeep`. Its producer is M08, relaying M06,
   neither of which can emit any of them (SPEC-M06 §7, SPEC-M08 §7), so no
   requirement names the case and DV SHALL assert nothing about it.
6. **M10's response to a `hdr_valid` pulse whose `hdr_ethertype` is not
   0x0806.** M08 routes on the ethertype and this port receives only 0x0806
   frames (SPEC-M08 §6.1); M10 does not re-check it (§4.2) and DV SHALL assert
   nothing about a frame delivered here with any other value.

## 7. Timing contract

- **Latency.** M10 emits no octet, so §0.5's per-octet definition needs its two
  measurement events named before it means anything here. They are:

  > **input event** — the octet time, on the `payload` stream, of ARP octet 0:
  > position 0 of payload word 0, that is 8·Cp;
  > **output event** — the octet time of the `arp_valid` pulse, which is
  > position 0 of its cycle, that is 8·(Cp + 4).

  With those events the module's constants are

  | Quantity | Value |
  |---|---|
  | L (octet times) | **32** |
  | h (octet times) | **0** |
  | Word delay ΔC = (L + h)/8 | **4** cycles |
  | §1.1 ceiling | **none** — M10 is not on REQ-006's chain |

  h is 0 because M10 removes no octet from the front of what it measures — ARP
  octet 0 is both the first octet it consumes and the first octet the record
  describes — and because its input is word-aligned (REQ-021), so §0.5's second
  term is 0 too. (L + h) = 32, a multiple of 8, as §0.5 requires. There is one
  constant and not two: M10 sees no XGMII, so §0.5's start-lane pair — the
  clause carry-forward C-15 moved into §0.5's definition sentence — has no
  instance here.

  **L is a gapless figure and does not survive REQ-016's idle injection.** M10
  passes §0.5's straddle test trivially (h = 0, and there is no output word to
  straddle) and **fails its late-decision test**: the report is decided by the
  payload word carrying ARP octet 27 while L's input event is ARP octet 0's octet
  time, four words earlier, so idles injected between them move the output event
  and not the input one. §0.5 names M10 as the worked instance of exactly this.
  The gap-invariant quantity is the delay from the report's deciding input word,
  pinned in the handshake bullet below.

  **Four cycles is what the octet mapping produces, not a target.** ARP octet 27
  lies in payload word 3, which arrives at Cp + 3, and a registered output emits
  at Cp + 4. Nothing cheaper exists without making `arp_valid` a combinational
  function of `payload_tdata`. Nothing *requires* four, either: requirements.md
  §1.1 states in its own words that M10 carries no allocation because it is not
  on the chain REQ-006 measures, so this constant spends none of the architect's
  seven cycles of slack and changing it later is an ordinary spec diff with no
  budget consequence. What REQ-005 requires is that it be **one** number, and
  §8 measures it as one.

- **Throughput.** One payload word accepted every cycle, unconditionally and
  with no handshake (REQ-003). At most one `arp_valid` pulse per opened packet
  and at most one report per opened packet; M10 can therefore never be the
  module that fails REQ-004, because it consumes at the input rate by
  construction and produces at most one pulse per frame.

- **Handshake rules.** `arp_valid` is high for **exactly one cycle** per
  accepted packet and the five field values are valid **only on that cycle**
  (§6.3 item 2). This is the receive-side discipline of REQ-401 applied to a new
  record: a pulse, not a level, because nothing on this path may stall its
  producer and therefore no acceptance event can exist (REQ-003, ADR-0008's own
  reasoning for the receive direction).

  **The same record has the opposite discipline one module away, and that is
  deliberate.** On the M13 → M11 edge an `Arp_packet` is held until accepted
  (SPEC-M11 §7, ADR-0008 as instantiated there). The direction of a port decides
  which discipline binds, exactly as it does for `Eth_header` (SPEC-M06 §11.3,
  ADR-0008's closing consequence), and every port declares its direction. A
  monitor written for one and attached to the other reports a defect that is not
  there.

  `error_arp_unsupported` is high for exactly one cycle per rejected packet, on
  the cycle §6.1 pins.

  **Idle gaps on the payload input (REQ-016)** delay each **output event** by
  exactly the number of idle cycles injected at or before its **deciding input
  word** D (requirements.md §0.5) and change nothing else about the output.
  M10 has exactly one output event per opened packet, so the table is one row —
  and §6.1 already names D there, as the earliest of its own two conditions:

  | Output event | Deciding input word D | Delay from D |
  |---|---|---|
  | the packet's single report — `arp_valid` with its five fields, or one `error_arp_unsupported` pulse, never both and never neither | the earliest of: the payload word carrying **ARP octet 27** (payload word 3), and the input word carrying **the event that closed the packet** — the payload `tlast` word, or the next `hdr_valid` pulse (§6.1) | **1** cycle |

  On a gapless stimulus that reproduces §6.1's Cp + 4 exactly. A packet closed by
  `clear` is reported by neither and has no output event to delay (§6.1's
  exception, carry-forward **C-21**). **This is the quantity §10's REQ-016 hook
  commissions; the per-octet constant L = 32 of the latency bullet above is a
  gapless figure and a wrapper asserting it under injection fails a conformant
  M10.** Per-octet latencies on an injected run may always be **reported** as
  data.

- **The inherited abort bit arrives after the decision, and this is where that
  is stated.** `payload_tuser`[0] is meaningful only on the payload `tlast`
  word. For the 64-octet ARP frame of §6.1 that word is at Cp + 5, two cycles
  **after** the report at Cp + 4, and for a padded or oversized frame later
  still. M10 therefore cannot act on it without abandoning the constant above —
  it would have to hold every record until the payload `tlast`, making the parse
  latency a function of the frame length and failing REQ-005. It does not act on
  it, which is REQ-013's explicit permission, and §11.3 records the consequence
  and who owns it.

- **Reset.** While `clear` = 1 and on the first cycle after it returns to 0:
  `arp_valid` = 0, `error_arp_unsupported` = 0, state `Idle`, the captured field
  registers irrelevant because the next packet overwrites them. `clear` asserted
  inside an open packet abandons it with **no record and no strobe** — the one
  place in this specification where a packet vanishes without a report,
  permitted by REQ-009 and not by REQ-008. A packet whose `hdr_valid` pulse
  arrives on the first cycle after `clear` returns to 0 is parsed correctly.

- **Configuration sampling.** None; M10 reads no configuration (§4.3).

## 8. Line-rate stress obligation

**Mandatory: M10 is in requirements.md §0.4's stress-bench list** (M03, M06,
M08, M10, M14, M17, M20). **This section closes carry-forward C-6**, which
observed that M10 emits parsed fields rather than a payload octet stream, so
two of REQ-004's four pass criteria — "payload octets compare equal" and
"per-octet latency is constant" — have no direct observable at its output.
SPEC-TEMPLATE §8 obliges this specification to state the exact stimulus and the
exact criteria, and the criteria below are the parsed-fields form of REQ-004's
four. They are not weaker: criterion 2 checks more than an octet comparison
would, because it also checks the decode.

**Stimulus, derived by construction from the XGMII case and not re-invented**
(REQ-004's own rule for a module that does not see XGMII). Drive M10's `hdr`
and `payload` ports with exactly what M08 emits on its `arp_*` ports when M03
is driven by SPEC-M03 §8's stress run with the ethertype set to 0x0806:

- 10 000 consecutive ARP frames, each a **64-octet** Ethernet frame — 14 header
  octets, 28 ARP octets, 18 padding octets, 4 FCS octets — which M06 delivers as
  a **46-octet payload in 6 words** (five with `tkeep` = 0xFF, one with
  `tkeep` = 0x3F and `tlast` = 1) and M08 relays unchanged one cycle later;
- one `hdr_valid` pulse per frame, exactly one cycle before that frame's first
  payload word (SPEC-M06 §7, preserved by SPEC-M08 §6.1);
- the six words of a frame occupy **consecutive cycles**, and **between frames 4
  and 5 idle cycles alternately**: M03's start characters alternate lane 0 and
  lane 4 at 10 and 11 cycles apart (REQ-004, requirements.md §0.3) and six of
  those cycles carry payload words, leaving 4 and 5. The idle figure is counted
  **on the payload stream**, and the header pulse falls inside that idle run, one
  cycle before payload word 0 — it does not occupy a seventh cycle of the payload
  stream, and reading it as one would give 3 and 4 (dv_lead, WO-0015 Return log
  §6 item 1). **4 and 5 is the operative figure.** Idle gaps are
  preserved rather than closed up — that alternation is the stimulus, and a
  bench that packs the words back to back is testing a rate the receive path
  never sees;
- **packet contents**, chosen so that a stuck field register cannot pass:
  hardware type 1, protocol type 0x0800, hardware length 6, protocol length 4,
  **operation 1** (request), sender hardware address `02:00:00:00:00:02` with
  its low 16 bits carrying the frame index n modulo 65 536, sender protocol
  address `10.0.0.0 + n` as a 32-bit value, target hardware address
  `00:00:00:00:00:00` (RFC 826's convention in a request), target protocol
  address the configured local IP, and 18 octets of fixed filler as the Ethernet
  padding;
- `payload_tuser`[0] = 0 on every `tlast` word. **Error injection rate: zero in
  this run** — REQ-501's rejection cases are directed tests (§10), because
  REQ-004's conservation criterion is stated over the packets the module
  accepts.

Note for the bench writer: the sender protocol address at ARP octets 14–17 is
split across payload words 1 and 2 — two octets at positions 6 and 7 of word 1
and two at positions 0 and 1 of word 2. That split is the point of checking it:
it is the one field of this packet whose decode crosses a word boundary, and a
sequence number placed there fails loudly if the crossing is wrong.

**Checks — REQ-004's four criteria in their parsed-fields form (C-6).**

1. **Conservation, which replaces "frames out equals frames in".** 10 000
   `hdr_valid` pulses in; exactly 10 000 reports out, each exactly one cycle
   long; in this run all 10 000 are `arp_valid` and `error_arp_unsupported`
   pulses number **zero**. The general invariant the monitor asserts is the one
   §6.1 states — reports = packets opened, and no packet produces two reports or
   none — which is requirements.md §0.6's conservation equation computed at a
   port that carries no frames.

   **The one exemption that monitor needs, and where it bites** (carry-forward
   **C-21**'s sharper half, dv_lead). requirements.md §0.6 says the conservation
   monitor is active in **every** bench, and §10 commissions a mid-packet `clear`
   test at this module — in which a packet is opened and, correctly, never
   reported (§6.1, §7). A monitor asserting "reports = packets opened" without a
   `clear` exemption counts that as a silent discard and fails a conformant M10.
   This is ledger **C-2**'s exemption becoming load-bearing for the first time,
   at M10; SPEC-M12 §7 states the analogous exemption for a query lost to `clear`
   and is the model for its wording. In the stress run itself the exemption never
   fires — `clear` is not asserted — so criterion 1 stands exactly as written for
   all 10 000 packets.
2. **Field equality, which replaces "payload octets compare equal".** For every
   `arp_valid` pulse, all five fields compare equal to the injected packet's
   fields, and the sender protocol addresses arrive as `10.0.0.0 + 0`,
   `10.0.0.0 + 1`, … with no gap and no repeat (REQ-020). This is a stronger
   check than an octet comparison: it also asserts the network-byte-order decode
   of REQ-012 and the word-boundary crossing above.
3. **Constant parse latency, which replaces "per-octet latency is constant".**
   The interval from each packet's first payload word to its `arp_valid` pulse
   equals **4** cycles for every one of the 10 000 — one value, not a mean, and
   quoted in the sign-off packet as L = 32 octet times with h = 0 and ΔC = 4
   against **no** §1.1 ceiling (§7). This is REQ-611's shape, which is the
   analogue REQ-004's criterion has at a module whose output is a record.
4. **No `tready` on the stream under test**, and none on the `arp` record. This
   is structural (REQ-003, §4.1) — a statement about the type, not an assertion
   that could fail.

**Directed packets alongside the stress run** (REQ-501, §9): one packet per
rejection class — hardware type 2, protocol type 0x86DD, hardware length 8,
protocol length 6, operation 0, operation 3, operation 4, a 27-octet packet
(`tkeep` marking three octets on payload word 3) and a frame with no payload
frame at all (requirements.md §0.7) — plus one packet with **two** criteria
failing at once, to assert the single-pulse rule of §9. Each is checked for
exactly one `error_arp_unsupported` pulse on the cycle §6.1 pins, no
`arp_valid`, and the following packet parsed intact.

## 9. Errors and discards

Strobe names are normative (requirements.md §12).

| Condition | Strobe (one cycle) | Stream effect | REQ |
|---|---|---|---|
| An open packet whose hardware type is not 1, protocol type is not 0x0800, hardware length is not 6, protocol length is not 4, or operation is neither 1 nor 2 | `error_arp_unsupported` | **no `arp_valid` and no record**; nothing is emitted for this packet | REQ-501 |
| An open packet closed with fewer than 28 ARP octets delivered — a truncated packet, or a frame with no payload frame at all (requirements.md §0.7) | `error_arp_unsupported` | the same | REQ-501, §0.7 |

Silent discard is prohibited (REQ-008): both rows have a strobe. The `clear`
mid-packet case of §7 is REQ-009's, not REQ-008's.

**When a packet is open, and what closes it** (the list both rows refer to,
SPEC-M03 §9's device — carry-forward **C-12**'s pattern). A packet is open from
the cycle M10 sees its `hdr_valid` pulse until the earliest of: the payload
`tlast` word; the next `hdr_valid` pulse; or `clear` (REQ-009). Every condition
in the table is evaluated **only while the packet is open**, and a payload word
arriving while no packet is open is ignored and pulses nothing. This is what
makes each packet's report a function of that packet rather than of whatever
follows it, and it is what §0.6's conservation equation needs: a strobe pulsed
after closure would be attributable to a packet already counted.

**Strobe cycle, pinned.** `error_arp_unsupported` pulses for exactly one cycle,
on the cycle §6.1 pins for that packet's single report: one cycle after the
earlier of the payload word carrying ARP octet 27 and the closing event. For the
64-octet frame of §6.1 that is Cp + 4; for a 27-octet packet it is one cycle
after the payload `tlast` word; for a frame with no payload frame it is one
cycle after the **next** `hdr_valid` pulse, which is the only event that can
close it.

*That last case has a reference word and the window is determinate on it —
corrected 2026-08-11, this paragraph having said the opposite* (§13; the same
misreading `FINDING ABS-1` convicted at requirements.md §0.6 and at SPEC-M04
§11.3, which this paragraph cited as its authority). A frame with no payload
frame receives **no octet at all** at this port, which is precisely §0.6's
**third** clause: the reference word is then the input word carrying the event
that closed the packet — here the next `hdr_valid` pulse — and the ceiling is ΔC
beyond it. The window is therefore not vacuous but **redundant**, which §0.6's
own note for that clause states: the pin above is one cycle after the closing
event and the ceiling is ΔC beyond the same event — §7 pins ΔC = **4** here — so
the pin lies well inside the window as a matter of arithmetic, and a green
against the window is evidence about the window and none about the pin. **The conclusion this paragraph drew does not move**:
this specification does not depend on the window, the pulse cycle above is exact
and computable from the input trace alone, and a bench that wants that cycle
asserts that cycle (§0.6, *"a bound, never a licence"*).

**Which conditions can co-occur on one packet, and what then pulses.**

- **A field violation with a length violation**: both apply, and
  `error_arp_unsupported` pulses **once**. REQ-501's own words are "discarded
  with a single `error_arp_unsupported` pulse", and requirements.md §0.6's
  "each applicable condition's strobe pulses once" is not in tension with it —
  §0.6 counts *strobes*, and REQ-501 gives all its conditions **one** strobe
  name. A bench that expects two pulses for a 27-octet packet with hardware type
  2 will fail a conformant design; §8's two-criteria directed packet exists to
  fix that reading in a test.
- **Two field violations**: one pulse, for the same reason.
- **A rejection with an inherited `payload_tuser`[0] = 1**: one pulse, and M10
  pulses nothing extra for the abort — it did not detect it, and re-reporting an
  inherited abort is forbidden (requirements.md §0.6). M10 does not read the bit
  at all (§7).
- There is no other pair: M10 owns one strobe and reports each opened packet
  once.

**Aborted-and-forwarded versus discarded-before-emission.** Every row here is
the second kind: M10 emits no record for a rejected packet, so requirements.md
§0.6's abort rule has no instance and the strobe is the only report. M10 has no
output stream on which a `tuser`[0] could be set.

## 10. REQ coverage

| REQ | How this module satisfies it | Section | Verification hook for DV |
|---|---|---|---|
| REQ-001 | one clock; no gated or derived clock | §3 | the emitted-Verilog edge-expression check |
| REQ-003 | payload input is `Axi64.Source` with no `Dest`; the `arp` record carries no `ready` | §4.1 | interface compile check |
| REQ-004 | sustains M08's ARP-port output pattern — 1 header pulse, 6 words, 4 or 5 idle cycles, alternating — for 10 000 packets | §8 | line-rate stress bench |
| REQ-005 | constant parse latency: the report cycle is a function of the packet's length alone, never of its field values or its padding | §6.1, §7 | criterion 3 of §8: interval equals 4 for all 10 000, one value not a mean |
| REQ-007, REQ-013 | `payload_tuser`[0] is read by nothing **here**; no packet is dropped at M10 because it is set; M10 originates and re-reports no abort. REQ-013's ultimate-consumer clause is discharged one module up, at M13 (ADR-0009) | §2, §7, §9 | drive `tuser`[0] = 1 on an otherwise-valid packet's `tlast`; assert `arp_valid` pulsed normally at Cp + 4 with correct fields and no strobe **at M10**, and — the other half of the same stimulus, asserted at M13 — that nothing was learned and no reply was generated (SPEC-M13 §10's REQ-503 row) |
| REQ-008 | one strobe; both discard rows carry it; the pulse cycle is pinned | §9 | directed rejection tests plus the conservation monitor of §8 criterion 1 |
| REQ-009 | `clear` empties the pipeline; mid-packet `clear` abandons it silently | §7 | reset test: assert mid-packet, deassert, open a packet on the next cycle and assert it parses intact |
| REQ-010 | payload is the programme `Axi64.Source`; `Arp_packet` is declared once, here, and opened by M11 and M13 | §4.1 | interface compile check; the `ifc_check` lift of SPEC-M11 and SPEC-M13 opening this module is the cross-check |
| REQ-011 | `payload_tkeep` read to count delivered octets against 28 | §6.1 | the 27-octet directed packet, whose `tkeep` marks three octets on word 3 |
| REQ-012 | every field decoded to a numeric value, first wire octet most significant | §6.1 | known-packet directed test comparing all five fields against hand-computed values, including the word-crossing sender protocol address |
| REQ-014 | `payload_tstrb` ignored | §4.2 | protocol monitor; REQ-014's differential run |
| REQ-015 | one `tlast` per payload frame; M10 needs no word bound | §3 | protocol monitor on the payload stream |
| REQ-016 | idle cycles delay the report by the idles injected at or before its deciding input word and change nothing else; §6.1's cycle formulas are gapless-only | §6.1, §7 | idle-injection wrapper at 0, 1 and 7 cycles, asserting the report is still **exactly one per opened packet** with the same value, and that it falls exactly **one cycle** after its **deciding input word D** — the earliest of the payload word carrying ARP octet 27 and the word carrying the closing event (§7's table). **Not** §6.1's gapless `Cp + 4` formula and **not** §7's per-octet constant L = 32, which M10 cannot satisfy under injection: its report is late-decided, so a wrapper asserting a single per-octet L fails a conformant design (requirements.md §0.5, which names M10 as the worked instance; this hook commissioned that assertion until 2026-08-11, §13). Per-octet latencies on an injected run may be **reported** as data and SHALL NOT be asserted as a single constant |
| REQ-019 | no §1.1 ceiling — M10 is off REQ-006's chain — and no buffering: 28 octets of captured fields, never re-emitted | §3, §7 | ΔC computed from the pinned L and h at freeze; measured parse latency from the stress run in the sign-off packet, quoted against "no ceiling" rather than against a number |
| REQ-020 | one packet at a time; order not expressible otherwise | §6.2 | the sender-protocol-address sequence in the stress run |
| REQ-021 | ARP octet 0 at `payload_tdata`[7:0] of payload word 0 at every frame length, so the nine offsets are fixed | §3, §6.1 | the directed packets, whose offsets are asserted against the table of §6.1 |
| REQ-401 | consumer side: `hdr_valid` is treated as a one-cycle pulse opening a packet, and a header with no payload frame is tolerated | §6.1, §7 | inject a 14-octet ARP-ethertype frame: exactly one `error_arp_unsupported`, no `arp_valid`, next packet intact |
| REQ-404 | consumer side: M10 does not re-check the ethertype and asserts nothing about a frame delivered here with another value | §4.2, §6.3 item 6 | none — stated so that no sign-off packet claims ethertype coverage here |
| REQ-501 | six acceptance criteria checked; one strobe on failure; one record on success; exactly one report either way | §6.1, §9 | the directed rejection set of §8 — hardware type, protocol type, both lengths, operations 0, 3 and 4, a 27-octet packet, a payload-less frame, and one packet failing two criteria at once |
| REQ-503 | **not** M10's: it decodes the sender addresses and stores nothing | §2 | none — stated so that no sign-off packet claims learning coverage here |
| REQ-802, REQ-810 | no instance: M10 reads no configuration, and REQ-810's receive half is M03's (SPEC-M03 §4.3) | §4.3 | none — stated so that no sign-off packet claims coverage here |
| REQ-903, REQ-808 | `arp_eth_rx` is a distinct emitted module with `create`, `hierarchical` and an `.mli` | §4.1 | repository surface check and the `rtl_snapshots/` name comparison |

This table is the source of M10's rows in [`traceability.md`](../traceability.md),
updated in the same commit.

## 11. Deferred items

Item numbers are permanent; a closed item keeps its row (SPEC-TEMPLATE §11).

| # | Item | Status · what a reader assumes meanwhile | Tracked as | Owner | Closes by |
|---|---|---|---|---|---|
| 11.1 | **The `ifc_check` compile evidence for this lift is pending**: `arp_eth_rx_ifc.ml` is new in this commit and carries the first compile-time witness of `Arp_packet`'s six field names. | **CLOSED (WO-0017).** CI `build` run **30736107842** at 2f29888 reports `success` with all four batch-D lifts in it, this one included, and `git diff a9993ff 2f29888 -- docs/specs/` is **empty**, so the run elaborated byte-identically the text drafted at a9993ff. dv_lead re-fetched the run from the GitHub API rather than taking it from the packet and re-ran `tools/check_records_vs_appendix.sh` at that tree — 16 checks, 0 failures, including this spec's §4.1-versus-lift row (`J-dv_lead-0008`, WO-0015 Return log §0). `Arp_packet`'s six field names are established by a run. | the `Interface compile check` row of §12 | architect_docs_lead, rtl_lead | closed |
| 11.2 | **`Arp_packet` lives in M10's specification rather than in M01's**, because M01 is FROZEN at f78766e and a field addition there would be a breaking post-freeze interface change (SPEC-TEMPLATE rule 7, charter §6). SPEC-M11 and SPEC-M13 therefore open `Arp_eth_rx_ifc`, and the RTL follows the same shape: the record is defined in `arp_eth_rx.ml` and referenced as `Arp_eth_rx.Arp_packet`. | **CLOSED (WO-0019), affirmatively: the placement is permanent for Phase 1.** Batch F reached the moment this row named — SPEC-M20 aggregates every record — and declined the promotion on its merits: moving `Arp_packet` into M01 would be a post-freeze §4.1 diff to the specification five freeze records cite, in exchange for a rename that changes no behaviour, no port name and no emitted Verilog. The rule instead extended once more, cleanly: SPEC-M18 §4.1 declares `Udp_tx_request` at its owning module and SPEC-M19 and SPEC-M20 open it, so five records now live outside M01 under one rule with no field restated anywhere. The promotion remains available at the same price — one spec diff plus an ADR — if a later phase reopens M01. | this item; SPEC-M01 §4.1; SPEC-M18 §4.1 | architect_docs_lead, rtl_lead | closed |
| 11.3 | **A frame whose FCS was wrong is parsed, accepted and learned from.** M03 marks it (REQ-104), REQ-013 forbids dropping a frame solely for the mark, REQ-501's acceptance list does not mention it, and §7 shows `payload_tuser`[0] arriving two or more cycles after M10's pinned report — so acting on it would cost REQ-005's constant. | **CLOSED (WO-0017), in the negative, by repair: the behaviour is changed rather than accepted.** dv_lead declined to close this item in the affirmative at the batch-D countersignature (owed diff **D-2**, `J-dv_lead-0008`): REQ-013's "the ultimate consumer must discard it" was discharged by nobody on the one receive branch with no application, so a corrupt frame committed a wrong IP → MAC binding for `entry_lifetime_cycles` with no strobe naming the cause. **ADR-0009** settles it: M13 is that ultimate consumer and gates the REQ-503 learning write and the REQ-502 reply on `rx_payload_tuser`[0] read at the packet's payload `tlast` (SPEC-M13 §6.1, §6.2 (D)); requirements.md REQ-503 gains the "and not marked invalid" qualifier and REQ-013 names the consumer per branch. **This item's own cost estimate was wrong and is corrected here rather than deleted**, because a wrong price in a deferred item is how a decision gets made for the wrong reason later: the repair needs **no** new `Arp_packet` field — the bit arrives on the payload `tlast` word, two or more cycles *after* the record is emitted, so no field of that record could carry it — and M13 already owns `rx_payload`, which it relays into M10. **Nothing at M10 changes**: not a port, not §6, not §7's L = 32 / h = 0 / ΔC = 4, not §9's pulse cycle. Only §2's abort row moves, to name M13 as the owner. | this item; requirements.md REQ-013, REQ-503; ADR-0009 | architect_docs_lead, dv_lead | closed |
| 11.4 | **`Arp_packet`'s `valid` has two disciplines** — a one-cycle pulse here (§7) and a level held until acceptance on the M13 → M11 edge (SPEC-M11 §7) — and the record itself cannot say which applies. | **CLOSED (WO-0019), affirmatively: the direction of the port decides, and batch F found no consumer needing the distinction carried in the type.** The rule now has four instances and no exception — `Eth_header` (SPEC-M06 §11.3), `Arp_packet` (here), `Ip_header` (SPEC-M14 §7 pulse / SPEC-M15 §7 level) and `Udp_header`, whose receive discipline is SPEC-M17 §7's one-cycle pulse and which has **no** transmit instance at all, because M18 builds the UDP header from a `Udp_tx_request` rather than from a header record (SPEC-M18 §4.1). SPEC-M16 §7 and SPEC-M19 §7 each carry both disciplines across their own ports in opposite directions and state so. A record field carrying the discipline would therefore be an addition to a FROZEN §4.1 that no port needs. | ADR-0008; SPEC-M06 §11.3; SPEC-M17 §7 | architect_docs_lead | closed |

## 12. Freeze record

Filled in at `P1-spec-freeze`. All four rows are required (charter §5); this
spec is DRAFT.

| Item | Value |
|---|---|
| Interface compile check | CI `build` run **30736107842**, conclusion **`success`**, SHA **2f29888** — all thirteen lifts elaborate, the four batch-D lifts for the first time; per ADR-0005 a local build is not acceptable evidence. `git diff a9993ff 2f29888 -- docs/specs/` is empty, so the run witnesses the text drafted at a9993ff. CI `build` run **30739442056** at the freeze SHA **3f6accc** is likewise **`success`** with every lift in it (dv_lead fetched it through the GitHub API rather than taking it from the packet, `J-dv_lead-0009` §0), so the **frozen** text carries compile evidence at its own SHA and no witnessing argument is owed for this row either. This run is also §11.1's closure record |
| Architect signature | `J-architect_docs_lead-0006`; D-2 repair and the C-20/C-21 diffs `J-architect_docs_lead-0007` |
| dv_lead testability countersignature | **`J-dv_lead-0009`** (WO-0018) — batch D **COUNTERSIGNED at 3f6accc**. This spec was already SIGNED on its own merits at a9993ff (`J-dv_lead-0008`, WO-0015 Return log §1); the batch signature followed the re-review of the D-1 and D-2 landing sites, byte-identity, set equality and a green run at 3f6accc |
| Frozen at | SHA **3f6accc**, gate `docs/gates/P1-spec-freeze-checklist.md` |

## 13. Change log

Post-freeze changes only. Every diff made under WO-0017 — §2's abort row,
§6.1's `clear` exception and its report-cycle qualifier, §6.3 item 4's constant,
§8's idle-count and conservation notes, §10's REQ-007/REQ-013 hook, §11.1 and
§11.3's closures and §12's evidence row — is a **pre-freeze correction on DRAFT
text**, which is the cheap kind and is why dv_lead withheld the countersignature
rather than freezing first, and none of it is a row here. *This paragraph read
"This spec is DRAFT and has none" until 2026-08-11, which §12 and the header have
contradicted since the freeze at `3f6accc`; the sentence is repaired in the diff
that opens the table.* **No row below is breaking**: §4.1's records are
byte-for-byte unchanged since the freeze SHA, so §12's `ifc_check` evidence still
witnesses this revision's interface.

| Date | Change | Breaking? | ADR | Journal |
|---|---|---|---|---|
| 2026-08-11 | **The per-octet-under-injection reading retired by requirements.md §0.5 is repaired at all four sites §13's 2026-08-04 row named for M10, and §7 now names D.** §7's handshake bullet: *"Idle gaps on the payload input (REQ-016) delay everything by exactly 8 octet times per cycle and change nothing else"* is replaced by §0.5's per-output-event rule, with a one-row table — M10 has exactly one output event per opened packet — naming the **deciding input word D** as *the earliest of the payload word carrying ARP octet 27 and the word carrying the event that closed the packet*, which is §6.1's own "earliest of" pair, at a delay of **1 cycle**. §7's latency bullet scopes L = 32 to a gapless stimulus and states the verdict: M10 **fails** §0.5's late-decision test and is that test's worked instance. §3's REQ-016 row and §6.1's gapped paragraph, which both asserted the retired claim in their own words, are repaired with them; §10's REQ-016 hook, which commissioned *"asserting the **constant** of §7"*, commissions the achievable observable instead. **The DRAFT sentence above this table is repaired in the same diff** | no — **no cycle this specification pins moves**: §6.1's table and its `Cp + 4`, §7's L = 32 / h = 0 / ΔC = 4, §9's report cycle and the interface records are untouched, and M10 has no RTL and no bench. What changes is what a bench may assert under injection | none — the retired reading is arithmetically unsatisfiable at a late-deciding module rather than rejected among live alternatives; `requirements.md` §13's 2026-08-04 row gives the same ground for the ruling this discharges | `J-architect_docs_lead-0038` |
| 2026-08-11 | **§9's vacuity paragraph is corrected: the no-payload case has a reference word, and the window there is redundant rather than vacuous.** The paragraph read *"That last case is inside requirements.md §0.6's window only vacuously, because a frame with no payload has no 'input word carrying the last octet of the offending frame' for the window to be measured from — the same vacuity carry-forward **C-5** records against `error_underflow` (SPEC-M04 §11.3)"*. Both halves are wrong. §0.6's **third** clause — *"a frame that received no octet at all takes its closing word"* — was written for exactly this class and names the input word carrying the closing event, here the next `hdr_valid` pulse; and the SPEC-M04 case it cited as the same vacuity is not vacuous either, which is what `FINDING ABS-1` (dv_lead, `J-dv_lead-0173` §(c), ruled at `J-architect_docs_lead-0040`) convicted at requirements.md §0.6 in the same round. The paragraph now states the determinate reference word and the reason the window is worth nothing here anyway — the pin is the closing event + 1 and the ceiling is the closing event + ΔC = 4 (§7), so the pin sits well inside the window and a green against the window is evidence about the window and none about the pin (§0.6's *"a bound, never a licence"*). **This site was not in the finding's site list**: it was found by a census this round ran over every specification for the retired ceiling phrase, which is the survey carry-forward item 50 has been asking for; ABS-1 named two sites, the census found four, and this is the fourth | no — **editorial**: the paragraph's conclusion is unchanged (this specification does not depend on §0.6's window), the pinned pulse cycle, ΔC, L, h and every strobe are untouched, and no bench asserts the window here | none — a false ground under a true conclusion is a correction of record; requirements.md §13's 2026-08-11 `ABS-1` row carries the ruling that reaches all four sites | `J-architect_docs_lead-0040` |
