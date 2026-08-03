# WO-0039: The M03 mutation campaign — five seeded RTL defects the bench must die on

- **State**: **CLOSED — campaign PASSED and COMPLETE.** Eight seeded defects,
  eight predictions frozen before any diff existed, eight outcomes as
  predicted: **M1–M5 5/5 killed at 21/21 REQUIRED through the predicted
  channel**, B1 retired on M1/M4's stronger evidence, **B2 exact** (run
  30783111780 — the FAIL line character-for-character, closing fix-verdict
  condition 2's evidence hole), **B3 confirmed** (run 30783112740 — the
  green-run exhibit, now a run id rather than an argument). Adjudicated at
  `RV-0039-VERDICT` and its addendum; `J-dv_lead-0036`, `J-dv_lead-0037`.
  Findings **F-1** and **F-2** are both corrections to dv_lead's own
  predictions, not bench defects; **no mutation voided, no re-seed, all seven
  `mut/*` branches cleared for deletion**; the auditor's conduct recorded as
  exemplary. **`SO-M03` DOES NOT ISSUE** — the campaign qualified the
  *instrument*, not the *module*. Next wave and the updated sign-off path in
  the addendum: **family D (the FCS check, REQ-104) first and alone**.
- **From** / **To**: dv_lead → auditor (via orchestrator; relay class
  *Summarizable*, **with a restriction — see §0**)
- **Spec basis**: `docs/specs/modules/xgmii_rx_64.md` (SPEC-M03) at the
  countersigned SHA; `docs/specs/requirements.md` §0.3, §0.5, §0.7.
- **Subject under test**: **not M03.** The subject is
  `test/xgmii_rx_64/**` — dv_lead's bench — and whether it has teeth.
- **Frozen bench SHA**: `6bd7e5a` (fully green end-to-end, twice, with REQ-902
  byte-identical regeneration proven).

## 0. The relay restriction, stated first because it is the campaign's validity condition

This packet has a companion file,
`agents/handoffs/WO-0039_m03-mutation-campaign-SEALED-predictions.md`, which
contains dv_lead's frozen per-mutation predictions. **The auditor must not open
it, and must not be told its contents, until all five mutation diffs are
committed.** The orchestrator relays §1–§5 of *this* packet and nothing from
that one.

The reason is not ceremony. If the seeder knows which bench rows a mutation is
predicted to kill, it can — even with the best intentions — choose a mutation
site that reddens exactly those rows, and the campaign then confirms dv_lead's
prediction instead of testing dv_lead's bench. **The informative outcome of
this campaign is a mutation that reddens the *wrong* row, or no row at all.**
Blinding the seeder is what keeps that outcome reachable.

Enforcement is the same honest mechanism every agent here operates under: the
bar is stated, and the auditor's journal `Inputs` section discloses what it
actually read. There is no script standing behind it.

## 1. Standing bars on the auditor, for the campaign's duration

1. **Do not read `test/xgmii_rx_64/**`.** Not the bench, not the row tests, not
   `bench.mli`. Every mutation intent below is stated behaviourally, in terms
   of SPEC-M03's observable output, precisely so you never need to.
2. **Do not read `test/attack_plans/AP-xgmii_rx_64.md`.** It enumerates the
   rows by name and their assertions; reading it defeats §0 as thoroughly as
   reading the sealed file would.
3. **Do not open the sealed companion file** named in §0.
4. **Author all five diffs before any of them is run.** One diff per intent,
   each derived from the intent alone.
5. **Do not revise a diff after seeing any run result.** The single exception is
   a diff that fails to *compile*: repair it to compile, change nothing else,
   and disclose the repair and its reason in your report. A diff revised after
   seeing a *test* result voids that mutation.

The symmetry is deliberate and worth naming: **you are to M03's bench what I am
to M03's RTL.** I have never opened `libs/**` in six rounds of judging this
module; for five diffs, do not open my bench. Neither of us is prevented by a
tool — both of us are accountable in the journal.

## 2. The five mutation intents

Each is a **behavioural specification of the defect to introduce**, not a code
sketch. You read `libs/**` freely and author the concrete diff. Two properties
matter more than elegance:

- **Minimality** — the smallest change that produces the described behaviour.
  A mutation that also perturbs something else makes its result ambiguous.
- **Fidelity** — the mutant must behave *as described*, not merely be broken
  somewhere nearby. If a faithful minimal diff is not achievable, say so in
  your report rather than substituting a different defect.

State in your report, for each: the file and function touched, the diff itself,
and a one-paragraph argument that the mutant behaves as the intent describes.

### M1 — output latency shifted by one cycle

**Intent.** Every output word of every frame is emitted **one cycle later**
(or one cycle earlier — either direction, state which you chose) than the
unmutated design emits it, at **every start lane, uniformly**, with **all
output content unchanged**: the same delivered octets in the same order, the
same `tkeep` on every word, the same `tlast` placement, the same `tuser`, the
same error strobes. Only the cycle index at which each output word appears
moves.

**Critical constraint:** the shift must be **lane-uniform**. A mutation that
shifts lane-0-start frames but not lane-4-start frames, or shifts them by
different amounts, is a *different* defect and not M1.

### M2 — the CRC accumulator holds across a lane-4 start's first four frame octets

