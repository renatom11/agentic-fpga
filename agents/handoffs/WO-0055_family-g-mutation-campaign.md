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
