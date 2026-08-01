# Per-module specification template

- **Status**: normative form for every Phase-1 module specification
- **Owner**: architect_docs_lead · **Work order**: WO-0002
- **Applies to**: every module in the [`architecture.md`](architecture.md) §4
  inventory, written to `docs/specs/modules/<snake_case_name>.md`

---

## How to use this template

1. Copy everything below the horizontal rule marked **TEMPLATE BEGINS** into
   `docs/specs/modules/<module>.md` and fill every section. A section that does
   not apply is answered with "not applicable" **and one sentence of why** —
   never deleted, because the auditor checks the form against this file.
2. **A specification is written before its RTL exists.** No module may be
   implemented against a DRAFT spec; the freeze record at the bottom is what
   makes it implementable (charter §6, PROTOCOL §7).
3. **Write for two readers who never speak to each other**: an implementer who
   will produce Hardcaml from this text alone, and a test writer who will
   receive spec *excerpts* with the RTL deliberately withheld (PROTOCOL §10).
   If a sentence only makes sense to someone who has seen the code, rewrite it.
4. **Every behavioural claim traces to a REQ** in
   [`requirements.md`](requirements.md). A behaviour with no REQ is either a
   missing requirement — raise it, do not invent it locally — or an
   implementation choice that belongs in §6.3 as explicitly unconstrained.
5. **Banned phrasing**: "as needed", "appropriately", "should normally",
   "obviously", "TBD" outside §11, and any behaviour described only by
   reference to another module's implementation. Each is an ambiguity a test
   writer cannot resolve.
6. The Interface block in §4 is **lifted verbatim** into
   `docs/specs/ifc_check/<module>_ifc.ml` and must compile against the pinned
   toolchain (ADR-0004) in CI (ADR-0005) before freeze. The block is written so
   the whole thing compiles as a single `.ml` file: entry points are declared
   inside a `module type S`, not as bare `val`s.
7. After freeze, any change to §4, §6 or §7 is a **spec diff plus an ADR**
   (charter §3); §13 records it. Editorial changes elsewhere need only a
   journal entry.

---

**TEMPLATE BEGINS**

---

# SPEC-M<nn> — `<Module_name>`

- **Status**: DRAFT | FROZEN (`P1-spec-freeze`, SHA `<sha>`)
- **Inventory id**: M<nn> (architecture.md §4) · **Path**:
  `libs/hardcaml_ethernet/src/<snake_case_name>.ml`
- **Datapath role**: receive | transmit | shared/structural
- **Owns REQs**: REQ-###, REQ-### …
- **Prior-art counterpart**: `<verilog-ethernet module>.v` (MIT) — consulted
  for decomposition and port naming only; behaviour below is stated
  independently and no source was copied
- **Depends on specs**: SPEC-M<nn> …
- **Author**: architect_docs_lead, journal `J-architect_docs_lead-NNNN`

## 1. Purpose

Two to five sentences: what this module turns into what, and why it exists as a
separate module. State its position in the receive or transmit chain by naming
its immediate upstream and downstream modules.

## 2. Scope

- **In scope**: the behaviours this module is solely responsible for.
- **Not this module's job**: behaviours a reader might reasonably expect here,
  with the module that does own them. This section prevents duplicated or
  orphaned requirements at module boundaries.

## 3. Programme invariants that bind this module

List the REQ-001 … REQ-021 invariants that apply, one line each, with the
module-specific consequence. Do not paraphrase the requirement text — cite the
id and state what it forces here. At minimum every receive-path module cites
REQ-003 (no backpressure), REQ-004 (line rate), REQ-005 (cut-through),
REQ-007 (abort propagation), REQ-019 (no deep buffering) and REQ-021
(word alignment).

## 4. Interface

### 4.1 Interface records

```ocaml
(* Lifted verbatim into docs/specs/ifc_check/<module>_ifc.ml.
   Records and signatures only — no logic, no implementation. *)

open! Base
open Hardcaml

(* ---- programme-wide types, defined once in Axi64 (M01) and repeated
   here only in M01's own specification; other specs write
   [open Ifc_check_axi64] instead of restating them. ---- *)

module Axi64_config = struct
  let data_bits = 64
  let user_bits = 1
end

module Axi64 = Hardcaml_axi.Stream.Make (Axi64_config)

module Eth_header = struct
  type 'a t =
    { valid : 'a
    ; dst_mac : 'a [@bits 48]
    ; src_mac : 'a [@bits 48]
    ; ethertype : 'a [@bits 16]
    }
  [@@deriving hardcaml]
end

(* ---- this module ---- *)

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
```

Rules for this block:

- Scalar fields carry `[@bits n]` unless they are one bit wide.
- Nested interfaces carry `[@rtlprefix "…"]` so the emitted Verilog port names
  are legal and readable.
- Receive-path modules expose `Axi64.Source` **without** a matching
  `Axi64.Dest`: the absence of `tready` in the type is how REQ-003 is enforced.
  A receive module that needs backpressure cannot be written without a spec
  diff, which is the point.
- Transmit-path modules expose `Source` in one direction and `Dest` in the
  other, on the same logical stream.
