# SPEC-M03 — `Xgmii_rx_64`

- **Status**: **FROZEN** (`P1-spec-freeze`, SHA `f78766e`) — batch B, dv_lead
  countersignature `J-dv_lead-0005`. Changes to §4, §6 or §7 after this point
  are spec diffs recorded in §13 (SPEC-TEMPLATE rule 7)
- **Inventory id**: M03 (architecture.md §4) · **Path**:
  `libs/hardcaml_ethernet/src/xgmii_rx_64.ml`
- **Datapath role**: receive
- **Owns REQs**: REQ-101, REQ-102, REQ-103, REQ-104, REQ-105, REQ-106,
  REQ-107, REQ-108, REQ-109, REQ-110, REQ-111, REQ-112, REQ-113
- **Prior-art counterpart**: `axis_xgmii_rx_64.v` (MIT) — consulted for
  decomposition and port naming only; behaviour below is stated independently
  and no source was copied
- **Depends on specs**: SPEC-M01 (`Axi64`, `Xgmii`), SPEC-M02 (`Crc32_eth`)
- **Author**: architect_docs_lead, journal `J-architect_docs_lead-0004`

## 1. Purpose

M03 turns the XGMII receive lane pair into a frame stream: it finds the start
character, discards the eight preamble octets, delivers the frame's octets
word-aligned on an `Axi64.Source`, removes the four FCS octets, and marks a
frame the receiver believes to be damaged. It exists as a separate module
because it is the whole of the programme's XGMII decode: every module above it
sees frames and never sees a lane, a control character or a start lane.

Its upstream is the XGMII receive lane pair, driven in Phase 1 by the DV
link-partner model (REQ-018, architecture.md §3). Its downstream is M06
`Eth_axis_rx`. It instantiates M02 `Crc32_eth` and holds the running CRC in its
own registers.

## 2. Scope

**In scope.**

- Start-character detection in lane 0 and lane 4, and the two output alignments
  that follow (REQ-101).
- Preamble and SFD removal — eight octets counted from the start character
  inclusive — without validating their data values (REQ-102).
- Frame extraction and FCS removal (REQ-103), terminate handling in any lane
  (REQ-106).
- The FCS check and its abort marking (REQ-104), using M02.
- The four error conditions that end a frame early or late: error character
  (REQ-105), runt (REQ-107), oversize (REQ-108), start-without-terminate
  (REQ-110), and resynchronisation after each.
- Silence between frames (REQ-109) and indifference to ordered sets and to any
  control character outside a frame (REQ-113).
- Constant per-octet latency at both start lanes (REQ-111) and unconditional
  acceptance of an XGMII word every cycle (REQ-112).

**Not this module's job.**

| Behaviour a reader might expect here | Owner |
|---|---|
| Parsing destination address, source address or ethertype; anything that reads *into* the frame | M06 `Eth_axis_rx` (REQ-401). M03 does not know where the Ethernet header ends and does not look |
| Filtering on destination MAC | nobody — the receive path is deliberately promiscuous (REQ-407) |
| The CRC-32 function itself, its parameterisation and its two constants | M02 `Crc32_eth` (REQ-301 … REQ-306). M03 seeds it, sequences it and compares its result |
| Generating XGMII, measuring the inter-frame gap on receive, or reacting to a gap shorter than 12 octets | nobody on the receive path. Gap generation is M04's (REQ-204); the receive path accepts whatever spacing arrives and REQ-004 fixes the worst case it must survive |
| Emitting the start, preamble, terminate or idle characters | M04 `Xgmii_tx_64` (REQ-201, REQ-205) |
| The link partner that produces these lanes, including every error injection | dv_lead, under `test/` (REQ-018, architecture.md §3) |
| Validating the *values* of the six preamble filler octets and the SFD octet | nobody, deliberately — REQ-102 forbids it, so that a link partner with a nonstandard but legal preamble is not a false failure |
| Buffering a frame until its FCS is known | nobody — REQ-005 forbids it; the abort bit exists because of that (architecture.md §2.1) |

## 3. Programme invariants that bind this module

M03 is a receive-path module under requirements.md §0.4 — it is the first link
of the chain — and its output stream is a receive-path stream.

| REQ | Consequence for M03 |
|---|---|
| REQ-001 | One `clock`. The whole module is synchronous to it; the XGMII pins are sampled on it and there is no second domain (REQ-018 keeps the boundary simulation-only, so no CDC exists to be got wrong). |
| REQ-002 | The output stream is one `Axi64` word, 64 bits, at most one word per cycle. The input lane pair is 64 bits of data plus 8 control bits — one XGMII word per cycle, always present, never gated. |
| REQ-003 | The output is `Axi64.Source` **without** `Axi64.Dest`: M06 cannot stall M03, structurally (§4.1). |
| REQ-004 | M03 is on requirements.md §0.4's stress-bench list. It SHALL sustain minimum-length frames at start-to-start spacings alternating 10 and 11 cycles for 10 000 consecutive frames (§8). |
| REQ-005 | Cut-through: every payload word is emitted at a fixed delay from its input octets and no word is withheld to the end of a frame. The per-octet latency is the constant of §7, at both start lanes. The FCS is removed by `tkeep` and `tlast` placement inside a fixed-delay pipeline, **never** by holding octets back — that is the single design fact that makes REQ-103 and REQ-005 compatible (§6.1). |
| REQ-007 | A frame found invalid after its forwarding has begun is marked `tuser`[0] = 1 on its `tlast` word. M03 is the origin of that bit for the whole receive path: it inherits none. |
| REQ-008 | Every discard M03 performs has a strobe (§9). It owns five of the twenty-one (requirements.md §12). |
| REQ-009 | Synchronous `clear`. On every cycle `clear` = 1 and on the first cycle it is 0, `tvalid` = 0 and all five strobes are 0; a frame in flight is truncated with no `tlast` and no strobe; a frame whose start character arrives on the first cycle after `clear` returns to 0 is received correctly (§7). |
| REQ-010 | The output is the programme `Axi64.Source` (§4.1). The **input** is not a stream and is not required to be one: an XGMII lane pair carries a value on every cycle, so `tvalid`, `tkeep` and `tready` have no meaning there. It is the `Xgmii` record of SPEC-M01 §4.1, not an ad-hoc restatement. |
| REQ-011 | `tkeep` is `0xFF` on every output word except the `tlast` word, where it is 1 to 8 contiguous ones from bit 0. The `tlast` value is decided by the terminate lane and by which of §9's conditions ended the frame. |
| REQ-012 | XGMII lane k is `xgmii_rxd`[8k+7:8k]; the frame octet in lane k is placed at the corresponding `tdata` position of its output word. Lane 0 is the earlier octet on the wire, and so is `tdata`[7:0]. |
| REQ-013 | `tuser`[0] means "found invalid, discard at the end". M03 sets it and never reads it. |
| REQ-014 | `tstrb` is driven to 0 on every output word. |
| REQ-015 | One `tlast` per frame; at most **190** words between two `tlast` words on this stream (1514 octets, REQ-108), at least one. |
| REQ-016 | The output may carry idle cycles inside a frame only where the input did — an XGMII word carrying no frame octet, which inside an open frame is an idle cycle the stimulus injected (§10 commissions injection at 0, 1 and 7 cycles) and **not** a lane-4 start, whose second preamble word carries frame octets 0–3 (§6.1, carry-forward **C-18**). Downstream must tolerate them; M03 never inserts one for its own reasons. |
| REQ-017 | M03's wire-side ports are the receive half of the four REQ-017 names, declared from SPEC-M01's `Xgmii` record with `[@rtlprefix "xgmii_rx"]`, which emits `xgmii_rxd` and `xgmii_rxc` exactly. |
| REQ-018 | M03 contains no PMA, PCS, 64b/66b, scrambler, link-training or PTP logic, and instantiates no primitive outside the architecture.md §4 inventory (it instantiates M02 and nothing else). |
| REQ-019 | Word delay ΔC = 3 cycles against a ceiling of 4 (requirements.md §1.1), at both start lanes. Payload storage is **two** datapath words — the pipeline of §7 — and no more, which is the depth REQ-019 permits and not a coincidence: the FCS-removal lookahead is exactly one word. |
| REQ-020 | Frames leave in the order their start characters arrived; M03 holds one frame at a time (§6.2) so reordering is not expressible. |
| REQ-021 | The first octet of every frame M03 emits occupies `tdata`[7:0] of that frame's first word, at **both** start lanes. At a lane-4 start this is a real realignment: output word 0 is assembled from two input words. |

