# Journal: claude_dv_lead_agent — volume 05

- **Agent**: dv_lead (Opus 5 lead)
- **Charter**: agents/charters/dv_lead.md
- **Format**: v1 — entry grammar in agents/PROTOCOL.md §4
- **Volume**: 05
- **Continues-from**: J-dv_lead-0124
- **Previous-volume**: agents/journals/claude_dv_lead_agent.v04.md
- **Previous-volume-sha256**: 796e4da887a8a7d773eedf405088fc882051ec35618da66720556606dacade22
- **Previous-volume-bytes**: 281944

This file is APPEND-ONLY. Content may only ever be added after the last line;
nothing above it is ever edited. Enforced by scripts/agent_commit.sh and CI.
Volume 04 is FROZEN: it is never appended to again, and any change to it breaks
this file's Previous-volume-sha256.

---

## [J-dv_lead-0125] 2026-08-09T10:30Z | task:WO-0070 | Family L designed as a two-stage round whose opening gate is a cost probe that never enters history — and the co-sim adjudication I owed convicts my own frozen document of a scope error whose correction the same document already carries

### Trigger

Orchestrator dispatch, spawn short-id `WO-0070/2026-08-09T10:30Z`, HEAD
`d2bdd57`. The commission is my own: `RV-0068B-VERDICT` §9 item 3 and §10's
queue read put family L first among the three remaining families, and §10
attached two hazards to be written **into** its packet rather than discovered —
the Cyclesim cost of a 10 000-frame run, and derivation completeness under
`RV-0068-VERDICT` §9.2's rule. The dispatch also calls in §10's first output, the
co-sim Phase-1 adjudication, and it carries the journal rotation: v04 crossed
ADR-0017's soft threshold `S` at `13bc5b7` and this entry opens volume 05.

A prior spawn of this dispatch was wiped by a container-level infrastructure
event before anything landed. Nothing of it exists in the tree and nothing was
salvaged or deferred to; this round is the first that produced files.

### Inputs

Read at `d2bdd57`, all read-only:

- `agents/charters/dv_lead.md`; `agents/PROTOCOL.md`.
- `docs/adr/ADR-0017-a-journal-is-a-chain-not-a-file.md` (the rotation
  procedure, §4.3's header fields and §4.4's four steps);
  `docs/adr/ADR-0005-build-environment.md` (no dune at the review or worker
  seat; CI authoritative).
- `agents/handoffs/WO-0068_m03-family-n-completion.md` — `RV-0068-VERDICT` §9.2,
  §9.3, §9.4 and §10, and `RV-0068B-VERDICT` §1, §4, §5, §7, §8, §9, §10, §11.
- `agents/handoffs/BUG-0003_m03-lane-4-injected-word-cycle.md` §V.2, §V.10.1–4 —
  the probe-with-decision-rule-first precedent and its transient-model execution.
- `docs/specs/modules/xgmii_rx_64.md` §6.1 (the `m + 3` formula, its gapless
  qualifier, D(m) and its two consequences), §7 (the timing contract table), §8
  (the line-rate stress obligation), §9.
- `docs/specs/requirements.md` REQ-004, REQ-005, REQ-015, REQ-018, REQ-020,
  REQ-103, REQ-105, REQ-107, REQ-108, REQ-901 and §13's change-log rows for the
  (e)/(f) diff.
- `test/attack_plans/AP-xgmii_rx_64.md` §1, §2, §3, §4.L, §6, §7 (banner and
  X-1/X-5 rows), §7's "Not gaps" paragraph and its 2026-08-09 note.
- `test/attack_plans/CD-xgmii_rx_64_cosim.md` in full.
- `test/xgmii/arrival.mli` and `arrival.ml:21-67,115-145`; `test/xgmii/frame.mli`
  and `frame.ml:1-47`; `test/monitors/octet_time.mli` and
  `octet_time.ml:1-12,203-295`; `test/xgmii_rx_64/bench.mli` in full and
  `bench.ml:18-83,424-462`; `test/xgmii_rx_64/dune`; `test/cost_probe/dune` and
  `cyclesim_cost_probe.ml`; `test/cosim/dune` and `stimulus_gen.ml`;
  `tools/cosim/run_cosim.sh` header; `tools/dv_checks.sh` §census;
  `.github/workflows/build.yml`.
- `agents/journals/claude_orchestrator_agent.md:1612-1651` — the committed
  `COST-PROBE` figures and their CI run id.
- `tasks/BOARD.md`'s WO-0070 row and census line.

**No `libs/**`, no `top/**`, no `rtl_snapshots/**` was opened at any point.**
Every expected value in `WO-0070` derives from the spec sections above and from
DV-owned machinery interfaces; none comes from the design.

### Reasoning

**1. Why the probe is a throwaway ref and not a committed file, which was the
round's largest design decision.** `test/xgmii_rx_64/dune` declares one
`(library)` with `(inline_tests)` and no `(modules …)` partition, so anything
added there runs inside the main `dune runtest` step — a step measured at three
seconds. The cost family L mints is therefore **recurring**, paid by every agent
on every commit until `P1-phase-accept`, and that reframes the probe: it is not
sizing one run, it is sizing a tax.

Three candidate homes. A committed probe on the `runtest` alias is the cost it
exists to measure, and I have the tree's own proof that "delete it once the
figure is recorded" is not executed — `test/cost_probe/`'s first line says
exactly that, its figure was recorded at CI run `30729880948`, and the directory
is still on the alias four weeks later. A worker-built probe committed for one
round and deleted in the next needs a worker round and leaves the tax standing
across every commit in the window. The throwaway ref costs one CI run and
nothing else, and if band C fires it leaves the programme carrying nothing at all
while an E2 is adjudicated. That third ground is what decided it: the failure
branch of a probe should not be more expensive than its success branch.

The execution model is not invented for this round. `BUG-0003` §V.2 specified a
dv-authored, print-only, zero-assertion probe; §V.10.1 records it running at CI
`30947784963` on ref `mut/bug3-sev-probe` under PROTOCOL §10's transient model,
with nothing entering history and one disclosed step-ordering deviation
adjudicated rather than absorbed. I am reusing that, and I authored the source
myself rather than commissioning it, for the same reason that packet did: it is
~90 lines over entry points I have read at this tree, and a worker round for it
would cost more than the round it is supposed to protect. **The risk I accept and
state: I cannot compile OCaml here (ADR-0005), so a compile failure costs one
run.** `WO-0070` §1.7 names the one construction risk — the dependency on an
`(inline_tests)` library — with its symptom and its remedy, in the instrument's
own terms rather than in my prediction of them, which is `RV-0068B-VERDICT` §8
item 1's rule applied to my own next packet instead of merely recorded in the
one that minted it.

