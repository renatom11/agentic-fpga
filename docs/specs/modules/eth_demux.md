# SPEC-M08 — `Eth_demux`

- **Status**: **FROZEN** (`P1-spec-freeze`, SHA `508eea2`) — batch C, dv_lead
  countersignature `J-dv_lead-0007`. Changes to §4, §6 or §7 after this point
  are spec diffs recorded in §13 (SPEC-TEMPLATE rule 7)
- **Inventory id**: M08 (architecture.md §4) · **Path**:
  `libs/hardcaml_ethernet/src/eth_demux.ml`
- **Datapath role**: receive
- **Owns REQs**: REQ-404
- **Prior-art counterpart**: `eth_demux.v` (MIT) — consulted for decomposition
  and port naming only; behaviour below is stated independently and no source
  was copied
- **Depends on specs**: SPEC-M01 (`Axi64`, `Eth_header`), SPEC-M06
  (`Eth_axis_rx`, the module whose output timing this one is written against)
- **Author**: architect_docs_lead, journal `J-architect_docs_lead-0005`

## 1. Purpose

M08 reads one number — the ethertype — and sends the frame to one of two
places, or to neither. It exists as a separate module because that decision is
the only thing on the receive path that is a *choice*, and isolating it means
neither the ARP parser nor the IPv4 parser has to check whether a frame is
addressed to it, and neither has a discard condition it did not cause.

Its upstream is M06 `Eth_axis_rx`; its downstreams are M10 `Arp_eth_rx`
(ethertype 0x0806) and M14 `Ip_eth_rx_64` (ethertype 0x0800). It instantiates
nothing.

## 2. Scope

**In scope.**

- Routing a header record and its payload frame to the IPv4 port on ethertype
  0x0800 and to the ARP port on 0x0806 (REQ-404).
- Discarding a frame of any other ethertype — 0x8100 VLAN and 0x86DD IPv6
  included — with a single `error_unknown_ethertype` pulse (REQ-404, REQ-008).
- Preserving, on the routed port, the relationship SPEC-M06 §7 establishes
  between a header record's `valid` pulse and its frame's first payload word.
- Constant per-octet latency on every routed octet (REQ-005), at the smallest
  word delay requirements.md §1.1 allocates to any module.

**Not this module's job.**

| Behaviour a reader might expect here | Owner |
|---|---|
| Reading anything inside the payload | M10 (REQ-501) and M14 (REQ-601 …). M08 reads `hdr_ethertype` and nothing else — not one payload octet |
| Filtering on destination MAC, IP address or port | nobody at this layer: MAC filtering does not exist (REQ-407), IP filtering is M14's (REQ-604), port filtering is M17's (REQ-704) |
| Buffering a frame while the decision is made | nobody — the decision is available a cycle *before* the first payload word arrives (§6.1), which is exactly why REQ-404 can say the discard "is clean and needs no abort interaction" |
| Deciding what happens to an aborted frame it routes | REQ-007: the abort bit is relayed on the routed port's `tlast` word and M08 re-reports nothing (§9) |
| Arbitrating in the other direction — merging two transmit sources | M09 `Eth_arb_mux` (REQ-406). M08 and M09 are not each other's inverse: M08 splits a receive path with no `tready` anywhere, M09 merges a transmit path with `tready` on both inputs |
| VLAN tag parsing | nobody: out of Phase-1 scope, and 0x8100 is discarded by this module (requirements.md §11) |

## 3. Programme invariants that bind this module

M08 is a receive-path module under requirements.md §0.4 — the third link of the
chain — and its input and both output payload streams are receive-path streams.

