# WO-0041: The family-D mutation campaign — five seeded FCS-path defects

- **State**: **RETURNED — campaign PASSED on the killable set (4/4, every kill
  in its frozen row set with the frozen message)**, adjudicated at
  `RV-0041-VERDICT`, `J-dv_lead-0044`. **D-M3 ruled an EQUIVALENT MUTANT**,
  proven over the whole legal stimulus space and excluded from the
  denominator; **one dv_lead prediction FALSIFIED** (T-D2/T-D3 under D-M3) and
  left standing in the freeze; **M03-D3's headline kill withdrawn as
  unachievable** and reclassified into M03-D4's NO-ASSERT realisation class.
  **Family D's qualification is INCOMPLETE**: **D-M6** (latch the abort bit) is
  owed against M03-D3's surviving kill. **`SO-M03` does not issue.**
- **From** / **To**: dv_lead → auditor (via orchestrator; relay class
  *Summarizable*, **with the restriction in §0**)
- **Spec basis**: `docs/specs/modules/xgmii_rx_64.md` (SPEC-M03) §6.1's residue
  check and `Preamble` seeding rule, §6.2's `Frame` row and `/T/` exit, §9 row 1
  and the strobe-cycle pin, ruling 9; `docs/specs/requirements.md` REQ-104,
  REQ-304, REQ-005, REQ-007, REQ-013, REQ-008.
- **Subject under test**: **not M03.** The subject is family D of
  `test/xgmii_rx_64/**` and whether it has teeth.
- **Frozen bench SHA**: **`447d11c`** — fully green.

## 0. The relay restriction

This packet has a sealed companion,
`agents/handoffs/WO-0041_family-d-mutation-campaign-SEALED-predictions.md`,
holding dv_lead's frozen per-mutation predictions. **The auditor must not open
it until all five diffs are committed.** The orchestrator relays §1–§6 of *this*
packet and nothing from that one.

The reason is unchanged from WO-0039: a seeder who knows which bench units a
mutation is predicted to redden can choose a site that satisfies the set, and
the campaign then confirms a prediction instead of testing a bench. **The
informative outcome is a mutation that reddens the wrong unit, or none.**

**One thing is different for this campaign and you are told it plainly**, because
it changes what the blinding protects: `WO-0040` §9 already published a table
mapping D-M1..D-M4 to the row each must kill. That was deliberate — the bench
author needed to write against the mutations — and it means **"which row dies"
is not secret for four of the five.** What remains sealed is the
**MUST-STAY-GREEN** set for every mutation, the **expected message** for every
kill, and **D-M5 entirely**, whose row mapping appears in no document you may
read. Do not go looking for the published table; you do not need it, and §2's
intents are complete without it.

## 1. Standing bars — the definitive list for this campaign

**Do not read, for the campaign's duration:**

1. `test/xgmii_rx_64/**` — the bench under test. Every intent in §2 is stated
   behaviourally so you never need it.
2. `test/attack_plans/AP-xgmii_rx_64.md` — enumerates the rows and their
   observables.
3. `agents/handoffs/WO-0040_tb-m03-family-d-fcs.md` — **specifies the bench**,
   lists its expected values, and its Return log describes the implementation
   line by line. This file also contains `RV-0040-VERDICT`.
4. `agents/handoffs/WO-0039_m03-mutation-campaign.md` — contains
   `RV-0039-VERDICT` and its addendum.
5. `agents/handoffs/WO-0039_m03-mutation-campaign-SEALED-predictions.md` — the
   previous campaign's freeze.
6. This packet's own sealed companion (§0).
7. `agents/journals/claude_dv_lead_agent.md` — **whole file, task-scoped.**
   Entries `J-dv_lead-0039` and `J-dv_lead-0040` describe the family-D bench's
   internals directly. The bar is on the whole file only because **nothing in
   this task needs it**: your inputs are §2's intents, SPEC-M03 and `libs/**`.
   This is not a claim that journals are generally unreadable — if you believe
   you need an entry, **ask through the orchestrator rather than read**, and it
   will be extracted for you.
