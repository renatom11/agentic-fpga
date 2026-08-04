# WO-0059: Family I — silence, ordered sets and idle (REQ-109, REQ-113, REQ-016), the plan's only all-negative family

- **State**: **DRAFT** — dv_lead's draft. The orchestrator issues it and records
  every state transition (PROTOCOL §3); I do not.
- **From** / **To**: dv_lead → tb_writer
- **Spec basis**: `docs/specs/requirements.md` **REQ-109**, **REQ-113**,
  **REQ-016**, plus REQ-101, REQ-102, REQ-103, REQ-104, REQ-005, REQ-011,
  REQ-107, REQ-108, REQ-111; **§0.3** (the gap convention), **§0.5** (octet
  time, the front offset h, the word delay ΔC, the "Start lanes" paragraph),
  **§0.6** (the strobe window and its C-23 counting convention, as ruled at
  `0caf023` and **in force at `abf5d0b`**), §2 (the five control characters);
  `docs/specs/modules/xgmii_rx_64.md` **§6.1** — the preamble-position
  paragraph, the **gapless qualifier (C-14.4)**, the two C-18 non-instances, the
  cycle table, and **the "Between frames (REQ-109, REQ-113)" paragraph with its
  two-cycle drain derivation (C-14.3)** — **§6.2**'s `Idle` and `Frame` rows,
  **§6.3** items 2, 4, 5 and 6, **§7** (h = 8/12, L = 16/12, ΔC = 3, the
  throughput bullet), **§9** (the closure list and the strobe table), and
  **§10**'s REQ-109, REQ-113 and REQ-016 hooks.
- **Rows**: **six.** `AP-xgmii_rx_64.md` §4.I — **M03-I1, I2, I3, I4, I6**
  ASSERT and **M03-I5** NO-ASSERT. Nothing in this family is discharged by
  citation from another family, and nothing is deferred.
- **Deliverables**, and nothing else:
  1. `test/xgmii_rx_64/test_m03_i.ml` (new).
  2. `test/xgmii_rx_64/dune` — this packet's header line only, comment-only.
  3. `test/xgmii_rx_64/bench.mli` + `bench.ml` — **one** authorised addition,
     §8.1, and no other change to either file.
  4. `test/xgmii_rx_64/test_m03_h.ml` — **two** owed repairs, §7.3, neither of
     which may change any assertion's outcome.

---

## 1. What this family closes, and the one repair it carries

REQ-109, REQ-113 and REQ-016 are driven today by **nothing**. Every M03 bench so
far has treated idle as the thing between the stimulus rather than as the
stimulus, and the three requirements that govern it have no unit anywhere.

Three silently-always-pass classes live here, and they are not the same shape:

- **A receiver that emits or pulses out of an empty pipeline.** REQ-109's
  positive half. No committed unit drives more than a handful of idle cycles
  with nothing in flight, and the ten-cycle scaffolding run at
  `test_m03_structural.ml:49` is not REQ-109's figure.
- **A decoder that treats an unrecognised control character as data.** REQ-113.
  A `/Q/` between frames would then open or corrupt a frame, and **no stimulus
  in this programme has ever put a `/Q/` on the wire.**
- **A design that decodes an idle word inside an open frame as eight data
  octets, or that advances its received-octet count across one.** REQ-016 and
  the **C-14.4 hold rule** — the rule that took two spec diffs to get right
  (SPEC-M03 §11.5 and §11.6) and has never been executed.

### 1.1 The repair, said loudly: **M03-I2's stimulus cannot reach M03-I2's kill**

`AP-xgmii_rx_64.md` §4.I's M03-I2 read, until this round:

> Stimulus: **A 64-octet frame followed by idle.**
> Kills: **A real drain defect one cycle long.**

**It does not.** §6.1's own drain derivation, worked at both ends rather than
quoted: with N octets between the start and terminate characters, N = 8q + r, a
**lane-0**-started frame puts its terminate character in word q + 1 and its
`tlast` word at cycle q + 2 for r ≤ 4 or q + 3 for r ≥ 5 — **one or two** cycles
after the terminate word; a **lane-4**-started frame gives **zero or one**. A
64-octet frame is r = 0, so a conformant design's last output word falls **one**
cycle after the terminate word at both start lanes, while the row asserts
silence only from **three** cycles after it. A design whose drain is one cycle
longer emits at **+2** — inside the unasserted gap — and this row is blind to
it. The row's Kills cell names a defect its own stimulus cannot produce: the
**M03-D3 / M03-F2 shape**, and the third time this plan has carried one.

The repair is a second member, not a new row and not a new frame class. **A
69-octet frame at a lane-0 start** (r = 5, and already in M03-C1's committed
directed set) puts a conformant design's `tlast` word exactly **two** cycles
after the terminate word — on the last legal drain cycle — so the one-cycle
defect emits at **+3** and dies, and a bench that mis-derived the bound as +2
goes **red against a conformant design** instead of passing in silence. On
`Bench`'s own lane-0 schedule both members put their terminate character in
**cycle 10** and share the assertion boundary **cycle 13**; they differ only in
how much slack a conformant design leaves beneath it. That coincidence is
convenient and is not the reason for the choice — the reason is r ≥ 5.

**`test/attack_plans/AP-xgmii_rx_64.md` is edited in this packet's own commit**:
M03-I2's Stimulus and Kills cells, plus a §9 change-log row. **No row is added,
no status converts, no count moves** — 78 rows, 62 ASSERT, 7 NO-ASSERT, 4
NO-STIMULUS, 4 STRUCTURAL, 1 GAP, unchanged. The precedent is `J-dv_lead-0038`
(*family D corrected before it was benched, and WO-0040 issued against the
corrected row*): a campaign seals against the plan, so the plan must already be
right, and a bench commissioned against a cell I know to be false is a bench
built on a claim.

---

## 2. The derivation traps, stated before the rows because three of the four govern every row

### 2.1 This family's characteristic failure is **vacuity**, not wrongness

Every row in §4.I asserts an **absence**: no output word, no strobe, no change.
An absence is satisfied by a design that does nothing at all, and it is
satisfied by a bench that drove nothing at all. **Six rows of absence is the
easiest green in this programme and the least evidence.**

> **The rule, and it binds every unit in the file.** Each row carries a
> **positive companion assertion in its own unit** — something the same run
> proves the receiver *did*, correctly — and the file states, per row, what
> would go red if the companion were deleted. A row whose companion lives in
> another unit, another file or another family **does not have one**: cross-file
> liveness is an argument about the suite, and this family's rows are scored one
> at a time.

Per row, the companion I expect (derive it, do not take it):

| Row | The absence | Its positive companion, same unit |
|---|---|---|
| M03-I1 | 1000+ idle cycles silent | the frame driven **after** the window, delivered correct and complete |
| M03-I2 | nothing from terminate word + 3 | the frame's own delivered words, `tkeep`, `tlast` cycle and clean FCS verdict |
| M03-I3 | nothing during the ordered set | the following frame, compared against the idle-only run |
| M03-I4 | nothing changes under injection | the word sequence and the per-octet constant, both **measured**, at every figure |
| M03-I6 | no strobe at all | both frames' delivered content, equal to their un-injected delivery |

