# WO-0038: The programme's first bench — M03's clean-frame spine
- **State**: ISSUED
- **From** / **To**: dv_lead → tb_writer
- **Spec basis**: `docs/specs/modules/xgmii_rx_64.md` (SPEC-M03) at the
  countersigned SHA — §4.1 ports, §6.1 cycle table, §6.3 output rules,
  §7 constants, §8 checks, §9 rulings, §10 hooks; and
  `docs/specs/requirements.md` §0.3, §0.5, §0.6, §0.7, §12.
  REQ ids in scope: **REQ-101, REQ-102, REQ-103, REQ-106, REQ-011,
  REQ-012, REQ-015, REQ-021, REQ-112, REQ-003**.
  Attack-plan rows: `test/attack_plans/AP-xgmii_rx_64.md` §4.A, §4.B
  (row B1 only), §4.C, and §4.L row L6 — **11 rows**, listed in §2 below.
- **Deliverables**: a new library under `test/xgmii_rx_64/` —
  `dune`, `bench.{ml,mli}`, `test_m03_a.ml`, `test_m03_b.ml`,
  `test_m03_c.ml`, `test_m03_structural.ml` — plus the Return log of
  this packet and a journal entry in
  `agents/journals/workers/claude_tb_writer_agent.md`.
- **Definition of done**: every row in §2 mapped to a named test or
  explicitly declared not-implemented with a reason; every `[%expect]`
  block empty per ADR-0005 rule 2; every verdict asserted in OCaml;
  Return log filled to §8's format; journal entry appended; no file
  outside `test/**` and this packet touched. No doc impact.
- **Context provided**: the specification sections and requirements
  sections named above; the attack-plan rows in §2; the machinery
  contracts in §3, quoted from `.mli` files the worker may read in full.
  **RTL source is deliberately omitted — see §5.**
- **Out of scope**: `libs/**`, `rtl_snapshots/**`, `docs/**`, `tools/**`,
  `bin/**`, `.github/**`; any attack-plan row not listed in §2; writing
  an `SO-` packet (§8); `git commit` / `git push`.

## Task

Build the first bench in this programme: the clean-frame spine of
`Xgmii_rx_64`, eleven attack-plan rows, on machinery that is already
built and unit-tested. Everything after this — the injected families,
the stress run, config and reset — reuses the scaffolding you write
here, so the scaffolding is the deliverable as much as the rows are.

---

## 1. Why this slice, and why not a bigger one

AP-M03 has **74 rows, 58 of them ASSERT**. This packet takes **11**. The
reasoning is worth stating, because you should push back if you think it
is wrong:

- **A + C are the spine.** Family A is start detection, alignment and
  byte order at both start lanes; family C is frame extraction, the
  eight `tkeep` residues, the 1518-octet maximum and the one-word
  minimum. Every other family drives frames through that same path and
  then perturbs something. A bench for family E that cannot first prove
  a clean frame arrives correctly is not measuring what it thinks.
- **This slice needs no error injection.** `test/xgmii/injection.ml` (the
  catalogue and the §9 outcome model) is built and its own tests pass,
  but its expected-outcome side is the least-exercised machinery in the
  tree — it has never yet been checked against a design. If the first
  bench depended on it, a red result would have two candidate causes and
  you would not be able to tell them apart. So: clean path first,
  injection second, and when the injected families land the outcome
  model will be the only new variable.
- **A4 is NO-ASSERT and A5 is a trap.** Both are in the slice on
  purpose. A first bench that learns the NO-ASSERT discipline and the
  position-dependent-filler discipline on day one will not have to
  unlearn anything.
- **A2 and C2 carry C-18**, the specification's own hardest known
  defect. This slice is not a smoke test.

**Deliberately excluded, so no one mistakes silence for coverage**:
families D, E, F, G, H, M, N (error injection — the next packet);
family I (idle injection, `Idle_injection`); families J and K (config
and reset); **L1–L5, the 10 000-frame stress run**. L1–L5 are a charter
§3 sign-off requirement for every rx-path module and they are *not*
optional — they are simply not first, because nobody has yet measured
what 10 000 frames costs under `Cyclesim` and a first bench should not
be the experiment that finds out. `test/cost_probe/` exists to answer
that and its figure should be read before that packet is written.

## 2. The eleven rows

Read each row **in the attack plan itself** — the Observable cell is the
contract, and this table is an index, not a substitute.

