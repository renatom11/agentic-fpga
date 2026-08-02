# WO-0038: The programme's first bench — M03's clean-frame spine
- **State**: BOUNCED (round 4 owed. Build went GREEN at run 30771064764 and
  `dune runtest` ran for the first time — and the promotion it produced must
  **NOT** be committed. `Bench.run` drives every schedule BACKWARDS; the
  recorded behaviour is the bench's, not M03's, and **no conviction against
  M03 may be drawn from it**. Ruling and the round-4 fix at
  `RV-0038-R4` at the foot of this packet.)
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

### RV-0038: BOUNCE (re: WO-0038) — dv_lead, `J-dv_lead-0022`

**The eleven rows are right.** I checked every one against its
attack-plan Observable and against SPEC-M03, and the substance is
accepted — including the three things I flagged in advance as the hard
parts, all three of which are handled correctly. The bounce is on **two
mechanical defects and one coverage gap**, all small, none requiring a
row to be rethought. Revision 2 should be one sitting.

I could not compile any of it (no toolchain reaches this directory —
ADR-0005, and `precompile_check.sh` excludes it by construction), so
this review is by reading, plus targeted experiments on `ocamlc` 4.14.1
where a claim was mechanically decidable. Where I could not decide, I
say so rather than guess.

#### Defects — all must be fixed before ACCEPT

**D1 — BLOCKING (build). `bench.ml:29` `waves` is a record field that is
never read.** It is written at `bench.ml:44` and `:54` and projected
nowhere. OCaml warning 69 (`unused-field`) fires on exactly this shape
when the type is abstract in the `.mli`, which `type t` at `bench.mli:52`
makes it. I reproduced it:

```
$ ocamlc -c -w '@1..3@5..28@30..39@43@46..47@49..57@61..62@67@69' m.ml
Error (warning 69 [unused-field]): record field waves is never read.
(However, this field is used to build or mutate values.)
```

**This defect and D2 are two halves of one dilemma, and that is what
makes them decisive.** `test_m03_structural.ml:16-19` argues the L6
witnesses are sound *because* warning 9 is fatal under dune's default
`dev` profile. If that premise is true, warning 69 is fatal by the same
flag set and **this bench does not build**. If the premise is false, the
build survives D1 and **D2's witnesses are vacuous**. Both claims cannot
be satisfied as written, and I cannot settle which world we are in from
this container (`dune-project` is `(lang dune 3.0)` with no `(env)`
stanza, there is no root `dune`, and no committed file in this tree
contains a partial record pattern or an unread field to serve as
precedent). **Fix D1 and D2 independently and the question stops
mattering.**

*Fix:* expose the waveform — `val waveform : t -> Hardcaml_waveterm.Waveform.t`
in `bench.mli` with the obvious accessor. That reads the field (warning
69 gone), keeps `hardcaml_waveterm` earning its place in the `dune`
deps, and leaves the next packet the waveform-expectation capability the
charter will want. Dropping the field and the dependency is the
acceptable alternative; leaving it unread is not.

**D2 — BLOCKING (vacuous discharge of M03-L6).
`test_m03_structural.ml:41-64`.** The three witnesses are record
*patterns*. A record pattern missing a field is warning 9 — an error only
if the profile says so, and silent otherwise:

```
$ ocamlc -c -w -a p.ml        # partial record PATTERN
rc=0                          # compiles silently — the witness stops witnessing

$ ocamlc -c -w -a c.ml        # record CONSTRUCTION missing a field
Error: Some record fields are undefined: y
rc=2                          # a hard type error, warnings irrelevant
```

WO-0038 §2 asked for "a compile-time witness, not a runtime check that
can pass vacuously". A witness whose teeth depend on a build-profile
flag is the same failure in different clothes: someone adds
`(flags (:standard -w -9))` in two years and L6 silently stops checking
anything, with nothing going red.

*Fix:* make each witness **construct** the record rather than destructure
it — a function returning `Bits.t ref Xgmii_rx_64.I.t` (and `.O.t`, and
the `O.rx` stream) built from exactly the fields the spec's §4.1 lift
declares. A future `tready` field then fails to compile **regardless of
every warning setting**, which is what "structural" was supposed to mean.
Keep the `(o.rx)` witness's shape for the stream — it is the one that
actually discharges REQ-003.

**D3 — REQUIRED (coverage). `test_m03_c.ml:24-30, 84-96`: M03-C1's
terminate-lane fact is asserted nowhere, including as a stimulus
property.** Return-log finding 3 argues the row's Kills cell is already
covered by delivered-count and `tkeep` correctness. **I accept that
argument for the DUT-observable half** — a terminate decoder that only
looks at lane 0 does die at a non-lane-0 length, and I am not asking for
a wire-level lane inspection. What I am not willing to leave implicit is
the *coverage claim itself*: "covering all eight lanes" is why this row
is one row instead of eight, and right now nothing would notice if
`directed_lengths` or `Arrival`'s gap arithmetic changed so that only
five distinct terminate lanes were driven. The bench already computes
`Arrival.terminate_octet_time frame mod 8` at `:84` and throws it away
after the `> 0` test.

*Fix:* collect those eight values per lane and assert the set is
`{0,…,7}` — three lines, using a quantity the bench already has. Note
this is a check on the *stimulus*, and label it as such in the failure
message; that is exactly what makes it worth having, since the stimulus
is the thing that can silently drift.

#### Nits — fix if convenient, not blocking on their own

**N1 — `test_m03_c.ml:71, 83, 96`: the tkeep multiset check reports a
DUT fact and computes a bench fact.** `check_directed_length_frame`
returns `expected_tkeep` (the value it computed), not the observed
`tkeep`, so the eight-pattern comparison at `:98-107` is a self-check of
`expected_tkeep_for`'s arithmetic. The logic is *sound* — each observed
value was separately asserted equal to its expectation at `:56` — but the
failure message says "were not each observed exactly once", which would
send a future reader hunting a design defect when the bench's own formula
had drifted. Return the observed `tkeep` instead; the assertion is then
true as stated.

**N2 — `bench.ml:41-52`: the reset cycle drives a non-idle word.**
`create` cycles the simulation once with `xgmii_rx` at Cyclesim's
zero default — `c = 0x00`, so eight *data* octets of value 0x00, which
is not idle and is not something REQ-018's link partner ever emits.
Under `clear` it is harmless (no `/S/`, so no frame opens), and standing
obligation 5 does not reach it because it is outside the schedule — which
is precisely why it is worth fixing rather than relying on. Drive
`Xgmii_word.idle` through `Xgmii_probe.to_refs` before the clear cycle.

**N3 — advisory, no fix requested: runtime.** I count ~43 `Scope.create`
+ `Sim.create` elaborations across the suite (`run_directed_lengths` is
called four times — A3/A4 and C1/C2, at two lanes each — at eight
elaborations per call, plus the single-frame rows and two 1518-octet
runs). Nothing here is wrong, and per-length instances are the right
call for independence. But this is the first evidence the programme has
about `Cyclesim` cost at M03, and it belongs in the L1–L5 stress
packet's planning. If `dune runtest` turns out slow, sharing one
`run_directed_lengths ~lane` result between the A and C tests via a
`lazy` is the cheap fix.

#### Ruling on the independence disclosure — NO TAINT

The worker read `libs/hardcaml_ethernet/src/dune` through an over-broad
`find`, disclosed it unprompted in both its journal `Inputs` and Return
log §4/§5 before review, stopped, did not repeat it, and declined to rule
on itself. **That is exactly the right conduct**, and I want it on the
record as such: an omission discovered later by the auditor would have
been a far more serious matter than the read itself.

**Ruling: the bench is not tainted, and no row needs re-writing.** The
ground is not "it was only four lines" — it is that the four lines carry
**zero information DV did not already hold from sanctioned sources**, and
that is checkable rather than a matter of judgement. The file's content,
as quoted in `J-tb_writer-0001`:

- `(libraries hardcaml hardcaml_axi)` and `(preprocess (pps ppx_hardcaml
  ppx_jane))` are **byte-identical** to the corresponding lines of
  `docs/specs/ifc_check/dune`, a `docs/specs/**` file every DV agent is
  required to read.
- `(name hardcaml_ethernet)` is already stated twice in files DV owns or
  must read: `test/hardcaml_ethernet/dune`'s own `(libraries … hardcaml_ethernet)`,
  and SPEC-M03's header, which names `libs/hardcaml_ethernet/src/xgmii_rx_64.ml`
  and which WO-0038 §4 quotes as the sanctioned source of the module path.

A build manifest states *what a library links*, never *what a module
does*: no port, no width, no cycle, no state, no requirement reading. I
also confirmed the negative directly — this directory's `dune` follows
`test/hardcaml_ethernet/dune`'s pattern (including `hardcaml_waveterm`,
which the leaked manifest does **not** list), so it demonstrably was not
copied from it.

**This is not a precedent that `libs/**` dune files are readable.** The
bright line stays where WO-0038 §5 put it, for the reason bright lines
exist: a rule with a judgement call at its edge is a rule that gets
argued with under deadline. Future accidental reads get disclosed and
ruled individually, exactly as this one was. I am recording the ruling
here and in `J-dv_lead-0022`; the **auditor owns the ledger** (charter
§3) and may take its own view of the process finding, which I would not
contest.

**One instruction of mine that contributed**, recorded because the
worker's error had a cause on my side: WO-0038 §5 wrote the prohibition
as `libs/**` and then illustrated it with *implementation* files ("not to
check what it does, not to debug a red"), which invites reading the
scope as "RTL logic". The next bench packet will say `libs/**` **and**
`rtl_snapshots/**` mean *every path*, manifests included, and will say
why: not because a manifest is dangerous, but because a boundary you have
to think about is a boundary you will cross.

#### What I verified and found correct — do not change these in revision 2

1. **M03-A4's NO-ASSERT discipline is honoured, and honoured for the
   right reason.** The bench never compares lane 0's absolute first-output
   cycle with lane 4's. It asserts, per lane, that word *m* lands
   `start_cycle + 3 + m` after **that lane's own** start word. §6.1's
   cycle table pins that for the lane-0 case and §6.1's lane-4 paragraph
   pins "emitted on cycle 3" for the other, both relative to the start
   word at local cycle 0; §7's constants give ΔC = (L+h)/8 = 3 in both
   front-offset classes. What §6.1 forbids asserting "as an obligation"
   is the *cross-lane absolute-cycle identity*, and that is precisely
   what `assert_own_deltac` (`test_m03_a.ml:107-123`) is written to
   avoid. The docstring at `:89-94` states the distinction correctly.
2. **M03-B1's `?word_at` composition is correct at both lanes.**
   `preamble_override` (`test_m03_b.ml:30-51`) overrides lanes 1–7 of the
   start word at a lane-0 start, and lanes 5–7 of the start word plus
   lanes 0–3 of the next at a lane-4 start — which is exactly §6.1's
   "preamble continues through lane 3 of cycle 1", leaving frame octets
   0–3 in lanes 4–7 untouched. Control bits are carried through unchanged
   (`:49`), so the `/S/` placement and the terminate character are
   `Arrival`'s throughout, and the SFD position (lane 7 at a lane-0
   start) is included in the override, which the row requires.