## 4. Interface

### 4.1 Interface records

```ocaml
(* SPEC-M03 §4.1, lifted verbatim into docs/specs/ifc_check/xgmii_rx_64_ifc.ml
   (SPEC-TEMPLATE.md rule 6). Records and signatures only — no logic, no
   implementation.

   [Axi64_ifc] is M01's types home (SPEC-M01 §4.1): [Axi64], [Xgmii] and
   [Config] come from there and are restated nowhere.

   The witness at the bottom is not circuit logic — this library is never
   instantiated and emits no hardware. It is the compile-time check
   REQ-010's verification column prescribes, extended to name every field
   of [Axi64.Source] so that SPEC-M01 §11.4 is settled by a CI run rather
   than by transcription: if [hardcaml_axi] v0.17.0 spells any of these
   names differently, this file fails to compile and the divergence is
   found before freeze instead of at the first bench. *)

open! Base
open Hardcaml
open! Axi64_ifc

module I = struct
  type 'a t =
    { clock : 'a
    ; clear : 'a
    ; xgmii_rx : 'a Xgmii.t [@rtlprefix "xgmii_rx"]
    ; cfg_rx_enable : 'a
    }
  [@@deriving hardcaml]
end

module O = struct
  type 'a t =
    { rx : 'a Axi64.Source.t [@rtlprefix "rx_"]
    ; error_bad_fcs : 'a
    ; error_bad_frame : 'a
    ; error_runt : 'a
    ; error_oversize : 'a
    ; error_start_without_terminate : 'a
    }
  [@@deriving hardcaml]
end

module type S = sig
  val create : Scope.t -> Signal.t I.t -> Signal.t O.t
  val hierarchical : ?instance:string -> Scope.t -> Signal.t I.t -> Signal.t O.t
end

(* REQ-010 type identity, and the SPEC-M01 §11.4 field-name witness. *)

let _witness_source_is_the_programme_type (x : Signal.t Axi64.Source.t) = x

let _witness_source_field_names (x : Signal.t Axi64.Source.t) =
  let open Axi64.Source in
  [ x.tvalid; x.tdata; x.tkeep; x.tstrb; x.tlast; x.tuser ]
;;
```

Conformance of this block to the template's rules for §4.1:

- Scalar fields carry `[@bits n]` unless one bit wide: `clock`, `clear` and
  `cfg_rx_enable` are one bit; every other field is inside a nested record that
  carries its own widths (SPEC-M01 §4.1).
- Nested interfaces carry `[@rtlprefix]`: `xgmii_rx` emits `xgmii_rxd` and
  `xgmii_rxc` (REQ-017), and `rx` emits `rx_tvalid`, `rx_tdata`, `rx_tkeep`,
  `rx_tstrb`, `rx_tlast`, `rx_tuser`.
- **Receive-path `Source` without `Dest`: held.** The `O` record contains no
  `Axi64.Dest` and the `I` record contains no `tready`. A future M03 that
  wanted backpressure could not be written without changing this record, which
  is a spec diff — REQ-003, REQ-112.
- Both `create` and `hierarchical` are declared (REQ-903, REQ-808).

### 4.2 Port table

Every port in §4.1 appears exactly once.

| Port | Dir | Width | Meaning | REQ |
|---|---|---|---|---|
| `clock` | in | 1 | 156.25 MHz single domain | REQ-001 |
| `clear` | in | 1 | synchronous clear | REQ-009 |
| `xgmii_rxd` | in | 64 | eight XGMII lanes; lane k is bits [8k+7:8k], lane 0 the earlier octet on the wire | REQ-012, REQ-017 |
| `xgmii_rxc` | in | 8 | bit k marks lane k as a control character: `/I/` 0x07, `/S/` 0xFB, `/T/` 0xFD, `/E/` 0xFE, `/Q/` 0x9C (requirements.md §2) | REQ-017, REQ-113 |
| `cfg_rx_enable` | in | 1 | `Config.rx_enable`; when 0 no frame is accepted (§6.1, REQ-810) | REQ-802, REQ-810 |
| `rx_tvalid` | out | 1 | this cycle carries a word of the received frame | REQ-016 |
| `rx_tdata` | out | 64 | frame octets, word-aligned at the first octet of the frame | REQ-012, REQ-021 |
| `rx_tkeep` | out | 8 | valid octet positions, contiguous from bit 0 | REQ-011 |
| `rx_tstrb` | out | 8 | reserved and unused; driven to 0 | REQ-014 |
| `rx_tlast` | out | 1 | this word carries the frame's final delivered octets | REQ-015 |
| `rx_tuser` | out | 1 | bit 0: this frame was found invalid; meaningful only on the `tlast` word | REQ-013, REQ-007 |
| `error_bad_fcs` | out | 1 | one-cycle strobe: received FCS does not match | REQ-104 |
| `error_bad_frame` | out | 1 | one-cycle strobe: error character between start and terminate | REQ-105 |
| `error_runt` | out | 1 | one-cycle strobe: fewer than 64 octets between start and terminate | REQ-107 |
| `error_oversize` | out | 1 | one-cycle strobe: more than 1518 octets between start and terminate | REQ-108 |
| `error_start_without_terminate` | out | 1 | one-cycle strobe: start character before the current frame terminated | REQ-110 |

