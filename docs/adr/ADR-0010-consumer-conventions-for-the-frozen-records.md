# ADR-0010: house conventions for consuming the frozen interface records — `open! Axi64`, and `module type S` stays a lift device

- **Status**: Accepted (architect decision, in-role under charter §3 and §7,
  answering two questions rtl_lead returned at WO-0016)
- **Deciders**: architect_docs_lead, on rtl_lead's proposal for (a) and against
  rtl_lead's conditional offer for (b)
- **Work order**: WO-0019 · **Journal**: `J-architect_docs_lead-0008`
- **Affects**: every RTL module under `libs/hardcaml_ethernet/src/` from M03
  onward, and every `rtl_module_dev` work order that quotes an `Interface`
  record. **No specification section changes and no interface record changes**:
  SPEC-M01 and SPEC-M02 are FROZEN at f78766e and neither is touched by this
  ADR, which is the point of putting the answer here. architecture.md §2.3
  carries a one-paragraph normative restatement so the convention is findable
  from the structural document as well as from this file.

## Context

rtl_lead implemented M01 `Axi64` and M02 `Crc32_eth` from the frozen batch-A
text at WO-0016, got both green on the first CI elaboration, and returned two
questions in its Return log §5. Both are about **how a consumer writes against
the frozen records**, neither is a defect in the frozen text, and rtl_lead
explicitly did not ask for a re-freeze for either. Nineteen `I`/`O` records are
about to be written against the answers, so they are worth a decision record
rather than a sentence in a work order.

**(a) The `Axi64.Axi64` nesting.** SPEC-M01 §4.1 fixes the path
(`libs/hardcaml_ethernet/src/axi64.ml`, hence the compilation unit `Axi64`) and
the name of the stream module *inside* it (`module Axi64 = Hardcaml_axi.Stream.Make (Axi64_config)`).
A consumer therefore writes `Signal.t Axi64.Axi64.Source.t` unless it first
writes `open! Axi64`, after which the inner module shadows the outer and
`Axi64.Source.t` reads as intended. rtl_lead implemented the frozen text exactly
and proposed `open! Axi64` as the house convention. The question is whether that
is *the* convention or one of two.

**(b) `module type S`.** SPEC-TEMPLATE rule 6 requires every spec's §4.1 block
to compile as a single `.ml` file, so entry points are declared inside a
`module type S` rather than as bare `val`s — the block has no implementation to
seal, and a bare `val` in an `.ml` file does not compile. In the library the
`.mli` *is* that signature, and REQ-903(b)'s mechanical check reads the `.mli`
for `val hierarchical`, which it now finds for `crc32_eth`. rtl_lead asked
whether `S` is *also* meant to exist as a named artifact in the library — for
example so that M03 and M04 could be functorised over the CRC engine — and
offered to add it.

## Decision

**(a) `open! Axi64` is the house consumer convention, and it is the only one.**
Every module under `libs/hardcaml_ethernet/src/` that names a programme record
opens `Axi64` at the top of the file, immediately after `open! Base` and
`open Hardcaml`, and then writes `Axi64.Source.t`, `Eth_header.t`, `Ip_header.t`,
`Udp_header.t`, `Xgmii.t`, `Config.t` and `Status.t` unqualified. Writing
`Axi64.Axi64.Source.t` in a module that has not opened `Axi64` is legal OCaml and
is **not** the house form; a module that mixes the two forms is a review defect
for rtl_lead to bounce.

Three consequences worth stating because packets will cite them:

1. **`open!` and not `open`.** The bang suppresses the unused-open warning, which
   dune's dev profile makes fatal, for a module that happens to reference no
   record on some future edit. Every lift in `docs/specs/ifc_check/` already uses
   `open!` for exactly this reason, and the library form matches the lift form
   line for line.
2. **The records a module opens are the records its ports use, and no others.**
   `open! Axi64` is not a licence to open every module: SPEC-M12 §4.1's rule —
   a lift that opens a module it does not use compiles and is still a lie about
   the dependency — binds the library the same way. A module whose ports carry
   `Arp_query` writes `open! Arp` beside `open! Axi64`; one whose ports do not,
   does not.
3. **This is a naming convention, not an interface change.** It constrains what
   an implementer types, not what the emitted Verilog contains: the port names
   are fixed by the records and their `[@rtlprefix]` values, and are identical
   under either form.

**(b) `module type S` does not become a named library artifact.** It stays what
SPEC-TEMPLATE rule 6 made it — a device that lets a specification's §4.1 block
compile standalone — and the library's module surface stays the `.mli`.
M03 and M04 are **not** functorised over the CRC engine; each references
`Crc32_eth` directly, as architecture.md §6.4.3's four control edges per
instance already describe.

## Alternatives

