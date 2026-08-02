# Journal: claude_rtl_lead_agent

- **Agent**: rtl_lead (Opus 5 lead)
- **Charter**: agents/charters/rtl_lead.md
- **Format**: v1 — entry grammar in agents/PROTOCOL.md §4

This file is APPEND-ONLY. Content may only ever be added after the last line;
nothing above it is ever edited. Enforced by scripts/agent_commit.sh and CI.

---

## [J-rtl_lead-0001] 2026-08-02T07:55:00Z | task:WO-0016 | M01 `Axi64` and M02 `Crc32_eth` written from the frozen batch-A specs: the vocabulary module with its REQ-903 `.mli`, and a combinational CRC-32 built as the reflected bit recurrence tapped after each octet

### Trigger

Orchestrator work order `agents/handoffs/WO-0016_m01-m02-implementation.md`
(spawn short-id `WO-0016/2026-08-02T06:52Z`) — the programme's first RTL
activation. M01 and M02 are the two specifications frozen longest (`f78766e`)
and sit at the bottom of every dependency chain: the types every later module's
port record is built from, and the CRC engine M03 and M04 share.

### Inputs

Governance: `agents/charters/rtl_lead.md`, `agents/PROTOCOL.md` (§4 grammar, §6
scopes, §10 independence), `agents/handoffs/WO-0016_m01-m02-implementation.md`.

Frozen specifications, read in full and treated as the whole authority:
`docs/specs/modules/axi64.md` and `docs/specs/modules/crc32_eth.md` (both
FROZEN at `f78766e`, byte-unchanged in the working tree; §13 of each is empty).
Their compile-checked lifts `docs/specs/ifc_check/axi64_ifc.ml` and
`docs/specs/ifc_check/crc32_eth_ifc.ml`, plus `docs/specs/ifc_check/dune`.
`docs/specs/requirements.md` §4 (REQ-301 … REQ-306 and the provenance note on
the two constants), REQ-010's narrowed subject, REQ-903's amended text and its
2026-08-02 change-log row. `docs/specs/architecture.md` §10 (the `hardcaml_axi`
reference). ADRs: `ADR-0004` (toolchain lane), `ADR-0005`
(`docs/adr/ADR-0005-build-environment.md` — CI is the authoritative build),
`ADR-0006` (finished-value ports), and ADR-0007 as quoted by SPEC-M02 §6.3/§11.2.

Repository context: `libs/hardcaml_ethernet/src/{word_counter.ml,word_counter.mli,dune}`
(the CI-green precedent for the `.ml`/`.mli` + `[@@deriving hardcaml]` pattern),
`bin/dune`, `bin/generate.ml`, `dune-project`, `agentic_fpga.opam`,
`.ocamlformat`, `.github/workflows/build.yml`. DV-owned material read but never
modified: `tools/dv_checks.sh`, `tools/check_emitted_verilog.sh` (its REQ-903,
REQ-306 and REQ-808 checks are what my file set has to satisfy),
`test/axi64_probe/axi64_probe.ml` and its `dune` — read to see what a consumer
does with M01's records and to confirm the `Source` field names are exercised by
a compile somewhere.

Toolchain sources, read to bind every construct to a real signature rather than
to memory (ADR-0005 leaves me no other way): the **Hardcaml v0.17.1 sources
present but not installed** in this container at
`/root/.opam/fpga/.opam-switch/sources/hardcaml` — `src/comb_intf.ml`,
`src/hierarchy.mli`, `src/interface_intf.ml`, `src/circuit.mli`,
`src/scope.mli`, `src/constant.ml`, `src/async_fifo.mli`,
`ppx/src/ppx_hardcaml_zero.ml` — and the dune 3.24.1 sources at
`.opam-switch/sources/dune.3.24.1/src/dune_rules/ocaml_flags.ml`. Hardcaml is
MIT and is this programme's own toolchain, so reading it carries no licensing
question.

**Licensing honesty (charter §8)**: `Essenceia/Nasdaq-HFT-FPGA` was **not**
consulted for any part of this unit of work. `alexforencich/verilog-ethernet`
was **not** opened either — SPEC-M02's prior-art row records that its
decomposition influence is already spent in the specification, and the CRC
formulation below is derived from REQ-301's parameterisation directly.

### Reasoning

**M01 — transcription, not design.** SPEC-M01 §4.1 is normative down to field
names, widths and record order, and REQ-010 exists precisely to stop nineteen
modules growing nineteen dialects of one agreement. The record blocks in
`axi64.ml` are therefore byte-identical to the frozen §4.1 block and to the
lift that CI already elaborates; the only additions are the module doc comment
and the adaptation of the lift's own comments from "this lift" to "this
library". Nothing here was mine to choose, and the one place I could have
drifted — `Config`'s twelve fields and `Status`'s twenty-one names and order —
is exactly the drift the C-9 script re-checks at every SHA, so a transcription
error would have been mechanically visible rather than latent.

**M01's `.mli` — the one place WO-0016 and the frozen text disagree, and how I
resolved it.** The work order's deliverable 3 offers `.mli` files "if and only
if the spec's §4 implies a narrower public surface", calling REQ-903's `.mli`
half "still an open C-8-adjacent item". The frozen text says otherwise and says
it three times: SPEC-M01 §4.1's last conformance bullet ("**The `.mli` is
not**" — not applicable — "… `libs/hardcaml_ethernet/src/axi64.mli` … is
required and §10 carries the row … closed by the REQ-903 diff in this work
order"), SPEC-M01 §10's REQ-903 row, and requirements.md REQ-903 itself, whose
amended text names M01 as the only types-only module and waives the
`hierarchical` half **only**. `tools/check_emitted_verilog.sh` already
implements that split ("an `.mli` for every inventory module, M01 INCLUDED").
So this is not policy for me to invent: C-8 is closed in the direction of
"required", and I implemented the frozen text. I flag the divergence in the
packet's Return log rather than silently resolve it, because a work order and a
frozen spec disagreeing is exactly the class of thing that should be visible
(charter §7: never patch around a spec silently, in either direction).

