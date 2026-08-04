# Journal: claude_dv_lead_agent — volume 03

- **Agent**: dv_lead (Opus 5 lead)
- **Charter**: agents/charters/dv_lead.md
- **Format**: v1 — entry grammar in agents/PROTOCOL.md §4
- **Volume**: 03
- **Continues-from**: J-dv_lead-0090
- **Previous-volume**: agents/journals/claude_dv_lead_agent.v02.md
- **Previous-volume-sha256**: 0c6bb3686a1537b2d0c5b7153672801ff8e7a51a2bf4eb38cd63a636231b9f26
- **Previous-volume-bytes**: 273809

This file is APPEND-ONLY. Content may only ever be added after the last line;
nothing above it is ever edited. Enforced by scripts/agent_commit.sh and CI.
Volume 02 is FROZEN: it is never appended to again, and any change to it breaks
this file's Previous-volume-sha256.

---

## [J-dv_lead-0091] 2026-08-07T20:10Z | task:none | Volume 03 opened — and the one thing worth saying about a second rotation is that this one was NOT forced: v02 sits in the warn band, not above `H`, so R10 would have taken the append and the choice to rotate is mine to defend

### Trigger
Orchestrator dispatch, step 0 of the BUG-0003 confirm round at `b848d56`:
create volume 03 before anything else, with the chain fields computed rather
than accepted, and commit the new volume alone.

### Inputs
- `docs/adr/ADR-0017-a-journal-is-a-chain-not-a-file.md` §4.3 (the header block
  and why the back-link is the load-bearing part), §4.4 (the rotation commit),
  **§5.1 (the thresholds and what anchors them)**, §5.2's disposition table.
- `agents/PROTOCOL.md` §4, §4.1, §4.2, §5 (`R2`, `R3`, `R5`, `R10`).
- `scripts/agent_commit.sh` lines 79–145 and 173–181 — the R10 checks I am
  about to be graded by, read so the header is written against the checker and
  not against my memory of the ADR.
- `scripts/policy.sh` lines 13–14 — `JOURNAL_SOFT_MAX` 262144,
  `JOURNAL_HARD_MAX` 524288.
- **`agents/journals/claude_dv_lead_agent.v02.md` at HEAD** — its entry-header
  tail and its committed bytes, both through `git show HEAD:`, not from disk.
- My own `J-dv_lead-0073` (the volume-02 rotation) as the form.
- **No `libs/**`, no `docs/reports/audit/**`, no `scripts/` writes.**

### Reasoning

**Every chain field is computed, and the one I was told is verified against the
tree rather than against the dispatch.** `Continues-from` was given as
`J-dv_lead-0090`; `git show HEAD:agents/journals/claude_dv_lead_agent.v02.md |
grep '^## \[J-dv_lead-'` ends on **J-dv_lead-0090**, so the join point is right.
`Previous-volume-sha256` is the sha256 of the **committed blob**, taken through
`git show HEAD:` and cross-checked against the worktree copy, which
`git diff --stat` reports byte-clean on that path — so the hash describes a state
that exists in history, which is the whole point of the field. Bytes: 273,809,
the same figure `wc -c` gives on both.

**The honest fact about this rotation, stated because the last one did not have
to state it.** v02 is **273,809 bytes — over `S` (262,144) and well under `H`
(524,288)**. `agent_commit.sh` line 178 refuses only above `H`; line 180 emits
`WARN-JOURNAL` above `S`. So unlike the volume-02 rotation — where v01 stood at
1,123,442 bytes, **2.14 × H**, and the next append was mechanically impossible —
**this rotation is elective**. R10 would have taken the append. I record that
plainly because the alternative is a journal that implies its rotations are all
forced, and an auditor comparing `J-dv_lead-0073` against this entry would find
the difference and be right to ask why neither entry mentioned it.

**Why rotate anyway, given it is elective.** Three reasons, in order of weight.
(i) The dispatch asked for it, and a rotation is a clerical act with no evidence
content — declining an instruction that costs nothing and forecloses nothing
would be obstruction dressed as rigor. (ii) The boundary is a genuinely good
one: v02's last entry (`J-dv_lead-0090`) **opened** BUG-0003, and the first
entries of this volume **close** its behavioural half — a reader who opens v03
gets the confirm round from its first byte rather than joining a packet
mid-flight. (iii) v02 would cross `H` inside this phase on its current growth
(the last eight entries average ~4 KB and this round alone will add three), so
the rotation is due within a handful of rounds regardless; doing it at a packet
boundary is strictly better than doing it at whatever entry happens to trip the
refusal.

**What I did not do.** I did not touch v02 — not one byte, which R10 line 126
checks by comparing the staged and HEAD blob ids and which is also the reason
`Previous-volume-sha256` is meaningful at all. I did not seed or read any other
agent's journal into this commit. I did not fold any work product into the
rotation: `Files-in-this-commit` is `- (none)` and the commit carries
`Journal-Only: true`, so the rotation is separable in the log from the promotion
and the verdict that follow it, exactly as the dispatch ordered them.

### Actions
- Created `agents/journals/claude_dv_lead_agent.v03.md` with the ADR-0017 §4.3
  header block (Volume 03, Continues-from J-dv_lead-0090, Previous-volume
  `agents/journals/claude_dv_lead_agent.v02.md`, sha256 and bytes as computed)
  and this entry as its first.
- Computed, not copied: sha256 and byte count of the predecessor at HEAD;
  read the predecessor's last entry id from HEAD rather than from the dispatch.

### Evidence
```sh
git show HEAD:agents/journals/claude_dv_lead_agent.v02.md | wc -c
# 273809
git show HEAD:agents/journals/claude_dv_lead_agent.v02.md | sha256sum
# 0c6bb3686a1537b2d0c5b7153672801ff8e7a51a2bf4eb38cd63a636231b9f26  -
git show HEAD:agents/journals/claude_dv_lead_agent.v02.md | grep -c '^## \[J-dv_lead-'
# 18
git show HEAD:agents/journals/claude_dv_lead_agent.v02.md | grep '^## \[J-dv_lead-' | tail -1
# ## [J-dv_lead-0090] ... | task:none | BUG-0003 opened as its own commit ...
git diff --stat -- agents/journals/claude_dv_lead_agent.v02.md
# (empty — the hashed bytes are the committed bytes)
```
Thresholds read from `scripts/policy.sh:13-14`: `JOURNAL_SOFT_MAX=262144`,
`JOURNAL_HARD_MAX=524288`; 273,809 is between them, i.e. **warn, not refuse**.

### Outcome
DoD met for step 0. Volume 02 frozen; volume 03 active and chaining to it.
Handoff: the orchestrator commits this volume **alone**, `Journal-Only: true`,
ahead of the promotion commit and the BUG-0003 verdict commit.

### Open-questions
none

### Files-in-this-commit
- (none)

## [J-dv_lead-0092] 2026-08-07T20:35Z | task:none | The promotion landed and every printed class set scored against all three prediction sources — 48 cells, 48 agreements, and the source that scores best is the one that was RETIRED: it is refuted at 16 cells in exactly the direction its replacement named

### Trigger
Orchestrator: the decisive suite run at `b848d56` (CI run **30916188480**, job
**92014809540**) came back with **zero assertion failures across the whole
suite** and one red — the expect diff at `test_m03_i.ml`'s report sites. Land
the promotion as my own change and score the printed tables.

### Inputs
- CI job log `92014809540` (`bug3_92014809540.log`, an **ephemeral scratchpad
  artifact**, ADR-0003/F5 — the durable references are the run id, the job id,
  the `head_sha` `b848d56aeff8bc897d1606cc26e1a5ce4a103711` and the sha256
  below, all of which are re-derivable from the GitHub run).
- The promoted source from that job's `PROMOTION BLOCK`, sha256
  `4b66e2b9f2b3f789f41b31b22418e3257644776f833ee27c8b60b774b914b3e8`.
- `test/xgmii_rx_64/test_m03_i.ml` at HEAD (`git show HEAD:`) for the diff.
- `test/attack_plans/AP-xgmii_rx_64.md` §9 — the change-log rows at
  `J-dv_lead-0085` and `J-dv_lead-0087`, which carry the three prediction
  sources in the form they were committed **before** this measurement existed.
- `agents/handoffs/BUG-0003_m03-lane-4-injected-word-cycle.md` §7 items 1–3.
- `agents/handoffs/WO-0060_tb-m03-family-i-dm-rebase.md` `RV-0060-VERDICT` §9
  (the count method).
- **RTL read this round: none.** `libs/**` was not opened; `git diff --stat` on
  `fafb83d..b848d56 -- libs/` was run for the *file list and line counts only*
  (one file, +102/−14) in service of the acceptance check, not for semantics.

### Reasoning

**The diff is ONE expect block, not two — and saying so is not pedantry, it is
the acceptance check.** The dispatch described the promotion as moving "the two
expect blocks". It does not. `test_m03_i.ml` holds **five** `[%expect {||}]`
blocks; the promoted file differs from HEAD in **one hunk**,
`@@ -1345,7 +1345,82 @@`, one line removed and 76 added — M03-I4's block at
`:1348`. M03-I6's block at `:1558` stays empty **and is correctly empty**: I read
`run_i6` (`:1542–1549`) and it calls `run_i6_case` twice per lane and emits no
report at all — there is no `Latency.report` on that path, so there is nothing
for the block to carry. What the dispatch called two blocks is **one block
carrying two report streams**: the 48 per-run reports printed inside
`run_i4_length_lane`, and the cross-run report printed by `run_i4` at `:1330`.
CI's own diff header is the same single hunk at the same line, which is the
independent confirmation that my local diff is not an artefact of how I applied
the file.

**Bit-identity, established rather than asserted.** The scratchpad file's sha256
equals the one CI printed in its `PROMOTION BLOCK`, and the block lists
**exactly one file** — which is BUG-0003 §7 item 2 met *empirically*, not by
inspection. That matters because §7 item 2 was written as a trap: "*a fix return
whose promotion block lists more than `test/xgmii_rx_64/test_m03_i.ml` has
converted a fix into a regression, and the extra file names the family to look
at first*". Nothing else moved, so the trap did not spring, and rtl_lead's §9.4
claim — that at offset 0 the change is textually the identity, so **every**
lane-0 member of **every** family is bit-identical by inspection — is now
measured true across all 34 other M03 units and all 80 non-M03 units.

**Why this is a promotion and not a repair.** ADR-0005: an expect diff is a
*promotion source*. The printed values are **REPORTED data, asserted nowhere** —
`run_i4_case`'s own declaration says so, and the `J-dv_lead-0085` repair is what
demoted them, precisely so a live spec dispute could land in this file without
moving a row's status. Applying CI's bytes therefore adds no expectation and
grades no design; it records a measurement. It is mine to stage because
`test/**` is my scope and rtl_lead cannot enter it.

#### Scoring the printed tables against the three prediction sources

Residue `r = N mod 8` over the directed lengths, `k` the injected idle count.
Measured class sets, read off the promoted block:

| r (length) | lane 0, k=0 / 1 / 7 | lane 4, k=0 / 1 / 7 |
|---|---|---|
| 0 (64) | {16} / {24} / {72} | {12} / {20,28} / {68,124} |
| 1 (65) | {16} / {24} / {72} | {12} / **{12,20,28}** / **{12,68,124}** |
| 2 (66) | {16} / {24} / {72} | {12} / **{12,20,28}** / **{12,68,124}** |
| 3 (67) | {16} / {24} / {72} | {12} / **{12,20,28}** / **{12,68,124}** |
| 4 (68) | {16} / {24} / {72} | {12} / {20,28} / {68,124} |
| 5 (69) | {16} / **{16,24}** / **{16,72}** | {12} / {20,28} / {68,124} |
| 6 (70) | {16} / **{16,24}** / **{16,72}** | {12} / {20,28} / {68,124} |
| 7 (71) | {16} / **{16,24}** / **{16,72}** | {12} / {20,28} / {68,124} |

