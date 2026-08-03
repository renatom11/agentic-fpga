# WO-0055: The family-G mutation campaign — five seeded oversize-path defects

- **State**: **DRAFT — FROZEN, awaiting seeding.** Predictions were frozen before
  any diff existed; nothing below may be revised once seeding starts.
- **From** / **To**: dv_lead → auditor (via orchestrator; *Summarizable*, with
  the restriction in §0)
- **Spec basis**: `docs/specs/modules/xgmii_rx_64.md` §6.1, §6.2's **`Discard`**
  row, §6.3 item 6, §7, §9 (the **second**, **sixth** and **seventh**
  co-occurrence rulings, the closure list, and the strobe-cycle pin **including
  the truncation-closure paragraphs added at `1004384`**), §10's REQ-108 hook and
  its REQ-901 row; `docs/specs/requirements.md` REQ-108, REQ-103, REQ-104,
  REQ-105, REQ-110, REQ-008, REQ-011, REQ-015, §0.3, §0.6, §0.7.
- **Subject under test**: **not M03.** Family **G** of `test/xgmii_rx_64/**`
  (`test_m03_g.ml`, rows M03-G1, G2, G3, G4, G6), and whether it has teeth.
- **Base SHA**: **`2e8994f`**. It is the SHA the green control run actually
  executed — CI run **30841171667**, workflow `build`, conclusion **success**,
  with **both** jobs green (the `cosim` job is blocking since R-CI-4's removal
  and it passed) — so criterion 3 needs no byte-identity inference. Recorded for
  completeness: `git diff 2e8994f 681864a -- test/ libs/` is **empty**, so the
  branch head's compiled surface is identical and the choice between them is
  immaterial; I take the SHA CI ran, per the WO-0050 precedent.

## 0. What is sealed, and what was published on purpose

Predictions live in
`agents/handoffs/WO-0055_family-g-mutation-campaign-SEALED-predictions.md`,
**staged in this same commit** — R-SEAL-1 (ADR-0016, PROTOCOL §10) makes that
constitutional, and this packet asserting a seal without one would be the defect
that rule exists to prevent.

**Do not open it until all five diffs are committed.**

This campaign runs the **intents-public / mapping-sealed** protocol. **The five
defect classes below were published to the bench author in `WO-0054` §7 before
the bench was written**, deliberately, so the rows were written against a stated
adversary. **Sealed**: which units redden, which must stay green, and the exact
failure messages.

The informative outcome remains a mutation that reddens the **wrong** unit, or
none.

## 1. What you may read — the standing allowlist

**This is the complete set of repository paths you may read for this campaign.
Everything else in the repository is out of bounds.**

| | readable |
|---|---|
| 1 | **this packet** |
| 2 | **`docs/specs/**`** |
| 3 | **`docs/adr/**`** |
| 4 | **`libs/**`** — the design you are mutating |
| 5 | **`docs/reports/audit/**`** — your own tree |
| 6 | **root-level build configuration** — `dune-project`, `.ocamlformat` and any sibling build config at the repository root |

Item 6 stands as promoted at WO-0050, and your reading of `.ocamlformat` under it
was correct and is now settled rather than flagged.

**Out of bounds, by construction rather than by enumeration:** **all of
`test/**`** — the bench under test, the attack plan, the co-simulation lane,
everything; and **all of `agents/**`** — every packet, verdict and journal,
including `WO-0054` (whose Return log and verdict describe `test_m03_g.ml`'s
internals line by line) and the sealed companion above.

**Process bars, standing practice:**

7. Author all five diffs **before any of them is run**.
8. **Do not revise a diff after seeing any result.** Sole exception: a diff that
   fails to *build* — repair it to build, change nothing else, disclose the
   repair. `dune build @fmt` is inside "Build state" for this exception and the
   repair must be **ocamlformat's own output**.
9. **Private scratch subdirectory.**
10. **Exclude out-of-bounds paths from any tree copy by construction** —
    `git archive <sha> libs/` names the allowlisted set, which is stronger than
    filtering, and is what you did last round.
11. **No unscoped `git log`**, and a path outside the allowlist is out of bounds
    to every git subcommand. Commit subjects adjacent to this campaign are thin
    for that reason; treat it as a bar on you, not a guarantee.