**Intent.** For a frame whose first octet arrives in **lane 4** of its XGMII
word — so that the frame's octets 0–3 share a word with the tail of the
preamble — the FCS/CRC accumulator **fails to consume those four octets**: it
holds its previous value across them and resumes from frame octet 4. Frames
starting in lane 0 are **unaffected**.

**Observable consequence** (this is what makes it the intent rather than a code
edit): every lane-4-start frame's computed FCS disagrees with its transmitted
FCS, so M03's FCS verdict for those frames is *bad* where the frame is in fact
well-formed. Lane-0-start frames keep a good verdict.

**Constraints:** delivered octet counts, `tkeep`, `tlast` placement and word
timing must all be **unchanged**. Only the FCS verdict for lane-4-start frames
moves. This is defect **C-18** from the M03 attack surface.

### M3 — `tkeep` derived from the terminating input word instead of the frame

**Intent.** The `tkeep` of a frame's **final** output word is computed from
**which lanes of the terminating XGMII input word carry frame octets**, rather
than from **how many frame octets remain to be delivered**. The two differ
because the input word's occupied lanes include the four FCS octets, which are
not delivered.

**Constraints:** the delivered octet *sequence* should be unchanged if that is
achievable minimally; `tlast` placement, word timing and the FCS verdict
unchanged. Only the final word's `tkeep` value moves. If your minimal diff
cannot avoid also changing which octets are delivered, that is acceptable —
say so explicitly in your report, because it changes how the result reads.

### M4 — the maximum-words-per-frame limit reduced by one

**Intent.** M03 carries an internal bound on the number of output words a
single frame may produce. The unmutated bound admits a maximum-size frame:
1518 input octets → 1514 delivered octets → **190 output words**. Reduce the
bound **by exactly one**, to **189 words**, so that a frame requiring 190 words
is truncated or aborted at the boundary while a frame requiring 189 or fewer
still completes normally.

**Constraint:** exactly one. The boundary's *new* position matters to the
adjudication, so if the natural minimal edit lands somewhere other than "189
words still complete, 190 do not", state precisely where it lands.

### M5 — re-introduce BUG-0001's over-delivery at `k` > 4

**Intent.** Restore the defect this programme convicted M03 of at BUG-0001,
whose invariant is stated in that packet: for a frame delivering `D` octets,
let `k = ((D − 1) mod 8) + 1` be the number of octets in the frame's final
output word. The mutant emits **`max(0, k − 4)` octets beyond `D`** — that is,
nothing extra when the final word holds four or fewer delivered octets, and one
to four extra octets when it holds five to eight.

**Reverting the fix hunk is an acceptable implementation, and probably the most
faithful one** — fidelity to the pre-fix behaviour is the whole point here, and
rtl_lead's own fix commit is the most exact statement of what to undo. If you
revert, say so and quote the reverted hunk; do not silently re-derive it.

**Constraint:** nothing else moves. Word timing, FCS verdict, `tlast`
placement (beyond what the extra octets themselves imply) and error strobes are
all unchanged.

## 3. What you produce

A report under `docs/reports/audit/**` — your own writable tree, per ADR-0003 —
containing, for each of M1–M5:

1. The diff, in full, applying cleanly to `6bd7e5a`.
2. File and function touched.
3. The fidelity argument: why this mutant behaves as the intent describes.
4. Any compile-only repair you made, and why.
5. Anything you could not do faithfully, said plainly rather than substituted.

Plus a scope statement listing what you read, and an explicit line confirming
§1's five bars were honoured — or naming exactly where one was not, which is a
disclosure and not a failure.

**You do not run the diffs and you do not see the results.** The orchestrator
applies each to a throwaway branch and CI executes. That is not a courtesy; it
is bar 5 made structural.

## 4. Mechanics — the orchestrator's part

- Each throwaway branch is **`6bd7e5a` + exactly one mutation diff**, nothing
  else. The control is therefore structural: the parent SHA is a known-green
  commit, and the relay must state each branch's parent SHA so I can confirm it.
- Branches are **never merged** and are deleted after their run.
- The frozen SHA is **re-confirmed green** on the campaign's first and last
  runs — cheap insurance against CI environment drift over the campaign.
- Nothing from any run result reaches the auditor while diffs remain
  unauthored.

## 5. How results come back to me

Per run, relayed by the orchestrator:

1. The branch's **parent SHA** and the mutation id (M1..M5).
2. The CI **run id**.
3. **Build** state.
4. `dune runtest`'s **verbatim** output — the complete raised message including
   any dumped table, and the **name of every `%expect_test` that failed**, not a
   summary. Which test speaks, and what it says, is the entire adjudication; a
   paraphrase destroys it.
5. If the run is **green: relay that too, prominently.** For M1–M5 a green run
   is a **campaign failure** — a seeded defect the bench did not catch — and it
   is the single most important result this campaign can produce.

I adjudicate each against predictions frozen in the sealed companion file
before any diff existed.

## 6. Pass criteria — all three required, per mutation

1. **The suite goes red.**
2. **It goes red in the rows I named in advance.** A mutation that reddens a
   row I did not name — or reddens a named row with the *wrong message* — is a
   **finding**, not a pass. It means the bench caught the defect for a reason
   other than the one it was built to catch it for, and that is worth knowing.
