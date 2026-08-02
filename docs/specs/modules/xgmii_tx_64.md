# SPEC-M04 — `Xgmii_tx_64`

- **Status**: DRAFT
- **Inventory id**: M04 (architecture.md §4) · **Path**:
  `libs/hardcaml_ethernet/src/xgmii_tx_64.ml`
- **Datapath role**: transmit
- **Owns REQs**: REQ-201, REQ-202, REQ-203, REQ-204, REQ-205, REQ-206,
  REQ-207, REQ-208, REQ-209, REQ-210
- **Prior-art counterpart**: `axis_xgmii_tx_64.v` (MIT) — consulted for
  decomposition and port naming only; behaviour below is stated independently
  and no source was copied
- **Depends on specs**: SPEC-M01 (`Axi64`, `Xgmii`), SPEC-M02 (`Crc32_eth`)
- **Author**: architect_docs_lead, journal `J-architect_docs_lead-0004`

## 1. Purpose

M04 turns a frame stream into XGMII lanes: it prepends the preamble and start
character, pads short frames, appends the CRC-32 FCS, emits the terminate
character and serves the inter-frame gap. It exists as a separate module for
the same reason M03 does — it is the whole of the programme's XGMII *encode*,
and no module above it ever writes a lane or a control character.

Its upstream is M07 `Eth_axis_tx` (through M09 `Eth_arb_mux`); its downstream is
the XGMII transmit lane pair, decoded in Phase 1 by the DV link-partner model
(REQ-018). It instantiates M02 `Crc32_eth` and holds the running CRC in its own
registers — the same engine M03 uses, which is the point of M02 existing
(SPEC-M02 §1).

## 2. Scope

**In scope.**

- Start character and the eight preamble octets, lane 0 only in Phase 1
  (REQ-201).
- Padding short frames to 60 octets before the FCS (REQ-203).
- FCS computation and its wire order (REQ-202).
- Terminate character placement and idle fill (REQ-205).
- The inter-frame gap, its `cfg_ifg` configuration and its lane-0 rounding
  (REQ-204), and the throughput that follows (REQ-209).
- `tready` towards the frame source, and the guarantee that no accepted word is
  dropped (REQ-207).
- Underflow detection and reporting (REQ-206).
- A constant, pinned start-up latency (REQ-210).

**Not this module's job.**

| Behaviour a reader might expect here | Owner |
|---|---|
| Building the 14 Ethernet header octets, or any header | M07 `Eth_axis_tx` (REQ-405) and the layers above it |
| Choosing between two frame sources, or frame-atomic arbitration | M09 `Eth_arb_mux` (REQ-406) |
| The CRC-32 function and its constants | M02 `Crc32_eth` (REQ-301 … REQ-306) |
| Knowing a frame's length before it arrives | nobody: M04 pads and terminates from `tlast` and an octet counter, never from a declared length. The declared length of REQ-705 belongs to M18 and never reaches this module |
| Deficit idle count, and averaging the gap below 16 octets | nobody — out of Phase-1 scope (requirements.md §11); M04 rounds every gap up and under-uses the link deliberately (§0.3) |
| Reporting that the application supplied more or fewer octets than it declared | M18 `Udp_ip_tx_64` (`error_tx_length_mismatch`, REQ-709, REQ-710). M04 reports only what it detects itself: a word required and not presented |
| Decoding the transmitted lanes to check them | dv_lead's link-partner model (REQ-018) |

## 3. Programme invariants that bind this module

M04 is **not** a receive-path module under requirements.md §0.4: it is on the
transmit chain, its `tready` is legitimate, and requirements.md §1.1 allocates
it no ceiling. The invariants that do bind it are below; REQ-208 is the one
that connects it to the receive path at all.