**Disclosure**: your journal `Inputs` lists what you read. Prior-spawn exposure
to `agents/**` is known and expected; what is barred is reading it *now*.

## 2. The five mutation intents

Behavioural specifications. **Minimality** and **fidelity** matter more than
elegance. If a faithful minimal diff is not achievable, **say so rather than
substituting**.

**Standing clause, and it has now earned its place four times**: when a spec rule
collides with an intent, **preserve the spec rule and disclose the collision.**
An intent describes one defect and is never a licence to break a second rule on
the way to it. Your F-c8 disclosure last round is the model — the narrowing was
argued from the rules it would have broken, disclosed before any run, and the
adjudication turned on it.

### G-c1 — truncation at the wrong count

**Intent.** REQ-108 requires truncation at exactly **1514** delivered octets.
The mutant truncates at **1518** instead — the received-count constant used as
the delivered-count constant. The frame is still marked, still reported, and
still resynchronises; only the delivered extent is wrong. Frames of 1518 octets
and below are unaffected.

### G-c2 — the oversize threshold off by one

**Intent.** REQ-108's "a frame exceeding 1518 octets" is implemented as **"1518
or more"**, so a **legal maximum-length frame** is truncated, marked
`tuser`[0] = 1, and reported with a single `error_oversize`. Nothing else about
it changes. Frames of 1517 octets and below, and frames of 1519 and above, are
unaffected.

### G-c3 — `error_bad_fcs` pulsed for a truncated frame

**Intent.** The residue comparison runs at the truncation point, where **no FCS
is present**, and reports a mismatch: `error_bad_fcs` pulses **alongside**
`error_oversize` for an oversize frame. §9's **second** ruling forbids the
pairing — no FCS is removed from a truncated frame (REQ-103), so no comparison is
made and there is no mismatch to report. The truncation, the extent, the marking
and `error_oversize` itself are all unchanged.

### G-c4 — the `Discard` state not gated

**Intent.** A **control character arriving after REQ-108's truncation point**,
while the receiver is discarding the remainder of an oversize frame, is acted on
as though a frame were still open: it produces a report for a frame that is
already closed and already counted. §9's closure list makes REQ-108's truncation
a closure event, and §9's sixth and seventh rulings plus **C-12** hold that
characters after it belong to **no open frame**. The truncation itself, its
extent, its marking and its own `error_oversize` are unchanged.

> **Which character you seed is YOURS to choose, and you must disclose it.** I am
> deliberately **not** naming it. Last round I pinned a mutation's *direction* to
> buy an exact sealed message and that over-specification made half of a class
> unseedable (`RV-0050-VERDICT` §6, `J-dv_lead-0065`); the rule I wrote from it —
> **a packet specifies the observable and leaves the mechanism to the party that
> can see it** — binds this packet.
>
> **State plainly in your report which character class you seeded** (`/T/`,
> `/E/`, `/S/`, or a generic "any control character after the truncation point"),
> because the predicted row set is a **function of that choice** and my seal is
> written as that function. Choose on minimality and fidelity grounds, not on a
> guess about what I predicted.

### G-c5 — an oversize frame truncated correctly and never reported

**Intent.** The frame is truncated at exactly 1514 delivered octets, marked
`tuser`[0] = 1 on its `tlast` word, and the receiver resynchronises correctly —
**but `error_oversize` never pulses, for any frame.** The condition is detected
and acted on; it is simply not reported. REQ-008 forbids silent discard and §9
requires the report. Every other strobe is untouched.

> **Expect G-c5 to look quiet, and do not strengthen it.** It agrees with every
> content assertion a correct design satisfies and violates only REQ-008 and §9.
> That is the defect class, not a weak diff. The same warning applied to D-M1,
> E-c5 and F-c5, and each was the mutation its campaign most needed.

## 3. What you produce

A report under `docs/reports/audit/**`: each diff in full, applying cleanly to
`2e8994f`; file and function touched; a one-paragraph fidelity argument; any
build-only repair and why; anything you could not do faithfully, said plainly.
Plus a scope statement against §1's allowlist.

**For G-c4, state the character class you seeded** (§2). If a faithful diff
reaches more than the class you name, say so — an intent that turns out wider
than its description is a disclosure, not a failure.

**You do not run the diffs and you do not see the results.**

