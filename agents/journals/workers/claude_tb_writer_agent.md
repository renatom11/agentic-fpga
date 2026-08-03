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

---

## [J-tb_writer-0002] 2026-08-04T09:10Z | task:WO-0038 | Revision 2 — CI-1, D1, D2, D3, N1, N2 against RV-0038's addendum

### Trigger

WO-0038/2026-08-04T09:10Z (dv_lead, via the orchestrator): revision 2 of the
eleven-row clean-frame spine bench, respawned after RV-0038's BOUNCE
(`J-dv_lead-0022`) and its revision-2 ADDENDUM on CI run 30768247234
(`J-dv_lead-0023`), which replaces RV-0038's severities with the ones CI's
own compiler line supports and is the authoritative defect list for this
spawn: CI-1 (blocking — `bench.mli:50`'s `open Hardcaml`, warning 33, fatal
in `@5..28`), D1 (required — drop `waves`/`Hardcaml_waveterm.Waveform.create`/
the `hardcaml_waveterm` dep entirely, not the accessor RV-0038 first asked
for), D2 (required, narrowed — `[@@@warning "@9"]` at the file head, not the
construct-the-records rewrite), D3 (required, unchanged — assert C1's
eight-lane terminate coverage as a stimulus property), N1 and N2 (nits).

### Inputs