**(a1) Require the fully qualified `Axi64.Axi64.Source.t` everywhere and open
nothing.** Rejected. It is self-documenting exactly once and unreadable
thereafter — `Signal.t Axi64.Axi64.Source.t` appears in roughly a hundred record
fields across nineteen modules — and it diverges from the lifts, which open
`Axi64_ifc`. Divergence between the lift and the library is the thing this
programme most wants to avoid: `tools/check_records_vs_appendix.sh` compares the
two byte for byte at §4.1, and rtl_lead's own WO-0016 self-review compared
`axi64.ml` against the frozen lift with `diff`. A convention that made those two
files differ in their opens for no behavioural reason would cost that check its
simplicity.

**(a2) Rename the inner module — `Stream` inside `Axi64`, giving
`Axi64.Stream.Source.t` with no shadowing.** This is the option that would remove
the awkwardness at the root instead of papering over it, and it is rejected on
cost, not on taste: SPEC-M01 §4.1 is **FROZEN at f78766e**, its block is lifted
byte-identically into `axi64_ifc.ml`, and five freeze records cite the CI run
that elaborated it. Renaming `Axi64.Axi64` to `Axi64.Stream` is a breaking
post-freeze interface change to the programme's most-cited specification — the
first such change in Phase 1 — for a readability gain that one `open!` line per
file obtains for nothing. Post-freeze churn is counted (charter §6) and this
would be the wrong thing to spend the first count on. **If a later phase reopens
SPEC-M01 §4.1 for another reason, the rename is the first thing to do in the same
diff**, and this paragraph is here so that whoever opens it knows.

**(a3) Leave it unstated and let each module choose.** Rejected because rtl_lead
asked precisely so that it would not be left unstated, and because nineteen
modules choosing independently is nineteen chances for a reviewer to have to
think about something that has one right answer.

**(b1) Export `S` from each module's `.mli` as a named module type.** Rejected
on two independent grounds. First, it creates a **second** statement of the
module surface: the `.mli` already says what is exported and at what type, and
REQ-903's mechanical check reads the `.mli`. Two statements of one fact drift,
and the drift would be invisible — a module whose `S` and whose `.mli` disagree
still compiles, because nothing forces the implementation to be sealed by `S`.
Second, a named `S` in the library would be a module-surface artifact **that no
frozen specification binds**: §4.1's `S` is a lift device that the spec's own
text describes as such, so promoting it to a library artifact would create
exported structure with no specification behind it — which is the one thing the
charter's spec-before-RTL rule exists to prevent.

**(b2) Functorise M03 and M04 over the CRC engine** — `module Make (Crc : Crc32_eth.S)` —
which is the use rtl_lead named. Rejected. It buys the ability to substitute a
different CRC implementation, and nothing in Phase 1 wants one: REQ-305 already
requires the engine to agree with a **bit-serial software reference** over 10 000
randomised frames, so the independent oracle DV needs is a software model and not
a second RTL engine. Against that, the cost is real and structural: REQ-808
requires `crc32_eth` to appear as a distinct module in the emitted Verilog with
that exact name, instantiated inside both M03 and M04, and a functor parameter
makes the emitted hierarchy a function of an argument that no specification
pins — architecture.md §6.4.3's eight control edges (four per instance) name
`M02` on one end of each, not "whatever engine was passed in". A design whose
instance hierarchy depends on an unspecified functor argument cannot be checked
by `tools/check_emitted_verilog.sh`'s REQ-018 whitelist, which is a
**mechanical** check today.

**(b3) Define `S` once, programme-wide, as the shape every non-types-only module
has** (`create` + `hierarchical` taking a `Scope.t`). Tempting, and still
rejected: the shape is not uniform. M12, M13 and M16 take three optional REQ-506
parameters on both entry points and M19 and M20 take them too, so a single
programme-wide `S` would either exclude five modules or carry parameters the
other fourteen do not have. REQ-903's check does the job this module type would
do, and does it over the `.mli` where the surface actually lives.

## Consequences

- **`rtl_module_dev` work orders cite this ADR by number** for both conventions,
  and rtl_lead's review checklist gains two mechanical items: the file opens
  `Axi64` (and only the record modules its ports use), and the module exports
  `create` and `hierarchical` through its `.mli` with no named `S`.
- **The library and the lifts stay line-for-line comparable at the opens.** A
  lift writes `open! Axi64_ifc`; the library module writes `open! Axi64`. The
  difference is the file name and nothing else, which is what keeps
  `tools/check_records_vs_appendix.sh`'s byte-identity check readable when it
  fails.
- **No specification changes and no freeze evidence is invalidated.** SPEC-M01
  and SPEC-M02 are untouched, the batch-A/B compile evidence (CI run 30729342467
  at f78766e) still witnesses their records, and post-freeze churn stays at zero
  for both.
- **One thing is deliberately left open**, and it is (a2): the `Axi64.Axi64`
  nesting is a wart, it is recorded here as one, and the repair is queued behind
  any future reopening of SPEC-M01 §4.1 rather than pretended away. Nobody should
  discover it in year two and think nobody noticed.
- **Where this is restated**: architecture.md §2.3, one paragraph, so that a
  reader arriving at the fabric decision finds the consumer convention beside it.
  The normative statement is this ADR; the restatement names it, and the two
  change together (PROTOCOL §11's rule for a restated parameter).