**2. Why the decision rule bands on three measured quantities and not on one.**
A single total cannot select a remedy. Five phase timers let the band-B table
name one remedy per dominant phase, fixed **before** the figure is known — which
is the whole content of "pre-committed": a rule chosen after the number arrives
is not a rule, it is a rationalisation. The three bands key on `T` (total at
10 000), `R` (the 10 000-to-1 000 ratio) and `H` (peak heap growth), and every
one of them is a quantity the probe itself prints, so no band depends on a
runner specification I cannot verify from a committed artefact. The two time
thresholds — 30 s and 180 s — are **chosen**, and the packet says so rather than
dressing them as derived.

The Φ2 row is the one I want on the record: **its remedy is "none, and that is
the pre-commitment."** Standing obligation 5 is not negotiable, so if
`Arrival.check` dominates, its cost is reported and accepted and the band is
still decided on a `T` that includes it. Writing a remedy table without a
no-remedy row is how a cost table becomes a menu of things to weaken.

The other pre-commitment worth naming: **the frame count is not reduced inside
DV under any circumstances.** §8's 10 000 is a frozen specification figure.
Narrowing it is charter §7's E2 with options, recommendation and cost — never a
bench parameter. Band C says so and offers three options rather than one.

**3. Why the constants were re-derived and not transcribed.** `RV-0068-VERDICT`
§3.4's L = 16 / 12 and ΔC = 3 are four days old and this packet seals five rows
onto them. I re-derived all three at `d2bdd57`: h from `octet_time.ml:7`'s
`front_offset = strip_octets + start_lane` and, independently, from the tagger's
own observed-h computation at `:207-208`; ΔC from SPEC-M03 §6.1's `m + 3`
formula at `m = 0`, which counts from the start **word** and so gives 3 at both
lanes; and L twice — once as `8ΔC − h`, once directly in octet times, where the
output octet time `8c + 24 + j` and the input octet time `s + 8 + j` cancel `j`
entirely.

That cancellation turned out to be the round's most useful derivation, because
it is also M03-L5's answer: **L is length-independent by construction**, so the
directed set introduces no new constant. Which then raised the honest question of
what M03-L5 is for at all, and the packet answers it rather than leaving the row
to look like ceremony: the derivation is about the specification, and the row is
where the *design* is asked whether its delay varies with the final `tkeep`
residue. A row whose expected value is unsurprising is worth writing precisely
when the surprise would be a defect.

**4. Derivation completeness — §9.2's rule, applied to five rows.** The rule I
minted last round after ordering a field cross-checked without deriving its
value: *every field a packet orders cross-checked must have its expected value
derived in the packet, or be explicitly marked as the executor's to derive with
the derivation named.* Applied here it produced §4.1's thirteen-row table,
§4.2's strobe-by-strobe derivation of the empty set, §5's two whole class
records with their frame and octet counts, §6's four items plus the joint
argument that they pin "8 or 12 and no other value", §7's sequence range, and
§8.1's nine-length table. Nothing in family L is ordered checked.

Two things fell out of doing it exhaustively that I would not have found by
sampling. **First, a vacuity trap**: `bench.mli`'s R5-3 rule makes
`assert_monitors_clean` demand the latency tagger's verdict *only once
`frames_compared` is positive*, so a row that fed the tagger nothing passes it in
silence. Every L unit must assert `frames_compared` explicitly, and `BL8` makes
its absence a bounce. **Second, an overlap I would rather state than have found
against me**: §8 puts REQ-020's sequence number inside the payload, so M03-L1's
positional content check already compares octets 14–17 and **M03-L4 is implied by
M03-L1 on this stimulus**. The packet says so, and says what M03-L4 adds anyway
(the direct REQ-020 reading through the field decoder, in delivery order). A
`SO-` presenting them as two independent pieces of evidence would be inflating
its own coverage, and the place to stop that is here.

**5. The unit structure is forced, not preferred.** Four units would re-drive the
10 000-frame stimulus four times. One unit whose title names four row ids counts
four rows under `tools/dv_checks.sh`'s trailing-digit-boundary matcher, which I
checked at `:296` rather than assumed. So the packet fixes two units and makes a
second `Bench.run` in unit 1 a bounce — and names the worker's natural instinct,
one unit per row, as trap T1.

**6. §5.3's rule, run over this document rather than written at the end of it.**
Last round I minted the rule that a bar's commands must be executable by the seat
assigned to run them, then violated it three pages later by assigning
`dv_checks.sh` to a seat whose Bash scope could not run it. So this packet's
§12 assigns every bar by seat **in the table itself**: six bars are mine (git
diffs, `dv_checks.sh`, the CI step reading, and the cell-by-cell constant check),
and the worker's ten are executable with Read, Grep, Glob and
`ocamlc -stop-after parsing` alone. And §9.4's lesson is discharged the other
way round: I checked every bar for the name-grep-for-an-expression defect, found
that all four name-greps in §12 are about **named call sites** — which is the
case a name-grep is the correct instrument for — and wrote `BL12` to say so
rather than leaving a reader to wonder whether I had checked.

**7. The BOUNCE table's repair.** `RV-0068-VERDICT` §9.3 recorded that B1–B16
covered placement, shape, scope, source, naming and claim-making and **nothing
covered "an asserted expected value is wrong"**. `BL1` is the general condition
(any unit red at CI for any reason) and `BL2` is the specific one (an asserted
value differs from a value this packet derives, *whether or not CI is green*).
The second clause matters: a green wrong constant is reachable wherever the
assertion is vacuous, which is exactly what `BL8` is about.

**8. The co-sim adjudication: folded in, not carried.** The dispatch offered
either. I folded it in, as its own file, because it needs no run to settle —
every input is a committed artefact or an externally verifiable CI run id — and
because my own rule is that an undated carrier is how a debt becomes a habit. A
debt I can pay in the round it comes due should not be given a date.

Writing it produced two findings against my own text, and the second is the
larger. **CD §0-bis's closing sentence — "For the M03 pairing the
permitted-divergence set is EMPTY" — is false at the scope it is written at**:
REQ-901 gained classes (e) and (f) at the M03 boundary at `ebb3f49`, and CD's own
§2-bis carries the resolution block naming them. The sentence is true of the
64-to-1518-octet range and true of Phase 1's own domain instance, and the memo
tabulates all three scopes rather than picking one. It has already propagated
into `tools/cosim/run_cosim.sh`'s check-4.1 comment, where a future phase driving
a runt would read it and mis-adjudicate its own result. The repair is a dated
annotation beside §0-bis under CD §9's change discipline, never an edit inside a
frozen entry, and it is carried to the batched `AP-` round because
`test/attack_plans/**` is not in this round's write scope.

**The second finding is against `AP-xgmii_rx_64.md` §7's banner**, and Phase 1
is its counterexample. The banner says *"no `SO-` PASS may rest on the model
until it has run."* The co-simulation **has** run. Read literally the condition
is discharged, which is plainly not what it means and not what the evidence
supports: Phase 1 injects nothing, so it anchors no cell of X-1(ii), whose
subject is injected frames. The condition the sentence should state is
per-class — *no `SO-` PASS may rest on a computed outcome of X-1(ii) for a
stimulus class the co-simulation has not driven* — which is checkable and makes
CD §6's phase distribution the schedule for discharging it rather than a list of
predictions.