| REQ | Consequence for M04 |
|---|---|
| REQ-001 | One `clock`, shared with the receive path (REQ-018 makes the boundary simulation-only, so the real XGMII's independent transmit clock has no instance here). |
| REQ-002 | The source stream is one `Axi64` word per cycle; the XGMII output is 64 data bits and 8 control bits per cycle, always present. |
| REQ-003 | Does not bind M04's own ports — but REQ-208 does: nothing here may reach back into the receive datapath. |
| REQ-005 | Does not bind M04 (it is not a receive-path module). Its transmit analogue is REQ-210's constant, pinned in §7. |
| REQ-008 | M04 owns one strobe, `error_underflow` (§9). |
| REQ-009 | Synchronous `clear`: no XGMII frame begins, `tready` is 0, `error_underflow` is 0, and a frame in flight is abandoned without a terminate character and without a strobe (§7). |
| REQ-010 | The source port is the programme `Axi64.Source` with a matching `Axi64.Dest` — the transmit-path pattern of architecture.md §2.3. The XGMII output is SPEC-M01's `Xgmii` record and is not a stream (an XGMII pair carries a value every cycle). |
| REQ-011 | `tkeep` on the incoming `tlast` word tells M04 how many octets of that word to transmit; `tkeep` = 0 with `tvalid` = 1 never arrives (SPEC-M01 §6.1) and M04 defines no behaviour for it. |
| REQ-012 | Source octet position k (`tdata`[8k+7:8k]) is transmitted in XGMII lane order, earliest first; a source word maps to a transmit word without rotation, because M04 starts on lane 0 and its preamble is exactly one word. |
| REQ-013 | `tuser`[0] on the incoming `tlast` word is **not** acted on: M04 transmits the frame regardless, which is REQ-013's "no module drops a frame solely because this bit is set". A frame the stack knows to be bad reaching the wire is a Phase-1 non-event — nothing upstream of M04 generates one. |
| REQ-014 | `tstrb` on the source stream is ignored (REQ-014). |
| REQ-015 | One `tlast` per frame; M04 uses it as the frame's end and needs no length. |
| REQ-016 | REQ-016's idle tolerance **does not extend to this interface**: a missing word on a cycle M04 requires one is an underflow (REQ-206), not a gap. requirements.md §11 records the absence of elastic buffering as a decision. |
| REQ-017 | M04's wire-side ports are the transmit half of REQ-017's four names, declared from SPEC-M01's `Xgmii` record with `[@rtlprefix "xgmii_tx"]`. |
| REQ-018 | No sub-XGMII logic, no PTP, no vendor primitive; instantiates M02 and nothing else. |
| REQ-020 | Frames are transmitted in the order they are accepted; M04 holds one frame at a time. |
| REQ-021 | Every source word is word-aligned at its producer, so M04 never realigns and its octet mapping is the identity. |

## 4. Interface

### 4.1 Interface records

```ocaml
(* SPEC-M04 §4.1, lifted verbatim into docs/specs/ifc_check/xgmii_tx_64_ifc.ml
   (SPEC-TEMPLATE.md rule 6). Records and signatures only — no logic, no
   implementation.

   [Axi64_ifc] is M01's types home (SPEC-M01 §4.1).

   [tx] and [tx_dest] are the two directions of **one** logical stream and
   share the prefix "tx_": the [Source] fields emit tx_tvalid … tx_tuser
   and the [Dest] field emits tx_tready, with no collision because the
   field names are disjoint. This is the transmit-path pattern
   architecture.md §2.3 fixes — [Source] one way, [Dest] the other — and
   it is the only place in Phase 1 where a [Dest] legitimately appears
   beside a frame stream.

   The [Dest] witness at the bottom completes SPEC-M01 §11.4: M03's lift
   names the six [Source] fields, this one names [tready]. *)

open! Base
open Hardcaml
open! Axi64_ifc

module I = struct
  type 'a t =
    { clock : 'a
    ; clear : 'a
    ; tx : 'a Axi64.Source.t [@rtlprefix "tx_"]
    ; cfg_ifg : 'a [@bits 8]
    ; cfg_tx_enable : 'a
    }
  [@@deriving hardcaml]
end

module O = struct
  type 'a t =
    { tx_dest : 'a Axi64.Dest.t [@rtlprefix "tx_"]
    ; xgmii_tx : 'a Xgmii.t [@rtlprefix "xgmii_tx"]
    ; error_underflow : 'a
    }
  [@@deriving hardcaml]
end

module type S = sig
  val create : Scope.t -> Signal.t I.t -> Signal.t O.t
  val hierarchical : ?instance:string -> Scope.t -> Signal.t I.t -> Signal.t O.t
end

(* SPEC-M01 §11.4 field-name witness, Dest half. *)

let _witness_dest_field_names (x : Signal.t Axi64.Dest.t) =
  let open Axi64.Dest in
  [ x.tready ]
;;
```

Conformance of this block to the template's rules for §4.1:

- Scalar fields carry `[@bits n]` unless one bit wide: `cfg_ifg` is 8 bits
  (requirements.md §9.1); `clock`, `clear`, `cfg_tx_enable` and
  `error_underflow` are one bit.
- Nested interfaces carry `[@rtlprefix]`.
- **`Source` one way and `Dest` the other, on the same logical stream**: held,
  and this is the transmit-path rule rather than the receive-path one. M04 is
  allowed a `tready` precisely because it is not a receive-path module
  (requirements.md §0.4); REQ-208, not REQ-003, is what keeps that `tready`
  from mattering to the receive path.
- Both `create` and `hierarchical` are declared (REQ-903, REQ-808).

### 4.2 Port table

Every port in §4.1 appears exactly once.

| Port | Dir | Width | Meaning | REQ |
|---|---|---|---|---|
| `clock` | in | 1 | 156.25 MHz single domain | REQ-001 |
| `clear` | in | 1 | synchronous clear | REQ-009 |
| `tx_tvalid` | in | 1 | the source presents a word this cycle | REQ-016, REQ-206 |
| `tx_tdata` | in | 64 | frame octets, DA first, word-aligned | REQ-012, REQ-021 |
| `tx_tkeep` | in | 8 | valid octet positions; 1 to 8 contiguous ones on the `tlast` word | REQ-011 |
| `tx_tstrb` | in | 8 | reserved and ignored | REQ-014 |
| `tx_tlast` | in | 1 | this word carries the frame's final octets | REQ-015 |
| `tx_tuser` | in | 1 | bit 0 advisory abort; **not acted on** (§3, REQ-013) | REQ-013 |
| `tx_tready` | out | 1 | M04 accepts a word this cycle; a word accepted is never dropped | REQ-207 |
| `cfg_ifg` | in | 8 | inter-frame gap in octets, counted from the terminate character inclusive; default 12, values below 12 SHALL NOT be driven | REQ-204, REQ-802 |
| `cfg_tx_enable` | in | 1 | when 0 no new frame begins and `tx_tready` stays 0 | REQ-810, REQ-802 |
| `xgmii_txd` | out | 64 | eight XGMII lanes; lane k is bits [8k+7:8k], lane 0 transmitted first | REQ-012, REQ-017 |
| `xgmii_txc` | out | 8 | bit k marks lane k as a control character | REQ-017, REQ-205 |
| `error_underflow` | out | 1 | one-cycle strobe: a word was required mid-frame and not presented | REQ-206 |

### 4.3 Configuration inputs

Two fields of the `Config` record, as scalar `cfg_<field>` inputs under the
programme convention of SPEC-M01 §4.2.

| Field | Effect | When a change takes effect |
|---|---|---|
| `ifg` | the minimum inter-frame gap in octets counted from the terminate character inclusive (REQ-204). Values below 12 are prohibited (requirements.md §9.1) and M04 defines no behaviour for them | sampled when the gap begins, i.e. on the cycle the terminate character is emitted; a gap already being served is not shortened or lengthened by a change (REQ-803) |
| `tx_enable` | when 0, no new frame begins on XGMII, only idle characters are emitted, and `tx_tready` is held 0 (REQ-810) | sampled at the frame boundary: a frame already in flight completes, the next does not begin (REQ-803, REQ-810) |

## 5. Parameters

**None.** The preamble pattern, the 60-octet pad target and the FCS width are
fixed by REQ-201, REQ-203 and REQ-202; the gap is a *configuration* input, not
a parameter, because REQ-204 makes it runtime-visible. REQ-506's rule has no
instance here: M04 has no timeout, no ageing interval and no retry.

| Parameter | Type | Default | Range | Why a test overrides it |
|---|---|---|---|---|
| (none) | — | — | — | — |

## 6. Behaviour

### 6.1 Normal path

M04 reads no header field and writes none: it prepends, appends and pads octets
whose meaning it never inspects. The one structural fact it uses is `tlast`.

**The preamble (REQ-201).** One XGMII word: `/S/` in lane 0, six 0x55 octets in
lanes 1–6, one 0xD5 SFD octet in lane 7. Phase 1 places the start character in
lane 0 only — no lane-4 starts and no deficit idle count (requirements.md §0.3,
§11) — which is why the preamble is exactly one word and why M04 never
realigns a source word.

**The frame (REQ-012, REQ-021).** Source word m is transmitted as XGMII word
m + 1 counted from the preamble word, octet position for lane position, with no
rotation. On the `tlast` word only the octets marked by `tkeep` are frame
octets.

**Padding (REQ-203).** M04 counts the frame octets it has transmitted. If the
count at `tlast` is below 60, it continues with zero octets until 60 have been
transmitted, and those pad octets are covered by the FCS. A 60-octet frame plus
its four FCS octets is the 64-octet minimum frame of requirements.md §0.3.

**The FCS (REQ-202), in M02's finished-value convention** (SPEC-M02 §6.1,
ADR-0006):