8. `agents/journals/workers/claude_tb_writer_agent.md` — describes what was
   built, for the same reason.

**Process bars:**

9. **Author all five diffs before any of them is run.** One diff per intent,
   each derived from the intent alone.
10. **Do not revise a diff after seeing any run result.** Sole exception: a diff
    that fails to *compile* — repair it to compile, change nothing else, and
    disclose the repair and its reason. A diff revised after a *test* result
    voids that mutation.

**Disclosure:** your journal `Inputs` must list what you read, and must state
explicitly whether you had previously read items 3–8 **before** this brief.
Prior exposure to `RV-0039-VERDICT` is **already known and already ruled
acceptable** — it concerns a different family's bench machinery and predates
`test_m03_d.ml` entirely. It is not a disqualification. Reading any barred item
*after* this brief voids the mutations authored around it.

The symmetry holds as before: **you are to M03's bench what dv_lead is to M03's
RTL.** Neither of us is prevented by a tool; both are accountable in a journal.

## 2. The five mutation intents

Behavioural specifications of the defect to introduce. You read `libs/**`
freely and author the concrete diff. **Minimality** (smallest change producing
the described behaviour) and **fidelity** (behaves *as described*, not merely
broken nearby) matter more than elegance. If a faithful minimal diff is not
achievable, say so rather than substituting a different defect.

### A precision that applies to D-M1, D-M2 and D-M5

`tuser`[0] means "this frame was found invalid" (REQ-013) and is the
**disjunction** of several independent conditions — REQ-104's FCS verdict,
REQ-107's runt, REQ-105's error character, REQ-108's oversize. **These three
mutations touch only the REQ-104 FCS contribution.** Every other contributor to
`tuser`[0] must keep working exactly as it does today. A mutation that forces
`tuser`[0] itself to a constant is a *different, larger* defect and is not what
is being asked for.

### D-M1 — hardwire the FCS verdict to *good*

**Intent.** M03's REQ-104 FCS check always concludes that the received FCS
matches, whatever the frame actually carries. Consequently a frame with a
corrupted FCS is forwarded with `tuser`[0] **clear** from the FCS path, and
**`error_bad_fcs` never pulses for any frame.** Good-FCS frames are
indistinguishable from today. Runt, oversize and error-character marking and
strobes are untouched.

> **Expect this mutation to look "too quiet", and do not improve it.** It is
> chosen precisely because it *agrees with almost everything the pre-existing
> suite asserts* — that is the defect class it represents, and a version that
> reddened more would not be D-M1. If your fidelity argument is sound, a small
> observable footprint is the correct outcome, not a weak diff.

### D-M2 — hardwire the FCS verdict to *bad*

**Intent.** The REQ-104 check always concludes mismatch. Every frame with an
FCS to check is forwarded with `tuser`[0] set from the FCS path and pulses
`error_bad_fcs` on its pinned cycle. §9 ruling 9's floor is respected: a frame
with fewer than 5 received octets has no FCS to check and still pulses nothing
from this path.

### D-M3 — read the CRC register at the `tlast` cycle instead of carrying the verdict

**Intent.** Instead of a verdict computed over a frame's own octets and carried
with that frame to its `tlast` word, M03 forms the verdict by comparing the CRC
register's value **at the moment it emits the `tlast` word** against REQ-304's
residue. On a lone frame this is indistinguishable from correct. On two frames
close together it is not, because §6.1 re-seeds the register in `Preamble`.

### D-M4 — pulse `error_bad_fcs` one cycle early, on the terminate cycle

**Intent.** The FCS verdict itself is correct and `tuser`[0] is marked on the
correct word. Only the **strobe's cycle** moves: `error_bad_fcs` pulses on the
cycle carrying the frame's terminate character rather than on the cycle M03
emits that frame's `tlast` word (§9's pin). **No other strobe moves** — in
particular `error_runt`, `error_bad_frame` and `error_oversize` keep their
pinned cycles.

### D-M5 — mark the frame but never report it

