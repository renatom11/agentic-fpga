# WO-0046: Co-simulation Phase 1 — the smallest end-to-end differential run

- **State**: DRAFT (id is a placeholder — orchestrator allocates)
- **From** / **To**: dv_lead → **tb_writer** (`test/cosim/**`) and
  **data_wrangler** (`tools/cosim/**`) — §5 splits them by artifact
- **Governing**: **REQ-901** (differential co-simulation — read it first and in
  full; it settles more of this packet than any other source), REQ-902,
  REQ-906; ADR-0015; `test/attack_plans/CD-xgmii_rx_64_cosim.md` **as corrected
  at §0-bis**.
- **Base**: current HEAD, with the reference vendored at `f4f074b`.
- **Scope**: **Phase 1 only.** Nothing in Phases 2–4 is authorised.

## 0. The vendoring is ACCEPTED — verified, not taken

Checked myself rather than from the return: `test/third_party/verilog-ethernet/`
holds `axis_xgmii_rx_64.v`, `lfsr.v`, `COPYING` and `PROVENANCE.md`; the pin
`77320a9471d19c7dd383914bc049e02d9f4f1ffb` matches; and both recorded sha256s
match the files on disk —

```
99d2b9578a440f03…  axis_xgmii_rx_64.v
5502c8203b0dfc72…  lfsr.v
```

The closure re-derivation at the pin (one instantiation, `lfsr`, no includes,
`lfsr` a leaf) and the three-notice licensing per ADR-0015 D2 are accepted.
**No Return log entry is owed** — the worker read its scope as narrowed and was
right to; this section is that acceptance, per WO-0044's own structure.

## 1. REQ-901 governs, and it settles most of what I would otherwise have asked

**Read REQ-901 before anything else in this packet.** It is a requirement, not
guidance, and it already fixes:

- **The reference's configuration** — "deficit idle count disabled, padding
  enabled, minimum frame length 64, PTP disabled and transmit checksum
  generation disabled". **These are the wrapper testbench's parameter settings**
  and you do not derive them; you map them onto `axis_xgmii_rx_64`'s actual
  parameter names and **report the mapping** (§6 question 1).
- **The comparison is transactional, not cycle-by-cycle** — "cycle alignment,
  internal pipelining and latency constants are deliberately not compared: ours
  are pinned by REQ-005 and REQ-111, the reference's are its own."
- **Exactly what is compared** — "the same ordered sequence of output frames —
  payload octets, the `tkeep` extent of **each** word, and `tuser`[0] on each
  `tlast` — and **the same accept-or-discard decision per input frame**."
- **The report format**, from its Verification column — "**frames compared,
  frames matching, and every divergence with the class it falls in or the defect
  it is**". Your comparator emits exactly that.
- **The divergence rule** — four classes are declared, **none of them applies to
  the M03 pairing**, and "any divergence outside these four classes is a defect.
  A divergence class discovered later SHALL be added here by spec diff before
  any sign-off packet may cite it."

> **So for M03 the permitted-divergence set is EMPTY.** Any difference is a
> **defect** until a spec diff says otherwise. My own Phase 0 document said
> otherwise and is corrected at its §0-bis; **build against REQ-901 and that
> correction, not against CD §6 as originally written.** If you find CD and
> REQ-901 disagreeing anywhere else, **stop and tell me** — that is a finding
> against my document, and it will be the second.

## 2. The architecture — three artifacts, one stimulus, two canonical files

Our side is OCaml/Cyclesim; the reference is Verilog under `iverilog`/`vvp`.
They cannot share a process, so the stimulus becomes a **file** both sides
consume:

```
stimulus.txt ──> ours_run    ──> ours.canon      ─┐
             └─> vvp (tb)    ──> theirs.canon    ─┴─> compare ──> exit 0/1
```

Making the stimulus an artifact is deliberate: it is what the reproducibility
guarantee's antecedent names ("the recorded stimulus"), and it lets a divergence
be re-driven later without regenerating anything.

### 2.1 File layout — this is what fixes `build.yml`'s entry point

```
test/cosim/
  dune                  (executables) — NOT (inline_tests). See §2.2.
  canonical.ml/.mli     the canonical form: writer, parser, and the domain comparison
  stimulus_gen.ml       writes stimulus.txt
  ours_run.ml           reads stimulus.txt, drives Hardcaml M03, writes ours.canon
  compare.ml            reads two .canon files, applies REQ-901's comparison, emits the report
  tb_xgmii_rx_64.v      the wrapper testbench (REQ-901's parameters at instantiation)
tools/cosim/
  run_cosim.sh          THE ENTRY POINT — the only thing CI invokes
```