1. a 32-bit register is **seeded to 0x00000000** before the frame's first
   octet;
2. on every cycle transmitting at least one frame or pad octet, it is updated
   through M02 with those octets and `octet_count` set to how many — **1 to 8,
   never 0**. On any other cycle the register is **held** by its enable and
   M02's result is ignored, so no update-by-zero is driven (ADR-0007);
3. coverage is the destination address through the last payload **or pad**
   octet;
4. the four FCS octets are the finished value transmitted **least significant
   octet first**: `crc_out`[7:0], then [15:8], then [23:16], then [31:24]. That
   wire order is what makes REQ-304's residue constant, which is what M03
   checks against — the two requirements are one decision seen from two sides
   (SPEC-M02 §6.1, worked example 2).

The FCS octets follow the last frame or pad octet in the next lane positions,
so they may share a word with frame octets or occupy a word of their own.

**Terminate and fill (REQ-205).** The terminate character occupies the lane
immediately after the last FCS octet; every remaining lane of that word and
every lane of every subsequent gap word carries `/I/`.

**The inter-frame gap (REQ-204).** The gap is counted **from the terminate
character inclusive** to the next start character exclusive, and must be at
least `cfg_ifg` octets. Because M04 starts frames on lane 0 only, the gap is
rounded up to the next lane-0 boundary: with the terminate character in lane t
of a word, the next start character is g words later where g = ⌈(`cfg_ifg` +
t) / 8⌉, giving an actual gap of 8g − t octets. At the default `cfg_ifg` = 12
this is 16 octets for t = 0 and 12 octets for t = 4. Gaps are only ever rounded
**up**; deficit idle count is out of scope, so no gap is ever shortened
(requirements.md §0.3, §11).