**Source A — my own countersignature tables** (`J-dv_lead-0086`, transcribed
into the plan's §9 at `J-dv_lead-0087`): lane 0 `{16+8k}` at `r ∈ {0…4}` and
`{16, 16+8k}` at `r ∈ {5,6,7}`; lane 4 `{12+8k, 12+16k}`, and
`{12, 12+8k, 12+16k}` at `r ∈ {1,2,3}`. **Substituting k = 1 and k = 7 gives
every cell of the table above, and no cell disagrees.** 48 cells (8 lengths × 2
lanes × 3 `k`), 48 agreements. I count **32 of them as discriminating**: the 16
`k = 0` cells are degenerate — both branches of the formula collapse to the same
singleton — so they confirm REQ-019's word_delay 3, not the residue split.

**Source B — the architect's retired-and-replaced prediction**, SPEC-M03 §6.1
item 3's lane-0 carve-out: at `r ∈ {5,6,7}` the `tlast` word's octets all lie in
the terminate's own word, so *nothing straddles* — a **single** class there, and
by complement the straddling residues `r ∈ {0…4}` carry more than one. The
measurement is the **exact inversion**, as the `J-dv_lead-0087` change-log row
predicted in terms: single class at `r ∈ {0…4}`, two classes at `r ∈ {5,6,7}`.
**16 lane-0 cells refute it (5 lengths × 2 non-zero `k` on the singleton side,
3 × 2 on the pair side); zero confirm it.** This is the best outcome a retirement
can get: the withdrawn claim is not merely unsupported, it is measured false in
the direction its replacement named, at every cell where the two differ.

**Source C — FINDING F-1's repair** (mine, `J-dv_lead-0086`, still an open
finding against SPEC-M03 §6.1 item 2's *"every output word, at a lane-4 start"*):
a **third** class `{12, 12+8k, 12+16k}` at lane 4, `r ∈ {1,2,3}` and there only.
**Confirmed, and confirmed as a selection rather than as a covering**: the third
class is present at exactly the 6 cells F-1 named (lengths 65/66/67 × `k` ∈
{1,7}) and **absent at the 10 lane-4 cells it excluded** (`r ∈ {0,4,5,6,7}` ×
`k` ∈ {1,7}). A prediction that fired everywhere would have selected nothing and
could not be scored; this one draws the boundary and the boundary holds. F-1 is
now a **measured** finding, not a derived one, and it is the first hardware
evidence in this program against a live clause of a frozen spec.

**Cross-run, and what had never executed.** `h = 8` accumulates
`{16, 24, 72}` and `h = 12` accumulates `{12, 20, 28, 68, 124}` — the exact
unions of the per-`k` sets above, which is the arithmetic check that the 48 runs
were accumulated and not sampled. The cross-run **assertions** (exactly two
front-offset classes; `h` = 8 and `h` = 12; 24 frames each) had **never run in
this program's history** — they sit after all 48 cases and every prior round
raised before reaching them. They executed and passed. BUG-0003 §7 item 1 called
them "not a formality" and it was right: they are the only check that both lanes
accumulated their full 24.

**REQ-019 unmoved (§7 item 3).** The `k = 0` rows print `h = 8 / L = 16 /
word_delay = 3` at lane 0 and `h = 12 / L = 12 / word_delay = 3` at lane 4 —
against §1.1's ceiling of 4, unchanged from `fafb83d`. rtl_lead's §9.5 claim
that no E2 revival condition is tripped is therefore measured on its DV-observable
half, and the *only* half I can measure.

**rtl_lead's derived lane-4 cycles held.** §9.3 stated, before any run, cycles
**6, 8, 10, 12, 14, 16, 18, 19** at (64, lane 4, `k` = 1) and **18, 26, 34, 42,
50, 58, 66, 67** at `k` = 7. Those are asserted by `injected_word_cycle` against
`baseline_cycle(m) + (cycle_of(D m) − D m)`, computed by the bench from the
specification with no design term in it, and the assertions passed. The design
now meets §0.5 at the start lane where it did not.

### Actions
- Verified the scratchpad promoted file's sha256 against the one CI printed.
- Diffed it against `git show HEAD:test/xgmii_rx_64/test_m03_i.ml`: one hunk,
  one expect block, −1/+76.
- Read `run_i6` to establish that M03-I6's still-empty block is correct rather
  than unpromoted drift.
- Applied the file verbatim over `test/xgmii_rx_64/test_m03_i.ml` and re-hashed
  in place.
- Scored all 48 printed class sets against the three prediction sources.

### Evidence
```sh
sha256sum test/xgmii_rx_64/test_m03_i.ml
# 4b66e2b9f2b3f789f41b31b22418e3257644776f833ee27c8b60b774b914b3e8
#   -- equal to the sha256 in CI job 92014809540's PROMOTION BLOCK,
#      which lists exactly one file.
git show HEAD:test/xgmii_rx_64/test_m03_i.ml > /tmp/head_m03_i.ml
diff -u /tmp/head_m03_i.ml test/xgmii_rx_64/test_m03_i.ml | grep -c '^@@'   # 1
diff -u /tmp/head_m03_i.ml test/xgmii_rx_64/test_m03_i.ml | grep '^-' | grep -v '^---'
#   -  [%expect {||}]          (one removed line, and only one)
git diff --numstat -- test/xgmii_rx_64/test_m03_i.ml                        # 76  1
```
CI, run **30916188480**, job **92014809540**, `head_sha` `b848d56`: `dune build
@default` clean; `dune runtest` red on the expect diff at
`test/xgmii_rx_64/test_m03_i.ml` line 1 only, hunk `@@ -1345,7 +1345,82 @@`; no
`fail` message anywhere in the log; cosim green; `journal-check` green.
Local toolchain cannot reproduce the run (`hardcaml` is not installed in this
switch — `dune build @default` fails with *Library "hardcaml" not found*), which
is why the run reference is CI's and is stated as such.

### Outcome
DoD met. The promotion is staged as my change; the tree is clean at this commit
and the suite is green with no unpromoted drift. **M03-I4 and M03-I6 discharge
here** and the count moves to **38 of 62** (re-derived in the next entry).
Handoff: BUG-0003's `Fix verdict`, next commit.

### Open-questions
1. **FINDING F-1 is now measured and still unanswered by SPEC-M03.** §6.1 item 2
   asserts `h = 12` for *every* output word at a lane-4 start; the third class at
   `r ∈ {1,2,3}` is that clause failing for the `tlast` word, printed in a
   committed expect block. It moves no row (the values are reported, not
   asserted) but it is a spec defect on the record and the architect owes it a
   ruling. Carried to the orchestrator as an escalation, not folded into
   BUG-0003.

### Files-in-this-commit
- test/xgmii_rx_64/test_m03_i.ml

## [J-dv_lead-0093] 2026-08-07T21:00Z | task:none | BUG-0003's fix ACCEPTED and the packet deliberately NOT closed — the severity conversion rtl_lead handed me is warranted and I am refusing to record it, because the evidence class is the designer's derivation from the RTL and I have already been wrong once this round about what that port carried

### Trigger
The promotion landed at `J-dv_lead-0092` with the defect measured absent.
BUG-0003 now needs its `Fix verdict` written per the packet template: the fix
graded against §7's five acceptance items, §5's severity conversion ruled on,
rtl_lead's honesty grading of my §6 answered, and the packet's state set.

### Inputs
- `agents/handoffs/BUG-0003_m03-lane-4-injected-word-cycle.md` in full,
  **including §9** (rtl_lead's Root-cause, appended at `b848d56`): §9.1 the
  mechanism and my §6 graded, §9.2 the severity evidence, §9.3 the fix and its
  derived cycles, §9.4 gapless bit-identity, §9.5 the E2 conditions, §9.6 the
  six things it asks the verdict round to check.
- `agents/journals/claude_rtl_lead_agent.md` `J-rtl_lead-0011` — read in full,
  for the Root-cause obligation my charter §8 makes me verify **and** for the
  three rejected fix variants, which are what tell me the fix was chosen rather
  than found.
- `agents/charters/dv_lead.md` §3, §5's DoD, §8's bug-entry rule.
- `agents/PROTOCOL.md` §10 (independence, the transient-mutation pattern).
- `test/xgmii_rx_64/test_m03_i.ml` `:290`, `:445`, `:300–330`;
  `test/xgmii_rx_64/bench.ml:222`; `test/cosim/stimulus_gen.ml` header;
  a tree-wide enumeration of every `[%expect]` block in `test/**`.
- `git show --name-status b848d56`; `git log -- rtl_snapshots/`.
- **RTL not opened.** §9 quotes six lines of the module; that exposure is
  adjudication, licensed and bounded by `RV-0060-VERDICT` §11, and the bench
  that judges this fix froze at `51b9920`, four commits before `b848d56`.

### Reasoning

**Why ACCEPT and NOT CLOSED, which is one decision and not two.** Four of §7's
five acceptance items are met and measured. The fifth — `rtl_snapshots/**`
regenerated under REQ-902's double-generation check — is **not**: `b848d56`
stages three paths and none is under `rtl_snapshots/`, which last moved at
`750be49`, **two RTL changes ago**. I wrote item 5 into this packet myself and I
wrote it *because it had already been skipped once at `fafb83d`*. A packet that
closes over its own carried item teaches the next round that carried items
evaporate, and I have watched that happen to item 5 already. So: the behaviour is
accepted, the packet stays open, and the two are recorded as different things
rather than averaged into one soft verdict.

**The severity ruling is the hard call and I want the reasoning legible, because
it looks like moving my own goalposts and is not.** §5 promised to convert to
CRITICAL "**without argument** if either appears". §9.2 reports both conditions
present — seven mid-frame `tkeep` = 0x0F words with `tlast` = 0, and 4 of 60
required octets delivered with the rest being the idle word's `0x07` filler
presented as frame octets — and reports them, in its own words, "**Derived, not
measured**".

I am not arguing against the conversion. I am refusing to *record* it on that
evidence class, for three reasons, of which the third decides it:

1. §5's conditions are **appearance** predicates, and this packet's §2.4 is an
   unusually careful separation of measured from unmeasured, word by word.
   Converting on a derivation would contradict the packet's own standard inside
   the packet.
2. The derivation is **the designer's, from the RTL**. A DV severity recorded on
   it makes the severity of a DV bug packet a designer-supplied fact — the exact
   transfer PROTOCOL §10 exists to prevent. It cuts against my convenience, not
   for it: the conversion would make my packet weightier.
3. **I was wrong once already this round about what that same port carried, and
   wrong by inference.** §6 reasoned from "the count guard runs first and passed"
   to "no half word reached the output". §9.1 refutes it structurally. An agent
   whose inference about a port has just failed does not then accept someone
   else's inference about the same port. That is not caution; it is the only
   consistent position available to me after §9.1.

**So the ruling is: conversion WARRANTED IN SUBSTANCE, NOT RECORDED, and a
measurement is OWED** — and I specified it tightly enough that it cannot be
argued about later: restore the module to its `fafb83d` content in a **transient
uncommitted tree** (PROTOCOL §10's own pattern, run in reverse — a de-mutation
rather than a mutation), drive the single stimulus (64 octets, lane 4, `k` = 1)
with a throwaway print-only probe, and report two numbers: how many mid-frame
words carry `tkeep` ≠ 0xFF with `tlast` = 0 (§9.2 predicts 7), and how many of
the 60 required octets arrive in their gapless byte positions (§9.2 predicts 4).
Either number convicts, and if both come back conformant then §9.2 is wrong,
which would be far more interesting. Nothing enters history.

**What is *not* in doubt, said so the refusal is not mistaken for scepticism.**
§9.1's mechanism is corroborated by something I *did* measure: the same
structural account produced, before any run existed, the post-fix cycles
6, 8, 10, 12, 14, 16, 18, 19 at `k` = 1 and 18, 26, 34, 42, 50, 58, 66, 67 at
`k` = 7 — and the bench, computing those from the specification with no design
term in it, agreed. I doubt the mechanism not at all. I have simply never seen
its pre-fix consequence.

**rtl_lead's grading of my §6, adopted verbatim and split in two.** "Right for
the wrong reason" is correct. The **act** was right — a bug packet must not
prejudge root cause, and had I adopted escalation 1's mechanism I would have
shipped a packet written from the design that was also *half wrong* (it said both
halves are emitted; the design emits one and drops one). The **argument** was
wrong, and I wrote it as unsound rather than as incomplete, because it was: it
assumed both halves survive, and `hold` means they do not.

**The DV gap it hands me, and the ruling on what follows.** At a lane-4 start
`ev12` fires exactly `W` times per frame at any `k`, so emitted count = `W` **by
identity** — `delivered_samples`' word count is a quantity that *cannot*
disagree there, and the `tlast`-position check likewise. Ruling:

- **No guard row.** The class already has **two independent kills in the
  committed bench** — the per-word `tkeep` assertion and the delivered-octet
  equality, both inside M03-I4's own loop, both of which would have fired at
  `fafb83d` had the run reached them. The suite was not blind; one *instrument*
  was, and an earlier guard raised first. Adding a row for coverage that exists
  inflates the denominator and buries the lesson.
- **Two bench notes ARE owed**: one at the count guard's own sites
  (`test_m03_i.ml:290`, `:445`; definition at `bench.ml:222`) saying that at a
  lane-4 start the count is `W` by construction and no packet may cite "the count
  was right" as evidence about word integrity — a sentence whose negation I wrote
  into §6; and one on **guard ordering**, requiring any packet reasoning from
  "guard X passed" to state which guards ran before it, since a raising `fail`
  hides every later guard and that is why §2.4 had 22 undriven runs.
- **Which round: the next one that opens `test/xgmii_rx_64/` for editing**, riding
  with `RV-0060-VERDICT` §10 item 3's three citation sites. **Not this round**,
  and for a reason that is not convenience: this round's bench commit must be
  **byte-identical to CI's promoted file**, which is §7 item 2's own check; a
  hand-written comment in the same commit destroys the one property that makes
  the promotion auditable.

**The count, re-derived rather than inherited.** `RV-0060-VERDICT` §9 published
**38** as a forward figure; I recomputed it from the tree instead of collecting
it. Mechanically: 38 distinct M03 rows are named in committed `%expect_test`
titles under `test/xgmii_rx_64/`; intersecting with the plan's 62 ASSERT rows
drops exactly one (**M03-A4**, a NO-ASSERT row named in a title) leaving **37**;
plus **M03-F5** by citation = **38 carrying a discharge**, with **nothing
subtracted** because M03-I4 and M03-I6 were the only red rows and both are green.
Plan totals recounted from the file: 78 rows, 62 ASSERT, 7 NO-ASSERT, 4
NO-STIMULUS, 4 STRUCTURAL, 1 GAP. **38 of 62.**

Two precisions I would rather state than have found: **the count moves at my
promotion commit, not at `b848d56`** — at `b848d56` the assertions are green but
the tree carries unpromoted drift, so my own DoD's `git diff --exit-code` limb is
unmet there; and **the count does not wait on this packet's two open items**,
because the method measures rows against the bench tree, not packets. Holding it
hostage to a stale snapshot would make it a narrative, which is the same failure
`RV-0060-VERDICT` §9 refused from the other direction when it declined a
fractional discharge.

**The sweep, and a blanket claim I had to retract mid-writing.** rtl_lead's
§9.6 item 4 asks whether any unit outside `Idle_injection` could legitimately
have moved. I first wrote that *every* expect block in *every* RTL-driving unit
in the tree is empty — tidy, and **false**: enumerating all of `test/**`
mechanically turned up `test/hardcaml_ethernet/test_word_counter.ml:25`, which
instantiates `Word_counter` and carries a waveform block. It is out of reach
(different module, `valid`-toggle stimulus, no XGMII interface, no start lane)
but it exists, and the packet now names it. A sweep is only worth something if it
reports what it found rather than what would have read better.

### Actions
- Verified rtl_lead's fix entry contains a Root-cause section, and that it
  answers §6's open mechanism question, before writing ACCEPT (charter §8).
- Graded §7's five acceptance items individually against CI evidence and the
  commit's own file list.
- Ruled the severity conversion and specified the measurement that unblocks it.
- Ruled on the count-guard blindness: no row, two bench notes, next bench round.
- Swept `test/**` for rtl_lead's escalation-3 discriminator; retracted and
  replaced my first formulation of the result.
- Re-derived the discharge count mechanically from the tree.
- Appended `### FIX VERDICT` (§V.1–§V.8) to the packet.

### Evidence
```sh
git show --name-status b848d56 | tail -4
#   M  agents/handoffs/BUG-0003_m03-lane-4-injected-word-cycle.md
#   M  agents/journals/claude_rtl_lead_agent.md
#   M  libs/hardcaml_ethernet/src/xgmii_rx_64.ml       <- no rtl_snapshots/ (§7 item 5)
git log --oneline -1 -- rtl_snapshots/
#   750be49 BUG-0001 fix snapshots: ... REQ-902 owed by next run
```
Count re-derivation (both figures computed, not quoted): 38 rows named in
`%expect_test` titles under `test/xgmii_rx_64/`; 62 ASSERT rows in
`test/attack_plans/AP-xgmii_rx_64.md`; the intersection is **37** and the single
titled non-ASSERT row is **M03-A4** (NO-ASSERT); plan totals 78 / 62 / 7 / 4 / 4
/ 1. Sweep: 36 expect blocks across ten files under `test/xgmii_rx_64/`, all
`{||}` at HEAD; exactly one RTL-instantiating unit tree-wide carries a non-empty
block (`test/hardcaml_ethernet/test_word_counter.ml:25`, `Word_counter`);
`Idle_injection` is referenced by two units only, one of which instantiates no
RTL; `test/cosim/stimulus_gen.ml` is lane-0-start-only by its own header.
Suite reference for the ACCEPT: CI run **30916188480**, job **92014809540**,
`head_sha` `b848d56`, zero assertion failures.

### Outcome
DoD met. `BUG-0003` state: **FIX ACCEPTED / OPEN** on two bounded items (§7 item
5, and §V.2's pre-fix measurement). Family I's rows discharge; the count stands
at **38 of 62**. `SO-xgmii_rx_64.md` remains unopened and is not offered — 24
ASSERT rows outstanding, family I's qualification campaign unrun, the
verilog-ethernet anchor undischarged for a PASS. Handoff: verbatim relay of this
packet to rtl_lead via the orchestrator.

### Open-questions
1. **The pre-fix measurement at `fafb83d`** (§V.2) — orchestrator to operate in a
   transient tree; the severity line cannot move until it returns.
2. **§7 item 5** — `rtl_snapshots/**` now stale across two RTL changes, with
   rtl_lead's structural prediction unverified in both.
3. **FINDING F-1**, measured at `J-dv_lead-0092` and still owed a ruling by
   architect_docs_lead against SPEC-M03 §6.1 item 2.
4. **N-1**, carried again, now with its first measurement behind it (§V.7).

### Files-in-this-commit
- agents/handoffs/BUG-0003_m03-lane-4-injected-word-cycle.md

## [J-dv_lead-0094] 2026-08-07T21:20Z | task:none | The plan's carried §9 row paid at the first round that could pay it, and the one judgement in a clerical edit is what I refused to add — no row for the count-guard blindness, because the class already has two kills and a row for coverage that exists inflates the denominator

### Trigger
`RV-0060-VERDICT` §9 recorded a change-log row **owed** to the attack plan "at
the next round that opens the plan": a record of §6's ruling that rtl_lead's
escalation 2 (sub-word granularity) earns **no row and none owed**. This round is
the first since that could open the plan without confounding an open design
round, and it has three further plan-relevant facts to put on the same record.

### Inputs
- `test/attack_plans/AP-xgmii_rx_64.md` — §9's change log (its last three rows,
  at `J-dv_lead-0082`, `J-dv_lead-0085` and `J-dv_lead-0087`, for form and for
  the totals they publish), §4.I's rows, §5's rejected-attack section.
- `agents/handoffs/WO-0060_tb-m03-family-i-dm-rebase.md` — `RV-0060-VERDICT` §6
  (the no-row ruling being recorded), §9 (the owed row, and the count method),
  §10 item 3 (the deferred citation sites).
- `agents/handoffs/BUG-0003_m03-lane-4-injected-word-cycle.md` §V.1–§V.8 as
  written at `J-dv_lead-0093`.
- `agents/journals/claude_rtl_lead_agent.md` `J-rtl_lead-0011` §9.6 item 4.
- The promoted `test/xgmii_rx_64/test_m03_i.ml` as landed at `J-dv_lead-0092`.
- **No RTL.**

### Reasoning

**Whether to open the plan at all this round, which the dispatch left to me.**
Yes, and the argument that decided it is that the reason for the last two
deferrals has expired. `RV-0060-VERDICT` §10 item 3 deferred bench edits because
"a bench edit inside an open design round is the confound this whole sequence
exists to avoid" — the design round is now closed, the fix is measured, and the
plan is not a bench in any case. Against that: a one-row debt deferred a third
time becomes a debt nobody expects to be paid. And this round generates three
further facts whose home is the plan's own record rather than a journal an
auditor has to go looking for — F-1 measured, the sweep result as a rejected
attack, and the count moving to 38 of 62. Paying one row and recording three
findings in the same row is strictly better than four deferrals.

**Why the plan edit is a change-log row and nothing else.** No cell of §4.I is
wrong. M03-I4's and M03-I6's `Observable` cells already state, at both start
lanes, the exact clause lane 4 was failing — that is why they held the red
honestly — and the fix does not change what they observe. The values F-1 concerns
are REPORTED, not ASSERTED, which is exactly what the `J-dv_lead-0085` repair
bought, so a live spec dispute lands in a committed expect block without moving a
status. And the discharge count is measured **from the tree**, not tracked in the
plan, so no cell records it. **78 / 62 / 7 / 4 / 4 / 1, recounted from the file
after the edit and unchanged** — I recount rather than assert, because every
prior row of this log that claimed unchanged totals claimed them after counting.

**The one judgement inside an otherwise clerical edit: the row I did NOT add.**
rtl_lead's §9.1 hands DV a real instrument limit — at a lane-4 start the emitted
word count equals `W` by identity, so `delivered_samples`' count cannot disagree
and the `tlast`-position check is blind with it. The reflex is to add an attack
row. I refused, and the reason is a denominator argument I want on the record
because it will recur: **the defect class already has two independent kills
inside the committed bench** — M03-I4's per-word `tkeep` assertion and its
delivered-octet equality — either of which would have convicted `fafb83d` had the
run reached them; they did not fire because an earlier guard raised first, which
is a *guard-ordering* fact, not a coverage fact. A row added here would raise the
plan's denominator for coverage that already exists, dilute the ratio the auditor
reads, and misdescribe the failure as a hole in the attack table when it is a
property of one instrument and of `fail`-raising control flow. What the finding
actually earns is **two bench notes** — at the count guard's own sites and on
guard ordering — and those land where a reader of the guard meets them, in the
next round that opens `test/xgmii_rx_64/`.

**Why the notes are not duplicated into §7 now.** §7 is "machinery this plan
requires and does not have"; the count guard is not missing, it is present and
blind at one lane, so §7 is the wrong home. More importantly, a note in §7 plus a
note in the bench is two records of one fact, and two records drift. The
change-log row states the ruling and names where the note will land; the bench
gets the operative sentence next round.

**What I deliberately kept out of this commit.** The promoted bench file. Its
whole auditability is that its bytes equal CI's, sha256-verified — so the plan
edit is a separate commit from the promotion, and both are separate from the
verbatim-relay packet. Three files, three commits, three reasons, none of them
stylistic.

### Actions
- Appended one row to `test/attack_plans/AP-xgmii_rx_64.md` §9 recording: the
  carried `RV-0060-VERDICT` §6 no-row ruling; family I's discharge and the
  count at 38 of 62 re-derived; F-1 measured with its selection boundary; the
  count-guard instrument limit with the no-row ruling and the two owed bench
  notes; and the escalation-3 sweep result as a rejected attack.
- Recounted the plan's rows and status totals from the file after the edit.

### Evidence
```sh
# row totals recounted from the file AFTER the edit
# 78 rows: ASSERT 62, NO-ASSERT 7, NO-STIMULUS 4, STRUCTURAL 4, GAP 1
# §9 change log grew by exactly one row (19 -> 20 table lines)
```
The row's own claims are the ones evidenced at `J-dv_lead-0092` (CI run
**30916188480**, job **92014809540**, `head_sha` `b848d56`, promoted sha256
`4b66e2b9f2b3f789f41b31b22418e3257644776f833ee27c8b60b774b914b3e8`) and
`J-dv_lead-0093` (the count re-derivation and the tree-wide sweep); this entry
adds no new measurement and deliberately re-states none as if it did.

### Outcome
DoD met. The plan carries no owed change-log row. Family I's record is complete
on the plan's own face: rows discharged, the ruling that added none recorded, the
rejected attack recorded, and the instrument limit ruled with its remedy located
in a named future round. Handoff: none — this is the round's last commit.

### Open-questions
1. **The two bench notes** (count-guard identity at a lane-4 start; guard
   ordering) ride with `RV-0060-VERDICT` §10 item 3's three citation sites in the
   next family-I bench work order. Recorded as owed, in the plan, so the debt is
   not journal-only this time.

### Files-in-this-commit
- test/attack_plans/AP-xgmii_rx_64.md

## [J-dv_lead-0095] 2026-08-07T22:05Z | task:WO-0061 | Family I's campaign frozen at ten classes, and the class list is not a list of defects but a decomposition of ONE specification sentence — §6.2's `Frame` row has five conjuncts and the family's five rows have never had any of them attacked

### Trigger
Orchestrator dispatch: draft the family-I qualification campaign per my standing
model (`WO-0055`/`WO-0058` form, freeze-first — packet and seal in one commit
before any manifest diff exists). Family I is complete and green at `42b9df3`
(CI **30920890962**, both jobs), its two red rows discharged by two design fixes
and a spec re-ruling, and its five ASSERT rows have never been mutation-scored.

### Inputs
- `test/xgmii_rx_64/test_m03_i.ml` in full (1,634 lines) — the five units'
  committed control flow, assertion order and iteration order, which is what the
  seal's messages are derived from; `test/xgmii_rx_64/bench.ml` `:176–330`
  (`run`, `sample_cycle`, `delivered_samples`, `error_pulses`,
  `account_clean_frame`, `assert_monitors_clean`, `directed_frame_octets`);
  `test/xgmii/idle_injection.ml` `:142–182` (`uniform`'s site rule, `cycle_of`)
  and `idle_injection.mli` `:95–150`; `test/monitors/strobe_monitor.ml`
  `:150–195`; `test/xgmii_rx_64/test_m03_b.ml` `:30–62` and
  `test_m03_g.ml` `:1095–1150` (the two `?word_at` overlays that could have put
  an idle word inside an open frame, and do not).
- `docs/specs/modules/xgmii_rx_64.md` §6.1, **§6.2's `Frame` row** (line 722 —
  the hold rule and its exit column), §7, §10's REQ-016/REQ-109/REQ-113 hooks;
  `docs/specs/requirements.md` REQ-016, REQ-109, REQ-113, REQ-107, REQ-108,
  REQ-103, REQ-011, REQ-008, §0.3, §0.5, §0.6, and the change-log rows for
  `a77017c` and `1f3c04c`.
- `test/attack_plans/AP-xgmii_rx_64.md` §4.I (all five rows in full, including
  M03-I4's repaired `Observable` and its `Kills` cell).
- `agents/handoffs/WO-0058_m03-g7-h-mutation-campaign.md` and its SEALED
  companion — form, §4's binding-rules pattern, the disclosure-function method;
  `WO-0055`'s G-c4 branch method by citation; `WO-0060`'s `RV-0060-VERDICT` §9,
  §10, **§11** (the adjudicator-exposure ruling this packet had to carry).
- `agents/handoffs/BUG-0003_…` §V.1–§V.8; `agents/journals/claude_rtl_lead_agent.md`
  `J-rtl_lead-0012`; my own `J-dv_lead-0092`, `J-dv_lead-0093`, `J-dv_lead-0094`.
- **No RTL.** No path under `libs/**`, `top/**`, `bin/**`, `rtl_snapshots/**` or
  `docs/reports/audit/**` was opened at any revision this spawn.

### Reasoning

**The design question this round actually had to answer, and the answer that
organises the packet.** A qualification campaign picks classes. For families D
through H the classes picked themselves: each row named a defect and the class
was that defect. Family I's rows do not work that way — **every one of them
asserts an ABSENCE**, and an absence has no defect of its own; it has a *rule*
whose violation is the defect. So I went to the rule. **§6.2's `Frame` row is
one sentence with five conjuncts**: on a held cycle *the CRC register holds*,
*the octet count holds*, *no output word is produced*, *no condition is raised*,
and — from the row's exit column, exhaustively listed — *the frame does not
close*. That is five classes, derived from one sentence, each attacking exactly
one conjunct, and it is the first class list in this programme that is
**clause-complete** against its own normative text rather than merely plausible.
Three more classes cover the family's other three requirements (REQ-016's D(m),
REQ-109's silence, REQ-113's ordered set), one covers REQ-016's clause (a) as
content rather than timing, and one covers REQ-109's drain bound. Ten.

**Why ten and not seven, stated as a cost I am choosing to pay.** Ten diffs is
more than any prior campaign. The justification is not thoroughness for its own
sake: family I's five rows carry roughly forty distinct assertions and the
family's characteristic failure is **vacuity**, so the unit this campaign must
cover is the **instrument**, not the row. Seven classes would have qualified all
five rows and left the delivered-octet equality, the FCS verdict and the tight
drain window untouched — three instruments whose teeth are exactly what nobody
has ever measured here.

**The finding I did not expect to make while writing the seal, and it is the
round's most useful output: the absence assertions are SHADOWED by their own
positive companions.** Worked from the committed control flow rather than
assumed. `delivered_samples` counts every `tvalid` cycle in a run, and in M03-I1,
M03-I2 and M03-I3 the word-count guard runs **before** the row's headline
absence scan. So a spurious output word in the idle window, in the drain window
or inside the ordered set reddens the **count**, never the silence. The silence
assertions can only speak for a defect that adds a word inside the window *and*
removes one elsewhere. **The strobe halves are not shadowed** — no count guard
sees a pulse — which is why three of the ten classes are strobe classes and why
M03-I2's tight window is reachable at all. I recorded this in the packet
(§4.5) as a binding adjudication rule **before** the result rather than
discovering it in a scorecard, which is the only reason it is worth anything.
It is a property of putting the positive companion first — the very thing that
makes the absence non-vacuous — so it is a price, not a defect, and I say so.

**The class that decides whether family I means anything at all.** I-c5 (a held
cycle closes the frame) is drastic and looks like an easy kill. Its real job is
different: it is the **wrapper's liveness proof**. If `Idle_injection`'s idle
words are not reaching the design, then I-c1 … I-c6 all survive and the injected
half of family I — 48 runs, two rows, the whole SCR-M03-I4 saga — is vacuous.
The packet fixes in advance (§4.2) that a double survival there is adjudicated
as a **CRITICAL finding against me**, not as weak rows. That is the inversion
this family needed: for once, the informative outcome is named before it can be
argued about.

**M03-I2 is the row I could not qualify narrowly, and I decided to say so rather
than manufacture a class.** Everything M03-I2 can see, some other row can see:
its stimulus is the most ordinary in the bench (one clean frame, then idle) and
its distinction is the **tightness of its window**, not the shape of its input.
So it is REQUIRED by exactly one class (I-c10, deliberately wide), and the
packet states that if I-c10 survives the row ends the campaign **unqualified**.
Better: the class carries a disclosed **offset**, and the offset is the one
datum that measures what C-14.3's tightening actually bought — a pulse at + 1 or
+ 2 is caught by machinery every row has, a pulse at + 3 or later is caught by
M03-I2's window **and nothing else in the repository**. That is a real
measurement of a specification decision, extracted from a class I would
otherwise have called a formality.

**Where the seal's exactness comes from, and the one place I refused to fake
it.** Every message is the first assertion to speak given the row's own
iteration order (M03-I4 drives its **baseline** run first, then idles 0/1/7 —
and `idles = 0` places no sites at all, so the first run any injection-gated
class can reach is `(64, lane 0, idles 1)`). The counts are derived, not
guessed: `uniform` places sites at `before_cycle` 3…10 for every M03-C1 length
at lane 0, so 8 idle words at `k` = 1 and 56 at `k` = 7, which gives I-c3's
`got 16` / `got 64` and I-c5's `got 1` at both units by arithmetic. I-c7's
`expected 5` is derived from `D(0) = 3`, `cycle_of(3) = 4` and
`baseline_cycle(0) = 4`. **What I would not seal is the mutant's own value**: the
observed-cycle field, the observed counts, the strobe names. Those are sealed as
*inequalities with a named direction* — early, greater, fewer — with the
adjudication rule fixed in advance that a differing magnitude is a rendering
fact and a differing **assertion** is a finding. GH-1 was a cell asserted from a
category; the repair is not to guess harder but to seal only what the
specification and the bench determine.

**The UNWORKED cells, and why each is honest rather than lazy.** Three: I-c10's
thirty non-scored M03 units (deriving thirty first-speaking assertions would be
thirty chances to repeat G-1; the rule fixed instead is that a red there is
blast radius worth zero kills and a **green is a finding**, because a row that
cannot see a spurious strobe on its own frame's closure is a coverage fact worth
having); T-G6 under a `Discard`-wide gate (the bench's only unit where idle
words arrive while the machine is not in `Idle` — no cell scored in either
direction); and I-c1's `tkeep`-versus-count sub-branch. Each carries its
adjudication rule in the seal, before the result.

**The adjudicator-exposure rule, carried as the packet's standing discipline and
sharpened by one fact I had to disclose against myself.** `RV-0060-VERDICT` §11
ruled ordering, not blindness: the bench that judges must be frozen at a SHA
strictly earlier than the RTL it judges, mechanically checkable. For a mutation
campaign the check is one line per branch (`git diff 42b9df3 <branch> -- test/`
must be empty), because every mutant is base + one diff. But **M03-I4's expect
block is non-empty and was promoted from CI's output at `b848d56`** — later than
the RTL it now helps judge — so a reader could reasonably ask whether that
instrument was tuned to the design. I put it in the packet (§0.1) rather than
leaving it to be found, with the three facts that bound it (CI's bytes not mine,
sha-verified; no assertion authored there; 48 of 48 printed class sets agreed
with predictions made before the run existed) and, more usefully, a **scoring
rule**: no kill is ever scored on the expect-block diff alone. An exposure with
a rule attached is a control; an exposure with a paragraph attached is an
excuse.

**The mapping, restated here as the seal's second copy** (row sets only, never
the messages — the practice since `J-dv_lead-0079`, and the reason a seal's
claims can be checked even if its file is lost): I-c1 → {T-I6}; I-c2, I-c3,
I-c4, I-c5, I-c6, I-c7 → {T-I4, T-I6} each; I-c8 → {T-I1, T-I6} on the nominal
threshold branch; I-c9 → {T-I3}; I-c10 → every M03 unit except T-ST (35).
**Fifty-one REQUIRED cells, ten possible kills, 309 M03 and 800 non-M03
must-stay-green cells.**

