# SPEC-M09 — `Eth_arb_mux`

- **Status**: **FROZEN** (`P1-spec-freeze`, SHA `508eea2`) — batch C, dv_lead
  countersignature `J-dv_lead-0007`. Changes to §4, §6 or §7 after this point
  are spec diffs recorded in §13 (SPEC-TEMPLATE rule 7)
- **Inventory id**: M09 (architecture.md §4) · **Path**:
  `libs/hardcaml_ethernet/src/eth_arb_mux.ml`
- **Datapath role**: transmit
- **Owns REQs**: REQ-406
- **Prior-art counterpart**: `eth_arb_mux.v` (MIT) — consulted for decomposition
  and port naming only; behaviour below is stated independently and no source
  was copied
- **Depends on specs**: SPEC-M01 (`Axi64`, `Eth_header`), SPEC-M07
  (`Eth_axis_tx`, the module this one feeds), ADR-0008 (the transmit-side header
  handshake)
- **Author**: architect_docs_lead, journal `J-architect_docs_lead-0005`

## 1. Purpose

M09 is the transmit path's only fork: two sources want the wire — the ARP
transmitter and the IPv4 transmitter — and exactly one frame at a time may have
it. M09 chooses, holds the choice for the whole frame, and hands the winner
through to M07. It exists as a separate module because frame atomicity (REQ-406)
is the one property that cannot be enforced anywhere else: neither source can
know the other is mid-frame, and M07, which has a single input port, has already
lost the information needed to interleave incorrectly.

Its upstreams are M11 `Arp_eth_tx` and M15 `Ip_eth_tx_64`; its downstream is M07
`Eth_axis_tx`. It instantiates nothing.

## 2. Scope

**In scope.**

- Granting one of two input ports and holding that grant until the granted
  frame's `tlast` word is accepted — frame atomicity (REQ-406).
- Granting a waiting request no later than one cycle after the `tlast` of the
  frame in progress (REQ-406), which is what makes the arbiter fair enough that
  a continuously busy port cannot starve the other.
- Relaying the granted port's `Eth_header` record and payload stream to M07
  unchanged, and relaying M07's `tready` back to the granted port and to no
  other.
- Adding no latency and no storage of its own (§7).

**Not this module's job.**

| Behaviour a reader might expect here | Owner |
|---|---|
| Deciding *which* frame is more urgent — priority, quality of service, ageing | nobody in Phase 1. REQ-406 fixes atomicity and a grant deadline; it deliberately fixes no priority, and §6.3 records the tie as unconstrained on REQ-406's own instruction |
| Dropping a frame that cannot be transmitted | M13 `Arp` (`error_arp_reply_dropped`, REQ-510) — and it drops the *reply*, before M11 ever builds it, precisely so that M09 never has to. M09 discards nothing and raises no strobe (§9) |
| Buffering a frame while the other port is served | nobody: a waiting source holds its own words (ADR-0008), which is what a `tready` is for. M09 holds no payload word at all (§7) |
| Building or reading a header | M11 (REQ-502) and M15 (REQ-608); M09 relays the record and never inspects a field |
| Inserting the fourteen header octets into the frame stream | M07 `Eth_axis_tx` (REQ-405) |
| Splitting a stream in the receive direction | M08 `Eth_demux` (REQ-404). M08 and M09 are not each other's inverse: M08 splits a path with no `tready` anywhere, M09 merges a path with `tready` on both inputs, and it is the `tready` that makes arbitration possible at all |

## 3. Programme invariants that bind this module

M09 is **not** a receive-path module under requirements.md §0.4: it is on the
transmit chain and §1.1 allocates it no latency ceiling.

