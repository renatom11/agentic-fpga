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