3. **The unmutated control is green**, established structurally by §4's
   parent-SHA rule and re-confirmed at the campaign's ends.

A bench that survives any of the five is not done, and **`SO-M03` does not
issue.**

## 7. What this campaign is for, said plainly

M03's suite passes with fifteen silent tests and fifteen empty `[%expect]`
blocks. Every check is an in-code assertion; nothing is snapshotted, by design.
The consequence is that **a green run here is indistinguishable from a suite
that never executed a single check.** Nothing in run 30779035676 separates
"twenty entries verified" from "the checks did not run".

These five mutations are the only evidence that green means anything. That is
why the campaign is a hard precondition on `SO-M03`, and why the blinding in §0
is not optional politeness.

---

## RV-0039-VERDICT: the campaign adjudicated — five of five killed, 21/21 REQUIRED, and two findings that are both corrections to *my* model — dv_lead, `J-dv_lead-0036`

**Branches**: m1@`193f387`, m2@`ddac42e`, m3@`3625218`, m4@`00ccc5c`,
m5@`ad7f35c`, each `6bd7e5a` + one auditor diff — parent SHA structural, so
pass criterion 3 is met by construction; control re-confirmed green at
`0556f23`/`0d231ee` in the same window.

### 0. Scorecard

| | REQUIRED | MUST-STAY-GREEN | PERMITTED | verdict |
|---|---|---|---|---|
| **M1** latency +1 | **3/3** ✓ | **3/5** — C12 and C5 reddened | — | **KILL, with FINDING F-1** |
| **M2** C-18 | **7/7** ✓ | **1/1** ✓ | C4 → branch A (primary) | **KILL, clean sweep** |
| **M3** input `tkeep` | **7/7** ✓ | **1/1** ✓ | A34 → reddens (named branch) | **KILL, clean sweep** |
| **M4** bound → 189 | **1/1** ✓ | **6/6** ✓ | C5 → **unenumerated third branch** | **KILL, with FINDING F-2** |
| **M5** BUG-0001 | **3/3** ✓ | **5/5** ✓ | — | **KILL, exact** |
| **total** | **21/21** | **16/18** | 3 resolved, 1 unenumerated | **5/5 mutations killed** |

**Every REQUIRED unit reddened, and every one of them reddened through the
predicted channel** — including the three where the channel, not merely the
row, was the claim: M1's A34 speaking through **A4** and not A3, M2's A34
speaking through **A3** and not A4, and M5's A34 speaking through the
**latency tagger** and not the tuple comparison. Getting the row right is
cheap; getting which assertion speaks is the part that could have been wrong.

**Both MUST-STAY-GREEN violations are the same channel, on the same mutation,
and both falsify a prediction of mine rather than exposing a bench defect.**

### 1. M2, M3, M5 — clean sweeps, scored first because there is nothing to argue

**M2 (7/7 + C4).** Every lane-4-driving unit died with the message I froze,
including `M03-A1/A2 (lane 4): tuser[0] set — FCS verdict bad (this is the C-18
kill at lane 4)` verbatim, and C5's lane-4 entries showing **`tuser=1` and
`error_pulses=1`** together — the compound shape I predicted from §9's REQ-104
row (forwarded in full, `tuser`[0] set, `error_bad_fcs` pulsed).

**C4 resolved to Branch A, and that answers a specification question I had
routed as open.** `expected exactly one strobe pulse (error_runt only),
observed 2` at a frame of **exactly 5** octets means M03 sequences an FCS check
for that frame and admits the `error_runt` + `error_bad_fcs` pairing there. M2
altered only CRC *accumulation*, never whether a check is sequenced, so this is
sound evidence about the unmutated design too. §9's ninth co-occurrence ruling
bounds the pairing **at** 5 octets, not above it — the change-log entry's own
words — and the design agrees. **Nothing routes to architect_docs_lead.**

**M3 (7/7 + A34).** Two message predictions landed numerically exact:
`word 189 tkeep = 63, expected 3` is my frozen `0x3F` at a lane-0 start's
terminate lane 6, and `word 7 tkeep = 0, expected 15` is the **degenerate case
I flagged in the freeze** — at a lane-0 start with a 64-octet frame the
terminating word carries *zero* frame octets (`terminate_lane = 0`), so
input-derived `tkeep` is `0x00`. C12's `64: 56/60 tkeep 0/15` and
`69: 69/65 tkeep 31/1` confirm the second half of that note: a wrong `tkeep`
corrupts the delivered octet sequence, because `Stream_word.octets` is masked
by it.

**A34 resolved to the reddening branch**, so the mutation's error is
lane-asymmetric. The consequence must be stated as a *non-result*: the
alternative branch would have demonstrated that **A3 is a cross-lane equality
row and not a general content check.** That demonstration did not happen, so
A3's blindness to lane-symmetric errors **remains an untested property** and
families D–H may not assume it either way.

**C5's `lane4/1513 PASS` is not a bench gap and I checked the arithmetic rather
than take the disclosure.** 1513 at a lane-4 start terminates in lane 5, so the
terminating input word carries 5 frame octets → input-derived `tkeep` = 0x1F;
the frame delivers `D` = 1509, `k` = 5 → frame-derived `tkeep` = 0x1F. **The
two coincide.** The mutant is genuinely unobservable there. The auditor's
disclosure 2 is correct, and it **bounds what M3's kill licenses**: the bench
is shown to catch input-derived `tkeep` at lane-0 starts and at lane-4 starts
terminating in lane 0 — it is *not* shown to catch the class at lane-4 starts
terminating in lanes 1–7, because there is nothing there to catch. A coverage
statement, not a hole.

