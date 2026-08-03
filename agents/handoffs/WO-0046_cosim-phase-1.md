# WO-0046: Co-simulation Phase 1 — the smallest end-to-end differential run

- **State**: **bench half ACCEPTED** (`RV-0046-VERDICT`, `J-dv_lead-0056`) —
  canonical grammar exact to the §2.3 pin and stricter than specified, `dune`
  verified free of `runtest` wiring, **the comparator's mismatch check already
  run and passed in-container on the production path**, and all four questions
  answered (Q3 closes my own inferred pairing). **Sidecar ruled: one writer,
  `run_cosim.sh`, no placeholders, fail the run if a field is unknown.** The
  worker's no-length-check finding is **verified and forces a CD revision plus
  a REQ-901 spec diff** — **the co-sim cannot anchor families F or G until it
  lands.** `run_cosim.sh` still owed; the cosim job has not run.
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

### RETURNED (tb_writer, spawn WO-0046/2026-08-03T14:00Z — reconstructed: no
explicit spawn short-id token was included verbatim in my launch prompt, so
this is derived from the current UTC context at first tool call, the same
convention `J-tb_writer-0007`/`0008`/`0009` used when a token was likewise
absent)

State left as **ISSUED** — dv_lead's `RV-` flips it, per PROTOCOL §3. This is
the `test/cosim/**` half only (§5); `tools/cosim/run_cosim.sh` is
data_wrangler's and is not touched here.

#### 1. What I built

| File | Role |
|---|---|
| `test/cosim/dune` | `(executables)` — not `(inline_tests)`, per §2.2 |
| `test/cosim/canonical.mli` / `.ml` | §2.3's pinned grammar: writer, parser, REQ-901's domain comparison |
| `test/cosim/stimulus_gen.ml` | Phase 1's one-frame stimulus (§3) |
| `test/cosim/ours_run.ml` | our-side driver: elaborates M03, writes `ours.canon` |
| `test/cosim/compare.ml` | the comparator, with `--self-test` (§4.2) |
| `test/cosim/tb_xgmii_rx_64.v` | the wrapper testbench around the vendored reference (§2.1) |

No file outside `test/cosim/` was touched. `git status --porcelain` shows three
other modified/untracked paths (`agents/handoffs/WO-0045_family-e-mutation-campaign.md`,
`agents/journals/claude_dv_lead_agent.md`, `test/attack_plans/AP-xgmii_rx_64.md`)
— **not mine**: no `Write`/`Edit`/mutating `Bash` call touched any of them this
spawn, and I read none of them. They predate this spawn in the shared working
tree.

#### 2. The four question-deliverables (§6), with evidence

**Question 1 — the parameter mapping.** `axis_xgmii_rx_64`'s actual parameters
(its own header, `axis_xgmii_rx_64.v:34-42`): `DATA_WIDTH`, `KEEP_WIDTH`,
`CTRL_WIDTH`, `PTP_TS_ENABLE`, `PTP_TS_FMT_TOD`, `PTP_TS_WIDTH`, `USER_WIDTH`.
Of REQ-901's five settings, **only one has a counterpart**:

- **"PTP disabled" → `PTP_TS_ENABLE(0)`** (`axis_xgmii_rx_64.v:39`, already its
  own default). Set explicitly at instantiation in `tb_xgmii_rx_64.v` anyway,
  for self-documentation.
- **"deficit idle count disabled" → no counterpart.** DIC is transmit-side
  gap-shortening (REQ-204); nothing in this file's 449 lines mentions idle
  count or a gap at all — it is a pure receiver with no notion of inter-frame
  spacing.
- **"padding enabled" → no counterpart.** Padding to a minimum wire length
  (REQ-203) is transmit-side; this file contains no padding logic.
- **"minimum frame length 64" → no counterpart, and worth flagging.** I read
  the whole file looking for anything resembling REQ-107/REQ-108's runt or
  oversize handling and found **none**: no octet counter gates a minimum or
  maximum, and the state machine (`STATE_IDLE`/`STATE_PAYLOAD`/`STATE_LAST`)
  forwards whatever lies between a recognised start and the next terminate or
  error character regardless of length. There is therefore no parameter to
  set here, and — read together with `CD-xgmii_rx_64_cosim.md`'s V1-V3
  predictions — this reference may not implement runt/oversize dropping or
  truncation at all, which Phase 1's single 64-octet frame does not probe but
  a future Phase 2/3 length sweep will.
- **"transmit checksum generation disabled" → no counterpart.** That is an
  IP/UDP transmit-layer behaviour (REQ-609, REQ-706), a different module
  pairing entirely; this RX-only file computes no checksum of its own kind.

**Question 2 — the `tuser` mapping.** Bit 0 of `m_axis_tuser` is the bad-frame
indication: it is set to `1'b1` in exactly the three branches that mark a
frame invalid (`axis_xgmii_rx_64.v:247` framing error, `:264` bad FCS in
`STATE_PAYLOAD`, `:292` bad FCS in `STATE_LAST`) and defaults to `1'b0` every
cycle (`:213`) and on every clean close (`:238`, `:283`). With
`PTP_TS_ENABLE(0)` at our instantiation, `USER_WIDTH = (0 ? … : 0) + 1 = 1`
(`:42`), so `m_axis_tuser` is exactly one bit and bit 0 is its only bit — no
PTP-timestamp aliasing is possible at this configuration (the
`PTP_TS_ENABLE`-gated block, `:240-242`, is dead code here). **Polarity
matches**: 1 means "found invalid", identically to REQ-013's `tuser`\[0\]
("this frame was found invalid"). No inversion, no remapping — the comparator
reads both sides' bit 0 the same way.