| REQ | Consequence for M09 |
|---|---|
| REQ-001 | One `clock`. The grant register is the module's only state and is synchronous to it. |
| REQ-002 | All three payload streams are 64-bit `Axi64`, at most one word per cycle each. |
| REQ-003 | Does not bind M09's ports — but REQ-208 does, and it holds structurally: M09 has no receive-side port, so no path from here into the receive datapath exists. |
| REQ-005 | Does not bind M09 (not a receive-path module). Its analogue is §7's zero added cycles, stated so that M07's and M04's cadences compose. |
| REQ-007, REQ-013 | `tuser`[0] is relayed on the granted frame's `tlast` word and never acted on. |
| REQ-008 | M09 owns **no** strobe: it detects no condition and discards nothing (§9). |
| REQ-009 | Synchronous `clear`: the grant is released, both input `tready` outputs are 0 and the output `tvalid` is 0 while `clear` = 1 and on the first cycle after; a frame in flight is abandoned (§7). |
| REQ-010 | Every stream port is the programme `Axi64.Source` with its matching `Axi64.Dest`; both header ports and the output header port are SPEC-M01's `Eth_header`. |
| REQ-011 | `tkeep` is relayed unchanged. |
| REQ-012 | Octet positions are relayed unchanged; M09 rotates nothing. |
| REQ-014 | `tstrb` is relayed unchanged (M07 ignores it and drives 0 outward). |
| REQ-015 | One `tlast` per frame on the output, the `tlast` word included in the count; the maximum is the larger of the two sources' maxima — **188** words, from M15's 1500-octet IPv4 datagram (REQ-612). **REQ-406's merge atomicity is what makes this count meaningful**: without it, words of two frames would fall between two `tlast` words and no maximum would be well defined. |
| REQ-016 | A granted source may deassert `tvalid` between words and M09 relays the idle cycle; the grant is unaffected, because a grant ends on a `tlast` and not on an idle. |
| REQ-020 | Order is preserved within each port. Across ports there is no order to preserve: two frames from different sources have no defined relative order, which is the same fact §6.3 records as the unconstrained tie. |
| REQ-021 | Word alignment is its sources'; M09 relays words untouched. |
| REQ-208 | No wire connects M09 to the receive datapath. Structural, and visible in §4.1: there is no receive-side port to connect. |

## 4. Interface

### 4.1 Interface records

```ocaml
(* SPEC-M09 §4.1, lifted verbatim into docs/specs/ifc_check/eth_arb_mux_ifc.ml
   (SPEC-TEMPLATE.md rule 6). Records and signatures only — no logic, no
   implementation.

   [Axi64_ifc] is M01's types home (SPEC-M01 §4.1): [Axi64] and
   [Eth_header] come from there and are restated nowhere.

   Transmit-path module with two input ports and one output port, so
   [Source] one way and [Dest] the other on each of the three logical
   streams: the two inputs' [Source]s are inputs and their [Dest]s are
   outputs, and the output stream is the reverse. Each stream's two
   directions share a prefix, with no collision because [Source]'s field
   names and [Dest]'s are disjoint (SPEC-M04 §4.1 fixes that pattern).

   A port requests by asserting its [Eth_header]'s [valid] together with
   its first payload word, and holds both until that word is accepted
   (ADR-0008). That is why no [ready] appears beside a header record
   here: acceptance of the first payload word IS the grant, observable on
   one wire that already exists. *)

open! Base
open Hardcaml
open! Axi64_ifc

module I = struct
  type 'a t =
    { clock : 'a
    ; clear : 'a
    ; arp_hdr : 'a Eth_header.t [@rtlprefix "arp_hdr_"]
    ; arp_payload : 'a Axi64.Source.t [@rtlprefix "arp_payload_"]
    ; ip_hdr : 'a Eth_header.t [@rtlprefix "ip_hdr_"]
    ; ip_payload : 'a Axi64.Source.t [@rtlprefix "ip_payload_"]
    ; payload_dest : 'a Axi64.Dest.t [@rtlprefix "payload_"]
    }
  [@@deriving hardcaml]
end

module O = struct
  type 'a t =
    { arp_payload_dest : 'a Axi64.Dest.t [@rtlprefix "arp_payload_"]
    ; ip_payload_dest : 'a Axi64.Dest.t [@rtlprefix "ip_payload_"]
    ; hdr : 'a Eth_header.t [@rtlprefix "hdr_"]
    ; payload : 'a Axi64.Source.t [@rtlprefix "payload_"]
    }
  [@@deriving hardcaml]
end

module type S = sig
  val create : Scope.t -> Signal.t I.t -> Signal.t O.t
  val hierarchical : ?instance:string -> Scope.t -> Signal.t I.t -> Signal.t O.t
end

(* REQ-010 type identity on all three streams, both directions. *)

let _witness_three_sources_and_three_dests
      (a : Signal.t Axi64.Source.t)
      (b : Signal.t Axi64.Source.t)
      (c : Signal.t Axi64.Source.t)
      (d : Signal.t Axi64.Dest.t)
  =
  a, b, c, d
;;
```

Conformance of this block to the template's rules for §4.1:

- Scalar fields carry `[@bits n]` unless one bit wide: `clock` and `clear` are
  one bit; every other field is inside a nested record carrying its own widths.
- Nested interfaces carry `[@rtlprefix]`, and each input port's two records
  share its prefix: `arp_payload_tvalid` … `arp_payload_tuser` beside
  `arp_payload_tready`, and the same for `ip_payload_` and for the output
  `payload_`.
- **`Source` one way and `Dest` the other, on each logical stream**: held. M09
  is allowed `tready` because it is not a receive-path module (requirements.md
  §0.4); REQ-208 holds structurally because M09 has no receive-side port.
- Both `create` and `hierarchical` are declared (REQ-903, REQ-808).

### 4.2 Port table

Every port in §4.1 appears exactly once. Direction is with respect to M09.
The two input ports are symmetric, so the ARP port's rows stand for both and the
IPv4 port's rows say only what differs.

| Port | Dir | Width | Meaning | REQ |
|---|---|---|---|---|
| `clock` | in | 1 | 156.25 MHz single domain | REQ-001 |
| `clear` | in | 1 | synchronous clear | REQ-009 |
| `arp_hdr_valid` | in | 1 | the ARP port requests: held with `arp_payload_tvalid` until the first payload word is accepted (ADR-0008) | REQ-406 |
| `arp_hdr_dst_mac`, `arp_hdr_src_mac`, `arp_hdr_ethertype` | in | 48/48/16 | the requested frame's header, stable while `arp_hdr_valid` = 1; relayed, never inspected | REQ-409 |
| `arp_payload_tvalid` … `arp_payload_tuser` | in | 1/64/8/8/1/1 | the ARP port's payload stream | REQ-010 |
| `arp_payload_tready` | out | 1 | the ARP port is granted and M07 can accept this cycle | REQ-406 |
| `ip_hdr_valid`, `ip_hdr_*`, `ip_payload_*` | in | as above | the IPv4 port, identical in every respect | REQ-406 |
| `ip_payload_tready` | out | 1 | the IPv4 port is granted and M07 can accept this cycle | REQ-406 |
| `hdr_valid`, `hdr_dst_mac`, `hdr_src_mac`, `hdr_ethertype` | out | 1/48/48/16 | the granted port's header record, relayed | REQ-405 |
| `payload_tvalid` … `payload_tuser` | out | 1/64/8/8/1/1 | the granted port's payload stream, relayed | REQ-010 |
| `payload_tready` | in | 1 | M07 accepts a word this cycle | REQ-207 |

### 4.3 Configuration inputs

**None.** REQ-406 fixes M09's whole behaviour and names no configurable
quantity: there is no priority to set, no weight, no timeout. Adding one would
make the tie a configured value instead of an unconstrained one, which is
exactly what §6.3 and REQ-406 decline to do. REQ-803 therefore has no instance
at M09.

## 5. Parameters

**None.** REQ-506's rule has no instance: M09 has no timeout, no ageing interval
and no retry — its grant ends on a `tlast`, an event, and never on a count.

| Parameter | Type | Default | Range | Why a test overrides it |
|---|---|---|---|---|
| (none) | — | — | — | — |

## 6. Behaviour

### 6.1 Normal path

M09 reads no header field and no payload octet, so there is no field table here.
What follows is the grant.

**Requesting (ADR-0008).** A port requests by asserting its header record's
`valid` **together with** `tvalid` for its frame's first payload word, on the
same cycle, and holding both — with the header fields and the payload word
stable — until that word is accepted. A port that is not requesting holds
`hdr_valid` = 0.

**Granting.** The grant is a register holding one of three values: *none*, *ARP*
or *IPv4*. It is evaluated on every cycle on which no frame is in progress:

1. if neither port requests, the grant is *none*;
2. if exactly one port requests, that port is granted;
3. if both request, the port that did **not** hold the previous grant is
   granted; if the previous grant was *none*, the choice is unconstrained
   (§6.3 item 1, on REQ-406's own instruction).

Rule 3's first half is what turns REQ-406's grant deadline into a property a
design can hold: a port transmitting back-to-back frames cannot re-take the
grant while the other is waiting, so a waiting request is granted at the first
frame boundary after it appears — no later than one cycle after the `tlast` of
the frame in progress, which is REQ-406's figure.

**Holding.** A frame is in progress from the cycle its first payload word is
accepted until the cycle its `tlast` word is accepted, inclusive. Throughout
that interval the grant register does not change, whatever the other port does:
that is frame atomicity, and it is a property of the register rather than of the
datapath, which is why no bench can observe an interleaving that a conformant
design could produce.

**Relaying.** While a port is granted, M09's output is that port's input, with
no register between: `hdr_*` is the granted port's header record, `payload_*` is
its payload stream, and the granted port's `payload_tready` is M07's
`payload_tready`. The ungranted port's `tready` is held **0**, so a source that
is requesting and not granted simply waits, holding its own first word — which
is what makes zero storage in M09 sufficient.

**Cycle by cycle, a grant hand-over.** Both ports request; the IPv4 port holds
the grant with a frame in progress; the ARP port has been waiting.

| Cycle | Grant | `ip_payload_tready` | `arp_payload_tready` | Output |
|---|---|---|---|---|
| G | IPv4 | 1 | 0 | the IPv4 port's word, `tlast` = 0 |
| G+1 | IPv4 | 1 | 0 | the IPv4 port's **`tlast`** word, accepted this cycle |
| G+2 | **ARP** | 0 | 1 | the ARP port's first word, `hdr` = the ARP header — accepted this cycle if M07's `payload_tready` is 1 |

The grant changes on the cycle **after** the `tlast` word is accepted, which is
REQ-406's "no later than one cycle after the `tlast` of the frame in progress"
met exactly, and the waiting port's first word is offered to M07 on that same
cycle. M09 costs the transmit path **nothing** between frames — the one cycle in
the table is the register's, and REQ-406 budgets for it.

**When M07 stalls.** `payload_tready` = 0 reaches the granted port unchanged, so
the granted source holds its word. Nothing is dropped, nothing advances, and the
grant is unaffected — a stall is not a frame boundary.

### 6.2 State machine

Reset state and `clear` state are both `Idle` with the grant *none*.

| State | Entered when | Does | Leaves to |
|---|---|---|---|
| `Idle` | reset; `clear`; the granted frame's `tlast` word is accepted | evaluates the grant rule of §6.1 every cycle; drives the selected port's `tready` from `payload_tready` and the other's to 0; `hdr_valid` and `payload_tvalid` are the selected port's | `Busy` on the cycle a granted port's first payload word is accepted |
| `Busy` | a granted port's first payload word is accepted | holds the grant register unchanged; relays that port's header, payload and `tready` and holds the other port's `tready` at 0 | `Idle` on the cycle the granted port's `tlast` word is accepted |

Two things this table is deliberately explicit about. **The grant is evaluated
in `Idle`, including on the cycle a request first appears** — so a request
arriving into an idle arbiter is granted the same cycle and M09 adds no
start-up latency. And **`Idle` is where a request may be granted but no word has
yet been accepted**: if M07's `payload_tready` is 0, M09 stays in `Idle` with a
selected port and nothing happens, which is a wait and not a state.

### 6.3 Deliberately unconstrained

Anything not listed here is constrained by this specification, and a test may
rely on it.

1. **Which port wins when both request simultaneously into an idle arbiter with
   no previous grant** — after `clear`, or after an interval in which neither
   port requested. REQ-406 states this exclusively: *"Which port wins a
   simultaneous tie is deliberately unconstrained and SHALL NOT be asserted;
   SPEC-M09 §6.3 records that."* It is recorded here, and the reason is worth
   one sentence: constraining it would commission a test whose only content is
   the implementation's choice, and would make a later change of that choice a
   spec diff for no behavioural gain. What is **not** unconstrained is the
   repeated case — rule 3 of §6.1 forbids the same port winning twice while the
   other waits, and that *is* asserted (§8).
2. **The encoding of the grant register** and of the `Idle`/`Busy` state, and
   whether they are one register or two.
3. **The value of the output header and payload fields on cycles where
   `hdr_valid` and `payload_tvalid` are 0**, and of an ungranted port's relayed
   values (SPEC-M01 §6.3 item 5).
4. **M09's behaviour when a source violates ADR-0008** — asserting `hdr_valid`
   without a payload word, changing a header field while `hdr_valid` is held,
   or deasserting `hdr_valid` before its first word is accepted. No conformant
   source does any of these (SPEC-M11 and SPEC-M15 restate the obligation), no
   requirement names the case, and DV SHALL assert nothing about it.

## 7. Timing contract

- **Latency.** **Zero cycles added.** The granted port's `Source` fields appear
  at M09's output, and M07's `tready` appears at the granted port's
  `payload_tready`, as combinational functions of the grant register — so an
  octet's octet time at M09's output equals its octet time at the granted input,
  L = 0 and ΔC = 0.

  M09 is not a receive-path module: requirements.md §1.1 allocates it no ceiling
  and REQ-006's budget does not contain it. The zero is stated rather than
  omitted for the reason SPEC-M05 §7 states its own: a future revision that
  registered the datapath would change the transmit chain's cadence and must be
  a visible spec diff to this bullet, not an implementation detail.

  **The grant, by contrast, is registered**, and REQ-406's one-cycle deadline is
  exactly that register (§6.1). Frame atomicity comes from the register;
  transparency comes from the datapath; and separating them is what lets M09 add
  no cycles while still being unable to interleave.

- **Throughput.** One word per cycle through the granted port whenever M07 can
  accept one. M09 introduces no bubble inside a frame and exactly one cycle
  between frames when the grant changes hands (§6.1) — which the inter-frame gap
  M04 must serve anyway (REQ-204, at least 12 octets) absorbs entirely, so M09
  costs REQ-209's 11-cycle frame period nothing.

- **Handshake rules.** A word is accepted on a cycle with `tvalid` = 1 and
  `tready` = 1 at the granted port; the same cycle, the same word, is accepted
  at M09's output by M07, because the two `tready` signals are the same wire.
  `tkeep`, `tlast`, `tuser` and `tstrb` are relayed unchanged.

  **The header record's `valid` is a level here, not a pulse** — held from the
  request until the frame's first payload word is accepted, with fields stable
  (ADR-0008). This is the transmit-side discipline, the opposite of REQ-401's
  one-cycle receive-side pulse (SPEC-M06 §7), and a monitor written for one and
  attached to the other reports a defect that is not there.

  A granted source may deassert `tvalid` between words (REQ-016); M09 relays the
  idle cycle and the grant is unaffected, because a grant ends on a `tlast` and
  not on an idle.

- **Reset.** While `clear` = 1 and on the first cycle after it returns to 0: the
  grant is *none*, both input `tready` outputs are 0, `payload_tvalid` = 0 and
  `hdr_valid` = 0. `clear` asserted mid-frame abandons the granted frame — M07
  and M04 abandon the same frame on the same cycle (SPEC-M07 §7, SPEC-M04 §7),
  which is REQ-009's explicit permission and the only silent frame loss in this
  specification. A request present on the first cycle after `clear` returns to 0
  is granted on the next cycle and transmitted correctly, because the source
  holds it (ADR-0008).

- **Configuration sampling.** None; M09 reads no configuration (§4.3).

- **Timing closure.** M09's datapath and its `tready` are combinational, and
  they sit between M15 or M11 and M07, whose own output is registered
  (SPEC-M07 §7). Phase 1 is simulation-only at the XGMII boundary (REQ-018) so
  no static timing closure at 6.4 ns is required; if a later phase cannot close
  the M15 → M09 → M07 path, the remedy is a spec diff to this bullet and an ADR
  — a registered grant path with a re-stated cadence — and never a quiet
  register, which would change REQ-406's measured grant delay without changing
  any document.

## 8. Line-rate stress obligation

**Not applicable.** M09 is not in requirements.md §0.4's stress-bench list (M03,
M06, M08, M10, M14, M17, M20), which enumerates *receive-path* modules —
REQ-004's invariant is about surviving an arrival rate the module cannot slow
down, and M09 can slow either source down with `tready`, which is the whole
mechanism of arbitration.