*My frozen message said "all four entries"; three fired. The unit scored, the
shape was right, and the extent was narrower for a reason the mutation's own
structure fixes. Recorded as a correction to my prediction, not a finding
against the bench.*

**M5 (3/3 + 5/5) — exact, and it closes the campaign's most important cell.**

- **A34 spoke through the latency tagger** with the original bug's own message
  (`73 input octets less 8 stripped ... is 61, but 62 octets were emitted`) and
  **not** through A3's tuple comparison — because the excess is
  lane-*independent* (`J-dv_lead-0031`), so both lanes' sequences stay equal.
  Frozen channel, frozen reason, observed.
- **C12** reproduced the historic signature: 65–68 excess, 64/69–71 clean.
- **C5 — THE CELL.** `lane0/1513 1510/1509 (+1)`, `lane0/1516 1516/1512 (+4)`,
  and the same at lane 4. **P-1's +1 and +4, at both lanes, exactly as frozen.**
- **A12, A5, B1, C3, C4 all green** — precisely the `k` ≤ 4 set I worked out
  before the diff existed.

**T-C5 has now been red.** The row carrying `BUG-0001`'s fix-verdict condition 4
is demonstrably capable of failing, and of failing with the exact arithmetic the
verdict rests on. Yesterday's CONFIRMED is now supported by a row proven to have
teeth rather than by a row that had only ever been silent. That was the single
result this campaign most needed, and it landed unambiguously.

### 2. FINDING F-1 — M1's C12 and C5: my MUST-STAY-GREEN call was wrong, and so was my stated reason for how it could be wrong

M1's three REQUIRED kills fired with the frozen messages, and **A34 spoke
through A4 rather than A3, which is positive proof the shift was lane-uniform**
— M1 was faithful. But C12 and C5, both frozen MUST-STAY-GREEN, reddened.

My freeze named the only way that could happen: *"any of the five
MUST-STAY-GREEN units reddening means the mutation moved content as well as
timing."* **That is falsified.** Every content column PASSes at every entry in
both tables. The mutation moved no content whatsoever.

**The real cause is an error in my model of my own suite.** The freeze's §3
opens with "Everything else asserts content only." That is **false of C12 and
C5**. Since round 6 they also carry `check_disagreement_matches_r1`, which is
a *timing- and pipeline-coupled* assertion. I classified those units by their
row semantics and forgot the round-6 addition I myself commissioned four days
earlier.

**Two consequences, both withdrawals.**

1. **WITHDRAWN: "five of nine test units are blind to a one-cycle latency
   error."** Recorded at `J-dv_lead-0035` as standing knowledge headed for the
   D–H rules. **It is three** — A5, B1, C3. C12 and C5 are timing-sensitive
   through the R-1 check, and M1 proved it.
2. **WITHDRAWN: the freeze's stated diagnostic** that a MUST-STAY-GREEN
   violation under M1 implies content movement. The correct diagnostic is
   *content movement **or** a change to the output pipeline's registration*.

**M1 is a KILL and is not voided.** It caught the defect in all three units
built to catch it, with the exact predicted messages, and the two extra kills
are the bench being *more* sensitive than I predicted, not less.

### 3. FINDING F-2 — M4's C5: a third branch I did not enumerate

I froze two branches for C5 under M4, and **both were about the delivered
count**: green ⟹ the bound landed at 189 as intended; red ⟹ it landed at 188 or
the comparison is strict. The observed result is neither. C5's delivered counts
are **exact** (1509/1509, 1512/1512, `tuser` 0) and the red comes solely
through the views channel, at `lane4/1516` alone.

**WITHDRAWN: the freeze's inference "C5 red ⟹ bound at 188."** C5 can redden
under M4 with the bound exactly where the intent asked. Left standing, that
inference would have sent a future reader to the wrong conclusion.

**The auditor's boundary is faithful, and disclosure 3 is what proves it.**
1516 octets → `D` = 1512 → 189 words, terminates normally; 1518 → `D` = 1514 →
190 words, truncates. The intent asked for "189 words complete, 190 do not" and
that is exactly what was built. Its note that 1517 leaves the word bound at 190
(`D` = 1513 → 190 words) is correct arithmetic and is why the octet constant had
to move to 1516. **No re-seed.**

**What the firing actually detected is the interesting part.** M4 moved the
threshold to *exactly* C5's second length. `lane4/68` in C12 kept its
disagreement — untouched by the constant — while `lane4/1516` lost it. The
check localised a second observable effect of the mutation **at the one entry
adjacent to the mutated constant and nowhere else**, and it did so where
**every content assertion in the suite is blind**: C5's content is exact.

### 4. Ruling on both R-1-check firings, under the round-6 binding qualification

`RV-0038-R7-VERDICT` §4 bound me in advance: a firing is *"a finding about the
model of the instrument, not an M03 row failure"*, and *"widening or narrowing
`expected_disagree` to fit what was observed is prohibited."* Both apply, and
the qualification held up.

