# SPEC-M04 — `Xgmii_tx_64`

- **Status**: **FROZEN** (`P1-spec-freeze`, SHA `f78766e`) — batch B, dv_lead
  countersignature `J-dv_lead-0005`. Changes to §4, §6 or §7 after this point
  are spec diffs recorded in §13 (SPEC-TEMPLATE rule 7)
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

A change to either field landing on the **same** cycle as its sampling event is
outside both rows above and is deliberately unconstrained — §6.3 item 5,
carry-forward **C-14.5**.

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
| `Idle` | reset; `clear`; the gap has been served | emits `/I/` in every lane; `tx_tready` = `cfg_tx_enable`, **except on the cycles §7's reset clause covers** — while `clear` = 1 and on the first cycle after it returns to 0, `tx_tready` is 0 whatever `cfg_tx_enable` is (carry-forward **C-14.2**) | `Preamble` on the cycle a first source word is accepted; or, if that word was already accepted on §7's early-acceptance cycle before the gap was served, on the cycle after `Idle` is entered (carry-forward **C-16**) |
| `Preamble` | a first source word is accepted | emits the REQ-201 word; seeds the CRC register to 0x00000000; keeps `tx_tready` = 1 | `Frame`, always, after exactly one cycle |
| `Frame` | the cycle after `Preamble` | transmits source words; enables the CRC update on every cycle covering ≥ 1 octet; counts transmitted frame octets; requires a source word on every cycle `tx_tready` = 1 | `Pad` if `tlast` arrived below 60 octets; `Fcs` if the count has reached 60 at `tlast`; `Abort` on underflow |
| `Pad` | `tlast` below 60 octets | transmits zero octets, covered by the CRC, until 60 | `Fcs` |
| `Fcs` | the last frame or pad octet is transmitted | transmits the four FCS octets least significant first, then the terminate character in the next lane and `/I/` to the end of the word | `Gap` |
| `Abort` | underflow (REQ-206) | transmits the words already accepted, then one word carrying `/E/` in lane 0 and `/T/` in lane 1 with `/I/` in lanes 2–7; appends **no** FCS | `Gap` |
| `Gap` | a terminate character has been emitted | emits `/I/`; counts the gap from the terminate character inclusive against `cfg_ifg`, rounding up to the next lane-0 boundary | `Idle` when the gap is satisfied |

The CRC register's **enable** is the mechanism ADR-0007 records: asserted only
in `Frame` and `Pad`, and only on cycles covering at least one octet, so
`octet_count` is always inside M02's 1-to-8 domain.

**Accepting the next frame's first word before `Idle` is entered** (carry-forward
**C-16**). §7 pins `tx_tready` = 1 on the cycle after the frame's `tlast` word
is accepted — C+8 in §6.1's table — and that cycle is in `Frame`, `Pad` or `Fcs`
depending on the frame's length, none of which is `Idle`. A source word
presented there is the **next** frame's first word: M04 accepts it into the
storage slot the current frame vacates on the same cycle and holds it. The
acceptance changes no state of the frame in progress and starts no frame — it is
`Idle`, entered when the gap has been served, that releases it, which is the
second half of the `Idle` row's "Leaves to" cell above. No other state accepts a
first source word, and no cycle other than that one is an early acceptance.

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
5. **The outcome of changing `cfg_tx_enable` or `cfg_ifg` on the exact cycle of
   the event that samples it** — the frame boundary for `cfg_tx_enable`, the
   terminate character for `cfg_ifg` (§4.3, carry-forward **C-14.5**). §4.3
   governs a change landing at least one cycle before its sampling event; the
   same-cycle case is left open by that wording and is left open deliberately
   here. A bench that changes either input on the sampling event's own cycle and
   asserts either outcome is flaky by construction and SHALL NOT be written.

## 7. Timing contract

