# SPEC-M02 — `Crc32_eth`

- **Status**: DRAFT
- **Inventory id**: M02 (architecture.md §4) · **Path**:
  `libs/hardcaml_ethernet/src/crc32_eth.ml`
- **Datapath role**: shared/structural (combinational function, instantiated
  inside a receive-path module and inside a transmit-path module)
- **Owns REQs**: REQ-301, REQ-302, REQ-303, REQ-304, REQ-305, REQ-306
- **Prior-art counterpart**: `lfsr.v` and `axis_eth_fcs_64.v` (MIT) — consulted
  for decomposition and port naming only; behaviour below is stated
  independently and no source was copied
- **Depends on specs**: SPEC-M01 (`Axi64`) for the datapath width and the
  octet-position convention. M02 takes no *record* from M01 — it has no stream
  port (§4.1).
- **Author**: architect_docs_lead, journal `J-architect_docs_lead-0003`

## 1. Purpose

M02 turns a running CRC value and 1 to 8 further frame octets into the running
CRC value that includes those octets, in one cycle and with no state of its own.
It exists as a separate module because two modules need exactly this function and
must agree on it bit for bit: M03 `Xgmii_rx_64` checks a received FCS with it
(REQ-104) and M04 `Xgmii_tx_64` generates a transmitted FCS with it (REQ-202), so
a difference between two private implementations would be a receiver that accepts
frames the transmitter cannot produce.

M02 is not itself a link in the receive or transmit chain: it has no stream port
and no upstream or downstream module. It is instantiated inside M03 and inside
M04 (architecture.md §6.3), and it is those two modules that sequence it over a
frame.

## 2. Scope

**In scope.**

- The CRC-32 parameterisation of REQ-301, as a function.
- The parallel update by 1 to 8 octets in a single cycle, agreeing octet for
  octet with a serial update (REQ-302).
- The value convention carried on `crc_in`/`crc_out`, and with it the two
  constants REQ-303 and REQ-304 pin (§6.1).
- Statelessness: no register, no `clock` port, no sequencing (REQ-306).

**Not this module's job.**

| Behaviour a reader might expect here | Owner |
|---|---|
| Seeding the running value at the start of a frame, and holding it between cycles | M03 (receive) and M04 (transmit), each in its own registers, on `clock` (REQ-001) |
| Deciding which octets of a frame are covered — destination address through last payload octet, or through the FCS | M03 (REQ-104) and M04 (REQ-202, REQ-203: padding is covered) |
| Comparing a computed value against a received FCS, or against REQ-304's residue, and raising `error_bad_fcs` | M03 (REQ-104). Whether M03 checks by comparison or by residue is SPEC-M03's choice to record |
| Stripping the four FCS octets from the receive stream, or appending them to the transmit stream in wire order | M03 (REQ-103) and M04 (REQ-202) |
| Deriving `octet_count` from `tkeep`, or from an XGMII terminate-character lane | M03 and M04, from REQ-011 and REQ-106 respectively |
| Any strobe | no module: M02 detects no condition (§9) |
| The independent software CRC oracle REQ-305 and REQ-202 rely on | dv_lead, under `test/` or `tools/` (§6.1, PROTOCOL §10) |

## 3. Programme invariants that bind this module

M02 is **not** a receive-path module under requirements.md §0.4: §0.4's receive
path is a chain of modules connected by streams, and M02 carries no stream. The
template's receive-path minimum (REQ-003, REQ-004, REQ-005, REQ-007, REQ-019,
REQ-021) therefore binds M03 and M04, which contain M02, rather than M02 itself.
What that containment forces on M02 is stated below, because it is the reason
REQ-306 exists.