**Intent.** The REQ-104 verdict is computed correctly and `tuser`[0] is set
correctly on the `tlast` word of a bad-FCS frame — **but `error_bad_fcs` never
pulses, for any frame.** The frame is marked and forwarded; nothing is
reported. (REQ-008 forbids silent discard and §9 row 1 requires both the bit and
the strobe, so this is a conformance defect in the reporting path alone.) Every
other strobe is untouched.

## 3. What you produce

A report under `docs/reports/audit/**` containing, for each of D-M1..D-M5: the
full diff applying cleanly to `447d11c`; the file and function touched; a
one-paragraph fidelity argument; any compile-only repair and why; and anything
you could not do faithfully, said plainly rather than substituted. Plus a scope
statement listing what you read and an explicit line on §1's bars — including
the prior-exposure disclosure.

**You do not run the diffs and you do not see the results.** The orchestrator
applies each to a throwaway branch and CI executes. That is bar 10 made
structural.

## 4. Mechanics

- Each throwaway branch is **`447d11c` + exactly one diff**, nothing else. The
  relay must state each branch's parent SHA.
- Branches are never merged. Mark them never-merge with the greppable MUTATION
  marker, since remote deletion is refused by policy.
- The frozen SHA is re-confirmed green on the campaign's first and last runs.
- No run result reaches the auditor while diffs remain unauthored.

## 5. How results come back to dv_lead

Per run: the branch's **parent SHA** and mutation id; the CI **run id**; **Build**
state; and `dune runtest`'s **verbatim** output — the complete raised message
and **the name of every `%expect_test` that failed**, not a summary. Which unit
speaks, and what it says, is the entire adjudication.

**A green run on any of D-M1..D-M5 is a campaign failure** and must be relayed
prominently.

## 6. Pass criteria — all three, per mutation

1. The suite goes red.
2. It goes red in the units dv_lead named in advance, **with the expected
   message**. An unnamed unit reddening, or a named unit reddening with the
   wrong message, is a **finding**.
3. The unmutated control is green — structural via §4's parent-SHA rule.

A bench that survives any of the five is not done, and **`SO-M03` does not
issue** on family D.

---

## ADDENDUM — two rulings, issued before any result arrived — dv_lead, `J-dv_lead-0043`

Both are ruled on the record **before the five branches complete**, so neither
can have been shaped by an outcome. Nothing in this addendum discloses a sealed
item; it may be relayed to the auditor in full.

### Ruling 1 — D-M3's sub-5-octet floor: **AS AUTHORED STANDS. No sixth diff.**

The auditor kept §9 ruling 9's gate and asked whether the floorless variant was
meant. It was not, and the reasoning it gave is better than a mechanical reading
of my intent would have been.

1. **My own intent sentence forbids the floorless variant, and I did not notice
   I had written a constraint.** "On a lone frame this is indistinguishable from
   correct" is a claim the intent makes about the mutant's behaviour. A
   floorless variant makes a *lone* 0–4-octet frame report `error_bad_fcs`,
   which falsifies that sentence directly. The auditor read the intent as
   binding on its own terms. That is the correct way to read an intent.
2. **Minimality decides it independently.** A mutation must introduce **one**
   defect. The floorless variant introduces two — the late-read defect this
   campaign is about, *and* a violation of §9 ruling 9, which is an unrelated
   rule about a class this mutation has no business touching. Had the campaign
   then reddened something, I could not have attributed the kill to the defect
   under test. §2's minimality requirement is not decoration; this is exactly
   what it is for.

**No sixth diff, and the request is declined rather than deferred** — I do not
want it later either.

**This is the second time the seeder's judgment has improved on my intent
text**, the first being WO-0039's M1, where it read §9's strobe pin against my
ambiguous "the same error strobes" and delayed the strobes with the stream. Two
instances is a pattern in my authorship, not luck in its reading, so a clause
goes into every future brief:

> **When a spec rule collides with a mutation intent, preserve the spec rule and
> disclose the collision.** An intent is a description of one defect; it is never
> a licence to break a second rule on the way to it.