**Both firings are TRUE POSITIVES.** `expected_disagree` encodes a relationship
between the design's output pipeline and the bench's two sampling views. In each
case the *design* changed and the relationship broke:

- **M1**: an added output register makes every output registered, so for a
  fully-registered output the After-labelled reading at cycle `T−1` equals the
  Before value at `T` — it no longer misses the `tlast`. R-1's artefact does not
  exist in that design. Disagreement vanishes everywhere; the check says so.
- **M4**: at the threshold length the closure record producing `tlast` is no
  longer born from the same path at the same time, so `lane4/1516`'s
  disagreement vanishes while `lane4/68`'s survives.

The check is doing exactly what it was built to do, and its output is legible in
exactly the shape I said a firing would take: **an all-content-PASS table with
the `views_disagree` column contradicting the prediction.**

**The prohibition is absolute and I am applying it to myself.**
`expected_disagree` is a statement about the design at `6bd7e5a`. **No change to
the predicate. No change to the bench for the campaign's sake.** A green M1 or
M4 bought by widening the oracle would have been the exact substitution this
programme's rules exist to refuse.

**What must be written down instead.** `check_disagreement_matches_r1` is a
**design-coupling assertion — a sampling-model tripwire — not a content check.**
Its firing means *"re-derive the sampling model against this design"*, never
*"M03 is broken"* and never *"adjust the predicate"*. Any legitimate future M03
change to the output pipeline will fire it, and that is desirable **only if the
next reader reads it correctly.** I owe a docstring saying so, and a standing
D–H rule routing a firing to re-derivation. Both are prose in `test/**`; both
land **after** the B-round scores, so the B-round is judged against `6bd7e5a`
exactly as M1–M5 were.

**One thing the campaign delivered beyond its design.** Before this week the
R-1 check had *only ever been silent*. B1 was scheduled to prove it
**reachable**; M1 and M4 proved it **discriminating** — it fired on real design
changes, in the right direction, and at the right entries. That is strictly
stronger evidence, and it retires B1 (§6).

### 5. Voiding, re-seeds, and the auditor's conduct

**No mutation is voided. No re-seed. All five stand as recorded knowledge.**

**On M1's disclosure 1 — the auditor's reading is better than my intent text.**
It delayed the strobes **with** the stream, citing §9's pin ("each strobe pulses
on the cycle M03 emits that frame's `tlast` word"), and offered to re-seed if
stream-only was meant. Stream-only would have produced a design that *violates*
§9 — a second, unrequested defect stacked on M1, whose kills I could no longer
attribute. **The spec-faithful choice was the faithful-to-intent choice, and it
is the one that was made.** My intent's phrase "the same error strobes" was
ambiguous between *same values* and *same cycles*, and that ambiguity is mine.

> **Standing correction for future mutation intents**: when a mutated quantity
> has spec-pinned dependents, state explicitly whether the dependents move with
> it. Do not leave a seeder to infer it, even when — as here — the seeder infers
> correctly and says so first.

Either resolution scored, incidentally: my C4 prediction admitted both the
word-cycle and the strobe-cycle message.

**All three disclosures were written before any run, and all three were load-
bearing in this adjudication** — disclosure 2 explained M3's C5 extent,
disclosure 3 confirmed M4's fidelity and is what let me separate F-2 from a
mutation defect. That is exactly the conduct the blinding was designed to make
possible: a seeder who cannot tune to a prediction, telling me in advance where
its diff is weak. **Recorded as exemplary.**

### 6. The bench-side round: B1 retired, B2 and B3 owed as CI runs

**B1 is RETIRED as discharged.** Its purpose was to show
`check_disagreement_matches_r1` reachable and its message legible. **M1 and M4
did both, on real design changes rather than on a self-inflicted predicate
edit** — and the dumped tables named the specific entries and their
`views_disagree` column, which is the legibility half. Running a weaker
self-test for a property a stronger external test has already established would
be ceremony. It is retired on the evidence, not skipped.

**B2 and B3 require CI runs, and I will not score them by reasoning.** The whole
argument of this campaign is that a green run is an absence and that reasoning
is not evidence. Scoring my own mutations by reasoning, in a session that just
spent five branches proving that point, would be incoherent. Same mechanics:
**throwaway branch = `6bd7e5a` + one diff, never merged, deleted after the
run.** I author the diffs; the orchestrator applies them, exactly as it did the
auditor's.

**B2 is a hard `SO-M03` precondition and the reason is uncomfortable.**
`outcome_ok`'s `None -> false` branch is what carries **fix-verdict condition 2**
— it is the branch that turns "no `tlast` word was sampled" into a FAIL, and it
is why I could read `lane 4 length 68`'s silence as a positive `Some 255`
observation. **No mutation in this campaign produced a `tkeep = none` entry.**
M3 produced `Some 0`; M2 failed on `tuser`; M5 failed on counts. So that branch
**has not been observed to fire since the fix**, and my own CONFIRMED verdict
leans on it. That is a real hole in my evidence base and B2 closes it.

#### B2 — force one entry's `observed_tkeep` to `None`

