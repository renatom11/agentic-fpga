# ADR-0021: a check is only where it runs

- **Status**: **ACCEPTED — force per subject, per §9's table.** Subjects
  **1, 2 and 4 are IN FORCE** at the commit carrying `J-orchestrator-0277`
  (the §11(2) acceptance entry): every countersignature on their routes is
  paid (dv_lead `J-dv_lead-0189`; auditor `J-auditor-0024` act 1 on
  subject 1; rtl_lead `J-rtl_lead-0026` carrying its conditions to edit
  grade), every countersignature condition is applied in this file's text and
  in the implementation, and scenarios `S40`–`S51` are green in the suite.
  **Subject 3 enters force at the first green run of its step**, cited by run
  id per `REQ-906` — owed at the implementing seat's next entry. Proposed at
  `J-architect_docs_lead-0049`; the first edition of this block read
  PROPOSED/NOT IN FORCE.
- **Deciders**:
  - **orchestrator** — the four decisions themselves, all four made before this
    round opened and recorded here as its: the ±60-minute stamp-sanity
    **warning** on both surfaces (`J-orchestrator-0259` Act 2 item 1, accepting
    the auditor's `R-0020-1`); the journal-size limb on the CI surface; the
    `REQ-902` two-run determinism step; and the `REC-5` working-tree
    disposition — **adopted as procedure, refused as mechanism**. The
    implementation of every one of them is the orchestrator's too: `scripts/**`
    and `.github/**` are its exclusive scope (PROTOCOL §6), so this file carries
    specifications and test scenarios and **no diffs to those paths**.
  - **architect_docs_lead** — this instrument: the predicates, the two surfaces'
    output rule and its noise bound (§2.4, §3.4), the failure-mode tables, the
    ten `test_protocol.sh` scenarios, the exact `build.yml` step with its
    in-step negative control (§4.2), the **refusal** of the offered
    `agents/PROTOCOL.md` staging warning on the ground that it fires in neither
    of the two cases that matter (§5.2), the evidence form adopted in its place
    (§5.4), and `FINDING ADR21-1` — that `R10` and `R11` are enforced by the
    scripts and named nowhere in the constitution (§3.5).
  - **auditor** — `R-0020-1`, subject 1's whole evidentiary basis: the
    program-wide census, the four candidate bands with their measured
    false-positive rates, the twenty-entry lead time, and constraints (i)–(iii)
    (`J-auditor-0020` §7).
  - **rtl_lead** — subject 3's derivation *in full*: that an in-process second
    emission is unsound for the property, that the only file which invokes the
    executable is the workflow, and the step's shape — second process, scratch
    cwd, `diff -r` (`J-rtl_lead-0021` §7). §4 transcribes it and adds the
    failure semantics, the placement argument, the capability bounds and the
    negative control.
  - **dv_lead** — `FINDING REC-5` and its own bounding of it (`J-dv_lead-0185`
    §10), the banked lesson (e) that generalises it, and the both-surfaces
    corollary it first stated in its `ADR-0016` §6.4 rider, which is the whole
    of §2 and §3's shape.
  - **Not an escalation class.** No requirement is added or dropped, no phase,
    no role, no toolchain lane, no licensing boundary. §11(1)–(3) is the whole
    procedure.
- **Proposed by**: orchestrator dispatch, one round, four subjects — the
  enforcement-hardening round scheduled at `J-orchestrator-0259` Act 2 item 1
  ("one enforcement round of mine together with `REQ-902`'s two-run determinism
  instrument … both are enforcement-surface edits, both need the ADR-and-test
  form"), with `REC-5` and the size asymmetry joined to it.
- **Work order**: none (orchestrator dispatch) · **Journal**:
  `J-architect_docs_lead-0049`
- **Affects, if accepted**: `scripts/policy.sh` (three parameters),
  `scripts/agent_commit.sh` (one warning), `scripts/check_journals.sh` (one
  warning, one size limb, one summary), `scripts/test_protocol.sh` (ten
  scenarios), `.github/workflows/build.yml` (one step). Doc debt this ADR
  **names and does not pay**: `docs/PROCESS.md` §2.5's blanket sentence,
  `docs/specs/requirements.md`'s `REQ-902` verification column, and — as
  `FINDING ADR21-1` — `agents/PROTOCOL.md` §5, which enumerates `R1`–`R9` and
  names neither `R10` nor `R11`. **No frozen spec text, no requirement text, no
  interface record, no gate checklist, no RTL.** Every path above except this
  file is outside my write scope.
- **Measurement pin**: every number in this file was measured at **`b19ff91`**,
  with the commands in §7.4. The dispatch head was `6c02f5b`; one declared
  sibling commit (`b19ff91`, `Agent: dv_lead`) landed mid-round, and every file
  this ADR specifies against — `scripts/policy.sh`, `scripts/agent_commit.sh`,
  `scripts/check_journals.sh`, `scripts/test_protocol.sh`,
  `agents/PROTOCOL.md`, both workflows, `docs/PROCESS.md`,
  `docs/specs/requirements.md` — is **byte-identical at the two SHAs** (blob
  hashes compared, not diffed). Where a number moves with the record, the
  command is given so it can be re-read rather than trusted.

---

## 0. How to read this file

Three sentences, because this ADR proposes four things that are not one thing.

1. **Nothing here is in force.** §9's table states, per subject, what
   countersignature and what act put it in force. A subject may reach force
   while another has not; the file does not flip as a unit.
2. **The decisions are the orchestrator's and the mechanisms are mine.** Where
   a section says *decided*, the decision arrived with the dispatch and is
   recorded with its grounds; where it says *design*, *refused* or *finding*,
   it is this seat's work and is contestable on its own terms.
3. **Every threshold is a parameter with a recorded anchor**, per ADR-0017 §5.1:
   changing one is a policy edit that restates the anchor, not a new ADR.

---

## 1. Context — four items, one shape

### 1.1 The shape

Four items arrived in one dispatch because they are one question asked four
times: **where does a check run, and is that where the failure lives?**

| # | subject | the failure | where the check must run |
|---|---|---|---|
| 1 | stamp sanity | a header stamp that is not the time the entry was written — testimony, not structure | **both** the commit path and the history path, or it is a property of one path |
| 2 | journal size | `R10`'s thresholds are refused locally and unexamined by CI | **both**, for the same reason, on the rule that names itself both-surfaces' first victim |
| 3 | `REQ-902` | emission that is not byte-reproducible | a **second process**, because the classes at issue are fixed once per process |
| 4 | `REC-5` | a working-tree write by a seat that cannot commit it | **nowhere** — between rounds there is no process to run it in |

Subjects 1 and 2 add a surface. Subject 3 adds a process. Subject 4 finds no
surface exists and says so instead of inventing one. The unifying rule is the
title: **a check is only where it runs**, and a rule enforced on one path is a
property of that path rather than of the repository — dv_lead's `ADR-0016` §6.4
rider, ADR-0017 §1.2's conviction of the blob gate, and `PROCESS` §2.4's
corollary, all three saying the same thing about three different checks.

### 1.2 Why subject 2 is not a repetition of ADR-0017 §6.6

ADR-0017 §6.6 applied the corollary to the **blob gate** and minted `R11` for
it. It did not apply it to its own new rule. The council's record-checking
reviewer found the gap and stated it exactly (`docs/reports/process-council/round-1/bob.md`
§F3, landed verbatim at `J-orchestrator-0265`):

> `scripts/agent_commit.sh` refuses appends beyond `JOURNAL_HARD_MAX` (`R10`
> limb, lines 177–179); `scripts/check_journals.sh` contains **no size check at
> all**. A `git commit --no-verify` over-append passes CI clean. ADR-0017
> applied the both-surfaces corollary to the blob gate (minting `R11`, §6.6) but
> never put `H` into `check_journals.sh`, and neither PROTOCOL §5 nor ADR-0017
> declares the residue.

Verified at `b19ff91` and it is exactly right: `check_journals.sh` references
neither `JOURNAL_SOFT_MAX` nor `JOURNAL_HARD_MAX`. This is the second time the
same defect shape has been found in this repository by a reader rather than by a
check, which is itself the argument for subject 1: **a defect that only a reader
finds is found on the reader's schedule.**

*Independently corroborated while this file was being drafted*: the auditor's
claim-verification pass landed at `89998a6` with the same finding re-executed
against the machinery — `docs/reports/audit/PROCESS-claims-posture.md` rows
**C-46** (the threshold pair is machine-checked *"one surface only"*), **C-55**
(the both-surfaces corollary is `PERFORMED-ONCE`, *"a live unrepaired instance
inside the very rule family that minted it"*) and **C-56** (§2.5 `FALSE`). Two
seats reaching the same defect from different directions is why subject 2 needs
no further argument. That pass does **not** reach `FINDING ADR21-1` (§3.5),
which is about the constitution's enumeration rather than the scripts'
asymmetry — checked against the report before this sentence was written.

---

## 2. Subject 1 — `WARN-STAMP`

### 2.1 The decision, and its grounds

**DECIDED (orchestrator, `J-orchestrator-0259` Act 2 item 1).** A ±60-minute
band comparing a journal entry's header stamp against the time of the commit
that carries it. **A warning, never a refusal. On both surfaces.**

The grounds are the auditor's and are recorded rather than re-derived
(`J-auditor-0020` §7):

- **The band separates compliance from drift, measured.** Over the history at
  `b29d2eb`: ±60 min flags 371 of 577 entries and **0 of the 16** committed
  after the `-0251` ruling landed. Post-ruling honest behaviour occupies
  **−18.8 to −0.3 minutes** — a stamp read at authoring, therefore slightly
  *before* its commit. False-positive rate against known-good behaviour: **0 of
  16**.
- **The lead time is the point.** The band would have fired at
  `J-orchestrator-0231` (+85 min) — **twenty entries and one working day before**
  the bounce that actually caught the decay.
- **(i) Warning, never refusal.** `R3` freezes committed stamps; a blocking
  check makes a legitimate re-commit of an already-authored entry unfixable, and
  the defect guarded is **testimony, not structure**.
- **(ii) A new instance, not a new class.** `agent_commit.sh` already emits
  `WARN-JOURNAL`; §10 already contemplates an advisory `WARN-SEAL`.
- **(iii) Both surfaces or neither**, on ADR-0017 §1.2's own conviction.

**Re-measured at `b19ff91` for this file** (§7.4 command 1): 600 commits, 600
entries, **371 outside ±60 minutes (61.8%)**, and **zero unparseable stamps**.
The auditor's figure reproduces; the count moved with the record, the fraction
did not.

### 2.2 The predicate, exactly

One predicate, evaluated identically on both surfaces. Only its inputs' sources
differ, because the two surfaces examine different objects.

    stamp   := the ISO-8601 token at the head of the entry-header line of the
               ONE entry appended by this commit
    ref     := the commit's time
    drift   := stamp - ref, in seconds
    warn    <=> drift > JOURNAL_STAMP_FAST_MAX  or  drift < -JOURNAL_STAMP_SLOW_MAX

- **`stamp` extraction.** The entry header is
  `## [J-<agent>-<NNNN>] <UTC ISO-8601> | task:… | title`. Take the appended
  region already computed by both scripts (`$TMPDIR_P/appended`,
  `$TMP/appended`), take its single entry-header line, strip through the `]`,
  and match the **leading token** with
  `^[0-9]{4}-[0-9]{2}-[0-9]{2}T[0-9]{2}:[0-9]{2}(:[0-9]{2})?Z`.
  **Never hand the whole field to `date`.** Measured ground: of 600 stamps, 377
  are minute-precision, 222 are second-precision, and a trailing parenthetical
  — `2026-08-11T13:00Z (estimated, see Open-questions)` (`J-tb_writer-0044`) —
  is **a recurring practice of at least one chain, with a recorded cause
  outside the grammar** *(J-dv_lead-0189 §1.9: two consecutive entries of that
  chain carry it, structurally, until the work order that forces the estimate
  is repaired)*. GNU `date` happens to parse that leniently; a leading-token
  regex parses it *correctly*, and an entry that qualifies its own stamp is
  **more** honest than the grammar, not less. It must not be flagged as
  malformed, and at −11.8 minutes it is in band anyway.
- **`ref` on the commit surface** is `date -u +%s` read inside
  `agent_commit.sh`. The commit does not exist yet; the script creates it
  within a second of the read, so its own clock is the commit's author time to
  within that second. This is the honest instrument, not a proxy for one.
- **`ref` on the history surface** is `git log -1 --format=%at "$C"` — **author**
  time. Checked at `b19ff91`: author time equals committer time on **all 600**
  commits (§7.4 command 3), so the choice is currently free; author time is
  specified because it is the one preserved across the operations R9 forbids but
  a hosting platform can still perform.
- **The join is exact and needs no judgement**: `R2` makes one journal append
  per commit a mechanical invariant, so "the entry this commit carries" is
  single-valued by construction. This is the auditor's join and it is the reason
  the census is a measurement rather than an estimate.

### 2.3 The two surfaces' predicate is identical; their output is not, and that is the design

The corollary that binds here is *both surfaces evaluate the same rule*. It is
**not** *both surfaces print the same way*. Their subjects differ by three
orders of magnitude — one entry versus 600 — so a design that prints identically
either buries the single new violation or emits 371 lines per push.

**The output rule, stated once and applying to both surfaces:**

> Report per entry while the checked set is small; aggregate per **chain** once
> it is large; never let the line count grow with history.

- `agent_commit.sh` checks **one** entry and emits **at most one line**.
- `check_journals.sh --range A..B` — CI's second step, the pushed range, one to
  a handful of commits — reports **per entry**, capped at
  `JOURNAL_STAMP_LIST_MAX` (default 20) lines, then aggregates the remainder.
- `check_journals.sh --all` — CI's first step, the full history — reports **one
  line per chain**.

This costs nothing to build and it exploits a split the CI workflow already has:
`journal-check.yml` runs `--all` **and** `--range` on every push, so the history
view and the new-commits view are already separate steps with separate logs. A
new violation appears as its own line in the range step; the history stays one
line per chain in the `--all` step. **The tip signal and the historical noise
were already in different places, and the design's whole job was to not fight
that.** One limit, this ADR's own thesis applied to itself *(J-dv_lead-0189
§1.3)*: when the range step cannot compute its range (`github.event.before`
absent, all-zero, or unfetched) it falls back to `--all`, and on that push the
range step degrades to the history view — the new violation is visible only
inside its chain's aggregate.

### 2.4 The `--all` summary, and its measured bound

Emitted **once**, on **stderr** on both surfaces (the class `WARN-JOURNAL`
already instantiates — J-dv_lead-0189 §1.4), as the **last output before the
verdict line**, every line prefixed with the single token `WARN-STAMP` so a
log scan counts deterministically:

```
WARN-STAMP: 371 of 600 checked entries carry a header stamp outside the band
WARN-STAMP: (fast > +60m, slow < -60m, vs their own commit's author time). Advisory:
WARN-STAMP: a warning is not a verdict and its absence is not a clearance.
WARN-STAMP: dv_lead              188 entries  153 out  latest J-dv_lead-0178 (+164.9m)  compliant-run 10
WARN-STAMP: orchestrator         265 entries  150 out  latest J-orchestrator-0250 (+204.1m)  compliant-run 15
WARN-STAMP: architect_docs_lead   48 entries   36 out  latest J-architect_docs_lead-0040 (+703.8m)  compliant-run 8
WARN-STAMP: tb_writer             44 entries   18 out  latest J-tb_writer-0034 (+7404.9m)  compliant-run 10
WARN-STAMP: rtl_lead              24 entries    7 out  latest J-rtl_lead-0008 (+834.5m)  compliant-run 16
WARN-STAMP: auditor               22 entries    4 out  latest J-auditor-0018 (+6422.3m)  compliant-run 4
WARN-STAMP: data_wrangler          9 entries    3 out  latest J-data_wrangler-0009 (+797.4m)  compliant-run 0
```

Those are not an illustration. They are the real values at `b19ff91` (§7.4
command 1), and the block is therefore **a testable prediction in ADR-0017
§5.2's sense**: an implementation that produces different totals or a different
line count does not match this ADR, and that is the first thing to check.

**The bound, stated as a property rather than a hope**: the block is
`3 + |chains|` lines — **ten today** — and it does not grow with history. 371
violations produce ten lines. `grep -c '^WARN-STAMP' ` is bounded by the roster.

**The `latest` cell is the chain's most recent OUT-OF-BAND entry, with its
drift** — not the chain's latest entry *(J-dv_lead-0189 §1.2: the two readings
produce identical totals and line counts, and only this one reproduces the
block's cells, so the falsifier at this section's head does not discriminate
them; this clause is what does)*.

**`compliant-run` is the column that does the work.** It is the number of
consecutive **most recent** entries of that chain whose stamp is in band. It is
zero-state — no baseline file, no stored history, nothing to decay — it
increases monotonically while a chain stays honest, and **it resets to 0 the
moment one entry drifts**. That is the whole decay detector: a chain reading 15
and a chain reading 0 are distinguishable at a glance, and the transition
15 → 0 is what `-0251`'s decay looked like from the outside, twenty-four entries
before anyone noticed. At `b19ff91` six chains read 4–16 and one reads **0** —
`data_wrangler`, whose most recent entry (`J-data_wrangler-0009`, +797.4 min) is
out of band. That single zero is the counter earning its place on the day it
lands.

`compliant-run` prints in `--all` mode only. Over a range it would say "N of the
N checked" and mean nothing; the range mode's per-entry lines are its signal.

**On a red run the summary does not print.** `check_journals.sh` exits at the
first violation via `fail()`, and the summary is emitted just before the OK
line. A verdict outranks a counter; nothing is lost, because the next green run
prints it.

### 2.5 Failure modes

| # | condition | disposition | ground |
|---|---|---|---|
| F1 | stamp in band | silent on both surfaces | the positive control; scenario S40 asserts the **absence** of output, because a check that never speaks and a check that is dead are indistinguishable otherwise (the S39 lesson) |
| F2 | stamp outside band | one line (commit surface) / one entry line or one chain line (history surface); **exit code untouched** | the decision: warning, never refusal |
| F3 | stamp not matched by the leading-token regex | `WARN-STAMP: … unparseable stamp '<text>'`; **exit code untouched** | malformedness is testimony too; and `R5`'s own header grep requires only `## [J-agent-NNNN]`, so a malformed stamp already passes every structural gate. Refusing here would make this ADR the only rule that refuses a defect ADR-0017's own grammar tolerates |
| F4 | `date -u -d` unavailable (non-GNU `date`) | probe once at startup; on failure print **one** `WARN-STAMP: stamp checking unavailable (no GNU date -d); skipped` and disable the check for the run; **exit 0** | CI is `ubuntu-latest` and has GNU date, but `test_protocol.sh` and `check_journals.sh` are run locally too. An advisory that reddens a build on a portability difference is worse than the absence it replaces |
| F5 | an entry authored honestly more than 60 minutes before its commit | **warns — a false positive**, and the only one this design has | see below |
| F6 | merge commit | not reached (both scripts `continue` before the journal block) | a merge appends no entry; `R9` makes it content-free |
| F7 | rotation commit | checked identically: the header stamp read is the appended **entry's**, not the volume header's | the appended region begins with the volume header block on a rotation; the extraction keys on the `## [J-…]` line, not on position |

**F5 is the honest cost and it is asymmetric.** An honest stamp is *always* at
or before its commit, because authoring precedes committing; the entire measured
defect population is on the **fast** side (of 371 violations, 369 are fast). A
long round — stamp read at authoring, commit ninety minutes later — trips the
**slow** bound and is a false positive; nothing an agent can honestly do trips
the fast bound. The design therefore exposes the two bounds as **separate
parameters** (§6) rather than one band, so that the asymmetry can be corrected
by a policy edit with a restated anchor. **Both default to 3600**, because ±60
symmetric is what was decided and what was measured; the asymmetry is recorded
so a later tightening is a parameter change rather than an argument. And the
review trigger is named now: **if the slow bound ever fires on an entry whose
round genuinely ran long, that is a false positive and the bound moves — the
practice does not.** The cost of that false positive is one log line, which is
the entire reason this may be a warning and could never have been a refusal.

### 2.6 What it does not buy

The auditor's own bound, adopted verbatim and binding here: **a warning is not a
verdict and its absence is not a clearance** (§10's words about `WARN-SEAL`).
Three further limits, stated so the counter is not read as more than it is:

- **It cannot detect an honest-looking lie.** A stamp fabricated to sit inside
  the band passes. The check separates *drift* from *compliance*, not truth from
  falsehood.
- **It repairs nothing.** `R3` freezes committed stamps; the 371 historical
  violations stay exactly as written, as the architect's `requirements.md` §13
  preamble note and the auditor's §6(c) both already ruled — *a frozen record
  repaired by rewriting is a worse record*.
- **What it buys is a schedule.** In the auditor's words: *what the counter buys
  is not honesty; it is that the next decay is visible in three entries instead
  of twenty-four.*

### 2.7 `test_protocol.sh` scenarios owed — S40…S46

§11(3) binds: enforcement semantics change, so these are owed, not optional.
Written in the suite's existing style, continuing from `S39`.

- **S40 — in-band stamp, silence.** A commit whose entry stamp is 10 minutes
  before the run: **accepted**, and stderr contains **no** `WARN-STAMP`. The
  positive control; without it every later scenario could pass against a check
  that fires unconditionally.
- **S41 — the load-bearing case.** A commit whose entry stamp is **+6 h** fast:
  **exit status 0** *and* a `WARN-STAMP` line naming the entry id and the drift.
  Two assertions, and the first is the one that proves *warning, never refusal*.
  **This is the case to write first.**
- **S42 — the same fixture through CI.** `check_journals.sh --all` over that
  history: **exit 0**, summary block present, the violating entry's chain named
  with `out ≥ 1`.
- **S43 — the noise bound, asserted as a number.** A history with **five**
  out-of-band entries across **two** chains: `--all` emits **exactly two**
  chain lines (plus the fixed 3-line header) and **no** per-entry lines —
  `grep -c '^WARN-STAMP'` equals `3 + 2`, and specifically **not** `≥ 5`. The
  scenario the dispatch asked the design to guarantee, expressed so a
  regression to per-entry spam fails the suite.
- **S44 — malformed stamp.** An entry header whose stamp is `not-a-date`:
  **both** surfaces exit 0 and emit the `unparseable` message (F3).
- **S45 — the band is live, and its boundary.** With
  `JOURNAL_STAMP_FAST_MAX` set to the fixture's exact drift in seconds: **no**
  warning (the comparison is strict `>`); one second lower: a warning. Proves
  the parameter is read and pins the boundary semantics.
- **S46 — graceful degradation.** With a `date` shim earlier on `PATH` that
  fails `-d`: both surfaces exit 0 and emit the single `skipped` notice (F4).

`S40` and `S41` are the pair that must never be allowed to pass vacuously
together: one asserts output, the other asserts its absence, on the same
mechanism.

---

## 3. Subject 2 — `R10`'s size limb on the CI surface

### 3.1 The decision

**DECIDED (orchestrator).** `check_journals.sh` gains the `R10` size check, so
that the two enforcement surfaces agree what compliance is. **Same posture as
subject 1: warning, not refusal.**

The gap is proven live, not argued: `bob.md` §F3, quoted at §1.2, verified at
`b19ff91`.

### 3.2 The predicate: the **active** volume, and why not every volume

    for each commit C with trailer Agent: A
        J  := active_journal_for A C          # the highest-numbered volume in C's tree
        sz := git cat-file -s "C:J"
        over-S <=> sz > JOURNAL_SOFT_MAX
        over-H <=> sz > JOURNAL_HARD_MAX

**The active volume only.** This is the design decision of this subject and it
is forced by measurement. `agent_commit.sh`'s subject is the *staged active
volume* (`$TMPDIR_P/staged`, line 177), so the active volume is what makes the
two surfaces evaluate the **same** predicate — which is the entire point of the
change. And the alternative is unusable: `claude_dv_lead_agent.md` froze at
**1,123,442 bytes**, 2.1× `H`, and it is *frozen* — nothing anyone does can
change it. A check over every volume in the tree would flag it on every commit
from its rotation to the end of the program, an alarm with no act attached to
it. Measured over the 600 commits at `b19ff91` (§7.4 command 2):

| | commits | distinct (agent, volume) |
|---|---|---|
| active volume over `S` | **95** | **18** |
| active volume over `H` | **48** | **1** (`claude_dv_lead_agent.md`, max 1,123,442) |

### 3.3 Noise: aggregate what no one can act on, itemise what someone can

The `--all` size report is **a two-line aggregate for frozen history plus one
line per active volume currently over a threshold**, every line prefixed
`WARN-JOURNAL` — the token `agent_commit.sh` already uses for this rule, because
it *is* this rule:

```
WARN-JOURNAL: R10 history: 18 volume(s) exceeded S while active over 600 commits;
WARN-JOURNAL: 1 exceeded H (agents/journals/claude_dv_lead_agent.md, max 1123442 B, frozen).
WARN-JOURNAL: active volumes at HEAD: all within S.
```

Three lines today: two of aggregate and one saying that no active volume is over
`S`. The third is the only line that can ever name a seat, and the block's bound
is `2 + |active volumes over a threshold|`, i.e. `2 + |roster|` in the worst
case. The principle generalises across both subjects and is the answer to "how
is the noise bounded":

> **Report at the granularity of the seat that can act.** A chain's stamp drift
> is actionable at its owner's next entry, so the stamp summary is per chain. A
> frozen volume's size is actionable by nobody, so it is one aggregate; an
> active volume's size is actionable at its owner's next entry, so it is
> itemised.

Both blocks are bounded by the **roster**, not by history. That is the property
that keeps a full-history checker readable for the life of the program.

### 3.4 The posture asymmetry, stated rather than hidden

After this change the surfaces agree on the **predicate** and differ on the
**posture**: `agent_commit.sh` refuses above `H`, CI warns. That is a real
residue and it must be declared here rather than discovered later — the exact
failure `bob.md` §F3 convicted ADR-0017 of ("neither PROTOCOL §5 nor ADR-0017
declares the residue").

**Why CI warns where the commit path refuses.** Not deference to the decision —
the decision has a ground, and it is one the blob gate does not share:

- **A permanent red is proportionate to harm that persists in every future
  reader, and disproportionate to harm bounded by one file's readability**
  *(the ground as corrected by J-dv_lead-0189 §2.1 — the first edition's
  bolded sentence, "a rule whose only remedy is forbidden cannot be a refusal
  in a full-history checker", is refuted by this repository's own `R11`, which
  is exactly such a refusal and is kept; it survives below as a premise, not
  the test)*. A landed multi-megabyte blob costs every future clone until
  someone deals with it; an oversized journal volume costs the readability of
  one file, and its cure is available prospectively and unilaterally to its
  owner. As a premise: history is immutable, `--all` re-reads it forever, and
  if CI refused here, one seat's one-round oversight would fail every future
  push by every agent, permanently, with the only remedy a history rewrite
  `R9` forbids.
- **The harm is bounded and self-curing.** `R11`'s blob gate protects every
  future clone, and a landed multi-megabyte blob keeps costing until someone
  deals with it — a permanent red is proportionate. An over-`H` journal volume
  costs *readability of one file*, and its cure is available prospectively and
  unilaterally: the owner rotates at its next entry and the oversized volume
  freezes forever. Refusing in CI would convert one seat's one-round oversight
  into a total stop for every other seat.
- **What is therefore bought is visibility, not prevention**, and the honest
  statement of the cure is: *the bypassed over-`H` append still lands; from this
  change on, it is named on every push instead of never.* The gap `F3` found
  closes to **detected and named**, not to zero.

### 3.5 `FINDING ADR21-1` (MAJOR, against the record, raised here rather than routed)

While specifying this subject I checked what the constitution says about the
rule being extended. It says nothing.

    $ grep -c -E 'R10|R11|volume|rotate' agents/PROTOCOL.md
    0

`agents/PROTOCOL.md` §5 enumerates `R1`–`R9`, and its CI paragraph says CI
"re-checks `R1`–`R8`". The scripts at `b19ff91` enforce **`R10`** (chain
integrity, rotation headers, one-volume-per-commit, the size thresholds) and
**`R11`** (the CI blob gate), and `test_protocol.sh` has eleven scenarios for
them (`S28`–`S38`). ADR-0017 §8.2 **wrote** the `R3`/`R5`/`R10` PROTOCOL diffs and stated
they were *"written, NOT applied"* pending acceptance; §8.4 listed
`agents/PROTOCOL.md` among the files a work order must touch. The scripts
landed. **The constitution's half never did**, and no entry I can find retires
or defers it.

So the honest picture of subject 2 is that there are **three** surfaces, not
two, and the third disagrees with both others:

| surface | knows `R10`'s chain limb | knows `R10`'s size limb | knows `R11` |
|---|---|---|---|
| `agent_commit.sh` | yes | yes, **refuses** | yes (carve-out) |
| `check_journals.sh` | yes | **no** → this ADR | yes, refuses |
| `agents/PROTOCOL.md` | **no** | **no** | **no** |

I raise it and do not repair it: `agents/PROTOCOL.md` is orchestrator scope
(§6) and the amendment is a §11 act whose instrument is ADR-0017, whose §8.2
text already exists and needs only `R11` and this ADR's size-limb sentence added.
**Recommended route**: the orchestrator applies ADR-0017 §8.1–§8.3 as written,
plus the two sentences drafted at §8 below, in the same act that lands this
ADR's scripts — or routes it as its own round. **It is not a precondition of
this ADR**, and this ADR does not amend PROTOCOL. Recording it is the point:
`PROCESS` §2.5's sentence is false for a second reason nobody has stated, and a
rule that no constitution names is a rule that a fresh orchestrator cannot find.

### 3.6 `test_protocol.sh` scenarios owed — S47…S49

- **S47 — both surfaces on one fixture.** The `S37` fixture (an append past `H`)
  is committed with `JOURNAL_HARD_MAX` overridden — the documented bypass, as
  `S38` does for the blob gate. Then: `agent_commit.sh` under the default `H`
  **refuses** it (already `S37`), and `check_journals.sh --all` over the landed
  history **exits 0** while naming the volume and its byte count. The
  ADR-0017 §9(h) analogue: the case that proves the ADR's central claim rather
  than its mechanics, and the one to write first.
- **S48 — size noise bound.** Five commits over one oversized active volume
  produce **one** `WARN-JOURNAL` volume line, not five.
- **S49 — the active-volume predicate.** After the oversized volume is rotated
  past, the frozen volume produces **no** per-volume line (it enters the
  aggregate count), while an active volume over `S` does produce one. Proves the
  predicate is "active volume", which is the one thing a later simplification
  would get wrong.

---

## 4. Subject 3 — `REQ-902`'s two-run determinism instrument

### 4.1 The decision, and whose derivation this is

**DECIDED (orchestrator).** A step in `.github/workflows/build.yml`, after
`Generate RTL` and before the determinism-verify step, running the built
executable a **second time as a separate process from a scratch working
directory** and `diff -r`-ing the two output trees.

**The derivation is rtl_lead's** (`J-rtl_lead-0021` §7), was made against its
own interest — it declined the rider it was offered — and is transcribed rather
than restated:

- The existing workflow *"generates **once** and compares against the committed
  tree, so this is cross-run identity between two commits and **not** a
  double-generation check"* (dv_lead, `J-dv_lead-0176` §9; adopted by rtl_lead).
- *"The only check that fits inside `bin/**` is a second emission within the
  same process, compared in memory — and it is unsound for this requirement.
  The nondeterminism classes `REQ-902` exists to catch are process-scoped …
  **A check that can pass while the property fails, and might fail while it
  holds, is worse than the absence it replaces**."*
- *"Regeneration is a **process invocation**, and the only file in this
  repository that invokes `generate.exe` is `.github/workflows/build.yml`,
  whose scope is the orchestrator's exclusively."*

That is why this subject is in an ADR at all: the requirement's instrument lives
in a file its owner cannot write.

### 4.2 The step, exactly

Placed between the current lines 55 and 57 of `.github/workflows/build.yml`:

```yaml
      - name: REQ-902 two-run determinism (second process, scratch cwd)
        # REQ-902: regenerating from unchanged sources SHALL produce
        # byte-identical files. The step below is the FIRST instrument for it.
        # "Generate RTL" above generated once; the step below compares that
        # output against the COMMITTED tree — cross-commit identity, not a
        # double generation (J-dv_lead-0176 §9, J-rtl_lead-0021 §7).
        #
        # A second emission inside one process cannot expose the classes at
        # issue: they are fixed once per process. So run 2 is a separate
        # process, from a working directory OUTSIDE the checkout — bin/
        # generate.ml writes "rtl_snapshots/<name>.v" relative to cwd and
        # mkdir's the directory if absent, so a scratch cwd yields a complete
        # second tree and touches nothing in the checkout (ADR-0015 R-CI-5's
        # rule, applied here).
        #
        # A diff here is a REQ-902 defect and is NEVER a promotion source:
        # two runs disagree, so neither tree is authoritative and there is no
        # correct file to promote. Contrast the step below, whose failure
        # output IS the promotion source (ADR-0005 rule 2).
        run: |
          set -euo pipefail
          SCRATCH=$(mktemp -d)                    # outside the checkout
          trap 'rm -rf "$SCRATCH"' EXIT
          EXE="$PWD/_build/default/bin/generate.exe"
          test -x "$EXE" || { echo "REQ-902: $EXE is not built"; exit 1; }
          # Corrected after the first execution (run 31571485201, exit 50):
          # the switch is project-local, so from a scratch cwd a bare
          # `opam exec` finds no switch at all. Resolved in the checkout and
          # passed explicitly — the first edition of this block lacked it.
          SWITCH=$(opam switch show)
          ( cd "$SCRATCH" && opam exec --switch "$SWITCH" -- "$EXE" )
          if ! diff -r "$SCRATCH/rtl_snapshots" rtl_snapshots > "$SCRATCH/req902.diff" 2>&1; then
            echo '=== REQ-902 DEFECT: two generations of the same source disagree ==='
            echo 'NOT a promotion source: neither run is authoritative.'
            cat "$SCRATCH/req902.diff"
            echo '--- run 1 (checkout) ---'; sha256sum rtl_snapshots/*.v
            echo '--- run 2 (scratch)  ---'; sha256sum "$SCRATCH"/rtl_snapshots/*.v
            echo '=== END REQ-902 DEFECT ==='
            exit 1
          fi
          # Negative control, in the same step: the comparator must be able to
          # fail. A comparator that cannot fail is indistinguishable from one
          # that always passes (ADR-0015 R-CI-4's lesson, made per-run).
          cp -r "$SCRATCH/rtl_snapshots" "$SCRATCH/ctrl"
          printf 'x' >> "$(ls -1 "$SCRATCH"/ctrl/*.v | head -1)"
          if diff -r "$SCRATCH/ctrl" rtl_snapshots > /dev/null 2>&1; then
            echo 'REQ-902: negative control did not fire — the comparator is inert'
            exit 1
          fi
          echo "REQ-902: two generations byte-identical ($(ls -1 "$SCRATCH"/rtl_snapshots | wc -l) files); negative control fired"
```

Three notes on the text, each a decision rather than a detail.

- **`opam exec --` wraps run 2** so that both runs resolve the same opam
  switch. It does **not** make the two environments equal, and the difference
  is declared here rather than removed *(C-RL-11, J-rtl_lead-0026 — this
  bullet's first edition claimed the only declared difference was cwd and
  process identity)*. Run 1 goes through `dune exec`, which injects nine
  variables the direct invocation does not have — `INSIDE_DUNE`,
  `DUNE_SOURCEROOT`, `DUNE_OCAML_STDLIB`, `DUNE_OCAML_HARDCODED`, `OCAMLPATH`,
  `OCAMLFIND_IGNORE_DUPS_IN`, `OCAMLTOP_INCLUDE_PATH`, `CAML_LD_LIBRARY_PATH`,
  `MANPATH` — and prepends `_build/install/default/bin` to `PATH`; three of
  the nine are absolute paths into the checkout. The set is **descriptive of
  one measurement** (dune 3.24.1) and not a pinned contract:
  `agentic_fpga.opam` requires only `dune >= 3.0` and CI resolves the version
  through `ocaml/setup-ocaml@v3`. Declaring beats equalising precisely
  because of that — and it must never be mechanised as an assertion: a
  hard-coded equality check goes red on a dune bump for a reason unrelated to
  `REQ-902`. If mechanised at all: **print** the delta, never assert it.
- **`_build/default/bin/generate.exe` directly, never `dune exec`.** `dune exec`
  runs from the project root — it would overwrite run 1's output and destroy the
  comparison — and may relink. The path is rtl_lead's own.
- **The negative control runs against a copy inside scratch**, never against the
  checkout, and is why this step can be believed on a green run.

### 4.3 The placement is forced twice, not chosen

- **After `Generate RTL`**: that step both produces run 1's output *and*
  guarantees `_build/default/bin/generate.exe` exists. Either reason alone fixes
  the lower bound.
- **Before `Verify nothing was left unpromoted or non-deterministic`**: that
  step runs `git add -A`, which stages the checkout's generated files. Running
  after it would compare run 2 against a tree the checker had already acted on,
  and — the property rtl_lead named as load-bearing for the two-commit red/green
  pattern — **a reader must be able to tell one failure from another by the
  failing step's name alone**. Two determinism-shaped failures must not share a
  step.

### 4.4 Failure semantics: three classes, one disposition each

`diff -r` produces three distinguishable outputs and they are not one finding.

| output | class | disposition |
|---|---|---|
| `Files … differ` | **`REQ-902` defect** — the same source emitted different bytes in two processes | job **red**; never promote; the commit does not advance; route to rtl_lead as a defect against the emitter, not against the snapshot — **but before routing, check the differing bytes for any of the values §4.2 note 1 declares. A harness-caused diff and a program-caused diff are the same `diff` output, and this check is the only thing that separates them** *(C-RL-11)* |
| `Only in <scratch>/rtl_snapshots` | **`REQ-902` defect** — a file written by one process and not the other | job **red**; same routing. A write that happens once is nondeterminism of the strongest kind |
| `Only in rtl_snapshots`, **untracked** (absent from `git ls-files`, `??` in status) | **`REQ-902` defect** — row 2's class, direction-reversed: run 1 wrote it, run 2 did not *(C-RL-12)* | job **red**; **never delete**; route to rtl_lead against the emitter |
| `Only in rtl_snapshots`, **tracked and modified** (` M`) | **`REQ-902` defect** — the checkout copy is not `HEAD`'s bytes, so run 1 rewrote it while run 2 did not write it at all *(C-RL-12)* | job **red**; **never delete**; route to rtl_lead |
| `Only in rtl_snapshots`, **tracked and clean** | **undetermined at the step** — git cannot separate *run 1 rewrote it identically* from *run 1 never touched it* *(C-RL-12)* | job **red**; resolved by one read of `bin/generate.ml`'s emitter list: **if the list names the file it is a `REQ-902` defect** (run 2 omitted a registered emission); **only if the list does not name it** is it an orphan, remedy deletion, rtl_lead's inventory. The test runs opposite to the reading it invites: a file is an orphan **only when no emitter row names it** |

And a fourth, from `set -e` rather than from `diff`: **run 2 exits nonzero**
while run 1 succeeded. That is the same class as the second row and the strongest
signal the instrument can produce.

**In no case is this step's output a promotion source.** That sentence is the
one that must survive into the implementation, because every neighbouring step
in this workflow prints a `PROMOTION BLOCK` on failure and the reflex it trains
is exactly wrong here.

### 4.5 What it discharges, and what it does not

**One datapoint per run, not a proof.** Each green run is one observation of
byte-identity between two processes, on one runner, with one toolchain, seconds
apart. After N green runs the honest claim is *"N observations, zero
divergences"* — never *"`REQ-902` holds"*.

| nondeterminism class | exposed? | why |
|---|---|---|
| address / allocation-order dependence | **yes** | ASLR varies per process; two processes is exactly the frame |
| cwd dependence, absolute-path leakage into output | **yes** | deliberately varied — the scratch cwd is not decoration |
| per-process random seed, pid, or start-time dependence | **yes** for seed/pid | two processes differ in both |
| hash-table iteration order under a per-process seed | **no, under the shipped runtime** | OCaml's `Hashtbl` is not randomised unless `~random:true` or `OCAMLRUNPARAM=R`. The class rtl_lead named first is the one this instrument does **not** reach as configured, and saying so is the difference between an instrument and a claim |
| environment / locale dependence | **yes, incidentally — and now declared** | the two runs do **not** share an environment: `dune exec` injects into run 1 the set §4.2 note 1 names *(C-RL-11)*. The capability is a by-product of the harness asymmetry, not a designed probe, so it is not a controlled variation of any one variable and supports no claim about which one mattered |
| coarse time-of-day dependence (a timestamp embedded in output) | **not reliably** | two runs seconds apart usually agree; a date stamp in emitted Verilog would pass most of the time and fail at midnight |
| machine, OS, opam switch, dune or library version | **no** | one runner, one build |
| a nondeterministic **compiler** | **no** | both runs execute the same binary |

**The `OCAMLRUNPARAM=R` variant, named and not adopted.** Running run 2 with
hash randomisation on would convert this from a sample into a real probe of the
hash-order class. It is not adopted, for a stated reason rather than by
omission: `REQ-902`'s text is *"regenerating the RTL snapshots from unchanged
sources"*, and an environment variable is not source, so a red under `R` would
be a finding whose disposition needs a spec reading nobody has made. If a later
round wants it, it belongs in **its own step with its own name** so a failure
attributes correctly — the same reason §4.3 gives for not sharing a step.

### 4.6 The comparison script: declined as a file, credited as a derivation

rtl_lead offered to author the comparison script *"but not in `bin/`"*. **The
offer is declined for the file and accepted for the derivation** — which is what
§4.1 and §4.2 transcribe.

- The step is six lines of shell. The ADR-0015 precedent that put the cosim lane
  in `tools/cosim/run_cosim.sh` had reasons a six-line diff does not have:
  mktemp hygiene across three checks, sidecar metadata (`R-CI-3`), and an
  entry-point contract.
- A script would need an owner, and **every candidate path is wrong**: `bin/`
  holds the OCaml executable and nothing else by this repository's convention
  (rtl_lead's own words); `tools/` is dv_lead's scope, which would make an
  RTL-line instrument a DV artifact and put the verifying seat inside the
  instrument it verifies with; `scripts/` is the orchestrator's, which is where
  `build.yml` already lives, so a script there buys indirection and no
  ownership clarity.
- **No `R-CI-` number is minted.** `R-CI-1`…`R-CI-8` are ADR-0015's rules for
  the **cosim lane**; extending that namespace to a step in `build` would drift
  its meaning silently, which is the defect ADR-0017 D5 named. This step's
  authority is this ADR's §4 and `REQ-902`'s own verification column.

### 4.7 What §11(3) owes here, since it is not a `test_protocol.sh` case

§11 binds *"this protocol, a charter, or the enforcement scripts"*.
`build.yml` is none of the three — it is the build/test workflow, not a journal
enforcement script — so **no `test_protocol.sh` case is owed for subject 3**,
and inventing one would test the wrong thing. What is owed instead, stated so
the absence is a decision:

1. **The in-step negative control** (§4.2), which discharges per-run what
   `R-CI-4` discharged once for the cosim comparator.
2. **A CI run id and conclusion** for the first green execution of the step,
   cited in the implementing entry's Evidence per `REQ-906`.
3. **A doc edit I own and name here**: `docs/specs/requirements.md`'s `REQ-902`
   verification column currently reads *"The existing `build` workflow
   determinism step"*, which after this change is incomplete and misattributes
   the instrument. It is paid in the round that lands the step, or immediately
   after — **not in this one**, whose write allowance is this file and my
   journal.

---

## 5. Subject 4 — the `REC-5` working-tree question

### 5.1 The decision, recorded

**DECIDED (orchestrator).**

- **ADOPTED AS PROCEDURE**: the pre-application byte-check against `HEAD`,
  already exercised at `a76e485` (*"applied from the ADR's own recipe, verified
  byte-clean before and after"*) and made procedure.
- **REFUSED AS MECHANISM**, on three grounds, recorded as given: the working
  tree between rounds has **no daemon to watch it** in this harness;
  `agent_commit.sh` already refuses the commit path under any non-orchestrator
  trailer (`R7` — *the actual landing gate held even during the incident*); and a
  mechanical tree-watcher would be **a new class of thing**, which `R-0020-1`'s
  own constraint (iii) counsels against.

The incident is dv_lead's own disclosure, made against itself and bounded by
itself (`J-dv_lead-0185` §10): an applier defaulted to the repository,
`agents/PROTOCOL.md` was modified in the working tree — 48 insertions, 3
deletions — detected on the next `git status`, reverted within the minute, and
**measured back** to `72458857aa75…` byte-for-byte against `HEAD`. Nothing was
staged; nothing landed. Its own summary is the sentence this subject exists
against: **"the guard that would have caught it was luck plus a status read —
which is not a guard."**

### 5.2 The offered addition: **REFUSED**, and the reason is that it fires in neither case

I was asked to design or refuse a cheap addition: `agent_commit.sh` warning when
`agents/PROTOCOL.md` is staged and the entry's body does not name it. **Refused.**
The ground is not cost. It is that the predicate is orthogonal to the hazard, and
tracing the two reachable cases shows it:

**Case A — the accidental stage.** The committer runs `git add -A` in a window
when a sibling's stray write sits in the tree. Its entry was written *before*
the commit (§4.1's rule), from the round's own intent, so the entry's
`Files-in-this-commit` list does not contain `agents/PROTOCOL.md`. **`R4`
refuses the commit** — set-equality fails and the script prints the offending
path in its `--- claimed vs staged ---` diff. **The guard already exists, it is
mechanical, and it is a refusal rather than a warning.** A warning here is
strictly weaker than what already happens.

**And Case A's guard has a precondition that is worth more than the warning was.**
`R4` catches the stray stage only because the files list was authored from
*intent*. §4.1 requires the entry before the **commit**, not before the
**staging**, so a committer that stages first and then transcribes its list from
`git diff --cached --name-only` satisfies `R4` **tautologically**: the claim is
derived from the thing it is supposed to check, and the stray path is carried
into the list along with everything else. That is the one way Case A becomes
silent, and no script can tell the two authoring orders apart — the index looks
identical either way. So the honest statement of the existing guard is
conditional, and the condition belongs in the same procedure as §5.4:
**the `Files-in-this-commit` list is authored from the round's intent and then
compared against the index; the discrepancy is the signal, and deriving the list
from the index destroys it.** That sentence is a cheaper and strictly more
valuable addition than the warning that was offered, and it costs no code at all.

**Case B — the legitimate amendment.** The committer's round *is* the
constitutional edit (`a76e485` is the live example). `agents/PROTOCOL.md` is on
the files list legitimately and the entry's body is *about* it. The proposed
predicate — "the body does not name it" — is **false**, so the warning is
**silent**. And Case B is exactly where the residue lives: `R4` is
**path-granular**, so an extra hunk riding inside a file that is legitimately
staged passes every mechanical check in the repository.

> The proposed warning is loud where a refusal already fires and silent where the
> residue actually is. That is the whole refusal.

### 5.3 What the residue actually is — a correction to the framing

The dispatch framed the residue as *"an orchestrator could unknowingly stage a
poisoned `agents/PROTOCOL.md`"*. Traced, the unknowing stage of an **unlisted**
file is already refused by `R4` (Case A). What survives is narrower and sharper:

> **`R4` binds paths; the hazard is hunks.** The residue is an unintended change
> *inside a file the committing entry legitimately lists* — `agents/PROTOCOL.md`
> during an amendment act, `tasks/BOARD.md` during any flip — and it requires two
> conditions to coincide: a concurrent lane writing outside its scope into the
> tree, and the committer legitimately staging that same path in that window.

Two consequences follow, and both are better news than the original framing.

- **No mechanism can reach it**, and this is provable rather than pessimistic:
  distinguishing an intended hunk from an unintended one requires the round's
  *recipe*, which lives in the agent's reasoning and in the ADR it applies —
  never in the index. A script comparing the staged diff to "what was meant" has
  no access to what was meant. This is `ADR-0016` §5.3's distinction exactly: a
  gate that cannot tell a confession from a crime must not be a gate.
- **It is detectable after the fact.** The commit's diff is in history and the
  entry's narrative either accounts for every hunk or does not — which is
  §4.1's vacuity standard and the auditor's sampling mandate. The residue is
  *prevented by procedure* and *caught by audit*, and mechanically refusable at
  neither end.

### 5.4 What is adopted instead: the procedure gains an evidence form

A habit that leaves no trace cannot be measured, and an unmeasurable remedy is
how `-0226`'s date-honesty adoption decayed in three entries — this program's
own best-documented failure, and the reason subject 1 exists. So the procedure
is adopted **with an evidence form**, which is the smallest change that makes
compliance countable:

> **The three-limb byte-check** (binding the sole committer, for any commit
> staging a constitutional path — `agents/PROTOCOL.md`, `agents/charters/**`,
> `scripts/**`, `.github/**`):
>
> **Limb 1 — before applying.** Before any generated or scripted edit is applied
> to a repository artifact, verify the target is byte-equal to `HEAD` and record
> the pair of digests. (This is what `a76e485` did.)
>
> **Limb 2 — the files list is authored from intent, never from the index**
> (§5.2). `R4`'s set-equality is a check only while its two sides have
> independent sources; a list transcribed from `git diff --cached --name-only`
> makes `R4` a tautology and silences the one guard that covers the accidental
> stage.
>
> **Limb 3 — after staging, before committing.** Read `git diff --cached --
> <path>` in full for each constitutional path staged, and record in the entry's
> **Evidence** the line counts and the recipe they came from.
>
> The commit's own entry is the artifact. **Review-enforced**, like §10:
> no `R`-number, no namespaced id, no script change — and therefore, per §11(3),
> **no test case owed**.

**Why an evidence form is worth the words.** It converts an unenforceable habit
into a claim an auditor can measure with one pass over history: *for every
commit staging a constitutional path, does the entry's Evidence carry the
byte-check?* That is grep-able against the whole record, by a seat that owns
neither the scripts nor the constitution. The remedy for the residue thus ends
up in the same place `R-SEAL-1` and §10's mutation discipline live — reviewed,
evidenced, and countable — which is where a rule about *conduct in a working
tree* belongs, because a working tree is the one object in this program that no
commit ever sees.

### 5.5 What is deliberately not built, and not numbered

- **A tree-watcher**: refused with the decision, and independently: it would have
  to run *between* rounds, where this harness runs nothing.
- **An unconditional staged-diffstat display** in `agent_commit.sh` — considered
  seriously, because it has no predicate and therefore no false positives.
  **Refused**: `agent_commit.sh`'s output discipline today is *silence unless
  `WARN-` or `PROTOCOL VIOLATION`*, and this ADR is already spending that
  channel on three new advisory instances. Routine chatter in the same round
  trains the operator to skim exactly the channel subjects 1 and 2 are
  investing in. **The value of a warning channel is the silence around it.**
- **A number.** No `R`-rule, no `R-TREE-n`. `ADR-0016` settled that numbers in
  the `R1`–`R9` space mean *the script refuses this*, and namespaced ids are for
  review-enforced rules of general application. This binds one seat's practice
  and is citable as `ADR-0021 §5.4`. If the auditor finds ADR-citation
  insufficient at a later process round, the amendment is a one-line addition to
  PROTOCOL §10 and §5.4's text above is its draft — offered as text, claimed as
  nothing.

---

## 6. Parameters, and where they live

All in `scripts/policy.sh`, beside `JOURNAL_SOFT_MAX`/`JOURNAL_HARD_MAX`, in the
same form (env-overridable defaults). Per ADR-0017 §5.1, changing one is a policy
edit that restates its anchor, not a new ADR.

| parameter | default | anchor |
|---|---|---|
| `JOURNAL_STAMP_FAST_MAX` | `3600` | the auditor's measured band: 0 of 16 false positives on known-good behaviour; the entire measured defect population is on this side (369 of 371) |
| `JOURNAL_STAMP_SLOW_MAX` | `3600` | the decided ±60 symmetric — and **anchored to nothing measured**: the 0-of-16 false-positive rate and the 369-of-371 population are fast-side facts that do not transfer (`FINDING F-0024-1`, auditor countersignature). Separated from the fast bound because the false-positive risk is entirely here (§2.5 F5) and grows with round length |
| `JOURNAL_STAMP_LIST_MAX` | `20` | the per-entry listing cap in `--range` mode; above it, the range aggregates like `--all`. Sized so an ordinary push (1–5 commits) always itemises |

No parameter disables the stamp check. Graceful degradation exists for the one
environment condition that warrants it (§2.5 F4) and is not a switch.

---

## 7. Consequences

### 7.1 On the day this lands

- `agent_commit.sh` prints **nothing new on a compliant commit** and **at most
  one line** on a drifted one. Its **refusal set is unchanged**: no commit that
  passes today fails after this change. That is checkable, and it is exactly
  what the `S40`/`S41` pair asserts.
- `check_journals.sh --all` gains **thirteen lines** on a green run: ten
  `WARN-STAMP` (§2.4) and three `WARN-JOURNAL` (§3.3). Its refusal set is
  **unchanged**.
- `build` gains one step and roughly the runtime of one RTL generation.
- Nothing in history is edited, and nothing is repaired. 371 stamps and 18
  oversized volumes stay exactly as written.

### 7.2 The three claims a reader may make afterwards, and their exact strength

- *"Journal stamps are checked."* — On both surfaces, as a **counter**. It
  separates drift from compliance; it does not detect a fabricated stamp, and its
  silence is not a clearance.
- *"The two enforcement surfaces agree what compliance is."* — On the
  **predicate**, for `R10`'s size limb. Their **postures** still differ, by the
  reasoned decision at §3.4, and the constitution names neither rule at all
  (`FINDING ADR21-1`).
- *"`REQ-902` is instrumented."* — By a per-run **sample**, with the capability
  bounds of §4.5 and a negative control proving the comparator is live. Not a
  proof, and the honest form of the claim is a count of observations.

### 7.3 Debts this ADR creates, each with an owner

| debt | owner | trigger |
|---|---|---|
| `docs/PROCESS.md` §2.5's blanket sentence, corrected to state that CI **evaluates** every rule and that two are evaluated with a lesser posture, naming them | architect_docs_lead | the council-verdict revision round already queued at `J-orchestrator-0265` |
| `docs/specs/requirements.md` `REQ-902` verification column (§4.7 item 3) | architect_docs_lead | the commit that lands the `build.yml` step |
| `agents/PROTOCOL.md` §5's enumeration — `R10`, `R11`, and the size limb (`FINDING ADR21-1`) | orchestrator | its own round, or the implementing act; ADR-0017 §8.2 plus §3.5's table is the draft |
| `agents/journals/INDEX.md`, noticed while enumerating chains and unrelated to this ADR: it records `J-orchestrator-0012` as the orchestrator's last entry (actual: `-0265`), three leads as *"not yet activated"*, and has no volume column at all — ADR-0017 §8.4 asked for one | orchestrator | next gate boundary; PROTOCOL §9 makes it best-effort, so this is a note, not a finding |

### 7.4 The commands behind every number in this file

Run at `b19ff91`, read-only, reproducible from a checkout:

```sh
# 1 — stamp census: per commit, the appended entry's stamp vs the commit's author time
for C in $(git rev-list --reverse HEAD); do
  [ "$(git rev-list --parents -n 1 "$C" | wc -w)" -gt 2 ] && continue
  at=$(git log -1 --format=%at "$C")
  hdr=$(git diff-tree -p --root --no-commit-id -r "$C" -- agents/journals/ \
        | grep -m1 -E '^\+## \[J-[a-z_]+-[0-9]{4}\]')
  eid=$(printf '%s' "$hdr" | grep -oE 'J-[a-z_]+-[0-9]{4}' | head -1)
  st=$(printf '%s' "$hdr" | grep -oE '[0-9]{4}-[0-9]{2}-[0-9]{2}T[0-9]{2}:[0-9]{2}(:[0-9]{2})?Z' | head -1)
  echo "$eid $(( $(date -u -d "$st" +%s) - at ))"
done
#  -> 600 entries, 371 outside +/-3600 s, 0 unparseable, per-chain table of section 2.4

# 2 — active-volume size census (needs policy.sh's resolvers)
. scripts/policy.sh
for C in $(git rev-list --reverse HEAD); do
  a=$(git log -1 --format=%B "$C" | git interpret-trailers --parse | sed -nE 's/^Agent: //p' | head -1)
  J=$(active_journal_for "$a" "$C"); echo "$a $J $(git cat-file -s "$C:$J")"
done
#  -> 95 commits over S, 48 over H, 18 distinct (agent,volume) over S, 1 over H

# 3 — the reference clock is single and monotone
git log --format='%at %ct' | awk '$1!=$2{d++} END{print NR, d+0}'    # -> 600 0

# 4 — FINDING ADR21-1
grep -c -E 'R10|R11|volume|rotate' agents/PROTOCOL.md                # -> 0
grep -c -E 'JOURNAL_SOFT_MAX|JOURNAL_HARD_MAX' scripts/check_journals.sh  # -> 0
```

---

## 8. The PROTOCOL sentences this ADR would add — written, NOT applied

Offered only because `FINDING ADR21-1` needs a draft to be actionable. **This
ADR does not amend PROTOCOL and its route does not include one.** These two
sentences join ADR-0017 §8.2's `R10` text, which is still unapplied:

`R10` gains: *"The active volume's size is bounded: above `JOURNAL_SOFT_MAX` the
commit script warns, above `JOURNAL_HARD_MAX` it refuses and names the rotation.
CI evaluates the same bound over history and reports it as a warning, because a
permanent red is proportionate to harm that persists in every future reader and
an oversized volume's harm is bounded by one file's readability, with its cure
available prospectively to its owner — where `R11`'s blob gate refuses on
exactly the opposite proportionality."* *(Cured per J-dv_lead-0189 §2.1 before
any constitutional application: the first draft recited the refuted
remedy-ground, and adopting it would have written into the constitution a
principle its own `R11`, two paragraphs later, breaks.)*

`R11` (new, retro-naming what `check_journals.sh` already enforces): *"**R11 —
CI blob gate.** `check_journals.sh` re-verifies ADR-0002's blob threshold over
every commit, with journals carved out per `R10`."*

And §5's CI paragraph, currently *"re-checks `R1`–`R8`"*, becomes *"re-checks
`R1`–`R8` and `R10`–`R11`, and emits advisory `WARN-STAMP`/`WARN-JOURNAL`
counters that never affect its verdict."*

---

## 9. PROTOCOL §11 — the route, and what "in force" means per subject

§11(1) is this file. §11(2) is the orchestrator's journal entry at
implementation. §11(3) is the scenario set, owed where enforcement semantics
change and explicitly not owed where they do not (§4.7).

| subject | changes | countersignature required | in force when |
|---|---|---|---|
| **1 — `WARN-STAMP`** | `policy.sh`, `agent_commit.sh`, `check_journals.sh`, `test_protocol.sh` | **dv_lead** on the design; **auditor** on this subject — `R-0020-1` is its recommendation, the band is its measurement, and constraints (i)–(iii) are its wording | the orchestrator's §11(2) acceptance entry **and** `S40`–`S46` green in the suite |
| **2 — `R10` size on CI** | `check_journals.sh`, `test_protocol.sh` | **dv_lead** (the both-surfaces corollary is its rider, one level up). Auditor **not required**; its constraint (iii) is honoured, not adjudicated | acceptance entry **and** `S47`–`S49` green |
| **3 — `REQ-902` step** | `.github/workflows/build.yml` | **rtl_lead**, on §4.1–§4.5 as a **factual check that its derivation is transcribed and not misstated** — blocking for this subject only, so subjects 1, 2 and 4 do not wait on it | acceptance entry **and** the first green run of the step, cited by id (`REQ-906`) |
| **4 — `REC-5`** | nothing mechanical; §5.4's evidence form | **dv_lead**, whose finding and whose seat this is | the acceptance entry alone; the procedure is the committer's practice from `a76e485` and this file records it |

**Countersignature form**, per PROTOCOL §7's convention: a journal entry of the
signing seat that says which sections it signs and what, if anything, it
contests. A contested section is redrafted before acceptance, as ADR-0020's
(b.1) was twice.

**`FINDING ADR21-1` is on no subject's route.** It is raised for the
orchestrator to route or refuse, and this ADR's force does not depend on it.

---

## 10. What this ADR does not decide

- **Whether the ±60 band is right.** It is the decided band, measured by the
  auditor at 0/16 against known-good behaviour. §2.5's F5 records the asymmetry
  and §6 exposes both bounds as parameters so a correction is a policy edit.
- **Whether stamps should be checked for anything other than drift.** Format
  strictness, a canonical precision, a required suffix — all untouched. One of
  600 stamps carries a self-declared estimate qualifier and this design admits
  it deliberately (§2.2).
- **Whether `agent_commit.sh` should ever refuse on a stamp.** No, by the
  decision and by `R3`; a later round wanting it would be reversing constraint
  (i) and needs its own ADR.
- **Whether `R10`'s `H` should refuse in CI.** Decided as a warning with grounds
  at §3.4; the grounds are the appealable object.
- **Whether hash-order determinism is required of the emitter.** §4.5 names the
  `OCAMLRUNPARAM=R` probe, declines it for a stated reason, and leaves the spec
  reading open.
- **Whether the constitution should enumerate `R10`/`R11`.** Raised as
  `FINDING ADR21-1` with draft text at §8, routed to the seat that owns the file.
- **Anything about `docs/PROCESS.md`'s revision** beyond naming the one sentence
  this round proves false. That document's round is queued and is not this one.