**Question 3 — the pairing.** Confirmed against `architecture.md` §4 itself,
not assumed. The row, quoted verbatim:

> `| M03 | `Xgmii_rx_64` | R | XGMII lanes to frame stream: start-lane
> detection, preamble strip, terminate handling, FCS check, error marking. |
> `axis_xgmii_rx_64.v` | 101–113 |`

The counterpart column reads `axis_xgmii_rx_64.v` exactly. Matches this
packet's assumption and `CD-xgmii_rx_64_cosim.md`'s own Pairing line; no
disagreement to report.

**Question 4 — the accept-or-discard decision.** Derived **identically** for
both sides (`ours_run.ml`'s `accumulate`, `tb_xgmii_rx_64.v`'s per-cycle
loop): a frame is admitted the cycle its start character is recognised (lane 0
or lane 4, REQ-101's control-character encoding, read from the spec's own
table, requirements.md §2 — not from either side's RTL); it is **accept** iff
an output word with `tlast` is observed for it before the run (which already
carries its own drain margin) ends, and **discard** otherwise — WO-0046
§2.3's "no output word at all" case. I expected this to differ per side (your
own phrasing anticipated it) and it did not: both M03 and the reference
present an AXI-Stream-shaped `tvalid`/`tlast` output, so the same rule reads
both. **Scope limit, stated rather than silently handled**: a second start
character arriving while a frame is still open (REQ-110's abort case) is
outside Phase 1's authorised stimulus (§9) and neither driver implements it —
both `failwith`/`$finish` loudly rather than guess, so a Phase 2 stimulus that
needs it will get an explicit failure pointing here, not a silently wrong `D`
line.

#### 3. Canonical-form implementation notes

- **Grammar reading.** The packet's grammar block (`F` / `W`* / `D`) is
  implemented literally as one triple per frame: an `F` line is **always**
  present, even for a discarded frame (zero `W` lines between its `F` and its
  `D`), rather than omitted. This is the plainest reading of the block as
  given and it round-trips cleanly (evidence below).
- **Frame index** is 0-based, input-admission order — not output position, so
  a discarded frame still owns an index and a frame missing on one side
  becomes a detectable `Missing_frame` divergence rather than an invisible
  shift of every later index.
- **Hex fields** are exactly 2 lowercase digits (`tkeep`, each octet), matching
  "hex-2" literally.
- **`tuser0` is written on every `W` line**, not only the `tlast` word,
  because the grammar block shows it in every `W` line's shape; REQ-013 still
  governs that only the `tlast` word's value is *meaningful* — the comparator
  does not read it on other words (word comparison in `compare_transactions`
  checks `tuser0` on every word only because both sides are required to
  record 0 there by construction, not because a non-`tlast` value is spec'd).
- **Comparison is by frame index**, not list position (`Int_map` keyed
  comparison in `canonical.ml`), so a missing frame reports as `Missing_frame`
  at its own index rather than desynchronising every frame after it.
- **`class_of` is `None` for every divergence this module can produce.**
  REQ-901's four declared classes all name other module pairings (M14's
  checksum, M12/M13's ARP cache, M18's UDP checksum); none names M03, so this
  lane's permitted-divergence set is empty and every divergence prints as
  `DEFECT` (§1's own instruction). The function is kept as an extension seam,
  never as an invented class.
- **Word comparison is skipped when the two sides' `decision` already
  disagree** (nothing to align a word list against), so a decision mismatch
  is reported once, cleanly, rather than compounded with a spurious word-count
  mismatch.
- **stimulus.txt is NOT the canonical form.** It is test/cosim's own internal
  seam between `stimulus_gen.ml`, `ours_run.ml` and `tb_xgmii_rx_64.v` (one
  line per cycle, two hex tokens: 16-hex `xgmii_rxd`, 2-hex `xgmii_rxc`), and
  carries no obligation to `tools/cosim/run_cosim.sh` beyond "a file path
  three of my own binaries agree on" — `run_cosim.sh` only needs to sequence
  named entry points and never needs to parse it.

#### 4. Self-check evidence (verbatim; commands reproduce at this tree)

`canonical.ml`/`.mli` and `compare.ml` need no Hardcaml — I fully type-checked
AND linked AND ran them with the system compiler, not merely parsed them:

```
$ ocamlc -c canonical.mli canonical.ml compare.ml
(exit 0, no output)
$ ocamlc canonical.mli canonical.ml compare.ml -o compare
$ ./compare --self-test
compare --self-test: known-good pair (identical canonical files)
frames compared: 1
frames matching: 1
divergences: none
  PASS: identical canonical files compare clean (exit 0)
compare --self-test: perturbed pair (exactly one octet changed, real files, real production path)
frames compared: 1
frames matching: 0
divergences: 1
  DEFECT: frame 0 word 1: octets mismatch (ours=08 09 0a 0b, theirs=09 09 0a 0b)
  PASS: a one-octet perturbation is reported and exits nonzero (exit 1)
compare --self-test: OK
$ echo $?
0
```

I additionally hand-wrote a round-trip + three grammar-violation scratch test
(write→read equality; a `D` index mismatch; a `tkeep`/octet-count mismatch; a
file ending with a frame still open) — all four raised or matched exactly as
designed. Not committed (scratch-only, per instructions not to write report
files); reproducible from `canonical.mli`/`.ml` alone.

`stimulus_gen.ml` needs only `dv_xgmii` (Hardcaml-free). I copied
`test/xgmii/{frame,arrival,xgmii_word}.ml{,i}` and `test/golden/crc32_ref.ml{,i}`
into a scratch directory, wrapped them under `Dv_xgmii`/`Dv_golden` module
aliases (the same wrapping `tools/precompile_check.sh`'s Lane 2 documents),
and fully compiled AND ran `stimulus_gen.ml` against the **real, unmodified**
library sources:

```
$ ocamlc crc32_ref.mli crc32_ref.ml dv_golden.ml xgmii_word.mli xgmii_word.ml \
    frame.mli frame.ml arrival.mli arrival.ml dv_xgmii.ml stimulus_gen.ml \
    -o stimulus_gen
$ ./stimulus_gen stimulus.txt && wc -l stimulus.txt
36 stimulus.txt
```

I cross-checked the output byte-for-byte against an independent hand/`python3
zlib.crc32` computation of the same frame (`Dv_xgmii.Frame.stress_frame
~sequence:0 ()`'s own recipe: DA 02:00:00:00:00:01, SA 02:00:00:00:00:02,
ethertype 0x0800, sequence 0, 42-octet filler `offset land 0xff`, CRC-32 per
REQ-301, appended least-significant-octet-first per REQ-202) — every one of
the ten real cycles (start word, eight data words, terminate word) matched
exactly, lane for lane, octet for octet, FCS included (`cfddc438` little-endian
→ `38 c4 dd cf`), and the residue over frame+FCS came back `2144df1c`, REQ-304's
constant.

`ours_run.ml`'s Cyclesim-driving glue could **not** be compiled here:
`hardcaml`/`hardcaml_axi`/`ppx_hardcaml`/`ppx_expect`/`hardcaml_waveterm` are
not installed in this opam switch (confirmed pre-existing: `dune build`
already failed on these before I touched anything), and
`tools/precompile_stubs/hardcaml.ml` — the one thing that lets Lane 2
type-check Hardcaml-*facing* code here — stubs only six `Bits` functions, not
`Cyclesim`/`Scope`/`Side`, and there is no stub for `hardcaml_ethernet` at all
(confirmed by reading the stub file and `tools/precompile_check.sh`'s own
`discover()`, which is exactly why it classifies any `hardcaml_ethernet`-
depending directory `EXCLUDED`). I instead pulled the bookkeeping half of
`ours_run.ml` — `accumulate` and `word_of_stream_word`, the part that decides
frame boundaries and the accept/discard call, and the part I was least
willing to trust to review alone — into a Hardcaml-free scratch copy, wrapped
`Dv_xgmii.Xgmii_word` and `Dv_monitors.Stream_word` (both real, both
Hardcaml-free) the same way, and ran five unit tests against hand-built
`(Xgmii_word.t * Stream_word.t)` traces:

```
$ ./run_tests
TEST1 PASS: one Accept frame, 8 words, final tkeep=0x0f tlast
TEST2 PASS: undrained admitted frame reports Discard with no words
TEST3 PASS: no admission, empty transaction
TEST4 PASS: two back-to-back frames get indices 0 and 1
TEST5 PASS: raised as documented: ours_run: a second start character arrived while a frame was open -- ...
```

The remaining part of `ours_run.ml` — `Scope.create`, `Sim.create
(Hardcaml_ethernet.Xgmii_rx_64.create scope)`, `Cyclesim.inputs`/`.outputs
~clock_edge:Side.Before`, the `i.xgmii_rx.d`/`.c`, `i.clear`,
`i.cfg_rx_enable`, `o.rx.tvalid`/`.tdata`/`.tkeep`/`.tstrb`/`.tlast`/`.tuser`
field names — was verified only by close, field-by-field matching against
`test/xgmii_rx_64/bench.ml`'s already-reviewed pattern (same construction, same
`Before`-view convention and its BUG-0001/RV-0038-R6 rationale, same field
names), and against the real signatures in
`docs/specs/ifc_check/xgmii_rx_64_ifc.ml`, `test/xgmii_probe/xgmii_probe.ml`
and `test/axi64_probe/axi64_probe.ml`. This is a hand cross-check, not a
compiler, and I am saying so rather than letting the parsing-only result below
imply more.

All five `.ml`/`.mli` files, parsed (syntax only, the widest check reaching
every file uniformly):

```
$ ocamlc -stop-after parsing test/cosim/canonical.ml test/cosim/compare.ml \
    test/cosim/ours_run.ml test/cosim/stimulus_gen.ml test/cosim/canonical.mli
(exit 0, no output — all five clean)
```

`tools/precompile_check.sh`, before and after adding `test/cosim/`: both
`ALL LANES PASSED`. `test/cosim` is automatically classified
`EXCLUDED — executable stanza; this harness compiles libraries only` by the
script's own generic dune-stanza-kind discovery (`discover()`, read in full
before I added anything) — no edit to `tools/**` was made or needed:

```
$ bash tools/precompile_check.sh   # after
…
--- LANE 3a — coverage sweep
  EXCLUDED cosim — executable stanza; this harness compiles libraries only
  EXCLUDED cost_probe — executable stanza; this harness compiles libraries only
  EXCLUDED hardcaml_ethernet — depends on hardcaml_waveterm hardcaml_ethernet, which this harness cannot transcribe
  EXCLUDED xgmii_rx_64 — depends on hardcaml_ethernet, which this harness cannot transcribe
  RESULT: 43 files in compiled directories, all 43 materialised and compiled.
…
precompile_check: ALL LANES PASSED
```

`tools/dv_checks.sh`: exit 0 before and after, identical (the pre-existing
`check_rfc1071_anchor.sh` OBLIGATION-OPEN line is unrelated — blocked network
egress in this container, documented since `J-dv_lead-0017`).

**`dune build`/`dune runtest` could not be run at all, before or after my
change.** `dune build` (bare, no target) already failed on this checkout
*before* I wrote anything, on `ppx_expect`/`hardcaml_axi`/`ppx_hardcaml`/
`hardcaml_waveterm` not being installed in this opam switch — a pre-existing
environment gap, not something this packet introduced. `test/cosim`'s
`(executables)` stanza carries no `(rule (alias runtest) …)` (unlike
`test/cost_probe/dune`'s own throwaway probe), so it is structurally
unreachable from `dune runtest` by construction, which is the mechanism §2.2
relies on — I could not additionally observe it stay green, only confirm the
mechanism is in place and that the fifteen existing `%expect_test` units'
source files are untouched (`git status --porcelain` above lists no path
under `test/xgmii_rx_64/` or any other existing bench directory).

#### 5. Open questions

1. **The `.canon.meta` sidecar's simulator-name/version and runner-image
   fields have no owner I can find pinned in the packet.** Neither
   `ours_run.ml` nor `tb_xgmii_rx_64.v` can determine its own toolchain's
   version or the runner's identity from inside itself with "no arguments, no
   environment beyond `PATH`" (§2.1) — only the invoking shell
   (`run_cosim.sh`) can, e.g. via `iverilog -V`. I had each producer write a
   best-effort sidecar with what it *can* determine on its own (the fixed
   reference pin, and the stimulus file/line count it actually consumed) and
   left the other two fields explicitly marked `unknown (fill in: ...)`
   rather than fabricate or silently omit them. Please confirm whether
   `run_cosim.sh` should overwrite/append these two fields after each run, or
   whether the split should move entirely.
2. **The reference's own length-enforcement behaviour is unmeasured, not
   just its parameters (question 1).** Reading the whole 449-line file, I
   found no runt/oversize logic of any kind — not "a different threshold",
   *none*. If that reading is right, `CD-xgmii_rx_64_cosim.md`'s V1/V2/V3
   predictions ("reference drops" a runt/undersize/oversize frame) may
   themselves need revising to "reference forwards regardless of length" once
   Phase 2/3 actually drives one — I have not driven one (out of Phase 1's
   scope, §9) and am not asserting this as a run result, only as a reading of
   the source worth flagging before it surprises Phase 2.
3. **`ours_run.ml`'s Cyclesim-driving code is unverified by compilation here**
   (§4) — this environment has neither the real Hardcaml toolchain nor a stub
   covering `Cyclesim`/`Scope`/`hardcaml_ethernet`. `dune build @default` at a
   real toolchain is where this closes, per ADR-0005's own standing pattern
   for every other Hardcaml-facing file in this tree.
4. **The 24-cycle drain margin (`stimulus_gen.ml`) is a round, generous
   number, not a measured one** — I was told not to hand-simulate iverilog's
   output, so I did not try to derive the reference's exact pipeline depth
   from its source to justify a tighter figure. If the first real run shows
   it insufficient (unlikely — the reference visibly needs only a handful of
   register stages), it is a one-constant change.

No RTL was read this spawn. `libs/**`, `top/**`, `bin/**` and `rtl_snapshots/**`
were not opened, globbed, or otherwise consulted at any point.

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

---

## RV-0046-VERDICT (bench half): ACCEPT — dv_lead, `J-dv_lead-0056`

**No correctness defect. No blocking defect.** One ruling settles both workers'
sidecar question; one finding of the worker's forces a revision to my own Phase 0
document and raises a spec diff.

### 1. The canonical grammar — **exact to the pin**, and stricter than I specified

`canonical.ml` writes `"F %d\n"`, `"W %02x %d %d"` with `" %02x"` per octet, and
`"D %d %s\n"` — **character-for-character §2.3's grammar**, two-hex tkeep, 0|1
flags, two-hex octets, LF endings, nothing else in the file.

**The parser is stricter than the packet required**, and the additions are the
ones that matter: it rejects an unrecognised record kind, a `W` outside an open
frame, an `F` while one is open, an `F`/`D` index mismatch, a file ending with a
frame still open — and **a `W` line whose octet count disagrees with its
`tkeep`**. A lenient parser would let two malformed files compare equal; that
last check is the one I would most have wanted and did not think to pin.

**And one decision better than my pin.** §2.3 said `F` opens a frame and `W`
lines follow; it left implicit what a frame with *no* output words looks like.
`canonical.mli` fixes it: such a frame "still owns an index and a `D` line". Had
it not, a discarded frame would be invisible in the file and REQ-901's
accept-or-discard comparison could not be keyed by index at all. Caught by the
worker, not by me.

### 2. `dune` — and the worker checked the thing that actually matters

`(executables (names stimulus_gen ours_run compare))`, no `(inline_tests)`.

**More to the point, it verified there is no `runtest` wiring** — no
`(rule (alias runtest) …)` — and cited `test/cost_probe/dune` as the contrast
case that has one. **That is the correct check.** Absence of `(inline_tests)`
alone would not have been sufficient; a rule aliased to `runtest` would have
dragged the lane into the main suite just as effectively, and only someone who
went looking would know the repository contains an example.

§2.2's constraint is met, and the main suite's fifteen units are untouched.

### 3. The comparator and its self-test — better than the packet asked for

§4.2 required the mismatch check to exercise **the production path**, because the
natural implementation proves a *different* comparator can fail. `compare
--self-test` does, and it has already **run and passed in-container**: a
known-good pair compares clean at exit 0; a one-octet perturbation is reported
with the exact octets named, exit 1.

**What made that possible was a deliberate design decision, and it deserves
naming**: `compare` depends on nothing beyond `canonical.ml` and the standard
library — no Hardcaml — so it builds and self-tests where the toolchain is
absent. **The comparator is proven able to fail before CI has run once.** I asked
for the check to exist; it exists *and* has already fired.

### 4. The four questions

**Q1 — verified independently, and the answer is bigger than the question.** Only
`PTP_TS_ENABLE(0)` of REQ-901's five settings has a counterpart. I checked the
"no length check" claim myself rather than take a strong negative on report:
`grep -niE "length|runt|oversize|too_short|too_long|min_|max_|frame_len"` over
all 449 lines returns **nothing**. Confirmed, and see §6.

**Q2 — accepted.** `m_axis_tuser` bit 0 is bad-frame, `USER_WIDTH` = 1 under
`PTP_TS_ENABLE(0)`, polarity matching REQ-013. Consistent with the
`error_bad_frame_next` assignments I read at :248 and :265.

**Q3 — resolved, and it closes an open question of mine.** `architecture.md` §4's
counterpart column quoted verbatim: M03 pairs with `axis_xgmii_rx_64`. I had been
writing that pairing from **inference** since WO-0044 and flagged it at
`J-dv_lead-0052` as possibly able to move the packet. It does not move.

**Q4 — accepted, and the instinct is the right one.** Accept/discard derived
symmetrically (admitted on start; accept iff `tlast` observed; discard
otherwise), implemented independently in both drivers so neither inherits the
other's reading. And REQ-110's second-start case is out of Phase 1 scope with
**both drivers failing loudly rather than guessing** — which is the correct
disposition for an unscoped case and the opposite of the one that produces a
quiet wrong answer.

### 5. RULING — the `.canon.meta` sidecar has ONE writer: `run_cosim.sh`

Both halves asked this from opposite sides. One ruling settles both.

**The OCaml producers write no sidecar at all.** `stimulus_gen` and `ours_run`
emit only canonical files. **`tools/cosim/run_cosim.sh` creates each sidecar**,
because it is the only actor that knows all four fields at the moment of the run:
the reference pin (a repository fact), the **simulator name and version** (only
the invoker knows), the **runner image** (only CI knows), and the stimulus
identifier.

**Placeholders are barred. If `run_cosim.sh` cannot determine a field, the run
FAILS.** A `"unknown (fill in:)"` marker in an evidence artifact is worse than an
absent file: it can be read as a recorded value, and **the reproducibility
guarantee's entire antecedent is those fields being real**. A run that cannot
record them cannot claim the guarantee, so it must not appear to.

The overwrite-or-append question dissolves: with no producer-written sidecar
there is nothing to overwrite. **Single writer, single owner, checkable
obligation.**

### 6. The no-length-check finding — CD revised NOW, and a spec diff raised

**Revised now, and the discipline permits it.** CD §0 bars moving an entry
outward only *after a run has probed it*; **Phase 1 drives one 64-octet good
frame and probes none of V1–V3**. And this is a **source reading I verified
myself**, not a result being fitted to. Leaving a mechanism I now know to be
wrong standing in a frozen document is the stale-inference defect this programme
has corrected six times.

**What was wrong**: V1–V3 predicted the reference **drops** short and long
frames. It has **no length logic at all** and forwards them unmarked. The
predictions were right that a divergence appears and wrong about why.

**What follows is larger than the correction.** For a runt, ours marks
`tuser`[0] = 1 and the reference does not; for oversize, ours truncates to 1514
and marks, the reference forwards whole. **Both divergences are in `tuser`[0] on
the `tlast` — inside REQ-901's comparison domain**, where any divergence outside
its four classes "is a defect". **It is not a defect; it is a deliberate
specification difference**, and REQ-901's only legitimate resolution is a **fifth
divergence class added by spec diff** — which my comparison domain cannot grant
(CD §0-bis).

> **Raised and routed to architect_docs_lead.** REQ-901 requires such a class
> "before any sign-off packet may cite it", so **the co-simulation cannot anchor
> families F (runts) or G (oversize) until that spec diff lands.** CD §2's
> finding is sharpened accordingly: the lane anchors clean frames and the FCS and
> `/E/` paths, where counterparts exist, and **cannot anchor the length-derived
> error paths in either half.**

Also corrected in CD: §2 claimed the reference has no counterparts for our five
strobes. **Two it has, by the same names** — `error_bad_frame` and
`error_bad_fcs`. §2's conclusion survives on a better ground: **REQ-901 does not
compare strobes at all.** Third time REQ-901 has superseded my own reasoning in
that document.

### 7. Expected CI

- **`dune build @default`: `ours_run.ml` is the genuine unknown** — the one file
  here that elaborates `Hardcaml_ethernet.Xgmii_rx_64`, and the first real
  compile of it in this directory. Named risks: **warning 9 fatal** on any record
  literal, and the `Cyclesim.With_interface` entry point. `canonical` and
  `compare` are already `ocamlc -c` type-checked in-container, so a Build failure
  is almost certainly `ours_run`'s.
- **`dune runtest`: unchanged and green — fifteen units, none of them here.**
  This stanza is structurally unreachable from `runtest`, which is §2.2's whole
  point and now a review check that passed.
- **The cosim job has not run and this verdict claims nothing about it.**

### 8. Conduct

The self-test was run rather than merely written, on the production path, and the
dependency choice that made that possible was deliberate. The `runtest`-wiring
check went past the obvious test to the one that would actually catch the
hazard. A strong negative about the reference was reported as a **reading**
rather than a result, correctly hedged, and it turned out to be both true and
more consequential than reported. And the out-of-scope REQ-110 case fails loudly
instead of guessing.

## Return log — round 2

### data_wrangler — `tools/cosim/run_cosim.sh` (RETURNED, round 2)

**Journal**: `J-data_wrangler-0002`. **Trigger**: `RV-0046-VERDICT`'s ruling on
the sidecar (§5, ACCEPTED) plus `test/cosim/**` having landed, both requiring a
second pass over `run_cosim.sh`. **Write scope used**: `tools/cosim/run_cosim.sh`
only (modified in place); nothing under `test/**` was written — the still-
placeholder-writing Verilog code noted below is flagged, not fixed.

#### 1. The sidecar ruling, implemented

dv_lead's ruling is now the script's design, not an open question: `run_cosim.sh`
is the sidecar's **sole writer**. `write_sidecar` runs **after** both producers
for a run finish and **fully overwrites** `<name>.canon.meta` (truncate + write,
never append) — so the placeholder text `tb_xgmii_rx_64.v` **still writes** into
`theirs.canon.meta` today (`simulator: unknown (fill in: …)`,
`runner-image: unknown (fill in: …)` — read in full this round, lines 263–276 of
the landed file) is replaced before anything downstream — the comparison, the
determinism diff, an on-failure dump — ever reads it. **`test/cosim/tb_xgmii_rx_64.v`
was NOT edited** to remove that code — `test/**` is outside this agent's write
scope — so it is flagged here for tb_writer's next round: per dv_lead's ruling
("the producers write no sidecar at all"), that six-line block (the `$fwrite`
calls building `theirs.canon.meta`, plus the `meta_fd` open/close around them) is
now dead weight the testbench doesn't need, since this script's overwrite makes
its output moot regardless. Removing it is tb_writer's to do, not blocking Phase 1.

#### 2. The four REQUIRED fields, fail-closed, no placeholders anywhere

`require_field` gates all four before any sidecar is written: **reference pin
SHA** (parsed from `PROVENANCE.md`, as round 1), **simulator version** — now
**both** `iverilog -V` and `vvp -V`, captured separately (round 1 only captured
`iverilog -V`; the coordinator's round-2 instructions named both explicitly and
the reproducibility guarantee's antecedent is about the simulator that actually
ran the design, which is `vvp`, at least as much as the compiler that built it)
— **stimulus sha256** (unchanged), and **runner image** (new construction, next
item). Any of the four empty fails the whole run with the new **`EXIT_PROVENANCE`
= 7**, distinct from `EXIT_INTERNAL` because the three checks' own machinery may
be fine — only the provenance record is not attestable, which the script treats
as reason enough on its own. The `dpkg-query` package version stays exactly as
round 1 left it in spirit but is now explicitly **advisory, not gated** (R-CI-3's
extra forensic detail, not part of the antecedent) — and, applying dv_lead's own
"no marker that reads as a recorded value" principle to this one non-required
field too, an unavailable `dpkg-query` result now **omits the key from the
sidecar entirely** rather than writing any "unknown"/"not available" text for it.

#### 3. The runner-image field outside CI — decided, not left as a gap

In CI, `$ImageOS` (+ `$RUNNER_NAME` if present) is used, prefixed `ci:`. Outside
CI — a developer running the full pipeline locally with a real toolchain on
PATH — the field is built from `hostname` + `uname -srm` + (if readable)
`/etc/os-release`'s `PRETTY_NAME`, prefixed `local:`. This is a **real,
determinable value**, not a placeholder: every token is a fact this shell can
read about the machine it is actually on. **A genuine bug found and fixed while
writing this**: the first version of this composition used
`"${host:-unknown-host}"`/`"${unamestr:-unknown-kernel}"` to paper over a
*partial* failure (e.g. `hostname` unavailable but `uname` fine) — which would
have embedded a literal `unknown-host`-shaped token into a field this same
script then treats as real, exactly the marker-that-reads-as-a-recorded-value
dv_lead's ruling bars, self-inflicted one level down. Caught by re-reading my
own diff before returning it, not by an external review. Fixed: the field is now
composed **only** from whichever of `hostname`/`uname`/`os-release` actually
succeeded, with no filler for the others; only if **all three** are empty does
`runner_image` return failure and the run stop at `EXIT_PROVENANCE`. This keeps
a genuinely runnable local lane genuinely able to pass — ADR-0015 D1's own
finding that "the local lane is genuinely usable" would otherwise be defeated by
a rule aimed at fabricated values, not real local ones.

#### 4. The pinned entry points — assumption replaced by confirmed fact, one bug fixed

`test/cosim/**` landed this round (`stimulus_gen.ml`, `ours_run.ml`,
`compare.ml`, `tb_xgmii_rx_64.v`, all read in full). Round 1's zero-argument
assumption was **half right**: `stimulus_gen`/`ours_run` do default to
cwd-relative filenames when given fewer args than paths, but this script now
passes each of them its path(s) **explicitly and absolute**, needing no `cd` for
either. **`compare` does not default at all** — it requires exactly two
positional arguments (`<ours.canon> <theirs.canon>`) or the literal
`--self-test`, and prints usage + exits 2 for anything else, including zero
arguments. **Round 1's script called `compare` with zero arguments for the real
comparison (check 4.1)** — this would have hit `compare`'s usage branch on every
real run, exiting 2 and comparing nothing, while still being misreported by this
script as `EXIT_DIFFERENTIAL` on any nonzero exit. **Found and fixed this
round**, before it ran once in CI: `compare` is now called with both canonical
files' explicit absolute paths. `tb_xgmii_rx_64.v` has no argv support at all
(confirmed: no `$test$plusargs`) and hardcodes `stimulus.txt`/`theirs.canon`/
`theirs.canon.meta` relative to `vvp`'s cwd, exactly as round 1 assumed and as
the file's own "WORKING DIRECTORY CONTRACT" comment states — this script still
`cd`s into the run directory only for that one invocation. Round 1's open
questions 1 and 2 are closed by this reading, independent of the sidecar ruling:
the calling convention is confirmed, and the bare `iverilog -o <bin> <sources>`
invocation needed no change — `tb_xgmii_rx_64.v` is plain Verilog-2001, per its
own header comment.

#### 5. Local testing, round 2

- `bash -n tools/cosim/run_cosim.sh` — clean syntax.
- `shellcheck tools/cosim/run_cosim.sh` — zero findings, exit 0 (same
  shellcheck 0.9.0 installed in round 1, still present).
- **Degraded path, re-run for real**: `iverilog`/`vvp`/`dune` are still absent
  from this container. Output is byte-for-byte the same shape as round 1 (see
  Evidence) — exits `2` (`EXIT_PREREQ`), never `0`.
- **New this round**: since the four-required-field / `runner_image` /
  `require_field` logic sits entirely inside bash and does not need
  `iverilog`/`vvp`/`dune` to exercise, I extracted those functions into an
  isolated harness and ran nine scenarios against them for real (all verbatim
  in `J-data_wrangler-0002`'s Evidence): a normal local machine; CI-style
  `$ImageOS` with and without `$RUNNER_NAME`; `require_field` on a real value
  (does not die) and an empty one (dies, exit 7, quotes dv_lead's ruling);
  `hostname` failing alone; `uname` failing alone (these last two are what
  caught the bug in item 3 above); both failing with no `/etc/os-release`
  fallback (returns failure, as designed); and `write_sidecar`'s conditional
  omission of the advisory `dpkg-query` field, both present and absent. This is
  the same "traceable by review" instruction as round 1, extended with actual
  execution everywhere execution was possible without the missing simulator.
- The `iverilog`/`vvp`/`dune`-dependent path (BUILD, both `run_pipeline` calls,
  the real `compare` invocations) remains traceable by review only, as round 1
  stated and as remains true here — no simulator exists in this container.

#### 6. Open questions (round 2)

1. **The `dpkg-query` advisory-vs-gated line.** I read "simulator version" in
   the reproducibility guarantee's antecedent as `iverilog -V` + `vvp -V` only
   (matching the coordinator's round-2 instruction, which named exactly those
   two), and the distro package version as R-CI-3's separate, non-gated
   forensic extra. If dv_lead intends the package version to be part of the
   gated antecedent too, `require_field` needs one more call — a one-line
   change, flagged rather than assumed.
2. **`test/cosim/tb_xgmii_rx_64.v`'s still-placeholder-writing sidecar code**
   (item 1 above) is now dead weight under dv_lead's ruling. Not fixed here
   (outside this agent's write scope); noted for tb_writer's next round.
3. Round 1's open question 3 (`dune build`'s `_build/` cache landing inside the
   checkout, gitignored) was not addressed by `RV-0046-VERDICT` and remains
   open; repeated here rather than assumed resolved by silence.

---

## COUNTERSIGNATURE — REQ-901 classes (e) and (f) at `ebb3f49` — dv_lead, `J-dv_lead-0057`

**SIGNED. The diff is countersigned and in force on transcription.**
`docs/specs/**` is outside my write scope, so this is the signature of record and
the orchestrator transcribes it, per the clerical-transcription rule.

### 1. Verified against the diff, not the summary

- **Class (e)** present and grounded in the verified fact — no frame-length
  logic in the vendored reference, length sweep over 449 lines at pin `77320a9`,
  zero matches. **It pre-empts the obvious objection in its own text**: the
  `MIN_FRAME_LENGTH` parameter named in REQ-901's configuration clause is
  `axis_xgmii_tx_64.v`'s, driving transmit padding, so that clause confers no
  receive-side length check. I had not spotted that and would have had to answer
  it later.
- **Class (f)** present, whole-frame exclusion including the resynchronisation
  window.
- **Bounded**: "(e) and (f) exclude **nothing in the 64-to-1518-octet range**".
- **The cost rule** is stated once for all classes: inside an exclusion the
  co-simulation anchors nothing, the excluded requirement is verified by
  directed test, and **a sign-off packet SHALL NOT offer a co-simulation result
  as its external anchor**.
- **ADR-0015's converse is restated inside the requirement**: an exclusion is
  never a licence to take an expected value from the reference.
- **The numeral "four" is retired** and — better than I asked — the **append-only
  lettering rule is written into REQ-901's own text**, so no cited letter can
  ever move.

**And the claim I would not sign on assertion, checked directly**: the change-log
row classes the REQ-107/REQ-108 edits as *concurrence, verification columns
only, both normative sentences untouched*. I extracted each row's normative
column at `ebb3f49^` and at `ebb3f49` and compared: **both are byte-identical.**
The classification is correct, and the two axes are kept on separate §13 rows so
the countersignature-owed answer and the concurrence answer are not blurred.

### 2. The (e) confirmation the architect asked for — **CONFIRMED**, and I checked the load-bearing fact

The question is whether leaving payload and `tkeep` compared on 5-to-63-octet
frames matches what my comparison domain needs. **It does, and it is better than
the whole-frame exclusion my finding would have supported.**

That turns entirely on one thing: **does the reference strip the FCS on a runt?**
If it did not, payload would diverge too and (e) would be too narrow — I would be
signing a class that produces a false defect on every runt the lane ever drives.
So I read it rather than reason about it. The reference's FCS check is an
**eight-entry lane-indexed residue array** (`crc_valid[7..0]`, one precomputed
residue per possible terminate lane) with **no length gate anywhere on it**. It
strips unconditionally and delivers `length − 4`.

**So on a 5-to-63-octet frame the two designs deliver identical octets with
identical `tkeep`, and `tuser`[0] is the only divergence.** (e) excludes exactly
that and nothing more.

**What the narrowness buys is concrete and I want it on the record**: M03-F1's
core observable — REQ-103's FCS removal on a runt, delivered counts 1, 12, 56 and
59 with their `tkeep` extents — **remains co-simulation-anchorable.** A
whole-frame exclusion would have thrown that away for a divergence confined to
one bit. **Narrower was right.**

**And the sub-5 disposition is right too, for a reason the same reading gives.**
Below five octets there are not four octets to strip, so the reference's
behaviour is undefined rather than merely different — which is precisely why (e)
excludes such a frame entirely, accept-or-discard included, and records the
reference's actual disposition as **data, never adjudicated**.

> **One cross-link worth flagging, and it is not an objection.** `WO-0047` §3.2
> flags M03-F2's declared kill — an FCS-strip counter underflowing on a frame
> with nothing to strip — as possibly unachievable, and says the campaign settles
> it. The reference is a design with no sub-5 handling at all, so the data (e)
> mandates collecting will show what a real implementation does there. **That is
> evidence about whether the defect class is natural, not about our RTL**, and it
> must never be used as an expected value — which is the clause (e) itself
> restates.

### 3. What this changes downstream

`CD-xgmii_rx_64_cosim.md` §2-bis is updated: it predicted a whole-frame runt
exclusion, and the narrower class governs. The paragraph stands as a recorded
miss with the correction above it.

**The `SO-M03` consequence is unchanged in kind and smaller in size**: REQ-107
and REQ-108 rest on their own directed tests and **no sign-off may offer a
co-simulation result as their anchor** — but family F's FCS-removal observable
keeps an anchor it would otherwise have lost.

**The cascade** — three stale restatements in module specs and traceability,
enumerated in the §13 row and deliberately not folded in — is correctly deferred
to a follow-on WO. Folding it here would have mixed a countersignature-owed diff
with editorial repairs and made this signature harder to give, not easier.