- **Latency. Two constants, and naming which is which is the requirement**
  (`FINDING AP-M04-1`, §13). M04 inserts eight octets ahead of every frame and
  removes none, so the delay between the two **events** REQ-210 names and the
  **per-octet** latency requirements.md §0.5 defines are different quantities
  with different values. Both are pinned here; neither may be measured against
  the other's figure.

  | Quantity | Value | Measured between |
  |---|---|---|
  | **REQ-210's event delay** | **1 cycle = 8 octet times** | the cycle on which `tx_tvalid` and `tx_tready` are both 1 for the frame's first word, and the cycle of the XGMII word whose lane 0 carries `/S/` |
  | L (octet times), §0.5 | **16** | the octet time of a frame octet on the source stream, and the octet time of that same octet on the XGMII lane pair |
  | h (octet times) | **0** | — |
  | Word delay ΔC = (L + h)/8 | **2** cycles | the cycle of the source word carrying the frame's first octet, and the cycle of the first XGMII word carrying an octet **of the frame** |
  | §1.1 ceiling | **none** — M04 is not on REQ-006's chain | — |

  **Why h is 0 at a module that inserts.** requirements.md §0.5's front offset is
  the offset to the first octet the module emits for that frame *at that same
  input*; the preamble and SFD octets entered on no input, have no input octet
  time and are not octets of the frame, so the first octet the definition reaches
  is the frame's own first octet and h = 0. ΔC therefore counts to the first
  output word carrying an octet **of the frame** — the word after the preamble
  word — and not to the preamble word itself. (L + h) = 16, a multiple of 8 as
  §0.5 requires.

  **The two figures, derived both ways and shown to agree.** Frame octet `j` is
  accepted in source word `⌊j/8⌋` at cycle `C + ⌊j/8⌋`, byte position `j mod 8`,
  so its input octet time is `8C + j`. §6.1 transmits a word accepted at `C + m`
  on cycle `C + m + 2`, lane = byte position (REQ-012, no rotation), so its
  output octet time is `8C + 16 + j`: **L = 16 for every frame octet, of every
  frame, at every length.** By the identity, ΔC = (16 + 0)/8 = 2, which is
  (C + 2) − C — the first XGMII word carrying frame octets against the source
  word carrying frame octet 0. REQ-210's 8 is the *other* pair of events, one
  output word earlier, and it is exactly 8 × 1 octet times because REQ-201 puts
  every start character in lane 0, so both of its events sit at octet position 0
  of their words. **The two differ by exactly the preamble word.**

  **A monitor asserting 8 per octet fails a conformant M04 at every octet of
  every frame**, which is the bench `AP-xgmii_tx_64` row `M04-J3` forbids and the
  finding this bullet answers. Both constants may be asserted, each against its
  own figure. M04 passes both of §0.5's tests — straddle, **(h − q) ≡ 0 (mod 8)**,
  both terms 0 here because M04 removes nothing and inserts a whole number of
  words, and late
  decision (its output framing is decided by the source word it is transmitting,
  never by a later one) — and that is what makes L single-valued at all: no output
  word is assembled from two source words, so no output word can carry two
  latencies.

  **What those two verdicts do not license is an idle-injection bench at this
  port** (`FINDING AP-M04-2`, §13). This bullet claimed until 2026-08-11 that,
  *"unlike every straddling receive module"*, M04's per-octet constant *"does
  survive REQ-016's idle injection"* — a claim about a stimulus class this
  specification twice declares has no instance here. REQ-016 carves this
  interface out in its own text, §3's REQ-016 row says so again, and a source
  word required and not presented is REQ-206's **underflow**: the frame ends in
  `/E/` then `/T/` with no FCS (§9), so there is no frame left whose per-octet
  constant could survive anything. **A bench SHALL NOT build a REQ-016
  idle-injection wrapper at this module's source interface**: the first injected
  cycle on a required cycle is an underflow, and a monitor measuring L across it
  measures a frame the injection destroyed. The survival question **does not
  arise at this module**, and the two verdicts are recorded here for what they do
  buy — L single-valued on this module's own domain, a frame whose source words
  are presented on the cycles the transmitter requires them
  (`AP-xgmii_tx_64` §6's REQ-016 row records the same absence from the bench
  side, and the two documents now agree).

  M04 is not a receive-path module: requirements.md §1.1 allocates it no
  ceiling and REQ-006's budget does not contain it. No requirement constrains
  the *value* of either constant — only that each is one. The event delay is
  pinned at 1 cycle because that is the minimum an inserted preamble word
  permits (§6.1), and changing it later is an ordinary spec diff with no budget
  consequence; L moves with it, by 8 octet times per cycle.

  Back-to-back transmission legitimately delays a start character until the gap
  is served, and REQ-210 puts that outside its domain.