| REQ | Consequence for M08 |
|---|---|
| REQ-001 | One `clock`. The single register level of §7 is synchronous to it. |
| REQ-002 | Input and both output payload streams are 64-bit `Axi64`, at most one word per cycle each. |
| REQ-003 | Every payload port is `Axi64.Source` **without** `Axi64.Dest`, and no `tready` exists anywhere in §4.1: neither downstream can stall M08 and M08 cannot stall M06. This is what forces the discard in §9 to be a discard rather than a stall. |
| REQ-004 | M08 is on requirements.md §0.4's stress-bench list. Its stimulus is the stream M06 produces under REQ-004's arrival pattern, derived by construction (§8). |
| REQ-005 | Cut-through, trivially: M08 forwards each word one cycle after it arrives and withholds nothing. Per-octet latency is the single constant **L = 8 octet times** of §7. |
| REQ-007 | An abort inherited on the input payload's `tlast` word is relayed on the routed port's `tlast` word. M08 originates no abort. |
| REQ-008 | M08's one discard condition has a strobe (§9). It owns one of the twenty-one (requirements.md §12). |
| REQ-009 | Synchronous `clear`. On every cycle `clear` = 1 and on the first cycle it is 0: both `payload_tvalid` outputs are 0, both `hdr_valid` outputs are 0 and `error_unknown_ethertype` is 0. A frame in flight is truncated with no `tlast` and no strobe (§7). |
| REQ-010 | Every stream port is the programme `Axi64.Source`; both header ports are SPEC-M01's `Eth_header`. M08 declares no record of its own (§4.1). |
| REQ-011 | `tkeep` is relayed unchanged: `0xFF` on every word but the `tlast` word, 1 to 8 contiguous ones there. |
| REQ-012 | Octet positions are relayed unchanged; M08 rotates nothing. The ethertype it compares against is a numeric value, so the comparison is `hdr_ethertype` = 0x0800, not an octet-order puzzle (REQ-409). |
| REQ-013 | `tuser`[0] is relayed on the `tlast` word. M08 never drops a frame because of it — a frame it discards is discarded for its ethertype, which is its own locally detected condition (requirements.md §0.6). |
| REQ-014 | `tstrb` is ignored on the input and driven to 0 on both outputs. |
| REQ-015 | One `tlast` per frame on each output; at most **188** words between two `tlast` words (SPEC-M06 §3's figure, relayed unchanged), the `tlast` word included, at least one. |
| REQ-016 | Idle cycles inside a frame are relayed as idle cycles: k idle cycles on the input delay every octet that follows by exactly 8k octet times and change nothing else. |
| REQ-017, REQ-018 | No instance: M08 sees no lane and no control character. |
| REQ-019 | Word delay ΔC = (L + h)/8 = (8 + 0)/8 = **1** cycle against a ceiling of **1** (requirements.md §1.1). Payload storage is **one** datapath word, the register that produces the cycle. |
| REQ-020 | Frames leave in the order they arrived, on whichever port they leave; M08 handles one frame at a time (§6.2). |
| REQ-021 | M08 strips nothing, so h = 0 and no realignment is needed or performed: word-aligned in, word-aligned out. It is the one module in requirements.md §1.1's table with h = 0, and that is why its ceiling is one cycle. |

## 4. Interface

### 4.1 Interface records

```ocaml
(* SPEC-M08 §4.1, lifted verbatim into docs/specs/ifc_check/eth_demux_ifc.ml
   (SPEC-TEMPLATE.md rule 6). Records and signatures only — no logic, no
   implementation.

   [Axi64_ifc] is M01's types home (SPEC-M01 §4.1): [Axi64] and
   [Eth_header] come from there and are restated nowhere.

   Receive-path module: three [Axi64.Source] ports and no [Axi64.Dest]
   anywhere, which is REQ-003 structurally. A demultiplexer is the module
   at which a designer is most tempted to add backpressure — "stall the
   input while the slow port drains" — and the absence of the type is
   what makes that a spec diff rather than a decision. *)

open! Base
open Hardcaml
open! Axi64_ifc

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
    { ip_hdr : 'a Eth_header.t [@rtlprefix "ip_hdr_"]
    ; ip_payload : 'a Axi64.Source.t [@rtlprefix "ip_payload_"]
    ; arp_hdr : 'a Eth_header.t [@rtlprefix "arp_hdr_"]
    ; arp_payload : 'a Axi64.Source.t [@rtlprefix "arp_payload_"]
    ; error_unknown_ethertype : 'a
    }
  [@@deriving hardcaml]
end

module type S = sig
  val create : Scope.t -> Signal.t I.t -> Signal.t O.t
  val hierarchical : ?instance:string -> Scope.t -> Signal.t I.t -> Signal.t O.t
end

(* REQ-010 type identity at all three stream ports. *)

let _witness_streams_are_the_programme_type
      (a : Signal.t Axi64.Source.t)
      (b : Signal.t Axi64.Source.t)
      (c : Signal.t Axi64.Source.t)
  =
  a, b, c
;;
```

Conformance of this block to the template's rules for §4.1:

- Scalar fields carry `[@bits n]` unless one bit wide: `clock`, `clear` and
  `error_unknown_ethertype` are one bit; every other field is inside a nested
  record carrying its own widths.
- Nested interfaces carry `[@rtlprefix]`, and the two output pairs are prefixed
  by destination — `ip_hdr_valid` … `ip_payload_tuser` and `arp_hdr_valid` …
  `arp_payload_tuser` — so the port names say where a wire goes.
- **Receive-path `Source` without `Dest`: held** at all three stream ports.
- Both `create` and `hierarchical` are declared (REQ-903, REQ-808).

### 4.2 Port table

Every port in §4.1 appears exactly once.

| Port | Dir | Width | Meaning | REQ |
|---|---|---|---|---|
| `clock` | in | 1 | 156.25 MHz single domain | REQ-001 |
| `clear` | in | 1 | synchronous clear | REQ-009 |
| `hdr_valid` | in | 1 | one cycle high: the other three fields are the header of the frame whose first payload word arrives next cycle | REQ-401 |
| `hdr_dst_mac` | in | 48 | destination MAC, numeric; relayed, never compared | REQ-409, REQ-407 |
| `hdr_src_mac` | in | 48 | source MAC, numeric; relayed | REQ-409 |
| `hdr_ethertype` | in | 16 | ethertype, numeric — **the only input M08 makes a decision from** | REQ-404 |
| `payload_tvalid` | in | 1 | this cycle carries a payload word | REQ-016 |
| `payload_tdata` | in | 64 | payload octets, word-aligned | REQ-012, REQ-021 |
| `payload_tkeep` | in | 8 | valid octet positions | REQ-011 |
| `payload_tstrb` | in | 8 | reserved; ignored | REQ-014 |
| `payload_tlast` | in | 1 | this word carries the payload's final octets | REQ-015 |
| `payload_tuser` | in | 1 | bit 0: inherited abort, on the `tlast` word | REQ-013, REQ-007 |
| `ip_hdr_valid`, `ip_hdr_dst_mac`, `ip_hdr_src_mac`, `ip_hdr_ethertype` | out | 1/48/48/16 | the input header, one cycle later, when the ethertype is 0x0800 | REQ-404 |
| `ip_payload_tvalid` … `ip_payload_tuser` | out | 1/64/8/8/1/1 | the payload stream, one cycle later, when the ethertype is 0x0800 | REQ-404 |
| `arp_hdr_valid`, `arp_hdr_dst_mac`, `arp_hdr_src_mac`, `arp_hdr_ethertype` | out | 1/48/48/16 | the input header, one cycle later, when the ethertype is 0x0806 | REQ-404 |
| `arp_payload_tvalid` … `arp_payload_tuser` | out | 1/64/8/8/1/1 | the payload stream, one cycle later, when the ethertype is 0x0806 | REQ-404 |
| `error_unknown_ethertype` | out | 1 | one-cycle strobe: the ethertype was neither 0x0800 nor 0x0806 | REQ-404, REQ-008 |

### 4.3 Configuration inputs

**None.** The two accepted ethertypes are protocol constants fixed by REQ-404,
not configuration: making them runtime-settable would let a bench configure a
routing table the programme does not have, and REQ-802's twelve fields contain
no ethertype for exactly that reason. REQ-803 therefore has no instance at M08.

## 5. Parameters

**None.** REQ-506's rule has no instance: M08 has no timeout, no ageing interval
and no retry. The two constants 0x0800 and 0x0806 are REQ-404's and are not
overridable, for the reason §4.3 gives.

| Parameter | Type | Default | Range | Why a test overrides it |
|---|---|---|---|---|
| (none) | — | — | — | — |

## 6. Behaviour

### 6.1 Normal path

M08 reads no header **field offsets** — it never sees the frame's header octets,
only the decoded record — so there is no octet-offset table here. The one field
it reads is `hdr_ethertype`, a 16-bit numeric value (REQ-012, REQ-409):

| `hdr_ethertype` | Routed to | Strobe |
|---|---|---|
| 0x0800 | `ip_hdr` and `ip_payload` | none |
| 0x0806 | `arp_hdr` and `arp_payload` | none |
| anything else, 0x8100 and 0x86DD included | neither port | `error_unknown_ethertype`, once |

**Why the decision is always in time.** SPEC-M06 §7 puts `hdr_valid` exactly one
cycle before its frame's first payload word. M08 captures the routing decision
on the `hdr_valid` cycle into a register, and that register is what steers the
payload from the very first word — so no payload word is ever forwarded before
the decision exists, no word has to be held back while it is made, and a
discarded frame's first word is never emitted anywhere. That is the property
REQ-404's verification column names when it says the discard "is clean and needs
no abort interaction", and it is a property of M06's contract rather than of
M08's cleverness.

*What this specification does **not** say about a producer that pulsed `valid`
on the same cycle as the first payload word* (carry-forward **C-17(c)**,
dv_lead). Such a producer would satisfy REQ-401's "on or before" and would force
M08 to a combinational decision. An earlier revision of this paragraph said
"M08 tolerates that too" without saying what M08's output timing would then be,
while §6.3 opens by declaring that anything not on its list is constrained here —
so the sentence claimed a behaviour and specified none. The case is
**unreachable**: M06 is M08's only producer and always leads by exactly one
cycle (SPEC-M06 §7). It is therefore recorded as unreachable in §6.3 item 5,
in the form SPEC-M07 §6.3 item 3 and SPEC-M09 §6.3 item 4 use, and every cycle
formula below assumes M06's one-cycle lead without qualification.

**On a gapless stimulus**, with H the cycle of the input `hdr_valid` pulse:

| Cycle | Input | Output (ethertype 0x0800) |
|---|---|---|
| H | `hdr_valid` = 1, fields valid | nothing yet |
| H+1 | payload word 0 | **`ip_hdr_valid` = 1**, fields relayed |
| H+2 | payload word 1 | `ip_payload` word 0 |
| H+1+m | payload word m | `ip_payload` word m−1 |
| H+2+M | idle (the input `tlast` was at H+1+M) | `ip_payload` word M, `tlast` = 1, `tuser`[0] relayed |

Every output is the input delayed by exactly one cycle and steered; the
`arp_*` ports hold `valid` = 0 and `tvalid` = 0 throughout. For ethertype 0x0806
the table is the same with the two output ports exchanged.

The one-cycle relation between a header pulse and the first payload word is
therefore **preserved** at M08's output, which is what lets M10 and M14 be
written against the same producer contract M08 was (SPEC-M06 §7).

**Gapped stimulus.** An input cycle carrying no payload word produces an output
cycle carrying none: M08 relays idle for idle (REQ-016), so k idle cycles delay
everything after them by exactly 8k octet times. The cycle formulas above hold
on a gapless stimulus; the **per-octet** constant of §7 holds on every stimulus,
and that is what a bench asserts (the same distinction carry-forward C-14.4
fixed in SPEC-M03 §6.1).

**When the ethertype is unknown.** No word is emitted on either port and no
`valid` is pulsed on either header port. `error_unknown_ethertype` pulses once,
on cycle H + 1 — the cycle on which the routed header would have been emitted.
The frame's payload words are accepted and dropped as they arrive, because M08
has no `tready` with which to refuse them (REQ-003) and REQ-404 requires the
frame gone rather than stalled. Frame conservation counts that frame against its
strobe (requirements.md §0.6).

**A frame with no payload (requirements.md §0.7).** M06 emits a header record
with no payload frame for a 14-octet Ethernet frame. M08 routes the header
normally — it is a frame, and its ethertype decides its port exactly as any
other's — and no payload frame follows on the routed port. Every downstream
module SHALL tolerate that (§0.7); M10 and M14 restate the obligation in their
own §7. If such a frame's ethertype is unknown it is discarded like any other,
with one strobe and nothing emitted.

### 6.2 State machine

Reset state and `clear` state are both `Idle`.

| State | Entered when | Does | Leaves to |
|---|---|---|---|
| `Idle` | reset; `clear`; the input payload `tlast`; a `hdr_valid` pulse that ends a payload-less frame | relays nothing; both `valid` outputs and both `tvalid` outputs 0 | `Ipv4`, `Arp` or `Drop` on `hdr_valid` = 1, chosen by `hdr_ethertype` |
| `Ipv4` | `hdr_valid` with `hdr_ethertype` = 0x0800 | relays the header on `ip_hdr` and every payload word on `ip_payload`, one cycle later | `Idle` on the input payload `tlast`, or on the next `hdr_valid` |
| `Arp` | `hdr_valid` with `hdr_ethertype` = 0x0806 | the same on the `arp_*` ports | `Idle` on the input payload `tlast`, or on the next `hdr_valid` |
| `Drop` | `hdr_valid` with any other `hdr_ethertype` | emits nothing anywhere; pulses `error_unknown_ethertype` once, one cycle after entry | `Idle` on the input payload `tlast`, or on the next `hdr_valid` |

**Why "or on the next `hdr_valid`" is there and is not a hedge.** A frame with a
zero-octet payload has no `tlast` to end it (requirements.md §0.7), so a state
machine that left only on `tlast` would wait for a word that never comes. The
next `hdr_valid` ends it instead, and that is always safe: SPEC-M06 §6.1 shows
the next frame's header pulse arriving strictly after the previous frame's
payload `tlast` word, at every frame length, so a `hdr_valid` never arrives
mid-frame from a conformant producer. M08 needs no timeout and holds no counter.

An input cycle carrying no payload word holds every state: it is not a condition
and it advances nothing.

### 6.3 Deliberately unconstrained

Anything not listed here is constrained by this specification, and a test may
rely on it.

1. **The internal encoding of the routing register and the FSM state**, and
   whether the two output header records are driven from one register or two.
   §7's constant is what is fixed.
2. **The value of every field of an output port that is not carrying this
   frame** — the `arp_*` ports while an IPv4 frame is routed, and both ports
   while a frame is dropped — on cycles where its `valid` and `tvalid` are 0.
   SPEC-M01 §6.3 item 5 governs; no monitor may read them.
3. **M08's response to a `hdr_valid` pulse arriving mid-frame**, which §6.2 ends
   the current frame on. No conformant producer emits one (SPEC-M06 §6.1), no
   requirement names the case, and DV SHALL assert nothing about the state of
   the truncated frame's output.
4. **Whether the strobe is derived from the ethertype comparison directly or
   from the `Drop` state.** Both compute the same predicate; §9 pins the pulse
   cycle, which is what a bench needs.
5. **M08's behaviour when `hdr_valid` is pulsed on the same cycle as the frame's
   first payload word**, rather than one cycle before it. No conformant producer
   does it: M06 is M08's only producer and SPEC-M06 §7 pins `hdr_valid` exactly
   one cycle before that frame's first payload word, at every frame length. The
   case is unreachable rather than undefined, no requirement names it, and DV
   SHALL assert nothing about M08's output timing for it (carry-forward
   **C-17(c)**).