Its equivalent obligation is REQ-406's two-port bench, and it is stronger than a
throughput figure:

1. **Atomicity.** Two ports issue frames simultaneously and continuously, with
   distinguishable payloads (a per-port tag in the first payload octet and a
   per-frame sequence number in the next four). Assert that between any two
   successive `tlast` words on M09's output every word carries the same port tag
   — no interleaving — for at least 10 000 frames.
2. **The grant deadline.** For every frame boundary at which the other port was
   requesting, measure the cycles from the `tlast` acceptance to the acceptance
   of the waiting port's first word, and assert it is **1** (REQ-406's "no later
   than one cycle after"), allowing for cycles on which M07's `payload_tready`
   is 0, which are not M09's to give.
3. **No starvation, which is what rule 3 buys.** With both ports continuously
   requesting, assert that the granted port **alternates** frame by frame. This
   is the assertion the unconstrained tie of §6.3 does not forbid: the tie is
   unconstrained only from a standing start, and asserting alternation from the
   second frame onward tests the fairness rule rather than the implementation's
   arbitrary first choice.
4. **Order within a port.** Each port's frames arrive at the output in the order
   that port issued them, with no duplication (REQ-020).
5. **Composition.** Repeat item 1 with M09 driving M07 and M04, and assert
   REQ-209's figures are unchanged: the mean is 11 cycles per minimum-length
   frame and no inter-frame spacing differs from 11. This is what proves M09's
   one grant cycle fits inside M04's gap (§7).