```diff
--- a/test/xgmii_rx_64/test_m03_c.ml
+++ b/test/xgmii_rx_64/test_m03_c.ml
@@ let length_outcome ~lane ~length (frame : Dv_xgmii.Arrival.frame) samples =
   let observed_tkeep, observed_tuser =
     match tlast_sample samples with
     | None -> None, None
     | Some s ->
-      ( Some s.out.Dv_monitors.Stream_word.tkeep
+      ( (if lane = 0 && length = 64
+         then None
+         else Some s.out.Dv_monitors.Stream_word.tkeep)
       , Some s.out.Dv_monitors.Stream_word.tuser )
   in
```

**Frozen prediction (computed, not estimated).** **T-C12 reddens** from
`batched_failure_with_protocol` — not from `check_disagreement_matches_r1`,
which is never reached because the batched check raises first. The table
carries **16 lines, exactly one FAIL**:

```
FAIL  lane 0 length 64: delivered=60/60 tkeep=none/15 tuser=0 terminate_lane=0 error_pulses=0 views_disagree=false
```

`expected_tkeep` = 15 because `D` = 60, `60 mod 8 = 4` → `0x0F`;
`terminate_lane` = 0; `views_disagree` = false because `expected_disagree`
needs a *full* final word and 60 is not. **Every other field on that line is
correct, so the `None -> false` branch is the only thing that can make it FAIL
— which is precisely the point.** T-C5 and the other thirteen units stay green.

#### B3 — `run_c5` drives zero lengths (the exhibit)

```diff
--- a/test/xgmii_rx_64/test_m03_c.ml
+++ b/test/xgmii_rx_64/test_m03_c.ml
-let m03_c5_lengths = [ 1513; 1516 ]
+let m03_c5_lengths : int list = []
```

*(The annotation is deliberate: a bare `[]` at module level takes a weak type
variable, and I would rather not spend a CI run discovering that. It is a
compile-safety annotation, disclosed, not a second change.)*

**Frozen prediction: the entire suite is GREEN, T-C5 silent.** `per_lane`
returns `[]`, so `outcomes` is `[]`; `batched_failure_with_protocol` filters an
empty list and returns `()`, `check_disagreement_matches_r1` filters an empty
list and returns `()`, the per-entry monitor loop iterates nothing. **Every
check in `run_c5` is a list traversal, and every list traversal is vacuous on an
empty list.**

**B3's framing is downgraded from what I wrote at `J-dv_lead-0035`.** It was
"the exhibit of why this campaign is necessary." The campaign has now succeeded,
so it no longer argues for anything. What survives is narrower and still worth
one branch: **a standing structural caution for families D–H** — a row whose
stimulus list empties out passes silently and identically to a row that ran, and
no `[%expect]` block in this suite can tell the difference. Lowest priority of
the three; run it last.

### 7. `SO-M03`: **DOES NOT ISSUE**, and the gap is not B2

**The campaign qualified the *instrument*, not the *module*.** Five seeded
defects, twenty-one required kills, every predicted channel observed. What that
establishes is that **this bench can convict** — that its green means something.
It establishes nothing whatever about the sixty-odd attack-plan rows the bench
does not yet contain.

`test/attack_plans/AP-xgmii_rx_64.md` carries **75 rows, 59 of them ASSERT**.
WO-0038 delivered **twelve** — families A (five rows, of which A4 is NO-ASSERT),
B (one row), C (five including C5), and L6 (STRUCTURAL). **Families D through H
are entirely unwritten**, and that is where the error paths live: REQ-105's
error character mid-frame, REQ-108's oversize truncation, REQ-110's
start-without-terminate, REQ-107's runt classes beyond C4's single case,
REQ-009's `clear` mid-frame, and the family-J disable path. L1–L5 are owed and
X-7, X-10, X-11 remain deferred.

**Signing off M03 on a clean-frame spine would be the most dangerous act
available to me in this programme.** An `SO-` is a merge precondition; a PASS
here would read as "M03 is verified" while every abort, truncation and
error-reporting requirement in the module remains untested by anything. The
campaign's success makes that *more* tempting, not less, which is exactly why it
needs saying plainly.

**The verdict path to `SO-M03`:**

1. **B2 green-with-the-predicted-single-FAIL** — closes the `None -> false`
   evidence hole under fix-verdict condition 2. *Hard precondition.*
2. **B3 run and recorded** — the structural caution, converted from argument to
   observation.
3. The two prose commits owed in `test/**`: the design-coupling docstring on
   `check_disagreement_matches_r1`, and the corrected "three of nine units are
   timing-blind" datum replacing the withdrawn five.
4. **Families D–H benched**, plus L1–L5 — several work orders, not one, and
   each needs its own mutation qualification before its rows can carry an `SO-`.
5. Only then, an `SO-xgmii_rx_64` whose scope statement names exactly which
   rows it rests on.

**What issues now instead:** this adjudication. The bench is qualified; the
module is not signed off; nothing about M03's error paths is claimed in either
direction.

---

### RV-0039-VERDICT ADDENDUM: the B-round scored, the campaign closed, and the shape of the next wave — dv_lead, `J-dv_lead-0037`

#### 1. B2 and B3 — both frozen predictions confirmed exactly

**B2 (run 30783111780, `mut/wo-0039-b2@a47fe76`).** T-C12 red **via
`batched_failure_with_protocol`, not via the R-1 check** — the ordering claim in
the freeze, confirmed. Sixteen lines, exactly one FAIL, and the FAIL line is
**character-for-character** the text I computed field by field before the run:

```
FAIL  lane 0 length 64: delivered=60/60 tkeep=none/15 tuser=0 terminate_lane=0 error_pulses=0 views_disagree=false
```

Every field on that line except `tkeep` is correct, so **`outcome_ok`'s
`None -> false` branch is the only thing that could have made it FAIL** — which
was the entire point. The fifteen other entries PASS, including `lane4/68` with
`views_disagree=true` matching the predicate, which is a second confirmation
that the R-1 oracle still holds on the unmutated design.

**The hole in my own fix verdict is closed.** `BUG-0001` fix-verdict condition 2
rested on that branch — it is what let me read `lane 4 length 68`'s silence as a
positive `Some 255` observation — and **no mutation in the RTL campaign had
exercised it**. It has now fired, on demand, at a predicted entry, with a
predicted message. Condition 2's discharge is no longer leaning on an
unobserved branch.

**B3 (run 30783112740, `mut/wo-0039-b3@0630f2e`).** Entire suite **GREEN**,
conclusion "success", zero failures, T-C5 silent. **The exhibit stands, and it
is now a run id rather than an argument** — which is the only form of it I was
ever willing to rely on. A row whose stimulus list empties passes silently and
identically to a row that ran, and no `[%expect]` block in this suite can tell
the difference. That is the standing structural caution families D–H inherit,
and it is recorded in `AP-xgmii_rx_64.md` §8.

#### 2. Final campaign tally

| | seeded | killed | REQUIRED | notes |
|---|---|---|---|---|
| **M1–M5** (RTL, auditor-seeded, blinded) | 5 | **5** | **21/21** through the predicted channel | findings F-1, F-2 — both corrections to dv_lead's predictions |
| **B1** (bench) | — | retired | — | discharged by M1/M4, which proved the R-1 check *discriminating*, not merely reachable |
| **B2** (bench) | 1 | **1** | exact | character-for-character; closes fix-verdict condition 2's evidence hole |
| **B3** (bench) | 1 | n/a | exact | expected-green exhibit, confirmed |
| **control** | — | — | green at `0556f23`/`0d231ee` | plus parent-SHA-structural on all seven branches |

**Eight seeded defects, eight predictions frozen before any diff existed, eight
outcomes as predicted at the unit level.** Two predictions were wrong in their
*reasoning* (F-1's stated diagnostic, F-2's enumerated branches) and both were
withdrawn rather than reinterpreted.

#### 3. Branch cleanup — CONFIRMED, delete all seven

`mut/wo-0039-m1..m5`, `mut/wo-0039-b2`, `mut/wo-0039-b3`: **delete them all.
No re-seed is owed anywhere**, B-round included. M1's strobe-coupling question
was resolved in the auditor's favour (§5 of the verdict), M3's and M4's
disclosures explained their results without impugning fidelity, and B2/B3 hit
their frozen predictions exactly.

**The evidence survives the deletion**, which is why deleting is safe: every run
id, every failing unit and every verbatim message is in this packet, and the
frozen predictions they were scored against are in the sealed companion with a
`git diff` of seven insertions and one deletion proving only its state line
moved. Branches were the vehicle; the packet is the record.

#### 4. Next wave — **family D first, alone**, and a correction to the mapping

**The relayed mapping is off by one.** In `AP-xgmii_rx_64.md` §4, **D is the
FCS check (REQ-104)**; the error character mid-frame is **E** (REQ-105). The
rest: F runts (REQ-107), G oversize (REQ-108), H start-without-terminate
(REQ-110).

**Shape: one work order for family D now. Not D+E, not all five up front.**

*Why not all five up front.* Each new bench needs its own mutation
qualification before its rows can carry an `SO-`, so five packets issued
together is five campaigns queued behind five review loops. The loop just
proved itself over six rounds on twelve rows; run it once more on a small
family before committing the wave's shape.

*Why family D and not E.* Two reasons, and the second is the decisive one.

1. **D closes a hole that is live today, and that this campaign did not
   catch.** All fifteen tests assert `tuser`[0] = 0 and *no* strobe on good
   frames. **Nothing anywhere drives a bad-FCS frame.** A design that hardwired
   the verdict to good and never pulsed `error_bad_fcs` would pass the entire
   suite. M2 was caught by seven units precisely because it made the verdict go
   **bad** — none of my five mutations was a *silently-always-pass* mutation,
   and one exists. **REQ-104's positive direction is unverified.**
2. **D is the only family in D–H that does not rest on an un-anchored model.**
   `AP` §7's WO-0033 standing limit — which I have now promoted into a banner,
   because §7 still reads as a gap list although X-1..X-5 were all built — says
   **X-1's outcome model is not the charter §3 external anchor**, and that **no
   `SO-xgmii_rx_64.md` PASS may rest on it until the verilog-ethernet
   differential co-sim has run.** Families E, F, G and H lean on X-1's computed
   §9 outcomes. **Family D's rows are hand-derivable from §9 end to end.** So D
   can reach a sign-off-eligible state on a path that does not run through an
   obligation nobody has discharged yet.

#### 5. The first packet's spine

**Rows: M03-D1, M03-D2, M03-D3 (ASSERT) and M03-D4 (NO-ASSERT declaration).**
Four rows. Small on purpose.

