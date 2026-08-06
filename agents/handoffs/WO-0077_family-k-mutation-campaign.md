# WO-0077: the family-K mutation campaign — six `clear` classes against the one port two units in the bench drive, carrying a declared, separately-sealed N-COMPLETION section, and the last campaign of this era

- **State**: **DRAFT** — dv_lead's draft. The orchestrator issues it, operates it
  (PROTOCOL §10's transient model) and allocates its id (PROTOCOL §3); `0077` is
  the id the spawn allocated and is used throughout.
- **From** / **To**: dv_lead → **auditor** (manifest author), via the
  orchestrator (campaign operator, and — per `FINDING WO-0074-A1`, ruled
  ACCEPTED and carried unchanged at `WO-0076` §7.1 — the **sole** cutter of the
  transient branches; §9.1).
- **Spec basis**: `docs/specs/requirements.md` **REQ-009** in full (the
  synchronous-`clear` sentence, the two-conjunct silence clause — *"On every
  cycle in which `clear` = 1 **and on the first cycle in which it is 0**, every
  `tvalid` output SHALL be 0, every header-record `valid` SHALL be 0 and every
  strobe SHALL be 0"* — the mid-frame truncation sentence *"no `tlast` and no
  strobe is emitted for it"*, and the last sentence *"A frame whose first word is
  presented on the first cycle after `clear` returns to 0 SHALL be received
  correctly"*), **REQ-015**, **REQ-008**, **REQ-011**, **REQ-005**, **REQ-103**,
  **REQ-104**, **REQ-106**, **REQ-107**, **REQ-110**, **REQ-113**, **§0.6**,
  **§0.7**, **§12**. `docs/specs/modules/xgmii_rx_64.md` **§7**'s **Reset**
  bullet in full; **§6.2**'s state table — the `Idle` row's *"reset; `clear`"*
  entry condition and its *"ignores every lane"* action, and the `Frame` row's
  exits; **§9**'s *"The one real exception in this specification is `clear`
  asserted mid-frame, which REQ-009 governs (§7)"* and its **"When a frame is
  open, and what closes it"** paragraph, whose closing list names `clear`
  (REQ-009) as one of five closers; **§9**'s third row and carry-forward
  **C-12**; **§4.1**/**§4.2**'s `clear` port row (`| clear | in | 1 | synchronous
  clear | REQ-009 |`). **For the N-completion section additionally**: **REQ-810**
  in full, **REQ-803**, **REQ-802**, **REQ-105**, **§4.3** in its entirety,
  **§6.1**'s *"When `cfg_rx_enable` is 0"* paragraph, **§6.3 item 7**
  (**C-14.5**), **§10**'s REQ-110 and REQ-802/REQ-810 hooks, and **ADR-0014** in
  full.
- **Plan basis**: `test/attack_plans/AP-xgmii_rx_64.md` **§4.K** rows `M03-K1`
  … `M03-K3` with their cells **as they read today** — in particular `M03-K1`'s
  **withdrawn** second class and the **honest kill** that replaced it
  (2026-08-09, `WO-0072` §7.5, `J-dv_lead-0130`, landed `J-dv_lead-0132`), which
  this packet seals against and never against the struck text, and `M03-K2`'s
  **reclassified third kill**; **§4.K**'s landed-status block; **§4.N**'s
  `M03-N1` and `M03-N4` with `FINDING AP-3`'s correction as it now reads there;
  **§2** items 1–4 (the standing monitors and the C-23 counting convention);
  **§7**'s X-rows, U-1 … U-4 and its banner **bars 1–4**.
- **Disposition basis, and it is this packet's own predecessor**:
  `agents/handoffs/WO-0072_m03-family-k-clear.md` **§9**'s pre-committed
  disposition table — **D1** (a `tlast` = 1 delivered word inside cycles 6 … 11,
  or any `tlast` attributable to frame A), **D2** (frame B absent, short, or
  delivered on cycles other than 14 … 21) and **D3** (`tvalid` = 1 or any strobe
  high on a cycle in 6 … 11, with no `tlast`) — **written before a single cycle
  was driven and never yet exercised against a design that actually holds the
  defect**. Three of this round's six K classes exist to exercise exactly those
  three rows, and **§5 item 1 is what that exercise found before it ran**.
- **Bench basis**, named because a campaign scores *files*:
  `test/xgmii_rx_64/test_m03_k.ml` (two units, `run_k1` and `run_k2`),
  `test_m03_n.ml`'s `run_n1` (two members) and `run_n4` (two members),
  `test_m03_structural.ml`'s `Bench.Clear` witness, and `bench.ml`/`bench.mli`'s
  `Clear` module, its **K pre-scan guard**, `create`'s **reset pulse** and
  `run`'s `?clear` plumbing — all at the base SHA.
- **Binding**: the auditor's **R-DISC-1** and **R-DISC-2** (`DISP-0001` §4,
  `fab31de`) bind these manifests and are adjudication criteria for them.
- **Five methods carried in as bars on the seal**, each named with what it
  changed:
  1. **`FINDING WO-0074-S4`** — derive the collision inventory from the **cross
     product** of every class's predicted red set with every scored cell, never
     from the scored cells alone. **It is applied and §12 says what it found**,
     including the one thing this packet's whole two-section structure rests on
     (§8).
  2. **`FINDING WO-0074-S1`** — every rule states its **complete conjunct list**,
     including every gate the rendering may *not* remove. **§6 says where it
     changed what I sealed**, and the conjunct it added is not a small one.
  3. **`FINDING WO-0076-S1`** — a seal's instrument arms are **enumerated from
     the file at the base SHA, in source order, never from memory**. Discharged
     at §4.4 in the open, with line numbers.
  4. **`FINDING WO-0076-S2`** — every matrix count is **re-derived from the
     matrix** and its arithmetic shown beside it, so a prose count and a matrix
     can never disagree inside one document.
  5. **`FINDING RV-0075-3`** — **no case that is the sole exerciser of a branch
     may be marked optional.** §14 names this round's two sole exercisers and
     both are MANDATORY; the cost trade is stated in figures rather than as a
     hedge.
- **The seal**: `WO-0077_family-k-mutation-campaign-SEALED-predictions.md`,
  frozen in **this packet's own commit**, before any diff exists, and carrying
  **two separately-sealed sections** (§K and §N) whose separation is §13's.
  **If this commit does not stage that file, this round has no seal**, its
  cell-level claims may not be made, and the absence is a finding against me —
  PROTOCOL §10's **R-SEAL-1**.
- **Precedent carried in terms**: `WO-0063B`'s pre-run reading note. **If the
  manifest raises a question for me, it comes to me BEFORE the run**, as a
  committed reading note, not as a post-hoc reading of a scorecard. It has paid
  for itself at `WO-0074` (two rulings correcting my own seal) and at `WO-0076`
  (four rulings, one of which would have made the era's oldest unscored row
  unscoreable by its own permission list).
- **Two-family precedent**: **`WO-0058`**, the combined `M03-G7` + family-H
  campaign — seven classes, five scored units, two families, one seal, one base
  SHA. This packet follows it and adds what `WO-0058` did not have: a
  **cross-product-derived, pre-run enumeration of every cell where one section's
  class could reach the other section's rows** (§8), which is the machinery the
  adopted ruling rests on rather than an assurance.

---

## Section map

| § | what it fixes |
|---|---|
| 0 | what this campaign is, the two sections it carries, and the six things it cannot do |
| 1 | the six family-K intent classes and their mandatory disclosures |
| 2 | the **N-COMPLETION section** — three classes, and the falsifiable half **answered with its derivation** |
| 3 | the denominator, the **clear census** and the **enable census**, re-measured at this tree |
| 4 | the convicting instruments: the three kinds, **clear-low invariance AND the reset-pulse conjunct**, the assertion orders, and the monitor arms enumerated from the file |
| 5 | **what this campaign structurally cannot score, declared before it runs** — including `FINDING K-1`, a MAJOR finding against my own pre-committed disposition table |
| 6 | reachability, discharged term by term — both sides |
| 7 | §4(c) as a test — the per-class permission lists |
| 8 | **the K × N cross product, enumerated before it runs** |
| 9 | the allowlist, the manifest-only rule, and the abort-first direction check |
| 10 | the base SHA and the adjudicator-ordering rule |
| 11 | mutant-owned quantities, and how they are sealed |
| 12 | collisions: derived by the cross product, and what they cost the manifest |
| 13 | the qualification rule, and how the two sections are kept apart |
| 14 | cost, priced before seeding — and the two sole exercisers |
| 15 | what this round does NOT close, and the owed list with carriers |
| 16 | weighting, discounted in advance |
| 17 | what comes back |
| 18 | not to be told |

---

## 0. What this campaign is, the two sections it carries, and the six things it cannot do

This is the **tenth campaign** of the class-based era and the **last of it**.
It is also the last thing standing between this module and its `SO-` other than
the charter §3 anchor, and it carries two jobs that were argued as two rounds and
ruled as one.

**Job one — family K.** Two rows landed at `284225d`: `M03-K1` and `M03-K2`,
the first and only units in this suite ever to drive `clear`. Neither has been
scored. `WO-0072` §9 pre-committed a disposition table for a K2 red — **D1**,
**D2**, **D3** and six bench-side classes — *"in a committed artefact, before a
single cycle was driven"*. That table has never met a design that holds the
defect. This campaign is that meeting.

**Job two — the N-completion section.** `M03-N1` and `M03-N4` are **landed,
green, `ASSERT`, and mutation-scored by nothing**. `FINDING AP-3` measured that
across the whole era at `J-dv_lead-0143`: `M03-N4` has taken **five reds in two
campaigns** and been qualified by none of them, every one through an admission
path seeded against a family-J row and scored at a family-J cell; `M03-N1` has
taken nothing at all. Two landed green rows whose instruments no campaign has
ever shown to convict is exactly the unearned reassurance `RV-0075` spent its
round correcting out of two documents, and it sits directly in the path of the
`SO-`.

**Why one campaign and not two, and the price stated before the round rather
than discovered inside it.** Both families' benches are landed, so a second
campaign buys only a second seal, a second pre-run round and a second `test/**`
freeze window — and two freeze windows before the `SO-` is `WO-0076` §8's own
silent hazard doubled. The machinery for keeping two families apart inside one
campaign exists, is vindicated on evidence (§13's qualification rule;
`FINDING WO-0074-S4`'s cross product, which found both of `WO-0076`'s collisions
in another class's blast radius), and `WO-0058` is the two-family precedent.
**The price I named when I recommended it**: at family J, four of five classes
reddened `M03-N4` through the admission path, so a K class touching admission
would do the same, and the seal would have to pre-declare every such red as blast
radius. **§8 discharges that price by measurement rather than by promise, and the
measurement is better than the promise was** — see §8.

**Six things this round cannot do, stated first so no verdict drifts into
them.**

1. **It cannot score `M03-K3`.** That row is `NO-ASSERT` and no unit title in
   `test_m03_k.ml` names it; the protocol monitor's frame-in-progress reset is
   machinery family K's round *wires* and never a design assertion it makes.
   Nothing here discharges it (§5 item 2).
2. **It cannot score the `clear` pre-scan guard, and no campaign ever can.** The
   guard walks the driven cycles and reads the **driven word** before a cycle is
   driven; the structural witness compares `Clear.high_cycles` against literals
   and drives no design. **No RTL mutation can make either fire or not fire**
   (§5 item 3).
3. **It cannot pay the charter §3 differential co-simulation anchor**, and the
   ground is `WO-0075`'s **bar 4** at its **third** instance and its purest yet:
   the lane drives `clear` **exactly once, at the reset cycle, with nothing in
   flight** (`test/cosim/ours_run.ml:159`/`:162`; the reference holds `rst` for
   the first cycle and releases it at `test/cosim/tb_xgmii_rx_64.v:257`), and
   holds `cfg_rx_enable` at 1 for the whole run
   (`test/cosim/ours_run.ml:160`; `tb_xgmii_rx_64.v:63`). **Not one of this
   round's nine classes is rendered at that stimulus** (§5 item 4).
4. **It cannot measure the lane-4 members of the N section.** `M03-N1` and
   `M03-N4` each iterate lane 0 then lane 4 inside one unit; lane 0 raises
   first, so every lane-4 member is **structurally unobservable in a
   passing-to-failing run** and is recorded **unobserved — never as a miss and
   never as a pass** (§5 item 8). The K units have **one member each** and this
   limit does not reach them.
5. **It cannot separate three of `WO-0072` §9's own disposition classes from
   what a scorecard prints.** That is `FINDING K-1` and it is §5 item 1. It is
   the largest thing this round found and it was found **before the run**, by
   working the row's own instrument while authoring the packet that commissions
   the attack.
6. **It cannot, by itself, open an `SO-`.** A clean sweep here leaves the
   charter §3 anchor undischarged, `M03-K3` unscored and the lessons harvest
   still owed. What it does remove is the last **campaign** debt.

---

## 1. The six family-K intent classes

Each is **one kill**, never one kill per reddened unit. Each is derived from a
sentence of REQ-009, SPEC-M03 §7 or §9, or from `AP` §4.K's own cells, and each
is named with the row whose cell or disposition it instantiates — **and where the
plan's cell does not reach the class, §5 says so rather than letting the naming
imply it did.**

**One property is shared by all six and is stated once here, because every later
section depends on it**: every K class is keyed on **`clear` being high while
something is pending** — a frame in flight, a strobe owed, a start character on
the release cycle, or a word in the emission path. `clear` held at 0 is untouched
by all six, and so is the one-cycle reset pulse every unit drives before its
schedule (§4.2). **That pair of conjuncts is the whole of the MUST-STAY-GREEN
guarantee outside the two K units**, and it is demanded of every class as
`D-K*b`.

### IC-K1 — `clear` closes the in-flight frame instead of abandoning it (the phantom frame; `WO-0072` §9's **D1**)

**Ground**: REQ-009 — *"`clear` asserted mid-frame truncates the in-flight output
frame without a terminating word; **no `tlast` and no strobe is emitted for it**"*
— SPEC-M03 §7's Reset bullet in the same words, and `AP` §4.K's `M03-K2` **kill
1**, which the plan calls *"this row's principal attack"* and names *"reachable at
THREE distinct sites"*.

Render a design that reads `clear` as *"close the current frame"* rather than
*"abandon it"*: a `tlast` attributable to the abandoned frame appears.

**Required consequence**: at `M03-K2` a delivered word carrying `tlast` and
attributable to frame A appears where REQ-009 licenses none. Everything else is
unchanged: frame B is admitted on the release cycle and delivered completely, and
no strobe pulses anywhere.

**Permitted movement (§7)**: the delivered stream of a frame in flight across a
`clear` window. **Not permitted**: any strobe; frame B's delivery; anything with
`clear` held at 0; the reset pulse's own response.

#### 1.1 MANDATORY DISCLOSURE **D-K1a** — which of the three sites

`AP` §4.K's `M03-K2` cell names three: **(i)** the window's **opening** edge (a
design reading `clear` as *"close the current frame"*), **(ii)** the **release**
edge (a design that holds the abandoned frame's closure and emits it when `clear`
lifts), **(iii)** frame A's own **terminate character inside the window** (a
design that latches the `/T/` while cleared and closes on release). **All three
are the class.** State which you rendered and **the cycle your `tlast` lands
on**. The seal branches on this disclosure alone; §12 says why that matters more
here than it has in any previous round.

#### 1.2 MANDATORY DISCLOSURE **D-K1b** — clear-low and reset-pulse invariance

State positively that (a) with `clear` held at **0** for every cycle your
rendering is byte-identical to the base at every stimulus, and (b) a **one-cycle
`clear` pulse with no frame in flight, no strobe owed and an idle input word** —
which is what `Bench.create` drives before every one of the fifty-nine M03
schedules (§4.2) — produces the same response as the base. **This pair is the
single conjunct that protects fifty-seven of the fifty-nine M03 units and all
seventy-nine non-M03 behavioural units**, and it is demanded of **every** class in
this section, not only of this one.

### IC-K2 — the abandoned frame is reported (REQ-009's no-strobe clause; §9's *"one real exception"*)

**Ground**: REQ-009's *"no `tlast` and **no strobe** is emitted for it"*;
SPEC-M03 §7's *"the one place in this specification where a frame vanishes
without a strobe, and **REQ-009, not REQ-008, is what permits it**"*; §9's
*"Silent discard is prohibited (REQ-008) … The one real exception in this
specification is `clear` asserted mid-frame"*; `AP` §4.K's `M03-K2` Observable,
*"The in-flight frame vanishes with **no `tlast` and no strobe**"*.

Render a design that **pulses a strobe for the frame `clear` abandoned** — the
design a reader of REQ-008 writes when they mistake an abandonment for a discard
that owes a report. The truncation itself is retained: no `tlast`, no word inside
the window; only the report is added.

**This class is `IC-J2` one family over, and the symmetry is deliberate.** At
family J the added report was for a frame the enable **refused**; here it is for
a frame `clear` **abandoned**. Both are REQ-008 misread against a requirement
that disclaims the hole in terms, and the family-J instance killed.

**Permitted movement**: the strobe set inside a `clear` window and on the release
cycle. **Not permitted**: any delivered word anywhere; any strobe of a frame
`clear` did not abandon; anything with `clear` at 0; the reset pulse's response.

#### 1.3 MANDATORY DISCLOSURE **D-K2a** — which strobe, and on which cycle

M03 has five error outputs (`error_bad_fcs`, `error_bad_frame`, `error_runt`,
`error_oversize`, `error_start_without_terminate`) and REQ-009 forbids **all** of
them for the abandoned frame, so the class is the same whichever you pick. **Name
the one you used and the cycle your rendering pulses on** — the window's opening
edge, the abandoned frame's would-be report cycle, or the release cycle.

#### 1.4 MANDATORY DISCLOSURE **D-K2b** — one pulse, or a level

State whether your rendering pulses **once** or holds a level across the window.
**C-23's counting convention** (`error_pulses` reports presence per name per
cycle) makes them different integers at one cell and identical at another, and
§11 seals the affected quantity as an inequality for exactly this reason.

### IC-K3 — the release cycle is not available (`WO-0072` §9's **D2**; `M03-K2`'s **kill 2**)

**Ground**: REQ-009's last sentence — *"A frame whose first word is presented on
the first cycle after `clear` returns to 0 SHALL be received correctly"* —
SPEC-M03 §7's identical sentence, and `AP` §4.K's `M03-K2` **kill 2**, which the
plan calls *"the tightest legal placement"* because *"REQ-009's last sentence
names the release cycle specifically and the new frame's start character is on
it"*.

Render a design that **needs one idle cycle after `clear` before it can accept a
start character**: a start character arriving on the release cycle is not
admitted.

**Required consequence**: at `M03-K2` frame B is not received on its own cycles.
Everything about the window itself is unchanged — frame A still vanishes with no
`tlast` and no strobe, and its two escaped words are where they were, which is
what makes this class `M03-K2`'s **kill 2** and not its kill 1.

#### 1.5 MANDATORY DISCLOSURE **D-K3a** — refused, or late

Is frame B **refused entirely** (no output word for it anywhere in the run) or
**admitted late** (delivered, but not on its own cycles)? **Both are the class** —
`WO-0072` §9's D2 tell is *"frame B absent, short, or delivered on cycles other
than 14 … 21"* — and they are different observations. Answer before the run.

#### 1.6 MANDATORY DISCLOSURE **D-K3b** — the settling depth, and what else it delays

State the depth in cycles, and state whether your rendering also delays anything
other than start-character acceptance — the output path, the report path, or the
state reset. A rendering that delays the whole clear release is **IC-K5**, not
this class, and delivering one under the other's name makes both unscoreable
(§12).

### IC-K4 — the strobe path survives `clear` (`M03-K1`'s **honest kill**)

**Ground**: REQ-009's *"On every cycle in which `clear` = 1 and on the first
cycle in which it is 0 … **every strobe SHALL be 0**"*, and `AP` §4.K's `M03-K1`
**honest kill** in its own words: *"a design whose strobe path survives `clear` —
either by presenting a pre-clear strobe inside the window, or by holding it
suppressed and re-presenting it on the release cycle"*.

Render a design in which a strobe raised **immediately before** a `clear` window
is carried **into** it — presented inside the window (member **α**) or held and
re-presented on the release cycle (member **β**).

**Required consequence**: at `M03-K1` a strobe is observable inside the window or
on the release cycle, where a conformant design shows exactly one strobe, at the
frame's own `tlast` cycle, immediately before the window opens. The delivered
stream does not move.

**This is the class most likely to come back `NOT SEEDED`, I say so before the
run, and the declaration would be a RESULT rather than a failure.** `M03-K1`'s
window is placed over an interval in which a conformant design has **nothing
pending and nothing arriving**: the frame closed on the cycle before the window
opened, every input word inside the window is idle, and there is no start
character anywhere after cycle 1 (§4.3, measured). **So the only class the row
can convict is one that carries a pre-clear observable forward**, and a carry
mechanism that also satisfies **D-K1b** must be *conditional on the neighbourhood
of a clear* rather than a plain re-timing — a plain registered strobe moves every
pinned strobe cycle in the suite and is a scope violation, not a class (§7
consequence). **If that rendering is not minimal, say so under `D-K4c` and
declare NOT SEEDED. The disposition is pre-committed at §13 and the consequence
is stated at §5 item 1: `M03-K1` would then be UNQUALIFIABLE BY MUTATION at this
stimulus, declared rather than discovered by a sixth unqualifying red.**

**Permitted movement**: the strobe set inside a `clear` window and on the release
cycle. **Not permitted**: any strobe cycle outside the neighbourhood of a clear;
the delivered stream anywhere; anything with `clear` at 0; the reset pulse's
response.

#### 1.7 MANDATORY DISCLOSURE **D-K4a** — α or β, and the cycle

State which member you rendered and **the cycle your rendering presents on**. The
seal's cell prints a count, not a cycle (§11), so the disclosure is the only
thing that can distinguish a rendering that fired where you meant it from one
that fired somewhere else.

#### 1.8 MANDATORY DISCLOSURE **D-K4b** — one presentation, or a level

As `D-K2b`: one added high cycle, or a level held across the window. The seal
seals the affected count as an inequality with a direction and names both
derivations.

#### 1.9 MANDATORY DISCLOSURE **D-K4c** — the carry mechanism, in your own words, or NOT SEEDED

Name the mechanism and state explicitly how it satisfies `D-K1b`'s two conjuncts.
**If you cannot render one that does, declare `NOT SEEDED` and quote the shared
term you could not separate.** That declaration is the measurement this class
exists to make if it cannot be seeded, and it is worth as much as its kill.

### IC-K5 — the `clear` window is honoured one cycle LATE (`WO-0072` §7.5's own *"invisible at M03-K1"* derivation, measured from a run)

**Ground**: REQ-009's two-conjunct clause — *"On every cycle in which `clear` = 1
**and on the first cycle in which it is 0**"* — a window shifted by one satisfies
neither conjunct; SPEC-M03 §7's Reset bullet; and `AP` §4.K's `M03-K1` cell,
which **derives, before a bench existed, that this design is invisible at
`M03-K1`**: *"a design whose `clear` takes effect one cycle **late** behaves
un-cleared on the first window cycle — where a conformant design also produces
nothing, because the frame drained before the window opened … Both are invisible
here"*, and locates the class at `M03-K2`, *"whose window opens over a frame with
six output words still to come and closes on a cycle carrying a start
character"*.

Render a design whose `clear` gate is honoured **one cycle late at both edges** —
the gate reads the previous cycle's `clear` where REQ-009's synchronous clear
requires the driven cycle's own.

**Required consequence**: at `M03-K2` the window's first cycle behaves un-cleared
and the release cycle behaves cleared, so a word escapes at the leading edge
**and** frame B's start character is not accepted; at `M03-K1` **nothing moves at
all**.

**This class is the round's own measurement of a derivation this programme argued
and never ran, and it is why it is worth its job even if every kill were
predictable.** `WO-0072` §7.5 withdrew a class from `M03-K1` on an argument from
the stimulus. **IC-K5 is that design.** The derivation predicts `M03-K2` red and
`M03-K1` **green**, and §13 fixes both outcomes before the run. A bench cannot
make that measurement about itself; a campaign can. This is the `IC-J3`/`M03-J2`
pattern one family over, at its second instance, and the first instance killed
and measured.

**Permitted movement**: the one-cycle boundary of a driven `clear` window, at
both edges. **Not permitted**: anything with `clear` at 0 for the whole run;
anything at a stimulus with no `clear` window other than the reset pulse; any
strobe not attributable to the shift.

#### 1.10 MANDATORY DISCLOSURE **D-K5a** — both edges, or one

Is the shift at **both** edges, or only at the leading edge, or only at the
trailing one? Each is a different set of observations and the seal branches on
the answer.

#### 1.11 MANDATORY DISCLOSURE **D-K5b** — the reset pulse under the shift

State what your rendering does to `Bench.create`'s **one-cycle reset pulse**,
which is driven before cycle 0 of every schedule and whose release cycle is
**cycle 0**. **This is the conjunct that decides whether your class is a class or
a scope violation**: the earliest start character anywhere in this bench is at
**cycle 1** (§4.3, measured at this tree), so a shift that pushes the reset's
effect onto cycle 0 is invisible and a shift that pushes it onto cycle 1 is not.
Answer explicitly and quote the cycles.

### IC-K6 — `clear` gates the state machine but not the output stream (`WO-0072` §9's **D3**)

**Ground**: REQ-009's first clause — *"On every cycle in which `clear` = 1 … every
`tvalid` output SHALL be 0"*; SPEC-M03 §7's Reset bullet; `WO-0072` §9's **D3**,
whose own text says it is *"Distinct from D1 because a leaked word is not a
phantom frame and the two have different root causes"*.

Render a design in which `clear` forces the state machine to `Idle` but does
**not** gate the output stream, so a word already formed for the in-flight frame
is presented during the window — `tvalid` = 1 with **no** `tlast`.

**Required consequence**: at `M03-K2` at least one output word appears on a cycle
inside the window, none of them carrying `tlast`, and no strobe pulses. Frame B
is admitted on the release cycle and delivered completely.

**Permitted movement**: `tvalid` and the delivered stream inside a `clear` window
and on the release cycle. **Not permitted**: any `tlast`; any strobe; frame B's
delivery; anything with `clear` at 0; the reset pulse's response.

#### 1.12 MANDATORY DISCLOSURE **D-K6a** — how many cycles leak, and whether the release cycle leaks

REQ-009's clause has **two** conjuncts — the window and the first cycle after it —
and a rendering may break one or both. State how many cycles of the window
present a word, and state separately whether the **release cycle** does.

---

## 2. The N-COMPLETION section — three classes, and the falsifiable half ANSWERED

**This section is declared here, sealed separately at the seal's §N, scored
separately at §13, and reported separately in the verdict.** It is not a second
campaign and it does not share a kill count with the K classes; it shares one
base SHA, one freeze window and one seal file.

### 2.1 The falsifiable half, answered before any `SO-` — and the derivation

My own terms, filed at `RV-0075` and carried into this spawn, were: *"if
N-classes asserting `M03-N1`'s and `M03-N4`'s OWN observables cannot be authored,
those rows are unqualifiable by mutation at this bench and that SHALL be declared
in the packet before any `SO-`."*

**They can be authored. Here they are, and here is the derivation that produced
them** — worked from the rows' Observables and the units' committed assertion
orders, and stated in the open because it is a fact about the bench and not about
the answer.

- **`M03-N1`'s Observable has two clauses**: *"The `/T/` closes the frame normally
  (REQ-106, FCS checked); the `/E/` finds **no open frame** and produces nothing
  and pulses nothing (§9's third row, C-12)."* The second clause is asserted by a
  **strobe-set assertion over the whole run**, and the row's own Kills cell names
  the design that breaks it in terms: *"A design evaluating every control lane of
  a word against the state the word *started* in."* **That design is renderable,
  it is minimal, and it reaches the row's own assertion.** It is **IC-N1**.
- **`M03-N4`'s Observable has four clauses**: the in-flight frame aborted at the
  octet before the refused `/S/` with `tuser`[0] = 1 on its `tlast`; **exactly one**
  `error_start_without_terminate`; **no** output word for the frame the `/S/`
  would have begun; and the next frame received normally after the enable returns
  to 1. Clauses 1 and 3 are asserted by the run's **delivered-sample cycle list**;
  clause 2 by an **exact strobe count**. The row's Kills cell names **reading
  (ii)** in two halves, and **each half is a class**: *"the open frame is carried
  across a character §6.1 routes to REQ-110 and its octet count absorbs a refused
  frame's octets"* (**IC-N4a**, at clauses 1 and 3) and *"a design that gates the
  datapath rather than admission, which suppresses the in-flight frame's own
  remaining words and **its report**"* (**IC-N4b**, at clause 2).
- **`FINDING J-2` named `M03-N4` as the carrier that convicts the suppressing
  design and recorded that no campaign had yet seeded one.** IC-N4b is that
  class. It is the debt `WO-0076-VERDICT` §10 left this row carrying, paid here.

**So the declaration required by my own terms is the affirmative one, and it is
made before the run rather than after a scorecard**: `M03-N1` and `M03-N4` are
**qualifiable by mutation at this bench**, by three classes asserting their own
observables at their own units. **What remains unqualifiable is declared at §5
items 5 and 6 and is smaller and older than the rows themselves**: `M03-N4`'s
**zero-delivered branch**, which has no legal stimulus at all (`J-dv_lead-0121`'s
derivation, landed in the row), and `M03-N3`, which is `NO-STIMULUS`.

**And the counterfactual is recorded, because a falsifiable claim that cannot say
what would have falsified it is not one.** Had `M03-N4`'s two assertable clauses
both been reachable only through the **admission** path — the way all five of the
row's historical reds were — no class asserting the row's own observable could
have been authored without also being a family-J class, and the row would have
been unqualifiable by mutation at this bench. It is not, and the reason is
specific: **clause 2 is a report-path observable and clause 1 is an abort-geometry
observable, and neither is the admission gate.** That is the derivation, and it is
the sentence a later reader should check rather than the conclusion.

### IC-N1 — every control lane of an input word is routed against the state the word STARTED in

**Ground**: SPEC-M03 §9's third row and carry-forward **C-12** — *"The last row
discards nothing — there is no frame for it to discard, which is precisely why it
pulses nothing"*; §9's *"Every condition in the table is evaluated **only while
the frame is open**"*; §6.2's `Idle` row (*"ignores every lane"*); REQ-105's
open-frame clause; and `AP` §4.N's `M03-N1` Kills cell verbatim.

Render a design that evaluates **every** control lane of an input word against
the state the word **started** in, rather than against the state as the earlier
lanes of that same word have left it.

**Required consequence**: at `M03-N1` the `/E/` five octet times after the
frame's own lane-0 `/T/`, in the **same input word**, is routed to REQ-105
against a `Frame` state the `/T/` has already left, and pulses a strobe the
row's own Observable forbids in terms. The frame's own delivery is untouched:
its eight words, its cycles, its final `tkeep` and its `tuser`[0] = 0 are all
exactly as they are at the base.

**Permitted movement**: the strobe set at an input word in which an **earlier**
lane effects a state change and a **later** lane carries a control character —
**and, under branch β only (`D-N1c`), the delivered stream of the frame that
earlier lane closed.** **Not permitted**: any delivered word at any other frame;
any strobe at a word carrying one control character or none; anything at a word
in which no lane effects a state change — **which is what protects every idle
word in the suite, all eight of whose lanes are control**.

**Declared before the run: this class has the largest blast radius of the nine,
and it runs in BOTH directions.** Its rule selects `M03-N1` (scored) and, by
measurement of their stimulus titles at this tree, `M03-N2`'s six sub-cases and
the family-B units whose stimulus places a control character in a **preamble
position of the same input word as the start character that opened that
preamble** — `M03-B2`, `M03-B2 /I/`, `M03-B2 /Q/`, `M03-B3` and `M03-B4`. **At
`M03-N1` the class ADDS a strobe** (the word starts in `Frame`, and the later
lane should have seen `Idle`); **at every selected family-B unit it REMOVES one**
(the word starts in `Idle`, and the later lane should have seen `Preamble`, whose
exits §6.2 enumerates). **Both directions are the same rule and every one of
those reds qualifies nothing** — they are other families' units and §13 governs.
A green at a unit the rule selects is a finding adjudicated per row.

#### 2.2 MANDATORY DISCLOSURE **D-N1a** — which strobe

REQ-105 is the route the cell names, but a rendering may reach REQ-107 or
REQ-110 instead depending on which lane's condition it evaluates. **Name the
strobe your rendering pulses and the cycle.**

#### 2.3 MANDATORY DISCLOSURE **D-N1b** — the direction of the state read

State whether your rendering (a) freezes the state for the **whole** word and
evaluates every lane against it, or (b) evaluates lanes in order but fails to
apply an **earlier lane's** exit before a **later lane's** condition. Both are
the class; they differ in their blast radius across other in-word geometries and
the seal records which.

#### 2.4 MANDATORY DISCLOSURE **D-N1c** — report only, or report and suppress

Does your rendering **also** suppress or alter an output word of the frame the
earlier lane closed? Branch **α** is report-only: the frame's delivered stream is
untouched and only the strobe set moves. Branch **β** additionally applies the
mis-routed character's own no-output-word consequence to the already-closing
frame. **Both are the class**, they raise at **different assertions** of the same
row, and the seal branches on this answer alone. Answer before the run.

### IC-N4a — the refused start character does not abort the in-flight frame

**Ground**: **ADR-0014** and SPEC-M03 §6.2's `Frame` row in its own words — *"on
`/S/` (REQ-110) **`Preamble` while `cfg_rx_enable` = 1 and `Idle` while it is
0** — the frame is aborted and reported under REQ-110 **in both cases**, and only
the beginning of the new frame is gated"*; §4.3; REQ-110; and `AP` §4.N's
`M03-N4` Kills **reading (ii)**, first half.

Render a design in which the **abort** effect of a start character is gated on
`cfg_rx_enable`, so a start character arriving mid-frame while the enable is 0 is
treated as fully absent and the open frame continues.

**Required consequence**: at `M03-N4` frame A is not aborted at the octet before
the refused start; it continues and delivers words on cycles the row's own list
does not contain. Frame C, admitted after the enable returns to 1, is unaffected.

**Permitted movement**: the delivered stream of a frame open across a refused
start character. **Not permitted**: any frame admitted while the enable is 1 and
untouched by a refused start; anything at `Enable.high`.

#### 2.5 MANDATORY DISCLOSURE **D-N4a-1** — what the refused start's own octet position forwards

State what your rendering forwards for the refused start character's own position
— the control character's data value, a hold, or nothing — and state the
consequence for the frame's octet count. The specification does not fix this,
because under it the character is never forwarded at all; the seal therefore seals
the affected quantity as an inequality with a direction (§11) and this disclosure
is what pins the rendering.

#### 2.6 MANDATORY DISCLOSURE **D-N4a-2** — the report

Does the frame that is no longer aborted still draw
`error_start_without_terminate`? Say so. A rendering that removes the abort **and**
the report reaches a second assertion and the seal records which cell speaks
first.

### IC-N4b — the report path is gated by the enable, so an in-flight frame's own abort report is suppressed

**Ground**: REQ-810's three prohibitions read **unscoped** — the reading
**ADR-0014** prices and rejects; SPEC-M03 §4.3's three-clause *"What the enable
gates"* statement; §6.2's `Frame` row (*"the frame is aborted and reported under
REQ-110 in **both** cases"*); §6.1's *"When `cfg_rx_enable` is 0"* paragraph; and
`AP` §4.N's `M03-N4` Kills **reading (ii)**, second half. **And `FINDING J-2`,
which named this row as the carrier that convicts a design that SUPPRESSES an
in-flight frame's own report, and recorded that no campaign had seeded one.**

Render a design in which **no strobe is emitted on any receive-path stream while
`cfg_rx_enable` = 0**, including a report owed by a frame admitted while the
enable was 1.

**Required consequence**: at `M03-N4` frame A's own
`error_start_without_terminate` — owed at a cycle at which the enable is 0 — does
not pulse. The delivered stream does not move at all: frame A's single aborted
word and frame C's eight are exactly where they are at the base, with the same
`tkeep`, the same `tlast` and the same `tuser`.

**This class is the only one in either section that reaches a strobe-set
assertion at a frame the enable did not refuse, and it measures `FINDING J-2`
from a run rather than from an argument.** `M03-J3`'s strobe clause is
unfalsifiable in the subtractive direction because its in-flight frame is clean
and owes none; `M03-N4`'s in-flight frame owes one. **The prediction is
`M03-N4` red and `M03-J3` green**, and §13 fixes both outcomes before the run.

**Permitted movement**: the strobe set on a cycle at which `cfg_rx_enable` = 0.
**Not permitted**: any delivered word anywhere; any strobe on a cycle at which the
enable is 1; anything at `Enable.high`.

#### 2.7 MANDATORY DISCLOSURE **D-N4b-1** — the gate's own term

Name the term you gated and confirm it is the **report** path alone. If the same
edit also reaches the emission path, say so and list every output it touches —
that rendering is family J's `IC-J3` and not this class, and §12 says what
delivering one under the other's name costs.

#### 2.8 MANDATORY DISCLOSURE **D-N4b-2** — sampled, or latched

Is the gate evaluated against the enable's value **on the report cycle**, or
against the value at the frame's admission? The first is this class; the second
suppresses nothing at this stimulus and would be `NOT SEEDED`. Answer before the
run.

---

## 3. The denominator, the clear census and the enable census — re-measured at this tree

Re-measured at the base tree, **not carried forward** from `WO-0076`:

```
    3  test_m03_a.ml    7  test_m03_b.ml    4  test_m03_c.ml    3  test_m03_d.ml
    4  test_m03_e.ml    4  test_m03_f.ml    7  test_m03_g.ml    4  test_m03_h.ml
    5  test_m03_i.ml    3  test_m03_j.ml    2  test_m03_k.ml    2  test_m03_l.ml
    8  test_m03_n.ml    3  test_m03_structural.ml
  ---
   59  test/xgmii_rx_64/ (the M03 bench)
  139  test/ (repository-wide, OCaml units, --include=*.ml)
```

**59 M03 units; 139 repository-wide; 80 non-M03**, split `monitors` 37 +
`xgmii` 25 + `golden` 11 + `axi64_probe` 3 + `xgmii_probe` 3 = **79
behavioural**, and `hardcaml_ethernet` **1 build-level**. `test/cosim/`
contributes **0 units**. Provenance for every figure above: `bash
tools/dv_checks.sh` at this tree, whose own output is the citation
(`FINDING M-4`'s repaired file-type matcher). The **old directory-scoped
matcher** reports **141** at this tree and is not used.

### 3.1 The clear census — the number that decides the K section

Measured, not recalled (`FINDING K-3`'s rule: a universal in a bar is measured at
its own tree before the bar is written, or it is not a bar):

```
grep -rn --include=*.ml '~clear\|Clear\.' test/   ->  three files only:
    test/xgmii_rx_64/bench.ml            the capability's own plumbing, the K
                                         guard, and create's reset pulse
    test/xgmii_rx_64/test_m03_k.ml:228   M03-K1's clear window   (one member)
    test/xgmii_rx_64/test_m03_k.ml:459   M03-K2's clear window   (one member)
    test/xgmii_rx_64/test_m03_structural.ml:114-128
                                         the Clear witness — drives no design
```

**Exactly two units in the whole repository drive `clear` high during a
schedule**: `M03-K1` and `M03-K2`. **Fifty-seven of the fifty-nine M03 units and
all seventy-nine non-M03 behavioural units drive `Clear.never`** — `run`'s own
default, which resolves to `Bits.gnd` on every cycle at the same choke point
`cfg_rx_enable` is driven from (`bench.ml:267`).

**Family K owns 2 of the 59. That is the narrowest instrument footprint of any
campaign in this era** — narrower than family J's four — and it is a property of
what family K *is*, not of what this packet chose.

### 3.2 The enable census — carried into the N section unchanged, and re-measured

```
grep -rn --include=*.ml '~enable' test/     ->  bench.ml:229, :429      plumbing
    test/xgmii_rx_64/test_m03_j.ml:223, :457   explicit ~enable:Enable.high
    test/xgmii_rx_64/test_m03_j.ml:169         M03-J1's disabled run
    test/xgmii_rx_64/test_m03_j.ml:279         M03-J2's disabled run
    test/xgmii_rx_64/test_m03_j.ml:488         M03-J3's disabled run (both members)
    test/xgmii_rx_64/test_m03_n.ml:1256        M03-N4's disabled run (both members)
```

**Exactly four units drive `cfg_rx_enable` away from `Enable.high`**: `M03-J1`,
`M03-J2`, `M03-J3` and `M03-N4`. Unchanged from `WO-0076` §2 and re-measured
here rather than quoted.

### 3.3 The intersection, and it is the fact this packet's structure rests on

```
  clear-driving units   { M03-K1, M03-K2 }
  enable-driving units  { M03-J1, M03-J2, M03-J3, M03-N4 }
  intersection          EMPTY
```

**No unit in this bench drives both ports.** §8 turns that measurement into the
cross-product enumeration my own terms demanded, and §13 turns it into the
separation rule.

---

## 4. The convicting instruments, measured from the landed files

**Method, so it is checkable**: every `fail`/`failwith` reachable from each of the
four scored units was enumerated in source order at the base SHA and classified
by the object it reads — DUT output, bench model, or monitor report. The result is
the seal's §2; the parts a manifest author needs are here.

### 4.1 The three instrument kinds, and only one of them can convict a design

| kind | what it reads | can a mutation move it? |
|---|---|---|
| **bench-side stimulus derivation** — `Arrival.check`, the frame counts, every derived start/terminate/window cycle, `Frame.residue_ok`, the no-start-character-in-the-window checks, `Injection.outcomes` and both landing checks, every `test bug --` message | the schedule and the driven word, before or independently of the DUT | **No.** A message from one of these means something other than a seeded class |
| **driven-port checks** — `sample.clear` and `sample.enable` against an independently written predicate | the value the bench drove, read back at the same choke point | **No.** Both are `run`'s own arguments resolved per cycle; the DUT does not produce them |
| **DUT-observable assertions** — every delivered word, every strobe, the monitors fed from delivered words, and both control runs | the design's outputs | **Yes. These, and only these, are this campaign's cells** |

### 4.2 The two structural facts this campaign rests on — and the second one is NEW

**(a) Clear-low invariance.** Fifty-seven of the fifty-nine M03 units and all
seventy-nine non-M03 behavioural units drive `clear` = 0 on every schedule cycle.
A rendering that leaves the `clear` = 0 behaviour byte-identical therefore cannot
redden any of them **through a schedule cycle**, by construction and not by care.

**(b) The reset pulse, and it is why (a) alone is not the guarantee.**
`Bench.create` drives `i.clear := Bits.vdd`, an idle XGMII word and
`cfg_rx_enable` = 1, steps the clock once, then releases (`bench.ml:64–68`).
**Every one of the fifty-nine M03 units therefore drives `clear` high exactly
once, before cycle 0 of its own schedule, with nothing in flight, no strobe owed
and an idle word.** The reset pulse's **release cycle is cycle 0**.

**This is where `FINDING WO-0074-S1`'s complete-conjunct bar changed what I
sealed, and the change is not cosmetic.** A rule whose only conjunct was *the unit
drives `clear` high during its schedule* selects two units and is **false as a
complete statement**: it omits the pulse every unit drives, so a class that
mishandles a clear with nothing pending would redden fifty-nine units against a
seal predicting two. **Every rule in this campaign's K section therefore carries
BOTH conjuncts**, and `D-K1b` demands both of every class. `D-K5b` demands the
sharper version of the second, because a one-cycle shift is the one class whose
rendering can reach the pulse.

**And the conjunct is measured rather than assumed**: the earliest start character
anywhere in this bench is at **cycle 1**. Every schedule is laid out by
`Bench.frames_at` (`first_start` = 8 at lane 0, 12 at lane 4) or by a direct
`Arrival.create` whose `first_start` is 8, 12, or `8 + 8k` (`test_m03_i.ml:285`) —
all ≥ 8 octet times, all cycle ≥ 1. **No unit presents a start character on cycle
0**, which is the reset pulse's release cycle, so `IC-K3`'s defect has no instance
there.

### 4.3 The assertion order inside each convicting unit — measured, not assumed

**`M03-K1`** (`run_k1`, one member, row prefix carries no lane suffix): stimulus
derivation and the derived window → the strobe-monitor registration →
**the delivered-word count** → per word: cycle → `tkeep` → `tlast`/`tuser` →
**the delivered octets** → **the strobe set (name, then cycle, then count)** →
the driven-`clear` check → **the silence scan over the window AND the release
cycle** (`tvalid` checked before the strobe list, per sample, samples in cycle
order) → the accounting calls → `cleared_mid_frame` → the five conservation
counters → the latency `word_delay` → **the control run at the default schedule**
(its own word count, per-word facts, octets, strobe set and silence scan) →
`assert_monitors_clean` on the clear bench, then the control bench.

> **The delivered-word count is the FIRST DUT-observable assertion in the unit.**
> Its window contains **no frame, no strobe condition and no start character**:
> the frame's own `tlast` and its `error_bad_fcs` both land on the cycle
> immediately **before** the window opens, every input word from there to the end
> of the drain is idle, and the schedule's only start character is at cycle 1.
> **That is the whole reachable surface of this row and it is why `IC-K4` is the
> only class that can convict it.**

**`M03-K2`** (`run_k2`, one member): stimulus derivation, the two frames'
constants, the window's own two constants and the release-cycle identity → **the
delivered-cycle list of the whole run** → the two partition-length checks → frame
A's `tkeep` and its `tlast` prohibition → frame A's octets → frame B's per-word
facts → frame B's octets → frame B's sequence number → **the whole run's `tlast`
count and its cycle** → **the strobe set over the whole run** → the driven-`clear`
check → **the silence scan across the window and the release cycle** → the
accounting calls → `cleared_mid_frame` → the protocol counters → the five
conservation counters → `word_delay` → `frames_compared` → **the control run at
the default schedule** → `assert_monitors_clean` on both benches.

> **The delivered-cycle list of the whole run is the FIRST DUT-observable
> assertion in the unit, and it is a CHOKE POINT.** Every class that moves which
> cycles carry a delivered word — a phantom closure, a leaked word, a refused
> frame B, a shifted window — raises **that** assertion and nothing after it.
> **And its message carries no observed data**: it names the expected list and
> stops. §5 item 1 is the finding that follows, and it is this round's largest.
>
> **The two partition-length checks immediately after it are unreachable while it
> passes**, because it pins the total at ten and the partition is a fixed split at
> two. Recorded so that no scorecard implies they were probed.

**`M03-N1`** (`run_n1`, **two members**, lane 0 then lane 4): schedule
construction, the frame's own terminate and the `/E/`'s derived octet time, the
overlay's two pre-drive landing checks, the driven word's own two landing checks
(all bench-side, reading the **driven** word) → **the delivered-word count** →
per word: cycle → `tlast` position → final `tkeep` → `tuser` → **the delivered
octets** → **the strobe set over the whole run** → the accounting call →
`assert_monitors_clean`.

**`M03-N4`** (`run_n4`, **two members**, lane 0 then lane 4): the whole
construction block, the two report-cycle routes' agreement, the derived change
cycles, the `Injection.outcomes` cross-check, both landing checks, the three named
enable facts and the driven-window check (all bench-side) → **the
delivered-sample cycle list** → frame A's word count, per-word facts and content
→ frame C's word count, per-word facts, content and sequence → **the exact strobe
set over the whole run** → the accounting calls → `word_delay` →
`assert_monitors_clean`.

> **Unlike `M03-K2`'s, `M03-N4`'s delivered-cycle assertion PRINTS THE OBSERVED
> LIST.** Two assertions of the same shape in the same bench, one of which reports
> what it saw and one of which does not. That comparison is `FINDING K-1`'s
> ground and it is a measurement, not an opinion.

### 4.4 `assert_monitors_clean`'s arms — ENUMERATED FROM THE FILE, in source order

`FINDING WO-0076-S1` is carried in as a bar and discharged **in the open** so the
next reader does not have to trust that it was. At the base SHA
`test/xgmii_rx_64/bench.ml`, `assert_monitors_clean` is defined at **`:599`** and
has **five** arms, in this order:

| # | line | form |
|---|---|---|
| 1 | `:604` | `<row>: protocol monitor unclean:` + the protocol report |
| 2 | `:610` | `<row>: conservation monitor unclean:` + the conservation report |
| 3 | `:616` | `<row>: strobe monitor unclean:` + the strobe report |
| 4 | `:632` | `<row>: latency tagger errors:` + the tagger's error list |
| 5 | `:638` | `<row>: latency tagger unclean:` + the tagger report, **gated on `frames_compared > 0`** |

**Arm 4 precedes arm 5**, which is the ordering `WO-0076`'s seal got wrong from
memory. **Both K units and `M03-N4` assert `word_delay` before reaching this
function, and `M03-K2` asserts `frames_compared = 2` before it**, so arm 5's gate
is satisfied at every unit this campaign scores. **A red at any of these five means
the unit's own assertions all passed and a monitor spoke afterwards**; §13's
qualification rule forbids counting a kill from it.

---

## 5. What this campaign structurally cannot score — DECLARED BEFORE IT RUNS

Every statement here is derived from committed text at the base SHA. None of it
is contingent on the result.

1. **`FINDING K-1` (MAJOR, against my own `WO-0072` §9) — the pre-committed
   disposition table asks the adjudicator to tell D1, D2 and D3 apart from what a
   scorecard prints, and at `M03-K2` a scorecard prints ONE IDENTICAL SENTENCE
   for all three.** `WO-0072` §9 fixes three *distinct* dispositions with three
   *distinct* `BUG-` citations: D1 cites REQ-009's mid-frame truncation sentence,
   D2 cites REQ-009's **last** sentence, D3 cites REQ-009's **first** clause. Their
   tells are three different observations. **But all three move which cycles carry
   a delivered word, so all three raise the unit's FIRST DUT-observable assertion
   — the whole run's delivered-cycle list — and that assertion's message names the
   expected list and does not report the observed one.** Four of this round's six
   K classes land there (§12). **Reachable is not separable**, and `M03-K2`'s own
   Kills cell compounds it: it says kill 1 is *"reachable at THREE distinct
   sites"*, and measured against the row's own instrument the three sites produce
   **one** message — two of them produce the same delivered-cycle list as well.
   **Disposition, and it is the precedent applied to a NEW shape**: the row **stays
   `ASSERT`** — its Observable is REQ-009's own and is sound, and every one of its
   assertions is correct. What the finding changes is **what a round may claim to
   have distinguished**, and it changes `WO-0072` §9's table from a discriminator
   into a taxonomy that needs the manifest to apply it. **Two carriers, named**:
   the message repair (print the observed list, as `M03-N4`'s own equivalent
   assertion already does) is owed to **the next commit that opens
   `test_m03_k.ml`**; the record of the finding is owed to **the post-campaign
   `AP-` round**. **Neither is paid here** — §10's freeze is worth more than a
   tidier bench, and repairing an assertion inside the window that scores it would
   void the round by its own rule.
2. **`M03-K3` is `NO-ASSERT` and is not scoreable.** No unit title in
   `test_m03_k.ml` names it and no assertion in the file is its. Declared, not
   omitted; unchanged by this round in either direction.
3. **The `clear` pre-scan guard and the `Clear` structural witness are bench-side
   and unreachable by any mutation.** The guard walks cycles `0 … total − 1`,
   reads the **driven** clear value and the **driven** word, and raises before the
   DUT's outputs are examined; the witness compares `Clear.high_cycles` and
   `Clear.value_at` against literals and drives no design. **A guard message in
   this campaign means something other than a seeded class.** **And the standing
   fact stays standing**: both K rows *enter* the guard and find nothing, so the
   guard's **entry** condition is mechanically witnessed and its **refusal** has
   never fired on a real violation — a half-measured instrument, exactly as the
   `Enable` guard is, and unchanged here.
4. **The differential co-simulation anchor is blind to this entire campaign, and
   the ground is STIMULUS.** The lane drives `clear` for **one cycle at reset with
   nothing in flight** (`test/cosim/ours_run.ml:159`/`:162`; `rst` released at
   `test/cosim/tb_xgmii_rx_64.v:257`), holds `cfg_rx_enable` at **1** for the whole
   run (`ours_run.ml:160`; `tb_xgmii_rx_64.v:63`), and drives **one** 64-octet
   good-FCS frame with no in-word double-closure geometry anywhere. **Not one of
   the nine classes is rendered at that stimulus**, so a green `cosim` job is
   evidence of nothing. This is `WO-0075`'s **bar 4** at its **third** instance,
   and here as at family J there is only one candidate cause: the port under test
   is never driven with anything pending. A wider canonical grammar would change
   nothing.
5. **`M03-N4`'s zero-delivered branch has NO INSTANCE and no campaign can give it
   one.** The row's own Observable cell carries the derivation
   (`J-dv_lead-0121`, landed `J-dv_lead-0124`): the aborting `/S/` must land at or
   before frame A's first octet, so the enable's 1 → 0 change would have to fall
   strictly between A's start cycle and W, and §6.3 item 7 / **C-14.5** forbids a
   change on a start character's own cycle. **There is no admissible change cycle
   at either start lane.** `IC-N4a` and `IC-N4b` are seeded against the
   **delivering** branch and nothing here reaches the other one. **No `SO-`,
   campaign or verdict may read this row as coverage of a zero-delivered REQ-110
   abort**, whatever this campaign scores.
6. **`M03-N3` is `NO-STIMULUS` for the REQ-016 family** and is untouched here.
7. **REQ-802/§9.1's reset value for `receive enable` remains unobservable at this
   bench.** `Bench.create` drives `cfg_rx_enable` = 1 through the reset cycle and
   `run` drives a value every cycle from cycle 0. Declared again so that no `SO-`
   counts §9.1's reset column as covered by this round.
8. **Every lane-4 member of the N section is shadowed, not measured**, and so is
   every assertion ordered after the first reddening one in each of the four
   units. `R-DISC-1`'s discharge is still required **per lane**: a member
   discharged term by term and merely unobserved is recorded **unobserved**, never
   as a miss and never as a pass.
9. **`M03-K1`'s withdrawn second class stays withdrawn.** No cell in this campaign
   may qualify `M03-K1` on *"a design that needs a second cycle to settle"*,
   whatever a scorecard shows. That prohibition is the plan's own
   (`WO-0072` §7.5, `J-dv_lead-0132`) and it binds this verdict. **`IC-K5` is the
   design in question, it is seeded against `M03-K2`, and a kill there is
   `M03-K2`'s and never `M03-K1`'s.**
10. **`M03-K2`'s third declared kill is not a design kill and no round may count
    it as one.** *"A monitor that counts the abandonment as a silent discard"* is a
    statement about the **monitor contract** — no design can cause it to be wrong —
    reclassified at `J-dv_lead-0132` and discharged by the row's own
    `frames_exempt` assertion. Unchanged here.
11. **`FINDING J-1`'s second half is not repaired here.** REQ-810's first sentence
    still has no `Kills` cell at `M03-J1`. Carrier: the post-campaign `AP-` round.
12. **A kill proves the assertion convicts, never that the bench is a general
    detector of the class.**

**None of items 2–12 is a defect in the bench and none moves a row.** Item 1 is a
defect in **my own pre-committed disposition table** and, secondarily, in a bench
message; it is found here and repaired nowhere here.

---

## 6. Reachability, discharged term by term — both sides

**R-DISC-1 binds your manifests** (`DISP-0001` §4). For **each** of the nine
classes separately: name the gate signal, quote its **complete** defining
expression from the base file with line numbers, and evaluate **every** conjunct
on the named stimulus at the claimed firing cycle, calling out which conjuncts are
contributed by the **stimulus** rather than by the mutation.

**Per-lane evaluation is required wherever the class's own consequence names more
than one.** `M03-N1` and `M03-N4` each drive **both** start lanes; discharge at
**both** for every N class that selects them. The two K units have **one member
each**. A lane you did not evaluate is **NOT SEEDED** for scoring purposes.

**Four cycle facts must be discharged explicitly for every K class, because every
one of them turns on one of them**: (a) the cycles at which the driven `clear` is
high; (b) the **release** cycle, which is the first cycle at which it is 0 again;
(c) what is pending on the cycle immediately **before** the window opens — a
delivered word, a strobe, a frame in flight, or nothing; (d) whether any cycle in
`[window first − 1, release]` carries a start character. **At `M03-K2` the release
cycle IS a start character's cycle and the distance is zero**, which is what makes
`IC-K3` reachable at all and what makes a rendering needing one idle cycle a
*conformant-looking* design that is not. **At `M03-K1` (c) is a strobe and nothing
else, and (d) is empty** — which is §5 item 1's other half and `IC-K4`'s whole
ground.

**Two cycle facts must be discharged for every N class**: the cycle at which the
enable changes in each direction, and the cycle at which the observable your class
moves is produced, against §4.3's *"at least one cycle after"*.

**R-DISC-2**: **name the paths and say which your class touches.** This campaign's
gate inventory is **admission** (a start character's acceptance), **emission** (the
output-word path), **report** (the five strobes' enables), **state** (the state
machine's reset) and **abort** (REQ-110's Frame-exit on a start character). Each
path gets a gate-inventory row carrying its full term list and every intent's
claim about it, **before delivery**, with **cross-class gate facts tabulated** —
every term two classes both touch, named before delivery rather than discovered.
Expected shape, stated so a shared site is not mistaken for a combined diff:
**IC-K1, IC-K6 and IC-K5 will all touch the emission path's clear gate**; **IC-K3
and IC-K5 will both touch admission's clear interaction**; **IC-K2, IC-K4 and
IC-N4b will all touch the report path**, two of them under `clear` and one under
the enable. `WO-0073-VERDICT` §7 Q4 governs: **a shared site is not a combined
diff. Nine separate diffs remain mandatory.**

**And the same standard applies to me, on the bench side, discharged here.** Every
`R!` cell in the seal is a message raised by an assertion whose own terms are:

- **(a)** the stimulus reaches the assertion — every unit is its own
  `%expect_test`, so no unit shadows another; inside a unit the members shadow and
  §4.3's order is the whole of the adjudication;
- **(b)** the observable is read from the DUT's own outputs under the `Before`
  view, so a pulse belongs to the cycle whose input word was driven and a delivered
  word belongs to the cycle it left on;
- **(c)** every assertion ordered **before** the scored one is unmoved under the
  class — which for `M03-K2`'s later cells means the whole delivered-cycle list,
  and is discharged per class at §7;
- **(d)** nothing outside the unit is required for the conviction.

---

## 7. §4(c) as a test — the per-class permission lists

**The measured datapath-perturbation signature** (`BUG-0003` §V.10.2,
`J-dv_lead-0103`, transient tree `5c47582`): **(a)** 7 mid-frame words with
`tkeep` ≠ 0xFF and `tlast` = 0; **(b)** 4 of 60 required octets in their gapless
byte positions, 28 delivered as the idle filler `0x07` and **28 never delivered at
all**; `tlast` on word 7; `tuser` = 0 on a corrupted frame.

`WO-0076` inverted the check from a global prohibition into a **per-class
permission list**, because a family whose observable *is* the datapath makes a
global prohibition fail a correct rendering. Family K is the same shape and the
same form is used. **The signature's components are permitted to NO class in this
campaign.**

| class | permitted to move | must be identical to the base |
|---|---|---|
| **IC-K1** | the delivered stream of a frame in flight across a driven `clear` window | every strobe; frame B's delivery; every stimulus with `clear` at 0; the reset pulse's response |
| **IC-K2** | the strobe set inside a driven `clear` window and on its release cycle | every delivered word anywhere; every strobe of a frame `clear` did not abandon; every stimulus with `clear` at 0; the reset pulse's response |
| **IC-K3** | the delivered stream of the **first** frame whose start character is on a `clear` window's release cycle | the window's own contents; every strobe; every stimulus with `clear` at 0; the reset pulse's response |
| **IC-K4** | the strobe set inside a driven `clear` window and on its release cycle | every strobe cycle outside the neighbourhood of a driven clear — **and this is the conjunct that separates the class from a re-timing** (§1.9); every delivered word anywhere; every stimulus with `clear` at 0; the reset pulse's response |
| **IC-K5** | the one-cycle boundary of a driven `clear` window at each edge it shifts | every stimulus with no driven `clear` window; **the reset pulse's release cycle, which is cycle 0** (§1.11); everything else |
| **IC-K6** | `tvalid` and the delivered stream inside a driven `clear` window and on its release cycle | every `tlast`; every strobe; frame B's delivery; every stimulus with `clear` at 0; the reset pulse's response |
| **IC-N1** | the strobe set at an input word in which an **earlier** lane effects a state change and a **later** lane carries a control character; **and, under branch β only (`D-N1c`), the delivered stream of the frame that earlier lane closed** | every delivered word at any other frame; every strobe at a word carrying one control character or none; **every word in which no lane effects a state change — every idle word in the suite included** |
| **IC-N4a** | the delivered stream of a frame open across a refused start character | every frame untouched by a refused start; every strobe not attributable to the abort; everything at `Enable.high` |
| **IC-N4b** | the strobe set on a cycle at which `cfg_rx_enable` = 0 | every delivered word anywhere; every strobe on a cycle at which the enable is 1; everything at `Enable.high` |

1. **The auditor's pre-ship check, for ALL NINE classes.** Before delivering each
   manifest, confirm the rendering produces **none** of the signature's components
   at any stimulus, and confirm **positively** that every fact in the right-hand
   column is identical to the base — in particular **the `clear` = 0 column and the
   reset-pulse column for every K class**, and the `Enable.high` column for every
   N class.
2. **My adjudication check, and it is executable.** In `M03-K2` the delivered-cycle
   list is asserted before every per-word fact, and in `M03-K1` the delivered-word
   count is asserted before the strobe set. So a rendering that moves something
   outside its permission list raises a message this seal places at a **different**
   assertion from the class's own cell, and the seal's §4 records which.

**Consequence, fixed here so it cannot be renegotiated**: a class red at a cell
**outside** its own permission list is scored as **the class out of specification
— reported, not scored**, no claim about the affected row is made in either
direction, and the class's kill is not counted from that red. **A class that
reddens a unit driving neither `clear` nor the enable has not rendered a
configuration or reset defect at all**, and is a **scope finding**.

---

## 8. The K × N cross product, enumerated BEFORE it runs

**This section exists because I demanded it of myself before the ruling that
adopted this packet's shape**: the seal SHALL enumerate the K × N cross product
before it runs and pre-declare every K-class red at an N row as blast radius. **At
family J that demand was expensive** — four of five classes reddened `M03-N4`
through the admission path, and the seal had to carry four blast-radius cells
whose only function was to stop a scorecard reading them as breadth.

**Here it is cheap, and the reason is measured rather than hoped for.** §3.3: the
clear-driving set and the enable-driving set have **empty intersection**, and
`IC-N1`'s rule selects a unit by an in-word geometry neither K unit drives.

**The enumeration, all thirty cells, stated in the open because it is a fact about
the bench and not about the answer:**

| | `M03-N1` | `M03-N4` |
|---|---|---|
| IC-K1 … IC-K6 (six classes × two units = **12 cells**) | predicted **GREEN** — both units drive `Clear.never`; no schedule cycle has `clear` high; the only `clear` either sees is the reset pulse, with nothing in flight, no strobe owed and an idle word | same |

| | `M03-K1` | `M03-K2` |
|---|---|---|
| IC-N1, IC-N4a, IC-N4b (three classes × two units = **6 cells**) | predicted **GREEN** — both units run at `Enable.high`, so neither N4 class's first conjunct is satisfied; and no input word in either schedule carries two control characters, so `IC-N1`'s is not either | same |

The remaining **12 cells** of the 5 × 6 product — the three N classes against the
three family-J units, and the six K classes against them — are enumerated in the
seal, where the one **load-bearing** green among them lives (`M03-J3` under
`IC-N4b`, which measures `FINDING J-2`).

**Pre-committed disposition, and it is stated in BOTH directions**:

- **A K-class red at `M03-N1` or `M03-N4`** is **blast radius — it qualifies
  nothing in either direction — AND it is a SCOPE FINDING**, because it means the
  rendering reached a unit that never drives `clear` during a schedule, which is a
  failure of `D-K1b`. Both consequences apply; neither substitutes for the other.
- **An N-class red at `M03-K1` or `M03-K2`** is the same, mirrored: blast radius
  **and** a scope finding against the class's own `Enable.high` column.

**This is the separating machinery the adopted ruling rests on, and it is now a
measurement rather than an assurance.** `WO-0058` ran two families in one campaign
on the strength of an argument; this one runs two sections on the strength of a
census whose intersection is empty and a cross product whose reds are all
predicted absent.

---

## 9. The allowlist — BLINDED, and absolute

**This is the complete set of repository paths you may read for this campaign's
duration. Everything else is out of bounds, absolutely.**

| | readable |
|---|---|
| 1 | `libs/hardcaml_ethernet/src/xgmii_rx_64.ml` **and its `.mli`**, at the base SHA — the mutation target |
| 2 | `docs/specs/requirements.md` and `docs/specs/modules/xgmii_rx_64.md` — the specs this packet names |
| 3 | **this packet** |
| 4 | `docs/adr/ADR-0014.md` — named because both `M03-N4` classes are derived from a reading it adjudicates, and reading the ADR is reading normative reasoning, not an answer |
| 5 | `docs/reports/audit/**` — your own tree |

**Out of bounds, absolutely, for the campaign's duration**: **all of `test/**`** —
which includes `test_m03_k.ml`, `test_m03_n.ml`, `test_m03_structural.ml`,
`bench.ml`/`bench.mli`, `test/xgmii/`, `test/monitors/`, `test/cosim/` **and the
attack plan `test/attack_plans/AP-xgmii_rx_64.md`** — **all of `agents/**`, this
packet excepted and its sealed companion emphatically not excepted**, and every
journal. The seal names cells, message strings, assertion orders and
MUST-STAY-GREEN sets; reading it is reading the answer. **The AP is barred by name
because SEVEN of this campaign's nine classes are quoted from its cells** —
IC-K1, IC-K3, IC-K4 and IC-K5 from §4.K's two rows, IC-N1 from `M03-N1`'s Kills
cell, and IC-N4a and IC-N4b from the two halves of `M03-N4`'s reading (ii) — and a
manifest author who reads the row that authored the class is choosing a diff
against a written expectation rather than against the specification. **`WO-0072`
is barred by the same rule** — it is under `agents/**` and it carries §9's
disposition table, which is `FINDING K-1`'s subject.

### 9.1 Manifest only — the auditor does not cut a branch

**`FINDING WO-0074-A1` (MAJOR, auditor's, ruled ACCEPTED) is carried into this
round's terms rather than left to be re-derived, as it was at `WO-0076`.** The
auditor delivers **manifests**: patch text, the substitution table, the
discharges, the disclosures and the pre-ship check. It does **not** cut, commit or
push the transient branches — PROTOCOL §2 makes the orchestrator the sole operator
of git and §6/R7 puts `libs/**` outside the auditor's scope. **The operator cuts
the nine transients itself, from the manifest's own table, in §12's fixed delivery
order**, and reports each branch name and CI run id.

### 9.2 The abort-first direction check

**First action, before reading anything**: run `git rev-parse HEAD` and compare it
against §10's base SHA as the operator supplies it.

**If it does not match, do not proceed and do not guess which way it differs —
determine the direction and report in one line.** Run
`git merge-base HEAD <base>`: if **HEAD is the merge-base**, HEAD is a strict
ancestor of the base and the container has rolled back — say so and stop. If HEAD
is a **descendant**, something landed inside the freeze window and §10's ordering
rule decides whether the round still has a valid base — say so and stop. If
neither, the histories have diverged — say so and stop. **A manifest authored
against one tree and applied to another is not a manifest, and the failure is
silent in every artefact the round produces.** This is incident three's check with
incident four's direction test, which caught incident four in one command.

### 9.3 What the manifests must carry

Per R-DISC-1 / R-DISC-2:

1. **Nine diffs** — IC-K1, IC-K2, IC-K3, IC-K4, IC-K5, IC-K6, IC-N1, IC-N4a,
   IC-N4b — each **minimal and independent**: each applies alone to the base SHA,
   elaborates, and reverts cleanly. **No diff may combine two classes**; a combined
   diff makes both unscoreable.
2. **A reachability discharge per class, per named lane, term by term at the
   firing cycle**, with the stimulus-contributed conjuncts called out and §6's four
   K cycle facts and two N cycle facts explicit — or a **self-declared NOT SEEDED**
   for any term you cannot discharge.
3. **Gate-inventory rows** for the **admission**, **emission**, **report**,
   **state** and **abort** paths, with every class's claim about each, and
   **cross-class gate facts tabulated**.
4. **All nineteen disclosures answered in your own words**: **D-K1a**, **D-K1b**,
   **D-K2a**, **D-K2b**, **D-K3a**, **D-K3b**, **D-K4a**, **D-K4b**, **D-K4c**,
   **D-K5a**, **D-K5b**, **D-K6a** *(twelve in the K section)*; **D-N1a**,
   **D-N1b**, **D-N1c**, **D-N4a-1**, **D-N4a-2**, **D-N4b-1**, **D-N4b-2**
   *(seven in the N section)*. **12 + 7 = 19**, and each is answered separately
   under its own label.
5. **The §7 pre-ship check result for all nine classes**, in its positive form,
   against that class's own permission list — including the `clear` = 0 column and
   the **reset-pulse** column for every K class and the `Enable.high` column for
   every N class.
6. **The base SHA you applied to**, quoted, and confirmation that it matches §10's
   and the direction check of §9.2.
7. **Anything the packet made you guess.** A question about this packet comes to me
   as a committed **pre-run reading note** **before** the run, and I answer it in
   the same form. A question answered after a scorecard exists is not a question,
   it is a negotiation.

---

## 10. The base SHA, and the adjudicator-ordering rule

**One base SHA for the whole round** — all nine classes, both sections, the
control run and every MUST-STAY-GREEN sweep. `BUG-0003` §V.9's *"one round cannot
carry two base SHAs in its evidence"* governs, and it governs across the two
sections as strictly as within one.

**The base SHA is the commit that stages this packet and its seal.** Not its
parent — the corrective drafting rule adopted at `WO-0073-VERDICT` §7 after
`FINDING WO-0073-M1`, applied for the fourth time. I cannot state its hash: I
never run git (PROTOCOL §2), and the commit has none until the orchestrator
creates it. **The orchestrator records the hash when it lands**; the auditor quotes
the hash it applied to (§9.3 item 6), and any disagreement is a finding **before**
the campaign runs, not after.

**The adjudicator-ordering rule, stated because it is what makes any of this
evidence.** **The bench must be frozen strictly earlier in history than any mutant
RTL it judges.** Concretely:

- Every `test/**` byte this campaign scores against is at or before the base SHA.
  **The last `test/**` edit before this packet is `22ffe13`** (`J-tb_writer-0032`,
  the cosim-lane comparator half); **this packet stages no `test/**` byte**, and
  **nothing under `test/**` moves again until the campaign scores.**
- The seal is frozen in this packet's own commit — **after** the last bench edit
  and **before** the first mutant diff exists.
- **No diff body reaches me until every diff is committed on its transient
  branch.** I adjudicate against the seal, and the seal is opened only when the
  scorecards are in hand.
- If any `test/**` file is edited between this commit and the scorecard, **the
  round is adjudicated as having no valid base** and re-runs from a fresh seal.
  **That includes edits by me**, and it specifically includes `FINDING K-1`'s
  message repair, which is why §5 item 1 refuses to pay it here.

### 10.1 The hazard `WO-0076` §8.0 named has NO INSTANCE this round, and the reason is the resequencing

`WO-0076` §8.0 named `WO-0075` as a live hazard: an outstanding work order whose
return edits `test/cosim/**` and would have broken the freeze from inside the
window. **The adopted 3 → 2 → 1 resequencing (`J-dv_lead-0142` Open-question 1)
was chosen to buy family K a clean window, and it did.** `WO-0075` is `ACCEPTED`,
both halves landed at `5705e3a` and `22ffe13`, and the post-campaign `AP-` round
landed at `1e5d58a`. **There is no outstanding work order that touches `test/**`
or `tools/**` at the time this packet is drafted.** The Phase-2/3 stimulus-widening
work order that carries `RV-0075-2`'s antecedent repair, the
`EXIT_TIMING_UNASSERTABLE(12)` code and the case-(e) fixture rebuild is **drafted
after this campaign scores, by ruling**, and its own draft is dated by the commit
that carries it.

**If anything lands inside the window anyway, the round re-seals.** I am not
writing myself a carve-out on the ground that some directory contributes no unit:
`FINDING K-3`'s rule is that a bar unmeasured against its own tree is a hope, and
a freeze with an exception invented after the fact is worse than that.

---

## 11. Mutant-owned quantities, and how they are sealed

A quantity is **mutant-owned only if the specification does not fix it**. Every
such quantity is sealed as an **inequality with a named direction**, never as a
value; a seal that pins a rendering's own arithmetic scores a correct rendering as
a finding. The axes, with the cells in the seal:

| quantity | sealed as | direction, and why |
|---|---|---|
| the **delivered-word count** at `M03-K1` under any class permitted to move it | an inequality with the derived value stated | the row's own count is specification-fixed at eight by REQ-103 and §6.1; a class that moves it says which way |
| the **strobe count** at `M03-K1` under **IC-K4** | an inequality **above one**, with both `D-K4b` derivations named | **more** — a carried strobe adds high cycles beside the frame's own; the *number* depends on pulse-versus-level and is the disclosure's, not the seal's |
| the **cycle** an `IC-K4` rendering presents on | an inequality **inside the driven window and its release cycle**, with both `D-K4a` members' derivations named | **not printed at the scored cell**, which is why `D-K4a` exists |
| the **delivered-cycle list** at `M03-K2` under IC-K1, IC-K3, IC-K5 and IC-K6 | **the cell's message is character-exact and contains no observed data at all** (§5 item 1); the *list itself* is mutant-owned and **UNREAD** | the seal states, per class, which cycles the list gains or loses — as a **prediction that no cell reads**, so a disagreement about it is information and never a finding |
| the **strobe set** at `M03-K2` under **IC-K2** | **the cell's message is character-exact and contains no integer**; the strobe's name and cycle are mutant-owned and **UNREAD** | which is why `D-K2a` exists |
| the **delivered-sample cycle list** at `M03-N4` under **IC-N4a** | an inequality: the observed list is a **strict superset** of the expected one, with the derived gained set stated per member | **more** — a frame that is not aborted delivers the words it would have delivered under `Enable.high`. **This list IS printed**, so the direction is a real bench-side discriminator here and is not at `M03-K2` |
| the **strobe count** at `M03-N4` under **IC-N4b** | an inequality **below one**, with the derived value stated | **fewer** — a suppressed report cannot add a pulse |
| the **strobe set** at `M03-N1` under **IC-N1** | **the cell's message is character-exact and contains no integer**; the strobe's name and cycle are mutant-owned and **UNREAD** | which is why `D-N1a` exists |
| every delivered word count, cycle, `tkeep`, `tuser` and octet at a frame **outside** the class's permission list | **not mutant-owned** — spec-fixed by REQ-011, REQ-016, REQ-103, REQ-106, §6.1, §7 | §7's check restated as a seal: any movement is out of specification, not a rendering's prerogative |
| `sample.clear`, `sample.enable`, every derived window, start, terminate and change cycle, `Arrival.check`, `Injection.outcomes`, both landing checks, `Enable.report`, both pre-scan guards | **not mutant-owned** — bench-supplied | evaluated on the bench's own model before or independently of the DUT; a message from one means something other than a seeded class |
| **units reddening under a class** | `⊆` the class's **rule** in the seal, whose conjuncts include §4.2's two | a red outside the rule is a finding: either my rule was wrong or the diff reaches further than the class it names |

**Five of the eleven rows are specification-fixed or bench-supplied and are sealed
as equalities on purpose**; calling them mutant-owned would be buying an
unfalsifiable seal. **The fourth row is the one to read twice, and it is a
confession rather than a technique**: at `M03-K2` the seal has **no** mutant-owned
axis to seal, because the cell prints nothing a mutant chose. That is `FINDING
K-1` restated as a seal property, and it is why §12's first collision has no
bench-side discriminator at all.

---

## 12. Collisions — derived by the cross product, and what they cost you

**Freely told**: this campaign's collision inventory was built by
`FINDING WO-0074-S4`'s corrected method — **the cross product of every class's
predicted red set with every scored cell**, never from the scored cells alone. It
contains **one four-class collision on a single scored cell**, **one within-class
branch pair**, and **one cross-section near-collision that the method proved
empty**. Which strings and which discriminators are sealed; the shapes are here
because they are facts about the bench.

**The method's yield, stated in the open because it is the point of carrying
it**, and this round it yielded three different kinds of thing:

1. **The four-class collision at `M03-K2` would have been visible from the scored
   cells alone for three of its four members** — IC-K3, IC-K5 and IC-K6 all mark
   that cell. **The fourth member is IC-K1 under two of its three disclosed sites**,
   and that arrival is *blast-radius-shaped*: IC-K1's own marked cell depends on
   `D-K1a`, so under the old method it would not have been in the inventory at all.
   That is exactly the shape `WO-0074`'s fourth collision had.
2. **The within-class branch pair is IC-K4's α and β**, which are message-identical
   at the scored cell whenever α presents once; the seal branches on `D-K4a` alone.
   This is `WO-0066`'s IC-D/IC-F situation, `WO-0073`'s collision 1, `WO-0074`'s
   collision 1 and `WO-0076`'s collision 3 at their **fifth** instance.
3. **And the method's most valuable yield this round is a NEGATIVE**: the K × N
   and N × K cross products are **empty of reds** (§8), measured rather than
   assumed, which is what makes one campaign with two sealed sections lawful here
   where family J's four-of-five `M03-N4` reds made it costly.

**What that costs you, and it is operational rather than theoretical:**

1. **Every class is delivered as its own diff and run as its own transient.** For
   the four-class collision, **which diff was applied is very nearly the only
   discriminator that exists** — the seal names the one other discriminator it
   has, and it is a colour at a different unit, not a string.
2. **The delivery order is fixed**: IC-K1, IC-K2, IC-K3, IC-K4, IC-K5, IC-K6,
   IC-N1, IC-N4a, IC-N4b, each on its own branch, each with its own CI run id
   reported. **A scorecard that cannot say which branch produced which message
   cannot be adjudicated at all this round** — which is a stronger statement than
   any previous campaign has had to make, and `FINDING K-1` is why.
3. **A combined diff makes both members unscoreable** and is reported as a manifest
   defect, not as a result. Two classes touching the same clear gate does **not**
   make them a combined diff — `WO-0073-VERDICT` §7 Q4 governs — but nine diffs are
   still nine diffs.
4. **The disclosures are load-bearing in a way they have not been before.** At
   `WO-0076` a disclosure decided between two branches of one class. Here
   `D-K1a`, `D-K3a`, `D-K5a` and `D-K6a` are, for their classes, the **only**
   record of what was rendered that the scorecard cannot supply. An unanswered
   disclosure makes its class's cells `U` and the class scores zero.

---

## 13. The qualification rule, and how the two sections are kept apart

`WO-0073` §11's rule and `WO-0074` §11's correction were written for **bound**
rows. **Family K owns its two units outright and family N owns its two**, so the
corrected rule applies in its simplest form and one clause does the work:

> A red qualifies a row **iff the assertion that spoke is an assertion of that
> row's own observable**. A red at another family's unit qualifies that row at
> most and this family not at all; a red arriving through a monitor arm or a
> bench-side guard qualifies nothing anywhere.

Six consequences, all binding:

- **Kills are counted per class** (`WO-0066` §11). Six K classes and three N
  classes is at most **nine** kills, and **five classes qualifying `M03-K2` is
  five kills and one qualification**, reported that way rather than as five
  qualifications.
- **The two sections are scored, tallied and reported separately.** The verdict
  states K kills and N kills as two numbers, states which rows each section
  qualified, and **never sums a K kill into an N row's evidence or the reverse**.
  Both feed one era tally (§14) because a class is a class.
- **A K-class red at an N unit or an N-class red at a K unit qualifies nothing in
  either direction and is a scope finding** (§8).
- **A red through any of `assert_monitors_clean`'s five arms qualifies no row**
  (§4.4), however red, and the class's kill is never counted from it.
- **`M03-K1` is qualified by `IC-K4` or by nothing.** If `IC-K4` returns `NOT
  SEEDED`, the row is **UNQUALIFIED and declared UNQUALIFIABLE BY MUTATION at its
  own stimulus**, with §4.3's derivation as the ground — and that declaration is
  this campaign's result for that row, made in the verdict and carried into the
  `SO-`, not discovered later by a seventh unqualifying red.
- **A qualification measures an instrument; it discharges no row and moves no
  count** (`J-dv_lead-0138`). §1's status vocabulary is closed at six values and
  `QUALIFIED` is not one of them.

---

## 14. Cost — priced before the transients are seeded, and the two sole exercisers

**This campaign adds no stimulus.** Every unit it scores is already in the landed
suite and already runs in every CI job; there is no new schedule, no probe and no
frame-count decision to make. **Its marginal test cost is exactly zero** and its
whole price is job walls.

The reference figure, quoted with its provenance rather than estimated: the
`build` job's whole wall was **344 s** at run `31015276337` (job `92337605716`),
of which the entire `dune runtest` step was **4 s**. That figure is **carried**
from `WO-0074` §12 and `WO-0076` §12 with its provenance rather than re-measured —
I cannot run CI (ADR-0005) — and nine consecutive campaigns' transients have come
in at that shape.

| item | figure |
|---|---|
| classes | **9** — six K, three N |
| transient branches | **9** (one per class; §12 forbids combining) |
| CI `build` runs | **9** |
| CI wall, at the measured 344 s job | **3096 s ≈ 51.6 minutes** |
| of which the K section | 6 × 344 s = **2064 s ≈ 34.4 minutes** |
| of which the N section | 3 × 344 s = **1032 s ≈ 17.2 minutes** |
| of which the whole `dune runtest` step | 9 × 4 s = **36 s** |
| of which stimulus added by this campaign | **0 s — it adds none** |

**Four consequences fixed before seeding.**

(a) **No reduction proposal can be made on stimulus grounds**; the only lever is
the class count.

(b) **`FINDING RV-0075-3` is carried in as a bar and it binds this section: no
class here is optional, and the two that a cost-cutting reading would reach for
first are named as SOLE EXERCISERS.** **`IC-K5` is the only class in this campaign
that measures `WO-0072` §7.5's *"invisible at `M03-K1`"* derivation**, a
withdrawal this programme argued from a stimulus and has never run; **`IC-N4b` is
the only class that reaches a strobe-set assertion at a frame the enable did not
refuse, which is the sole instrument `FINDING J-2` names for the suppressing
design and the only carrier for a debt `WO-0076-VERDICT` §10 left open.** Dropping
either saves **344 s** and costs a measurement that no other class in the round or
in any previous one can make. **My recommendation is to keep both**, and the trade
is in figures so the operator can decide rather than infer. **What a specification
may not do is mark either "optional if it costs you nothing"** — that is the
drafting defect `RV-0075-3` was minted against, and this packet does not repeat
it.

(c) **`IC-K4` is the likeliest `NOT SEEDED` of the nine and its price is paid
either way.** Its job runs whether it is seeded or declared, because the
declaration is a manifest, not a run. A `NOT SEEDED` there is a **result** in the
register `WO-0074` used for `M03-M5` (§13).

(d) **The control run is the base commit's own CI run** and costs nothing extra;
**CI is the authority** (ADR-0005) and *"passes locally"* is not admissible from
the auditor, the orchestrator or me.

**What the era tally becomes, stated before the run so no verdict can inflate
it.** The class-based era stands at **54 sealed / 52 killed / 1 survived / 1 void
by declaration** (`WO-0076-VERDICT` §12; 52 + 1 + 1 = 54). This campaign seals
**nine**, so the era closes at **63 sealed**, with a ceiling of **61 killed** and a
floor of **52 killed, 1 survived, 10 void** if nothing seeds. **The single
survivor remains `G-c4` (`FINDING G-1`) and the single existing void remains
`IC-M5`**; `IC-K4` is this round's likeliest addition to the void column and §13
says what its void buys.

---

## 15. What this round does NOT close, and the owed list with its carriers

**Named before the result, so no omission is invisible.**

1. **The attack plan does not move in this round's commit, and it does not move in
   the round before it either.** `RV-0075`'s three §7 placements —
   `FINDING RV-0075-1`'s and `FINDING RV-0075-2`'s carriers beside bar 4, and bar
   4's reconfirmation at the anchor's first timing execution — are **the next
   `AP-` round's and are carried**, unpaid at this commit by design. Every AP edit
   this campaign wants — §4.K's rows gaining qualification cells and a
   post-campaign block, `FINDING K-1`'s record, §4.N's two rows gaining their first
   qualifications, `DECLARATION`s, and the change-log row — is **owed, with a named
   carrier: the post-campaign `AP-` round.** §10's freeze is worth more than a
   tidier plan.
2. **`FINDING K-1`'s message repair is owed to the next commit that opens
   `test_m03_k.ml`**, and it may not be paid inside this campaign's window without
   voiding the round.
3. **`FINDING J-1`'s second half** — REQ-810's first sentence has no `Kills` cell
   at `M03-J1` — is raised, unrepaired, and **carrier-less until an `AP-` round is
   scheduled**. If none is scheduled before the `SO-`, it rides the `SO-`'s own
   round; an undated carrier is how a debt becomes a habit.
4. **The charter §3 differential co-sim anchor is undischarged and now blind per
   RESET class as well as per configuration class and per strobe** (§5 item 4),
   which is `WO-0075`'s bar 4 gaining its third instance. **Carrier: the `SO-`
   round's own accounting** — there is nothing to repair, because the bar is a
   refusal and not a deferral.
5. **`RV-0075-1`, `RV-0075-2` and `RV-0075-3`'s owed repairs** — T1's
   expected-versus-observed table, the antecedent repair,
   `EXIT_TIMING_UNASSERTABLE(12)` and the case-(e) fixture rebuild — **ride the
   Phase-2/3 stimulus-widening work order, which I draft AFTER this campaign
   scores and which is dated by the commit that carries it.** By ruling. The
   escalation is dated to a commit and not to a clock: the first work order giving
   that lane a second frame or an injected idle must carry all four in the same
   round.
6. **`M03-K3`, the `clear` guard's refusal path, the `Enable` guard, `M03-J4`,
   REQ-802/§9.1's reset column, `M03-N3` and `M03-N4`'s zero-delivered branch**
   are all unscoreable here and stay so (§5).
7. **Carried unchanged and not this packet's to pay**: `WO-0047` §2's 4-octet
   anti-vacuity question (carrier: the next commit opening `test_m03_f.ml`);
   `OBSERVATION L-O1` (`test_m03_l.ml`); `WO-0073-D3`'s `M03-I4` mislabel
   (`test_m03_i.ml`); `OBSERVATION K-O1` (`test/monitors/`); AP-M14's §6 invariant;
   the `precompile_check.sh` side-effect lane; the RFC 1071 anchor; X-7, X-10, X-11
   deferred; L1–L5 as a separate packet.
8. **No `SO-xgmii_rx_64.md` issues and none is offered.** Outstanding before any
   PASS after this round scores: **the charter §3 anchor**, the four declared
   unscoreables above, and the **lessons harvest**, which falls due at the `SO-`,
   spans from my last harvest, and currently holds **eight banked candidates** —
   the three at `J-dv_lead-0137`, (C) at `J-dv_lead-0141`, (D) and (E) at
   `J-dv_lead-0142`, (F) at `J-dv_lead-0143`, and (G) and (H) at `J-dv_lead-0144`.
   It is **not** due this round and the span stays open, declared rather than
   skipped.
9. **A kill here qualifies a row on the class it was seeded against and on nothing
   else.**

---

## 16. Weighting, discounted in advance

**In favour of this round**: neither K row was authored with a mutation class
known — both landed at `284225d`, and the disposition table three of the classes
attack was written at `WO-0072` before a bench existed. **Seven of the nine
classes are quoted from the plan's own cells** rather than invented for the bench,
and the other two (IC-K2, IC-K6) come from REQ-009's own clauses and from
`WO-0072` §9's own D3. Two
classes (`IC-K5`, `IC-N4b`) measure derivations this programme argued and never
ran, and one of them (`IC-N4b`) pays a debt a previous verdict named and could not
carry. And the N section closes the last two landed-green-unscored rows in the
module.

**Against it, six ways, all stated before the scorecard:**

1. **The largest thing this round found, it found before running, and it is
   against my own artefact** (`FINDING K-1`, §5 item 1). A campaign whose headline
   is a defect in its own commissioning document's discrimination is a campaign
   whose kills are worth less than their count suggests.
2. **Four of six K classes score at one cell with one character-exact message**
   (§12). Their kills are attributable by branch and by the manifest's disclosures,
   and by very little else this bench prints.
3. **The campaign's instrument footprint is four units of fifty-nine**, two of
   which are the entire family-K surface. Fifty-five units are MUST-STAY-GREEN by
   two conjuncts, and that is a *protection*, never a coverage claim.
4. **`M03-K1` may end the round unqualified**, and if it does, the honest reading
   is not that the campaign failed but that the row's stimulus places its window
   over an interval where a conformant design has nothing to get wrong (§4.3). That
   is a statement about the row, made here rather than after a scorecard.
5. **`M03-K2`'s window geometry is tested at exactly one placement** — five cycles,
   opening with six output words still to come, closing on a cycle carrying a start
   character. A design that needs three cycles of settling and one that needs two
   are the same class here.
6. **The N section scores two rows whose historical reds were all blast radius**,
   and a reader who sees `M03-N4` red in a sixth and seventh campaign must be told,
   in terms, that **these two** are the first reds at the row's own cells seeded
   against the row's own observables. The verdict says so per class or it says
   nothing.
7. **`IC-N1` has the widest blast radius of the nine and it is wide in a way that
   flatters a scorecard**: its rule selects `M03-N2`'s six sub-cases and five
   family-B units besides its own, so a single class can produce **a dozen reds
   and one kill**. §2's declaration and §13's rule are what stand between that and
   a breadth claim, and the verdict states the qualifying red and the blast radius
   separately, per unit, or it states nothing.

---

## 17. What comes back

1. The **nine manifests** per §9.3.
2. **All nineteen disclosure items**, in the auditor's own words.
3. The **§7 pre-ship check** result for **all nine** classes, in its positive form,
   against each class's own permission list — the `clear` = 0 column and the
   **reset-pulse** column included for every K class, the `Enable.high` column for
   every N class.
4. The **full scorecard**: every unit red or green under each class, at the base
   SHA, with the **raised message at every red — the message, not a summary of
   it**, because the seal's cells are message-level. Where a unit raises inside a
   lane iteration, the **row prefix** distinguishes the member and must be
   reproduced verbatim.
5. The **control run**: the unmutated base SHA green, with its **CI run id and
   conclusion**.
6. The **per-class CI run id and branch name**, so §12's ordering is auditable.
   **This round cannot be adjudicated without it** (§12 item 2).
7. **The `cosim` job's conclusion under each class**, reported and explicitly
   **not** offered as evidence — §5 item 4 has already declared what a green there
   means and why the ground is the stimulus.
8. Anything judged rather than followed, and why.

**Three questions for the orchestrator's ruling, raised here rather than at the
scorecard:**

- **Q1 — the delivery order of the two sections.** §12 fixes K first, then N. The
  alternative is N first, on the ground that its two rows are the older debt and a
  container incident inside a 51.6-minute window would cost less if the older debt
  had already scored. **My recommendation is K first as written**, because the K
  section is the one whose freeze the resequencing was chosen to buy and because
  `FINDING K-1` makes K's adjudication the round's hardest; but the argument for N
  first is real and the operator should have it in figures rather than infer it.
- **Q2 — `IC-K4`'s price against its likely `NOT SEEDED`.** It is the only class
  that can qualify `M03-K1` and the likeliest of the nine to come back declared
  (§1.6, §14(c)). Keeping it is my recommendation; the alternative is an
  eight-class round in which `M03-K1` is unqualified **without a manifest saying
  why**, which is strictly worse than an unqualifiable declaration backed by one.
- **Q3 — whether `FINDING K-1` warrants a `BUG-`-class escalation of its own.** My
  reading is **no**: it is a defect in a bench message and in my own disposition
  table, not in the design, and PROTOCOL §10 gives it no `R`-rule. But it changes
  what `WO-0072` §9's committed table can be used for, and a pre-committed table
  that cannot discriminate is the kind of thing the operator may want surfaced
  rather than filed. Raised, not decided.

**Adjudication is mine**, against the sealed file, which is opened **only after
every scorecard is in hand**.

---

## 18. Not to be told

The sealed companion in its entirety: its two sections' matrices and their
MUST-STAY-GREEN sets, its verbatim message cells, the assertion orders' exact
message strings, its row prefixes, its UNWORKED adjudication rules, its
disclosure-branch tables, **which** classes collide and with what strings, its
GREEN-BY-BLINDNESS section, its per-class rules and worked instances, its
cross-product matrix's load-bearing cells, and its dispositions.

**Freely told, and told above**: the nine classes and the sentence each is derived
from; the nineteen mandatory disclosure items; §3's denominator, clear census,
enable census and their empty intersection; §4's three instrument kinds, the two
structural conjuncts, the assertion **orders** and the five monitor arms with
their line numbers; **§5's twelve declarations of what this campaign cannot
score**, including `FINDING K-1` in full and the anchor's stimulus blindness; §6's
reachability standard and the five-path gate inventory; §7's signature and the
per-class permission lists; §8's cross-product enumeration and its pre-committed
dispositions in both directions; §9's allowlist, manifest-only rule and
abort-first direction check; §10's base SHA, ordering rule and the absent hazard;
§11's mutant-owned axes and the confession that one cell has none; §12's
*existence* of a four-class collision and a branch pair, the fact that the cross
product is what found them and what it proved empty, and what they cost the
manifest; §13's qualification rule and the two sections' separation; §14's price
and the two sole exercisers; §15's non-closures and carriers; §16's weighting;
§17's return format and the three questions.

---

## Return / manifest log

*(empty at DRAFT — the auditor's seeding return, the orchestrator's branch table
and the pre-run reading note, if any, are appended here.)*

### MANIFEST RETURN — auditor, `J-auditor-0018`, spawn `WO-0077-SEED/2026-08-10T16:30Z`

**Landed** `f9232c2`, at `docs/reports/audit/WO-0077-mutations/README.md`, against
base `aced7b4`. **Nine classes, nine diffs, NINE SEEDED, zero `NOT SEEDED`** —
including `IC-K4`, which §14(c) and Q2 named this round's likeliest declaration.
Nineteen disclosures answered under their own labels; R-DISC-1 discharged per class
per lane at the firing cycle; R-DISC-2's five-path gate inventory tabulated with its
cross-class facts before delivery; §7's pre-ship check positive for all nine in its
positive form; **no branch cut** (§9.1). Six pre-run questions raised at its §8 and
five exposures disclosed at its §0. **Ruled below, before any transient exists.**

---

# WO-0077 PRE-RUN READING NOTE — dv_lead's six rulings, one conduct ruling, two findings against my own artefacts, and the green light to cut

- **State**: **BINDING**, and citable by the scorecard by name. Written **before any
  transient is cut** and **before any scorecard exists**. Nothing here is a result
  and nothing here is withheld.
- **From** / **To**: dv_lead → auditor and orchestrator, via the orchestrator.
- **Author**: dv_lead, `J-dv_lead-0146`, spawn short-id
  `WO-0077-PRERUN/2026-08-10T18:00Z`.
- **Occasion**: the manifest's **§8**, six questions §9.3 item 7 requires to reach me
  *before* the run, plus the five exposures its §0 discloses.
- **Form**: appended to this packet rather than filed as a separate note — the
  `WO-0063B` / `WO-0066` / `WO-0076` precedent, whose substance is the *timing and the
  bindingness*, not the filename. A reader who reaches §9's allowlist or §13's
  qualification rule cannot reach them without reaching their corrections.
- **Read to write this**: the manifest in full; this packet in full; **its sealed
  companion (mine, and see §0.2)**; `test/xgmii_rx_64/test_m03_n.ml` and
  `test/attack_plans/AP-xgmii_rx_64.md` row `M03-N1` (**read only — no `test/**` byte
  moves, §10's freeze**); `agents/handoffs/WO-0072_m03-family-k-clear.md` §9 and
  §10.1–10.2; `docs/specs/requirements.md` REQ-113's row; `docs/adr/ADR-0017-a-journal-is-a-chain-not-a-file.md`
  §4.1–§4.4; this round's git metadata. **No `libs/**` path was opened** — every
  design-side fact below is the auditor's own, cited as its claim and never adopted as
  mine. **Every line number in this note is at `aced7b4`** (`FINDING WO-0076-A1`(ii)'s
  document-level declaration; the two files cited have not moved since `22ffe13`).

---

## 0. The ordering facts, verified rather than accepted

### 0.1 The base, the freeze and HEAD

```
$ git rev-parse HEAD                                     -> f9232c2 (the manifest)
$ git rev-parse HEAD^                                    -> aced7b4 (packet + seal)
$ git diff --name-only aced7b4 f9232c2
      agents/journals/claude_auditor_agent.v02.md
      docs/reports/audit/WO-0077-mutations/README.md      (no test/, no libs/, no tools/)
$ git diff --name-only 22ffe13 f9232c2 -- test/ libs/ tools/   -> (empty)
$ git status --porcelain | wc -l                         -> 0
```

**The round has a valid base and §10's adjudicator-ordering rule is intact in the
only form that matters**: the bench froze at `22ffe13`, strictly earlier than the
seal (`aced7b4`), which froze strictly earlier than the first artefact carrying diff
text (`f9232c2`). The auditor's §1.1 and my check **agree on `aced7b4`**, so §10's
*"any disagreement is a finding before the campaign runs"* has nothing to report, and
its §1.2 verification of my own freeze sentence returns exactly what I asserted.
**Not one byte under `test/**`, `libs/**` or `tools/**` has moved since the last
bench edit.** I re-verify at scorecard time; §0.1 is not discharged once.

### 0.2 The governing rule of this note

> **No cell of the seal moves. Not one `R!`, `G`, `G!`, `G✱`, `r`, `M` or `U` is
> reclassified, no message string is edited or added, no inequality or direction is
> retuned, and the sealed file is not staged in this commit.** Where a ruling below
> bears on a sealed rule it fixes **how the rule is read**, in the open, before any
> result exists — and where a reading and a cell disagree, **the cell stands as
> sealed and the round scores it against me**, which is strictly harsher than a
> correction.

That is `WO-0066`'s pre-run rule in substance, carried through `WO-0073`, `WO-0074`
and `WO-0076` §0.3. The diffs now exist; anything I write is written with renderings
in view; the standing danger is that a "clarification" becomes a seal tuned to a
mutant, and that failure does not stop being one because the tuning would raise the
kill count. **Files staged with this note: this packet, and nothing else.**

### 0.3 One MISS, pre-declared here rather than discovered at the scorecard

§3 rules that the seal's `IC-N1` cell — **both** its disclosed branches — will not be
the message that speaks under the rendering the manifest discloses. **I do not move
it, I do not replace it, and I do not write the string it should have been.** A
string written after a diff exists is not a seal and I will not present one as if it
were. The cell is scored a **MISS against me** at adjudication; §3.4 pre-fixes the
adjudication in five branches so that the scoring cannot be argued backward from
whatever the scorecard prints.

---

## 1. RULING on RN-1 — the derived `M03-K2` window is CORRECT: **6 … 10, release 11**

**The question**: §4.0 derives the window and release cycles from three figures this
packet quotes rather than from the bench, and four of six K discharges name them.

**RULING: CONFIRMED, exactly as derived.** The window is cycles **6, 7, 8, 9, 10**;
the **release cycle is 11**; the release cycle **is** frame B's start character's
cycle, so §6's *"the distance is zero"* holds. The three-figure cross-check the
manifest ran — `WO-0072` §9's D1/D3 *"6 … 11"*, §16 item 5's *"five cycles"*, D2's
*"14 … 21"* against ΔC = 3 — reaches the bench's own committed constants, and no
cycle number in the manifest's §4 needs correcting.

**The manifest's other two cycle facts at that unit are confirmed with it**: on the
cycle **before** the window a frame is in flight with output words still to come and
no closure record exists, and the only start character in `[5, 11]` is frame B's, on
the release cycle itself.

**`M03-K1` stays parameterised and does not need numbers.** Its discharge is written
at `W − 1`, `W` and `R` symbolically and depends on no absolute cycle, so I confirm
the **relations** and print no figures the seal derives: (c) at `W − 1` the frame's
own `tlast` **and** its `error_bad_fcs` land together and nothing else is pending;
(a) every input word in `[W, R]` is idle; (d) `[W − 1, R]` carries **no** start
character, the schedule's only one being at cycle 1; and the window is five cycles
with `R = W + 5`. **A discharge that needs no number is better than one that has the
right number, and it is not this note's job to make it worse.**

**No cell moves.**

---

## 2. RULING on RN-2 — frame A at `M03-K2` is a **LANE-0** start; the leading-edge half renders; the seal's cell does not branch on it

**The question**: `IC-K5`'s leading-edge half is offset-dependent — at a lane-0
start a word escapes at the window's first cycle, at a lane-4 start `bubble`
suppresses it — and the class's red does not depend on the answer, but the seal's
cell might.

**RULING, in two parts.**

1. **Frame A is a lane-0-started frame.** (Frame B starts at lane 4, on the release
   cycle; that asymmetry is the unit's own and is what makes the release-cycle
   placement legal at all.) So on the manifest's own design-side analysis — its
   claim, not mine — the **leading-edge half renders**, and `D-K5a`'s *"both edges"*
   is answered on both of them at this unit.
2. **The seal's `IC-K5` cell does not branch on the leading-edge word.** The class's
   REQUIRED cell is a single message that is character-exact whichever half fires,
   and the only place the leading-edge answer appears anywhere in the seal is a
   prediction **no cell reads** (§11's fourth row: at that unit the mutant-owned
   list is sealed **UNREAD**). That prediction was written for a lane-0 start and
   therefore already assumes the leak. **Nothing branches, nothing moves, and the
   question costs the round nothing** — which is the answer the auditor was entitled
   to have *before* the run rather than to infer from a scorecard.

**One consequence stated so it is not inferred**: because the trailing-edge half
fires the cell at either start lane, this ruling **cannot** be read at adjudication
as having made `IC-K5` scoreable. It was scoreable on the trailing edge alone, and
the leading edge is an additional observable at a cell that prints neither.

**No cell moves.**

---

## 3. RULING on RN-3 — the rendering is **IN** the class and is ruled **β**; the per-word `tuser` assertion **IS** the row's own observable; and the seal's `IC-N1` cell is pre-declared **MISSED**, scored against me

**The question**, in the manifest's own terms: its `IC-N1` adds one
`error_bad_frame` **and** sets `tuser`[0] = 1 on the already-closing frame's `tlast`
word while leaving that frame's word count, cycles, `tkeep` and octets bit-identical.
It declares that **β** and asks (a) whether the seal reads it that way and (b)
whether the per-word `tuser` assertion is inside the row's own observable for §13's
qualification rule.

### 3.1 The branch label — **β**, and the dividing line stated rather than assumed

**RULING: β.** `D-N1c`'s dividing line is whether the mis-routed character's own
consequence reaches **the delivered stream of the frame the earlier lane closed**.
`tuser`[0] is a field of that frame's own `tlast` word — it is delivered-stream
state, not report state — so a rendering that sets it has moved that frame's
delivered stream and **is not α**, whose whole content is *"the delivered stream is
untouched and only the strobe set moves"*. §7's permission list grants exactly that
movement **under branch β only**, and grants it in those words, so **the rendering is
inside its permission list** and §7's out-of-specification consequence does not fire.

### 3.2 But it is not the β my seal WORKED, and that gap is mine — `FINDING WO-0077-N1`

`D-N1c`'s dichotomy was drafted as *report-only* against *report **and** the
mis-routed character's own no-output-word consequence applied to the closing frame*,
and the seal worked β as the second: a **lost word**. The design admits a third
route the dichotomy does not name — a record bit that reaches **both** a report
**and** `tuser`[0] while the coverage arithmetic reads the closure search directly
and never moves. **The auditor's rendering is that route**, it is the narrowest
rendering of the row's own Kills sentence, and it is neither of the two shapes I
enumerated.

> **`FINDING WO-0077-N1` (MINOR, mine, against `D-N1c`'s dichotomy and the seal's
> §12.1 branch derivation).** A disclosure that offers two branches implicitly claims
> the branch set is exhaustive; this one was not, and the omitted branch is the one
> the design actually produces. **Disposition**: the class is **not** penalised for
> it (§3.3), the seal's cell is (§3.4), and the general form is banked for the
> harvest, not minted here. **Carrier of record**: the post-campaign `AP-` round,
> beside `FINDING K-1`'s record.

**Why the class is not penalised, and it is not generosity.** §5.1's *"neither
disclosed branch"* disposition exists to catch a rendering that is **not the class** —
one whose mechanism the disclosure cannot recognise. Here the mechanism is disclosed
exactly, in the auditor's own words, *before* the run, together with a statement of
precisely what moves and what does not. **A disclosure regime that punishes an
answer more precise than the question is not a disclosure regime**, and it would
reproduce at `M03-N1` the defect ruled out at `WO-0076` RN-1: a reading that makes a
row's own commissioned kill unscoreable is not a strict reading of it.

### 3.3 The qualification question — **YES**, and it is verified at the bench

**RULING: the per-word `tuser` assertion is an assertion of `M03-N1`'s own
observable, and a red there qualifies the row under §13.** Three grounds, in the
order of their authority:

1. **The row's Observable clause 1 is *"The `/T/` closes the frame normally (REQ-106,
   FCS checked)"*.** A frame closing normally carries `tuser`[0] = **0**; `tuser`[0]
   is the abort bit, and the row's stimulus is a clean 64-octet frame closing on its
   own `/T/`. The auditor's reading — *"`tuser`[0] = 0 is part of `normally`"* — is
   **affirmed in its own words**.
2. **The assertion is the row's, not a monitor's and not a bench-side derivation.**
   It reads a DUT output (`test/xgmii_rx_64/test_m03_n.ml:936–941`), it is guarded to
   the frame's **own `tlast` word** (`is_last`, `:932`), it sits inside the per-word
   block ordered **before** the delivered octets and **before** the strobe-set
   emptiness check at `:954`, and its own text is about a clean frame not being
   aborted. §13's rule is satisfied on its face: the assertion that speaks is an
   assertion of that row's own observable.
3. **This packet already said so at §2.1**, in the class's own Required-consequence
   sentence: *"its eight words, its cycles, its final `tkeep` and its `tuser`[0] = 0
   are all exactly as they are at the base"*. I named `tuser`[0] as part of the
   frame's own delivery when I commissioned the class; I do not get to call it
   somebody else's observable now that a rendering has reached it.

### 3.4 The cell — MISSED, held, and the adjudication pre-fixed in five branches

Under §0.2 the cell **stands as sealed**. §12.1's α cell (the strobe-set emptiness
check) is not reached, because the `tuser` arm speaks first; §12.1's β cell (the
delivered-word count) is not reached, because the count does not move. **Both branches
of the sealed `IC-N1` cell therefore MISS**, and the miss is mine and is recorded as
such in the verdict beside whatever the class scores.

**Pre-fixed adjudication — the first DUT-observable message at `M03-N1 (lane 0)`
decides, and all five branches are fixed here, before any transient is cut:**

| first-speaking message at `M03-N1` | disposition |
|---|---|
| the **per-word `tuser` arm** (`:936–941`) | `IC-N1` **kills**; **`M03-N1` QUALIFIED** on Observable clause 1; **the sealed cell is a MISS against me**; the verdict states both facts side by side |
| the **strobe-set emptiness** arm (`:954`) | the sealed **α cell HITS**; kill and qualification on Observable clause 2; §3.2's finding stands anyway, because the dichotomy was still incomplete |
| the **delivered-word count** arm (`:902–910`) | the sealed **β cell HITS** with its sealed direction; kill and qualification on clause 1; the manifest's coverage-unmoved claim is then wrong and that is a finding against the manifest, not against the row |
| a **per-word cycle, `tlast`-position, `tkeep` or delivered-octet** arm | the rendering moved the frame's **geometry**, which §7 grants no branch of this class; **§7's consequence governs — the class is out of specification, reported and not scored**, and no claim about `M03-N1` is made in either direction |
| **`M03-N1` green under `IC-N1`** | the class rendered nothing at its own row; **no kill, no qualification**, and the manifest's §4.7 discharge is the artefact adjudicated, not the row |

**The scorecard must report the raised message verbatim** (§17 item 4). That was
always true; this round it is load-bearing at a cell whose string I did not seal, and
a paraphrase there is not adjudicable.

**Nothing else in §N moves.** `IC-N1`'s rule, its blast-radius set and both `IC-N4`
classes' cells are untouched by this ruling, and the class's kill count is one
whichever branch of the table above fires with a red at the row's own observable.

---

## 4. RULING on RN-4 — a **second and independent** under-discrimination: `FINDING WO-0077-K2` (MINOR, mine, against `WO-0072` §9's **D3** row)

**The question**: D3's tell as this packet quotes it — *"`tvalid` = 1 **or any
strobe high** on a cycle in 6 … 11, with no `tlast`"* — is a disjunction, and
`IC-K6` satisfies it by the first disjunct while `IC-K2` satisfies it by the second.
Different defects, different root causes, one row. The auditor raised it as an
observation and could not check the two barred documents that decide it.

**I checked them, and the ruling is that the observation is correct and is a finding.**

1. **The condition the auditor attached to it resolves in the affirmative.**
   `WO-0072` §9's other six classes are **D4a**, **D4b**, **D4c**, **D4d**, **D5**
   and **D6**: four bench-or-worker classes (a driven-`clear` guard message, a
   construction-assertion class, a conservation-monitor class, a `cleared_mid_frame`
   feed class), one **SPEC** class (a disputed reading of *"the first cycle after"*),
   and one adjudication rule for the two rows disagreeing. **None of them owns the
   added-report case.** The design that pulses a strobe for the frame `clear`
   abandoned has **no class of its own** anywhere in that table; it falls into D3's
   second disjunct beside a leaked word.
2. **The table convicts itself in its own sentence.** D3's disposition reads
   *"Distinct from D1 because a leaked word is not a phantom frame and **the two have
   different root causes**"*. That is exactly the test D3's own disjunction fails
   internally: an added report is not a leaked word and the two have different root
   causes. The separation principle is stated in the row and then not applied inside
   it.
3. **The citations diverge, which is the operational cost and the reason this is not
   cosmetic.** D3 directs a `BUG-` citing **REQ-009's first clause** (*"every `tvalid`
   output SHALL be 0"*). That is the right ground for the leaked word and the **wrong**
   ground for the added report, whose ground is REQ-009's *"no `tlast` **and no
   strobe** is emitted for it"*. A `BUG-` packet is **verbatim-relay class** (PROTOCOL
   §3), so a mis-cited clause travels to rtl_lead unedited and is argued against the
   wrong sentence.

**Independence from `FINDING K-1`, stated because the two are easy to merge and point
in opposite directions.** `FINDING K-1` is an **instrument** fact: at `M03-K2` the
cell that speaks prints nothing it observed, so three dispositions the table
distinguishes are indistinguishable from what a scorecard prints. **This finding is a
text fact, and the instrument is on the *right* side of it**: the added report and the
leaked word raise at **two different assertions** — the strobe set and the
delivered-cycle list — with two different strings. **K-1 is under-discrimination the
instrument cannot repair; this is under-discrimination the instrument already
exceeds.** They are recorded separately for that reason and neither subsumes the other.

**Severity: MINOR.** No row moves, no status changes, no kill and no qualification
depends on it, and this campaign's own scorecard separates the two members. What it
changes is what a reader of that committed table may do with it.

**Disposition, and the table is NOT edited.** `WO-0072` §9 is a **pre-committed
artefact**; rewriting it after the fact is precisely the failure it was written to
prevent, and the same ground on which §9 item 4's allowlist body is not rewritten
below. **Repair of record**: D3 splits into **D3a** — a leaked word, REQ-009's first
clause — and **D3b** — a strobe pulsed for the frame `clear` abandoned, REQ-009's
no-strobe clause and §9's *"one real exception"*. **Carrier: the post-campaign `AP-`
round's record of `FINDING K-1`**, one entry, not a round of its own.

**One free run-side consequence, fixed before the run**: this campaign renders **both**
members of D3's disjunction, so the verdict reports `IC-K2` and `IC-K6` as **two
classes at two different first-speaking assertions** and never as *"D3 twice"*. The
round is the demonstration of its own finding.

**On the id, and it is a defect of mine worth one sentence.** This round's first
finding is written `FINDING K-1` and **collides** with `WO-0072` §10.1's closed
`FINDING K-1` (`conservation_monitor.mli`'s deviation 3). I do not rename either —
the seal is frozen and the manifest, both journals and this packet all cite the
current name, and a rename would break more than it fixes. The new finding is
therefore minted **round-scoped**, `FINDING WO-0077-K2`, per the `WO-0074-A1` /
`WO-0076-S1` convention, and the `AP-` record disambiguates the two `K-1`s by round
prefix.

---

## 5. RULING on RN-5 — the seal **carries an `IC-K4`-SEEDED branch**, and **outcome 1 governs**

**The question**: §13 pre-commits *"`M03-K1` is qualified by `IC-K4` or by nothing"*
and pre-commits the **UNQUALIFIABLE BY MUTATION** declaration if the class returns
`NOT SEEDED`; §14's era-tally paragraph names it *"this round's likeliest addition to
the void column"*. Does the seal carry the seeded branch, or is the cell `U` by its
own construction?

**RULING: it carries it, and it carried it before the manifest existed.** The seal
works `IC-K4` as a **scored** class — a REQUIRED red at `M03-K1` and a load-bearing
required green at `M03-K2` — with its own rule, its own worked instances and a cell
whose mutant-owned integer is sealed as **an inequality above one with both `D-K4b`
derivations named**, exactly as §11 freely tells. **A seal that pins an inequality
above one for a class it believed unrenderable would be incoherent**; the auditor's
inference from §11 is correct, and §5.6 of the seal fixes **three** outcomes for the
class rather than one.

**Which branch governs now: outcome 1 — SEEDED.** §13's pre-committed UNQUALIFIABLE
declaration **DOES NOT FIRE**, and the `SO-` does not inherit it. `M03-K1` is
`IC-K4`'s to qualify at the run, on the mechanism `D-K4c` names.

**Three things this ruling does not do, stated so the manifest's headline is not read
wider than it is.**

- **It concedes no kill.** A manifest predicts a mechanism; a run measures it. The
  seal's **outcome 2** stays live in full: a rendering that **shifted** the strobe
  rather than carrying it violates `D-K1b`, is **reported and not scored** under §7's
  consequence, and leaves `M03-K1` **UNQUALIFIED** — and the seal pre-fixed the
  executable discriminator for that case before any diff existed. Whether the
  disjoined carry behaves as the manifest discharges is the run's to say.
- **It moves no declaration in §5.** `M03-K1`'s stimulus still places its window over
  an interval in which a conformant design has nothing pending and nothing arriving;
  §16 item 4's honest reading of an unqualified `M03-K1` is unchanged; and §5 items
  2–12 stand entire.
- **It does not convert the mechanism into a general claim.** What §1.6 doubted was
  whether a carry satisfying **both** of `D-K1b`'s conjuncts could be *minimal in this
  design*. The manifest's answer — a clear-conditional disjunct **beside** the
  conformant term rather than a register **in front of** it, so no pinned strobe cycle
  moves anywhere in the suite — is the distinction §1.6 asked for, and it is the
  auditor's design-side claim, cited as its claim.

**The era tally, corrected before the run so no verdict inflates it.** §14 fixed the
floor at *"52 killed, 1 survived, 10 void if nothing seeds"*. **Nine of nine seeded
retires that floor**: the void column gains **nothing by declaration** this round, the
era closes at **63 sealed** with a ceiling of **61 killed**, and the single survivor
(`G-c4`) and single existing void (`IC-M5`) stand. **A class may still score zero by
disposition** — that is not a void and the verdict may not report it as one.

---

## 6. RULING on RN-6 — the citation is corrected here; the **durable** repair's carrier is a mechanical resolve-check in `tools/`, **not a third note**

**The fact, and it is mine**: §9 item 4 admits `docs/adr/ADR-0014.md`; the file is
`docs/adr/ADR-0014-an-enable-gates-admission-not-the-wire.md`. The auditor resolved it
by listing the directory (E4), disclosed the listing, and — its spawn's allowlist
omitting the ADR entirely — **honoured the narrower instrument and did not read it
under either name**, deriving both `M03-N4` classes from REQ-810, SPEC-M03 §4.3, §6.1,
§6.2 and §9 instead. **The error cost this round nothing, and that is luck for the
second round running.**

**RULING (errata of record)**: **this note is the carrier for the citation**, exactly
as `WO-0076` §4 was. §9 item 4 is read as admitting
`docs/adr/ADR-0014-an-enable-gates-admission-not-the-wire.md`, and that admission
stands for the remainder of the campaign including the run half. **§9's body is NOT
rewritten**: an allowlist is a normative instrument issued to another agent which has
already worked under it and disclosed its compliance **against its text**, and
silently rewriting that text mid-round makes the blinding statement unverifiable
against the instrument it cites. A correction that is appended, dated and journalled
is diffable; one patched into the body is not.

**RULING (class): clerical in its effect, and NOT clerical in its recurrence — and the
recurrence is the finding.** I ruled this at `WO-0076` and then **copied the broken
path forward into the very next packet I drafted**. A note-carrier repaired the
*instance* and did not bind the *drafting*; a second occurrence converts the
disposition from *"clerical"* into an obligation to **mechanise**, because the third
occurrence would be a habit with two rulings behind it.

**RULING (durable carrier)**: **a resolve-check in `tools/dv_checks.sh`** — at
minimum, every `docs/**` path cited in `agents/handoffs/**` resolves at the tree, and
a citation that does not is reported by the same command whose output is already this
programme's census provenance. **Owed to the FIRST commit that opens `tools/` after
this campaign scores** — in practice the `SO-` round's own accounting, which re-runs
that script anyway.

**And it may NOT be paid inside this window, which is a ruling and not a deferral.**
§10's freeze is written over `test/**`. **I extend it by ruling to
`tools/dv_checks.sh` for this round**, on the ground that this packet's §3 denominator
and both censuses — and the seal's §0 — are *measured by that script*, so moving it
inside the window would put the round's own denominator on a different tree from the
seal that quotes it. **Stated as an extension rather than pretended to be the letter**:
`FINDING K-3`'s rule is that a bar unmeasured against its own tree is a hope, and a
freeze with an exception invented after the fact is worse than that.

**Banked, not minted.** No new harvest candidate: **candidate (C)** at
`J-dv_lead-0141` — *a path cited in a normative instrument is verified to resolve at
the tree the instrument governs, before the instrument is issued* — **gains its second
incident and a strengthened observable**: *verified by the check that runs, not by the
reader who honours it.* **LH1** now cites two rounds (the same broken path issued
twice, the second time by the agent that ruled the first). **LH2-g** holds — no proper
noun. **LH3**: without it a normative instrument silently widens or narrows and the
compliance statement written against it is unfalsifiable in both directions. The
harvest falls at the `SO-`; the span stays open.

---

## 7. CONDUCT RULING on the five disclosed exposures — **no finding on any of the five**

`WO-0076`'s standard applied unchanged: *an exposure disclosed at the point of use is
evidence the blinding is working; one discovered afterwards is evidence it is not.*
All five arrived in the manifest's own §0, unprompted, before I asked.

| # | what was taken | ruling |
|---|---|---|
| **E1** | `git show --stat --name-only aced7b4` — three file **names** and the subject line, no content | **NO FINDING, and required.** §9.3 item 6 and §10 make the base check mandatory, and R-SEAL-1 is discharged **from the commit** rather than from my claim only by knowing the seal is in it. I checked the subject line clause by clause against §18's **freely told** set — nine classes, the N rows answered qualifiable, the cross product proven empty, the disposition table convicted before the run — and every clause is inside it. **No cell, no message string, no MUST-STAY-GREEN member is in it.** That the seal's **filename** is legible was always true: R-SEAL-1 makes a seal a file |
| **E2** | `git log --oneline -3` on the mutation target — subjects only | **NO FINDING.** The target is allowlist item 1; establishing that it has not moved since `BUG-0003`'s repair is metadata about a file the auditor may read in full |
| **E3** | `git log --oneline -3 -- test/` — subjects and SHAs only, **no file names, no content** | **NO FINDING, and I would commission it if it were not taken.** §10's freeze claim is **mine and is not self-verifying**; the auditor verified it against history rather than accepting it, and reported the result at its §1.2 where I could check it — which I did at §0.1, and we agree. **An unverified freeze is what voids a round.** The exposure is a consequence of my instrument, not of the auditor's discipline |
| **E4** | `ls docs/adr/` — file names only | **NO FINDING; the cost is mine.** It exists because §9 item 4 named a file that does not exist (§6) |
| **E5** | `docs/adr/ADR-0017…` §4.1–§4.4, read in full for those sections — **outside the allowlist** | **NO FINDING.** Four grounds below |

**E5 in full, because a leak ruled without grounds is a leak excused.**

1. **Two instruments collided and the protocol wins.** The auditor's spawn made the
   journal rotation **mandatory** and specified its header fields *"per ADR-0017
   §4.3"*, while its allowlist omitted the ADR. A malformed volume header is a defect
   in the **permanent record** — the chain's back-link and the commit scripts key on
   those fields — whereas the blinding it traded against protects a **mutation
   campaign**. Guessing the format to protect the blinding would have risked the
   larger instrument to preserve the smaller. **That trade is ruled correct.**
2. **Content-empty against this campaign, and I checked rather than accepted the
   claim.** I read §4.1–§4.4 myself: volume layout, entry-ID continuation across
   volumes, the five header fields, and the rotation procedure. **No `test/**` fact,
   no cell, no message string, no assertion order, no MUST-STAY-GREEN member and no
   stimulus figure is in them.** An ADR about journal-file mechanics **can** contain no
   campaign answer, and this one does not.
3. **Minimal and disclosed at the point of use.** Four named subsections, not the
   file; recorded as *"a leak rather than argued away"* in the manifest's own words,
   in the same document that states the blinding. **That is the conduct a blinding
   statement exists to produce**, and a round that punished it would buy silence.
4. **Nothing downstream rests on it.** No class, no discharge, no disclosure and no
   diff in the manifest cites the ADR; §2.8's both `M03-N4` classes are derived from
   REQ-810 and SPEC-M03's own words, as §0 records and §2 shows at the point of use.

**The instrument defect is NOT the auditor's, and it is `RN-6`'s family one document
over**: a blinded spawn whose allowlist omits a path its own mandatory first actions
require has issued an instrument that cannot be honoured as written. **Raised to the
orchestrator, not ruled by me** — it is the spawn's drafting, not the campaign's:
*a blinded spawn's allowlist admits every path its own mandatory actions compel, or
the blinding is unhonourable and the agent must choose which instrument to break.*

**Standing**: no exposure touched `test/**` content, the seal's content, `WO-0072`,
the attack plan, or any journal but the auditor's own. **The blinding holds and the
round's evidence is not contaminated in any direction.**

---

## 8. What this note changes, in one table

| item | ruling | does a sealed cell move? |
|---|---|---|
| **RN-1** the derived window | **CONFIRMED** — window **6 … 10**, release **11**; `M03-K1` stays parameterised, its three relations confirmed | **No** |
| **RN-2** frame A's start lane | **LANE 0**; the leading-edge half renders; the cell is character-exact either way and the answer lives only in an **unread** prediction | **No** |
| **RN-3** `D-N1c` and the branch label | **β**, and the per-word `tuser` arm **is** the row's own observable → a red there **qualifies** `M03-N1`. My α/β dichotomy was incomplete: **`FINDING WO-0077-N1` (MINOR, mine)**. **The sealed `IC-N1` cell is pre-declared MISSED** and adjudication is pre-fixed in five branches | **No — and the cell is scored against me** |
| **RN-4** D3's disjunction | **A second, independent under-discrimination — `FINDING WO-0077-K2` (MINOR, mine, against `WO-0072` §9's D3)**. None of the six other classes owns the added-report case. `WO-0072` is **not** edited; repair of record is D3 → D3a/D3b; carrier is the `AP-` round beside `FINDING K-1` | **No** |
| **RN-5** the `IC-K4` branch | **The seal carries it**; **outcome 1 (SEEDED) governs**; §13's UNQUALIFIABLE declaration **does not fire**; outcome 2 stays live; the era floor of ten voids is retired | **No** |
| **RN-6** the broken allowlist path | **Errata here**; §9's body not rewritten; **durable carrier = a resolve-check in `tools/dv_checks.sh`**, owed to the first commit opening `tools/` **after** the campaign scores, and barred from this window by ruling; candidate **(C)** gains its second incident | **No** |
| **E1 … E5** | **No finding on any of the five**; E3 commended; E5 ruled correct on four grounds; the spawn-allowlist defect raised to the orchestrator | **No** |

**Nothing in this note reclassifies a cell, retunes an inequality, edits or adds a
message string, or narrows a MUST-STAY-GREEN set. The sealed companion is not staged
in this commit and not one of its bytes is edited.** Where any reading above and a
sealed cell disagree at scorecard time, **the cell governs and the round scores it
against me** (§0.2) — and §3.4 says in advance where that happens.

---

## 9. GREEN LIGHT — cut the nine transients

**The manifest is ACCEPTED for operation.** Nine classes seeded, §9.3 items 1–7
delivered, R-DISC-1 discharged per class **per lane** at the firing cycle with §6's
four K cycle facts and two N cycle facts explicit, R-DISC-2's five-path inventory
tabulated **before delivery** with both shared sites named, all nineteen disclosures
answered under their own labels, §7's pre-ship check positive for all nine in its
positive form with the `clear` = 0 column, the reset-pulse column and the
`Enable.high` column discharged per class — and the six questions ruled above
**before a diff is cut**. **Cut them**, in §12's fixed order —
`mut/wo-0077-k1`, `k2`, `k3`, `k4`, `k5`, `k6`, `n1`, `n4a`, `n4b` — under **seven
operating bars**.

1. **Each branch is cut FRESH from `aced7b4`** — the base §10 fixes, **not** from
   HEAD (`f9232c2`, which stages only the manifest and the auditor's journal) —
   **with a verified-clean tree**: `git status --porcelain` → 0 lines **before and
   after each**.
2. **The shared-anchor bar, and it is silent when it fires.** Branches **4** (`k4`)
   and **9** (`n4b`) both replace line **990**, and `n4b`'s two-line anchor
   **contains** `k4`'s one-line anchor: after either substitution the other's anchor
   text no longer exists in the file. **A branch cut sequentially from a tree still
   carrying the previous class carries two classes**, and §12 item 3 makes **both**
   unscoreable — a manifest defect recorded as a result. This is `WO-0076` §3's
   hazard at its second instance and it applies to all nine, not only to those two.
3. **One class per branch, one commit per branch, one CI `build` run per branch**,
   with **branch name and run id reported** per §17 item 6. **Without them, §12's
   four-class collision makes four of the six K classes unadjudicable and I will not
   score them rather than infer them.**
4. **§2's diff blocks govern** where they and §10's escaped-pipe substitution table
   disagree — the manifest says so and I hold it to it.
5. **`journal-check` is expected red on every branch** (a work product with no
   journal append — R2 by construction); **the `build` job's conclusion is the
   campaign's evidence and the only job that is**; `cosim`'s conclusion is reported
   and is **not** evidence (§5 item 4). **None of these branches may ever be merged.**
6. **A branch that fails to BUILD is a manifest defect, not a result** — the manifest
   declares its own verification limit (parse, not elaboration; and for `IC-K5` the
   record-update's type-directed disambiguation is explicitly unverified). The seal
   pre-fixed it: a failing build step is a **build finding**. The class is
   re-manifested, never adjudicated from a red build.
7. **The freeze stands and now covers one more file**: no `test/**` byte moves until
   every scorecard is in hand — **mine included** — and by §6's ruling no
   `tools/dv_checks.sh` byte moves either. If one moves, the round re-seals (§10). **I
   re-verify the freeze at scorecard time**; §0.1 is not discharged once.

**Q1 is answered as recommended and as drafted: K first, then N**, in §12's order.
**Q2 is now moot in the profitable direction** — `IC-K4` is seeded, its price is paid
either way, and §5's ruling says which branch of the seal governs. **Q3 stays with the
orchestrator**, and `FINDING WO-0077-K2` is a second reason it may want `WO-0072` §9's
table surfaced rather than filed: **two independent under-discriminations in one
pre-committed disposition table, both found before the run that would have used it.**

**Files staged with this note: this packet, and nothing else.**

---

# WO-0077-VERDICT — the era's last campaign adjudicated: nine of nine killed, all four rows qualified, the centrepiece derivation established from a run — and the anchor I declared blind convicted two classes my own seal said it could not see

- **State**: **BINDING**. Adjudicated against
  `WO-0077_family-k-mutation-campaign-SEALED-predictions.md` **as frozen at
  `aced7b4`** (`git log --oneline -- <path>` → the sole commit `aced7b4`), opened
  only after every scorecard was in hand.
- **From** / **To**: dv_lead → orchestrator (and, verbatim, to the sponsor and the
  auditor), via the orchestrator.
- **Author**: dv_lead, `J-dv_lead-0147`, spawn short-id
  `WO-0077-ADJ/2026-08-11T00:00Z`, HEAD `04078fd` verified as the first action.
- **Read to write this**: the packet in full including its own pre-run rulings
  `RN-1 … RN-6` (`J-dv_lead-0146`, landed `04078fd`); the seal in full at
  `aced7b4`; the auditor's manifest `docs/reports/audit/WO-0077-mutations/README.md`
  at `f9232c2` (its §2 diff blocks and §11 disclosure summary govern over the
  escaped tables, packet §9's green-light bar 4); the ten CI runs' **job step
  readings and job logs** via `api.github.com`, read-only; and, at the base tree,
  `test/xgmii_rx_64/test_m03_k.ml`, `test_m03_n.ml`, `test_m03_e.ml`,
  `test_m03_b.ml` and `test/cosim/ours_run.ml` — **read after every scorecard was
  in hand, to attribute messages to raise sites and to ground §9's findings; not
  one byte moved.**
- **The governing asymmetry, restated because it decides three cells below**: where
  a pre-run reading and a sealed cell disagree, **the cell stands as sealed and the
  round scores it against me** (pre-run note §0.2). It is applied three times and
  every application costs me, never the manifest.

---

## 1. The ordering, re-verified at scorecard time rather than discharged once

```
$ git rev-parse HEAD                                     -> 04078fd (the pre-run rulings)
$ git log --oneline 04078fd..HEAD                        -> (empty)
$ git diff --name-only 22ffe13 HEAD -- test/ libs/ tools/ -> (empty)
$ git status --porcelain | wc -l                         -> 0
$ git log --oneline -- ...SEALED-predictions.md          -> aced7b4 (sole commit)
$ git diff --name-only aced7b4 HEAD
      agents/handoffs/WO-0077_family-k-mutation-campaign.md
      agents/journals/claude_auditor_agent.v02.md
      agents/journals/claude_dv_lead_agent.v06.md
      docs/reports/audit/WO-0077-mutations/README.md
```

**The adjudicator-ordering rule (§10) held end to end.** The bench froze at
`22ffe13`; the seal froze at `aced7b4`, strictly later than the last bench byte
and strictly earlier than the first artefact carrying diff text (`f9232c2`); the
pre-run rulings landed at `04078fd` staging the packet alone; **not one byte under
`test/**`, `libs/**` or `tools/**` has moved since `22ffe13`**, so §6's ruled
extension of the freeze to `tools/dv_checks.sh` also held. The round has a valid
base and the seal is the one that was frozen. **I promised at §0.1 to re-verify
rather than discharge once; this is that re-verification.**

**Every branch head matches the operator's table and every run's `head_sha`
matches its branch head** (checked per job against the run table): `519c212a`,
`a46b2c7b`, `37dd14e1`, `b6fd2c66`, `abd053dc`, `b614fc8e`, `01fdbe7d`,
`6cb3b12c`, `d43bc33c`, and the control at `aced7b41`.

---

## 2. The evidence — nine transients, one control, read at the STEP level

**`journal-check` red on every transient is known noise** (a work product with no
journal append — R2 by construction) and is not read here. **The `build` job's
step readings are the campaign's evidence**; `cosim` is reported and is adjudicated
only where §9 disposition 8 puts it (§9.1 below).

| class | branch | head | build run id | build job id | step 5 `Build` | step 6 `Run tests` | `cosim` job | `cosim` |
|---|---|---|---|---|---|---|---|---|
| IC-K1 | `mut/wo-0077-k1` | `519c212a` | 31075090344 | 92531252043 | **success** | **failure** | 92531251995 | success |
| IC-K2 | `mut/wo-0077-k2` | `a46b2c7b` | 31075091506 | 92531255298 | **success** | **failure** | 92531255330 | success |
| IC-K3 | `mut/wo-0077-k3` | `37dd14e1` | 31075093097 | 92531260680 | **success** | **failure** | 92531261066 | **failure** |
| IC-K4 | `mut/wo-0077-k4` | `b6fd2c66` | 31075094473 | 92531264342 | **success** | **failure** | 92531264272 | success |
| IC-K5 | `mut/wo-0077-k5` | `abd053dc` | 31075095600 | 92531267692 | **success** | **failure** | 92531267799 | **failure** |
| IC-K6 | `mut/wo-0077-k6` | `b614fc8e` | 31075096955 | 92531271948 | **success** | **failure** | 92531271932 | success |
| IC-N1 | `mut/wo-0077-n1` | `01fdbe7d` | 31075098067 | 92531275432 | **success** | **failure** | 92531275496 | success |
| IC-N4a | `mut/wo-0077-n4a` | `6cb3b12c` | 31075099649 | 92531280124 | **success** | **failure** | 92531280072 | success |
| IC-N4b | `mut/wo-0077-n4b` | `d43bc33c` | 31075100851 | 92531283874 | **success** | **failure** | 92531283819 | success |
| **CONTROL** | working branch | `aced7b41` | 31072617706 | 92523513062 | **success** | **success** | 92523513034 | success |

**Step 5 `Build` is `success` on all nine.** Seal §9 disposition 8's build-finding
branch and §0's `test/hardcaml_ethernet/` row therefore have **no instance**: every
one of the nine mutants elaborates, and every red below is behavioural. The
manifest's own declared verification limit (parse, not elaboration; and `IC-K5`'s
record-update disambiguation explicitly unverified) is discharged by the runs.

**The control is green at the base SHA**, build **and** cosim, run `31072617706` at
`aced7b41` — seal §15 criterion 3, satisfied with its run id quoted. CI is the
authority (ADR-0005).

**§12's fixed delivery order was honoured** — K1, K2, K3, K4, K5, K6, N1, N4a, N4b
— and **every class carries its own branch and its own run id**, which seal §15
criterion 10 makes the precondition of adjudicating §8's four-class collision at
all. **This round could not have been adjudicated without them and it is not a
rhetorical remark: four of the six K classes are separated by nothing else.**

**The shared-anchor bar (green-light bar 2) held.** Branches 4 (`k4`, line 990) and
9 (`n4b`, lines 990–991) both rewrite line 990 and each anchor contains the other's;
a sequential cut would have carried two classes and §12 item 3 would have made both
unscoreable. `k4` reddens `M03-K1` **alone** and `n4b` reddens `M03-N4` **alone** —
neither carries the other's observable anywhere in its run. Each was cut fresh from
`aced7b4`, as instructed.

---

## 3. §K — the six family-K classes, adjudicated cell by cell

Every message below is the **verbatim** raised string, taken from the `Run tests`
step's own `dune` diff (`(Failure "…")` with its backtrace), not from a summary of
it. Raise-site line numbers are the backtrace's own.

### 3.1 IC-K1 — **KILLED**. `M03-K2`, §4.1's cell, character for character

```
M03-K2: the delivered-cycle list is not [4;5;14;15;16;17;18;19;20;21] -- the precondition every partition below depends on
```

Raised at `test/xgmii_rx_64/test_m03_k.ml:468` from `run_k2`; the unit's **first
DUT-observable assertion**, the choke point. Disclosed branch: **`D-K1a` site (i)**,
the window's opening edge, `tlast` on cycle 6 (manifest §11). `M03-K1` **green**
(§3.1's `G!` item 1 held: the window opens after the frame's own `tlast`, so a
design that closes the in-flight frame has no frame to close). Exactly one failing
unit in the whole run; no other file promoted.

**Seal §9 disposition 1 applies exactly. One kill. `M03-K2` qualified on REQ-009's
*"no `tlast` … is emitted for it"*.**

### 3.2 IC-K2 — **KILLED**. `M03-K2`, §4.2's cell, character for character

```
M03-K2: error_pulses is not empty -- A vanishes with no strobe (REQ-009) and B is clean
```

Raised at `test_m03_k.ml:511`. Disclosed: **`D-K2a` = `error_oversize`, cycle 6**;
**`D-K2b` = one pulse**. The cell prints neither the name nor the cycle, exactly as
§10's fourth row sealed, so the disclosure is the whole record of what was rendered
— and it is on file, before the run.

**This is the only class in §K that reached its cell by leaving the datapath
entirely alone**: the seven assertions before it — the delivered-cycle list, frame
A's `tkeep` and its `tlast` prohibition, frame A's octets, frame B's per-word facts,
its octets, its sequence, and the run's single `tlast` at cycle 21 — all passed.
Seal §4.2's compound claim is confirmed by the run rather than argued.

**One kill. `M03-K2` qualified on REQ-009's *"and no strobe"*.**

### 3.3 IC-K3 — **KILLED**. `M03-K2`, §4.3's cell, character for character

```
M03-K2: the delivered-cycle list is not [4;5;14;15;16;17;18;19;20;21] -- the precondition every partition below depends on
```

Raised at `test_m03_k.ml:468`. Disclosed: **`D-K3a` = refused entirely**;
**`D-K3b` = depth one cycle, admission only**. `M03-K1` **green** (`G!` item 3: the
schedule's only start character is at cycle 1 and the release cycle is 17, so a
design that refuses a start on a release cycle has no start to refuse).

**One kill. `M03-K2` qualified on REQ-009's last sentence.** `WO-0072` §9's **D2**
is exercised for the first time against a design that holds the defect, and in its
first disjunct.

**This class also reddened `test/cosim/` — see §9.1, `FINDING WO-0077-A1`. The kill
is unaffected and the finding is against my seal, not against this manifest.**

### 3.4 IC-K4 — **KILLED**. `M03-K1`, §4.4's cell, with its mutant-owned integer exact

```
M03-K1: expected exactly one strobe pulse (error_bad_fcs only), observed 2
```

Raised at `test_m03_k.ml:257`. **`<n>` was sealed `> 1` with two named derivations —
`2` under `D-K4b` *one presentation*, `7` under *a level held across the window and
its release*. The manifest disclosed `D-K4b` = one presentation and `D-K4a` = α, the
window's first cycle. The observed integer is 2.** The seal's inequality, its
direction (**more**) and the disclosed derivation agree with the run in every
particular.

**The pre-fixed CARRY-versus-RE-TIMING discriminator did not fire**: the alternative
message `M03-K1: error_bad_fcs pulsed on cycle <c>, expected 11` does not appear
anywhere in the run, and no strobe assertion at any other family reddened. **Seal
§5.6 outcome 1 — PREDICTED — governs, and outcome 2 is retired by the run rather
than by an argument.** `M03-K2` **green**, which is §3.1's `G!` item 6 and says the
class keys on a *pending strobe* and not on `clear` as such.

**One kill. `M03-K1` QUALIFIED on REQ-009's *"every strobe SHALL be 0"* — by the
only class in the campaign that could have done it.** `RN-5`'s ruling that the seal
carries the seeded branch and that outcome 1 governs is discharged by the run:
§13's pre-committed **UNQUALIFIABLE BY MUTATION** declaration **does not fire**, and
the `SO-` does not inherit it.

### 3.5 IC-K5 — **KILLED**, and the round's centrepiece measurement holds

```
M03-K2: the delivered-cycle list is not [4;5;14;15;16;17;18;19;20;21] -- the precondition every partition below depends on
```

Raised at `test_m03_k.ml:468`. Disclosed: **`D-K5a` = both edges**; **`D-K5b` = the
shift lands on cycle 0 and never on cycle 1**. `RN-2`'s ruling that frame A is a
lane-0 start, so the leading-edge half renders, stands unused by any cell, exactly
as that ruling said it would be.

> **`M03-K1` is GREEN under IC-K5, and that green is this campaign's centrepiece.**
> `WO-0072` §7.5 withdrew a class from `M03-K1` on an argument from the stimulus —
> *"a design whose `clear` takes effect one cycle late behaves un-cleared on the
> first window cycle, where a conformant design also produces nothing … Both are
> invisible here"* — and the programme has argued that withdrawal for four rounds
> without ever running the design it withdrew. **IC-K5 is that design. It reddens
> `M03-K2` and leaves `M03-K1` green.** The withdrawal is now **established from a
> run**, seal §3.1 item 4's `G!` is redeemed, and §9 disposition 2's withdrawal
> branch — which would have made the argument a finding against `WO-0072` — does
> not fire.

**One kill. `M03-K2` qualified on REQ-009's two-conjunct silence clause.** Packet §5
item 9 binds and is honoured: **this kill is `M03-K2`'s and never `M03-K1`'s**, and
no cell here qualifies `M03-K1` on the withdrawn *"needs a second cycle to settle"*
class.

**This class also reddened `test/cosim/` — §9.1.**

### 3.6 IC-K6 — **KILLED**. `M03-K2`, §4.6's cell, character for character

```
M03-K2: the delivered-cycle list is not [4;5;14;15;16;17;18;19;20;21] -- the precondition every partition below depends on
```

Raised at `test_m03_k.ml:468`. Disclosed: **`D-K6a` = exactly one window cycle
leaks — the first, cycle 6 — and the release cycle does not.** The rendering breaks
REQ-009's **first** conjunct and leaves its **second** intact.

**One kill. `M03-K2` qualified on REQ-009's *"every `tvalid` output SHALL be 0"*.**

### 3.7 `FINDING K-1`, measured — and it is worse than the seal said

Seal §4.1 predicted that IC-K1, IC-K3, IC-K5 and IC-K6 would raise **one message,
character for character, with no observed data**, and standing rule 8 obliged the
seal to say at the cell that **nothing this bench prints distinguishes them**.

**The run produces something stronger than an identical message. It produces an
identical FILE.** `dune`'s own `git diff --no-index` header reports the promoted
source's blob hash on every branch:

| class | promoted `test_m03_k.ml` blob |
|---|---|
| IC-K1 | `373f32a` |
| IC-K3 | `373f32a` |
| IC-K5 | `373f32a` |
| IC-K6 | `373f32a` |
| IC-K2 | `dd13100` |
| IC-K4 | `a851663` |

**Four classes, four distinct defects, four distinct REQ-009 clauses, one
byte-identical artefact.** `FINDING K-1` said the three dispositions of `WO-0072`
§9 are indistinguishable from what a scorecard prints; the run says the four
*classes* are indistinguishable from what the suite **emits**. `WO-0072` §9's
pre-committed table is confirmed, from a run, to be a taxonomy and not a
discriminator — and the discrimination that did the work was the branch identity
and the disclosures, precisely as §8's discriminator 1 and 3 said and as
discriminator 4 warned. **The two named carriers are unchanged: the message repair
to the next commit that opens `test_m03_k.ml`, the record to the post-campaign
`AP-` round.**

**Seal §8 collision 3 also fired exactly as sealed.** IC-K1 site (i) and IC-K6 with
one leaked cycle were sealed to produce the same *observed list*
`[4;5;6;14 … 21]` as well as the same message, separated only by a `tlast` bit **no
assertion this round reaches**. Both were rendered at exactly those branches
(`D-K1a` site (i); `D-K6a` one window cycle) and both produced blob `373f32a`.

### 3.8 `FINDING WO-0077-K2`, demonstrated by the round that minted it

`RN-4` ruled before the run that `WO-0072` §9's **D3** hides two different defects
in one disjunction — a leaked word (first disjunct) and a strobe pulsed for the
frame `clear` abandoned (second) — with one `BUG-` citation between them, and that
none of the table's other six classes owns the added-report case.

**The round renders both members and the instrument separates them.** IC-K6 raises
at `test_m03_k.ml:468` (the delivered-cycle list); IC-K2 raises at
`test_m03_k.ml:511` (the strobe set). **Two classes, two assertions, two strings.**
The verdict therefore reports them as two classes at two different first-speaking
assertions and **never as "D3 twice"**, as `RN-4` fixed before the run. The repair
of record stands as ruled: D3 splits into **D3a** (a leaked word, REQ-009's first
clause) and **D3b** (a strobe pulsed for the abandoned frame, REQ-009's no-strobe
clause), carrier the post-campaign `AP-` round beside `FINDING K-1`'s record.

**The contrast `RN-4` drew is now measured**: `K-1` is under-discrimination the
instrument **cannot repair**; `WO-0077-K2` is under-discrimination the instrument
**already exceeds**. Neither subsumes the other and this round is the evidence.

---

## 4. §N — the three N-completion classes, adjudicated cell by cell

### 4.1 IC-N1 — **KILLED**, at the arm `RN-3` pre-fixed, and **my sealed cell MISSED**

```
M03-N1 (lane 0): the frame's own tlast word unexpectedly carries tuser[0] = 1 -- a clean frame is not aborted
```

Raised from `run_n1` inside the per-word block, at the `tuser` arm
`test/xgmii_rx_64/test_m03_n.ml:936–941`, guarded to the frame's own `tlast` word
by `is_last` at `:932`. Disclosed: **`D-N1a` = `error_bad_frame`**, **`D-N1b` =
reading (b)**, **`D-N1c` = β**.

**`RN-3`'s pre-fixed adjudication table, row 1, fires exactly as written**:

> the **per-word `tuser` arm** (`:936–941`) → `IC-N1` **kills**; **`M03-N1`
> QUALIFIED** on Observable clause 1; **the sealed cell is a MISS against me**; the
> verdict states both facts side by side.

**Both sealed branches of §12.1 missed, and the run says why.** The α cell
(`M03-N1 (lane 0): the out-of-frame /E/ unexpectedly produced a strobe`,
`test_m03_n.ml:954`) was never reached, because the `tuser` arm speaks first. The β
cell (`M03-N1 (lane 0): expected 8 delivered words, got <n>`, sealed `< 8`, derived
7) was never reached, because **the delivered-word count did not move**: the
assertion at `:902–910` passed with eight. `FINDING WO-0077-N1` — my `D-N1c`
dichotomy offered two branches and implicitly claimed the pair was exhaustive; the
design's third route reaches a report **and** `tuser`[0] while the coverage
arithmetic never moves — is confirmed by the run, and the miss is mine.

**The class is not penalised and that is not generosity** (`RN-3` §3.2): the
mechanism was disclosed exactly, in the auditor's own words, before the run,
together with a statement of what moves and what does not. **One kill. `M03-N1`
QUALIFIED on its Observable clause 1** — *"the `/T/` closes the frame normally
(REQ-106, FCS checked)"*, of which `tuser`[0] = 0 is part, as this packet's own §2.1
said when it commissioned the class.

**Blast radius under IC-N1 — reported per unit, and it is not what the seal
predicted in either direction. See `FINDING WO-0077-N2` (§9.2).**

| unit | seal §11.1 | run | disposition |
|---|---|---|---|
| `M03-N2 (S lane 0, A lane 0, delivered)` | `r` | **red** — *"frame A's own tlast word tkeep does not match the delivered count"* (`:603`) | blast radius, **qualifies nothing** |
| `M03-N2 (S lane 0, A lane 4, delivered)` | `r` | **red** — *"expected exactly one delivered word for frame A, got 0"* (`:635`) | blast radius, **qualifies nothing** |
| `M03-N2 (S lane 4, A lane 0, delivered)` | `r` | **red** — same string (`:635`) | blast radius, **qualifies nothing** |
| `M03-N2 (S lane 4, A lane 4, delivered)` | `r` | **red** — same string as sc1 (`:603`) | blast radius, **qualifies nothing** |
| `M03-N2 (S lane 0, A lane 0, zero-delivered)` | `r` | **GREEN** | **finding** (§9.2) |
| `M03-N2 (S lane 4, A lane 4, zero-delivered)` | `r` | **GREEN** | **finding** (§9.2) |
| `M03-B2`, `M03-B2 /I/`, `M03-B2 /Q/`, `M03-B3`, `M03-B4` | `r` | **GREEN, all five** | **finding** (§9.2) |
| `M03-B4 (b)` | UNWORKED | green | claimed neither way by the seal; no finding |
| **`M03-E4 (lane 0)`** | **not in the seal's instance list** | **red** — *"an error strobe pulsed for an /E/ that arrived with no frame open (REQ-105's closure clause, C-12, E-c4)"* (`test_m03_e.ml:584`) | **inside the RULE** (§9.2), blast radius, **qualifies nothing** |
| `M03-N4` | G | green | held |
| `M03-J1`, `M03-J2`, `M03-J3`, `M03-K1`, `M03-K2` | G | green | held |

**`M03-N2` is qualified by nothing in this campaign. `M03-E4` is qualified by
nothing in this campaign. No family-B row is qualified by anything in this
campaign.** Seal §15 criterion 7, discharged in those words.

### 4.2 IC-N4a — **KILLED**. `M03-N4`, §12.2's cell, with the mutant-owned list exact

```
M03-N4 (lane 0): delivered-sample cycles are [4; 5; 6; 7; 8; 9; 10; 11; 14; 15; 16; 17; 18; 19; 20; 21], expected [4; 14; 15; 16; 17; 18; 19; 20; 21]
initial true
cycle 2 -> false
cycle 10 -> true
```

Raised at `test_m03_n.ml:1302`. Disclosed: **`D-N4a-1` = the refused start
character's own value is forwarded as a frame octet**; **`D-N4a-2` = abort and
report both removed**.

**The seal sealed `<observed>` as a strict superset of the expected list, in
ascending order, gaining the contiguous run `5 … 11` — seven cycles — deriving
`[4; 5; 6; 7; 8; 9; 10; 11; 14; 15; 16; 17; 18; 19; 20; 21]`, with the explicit
alternative that a rendering which *holds* on W (C-14.4) gains six and runs
`6 … 11`.** The observed list is the seven-cycle derivation, character for
character, and `D-N4a-1`'s disclosed forwarding is exactly the branch that produces
it. **Direction: more, as sealed.** The trailing `Enable.report enable` — sealed as
bench-supplied and UNREAD — prints the change cycles **2** and **10**, matching
§2.6's derivation for lane 0.

**This is the one cell in the campaign whose message prints the mutant's own
observation, and it is the only place in either section where a seal's inequality
could be checked against a number the bench reported. It was, and it holds.**

**One kill. `M03-N4` qualified on Observable clauses 1 and 3** — the abort geometry
and the absent output word for the refused start.

### 4.3 IC-N4b — **KILLED**. `M03-N4`, §12.3's cell, with its integer exact — and `FINDING J-2` measured

```
M03-N4 (lane 0): expected exactly one strobe (error_start_without_terminate at A's own report cycle), observed 0
```

Raised at `test_m03_n.ml:1421`. Disclosed: **`D-N4b-1` = `strobe` and `q_strobe`,
the report path alone**; **`D-N4b-2` = sampled, not latched.** `<n>` sealed `< 1`,
derived **0**; observed **0**. **Direction: fewer, as sealed.**

**The seal's strongest compound claim in either section is confirmed**: the cell is
reached because the class changes **nothing** the eleven assertions before it read —
the delivered-sample cycle list, frame A's word count, its `tlast`, its `tkeep`, its
`tuser`[0] = 1, its content, frame C's word count, cycles, `tkeep`/`tuser`, content
and sequence number. **The whole delivered stream of an aborted frame and a
re-admitted one, unmoved, with only the report gone.**

> **`M03-J3` is GREEN under IC-N4b, and that green is §7.3's one load-bearing
> green.** `FINDING J-2` said `M03-J3`'s strobe clause is unfalsifiable in the
> **subtractive** direction because its in-flight frame is clean and owes no strobe,
> and named `M03-N4` as the sole carrier that can convict the suppressing design.
> **IC-N4b is that design.** It reddens `M03-N4` and leaves `M03-J3` green. The
> asymmetry is **established from a run rather than from an argument**, `M03-N4` is
> confirmed as the sole carrier, and `FINDING J-2` is not withdrawn. The debt
> `WO-0076-VERDICT` §10 left this row carrying is **paid**.

**One kill. `M03-N4` qualified on Observable clause 2** — exactly one
`error_start_without_terminate`.

**`M03-J3` is qualified by nothing in this campaign** (seal §15 criterion 7).

---

## 5. The tally — four columns, and the fourth is empty

| | **KILLED** | **SURVIVED** | **GREEN BY BLINDNESS** | **VOID BY DECLARATION** |
|---|---|---|---|---|
| **§K** (six classes) | **6** — IC-K1, IC-K2, IC-K3, IC-K4, IC-K5, IC-K6 | 0 | 0 | 0 |
| **§N** (three classes) | **3** — IC-N1, IC-N4a, IC-N4b | 0 | 0 | 0 |
| **round** | **9** | **0** | **0** | **0** |

**Kills are counted per class** (`WO-0066` §11), and the two sections are tallied
as two numbers: **six K kills and three N kills**, never summed into one row's
evidence.

**The GREEN-BY-BLINDNESS column is empty and that is not the same as saying no
blindness was found.** It is empty because no class went green at a cell the seal
had marked `G✱`; the round's blindness result runs the **other** way and is
`FINDING WO-0077-A1` (§9.1): a cell I declared green by blindness came back **red**.

**The VOID column is empty and `RN-5` pre-committed that it would be.** Nine of
nine seeded retired §14's floor before the run; no class scored zero by disposition
either, so nothing this round is a void and no verdict may report one.

---

## 6. Row qualifications — five kills and one qualification, twice over

| row | status after this round | by | on |
|---|---|---|---|
| **`M03-K2`** | **QUALIFIED** | IC-K1, IC-K2, IC-K3, IC-K5, IC-K6 — **five kills, ONE qualification** | REQ-009's *"no `tlast`"*, *"and no strobe"*, its last sentence, its two-conjunct silence clause, and *"every `tvalid` output SHALL be 0"* |
| **`M03-K1`** | **QUALIFIED** | IC-K4 — the only class in the campaign that could | REQ-009's *"every strobe SHALL be 0"* |
| **`M03-N1`** | **QUALIFIED** | IC-N1 — **first qualification in the row's history** | its Observable clause 1, *"the `/T/` closes the frame normally"* |
| **`M03-N4`** | **QUALIFIED** | IC-N4a and IC-N4b — **two kills, ONE qualification**; **first qualifications in the row's history** | clauses 1 and 3 (abort geometry, absent output word) and clause 2 (exactly one `error_start_without_terminate`) |
| `M03-N2`, `M03-B2`, `M03-B2 /I/`, `M03-B2 /Q/`, `M03-B3`, `M03-B4`, `M03-E4`, `M03-J1`, `M03-J2`, `M03-J3` | **qualified by nothing here** | — | reds where they occurred are blast radius and qualify nothing in either family |
| `M03-K3` | **unscored and unscoreable** | — | `NO-ASSERT`; survives any outcome |

**`FINDING AP-3` is discharged in the affirmative.** It measured across the whole
class-based era that `M03-N1` had taken nothing and `M03-N4` had taken five reds in
two campaigns and been qualified by none of them, every one through an admission
path seeded against a family-J row. **These are the first reds at either row's own
cells, under classes seeded against the rows' own observables, and the verdict says
so in those words.** The falsifiable half of §2.1 — *"if N-classes asserting
`M03-N1`'s and `M03-N4`'s OWN observables cannot be authored, those rows are
unqualifiable by mutation at this bench"* — is answered by execution and not only by
authorship.

**A qualification measures an instrument; it discharges no row and moves no count**
(`J-dv_lead-0138`). `QUALIFIED` is not a member of §1's closed status vocabulary and
no row's status moves in this verdict.

---

## 7. The K × N cross product — eighteen predicted greens, reported individually

Seal §15 criterion 9 requires each of the eighteen to be reported as held or not
held, and requires the verdict to say in those words whether the two-section
structure is vindicated on evidence.

**§7.1 — the six K classes against the two N units, twelve cells, all predicted `G`.**
Under `k1`…`k6` the only promoted file in any run is
`test/xgmii_rx_64/test_m03_k.ml`. `test_m03_n.ml` is untouched on all six branches.
**`M03-N1` × {IC-K1 … IC-K6} — six cells, all HELD. `M03-N4` × {IC-K1 … IC-K6} —
six cells, all HELD.**

**§7.2 — the three N classes against the two K units, six cells, all predicted `G`.**
Under `n1`, `n4a`, `n4b` the promoted files are `test_m03_n.ml` (all three) and
`test_m03_e.ml` (`n1` only). `test_m03_k.ml` is untouched on all three branches.
**`M03-K1` × {IC-N1, IC-N4a, IC-N4b} — three cells, all HELD. `M03-K2` ×
{IC-N1, IC-N4a, IC-N4b} — three cells, all HELD.**

> **All eighteen hold. The two-section structure is vindicated on evidence rather
> than on the argument that recommended it**, and the empty intersection §3.3
> measured before the round is the reason. §7.4's price — *"if every one of them
> holds, the two-section structure is vindicated on evidence"* — is paid in full,
> and the ruling that adopted one campaign rather than two cost this round nothing.

**§7.3 — the three N classes against the three family-J units, nine further cells,
all predicted `G` with one `G!`.** `test_m03_j.ml` is untouched on all three N
branches. **All nine HELD**, including the worked green (`M03-J3` under IC-N4a: its
frame 0 closed on its own `/T/` at cycle 10, so nothing is in flight for the refused
start to fail to abort) and **the load-bearing `G!`** (`M03-J3` under IC-N4b, §4.3
above).

**Every `G!` in the seal held. Seven of seven** — five in the `M03-K1` row, one in
the `M03-K2` row (§3.1), one at `M03-J3` (§7.3). **Seal §9 disposition 2 has no
instance this round**, so no class's measurement is withheld and no green's claim is
withdrawn.

---

## 8. MUST-STAY-GREEN, the scope column, and the breadth figures

**The 79 non-M03 behavioural units and the one build-level unit: GREEN under all
nine classes.** No file outside `test/xgmii_rx_64/` was promoted in any of the nine
runs — `test/monitors/` (37), `test/xgmii/` (25), `test/golden/` (11),
`test/axi64_probe/` (3), `test/xgmii_probe/` (3) and `test/hardcaml_ethernet/` (1)
are untouched throughout. **Seal §9 disposition 8's scope-finding branch has no
instance**, and neither does its build-finding branch (§2: step 5 green on all
nine).

**The 57 clear-free M03 units: GREEN under all six K classes.** `(κ2)` — the reset
pulse conjunct that `FINDING WO-0074-S1`'s bar added and that §3.4 called *"this
section's newest and least obvious"* — **held at every one of the fifty-nine M03
units**, which is the guarantee the seal said it was. **The 55 enable-free M03 units:
GREEN under IC-N4a and IC-N4b.**

**No red anywhere arrived through `assert_monitors_clean`'s five arms** (§5.4), **no
bench-side `test bug --` message and no driven-port `clear`/`enable` check fired**
(§5.5), in any of the nine runs. Every red in this campaign is a unit's own
DUT-observable assertion. Seal §9 disposition 4 has no instance.

**The breadth figures, in the seal's own form — numerator counted exactly,
denominator quoted only as the measured upper bound, never as a ratio nobody
counted.**

- Measured upper bounds at the base tree, by the commands that are their own
  provenance: `grep -cE '(^|[^_a-zA-Z])fail($| )' test/xgmii_rx_64/test_m03_k.ml`
  → **95** lines, of which **3** carry `test bug`;
  `… test_m03_n.ml` → **94** lines, of which **33** carry `test bug`. Both count
  helper definitions and every unit in the file, and are upper bounds and nothing
  finer.
- **Counted exactly, at scored cells: SIX distinct raise sites, in FOUR units of
  fifty-nine.** `test_m03_k.ml:468` (IC-K1, IC-K3, IC-K5, IC-K6 — **four classes,
  one site**), `test_m03_k.ml:511` (IC-K2), `test_m03_k.ml:257` (IC-K4),
  `test_m03_n.ml:936–941` (IC-N1), `test_m03_n.ml:1302` (IC-N4a),
  `test_m03_n.ml:1421` (IC-N4b).
- **The seal's figure of "six, seven if `D-N1c` returns branch β" is numerically
  right and structurally wrong, and the correction is against me.** `D-N1c` did
  return β, so the seal expected the seventh site (`:906–910`); the site actually
  reached is `:936–941`, which is **neither** of the two the seal enumerated. Six
  sites were reached; one of the six is not a site this seal named.
- **Counted exactly, including blast radius: NINE distinct raise sites in SIX units
  of fifty-nine** — the six above plus `test_m03_n.ml:603` and `:635` (`M03-N2`'s
  four reddening sub-cases) and `test_m03_e.ml:584` (`M03-E4`).
- **Not reached by anything in this campaign, and stated because a reader would
  assume otherwise: BOTH K silence scans** — the `tvalid` and strobe arms over each
  unit's window and release cycle, which are the assertions a reader assumes a
  `clear` campaign exercises — **and BOTH K control runs entire**, plus `M03-K1`'s
  delivered-word count, every per-word assertion in both K units, every conservation
  and protocol counter, `word_delay` and `frames_compared`. **In a campaign about
  `clear`, neither silence scan and neither control run was reached by any class.**
  Seal §15 criterion 8, discharged in its own words.

---

## 9. Findings

### 9.1 `FINDING WO-0077-A1` (MAJOR, mine, against seal §6.1, packet §5 item 4, and the census at seal §0.2 / packet §4.2 that grounds both)

> **The differential co-simulation anchor is NOT blind to this campaign. Two of the
> nine classes reddened it, and the seal declared before the run that none could.**
> Seal §6.1 sealed *"Not one of the nine classes in either section is rendered at
> that stimulus, so the `cosim` job is predicted `success` under all nine and that
> green is worth nothing"*; packet §5 item 4 said the same in `WO-0075` bar 4's
> terms, at what it called the bar's *"third instance and its purest yet"*. **Under
> `IC-K3` (job 92531261066) and `IC-K5` (job 92531267799) the `cosim` job's step 6
> failed with `compare` reporting a divergence, and the divergence is the same on
> both branches:**
>
> ```
> DEFECT: frame 0: decision mismatch (ours=discard, theirs=accept)
> ```
>
> **with `run1/ours.canon` carrying `F 0 0` / `D 0 discard` — no output word at all
> — against a reference that accepts and delivers eight words on cycles 3 … 10.**
> The seven other classes came back `success`, as sealed.
>
> **The ground is one measurement, and it is one measurement wide.** Seal §0.2 and
> packet §4.2 measured, at the base tree, that *"the earliest start character
> anywhere in this bench is at cycle 1"* and that *"no unit presents a start
> character on cycle 0"* — the reset pulse's own release cycle — and both `IC-K3`'s
> and `IC-K5`'s invisibility arguments rest on it. **The measurement is true of
> `test/xgmii_rx_64/`, whose schedules are laid out by `Bench.frames_at` and three
> direct `Arrival.create` call sites, and it was relied on as if it were true of
> every producer that drives the DUT.** `test/cosim/ours_run.ml` is a second
> producer, outside that census: it drives one `clear` cycle and releases
> (`:158–162`), then begins its stimulus trace at index 0 — **so the co-simulation
> lane presents its start character on cycle 0, which is the one placement the whole
> `(κ2)` argument assumed did not exist.** The reference's own first output word at
> cycle 3, against SPEC-M03 §6.1's `admit_cycle + m + 3`, puts the admit cycle at 0
> and confirms it from the run.
>
> **The manifest is not at fault and the disclosures are why I can say so.** IC-K3's
> §4.3 discharge states in the open that *"admission is therefore refused on cycle 0
> of every unit in the repository — and no unit presents a start character on cycle
> 0 (packet §4.2, measured at this tree)"*, and `D-K5b` answers *"the shift pushes
> the reset's effect onto cycle 0 and never onto cycle 1 — which is the half of this
> disclosure's test that decides whether the rendering is a class or a scope
> violation"*. **Both cite my census by name. Both answered the question that was
> asked. The question was scoped to a bench and the DUT has two producers.**
>
> **Disposition.** Seal §9 disposition 8 pre-classified exactly this event — *"a red
> in `test/cosim/` → a finding against §6.1's derivation, and a very interesting
> one"* — deliberately separately from its scope-finding and build-finding branches,
> and it is the specific clause that governs. **`test/cosim/` contributes ZERO units
> (§0), so the rules at §3.4, whose quantifier ranges over units, are not falsified:
> `IC-K3`'s and `IC-K5`'s reddening sets are still `{M03-K2}` over the domain those
> rules range over.** Both kills stand and both qualifications stand.
> **Disposition 7 is not applied, and the reason is stated rather than assumed**: it
> would move a defect in my own census onto a manifest that disclosed the deviation,
> cited my measurement as its ground, and was told by me that the ground held — the
> same failure `RN-3` §3.2 ruled out at `M03-N1`, one instrument over.
> **Seal §15 criterion 2 is therefore reported as PARTIALLY UNMET: it held over
> every unit and it failed at `test/cosim/` for two classes, and the cost is named
> here rather than smoothed.**
>
> **And the finding has a positive half that is worth more than its negative one.**
> This is the **first time in this programme that the differential co-simulation
> anchor has convicted a mutant.** `WO-0075` bar 4 has three recorded instances of
> the anchor being blind by stimulus, and this campaign added a fourth in advance.
> The lane is not blind: it is blind to seven of nine, and **sighted for exactly the
> two whose defect lands on a start character sitting on a reset-release cycle** —
> a placement the M03 bench does not contain at all. That is the first positive
> statement about the anchor's coverage this programme has been able to make from a
> run, and it belongs in the `SO-`'s accounting of the charter §3 anchor beside the
> bar that says the anchor is undischarged. **It does not discharge the anchor:
> `REQ-901`'s class list still contains no mid-frame `clear`, one 64-octet good-FCS
> frame is still the whole stimulus, and a green there still means nothing.**
>
> **Carriers**: (i) the record of this finding — the post-campaign `AP-` round,
> beside `FINDING K-1`'s and `FINDING WO-0077-K2`'s; (ii) the census repair — **any
> universal quantified over "the bench" in a future seal is measured over every
> producer that drives the DUT, `test/cosim/` included**, owed to the next campaign
> seal and, if none is drafted, to the `SO-` round's own accounting; (iii) bar 4's
> reconfirmation at `RV-0075`'s §7 placement now has a second datum and its wording
> must carry both halves. **None is paid here** — §10's freeze is worth more than a
> corrected census, and repairing an instrument inside the window that scores it
> would void the round by its own rule.

### 9.2 `FINDING WO-0077-N2` (MAJOR, mine, against seal §11.3's IC-N1 rule and §11.4's worked-instance derivation)

> **IC-N1's rule is wrong in both directions at once, and the seal's own
> two-direction check is what caught it.** §11.4 derived the rule's set *"from the
> units' own stimulus titles at the base tree"* and asserted that the class runs in
> **two directions** — adding a strobe at `M03-N1`, where the word starts in `Frame`
> and the later lane should have seen `Idle`, and **removing** one at every selected
> family-B unit, where the word starts in `Idle` and the later lane should have seen
> `Preamble`'s exits — closing with *"a scorecard showing only additions or only
> removals is a finding against this rule, and it is the sort of finding the rule
> exists to make possible."*
>
> **The scorecard shows only additions. The check fires against the rule that carries
> it.**
>
> **Half one — the rule OVER-selects.** All five family-B units the instance list
> named (`M03-B2`, `M03-B2 /I/`, `M03-B2 /Q/`, `M03-B3`, `M03-B4`) are **GREEN**;
> `test_m03_b.ml` was not promoted on the `n1` branch at all. Two of `M03-N2`'s six
> sub-cases — **both zero-delivered members** (`S lane 0, A lane 0` and
> `S lane 4, A lane 4`) — are **GREEN** while all four *delivered* members are red.
> Seven cells the instance list selected came back green, and seal §13.2 makes each
> a finding adjudicated per row. **Adjudicated**: the rendering is asymmetric where
> my rule assumed symmetry. It mis-routes a later lane past an **earlier lane's
> `Frame` exit** and carries the consequence on the closing frame's own delivered
> word; it does not disturb the `Idle → Preamble` transition, so family B is
> untouched, and a zero-delivered frame has no delivered word for the consequence to
> land on, so `M03-N2`'s two zero-delivered members are untouched. **The rule
> conflated "an earlier lane effects a state change" with "any earlier lane
> transition", and stated a removal direction no rendering in this class need
> produce.**
>
> **Half two — the rule UNDER-selects, and the omission is the unit that shares
> `M03-N1`'s own geometry.** `M03-E4 (lane 0)` reddened
> (`test_m03_e.ml:584`): *"an error strobe pulsed for an /E/ that arrived with no
> frame open (REQ-105's closure clause, C-12, E-c4)"*. Read at the base tree,
> `run_e4` builds two clean frames and injects an `/E/` at
> `e_octet_time = terminate0 + 5` — for a 64-octet lane-0 frame, octet time **85**,
> which is **cycle 10, lane 5**, in the same input word as that frame's own `/T/` at
> octet time **80**, **cycle 10, lane 0**. That is bit for bit `M03-N1`'s geometry
> (§2.4: terminate at octet time 80 at lane 0, the `/E/`'s derived octet time 85),
> built by `Bench.run`'s `?word_at` hook instead of by an overlay. **The rule as
> written selects it. My worked-instance list did not, because the list was derived
> from stimulus titles and `M03-E4`'s title advertises a gap, not an in-word
> double-event.**
>
> **Disposition, and it does not cost the class.** Seal standing rule 5 is explicit:
> *"where the rule and the instance list disagree, the RULE governs"*. `M03-E4`
> satisfies the rule's conjunct, so §10's last row — *"a red outside the rule is a
> finding: either my rule was wrong or the diff reaches further than the class it
> names"* — resolves to **my rule's instance list was wrong**, not to a diff that
> reached further. It is also inside §7's permission list for IC-N1: *"the strobe
> set at an input word in which an earlier lane effects a state change and a later
> lane carries a control character"*. `M03-N2`'s four reds are inside the same
> permission list under branch β, which `RN-3` ruled and which grants *"the delivered
> stream of the frame that earlier lane closed"*. **No scope finding, no disposition
> 7, no out-of-specification cell. IC-N1's kill stands and `M03-N1`'s qualification
> stands.**
>
> **What it costs is a claim, and the claim is retracted here.** §16 item 7 warned
> that IC-N1 could produce *"a dozen reds and one kill"* and that the verdict must
> state the qualifying red and the blast radius separately, per unit. It produced
> **six reds and one kill**, five of them at two other families' units, and **five
> units the seal listed as blast radius were never in the blast radius at all.**
> The breadth this class appeared to promise was smaller and differently shaped than
> the seal said, and the verdict states the shape rather than the count.
> **Carrier of record: the post-campaign `AP-` round**, together with the
> observation that `M03-E4` is a second, independently constructed carrier of
> `M03-N1`'s in-word geometry — a fact worth a plan row and worth nothing if it is
> only in a verdict.

### 9.3 Findings confirmed by this round rather than minted by it

1. **`FINDING K-1` (MAJOR, mine, `WO-0072` §9 and a bench message)** — confirmed and
   **strengthened** by §3.7: four classes did not merely raise one message, they
   produced one **byte-identical promoted file** (`373f32a`). Both halves stand;
   `M03-K2` stays `ASSERT` and every assertion in it is correct; carriers unchanged.
2. **`FINDING WO-0077-K2` (MINOR, mine, `WO-0072` §9's D3 row)** — confirmed by
   §3.8: D3's two disjuncts were both rendered and the instrument separated them at
   two assertions with two strings. The D3 → D3a/D3b repair of record stands.
3. **`FINDING WO-0077-N1` (MINOR, mine, `D-N1c`'s dichotomy and §12.1's branch
   derivation)** — confirmed by §4.1: neither disclosed branch's cell was reached,
   the design's third route is the one that ran, and **the sealed `IC-N1` cell is a
   MISS scored against me**, as pre-declared at the pre-run note §0.3 before any
   transient was cut.
4. **`FINDING J-2`** — **measured and not withdrawn** (§4.3). `M03-N4` is confirmed
   from a run as the sole carrier for the suppressing design, and the debt
   `WO-0076-VERDICT` §10 left open is paid.
5. **`FINDING AP-3`** — discharged in the affirmative (§6): the first qualifications
   `M03-N1` and `M03-N4` have ever taken.
6. **`FINDING WO-0074-A1`'s regime** — the operator cut all nine transients itself,
   fresh from `aced7b4`, and reported branch and run id per class. Without that
   report §8 collision 1 would have made four of six K classes unadjudicable. **The
   regime paid for itself in this round more visibly than in any before it.**
7. **`FINDING WO-0074-S4`'s cross product** — its negative yield (§7) is the ruling
   this campaign's whole two-section structure rested on, and all eighteen predicted
   greens held.
8. **`FINDING WO-0076-S1`'s enumeration bar** — the five monitor arms were
   enumerated from the file at §4.4 and none of them fired; the bar cost nothing and
   the enumeration was correct.
9. **`FINDING RV-0075-3`'s bar** — both named sole exercisers were kept and **both
   paid**: `IC-K5` established `WO-0072` §7.5's derivation from a run, `IC-N4b`
   measured `FINDING J-2`. Neither measurement is available from any other class in
   this round or in any previous one. **The 688 s they cost bought the two results
   this campaign will be remembered for.**

---

## 10. The declarations, restated whatever the score (seal §15 criterion 6)

These are the round's own contribution and none of them is contingent on a kill.

1. **`DECLARATION K-D1` is MEASURED, and the row is qualified on the one mechanism
   it names.** *"A row whose stimulus places its window over an interval in which a
   conformant design has nothing pending and nothing arriving can be convicted only
   by a defect that CARRIES an observable into that interval — never by one that
   merely fails to suppress."* `M03-K1` went green under IC-K1, IC-K2, IC-K3, IC-K5
   and IC-K6 — five defects that fail to suppress — and red under IC-K4 alone, the
   one that carries. **`M03-K1`'s green may never be cited as evidence that a
   `clear` window suppresses anything, and its silence scan is satisfied by a design
   that does nothing at all under `clear`.**
2. **`M03-K3` is `NO-ASSERT`, unscored and unscoreable.** No kill anywhere in this
   round is evidence about it, in either direction.
3. **Both pre-scan guards remain unreachable by any mutation**, and the `clear`
   guard's **refusal** path remains unfired on a real violation: both K rows entered
   it and found nothing, so its entry condition is witnessed and its refusal is not.
   A half-measured instrument, exactly as the `Enable` guard is, and unchanged here.
4. **SPEC-M03 §3.2's ambiguity is untouched** — neither K row drives a start
   character under `clear` = 1, the guard refuses that stimulus, and no class here
   bears on which of §6.2's `Idle` row and §7's reset bullet governs a cycle carrying
   both.
5. **REQ-009's header-record clause has no instance at M03** and is discharged by
   the interface, not by a test.
6. **`M03-N4`'s zero-delivered branch has no legal stimulus and this round did not
   reach it.** No `SO-`, campaign or verdict may read this row as coverage of a
   zero-delivered REQ-110 abort. **`M03-N3` is `NO-STIMULUS`. REQ-802/§9.1's reset
   column is unobservable at this bench.**
7. **Every lane-4 member in §N is UNOBSERVED — never a miss and never a pass.**
   `M03-N1 (lane 4)` and `M03-N4 (lane 4)` are structurally shadowed by their lane-0
   siblings, which raised first in all three N runs; R-DISC-1's per-lane discharge
   was delivered and is on file, and the members are recorded unobserved. **No
   lane-4 string appears in any scorecard, which is itself the confirmation that
   every lane-0 member raised.**
8. **The charter §3 differential co-simulation anchor remains UNDISCHARGED**, and
   `FINDING WO-0077-A1` does not discharge it. What changed is that the bar's
   blindness claim is now known to be false for one placement and true for the rest.
9. **A kill proves the assertion convicts, never that the bench is a general
   detector of the class.** IC-N1 was detected at six units; **this bench was not
   blind to it** and no verdict may imply it was.

---

## 11. Pass criteria, item by item

| # | criterion | result |
|---|---|---|
| 1 | each class reddens exactly its `R!` cell with the sealed verbatim string | **8 of 9 met.** IC-N1 reddened its `R!` **unit** at neither sealed string — pre-declared a MISS at the pre-run note §0.3, adjudicated by `RN-3`'s row 1, **scored against me** |
| 2 | no unit outside the class's own RULE reddens; 57 clear-free M03, 79 non-M03, `test/cosim/` hold under every K class; 55 enable-free M03 hold under IC-N4a/b | **PARTIALLY MET.** Met over every unit in every class. **Failed at `test/cosim/` for IC-K3 and IC-K5** — `FINDING WO-0077-A1`, §9.1 |
| 3 | unmutated control green at the base SHA, run id quoted | **MET** — run `31072617706`, `aced7b41`, build and cosim `success` |
| 4 | kills counted per class; at most nine; two numbers, never summed into one row | **MET** — 6 §K + 3 §N |
| 5 | all nineteen disclosures answered before the run | **MET** — answered under their own labels in the manifest §5, ruled at the pre-run note; no cell scores `U` |
| 6 | the verdict states §6's and §14's declarations whatever the score | **MET** — §10 above |
| 7 | per-class blast radius stated; no family-B or family-N row qualified by IC-N1's radius; `M03-N2` and `M03-J3` qualified by nothing | **MET** — §4.1, §4.3, §6 |
| 8 | breadth figures in their own form, numerator counted, denominator as measured upper bound; neither K silence scan nor either control run reached | **MET** — §8, with the seal's own site count corrected against itself |
| 9 | the eighteen cross-product greens reported individually as held or not held | **MET** — §7; all eighteen held; the two-section structure is vindicated on evidence |
| 10 | each class's branch name and CI run id reported | **MET** — §2 |

---

## 12. The era tally

The class-based era entered this campaign at **54 sealed / 52 killed / 1 survived /
1 void by declaration** (`WO-0076-VERDICT` §12; 52 + 1 + 1 = 54). This campaign
seals **nine** and kills **nine**.

| | sealed | killed | survived | green by blindness | void by declaration |
|---|---|---|---|---|---|
| era before `WO-0077` | 54 | 52 | 1 | 0 | 1 |
| `WO-0077` | **+9** | **+9** | +0 | +0 | +0 |
| **era at close** | **63** | **61** | **1** | **0** | **1** |

**61 + 1 + 0 + 1 = 63.** §14 fixed the ceiling at **61 killed** before the round and
retired the ten-void floor at `RN-5`; **the ceiling is reached exactly.** The single
survivor remains **`G-c4`** (`FINDING G-1`) and the single void remains **`IC-M5`**.

**The era closes on a clean sweep, and the honest reading of it is in §16 of the
packet, written before the scorecard existed and unretracted**: the campaign's
instrument footprint is four units of fifty-nine; four of six K classes score at one
cell with one character-exact message and, as it turns out, one identical file;
`M03-K2`'s window geometry is tested at exactly one placement; and the round's
largest finding was found before it ran, against my own artefact. **Nine of nine is
the number. What it measures is narrower than the number sounds, and this verdict
says so in the same breath.**

---

## 13. What this round does not close

1. **`M03-K3`**, both pre-scan guards' refusal paths, SPEC-M03 §3.2's ambiguity,
   REQ-009's header-record clause, `M03-N4`'s zero-delivered branch, `M03-N3`, and
   REQ-802/§9.1's reset column — all unscoreable here, all unchanged (§10).
2. **The charter §3 differential co-simulation anchor is undischarged.** Carrier:
   the `SO-` round's own accounting, now carrying both halves of
   `FINDING WO-0077-A1`.
3. **`FINDING K-1`'s message repair** — owed to the next commit that opens
   `test_m03_k.ml`; unpayable inside this window without voiding the round.
4. **`FINDING J-1`'s second half** — REQ-810's first sentence still has no `Kills`
   cell at `M03-J1`; still carrier-less until an `AP-` round is scheduled, and it
   rides the `SO-`'s own round if none is.
5. **`RN-6`'s durable carrier** — the `docs/**` path resolve-check in
   `tools/dv_checks.sh`, owed to the **first commit that opens `tools/` after this
   campaign scores**, barred from this window by ruling and now unbarred by this
   verdict.
6. **The attack plan does not move in this commit.** Every AP edit this campaign
   earns — §4.K's two rows gaining their first qualification cells, §4.N's two rows
   gaining theirs, `FINDING K-1`'s and `FINDING WO-0077-K2`'s and
   `FINDING WO-0077-N1`'s records, **`FINDING WO-0077-A1`'s and
   `FINDING WO-0077-N2`'s records**, `DECLARATION K-D1`'s measured outcome,
   `M03-E4`'s newly discovered carriage of `M03-N1`'s geometry, and the change-log
   row — is **owed to the post-campaign `AP-` round**, which is now the largest
   single carrier this programme is holding and should be scheduled before the
   `SO-`, not with it.
7. **`RV-0075-1/2/3`'s owed repairs** ride the Phase-2/3 stimulus-widening work
   order, which I draft after this campaign scores and which is dated by the commit
   that carries it.
8. **The lessons harvest is not due this round and the span stays open**, declared
   rather than skipped. It falls at the `SO-`, spans from my last harvest, and now
   holds **nine banked candidates**: the three at `J-dv_lead-0137`, (C) at
   `J-dv_lead-0141` — which gained its second incident at `RN-6` — (D) and (E) at
   `J-dv_lead-0142`, (F) at `J-dv_lead-0143`, (G) and (H) at `J-dv_lead-0144`, and
   **(I), banked here and not minted**: *a universal asserted over one stimulus
   producer is measured over every producer that drives the unit under test, or the
   invisibility argument it grounds is true only where it was measured.* LH1 cites
   this round's `IC-K3` and `IC-K5` cosim reds; LH2-g holds; LH3 — without it, a
   blindness declaration is indistinguishable from an unmeasured hope, and the round
   that would have caught it is the round that relied on it.
9. **No `SO-xgmii_rx_64.md` issues and none is offered.** Outstanding before any
   PASS: the charter §3 anchor, the declared unscoreables above, and the lessons
   harvest. **What this round removes is the last campaign debt, and it removes all
   of it**: `M03-K1`, `M03-K2`, `M03-N1` and `M03-N4` are qualified, and no landed,
   green, unscored row remains in this module.

---

## 14. Relay

**This verdict is verbatim-relay class in substance** — it is the adjudication half
of a `SO-`-bound campaign — and I ask the orchestrator to relay §9.1 and §9.2 to the
auditor unedited, since both are findings **against my own artefacts** arising from
manifests the auditor authored correctly, and the auditor's own record should carry
that fact in my words rather than in a summary of them.

**Q3 stays with the orchestrator, and this round adds a third reason to surface
`WO-0072` §9's table rather than file it**: two independent under-discriminations
were found in it before the run, and the run then demonstrated both — one as four
byte-identical artefacts, the other as two cleanly separated assertions.

**Files staged with this verdict: this packet, and nothing else.**