- **Throughput.** One source word accepted per cycle while `tx_tready` is 1;
  one XGMII word emitted every cycle, always. With the default gap, minimum
  length frames go out at exactly one per 11 cycles and no inter-frame spacing
  differs from 11 (REQ-209) — a consequence of REQ-204's lane-0 rounding, not
  an independent design choice.

  **When `tx_tready` is 0, stated so that it agrees with §6.1's own table**
  (carry-forward **C-14.1**). It is 0 on the FCS word and on the terminate word,
  because M04 has no slot to put a further word in. It is **1 again on the last
  cycle of the gap** — C+11 in §6.1's table, which is *inside* the gap — because
  a word accepted there has its preamble emitted on the next cycle, exactly on
  REQ-204's rounded lane-0 boundary; REQ-209's 11-cycle cadence is unachievable
  otherwise, and §6.1's table has shown that cycle asserted since the spec was
  written. On the earlier cycles of a longer gap the value is unconstrained by
  this bullet and governed by §6.3 item 3, bounded by two obligations that no
  choice may break: REQ-207 (never accept a word M04 cannot then transmit) and
  REQ-204 (an acceptance may not force the next start character earlier than the
  rounded gap allows). It may also be 1 during the preamble word, because the
  two-word depth of §6.1 absorbs exactly that one slot.

  *The sentence this replaces read "`tx_tready` is 0 during the FCS word, the
  terminate word and the gap", which contradicted §6.1's table, §6.3 item 3 and
  REQ-209 at once. A bench built from it alone would assert `tx_tready` = 0 at
  C+11 and fail every conformant design.*

  **The cycle after the frame's `tlast` word is accepted — C+8 in §6.1's table —
  and what M04 does with a word presented there** (carry-forward **C-16**,
  dv_lead). The bullet above says when `tx_tready` is 0 and pins the gap's last
  cycle at 1; it did not state this cycle, and the composed transmit cadence
  turns on it. `tx_tready` is **1** there, as §6.1's table has asserted since
  this specification was written, and four things follow that a bench needs:

  1. **Nothing of the current frame may be presented on that cycle, so
     `tx_tvalid` = 0 there is not an underflow.** REQ-206's condition, stated in
     §9 and in the handshake bullet below, ends at the acceptance of the frame's
     `tlast` word — which happened at C+7. C+8 is therefore a legal offer with
     no obligation behind it, and this is the one cycle in a frame's life where
     `tx_tready` = 1 with `tx_tvalid` = 0 means nothing at all.
  2. **A word presented there is the next frame's first word and M04 accepts
     it.** It takes the storage slot the current frame's word 6 vacates on that
     same cycle, so §6.1's two-word depth is unchanged: at the end of C+8 M04
     holds the `tlast` word and the new frame's word 0. REQ-207 then binds as it
     always does — the accepted word **is** transmitted, at C+13, the cycle after
     the next frame's start character.
  3. **The acceptance does not move the start character.** §6.1's "a source word
     accepted on cycle C + m is transmitted on C + m + 2" is stated for a frame
     whose first word is accepted into an idle transmitter with the gap already
     served; back to back it is REQ-204's rounded gap, and not M04's depth, that
     fixes the start character — the REQ-210 bullet above already says so. The
     terminate character is at C+10, so the next start character is at **C+12**
     whether that frame's first word was accepted at C+8 or at C+11, and
     REQ-209's eleven cycles hold either way.
  4. **The two cycles cannot both fill both slots.** If a word was accepted at
     C+8, the word accepted at C+11 is that frame's *second* word and
     `tx_tready` is 0 on the preamble cycle C+12; if none was, the word accepted
     at C+11 is its first and `tx_tready` **may** be 1 at C+12 — which is what
     the "may also be 1 during the preamble word" sentence above is carrying.
     Either way M04 holds at most two accepted, untransmitted words.

  *Why this value is load-bearing rather than tidy.* SPEC-M07 §6.2's `Idle` row
  asserts `payload_tready` only on a cycle with `tx_tready` = 1, and M07
  re-enters `Idle` at C+8 — the cycle after M04 accepted its `tlast` output word
  at C+7. C+8 is therefore the only cycle in the window at which M07 can accept
  the next frame's first payload word and still present its output word 0 by
  M04's next acceptance at C+11. Were `tx_tready` 0 there, M07 would accept at
  C+11, emit output word 0 at C+12, M04 would accept it at C+12 and emit the
  start character at C+13: **twelve** cycles between start characters, failing
  REQ-209 and failing the composed assertion SPEC-M07 §8 and SPEC-M09 §8 item 5
  commission. In the composed chain M07 presents nothing at C+8 — its output
  word 0 leaves at C+9 and is accepted at C+11, exactly as §6.1's table shows —
  so case 2 above is reached only by a bench driving M04 directly from a
  continuous source, which is what §8's REQ-209 run does.