| REQ | Consequence for M02 |
|---|---|
| REQ-001 | M02 has no `clock` port at all (REQ-306), which satisfies REQ-001 vacuously and is checked as such: the emitted `crc32_eth` module contains no `always @(posedge …)` block. The registers that hold the running value belong to M03 and M04 and are on `clock`. |
| REQ-002 | `data` is 64 bits — one `Axi64` word (SPEC-M01 §5) — so a caller updates by at most one word per cycle and never has to split a word across cycles. |
| REQ-003 | M02 has no handshake of any kind: it cannot stall a caller, because there is nothing to stall. A caller's cycle in which it does not update is a cycle in which it ignores `crc_out`. |
| REQ-005 | M02 is inside M03's and M04's pinned latency constants and contributes **zero** octet times of its own. This is what REQ-306 buys: a registered CRC stage would add a cycle to every octet passing M03, inside a 4-cycle ceiling (requirements.md §1.1). |
| REQ-009 | M02 holds no state, so it has no reset behaviour and takes no `clear` port; REQ-009's obligations fall on the callers' registers. |
| REQ-010 | M02's `data` port carries frame octets but is **not** a stream: it has no `tvalid`, no `tlast`, no `tkeep` and no `tuser`, and REQ-306 forbids it the state that would make those meaningful. REQ-010 prohibits ad-hoc per-module *stream records*; M02 declares none, and declaring an `Axi64.Source` here would put four fields on the port that no requirement gives a meaning at this boundary. §11.3 raises the wording of REQ-010 rather than assuming the reading. |
| REQ-012 | Octet k of `data` is `data`[8k+7:8k], and octet 0 is the earlier octet on the wire — the same mapping SPEC-M01 §6.1 fixes for `tdata`. The CRC is defined over the octets in that order (§6.1). |
| REQ-021 | Octets are always presented from position 0 upward, contiguously, exactly as a word-aligned stream presents them; a caller never offsets its octets inside `data`. |

## 4. Interface

### 4.1 Interface records

```ocaml
(* SPEC-M02 §4.1, lifted verbatim into docs/specs/ifc_check/crc32_eth_ifc.ml
   (SPEC-TEMPLATE.md rule 6). Records and signatures only — no logic, no
   implementation.

   [Axi64_ifc] is M01's types home (SPEC-M01 §4.1). M02 takes no record
   from it: REQ-306 makes M02 a pure function of a word, an octet count
   and a running CRC, so it has no stream port and no configuration port.
   The [open!] is here so that this lift, like every other in this
   directory, has exactly one place to obtain a shared type from and
   cannot grow a second [Axi64_config]; [data] below is one [Axi64] word
   wide (REQ-002, SPEC-M01 §5).

   No [clock] and no [clear]: REQ-306. No [Config]: §4.3. *)

open! Base
open Hardcaml
open! Axi64_ifc

module I = struct
  type 'a t =
    { crc_in : 'a [@bits 32]
    ; data : 'a [@bits 64]
    ; octet_count : 'a [@bits 4]
    }
  [@@deriving hardcaml]
end

module O = struct
  type 'a t = { crc_out : 'a [@bits 32] }
  [@@deriving hardcaml]
end

module type S = sig
  val create : Scope.t -> Signal.t I.t -> Signal.t O.t
  val hierarchical : ?instance:string -> Scope.t -> Signal.t I.t -> Signal.t O.t
end
```

Conformance of this block to the template's rules for §4.1:

- Scalar fields carry `[@bits n]`; there is no one-bit field in either record.
- No nested interface appears, so no `[@rtlprefix]` is needed: every port name is
  already the field name and is legal and readable.
- Receive-path `Source`-without-`Dest`: not applicable, because M02 has no stream
  port (§3, REQ-010 row). The structural expression of REQ-003 at this module is
  stronger and simpler — there is no handshake signal of any kind to stall with.
- Both `create` and `hierarchical` are declared (REQ-903, REQ-808); a
  combinational module is still a module in the emitted Verilog and still takes a
  `Scope.t`.

### 4.2 Port table

Every port in §4.1 appears exactly once. There is no `clock` row and no `clear`
row: REQ-306 makes the module a pure function, and their absence is the
mechanically checked half of that requirement.

