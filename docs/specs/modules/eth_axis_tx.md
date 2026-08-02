# SPEC-M07 — `Eth_axis_tx`

- **Status**: **FROZEN** (`P1-spec-freeze`, SHA `508eea2`) — batch C, dv_lead
  countersignature `J-dv_lead-0007`. Changes to §4, §6 or §7 after this point
  are spec diffs recorded in §13 (SPEC-TEMPLATE rule 7)
- **Inventory id**: M07 (architecture.md §4) · **Path**:
  `libs/hardcaml_ethernet/src/eth_axis_tx.ml`
- **Datapath role**: transmit
- **Owns REQs**: REQ-405, REQ-409 (transmit half)
- **Prior-art counterpart**: `eth_axis_tx.v` (MIT) — consulted for decomposition
  and port naming only; behaviour below is stated independently and no source
  was copied
- **Depends on specs**: SPEC-M01 (`Axi64`, `Eth_header`), SPEC-M04
  (`Xgmii_tx_64`, the module this one feeds), SPEC-M09 (`Eth_arb_mux`, its
  source), ADR-0008 (the transmit-side header handshake)
- **Author**: architect_docs_lead, journal `J-architect_docs_lead-0005`

## 1. Purpose

M07 is M06 run backwards: it takes an Ethernet **header record** and a
**payload stream** and emits one frame stream whose first fourteen octets are
the header and whose remainder is the payload, octet order preserved. It exists
as a separate module for the same reason M06 does — the 14-octet header is not a
multiple of eight, so something has to own the realignment, and putting it here
means neither the ARP transmitter nor the IPv4 transmitter has to know that
Ethernet framing is misaligned with a 64-bit datapath.

Its upstream is M09 `Eth_arb_mux`, which has already chosen between the ARP and
IPv4 transmit sources; its downstream is M04 `Xgmii_tx_64` (through the M16,
M19 and M05 wrappers), which adds the preamble, the padding, the FCS and the
gap. It instantiates nothing.

## 2. Scope

**In scope.**

- Emitting the fourteen header octets — destination MAC, source MAC, ethertype —
  from the `Eth_header` record, in wire order, followed by the payload stream
  with its octet order preserved (REQ-405, REQ-409).
- The realignment that follows from a 14-octet header on a 64-bit datapath:
  every output word from the second onward is assembled from two payload words
  (§6.1).
- The transmit-side header handshake of ADR-0008: the record and the frame's
  first payload word are offered together and held until that word is accepted.