### 4.3 Configuration inputs

**One field: `rx_enable`**, presented as the scalar input `cfg_rx_enable` under
the programme convention SPEC-M01 §4.2 states (a module declares the `Config`
fields it reads, at §9.1's widths, named `cfg_<field>`; only M20 declares the
whole record).

Effect: when `cfg_rx_enable` = 0, M03 accepts no frame — it treats every start
character as absent, emits no output word, and pulses no strobe (REQ-810). It
is sampled **at the start character**: a frame whose start character is
accepted at least one cycle after the input changes is governed by the new
value, and a frame already in flight completes under the old one (REQ-803). A
change landing on the **same** cycle as a start character is outside that
sentence and is deliberately unconstrained — §6.3 item 7, carry-forward
**C-14.5**.
Gating here rather than downstream is deliberate: REQ-810 requires that *no*
receive-path stream carries a word, and M03 is the only module from which that
follows without every other module implementing the same control.

## 5. Parameters

**None.** M03 has no compile-time parameter. REQ-506's rule — timeouts and
ageing intervals must be parameters so tests can use short values — has no
instance here: M03 has no timeout, no interval and no ageing. The two numeric
constants it does contain, 1518 and 1514, are pinned by REQ-108 and would
diverge from it if they were overridable, and the oversize bench costs one
1600-octet frame, which is not a length a simulation needs shortened.

| Parameter | Type | Default | Range | Why a test overrides it |
|---|---|---|---|---|
| (none) | — | — | — | — |

## 6. Behaviour

### 6.1 Normal path

M03 reads no header field, so there is no field table here: it does not know
where the Ethernet header ends and never looks (§2). What follows is the octet
pipeline.

**Decoding the lane pair.** Lane k of a word is a control character when
`xgmii_rxc`[k] = 1 and its value is `xgmii_rxd`[8k+7:8k]. Only five control
characters have meaning in this programme (requirements.md §2): `/S/` start,
`/T/` terminate, `/E/` error, `/I/` idle and `/Q/` ordered set. A lane that is
not marked control is a data octet, whatever its value.

**Finding the frame.** A start character in lane 0 or lane 4 begins a frame
(REQ-101). The eight octets from the start character **inclusive** are preamble
and SFD and are discarded; their data values are not validated (REQ-102), so
the frame's first octet is always exactly 8 octet times after the start
character. A lane marked control inside those eight positions is not preamble
and is routed by §9: `/T/` to REQ-107, `/S/` to REQ-110, anything else to
REQ-105.

**Emitting the frame.** Frame octet j is emitted at `tdata` position j mod 8 of
output word ⌊j / 8⌋, so the frame's first octet is at `tdata`[7:0] of the first
output word at both start lanes (REQ-021). **On a gapless stimulus** — one in
which the frame's octets occupy **consecutive octet times** from the start
character onward, so that no XGMII word between the start word and the word
carrying the terminate character is an idle word — output word m is emitted on
the cycle **m + 3** counted from the word carrying the start character; that
single sentence is the whole timing contract and §7 derives the latency
constants from it.

*The definition is stated in octet times and not in words, and that is
carry-forward **C-18*** (dv_lead). "Every XGMII word from the start word onward
carrying frame octets" — the wording this replaces — is satisfied by no
stimulus at all: the start word carries the start character and preamble and
never a frame octet, and the terminate word of the 64-octet table below (`/T/`
in lane 0 of cycle 9) carries none either, yet that table is the gapless case
the m + 3 formula is derived from. In octet times the definition is exact and
both words fall outside the span it constrains.

The qualifier is load-bearing and is §0.5's own (carry-forward **C-14.4**). An
input word that covers **no** frame octet — *inside an open frame*, a terminate
character in **lane 0**, or an idle cycle injected by REQ-016's wrapper, which
§10 commissions against this module at 0, 1 and 7 cycles — carries the frame
forward without advancing m: it is *not* a condition, it holds the CRC register
by its enable (§6.2) and it delays every later octet by exactly 8 octet times
per cycle, which is REQ-016's own arithmetic. The **per-octet** constant of §7
holds on every stimulus, gapped or not; the cycle formula above holds only on
the gapless one, and a bench asserting the formula under idle injection would
fail a conformant design.

**Two words that are not instances of that rule, stated because reading them as
instances breaks the FCS check of every frame that has one** (carry-forward
**C-18**):

1. **The second preamble word of a lane-4 start covers four frame octets, not
   none.** At a lane-4 start the preamble runs from lane 4 of cycle 0 through
   lane 3 of cycle 1, and frame octets 0–3 occupy lanes 4–7 of cycle 1 — which
   is what the "same frame at a lane-4 start" paragraph below states. That word
   is therefore in `Frame`, the CRC enable is **asserted** for it with
   `octet_count` = 4, and a design that held the CRC register across it would
   fail the FCS check of every lane-4 frame.
2. **A terminate character in a lane other than 0 leaves frame octets in the
   lanes below it.** With `/T/` in lane k, lanes 0 … k−1 carry frame octets and
   the CRC enable is asserted with `octet_count` = k. Only k = 0 gives a word
   covering no frame octet.

**Removing the FCS without varying the latency.** The last four octets before
the terminate character are the FCS and are not delivered (REQ-103). They are
removed by **not marking them in `tkeep`**, inside a pipeline whose delay is the
same for every octet — never by holding octets back until the frame's end. This
is why the module needs exactly one word of lookahead (the octets of output
word m may be followed by an FCS lying in the next input word) and why its
payload storage is two words and not more (REQ-019). It is also why REQ-103's
"no FCS removal is attempted" cases — a frame aborted under REQ-105, truncated
under REQ-108 or cut short under REQ-110 — cost nothing: the same pipeline
delivers those four octets instead of suppressing them, at the same delay.

**The FCS check, by residue (REQ-104).** M03 holds a 32-bit running value in a
register, in M02's finished-value convention (SPEC-M02 §6.1, ADR-0006):

1. the register is **seeded to 0x00000000** on the cycle before the frame's
   first octet is covered;
2. on every cycle covering at least one frame octet, the register is updated
   through M02 with those octets and `octet_count` set to how many — **1 to 8,
   never 0**. On a cycle covering no frame octet the register is **held** by
   its enable and M02's result is ignored: no update-by-zero is ever driven
   (SPEC-M02 §11.2, ADR-0007);
3. the coverage runs over **every received octet of the frame, the four FCS
   octets included**, and ends with the octet immediately preceding the
   terminate character;
4. the frame's FCS is correct iff that final value equals REQ-304's residue
   **0x2144DF1C**. Any other value sets `tuser`[0] = 1 on the `tlast` word and
   pulses `error_bad_fcs` once.