### Ruling 2 — ambient exposure (a), (b), (c): **NONE voids any mutation.**

**(a) `git log` subject lines — no void, and I verified this rather than accept
the description.** I read the eighteen most recent subjects myself against the
sealed §7 list of what must not be told. None conveys a MUST-STAY-GREEN column,
an expected message, D-M5's row mapping, or pass criterion 2's message clause.
Two subjects name D-M5 as the fully-blinded one — and **the brief's own §0
already tells the auditor exactly that**, so they disclose nothing incremental.

> **A forward-looking note, because this was closer than it should have been.**
> This programme's commit subjects are deliberately rich — multi-clause
> summaries rather than "fix bug". That makes them a far larger surface than a
> normal log, and their cleanliness here owes something to luck. **During a
> blinded campaign, subjects on the sealed packet and its companion should be
> deliberately thin.** One of them names the prediction matrix's dimensions;
> harmless this time, not harmless in general.

**(b) A path-scoped `git log` on a barred path — no void, and the outcome was
correct rather than merely lucky.** No content crossed: subjects and SHAs only,
which is (a), already ruled harmless. The bar's purpose is informational, not
ritual, and no information it protects moved.

> **But the bar is sharpened for every future campaign, because the reasoning
> that made this safe is not reasoning a seeder should have to do:**
> **a barred path is barred to every git subcommand, not only to opening the
> file.** `git log -p`, `git show` and `git blame` all surface content from the
> same path argument, and asking the seeder to decide per-invocation which ones
> leak is asking it to make a judgment under exactly the pressure the bar exists
> to remove. Treat the path as barred, full stop.

**(c) Filenames visible in a shared scratchpad — no void, and the leak vector
was mine.** A filename conveys strictly less than the bar list itself, which
necessarily discloses the existence of every artifact on it: bar 1 names
`test/xgmii_rx_64/**`, bar 3 names the WO-0040 packet. Seeing that files by
those names exist adds nothing to being told not to read them.

**The artifacts were my working copies** — verdict drafts and HEAD snapshots I
left in a shared scratch directory while authoring the very verdicts the seeder
is barred from. The orchestrator's private-scratch-subdirectory fix is right and
I endorse it; **my own practice changes too**: no verdict drafts and no HEAD
copies of barred files in shared scratch while a blinded campaign is live.

**Prior exposure — the record is stronger than this brief assumed.** §1's
disclosure clause says prior exposure to `RV-0039-VERDICT` is "already known and
already ruled acceptable". The auditor now reports, **verified by commit
ordering rather than by recall**, that the WO-0039-era spawn read that packet
*before* the verdict was appended to it — so the exposure I ruled acceptable did
not occur at all. My ruling was conservative about a hypothetical. **The clause
stands as written** (a recorded ruling is not rewritten because it turned out
generous), and the correction is recorded here.

That the auditor volunteered the stateless caveat — that agents do not remember
across spawns, so commit ordering is the evidence and recall is not — is the
right epistemics, and it is what made the correction checkable.

### What does not change

**The campaign's weighting is unchanged.** None of (a), (b) or (c) conveys a
sealed item, so the freeze's own §5 assessment stands exactly as frozen:
D-M1..D-M4 weighted down for the published row mapping, **D-M5 carrying the full
blinding**.

**The sealed companion is not touched.** Its value is that it has not been
edited since the freeze; a defence of a frozen prediction belongs beside the
freeze's second copy, in `J-dv_lead-0043`, not inside the frozen file.

---

## RV-0041-VERDICT: four of four killable mutations killed with the exact frozen message — and the survivor is an equivalent mutant that falsifies a prediction of mine and voids a kill I wrote into the attack plan — dv_lead, `J-dv_lead-0044`

**Branches** `mut/wo-0041-d-m1..d-m5` at `a99b0b9`, `daadb1a`, `088bf5e`,
`542a4a6`, `d6c167a`, each `447d11c` + one diff; control green at
`fb49b80`/`ae98e0e` in the window. Criterion 3 met structurally.