- **Handshake rules.** A word is accepted on a cycle with `tx_tvalid` = 1 and
  `tx_tready` = 1, and an accepted word is always transmitted (REQ-207). Field
  stability is the source's for the cycle of acceptance only; M04 registers
  what it accepts. `tx_tlast` ends the frame — M04 needs no declared length.
  **REQ-016's idle tolerance does not apply to this interface**: on any cycle
  after the start character has been emitted and before the frame's `tlast`
  word has been accepted, `tx_tready` = 1 with `tx_tvalid` = 0 is an underflow
  (REQ-206, §9), not a gap.

- **Reset.** While `clear` = 1 and on the first cycle after it returns to 0:
  `tx_tready` = 0, `error_underflow` = 0, and the lanes carry idle. This clause
  **wins over §6.2's `Idle` row**, which states `tx_tready` = `cfg_tx_enable`
  for every other cycle of that state (C-14.2). `clear` asserted mid-frame
  abandons the frame on the wire with **no** terminate character and **no**
  strobe — the frame simply stops, which is REQ-009's explicit permission and is
  the only silent frame loss in this specification.

  A frame **presented** on the first cycle after `clear` returns to 0 is
  transmitted correctly, and the mechanism is worth one sentence because a
  reader can otherwise not reconcile it with `tx_tready` = 0 on that cycle: the
  word is not *accepted* there, the source holds `tvalid` and the word stable
  until acceptance (the handshake bullet above), and M04 accepts it on the
  following cycle. Nothing is lost and nothing is duplicated; the frame is
  delayed by one cycle, which no requirement forbids (REQ-210 measures from the
  first **accepted** word).

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
condition is decidable, and inside requirements.md §0.6's window, whose
reference word for a condition reported on the **non-arrival** of an input word
is that same cycle (§0.6's fourth clause, carry-forward **C-5**, closed at
§11.3). The pin therefore sits at the window's near edge and the window adds
nothing to it: a bench that wants this cycle asserts this cycle. The wire
consequence follows two cycles later, when the missing word's transmit slot
arrives; a bench must not expect the strobe and the `/E/` on the same cycle.

**No FCS on an underflowed frame, stated because the alternative is worse.**
Appending a valid FCS to a truncated frame would put a **well-formed short
frame** on the wire, which the link partner would accept as a real frame with
a real (wrong) length. The `/E/` before the terminate character is what makes
the truncation visible to a receiver, and it is what M03 detects as REQ-105 at
the other end of a loopback.

**Co-occurrence.**