**Cycle by cycle, a minimum-length frame.** The source presents 60 octets in
eight words (seven full, one with `tkeep` = 0x0F). Cycle C is the cycle the
first source word is accepted.

| Cycle | `tx_tready` | Source | XGMII output |
|---|---|---|---|
| C | 1 | word 0 accepted (octets 0–7) | idle (the previous gap, or idle) |
| C+1 | 1 | word 1 accepted | **preamble**: `/S/`, 0x55 ×6, 0xD5 |
| C+2 … C+8 | 1 | words 2–7 accepted (word 7 carries 4 octets, `tlast` = 1 at C+7) | frame octets 0–55, eight per word |
| C+9 | 0 | — | octets 56–59 and the four FCS octets |
| C+10 | 0 | — | `/T/` in lane 0, `/I/` in lanes 1–7 |
| C+11 | 1 (next frame may be accepted) | next frame's word 0 | `/I/` ×8 |
| C+12 | 1 | | next frame's preamble |

Eleven cycles from start character to start character (REQ-209); the gap from
the terminate character inclusive is 1 + 7 + 8 = 16 octets, which satisfies the
12-octet minimum (REQ-204); 88 octets between successive start characters,
which is REQ-204's verification figure.

**Storage, stated because REQ-207 depends on it.** A source word accepted on
cycle C + m is transmitted on cycle C + m + 2, so exactly **two** words are in
flight inside M04 at any time. The preamble word is the one output slot that
does not consume a source word, and that is the whole reason the depth is two
rather than one. It is not an elastic buffer: M04 requires a word on every
cycle it asserts `tx_tready` during a frame, and a missing one is an underflow
on that cycle (REQ-206, REQ-016).