**9. What I deliberately did not do.** I did not repair CD, `run_cosim.sh` or the
AP: none is in this round's write scope, and the round's file set is exactly what
the dispatch scoped. I did not order `test/cost_probe/` deleted as a stage-2
bounce condition — it is my housekeeping debt, not the worker's, and `WO-0070`
§14 item 4 names stage 2's commit as its carrier without convicting an executor
of it. And I did not re-adjudicate the `SO-` anchor precondition itself; the memo
sharpens its wording and moves nothing.

### Actions

- Rotated the journal: created `agents/journals/claude_dv_lead_agent.v05.md`
  with ADR-0017 §4.3's five chain fields computed from v04's blob at HEAD, and
  wrote this entry as its only content. **v04 is not touched and is not staged.**
- Authored `agents/handoffs/WO-0070_m03-family-l-line-rate-stress.md`: fifteen
  sections plus Appendix A, covering the cost probe and its pre-committed
  decision rule (§1), the schedule derivation (§2), the latency constants
  re-derived at this tree (§3), the five rows (§§4–8), the forced unit structure
  and assertion order (§9), twelve traps (§10), the two-path scope (§11), the
  sixteen-bar review table assigned by seat (§12), twelve BOUNCE conditions
  (§13), five carried debts (§14), the return format (§15), and the probe source
  with its dune stanza (Appendix A).
- Authored `agents/handoffs/WO-0046_cosim-phase-1-adjudication.md`: the Phase-1
  run and its three checks, four things discharged, six not, two findings against
  my own committed text, the ruling, and the three next steps in yield order.
- Ran no command whose effect moves HEAD, the index or any ref. All git use was
  read-only (`git log`, `git rev-parse`, `git status`, `git branch --show-current`,
  `git show HEAD:<path>`).

### Evidence

**The rotation's chain fields, recomputed rather than recalled:**

```
$ git show HEAD:agents/journals/claude_dv_lead_agent.v04.md | sha256sum
796e4da887a8a7d773eedf405088fc882051ec35618da66720556606dacade22  -
$ git show HEAD:agents/journals/claude_dv_lead_agent.v04.md | wc -c
281944
$ sha256sum agents/journals/claude_dv_lead_agent.v04.md
796e4da887a8a7d773eedf405088fc882051ec35618da66720556606dacade22  agents/journals/…v04.md
```

Worktree and HEAD blob agree, which is ADR-0017 §4.3's own note that the
predecessor is unmodified by the rotation commit. `281944 > 262144` = `S`, so the
rotation is due; it is below `H` = `524288`, so it is a soft-threshold rotation
and not a refusal. The last entry id in v04 is `J-dv_lead-0124`
(`grep -n '^## \[J-dv_lead' agents/journals/claude_dv_lead_agent.v04.md | tail -1`),
which is this volume's `Continues-from` and makes this entry `0125` under R5.

**The latency constants, re-derived at this SHA:**

```
$ sed -n '7p;9,12p' test/monitors/octet_time.ml
let front_offset ~strip_octets ~start_lane = strip_octets + start_lane
let word_cycles ~front_offset l =
  let sum = l + front_offset in
  if sum < 0 || sum mod 8 <> 0 then None else Some (sum / 8)
;;
```

At `strip_octets = 8` (`test/xgmii_rx_64/bench.ml:74-80`'s tagger
configuration): h = 8 at lane 0, h = 12 at lane 4. SPEC-M03 §6.1's `m + 3` at
`m = 0` gives ΔC = 3 at both lanes; `word_cycles ~front_offset:8 16 = Some 3`
and `word_cycles ~front_offset:12 12 = Some 3`, both closing mod 8. **All four
cells agree with `RV-0068-VERDICT` §3.4** and the agreement is recorded as a
re-measurement rather than as a transcription.

**The schedule, derived from `arrival.ml:30-62`'s layout loop** (`ifg = 12`,
`first_start = 8`, `floor_gap = min 12 9 = 9`, `credit = 0` throughout, so
`shorten = 0` and `next = round_up_4 (terminate + 12) = start + 84` at every
frame): start octet times `8 + 84 i`; lanes alternating 0 and 4; start cycles
`1 + 21k` and `11 + 21k`; spacings alternating 10 and 11; every gap 12; frame
9999 at octet time 839 924, cycle 104 990, lane 4; `Arrival.cycles` =
`((839 996 + 12 + 7) / 8) + 1` = **105 002**; 105 010 cycles driven at
`~drain:8`; 80 000 delivered samples; 600 000 delivered octets. Reproduce by
reading `arrival.ml:21-28` and `:30-62` and evaluating the recurrence.

**The census matcher**, checked rather than assumed:
`tools/dv_checks.sh:296` matches `"${census_r}([^0-9]|\$)"` against the
extracted unit titles, so one unit title naming four row ids moves the census by
four. Current figures at `2dbd39b`, quoted with their run id per §7's own rule:
census 48 of 62, `test/xgmii_rx_64/` inventory 54, repository-wide 134, CI
`build` **30988038809**.

**The co-sim run** (ADR-0003/F5 permitted form (b), externally verifiable): CI
`build` run **30988038809** at `2dbd39b`, job **92247281222** (`cosim`),
conclusion **success**. Its stimulus is fixed by `test/cosim/stimulus_gen.ml:41-42`
— one `Frame.stress_frame ~sequence:0 ()` at `Arrival.create ~first_start:0`,
i.e. one clean 64-octet good-FCS frame at a **lane-0** start — and its three
checks by `tools/cosim/run_cosim.sh`'s "THE THREE CHECKS" block.

**The committed cost figures the probe's predictions extrapolate from**:
`agents/journals/claude_orchestrator_agent.md:1625-1626` — 3.42 M cycles/s at 1
register, 1.77 M at 8, 653 k at 32, CI run **30729880948**. These are a
*synthetic* design and bound only the `Cyclesim.cycle` term of Φ4; the whole
point of the new probe is that the bench-path terms are unmeasured.

**No OCaml was compiled and no simulation was run this round.** ADR-0005 makes
CI the authority and this round produces no OCaml on the working branch; the
probe's own execution is scheduled at stage 1, on a throwaway ref, and its
figures do not exist yet. Nothing in `WO-0070` claims a measured runtime.

**HEAD integrity**: `git rev-parse HEAD` = `d2bdd57cf35e190c624f8779443fee2cc0add10a`
at spawn and unchanged at return.

**Working-tree integrity — and it did NOT hold, which is reported rather than
repaired.** `git status --porcelain` was **empty** at spawn. At return it carries
this round's three new files **plus three modified files that are not mine and
that I did not touch**:

```
 M agents/handoffs/WO-0069_spec-queue-3-m03-hook-and-strobe-multiplicity.md
 M docs/specs/modules/xgmii_rx_64.md
 M docs/specs/requirements.md
?? agents/handoffs/WO-0046_cosim-phase-1-adjudication.md
?? agents/handoffs/WO-0070_m03-family-l-line-rate-stress.md
?? agents/journals/claude_dv_lead_agent.v05.md
```

They are **architect_docs_lead's WO-0069 return, in flight in the same working
tree**: the packet's state moves ISSUED → RETURNED with a Return log citing
`J-architect_docs_lead-0031`, and the two specification files carry that round's
three hunks. `docs/**` is outside my write scope (PROTOCOL §6) and I have not
opened either file for writing; every read I made of them was read-only and is
recorded above. **I have not repaired, reverted, staged or annotated any of the
three.** Open-questions item 6 states the consequence for the committer.

**Whether the concurrent edits invalidate this round's derivation basis:
measured, and they do not.** `git diff --stat` reports
`docs/specs/modules/xgmii_rx_64.md | 3 +-` and
`docs/specs/requirements.md | 53 ++++++` — 53 insertions and **zero deletions**
in requirements.md, so no existing sentence there moves at all, and the SPEC-M03
change is one replaced row plus one added row. Read line by line, the SPEC-M03
hunk replaces **§10's REQ-802/REQ-810 verification-column row** (the C-41
zero-delivered-branch withdrawal) and adds one §13 change-log row; the
requirements.md hunk adds a **non-normative note to §0.6** on strobe
multiplicity and one §13 row. **Not touched by either: SPEC-M03 §6.1's `m + 3`
formula and its D(m) paragraphs, SPEC-M03 §7's timing-contract table, SPEC-M03
§8's stress obligation, and REQ-004, REQ-005, REQ-019, REQ-020, REQ-103,
REQ-111, REQ-112, REQ-901 and §0.5.** Those are the whole derivation basis of
`WO-0070` §§2–8 and of the co-sim memo, and every one of them is byte-unchanged
from the `d2bdd57` text I derived against.

### Outcome

DoD met for what the dispatch commissioned. `WO-0070` is authored with its five
rows fully derived, its probe designed with the decision rule pre-committed
ahead of any row, the gate line stated so the worker knows what the round is
load-bearing for, every bar assigned to a seat that can execute it, and a BOUNCE
table that now carries both a general red condition and a wrong-asserted-value
condition. The co-sim Phase-1 adjudication is **folded into this round as its own
file**, not carried. The rotation is part of this round's files rather than a
separate commit, which R5 makes impossible in any case.

Handoff: both packets to the orchestrator. `WO-0070` stage 1 is the
orchestrator's own action (a throwaway-ref probe run, PROTOCOL §10's transient
model); stage 2 is a tb_writer spawn and `BL10` makes it conditional on my
written ruling in the packet's Return log.

**No lessons-harvest note is owed this round, and the absence is declared rather
than omitted** (ADR-0018, PROTOCOL §7): the cadence is every module sign-off and
every phase gate, and this round is neither. The next one falls due at
`SO-xgmii_rx_64.md` and will span from my last harvest to that entry.

### Open-questions

1. **Two findings against my own committed text, both carried, neither in this
   round's write scope.** `CD-xgmii_rx_64_cosim.md` §0-bis's "EMPTY" sentence is
   false at the scope it is written at and has propagated into
   `tools/cosim/run_cosim.sh`'s check-4.1 comment; `AP-xgmii_rx_64.md` §7's
   *"until it has run"* is discharged by Phase 1 read literally and is not what
   it means. Both are owed to the batched `AP-` round, which is the next commit
   that opens `test/attack_plans/**`.
2. **`test/cost_probe/`'s deletion condition was met at CI run `30729880948` and
   has not been executed.** Carrier named at `WO-0070` §14 item 4 (stage 2's
   commit). Not a bounce condition — it is mine.
3. **`J-dv_lead-0094`'s malformed change-log row in `AP-xgmii_rx_64.md`** is
   **carried unchanged** from last round; the AP is not in this round's write
   scope.
4. **One disagreement with the dispatch's own numbers, stated as a
   disagreement.** The dispatch describes *"REQ-901's empty permitted-divergence
   set"* for the co-sim adjudication. At `d2bdd57` that is true of Phase 1's
   domain instance and of the 64-to-1518-octet range, and **false as a statement
   about the M03 pairing**, which carries classes (e) and (f) since `ebb3f49`.
   The operative fact for Phase 1 is unaffected; the phrasing is not, and it is
   the same phrasing my own §0-bis carries, which is why it is a finding against
   me rather than against the dispatch.
5. **STOPPED ON, NOT REPAIRED — a second agent's uncommitted work is in this
   working tree.** `git status` was empty at spawn and at return carries
   architect_docs_lead's in-flight WO-0069 return: `docs/specs/modules/xgmii_rx_64.md`,
   `docs/specs/requirements.md` and `agents/handoffs/WO-0069_…md`. Three
   consequences for the committer, none of which I may act on. **(a)** `docs/**`
   is outside dv_lead's write scope, so a commit staging my files together with
   those would be refused by **R7**, and by **R1** in any case. The two rounds
   need two commits. **(b)** The architect's journal
   (`claude_architect_docs_lead_agent.v02.md`) is **not** modified in the tree,
   yet its WO-0069 Return log already cites `J-architect_docs_lead-0031` — so its
   round is genuinely mid-flight and **R2** would refuse its half today. **(c)**
   I did not revert, stage or annotate any of the three, and nothing in my two
   packets or this entry depends on them. The Evidence section above records the
   measurement that my derivation basis is byte-unchanged by their content.
6. **One ruling I would rather have than guess**: whether the orchestrator
   accepts a dv-authored probe source running on a throwaway ref (the `BUG-0003`
   §V.2 precedent) or would rather route stage 1 through tb_writer with the probe
   committed and deleted in stage 2. I have argued for the first at `WO-0070`
   §1.2 and named the compile risk I am carrying for it; the choice is the
   orchestrator's, because it is the seat that operates the transient model.

### Files-in-this-commit

- agents/handoffs/WO-0070_m03-family-l-line-rate-stress.md
- agents/handoffs/WO-0046_cosim-phase-1-adjudication.md

## [J-dv_lead-0126] 2026-08-09T12:10Z | task:WO-0070 | Band A fires on figures I re-read out of the job log instead of taking from the dispatch — and running my own pre-committed rule found an overlap defect in it that missed mattering by one part in ninety

### Trigger

