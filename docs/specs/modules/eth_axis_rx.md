# SPEC-M06 — `Eth_axis_rx`

- **Status**: **FROZEN** (`P1-spec-freeze`, SHA `508eea2`) — batch C, dv_lead
  countersignature `J-dv_lead-0007`. Changes to §4, §6 or §7 after this point
  are spec diffs recorded in §13 (SPEC-TEMPLATE rule 7)
- **Inventory id**: M06 (architecture.md §4) · **Path**:
  `libs/hardcaml_ethernet/src/eth_axis_rx.ml`
- **Datapath role**: receive
- **Owns REQs**: REQ-401, REQ-402, REQ-403, REQ-407, REQ-408, REQ-409, REQ-410
- **Prior-art counterpart**: `eth_axis_rx.v` (MIT) — consulted for decomposition
  and port naming only; behaviour below is stated independently and no source
  was copied
- **Depends on specs**: SPEC-M01 (`Axi64`, `Eth_header`), SPEC-M03
  (`Xgmii_rx_64`, the stream this module consumes)
- **Author**: architect_docs_lead, journal `J-architect_docs_lead-0005`

## 1. Purpose

M06 turns a frame stream into an Ethernet **header record** plus a **payload
stream**: it captures the fourteen header octets, presents them as decoded
numeric fields, and re-emits everything after the ethertype word-aligned on its
own stream. It exists as a separate module because it is the first place in the
receive chain where a frame stops being an octet string and starts being a
protocol object, and because the 14-octet header is not a multiple of eight —
the realignment REQ-021 demands has to live somewhere, and this is the first of
the three places it does (M06 strips 14, M14 strips 20, M17 strips 8).

Its upstream is M03 `Xgmii_rx_64` (through the M05 and M16/M19 wrappers); its
downstream is M08 `Eth_demux`. It instantiates nothing.

## 2. Scope

**In scope.**

- Capturing destination MAC, source MAC and ethertype into an `Eth_header`
  record with decoded numeric fields, and pulsing its `valid` exactly once per
  frame (REQ-401, REQ-409, REQ-012).
- Emitting every octet after the ethertype as a payload stream, **including any
  Ethernet padding** (REQ-408).
- Realigning that payload so its first octet is at `tdata`[7:0] of the payload
  stream's first word (REQ-021), at every frame length.
- Detecting a frame shorter than the header and reporting it (REQ-402).
- Carrying an inherited abort through to the payload stream's `tlast` word
  (REQ-403, REQ-007).
- Accepting a new frame on the cycle after the previous frame's `tlast`
  (REQ-410), with constant per-octet latency throughout (REQ-005, §7).

**Not this module's job.**

| Behaviour a reader might expect here | Owner |
|---|---|
| Filtering on destination MAC | **nobody** — the receive path is deliberately promiscuous (REQ-407). M06 reads `dst_mac` into the record and compares it against nothing |
| Deciding what the ethertype means, or routing on it | M08 `Eth_demux` (REQ-404). M06 presents the number and never looks at its value |
| Removing the Ethernet padding it forwards | M14 `Ip_eth_rx_64` (REQ-605), which is the layer that knows the datagram's real length |
| The FCS, the abort bit's origin, runts, oversize frames | M03 `Xgmii_rx_64` (REQ-103 … REQ-110). M06 sees a frame stream that has already had its FCS removed and its aborts marked |
| Enabling or disabling reception (`cfg_rx_enable`) | M03 (REQ-810). M06 reads no configuration at all (§4.3) |
| Building a frame from a header record — the reverse direction | M07 `Eth_axis_tx` (REQ-405). The two share the `Eth_header` record and nothing else, and the record's `valid` has a **different discipline** on the transmit side (ADR-0008) |
| Any encoding of a zero-octet payload | nobody: it has none (REQ-011). A 14-octet frame is reported by its header `valid` pulse alone, which is requirements.md §0.7's pattern and not a local invention |

## 3. Programme invariants that bind this module

M06 is a receive-path module under requirements.md §0.4 — the second link of
the chain — and both its input stream and its output payload stream are
receive-path streams.

