# ADR-0015: the differential co-simulation lane — Icarus in CI, a two-file vendored reference, and the determinism REQ-902 does not give it

- **Status**: **PROPOSED.** Three sub-decisions are taken in-role and are in
  force on commit; **two are E3** (PROTOCOL §8, charter §7 — a new toolchain
  dependency, and third-party source entering the repository) and are **drafted
  here for sponsor decision via the orchestrator**, not accepted by me. Each
  section below carries its own authority line; the E3 items are D1 and D2's
  *permission* halves. WO-0044 stays BLOCKED on the two E3 answers; everything
  the in-role rulings settle is unblocked now.
- **Deciders**: architect_docs_lead drafts; **sponsor (Renato) decides the two
  E3 items** on an orchestrator escalation carrying options + recommendation +
  cost. The in-role rulings (D2's placement and pinning mechanism, D2's
  `libs/**` boundary ruling, D3's REQ-902 scoping) are mine under charter §3
  and §7 and are recorded as decided.
- **Work order**: WO-0044 (`agents/handoffs/WO-0044_cosim-lane-opening.md`, §7's
  three questions) · **Journal**: `J-architect_docs_lead-0014`
- **Affects**: **no frozen spec text and no requirement's normative sentence.**
  This ADR cites REQ-901, REQ-902 and REQ-906 and changes none of them. It
  creates one new tree path (`test/third_party/`), states requirements for
  `.github/workflows/build.yml` (implemented by the orchestrator, not here), and
  rules one independence boundary that WO-0044 §6 explicitly declined to settle
  unilaterally. If the sponsor rejects either E3 item, no committed artifact has
  to be unwound — that is why this ADR precedes the vendoring commit rather
  than describing it.

---

## Context

`WO-0044` opens the differential co-simulation lane: our `Xgmii_rx_64` (M03)
against `alexforencich/verilog-ethernet`'s `axis_xgmii_rx_64.v`. The lane is on
the `SO-xgmii_rx_64` critical path because `test/xgmii/injection.ml`'s outcome
model is a golden model with no external anchor, and PROTOCOL §10 forbids a
golden model judging RTL until it has one.

The packet is deliberately narrow: **Phase 1 is one 64-octet good-FCS frame at
a lane-0 start, plus a deliberate mismatch check**, and nothing past that is
authorised. This ADR is scoped to match. It answers the three questions
`WO-0044` §7 asks and does not pre-decide the campaign — a decision made now
about Phase 3's error-path volume would be made without the one datum that
matters, which is what the bridge costs when it exists.

Two constraints shape every answer below and are worth stating before the
decisions rather than inside them:

1. **ADR-0005's pattern.** CI is the authoritative build environment; a local
   result is never gate evidence (REQ-906). A second toolchain needs its own
   availability story or, as `WO-0044` §7.1 puts it, "the failure modes
   multiply".
2. **The `build` workflow's determinism step is a tripwire for anything that
   writes into the working tree.** It runs `git add -A` and then
   `git diff --cached --exit-code`, deliberately, so that an uncommitted
   *untracked* generated file fails the build. A co-simulation that drops a
   compiled simulator binary, a VCD or a log anywhere under the checkout will
   redden the main suite on its first run — precisely the outcome `WO-0044` §3
   says gets the lane reverted rather than fixed.

---

## D1 — The simulator: Icarus Verilog, from the Ubuntu archive, in its own job

**Authority**: the *choice* is my recommendation; **adding a second toolchain
dependency to CI at all is E3** and is the sponsor's.

### Decision

**Icarus Verilog (`iverilog` + `vvp`), installed from the Ubuntu archive with
`apt-get`, running in a separate `cosim` job of `build.yml`.** The harness
invokes it as a **subprocess across files** — a text stimulus file in, a text
transaction file out — and never links against it.

### Why Icarus and not Verilator

Verilator is the faster simulator and is the one this programme's plan already
names for Phase-2 full-day replay (charter §9). It still loses here, on three
grounds that are specific to *this* lane rather than to simulators in general:

- **Verilator is 2-state; this lane's whole job is to be an anchor.** Verilator
  resolves unknowns to a definite value instead of propagating `x`. On our own
  emitted RTL that is a tolerable modelling choice. On a reference
  implementation being used to *corroborate* our design it is the wrong failure
  mode in the wrong direction: it can make the reference appear to agree
  because the simulator supplied a value, not because the design produced one.
  An anchor that can agree for the wrong reason is worse than a missing anchor,
  because the missing one is visible.
- **A C++ harness is a second thing that can be wrong.** Verilator requires
  `--cc --exe --build` and a `sim_main.cpp`; Icarus runs a plain Verilog
  testbench with `$readmemh`/`$fdisplay` and needs `iverilog -o sim … && vvp
  sim`. Phase 1's deliverable is "the lane exists and a difference would be
  visible". Every component between the stimulus and the comparison is a
  component that can produce a green run that compared nothing — the failure
  mode `WO-0044` §4 names explicitly.
- **Verilator lints third-party source hard.** `WIDTH`, `UNOPTFLAT` and
  `CASEINCOMPLETE` findings on someone else's file become either `-Wno-fatal`
  (which discards the lint's value) or a waiver list we maintain against an
  upstream we do not control. Upstream's own benches run under Icarus + cocotb,
  so Icarus is the configuration the file is known to elaborate in.

**This is deliberately a reversible door.** Because the bridge is file-based,
replacing `iverilog`/`vvp` with `verilator` later changes one invocation script
and **no test and no expected value** — the transaction file format is the
interface, not the simulator's API. Two simulators in the programme is a real
cost, and the file-based bridge is what bounds it: the cost is one script, paid
only if Phase 3's volume demands it.

### Rejected alternatives

| Alternative | Why not |
|---|---|
| **Verilator** | Above. Named as the likely Phase-2/3 replay simulator; **this ADR does not decide that**, and choosing Icarus here does not pre-empt it. |
| **cocotb (+ Icarus)** | Adds Python and a package ecosystem — and a second expected-value language — to drive one frame. Upstream uses it because it maintains a whole regression suite; we are proving a lane exists. |
| **Build the simulator from source, or a PPA** | An unpinned network dependency with weaker provenance than the distribution archive, for a tool the archive already ships. |
| **Link the simulator into the OCaml bench (FFI/Verilator C++)** | Turns the simulator choice into a one-way door and puts a foreign build system inside `dune runtest`, where a failure is indistinguishable from a design failure. |

### The availability story, measured rather than assumed

ADR-0005 established its constraints empirically and this one does the same.
Measured in the development container on 2026-08-03 (Ubuntu 24.04 noble):

- `apt-cache policy iverilog` → candidate **`12.0-2build2`**, from
  `http://archive.ubuntu.com/ubuntu noble/universe`, `Installed: (none)`.
- `apt-get download iverilog` → **fetched 2126 kB successfully**. The Ubuntu
  archive is reachable from this container — **unlike** the opam and
  GitHub-`/archive/` endpoints ADR-0005 found blocked.
- `apt-get install -s -y iverilog` → `0 upgraded, 1 newly installed, 0 to
  remove`. **Zero additional packages**; `gtkwave` is a suggestion, not a
  dependency.

What that does and does not license:

- **It does not weaken ADR-0005 rule 1 or REQ-906.** A gate signature, an `SO-`
  packet and a work order's Evidence still cite a **CI run id and conclusion**.
  A locally-run co-simulation is convenience for iteration and is not evidence,
  for the same reason a local `dune build` is not: nobody else can reproduce
  the environment it ran in.
- **It does mean the local lane is genuinely usable**, which the OCaml lane is
  not. That asymmetry is worth recording, because a future agent reading
  ADR-0005 would otherwise reasonably assume the container blocks this too and
  not try.
- **The claim's limits**: I simulated the install; I did not install. A
  successful `apt-get download` plus a clean `-s` resolution is evidence the
  package is fetchable and dependency-clean, not that `vvp` runs here.

### Unavailability, and the rule that matters most

If the install fails — archive outage, package rename, a runner image change —
the `cosim` job **fails with a distinguishable message and does not
silently pass**. The standing rule, which outlives the non-blocking window:

> **A skipped, absent or failed-to-install simulator is never a PASS.** No
> `SO-` packet may cite a run in which the co-simulation lane did not execute,
> and a run summary must distinguish *ran and agreed* from *did not run*.

That is the same shape as `WO-0044` §4's deliberate-mismatch requirement, one
level up: a comparator that never ran is worth exactly as much as one that has
only ever agreed.

### What `build.yml` needs — REQUIREMENTS (the orchestrator implements)

| # | Requirement | Why it is here and not left to implementation taste |
|---|---|---|
| **R-CI-1** | The lane is a **separate job**, not a step in `build`. | `build`'s determinism step runs `git add -A`; a simulator artifact in that job's tree fails it. A separate job also means a red lane cannot red the main suite. |
| **R-CI-2** | `sudo apt-get update && sudo apt-get install -y iverilog`. No PPA, no source build. | Distribution provenance; the version is then a fact about the runner image, not about us. |
| **R-CI-3** | The job **records the simulator version into the run's artifact**, not only into the log: `iverilog -V \| head -1` and `dpkg-query -W -f='${Version}' iverilog`. | D3's reproducibility guarantee is *conditional on the version*. A guarantee whose condition is not in the record is not checkable. |
| **R-CI-4** | The job is **`continue-on-error: true` on its first landing**, and the gate comes off in **its own later commit** once Phase 1's deliberate-mismatch check has demonstrated the comparator fires. | `WO-0044` §3 requires non-blocking on landing. A *permanently* non-blocking lane is decoration, so the removal condition is written down here, now, rather than left to whoever remembers. |
| **R-CI-5** | Every simulator artifact is written **outside the checkout** (e.g. `$RUNNER_TEMP`) **or** to a path added to `.gitignore` in the same change. | R-CI-1 protects `build`; this protects the co-sim job from failing its own future determinism checks and keeps `git status` clean for any agent working in the tree. |
| **R-CI-6** | On failure, upload as a workflow artifact: the stimulus file, **both** transaction files, and the diff. | `WO-0044` §3 — a finding that cannot be adjudicated from the artifact is not a finding. Note these artifacts are **ephemeral**; a journal citing them must say so (ADR-0003/F5). |
| **R-CI-7** | Trigger on the same `push` as `build`. Not a schedule. | A lane that runs on a schedule produces failures attributable to no commit. |
| **R-CI-8** | No fetch step. The reference is in the checkout (D2). | Stated so its absence is a decision rather than an omission. |

---

## D2 — The reference: two files, vendored verbatim under `test/third_party/`

**Authority**: **whether third-party source may enter the repository at all is
E3** (charter §7 — the verilog-ethernet licensing boundary) and is the
sponsor's. **Where it goes, how it is pinned, and the `libs/**` boundary
question are mine** and are decided below.

### Decision

Vendor a **verbatim copy of exactly the module under comparison and its
instance closure** at a pinned upstream commit, at:

```
test/third_party/verilog-ethernet/
├── COPYING              # upstream's licence file, verbatim, under its own name
├── PROVENANCE.md        # the pin: repo URL, commit SHA, per-file upstream path + sha256
├── axis_xgmii_rx_64.v   # upstream rtl/axis_xgmii_rx_64.v, byte-verbatim
└── lfsr.v               # upstream rtl/lfsr.v, byte-verbatim
```

### The closure is two files, measured

Fetched from `raw.githubusercontent.com` on 2026-08-03 and inspected:

- `rtl/axis_xgmii_rx_64.v` — 449 lines, **13,496 bytes**. Instantiates exactly
  one module: `lfsr` at line 177, instance name `eth_crc` (the CRC-32). No
  `` `include `` directives.
- `rtl/lfsr.v` — 447 lines, **16,327 bytes**. Instantiates nothing; it is a
  leaf.

So the Phase-1 closure is **two files**. A whole-repository vendor is rejected:
it would copy hundreds of files this programme never simulates, and each is a
licensing surface and an audit surface bought for nothing. The manifest's
completeness is **checkable rather than asserted** — the simulator resolving
every instance with no missing-module diagnostic is the check, and it runs on
every co-sim run.

`scripts/agent_commit.sh`'s blob gate refuses any staged file over 1,000,000
bytes. Both files are two orders of magnitude under it. Recorded because the
gate is a second, independent reason the vendoring must be file-scoped.

### Licensing — three notices, not one

Upstream's licence facts, verified rather than assumed:

- The licence file at the repository root is named **`COPYING`**, not
  `LICENSE`. `LICENSE`, `LICENSE.md`, `LICENSE.txt` and `license` all return
  404; `COPYING` returns 200 (1,062 bytes, MIT, `Copyright (c) 2014-2018 Alex
  Forencich`).
- **Each source file carries its own MIT notice in its header, with its own
  copyright years**: `axis_xgmii_rx_64.v` says *2015-2017*;
  `lfsr.v` says *2016-2023*. Neither matches `COPYING`'s *2014-2018*.

Therefore:

1. `COPYING` is copied **verbatim and under its upstream name**, so a reader
   can match it to upstream without guessing which file we renamed.
2. The two `.v` files are copied **byte-verbatim, headers included**. The
   per-file notices are not redundant with `COPYING` — they carry different
   copyright lines, and stripping or "tidying" a header would produce an
   attribution that is *narrower than the one the author wrote*. This is the
   concrete reason the no-edit rule below is a licensing rule and not just a
   provenance preference.
3. `PROVENANCE.md` records: upstream repository URL, the **40-hex commit SHA**
   the copy was taken at, each file's upstream path, and each file's `sha256`
   as vendored. The sha256 makes "verbatim" verifiable by anyone at any later
   SHA without network access.

### No edits, ever — configuration is a parameter, not a patch

The vendored files are **never modified in place**. REQ-901 pins the
reference's configuration (deficit idle count disabled, padding enabled,
minimum frame length 64, PTP disabled, transmit checksum generation disabled)
and every one of those is a **module parameter**, set at instantiation in *our*
testbench wrapper, which is our file. Confirmed against the source: the module
is `axis_xgmii_rx_64 #(DATA_WIDTH, KEEP_WIDTH, CTRL_WIDTH, PTP_TS_ENABLE,
PTP_TS_FMT_TOD, PTP_TS_WIDTH, USER_WIDTH)`, and `PTP_TS_ENABLE = 0` yields
`USER_WIDTH = 1` — which is exactly REQ-901's "`tuser`[0] on each `tlast`".

If a change to the reference ever became genuinely necessary it lands as a
**separate patch file applied at build time**, never as an in-place edit: a
modified file bearing an upstream SHA in its manifest is a **false provenance
record**, and that is the single worst outcome available in this area.

### Pin bumps are their own commit

Changing the pinned SHA changes *what the anchor is*. A bump therefore lands as
its own commit, with the `PROVENANCE.md` diff showing old SHA → new SHA and the
re-run comparison result, and is **never folded into a harness change** — the
one arrangement in which a divergence introduced by the bump is
indistinguishable from one introduced by the harness.

### Why `test/third_party/` and not the alternatives

| Alternative | Why not |
|---|---|
| **A new top-level `third_party/`** | **Mechanically blocked.** `scripts/policy.sh`'s `agent_may_write` has no case arm matching `third_party/*` for any agent except the orchestrator. Vendoring there either forces the sole committer to do work `WO-0044` §6 assigns to `data_wrangler`/`tb_writer`, or requires a PROTOCOL §6 amendment plus a `policy.sh` change plus a `scripts/test_protocol.sh` case (PROTOCOL §11) — a constitutional amendment to house two files. |
| **A git submodule** | Two defects. `.gitmodules` is a repo-root file (orchestrator scope again); and a submodule bump shows in `git diff A..B` as a **SHA change, not as content**, which defeats PROTOCOL §1's first non-negotiable property — the diff *is* the record here, and the whole enforcement apparatus is built on that. It also adds a network dependency to every checkout. |
| **Fetch at build time** | Collides with the determinism step (an untracked fetch into the tree fails `git add -A`); makes the lane fail when GitHub is unreachable; and leaves the auditor unable to establish, at a SHA, what was actually simulated. ADR-0005's own table shows `/archive/` and `codeload` are 403 from the container, so a tarball fetch is *known* to fail locally. |
| **`libs/third_party/`** | `libs/**` is our design and rtl_lead's scope. Putting a reference implementation there puts third-party RTL inside the read bar and inside the design line's write scope — wrong on both axes at once. |
| **`tools/third_party/`** | `tools/` holds things that *run*; the reference is a **test fixture**. Co-locating fixture and harness under `test/**` also means one write scope, one worker, one review loop. |

There is direct precedent for non-design Verilog under `test/`:
`tools/check_emitted_verilog.sh`'s REQ-018 check already records that "the
XGMII link partner lives under `test/`". That check reads `rtl_snapshots/*.v`
and `docs/specs/architecture.md` only, so vendored `.v` files under `test/`
cannot perturb it.

### Ruling: vendored third-party source is **OUTSIDE** the `libs/**` read bar

`WO-0044` §6 states dv_lead's reading — outside — and correctly declines to
settle it unilaterally. **I rule the same way, and the grounds matter more than
the answer:**

1. **The bar's purpose is preserved, not stretched.** PROTOCOL §10 bars DV from
   the design under test so tests cannot be back-fitted to the implementation
   they are meant to judge. A third-party implementation is *not* the design
   under test; reading it cannot leak our implementation's choices into our
   tests, because our implementation's choices are not in it.
2. **The path bar stays an honest proxy.** `libs/**` is a *path* bar because
   path is the mechanical stand-in for "our RTL". Vendoring under
   `test/third_party/` keeps the proxy and the semantics naming the same set.
   Vendoring under `libs/` would have broken that alignment, and the bar's
   enforceability rests on the alignment — this is a second, independent reason
   the placement decision above is not merely tidiness.
3. **The converse obligation, which is the load-bearing half.** Because the
   reference is readable by DV, it must never become a source of **expected
   values**:

   > **No attack-plan row's expected value, and no golden-model outcome, may be
   > changed to match the reference.** A co-simulation divergence resolves in
   > exactly one of three ways: a defect against our RTL; an entry in the
   > comparison domain's documented-divergence list, citing the SPEC-M03 clause
   > or reference behaviour that explains it; or a spec diff with its own ADR.
   > **Never by amending an expectation to agree.** `WO-0044` §5 states the
   > principle — "our rows govern" — and this is its operational form.

   Without this clause, "dv may read the reference" degrades into "the
   reference is the spec" one convenient row at a time, and it degrades
   silently, which is the worst property a rule can have.
4. **Nothing else moves.** `libs/**` and `rtl_snapshots/**` remain barred to
   dv_lead exactly as before. This ADR does not widen either bar by a byte and
   does not re-open the existing narrow scripted exception by which
   `tools/dv_checks.sh` parses emitted Verilog (settled at WO-0003/WO-0007;
   untouched here).

---

## D3 — REQ-902 and an external simulator: what the determinism step does not cover

**Authority**: mine, in-role. This is a reading of an existing requirement's
scope, not a change to it. **REQ-902's normative sentence is not amended.**

### Ruling

**REQ-902 does not extend to the co-simulation lane, and no co-simulation result
may be cited under it.** REQ-902 says: *"Regenerating the RTL snapshots from
unchanged sources SHALL produce byte-identical files,"* verified by *"the
existing `build` workflow determinism step."* Its subject is `rtl_snapshots/**`
as regenerated by `bin/generate.exe` from our Hardcaml sources. The external
simulator is not in that path — it *consumes* emitted Verilog and produces
nothing REQ-902 quantifies over. Adding a simulator to the repository does not
enlarge what a requirement about our emitter's output means, and anyone citing
REQ-902 for a co-sim result is citing the wrong requirement.

### What the determinism step *does* cover, and the hazard it creates

The step is `git add -A` then `git diff --cached --exit-code`. It stages
untracked files deliberately, so that a generated-but-uncommitted file fails
the build. Two consequences for this lane:

- **Covered**: the vendored `.v` files, once committed, are ordinary tracked
  files. They cannot drift silently — an edit to one shows up in a diff like
  any other, which is the mechanism that enforces D2's no-edit rule at no extra
  cost.
- **Not covered, and actively hazardous**: every artifact the simulator
  produces. A compiled `sim`, a `.vcd`, a log or a transaction file left in the
  checkout is an untracked file, and the step will fail on it. This is the
  single most likely way the lane reddens the main suite on day one. R-CI-1 and
  R-CI-5 exist for exactly this and are not optional.

### The weaker guarantee this lane gets instead — *pinned-input reproducibility*

Named, so it cannot be confused with REQ-902 in a later citation:

> **Pinned-input reproducibility.** Given (i) the vendored reference at its
> pinned SHA, (ii) the recorded simulator package version, (iii) the recorded
> stimulus file, and (iv) the same runner image, two executions of the lane
> SHALL produce **byte-identical canonical transaction files**.

Three things this is careful about:

1. **The compared object is a canonical transaction file, not the raw log.**
   REQ-901 already makes the comparison **transactional, not cycle-by-cycle**:
   the ordered sequence of output frames, each word's `tkeep` extent, `tuser`[0]
   on `tlast`, and the accept-or-discard decision per input frame. So the
   harness writes precisely that, and **timestamps, simulator banners, VCD
   headers and wall-clock durations are excluded from the file by construction**
   — the version goes in a **sidecar** (R-CI-3), never inside the file whose
   bytes the guarantee is about. A "determinism" check that a simulator banner
   can break teaches everyone to ignore it.
2. **It is conditional, and says so.** It is *not* a claim of reproducibility
   across simulator versions or across runner images. Icarus 12.0 and a future
   Icarus 13 may legitimately differ, as may two implementations of an
   `always` block's scheduling. Stating the condition is what makes the
   guarantee usable: when it breaks, the first question is which of the four
   inputs moved, and all four are recorded.
3. **It is exercised, not asserted.** **Phase 1 runs the simulation twice in the
   same job and diffs the two transaction files.** This is the determinism
   analogue of `WO-0044` §4's deliberate-mismatch check, and it exists for the
   same reason: an unexercised determinism claim is worth what an unexercised
   comparator is worth. It costs one extra invocation on a one-frame stimulus.

### What is emphatically *not* claimed

- Not that the reference's internal behaviour is reproducible under a different
  simulator. It is not tested and not needed.
- Not that co-sim outputs may be committed as snapshots. **They may not.**
  `rtl_snapshots/**` is our emitter's output and stays that; a committed co-sim
  transaction file would put a third-party simulator's output inside the
  artifact set REQ-902 governs, which is exactly the conflation this section
  exists to prevent.
- Not that a green co-sim run says anything about whether *our bench would
  notice if our design changed*. `WO-0044` §5 says it and it bears repeating in
  the record: this lane does not substitute for the mutation campaigns.

---

## Consequences

- The programme acquires its **first system-package CI dependency** and, if
  Phase 2/3 later takes Verilator for replay, its **second simulator**. The
  file-based bridge is the mechanism that bounds the cost of that to one script.
- `test/third_party/` becomes a path with a rule attached: **verbatim, pinned,
  manifest-backed, never edited**. It is inside `dv_lead`/`tb_writer`/`formal_dv`
  write scope, so the packet's own assignees can land and review it with no
  protocol amendment.
- The **auditor gains a checkable licensing surface**: `PROVENANCE.md`'s
  sha256 values against the vendored bytes, `COPYING` against upstream, and the
  per-file headers intact. All three checks run offline at any SHA.
- The **expected-value clause in D2's ruling 3** is a new standing rule for
  every future co-sim finding, and the comparison-domain document (dv_lead's
  Phase 0) is where it is operationalised. It is stated here because a rule
  that only exists in a verification-scope document is a rule the design line
  never reads.
- WO-0044 remains BLOCKED **only** on the two E3 answers. D2's placement,
  pinning and boundary rulings and D3's REQ-902 scoping are in force on commit,
  so the comparison domain, the bridge design and the harness's file format can
  all proceed in parallel.

## What this ADR does not decide

Stated explicitly, because `WO-0044` §4 warns against scoping the full campaign
from here:

- **The comparison domain** — which observables must agree under which stimulus
  classes, and the enumerated documented divergences. That is dv_lead's Phase 0
  deliverable; I countersign the SPEC-M03 clauses it cites.
- **The bridge's format details** — the stimulus file's encoding and the
  transaction file's exact syntax. Constrained here only by D3's canonicality
  requirement.
- **Anything past Phase 1** — Phase 2's stimulus spine and Phase 3's error
  paths are scoped after Phase 1 reports what the bridge cost.
- **Phase 2's replay simulator.** Verilator remains the plan of record for
  full-day replay of our own design; D1 is scoped to the differential lane.
- **Whether the lane ever becomes blocking beyond R-CI-4's stated condition.**