## 7. Timing contract

- **Latency.** Front offset **h = 0** octet times: M08 removes nothing from the
  front of the frame and its input is word-aligned, so both terms of §0.5's h
  are zero. The pinned per-octet constant is

  | Quantity | Value |
  |---|---|
  | L (octet times) | **8** |
  | h (octet times) | **0** |
  | Word delay ΔC = (L + h)/8 | **1** cycle |
  | §1.1 ceiling | **1** cycle |

  (L + h) = 8, a multiple of 8 as requirements.md §0.5 requires. This is the one
  module in §1.1's table where h = 0, so it is the one module for which
  ΔC = L/8 = floor(L/8) and the C-1 change of unit moves nothing
  (requirements.md §0.5, "Cycles").

  **The two measurement events**: the input event is the octet time, on the
  `payload` stream, of the octet being measured; the output event is the octet
  time of that same octet on the routed output stream. For the word delay the
  two events are the cycle of the input payload word carrying the frame's first
  octet and the cycle of the frame's first routed payload word.

  **The header record is delayed by the same one cycle**, which is what
  preserves M06's one-cycle lead at M08's output (§6.1). A specification that
  delayed the payload and forwarded the header combinationally would still meet
  REQ-401 downstream but would make the two ports disagree about what "one cycle
  before" means, and every module below would need to know which.

  M08 is pinned at its ceiling, and here that costs nothing: one cycle is the
  minimum a registered output can achieve and requirements.md §1.1 allocates
  exactly that. There is no cheaper conformant design and therefore nothing to
  hold in reserve.