The residue form is chosen over capturing the four received FCS octets and
comparing them against a CRC over the data alone. Both use M02 unchanged and
neither is observable at the ports (§6.3), so this is a specification choice
made for the reader: the residue form needs no capture register and, decisively,
**no octet-order reassembly of the received FCS** — the exact operation whose
convention error requirements.md §4's provenance note records this programme
already paying for once. It is one equality against one constant that dv_lead
has independently reproduced at five frame lengths (WO-0007).

**Cycle-by-cycle, a minimum-length frame at a lane-0 start.** 64 octets DA
through FCS: 60 delivered, 4 stripped. Cycle 0 is the word carrying the start
character.

| Cycle | XGMII input word | Output |
|---|---|---|
| 0 | `/S/` in lane 0, six 0x55 and one 0xD5 in lanes 1–7 (values not checked) | `tvalid` = 0 |
| 1 | frame octets 0–7 | `tvalid` = 0 |
| 2 | frame octets 8–15 | `tvalid` = 0 |
| 3 | frame octets 16–23 | word 0: octets 0–7, `tkeep` = 0xFF |
| 4–9 | frame octets 24–63, eight per cycle, then `/T/` in lane 0 of cycle 9 | words 1–6: octets 8–55, `tkeep` = 0xFF |
| 10 | idle | word 7: octets 56–59, `tkeep` = 0x0F, `tlast` = 1, `tuser`[0] = 0 for a good FCS |
| 11 onward | idle | `tvalid` = 0 (REQ-109) |

Sixty octets in eight words; the terminate character in lane 0 of cycle 9 means
the previous word carried the last octet (REQ-106), and the four octets before
it (60–63) are the FCS, absent from `tkeep`.

**The same frame at a lane-4 start.** `/S/` is in lane 4 of cycle 0, preamble
continues through lane 3 of cycle 1, and frame octets 0–3 occupy lanes 4–7 of
cycle 1. Output word 0 is assembled from cycles 1 and 2 and is emitted on cycle
3 — **the same cycle as in the lane-0 case**, carrying the same eight octets.
Every subsequent word matches likewise, so the two output streams are identical
as ordered tuple sequences *and* in absolute cycle (REQ-101 requires only the
first; the second is a property of the constants §7 pins, not an obligation, and
a bench SHALL NOT assert it as one for other modules).

**Between frames (REQ-109, REQ-113).** With no frame in flight, idle characters
and ordered sets produce no output word and no strobe. A frame still draining
through the two-word pipeline legitimately produces output words during the
first idle cycles after its terminate character — **up to and including two
cycles after the terminate word, and no later**, which is what a REQ-109 bench
must allow for and no more (carry-forward **C-14.3**).

