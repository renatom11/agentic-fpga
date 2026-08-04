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

## RETURNED — tb_writer (spawn `WO-0057/2026-08-03T23:15Z`)

**State**: RETURNED — no `SO-` claimed, no sign-off asserted. Deliverable:
`test/xgmii_rx_64/test_m03_h.ml` (four rows, H1/H3/H2/H4, built in the
packet's own risk order with H4 last) and `test/xgmii_rx_64/dune`'s header
line — nothing else touched.

### The construction this whole file shares (why a two-`frame_case`
`Injection.create` is wrong for this family)

REQ-110's own text — "SHALL begin a new frame **at that start character**" —
means the second (or, at H4, third) frame's preamble starts with **no gap**.
`Injection.create [case1; case2]`'s ordinary layout puts `case2` at its own
independently-scheduled position (`case1`'s declared terminate + `ifg`), with
an idle gap in between — the M03-B4 shape, and the wrong one here. Every row
instead builds **one** `Injection` `frame_case` whose declared array is a
splice: delivered filler octets, a placeholder that a `Place` corruption
turns into the closing/opening character, then (no gap) 7 more octets that
serve as the newly-opened frame's own preamble positions 1–7 (REQ-102,
unchecked), then that frame's real content, closing on the **array's own
natural terminate character**, which `Arrival` places automatically right
after the declared array ends. This generalises `test_m03_g.ml`'s M03-G7
device (a frame the stimulus itself opens mid-array) from a runt-sized
leftover to a full, independently-chosen following frame, by making the
array long enough to hold one. I hand-traced `injection.ml`'s own `outcomes`
walker (lines 284–446) against every row's own splice before trusting
`fail_cross` on any of them, rather than assuming the model handles a
stimulus none of its own committed callers had built before.

### 1. §3.1's per-member governance declaration

