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
