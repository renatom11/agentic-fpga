# WO-0016: Implement M01 `Axi64` and M02 `Crc32_eth` (first RTL activation)
- **State**: ACCEPTED
- **From** / **To**: orchestrator → rtl_lead
- **Spec basis** (PROTOCOL §10 — this packet is your whole authority):
  SPEC-M01 (docs/specs/modules/axi64.md) and SPEC-M02
  (docs/specs/modules/crc32_eth.md), both **FROZEN at f78766e** and
  byte-unchanged since (the working tree's copies ARE the frozen text;
  §13 of each records the only amendments, none touching §4). ADR-0004
  (Hardcaml v0.17.x from opam), ADR-0005 (CI is the authoritative build
  environment), ADR-0006 (CRC finished-value ports, seed 0x00000000).
  The compile-checked lifts docs/specs/ifc_check/axi64_ifc.ml and
  crc32_eth_ifc.ml elaborate green in CI (latest witness: run
  30736107842) — your modules must expose interfaces the rest of the
  library can `open` with those exact record shapes.
- **Deliverables**, in order:
  1. `libs/hardcaml_ethernet/src/axi64.ml` — SPEC-M01. Types only, no
     circuit: the programme stream types at 64 bits, the `Xgmii`
     lane-pair record, `Eth_header`/`Ip_header`/`Udp_header`,
     `Config`/`Status`, exactly as §4 writes them. This module is the
     vocabulary every later module opens; field names, widths and
     `rtlprefix` attributes are normative from the spec, not stylistic.
  2. `libs/hardcaml_ethernet/src/crc32_eth.ml` — SPEC-M02, on your
     personally-implemented list (charter §2). Combinational CRC-32
     (IEEE 802.3) update for 1–8 octets per cycle: the finished-value
     port convention and seed 0x00000000 per ADR-0006; the per-octet-
     count update matrices per §6/§7. REQ-301…306 govern; §8's anchor
     vectors (residue 0xCBF43926 / complement 0x2144DF1C) are what dv's
     oracle will hold you to.
  3. `.mli` interfaces if and only if the spec's §4 implies a narrower
     public surface than the `.ml` (REQ-903's `.mli` half is still an
     open C-8-adjacent item — do not invent policy; if unclear, return
     the question).
  4. dune wiring so `dune build` covers both modules in CI. Do NOT
     register RTL emission tops for these (M01 has no circuit; M02's
     emission decision belongs to a later packet).
  - Journal **J-rtl_lead-0001** (your first entry — the seed header is
    in agents/journals/claude_rtl_lead_agent.md); Files-in-this-commit
    = exactly what you touch plus this packet. Return log in this
    packet with per-REQ implementation notes and your line-by-line
    self-review (charter §3 requires it even for your own code).
- **Definition of done**: both files written to compile against
  hardcaml v0.17 + hardcaml_axi from reading alone (the container
  cannot run dune — ADR-0005; I round-trip CI and relay the log
  verbatim if red); interfaces record-compatible with the frozen §4.1
  lifts; no REQ silently narrowed; ambiguities returned as questions,
  never guessed.
- **Out of scope**: tests of any kind (dv_lead owns every test that
  gates your modules — charter red line); `test/**`, `tools/**`,
  `docs/**` (spec problems come back as Return-log questions for the
  architect, not edits); M03+ (later packets); RTL emission registration.
## Task
First RTL activation of the programme. M01/M02 have been FROZEN longest
(f78766e, two countersign cycles ago) and sit at the bottom of every
dependency chain — the vocabulary module and the CRC engine the MAC
builds on. Write them as the frozen text says, and say so where the
text made you choose.
## Return / verdict log

### RETURNED — rtl_lead, 2026-08-02T07:55Z (`J-rtl_lead-0001`)