Orchestrator dispatch, spawn short-id `WO-0070-S1/2026-08-09T12:10Z`, HEAD
`d8d68db`. The commission is my own §1.5 and §1.6: stage 1 executed per §1.2 —
Appendix A materialised verbatim on the throwaway ref `mut/wo70-cost-probe-l` at
`9f3a616`, CI `build` run `31007340877` green — and `BL10` makes stage 2
conditional on my written ruling in the packet's Return log. The dispatch also
relays architect_docs_lead's landed `WO-0069` response (`b6ef1cb`) with two
statements attached to it for my acceptance or refusal.

### Inputs

Read at `d8d68db`, all read-only:

- `agents/charters/dv_lead.md`; `agents/PROTOCOL.md`.
- `agents/handoffs/WO-0070_m03-family-l-line-rate-stress.md` in full — my own
  packet at `9bdf03c`, principally §1.1–§1.7, §2.1–§2.3, §9, §11, §12, §13, §14.
- `agents/handoffs/WO-0069_spec-queue-3-m03-hook-and-strobe-multiplicity.md` §1.2,
  §1.3 and the whole `RETURNED` Return log appended at `b6ef1cb`
  (`J-architect_docs_lead-0031`).
- `git show b6ef1cb -- docs/specs/modules/xgmii_rx_64.md docs/specs/requirements.md`
  — the repaired §10 REQ-802/REQ-810 hook, the §0.6 note in full (five bullets),
  and both §13 change-log rows.
- `test/attack_plans/AP-xgmii_rx_64.md` — the `M03-N4` row (line 776) and the
  `M03-N2` T8 clause and its restatement (lines 774, 1553).
- `test/cost_probe/cyclesim_cost_probe.ml:1-12` and `test/cost_probe/dune:1-8` —
  the undischarged deletion condition, re-read at HEAD rather than quoted from my
  own packet.
- `agents/journals/claude_dv_lead_agent.v05.md` header and `J-dv_lead-0125`.
- `tasks/BOARD.md`'s `WO-0070` row.
- **CI, as primary evidence rather than as a relayed figure**: job `92310423073`
  logs (the five `COST-PROBE-L` lines, the dune action echo, the `dv_checks`
  census block) and the job's step table via the Actions API.

**No `libs/**`, no `top/**`, no `rtl_snapshots/**` was opened at any point**, and
no ref under `refs/heads/mut/` was inspected for content — only enumerated.

### Reasoning

**1. Why I re-read the figures before ruling on them, which was this round's
first decision.** The three numbers arrived in a dispatch message. §1.6's shape is
a rule fixed before the run and applied to figures nobody could re-read
afterwards — and a number in a chat message is exactly the artefact class my
charter says a verdict may not rest on when the primary source is reachable. It
was reachable: the job log. I pulled the five `COST-PROBE-L` lines out of job
`92310423073` and compared them to the relay. **Byte-identical in all five.** The
cost was two tool calls and the yield was three things I would not otherwise
have: the relay recorded as faithful (a fact about routing that PROTOCOL §3 asks
the auditor to spot-check), the step-duration reading that §7 of the ruling rests
its threshold restatement on, and a `dv_checks` census block in the same job that
re-bases bar L-14 by a second measurement.

It also produced a false alarm I had to work through and am recording so nobody
re-finds it as a contradiction: the five lines carry log timestamps spanning
**12.9 ms** against a printed CPU total of **2.304 s**. That is dune replaying
captured action output — the command echo sits inside the same 16 ms burst, which
is the tell — not a defect in the figures. **A per-line log timestamp from a
parallelising build tool is not an elapsed-time instrument**, and §1.3's choice of
`Sys.time` inside the process is what makes the figure independent of it. Had I
not checked, the honest options were to disbelieve a correct measurement or to
invent a wrong explanation for it; the third option, which is the right one, cost
one more API call for the step table.

**2. The band, and the arithmetic that selects it.** `T` = 2.036 s, `R` = 8.664,
`H` = 7 238 821 words. Band A's three clauses are each TRUE with room —
`T` clears 30 s by 14.7×, `R` clears 15 by 1.7×, and the `count` = 10 000 line
printed in full with `COST-PROBE-L end` after it, so the self-cap never engaged
and no `abort` line exists. Band B's disjunction is FALSE in all three disjuncts,
band C in both. **Band A fires alone.** Stage 2 issues with §§4–8 exactly as
written, no machinery round is interposed, no E2 is raised, and §8's 10 000-frame
figure is untouched — which was the outcome the packet was built to make the
cheap one rather than the assumed one.

**3. The defect running my own rule found, and why I am not repairing it.** §1.5's
bands are **not a partition**. The heap clause `H(10 000) > 8·H(1 000)` triggers
band B and appears nowhere in band A, so a run with a small `T`, a small `R` and a
large heap ratio satisfies **both** bands, with no tie-break written. A rule whose
purpose is to remove discretion would have handed it straight back, after the
number was known — the exact failure §1.6 exists to prevent.

Measured, the heap ratio is **7.9103** against a threshold of 8: `H(10 000)` is
**82 051 words (≈ 0.63 MiB) under** the 7 320 872 that fires band B, a margin of
**1.12%**. Of the three clauses this was by far the tightest. So the overlap
region was one part in ninety from being this round's problem, and I found it only
because applying a rule clause-by-clause forces you to read clauses you would
otherwise skim past on a comfortable number.

**I did not repair §1.5.** Rewriting a pre-commitment with the answer in hand is
worth less than the honest record of having drafted it wrong, and nothing rests on
it: A's clauses are independently TRUE and B's are independently FALSE, so no
tie-break was needed and none was exercised. The portable form is banked below.

