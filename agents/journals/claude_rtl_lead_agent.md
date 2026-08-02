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