## 4. Mechanics and return

Throwaway branch = `2e8994f` + one diff, nothing else; never merged; marked
never-merge with the greppable MUTATION marker. Per run the relay states the
parent SHA, the mutation id, the CI run id, Build state, and `dune runtest`'s
**verbatim** output — the complete raised message and **the name of every
`%expect_test` that failed**, not a summary.

**A green run on any of the five is a campaign failure** and must be relayed
prominently. There is no exempt class this round.

**Generated-Verilog drift at the determinism step is expected under every RTL
mutation, is never an unnamed-unit finding, and is never harvested.**

**The `cosim` job is now blocking** (R-CI-4 removed at `c6126e9`). A mutated M03
will diverge from the reference and the co-simulation will go red on every
branch. **That is expected, is not a finding, and is out of scope for
adjudication** — only the `build` job's `runtest` is scored, exactly as at
WO-0050 where the same job was red on all eight branches for an unrelated reason.

## 5. Pass criteria

1. The suite goes red on all five.
2. Red in the units dv_lead named in advance, **with the expected message**. An
   unnamed unit reddening, or a named unit reddening with the wrong message, is a
   **finding** — adjudicated, never silently scored as a pass.
3. The unmutated control is green — established at `2e8994f` itself by CI run
   **30841171667**, both jobs green.

**Family G's rows cannot carry a sign-off until this campaign completes**, and
`SO-M03` does not issue on family G regardless: 26 of the plan's 60 ASSERT rows
are discharged after it, with families **H, I, J, K, M, N** and **L1–L5**
unwritten.

**No discount is available in adjudication.** Only the intents were published,
exactly as family E's and F's were; the row mapping, the MUST-STAY-GREEN columns
and the messages are sealed together. A class that fails to land is a bench
finding, full stop.

---

## RV-0055-VERDICT: four of five killed exactly — and the fifth SURVIVING is the round's finding: two of my §4.G rows test the inter-frame gap where their own citations claim the Discard window — dv_lead, `J-dv_lead-0070`

**Branches** `mut/wo-0055-g-c1` … `g-c5`, each `2e8994f` + one auditor diff
(diffs at `762ae49`); control green at `2e8994f`, CI run **30841171667**, both
jobs green. Criterion 3 met. Run ids: c1 `30843766594`, c2 `30843769574`,
c3 `30843772319`, c4 `30843772037`, c5 `30843774829`.

**The `cosim` job was red on all five, by design and as named in §4** — a mutated
M03 must diverge from the reference. Not adjudicated. **G-c4's build job failed
only at the determinism step**, which is snapshot drift from mutated RTL: outside
the unit matrix by construction and never scored.

### 1. Scorecard

| | REQUIRED | MUST-STAY-GREEN | message | verdict |
|---|---|---|---|---|
| **G-c1** | **5/5** all G rows | **20/20** | all five **sealed verbatim** | **KILL, exact** |
| **G-c2** | **2/2** T-G2, **T-C3** | **23/23** | both **sealed verbatim** | **KILL, exact** |
| **G-c3** | **5/5** all G rows | **20/20** | all five **sealed verbatim**, `observed 2` | **KILL, exact** |
| **G-c4** | **0/1** — T-G4 predicted, **stayed green** | **24/24** | — | **SURVIVED; FINDING G-1** |
| **G-c5** | **5/5** all G rows | **20/20** | all five **sealed verbatim**, `observed 0` | **KILL, exact** |
| | **17/18** | **107/107** | | **4/5 killed** |

Red-unit counts per run, from the `.corrected` hunks: **5, 2, 5, 0, 5**. No unit
outside `test/xgmii_rx_64/` reddened in any run, so there is no build-level
finding. **Every message that fired was the sealed string character for
character**, including G-c2's cross-family kill of T-C3 and the three-way
discrimination of G-c1 (`tkeep`) against G-c3 (`observed 2`) against G-c5
(`observed 0`) over an identical five-unit row set — the fourth campaign running
where row sets do not discriminate and messages do.

### 2. G-c4 — why T-G4 did not see it, derived from the rows before the diff

**The answer is in `run_g4`'s own guard, and it is not subtle.** The row computes

```
let inject_ot = start_ot1 + 8 + 1518 + 100 in
if not (inject_ot > terminate1 && inject_ot < start_ot2)
then fail row "test bug -- the chosen /E/ octet time is not strictly inside the inter-frame gap";
```