**The CI job invokes exactly one command:**

```
tools/cosim/run_cosim.sh
```

**exit 0** = all three checks passed; **nonzero** = failure, with the failing
check named on stdout. No arguments, no environment beyond `PATH` reaching
`iverilog`/`vvp` and a built dune tree. If the script needs configuration, it
takes it from files in the repository, not from the job — a job that must pass
parameters is a job that must change every time the lane does.

### 2.2 Why `(executables)` and not `(inline_tests)` — a hard constraint

**The comparison must never run under `dune runtest`.** `compare` depends on a
file produced by `vvp`, which runs outside dune and does not exist in any
environment where the lane has not run. An inline test would therefore **fail
the main suite everywhere iverilog is absent** — including the dev container,
including every existing CI job.

`test/cosim/`'s stanza is `(executables)`. The main suite's fifteen
`%expect_test` units are untouched, and `dune runtest` must be **byte-identically
green before and after this packet**. That is a review check, not an aspiration.

### 2.3 The canonical form — pinned here, because it is the interface between two workers

Text, one record per line, ASCII, LF endings, no trailing whitespace:

```
F <frame-index>
W <tkeep-hex-2> <tlast 0|1> <tuser0 0|1> <octet-hex-2>*
D <frame-index> <accept|discard>
```

- `F` opens a frame; `W` lines follow in emission order; `octet-hex-2` are the
  octets that word actually delivers, in ascending `tdata` position order, and
  there are exactly as many as `tkeep` has bits set.
- `D` records **REQ-901's accept-or-discard decision** for the corresponding
  **input** frame — the field my Phase 0 document omitted.
- **Nothing else may appear in the file.** No version string, no tool name, no
  path, no timestamp, no host, no comment. CD §3, and it is what makes the §4.3
  determinism check meaningful rather than noise.

**Provenance goes in a sidecar** `<name>.canon.meta`: the reference pin, the
simulator name and version, the runner image identifier, and the stimulus
identifier. The sidecar is **never** compared.

## 3. What Phase 1 drives

**One 64-octet good-FCS frame at a lane-0 start.** Not eight lengths, not both
lanes, not an error path. Phase 1 proves the **lane exists**: the reference
builds, the stimulus reaches both sides, canonical files come back, and a
difference would be visible.

Expected inside REQ-901's comparison: 60 delivered octets, final-word `tkeep`
extent 0x0F, `tuser`[0] = 0 on the `tlast` word, accept.

## 4. The three checks — all three, or Phase 1 is not done

### 4.1 The differential comparison

`compare` applies REQ-901's comparison and emits its Verification-column report:
**frames compared, frames matching, and every divergence with the class it falls
in or the defect it is.** For M03 there are no applicable classes, so any
divergence prints as a **defect** and exits nonzero.

### 4.2 The deliberate mismatch check — and it must use the real path

Perturb one octet and confirm a difference is reported. **It must exercise the
same code path as the real comparison** — a separate "test the comparator"
harness that does not call the production comparison proves nothing about the
production comparison.

Implement it as `compare --self-test`, in the same binary, the way
`tools/precompile_check.sh` and `tools/check_rfc1071_anchor.sh` already do:
construct a known-good pair, assert agreement; perturb exactly one octet, assert
the **same** comparison reports a difference and exits nonzero.

**A comparator that has only ever agreed is worth nothing.** This programme has
now spent two mutation campaigns establishing that; the same applies here and it
costs one perturbation.

### 4.3 The two-run determinism check

Run **the whole pipeline twice within the same CI job** and diff both canonical
files byte-for-byte. This exercises the architect's guarantee, which is **not**
REQ-902 and must never be summarised as it:

> Given the pinned reference SHA, the recorded simulator version, the recorded
> stimulus, and the same runner image, two runs produce byte-identical canonical
> transaction files.

Every clause of that antecedent is load-bearing. The sidecar records what it
names; the compared file contains none of it.

## 5. Who executes what

| artifact | worker | review |
|---|---|---|
| `test/cosim/**` — canonical form, comparator, our-side driver, **and the Verilog testbench** | **tb_writer** | dv_lead, the `RV-` loop |
| `tools/cosim/run_cosim.sh` — sequencing, working directory, cleanup | **data_wrangler** | dv_lead |
| `build.yml` | **orchestrator** — §2.1 fixes the entry point | — |