| Port | Dir | Width | Meaning | REQ |
|---|---|---|---|---|
| `crc_in` | in | 32 | the running CRC-32 of every octet covered so far, in the value convention of §6.1: the finished CRC-32 (REQ-301 parameterisation, final XOR already applied) of that octet string. A caller starting a new frame drives 0x00000000, which is the CRC-32 of the empty octet string | REQ-301, REQ-306 |
| `data` | in | 64 | up to eight frame octets; octet k occupies `data`[8k+7:8k] and octet 0 is the earlier octet on the wire. Positions at and above `octet_count` are ignored and do not affect `crc_out` | REQ-012, REQ-302 |
| `octet_count` | in | 4 | how many octets of `data`, counted from position 0 upward, are covered by this update. Permitted values are 1 through 8; the values 0 and 9 through 15 are outside REQ-302's domain and §6.3 records the output as unconstrained for them | REQ-302 |
| `crc_out` | out | 32 | the running CRC-32 of the octets covered by `crc_in` followed by the `octet_count` octets of this update, in the same value convention as `crc_in` | REQ-301, REQ-302 |

### 4.3 Configuration inputs

**None.** M02 reads no field of the `Config` record (SPEC-M01 §4.2): the CRC-32
parameterisation is fixed by REQ-301 and is not configurable, and no field of
requirements.md §9.1 has any effect here. REQ-803's sampling rule therefore has
nothing to bite on at this module.

## 5. Parameters

**None.** M02 has no compile-time parameter: the polynomial and its
parameterisation are REQ-301's, the word width is REQ-002's, and the octet-count
range is REQ-302's. REQ-506's rule — timeouts and ageing intervals must be
parameters so tests can use short values — does not apply, because M02 has no
timeout, no interval and no counter.

| Parameter | Type | Default | Range | Why a test overrides it |
|---|---|---|---|---|
| (none) | — | — | — | — |

## 6. Behaviour

### 6.1 Normal path

**The function.** Write `CRC32(S)` for the CRC-32 of the octet string `S` under
REQ-301's parameterisation — polynomial 0x04C11DB7, initial value 0xFFFFFFFF,
input and output reflected, final XOR 0xFFFFFFFF — as a 32-bit number. The module
computes, combinationally and every cycle:

> given `crc_in` = `CRC32(S)` for some octet string `S`, and octets
> `d0 … d(n−1)` at `data` positions 0 to n−1 with `octet_count` = n,
> `crc_out` = `CRC32(S · d0 · … · d(n−1))`.

`crc_out` depends on `crc_in`, on `data`[8n−1:0] and on `octet_count`, and on
nothing else. In particular it does not depend on `data`[63:8n] — the ignored
positions — which is a directly testable statement and not a restatement of
REQ-306.

**The value convention, stated once, because it is the thing a reader is most
likely to get wrong.** The ports carry the **finished** CRC-32 value, not the
internal shift-register state. Three consequences:

1. The identity element is `crc_in` = **0x00000000**, because that is
   `CRC32(empty string)`: REQ-301's initial value 0xFFFFFFFF and its final XOR
   0xFFFFFFFF are both internal to the function and cancel over an empty input.
   A caller seeds a frame with zero, not with all-ones. This is not a
   contradiction of REQ-301 — 0xFFFFFFFF is the initial value of a register this
   module does not expose.
2. At every update boundary `crc_out` is the CRC-32 of the whole octet string
   consumed so far, so it can be compared directly against a software reference
   run over that same prefix, with no adjustment at either end (see the oracle
   paragraph below).
3. A reader comparing against prior art that carries the raw register — the usual
   choice in Verilog FCS blocks — converts in either direction by
   `register = port value XOR 0xFFFFFFFF`.

**The two constants (REQ-303, REQ-304).** Both are stated by requirements.md §4
in this same finished-value convention, so both are observed directly at
`crc_out` with no adjustment. Their authority and the record of how they came to
be corrected is the provenance note under requirements.md §4; it is not restated
here. For a reader converting to the raw-register convention of note 3,
REQ-303's 0xCBF43926 is 0x340BC6D9 there and REQ-304's 0x2144DF1C is 0xDEBB20E3;
those two are arithmetic on the REQ constants, not requirements of their own.