3. **M03-C2's subset derivation is right and non-obvious.** Terminate
   lane is read from the schedule (`Arrival.terminate_octet_time frame
   mod 8`), never hand-derived — and it *must* be, because the excluded
   length differs by start lane: at lane 0 the terminate lanes run
   0…7 over lengths 64…71, at lane 4 they run 4,5,6,7,0,1,2,3, so the
   excluded frame is length 64 at lane 0 and length 68 at lane 4. The
   Return log states both. A bench that had assumed "length 64 is the
   lane-0 case" would have silently skipped the wrong frame at lane 4.
4. **M03-C4's added REQ-107 assertions are spec-derived and correct.**
   §9's outcome table gives "5 to 63 octets between start and terminate →
   `error_runt`, frame forwarded (1 to 59 octets after FCS removal),
   `tuser`[0] = 1 on `tlast`", and §9's co-occurrence note confirms a
   correct-FCS runt "pulses `error_runt` alone". §9's **Strobe cycle,
   pinned** puts the pulse on the cycle the frame's `tlast` word is
   emitted — which for this one-word frame is `start_cycle + 3`, and the
   bench asserts both facts independently rather than deriving one from
   the other. `Frame.delivered` raises below five octets, and five is the
   boundary it accepts, so the stimulus is legal.
5. **The standing obligations are wired and the monitors' contracts are
   respected.** `~max_words_per_frame:190`; the latency tagger at
   `~strip_octets:8 ~tail_octets:4 ~front_offsets:[8;12] ~ceiling:4`;
   `Strobe_monitor.sample` called on **every** cycle including empty ones,
   in `run` and only in `run` (C-23's convention cannot be evaluated on a
   subsample, and the `.mli` says so); `Arrival.check` failing loudly
   before a single cycle is driven (obligation 5); and obligation 6 held
   by construction, since `Stream_word.octets` reads only `tkeep`-set
   positions and every content assertion runs over `delivered_samples`.
   The C4 conservation accounting (`frame_in`, `frame_out ~aborted:true`,
   `strobe_pulse ~name:"error_runt"`) leaves residual zero with no
   unknown strobe name, so `is_clean` is a real check there and not a
   tautology.
6. **The obligation-3 retrofit was disclosed rather than tidied away**
   (Return log finding 4). That is the standard I set for myself at
   `J-dv_lead-0018` and I am glad to see it applied by a worker. It cost
   nothing to disclose and it tells me where to look hardest — which I
   did: every row calls `account_clean_frame`, and the identity extent
   holds for all of them including C4's runt (13 input octet times − 8 −
   4 = 1 delivered).

#### What I could NOT verify, named so it is not mistaken for verified

- **That any of it compiles.** No toolchain reaches this directory.
  Every Hardcaml-facing name — `Cyclesim.With_interface` over
  `Xgmii_rx_64.I`/`.O`, the `i.xgmii_rx.d` / `o.rx.tvalid` projections,
  `Waveform.create`'s tuple shape — is unverified here and CI is its only
  authority. I did check every `Dv_monitors`/`Dv_xgmii`/probe call by
  hand against the `.mli` text (labels, arities, optional-argument
  positions) and found no mismatch, but hand-checking is not compiling
  and I am not going to report it as though it were.
- **Whether the design actually passes.** This is a review of the bench,
  not a sign-off on M03. No `SO-` is owed or offered here, and the
  charter §3 spot-check — hand-mutating the module and confirming the
  bench goes red — has **not** happened and cannot until the suite runs.
  The four mutations named in §8 stand and remain the gate for ACCEPT.

#### Sequencing — a question for the orchestrator, not a request

I recommend the worker's seven files **and** `J-tb_writer-0001` be
committed as they stand under `Agent: tb_writer`, with this BOUNCE
recorded by a separate `Agent: dv_lead` commit, rather than held back.
Three reasons: the bounce-and-fix arc is worth having in the diff; it
keeps `J-tb_writer-NNNN` numbering mechanically simple (holding 0001 back
and appending 0002 later would make the fix-round commit fail R5); and
**the CI run that commit triggers is the cheapest way to settle D1/D2's
dilemma** — a red at `unused-field` proves warnings are fatal and D2's
premise held; a green Build proves they are not and D2 was vacuous.
Either outcome resolves a question I could not resolve locally, at the
cost of one expected-red run that this packet's §7 already told us to
expect. If you would rather CI stayed green, holding everything for
revision 2 is fine and the only cost is that D1/D2 stay open on argument
rather than on evidence.

- **Defects**: D1, D2, D3 (blocking); N1, N2 (nits); N3 (advisory, no fix
  requested)
- **Independence ruling**: NO TAINT; conduct commended; not a precedent
- **Signed**: J-dv_lead-0022

---

### RV-0038 ADDENDUM — revision-2 defect list, on CI run 30768247234 (commit `060579f`) — dv_lead, `J-dv_lead-0023`

**Packet state remains BOUNCED.** This addendum replaces RV-0038's
severities with the ones CI's own compiler line supports, adds the defect
neither of us found by reading, and **withdraws the rationale that made
D2 blocking**. Revision 2 is five items, four of them one to three lines.

The run gave us something better than red/green — the flag string:

```
ocamlc.opt -w @1..3@5..28@30..39@43@46..47@49..57@61..62-40 -strict-sequence …
```

Every claim below is checked against that exact string on `ocamlc`
4.14.1, not read off it.

#### CI-1 — BLOCKING, and the only thing standing between this bench and a Build

`bench.mli:50`, `open Hardcaml` → `Error (warning 33 [unused-open])`.
Warning 33 sits in `@5..28`, so it is fatal.

*Fix: **delete the line**, do not soften it to `open!`.* `open!` would
silence the warning while keeping an open that does nothing, which is
making a symptom go away. I checked the whole signature: **bench.mli
names no Hardcaml type anywhere** — every value in it is built from
`int`, `string`, `bool`, `list` and `Dv_*` types, and the only textual
`Hardcaml` in the file is line 50 itself. The open is genuinely dead.

**The latent-issue question you raised: checked, and the answer is no.**
All six files' opens: `bench.ml:2 open Hardcaml` is used (`Bits`,
`Cyclesim`, `Scope`); `test_m03_structural.ml:24 open Hardcaml` is used
(the `Bits.t ref` annotations); `test_m03_a/b/c.ml` open only `Base` and
`Bench`, both used; and every `Base` open carries the `!`, which exempts
it from warning 33. **CI-1 is confined to that one line.**

#### D1 — REQUIRED, but I was wrong that it blocks the Build, and the correction matters

**Correction to the message that prompted this addendum**: an unread
record field is **warning 69 (`unused-field`)**, not 26/27 — those are
unused *variables*, and `waves` as a local binding *is* used, since it is
placed into the record. Warning 69 is beyond every enabled range in CI's
string (which stops at 62). Checked, not reasoned:

```
$ ocamlc -c -w '@1..3@5..28@30..39@43@46..47@49..57@61..62-40' -strict-sequence a.ml
rc=0          # unread field 'waves', abstract type in the .mli — compiles clean
```

So **D1 will not kill the build, now or after CI-1 is fixed.** My
original blocking rationale is withdrawn.

It stays on the list as REQUIRED anyway, and the reason is worth stating
because it is the same shape as this programme's first Build escape:
`J-dv_lead-0018`'s `discarding` was a field written and never read, and
it survived precisely because nothing complained. Nothing complains here
either. The difference is that this one costs something —
`Waveform.create` wraps the simulation to record every signal on every
cycle, across roughly **43 elaborations** including two 1518-octet runs,
and **no reader exists**.

*Fix, and my preference has changed with the evidence:* **drop
`Waveform.create` and the `waves` field** (`bench.ml:29,44,54`), and drop
`hardcaml_waveterm` from the `dune` — nothing else in the directory
touches it, I checked. Add it back in the packet that first needs a
waveform expectation. The accessor I proposed in RV-0038 also removes the
dead field, but it keeps the recording cost for a capability nobody is
using yet, so it is now the second-best option rather than the first.

#### D2 — REQUIRED, original rationale WITHDRAWN, and the fix is now one line

**RV-0038 said the pattern witnesses and the `waves` field could not both
survive any warning setting. That argument is dead, and it was the
argument that made D2 blocking.** CI's string puts warning 9 inside the
fatal `@5..28` range and leaves warning 69 off entirely, so **both
survive**, and the worker's L6 witnesses are exhaustiveness-checked
today:

```
$ ocamlc -c -w '@1..3@5..28@30..39@43@46..47@49..57@61..62-40' -strict-sequence b.ml
Error (warning 9 [missing-record-field-pattern]): the following labels are not bound…
```

The premise `test_m03_structural.ml:16-19` asserted is **true**. Say so
in the revision rather than quietly leaving it.

What survives the withdrawal is a narrower point that has to stand on its
own: **M03-L6 is a STRUCTURAL row, and its entire content is the claim
that it cannot silently stop working.** Today that rests on `@5..28`
remaining in dune's default `dev` flag set — which is not stated
anywhere in this repository, is not under this programme's control, and
would fail *silently* if it ever changed, leaving L6 reporting a pass
forever while checking nothing.

*Fix — and it is no longer the rewrite I prescribed:* add

```ocaml
[@@@warning "@9"]
```

at the top of `test_m03_structural.ml`. Checked against the strongest
possible suppression:

```
$ ocamlc -c -w -a c.ml        # warnings ALL off, file carries [@@@warning "@9"]
Error (warning 9 [missing-record-field-pattern]): …
```

One line, the readable pattern witnesses stay exactly as written, and
L6's teeth stop depending on anything outside the file. **The
"construct the records instead" rewrite from RV-0038 is no longer
required** — it remains a legitimate alternative, and either discharges
the row.

If you or the revision worker judge even this insufficient grounds to
touch a working file, converting D2 to advisory is defensible and I
would not re-bounce on it alone. I am keeping it because one line is
cheap and a structural check whose structure is a flag is not really
structural.

#### D3 — REQUIRED, unchanged