**The testbench goes with the verification content, not the plumbing**: it
encodes REQ-901's parameter settings and decides what is captured, which are
verification judgements and belong under the review loop.

**data_wrangler is not blocked by tb_writer.** `run_cosim.sh` sequences named
entry points; it can be written against §2.1's layout before those binaries
exist.

## 6. Questions to answer with evidence, as deliverables

1. **The parameter mapping.** REQ-901 names five settings; give
   `axis_xgmii_rx_64`'s actual parameter names for each, with the line you read
   them from. If any has no counterpart, say so — do not infer one.
2. **The `tuser` mapping.** Which bit of the reference's `m_axis_tuser` is the
   bad-frame indication, and does its polarity match `tuser`[0] as REQ-013
   defines ours? Establish it; do not assume.
3. **The pairing.** REQ-901 takes comparison boundaries from
   `architecture.md` §4's counterpart column. **Confirm M03's counterpart is
   `axis_xgmii_rx_64` from that column** rather than from this packet's
   assumption, and quote the row.
4. **The accept-or-discard decision.** How does each side express it? Ours is
   implicit in whether a frame is emitted at all; the reference's may differ.
   State how you derive `D` for each side.

## 7. Artifact hygiene — hard constraints, from ADR-0015 R-CI-1/R-CI-5

The determinism step **stages untracked files deliberately**, so **any artifact
left in the checkout fails the main suite.** This is a mechanism that reddens a
green tree, not a tidiness preference.

1. **Nothing is written inside the repository checkout at any point** —
   `iverilog` output, `vvp` output, VCDs, logs, the stimulus, the canonical
   files and their sidecars all live in a `mktemp -d` working directory.
2. **Cleanup runs on the failure path as well as the happy path** — `trap … EXIT`,
   not a tidy-up at the end of a successful run. A harness that cleans only on
   success strands artifacts on exactly the runs that matter.
3. **On failure, the evidence reaches the log**: emit both canonical files and
   both sidecars to stdout, because a divergence that cannot be adjudicated from
   the run log is a divergence that cannot be adjudicated.

## 8. What I expect back

A Return log on this packet from each worker plus journal entries. §6's four
answers are **deliverables, not background**. State explicitly that `dune
runtest`'s fifteen units are unchanged and still green — that claim is a review
check.

**Do not write an `SO-`.** Phase 1 proves a lane; it anchors nothing yet. The
anchoring obligation is Phase 3's, and CD §2's finding stands: **this lane can
anchor the data-path half of X-1's outcome model and not the strobe half**,
because the reference has no counterpart to §9's strobe taxonomy.

## 9. What Phase 1 does not authorise

Phase 2 is scoped after Phase 1's result, because Phase 1 will teach us what the
bridge actually costs. No additional lengths, no second start lane, no error
paths, no additional module pairs.

## Return log

### data_wrangler — `tools/cosim/run_cosim.sh` (RETURNED)

**Journal**: `J-data_wrangler-0001`. **Write scope used**: `tools/cosim/run_cosim.sh`
only (new file); nothing under `test/**` read or written.

**What was built**: the single CI entry point §2.1 names. It checks
prerequisites (`iverilog`, `vvp`, `dune` all on `PATH` — absence is
`EXIT_PREREQ=2`, never a PASS, per ADR-0015 D1's standing rule), builds the
three pinned OCaml executables plus the `iverilog`/`vvp` reference sim, then
sequences §4's three checks in order: 4.1 the differential comparison, 4.2
`compare --self-test` through the production path, 4.3 the two-run
byte-for-byte determinism diff of `ours.canon` and `theirs.canon`. Every
simulator/harness artifact — the compiled sim binary, the stimulus, both
canonical files, both sidecars — lives under one `mktemp -d`; `trap … EXIT`
removes it on every exit path, including every failure branch. On a
differential or determinism failure, both canonical files and both sidecars
are `cat` to stdout before cleanup runs (§7.3). The vendored reference's pin
is read from `test/third_party/verilog-ethernet/PROVENANCE.md` at run time
and recorded in the sidecar — never inside a compared file — alongside the
simulator's version (`iverilog -V`'s banner and the `dpkg-query` package
version) and a best-effort runner-image identifier.

