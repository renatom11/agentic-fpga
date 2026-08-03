# WO-0039: The M03 mutation campaign — five seeded RTL defects the bench must die on

- **State**: DRAFT (id is a placeholder — PROTOCOL §3 gives packet numbering to
  the orchestrator at first commit)
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
