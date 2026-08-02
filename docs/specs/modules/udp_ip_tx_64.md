# SPEC-M18 — `Udp_ip_tx_64`

- **Status**: DRAFT — batch F. Template-complete; the two evidence rows of §12
  are what the freeze flip waits on
- **Inventory id**: M18 (architecture.md §4) · **Path**:
  `libs/hardcaml_ethernet/src/udp_ip_tx_64.ml`
- **Datapath role**: transmit
- **Owns REQs**: REQ-705, REQ-706, REQ-709 (the detection-and-strobe half — the
  wire remedy is M04's, §5), REQ-710, REQ-610 (the **UDP half** — see §5), and
  REQ-810's **application-interface half** (§4.3)
- **Prior-art counterpart**: `udp_ip_tx_64.v` (MIT) — consulted for
  decomposition and port naming only; behaviour below is stated independently
  and no source was copied. One declared REQ-901 divergence class lives here:
  **(d)** the zero UDP transmit checksum (REQ-706), so that field is not
  compared. `udp_checksum_gen_64.v` is deliberately absent from the inventory
  (architecture.md §5) because it requires buffering the payload
- **Depends on specs**: SPEC-M01 (`Axi64`, `Ip_header`), SPEC-M15
  (`Ip_eth_tx_64`, its consumer, whose two-cycle resolution wait this module's
  offer discipline is written against), SPEC-M16 (`Ip_complete_64`, which
  relays that pair unchanged), SPEC-M04 (`Xgmii_tx_64`, whose REQ-206 remedy is
  the other half of REQ-709), ADR-0008 (the transmit-side header handshake),
  ADR-0011 (what an application under-delivery leaves behind)
- **Author**: architect_docs_lead, journal `J-architect_docs_lead-0008`

## 1. Purpose

M18 is the transmit path's entry point: it takes an application **transmit
request** — destination address, destination port, source port and payload
length — plus the payload stream those fields describe, builds the eight-octet
UDP header, and offers M15 an IPv4 **header record** plus a payload stream whose
first eight octets are that UDP header. It is where the application's declared
length becomes the two length fields the lower layers need (REQ-610), and it is
the only module that can detect that the application did not deliver what it
declared (REQ-709, REQ-710).

It exists as a separate module for the reason architecture.md §2.7 gives: the
declared-length-up-front contract is what lets IPv4 and UDP build their headers
without buffering, and putting the request handshake here means M15 receives an
ordinary `Ip_header` record and never learns that an application exists.

Its upstream is the application, reached through M20's and M19's `app_tx_*`
relays (architecture.md §6.4.2); its downstream is M15 `Ip_eth_tx_64`, through
M16's `ip_tx_*` relay ports. It instantiates nothing.

## 2. Scope

**In scope.**

- Accepting the application's transmit request under ADR-0008's discipline and
  the payload stream it describes (REQ-705).
- Emitting the eight UDP header octets in RFC 768 wire order — source port,
  destination port, length, checksum — as the **first word** of the payload
  stream it offers M15 (§6.1).
- Computing the two length fields REQ-610 states: the UDP length field as the
  application's payload length **+ 8**, and the IPv4 total length it hands M15 as
  that payload length **+ 28** (§5).
- Emitting a UDP checksum field of **0x0000** (REQ-706), which RFC 768 permits
  for IPv4 and which is what makes the no-buffering property reachable at all.
- Detecting an application that delivers **fewer** octets than it declared
  (REQ-709) or **more** (REQ-710), and pulsing `error_tx_length_mismatch` once
  for either (§9).
- Refusing to begin a frame while `cfg_tx_enable` = 0, which is what makes
  REQ-810's "holds `tready` deasserted at the application transmit interface"
  true at the port REQ-810 names (§4.3, §6.1).
- Relaying the payload stream to M15 with **no realignment**: the UDP header is
  exactly one datapath word, so application word j is output word j + 1, octet
  for octet (§6.1).

**Not this module's job.**

| Behaviour a reader might expect here | Owner |
|---|---|
| The IPv4 header — version, IHL, TTL, identification, the header checksum, the source address | M15 `Ip_eth_tx_64` (REQ-608, REQ-609). M18 supplies `dst_ip` and `total_length` in the record and nothing else that M15 reads (SPEC-M15 §6.1) |
| Computing a UDP checksum | **nobody** — REQ-706 makes the field 0x0000 and requirements.md §11 records the absence as a decision. Computing one would require buffering the payload, which REQ-705's own invariance criterion forbids (architecture.md §2.7) |
| Resolving the destination to a MAC, or knowing that ARP exists | M13 `Arp` through M15 (REQ-505 … REQ-509). M18 passes `dst_ip` down and never sees a MAC, a cache or a miss; a datagram discarded on a miss is discarded **below** this module and M18 is not told |
| Padding to 60 octets, the preamble, the FCS, the inter-frame gap, the underflow remedy | M04 `Xgmii_tx_64` (REQ-201 … REQ-206). REQ-709's `/E/` and `/T/` are M04's; M18's half of REQ-709 is the detection and the strobe (§5, §9, ADR-0011) |
| Buffering a payload the lower layers cannot yet take | **nobody** — REQ-705's no-buffering prohibition and REQ-019's spirit. M18 holds one word and propagates backpressure upward (§7) |
| Deciding *when* the application may send | the application. M18 refuses a request only while `cfg_tx_enable` = 0 (§4.3); it has no rate limit, no queue and no credit scheme |

## 3. Programme invariants that bind this module

M18 is **not** a receive-path module under requirements.md §0.4: it is the head
of the transmit chain, its `payload_tready` towards the application is
legitimate, and §1.1 allocates it no latency ceiling.

| REQ | Consequence for M18 |
|---|---|
| REQ-001 | One `clock`, shared with the receive path (REQ-018 keeps the XGMII boundary simulation-only, so there is no second domain). |
| REQ-002 | Application payload in and IPv4 payload out are 64-bit `Axi64` streams, at most one word per cycle each. |
| REQ-003 | Does not bind M18's ports — but REQ-208 does: nothing here may reach back into the receive datapath, and nothing does, because M18 has no receive-side port at all. |
| REQ-005 | Does not bind M18 (not a receive-path module). Its analogue is §7's pinned one-cycle constant, stated so that REQ-705's invariance criterion and M04's 11-cycle frame period compose from named numbers. |
| REQ-007, REQ-013 | `tuser`[0] on the application payload's `tlast` word is copied to the output stream's `tlast` word and is **not** acted on: M18 transmits the frame regardless, which is REQ-013's "no module drops a frame solely because this bit is set". M18 originates no abort; REQ-709's under-delivery is reported by a strobe and by M04's wire remedy, not by the abort bit (§9). |
| REQ-008 | M18 owns **one** strobe, `error_tx_length_mismatch`, shared by REQ-709 and REQ-710 — the only strobe in requirements.md §12 that reports two conditions, which §9 states can never apply to the same frame. |
| REQ-009 | Synchronous `clear`: `ip_hdr_valid` = 0, `ip_payload_tvalid` = 0, `payload_tready` = 0 and the strobe = 0 while `clear` = 1 and on the first cycle after; a frame in flight is abandoned with no `tlast`. **`clear` is also the specified recovery from an under-delivered frame** (ADR-0011, §9). |
| REQ-010 | Application payload in and IPv4 payload out are the programme `Axi64.Source`, each with the matching `Axi64.Dest` in the other direction — the transmit-path pattern of architecture.md §2.3. `Ip_header` is SPEC-M01's, unchanged. `Udp_tx_request` is **declared here** (§4.1) under the declare-once rule, because M01 is FROZEN and REQ-705 makes this module its owner. |
| REQ-011 | `tkeep` on the incoming application `tlast` word says how many octets of that word are payload; `tkeep` on the emitted `tlast` word marks exactly the octets the frame carries, which is where the declared count is enforced (§6.1). |
| REQ-012 | Header octets are emitted first wire octet first: `src_port`[15:8] is UDP octet 0, the length field's high octet is UDP octet 4. Application payload octet position k maps to output octet 8 + k (§6.1). |
| REQ-014 | `tstrb` on the application input is ignored; `tstrb` on the output is driven to 0. |
| REQ-015 | One `tlast` per frame in each direction. At most **184** words between two `tlast` words on the output stream (1472 octets of payload plus the 8-octet UDP header is 1480 octets, 185 words — see §11.3 for the declared-length bound), the `tlast` word included. |
| REQ-016 | The application **may** deassert `tvalid` between words and M18 tolerates it without corrupting the frame — M18 simply does not advance. REQ-016's tolerance ends three modules later, at M04's source port (REQ-206), which is what makes an application gap indistinguishable from an under-delivery **to M04** and is why M18 and not M04 detects REQ-709 (§9). |
| REQ-019 | No instance: M18 is not on the chain REQ-006 measures and §1.1 allocates it nothing. Its storage is **one** payload word — the registered output — because the header it prepends is a whole datapath word and no realignment shift exists (§7). That is one word less than M07 and M15 each hold for the same job with a header that is not word-aligned. |
| REQ-020 | Datagrams leave in the order the application offered them; M18 holds one at a time (§6.2), so reordering is not expressible. |
| REQ-021 | Producer-side word alignment holds at M18's output — output octet 0, the first UDP header octet, is at `ip_payload_tdata`[7:0] of output word 0 — and it holds **without a shifter**: the application's stream is word-aligned at its producer (REQ-021) and M18 prepends exactly one whole word, so every later output word is one application word unchanged. |

## 4. Interface

### 4.1 Interface records

```ocaml
(* SPEC-M18 §4.1, lifted verbatim into docs/specs/ifc_check/udp_ip_tx_64_ifc.ml
   (SPEC-TEMPLATE.md rule 6). Records and signatures only — no logic, no
   implementation.

   [Axi64_ifc] is M01's types home (SPEC-M01 §4.1): [Axi64] and
   [Ip_header] come from there and are restated nowhere.

   [Udp_tx_request] is DECLARED HERE and is batch F's only new record.
   The declare-once rule batch D adopted (SPEC-M10 §4.1, §11.2) puts a
   record in the specification of the module that OWNS it and has every
   counterpart [open!] that module: REQ-705 makes the transmit request
   this module's, so it is declared here and SPEC-M19 and SPEC-M20 open
   [Udp_ip_tx_64_ifc] for it. It is not added to M01, which is FROZEN at
   f78766e; a record added there would be a breaking post-freeze
   interface change to the specification five freeze records cite.

   The request carries a [valid] and NO [ready]: its acceptance event is
   the acceptance of the frame's first application payload word by THIS
   module, which is ADR-0008's decision 3 applied one port further out
   than batch C applied it. [payload_length] counts UDP PAYLOAD octets
   only — not the UDP header and no lower-layer header (REQ-705) — which
   is the one field of this record a reader can get wrong, so its width
   and its unit are both stated here and in §4.2.

   Transmit-path module, so [Source] one way and [Dest] the other on each
   of the two logical streams: the application stream's [Source] is an
   input and its [Dest] an output; the output stream's [Source] is an
   output and its [Dest] an input. Each stream's two directions share a
   prefix with no collision, because [Source]'s field names and [Dest]'s
   are disjoint (SPEC-M04 §4.1 fixes that pattern). *)

open! Base
open Hardcaml
open! Axi64_ifc

module Udp_tx_request = struct
  type 'a t =
    { valid : 'a
    ; dst_ip : 'a [@bits 32]
    ; dst_port : 'a [@bits 16]
    ; src_port : 'a [@bits 16]
    ; payload_length : 'a [@bits 16]
    }
  [@@deriving hardcaml]
end

module I = struct
  type 'a t =
    { clock : 'a
    ; clear : 'a
    ; request : 'a Udp_tx_request.t [@rtlprefix "request_"]
    ; payload : 'a Axi64.Source.t [@rtlprefix "payload_"]
    ; ip_payload_dest : 'a Axi64.Dest.t [@rtlprefix "ip_payload_"]
    ; cfg_tx_enable : 'a
    }
  [@@deriving hardcaml]
end

module O = struct
  type 'a t =
    { payload_dest : 'a Axi64.Dest.t [@rtlprefix "payload_"]
    ; ip_hdr : 'a Ip_header.t [@rtlprefix "ip_hdr_"]
    ; ip_payload : 'a Axi64.Source.t [@rtlprefix "ip_payload_"]
    ; error_tx_length_mismatch : 'a
    }
  [@@deriving hardcaml]
end

module type S = sig
  val create : Scope.t -> Signal.t I.t -> Signal.t O.t
  val hierarchical : ?instance:string -> Scope.t -> Signal.t I.t -> Signal.t O.t
end

(* REQ-010 type identity in both directions of both streams. No witness is
   written for [Ip_header]'s field names: SPEC-M14 §4.1's lift names all
   seven and settles them once (SPEC-M16 §4.1's rule for the same
   omission). *)

let _witness_both_directions
      (s : Signal.t Axi64.Source.t)
      (d : Signal.t Axi64.Dest.t)
  =
  s, d
;;
```

Conformance of this block to the template's rules for §4.1:

- Scalar fields carry `[@bits n]` unless they are one bit wide: `clock`,
  `clear`, `cfg_tx_enable`, the request's `valid` and the strobe are one bit;
  `dst_ip` carries 32 and the three 16-bit request fields carry 16, and every
  other field is inside a nested record carrying its own widths.
- Nested interfaces carry `[@rtlprefix]`: `request` emits `request_valid` …
  `request_payload_length`, `payload` and `payload_dest` emit `payload_tvalid` …
  `payload_tuser` and `payload_tready`, `ip_hdr` emits `ip_hdr_valid` …
  `ip_hdr_total_length`, and `ip_payload` and `ip_payload_dest` emit
  `ip_payload_tvalid` … `ip_payload_tuser` and `ip_payload_tready`. Every name is
  architecture.md §6.4.2's, confirmed unchanged by this batch.
- **`Source` one way and `Dest` the other, on each logical stream**: held. M18 is
  allowed both because it is not a receive-path module (requirements.md §0.4);
  REQ-208, not REQ-003, is what keeps its backpressure away from the receive
  datapath, and REQ-208 holds structurally because M18 has no receive port at
  all.
- Both `create` and `hierarchical` are declared (REQ-903, REQ-808).

### 4.2 Port table

Every port in §4.1 appears exactly once. Direction is with respect to M18.

| Port | Dir | Width | Meaning | REQ |
|---|---|---|---|---|
| `clock` | in | 1 | 156.25 MHz single domain | REQ-001 |
| `clear` | in | 1 | synchronous clear; also the recovery from an under-delivered frame (ADR-0011) | REQ-009 |
| `request_valid` | in | 1 | a datagram is offered; **held** until its first payload word is accepted (ADR-0008) | REQ-705, ADR-0008 |
| `request_dst_ip` | in | 32 | the datagram's destination IPv4 address; relayed to M15 as `ip_hdr_dst_ip` and used by nothing else here | REQ-705, REQ-012 |
| `request_dst_port` | in | 16 | the destination UDP port; emitted at UDP octets 2–3 | REQ-705, REQ-012 |
| `request_src_port` | in | 16 | the source UDP port; emitted at UDP octets 0–1 | REQ-705, REQ-012 |
| `request_payload_length` | in | 16 | **the number of UDP payload octets the application will supply** — excluding the 8-octet UDP header and every lower-layer header (REQ-705). The UDP length field is this + 8 and the IPv4 total length is this + 28 (REQ-610). Its permitted range is §11.3's | REQ-705, REQ-610 |
| `payload_tvalid` | in | 1 | the application presents a payload word this cycle | REQ-016 |
| `payload_tdata` | in | 64 | UDP payload octets, word-aligned at the producer (REQ-021); octet 0 is the first UDP payload octet | REQ-012 |
| `payload_tkeep` | in | 8 | valid octet positions; 1 to 8 contiguous ones on the `tlast` word | REQ-011 |
| `payload_tstrb` | in | 8 | reserved; ignored | REQ-014 |
| `payload_tlast` | in | 1 | this word carries the application payload's final octets — and, if the declared count has not been reached, REQ-709's condition | REQ-015, REQ-709 |
| `payload_tuser` | in | 1 | bit 0 advisory abort; copied out, never acted on | REQ-013, REQ-007 |
| `ip_payload_tready` | in | 1 | M15 accepts an output word this cycle; its first acceptance is the acceptance of the offer (ADR-0008) | REQ-207 (three stages up), ADR-0008 |
| `cfg_tx_enable` | in | 1 | 0 refuses every new request: `payload_tready` stays 0 and no frame is offered. This is REQ-810's application-interface half (§4.3) | REQ-810, REQ-802 |
| `payload_tready` | out | 1 | M18 accepts an application word this cycle; an accepted word is transmitted **or**, past the declared count, accepted and discarded (REQ-710) | REQ-207 (one stage up), REQ-705, REQ-710 |
| `ip_hdr_valid` | out | 1 | a datagram is offered to M15; asserted together with output word 0's `tvalid` and held until that word is accepted (ADR-0008) | REQ-610, ADR-0008 |
| `ip_hdr_dst_ip` | out | 32 | `request_dst_ip`, unchanged | REQ-705, REQ-507 |
| `ip_hdr_total_length` | out | 16 | `request_payload_length` + **28** (REQ-610): 20 octets of IPv4 header, 8 of UDP header, and the payload | REQ-610 |
| `ip_hdr_src_ip` | out | 32 | driven to **0**. M15 reads it for nothing — REQ-608 fixes the source address as `cfg_local_ip` — and SPEC-M15 §6.3 item 3 says DV SHALL assert nothing about it | REQ-608 |
| `ip_hdr_protocol` | out | 8 | driven to **17**, which is true rather than convenient; M15 reads it for nothing (REQ-608 fixes protocol 17 as a constant) | REQ-608 |
| `ip_hdr_ttl` | out | 8 | driven to **0**; M15 reads it for nothing (REQ-608 takes TTL from `cfg_ttl`) | REQ-608 |
| `ip_hdr_dscp` | out | 6 | driven to **0**; M15 reads it for nothing (REQ-608 fixes DSCP and ECN to 0) | REQ-608 |
| `ip_payload_tvalid` | out | 1 | this cycle carries an output word | REQ-016 |
| `ip_payload_tdata` | out | 64 | the eight UDP header octets in word 0, then the application payload verbatim | REQ-012, REQ-021 |
| `ip_payload_tkeep` | out | 8 | valid octet positions, contiguous from bit 0; `0xFF` on word 0 always | REQ-011 |
| `ip_payload_tstrb` | out | 8 | reserved; driven to 0 | REQ-014 |
| `ip_payload_tlast` | out | 1 | this word carries the datagram's final octets — asserted at the **declared** count and never before it (§6.1, REQ-709) | REQ-015 |
| `ip_payload_tuser` | out | 1 | bit 0: the inherited advisory abort, on the `tlast` word | REQ-013, REQ-007 |
| `error_tx_length_mismatch` | out | 1 | one-cycle strobe: the application supplied fewer octets than it declared (REQ-709) or more (REQ-710) | REQ-709, REQ-710 |

### 4.3 Configuration inputs

M18 reads **one** field of the `Config` record (requirements.md §9.1), as a
scalar.

| Field | Effect | When a change takes effect (REQ-803) |
|---|---|---|
| `cfg_tx_enable` | 0 refuses every new transmit request: M18 stays in `Idle`, holds `payload_tready` = 0 and asserts no `ip_hdr_valid`, so no frame is offered to M15 and none begins. 1 permits requests normally | sampled on every cycle M18 is in `Idle` — that is, on the cycle a request would otherwise be taken. A frame already in flight completes under the old value, which is REQ-803's "next frame boundary on its own path" |

**This edge is an amendment to architecture.md §6.4.3, made in the same commit as
this specification** (§6.4's confirm-or-amend rule), which routed `cfg_tx_enable`
only to M04. It is one added row —

> `| `M20.cfg_tx_enable` | `M18.cfg_tx_enable` | `bit` | control |`

— and it renames nothing.

**Why the edge exists, because the alternative looks cheaper and is not.**
REQ-810's transmit clause has two observables: "it emits only idle characters"
(M04's, and M04 has the enable already) **and** "holds `tready` deasserted at the
application transmit interface" — which is a statement about **this module's**
`payload_tready`, three modules away from M04. Without an enable here that second
clause is satisfied only by backpressure propagation, and propagation is not
exact: with transmit disabled, M15 still accepts a frame's first payload word
unconditionally on its resolution cycle (SPEC-M15 §6.1 step 3), so M18 would
accept **exactly one** application word before `tready` fell. REQ-810's own
verification column says "`tready` stays low", and a bench written from it would
fail a conformant design by one cycle. One input at M18 makes the requirement
true as written, at the port the requirement names, and costs one control row.

The alternative — leaving it to propagation and rewording REQ-810's verification
column to permit one accepted word — was rejected because it moves a
**requirement** to accommodate a topology, and because "one word may be accepted
while transmit is disabled" is a sentence nobody would want to defend to a
sponsor. Recorded here so the choice is visible rather than assumed.

**REQ-810's three halves, so no sign-off packet claims another's.** The receive
half is M03's (`cfg_rx_enable`, SPEC-M03 §4.3); the XGMII transmit half is M04's
(`cfg_tx_enable`, SPEC-M04 §4.3 and §6.2's `Idle` row); the
application-interface half is **this module's**. The ARP clause — the first reply
generated while transmit is disabled is held inside M11 and transmits late — is
M13's and is unaffected by this edge, because M13 has no enable and needs none
(SPEC-M13 §11.2). `traceability.md`'s REQ-810 row names all four modules.

## 5. Parameters

**None.** REQ-506's rule has no instance: M18 has no timeout, no ageing interval
and no retry. Its numeric constants — 8, 28, 17 and the zero checksum — are fixed
by REQ-610 and REQ-706 and by RFC 768's header format, and making any of them
overridable would let a test configure a protocol the programme does not have.

| Parameter | Type | Default | Range | Why a test overrides it |
|---|---|---|---|---|
| (none) | — | — | — | — |

**REQ-610 is owned in two halves, and this is the UDP half.** REQ-610 states two
arithmetic facts and one prohibition: total length is the application's payload
length plus 28, the UDP length field is that payload length plus 8, and neither
may be derived by buffering the payload. **M18's half** is: it receives the
payload length in the request (REQ-705), computes **both** sums, emits the second
into UDP octets 4–5 and hands the first to M15 as `ip_hdr_total_length`, and
buffers **nothing** to do either — §7's structural argument is that M18 emits its
first output word before it has accepted any application word, at every payload
length. **M18 claims no coverage of the IPv4 total length field's emission and no
coverage of the no-buffering property at M15's own port**: the field goes into
IPv4 octets 2–3 at **M15**, which sizes its body from it and holds two payload
words to do so (SPEC-M15 §5, §7), and that half is claimed there, not here.
`traceability.md`'s REQ-610 row lists both modules, and this paragraph is the
second side SPEC-M15 §11.3 closes on.

**REQ-709 is owned in two halves too, and this is the detection half.** REQ-709
requires the transmit path to terminate an under-delivered frame per REQ-206 and
to pulse **both** `error_underflow` and `error_tx_length_mismatch`. The wire
remedy — the error character, the terminate character, the missing FCS and
`error_underflow` — is **M04's** (SPEC-M04 §9), reached because M18 stops
presenting words; M18's half is the detection and its own strobe. The two strobes
are **not** on the same cycle and no bench should assert that they are (§9,
ADR-0011). REQ-710's over-delivery is wholly M18's: the frame on the wire is
already complete and correct, so M04 has no instance of it and SPEC-M04 §9 says
so.

## 6. Behaviour

### 6.1 Normal path

**The UDP header M18 writes**, with the octet offsets a test writer needs to
hand-assemble the reference datagram. Offsets are from the first octet M18
emits, which is the first octet after the IPv4 header on the wire. This table is
the transpose of SPEC-M17 §6.1's.

| Field | Octet offset | Width | Source | Wire order |
|---|---|---|---|---|
| source port | 0–1 | 16 bits | `request_src_port` | most significant octet first: port 8080 emits 0x1F then 0x90 |
| destination port | 2–3 | 16 bits | `request_dst_port` | same |
| length | 4–5 | 16 bits | `request_payload_length` **+ 8** (REQ-610) | same: a payload of 18 octets emits 0x00 then 0x1A |
| checksum | 6–7 | 16 bits | **constant 0x0000** (REQ-706) | both octets zero on every datagram |

**The two lengths, computed here and used in two places.** With P the declared
payload length:

> UDP length field = **P + 8** (emitted at octets 4–5)
> `ip_hdr_total_length` = **P + 28** (handed to M15, emitted by it at IPv4 octets 2–3)

Both are pure functions of one request field, available on the cycle the request
is offered, so no payload octet is ever needed to compute either and REQ-610's
no-buffering prohibition is not approached. For REQ-708's datagram, P = 18: the
UDP length is 26 and the IPv4 total length is 46, which is exactly the figure
SPEC-M14 §8 and SPEC-M15 §6.1 use for the same frame from the other direction.

**The four `Ip_header` fields M15 does not read are driven to constants**, and
the constants are stated so that a waveform is readable rather than so that a
bench can assert them: `ip_hdr_src_ip` = 0, `ip_hdr_ttl` = 0, `ip_hdr_dscp` = 0
and `ip_hdr_protocol` = **17** — the last one true rather than merely convenient,
because a reader who sees 17 on that wire should not have to wonder whether it
means anything. SPEC-M15 §6.3 item 3 states that DV SHALL assert nothing about
any of the four, and that stands: the emitted IPv4 header is a function of
`cfg_local_ip`, `cfg_ttl`, `hdr_dst_ip`, `hdr_total_length` and M15's own
counter, and of nothing else.

**The offer, in the order it happens.** With A the first cycle on which M18 sees
`request_valid` = 1 while it is idle and `cfg_tx_enable` = 1 — the cycle the
application's offer appears, ADR-0008 having obliged the application to assert
`request_valid` and payload word 0's `tvalid` together and hold both:

1. **Cycle A**: M18 asserts `ip_hdr_valid` = 1 with the record's fields, and
   `ip_payload_tvalid` = 1 with **output word 0 — the eight UDP header octets**,
   `tkeep` = 0xFF. Both are functions of the request alone, so both are available
   on this cycle; ADR-0008 decision 1 requires them together and this is how M18
   meets it. `payload_tready` = 0: no application word has been accepted and none
   is needed yet.
2. **Cycles A and A + 1**: M15 is resolving the destination through M13 and holds
   `ip_payload_tready` = 0 (SPEC-M15 §7's two-cycle resolution wait, uniform over
   every destination class). M18 holds the offer with every field stable, which
   is ADR-0008 decision 2 doing the job it exists for, and holds
   `payload_tready` = 0. **The application's two-cycle head cost is M15's
   resolution wait relayed, and M18 adds nothing to it.**
3. **Cycle C = A + 2**: M15 accepts output word 0. On this same cycle M18 accepts
   the application's payload word 0. From here the two streams run in lockstep,
   one word per cycle, with a one-word offset that never grows.
4. **Cycle C + n**: output word n is emitted, carrying application payload word
   n − 1, for n ≥ 1; application word j is accepted on cycle C + j.

**Cycle by cycle, an 18-octet application payload** — REQ-708's datagram, the one
a minimum-length frame carries. The application supplies 18 octets in J = 3 words
(two full, one carrying 2 octets); M18 emits W = 4 output words (26 octets: the
8-octet UDP header plus 18).

| Cycle | `payload_tready` | Application input | Output (`ip_payload`) |
|---|---|---|---|
| A | **0** | offer seen: `request_valid` = 1 with payload word 0 held | `ip_hdr_valid` = 1; output word 0 = the UDP header, `tkeep` = 0xFF, offered and held |
| A+1 | **0** | offer still held (ADR-0008) | still offered; `ip_payload_tready` = 0 (M15 resolving) |
| C = A+2 | **1** | payload word 0 accepted (payload octets 0–7) | output word 0 **accepted** by M15 |
| C+1 | 1 | payload word 1 accepted (octets 8–15) | output word 1: payload octets 0–7 |
| C+2 | 1 | payload word 2 accepted (octets 16–17, `tkeep` = 0x03, `tlast` = 1) | output word 2: payload octets 8–15 |
| C+3 | **0** | — | output word 3: payload octets 16–17, `tkeep` = 0x03, `tlast` = 1, `tuser`[0] copied from the application's `tlast` word |
| C+4 | 1 if a request is offered | the next datagram's offer | `ip_payload_tvalid` = 0 |

**`payload_tready` falls for exactly one cycle at the end of every frame, and the
count is W − J and not W − J + 1.** M18 emits W = J + 1 output words for J
application words — it adds exactly one word, because the UDP header is exactly
one word at every payload length, with **no residue classes at all**. Over the
frame it accepts one application word per cycle on C … C + J − 1 and emits one
output word per cycle on C … C + J, so the single cycle in which it emits without
accepting is **C + J**, and that is the only stalled cycle.

*This is carry-forward **C-17(b)**'s distinction, applied rather than copied.*
SPEC-M15 §6.1 derives **W − J + 1** for its own drain and SPEC-M07 §6.1 the same,
and the temptation is to write the same formula here. It would be wrong by one.
The difference is exactly one event: M15's first body word leaves on the cycle
**after** the acceptance that starts its frame, so the acceptance cycle is not
also an emission cycle; M18's output word 0 is **accepted on the same cycle** as
its first application word, because it was offered before that cycle and was
waiting. The two modules' stall counts therefore differ by one for the same
reason their offers differ, and a bench that carries M15's number to this port
fails a conformant M18 on every frame. **W − J + 1 is not a programme constant;
it is a consequence of where the first output word sits relative to the first
acceptance, and each module derives it.**

**Where the octets land.** Output octet 8 + k is application payload octet k, so
output word 0 is header only and output word n ≥ 1 **is** application word n − 1,
octet position for octet position. There is no shifter and no two-word
combination anywhere in this module — the property REQ-021 needs is already true
at the input and prepending a whole word preserves it. M18 is the only header
builder in the programme of which that is true (M07 prepends 14 octets, M15
prepends 20).

**When the consumer stalls.** `payload_tready` is 1 only when
`ip_payload_tready` is 1 and the frame still needs application words, so a cycle
on which M15 cannot accept a word is a cycle on which M18 accepts none either:
the word in flight is held in its register, nothing is dropped and nothing is
duplicated (REQ-207's discipline, three stages before M04). Every cycle formula
above shifts by exactly the number of stalled cycles. Until M15 accepts output
word 0, M18 holds the offer unchanged, which is ADR-0008 decision 2's requirement
on a source.

**When the application stalls.** The application may deassert `payload_tvalid`
between words (REQ-016) and M18 simply does not advance: it emits no output word
that cycle. Nothing downstream breaks at M15, M09 or M07 — all three tolerate
gaps — but the gap **does** reach M04, whose source interface has no idle
tolerance (REQ-206, requirements.md §11). **An application that gaps its own
payload mid-frame therefore risks an underflow on the wire, and that is a
property of the design rather than a defect**: requirements.md §11 records the
absence of elastic buffering on the transmit source interface as a decision, and
REQ-206's threshold is one cycle. The application's obligation is to present
words continuously once a frame is offered; §11.2 records the residual and
ADR-0011 records what happens when it is not met.

**While `cfg_tx_enable` = 0** (REQ-810, §4.3). M18 stays in `Idle`: it asserts no
`ip_hdr_valid`, presents no output word and holds `payload_tready` = **0**, so
the application's offer waits — held, per ADR-0008, by the application itself —
and no frame begins anywhere. On the first cycle after `cfg_tx_enable` returns to
1 the offer is taken normally and the frame transmits, which is REQ-810's
"re-enable and check the frame transmits" satisfied with no queue and no state.

### 6.2 State machine

Reset state and `clear` state are both `Idle`.

| State | Entered when | Does | Leaves to |
|---|---|---|---|
| `Idle` | reset; `clear`; the output `tlast` word is accepted; an under-delivered frame has been reported (§9) | `ip_payload_tvalid` = 0, `ip_hdr_valid` = 0, `payload_tready` = 0, strobe 0; samples `cfg_tx_enable` | `Offer` on the first cycle `request_valid` = 1 **and** `cfg_tx_enable` = 1, capturing the four request fields and computing both lengths |
| `Offer` | a request was taken | asserts `ip_hdr_valid` = 1 and presents output word 0 — the UDP header — holding both with every field stable until that word is accepted (ADR-0008 decisions 1 and 2); `payload_tready` = 0 | `Body` on the cycle `ip_payload_tvalid` and `ip_payload_tready` are both 1 for output word 0, accepting the application's payload word 0 on that same cycle |
| `Body` | output word 0 was accepted | emits output word n carrying application word n − 1 while `ip_payload_tready` = 1; accepts an application word on every such cycle; counts delivered octets against the declared count | `Drain` on the cycle it accepts the application word that completes the **declared** count; `Excess` on accepting a word beyond it (REQ-710); `Short` on accepting a word carrying `tlast` before it (REQ-709) |
| `Drain` | the declared count is complete | emits the last output word — the one carrying the declared count's final octets, with `ip_payload_tlast` = 1, the `tkeep` the declared count implies and the inherited `tuser`[0] — and holds `payload_tready` = 0 | `Idle` when that word is accepted |
| `Excess` | the application presented a word beyond the declared count (REQ-710) | pulses `error_tx_length_mismatch` **once**, on entry; completes the output frame exactly as `Drain` does, with exactly the declared octet count; holds `payload_tready` = **1** and accepts and **discards** every further application word so the application is never stalled | `Idle` when both the output `tlast` has been accepted and the application's `tlast` has been accepted |
| `Short` | the application's `tlast` arrived before the declared count (REQ-709) | pulses `error_tx_length_mismatch` **once**, on entry; emits the octets it holds **without** `ip_payload_tlast`, then presents no further word for this frame, ever; holds `payload_tready` = 0 | **nowhere by itself.** The frame is never terminated downstream; M04 underflows and terminates it on the wire, and `clear` returns this module and the whole transmit chain to `Idle` (ADR-0011, §9) |

A cycle on which `ip_payload_tready` = 0, or on which the application presents no
payload word, holds every state and every register: it is not a condition and it
advances nothing (§6.1). `clear` in any state returns to `Idle`, abandoning a
frame in flight with no `tlast`.

### 6.3 Deliberately unconstrained

Anything not listed here is constrained by this specification, and a test may
rely on it.

1. **The placement of the register level** inside the one-cycle delay, and every
   internal encoding: the FSM encoding, whether the request is captured into one
   register or five, whether the delivered-octet count is a counter or is derived
   from the word index and `tkeep`. §7's constants are what is fixed.
2. **The value of `ip_payload_tdata` at positions where `ip_payload_tkeep` is 0**,
   the seven `ip_hdr` fields on a cycle with `ip_hdr_valid` = 0, and every output
   field on a cycle with `ip_payload_tvalid` = 0 (SPEC-M01 §6.3 item 5). No
   monitor may read them.
3. **M18's behaviour when a request is offered with no payload word**, or when
   `request_valid` is asserted without `payload_tvalid`. ADR-0008 decision 4
   forbids it, and here it is **unreachable rather than merely forbidden**: a
   zero-octet application payload has no encoding on an `Axi64` stream (REQ-011,
   requirements.md §0.7), so the smallest transmittable UDP datagram carries one
   payload octet and has UDP length 9. No requirement names the case and DV SHALL
   assert nothing about it. This is the wording SPEC-M07 §6.3 item 3 and SPEC-M15
   §6.3 item 4 use.
4. **The behaviour for a declared payload length outside §11.3's range** — above
   1472, which would make the IPv4 total length exceed REQ-612's 1500 and put a
   frame above 1518 octets on the wire. M18 does not check it, no requirement
   constrains it, and DV SHALL assert nothing about it; §11.3 records the residual
   and what a reader assumes.
5. **The relative order of `error_tx_length_mismatch` at this module and
   `error_underflow` at M04** for one under-delivered frame. M18's pulses first
   and M04's follows by the number of words in flight between them, which depends
   on how far M15's drain had progressed and is **not pinned**. A bench asserts
   one pulse of each per under-delivered frame and SHALL NOT assert a separation
   (ADR-0011, §9). SPEC-M04 §9's co-occurrence bullet says the same thing from
   the other end.
6. **What the application does with the two cycles of `payload_tready` = 0 at the
   head of every frame.** They are M15's resolution wait relayed (§6.1 step 2) and
   are a constant M18 neither shortens nor lengthens; whether the application
   uses them is its business.

## 7. Timing contract

- **Latency.** Pinned at **1 cycle**: output word n carrying application word
  n − 1 is emitted on the cycle after M18 accepts application word n − 1. The two
  measurement events are the cycle on which `payload_tvalid` and `payload_tready`
  are both 1 for an application word, and the cycle on which
  `ip_payload_tvalid` is 1 for the output word carrying it. Both sit at octet
  position 0 of their words, so the figure is exactly 8 octet times and not a
  rounding.

  **Output word 0 is outside that constant and is stated separately**, because it
  carries no application octet: it is a function of the request alone and is
  presented from cycle A, the cycle the offer is seen, so a monitor measuring
  "request to first output word" observes **0** cycles and a monitor measuring
  "application word accepted to the output word carrying it" observes 1. Both
  figures are here so that neither has to be guessed.

  M18 is not a receive-path module: requirements.md §1.1 allocates it no ceiling
  and REQ-006's budget does not contain it. **No requirement constrains the value
  of this constant** — only that this specification states one, so that REQ-705's
  invariance criterion, M15's cadence and M04's 11-cycle frame period compose
  against known figures. It is 1 cycle because a registered output cannot do
  better and a combinational one would put the application's `tdata` on M15's
  input path.

- **Head cost.** **Exactly two cycles** of `payload_tready` = 0 at the head of
  every frame, hit or miss, every destination class — SPEC-M15 §7's resolution
  wait, relayed. M18 adds **zero**: it presents its own first word on the cycle
  the offer arrives. A bench may assert the two cycles at the application port
  directly, and the fact that the figure is M15's rather than M18's is what makes
  it independent of the network configuration (SPEC-M13 §7's own argument).

- **Throughput.** One application word accepted per cycle while `payload_tready`
  is 1; one output word emitted per cycle while `ip_payload_tready` is 1. Over a
  frame M18 emits **exactly one more** word than it consumes — the UDP header —
  at every payload length and with no residue classes, so it costs the transmit
  path one cycle per frame that M04's inter-frame gap absorbs, plus the two
  relayed head cycles. `payload_tready` is 0 for exactly **one** cycle at each
  frame's end, which is **W − J** and not W − J + 1 (§6.1's derivation and its
  C-17(b) warning). M18 never emits two words in one cycle and never accepts two.

  **REQ-705's no-buffering prohibition is structural here, not promised, and it
  is stronger at this port than anywhere else.** M18 emits its first output word
  before it has accepted **any** application word, at every payload length — so
  the count REQ-705's invariance criterion names ("the number of application
  words accepted before the first octet of that frame appears on the wire") has
  the same value for a 1-octet payload and a 1472-octet payload, and that value
  is fixed by M15's, M09's, M07's and M04's constants rather than by anything
  here. A store-and-forward implementation would have to accept a length-dependent
  number of words first, and the invariance fails immediately at short lengths,
  which is why REQ-705 prefers it to an ordering criterion.

- **Handshake rules.** An application word is accepted on a cycle with
  `payload_tvalid` = 1 and `payload_tready` = 1; an accepted word is transmitted,
  or — in `Excess` — accepted and dropped, which is REQ-710's own instruction. An
  output word is accepted on a cycle with `ip_payload_tvalid` = 1 and
  `ip_payload_tready` = 1; M18 holds `ip_payload_tvalid` and the word's contents
  stable until that happens.

  **ADR-0008's source obligations, restated as that ADR's Consequences require of
  every transmit-side source** (SPEC-M07 §11.2, SPEC-M09 §11.3 and SPEC-M11 §11.2
  track this restatement; M18 is the third and last source and closes the
  enumeration):
  - **Decision 1** — M18 asserts `ip_hdr_valid` = 1 **and** output word 0's
    `ip_payload_tvalid` = 1 **on the same cycle**, never one before the other.
  - **Decision 2** — it holds both, with all seven header fields and output word
    0's contents stable, until that word is accepted.
  - **Decision 4** — it never offers a header for a frame with no output word:
    output word 0 is the UDP header, which every frame has, so the case is
    unreachable structurally rather than tolerated — the same shape M11 and M15
    have, obtained here for free.
  - **Decision 3** is the consumer's half and M15 performs it (SPEC-M15 §6.1);
    M18 may drop `ip_hdr_valid` on the cycle after acceptance **and does**, which
    is a stronger commitment than the ADR requires of a source. Under ADR-0008's
    C-22 precedence clause that stronger commitment governs a monitor attached to
    *this* port, and such a monitor may assert the fall — while a monitor built
    from the ADR alone SHALL NOT.

  **On the input side the discipline is the same ADR's, one port further out, and
  this is its first application-facing instance.** `request_valid` is a **level**
  the application holds until M18 accepts the frame's first payload word; M18
  captures nothing until that cycle. The application is therefore bound by
  decisions 1, 2 and 4 exactly as M11, M15 and M18 are, and SPEC-M20 §7 states
  the obligation at the port the application actually sees. A bench driving M20's
  application transmit interface is a *source* under ADR-0008 and must behave
  like one.

  Idle gaps on the application payload input (REQ-016) are tolerated by M18 and
  delay everything by the number of idle cycles — but see §6.1's warning about
  what they do at M04.

- **Reset.** While `clear` = 1 and on the first cycle after it returns to 0:
  `ip_payload_tvalid` = 0, `ip_hdr_valid` = 0, `payload_tready` = 0 and the
  strobe = 0. `clear` asserted mid-frame abandons the frame with **no** `tlast`
  word — the frame simply stops, which is REQ-009's explicit permission; M15,
  M09, M07 and M04 abandon the same frame on the same cycle (SPEC-M15 §7,
  SPEC-M09 §7, SPEC-M07 §7, SPEC-M04 §7). A request offered on the first cycle
  after `clear` returns to 0 is transmitted correctly. **`clear` is additionally
  the specified recovery from an under-delivered frame** (ADR-0011), which is the
  one place in Phase 1 where `clear` is load-bearing for something other than
  initialisation, and §9 states it.

- **Configuration sampling.** §4.3: `cfg_tx_enable` on every cycle M18 is in
  `Idle`. A frame in flight completes under the old value (REQ-803).

## 8. Line-rate stress obligation

**Not applicable.** M18 is not in requirements.md §0.4's stress-bench list (M03,
M06, M08, M10, M14, M17, M20), which enumerates *receive-path* modules —
REQ-004's invariant is about surviving an arrival rate the module cannot slow
down, and M18 can slow its source down, by the two relayed head cycles and the
one drain cycle §7 states.

Its equivalent obligations are six, stated so that no sign-off packet has to
invent them:

1. **REQ-705's invariance, which is the whole no-buffering test**: offer
   datagrams whose declared payload lengths cover every residue modulo 8 from 1
   to 16, plus 100 and 1472, and assert that the number of application words
   accepted before M18's **first output word is accepted by M15** is **zero** for
   every one of them, and that the head cost is exactly two cycles in every case.
   Both figures are §7's. A bench that instead asserts an *ordering* — payload
   before wire — passes a store-and-forward design at long lengths and is the
   weaker test REQ-705's verification column warns against.
2. **REQ-610's arithmetic, both sums, over the same length set**: decode
   `ip_hdr_total_length` at M18's port and the UDP length field at output word
   0's octets 4–5, and assert P + 28 and P + 8 for every P. The two are checked
   at **different ports** on purpose: the first is a record field this module
   drives and the second is octets on a stream, and an implementation that got one
   right and the other wrong would pass a test that checked only one.
3. **REQ-706's zero checksum**: decode output word 0's octets 6–7 on every frame
   of item 1 and assert 0x0000. Cheap, and it is the field a later phase is most
   likely to "improve" without noticing that REQ-705's invariance dies with it.
4. **REQ-710's over-delivery**: declare 100 octets and supply 110. Assert the
   output frame carries exactly 100 payload octets with `ip_payload_tlast` on the
   word carrying octets 97–100 and `tkeep` = 0x0F; that `payload_tready` is **1**
   on every cycle from the declared count to the application's `tlast`, so the ten
   excess words are accepted and discarded and the application is never stalled;
   that `error_tx_length_mismatch` pulses **once**; that `error_underflow` does
   **not** pulse anywhere; and that the next frame transmits correctly with no
   `clear`.
5. **REQ-709's under-delivery**, which is the one item that needs ADR-0011 in
   hand: declare 100 octets and supply 90. Assert `error_tx_length_mismatch`
   pulses **once**, at M18, on the cycle it accepts the short `tlast`; that M18
   presents no further output word for that frame and never asserts
   `ip_payload_tlast`; that `error_underflow` pulses **once**, at M04, some cycles
   later — **the separation is not asserted** (§6.3 item 5); that the wire carries
   `/E/` then `/T/` with no FCS (SPEC-M04 §9); **then assert `clear`**; and only
   then check that the next frame transmits correctly. The `clear` is not
   optional and is not a bench convenience: without it the transmit chain is
   still holding an unterminated frame, and requirements.md REQ-709's
   verification column now says so.
6. **REQ-810's application-interface half**: drive `cfg_tx_enable` = 0, offer a
   request, and assert that `payload_tready` is **0 on every cycle** — not "falls
   within N cycles" — that no `ip_hdr_valid` appears and that no start character
   reaches XGMII; then re-enable and assert the held offer is taken and the frame
   transmits. This is the assertion the `cfg_tx_enable` edge of §4.3 exists to
   make true, and a bench run against a design without that edge fails it on the
   first cycle.

## 9. Errors and discards

Strobe names are normative (requirements.md §12). M18 owns one of the
twenty-one, and it is the only strobe in the programme that reports two
conditions.

| Condition | Strobe (one cycle) | Stream effect | REQ |
|---|---|---|---|
| The application asserts `tlast` before the declared payload count has been delivered | `error_tx_length_mismatch` | M18 emits the octets it holds **without** `ip_payload_tlast` and then presents no further word for that frame. The frame is never terminated downstream: M15 waits for a payload `tlast` that does not come, and **M04 underflows and terminates the frame on the wire** with `/E/`, `/T/`, no FCS and one `error_underflow` pulse (REQ-206, SPEC-M04 §9). The transmit chain is left holding an unterminated frame and **`clear` is the recovery** (ADR-0011) | REQ-709 |
| The application presents a payload word beyond the declared count | `error_tx_length_mismatch` | the output frame is completed **normally** with exactly the declared octet count — `ip_payload_tlast` on the word carrying the declared count's last octets, `tkeep` marking exactly them — so the frame on the wire is well formed with a valid FCS; every excess word is **accepted and discarded** with `payload_tready` held 1, so the application is never stalled; `error_underflow` does not pulse | REQ-710 |

Silent discard is prohibited (REQ-008): both rows have a strobe. The `clear`
mid-frame case of §7 is REQ-009's, not REQ-008's.

**Strobe cycles, pinned.** `error_tx_length_mismatch` pulses for exactly one
cycle, on the cycle M18 **accepts** the application word that establishes the
condition — the short `tlast` word for REQ-709, the first word beyond the
declared count for REQ-710. Both are the earliest cycle the condition is
decidable from M18's own inputs, and both lie inside requirements.md §0.6's
window. One pulse per frame: `Excess` and `Short` are entered once and the pulse
is on entry, so an application that presents ten excess words produces **one**
high cycle and not ten.

**The two conditions cannot co-occur on one frame**, which is what makes one
strobe for two conditions legitimate under §0.6 rather than a shortcut: REQ-709's
condition is `tlast` **before** the declared count and REQ-710's is a word
**after** it, and a frame has one `tlast`. A bench distinguishing them therefore
reads the wire (`/E/` and `/T/` versus a valid FCS) or `error_underflow`, never
the strobe.

**`error_underflow` and `error_tx_length_mismatch` are two modules' reports of
one event, and they are not simultaneous.** M18's pulses on the cycle above;
M04's pulses on the first cycle M04 requires a word the path can no longer supply,
which is later by the number of words in flight between M18 and M04 and depends
on how far M15's drain had progressed. **Neither the separation nor its bound is
pinned**, and a bench asserts one pulse of each per under-delivered frame and
nothing about their relative timing (§6.3 item 5). SPEC-M04 §9's co-occurrence
bullet says the same from the other end. This is not a §0.6 re-report violation:
M04 detects its own condition at its own port — a required word that was not
presented — and M18 detects a different one, a declared count that was not met.

**What an under-delivery leaves behind, stated because ADR-0011 exists to make
it visible rather than discoverable.** After REQ-709's remedy the wire is correct
and both strobes have pulsed, and M18, M15 and M09 are all still holding the
frame: M18 in `Short`, M15 in its `Body` state waiting for a payload `tlast`, and
M09 still granting the IPv4 port (REQ-406's arbitration is frame-atomic, and the
frame never ends). Nothing is presented anywhere, so **no spurious frame reaches
the wire and no word is lost** — but no further application datagram is accepted
and no ARP reply is granted the transmit port until `clear` is asserted.
ADR-0011 records the alternatives, why each was rejected, and which one a later
phase should take if the trade changes; requirements.md REQ-709's verification
column names the `clear`; requirements.md §11 records the absence of a finer
recovery as a decision rather than an omission.

**Inherited aborts.** `payload_tuser`[0] on the application payload's `tlast`
word is copied to the output stream's `tlast` word and nothing else happens
(REQ-013, REQ-007). M18 pulses nothing for it and does not discard the datagram:
REQ-013 forbids dropping a frame solely for that bit, and on the transmit path
the ultimate consumer is beyond the wire.

## 10. REQ coverage

| REQ | How this module satisfies it | Section | Verification hook for DV |
|---|---|---|---|
| REQ-001 | one clock; no gated or derived clock | §3 | the emitted-Verilog edge-expression check |
| REQ-007, REQ-013 | inherited `tuser`[0] copied to the output `tlast` word and never acted on | §9 | drive `tuser`[0] = 1 on an application `tlast` word; assert the frame is transmitted unchanged with the bit set |
| REQ-008 | two conditions, one strobe, one pulse per frame, pulse cycles pinned, and the argument that the two conditions cannot co-occur | §9 | §8 items 4 and 5 |
| REQ-009 | `clear` abandons the frame and holds every output low; it is also the ADR-0011 recovery | §7 | reset test: assert mid-frame, deassert, offer a request on the next cycle and assert it transmits intact |
| REQ-010 | `Source` and `Dest` on both streams from the programme types; `Ip_header` is SPEC-M01's; `Udp_tx_request` is declared here under the declare-once rule and opened by SPEC-M19 and SPEC-M20 | §4.1 | interface compile check; the two later lifts opening `Udp_ip_tx_64_ifc` are the cross-module witness |
| REQ-011 | `ip_payload_tkeep` `0xFF` except on `tlast`; the declared count decides the last word's extent, not the application's `tkeep` | §6.1, §9 | protocol monitor on both streams; §8 item 4's `tkeep` = 0x0F assertion |
| REQ-012 | every header field emitted first wire octet first; the length field's octet order is what a hand-assembled reference pins | §6.1 | §8 item 2's decode of output word 0 |
| REQ-014 | `tstrb` ignored in, driven 0 out | §4.2 | protocol monitor; REQ-014's differential run |
| REQ-015 | one `tlast` per frame; at most 185 output words at the maximum declared length | §3, §7 | protocol monitor |
| REQ-016 | application idle cycles tolerated; M18 does not advance and emits nothing — with §6.1's warning that the gap reaches M04, which does not tolerate one | §6.1, §7 | idle-injection wrapper at 0, 1 and 7 cycles on the application stream at **M18's own ports**, where no underflow can result; the composed case is §11.2's |
| REQ-021 | output octet 0 at `ip_payload_tdata`[7:0]; every later output word is one application word unchanged, with no shifter | §3, §6.1 | payload lengths covering every residue modulo 8, asserting the octet string at M18's output equals the application's with eight octets prepended |
| REQ-207 | an accepted application word is transmitted, or accepted and dropped under REQ-710; `payload_tready` is 0 when M18 cannot accept | §6.1, §7 | drive a continuous source; assert the transmitted octet sequence equals the accepted-word octet sequence exactly once, in order, and that the run of 0 cycles at each frame's end is **W − J = one cycle**, not two (C-17(b), §6.1) |
| REQ-208 | M18 has no receive-side port, so no path from here into the receive datapath exists | §3 | inspection of the emitted netlist; REQ-208's top-level test |
| REQ-610 (UDP half) | UDP length = P + 8 emitted at octets 4–5; `ip_hdr_total_length` = P + 28 handed to M15; both computed from one request field with **no** payload buffering | §5, §6.1, §7 | §8 items 1 and 2. **The IPv4 total length's emission into octets 2–3 and the no-buffering property at M15's own port are M15's** and are claimed there, not here (§5) |
| REQ-705 | the request's four fields, the ADR-0008 offer discipline, and the no-buffering invariance in its strongest form — zero application words accepted before the first output word is accepted, at every length | §4.1, §6.1, §7 | §8 item 1's invariance test; interface compile check for the record |
| REQ-706 | the checksum field is the constant 0x0000 | §6.1 | §8 item 3 |
| REQ-709 (detection half) | the short `tlast` is detected on the cycle it is accepted, one strobe pulses, and no `ip_payload_tlast` is ever asserted for that frame | §6.2, §9 | §8 item 5. **The wire remedy — `/E/`, `/T/`, no FCS and `error_underflow` — is M04's** (SPEC-M04 §9) and is claimed there, not here; the recovery is `clear` (ADR-0011) |
| REQ-710 | the frame is completed at exactly the declared count, one strobe pulses, and every excess word is accepted and discarded | §6.2, §9 | §8 item 4 |
| REQ-802, REQ-803 | one configuration input, sampled only in `Idle`, so a frame in flight completes under the old value | §4.3 | change `cfg_tx_enable` mid-frame and assert the frame in flight completes and the next request waits |
| REQ-810 (application-interface half) | `cfg_tx_enable` = 0 keeps M18 in `Idle` with `payload_tready` = 0 on **every** cycle and no offer to M15 | §4.3, §6.1, §6.2 | §8 item 6. **The XGMII half is M04's**, the receive half is M03's and the ARP clause is M13's; all four are named in `traceability.md`'s REQ-810 row and none is claimed here |
| REQ-901 | declared divergence class **(d)** lives here: the zero UDP transmit checksum, so that field is not compared | header, §2 | the co-simulation report names class (d) against this module |
| REQ-903, REQ-808 | `udp_ip_tx_64` is a distinct emitted module with `create`, `hierarchical` and an `.mli` | §4.1 | repository surface check and the `rtl_snapshots/` name comparison |

This table is the source of M18's rows in [`traceability.md`](../traceability.md),
updated in the same commit.

## 11. Deferred items

Item numbers are permanent; a closed item keeps its row (SPEC-TEMPLATE §11).

| # | Item | Status · what a reader assumes meanwhile | Tracked as | Owner | Closes by |
|---|---|---|---|---|---|
| 11.1 | **The `ifc_check` compile evidence for this lift is pending**: `udp_ip_tx_64_ifc.ml` is new in this commit and declares batch F's only new record, which two later lifts in the same batch `open!`. | **DEFERRED — the record is written, the run is pending.** Meanwhile a reader assumes it exactly as §4.1 writes it. The declare-once shape has compiled green three times already — batch D's three intra-batch `open!`s at run 30736107842 and `ip_eth_tx_64_ifc.ml`'s cross-batch one at run 30739442056 — and there is no cycle, because neither M19's nor M20's lift is referenced here. A divergence is a red CI run on this commit and an editorial diff. | the `Interface compile check` row of §12 | architect_docs_lead, rtl_lead | the batch-F `ifc_check` run |
| 11.2 | **An application that gaps its own payload mid-frame can cause an underflow on the wire** (§6.1). REQ-016 obliges M18 to tolerate the gap and it does; M04's source interface does not tolerate one (REQ-206), and there is no elastic buffer between them by decision (requirements.md §11). So a gap of one cycle at the application port, arriving when M15 has no surplus word held, becomes `/E/` `/T/` and `error_underflow` on the wire. | **DEFERRED — the behaviour is fully specified at every module and a reader is not blocked.** Meanwhile the application's obligation is the one REQ-705's contract implies: present payload words continuously once a frame has been offered. What is *not* stated anywhere is how many cycles of slack the chain actually absorbs — M15 holds two payload words and M07 holds two, so a short gap early in a frame is absorbed and a gap near its end is not — and this specification deliberately does not pin that number, because it is a function of four modules' pipelines and pinning it here would make a change at any of them a diff here. The safe reading, and the one a bench should drive, is **zero slack**. If Phase 2's feed handler needs a stated bound, it is a spec diff at M04 or an elastic buffer, and the second reopens requirements.md §11. | this item; requirements.md §11; SPEC-M04 §7 | architect_docs_lead, dv_lead | Phase-2 transmit scoping, or the first `SO-` packet that drives a gapped transmit frame |
| 11.3 | **REQ-705 places no upper bound on the declared payload length**, and one exists in fact: above **1472** octets the IPv4 total length M18 computes exceeds REQ-612's 1500 and the frame on the wire exceeds 1518 octets, which nothing in the transmit path checks (M04 pads but never truncates). | **DEFERRED — the bound is derivable and stated here, and nothing is blocked.** A reader implements no check and assumes the application declares **1 ≤ P ≤ 1472**: 1 because a zero-octet payload has no encoding (§6.3 item 3) and 1472 because 1472 + 28 = 1500 = REQ-612's maximum. §6.3 item 4 records M18's behaviour outside that range as unconstrained, so DV asserts nothing about it and no bench may treat a larger declaration as a defect **or** as legal. The repair, if a later phase wants one, is a range clause on REQ-705 plus a strobe — and a strobe means a twenty-second entry in requirements.md §12, which REQ-804 and REQ-008 quantify over, so it is a requirements diff and a `Status` record change rather than a local check. That cost is why it is not taken now for a case the application controls entirely. | this item; requirements.md REQ-705, REQ-612 | architect_docs_lead, dv_lead | Phase-2 transmit scoping (E2) |
| 11.4 | **An under-delivered frame leaves the transmit chain holding an unterminated frame** and `clear` is its only recovery (ADR-0011, §9). | **DEFERRED — the decision is made, recorded and testable, and a reader is not blocked.** A reader implements §6.2's `Short` state exactly as written; a bench follows §8 item 5, which asserts the two strobes and the wire encoding and **then asserts `clear`** before the next frame, and requirements.md REQ-709's verification column says the same. ADR-0011 carries the three rejected alternatives, the sharpest being that M04 consumes and discards an aborted frame's remainder — which is the right repair the day this design meets real hardware, and which costs a REQ-207 scoping diff and a post-freeze §6 change at M04. The item is here so that the cost is priced before someone pays it by accident. | **ADR-0011**; requirements.md REQ-709 and §11 | architect_docs_lead, dv_lead | Phase-2 hardening, or the first real-hardware attach |

## 12. Freeze record

Filled in at `P1-spec-freeze`. All four rows are required (charter §5); this
spec is DRAFT.

| Item | Value |
|---|---|
| Interface compile check | pending — CI `build` run `<id>`, conclusion `<success>`, SHA `<sha>`; per ADR-0005 a local build is not acceptable evidence. This run is also §11.1's closure record |
| Architect signature | `J-architect_docs_lead-0008` |
| dv_lead testability countersignature | pending — batch F (SPEC-M17, M18, M19, M20) |
| Frozen at | pending — SHA `<sha>`, gate `docs/gates/P1-spec-freeze-checklist.md` |

## 13. Change log

Post-freeze changes only. This spec is DRAFT and has none.

| Date | Change | Breaking? | ADR | Journal |
|---|---|---|---|---|
| — | — | — | — | — |