| REQ | Consequence for M06 |
|---|---|
| REQ-001 | One `clock`. Every register in §7's pipeline is synchronous to it. |
| REQ-002 | Input and payload output are 64-bit `Axi64` streams, at most one word per cycle each. |
| REQ-003 | The payload output is `Axi64.Source` **without** `Axi64.Dest`, and the input carries no `tready`: M08 cannot stall M06 and M06 cannot stall M03, structurally (§4.1). |
| REQ-004 | M06 is on requirements.md §0.4's stress-bench list. Its stimulus is the stream M03 produces under REQ-004's arrival pattern, derived by construction and never re-invented (§8). |
| REQ-005 | Cut-through: no payload word is withheld to the end of its frame. The per-octet latency is the single constant **L = 10 octet times** of §7, at every frame length and content. |
| REQ-007 | An abort inherited on the input `tlast` word is carried to the payload stream's own `tlast` word (§9). M06 originates no abort of its own. |
| REQ-008 | M06's one discard condition — a frame shorter than the header — has a strobe (§9). It owns one of the twenty-one (requirements.md §12). |
| REQ-009 | Synchronous `clear`. On every cycle `clear` = 1 and on the first cycle it is 0: `payload_tvalid` = 0, `hdr_valid` = 0, `error_short_frame` = 0. A frame in flight is truncated with no `tlast` and no strobe; a frame whose first word arrives on the first cycle after `clear` returns to 0 is received correctly (§7). |
| REQ-010 | Both streams are the programme `Axi64.Source`; the header is SPEC-M01's `Eth_header`. M06 declares no record of its own (§4.1). |
| REQ-011 | `payload_tkeep` is `0xFF` on every payload word except the `tlast` word, where it is 1 to 8 contiguous ones from bit 0. |
| REQ-012 | Input octet position k is `tdata`[8k+7:8k], the first frame octet at k = 0; the header fields are presented as numeric values with network byte order already decoded (§6.1). |
| REQ-013 | `tuser`[0] is read on the input `tlast` word and written on the payload `tlast` word. M06 never drops a frame because of it (REQ-403). |
| REQ-014 | `tstrb` is ignored on the input and driven to 0 on the payload output. |
| REQ-015 | One `tlast` per payload frame, the `tlast` word included in the count; at most **188** words between two `tlast` words on the payload stream (1500 octets — 1514 input octets less the 14-octet header — is 187 full words and a final four-octet word), at least one. |
| REQ-016 | The input may carry idle cycles inside a frame and M06 tolerates them: k idle cycles before an input word delay every octet that word carries by exactly 8k octet times and change nothing else (§7). M06 inserts idle cycles inside a frame only where the input carried them or where stripping the header consumed a whole word. |
| REQ-017, REQ-018 | No instance: M06 sees no lane, no control character and nothing below XGMII. |
| REQ-019 | Word delay ΔC = (L + h)/8 = (10 + 14)/8 = **3** cycles against a ceiling of **3** (requirements.md §1.1) — M06 is pinned exactly at its allocation, which §7 states as a decision rather than leaving to be discovered. Payload storage is **two** datapath words: payload octets 0–7 span two input words, and that is the whole reason the depth is two rather than one (REQ-019 permits two). |
| REQ-020 | Frames leave in the order they arrived; M06 holds one frame's header at a time (§6.2), so reordering is not expressible. |
| REQ-021 | **The realignment obligation, first instance.** M06 strips 14 octets, which is not a multiple of 8, so the payload's first octet is at input octet position 6 of input word 1 and must be emitted at `tdata`[7:0] of payload word 0. Every payload word is assembled from two input words (§6.1). |

## 4. Interface

### 4.1 Interface records

```ocaml
(* SPEC-M06 §4.1, lifted verbatim into docs/specs/ifc_check/eth_axis_rx_ifc.ml
   (SPEC-TEMPLATE.md rule 6). Records and signatures only — no logic, no
   implementation.

   [Axi64_ifc] is M01's types home (SPEC-M01 §4.1): [Axi64] and
   [Eth_header] come from there and are restated nowhere. This is the
   first specification to use [Eth_header], and it uses it unchanged —
   the record was frozen at f78766e and batch C adds no field to it.

   Receive-path module: [rx] and [payload] are [Axi64.Source] and there
   is no [Axi64.Dest] anywhere in either record, which is REQ-003
   structurally. The [Eth_header] carries a [valid] and no [ready] for
   the same reason: on this path nothing may stall its producer. *)

open! Base
open Hardcaml
open! Axi64_ifc

module I = struct
  type 'a t =
    { clock : 'a
    ; clear : 'a
    ; rx : 'a Axi64.Source.t [@rtlprefix "rx_"]
    }
  [@@deriving hardcaml]
end

module O = struct
  type 'a t =
    { hdr : 'a Eth_header.t [@rtlprefix "hdr_"]
    ; payload : 'a Axi64.Source.t [@rtlprefix "payload_"]
    ; error_short_frame : 'a
    }
  [@@deriving hardcaml]
end

module type S = sig
  val create : Scope.t -> Signal.t I.t -> Signal.t O.t
  val hierarchical : ?instance:string -> Scope.t -> Signal.t I.t -> Signal.t O.t
end

(* REQ-010 type identity at both stream ports, and the first compile-time
   witness that [Eth_header]'s field names are what SPEC-M01 §4.2 writes. *)

let _witness_streams_are_the_programme_type
      (x : Signal.t Axi64.Source.t)
      (y : Signal.t Axi64.Source.t)
  =
  x, y
;;

let _witness_eth_header_field_names (h : Signal.t Eth_header.t) =
  let open Eth_header in
  [ h.valid; h.dst_mac; h.src_mac; h.ethertype ]
;;
```

Conformance of this block to the template's rules for §4.1:

- Scalar fields carry `[@bits n]` unless one bit wide: `clock`, `clear` and
  `error_short_frame` are one bit; every other field is inside a nested record
  carrying its own widths (SPEC-M01 §4.1).
- Nested interfaces carry `[@rtlprefix]`: `rx` emits `rx_tvalid` … `rx_tuser`,
  `payload` emits `payload_tvalid` … `payload_tuser`, and `hdr` emits
  `hdr_valid`, `hdr_dst_mac`, `hdr_src_mac`, `hdr_ethertype`.
- **Receive-path `Source` without `Dest`: held.** Neither record contains an
  `Axi64.Dest` and neither contains a `tready` field. An M06 that wanted
  backpressure could not be written without changing this record, which is a
  spec diff — REQ-003.
- Both `create` and `hierarchical` are declared (REQ-903, REQ-808).

### 4.2 Port table

Every port in §4.1 appears exactly once.