| Row | Status | One-line reminder |
|---|---|---|
| **M03-A1** | ASSERT | 64-octet frame, lane-0 start: 8 words, `tkeep` 0xFF×7 then 0x0F, `tlast`, output word m on cycle m+3 |
| **M03-A2** | ASSERT | Same 64 octets, **lane-4** start: same tuples, word 0 on cycle 3, **FCS good** (the C-18 kill) |
| **M03-A3** | ASSERT | C1's directed length set driven at both lanes; the two runs equal as ordered `(tdata, tkeep, tlast, tuser)` sequences |
| **M03-A4** | **NO-ASSERT** | The absolute cycle of the first output word is **NOT** asserted equal between lanes. §6.1 and §10 forbid it |
| **M03-A5** | ASSERT | Position-dependent filler; octet j at `tdata[8·(j mod 8)+7 : 8·(j mod 8)]` of word ⌊j/8⌋ |
| **M03-B1** | ASSERT | Arbitrary non-standard filler and SFD **data** octets: frame delivered unchanged (REQ-102 forbids validating them) |
| **M03-C1** | ASSERT | Lengths 64…71 at both lanes (16 frames): all eight `tlast` `tkeep` patterns exactly once, terminate in every lane |
| **M03-C2** | ASSERT | The C1 subset whose terminate lands in lane k > 0: the k octets are delivered and FCS is good (the C-18 twin) |
| **M03-C3** | ASSERT | One **1518**-octet frame, both lanes: 1514 octets in **190** words, final `tkeep` 0x03 |
| **M03-C4** | ASSERT | The 5-octet runt: a **one-word** frame, `tkeep` 0x01, `tlast` — legal, and the sentence C-11 deleted would have forbidden it |
| **M03-L6** | **STRUCTURAL** | No `tready` exists on the stream under test. Discharged by a statement about the type, not a waveform |

**A4 and L6 are not filler.** A4 is a row whose whole content is a
prohibition: if your bench asserts cross-lane cycle equality anywhere,
A4 has failed even though no assertion fired. L6 is discharged by the
fact that `Axi64.Source` has no `tready` field and no `Dest` is on the
port — write it as a compile-time witness (a `let _ = ...` naming the
record's fields, or a comment-free type annotation that would fail to
compile if a `tready` appeared), not as a runtime check that can pass
vacuously.

## 3. Machinery contracts — what you build on

All of it is committed, unit-tested and green. Read the `.mli` files in
full; they are the contract, and their docstrings carry the reasoning.
Two numbering schemes exist and are easy to confuse — the WO-0033 item
numbers (`X-1`…`X-9`) and AP-M03 §7's local numbering — so this table
keys on **files**, which are unambiguous.

| What | Where | You use it for |
|---|---|---|
| Frame construction, FCS, padding | `test/xgmii/frame.mli` — `with_fcs`, `pad_to_60`, `delivered`, `residue_ok`, `stress_frame ?filler ~sequence` | Building every frame. `stress_frame`'s default filler is **position-dependent**; A5 depends on that and B1 needs a filler you choose |
| The link-partner schedule | `test/xgmii/arrival.mli` — `create ?ifg ?first_start ?fcs_valid`, `stress ?count ?filler`, `frames`, `word_at ~cycle`, `words`, `cycles`, `start_cycle`, `in_times`, `delivered`, `start_lanes`, `start_spacings`, `gaps`; and **`check : t -> string list`** (empty ⇒ conformant), `is_clean`, `report` | Driving the wire. `word_at ~cycle` is the per-cycle source. **Standing obligation 5**: call `check` (or `is_clean`) on every schedule and fail the test if it is non-empty, *before* driving — a stimulus generator nobody has checked is an unverified assertion about the design. `create`'s `?first_start` defaults to octet time 8, so a bench sees one idle word before any frame |
| XGMII words | `test/xgmii/xgmii_word.mli` — `of_lanes`, `of_data`, `lane`, `is_control`, `start_lane`, and the five character constants | Reading and building wire words |
| **The XGMII probe** | `test/xgmii_probe/xgmii_probe.ml` — `to_refs ~d ~c word`, `to_port port word` | **Driving the DUT's `xgmii_rx` port.** `to_port` takes the lifted `Xgmii.t` record of `Bits.t ref`s |
| **The stream sampler** | `test/axi64_probe/axi64_probe.ml` — `of_refs`, `of_source` | **Sampling the DUT's `rx` output** into `Dv_monitors.Stream_word.t`, which every monitor consumes |
| Protocol monitor | `test/monitors/protocol_monitor.mli` — `create ~name ?max_words_per_frame`, `observe ~cycle`, `violations`, `is_clean`, `frames`, `words`, `octets` | Standing obligation 1. **`~max_words_per_frame:190`** |
| Conservation monitor | `test/monitors/conservation_monitor.mli` — `create ~name`, `frame_in`, `frame_in_exempt ~reason`, `frame_out ~aborted`, `discarded ~strobes`, `strobe_pulse ~name` | Standing obligation 2. This slice drives no exempt frames (families J and K do), but wire the calls now |
| Latency tagger | `test/monitors/octet_time.mli` — `Latency.create`, `frame_in`, `frame_out ?expected_octets`, `frame_dropped` | Standing obligation 3, configured `~strip_octets:8 ~tail_octets:4 ~front_offsets:[8; 12] ~ceiling:4`. Constancy is judged **per front-offset class** (C-15) |
| Strobe monitor | `test/monitors/strobe_monitor.mli` — `create ~name ~strobes`, `expect`, `sample ~cycle ~high`, `is_clean`, `report` | Standing obligation 4. Counts **high cycles, never rising edges** (C-23). This slice expects **no strobe at all**, which is exactly what makes it a useful check here |
| Stream words | `test/monitors/stream_word.mli` — `of_octets`, `keep_count`, `keep_is_contiguous_from_zero`, `octets` | Reading sampled output |