**Worked example 1 — REQ-303's check value at this module's ports.** The nine
ASCII octets `123456789` in two updates. This is a directed test a test writer can
build from this table alone.

| Update | `crc_in` | `data` | `octet_count` | `crc_out` |
|---|---|---|---|---|
| 1 | 0x00000000 | 0x3837363534333231 (`'1'` = 0x31 at `data`[7:0] … `'8'` = 0x38 at `data`[63:56]) | 8 | 0x9AE0DAAF |
| 2 | 0x9AE0DAAF | `data`[7:0] = 0x39 (`'9'`); `data`[63:8] unconstrained | 1 | **0xCBF43926** |

The intermediate 0x9AE0DAAF is `CRC32("12345678")`. It is a derived value, not a
requirement: it follows from REQ-301's parameterisation, and any implementation of
that parameterisation reproduces it. Driving update 2 with a different value in
`data`[63:8] and observing the same `crc_out` is the ignored-position check.

**Worked example 2 — a minimum-length frame, both directions.** A 64-octet frame
(destination address through FCS, requirements.md §0.3) covers 60 octets before
the FCS. M04 computes over those 60 in eight updates; M03 checks by continuing
over the four received FCS octets, reaching REQ-304's residue after eight updates
of eight octets.

| Update | Covered octets (transmit, M04) | `octet_count` | `crc_out` |
|---|---|---|---|
| 1 | frame octets 0–7 (destination address) | 8 | `CRC32` of octets 0–7 |
| 2–7 | octets 8–55, eight per update | 8 | running |
| 8 | octets 56–59; `data`[63:32] ignored | 4 | the frame's FCS value, `CRC32` of octets 0–59 |

M04 then transmits those four octets **least significant first** (REQ-202): the
wire order is `crc_out`[7:0], `crc_out`[15:8], `crc_out`[23:16], `crc_out`[31:24].
M03, covering all 64 received octets from `crc_in` = 0x00000000 in eight updates
of eight, obtains `crc_out` = **0x2144DF1C** on a frame whose FCS is correct
(REQ-304), and any other value means the frame is damaged (REQ-104). REQ-304's
residue is constant only because REQ-202 fixes that wire order; the two
requirements are one decision seen from two sides.

**Serial equivalence (REQ-302).** For every n in 1 to 8 the parallel update
equals n consecutive one-octet updates:
`update(C, d0…d(n−1), n) = update(update(C, d0, 1), d1…d(n−1), n−1)`. This
decomposition is what the REQ-302 comparison test drives, and it is also what
makes the eight `octet_count` values one function rather than eight.

**The REQ-305 oracle relationship.** REQ-305's bit-serial CRC-32 reference is a
**software** implementation of REQ-301's parameterisation, owned by dv_lead and
written from this section and from requirements.md §4 — never from this module's
RTL, and never from its parallel formulation (PROTOCOL §10). Three properties
make it usable as an oracle:

- **It is anchored before it may judge.** The reference must reproduce REQ-303's
  0xCBF43926 for `123456789` before any comparison run counts. That is the
  external-anchor rule PROTOCOL §10 states for golden models, and REQ-303 is the
  anchor it names.
- **The comparison is an identity, not a conversion.** Because the ports carry
  finished values (note 2 above), the check is `crc_out` = `reference(crc_in,
  octets)`, with the reference taking a running value and returning the running
  value that includes the octets. A table-driven implementation with that exact
  signature — for example `zlib.crc32(data, crc)` — is a legitimate cross-check
  *of the reference*, and is not a substitute for it: REQ-305 names a bit-serial
  reference precisely so that the oracle shares no structure with the design.
- **It is the oracle REQ-202 requires.** The four FCS octets on the wire are
  compared against the reference, not against a second run of this engine:
  feeding a transmitted frame back through the receiver checks only that the
  design agrees with itself, which a systematically wrong but self-consistent CRC
  would pass. REQ-202's verification column says exactly this, and M02 is the
  shared engine that makes the risk real.