- `error_underflow` with `error_tx_length_mismatch` (REQ-709): two modules'
  reports of one event, **ordered and unpinned — not simultaneous**.
  `error_tx_length_mismatch` pulses first, at M18, on the cycle M18 accepts the
  short `tlast` (SPEC-M18 §9); `error_underflow` pulses here, later, on the first
  cycle M04 requires a word the path can no longer supply — later by the number of
  words in flight between M18 and M04, which depends on how far M15's drain had
  progressed. **Neither the separation nor a bound on it is pinned**, and a bench
  asserts **one pulse of each per under-delivered frame** and nothing about their
  relative timing (ADR-0011; requirements.md REQ-709's verification column;
  SPEC-M18 §9, which says the same from the other end). When the application
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
| REQ-009 | `clear` abandons the frame and holds `tready` low, overriding §6.2's `Idle` row on those cycles | §6.2, §7 | reset test: assert mid-frame, deassert, present a word on the first cycle after and assert it is accepted on the **second**, with the frame transmitted intact (C-14.2) |
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
| REQ-209 | one minimum-length frame per 11 cycles at the default gap, which requires `tx_tready` = 1 on the gap's last cycle **and** on the cycle after the `tlast` word is accepted | §6.1, §7 | 10 000-frame sustained bench; mean 11 **and** no spacing differing from 11. A bench SHALL NOT assert `tx_tready` = 0 across the whole gap — §6.1's table asserts it at C+11 and REQ-209 needs it there (C-14.1) — and SHALL NOT assert it 0 at C+8, which §6.1's table also asserts and on which SPEC-M07's composed cadence turns (C-16). Driven from a continuous source, this bench accepts the next frame's first word at C+8 and its second at C+11; the start characters are 11 cycles apart either way (§7) |
| REQ-210 | **two constants, named**: an event delay of 8 octet times (1 cycle) from the first accepted word to the start-character word, and §0.5's per-octet latency L = 16 with h = 0 and ΔC = 2 | §7 | latency measurement over several frame lengths, each into an idle transmitter after the gap has elapsed: the **event** interval equals 1 cycle at every length. A bench **SHALL NOT** assert 8 octet times **per octet** — a conformant M04 delivers 16 at every octet of every frame, so that assertion fails every conformant design (`FINDING AP-M04-1`, `AP-xgmii_tx_64` row `M04-J3`). Where the per-octet latency is asserted at all it is asserted against **16**, and the tagger's domain is the **frame** octets only: pad and FCS octets entered on no input and have no input octet time (row `M04-J4`) |
| REQ-802, REQ-810 | `cfg_ifg` and `cfg_tx_enable` sampled per §4.3 | §4.3 | `cfg_tx_enable` = 0 with a request pending: no start character, `tready` low; re-enable and check the frame goes out |
| REQ-903, REQ-808 | `xgmii_tx_64` is a distinct emitted module with `create`, `hierarchical` and an `.mli` | §4.1 | repository surface check and the `rtl_snapshots/` name comparison |

This table is the source of M04's rows in [`traceability.md`](../traceability.md),
updated in the same commit.

## 11. Deferred items