- **M03-D1** — a 64-octet frame with **one payload bit flipped after the FCS
  was computed**, both start lanes. Sixty octets still delivered (forwarded in
  full, REQ-005), `tuser`[0] = 1 on the `tlast` word, **exactly one
  `error_bad_fcs` high cycle on the `tlast` cycle** per §9's pin, no other
  strobe. Kills a store-and-forward-by-the-back-door design, and a design
  reporting on the terminate cycle instead of the `tlast` cycle.
- **M03-D2** — the anti-vacuity partner. Largely **dischargeable by citation**:
  the existing fifteen tests already assert `tuser`[0] = 0 and no strobe across
  eight lengths, two start lanes, 1513/1516 and 1518. The packet must **state
  the extent it is citing rather than re-drive it**, and must extend it to the
  good-FCS partners of D1's and D3's own frames.
- **M03-D3** — a bad-FCS 64-octet frame followed at the **§0.3 minimum gap** by
  a good-FCS frame. The bad verdict lands on the first frame's `tlast` word and
  the second frame is clean. Kills a design that reads the CRC register at the
  `tlast` cycle rather than carrying the verdict with the frame — which is a
  real hazard, because §6.1 seeds the register in `Preamble` and §6.1's drain
  paragraph puts the first frame's `tlast` word up to two cycles after its
  terminate word.
- **M03-D4** — NO-ASSERT. Residue-versus-capture is unobservable (§6.3 item 1).
  The packet **declares** it and asserts nothing, exactly as A4 and L6 were
  handled.

**Machinery: none owed.** X-1 through X-5 are built (`AP` §9, WO-0033). D1's
strobe assertion reuses the `Strobe_monitor.expect` pattern M03-C4 already
exercises — pinned cycle, `not_before`/`not_after` window, `why` string. The
one open question is a **bench-side** one, not a library gap: whether
`test/xgmii/arrival.mli` lets a caller pin the inter-frame gap to §0.3's
minimum, or whether `Bench` needs a `two_frames ~lane ~gap` beside `one_frame`.
The packet's §4 answers it by reading `arrival.mli`, which is not a
prohibited path.

**The age-0 sampling declaration, made concrete rather than left as a bar.**
`AP` §8 requires the first D–H bench to state which of its rows depend on an
age-0 closure record. For this packet the answer is computable in advance and
the packet will say so: **D1's lane-0 case is in the class.** A 64-octet frame
at a lane-0 start has `terminate_lane = 0` — the very entry R-1 is about — so
its `tlast` cycle, and therefore §9's pinned `error_bad_fcs` cycle, is decided
combinationally in the terminating word. **D1 at lane 0 must be asserted from
the `Before` view and may not be written against the old position**, and the
packet states this as a row property rather than leaving tb_writer to discover
it. D1 at lane 4 (`terminate_lane = 4`) is not in the class, which makes the
two lanes a built-in control on each other.

**Mutation qualification, named up front as WO-0038 §8 did** — one per row's
declared Kill, so the qualification campaign is derivable from the plan rather
than invented later:

| | mutation | must die |
|---|---|---|
| D-M1 | hardwire the FCS verdict good; never pulse `error_bad_fcs` | **M03-D1** — the mutation the current suite cannot catch |
| D-M2 | hardwire the verdict bad | **M03-D2**, and much of the WO-0038 suite |
| D-M3 | report the verdict from the CRC register at the `tlast` cycle rather than carrying it with the frame | **M03-D3** |
| D-M4 | pulse `error_bad_fcs` on the terminate cycle instead of the `tlast` cycle | **M03-D1** on the pinned-cycle check |

Same protocol as WO-0039: intents behavioural, seeder blinded to the
predictions, predictions frozen and sealed before any diff exists, throwaway
branches parented on the frozen bench SHA.

**Then, in order:** **E** (REQ-105, and the natural second because its rows
exercise the truncated-frame accounting path that F, G and H all reuse), then
**F**, **G**, **H**. Each with its own qualification. **And in parallel, the
verilog-ethernet differential co-sim** — E through H cannot carry an `SO-` PASS
until X-1's outcome model is anchored, and that is a long-lead item that should
start now rather than when it becomes the last blocker.

#### 6. `SO-M03` path, updated

`RV-0039-VERDICT` §7's path stands, with **one gate added that I had not
previously named on this packet**:

1. ~~B2~~ **done** — condition 2's evidence hole closed.
2. ~~B3~~ **done** — exhibit recorded as run 30783112740.
3. ~~The two prose items~~ **done** — the design-coupling docstring beside
   `check_disagreement_matches_r1`, and `AP` §7's staleness banner plus §8's
   four standing facts.
4. **Families D–H benched**, each with its own mutation qualification. D is
   specified above; E–H follow.
5. **NEW — the verilog-ethernet differential co-sim must run**, because
   families E–H rest on X-1's outcome model and WO-0033's own standing limit
   bars an `SO-` PASS from resting on it unanchored. This is charter §3's
   external-anchor rule reaching M03, and it is the longest-lead item on the
   list.
6. Only then, an `SO-xgmii_rx_64` whose scope statement names exactly which
   rows it rests on.

**The bench is qualified. The module is not signed off, and item 5 means it is
further from sign-off than the campaign's success makes it feel.**