**When `cfg_tx_enable` is 0.** `tx_tready` is held 0 and no start character is
emitted; the lanes carry idle. A frame already in flight completes normally
(REQ-803, REQ-810).

### 6.2 State machine

Reset state and `clear` state are both `Gap` with the gap counter satisfied,
which is equivalent to idle and needs no separate state.

| State | Entered when | Does | Leaves to |
|---|---|---|---|
| `Idle` | reset; `clear`; the gap has been served | emits `/I/` in every lane; `tx_tready` = `cfg_tx_enable` | `Preamble` on the cycle a first source word is accepted |
| `Preamble` | a first source word is accepted | emits the REQ-201 word; seeds the CRC register to 0x00000000; keeps `tx_tready` = 1 | `Frame`, always, after exactly one cycle |
| `Frame` | the cycle after `Preamble` | transmits source words; enables the CRC update on every cycle covering ≥ 1 octet; counts transmitted frame octets; requires a source word on every cycle `tx_tready` = 1 | `Pad` if `tlast` arrived below 60 octets; `Fcs` if the count has reached 60 at `tlast`; `Abort` on underflow |
| `Pad` | `tlast` below 60 octets | transmits zero octets, covered by the CRC, until 60 | `Fcs` |
| `Fcs` | the last frame or pad octet is transmitted | transmits the four FCS octets least significant first, then the terminate character in the next lane and `/I/` to the end of the word | `Gap` |
| `Abort` | underflow (REQ-206) | transmits the words already accepted, then one word carrying `/E/` in lane 0 and `/T/` in lane 1 with `/I/` in lanes 2–7; appends **no** FCS | `Gap` |
| `Gap` | a terminate character has been emitted | emits `/I/`; counts the gap from the terminate character inclusive against `cfg_ifg`, rounding up to the next lane-0 boundary | `Idle` when the gap is satisfied |

The CRC register's **enable** is the mechanism ADR-0007 records: asserted only
in `Frame` and `Pad`, and only on cycles covering at least one octet, so
`octet_count` is always inside M02's 1-to-8 domain.

### 6.3 Deliberately unconstrained

Anything not listed here is constrained by this specification, and a test may
rely on it.

1. **The placement of the two register levels** and every internal encoding:
   the FSM encoding, how the pad counter is built, whether the FCS is sliced
   from a register or from M02's combinational output. §7's constant is what is
   fixed.
2. **The value of `xgmii_txd` lanes carrying a control character.** The control
   character's own value is normative (`/S/` 0xFB, `/T/` 0xFD, `/E/` 0xFE,
   `/I/` 0x07) and is what `xgmii_txc` marks; nothing else is.
3. **`tx_tready` on cycles when no frame is in progress and `cfg_tx_enable` is
   1** — M04 may hold it high waiting for a source, or gate it on the gap
   counter, provided REQ-209's throughput and REQ-204's gap hold. What it may
   **not** do is accept a word it then cannot transmit (REQ-207).
4. **The number of idle words emitted before the first frame after `clear`**,
   beyond the requirement that the first frame's gap obligation is satisfied
   (there is no preceding terminate character, so REQ-204 has no instance for
   the first frame).