| # | Item | Status · what a reader assumes meanwhile | Tracked as | Owner | Closes by |
|---|---|---|---|---|---|
| 11.1 | **`Axi64.Dest`'s field name `tready` is witnessed here for the first time** (§4.1), completing the `Source` half witnessed in SPEC-M03. | **CLOSED (WO-0010).** CI `build` run 30729342467 at f78766e reports `success` with this lift in it, so `tready` is spelled as SPEC-M01 §4.2 writes it. SPEC-M01 §11.4 closes with the same run. | SPEC-M01 §11.4 | architect_docs_lead, rtl_lead | closed |
| 11.2 | **REQ-206's underflow remedy interacts with REQ-207's no-drop rule**, and this specification resolves it by transmitting the already-accepted words before the `/E/`. Nothing in requirements.md says which wins. | **CLOSED (WO-0010) as *confirmed*.** dv_lead confirmed the resolution and recorded it as **compelled** rather than chosen — REQ-207's "SHALL NOT drop a word it has accepted" is unconditional and REQ-206 nowhere requires the accepted words to be dropped — so no requirements.md diff is owed under either reading. | WO-0008 Return log; WO-0010 Return log §(d) ruling 4 | architect_docs_lead, dv_lead | closed |
| 11.3 | **Carry-forward C-5**: requirements.md §0.6's strobe window bound is vacuous for `error_underflow`, because its "latency in cycles after the input word carrying the last octet of the offending frame" is not defined for a frame that never receives that octet. | **CLOSED (2026-08-11).** requirements.md §0.6's reference-word rule gains a **fourth clause**, for a condition reported on the **non-arrival** of an input word: the reference word is the cycle the word was required and not presented, the ceiling adds §0.5's word delay ΔC (2 here — never REQ-210's 1-cycle event delay, §7), and the clause states in its own words that the window carries **no independent information** at this module because §9's pin sits at its near edge. The deferral's reading — this specification does not depend on the window — is unchanged and is now §0.6's own statement rather than this row's assurance; what the repair removes is the trap the deferral left standing, a reader of §0.6 alone finding a window with no referent, applying it, and getting a green that means nothing (`AP-xgmii_tx_64` §8 item 3). §9 carries the cross-reference. **Correction to this row's own raised statement, 2026-08-11, and to the sentence just above it (`FINDING ABS-1`, dv_lead, `J-dv_lead-0173` §(c), ruled at `J-architect_docs_lead-0040`; requirements.md §13).** The statement in the first column — *"is not defined for a frame that never receives that octet"* — is **false**, and so is the *"window with no referent"* reading of the closure it produced. Since 2026-08-04 §0.6's first clause names *"the last octet that frame **received while it was open**"*, and an underflowed frame has always accepted at least one word (REQ-206 dates the underflow after the start character; §6.1 emits that character only once a first word has been accepted), so the first clause always names a word here: the input word carrying the last octet accepted. §0.6's fourth clause is therefore an **override** of the first and not a hole-filler, and it now says so. **The closure does not move and neither does the reading**: the reference word, the ceiling's ΔC and the no-independent-information statement are exactly as countersigned, and the override only **loosens** — this window strictly contains the one the first clause would give, with §9's pin at the floor of both. The raised statement is left standing as raised (SPEC-TEMPLATE §11: item numbers and their statements are permanent) and corrected here, where a reader of the row meets it; it is also the likely source of the same misreading in dv's own `AP-xgmii_tx_64` row `M04-G7`, which is dv's to repair. | ledger **C-5**; requirements.md §13 (2026-08-11, both rows); `FINDING ABS-1` | architect_docs_lead | closed |
| 11.4 | **Three readings this specification carried that a bench would have failed a conformant design on**: §7 said `tx_tready` = 0 "during the gap" while §6.1's table asserts it at C+11 and REQ-209 requires it there; §6.2's `Idle` row said `tx_tready` = `cfg_tx_enable` without §7's reset exception; and §4.3 left the same-cycle configuration change unconstrained only by implication. | **CLOSED (WO-0011).** §7's throughput bullet now states exactly when `tx_tready` is 0 and why the gap's last cycle is 1; §6.2's `Idle` row carries the reset exception and §7's reset bullet says it wins; §6.3 item 5 makes the same-cycle case explicit. `error_underflow`, the FCS, the gap arithmetic and the interface record are untouched. | ledger **C-14** (readings 1, 2 and 5) | architect_docs_lead | closed |
| 11.5 | **§7's amended `tx_tready` bullet was correct but not complete**, and the cycle it left uncovered — C+8 in §6.1's table, the cycle after the frame's `tlast` word is accepted — is the one the composed 11-cycle transmit cadence turns on. §6.2 had no state that accepted a source word there and §6.1's C + m + 2 transmit rule could not hold for one, so a reader had only §6.1's table asserting the value and nothing saying what it meant. | **CLOSED (WO-0014).** §7 pins the value and states four consequences: it is not an underflow cycle, a word presented there is the next frame's first, the acceptance does not move the start character, and the C+8 and C+11 acceptances cannot both fill both storage slots. §6.2's `Idle` row and the paragraph below its table carry the acceptance; §10's REQ-209 hook forbids the assertion that would fail a conformant design. | ledger **C-16** | architect_docs_lead | closed |

## 12. Freeze record

Filled in at `P1-spec-freeze`. All four rows are required (charter §5).

| Item | Value |
|---|---|
| Interface compile check | CI `build` run **30729342467**, conclusion **`success`**, SHA **f78766e**; per ADR-0005 a local build is not acceptable evidence. This run carries §4.1's `Dest.tready` witness, closing §11.1 and SPEC-M01 §11.4 |
| Architect signature | `J-architect_docs_lead-0004` |
| dv_lead testability countersignature | `J-dv_lead-0005` (WO-0010) — **SIGNED**, batch B, "with C-14.1, the sharpest of the editorial diffs" |
| Frozen at | SHA **f78766e**, gate `docs/gates/P1-spec-freeze-checklist.md` |

## 13. Change log

Post-freeze changes only. Each row cites the ADR that authorised it; a breaking
interface change is counted against post-freeze churn (charter §6). **No row
below is breaking**: §4.1's record is byte-for-byte unchanged since the freeze
SHA, so the `ifc_check` evidence of §12 still witnesses this revision's
interface.