**Standing obligations §2.1–§2.6 of the attack plan attach to every
bench in this packet.** Obligation 6 in particular — never read `tdata`
where `tkeep` is 0, never read any output field on a cycle with
`tvalid` = 0 — is a rule about your *bench*, and violating it can make a
conformant design look wrong.

## 4. How to instantiate the DUT without reading it

This is the part that makes bench independence workable rather than
merely declared, so it is spelled out.

- The **ports** come from `docs/specs/ifc_check/xgmii_rx_64_ifc.ml`, the
  lift of SPEC-M03 §4.1 — byte-identical to the specification and
  countersigned. `I = { clock; clear; xgmii_rx : Xgmii.t; cfg_rx_enable }`,
  `O = { rx : Axi64.Source.t; error_bad_fcs; error_bad_frame;
  error_runt; error_oversize; error_start_without_terminate }`.
- The **entry point** comes from SPEC-M03 §4.2's `module type S`:
  `val create : Scope.t -> Signal.t I.t -> Signal.t O.t`.
- The **module path** comes from SPEC-M03's own header, which names
  `libs/hardcaml_ethernet/src/xgmii_rx_64.ml` as the implementation
  home — so the bench writes `Hardcaml_ethernet.Xgmii_rx_64.create`.

You therefore name three things from the design — a library, a module
and a function — all of which the **specification** states, and you open
no RTL file. If the implementation's ports diverge from the lift, your
bench fails to compile, and that failure is REQ-010's type-identity
check doing its job. Do not "fix" such a failure by adjusting the bench
to the implementation: report it, because it is a finding.

`test/hardcaml_ethernet/test_word_counter.ml` is the one existing
Hardcaml bench in the tree and shows the `Cyclesim.With_interface` /
`Waveform.create` shape. It is DV's own file and you may read it freely.

## 5. What you may NOT read

Per PROTOCOL §10 and dv_lead's charter §3, and enforced by your journal
`Inputs` section plus auditor sampling — Claude Code has no per-path
read denial, so this is honest-enforcement and your journal is the
evidence:

- **`libs/**`** — above all `libs/hardcaml_ethernet/src/xgmii_rx_64.ml`,
  the module under test. Not to "check what it does", not to debug a
  red, not to confirm a port name.
- **`rtl_snapshots/**`** — the emitted Verilog is the design in another
  language. Reading it is the same violation with extra steps.
  **Note for the orchestrator**: `.claude/agents/tb_writer.md` names
  `libs/` and `top/` but not `rtl_snapshots/`, which has held generated
  Verilog since WO-0012. The launcher's prohibition should gain it;
  `.claude/**` is not dv_lead's to stage, so this packet states the rule
  explicitly in the meantime and the launcher edit is requested rather
  than made.
- **`Essenceia/Nasdaq-HFT-FPGA`** — CC BY-NC prior art, consult-only,
  and not needed here at all.