**How `axi64.mli` names the stream module.** `Axi64` is
`Hardcaml_axi.Stream.Make (Axi64_config)`, and an interface file has to say
something about it. Three options:

1. *Hand-write a `Source`/`Dest` signature.* Rejected. A record type declared
   without a manifest in a signature is a **new** nominal type: sealing it that
   way would break the identity between our `Axi64.Source.t` and
   `hardcaml_axi`'s, restate six field names this programme does not own
   (SPEC-M01 §11.4's whole point), and create the second place for them to
   drift that REQ-010 exists to prevent.
2. *`module type of Hardcaml_axi.Stream.Make (Axi64_config)`.* Legal, but the
   unstrengthened form: any abstract type in the functor's result signature is
   re-abstracted, which weakens what consumers can prove about the type without
   buying anything.
3. **`module type of struct include Hardcaml_axi.Stream.Make (Axi64_config) end`
   — chosen.** The standard non-re-abstracting idiom: the exported module keeps
   every type equation the functor application has, so M03 onward see exactly
   the `hardcaml_axi` types, and this file restates none of them. The functor is
   applied to a path (`Axi64_config`, declared immediately above in the same
   signature), so the applicative-functor identity between the `.ml` and the
   `.mli` holds by path.

`Axi64_config` is declared in the `.mli` as the two `val`s SPEC-M01 §5 pins,
which is the minimum that lets the functor application above type-check and the
maximum a caller may do with it (§5: neither parameter is overridable).

**No `[@bits]` in either `.mli`.** The ppx's signature generator
(`ppx_hardcaml_zero.ml`, `sig_of_type`) emits only
`include Interface.S with type 'a t := 'a t` and never reads a field's
attributes, so a `[@bits n]` surviving in a signature is an *unconsumed*
attribute — a hard error, not a warning. `word_counter.mli` in this repository
already carries that asymmetry and is CI-green; I matched it and wrote the
reason into both files so the next module author does not "fix" it back.

**M02 — the microarchitecture choice, which is the only real design decision in
this packet.** SPEC-M02 §6.3 item 2 explicitly leaves the internal formulation
unconstrained and names four legal ones. I considered three:

- **(a) Elaboration-time GF(2) matrices, one per octet count.** The textbook
  parallel-CRC form and the shallowest network. Rejected **for this activation**
  on the ADR-0005 risk profile, not on hardware grounds: it moves correctness
  out of the recurrence and into ~50 lines of my own linear algebra, which I
  cannot compile, cannot simulate, and — by charter red line and PROTOCOL §10 —
  may not test, because dv_lead owns every test that gates this module. An error
  there is invisible until dv's oracle runs, and it is invisible to a reviewer
  reading the source against REQ-301.
- **(b) Table-driven (256-entry lookup per octet).** A ROM per octet position,
  eight of them; larger, no less arbitrary, and the tables are the same linear
  algebra as (a) in a different representation.
- **(c) The reflected bit recurrence elaborated once as a 64-step prefix chain,
  tapped after each octet, with a 16-way multiplexer selecting the tap —
  chosen.** It *is* REQ-301's parameterisation written out, so a reviewer or an
  auditor checks it against the requirement by reading; the chain is shared
  across all eight octet counts, so eight results cost one network plus one
  multiplexer instead of eight networks; and REQ-302's ignored-position clause
  holds **by construction** — the tap for n octets is a function of
  `data[8n-1:0]` only — rather than by a mask that can be off by one octet.

The cost of (c) is source-level depth: 64 dependent steps rather than a
two-level XOR tree. That is a linear network that synthesis restructures, and
SPEC-M02 §7 settles the question for this phase in the specification's own
words — Phase 1 is simulation-only at the hardware boundary (REQ-018), no static
timing closure is required of this module, and if a later phase cannot close the
path the remedy is a spec diff to REQ-306 plus an ADR, never an internal
register. Formulation (a) is the drop-in replacement at that point, observably
identical over REQ-302's domain, and swapping it changes no port, no caller and
no requirement. That escape hatch is written into the module's doc comment so
the option survives without me.

**The bit order, which is the one place a wrong reading is silent.** REQ-301's
"input reflected" means each octet enters least significant bit first; REQ-012
puts octet k at `data[8k+7:8k]`. Composing the two, the consumption order over a
whole word is simply `data` bit 0 upward — `bits_lsb` is already exactly that
order, and `chunks_of ~length:8` cuts it back into octets. A byte-wise
implementation XORs the octet into the register and then shifts eight times;
the bit-at-a-time form I used XORs each bit as it is consumed. These are the
same function because the step map S satisfies S(e_i) = e_{i-1} for i ≥ 1, so
S^8(e_i) = S^{8-i}(e_0) — the byte-wise form's contribution from bit i and the
bit-at-a-time form's contribution from bit i are the same term. I state the
argument here because "the two forms are obviously equivalent" is how a
byte-reversed CRC gets shipped.

**The value convention.** ADR-0006 is implemented as exactly two exclusive-ors
with 0xFFFFFFFF, one on `crc_in` and one on the multiplexer output; everything
between them is the raw reflected register. That places the whole convention in
two named lines instead of spreading it, and it makes `crc_in` = 0x00000000
start the register at REQ-301's initial value 0xFFFFFFFF with no first-update
special case anywhere in this module or in M03/M04. The final XOR is applied
once **after** the multiplexer rather than eight times before it: the mask is
constant, so the two orders are the same function and this one is smaller.

**`octet_count` outside 1 … 8.** SPEC-M02 §6.3 item 1 leaves `crc_out`
unconstrained for 0 and 9 … 15, and ADR-0007 records *why*: an identity meaning
for 0 would make an accidental update-by-zero silently correct-looking, where
any other value keeps it a caller defect a bench can catch. I therefore tied
those eleven select values to the eight-octet tap and deliberately **not** to
`crc_in`. A 16-entry multiplexer list rather than a 9-entry one: Hardcaml
repeats the last case for unlisted indices, and relying on that would have hidden
this decision in a library convention instead of writing it down.

**What I did not do.** No RTL emission top for either module (WO-0016 out of
scope; M01 could never have one — REQ-808 excludes types-only modules by name).
No dune edit: `libs/hardcaml_ethernet/src/dune` already declares
`(libraries hardcaml hardcaml_axi)` with `(pps ppx_hardcaml ppx_jane)` and no
`(modules)` field, so both new modules are built by `dune build @default` as
they stand — the correct wiring for deliverable 4 is the empty diff, which is
worth saying explicitly so it is not read as an omission. No `Scope.naming` on
the CRC taps: the only observable of a combinational function is `crc_out`, and
named internal wires would add emitted-Verilog nodes with no verification value.
No test of any kind, anywhere (charter red line).

### Actions

Written, all under `libs/hardcaml_ethernet/src/`:

- `axi64.ml` — SPEC-M01 §4.1 as frozen: `Axi64_config` (64/1), the single
  `Hardcaml_axi.Stream.Make` application, `Xgmii`, `Eth_header`, `Ip_header`,
  `Udp_header`, `Config` (twelve fields), `Status` (twenty-one strobes). Types
  only; no `create`, no `hierarchical`, no circuit.
- `axi64.mli` — the REQ-903 surface: the same eight items, records without
  `[@bits]`, `Axi64` exported through
  `module type of struct include … end`, and no `hierarchical`.
- `crc32_eth.ml` — `I` (`crc_in` 32, `data` 64, `octet_count` 4), `O`
  (`crc_out` 32), `create` and `hierarchical ?instance`. No `clock`, no
  `clear`, no register, no `Config` (REQ-306, §4.3).
- `crc32_eth.mli` — `I`, `O`, `val create`, `val hierarchical`.

Ran `tools/dv_checks.sh` (DV-owned, read-only, runnable in this container by
its own header) to see what my file set does to the mechanical checks. Ran a
throwaway Python model of the exact recurrence in the session scratchpad to
convince myself of the arithmetic before writing Hardcaml. Appended the Return
log to WO-0016 with per-REQ notes and the line-by-line self-review charter §3
requires of my own code. No git command of any kind was run beyond
`git status`/`git log` inspection (PROTOCOL §2).

### Evidence

**Local build is impossible and no local-build claim is made (ADR-0005).** This
container has `ocaml` and `opam` but no `dune` binary and no installed Hardcaml:
`/root/.opam/fpga/lib` contains `dune`, `stublibs` and `toplevel` only, and
hardcaml appears solely as unbuilt *sources* under `.opam-switch/sources/`.
Every OCaml correctness claim below is therefore a reading claim, and CI is the
adjudicator — the orchestrator round-trips it and relays the log verbatim.

API bindings verified by reading v0.17.1 sources (paths relative to
`/root/.opam/fpga/.opam-switch/sources/hardcaml/`):

- `src/comb_intf.ml` — `val of_int : width:int -> int -> t`;
  `val zero : int -> t`; `val lsb : t -> t`; `val srl : t -> int -> t`;
  `val mux2 : t -> t -> t -> t`; `val bits_lsb : t -> t list`;
  `val mux : t -> t list -> t` with "If [l] < 2\*\*[w], the last input is
  repeated" (my 16-entry list does not rely on it);
  `src/constant.ml` `of_int` truncates to `width` rather than raising, so
  `of_int ~width:32 0xedb8_8320` is well defined.
- `src/hierarchy.mli` — `In_scope (I) (O)` exports
  `val hierarchical : ?config:… -> ?instance:string -> ?attributes:… ->
  scope:Scope.t -> name:string -> create -> Circuit.With_interface(I)(O).create`,
  and `src/interface_intf.ml:375` gives
  `Create_fn(I)(O).t = Signal.t I.t -> Signal.t O.t`. My `hierarchical` takes
  `?instance` then `scope` then the input record, which is SPEC-M02 §4.1's
  `module type S` signature exactly.
- `ppx/src/ppx_hardcaml_zero.ml:832` — the signature generator emits only
  `include Ppx_hardcaml_runtime.Interface.S with type 'a t := 'a t` and reads no
  field attribute, which is why neither `.mli` carries `[@bits]`;
  `src/async_fifo.mli` is hardcaml's own precedent for the same asymmetry.
- dune 3.24.1 `src/dune_rules/ocaml_flags.ml` — the dev profile's warning set is
  `@`-prefixed (fatal) for `(lang dune 3.0)`, so unused opens and unused
  top-level values would be *errors*: hence `open!` on the two decorative opens,
  `_scope`, and no unused constant in either file.

**Mechanical checks, re-runnable at this commit's SHA:**

    $ tools/dv_checks.sh
    …
    PENDING  REQ-903: 2 of 20 inventory module(s) have an .mli; not written yet: xgmii_rx_64 … nic_top
    PENDING  REQ-306: crc32_eth is not in rtl_snapshots/ yet (M02 unbuilt)
    PENDING  REQ-808: inventory module(s) not yet emitted: crc32_eth … nic_top
    4 check(s) run, 0 failure(s), 4 pending
    dv_checks: all checks passed

The REQ-903 line moved from 0 of 20 to **2 of 20** and no `REQ-903(b)` failure
appeared, which is the mechanical confirmation that `crc32_eth.mli` exports
`hierarchical` and that `axi64.mli` correctly does not. The 16 C-9 record-vs-
appendix checks still pass, so nothing I wrote perturbed the frozen text they
compare.

**Arithmetic cross-check, and what it is not.** Before writing Hardcaml I
modelled the exact recurrence — `feedback = lsb(r) XOR bit; r >>= 1; if
feedback then r ^= 0xEDB88320`, with `r = crc XOR 0xFFFFFFFF` at both ends — in
Python in the session scratchpad
(`…/scratchpad/crc_model.py`, **an ephemeral artifact outside the repository, per
ADR-0003/F5**) and checked it against every anchor the specification pins:
SPEC-M02 §6.1 worked example 1 reproduced exactly (intermediate `0x9AE0DAAF`
after `12345678`, `0xCBF43926` after `9` — REQ-303); `crc_out` unchanged over
200 random draws of the ignored positions `data[63:8]` on that second update
(REQ-302's ignored-position clause); agreement with `zlib.crc32` over 3000
random octet strings consumed in randomly sized 1-to-8-octet updates
(REQ-301/REQ-305 in spirit); parallel-versus-serial equality over 2000 random
(crc, word, count) triples (REQ-302); and REQ-304's residue `0x2144DF1C` at
frame lengths 46, 60, 64, 100 and 1500 with the FCS appended least significant
octet first (REQ-202). **This carries no DoD weight and is not verification**
(charter §3): it is a throwaway smoke check of my own arithmetic, it never
touched the Hardcaml source, and the oracle that judges this module is
dv_lead's independent bit-serial reference under REQ-305, which must anchor on
REQ-303 before it may judge anything (PROTOCOL §10).

**Not claimed**: that either file compiles; that `crc32_eth` elaborates; that
any REQ is verified. Those are CI's and dv_lead's to say, in that order.

### Outcome

WO-0016 deliverables: (1) `axi64.ml` — done, §4.1 verbatim; (2) `crc32_eth.ml` —
done, REQ-301 … REQ-306 implemented with the per-REQ notes in the packet;
(3) `.mli` files — **both written**, on the frozen text's answer to C-8 rather
than on the work order's "if unclear" caveat, with the divergence flagged in the
Return log for the architect to bounce if I read it wrong; (4) dune wiring —
already correct, empty diff, stated rather than assumed. Out-of-scope items
(emission registration, tests, `docs/**`) untouched.

DoD status against charter §5: implements its frozen spec with no silent
deviation — **met, pending compile**; compiles and elaborates hierarchically —
**cannot be claimed here** (ADR-0005), CI round-trip owed; deterministic
emission into `rtl_snapshots/**` — **not applicable this packet** (no emission
top registered, by instruction); house style — met (`[@@deriving hardcaml]`
interfaces, `Hierarchy.In_scope`, library primitives, janestreet-profile
layout; the repository wires no `@fmt` alias, so this is by construction rather
than by check); line-rate invariant — not applicable, neither module is on
requirements.md §0.4's receive chain, and M02 contributes zero octet times by
REQ-306; worker review — none, both modules are mine; journal appended — this
entry. No DV sign-off is claimed or implied: `SO-M02` is dv_lead's.

Handoff: `agents/handoffs/WO-0016_m01-m02-implementation.md`, Return log
appended, state RETURNED for the orchestrator's CI round-trip.

### Open-questions

1. **`Axi64.Axi64` — an ergonomics wrinkle every later module inherits, raised
   now rather than at M03.** SPEC-M01 fixes both the path
   (`libs/hardcaml_ethernet/src/axi64.ml`, so the compilation unit is `Axi64`)
   and the name of the stream module inside it (`Axi64`), so a consumer writes
   `Signal.t Axi64.Axi64.Source.t` unless it first writes `open! Axi64`, after
   which the inner module shadows the outer and `Axi64.Source.t` reads
   correctly. I implemented the frozen text exactly and take the `open!` route
   as the house convention for M03 onward. It is not a defect and I am not
   asking for a re-freeze; I am asking the architect to confirm the convention
   in writing before batch B lands, because nineteen `I`/`O` records are about
   to depend on it.
2. **Should the library carry SPEC-M02 §4.1's `module type S` as a named module
   type?** In the lift it exists because a lift has no implementation to seal;
   in the library the `.mli` *is* that signature, and REQ-903(b)'s check greps
   the `.mli` for `val hierarchical`, which it now finds. If the architect
   intends `S` to be a named artifact — e.g. so M03/M04 could be functorised
   over the CRC engine — say so and I will add it; nothing else changes.
3. **The WO-0016 / frozen-text divergence on the `.mli` half of REQ-903** is
   recorded in the Return log. I resolved it towards the frozen text (both files
   written). If that reading is wrong, the fix is a deletion and it should come
   back as a bounce, not as a silent later cleanup.
4. **Compile risk, named so the round-trip is cheap.** The single construct in
   this delivery that no reading of the Hardcaml sources could fully settle for
   me is `axi64.mli`'s
   `module type of struct include Hardcaml_axi.Stream.Make (Axi64_config) end`,
   because `hardcaml_axi`'s sources are not present in this container (only
   hardcaml's are) and `docs/specs/architecture.md` §10 records its field names
   second-hand. If CI reddens there, the fallback is the plain
   `module type of Hardcaml_axi.Stream.Make (Axi64_config)` and, failing that,
   an `.mli`-level re-export of `Source`/`Dest` — which I would resist, per the
   Reasoning above.
5. **dv_lead's `of_source` retarget is now unblocked.** `J-dv_lead-0004` records
   that `test/axi64_probe/axi64_probe.ml` imports
   `Ifc_check.Axi64_ifc.Axi64` "until rtl_lead builds M01". M01 exists as of this
   entry; the retarget is dv_lead's one-line change in dv_lead's scope, and it
   should happen only after CI is green on this commit.

### Files-in-this-commit

- agents/handoffs/WO-0016_m01-m02-implementation.md
- libs/hardcaml_ethernet/src/axi64.ml
- libs/hardcaml_ethernet/src/axi64.mli
- libs/hardcaml_ethernet/src/crc32_eth.ml
- libs/hardcaml_ethernet/src/crc32_eth.mli

## [J-rtl_lead-0002] 2026-08-02T18:40:00Z | task:WO-0024 | The MAC layer written from the frozen batch-B specs: M03 as one shared rotation window with a three-age closure record, M04 as one signed position sequence, M05 as wiring

### Trigger

Orchestrator work order `agents/handoffs/WO-0024_batch-b-rtl.md` (spawn
short-id `WO-0024/2026-08-02T16:50Z`) — the second RTL activation and the
first to carry full behavioural specifications rather than a types module and
a combinational function. Mid-activation the orchestrator relayed an API
hard-limit termination of my first attempt (nothing had reached disk) with a
mandatory incremental-write discipline; this entry covers the completed unit
of work, written M03 → M04 → M05 so an interruption could lose at most one
module.

### Inputs

Governance: `agents/charters/rtl_lead.md`, `agents/PROTOCOL.md` (§4 grammar,
§6 scopes, §10 independence), the work order above.

Frozen specifications, read in full including **every §13 row**:
`docs/specs/modules/xgmii_rx_64.md` (SPEC-M03, FROZEN at `f78766e`, six §13
rows through **C-18**), `docs/specs/modules/xgmii_tx_64.md` (SPEC-M04, five
§13 rows through **C-16** and **C-31**), `docs/specs/modules/eth_mac_10g.md`
(SPEC-M05, §13 empty). Their lifts `docs/specs/ifc_check/{xgmii_rx_64_ifc.ml,
xgmii_tx_64_ifc.ml,eth_mac_10g_ifc.ml}`. `docs/specs/requirements.md` §0.3
(frame lengths and the inter-frame-gap convention), §0.4 (the receive path and
the stress list), §0.5 (octet time, front offset h, word delay ΔC), §0.6
(aborts, strobes, conservation), §0.7 (zero-length payloads), §1 (REQ-001 …
REQ-021), §1.1 (the ΔC ceilings), §2 (REQ-101 … REQ-113 and the five control
characters), §3 (REQ-201 … REQ-210), §9 (REQ-802, REQ-803, REQ-808, REQ-810),
§9.1, §10 (REQ-902, REQ-903), §12 (the strobe appendix).
`docs/specs/architecture.md` §2.3, §4, §6.3. ADRs: **ADR-0010** (consumer
conventions — `open! Axi64` normative, no named `module type S`), ADR-0006
(finished-value CRC ports), ADR-0007 (`octet_count` domain 1–8 and the
caller-side enable), ADR-0008 and ADR-0011 read for the M04-adjacent context
the work order named.

My own delivered M01/M02 at `189d5b2`:
`libs/hardcaml_ethernet/src/{axi64.ml,axi64.mli,crc32_eth.ml,crc32_eth.mli,
word_counter.ml,word_counter.mli,dune}`. `bin/generate.ml`, `bin/dune`,
`dune-project` read to decide the emission question. DV-owned material read,
never modified: `tools/check_emitted_verilog.sh` (its REQ-903 and REQ-808
checks are what my file set has to satisfy).

Toolchain sources, read to bind every construct to a real signature rather
than to memory (ADR-0005 leaves no other way), under
`/root/.opam/fpga/.opam-switch/sources/`: hardcaml v0.17.1
`src/always.mli` (the `Variable`/`State_machine` surface),
`src/comb_intf.ml` and `src/comb.ml` (`popcount`'s
`ceil_log2 (width+1)` result width, `onehot_to_binary`'s
`num_bits_to_represent`, the signed comparison operators),
`src/signal_intf.ml` (`reg`, `reg_fb`, `wire`, `( <== )`),
`src/reg_spec.mli`, `src/hierarchy.mli`; and
`dune.3.24.1/src/dune_rules/ocaml_flags.ml`, re-read to confirm the dev
profile's fatal-warning set **excludes 40, 41 and 42** (so type-directed
constructor and label disambiguation is safe) while **including 26, 27 and
32** (so every unused binding is an error — which is why several
documentation-only constants were deleted rather than left).

**Licensing honesty (charter §8)**: `Essenceia/Nasdaq-HFT-FPGA` was **not**
consulted for any part of this unit of work. `alexforencich/verilog-ethernet`
was **not** opened either; each spec's prior-art row records that its
decomposition influence is already spent in the specification, and every
structure below is derived from the frozen text.

### Reasoning

**The implement-versus-decompose call, and why it went the way it did.** The
work order left M04 and M05 to my judgement. I implemented all three. The
argument is that M04's specification is *harder* than M03's, not easier:
C-16's C+8 rule, C-14.1's `tx_tready` rule, C-14.2's reset precedence and
C-31's ordered-and-unpinned §9 are four carry-forwards whose whole purpose is
that a *plausible* reading of the older text fails a conformant design. A
worker packet must restate them exactly; a packet that restates them
imperfectly yields RTL that compiles, reads correctly and misses REQ-209's
eleven-cycle cadence by one cycle — which is the precise failure C-16 was
written to prevent. Writing a packet faithful enough to avoid that is writing
M04's timing contract out longhand, and costs more than implementing it. M05
is eighty lines of wiring, below the threshold where a spawn round-trip pays.
The cost I accept and record: none of the three has independent review, and
self-review is not review. The compensating controls are dv_lead's suites and
the auditor's mutation campaign, and I say so in the packet rather than
letting §4's self-review section stand in for them.

**M03's one real design decision: a shared rotation window.** REQ-021 makes
frame octet 0 land in `tdata[7:0]` at both start lanes, and §7 pins ΔC = 3 at
both — so a lane-4 frame's octets arrive four octet times later while its
first output word leaves on the same cycle. Three shapes were available.

- *(a) Two datapaths, one per start lane, selected per frame.* Rejected: it
  doubles the payload registers, which REQ-019 caps at two datapath words, and
  it makes every later reader check that the two agree.
- *(b) An octet accumulator with a fill level — the general realignment
  shifter.* Rejected for this module: it is the Phase-2 hard block's
  structure, it is elastic by nature, and elasticity is the one property a
  module under the line-rate invariant must not have. It would also make ΔC a
  function of the fill level rather than a constant.
- **(c) One rotation over the two-word window {this word, the previous word},
  applied identically to the octets and to their per-lane coverage vector —
  chosen.** At offset 0 the aligned word *is* the previous input word; at
  offset 4 it is the previous word's upper four octets followed by this word's
  lower four. Aligned word *m* is then the frame's output word *m* − 2 **at
  both start lanes**, so ΔC = 3 falls out of the structure rather than being
  arranged, and the payload storage is the input register plus the output
  register — two words, REQ-019's ceiling, not a coincidence but the
  lookahead §6.1 describes.

**The consequence that makes the FCS strip free.** Because the coverage
vector is rotated by the same window as the octets, the emitted word's
`tkeep` and `tlast` are a function of exactly two numbers: the octet count of
the word being emitted (registered) and of the word behind it (combinational,
this cycle — the one word of lookahead). A frame's octets are contiguous from
aligned position 0, so a word with fewer than eight octets is *necessarily*
the frame's last; "fewer than eight behind me" is therefore the end-of-frame
signal, and the four FCS octets are unmarked wherever they straddle the two
words. No counter of delivered octets exists, which matters because such a
counter needs the frame's total before the first word leaves — the definition
of store-and-forward, which REQ-005 forbids. The same two numbers with a
strip of 0 instead of 4 give REQ-103's "no FCS removal is attempted" for
aborted, truncated and cut-short frames, so those cost nothing.

**REQ-108 without a second coverage rule.** Coverage is capped at 1518
received octets and the four-octet tail removal then runs, delivering exactly
1514. The alternative — capping coverage at 1514 — was rejected because
coverage also feeds the CRC, and stopping at 1514 would leave the FCS octets
of a *legal* 1518-octet frame uncovered and fail every maximum-length frame.
The arithmetic coincidence is documented in the source so no later reader
"fixes" it: nothing identifies an FCS on a truncated frame, and
`error_bad_fcs` is never evaluated there (§9).

**Reporting: a three-age closure record rather than a latch.** §9 pins each
strobe to the cycle the frame's `tlast` word is emitted, and to *two cycles
after the closing input word* for a frame that emits none — and §6.1's own
derivation puts the `tlast` at zero, one or two cycles after closure
depending on start lane and length. A single latched record loses a frame's
report when the next frame closes on the drain's last cycle, which is
reachable with a normal frame followed by a sub-5-octet runt: closures are at
least two cycles apart, so two records can be live at once. The record
therefore travels as three ages — age 0 combinational, ages 1 and 2
registered — consumed oldest-first, with age 2 forced. That bound is derived,
not assumed: a closure sends the machine to `Idle` or `Discard` for at least
one cycle and a new frame spends its start word there.

**M04: one signed position sequence.** Every octet of a transmitted frame has
a position counted from the first destination-address octet, and payload, pad
(REQ-203), FCS (REQ-202) and terminate (REQ-205) are four boundaries on that
one axis. Taking them relative to the composed word's position as **signed**
offsets means a boundary already passed is negative — which is exactly how an
FCS split across two words is expressed without a second counter, and how a
word carrying payload, pad, FCS and the terminate character at once needs no
special case. The rejected alternative was §6.2's seven states implemented as
seven behaviours: `Frame`, `Pad` and `Fcs` are three regions of one sequence,
and making them three behaviours puts every straddle in the transitions
between them, which is where this kind of module goes wrong.

**Why that shape settles C-16 without a rule for it.** `tx_tready` is
asserted exactly when the composer consumes a payload word this cycle. At C+8
it consumes the `tlast` word's remaining four octets, so `tx_tready` = 1
there with no clause of its own; at C+9 it consumes nothing, so `tx_tready` =
0. §7's four consequences then hold by construction: C+8 carries no
obligation (the underflow window closed when the `tlast` word was accepted),
a word presented there is the next frame's first and is accepted into the
two-entry holding structure, the start character stays where REQ-204's
rounded gap puts it because the gap counter and not the depth fixes it, and
the C+8/C+11 pair cannot exceed two accepted-untransmitted words because that
bound *is* the `tx_tready` full condition. C-14.1's "1 again on the gap's last
cycle" is the same mechanism seen from the other side: the gap's last cycle is
the cycle on which a frame may begin.

**REQ-206's two-cycle wire consequence is structural.** A word accepted on
cycle *a* is composed on *a*+1 and reaches the wire on *a*+2. So the strobe
pulses on the acceptance cycle where the word was required and absent, the
composer finds the holding structure empty on the next cycle and composes the
abort word, and that word reaches the wire on the cycle after — §9's "the wire
consequence follows two cycles later", with no delay line to get wrong.
`tx_tready` is suppressed while starved, which is what keeps the strobe one
cycle wide rather than high until the frame ends.

**M05.** Two `hierarchical` calls and a record of pass-throughs; no register,
no mux, no logic, so §7's "zero octet times added" and §8's structural-wrapper
exemption hold by construction and §6.1's total table is checkable by reading
the file against it. §6.3 item 2 left the `.mli` re-exports to me: it
re-exports nothing, because a consumer already has M01's records through
`Axi64` and a re-export is a second place for the same names to drift.

**What I did not do.** No emission registration and no `rtl_snapshots/`
change: SPEC-M05 §12 names no entry point, the work order says to return the
question in that case, and the determinism evidence my charter §8 requires of
any such change is evidence I cannot produce without a build (ADR-0005). No
`dune` edit — the library declares no `(modules)` field, so the correct diff
is empty, which is worth stating so it is not read as an omission. No test of
any kind, anywhere, and no smoke sim: charter red line, PROTOCOL §10.

### Actions

Written, all under `libs/hardcaml_ethernet/src/`:

- `xgmii_rx_64.ml` / `.mli` — M03. `I` (`clock`, `clear`, `xgmii_rx` with
  `[@rtlprefix "xgmii_rx"]`, `cfg_rx_enable`), `O` (`rx` with
  `[@rtlprefix "rx_"]` plus the five strobes), a four-state `Always`
  machine (`Idle`, `Preamble`, `Frame`, `Discard`), the shared rotation
  window, the three-age closure record, one `Crc32_eth.hierarchical`
  instance, `create` and `hierarchical ?instance`.
- `xgmii_tx_64.ml` / `.mli` — M04. `I` (`clock`, `clear`, `tx`, `cfg_ifg`,
  `cfg_tx_enable`), `O` (`tx_dest`, `xgmii_tx`, `error_underflow`), a
  four-phase `Always` machine (`Idle`, `Body`, `Abort`, `Gap`) with §6.2's
  seven states mapped onto it in the source, the two-entry holding
  structure, the signed position sequence, one `Crc32_eth.hierarchical`
  instance, `create` and `hierarchical ?instance`.
- `eth_mac_10g.ml` / `.mli` — M05. `I`/`O` per SPEC-M05 §4.1, two child
  instantiations, ten pass-throughs, no logic.

Appended the Return log to `agents/handoffs/WO-0024_batch-b-rtl.md` with the
implement-vs-decompose call, the per-module rationale, the line-by-line
self-review, the compile-risk register and four returned questions. No `git`
command of any kind was run (PROTOCOL §2). No file outside my write scope was
modified.

### Evidence

**No local build exists and no local-build claim is made (ADR-0005,
REQ-906).** This container has no `dune` binary and no installed Hardcaml —
hardcaml appears only as unbuilt sources under `.opam-switch/sources/`. Every
OCaml correctness claim here is a reading claim; CI is the adjudicator and
the orchestrator round-trips it.

API bindings verified by reading v0.17.1 sources (paths relative to
`/root/.opam/fpga/.opam-switch/sources/hardcaml/`):

- `src/always.mli` — `Always.State_machine.create : ?encoding -> ?auto_wave_format
  -> ?enable -> (module State with type t = 'a) -> Reg_spec.t -> 'a t`, whose
  `State` requires `[@@deriving compare, enumerate, sexp_of]`; the record
  fields `is`, `set_next`, `switch`; `if_`, `when_`, `compile`.
- `src/comb.ml:889` — `popcount` result width is `Int.ceil_log2 (width + 1)`,
  so 4 bits for an 8-bit input; `src/comb.ml:963` — `onehot_to_binary` returns
  `num_bits_to_represent (width - 1)` bits, 3 for 8. Both are `uresize`d at
  the use sites rather than assumed.
- `src/comb_intf.ml` — `( <+ )`, `( >=+ )`, `( <=+. )`, `( >=+. )` (signed),
  `binary_to_onehot`, `sel_bottom`, `repeat`, `concat_lsb`, `concat_msb`,
  `select`, `mux`, `mux2`, `srl`.
- `src/signal_intf.ml:79` — `reg : Reg_spec.t -> ?enable:t -> t -> t` and
  `reg_fb : ?enable -> Reg_spec.t -> width:int -> f:(t -> t) -> t`; `wire`
  and `( <== )` for the declared-early signals.
- `src/hierarchy.mli` — `In_scope (I) (O)`'s
  `hierarchical : ?config -> ?instance:string -> ?attributes -> scope:Scope.t
  -> name:string -> create -> …`, matching each spec §4.1's `module type S`.
- `dune.3.24.1/src/dune_rules/ocaml_flags.ml:9-17` — the dev-mode fatal
  warning set excludes 40/41/42 and includes 26/27/32, which is the basis for
  both the constructor-disambiguation and the no-unused-binding claims above.

**Mechanical check, re-runnable at this commit's SHA:**

    $ tools/dv_checks.sh

expected to move REQ-903's line from `2 of 20` to `5 of 20` inventory modules
with an `.mli`, with no `REQ-903(b)` failure, since all three new `.mli` files
export `val hierarchical`. REQ-808 and REQ-306 stay PENDING: nothing new is
emitted this packet (see Open-questions 1).

**Self-review, and what it found** — four defects fixed before return, each
recorded in the packet's §4: a combinational loop in M04's `need_payload`
chain (an elaboration failure, not a wrong waveform); an unsaturated
`cap_end` in M03 producing spurious coverage in the states that cover
nothing; idle words inside an open frame decoded as eight data octets, which
would corrupt the CRC of every frame §10's REQ-016 wrapper touches; and a
lookahead that read the next frame's first aligned word as a continuation,
losing a REQ-110-aborted frame's `tlast`. A review section reporting nothing
is a review that was not done, so these are in the packet in full.

**Not claimed**: that any file compiles; that any module elaborates; that any
REQ is verified; that ΔC = 3 or L = 16/12 has been *measured*. Those are CI's
and dv_lead's to say, in that order. No `SO-` sign-off is claimed or implied.

### Outcome

WO-0024 deliverables: (1) M03 — done, personally, with the line-rate
invariant structural (no `tready` in the record, one XGMII word accepted per
cycle unconditionally) and ΔC = 3 by construction at both start lanes;
(2) M04 — done, personally, including C-16's C+8 rule and C-31's §9 reading;
(3) M05 — done, personally, wiring only; (4) emission registration — **not
done, question returned**, because SPEC-M05 §12 names no entry point and the
determinism evidence such a change owes cannot be produced blind. `dune`
untouched by design.

DoD status against charter §5: implements its frozen spec with no silent
deviation — **met, pending compile**, with the two readings I had to make
(single closure per input word; idle inside a frame's own preamble out of
scope) **declared as questions rather than resolved silently**; compiles and
elaborates hierarchically — **cannot be claimed here** (ADR-0005), CI
round-trip owed; deterministic emission — **not applicable this packet**;
house style — met (`[@@deriving hardcaml]` records, `Always` FSMs,
`Hierarchy.In_scope`, library primitives over hand-rolled equivalents,
`open! Axi64` per ADR-0010, no named `module type S`); line-rate invariant —
designed to it on M03 (zero backpressure structurally, two datapath words of
payload storage, no elastic buffer, no store-and-forward path), with DV's
back-to-back stress the proof I do not own; worker review — none, all three
modules are mine and the self-review is recorded as not being a substitute;
journal appended — this entry.

Handoff: `agents/handoffs/WO-0024_batch-b-rtl.md`, Return log appended, state
RETURNED for the orchestrator's CI round-trip.

### Open-questions

1. **Emission registration is owed and is deliberately not in this packet.**
   `bin/generate.exe` still emits only `word_counter`. Registering M05 (and
   with it M03, M04 and M02) is small, but the commit that does it must carry
   the REQ-902 double-generation byte-identity evidence, which needs a build.
   **Request: a follow-up WO after this one is CI-green.**
2. **Two closure characters in one input word**, beyond §10's
   `/S/`-then-`/S/` case, is unspecified and I implemented the
   single-closure-per-word reading. Declared, not discovered. Architect to
   confirm as §6.3 (unconstrained) or specify in §9 (a second report path).
3. **An idle word inside a frame's own preamble** contradicts §6.1's "exactly
   8 octet times after the start character"; M03 treats it as outside the
   specified stimulus space. Confirming that in §6.3 closes the last place
   REQ-016 and §6.1 can be read against each other.
4. **`cfg_rx_enable` = 0 with a REQ-110 `/S/` arriving mid-frame**: I abort
   and report the in-flight frame (it was accepted under the old value,
   REQ-803) and do not begin the new one (REQ-810). Raised so the reading is
   visible.
5. **Compile-risk register** is in the packet's §5, highest-risk first: the
   `Always.State_machine` deriver set (no precedent in this repository),
   constructor disambiguation, `popcount`/`onehot_to_binary` widths, the
   signed comparison operators, top-level `Signal.t` constants, and
   `open! Axi64` inside an `.mli`.

### Files-in-this-commit

- agents/handoffs/WO-0024_batch-b-rtl.md
- libs/hardcaml_ethernet/src/eth_mac_10g.ml
- libs/hardcaml_ethernet/src/eth_mac_10g.mli
- libs/hardcaml_ethernet/src/xgmii_rx_64.ml
- libs/hardcaml_ethernet/src/xgmii_rx_64.mli
- libs/hardcaml_ethernet/src/xgmii_tx_64.ml
- libs/hardcaml_ethernet/src/xgmii_tx_64.mli