**State**: ISSUED → **RETURNED**. Both modules written from the FROZEN text at
`f78766e`; nothing is claimed to compile (ADR-0005 — this container has no
`dune` and no installed Hardcaml), so the CI round-trip is owed and this packet
stays open until it is green.

#### 1. Delivered

| Path | What it is |
|---|---|
| `libs/hardcaml_ethernet/src/axi64.ml` | SPEC-M01 §4.1, records byte-identical to the lift |
| `libs/hardcaml_ethernet/src/axi64.mli` | REQ-903(a) surface; no `hierarchical` (REQ-903(b) excuses M01 by name) |
| `libs/hardcaml_ethernet/src/crc32_eth.ml` | SPEC-M02: `I`, `O`, `create`, `hierarchical ?instance` |
| `libs/hardcaml_ethernet/src/crc32_eth.mli` | REQ-903(a)+(b) surface |

**Deliverable 4 (dune wiring) is deliberately an empty diff.**
`libs/hardcaml_ethernet/src/dune` already declares
`(libraries hardcaml hardcaml_axi)` and `(preprocess (pps ppx_hardcaml ppx_jane))`
and carries no `(modules)` field, so `dune build @default` picks both new
modules up unchanged. No emission top was registered for either module
(instructed out of scope; M01 could never have one — REQ-808 excludes types-only
modules by name).

#### 2. Per-REQ implementation notes

**M01 (`Axi64`)** — REQ-010, 011, 012, 013, 014, 802 owned; 002, 003, 017, 808,
903 bind it.

| REQ | Where it lands in the code |
|---|---|
| REQ-002 | `Axi64_config.data_bits = 64`, applied once. No other width is obtainable from this module; the `.mli` exports the value, not a way to change it. |
| REQ-003 | `Source` and `Dest` stay the distinct records `Hardcaml_axi.Stream.Make` produces — the `.mli` exports them through `module type of struct include … end` precisely so they are not re-declared and cannot be merged. |
| REQ-010 | One `Stream.Make` application, in one file, exported by one `.mli`. The `open! Axi64` line in `crc32_eth.ml` is the idiom that keeps it that way — the same reason the lifts write `open! Axi64_ifc`. |
| REQ-011/013/014/015/016 | Field meanings are §6.1's and belong to producers; M01 supplies the fields and the `user_bits = 1` that stops `tuser` growing a second meaning. |
| REQ-012 | The octet-position convention is stated, not computed: nothing in M01 shuffles octets, and the same convention is what M02's bit order is derived from. |
| REQ-017 | `Xgmii` with fields `d`/`c` exactly — the two-character names are load-bearing, since `[@rtlprefix "xgmii_rx"]` + `d` is the only way to emit `xgmii_rxd`. Not renamed, not lengthened. |
| REQ-802 | `Config` carries the twelve §9.1 fields at §9.1 widths in §9.1 order; no `[@rtlprefix]` here, because that is an instantiation-site property (§4.1 conformance bullet 2) and M01 has no sites. |
| REQ-804 | `Status` carries the twenty-one §12 strobes, names and order untouched. |
| REQ-808 | No `create`, no `hierarchical`, no circuit: M01 cannot appear in `rtl_snapshots/`. |
| REQ-903 | `.mli` written (see §4 below); `hierarchical` deliberately absent, which `tools/check_emitted_verilog.sh` confirms by printing no M01 note. |

**M02 (`Crc32_eth`)** — REQ-301 … REQ-306 owned.

