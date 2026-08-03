# WO-0057: Family H — start without terminate (REQ-110), and the row that makes C-23 testable

- **State**: **DRAFT** (dv_lead-authored; the orchestrator issues)
- **From** / **To**: dv_lead → tb_writer
- **Spec basis**: `docs/specs/requirements.md` **REQ-110** (its zero-delivered
  clause in particular), REQ-101, REQ-103, REQ-105, REQ-021, REQ-008, REQ-007,
  **§0.6** (the strobe window **and its C-23 high-cycle counting convention**),
  §0.3, §0.7; `docs/specs/modules/xgmii_rx_64.md` §6.1 (the preamble's eight
  octet times, the per-octet constant, and the two-events-in-one-word paragraph
  with its six-row table), §6.2's `Frame` row, §6.3 items 3 and 8, §7, §9 (the
  closure list, the **fifth** co-occurrence ruling, rows 8 and 9, and the strobe
  pin **with its no-output-word clause**), §10's REQ-110 hook.
- **Rows**: **four.** `AP-xgmii_rx_64.md` §4.H — **M03-H1, H2, H3, H4**, all
  ASSERT. Nothing is discharged by citation and nothing is declared NO-ASSERT in
  this family.
- **Deliverables**: `test/xgmii_rx_64/test_m03_h.ml`, plus `test/xgmii_rx_64/dune`'s
  header line (§8) and nothing else.

---

## 1. What this family closes

REQ-110 is driven today by **exactly one** committed row — **M03-B4**, a `/S/` in
lane 4 of a word whose lane 0 carried a `/S/`, with **no frame open before it**.
That row asserts one strobe and an intact second frame. **Nothing anywhere aborts
a frame that has already delivered octets**, so REQ-110's central sentence — *the
aborted frame's last delivered octet is the one immediately preceding the new
start character* — is unverified in both directions.

**Two silently-always-pass classes live in this family and they are not the same
shape:**

- **A design that strips the FCS on the abort path** delivers four octets too few
  and pulses everything correctly. **M03-H1** is the closure.
- **A design that switches its alignment offset on the same cycle it accepts the
  new start character** loses the aborted frame's trailing four octets **with no
  strobe at all** — a REQ-008 hole. **M03-H2** is the closure, and the attack plan
  calls it the highest-value row in the family for exactly that reason.

## 2. The rows, ranked by risk

I am ranking them because three of the four are ordinary and one is not, and I
would rather you spend your care where it is owed.

### 2.1 M03-H1 — the baseline (ASSERT, lowest risk)

A 64-octet frame whose **terminate character is replaced by a new `/S/` in lane
0**, followed by a complete frame.

Aborted frame: last delivered octet is the one immediately preceding the new
`/S/`; `tuser`[0] = 1 on its `tlast` word; **exactly one
`error_start_without_terminate`**; **no FCS removed** — so it delivers **four
octets more** than a clean frame of the same length, and that count is the
assertion that catches the strip. Second frame received intact.

**Derive the delivered count from REQ-103's no-removal clause, not from
`Frame.delivered`.** The family-G trap in a new dress: `Frame.delivered`
implements REQ-103's *removal*, which REQ-110's abort path does not perform.
State per row which clause governs, as `WO-0054` §2 required and `test_m03_g.ml`
already does.

### 2.2 M03-H3 — co-occurrence (ASSERT, low risk)