**What I deliberately kept OUT of the campaign.** BUG-0002's and BUG-0003's own
defects. Both are settled measurements — the committed bench convicted each on a
real design, with the raised message on the record — and re-seeding them would
recycle a result this programme already owns (the `g-c4` exclusion at
`WO-0058` §1). I-c7 is adjacent to BUG-0003 and the packet says exactly what it
adds instead: the **lane-0** half of the re-based cycle instrument, which no
defect has ever exercised, under a different rendering.

### Actions
- Measured the denominators at the base SHA from the base's own blobs (36 M03
  units, 116 repository-wide, 80 non-M03) rather than carrying `WO-0058`'s 31 /
  111 / 80.
- Derived the ten intents from §6.2's `Frame` row (five conjuncts), REQ-016's
  clauses (a) and (b), REQ-109 (silence and drain) and REQ-113.
- Derived every sealed message from the bench's committed assertion and
  iteration order; derived every sealed count from `uniform`'s site rule.
- Derived the MUST-STAY-GREEN complement from a stimulus inventory (which units
  can present an idle word inside an open frame — two — and which is the one
  near-miss — T-G6, in `Discard`).
- Wrote the disclosure functions (eight branch tables) and fixed the
  adjudication rule for every UNWORKED cell.
- Carried `RV-0060-VERDICT` §11 into the packet as its standing discipline and
  disclosed the M03-I4 expect-block provenance against myself.
- Staged packet and seal in ONE commit, before any manifest diff exists.

### Evidence
```sh
# denominators, measured at the base SHA's own blobs (not at HEAD, not recalled)
for f in $(git ls-tree --name-only -r 42b9df3 test/ | grep '\.ml$'); do
  git show 42b9df3:$f | grep -c 'let%expect_test'; done | paste -sd+ | bc
#   116          (test/ repository-wide)
#   36           (test/xgmii_rx_64/, summed per file: 3 1 4 3 4 4 7 4 5 1)
git diff --stat 42b9df3 172347c -- test/ libs/ tools/ dune-project
#   (empty — the base's compiled surface is the branch head's)
grep -rl "Idle_injection" test/ --include=*.ml
#   test/xgmii/test_idle_injection.ml   (library test, instantiates no DUT)
#   test/xgmii_rx_64/test_m03_i.ml      (the only DUT-facing user)
grep -rl "sequence_char" test/ --include=*.ml   # /Q/ reaches a DUT at one unit
sha256sum test/xgmii_rx_64/test_m03_i.ml
#   4b66e2b9f2b3f789f41b31b22418e3257644776f833ee27c8b60b774b914b3e8
```
Control for the campaign: CI run **30920890962** at `42b9df3`, **both jobs**
green (`build` including Generate-RTL and determinism, and `cosim`) — the
figure the packet's §7 criterion 3 rests on, relayed by the orchestrator and
externally checkable by run id.

### Outcome
DoD met. `WO-0061` is **DRAFT — FROZEN, awaiting seeding**, with its SEALED
companion staged in the same commit (R-SEAL-1). Ten classes, five scored units,
51 REQUIRED cells on the nominal branches, 309 M03 + 800 non-M03 must-stay-green
cells. Handoff: the packet goes to the auditor via the orchestrator; the sealed
companion goes nowhere until all ten diffs are committed.
`SO-xgmii_rx_64.md` remains unopened and is not offered.

### Open-questions
1. **The two bench notes** (count-guard identity at a lane-4 start; guard
   ordering) remain owed at the next round that opens `test/xgmii_rx_64/` for
   editing — this round opens no bench file. `WO-0061` §4.5's shadowing rule is
   a **third** candidate note for that same round; it binds this campaign's
   adjudication now and is deliberately not duplicated into the bench yet.
2. **§V.2's pre-fix measurement** for BUG-0003 — deferred to a round of its own;
   disposition and reasons recorded in the packet's own §V.9 and in
   `J-dv_lead-0096`.
3. **FINDING F-1** (SPEC-M03 §6.1 item 2's lane-4 cell) still owed a ruling by
   architect_docs_lead; it moves no cell in this campaign, since every value it
   concerns is REPORTED and none is ASSERTED.
4. **N-1**, carried unchanged.

### Files-in-this-commit
- agents/handoffs/WO-0061_family-i-mutation-campaign.md
- agents/handoffs/WO-0061_family-i-mutation-campaign-SEALED-predictions.md

## [J-dv_lead-0096] 2026-08-07T22:20Z | task:none | BUG-0003's item 5 discharged on evidence that is re-executable rather than derived — and the reason that sentence matters is that it is the exact test §V.2 refuses to waive for the other open item

### Trigger
`J-rtl_lead-0012` landed the promotion at `42b9df3` and CI run **30920890962**
completed REQ-902's double-generation check at that SHA. §7 item 5 — the item
this packet has carried across two RTL changes and which `J-dv_lead-0093`
refused to close over — is now met in both its limbs. The packet's Return log
owes the flip.

### Inputs
- `agents/handoffs/BUG-0003_m03-lane-4-injected-word-cycle.md` §7 item 5, §9.6
  item 5 (the structural prediction attached to it), §V.1's table row and §V.8's
  packet state.
- `agents/journals/claude_rtl_lead_agent.md` `J-rtl_lead-0012` in full — the
  three-link sha chain, the two file hashes and byte counts, the netlist census,
  and its own Open-question 1 (REQ-902 completing at the next CI run).
- `git show --name-status 42b9df3`; `sha256sum rtl_snapshots/*.v` at HEAD.
- The orchestrator's relay of CI run **30920890962** (both jobs green at
  `42b9df3`, determinism's second sample an empty diff).
- **No RTL.** `J-rtl_lead-0012` quotes no module source; the census it publishes
  is a count over the **emitted netlist**, which is a generated artefact under
  `rtl_snapshots/**` that I did not open.

### Reasoning

**Why this is an appended block and not an edited table cell.** §V.1's row says
`NOT MET` and it will keep saying so. A verdict of record is corrected forward,
never amended in place — the rule I applied to a countersignature block at
`RV-0060-VERDICT` §10 item 1, applied now to my own verdict. A reader who finds
the `NOT MET` row and reads on finds the discharge; a reader of a silently
edited table finds a packet that was never wrong about anything, which is the
kind of document nobody should trust.

**Why the discharge is a real one and not a tick.** Item 5 was never about
snapshots existing. It was written — and rewritten after being skipped once —
because §9.6 item 5 attached a **structural prediction** to the regeneration
(three existing registers gain an enable condition, one mux term, no new flop,
no new process, mirrored into `eth_mac_10g.v`) that had gone **unverified across
two fixes**. `J-rtl_lead-0012` grades it against the emitted netlist: 16 → 16
`always @(posedge …)`, 3 → 3 `always @*`, 19 → 19 `reg`, 17 → 22 `if (`, 683 →
709 `wire`. **No flop, no process, five enable conditions, one new mux** — and
the 3,039-line raw diffstat that would have refuted all of it is Hardcaml net
renumbering, which `J-rtl_lead-0012` establishes rather than asserts. The
interlock of the two fixes is verified where it is actually decided.

**The evidence-class point, which is the whole reason I am comfortable recording
this and not comfortable recording the severity conversion.** Both facts come
from rtl_lead. The difference is not authorship, it is **re-executability**: the
sha-256 chain and the netlist census are re-runnable by anyone at `42b9df3` with
two commands, and CI run 30920890962 is externally checkable by id. §9.2's
severity evidence is a **derivation from the RTL** that no committed artefact
reproduces — which is exactly what `J-dv_lead-0093` refused to convert on, and
that refusal is unaffected by today's flip. The two items were separated in §V.8
for a reason and they discharge by different tests.

**Disposition of the remaining item, decided rather than carried.** §V.2's
pre-fix measurement is **deferred to its own round**, not folded into the
`WO-0061` campaign, and the reasons are all ordering reasons: it needs a
transient tree at `fafb83d` (a de-mutation) while every campaign branch is
`42b9df3` + one diff, and one round cannot carry two base SHAs in its evidence;
it is a `test/**` artefact and the campaign round opens no bench file; and
`WO-0061` §0.1's exposure rule bars me from RTL-adjacent work at a pre-fix SHA
while that campaign's seal is being frozen. The shape is fully specified in
§V.2 and restated in §V.9, so the round that runs it needs no further
adjudication from me beyond reading the two numbers back.

**Why this is a second commit and not folded into `J-dv_lead-0095`.** The freeze
commit must contain exactly the packet and its seal, so that the seal appears in
that commit's own `Files-in-this-commit` list and R-SEAL-1's evidence is the
commit itself rather than a paragraph about it. A verbatim-relay bug packet
riding in the same commit would not break the rule but would blur the one thing
the commit exists to demonstrate. Two commits, two entries, two reasons.

### Actions
- Verified both limbs of §7 item 5 against `J-rtl_lead-0012` and the tree
  (`sha256sum rtl_snapshots/*.v` matches the hashes that entry publishes).
- Appended §V.9 to `BUG-0003`: item 5 DISCHARGED, the netlist grading recorded,
  the packet state moved from OPEN-on-two to **OPEN on §V.2 alone**, severity
  held at MAJOR, and §V.2's round scheduled with its reasons.
- Left §V.1's table and §V.8 unedited.

### Evidence
```sh
git show --name-status 42b9df3 | tail -3
#   M  agents/journals/claude_rtl_lead_agent.md
#   M  rtl_snapshots/eth_mac_10g.v
#   M  rtl_snapshots/xgmii_rx_64.v
sha256sum rtl_snapshots/xgmii_rx_64.v rtl_snapshots/eth_mac_10g.v
#   05186ac1a9bae4b1478cdb45c279ab6c0b9dfab87a2031f11dc49e47291de239  xgmii_rx_64.v
#   a309376c9d7082d49fd86100b5718c53dc700603a2780505cd2a50405d7acbc6  eth_mac_10g.v
#   — the two hashes J-rtl_lead-0012 publishes, and the prefixes CI published
```
REQ-902's double-generation limb: CI run **30920890962** at `42b9df3`, both jobs
green, determinism's second sample an empty diff. The netlist census is
`J-rtl_lead-0012`'s own measurement, re-runnable at this SHA; this entry adds no
measurement of its own and re-states none as if it did.

### Outcome
DoD met. `BUG-0003` state: **FIX ACCEPTED — OPEN on §V.2 alone**, severity
**MAJOR**. Handoff: verbatim relay of the packet to rtl_lead via the
orchestrator; the §V.2 round is the orchestrator's to schedule (transient tree,
throwaway branch, nothing entering history).

### Open-questions
1. **§V.2's pre-fix measurement** — deferred with its shape fixed; it is the
   packet's last open item and the severity line cannot move until it returns.

### Files-in-this-commit
- agents/handoffs/BUG-0003_m03-lane-4-injected-word-cycle.md

## [J-dv_lead-0097] 2026-08-08T09:40Z | task:WO-0061 | Nine of nine scoreable classes killed and the one row the campaign existed to test is UNQUALIFIED — the strobe pulsed at cycle 11 against a window that opens at 13, so M03-I2's tightness was never in the running, and the datum that proves it was volunteered by the seeder

### Trigger
Orchestrator dispatch: adjudicate the WO-0061 family-I qualification campaign
against the seal frozen at `61eb242`, all ten diffs committed and all ten
transients harvested RED. The ordering bar of `WO-0061` §0.1 item 2 is
satisfied — the seal is in history, the manifest is committed at `c4ffe7a` — so
this is the first spawn in which I may read the mutation diffs.

### Inputs
- `agents/handoffs/WO-0061_family-i-mutation-campaign.md` (the packet, in full)
  and `agents/handoffs/WO-0061_family-i-mutation-campaign-SEALED-predictions.md`
  (the seal, in full, **opened for the first time in this spawn**). Verified
  unedited since the freeze: `git diff --stat 61eb242 -- <both paths>` empty.
- `docs/reports/audit/WO-0061-mutations/README.md` at `c4ffe7a` — **in full**,
  all ten diffs and every disclosure, per the dispatch's ordering ruling.
- The ten harvest logs (CI runs 30927976269, 30927978551, 30927979347,
  30927986086, 30927984066, 30927984786, 30927986209, 30927988354, 30927989865,
  30927994449), read for their **PROMOTION BLOCKs** rather than their diffs: each
  promoted source base64-recovered and its `sha256` checked against the block's
  own recorded digest, so every failing-unit set below is the run's bytes.
- `test/xgmii_rx_64/test_m03_i.ml` (`run_i1`, `run_i2_member`, `run_i6_case`
  assertion orders), `test/xgmii_rx_64/bench.ml` (`run`, `delivered_samples`),
  `test/xgmii/arrival.ml` (`cycles`), `test/xgmii_rx_64/test_m03_c.ml`,
  `test_m03_e.ml`, `test_m03_f.ml` (the seven green rows' own titles).
- **RTL, opened deliberately and declared**: `libs/hardcaml_ethernet/src/
  xgmii_rx_64.ml` lines 135–148, 341–353, 361–364, 380–398, 470–479, 502. Opened
  **only** to adjudicate FINDING A-1 — why I-c1 produced no family-I red — and
  only after the seal was frozen in history and the bench proven byte-identical
  to its base blob at every mutant (`git diff 42b9df3 mut/... -- test/` empty,
  ten for ten). `WO-0061` §0.1 rules this exposure safe by **ordering**: the
  bench that judged these mutants froze at a SHA strictly earlier than any RTL it
  judged, and that is structural here rather than argued. **No test was written
  or edited in this spawn; no bench file is staged.**

### Reasoning

**Why the headline is a kill count of nine and not ten, and why that is the seal
doing its job rather than an excuse.** I-c1's mandatory disclosure answered the
third standing clause's question (c) — does the gate fire on a **lane-0 terminate
character** — with **YES**. `SEALED` §5.8 enumerated that as **branch (iv)**,
called it *"the dangerous one"*, and fixed its adjudication before any diff
existed: a diff disclosed under (iv) *"is scored as the class not seeded as
specified — a scope report, not a bench result — and no claim about any row is
made from it in either direction."* I wrote that clause because a gate on "any
input word covering no frame octet" fires on a **gapless** event present in every
family, so its row set is one the seal cannot enumerate. It fired exactly as
feared: I-c1's only reds are T-F1, T-F2 and T-G7, all gapless, all in families
the class was never aimed at. **Applying my own clause costs me a kill and buys
the scorecard its integrity**, and the alternative — counting three unpredicted
reds in unrelated families as a kill for a class targeted at REQ-108 under
injection — is precisely the `RV-0055` inflation this programme has already paid
for once.

**The central question, and why I am comfortable ruling against my own row.**
`WO-0061` §4.3 made M03-I2's qualification ride on one class and made the
**offset** decide what a kill there proves. The seal wrote two branches for that
one cell — the only two-branch cell in the file — precisely so the answer could
not be constructed after the fact. Neither branch occurred. What occurred is
worse for the row than either: it reddened on `tuser`, a clean-frame FCS verdict
that twenty-two other units raised in the same run, and its silent-tail scan at
`:501` was never evaluated because `:474` raised first. And the offset is not a
matter of derivation any more — **M03-A3's strobe-monitor report prints
`observed: error_runt@11`** for a 64-octet lane-0 frame terminating at cycle 10,
so the pulse is at **+1** and M03-I2's boundary is **13**. Two independent
grounds, and they agree: the window could not have seen it, and the row never
reached the window. §4.3 item 3 forbids crediting the window with what an earlier
assertion caught first. **UNQUALIFIED**, recorded in the packet in those words.

**The part of that ruling worth carrying forward is not the verdict but its
generality.** The manifest's §6 judgement-call 4 says a `+3`-or-later rendering
*"was available only by delaying the strobe — a defect in the report path rather
than in the threshold comparison — which is a different class"*. That is right,
and it converts a one-round disappointment into a transferable coverage fact:
**M03-I2's tight window is unfalsifiable by any threshold-class defect**, because
§9 pins epoch A's consumption to the `tlast` cycle or age 2 and both lie inside
+0…+2 at every length and both start lanes. The row is not weak; it is aimed at a
defect class no campaign has yet constructed. That is a work order, not a repair.

**Why FINDING A-1 required opening the RTL, and why I judged that admissible
rather than convenient.** I-c1 came back with the whole of `test_m03_i.ml`
green — including M03-I6's 1518-octet member, the one cell the class exists to
reach — while the auditor's disclosure asserted the REQ-108 crossing happens
*"with an enormous margin"*. Two readings were available: the bench is blind to a
truncated maximum-length frame (a CRITICAL finding against me), or the mutant is
observationally equivalent to the base design on the injected half (a finding
against the disclosure). **Those are not distinguishable from the log**, and
guessing between them would have been the exact vice §4.2 exists to prevent. The
design settles it in two lines: `a_close_oversize` requires
`cap_end <: a_hold_end`, and on an all-idle in-frame word `a_hold_v` is `0xFF` so
`a_hold_end` is **0** — truncation is structurally impossible on precisely the
cycles the mutation inflates; and `cap_room` is an unsigned 11-bit subtraction
(`count_bits = 11`) that **underflows** the moment `count` passes 1518, after
which `cap_end` saturates at 8 forever. With the count stepping by exactly 8 the
single cycle at which `cap_room` lies in [1,7] is `count` = 1512 = 8 × 189, and
189 ≡ 5 (mod 8) puts it on a held cycle. **The bench is right and the disclosure
is wrong**, and the manifest's own I-c3 entry states the deciding fact one class
away. I would rather spend a declared RTL read than ship an unresolved CRITICAL.

**FINDING S-1 is the one I am least comfortable with, and it is arithmetic I had
the file open to check.** The seal read `drain = injected + 8` as *"1331 drain
cycles"* of trailing idle at M03-I6's 1518 member. `Bench.run` computes
`total = Arrival.cycles sched + drain`, and `Arrival.cycles` is a function of the
**source** schedule alone — the injected words eat the drain from the inside, so
the true tail is **8 cycles**, which is exactly what `injected + 8` was written
to produce. I had both files open when I wrote the seal and read the formula
without reading its consumer. The corrected inventory is stark and useful: the
suite's idle runs are **1001, 100, and 8** — nothing else. So no threshold
whatever reaches T-I6 or T-I4, §5.7's table is wrong at four branches, and the
observed row set {T-I1} matches none of them. **The correction is also the
campaign's best news**: it makes M03-I1's 1001-cycle prefix the *only* place in
the repository where a T > 100 defect can be seen, which is a stronger claim than
`SEALED` §6 bound 3 dared hope for and which I could not have made without being
wrong first.

**FINDING S-2, and the discipline it indicts.** Every I-c10 message in the seal
is a strobe check; four of the five rows check `tuser` first. I had derived that
exact ordering **one section earlier**, for I-c2, quoting the line numbers. The
failure is not analysis, it is **re-use**: I worked M03-I4's baseline cell (which
is why that one matched character for character) and pattern-matched the other
four from the class's name. `RV-0055` FINDING G-1 was "a cell asserted from a
category with the discriminating quantity unchecked"; GH-1 was the same error one
campaign later. **This is the third instance of that species and the first where
the discriminating quantity was already written down in my own file.** The bench
note owed at the next `test/**` touch is not decoration — it is where this stops
being repeated.

**Why the seven I-c10 greens are not row findings, against `SEALED` §4(e)'s own
rule.** §4(e) fixed that a green at an UNWORKED cell *"is a FINDING … adjudicated
per row"*. Adjudicating them per row is what changes the answer: T-E1/E2/E5 close
under `/E/`, where `a_close_terminate` is low; T-C4, T-F1, T-F2 and T-F3 are
**already runts**, where the mutation is the identity. Both facts are in the
auditor's disclosure verbatim. The rows are blind to nothing. The finding belongs
to §4(e)'s trigger derivation — "a frame closes" instead of "a frame closes on
`/T/` and its true count is ≥ 64" — and I-c10's true reach is **28 units, not
35**. A rule that says "a green is a finding" has to be willing to conclude the
finding is against the rule.

**What I did not do.** I did not edit the SEALED file, now or ever; all eight
falsified cells stand frozen and the verdict block is the correction of record.
I did not open a bench file for editing — `WO-0061` §4.5's closing clause defers
the notes to the next round that opens `test/xgmii_rx_64/`, and this round opens
none. I did not add attack-plan rows for the two coverage gaps the result earns;
on the WO-0058 precedent they are footnoted here and added by the round that can
also test them. And I did not offer `SO-xgmii_rx_64.md`: §7's arithmetic is
unchanged at 38 of 62 ASSERT rows.

### Actions
- Read the seal for the first time, then the manifest in full, then the ten
  harvest logs; recovered and `sha256`-verified every promoted source from the
  runs' own PROMOTION BLOCKs to fix the failing-unit sets exactly.
- Re-executed `WO-0061` §0.1's mechanical independence check on all ten branches.
- Scored every class against its sealed REQUIRED cells on the branch its
  disclosure selects; applied §5.8(iv) to I-c1, §4(e) to I-c10's thirty UNWORKED
  cells, §4(g) to I-c9, §4.4 to every M03-I4 cell and §4.5 to M03-I1/I3.
- Tested all four pre-named collision rules against the observed messages.
- Opened six sites in the M03 source to adjudicate A-1 (declared above).
- Appended `WO-0061-VERDICT` (sections 0–12) to the campaign packet.

### Evidence
- Independence, ten for ten:
  `for c in 1 2 3 4 5 6 7 8 9 10; do git diff 42b9df3 mut/wo-0061-i-c$c -- test/ | wc -c; done`
  → `0` ×10; `git rev-list --count 42b9df3..mut/wo-0061-i-c$c` → `1` ×10;
  `git diff --name-only 42b9df3 mut/wo-0061-i-c$c` →
  `libs/hardcaml_ethernet/src/xgmii_rx_64.ml` ×10.
- Seal unedited: `git diff --stat 61eb242 -- agents/handoffs/WO-0061_family-i-mutation-campaign-SEALED-predictions.md`
  → empty.