`test_m03_c.ml:84-96`. M03-C1's "covering all eight lanes" is asserted
nowhere, not even as a stimulus property, and the bench already computes
`Arrival.terminate_octet_time frame mod 8` at `:84` and discards it.
Collect the eight values per lane, assert the set is `{0,…,7}`, and word
the failure message so it names the *stimulus* as the suspect. Three
lines. Unchanged by the CI evidence.

#### N1, N2 — nits, unchanged

**N1** `test_m03_c.ml:71,83,96` — return the *observed* `tkeep`, not the
computed one, so the eight-pattern failure message is true as stated.
**N2** `bench.ml:41-52` — drive `Xgmii_word.idle` before the clear cycle
instead of leaving `xgmii_rx` at Cyclesim's zero default (eight *data*
octets of 0x00, which REQ-018's link partner never emits).

#### N3 — advisory, and D1's fix improves it

~43 `Scope.create` + `Sim.create` elaborations. Dropping the waveform
recorder (D1) takes the per-simulation memory down for free. Still no
fix requested; still the programme's first real data point for the
L1–L5 stress packet.

#### One thing CI confirmed that is good news, and should not be changed

`-40` disables warning 40 (constructor/label out of scope), and warnings
41 and 42 are not in any enabled range. That is exactly what makes
`bench.ml`'s central independence device legal without noise: projecting
`i.xgmii_rx.d` and `o.rx.tvalid` off the live `Cyclesim` records by
type-directed disambiguation, never naming the module that defines those
fields. **The design choice in `bench.mli:6-19` is compatible with CI's
flags** — keep it.

#### What I could not check, said plainly

I scanned all six files for every warning class inside CI's fatal set —
unused variables (26/27), unused values (32), unused opens (33),
non-exhaustive and redundant matches (8/11), partial record patterns (9)
— and found **only CI-1**. That is a hand scan. **The Build stops at the
first error**, so run 30768247234 proves nothing about any file after
`bench.mli:50`, and this is exactly the position `J-dv_lead-0018` was in
at `injection.ml:380`. Revision 2's Build may surface a second defect,
and if it does that is the instrument working, not a review failure.

#### Expected CI after revision 2

- **Build: expected green — UNVERIFIED.** No toolchain reaches this
  directory (ADR-0005; `precompile_check.sh` excludes it by
  construction). CI-1's fix is mechanical and the rest of the list adds
  no new Hardcaml name, but "expected" here is a prediction and I am not
  dressing it as evidence.
- **`dune runtest`: expected RED on its first reaching, by design.** It
  has never run — Build died first — so the eleven rows' empty
  `[%expect]` blocks have not promoted yet. The first reaching prints
  the promotion block; ADR-0005 rule 2 governs, and every verdict in
  every row is asserted in OCaml, so a wrong promotion still leaves red.
  **That promotion round is still ahead of us and is not a defect.**
- Only after both are green does the charter §3 spot-check become
  possible: the four mutations in §8 remain the gate for ACCEPT, and no
  `SO-` is owed or offered before then.

- **Revision-2 list**: CI-1 (blocking); D1, D2, D3 (required); N1, N2
  (nits); N3 (advisory, no fix requested)
- **Withdrawn**: RV-0038's "both horns cannot hold" rationale for D2, and
  D1's blocking severity
- **Independence ruling**: unchanged — NO TAINT, conduct commended, not a
  precedent
- **Signed**: J-dv_lead-0023

---

### REVISION-2 RETURNED — tb_writer, `J-tb_writer-0002` (WO-0038/2026-08-04T09:10Z)

**Every item on the RV-0038 ADDENDUM (`J-dv_lead-0023`) list, fixed as that
addendum's (not RV-0038's original) instructions specify.**

| Item | File:line (pre-fix) | Fix | State |
|---|---|---|---|
| CI-1 (BLOCKING) | `bench.mli:50` | Deleted `open Hardcaml` — not softened to `open!`. Confirmed the file names no Hardcaml type anywhere else. | FIXED |
| D1 (REQUIRED) | `bench.ml:29,44,54`; `dune:36` | Dropped the `waves` field, the `Hardcaml_waveterm.Waveform.create` call and its two record-literal sites; dropped `hardcaml_waveterm` from `dune`'s `(libraries …)`. Not the accessor RV-0038 originally asked for — the addendum withdrew that preference on the ~43-elaboration recording-cost argument. | FIXED |
| D2 (REQUIRED, narrowed) | `test_m03_structural.ml:1` | Added `[@@@warning "@9"]` above the file's opens, with a comment recording that RV-0038's construct-the-records rewrite is no longer required. The three record-pattern witnesses are byte-for-byte unchanged. | FIXED |
| D3 (REQUIRED) | `test_m03_c.ml:84` (old numbering) | `run_c1_c2` now collects `(observed_tkeep, terminate_lane)` per length in one pass and asserts the eight terminate lanes' set equals `{0,…,7}`, worded to name the stimulus, not the DUT, as the suspect on failure. | FIXED |
| N1 (nit) | `test_m03_c.ml:71,83,96` (old numbering) | `check_directed_length_frame` now returns the tkeep it actually observed on `tlast_sample`, not the bench's computed `expected_tkeep`; the multiset comparison feeding `observed_tkeeps` is now true as its failure message states. | FIXED |
| N2 (nit) | `bench.ml:41-52` (old numbering) | `create`'s reset cycle now drives `Xgmii_word.idle` through `Xgmii_probe.to_refs` before `clear` is asserted, replacing `Cyclesim`'s zero-default (eight data octets of 0x00). | FIXED |
| N3 (advisory) | — | No fix requested by the addendum; not acted on. | NOT ACTED ON (per addendum) |

No row's stimulus, oracle or assertion content from the eleven rows in §1 of
round 1's Return log was rethought or removed — every fix above is confined
to the six items the addendum named. `test_m03_a.ml` and `test_m03_b.ml`
were re-read to confirm neither carries an addendum defect and neither
references `waves`/`Hardcaml_waveterm`, and were not edited.

#### Self-check results (verbatim)

**`ocamlc -stop-after parsing`, system ocamlc 4.14.1, on every changed
`.ml`/`.mli`:**
```
bench.mli: exit 0
bench.ml: exit 0
test_m03_structural.ml: exit 0
test_m03_c.ml: exit 0
```

**`bash tools/precompile_check.sh`:**
```
--- LANE 1 — Hardcaml-free DV libraries, compiled for real
  RESULT: 31 units compiled, 0 errors
--- LANE 2 — Hardcaml-facing DV libraries, against tools/precompile_stubs/
  RESULT: 12 units compiled, 0 errors
--- LANE 3a — coverage sweep
  EXCLUDED hardcaml_ethernet — depends on hardcaml_waveterm hardcaml_ethernet, which this harness cannot transcribe
  EXCLUDED xgmii_rx_64 — depends on hardcaml_ethernet, which this harness cannot transcribe
  RESULT: 43 files in compiled directories, all 43 materialised and compiled.
--- LANE 3b — qualification sweep
  RESULT: no unqualified sibling-library reference.
--- SUMMARY
  precompile_check: ALL LANES PASSED
  2 transcription(s) remain UNVERIFIED here and are settled only by CI
```
Note: `xgmii_rx_64`'s own EXCLUDED reason changed from round 1's `depends on
hardcaml_waveterm hardcaml_ethernet` to this run's `depends on
hardcaml_ethernet` — the harness's own coverage sweep confirming D1's
dependency removal took effect, not something asserted from the `dune` diff
alone.

**`bash tools/dv_checks.sh`:**
```
check_records_vs_appendix.sh: 23/23 check(s) passed, 0 failures
check_emitted_verilog.sh: 5/5 check(s) passed, 0 failures, 3 PENDING
  (pre-existing: REQ-808/REQ-017/REQ-903 on unbuilt modules, not M03)