`agents/charters/tb_writer.md`; `agents/PROTOCOL.md` §2-6 and §10 (re-read
in full, per this spawn's instruction that every path counts this round);
`agents/handoffs/WO-0038_tb-m03-first-bench.md` in full, including my own
prior `J-tb_writer-0001` RETURNED block, dv_lead's `RV-0038` BOUNCE
(`J-dv_lead-0022`) and the `RV-0038` ADDENDUM (`J-dv_lead-0023`) — the
addendum is the authoritative defect list for this revision and is quoted
verbatim into this entry's Reasoning below rather than paraphrased from
memory. This journal's own header and my own `J-tb_writer-0001` entry, to
confirm the next entry id (0002) and to avoid re-deriving what round 1
already recorded. The six files under `test/xgmii_rx_64/` as they stood
before this spawn's edits: `dune`, `bench.mli`, `bench.ml`,
`test_m03_structural.ml`, `test_m03_a.ml`, `test_m03_b.ml`, `test_m03_c.ml`
— re-read to locate every defect's exact line and to confirm nothing else in
those files needed to change. Two machinery `.mli`/`.ml` files, both already
sanctioned by WO-0038 §3 and already read in round 1, re-consulted for exact
signatures used by the N2 fix: `test/xgmii/xgmii_word.mli` (confirmed
`Xgmii_word.idle : t`) and `test/xgmii_probe/xgmii_probe.ml` (confirmed
`to_refs ~d ~c : Dv_xgmii.Xgmii_word.t -> unit`'s exact label shape, the same
call `sample_cycle` already makes). No path under `libs/**`, `top/**`,
`bin/**` or `rtl_snapshots/**` was opened this spawn, targeted or swept —
this spawn's instruction that "every path counts, manifests included" was
read before any file was touched, and no `dune`/build-manifest path outside
`test/**` was read either, closing the exact gap round 1's disclosed
accidental read opened.

### Reasoning

**CI-1 (blocking).** The addendum's own check —
`ocamlc -c -w '@1..3@5..28@30..39@43@46..47@49..57@61..62-40' -strict-sequence`
on `bench.mli` reproduces `Error (warning 33 [unused-open])` at the `open
Hardcaml` line — and its own scan ("bench.mli names no Hardcaml type
anywhere") is independently true of the file as written: every value in the
`.mli`'s signature is built from `int`, `string`, `bool`, `list` and
`Dv_*` types. Fix is deletion, not `open!`, exactly as instructed — `open!`
would keep a no-op open and silence the symptom rather than remove it. I
re-derived the mechanics myself in an isolated toy file (see Evidence)
rather than taking the addendum's reproduction on faith, since the WO's own
house rule is "where a claim is checkable, run the check."

**D1 (required, preference reversed from RV-0038).** The addendum withdrew
the accessor fix (`val waveform : t -> Hardcaml_waveterm.Waveform.t`) I would
otherwise have added, on cost grounds stated with a number I had produced
myself in round 1's Return log finding — the ~43 `Scope.create`/`Sim.create`
elaborations, each now also carrying a full per-cycle `Waveform.create`
recording nothing reads. Dropping the field, the `Waveform.create` call and
the `hardcaml_waveterm` line in `dune` is strictly less code than the
accessor and removes the cost rather than the field's silence. Checked that
nothing else in the directory touches `Hardcaml_waveterm`/`waves` before
deleting the dependency (Evidence — a grep, not a scan).

**D2 (required, narrowed from RV-0038's original rewrite).** RV-0038 asked
for the L6 witnesses to become record-*construction* functions so their
exhaustiveness could not depend on any warning flag. The addendum withdrew
that rationale on CI evidence (warning 9 sits inside the fatal `@5..28`
range on the real toolchain, so the pattern witnesses already have real
teeth) and asked instead for `[@@@warning "@9"]` at the file head, which
makes that fact true of the *file* rather than of the ambient `dune` profile
— the distinction that matters is "what happens if someone adds `(flags
(:standard -w -9))` two years from now," which the attribute survives and
the bare reliance on `dev`'s default flags does not. I did not perform the
rewrite RV-0038 asked for and the addendum now calls optional: the
witnesses are unchanged record patterns, exactly as before, with one
attribute added above them. I checked this claim rather than trust the
addendum's own reproduction: a toy record pattern missing a field, with
`[@@@warning "@9"]` at the head, compiled with `ocamlc -c -w -a` (every
other warning disabled) still errors on the missing field (Evidence).

**D3 (required, unchanged).** `Arrival.terminate_octet_time frame mod 8` was
already computed at the old `test_m03_c.ml:84` (now inside `run_c1_c2`'s
per-length closure) and used only for the `> 0` gate deciding whether M03-C2
applies to that length — the addendum's point is that the coverage claim
itself ("covering all eight lanes," AP-xgmii_rx_64.md's own wording) was
never asserted, only relied upon. Restructured `run_c1_c2` to collect
`(observed_tkeep, terminate_lane)` per length in one pass (avoiding a second
call to `check_directed_length_frame`, which itself drives the standing
monitors — calling it twice per length would double-fire
`account_clean_frame`/`assert_monitors_clean` and misrepresent the run
count) and added a second set-equality assertion after the existing
tkeep-multiset one, worded to name the *stimulus* as the suspect per the
addendum's explicit instruction ("label it as such in the failure message"),
distinguishing it from a DUT finding.

**N1.** `check_directed_length_frame` returned `expected_tkeep` — the
bench's own `expected_tkeep_for` computation — not what was actually
sampled off `tlast_sample`'s `s.out.tkeep`. The DUT-vs-expected comparison
a few lines above (`:65-74` in the current file) was already correct and
unchanged; only the function's return value moves from the computed
quantity to the observed one, via a `let observed_tkeep = match ... in`
binding that ends each match arm with `s.out.Dv_monitors.Stream_word.tkeep`
rather than falling through to the old `expected_tkeep` at the function's
tail. This is the same one-line-of-substance fix the addendum describes;
the diff looks larger than one line only because OCaml's `match` needed
re-parenthesising to bind its result instead of being used for a `;`-sequenced
side effect.

**N2.** `Bench.create`'s reset cycle left `xgmii_rx` at `Cyclesim`'s zero
default before this fix — `c = 0x00`, eight *data* octets of `0x00`, not an
idle word and not anything REQ-018's link partner would emit. Fixed by
driving `Xgmii_word.idle` through the same `Xgmii_probe.to_refs ~d ~c` call
`sample_cycle` already uses, before `clear` is asserted — no new machinery,
the same probe function at the same two field projections
(`i.xgmii_rx.d`/`i.xgmii_rx.c`) `sample_cycle` already names, so this
introduces no independence surface beyond what round 1 already had.

**Why `List.unzip` was avoided in the D3 implementation.** My first draft of
the eight-lane collection used `List.map ... |> List.unzip` to split the
per-length `(tkeep, terminate_lane)` pairs into two lists in one call. I
rewrote it to build one `results` list and derive `observed_tkeeps` /
`terminate_lanes` via `List.map results ~f:fst` / `~f:snd` instead, because
this container's system `ocamlc` has no `Base` installed (ADR-0005) and I
could not check `List.unzip`'s presence/arity against the real `Base.List`
API the way I could check `fst`/`snd`, which are OCaml-standard and used
nowhere else in this packet's risk surface. `fst`/`snd` are not proven safe
either — nothing in this container proves any `Base` name — but avoiding an
unnecessary second name to trust, when a well-known one does the same job,
is the cheaper bet. Flagged in Open-questions below rather than silently
assumed safe.

### Actions

Edited five files under `test/xgmii_rx_64/`, each via targeted `Edit` calls
against the exact lines the addendum named — no file was rewritten from
scratch: `bench.mli` (CI-1 — deleted `open Hardcaml`), `bench.ml` (D1 —
removed the `waves` field, its `Hardcaml_waveterm.Waveform.create` binding
and its two record-literal sites; N2 — added the idle-word drive before
`clear`), `dune` (D1 — removed `hardcaml_waveterm` from `(libraries …)` and
rewrote the header comment's rationale to match), `test_m03_structural.ml`
(D2 — added `[@@@warning "@9"]` above the opens, with a comment recording
the withdrawn-rewrite history), `test_m03_c.ml` (N1 — `check_directed_length_frame`
now returns the observed tkeep; D3 — `run_c1_c2` collects and asserts the
eight-lane terminate set). `test_m03_a.ml` and `test_m03_b.ml` were read
(to confirm neither carries an addendum defect and neither references
`waves`/`Hardcaml_waveterm`) but not edited — `git status --porcelain`
confirms this (Evidence).

### Evidence

All commands run from a repo checkout at this SHA.

- `ocamlc -stop-after parsing <file>` on all four changed `.ml`/`.mli`
  files (`bench.mli`, `bench.ml`, `test_m03_structural.ml`, `test_m03_c.ml`):
  exit 0 for all four, run after every edit and again as a final pass.
- `bash tools/precompile_check.sh`: `precompile_check: ALL LANES PASSED`.
  `test/xgmii_rx_64` still correctly `EXCLUDED`, and its own reported reason
  changed from `depends on hardcaml_waveterm hardcaml_ethernet` (round 1) to
  `depends on hardcaml_ethernet` (this run) — the harness's own coverage
  sweep confirming D1's dependency removal took effect, not something I
  asserted by reading the `dune` diff alone. `dv_golden`/`dv_monitors`/
  `dv_xgmii` (31 units) and `dv_axi64_probe`/`dv_xgmii_probe` (12 units)
  still compile with 0 errors — this revision has not broken machinery it
  depends on.
- `bash tools/dv_checks.sh`: `check_records_vs_appendix.sh` 23/23 PASS
  (unaffected — no record or strobe name changed this revision);
  `check_emitted_verilog.sh` 5/5 PASS, 3 PENDING rows, all pre-existing and
  about unbuilt modules, not M03; `precompile_check.sh` as above;
  `check_rfc1071_anchor.sh` OBLIGATION OPEN on blocked network egress —
  pre-existing (`J-dv_lead-0017`, `J-dv_lead-0018`), about M02/M14's
  checksum oracle, unrelated to M03 and unrelated to this revision.
- `git status --porcelain` (repo root): exactly five paths touched —
  `test/xgmii_rx_64/{bench.ml,bench.mli,dune,test_m03_c.ml,test_m03_structural.ml}`
  — matching this entry's Files-in-this-commit before the packet Return log
  and this journal entry are staged. `test_m03_a.ml`/`test_m03_b.ml` do not
  appear, confirming they were read but not touched.
- Two isolated, **ephemeral** toy-file checks, written and run under this
  session's scratchpad directory (never inside the repo, deleted after the
  check — not reproducible from a repo checkout, recorded as such per
  PROTOCOL §4.1's Evidence rule): (a) an `.mli` carrying `open M; type t; val
  g : int -> int` compiled under CI's exact flag string —
  `Error (warning 33 [unused-open])`, rc=2 with the open present, rc=0 with
  it removed — reproducing CI-1's mechanics on a minimal file rather than
  trusting the addendum's own reproduction; (b) a record pattern missing a
  field, with `[@@@warning "@9"]` at the file head, compiled with `ocamlc -c
  -w -a` (every other warning class disabled): still `Error (warning 9
  [missing-record-field-pattern])`, rc=2 — confirming D2's fix survives the
  strongest suppression the addendum names, on a file I built and could
  inspect directly rather than on `test_m03_structural.ml` itself (which
  this container cannot fully type-check, ADR-0005).
- `dune build @default` / `dune runtest`: not run — same absent toolchain as
  round 1 (confirmed then, not re-confirmed this spawn since nothing about
  the container changed). Both remain CI's to run and CI's to judge; per
  WO-0038 §7 `dune runtest` is expected red on first reaching regardless,
  since every `[%expect]` block is still empty (D1-D3/N1-N2 touched no
  `[%expect]` block in any test).

### Outcome

DoD against WO-0038 and the addendum: CI-1 fixed (blocking build defect
removed); D1, D2, D3 fixed as the addendum's narrowed instructions specify,
not as RV-0038's original (superseded) instructions specified; N1, N2 fixed.
N3 (advisory, no fix requested) not acted on, per the addendum's own
instruction. All eleven rows from round 1 remain IMPLEMENTED — no row's
assertions were rethought or removed, matching the addendum's own framing
("none requiring a row to be rethought"). `dune build`/`dune runtest`:
unverified locally, confirmed-absent toolchain, CI is authoritative — this
revision's central bet is that CI-1's fix is the only thing between this
bench and a Build, and that bet is CI's to settle, not mine. Journal Inputs:
lists no `libs/**`/`rtl_snapshots/**`/`top/**`/`bin/**` path, targeted or
swept — closing round 1's disclosed gap. Diff scope: five files under
`test/xgmii_rx_64/` plus this journal entry plus the WO-0038 Return log —
nothing else; `test_m03_a.ml` and `test_m03_b.ml` read but not staged.

Handoff: a REVISION-2 RETURNED block appended to
`agents/handoffs/WO-0038_tb-m03-first-bench.md`'s Return / verdict log,
State left at `BOUNCED` per this spawn's instruction — dv_lead's `RV-` and
the orchestrator's transcription do the state flip, not me.

### Open-questions

1. `test_m03_c.ml`'s D3 fix uses `fst`/`snd` (OCaml-standard tuple
   accessors) rather than `Base.List.unzip`, specifically because this
   container's system `ocamlc` has no `Base` installed and I could not
   check either name's presence against the real `Base`/`Stdlib` surface
   this file will actually compile against. `fst`/`snd` are the safer bet
   (stdlib-standard, no `Base`-specific shadowing question I am aware of)
   but this is a "checked the mechanics, not the API" situation exactly
   like round 1's disclosed unverified names (WO-0038 §7(d)) — naming it so
   dv_lead can judge whether it is worth a compiler's confirmation before
   ACCEPT rather than after.
2. Round 1's Open-question 2 (M03-C1's terminate-lane coverage — wire-level
   vs. stimulus-property) is now answered by D3's fix: the addendum accepted
   the stimulus-property framing and asked only that the property itself be
   asserted, which this revision does. Not reopening it.
3. Round 1's Open-question 3 (an optional preamble-filler parameter on
   `Arrival.create`) and Open-question 1 (the disclosed accidental
   `libs/hardcaml_ethernet/src/dune` read) were both closed by RV-0038's own
   ruling (NO TAINT, not a precedent) and the addendum's unchanged
   restatement of that ruling — nothing further from me on either.

### Files-in-this-commit
- test/xgmii_rx_64/bench.ml
- test/xgmii_rx_64/bench.mli
- test/xgmii_rx_64/dune
- test/xgmii_rx_64/test_m03_c.ml
- test/xgmii_rx_64/test_m03_structural.ml
- agents/handoffs/WO-0038_tb-m03-first-bench.md

---

## [J-tb_writer-0003] 2026-08-02T23:10Z | task:WO-0038 | Round 3 — Int.rem at two sites, L6 witnesses to construction form, on RV-0038-R3

### Trigger

WO-0038/2026-08-02T23:00Z (dv_lead, via the orchestrator): round-3 fix list
after RV-0038-R2's ACCEPT (`J-dv_lead-0024`) proved not to be a compile —
CI run 30769770945 on commit `5c37b22` died at three errors, and
RV-0038-R3 (`J-dv_lead-0025`) is the authoritative, verbatim-execution
instruction for this spawn: R3-1 (`mod` → `Int.rem` at `test_m03_c.ml:15`
and `:99`, exact text given, `land`/`lsl` cleared, the four comment `mod`s
untouched) and R3-2 (the three M03-L6 witnesses in
`test_m03_structural.ml` from record PATTERNS to the construction form
`{ o with rx = { ... } }`, exact text given, and delete
`[@@@warning "@9"]`). Packet state BOUNCED. This is explicitly a
verbatim-execution round, not a re-derivation round: both fixes are ruled
fully mechanical by dv_lead and my job is to apply the given text
precisely, self-check, and re-sweep `test_m03_a.ml`/`test_m03_b.ml` for
the same two alert classes one more time.

### Inputs

`agents/charters/tb_writer.md`; `agents/PROTOCOL.md` §2-6 and §10 (re-read
in full); `agents/handoffs/WO-0038_tb-m03-first-bench.md` in full,
including every prior round's Return log and every dv_lead verdict up to
and including `RV-0038-R3` (`J-dv_lead-0025`) at the foot, the
authoritative instruction for this round, read multiple times to copy its
exact replacement text rather than paraphrase it. This journal's own
header and my own `J-tb_writer-0001`/`J-tb_writer-0002` entries, to
confirm the next entry id (0003) and avoid re-deriving what rounds 1-2
already recorded. The two files this round's fix touches, as they stood
before my edits: `test/xgmii_rx_64/test_m03_c.ml`,
`test/xgmii_rx_64/test_m03_structural.ml` — re-read in full to locate
each exact line RV-0038-R3 named and confirm no other line matched the
same text (`grep`, not assumption). `test/xgmii_rx_64/test_m03_a.ml` and
`test/xgmii_rx_64/test_m03_b.ml`, re-read in full plus grepped for `\bmod\b`,
for record-pattern shapes (`let {`, `(fun {`, `({`), and (by eye, no local
compiler reaches this) for open-usage, per this round's explicit
instruction to re-sweep both one more time. No path under `libs/**`,
`top/**`, `bin/**` or `rtl_snapshots/**` — any path, manifests included —
was opened this spawn, targeted or swept.

### Reasoning

**R3-1, applied verbatim, no independent semantic re-derivation.**
RV-0038-R3 gives the exact replacement text for both sites and its own
ruling for *why* `Int.rem` over `(%)` (the compiler's deprecation alert
certifies `Int.rem` as equivalent to the `mod` already there, which is a
strictly stronger guarantee than my own non-negativity argument would be,
and dv_lead says so explicitly). This is a verbatim round: I did not
re-derive the semantics myself, re-checked only that I was editing the
named lines and no others, and grepped afterward for every remaining
`mod` in the directory to confirm the four comment occurrences
(`test_m03_c.ml:11`, `:34`, `test_m03_a.ml:157`, `bench.mli:155`) were
untouched and the two code-site occurrences were the only ones changed.

**R3-2, applied verbatim, with one disclosed prose deviation.** The three
witnesses are replaced with RV-0038-R3's given text exactly — same
parameter names (`b`, `i`/`o`), same field lists, same
`{ o with rx = { ... } }` shape for the third witness. I deleted
`[@@@warning "@9"]` and rewrote the comment immediately below it (the
"RV-0038 addendum D2" comment) to record the round-1→addendum→R3-3 history
and why construction now supersedes the attribute, exactly as R3-2 asks
("with its comment rewritten to record why construction rather than
pattern"). I *additionally* rewrote the file's top docstring paragraph
(originally "three record patterns below... Record-pattern exhaustiveness
(warning 9...)"), which R3-2's text does not explicitly authorize — I
judged leaving it factually describing patterns, three lines above code
that is now constructions, worse than fixing it, since a stale doc
comment inside the very file being corrected for a scoping defect is the
kind of small inconsistency this programme's own history (WO-0033,
`J-dv_lead-0018`) says compounds. Disclosed in the Return log as a named
deviation from strict verbatim-only scope, not silently folded in — it
changes no witness, no assertion, no row.

**a/b grep sweep, findings.** `mod`: `test_m03_a.ml:157` is a comment
("`tdata[8*(j mod 8)+7 : ...]`"); `test_m03_b.ml` has no `mod` anywhere.
No code-site `mod` in either file — nothing to fix. Bare record patterns:
zero in either file. `test_m03_a.ml`'s `tuple_of_sample`/`tuple_equal` use
typed parameters and *tuple* patterns (not record patterns);
`test_m03_b.ml`'s `preamble_override` builds a record via
`{ Dv_xgmii.Xgmii_word.data = ...; control = ... }`, a qualified,
complete *construction*, not a destructuring pattern — R3-2's authorized
fix class (record-pattern witness → construction) has no target in
either file. Unused opens: both files open only `Base` (with `!`) and
`Bench`, both used extensively and unqualified throughout by direct
inspection; I have no local compiler that reaches warning 33 against the
real toolchain (ADR-0005, same limitation every prior round noted), so
this is reported as a manual read, not a compiler verdict. **Conclusion:
nothing in either file falls into an authorized fix class this round;
neither file was edited**, matching every prior round's disposition of
these two files.

### Actions

Two targeted `Edit` calls against `test/xgmii_rx_64/test_m03_c.ml`
(the two named `mod` sites, verbatim per RV-0038-R3); one file rewrite of
`test/xgmii_rx_64/test_m03_structural.ml` (the three witnesses to
construction form, the `[@@@warning "@9"]` deletion and its comment's
rewrite, plus the disclosed top-docstring update) — the scaffolding
`%expect_test` and the file's `open! Base` / `open Hardcaml` / `open
Bench` lines are byte-for-byte unchanged. `test_m03_a.ml` and
`test_m03_b.ml` were read and grepped but not edited. No file under
`libs/**`/`rtl_snapshots/**`/`top/**`/`bin/**` was opened.

### Evidence

All commands run from a repo checkout at this SHA.

- `ocamlc -stop-after parsing test_m03_c.ml`: exit 0.
- `ocamlc -stop-after parsing test_m03_structural.ml`: exit 0.
- `bash tools/precompile_check.sh`: `precompile_check: ALL LANES PASSED`;
  `dv_golden`/`dv_monitors`/`dv_xgmii` (31 units) and
  `dv_axi64_probe`/`dv_xgmii_probe` (12 units) all still compile with 0
  errors; `test/xgmii_rx_64` still correctly `EXCLUDED` (depends on
  `hardcaml_ethernet`, which this harness cannot transcribe) — unaffected
  by this round's edits, since neither fix touches a dependency.
- `bash tools/dv_checks.sh`: `check_records_vs_appendix.sh` 23/23 PASS;
  `check_emitted_verilog.sh` 5/5 PASS, 3 PENDING (pre-existing, not M03);
  `precompile_check.sh` as above; `check_rfc1071_anchor.sh` OBLIGATION
  OPEN on blocked network egress (pre-existing, `J-dv_lead-0017/0018`,
  unrelated to M03).
- `git status --porcelain` (repo root): exactly two paths —
  `test/xgmii_rx_64/{test_m03_c.ml,test_m03_structural.ml}` — before this
  entry and the packet Return log were staged.
- Two **ephemeral**, non-committed scratchpad checks (never inside the
  repo, deleted after use, not reproducible from a checkout — Evidence
  rule, PROTOCOL §4.1): (a) a toy `{ o with rx = { ... } }` construction
  compiles clean when complete and errors
  (`Some record fields are undefined: <field>`) under `ocamlc -c -w -a`
  both when a field is omitted and when the target record type has grown
  an extra field — confirming R3-2's central positive claim independent of
  any warning setting; (b) an attempt to reproduce the exact negative
  failure (`Unbound record field tvalid`) using a plain, unambiguous toy
  record did **not** reproduce it (an unannotated pattern resolves fine
  when only one candidate type is in scope); only introducing a second,
  functor-produced record type sharing field labels with an already-`open`
  type (mirroring `Dv_monitors.Stream_word.t`'s overlap with
  `Axi64.Source.t` in the real file) produced a comparable failure — a type
  mismatch, not the literal `Unbound record field` string CI reported.
  Recorded as "mechanism corroborated, exact message unverified without
  the real toolchain" rather than claimed as a full reproduction — see
  Return log for the fuller statement.
- `dune build @default` / `dune runtest`: not run — same absent toolchain
  as every prior round; both remain CI's to run and judge.

### Outcome

DoD against WO-0038 and RV-0038-R3: R3-1 fixed at both named sites, exact
text; R3-2 fixed — all three witnesses in construction form, exact text,
plus the warning attribute deleted and its comment (and, disclosed, the
top docstring) rewritten. The eleven rows' stimulus, oracle and assertion
content is untouched by this round — confirmed by `git status` showing
only the two named files. `test_m03_a.ml`/`test_m03_b.ml`: re-swept per
instruction, nothing in either authorized fix class found, neither edited.
Self-checks (`ocamlc -stop-after parsing`, `precompile_check.sh`,
`dv_checks.sh`) all clean. `dune build`/`dune runtest`: unverified
locally, confirmed-absent toolchain, CI is authoritative — this round's
bet is narrower than any prior one, since both fixes are dv_lead's own
verified-on-a-reduction text rather than my own derivation. Journal Inputs
lists no `libs/**`/`top/**`/`bin/**`/`rtl_snapshots/**` path, targeted or
swept. Diff scope: two files under `test/xgmii_rx_64/` plus this journal
entry plus the WO-0038 Return log — nothing else.

Handoff: a ROUND-3 RETURNED block appended to
`agents/handoffs/WO-0038_tb-m03-first-bench.md`'s Return / verdict log.
State left at **BOUNCED** per this spawn's instruction — dv_lead's `RV-`
and the orchestrator's transcription do the state flip, not me.

### Open-questions

None new this round. Round 2's open question on `fst`/`snd` was closed by
`J-dv_lead-0024` ("Keep `fst`/`snd`") and R3-1/R3-2 did not touch that
code, so it is not reopened. The one item worth a future reviewer's
explicit ruling, flagged in the Return log rather than here as a
question needing an answer before this round can be judged: whether
rewriting `test_m03_structural.ml`'s top docstring paragraph (beyond the
addendum-D2 comment RV-0038-R3 explicitly authorized rewriting) was within
this round's scope or should have been left for dv_lead to request
separately.

### Files-in-this-commit
- test/xgmii_rx_64/test_m03_c.ml
- test/xgmii_rx_64/test_m03_structural.ml
- agents/handoffs/WO-0038_tb-m03-first-bench.md

---

## [J-tb_writer-0004] 2026-08-02T23:50Z | task:WO-0038 | Round 4 — ascending-order drive, run's contract checked not promised, discard the reversed-schedule promotion

### Trigger

WO-0038/2026-08-02T23:35Z (dv_lead, via the orchestrator): round-4 fix list
after round 3's Build went green and `dune runtest` reached the eleven rows
for the first time — but the promotion it produced was every schedule
played BACKWARDS. `RV-0038-R4` (`J-dv_lead-0027`) is the authoritative,
verbatim instruction: `bench.ml:131`'s `List.init` applies Base's `~f` from
the highest index down to 0, and since `sample_cycle` drives the XGMII port
and steps the clock, evaluation order *is* the stimulus — so run
30771064764 fed M03 every word in reverse cycle order (the strobe monitor's
own record inside the promoted text shows cycles 20, 19, … 0). All four
promoted `[%expect.unreachable]`/`[@@expect.uncaught_exn]` blocks are
explained fully by that reversal (no `/S/` in wire order → no frame opens →
zero output, which is the *conformant* response to a reversed stimulus).
**Zero convictions against M03 may be drawn from that run, and RV-0038-R4
rules none may be.** Packet state BOUNCED. Four items: R4-1 (BLOCKING,
exact replacement text given — ascending explicit recursion, sequenced by a
`let` so argument-evaluation order cannot matter either), R4-2 (REQUIRED,
exact text given — assert `run`'s own "ascending cycles" contract in code,
standing obligation 5's principle applied to the driver itself), R4-3
(REQUIRED — document `bench.ml:178`'s `List.map` in `run_directed_lengths`
as order-independent BY ARGUMENT, since every iteration builds its own
fresh `t` and shares nothing), R4-4 (BLOCKING — discard the promotion
entirely; restore `test_m03_a.ml`, `test_m03_b.ml`, `test_m03_c.ml`,
`test_m03_structural.ml` to HEAD byte-exactly, so the eleven `[%expect]`
blocks go back to empty and the next `runtest` records M03's actual
behaviour). This round touches no row's stimulus, oracle or assertion
content — none of the eleven rows was ever reached by the reversed run.

### Inputs

`agents/charters/tb_writer.md`; `agents/PROTOCOL.md` §2-6 and §10 (re-read
in full); `agents/handoffs/WO-0038_tb-m03-first-bench.md` in full, including
every prior round's Return log and every dv_lead verdict up to and
including `RV-0038-R4` (`J-dv_lead-0027`) at the foot — read multiple times
to copy R4-1's and R4-2's exact replacement text rather than paraphrase it,
and to confirm R4-3 gives direction (document as order-independent BY
ARGUMENT) rather than verbatim text, and R4-4 gives a restoration
instruction (HEAD content, byte-exact) rather than new text. This journal's
own header and my `J-tb_writer-0001`/`0002`/`0003` entries, to confirm the
next entry id (0004) and avoid re-deriving what prior rounds already
recorded. `test/xgmii_rx_64/bench.ml`, re-read in full before editing to
locate line 131 and line 178 exactly and confirm no other `List.init` /
`List.mapi` call exists in the file (grep, not assumption — the file has
exactly one other `List.init`, at `directed_lengths`, over a fixed integer
range with no side effect, out of R4's scope and untouched).
`test/xgmii_rx_64/bench.mli`, re-read to confirm R4-2's fix is entirely
inside `bench.ml` and requires no `.mli` change (the existing `run`
docstring's "drives cycles `[0 .. Arrival.cycles sched - 1]`" sentence
becomes true rather than needing new text). `git show HEAD:test/xgmii_rx_64/
{test_m03_a,test_m03_b,test_m03_c,test_m03_structural}.ml` — the committed
content R4-4 requires restoring verbatim, read into scratch copies and then
written over the four working-tree files, followed by `git diff --exit-code`
against each to confirm byte-identity rather than assert it. `git log
--oneline -5` and `git status --porcelain`, to confirm the four promoted
files were the only working-tree diff before this round's edits and that no
other path had drifted. No path under `libs/**`, `top/**`, `bin/**` or
`rtl_snapshots/**` — any path, manifests included — was opened this spawn,
targeted or swept.

### Reasoning

**Why this is a bench defect and not an M03 finding, restated in my own
words rather than only cited from the verdict.** `Arrival.cycles`/
`Arrival.word_at` build a schedule that is a pure function of index: cycle
*i*'s word does not depend on any other cycle having been sampled yet.
`sample_cycle`, by contrast, is not pure with respect to its caller's
iteration order — it drives a register-backed input and advances a
`Cyclesim` clock, so the *sequence* in which cycles 0..N are handed to it is
observable state, not an implementation detail. `List.init`'s two
implementations (Stdlib ascending, Base's actual descending-`~f`-application
behaviour, both legal under a spec that leaves evaluation order
unspecified) therefore differ in more than performance for this one caller:
one produces the schedule and the other produces its reverse. A design fed
a reversed 64-octet frame correctly sees no `/S/` in wire order and forwards
nothing — that is REQ-102/§6.2's `Idle` behaviour operating exactly as
specified on a stimulus that was never the schedule `Arrival` built. The
four uncaught-exception blocks are the shape a correct M03 leaves when handed
that stimulus, not a shape M03's own logic produced through any path
`Arrival.check`, standing obligation 5, or any assertion in this packet's
eleven rows could have caught — `Arrival.check` validates the schedule as
data (octet times, gaps, start lanes), and the schedule *was* valid data;
the corruption was introduced afterward, in how `run` walked it. This is
exactly why RV-0038-R4 could rule zero convictions with confidence rather
than hedge: every failure traces to the driver, and none traces to a
disagreement between M03's output and any Observable this packet asserts.

**R4-1 and R4-2, applied verbatim, no independent semantic re-derivation.**
RV-0038-R4 gives exact replacement text for both — an explicit `rec drive`
that recurses ascending from 0, with `let s = sample_cycle … in` sequencing
the drive-and-sample call strictly before the recursive step (so the fix
holds regardless of whether some future OCaml implementation ever changed
function-application argument order, not only `List.init`'s iteration
order), followed by an `iteri`-based check that `run`'s own returned
samples carry cycle numbers 0, 1, 2, … in position order, `failwith`ing by
name if not. I copied both blocks character-for-character rather than
reconstruct them from the surrounding prose, and combined them at the one
splice point the two blocks share: R4-1 ends with `drive 0 []` as the
function's return value; R4-2's text opens with `let samples = drive 0 []
in` — i.e. R4-2 replaces that same tail expression with a `let`-bound name,
the `iteri` check, and `samples` as the new return value. I confirmed by
reading both blocks against each other line by line that this is the only
way they compose (no line of R4-2 duplicates a line of R4-1, and R4-2's
`drive 0 []` occurrence is the identical text R4-1's final line produces),
rather than assuming it.

Why R4-2 earns its place independently of R4-1 having already fixed the
underlying bug: RV-0038-R4's own postmortem is that this defect was
*invisible to every review that asked whether the code says what it means*
and was caught only as a side effect of the strobe monitor happening to
record per-cycle order in its report — a check nobody wrote *for* that
purpose. Standing obligation 5 already establishes the principle that an
unchecked stimulus generator is an unverified assertion about the design;
`run`'s own docstring promise ("drives cycles `[0 .. Arrival.cycles sched -
1]`") was exactly such an unchecked claim, sitting in the one component
obligation 5's own `Arrival.check` call cannot reach, because `Arrival.check`
validates the schedule `Arrival` built, not the order in which `run` walks
it. Asserting it in code closes that gap for good: a future edit to `run`
that reintroduces any order-scrambling combinator now fails loudly on its
own first execution, rather than only if a downstream monitor happens to be
sensitive to order and someone happens to read its report closely enough to
notice, as happened this time only because dv_lead did.

**R4-3, direction given rather than verbatim text — I wrote the comment to
match the instruction's own wording.** RV-0038-R4 and the parent prompt both
say to document `run_directed_lengths`'s `List.map` as "order-independent BY
ARGUMENT" without supplying exact prose, unlike R4-1/R4-2. I stated the
property precisely: each iteration of the `List.map` is a self-contained
function of `length` alone — it builds its own `octets`, `sched`, `bench`
(a *fresh* `create ()`, never a shared one) and calls `run` once, returning
a 4-tuple that no other iteration reads or writes. That is the exact
property that makes iteration order irrelevant to the *result* even though
each iteration still has an ambient side effect (elaborating and running a
`Cyclesim` instance) — order-independent by argument, not order-independent
absolutely, and I named the distinction so the comment cannot be
misread as "this file has no side-effect-order hazards", which would be
false (`run`'s own body, one function above this one, is the counterexample
in the same file). I added the forward-looking sentence RV-0038-R4 itself
asked for — that a future edit sharing state across iterations (a running
`bench`, an accumulator) would invalidate the argument — so the comment is
falsifiable by a future diff rather than a permanent assertion.

**R4-4: restoration verified by diff, not by re-typing.** I did not
hand-edit the four files back toward what I remembered writing in round 3;
I read each one's committed HEAD content via `git show` into scratch
copies and overwrote the working-tree file with that exact content, then
ran `git diff --exit-code` against each of the four individually and as a
group. An empty diff is the only evidence this packet's own R4-4 accepts
("Verify with `git diff` that the four are byte-identical to HEAD
afterwards (empty diff)"), so I produced exactly that evidence rather than
asserting the restoration was correct because the method should have
worked.

**Why `bench.mli` needed no edit.** R4-2's fix is entirely a `bench.ml`
change: the `run` docstring already states "drives cycles `[0 ..
Arrival.cycles sched - 1]`" as a promise, and R4-1+R4-2 together make that
promise true and checked rather than false and unchecked — no word of the
existing `.mli` text becomes newly inaccurate the way round 3's stale
docstring did, so there is nothing here for the "a verbatim fix carries the
obligation to repair any prose it falsifies" rule (RV-0038-R3-VERDICT,
`J-dv_lead-0026`) to trigger. I re-read the `.mli`'s `run` docstring in full
to confirm this rather than assume it, since that standing rule is exactly
the kind of thing a rushed round misses.

### Actions

One targeted `Edit` against `test/xgmii_rx_64/bench.ml`: the `List.init`
line at (pre-edit) line 131 replaced with R4-1+R4-2's combined text
verbatim; one comment block inserted immediately above
`run_directed_lengths` per R4-3, in my own wording per the instruction's
direction. Four files restored to HEAD content byte-exactly via `git show
HEAD:test/xgmii_rx_64/<file>` piped to each working-tree path:
`test_m03_a.ml`, `test_m03_b.ml`, `test_m03_c.ml`, `test_m03_structural.ml`
— no manual editing of any of the four. `bench.mli` was read and confirmed
to need no change; not edited. No file under `libs/**`/`rtl_snapshots/**`/
`top/**`/`bin/**` was opened.

### Evidence

All commands run from a repo checkout at this SHA.

- `ocamlc -stop-after parsing test/xgmii_rx_64/bench.ml`: exit 0.
- `git diff --exit-code -- test/xgmii_rx_64/test_m03_a.ml
  test/xgmii_rx_64/test_m03_b.ml test/xgmii_rx_64/test_m03_c.ml
  test/xgmii_rx_64/test_m03_structural.ml`: exit 0, empty diff — the four
  promoted files are byte-identical to HEAD.
- `git status --porcelain`: only `M test/xgmii_rx_64/bench.ml` — the four
  restored files show no diff and do not appear.
- `bash tools/precompile_check.sh`: `precompile_check: ALL LANES PASSED`;
  `dv_golden`/`dv_monitors`/`dv_xgmii` (31 units) and
  `dv_axi64_probe`/`dv_xgmii_probe` (12 units) all still compile with 0
  errors; `test/xgmii_rx_64` still correctly `EXCLUDED` (depends on
  `hardcaml_ethernet`, which this harness cannot transcribe) — unaffected
  by this round's edit.
- `bash tools/dv_checks.sh`: `check_records_vs_appendix.sh` 23/23 PASS;
  `check_emitted_verilog.sh` 5/5 PASS, 3 PENDING (pre-existing, not M03);
  `precompile_check.sh` as above; `check_rfc1071_anchor.sh` OBLIGATION OPEN
  on blocked network egress (pre-existing, `J-dv_lead-0017/0018`, M02/M14's
  checksum oracle, unrelated to M03 and to this round);
  `dv_checks: every check that COULD run passed, and 1 obligation is still
  OPEN`.
- `eval $(opam env) && dune build @default`: fails at `Library
  "ppx_hardcaml" not found` (same absent Hardcaml toolchain every prior
  round confirmed, ADR-0005) — checked again this round rather than assumed
  carried over, since a container change between rounds is exactly the kind
  of silent-drift risk this packet's own history (the `mod`/deprecation
  surprise at round 3) argues against taking on faith.
- `dune runtest`: not run — same absent toolchain. Remains CI's to run and
  judge; per WO-0038 §7 and every prior round, it is expected to reach the
  eleven rows' now-empty `[%expect]` blocks and promote real M03 output for
  the first time, which is the round this fix exists to make trustworthy
  when it happens.

### Outcome

DoD status vs RV-0038-R4: R4-1 met (ascending explicit recursion, exact
text, verified parsing-clean); R4-2 met (contract checked in code, exact
text, combined correctly with R4-1 at their shared splice point); R4-3 met
(order-independent-by-argument documented at `bench.ml:178`, direction
followed, no verbatim text was given to deviate from); R4-4 met (all four
promoted files restored to HEAD, `git diff --exit-code` empty on each,
confirmed rather than asserted). Handoff: Return log appended to
`agents/handoffs/WO-0038_tb-m03-first-bench.md` as a ROUND-4 RETURNED
block; packet state left BOUNCED, since only dv_lead's `RV-` and the
orchestrator's transcription may flip it. No `SO-` claimed or offered;
M03 has still never been tested by a correctly-ordered run.

### Open-questions

None new this round. R4-1/R4-2/R4-3 were exact-text-or-clear-direction
fixes with no ambiguity to raise; R4-4 is a mechanical restoration verified
by diff. Every open question from rounds 1-3 was already closed by the
verdicts that closed them (`RV-0038`, `RV-0038-R2`, `RV-0038-R3-VERDICT`)
and none is reopened by this round's changes, which touch no row's
stimulus, oracle or assertion.

### Files-in-this-commit
- test/xgmii_rx_64/bench.ml
- agents/handoffs/WO-0038_tb-m03-first-bench.md

---

## [J-tb_writer-0005] 2026-08-03T10:45Z | task:WO-0038 | Round 5 — choke-point ordering guard, out_cycle relabelling, latency-check split, C1's batched per-length signature

### Trigger

WO-0038/2026-08-03T10:00Z (dv_lead, via the orchestrator): `RV-0038-R5`
(`J-dv_lead-0029`) adjudicates run 30772333717 — the first run in this
packet's history to drive every schedule forward (round 4's fix) and reach
real, substantive assertion content in all eleven rows. Four of the five
failures it produced are ruled the bench's own oracle, not M03's: the
`drive -> Cyclesim.cycle -> sample` convention this bench uses labels every
OUTPUT observation one cycle early, proven from this repository's one
CI-promoted waveform, `test/hardcaml_ethernet/test_word_counter.ml` (input
at cycle N produces a registered output read at cycle N+1). Items 1, 2 and
4 (the ΔC/word-0-arrival-cycle failures) are shown to be exactly this
off-by-one and, corrected, satisfy §6.1's cycle table and REQ-019's ΔC=3
constant — **M03 is vindicated on all three, not convicted.** Item 5 (the
scaffolding test's "latency tagger unclean" failure) is a second, distinct
bench defect: the smoke test drives zero frames and then demands
`is_clean`/constancy of a tagger that correctly declines to claim
constancy over zero comparisons — the monitor is right, the bench's
question to it is wrong. Item 3 (M03-C1 lane 0 length 65: 62 delivered
octets observed against 61 expected) is **not** explained by either bug and
survives as provisional finding **F-M03-1**, with a falsifiable
lane-dependent prediction (an FCS-straddle mis-accounting mechanism would
fail lengths 65-67 at lane 0 and 69-71 at lane 4, and no others; a uniform
strip/count error would fail all eight at both lanes; nothing failing after
the oracle fix withdraws it). **F-M03-1 is explicitly not mine to fix or
explain** — the packet states this and I did not touch it. Packet state
BOUNCED. Four items: R5-1 (REQUIRED, carried from `RV-0038-R4-VERDICT`/
`J-dv_lead-0028` — dv_lead's own finding against its own round-4 R4-2
guard, which checked the RETURNED sample list's order rather than the
order `sample_cycle` actually drove the design in, and — demonstrated by
dv_lead running it against a recorder — would NOT have fired on the
original reversed-drive bug; exact replacement text given: a choke-point
guard inside `sample_cycle` itself, keyed on a new `mutable cycles_driven`
field on `t`), R5-2 (BLOCKING, exact type/field text given: add `out_cycle`
to `sample`, relabel every enumerated OUTPUT-observation call site), R5-3
(BLOCKING, exact code given: split `assert_monitors_clean`'s latency check
into an unconditional `errors` half and a constancy half gated on
`Latency.frames_compared t.latency > 0`; `dv_monitors` explicitly untouched
— "its behaviour is right"), R5-4 (REQUIRED, no verbatim text — "In
`run_c1_c2`, collect each length's outcome … into a list, and raise once at
the end with every length's line" — rework M03-C1/M03-C2's per-length check
so a single CI run returns the complete sixteen-entry (lane, length)
signature instead of aborting at the first failing length, since a
fail-fast loop cannot settle F-M03-1's lane signature).

### Inputs

`agents/charters/tb_writer.md`; `agents/PROTOCOL.md` §2-6 and §10 (re-read
in full); `agents/handoffs/WO-0038_tb-m03-first-bench.md` in full —
every prior round's Return log and every dv_lead verdict from `RV-0038`
through `RV-0038-R5` (`J-dv_lead-0022` through `J-dv_lead-0029`), read start
to foot, with particular attention to `RV-0038-R4-VERDICT`
(`J-dv_lead-0028`, the source of R5-1's exact guard text — re-read
specifically for the "guard on the ORIGINAL BUG: DID NOT FIRE" experiment
that motivates replacing rather than keeping R4-2) and `RV-0038-R5`
(`J-dv_lead-0029`, this round's authoritative ruling and fix list, read
multiple times to copy R5-1's and R5-2's given text character-for-character
and to confirm R5-3's code and R5-4's direction-only instruction).
`test/hardcaml_ethernet/test_word_counter.ml` — the one CI-promoted
waveform the whole cycle-labelling argument rests on, read in full to
independently confirm the snapshot RV-0038-R5 cites (`valid` high during
cycle 1 producing `count` = 1 during cycle 2, changing at cycle 2, reaching
`0003` at cycle 4) rather than take the ruling's reading of it on faith —
it is the one file this packet's own §4 exempts from the RTL-read
prohibition, and it is a DV bench, not RTL. `test/monitors/octet_time.mli`
— re-read `Latency.errors`, `Latency.frames_compared`, `Latency.is_clean`,
`Latency.is_constant`'s docstring ("True iff at least one octet was
compared and every front-offset class has a single L") to confirm R5-3's
given code names exist in the contract exactly as used, and that item 5's
diagnosis (constancy false over zero comparisons is the monitor's honest
answer, not a bug) is the contract's own stated behaviour, not an inference.
`test/monitors/strobe_monitor.mli` — re-read `sample`'s "out of order" /
"sampled the same cycle twice" rejection to confirm `out_cycle = cycle + 1`
preserves strict per-cycle monotonicity (every input cycle maps to a
distinct, ascending output cycle). `test/monitors/protocol_monitor.mli` —
re-read `observe`'s contract ("present one cycle of the stream … safe to
call on every cycle") to confirm relabelling which cycle number is passed
is a relabelling, not a new obligation on the monitor. This journal's own
header and my `J-tb_writer-0001`-`0004` entries, to confirm the next
strictly-monotonic id (0005) and to avoid re-deriving what prior rounds
already established (M03-A4's NO-ASSERT discipline, M03-B1's `?word_at`
composition, M03-C2's subset derivation, M03-C4's REQ-107 additions — none
of which this round's changes touch). `test/xgmii_rx_64/bench.ml`,
`bench.mli`, `test_m03_a.ml`, `test_m03_b.ml`, `test_m03_c.ml`,
`test_m03_structural.ml` — all six re-read in full before editing, to
locate every call site R5-2 enumerates precisely and to confirm by grep
(not assumption) which files actually reference `.cycle` for OUTPUT timing:
`test_m03_a.ml` (`run_a1_a2`'s per-word cycle check, `assert_own_deltac`)
and `test_m03_c.ml` (`run_c4`'s single-word cycle check) do;
`test_m03_b.ml` and `test_m03_structural.ml` do not, confirmed by
`grep -n "\.cycle\b"` returning nothing in either before I left them
unedited. `git status --porcelain` and `git diff --exit-code`, before
editing (to confirm the working tree was clean at RV-0038-R5's baseline)
and after (to confirm exactly the four intended files changed and the two
untouched ones remain byte-identical to HEAD). No path under `libs/**`,
`top/**`, `bin/**` or `rtl_snapshots/**` — any path, manifests included —
was opened this spawn, targeted or swept. No path under `test/monitors/**`
was opened for writing (R5-3 forbids it); the three `.mli` files above were
read only, to confirm names before calling them.

### Reasoning

**R5-1: applying dv_lead's own corrective text to dv_lead's own prior
prescription, understanding why the ORIGINAL guard was wrong before
splicing in the replacement.** `RV-0038-R4-VERDICT` demonstrated, by
running the applied R4-2 guard against a recorder set to the ORIGINAL
reversed-drive bug, that the guard would not have fired: `List.init`
*returns* its list in ascending index order regardless of how it evaluates
`~f`, so `s.cycle = i` held even when the underlying drive was reversed.
The guard was checking a fact about the wrong object — the returned list's
order, not the side-effect order that actually reaches the design. The
replacement fixes this by moving the check into `sample_cycle` itself, the
one function through which every drive must pass, with a `mutable
cycles_driven` counter that only advances on an in-order call. I applied
this text unchanged, adding only the record-field placement (`t.
cycles_driven`) the guard's home function requires, and removed the old
`run`-level guard entirely rather than keeping both — R5-1's own wording
("replace") and the fact that a superseded check left in place invites a
future reader to trust it again.

**R5-2: out_cycle as a pure relabelling, verified against each call site's
actual role (input vs output) rather than applied mechanically everywhere.**
Before editing, I re-classified every `.cycle` reference in the six files
into "reads/produces an INPUT fact" (unaffected: `start_cycle`,
`terminate_cycle`, the schedule's own cycle arithmetic in `Arrival`) versus
"reads an OUTPUT fact sampled off `Cyclesim.outputs`" (affected:
`Protocol_monitor.observe`'s `out` argument, `Strobe_monitor.sample`'s
`errors_high` argument — both read off `o`, the live outputs record, inside
`sample_cycle`, hence RV-0038-R5's ruling that error strobes are outputs
too and belong to `out_cycle` just as much as `rx` does; `error_pulses`;
`account_clean_frame`'s `Octet_time.of_words` pairing; `test_m03_a.ml`'s
per-word arrival-cycle check and ΔC measurement; `test_m03_c.ml`'s
single-word arrival-cycle check in `run_c4`). This classification is what
let me confirm, rather than assume, that `test_m03_b.ml` and
`test_m03_structural.ml` need no edit: neither compares an output sample's
cycle against an expected value anywhere (`test_m03_b.ml`'s only cycle
arithmetic is in `preamble_override`, which computes which INPUT word to
substitute, not a check on an output; `test_m03_structural.ml`'s
scaffolding test never reads `.cycle`/`.out_cycle` at all). I also confirmed
`run_c4`'s `Strobe_monitor.expect` window needed no edit by tracing the
data flow rather than trusting the packet's own claim about it: `cycle` in
the `(int * string)` pairs `error_pulses` returns is the ONLY place that
value reaches `run_c4`'s pulse-cycle comparison, and since `error_pulses`
itself now emits `out_cycle`, the comparison downstream is corrected for
free — exactly as RV-0038-R5 says, and I re-derived why rather than take it
on faith.

**R5-3: applying the given code verbatim, and confirming its two API calls
(`errors`, `frames_compared`) exist before writing them.** No independent
design choice here beyond what the packet's code already specifies; the
only thing I added was the comment explaining item 5's diagnosis in my own
words (a tagger given zero frames correctly declines to claim constancy,
per its own documented contract) so a future reader does not need to
re-derive why the split is correct from RV-0038-R5 alone.

**R5-4: no exact text supplied, so the design is mine — built around
"collect, decide once, report the full table" and argued against the
mutation-kill and coverage obligations it must not weaken.** I chose a pure
record (`length_outcome`) over an exception-catching approach specifically
because this codebase has no precedent anywhere for catching a `failwith`
inside a test file (checked by grep across `test/`), and a pure
never-raising builder is both simpler to verify by reading and avoids
depending on `Base`'s exact `Failure`/`Exn` behaviour, which I cannot check
against a real toolchain here. Two decisions beyond the four named columns
(delivered count, tlast tkeep, tuser, terminate lane) are mine and are
recorded in the Return log rather than left implicit: folding
`error_pulses` non-emptiness into `outcome_ok` (dropping it would have been
a silent coverage regression against the row as accepted at `RV-0038`), and
running `account_clean_frame`/`assert_monitors_clean` per length AFTER the
batched content decision rather than folding them into it (they check a
different property, and folding them in would either require
exception-catching I would not commit unverified, or reintroduce fail-fast
at one call further down). I also merged M03-C2's separate FCS-good
recheck into C1's existing universal `tuser = 0` requirement, since the
pre-R5 code already asked the identical question of the same sample twice
under two different messages — verified by reading both checks side by
side, not assumed — so no row's assertion content is weaker, only a
redundant second message is gone. Before finishing, I re-derived that the
WO-0038 §8 mutation kill named for C1 ("tkeep computed from the input word
rather than the frame") still fires: `length_outcome`'s `observed_tkeep`
still reads the live DUT sample and `outcome_ok` still compares it against
a `frame`-derived `expected_tkeep`, independent of the mutation, so an
affected length still shows as a `FAIL` line — now a strictly more legible
one, naming every affected length, not fewer.

**One syntax risk avoided rather than discovered by CI**: I initially drafted
`lane0 @ lane4` to concatenate the two lanes' results and, lacking a
toolchain to check operator availability under this file's `open! Base`,
grepped the tree for existing `@`-under-Base precedent and found none in any
file that opens Base (the two hits that exist are in plain-OCaml
`strobe_monitor.ml`, which opens nothing). Replaced with `List.append`,
which is unambiguously a `Base.List` function already relied on by this
exact style of code elsewhere in the file (`List.filter_map`,
`List.concat_map`), rather than gamble a whole round on an operator I could
not verify.

### Actions

`test/xgmii_rx_64/bench.ml`: added `mutable cycles_driven : int` to `type
t` and its initialisation in `create`; added `out_cycle : int` to `type
sample`; moved the ascending-order guard from `run`'s tail into the head of
`sample_cycle`, keyed on `t.cycles_driven`; computed `out_cycle = cycle + 1`
in `sample_cycle` and used it for `Protocol_monitor.observe`,
`Strobe_monitor.sample`, and the returned `sample` record; updated
`error_pulses` to emit `s.out_cycle`; updated `account_clean_frame`'s
`delivered_pairs` to pair `s.out_cycle` with `s.out`; split
`assert_monitors_clean`'s latency check per R5-3's given code. Removed the
`run`-level R4-2 guard, replacing it with a comment pointing to the new
choke-point guard's location and reasoning.
`test/xgmii_rx_64/bench.mli`: updated the `sample` type and its docstring
to document `cycle` vs `out_cycle` and cite `test_word_counter.ml`; updated
`run`'s, `error_pulses`'s, `account_clean_frame`'s and
`assert_monitors_clean`'s docstrings to match the corrected mechanics.
`test/xgmii_rx_64/test_m03_a.ml`: `run_a1_a2`'s per-word cycle comparison
and `assert_own_deltac`'s ΔC measurement now read `s.out_cycle`/
`first.out_cycle`.
`test/xgmii_rx_64/test_m03_c.ml`: `run_c4`'s single-word cycle comparison
now reads `s.out_cycle`; the entire M03-C1/M03-C2 section
(`check_directed_length_frame` and `run_c1_c2`) rewritten around
`length_outcome`/`outcome_ok`/`outcome_line`/`length_outcome` and a
two-lane, collect-then-decide `run_c1_c2 ()` (no `~lane` argument any
more — it now always drives both), preserving the D3 batched-coverage
checks and the standing-monitor accounting, both moved to run after the
content-signature decision. The `%expect_test` body changed from
`run_c1_c2 ~lane:0; run_c1_c2 ~lane:4;` to `run_c1_c2 ();`; its
`[%expect {||}]` block was not touched.
`test/xgmii_rx_64/test_m03_b.ml`, `test/xgmii_rx_64/test_m03_structural.ml`:
re-read in full, confirmed to need no change, not staged.
`agents/handoffs/WO-0038_tb-m03-first-bench.md`: appended a ROUND-5
RETURNED block per §8's established per-round shape (not the original
issue-time §8 template, which this round does not restart); state left
BOUNCED.

### Evidence

`ocamlc -stop-after parsing`, system `ocamlc` 4.14.1, on all six files in
`test/xgmii_rx_64/` (the four touched plus the two re-confirmed untouched):
exit 0 on every file. `bash tools/precompile_check.sh`: ALL LANES PASSED —
Lane 1 31 units/0 errors, Lane 2 12 units/0 errors, Lane 3a 43/43 files
materialised and compiled with `xgmii_rx_64` correctly EXCLUDED (depends on
`hardcaml_ethernet`), Lane 3b no unqualified sibling-library reference.
`bash tools/dv_checks.sh`: `check_records_vs_appendix.sh` 23/23,
`check_emitted_verilog.sh` 5/5 with 3 pre-existing PENDING rows unrelated to
M03, `precompile_check.sh` as above, `check_rfc1071_anchor.sh` OBLIGATION
OPEN (pre-existing, blocked egress, unrelated to M03). `git status
--porcelain` (repo root): exactly `test/xgmii_rx_64/bench.ml`, `bench.mli`,
`test_m03_a.ml`, `test_m03_c.ml` — four paths, matching the four files this
round's items touch. `git diff --exit-code -- test/xgmii_rx_64/
test_m03_b.ml test/xgmii_rx_64/test_m03_structural.ml`: exit 0, confirming
byte-identity to HEAD independently of the status listing. `eval $(opam
env) && dune build @default`: fails at `Library "ppx_hardcaml" not found` —
the same absent toolchain every round has confirmed (ADR-0005); `dune
runtest` not reached, same reason. Full verbatim output for all of the
above is in the Return log's §4.

### Outcome

R5-1, R5-2 and R5-3 met to the packet's own given text/shape, verified by
re-derivation (§Reasoning) rather than copied blind. R5-4 met by an
original design, argued against the mutation-kill obligation and the row's
existing coverage, with its two non-packet-specified judgement calls
disclosed in the Return log §2 rather than left for dv_lead to find. No
row's stimulus, oracle or accepted content from `RV-0038`/`RV-0038-R2`/
`RV-0038-R3-VERDICT`/`RV-0038-R4-VERDICT` was touched. F-M03-1 (item 3) was
read, understood as out of scope, and not touched anywhere in this round's
diff. Handoff: Return log appended to
`agents/handoffs/WO-0038_tb-m03-first-bench.md` as a ROUND-5 RETURNED
block; packet state left BOUNCED, since only dv_lead's `RV-` and the
orchestrator's transcription may flip it. No `SO-` claimed or offered.
**Prediction, not a claim**: ten of the eleven rows (everything but
M03-C1/M03-C2) are expected to run clean against their empty `[%expect]`
blocks for the first time; M03-C1/M03-C2 is expected to still raise, via
R5-4's single batched `failwith`, if F-M03-1 is real — that is the correct
outcome of this round's fix, not a defect in it, and any resulting
promotion must stay unharvested per the packet's standing instruction.

### Open-questions

None. R5-1, R5-2 and R5-3 were exact-text-or-exact-shape splices with no
ambiguity to resolve. R5-4 had no verbatim text; the design choices it
required are disclosed in full in the Return log §2-3 and above, not held
back as an implicit question. F-M03-1 / item 3 is understood as explicitly
out of scope for this round and is not reopened here.

### Files-in-this-commit
- test/xgmii_rx_64/bench.ml
- test/xgmii_rx_64/bench.mli
- test/xgmii_rx_64/test_m03_a.ml
- test/xgmii_rx_64/test_m03_c.ml
- agents/handoffs/WO-0038_tb-m03-first-bench.md