- Failing-unit sets (from each run's PROMOTION BLOCK, digests verified):
  i-c1 {M03-F1, M03-F2, M03-G7}; i-c2 {M03-I4, M03-I6}; i-c3 {M03-I4, M03-I6};
  i-c4 {M03-I4, M03-I6}; i-c5 {M03-I4, M03-I6}; i-c6 {M03-I4, M03-I6};
  i-c7 {M03-I4, M03-I6}; i-c8 {M03-I1}; i-c9 {M03-I3};
  i-c10 28 M03 units red, 7 green (M03-C4, E1, E2, E5, F1, F2, F3), T-ST green.
  **No file outside `test/xgmii_rx_64/` promoted on any branch** — 800 non-M03
  must-stay-green cells clean.
- The decisive measurement for §3: i-c10's `test_m03_a.ml` block raises
  `M03-A3 (length 64) lane 0: strobe monitor unclean: … observed: error_runt@11`
  on a frame whose terminate word is at cycle 10 → **offset +1**, against
  M03-I2's boundary of 13.
- The measurement behind S-1: `bench.ml:190` `let total = Arrival.cycles sched + drain in`
  with `arrival.ml:119–126` `((terminate_octet_time last + t.ifg + 7) / 8) + 1`.
- The measurement behind A-1: `xgmii_rx_64.ml:148` `let count_bits = 11`,
  `:342` `let cap_room = of_int ~width:count_bits oversize_threshold -: count`,
  `:361–362` `a_close_oversize = a_open &: (cap_end <: a_char_end) &: (cap_end <: a_hold_end) &: (cap_end <:. 8)`.
- Verdict block: `agents/handoffs/WO-0061_family-i-mutation-campaign.md`,
  `## WO-0061-VERDICT` onward; per-class scorecard in its §1, headline numbers in
  its §11.

### Outcome
DoD met. **Kills 9 of 9 scoreable classes** (10 of 10 branches red; I-c1 a scope
report under `SEALED` §5.8(iv)). **42 of 50 sealed REQUIRED cells met**, 8
falsified and standing unedited. **Zero MUST-STAY-GREEN violations** in either
denominator (274 M03 cells, 800 non-M03). **Qualified: M03-I1, M03-I3, M03-I4,
M03-I6. NOT QUALIFIED: M03-I2.** Six findings — four against my seal (S-1…S-4),
one against the auditor's I-c1 disclosure (A-1), two credits (A-2, A-3) — and
**none against any bench row**. `WO-0061` §4.2's CRITICAL-against-dv_lead branch
is **closed** by I-c5's death at both units. `SO-xgmii_rx_64.md` does not issue:
38 of 62 ASSERT rows discharged, families J/K/M/N and L1–L5 unwritten, the
verilog-ethernet anchor undischarged. Handoff: this packet to the orchestrator;
A-1 to the auditor as a disclosure finding via the orchestrator.

### Open-questions
1. **M03-I2 needs a report-path-delay class to qualify** — a strobe whose
   consumption is deferred past age 2, which no threshold-class defect can
   produce. A one-class mini-round on the WO-0042 precedent; the orchestrator's
   to schedule.
2. **`WO-0061` §8 bound 1 ends half measured.** The delivered-octet instrument
   at an injected run is exercised (I-c6); the `tkeep` instrument is not, because
   its only carrier was I-c1's wide branch and I-c1 is void. Closing it needs a
   delivered-extent class gated on injection that does **not** touch the lane-0
   terminate — a scope decision, not a re-run.
3. **M03-I6's 1518-octet member is unexercised by every class this campaign could
   construct**, and M03-I4's `tkeep`, delay-identity, front-offset and cross-run
   instruments remain unreachable by construction (§8 bound 2).
4. **Five bench notes now owed** at the next round that opens
   `test/xgmii_rx_64/`: `J-dv_lead-0094`'s two, plus the `tuser`-before-strobe
   ordering (S-2), the M03-I6 1518-member gap, and the `drain = injected + 8`
   reading (S-1).
5. **Two attack-plan rows earned, footnoted not added**: a prolonged-idle row
   with a threshold below 100 cycles, and a report-path-delay row for M03-I2.

### Files-in-this-commit
- agents/handoffs/WO-0061_family-i-mutation-campaign.md

## [J-dv_lead-0098] 2026-08-08T11:15Z | task:none | Family B chosen over family J because one of its rows is another family's measured blocked dependency — and the I2 mini-round splits into two packets on the reader, not on the subject, because the family packet's reader is the one agent who must not see a mutation intent

### Trigger
Orchestrator dispatch after the auditor's `DISP-0001` landed at `fab31de`: one
round, two deliverables — the next family bench packet (my queue read governs),
and the M03-I2 report-path-delay class designed as a one-class mini-campaign
(my own escalation 1 from `WO-0061-VERDICT` §3). Plus three dispositions to
return: the `BUG-0003` §V.2 probe's scheduling, the I6-at-even-k gift, and the
correction to my own §12 owed note (iv).

### Inputs
- `agents/charters/dv_lead.md` (§3 attack plans, §8 harvest notes),
  `agents/PROTOCOL.md` (§3 packets and numbering, §4 grammar, §6 scope, **§7's
  new lessons-harvest section**, §10 independence and **R-SEAL-1**).
- `docs/reports/audit/WO-0061-mutations/DISP-0001_A-1.md` **in full** at
  `fab31de` — §2.4's correction of my two supporting sentences (the cap binds
  **six** times, all frozen to held cycles by the residue 189 mod 8 = 5),
  §2.4's k-parity rule (binds at `t ≡ 189 (mod 256)`, always odd, so no odd k
  can place one on a covering word), §4's **R-DISC-1**/**R-DISC-2**, and §5's
  forward gift.
- `agents/handoffs/WO-0061_family-i-mutation-campaign.md` §8 (bounds 1–7), and
  its VERDICT §3, §10, §11, §12 (the owed notes and the two earned rows).
- `agents/handoffs/WO-0058_m03-g7-h-mutation-campaign.md` §3 (FINDING GH-1's
  by-product: the alignment-transition instrument is one point), §4 (GH-2's
  missing disclosure column), §8 bound 2, §9 bounds 6 and 7.