## 9. Errors and discards

**Not applicable as a detection table.** M09 detects no abnormal condition,
discards nothing and raises no strobe. Every frame accepted at an input port is
relayed to the output; a source that is not granted is not refused, it is
delayed, and it holds its own words while it waits.

| Condition | Strobe (one cycle) | Stream effect | REQ |
|---|---|---|---|
| (none detected here — see above) | — | — | — |

**REQ-008 is not weakened by an empty table**, and the reason is a design
decision made one module away rather than an accident here. The condition a
merge point would otherwise own — "a frame arrived that cannot be sent" — is
owned by M13 `Arp`, which holds at most one pending reply and drops the second
with `error_arp_reply_dropped` (REQ-510) *before* M11 builds it. REQ-510's own
words say it is "the only condition under which a reply is dropped, and it is
reachable by construction". So M09 never faces an undeliverable frame, and
requirements.md §12's twenty-one strobes contain none for this module because
there is no condition here to name.

Frame conservation (requirements.md §0.6) at M09's ports is the sum identity:
frames out equals frames in on port A plus frames in on port B, with no discard
term. That is exactly what a monitor should assert here, and a discrepancy is a
lost or duplicated frame, not a discard.

**Inherited aborts.** `tuser`[0] on a granted frame's `tlast` word is relayed
and nothing else happens (REQ-013, REQ-007). M09 pulses nothing for it:
re-reporting an inherited abort is forbidden by requirements.md §0.6, and M09
has no strobe to re-report it with.

## 10. REQ coverage

| REQ | How this module satisfies it | Section | Verification hook for DV |
|---|---|---|---|
| REQ-001 | one clock; the grant register is the only state | §3, §7 | the emitted-Verilog edge-expression check |
| REQ-007, REQ-013 | `tuser`[0] relayed on the granted `tlast` word, never acted on | §9 | drive `tuser`[0] = 1 on a granted frame's `tlast`; assert the frame reaches M07 unchanged with the bit set |
| REQ-008 | no condition detected, no strobe owned; the merge point's would-be condition is REQ-510's, owned by M13 | §9 | the frame-conservation monitor at M09's three ports: out = A in + B in, no discard term |
| REQ-009 | `clear` releases the grant and holds every `tready` and `tvalid` low | §7 | reset test: assert mid-frame on the granted port, deassert, request on the next cycle |
| REQ-010 | `Source` and `Dest` on all three streams, from the programme types | §4.1 | interface compile check |
| REQ-011, REQ-014 | `tkeep` and `tstrb` relayed unchanged | §7 | protocol monitor on all three streams |
| REQ-015 | one `tlast` per output frame; at most 188 words, the `tlast` word included — meaningful *because* of REQ-406 | §3, §7 | protocol monitor on the output stream, which fails immediately on any interleaving |
| REQ-016 | a granted source's idle cycles are relayed; the grant is unaffected | §6.1, §7 | idle-injection wrapper at 0, 1 and 7 cycles on the granted port, asserting atomicity and order are unchanged |
| REQ-020 | order preserved within each port; across ports there is no order to preserve | §3, §8 | per-port sequence numbers in the two-port bench |
| REQ-021 | words relayed untouched; M09 realigns nothing | §3 | the octet comparison in the two-port bench |
| REQ-208 | M09 has no receive-side port, so no path into the receive datapath exists | §3, §4.1 | inspection of the emitted netlist; REQ-208's top-level test |
| REQ-406 | grant register held for the whole frame; a waiting request granted one cycle after the `tlast`; the simultaneous tie unconstrained and the repeated case not | §6.1, §6.2, §6.3 | the two-port bench of §8, items 1 to 3: atomicity over 10 000 frames, the measured grant delay, and alternation under continuous demand. The tie from a standing start SHALL NOT be asserted |
| REQ-207 | M07's `tready` is relayed to the granted port only; an accepted word is never dropped | §6.1, §7 | assert the output octet sequence equals the concatenation of the two ports' accepted-word sequences, each in order |
| REQ-510 | not owned, but **relied on**: it is why M09 needs no drop condition | §9 | none at M09 — stated so that no sign-off packet claims REQ-510 coverage here |
| REQ-903, REQ-808 | `eth_arb_mux` is a distinct emitted module with `create`, `hierarchical` and an `.mli` | §4.1 | repository surface check and the `rtl_snapshots/` name comparison |