| REQ | Where it lands in the code |
|---|---|
| REQ-301 | `reflected_polynomial = 0xEDB88320` is 0x04C11DB7 bit-reversed, which is what "input and output reflected" means for a register that shifts down; initial value and final XOR are the single `xor_mask` applied at each end (ADR-0006), so REQ-301's 0xFFFFFFFF never appears at a port. |
| REQ-302 | One update covers 1 to 8 octets: the recurrence is elaborated once as a 64-step prefix chain and tapped after each octet, so (a) the tap for n octets is a function of `data[8n-1:0]` only — the ignored-position clause holds by construction, with no mask to get wrong — and (b) the tap for n is literally n consecutive one-octet updates, which is the serial equivalence the REQ-302 comparison test drives. |
| REQ-303 | Falls out of REQ-301's parameterisation; the port convention means the constant is observed at `crc_out` with no adjustment. Reproduced in a scratchpad model before writing Hardcaml (§7). |
| REQ-304 | Same; the residue is a property of REQ-202's wire order, and this module neither knows nor constrains that order. |
| REQ-305 | Nothing here converts anything: `crc_out = reference(crc_in, octets)` is an identity comparison, which is the property the oracle relationship depends on. The reference itself is dv_lead's and must anchor on REQ-303 first (PROTOCOL §10). |
| REQ-306 | No register, no `clock`, no `clear`, no `Config`, no handshake. The emitted module will contain no `posedge`; `tools/check_emitted_verilog.sh` will confirm that mechanically once an emission top exists (a later packet). |
| REQ-002/012/021 | `data` is one 64-bit `Axi64` word; octet k is `data[8k+7:8k]`; octets are consumed from position 0 upward, contiguously. |
| REQ-808/903 | `hierarchical` names the circuit `crc32_eth` — the architecture.md §4 inventory spelling the REQ-808 name comparison uses — and the `.mli` exports both entry points. |

#### 3. Decisions the specifications left to me

1. **Formulation of the update (SPEC-M02 §6.3 item 2, explicitly unconstrained).**
   Chose the reflected bit recurrence elaborated as a 64-step prefix chain with
   eight taps and a 16-way multiplexer, over (a) elaboration-time GF(2) matrices
   per octet count and (b) a table-driven form. Deciding argument: under
   ADR-0005 I can neither compile nor simulate, and by charter red line I may
   not write the tests that gate this module, so correctness has to be
   establishable **by reading the source against REQ-301** — which the
   recurrence is and a matrix is not. Secondary: the chain is shared across all
   eight counts, and the ignored-position property is structural rather than
   masked. Cost: source-level depth. SPEC-M02 §7 settles that for Phase 1 (no
   timing closure required; a later phase's remedy is a spec diff to REQ-306
   plus an ADR, never an internal register), and the matrix form is the drop-in
   replacement at that point with no port, caller or requirement affected. The
   module's doc comment records this so the option survives me.
2. **Out-of-domain `octet_count`.** 0 and 9 … 15 select the eight-octet tap and
   deliberately not `crc_in`. §6.3 item 1 leaves them unconstrained; ADR-0007's
   argument decides the direction — an identity meaning for 0 would make an
   accidental update-by-zero silently correct-looking. A full 16-entry
   multiplexer list, rather than a 9-entry one relying on Hardcaml's
   "last case repeated" rule, so the decision is written down rather than
   inherited from a library convention.
3. **Where the two `xor_mask` applications sit.** One on `crc_in`, one after the
   multiplexer (not eight times before it — the mask is constant, so the orders
   are the same function and this one is smaller). ADR-0006's whole convention
   is therefore two named lines.
4. **`Scope` unused in `create`.** No `Scope.naming` on the internal taps: the
   only observable of a combinational function is `crc_out`, and named internal
   wires would add emitted-Verilog nodes with no verification value. `create`
   still takes the `Scope.t` SPEC-M02 §4.1 declares.
5. **How `axi64.mli` names the stream module.**
   `module type of struct include Hardcaml_axi.Stream.Make (Axi64_config) end` —
   the non-re-abstracting idiom, so consumers keep the exact `hardcaml_axi`
   types. Rejected: a hand-written `Source`/`Dest` signature (a record declared
   in a signature is a **new** nominal type, so it would sever the identity with
   `hardcaml_axi` and restate six field names this programme does not own —
   SPEC-M01 §11.4's point), and plain `module type of F(A)` (weaker, buys
   nothing).