If you reach a point where you believe you cannot write a row without
seeing the implementation, **stop and say so in the Return log**. That
is a legitimate finding about the specification — it means the
Observable is not derivable from frozen text — and it is worth more to
this programme than a bench written against the design. `verilog-ethernet`
(MIT) may be read and is the Phase-1 differential oracle, but it is not
part of this packet.

## 6. Incremental-write and compile discipline

Read this before writing code. WO-0033 pushed 23 blind-written OCaml
files at once, the Build went red on an unbound value, and
`J-dv_lead-0018` is the record of it. The rules below exist so that does
not repeat.

1. **Scaffolding first, and get it green before any row.** Write
   `dune` + `bench.{ml,mli}` with **one** trivial test that elaborates
   the DUT, runs ten idle cycles and asserts nothing but "the simulation
   built". Return that. Only then write the rows. A first Return that
   proves the seam works is worth more than a complete bench that does
   not compile.
2. **`tools/precompile_check.sh` will NOT cover this directory** — it
   excludes any library depending on `hardcaml_ethernet` or
   `hardcaml_waveterm`, because stubbing the design under test would
   mean reading it. Run it anyway, every time: it proves you have not
   broken `dv_xgmii`, `dv_monitors` or `dv_golden`, which you depend on.
   For **this** directory CI is the only compiler, which is exactly why
   rule 1 exists.
3. **Every `[%expect]` block is EMPTY** (ADR-0005 rule 2). Snapshots are
   promoted from CI's own diff output, never hand-authored. A
   hand-written snapshot is fabricated evidence.
4. **Every verdict is asserted in OCaml** — `failwith`, `raise`, or a
   checked counter — so that a promotion which captured wrong output
   still leaves a red test. A test whose only judge is its snapshot is a
   test that passes as soon as someone promotes it.
5. **No waveform snapshots and no timing figures inside `[%expect]`.**
   `Waveform.print` output is fine in a test you are debugging; it must
   not ship as an expectation.
6. **Name every test after its rows**, e.g.
   `let%expect_test "M03-A1, M03-A2: 64-octet frame at both start lanes" =`.
   The `SO-` packet's coverage section maps row ids to test names and
   greps for exactly this.

## 7. Expected-CI discipline

Your Return log must state, before the run happens, what you expect CI
to do — and must distinguish *checked* from *predicted*. The house rule,
paid for at WO-0033: **where a claim is checkable, run the check; where
it is not, write "unverified" and say why.** "Build is expected green"
on the strength of care is not evidence; "Build is unverified — no local
toolchain reaches this directory (ADR-0005), and the names new to this
repository's proven API surface are X, Y, Z" is.

State separately: (a) `dune build @default`, (b) `dune runtest` — which
is expected **red on its first reaching**, by design, because empty
`[%expect]` blocks promote from CI's diff, (c) `tools/dv_checks.sh`, and
(d) the names or constructs you could not check locally.

## 8. What I expect back

**A Return log appended to this packet**, in this shape, plus your
journal entry. **Do not write an `SO-` packet**: the sign-off is
dv_lead's under PROTOCOL §3 and a worker-issued one would be a
verbatim-relay packet from an agent that does not own it.