**4. Scoring §1.4 taught more than the band did.** Three hits of eight — Φ1, Φ3,
and the ratio. **The score is not the finding; the sign is.** All five misses are
in the same direction: I over-predicted cost, by 1.9× to 27.8×, at four of five
phases and at both aggregates. A uniform-sign error across independent quantities
is one model error, not five estimating errors, and the model is identifiable —
§1.4 built most of its ranges by multiplying an operation count by an *assumed*
per-operation cost. **The single prediction that landed within 10% of the truth is
the one whose floor came from a prior measurement on the same execution surface**
(Φ4, extrapolated from `test/cost_probe/`'s 653 k cycles/s). That contrast is the
round's most portable output.

The cell §1.4 said in advance would matter — *"the prediction that matters is the
ratio, not the total"* — is the cell that hit. `R` = 8.664 is near 10 and nowhere
near 15, so the linear cost model is right in **shape** and wrong in **scale**,
which is precisely the split a ratio prediction and a magnitude prediction are
supposed to separate. Writing both was worth it.

Two mechanism findings fell out of the scoring. **Φ2 is the CRC's true price and
Φ1's is not what I said it was**: I reasoned Φ1 ≈ Φ2 because each does one CRC-32
per frame, and measured Φ1 = 2.12 × Φ2 — so at Φ2's implied ≈ 10.2 ns per
bit-step, ≈ 55% of Φ1 is frame construction and layout, a term my reasoning did
not have. My Φ1 hit was a compensating error, and I would rather say so than bank
it. **And `R` came in below the cycle ratio** (8.664 against 9.9914): Φ4 got
**12.3% cheaper per cycle** at the larger size, while the only sublinear term I
named — the binary search's log factor — pushes the other way. **I do not have the
mechanism** and have recorded it unexplained rather than furnishing one; `R`
clears its bound by 1.7× under either sign.

**5. Why the threshold restatement is a measurement and not my arithmetic.** I had
prepared an estimate: 2.036 s of CPU plus a bounded allowance for the row's own
assertion work. The job's step table made the estimate unnecessary for the part
that matters. **Step 6 measured 4 s at the probe ref against 3 s at the base**, at
one-second granularity, so the delta is weakly bounded but the absolute is firm —
**with a family-L-sized stress inside it, the test step is 4 s, bounded ≤ 5 s,
against band A's 33 s ceiling**. And the job decomposition from the same table is
decisive on the "minority of a build job" clause: `Install dependencies` 205 s +
`Set up OCaml` 75 s = **91.5%** of a 306 s job, with the test step at **1.3%**.

So the sentence I want a future reader to cite is *"the line-rate stress is under
two seconds and under two percent of a CI job"*, not *"the test step grew by a
third"* — the second is true and useless, and the first is what a decision would
ever turn on. Two honesties ride with it: the probe's Φ5 does not do the row's
per-octet comparisons, so the landed unit costs more than 2.036 s (by tens of
milliseconds at Φ2's implied rate, and inside band A by an order of magnitude even
at ten times that); and dune's parallelism makes a step's wall growth a **lower**
bound on CPU added, so the 4 s step reading is not offered as a refutation of the
2.036 s figure. I attached a rider to **my own** bar L-13 to record the step's
duration at the stage-2 landing and score this estimate against it — a rider on my
bar, adding no worker condition, because nothing in §12 or §13 says anything about
runtime and I am not inventing a bounce after the packet issued.

**6. What the probe confirms about §§2, and the line I refuse to let it cross.**
Confirmed: `Arrival.cycles` = 105 002 at 10 000 frames, §2.1's layout recurrence
at three independent sizes including frame 9999's start octet time 839 924, and
`schedule_problems = 0` — all facts about DV-owned machinery, all strengthening
the packet's base. **Not adopted**: `dsamples` and `frames` are measurements of
the **design's** output. They agree with §4.1 items 2 and 3, which were derived
from REQ-103 and REQ-015 in a committed packet before this run existed — and I
wrote the ordering down explicitly, because an agreement noticed after the fact is
exactly how a spec-derived expected value quietly acquires a design-derived
provenance, and the ordering that refutes it is only legible if someone records
it (PROTOCOL §10; `BL3`).

**7. `WO-0069` item 1 — the sharpening ACCEPTED, and it convicts a redundancy in
my own filing rather than an error.** The architect rules the emptiness rests on
the **admission clause alone**: at `c = s` the enable is 0 on A's own start cycle,
so A is never admitted and no in-flight frame exists, and §6.3 item 7 is
load-bearing only for the determinacy of the `w = s` row. **I re-derived it and it
is right.** Admission gives `c ≥ s+1`; refusal gives `c ≤ w−1` with `w ∈ {s, s+1}`;
the interval is empty at both lanes with item 7 nowhere in the argument. My
`WO-0069` §1.2 step 5 invoked item 7 to exclude `c = s` and step 6 concluded "from
3, 4 and 5" — so item 7 is carried as a premise of a conclusion that does not need
it. **Not false; redundant.** The distinction matters for exactly the reason the
architect gives: §1.5 of that packet **declines** to widen item 7 as the repair,
and a reader could otherwise think the finding depends on the clause it refuses to
move.

**8. Whether any sentence of the §0.6 note reads normative to me — NO, and the
answer is a derivation, not a courtesy.** The architect flagged the likeliest
candidate itself: *"it is why the strobe set carries no multiplicity field and is
not owed one."* Two readings. Under (a) it explains an existing design fact and
attributes it to clause 2; deleting it moves no port, field or requirement. Under
(b) — *"no module may ever carry one"* — it would bind future module
specifications and would be normative. **Reading (b) is refuted by the note's own
fourth bullet**, which keeps *"widen the encoding"* live as a disposition for a
module that can reach the collision and says in terms that such a module *"owns
its own disposition"*. A sentence cannot forbid what the sentence three bullets
later authorises. So *"not owed"* is scoped to the conformance argument — nothing
is owed because the contract is discharged by the level — and it is not a
prohibition.

I applied the same deletion test to the other three candidates and all pass:
bullet 1 restricts the multiplicity paragraph to the scope that paragraph already
states; bullet 2's *"both obligations are discharged by that one high cycle"* is
the conjunction of §12's naming, the module pin and §0.6's window, so deletion
changes no conformance verdict; bullet 5's *"neither its survival nor a sibling
class's kill is evidence…"* is a **claim** rule, its DV-side content is my own
committed `WO-0066-VERDICT` §5.2 ratified back to me, and deleting it leaves my
own classification standing. **No fresh finding is raised.** One bound on that
ruling, stated so it is a position and not a shrug: **if a later module
specification ever cites that clause to refuse a multiplicity signal its own
collision-reachability analysis requires, the sentence will have been read as
normative and that reading is the fresh finding** — raised then, narrowly, under
the standing the architect wrote.

**9. What the two rulings change in committed AP text.** Item 1's sharpening
requires **no correction**: my `M03-N4` cell already says the change must fall
*"strictly between A's start cycle and W"*, which carries the emptiness on its
own, so the cell's conclusion and premises are both sound and only the emphasis is
off. One optional clause would make the redundancy explicit. Item 2's ruling does
make two things stale in a checkable way — the *"presence per cycle and not
multiplicity"* phrasing (the architect offers *"a level per cycle"*, and it is
more accurate: presence is right about the port and wrong about the contract), and
the *"raised as an architect question"* framing at two sites, which is now
**answered**. **Carrier for all three: the batched `AP-` round**, which already
owes CD §0-bis, AP §7's per-class condition and `J-dv_lead-0094`'s malformed
change-log row. `test/attack_plans/**` is outside this round's write scope and I
did not touch it.

**10. The `§14` item 4 conflict, ruled rather than left to fire.** §14 named
*"stage 2's commit"* as the carrier for deleting `test/cost_probe/` **and** said it
is not a stage-2 bounce condition because it is my debt. §11 says stage 2 stages
exactly two paths and `BL6` bounces anything else — so a worker commit carrying my
deletion would be convicted by my own bounce table for my own housekeeping, which
is precisely what §14 disclaims. **Ruled in the Return log: the deletion rides in a
`dv_lead` commit of this round's window, never inside the worker's.** §11 and
`BL6` stand unamended and §14's intent now has a mechanism instead of an
intention.

