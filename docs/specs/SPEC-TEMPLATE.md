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
id and state what it forces here. Whether this module is a receive-path module,
and for which of its ports, is decided by `requirements.md` §0.4, not by
judgement: a structural module is on the receive path only with respect to the
ports that lie on that chain. At minimum every receive-path module cites
REQ-003 (no backpressure), REQ-004 (line rate), REQ-005 (cut-through, per-octet
constant latency), REQ-007 (abort propagation), REQ-019 (latency ceiling and no
deep buffering) and REQ-021 (word alignment).

## 4. Interface

### 4.1 Interface records

```ocaml
(* Lifted verbatim into docs/specs/ifc_check/<module>_ifc.ml.
   Records and signatures only — no logic, no implementation. *)

open! Base
open Hardcaml

(* ---- programme-wide types, defined once in Axi64 (M01) and repeated
   here only in M01's own specification; other specs write
   [open! Axi64_ifc] instead of restating them. ---- *)

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

- **Latency**: the module's constant L, stated as an exact number of **octet
  times** per `requirements.md` §0.5 — not a bound — for receive-path modules
  (REQ-005, REQ-111), together with the module's **front offset h**, its
  **output offset q** and its **word delay** ΔC = (L + h − q) / 8 in cycles,
  which is the figure `requirements.md` §1.1's ceiling is stated in and the
  figure REQ-006's end-to-end budget is the sum of (REQ-019). State h
  explicitly, per start lane where the two differ. **State q explicitly at any
  module that inserts octets ahead of the frame** — q is (the octets inserted
  ahead of the frame) mod 8 — because a specification stating no q is stating
  q = 0, and that is true only of a module which inserts nothing or inserts a
  whole number of words. Show that **(L + h − q)** is a multiple of 8 — a pinned
  L for which it is not describes a module that cannot exist. **Do not write
  that test in the q-free form (L + h)**: that form is this test evaluated at
  q = 0, and at an inserting module whose insertion is not a whole number of
  words it convicts a **conformant** design — a freeze-time check that refutes
  the module it exists to protect (`requirements.md` §0.5's whole-number bullet;
  the Phase-1 instances are SPEC-M07, q = 6, and SPEC-M15, q = 4, whose first
  §7 bullets were written from an earlier revision of *this* bullet and carried
  its defect). Name the two measurement events explicitly. **A delay pinned to a
  word the module itself inserted is an event delay, not a latency**: it is a
  legitimate and often sharper thing to pin, but it is a different quantity with
  a different value, and a specification pinning both SHALL name which is which
  (§0.5's inserting-module clause). Do not state latency as "word in to word
  out": at a realigning module, at an inserting module, or at a lane-4 start
  that names no single event and is not constant. A module seeing XGMII pins one
  constant per start lane and they differ by no more than one cycle.
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

**Mandatory for every module in `requirements.md` §0.4's stress-bench list
(M03, M06, M08, M10, M14, M17, M20). Every other module states "not applicable"
with one sentence of why — for a structural wrapper, that its children's benches
cover it and it adds no datapath logic of its own.**

The module SHALL be exercised by a bench that:

1. drives minimum-length (64-octet, destination address through FCS) frames
   separated by the minimum 12-octet inter-frame gap **counted from the
   terminate character inclusive** (`requirements.md` §0.3), with start
   characters alternating between lane 0 and lane 4 where this module sees
   XGMII — start-to-start spacing alternating 10 and 11 cycles. Where the module
   sees a stream rather than XGMII, the stimulus is whatever that same arrival
   pattern produces at this module's boundary, idle gaps preserved, derived by
   construction from the XGMII case and never re-invented here (REQ-004);
2. runs for at least 10 000 consecutive frames, every one of which this module
   accepts and forwards, so that frames-out equals frames-in is well defined
   even for a module that legitimately discards;
3. checks that the number of frames out equals the number in, that payload
   octets compare equal, that no word is dropped, that per-octet latency is
   constant (REQ-005), and that frame conservation holds (§0.6);
4. records that the module exposes no `tready` on the stream under test — this
   is structural (REQ-003) and is a statement about the type, not a bench
   assertion that could fail.

State here the exact stimulus this module needs (frame contents, header field
values, error injection rate) so the bench can be written from this section
alone.

## 9. Errors and discards

Every abnormal condition, its strobe, and its effect on the output stream. The
strobe names are normative and come from `requirements.md` §12.

State also, below the table, **which of these conditions can co-occur on one
frame and which strobes then pulse**, and for each condition whether the frame
is aborted-and-forwarded or discarded before any word is emitted. The general
precedence and multiplicity rules are `requirements.md` §0.6 (local discard beats
an inherited abort; an inherited abort is never re-reported with a strobe; every
locally detected applicable condition pulses once); this section says how they
land for this module, because that is what a bench asserts.

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

## 11. Deferred items

Numbered, each with an owner and the gate or work order it closes by. "None" is
a valid answer. Item numbers are **permanent**: a closed item keeps its number
and its row, with the closure recorded in place, because countersignatures and
work-order logs cite these numbers and a renumbered table makes those citations
lie.

**DRAFT versus FROZEN.** A DRAFT spec may carry an *open question* — an item
whose answer is not yet known and which something downstream cannot be built
without. **A FROZEN spec SHALL carry no open question.** It MAY carry a
*deferred item*, which is a different thing: a decision this specification has
already made and stated in its own normative sections, whose remaining work
(a script, a compile run, a wording fix in another file) is tracked elsewhere.
Every deferred item in a FROZEN spec SHALL state, in this order:

1. **Where it is tracked** — a carry-forward ledger row (`C-n` in
   `docs/gates/P1-spec-freeze-checklist.md`) or a work-order id — so the item
   cannot be closed silently or forgotten;
2. **What a reader assumes meanwhile** — one sentence an implementer or a test
   writer can act on today, without waiting for the item and without asking
   anyone. A frozen specification that leaves a reader blocked is not frozen;
3. **Owner and closing gate**.

An item that cannot state (2) is an open question, whatever it is called, and a
spec carrying one may not be frozen. That is the whole force of this rule:
freezing means nobody downstream is blocked — not that nothing is left to do.

Recommended form (Status is `OPEN`, `DEFERRED` or `CLOSED`):

| # | Item | Status · what a reader assumes meanwhile | Tracked as | Owner | Closes by |
|---|---|---|---|---|---|

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