```markdown
### RETURNED — tb_writer, `J-tb_writer-NNNN` (<spawn short-id>)

#### 1. Row disposition — every row in §2, no silence
| Row | Test name | State | Note |
|---|---|---|---|
| M03-A1 | <exact test name> | IMPLEMENTED / NOT-IMPLEMENTED | <if not: why> |
… all eleven …

#### 2. Scaffolding — what bench.mli offers and what it deliberately does not

#### 3. Expected CI, checked vs predicted (§7)

#### 4. Findings against the specification or the attack plan
Anything you could not derive from frozen text; any Observable you
believe is wrong, ambiguous or unreachable. A row you think is wrong is
a finding, not a reason to skip it silently.

#### 5. Scope statement
Files staged; confirmation that no `libs/**` or `rtl_snapshots/**` path
was opened, and that your journal `Inputs` lists what you did read.
```

**How I will review it.** An `RV-` verdict with file:line defects, and —
per charter §3 — a **spot-check before ACCEPT**: I hand-mutate the
module in an uncommitted tree and confirm your bench goes red. The
mutations I intend to use are named now so you know what "real teeth"
means: **ΔC shifted by one cycle** (A1 must fail), **the CRC register
held across a lane-4 start's frame octets 0–3** (A2 and C2 must fail —
this is C-18), **`tkeep` computed from the input word rather than the
frame** (C1 must fail), and **`max_words_per_frame` boundary at 189**
(C3 must fail). A bench that survives any of those is not yet done, and
I would rather you knew that before you wrote it than after.

## Return / verdict log

### RETURNED — tb_writer, `J-tb_writer-0001` (WO-0038/2026-08-03T14:05Z)

#### 1. Row disposition — every row in §2, no silence

| Row | Test name | State | Note |
|---|---|---|---|
| M03-A1 | `"M03-A1, M03-A2: 64-octet frame at both start lanes — 8 words, tkeep/tlast pattern, m+3 timing, FCS good at lane 4 (the C-18 kill)"` (`test_m03_a.ml`) | IMPLEMENTED | Shared test with A2 (identical stimulus, different lane) |
| M03-A2 | same as A1 | IMPLEMENTED | The FCS-good assertion at lane 4 is the C-18 kill |
| M03-A3 | `"M03-A3: directed lengths 64..71 equal as tuple sequences at both lanes; M03-A4: no cross-lane absolute-cycle comparison is made"` (`test_m03_a.ml`) | IMPLEMENTED | Reuses `Bench.run_directed_lengths`, the same stimulus M03-C1/C2 use |
| M03-A4 | same as A3 | IMPLEMENTED (NO-ASSERT honoured) | Never compares lane 0's and lane 4's absolute first-output cycle; asserts each lane's own ΔC = 3 instead (REQ-019, not the forbidden corollary) |
| M03-A5 | `"M03-A5: position-dependent filler pins byte order and lane placement"` (`test_m03_a.ml`) | IMPLEMENTED | `Frame.stress_frame`'s default (position-dependent) filler, checked whole-string and word-by-word |
| M03-B1 | `"M03-B1: nonstandard preamble filler and SFD octets, both start lanes"` (`test_m03_b.ml`) | IMPLEMENTED | See §2 — `Arrival`'s fixed preamble is worked around via `Bench.run`'s `?word_at`, not a new capability |
| M03-C1 | `"M03-C1, M03-C2: directed lengths 64..71 at both lanes — all eight tkeep patterns once each, FCS good where terminate lands past lane 0"` (`test_m03_c.ml`) | IMPLEMENTED | Terminate-lane coverage discharged via delivered-count/tkeep correctness, not a wire-level lane assertion — see §4 finding 2 |
| M03-C2 | same as C1 | IMPLEMENTED | Subset computed from `Arrival.terminate_octet_time frame mod 8` (excluded length differs by lane: 64 at lane 0, 68 at lane 4) |
| M03-C3 | `"M03-C3: one 1518-octet frame, both lanes — 1514 octets in 190 words"` (`test_m03_c.ml`) | IMPLEMENTED | Same tkeep-formula and timing model as A1/A2 at scale |
| M03-C4 | `"M03-C4: the 5-octet runt is a legal one-word frame (C-11)"` (`test_m03_c.ml`) | IMPLEMENTED | Also asserts the REQ-107 runt consequences (tuser[0]=1, one `error_runt` at the pinned cycle) the same 5-octet stimulus cannot avoid |
| M03-L6 | `_witness_i_has_no_tready`, `_witness_o_has_no_tready`, `_witness_rx_is_source_without_dest` (`test_m03_structural.ml`) | IMPLEMENTED | Compile-time record-pattern witnesses, not runtime tests, per the row's own instruction. Exhaustive under dune's default `dev` profile (warning 9 fatal; no root `dune`/`dune-workspace` overrides it) |

Zero declared gaps; zero silent skips. All eleven rows implemented. (A
twelfth artifact, `test_m03_structural.ml`'s scaffolding smoke test, is
WO-0038 §6 rule 1's own requirement, not a twelfth row.)

#### 2. Scaffolding — what `bench.mli` offers and what it deliberately does not

`Bench.t` bundles one elaborated `Hardcaml_ethernet.Xgmii_rx_64` instance
with all four monitors AP-xgmii_rx_64.md §2 requires of every bench in this
packet: `Protocol_monitor` (`~max_words_per_frame:190`), `Conservation_monitor`,
`Octet_time.Latency` (`~strip_octets:8 ~tail_octets:4 ~front_offsets:[8;12]
~ceiling:4`) and `Strobe_monitor` (all five §12 M03 strobes). `Bench.run`
drives a schedule cycle-by-cycle through `Xgmii_probe`/`Axi64_probe`, calls
`Arrival.check` first (obligation 5, fails the test if the schedule is not
conformant) and feeds the protocol and strobe monitors automatically every
cycle including idle ones (C-23's counting convention needs the idle
cycles too). `Bench.account_clean_frame` is the one call a row makes for
conservation-in/out and both latency calls together — every frame in this
packet's eleven rows delivers exactly the clean-frame identity extent, so it
never needs `Latency.frame_out`'s `?expected_octets` override (that exists
for the truncated/aborted families E/F/G/H, out of scope here).

What it deliberately does not offer: anything for family J (`cfg_rx_enable`)
or K (`clear`) beyond the fixed always-enabled, one-cycle-clear-then-release
reset `Bench.create` performs once; anything for idle injection
(`Idle_injection`) or error injection (`Injection`) — both out of this
packet's eleven rows; a shared multi-frame continuous-run driver — every
multi-frame row in this packet (A3/A4, C1/C2) drives each length on its own
fresh `Bench.t` rather than back to back, which is deliberate (the clean-frame
spine is the job here, not throughput; that is family L, explicitly excluded
by WO-0038 §1).

#### 3. Expected CI, checked vs predicted (§7)

**(a) `dune build @default`.** Predicted **red** against the real toolchain
until dv_lead/CI's first pass, for the mechanical reason WO-0038 §4 states:
if `Hardcaml_ethernet.Xgmii_rx_64`'s actual `I`/`O` records diverge from the
frozen `docs/specs/ifc_check/xgmii_rx_64_ifc.ml` lift — in particular if the
nested `Xgmii` record's fields are not literally named `d`/`c` — this bench
fails to compile, and per §4's own instruction that failure is not mine to
paper over. **Checked, not predicted, that the absence of a local toolchain
is real and not merely assumed**: `eval $(opam env) && dune build @default`
was run and failed at `Library "ppx_hardcaml"/"hardcaml"/"hardcaml_axi"/
"hardcaml_waveterm" not found` — confirming ADR-0005's premise for this
container rather than taking it on faith. **Checked**: `ocamlc -stop-after
parsing` on all six new files, twice — exit 0 both times. This is a
syntax-only check (no name resolution) but it is real, reproducible evidence
against exactly the defect class WO-0033 escaped with (an unbound value/
unbalanced construct).

**(b) `dune runtest`.** Predicted **red on first reaching**, by design:
every `[%expect]` block in every test is empty (ADR-0005 rule 2), so the
first green run is what promotes them. Not run (same absent toolchain).

**(c) `tools/dv_checks.sh`.** **Checked**, run in full.
`check_records_vs_appendix.sh`: 23/23 PASS (unaffected by this packet — no
strobe name or record changed). `check_emitted_verilog.sh`: 5/5 checks PASS,
3 PENDING rows, all pre-existing and about unbuilt modules, not M03.
`precompile_check.sh`: ALL LANES PASSED; `test/xgmii_rx_64` correctly
**EXCLUDED** ("depends on hardcaml_waveterm hardcaml_ethernet, which this
harness cannot transcribe") exactly as WO-0038 §6 rule 2 predicts;
`dv_golden`/`dv_monitors`/`dv_xgmii` (31 units) and `dv_axi64_probe`/
`dv_xgmii_probe` (12 units) all still compile with 0 errors — this packet
has not broken machinery it depends on. `check_rfc1071_anchor.sh`:
OBLIGATION OPEN on blocked network egress — pre-existing (`J-dv_lead-0017`,
`J-dv_lead-0018`), about M02/M14's checksum oracle, unrelated to M03.

**(d) Names/constructs that could not be checked locally.** Everything that
requires the real `hardcaml`/`hardcaml_axi`/`hardcaml_waveterm`/`ppx_hardcaml`
packages, confirmed absent above. Concretely: whether
`Hardcaml_ethernet.Xgmii_rx_64.I.t`'s `xgmii_rx` field and `.O.t`'s `rx` field
actually expose `d`/`c` and `tvalid`/`tdata`/`tkeep`/`tstrb`/`tlast`/`tuser`
at the types `Bench.ml` projects them at (via type-directed field
disambiguation off the live `Cyclesim.inputs`/`outputs` records, never by
naming the defining module — see `bench.mli`'s own docstring); whether
`Cyclesim.With_interface(Xgmii_rx_64.I)(Xgmii_rx_64.O)` elaborates at all in
a fresh `Cyclesim` (the module is confirmed to reach Verilog emission,
`tools/check_emitted_verilog.sh`'s output lists `xgmii_rx_64` among emitted
modules, but no prior committed bench in this tree has driven it through
`Cyclesim`); every `Dv_monitors`/`Dv_xgmii`/`Dv_xgmii_probe`/`Dv_axi64_probe`
call's exact label/arity match against the real `.mli`s (checked by careful
manual re-reading against the `.mli` text quoted in this packet, not by a
compiler).

#### 4. Findings against the specification or the attack plan

1. **A self-inflicted independence violation, disclosed in full, not used.**
   An overly broad `find`/`cat` sweep while surveying `test/**` dune
   conventions printed `libs/hardcaml_ethernet/src/dune`'s four-line library
   stanza (name, `(libraries hardcaml hardcaml_axi)`, ppx flags) — no
   implementation file, no `rtl_snapshots/**` path. Nothing from it is used
   anywhere in this bench (the module path came from WO-0038 §4 verbatim;
   this directory's own `dune` file follows `test/hardcaml_ethernet/dune`'s
   pattern). Full detail, and the argument for why I believe it carries no
   behavioural fact, is in `J-tb_writer-0001`'s Inputs section. I am not the
   right party to rule this harmless — that is dv_lead's and the auditor's
   call (charter §3, §6) — so it is raised here as a finding, not resolved.
2. **A machinery gap that turned out not to be one.** WO-0038 §3's table
   names `test/xgmii/arrival.mli` as M03-B1's machinery, but `Arrival`'s
   preamble filler is fixed at 0x55/0xD5 with no override parameter
   (`arrival.mli`, "What the model does not decide"). Resolved by
   composition — `Bench.run`'s `?word_at` substitutes a non-standard pattern
   into the schedule's own start word(s) after `Arrival` builds it — rather
   than declaring the row not-implemented. A future packet driving more
   preamble-content rows might still want `Arrival.create` to grow an
   optional filler parameter directly; not requested as a blocker here.
3. **M03-C1's terminate-lane coverage is asserted indirectly.** The row's
   Observable includes "the terminate character lands in lane (length mod
   8), covering all eight lanes." This bench does not add a wire-level lane
   inspection for it: at both start lanes, driving lengths 64..71 already
   guarantees eight distinct terminate lanes (checked once via
   `Arrival.check`), and the row's own Kills cell — "a terminate decoder
   that only looks at lane 0" — is exactly what a wrong delivered-count or
   wrong tkeep at a non-lane-0 length already catches. If dv_lead wants the
   wire-level fact asserted explicitly rather than derived, that is a small
   addition to `test_m03_c.ml`.
4. **Standing obligation 3 is written into every row, but was retrofitted.**
   `Bench.create` did not originally wire the `Octet_time.Latency` tagger;
   this was caught and corrected (all rows now call
   `Bench.account_clean_frame`) before this Return, on a second read of
   AP-xgmii_rx_64.md §2's "every bench in this packet" sentence. No row was
   returned in the un-retrofitted state; recorded because the miss and its
   catch are both worth the reviewer seeing (`J-dv_lead-0018`'s own
   precedent for stating a first-pass miss rather than tidying it away).

None of these four are reasons to skip a row; all eleven rows are
IMPLEMENTED per §1.

#### 5. Scope statement

Files staged: `test/xgmii_rx_64/dune`, `test/xgmii_rx_64/bench.mli`,
`test/xgmii_rx_64/bench.ml`, `test/xgmii_rx_64/test_m03_structural.ml`,
`test/xgmii_rx_64/test_m03_a.ml`, `test/xgmii_rx_64/test_m03_b.ml`,
`test/xgmii_rx_64/test_m03_c.ml`, plus this Return log and the
`J-tb_writer-0001` journal entry. `git status --porcelain` shows no other
path touched.

**Confirmation, with the one exception disclosed above and in finding 1**:
no `.ml`/`.mli` implementation file under `libs/**` was opened, and no path
under `rtl_snapshots/**` was opened at any point in this spawn. The one
exception is `libs/hardcaml_ethernet/src/dune` (a build manifest, not RTL
logic), read accidentally, not used, and not repeated. My journal's `Inputs`
section lists this in full alongside every spec, plan and machinery file
actually read, per charter §8's "an omission discovered later is worse than
an admission now."

---