## 7. Timing contract

- **Latency.** REQ-210's constant, pinned: the delay from the first accepted
  source word to the XGMII word carrying that frame's start character is
  **1 cycle = 8 octet times**, measured with the transmitter idle and REQ-204's
  gap obligation already satisfied. The two measurement events are the cycle on
  which `tx_tvalid` and `tx_tready` are both 1 for the frame's first word, and
  the cycle of the XGMII word whose lane 0 carries `/S/`. The figure is exactly
  8 × 1 octet times because REQ-201 puts every start character in lane 0, so
  both events sit at octet position 0 of their words.

  M04 is not a receive-path module: requirements.md §1.1 allocates it no
  ceiling and REQ-006's budget does not contain it. No requirement constrains
  the *value* of this constant — only that it is one. It is pinned at 1 cycle
  because that is the minimum an inserted preamble word permits (§6.1), and
  changing it later is an ordinary spec diff with no budget consequence.

  Back-to-back transmission legitimately delays a start character until the gap
  is served, and REQ-210 puts that outside its domain.

- **Throughput.** One source word accepted per cycle while `tx_tready` is 1;
  one XGMII word emitted every cycle, always. With the default gap, minimum
  length frames go out at exactly one per 11 cycles and no inter-frame spacing
  differs from 11 (REQ-209) — a consequence of REQ-204's lane-0 rounding, not
  an independent design choice. `tx_tready` is 0 during the FCS word, the
  terminate word and the gap; it may be 1 during the preamble word, because
  the two-word depth of §6.1 absorbs exactly that one slot.

- **Handshake rules.** A word is accepted on a cycle with `tx_tvalid` = 1 and
  `tx_tready` = 1, and an accepted word is always transmitted (REQ-207). Field
  stability is the source's for the cycle of acceptance only; M04 registers
  what it accepts. `tx_tlast` ends the frame — M04 needs no declared length.
  **REQ-016's idle tolerance does not apply to this interface**: on any cycle
  after the start character has been emitted and before the frame's `tlast`
  word has been accepted, `tx_tready` = 1 with `tx_tvalid` = 0 is an underflow
  (REQ-206, §9), not a gap.

- **Reset.** While `clear` = 1 and on the first cycle after it returns to 0:
  `tx_tready` = 0, `error_underflow` = 0, and the lanes carry idle. `clear`
  asserted mid-frame abandons the frame on the wire with **no** terminate
  character and **no** strobe — the frame simply stops, which is REQ-009's
  explicit permission and is the only silent frame loss in this specification.
  A frame presented on the first cycle after `clear` returns to 0 is
  transmitted correctly.

- **Configuration sampling.** `cfg_ifg` at the terminate character; `cfg_tx_
  enable` at the frame boundary (§4.3, REQ-803).

- **Timing closure.** The FCS word combines M02's combinational eight-octet
  update with the output word selection in one cycle. Phase 1 is simulation
  only at this boundary (REQ-018), so no static timing closure at 6.4 ns is
  required; SPEC-M02 §7's note governs what happens if a later phase cannot
  close it, and the remedy there is a spec diff and an ADR, never a quiet
  register.

## 8. Line-rate stress obligation

**Not applicable.** M04 is not in requirements.md §0.4's stress-bench list
(M03, M06, M08, M10, M14, M17, M20), which enumerates *receive-path* modules —
REQ-004's invariant is about surviving an arrival rate the module cannot slow
down, and M04 is the one module in Phase 1 that sets its own pace. Its
equivalent obligation is REQ-209's sustained transmit bench: 10 000
minimum-length frames, asserting that the mean is 11 cycles per frame **and**
that no individual inter-frame spacing differs from 11 (§10). That bench is
stronger than a mean, and it is what §0.4's list would have bought here.

## 9. Errors and discards

