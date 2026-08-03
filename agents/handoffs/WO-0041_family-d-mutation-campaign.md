# WO-0041: The family-D mutation campaign — five seeded FCS-path defects

- **State**: DRAFT (id is a placeholder — PROTOCOL §3 gives numbering to the
  orchestrator at first commit)
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