- **Throughput.** One input word accepted every cycle, unconditionally and with
  no handshake (REQ-003). At most one output word per cycle, on exactly one of
  the two ports — the routed one — so the two output streams are never
  simultaneously active and the module can never be asked to emit two words at
  once. That is structural, not a bench assertion: a frame has one ethertype.

- **Handshake rules.** On the routed port, `tvalid` = 1 exactly on the cycles
  the input carried a word, one cycle later; `tkeep`, `tlast` and `tuser` are
  relayed unchanged, and `tkeep` is `0xFF` except on the `tlast` word. `tlast`'s
  word is included in the frame's word count (REQ-015); at most 188 words
  between successive `tlast` words. The routed `hdr_valid` is high for exactly
  one cycle per routed frame, on the cycle **before** that frame's first routed
  payload word, and its three field values are valid only on that cycle. A
  routed header with no payload frame is legal and every consumer SHALL tolerate
  it (requirements.md §0.7). On the port that is not routed, `valid` and
  `tvalid` are 0 for the whole frame.

  Idle gaps on the input (REQ-016) delay everything by exactly 8 octet times per
  cycle and change nothing else.

- **Reset.** While `clear` = 1 and on the first cycle after it returns to 0:
  both `payload_tvalid` outputs 0, both `hdr_valid` outputs 0,
  `error_unknown_ethertype` 0, state `Idle`. `clear` asserted mid-frame
  truncates the in-flight routed frame with no `tlast` and no strobe (REQ-009) —
  the one place in this specification where a frame vanishes without a strobe. A
  frame whose header pulse arrives on the first cycle after `clear` returns to 0
  is routed correctly.