- Backpressure in both directions — accepting a payload word only when the word
  it will produce can be transmitted (REQ-207's discipline one stage up).

**Not this module's job.**

| Behaviour a reader might expect here | Owner |
|---|---|
| The preamble, the start character, padding to 60 octets, the FCS, the terminate character, the inter-frame gap | M04 `Xgmii_tx_64` (REQ-201 … REQ-205). M07 emits destination address through payload and nothing else |
| Choosing between the ARP and IPv4 transmit sources | M09 `Eth_arb_mux` (REQ-406). By the time a frame reaches M07 the choice is made and cannot be revisited: M07 has no second input port to interleave from |
| Resolving a destination MAC address | M13 `Arp` (REQ-505 … REQ-509). M07 copies `dst_mac` out of the record and never asks where it came from |
| Reporting that the application supplied the wrong number of octets | M18 `Udp_ip_tx_64` (REQ-709, REQ-710); the wire consequence is M04's `error_underflow` (REQ-206). M07 detects nothing and raises no strobe (§9) |
| Knowing the frame's length before it arrives | nobody: M07 terminates on the payload's `tlast`, exactly as M04 does (SPEC-M04 §2) |
| Padding a short frame | M04 (REQ-203). A 14-octet frame — header, no payload — is not a Phase-1 stimulus (§6.3 item 3) |

## 3. Programme invariants that bind this module

M07 is **not** a receive-path module under requirements.md §0.4: it is on the
transmit chain, its `tready` towards its payload source is legitimate, and
§1.1 allocates it no latency ceiling.

| REQ | Consequence for M07 |
|---|---|
| REQ-001 | One `clock`, shared with the receive path (REQ-018 keeps the XGMII boundary simulation-only, so there is no second domain). |
| REQ-002 | Payload input and frame output are 64-bit `Axi64` streams, at most one word per cycle each. |
| REQ-003 | Does not bind M07's ports — but REQ-208 does: nothing here may reach back into the receive datapath, and nothing does, because M07 has no receive-side port. |
| REQ-005 | Does not bind M07 (not a receive-path module). Its analogue is §7's pinned one-cycle constant, which no requirement obliges but which is stated so that M09's and M04's cadences compose. |
| REQ-007, REQ-013 | `tuser`[0] on the payload's `tlast` word is copied to the frame's `tlast` word and is **not** acted on: M07 transmits the frame regardless, which is REQ-013's "no module drops a frame solely because this bit is set". |
| REQ-008 | M07 owns **no** strobe: it detects no condition (§9). |
| REQ-009 | Synchronous `clear`: `tx_tvalid` = 0 and `payload_tready` = 0 while `clear` = 1 and on the first cycle after; a frame in flight is abandoned with no `tlast` (§7). |
| REQ-010 | Payload in and frame out are the programme `Axi64.Source`, each with the matching `Axi64.Dest` in the other direction — the transmit-path pattern of architecture.md §2.3. The header is SPEC-M01's `Eth_header`, unchanged. |
| REQ-011 | `tkeep` on the incoming payload `tlast` word says how many octets of that word are payload; `tkeep` on the emitted `tlast` word marks exactly the octets the frame carries. |
| REQ-012 | Header octets are emitted first wire octet first: `dst_mac`[47:40] is frame octet 0. Payload octet position k maps to the frame octet 14 + k (§6.1). |
| REQ-014 | `tstrb` on the payload input is ignored; `tstrb` on the frame output is driven to 0. |
| REQ-015 | One `tlast` per frame in each direction. At most **190** words between two `tlast` words on the output stream (1514 octets: 14 header octets plus a 1500-octet maximum payload, REQ-612), the `tlast` word included. |
| REQ-016 | The payload source **may** deassert `tvalid` between words and M07 tolerates it without corrupting the frame — M07 simply does not advance. REQ-016's tolerance stops one module later: M04 treats a missing word as an underflow (REQ-206), and M07 never presents a word to M04 that it has not already accepted. |
| REQ-020 | Frames leave in the order M09 granted them; M07 holds one frame at a time. |
| REQ-021 | Producer-side word alignment holds trivially at M07's output — frame octet 0, the first destination-address octet, is at `tx_tdata`[7:0] of output word 0 — but the *work* is the same realignment M06 does in reverse, and §6.1 states it rather than letting the trivial reading hide it. |

## 4. Interface

### 4.1 Interface records

```ocaml
(* SPEC-M07 §4.1, lifted verbatim into docs/specs/ifc_check/eth_axis_tx_ifc.ml
   (SPEC-TEMPLATE.md rule 6). Records and signatures only — no logic, no
   implementation.

   [Axi64_ifc] is M01's types home (SPEC-M01 §4.1): [Axi64] and
   [Eth_header] come from there and are restated nowhere.

   Transmit-path module, so [Source] one way and [Dest] the other on each
   of the two logical streams. The payload stream's [Source] is an input
   and its [Dest] an output; the frame stream's [Source] is an output and
   its [Dest] an input. The two directions of one stream share a prefix —
   "payload_" and "tx_" — with no collision, because [Source]'s field
   names and [Dest]'s are disjoint (SPEC-M04 §4.1 fixes that pattern).

   [hdr] carries no [ready]: its acceptance event is the acceptance of
   the frame's first payload word (ADR-0008), which is what lets M01's
   [Eth_header] serve both datapath directions unchanged. *)

open! Base
open Hardcaml
open! Axi64_ifc

module I = struct
  type 'a t =
    { clock : 'a
    ; clear : 'a
    ; hdr : 'a Eth_header.t [@rtlprefix "hdr_"]
    ; payload : 'a Axi64.Source.t [@rtlprefix "payload_"]
    ; tx_dest : 'a Axi64.Dest.t [@rtlprefix "tx_"]
    }
  [@@deriving hardcaml]
end

module O = struct
  type 'a t =
    { payload_dest : 'a Axi64.Dest.t [@rtlprefix "payload_"]
    ; tx : 'a Axi64.Source.t [@rtlprefix "tx_"]
    }
  [@@deriving hardcaml]
end

module type S = sig
  val create : Scope.t -> Signal.t I.t -> Signal.t O.t
  val hierarchical : ?instance:string -> Scope.t -> Signal.t I.t -> Signal.t O.t
end

(* REQ-010 type identity in both directions of both streams. *)

let _witness_both_directions
      (s : Signal.t Axi64.Source.t)
      (d : Signal.t Axi64.Dest.t)
  =
  s, d
;;
```

Conformance of this block to the template's rules for §4.1:

- Scalar fields carry `[@bits n]` unless one bit wide: `clock` and `clear` are
  one bit; every other field is inside a nested record carrying its own widths.
- Nested interfaces carry `[@rtlprefix]`: `hdr` emits `hdr_valid`,
  `hdr_dst_mac`, `hdr_src_mac`, `hdr_ethertype`; `payload` and `payload_dest`
  emit `payload_tvalid` … `payload_tuser` and `payload_tready`; `tx` and
  `tx_dest` emit `tx_tvalid` … `tx_tuser` and `tx_tready`.
- **`Source` one way and `Dest` the other, on each logical stream**: held. M07
  is allowed both because it is not a receive-path module (requirements.md
  §0.4); REQ-208, not REQ-003, is what keeps its backpressure away from the
  receive datapath, and REQ-208 holds structurally because M07 has no receive
  port at all.
- Both `create` and `hierarchical` are declared (REQ-903, REQ-808).

### 4.2 Port table

Every port in §4.1 appears exactly once. Direction is with respect to M07.

| Port | Dir | Width | Meaning | REQ |
|---|---|---|---|---|
| `clock` | in | 1 | 156.25 MHz single domain | REQ-001 |
| `clear` | in | 1 | synchronous clear | REQ-009 |
| `hdr_valid` | in | 1 | a frame is offered; held high until its first payload word is accepted (ADR-0008) | REQ-405 |
| `hdr_dst_mac` | in | 48 | destination MAC as a numeric value; emitted first wire octet first | REQ-409, REQ-012 |
| `hdr_src_mac` | in | 48 | source MAC, same encoding | REQ-409, REQ-012 |
| `hdr_ethertype` | in | 16 | ethertype as a numeric value; 0x0800 is emitted as octets 0x08, 0x00 | REQ-409, REQ-012 |
| `payload_tvalid` | in | 1 | the source presents a payload word this cycle | REQ-016 |
| `payload_tdata` | in | 64 | payload octets, word-aligned at the producer (REQ-021) | REQ-012 |
| `payload_tkeep` | in | 8 | valid octet positions; 1 to 8 contiguous ones on the `tlast` word | REQ-011 |
| `payload_tstrb` | in | 8 | reserved; ignored | REQ-014 |
| `payload_tlast` | in | 1 | this word carries the payload's final octets | REQ-015 |
| `payload_tuser` | in | 1 | bit 0 advisory abort; copied out, never acted on | REQ-013, REQ-007 |
| `payload_tready` | out | 1 | M07 accepts a payload word this cycle; an accepted word is always transmitted | REQ-207 (one stage up) |
| `tx_tvalid` | out | 1 | this cycle carries a word of the frame | REQ-016 |
| `tx_tdata` | out | 64 | frame octets, first destination-address octet at position 0 | REQ-012, REQ-021 |
| `tx_tkeep` | out | 8 | valid octet positions, contiguous from bit 0 | REQ-011 |
| `tx_tstrb` | out | 8 | reserved; driven to 0 | REQ-014 |
| `tx_tlast` | out | 1 | this word carries the frame's final octets | REQ-015 |
| `tx_tuser` | out | 1 | bit 0: the inherited advisory abort, on the `tlast` word | REQ-013, REQ-007 |
| `tx_tready` | in | 1 | the consumer (M04) accepts a word this cycle | REQ-207 |

### 4.3 Configuration inputs

**None.** M07 reads no field of the `Config` record. Every value it puts on the
wire arrives in the `Eth_header` record: `local_mac` reaches the frame as
`hdr_src_mac`, filled in by M15 or M11, which are the modules that know whether
a frame is IPv4 or ARP. Concentrating configuration at the module that *decides*
a field, rather than at the module that *emits* it, is SPEC-M01 §4.2's
convention applied — and it means REQ-803 has no instance here, since there is
no configuration input whose change could land inside a frame.

## 5. Parameters

**None.** REQ-506's rule has no instance: M07 has no timeout, no ageing interval
and no retry. Its one numeric constant, 14, is the Ethernet II header length
fixed by REQ-405.

| Parameter | Type | Default | Range | Why a test overrides it |
|---|---|---|---|---|
| (none) | — | — | — | — |

## 6. Behaviour

### 6.1 Normal path

**The header M07 writes**, with the octet offsets a test writer needs to
hand-assemble the reference frame REQ-405 compares against. Offsets are from the
first octet M07 emits.

| Field | Octet offset | Width | Source | Wire order |
|---|---|---|---|---|
| destination MAC | 0–5 | 48 bits | `hdr_dst_mac` | most significant octet first: `hdr_dst_mac`[47:40] is octet 0 |
| source MAC | 6–11 | 48 bits | `hdr_src_mac` | same |
| ethertype | 12–13 | 16 bits | `hdr_ethertype` | `hdr_ethertype`[15:8] is octet 12; ethertype 0x0800 emits 0x08 then 0x00 |

**The offer (ADR-0008).** A frame is offered to M07 when `hdr_valid` = 1 **and**
`payload_tvalid` = 1 for the frame's first payload word, asserted on the same
cycle and held, with all four header fields and the payload word stable, until
M07 accepts that word (`payload_tready` = 1). The header record therefore needs
no `ready` of its own, and M01's `Eth_header` serves both datapath directions
without a field that REQ-003 would forbid on the receive side. The header is
captured on the acceptance cycle and the source may drop `hdr_valid` on the next
cycle.

**Where the payload lands.** Frame octet 14 + k is payload octet k, so output
word 0 is header only, output word 1 is header octets 8–13 plus payload octets 0
and 1, and output word n ≥ 2 carries payload octets 8n − 14 through 8n − 7 —
which lie in payload words n − 2 (positions 2 to 7) and n − 1 (positions 0 and
1). That is the realignment, and it is why M07 holds **two** payload words.

**On an unstalled frame** (`tx_tready` = 1 throughout), with C the cycle on which
M07 accepts the frame's first payload word:

- output word 0 is emitted on cycle **C + 1**, and output word n on cycle
  **C + 1 + n**;
- payload word j is accepted on cycle **C + j**, so the payload word an output
  word needs is always accepted at least one cycle before that word leaves.

**Cycle by cycle, a 46-octet payload** — the ARP-sized frame the transmit path
most often carries, and the one whose output length matches §8's reference
figure. Payload words: 6 (five full, one carrying 6 octets). Output words:
⌈(14 + 46)/8⌉ = 8 (seven full, one carrying 4 octets).

| Cycle | `payload_tready` | Payload input | XGMII-side output (`tx`) |
|---|---|---|---|
| C | 1 | payload word 0 accepted (payload octets 0–7) | `tx_tvalid` = 0 |
| C+1 | 1 | payload word 1 accepted | output word 0: frame octets 0–7 (destination MAC, source MAC[0:1]) |
| C+2 | 1 | payload word 2 accepted | output word 1: frame octets 8–15 (source MAC[2:5], ethertype, payload 0–1) |
| C+3 … C+5 | 1 | payload words 3–5 accepted; word 5 carries 6 octets with `tlast` = 1 | output words 2–4: frame octets 16–39 |
| C+6 | **0** | — | output word 5: frame octets 40–47 |
| C+7 | 0 | — | output word 6: frame octets 48–55 |
| C+8 | 0 | — | output word 7: frame octets 56–59, `tkeep` = 0x0F, `tlast` = 1, `tuser`[0] copied from the payload's `tlast` word |
| C+9 | 1 if a frame is offered | next frame's payload word 0 | `tx_tvalid` = 0 |

`payload_tready` falls for the last **three** cycles of this frame because M07
emits **more** words than it consumes: it adds fourteen octets, so
W = ⌈(14 + P)/8⌉ output words come from J = ⌈P/8⌉ payload words, with W − J
equal to 1 for P ≡ 1 or 2 (mod 8) and 2 at every other payload length. The
count of zero cycles is **W − J + 1**, so it is **two or three** and not one or
two: the frame's last payload word is accepted on cycle C + J − 1 and its last
output word leaves on cycle C + W, and `payload_tready` is 0 on every cycle
between, inclusive — C+6, C+7 and C+8 in the table above, where J = 6 and
W = 8. Those two or three cycles are the whole of M07's backpressure on an
unstalled frame, and they are the reason M07 is a transmit-path module and could
not be a receive-path one.

*The `+ 1` is carry-forward **C-17(b)*** (dv_lead), and it was wrong in three
places at once — here, in §6.2's `Drain` row and in §7's throughput bullet. It
matters because a throughput assertion built from "one or two" fails **every**
conformant design, at every payload length, including the 46-octet frame this
table shows. W − J is the number of *extra words* M07 emits and is correctly 1
or 2; the number of *stalled cycles* is one more than that, because the cycle
on which the last payload word is accepted is not itself a stalled cycle and the
cycle on which the last output word leaves is.

**When the consumer stalls.** `payload_tready` is 1 only when `tx_tready` is 1
and the frame still needs payload words, so a cycle on which M04 cannot accept a
word is a cycle on which M07 accepts none either: the two words in flight are
held in their registers, nothing is dropped and nothing is duplicated
(REQ-207's discipline, applied one stage before M04). Every cycle formula above
shifts by exactly the number of stalled cycles.

**When the source stalls.** The payload source may deassert `payload_tvalid`
between words (REQ-016) and M07 simply does not advance: it emits no output word
that cycle. Nothing downstream breaks, because M07 never presents a word to M04
it has not already accepted — which is precisely why REQ-016's tolerance can end
at M04's port (REQ-206) without a buffer anywhere.

### 6.2 State machine

Reset state and `clear` state are both `Idle`.

| State | Entered when | Does | Leaves to |
|---|---|---|---|
| `Idle` | reset; `clear`; the frame's `tlast` output word is accepted | `tx_tvalid` = 0; `payload_tready` = 1 when `hdr_valid` = 1 and `tx_tready` = 1, and 0 otherwise | `Header` on the cycle the frame's first payload word is accepted, capturing the four header fields |
| `Header` | the first payload word is accepted | emits output word 0 (header only) on the next cycle, then output word 1 (header tail plus payload octets 0–1); keeps accepting payload words while `tx_tready` = 1 | `Body`, always, after output word 1 |
| `Body` | output word 1 has been emitted | emits output word n from payload words n − 2 and n − 1; accepts a payload word on every cycle `tx_tready` = 1 until the payload's `tlast` word has been accepted | `Drain` on accepting the payload `tlast` word |
| `Drain` | the payload `tlast` word has been accepted | emits the remaining **two or three** output words — W − J + 1 of them, §6.1 — the last carrying `tx_tlast` = 1, the `tkeep` the payload length implies and the inherited `tuser`[0]; holds `payload_tready` = 0 throughout (C-17(b)) | `Idle` when that word is accepted |

A cycle on which `tx_tready` = 0, or on which the source presents no payload
word, holds every state and every register: it is not a condition and it
advances nothing (§6.1).

### 6.3 Deliberately unconstrained

Anything not listed here is constrained by this specification, and a test may
rely on it.

1. **The placement of the register levels** inside the one-cycle delay, and every
   internal encoding: the FSM encoding, how the 14-octet realignment shift is
   built, whether the header is held in one register or three. §7's constant is
   what is fixed.
2. **`payload_tready` on cycles when no frame is offered** — M07 may hold it low
   or hold it high waiting for a source, provided it never accepts a word it
   cannot then transmit and never accepts a payload word before the header
   record accompanying it is valid (ADR-0008). What it may **not** do is accept
   a word and drop it.
3. **M07's behaviour when a header is offered with no payload word** — a frame
   of exactly fourteen octets. Phase 1 never produces one: every transmit frame
   carries at least 28 octets of payload (an ARP packet, REQ-501) or at least 28
   (a 20-octet IPv4 header plus an 8-octet UDP header, REQ-610). ADR-0008 makes
   the simultaneous offer of header and first payload word an obligation on the
   source for exactly this reason, so the case is unreachable rather than
   undefined, and DV SHALL assert nothing about it.
4. **The value of `tx_tdata` at positions where `tx_tkeep` is 0**, and every
   output field on a cycle with `tx_tvalid` = 0 (SPEC-M01 §6.3 item 5).

## 7. Timing contract

- **Latency.** Pinned at **1 cycle**: the frame's first output word is emitted
  on the cycle after M07 accepts the frame's first payload word. The two
  measurement events are the cycle on which `payload_tvalid` and
  `payload_tready` are both 1 for the frame's first payload word, and the cycle
  on which `tx_tvalid` is 1 for that frame's first output word. Both sit at
  octet position 0 of their words, so the figure is exactly 8 octet times and
  not a rounding.

  M07 is not a receive-path module: requirements.md §1.1 allocates it no ceiling
  and REQ-006's budget does not contain it. **No requirement constrains the
  value of this constant** — only that this specification states one, so that
  M09's grant cadence and M04's 11-cycle frame period compose against a known
  figure. It is 1 cycle because output word 0 is a function of the header record
  alone and a registered output cannot do better; changing it later is an
  ordinary spec diff with no budget consequence.

  Measured with `tx_tready` held 1 throughout, exactly as REQ-210 measures M04's
  constant with the gap obligation already satisfied. A downstream stall delays
  everything by the number of stalled cycles and is outside this constant's
  domain.

- **Throughput.** One payload word accepted per cycle while `payload_tready` is
  1; one output word emitted per cycle while `tx_tready` is 1. Over a frame M07
  emits **one or two more** words than it consumes — W − J, which is the
  fourteen header octets — so it costs the transmit path one or two cycles per
  frame that M04's inter-frame gap absorbs. `payload_tready` is 0 for the
  frame's last **W − J + 1 = two or three** cycles, one more than the word
  surplus (§6.1, carry-forward **C-17(b)**): the last payload word is accepted
  at C + J − 1 and the last output word leaves at C + W, and every cycle
  strictly after the first and up to and including the second is a stalled one.
  M07 never emits two words in one cycle and never accepts two.

- **Handshake rules.** A payload word is accepted on a cycle with
  `payload_tvalid` = 1 and `payload_tready` = 1; an accepted word is always
  transmitted. An output word is accepted on a cycle with `tx_tvalid` = 1 and
  `tx_tready` = 1; M07 holds `tx_tvalid` and the word's contents stable until
  that happens, which is what SPEC-M04 §7 relies on when it says a word
  presented on the first cycle after `clear` is accepted on the next.

  **The header record's `valid` is a level here, not a pulse.** `hdr_valid` = 1
  from the offer until the frame's first payload word is accepted, with the
  three field values stable throughout (ADR-0008). This is the opposite
  discipline to the receive side, where REQ-401 makes `valid` a one-cycle pulse
  (SPEC-M06 §7). Both are correct for their direction — a receive-path record
  cannot carry a `ready` without violating REQ-003, and a transmit-path record
  needs an acceptance event — and the direction of a port is what says which
  applies. A monitor written for one and attached to the other reports a defect
  that is not there.

  Idle gaps on the payload input (REQ-016) are tolerated and delay everything by
  the number of idle cycles. REQ-016's tolerance ends one module later, at M04's
  source port (REQ-206), and M07 is what makes that safe.

- **Reset.** While `clear` = 1 and on the first cycle after it returns to 0:
  `tx_tvalid` = 0 and `payload_tready` = 0, and the lanes M04 drives carry idle
  because M04 is in the same reset (SPEC-M04 §7). `clear` asserted mid-frame
  abandons the frame with **no** `tlast` word — the frame simply stops, which is
  REQ-009's explicit permission and is the only silent frame loss in this
  specification. A frame offered on the first cycle after `clear` returns to 0
  is transmitted correctly: its first payload word is not accepted on that
  cycle, the source holds it (ADR-0008), and M07 accepts it on the next.

- **Configuration sampling.** None; M07 reads no configuration (§4.3).

## 8. Line-rate stress obligation

**Not applicable.** M07 is not in requirements.md §0.4's stress-bench list (M03,
M06, M08, M10, M14, M17, M20), which enumerates *receive-path* modules —
REQ-004's invariant is about surviving an arrival rate the module cannot slow
down, and M07 can slow its source down, by two or three cycles per frame,
exactly as §7 states.

Its equivalent obligation is the transmit chain's sustained bench: M04's
REQ-209 run of 10 000 minimum-length frames, driven **through** M09 and M07 from
a payload source, asserting that the mean is 11 cycles per frame and that no
individual inter-frame spacing differs from 11. That run is what proves M07's
one-or-two-cycle backpressure fits inside M04's gap rather than lengthening the
frame period; a bench that drives M04 directly proves nothing about M07. The
stimulus is a 46-octet payload with the header record fields of SPEC-M03 §8's
frame (destination `02:00:00:00:00:01`, source `02:00:00:00:00:02`, ethertype
0x0800), which is what makes a 64-octet frame on the wire.

**Two figures this run must be asserted against, and one it must not.** M07's
drain is **three** cycles for this payload — `payload_tready` = 0 at C+6, C+7
and C+8 of §6.1's table (C-17(b)) — and M07 returns to `Idle` at C+9, which in
M04's timebase is the cycle SPEC-M04 §7 pins `tx_tready` = 1 on and which the
11-cycle cadence turns on (SPEC-M04's carry-forward **C-16**). A bench asserting
a drain of two cycles fails a conformant design; a bench asserting that M04's
`tx_tready` is 0 on that cycle fails the whole composition.

## 9. Errors and discards

**Not applicable as a detection table.** M07 detects no abnormal condition and
raises no strobe. Every condition on the transmit path is owned elsewhere: a
missing word is M04's `error_underflow` (REQ-206), a declared-length mismatch is
M18's `error_tx_length_mismatch` (REQ-709, REQ-710), an unresolvable destination
is M13's `error_arp_miss` (REQ-505). M07 sees a header record and a payload
stream, both already committed by M09's grant, and has nothing left to decide.

| Condition | Strobe (one cycle) | Stream effect | REQ |
|---|---|---|---|
| (none detected here — see above) | — | — | — |

**REQ-008 is not weakened by an empty table.** M07 discards nothing: every
payload word it accepts is transmitted (§7), and a frame it has begun is
completed unless `clear` truncates it, which is REQ-009's permission and not a
silent discard. Frame conservation (requirements.md §0.6) at M07's ports is the
identity — one frame in, one frame out — which is exactly what a monitor should
assert here.

**Inherited aborts.** `payload_tuser`[0] on the payload's `tlast` word is copied
to the frame's `tlast` word and nothing else happens (REQ-013, REQ-007). M07
pulses nothing for it: re-reporting an inherited abort is forbidden by
requirements.md §0.6, and M07 has no strobe to re-report it with.

## 10. REQ coverage

| REQ | How this module satisfies it | Section | Verification hook for DV |
|---|---|---|---|
| REQ-001 | one clock; no gated or derived clock | §3 | the emitted-Verilog edge-expression check |
| REQ-007, REQ-013 | inherited `tuser`[0] copied to the output `tlast` word and never acted on | §9 | drive `tuser`[0] = 1 on a payload `tlast` word; assert the frame is transmitted unchanged with the bit set |
| REQ-009 | `clear` abandons the frame and holds both `tready` and `tvalid` low | §7 | reset test: assert mid-frame, deassert, offer a frame on the next cycle and assert it transmits intact |
| REQ-010 | `Source` and `Dest` on both streams, from the programme types | §4.1 | interface compile check |
| REQ-011 | `tx_tkeep` `0xFF` except on `tlast`; the payload's `tkeep` decides the frame's last-word extent | §6.1 | protocol monitor on both streams |
| REQ-012, REQ-409 | header fields emitted first wire octet first; the ethertype's octet order is the case most often got wrong | §6.1 | REQ-405's octet-for-octet comparison, which includes a MAC field and the ethertype |
| REQ-014 | `tstrb` ignored in, driven 0 out | §4.2 | protocol monitor; REQ-014's differential run |
| REQ-015 | one `tlast` per frame; at most 190 output words, the `tlast` word included | §3, §7 | protocol monitor |
| REQ-016 | payload idle cycles tolerated; M07 does not advance and emits nothing | §6.1, §7 | idle-injection wrapper at 0, 1 and 7 cycles on the payload stream, asserting the output octet sequence is unchanged |
| REQ-021 | frame octet 0 at `tx_tdata`[7:0]; the payload realignment is the inverse of M06's | §6.1 | payload lengths covering every residue modulo 8, asserting the octet string on the wire |
| REQ-207 | an accepted payload word is always transmitted; `payload_tready` is 0 when M07 cannot accept | §6.1, §7 | drive a continuous source; assert the transmitted octet sequence equals the accepted-word octet sequence exactly once, in order, and that the run of 0 cycles at each frame's end is **W − J + 1** — two or three, never one (C-17(b)) |
| REQ-208 | M07 has no receive-side port, so no path from here into the receive datapath exists | §3 | inspection of the emitted netlist; REQ-208's top-level test |
| REQ-405 | fourteen header octets then the payload, octet order preserved | §6.1 | compare the built frame against a hand-assembled reference frame, octet for octet |
| REQ-406 | no instance: M07 has one input port and cannot interleave | §2 | none — stated so that no sign-off packet claims arbitration coverage here |
| REQ-903, REQ-808 | `eth_axis_tx` is a distinct emitted module with `create`, `hierarchical` and an `.mli` | §4.1 | repository surface check and the `rtl_snapshots/` name comparison |

This table is the source of M07's rows in [`traceability.md`](../traceability.md),
updated in the same commit.

## 11. Deferred items

Item numbers are permanent; a closed item keeps its row (SPEC-TEMPLATE §11).

| # | Item | Status · what a reader assumes meanwhile | Tracked as | Owner | Closes by |
|---|---|---|---|---|---|
| 11.1 | **The `ifc_check` compile evidence for this lift is pending**: `eth_axis_tx_ifc.ml` is new in this commit. | **CLOSED (WO-0014).** CI `build` run **30733153172** at f457efc reports `success` with this lift in it, and `git diff 508eea2 f457efc -- docs/specs/ifc_check/` is empty, so the run witnesses the record frozen here. | the `Interface compile check` row of §12 | architect_docs_lead, rtl_lead | closed |
| 11.2 | **The transmit-side header handshake is a programme convention, not this module's invention** (ADR-0008): header and first payload word offered together, held until that word is accepted. M09, M11, M15 and M18 all rely on it, and only M07 and M09 are specified so far. | **CLOSED (WO-0017), affirmatively: two of the three sources have now restated the obligation and neither needed an exception.** SPEC-M11 §7 (batch D) restated decisions 1, 2 and 4 with one substitution at its record-only *input* port, which dv_lead judged an **instantiation** of ADR-0008 rather than a supersession (`J-dv_lead-0008`, WO-0015 Return log §4/Q1), and SPEC-M15 §7 (batch E) restates all three at its output with no substitution at all — decision 4 satisfied structurally, because every transmit datagram carries at least a 20-octet IPv4 header plus an 8-octet UDP header (REQ-610). The ADR needed no amendment for either; it gained one clause, C-22's precedence rule, which is about monitors and not about sources. SPEC-M18 (batch F) is the third and last source and restates it in its own §7; with two of three confirmed and neither needing an exception, that restatement is a template obligation on batch F rather than an open question here, which is why this item closes now instead of waiting for it. | ADR-0008 | architect_docs_lead | closed |
| 11.3 | **M07 has no bench of its own in requirements.md's process REQs**: §0.4's stress list is receive-path only, and REQ-209's sustained transmit bench is written against M04. | **CLOSED (WO-0013), answered in the negative.** dv_lead declined to make it a REQ: §8 already states both the obligation and the stimulus, SPEC-M09 §8 item 5 commissions the same run independently, and a REQ reading "run REQ-209's bench through M09 and M07" would add no testable fact either specification does not already carry — requirements.md §0.2's "one REQ states one testable fact" is the test it would fail. No requirements.md diff is owed. | this item; SPEC-M04 §8; WO-0013 Return log | architect_docs_lead, dv_lead | closed |
| 11.4 | **The drain count was stated as W − J in three places** — §6.1's prose, §6.2's `Drain` row and §7's throughput bullet — while §6.1's own cycle table shows W − J + 1. A throughput assertion built from the prose fails every conformant design at every payload length. | **CLOSED (WO-0014).** All three now read **W − J + 1 = two or three**, with the derivation stated once in §6.1 and the distinction between the word surplus (W − J) and the stall count (W − J + 1) made explicit; §8 names the figure the composed run must assert and ties it to SPEC-M04's C+8 cycle; §10's REQ-207 hook carries the prohibition. No constant, state or record changes. | ledger **C-17** (item (b)) | architect_docs_lead | closed |

## 12. Freeze record

Filled in at `P1-spec-freeze`. All four rows are required (charter §5).

| Item | Value |
|---|---|
| Interface compile check | CI `build` run **30733153172**, conclusion **`success`**, SHA **f457efc** — all nine batch-A/B/C lifts elaborate, this one included; per ADR-0005 a local build is not acceptable evidence. `git diff 508eea2 f457efc -- docs/specs/ifc_check/` is empty, so the run witnesses the record frozen at 508eea2 |
| Architect signature | `J-architect_docs_lead-0005` |
| dv_lead testability countersignature | `J-dv_lead-0007` (WO-0013) — **SIGNED**, batch C, with C-17(b) raised and now closed in §13 |
| Frozen at | SHA **508eea2**, gate `docs/gates/P1-spec-freeze-checklist.md` |

## 13. Change log

Post-freeze changes only. Each row cites the ADR that authorised it; a breaking
interface change is counted against post-freeze churn (charter §6). **No row
below is breaking**: §4.1's record is byte-for-byte unchanged since the freeze
SHA, so the `ifc_check` evidence of §12 still witnesses this revision's
interface.

| Date | Change | Breaking? | ADR | Journal |
|---|---|---|---|---|
| 2026-08-02 | Drain count corrected from W − J to **W − J + 1** (two or three cycles) in §6.1, §6.2's `Drain` row and §7's throughput bullet; §8 gains the composed figure and its tie to SPEC-M04's C+8 cycle; §10's REQ-207 hook gains the prohibition (ledger **C-17(b)**) | no | none — §6.1's cycle table already showed three zero cycles for the 46-octet frame; the prose contradicted it | `J-architect_docs_lead-0006` |