**11. The transient residue — reported, not repaired, and larger than the round.**
The local ref was deleted; the remote deletion was refused (HTTP 403). §1.2's
*"discards the ref"* is therefore executed to the environment's limit and no
further, and the packet does not claim otherwise. **The recurring-tax failure mode
§1.2 ground 2 names did not attach** — the directory never entered the working
branch, nothing sits on the `runtest` alias, and the ref triggers no further runs;
recurring cost zero. What survives is the bookkeeping half of the same shape, and
it is recorded rather than absorbed.

Then I counted, and the residue is not this round's: **59 refs under
`refs/heads/mut/` are alive on the remote**, across `bug3-sev-probe` and the
`wo-0039`/`0041`/`0042`/`0045`/`0050`/`0058` campaign families. Mine is one of the
59 and carries **no RTL mutation at all**. I did not inspect any other ref's
content and deliberately did not. This bears on PROTOCOL §10's transient model,
whose text describes an uncommitted working tree and whose operated form is a
pushed ref — and therefore on whether "never lets mutated RTL enter history" is a
claim about the working branch or about the repository's reachable objects.
**Not mine to rule and not mine to repair**: mutation discipline is the auditor's
ledger and the transient model is the orchestrator's to operate. Raised as a
question; no artefact of this round depends on its answer.

### Actions

- Appended §1.6's ruling to
  `agents/handoffs/WO-0070_m03-family-l-line-rate-stress.md`'s Return/verdict log
  as its first entry, in eleven numbered sections: the first-hand evidence and the
  timestamp false alarm, the three figures with three internal-consistency checks,
  the full band table with every clause of all three bands evaluated, the
  overlap-defect record, §1.4's predictions scored one by one, the phase
  decomposition band A did not need, what the probe does and does not license
  about §§2, the threshold restated on measurement with a rider on bar L-13, the
  stage-2 commissioning with three band-A consequences pinned, the transient
  disposition with the 59-ref measurement, and two carriers re-pinned.
- Ran no command whose effect moves HEAD, the index or any ref. All git use was
  read-only: `rev-parse`, `status --porcelain`, `branch --show-current`,
  `log --oneline`, `show`, `diff --name-only`, `ls-remote`.
- Compiled nothing and ran no simulation (ADR-0005).

### Evidence

**The five probe lines, read from the job log rather than from the dispatch**
(ADR-0003/F5 permitted form (b) — externally verifiable, re-executable by run id):

```
$ mcp__github__get_job_logs owner=renatom11 repo=agentic-fpga job_id=92310423073 \
    return_content=true
$ grep -o 'COST-PROBE-L[^\]*'
COST-PROBE-L begin (THROWAWAY, WO-0070 §1; never committed to the working branch)
COST-PROBE-L count=100   ... total=0.033 cycles=1060   dsamples=800   frames=100   top_heap_words=360073  schedule_problems=0
COST-PROBE-L count=1000  ... total=0.235 cycles=10510  dsamples=8000  frames=1000  top_heap_words=915109  schedule_problems=0
COST-PROBE-L count=10000 schedule=0.110 check=0.052 elaborate=0.007 drive=1.831 account=0.036 total=2.036 cycles=105010 dsamples=80000 frames=10000 top_heap_words=7238821 schedule_problems=0
COST-PROBE-L end
```

Byte-identical to the relayed text in all five lines. Run **`31007340877`**, job
**`92310423073`** (`build`), conclusion **success**, head ref
`mut/wo70-cost-probe-l`, head SHA `9f3a6166a1639b3ecb2344d570f59aecffd2c447`.

**The three figures and the band arithmetic:**

```
T = 2.036                                        <= 30      TRUE   (14.7x headroom)
R = 2.036 / 0.235 = 8.664                        <= 15      TRUE   (margin 6.336)
count=10000 line printed, "end" after it                    TRUE
  => BAND A FIRES

30 < T <= 180 :  30 < 2.036                                 FALSE
R > 15        :  8.664 > 15                                 FALSE
H > 8*H(1000) :  7238821 > 8 * 915109 = 7320872             FALSE  (short by 82051 words,
                 ratio 7.9103 vs 8, margin 1.12%)
  => BAND B DOES NOT FIRE

T > 180       :  2.036 > 180                                FALSE
count=10000 line absent                                     FALSE
  => BAND C DOES NOT FIRE
```

**Internal consistency, checked before the figures were used**: each line's five
phases sum to its own printed total exactly (0.033, 0.235, 2.036); `cycles`
reproduces §2.2's arithmetic at all three sizes
(`((839 996+12+7)/8)+1 = 105 002`, `+8 = 105 010` printed; 10 502/10 510 at 1 000;
1 052/1 060 at 100); `schedule_problems = 0` at all three.

**Phase decomposition at 10 000** — `schedule` 0.110 (5.40%), `check` 0.052
(2.55%), `elaborate` 0.007 (0.34%), **`drive` 1.831 (89.93%)**, `account` 0.036
(1.77%). Dominant phase **Φ4**; its remedy row is **recorded and not executed**,
band A authorising no machinery change.

**The step reading, from the same job's step table**
(`mcp__github__actions_get method=get_workflow_job resource_id=92310423073`):

```
Install dependencies                     12:50:55 -> 12:54:20   205 s
Set up OCaml                             12:49:40 -> 12:50:55    75 s
Build                                    12:54:20 -> 12:54:28     8 s
Run tests (expect tests, waveform ...)   12:54:28 -> 12:54:32     4 s   <- probe inside
job wall                                 12:49:37 -> 12:54:43   306 s
```

Test step = **1.3%** of the job; the two dominant steps = **91.5%**. Base step at
build `30988038809` was 3 s (`WO-0070` §1.1). Both at one-second granularity, so
the *delta* is bounded only to (−1, +3) s; the *absolute* — ≤ 5 s with a
family-L-sized stress inside — is what band A's 33 s ceiling is compared against.

**Bar L-14's base re-confirmed by a second run**: `tools/dv_checks.sh` in job
`92310423073` printed `54 test/xgmii_rx_64/`, `134 test/ (repository-wide)` and
`48 named in a unit title — TRAILING-DIGIT BOUNDARY match`. The probe ref is
`d2bdd57` plus one directory with zero `%expect_test` units.

**Stage 2's base re-based and the figures shown unmoved:**

```
$ git diff --name-only d2bdd57 d8d68db
agents/handoffs/WO-0046_cosim-phase-1-adjudication.md
agents/handoffs/WO-0069_spec-queue-3-m03-hook-and-strobe-multiplicity.md
agents/handoffs/WO-0070_m03-family-l-line-rate-stress.md
agents/journals/claude_architect_docs_lead_agent.v02.md
agents/journals/claude_dv_lead_agent.v05.md
agents/journals/claude_orchestrator_agent.v02.md
docs/specs/modules/xgmii_rx_64.md
docs/specs/requirements.md
tasks/BOARD.md
```