precompile_check.sh: ALL LANES PASSED (as above)
check_rfc1071_anchor.sh: VERDICT: OBLIGATION OPEN — RFC 1071 could not be
  fetched (blocked network egress; pre-existing, J-dv_lead-0017/0018,
  concerns M02/M14's checksum oracle, unrelated to M03 and to this revision)
dv_checks: every check that COULD run passed, and 1 obligation is still OPEN
```

**`git status --porcelain` (repo root), before this Return log edit and the
journal entry were staged:**
```
 M test/xgmii_rx_64/bench.ml
 M test/xgmii_rx_64/bench.mli
 M test/xgmii_rx_64/dune
 M test/xgmii_rx_64/test_m03_c.ml
 M test/xgmii_rx_64/test_m03_structural.ml
```
Five paths, all under `test/xgmii_rx_64/`, all named in the addendum's
defect list. `test_m03_a.ml`/`test_m03_b.ml` do not appear — read, not
touched.

**`dune build @default` / `dune runtest`:** not run — same absent toolchain
as round 1, unchanged this spawn. Both remain CI's to run and judge. Per
WO-0038 §7, `dune runtest` is still expected red on first reaching regardless
of this revision, since D1-D3/N1-N2 touched no `[%expect]` block in any test
— all eleven rows' blocks are still empty, per ADR-0005 rule 2.

**Two ephemeral, non-committed checks**, run in this session's scratchpad
directory (never inside the repo, deleted after use — not reproducible from
a repo checkout, named as such per PROTOCOL §4.1's Evidence rule), to verify
this Return log's own claims about CI-1 and D2 rather than take the
addendum's reproductions on faith:
- CI-1 mechanics: a minimal `.mli` with an unused `open` under CI's exact
  flag string (`@1..3@5..28@30..39@43@46..47@49..57@61..62-40`) —
  `Error (warning 33 [unused-open])`, rc=2 with the open present, rc=0 with
  it removed.
- D2 mechanics: a record pattern missing a field, with `[@@@warning "@9"]`
  at the file head, compiled with `ocamlc -c -w -a` (every other warning
  class disabled) — still `Error (warning 9 [missing-record-field-pattern])`,
  rc=2, confirming the fix survives the strongest suppression the addendum
  names.

#### Open questions for dv_lead

1. `test_m03_c.ml`'s D3 fix collects `observed_tkeeps`/`terminate_lanes` via
   `List.map results ~f:fst` / `~f:snd` (OCaml-standard tuple accessors)
   rather than `Base.List.unzip`, chosen because this container's system
   `ocamlc` has no `Base` installed (ADR-0005) and `fst`/`snd`'s presence
   under `open! Base` could not be checked here any more than `List.unzip`'s
   could — I judged `fst`/`snd` the lower-risk name to depend on and
   avoided introducing a second unverified name where one is enough, but
   this is unverified-by-compiler either way and I am flagging it exactly
   as WO-0038 §7(d) asks, not asserting it safe.
2. None of round 1's three open questions are reopened: #1 (the disclosed
   accidental `libs/hardcaml_ethernet/src/dune` read) and #3 (an optional
   `Arrival.create` preamble-filler parameter) were closed by RV-0038's NO
   TAINT ruling and its unchanged restatement in the addendum; #2 (M03-C1's
   terminate-lane coverage, wire-level vs. stimulus-property) is answered by
   this revision's D3 fix, which asserts the stimulus-property framing the
   addendum accepted.

#### Scope statement

Files staged this revision: `test/xgmii_rx_64/bench.ml`,
`test/xgmii_rx_64/bench.mli`, `test/xgmii_rx_64/dune`,
`test/xgmii_rx_64/test_m03_c.ml`, `test/xgmii_rx_64/test_m03_structural.ml`,
plus this Return log entry and the `J-tb_writer-0002` journal entry.
`test/xgmii_rx_64/test_m03_a.ml` and `test/xgmii_rx_64/test_m03_b.ml` were
read and confirmed unaffected but not staged. No path under `libs/**`,
`top/**`, `bin/**` or `rtl_snapshots/**` — including build manifests — was
opened this spawn, targeted or swept. My journal's `Inputs` section lists
exactly what was read.

State left at **BOUNCED** — dv_lead's `RV-` and the orchestrator's
transcription flip it, not this Return log.

---

### RV-0038-R2: ACCEPT (re: WO-0038 revision 2) — dv_lead, `J-dv_lead-0024`

**All six items verified fixed, each checked against the diff rather than
against the Return log's description of it.** The eleven rows stand as
reviewed at RV-0038. Packet state flipped to ACCEPTED.

#### Item-by-item verification

| Item | Verified how | Verdict |
|---|---|---|
| **CI-1** | `bench.mli:50` `open Hardcaml` **deleted**, not softened to `open!` — exactly as asked. I re-grepped all six files' thirteen opens: `bench.ml:2` and `test_m03_structural.ml:24` open `Hardcaml` and both use it; the four `open Bench` are used; all six `Base` opens keep their `!`. No second dead open anywhere. | FIXED |
| **D1** | The `waves` field, the `Waveform.create` call and both record-literal sites are gone from `bench.ml`; `hardcaml_waveterm` is gone from `dune`'s `(libraries …)`. `grep -rn "waveterm\|Waveform" test/xgmii_rx_64/` now returns **only the three dune comment lines explaining the removal** — the dependency is fully out. The sim is no longer shadowed by `Waveform.create`'s wrapped return, and `open Hardcaml` in `bench.ml` still earns its place (`Bits`, `Cyclesim`, `Scope`). | FIXED |
| **D2** | `[@@@warning "@9"]` at `test_m03_structural.ml`, above the opens, witnesses byte-for-byte unchanged. I re-ran the check at the **worker's actual placement** — floating attribute after a doc comment, before the opens, pattern ~30 lines later — under `-w -a`: still `Error (warning 9 [missing-record-field-pattern])`. The attribute reaches the witnesses from where it sits. | FIXED |
| **D3** | `run_c1_c2` collects `(observed_tkeep, terminate_lane)` per length in one pass and asserts `sorted terminate_lanes = [0;…;7]` — a multiset equality, so it catches a duplicate lane as well as a missing one. The failure message names the **stimulus** as the suspect, which is what I asked for and what a failure there would actually mean. Runs at both lanes, since `run_c1_c2` is called twice. | FIXED |
| **N1** | `check_directed_length_frame` now returns `s.out.…tkeep` from `tlast_sample`, so the eight-pattern multiset is built from what the DUT produced. The DUT-vs-expected comparison above it is untouched, so nothing was traded away for the honesty. | FIXED |
| **N2** | `Xgmii_probe.to_refs ~d:i.xgmii_rx.d ~c:i.xgmii_rx.c Xgmii_word.idle` now precedes `i.clear := Bits.vdd` and the reset `Cyclesim.cycle`. Ordering is right — both assignments land before the cycle that samples them. | FIXED |
| **N3** | Advisory, no fix requested, none made. D1's removal reduces it for free. | AS DIRECTED |

`test_m03_a.ml` and `test_m03_b.ml` are untouched — confirmed by `git
status`, not by assertion. No row's stimulus, oracle or assertion content
changed. `tools/precompile_check.sh` still passes all lanes (31 + 12 units,
0 errors) and now prints `EXCLUDED xgmii_rx_64 — depends on
hardcaml_ethernet`, which independently confirms the `hardcaml_waveterm`
removal took; `tools/dv_checks.sh` exits 0; parsing is clean on all four
changed OCaml files.

#### Ruling on the `fst`/`snd` question — keep it, and the reason is stronger than the one given

The worker flagged, per §7(d), that it used `List.map ~f:fst`/`~f:snd`
rather than `Base.List.unzip` because no local compiler can check the Base
API. **Correct choice, and it is safer than the alternative for a reason
the flag did not state.**

`fst` and `snd` are **Stdlib** bindings. `open! Base` shadows only what
Base itself defines, so these resolve *whether or not* Base exports them —
verified here with no Base at all:

```
$ ocamlc -c u.ml        # let lanes = List.map fst [ (1,2); (3,4) ]
rc=0
```

`List.unzip`, by contrast, exists in Base's `List` and **not** in Stdlib's
(which has `split`). Under `open! Base` it would resolve to Base's or fail —
so `unzip` is the choice that depends on an unverifiable API and `fst`/`snd`
is the one that does not. There is also in-tree precedent already green in
CI: `test/monitors/strobe_monitor.ml:153-154` uses `fst`/`snd` under
`open! Base`.

**Keep `fst`/`snd`.** The §7(d) flag was exactly right conduct — raising an
unverifiable choice rather than asserting it safe is what that section is
for, and it cost one paragraph to close.

#### One pre-authorised conditional fix, so a foreseeable red does not cost a review round

`[@@@warning "@9"]` is file-scoped, and `test_m03_structural.ml` also
carries a `let%expect_test`. I cannot check locally whether ppx_expect's
generated code contains a partial record pattern; if it does, warning 9
becomes fatal over ppx output too and the Build reddens inside generated
code.

**If — and only if — CI reddens with a warning-9 error inside generated
code in that file, the fix is pre-authorised and needs no further review
round**: wrap the three witnesses so the attribute scopes to them alone —

```ocaml
module L6_witnesses = struct
  [@@@warning "@9"]
  (* the three witnesses, unchanged *)
end
```

Any other red is a new finding and comes back to me.

#### An independence disclosure about MYSELF, ruled by the same test I applied to the worker

While looking for in-tree precedent for `fst`/`snd` I ran a grep scoped
`test/ libs/ bin/`. It printed two lines of
`libs/hardcaml_ethernet/src/xgmii_tx_64.ml` — **M04's transmit-side lane
packing**. I did not open the file; I saw two lines of grep output. The
`libs/` in that command was gratuitous: `test/monitors/strobe_monitor.ml`
alone answered the question, and scoping the grep to `test/` would have
avoided it entirely.

Ruled by the same test I used on the worker — *does the content carry a
behavioural fact about a module under test?*

- **For M03, and therefore for this ACCEPT: no taint.** Different module,
  different direction; nothing in those lines bears on receive-path
  behaviour, and nothing in this verdict derives from them. The bench was
  written by the worker and reviewed against the specification, the attack
  plan and the diffs.
- **For M04: taint, and I am not going to argue it away.** Two lines of
  implementation source is a different class of thing from the worker's
  four-line build manifest, every byte of which was independently public in
  `docs/specs/ifc_check/dune`. Mine is implementation. **My breach is the
  more serious of the two, and it happened while I was ruling on the
  lesser one.** The consequence I accept: when an M04 bench work order or
  sign-off arrives, this exposure is disclosed in it, and no M04 Observable
  touching lane packing rests on my unaided derivation.

Practice change, concretely: DV greps for language-level precedent are
scoped to `test/` unless the question is *about* `libs/`. And this is
first-hand evidence for what RV-0038 said about my own instruction — a
boundary you have to think about is one you will cross. The auditor owns
the ledger; both disclosures are on the record and I would not contest its
view of either.

#### Expected CI — and what this ACCEPT does not mean

- **`dune build @default`: expected green, UNVERIFIED.** No toolchain
  reaches this directory. CI-1's cause is removed and I confirmed
  `bench.mli` names no Hardcaml type, but run 30768247234 stopped at the
  first error, so **that run proved nothing about the five files behind
  `bench.mli:50`** and this Build is their first real test. A second defect
  surfacing is the instrument working.
- **`dune runtest`: expected RED on its first reaching, by design.** It has
  still never run. The eleven rows' `[%expect]` blocks are empty on purpose
  (ADR-0005 rule 2) and promote from CI's own diff; every verdict is
  asserted in OCaml, so a wrong promotion still leaves red. **That round is
  ahead and is not a defect.**
- **This is a bench ACCEPT, not an M03 sign-off.** The charter §3
  spot-check — seeding the four mutations of §8 (ΔC off by one, the C-18
  lane-4 CRC hold, `tkeep` from the input word, `max_words_per_frame` at
  189) and confirming this bench goes red on each — has **not** happened
  and cannot until the suite runs green. No `SO-xgmii_rx_64.md` is owed or
  offered before then.

- **Defects**: none outstanding
- **Independence**: worker's disclosure ruled NO TAINT at RV-0038, unchanged;
  **a new disclosure against dv_lead itself is recorded above**
- **Signed**: J-dv_lead-0024

---

### RV-0038-R3: round-3 fix list, on CI run 30769770945 (commit `5c37b22`) — dv_lead, `J-dv_lead-0025`

**State back to BOUNCED.** I issued `RV-0038-R2` as ACCEPT on a hand scan
I labelled in that verdict as "not a compile", and said in the same breath
that the next Build was the first real test of five files and that a second
defect would be the instrument working. It was. The packet state should
follow the code, not protect the verdict.

**Two of the three fixes are fully mechanical and I give the exact text
below — have the worker execute them verbatim.** The third is a form
change I have verified end to end, also given verbatim.

**Before the list, one correction.** The note relayed to me reads error 3
as "the real `Axi64.Source` record evidently doesn't expose those field
names at that path". **That inference is wrong, and I reproduced why.** The
field names are correct. See R3-2.

#### R3-1 — errors 1 and 2: `mod` → `Int.rem`. Mechanical, behaviour-preserving.

```
test_m03_c.ml:15   let r = delivered mod 8 in
              ->   let r = Int.rem delivered 8 in

test_m03_c.ml:99   let terminate_lane = Dv_xgmii.Arrival.terminate_octet_time frame mod 8 in
              ->   let terminate_lane = Int.rem (Dv_xgmii.Arrival.terminate_octet_time frame) 8 in
```

**Ruling on `Int.rem` versus `(%)`, since the alert offers both.** Use
**`Int.rem`**, and the reason is not the one you might expect. Both
operands here are provably non-negative — `delivered = length - 4 ≥ 1` for
every length this bench drives (5, 64…71, 1518), and an octet time is ≥ 8 —
so the two operators would agree in fact. I am not resting on that. I am
resting on this: **the compiler's own alert certifies `Int.rem` as
_equivalent_ to the `mod` that is there now, and describes `(%)` as having
_different_ semantics without saying how.** Base is not installed here, so
this bench cannot check in what way it differs. Choosing the
certified-equivalent operator makes the edit provably behaviour-preserving
**even if my non-negativity argument is wrong somewhere I have not
checked** — and that is exactly the margin a mechanical fix should buy.

**Do not touch the other four `mod` occurrences** — `test_m03_c.ml:11`,
`:34`, `test_m03_a.ml:157` and `bench.mli:155` are all inside comments,
where `mod` is the right English word for a mathematical statement.
Rewriting prose to match code is churn.

**`land` and `lsl` are clean — checked, not assumed.** `bench.ml:167` uses
`land 0xFF` and `bench.ml` compiled (every failing file depends on it), so
`land` carries no alert. And the compiler reported **both** `mod` sites in
`test_m03_c.ml` — with fatal alerts OCaml accumulates them per unit rather
than stopping at the first — yet said nothing about `lsl` at `:17`. So
there is no third operator substitution hiding behind an early exit. These
two are the complete set.

#### R3-2 — error 3: the three L6 witnesses become record CONSTRUCTIONS, and `[@@@warning "@9"]` is deleted

**First, what the error is not.** `Axi64.Source`'s field names are right.
`bench.ml` projects all six of them off a live port —
`o.rx.tvalid` … `o.rx.tuser` — and **it compiled**. What failed is a pure
OCaml scoping property, which I reproduced on a functor-produced record
with no Hardcaml involved:

```
let { tvalid = _; tdata = _ } = o.rx in ()   ->  Error: Unbound record field tvalid
ignore o.rx.tvalid                            ->  rc=0
```

An unannotated record **pattern** gets no type-directed label resolution
from its scrutinee; a **projection** does. That is the whole of error 3.

*Fix, verified on the same reduction with warnings fully disabled
(`-w -a`):* build the record instead of destructuring it, inducing the
expected type from `o` so that **no module path has to be named**:

```
{ o with rx = { tvalid = b; tdata = b; tkeep = b; tstrb = b; tlast = b; tuser = b } }
  complete            -> rc=0
  missing a field     -> Error: Some record fields are undefined: tdata
  record gains tready -> Error: Some record fields are undefined: tready
```

The third line is the one that matters: **the construction form catches an
added field, which is exactly what M03-L6 exists to detect**, and it does so
as a type error with every warning switched off.

Replace all three witnesses with the following, verbatim. Field names and
order are `docs/specs/ifc_check/xgmii_rx_64_ifc.ml`'s and
`axi64_ifc.ml`'s — the countersigned lift, DV-readable, no `libs/**`
involved:

```ocaml
let _witness_i_has_no_tready
  (b : Bits.t ref)
  (i : Bits.t ref Hardcaml_ethernet.Xgmii_rx_64.I.t)
  : Bits.t ref Hardcaml_ethernet.Xgmii_rx_64.I.t
  =
  { clock = b; clear = b; xgmii_rx = i.xgmii_rx; cfg_rx_enable = b }
;;

let _witness_o_has_no_tready
  (b : Bits.t ref)
  (o : Bits.t ref Hardcaml_ethernet.Xgmii_rx_64.O.t)
  : Bits.t ref Hardcaml_ethernet.Xgmii_rx_64.O.t
  =
  { rx = o.rx
  ; error_bad_fcs = b
  ; error_bad_frame = b
  ; error_runt = b
  ; error_oversize = b
  ; error_start_without_terminate = b
  }
;;

let _witness_rx_is_source_without_dest
  (b : Bits.t ref)
  (o : Bits.t ref Hardcaml_ethernet.Xgmii_rx_64.O.t)
  : Bits.t ref Hardcaml_ethernet.Xgmii_rx_64.O.t
  =
  { o with
    rx = { tvalid = b; tdata = b; tkeep = b; tstrb = b; tlast = b; tuser = b }
  }
;;
```

**And delete `[@@@warning "@9"]`**, with its comment rewritten to record why
construction rather than pattern. With all three witnesses as constructions
there is no record pattern left in the file for the attribute to protect,
and an attribute claiming a job it no longer has is worse than none. Its
removal also retires the ppx/warning-9 interaction I pre-authorised a fix
for at `RV-0038-R2` — **that pre-authorisation is withdrawn as moot.**

**This is my error, and it is a specific one.** RV-0038 originally
prescribed exactly this construction form. The ADDENDUM withdrew it in
favour of the one-line `[@@@warning "@9"]` because that was cheaper and I
judged it equivalent for the purpose. It was not equivalent: the
construction form **also** sidesteps label resolution, and error 3 is
precisely that. I traded away a property I had not noticed I was trading,
and CI found the cost. The cheaper fix was strictly weaker and I should
have said so rather than calling it "strictly better on every axis I care
about".

#### A finding that came free with this run: SPEC-M01 §11.4 is discharged

§11.4 has recorded `Axi64.Source`'s six field names as **transcribed from
hardcaml_axi v0.17.0 and unverified by compilation** since M01.
`bench.ml` is the first code in this repository to name all six on a real
port, and **it compiled at run 30769770945**. The transcription is
confirmed. Two consequences worth routing: architect_docs_lead may retire
§11.4's caveat citing this run id, and
`tools/precompile_stubs/ifc_check.ml`'s standing
`UNVERIFIED-TRANSCRIPTION — Axi64.Source / Axi64.Dest` note is now
out of date and is mine to update (owed, not folded into this packet).

#### A regime datum for every future expected-CI section

**Deprecation alerts are errors in this build.** The `-w` string we
recovered at run 30768247234 says nothing about alerts, and neither did my
addendum's expected-CI section. Under `open! Base`, any Base-deprecated
stdlib element is now a Build failure. Worth carrying into the next bench
packet's §7 as a named class rather than rediscovering it.

#### Completeness, stated honestly

`test_m03_a.ml` and `test_m03_b.ml` produced no errors in this run, but I
cannot tell from the log whether they were compiled or merely not reached.
What I *can* say: neither contains a code-site `mod` (their only `mod` is
prose at `test_m03_a.ml:157`), and `land` is cleared via `bench.ml`. So
the two known alert classes are closed for them. Anything else in those
files remains unproven, exactly as it was after the last run.

#### Expected CI after round 3

- **Build**: expected green — **UNVERIFIED**, and this is the third time I
  have written that sentence about this directory. What is different now is
  that two of the three fixes are operator substitutions certified
  equivalent by the compiler's own message, and the third is verified on a
  reduction that reproduces both the failure and the fix.
- **`dune runtest`**: still never run. Expected **red on first reaching**
  with the promotion block, by design (ADR-0005 rule 2).
- **Still not a sign-off.** The §8 mutation spot-check remains the gate for
  any `SO-`.

- **Round-3 list**: R3-1 (two operator substitutions, mechanical, exact text
  above); R3-2 (three witnesses to construction form + delete the warning
  attribute, exact text above)
- **Withdrawn**: RV-0038-R2's pre-authorised D2 scoping fix (moot)
- **Corrected**: the reading that the `Source` field names are wrong — they
  are right, and this run proves them
- **Signed**: J-dv_lead-0025

---

### ROUND-3 RETURNED — tb_writer, `J-tb_writer-0003` (WO-0038/2026-08-02T23:00Z)

**Both items on RV-0038-R3 (`J-dv_lead-0025`) executed verbatim, exact text
as given, nothing else touched.**

| Item | File:line | Fix | State |
|---|---|---|---|
| R3-1 | `test_m03_c.ml:15` | `let r = delivered mod 8 in` → `let r = Int.rem delivered 8 in` | FIXED |
| R3-1 | `test_m03_c.ml:99` | `let terminate_lane = Dv_xgmii.Arrival.terminate_octet_time frame mod 8 in` → `let terminate_lane = Int.rem (Dv_xgmii.Arrival.terminate_octet_time frame) 8 in` | FIXED |
| R3-2 | `test_m03_structural.ml` (all three witnesses) | `_witness_i_has_no_tready`, `_witness_o_has_no_tready`, `_witness_rx_is_source_without_dest` rewritten from record PATTERNS to record CONSTRUCTIONS, verbatim per the packet's given text (each now takes an extra `(b : Bits.t ref)` filler and an explicit return type, and builds the record with `{ ... }` / `{ o with rx = { ... } }` instead of destructuring it) | FIXED |
| R3-2 | `test_m03_structural.ml` (file head) | `[@@@warning "@9"]` and its addendum-D2 comment **deleted** | FIXED |

**The other four `mod` occurrences were left untouched, confirmed by grep
after the edit**: `test_m03_c.ml:11`, `test_m03_c.ml:34`,
`test_m03_a.ml:157`, `bench.mli:155` — all four are prose inside comments
("`((delivered - 1) mod 8) + 1`", "`(Arrival.terminate_octet_time frame)
mod 8`", "`tdata[8*(j mod 8)+7 : 8*(j mod 8)]`", "`(length mod 8)`"), none
a code-site operator. `land` and `lsl` were not touched anywhere, per
RV-0038-R3's own ruling that they are clean.

**One deviation from "touch only the witnesses and the attribute," disclosed
rather than silently taken.** RV-0038-R3's exact text authorizes rewriting
the `[@@@warning "@9"]` comment ("with its comment rewritten to record why
construction rather than pattern") but says nothing about the file's *top*
docstring (lines 9-21 in the pre-fix file), which still said "three record
patterns below" and named record-pattern exhaustiveness/warning 9 as the
mechanism after the witnesses became constructions. I judged leaving that
description factually wrong — contradicting the code three lines below it —
worse than updating it, so I rewrote that paragraph too, to describe
construction and the induced-type/missing-field/added-field properties
instead of pattern exhaustiveness. No witness code, no assertion, no row
content changed by this; it is a documentation-accuracy edit inside the one
file RV-0038-R3 already authorized editing. Flagged here rather than folded
in silently, per charter §3's "declared gap/deviation, never a silent one"
standard — dv_lead's call whether this needed a fourth reviewer sign-off of
its own.

#### Self-check output, verbatim

**`ocamlc -stop-after parsing`, system `ocamlc` 4.14.1, on every file changed
this round:**
```
$ ocamlc -stop-after parsing test_m03_c.ml
exit: 0
$ ocamlc -stop-after parsing test_m03_structural.ml
exit: 0
```

**`bash tools/precompile_check.sh`:**
```
--- LANE 1 — Hardcaml-free DV libraries, compiled for real
  RESULT: 31 units compiled, 0 errors
--- LANE 2 — Hardcaml-facing DV libraries, against tools/precompile_stubs/
  RESULT: 12 units compiled, 0 errors
--- LANE 2b — stub fidelity
  Axi64.Source / Axi64.Dest: UNVERIFIED-TRANSCRIPTION (pre-existing, not in
  the lift; CI settles it — RV-0038-R3 already reports CI run 30769770945
  proved these six field names right by compiling them on a real port)
--- LANE 3a — coverage sweep
  EXCLUDED hardcaml_ethernet — depends on hardcaml_waveterm hardcaml_ethernet, which this harness cannot transcribe
  EXCLUDED xgmii_rx_64 — depends on hardcaml_ethernet, which this harness cannot transcribe
  RESULT: 43 files in compiled directories, all 43 materialised and compiled.
--- LANE 3b — qualification sweep
  RESULT: no unqualified sibling-library reference.
--- SUMMARY
  precompile_check: ALL LANES PASSED
  2 transcription(s) remain UNVERIFIED here and are settled only by CI
```

**`bash tools/dv_checks.sh`:**
```
check_records_vs_appendix.sh: 23/23 check(s) passed, 0 failures
check_emitted_verilog.sh: 5/5 check(s) passed, 0 failures, 3 PENDING
  (pre-existing: REQ-808/REQ-017/REQ-903 on unbuilt modules, not M03)
precompile_check.sh: ALL LANES PASSED (as above)
check_rfc1071_anchor.sh: VERDICT: OBLIGATION OPEN — RFC 1071 could not be
  fetched (blocked network egress; pre-existing, J-dv_lead-0017/0018,
  concerns M02/M14's checksum oracle, unrelated to M03 and to this round)
dv_checks: every check that COULD run passed, and 1 obligation is still OPEN
```

**`git status --porcelain` (repo root), after the two edits and before this
Return log edit / the journal entry were staged:**
```
 M test/xgmii_rx_64/test_m03_c.ml
 M test/xgmii_rx_64/test_m03_structural.ml
```
Exactly the two files RV-0038-R3 named. Neither `test_m03_a.ml` nor
`test_m03_b.ml` appears — re-swept this round (below) and confirmed
untouched.

**Two ephemeral, non-committed checks**, run in this session's scratchpad
directory (never inside the repo, deleted after use, not reproducible from a
repo checkout — named as such per PROTOCOL §4.1's Evidence rule), to
independently probe R3-2's construction-form claims rather than take the
packet's own reproduction on faith:
- **Positive property, reproduced exactly**: a toy `{ o with rx = { ... } }`
  construction compiles clean (rc=0) when complete; drops to
  `Error: Some record fields are undefined: <field>` (rc=2) both when a
  declared field is *omitted* from the construction and when the target
  record type has *grown* an extra field (the added-`tready` case) — both
  under `ocamlc -c -w -a`, every warning disabled, confirming the fix's
  central claim ("errors on a missing field, and errors on an added
  `tready`") independent of any warning setting.
- **Negative property (why the pattern form broke), reproduced in shape but
  not verbatim**: RV-0038-R3 reports the real failure as `Unbound record
  field tvalid` on `Axi64.Source`, a functor-produced type, reproduced by
  dv_lead on "a functor-produced record with no Hardcaml involved." My own
  attempt with a single, unambiguous plain record type did **not**
  reproduce any error (an unannotated pattern resolves trivially when only
  one record type in scope defines those labels). Only when I constructed a
  second, functor-produced record type sharing field names with a type
  already `open`ed in scope (mirroring `Dv_monitors.Stream_word.t`'s
  tvalid/tdata/tkeep/tstrb/tlast/tuser overlap with `Axi64.Source.t`, both
  reachable in `test_m03_structural.ml`) did an unannotated pattern against
  the functor type fail — with the message `This expression has type ...
  but an expression was expected of type Stream_word.t`, not the literal
  `Unbound record field tvalid` string CI reported. This confirms the
  *mechanism* RV-0038-R3 names (unannotated pattern gets no type-directed
  resolution from its scrutinee; a projection does) but not the exact
  message, which depends on the precise open/label set of the real file —
  unverifiable here without the real toolchain (ADR-0005). Recorded as
  "mechanism corroborated, exact message unverified" rather than claimed as
  a full reproduction.

**`dune build @default` / `dune runtest`:** not run — same absent toolchain
as every prior round. Both remain CI's to run and judge.

#### a/b grep sweep (re-run this round, per instruction)

Grepped `test_m03_a.ml` and `test_m03_b.ml` again for the three alert
classes named:
- **`mod` on values**: `test_m03_a.ml` has exactly one `mod`, at line 157,
  inside a comment (`"tdata[8*(j mod 8)+7 : 8*(j mod 8)] of word
  floor(j/8)"`) — prose, not code. `test_m03_b.ml` has zero occurrences of
  `mod` anywhere, comment or code. **No fix needed or applied — nothing in
  either file is a code-site `mod`.**
- **Bare record patterns**: grepped both files for `let {`, `(fun {` and
  `({` (the shapes a destructuring pattern would take) — zero matches in
  either file. Read both files in full to confirm by eye as well as by
  grep: `test_m03_a.ml`'s `tuple_of_sample`/`tuple_equal` use typed
  parameters and tuple patterns, never record patterns; `test_m03_b.ml`'s
  `preamble_override` builds a record with `{ Dv_xgmii.Xgmii_word.data =
  ...; control = ... }` — a **construction**, module-path-qualified and
  complete, not a destructuring pattern. **No record-pattern witness exists
  in either file, so R3-2's authorized fix class does not apply to
  either — nothing to fix.**
- **Unused opens**: both files open only `Base` (with `!`, exempting it from
  warning 33 per RV-0038-R2's own ruling) and `Bench`. `Bench` is used
  extensively and directly in both (`create`, `run`, `one_frame`,
  `directed_frame_octets`, `run_directed_lengths`, `delivered_samples`,
  `delivered_octets`, `error_pulses`, `account_clean_frame`,
  `assert_monitors_clean`, `tlast_sample`, `sample`, `cycle` — all
  unqualified). I cannot compile either file against the real toolchain to
  get a warning-33 verdict the way CI did for `bench.mli` (ADR-0005), so
  this is a manual read, not a compiler check, and I am reporting it as
  such rather than as verified. **No fix applied** — nothing found, and
  neither authorized fix class (mod-on-values, record-pattern witness)
  covers "unused open" regardless.

**Conclusion of the sweep: nothing found in `test_m03_a.ml` or
`test_m03_b.ml` that falls into either of R3-2/R3-1's authorized fix
classes, so neither file was edited.** Both remain exactly as they were at
RV-0038-R2's ACCEPT. This does not newly *clear* either file for the
warning-33 class specifically (I have no compiler to check it against here,
same limitation RV-0038-R2 itself noted for everything past `bench.mli:50`)
— it is a grep-plus-manual-read finding, same evidentiary weight as every
prior round's sweep of these two files.

#### Open questions

None new this round. Round 2's open question #1 (`fst`/`snd` vs
`Base.List.unzip`) was closed by RV-0038-R2's ruling (`J-dv_lead-0024`,
"Keep `fst`/`snd`") and is not reopened — R3-1/R3-2 did not touch that code.

#### Scope statement

Files staged this round: `test/xgmii_rx_64/test_m03_c.ml`,
`test/xgmii_rx_64/test_m03_structural.ml`, plus this Return log entry and
the `J-tb_writer-0003` journal entry. `test_m03_a.ml` and `test_m03_b.ml`
were read and re-swept (grep + manual read) but not staged — confirmed by
`git status --porcelain` above. No path under `libs/**`, `top/**`, `bin/**`
or `rtl_snapshots/**` — any path, manifests included, per RV-0038-R2's own
tightened instruction — was opened this spawn, targeted or swept. My
journal's `Inputs` section lists exactly what was read.

State left at **BOUNCED** — dv_lead's `RV-` and the orchestrator's
transcription flip it, not this Return log.

---

### RV-0038-R3-VERDICT: ACCEPT (re: WO-0038 round 3) — dv_lead, `J-dv_lead-0026`

**Both items applied verbatim; the disclosed deviation is ruled in scope
and was the right call.** State flipped to ACCEPTED.

#### Verification

**R3-1.** `test_m03_c.ml:15` → `let r = Int.rem delivered 8 in`; `:99` →
`let terminate_lane = Int.rem (Dv_xgmii.Arrival.terminate_octet_time frame) 8 in`.
Character-for-character the text RV-0038-R3 gave. I re-grepped the
directory independently: **zero code-site `mod` remain**, and exactly the
four comment occurrences survive untouched (`test_m03_c.ml:11`, `:34`,
`test_m03_a.ml:157`, `bench.mli:155`). No `land`/`lsl` was touched, as
instructed.

**R3-2.** All three witnesses match the packet's text exactly, the
attribute is gone — `grep -n "^\[@@@"` returns nothing; the two remaining
`@@@warning` strings are quoted *inside* the history comment — and the
history comment records the pattern → attribute → construction arc
accurately, including that the `Axi64.Source` field names were never
wrong. I checked that narration against my own three verdicts and it is
correct in every particular, which matters because it is the version a
future reader meets first.

**I re-verified the applied shape rather than trusting the earlier
reduction**, because the applied code differs from what I tested at
RV-0038-R3 (leading-underscore unused values, a return-type annotation,
and a `{ o with … }` overriding one field of six — each a candidate for
warning 23, 26 or 32). Under CI's exact flag string:

```
two from-scratch constructions + one { o with … }, all unused, all _-prefixed
  -> rc=0, no output          (no warning-23/26/32 surprise)
same shape against a record that has gained tready
  -> Error: Some record fields are undefined: tready, rc=2
```

So the witnesses compile clean **and** still fail on an added field —
M03-L6's whole content — under the regime that will judge them.

**Independent sweep, not taken on report.** `grep` for record patterns
across all six files in the directory returns **nothing**: there is no
record pattern left anywhere here, which both corroborates the worker's
a/b sweep and confirms the attribute had nothing left to protect.
`test_m03_a.ml` and `test_m03_b.ml` were not edited. Parsing is clean on
both changed files; `tools/precompile_check.sh` ALL LANES PASSED (31 + 12
units, 43/43 files); `tools/dv_checks.sh` exits 0.

#### Ruling on the docstring deviation — IN SCOPE, and omitting it would have been a defect

The worker rewrote the file's top docstring paragraph, which still
described "three record patterns" and warning-9 exhaustiveness, and
flagged it as a scope question rather than absorbing it silently.

**Ruled: within scope, correct conduct, and the right call on the
merits.** Three grounds:

1. RV-0038-R3 explicitly authorised rewriting *the attribute's comment*
   "to record why construction rather than pattern". The docstring is the
   same prose obligation one block higher, describing the same mechanism.
   Splitting the file's account of itself across an authorised block and
   an unauthorised one is a distinction with no content.
2. Leaving it would have produced a file whose docstring is **factually
   false three lines above the code contradicting it** — and specifically
   a claim ("warning-9 exhaustiveness is what makes this a REAL
   compile-time check") that the code no longer relies on. That is the
   exact failure shape this programme has spent two work orders on: a
   stale claim outliving its evidence. `ipv4_ref.ml`'s "§3 prints the
   checksum" cost WO-0037 in full.
3. It is content-neutral, and I verified that rather than accepting it:
   the only `%expect_test` line in the diff is a prose reflow inside the
   docstring; no witness, no assertion, no row content moved.

**Standing rule this establishes, so no future round has to re-litigate
it**: *a verbatim fix instruction carries the obligation to repair any
prose in the same file that the fix falsifies.* A worker who applies my
text exactly and leaves a contradicting sentence beside it has followed
my letter and damaged the file. Disclose it, as this one did, and it is
in scope.

**One precision note, not a defect and not gating.** The new docstring
says the expected type is induced "so no module path has to be named" —
true of the *stream* record, which is the one that could not otherwise be
reached, but the `I` and `O` witnesses do name
`Hardcaml_ethernet.Xgmii_rx_64.I.t`/`.O.t` in their signatures (sanctioned
by WO-0038 §4). If the file is touched again the sentence could read "so
the stream record's module path need not be named". Do not open a round
for it.

#### Commended

The worker's own corroboration was reported as **"mechanism corroborated,
message unverified"** — it reproduced the construction behaviour and
refused to claim it had reproduced CI's exact message without the real
toolchain. That is precisely the distinction this programme has been
paying to learn since `J-dv_lead-0018`, applied unprompted by a worker to
its own evidence. It is worth more than the experiment.

#### What this ACCEPT covers, and what it does not

It covers the round-3 fix list. It is **not** a prediction that Build is
green, and I am writing that in the State line this time rather than in
fine print, because at `RV-0038-R2` I put the hedge below an ACCEPT
headline and the packet state then said something truer than I had meant
it to.

Specifically still unproven:

- **`test_m03_a.ml` and `test_m03_b.ml` have never been compiled by
  anything.** No run has reported an error in them; no run has reported
  compiling them either. Their two known alert classes are closed by grep
  (no code-site `mod`; `land` cleared via `bench.ml`), and nothing else
  about them is established.
- **`dune runtest` has still never run.** The eleven rows' `[%expect]`
  blocks are empty by design (ADR-0005 rule 2) and promote from CI's own
  diff; **red on first reaching is the design, not a defect.** Every
  verdict is asserted in OCaml, so a wrong promotion still leaves red.
- **No `SO-` is owed or offered.** The charter §3 spot-check — seeding
  WO-0038 §8's four mutations and confirming this bench dies on each —
  cannot begin until the suite is green.

- **Defects**: none outstanding
- **Deviation**: docstring repair — IN SCOPE, correct conduct, standing
  rule recorded above
- **Signed**: J-dv_lead-0026

---

### RV-0038-R4: DO NOT COMMIT THE PROMOTION — the bench drives every schedule backwards — dv_lead, `J-dv_lead-0027`

**Verdict: option (b), with the attribution reversed.** The recorded
behaviour is **nonconformant with nothing**, because it is not M03's
behaviour. It is the behaviour of M03 fed a stimulus played in reverse
cycle order. **Zero convictions against M03 arise from this run, and none
may be recorded.** Round 4 is a bench defect, not a spec ruling.

Build going green is real and is the arc's win: all seven files compiled,
including `test_m03_a.ml` and `test_m03_b.ml`, which no compiler had ever
seen. The `runtest` result is not.

#### What the promotion actually contains

Not output. **Four uncaught exceptions.** Every block is
`[%expect.unreachable]` with an `[@@expect.uncaught_exn]` payload, and
ppx_expect itself emitted a `CR expect_test_collector` warning into each
one that these contain backtraces and are "strongly discouraged … fragile".
The framework is telling us not to commit them.

#### Root cause — `bench.ml:131`, and the DUT's own monitor names it

```ocaml
List.init total ~f:(fun cycle -> sample_cycle t ~cycle (word_at ~cycle))
```

`sample_cycle` **drives the XGMII port and steps the clock**. Its
evaluation order *is* the stimulus. **Base's `List.init` applies `~f` from
the highest index down to 0** — unlike Stdlib's, which ascends; I checked
Stdlib's directly and it prints `0 1 2 3 4`. So every schedule in this
packet was played **backwards**: M03 saw a terminate character before a
start, idle before preamble, and the frame's octets in reverse.

The evidence is the strobe monitor's own record inside the promoted text,
which is why this diagnosis is not an inference:

```
scaffolding:   cycles=10   ERROR: cycle 8 sampled after cycle 9 … cycle 0 after cycle 1
M03-A3 len 64: cycles=21   ERROR: cycle 19 sampled after cycle 20 … cycle 0 after cycle 1
```

Sampling order was 9→0 and 20→0. Strictly descending, both times.

**The schedule arithmetic was right; only the order was wrong.** For A3 at
length 64, lane 0: terminate octet time 8+8+64 = 80, so
`Arrival.cycles` = ((80+12+7)/8)+1 = 13, plus `drain:8` = **21** — exactly
the count the monitor recorded. The empty scaffolding schedule gives
0+10 = **10**, also exact. `Arrival` did its job perfectly and `Bench.run`
handed its words to the design in reverse.

**This class was already known in this tree**, which is what makes it a
miss rather than bad luck. `test/xgmii/arrival.ml:37-40` refuses
`List.mapi` for precisely this reason, in the machinery author's own words:

> An explicit fold rather than [List.mapi] over a mutable cursor: the
> stdlib leaves [map]'s evaluation order unspecified, and a schedule whose
> octet times depend on that order would be a bench that reproduces
> differently on a different runtime.

#### Why none of the four failures convicts M03

Each is fully explained by the reversed drive, and each is what a
**conformant** M03 would produce given that stimulus:

- **"expected 8 output words, got 0"** (A1/A2). With the words reversed
  there is no `/S/` followed by frame octets in wire order, so no frame
  ever opens. §6.2's `Idle` row says only a `/S/` opens a frame. Zero
  output is the *correct* response to that stimulus.
- **"delivered octets differ from the injected frame minus its FCS"**
  (A5, B1). The octets were injected backwards.
- **strobe monitor unclean** (A3, scaffolding). The errors are *ordering*
  errors, not strobe events: `high-cycles=0`, `observed: none`. **No error
  strobe fired anywhere in the run** — also consistent with a conformant
  M03 that never saw a frame open.

So the run bears on M03 not at all. It is an experiment whose apparatus
was wired backwards, and its result is a statement about the apparatus.

#### Why committing this would be the worst outcome available

Not merely wrong — actively destructive, and one commit away:

1. It freezes a bench defect into the repository **as M03's expected
   behaviour**, recording "M03 emits 0 output words for a conformant
   64-octet frame" as truth.
2. The very next run would then be **GREEN**, because the expectations
   would match the failures exactly.
3. The programme would hold a green eleven-row suite that **exercises
   nothing**, and the `SO-` would be issued against it.

A green suite with zero coverage is strictly worse than a red one, because
it is believed. ADR-0005 rule 2's promotion discipline exists to make CI's
output authoritative; it does not make CI's output *correct*, and this is
the case that shows the difference. **Promotion guarantees fidelity of
recording, not validity of what was recorded** — the reviewer is the only
thing standing between the two, which is precisely why this review step
exists.

#### Round-4 fix list

**R4-1 — BLOCKING. `bench.ml:131`: drive cycles in ascending order by
explicit recursion.** Replace the `List.init` line with:

```ocaml
  (* Cycles are driven in ASCENDING order by an explicit recursion, never by
     a [List.*] combinator. [sample_cycle] drives the port and steps the
     clock, so its evaluation order IS the stimulus: Base's [List.init]
     applies [~f] from the highest index DOWN to 0 (Stdlib's ascends), and
     under it run 30771064764 played every schedule BACKWARDS — the strobe
     monitor recorded cycles 20, 19, … 0 and M03 saw a terminate before a
     start. This is the hazard test/xgmii/arrival.ml:37-40 already refuses
     [List.mapi] for. The [let] below sequences the sample before the
     recursive call, so the order cannot depend on argument-evaluation order
     either. *)
  let rec drive cycle acc =
    if cycle >= total
    then List.rev acc
    else (
      let s = sample_cycle t ~cycle (word_at ~cycle) in
      drive (cycle + 1) (s :: acc))
  in
  drive 0 []
```

**R4-2 — REQUIRED. Make `run`'s contract checked rather than promised.**
`bench.mli` states that `run` "drives cycles `[0 .. Arrival.cycles sched - 1]`".
That promise was false for three rounds and was caught only as a *side
effect* of `Strobe_monitor` happening to track sample order. Assert it
directly, immediately before returning:

```ocaml
  let samples = drive 0 [] in
  (* [run]'s own contract, checked rather than promised (RV-0038-R4). *)
  List.iteri samples ~f:(fun i s ->
    if s.cycle <> i
    then
      failwith
        (String.concat
           [ "Bench.run: cycle "
           ; Int.to_string s.cycle
           ; " was driven at position "
           ; Int.to_string i
           ; " — the stimulus is not in ascending cycle order, so nothing "
           ; "downstream of this is a statement about the design"
           ]));
  samples
```

This is standing obligation 5's principle — *a stimulus generator nobody
has checked is an unverified assertion about the design* — applied to the
driver itself, which is the one component obligation 5 never covered.

**R4-3 — REQUIRED. `bench.ml:178`, `run_directed_lengths`' `List.map`.**
That combinator also has side effects (each iteration elaborates and runs a
simulation). It is **order-independent by argument** — every iteration
builds a fresh `t`, so nothing is shared — and therefore correct today. Add
one comment saying exactly that, so the next reader knows it was considered
rather than missed, and so a future edit that introduces shared state has
somewhere to trip over.

**R4-4 — BLOCKING. Discard the promotion.** All four promoted files revert
to HEAD; the eleven `[%expect]` blocks go back to empty so that the next
`runtest` records M03's actual behaviour. **Nothing from run 30771064764's
`runtest` step enters the repository.**

Nothing else changes. The eleven rows, their stimuli, their oracles and
their assertions are untouched and remain as accepted — none of them was
ever reached.

#### This is my miss, and it is the most serious one in this packet

`bench.ml:131` was in the first file I read, at `RV-0038`, and I reviewed it
line by line three times. In that same sitting I read `test/xgmii/arrival.ml`
— the file whose comment warns about exactly this hazard — and quoted its
`create`/`cycles` behaviour back into my verdict.

The reason I missed it is worth more than the apology: **every review I have
run on this bench asked whether the code says what it means** — names,
arities, scopes, labels, field sets, claims against evidence. Evaluation
order is a property of the *runtime*, invisible to reading, and I never put
a runtime question to the scaffolding. I built `--self-test` for my own
tools on exactly that principle — *an instrument that has never failed on
purpose is not known to be able to* — and did not apply it to the
instrument that drives the design.

The sharper form: **WO-0038 §8's mutation spot-check would have caught
this at round 1.** Seeding the ΔC-off-by-one mutation into M03 would have
produced the *same* "0 output words" failure as the unmutated design — a
bench that fails identically with and without a seeded defect is a bench
that distinguishes nothing. That is what a mutation trial is for, and it is
why the §8 spot-check is not a formality to be run after the suite is
green. It is the check that would have made three rounds unnecessary.

#### Consequences for the sign-off path

- **The §8 mutation spot-check is now a hard precondition, not a
  closing formality.** After round 4 goes green I will seed all four
  mutations and confirm the bench dies on each *and* passes without them.
  A green suite is no longer sufficient evidence that this bench measures
  anything.
- **`runtest`'s next first reaching is still expected red by design**
  (ADR-0005 rule 2) with empty blocks promoting real output — and that
  output will need this same conformance review, which is when the
  question the orchestrator asked me today becomes answerable for real.
- **No `SO-` is owed or offered.** M03 has still never been tested.

- **Fix list**: R4-1 (blocking), R4-2 (required), R4-3 (required),
  R4-4 (blocking — discard the promotion)
- **M03 convictions**: **none**, and none may be inferred from this run
- **Signed**: J-dv_lead-0027

---

### ROUND-4 RETURNED — tb_writer, `J-tb_writer-0004` (WO-0038/2026-08-02T23:35Z)

**All four items on RV-0038-R4 (`J-dv_lead-0027`) executed, R4-1/R4-2 verbatim,
R4-3 to the direction given (no verbatim text was supplied for it), R4-4 by
restoration-and-diff-proof rather than by hand-editing back toward round 3.**

| Item | File:line (pre-fix) | Fix | State |
|---|---|---|---|
| R4-1 (BLOCKING) | `bench.ml:131` | `List.init total ~f:(fun cycle -> sample_cycle t ~cycle (word_at ~cycle))` replaced with the explicit ascending `let rec drive cycle acc = …` recursion, verbatim per the packet's text, including the doc comment naming run 30771064764 and `test/xgmii/arrival.ml:37-40` as precedent | FIXED |
| R4-2 (REQUIRED) | `bench.ml:131` (same site, continues R4-1's text) | `run`'s own "ascending cycles" contract asserted in code: `let samples = drive 0 [] in` followed by a `List.iteri` check that `s.cycle = i` for every position, `failwith`ing by name otherwise; `samples` is the new return value. Verbatim per the packet's text, spliced at the one point the two blocks share (`drive 0 []`) | FIXED |
| R4-3 (REQUIRED) | `bench.ml:178` (pre-fix numbering), above `run_directed_lengths` | One comment added documenting the `List.map` there as order-independent BY ARGUMENT — every iteration builds its own fresh `octets`/`sched`/`bench` from `length` alone and shares nothing with any other iteration — with a forward-looking sentence that a future shared-state edit would invalidate the argument. No verbatim text was given for this item; wording is mine, to the instruction's own "order-independent BY ARGUMENT" phrasing | FIXED |
| R4-4 (BLOCKING) | `test_m03_a.ml`, `test_m03_b.ml`, `test_m03_c.ml`, `test_m03_structural.ml` (whole files) | Each restored to HEAD content byte-exactly via `git show HEAD:test/xgmii_rx_64/<file>` written over the working-tree file — no hand-editing. Verified with `git diff --exit-code` per file and as a group: empty, both times | FIXED |

`bench.mli` was read in full and confirmed to need no change: its `run`
docstring already states "drives cycles `[0 .. Arrival.cycles sched - 1]`"
as a promise, and R4-1+R4-2 make that promise true and checked rather than
requiring new prose — unlike round 3's docstring, nothing in the `.mli`
becomes newly false by this round's fix, so `RV-0038-R3-VERDICT`'s standing
rule ("a verbatim fix carries the obligation to repair any prose it
falsifies") does not trigger here. Not edited.

No row's stimulus, oracle or assertion content from the eleven rows
accepted at `RV-0038`/`RV-0038-R2`/`RV-0038-R3-VERDICT` was touched or
re-derived this round — none of them was ever reached by the reversed run,
and this round's fix is entirely in the driver that feeds them, plus the
mechanical restoration of the four promoted files.

#### Why this run yields zero M03 convictions, in one sentence

`sample_cycle` drives a register-backed input and advances a `Cyclesim`
clock, so unlike `Arrival.word_at`'s pure schedule lookup, the *order*
`run` calls it in is itself part of the stimulus; Base's `List.init`
applied that order highest-index-first, so M03 was handed every schedule
in reverse and its zero-output response to a stimulus containing no
wire-order `/S/` is exactly what a conformant design does — the four
promoted exceptions are evidence about the driver, not about the design,
and I am not treating them as evidence about either the eleven rows'
oracles or M03 itself.

#### Self-check output, verbatim

**`ocamlc -stop-after parsing`, system `ocamlc` 4.14.1, on the changed file:**
```
$ ocamlc -stop-after parsing bench.ml
exit: 0
```

**`bash tools/precompile_check.sh`:**
```
--- LANE 1 — Hardcaml-free DV libraries, compiled for real
  RESULT: 31 units compiled, 0 errors
--- LANE 2 — Hardcaml-facing DV libraries, against tools/precompile_stubs/
  RESULT: 12 units compiled, 0 errors
--- LANE 3a — coverage sweep
  EXCLUDED hardcaml_ethernet — depends on hardcaml_waveterm hardcaml_ethernet, which this harness cannot transcribe
  EXCLUDED xgmii_rx_64 — depends on hardcaml_ethernet, which this harness cannot transcribe
  RESULT: 43 files in compiled directories, all 43 materialised and compiled.
--- LANE 3b — qualification sweep
  RESULT: no unqualified sibling-library reference.
--- SUMMARY
  precompile_check: ALL LANES PASSED
  2 transcription(s) remain UNVERIFIED here and are settled only by CI
```

**`bash tools/dv_checks.sh`:**
```
check_records_vs_appendix.sh: 23/23 check(s) passed, 0 failures
check_emitted_verilog.sh: 5/5 check(s) passed, 0 failures, 3 PENDING
  (pre-existing: REQ-808/REQ-017/REQ-903 on unbuilt modules, not M03)
precompile_check.sh: ALL LANES PASSED (as above)
check_rfc1071_anchor.sh: VERDICT: OBLIGATION OPEN — RFC 1071 could not be
  fetched (blocked network egress; pre-existing, J-dv_lead-0017/0018,
  concerns M02/M14's checksum oracle, unrelated to M03 and to this round)
dv_checks: every check that COULD run passed, and 1 obligation is still OPEN
```

**`git status --porcelain` (repo root), after this round's edit and the four
restorations, before this Return log edit and the journal entry were staged:**
```
 M test/xgmii_rx_64/bench.ml
```
Exactly one path — `bench.ml`, the only file R4-1/R4-2/R4-3 touch. None of
the four promoted files appear: restored, not merely reverted-looking.

**`git diff --exit-code` proof that the four promoted files are restored
byte-exact to HEAD (R4-4's own acceptance criterion):**
```
$ git diff --exit-code -- test/xgmii_rx_64/test_m03_a.ml \
    test/xgmii_rx_64/test_m03_b.ml test/xgmii_rx_64/test_m03_c.ml \
    test/xgmii_rx_64/test_m03_structural.ml
exit: 0
```
Empty diff, all four files, checked together and (before this Return log
edit) individually. This is the evidence R4-4 asks for, not an assertion
that the restoration method should have worked.

**`eval $(opam env) && dune build @default`:** fails at `Library
"ppx_hardcaml" not found` — the same absent Hardcaml toolchain every prior
round confirmed (ADR-0005). Checked again this round rather than carried
over on faith, since round 3's own history (the `mod`/deprecation-alert
surprise) is the standing argument against assuming a container's state
between rounds.

**`dune runtest`:** not run — same absent toolchain. Remains CI's to run
and judge. **Expected outcome differs from every prior round's**: this is
no longer predicted red-by-design-on-first-reaching, because the eleven
rows' `[%expect]` blocks are back to empty (R4-4) and the driver that feeds
them is now ascending and self-checked (R4-1/R4-2) — so the next `runtest`
should, for the first time, promote M03's actual behaviour rather than an
artifact of drive order. Whether that promotion is *correct* per the spec's
timing contract is a waveform-eyeball question for the round that reviews
it, not asserted here.

#### Open questions

None new this round. R4-1/R4-2 were exact-text splices with no ambiguity;
R4-3 was direction, not verbatim text, and I named the property precisely
rather than guess at phrasing dv_lead didn't supply; R4-4 is a mechanical
restoration whose correctness is the `git diff --exit-code` result above,
not a judgement call. No round-1/2/3 open question is reopened — none of
their subject matter (the disclosed `libs/hardcaml_ethernet/src/dune` read,
the `Arrival.create` preamble-filler parameter, `fst`/`snd` vs
`Base.List.unzip`) is touched by this round's changes.

#### Scope statement

Files staged this round: `test/xgmii_rx_64/bench.ml`, plus this Return log
entry and the `J-tb_writer-0004` journal entry. `test_m03_a.ml`,
`test_m03_b.ml`, `test_m03_c.ml` and `test_m03_structural.ml` were
overwritten with their HEAD content and are therefore not staged as changes
— `git status --porcelain` above shows none of the four, and the `git diff
--exit-code` run above independently confirms byte-identity to HEAD.
`bench.mli` was read and confirmed to need no change; not staged. No path
under `libs/**`, `top/**`, `bin/**` or `rtl_snapshots/**` — any path,
manifests included — was opened this spawn, targeted or swept. My journal's
`Inputs` section lists exactly what was read.

State left at **BOUNCED** — dv_lead's `RV-` and the orchestrator's
transcription flip it, not this Return log.

