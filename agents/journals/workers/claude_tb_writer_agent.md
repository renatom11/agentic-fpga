# Journal: claude_tb_writer_agent

- **Agent**: tb_writer (Sonnet worker template)
- **Charter**: agents/charters/tb_writer.md
- **Format**: v1 — entry grammar in agents/PROTOCOL.md §4

This file is APPEND-ONLY. Content may only ever be added after the last line;
nothing above it is ever edited. Enforced by scripts/agent_commit.sh and CI.

---

## [J-tb_writer-0001] 2026-08-03T15:40Z | task:WO-0038 | M03's clean-frame spine — eleven rows, first bench in the tree

### Trigger

WO-0038/2026-08-03T14:05Z (dv_lead, via the orchestrator): the programme's
first bench — the eleven-row clean-frame spine of `AP-xgmii_rx_64.md` (A1-A5,
B1, C1-C4, L6) for `Xgmii_rx_64`, built on already-committed, already-tested
DV machinery (the XGMII probe, the strobe monitor, the octet-time tagger, the
Axi64 driver/probe).

### Inputs

Spec and plan text, read in full: `agents/charters/tb_writer.md`;
`agents/PROTOCOL.md` §2-6 and §10 (and skimmed in full for context);
`agents/handoffs/WO-0038_tb-m03-first-bench.md`;
`docs/specs/modules/xgmii_rx_64.md` (SPEC-M03, all 13 sections);
`docs/specs/requirements.md` §0 (0.1-0.7), §1 (REQ-001…021, §1.1), §2
(REQ-101…113), §12, and the §13 revision log rows touching REQ-101…113;
`docs/specs/ifc_check/xgmii_rx_64_ifc.ml`; `docs/specs/ifc_check/axi64_ifc.ml`;
`docs/specs/ifc_check/dune`; `test/attack_plans/AP-xgmii_rx_64.md` (all
sections, §0-§9).

Machinery contracts, read in full per WO-0038 §3: `test/xgmii/frame.mli`,
`test/xgmii/arrival.mli`, `test/xgmii/xgmii_word.mli`,
`test/monitors/protocol_monitor.mli`, `test/monitors/conservation_monitor.mli`,
`test/monitors/octet_time.mli`, `test/monitors/strobe_monitor.mli`,
`test/monitors/stream_word.mli`, `test/monitors/strobes.mli`,
`test/golden/crc32_ref.mli`. Two machinery files exist only as `.ml` (no
`.mli`) and were read as such, exactly as WO-0038 §3 names them:
`test/xgmii_probe/xgmii_probe.ml`, `test/axi64_probe/axi64_probe.ml`.
`test/hardcaml_ethernet/test_word_counter.ml` read in full, per WO-0038 §4's
explicit sanction ("DV's own file and you may read it freely") — this is
where the `Cyclesim.With_interface` / `Scope.create` / `Waveform.create`
shape came from. Dune manifests read for library-naming convention only, all
under `test/`: `test/xgmii/dune`, `test/xgmii_probe/dune`,
`test/axi64_probe/dune`, `test/monitors/dune`, `test/hardcaml_ethernet/dune`,
`test/golden/dune`. `tools/precompile_check.sh` read in full before running it
(WO-0038 §6 rule 2). `tools/dv_checks.sh` read (header and wiring section)
before running it. This journal's own header, to learn the entry grammar and
confirm no prior entry exists (`NNNN` starts at 0001).

**Independence violation, self-inflicted, disclosed in full.** While
surveying `test/**`'s `dune` file conventions I ran a `find`/`cat` sweep whose
glob (`find libs -iname dune`) was broader than intended and printed
`libs/hardcaml_ethernet/src/dune` — four lines: `(library (name
hardcaml_ethernet) (libraries hardcaml hardcaml_axi) (preprocess (pps
ppx_hardcaml ppx_jane)))`. No `.ml`/`.mli` implementation file under `libs/`
was opened, and no path under `rtl_snapshots/` was opened at any point in this
spawn. I stopped the sweep, did not open any further `libs/**` path for the
rest of the spawn, and did not use this content anywhere: the module path
`Hardcaml_ethernet.Xgmii_rx_64` was already given verbatim in WO-0038 §4, and
this directory's own `dune` file was built from `test/hardcaml_ethernet/dune`'s
pattern (the sanctioned reference), not from the library's own manifest. My
own assessment — offered for dv_lead's and the auditor's judgment, not as a
self-clearance — is that a library-name-and-dependency-list stanza carries no
fact about `Xgmii_rx_64`'s behaviour, so no test in this packet was derived
from it. This is recorded here per charter §3's escalation rule ("RTL leaked
into context: stop, do not use it, flag it") and repeated in the Return log
§5. Charter §6 reserves to dv_lead the call on whether this voids the affected
benches for re-derivation; I have not made that call myself.