6. **No `[@bits]` in either `.mli`.** The ppx's signature generator emits only
   `include Interface.S with type 'a t := 'a t` and consumes no field
   attributes, so a surviving `[@bits]` is an unconsumed attribute — an error,
   not a warning. `word_counter.mli` is the CI-green precedent; both new `.mli`
   files carry a comment saying why, so the next author does not "fix" it back.
7. **`crc32_eth.ml`'s `O` record is one line** (`type 'a t = { crc_out : 'a [@bits 32] } [@@deriving hardcaml]`)
   where the lift breaks before the deriver. Semantically identical; matches
   `word_counter.ml` and the `.ocamlformat` janestreet profile. Flagged only
   because it is the sole textual difference from the lift.

#### 4. One divergence between this packet and the frozen text, resolved towards the text

Deliverable 3 offers `.mli` files "if and only if the spec's §4 implies a
narrower public surface", and calls REQ-903's `.mli` half "still an open
C-8-adjacent item". The frozen text says the opposite, three times:

- SPEC-M01 §4.1, last conformance bullet: "**`create` and `hierarchical`: not
  applicable. The `.mli` is not.** … `libs/hardcaml_ethernet/src/axi64.mli` is
  the file that fixes which of these records are exported and at what widths …
  so it is required and §10 carries the row. This is carry-forward **C-8** …
  **closed** by the REQ-903 diff in this work order";
- SPEC-M01 §10's REQ-903 row and SPEC-M02 §10's REQ-808/REQ-903 row;
- requirements.md REQ-903 as amended 2026-08-02 (change-log row: "split into an
  `.mli` half and a `hierarchical` half, M01 excluded from the second only"),
  which `tools/check_emitted_verilog.sh` already implements as "an `.mli` for
  every inventory module, **M01 INCLUDED**".

So C-8 is closed in the direction of *required*, and writing both `.mli` files
is implementing frozen text rather than inventing policy. Flagged here rather
than resolved silently: if the work order's caveat reflects a live intent I
cannot see, this comes back as a bounce and the fix is two deletions.

#### 5. Questions returned to architect_docs_lead

1. **`Axi64.Axi64` — please confirm the consumer convention in writing before
   batch B RTL lands.** SPEC-M01 fixes the path
   (`libs/hardcaml_ethernet/src/axi64.ml`, hence compilation unit `Axi64`) and
   the name of the stream module inside it (`Axi64`), so a consumer writes
   `Signal.t Axi64.Axi64.Source.t` unless it first writes `open! Axi64`, after
   which the inner module shadows the outer and `Axi64.Source.t` reads as
   intended. I implemented the frozen text exactly and propose `open! Axi64` as
   the house convention for M03 onward — the same shape the lifts already use
   with `open! Axi64_ifc`. This is not a defect and I am **not** asking for a
   re-freeze; nineteen `I`/`O` records are about to depend on the answer, so I
   would rather have it stated than assumed.
2. **Should SPEC-M02 §4.1's `module type S` exist as a named module type in the
   library?** In a lift it exists because there is no implementation to seal; in
   the library the `.mli` *is* that signature, and REQ-903(b)'s check greps the
   `.mli` for `val hierarchical`, which it now finds. If `S` is meant to be a
   named artifact — e.g. so M03/M04 can be functorised over the CRC engine — say
   so and I will add it; nothing else changes.

#### 6. Compile-risk register (for the CI round-trip)

Ordered by my own estimate, highest first, each with the repair I would make:

1. `axi64.mli`'s `module type of struct include Hardcaml_axi.Stream.Make (Axi64_config) end`.
   `hardcaml_axi`'s sources are **not** present in this container (hardcaml
   v0.17.1's are, and I read them), so its `Config` parameter signature and
   result shape are known to me only through architecture.md §10 and the lift.
   Repair, in order: plain `module type of Hardcaml_axi.Stream.Make (Axi64_config)`;
   then, only if forced, an `.mli`-level re-export of `Source`/`Dest` — which I
   would resist for the reason in §3.5.
2. `List.folding_map` / `List.chunks_of ~length` in `crc32_eth.ml` — standard
   Base, but Base's sources are not in this container either. Repair: an
   explicit `let rec` over `List.split_n`, three lines, no behaviour change.
3. Everything else binds to signatures I read directly in
   `/root/.opam/fpga/.opam-switch/sources/hardcaml/` (v0.17.1):
   `of_int ~width`, `zero`, `lsb`, `srl`, `mux2`, `mux`, `bits_lsb`,
   `Hierarchy.In_scope(I)(O).hierarchical ?instance ~scope ~name`, and
   `Create_fn(I)(O).t = Signal.t I.t -> Signal.t O.t`.

#### 7. Line-by-line self-review (charter §3, on my own code)

**What I checked, mechanically where possible:**

- `axi64.ml`'s records against the frozen lift:
  `diff <(awk '/^module Axi64_config/,0' docs/specs/ifc_check/axi64_ifc.ml) <(awk '/^module Axi64_config/,0' libs/hardcaml_ethernet/src/axi64.ml)`
  → **empty**. Every field name, width and record order is the frozen text.
- `.ml` versus `.mli` field lists for all eight records (six in M01, two in
  M02), compared name-by-name and in order → equal, including `Config`'s twelve
  in §9.1 order and `Status`'s twenty-one in §12 order.
- `crc32_eth.ml`'s `I`/`O` against `crc32_eth_ifc.ml` → identical but for the
  `O` line break noted in §3.7.
- `tools/dv_checks.sh` (DV-owned, read-only) → 16 C-9 checks still PASS,
  `REQ-903` moved from 0 of 20 to **2 of 20** with no `REQ-903(b)` failure,
  which is the mechanical proof that `crc32_eth.mli` exports `hierarchical` and
  `axi64.mli` does not.
- Bit order by hand, twice: octet k at `data[8k+7:8k]` (REQ-012) combined with
  reflected input (REQ-301) makes the consumption order `data` bit 0 upward, so
  `bits_lsb` *is* that order. Then the algebraic check that consuming each bit
  as it arrives equals XOR-the-octet-then-shift-eight (S(e_i) = e_{i-1} for
  i ≥ 1, hence S^8(e_i) = S^{8-i}(e_0)) — this is the one place where a
  plausible misreading produces a byte-reversed CRC that still looks like a CRC.
- Widths at every operator: `lsb`/feedback 1 bit, `mux2` cases both 32,
  `srl … 1` 32, the multiplexer 16 cases of 32 selected by 4 bits, both
  `xor_mask` applications 32.
- Warning discipline against dune's dev profile (fatal warning set, verified in
  dune 3.24.1's `ocaml_flags.ml` for `(lang dune 3.0)`): both decorative opens
  are `open!`, the unused scope is `_scope`, and every top-level constant is
  used.

**What changed because of the review** (all before hand-off):

1. A stray duplicated `;;` after `create`, introduced while editing the final
   expression — removed. Caught by re-reading, not by a tool, which is the
   argument for the pass.
2. Two comments contained a quoted phrase spanning a line break. A `"` pair
   inside a comment is lexed as a string literal, so a newline inside it is an
   unescaped end-of-line in a string constant; that warning is not in dune's
   fatal set, but the risk was free to remove, so both phrases were rewritten
   without quotes.
3. `{e not}` (odoc emphasis) inside a plain `(* *)` comment → plain `NOT`.
   Markup in a non-doc comment is noise that reads like a mistake.
4. Added the explicit gloss `(register >> 1) XOR (feedback ? polynomial : 0)`
   above the recurrence line, so its operator precedence is checkable at a
   glance rather than derived.
5. Reflowed one comment whose line breaks had drifted mid-sentence.

**What I did not find**: no spec deviation, no missing REQ, no field or width
disagreement with §4.1, and nothing in either module that holds state, takes a
`clock`, or needs backpressure.

#### 8. Not claimed

That either file compiles; that `crc32_eth` elaborates; that any REQ is
verified. The arithmetic cross-check behind §2's REQ-303/304 rows is a
throwaway Python model of the recurrence run in the session scratchpad — an
ephemeral artifact outside the repository (ADR-0003/F5), carrying no DoD weight
(charter §3), which never touched the Hardcaml source. `SO-M02` is dv_lead's to
issue against dv_lead's own REQ-305 reference, and `P1-module-ready` is not
approached by this packet.

#### 9. Freeze-text verification (added after HEAD advanced mid-task)

This packet asserts both specs are "byte-unchanged since `f78766e`". They are
not byte-unchanged — `508eea2` (WO-0011) touched both — so I checked what
changed rather than taking the sentence at face value:

    $ git diff -U0 f78766e..HEAD -- docs/specs/modules/axi64.md
    @@ -3,2 +3,4 @@      (Status: DRAFT → FROZEN)
    @@ -607..632 @@       (§11.4/§11.5 closure rows, §12 freeze record, §13 note)
    $ git diff f78766e..HEAD -- docs/specs/modules/crc32_eth.md
                          (Status line, §12 freeze record, §13 note)

Both diffs are the freeze-flip transcription and nothing else: **§4, §6 and §7
of both specifications are byte-unchanged**, which is the substance of the
packet's claim and is what my transcription is against. The lifts
`docs/specs/ifc_check/{axi64,crc32_eth}_ifc.ml` have not changed since the
freeze at all.

`HEAD` moved from `cdad57e` to `dce8a8f` (WO-0015 batch-D countersign) while I
worked; that commit touched `docs/gates/` only and nothing this packet depends
on. My working set is the four `libs/` files plus this packet — no other
agent's in-flight work is mixed into it.

### ACCEPTED — orchestrator, 2026-08-02T07:50Z, journal `J-orchestrator-0053`

Committed as `189d5b2` (rtl_lead, `J-rtl_lead-0001`; late Return-log §9
fragment transcribed at 24d0385). **CI `build` run 30738000890 on
189d5b2: `success`, every step** — Build, expect tests, RTL generation,
DV mechanical checks, determinism check. The packet's owed round-trip
is closed green: the programme's first RTL compiled on its first
elaboration, blind-written, including both constructs the Return log's
§6 compile-risk register ranked highest (`module type of struct
include Hardcaml_axi.Stream.Make (Axi64_config) end` and the Base list
functions). Neither repair was needed.

Acceptance notes:
1. Pre-commit checks recomputed at acceptance time (record-identity
   diff vs the frozen lift: empty; dv_checks: 16 checks pass, REQ-903
   coverage 0→2 of 20 with no REQ-903(b) failure).
2. **The §4 flagged divergence is resolved in rtl_lead's favour**: the
   packet's deliverable-3 caveat ("REQ-903's `.mli` half still open")
   was my drafting error — the frozen text closes C-8 in the direction
   of *required* in three places, and rtl_lead implemented the frozen
   text and flagged rather than silently resolving. No bounce; the
   `.mli` files stand.
3. **Two questions queued for architect_docs_lead** (Return log §5,
   answer owed before batch-B RTL): (a) confirm `open! Axi64` as the
   house consumer convention for the `Axi64.Axi64` nesting; (b) whether
   SPEC-M02 §4.1's `module type S` should exist as a named library
   artifact (e.g. for functorising M03/M04 over the CRC engine). Folded
   into the WO-0017 return processing or the next architect packet.
4. Environment finding recorded for future RTL spawns: hardcaml
   v0.17.1 sources at `/root/.opam/fpga/.opam-switch/sources/hardcaml`
   (unbuilt, readable); `hardcaml_axi` and `base` sources absent.
