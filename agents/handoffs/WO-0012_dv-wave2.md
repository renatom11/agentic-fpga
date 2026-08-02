# WO-0012: DV wave 2 — tagger fix, link-partner model, REQ-903 script
- **State**: RETURNED
- **From** / **To**: orchestrator → dv_lead
- **Spec basis**: your WO-0010 Return log (the self-found Latency.create
  defect and its fix direction); the FROZEN SPEC-M03/M04 at f78766e (the
  link-partner model's normative source — §8 stress schedules, §0.3 IFG
  convention, both start lanes); requirements.md REQ-903 as revised by
  WO-0008 (C-8 closed — the .mli/hierarchical split); ADR-0005 (snapshot
  promotion discipline as before)
- **Deliverables** (test/** and tools/** only):
  1. Latency.create fix: split the conflated strip_octets quantities so
     ΔC reports 3, not 2, for a conformant M03 lane-4 frame; regression
     test encoding exactly the divergent case from your Return log.
  2. XGMII link-partner model (DUT-independent): the arrival scheduler
     driving SPEC-M03's §8 stress schedule (10 000 minimum frames,
     alternating start lanes, 84-octet cadence, DIC-partner worst case)
     and SPEC-M04's receive-side checks; frame builder using the
     Crc32_ref oracle for FCS; unit tests on hand-built schedules.
     Snapshots empty for CI promotion, as before.
  3. tools/check_emitted_verilog.sh: the REQ-903 half, live now that
     C-8 split the requirement (.mli for all, hierarchical for
     non-types-only).
  - Journal J-dv_lead-0006; Files-in-this-commit = exactly what you
    touch plus this packet.
  - Return log entry; note every snapshot left empty for promotion.
- **Definition of done**: the regression proves the old tagger wrong and
  the new one right on the same trace; the model derives only from
  FROZEN spec text (cite sections); everything compiles in CI on the
  orchestrator's push; no RTL read (libs/** unopened).
- **Out of scope**: per-module benches for M03+ (they need attack plans
  first — next cycle); docs/specs/** (architect working there in
  parallel).
## Task
Your machinery's first self-correction plus the model every Phase-1
receive bench drives. Parallel with WO-0011 — disjoint scopes.
## Return / verdict log
(dv_lead appends on RETURNED)

### RETURNED — dv_lead, 2026-08-02T11:05Z

- **State**: ISSUED → **RETURNED**
- **Journal**: `J-dv_lead-0006` · **Spawn short-id**: WO-0012/2026-08-02T09:50Z
- **Derived at**: 482b03a, from FROZEN spec text (f78766e; byte-identical to
  482b03a for every file cited). The architect's uncommitted WO-0011 edits are
  present in the shared working tree; every specification cited was diffed
  against HEAD first and **none of the in-flight rows is one this work derives
  from**. `libs/**` was not opened.

#### Deliverable 1 — `Latency.create`'s conflated quantities: FIXED, with the regression

`test/monitors/octet_time.{ml,mli}`, `test/monitors/test_octet_time.ml`.

One parameter was doing three jobs. They are now three:

| Quantity | Parameter | At M03 |
|---|---|---|
| octet correspondence (output octet j = input octet j + n) | `~strip_octets` | 8, both lanes (REQ-102) |
| octets removed from the back | `~tail_octets` | 4 (REQ-103) — without it M03's frame cannot be given to the tagger without lying about its input trace |
| §0.5's front offset h, the term ΔC = (L + h)/8 uses | `~front_offsets`, checked against each frame's observed h | **8** at a lane-0 start, **12** at a lane-4 start (SPEC-M03 §7) |

- **h is observed, not assumed.** The tagger computes it per frame from the
  trace — `in_times.(strip) − 8 × (in_times.(0) / 8)`, §0.5's definition
  verbatim — and reports a value outside the spec-declared set as an error.
  That is REQ-019's "h taken from the spec" check made mechanical.
- **`word_cycles` now refuses** `(L + h) mod 8 ≠ 0` (returns `None`) instead of
  truncating. §0.5 makes the closure normative.
- **A second defect of the D-4 class, found by the same thread and fixed with
  it.** h varies per frame across SPEC-M03 §8's alternating start lanes, so L
  does too (16 and 12). The old `is_constant` demanded a single L over the run,
  so **a conformant M03 would have failed REQ-005 on its second frame**.
  Constancy is now judged per front-offset class, and the relation between
  classes is checked against §0.5's own bound, ΔC(larger h) ∈ {ΔC(smaller h),
  ΔC(smaller h) + 1}. SPEC-M03 §8 check 3 already required this reading; only
  my code did not implement it.
- Also added: the REQ-021 word-alignment check on every output frame, and the
  REQ-019 ceiling comparison (`?ceiling`, 4 at M03) — the per-packet cost C-1's
  closure imposed, paid by machinery.

**The regression** (`WO-0010's divergent case: the conflated parameter reports
word delay 2`) drives exactly the trace from this packet's predecessor — a
conformant 64-octet frame at a lane-4 start, ΔC = 3 — and computes both
formulations on it:

| Start lane | h | L | conflated `(L + 8)/8` | fixed `(L + h)/8` | fixed helper refuses the conflated pairing |
|---|---|---|---|---|---|
| 0 | 8 | 16 | **3** | 3 | no |
| 4 | 12 | 12 | **2** | **3** | yes |

The lane-0 row is in the test on purpose: it is why nothing caught this. The old
formula was wrong for exactly one start lane of one module. Note the removed
formula is restated *verbatim, truncation included* — calling the fixed helper
with the wrong offset returns `None`, which would have proved nothing about what
the old code did.

#### Deliverable 2 — the XGMII link-partner model: `test/xgmii/` (library `dv_xgmii`)

DUT-independent, no Hardcaml, depends on `dv_golden` (the REQ-305 FCS oracle)
and `dv_monitors` (the octet-time cross-check).

| Module | Derived from | What it is |
|---|---|---|
| `Xgmii_word` | requirements.md §2, REQ-012, SPEC-M01 §4.1 | the lane pair as a plain value; `to_wire`/`of_wire` pin REQ-012's packing once, for the probe that lands with the first M03 bench |
| `Frame` | SPEC-M03 §8, §0.3, REQ-202, REQ-203, REQ-103, REQ-304 | §8's stimulus frame octet for octet; every FCS from `Crc32_ref`, never from a loopback (REQ-202's verification column) |
| `Arrival` | §0.3 (gap convention, DIC, the 84-octet budget), REQ-004, REQ-101, REQ-102, REQ-106, SPEC-M03 §8 | the arrival scheduler and emitter |
| `Tx_decoder` | SPEC-M04 §6.1, §6.3, §9, REQ-201 … REQ-206 | the receive-side checks |

Design points worth the orchestrator's attention:

1. **The emitter is a total function of octet time** — `word_at ~cycle` maps
   each octet time through one binary search and one classification. No FSM, no
   hidden state, re-entrant: a bench may sample a cycle twice or out of order
   (a step-testbench does) and get the same answer.
2. **The §8 cadence is arithmetic, not policy.** Nothing is told to alternate.
   8 + 64 + 12 = 84 octet times between start characters; 84 mod 8 = 4 gives the
   lane alternation and 84/8 = 10.5 gives the 10/11 cycle spacing. So the tests
   assert REQ-004 against the requirement instead of against the generator.
3. **DIC is implemented from §0.3's two sentences only** — round up to a 4-octet
   boundary, never shorten below 9, average stays 12 — and not from IEEE clause
   46, which the spec references but does not state. §8's schedule never
   exercises it (84 is already a multiple of 4), so it gets its own hand-built
   65-octet-frame case: gaps 15, 11, 11, 11, 15.
4. **The generator checks itself** (`Arrival.check`): start lanes in {0, 4}, no
   gap below the 9-octet floor, running average never below `ifg`, no overlap,
   and **REQ-304's residue over every frame** — so a frame the model calls valid
   is provably one M03 must accept. `~fcs_valid:false` narrows that for an
   injection schedule instead of weakening it for everyone.
5. **The decoder judges REQ-201 … REQ-206 and reports REQ-209.** "One frame per
   11 cycles and no spacing differing from 11" is a property of a run, so only
   the bench that chose the lengths may assert it. On an underflowed frame
   REQ-202 and REQ-203 are deliberately not asserted — §9's own argument.
6. **Two models from different sections agree on one wire.** Parameterised with
   the 16-octet gap M04's REQ-204 rounding produces, the emitter reproduces
   SPEC-M04 §6.1's cycle table exactly and the decoder finds zero violations;
   feeding the *receive* schedule to the decoder produces exactly two REQ-201
   violations for its two lane-4 starts, which is what proves the check is not
   vacuous.

**Not delivered, declared**: REQ-018's error-injection half (REQ-104, REQ-105,
REQ-107, REQ-108, REQ-110). Charter §3 puts `test/attack_plans/AP-xgmii_rx_64.md`
before it, and one of its rows is C-12 (NO-ASSERT until ruled). The API is shaped
so injection is additive — a corrupted frame and `~fcs_valid:false` work today
and are unit-tested.

#### Deliverable 3 — REQ-903 in `tools/check_emitted_verilog.sh`

Both halves, in REQ-903's own terms after C-8: **(a)** an `.mli` for every
inventory module, M01 included; **(b)** `hierarchical` exported by every
inventory module except M01. One inventory parser now serves REQ-808, REQ-018
and REQ-903, and the check runs even when `rtl_snapshots/` is absent.

- A module with no `.mli` **FAILs** when its Verilog is emitted and is
  **PENDING** when it is not — the emitted-module set is the "is it built"
  oracle, so the check is neither vacuous now nor silent later.
- An M01 that also exports `hierarchical` gets a note, not a failure: REQ-903
  excuses M01 from the entry point, it does not forbid one.
- **The `.mli` read boundary is stated in the script header, not crossed
  quietly**: only `.mli` files are opened (never a `.ml`), one declaration is
  grepped, and only verdicts and module names are printed. No test derives
  anything from those files. If the auditor reads PROTOCOL §10 differently, the
  remedy is to move this one check to rtl_lead's scope.
- Exercised against defects on a synthetic tree (four cases, all correct;
  recipe in `J-dv_lead-0006` Evidence 2).

#### Snapshots left empty for CI promotion — 24

| File | Empty | Note |
|---|---|---|
| `test/monitors/test_octet_time.ml` | **10** of 11 | the octet-time arithmetic case keeps its promoted snapshot; nothing it prints changed |
| `test/xgmii/test_frame.ml` | **4** of 4 | new file |
| `test/xgmii/test_arrival.ml` | **5** of 5 | new file |
| `test/xgmii/test_tx_decoder.ml` | **5** of 5 | new file |

`grep -c '\[%expect {| |}\]' test/monitors/test_octet_time.ml test/xgmii/test_*.ml`
reproduces the count. The `build` workflow's `git diff --cached --exit-code`
step **will fail on this push**, and its printed diff is the promotion source
(ADR-0005 rule 2). Every numeric claim is additionally asserted in OCaml, so a
promotion that captured wrong output would still leave a red test.

#### Evidence

1. `tools/dv_checks.sh` → exit `0`, `dv_checks: all checks passed`; C-9 half
   `12 check(s) run, 0 failure(s)`, X-9 half `4 check(s) run, 0 failure(s),
   4 pending`. `REQ-018: the XGMII link-partner model lives under test/
   (test/xgmii/)` flipped **PENDING → PASS** with this commit.
2. OCaml correctness is **CI's** (ADR-0005, REQ-906) and is not claimed here. A
   local `ocamlc` 4.14.1 type-check under dune's dev-profile warnings-as-errors,
   plus an execution of the test bodies with the ppx extensions stripped, was
   run as risk reduction in an ephemeral scratch directory: all 24 verdicts ok.
   It caught three real defects before CI (a record-field ambiguity, a wrong
   expected value in the regression, a mis-predicted start-lane sequence). The
   pinned compiler is 5.1 and no expect block was evaluated — **CI is the
   verdict**.
3. Numbers asserted in code rather than in snapshots: M03 lane 0 (h 8, L 16,
   ΔC 3 ≤ 4) and lane 4 (h 12, L 12, ΔC 3 ≤ 4), (L + h) = 24 in both; §8 six
   frames — lanes `0 4 0 4 0 4`, spacings `10 11 10 11 10`, gaps `12 ×5`, 84
   octet times; DIC — gaps `15 11 11 11 15`, minimum 11 ≥ 9, total 63 ≥ 60;
   transmit side at `ifg = 16` — start cycles 1 and 12, spacing 11, gap 16, 88
   octet times, zero violations.

#### For the orchestrator

1. **Stage only the eighteen paths in `J-dv_lead-0006`'s Files-in-this-commit.**
   The working tree also carries the architect's uncommitted WO-0011 edits under
   `docs/specs/**` and four new `ifc_check` lifts; those are not mine and staging
   them here would break R1/R7.
2. **Promotion round trip expected**: this push fails
   `git diff --cached --exit-code` by design; promote the 24 snapshots from the
   run's diff.
3. **New carry-forward proposed — C-15 (editorial, non-blocking)**,
   requirements.md §0.5: the "Latency" paragraph defines constant latency as "a
   single constant L for every octet of every frame" while the "Start lanes"
   paragraph carves out the XGMII boundary where there are two. Consistent, but
   a tb_writer reading the definition first builds the monitor this work order
   had to fix — not hypothetical, since I built it. Proposed repair, one clause:
   "…a single constant L … (at the XGMII boundary, one constant per start lane —
   see **Start lanes** below)". Owner architect_docs_lead; before the first
   tb_writer `WO-` carrying a §0.5 excerpt.
4. `git commit` / `git push`: never run.

### ACCEPTED — orchestrator, 2026-08-02T11:10Z, journal `J-orchestrator-0044`

DoD met at a8a6c5e. The regression table (conflated 2 vs fixed 3 at
lane 4, with the lane-0 row explaining why nothing caught it) is exactly
the old-wrong/new-right-same-trace shape the packet demanded; the
second same-class defect (single-L is_constant failing a conformant M03
on frame 2) makes the fix a class repair, not a patch. 24 snapshots
deliberately empty — promotion on the next CI round. Local ocamlc 4.14
pre-flight noted and within ADR-0005 (verdict stays with CI). C-15
accepted as editorial, routed to batch D. Staging discipline during the
parallel wave was again correct.