- **Configuration sampling.** None; M08 reads no configuration (§4.3).

## 8. Line-rate stress obligation

**Mandatory: M08 is in requirements.md §0.4's stress-bench list.**

**Stimulus, derived by construction from the XGMII case and not re-invented**
(REQ-004's rule for a module that does not see XGMII). Drive M08 with exactly
what SPEC-M06 §8's stress run makes M06 emit:

- 10 000 consecutive frames, each a `hdr_valid` pulse followed on the next cycle
  by **6 payload words** — five with `tkeep` = 0xFF and one with `tkeep` = 0x3F
  and `tlast` = 1, carrying the **46 payload octets** a minimum-length Ethernet
  frame produces (REQ-408);
- header fields on every pulse: `dst_mac` = 0x020000000001,
  `src_mac` = 0x020000000002, `ethertype` = **0x0800**, so that every frame is
  one M08 accepts and forwards and REQ-004's "frames out equals frames in" is
  well defined (REQ-004's own clause for a module that legitimately discards);
- the first four payload octets carry the 32-bit frame sequence number, most
  significant octet first, which lands in `payload_tdata`[31:0] of payload word
  0 (REQ-020, SPEC-M06 §8);
- **frame period 10 and 11 cycles alternately** — the arrival pattern REQ-004
  fixes at the XGMII boundary, preserved through M03 and M06 unchanged. Of those
  cycles, one carries the header pulse, six carry payload words and the
  remaining 3 or 4 are idle. Idle gaps are preserved rather than closed up;
- `tuser`[0] = 0 on every `tlast` word. **Error injection rate: zero in this
  run** — REQ-404's unknown ethertype is a directed test, because REQ-004's
  conservation criterion is stated over frames the module accepts.

**Checks.**

1. 10 000 frames out on the IPv4 port for 10 000 in, 10 000 `ip_hdr_valid`
   pulses each exactly one cycle, and **zero** activity of any kind on the ARP
   port; no word dropped; frame conservation holds (requirements.md §0.6).
2. The 46 payload octets of every frame compare equal on the routed port, and
   the sequence numbers arrive as 0, 1, 2, … with no gap and no repeat
   (REQ-020).
3. Per-octet latency is constant and equals **8** octet times for every octet of
   all 10 000 frames (REQ-005, REQ-019) — one value, not a mean, converted to
   ΔC = (8 + 0)/8 = 1 against the §1.1 ceiling of 1 in the sign-off packet.
4. Every `ip_hdr_valid` pulse is exactly one cycle before its frame's first
   routed payload word, and carries the three fields of that frame unchanged.
5. `error_unknown_ethertype` never pulses during the run.
6. The module exposes no `tready` on any stream under test. This is structural
   (REQ-003, §4.1) — a statement about the type, not an assertion that could
   fail.

**A second stress run, with the routing alternating.** Repeat the run with the
ethertype alternating 0x0800 and 0x0806 frame by frame, and assert the same
five checks per port plus one more: no frame appears on both ports, and the
interleaving of the two output streams never puts a word of one frame between
two words of another. Routing a stream of identical frames exercises the
datapath; alternating exercises the register that steers it, and only the second
would catch a decision captured one cycle late.

**Directed tests alongside the stress run** (REQ-404): frames with ethertypes
0x0800, 0x0806, 0x8100 and 0x86DD, checking the routed port, the strobe and —
for the two unknown ethertypes — that no word appears on either output. Plus a
header record with no payload frame at each of the four ethertypes, checking
that the routed header appears alone and that an unknown one pulses the strobe
with nothing emitted.

## 9. Errors and discards

Strobe names are normative (requirements.md §12).

| Condition | Strobe (one cycle) | Stream effect | REQ |
|---|---|---|---|
| `hdr_ethertype` is neither 0x0800 nor 0x0806 — 0x8100 and 0x86DD included | `error_unknown_ethertype` | **no word and no header `valid` on either output port**; the frame is discarded before anything is emitted, and its payload words are accepted and dropped as they arrive | REQ-404, REQ-008 |

Silent discard is prohibited (REQ-008): the one row has a strobe. The `clear`
mid-frame case of §7 is REQ-009's, not REQ-008's.

**Strobe cycle, pinned.** `error_unknown_ethertype` pulses for exactly one
cycle, on the cycle **one after the input `hdr_valid` pulse** — the cycle on
which the routed header would have been emitted, the earliest a registered
output can report a condition decidable on the pulse cycle. It is computable
from the input trace alone and lies inside requirements.md §0.6's window. In
particular the strobe pulses **before** the frame's payload words have all
arrived, which is legal (§0.6 bounds the pulse from above, not from below) and
is the observable form of "the discard is clean".

**Which conditions can co-occur on one frame, and what then pulses.**

- **`error_unknown_ethertype` with an inherited `tuser`[0] = 1**: the strobe
  pulses once and nothing is emitted. requirements.md §0.6's local-discard rule
  says the local discard wins over the inherited abort, and its second half says
  M08 SHALL NOT pulse anything to re-report the abort it merely inherited. A
  bench that injects a bad-FCS frame with ethertype 0x86DD SHALL see exactly one
  strobe — this one — and no other.
- **`error_unknown_ethertype` with itself**: one pulse per frame. M08 evaluates
  its one condition once, on the header pulse.
- There is no other pair: M08 detects exactly one condition.

**Abort relay.** For every routed frame, `tuser`[0] on the input payload's
`tlast` word appears on the routed port's `tlast` word (REQ-007, REQ-403's
pattern one module later). M08 never sets that bit for a reason of its own,
never clears it, and never pulses a strobe because of it.

## 10. REQ coverage

| REQ | How this module satisfies it | Section | Verification hook for DV |
|---|---|---|---|
| REQ-003 | three `Axi64.Source` ports, no `Dest`, no `tready` field anywhere | §4.1 | interface compile check |
| REQ-004 | sustains M06's output pattern for 10 000 frames, in both the single-port and the alternating run | §8 | line-rate stress bench |
| REQ-005 | one register level; nothing withheld; per-octet latency constant | §6.1, §7 | per-octet latency tagger inside the stress bench |
| REQ-007 | inherited `tuser`[0] relayed on the routed `tlast` word | §9 | bad-FCS frame injected at M03, observed on M08's routed port |
| REQ-008 | one condition, one strobe, pulse cycle pinned | §9 | directed test plus the frame-conservation monitor |
| REQ-009 | `clear` empties the register; mid-frame `clear` truncates silently | §7 | reset test: assert mid-frame, deassert, drive a frame on the next cycle |
| REQ-011 | `tkeep` relayed unchanged, `0xFF` except on `tlast` | §7 | protocol monitor on all three streams |
| REQ-012, REQ-409 | the ethertype is compared as a numeric value; octet positions are relayed unrotated | §6.1 | known-frame directed test |
| REQ-014 | `tstrb` ignored in, driven 0 out | §4.2 | protocol monitor; REQ-014's differential run |
| REQ-015 | one `tlast` per routed frame; at most 188 words | §7 | protocol monitor |
| REQ-016 | idle in, idle out; §6.1's cycle formulas are gapless-only | §6.1, §7 | idle-injection wrapper at 0, 1 and 7 cycles, asserting the per-octet constant |
| REQ-019 | ΔC = 1 against a ceiling of 1; one word of storage | §7 | ΔC from the pinned L and h at freeze; measured ΔC from the stress run in the sign-off packet |
| REQ-020 | one frame at a time; order not expressible otherwise | §6.2 | sequence numbers in both stress runs |
| REQ-021 | strips nothing, realigns nothing, h = 0 | §3, §7 | the per-octet comparison: input and output octet positions are equal |
| REQ-404 | 0x0800 to the IPv4 port, 0x0806 to the ARP port, everything else discarded with one strobe; decided from the header record before any payload word | §6.1, §9 | directed frames at 0x0800, 0x0806, 0x8100 and 0x86DD; check routing, the strobe, and that a discarded frame puts no word on either port |
| REQ-401 | not owned, but **relied on**: M06's one-cycle header lead is what makes the decision available in time, and M08 reproduces the same lead at its output | §6.1, §7 | assert, on both stress runs, that every routed header pulse is exactly one cycle before its frame's first routed payload word |
| REQ-407 | `dst_mac` is relayed and compared against nothing | §4.2 | frame with a foreign destination MAC routed normally |
| REQ-802, REQ-810 | no instance: M08 reads no configuration | §4.3 | none — stated so that no sign-off packet claims coverage here |
| REQ-903, REQ-808 | `eth_demux` is a distinct emitted module with `create`, `hierarchical` and an `.mli` | §4.1 | repository surface check and the `rtl_snapshots/` name comparison |

This table is the source of M08's rows in [`traceability.md`](../traceability.md),
updated in the same commit.

## 11. Deferred items

Item numbers are permanent; a closed item keeps its row (SPEC-TEMPLATE §11).

| # | Item | Status · what a reader assumes meanwhile | Tracked as | Owner | Closes by |
|---|---|---|---|---|---|
| 11.1 | **The `ifc_check` compile evidence for this lift is pending**: `eth_demux_ifc.ml` is new in this commit. | **CLOSED (WO-0014).** CI `build` run **30733153172** at f457efc reports `success` with this lift in it, and `git diff 508eea2 f457efc -- docs/specs/ifc_check/` is empty, so the run witnesses the record frozen here. | the `Interface compile check` row of §12 | architect_docs_lead, rtl_lead | closed |
| 11.2 | **M08's discard has no downstream observable other than its strobe.** A frame dropped here never reaches M14 or M10, so the only evidence it existed is `error_unknown_ethertype` and the §0.6 conservation equation — and at `nic_top` the equation's input term is an XGMII frame count, not a stream count. | **CLOSED (WO-0019).** A reader runs §8's directed tests at M08's own ports, where both terms of the equation are observable — that half never moved. The top-level form, carry-forward **C-3**, is answered once for every discard on the chain by SPEC-M20 §9's top-level conservation equation, which counts XGMII frames in against application payload frames out **plus** header-record pulses with no payload frame **plus** the twenty-one status pulses, and which names the ARP fork and the zero-payload cases as its two non-obvious terms. C-3 itself stays on the ledger until its own gate — the top-level stress bench — because the equation still has to be *run*; what closes here is M08's dependency on it, which was only ever "somebody must state the top-level form". | ledger **C-3**; SPEC-M20 §9 | architect_docs_lead, dv_lead | closed |
| 11.3 | **§6.1 claimed M08 tolerates a producer whose `hdr_valid` pulses on the same cycle as the first payload word, and stated no output timing for that case**, while §6.3's opening sentence declares everything not on its list constrained by this specification. | **CLOSED (WO-0014).** The claim is withdrawn from §6.1 and the case is recorded as unreachable in §6.3 item 5, worded as SPEC-M07 §6.3 item 3 and SPEC-M09 §6.3 item 4 word theirs: M06 is M08's only producer, its one-cycle lead is pinned at every frame length, and DV asserts nothing about M08's output timing for a lead of zero. | ledger **C-17** (item (c)) | architect_docs_lead | closed |

## 12. Freeze record

Filled in at `P1-spec-freeze`. All four rows are required (charter §5).

| Item | Value |
|---|---|
| Interface compile check | CI `build` run **30733153172**, conclusion **`success`**, SHA **f457efc** — all nine batch-A/B/C lifts elaborate, this one included; per ADR-0005 a local build is not acceptable evidence. `git diff 508eea2 f457efc -- docs/specs/ifc_check/` is empty, so the run witnesses the record frozen at 508eea2 |
| Architect signature | `J-architect_docs_lead-0005` |
| dv_lead testability countersignature | `J-dv_lead-0007` (WO-0013) — **SIGNED**, batch C, "the cleanest of the four", with C-17(c) raised and now closed in §13 |
| Frozen at | SHA **508eea2**, gate `docs/gates/P1-spec-freeze-checklist.md` |

## 13. Change log

Post-freeze changes only. Each row cites the ADR that authorised it; a breaking
interface change is counted against post-freeze churn (charter §6). **No row
below is breaking**: §4.1's record is byte-for-byte unchanged since the freeze
SHA, so the `ifc_check` evidence of §12 still witnesses this revision's
interface.

| Date | Change | Breaking? | ADR | Journal |
|---|---|---|---|---|
| 2026-08-02 | §6.1's "M08 tolerates that too" claim about a zero-lead producer withdrawn and restated as an unreachable case in §6.3 item 5 (ledger **C-17(c)**) | no | none — the case was never reachable; the sentence claimed a behaviour and specified none, which §6.3's opening sentence made into a constraint by default | `J-architect_docs_lead-0006` |