### 6.2 State machine

**Not applicable: the module is combinational.** REQ-306 makes it a pure function
of (`crc_in`, `data`, `octet_count`) with no internal state, so there is no
state, no reset state and no behaviour on `clear` — and no `clock` or `clear`
port for either to be defined against (§4.2). Sequencing over a frame belongs to
the callers, whose state machines are SPEC-M03's and SPEC-M04's.

### 6.3 Deliberately unconstrained

Anything not listed here is constrained by this specification, and a test may
rely on it.

1. **`crc_out` when `octet_count` is 0, or 9 through 15.** REQ-302's domain is 1
   to 8 octets and this specification states nothing outside it. A caller driving
   such a value is a defect in the caller, detectable in the caller's own bench
   and not reportable here (§9). DV must assert nothing about these inputs, and a
   `formal_dv` proof of REQ-302 or REQ-305 assumes 1 ≤ `octet_count` ≤ 8. §11.2
   records the alternative — giving 0 the identity meaning — as a question for
   the batch-B specs, since only M03 and M04 can say whether they need it.
2. **The internal formulation.** Table-driven, matrix-unrolled, eight-way
   selected between per-count networks, or one network with masked octets: all
   are legal, none is observable, and REQ-302 plus REQ-305 constrain the result
   for every input in the domain.
3. **Combinational depth and any internal pipelining.** None is permitted: any
   internal register is a REQ-306 violation, not a pipelining choice. See §7 for
   what happens if depth ever becomes a problem.
4. **The value of `data`[63:8·`octet_count`]**, which the caller may drive to
   anything, including the stale octets of a previous word.

## 7. Timing contract

- **Latency**: **zero cycles — the module is combinational** (REQ-306), so the
  per-octet, octet-time formulation of requirements.md §0.5 has no measurement
  events at this module: `crc_out` is a function of the same cycle's inputs and
  no octet crosses a register boundary here. The constant-latency obligation
  belongs to the callers, whose pinned constants (REQ-111 for M03, REQ-210 for
  M04) already include this module's contribution of zero. M02 is not a
  receive-path module (§3) and carries no ceiling of its own in requirements.md
  §1.1.
- **Throughput**: one update per cycle, unconditionally. There is no cycle in
  which the module cannot accept an update, and no cycle in which it refuses one:
  it computes on every cycle and the caller decides which results to keep.
- **Handshake rules**: none exist. There is no `valid`, no `ready` and no `last`
  on this interface (§4.1). Field stability is the caller's: the inputs are
  sampled by whatever register the caller clocks `crc_out` into, so they must be
  stable for that cycle's setup, which is an ordinary synchronous-design
  obligation and not a protocol. REQ-016's idle tolerance is satisfied trivially
  — a caller's idle cycle is a cycle whose `crc_out` it does not use, and no state
  advances because there is none.
- **Reset**: not applicable. No state, therefore no `clear` port (§4.2, REQ-306);
  within one cycle of `clear` deasserting at a caller, that caller re-seeds
  `crc_in` to 0x00000000 for the next frame (REQ-009 at M03 and M04).
- **Configuration sampling**: not applicable. M02 reads no configuration (§4.3),
  so there is nothing to latch and REQ-803 has no instance here.

**Timing closure, stated so it is not mistaken for an implementation decision.**
An eight-octet CRC-32 update is a wide exclusive-or network, and REQ-306 forbids
splitting it across registers. Phase 1 is simulation-only at the hardware
boundary (REQ-018, architecture.md §1), so no static timing closure at 6.4 ns is
required of it in this phase. If a later phase cannot close the path, the remedy
is a spec diff to REQ-306 and an ADR, not an internal register — a registered
stage here changes M03's and M04's latency constants and their §1.1 ceilings.

## 8. Line-rate stress obligation