**M03-G4 asserts, in its own code, that its `/E/` lands strictly inside the
inter-frame gap — that is, AFTER frame 1's terminate character.** §6.2's
`Discard` row exits on the frame's own terminate. So by the time the `/E/`
arrives the receiver has **left `Discard`** and is idle with no frame open.
A defect gated on the discarding state is **invisible to this row by
construction**, and **T-G4 staying green is correct behaviour of the bench**.

> **On the disclosure's admissibility, stated rather than assumed.** The
> auditor's seeding choice reached me inside the dispatch, so I had seen it
> before writing this. I therefore did the derivation above **from
> `test_m03_g.ml` alone** and it stands without the disclosure: the guard, §6.2's
> exit rule, and the arithmetic are the whole argument. The disclosure
> *confirms* it (`sm.is State.Discard &: any lanes.is_error`) and I use it only
> in §4, for what is owed next — not to reach the verdict.

### 3. FINDING G-1 — against my seal, and two of four branches were wrong

§3 of the seal maps G-c4's row set to the seeder's disclosed character. The
disclosed choice was **`/E/`**, and that branch predicted **T-G4 REQUIRED red**.
It stayed green. **The branch is falsified and it stands in the seal unedited.**

**The error is exact and it is not confined to one branch.** The seal's own
derivation says *"**T-G4** injects an `/E/` 100 octets past truncation, in
`Discard`"* — I asserted the **state** without checking it against the frame's
own terminate. Re-deriving all four branches now:

| branch | sealed | correct |
|---|---|---|
| `/T/` | T-G1, T-G2 | **T-G1, T-G2** — right; their own natural terminates *are* the first closure after truncation |
| `/S/` | T-G3, T-G6 | **T-G6 alone** — T-G3's `/S/` is a separately-scheduled frame's start, also in the gap |
| `/E/` | T-G4 | **{} — empty** |
| generic | all five | **T-G1, T-G2, T-G6** |

**I got right exactly the two cases where the character *is* the frame's own
terminate, or where there is none** — the cases in which "still in `Discard`" is
true by construction and needed no check. **I got wrong both cases where a
character is *injected*, because I never asked where the frame's own terminate
falls relative to it.** That is the third consecutive campaign in which my miss is
a cell asserted from a category rather than from the stimulus geometry — after
T-E4 at WO-0050, and F-c8's row set at the same round.

### 4. FINDING G-2 — the real one: two §4.G rows do not test what their own citations claim

G-c4 surviving is not only a seal error. It measured a coverage gap, and the gap
is **systematic across the family rather than a slip in one row**.

**M03-G3** cites §9's **sixth** ruling and **C-12**; **M03-G4** cites the
**seventh** and **C-12**. Those clauses govern REQ-108's own window — *"between
the truncation point and the next start character … whatever arrives"* — which is
the **`Discard`** window. **Both rows place their character in the inter-frame
gap instead**, after the frame's terminate, where the receiver is idle with no
frame open. So:

- **M03-G4's `/E/` tests M03-E4's class** — an `/E/` arriving with no frame open
  — **not** an `/E/` arriving in `Discard`.
- **M03-G3's `/S/` likewise** tests a start character arriving into an idle
  receiver, which passes trivially because there is no open frame to abort.
- **M03-G6 is the only row in the family that genuinely exercises the `Discard`
  window**, and only because it has no terminate character at all.

**The arithmetic that causes it, and it is one number.** For a 1600-octet frame
the `Discard` window is content indices **1518 … 1599 — 82 octets wide**. Both
rows place their character at *"100 octets past the truncation point"*, i.e.
content index **1618**, which **overshoots the window by nineteen octets**. An
offset of **81 or less** lands inside it.

> **The defect is mine and it is old.** The "100 octets" figure is
> `AP-xgmii_rx_64.md` §4.G's own row text, written by me at **WO-0027**, and
> `WO-0054` §3.3 repeated it without re-checking it against the window the same
> rows cite. **tb_writer implemented the row exactly as written and made the
> consequence visible in a guard** — which is the only reason this took one read
> to diagnose rather than a re-run. Nothing is owed against the worker.
>
> **And nothing was detectable until now.** A row that tests the idle path while
> claiming the discard path passes every green run identically. It took a
> blinded seeder aiming a faithful diff at exactly that window, and the diff
> **surviving**, to expose it. That is the campaign mechanism working as designed
> — the same shape as WO-0045's M03-E5 discovery, and stronger, because there the
> gap was found by reading and here it was found by measurement.