*Two, not three, and it is derivable rather than asserted.* Let N be the number
of octets between the start and terminate characters, N = 8q + r. At a lane-0
start the terminate character lies at octet offset N from the first frame octet,
so its word is cycle q + 1; the frame delivers N − 4 octets, which is q words
for r ≤ 4 and q + 1 words for r ≥ 5, so the `tlast` word is output word q − 1 or
q and leaves at cycle q + 2 or q + 3 — **one or two cycles** after the terminate
word. At a lane-4 start the same arithmetic gives zero or one. The maximum is
therefore ΔC − 1 = **2**, which is exactly the bound REQ-109's verification
column already uses ("no output activity from 3 cycles after the terminate
character onward") and the bound §10's REQ-109 hook states. A drain window of
ΔC = 3 would be one cycle loose and would let a real drain defect through.

**When `cfg_rx_enable` is 0.** No start character is recognised, so no frame
begins, nothing is emitted and no strobe pulses (REQ-810). Because no frame is
accepted, nothing is discarded and no silent-discard hole opens under REQ-008.

### 6.2 State machine

Reset state and `clear` state are both `Idle`.

| State | Entered when | Does | Leaves to |
|---|---|---|---|
| `Idle` | reset; `clear`; a frame ends normally or is aborted | ignores every lane; `tvalid` = 0; CRC register held | `Preamble` on `/S/` in lane 0 or lane 4 while `cfg_rx_enable` = 1 |
| `Preamble` | a start character is accepted | discards the eight octets from the start character inclusive without checking their values (REQ-102); seeds the CRC register to 0x00000000 | `Frame` once those eight octets have passed; `Idle` on `/T/` (REQ-107, zero delivered octets), on `/E/` (REQ-105, zero delivered octets) or on `/S/` (REQ-110, zero delivered octets — re-entering `Preamble` for the new frame) |
| `Frame` | the frame's first octet | forwards octets at the fixed delay of §7; enables the CRC update on every cycle covering ≥ 1 frame octet; counts received octets for REQ-107 and REQ-108. An input word covering **no** frame octet — a terminate character in **lane 0**, or an idle cycle injected under REQ-016 — **holds** the frame: the CRC register holds by its enable, the octet count holds, no output word is produced and no condition is raised (C-14.4). A word covering **one or more** frame octets is never held, whatever else it carries: a terminate character in lane k > 0 covers k of them, and the second preamble word of a lane-4 start covers four (§6.1's two non-instances, C-18) | `Idle` on `/T/` (REQ-106; runt check on the count, FCS check on the residue); `Idle` on `/E/` (REQ-105); `Preamble` on `/S/` (REQ-110); `Discard` when the received count passes 1518 (REQ-108) |
| `Discard` | REQ-108 truncation | emits nothing further for this frame; keeps decoding lanes so the next frame is not lost. An `/E/` arriving here is **absorbed**: the frame is already closed and already reported by `error_oversize`, so no output word appears and no strobe pulses (REQ-105's open-frame clause, carry-forward **C-12**) | `Idle` on `/T/`; `Preamble` on `/S/` — this is REQ-108's "resynchronise on the next start character". `/E/` is not an exit: whether the implementation stays in `Discard` or falls to `Idle` on it is unobservable and is §6.3 item 6 |

The CRC register's **enable** is the mechanism ADR-0007 records: it is asserted
only in `Frame` and only on cycles covering at least one frame octet, so
`octet_count` is always in M02's 1-to-8 domain.

### 6.3 Deliberately unconstrained

Anything not listed here is constrained by this specification, and a test may
rely on it.

1. **The realisation of the FCS check.** §6.1 specifies it as the residue
   equality. An implementation that instead captures the four received FCS
   octets and compares them against the CRC over the data alone computes the
   **same function** — that is precisely what REQ-304 asserts — and no bench can
   distinguish the two, so DV asserts nothing about which is used. The choice is
   recorded in §6.1 because SPEC-M02 §11.4 asked for it to be specified rather
   than discovered in RTL, not because it is observable.
2. **The placement of the two register levels** inside the pipeline, and every
   internal encoding: the FSM state encoding, how the barrel shift for a lane-4
   start is built, whether the octet counter counts up or down. §7's constants
   are what is fixed.
3. **The response to a start character in a lane other than 0 or 4.** Such a
   word is not legal XGMII, the link-partner model's contract emits start
   characters in lane 0 and lane 4 only (REQ-018), and no requirement names the
   case. DV SHALL assert nothing about it. Constraining it would commission a
   test for a stimulus the programme has decided not to produce.
4. **The value of `tdata` at positions where `tkeep` is 0**, and every output
   field on a cycle with `tvalid` = 0 (SPEC-M01 §6.3 item 5).
5. **Which strobe cycle is used within the §9 window** is *not* on this list:
   §9 pins it exactly, because a one-cycle pulse whose cycle is unconstrained
   is a pulse a bench must search for.
6. **The state M03 occupies after absorbing an `/E/` in `Discard`** (§6.2,
   C-12). The *observable* is pinned — no output word, no strobe, and the next
   start character is received normally — and both candidate encodings
   (`Discard` held, or a fall to `Idle`) produce it identically, because `Idle`
   also ignores every lane and also begins a new frame on `/S/`. DV SHALL
   assert nothing about the internal state.
7. **The outcome of changing `cfg_rx_enable` on the exact cycle a start
   character is accepted** (§4.3, carry-forward **C-14.5**). §4.3 governs the
   frame whose start character is accepted *at least one cycle after* the
   change; the same-cycle case is left open by that wording and is left open
   deliberately here. A bench that changes the input on the start character's
   own cycle and asserts either outcome is flaky by construction and SHALL NOT
   be written; a bench that needs a determinate result changes the input at
   least one cycle earlier or later, which every REQ-810 test can do.

## 7. Timing contract

- **Latency.** Front offset h = **8** octet times at a lane-0 start (the start
  character plus its seven preamble octets) and **12** at a lane-4 start (four
  lanes of the start word precede the start character). The pinned per-octet
  constants (requirements.md §0.5) are

  | Start lane | h | L (octet times) | Word delay ΔC = (L + h)/8 | §1.1 ceiling |
  |---|---|---|---|---|
  | lane 0 | 8 | **16** | **3** cycles | 4 |
  | lane 4 | 12 | **12** | **3** cycles | 4 |

  (L + h) = 24 in both rows, a multiple of 8 as requirements.md §0.5 requires.
  The two constants differ by 4 octet times, inside §0.5's 8-octet-time bound,
  and they differ *because* a lane-4 frame's octets arrive four octet times
  later while its first output word leaves on the same cycle — the difference is
  the start character's position in its word and is not a defect (REQ-111).

  **The two measurement events**, named explicitly: the input event is the
  octet time, on the XGMII lane pair, of the frame octet being measured; the
  output event is the octet time of that same octet on the `rx` stream. For the
  word delay the two events are the cycle of the XGMII word carrying the frame's
  **start character** and the cycle of the **first output word** of that frame —
  REQ-006's own two events at this end of the chain.

  ΔC = 3 leaves one cycle of the §1.1 allocation unspent. That is deliberate:
  M03 is the hardest receive module and the one most likely to need a cycle
  later, and a module pinned at its ceiling turns any future change into a
  slack-release spec diff.

- **Throughput.** One XGMII word accepted every cycle, unconditionally and with
  no handshake (REQ-112). At most one output word per cycle; output words carry
  no idle cycle inside a frame except where the input word carried no frame
  octet.

- **Handshake rules.** `tvalid` = 1 exactly on cycles carrying frame octets.
  `tkeep` is `0xFF` except on the `tlast` word. `tlast` = 1 on the word carrying
  the frame's last delivered octet, **and that word is counted in the frame's
  word total** (REQ-015): a frame of **one** word, whose single word carries
  `tlast`, is legal on this stream and is what a 5-octet runt produces (§9,
  REQ-107, one delivered octet). `tuser`[0] is meaningful only on the `tlast`
  word. At most 190 words between successive `tlast` words, the `tlast` word
  included — 1514 octets is 189 full words and a final two-octet word (REQ-108).
  No header record is emitted, so REQ-401's `valid` pattern has no instance
  here. Idle gaps on the input (REQ-016) delay everything by exactly 8 octet
  times per cycle and change nothing else.

  *This bullet previously forbade a `tlast` word with no preceding word since
  the previous `tlast`, restating a sentence of REQ-015 that contradicted the
  same requirement's own 190-word figure and forbade the very frame REQ-107
  requires. The sentence is deleted from REQ-015 and from here in one diff,
  carry-forward **C-11**, on dv_lead's wording.*

- **Reset.** While `clear` = 1 and on the first cycle after it returns to 0:
  `tvalid` = 0, all five strobes 0, state `Idle`, CRC register value irrelevant
  because the next frame re-seeds it. `clear` asserted mid-frame truncates the
  in-flight output frame with no `tlast` and no strobe (REQ-009) — the one place
  in this specification where a frame vanishes without a strobe, and REQ-009,
  not REQ-008, is what permits it. A frame whose start character arrives on the
  first cycle after `clear` returns to 0 is received correctly.

- **Configuration sampling.** `cfg_rx_enable` is sampled at each start
  character (§4.3, REQ-803).

## 8. Line-rate stress obligation

**Mandatory: M03 is in requirements.md §0.4's stress-bench list.**

The module SHALL be exercised by a bench that drives minimum-length frames at
the REQ-004 arrival rate and checks the four REQ-004 criteria. Written out for
this module so the bench can be built from this section alone:

**Stimulus.** 10 000 consecutive frames, each 64 octets DA through FCS:

| Octets | Content |
|---|---|
| 0–5 | destination MAC `02:00:00:00:00:01` |
| 6–11 | source MAC `02:00:00:00:00:02` |
| 12–13 | ethertype 0x0800 |
| 14–17 | a 32-bit frame sequence number, first frame 0, incrementing by 1, most significant octet at offset 14 (REQ-020's four-octet sequence number) |
| 18–59 | 42 octets of filler; any fixed pattern, stated by the bench and constant across the run |
| 60–63 | the correct CRC-32 FCS, least significant octet first (REQ-202's wire order, REQ-304) |

Framing: eight preamble octets before octet 0, start characters **alternating
lane 0 and lane 4**, one terminate character after octet 63, and the minimum
12-octet inter-frame gap counted from the terminate character inclusive
(requirements.md §0.3) — start-to-start spacing alternating 10 and 11 cycles.
Every frame is one M03 accepts and forwards, so frames-out equals frames-in is
well defined (REQ-004).

**Error injection rate: zero in this run.** The five conditions of §9 are
directed tests, not stress-run noise, because REQ-004's conservation criterion
is stated over frames the module accepts.

**Checks.**

1. 10 000 frames out for 10 000 in; no word dropped; frame conservation holds
   (requirements.md §0.6).
2. The 60 delivered octets of every frame compare equal to the injected octets
   0–59, and the sequence numbers arrive as 0, 1, 2, … with no gap and no
   repeat (REQ-020).
3. Per-octet latency is constant and equals **16** octet times for every
   lane-0-start frame and **12** for every lane-4-start frame (REQ-005,
   REQ-111) — one value per start lane across all 10 000 frames, not a mean.
4. The module exposes no `tready` on the stream under test. This is structural
   (REQ-003, §4.1) — a statement about the type, not an assertion that could
   fail.

**Directed lengths alongside the stress run** (REQ-005, REQ-103): frames of 64
through 71 octets inclusive, which cover all eight `tlast` `tkeep` patterns and
all eight terminate lanes, plus 1518, each at both start lanes.

## 9. Errors and discards

Strobe names are normative (requirements.md §12).

| Condition | Strobe (one cycle) | Stream effect | REQ |
|---|---|---|---|
| Received FCS does not match the computed residue | `error_bad_fcs` | frame forwarded in full, `tuser`[0] = 1 on `tlast` | REQ-104 |
| `/E/` **while the frame is open** — after the start character and before the terminate character or any other event that closed the frame (§9's closure list below) — with ≥ 1 octet already delivered | `error_bad_frame` | frame truncated at the octet before the error character, `tuser`[0] = 1 on `tlast`, no FCS removed | REQ-105 |
| `/E/` while the frame is open, at or before the frame's first octet (including in a preamble position) | `error_bad_frame` | **no output word at all**; no `tlast` exists to mark | REQ-105, §0.7 |
| `/E/` while **no** frame is open — after a terminate character, after REQ-108's truncation, or between frames | *(none)* | nothing emitted, nothing pulsed; the next start character is received normally | REQ-105, REQ-108, REQ-113, **C-12** |
| 5 to 63 octets between start and terminate | `error_runt` | frame forwarded (1 to 59 octets after FCS removal), `tuser`[0] = 1 on `tlast` | REQ-107 |
| Fewer than 5 octets between start and terminate | `error_runt` | **no output word at all**; no FCS removal is attempted on a frame with nothing to remove it from | REQ-107, §0.7 |
| More than 1518 octets between start and terminate | `error_oversize` | frame truncated to exactly 1514 delivered octets, `tuser`[0] = 1 on `tlast`; the remainder is discarded until `/T/` or `/S/` | REQ-108 |
| `/S/` before the current frame's `/T/`, with ≥ 1 octet already delivered | `error_start_without_terminate` | current frame truncated at the octet before the new start character, `tuser`[0] = 1 on `tlast`, no FCS removed; the new frame begins normally | REQ-110 |
| `/S/` while the current frame is still inside its own preamble | `error_start_without_terminate` | **no output word at all** for the aborted frame; the new frame begins normally | REQ-110, §0.7 |

Silent discard is prohibited (REQ-008): every row that discards or truncates a
frame has a strobe. The last row discards nothing — there is no frame for it to
discard, which is precisely why it pulses nothing — and it is tabulated because
a reader who does not find it here has to guess (carry-forward **C-12**). The
one real exception in this specification is `clear` asserted mid-frame, which
REQ-009 governs (§7).

**When a frame is open, and what closes it** (the list the first two rows above
refer to). A frame is open from the cycle M03 accepts its start character until
the earliest of: its terminate character (REQ-106); an error character arriving
while it is open (REQ-105); a new start character (REQ-110); REQ-108's
truncation, on the cycle the received count passes 1518; or `clear` (REQ-009).
Every condition in the table is evaluated **only while the frame is open**. This
is what makes each frame's report a function of the frame rather than of the
characters that happen to follow it, and it is what §0.6's conservation equation
needs: a strobe that pulsed after closure would be attributable to a frame
already counted.

**Strobe cycle, pinned.** Each strobe pulses for exactly one cycle, on the
cycle M03 emits that frame's `tlast` word. For a frame that produces no output
word, it pulses **two cycles after the input word carrying the character that
ended the frame** — the cycle on which that frame's `tlast` word would have been
emitted. Both cycles are computable from the input trace alone, and both lie
inside requirements.md §0.6's window.

**Which conditions can co-occur on one frame, and what then pulses.**

- **`error_runt` with `error_bad_fcs`**: yes, and both pulse. A frame of 5 to 63
  octets ends with a terminate character, so its FCS *is* removed and *is*
  checked (REQ-103); if it is also wrong, two locally detected conditions apply
  to one frame and requirements.md §0.6 makes each pulse once. `tuser`[0] is
  set once — it is one bit on one word, not one bit per condition. A runt with a
  correct FCS pulses `error_runt` alone, which is what REQ-107's directed test
  drives.
- **`error_oversize` with `error_bad_fcs`**: never. REQ-108 says so explicitly,
  and the reason is that no FCS is present at the truncation point, so no check
  is performed and no result exists to report.
- **`error_bad_frame` with `error_bad_fcs`**: never, for the same reason — a
  frame ended by an error character has no terminate character, so REQ-103
  attempts no FCS removal and M03 performs no check.
- **`error_start_without_terminate` with `error_bad_fcs`**: never, likewise.
- **`error_bad_frame` with `error_start_without_terminate`**: never on the same
  frame. An error character **ends** the frame (§6.2 leaves to `Idle`), so a
  start character after it begins a new frame and aborts nothing. A bench that
  injects `/E/` and then `/S/` SHALL see exactly one `error_bad_frame` and no
  `error_start_without_terminate`.
- **`error_oversize` with `error_start_without_terminate`**: never on the same
  frame. REQ-108's truncation has already closed the frame with `tlast` and
  `tuser`[0] = 1; a start character arriving during the `Discard` state is the
  resynchronisation REQ-108 requires, not a second abort, and it pulses nothing.
- **`error_oversize` with `error_bad_frame`**: never on the same frame, for the
  same reason and by the same ruling (carry-forward **C-12**, dv_lead's proposed
  ruling adopted). REQ-108's truncation closes the frame; an `/E/` arriving in
  `Discard` therefore finds no open frame, emits nothing and pulses nothing. A
  bench that injects a 1600-octet frame with an error character after the
  truncation point SHALL see exactly one `error_oversize`, no `error_bad_frame`,
  and the following frame intact — the assertion `AP-xgmii_rx_64` was holding as
  NO-ASSERT until this ruling landed.
- **`error_runt` with `error_oversize`**: impossible — the octet ranges are
  disjoint.

**Aborted-and-forwarded versus discarded-before-emission.** Rows 1, 2, 4, 6 and
7 above forward a frame and mark it. Rows 3, 5 and 8 emit no word at all, so
requirements.md §0.6's abort rule does not apply to them and their strobe is
the only report — the case carry-forward C-4 exists to make explicit, now
stated in REQ-105 and REQ-110 themselves.

M03 inherits no abort: it is the origin of `tuser`[0] on this chain, so
§0.6's "a module SHALL NOT re-report an inherited abort" has no instance here.

## 10. REQ coverage

| REQ | How this module satisfies it | Section | Verification hook for DV |
|---|---|---|---|
| REQ-003 | output is `Axi64.Source` with no `Dest`; input has no `tready` | §4.1 | interface compile check |
| REQ-004 | sustains the 10/11-cycle alternating arrival rate for 10 000 frames | §8 | line-rate stress bench |
| REQ-005 | fixed-delay pipeline; FCS removed by `tkeep`, never by holding octets | §6.1, §7 | per-octet latency tagger inside the stress bench; directed lengths 64–71 and 1518 at both start lanes |
| REQ-007 | sets `tuser`[0] on `tlast` for every forwarded invalid frame | §9 | error injection per §9 row |
| REQ-008 | five strobes, one per condition, with a pinned pulse cycle | §9 | directed test per strobe plus the frame-conservation monitor |
| REQ-009 | `clear` empties the pipeline; mid-frame `clear` truncates silently | §7 | reset test: assert mid-frame, deassert, drive a frame on the next cycle |
| REQ-011 | `tkeep` `0xFF` except on `tlast`, contiguous from bit 0 | §7 | protocol monitor on the output stream, every bench |
| REQ-012 | lane k to `tdata` position, lane 0 earliest | §6.1 | known-frame directed test |
| REQ-014 | `tstrb` driven 0 | §7 | protocol monitor; REQ-014's differential run |
| REQ-015 | one `tlast` per frame, at most 190 words | §7 | protocol monitor |
| REQ-016 | input idle cycles delay octets and change nothing else; an input word covering no frame octet holds the frame and is not a condition | §6.1, §6.2, §7 | idle-injection wrapper at 0, 1 and 7 cycles, asserting the **per-octet** constant of §7 rather than §6.1's gapless cycle formula (C-14.4) |
| REQ-017 | `xgmii_rxd` / `xgmii_rxc` from SPEC-M01's `Xgmii` record | §4.1, §4.2 | emitted-Verilog port check at M05 and M20 |
| REQ-018 | no sub-XGMII logic; instantiates only M02 | §2, §3 | the emitted-module whitelist check |
| REQ-019 | ΔC = 3 against a ceiling of 4; two words of payload storage | §7 | ΔC computed from the pinned L and h at freeze; measured ΔC from the stress run in the sign-off packet |
| REQ-020 | one frame at a time; order not expressible otherwise | §6.2 | sequence numbers in the stress run |
| REQ-021 | frame octet 0 at `tdata`[7:0] at both start lanes | §6.1 | directed lane-0 and lane-4 comparison |
| REQ-101 | start detected in lane 0 and lane 4; identical output streams | §6.1 | REQ-101's tuple-sequence comparison; the absolute-cycle equality this module happens to achieve is **not** asserted |
| REQ-102 | eight octets from the start character discarded, values unchecked; control characters in preamble positions routed to §9 | §6.1, §9 | frame with arbitrary preamble filler; frame with `/E/` in a preamble lane; frame with `/T/` in a preamble lane |
| REQ-103 | delivers first DA octet through the octet before the FCS; no removal on aborted, truncated or cut-short frames | §6.1 | directed lengths 64–71 and 1518; the three no-removal cases from §9 |
| REQ-104 | residue check against 0x2144DF1C; abort bit and strobe on mismatch | §6.1, §9 | one payload bit flipped; assert the octet count is unchanged, `tuser`[0] = 1, one `error_bad_fcs` |
| REQ-105 | frame ends at the octet before `/E/`; zero-delivered case emits nothing; an `/E/` arriving when no frame is open emits and pulses nothing | §9 | `/E/` in each of eight lanes of a mid-frame word; `/E/` in a preamble lane; `/E/` after a terminate character and after a REQ-108 truncation point, asserting no `error_bad_frame` (C-12) |
| REQ-106 | terminate accepted in any lane; last octet is the one before it | §6.1 | lengths placing `/T/` in each of eight lanes |
| REQ-107 | 5–63 octets forwarded and marked; < 5 emits nothing | §9 | 5-, 16-, 60-, 63-octet frames; 0-, 1-, 4-octet frames |
| REQ-108 | truncation at exactly 1514 delivered octets; `Discard` then resynchronise; no `error_bad_fcs`, and no strobe of any kind between the truncation point and the next start character | §6.2, §9 | 1600-octet frame followed immediately by a valid frame; the same frame again with an `/E/` 100 octets past the truncation point (C-12) |
| REQ-109 | silent while idle and no frame in flight; the drain window is **two** cycles after the terminate word, not ΔC | §6.1, §7 | 1000 idle cycles; assert no activity from 3 cycles after the terminate word — the tight bound §6.1 derives (C-14.3) |
| REQ-110 | abort at the octet before the new `/S/`; zero-delivered case emits nothing; new frame received | §9 | `/S/` replacing `/T/` in lane 0 and lane 4; `/S/` in lane 4 of a word whose lane 0 was `/S/` |
| REQ-111 | L = 16 (lane 0) and 12 (lane 4), constant per lane | §7 | per-octet measurement over the REQ-005 frame set at both lanes |
| REQ-112 | no `tready` input; an XGMII word accepted every cycle | §4.1 | interface compile check plus the stress bench |
| REQ-113 | ordered sets and out-of-frame control characters ignored | §6.1 | 100 cycles of a local-fault ordered set, then a frame compared against the same frame after idles only |
| REQ-802, REQ-810 | `cfg_rx_enable` sampled at the start character; when 0, nothing is accepted or emitted; the same-cycle change is unconstrained (§6.3 item 7) | §4.3, §6.3 | drive `cfg_rx_enable` = 0 and inject 100 frames; assert no word and no strobe, then re-enable. The change SHALL be driven at least one cycle away from any start character — a same-cycle change has no determinate outcome and SHALL NOT be asserted on (C-14.5) |
| REQ-903, REQ-808 | `xgmii_rx_64` is a distinct emitted module with `create`, `hierarchical` and an `.mli` | §4.1 | repository surface check and the `rtl_snapshots/` name comparison |

This table is the source of M03's rows in [`traceability.md`](../traceability.md),
updated in the same commit.

## 11. Deferred items

| # | Item | Status · what a reader assumes meanwhile | Tracked as | Owner | Closes by |
|---|---|---|---|---|---|
| 11.1 | **`Axi64.Source`'s field names are witnessed here for the first time.** §4.1's `_witness_source_field_names` names all six; if `hardcaml_axi` v0.17.0 spells one differently, this lift fails to compile. | **CLOSED (WO-0010).** CI `build` run 30729342467 at f78766e reports `success` with this lift in it, so all six names are as SPEC-M01 §4.2 writes them, established by a run rather than by transcription. SPEC-M01 §11.4 closes with the same run. | SPEC-M01 §11.4; the `Interface compile check` row of §12 | architect_docs_lead, rtl_lead | closed |
| 11.2 | **REQ-810's receive half is implemented here, but `traceability.md` names M20 as REQ-810's owning module.** | **CLOSED (WO-0019).** SPEC-M20 §4.3 and §10 name M03 as the implementer of REQ-810's receive half, M04 as the implementer of its XGMII transmit half and M18 as the implementer of its application-interface `tready` half, and `traceability.md`'s REQ-810 row now lists all four owning modules with each half's evidence named separately. The behaviour here is unchanged: §4.3 and §10 already stated it and the matrix now agrees with them. | `traceability.md` REQ-810; SPEC-M20 §4.3, §10 | architect_docs_lead | closed |
| 11.3 | **The §9 co-occurrence rulings are this specification's, not requirements.md's** — in particular that an error character closes a frame so a following start character pulses nothing, and that a start character during REQ-108's `Discard` is resynchronisation rather than a second abort. | **CLOSED (WO-0010).** dv_lead confirmed all six rulings in the WO-0010 Return log §(d), and recorded two of them as *compelled* rather than chosen. No §9 text changed as a result. | WO-0008 Return log; WO-0010 Return log §(d) | architect_docs_lead, dv_lead | closed |
| 11.4 | **An error character arriving after the frame has been closed** — specifically during REQ-108's `Discard` — was governed by two sections that disagreed: §9 row 2's condition text read true after closure while §6.2's `Discard` row listed only `/T/` and `/S/` as exits. | **CLOSED (WO-0011), adopting dv_lead's proposed ruling.** Nothing pulses and nothing is emitted; §9's closure list, §9's third row, §6.2's `Discard` row and REQ-105/REQ-108 all say so, and §6.3 item 6 records that the internal state response is unobservable. | ledger **C-12** | architect_docs_lead, dv_lead | closed |
| 11.5 | **Two readings this specification carried that a bench would have failed a conformant design on**: §6.1's drain window was ΔC rather than the tight ΔC − 1, and §6.1's `m + 3` cycle formula was stated without §0.5's gapless qualifier while §10 commissions idle injection against it. | **CLOSED (WO-0011).** §6.1 now derives the two-cycle drain bound and carries the gapless qualifier; §6.2's `Frame` row states that an input word covering no frame octet holds the frame; §10's REQ-016 and REQ-109 hooks name the corrected figures. | ledger **C-14** (readings 3 and 4) | architect_docs_lead | closed |
| 11.6 | **The C-14.4 repair's illustrations contradicted §6.1's own worked examples**: one wrong instance (the second preamble word of a lane-4 start, which covers four frame octets), one loose one (a terminate character "in a low lane", when only lane 0 qualifies) and a definition of "gapless" that no stimulus satisfies. Read literally, §6.2's `Frame` row held the CRC register across four frame octets and failed the FCS check of **every** lane-4 frame. | **CLOSED (WO-0014).** The rule is unchanged and was never in doubt — dv_lead reaffirmed it at WO-0013. "Gapless" is now defined in **octet times**, the two non-instances are stated with their `octet_count` values, and §6.2's `Frame` row says that a word covering one or more frame octets is never held. §3's REQ-016 row carried the same wrong example and moves in the same diff. | ledger **C-18** | architect_docs_lead | closed |

## 12. Freeze record

Filled in at `P1-spec-freeze`. All four rows are required (charter §5).

| Item | Value |
|---|---|
| Interface compile check | CI `build` run **30729342467**, conclusion **`success`**, SHA **f78766e** — all five batch-A/B lifts elaborate, this one included; per ADR-0005 a local build is not acceptable evidence. This run is also SPEC-M01 §11.4's and §11.1's closure record |
| Architect signature | `J-architect_docs_lead-0004` |
| dv_lead testability countersignature | `J-dv_lead-0005` (WO-0010) — **SIGNED**, batch B |
| Frozen at | SHA **f78766e**, gate `docs/gates/P1-spec-freeze-checklist.md` |

## 13. Change log

Post-freeze changes only. Each row cites the ADR that authorised it; a breaking
interface change is counted against post-freeze churn (charter §6). **No row
below is breaking**: §4's records are byte-for-byte unchanged since the freeze
SHA, so the `ifc_check` evidence of §12 still witnesses this revision's
interface.

| Date | Change | Breaking? | ADR | Journal |
|---|---|---|---|---|
| 2026-08-02 | §7 handshake bullet: the deleted REQ-015 sentence removed, the `tlast`-inclusive count and the legal one-word frame stated (ledger **C-11**, dv_lead's wording; requirements.md REQ-015 moves in the same diff) | no | none — editorial, the corrected reading is REQ-015's own 190-word figure | `J-architect_docs_lead-0005` |
| 2026-08-02 | §6.2 `Discard` row, §6.3 item 6, §9 third row and §9's closure list: an error character arriving after the frame is closed emits nothing and pulses nothing (ledger **C-12**, dv_lead's proposed ruling adopted; requirements.md REQ-105 and REQ-108 move in the same diff) | no | none — a corner no requirement had decided; the ruling follows from §0.6's conservation equation, not from a new design choice | `J-architect_docs_lead-0005` |
| 2026-08-02 | §6.1 drain window tightened from ΔC to **two cycles** after the terminate word, with the derivation (ledger **C-14.3**) | no | none — §10's REQ-109 hook and REQ-109 itself already carried the tight figure; this removes the contradiction | `J-architect_docs_lead-0005` |
| 2026-08-02 | §6.1 `m + 3` formula qualified "on a gapless stimulus"; §6.2 `Frame` row states that an input word covering no frame octet holds the frame (ledger **C-14.4**) | no | none — restores §0.5's own qualifier | `J-architect_docs_lead-0005` |
| 2026-08-02 | §4.3 and §6.3 item 7: a `cfg_rx_enable` change landing on a start character's own cycle is deliberately unconstrained (ledger **C-14.5**) | no | none — makes an implication explicit so no bench asserts on it | `J-architect_docs_lead-0005` |
| 2026-08-02 | §3 REQ-016 row, §6.1 gapless definition and its illustrative list, §6.2 `Frame` row: "gapless" redefined in octet times; the lane-4 second preamble word and a terminate character in a lane above 0 stated as **non**-instances of the hold rule, with their `octet_count` values; §6.2 adds that a word covering ≥ 1 frame octet is never held (ledger **C-18**) | no | none — the C-14.4 **rule** is unchanged and reaffirmed (`J-dv_lead-0007`); only its illustrations and the definition of "gapless" were wrong, and §6.1's own worked examples already carried the governing reading | `J-architect_docs_lead-0006` |