**Exit-code map** (also documented in the script's own header comment): `0`
PASS · `2` PREREQ (iverilog/vvp/dune absent — did not run) · `3` BUILD (`dune
build`, the `iverilog` compile, or a pinned executable failed to run or
produce its file) · `4` DIFFERENTIAL (check 4.1) · `5` SELFTEST (check 4.2) ·
`6` DETERMINISM (check 4.3) · `9` INTERNAL (bad invocation, unparseable
`PROVENANCE.md`, `mktemp` failure).

**Interface decision flagged for tb_writer/dv_lead review** — §2.1 pins file
names but not an argv/CLI or filename contract for the four pinned entry
points, and I was told to build against the pinned interface rather than
guess, so the guess that had to be made is written down rather than made
silently. Absent a pin, `run_cosim.sh` commits to the smallest contract
matching this repository's existing zero-argument idiom (`bin/generate.exe`):
each of `stimulus_gen.exe`, `ours_run.exe`, `compare.exe` and
`tb_xgmii_rx_64.v` takes **no CLI arguments** and reads/writes **fixed,
cwd-relative** filenames (`./stimulus.txt`, `./ours.canon`, `./theirs.canon`);
the harness places every path by controlling **cwd alone**, never a flag.
This is spelled out at length in the script's own header (the section headed
"WHAT THIS SCRIPT ASSUMES…") so it is easy to find and easy to overrule — if
a different contract is wanted, only the four call sites marked `# INTERFACE`
in `run_cosim.sh` need to change; the sequencing, hygiene and exit-code logic
around them do not. Similarly, the `iverilog` invocation adds no flags beyond
`-o <bin> <sources>` — ADR-0015 D1's own literally quoted shape — so if
`tb_xgmii_rx_64.v` turns out to need `-g2012` or another generation flag,
that is a one-line change here, not an assumption made now.

**§6's four questions are tb_writer's to answer, not mine** — per §5's table
they govern `test/cosim/canonical.ml` and `tb_xgmii_rx_64.v`'s content
(parameter mapping, `tuser` polarity, the M03/`axis_xgmii_rx_64` pairing,
per-side accept/discard derivation), none of which is `tools/cosim/`, and
`test/**` is outside my write scope and outside what my charter reads. Not
answered here for that reason, not by oversight.

**Local testing performed** (this container has no simulator at all —
confirmed empirically, see below and my journal's Evidence):
- `bash -n tools/cosim/run_cosim.sh` — clean syntax.
- `shellcheck tools/cosim/run_cosim.sh` — **zero findings, exit 0**
  (shellcheck 0.9.0; not present in the base container, installed via
  `apt-get install -y shellcheck` for this one check, per the standing
  "try; report" instruction — this is a local dev-container action, not a
  claim about CI).
- **The degraded path, run for real**: `iverilog`, `vvp` and `dune` are all
  absent from `PATH` here (`command -v` on each returns nothing). Running
  `tools/cosim/run_cosim.sh` with no arguments fails at the PREREQUISITES
  check, names all three missing tools on stdout, and exits `2`
  (`EXIT_PREREQ`) — never `0`. Verbatim output is in `J-data_wrangler-0001`'s
  Evidence.
- The "everything present" path (build, `iverilog` compile, stimulus
  generation, both runs, both checks, the determinism diff) could not be
  executed in this container and is traceable by review only, as the task
  anticipated; `test/cosim/`'s executables and `tb_xgmii_rx_64.v` do not yet
  exist in this checkout either.
- Confirmed the degraded-path run left nothing behind: `git status` shows
  nothing new under `tools/cosim/` beyond the script itself, and the
  `mktemp -d` directory the script created before dying at the prerequisite
  check does not exist afterward — the `trap` fired.

**Open questions**:
1. Confirm or correct the zero-argument, fixed-relative-filename interface
   assumption above before `test/cosim/`'s `dune` executables and
   `tb_xgmii_rx_64.v` are written to a different contract.
2. Confirm the bare `iverilog -o <bin> <tb> <ref1> <ref2>` invocation (no
   `-g2012` or other generation flag) is sufficient for `tb_xgmii_rx_64.v`,
   once it exists.
3. `run_cosim.sh` lets `dune build` write to the checkout's own `_build/`
   (dune's ordinary, `.gitignore`d cache) rather than relocating the OCaml
   build tree into the `mktemp -d` too — reasoned through in the script's
   header (§7.1 names *simulator* artifacts — iverilog/vvp output, VCDs,
   logs, the stimulus, the canonical files, the sidecars — not the OCaml
   toolchain's own cache, and `_build/` is already `.gitignore`d repo-wide).
   Flagging in case dv_lead reads §7.1 more strictly than I have.