`/E/` mid-frame, then a `/S/` **two cycles later**. Exactly one
`error_bad_frame` and **no `error_start_without_terminate`** (§9's fifth ruling);
the frame the `/S/` opens is received normally.

**The teeth are the negative assertion**, so the strobe set is asserted
**exhaustively**, not as a lower bound. This is also M03-M5's stimulus — say so,
and do not build M5 separately.

### 2.3 M03-H2 — the highest-value row (ASSERT, medium risk)

A new `/S/` in **lane 4 of a mid-frame word**, so lanes 0–3 of that word still
belong to the aborted frame.

Those **four** octets are delivered as part of the aborted frame — the `tkeep`
extent and the delivered count together prove it; one strobe; the new frame
begins at lane 4 and is received **intact and correctly aligned**.

> **What makes this row load-bearing, and why a weaker version of it is worthless.**
> The defect it kills produces **no strobe** and a plausible-looking `tkeep`. It is
> caught only by **counting the aborted frame's delivered octets** and comparing
> them against the octets actually injected before the `/S/`. **A row that asserts
> the strobe and the second frame but not the aborted frame's octet-by-octet
> content does not kill it.** Assert the content, not just the count.

### 2.4 M03-H4 — the C-23 row (ASSERT, **highest risk, and the one to build last**)

`/S/` in **lane 0 and lane 4 of one word** (cycle `c`), then `/S/` in **lane 0 of
the next word** (cycle `c + 1`), then a complete frame.

- **Frame A** opens at octet time `8c` and is aborted at `8c + 4` — strictly
  inside its own preamble.
- **Frame B** opens at `8c + 4`, its preamble runs `8c + 4 … 8c + 11`, and it is
  aborted at `8c + 8` — also strictly inside.

Both are §9's zero-delivered class, and both start characters are in a
contract-legal lane (§3, REQ-101).

**Observable**: two zero-delivered aborts; **no output word for either**; §9's
no-output-word pin — two cycles after the input word carrying the closing
character — puts their `error_start_without_terminate` high cycles at **`c + 2`
and `c + 3`, consecutively**; the final frame received intact.

> **This row is why C-23 exists, and the assertion has to be built to see it.**
> §0.6 as revised counts **high cycles, never rising edges**: a strobe high on two
> consecutive cycles is **two events**. A rising-edge counter sees **one** where a
> conformant M03 reported two, and passes. **`Dv_monitors.Strobe_monitor` already
> implements the high-cycle rule and `sample` is total over the run** — use it,
> register **two** expected events, and do not hand-roll a count. This row is the
> first instance on the receive chain and the plan says so.

> **And it drives BOTH no-output-word shapes in one stimulus, which no other row
> in this programme does.** Frame A's start and its closure lie in the **same
> input word**; frame B's lie in **different** words (`c` and `c + 1`). That is
> pure §6.1 geometry, and it is why the epoch-A zero-delivered class owed since
> `J-dv_lead-0065` rides with this family — see §6.

## 3. The two derivation traps this family carries

### 3.1 `Frame.delivered` is the wrong oracle on every abort path

REQ-103 removes the FCS from a frame that ends with a terminate character.
**REQ-110's aborted frame does not end with one**, so nothing is removed and the
delivered set is the frame's received octets **up to and including the one
immediately before the new `/S/`**. `Frame.delivered` would return four too few.

**Per-member governance declaration, as a Return-log deliverable**: for every
frame in every row, state whether REQ-103's removal or REQ-110's no-removal
governs, and cite it. The second (complete) frame in H1/H2/H3 is REQ-103's; every
aborted frame is REQ-110's.

### 3.2 §0.6's window for a frame that delivered nothing

§0.6's upper bound is ΔC = 3 after the input word carrying the frame's **last
received octet**. **M03-H4's frames received none**, so that phrase has no
referent — the same shape as M03-G6's, which the architect ruled on at `1004384`.

**Ruling, and it is grounded rather than invented**: for a zero-delivered frame
the reference word is **the input word carrying the closing character**. Two
supports, and I want both cited in your file:

1. **The principle the architect's ruling derives from** — §9's closure list makes
   a frame's report *a function of the frame rather than of the characters that
   happen to follow it*, and the closure event is the last thing that belongs to
   the frame.
2. **The existing precedent in this bench**: `test_m03_f.ml`'s `run_f2` already
   does exactly this for its `k = 0` member — `expected_not_after = closing_cycle
   + 3` where a frame that received octets uses `((closing_ot - 1) / 8) + 3`.

**The exact pin carries every assertion either way** (`RV-0047` ruling 2, standing:
the window is a secondary bound). **Raised for the architect as §7 question 1** —
whether the truncation-closure ruling's principle generalises to *any* closure
event for a zero-delivered frame — and it **blocks no row**.

**Note the family has no oversize frame**, so the truncation-closure ruling itself
has no instance here. Stated so its absence is not mistaken for an oversight.

## 4. Octet-time intervals, constants, and the lesson that is two rounds old

**Every position in this family is an octet time or a lane, and both must be
derived with their boundary cases worked** — not merely computed. The `k = 1518`
correction (`RV-0056-VERDICT` §1, `J-dv_lead-0075`) happened because a cell stated
how an endpoint was *computed* and never asked what happens *at* it.

1. **Any constant you choose carries a committed guard**, and the guard must be
   able to fail. `test_m03_g.ml`'s five guards on one recommended `k` are the
   standard.
2. **Where I recommend a value it is a derivation to check, not an instruction.**
   If your derivation disagrees with mine, **say so in the Return log** — that
   disagreement is exactly what surfaced the first-epoch boundary, and it reached
   me only because both guards happened to ship.
3. **REQ-101's lane rule binds every placed start character**: lane 0 or lane 4
   only. For a frame starting at octet time `s`, content index `c` sits at octet
   time `s + 8 + c`; work the lane at **both** start lanes and show they agree or
   differ.
4. **A claim about the receiver's state cites the stimulus fact that establishes
   it, or is not made.** These rows need no state claim: every one of them is a
   statement about octet times, lanes, delivered octets and strobes.

## 5. Assertion order, and what a campaign will score

Assertion order is part of each row's contract (`WO-0047` §4.2). **The first
failing assertion is what a mutation campaign is sealed against**, and where a
row loops, which iteration runs first decides the message. State both per row.

Order structural first, specific after: word count → `tlast` cycle → `tkeep` →
`tuser` → delivered **content** → exact strobe set. **In M03-H2 the delivered
content is the row's whole point** and still goes in its usual place — the count
and `tkeep` will already have caught a coarser defect, and the content catches
the one that matters.

## 6. Interaction with family G's next campaign — stated here rather than discovered

`RV-0055`/`RV-0056` left family G with two live items, and family H touches both.
**Say in your Return log if you find any further overlap I have not named.**

1. **M03-G7 is benched but NOT mutation-qualified** — no mutation has ever
   reddened it — and the `/S/`-gated class the WO-0055 seeder rejected is now
   seedable against it. **A `/S/`-gated mutation is the natural next G class, and
   family H is full of start characters.** So the next G campaign's
   MUST-STAY-GREEN column must account for **every unit in this file**, and this
   family's own future campaign must account for M03-G7. Neither can be sealed
   without the other's unit list.
2. **M03-H4 supplies the epoch-A zero-delivered stimulus** owed since
   `J-dv_lead-0065` — a frame whose start and closure lie in **different input
   words**, delivering nothing — which is why I routed that owed class to ride
   with family H. **Frame A supplies the same-word shape in the same stimulus.**
3. **Shared machinery**: the no-output-word accounting helper
   (`account_dropped_frame`'s shape in `test_m03_e.ml`/`test_m03_f.ml`) and, for
   the aborted-but-delivering frames of H1/H2, the truncated-extent entry point
   on the latency tagger (**X-5**, whose docstring names H1 and H2 among its
   intended customers). **Confirm X-5 behaves on an abort extent and report it**,
   as WO-0054 §5 did for the truncation extent; family H is its second exercise.

> **What you may NOT do with any of the above**: `WO-0047` §1.2's
> shared-no-output-path claim remains **UNESTABLISHED and uncitable**
> (`AP` §8 item 5). If a row's reasoning would lean on two no-output-word rows
> sharing a path, **it must carry its own ground instead.**

## 7. Open questions I am carrying upward, not to you

1. **§0.6's reference word for a zero-delivered frame** (§3.2) — routed to
   architect_docs_lead as a scope question: does the truncation-closure ruling's
   principle generalise to any closure event? **Blocks no row**; the exact pin
   carries the assertion and the bench already has a precedent.
2. **§6.3 item 8's carve-out gets its second instance here.** M03-H4 produces two
   reports under the **same strobe name** on **consecutive** cycles — not the
   same cycle, so item 8's prohibition (two frames reported on one cycle under one
   name) is not violated. I have checked that and it holds; I record it so the
   campaign does not have to rediscover it.

## 8. `test/xgmii_rx_64/dune`

Add this packet's line to the header's per-packet list, **and the `WO-0056` line
that is still missing** (`RV-0056-VERDICT` §8 ruled it rides with the next
`test/**` touch, and this is it). **Comment-only**; touch no stanza.

## 9. What you may NOT read

- **Never open `libs/**`, `top/**`, `bin/**` or `rtl_snapshots/**`.** Scope every
  `grep` to `test/` and `docs/specs/`.
- **`docs/reports/audit/**` is out of bounds**, as at WO-0056: it holds mutation
  diffs, and a row written against a mutation is worth nothing.
- Derive every expected value from the specification. `Injection`'s **computed
  outcome model** is an oracle and is gated (`AP` §7's X-1 row — the placement
  machinery is free, the outcome model is not); use it only as a **reported**
  cross-check with the `fail_cross` idiom.

## 10. What I expect back

A Return log appended to this packet plus your journal entry. **No `SO-`.**
Deliverables rather than background:

1. **§3.1's per-member governance declaration**, with clauses cited.
2. **Each chosen octet time and lane, with its committed guard**, and the boundary
   case worked at each end of any interval.
3. **§3.2's window choice** for M03-H4's two frames, with the ground you used.
4. **M03-H4's two expected strobe cycles** (`c + 2`, `c + 3`) derived from §9's
   pin, and confirmation that they are registered as **two** events with the
   high-cycle monitor rather than counted by hand.
5. **X-5's behaviour on an abort extent** (§6 item 3), established not assumed.
6. **Assertion and iteration order** per row.
7. **The unit count you observe**, measured with `tools/dv_checks.sh`'s inventory
   block.
8. Anything you found that this packet did not authorise you to fix — **report it,
   do not fix it.**

## 11. What this packet does not do

`SO-M03` does not issue on family H. After it, **32 of the plan's 62 ASSERT rows**
would be discharged — H1–H4 newly. Families **I, J, K, M, N** and **L1–L5**
remain unwritten, and family H's own qualification campaign is a separate packet
with its classes published and its row mapping sealed.