**Not applicable.** M02 is not in requirements.md §0.4's stress-bench list (M03,
M06, M08, M10, M14, M17, M20), and the obligation would have no content at this
module: the bench of §8 is written in frames, gaps and start lanes, and M02 has no
stream port on which a frame, a gap or a start lane exists. M02 is nevertheless
driven at the full arrival rate inside M03's and M04's benches, one update per
cycle for 10 000 consecutive frames, which is the exercise a stress bench would
have provided; the obligation that actually constrains M02 is the randomised
equivalence of REQ-302 and REQ-305 across all eight octet counts, which is
stronger than any frame-rate argument because it covers input combinations no
frame stimulus reaches.

## 9. Errors and discards

**Not applicable.** M02 forwards no frame and holds no frame in flight, so it can
neither discard nor truncate nor abort one, and there is no condition it could
detect: a CRC-32 update is defined for every input in REQ-302's domain and fails
for none of them. The table is therefore empty rather than unfilled.

| Condition | Strobe (one cycle) | Stream effect | REQ |
|---|---|---|---|
| (none — see above) | — | — | — |

REQ-008's prohibition on silent discard is not weakened: the frame-level condition
this module's result feeds — a received FCS that does not match — is detected and
reported by M03 as `error_bad_fcs` (REQ-104), and it is M03's §9 that records it.
The one pathological input to M02, an `octet_count` outside 1 to 8 (§6.3), is a
caller defect rather than a frame event: it corresponds to no frame being
discarded, so there is nothing for a strobe to make observable, and inventing one
would put a status field in the top-level record (REQ-804) for a condition
requirements.md §12 does not name.

Co-occurrence, precedence and multiplicity (requirements.md §0.6): no instance,
since no condition is detected locally.

## 10. REQ coverage

Every REQ this module owns, plus every programme invariant from §3.

| REQ | How this module satisfies it | Section | Verification hook for DV |
|---|---|---|---|
| REQ-001 | no `clock` port exists; the callers' registers carry the running value | §4.2 | the mechanical emitted-Verilog check REQ-306 commissions, which is the same check |
| REQ-002 | `data` is exactly one 64-bit `Axi64` word | §4.2 | interface compile check |
| REQ-005 | zero cycles of latency contributed to M03 and M04 | §7 | the per-octet latency measurement inside M03's and M04's benches; M02 has no measurement event of its own |
| REQ-009 | no state to reset; no `clear` port | §6.2 | interface compile check (absence of `clear`), plus M03/M04's reset tests |
| REQ-010 | no ad-hoc stream record is declared; the port is a function argument, not a stream | §3, §4.1 | interface compile check; the wording question is §11.3 |
| REQ-012 | octet k at `data`[8k+7:8k], octet 0 earlier on the wire | §6.1 | REQ-303's known-answer test, whose octet packing (0x3837363534333231) is wrong under any other mapping |
| REQ-021 | octets always presented from position 0 upward, contiguously | §6.1 | implied by every directed and randomised test; no separate case needed |
| REQ-301 | implements exactly that parameterisation, exposed as finished values | §6.1 | REQ-303 and REQ-304 known-answer tests |
| REQ-302 | one update covers 1 to 8 octets and equals the serial decomposition; positions at and above `octet_count` do not affect `crc_out` | §6.1 | randomised comparison against the REQ-305 reference for every octet count over ≥ 10 000 inputs, plus an ignored-position test driving `data`[63:8n] randomly and asserting `crc_out` is unchanged |
| REQ-303 | `crc_in` = 0x00000000 over `123456789` yields 0xCBF43926 at the port, no adjustment | §6.1 | directed test, worked example 1 — two updates, 8 then 1 |
| REQ-304 | continuing over a correct FCS appended least significant octet first yields 0x2144DF1C | §6.1 | directed test over several frame lengths, worked example 2; also M03's FCS-check oracle |
| REQ-305 | the port convention makes the comparison against the bit-serial reference an identity with no conversion at either end | §6.1 | randomised equivalence run; candidate for a `formal_dv` exhaustive proof in Phase-1 hardening, assuming 1 ≤ `octet_count` ≤ 8 (§6.3) |
| REQ-306 | pure combinational function; no register, no `clock`, no `clear` | §4.1, §6.2 | interface compile check plus the mechanical check of the emitted `crc32_eth` module: no `clock` port, no `always @(posedge …)` block |
| REQ-808, REQ-903 | `crc32_eth` is a distinct emitted module with `create`, `hierarchical` and an `.mli` | §4.1 | the `rtl_snapshots/` module-name comparison and the repository surface check |