| Condition | Strobe (one cycle) | Stream effect | REQ |
|---|---|---|---|
| A source word is required and not presented: `tx_tready` = 1 and `tx_tvalid` = 0, after the start character has been emitted and before the frame's `tlast` word has been accepted | `error_underflow` | the words already accepted are transmitted (REQ-207 forbids dropping them), then one XGMII word carrying `/E/` in lane 0 and `/T/` in lane 1, `/I/` in lanes 2–7; **no FCS is appended**; the gap is then served from that terminate character | REQ-206 |

Silent discard is prohibited (REQ-008): the one row has a strobe. The
`clear`-mid-frame case of §7 is REQ-009's, not REQ-008's.

**Strobe cycle, pinned.** `error_underflow` pulses for exactly one cycle, on
the cycle **the word was required and not presented** — the earliest cycle the
condition is decidable, and inside requirements.md §0.6's window. The wire
consequence follows two cycles later, when the missing word's transmit slot
arrives; a bench must not expect the strobe and the `/E/` on the same cycle.

**No FCS on an underflowed frame, stated because the alternative is worse.**
Appending a valid FCS to a truncated frame would put a **well-formed short
frame** on the wire, which the link partner would accept as a real frame with
a real (wrong) length. The `/E/` before the terminate character is what makes
the truncation visible to a receiver, and it is what M03 detects as REQ-105 at
the other end of a loopback.

**Co-occurrence.**

- `error_underflow` with `error_tx_length_mismatch` (REQ-709): these pulse
  **together**, from different modules, for one event. When the application
  delivers fewer octets than it declared, M18 stops presenting words and M04
  underflows; M04 detects and reports only its own condition, M18 reports the
  length mismatch, and requirements.md §0.6's rule — a module never re-reports
  a condition it merely inherited — is why M04's strobe list is one row long.
  REQ-710's over-delivery is not visible here at all: the frame on the wire is
  already complete and correct.
- Two underflows on one frame: impossible — the first ends the frame.
- M04 raises nothing for `tuser`[0] = 1 on an incoming `tlast` word (§3,
  REQ-013): it is not M04's condition, and re-reporting it would violate §0.6.

## 10. REQ coverage

| REQ | How this module satisfies it | Section | Verification hook for DV |
|---|---|---|---|
| REQ-001 | one clock; no gated or derived clock | §3 | the emitted-Verilog edge-expression check |
| REQ-009 | `clear` abandons the frame and holds `tready` low | §7 | reset test: assert mid-frame, deassert, transmit on the next cycle |
| REQ-010 | `Source` in, `Dest` out, on one logical stream | §4.1 | interface compile check |
| REQ-013 | `tuser`[0] is carried in and not acted on | §3 | drive `tuser`[0] = 1 on a `tlast` word; assert the frame is still transmitted, unchanged |
| REQ-014 | `tstrb` ignored | §3 | REQ-014's differential run |
| REQ-017 | `xgmii_txd` / `xgmii_txc` from SPEC-M01's `Xgmii` record | §4.1, §4.2 | emitted-Verilog port check at M05 and M20 |
| REQ-018 | no sub-XGMII logic; instantiates only M02 | §2, §3 | the emitted-module whitelist check |
| REQ-201 | `/S/` in lane 0, 0x55 ×6, 0xD5 | §6.1 | decode 100 transmitted frames; every start character in lane 0, eight preamble octets exact |
| REQ-202 | CRC over DA through the last frame or pad octet, transmitted least significant octet first | §6.1 | compare the four wire octets against dv_lead's independent bit-serial reference (REQ-305), **not** against a loopback through M03 |
| REQ-203 | zero-padding to 60 octets before the FCS, pad covered by the CRC | §6.1, §6.2 | transmit a 20-octet frame; assert 60 octets before the FCS with zeros from octet 21, and 64 octets DA through FCS |
| REQ-204 | gap counted from the terminate character inclusive, rounded up to lane 0, never shortened | §6.1 | back-to-back minimum frames: 88 octets between start characters, 16-octet gap at the default `cfg_ifg` |
| REQ-205 | terminate in the lane after the last FCS octet; idle everywhere after | §6.1 | frame lengths placing the terminate character in each of the eight lanes |
| REQ-206 | underflow detected on the required cycle; `/E/` then `/T/`; no FCS | §9 | stall the source for exactly one required cycle mid-frame; check the characters, the strobe, and the next frame |
| REQ-207 | an accepted word is always transmitted; `tready` low when it cannot accept | §6.1, §7 | drive a continuous source; assert the transmitted octet sequence equals the accepted-word octet sequence exactly once, in order |
| REQ-208 | M04's `tready` reaches only the transmit chain; no path from here into the receive datapath exists | §3 | hold M04 busy with a maximum-length frame while driving the receive path at the REQ-004 rate; REQ-004 still holds |
| REQ-209 | one minimum-length frame per 11 cycles at the default gap | §7 | 10 000-frame sustained bench; mean 11 **and** no spacing differing from 11 |
| REQ-210 | constant 8 octet times (1 cycle) from first accepted word to start character | §7 | latency measurement over several frame lengths, each into an idle transmitter after the gap has elapsed |
| REQ-802, REQ-810 | `cfg_ifg` and `cfg_tx_enable` sampled per §4.3 | §4.3 | `cfg_tx_enable` = 0 with a request pending: no start character, `tready` low; re-enable and check the frame goes out |
| REQ-903, REQ-808 | `xgmii_tx_64` is a distinct emitted module with `create`, `hierarchical` and an `.mli` | §4.1 | repository surface check and the `rtl_snapshots/` name comparison |