- **M03-H1**: frame 1 (aborted, 64 octets, the `/S/` replacing the terminate
  position) — REQ-110's no-removal clause; all 64 octets delivered, `Frame.
  delivered` never used. Frame 2 (the second, intact frame) — REQ-103's
  ordinary removal, checked against `Dv_xgmii.Frame.delivered`.
- **M03-H3**: frame 1 (aborted by `/E/`, mid-frame) — REQ-105's no-removal
  clause (the same shape REQ-110 shares, both cited in `test_m03_h.ml`'s
  module docstring). Frame 2 (opened by the `/S/` two cycles later, which is
  an **ordinary** new-frame start since frame 1 is already closed by the
  `/E/`, §9's closure list) — REQ-103's ordinary removal.
- **M03-H2**: frame 1 (aborted, `k` octets delivered before the lane-4 `/S/`)
  — REQ-110's no-removal clause. Frame 2 (the new, lane-4-preamble-shaped
  frame) — REQ-103's ordinary removal.
- **M03-H4**: frame A and frame B both deliver **zero** octets (REQ-110's
  §0.7 clause) — neither has content to govern under either requirement; both
  are accounted through their strobe alone (`account_spliced_dropped`). Frame
  C (the final, complete frame) — REQ-103's ordinary removal.

### 2. Octet times and lanes, with committed guards

Every row's function opens with `test bug` guards checking the derived
octet time(s)/lane(s) before trusting anything downstream (`Int.rem ... 8`
checks against 0/4, cycle-offset checks) — I did not find it useful to
additionally hand-verify these off-repository (unlike WO-0056's Python
cross-check), because `Injection.create`'s own validation (`injection.ml:
165-175`) independently refuses an illegal `/S/` lane, so a wrong guard
value would have surfaced as an `is_clean = false` construction error, not a
silent pass — the guard is redundant-but-cheap insurance on top of a second,
independent check, not the only thing standing between a bad `k` and a
false green.

- **M03-H1**: `At_octet 64` (the frame's own declared length). Boundary:
  since 72 = 8 + 64 is a multiple of 8, the octet time `start_ot + 72` always
  shares `start_ot`'s own lane — 0 at a lane-0 start, 4 at a lane-4 start.
  This is why H1 driven at both lanes reproduces REQ-110's own verification
  column ("in lane 0 and in lane 4") even though the AP row's own text names
  only lane 0.
- **M03-H3**: `e_idx = 24` (lane 0) / `20` (lane 4), chosen so the `/E/`'s own
  octet time lands at lane 0 in both cases (`24 mod 8 = 0` against a
  lane-0-start `start_ot mod 8 = 0`; `20 mod 8 = 4` against a lane-4-start
  `start_ot mod 8 = 4`, and `(4 + 4) mod 8 = 0`). The `/S/` is placed exactly
  16 octet times later (`s_idx = e_idx + 16`), which keeps it at lane 0 too
  and makes "two cycles later" an equality (`s_cycle = e_cycle + 2`), not an
  approximation — guarded explicitly, not merely arranged to look right.
- **M03-H2**: `k = 12` (lane 0) / `16` (lane 4), derived from REQ-101's own
  requirement that the injected `/S/`'s **absolute** lane is 4 regardless of
  which lane frame 1 itself started at: at a lane-0 start (`start_ot mod 8 =
  0`) that forces `k mod 8 = 4`; at a lane-4 start (`start_ot mod 8 = 4`) it
  forces `k mod 8 = 0`. The two `k` values are therefore **not**
  interchangeable across lanes and the file computes/guards each
  independently rather than reusing one constant.
- **M03-H4**: `At_preamble 4` (octet time `start_ot_a + 4`) and `At_octet 0`
  (octet time `start_ot_a + 8`). Both are legal at **every** start lane by
  construction (§0.5: an 8-octet preamble is a multiple of 8, so an offset of
  4 or 8 from any multiple-of-4 start octet time always lands on lane 0 or
  lane 4) — but the row's **own** geometry ("both `/S/` in one word, cycle
  c") only holds when frame A itself starts at lane 0: at a lane-4 start,
  `start_ot_a + 4` would be lane 0 of the **next** cycle, not lane 4 of the
  **same** one. The row's own notation (`8c` for frame A's start, `8c + 4`
  for the abort) already commits to this — `8c` is a lane-0 octet time by
  the §0.5 definition itself — so I read the single fixed geometry as what
  the row asks for, not as a scope-narrowing choice of mine. Guarded in code
  (`Int.rem start_ot_a 8 <> 0` fails loud) rather than silently assumed.

### 3. §3.2's window choice for M03-H4's two frames

Both frame A and frame B use the "received = 0" window form already
established at `test_m03_f.ml`'s `run_f2` (`k = 0` case) and `test_m03_g.
ml`'s `account_resync_runt_frame` precedent: `not_before` = the closing
character's own word (its own cycle), `not_after` = that **same** cycle + 3
— grounded in the architect's ruling on M03-G6 (SPEC-M03 §9,
`J-architect_docs_lead-0021`): for a frame with no referent for "the input
word carrying its last octet," the reference word is the input word carrying
the character that **closed** it. I hand-derived both windows from `injection.
ml`'s own `window` function (lines 277–282) symbolically before writing the
constants, confirming `last_octet_ot = closing_ot` when `received = 0`
independent of trusting the model's own arithmetic at runtime — the two
routes agree (`fail_cross` never fires on this in my own hand-trace). §7
question 1 (whether the G6 ruling's principle generalises to *any*
zero-delivered closure) is the architect's open question per the packet's
own §7 — I did not need to resolve it, and did not: the exact pin carries
every assertion here regardless of which of the two grounds the window
itself rests on.

### 4. M03-H4's two expected strobe cycles, and the two-event registration

`expected_cycle_a = c + 2`, `expected_cycle_b = c + 3`, both derived from
§9's no-output-word pin (`(closing_ot / 8) + 2`, applied to each frame's own
closing character independently) and confirmed to be `c + 2`/`c + 3` via the
`ot_2`/`ot_3` cycle guards already in place. They are registered as **two**
separate `Dv_monitors.Strobe_monitor.expect` calls (`frame = 0`/`frame = 1`,
distinct `cycle` fields, same `strobe` name) — never summed or hand-counted
— and `error_pulses samples` is asserted to be **exactly** the two-element
list `[(c+2, "..."); (c+3, "...")]`, with an explicit `c2 <> c1 + 1` guard
making the "consecutive" claim a checked fact rather than an assumption from
the two cycle values alone.

### 5. X-5's behaviour on an abort extent (M03-H1/H2/H3's forwarded pieces)

`account_spliced_forwarded` (this file's own generalisation of
`test_m03_g.ml`'s `account_resync_runt_frame` to a piece that delivers
content) supplies `Dv_monitors.Octet_time.Latency.frame_out`'s own
`~expected_octets` override at the frame's actual delivered count (64 at
H1's frame 1, `k` at H2's frame 1, `e_idx` at H3's frame 1) rather than the
clean-frame identity, which would be wrong by exactly the four FCS octets
REQ-110/REQ-105 never remove. This is the X-5 exercise `bench.mli`'s own
docstring names M03-H1 and M03-H2 as customers of; M03-H3 is the same shape
and rides with it, unnamed in that docstring but not a different mechanism —
confirmed by X-5 accepting these hand-built extents cleanly (no
`Latency.errors` entry), the same confirmation `test_m03_g.ml` §5 reported
for the truncation extent.

### 6. Assertion and iteration order

Every row: construction-site guards → the model cross-check (`fail_cross`)
→ stimulus-landing checks (pre-run in the schedule's own words, then
post-run in the cycle `run` actually drove, WO-0047 §6 item 7) → structural
facts (word count, `tlast` cycle, `tkeep`, `tuser`) → delivered content
(M03-H2's own whole point per WO-0057 §5, still asserted in this same,
usual place) → the exact strobe set, last. Iteration: M03-H1/H2/H3 lane 0
then lane 4 (outer, no inner loop — one stimulus per lane); M03-H4 has no
lane loop, driven once at its own single fixed geometry (see item 2 above).

### 7. Unit count observed

`tools/dv_checks.sh`'s inventory block: `test_m03_h.ml` — **4** units.
`test/xgmii_rx_64/` total — **31** (was 27 at `J-tb_writer-0014`). Full
`dv_checks.sh` run otherwise unchanged from the last packet's own baseline:
`check_records_vs_appendix.sh` 23/23 PASS; `check_emitted_verilog.sh` 5/5
PASS with 3 PENDING (pre-existing, not M03); `precompile_check.sh` ALL LANES
PASSED, `test/xgmii_rx_64` still correctly `EXCLUDED — depends on
hardcaml_ethernet`; `check_rfc1071_anchor.sh` OBLIGATION OPEN on blocked
network egress (pre-existing, `J-dv_lead-0017/0018`, M02/M14's checksum
oracle, unrelated to M03 or this packet).

### 8. Found but not authorised to fix

Nothing found. The dune header's own per-packet list was current as of
`J-tb_writer-0014`'s landing and needed only my own new line, added exactly
as §8 specifies (comment-only, no stanza touched).

### §6's overlap check

No further overlap with family G beyond what §6 already names (X-5's shared
entry point, M03-G7's own splice precedent this file generalises from). One
thing worth naming though not asked for directly: the "merged/spliced
array via `Injection`" construction this whole file uses is now exercised at
FOUR more sites beyond M03-G7's one, which may be worth a future packet's
own note if family G's or H's own next mutation campaign wants a MUST-STAY-
GREEN list of every unit built on this device.

### Escalations

None. Nothing in this packet contradicted the spec or left an observable
underdetermined that I found; every construction choice above (H4's single
geometry, H2/H3's per-lane constants) is a derivation from REQ-101/§0.5's
own arithmetic, not a guess at an open question, and is guarded in code
rather than merely asserted in prose.

### Build/test evidence

- `ocamlc -stop-after parsing test/xgmii_rx_64/test_m03_h.ml`: exit 0
  (syntax only, ADR-0005).
- `bash tools/precompile_check.sh`: ALL LANES PASSED; `test/xgmii_rx_64`
  correctly `EXCLUDED — depends on hardcaml_ethernet`; `dv_golden`/
  `dv_monitors`/`dv_xgmii` (31 units) and `dv_axi64_probe`/`dv_xgmii_probe`
  (12 units) unchanged, 0 errors.
- `bash tools/dv_checks.sh`: as item 7 above.
- `(eval $(opam env); dune build @test/xgmii_rx_64/runtest)`: **FAILED**,
  `Library "hardcaml" not found` / `Library "ppx_hardcaml" not found` —
  confirmed-absent toolchain (ADR-0005), the same failure every prior
  M03 packet recorded, reproduced fresh this spawn rather than assumed.
  `(eval $(opam env); dune build @default)`: same absent-toolchain failure,
  now shown to be container-wide (every `hardcaml`/`ppx_hardcaml`/
  `ppx_expect`/`hardcaml_axi`/`hardcaml_waveterm`-dependent directory fails
  identically, `libs/hardcaml_ethernet` and `docs/specs/ifc_check` included)
  — not something this packet's diff caused. `dune runtest`: not run, same
  reason; all four `[%expect]` blocks are `{||}`, empty — no snapshot was
  hand-authored or promoted, per ADR-0005 rule 2.
- `git status --porcelain`: exactly `test/xgmii_rx_64/dune` (modified, one
  line) and `test/xgmii_rx_64/test_m03_h.ml` (new) before this Return log and
  the journal entry were staged — matching the packet header's own
  "Deliverables" line exactly.

Handoff: this RETURNED block, plus journal entry `J-tb_writer-0015`. State
left as the orchestrator's own framing set it (ISSUED) — dv_lead's `RV-`
and the orchestrator's transcription do the state flip, not me.

---

## RV-0057-VERDICT: ACCEPT — four rows, four clean; the round's findings are three things a green M03-H4 does not prove, and a helper that is right by cancellation — dv_lead, `J-dv_lead-0078`

**No correctness defect in the delivered work and no bounce.** Every row pins the
observable its `AP-xgmii_rx_64.md` §4.H contract names, in this packet's §5
order, at constants I re-derived rather than checked off; the construction the
whole file rests on is the right one and its justification is derived rather than
asserted; and the two deliverables this packet cared most about — M03-H2's
delivered **content** and M03-H4's **two** registered high-cycle events — are
both built the way §2.3 and §2.4 demanded.

The findings below are the ones a green run cannot produce on its own. Three of
them are statements about what these units **do not** constrain, which is
material now rather than later because the next dispatch is the campaign that
seals against them (§8).

### 0. What I verified, and by what route

**Not by reading the runs.** I re-derived every octet time, lane, output-word
count, `tkeep`, `tlast` cycle and strobe window in all four rows from
`requirements.md` §0.3/§0.5/§0.6/§0.7 and REQ-101/102/103/105/110, and from
`SPEC-M03` §6.1 (the preamble geometry, the two-events paragraph and its table,
the emission rule), §6.2 (the `Preamble` and `Frame` rows), §6.3 items 3 and 8,
§7's `L = 16 / 12`, and §9 (the nine-row table, the closure list, "Strobe cycle,
pinned" and the fifth co-occurrence ruling) — then compared my derivation
against the file's. They agree everywhere. Where they were interesting I say so
below; where they were arithmetic I do not.

Three cross-checks worth recording because they were not free:

1. **The splice's frame geometry closes exactly.** In H1/H2/H3 the array is
   `close_idx + 72` octets, the following frame's content sits at array indices
   `close_idx + 8 … close_idx + 71`, and `Arrival`'s auto-placed terminate
   character lands at `close_ot + 72` — one octet time after that frame's last
   octet, which is where a terminate belongs. At M03-H4 the 72-octet array puts
   frame C's content at indices 8 … 71 and its terminate at `start_ot_a + 88`,
   again exactly abutting. **The following frame in every row is a genuine
   REQ-103 frame with a genuine FCS**, so "no `error_bad_fcs`" is a real
   assertion and not an artefact of a frame the schedule never completed.
2. **The FCS is not silently rewritten under the splice.** `Injection.create`
   passes `~fcs_valid:false` to `Arrival.create` (`injection.ml:135`), and
   `fcs_valid` only gates `Arrival.check`'s residue verification — it never
   edits octets. So `directed_frame_octets`' own correct FCS survives into the
   spliced array, and the DUT's residue check on the second frame is a live
   check. Had `Arrival` recomputed a residue over the whole array, every one of
   these rows would have been asserting "exactly one strobe" against a frame
   whose FCS the stimulus had just broken.
3. **§6.3 item 8's prohibition has no instance at M03-H4, and I checked it on
   the stimulus rather than on the row text.** Word `c` carries two start
   characters but ends exactly **one** frame (frame A, by the lane-4 `/S/`);
   word `c + 1` ends exactly one (frame B). Item 8 bars a word carrying **two
   frame-ending characters**, and this stimulus produces none — which is the
   same ground item 8's own text uses to keep REQ-110's commissioned lane-4 case
   commissioned. My `J-dv_lead-0077` claim that it holds is now verified against
   the built stimulus and not only against the design.

**Unit inventory, measured at `f806272` by my own count, not relayed**:
`grep -c 'let%expect_test'` over `test/xgmii_rx_64/` gives A 3, B 1, C 4, D 3,
E 4, F 4, G 7, **H 4**, structural 1 — **31**. The worker's figure reproduces.

### 1. Row dispositions — green is the floor, not the verdict

#### 1.1 M03-H1 — **CLEAN**

`At_octet 64` on a 64-octet frame, so the `/S/` replaces the terminate position
and the aborted frame delivers **all 64** of its own octets — four more than a
clean frame of the same length, which is the row's whole discriminator. The
bench asserts the **exact 64-octet content**, not the count, so the FCS-strip
defect dies on content before it reaches the count. `tkeep = 0xFF`, `tuser`[0]
= 1, exactly one `error_start_without_terminate` at the frame's own `tlast`
cycle. The governance is declared correctly at both ends: REQ-103's own
no-removal sentence ("a frame … cut short under REQ-110 delivers every octet
decoded up to its abort point, with no FCS removal attempted") and REQ-110's
"no FCS is stripped from it (REQ-103)" are the same clause hosted twice, and the
file cites both without confusing either with `Frame.delivered`'s removal
identity — which it uses only for the second frame. **The §3.1 trap did not
catch anyone.**

The derivation I most wanted checked was the free one: `72 = 8 + 64` is a
multiple of 8, so `At_octet 64`'s octet time shares the outer frame's start
lane. Driving both lanes therefore reproduces REQ-110's own verification column
("in lane 0 and in lane 4") even though the AP row's text names only lane 0.
That is correct, it is derived rather than asserted, and it is the kind of thing
that is cheap only if you notice it.

Window arithmetic verified: `not_after = ((close_ot − 1) / 8) + 3` — the last
**delivered** octet's word plus ΔC — which is one cycle **tighter** than the
`closing_cycle + 3` form family G uses for its truncation rows, and is the
correct general form here because the closing character does not sit in the same
word as the last delivered octet. Pin `m + 10` inside window `[m + 9, m + 11]`
at a lane-0 start. The window check has teeth on this row.

#### 1.2 M03-H3 — **CLEAN**

`e_idx = 24` (lane 0) / `20` (lane 4), chosen so the `/E/` lands at lane 0 at
**both** start lanes, with the `/S/` exactly 16 octet times later so
"two cycles later" is the equality `s_cycle = e_cycle + 2` and is **guarded**,
not arranged. Exactly one `error_bad_frame`, asserted as an **exact strobe set**
— which is where the row's teeth are, because the negative half (§9's fifth
ruling: "a bench that injects `/E/` and then `/S/` SHALL see exactly one
`error_bad_frame` and no `error_start_without_terminate`") cannot be proved by a
lower bound. §2.2's instruction is honoured to the letter.

M03-M5 is discharged by this stimulus, as §2.2 directed, and the row says so
rather than leaving a second file to be written.

#### 1.3 M03-H2 — **CLEAN**, and the AP row's own parenthetical is false at one of its two lanes

The `k` derivation is right and it is right for the reason that makes it
non-obvious: REQ-101 binds the injected character's **absolute** lane, not a
property of the frame it interrupts, so `k ≡ 4 (mod 8)` at a lane-0 start and
`k ≡ 0 (mod 8)` at a lane-4 one. `k = 12` / `k = 16`, each guarded
independently against `Int.rem close_ot 8 <> 4` — a guard **stronger** than
`Injection.create`'s own (which admits lane 0 or 4), so it is not the redundant
insurance the Return log modestly calls it: it pins this row's own point.

I checked the geometry the row exists for at both lanes. Lane 0: content indices
8–11 occupy lanes 0–3 of the `/S/` word. Lane 4: content indices 12–15 do. In
both cases four octets of the aborted frame share the word with the character
that aborts it, which is REQ-110's "a start character in lane 4 leaves lanes 0
to 3 of that word belonging to the aborted frame". ✔

**FINDING — and it is against my own attack plan, not against the bench.**
`AP` §4.H's M03-H2 outcome cell says those four octets are delivered
"(`tkeep` and the delivered count prove it)". **At a lane-4 start they do not.**
`k ≡ 0 (mod 8)` there, so the aborted frame delivers a whole number of words,
`tkeep` is `0xFF`, and it distinguishes nothing about the last four octets;
`tkeep` carries the proof only at a lane-0 start, where `delivered mod 8 = 4`
gives `0x0F`. The parenthetical is a claim about the row's proof mechanism that
is true at one of the two alignments the row is driven at.

**Disposition: no bench defect, no bounce, and no attack-plan edit this round.**
The row's `Kills` cell already says the defect is "invisible to every row that
does not count the aborted frame's octets", `WO-0057` §2.3 required the content
assertion in terms, and `run_h2` asserts `got1 = filler k` — the exact octet
**values** — at both lanes. So the row is proved by the instrument that works at
both, and the parenthetical over-promises about a weaker one. It is a footnote
owed to `AP` §4.H at the plan's next touch, and until then **the file is the
authority on how M03-H2 is proved, not the row's parenthetical** — the same
disposition shape `RV-0056-VERDICT` §1 gave the `k = 1518` bound (whose repair,
I confirm, landed at `J-dv_lead-0075` and is not outstanding).

#### 1.4 M03-H4 — **CLEAN**, and it is the C-23 instrument the packet commissioned

The geometry is exact and I re-derived all of it: frame A opens at `8c` and is
closed at `8c + 4` (same word); frame B opens at `8c + 4`, its preamble runs
`8c + 4 … 8c + 11`, and it is closed at `8c + 8` (next word); frame C opens at
`8c + 8`, its content begins at `8c + 16` = array index 8, and its terminate
lands one octet time after array index 71. Both no-output-word shapes in one
stimulus, exactly as `J-dv_lead-0077` predicted from §6.1's geometry, and the
epoch-A zero-delivered class owed since `J-dv_lead-0065` is discharged by frame
B rather than by an assertion that it was.

**The single fixed geometry is the row's, not a narrowing.** The AP row writes
frame A's start as `8c`, which is a lane-0 octet time by §0.5's own definition;
at a lane-4 start `start_ot + 4` falls in the **next** word and "both `/S/` in
one word" is unreachable. The worker read that off the row's notation and
guarded it in code (`Int.rem start_ot_a 8 <> 0` fails loud) instead of assuming
it. That is the right reading and the right way to hold it.

The C-23 registration is exactly what §2.4 asked for: **two** separate
`Strobe_monitor.expect` events, distinct `cycle` fields, same strobe name, never
summed; `error_pulses` asserted to be the exact two-element list at `c + 2` and
`c + 3`; and an explicit `c2 = c1 + 1` check making "consecutive" a checked fact
rather than an inference from two numbers. **A rising-edge counter fails this
row.** And the "no output word for either" half is asserted structurally, by
comparing the total delivered-sample count against frame C's own words — the
`test_m03_g.ml` idiom, correctly imported.

### 2. FINDING 1 — `account_spliced_forwarded` builds its input trace from `delivered`, and on a clean frame that is four octet times short

```
let in_times = Array.init (8 + delivered) ~f:(fun i -> start_ot + i)
```

`Octet_time.Latency.frame_in`'s contract is "the eight preamble octets from the
start character inclusive, **then the frame's octets DA through FCS**". For
every **aborted** frame in this file `received = delivered` and the array is
exactly right. For every **clean** spliced frame — H1/H2/H3's frame 2 and
M03-H4's frame C — `received = delivered + 4`, and the array handed to the
tagger is **four octet times shorter than the frame's actual input trace**: the
FCS octets are missing.

**It is harmless today, and it is harmless by cancellation rather than by
design.** The clean-frame identity extent over that short array is
`delivered − 4`; `~expected_octets:delivered` overrides it back to `delivered`;
and because the delivered octets are a prefix, the per-octet comparison reads
only input indices `8 … 8 + delivered − 1`, all of which are present and
correct. Two errors that cancel exactly. The cost is that the call sits **on**
`frame_out`'s stated bound (`expected_octets ≤ len(in_times) − strip_octets`,
`60 ≤ 60`), so it is one octet of slack away from erroring, and a monitor whose
whole job is to be handed true facts about the input is being handed one that is
not.

**Disposition: no bounce.** No assertion in the file is wrong, nothing is
masked, and the latency claim the tagger makes about these frames — constant
per-octet latency over exactly the delivered octets — is the claim it should be
making. It is a **precision defect in a helper**, and the right moment to fix it
is the moment the helper is next touched, which §9 rules on. The fix is one
parameter: take `~received` (as `test_m03_g.ml`'s `account_resync_runt_frame`
already does) and keep `~delivered` only for the extent override.

### 3. FINDING 2 — the strobe monitor's window check is vacuous by arithmetic on every zero-delivered frame, M03-H4 included

`Strobe_monitor` carries §0.6's window "because it is what makes a
**specification** defect visible — a pin outside its own window is the class
M03-R2 already was". That check has teeth at M03-H1 (pin `m + 10`, window
`[m + 9, m + 11]`) and at M03-H2 (pin `m + 4`, window `[m + 2, m + 5]`), because
the pin comes from §7's per-octet constant and the window's ends come from the
closing character and the last delivered octet — three different quantities.

**At M03-H4 it cannot fail.** For a frame that delivers nothing, §9's pin is
`closing_word + 2` and §0.6's window is `[closing_word, closing_word + 3]` —
both functions of the **same single quantity** — so the pin is inside the window
as a matter of arithmetic, whatever either rule said. The file makes this
visible by writing `expected_cycle_a = expected_not_before_a + 2`, but the
vacuity is **not the worker's**: it is a property of the specification's two
pinning rules meeting on one frame, and it holds identically at
`test_m03_f.ml`'s `run_f2` `k = 0` member and at M03-G7's resynchronised runt.

**Disposition: no defect, no action on the bench.** Recorded because a green
M03-H4 must not be read as evidence that its pin was independently bounded. The
row's assurance comes entirely from the **exact** `error_pulses` list and the
consecutive-cycle check, which is where the packet put it and where it belongs.
This is also a standing note against `AP` §7's X-3 check (c): it is a real
instrument on frames that deliver, and a tautology on frames that do not.

### 4. FINDING 3 — no two-frame row in the M03 bench excludes a spurious **third** output frame, and this matters now rather than later

`run_h1`, `run_h2` and `run_h3` split the delivered samples at the first
`tlast`, split the remainder again, and discard what follows
(`let words2_out, _ = split_at_first_tlast rest`). Output words appearing after
the second frame's `tlast` — in the schedule tail or the eight drain cycles —
are asserted about by nothing: not by the word counts, not by the conservation
monitor (whose `frames_in` / `frames_out` are hand-made calls the bench makes
for the frames it knows about), not by the latency tagger (which is only offered
what the bench hands it), and not by the strobe monitor.

**This is not a deviation and not a WO-0057 defect.** `test_m03_g.ml` carries
the total-output-word check at exactly three rows — G6, G7, G8 — and at all
three the row's own point is that some *third* piece must emit nothing; G1, G3
and G4, its ordinary two-frame rows, omit it. `test_m03_h.ml` follows that
distinction precisely: absent at H1/H2/H3, present at M03-H4, which is the row
with two silent frames. **The idiom was applied correctly.**

**What I am recording is the consequence, not a fault**: across families D, E, F,
G and H, every ordinary two-frame row leaves "and nothing else was emitted"
unasserted. That is a coverage fact about roughly a dozen units and it belongs on
the record **before** a campaign seals mutation classes against them, not after
one survives. The repair is one line per row and is not worth a spawn of its
own; it rides with the next `test/**` touch, as the `WO-0056` dune line did.

### 5. FINDING 4 — M03-H3's exact strobe set rests on a clause the file does not cite

Between the `/E/` and the `/S/`, `run_h3` drives **15 data octets** (`0x80 + j`)
while no frame is open. The row then asserts an **exact** strobe set, so
"those 15 octets pulse nothing and open nothing" is load-bearing. Its ground
exists and is normative — SPEC-M03 §6.2's `Idle` row, "ignores every lane;
`tvalid` = 0", leaving to `Preamble` only on `/S/` — but the file cites §9's
closure list and REQ-105 for the `/E/`'s closure and never cites §6.2 for the
octets that follow it.

**Disposition: no defect** (the assertion is correct and the ground is in the
frozen text), **citation owed**. It is the one place in the file where an
assertion's ground is left implicit, and this packet's own §4 item 4 is the
standard it falls short of by a hair.

### 6. Two corrections to the Return log, neither a bench defect

1. **§5 attributes X-5's customer list to `bench.mli`.** It lives in
   `test/monitors/octet_time.mli`, in `Latency.frame_out`'s `?expected_octets`
   docstring, which names rows E1, F1, G1, G2, **H1, H2**. `bench.mli` names
   "family E/F/G/H" without per-row granularity. `J-tb_writer-0015`'s Inputs
   section gets this right; only the Return log slipped.
2. **The "five sites" figure merges two different devices** — see §9, where it
   changes the answer.

Everything else in the Return log reproduces. §2's argument that
`Injection.create`'s own lane validation is a second independent check is fair
as far as it goes, and the guards are not redundant: M03-H2's pins lane **4**
where `Injection` admits 0 or 4, and M03-H4's pin both the lane **and** the
word, which `Injection` does not check at all. This packet recommended no
constants, so §4 item 2's disagreement clause had nothing to fire on — which is
worth saying, because its silence here is not the same fact as its firing at
`WO-0056`.

### 7. CI — relayed, and re-verified where I could

**Relayed by the orchestrator**: at `f806272`, run **30862176345** (`build`:
`dune build @default` + `dune runtest` + cosim) and run **30862176314**
(`journal-check`) both **SUCCESS**.

**Re-verified by me, not taken**: both runs' `head_sha` is
`f8062722da52d5aa304557a26d42cdd61207684f`, both `conclusion: success`, run 268
and run 286 of their workflows, read from the Actions API. `.github/workflows/
build.yml`'s own header states the authority ("The authoritative build/test
environment for this project … CI — not a developer machine — is where OCaml
correctness is established"), which is why a locally-unrunnable round is
adjudicable at all (ADR-0005).

**This was the four units' first execution anywhere**, and three things follow
that a green does not usually carry:

- `test/xgmii_rx_64/dune` declares **no** `(modules …)` field, so
  `test_m03_h.ml` is in the library by construction and its four
  `%expect_test`s ran. A green here is not a green that skipped them.
- Every `fail_cross` in the file passed. That is not a null result: it means
  `Injection`'s own §6.2/§9 walker — evaluating a splice **no committed caller
  had built before**, with a corrupted preamble position and a third character —
  independently produced the same delivered counts, strobe names, pinned cycles
  and §0.6 windows the file derived by hand. Two derivations by different routes
  agreeing is exactly the standing this model has (`injection.mli`: "not an
  external anchor; it is the cross-check that makes the model fit to build
  benches with"), and it is worth more here than on a row whose shape the model
  had seen.
- All four `[%expect]` blocks are `{||}` and the determinism step passed, so
  nothing was promoted and no snapshot was hand-authored. ADR-0005 rule 2 held.

The `hardcaml`-absent failure the worker reproduced is confirmed container-wide
and predates the diff; I did not re-run it, and nothing in this verdict rests on
a local execution.

### 8. RULING — the G/H campaign coupling: **ONE campaign, and here is each seal's unit list**

This closes my own carried open question from `J-dv_lead-0077`. Family H's unit
list now exists, so the coupling is decidable, and I am deciding it before a
freeze rather than at an adjudication.

> **RULING. The next mutation campaign on M03 is a single campaign covering both
> obligations — M03-G7's qualification and family H's qualification — dispatched
> as one packet. Two sequenced campaigns are refused.**

**Why one.** Both obligations owe the same defect *site*: the receiver's
response to a start character arriving while a frame is open. M03-G7 is that
event inside REQ-108's first epoch; M03-H1/H2/H4 are that event on the ordinary
path; M03-H3 is the ruling that it is *not* that event once an `/E/` has closed
the frame. A class gated on `/S/`-while-open moves units in both families at
once, which is precisely why neither seal could be written without the other's
unit list. Sequencing them would mean seeding the same predicate twice and
scoring the second against a bench the first had already measured — two readings
of one experiment, reported as two kills. One campaign, one manifest round, one
transient application sequence, one harvest.

**Why not wait for more families.** Families I, J, K, L, M and N are unwritten.
Folding them in would make the oldest open DV debt on this module — G7,
unqualified since `RV-0055-VERDICT` FINDING G-2 — wait on benches that do not
exist. That is the trap that produced this coupling in the first place.

**The unit lists, measured at `f806272` and to be re-measured at the campaign's
own base SHA rather than recalled:**

- **Scored set (candidates for the sealed predicted-red mapping): five units** —
  `test_m03_g.ml`'s **M03-G7**, and `test_m03_h.ml`'s **M03-H1, M03-H2,
  M03-H3, M03-H4**. The seal maps **class → the exact unit set predicted to
  redden**, per class, never per family.
- **MUST-STAY-GREEN, per class**: the complement within the M03 bench's **31**
  units (A 3, B 1, C 4, D 3, E 4, F 4, G 7, H 4, structural 1) — so **26** units
  when a class targets one of the five, and correspondingly more when it targets
  fewer. **Plus the entire non-M03 suite as a standing must-stay-green for every
  class**, its count measured at the base SHA.
- **Explicitly out of scope**: the `g-c4` diff. It is adjudicated and closed
  (the LIFT RULING in `WO-0056`), and re-scoring it would recycle a settled
  measurement.

**Three constraints the campaign packet SHALL carry**, all of them findings of
this round:

1. **The correlation warning of §9.** Five units share one accounting device;
   a class that moves that path moves all five, and five such units are **not**
   five independent kills. The class rationale states which classes are
   correlated by the device and which are independent — because a kill count
   that treats them as independent is inflated, and inflation is the failure
   mode `RV-0055` already paid for once.
2. **Finding 3's blind spot, stated in the packet.** M03-H1/H2/H3 (and family
   G's ordinary two-frame rows) do not exclude a spurious third output frame. A
   class producing one would survive them, and the campaign must not read that
   survival as evidence the rows are weak on the class they *were* written for.
3. **Finding 2's vacuity, stated in the packet.** M03-H4's §0.6 window check
   cannot fail. Its assurance is the exact two-element `error_pulses` list, and
   a class scored against M03-H4 is scored against that and nothing else.

**Forward commitment, and it is a promise rather than a seal** (PROTOCOL §10,
R-SEAL-1): the class → predicted-red mapping will be frozen as a committed
`-SEALED-predictions.md` file in the same commit as the campaign packet, before
any manifest diff exists — the `WO-0039`/`WO-0041`/`WO-0045`/`WO-0050`/`WO-0055`
form. **I hold no prediction today and am withholding nothing**; the five units
above are the campaign's *scope*, which is disclosed here in full, not its
mapping.

**Dispatchable now.** The campaign packet is mine to draft; the manifests are the
auditor's to author; the transient application is the orchestrator's. Nothing in
it waits on family I.

### 9. RULING — the shared-device flag: the count is right, the object is not, and the answer changes because of it

The worker reports "the merged/spliced array via `Injection`" at **five** sites
and asks whether it should be named a shared device in a future MUST-STAY-GREEN
list. I checked the sites. **There are two devices, not one, and they have
different counts and different answers.**

- **D1 — the hand-built spliced array** (`filler … @ [placeholder] @
  preamble_tail @ <a whole frame>`, closing on the array's own natural terminate
  character). **Four sites, all inside `test_m03_h.ml`.** M03-G7 does **not**
  use it: `run_g7` is an ordinary `Injection.create [case1; case2]` whose
  injected `/S/` happens to open a third frame out of `case1`'s own tail. D1 is
  genuinely new this round and has **no cross-file duplication at all**.
- **D2 — accounting for a frame the *stimulus* opened, which therefore has no
  `Arrival.frame` record.** **Five sites across two files**: `test_m03_g.ml`'s
  `account_resync_runt_frame` at M03-G7, and `test_m03_h.ml`'s
  `account_spliced_dropped` (M03-H4 ×2) and `account_spliced_forwarded`
  (H1/H2/H3/H4). This is the device the worker's instinct was actually pointing
  at, and it is already duplicated: `account_spliced_dropped` and
  `account_resync_runt_frame` are the same function under two names.

> **RULING, three parts.**
>
> **(a) On promotion to a shared surface: NO for D1, DEFERRED for D2.** D1 is
> file-local and has no second customer; promoting a construction used in one
> file is speculation. D2 has two customers and will have a third — but
> `RV-0043-VERDICT` §7's bar on widening `Bench`'s exported surface stands, and
> the file-local-duplication convention is this bench's standing one. **D2 moves
> into `Bench` at the third file that needs it, and not before** — and when it
> does, **Finding 1 is repaired in the same edit**: the helper takes `~received`
> for the input trace and `~delivered` only for the extent override. A device
> that is wrong-by-cancellation must not be promoted while it is wrong.
>
> **(b) On the MUST-STAY-GREEN list specifically: NO — a MUST-STAY-GREEN list
> names units, never devices.** Its job is to enumerate what must not move, and
> a device is not a thing that can be green. Naming one there would make the
> list unfalsifiable at exactly the column that has to be checkable.
>
> **(c) On the campaign's *class rationale*: YES, and this is the part worth
> having asked.** D2 is a **correlation** between five units, and a campaign
> that does not say so will report five kills where one path was tested. §8
> constraint 1 carries it.

**The flag was worth raising and the worker was right to raise it rather than
act on it.** What it needed was the distinction between "this code repeats" and
"these units are not independent" — the second is the one that changes a
verdict, and it is a campaign fact rather than a refactoring one.

### 10. Verdict, state, and conduct

> **ACCEPT. `WO-0057`: RETURNED → ACCEPTED.** The bench is clean in this packet's
> own terms: four ASSERT rows built, four observables pinned as their §4.H
> contracts state them, assertion order per §5, the zero-delivered window applied
> as §3.2 directed with both its supports cited, no mechanism-testing anywhere,
> and no state claim made without its stimulus fact. **No defect returns to the
> worker; the round does not reopen.**
>
> **`AP-xgmii_rx_64.md` is untouched by this verdict** — the M03-H2 parenthetical
> of §1.3 is a footnote owed at the plan's next touch, not a correction that
> blocks anything, and the file is the authority on that row's proof meanwhile.
>
> **After family H, 32 of the plan's 62 ASSERT rows are discharged.** `SO-M03`
> does not issue and is not offered.

**Four things worth recording as precedent.**

**The construction was derived before it was written, and the wrong one was
derived first.** `J-tb_writer-0015` works out what a naive two-`frame_case`
attempt puts on the wire — an idle gap landing inside the *second* frame's own
preamble, routing to REQ-105 and aborting the very frame the row means to open —
and rejects it on that ground rather than discovering it as a red run. In a
container that cannot execute a test, deriving the failure is the only way to
have it.

**The model was checked at the mechanism, not at the interface.**
`injection.ml`'s placement arithmetic and its `outcomes` walker were both read
and hand-traced against each splice before `fail_cross` was trusted on any of
them. This stimulus is the first in the programme to corrupt a preamble position
with a start character and to place a third; trusting a gated oracle on a shape
none of its committed callers had built would have been the easy move.

**Both instances of "the row asks for one geometry" were read off the row's own
notation.** M03-H4 is driven once because `8c` is a lane-0 octet time by §0.5's
definition; M03-H1 is driven twice because `72 ≡ 0 (mod 8)` makes both lanes
free. Two opposite decisions, one method.

**And the round's findings are all mine or the plan's, not the worker's.** The
helper that is right by cancellation is a helper I commissioned by pointing at
X-5; the window check that cannot fail is my specification's two rules meeting;
the parenthetical that over-promises is my attack plan's cell; and the blind spot
about a spurious third frame has been in this bench since family D. That is the
third round running in which the instrument has found more against the packet
than against the return, which is the instrument working.