| Date | Change | Breaking? | ADR | Journal |
|---|---|---|---|---|
| 2026-08-02 | §7 throughput bullet: "`tx_tready` is 0 during … the gap" replaced by the exact rule, with the gap's last cycle asserted and the two obligations bounding the earlier gap cycles named (ledger **C-14.1**) | no | none — §6.1's cycle table and REQ-209 already carried the governing reading; this removes the contradiction | `J-architect_docs_lead-0005` |
| 2026-08-02 | §6.2 `Idle` row and §7 reset bullet: the reset clause is stated as the exception to `tx_tready` = `cfg_tx_enable` and as the winner, and the first-cycle-after-`clear` frame is explained (ledger **C-14.2**) | no | none — §7 already governed; the `Idle` row was incomplete | `J-architect_docs_lead-0005` |
| 2026-08-02 | §4.3 and §6.3 item 5: a configuration change landing on its own sampling cycle is deliberately unconstrained (ledger **C-14.5**) | no | none — makes an implication explicit so no bench asserts on it | `J-architect_docs_lead-0005` |
| 2026-08-02 | §7 throughput bullet completed for the cycle after the `tlast` word is accepted (C+8): the value is 1, a word presented there is the next frame's first and is accepted into the vacated slot, the start character stays at C+12 under REQ-204, and the C+8/C+11 pair cannot exceed the two-word depth. §6.2's `Idle` row gains the second entry condition and the table gains a paragraph; §10's REQ-209 hook gains the corresponding prohibition (ledger **C-16**) | no | none — §6.1's cycle table already asserted the governing value and §7's REQ-210 bullet already permitted a delayed start character; this states what a word presented there does, which nothing said. No §4 record, no strobe, no gap arithmetic and no latency constant moves | `J-architect_docs_lead-0006` |
| 2026-08-02 | §9 co-occurrence bullet: `error_underflow` and `error_tx_length_mismatch` no longer "pulse **together**" — they are stated as **ordered and unpinned**, M18's first on the cycle it accepts the short `tlast` and M04's later by an unpinned number of cycles that depends on M15's drain, with a bench asserting **one pulse of each per under-delivered frame** and nothing about the separation (ledger **C-31**) | no — no strobe, port, record, state, cycle table or latency constant moves; the bullet is brought into agreement with what two committed documents already say of it | **ADR-0011**, whose Consequences bullet ("it now says ordered-and-unpinned") and whose Affects header both assert this diff and are the authority for its wording; dv_lead's owed item **C-31**, preferred repair (WO-0020 Return log, answer (7)) | `J-architect_docs_lead-0009` |
| 2026-08-11 | §7's latency bullet and §10's REQ-210 hook: the **two** constants are separated and both pinned — REQ-210's **event delay** of 1 cycle (8 octet times) between the acceptance handshake and the start-character word, and requirements.md §0.5's **per-octet** latency **L = 16** with **h = 0** and **ΔC = 2**, derived both ways and shown to agree and to differ by exactly the preamble word. §7 states why h is 0 at a module that inserts (an inserted octet entered on no input and has no input octet time) and records that M04 passes both of §0.5's tests, so its per-octet constant survives idle injection. §10's hook forbids the assertion that fails a conformant design (`FINDING AP-M04-1`, dv_lead) | no — no port, record, state, cycle table, strobe, gap figure or pinned value moves; the 1-cycle event delay is the same number it has been since the freeze and L = 16 was always what §6.1's `C + m + 2` implied. What changes is that both quantities are named and neither can be measured against the other's figure | none — the reading the diff removes is arithmetically unsatisfiable rather than rejected, so nothing is chosen; the live alternative (repair §7's 8 to 16 instead of REQ-210's opening clause) is recorded and refused in `requirements.md` §13's row of the same date | `J-architect_docs_lead-0038` |
| 2026-08-11 | **`FINDING AP-M04-2` SUSTAINED — §7's new closing sentence claimed a survival over a stimulus this specification twice declares has no instance here, and it is struck.** The sentence read that M04 passes both of §0.5's tests *"so unlike every straddling receive module its per-octet constant **does** survive REQ-016's idle injection"*. The two verdicts are right and are kept — they are why L is single-valued at all — but the conclusion has no instance at this port: REQ-016 carves this interface out in its own text, §3's REQ-016 row says so again, and a required source word not presented is REQ-206's underflow, which ends the frame in `/E/`+`/T/` with no FCS. The hazard is the one `FINDING AP-M04-1` had just convicted a requirement for — a bench writer reading §7 is invited to build an injection wrapper at a port where the first injected cycle destroys the frame the monitor is measuring — so the repair states the vacuity and adds the prohibition at the site that produced the invitation. §9's strobe-cycle paragraph gains §0.6's fourth-clause cross-reference and §11.3 closes carry-forward **C-5** in the same diff | no — no strobe, port, record, state, cycle table or latency constant moves; L, h, ΔC, the event delay and the prohibition on cross-measuring are untouched, and no committed test changes meaning (M04 has no bench). **dv_lead's countersignature is not owed**: dv's own countersignature of §7 at `J-dv_lead-0170` §(a) carved this sentence out by name and §(b) requested the diff. If the added bench prohibition reads wider than dv intends, that is a fresh finding and takes a narrow round | none — the struck claim was vacuous rather than chosen among alternatives, so there is no rejected design to record; dv_lead's **`FINDING AP-M04-2`** (MINOR), `J-dv_lead-0170` §(b), routed undecided | `J-architect_docs_lead-0039` |
| 2026-08-11 | **§11.3's raised statement is corrected in its own Status column — the closed item was closed on a true reading and raised on a false one** (`FINDING ABS-1`, dv_lead, `J-dv_lead-0173` §(c), ruled at `J-architect_docs_lead-0040`). C-5 was raised as *"requirements.md §0.6's strobe window bound is vacuous for `error_underflow`, because its 'latency in cycles after the input word carrying the last octet of the offending frame' is not defined for a frame that never receives that octet"*. That premise died on **2026-08-04** (`0caf023`), when §0.6's first clause was glossed as naming *"the last octet that frame **received while it was open**"*: an underflowed frame has always accepted at least one word — REQ-206 dates the underflow after the frame's start character, and §6.1 emits that character only once a first source word has been accepted — so the first clause always names a word here and the bound was determinate all along, merely measured from the wrong event. §0.6's fourth clause is an **override** of the first, not a hole-filler, and requirements.md now says so. **Nothing this specification pins moves**: §9's `error_underflow` pin, its cross-reference to the fourth clause, ΔC = 2, REQ-210's event delay and every cycle in §6.1's table are untouched, and the corrected reading only **loosens** the §0.6 window (the override moves the reference later, so the new window strictly contains the old and §9's pin sits at the floor of both). The item's first column is left as raised, per SPEC-TEMPLATE §11's permanence rule, and the correction is written where a reader of the row meets it — this row exists because a correction that lives only in another document is one a reader of this one never sees, and because §11.3's raised wording is the likeliest source of the identical misreading in dv's own `AP-xgmii_tx_64` row `M04-G7` | no — **editorial, and not behavioural either**: no conformant design changes, no bench exists at this module, and the only bound the correction moves moves outward | none — a false recital under a true closure is a correction of record, not a choice between designs; requirements.md §13's 2026-08-11 `ABS-1` row carries the ruling | `J-architect_docs_lead-0040` |
| 2026-08-11 | **§7's straddle-test citation re-pinned to §0.5's amended keying — the one site in any module specification that prints the test's condition in symbols rather than evaluating it at a number.** The verdict paragraph read *"M04 passes both of §0.5's tests — straddle (h ≡ 0 mod 8) and late decision"*; the test is now **(h − q) ≡ 0 (mod 8)** (requirements.md §13's 2026-08-11 `C-RL-8` row) and the citation carried its retired form. It now names the amended condition and states that both terms are 0 here, M04 removing nothing and inserting a whole number of words — which is dv_lead's own measurement at the countersignature, made by two independent routes (positional: frame octet 0 at lane 0 of `C + 2`; modular: 8 mod 8), `J-dv_lead-0180` §4. **No verdict, constant or cell moves**: M04 passed the straddle test before the amendment and passes it after, `M04-J1`/`J3`/`J4` are unmoved, and §7's other two `(L + h)` occurrences — the ΔC table row and the *"(L + h) = 16"* derivation — are deliberately **not** touched, being evaluations at this module's own numbers rather than statements of the rule (dv_lead's class-A/class-B boundary at `J-dv_lead-0180` §5, upheld here). Filed inside `FINDING Q-1`'s sweep but **not** in its seven listed sites: dv's census pattern was `(L + h)` and could not reach a straddle-form site. dv_lead's `AP-xgmii_tx_64` §4.D carries the identical retired form in its own lane and is dv's to re-pin (`J-dv_lead-0180` Open-question 2); this row is the spec-side twin, landing first so that re-pin has a repaired source to cite | no — **editorial**: a citation's form, no design and no bench observable | none — the retired keying is arithmetically superseded rather than chosen among live alternatives; requirements.md §13's 2026-08-11 `C-RL-8` row carries the ruling | `J-architect_docs_lead-0042` |