- `agents/handoffs/BUG-0003_m03-lane-4-injected-word-cycle.md` §V.2 and §V.9
  (the probe's specification and the three grounds for deferring it).
- `test/attack_plans/AP-xgmii_rx_64.md` §4.A–§4.N — B1–B4, E5, F2, H2, H4, I2,
  I6, J1–J4, M10, N3's "carried at M03-B2" sentence.
- `test/xgmii_rx_64/bench.mli` (in full — `create` holds `cfg_rx_enable` at 1;
  the `Before` view; `run`'s drain), `test/xgmii/injection.mli` (placements,
  the `/S/` lane refusal, the `/I/`-at-preamble acceptance),
  `test/monitors/strobe_monitor.mli` (`not_before`/`not_after`),
  `test/xgmii_rx_64/test_m03_b.ml`, and the relevant runners of
  `test_m03_e.ml` (`run_e5`), `test_m03_f.ml` (`run_f2`), `test_m03_h.ml`
  (`run_h4`), `test_m03_i.ml` (`run_i2_member`, `run_i2`).
- My own `J-dv_lead-0094`, `J-dv_lead-0096`, `J-dv_lead-0097`;
  `WO-0060`'s `RV-0060-VERDICT` §10 item 3.
- **No `libs/**`, no `rtl_snapshots/**`. No writes anywhere but
  `agents/handoffs/`.**

### Reasoning

**The queue read, and it is not close.** Family J opens a new requirement group
(REQ-802/803/810) behind a **machinery** dependency I confirmed rather than
recalled: `bench.mli`'s `create` holds `cfg_rx_enable` at 1 for the whole run
and exposes no schedule for it, so J1–J3 cannot be written at all until a
capability round lands, and J's observables are entangled with **M03-N4**
(ADR-0014) and family K's `clear` exemptions, so rows written now would be
re-litigated when N4 does. Family B needs **no new capability** and pays **two
named debts**: `WO-0058` §9 bound 6 names **M03-B4's geometry** as where the
alignment-transition instrument's owed second point belongs — a class carried
today by one member of one unit in a 116-unit bench — and `AP` §4.M's **M03-M10
claims two carriers and has one**, the missing one being M03-B3's `/T/` in a
preamble position. Three rows that close another family's measured hole beat
three rows that open a frontier behind a tool dependency.

**What I checked rather than assumed, because the plan's prose hides it.**
`At_preamble p` puts a character at `start_ot + p`, and with `frames_at`'s
mapping (`first_start` 8 / 12) both start words are cycle 1. So B2's two members
— "lane 3 of a lane-0 start word" and "lane 7 of the start word at a lane-4
start" — are **the same placement, position 3**, at the two lanes; B3's is
position 5 at lane 0; B4's is position 4 at lane 0, landing in lane 4 of the
same word. And `run_e5` **already sweeps preamble positions 1 … 7 with an `/E/`
at a lane-0 start**, so B2's lane-0 member is E5's position-3 unit plus a
following frame. I wrote that into the packet as the row's honest weighting
instead of letting the worker discover it: B2's new content is the lane-4
geometry and the following-frame recovery, and nothing else.

**B4's construction is the round's real derivation, and its trap is silent.**
Frame B opens at octet time 12, so its preamble positions 4 … 7 consume the
first four octets of the case's array and **its own octet 0 is array index 4**;
`Arrival` auto-places the terminate after the whole array. An array of 64
therefore gives frame B **60** received octets — a runt, a different observable,
and a row that passes as a different test. The array must be **68** (4 filler +
a clean 64-octet frame), giving 64 received, 60 delivered, 8 words, final
`tkeep` 0x0F, word m at cycle 4 + m. I put the arithmetic in the packet as a
derivation to check and the count as a guard to write, because handing down a
number without its working is what put "100 octets" into families G3/G4.

**What B4 does and does not pay, said in the packet so it cannot be over-read.**
It pays bound 6 with a second point **and a second instrument** — the
resynchronised frame's delivered content, where `run_h2`'s instrument is the
aborted frame's trailing octets. It does **not** pay bound 7: nothing is open on
entry to the word, so the in-word abort with a frame already open is untouched.
And the genuinely *opposite* transition (4 → 0) is `At_preamble 4` at a **lane-4**
start, which is a cross-word abort in the next word — a **member addition to a
committed row**, therefore my plan edit and not a worker's. Footnoted, not
written: this round has no defect requiring an AP edit and I did not manufacture
one.

**The second plan ambiguity I found and did not resolve by fiat.** §4.N's M03-N3
says the assertable REQ-105 case an idle-in-preamble makes available is
*"carried at M03-B2"*, while B2's own stimulus cell names only `/E/`, and
`injection.mli` accepts `/I/`//`/Q/` at `At_preamble` and nowhere else. The plan
speaks twice with different extension. The narrow reading (the row's stimulus
cell governs) is what I commissioned, because commissioning a unit that maps to
no row breaks the coverage map that the `SO-` is built on; reconciling the cells
is a plan edit I now owe.

**The I2 mini-round: why two packets, and it is a rule about readers.**
`WO-0042`'s precedent folded a mini-round into the family packet — and its
reader was the *seeder*. `WO-0062`'s reader is the **bench author**, and the two
rows nearest this class are B2's and B3's strobe pins, exactly what a leaked
intent would tune. Every campaign since family E has kept intents away from
bench authors; folding here would have spent that discipline for a page saved.

**Designing the class made me refute the brief's own hope, and the refutation is
the design.** A mutant *only* M03-I2 can kill does not exist: `run_f2` asserts
the pinned strobe cycle exactly, so any report-path deferral reddens M03-F2 at
six units and M03-B3 at one. Claiming uniqueness without evaluating the sibling
units would be `DISP-0001` §3's fan-out error committed in my own direction, one
round after I convicted it. **What is unique is the instrument**: M03-I2's
window is the only assertion in the bench that reads a strobe's cycle against
C-14.3's drain bound rather than against §9's pin, and qualification is earned
when *that* instrument convicts with its own message and nothing inside its own
unit convicted first.

**Three structural findings fell out of the design and all three are in the
packet.** (1) The `tvalid` half of I2's window is **permanently shadowed**: the
row asserts every output word's cycle before it scans the tail, so a late word
always raises at the earlier guard — the window can only ever convict on a
strobe. (2) Both committed members are clean frames that owe no strobe, so
member **(iii)** — F2's zero-received `/T/` stimulus, no new machinery — is what
makes the row's own declared kill reachable; and its boundary must come from the
**closing** character, not from `Arrival.terminate_octet_time`'s declared one,
or the member measures a window ten cycles away from its own defect. (3) §0.6's
window `[W, W+3]` **admits the very cycle C-14.3 forbids**, so the standing
strobe monitor cannot see this class at any unit in the bench — an open question
for the architect, not a defect, since §9's pin is exact and normative.

**A member, not a row — correcting my own footnote.** `WO-0061` §12 called the
earned artefact a *row*. A new row would carry a **copy** of the silent-tail
scan, and qualifying a copy qualifies nothing about M03-I2. It is a member.

**IC-2 is the part I would not have written a month ago.** Seeding only the
class you hope will convict cannot distinguish a working instrument from a loud
one — that is precisely what `WO-0061` §3 had to settle *after* the run, on a
datum the seeder happened to volunteer. So the round seeds a **control**: the
same deferral on the `tlast`-pinned path, whose required consequence is that
M03-I2 stays **green** at all three members. The four dispositions are
pre-committed, including the one where the window is declared structurally
shadowed and the plan owes a NO-ASSERT rather than another member.

**Harvest (ADR-0018, PROTOCOL §7).** **Not due this round** — no `SO-` and no
gate. Span accruing since the chain's start and untiled by any prior harvest:
**J-dv_lead-0001 … 0098**; the first harvest fires at `SO-M03` and will state
that interval so the tiling is visible and a skip would be a gap.

### Actions
- Read `DISP-0001` in full, the two campaign packets it turns on, and the four
  bench runners whose assertions decide this round's designs. No RTL.
- **Authored `WO-0062`** (family B: M03-B2, B3, B4) — the queue-read rationale,
  thirteen standing bars, per-row derivations with their guards, a risk ranking
  that doubles as the review order, ten named traps, the five owed bench notes
  with **(iv) corrected**, and three earned-but-not-commissioned items.
- **Authored `WO-0063`** (the M03-I2 mini-round) — two phases, the plan-edit
  precedence, member (iii)'s derivation and its boundary trap, two mutation
  intents (one required red, one required green), the mandatory disclosure axis,
  R-DISC-1 discharged on the bench side term by term, the uniqueness claim
  explicitly withheld with its refutation, an R-SEAL-1 forward commitment, four
  pre-committed dispositions, and the `BUG-0003` §V.2 probe's scheduling.
- **Edited no `test/**` file, including the attack plan.** No defect this round
  required an AP edit; the two plan changes I found I owe are footnoted in
  `WO-0062` §6.2 and `WO-0063` §2.1.
- Ran no `git` command that writes.

### Evidence
1. `At_preamble p` → `start_ot + p` (`test/xgmii/injection.mli`, placement) with
   `first_start` 8 / 12 (`bench.mli`, `frames_at`): B2 position 3 → octet times
   **11** (lane 0, lane 3 of cycle 1) and **15** (lane 4, lane 7 of cycle 1);
   B3 position 5 → **13** (lane 5, cycle 1); B4 position 4 → **12** (lane 4,
   cycle 1). All four closing characters lie in the **start word**, so §9's
   no-output pin puts every family-B report on **cycle 3**, window **[1, 4]**.
2. B4 frame B: opens at octet time 12 (lane 4); octet 0 at **20** = array index
   4; auto-terminate at `16 + 68` = **84**; received `84 − 20` = **64**;
   delivered **60**; **8** words; final `tkeep` **0x0F**; word m at cycle
   **4 + m**.
3. Family J's blocker, quoted from the file rather than recalled —
   `test/xgmii_rx_64/bench.mli:53–56`: `create` "release `clear` after one cycle
   and hold `cfg_rx_enable` at 1 for the rest of the run — family J (the disable
   path) is out of this packet's eleven rows".
4. E5's sweep is positions **1 … 7** at a lane-0 start with `error_char`
   (`test_m03_e.ml:696–710`), single case, no following frame — hence B2's
   overlap and its two genuinely new facts.
5. `run_f2` asserts the exact pulse cycle (`test_m03_f.ml`, the
   `error_runt pulsed on cycle …, expected …` branch) — the measurement behind
   `WO-0063` §5's refusal to claim uniqueness.
6. `run_i2_member` orders per-word cycle assertions **before** the silent-tail
   scan (`test_m03_i.ml`, `run_i2_member`) — the measurement behind the
   permanently-shadowed `tvalid` half.
7. Member (iii)'s numbers: `At_octet 0` → closing `/T/` at octet time **16**
   (lane 0) / **20** (lane 4), both **cycle 2**; §9 pin **cycle 4**; §0.6 window
   **[2, 5]**; C-14.3 boundary `W + 3` = **5**; conformant margin **one cycle**.
   The declared terminate for the same stimulus is at octet time 80, **cycle
   10** — the trap the member's own runner must avoid.
8. §0.6's window upper bound for the zero-received branch is `closing_cycle + 3`
   (`test_m03_f.ml`'s `expected_not_after` when `k = 0`), i.e. the same cycle
   C-14.3 forbids — the strobe-monitor blindness recorded in `WO-0063` §5.
9. `DISP-0001` §2.4's gift, transcribed into `WO-0062` §6.1(iv) as the corrected
   note: binds recur at `t ≡ 189 (mod 256)`, always odd; k = 7 is odd; the same
   mutant truncates at k = 2.

### Outcome
DoD met for the round as dispatched. **Two packets drafted, nothing else
staged**: `WO-0062` (family B, three rows, to tb_writer) and `WO-0063` (the
M03-I2 two-phase mini-round, to orchestrator/auditor). **No `test/**` edit and
no AP edit** — the two plan changes I owe are footnoted, with their derivations,
in the packets. The three dispositions asked for are recorded: the `BUG-0003`
§V.2 probe **rides with phase A** of `WO-0063` (two of §V.9's three grounds have
expired; the two-base-SHA ground is honoured by keeping it out of phase B), the
**I6-at-even-k gift rides as a note** and joins no class list until the
injection-depth question is settled, and **owed note (iv) is corrected** to
*unexercised at k = 7*, with the parity rule that makes the immunity an
accident. `SO-xgmii_rx_64.md` does not issue and is not offered: 38 of 62 ASSERT
rows discharged, families J/K/M/N and L1–L5 unwritten, the verilog-ethernet
anchor undischarged.

### Open-questions
1. **Two plan edits are now owed by me**, both footnoted rather than taken:
   M03-B4's lane-4 member (the 4 → 0 transition, `WO-0062` §6.2 item 1) and the
   M03-B2 / M03-N3 extension conflict over `/I/` in a preamble position (item 2).
2. **M03-I2's third member is a plan edit that must precede its bench**
   (`WO-0063` §2.1) — charter §3's attack-plan-before-first-test rule, and it is
   mine to make in the commit that opens phase A.
3. **Open to architect_docs_lead**: is §0.6's `[W, W+3]` window normative
   alongside §9's exact pin for a no-output report, and is `W + 3` therefore
   conformant under §0.6 and non-conformant under C-14.3? No row moves on the
   answer; the standing strobe monitor's reach does.
4. **`WO-0058` bound 7** (an in-word abort with a frame already open on entry)
   is untouched by family B and has no candidate row.
5. **`WO-0061` §8 bound 1's `tkeep` half** at an injected run stays unmeasured,
   and the `RV-0060` §10 item 3 citation sites ride with `WO-0063` phase A, the
   next family-I bench round.
6. **Family J is next after a bench-capability round**, and that round is the
   orchestrator's to schedule; it is not deferred further than that.

### Files-in-this-commit
- agents/handoffs/WO-0062_tb-m03-family-b-preamble-and-sfd.md
- agents/handoffs/WO-0063_m03-i2-report-path-delay-mini-round.md

## [J-dv_lead-0099] 2026-08-04T18:40Z | task:WO-0062 | Family B accepted with one reviewed repair — and the finding that decided the round is not a derivation error but a partition idiom transplanted into the first run in this bench where one partition is empty by construction

### Trigger
Orchestrator dispatch, `RV-0062`: line review of tb_writer's family-B build at
`88da20e` (`run_b4`/`run_b3`/`run_b2` in `test/xgmii_rx_64/test_m03_b.ml`, the
five owed §6.1 bench notes in `test_m03_i.ml`, one `dune` header line), in the
packet's own ranked order B4 → B3 → B2, with two judgement calls flagged for
adjudication and a helper-duplication disposition owed.

### Inputs
- `agents/handoffs/WO-0062_tb-m03-family-b-preamble-and-sfd.md` — §2 (the
  thirteen bars), §3.1–§3.3 (the derivations), §4 (the ranking that is the review
  order), §5 (traps T1–T10), §6.1 (the five owed notes), §6.2 (the three
  footnoted items), §8 (pass criteria), and the full `RETURNED` block.
- `test/xgmii_rx_64/test_m03_b.ml` at `88da20e`, read end to end.
- `test/xgmii_rx_64/test_m03_i.ml` — the thirteen note insertions, and
  `run_i2_member` / `assert_clean_frame_structure` for adjudication 1.
- `test/xgmii_rx_64/bench.mli` (`run`, `delivered_samples`, `error_pulses`,
  `account_clean_frame`, `frames_at`, `directed_frame_octets`,
  `assert_monitors_clean`); `test/xgmii/injection.mli` (`placement`,
  `corruption`, `outcome`'s ten fields, `create`'s `?first_lane`);
  `test/xgmii/arrival.mli` (`frame`, `start_cycle`, `in_times`);
  `test/monitors/conservation_monitor.mli` (`discarded`, `strobe_pulse`).
- The landed precedents the review had to compare against:
  `test_m03_e.ml:139/:598` (`account_dropped_frame`, `run_e5`'s zero-delivered
  shape), `test_m03_f.ml:740`, `test_m03_g.ml` (six sites),
  `test_m03_h.ml:164/:210/:227/:351/:905` (`split_at_first_tlast`,
  `account_spliced_forwarded`, `run_h4`'s three-frame splice).
- `agents/handoffs/WO-0061_family-i-mutation-campaign.md` §4.5 and my own
  `J-dv_lead-0094` — opened specifically to settle adjudication 1, which
  tb_writer correctly refused to open.
- `agents/charters/dv_lead.md`, `agents/PROTOCOL.md` §3, §4, §6, §7, §10.
- **CI**: run `30937558341` (`build`, `88da20e`, failure, job `92087417632`) and
  its promotion block; `30937164518` (`build`, `a12ac8f`, success).
- **No RTL, no `libs/**`, no `docs/reports/audit/**`.**

### Reasoning

**The review found the defect; CI proved it. I want the order on the record,
because the reverse order is a different discipline.** Reading `run_b3`'s
structural block against `split_at_first_tlast`'s own definition, the inversion
is visible without running anything: the helper returns *(prefix through the
first `tlast`, remainder)*, and with frame 1 delivering nothing under §0.7 the
run's first `tlast` group **is** frame 2's. So frame 2's eight words are handed
to the guard that asserts frame 1 delivered none, and a conforming design goes
red with a message accusing the design of violating §0.7. Only afterwards did I
pull run `30937558341`, which prints exactly that `Failure` at exactly
`test_m03_b.ml:614` and `:791`. Had I taken the CI red first I would have been
debugging a stack trace; taking it second, it is a confirmation of a diagnosis
that already had a cause and a repair attached. Under ADR-0005 that ordering is
the only thing separating review from bisection.

**Why this is not a derivation failure, and why saying so precisely matters.**
Every number tb_writer derived is right, and the same CI run proves it: for both
failing rows, the construction guards, the `fail_cross` cross-check against
`Injection.outcomes` and **both** landing sites executed without raising before
line 614/791 was reached. Cycle 3, window `[1, 4]`, B4's received-64 /
delivered-60 / 8 words / `tkeep` 0x0F / `tlast` at 11 — all of it stands, and
B4's `%expect` block came back **unchanged**, meaning the whole runner including
`account_forwarded_frame` and every standing monitor is green on the DUT. What
failed is one **idiom**, imported from six landed files, whose unstated
precondition — that both frames deliver — holds in all six and holds in neither
of these two. That distinction decided the disposition, so it is not a
courtesy.

**Repair, not bounce, and the bar I applied.** The dispatch allows editing a
bench for a defect I would otherwise bounce as trivial. I applied a three-part
test: the correct form must be **unique**, **mechanical**, and **provable
without re-deriving the row**. All three hold here — list partitioning is a
one-sentence fact, no expected value moves, and everything upstream is already
measured green. So: repaired, itemised as `RV-0062` reviewed repair R-1, under
my own name. The counterfactual is the part worth journaling: had the defect
been in a derivation, a strobe set, a §0.6 window or a stimulus cell, it would
have **bounced**, because those are the worker's to re-derive and mine to
re-review, and a lead who repairs them is grading his own work. The line is not
"how small is the diff", it is "who owns the claim the diff makes".

**The repair's shape was chosen for the message, not for brevity.** The
one-liner would have been to pass `delivered_samples samples` straight to
`assert_following_frame_intact` and let its word-count guard convict. I refused
that: a frame-1 leak would then print a **frame 2** message, and owed note (ii)
— written by me, one round ago, about exactly this — says which instrument
convicts is a control-flow fact that decides what a reader sees. So frame 1
keeps its own instrument (nothing delivered before frame 2's own first word
could arrive, with the bound read from `Arrival`, never authored — T3 survives)
and its own message, and a second guard catches the other leak shape (a frame-1
group carrying its own `tlast`). Two defect shapes, two messages, one anti-vacuity
partner retained.

**Adjudication 1 — note (i)'s site — was settled by evidence, not by
preference.** tb_writer could not open `WO-0061` and said so rather than
guessing; that is the right conduct and I want it recorded as such. Opening it,
the answer is overdetermined: `J-dv_lead-0094` states the finding as
"`delivered_samples`' count cannot disagree", naming the instrument, and
`WO-0061` §4.5 locates it by line (`:290`, `:445`). The construction-time guard
compares this file's arithmetic to a packet parameter and never reads the DUT,
so it cannot be the subject of a claim about the *emitted* count. Placement
correct; no repair. I also counted the placements against §6.1 rather than
against the dispatch's summary — 5 + 1 + 4 + 1 + 2 = **13**, exactly the sites
the packet names.

**Adjudication 2 — one strobe check, and tb_writer undersold its own work.** It
asked whether the docstring's two mentions of strobe exactness owed two checks,
and answered "one", calling the second redundant. Right answer, incomplete
reason. §3.1 names two *claims*: frame A's report at the pin (which the standing
`Strobe_monitor.expect` record checks, with §0.6's window, per frame) and the
run-wide exact set (which `error_pulses` checks, drain included). Two
instruments, both already present. A second `error_pulses` match would duplicate
one instrument and leave the other uncredited — and would add a second message
for one fact, which is note (ii)'s own hazard. I ruled the built form correct
and recorded the two-instrument reading so the docstring is not re-litigated.

**Helper duplication: accepted now, consolidation owed — and the justification
is not tidiness.** Three copies of `account_dropped_frame`, two of the
forwarded-with-no-`Arrival`-record shape, two of the spliced-dropped shape, six
of `split_at_first_tlast`. I accepted the duplication for this round on the
ground the round itself just demonstrated: B-1 was catchable because the row's
diff was small enough to read line by line, and a refactor's blast radius inside
a row round destroys exactly that. But I attached a third binding condition to
the owed consolidation that turns it from housekeeping into a debt worth paying:
`split_at_first_tlast` must not move into `bench.ml` **without its precondition
recorded at the definition**. A shared copy of an idiom whose precondition is
unstated is strictly worse than six local copies of it — six readers each
transplanting it locally at least look at the call site, which is more scrutiny
than one import gets.

**Two findings I deliberately did not repair.** B-2: the Return log claims a
five-field cross-check on every clean/forwarded frame; that is true of B4's
frame B and false of B3's/B2's frame 2 (`delivered` + `reports` only). I did not
add the missing fields, because an assertion I cannot run is how a reviewer
turns a green row red — and the depth built is exactly `test_m03_h.ml`'s landed
precedent for a following clean frame, with the `start_cycle + 3 + m` rule
independently anchored by `assert_clean_frame_structure`, which is green at both
lanes. B-3: both frames in B3/B2 are `directed_frame_octets ~length:64`, hence
byte-identical, so frame 2's content comparison cannot distinguish frame 2 from
frame 1 delivered in its place — only the cycle checks discriminate provenance.
The remedy is a **stimulus** change, which is mine to commission in a packet,
never to make inside a review. Both go to the next family-B round.

**Harvest (ADR-0018, PROTOCOL §7).** **Not due this round** — no `SO-`, no gate.
Span since the note at `J-dv_lead-0098`: **J-dv_lead-0099** (this entry);
cumulative untiled span **J-dv_lead-0001 … 0099**, and the first harvest fires
at `SO-M03` and will state that interval so the tiling is visible. **One
candidate banked**, stated now so it is not reconstructed later: *"An idiom that
partitions a stream by its own terminator presumes every partition is non-empty;
transplanted to a case where one partition is empty by construction, it silently
re-labels the surviving partition as the missing one — and the guard written to
prove absence convicts the thing that is present."* **LH1**: `88da20e`, CI run
`30937558341`. **LH2-g** (no proper noun in the rule). **LH3**: without it, a
conforming implementation fails its own test with a message accusing it of the
violation the test was written to detect — a false red indistinguishable, to its
reader, from a true one. Not admitted here; admitted or refused at the harvest.

### Actions
- Line-reviewed `run_b4`, `run_b3`, `run_b2` against `WO-0062` §3's stimulus
  cells and derivations, §5's traps T2/T3/T4/T6, and §2's bars 2, 3, 4, 5, 6, 8,
  10, 12, 13; verified B1 untouched mechanically (728 insertions, 0 deletions)
  and the thirteen `test_m03_i.ml` note insertions as comment-only.
- Diagnosed FINDING **B-1** from the source, then confirmed it against CI run
  `30937558341`'s promotion block (line- and message-exact).
- **Edited `test/xgmii_rx_64/test_m03_b.ml`** — reviewed repair **R-1**, in
  `run_b3` and `run_b2`: replaced the inverted two-group `split_at_first_tlast`
  structural block with an `Arrival`-derived cycle bound for frame 1's silence
  plus a single-`tlast`-group check, each carrying a comment naming the repair
  and the idiom's precondition. No derivation, message string, strobe check,
  conservation call or assertion order moved.
- Opened `WO-0061` §4.5 and `J-dv_lead-0094` to adjudicate note (i)'s site;
  ruled the placement correct.
- Appended `RV-0062-VERDICT` to the work order: ACCEPT per row (B4 unmodified;
  B3/B2 with R-1), the CI measurement table, the two adjudications, the
  helper-duplication disposition with three binding conditions, findings B-2/B-3/B-4,
  the trap-by-trap verification, and the landing check owed by the orchestrator.

### Evidence
```sh
git show 88da20e --stat
#   test/xgmii_rx_64/test_m03_b.ml | 728 +++++  (0 deletions -> M03-B1 untouched)
#   test/xgmii_rx_64/test_m03_i.ml | 105 ++-   (104 insertions, 1 comment-terminator move)
ocamlc -stop-after parsing test/xgmii_rx_64/test_m03_b.ml   # exit 0, after repair R-1
git status --porcelain
#   M agents/handoffs/WO-0062_tb-m03-family-b-preamble-and-sfd.md
#   M test/xgmii_rx_64/test_m03_b.ml
```
CI at `88da20e` (externally verifiable, PROTOCOL §4.1(b)): `build` run
**30937558341**, job **92087417632**, conclusion **failure**; `journal-check`
run **30937558388**, success. Baseline `build` **30937164518** at `a12ac8f`,
success. The failing run's promotion block carries, character-exact:

- `(Failure "M03-B3: frame 1: an output word was observed for a frame that must deliver nothing (§0.7)")` raised at `test/xgmii_rx_64/test_m03_b.ml`, line **614**;
- `(Failure "M03-B2 (lane 0): frame 1: an output word was observed for a frame that must deliver nothing (§0.7)")` raised at line **791**;
- M03-B1's and **M03-B4's** `[%expect {||}]` blocks **unchanged** — both rows passed.

`dune runtest` was **not run** (ADR-0005 — no Hardcaml toolchain in this
container). The verdict's ACCEPT is conditioned on a green `build` at the commit
carrying repair R-1; that run does not exist yet and no claim is made about it.

### Outcome
DoD met. `RV-0062` returned as a committed verdict in the packet, not as chat:
**ACCEPTED**, B4 unmodified, B3/B2 with reviewed repair R-1, no row bounced.
Both flagged judgement calls adjudicated with cited evidence; the
helper-duplication disposition recorded with its three binding conditions.
Handoff: `agents/handoffs/WO-0062_tb-m03-family-b-preamble-and-sfd.md`
(`RV-0062-VERDICT`). **No `SO-xgmii_rx_64.md` issues and none is offered** — 41
of 62 ASSERT rows once these three land; families J/K/M/N and L1–L5 unwritten;
the verilog-ethernet anchor undischarged. No claim is made about what family B
kills: these rows enter a mutation denominator for the first time at the next
freeze (`WO-0058` §8).

### Open-questions
1. **The landing check is owed to me by the orchestrator**: a green `build` run
   at the commit carrying repair R-1, with all four `%expect` blocks in
   `test_m03_b.ml` empty and `git diff --exit-code` clean. **M03-B2's lane-4
   member has never executed** — `List.iter` raised on lane 0 at `88da20e` — so
   that run is a real check, not a formality. If it is red it is mine, not
   tb_writer's, and bounces to me rather than re-spawning the worker.
2. **Machinery-consolidation round owed and drafted by me**, with the three
   conditions of `RV-0062-VERDICT` §5 — in particular that
   `split_at_first_tlast` may not be shared without its precondition recorded at
   the definition.
3. **Findings B-2** (deepen the following-frame `Injection.outcomes` cross-check
   to B4's five fields, suite-wide) and **B-3** (give B3/B2's frame 2 a distinct
   declared length so content discriminates provenance) ride with the next
   family-B round; **B-4** (a stale M03-B4 forward reference in
   `test_m03_h.ml`'s module docstring) rides with the next round opening that
   file.
4. **My two owed plan edits stand** (`WO-0062` §6.2 items 1 and 2): M03-B4's
   lane-4 member, and the M03-B2 / M03-N3 extension conflict over `/I/` in a
   preamble position.
5. Carried unchanged from `J-dv_lead-0098`: the §0.6-window question open to
   architect_docs_lead; `WO-0058` bound 7 with no candidate row; `WO-0061` §8
   bound 1's `tkeep` half; family J behind a bench-capability round.

### Files-in-this-commit
- agents/handoffs/WO-0062_tb-m03-family-b-preamble-and-sfd.md
- test/xgmii_rx_64/test_m03_b.ml

## [J-dv_lead-0100] 2026-08-04T20:05Z | task:WO-0064 | The consolidation packet written to be un-hideable, and the plan stopped speaking twice about the preamble

### Trigger
Orchestrator dispatch: one round, two deliverables — item 1 of my own
`RV-0062-VERDICT` §8 queue (the bench-machinery consolidation I commissioned at
that verdict's §5, under three binding conditions I fixed there) and the two
attack-plan edits owed since `J-dv_lead-0098` (`WO-0062` §6.2 items 1 and 2),
with `RV-0062` findings B-2 and B-3 to be folded into the plan wherever it
should carry them.

### Inputs
- `agents/handoffs/WO-0062_tb-m03-family-b-preamble-and-sfd.md` — §2 bar 10,
  §3.1, §3.3, §5 (T3, T4, T6), §6.2 items 1 and 2, the `RETURNED` block §4, and
  my own `RV-0062-VERDICT` §2, §5, §6 and §8.
- `agents/handoffs/WO-0058_m03-g7-h-mutation-campaign.md` §9 bounds 6 and 7,
  read in full because member (b)'s payment claim turns on their exact wording.
- `test/attack_plans/AP-xgmii_rx_64.md` — §0, §1 (the row grammar and the
  permanence rule), §2, §3, §4.B, §4.N (M03-N3 in full, and M03-N2's six-row
  table), §6 (the REQ-102/105/110/113/016 lines), §8 (the WO-0029 §3b ruling
  record), §9.
- `test/xgmii_rx_64/` at HEAD, measured rather than recalled: `bench.ml`,
  `bench.mli`, `dune`, `.ocamlformat`, and every `test_m03_*.ml` — the fourteen
  helper definitions, their bodies, their comment blocks and all forty-seven
  call sites and passing mentions.
- `test/xgmii/injection.mli` (`placement`, `At_preamble`'s 1 … 7 domain, the
  `Place` docstring's `/I/`//`/Q/` clause and its lack of a lane restriction);
  `docs/specs/requirements.md` REQ-102, REQ-105, REQ-110, REQ-113, REQ-018,
  §0.5, §0.7.
- `agents/charters/dv_lead.md`; `agents/PROTOCOL.md` §3, §4, §6, §7, §10.
- **No RTL, no `libs/**`, no `rtl_snapshots/**`, no `docs/reports/audit/**`.**

### Reasoning

**The consolidation's home: `bench.ml`, and the argument is the fourth
member.** The tempting answer is a new `accounting.ml` — separation of concerns,
and `bench.ml` is the file that elaborates the DUT. I rejected it because the
family's fourth case, `account_clean_frame`, is *already* in `bench.ml`, and a
new module does one of two bad things: it strands that case, leaving one concept
with its cases in two modules — **which is precisely the configuration that
produced the drift I am paying off** — or it drags the case along and rewrites
every clean-frame call site in ten files, a diff several times the size of the
one whose readability is condition (ii)'s whole point. The clinching fact is
textual: fourteen local copies each carry a comment saying *"`{!Bench}` is the
only shared surface, so every family file carries its own copy"*. The refactor's
job is to make that sentence true, not to invent a second shared surface that
makes it false in a new way.

**The measurement that reshaped the packet, and that I would not have had by
reasoning.** Every family file already carries `open Bench`. So for
`account_dropped_frame` and `split_at_first_tlast`, deleting the local `let` is
*sufficient* — the name re-resolves through the `open` and **not one of their
thirty-six call sites changes**. That turns two thirds of this refactor into pure
deletion, and it let me forbid gratuitous `Bench.` qualification in the packet
rather than discover thirty-six needless edited lines at review. A packet
written from memory would have commissioned those edits.

**Naming: I spent churn deliberately, and here is what I bought.** I could have
kept every existing name and had eleven fewer edits. I renamed two identities
onto a `_frame`/`_piece` axis instead — `_frame` has an `Arrival.frame` and
reads `Arrival.in_times`; `_piece` has no such record and the caller sizes the
input trace by hand. The reason is not taste: **that axis is the trap**.
`RV-0057-VERDICT` Finding 1 was a `_piece`-shaped call whose trace was sized by
what the frame *delivered* where the contract wanted what it *received*, and it
was harmless only by cancellation. `account_spliced_forwarded` and
`account_resync_runt_frame` name *the family that first needed them*; the next
writer meets a name describing someone else's situation and re-derives the
contract from the body. A name must carry the thing the caller has to get right.

**Condition (i) is the whole risk of this round, so I made it decidable by a
script rather than by care.** Campaign seals cite exact failure messages. The
obvious way to protect them is diligence; diligence does not survive a
fourteen-way textual comparison. So I measured `fail` and `fail_cross` — and
they are **character-identical in all nine and all five files respectively**,
which means consolidating them would in fact change no emitted text. **I
excluded them anyway.** First, because the debt is contract-bearing helpers, and
a one-line `failwith` wrapper has no precondition anyone could transplant
wrongly — fourteen copies of it cost nothing. Second, and this is the real
reason: because no message-producing function moves, the diff of this round
contains **no added or removed string literal anywhere in the directory**, which
is one command that either prints nothing or bounces the packet. I chose the
scope boundary to make the seal-safety property mechanical. That is worth more
than the lines the exclusion leaves on the floor.

**One correction against myself, put in the instruction rather than the
verdict.** `RV-0062-VERDICT` §5's table says `split_at_first_tlast` has six
copies. The tree has **seven** (b, d, e, f, g, h, i). The verdict's count came
from the sites the review had opened, not from a census. I did **not** edit the
verdict — a verdict records a judgement at a time — and put the corrected table
in `WO-0064` §3 with the reason stated, because the *instruction* is the thing
that has to be right, and I told the worker that if its own count disagrees with
mine, its count and the Return log win and it stops before editing.

**The B4 lane-4 member: I checked what it pays *and* what it does not.** The
member is genuinely opposite geometry — the same `At_preamble 4` placement at a
lane-4 start lands at octet time 16, which is **lane 0 of the following word**,
aborting a frame already open on entry, with the alignment transition **4 → 0**
against member (a)'s and `run_h2`'s common **0 → 4**. It was tempting to write
that it closes `WO-0058` bound 7. It does not: bound 7 wants an **in-word**
abort with a frame already open, and this `/S/` is in lane 0 — a word boundary,
not in-word. It has the second half and not the first. I recorded the
non-payment beside the payment in note B-i, because a member that looks as
though it closes a bound and does not is exactly how a bound gets quietly
dropped, and this programme has an instrument (`WO-0058` §9) whose value is that
its bounds stay countable.

The arithmetic also produced a gift I did not expect and used: **both members
take the same 68-octet array and yield the same 64/60/8/`0x0F` expectation**
(member (a): terminate at 84, frame B receives 84 − 20; member (b): terminate at
88, receives 88 − 24). The pair therefore differs by one stimulus parameter and
one observable cycle — a controlled comparison rather than two tests, which is
the strongest form a two-member row can take.

**The B2/N3 conflict: ruled, and the ruling had to be substantive or it was
worthless.** The plan said two things — M03-N3: the idle-in-preamble REQ-105
case is *"carried at M03-B2"*; M03-B2's cell: `/E/` only. The bookkeeping
argument (N3 is the later, ruled text; B2's cell is unrevised batch-A text) gets
to the right answer but would not have justified widening a committed row's
stimulus. The argument that does: **`/E/` cannot discriminate REQ-102's third
sentence at all.** An `/E/` in a preamble position routes to REQ-105 under that
sentence *and* under a design that simply treats preamble positions as frame
positions — same observable, both readings, so the landed members test the
outcome and not the rule. `/I/` separates them, because REQ-113 orders a control
character other than `/S/` **outside** a frame to be ignored, and a preamble
position is **inside** an open frame. A design carrying REQ-113's ignore rule
into the preamble is silent where REQ-102 demands one `error_bad_frame`, and
nothing else in this plan sees it. A distinct kill is what makes it a member
rather than a duplicate.

**Where I refused to widen, and why that is not splitting the difference.**
`injection.mli` accepts `/Q/` at any `At_preamble` position with no lane
restriction. REQ-102's third sentence is extensional and admits it. But a
sequence ordered set is a **four**-character set whose first character is `/Q/`,
and this plan has never derived whether REQ-018's link-partner contract admits
one at an arbitrary preamble position — §3 constrains the lane of `/S/` and of
nothing else. Driving a stimulus whose legality is underived is how a bench
asserts a fact about a space the specification does not constrain, which is
M03-O5's own prohibition one level up. So `/I/` is commissioned and `/Q/` is a
**carried, not driven** sub-member with the derivation named. The conflict is
fully resolved — B2 carries the case — and `/Q/`'s position legality is a
separate question that was never part of it.

**The third obligation on that note exists because the edit is misreadable.**
M03-N3 is NO-STIMULUS and its binding output is a prohibition on M03-I4's
idle-injection **wrapper**. A reader meeting "B2 now drives `/I/` in a preamble
position" could take it as licence to relax that prohibition. It is not: these
members place a *character* through `Injection`'s `At_preamble`; the wrapper
injects an idle *word*. I wrote the distinction into the note rather than trust
it to be obvious.

**B-2 and B-3: made binding forward, recorded backward, and deliberately not
promoted.** Both findings are real and neither convicts a landed row — B-2's
depth is the suite's own standing depth for a following clean frame, and B-3's
provenance gap is closed by the cycle checks that are present. So I bound both
on **new** members (where they cost nothing, because the members are not written
yet) and left them as debts on the landed ones (where paying them means a
stimulus change or an unrunnable assertion). What I did not do is mint either as
a §2 standing obligation. §2 binds *every* M03 bench, and generalising a
two-row observation into a claim about seventy-eight rows I have not re-read for
it is the C-44 failure this plan already records against me twice. Recorded as
owed at the next plan-wide pass, which is the honest altitude.

**Harvest (ADR-0018, PROTOCOL §7).** **Not due this round** — no `SO-`, no gate.
Span since the note at `J-dv_lead-0099`: **J-dv_lead-0100** (this entry);
cumulative untiled span **J-dv_lead-0001 … 0100**, and the first harvest fires at
`SO-M03` and will state that interval so the tiling is visible.

- **0099's candidate is carried unchanged and did NOT ripen.** It concerns a
  partition idiom whose precondition is unstated; this round wrote that
  precondition into an instruction but produced no new incident for it. Nothing
  is added to it.
- **One new candidate banked**, adjacent to it: *"A helper lifted out of its
  first caller inherits that caller's name, so the name describes the situation
  that produced it rather than the obligation it imposes; the parameter the next
  caller must get right is then the one the name is silent about."* **LH1**: the
  input-trace sizing repair (`RV-0057-VERDICT` Finding 1 / `WO-0059` §7.3), and
  the present tree, where one accounting concept carries five names across four
  files. **LH2-g** — no proper noun in the rule. **LH3**: without it, the third
  call site's author reads a name about someone else's situation, re-derives the
  contract from the body, and applies a sizing rule to the wrong quantity.
  **Explicitly not collapsed with 0099's candidate**, though they may prove one
  rule ("a shared definition must carry its own contract") at the harvest —
  collapsing candidates before they are scored is how a harvest loses the
  narrower, more testable one.
- **One item banked as a probable war story, not a candidate**: my
  `RV-0062-VERDICT` §5 inventory counted six copies where the tree has seven,
  because the count came from the sites the review had opened. The rule it
  suggests — *a count taken from the artefacts an investigation happened to open
  is a sample, not a census* — passes LH1/LH2-g/LH3 on its face, but it is close
  enough to this plan's own recorded C-44 pattern that I expect the harvest to
  refuse it as non-novel. Recorded so the harvest gets to make that call rather
  than never seeing it.

### Actions
- Measured the consolidation surface from the tree rather than from the verdict:
  fourteen definitions, their body identity (hashes over whitespace-normalised
  text, then read side by side), forty-seven call sites and passing mentions,
  every preceding comment block by line range, and the `open Bench` fact that
  decides how many call sites move.
- Drafted **`agents/handoffs/WO-0064_bench-machinery-consolidation.md`**: the
  three binding conditions restated verbatim; the home decided with its reason;
  the `_frame`/`_piece` naming axis with the trap it encodes; the measured
  inventory including the correction of my own count; the precondition
  obligations for `split_at_first_tlast` (condition (iii)) and, unasked, for the
  `_piece` pair; the stale-comment repair as a deliverable with its sites
  tabulated and two comments explicitly protected; a ten-item review bar stated
  in runnable commands; ten pre-committed BOUNCE conditions; and the scope
  exclusions (`dune`, `fail`/`fail_cross`, the two `assert_*` helpers) each with
  a derived reason.
- Edited **`test/attack_plans/AP-xgmii_rx_64.md`** §4.B: M03-B4's stimulus,
  observable and kills cells widened to two members; M03-B2's widened to three
  character members with `/Q/` carried and not driven; **notes B-i, B-ii and
  B-iii** added below the table (the two-member arithmetic table and the
  bound-6-paid/bound-7-not-paid record; the ruling with its two grounds and three
  derivation obligations; findings B-2 and B-3 with what they bind); one §9
  change-log row appended.

### Evidence
```sh
git status --porcelain
#  M test/attack_plans/AP-xgmii_rx_64.md
#  ?? agents/handoffs/WO-0064_bench-machinery-consolidation.md
```
Inventory as measured at this tree (the numbers `WO-0064` §3 commissions
against, reproducible from a checkout):
```sh
grep -c . /dev/null; \
grep -n 'let split_at_first_tlast' test/xgmii_rx_64/*.ml   # 7: b:178 d:208 e:149 f:693 g:385 h:164 i:221
grep -n 'let account_dropped_frame' test/xgmii_rx_64/*.ml  # 3: b:190 e:139 f:145
grep -n 'let account_spliced_forwarded\|let account_forwarded_frame' test/xgmii_rx_64/*.ml   # h:210, b:204
grep -n 'let account_spliced_dropped\|let account_resync_runt_frame' test/xgmii_rx_64/*.ml   # h:227, g:408
grep -c 'open Bench' test/xgmii_rx_64/test_m03_*.ml        # 1 in each of the 10 files
```
Body identity, read side by side before it was written into the packet:
`account_dropped_frame` character-identical across b/e/f; `account_forwarded_frame`
(b:204) and `account_spliced_forwarded` (h:210) character-identical apart from
the name; `account_resync_runt_frame` (g:408) and `account_spliced_dropped`
(h:227) likewise; `split_at_first_tlast` identical apart from the parameter name
(`samples` in b/g/h/i, `words` in d/e/f) and one `if`'s line-wrapping; `fail`
character-identical in all **nine** files and `fail_cross` in all **five** —
measured, and excluded from scope anyway (`WO-0064` §4.6).

**No bench file was edited this round** (`test/xgmii_rx_64/**` is untouched — the
consolidation is the worker's, under the packet), and no test was run: this
round produces two documents. `dune runtest` remains unavailable in this
container (ADR-0005); CI is authoritative and `WO-0064` §6 bar 10 states the
landing check the packet's own ACCEPT will rest on.

### Outcome
DoD met for both deliverables. **(1)** `WO-0064` drafted for tb_writer, carrying
`RV-0062-VERDICT` §5's three conditions verbatim, the consolidation's home and
naming decided with reasons, a review bar in commands and ten pre-committed
BOUNCE conditions. **(2)** Both owed plan edits paid in
`test/attack_plans/AP-xgmii_rx_64.md`: M03-B4's lane-4 member added, the
M03-B2 / M03-N3 conflict ruled for widening B2 (with `/Q/` carried, not driven),
and findings B-2/B-3 folded in as note B-iii and made binding on the new
members. **NO ROW ADDED, NO ROW CONVERTED, NO STATUS MOVED, NO COVERAGE-MAP LINE
CHANGED**: 78 rows, 62 ASSERT, 7 NO-ASSERT, 4 NO-STIMULUS, 4 STRUCTURAL, 1 GAP.
**No `SO-xgmii_rx_64.md` issues and none is offered**; nothing here qualifies a
row against mutation. Handoff:
`agents/handoffs/WO-0064_bench-machinery-consolidation.md`, for the orchestrator
to issue to tb_writer.

### Open-questions
1. **`WO-0064` must land alone** (condition (ii)) — no row, no other packet's
   work in its commit, and its own CI `build` run. That is an instruction to the
   orchestrator as much as to the worker.
2. **The `WO-0063` phase-A plan edit (M03-I2's member (iii)) is not in this
   commit** — it rides the commit that opens phase A, per my own disposition.
   Stated here so its absence is not read as an omission.
3. **`WO-0058` bound 7 still has no candidate row.** M03-B4's new member (b) was
   examined for it and does not close it (note B-i).
4. **`/Q/` in a preamble position** is carried and not driven until REQ-018's
   contract is derived for it (note B-ii obligation 1). If the derivation says it
   is outside the constrained space, the sub-member converts to a declared gap,
   not to silence.
5. **B-2 and B-3 on the landed M03-B2/B3 members** remain debts: the first needs
   a round that can run the suite, the second is a stimulus change and rides the
   next family-B bench round. **B-4** (the stale M03-B4 forward reference in
   `test_m03_h.ml`'s module docstring) rides the next round opening that file —
   **not `WO-0064`**, whose scope forbids it.
6. Carried unchanged from `J-dv_lead-0099`: the §0.6-window question open to
   architect_docs_lead; `WO-0061` §8 bound 1's `tkeep` half; family J behind a
   bench-capability round.

### Files-in-this-commit
- agents/handoffs/WO-0064_bench-machinery-consolidation.md
- test/attack_plans/AP-xgmii_rx_64.md

## [J-dv_lead-0101] 2026-08-04T21:30Z | task:WO-0064 | The refactor accepted on a check my own packet did not specify — bar 1 is necessary and provably insufficient, and the one comment my packet ordered protected is the one the packet made false

### Trigger
Orchestrator, RV-0064: review tb_writer's execution of `WO-0064` at `c501425`,
landed alone per condition (ii) with build run 30943522690 and journal-check
run 30943522449 both SUCCESS. My own packet pre-committed ten review bars and
ten BOUNCE conditions; this entry records running them myself rather than
reading them off the Return log.

### Inputs
- `agents/handoffs/WO-0064_bench-machinery-consolidation.md` in full — my own
  §3 inventory table, §4.2 rename list, §4.4/§4.5 docstring obligations, §5
  comment table, §6's ten bars, §7's ten BOUNCE conditions — and the worker's
  Return log at lines 497-763.
- `agents/charters/dv_lead.md`, `agents/PROTOCOL.md` (mandatory first actions).
- `agents/journals/workers/claude_tb_writer_agent.v02.md`, entry
  `J-tb_writer-0022` — Trigger, Inputs, Reasoning, harvest note, Files list.
- `test/xgmii_rx_64/bench.ml`, `bench.mli`, `test_m03_b.ml`, `test_m03_d.ml`,
  `test_m03_e.ml`, `test_m03_f.ml`, `test_m03_g.ml`, `test_m03_h.ml`,
  `test_m03_i.ml` — at `42a81e3` and at `c501425`, read at every site §3 and §5
  name and compared programmatically.
- CI runs 30943522690 and 30943522449 via the Actions API (`head_sha`
  confirmed, conclusions read, not quoted from the Return log).
- **No `libs/**`, no `rtl_snapshots/**`, no `docs/**`, and no spec path.** A
  pure refactor's review needs no re-derivation; citing a REQ id here would
  mean I had done one.

### Reasoning
**The bar I wrote as primary is not the bar that carried the acceptance, and I
want that on the record against my own packet.** §6 bar 1 — the string-literal
multiset — is called "the primary bar" and condition (i) is operationalised
through it. It passed, over twelve files rather than the nine the Return log
checked. But it cannot bear the weight I put on it, for three reasons I
measured rather than suspected. It is a blind line-based regex, so it polices
quoted phrases sitting in **comments** it was never meant to reach — which is
what nearly bit the worker, and what forced several comments to be repaired in
place rather than deleted. It is a **per-file multiset**, so a literal deleted
from code while an identical span survives in a comment, or two literals
swapped between code positions in one file, both pass it. And decisively: this
suite's observable behaviour lives in `[%expect {| … |}]` blocks, whose `{| |}`
delimiters **the `"…"` regex never sees at all**. A bar that cannot see the
expect blocks cannot by itself prove a bench's behaviour is unchanged.

What actually discharged condition (i) was two checks my packet did not
specify: a **comment-stripped code diff** (nested, string-aware strip, then
diff the code alone — yielding exactly 11 added lines across seven files, all
of them the renamed call sites), and a direct byte-comparison of **all 40
`[%expect]` blocks** across the two revisions. Those, plus the green build, are
the evidence. Bar 1 is a useful cheap screen and a bad primary. I am recording
this as a defect in my own review design, discovered by executing it.

**Why the three minority `split_at_first_tlast` copies are not B2.** The
programmatic comparison returned DIFFERS for `d`/`e`/`f`, and a reviewer
reading only that word would bounce. The differences are exactly two: the
parameter name (`words` vs `samples`) and one `if`'s line-wrapping — the two
dimensions §4.3 named in advance and authorised, with the instruction to say so
in the Return log, which the worker did. A parameter name is not observable and
a line-wrap is not semantics. Bouncing here would be renegotiating a bar after
seeing the result.

**The failure this round taught me, and it is mine.** §5 named
`test_m03_b.ml:612`/`:814` as two comments that "remain true after the
consolidation", made editing either BOUNCE B10, and told the worker to confirm
byte-identity instead. The worker did exactly that and proved it. But one
clause of the first comment is **not** true after the consolidation: it
describes the idiom as the one "this file **carries above**", and the packet's
own instruction deleted the copy that sentence refers to. I asserted an
artefact was already correct, exempted it from review, and backed the exemption
with a bounce condition — so the only agent positioned to notice was
instructed not to look, and the check was performed once, by me, from memory,
before the change existed. **The protection is what stopped anyone looking.**
That is a more interesting failure than a miscount, and it generalises.

**Why I repaired rather than bounced.** All ten bars pass and no B1-B10
condition is hit. Two of the three defects I found are mine (the false
exemption; the §4.5 clause that never reached the shared definition); the third
— an orphaned fact comment in `test_m03_e.ml` that no longer points at the
definition it describes — is a shortfall against §5's *rule* but not against
B10's *text*, which reaches stale duplication claims and retired names, neither
of which it contains. My pre-committed discipline is that the verdict is not
renegotiated after the fact, so a defect that no pre-committed condition names
is repairable, not bounceable. All three repairs are comment-only and each is
stated in the verdict.

**On the worker's own judgement calls.** Several comment sites were left
unchanged after inspection rather than edited mechanically to match my table. I
checked each against the post-state and upheld all of them: the Independence-
section mentions are historical records of what a past round read, they name no
retired identifier, and my §5 explicitly says not to extend repairs to passing
mentions beyond a name that no longer exists. The worker read the rule rather
than the table, which is the right order.

### Actions
- Ran all ten §6 bars against `42a81e3`..`c501425` (the packet's HEAD-vs-tree
  form is vacuous once the work has landed), plus two checks the packet does
  not specify: the comment-stripped code diff and the `[%expect]` block
  comparison.
- Verified the four moved bodies byte-for-byte against **every** source copy;
  recounted all definitions and call sites on comment-stripped source; verified
  B4/B6 from the commit's file list and B8 by count and by absence from the
  diff; confirmed both CI runs through the Actions API.
- Read the `bench.mli` docstrings clause by clause against §4.4's four parts
  and §4.5, and diffed the moved `_piece` paragraph against its source at
  `test_m03_h.ml:185-209`.
- Made three reviewed repairs (`test_m03_b.ml`, `test_m03_e.ml`, `bench.mli`),
  then re-ran bar 1, the parse check, the inventory and the records check
  against the repaired tree.
- Appended **RV-0064-VERDICT (ACCEPT)** to the packet.

### Evidence
- CI at `c501425`: build **30943522690** conclusion `success`; journal-check
  **30943522449** conclusion `success`; both `head_sha
  c50142500e7a8233902cf061a7f8bb6737492a9d` (Actions API).
- Bar 1, parent-vs-commit, over all twelve `.ml`/`.mli` files in
  `test/xgmii_rx_64/`: **empty output**. Re-run against my repaired tree:
  **empty output**.
- All **40** `[%expect …]` blocks in the directory: **byte-identical** across
  `42a81e3`..`c501425`.
- Comment-stripped code diff, seven family files: removed 26/10/16/16/16/35/8,
  added 1/0/0/0/1/9/0 — **11 added code lines, all eleven renamed call sites**,
  each identical to its predecessor including its `~strobe:` arguments.
- Definitions: **14** in parent at exactly §3's fourteen line numbers, **4** at
  `c501425`, all in `bench.ml`. Retired-name grep under `test/xgmii_rx_64/`:
  **no match**.
- Call sites on comment-stripped source: `split_at_first_tlast` 30
  (b2 d1 e2 f2 g12 h7 i4); `account_dropped_frame` 6 (b3 e2 f1);
  `account_forwarded_piece` 8 (b1 h7); `account_dropped_piece` 3 (g1 h2) —
  every cell matches §3; renames **11**, matching §4.2.
- Body identity: `account_dropped_frame` IDENTICAL vs all 3 copies;
  `account_forwarded_piece` vs both; `account_dropped_piece` vs both;
  `split_at_first_tlast` vs all 4 majority copies, with `d`/`e`/`f` differing
  only in parameter name and one `if`'s wrapping (§4.3-authorised).
- B8: `fail` 9→9, `fail_cross` 5→5, `assert_following_frame_intact` 1→1,
  `assert_clean_frame_structure` 1→1, none in any hunk.
- `ocamlc -stop-after parsing` exit 0 on all nine files, and again on the three
  I repaired. `bash tools/dv_checks.sh` → `39 test/xgmii_rx_64/` before and
  after my repairs. `bash tools/check_records_vs_appendix.sh` → `23 check(s)
  run, 0 failure(s)` before and after.
- Comment-stripped code diff of my own three repaired files against `c501425`:
  **0 code-line differences** in each — the repairs are comment-only.
- `git show c501425 --name-only`: exactly the nine files plus the packet and
  the worker journal (B4/B6).

**Harvest (ADR-0018, PROTOCOL §7).** **Not due this round** — no `SO-`, no
gate. Span since the note at `J-dv_lead-0100`: **J-dv_lead-0101** (this entry);
cumulative untiled span **J-dv_lead-0001 … 0101**, with the first harvest still
firing at `SO-M03` and stating that interval so the tiling is visible.

- **Both banked candidates carry unchanged.** `J-dv_lead-0099`'s (a partition
  idiom whose precondition is unstated) and `J-dv_lead-0100`'s (a helper
  inheriting its first caller's name, so the name describes the situation
  rather than the obligation) — this round wrote **both** contracts into a
  shared definition's docstring, which is their remedy, not a new incident for
  them. Nothing is added to either, and they stay uncollapsed.
- **The probable war story carries unchanged**: my `RV-0062-VERDICT` §5
  six-versus-seven miscount. This round confirmed the corrected count of 7 from
  the tree, which is its closure, not new evidence.
- **The worker's LH2-g candidate at `J-tb_writer-0022` — premise CONFIRMED,
  and I can strengthen it.** Its claim is that a blind text-pattern equivalence
  check cannot distinguish payload from prose, so it both fails spuriously on
  prose edits and passes spuriously on payload edits. My review is a second,
  independent incident for it, from the reviewer's side rather than the
  executor's: I designed that check, called it "the primary bar", and it is
  provably insufficient in three distinct ways — it polices comment-resident
  quoted spans; it is a per-file multiset blind to a literal moving between
  code and comment or swapping code positions; and it cannot see `{| |}`
  delimited blocks at all, which is where this artefact's entire observable
  behaviour lives. The candidate's own observable ("enumerate every match the
  check would report and confirm each sits where its author intended") is
  right, and I would add a second clause to it at the harvest: *also enumerate
  what the check's pattern cannot match, because a check's blind spot is not
  visible in its output*. Recorded for the harvest to score, not merged into
  the worker's statement by me.
- **One new candidate banked, LH2-g.** *Rule*: an instruction that exempts an
  artefact from review by asserting it is already correct transfers the check
  from the executor to the author, where it is performed once, from memory, and
  before the change exists — so the exempted artefact is where staleness
  accumulates, because the exemption is what stops anyone looking. *Observable*:
  every exemption clause in a work instruction either carries the evidence for
  its own claim or is rewritten as an instruction to verify; an exemption backed
  by a penalty for touching the artefact is the strongest form of the defect.
  **LH1**: this round — §5 asserted two comments "remain true after the
  consolidation" and made editing either a bounce condition; the very change the
  packet ordered falsified one clause of one of them, and the executor,
  correctly obeying, preserved the falsehood and proved byte-identity.
  **LH2-g** — no proper noun in the rule. **LH3**: without it, the artefacts a
  reviewer is most confident about become the only ones no one re-reads, and
  the confidence is what causes it. **Domain pack**: n/a (general).

### Outcome
`WO-0064` **ACCEPTED**, verdict appended to the packet as `RV-0064-VERDICT`
with the ten bars' results, the comment-site adjudications and the three
reviewed repairs each stated. DoD met in full: fourteen definitions to four;
bar 1 clean; condition (iii)'s four-part precondition and §4.5's `~received`
precondition both at the definition; eleven renames and thirty-six unchanged
call sites; every stale comment repaired or deleted; parse clean; inventory 39;
nothing outside §2.1 staged. The `RV-0062-VERDICT` §5 consolidation debt is
closed.

Handoff: this tree (packet + three comment-only repairs) to the orchestrator
for commit. **`WO-0063` phase A opens next** — the member (iii) plan edit rides
phase A's opening commit; the `BUG-0003` §V.2 probe rides phase A; my five owed
notes' citation sites ride the next family-I bench round.

### Open-questions
1. **My own bar 1 is mis-specified as primary** and should not be reused in
   that role. Any future packet whose success criterion is behavioural
   equivalence needs the comment-stripped code diff and the expect-block
   comparison named as its bars, with the literal multiset demoted to a cheap
   screen. Owed at the next packet I write with an equivalence criterion.
2. **The exemption-clause failure above** is not yet a rule I have applied
   anywhere; it is banked as a candidate only. Until the harvest scores it, I
   should treat every "this stays exactly as it is" clause I write as owing its
   own evidence.
3. Carried unchanged: `WO-0058` bound 7 (in-word REQ-110 abort with a frame
   already open on entry) still has no candidate row; the
   `assert_following_frame_intact` / `assert_clean_frame_structure` merge stays
   deliberately uncommissioned as a redesign, not a refactor; the §0.6-window
   question remains open to architect_docs_lead; `WO-0061` §8 bound 1's `tkeep`
   half; family J behind a bench-capability round.

### Files-in-this-commit
- agents/handoffs/WO-0064_bench-machinery-consolidation.md
- test/xgmii_rx_64/bench.mli
- test/xgmii_rx_64/test_m03_b.ml
- test/xgmii_rx_64/test_m03_e.ml

## [J-dv_lead-0102] 2026-08-04T23:05Z | task:WO-0063 | Phase A opened plan-first, and writing the plan before the bench killed one of my own claims before a bench could inherit it — the standing strobe monitor is not blind to a deferred report, it is not independent of the bench that hands it the pin

### Trigger
Orchestrator dispatch, `WO-0063` **phase A** — my own commission, standing since
`J-dv_lead-0098` and re-confirmed in the `RV-0064` round's forward statement
(`J-dv_lead-0101` Outcome). Phase A's own law, from §2.1 of that packet and
charter §3: **the attack plan moves before the bench does**. This round is the
opening commit's content — the plan edit, the worker's execution packet, and the
`BUG-0003` §V.2 probe specification — and deliberately **no bench edit**.

### Inputs
- `agents/handoffs/WO-0063_m03-i2-report-path-delay-mini-round.md` in full (my
  own draft: §1's two structural reasons, §2.1–2.4, §3's two intents, §4's
  reachability discharge, §5's instrument fact, §7's dispositions, §8's
  scheduling).
- `agents/charters/dv_lead.md`; `agents/PROTOCOL.md` (§3, §4, §6, §7, §10 —
  mandatory first actions).
- `test/attack_plans/AP-xgmii_rx_64.md` — §4.I row M03-I2 and its two committed
  members, §4.F/§4.H context rows, §8's open-question blocks, §9's change log.
- `agents/handoffs/WO-0060_tb-m03-family-i-dm-rebase.md` §3.6, §3.7 and
  `RV-0060-VERDICT` §10 item 3 (the three citation sites and the closed-list
  finding against my own enumeration).
- `agents/handoffs/BUG-0003_m03-lane-4-injected-word-cycle.md` §V.2 and §V.9 —
  the probe's own specification and the three deferral grounds.
- `agents/handoffs/WO-0061_family-i-mutation-campaign.md` §§4–5 (the shadowing
  note and its deferral), `agents/handoffs/WO-0064_bench-machinery-consolidation.md`
  "What this unlocks" (my scheduling), `agents/journals/claude_dv_lead_agent.v03.md`
  entries `J-dv_lead-0094`, `0098`, `0101`.
- **`test/**` read, and only `test/**`**: `test/xgmii_rx_64/test_m03_i.ml`
  (`run_i2_member`, `run_i2`, the module docstring, the five owed bench notes,
  the three citation sites), `test/xgmii_rx_64/test_m03_f.ml` (`run_f2`),
  `test/xgmii_rx_64/bench.ml` / `bench.mli` (`assert_monitors_clean`,
  `one_frame`, `directed_frame_octets`), `test/xgmii/injection.mli`,
  **`test/monitors/strobe_monitor.mli` AND `strobe_monitor.ml`** — the `.ml`
  deliberately, and §Reasoning records why.
- **No `libs/**`, no `rtl_snapshots/**`, no `docs/reports/audit/**`.**
  `BUG-0002` was not opened (it carries RTL source); `BUG-0003` was, and it is
  mine.

### Reasoning
**Why a member and not a row, restated where the auditor reads it.** `WO-0061`
§12 — my own footnote — asked for a *row*. A new row would carry a **copy** of
M03-I2's silent-tail scan, and qualifying a copy qualifies nothing about M03-I2:
the instrument under test has to be the committed one. The correction was already
in the packet; what this round does is put it on the **plan's** record, because
the plan is what the auditor mines for rejected attacks and superseded
dispositions, not the packets.

**Why the row needed a strobe-owing member at all, and both halves of the
answer are structural rather than about intent strength.** `run_i2_member`
asserts each output word's cycle **before** it scans the silent tail, so a drain
defect emitting one cycle late always raises at the per-word guard and never at
the window — the `tvalid` half is permanently shadowed at every member and every
lane. And the strobe half, the only unshadowed axis, has never had a stimulus:
both committed members are clean frames that owe no strobe. Member (iii) is
M03-F2's `k` = 0 frame, so the row's own declared kill becomes reachable with **no
new machinery**.

**The trap is the reason the plan edit had to be mine and not the worker's.**
`run_i2_member` takes its boundary from `Arrival.terminate_octet_time`, which for
this stimulus is the **auto-placed** terminate at cycle 10, not the injected
closing character at cycle 2. A member inheriting that field asserts silence from
cycle 13 while the whole event lives at cycles 2–5 — green against anything,
forever, with no symptom. That is a derivation fact about the row, so it belongs
in the `Observable` cell, and I converted it into an executable guard in the
worker packet rather than leaving it as a warning.

**The correction that decided the round, and it is against myself.** §5 of my own
packet says a report deferred to `W + 3` sits inside §0.6's window and outside
C-14.3's bound, and concludes the standing `Strobe_monitor` *"cannot see IC-1 at
any unit at all"*. I had derived that from the monitor's **interface prose**,
which describes the §0.6 window check because that is the check the module was
built to explain. Writing the worker's assertion order forced me to answer a
different question — *how does this member keep the monitor clean while driving a
strobe?* — and that sent me to `strobe_monitor.ml`'s matching, which pairs
expected events to observed high cycles **exactly on `(strobe, cycle)`**. A pulse
moved by one cycle is therefore simultaneously a `missing` event and an
`unexpected` pulse, `is_clean` is false, and `assert_monitors_clean` fails at
**every** unit registering a no-output-word expectation. §5 is wrong; the
predicted convicting set for phase B is **wider** than it said. What survives is
sharper: the monitor detects the class only by re-checking a pin **this bench
computed and handed it**, so it is **not independent**, and no assertion anywhere
in this bench reads a report against **C-14.3** except M03-I2's own window.

**This is exactly what the plan-before-bench ordering is for, and it is the first
round in which it visibly paid.** The false sentence would otherwise have been
copied into a bench comment, into the phase-B seal's denominator, and into a
verdict — and a seal that under-predicts its own convicting set scores a campaign
in the direction that flatters its author. It cost nothing to find because no
bench existed yet to disagree with.

**A second correction fell out of the same reading, and I fixed my sentence
rather than let a worker discover the collision.** §2.3 says member (iii) *"does
not assert §9's pin"*. Taken literally that is unimplementable: there is no
unpinned form of `Strobe_monitor.expect`, and a unit that drives a strobe and
registers nothing fails `assert_monitors_clean` **on a conformant design**. Ruled:
register the event exactly as `run_f2` does, and scope the prohibition to **the
member's own assertions** — no comparison of an observed pulse cycle to 4, no
message of its own naming it. The registration is a standing obligation-4
artefact, evaluated **last**, so it cannot be *"an earlier assertion in that
unit"* under §7 disposition 4 and cannot shadow the window. §7's dispositions do
not move; only the reading of "asserts the pin" is sharpened.

**Why the worker's packet is a separate file rather than a section of `WO-0063`.**
§0 of that packet makes blinding a property of the **reader**, and it names IC-1
and IC-2 in §3. Appending worker-facing instructions to it would break its own
law in the commit that states it, and "the orchestrator excerpts §9" is a
protection rather than a check — precisely the shape `J-dv_lead-0101` banked as a
candidate. So `WO-0063A` is self-contained, and `WO-0063` §9 carries the exposure
ledger instead of assuming one. The ledger is honest about what leaks: the AP
row's `Kills` cell now names the class, unavoidably, and §2.4 already priced that
discount; what stays back is the **rendering** — §3.1's scoped-versus-shared axis
is what the seal branches on, and the class alone does not determine it.

**Applying `J-dv_lead-0101`'s own lesson to the packet I just wrote.** Every
claim `WO-0063A` makes about existing code — the eight derived numbers, the
quoted `run_i2_member` lines, the three citation sites — is written as a claim to
**verify and report**, never as an exemption. §7 says so in terms, and §9's BO-1
bounces a guard edited to match code after a disagreement. The citation-site
enumeration is explicitly **not** claimed closed, because claiming a closed list
is exactly how those three sites survived two rounds (`RV-0060-VERDICT` §10 item
3 is a finding against my own `WO-0060` §3.6).

**On the `BUG-0003` probe's scheduling.** §V.9 deferred it on three grounds; two
expired (phase A opens a bench file; no seal is frozen while it does) and the
third — one round, one base SHA — is **honoured, not waived**, by keeping the
probe out of phase B. Its harvest is reported in its own block against no campaign
denominator, and the severity line stays **MAJOR** until the two numbers return.
I fixed the decision rule before the run so no result can be re-read afterwards,
including the branch that says my correspondent's derivation is wrong.

### Actions
- Amended `AP-xgmii_rx_64.md` §4.I row **M03-I2** in four cells — Attacks
  (member (iii)'s §9/§0.6 context, marked *not asserted*), Stimulus (the
  EXTENDED banner, the member/row correction, member (iii)'s construction),
  Observable (the eight-number derivation at both lanes, the boundary trap, the
  assertion order, the §9-pin exclusion), Kills (the two structural reasons the
  window has been silent, the class member (iii) reaches, the corrected
  monitor-reach paragraph, the stated discount).
- Added **§8 item 6** — the §0.6-versus-C-14.3 open question to
  architect_docs_lead, carrying the corrected monitor statement.
- Added the **§9 change-log row** for `J-dv_lead-0102`, with counts re-derived
  from the file.
- Appended **§9 and §10 to `WO-0063`**: the phase-A dispatch record and exposure
  ledger; three forward corrections (§5's monitor claim, §2.3's pin prohibition,
  §12's row-versus-member footnote); and the finalized `BUG-0003` §V.2 probe
  specification for the orchestrator.
- Wrote **`agents/handoffs/WO-0063A_m03-i2-member-iii-bench.md`** — the phase-A
  execution packet for tb_writer: the artefact, the stimulus, the eight numbers
  as a derivation to check, the trap and its executable guard, the nine-step
  assertion order, the strobe-monitor ruling, the three citation sites, the
  out-of-scope list with its no-exemption clause, ten review bars and ten BOUNCE
  conditions.
- **No bench file edited. No git command run.**

### Evidence
All commands runnable from a checkout at this commit.

- Row and status counts, re-derived from the amended file rather than carried
  forward:
  `awk 'NR>=126 && NR<=720' test/attack_plans/AP-xgmii_rx_64.md | grep -c '^| \*\*M03-'`
  → **78**; the same selection piped through
  `awk -F'|' '{print $(NF-1)}' | sort | uniq -c` →
  **62 ASSERT, 7 NO-ASSERT, 4 NO-STIMULUS, 4 STRUCTURAL, 1 GAP**. Unchanged from
  `J-dv_lead-0100`.
- Table integrity after the edit: the same selection through
  `awk -F'|' '{print NF}' | sort | uniq -c` → **78 rows, all with 8 fields**
  (6 columns), so no cell boundary was broken by the four amended cells.
- The derivation, cross-checked against the committed bench that already drives
  this stimulus — `test/xgmii_rx_64/test_m03_f.ml:404-410`:
  `closing_ot = start_ot + 8 + k`; `closing_cycle = closing_ot / 8`;
  `expected_pulse_cycle = closing_cycle + 2`; `expected_not_before =
  closing_cycle`; `expected_not_after = if k = 0 then closing_cycle + 3 else …`.
  At `k` = 0 and `start_ot` ∈ {8, 12} that is **W = 2, pin = 4, window [2, 5]**,
  and C-14.3's `W + 3` = **5**, at both lanes — the numbers landed in the plan.
- The trap, from the committed source: `test/xgmii_rx_64/test_m03_i.ml:398-402`
  computes `terminate_ot = Arrival.terminate_octet_time frame`,
  `terminate_cycle = terminate_ot / 8`, `boundary = terminate_cycle + 3`. For
  member (iii)'s stimulus the declared terminate is the auto-placed one at octet
  time 80 → cycle 10 → boundary **13**, against the true boundary **5**.
- **The §5 correction, read from the implementation and not from the prose**:
  `test/monitors/strobe_monitor.ml`'s `match_up` pairs an expected event to an
  observed pair only when `s = e.strobe && c = e.cycle` — an **exact** match on
  name and cycle; unmatched expectations become `missing`, unmatched observations
  become `unexpected`, and `errors`/`is_clean` fold both. A pulse moved from
  `W + 2` to `W + 3` therefore produces **both** error classes.
  `test/xgmii_rx_64/bench.ml:344`'s `assert_monitors_clean` fails on
  `not (Strobe_monitor.is_clean …)`.
- The three citation sites, located **by content**:
  `grep -rn 'RV-0059-VERDICT §8' test/` → `test_m03_i.ml:938`, `:1394`, `:1501`;
  the fourth, `:41–42`, is **line-wrapped** across the `(RV-0059-VERDICT` /
  `§8,` boundary and is invisible to a line-based grep — which is why the
  worker packet instructs locating by content and forbids treating the
  enumeration as closed. `:938` is already in `WO-0060` §3.6's repaired form
  (authority `1f3c04c`, §8 kept as history) and is marked do-not-edit.
- The five `Owed bench note` blocks are present at
  `test_m03_i.ml:276, 316, 409, 451, 496, 665, 702, 1091, 1103, 1567, 1631,
  1640, 1682` (`grep -n 'Owed bench note' …`), i.e. landed at `WO-0062`'s round;
  their remaining citation sites are the item `WO-0064` deferred and are named
  in `WO-0063` §9.6 as **not** riding this round.
- `git status --porcelain` at this tree: exactly the three files listed below
  (two modified, one added). **No RTL path, no `docs/**` path, nothing outside
  my write scope (PROTOCOL §6).**
- **Not run, and stated rather than implied**: `dune build` / `dune runtest`.
  The local toolchain is unavailable (**ADR-0005**) and **CI is authoritative**;
  this commit stages no compiled artefact — two Markdown edits and one new
  Markdown packet — so there is no build claim to make. The first build claim of
  this round belongs to phase A's bench commit.

**Harvest (ADR-0018, PROTOCOL §7).** **Not due this round** — no `SO-`, no gate.
Span since the note at `J-dv_lead-0101`: **J-dv_lead-0102** (this entry);
cumulative untiled span **J-dv_lead-0001 … 0102**, with the first harvest still
firing at `SO-M03` and stating that interval so the tiling stays visible.

- **All three banked candidates carry unchanged**: `J-dv_lead-0099`'s (a
  partition idiom whose precondition is unstated), `J-dv_lead-0100`'s (a helper
  inheriting its first caller's name, so the name describes the situation rather
  than the obligation — **applied** this round as a naming bar in `WO-0063A` §1,
  which is its use, not a new incident), and `J-dv_lead-0101`'s (an instruction
  that exempts an artefact from review by asserting it correct — **applied** this
  round as `WO-0063A` §7's no-exemption clause and BO-1). Application is not
  evidence; none of the three gains an incident and none collapses.
- **The probable war story carries unchanged**: my `RV-0062-VERDICT` §5
  six-versus-seven miscount.
- **The worker's LH2-g candidate at `J-tb_writer-0022`** (a blind text-pattern
  equivalence check cannot distinguish payload from prose) carries with my
  `J-dv_lead-0101` strengthening clause, unchanged.
- **One NEW candidate banked, LH2-g, and its adjacency is declared rather than
  hidden.** *Rule*: a negative claim about an instrument — *"it cannot detect
  X"* — must be derived from the instrument's **matching rule**, never from its
  documentation or its stated purpose; an instrument normally implements several
  independent checks and its prose describes the one it was built to explain, so
  a blindness claim read off the prose is a claim about one check presented as a
  claim about the instrument. *Observable*: every "cannot detect" sentence in a
  packet or verdict cites, by location, the comparison whose failure the claim
  depends on. **LH1**: this round — I wrote that a standing monitor could not see
  a one-cycle deferral, having read the window check its interface documents;
  its matching implementation compares name and cycle exactly, so it detects the
  deferral at every registering unit, and the packet's predicted convicting set
  was too narrow. **LH2-g** — no proper noun in the rule. **LH3**: without it, a
  campaign under-predicts its own convicting set, and an under-predicting seal
  scores a result in the direction that flatters its author. **Domain pack**: n/a
  (general). **Adjacency**: this overlaps my `J-dv_lead-0101` strengthening
  clause (*enumerate what a check's pattern cannot match, because a blind spot is
  not visible in its output*); the two may be one rule about **evidence for
  negative coverage claims**, and **the harvest decides whether to merge them** —
  I am not merging them myself, and I am not banking the overlap twice as if it
  were two incidents.

### Outcome
`WO-0063` **phase A opened**, DoD met for the opening commit as the packet
defines it (§2.1: plan edit before bench, dv_lead's and not the worker's).
Delivered: the M03-I2 member (iii) plan edit in four cells plus §8 item 6 plus
the §9 change-log row, counts re-derived and unchanged; the phase-A execution
packet `WO-0063A` for tb_writer with ten bars and ten BOUNCE conditions; and
`WO-0063` §§9–10 carrying the dispatch record, the exposure ledger, three forward
corrections against my own text, and the finalized `BUG-0003` §V.2 probe
specification.

**Handoff**: this tree to the orchestrator for commit (three files, trailer
`Agent: dv_lead`, `Work-Order: WO-0063`). Then, in either order or in parallel
(`WO-0063` §10.4): **tb_writer spawned on `WO-0063A`** — with **`WO-0063` itself
withheld from that spawn** — and the **orchestrator operating the `BUG-0003`
§V.2 transient** at `fafb83d`. Phase B does not open until phase A's bench has
landed and its seal has been frozen in the commit that issues the campaign
packet.

### Open-questions
1. **`WO-0063` §5's convicting-set figure is now known to be too narrow** (§9.3).
   The phase-B seal must be frozen against the corrected reach — every unit
   registering a no-output-word expectation reddens under IC-1 through
   `assert_monitors_clean` — and the seal is owed **in the commit that issues the
   phase-B packet**, before any diff exists (R-SEAL-1; §6's forward commitment is
   a promise, and an unredeemed promise is adjudicated as no seal at all).
2. **New, to architect_docs_lead** (AP §8 item 6): is §0.6's `[W, W + 3]` window
   normative for M03's no-output-word reports alongside §9's exact pin, and is a
   report at `W + 3` therefore conformant under §0.6 and non-conformant under
   C-14.3? No row moves on the answer.
3. **`BUG-0003` stays MAJOR** until the §V.2 probe's two numbers return. If they
   come back conformant, §9.2's derivation of the pre-fix design did not
   reproduce, and that result is owed a disposition in the packet just as loudly
   as a conversion would be.
4. Carried unchanged: `WO-0058` bound 7 (an in-word REQ-110 abort with a frame
   already open on entry) still has no candidate row; the
   `assert_following_frame_intact` / `assert_clean_frame_structure` merge stays
   deliberately uncommissioned as a redesign, not a refactor; `WO-0061` §8 bound
   1's `tkeep` half at an injected run stays unmeasured; `WO-0064`'s five owed
   notes' remaining citation sites ride a later round, by that packet's own
   scheduling; family J behind a bench-capability round; `SO-xgmii_rx_64.md`
   remains unopened and is not offered.
5. **My own bar 1 mis-specification** (`J-dv_lead-0101` open question 1) is not
   yet discharged, and this packet did not need it — `WO-0063A` has no
   behavioural-equivalence criterion. It falls due at the next packet that does.

### Files-in-this-commit
- agents/handoffs/WO-0063A_m03-i2-member-iii-bench.md
- agents/handoffs/WO-0063_m03-i2-report-path-delay-mini-round.md
- test/attack_plans/AP-xgmii_rx_64.md

## [J-dv_lead-0103] 2026-08-04T23:55Z | task:none | BUG-0003 converts to CRITICAL on measurement and closes — and the designer's derivation was exactly right, which updates my estimate of the designer and not the rule that refused to record a severity on it

### Trigger
Orchestrator return of the `BUG-0003` §V.2 severity probe I authored last round
(`WO-0063` §10): CI run **30947784963**, transient tree
**`5c475821d1013cf940cfa21ff403283be2ec30aa`** cut from `fafb83d`. Adjudication
is mine by §V.2's own allocation — *"dv_lead's to adjudicate, orchestrator's to
operate"* — and by `WO-0063` §10.2's pre-committed decision rule.

### Inputs
- `agents/handoffs/BUG-0003_m03-lane-4-injected-word-cycle.md` — §5 (the MAJOR
  argument and its stated conversion condition), §9.1 / §9.2 (rtl_lead's
  mechanism and its derived figures), §V.1, §V.2, §V.3, §V.6, §V.7, §V.8, §V.9.
- `agents/handoffs/WO-0063_m03-i2-report-path-delay-mini-round.md` §10 — my own
  probe specification and §10.2's decision rule.
- The captured probe stdout for run 30947784963 (scratchpad copy; **ephemeral**,
  see Evidence) and the run's own metadata as relayed.
- `agents/PROTOCOL.md` §3, §4, §10; `agents/charters/dv_lead.md` §3, §8.
- **Deliberately NOT read**: `test/xgmii_rx_64/test_m03_i.ml` and the tb_writer
  worker journal. Both carry `WO-0063A`'s in-flight member (iii) work; reading a
  worker's bench mid-edit would contaminate the review I owe it at `RV-0063A`,
  and nothing this round needs it. Where §V.10.5 states a fact about that file,
  it is cited from the **committed** tree at `J-dv_lead-0102`, not re-checked
  against a working tree mid-edit.
- **No `libs/**`, no `rtl_snapshots/**`.**

### Reasoning
**I recomputed rather than transcribed, and that was not ceremony.** The whole
reason this round exists is that §V.2 refused to write a severity on a number it
had not seen produced. Accepting the orchestrator's transcription — or the
probe's own summary lines — would have reinstated exactly the defect at one
remove. So both figures come from the eight per-word lines alone, and the
60-octet reference sequence was **regenerated from the stimulus generator's
arithmetic** (`((length × 3) + 5j + 7) mod 256`) rather than read off the log, so
the comparison takes no input from the probe's summary. (a) = **7**, (b) = **4 of
60**. Both agree with what was printed.

**Both limbs of §10.2's rule fire independently** — (a) ≥ 1 and (b) < 60 — so the
conversion is not a judgement call and I made none. §5's own sentence was *"dv_lead
will convert it without argument if either appears"*. Both appeared. I am not
arguing.

**Three facts the summary did not foreground, which I put in the packet because
they change what the severity means.** (1) 28 of the 60 required octets are not
merely wrong but **absent** — the delivered stream is 32 octets against a required
60 — so (b) = 4 computed over 32 comparable positions *understates* the loss, and
a reader taking "4 of 60" as "56 wrong values" would have the wrong picture. (2)
`tuser` = 0 on the `tlast` word: the corrupted frame was marked **FCS-good**. I
scoped that claim explicitly, because the probe samples the `rx` stream and not
the strobes, and a severity block is exactly where an unscoped claim does damage.
(3) `tlast` is on word 7, not word 0 — **BUG-0002's class is absent at this
cell**, which separates two defects that were live at the same SHA.

**The part I most want on the record is the part that cuts against me.** Both of
rtl_lead's derived numbers were exactly right, and so was the substituted byte
value; taken with §9.1's earlier, correct prediction of the post-fix cycles, the
same structural account has now predicted this design on both sides of its fix.
That is a strong result and I recorded it as one, in the packet, generously.
**And it validates nothing about the rule §V.2 applied.** §V.2 never said the
derivation was wrong; it said DV may not record a severity on evidence the packet
itself labels derived, produced from a file DV does not read. That is a rule about
a **class of evidence**. Had I converted on §9.2 and been vindicated, I would have
been right by the luck of a careful correspondent, and neither the next
correspondent nor the next derivation from this one inherits that luck. What
updates is my estimate of rtl_lead's derivations — upward, materially. The
standard does not move, and I wrote the price of it into the packet next to the
outcome (**one round and one CI run**) precisely so a later reader cannot read
"the derivation turned out right" as "the check was waste".

**Why the header fields are edited when nothing else in the packet ever is.** This
packet's own convention, set at §V.9, is that a verdict of record is corrected
forward and never amended in place, and I kept it: §5's argument, §9.2's figures,
§V.1's table and §V.2's refusal are untouched. But `State` and `severity` are
**live fields**, they are the first two lines any reader of a verbatim-relay
packet meets, and leaving `MAJOR` there while the body says CRITICAL would make
the packet contradict itself at its most-read point — a defect in the relay, not a
preserved record. So both are updated, each carrying its own superseded value
inline and a pointer to §V.10.

**Why the packet closes, and what I refused to close over.** §V.9 enumerated the
open set as exactly one item and this discharges it, so the state moves to `FIX
ACCEPTED — CLOSED`. But a closed packet cannot carry anything, and two items were
travelling on this one: **N-1**, which §V.7 had riding here, is explicitly
re-homed to whichever packet next opens REQ-016's reach; and §V.3's owed bench
notes plus `RV-0060-VERDICT` §10 item 3's citation sites are recorded as paid
early (the notes, at `WO-0062`'s round) and commissioned (`WO-0063A` §6). Closing
without naming a new carrier is how a carried item evaporates, and this programme
has already paid for that once with §7 item 5.

### Actions
- Recomputed (a) and (b) independently from the probe's per-word lines, with the
  reference sequence regenerated from the generator's arithmetic; verified the
  two printed blocks byte-identical after stripping CI timestamps.
- Appended **§V.10** to `BUG-0003` — evidence and its admissibility (including
  the orchestrator's one disclosed workflow-step reordering, adjudicated as not
  touching admissibility *because* it was disclosed); the recomputed figures with
  the per-word table transcribed into the packet; §10.2's rule applied; the
  severity conversion over my signature with the measured figures replacing
  §9.2's derived ones; the derivation-reproduced finding; and packet state.
- Updated the two **header** fields (`State`, `severity`) clerically, each
  preserving its superseded value and pointing at §V.10.
- Routed the conversion to the auditor for the **DV-escape ledger**, which the
  auditor owns and DV never edits.
- **No bench file opened. No git command run.**

### Evidence
- **CI run `30947784963`** (`build`), branch `mut/bug3-sev-probe`, transient tree
  SHA **`5c475821d1013cf940cfa21ff403283be2ec30aa`**, conclusion **`failure`** —
  expected, and the premise: the pre-fix suite is red at that SHA. The probe step
  itself completed and printed. Externally verifiable via the Actions API at that
  run id; this is the admissibility class §V.2 demanded and §V.9 item 2 honoured.
- **Recomputation, from the eight per-word lines only.** Words at cycles
  `4, 6, 8, 10, 12, 14, 16, 18`; `tkeep` = `0x0F` at all eight; `tlast` on word 7
  only; `tuser` = 0 throughout. **(a)** = count of words with `tkeep` ≠ 0xFF and
  `tlast` = 0 = **7**. **(b)**: reference regenerated as
  `((64 × 3) + 5j + 7) mod 256` for j ∈ [0, 60), giving `C7 CC D1 D6 DB …` and
  ending `EE`; observed = concatenated kept octets = 32 long; positional matches
  = **4** (indices 0–3). Absent positions = **28**; `0x07` occurrences in the
  observed stream = **28**.
- **Determinism**: the probe printed twice via its two documented aliases; the
  two 34-line blocks are **byte-identical** after stripping the CI timestamp
  prefix.
- **Ephemeral-artifact declaration (ADR-0003 / F5)**: the captured stdout I read
  lives in a scratchpad file outside the repo and **will not exist later**, and
  the transient tree is gone by construction. The durable records are (i) CI run
  `30947784963`'s own log and (ii) **§V.10.2's per-word table inside the packet**,
  which transcribes the eight lines the figures are computed from — deliberately,
  so the datum survives in history even though the tree that produced it does not.
- **Not run**: `dune build` / `dune runtest` locally. No local toolchain
  (**ADR-0005**); this commit stages one Markdown file.

**Harvest (ADR-0018, PROTOCOL §7).** **Not due this round** — no `SO-`, no gate.
Span since the note at `J-dv_lead-0102`: **J-dv_lead-0103** (this entry);
cumulative untiled span **J-dv_lead-0001 … 0103**, first harvest still firing at
`SO-M03` and stating that interval so the tiling stays visible.

- **All four banked candidates carry unchanged**: `J-dv_lead-0099`'s (unstated
  partition precondition), `J-dv_lead-0100`'s (helper named for its situation
  rather than its obligation), `J-dv_lead-0101`'s (exemption-by-assertion), and
  `J-dv_lead-0102`'s (a blindness claim derived from an instrument's
  documentation rather than from its matching rule). None gains an incident this
  round; none collapses.
- **The worker's LH2-g candidate at `J-tb_writer-0022`** carries with my
  `J-dv_lead-0101` strengthening clause, unchanged.
- **The probable war story carries unchanged** (`RV-0062-VERDICT` §5's
  six-versus-seven miscount), and **one is added**: authoring the probe, I
  reproduced a committed helper's arithmetic into a different stdlib dialect and
  silently changed its meaning — `land` binds at the `*` level, so dropping one
  pair of parentheses masked a constant instead of the sum, and the reference
  sequence would have been wrong from index 12 onward with no local compiler to
  catch it. Caught by inspection before the run. It fails LH2 as a rule (the
  portable content is "parenthesise mixed bitwise and arithmetic operators",
  which is not a process rule), so it is a war story and goes no further —
  though the design choice it argues for is real and may merge into the
  `J-dv_lead-0102` candidate at harvest: the probe printed the **reference beside
  the observation** rather than only their comparison, and a broken reference is
  invisible in a comparison and obvious beside the data.
- **One NEW candidate banked, LH2-g.** *Rule*: when a precaution that refused to
  accept a number is later vindicated because the number was right, the write-up
  must record **both** the confirmation and the price the precaution cost —
  because a reader who sees only the confirmation concludes the precaution was
  unnecessary, and precautions are abandoned exactly by that inference.
  *Observable*: every "we checked and it was fine" disposition states what the
  check cost, and states explicitly whether the rule it enforced is about a class
  of evidence (in which case one correct instance is not evidence about the rule)
  or about that instance alone. **LH1**: this round — a refusal to record a
  severity on a derivation was discharged by a measurement that reproduced the
  derivation exactly, including a predicted byte value; the natural summary
  ("the derivation was right") is precisely the sentence that would retire the
  refusal. **LH2-g** — no proper noun in the rule. **LH3**: without it, a
  discipline is eroded by its own successes and is dropped in the round before
  the one where it would first have caught something. **Domain pack**: n/a
  (general).

### Outcome
`BUG-0003` **CLOSED** at severity **CRITICAL**, converted on measurement, with
§10.2's pre-committed rule applied unchanged and both limbs fired. §V.2 — the
packet's last open item since `J-dv_lead-0096` — is **discharged on evidence that
is externally re-executable**, which is the standard it set for itself. The
measured figures **(a) = 7, (b) = 4 of 60 at `5c47582`** replace §9.2's derived
ones as the citable magnitude of this defect. Two carried items are re-homed
rather than closed with the packet.

**Handoff**: this tree to the orchestrator for commit — **one file**, trailer
`Agent: dv_lead`, `Work-Order: none`. The working tree also carries tb_writer's
in-flight `WO-0063A` bench work, which is **not mine and is not in my files
list**; R1 requires it be committed separately under its own agent. The severity
conversion is relayed to the **auditor** for the DV-escape ledger. `WO-0063`
phase A's bench round continues; `RV-0063A` is mine when tb_writer returns.

### Open-questions
1. **N-1 has no carrier until the next packet opens REQ-016's reach.** It is
   named in §V.10.5 and in this entry so the gap is visible rather than silent;
   if the next such packet is phase B's, it rides there.
2. **The auditor's DV-escape ledger disposition is not mine and is not yet
   made.** A CRITICAL defect that the committed suite *did* catch — at
   M03-I4's own guards, though not at the first guard that raised — is a
   different ledger entry from an escape, and the distinction is the auditor's
   to draw, not mine to pre-empt.
3. **`WO-0063` §5's convicting-set figure is still too narrow** (corrected at
   §9.3 of that packet, `J-dv_lead-0102`); phase B's seal must be frozen against
   the corrected reach, in the commit that issues the phase-B packet.
4. Carried unchanged: `WO-0058` bound 7; the
   `assert_following_frame_intact` / `assert_clean_frame_structure` merge, still
   deliberately uncommissioned; `WO-0061` §8 bound 1's `tkeep` half; the §0.6 /
   C-14.3 question open to architect_docs_lead (AP §8 item 6); family J behind a
   bench-capability round; my own bar-1 mis-specification, due at the next packet
   with an equivalence criterion; `SO-xgmii_rx_64.md` unopened and not offered.

### Files-in-this-commit
- agents/handoffs/BUG-0003_m03-lane-4-injected-word-cycle.md

## [J-dv_lead-0104] 2026-08-05T00:40Z | task:WO-0063A | Member (iii) accepted on a green CI run that supplied the one figure the worker was right to refuse — and my own §5.1 ruling had falsified a universal in the file it was ruling about

### Trigger
`RV-0063A` — review of tb_writer's `WO-0063A` return, landed as `c00771f`
(`Agent: tb_writer`, `Journal-Entry: J-tb_writer-0023`). Mine by `WO-0063A` §8's
pre-committed bars and `J-dv_lead-0103`'s Outcome (*"`RV-0063A` is mine when
tb_writer returns"*). The orchestrator's spawn additionally directed me to check
the Actions runs for `c00771f` myself and to adjudicate three items the worker
flagged.

### Inputs
- `agents/handoffs/WO-0063A_m03-i2-member-iii-bench.md` — the whole packet, and
  the Return log at its end.
- `git show c00771f --stat` / `--name-only`; the full diff of
  `test/xgmii_rx_64/test_m03_i.ml`.
- `test/xgmii_rx_64/test_m03_i.ml` as landed — the new runner in full, plus
  `run_i2_member` (:396–:539) and the module docstring, read directly rather
  than through the diff.
- `test/xgmii/injection.ml` (the placement-to-octet-time map at :162, `create`'s
  `first_lane` handling at :128–:135, and `outcomes`' zero-received close),
  `test/xgmii/arrival.ml` (`create`, `terminate_octet_time`, `cycles`),
  `test/xgmii/idle_injection.mli` (:112–:138),
  `test/xgmii_rx_64/bench.mli` (`run`, `account_dropped_frame`, and the
  exported set §7 names), `test/xgmii_rx_64/bench.ml` (:176–:206),
  `test/xgmii_rx_64/test_m03_f.ml` (`run_f2`, :388–:497),
  `test/monitors/strobe_monitor.mli` (the (a)/(b)/(c)/(d) split).
- **Specs**: `docs/specs/requirements.md` §0.6 (all three reference-word
  clauses, the *bound-never-a-licence* note, C-23) and §0.7;
  `docs/specs/modules/xgmii_rx_64.md` §6.1's drain derivation (C-14.3, :685–:702)
  and the REQ-109 row. `git log -L` on §0.6's note to date it to `a12ac8f`.
- `agents/handoffs/WO-0063_m03-i2-report-path-delay-mini-round.md` §3, §4, §5,
  §6, §7, §9.3, §9.4, §9.6; `WO-0059` §8 (read to check a citation);
  `WO-0062`'s `RV-0062-VERDICT` (for verdict form).
- My own `J-dv_lead-0102` and `J-dv_lead-0103`; `agents/PROTOCOL.md` §3, §4, §6,
  §7, §10; `agents/charters/dv_lead.md`.
- **GitHub Actions API** for runs `30949738685` and `30949738762`, including the
  job list for the former.
- **No `libs/**`, no `rtl_snapshots/**`, no RTL of any kind.**

### Reasoning

**I re-derived the eight numbers before opening the returned code, and that
ordering is the only thing that makes B1 an anchor rather than an echo.** From
`injection.ml:162`'s own map (`At_octet k` → `start_ot + 8 + k`), `arrival.ml`'s
`create` (`first_lane:4` adds 4 to `first_start`), §0.6's third clause (a frame
that received no octet takes its **closing** word as the window's reference),
§0.7, §9's no-output-word pin and §6.1's C-14.3 derivation: `start_ot` 8/12,
closing octet time 16/20, W = **2 at both lanes**, pin 4, window [2, 5],
boundary 5, margin 1, words 0. Every cell matches the packet's table and the
returned constants. That the worker could not derive blind — its charter forces
it to read the work order first — is a **defect in my packet's shape**, not in
its compliance; B1's own sentence describes *my* procedure, and I performed it.
I ruled the intent met and banked the structural fix (omit the numbers from the
worker packet, or seal them) rather than pretending a self-contradictory
instruction had been disobeyed.

**The verdict turns on a green run, and the green supplied the figure the worker
was right to withhold.** B6(c) — the observed pulse's cycle and name — is not
available to an agent with no toolchain, and tb_writer said so instead of
asserting an expectation as an observation. Run `30949738685` closes it: step 7
passing means exactly one pulse named `error_runt` strictly below cycle 5, and
`assert_monitors_clean` passing over a registration pinned at cycle 4 — matched
exactly on `(strobe, cycle)` — pins the observation to **cycle 4 at both lanes**.
The honest gap in the return was closed by the authority ADR-0005 names, which is
how it is supposed to work; had the worker filled it with its own expectation I
would have had a BO-10 and no measurement.

**The thing I am recording hardest is against me.** The file's module docstring
asserted, as a universal, that *no `Strobe_monitor.expect` call appears anywhere
in this file* and that the family's entire strobe assurance is check (d) on an
expectation-free run. **`WO-0063A` §5.1 — my own ruling, written to resolve a
collision I had found in my own §2.3 — required member (iii) to make exactly such
a call.** So the round shipped with a false universal in the file it changed, and
the falsifying instruction was mine. This is `J-dv_lead-0101`'s shape one round
later, inside a packet whose §7 exists to prevent it, which tells me §7's
*"claims to verify, not facts to trust"* clause covers the packet's claims about
**existing code** but says nothing about the file's own prose that the packet's
**instructions** will falsify. Those are different failure modes and I had only
armed against one. The worker flagged the adjacent staleness (the "two members"
summary) and read §1's four-item fixed shape defensibly; it could not have been
expected to find this one, which requires knowing that `Strobe_monitor`'s checks
(a)/(b)/(c) go from vacuous to instanced.

**Repair now, in review, rather than as a next-round item.** Comment-only, in a
file already in scope, correct content fully determined by what landed, zero
behavioural risk. Deferring a *known* false universal to preserve a round
boundary is the trade `J-dv_lead-0101` already lost; the round boundary is worth
less than the claim's truth. Four edits, all in the docstring, none touching an
executable line, a message string, an assertion, a derivation or an `[%expect]`
block.

**What I refused to repair, and why the refusal is not laziness.** (i) The
strobe-silence message cites *(REQ-109, C-14.3)*, but §0.6 now says in terms that
C-14.3 bounds output **words**, not strobes; the assertion is sound (a pulse at
W+3 is non-conformant on **§9's** authority, since §0.6's ceiling admits it) but
the citation names the wrong rule — and it is **my §5** that instructed that
shape, matching `run_i2_member`'s established idiom. Repairing only member
(iii)'s two messages would make one file speak two ways about one idiom, so it is
commissioned as a single-idiom sweep across both runners. (ii)
`idle_injection.mli:135–137` credits `WO-0059` **§8** with stating the corrected
cycle rule; I read `WO-0059` §8 and it is titled *"`bench.mli`, `bench.ml` and
`dune`"* and states nothing of the kind. That is a fourth site of the same
disease, in a file outside this round's single-file shape, and choosing its right
target is a ruling rather than a typo fix. Commissioned, not smuggled in.

**The generalisation worth keeping from (ii).** §6 said three sites *"is NOT a
closed list"* and invited a fourth — and a fourth existed, one directory over, in
a form no regex for the packet's own quoted string could reach. The invitation
was open; the **predicate** was closed. Declaring an enumeration open does
nothing unless the search is defined by the *defect* (a citation crediting a
section with a rule it does not state) rather than by the *string* the known
instances happened to share.

**On phase B I changed nothing, deliberately.** The orchestrator asked whether
`WO-0063` §4(c)'s datapath-unmoved condition — now backed by a **measured**
perturbation signature from `J-dv_lead-0103` — belongs in this member's
assertions. It does not, and not merely because phase-B machinery is out of
scope: the signature is defined over an emitted stream (`tkeep` patterns,
positional octet matches, a `tlast` index) and this member's conformant emitted
stream is **empty**, so the check would have no domain. What the landed member
supplies instead is better and already executable — its **ordering** puts the two
datapath-unmoved assertions ahead of the strobe scan, so a rendering that
perturbs the datapath reddens with a datapath message and not the window's, which
is exactly the discrimination §4(c) asked for. Recorded for the seal; nothing
built.

**What the seal now waits on.** The bench phase B maps against exists as of
`c00771f`, so `WO-0063` §6's forward commitment is redeemable and falls due in
the commit that issues the phase-B packet — with the **§9.3-corrected** convicting
set, which is wider than §5's and now places member (iii) in **both** the standing-
monitor set and the C-14.3-instrument set. Because both detectors redden on the
same stimulus with **different messages**, the qualification cell is an *ordering*
cell, and the seal must freeze member (iii)'s step-6 message verbatim as the
REQUIRED cell so a red arriving via `assert_monitors_clean` scores as
structurally shadowed instead of as a qualification. One consequence of the
sweep I commissioned: it edits that very string, so it must land **before** the
phase-B base SHA or **after** the campaign, never between.

### Actions
- Full line review of `run_i2_zero_octet_member` against all ten bars and all ten
  BOUNCE conditions; independent re-derivation of the eight numbers at both lanes
  from specs and `test/xgmii/**` before reading the returned constants.
- Queried the Actions API for both `c00771f` runs and the `build` run's job list;
  ran `bash tools/dv_checks.sh` and `ocamlc -stop-after parsing`.
- Four reviewed repairs (R-1 … R-4), comment-only, in `test_m03_i.ml`'s module
  docstring — the "two members" summaries and the false `Strobe_monitor.expect`
  universal.
- Appended `RV-0063A-VERDICT` to the packet: bar-by-bar table, the three
  adjudications, three findings, the §4(c) ruling, and what phase B's seal waits
  on plus three commissioned items. Updated the packet's `State` header field
  clerically, preserving its superseded value inline.
- **No git command run. No RTL opened.**

### Evidence
- **CI run `30949738685`** (`build`, `c00771f`), jobs **92128549658** (`build`)
  and **92128549560** (`cosim`), both **success**; green steps include *Build*,
  *Run tests (expect tests, waveform snapshots)* and *Verify nothing was left
  unpromoted or non-deterministic*. **CI run `30949738762`** (`journal-check`,
  `c00771f`) — **success**. Both externally verifiable via the Actions API at
  those run ids; this is the admissibility class ADR-0005 requires, and no
  "passes locally" claim is made by me or accepted from the return.
- **B6, re-derived by me**: `Arrival.cycles` = `((80+12+7)/8)+1` = 13 at lane 0
  and `((84+12+7)/8)+1` = 13 at lane 4; `bench.ml:190`'s `total = cycles + drain`
  with `drain:8` gives last sampled cycle **20** and **16** samples at
  `cycle >= 5`, both lanes. **B6(c) = (cycle 4, `error_runt`) at both lanes**,
  derived from the green run as argued in Reasoning, not observed by me directly.
- **B7**: `git show --name-only c00771f` = `test/xgmii_rx_64/test_m03_i.ml`,
  `agents/handoffs/WO-0063A_m03-i2-member-iii-bench.md`,
  `agents/journals/workers/claude_tb_writer_agent.v02.md` — three files, no
  `dune`, no `bench.*`.
- **B8**: `bash tools/dv_checks.sh` → `5 test/xgmii_rx_64/test_m03_i.ml`,
  `39 test/xgmii_rx_64/`, both before and after my repairs; the commit's diff of
  that file contains **zero** added or removed lines matching `%expect`.
- **B9**: multiline (line-joined) sweep of `test/**` for `RV-0059-VERDICT\s+§8`
  → two hits, both correct (the repaired docstring history mention, and the
  untouched model site formerly at `:938`, now `:1253`).
- **My repairs**: `ocamlc -stop-after parsing test/xgmii_rx_64/test_m03_i.ml`
  → exit **0**; `git status --porcelain` shows exactly the two files in the list
  below. **Not run**: `dune build` / `dune runtest` — no local toolchain
  (ADR-0005). **The landing check for THIS commit is its own CI run**, which does
  not exist yet and which I do not pre-empt: my repairs are docstring-only and
  parse clean, and that is a necessary condition, not a verdict.
- **`a12ac8f`** dated by `git log -L 467,488:docs/specs/requirements.md` as the
  commit adding §0.6's *bound-never-a-licence* note, which closes `WO-0063` §8
  item 3 by name.

### Outcome
`WO-0063A` **ACCEPTED**; `WO-0063` §7 pass criterion 1 (phase A) fully
discharged. DoD met: bars B1–B10 all met, no BOUNCE condition met, verdict
committed as a packet rather than a chat message. Four reviewed repairs staged
under my own name, each stated in the verdict. Three items commissioned: the
single-idiom citation sweep, the `idle_injection.mli` citation ruling, and the
phase-B packet with its seal in one commit. **Handoff**: this tree to the
orchestrator for commit, trailer `Agent: dv_lead`, `Work-Order: WO-0063A`.

**Harvest (ADR-0018, PROTOCOL §7).** **Not due this round** — no `SO-`, no gate.
Span since the note at the previous entry: **J-dv_lead-0104** (this entry);
cumulative untiled span **J-dv_lead-0001 … 0104**, first harvest still firing at
`SO-M03` and stating that interval so the tiling stays visible.

- **All five banked candidates carry unchanged**: the unstated partition
  precondition; the helper named for its situation rather than its obligation;
  exemption-by-assertion; a blindness claim derived from an instrument's
  documentation rather than from its matching rule; and the
  vindicated-precaution-must-state-its-price rule. The worker's LH2-g candidate
  and the two war stories carry unchanged.
- **Exemption-by-assertion gains a second incident** and is **strengthened**:
  the rule as banked covers a packet asserting existing artefacts are correct.
  This round shows the sibling case — a packet whose own **instruction**
  falsifies a claim elsewhere in the artefact it edits, which no
  verify-the-packet's-claims clause reaches. Incident commits: `WO-0064` §5's
  (`J-dv_lead-0101`) and this one. Observable extended: *a change proposal states
  which existing claims its own instructions make false, not only which existing
  claims it relies on.*
- **One NEW candidate banked, LH2-g.** *Rule*: an enumeration declared open must
  be searched by the **defect** it enumerates, never by the string its known
  instances share. *Observable*: the search predicate is written as a description
  of the fault (here: a citation crediting a section with a rule that section does
  not state) and the round reports what predicate it ran, so a reader can see what
  the sweep could not have found. **LH1**: this round — a packet explicitly
  invited a fourth citation site, and a fourth existed one directory away in a
  form the packet's own quoted string could not match. **LH2-g** — no proper noun
  in the rule. **LH3**: without it, "the list is not closed" is a disclaimer
  rather than a method, and each round re-finds the same three instances and
  re-misses the same fourth. **Domain pack**: n/a (general).

### Open-questions
1. **The `(REQ-109, C-14.3)` citation on the strobe half is live in two runners**
   and its sweep is **ordering-constrained** against phase B's base SHA (before
   the packet, or after the campaign, never between). If phase B is issued first,
   the sweep waits, and the seal freezes the current string.
2. **`idle_injection.mli:135–137`'s target is undecided** — `RV-0059-VERDICT` §8
   with a garbled packet name, or a wrong section number. Named so it does not
   evaporate; carrier is the sweep above or the deferred `WO-0064` owed-notes
   round.
3. **`WO-0063` §5's convicting-set figure remains superseded** by §9.3's and now
   by this verdict's concrete enumeration; the seal must be frozen against the
   latter, in the commit issuing the phase-B packet, or the round has no seal.
4. Carried unchanged: `WO-0058` bound 7; the `assert_following_frame_intact` /
   `assert_clean_frame_structure` merge, still deliberately uncommissioned;
   `WO-0061` §8 bound 1's `tkeep` half; **N-1**, still without a carrier until a
   packet opens REQ-016's reach; the auditor's DV-escape ledger disposition on
   `BUG-0003`, which is not mine; family J behind a bench-capability round;
   `SO-xgmii_rx_64.md` unopened and not offered.
5. **My own bar-1 mis-specification is now two of a kind.** `WO-0063A` §8's B1
   describes my procedure but was read — reasonably — as binding the worker, and
   the packet simultaneously made the reading it demanded impossible. The
   equivalence criterion I owe at the next packet must state, for each bar,
   **whose** action it constrains.

### Files-in-this-commit
- test/xgmii_rx_64/test_m03_i.ml
- agents/handoffs/WO-0063A_m03-i2-member-iii-bench.md