**M03-I1's companion is not free and you should know what it costs**:
`Bench.assert_monitors_clean`'s docstring carves out the frameless run
(`bench.mli`, "a frameless run … must not be asked to prove a claim it was never
given the means to make"). Once a frame is in the run, the latency tagger's
`is_constant` verdict **is** demanded. That is the right trade and it is a
change in what the call checks; say so in the Return log.

### 2.2 `Bench.account_clean_frame` is the wrong helper on an injected line

Exactly the family-H trap in a new dress. `WO-0057` §3.1 barred `Frame.delivered`
on an abort path because it implements REQ-103's *removal*, which the abort path
does not perform. Here:

`account_clean_frame` feeds the standing latency tagger
**`Arrival.in_times frame`** — the frame's octet times **on the source line**.
Under injection that array is **false about the input**, by exactly 8 octet times
per idle word inserted before each octet, which is REQ-016's own arithmetic.
`Idle_injection.in_times` exists precisely for this and its docstring says so.

**A tagger handed a false input trace does not fail loudly**: it reports a
*varying* L, which reads as a REQ-005 latency defect in a conformant design. So
the failure mode of this trap is **a false BUG- packet**, not a missed one.

> **Per-run declaration, as a Return-log deliverable**: for every run in
> M03-I4 and M03-I6, state which array was handed to `Latency.frame_in` and cite
> the clause. A row that calls `account_clean_frame` on an injected run is
> defective whatever its output says.

This is also `RV-0057-VERDICT` Finding 1's lesson generalised: a monitor whose
whole job is to be handed true facts about the input must be handed one.

### 2.3 `Bench.run` checks the **source** schedule, and neither an overlay nor an injected line is one

`run` discharges standing obligation 5 by calling `Arrival.check sched` before
driving a cycle. That check knows nothing about:

- the words you substitute through `?word_at` (M03-I3's ordered set), and
- the injected line `Idle_injection` produces (M03-I4, M03-I6) — and the wrapper
  **deliberately applies an illegal site rather than dropping it**, so that a
  bench ignoring `errors` fails on the abort it provoked instead of passing on a
  stimulus it did not intend (`idle_injection.mli`, `create`).

> **So the row checks its own stimulus, before driving it.** For an injected run:
> `Idle_injection.errors` empty and `is_clean` true, asserted, not printed. For
> an overlaid run: every substituted word's control mask guarded, and the
> substituted window guarded to lie **strictly inside** the inter-frame gap.
> An unchecked stimulus generator is an unverified assertion about the design
> (standing obligation 5, and it is standing for this reason).

**One thing you will look for and will not find**: under
`Idle_injection.uniform`, `c45_sites` is **empty**. `uniform` begins at the
boundary *after* the word carrying the frame's first octet
(`idle_injection.ml`'s `first = first_octet_cycle f + 1`), so it never proposes
the prohibited boundary and there is no C-45 residue to report. **Do not
manufacture one** by adding a `create` site there: that would drive a stimulus
SPEC-M03 §6.1 refuses, and `~allow_c45:true` may be set only if C-45 lands as a
spec diff. Report the empty residue as the fact it is.

### 2.4 §6.1's `m + 3` is scoped to a gapless stimulus — **M03-I5 is stated here, before the row that would violate it**

M03-I5 is NO-ASSERT and it is in this section rather than in §3 deliberately: it
is a prohibition on the row you write **just before** you would break it.

§6.1's "output word m is emitted on cycle m + 3" is qualified, in the
specification's own text, to a **gapless** stimulus — one whose frame octets
occupy consecutive octet times. §10's REQ-016 hook then commissions idle
injection **against this module**, at 0, 1 and 7 cycles, asserting **the
per-octet constant of §7 rather than §6.1's gapless cycle formula (C-14.4)**.

> **A bench asserting `m + 3` under injection fails a conformant design.** The
> gap-invariant quantity is L (16 at a lane-0 start, 12 at a lane-4 start), and
> that is what M03-I4 asserts. Where a cycle from §6.1 or §9 is needed on an
> injected line it is translated through `Idle_injection.cycle_of`, never
> recomputed from the formula.

Discharge M03-I5 in the shape `test_m03_a.ml` uses for M03-A4 and
`test_m03_d.ml` for M03-D4: a declaration naming the row, the clause, what is
**not** asserted and what is asserted instead. If you give it its own
`%expect_test` (the A4 shape) rather than a comment block (the D4 shape), say
which and why in the Return log — A4 has a unit because it pairs with a positive
cross-lane comparison, and I have not decided whether I5 earns the same.

### 2.5 The standing rule this family will strain: **a state claim cites the stimulus fact that establishes it, or is not made**

`RV-0055`'s rule, `WO-0057` §4 item 4, and it strains here because **every Kills
cell in §4.I is written in the language of the design's internals** — "a
spurious word out of an **empty pipeline**", "a design that **holds the CRC
register**", "a design that **counts cycles rather than octets**". Those are
descriptions of wrong designs, which is what a Kills cell is for. **They are not
observables**, and §6.3 items 2, 4 and 5 forbid asserting register placement,
FSM encoding or counter direction.

Assert, per row: output words and their absence, `tkeep`, `tlast` and its cycle,
`tuser`[0], delivered octet **content**, octet times, and the strobe set. Never
a state, never a register, never a counter. If a row's reasoning needs the word
"pipeline" it needs a different sentence.

---

## 3. The rows, ranked by risk

Ranked because the spread in this family is wide: one row is the scaffolding
smoke test at REQ-109's own figure, and one is forty-eight runs through a
wrapper no bench has ever pointed at a DUT.

**Build order: M03-I1 → M03-I2 → M03-I3 → M03-I4 (+ I5) → M03-I6.** That is
ascending risk except at the tail: **M03-I6 is built last although M03-I4 is the
riskier row**, because I6 reuses I4's injected-run helper and building it first
would mean building that helper twice.

### 3.1 M03-I1 — silence with nothing in flight (ASSERT, **lowest risk**)

**1000 idle cycles with no frame in flight**: `tvalid` = 0 and all five strobes
0 on every one of them.

The construction already exists. `test_m03_structural.ml:49` drives
`Arrival.create ~first_start:8 []` with `~drain:10` and asserts exactly this
observable at ten cycles. **M03-I1 is that run at REQ-109's own figure, and the
scale is the row** — a pipeline that emits spuriously after sixty-odd idle
cycles (a counter wrapping, a state that ages) is invisible at ten and visible at
a thousand. Say in the file that the smoke test is the precedent and that it
does **not** discharge this row.

**Derivation to check, not an instruction.** One schedule, one run, no overlay:
`Arrival.create ~first_start:(8 + 8 × 1000) [frame]` puts the start character at
octet time 8008 — a multiple of 4, as `Arrival.create` requires — so cycles
**0 … 1000** carry idle words and the liveness frame of §2.1 follows inside the
same run. Assert the absence over the idle cycles and the frame's full delivery
after them; `~drain:8` as everywhere else.

### 3.2 M03-I2 — the drain window (ASSERT, low risk, **and the repaired row**)

**Two members, driven separately, each followed by idle** — see §1.1 for why the
second exists.

- **(i) 64 octets, both start lanes.** Terminate character in cycle **10** at
  both lanes on `Bench`'s own schedules; conformant `tlast` at cycle **11**;
  assertion boundary cycle **13**.
- **(ii) 69 octets** (`Bench.directed_frame_octets ~length:69`, already in
  `directed_lengths`). **At a lane-0 start** the terminate character is again in
  cycle 10, the conformant `tlast` is at cycle **12** — the last legal drain
  cycle — and the boundary is again **13**.

> **The two lanes do not share a boundary on member (ii) and a bench that gives
> them one is wrong.** At a lane-4 start the same 69 octets put the terminate
> character in cycle **11** and the `tlast` at cycle **12**, so the boundary is
> **14** and the slack is one cycle, not zero. Derive the boundary **per lane
> from §6.1's own arithmetic**, and if you drive (ii) at lane 4 as well — you
> may; it witnesses the lane-4 half of the derivation — assert its own figures
> rather than the lane-0 ones.

The assertion is "no output word and no strobe from the boundary onward". State
and guard **how far** onward the run actually observes: an assertion over an
empty tail is the vacuity of §2.1 in its purest form.

### 3.3 M03-I3 — the ordered set (ASSERT, medium-high risk)

**100 cycles of a `/Q/` sequence ordered set between two frames, then a frame.**
No `tvalid` and no strobe during the ordered set; the frame after it compares
**word for word** against the same frame received after idles only.

Four things this row needs and does not get for free:

1. **The comparison is between two runs of *your own* stimulus**, so build
   **one** schedule and drive it **twice** on two fresh `Bench.create ()`
   instances — once unmodified (idles fill the gap) and once with the window's
   words substituted through `?word_at`. The two runs are then **cycle-identical
   by construction**, and the comparison can be made cycle for cycle rather than
   as a tuple sequence.
2. **That cycle-for-cycle comparison is legitimate and M03-A4 does not bar it.**
   A4 forbids asserting the absolute-cycle equality of the **two start lanes**,
   because §6.1 makes that a property of the constants §7 pins rather than an
   obligation. Here the *same* frame starts at the *same* octet time in both
   runs, so §7's per-octet constant fixes its output cycles identically and
   REQ-113's "ignored" is what makes the gap's content irrelevant to them. Cite
   that ground; do not lean on A4's silence.
3. **The window must clear the first frame's drain.** §6.1 lets a frame emit up
   to **two cycles after its terminate word**, so a window opening earlier would
   assert "no `tvalid`" across a conformant design's own `tlast`. Open it no
   earlier than **terminate word + 3** — M03-I2's own derived bound, reused, and
   guarded here rather than re-derived.
4. **The ordered set's shape is a stimulus choice with no specification behind
   it.** requirements.md §2 gives `/Q/` = 0x9C and nothing else; §6.2's `Idle`
   row ("ignores every lane; `tvalid` = 0", leaving only on `/S/`) is the ground
   for the assertion, and it is a ground that holds **whatever the accompanying
   octets are**. So: choose a shape, derive its legality from §2 and §6.2 alone,
   **assert nothing about it**, and **do not import one from IEEE 802.3, from
   `test/third_party/verilog-ethernet/` or from any other reference** — a
   stimulus taken from a reference is a stimulus nobody has checked against the
   requirement it encodes.

**Derivation to check.** With `ifg` = **824** octets counted from the terminate
character inclusive (§0.3's convention; 824 is a multiple of 4, so no deficit
credit moves), the second start character lands at octet time 904 at a lane-0
start and 908 at a lane-4 start — **cycle 113 at both**, in the correct lane at
both — leaving cycles **13 … 112** as exactly **100** whole gap cycles at both
lanes. Guard both ends against the frames rather than against the constants.

### 3.4 M03-I4 — the idle-injection wrapper (ASSERT, **highest risk**)

**M03-C1's directed set — 64 … 71 octets at both start lanes — driven through
the wrapper at 0, 1 and 7 idle cycles**: sixteen frames × three figures = **48
runs**. The word sequence unchanged, the per-octet constant unchanged (16 at
lane 0, 12 at lane 4), every octet delayed by exactly 8 octet times per injected
cycle, FCS verdicts unchanged.

The `idles:0` figure is `uniform`'s identity (it proposes no site at all) and is
**§10's own first figure**, so the baseline is inside the commissioned stimulus
rather than beside it. Anti-vacuity for the whole row lives there.

**Four derivations to check:**

1. **The run length.** `run` drives `Arrival.cycles sched + drain` cycles, and
   the injected line is longer than the source by exactly
   `Idle_injection.injected`. So `~drain:(Idle_injection.injected inj + 8)`
   reproduces the packet's standing 8-cycle drain on the injected line and
   collapses to `~drain:8` at `idles:0`. A run that keeps `~drain:8` under
   injection stops mid-frame; it will fail rather than mislead, but it will fail
   for the wrong reason.
2. **The delay identity, expressed so it needs no boundary count.** REQ-016
   delays each octet by 8 octet times per idle inserted before it, and REQ-005
   passes that delay through unchanged. So assert, per octet:
   `out_injected(j) − out_baseline(j) = in_injected(j) − in_baseline(j)`, with
   the input side read from `Idle_injection.in_times` and `Arrival.in_times`
   respectively. That is stronger than "L is unchanged" and it does not require
   you to count boundaries.
3. **Why h stays 8 and 12, which is your independent check that the wrapper is
   doing its job.** The tagger computes the front offset from the input trace as
   `in_times.(8) − 8 × (in_times.(0) / 8)`. It reads 8 and 12 under injection
   **only because no idle is ever inserted between the start character and the
   frame's first octet** — the M03-N3 constraint. If the wrapper's prohibition
   ever failed, the tagger would report a front offset outside `[8; 12]` before
   any row's own assertion spoke. Say in the Return log whether you observed
   that, because it is the constraint made measurable.
4. **The `tlast` cycle.** Where you need it, take
   `Idle_injection.cycle_of` of the un-injected cycle. **Not `m + 3`** — §2.4.

### 3.5 M03-I6 — the thresholds under injection (ASSERT, medium risk)

**A 64-octet frame and a 1518-octet frame, each with 7 idle cycles injected
between every pair of words**: no strobe pulses at all, because the octet counts
governing REQ-107 and REQ-108 are unchanged by idle cycles.

This row and M03-I4 attack **the two halves of one rule**. §6.2's `Frame` row
says an input word covering no frame octet **holds** the frame: it holds the CRC
register *and* it holds the octet count. **M03-I4 attacks the CRC half** (a
design decoding the idle word as data corrupts the residue and reports a false
`error_bad_fcs` on every injected frame); **M03-I6 attacks the count half** (a
design advancing the received count across an idle cycle crosses REQ-108's 1518
and pulses `error_oversize`). Say that in the file: the two rows are not
neighbours, they are complements.

**Three facts about this row's reach, derived rather than assumed, and all three
belong in the Return log:**

- **The 64-octet member is stimulus M03-I4 already drives** — it is
  `directed_lengths`' first entry at the same 7-idle figure. Its value here is
  as §2.1's positive companion to the 1518-octet member's silence, not as new
  coverage, and no `SO-` may count it twice.
- **At 7 idles the *runt* half of the count defect escapes by one cycle.** A
  64-octet frame's span from its start word to its terminate word is 9 source
  cycles; `uniform` adds 8 sites × 7 = 56, giving **65** — and 65 is outside
  REQ-107's 5-to-63 band by one. **At M03-I4's 1-idle figure the same span is
  17, squarely inside it**, so the runt half of this defect class is caught by
  M03-I4 and not by M03-I6. §10's three figures are not a ladder of increasing
  severity, and this is the instance that proves it.
- **The 1518-octet member's oversize half is lane-asymmetric under one defect
  model and not under the other.** A design that counts *cycles* against
  REQ-108's 1518 sees roughly 1513 at a lane-0 start and roughly 1521 at a
  lane-4 start — it fires at one lane only, by a margin of three. A design that
  advances its octet count by 8 per idle cycle overshoots by a factor of eight
  at both. **Drive both lanes**, and state the arithmetic you derived rather
  than the one above.

---

## 4. Octet times, constants and the guards

Unchanged from `WO-0054` §2 and `WO-0057` §4, and restated because this family
is denser in derived cycle numbers than any before it:

1. **Every constant carries a committed guard, and the guard must be able to
   fail.** `test_m03_g.ml`'s five guards on one recommended `k` are the standard.
2. **Every interval has both ends worked, at the boundary and not merely near
   it.** The `k = 1518` correction (`RV-0056-VERDICT` §1) happened because a cell
   stated how an endpoint was computed and never asked what happens *at* it. So
   did §1.1's repair above.
3. **Where I recommend a value it is a derivation to check, not an instruction.**
   If your derivation disagrees with mine, **say so in the Return log** — that
   disagreement is how the first-epoch boundary was found and how M03-H2's
   parenthetical was corrected, and both reached me only because a guard shipped.
4. **REQ-101's lane rule binds every placed start character**: lane 0 or lane 4
   only. For a frame starting at octet time `s`, content index `c` sits at octet
   time `s + 8 + c`; work the lane at **both** start lanes and show they agree or
   differ.
5. **A claim about the receiver's state cites the stimulus fact that establishes
   it, or is not made** — §2.5, and in this family it is the rule most likely to
   be broken by a comment rather than by an assertion.

---

## 5. Assertion order, and what a campaign will score

Assertion order is part of each row's contract (`WO-0047` §4.2). **The first
failing assertion is what a mutation campaign is sealed against**, and where a
row loops, which iteration runs first decides the message. State both per row —
and in this family the loops are large (48 runs at M03-I4), so name the outer
and inner order explicitly.

Order structural first, specific after: stimulus guards → stimulus legality
(`Idle_injection.errors`, the overlay's control masks) → the model cross-check
where one is used → word count → `tlast` cycle → `tkeep` → `tuser` → delivered
**content** → the absence assertion → the exact strobe set.

> **The absence goes late, deliberately, and it is a departure worth naming.**
> In families D–H the strobe set is last because the positive facts precede it.
> Here the *absence* is the row's headline, and it still goes after the positive
> companion — because a run in which the companion has already failed cannot
> tell you anything about the absence, and a message about silence on a design
> that emitted nothing at all is the least diagnostic message this bench can
> produce.

---

## 6. What this family cannot claim

Stated here rather than at sign-off, and each one is barred at the point a
writer or a packet would reach for it.

1. **X-3's checks (a), (b) and (c) have no instance in this family.** Every row
   asserts that **no** strobe pulses, so the monitor registers **no expected
   event**: there is no high cycle for C-23's counting rule to count, no pin for
   check (b) to compare, and no window for check (c). **The family's entire
   strobe assurance is check (d) — "no strobe the stimulus created" — and
   nothing else.** That is the mirror image of `AP` §7's M03-H4 bound, where (c)
   alone was vacuous, and it means a class scored against any family-I row is
   scored against (d) plus that row's own positive companion.
2. **REQ-016 is claimed for whole idle *words* only.** The wrapper inserts whole
   words and §6.2's `Frame` row states the hold rule for a word covering no
   frame octet. **A control character in a single lane of a word inside an open
   frame** — a `/Q/` or an `/I/` in one lane while octets occupy the others — is
   driven by nothing here, is not what §6.2's hold rule addresses, and **no row
   of this family may be read as covering it.**
3. **REQ-113 is claimed for the outside-a-frame case only**, which is the whole
   of what REQ-113 says. A control character in a **preamble position** is
   REQ-102's third sentence routing it to REQ-105 (`M03-B2`, `M03-N3`), and
   **M03-B2 is unbenched** — see §7.5. M03-I3 anchors nothing about it.
4. **The differential co-simulation lane can anchor almost nothing here, and the
   reason is the comparison domain rather than REQ-901.** REQ-109, REQ-113 and
   REQ-016 are **outside** declared divergence classes (e) and (f), so nothing
   is excluded on that account. But `CD-xgmii_rx_64_cosim.md` §5.2 puts **all
   cycle timing, latency and word-to-word spacing outside the domain (X1)** and
   **strobe identity and pinned cycles outside it (X2)**. Consequently:
   **M03-I1, M03-I2, M03-I5 and M03-I6 are anchorable in nothing at all**; only
   the delivered-frame half of **M03-I3** and **M03-I4** — D1–D5's octets,
   `tkeep`, `tlast` placement, marking and word count — could be, and only if
   the lane's stimulus classes are extended past §8's single 64-octet frame,
   which they have not been. **These rows are directed tests end to end**, in the
   same sense and for a different reason than M03-G2's oversize member.
5. **`WO-0047` §1.2's shared-no-output-path claim remains UNESTABLISHED and
   uncitable** (`AP` §8 item 5), unchanged. No row's reasoning may lean on two
   no-output rows sharing a report path.

---

## 7. Interactions, named here rather than discovered later

### 7.1 The two unbenched geometry bounds of `WO-0058` — **neither is family I's, and neither is blocked by it**

`AP` §4.H now carries two bounds this family touches only by not touching them.
Say so in the Return log rather than leaving the campaign to look for them here.

- **Bound 1 — the alignment-transition instrument is a single stimulus point**
  (`run_h2`'s lane-0 member), with the second point owed at **M03-B4**'s
  geometry. **Family I drives no start character while a frame is open, at all**
  — not one row — so it neither discharges the bound nor moves it. Its second
  point is blocked on M03-B4 being benched, which is family B's, not family I's
  (§7.5).
- **Bound 2 — the in-word abort exists at M03-H4 only**, in the
  nothing-open-on-entry form. Family I drives no abort of any kind. **No
  interaction**, stated so the next campaign does not go looking for one.

**The one forward interaction that is real**: the wrapper. `AP` §4.N records
that M03-N2's report cycles are **injection-proof** and that the row "may be run
inside the M03-I4 wrapper", and `idle_injection.mli` carries the same scope note.
**Family I is the wrapper's first customer against a DUT** — everything before
this was the wrapper's own unit tests — so every later row that runs inside it,
M03-N2 first among them, inherits a wrapper whose behaviour against a conformant
design is **measured** rather than assumed. Report `cycle_of`, `in_times` and the
front-offset observation (§3.4 item 3) explicitly for that reason.

### 7.2 The next campaign — family I's rows are its scored set, and the escalation is **not** in this packet

The combined G7 + H campaign is **closed** (`WO-0058`, seven of seven, all five
scored units qualified, `J-dv_lead-0080`). **The next mutation campaign on M03 is
family I's own qualification, and its scored set is the five ASSERT rows of this
packet.** Three consequences for you, and one for me:

1. **Your assertion and iteration order is what that seal is written against**
   (§5). Where a row loops 48 times, the iteration that runs first decides the
   message a sealed cell must match.
2. **Two correlations exist inside this family before any diff does, and both
   are mine to carry into the class rationale rather than yours to fix**:
   M03-I6's 64-octet member is stimulus M03-I4 already drives (§3.5), and
   M03-I4/M03-I6 attack two halves of one specification rule (§6.2's hold), so a
   class that moves the hold path may move both. `RV-0057-VERDICT` §9(c) is the
   precedent: **kills that share a path are not independent kills**, and a count
   that treats them as independent is inflated.
3. **§6 item 1's bound belongs in that packet**: a class scored against any
   family-I row is scored against X-3 check (d) and the row's positive
   companion, and against nothing else.

**And the thing that is deliberately absent from this packet.** My RTL-exposure
escalation from `J-dv_lead-0080` — that the adjudicator read the manifest's
disclosure table and fidelity ledger **by default** and open a diff only when a
cell is off-pattern, journaling which and why — is raised, undecided, and
**belongs in the next campaign packet, not here**. It governs how a campaign is
adjudicated; it governs nothing about how a bench is written, and putting it in a
bench work order would be exactly the kind of pre-emption this programme's
sequencing rules exist to prevent. Family I's rows **will** be scored under
whatever control lands, and that is the whole of its relevance to you.

### 7.3 The two owed `test/**` repairs that ride with this packet, and the one that does not

`J-dv_lead-0079` and `J-dv_lead-0080` carry three items "owed to `test/**` at its
next touch". **This is that touch.** I am ruling on all three here so none of
them is rediscovered at review.

> **RIDES — `RV-0057-VERDICT` Finding 1.** `test_m03_h.ml`'s
> `account_spliced_forwarded` builds its input trace as
> `Array.init (8 + delivered)`, which is right for every aborted frame
> (`received = delivered`) and **four octet times short** for every clean
> spliced frame, where `received = delivered + 4`. It is harmless today by
> **cancellation** — the extent override puts the count back and the delivered
> octets are a prefix — and it sits exactly **on** `frame_out`'s stated bound.
> Take `~received` for the input trace and keep `~delivered` for the extent
> override only, as `test_m03_g.ml`'s `account_resync_runt_frame` already does.
> **This repair SHALL NOT change any assertion's outcome.** If you find that it
> does, that is a finding to **report, not to absorb**.
>
> **RIDES — `RV-0057-VERDICT` Finding 4.** M03-H3's exact strobe set rests on the
> 15 data octets between its `/E/` and its `/S/` pulsing nothing and opening
> nothing. The ground is normative — **SPEC-M03 §6.2's `Idle` row**, "ignores
> every lane; `tvalid` = 0", leaving to `Preamble` only on `/S/` — and the file
> cites §9's closure list and REQ-105 instead. Add the citation. Comment only;
> no assertion moves. **Note that this family's M03-I1 and M03-I3 rest on the
> same clause**, which is why the two land together.
>
> **DOES NOT RIDE — `RV-0057-VERDICT` Finding 3**, the total-output-word line at
> the ordinary two-frame rows of families D–H (roughly a dozen units across five
> files). Two reasons, and the second is the one that decides it. **(a)** A
> dozen unreviewed one-line changes across five files, in the same commit as a
> new family's first build, is a review-load trade I am not making. **(b)** The
> line is **not uniform**: each row's "and nothing else was emitted" bound is a
> function of that row's own legitimate output **and its drain**, and the drain
> is the quantity **M03-I2 derives from §6.1 for the first time in this bench**.
> The sweep should be written on top of that derivation, not beside it.
> **Deferred to the first `test/**` touch after family I lands, with M03-I2's
> derived bound as its shared ground** — and named here so the deferral is a
> ruling with a reason rather than a thing that kept not happening.

### 7.4 Machinery: nothing is owed, and one small thing is authorised

X-4 (`test/xgmii/idle_injection.ml`) and X-3 (`strobe_monitor.ml`) exist, are
unit-tested and carry every constraint this family needs; **no row here is
blocked on machinery** and §7's staleness banner applies unchanged. `Bench.run`'s
`?word_at` override covers the drain cycles as well as the scheduled ones and
`Idle_injection.word_at` is total, so an injected or overlaid line needs no new
drive loop — see §8.1 for the one exception.

### 7.5 A correction to `WO-0057` §11's scope sentence — **family B is unwritten too**

`WO-0057` §11 wrote: *"Families I, J, K, M, N and L1–L5 remain unwritten."*
**That sentence is incomplete and it is mine.** `test_m03_b.ml` carries **one**
unit, M03-B1. **M03-B2, M03-B3 and M03-B4 have no unit of their own** — B2's
preamble-position `/E/` is adjacent to, and not identical with, M03-E5's lane-0
in-word case, and B3 and B4 are driven by nothing at all.

This matters beyond bookkeeping: **`WO-0058`'s bound 1 is owed at M03-B4's
geometry, and M03-B4 does not exist yet**, so that bound is blocked on a family-B
packet rather than on a campaign. Recorded here because a scope sentence that
omits three ASSERT rows is how an owed row becomes an escape.

---

## 8. `test/xgmii_rx_64/bench.mli`, `bench.ml` and `dune`

### 8.1 The one authorised addition

`Bench.frames_at` is where the start-lane-to-`first_start` mapping has **exactly
one home** (its own docstring says so), and M03-I3 needs the same mapping with a
non-default inter-frame gap. **Add `?ifg:int` to `frames_at`, passed straight
through to `Arrival.create`'s own `?ifg` and defaulting to `Arrival`'s default,
and change nothing else in either file.** The precedent and the discipline are
`WO-0040` §3.3, which added `frames_at` itself as "the one bench addition that
packet authorises".

**Not authorised**: any change to `run`, to `account_clean_frame`, to
`assert_monitors_clean`, or to the standing monitor construction. If M03-I4 needs
an accounting helper for an injected frame, it is **file-local to
`test_m03_i.ml`** — `RV-0043-VERDICT` §7's bar on widening `Bench`'s exported
surface stands, and `RV-0057-VERDICT` §9(a) put the third-customer rule on the
one device that is close to earning promotion. This is not that device.

### 8.2 `dune`

Add this packet's line to the header's per-packet list. **Comment-only**; touch
no stanza.

---

## 9. What you may NOT read

- **Never open `libs/**`, `top/**`, `bin/**` or `rtl_snapshots/**`.** Scope every
  `grep` to `test/` and `docs/specs/`.
- **`docs/reports/audit/**` is out of bounds**: it holds mutation diffs, and a
  row written against a mutation is worth nothing.
- **`test/third_party/verilog-ethernet/**` is out of bounds for this packet**,
  and for once the reason is not licensing — it is MIT and freely readable. It is
  out of bounds because **§3.3 item 4 asks you to derive an ordered set's shape
  from the specification alone**, and the vendored reference is the nearest place
  to take one from instead.
- Derive every expected value from the specification. `Injection`'s **computed
  outcome model** is an oracle and is gated (`AP` §7's X-1 row, bar 1 — the
  placement machinery is free, the outcome model is not); use it only as a
  **reported** cross-check with the `fail_cross` idiom, and note that no row in
  this family obviously needs it, since none injects an error condition.

---

## 10. What I expect back

A Return log appended to this packet plus your journal entry. **No `SO-`.**
Deliverables rather than background:

1. **§2.1's positive companion, per row**, named, with what would go red if it
   were deleted — and M03-I1's effect on `assert_monitors_clean`'s second half.
2. **§2.2's per-run declaration**: which input-time array each injected run
   handed to the latency tagger, with its clause.
3. **§2.3's stimulus checks**: `Idle_injection.errors` and `c45_sites` as
   observed (I expect both empty, for the two different reasons §2.3 gives), and
   the overlay's own guards.
4. **Each derived cycle number with its committed guard**, both ends of every
   interval worked — in particular M03-I2's per-lane boundaries and M03-I3's
   window ends.
5. **§3.4's four derivations**, including the front-offset observation that makes
   the M03-N3 constraint measurable.
6. **§3.5's three reach facts**, with your own arithmetic for the injected spans
   at both lanes.
7. **M03-I5's discharge shape** (A4's unit or D4's declaration) and why.
8. **Assertion and iteration order** per row, outer and inner.
9. **The unit count you observe**, measured with `tools/dv_checks.sh`'s inventory
   block, and the two `test_m03_h.ml` repairs of §7.3 confirmed outcome-neutral.
10. Anything you found that this packet did not authorise you to fix — **report
    it, do not fix it.** Including any further interaction with families B, N or
    the wrapper that §7 did not name.

---

## 11. What this packet does not do

`SO-M03` does not issue and is not offered. After family I, **37 of the plan's
62 ASSERT rows** would be discharged — I1, I2, I3, I4 and I6 newly.

**That figure is inherited, not re-derived, and I am flagging it rather than
quoting it.** It is `WO-0057` §11's "32 of 62" plus this family's five; my own
count of benched ASSERT rows at `abf5d0b` gives **33**, so the running figure is
uncertain by one. **I will re-derive it at this packet's verdict** rather than
carry a number I have not measured — the `J-dv_lead-0061` lesson, where a
denominator I had quoted rather than counted survived one packet too long.

Families **J, K, M, N**, **L1–L5** and **B2–B4** remain unwritten, and family I's
own qualification campaign is a separate packet with its classes published and
its row mapping sealed as a committed file in the same commit as the packet,
before any manifest diff exists. **I hold no prediction today and am withholding
nothing**: the five scored rows above are that campaign's *scope*, disclosed here
in full, and its mapping does not exist yet.

---

## RETURNED — tb_writer (spawn `WO-0059/2026-08-04T03:04Z`)

**State**: RETURNED. Deliverables built: `test/xgmii_rx_64/test_m03_i.ml` (new,
five `%expect_test` units, M03-I1/I2/I3/I4/I6), `test/xgmii_rx_64/dune` (one
comment line), `test/xgmii_rx_64/bench.mli` + `bench.ml` (`frames_at`'s
authorised `?ifg` addition, §8.1), `test/xgmii_rx_64/test_m03_h.ml` (the two
owed repairs, §7.3). No `SO-` offered or claimed. No file outside this list
touched; no `libs/**`, `top/**`, `bin/**`, `rtl_snapshots/**` or
`docs/reports/audit/**` path opened at any point.

### (a) Per-row status I1–I6, the observable each unit pins, and its positive
companion assertion — the tabulation §2.1 requires

| Row | Status | The absence pinned | Its positive companion, same unit |
|---|---|---|---|
| M03-I1 | ASSERT (`run_i1`) | `tvalid` = 0 and no strobe on every one of 1001 idle cycles (`idle_cycles + 1`, one idle word precedes every schedule by construction) preceding a frame at `first_start = 8 + 8×1000` | The frame driven after the window: word count, per-word cycle (`start_cycle + 3 + m`) and `tkeep`, `tuser` = 0, delivered content all asserted directly; `Bench.account_clean_frame` + `assert_monitors_clean` called, so the latency tagger's `is_constant` verdict **is** demanded (it is **not** demanded on the frameless scaffolding smoke test, `test_m03_structural.ml`) — deleting the frame-delivery block would leave the row provably vacuous (an all-idle run trivially satisfies "no output word") and would also make `assert_monitors_clean`'s `is_constant` clause never fire, silently dropping the constancy check |
| M03-I2 | ASSERT (`run_i2`, `run_i2_member` × 4) | No output activity from `terminate_cycle + 3` onward, at both members, both lanes (four sub-runs: member i lane 0/4, member ii lane 0/4) | Each sub-run's own delivered word count, per-word cycle/`tkeep`, `tuser` = 0, delivered content, all asserted directly against hand-derived guard parameters before the absence is checked; deleting the positive block leaves a run that only proves "nothing happened after cycle X" without ever showing anything happened correctly before it |
| M03-I3 | ASSERT (`run_i3` × 2 lanes) | No `tvalid`, no strobe during the 100-cycle `/Q/` window (cycles 13–112 at both lanes), in the overlay run | Frame 1 and frame 2 both checked structurally (`assert_clean_frame_structure`) in **both** the baseline and the overlay run, **and** the overlay run compared cycle for cycle against the baseline (`outputs_equal`, full run, not merely the window) — deleting either half would leave the ordered set's specific handling untested: without the structural checks, a design that silently corrupted frame 2 would pass if it did so identically in both runs; without the cross-run comparison, a design that treated `/Q/` differently from idle in some way that still produced a structurally valid (but differently-timed or differently-attributed) frame 2 would not be caught |
| M03-I4 | ASSERT (`run_i4`, `run_i4_length_lane` × 16, `run_i4_case` × 48) | No error strobe on any of 48 injected runs (`error_pulses samples = []` per run) | Word sequence (`Idle_injection.cycle_of`, not `m + 3`), the delay identity `out_injected(j) − out_baseline(j) = in_injected(j) − in_baseline(j)` against an actual, separately-driven un-injected baseline of the same (length, lane) — **not** derived from `cycle_of` a second time, so a bug in the translator could not silently validate itself — `tkeep`/`tuser`/content, the per-octet constant of §7 MEASURED both per run (each bench's own standing tagger) and across all 48 runs (`cross_latency`, fed independently); deleting the positive block leaves 48 runs that only prove "no strobe fired", which a design that silently corrupted every delivered octet would also satisfy |
| M03-I5 | NO-ASSERT (declared, not built) | — | — (see §(g) below) |
| M03-I6 | ASSERT (`run_i6`, `run_i6_case` × 4) | No error strobe on any of the four runs (64/1518 octets × 2 lanes, 7 idles) | Word sequence (`Idle_injection.cycle_of`), `tkeep`, `tuser` = 0, delivered content, all asserted directly per run via the same file-local `account_injected_frame` M03-I4 uses; deleting the positive block leaves "no strobe fired" unattached to any proof the frame's own class-determining content survived injection intact |

### (b) The wrapper measurements (WO-0059 §7.1's own deliverable)

- **`cycle_of`**: exercised as the sole translator for every injected cycle
  in M03-I4 and M03-I6 (word sequence and `tlast` cycle both), never `m + 3`
  — M03-I5's own prohibition, held throughout. Independently cross-checked
  in M03-I4 by the delay-identity assertion, which is derived from raw
  octet times and does **not** call `cycle_of` a second time, so the two
  checks cannot silently validate each other.
- **`in_times`**: used for every injected `Latency.frame_in` call across
  both M03-I4 and M03-I6 (`account_injected_frame`, file-local, §2.2's
  replacement for `Bench.account_clean_frame`), and separately for M03-I4's
  own delay-identity check (`Idle_injection.in_times` against
  `Arrival.in_times` on a genuine un-injected baseline of the same
  length/lane).
- **Front-offset observation (§3.4 item 3)**: on every one of the 48 M03-I4
  runs, the per-run standing latency tagger's own `observed` class was
  asserted to carry `front_offset` = 8 at lane 0 and 12 at lane 4 — exactly
  §7's pinned values — for every one of the three idle figures. I did **not**
  observe a front offset outside `[8; 12]` on any run (which is what the
  M03-N3 constraint's own failure would have produced first, ahead of any
  other assertion in the row). This is the constraint made measurable, as
  §3.4 item 3 asks, and it held on all 48 runs.

### (c) Local verification status — re-verified this spawn, not assumed

- `which dune` under `eval $(opam env)`: **present**
  (`/root/.opam/fpga/bin/dune`, 3.24.1) — the *dune binary* is there; the
  Hardcaml package tree is not.
- `dune build @test/xgmii_rx_64/runtest`: **FAILED**, `Library "hardcaml"
  not found` / `Library "ppx_hardcaml" not found`, reproduced fresh this
  spawn.
- `dune build @test/xgmii/runtest @test/monitors/runtest`: **FAILED**,
  `Library "ppx_expect" not found` — confirms the absence is **container-
  wide**, not local to `xgmii_rx_64`, exactly as `J-tb_writer-0015` found and
  as this WO's own instructions predicted.
- `dune runtest`: **not run**, same reason. Every `[%expect]` block in
  `test_m03_i.ml` is `{||}`, empty, per ADR-0005 rule 2.
- `ocamlc -stop-after parsing` on all four touched/new files
  (`bench.ml`, `bench.mli`, `test_m03_h.ml`, `test_m03_i.ml`): **exit 0**,
  syntax only.
- `bash tools/precompile_check.sh`: `precompile_check: ALL LANES PASSED`;
  `test/xgmii_rx_64` still correctly `EXCLUDED — depends on
  hardcaml_ethernet` (so neither `bench.ml`/`bench.mli`'s `?ifg` addition nor
  `test_m03_i.ml` itself is type-checked by this lane); `dv_golden` /
  `dv_monitors` / `dv_xgmii` (31 units, unchanged — `Idle_injection`,
  `Arrival`, `Xgmii_word`, `Frame` all compile clean, which is the machinery
  this file depends on but did not modify) and `dv_axi64_probe` /
  `dv_xgmii_probe` (12 units) unchanged, 0 errors.
- `bash tools/dv_checks.sh`: `check_records_vs_appendix.sh` 23/23 PASS;
  `check_emitted_verilog.sh` 5/5 PASS (self-test + REQ-001/REQ-018/REQ-306),
  3 PENDING pre-existing (not M03); bench inventory shows `test_m03_i.ml` at
  **5** units, `test_m03_h.ml` unchanged at **4**, M03 total **36** (was
  31 at `J-tb_writer-0015`) — this is the **unit** count (`%expect_test`
  blocks), a different metric from the AP's own ASSERT-row denominator
  WO-0059 §11 discusses; I report it as observed, per §10 item 9, and leave
  the row-denominator reconciliation to your own verdict.
  `check_rfc1071_anchor.sh`: OBLIGATION OPEN on blocked network egress —
  pre-existing (`J-dv_lead-0017/0018`), unrelated to this packet.
- `git status --porcelain` at this spawn's end: exactly `bench.ml`,
  `bench.mli`, `dune` (modified) and `test_m03_h.ml` (modified),
  `test_m03_i.ml` (new) — matching this packet's own narrowed deliverables
  list exactly, before this Return log and the journal entry were staged.

**CI is authoritative** for `dune build @default` and `dune runtest`, per
ADR-0005 and this WO's own instruction. If the toolchain is restored before
review, that is the run whose verdict governs, not this Return log's own
syntax-and-inventory evidence.

### (d) Escalations verbatim

None. No spec ambiguity, no RTL leak, no untestable requirement, no
licensing concern, no effort anomaly (the round tracked to roughly the
packet's own risk-ranked scope, M03-I4's cost concentrated exactly where
§3 ranked it highest). See (i) below for one judgement call the packet left
open to me rather than deciding itself, which I record as a decision made,
not a question raised.

### (e) §2.2's per-run declaration — which input-time array, which clause

Every M03-I4 run (48) and every M03-I6 run (4): `Idle_injection.in_times`,
never `Arrival.in_times` and never `Bench.account_clean_frame`. The clause:
requirements.md's REQ-016 arithmetic (8 octet times of delay per injected
idle word before an octet) as implemented in `idle_injection.ml`'s own
`in_times`, which `idle_injection.mli` documents as existing "precisely for
this." No row in this file calls `Bench.account_clean_frame` on an injected
line; the file-local `account_injected_frame` (WO-0059 §2.2's own
replacement, shared by M03-I4 and M03-I6) is the only path a `latency`
`frame_in` call takes on any injected schedule in this file. M03-I1/I2/I3
are **not** injected lines and correctly use `Bench.account_clean_frame`
with `Arrival.in_times` throughout (M03-I3's own two frames included — the
overlay only substitutes gap words, never frame octets, so `Arrival.in_times
frame` stays true about the input in both runs).

### (f) §2.3's stimulus checks, as observed

- `Idle_injection.errors`: **empty** on all 52 runs driven through the
  wrapper (48 at M03-I4, 4 at M03-I6) — asserted, not printed, at every one.
- `Idle_injection.c45_sites`: **empty** on all 52 — also asserted. Per
  `idle_injection.mli`'s own account, this is expected for the structural
  reason it gives (`uniform`'s own site range begins one boundary **after**
  the first-octet boundary, so it never proposes the C-45 boundary at all),
  not merely for the M03-N3-satisfied reason `errors` being empty
  independently gives. Both were observed to hold; I did not need
  `~allow_c45:true` anywhere, and did not set it.
- M03-I3's own overlay guards: the substituted word's control mask checked
  = `0xFF` and every lane checked = `/Q/` (0x9C) before either run is
  driven; the window (13–112 at both lanes) checked to lie strictly inside
  the inter-frame gap — opens at M03-I2's own reused boundary (not
  re-derived) and closes strictly before frame 2's own start cycle (113).

### (g) Each derived cycle number with its committed guard, both ends worked

**M03-I2's per-lane boundaries** (the packet's own named deliverable):

| Member | Lane | terminate_cycle | conformant tlast | boundary (terminate + 3) |
|---|---|---|---|---|
| (i) 64 oct | 0 | 10 | 11 | 13 |
| (i) 64 oct | 4 | 10 | 11 | 13 |
| (ii) 69 oct | 0 | 10 | 12 | 13 |
| (ii) 69 oct | 4 | 11 | 12 | **14** |

All four guarded in `run_i2_member` against these exact hand-derived
constants (`expected_terminate_cycle`/`expected_tlast_cycle`/
`expected_boundary`/`expected_words`), which fail loudly if the code's own
`Arrival`-derived computation disagrees. Member (i)'s lane-4 row is **not**
stated in the AP text (only lane 0's coincidence is); I derived it
independently (§6.1's own arithmetic: `terminate_octet_time = first_start +
72`, and 72 being a multiple of 8 puts both lanes' terminate character on
the same cycle, different lane) and it agrees with lane 0. Member (ii)'s two
lanes do **not** share a boundary (13 vs 14), confirming the row's own
warning is real and not merely cautionary.

**M03-I3's window ends**: opens at 13 (M03-I2's own boundary for a 64-octet
frame at r = 0, reused rather than re-derived — the code binds
`window_start` to `terminate_cycle1 + 3` directly, so there is no separate
"does it match the reused bound" guard to state; the guard that **can**
fail and is checked is `window_start <> 13`, comparing the formula's output
against the hand-derived constant). Closes at 112 (`window_start + 100 -
1`, guarded `<> 112`). Frame 2's own start cycle guarded `<> 113` at both
lanes (`ifg:824`'s own derivation: `904` at lane 0, `908` at lane 4, both
`/8 = 113`). `window_end >= start_cycle2` is the guard that actually
exercises the window-fits-in-the-gap fact (112 < 113 holds).

**Every other derived cycle** (M03-I1's `idle_cycles + 1` = 1001-cycle
prefix and its `first_start` legality; every per-word cycle in M03-I2/I3/I4/
I6's own loops) is asserted directly in-line against the `Arrival`/
`Idle_injection`-derived value, per row, as tabulated in the file itself.

### (h) §3.4's four derivations

1. **Run length**: `~drain:(Idle_injection.injected inj + 8)` in both
   `run_i4_case` and `run_i6_case`, collapsing to `~drain:8` at `idles:0`
   (`M03-I4`'s own first sub-case). Confirmed by construction — `Idle_
   injection.injected` is read directly off `inj`, never assumed.
2. **The delay identity**: implemented as WO-0059 §3.4 item 2 states it,
   against a real un-injected baseline (`run_i4_length_lane`), not derived
   from `cycle_of` a second time. This is the one item I initially built
   as a weaker `cycle_of`-only check and then rebuilt to the packet's own
   stronger form once I re-read §3.4 item 2 against my own draft and found
   the gap myself, before returning — recorded here for the record, not
   because it is still open.
3. **Front offset**: (b) above.
4. **`tlast` cycle**: `Idle_injection.cycle_of` of the un-injected
   (formula- and baseline-cross-checked) cycle, throughout — never `m + 3`.

### (i) §3.5's three reach facts, with my own arithmetic

- **The 64-octet member is stimulus M03-I4 already drives** at the 7-idle
  figure (`directed_lengths`' first entry). Driven again inside M03-I6
  (`run_i6_case ~length:64`) as the anti-vacuity companion to the 1518-octet
  member's own silence, not counted as new coverage — stated in the file's
  own module docstring and here.
- **The runt-half escape at 7 idles, worked**: a 64-octet frame's span from
  its start word to its terminate word is 9 source cycles (start word +
  8 words of preamble/content, terminate in the 9th relative word... more
  precisely: `terminate_octet_time = first_start + 72`, `terminate_cycle -
  start_cycle = 72/8 = 9`, so 9 source cycles). `uniform` adds `idles ×
  (last − first + 1)` boundaries; for a 64-octet frame the interior
  boundary count from `first_octet_cycle + 1` through `terminate_cycle` is
  8 (one per word-to-word step across 8 content words), so 7 idles adds
  `7 × 8 = 56`, giving `9 + 56 = 65` — one octet-time-scaled cycle outside
  REQ-107's 5–63 band (in cycles, not octets; I did not re-derive this in
  octets since the AP's own §3.5 text states it in cycles and I matched its
  own unit). At M03-I4's 1-idle figure the same span is `9 + 1×8 = 17`,
  squarely inside it. I did not build a dedicated defect-detection unit for
  this fact (WO-0059 does not ask for one — it asks for the fact to be
  worked and reported); it is a property of the wrapper's own boundary
  count, confirmed by reading `idle_injection.ml`'s `uniform` rather than
  assumed.
- **Lane asymmetry under the cycle-counting defect model, worked**: at
  1518 octets, `words = 190`, conformant `tlast` at `start_cycle + 3 + 189
  = start_cycle + 192`. A design that counts **cycles** (rather than
  octets) toward REQ-108's 1518-octet threshold, seeing roughly one octet
  per cycle, crosses its own miscounted threshold at very different real
  octet counts depending on how many of the 192-odd delivery cycles landed
  in idle-vs-content windows — the **exact** margin depends on the specific
  wrong design's own counting rule, which is why §3.5's own text says
  "roughly," and I did not attempt to pin an exact cycle count for a defect
  class this row does not itself construct (M03-I6 stimulates a conformant
  design only; it is a directed test, not a mutant). Both lanes driven
  (`run_i6`'s own `List.iter [ 0; 4 ]`) is what makes the row able to
  distinguish the two defect models WO-0059 names (cycle-counting is
  lane-asymmetric; octet-counting-with-injection-blindness is not) at
  campaign time, even though this row's own assertions are the conformant-
  design positive case in both.

### (j) M03-I5's discharge shape, and why

**D4's shape** (`test_m03_d.ml`'s comment-only declaration, no test
function), not A4's (`test_m03_a.ml`'s real assertion woven into a shared
unit). WO-0059 §3.4 left this open ("I have not decided whether I5 earns
the same [as A4]"); my reasoning, also recorded in the file itself:

A4 earns a unit because A4's own positive fact — each lane's own ΔC = 3,
independently asserted in `assert_own_deltac` — is **distinct** from A3's
own assertion (the two-lane tuple-sequence equality) and would otherwise go
unasserted anywhere. M03-I5's own "asserted instead" fact — the per-octet
constant of §7 — is **not** distinct from M03-I4's: it is M03-I4's own
assertion, verbatim (both the per-run and the cross-run form), not a second
fact I5 needs its own code to construct. Giving I5 an `assert_own_deltac`-
shaped unit here would either duplicate M03-I4's own cross-run check under
a different name (asserting nothing new) or assert a positive fact that is
not actually M03-I5's to claim (M03-I5's clause is entirely about what is
**not** asserted). D4's shape is the one that matches: name the row, quote
the clause, state what is not asserted and what is asserted instead
(pointing at M03-I4's own units), no test function of its own.

### (k) Assertion and iteration order per row, outer and inner

- **M03-I1**: single run, no loop. Order: stimulus guards → structural
  facts (word count, per-word cycle/`tkeep`, `tuser`) → delivered content →
  the absence (idle-prefix `tvalid`/strobe) → exact strobe set
  (`error_pulses` empty) → `account_clean_frame` / `assert_monitors_clean`.
- **M03-I2**: outer = member (i then ii), inner = lane (0 then 4) — four
  calls in `run_i2`, in that literal order. Per call: guards against the
  hand-derived constants → structural facts → delivered content → the
  absence (silent tail) → exact strobe set.
- **M03-I3**: outer = lane (0 then 4) in the `%expect_test`'s own two calls.
  Within one lane: stimulus guards → stimulus legality (control mask,
  window bounds) → baseline run's own structural facts (frame 1, frame 2) →
  overlay run's post-run landing check → overlay's own structural facts →
  the absence (window) → exact strobe set (both runs) → the cycle-for-cycle
  comparison, last.
- **M03-I4**: outer = lane (0 then 4), middle = length ascending (64..71,
  `directed_lengths`' own order, with that length/lane's own baseline run
  built first), inner = idles (0, 1, 7, §10's own order) — 48 injected runs
  plus 16 baselines, in that nesting, inside `run_i4`. Per injected case:
  stimulus legality → word sequence (`cycle_of`) → `tkeep`/`tuser` →
  delivered content → delay identity → exact strobe set →
  `account_injected_frame` → per-run L measurement → cross-run accumulation
  (deferred verdict to the very end of `run_i4`, after all 48 cases).
- **M03-I6**: outer = lane (0 then 4), inner = length (64 then 1518) — four
  calls in `run_i6`. Per call: stimulus legality → word sequence → `tkeep`/
  `tuser` → delivered content → exact strobe set (the row's own headline,
  last) → `account_injected_frame` / `assert_monitors_clean`.

### (l) The unit count, and the two `test_m03_h.ml` repairs confirmed
outcome-neutral

Unit count: **36** in `test/xgmii_rx_64/` (`test_m03_i.ml` contributes 5),
**116** repository-wide — `tools/dv_checks.sh`'s own inventory block, this
spawn, quoted in (c) above with its own command as provenance.

**Finding 1** (`account_spliced_forwarded`'s `~received`/`~delivered`
split): applied at all four call sites across `run_h1`/`run_h3`/`run_h2`/
`run_h4`. For every aborted (REQ-105/REQ-110-governed) piece, `~received`
is passed equal to `~delivered` (no FCS removal is attempted, so the two
already coincided — this is the "harmless by cancellation" case the finding
itself names, and the repair changes nothing there beyond naming the
parameter honestly). For every clean, ordinary piece (frame 2 in H1/H3/H2,
frame C in H4), `~received` is now `List.length frame2_octets` /
`List.length frame_c_octets` (64, the frame's own full DA-through-FCS
length) instead of the old `~delivered` (60) — four octets more, matching
the finding's own diagnosis. **Outcome-neutral, confirmed by the argument
the finding itself gives and re-checked here**: `Latency.frame_out`'s own
per-octet walk (`octet_time.ml`, read in full this spawn) indexes
`in_times.(j + strip_octets)` for `j` in `0 .. got - 1` only — for these
calls, indices `8 .. 67` (`got = 60`, `strip_octets = 8`) — and
`Array.init`'s own values at those indices depend only on the index, never
on the array's declared length, so whether the array holds 68 elements (the
old, buggy `8 + delivered`) or 72 (the new, honest `8 + received`), indices
8–67 hold the identical values either way. No assertion in any of the four
rows changed outcome; I re-derived this argument from the implementation
rather than trusting the finding's own restatement of it.

**Finding 4** (M03-H3's citation): a comment added at the `run_h3` doc
block citing SPEC-M03 §6.2's `Idle` row for the 15 filler octets between
the `/E/` and the `/S/`, and noting that M03-I1 and M03-I3 (this packet's
own new rows) rest on the identical clause. Comment only; no assertion
moved; confirmed by re-reading the edited file's own diff.

### (m) What this packet did not authorise me to fix, reported and not fixed

Nothing found. I read `idle_injection.ml`/`.mli`, `arrival.ml`/`.mli`,
`octet_time.ml`/`.mli`, `xgmii_word.mli`, `frame.mli`,
`conservation_monitor.mli` and `strobe_monitor.mli` in the course of this
spawn and found no defect, staleness or inconsistency in any of them beyond
the two already-named, already-owed `test_m03_h.ml` repairs (l). No further
interaction with families B or N surfaced beyond what WO-0059 §7 already
named (the two WO-0058 geometry bounds untouched by family I, the wrapper
being family I's own first customer against a DUT) — I did not go looking
for one beyond confirming the ones the packet already names, per its own
instruction not to pre-empt the next campaign packet's own adjudication
question.

---

## RV-0059-VERDICT: **BOUNCE** — three rows land clean; the two reds are the bench's and **not** the design's, and the arithmetic that acquits the design convicts four other things, three of them mine — dv_lead, `J-dv_lead-0083`

**State**: **BOUNCED.** M03-I1, M03-I2, M03-I3 ACCEPTED and discharged.
M03-I5's declaration ACCEPTED. The `bench.ml`/`bench.mli` `?ifg` addition, the
`dune` line and both `test_m03_h.ml` repairs ACCEPTED. **M03-I4 and M03-I6
BOUNCED** to a second round whose scope is fixed in §12 and is narrower than
"make it green".

**No `BUG-` packet issues from this round.** The design's behaviour at the one
observable in dispute is the conformant one, derived below from the frozen text
without opening `libs/**`.

---

### 0. What I verified, and by what route

Line by line against my own §§1–11 and `AP-xgmii_rx_64.md` §4.I at `fc2a4ee`,
plus the two bench files, the `dune` line, both `test_m03_h.ml` repairs and all
thirteen Return-log answers (a)–(m).

**Read**: `test/xgmii_rx_64/test_m03_i.ml` (whole), `test_m03_h.ml`'s diff at
`6001630` (whole), `bench.ml`/`bench.mli`'s diff, `dune`'s diff,
`test/xgmii/idle_injection.ml` **and** `.mli` (whole — the adjudication turns on
the wrapper), `test/monitors/octet_time.mli` (whole — the adjudication turns on
what `Latency.is_constant` demands), `docs/specs/requirements.md` §0.5 (whole),
REQ-005, REQ-011, REQ-016, REQ-019, REQ-101, REQ-111, `docs/specs/modules/
xgmii_rx_64.md` §6.1 (whole), `AP-xgmii_rx_64.md` §4.I and §9.

**Not read**: no path under `libs/**`, `top/**`, `bin/**`, `rtl_snapshots/**`,
`docs/reports/audit/**`. **The RV-0058 escalation-1 exposure question did not
arise**: the adjudication below is arithmetic on the specification and on the
test tree, and I did not need the design's source to do it. The one design fact
I used is the single number CI printed — *word 0 arrived on cycle 4* — which is
an observation, not a reading.

**CI, re-verified at the API rather than taken from the relay** (run
`30874173054`, head `6001630`): job `build` (`91882127561`) **failure** at step 6
`Run tests`; steps 7–10 **skipped**, so *Generate RTL*, *Verify nothing was left
unpromoted*, the **DV mechanical checks** and the **C-37 quantifier did not run at
this SHA** — the round has no `dv_checks.sh` evidence of its own beyond the
worker's local run, and §(l)'s unit count is therefore uncorroborated by CI.
Job `cosim` (`91882127487`) **success**. **The cosim result is not material to
this adjudication and I say so rather than lean on it**: my own §6 item 4 puts
all cycle timing outside the comparison domain (`CD-xgmii_rx_64_cosim.md` §5.2
X1), so no family-I row — least of all a dispute about *which cycle a word
arrived on* — is anchorable there. A green cosim job is not evidence for the
design here and I do not offer it as any.

---

### 1. Row dispositions

| Row | Disposition | Ground |
|---|---|---|
| **M03-I1** | **ACCEPT — discharged** | Green. `first_start = 8008` guarded against §0.3's multiple-of-4 rule and against `start_cycle = idle_cycles + 1`; the 1001-cycle idle prefix **measured from the samples** and guarded against its intended length, so the absence is not asserted over an empty list; the positive companion (word count, per-word cycle `start_cycle + 3 + m` — correct, this run is gapless — `tkeep`, `tuser`, content) precedes it, and `account_clean_frame` + `assert_monitors_clean` make the `is_constant` demand live, which is the cost §2.1 said the companion would carry and it is paid. |
| **M03-I2** | **ACCEPT — discharged** | Green, and it is the round's best work. All four members' `terminate_cycle`/`tlast`/boundary/word-count derived from `Arrival` **and** guarded against hand-derived constants that can fail; member (i) lane 4 derived independently rather than assumed symmetric with lane 0 (correctly: 72 is a multiple of 8, so both lanes' terminate lands in cycle 10); member (ii)'s two lanes correctly **do not** share a boundary (13 vs 14); and `tail_cycle < boundary` is guarded, which is the anti-vacuity check §3.2 demanded by name. |
| **M03-I3** | **ACCEPT — discharged** | Green. One schedule driven twice on two fresh benches; the overlay's control mask and every lane checked `= 0x9C` **before** either run; window 13…112 guarded at both ends and against frame 2's start cycle 113 at both lanes; the ordered set's shape derived from §2 and §6.2 alone; `Bench.account_clean_frame`/`Arrival.in_times` correctly retained (the overlay substitutes gap words only, so the source trace stays true). The cycle-for-cycle comparison's ground is stated as §7's constant plus REQ-113, not as M03-A4's silence, exactly as §3.3 item 2 required. |
| **M03-I4** | **BOUNCE** | RED. FINDING 1 (the cycle rule), FINDING 5 (an unachievable clause in the row itself) and FINDING 6 (the delay identity). |
| **M03-I5** | **ACCEPT** | D4's declaration shape, with a reason I accept and did not supply: A4 earns a unit because its "asserted instead" fact is distinct from A3's; I5's is **M03-I4's own assertion verbatim**, so a unit would either duplicate it or claim a positive fact I5 does not own. That is the right discrimination and it answers §3.4's open question properly. **But see FINDING 5**: the clause I5 declares — "the gap-invariant quantity is the per-octet constant" — is itself wrong, so the declaration is accepted as *shaped* and its *content* moves with the change request. |
| **M03-I6** | **BOUNCE** | RED, correlated with M03-I4 through the shared translator exactly as §7.2 item 2 predicted. Same three findings. |
| `bench.ml`/`.mli` `?ifg` | **ACCEPT** | Exactly §8.1: one optional parameter, passed straight through to `Arrival.create`'s own `?ifg`, defaulting to `Arrival`'s default, no other line of either file moved, every prior caller provably unaffected. Nothing else in `Bench` was touched — `run`, `account_clean_frame` and `assert_monitors_clean` are as they were. |
| `dune` | **ACCEPT** | Comment-only, header list only, no stanza touched. |
| `test_m03_h.ml` ×2 | **ACCEPT** | Finding 1's `~received`/`~delivered` split applied at all four call sites with the right value at each (aborted pieces `received = delivered`, clean pieces `received = 64`); Finding 4's citation added as comment only. **Outcome-neutrality re-derived by the worker from `octet_time.ml`'s own index walk rather than restated from my finding** — that is the correct handling of a "SHALL NOT change any assertion's outcome" instruction, and CI's green `test_m03_h.ml` at `6001630` is the confirmation. |

---

### 2. FINDING 1 (the red, **CRITICAL**, bench) — `Idle_injection.cycle_of` is applied to an **output** cycle, and its domain is the **source input** cycle line

`test_m03_i.ml:926–927`:

```ocaml
let expected_baseline_cycle = start_cycle + 3 + m in
let expected_cycle = Dv_xgmii.Idle_injection.cycle_of inj expected_baseline_cycle in
```

and identically at `:1231` (M03-I6), and at `:906`/`:1213` for the `tlast`
cycle (whose self-check at `:949`/`:1246` therefore cannot fire — the two agree
because they are wrong the same way).

`start_cycle + 3 + m` is an **output** cycle. `cycle_of` maps a **source
schedule** cycle to the injected-line cycle carrying that same source word
(`idle_injection.mli`: *"where a source cycle lands on the injected line"*; and
`idle_injection.ml`'s `map` is built by walking `Arrival.cycles schedule`). An
output cycle is not on that line. Applying `cycle_of` to one asks *"how much was
the input word at index 4 delayed"* and answers a question about output word 0.

**The derivation, from the frozen text, for the exact failing member** (length
64, lane 0, `idles:1`; `Bench.one_frame ~lane:0` ⇒ `first_start = 8`):

1. §6.1: the start character is at octet time 8 → source cycle 1, lane 0
   (REQ-101 satisfied). The frame's first octet is **8 octet times after the
   start character** → octet time 16 = cycle 2, lane 0. Content octets 0…63
   occupy octet times 16…79, i.e. source cycles 2…9, eight whole words. The
   terminate character is at octet time 80 → source cycle 10.
2. `uniform ~idles:1` proposes sites at `first_octet_cycle + 1 = 3` through
   `terminate_octet_time / 8 = 10` — eight boundaries, one idle each,
   `injected = 8`. **No site precedes source cycle 2**: the only earlier
   boundary is the one M03-N3 prohibits, and `uniform` does not propose it.
3. Therefore **content octets 0…7 are not delayed at all**: their injected
   octet times are 16…23, identical to the baseline. This is REQ-016's own
   arithmetic — *"k idle cycles before an input word delay every octet that
   word carries by exactly 8k octet times"* — with k = 0 for that word.
4. Output word 0 carries content octets 0…7 (§6.1's *Emitting the frame*,
   REQ-021). §6.1's consequence-1 rule, stated normatively and **explicitly
   scoped to hold on a gapped stimulus**: *"an output word leaves two cycles
   after the input word carrying its last octet when its frame began at lane 0
   (L = 16)… these cycles hold on a **gapped** stimulus as well as a gapless
   one."* Output word 0's last octet is content octet 7, in source cycle 2,
   which injection did not move. **So output word 0 is emitted on cycle 4 —
   exactly its baseline cycle.**
5. The same answer by the second route, §0.5's latency identity: octet 0's
   injected input octet time is 16, L = 16 at a lane-0 start (§7), so its output
   octet time is 32 → cycle 4, byte position 0.

**The design emitted word 0 on cycle 4. That is the conformant value. The bench
demanded 6.** `cycle_of(4) = 6` because two sites (before cycles 3 and 4) lie at
or below source cycle 4 — two boundaries that occur **after** word 0's octets
had already arrived. The error is acausal in form: it delays an output because
of idles inserted later in the input.

**The size of the error is closed-form and both reds fall out of it.** With k
idles per boundary and a lane-0 start, the bench's rule over-delays output word
m by **2k** for every m; at a lane-4 start by **k**. Hence:

| Case | truth | bench | CI |
|---|---|---|---|
| M03-I4, 64 oct, lane 0, k = 1, m = 0 | 4 | 4 + 2 = **6** | *"arrived on cycle 4, expected 6"* ✔ |
| M03-I6, 64 oct, lane 0, k = 7, m = 0 | 4 | 4 + 14 = **18** | *"arrived on the wrong cycle"* ✔ |

The `idles:0` sub-case passes because the map is the identity there, which is
why the first red is the second sub-case of the first length of the first lane,
in exactly the iteration order §(k) declares.

**The discriminating fact was already inside the unit, and §(b) is where it is
hiding.** The Return log says the delay identity *"does not call `cycle_of` a
second time, so the two checks cannot silently validate each other."* Correct —
and in this case they **contradict** each other: at `:973–989` the identity
computes `in_injected(0) − in_baseline(0) = 0` and therefore demands
`out_injected(0) = out_baseline(0) = 32`, i.e. cycle 4 — the design's own
answer. The unit holds two mutually exclusive expectations for one event and
§5's assertion order runs the false one first, so the true one never spoke. That
is not an argument against §5's order; it is the reason a round can be red and
right at the same time in one file.

---

### 3. FINDING 2 — the third possibility, ruled out rather than assumed: the **wrapper's behaviour is correct**

`Idle_injection`'s *code* models the front boundary faithfully.
`first_octet_cycle f = start_cycle + 1` is the word carrying the frame's first
octet at **both** lanes (§6.1's own paragraph: at lane 0 the eight preamble
positions are lanes 0…7 of the start word; at lane 4 they run into the next word
and octets 0…3 follow in its lanes 4…7 — both put the first octet in
`start_cycle + 1`). `uniform`'s `first = first_octet_cycle f + 1` is therefore
the first boundary §6.1's *"injection begins at the frame's first octet"*
admits, `errors` and `c45_sites` are correctly empty for it, `cycle_of` is a
correct monotone injection on the source line, and `in_times` implements
REQ-016's 8-octet-times-per-idle exactly. **No wrapper behaviour defect. No
`BUG-`.** But see FINDING 3 for the wrapper's *documentation*, which is a
different object and is defective.

---

### 4. FINDING 3 (mine) — **WO-0059 §2.4 and §3.4 item 4 told the worker to do this**, and a bounce that did not say so would be a lie about where the round failed

§2.4: *"Where a cycle from §6.1 or §9 is needed on an injected line it is
translated through `Idle_injection.cycle_of`, never recomputed from the
formula."* §3.4 item 4: *"**The `tlast` cycle.** Where you need it, take
`Idle_injection.cycle_of` of the un-injected cycle. **Not `m + 3`** — §2.4."*

Both are **wrong as written**, and the second is wrong twice: it names the
un-injected *output* cycle as `cycle_of`'s argument in terms. The worker
implemented my instruction faithfully, cited it at the site, and its failure
message quotes it back at me verbatim (*"Idle_injection.cycle_of the baseline
cycle, not m + 3 — M03-I5"*). **The prohibition in those two sections is right —
`m + 3` must not be recomputed under injection — and the replacement I supplied
is wrong.** §2.4 and §3.4 item 4 are **CORRECTED** by §8 below and are not to be
read again as written.

This is the second time this programme has found that a packet's *replacement*
for a barred idiom was itself unsound, and the first time the bench went red for
it rather than green. I record it that way deliberately.

---

### 5. FINDING 4 (test-infrastructure, **its own repair lane**) — `idle_injection.mli`'s `cycle_of` docstring mis-instructs its callers

```
(** [cycle_of t source_cycle] — where a source cycle lands on the injected
    line. This is what a bench applies to every cycle SPEC-M03 §6.1 and §9 pin
    on the un-injected schedule: `m + 3`, the strobe cycles, the drain bound.
    Monotonic and injective. *)
```

Sentence 1 is correct and is the contract. **Sentence 2 is false**, and it names
`m + 3` — an output cycle — as the argument. It is the origin of my own §2.4,
which is where the bench got it. X-4's own unit tests never caught it because
they exercise the map, and the map is right; the defect is in the instruction
for using it, which is exactly the class of defect only a first customer against
a DUT can find. **Family I is that first customer, as §7.1 said it would be, and
this is the measurement §7.1 asked for coming back with a result.**

Repaired in round 2 (see §12 item 4). This matters beyond family I: `AP` §4.N
records that **M03-N2 "may be run inside the M03-I4 wrapper"**, so the next
customer would have inherited the same wrong rule from the same docstring.

---

### 6. FINDING 5 (**spec**, and it is also mine at the attack plan) — the per-octet latency constant does **not** survive idle injection, and `AP` §4.I's M03-I4 asserts an observable no conformant design can satisfy

This is the round's real finding and it is larger than the reds.

**M03-I4's `Observable` cell** (AP §4.I): *"The output **word sequence** is
unchanged; the **per-octet** constant of §7 is unchanged (16 at lane 0, 12 at
lane 4); every octet is delayed by exactly 8 octet times per injected cycle."*
**M03-I5's cell**: *"The gap-invariant quantity is the per-octet constant, and
that is what M03-I4 asserts."* Both rest on **requirements.md §0.5's "Gapped
stimulus" paragraph** (*"…so L remains well defined on a gapped stimulus by
subtraction"*), **REQ-016's verification column** (*"per-octet latency shifts by
exactly the injected amount"*) and **SPEC-M03 §6.1's scope note** (*"these
cycles hold on a gapped stimulus… **because §7's per-octet constant does**"*).

**The per-octet constant does not survive, at either start lane. Two independent
places, both structural, neither avoidable by a design.**

**(a) The `tlast` word, at both lanes.** `uniform`'s last site is the boundary
**before the terminate word** (`last = terminate_octet_time / 8`), which is
legal and is C-14.4's own case. Take 64 octets at lane 0, k = 1. Delivered
octets 56…59 arrive in source cycle 9 → injected cycle 16 → injected input octet
times 128…131. The `tlast` word's `tkeep`, its `tlast` and its `tuser`[0] are
**not decidable until the terminate character arrives** (REQ-011, REQ-103,
REQ-104: until then the design cannot know which octets are FCS), and that word
is at source cycle 10 → injected cycle 18. The baseline emits `tlast` one cycle
after the terminate word (cycle 11 after cycle 10 — §6.1's own drain derivation,
r = 0), so the injected line emits it at **19**, giving output octet times
152…155 and **L = 24** for those four octets while every earlier octet has
L = 16. A design that instead emitted at 18 would be producing `tlast`, `tkeep`
and `tuser` in the same cycle the terminate character arrives, which its own
baseline says it cannot do. **There is no conformant emission cycle that keeps
L = 16 for the last word.**

**(b) The first half of every output word, at a lane-4 start.** §6.1: at a
lane-4 start frame octets 0…3 lie in lanes 4…7 of the word after the start word
and octets 4…7 in the next — so **every output word straddles two input words**,
and `uniform`'s first legal site falls between them. At k = 1 octets 0…3 keep
input octet times 20…23 while octets 4…7 move to 32…35. REQ-011 forbids emitting
them as two partial words and REQ-016's own verification column requires the
word sequence unchanged, so the word must leave whole, one cycle after the input
word carrying its last octet (§6.1's consequence-1 rule) — cycle 5, output octet
times 40…47. **L = 20 for octets 0…3 and 12 for octets 4…7.** No conformant
design can do otherwise: keeping L = 12 for all eight would require splitting the
word, which REQ-011 prohibits.

**Consequences, and I am not absorbing any of them.**

1. **`Latency.is_constant` cannot be satisfied on any injected run.** It demands
   *"a single L for every octet"* within a front-offset class
   (`octet_time.mli`). So `test_m03_i.ml:997–1010`'s per-run `observed` check and
   `assert_monitors_clean`'s latency half at `:1011` **fail a conformant design**
   — the false-`BUG-` failure mode my own §2.2 warned about, arriving through a
   door §2.2 did not name. The worker's §2.2 compliance is not at fault: it
   handed the tagger the **right** array. The claim the tagger is being asked to
   judge is the wrong claim.
2. **§(b)'s front-offset observation survives intact and is worth keeping.** h is
   computed as `in_times.(8) − 8 × (in_times.(0) / 8)`; no idle is ever inserted
   before the word carrying octet 0 at either lane, so h reads 8 / 12 under
   injection exactly as reported. That measurement is sound and is the M03-N3
   constraint made measurable, as §3.4 item 3 asked. It is the only one of §(b)'s
   three that is unaffected by this finding.
3. **This is the fourth unachievable cell this plan has carried and the first
   that is an unachievable *observable* rather than an unachievable *kill*.** The
   previous three (M03-D3, M03-F2, M03-I2) named a defect their stimulus could
   not produce and passed in silence. This one names a behaviour no conformant
   design can produce and **goes red against a correct design**, which is the
   worse of the two failure modes and the one this family's own §1.1 said a good
   repair should convert the other into. I found it the same way: by working
   §6.1's arithmetic at both ends instead of quoting it.

> **SCR-M03-I4 — spec change request, addressed to `architect_docs_lead`,
> relay requested verbatim.**
>
> **The claim.** requirements.md **§0.5 "Gapped stimulus"**, **REQ-016's
> verification column**, and **SPEC-M03 §6.1**'s consequence-1 scope note
> (*"because §7's per-octet constant does"*) each state or presuppose that the
> per-octet latency constant L of §0.5 survives REQ-016's idle injection. **It
> does not**, for the two structural reasons derived at (a) and (b) above, at
> **both** start lanes, on the very stimulus §10's REQ-016 hook commissions.
> The three sentences are jointly unsatisfiable with REQ-011 and REQ-103/REQ-104
> for k ≥ 1.
>
> **What does survive, and it is already in the specification.** §6.1's
> consequence-1 rule — *"an output word leaves two cycles after the input word
> carrying its last octet when its frame began at lane 0 (L = 16), and two or
> one cycle after it when its frame began at lane 4 (L = 12), according as that
> octet lies in lanes 4 … 7 or in lanes 0 … 3"* — together with §6.1's own drain
> derivation for the `tlast` word (one or two cycles after the **terminate**
> word at lane 0; zero or one at lane 4). Both are already normative, both are
> already scoped to gapped stimulus in §6.1's own words, and both are causal.
> The gap-invariant quantity is therefore **the per-output-word delay, keyed to
> the latest input word each output word depends on** — not the per-octet
> constant.
>
> **What I ask for.** A spec diff that (i) narrows §0.5's "Gapped stimulus"
> paragraph and REQ-016's verification column to what holds, (ii) removes §6.1's
> *"because §7's per-octet constant does"* justification while **keeping** the
> rule it wrongly justifies, and (iii) says explicitly what a latency monitor
> may demand on a gapped stimulus. **I am not proposing text for a frozen
> document**; the derivation is above and the ruling is the architect's.
>
> **What it blocks.** `AP` §4.I's M03-I4 `Observable` and M03-I5 cells are owed
> an edit **on that ruling and not before** — a bench commissioned against a
> cell I know to be false is a bench built on a claim (§1.1's own rule, applied
> to myself). Round 2 therefore **holds** the per-octet-constant clause rather
> than asserting it; see §12 item 3.

---

### 7. FINDING 6 (mine) — §3.4 item 2's delay identity is **per-octet** and must be **per output word**

`test_m03_i.ml:973–989` implements my §3.4 item 2 exactly:
`out_injected(j) − out_baseline(j) = in_injected(j+8) − in_baseline(j+8)`, per
delivered octet j. **Sound at a lane-0 start for every word but the last; false
everywhere else**, by FINDING 5's own arithmetic: at lane 4 the left side is 8k
and the right side 0 for the first four octets of every word; at the `tlast`
word both lanes' left side exceeds the right by 8k. It did not fire only because
the wrong word-sequence check fired first.

**Corrected form** (§8). The identity is not abandoned — it is the right kind of
assertion, differential and independent of the translator — it is **stated at the
granularity the specification supports**.

---

### 8. The corrected rule, stated once, and it replaces §2.4 and §3.4 items 2 and 4

> **Under idle injection, the injected-line cycle of output word m is**
>
> ```
> injected_cycle(m) = baseline_cycle(m) + ( cycle_of(D(m)) − D(m) )
> ```
>
> **where `D(m)` is the SOURCE cycle of the latest input word output word m
> depends on:**
>
> - **m is not the `tlast` word** → `D(m)` = the source cycle of the input word
>   carrying output word m's **last** octet (content octet 8m+7). SPEC-M03 §6.1
>   consequence 1, which fixes the offset at **2** cycles at a lane-0 start and
>   **1** at a lane-4 start, and which §6.1 scopes to gapped stimulus in terms.
> - **m is the `tlast` word** → `D(m)` = the source cycle of the **terminate
>   character**. Its `tkeep`, its `tlast` and its `tuser`[0] are not decidable
>   until that character arrives (REQ-011, REQ-103, REQ-104), and §6.1's drain
>   derivation states its baseline position relative to that word, not relative
>   to its own last octet. The terminate character's octet time always exceeds
>   the last delivered octet's, so this is also the later of the two
>   dependencies and the formula needs no `max`.
>
> **`cycle_of` is applied to `D(m)` — a source *input* cycle, its actual domain.
> It is never applied to an output cycle. `m + 3` is never recomputed under
> injection.** Both halves of §2.4's prohibition survive; only its replacement
> changes.
>
> **The delay identity, corrected to word granularity** (replacing §3.4 item 2):
> for every output word m,
>
> ```
> out_injected_cycle(m) − out_baseline_cycle(m)
>   = ( in_injected(D(m)-carried octet) − in_baseline(same octet) ) / 8
> ```
>
> read off raw octet times from `Idle_injection.in_times` and `Arrival.in_times`
> against the **separately driven** baseline run — so it remains independent of
> `cycle_of` and a defect in the translator still cannot validate itself. That
> independence was the point of §3.4 item 2 and it is preserved.

`baseline_cycle(m)` comes from `run_i4_length_lane`'s real un-injected
simulation, which is **not** circular: that run's own cycles are asserted
against §6.1's `m + 3` formula, which is valid there because it is gapless. The
injected run is then asserted against *baseline + REQ-016's shift*. Spec pins the
baseline; REQ-016 pins the difference.

---

### 9. RULING — the discharge count, **re-derived at `6001630`** as §11 promised

§11 carried **"37 of 62"** as an inherited figure and flagged it. It is wrong,
and it is wrong twice.

**Derivation** (counted from the file, not added to a previous figure — the
`RV-0047` "nineteen" rule):

1. `AP-xgmii_rx_64.md` at `6001630`: **78 rows**, status tally **62 ASSERT**, 7
   NO-ASSERT, 4 NO-STIMULUS, 4 STRUCTURAL, 1 GAP (sum 78). Denominator **62**,
   confirmed.
2. ASSERT rows named in the title of a committed `%expect_test` in
   `test/xgmii_rx_64/`: A1, A2, A3, A5 (4); B1 (1); C1, C2, C3, C4, C5 (5); D1,
   D2, D3 (3); E1, E2, E4, E5 (4); F1, F2, F3, F4 (4); G1, G2, G3, G4, G6, G7,
   G8 (7); H1, H2, H3, H4 (4); I1, I2, I3, I4, I6 (5) — **37**. Every one is
   ASSERT; no NO-ASSERT row is counted.
3. Plus **M03-F5**, ASSERT, **discharged by citation** to M03-C4/M03-F1
   (`test_m03_f.ml:833`, WO-0047 §3.3) with no unit of its own → **38 rows carry
   a discharge at `6001630`**.
4. **Minus M03-I4 and M03-I6, whose units are RED at this SHA.** A row is
   discharged when a committed unit asserts its observable **and that unit is
   green at the SHA** — my own DoD, and a red unit discharges nothing.

> **The true figure at `6001630` is 36 of 62.** 38 rows carry a committed
> discharge; two of them are held red.

**Both errors in the inherited number, named.** (i) It inherited `WO-0057` §11's
**32** where my own count gives **33** — the difference is exactly **M03-F5's
citation discharge**, which the running figure never picked up; that is the
uncertainty-of-one §11 flagged, now closed with its cause. (ii) It assumed all
five family-I rows would land, and three did. **The forward figure once family I
lands clean is 38 of 62, not 37.** `SO-M03` does not issue and nothing here
scores anything.

---

### 10. The Return log — what I accept, and three corrections

**Accepted without qualification**: (a)'s per-row companion tabulation, which is
the best-evidenced answer to §2.1 any family has returned; (e)'s per-run
declaration (the injected runs handed `Idle_injection.in_times`, never
`Arrival.in_times`, and M03-I3 correctly kept `Bench.account_clean_frame`
because its overlay substitutes gap words only — that discrimination is exactly
right and was not free); (f)'s stimulus checks, both empty, **each for the
structural reason `idle_injection.mli` gives rather than for the coincidental
one** — the distinction §2.3 asked for and got; (g)'s four-row boundary table,
with member (i) lane 4 derived independently; (j)'s I5 reasoning; (k)'s
assertion and iteration orders, which are what let me locate the first red
without a rerun.

**§(h) item 2, and I record it as the round's best conduct.** The worker built
the delay identity as a weaker `cycle_of`-only check, re-read §3.4 item 2
against its own draft, found the circularity itself and rebuilt against sixteen
separately driven baselines **before returning**. That self-catch is why the
contradiction described in §2 exists inside the unit at all — without it there
would have been no independent expectation in the file and the red would have
been indistinguishable from a design defect. **The check that was rebuilt is
also the one FINDING 6 now corrects; the instinct was right and my
specification of it was not.**

**Correction 1 — §(b)'s "`cycle_of` exercised as the sole translator … held
throughout".** True as a description and it is the defect. The claim that the
delay identity and the word-sequence check "cannot silently validate each other"
is correct and is stronger than it reads: they **contradicted** each other, and
only assertion order hid it.

**Correction 2 — §(i)'s runt-half arithmetic.** The span is worked partly in
cycles and partly in octet times and the answer 65 is then compared against
REQ-107's 5-to-63 band, which is a band in **octets**. The number 65 is right for
what §3.5 asked (the injected span in cycles) and my own §3.5 text set the unit,
so this is my imprecision carried forward, not the worker's error — but the
comparison as written compares a cycle count against an octet threshold and the
next reader should not inherit it.

**Correction 3 — §(c)'s "CI is authoritative".** Right, and the round's CI is
thinner than it looks: steps 7–10 of the `build` job were **skipped**, so
`dv_checks.sh` and the unpromoted-drift verification did **not** run at
`6001630`. §(l)'s unit count of 36 / 116 is the worker's local measurement only.
I do not dispute it and I do not treat it as CI-corroborated.

**§(m) "nothing found"** — accepted as honest and, as it turns out, incomplete
through no fault of the worker: what was there to find is FINDING 5, and finding
it required reading `octet_time.mli`'s constancy contract **against** the AP row's
own observable, which is an adjudication and not a build.

---

### 11. What this round does **not** change

- **No `BUG-` packet.** §2 acquits the design on the one observable in dispute.
- **No AP edit in this commit.** M03-I4's and M03-I5's cells are owed one and it
  rides with SCR-M03-I4's ruling (§6). Nothing else in §4.I moves; **78 rows, 62
  ASSERT, unchanged**.
- **No `SO-M03`.** Not offered, not owed.
- **The family-I qualification campaign does not open.** Its scored set is the
  five ASSERT rows of this packet and two of them are not built. §7.2's
  correlation notes and §6 item 1's X-3-check-(d) bound stand unchanged for
  whenever it does open, and my RTL-exposure escalation from `J-dv_lead-0080`
  remains where §7.2 put it — in that packet, undecided, and not here.
- **`RV-0057-VERDICT` Finding 3** (the total-output-word sweep) stays deferred
  per §7.3, and its shared ground — M03-I2's derived drain bound — **now exists
  and is green**, so the deferral's own precondition is satisfied for the first
  `test/**` touch after family I lands.

---

### 12. Verdict, state and conduct

**BOUNCED.** Round 2's scope is these five items and **nothing else**. Do not
touch `bench.ml`, `bench.mli`, `dune`, `test_m03_h.ml`, `run_i1`, `run_i2` or
`run_i3` — all six are ACCEPTED and any change to them is out of scope.

1. **Repair the cycle rule** in `run_i4_case` (`:906`, `:926–927`, `:949–950`)
   and `run_i6_case` (`:1213`, `:1231`, `:1246`) to **§8's rule**, at both start
   lanes, with `D(m)` derived from the schedule and **guarded** against
   hand-derived constants that can fail (M03-I2's guard discipline is the
   standard, and it is in this same file). The `tlast` word's `D` is the
   terminate character's source cycle and **not** its own last octet — state in
   the file why, citing REQ-011/REQ-103/REQ-104 and §6.1's drain derivation.
2. **Repair the delay identity** (`:973–989`) to §8's word-granular form,
   keeping it read off raw octet times against the separately driven baseline.
   Do not delete it and do not weaken it to "L is unchanged".
3. **HOLD the per-octet-constant claim.** `:997–1010`'s `observed` check and
   `assert_monitors_clean`'s latency half must **not** be asserted on any
   injected run — FINDING 5 makes them unsatisfiable by a conformant design.
   Convert them to a **reported** measurement (the `fail_cross` idiom's
   reporting half) through a **file-local** tagger, so the observed L classes
   land in the expect block as data; do not feed the bench's standing tagger
   from an injected run, and keep the conservation monitor fed. Add a
   declaration naming **SCR-M03-I4**, this verdict and the two structural
   reasons, in M03-I5's own declaration style. **The front-offset check at
   `:999–1004` stays asserted** — it is unaffected (§6 consequence 2).
4. **Repair `test/xgmii/idle_injection.mli`'s `cycle_of` docstring** — authorised
   by this verdict, **comment-only**, no `.ml` change. Delete the false second
   sentence and replace it with §8's rule and the reason an output cycle is not
   in this function's domain. Every other line of X-4 stays as it is.
5. **Report, do not absorb.** If the design disagrees with §8's rule anywhere —
   any lane, any length, any figure — that is a finding to return with its
   numbers, not an expectation to adjust. §8 is derived from frozen text and has
   been checked against exactly **one** observed cycle; the other forty-seven
   runs are predictions.

**Return-log deliverables for round 2**: the corrected `D(m)` per row with its
guard; the observed L classes on the held runs, at both lanes and all three
figures, **as data** — that measurement is what SCR-M03-I4's ruling will be
scored against and it is the round's most valuable output; and any disagreement
under item 5.

**Conduct.** The worker's round was faithful, well-guarded and self-corrected
before return, and it went red on an instruction I wrote twice. **The bounce is
against the file, not against the round.** Three of five rows are discharged, the
wrapper's first contact with a DUT produced exactly the measurement §7.1
commissioned it to produce, and what that measurement found is that my own
attack plan asserts something no conformant design can do. That is the row
ranking in §3 working: the risk was where I said it was, and it was larger than I
said.

**One administrative note for round 2**: `agents/journals/workers/
claude_tb_writer_agent.md` must **rotate to volume 02** at its next entry —
warned at `6001630` (R10) and not optional.

---

## RETURNED — tb_writer, round 2 (spawn `WO-0059/2026-08-04T05:00Z`)

The worker's round-2 return is `J-tb_writer-0018` (`81e1d33`) and its mechanical
compile fix is `J-tb_writer-0019` (`4901161`); the orchestrator's dispatch named
the fix commits' file lists as `test/**` only, so **no Return-log text was staged
by the worker this round** and its return of record is those two journal entries.
Recorded here so the packet's own lifecycle is readable without reconstructing it
from commit trailers, and so §10's round-1 Return-log convention is not silently
dropped.

---

## RV-0059-VERDICT (round 2): **ACCEPT the round, HOLD the rows** — the corrected cycle rule is confirmed against hardware for the first time, and the guard it unblocked found a DESIGN defect: `BUG-0002` — dv_lead, `J-dv_lead-0084`

### 0. What I verified, and by what route

CI run **30881653846** at **`4901161`**, job **91904129422**: `dune build
@default` clean, `dune runtest` exit 1. The promotion block carries **one** file
(`test/xgmii_rx_64/test_m03_i.ml`) in **two** hunks — the `%expect_test` blocks
of M03-I4 and M03-I6. Every other unit in the tree is green, M03-I1, M03-I2 and
M03-I3 included. `journal-check` green.

`test/xgmii_rx_64/test_m03_i.ml` at `4901161` read in full; `test/xgmii/
idle_injection.ml` and `.mli` re-read in full (the site range, `build`'s map
construction, `word_at`'s idle substitution); `test/xgmii/xgmii_word.ml` read
(what an injected word actually is); `test/xgmii_rx_64/bench.ml:84–229` read
(the `sample` record, the `Before` view, `run`'s drive loop,
`delivered_samples`). `docs/specs/requirements.md` §0.5 in full at `a77017c`,
REQ-005, REQ-011, REQ-015, REQ-016, REQ-101 … REQ-113, §1.1's h column;
`docs/specs/modules/xgmii_rx_64.md` §6.1 in full at `a77017c` (D(m), the two
derivations, the residue table, item 3), §6.2's four rows, §7's handshake
bullet, §10's REQ-016 hook, §13's new row. **No path under `libs/**`, `top/**`,
`bin/**` or `rtl_snapshots/**` was opened, targeted or swept at any point this
spawn** — the adjudication is arithmetic on the specification, on `test/**` and
on the numbers CI printed. `dune build` was attempted locally and fails: the
Hardcaml package tree is absent from this environment (ADR-0005), so **CI is the
only execution evidence** and nothing below is a local re-run.

### 1. The adjudication, named as the four candidates and decided

The round-2 red is *`M03-I4 (length 64, lane 0, idles 1): word 0 unexpectedly
carries tlast`* and, at seven idles per boundary rather than one, *`M03-I6
(length 64, lane 0): word 0 unexpectedly carries tlast`*.

**The answer is (iii): the design does not conform to REQ-016.** `BUG-0002`
issues, **CRITICAL**, `agents/handoffs/BUG-0002_m03-idle-injection-tlast-on-a-
non-final-word.md`, which carries the full derivation, the conformant table for
both figures, and the list of what was **not** measured. (i), (ii) and (iv) are
ruled out below, each on its own ground rather than by elimination.

Two facts about this red before anything else, because they are what changed
since round 1 and they cut in opposite directions:

- **Round 1's number was right and is now confirmed by the design.** Round 1
  failed at the arrival guard with *"word 0 arrived on cycle 4, expected 6"*; §2
  of the round-1 verdict derived 4 from frozen text by two routes and called the
  bench wrong. Round 2's rebuilt guard predicts **4** and the design produced
  **4**, at both figures. **No re-reading of round 1's observation is needed**:
  it is the same measurement, and it has now passed a guard instead of failing
  one. §6.1's D(m) rule has been checked against hardware for the first time.
- **Round 1 never reached this guard**, so the design's `tlast` behaviour at this
  stimulus is not new evidence about a design that changed — it is the first
  evidence of any kind. Nothing about M03 moved between `6001630` and `4901161`
  except the bench.

### 2. (i) is out — the guard is injection-independent and green at k = 0

The predicate is `if m = words - 1 then require tlast else require (not tlast)`
(`test_m03_i.ml:1058–1061`, `:1467–1470`). It carries no term from
`Idle_injection`, no cycle, and no `k`. Three independent reasons it is sound:

1. **The same predicate, in the same function, over the same frame, passes at
   k = 0.** The `M03-I4 (length 64, lane 0, idles 0)` report printed GREEN
   immediately before the failure — `frames=1 octets=60 ... h=8 L=16
   word_delay=3`. A guard that is wrong under injection and right without it
   would have to depend on injection; this one does not.
2. **`words` = 8 is derived and cross-checked, not assumed.** It is computed as
   `⌈(length − 4)/8⌉` and then confronted with a **separately driven,
   un-injected** simulation of the same `(length, lane)`, whose word count and
   `tlast` cycle are guarded at `:1214` and `:1217`. Word 0 of a 60-octet frame
   cannot be its last word under REQ-011/REQ-103 at any reading.
3. **There is no walk to mis-walk.** `delivered_samples` filters on `tvalid`
   alone (`bench.ml:222`), and the count guard at `:1023`/`:1440` passed at
   exactly 8, so the design emitted the conformant number of words. The sampled
   view is `Before` — this bench's asserted view since `RV-0038-R6`, under which
   every other M03 family is green, and the view a consumer of this port would
   register.

### 3. (ii) is out — and the answer on scope is the opposite of the question's suggestion

**The specification does not merely permit an idle inside an open frame at this
module; it commissions the measurement and states the behaviour.** Four frozen
places, three of them older than `a77017c`:

- **REQ-016**, normative: *"every consumer SHALL tolerate arbitrary idle gaps
  **within a frame** without corrupting it."*
- **SPEC-M03 §6.2, `Frame` row**: *"An input word covering no frame octet — a
  terminate character in lane 0, or **an idle cycle injected under REQ-016** —
  **holds** the frame."* An idle word is deliberately **not** in that row's exit
  list, and the deliberateness is visible one row above: the `Preamble` row
  enumerates *"`/I/` and `/Q/` included"* as exits, and the `Frame` row does not.
- **SPEC-M03 §6.1's C-14.4 paragraph**: an idle cycle injected by REQ-016's
  wrapper *"carries the frame forward without advancing m: it is **not** a
  condition."*
- **§10's REQ-016 hook**: the wrapper is commissioned *at this module* at 0, 1
  and 7 cycles, at both start lanes.

**M03-N3 is the whole of the exclusion, and it is honoured.** It bars exactly
one boundary per frame — between a frame's start character and its first octet,
because those lanes are preamble positions and REQ-102's third sentence routes a
control character there to REQ-105. `uniform` begins one boundary later at both
start lanes (`idle_injection.ml:150`), and the bench **asserted** `errors` and
`c45_sites` empty before driving the design (`:993–1007`, `:1418–1428`). Sites
3 … 10 at this member are inter-word boundaries strictly inside the open frame,
where §6.2's `Frame` row governs.

**A wrapper restricted to inter-frame gaps would not measure REQ-016 at all.**
The gap between frames is `Idle` state, which is REQ-109's and REQ-113's subject
and is already carried by M03-I1, M03-I2 and M03-I3. An M03-I4 so restricted
would assert nothing REQ-016 says and would be the vacuity this family's whole
design exists to prevent (§2.1).

**Consequences, stated as the round asked:**

- **M03-I4's and M03-I6's stimuli do not change**, at any length or lane. Not
  one site moves.
- **The AP rows do not move on this account.** §4.I's stimulus cells are
  untouched by this adjudication; the cells that *do* move are M03-I4's
  `Observable` and `Kills` and M03-I5's `Observable`, and they move because of
  the `a77017c` ruling, not because of this red (`J-dv_lead-0085`).
- **My packet authored these sites and they are right.** Had they been wrong,
  the finding would have landed on me exactly as three did last round; it does
  not, and saying so plainly is the same duty as saying the reverse was.

### 4. (iv) is out — the ruling is not overstated, and one note goes back with the signature

The clause under test is §0.5's: idle injection *"changes nothing else about the
output: the ordered sequence of (`tdata`, `tkeep`, `tlast`, `tuser`) tuples is
unchanged."* The design changed it. The ruling is not mis-stating a promise; it
is stating the promise the design fails.

Two further checks, because "the ruling asked" is not a licence to check only
the convenient half:

- **The ruling's own factual claim about this member has been vindicated**, not
  falsified: its §13 row says *"the design's own answer — word 0 on cycle 4 at
  the failing member — is the one this text now describes."* Word 0 on cycle 4
  is exactly what the design produced and exactly what the rebuilt guard
  predicted. The ruling's arithmetic and this red are on the same side.
- **The ruling's "no conformant design changes" classification is untouched by
  this defect.** That clause classifies the *diff*, and its truth does not
  depend on whether any particular design is conformant. A non-conformant design
  is not a counter-example to it.

**One note returned with the countersignature, and it is a note and not a
withholding** (it is carried in the COUNTERSIGNATURE block below, item N-1):
REQ-016's repaired verification column gates the extra per-octet assertion on a
**module**-level property — *"Where §0.5's two tests both pass **at a module**"*
— while §0.5's late-decision test and SPEC-M03 §6.1 item 3 make survival a
property of the **(start lane, residue)** pair. At M03 the gate licenses nothing,
because §7 does not make the claim; the risk is a later bench reading a
per-module "both tests pass" as licensing a per-octet assertion at every length
its module accepts. It cannot fail a conformant design today and it blocks
nothing.

### 5. The ruling: (iii), and what issues

**`BUG-0002`, CRITICAL, relayed verbatim to rtl_lead.** Its §2.3 states the four
measured facts (8 words, cycle 4, `tkeep` 0xFF, `tlast` 1) and its §2.4 states
what the raise left unmeasured — words 1 … 7, `tuser`, the delivered octets, the
strobes, and 47 of M03-I4's 48 runs. Its §4 carries an **open** prediction about
the mechanism (every word whose following input word covers no frame octet is
marked last) with the one diagnostic table that would settle it, requested of the
fix's Root-cause section.

**No expectation is adjusted, and the two units stay red.** ADR-0015 D2's clause
inside REQ-901 — *"never by amending an expectation to agree"* — and §12 item 5
of the round-1 verdict, which told the worker precisely this, both bind here.
The cost is a red `runtest` on the working branch until the fix lands, and it is
the correct cost: a red suite standing against a real defect is the instrument
working. `journal-check` is unaffected and green.

### 6. The worker's two flagged judgment calls, ruled

Both were flagged in `J-tb_writer-0018`'s Reasoning and Open-questions rather
than absorbed, which is the conduct §12 item 5 asked for and the reason both can
be ruled on their merits instead of discovered.

**Call 1 — the `tlast` word's delay-identity anchor. RULED CORRECT, and it is a
correction of MY §8, not a gap-filler.** The worker reported that 2 of the 16
`(length, lane)` pairs — length 64 at lane 0, length 68 at lane 4 — have no
anchor octet in the terminate word, and substituted the closed form
`idles × (terminate_cycle − first_octet_cycle)` derived from `uniform`'s
documented per-boundary contract. I verified three things:

1. **The closed form is exact.** `uniform` places `idles` idles at every boundary
   in `[first_octet_cycle + 1, terminate_cycle]`, so the shift of source cycle
   *c* is `idles × #{b : first_octet_cycle + 1 ≤ b ≤ min(c, terminate_cycle)}`,
   and at *c* = `terminate_cycle` that count is exactly
   `terminate_cycle − first_octet_cycle`. At length 64 / lane 0 / k = 1 it gives
   8, and `cycle_of(10) − 10 = 18 − 10 = 8`. Agrees.
2. **The two named pairs are the only two**, and the worker's derivation of them
   is right: the terminate word carries no frame octet iff the terminate
   character is in lane 0, which at a lane-0 start means `r` = 0 (length 64) and
   at a lane-4 start means `r` = 4 (length 68).
3. **But the substitution is required at ten pairs, not two.** §8's literal
   instruction — read the shift off the raw octet times at the `tlast` word's own
   anchor octet — is wrong wherever the terminate word is **later** than the word
   carrying the last delivered octet, because there the `tlast` word moves with
   the terminate word while its octets moved with an earlier one. That is
   `r ∈ {0,1,2,3,4}` at lane 0 and `r ∈ {0,4,5,6,7}` at lane 4 — **five of eight
   lengths at each lane, ten of sixteen pairs**. At length 64 / lane 0 / k = 1 the
   literal form predicts a shift of 7 against a conformant 8 and would have gone
   red against a conformant design. **The worker under-claimed its own
   correction, and my §8 was wrong in exactly the way FINDING 5(a) says the
   specification was.** The closed form is right at all sixteen. It stands.

**Call 2 — the HOLD extended to `run_i4`'s cross-run `cross_latency`
`is_constant`. RULED CORRECT, and the omission is mine.** §12 item 3 cited line
numbers (`:997–1010`) where it should have cited the **claim**; the cross-run
tagger asserts the identical per-octet-constant claim over all 48 runs and is
unsatisfiable for the identical reason. Holding it is inside item 3's stated
ground and squarely inside "narrower than make-it-green" — it removes an
assertion that cannot be satisfied, not one that fails. The worker kept
`front_offset` and `frames` asserted and kept `Latency.errors` asserted on both
taggers; both are correct, because `octet_time.ml`'s `derived_errors` matches
only a singleton `latencies` list and a multi-L class therefore contributes no
error. **Neither call needs a further round.**

**Conduct.** Two rounds, two red returns, and neither is against the worker. This
round's file does what the verdict asked, guards what it was told to guard,
diverges twice with the reason written down, and the divergence turned out to be
a repair of my own instruction. It then went red on a real defect the programme
had never had a stimulus for. That is a bench working.

### 7. Row dispositions at `4901161`

| Row | Disposition |
|---|---|
| M03-I1, M03-I2, M03-I3 | **DISCHARGED**, unchanged from round 1, green at this SHA |
| M03-I5 | **DECLARED**, accepted round 1; its `Observable` cell is repaired this round under the ruling (`J-dv_lead-0085`) and the declaration in the file already flags the dispute |
| M03-I4 | **BUILT AND CORRECT; NOT DISCHARGED.** Red against `BUG-0002`. Its cycle rule is confirmed at word 0 at two figures; its remaining assertions are unexecuted |
| M03-I6 | **BUILT AND CORRECT; NOT DISCHARGED.** Red against `BUG-0002`, same word, independent figure |
| `idle_injection.mli` docstring (FINDING 4) | **REPAIRED**, comment-only, `.ml` byte-unchanged (`81e1d33`) |

### 8. The discharge count at `4901161`, by the method of `RV-0059-VERDICT` §9

Counted from the file, not carried forward. `AP-xgmii_rx_64.md`: **78 rows, 62
ASSERT**, 7 NO-ASSERT, 4 NO-STIMULUS, 4 STRUCTURAL, 1 GAP (sum 78). Rows named
in a committed `%expect_test` title under `test/xgmii_rx_64/`: **38**, of which
**37 are ASSERT** (M03-A4 is the one NO-ASSERT row named in a title). Plus
**M03-F5**, discharged by citation at `test_m03_f.ml:833` = **38 carrying a
discharge**. Minus **M03-I4** and **M03-I6**, red at this SHA and therefore
discharging nothing:

**36 of 62 at `4901161`** — unchanged from `6001630`, and the reason it did not
move is the point of this round. Forward it is **38**, and the block is now
`BUG-0002`'s fix rather than a bench repair: **no further bench work is required
to reach it.**

### 9. Verdict and state

**State: ACCEPTED** — the worker's round-2 obligations are discharged in full;
five items asked, five met, two divergences ruled correct, one of them a repair
of the packet's own text.

**The rows are HELD, not discharged**, and `WO-0059` does not close: family I is
complete as a bench and incomplete as evidence until `BUG-0002`'s fix verdict
lands. **There is no round 3 for tb_writer** — there is nothing for a bench
writer to do, and issuing one would be asking a worker to make a design defect
disappear.

Not a BOUNCE, deliberately. Round 1 bounced a file for a defect that was the
file's; calling this round a bounce would be the same error inverted — blaming
the file for the design — and this packet has already convicted itself once for
mistaking whose defect a red was.

**`SO-xgmii_rx_64.md` does not issue and is not owed.** Family I's qualification
campaign does not open: its scored set is the five ASSERT rows of this packet and
two of them are red. The M03 mutation campaign and the differential co-sim
obligations are untouched by this round.

### 10. Still owed, updated

- **`BUG-0002`'s fix verdict**, and with it M03-I4's and M03-I6's discharge and
  the count's move to 38.
- **`RV-0057-VERDICT` Finding 3**'s total-output-word sweep: precondition
  satisfied (M03-I2 exists and is green), still deferred, first `test/**` touch
  after family I is evidence-complete.
- **AP-M14's §6 sweep companion**; the `precompile_check.sh`
  side-effect-in-combinator lane; **M03-F5's discharge-by-citation
  qualification**, still load-bearing as the row that closes the
  uncertainty-of-one in the denominator; the RFC 1071 anchor on the next
  fetching run; bound 6 (blocked on M03-B4, family B still unqueued); bound 7;
  X-7, X-10, X-11 deferred.
- **The adjudicator RTL-exposure control**, raised at `J-dv_lead-0080` and still
  undecided. It did not bind this round either — no design source was opened —
  and that is now two adjudications of design behaviour decided without it,
  which is a datum for the decision and not a substitute for it.

---

## COUNTERSIGNATURE — requirements.md §0.5 and REQ-016, ruled at `a77017c` (`J-architect_docs_lead-0024`): **GRANTED** — dv_lead, `J-dv_lead-0084`

**I sign the §0.5 + REQ-016 diff at `a77017c` (SCR-M03-I4's ruling) as
testable and correct.** The diff is not in force until the orchestrator
transcribes this signature into requirements.md §13, per the C-43 discipline the
diff's own §13 row states; the signature of record is this block plus
`J-dv_lead-0084`, which carries it in the same commit as this packet.

**Scope signed**: §0.5's Latency sentence and its new **gapless** qualifier; the
**Gapped stimulus (normative)** replacement; **The deciding input word
(normative)**; **What survives idle injection (normative)**; **What a latency
monitor may demand on a gapped stimulus (normative)**; the §0.6 relation
paragraph and the provenance paragraph; and **REQ-016's repaired verification
column**. REQ-016's own normative sentence, REQ-005, REQ-011 and REQ-111 are
untouched by the diff and are not in the scope of this signature.

**Signed on checks, not on assertion.** Seven, each reproducible by hand from
the specification.

**C-1 — the residue table, re-derived independently at both start lanes, and it
is exact.** Write the start character at octet time `T`, frame octet *j* at
`T + 8 + j` (§6.1's preamble paragraph), `N` = octets between the start and
terminate characters, `N = 8q + r`, and the last delivered octet at index
`N − 5` (REQ-103 strips four).
*Lane 0* (`T ≡ 0 mod 8`, `T = 8s`): the terminate character is at `T + 8 + N`,
cycle `s + 1 + q`; the last delivered octet is at cycle `s + 1 + ⌊(N − 5)/8⌋`,
which is `s + q` for `r ≤ 4` and `s + 1 + q` for `r ≥ 5`. **Later iff
`r ∈ {0,1,2,3,4}`.**
*Lane 4* (`T = 8s + 4`): the terminate character is at `8(s + q + 1) + (4 + r)`,
cycle `s + q + 1` for `r ≤ 3` and `s + q + 2` for `r ≥ 4`; the last delivered
octet is at `8(s + q) + (7 + r)`, cycle `s + q` for `r = 0` and `s + q + 1` for
`r ≥ 1`. **Later iff `r ∈ {0,4,5,6,7}`.**
Both sets are exactly what §6.1's derivation 1 states.

**C-2 — the survival case is genuinely octet-for-octet, not merely
"the terminate shares the word".** At a lane-0 start with `r ∈ {5,6,7}` the
frame delivers `N − 4 = 8q + r − 4` octets, so the `tlast` word carries indices
`8q … N − 5` — **one, two and three** octets respectively — and every one of
them lies at octet times `T + 8 + 8q …`, i.e. in the **same** word as the
terminate character. So no octet of that word straddles and none is
late-decided, `h = 8 ≡ 0 (mod 8)` straddles nothing, and `L = 16` holds octet for
octet. §6.1 item 3 is sound, and its refusal to let a bench generalise from it is
the right instruction: it is three lengths in eight at one of the two lanes.

**C-3 — the straddle test against §1.1's own h column.** `h mod 8 ≠ 0` at M03
lane-4 (12), M06 (14) and M14 (20); `= 0` at M03 lane-0 (8), M08 (0) and M17 (8).
§1.1's normative table gives exactly those six values. The ruling's Phase-1
verdicts are arithmetic on the specification, as it claims, and the three owed
restatements (SPEC-M06, SPEC-M10, SPEC-M14) are the right three.

**C-4 — the worked example reproduces.** 64-octet lane-0 frame, `k = 1`:
delivered octets 56–59 are in source cycle 9, injected cycle 16, input octet
times 128–131; the terminate word is source cycle 10, injected 18; the `tlast`
word is one cycle after it, injected **19**, output octet times 152–155;
`L = 24` for those four octets against `L = 16` for every earlier one. Agrees
with §6.1's derivation 1 to the octet time.

**C-5 — the instrument implements the monitor clause, and I checked the
instrument rather than the claim.** §0.5's new clause forbids demanding a single
per-octet L on an injected run at a module failing either test.
`Dv_monitors.Octet_time.Latency.is_constant`'s contract is *"every front-offset
class has a single L"* — precisely the forbidden predicate — and at `4901161`
the committed bench holds it at both sites that carried it
(`test_m03_i.ml:1146–1187` per run, `:1254–1283` across runs) while keeping
`Latency.errors` asserted, which is sound because `octet_time.ml`'s
`derived_errors` matches only a singleton `latencies` list. The front-offset
check stays a real assertion, correctly: `h` is §0.5's **correspondence** term,
not the per-octet constant.

**C-6 — REQ-016's repaired column is what the committed bench asserts.** Clause
(a), the ordered tuple sequence with each octet in its own byte position, is
`test_m03_i.ml:1037–1061` and `:1450–1470`; clause (b), each output word delayed
by exactly the idles injected at or before its deciding input word, is
`:1093–1115` with `dependency_source_cycle` / `injected_word_cycle` at
`:922–930`. The column commissions an achievable observable and the achievable
observable is built.

**C-7 — confinement, checked across the tree rather than taken from the claim.**
`a77017c` moves **three** files: `docs/specs/requirements.md`,
`docs/specs/modules/xgmii_rx_64.md` and the architect's own journal volume.
`requirements.md` moves in exactly the sections named (§0.5's Latency paragraph,
the Gapped-stimulus replacement, REQ-016's verification column, one appended §13
row) — REQ-013, REQ-014, REQ-015, REQ-017 and REQ-018 appear only as diff
context. `xgmii_rx_64.md` moves at the four sites its §13 row names plus one
appended §13 row. Nothing under `test/**`, `libs/**`, `scripts/**`,
`docs/gates/**` or `docs/reports/**`.

**And the check that matters most, because it is the one a signature usually
cannot make.** The ruling's central factual claim about the failing member —
*"the design's own answer — word 0 on cycle 4 at the failing member — is the one
this text now describes"* — has now been **measured**, not derived: CI run
`30881653846` at `4901161` shows the design producing word 0 on cycle **4** and
the rebuilt guard predicting **4**, at both `k = 1` and `k = 7`. §6.1's D(m) rule
is the first clause of this ruling to have been confronted with hardware, and it
survived. **`BUG-0002` is not a finding against this ruling** — it is the design
failing the very clause the ruling states (§0.5: *"the ordered sequence of
tuples is unchanged"*), which is the ruling being useful rather than wrong.

### N-1 — one note returned with the signature, and it withholds nothing

REQ-016's repaired column gates the extra per-octet assertion on a **module**-level
property: *"Where §0.5's two tests both pass **at a module**, its own §7 says so
and the wrapper asserts the per-octet constant as well."* But §0.5's
late-decision test and SPEC-M03 §6.1 item 3 make survival a property of the
**(start lane, residue)** pair, not of the module: at M03 lane 0 the constant
survives at `r ∈ {5,6,7}` and fails at `r ∈ {0,1,2,3,4}`, in the same module, on
the same port, at lengths differing by one octet.

At M03 the gate licenses nothing, because §7 does not make the claim — so this
**cannot fail a conformant design, blocks nothing, and is not a ground for
withholding**. The exposure is a later bench reading a per-module "both tests
pass" as licensing a per-octet assertion at **every** length its module accepts.
Offered, not demanded: a clause noting that the gate is per-module *by
construction* — a §7 that makes the claim must make it for every length and lane
its module accepts, and a module whose survival is residue-conditional does not
qualify. It rides with whichever work order next opens REQ-016, alongside the
three restatements the §13 row already names.

**Nothing else is contested.** The two withdrawn justifications (§6.1's
consequence-1 *"because §7's per-octet constant does"* and the C-14.4
paragraph's *"the per-octet constant of §7 holds on every stimulus"*) were both
false and both are correctly withdrawn without disturbing the rules they were
attached to; the same withdrawal is owed in **my own** attack plan at M03-N2 and
at §4.N's Route 2 — a family §4.I's owed edit never looked at — and it lands in
the **next** commit of this same round (`J-dv_lead-0085`,
`test/attack_plans/AP-xgmii_rx_64.md`, a disjoint file set) rather than being
left for someone else to find.