- Every module provides both `create` and `hierarchical` (REQ-903, REQ-808).

### 4.2 Port table

| Port | Dir | Width | Meaning | REQ |
|---|---|---|---|---|
| `clock` | in | 1 | 156.25 MHz single domain | REQ-001 |
| `clear` | in | 1 | synchronous clear | REQ-009 |
| `<port>` | in/out | n | one sentence, stating the units and the encoding | REQ-### |

Every port in §4.1 appears in this table exactly once. Reserved or unused
fields say so and name the REQ that permits them (for example `tstrb`,
REQ-014).

### 4.3 Configuration inputs

Fields of the `Config` record this module reads, their effect, and when a
change takes effect (REQ-803). "None" is a valid answer.

## 5. Parameters

Compile-time parameters (OCaml function arguments or functor parameters), with
default, permitted range, and the reason a test might override it. Timeouts and
ageing intervals **must** be parameters so tests can use short values
(REQ-506).

| Parameter | Type | Default | Range | Why a test overrides it |
|---|---|---|---|---|

## 6. Behaviour

### 6.1 Normal path

Prose plus, where there is sequencing, a cycle-by-cycle table for one
representative frame. Name every field of every header this module reads or
writes, with its octet offset and its width, so a test writer can build the
stimulus without a protocol reference open.

### 6.2 State machine

| State | Entered when | Does | Leaves to |
|---|---|---|---|

Include the reset state and state on `clear`. If the module is combinational,
say so and cite REQ-306-style statelessness.

### 6.3 Deliberately unconstrained

Behaviour the implementer may choose freely (internal encodings, pipeline
placement within the stated latency, which of several legal orderings is used).
Anything not listed here is constrained by this specification, and a test may
rely on it.

## 7. Timing contract

- **Latency**: the constant number of cycles from a defining input event to the
  corresponding output event, stated as an exact number, not a bound, for
  receive-path modules (REQ-005, REQ-111). State the measurement points.
- **Throughput**: words accepted per cycle, and any cycle in which the module
  cannot accept a word (transmit path only — receive path must always accept,
  REQ-003).
- **Handshake rules**: when `valid` may assert and deassert, how long fields
  stay stable, the permitted relationship between a header record's `valid` and
  the first payload word (REQ-401 pattern), and behaviour on idle gaps
  (REQ-016).
- **Reset**: what is true within one cycle of `clear` deasserting (REQ-009),
  and what happens to a frame in flight when `clear` asserts.
- **Configuration sampling**: when configuration inputs are latched (REQ-803).

## 8. Line-rate stress obligation

**Mandatory for every receive-path module. Structural and transmit modules
state "not applicable" with one sentence of why.**

The module SHALL be exercised by a bench that:

1. drives minimum-length (64-octet) frames separated by the minimum 12-octet
   inter-frame gap, with start characters alternating between lane 0 and lane 4
   where this module sees XGMII, or at the equivalent one-frame-per-10.5-cycles
   arrival rate where it sees a stream (REQ-004);
2. runs for at least 10 000 consecutive frames;
3. checks that the number of frames out equals the number in, that payload
   octets compare equal, and that no word is dropped;
4. checks that the module asserts no backpressure — for receive modules this is
   structural (no `tready` exists) and the bench asserts it by construction.

State here the exact stimulus this module needs (frame contents, header field
values, error injection rate) so the bench can be written from this section
alone.

## 9. Errors and discards

Every abnormal condition, its strobe, and its effect on the output stream. The
strobe names are normative and come from `requirements.md`.

| Condition | Strobe (one cycle) | Stream effect | REQ |
|---|---|---|---|
| … | `error_…` | frame forwarded with `tuser`[0] = 1 on `tlast` / frame not forwarded / frame truncated at word n | REQ-### |

Silent discard is prohibited (REQ-008): every row has a strobe.

## 10. REQ coverage

Every REQ this module owns, plus every programme invariant from §3.

| REQ | How this module satisfies it | Section | Verification hook for DV |
|---|---|---|---|
| REQ-### | one sentence | §6.1 | directed test / stress bench / co-simulation / property |

This table is the source of the module's rows in
[`traceability.md`](traceability.md); update the matrix in the same commit.

## 11. Open questions

Numbered, each with an owner and the gate it must be closed by. "None" is a
valid answer. A DRAFT spec may carry open questions; a FROZEN spec may not.

## 12. Freeze record

Filled in at `P1-spec-freeze`. All four rows are required (charter §5).

| Item | Value |
|---|---|
| Interface compile check | CI `build` run `<id>`, conclusion `<success>`, SHA `<sha>` — per ADR-0005 a local build is not acceptable evidence |
| Architect signature | `J-architect_docs_lead-NNNN` |
| dv_lead testability countersignature | `J-dv_lead-NNNN` |
| Frozen at | SHA `<sha>`, gate `docs/gates/P1-spec-freeze.md` |

## 13. Change log

Post-freeze changes only. Each row cites the ADR that authorised it; a breaking
interface change is counted against post-freeze churn (charter §6).

| Date | Change | Breaking? | ADR | Journal |
|---|---|---|---|---|