This table is the source of M04's rows in [`traceability.md`](../traceability.md),
updated in the same commit.

## 11. Deferred items

| # | Item | Status · what a reader assumes meanwhile | Tracked as | Owner | Closes by |
|---|---|---|---|---|---|
| 11.1 | **`Axi64.Dest`'s field name `tready` is witnessed here for the first time** (§4.1), completing the `Source` half witnessed in SPEC-M03. | **DEFERRED — the witness is written, the run is pending.** Meanwhile a reader assumes `tready` exactly as SPEC-M01 §4.2 writes it. A divergence is a red CI run on this commit and an editorial diff. | SPEC-M01 §11.4 | architect_docs_lead, rtl_lead | the batch-B `ifc_check` run |
| 11.2 | **REQ-206's underflow remedy interacts with REQ-207's no-drop rule**, and this specification resolves it by transmitting the already-accepted words before the `/E/`. Nothing in requirements.md says which wins. | **DEFERRED for confirmation, not for decision.** §9 states the resolution normatively and a bench is derivable today: after an underflow, the octets already accepted appear on the wire, then `/E/` `/T/`. Flagged in the WO-0008 Return log for dv_lead's batch-B countersignature; if dv_lead prefers dropping them, that is a requirements.md diff to REQ-207, not a local edit. | WO-0008 Return log | architect_docs_lead, dv_lead | batch-B countersignature |
| 11.3 | **Carry-forward C-5**: requirements.md §0.6's strobe window bound is vacuous for `error_underflow`, because its "latency in cycles after the input word carrying the last octet of the offending frame" is not defined for a frame that never receives that octet. | **DEFERRED — this specification does not depend on the window.** §9 pins the pulse to one exact cycle, computable from the source trace alone, so a bench needs nothing from §0.6 here. The editorial repair to §0.6 is ledger item C-5 and lands at any convenient work order. | ledger **C-5** | architect_docs_lead | any |

## 12. Freeze record

Filled in at `P1-spec-freeze`. All four rows are required (charter §5); this
spec is DRAFT.

| Item | Value |
|---|---|
| Interface compile check | pending — CI `build` run `<id>`, conclusion `<success>`, SHA `<sha>`; per ADR-0005 a local build is not acceptable evidence |
| Architect signature | `J-architect_docs_lead-0004` |
| dv_lead testability countersignature | pending — batch B (SPEC-M03, M04, M05) |
| Frozen at | pending — SHA `<sha>`, gate `docs/gates/P1-spec-freeze-checklist.md` |

## 13. Change log

Post-freeze changes only. This spec is DRAFT and has none.

| Date | Change | Breaking? | ADR | Journal |
|---|---|---|---|---|
| — | — | — | — | — |