This table is the source of M02's rows in [`traceability.md`](../traceability.md).
**The matrix is not updated in this commit**: WO-0006 fixes its file set to the
two specs, the two lifts and the packet, so the rows for REQ-301 … REQ-306 still
read `pending` in the Spec-section column. The update is owed before
`P1-spec-freeze` and is recorded in SPEC-M01 §11.2 and in the WO-0006 Return log.

## 11. Open questions

| # | Question | Owner | Closed by |
|---|---|---|---|
| 11.1 | **ADR owed for two interface decisions this specification embodies.** (a) The ports carry finished CRC-32 values rather than the raw shift-register state (§6.1), which is the minority convention in prior art and is chosen so that REQ-303's and REQ-304's constants and the REQ-305 oracle need no conversion; the rejected alternative is the raw register with 0xFFFFFFFF seeding and an XOR at every comparison. (b) `octet_count` is a 4-bit count with domain 1 to 8; the rejected alternative is a 3-bit count-minus-one, which has no illegal encoding but puts an off-by-one at every call site and in every bench. Charter §3 makes both ADR material; WO-0006's file set excludes `docs/adr/`, so the ADR is requested from the orchestrator. | architect_docs_lead | `P1-spec-freeze` |
| 11.2 | **Should `octet_count` = 0 be given the identity meaning** (`crc_out` = `crc_in`) as a new REQ-307, instead of being unconstrained (§6.3)? It would make the function total and remove an assumption from a `formal_dv` proof. It is not invented here because only M03 and M04 can say whether an update-by-zero cycle actually occurs in their sequencing; if it does, this becomes a requirement rather than a convenience. | architect_docs_lead, rtl_lead | SPEC-M03 and SPEC-M04 (batch B) |
| 11.3 | **REQ-010's wording versus a frame-carrying port that is not a stream.** REQ-010 says all frame-carrying ports SHALL use `Axi64.Source`/`Axi64.Dest`; M02's `data` carries frame octets and is deliberately not a stream (§3). Read literally, M02 is the one Phase-1 module that cannot satisfy REQ-010, and its interface compile check has no `Axi64` port to witness. The proposed spec diff narrows REQ-010's subject to frame-carrying *stream* ports and names M02 explicitly, which changes no behaviour and removes a standing audit finding. requirements.md is read-only under WO-0006, so this is raised, not applied. | architect_docs_lead, dv_lead (countersignature) | `P1-spec-freeze` |
| 11.4 | **Which FCS-check formulation M03 uses** — compute over destination address through last payload octet and compare against the received FCS, or continue over the FCS and compare against REQ-304's residue — is left to SPEC-M03. Both use this module unchanged; the residue form needs no comparison register but reports one cycle later. Recorded here so that the choice is made in M03's specification rather than discovered in its RTL. | architect_docs_lead | SPEC-M03 (batch B) |

## 12. Freeze record

Filled in at `P1-spec-freeze`. All four rows are required (charter §5); this spec
is DRAFT and none is filled.

| Item | Value |
|---|---|
| Interface compile check | pending — CI `build` run `<id>`, conclusion `<success>`, SHA `<sha>`; per ADR-0005 a local build is not acceptable evidence |
| Architect signature | pending |
| dv_lead testability countersignature | pending |
| Frozen at | pending — SHA `<sha>`, gate `docs/gates/P1-spec-freeze-checklist.md` |

## 13. Change log

Post-freeze changes only. This spec is DRAFT and has none.

| Date | Change | Breaking? | ADR | Journal |
|---|---|---|---|---|
| — | — | — | — | — |
