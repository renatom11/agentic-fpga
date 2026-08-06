# Journal: claude_tb_writer_agent — volume 03

- **Agent**: tb_writer (Sonnet worker template)
- **Charter**: agents/charters/tb_writer.md
- **Format**: v1 — entry grammar in agents/PROTOCOL.md §4
- **Volume**: 03
- **Continues-from**: J-tb_writer-0034
- **Previous-volume**: agents/journals/workers/claude_tb_writer_agent.v02.md
- **Previous-volume-sha256**: f6d9c72af41a764a6d014b20fcf4c95f5f5b926f04ea770867b05e7e2701e3da
- **Previous-volume-bytes**: 268905

This file is APPEND-ONLY. Content may only ever be added after the last line;
nothing above it is ever edited. Enforced by scripts/agent_commit.sh and CI.
Volume 02 is FROZEN: it is never appended to again, and any change to it breaks
this file's Previous-volume-sha256.

---

## [J-tb_writer-0035] 2026-08-06T10:10Z | task:WO-0078 | Volume 03 opened, combined with Stage 2's first landing — C1 and C2 constructed as case-table entries beside case 0, both verified by genuine local compile-and-run against the real DV-side link-partner model

### Trigger
Orchestrator, dispatching WO-0078 Stage 2's first landing (C1+C2, per §6.2's
"Landings: C1 + C2 together"). The dispatch text itself directs this entry
to open volume 03 ("THIS ENTRY OPENS workers VOLUME 03") rather than
rotating in a separate journal-only commit ahead of the substantive round,
which is the shape J-tb_writer-0017 (volume 02's own opening, at
`WO-0059`'s round 2) used under a different, two-commit instruction
(`RV-0059-VERDICT`'s "Step 0, before round 2's own work"). No spawn
short-id token in the literal "work-order id + spawn UTC timestamp" form
(PROTOCOL §4.1) was present in this round's own dispatch prompt — recorded
honestly here per `J-data_wrangler-0001`'s and `J-data_wrangler-0003`'s own
precedent for the identical situation (also used by tb_writer's own prior
round, the Stage-1 repair entry immediately below `RV-STAGE1` in
`WO-0078`'s §14), rather than presented as a token copied verbatim: the
timestamp above is this entry's own UTC header time, `date -u` read at the
start of this round, matching the environment's own `currentDate` context
(2026-08-06) rather than the fictional 2026-08-11 dates several `WO-0078`
§14 entries above this one carry (a discrepancy `FINDING CD-P2-2` already
records and does not repeat here — I use my own clock's real reading, not
the packet's own prior entries' dates).

### Inputs
- **Abort-first head check**: `git rev-parse HEAD` = `8427b12bf5c1e169ddb1cb98d48cfd6be2c0f491`,
  exactly the dispatch's stated spawn-head. Proceeded without the mismatch
  procedure.
- `agents/charters/tb_writer.md` (full read, this round).
- `agents/PROTOCOL.md` §2–6, §10 (full read, this round).
- `agents/handoffs/WO-0078_cosim-phase2-3-stimulus-widening.md`, read **in
  full** (2059 lines, two page-reads) — every section, including the entire
  §14 Return/verdict log (Stage 1 tb_writer's and data_wrangler's own
  Return entries and `RV-STAGE1`'s full text, all four findings, and the
  Stage-1 repair round's own Return entry), because §14's own history is
  what carries `FINDING RV-0078-S1-1`'s successor rule and
  `FINDING RV-0078-S1-2`'s printer-repair status, both load-bearing for
  confirming Stage 2's preconditions were actually met before this round
  began rather than merely asserted by the dispatch.
- `test/attack_plans/CD-xgmii_rx_64_cosim.md`, read **in full** (855 lines) —
  §0 through §10.7, with particular weight on §10.0 (what binds every
  Stage-2 instance), §10.1 (C1's frozen instance) and §10.2 (C2's frozen
  instance), and `FINDING CD-P2-1`/`FINDING CD-P2-2` (both read, neither
  bears on stimulus construction — CD-P2-1 is a branch-table defect at C3/C4,
  not C1/C2; CD-P2-2 is a date-literal defect, noted above rather than
  repeated).
- `test/cosim/stimulus_gen.ml` at HEAD (the file this round edits) — read in
  full before editing.
- `test/xgmii/arrival.mli` — re-read in full this round (DV-side, REQ-018's
  link-partner model, not RTL). `?ifg` default 12, `?first_start` default 8
  ("lane 0 of cycle 1"), must be a multiple of 4, `?fcs_valid` default
  `true`, `create` taking `int list list` (a frame LIST) — all UNCHANGED
  from `WO-0078` FI-2's own citation and from the Stage-1 round's own
  re-measurement. This is the frozen input C1's and C2's own constructions
  rest on most directly, and it had not moved.
- `test/xgmii/frame.mli` — read in full (DV-side). `stress_frame`'s
  `?filler`/`~sequence` signature and the 64-octets-DA-through-FCS /
  60-octets-delivered convention it documents.
- `test/xgmii/test_tx_decoder.ml:215` — read (one line, for the two-frame
  `Arrival.create` call idiom C2's own construction follows rather than
  invents).
- `tools/cosim/run_cosim.sh` — read-only (`tools/cosim/**` is not my write
  scope this round, and no line of it was staged): confirmed the pinned
  entry-points comment's own account of `stimulus_gen.exe`'s two-optional-
  positional-argument contract (output path, then case id) and confirmed
  `CASES=("0")` is still Stage 1's own array, i.e. data_wrangler's own
  Stage-2 landing (not commissioned by this dispatch) is what will add
  `"C1"`/`"C2"` to that array — nothing in my own file depends on that
  extension existing yet, and `run_cosim.sh` was not staged.
- For local verification only, read (not staged, not part of any deliverable):
  `test/golden/crc32_ref.ml`/`.mli`, `test/xgmii/xgmii_word.ml`/`.mli`,
  `test/xgmii/frame.ml`, `test/xgmii/arrival.ml` — the concrete
  implementations behind the interfaces above, all DV-side
  (`test/golden/`, `test/xgmii/`), read to build a standalone local compile
  of the edited `stimulus_gen.ml` against the REAL DV-side model rather than
  a hand-written stub (see Reasoning and Evidence). `test/golden/dune` and
  `test/monitors/dune`'s own header comments, read to confirm neither
  `dv_golden` nor `dv_monitors` (and, by extension, `dv_xgmii`, which depends
  only on those two) carries a Hardcaml dependency — this is what makes the
  local run below possible at all.
- **No `libs/**`, no `top/**`, no `rtl_snapshots/**` — opened at no point,
  by any means, this round.** Every file listed above is `agents/**`,
  `test/**` (DV-side only: `test/cosim/`, `test/xgmii/`, `test/golden/`,
  `test/attack_plans/`) or `tools/cosim/run_cosim.sh` (read-only). No RTL
  reached this seat's context at any point.

### Reasoning
**Scope, read against §6.2's table and the dispatch before a line was
written.** C1 and C2 only, per the dispatch's own narrowing of §6.2's four
cases to "the clean pair that lands together." C3 and C4 are out of scope
for this round (they land alone, per §6.2's own landing split, and each may
resolve to branch γ, forcing a spec-diff conversation the dispatch does not
commission here). Case 0's construction (`build ()`, `write_stimulus`, and
`drain_cycles`) is not opened for editing — confirmed both by diff (all
`+` lines land strictly after `case0_meta`'s closing `;;`, verified by
`git diff`) and, independently and more strongly, by re-running `build ()`
itself this round and reproducing `c675517176922d42bca42ec3def182cb3536861f1acaa8384116f33a5c4cc051`
byte for byte against the pin `RV-STAGE1` §1 anchored to CI run
`31080871169` at `55e16ae` (see Evidence) — not merely "the diff shows
nothing touched" (§11's own bar) but "the function, re-executed today,
still produces exactly that pin."

**Why C1's and C2's constructions are what they are, checked against CD's
own frozen instances rather than against the packet's own summary of
them.** `WO-0078` §6.2's table and CD §10.1/§10.2 agree word for word on
both cases' stimulus (as they must — CD §10 states it is carrying
`WO-0078` §6.2's own instances verbatim), so there was no discrepancy to
adjudicate between the two documents. What CD adds beyond §6.2's one-line
table cells is the derivation for *why* the chosen constants are the ones
CD's own frozen prediction rests on:

- **C1**: CD §10.1 states the construction as "case 0's frame with
  `~first_start:4`" and explains the multiple-of-4 constraint
  (`arrival.mli`) is what makes `4` a lane-4 start **on cycle 0** rather
  than the naive `~first_start:12` (a lane-4 start on cycle 3, off the
  reset-release cycle). `build_c1` therefore reuses
  `Frame.stress_frame ~sequence:0 ()` — the literal same content as case
  0's own frame, confirmed identical by a local check (Evidence) rather
  than merely asserted from "same construction shape" — and changes only
  `~first_start` from case 0's `0` to `4`.
- **C2**: CD §10.2 states "two 64-octet good-FCS frames, frame 0 at
  `~first_start:0` … separated by the minimum inter-frame gap of
  requirements.md §0.3: 12 octets, counted from the terminate character
  inclusive" and separately records the consequence that frame 1's own
  start character lands in lane 4 (84 octet-times is not a multiple of 8).
  `build_c2` therefore calls `Arrival.create` once with a two-entry frame
  list (`[ octets0; octets1 ]`, `~sequence:0` and `~sequence:1` — a second,
  DISTINCT frame rather than the first one repeated, following the
  precedent already landed at `test/xgmii/test_tx_decoder.ml:215` rather
  than inventing a new idiom), `~first_start:0` for frame 0, and `~ifg:12`
  passed EXPLICITLY (rather than left to `Arrival.create`'s own identical
  default) so the 12-octet figure CD §10.2 states is legible in the source
  itself rather than resting silently on a library default. `Arrival.create`
  itself computes frame 1's placement from the gap arithmetic, exactly as
  `arrival.mli`'s own header documents — there is no second `~first_start`
  to choose, and none is passed.

**Why neither construction touches an accumulator, checked rather than
assumed** (the dispatch's own stop-rule for C2, and the same argument
covers C1 by an even shorter route since C1 never opens a second frame at
all). `WO-0078` §2.2's finding is that both of this lane's refusal guards
(`ours_run.ml`'s `FI-4`, `tb_xgmii_rx_64.v`'s `FI-6`) fire only on a second
start character arriving **while a frame is open**. Neither `build_c1` nor
`build_c2` calls anything but `Arrival.create` and `Frame.stress_frame` —
the identical call shape case 0's own `build ()` uses — so neither
producer's admission logic sees anything from these two constructions that
case 0's own construction does not already exercise in kind (one frame, or
a frame list handed to `Arrival.create` in one call, which is exactly the
affordance `WO-0078` FI-2 names: "`create` takes an `int list list` — a
frame LIST — so a second clean frame needs no new machinery"). I did not
open `ours_run.ml`, `tb_xgmii_rx_64.v`, `canonical.ml`, `canonical.mli` or
`compare.ml` this round (confirmed by `git status --porcelain`: one file
changed), so there was no path on which I could have found otherwise and
had to stop — the dispatch's stop-rule was never engaged because the
construction never approached it.

**Case ids: `"C1"`/`"C2"`, not `"1"`/`"2"`.** `WO-0078` §6.2's table and CD
§10 both name the cases `C1`/`C2` throughout, capitalized, with no bare-
digit alternative ever used for them (unlike case 0, which both documents
call "case 0" and "0" interchangeably, and whose own `case_meta.id` is the
bare string `"0"`). Matching that vocabulary exactly in `case_meta.id` and
in `build_case`'s dispatch keys removes one avoidable translation step
between this file and every document a later reader (dv_lead's review,
data_wrangler's own Stage-2 landing, a future auditor sample) will hold
next to it. `tools/cosim/run_cosim.sh`'s own `CASES` array is
data_wrangler's file, not mine, and is unedited this round — its own
Stage-2 landing will need to pass exactly these two strings as its case-id
arguments, and this choice is what makes that landing's own array literal
read `("0" "C1" "C2")` rather than something a reader has to cross-reference
against a different id scheme in a different file.

**Idle-count sidecar values: `[0]` for C1, `[0; 0]` for C2, and why zero is
not an assumption.** `WO-0078` §5.2's mechanism — landed at Stage 1,
untouched this round — carries `injected_idle_before_d0`, a count of idle
cycles injected strictly between a frame's start character and its first
octet. Neither `build_c1` nor `build_c2` uses `test/xgmii/injection.ml`'s
injection machinery at all; both call `Arrival.create` directly on a plain
frame list, exactly as case 0 does. There is therefore no mechanism present
in either construction that could inject such an idle, and the count is
zero by the same construction argument case 0's own comment already makes
for its own single frame — restated at each new case rather than assumed
to carry over silently, per this file's own documentation style.

**Local verification: found a stronger check than Stage 1's own precedent
bound, disclosed rather than silently exceeded.** Stage 1's Return log
(and the Stage-1 repair round's) both state, verbatim, that
`stimulus_gen.ml` "depend[s] on Hardcaml/Hardcaml_ethernet/Dv_xgmii, none
of which has an installable switch in this container… I could not
type-check or run [it] beyond the parse-only check… and did not attempt to
reconstruct their dependency closure by hand." That bound was set at the
`test/cosim/dune` **stanza** level — `(executables (names stimulus_gen
ours_run compare) (libraries hardcaml hardcaml_ethernet dv_xgmii …))` lists
`hardcaml`/`hardcaml_ethernet` for the whole stanza because `ours_run.ml`
needs them, even though `stimulus_gen.ml` itself does not call into either.
Reading `test/xgmii/dune` and `test/golden/dune`'s own header comments
(both read this round) shows the file this round actually edits depends
only on `dv_xgmii`, which depends only on `dv_golden` and `dv_monitors` —
and both of THOSE libraries' own dune headers state, in their own words,
"No `(libraries)` field… plain OCaml over the standard library." Nothing
in `stimulus_gen.ml`, `arrival.ml`, `frame.ml`, `xgmii_word.ml` or
`crc32_ref.ml` requires Hardcaml at all; `arrival.ml` never references
`Dv_monitors` in code (only in a doc comment inside `arrival.mli`), so no
stub was even needed for that one. **This means the actual dependency
closure `stimulus_gen.ml` needs is entirely reconstructible with the bare
system `ocamlc`, from the real DV-side sources, with no stub standing in
for anything** — a genuinely stronger check than Stage 1's own disclosed
bound, found by tracing the stanza-vs-file distinction rather than
accepting the stanza's aggregate dependency list as this file's own. Built
in scratchpad (outside the repository checkout, nothing staged from
there): `crc32_ref.{ml,mli}`, `xgmii_word.{ml,mli}`, `frame.{ml,mli}`,
`arrival.{ml,mli}` copied verbatim from their real repository locations,
plus two two-line wrapper files (`dv_golden.ml`: `module Crc32_ref =
Crc32_ref`; `dv_xgmii.ml`: three `module X = X` aliases) reproducing dune's
own library-wrapping convention by hand, since dune itself is unavailable
(ADR-0005). This is not a claim that `dune build`/`dune runtest` were run —
they were not, and the landing CI remains the only real build of this file
through its own actual dune stanza, exactly as every prior round in this
lane has disclosed. It is a claim that the NEW code in this round's diff —
`check_conformant`, `build_c1`, `build_c2`, the two new `case_meta` records,
and the extended `build_case` match — was genuinely type-checked, linked,
and EXECUTED against the real (non-Hardcaml) half of its own dependency
graph, which is strictly more than a parse-only check proves and strictly
less than a claim that the Hardcaml-dependent producers downstream of this
stimulus were exercised (they were not, by this round or by any prior one
outside CI).

**Promotion discipline, applied to what this round can promote.** This
round produces no `[%expect]` block and eyeballs no waveform — its output is
a stimulus generator, not a test that observes a design, so charter §3's
"never promote expect output without eyeballing the waveform" does not
apply to a promotion event here; there is none. What stands in its place is
reading the actual printed/computed values from the real run against CD's
own frozen instance text, word for word, which is what the Evidence section
below does: `start_lanes`/`start_cycles`/`gaps` read directly off the
constructed schedules, not inferred from the source code's own intent.

### Actions
- Read the WO-0078 packet in full (both page-reads), the charter, PROTOCOL
  §2–6/§10, and CD-xgmii_rx_64_cosim.md in full.
- Re-read `test/xgmii/arrival.mli` and `test/xgmii/frame.mli` (DV-side) to
  re-measure FI-1/FI-2 at this seat's own base per §1's standing rule; none
  had moved.
- Edited `test/cosim/stimulus_gen.ml`: added `check_conformant` (a shared
  helper, not used by case 0's own unedited `build`), `build_c1`,
  `c1_meta`, `build_c2`, `c2_meta`, extended `known_cases` to
  `[ case0_meta; c1_meta; c2_meta ]`, and extended `build_case`'s match with
  `"C1"` and `"C2"` arms. Fixed one typo in my own first draft of the C1
  comment (a duplicated "a placement") before finishing.
- Verified byte-identity of case 0's construction span mechanically:
  `git show HEAD:test/cosim/stimulus_gen.ml | head -c 3121 | sha256sum`
  against the same on the edited file — equal — and confirmed the closing
  `;;` of `write_stimulus` is still at byte offset 3121/line 64.
- Built a local, non-stub compile environment in scratchpad from real
  DV-side sources (`crc32_ref`, `xgmii_word`, `frame`, `arrival`, plus two
  hand-written wrapper files reproducing dune's library-wrapping), compiled
  the edited `stimulus_gen.ml` against it with the bare system `ocamlc`,
  linked an executable, and ran it for all three case ids (`0`, `C1`,
  `C2`), then wrote three small ad hoc diagnostic drivers (also
  scratchpad-only, never staged) that call `Stimulus_gen.build`,
  `.build_c1`, `.build_c2` directly and print `Arrival.start_lanes`,
  `.start_cycles`, `.gaps`, `.frames`, `.delivered` and `.check` — see
  Evidence.
- Confirmed `git status --porcelain` shows exactly one changed file,
  `test/cosim/stimulus_gen.ml`, and nothing else in the repository
  checkout (no stray artifact from local testing leaked in).
- Verified this round's Stage-2 precondition (§11 "Both, every stage"): CD
  §10.1/§10.2 are committed at `5c01af0` (an ancestor of and prior to my
  spawn-head `8427b12`), with no uncommitted changes on top
  (`git status --porcelain` on the CD file is empty) — the case's own
  domain instance was committed before this round began.
- Verified `agents/journals/workers/claude_tb_writer_agent.v02.md`'s sha256
  and byte count against the dispatch's stated `Previous-volume-sha256`/
  `Previous-volume-bytes` — both matched exactly — before creating volume
  03.
- Created `agents/journals/workers/claude_tb_writer_agent.v03.md` with
  ADR-0017 §4.3's header block and wrote this entry, `J-tb_writer-0035`, as
  the volume's first.
- Did **not** touch volume 02 — no append, no edit, not staged.
- Appended a Return-log entry to `WO-0078` §14 (see Files-in-this-commit).
- No `dune`, no `git`, no `iverilog` run against the repository checkout
  itself (only the bare system `ocamlc`, and only inside scratchpad, on
  copied files). No `git commit`, no `git push` — I never run git.

### Evidence
```
$ git rev-parse HEAD
8427b12bf5c1e169ddb1cb98d48cfd6be2c0f491        # exact spawn-head, matched

$ git show HEAD:agents/journals/workers/claude_tb_writer_agent.v02.md | sha256sum
f6d9c72af41a764a6d014b20fcf4c95f5f5b926f04ea770867b05e7e2701e3da  -   # matches dispatch

$ git show HEAD:agents/journals/workers/claude_tb_writer_agent.v02.md | wc -c
268905                                                                # matches dispatch

$ git show HEAD:test/cosim/stimulus_gen.ml | head -c 3121 | sha256sum
ed4e47f36482a463c528a3dea3fccb27238c3e2b27b155dcb80e908709d6fbea  -

$ head -c 3121 test/cosim/stimulus_gen.ml | sha256sum      # after this round's edit
ed4e47f36482a463c528a3dea3fccb27238c3e2b27b155dcb80e908709d6fbea  -   # IDENTICAL

$ awk '/^let write_stimulus/{f=1} f && /^;;$/{print NR; exit}' test/cosim/stimulus_gen.ml
64                                                          # write_stimulus's closing ;; unmoved
```

**The real-source local build, genuinely type-checking and linking the new
code (not a stub):**
```
$ ocamlc -c crc32_ref.mli && ocamlc -c crc32_ref.ml    -> exit 0 (each)
$ ocamlc -c dv_golden.ml                                -> exit 0
$ ocamlc -c xgmii_word.mli && ocamlc -c xgmii_word.ml   -> exit 0 (each)
$ ocamlc -c frame.mli && ocamlc -c frame.ml             -> exit 0 (each)
$ ocamlc -c arrival.mli && ocamlc -c arrival.ml         -> exit 0 (each)
$ ocamlc -c dv_xgmii.ml                                 -> exit 0
$ ocamlc -c stimulus_gen.ml                             -> exit 0   (the edited file, genuinely
                                                                       type-checked against the
                                                                       real Arrival/Frame/Xgmii_word)
$ ocamlc -o stimulus_gen.exe crc32_ref.cmo dv_golden.cmo xgmii_word.cmo \
    frame.cmo arrival.cmo dv_xgmii.cmo stimulus_gen.cmo  -> exit 0   (genuinely LINKED)
```

**Run for all three case ids, real execution:**
```
$ ./stimulus_gen.exe stim_0.txt 0   -> exit 0; 36 lines; idle sidecar: "0"
    sha256(stim_0.txt) = c675517176922d42bca42ec3def182cb3536861f1acaa8384116f33a5c4cc051
```
**This is the EXACT literal `RV-STAGE1` §1 pinned and anchored to CI run
`31080871169` at `55e16ae` — reproduced today by genuinely re-executing
`build ()`, not merely by diffing source text.** The strongest form of
"case 0 untouched" this round could produce.
```
$ ./stimulus_gen.exe stim_C1.txt C1 -> exit 0; 36 lines; idle sidecar: "0"
    sha256(stim_C1.txt) = 5ae9e4f501251c38d0c2d386bd792e07cbcf9cf107cf7e75c378e21b1ce3bd7c   (new, distinct from case 0's)

$ ./stimulus_gen.exe stim_C2.txt C2 -> exit 0; 46 lines; idle sidecar: "0", "0"
    sha256(stim_C2.txt) = cc1e85a4c5f871226f07b4792446d63c523577dcf172d6c4a80b8a3e845b44a7  (new)
```

**Diagnostic driver, `Arrival.start_lanes`/`.start_cycles`/`.gaps`/`.is_clean`
read directly off the constructed schedules — checked against CD §10.1/§10.2's
own frozen text word for word, not inferred:**
```
=== case 0 ===  start_lanes: 0     start_cycles: 0
=== C1 ===      start_lanes: 4     start_cycles: 0
=== C2 ===      start_lanes: 0,4   start_cycles: 0,10   gaps: 12   is_clean: true
```
C1: lane 4, cycle 0 — CD §10.1's own claim ("a lane-4 start ON CYCLE 0
where the obvious `12` would have been … on cycle 3") confirmed directly,
not merely by construction of the multiple-of-4 argument. C2: frame 0 at
lane 0/cycle 0 (sighted placement preserved for frame 0, CD §10.2's own
claim); frame 1 at lane 4/cycle 10, consistent with `arrival.mli`'s own
documented 10/11-cycle alternation and with CD §10.2's own recorded
consequence ("frame 1's start character lands in lane 4"); the single
inter-frame gap measured at exactly 12 octets — CD §10.2's own "minimum
inter-frame gap … 12 octets," confirmed as a MEASURED property of the
constructed schedule, not merely the value passed to `~ifg`.

**Second diagnostic driver, `Arrival.frames`/`.delivered`/`.check`/`.cycles`:**
```
=== case 0 ===  frame 0: start_octet_time=0  start_lane=0  delivered_len=60   check: [] (conformant)   cycles: 12
=== C1 ===      frame 0: start_octet_time=4  start_lane=4  delivered_len=60   check: [] (conformant)   cycles: 12
=== C2 ===      frame 0: start_octet_time=0  start_lane=0  delivered_len=60
                frame 1: start_octet_time=84 start_lane=4  delivered_len=60   check: [] (conformant)   cycles: 22
```
`delivered_len=60` on every frame in both new cases, matching CD §10.1's
and §10.2's own "60 delivered octets" claim (REQ-103: 64 octets DA-through-
FCS minus the 4 FCS octets). `check: []` on both — `Arrival.check`'s own
conformance verdict, empty on every case, confirming no accumulator or
schedule-conformance issue exists in either construction (the dispatch's
own stop-rule for C2 never engaged).

**Third diagnostic driver, delivered-octet equality between case 0 and C1
("otherwise case 0's frame"):**
```
case0 delivered = C1 delivered: true
case0[0:8] = 02 00 00 00 00 01 02 00
C1   [0:8] = 02 00 00 00 00 01 02 00
```
Confirms C1 carries the IDENTICAL 60 delivered octets as case 0 — only the
start-lane placement differs, exactly as `WO-0078` §6.2's table cell and CD
§10.1 both state ("otherwise case 0's frame").

```
$ git status --porcelain
 M test/cosim/stimulus_gen.ml
```
Exactly one file changed in the repository checkout; nothing from local
testing leaked in (all scratch files remained under scratchpad, outside the
checkout).

**What is CI-deferred, and why.** The Hardcaml-dependent producer
(`ours_run.ml`) and the Verilog reference (`tb_xgmii_rx_64.v`) were not
touched this round and were not exercised locally or in CI by this round —
neither needed to be, since neither file changed and §2.2's own finding
(restated in the dispatch) is that a second clean frame needs no
accumulator change in either. The landing `cosim` CI job remains the first
and only real execution of C1's and C2's stimulus through the actual
Hardcaml design and the actual Icarus reference, exactly as every prior
round in this lane has disclosed (ADR-0005). What this round's local
verification adds, beyond that CI run, is a genuine (non-stub) confirmation
that `stimulus_gen.ml` itself — the file this round actually edits —
compiles, links, and produces the exact schedules CD §10.1/§10.2 freeze,
including reproducing case 0's own CI-pinned hash exactly, before any CI
run of this landing exists.

### Outcome
DoD (WO-0078 §11, "Stage 2, per landing — tb_writer") met:
- [x] The case(s) added (C1, C2), each with its `stimulus_sha256` computed
      locally and confirmed distinct from case 0's and from each other
      (the harness's own printing of these values at landing time is
      `run_cosim.sh`'s job, data_wrangler's own Stage-2 half, not
      commissioned by this dispatch).
- [x] Case 0 untouched — proven by byte-identity of the construction span
      AND by re-executing `build ()` and reproducing the exact CI-pinned
      sha256.
- [x] Construction parameters (`~first_start`, `~ifg`, `~sequence`) each
      tied to a spec/CD citation in an adjacent comment; no expected value
      taken from the reference, from a prior run, or from `libs/**` — none
      was needed, since this round's own deliverable is the stimulus
      construction itself, not a comparator expectation.
- [x] Journal entry (this one) + WO-0078 §14 Return-log entry appended.

Not commissioned by this round and not attempted: C3, C4 (separate
landings per §6.2); any file under `tools/cosim/**` (data_wrangler's own
half; `run_cosim.sh` was read, not staged); any file under
`test/attack_plans/**` (dv_lead's own; both CD and the packet were read,
neither staged).

Handoff: WO-0078 §14, this round's own Return-log entry, appended below
this journal entry's own commit — for dv_lead's review, via the
orchestrator.

### Open-questions
None. No spec ambiguity was met; no RTL leaked into context (confirmed:
`libs/**`, `top/**`, `rtl_snapshots/**` opened at no point, by grep of this
entry's own Inputs list as well as by direct recollection of every file
read); no untestable requirement; no licensing-taint suspicion (no
Essenceia-derived material in any input this round); no effort anomaly (the
round tracked in line with §9's own per-landing estimate of one worker
round).

### Files-in-this-commit
- test/cosim/stimulus_gen.ml
- agents/handoffs/WO-0078_cosim-phase2-3-stimulus-widening.md

---

## [J-tb_writer-0036] 2026-08-06T12:07Z | task:WO-0078 | `FINDING RV-0078-S2-1` repair — the admission span split from the delivery FIFO in both producers, plus the fixture pair the finding names

### Trigger
Orchestrator, dispatching the `FINDING RV-0078-S2-1` (MATERIAL) repair round —
"the settlement entry RV-C1C2-SETTLEMENT ... the amended text governs your
fixtures", per WO-0078 §14's `RV-C1C2` and `RV-C1C2-SETTLEMENT` entries. No
explicit "work-order id + spawn UTC timestamp" token (PROTOCOL §4.1's literal
form) was present in this round's own dispatch prompt — recorded honestly
here per `J-data_wrangler-0001`'s and this same packet's own prior tb_writer
entries' precedent (`J-tb_writer-0035`; the Stage-1 repair round immediately
below `RV-STAGE1` in WO-0078 §14) for the identical situation, rather than
presented as a token copied verbatim: the timestamp above is this entry's own
UTC header time, `date -u` read at the start of this round, matching the
environment's own `currentDate` context (2026-08-06).

### Inputs
- **Abort-first head check**: `git rev-parse HEAD` = `b221232d9b3e69c9a8ed6476bfcc569163ab69dd`,
  exactly the dispatch's stated spawn-head. `git status --porcelain` empty.
  Proceeded without the mismatch procedure.
- `agents/charters/tb_writer.md` (full read, this round).
- `agents/PROTOCOL.md` §2–6, §10 (full read, this round).
- `agents/handoffs/WO-0078_cosim-phase2-3-stimulus-widening.md`, read in full
  across several page-reads (3502 lines at spawn) — §§0–14 in full, with
  particular weight on: §14's `RV-C1C2` §4 (the finding's full text, the
  measured arithmetic — frame 0's `/T/` at octet 72/line 9, frame 1's `/S/`
  at octet 84/line 10 — and the six-item successor rule), `RV-C1C2` §5
  (C2's void-and-re-run disposition, the `stimulus_sha256` bind
  `cc1e85a4c5f871226f07b4792446d63c523577dcf172d6c4a80b8a3e845b44a7`,
  unamended), `RV-C1C2` §6 (the five findings, `S2-1` MATERIAL), `RV-C1C2` §7
  (the dispatch-shorthand ruling — read for the general rule it states about
  a dispatch's restatement of a committed artefact, not because this round's
  own dispatch conflicted with anything committed), and
  `RV-C1C2-SETTLEMENT` §§0–4 in full (criterion 7's amendment — settled
  ground, not reopened by this round; `S2-4`'s CD annotation; `S2-3`'s
  ruling that §7 is not annotated). §12 criterion 7 (both the amended text
  and the superseded text quoted beneath it) read in full to confirm this
  round's fixture pair answers to the amended limbs (a)/(b)/(c), per the
  dispatch's own instruction.
- `test/attack_plans/CD-xgmii_rx_64_cosim.md` §10.0, §10.1, §10.2, §10.2-bis
  read in full — §10.2's frozen C2 instance (unedited by this round, and not
  opened for editing: `test/attack_plans/**` is dv_lead's write scope, not
  mine) and §10.2-bis's annotation (confirming the falsified "needs no
  accumulator change" clause and the mechanism this round repairs, and that
  the annotation itself specifies nothing — the successor rule is
  `RV-C1C2` §4's, which is what this round implements).
- `test/cosim/ours_run.ml` (the file this round edits) — read in full before
  editing, then re-read after each edit via the Edit tool's own diff.
- `test/cosim/tb_xgmii_rx_64.v` (the file this round edits) — read in full
  before editing, then re-read after each edit.
- `test/cosim/compare.ml` — read in full, NOT edited. Read specifically to
  determine whether the fixture pair belongs there (the dispatch's own
  conditional: "ONLY if the fixture pair lives there") — it does not:
  `compare.ml` depends only on `canonical.ml` and the standard library (its
  own header comment: "so the comparator itself never needs a working
  Hardcaml toolchain to build or to run --self-test"), has no import of
  `Xgmii_word`, `Stream_word` or `accumulate`, and its `self_test` exercises
  only already-produced canonical files — the guard this finding convicts
  fires (or does not) BEFORE either canonical file exists, so no fixture
  built at compare.ml's own level of abstraction can exercise it.
  `compare.ml`'s own `reference_refusal_canon_text` fixture (FI-7's sentinel
  shape) was checked against this round's edit to confirm its literal text
  ("E word-with-no-open-frame") is unchanged — confirmed, since this round
  did not edit that `$fwrite` line's string argument.
- `test/cosim/stimulus_gen.ml` — NOT opened, at any point, this round (§4
  item 6's own bar: "It may not touch `test/cosim/stimulus_gen.ml`"; the
  dispatch's own "NOT stimulus_gen.ml" instruction). Confirmed absent from
  `git status --porcelain` at return.
- `test/xgmii/xgmii_word.mli` — read in full (DV-side link-partner model,
  not RTL): `start_lane`, `lane`, `is_control`, `terminate_char`,
  `Control`/`Data` — the exact vocabulary `has_terminate` (new, both
  producers) is built from, mirroring `start_lane`'s own scan shape.
- `test/monitors/stream_word.mli` — read in full (DV-side, not RTL):
  `of_octets`, `idle`, confirming both carry no Hardcaml dependency (own
  header comment), which is what makes the self-test's fixtures buildable
  with the bare system `ocamlc`.
- For local verification only, read (not staged, not part of any
  deliverable): `test/xgmii/xgmii_word.ml`, `test/monitors/stream_word.ml`,
  `test/cosim/canonical.ml`/`.mli` (the concrete implementations behind the
  interfaces above, all DV-side or already my own file, read to build a
  standalone local compile-and-link-and-RUN of the edited `accumulate`
  against the real DV-side types, not a hand-written stub) and
  `test/monitors/dune`/`test/xgmii/dune`'s own header comments (confirming
  neither `dv_monitors` nor `dv_xgmii` carries a Hardcaml dependency).
- `git show HEAD:test/cosim/ours_run.ml` (read-only, via `git show`, not
  edited) — the PRE-repair `accumulate`, extracted to build the negative
  control (`old_accumulate_check.ml`) proving the fixture pair is
  load-bearing.
- **No `libs/**`, no `top/**`, no `rtl_snapshots/**` — opened at no point, by
  any means, this round.** Every file listed above is `agents/**`, `test/**`
  (DV-side or `test/cosim/`, my own write scope) or read-only inspection of
  `test/attack_plans/CD-xgmii_rx_64_cosim.md` (dv_lead's, not staged). No RTL
  reached this seat's context at any point.

### Reasoning
**The rule, derived from the finding's own §4, not invented here.** `RV-C1C2`
§4 already states the successor rule in full — two spans, an admission span
closed at the frame's own input `/T/` and a delivery FIFO closed by output
`tlast` — so this round's own design work was translating that written
derivation into both producers identically, not re-deriving it. The one
choice the finding leaves open is *how* to detect "this same frame's own
terminate character" on the input side; I chose the same eight-lane scan
shape `Xgmii_word.start_lane` already uses (mirrored in Verilog as the
identical `c[k] && d[8*k +: 8] == target` shape the existing admission check
already uses for `8'hFB`), so the closing condition is symmetric with the
opening one by construction rather than by a second, differently-shaped
mechanism.

**Why a FIFO, not a second single-slot variable.** The finding's own §4 item
1 says "delivery span is a FIFO of admitted frames in admission order" —
not optional machinery, because C2's own stimulus (and any future case with
tighter timing) can admit frame 1 before frame 0's own delivery is complete
(the exact one-cycle overlap the finding measured), so at that instant TWO
frames are simultaneously "admitted but not yet delivered." A single-slot
replacement for `open_frame` would have reproduced the same conflation one
level down. `ours_run.ml`'s FIFO is a plain OCaml list (`@`-appended at the
tail, popped at the head) since nothing bounds how many frames could in
principle overlap; `tb_xgmii_rx_64.v`'s FIFO is a fixed-depth array
(`DELIVERY_DEPTH = 8`) because Verilog-2001 has no dynamic array, with its
own overflow guard as a new, by-construction-unreachable-for-this-case-set
refusal — disclosed per this file's own established §2.3 convention (the
metadata-sidecar guard earlier in the same file sets the precedent for
"found while repairing, flagged as such, not silently added") rather than
silently introduced.

**Why the fixture pair lives in a new `ours_run.ml --self-test`, not
`compare.ml`, decided by tracing the dependency graph rather than by
guessing at the dispatch's phrasing.** The dispatch's own wording is
conditional — "`test/cosim/compare.ml` ONLY if the fixture pair lives there"
— which reads as leaving the venue to be determined by where the fixture
pair actually CAN live, not as a default. `compare.ml`'s own header states
its whole design point: it depends on nothing beyond `canonical.ml` and the
standard library "so the comparator itself never needs a working Hardcaml
toolchain to build or to run --self-test." `accumulate` is upstream of
either canonical file's existence — the refusal this finding is about
happens before `Canonical.write_file`/`$fwrite "F ..."` is ever reached — so
no fixture expressed as two `.canon` files (compare.ml's own vocabulary)
could exercise the guard itself, only a hand-simulated CONSEQUENCE of it
(e.g. a canonical file with a frame missing its `D` line), which would test
`Canonical.read`'s tolerance for malformed input, not the guard `accumulate`
itself runs. `ours_run.ml`'s own header comment already documents
`accumulate` as "exercisable on a hand-built trace with no DUT, no simulator
and no elaboration" — an affordance already asserted, never previously
used — so adding `--self-test` there, mirroring `compare.ml`'s own CLI
convention (`<binary> --self-test`, PASS/FAIL per case, aggregate OK/FAILED,
a process exit code), is the venue the finding's own preconditions select,
not a preference between two equally valid options.

**The two fixtures' construction, chosen to be the SMALLEST trace that
reproduces the finding's own measured arithmetic, not the real C2 stimulus
scaled down arbitrarily.** Content (octets, tuser) is arbitrary throughout —
the same convention every `compare.ml` self-test fixture already uses
("this is a comparator self-test, not a co-simulation vector," that file's
own `sample_transaction` comment) — because `accumulate`'s admission/
delivery bookkeeping does not read frame content at all. What IS load-
bearing: fixture (i)'s line 3 carries frame 1's own `/S/` on the INPUT side
and frame 0's own `tlast` on the OUTPUT side, in the SAME iteration — this
is the literal one-cycle overlap `RV-C1C2` §4 measured at real C2 (frame 0's
input `/T/` at line 9, frame 1's input `/S/` at line 10, frame 0's output
`tlast` at cycle 10), scaled down from "input line 9/10, output cycle 10" to
"input line 1/3, output line 3" while preserving the one structural fact
that matters: the OUTPUT completion and the SECOND `/S/` land in the same
processed word. A trace that separated them by even one more line would not
have exercised the exact hazard the finding names — I checked this
deliberately rather than picking round numbers.

**The negative control, and why it is not optional.** `RV-C1C2` §4 item 5's
own words — "without it the repair is unfalsifiable in the direction that
matters" — apply to fixture (ii) (the still-refusing case) against a
regression where the narrowing silently deletes the guard. I extended the
same discipline one step further, in the Reasoning rather than the
deliverable: built the byte-for-byte PRE-repair `accumulate` in scratchpad
and ran it against fixture (i)'s own trace, confirming it RAISES the exact
failure the finding describes. This is not part of the shipped self-test
(the shipped pair tests the REPAIRED code, as it must) — it is this round's
own proof that fixture (i) is load-bearing rather than vacuously true of
both the old and the new code, the same "reproduces the uncorrected
failure" standard `RV-C1C2` §7 commended in data_wrangler's own
dispatch-shorthand correction, applied here to my own fixture rather than to
a case-id spelling.

**Case 0 / C1 invariance, argued structurally rather than by re-running
either case (neither is executable here, ADR-0005).** Both are single-frame
stimuli; the REQ-110 guard's `if !admission_open` branch is never taken for
either (there is no second `/S/` to take it on), so the only code path
either case can reach is the one where `admission_open`/the FIFO push
happen exactly where `open_frame`'s two writes used to happen, and the only
close either case can reach is the one where the FIFO's sole head is popped
on the frame's own `tlast`, exactly where `close_frame`'s write used to
happen. Every write site that produces an observable (the `F`/`W`/`D` lines
in both files) is therefore reached by the SAME code, at the SAME point in
the iteration, with the SAME inputs, for either case — the repair changes
WHEN `admission_open` closes internally, but that closing is consulted by
nothing except the start-character guard, which neither case's stimulus
ever re-enters. This is `RV-C1C2` §10's own "a single-frame stimulus cannot
trip the defect" argument, applied one level further (to prove bit-identical
OUTPUT, not merely "does not trip the guard").

**Promotion discipline.** No `[%expect]` block and no waveform in this
round's deliverable — `ours_run.ml --self-test` prints PASS/FAIL text, not a
waveterm snapshot, so charter §3's waveform-eyeball clause does not apply
literally; what stands in its place is reading the actual printed self-test
output (both fixtures' titles, PASS/FAIL, and the raised message's full
text) against the finding's own stated mechanism, word for word, which the
Evidence section below records verbatim rather than summarized.

### Actions
- Read the WO-0078 packet in full, the charter, PROTOCOL §2–6/§10, and
  CD-xgmii_rx_64_cosim.md §10.0/§10.1/§10.2/§10.2-bis.
- Edited `test/cosim/ours_run.ml`: added `has_terminate`; replaced
  `accumulate`'s `open_frame` single-slot state with `admission_open` (bool)
  and `delivery_queue` (FIFO list), splitting the REQ-110 guard from the
  orphan-output guard onto the two respectively; added
  `self_test_start_word`/`self_test_terminate_word`/`self_test_idle_out`/
  `self_test_tlast_out` (fixture-building helpers), `min_ifg_two_frame_trace`,
  `req110_abort_trace`, `self_test_check`, `self_test`; wired `--self-test`
  into the CLI dispatcher ahead of the Hardcaml-dependent `run` path;
  updated the file's own header comment (a new "Two spans, tracked
  separately" section) and `accumulate`'s own doc comment.
- Edited `test/cosim/tb_xgmii_rx_64.v`: added `has_terminate` (a Verilog
  function); replaced `frame_open`/`frame_index` with
  `admission_open`/`admission_index` and a `DELIVERY_DEPTH`-bounded FIFO
  (`delivery_index`/`delivery_head`/`delivery_tail`/`delivery_count`);
  rewrote `open_frame` to push the FIFO and open `admission_open` together
  (with a by-construction-unreachable overflow guard); renamed
  `close_frame_accept`/`close_frame_discard` to
  `close_delivery_accept`/`close_delivery_discard`, now popping the FIFO's
  head; updated the admission check to test `admission_open` alone and the
  orphan-output check to test `delivery_count == 0` alone; inserted the new
  `has_terminate`-based admission-span-closing check between the two;
  updated the file's own top-of-file comment block and the "Stimulus +
  capture" section comment. Confirmed the orphan-output guard's own
  `$fwrite(out_fd, "E word-with-no-open-frame\n")` line's string argument is
  byte-for-byte unchanged (compare.ml's own self-test reproduces it by
  value).
- Built a local, non-stub compile-and-link-and-run environment in
  scratchpad from real DV-side sources (`xgmii_word.{ml,mli}`,
  `stream_word.{ml,mli}`, `canonical.{ml,mli}`, plus two one-line wrapper
  files reproducing dune's own library-wrapping), extracted
  `ours_run.ml`'s pure-logic span (everything except the Hardcaml-dependent
  opens/aliases/`run`, copied byte-for-byte) into `ours_run_pure.ml`,
  compiled, linked and RAN it — see Evidence.
- Built `old_accumulate_check.ml` (the PRE-repair `accumulate`, extracted
  from `git show HEAD:test/cosim/ours_run.ml`, diffed by eye against that
  exact span to confirm fidelity) as a negative control, confirmed it
  raises on fixture (i)'s own trace where the repaired code does not — see
  Evidence.
- Confirmed `git status --porcelain` shows exactly two changed files,
  `test/cosim/ours_run.ml` and `test/cosim/tb_xgmii_rx_64.v`, and nothing
  else in the repository checkout (no stray artifact from local testing
  leaked in; `iverilog`/`vvp` confirmed absent, ADR-0005).
- Appended a Return-log entry to `WO-0078` §14 (see Files-in-this-commit).
- No `dune`, no `git commit`, no `git push`, no `iverilog` run against the
  repository checkout itself (only the bare system `ocamlc`, and only
  inside scratchpad, on copied files). I never run git.

### Evidence
```
$ git rev-parse HEAD
b221232d9b3e69c9a8ed6476bfcc569163ab69dd        # exact spawn-head, matched

$ git status --porcelain     # before any edit
                                                 # (empty)

$ which iverilog vvp
                                                 # (not found, ADR-0005 confirmed again)
```

**The real-source local build of the edited `accumulate`, genuinely
type-checking and linking the new code (not a stub):**
```
$ ocamlc -c xgmii_word.mli && ocamlc -c xgmii_word.ml     -> exit 0 (each)
$ ocamlc -c stream_word.mli && ocamlc -c stream_word.ml   -> exit 0 (each)
$ ocamlc -c canonical.mli && ocamlc -c canonical.ml       -> exit 0 (each)
$ ocamlc -c dv_xgmii.ml && ocamlc -c dv_monitors.ml        -> exit 0 (each)
$ ocamlc -c ours_run_pure.ml                               -> exit 0, no warnings
$ ocamlc -o ours_run_pure.exe xgmii_word.cmo stream_word.cmo canonical.cmo \
    dv_xgmii.cmo dv_monitors.cmo ours_run_pure.cmo          -> exit 0 (linked)
```

**Run, real execution, both fixtures, printed verbatim:**
```
$ ./ours_run_pure.exe
ours_run --self-test: (FINDING RV-0078-S2-1, i) minimum-IFG two frames -- second start AFTER frame 0's own input terminate
  PASS: accumulate did not raise; both frames closed Accept -- a lawful minimum-IFG schedule is admitted, and the FIFO correctly attributes the overlapping output word to frame 0
ours_run --self-test: (FINDING RV-0078-S2-1, ii) genuine REQ-110 abort -- second start WHILE frame 0's admission span is open
  PASS: accumulate raised "ours_run: a second start character arrived while a frame's admission span was open -- REQ-110 abort handling is out of Phase 1's authorised stimulus (WO-0046 section 9)"
ours_run --self-test: OK
$ echo $?
0
```
Eyeballed, not merely exit-code-checked: fixture (i)'s PASS text confirms
BOTH frames closed `Accept` (not merely "did not raise" — a version that
raised zero frames or misattributed the overlapping word would also "not
raise" under a weaker check); fixture (ii)'s PASS text confirms the raised
message's full text, including "admission span was open" and the REQ-110/
WO-0046 citation, not just that SOME exception fired.

**Negative control — the fixture is load-bearing, demonstrated:**
```
$ ocamlc -c old_accumulate_check.ml && ocamlc -o old_accumulate_check.exe \
    xgmii_word.cmo stream_word.cmo canonical.cmo dv_xgmii.cmo dv_monitors.cmo \
    old_accumulate_check.cmo
$ ./old_accumulate_check.exe
old_accumulate: RAISED "ours_run: a second start character arrived while a frame was open -- REQ-110 abort handling is out of Phase 1's authorised stimulus (WO-0046 section 9)"
```
The PRE-repair `accumulate`, run against fixture (i)'s exact trace, raises
the finding's own defect; the repaired `accumulate` (previous block) does
not. Fidelity of the negative control checked against the real HEAD text:
```
$ git show HEAD:test/cosim/ours_run.ml | sed -n '152,202p'
   # (matches old_accumulate_check.ml's copied span, modulo comments)
```

```
$ git status --porcelain
 M test/cosim/ours_run.ml
 M test/cosim/tb_xgmii_rx_64.v
```
Exactly two files changed; nothing from local testing leaked in (all scratch
files remained under scratchpad, outside the checkout).

**What is CI-deferred, and why.** `tb_xgmii_rx_64.v`'s own mirrored repair
was not executed locally or in CI by this round — `iverilog` is not present
(ADR-0005, reconfirmed above) — and is self-reviewed line by line against
`ours_run.ml`'s own (locally executed) repair, exactly as every line of that
file has been since `WO-0046`. The landing `cosim` job at the C2 re-run
remains the first and only real execution of either producer's repaired
guard through the actual Hardcaml design and the actual Icarus reference,
and the first place `FINDING RV-0078-S1-4`'s still-open reference-emission
gap could close (not owed by, and not closed by, this round — C9). Case 0's
and C1's own stimulus was not re-executed this round; their invariance is
argued structurally in Reasoning above, not reproduced as a hash, because
neither `stimulus_gen.ml` nor `ours_run.ml`'s Hardcaml-dependent `run` path
was opened or run.

### Outcome
DoD met, against the finding's own six-item successor rule and the
dispatch's four numbered deliverables:
- [x] One rule (admission span / delivery FIFO), stated once, applied
      identically in both producers, from the finding's own text.
- [x] A second `/S/` after the first frame's own input terminate is lawful
      (fixture i, PASS); a second `/S/` while the input frame is still open
      still refuses, same guard, same REQ-110 citation (fixture ii, PASS).
- [x] Both fixtures present, neither optional, in the venue the finding's
      own dependency graph selects (`ours_run.ml --self-test`, not
      `compare.ml`, per Reasoning).
- [x] `stimulus_gen.ml` untouched (confirmed by `git status --porcelain`
      throughout).
- [x] Case 0 / C1 invariance argued structurally (Reasoning), since neither
      is locally executable here.
- [x] CI-deferred checks named explicitly (Evidence), per ADR-0005.
- [x] Journal entry (this one) + WO-0078 §14 Return-log entry appended.

Not commissioned by this round and not attempted: any file under
`test/attack_plans/**` (dv_lead's own; CD read, not staged); any file under
`tools/cosim/**` (data_wrangler's own; not opened); `compare.ml`,
`canonical.{ml,mli}`, `stimulus_gen.ml` (read where relevant, none staged —
see Reasoning for why compare.ml specifically was not the right venue).

Handoff: WO-0078 §14, this round's own Return-log entry, appended below this
journal entry's own commit — for dv_lead's review, via the orchestrator, as
the precondition for the C2 re-run.

### Open-questions
None. No spec ambiguity was met (the finding's own §4 fully determines the
rule); no RTL leaked into context (confirmed: `libs/**`, `top/**`,
`rtl_snapshots/**` opened at no point, by grep of this entry's own Inputs
list as well as by direct recollection of every file read); no untestable
requirement; no licensing-taint suspicion (no Essenceia-derived material in
any input this round); no effort anomaly (one round, as `RV-C1C2` §6's own
"Carrier: a tb_writer repair round" names it).

### Files-in-this-commit
- test/cosim/ours_run.ml
- test/cosim/tb_xgmii_rx_64.v
- agents/handoffs/WO-0078_cosim-phase2-3-stimulus-widening.md
