# WO-0034: The real-compile harness into tools/ — and the RFC anchor closed from CI
- **State**: ISSUED
- **From** / **To**: orchestrator → dv_lead
- **Spec basis**: your own J-dv_lead-0018 Open-questions ask (the
  three-lane harness "would be worth more committed under tools/
  where the auditor could re-execute it"); your J-dv_lead-0017
  Evidence item 7 + the WO-0033 acceptance block (RFC 1071 anchor
  open after five 403s across two egress paths; your named cheapest
  closure: one CI step); ADR-0005 (which blocks the Hardcaml
  toolchain, not the system compiler — your own discovery).
- **Deliverables**:
  1. tools/precompile_check.sh — the three-lane harness from the
     J-dv_lead-0018 addendum, reconstructed as a committed, auditor-
     re-executable script: lane 1 real-compiles the Hardcaml-free
     test libraries with the system ocamlc; lane 2 compiles
     Hardcaml-facing files against stubs transcribed from the real
     signatures (stubs committed beside it, marked as transcriptions
     with their source paths); lane 3 the cross-library
     qualification sweep. Self-documenting output; nonzero exit on
     any lane failure.
  2. Wire it into tools/dv_checks.sh (or its own CI step via a
     Return-log request to me if you judge the workflow file the
     better seam — build.yml is mine, tools/ is yours).
  3. A CI-side RFC 1071 anchor check: a step or script that fetches
     RFC 1071's text FROM THE RUNNER (its egress is open), extracts
     §3's example and the two §2 properties, and compares against
     `Ipv4_ref.rfc1071_example_{octets,sum,checksum}` — turning the
     open SO- obligation into a mechanically re-verified fact. If
     the fetch fails on the runner too, the obligation stays open
     and the step must say so loudly, not pass vacuously.
  4. Note for your Return log: whether rtl_lead can use lane 2's
     stub approach against hardcaml's real signatures (the sources
     are readable at the opam switch) — a question, not a build.
  - Journal **J-dv_lead-0019**; Files-in-this-commit exact.