| Port | Dir | Width | Meaning | REQ |
|---|---|---|---|---|
| `clock` | in | 1 | 156.25 MHz single domain | REQ-001 |
| `clear` | in | 1 | synchronous clear | REQ-009 |
| `rx_tvalid` | in | 1 | this cycle carries a word of the frame M03 delivered | REQ-016 |
| `rx_tdata` | in | 64 | frame octets, first destination-address octet at position 0 | REQ-012 |
| `rx_tkeep` | in | 8 | valid octet positions, contiguous from bit 0 | REQ-011 |
| `rx_tstrb` | in | 8 | reserved; ignored | REQ-014 |
| `rx_tlast` | in | 1 | this word carries the frame's final octets | REQ-015 |
| `rx_tuser` | in | 1 | bit 0: the frame was found invalid upstream; read only on the `tlast` word | REQ-013, REQ-403 |
| `hdr_valid` | out | 1 | one cycle high per frame of at least 14 octets; the other three fields are that frame's header | REQ-401 |
| `hdr_dst_mac` | out | 48 | destination MAC as a numeric value, first wire octet most significant | REQ-409, REQ-012 |
| `hdr_src_mac` | out | 48 | source MAC, same encoding | REQ-409, REQ-012 |
| `hdr_ethertype` | out | 16 | ethertype as a numeric value; 0x0800 reads as 0x0800 | REQ-409, REQ-404 |
| `payload_tvalid` | out | 1 | this cycle carries a payload word | REQ-016 |
| `payload_tdata` | out | 64 | payload octets, the first octet after the ethertype at position 0 | REQ-021, REQ-408 |
| `payload_tkeep` | out | 8 | valid octet positions, contiguous from bit 0 | REQ-011 |
| `payload_tstrb` | out | 8 | reserved; driven to 0 | REQ-014 |
| `payload_tlast` | out | 1 | this word carries the payload's final octets | REQ-015 |
| `payload_tuser` | out | 1 | bit 0: inherited abort, meaningful only on the `tlast` word | REQ-403, REQ-007 |
| `error_short_frame` | out | 1 | one-cycle strobe: the frame carried fewer than 14 octets | REQ-402 |

### 4.3 Configuration inputs

**None.** M06 reads no field of the `Config` record, and that is a consequence
of two requirements rather than an omission: REQ-407 forbids Ethernet-layer
address filtering, so `local_mac` has no use here, and REQ-810's receive half is
implemented in M03 (SPEC-M03 §4.3), so `rx_enable` never reaches this module.
REQ-803 therefore has no instance at M06 — there is no configuration input whose
change could land inside a frame.

## 5. Parameters

**None.** M06 has no timeout, no ageing interval and no retry, so REQ-506's rule
has no instance. The one numeric constant it contains, 14, is the Ethernet II
header length fixed by REQ-401 and REQ-408; making it overridable would let a
test configure a frame format the programme does not have.

| Parameter | Type | Default | Range | Why a test overrides it |
|---|---|---|---|---|
| (none) | — | — | — | — |

## 6. Behaviour

### 6.1 Normal path

**The header M06 reads**, with the octet offsets and widths a test writer needs
to build stimulus without a protocol reference open. Offsets are from the first
destination-address octet, which is octet 0 of the input stream (REQ-103 makes
M03's output start there).

| Field | Octet offset | Width | Header-record field | Encoding |
|---|---|---|---|---|
| destination MAC | 0–5 | 48 bits | `hdr_dst_mac` | numeric, first wire octet most significant: 00:11:22:33:44:55 reads 0x001122334455 (REQ-012) |
| source MAC | 6–11 | 48 bits | `hdr_src_mac` | same |
| ethertype | 12–13 | 16 bits | `hdr_ethertype` | numeric: 0x0800 reads 0x0800 |

Everything from octet 14 to the frame's last octet is payload (REQ-408),
Ethernet padding included; M06 does not know a datagram's real length and never
looks.

**Where the fields lie in the input words.** Input word 0 carries octets 0–7 —
the whole destination MAC and the first two source-MAC octets. Input word 1
carries octets 8–15 — the remaining four source-MAC octets, both ethertype
octets at positions 4 and 5, and **payload octets 0 and 1** at positions 6 and
7. The header is therefore complete at input word 1, and the payload's first
octet lies in the same word: that overlap is the realignment, and it is why the
module needs two words of payload storage and not one.

**Emitting the payload (REQ-021, REQ-408).** Payload octet j is emitted at
`tdata` position j mod 8 of payload word ⌊j / 8⌋, so payload octet 0 is at
`payload_tdata`[7:0] of payload word 0 at every frame length. Payload word m is
assembled from input words m + 1 and m + 2: positions 0 and 1 from input word
m + 1 positions 6 and 7, positions 2 to 7 from input word m + 2 positions 0 to
5. The last payload word takes only the octets that exist, and `payload_tkeep`
marks exactly them.

**On a gapless stimulus**, with Ci the cycle of the input word carrying the
frame's first octet:

- `hdr_valid` pulses on cycle **Ci + 2** — one cycle after the input word that
  completes the ethertype, and one cycle before the frame's first payload word;
- payload word m is emitted on cycle **Ci + 3 + m**.

The gapless qualifier is §0.5's own and is load-bearing (the same reading
carry-forward C-14.4 fixed in SPEC-M03 §6.1): an input word covering no octet of
this frame — an idle cycle under REQ-016, which §10 commissions against this
module at 0, 1 and 7 cycles — **holds** the frame and advances nothing, delaying
every later octet by exactly 8 octet times per cycle. The **per-octet** constant
of §7 holds on every stimulus, gapped or not; the cycle formulas above hold only
on the gapless one, and a bench asserting them under idle injection would fail a
conformant design.