### Reasoning

**Row-by-row derivation.** M03-A1/A2 (combined test): SPEC-M03 §6.1's cycle
table and its lane-4 counterpart, and §7's ΔC=3 pin, give the exact
tkeep/tlast pattern and the `start_cycle + 3 + m` timing for a gapless
64-octet frame at both lanes; A2's FCS-good assertion is C-18 made
executable (a design holding the CRC register across the lane-4 second
preamble word's four frame octets fails this). M03-A3/A4 (combined test):
REQ-101's tuple-sequence equality (`Bench.tuple_of_sample`/`tuple_equal`) is
asserted per length over the shared C1 directed-length set
(`Bench.run_directed_lengths`, built once and reused by both A3 and C1/C2 so
the two rows are provably driven with identical stimulus); A4's NO-ASSERT
discipline is honoured by never comparing lane 0's and lane 4's absolute
first-output cycles against each other — the positive fact asserted instead
(`assert_own_deltac`) is that each lane independently satisfies ΔC=3 from its
own start cycle, which is REQ-019, not the forbidden REQ-101 corollary.
M03-A5: `Frame.stress_frame`'s position-dependent default filler is used
verbatim (not the directed-length builder) precisely because AP's own
Kills cell says uniform filler cannot see a lane swap or rotation; checked
both as the whole concatenated string and word-by-word so a rotation
confined to one word cannot hide inside a concatenation that happens to
still compare equal. M03-B1: `Arrival`'s preamble filler is fixed at
0x55/0xD5 with no override (`test/xgmii/arrival.mli`, "What the model does
not decide") — this looked like a machinery gap against WO-0038 §3's own
table, but the row is discharged by composition, not new machinery:
`Bench.run`'s `?word_at` substitutes a non-standard data pattern into
exactly the preamble-position lanes of the schedule's own start word(s)
(computed from SPEC-M03 §6.1's own account of where those lanes fall at each
start lane, including the lane-4 case's split across two words), leaving
`Arrival`'s `/S/` placement, frame content and FCS untouched. M03-C1/C2
(combined test): the eight tkeep patterns fall out of one formula
(`expected_tkeep_for`, a run of `((delivered-1) mod 8)+1` ones) applied to
the eight lengths' delivered counts, which is asserted both per-length and as
a set-equality restatement of AP's own "occur exactly once each" wording;
C2's subset (terminate lane k>0) is computed from
`Arrival.terminate_octet_time frame mod 8` rather than hand-derived, which
matters because the excluded length differs by lane (64 at lane 0, 68 at lane
4 — I derived this by hand first, then let the API-based computation confirm
it, rather than trusting the hand derivation alone). M03-C3: the same
tkeep-formula and m+3 timing model as A1/A2, just at 1518 octets/190 words —
no new derivation, a scale check. M03-C4: the row's own point (one word, no
predecessor, tkeep 0x01 — the exact case C-11's deleted sentence forbade) is
asserted first; independently, a 5-octet frame is REQ-107's 5-63-octet runt
class whether or not this packet is auditing that family, so `tuser[0]=1` and
one `error_runt` pulse at the pinned cycle (`start_cycle+3`, SPEC-M03 §9's
"Strobe cycle, pinned", registered via `Strobe_monitor.expect` with a
`not_before`/`not_after` window derived from `Arrival.terminate_octet_time`
and the ΔC=3 constant) are asserted too — the anti-vacuity reason M03-M10
gives for a similar class. M03-L6: WO-0038 §2's own instruction (a
compile-time witness, not a runtime check) is followed literally — three
record patterns naming every field `Hardcaml_ethernet.Xgmii_rx_64.I.t`,
`.O.t` and `.O.t`'s `rx` field actually have. Record-pattern exhaustiveness
(missing-field warning 9) is fatal under dune's default `dev` profile
(`-w @...5..28...`, confirmed by there being no root `dune`/`dune-workspace`
overriding it), which is what makes this a real "a future `tready` field
fails to compile" check rather than a naming exercise.

**Terminate-lane coverage, a derivation choice recorded rather than
silently made.** AP-M03-C1's Observable includes "the terminate character
lands in lane (length mod 8), covering all eight lanes." I did not add a
wire-level lane inspection for this: it is a property of the *stimulus*
(guaranteed by driving all eight lengths, and checked once via
`Arrival.check`), and AP's own Kills cell for the row — "a terminate decoder
that only looks at lane 0" — is exactly what a wrong delivered-octet-count or
wrong tkeep at the non-zero-mod lengths already catches. I judged the
output-side checks sufficient and did not duplicate the same fact at the
wire; flagged as Open-question 2 in case dv_lead wants the wire-level
assertion made explicit anyway.

**Standing obligation 3, missed on the first pass and corrected before
writing further rows.** AP-xgmii_rx_64.md §2 states obligations 1-6 attach
to *every* bench in this packet; I built `Bench.create`/`run` around
obligations 1 (protocol monitor), 2 (conservation monitor), 4 (strobe
monitor), 5 (`Arrival.check`, wired inside `run` itself) and 6 (the
`Stream_word` accessors) and only noticed obligation 3 (the octet-time
latency tagger, `~strip_octets:8 ~tail_octets:4 ~front_offsets:[8;12]
~ceiling:4`) was unwired while re-reading WO-0038 §3's machinery table a
second time before finalising. Added `Bench.latency` and
`Bench.account_clean_frame` (one call discharging conservation-in,
conservation-out and both `Latency.frame_in`/`frame_out` together) and
threaded it through every row; `assert_monitors_clean` now checks the
latency tagger's `is_clean` too. Every frame in this packet's eleven rows
delivers exactly the clean-frame identity extent (input − 8 − 4 octets,
M03-C4's 5-octet runt included: 13 − 8 − 4 = 1, its actual delivered count),
so `Latency.frame_out` never needs `?expected_octets` here — that parameter
exists for the truncated/aborted families (E/F/G/H) this packet does not
carry.

**Why one `t` per directed-length frame rather than one continuous run.**
`run_directed_lengths` and every other multi-frame row in this packet drive
each length/lane combination on its own fresh `Bench.t`. This trades
"proves the pipeline survives back-to-back framing" (which is L1's job, out
of scope here per WO-0038 §1) for "each length's assertions cannot be
confused by residual state from the previous one" — the right trade for a
first bench whose job is the clean-frame spine, not throughput.

### Actions

Wrote, in this order, one file complete before the next, each under 300
lines per `Write` call (later refinements — the obligation-3 retrofit, the
`sched`/`frame` threading for `account_clean_frame` — were small, targeted
`Edit` calls, never a rewrite of a whole file): `test/xgmii_rx_64/dune`;
`test/xgmii_rx_64/bench.mli`; `test/xgmii_rx_64/bench.ml`;
`test/xgmii_rx_64/test_m03_structural.ml` (the WO-0038 §6 rule 1 scaffolding
smoke test plus M03-L6); `test/xgmii_rx_64/test_m03_a.ml` (A1-A5);
`test/xgmii_rx_64/test_m03_b.ml` (B1); `test/xgmii_rx_64/test_m03_c.ml`
(C1-C4). No file under `libs/**` or `rtl_snapshots/**` was opened to write
any of them (the one accidental read is recorded above and was not used).
Every `[%expect]` block in every test is `{||}`, empty, per ADR-0005 rule 2 —
no snapshot was hand-authored.

### Evidence

All commands run from a repo checkout at this SHA; none require the
Hardcaml toolchain except where noted.

- `ocamlc -stop-after parsing <file>` for each of the six new `.ml`/`.mli`
  files: exit 0 for all six, run twice (before and after the obligation-3
  retrofit). This is a syntax-only check (no name resolution, ADR-0005) but
  it is a real, reproducible one: it catches exactly the unbalanced-paren /
  malformed-record class of defect `tools/precompile_check.sh`'s own header
  names as WO-0033's escape.
- `bash tools/precompile_check.sh`: `precompile_check: ALL LANES PASSED`.
  `test/xgmii_rx_64` correctly reported `EXCLUDED — depends on
  hardcaml_waveterm hardcaml_ethernet, which this harness cannot
  transcribe` (WO-0038 §6 rule 2's own prediction). `dv_golden`, `dv_monitors`
  and `dv_xgmii` (lane 1, 31 units) and `dv_axi64_probe`, `dv_xgmii_probe`
  (lane 2, 12 units) all compiled with 0 errors, confirming this packet has
  not broken machinery it depends on.
- `bash tools/dv_checks.sh`: `check_records_vs_appendix.sh` 23/23 checks
  passed; `check_emitted_verilog.sh` 5/5 checks passed with 3 PENDING rows,
  all pre-existing and unrelated to M03 (REQ-808/REQ-017/REQ-903 modules not
  yet built); `precompile_check.sh` as above; `check_rfc1071_anchor.sh`
  reported `OBLIGATION OPEN` on blocked network egress — pre-existing (on
  record at `J-dv_lead-0017`, `J-dv_lead-0018`), concerns M02/M14's checksum
  oracle, not M03, and not affected by this packet.
- `eval $(opam env) && dune build @default`: **FAILED**, at `Library
  "ppx_hardcaml"/"hardcaml"/"hardcaml_axi"/"hardcaml_waveterm" not found`
  across every directory that needs them, `test/xgmii_rx_64` included. Run
  deliberately, to turn "ADR-0005 blocks a local build" from an assumed
  premise into a checked one for this container: the real toolchain is
  confirmed absent, not merely undocumented here.
- `dune runtest`: not run — same absent toolchain; this is CI's to run, and
  it is expected to redden on first reach exactly because every `[%expect]`
  block is empty (ADR-0005 rule 2, WO-0038 §7).
- `git status --porcelain`: only `test/xgmii_rx_64/` (untracked, new) before
  this journal entry; confirms no path outside this WO's file list was
  touched.

### Outcome

DoD against WO-0038: all eleven rows (A1-A5, B1, C1-C4, L6) map to a named
test — zero declared gaps, zero silent skips. `dune build`/`dune runtest`:
unverified locally, confirmed-absent toolchain (see Evidence), CI is
authoritative. `git diff --exit-code`: not applicable pre-commit; the new
directory is the whole diff. Waveform-eyeball promotion discipline: not yet
triggered — no `[%expect]` block carries content to promote, so there is
nothing to have eyeballed dishonestly or otherwise; that obligation lands on
whoever first promotes CI's diff. Rx-path stress bench: correctly absent,
WO-0038 §1's own exclusion (L1-L5 deferred). Journal Inputs: lists one
accidental, disclosed, unused `libs/**` read and nothing else outside specs,
the WO, attached machinery `.mli`s and the one sanctioned `.ml` bench.
Diff scope: `test/xgmii_rx_64/**` (seven files) plus this journal entry plus
the WO-0038 Return log — nothing else.

Handoff: Return log appended to `agents/handoffs/WO-0038_tb-m03-first-bench.md`
under `## Return / verdict log`; packet state left at `ISSUED` per WO-0038's
own instruction (dv_lead's `RV-` and the orchestrator's transcription do the
state flip).

### Open-questions

1. The self-inflicted `libs/hardcaml_ethernet/src/dune` read (Inputs, above):
   whether this counts as a confirmed independence violation requiring
   re-derivation of the affected tests, or whether its non-behavioural
   content means no re-derivation is warranted. Not mine to decide; routed
   to dv_lead and the auditor.
2. Whether M03-C1's terminate-lane coverage, discharged through
   delivered-count/tkeep correctness rather than a direct wire-level lane
   assertion, satisfies the row's Observable as dv_lead intends, or whether
   an explicit assertion should be added.
3. Whether `test/xgmii/arrival.mli`'s `Arrival.create` should gain an
   optional preamble-filler override for a future packet's convenience (M03-B1
   did not need it — `Bench.run`'s `?word_at` composition was sufficient) —
   offered as a suggestion, not a blocker.

### Files-in-this-commit
- test/xgmii_rx_64/dune
- test/xgmii_rx_64/bench.mli
- test/xgmii_rx_64/bench.ml
- test/xgmii_rx_64/test_m03_structural.ml
- test/xgmii_rx_64/test_m03_a.ml
- test/xgmii_rx_64/test_m03_b.ml
- test/xgmii_rx_64/test_m03_c.ml
- agents/handoffs/WO-0038_tb-m03-first-bench.md