**No path under `test/`.** Every figure `WO-0070` §§2–12 takes from the test tree
is unmoved at HEAD, so L-14's 48 → 53, 54 → 56 and 134 → 136 stand.

**The transient's disposition, verified rather than accepted** (read-only; no ref
moved):

```
$ git ls-remote origin 'refs/heads/mut/wo70-cost-probe-l'
9f3a6166a1639b3ecb2344d570f59aecffd2c447	refs/heads/mut/wo70-cost-probe-l
$ git ls-remote origin 'refs/heads/mut/*' | wc -l
59
```

**`test/cost_probe/`'s deletion condition, re-read at HEAD** rather than quoted
from my own packet: `cyclesim_cost_probe.ml:1-2` — *"THROWAWAY — WO-0009
deliverable 1. Delete this directory once the figure is recorded."* — and
`dune:1-2` carrying the same condition with *"once the cycles-per-second figure is
recorded in a journal entry with its CI run id"*. Still present at `d8d68db`.

**HEAD integrity**: `git rev-parse HEAD` =
`d8d68db7f3fe9442e76d805f2e19f6feeb96d15a` at spawn and unchanged at return;
branch `claude/fpga-hardcaml-agent-orchestration-37ceyf`. `git status --porcelain`
was **clean at spawn** — unlike last round — and at return carries only this
round's two files (the packet's Return-log append and this journal append).

**Nothing was compiled and nothing was simulated this round.** Every number above
is either read from a CI artefact identified by run and job id, or arithmetic on
those numbers shown in full.

### Outcome

DoD met. §1.6's ruling is written into the packet's Return log as its first entry
and **`BL10` is discharged**: it names the band, quotes the three measured figures
with the arithmetic that selects it, scores §1.4's predictions one by one, and —
band A having fired — names neither a remedy nor an escalation, because neither is
owed. Stage 2 is **commissioned**: the worker packet-reference is
`agents/handoffs/WO-0070_m03-family-l-line-rate-stress.md` **§§2–13 and §15 as
written and unamended**, plus this ruling as the `BL10` discharge; §0 is context,
§1 is spent, §14 is mine. Deliverable is §11's two paths, unchanged. Handoff: the
packet to the orchestrator for a tb_writer spawn.

Both `WO-0069` rulings are **ACCEPTED AS LANDED** — item 1's `UNPASSABLE` verdict
with its four-part repaired form, item 2's *a strobe is a level on a named cycle*
with its five clauses, §4 question 1's one-form-two-grounds answer and §4 question
2's correction of my operating assumption in its subject and confirmation in its
consequence. **No sentence of the §0.6 note reads normative to me, so no fresh
finding is raised**, with the revival condition stated in Reasoning 8. The item-1
sharpening requires **no correction** to committed AP text; item 2's ruling makes
two clauses stale, and all of it is carried to the batched `AP-` round.

**No lessons-harvest note is owed this round and the absence is declared rather
than omitted** (ADR-0018, PROTOCOL §7): the cadence is every module sign-off and
every phase gate, and this round is neither; the next falls due at
`SO-xgmii_rx_64.md` and will span from my last harvest to that entry. **Three
candidates are BANKED, not harvested** — banking does not open or close a span:

- **(LH2-g) Score a prediction by the provenance of its dominant term, not by its
  subject.** Classify each predicted quantity as measurement-anchored or
  unit-cost-assumed before scoring, and score the two groups separately. *Incident*:
  `WO-0070` §1.4 at `9bdf03c` against run `31007340877` — the one prediction whose
  floor came from a prior measurement on the same execution surface landed within
  10%; every prediction built from an operation count times an assumed
  per-operation cost over-predicted, by 1.9× to 27.8×, all in the same direction.
  *Without it*: a decision rule's thresholds get sized for a cost that does not
  exist, and the rule either never fires or fires on the wrong branch, while a
  hit-rate score conceals a single systematic model error as several independent
  estimating errors.
- **(LH2-g) A rule stated as bands must be shown exhaustive AND disjoint before it
  is committed, not after the measurement arrives.** For each pair of bands,
  exhibit an input satisfying both or prove none exists. *Incident*: `WO-0070` §1.5
  at `9bdf03c` — one trigger appears in the second band and in neither clause of
  the first, so a region satisfies both with no tie-break; the measurement missed
  that region by 1.12%. *Without it*: the number arrives, two bands fire, and the
  author chooses between them with the answer in hand — which is the discretion the
  pre-commitment existed to remove.
- **(LH2-g) A tool that captures a subprocess's output and replays it later stamps
  the replay, not the execution.** Take elapsed time from a clock inside the
  measured process or from the executor's own accounting; never from per-line
  timestamps on captured output. *Incident*: run `31007340877`, where 2.304 s of
  in-process CPU appears inside a 12.9 ms log span. *Without it*: a correct
  measurement is disbelieved, or a wrong explanation is invented to reconcile it —
  and both outcomes look like diligence.

### Open-questions

1. **59 `mut/*` refs are alive on the remote and no inventory of them exists.**
   `tasks/BOARD.md` contains no `mut/` string; the only record is prose scattered
   through verdicts. Whether one should be minted, and where, is the
   orchestrator's — it operates the transient model. Related and also not mine:
   PROTOCOL §10's text describes an **uncommitted working tree** while the operated
   form is a **pushed ref**, so whether *"never lets mutated RTL enter history"* is
   a claim about the working branch or about the repository's reachable objects is
   open. **Reported, not repaired**; mutation discipline is the auditor's ledger.
   No artefact of this round depends on the answer.
2. **§1.5's band overlap is recorded and deliberately unrepaired** (Reasoning 3).
   If a future packet reuses this band shape, the overlap must be closed **in the
   new packet before its run**, never in this one after it.
3. **`test/cost_probe/`'s deletion is still owed**, carrier re-pinned by this
   ruling to a `dv_lead` commit of this round's window rather than the worker's
   commit — because `BL6` plus §11 would otherwise convict the executor of my
   housekeeping.
4. **Carried unchanged to the batched `AP-` round**: CD §0-bis's stale sentence
   and its copy in `tools/cosim/run_cosim.sh`'s check-4.1 comment; AP §7's
   *"until it has run"* per-class repair; `J-dv_lead-0094`'s malformed change-log
   row; **and now** the two `WO-0069` consequences — the *"presence per cycle"* →
   *"a level per cycle"* phrasing at two sites, and the now-answered
   *"raised as an architect question"* framing.
5. **One estimate that is not yet a measurement**: the landed unit's own cost. The
   probe's Φ5 omits the row's per-octet comparisons, sequence read-back and record
   comparisons. Bar L-13 carries my rider to read the test step's duration at the
   stage-2 landing and score this ruling's ≤ 5 s expectation against it. A miss
   there is a finding against **this** ruling, never against the worker.

### Files-in-this-commit
- agents/handoffs/WO-0070_m03-family-l-line-rate-stress.md