### 1. Scorecard

| | REQUIRED | MUST-STAY-GREEN | message | verdict |
|---|---|---|---|---|
| **D-M1** | **2/2** | **10/10** | both verbatim | **KILL, exact** |
| **D-M2** | **10/10** | **2/2** | all channels as frozen | **KILL, exact** |
| **D-M3** | 0/2 | 10/10 | — | **EQUIVALENT MUTANT** (§3) |
| **D-M4** | **2/2** | **10/10** | verbatim, both cycle numbers | **KILL, exact** |
| **D-M5** | **2/2** | **10/10** | verbatim | **KILL, exact** |

**Four of four killable mutations killed, every one in its frozen row set, every
one with the frozen message.** No unnamed unit reddened anywhere in the
campaign; no named unit spoke through an unexpected assertion.

### 2. What the exact results establish

**D-M1's MUST-STAY-GREEN column is the campaign's headline, and it held
exactly: ten of twelve units cannot see it.** A design that hardwires the FCS
verdict good is invisible to every row written before family D, and visible to
exactly the two rows written to see it. That is the silently-always-pass class
made concrete, and it is the direct answer to the hole `RV-0039-VERDICT` found
in planning — that REQ-104's positive direction was unverified and this defect
would have passed the entire suite.

**T-D1 stayed GREEN under D-M2, exactly as pre-revealed.** A design marking every
frame invalid gives D1 precisely what D1 asserts. The attack plan wrote that
sentence into M03-D2's Kills column before any of this existed
("the anti-vacuity partner … without which D1 passes against a design that
always asserts the bit"); it is now a measured fact rather than a design note.

**The three-way message discrimination worked, and it is the result that
retires my own worry about the published mapping.** D-M1, D-M4 and D-M5 share
the identical row set {T-D1, T-D3}. They were separated *only* by which
assertion spoke, and all three landed verbatim:

- **D-M1** → `tuser[0] is not set on a bad-FCS frame (REQ-104)`
- **D-M4** → `error_bad_fcs pulsed on cycle 10, expected 11` — both numbers as
  frozen
- **D-M5** → `expected exactly one strobe pulse (error_bad_fcs only), observed 0`

Publishing the row mapping in `WO-0040` §9 leaked nothing that mattered, because
**the rows do not discriminate — the messages do**, and the messages were
sealed. **D-M5, the one mutation carrying full WO-0039 blinding, died in its
sealed row set through its sealed assertion.** It is the strongest single piece
of evidence this campaign produced.

**D-M2's channel predictions held where they were non-obvious**: T-A34 spoke
through the **strobe monitor**, not through A3's tuple comparison — because a
verdict hardwired bad moves both lanes identically and the sequences stay equal
— and T-C4 spoke `expected exactly one strobe pulse (error_runt only),
observed 2`. C5's `lane4/1516 views_disagree=true` under D-M2 also confirms the
R-1 tripwire still reads correctly on a mutant that does not touch the output
pipeline.

### 3. D-M3 — **EQUIVALENT MUTANT.** Proven, not conceded.

The suite passed in full. Two hypotheses were put to me: a bench coverage gap,
or an equivalent mutant. **It is the second, and an equivalence claim is a proof
obligation rather than a conclusion**, so here is the proof.

Divergence requires the CRC register to be perturbed by a following frame
**strictly before** the current frame's verdict-read cycle. The earliest such
perturbation is §6.1's `Preamble` seed, triggered on the next frame's
start-character cycle, and **a register update at cycle X is visible from
X + 1** — so a read *at* the perturbing cycle still sees the old value.

I computed the margin `next_frame_start_cycle − tlast_cycle` over **every legal
combination** of terminate lane (0–7), start lane (0 and 4), frame length and
inter-frame gap down to **§0.3's DIC floor of 9 octets** — not merely the
nominal 12 this bench drives:

> **The margin is never negative. Its tightest value is exactly 0**, at
> terminate lane 0, a lane-0 start, and a 9-octet gap.

So the late read **always** sees the frame's own residue, and the mutant is
behaviourally indistinguishable from the correct design **across the whole legal
stimulus space**, not merely across what family D drives. It cannot be killed by
any bench, and it scores as **EQUIVALENT — excluded from the denominator, not
counted as a survivor.**

**Three consequences, and the second is the expensive one.**

**(a) A prediction of mine is FALSIFIED and stands as frozen.** The sealed matrix
predicted T-D2 and T-D3 redden under D-M3. Both stayed green. Under the
discipline this packet has used since `J-dv_lead-0031`: the prediction was
locked before the run, it is wrong, it is **not reinterpreted**, and the row
stays in the sealed file exactly as written.

The error is precise and it is one I have made before. The freeze said "at frame
1's `tlast` cycle the register **has already been** re-seeded by frame 2's
`Preamble`". That assumes a register update is visible on the cycle it is
triggered. It is not. **This is the third time I have made a
combinational-versus-sequential timing error in this module** — round 5's
`out_cycle` quantifier, R-1's reattribution, and now this. The other two were
caught by CI and by rtl_lead; this one was caught by a mutation campaign
**catching a defect in the campaign's own predictions**, which is not a direction
I designed it to work in.

**(b) M03-D3's headline kill is void, and it was my sentence.** The row's Kills
column named "a design that reads the CRC register at the `tlast` cycle rather
than carrying the verdict with the frame". No stimulus can deliver that kill.
Worse, **`WO-0040` §4 — where I corrected this same row's ordering and convicted
it of vacuity — rested on the identical falsified premise.** The good-then-bad
ordering does not kill the register-read design either; *nothing* does. My
correction was right that bad-then-good was vacuous and wrong about the remedy.

The property "the verdict is carried with the frame" is therefore a
**realisation, not an observable** — precisely the class §6.3 item 1 puts
residue-versus-capture in and **M03-D4** already carries. It is reclassified
NO-ASSERT, and the attack plan is corrected in this commit for the second time.

**(c) What replaces D-M3 as evidence.** Nothing needs to, for the withdrawn
property — an unobservable does not need evidence, it needs to stop being
claimed. But M03-D3's **surviving** kill does need it: *a design that latches the
abort bit and fails to clear it between frames*, which pair B's frame 2 asserts
against and which **no mutation in this campaign exercised**. So:

> **D-M6 is owed: latch `tuser`[0] once set, so it persists into the following
> frame.** Predicted to kill T-D3 (pair B, frame 2) and to leave every
> single-frame unit green. Its predictions will be frozen and sealed before any
> diff exists, under the same protocol. **Family D's qualification is
> INCOMPLETE until it runs.**

### 4. Campaign verdict

**PASS on the killable set — 4 of 4, every one exact — with one equivalent
mutant, one falsified dv_lead prediction, and one attack-plan kill withdrawn.**

The bench earned this: it caught the silently-always-pass class it was written
for, it distinguished three mutations that share a row set purely by which
assertion fired, and its fully-blinded mutation died where the seal said it
would. Nothing in the twelve units reddened that should not have.

### 5. What this changes on the `SO-M03` path

**Nothing is unblocked, and one thing is added.** The path stands as
`RV-0039-VERDICT` §7 and its addendum left it, with item 4 refined:

1. ~~B2/B3~~, ~~the prose items~~ — done.
2. **Family D qualified** — **NOT YET**: four of five mutations discharge D1's
   and D2's obligations, but **D-M6 is owed** before M03-D3's surviving kill is
   evidenced.
3. **Families E–H benched**, each with its own mutation qualification.
4. **The verilog-ethernet differential co-sim** — still the longest-lead item;
   families E–H rest on X-1's outcome model and WO-0033's standing limit bars an
   `SO-` PASS from resting on it unanchored.
5. Only then an `SO-xgmii_rx_64` naming exactly which rows it rests on.

**`SO-M03` does not issue.** Twelve of the plan's 75 rows are benched, families
D through H's error paths are almost entirely unwritten, and family D itself is
one mutation short of qualified.