This table is the source of M09's rows in [`traceability.md`](../traceability.md),
updated in the same commit.

## 11. Deferred items

Item numbers are permanent; a closed item keeps its row (SPEC-TEMPLATE §11).

| # | Item | Status · what a reader assumes meanwhile | Tracked as | Owner | Closes by |
|---|---|---|---|---|---|
| 11.1 | **The `ifc_check` compile evidence for this lift is pending**: `eth_arb_mux_ifc.ml` is new in this commit and is the widest record batch C adds (three streams, two directions each). | **CLOSED (WO-0014).** CI `build` run **30733153172** at f457efc reports `success` with this lift in it, and `git diff 508eea2 f457efc -- docs/specs/ifc_check/` is empty, so the run witnesses the record frozen here. | the `Interface compile check` row of §12 | architect_docs_lead, rtl_lead | closed |
| 11.2 | **M09's datapath is combinational** (§7), so the M15 → M09 → M07 path and the `payload_tready` path back through it are the longest combinational runs in the transmit chain. | **DEFERRED — nothing in Phase 1 depends on closing them.** REQ-018 keeps the XGMII boundary simulation-only and no static timing closure at 6.4 ns is required, so a reader builds the combinational mux today. If a later phase cannot close the path, §7's timing-closure bullet states the remedy — a spec diff plus an ADR restating the cadence — and forbids the quiet register that would otherwise change REQ-406's measured grant delay. | this item; SPEC-M04 §7's equivalent note | architect_docs_lead, rtl_lead | Phase-3 attach, or the first synthesis attempt |
| 11.3 | **The transmit-side header handshake is a programme convention, not this module's invention** (ADR-0008), and M09 is the module that consumes it most sharply: the *request* signal is `hdr_valid`. | **CLOSED (WO-0017), affirmatively: both of M09's sources have restated the source-side obligation and neither needed an exception.** SPEC-M11 §7 (batch D) offers M09's `arp_*` port under decisions 1, 2 and 4, and SPEC-M15 §7 (batch E) offers its `ip_*` port under the same three — so both of this arbiter's request signals are levels held until their first payload word is accepted, which is exactly what makes the grant observable on `payload_tready` and nowhere else (§6.1). ADR-0008 needed no supersession; it gained C-22's precedence clause, which concerns monitors rather than sources and does not change what either source does. | ADR-0008 | architect_docs_lead | closed |

## 12. Freeze record

Filled in at `P1-spec-freeze`. All four rows are required (charter §5).

| Item | Value |
|---|---|
| Interface compile check | CI `build` run **30733153172**, conclusion **`success`**, SHA **f457efc** — all nine batch-A/B/C lifts elaborate, this one included; per ADR-0005 a local build is not acceptable evidence. `git diff 508eea2 f457efc -- docs/specs/ifc_check/` is empty, so the run witnesses the record frozen at 508eea2 |
| Architect signature | `J-architect_docs_lead-0005` |
| dv_lead testability countersignature | `J-dv_lead-0007` (WO-0013) — **SIGNED**, batch C; REQ-406's grant deadline re-derived at the bound and starvation checked under rule 3. No C-17 item is raised against this specification |
| Frozen at | SHA **508eea2**, gate `docs/gates/P1-spec-freeze-checklist.md` |

## 13. Change log

Post-freeze changes only. Each row cites the ADR that authorised it; a breaking
interface change is counted against post-freeze churn (charter §6). §4.1's
record is byte-for-byte unchanged since the freeze SHA. **No post-freeze change
has been made to this specification.**

| Date | Change | Breaking? | ADR | Journal |
|---|---|---|---|---|
| — | — | — | — | — |