- **Out of scope**: libs/**, docs/**, bin/**; build.yml (request,
  don't edit); committing.
## Task
Your harness caught nothing less than the org's first Build escape's
entire class. Commit it where the auditor can run it, and close the
one obligation your evidence left open.
## Return / verdict log

### RETURNED — dv_lead, `J-dv_lead-0019` (WO-0034/2026-08-03T10:05Z)

Four deliverables: three built, one answered. Everything below was
run, not predicted — that distinction is the whole point of
`J-dv_lead-0018` and I am not going to spend it twice.

#### 1. `tools/precompile_check.sh` — the harness, committed

Reconstructed from the J-dv_lead-0018 addendum §2 and then made
stricter, because testing it found two ways the scratch original was
**more permissive than dune** — i.e. two ways it could have passed
code CI would redden. Both are fixed and both now have a seeded
self-test.

```
tools/precompile_check.sh              lanes 1, 2, 2b, 3
tools/precompile_check.sh --self-test  three seeded defects, all must be caught
tools/precompile_check.sh --force      run even where the harness would stand down
tools/precompile_check.sh --warnings   advisory warnings-on pass
tools/precompile_check.sh --keep       keep the build workspace
```

**Lane 1** — `dv_golden`, `dv_monitors`, `dv_xgmii` compiled for real
with the system `ocamlc` 4.14.1, `.mli` before `.ml`, ppx_expect
syntax rewritten away by a transform that touches only the
`let%expect_test` wrapper and the `[%expect]` node. **31 units, 0
errors.** An unhandled ppx shape cannot slip past: `ocamlc` refuses an
uninterpreted extension node, so the lane goes red rather than
quietly skipping the file.

**Lane 2** — `dv_axi64_probe`, `dv_xgmii_probe` against the committed
stubs. **12 units, 0 errors.**

**Lane 2b — new, and the reason the stubs are worth committing.**
Stub fidelity, re-checked at run time:

- `precompile_stubs/ifc_check.ml` vs `docs/specs/ifc_check/axi64_ifc.ml`,
  field for field, for `Xgmii  Eth_header  Ip_header  Udp_header
  Config  Status`. The lift is committed here, so this comparison can
  never be skipped. Seeding `ethertype` → `ether_type` into the stub
  makes the lane print `STUB DRIFT` with the diff and exit 1.
- `precompile_stubs/hardcaml.ml` vs the hardcaml package sources. **The
  switch has hardcaml v0.17.1 unpacked** at
  `$(opam var switch)/.opam-switch/sources/hardcaml/src/` — not
  installed (ADR-0005 stopped that), but *readable*. All six names are
  found verbatim in `comb_intf.ml`, including
  **`val concat_lsb : t list -> t`** and **`val width : t -> int`** —
  two of the three names `J-dv_lead-0018` Evidence item 6 listed as
  reachable by no local check. They now are.
- What it cannot re-check, it prints as `UNVERIFIED-TRANSCRIPTION` and
  counts in the summary rather than passing over: `Axi64.Source` /
  `Axi64.Dest` (not in the lift — SPEC-M01 §11.4's known gap;
  hardcaml_axi sources are absent) and `base.ml`.

**Lane 3a — coverage.** Every `test/*/` directory is dispositioned
LANE1 / LANE2 / EXCLUDED-with-a-printed-reason, derived from its dune
file, and every `.ml`/`.mli` in a compiled directory must be
accounted for by a compiled unit (43 of 43). A new library is picked
up automatically; a directory with OCaml sources and no dune file
fails the lane. This is the anti-rot property: the harness cannot
decay into a checker of a shrinking subset without going red.
`test/cost_probe` is EXCLUDED as an executable stanza;
`test/hardcaml_ethernet` is EXCLUDED because it depends on
`hardcaml_waveterm` and `hardcaml_ethernet` — and the second of those
is `libs/**`, so stubbing it would mean reading the RTL under test.
That exclusion is principled, not unimplemented.

**Lane 3b — qualification.** The comment-stripped grep for a
sibling-library module named without its prefix. Zero hits.

**The two ways the scratch harness was wrong, found by testing this
one against synthetic libraries:**

1. *Wrapping.* A flat `ocamlc -I` resolves `Strobes.all` from any
   library; dune does not. The harness now mangles unit names as dune
   does (`dv_monitors__Strobes`), generates the `Dv_monitors__` alias
   module, and compiles with `-open Dv_monitors__ -no-alias-deps`.
2. *Isolation.* A shared build directory lets a library use a sibling
   its dune file never declares — dune rejects that and CI goes red.
   Each library now builds in its own directory with an include path
   of exactly its own directory plus its **declared** dependencies.

I would not have found either by re-reading the script. I found them
by feeding it a two-line synthetic library that should have failed
and watching it pass.

**Stubs, committed beside it**, each header naming its SOURCE, its
VERIFIED/UNVERIFIED status and its SCOPE, per
`tools/precompile_stubs/README.md`:

| file | source | re-checkable here |
|---|---|---|
| `hardcaml.ml` | hardcaml v0.17.1 `src/comb_intf.ml`, `src/bits.mli` | yes, when the switch has the sources |
| `ifc_check.ml` | `docs/specs/ifc_check/axi64_ifc.ml` (committed) | yes, always |
| `base.ml` | Base v0.17 `Array.init : int -> f:(int -> 'a) -> 'a t` | **no** — base is absent |

`base.ml` is a deliberate improvement on the scratch original, which
stubbed out `Axi64_probe` wholesale and so left **the one DV file
that names every `hardcaml_axi` `Source` field** as the one file lane
2 never checked. Stubbing one Base signature instead compiles the
real file. Its limit is stated in its header: everything else
`open! Base` would shadow resolves to Stdlib, so lane 2 checks that
file's scoping and arities and does not reproduce Base's shadowing.

#### 2. Wiring — `tools/dv_checks.sh`, no `build.yml` change requested

Wired into `tools/dv_checks.sh`, and I am **not** asking you for a
workflow step. `build.yml` already runs `tools/dv_checks.sh`, which
makes that script the DV line's own seam into CI: a check added there
reaches the runner with no workflow edit, no round trip through you,
and the auditor still re-executes the whole set with one command.
Both WO-0034 checks went there.

Strictness is deliberately **not** uniform, and the asymmetry is
argued in the file's header rather than left to be discovered:

- `precompile_check.sh` **stands down on a CI runner** (its GATE 2:
  real Hardcaml installed, or `$CI`/`$GITHUB_ACTIONS` set). On the
  runner `dune build @default` against real Hardcaml strictly
  dominates every lane; running a stub-based check beside the
  authoritative one could only produce a weaker signal or a false
  alarm the programme would learn to ignore. It prints why, and
  `dv_checks.sh` prints `SKIPPED — NOT coverage` rather than `OK`
  over the banner, because `OK` is what a reader scans for.
- `check_rfc1071_anchor.sh` is always invoked in its **strict** form
  and `dv_checks.sh` interprets its exit 2 by environment, visibly, in
  the log.

**One thing to expect, so it is not a surprise.** On the first CI run
carrying this, if the runner's egress to rfc-editor.org is *also*
blocked, the `DV mechanical checks` step goes **RED** with
`FAILED — unreachable ON A CI RUNNER`. That redness is the deliverable
working exactly as WO-0034 deliverable 3 specifies, not a defect: it
is the loud form of "the cheapest closure we named for this obligation
does not work either". If you would rather it not gate the build while
we find another route, the one-line change is in `dv_checks.sh`'s
`case "$rfc_rc"` block and it is mine to make on request — I have not
pre-emptively softened it, because softening it before we know is how
an open obligation becomes an invisible one.

#### 3. The RFC 1071 anchor check — `tools/check_rfc1071_anchor.sh`

Two lanes, three exit codes, and exactly one place in the script that
may set CONFIRMED.

**LOCAL (always runs, no network).** Parses the three constants out of
`test/golden/ipv4_ref.ml` — never hard-codes them; empty parses are a
hard failure, so it can never compare two empty strings and call it
agreement — then re-derives RFC 1071's arithmetic **in awk**, sharing
no code with `Ipv4_ref.sum`. Four checks, all green here: the sum
`0xddf2`, its complement `0x220d`, SPEC-M14 §6.1's residue form
(`0xFFFF`), and RFC 1071 §2's byte-swap invariance
(`sum(swap(octets)) = 0xf2dd = swap(sum)`). This proves the constants
are **consistent**. It does not prove they are **quoted** — only the
RFC's text can, and the script says so in those words.

**NETWORK.** Fetches from four sources in order, requires HTTP 200,
requires the body to identify itself (`Computing the Internet
Checksum` **and** `Numerical Examples`) before it will grep anything,
slices §3, then confirms the four octet pairs (and their wire order),
the sum and the checksum as **delimited hex tokens**, plus a
**negative control** — the deliberately wrong `0xddf3` / `0x220c` must
*not* appear, or the match is not discriminating and the run is not a
pass. The two §2 property citations are located and their enclosing
section number **reported as ADVISORY**: a keyword search over prose
cannot tell "the RFC says it elsewhere" from "my keywords are wrong",
so it may not gate a build; the three constants are exact hex tokens
and may.

**On success**: prints provenance (URL, byte count, sha256), `ANCHOR
CONFIRMED`, exit 0, and states that a sign-off citing the anchor must
cite a *run* of the script — its CI run id — not its existence.
A `--print-body` confirmation deliberately does **not** claim
discharge: it says `CONFIRMED AGAINST A LOCAL COPY`, because the
script did not fetch it and cannot vouch for where it came from.

**On failure**: exit 1 for a MISMATCH (fetched, sliced, constants
disagree — always a real failure everywhere); exit 2 for OBLIGATION
OPEN (could not fetch, or could not slice §3). It does **not** fall
back to grepping the whole document when §3 will not slice: "the token
appears somewhere in RFC 1071" is not the claim the oracle makes, and
confirming the weaker claim is the vacuous pass the script exists to
refuse.

**Its own behaviour is tested, not asserted.** `--self-test`
generates §3-shaped documents at run time from the oracle's own
constants, banner-marked SYNTHETIC and never written into the
repository, and requires five outcomes: well-formed → CONFIRM;
sum one bit off → REJECT; both right and wrong values present →
negative control fires; no sliceable §3 → exit 2; unidentified
document → exit 2. All five pass. **This says nothing about RFC
1071's real text.** It says the machinery that will read it is not a
rubber stamp — which is the only claim I can honestly make from an
environment that cannot fetch it.

**Here, it exits 2.** Four more 403s (rfc-editor ×2, ietf.org,
datatracker), plus one more from a fifth path — the agent's own
`WebFetch` tool, which is not `curl` through the proxy — bringing the
programme's tally to **ten refusals across four egress paths**. The
anchor obligation on `SO-ip_eth_rx_64.md` is therefore **still open at
this commit** and only CI can close it.

#### 4. Answer: can rtl_lead use lane 2's stub approach?

**The fidelity mechanism transfers and is worth taking today. The
compile lane does not transfer, and the blocker is `[@@deriving
hardcaml]`.**

*What is actually available.* The switch keeps hardcaml **v0.17.1**
unpacked at `$(opam var switch)/.opam-switch/sources/hardcaml/`. So
rtl_lead can **read** the real signatures. It cannot **build** them:
hardcaml v0.17.1's own opam file requires `ocaml >= 5.3.0`, `base
v0.17`, `ppxlib >= 0.36.0`, `zarith`, `core_kernel` — the system
compiler is 4.14.1 and none of those are installed. Reading is the
whole of what the sources buy. (`hardcaml_axi` is **not** in the
sources cache at all — only `hardcaml` and `dune` are — so anything
naming `Hardcaml_axi.Stream.Make` is unanchorable locally, which is
precisely the gap lane 2b already reports against `Axi64.Source`.)

*Why the compile lane does not transfer.* The criterion is sharp:
**lane 2 works where the ppx is REMOVABLE and fails where it is
GENERATIVE.** `ppx_expect` is removable — its output is test
scaffolding, so deleting it textually leaves every body intact and
every name still resolved, which is exactly what lane 1 does.
`[@@deriving hardcaml]` is generative: it *is* the module's port list,
widths, `map`/`iter`, and its `Interface.S` instance, all synthesised
from the record. Every RTL module's I/O is built out of that generated
code. A stub cannot supply it, because what is missing is not a
signature to transcribe but code keyed to each individual record —
and hand-writing it per module means boilerplate that must be kept in
step with the record, so the first time it drifts the harness lies.
The deriver itself (`ppx/src/ppx_hardcaml_zero.ml`) is a ppxlib plugin
and is no more buildable here than hardcaml is.

*And the surface is a different order of magnitude.* DV's lane 2
needed **six** `Bits` names. `comb_intf.ml` alone declares **176**
`val`s; add `Signal`, `Always` (186 lines of interface), `Interface`
(398), `Scope`, `Instantiation`, `Reg_spec`. A stub for RTL is not a
transcription, it is a re-implementation, and a re-implementation that
is wrong is worse than no harness because it is trusted.

*What I would actually recommend, and it is cheap.* Take **lane 2b's
mechanism, not lane 2's**: a name-existence check. Extract every
`Signal.*` / `Always.*` / `Bits.*` / `Instantiation.*` name the RTL
uses and confirm each appears in v0.17.1's `*_intf.ml` / `.mli` at the
recorded path. No stubs, no compile, no ppx — and it catches "this
name does not exist in v0.17.1", which is a real and recurring
red-build class (it is the class `Bits.concat_lsb` and `Bits.width`
sat in until this commit). If rtl_lead wants genuine compile coverage
on top, the cheaper seam is structural: keep deriver-free helper
modules — pure `Signal.t -> Signal.t` combinational functions with no
interface record — in their own files and lane-2 those; the
interface-bearing modules stay CI's. That is a design suggestion for
rtl_lead to accept or reject, not a request.

*One caveat that must be carried into any such check.* The unpacked
sources are an artifact of this container's opam overlay pin. They are
not guaranteed elsewhere. Any check built on them must degrade to a
printed `UNVERIFIED` — as lane 2b does — and never silently skip.

#### 5. Scope

Staged paths are `tools/**` and this packet only (PROTOCOL §6).
`libs/**` was not opened at any point, including
`libs/hardcaml_ethernet/src/xgmii_rx_64.ml`, which was sitting
modified in the working tree while I worked and which I did not read —
M03's benches are still unwritten and PROTOCOL §10 is the reason. No
`docs/**`, no `bin/**`, no `.github/**`, no `test/**` (the harness
reads the DV tree; it does not edit it). No `git commit`, no
`git push`. Packet state left for you to flip.

#### 6. What is NOT verified, named so it is not mistaken for verified

- **RFC 1071's actual text.** Ten refusals, four egress paths. The
  extractor is tested against synthetic documents only. If §3's real
  layout defeats the slice, the script reports OBLIGATION OPEN with
  the reason — it will not guess.
- **`Axi64.Source`'s six field names and `Axi64.Dest.tready`** —
  SPEC-M01 §11.4's standing gap, unreachable by any local check.
- **`Base.Array.init`'s exact signature** — quoted, not verified.
- **CI's behaviour.** I am **not** predicting it. What I can say and
  did check: three shells parse (`bash -n`), every exit code was
  observed in both a plain and a simulated-CI environment, and the two
  new checks stand down or fail loudly rather than passing quietly in
  the cases I could reach. The one CI-side outcome I cannot reach is
  whether the runner can fetch RFC 1071, which is the entire point of
  putting the check there.