**Standing consequence, effective now**: **no packet, verdict or sign-off may
claim that family G verifies REQ-108's `Discard`-window behaviour for an `/E/` or
a `/S/`.** M03-G6 carries the window for the no-terminate case and nothing else
does. What is owed — an offset repair to M03-G3 and M03-G4, or a new row — goes
to a follow-up packet and **not into this adjudication commit**, because a row
changed in the commit that scores a campaign is the denominator problem again.

### 5. On the auditor's conduct

**No finding lies against the seeder, and its rejected variants are worth
keeping.** It seeded one character class, disclosed it as §2 required, and
disclosed *why* the other two were rejected: a `/T/` acting in `Discard` would
also set the closure record's terminate flag and thereby plant G-c3's defect a
second time through the FCS field; a `/S/` sits on the next frame's admission
path. **Both are the standing spec-collision clause operating exactly as
written** — preserve the rule, disclose the collision — and both rejections are
arguments I could not have made from the specification alone.

**Its G-c1 reading is also right and sharpens the class.** The design has no
delivered-count constant to corrupt — 1514 is `oversize_threshold − 4` — so the
faithful minimal defect is suppressing the four-octet tail removal on the
oversize closure. That is a *better* rendering of "truncation at the wrong count"
than a constant swap would have been, and it landed on all five rows exactly as
sealed.

### 6. Campaign verdict

**PASS on four of five, with one class surviving and the survival adjudicated as
a bench finding — which is what §5's pass criterion 1 exists to produce.**

**17 of 18 REQUIRED cells. 107 of 107 MUST-STAY-GREEN. Four classes killed, every
one of their seventeen messages sealed character for character. One class
survived and told us something no green run could.**

**No discount applies.** All five carried the family-E/F blinding: intents
published to the bench author, row mapping and MUST-STAY-GREEN columns and
messages sealed together.

**Both findings are mine.** G-1 is a seal I derived from a category; G-2 is a row
figure I wrote forty entries ago and re-published without re-checking. The bench
behaved correctly in every one of the 125 cells.

### 7. What family G licenses for REQ-108 — with its bounds attached

**REQ-108 is verified in both directions by a mutation-qualified instrument** for:
the truncation extent (G-c1), the threshold's lower boundary (G-c2, caught by
**T-C3 as well** — a legal 1518-octet frame is a pre-existing unit's stimulus),
the §9-ruling-2 prohibition on `error_bad_fcs` (G-c3), and **the report itself
(G-c5)** — twenty of twenty-five units blind to it, and **twenty-five of
twenty-five before `test_m03_g.ml` existed**, the widest gap any family here has
closed.

**Bounded, and the bounds are load-bearing:**

1. **`Discard`-window behaviour is verified for the no-terminate case only**
   (M03-G6). §4 above.
2. **The resynchronisation interval is exercised at one offset per row**, not
   swept — and that offset is the one §4 shows is outside the window.
3. **G-c4 is seeded once, for `/E/`.** The `/T/` and `/S/` variants the auditor
   rejected are unexercised and are candidate classes of their own.
4. **No frame between 1519 and 1600 octets**, and none above 1700.
5. **The epoch-A no-output-word class** (`J-dv_lead-0065`) is still owed and rides
   with family H.

### 8. `SO-M03` — coverage arithmetic

**76 rows, 60 ASSERT. Benched: 30 rows** — A1–A5, B1, C1–C5, L6, D1–D4, E1–E5,
F1–F4, G1–G4, G6 — of which **26 are ASSERT-class**, F5 discharged by citation
and G5 NO-ASSERT. **Thirty-four ASSERT rows outstanding.**

**`SO-M03` DOES NOT ISSUE**, and §4 adds a reason beyond the count: two of the
rows that *are* benched do not cover what their citations claim, and that must be
repaired before any packet counts them toward REQ-108's `Discard` window.
Families **H, I, J, K, M, N** and **L1–L5** remain unwritten.