**Cycle by cycle, the frame a minimum-length Ethernet frame produces.** M03
delivers 60 octets for a 64-octet frame (four FCS octets stripped, REQ-103), so
the input is 8 words — seven full and one carrying four octets — and the payload
is **46 octets** (REQ-408's worked figure), 6 words.

| Cycle | Input word | Output |
|---|---|---|
| Ci | word 0: octets 0–7 (destination MAC, source MAC[0:1]) | `hdr_valid` = 0, `payload_tvalid` = 0 |
| Ci+1 | word 1: octets 8–15 (source MAC[2:5], ethertype, payload 0–1) | `hdr_valid` = 0, `payload_tvalid` = 0 |
| Ci+2 | word 2: octets 16–23 | **`hdr_valid` = 1**, all three fields; `payload_tvalid` = 0 |
| Ci+3 | word 3: octets 24–31 | payload word 0: payload octets 0–7, `tkeep` = 0xFF |
| Ci+4 … Ci+7 | words 4–7; word 7 carries octets 56–59 with `tkeep` = 0x0F and `tlast` = 1 | payload words 1–4: payload octets 8–39 |
| Ci+8 | idle | payload word 5: payload octets 40–45, `tkeep` = 0x3F, `tlast` = 1, `tuser`[0] = the input `tlast` word's `tuser`[0] |
| Ci+9 onward | idle | `payload_tvalid` = 0 |

**A short frame's last word is not emitted early, and that is REQ-005 not
pedantry.** A 15-octet frame has one payload octet, which lies in input word 1
at position 6; that word arrives at Ci + 1. The payload word carrying it is
nevertheless emitted at Ci + 3, because payload octet 0's input octet time is
8·Ci + 14 and constant latency fixes its output octet time at 8·Ci + 24, which
is position 0 of cycle Ci + 3. An implementation that emitted it at Ci + 2
because it happened to have all the octets would have length-dependent latency
and would fail REQ-005's per-octet tagger.

**The abort bit is always available in time (REQ-403).** For an input frame of N
octets the input has K = ⌈N / 8⌉ words and the payload has M = ⌈(N − 14) / 8⌉
words, and stripping fourteen octets removes one or two words, so M is K − 1 or
K − 2. The input `tlast` arrives at Ci + K − 1 and the payload `tlast` word
leaves at Ci + M + 2 ≥ Ci + K, at least one cycle later. M06 therefore never has
to guess the abort bit, at any frame length.

**Back-to-back frames (REQ-410).** The next frame's first input word may arrive
on cycle Ci + K, the cycle immediately after the previous frame's `tlast`, and
is received correctly: its payload word 0 leaves at Ci + K + 3, while the
previous frame's last payload word left at Ci + M + 2, and M + 2 ≤ K + 1 < K + 3
at every frame length. The output is never asked to carry two words on one cycle
— which is structural rather than lucky, because M06 emits **fewer** words than
it consumes for every frame.

*The inequality that matters here is the one just used, and it is not the one
the abort paragraph uses* (carry-forward **C-17(a)**, dv_lead). From M = K − 1
for N ≡ 0 or 7 (mod 8) and M = K − 2 otherwise, M + 2 is K + 1 or K: so
M + 2 **≥** K always — which is what the abort argument above needs — and
M + 2 ≤ K + 1, which is what this argument needs. An earlier revision of this
paragraph wrote "M + 2 ≤ K", which is true only at the equality case and false
for every input frame whose length is a multiple of 8, the 64-octet stress frame
included; a REQ-410 bench asserting that the previous frame's payload completes
before the next frame's first input word arrives would fail a conformant design
on the very stimulus §8 drives. The conclusion is unaffected: the previous
frame's last payload word leaves at least two cycles before the next frame's
first payload word.

**When the frame is shorter than the header (REQ-402).** A frame of 1 to 13
octets — one input word, or two where `tkeep` on the `tlast` word marks fewer
than six octets — produces no `hdr_valid`, no payload word and a single
`error_short_frame` pulse (§9). A frame of exactly 14 octets is **not** an
error: the header is complete, `hdr_valid` pulses normally, and no payload frame
is emitted because a zero-octet payload has no encoding (requirements.md §0.7,
REQ-011). Downstream modules tolerate a header with no payload frame; that is
§0.7's obligation on them, restated in §7's handshake rules.

### 6.2 State machine

Reset state and `clear` state are both `Idle`. **The state machine advances on
the input side**; the output is the fixed-delay pipeline of §7 running behind
it. That separation is what makes REQ-410 hold: M06 returns to `Idle` on the
input `tlast` cycle and may begin a new frame on the very next cycle while the
previous frame's last payload word is still in flight.

| State | Entered when | Does | Leaves to |
|---|---|---|---|
| `Idle` | reset; `clear`; the input `tlast` of the previous frame | ignores the input; `payload_tvalid` = 0, `hdr_valid` = 0 | `Header` on the first input word with `tvalid` = 1 |
| `Header` | the frame's first input word | captures octets 0–7 into `dst_mac` and `src_mac`[47:32]; on the next input word captures `src_mac`[31:0] and `ethertype`, and pulses `hdr_valid` one cycle after it | `Payload` after the input word carrying octet 13; `Idle` if that frame's `tlast` arrives with fewer than 14 octets accumulated (REQ-402, one `error_short_frame`) |
| `Payload` | the ethertype is complete | forwards every remaining octet at the fixed delay of §7, realigned; marks `payload_tlast` and copies the inherited `tuser`[0] onto it | `Idle` on the input `tlast` — the state leaves immediately, and the pipeline drains behind it |

An input word covering no octet of the current frame (an idle cycle, REQ-016)
holds every state and every register: it is not a condition and it advances
nothing (§6.1).

### 6.3 Deliberately unconstrained

Anything not listed here is constrained by this specification, and a test may
rely on it.

1. **The placement of the two register levels** inside the three-cycle pipeline,
   and every internal encoding: the FSM state encoding, how the 14-octet
   realignment shift is built, whether the header is captured into one register
   or three. §7's constants are what is fixed.
2. **The value of the three header fields on cycles where `hdr_valid` = 0**, and
   the value of `payload_tdata` at positions where `payload_tkeep` is 0, and
   every output field on a cycle with `payload_tvalid` = 0 (SPEC-M01 §6.3 item
   5). No monitor may read them.
3. **M06's response to an input that violates REQ-011 or REQ-015** — a word with
   `tvalid` = 1 and `tkeep` = 0, a `tlast` with no preceding word, a `tkeep`
   that is not contiguous. Its producer is M03, which cannot emit any of them
   (SPEC-M03 §7), so no requirement names the case and DV SHALL assert nothing
   about it. Constraining it would commission a test for a stimulus the
   programme has decided not to produce.
4. **Whether `error_short_frame` is derived from a running octet count or from
   the `tkeep` of the `tlast` word.** Both compute the same predicate and
   neither is observable; §9 pins the pulse cycle, which is what a bench needs.

## 7. Timing contract

- **Latency.** Front offset **h = 14** octet times: M06 removes fourteen octets
  from the front of the frame and its input is word-aligned, so §0.5's second
  term is 0 and h is exactly the header length. The pinned per-octet constant is

  | Quantity | Value |
  |---|---|
  | L (octet times) | **10** |
  | h (octet times) | **14** |
  | Word delay ΔC = (L + h)/8 | **3** cycles |
  | §1.1 ceiling | **3** cycles |

  (L + h) = 24, a multiple of 8 as requirements.md §0.5 requires. There is one
  constant and not two: M06 sees no XGMII, so §0.5's start-lane pair has no
  instance here and L is a single value.

  **The two measurement events**, named explicitly: the input event is the
  octet time, on the `rx` stream, of the octet being measured; the output event
  is the octet time of that same octet on the `payload` stream. For the word
  delay the two events are the cycle of the input word carrying the frame's
  **first octet** and the cycle of the frame's **first payload word** — the
  previous stage's output word and this stage's, which is what makes ΔC additive
  along the chain (§0.5).

  **M06 is pinned exactly at its §1.1 ceiling, and that is a decision.** Three
  cycles is the smallest word delay an implementation with a registered output
  can reach here: payload octets 0–7 span input words 1 and 2, input word 2
  arrives at Ci + 2, and a registered output emits at Ci + 3. Spending a fourth
  cycle would be legal only as a **slack release** — an explicit spec diff
  against the seven cycles requirements.md §1.1 reserves, changing both copies
  of the allocation table — and never as a local implementation decision. This
  is the module dv_lead named at WO-0010 as one of the two it would spend slack
  on; the slack is not spent.

- **Throughput.** One input word accepted every cycle, unconditionally and with
  no handshake (REQ-003). At most one payload word emitted per cycle, and never
  more than one per input word: M06 removes fourteen octets and therefore emits
  one or two **fewer** words than it consumes for every frame, which is why no
  backpressure is needed anywhere and why REQ-410's back-to-back case cannot
  collide at the output.

- **Handshake rules.** `payload_tvalid` = 1 exactly on cycles carrying payload
  octets. `payload_tkeep` is `0xFF` except on the `tlast` word, where it is 1 to
  8 contiguous ones. `payload_tlast` = 1 on the word carrying the payload's last
  octet, that word included in the frame's word count (REQ-015); a one-word
  payload frame is legal and is the mandatory encoding of a payload of 1 to 8
  octets. At most 188 words between successive `payload_tlast` words.
  `payload_tuser`[0] is meaningful only on the `tlast` word.

  `hdr_valid` is high for **exactly one cycle per frame** of at least 14 octets,
  on the cycle **before** that frame's first payload word — which satisfies
  REQ-401's "on or before" with one cycle to spare and gives M08 a whole cycle
  to make its routing decision (SPEC-M08 §6.1). For a frame of exactly 14 octets
  `hdr_valid` pulses on the same cycle it would have anyway, one cycle after the
  input `tlast`, and **no payload frame follows**: every consumer of this record
  SHALL tolerate a header with no payload frame (requirements.md §0.7). The three
  field values are valid only on the pulse cycle (§6.3 item 2).

  Idle gaps on the input (REQ-016) delay everything by exactly 8 octet times per
  cycle and change nothing else.

- **Reset.** While `clear` = 1 and on the first cycle after it returns to 0:
  `payload_tvalid` = 0, `hdr_valid` = 0, `error_short_frame` = 0, state `Idle`,
  the captured header fields irrelevant because the next frame overwrites them.
  `clear` asserted mid-frame truncates the in-flight payload frame with no
  `tlast` and no strobe (REQ-009) — the one place in this specification where a
  frame vanishes without a strobe, permitted by REQ-009 and not by REQ-008. A
  frame whose first word arrives on the first cycle after `clear` returns to 0
  is received correctly.

- **Configuration sampling.** None; M06 reads no configuration (§4.3).

## 8. Line-rate stress obligation

**Mandatory: M06 is in requirements.md §0.4's stress-bench list.**

**Stimulus, derived by construction from the XGMII case and not re-invented**
(REQ-004's own rule for a module that does not see XGMII). Drive M06's `rx`
stream with exactly what SPEC-M03 §8's stress run makes M03 emit:

- 10 000 consecutive frames, each **60 octets** — the 64-octet frame of
  SPEC-M03 §8 with its four FCS octets removed (REQ-103) — presented as **8
  words**, seven with `tkeep` = 0xFF and one with `tkeep` = 0x0F and `tlast` = 1;
- the eight words of a frame occupy **consecutive cycles**: M03 emits output
  word m at cycle m + 3 from its start word, so its output carries no gap inside
  a frame at either start lane;
- **between frames, 2 and 3 idle cycles alternately**, because M03's start
  characters alternate lane 0 and lane 4 at 10 and 11 cycles apart (REQ-004,
  requirements.md §0.3) and eight of those cycles carry words. Idle gaps are
  preserved rather than closed up: that alternation is the stimulus, and a bench
  that packs the words back-to-back is testing a rate the receive path never
  sees;
- frame contents exactly as SPEC-M03 §8's table gives them, minus the FCS:
  destination MAC `02:00:00:00:00:01`, source MAC `02:00:00:00:00:02`, ethertype
  0x0800, a 32-bit frame sequence number at octets 14–17 with its most
  significant octet first (REQ-020), 42 octets of fixed filler at 18–59;
- `tuser`[0] = 0 on every `tlast` word. **Error injection rate: zero in this
  run** — REQ-402's short frame and REQ-403's abort are directed tests, because
  REQ-004's conservation criterion is stated over frames the module accepts.

Note for the bench writer: the sequence number at frame octets 14–17 is
**payload octets 0–3**, so it lands in `payload_tdata`[31:0] of payload word 0.
That is not a coincidence — it is the realignment REQ-021 commissions, and it
makes the sequence check readable.

**Checks.**

1. 10 000 payload frames out for 10 000 frames in, 10 000 `hdr_valid` pulses,
   each exactly one cycle; no word dropped; frame conservation holds
   (requirements.md §0.6).
2. The 46 delivered payload octets of every frame compare equal to input octets
   14–59, and the sequence numbers arrive as 0, 1, 2, … with no gap and no
   repeat (REQ-020).
3. Per-octet latency is constant and equals **10** octet times for every octet
   of all 10 000 frames (REQ-005, REQ-019) — one value, not a mean, and
   converted to ΔC = (10 + 14)/8 = 3 against the §1.1 ceiling of 3 in the
   sign-off packet.
4. Every `hdr_valid` pulse carries the destination MAC, source MAC and ethertype
   of the frame whose first payload word follows on the next cycle.
5. The module exposes no `tready` on either stream under test. This is
   structural (REQ-003, §4.1) — a statement about the type, not an assertion
   that could fail.

**Directed lengths alongside the stress run** (REQ-005, REQ-021, REQ-408): input
frames of **14 through 22 octets inclusive**, which cover the zero-payload case,
all eight payload residues modulo 8 **and** all eight `tkeep` patterns on the
payload `tlast` word, plus 1514 octets (the maximum M03 delivers, giving a
1500-octet payload in 188 words). Each is checked for the payload octet string,
the `tkeep` extent, `hdr_valid`'s single cycle and the per-octet constant.

*Twenty-two and not twenty-one, and the extra octet buys the one pattern nothing
else drives* (carry-forward **C-17(e)**, dv_lead). The residues 0 to 7 are
covered by 14 … 21, which is what REQ-021 asks for; the `tkeep` **patterns** are
not. Residue 0 in that range is the 14-octet frame, whose payload is zero octets
and which emits no payload word at all (requirements.md §0.7) and therefore no
`tlast` and no `tkeep`. The full-word pattern `0xFF` needs a payload length that
is a positive multiple of 8, which is a **22**-octet input frame; neither the
60-octet stress frame (payload 46, `tkeep` = 0x3F) nor the 1514-octet case
(payload 1500, `tkeep` = 0x0F) produces one. A coverage table quoting the
`0xFF` row without this length would name a row no test drives.

## 9. Errors and discards

Strobe names are normative (requirements.md §12).

| Condition | Strobe (one cycle) | Stream effect | REQ |
|---|---|---|---|
| The frame carries fewer than 14 octets (1 to 13; a 0-octet frame has no encoding, REQ-011) | `error_short_frame` | **no `hdr_valid`, no payload word at all**; the frame is discarded before anything is emitted | REQ-402, §0.7 |

Silent discard is prohibited (REQ-008): the one row has a strobe. The `clear`
mid-frame case of §7 is REQ-009's, not REQ-008's.

**Strobe cycle, pinned.** `error_short_frame` pulses for exactly one cycle, on
the cycle **one after the input word carrying that frame's `tlast`** — the
earliest cycle a registered output can report a condition that becomes decidable
on that word, and the same offset at which `hdr_valid` reports a 14-octet frame.
It is computable from the input trace alone and lies inside requirements.md
§0.6's window.

**A frame of exactly 14 octets is not on this table.** It is a legal frame with
a zero-octet payload: `hdr_valid` pulses, no payload frame is emitted, no strobe
pulses, and requirements.md §0.6's conservation equation counts the frame
against the header pulse. A bench that treats it as a discard will find a
conservation discrepancy that does not exist.

**Which conditions can co-occur on one frame, and what then pulses.**

- **`error_short_frame` with an inherited `tuser`[0] = 1**: the strobe pulses
  once and no frame is emitted. This is requirements.md §0.6's local-discard
  rule — the local discard wins over the inherited abort — and its second half
  matters as much: M06 SHALL NOT pulse anything to re-report the inherited
  abort, because it did not detect it. REQ-403's own verification commissions
  exactly this case (a 13-octet aborted frame: no output frame, exactly one
  `error_short_frame`).
- **`error_short_frame` with itself**: one pulse per frame. M06 owns one
  condition and evaluates it once, at the frame's `tlast`.
- There is no other pair: M06 detects exactly one condition.

**Abort inheritance.** For every frame that produces a payload frame, the
`tuser`[0] of the input `tlast` word is copied to the payload `tlast` word
(REQ-403, REQ-007). M06 never sets that bit for a reason of its own and never
clears it.

## 10. REQ coverage

| REQ | How this module satisfies it | Section | Verification hook for DV |
|---|---|---|---|
| REQ-003 | both streams are `Axi64.Source` with no `Dest`; no `tready` in either record | §4.1 | interface compile check |
| REQ-004 | sustains M03's output pattern — 8 words then 2 or 3 idle cycles, alternating — for 10 000 frames | §8 | line-rate stress bench |
| REQ-005 | fixed-delay pipeline; no payload word withheld to the frame's end; a short frame's word is not emitted early | §6.1, §7 | per-octet latency tagger inside the stress bench; directed lengths 14–22 and 1514 |
| REQ-007, REQ-403 | inherited `tuser`[0] copied to the payload `tlast` word; a discarded frame emits none | §9 | error injection on a frame long enough to produce payload words, plus a 13-octet aborted frame |
| REQ-008 | one condition, one strobe, pulse cycle pinned | §9 | directed test plus the frame-conservation monitor |
| REQ-009 | `clear` empties the pipeline; mid-frame `clear` truncates silently | §7 | reset test: assert mid-frame, deassert, drive a frame on the next cycle |
| REQ-011 | `payload_tkeep` `0xFF` except on `tlast`, contiguous from bit 0 | §7 | protocol monitor on the payload stream, every bench |
| REQ-012, REQ-409 | header fields decoded to numeric values, first wire octet most significant | §6.1 | known-frame directed test comparing a MAC field and the ethertype against hand-computed values (REQ-012's worked examples) |
| REQ-014 | `tstrb` ignored in, driven 0 out | §4.2 | protocol monitor; REQ-014's differential run |
| REQ-015 | one `tlast` per payload frame, the `tlast` word included; at most 188 words | §7 | protocol monitor |
| REQ-016 | input idle cycles delay octets and change nothing else; §6.1's cycle formulas are gapless-only | §6.1, §7 | idle-injection wrapper at 0, 1 and 7 cycles, asserting the **per-octet** constant rather than the cycle formula |
| REQ-019 | ΔC = 3 against a ceiling of 3; two words of payload storage | §7 | ΔC computed from the pinned L and h at freeze; measured ΔC from the stress run in the sign-off packet |
| REQ-020 | one frame at a time; order not expressible otherwise | §6.2 | sequence numbers in the stress run |
| REQ-021 | payload octet 0 at `payload_tdata`[7:0] at every frame length | §6.1 | directed lengths 14–22: 14–21 cover every residue modulo 8, and 22 is what covers the `0xFF` `tkeep` pattern (C-17(e)) |
| REQ-401 | header record with `valid` one cycle high, one cycle before the first payload word; a 14-octet frame pulses `valid` with no payload frame | §6.1, §7 | known-frame test: fields compare equal, `valid` high exactly one cycle; plus the 14-octet frame, asserting header, no payload word, no strobe |
| REQ-402 | frames of 1–13 octets produce no header, no payload and one strobe | §9 | 1-, 8- and 13-octet frames |
| REQ-407 | `dst_mac` is captured and compared against nothing; no filtering exists to disable | §2, §4.3 | frame with a foreign destination MAC delivered unchanged (checked end to end at M20) |
| REQ-408 | every octet after the ethertype is forwarded, padding included; 46 octets from a 64-octet frame | §6.1, §8 | the 64-octet frame of §8, asserting 46 payload octets |
| REQ-410 | a frame whose first word arrives on the cycle after the previous `tlast` is received correctly | §6.1, §6.2 | two frames with zero idle cycles between them; both delivered intact with correct header records. A bench SHALL NOT assert that the previous frame's payload `tlast` word has already left when the next frame's first input word arrives: M + 2 ≥ K, so it has not, at any length that is a multiple of 8 (C-17(a)) |
| REQ-802, REQ-810 | no instance: M06 reads no configuration, and REQ-810's receive half is M03's | §4.3 | none — stated so that no sign-off packet claims coverage here |
| REQ-903, REQ-808 | `eth_axis_rx` is a distinct emitted module with `create`, `hierarchical` and an `.mli` | §4.1 | repository surface check and the `rtl_snapshots/` name comparison |

This table is the source of M06's rows in [`traceability.md`](../traceability.md),
updated in the same commit.

## 11. Deferred items

Item numbers are permanent; a closed item keeps its row (SPEC-TEMPLATE §11).

| # | Item | Status · what a reader assumes meanwhile | Tracked as | Owner | Closes by |
|---|---|---|---|---|---|
| 11.1 | **The `ifc_check` compile evidence for this lift is pending**: `eth_axis_rx_ifc.ml` is new in this commit and carries the first compile-time witness of `Eth_header`'s four field names. | **CLOSED (WO-0014).** CI `build` run **30733153172** at f457efc reports `success` with this lift in it, and `git diff 508eea2 f457efc -- docs/specs/ifc_check/` is empty, so the record the run elaborated is byte-identical to the one frozen here. `Eth_header`'s four field names are as SPEC-M01 §4.2 writes them, established by a run. | the `Interface compile check` row of §12 | architect_docs_lead, rtl_lead | closed |
| 11.2 | **M06 is pinned exactly at its §1.1 ceiling** (ΔC = 3 of 3), with no cycle of its own in reserve — the position SPEC-M03 §7 deliberately avoided for M03. | **DEFERRED — the number is decided and buildable, only its reserve is absent.** A reader implements to ΔC = 3 today, and §7 gives the argument that three is reachable with a registered output. If implementation shows otherwise, the repair is a **slack release** from the seven cycles requirements.md §1.1 reserves: a spec diff to §7, to §1.1 and to architecture.md §4 together, never a local decision and never a silent one. | this item; requirements.md §1.1 | architect_docs_lead | M06's `P1-module-ready` |
| 11.3 | **`Eth_header`'s `valid` has two disciplines** — a one-cycle pulse here (REQ-401) and a level held until acceptance on the transmit side (SPEC-M07 §6.1, ADR-0008) — and the record itself cannot say which applies. | **CLOSED (WO-0019), affirmatively: batch F found no such consumer, so no diff to SPEC-M01 §4.1 is owed.** The receive-side discipline is REQ-401's and this specification's §7; the transmit-side one is ADR-0008's and SPEC-M07 §6.1's; the direction of a port decides which, and every port declares its direction. The rule now covers four records with no exception — `Eth_header`, `Arp_packet` (SPEC-M10 §11.4), `Ip_header` (SPEC-M14 §7 against SPEC-M15 §7) and `Udp_header`, which has a receive discipline only (SPEC-M17 §7), because M18 builds its header from a `Udp_tx_request` rather than from a header record. Both wrappers that carry the two disciplines across their own ports in opposite directions say so in their §7 (SPEC-M16, SPEC-M19). A `discipline` field in a FROZEN record would be an addition no port asks for. | ADR-0008; SPEC-M17 §7 | architect_docs_lead | closed |
| 11.4 | **Two readings this specification carried that a bench would have failed a conformant design on, or claimed coverage for without a test**: §6.1's back-to-back paragraph asserted M + 2 ≤ Ci + K, the inverse of the inequality its own abort paragraph proves; and §8's directed set 14–21 claimed all eight `tkeep` patterns while omitting the only length that produces `0xFF`. | **CLOSED (WO-0014).** §6.1 now states M + 2 ≤ K + 1 with both inequalities derived side by side and names the stimulus the old wording failed on; §8 extends the directed set to **14 through 22** and separates the residue claim from the pattern claim; §10's REQ-005, REQ-021 and REQ-410 hooks carry the corrected figures. No constant, state or record changes. | ledger **C-17** (items (a) and (e)) | architect_docs_lead | closed |

## 12. Freeze record

Filled in at `P1-spec-freeze`. All four rows are required (charter §5).

| Item | Value |
|---|---|
| Interface compile check | CI `build` run **30733153172**, conclusion **`success`**, SHA **f457efc** — all nine batch-A/B/C lifts elaborate, this one included; per ADR-0005 a local build is not acceptable evidence. `git diff 508eea2 f457efc -- docs/specs/ifc_check/` is empty, so the run witnesses the record frozen at 508eea2. This run is also §11.1's closure record |
| Architect signature | `J-architect_docs_lead-0005` |
| dv_lead testability countersignature | `J-dv_lead-0007` (WO-0013) — **SIGNED**, batch C; the zero-reserve ceiling of §7 judged achievable and signed at zero reserve, with C-17(a) and C-17(e) raised and now closed in §13 |
| Frozen at | SHA **508eea2**, gate `docs/gates/P1-spec-freeze-checklist.md` |

## 13. Change log

Post-freeze changes only. Each row cites the ADR that authorised it; a breaking
interface change is counted against post-freeze churn (charter §6). **No row
below is breaking**: §4.1's record is byte-for-byte unchanged since the freeze
SHA, so the `ifc_check` evidence of §12 still witnesses this revision's
interface.

| Date | Change | Breaking? | ADR | Journal |
|---|---|---|---|---|
| 2026-08-02 | §6.1 back-to-back paragraph: the inverted inequality `M + 2 ≤ Ci + K` replaced by `M + 2 ≤ K + 1`, with both directions derived and the failing stimulus named; §10's REQ-410 hook gains the matching prohibition (ledger **C-17(a)**) | no | none — the abort paragraph two paragraphs earlier already proved the governing inequality; this removes the contradiction | `J-architect_docs_lead-0006` |
| 2026-08-02 | §8 directed set extended from 14–21 to **14–22** octets and its residue claim separated from its `tkeep`-pattern claim; §10's REQ-005 and REQ-021 hooks follow (ledger **C-17(e)**) | no | none — a coverage claim short by one length, not a behavioural statement; §6.1's payload mapping is unchanged | `J-architect_docs_lead-0006` |
