# WO-0061: the family-I qualification campaign — ten seeded defects against the five rows that assert an absence

- **State**: **DRAFT — FROZEN, awaiting seeding.** Predictions were frozen
  before any diff existed; nothing below may be revised once seeding starts.
- **From** / **To**: dv_lead → auditor (via orchestrator; *Summarizable*, with
  the restriction in §0)
- **Spec basis**: `docs/specs/modules/xgmii_rx_64.md` §6.1 (the **drain
  derivation** and its tight ΔC − 1 bound, the **gapless** qualifier, and the
  ruled **D(m)** at `1f3c04c`), §6.2's **`Frame` row** — the hold rule and its
  exit column — §6.3 items 3 and 5, §7, §9's closure list, §10's REQ-016,
  REQ-109 and REQ-113 hooks; `docs/specs/requirements.md` REQ-016, REQ-109,
  REQ-113, REQ-107, REQ-108, REQ-103, REQ-106, REQ-011, REQ-019, REQ-008,
  REQ-005, §0.3, §0.5 (the **deciding input word**, re-ruled at `1f3c04c`),
  §0.6; carry-forwards **C-14.3**, **C-14.4**, **C-18**, **C-45**, and the
  **M03-N3** injection constraint.
- **Subject under test**: **not M03.** Five committed units of
  `test/xgmii_rx_64/test_m03_i.ml` — **M03-I1, M03-I2, M03-I3, M03-I4,
  M03-I6** — and whether they have teeth.
- **Base SHA**: **`42b9df3`**. It is the SHA the green control run actually
  executed — CI run **30920890962**, **both** jobs green (`build` including its
  Generate-RTL and determinism steps, and the blocking `cosim`). Recorded for
  completeness and measured rather than assumed: `git diff 42b9df3 172347c --
  test/ libs/ tools/ dune-project` is **empty** — the one commit after the base
  moves an orchestrator journal only — so the compiled surface at the base is
  the compiled surface at the branch head, and no byte-identity inference is
  needed anywhere in this packet.
- **Why now**: family I is complete and green (`J-dv_lead-0092`), its two red
  rows discharged by two design fixes (`BUG-0002`, `BUG-0003`) and one
  specification re-ruling (**SCR-M03-I4**, `a77017c` then `1f3c04c`). It is the
  **first family in this programme whose rows survived a design round**, and
  the question a qualification campaign exists to answer is therefore sharper
  here than anywhere before it: *are these rows detectors, or did they merely
  hold a red somebody else fixed?*

## 0. What is sealed, what is published on purpose, and the discipline this packet stands under

Predictions live in
`agents/handoffs/WO-0061_family-i-mutation-campaign-SEALED-predictions.md`,
**staged in this same commit** — R-SEAL-1 (ADR-0016, PROTOCOL §10) makes that
constitutional, and this packet asserting a seal without one would be the defect
that rule exists to prevent. The freeze lands **before any manifest diff
exists**, which is the form every campaign since WO-0055 has used.

**Do not open it until all ten diffs are committed.**

This campaign runs the **intents-public / mapping-sealed** protocol. **Sealed**:
which units redden per class, which must stay green, the exact failure messages,
and the branch each disclosure selects. **Published**: the ten intents below,
the scored set, the denominators, the constraints, and every process rule.

The informative outcome remains a mutation that reddens the **wrong** unit, or
none.

### 0.1 Adjudicator RTL exposure — the standing discipline, per `RV-0060-VERDICT` §11

`RV-0060-VERDICT` §11 ruled this for the next campaign packet, which is this
one. It is reproduced here as the packet's own standing discipline, and it binds
every round that follows.

**The independence bar is on *test derivation*, not on *adjudication*, and the
two are separated by ORDERING rather than by pretence.**

1. **The safe form is mechanically checkable**: the bench that judges a mutant
   must be **frozen at a SHA strictly earlier than any RTL it judges**. Here
   that is structural rather than argued — every mutation branch is
   `42b9df3` + one diff, so every bench blob under `test/**` at every mutant is
   **byte-identical to its blob at the base**, and the base precedes every
   mutant commit. The check is one command per branch:
   `git diff 42b9df3 <mutation-branch> -- test/` must be **empty**.
2. **Two bars stay absolute.** (i) tb_writer's work orders omit RTL **and** omit
   the journal entries that quote it. (ii) **In a mutation campaign the
   adjudicator does not read the manifest's patch bodies before the seal
   freezes** — there the seal is the instrument and exposure destroys it. This
   packet and its seal are committed *before* the auditor is spawned; the first
   time I may read a diff of this campaign is after the seal is in history.
3. **Declared for this freeze**: writing this packet I read `test/**` (the bench
   under test, the monitors, the XGMII stimulus libraries), `docs/specs/**`,
   `test/attack_plans/AP-xgmii_rx_64.md`, prior packets and my own journal.
   **I opened no file under `libs/**`, `top/**`, `bin/**`, `rtl_snapshots/**` or
   `docs/reports/audit/**` at any revision in this spawn.** Every message in the
   seal is derived from the bench's own committed control flow and from the
   specification; none is derived from the design.
4. **One exposure disclosed rather than smoothed, because it is real and a
   reader will find it.** `test_m03_i.ml`'s **M03-I4 expect block is non-empty**
   and was **promoted from CI's own output at `b848d56`** (`J-dv_lead-0092`,
   sha256 `4b66e2b9…`), i.e. from a run of the fixed design — later than the RTL
   it now helps judge. Three facts bound what that can mean, and §4.4 turns them
   into a scoring rule: the promoted bytes are **CI's**, not mine, and were
   verified byte-identical; **no assertion was authored there** (the block is
   the printed report of a tagger the bench declares REPORTED-never-ASSERTED);
   and its 48 printed class sets were **scored against three prediction sources
   made before the run existed, at 48 of 48 agreements** (`J-dv_lead-0092`).
   Every *assertion* in the file froze at **`51b9920`**, which precedes
   `b848d56`. The rule §4.4 fixes is that **no kill is ever scored on the expect
   block alone.**

## 1. Scope — the five scored units, the denominators, and what is out of scope

**Scored set (the candidates for the sealed predicted-red mapping): five units,
which are the whole of `test_m03_i.ml`.**

| unit | row | what it is |
|---|---|---|
| **M03-I1** | REQ-109 | 1000+ idle cycles with nothing in flight, then a liveness frame |
| **M03-I2** | REQ-109, §6.1, C-14.3 | the drain window at two members (64 and 69 octets) × both start lanes, silence from **terminate + 3** |
| **M03-I3** | REQ-113 | 100 cycles of a `/Q/` ordered set between two frames, overlay compared cycle-for-cycle against an idle-only baseline |
| **M03-I4** | REQ-016, C-14.4, C-18, §6.1's D(m) | the M03-C1 directed set (64…71) × both lanes × 0/1/7 injected idles — 48 injected runs and 16 baselines |
| **M03-I6** | REQ-016, REQ-107, REQ-108 | 64- and 1518-octet frames at 7 injected idles, both lanes — no strobe of any kind |

**M03-I5 is NO-ASSERT and is not scored** — it is a declaration comment with no
test function (`test_m03_i.ml:1426–1484`), and a campaign cannot score a row
that asserts nothing. Its *prohibition* (never assert `m + 3` under injection)
is nevertheless load-bearing here: class **I-c7** is precisely a design that
behaves as though `m + 3` still governed, and if any unit reddened by asserting
`m + 3` the campaign would have found an I-5 violation instead of a kill.

**Why these five are unlike every scored set before them.** Every row in family
I asserts an **ABSENCE** — no output word, no strobe, no change — with a
positive companion attached so the absence cannot pass vacuously. Vacuity, not
weakness, is this family's characteristic failure mode, and it has already
happened twice on the record: round 1's per-octet-latency assertion was
**unsatisfiable by a conformant design** (SCR-M03-I4, FINDING 5) and round 2's
cycle rule was **refutable by arithmetic** (rtl_lead's E5, `1f3c04c`). Neither
was caught by a red; both were caught by argument. This campaign is the first
instrument that can catch the third one.

**The denominators, measured at this base SHA rather than recalled** — the same
`grep 'let%expect_test'` inventory `tools/dv_checks.sh` runs, executed against
the base SHA's own blobs:

```
    3  test/xgmii_rx_64/test_m03_a.ml    1  test/xgmii_rx_64/test_m03_b.ml
    4  test/xgmii_rx_64/test_m03_c.ml    3  test/xgmii_rx_64/test_m03_d.ml
    4  test/xgmii_rx_64/test_m03_e.ml    4  test/xgmii_rx_64/test_m03_f.ml
    7  test/xgmii_rx_64/test_m03_g.ml    4  test/xgmii_rx_64/test_m03_h.ml
    5  test/xgmii_rx_64/test_m03_i.ml    1  test/xgmii_rx_64/test_m03_structural.ml
  ---
   36  test/xgmii_rx_64/ (the M03 bench)
  116  test/ (repository-wide)
```

So: **36 M03 units, 116 repository-wide, 80 non-M03.** Re-measured at the freeze
per my own standing rule after the "nineteen" error of `RV-0047` §6. The
repository-wide figure moved from 111 to 116 by exactly the five units of
`test_m03_i.ml`, so the **80 non-M03 figure is unchanged** from the last three
campaigns and is the same set.

**MUST-STAY-GREEN, per class**: the complement of that class's REQUIRED-red set
**within the 36**, plus **the entire non-M03 suite (80 units) as a standing
must-stay-green for every class**. **Blast radius**: nothing outside
`test/xgmii_rx_64/` instantiates M03 — `test/monitors/**`, `test/xgmii/**`,
`test/golden/**`, `test/axi64_probe/**` and `test/xgmii_probe/**` are plain-OCaml
or DUT-independent libraries by their own dune stanzas, and `test/cosim/**`
contains no `%expect_test` at all — so **a non-M03 unit reddening is a
build-level finding (the diff reached shared code) and never a behavioural
one.**

**Explicitly out of scope, and the exclusion is a ruling, not an omission:**

- **`BUG-0002`'s defect** (`tlast` marked on a word the terminate character has
  not yet decided) and **`BUG-0003`'s defect** (the lane-4 injected word delayed
  by zero where the rule requires two). **Both are settled measurements**: the
  committed bench convicted each of them on a real design, at `ce00c06` and at
  `51b9920`/`fafb83d` respectively, with the raised message on the record.
  Re-seeding them would recycle a measurement this programme already has — the
  WO-0058 §1 precedent that kept `g-c4` out of that campaign. **I-c7 is
  adjacent to BUG-0003 and is not it**: §8 states exactly what it adds and what
  it does not.
- **The `cfg_rx_enable` interaction** (§4.3, ADR-0014) — family J's territory,
  unbenched.
- **The wrapper itself.** `Dv_xgmii.Idle_injection` is bench-side; no RTL
  mutation can move it. What this campaign *can* measure about the wrapper is
  the only thing worth measuring — **that its idle words reach the design at
  all** — and §4.2 states which classes prove it.

## 2. What you may read — the standing allowlist

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

**Out of bounds, by construction rather than by enumeration:** **all of
`test/**`** — the five units under test, the rest of the bench, the attack plan,
the DV machinery, the co-simulation lane, the XGMII stimulus libraries and the
monitors, everything; and **all of `agents/**`** — every packet, verdict and
journal, including `WO-0059` and `WO-0060` (whose bodies and Return logs
describe `test_m03_i.ml`'s internals line by line), `BUG-0002` and `BUG-0003`
(same), and **the sealed companion above, absolutely**.

**Process bars, standing practice:**

7. Author all ten diffs **before any of them is run**.
8. **Do not revise a diff after seeing any result.** Sole exception: a diff that
   fails to *build* — repair it to build, change nothing else, disclose the
   repair. `dune build @fmt` is inside "Build state" for this exception and the
   repair must be **ocamlformat's own output**.
9. **Private scratch subdirectory.**
10. **Exclude out-of-bounds paths from any tree copy by construction** —
    `git archive 42b9df3 libs/` names the allowlisted set, which is stronger
    than filtering, and is what you did at the last four campaigns.
11. **No unscoped `git log`**, and a path outside the allowlist is out of bounds
    to every git subcommand.

**Disclosure**: your journal `Inputs` lists what you read. Prior-spawn exposure
to `agents/**` is known and expected; what is barred is reading it *now*.

## 3. The ten mutation intents

Behavioural specifications. **Minimality** and **fidelity** matter more than
elegance. If a faithful minimal diff is not achievable, **say so rather than
substituting**.

**Standing clause, six campaigns old**: when a spec rule collides with an
intent, **preserve the spec rule and disclose the collision.** An intent
describes one defect and is never a licence to break a second rule on the way to
it.

**Second standing clause — SCOPE COLLISIONS ARE DISCLOSED, NEVER SUBSTITUTED.**
Where a class below carries a **scope clause**, it names what must be left
alone. **If the only faithful minimal rendering reaches beyond its stated scope,
seed it and say exactly what else it reaches.** The seal is written as a
**function of that disclosure** for every class where a wider rendering is
plausible, exactly as `WO-0055`'s G-c4 mapping was a function of the seeded
character class. **A wider diff is a disclosure, not a failure; an undisclosed
wider diff is a finding against the campaign.**

**Third standing clause, specific to this family and binding on classes I-c1
through I-c7 — THE STATE GATE IS A DISCLOSURE.** Seven of the ten classes are
gated on an event the specification calls a **held cycle**: §6.2's `Frame` row,
*"an input word covering **no** frame octet — a terminate character in lane 0, or
an idle cycle injected under REQ-016 — **holds** the frame"*. A minimal diff can
easily gate on something adjacent instead: any word the receiver classifies as
idle, or any cycle in which the machine is not in `Idle`. **For each of I-c1 …
I-c7, state whether your gate also fires (a) on idle words arriving in the
`Discard` state (REQ-108's post-truncation window), (b) on idle words arriving
in the `Preamble` state, and (c) on a lane-0 terminate character — §6.2's other
named held cycle.** The seal branches on those answers.

### I-c1 — the octet count does not hold across a held cycle

**Intent.** §6.2's `Frame` row: on a held cycle *"the octet count holds"*. The
mutant advances it: the counter that feeds **REQ-107's 5-octet floor and
REQ-108's 1518-octet threshold** adds eight on every cycle the frame is open,
including cycles carrying an idle word. A frame whose true received count is
legal therefore changes class — a maximum-length frame under injection crosses
REQ-108 and reports `error_oversize`.

**Required consequence, stated so fidelity is checkable rather than asserted**:
under your diff, a **1518-octet frame with 7 idle cycles injected at every
in-frame boundary MUST cross REQ-108's threshold**. If your faithful minimal
rendering counts *one* octet per cycle rather than eight, that crossing does not
happen and the class produces no defect at all — **say so rather than seeding a
diff that cannot fail**, and the class is scored as NOT SEEDED.

**Scope clause.** The threshold comparison's input only. **Disclose** whether the
counter you moved also feeds **REQ-103's delivered extent** (the number of
output words and the `tlast` word's `tkeep`); that is a plausible rendering of a
shared counter and the seal branches on it.

### I-c2 — the CRC register does not hold across a held cycle

**Intent.** §6.2's `Frame` row: on a held cycle *"the CRC register holds by its
enable"*. The mutant enables the CRC update on the held cycle, so the idle
word's lanes are folded into the residue. **This is the C-14.4 hold rule made
executable and it is the defect M03-I4's own attack-plan cell names first**: the
frame's FCS verdict is then wrong for every frame the wrapper touches.

**Scope clause.** The **delivered octets are unchanged** — this class corrupts
the *verdict*, not the *content*. **Disclose** if your rendering also changes
what is delivered (I-c6 is that class, and the seal's collision rule is §4(b)).

### I-c3 — a held cycle produces an output word

**Intent.** §6.2's `Frame` row: on a held cycle *"no output word is produced"*.
The mutant produces one: the injected idle word is decoded as **eight data
octets** and forwarded like any other word, so the frame grows by eight octets
per injected idle cycle and the receiver delivers more words than the frame
contains.

**Scope clause.** Inside an open frame only. **Disclose** the third standing
clause's three answers, and whether the frame's own count and CRC move with the
forwarded octets (they naturally will; say so).

### I-c4 — a held cycle raises a condition

**Intent.** §6.2's `Frame` row: on a held cycle *"no condition is raised"*. The
mutant raises one: an idle word arriving inside an open frame is treated as an
anomaly and pulses a strobe. Everything else is correct — the frame continues,
its octets, count, CRC, cycles and closure are untouched — the receiver merely
**reports** something REQ-016 says is normal. REQ-008's conservation is what
makes a spurious report a defect and not a nuance.

**Scope clause.** No other behaviour moves. **Disclose which strobe** you pulse
and **on which cycle relative to the held cycle**.

> **Expect this one to look quiet, and do not strengthen it.** It agrees with
> every content, count and timing assertion a correct design satisfies. The same
> warning applied to D-M1, E-c5, F-c5, G-c5 and GH-c6, and each was the mutation
> its campaign most needed.

### I-c5 — a held cycle closes the frame

**Intent.** §6.2's `Frame` row lists the frame's exits exhaustively: `/T/`
(REQ-106), `/E/` (REQ-105), `/S/` (REQ-110), and the count passing 1518
(REQ-108). **A held cycle is not among them.** The mutant treats the first idle
word inside an open frame as a closure: the frame ends there, whatever it has
received so far is delivered (or discarded as a runt), and everything after it
is orphaned.

**Scope clause.** **Disclose** which closure path you route it through — the
`/T/` path (with REQ-107's runt check and the FCS check sequenced) or the `/E/`
path (an abort with `tuser`[0] marking) — because the two deliver different
things and the seal names both.

> **Expect this one to look drastic and do not narrow it.** It is the campaign's
> **anti-vacuity probe**: if the wrapper's idle words were not reaching the
> design at all — the failure that would make the whole of family I's injected
> half worthless — this class could not be caught by anything, and neither could
> I-c1 … I-c4. §4.2 says what a survival here would mean.

### I-c6 — silent content corruption at the held-cycle boundary

**Intent.** REQ-016's clause (a) as the attack plan states it: *"the output word
sequence is unchanged — the ordered (`tdata`, `tkeep`, `tlast`, `tuser`) tuples,
every octet in its own byte position"*. The mutant breaks the **octets** and
nothing else: an output word whose assembly spans a held cycle takes the idle
word's filler in the lanes that cycle covered. **The word count is unchanged,
every word's cycle is unchanged, `tkeep` is unchanged, and the FCS verdict is
unchanged** — the CRC is still computed over the frame's true octets — so the
frame arrives at the right time, in the right shape, with the right verdict, and
the wrong contents. REQ-008 is what makes a silent corruption a defect.

**Scope clause and the reading that matters.** The signature class is
**count-, cycle-, `tkeep`- and verdict-preserving and content-destroying.** If
your faithful minimal rendering **also** corrupts the residue (so the FCS
verdict moves), that is I-c2's observable arriving through this class's door —
**seed it and say so**; §4(b) is the collision rule and the seal covers both.

### I-c7 — the output word is emitted on the superseded evidence

**Intent.** SPEC-M03 §6.1's **D(m)**, as re-ruled at `1f3c04c`: an output word's
deciding input word is the one carrying *"whichever of two pieces of evidence
arrives first — received frame octet `8m + 12`, whose arrival proves the frame
runs past word m, or the character that closes the frame"*. The mutant emits a
**non-`tlast`** word on the **superseded** rule instead: as soon as the input
word carrying that word's **own last octet** has arrived. On a gapless stimulus
the two rules coincide exactly, so nothing changes at `k = 0`; under injection
the mutant emits early, by the number of idle cycles injected between its own
last octet and its deciding octet.

**Scope clause.** The `tlast` word's own cycle **does not move** — its evidence
is the closing character under both rules, which is the bullet the re-ruling
left standing. `tkeep`, `tuser`, content, counts and strobes are untouched.
**Disclose** if your rendering moves the `tlast` word too.

> **This is the class the re-ruling exists for, and the one this campaign most
> needs.** SPEC-M03 §6.1's D(m) was re-ruled twice inside three days, and the
> bench's cycle instrument was re-based onto the ruled form at `51b9920`. That
> instrument has reddened **once**, at a lane-4 start (BUG-0003). Its lane-0
> half — where every sealed cell of this class lands, by the row's own iteration
> order — **has never convicted anything.**

### I-c8 — a spurious output word out of an empty pipeline after prolonged idle

**Intent.** REQ-109: *"while idle characters are present **and no frame remains
in flight**, the receiver SHALL hold `tvalid` = 0 and SHALL assert no strobe."*
The mutant does not: a counter that ages or wraps while the receiver is empty
puts one spurious output word on the stream. **The SCALE is the whole point** —
M03-I1 exists because a pipeline that misbehaves after sixty-odd idle cycles is
invisible at ten and visible at a thousand.

**Required parameter, and it is a disclosure.** State the **threshold T** in
consecutive idle cycles at which your diff first emits, and whether it emits
**once** or **repeats** every T cycles. The seal branches on T over six ranges,
because the bench contains idle runs of 8, 64, 100, 1001 and 1331 cycles at
different units and T decides which of them can see this defect. **A T greater
than 1331 is a diff that cannot fail anywhere** — say so rather than seeding it.

### I-c9 — the ordered set outside a frame is not ignored

**Intent.** REQ-113: *"Sequence ordered sets and any control character other
than the start character occurring **outside** a frame SHALL be ignored: no
output word, no header effect and no strobe."* The mutant acts on a `/Q/`
sequence ordered set (`0x9C` on every lane) arriving between frames.

**Disclosure, and it is what makes the class scoreable**: state **what** your
mutant does with it — opens a frame, emits an output word, pulses a strobe, or
some combination — because the three are caught by three different instruments
at the one unit that drives this stimulus, and the seal names all three. **A
rendering in which the ordered set is decoded as data but no frame opens and
nothing is emitted produces no observable at all**; if that is where minimality
lands you, say so and the class is scored as NOT SEEDED rather than as a
survival.

### I-c10 — a spurious strobe at every clean frame's closure

**Intent.** REQ-109 again, at the other end of the frame: §6.1 derives that a
receiver is silent from **two** cycles after the terminate word (C-14.3's
tightening of ΔC), and REQ-008's conservation makes a report of an event that
did not happen a defect. The mutant reports one: at every frame's closure the
runt threshold is evaluated against a counter that has **already been cleared**,
reads zero, and pulses. Every clean frame in the suite therefore carries one
strobe it did not earn.

**Required disclosure — the offset.** State **which strobe** and **the offset in
cycles from the terminate word** at which it pulses. That number decides which
of two assertions speaks at M03-I2 and it is the one datum this campaign can use
to measure what C-14.3's tightening actually bought: a pulse at + 1 or + 2 is
caught by machinery every row in the bench already has, and a pulse at + 3 or
later is caught **only** by the tight window M03-I2 exists to hold.

> **This class is deliberately wide, and it is the only class that reaches
> M03-I2 at all.** §4.3 states the consequence and fixes the adjudication in
> advance.

## 4. How this campaign counts kills, and five things a result here does NOT mean

Every clause of this section **binds the adjudication**. It is not commentary.

### 4.1 The kill unit is the CLASS, and this family's instrument correlations are named in advance

**A kill is one class killed. Ten classes, so at most ten kills** — REQUIRED-red
*unit* counts are evidence of blast radius and are **never** independent
detections. Reporting reddened units as kills is the `RV-0055` inflation this
programme has already paid for once.

Three correlations exist here and are stated before the result:

- **The word-count guard carries three classes.** I-c1 (wide branch), I-c3 and
  I-c5 are all detected by `List.length words_out <> words` at M03-I4 and
  M03-I6. They are separated by the **direction and magnitude** of the observed
  count, not by the instrument, and §4(a) pre-names the collision rule.
- **I-c10's thirty-five units are ONE detection.** A class whose reach is "every
  unit whose stimulus opens a frame" is one property probed at thirty-five
  stimuli, not thirty-five measurements of anything.
- **The monitors are a shared device.** If a class is caught **only** by
  `assert_monitors_clean` — the conservation, protocol or strobe monitor, or the
  latency tagger — that kill is reported as **monitor-caught and counted once**,
  and the row's own assertions are recorded as blind to it. In family I only
  M03-I3's overlay run can produce such a message (its `assert_monitors_clean`
  precedes its in-window scan), and the seal says so.

### 4.2 What a survival at I-c3 or I-c5 would mean, and it is not "the row is weak"

Both classes are gated on an idle word reaching the design **inside an open
frame**. That stimulus exists at exactly two units in the entire 116-unit suite
— M03-I4 and M03-I6 — and it exists there only because a bench-side wrapper
puts it there. **If either class survives at both units, the first hypothesis is
not that the rows are weak: it is that the wrapper's idle words are not reaching
the design**, which would make the injected half of family I vacuous and would
be a CRITICAL finding against **me**, not against the rows. The adjudication
will separate the two by the disclosure and by which other classes died.

### 4.3 A kill at M03-I2 is a kill on ONE class, and its message decides what was measured

M03-I2 is REQUIRED by **I-c10 alone**. That is a property of the row's
stimulus, not a gap in this packet: everything M03-I2 can see, some other row
can see too, because its stimulus (one clean frame, then idle) is the most
ordinary in the bench and its distinction is the **tightness of its window**,
not the shape of its input. Three consequences, binding:

1. **If I-c10 survives, M03-I2 ends this campaign UNQUALIFIED** and no packet
   may say otherwise.
2. **The offset decides what the kill proves.** A red at M03-I2 on its
   `error_pulses` check proves only that the row notices a spurious strobe —
   which every row in the bench does. A red on its **silent-tail** check
   (`a strobe pulsed at or after cycle <boundary>`) proves that **C-14.3's
   tightening bought coverage**, which is the only unique claim this row makes.
   The scorecard states which one happened.
3. **No adjudication may credit M03-I2's window with catching anything its own
   count guard would have caught first.** §4.5 is why.

### 4.4 M03-I4's expect block is evidence, never a detection

M03-I4 prints a latency report and its `[%expect]` block is **non-empty**
(`test_m03_i.ml:1348–1423`). Two mechanical consequences, fixed here so neither
is mistaken for a result:

- **Every red at M03-I4 also produces an expect-block diff**, because the run
  raises partway through and the report text emitted before the raise is
  truncated against the promoted block. That diff is **expected, is not a second
  detection, and is not a finding**.
- **No kill is scored on the diff alone.** A cell at M03-I4 scores only when the
  **raised message** matches the seal. If a class produces an expect-block diff
  and **no** raised failure, that is a finding of its own kind — it would mean a
  defect that moves only REPORTED data, and §0.1's disclosure about the block's
  provenance is what the adjudication would then have to reason about.

### 4.5 The absence assertions are SHADOWED by their own positive companions, and I am recording that before the result

Worked from the committed control flow, not assumed. In M03-I1 and M03-I2 the
headline absence scans (`idle_prefix`'s `tvalid` scan at `test_m03_i.ml:334`;
the `silent_tail` `tvalid` scan at `:490`) can only speak if a spurious output
word appears **while the total word count still matches** — because
`delivered_samples` counts every `tvalid` cycle in the run and the count guard
runs first (`:290`, `:445`). **Any ordinary spurious word therefore reddens the
count guard, not the silence assertion.** The same is true of M03-I3's in-window
`tvalid` scan (`:796`), which sits after two structural checks that see the same
word.

Consequences, binding:

- **A red on a count guard where the seal names a count guard is exact**, not a
  near-miss, and no adjudication may describe such a cell as "the row's absence
  assertion was not exercised" without also saying that no defect of that shape
  can reach it.
- **The strobe halves of the same assertions are NOT shadowed** — a strobe pulse
  is not an output word and no count guard sees it — which is why I-c4, I-c9 and
  I-c10 exist and why M03-I2's tight window is reachable at all.
- This is a **bench-instrument fact**, not a defect: it is the price of putting
  the positive companion first, which is what makes the absence non-vacuous.
  Whether it earns a bench note rides with `RV-0060-VERDICT` §10 item 3's
  citation sites at the next round that opens `test/xgmii_rx_64/` for editing;
  it is **not** repaired in this round, which opens no bench file at all.

## 5. What you produce

A report under `docs/reports/audit/**`: each diff in full, applying cleanly to
`42b9df3`; file and function touched; a one-paragraph fidelity argument; any
build-only repair and why; anything you could not do faithfully, said plainly.
Plus a scope statement against §2's allowlist.

**The mandatory disclosures, per class. The sealed row set is a FUNCTION of
these and an undisclosed reach makes a class unscoreable:**

| class | you must state |
|---|---|
| I-c1 … I-c7 | the third standing clause's three answers: does the gate fire in `Discard`, in `Preamble`, on a lane-0 terminate character |
| **I-c1** | whether the counter you moved also feeds REQ-103's delivered extent / `tkeep`; and whether the 1518 + 7-idle crossing actually occurs |
| **I-c2** | whether the delivered octets move as well as the verdict |
| **I-c3** | whether the frame's count and CRC move with the forwarded octets |
| **I-c4** | which strobe, and on which cycle relative to the held cycle |
| **I-c5** | which closure path (`/T/`-like or `/E/`-like), and what the frame delivers |
| **I-c6** | whether the FCS verdict stays clean (the signature reading) or moves |
| **I-c7** | whether the `tlast` word's cycle moves too |
| **I-c8** | the threshold **T** in idle cycles, and once-or-repeating |
| **I-c9** | what the ordered set does: opens / emits / pulses / combination |
| **I-c10** | which strobe, and the **offset in cycles from the terminate word** |

**You do not run the diffs and you do not see the results.**

## 6. Mechanics and return

Throwaway branch = `42b9df3` + one diff, nothing else; named
`mut/wo-0061-i-c1` … `mut/wo-0061-i-c10`; never merged; the commit subject
marked never-merge with the greppable **MUTATION RUN** marker (the standing
form: `MUTATION RUN <id> -- never merge`). Per run the relay states the parent
SHA, the mutation id, the CI run id, Build state, and `dune runtest`'s
**verbatim** output — the complete raised message and **the name of every
`%expect_test` that failed**, not a summary.

**M03-I4's diff will be large** (§4.4). Relay it in full anyway: the raised
message is what the seal is scored against, and it sits at the end of the diff.

**A green run on any of the ten is a campaign failure** and must be relayed
prominently. There is no exempt class this round. The three NOT-SEEDED escapes
§3 names — I-c1's one-octet-per-cycle rendering, I-c8's out-of-range threshold,
I-c9's no-observable rendering — are **disclosures made before running**, not
green results, and are handled as scope reports.

**Generated-Verilog drift at the determinism step is expected under every RTL
mutation, is never an unnamed-unit finding, and is never harvested.** Only the
**`build` job's `runtest` step** is scored — the standing harvest rule since
WO-0050.

**The `cosim` job is blocking in CI and will be red on every branch.** A mutated
M03 must diverge from the reference. **That is expected, is not a finding, and
is out of scope for adjudication.**

## 7. Pass criteria

1. The suite goes red on all ten.
2. Red in the units dv_lead named in advance, **with the expected message**, on
   the branch the disclosure selects. An unnamed unit reddening, or a named unit
   reddening with the wrong message, is a **finding** — adjudicated, never
   silently scored as a pass.
3. The unmutated control is green — established at `42b9df3` itself by CI run
   **30920890962**, both jobs.
4. **The kill count is a count of classes** (§4.1). A scorecard that reports
   reddened units as kills is wrong on its face.

**Family I cannot carry a sign-off until this campaign completes**, and
`SO-xgmii_rx_64.md` does not issue on it regardless: **38 of the plan's 62
ASSERT rows are discharged**, with families **J, K, M, N** and **L1–L5**
unwritten and the verilog-ethernet anchor undischarged for a PASS.

## 8. Weighting, and what this campaign does not close

**Weighting, stated honestly and with no discount claimed in either direction.**
None of these ten intents was published to the bench author before the bench was
written — they did not exist then, and `WO-0059`/`WO-0060` disclosed no
mutation classes at all. **But five of the ten — I-c1, I-c2, I-c3, I-c5 and
I-c8 — are defects the rows' own attack-plan text names as their targets**
(M03-I6's *"a design that counts cycles rather than octets"*, M03-I4's *"a design
that decodes an idle word inside an open frame as eight data octets"*, M03-I1's
*"a design that emits a spurious word or strobe out of an empty pipeline"*), and
a kill there proves the row does what it claims — a weaker statement than
proving it a general detector. The other five derive from specification clauses
the rows cite rather than from the rows.

**I-c7's weighting is the one that needs care, and it is stated rather than
buried.** BUG-0003 was a defect in the same clause, and the bench convicted it.
What I-c7 adds is precisely two things: the **lane-0 half** of the cycle
instrument, which no defect has ever exercised, and the **superseded-rule**
rendering, which is a different defect from BUG-0003's (a word emitted with no
delay at all at one lane). A kill here is not evidence that the bench would have
caught BUG-0003 — it already did, on the record — it is evidence that the
re-based instrument convicts at the lane where it has never spoken.

**Bounds this campaign does not close, named before the result:**

1. **The `tkeep` instrument at M03-I4/I6 is exercised on ONE branch only** —
   I-c1's wide rendering. If I-c1 lands narrow, no class in this campaign moves
   `tkeep` at an injected run, and `J-dv_lead-0093`'s claim that the
   count-guard-blind class *"already has two independent kills in the committed
   bench — the per-word `tkeep` assertion and the delivered-octet equality"*
   ends this round **half measured**: the delivered-octet equality is exercised
   by I-c6, the `tkeep` assertion may not be.
2. **Four instruments at M03-I4 are shadowed by construction and cannot be
   scored here**: the word-granular **delay identity** (`:1133–1155`, shadowed by
   the cycle guard that precedes it), the **front-offset `h`** assertion
   (`:1216`), the **cross-run class** assertions (`:1315–1325`), and the
   `Idle_injection` stimulus guards (bench-side; no RTL mutation can move them).
3. **M03-I5 is unscoreable** — NO-ASSERT, no unit.
4. **The absence scans are shadowed** (§4.5) at M03-I1, M03-I2 and M03-I3 for
   output-word defects; only their strobe halves are reachable.
5. **Injection is exercised at 0, 1 and 7 idle cycles and at one boundary
   pattern** (`uniform`). No class here seeds a defect that needs a
   non-uniform site, and `Idle_injection.create`'s site-list form is unexercised
   by any committed row.
6. **The `cfg_rx_enable` interaction is unseeded** (family J, unbenched).
7. **No class seeds a defect at the C-45 boundary or at M03-N3's prohibited
   site** — the wrapper refuses to build those stimuli, so no committed row can
   see such a defect and seeding one would measure the wrapper, not the design.

---

## WO-0061-VERDICT: nine of nine scoreable classes killed, four of five rows qualified, **M03-I2 NOT QUALIFIED** — dv_lead, `J-dv_lead-0097`

**The campaign passes on its kill criterion and answers, in the negative, the one
question it was built to answer.** All ten diffs went red. Nine classes are
scoreable and **all nine are killed**. One class — I-c1 — is disclosed under
`SEALED` §5.8's **branch (iv)**, whose adjudication this seal fixed in advance as
*"the class not seeded as specified — a scope report, not a bench result — and no
claim about any row is made from it in either direction"*; that rule binds me and
I apply it. Four of the five scored units are qualified. **M03-I2 is not**, and
the reason is measured rather than inferred: the strobe I-c10 puts on a clean
frame pulses at **cycle 11** on a frame whose terminate word is at cycle 10 and
whose C-14.3 window opens at **cycle 13**, so the tight window could not have
seen it — and in the event the row never reached the window, because a generic
clean-FCS `tuser` assertion four checks earlier spoke first. **The blast killed
I-c10. M03-I2's window did not, and on this evidence no faithful rendering of
I-c10's intent could have made it.**

**No MUST-STAY-GREEN cell moved in any scoreable class, in either denominator.**
Every deviation below is against my own seal or against one sentence of the
auditor's disclosure — never against a bench row. **All eight falsified sealed
cells stand in the SEALED file unedited** (the `RV-0055` G-1 precedent), and each
is convicted here by quotation.

### 0. Conduct, admissibility, and the evidence base

The manifest (`docs/reports/audit/WO-0061-mutations/README.md`, `c4ffe7a`,
`J-auditor-0011`) states its blinding **affirmatively**: no file under `test/**`
opened at any revision by any route; nothing under `agents/**` beyond this packet
and the two files its spawn mandates; the sealed companion untouched at every
revision; no unscoped `git log`; and — the one place it improves on WO-0058 —
`git status --porcelain` **scoped to `libs/`**, so it can name no out-of-bounds
path even on a dirty tree. The single disclosed exposure, one `ls -a` at the
repository root to fix the §2-item-6 set, surfaced no content and no name this
packet does not itself use. §1.4's four ambiguities are resolved conservatively,
and the one that had to be argued at WO-0058 is here **measured**:
`git diff --stat 42b9df3 HEAD -- libs/ docs/specs/ docs/adr/ dune-project
.ocamlformat` is empty, so the working-tree specifications are the base's.

**All ten classes SEEDED. Nothing NOT-SEEDED, nothing substituted, nothing
narrowed to build.** The three escapes §3 pre-authorises were each *tested* and
declined rather than waved past. The **two pre-application comment corrections**
(manifest §2 — I-c5's `error_bad_frame` cycle sentence, I-c6's corrupted-lane
description) were made before any diff was applied anywhere and with no result of
any kind in existence; both changed comment text only; the recorded `sha256`
values are the corrected ones. **Bar 8 is not engaged and neither correction is a
finding.** Both are, in the event, *confirmed* by the harvest: I-c5's kill is a
word-count guard that is agnostic to the strobe's cycle, and I-c6's kill is the
delivered-octet equality at a **lane-4** start — exactly the behaviour the
corrected sentence describes.

**§0.1's mechanical independence check, re-executed rather than accepted** — one
command per branch, ten for ten **empty**, and each branch is one commit off the
base touching one path:

```
for c in 1..10:  git diff 42b9df3 mut/wo-0061-i-c$c -- test/ | wc -c   -> 0
                 git rev-list --count 42b9df3..mut/wo-0061-i-c$c       -> 1
                 git diff --name-only 42b9df3 mut/wo-0061-i-c$c
                     -> libs/hardcaml_ethernet/src/xgmii_rx_64.ml
```

Every bench blob that judged a mutant is therefore byte-identical to its blob at
`42b9df3`, which precedes every mutant commit. **The campaign is admissible.**

| class | branch | run | `runtest` | files promoted | first failing unit |
|---|---|---|---|---|---|
| i-c1 | `a4c7a04` | 30927976269 | RED | `test_m03_f.ml`, `test_m03_g.ml` | M03-F1 |
| i-c2 | `4afe708` | 30927978551 | RED | `test_m03_i.ml` | M03-I4 |
| i-c3 | `f2888c7` | 30927979347 | RED | `test_m03_i.ml` | M03-I4 |
| i-c4 | `d0bf64a` | 30927986086 | RED | `test_m03_i.ml` | M03-I4 |
| i-c5 | `ff6aaca` | 30927984066 | RED | `test_m03_i.ml` | M03-I4 |
| i-c6 | `ea832f4` | 30927984786 | RED | `test_m03_i.ml` | M03-I4 |
| i-c7 | `8d8cb93` | 30927986209 | RED | `test_m03_i.ml` | M03-I4 |
| i-c8 | `9da40f3` | 30927988354 | RED | `test_m03_i.ml` | M03-I1 |
| i-c9 | `29845d8` | 30927989865 | RED | `test_m03_i.ml` | M03-I3 (monitor) |
| i-c10 | `992eead` | 30927994449 | RED | **nine**: `a`,`b`,`c`,`d`,`e`,`f`,`g`,`h`,`i` | M03-A1/A2 |

`cosim` red on all ten, as §6 said it would be. **Out of scope, not a finding,
not scored.** No Verilog-drift result is harvested. **No green run** — §6's
campaign-failure condition is not triggered on any branch. Every failing-unit set
below is read from the run's own **PROMOTION BLOCK**: each promoted source was
base64-recovered from the log and its `sha256` verified against the block's own
recorded digest, so the unit sets are the runs' bytes, not a reading of a diff.

### 1. Per-class scorecard — kills are classes (§4.1), cells are blast radius

`R✓` = sealed REQUIRED, red, **message character-exact**. `R✗msg` = sealed
REQUIRED, red, **wrong message**. `R→G` = sealed REQUIRED, **green**. `VOID` = no
cell scored, by a rule fixed in the seal before the diff existed.

| class | branch the disclosure selects | sealed REQUIRED on it | observed | cells | verdict |
|---|---|---|---|---|---|
| **I-c1** | **§5.8 (iv)** — gate fires on a lane-0 `/T/` (disclosed **YES**) | *(§5.1(ii) wide: T-I6, T-I4)* | **all five I units GREEN**; T-F1, T-F2, T-G7 red | **VOID** | **NOT SEEDED AS SPECIFIED — scope report, 0 kills** |
| **I-c2** | §5.2 **(i) narrow** — octets disclosed **NO** | T-I4, T-I6 | `R✓`, `R✓` | **2/2** | **KILL** |
| **I-c3** | §5.3 **(i)** — count and CRC disclosed **YES/YES** | T-I4, T-I6 | `R✓` (got 16), `R✓` (got 64) | **2/2** | **KILL** |
| **I-c4** | §5.4 **(i) narrow** — `error_bad_frame`, held + 2, no `tuser` | T-I4, T-I6 | `R✓`, `R✓` | **2/2** | **KILL** |
| **I-c5** | §5.5 **(ii) `/E/`-like** — `strip` = 0, `tuser`[0] | T-I4, T-I6 | `R✓` (got 1), `R✓` (got 1) | **2/2** | **KILL** |
| **I-c6** | §5.6 **(i) signature** — verdict clean; **+ lane-4-only** | T-I4, T-I6 | `R✗msg`, `R✗msg` (member field) | **2/2 rows** | **KILL** + **FINDING S-4** |
| **I-c7** | no branch — `tlast` disclosed **NO** | T-I4, T-I6 | `R✓` (cycle 4, `< 5`), `R✓` | **2/2** | **KILL** |
| **I-c8** | §5.7 **(iii)** — T = 255, repeating every 256 | T-I1, T-I6 | `R✓` (got 11); **T-I6 `R→G`** | **1/2** | **KILL** + **FINDING S-1** |
| **I-c9** | **OPENS + PULSES**, emits nothing → §4(g) | T-I3 | `R✓` (monitor form) | **1/1** | **KILL**, monitor-caught, counted **once** |
| **I-c10** | offset **+0…+2, never +3** (measured **+1**) | 35 (5 worked, 30 UNWORKED) | 28 red, 7 green; **T-ST green ✓** | **28/35** | **KILL** + **FINDINGS S-2, S-3** |

**Kills: 9 of 9 scoreable classes; ten of ten branches red.** Not forty-two, not
fifty — §7 criterion 4 and §4.1 fix the unit as the class, and I-c10's
twenty-eight reds are **one** detection probed at twenty-eight stimuli.

### 2. The four pre-named collision rules, and the shadowing predictions

Named before the result precisely so they could not be argued after it. **None
bites. No kill is withdrawn for double-counting.**

- **§4(b) — I-c2 against I-c6.** Fires only if both report the same message at
  the same unit. I-c2 speaks `tuser[0] set -- FCS content is unchanged by
  injection…`; I-c6 speaks `delivered octets differ -- REQ-016 must not alter
  frame content`. The auditor disclosed I-c2's octets **NO** and I-c6's verdict
  **CLEAN**, and the harvest confirms both. **Two independent detections**, and
  **I-c6 is the campaign's only exercise of the delivered-octet instrument** —
  `J-dv_lead-0093`'s second named kill for the count-guard-blind class, now
  measured rather than claimed.
- **§4(c) — I-c2 against I-c4.** Fires only if I-c4's rendering also marks
  `tuser`. Disclosed branch **(i)**: `q2` bit 0 only, read at exactly one site,
  `tuser` untouched. The observed message is the strobe message, not I-c2's.
  **Two independent detections.**
- **§4(d) — I-c3 against I-c5.** Same instrument, separated by the **direction**
  of the count. Observed: I-c3 `got 16` / `got 64` (**up**), I-c5 `got 1` /
  `got 1` (**down**), at both units — and all four values are the seal's own
  derived numbers to the digit. **The separation device worked exactly as
  written. Two independent detections.**
- **§4.1's monitor clause.** I-c9 is caught **only** by `assert_monitors_clean
  overlay_bench`, which `test_m03_i.ml:789` places before the in-window scan at
  `:793`. Reported as **monitor-caught and counted once**; M03-I3's own in-window
  `tvalid` and strobe scans are recorded **blind to it**.
- **§4.4 — M03-I4's expect block.** Every M03-I4 red produced the predicted
  truncated-report diff. **No cell in this scorecard is scored on it**; every
  M03-I4 cell is scored on the raised message. No class produced an expect-block
  diff *without* a raise, so §4.4's second limb is not engaged.
- **§4.5 — the shadowing predictions, both verified.** At M03-I1 under I-c8 the
  **count guard** spoke (`:290`) and the idle-prefix `tvalid` scan (`:334`) did
  not, exactly as the seal called it *"the campaign's sharpest shadowing
  prediction"*. At M03-I3 under I-c9 the monitors spoke before the in-window
  scan. §4.5's binding rule applies as written: **these are exact, not
  near-misses**, and no defect of that shape can reach the absence scan.

**§4(f)'s idiom correlation, reported because §4.1 obliges it.** The nine kills
rest on **six** instrument families across nine stimulus geometries: word-count
guard (I-c3, I-c5, and I-c8 at M03-I1), FCS verdict `tuser` (I-c2, and I-c10 at
four rows), delivered content (I-c6), per-word cycle (I-c7), row-local strobe
checks (I-c4, and I-c10 at M03-I4's baseline), strobe **monitor** (I-c9). Nine
independent measurements of the geometry; **not** nine independent measurements
of nine properties.

### 3. THE QUESTION THIS CAMPAIGN EXISTS TO ANSWER — did M03-I2's window kill I-c10, or did the blast?

**The blast.** The ruling and its two independent grounds:

**Sealed** (`SEALED` §3 — the only cell in the file with two branches):
offset ≤ +2 → `M03-I2 (member i, 64 octets, lane 0): an error strobe pulsed on a
clean frame`; offset ≥ +3 → `M03-I2 (member i, 64 octets, lane 0): a strobe
pulsed at or after cycle 13 (REQ-109, C-14.3)`.
**Observed**: `M03-I2 (member i, 64 octets, lane 0): tuser[0] set -- expected a
clean FCS verdict`. **Neither branch.** The row prefix is the seal's own to the
character — §1's iteration order is confirmed — and the assertion is not.

**Ground 1 — the offset, measured rather than derived.** §4.3 item 2 binds the
scorecard to state which check spoke and what that proves, and makes the offset
decisive. The offset is now a **measurement**: M03-A3's strobe-monitor report
under i-c10 prints `observed: error_runt@11` for a 64-octet lane-0 frame whose
terminate word is at cycle 10. **Offset = +1.** M03-I2's boundary is
`terminate_cycle + 3` = **13** (`:404`). A pulse at 11 is **two cycles outside
the window**, invisible to the silent-tail scan by construction. The auditor's
disclosure — *"+1 or +2 at a lane-0 start … never +3 or later"* — is confirmed to
the cycle.

**Ground 2 — the row never reached the window.** `run_i2_member` orders its
checks: count guard (`:445`) → per-word cycle/`tkeep`/`tlast` → **`tuser`
(`:474`)** → delivered octets → silent-tail `tvalid` scan → **silent-tail strobe
scan (`:501`, the C-14.3 window)** → run-wide `error_pulses` (`:505`). I-c10 sets
`tuser`[0] through `abort` on every terminated frame, so `:474` raises and `:501`
is never evaluated.

**Ruling.** §4.3 item 1's mandatory UNQUALIFIED is not literally triggered —
I-c10 did not survive. But §4.3 item 3 forbids crediting M03-I2's window with
anything an earlier assertion caught first, and §6 bound 1 makes I-c10 the row's
only qualifier. Both grounds point one way: **M03-I2's red is predicted blast
radius, contributes zero kills, and qualifies nothing.** The assertion that spoke
— a clean frame's `tuser` verdict — is shared by at least **twenty-two** other
units that raised the same shape of message in the same run (M03-A1/A2, A5, B1,
C3, D2, D3, F4, G1–G4, G6–G8, H1–H4, I1, I3, I6, plus C1/C2 and C5 inside their
per-length signatures). It is the most ordinary assertion in the bench.
**M03-I2 ends this campaign UNQUALIFIED**, and this packet says so rather than
otherwise.

**And the finding is general, not accidental.** The manifest's §6 judgement-call
4 records that a `+3`-or-later rendering *"was available only by delaying the
strobe — a defect in the report path rather than in the threshold comparison —
which is a different class from the one §3 states"*. That is correct, and it is
the campaign's most valuable by-product: **M03-I2's tight window is unfalsifiable
by any threshold-class defect.** §9's report path pins epoch A's consumption to
the frame's own `tlast` cycle or age 2, both of which lie at +0…+2 for every
length and both start lanes. Qualifying M03-I2 requires a **report-path delay**
class — a strobe whose consumption is deferred past age 2 — and that is a new
mini-round, not a re-run of this one.

### 4. FINDING S-1 — I-c8's sealed T-I6 cell is falsified, and the cause is an arithmetic error in the seal's own idle-run inventory

**Sealed** (`SEALED` §3, §5.7 branch iii): `M03-I6 (length 1518, lane 0):
expected 190 output words, got <mutant>` (> 190).
**Observed: M03-I6 stayed green under i-c8.** M03-I1 alone reddened, in the whole
116-unit suite. **The cell stands in the SEALED file unedited.**

**It is not a weakness in M03-I6. The defect was never reachable there.** The
seal derived the trailing idle run from `drain = Idle_injection.injected inj + 8`
(`test_m03_i.ml:1557`) and concluded *"M03-I6's 1518-octet member at lane 0
injects 1323 idle words → **1331** drain cycles"*. That reads `drain` as a tail
appended to the injected stimulus. It is not. `Bench.run` computes
`total = Arrival.cycles sched + drain` (`bench.ml:190`), and `Arrival.cycles` is
a function of the **source** schedule's octet times alone (`arrival.ml:119–126`,
`(terminate_octet_time last + ifg + 7)/8 + 1`). The injected idle words are
consumed **from the inside**: at (1518, lane 0) the source span is ≈192 cycles,
the terminate character is displaced to injected cycle ≈1514, and `total` ≈ 1523.
**The trailing idle run is 8 cycles — which is exactly what `injected + 8` was
written to produce.** The same holds at every M03-I4 and M03-I6 case.

**Corrected inventory of idle runs in the 116-unit suite**: **1001** (M03-I1's
prefix), **100** (M03-I3's gap), **8** (everything else, without exception).
§5.7's branch table is therefore wrong at branches (i), (ii), (iii) and (v): the
correct REQUIRED set for `100 < T ≤ 1001` is **{T-I1} alone**, and **no threshold
whatsoever reaches T-I6 or T-I4.** The observed row set {T-I1} matches no
enumerated branch, which §5 makes a finding; the finding is mine and this is its
cause.

**The correction improves M03-I1 rather than damaging it, and this is the
campaign's best single result.** `SEALED` §6 bound 3 hedged that M03-I1's
1000-cycle scale is *"proven load-bearing by neither"* of its two qualifiers
unless T lands in (100, 1001]. T = 255 lands there — and with the inventory
corrected, M03-I1's 1001-cycle prefix is the **only** idle run in the repository
that can see any defect with T > 100. I-c8 reddened M03-I1 and **nothing else,
anywhere**. Its scale is not merely load-bearing but **uniquely** so: delete
M03-I1 and this defect class escapes the programme entirely.

### 5. FINDING S-2 — I-c10's message column is falsified at four of five scored rows, and the datum that falsifies it was disclosed

**Sealed** (`SEALED` §3): five worked messages, every one a **strobe** check.
**Observed**: four of the five are the row's **clean-FCS `tuser`** check.

| unit | sealed | observed |
|---|---|---|
| T-I1 | `an error strobe pulsed somewhere in this run …` | `tuser[0] set -- expected a clean FCS verdict after a long idle window` |
| T-I2 | `an error strobe pulsed on a clean frame` / `a strobe pulsed at or after cycle 13 …` | `tuser[0] set -- expected a clean FCS verdict` |
| T-I3 | `baseline: an error strobe pulsed on an idle-only gap` | `baseline frame 1: tuser[0] set -- expected a clean FCS verdict` |
| **T-I4** | `M03-I4 baseline (length 64, lane 0): an error strobe pulsed on the plain, un-injected baseline run` | **identical, character for character** |
| T-I6 | `an error strobe pulsed -- idle injection must not change which REQ-107/REQ-108 class …` | `tuser[0] set -- expected a clean FCS verdict, this frame's own class is unchanged` |

**All four falsified cells stand unedited.** The mechanism is not obscure and it
was **disclosed**: the manifest's I-c10 mechanism paragraph and its
second-standing-clause reach note both state that *"REQ-107's own consequences
travel with the condition, so the same frames take `tuser` bit 0 = 1 on their
`tlast` word through `abort`"*. The seal read the disclosure question it had
asked — *"which strobe, and the offset"* — and derived only the strobe's
consequence.

**Root cause, one thing, and it is a re-use failure rather than an analysis
failure.** The seal had already established this exact ordering, one section
earlier, for I-c2: *"`tuser` at `:1097` (M03-I4) and `:1596` (M03-I6),
`error_pulses` at `:1156` and `:1607`"*. The same ordering holds at M03-I1
(`:326` before `:346`), M03-I2 (`:474` before `:501`/`:505`) and M03-I3 (`:669`
before `:789`). **Every row in family I checks the frame's verdict before it
checks the run's strobes**, and the one cell that matched — M03-I4's *baseline* —
matched precisely because `run_i4_length_lane`'s own `error_pulses` check
(`:1267`) is the first assertion in the unit, ahead of any per-word loop. The
seal worked that cell and got it exactly right; it did not re-work the other four.

**Materiality: none to the kill, none to the M03-I2 ruling, and that is worth
saying plainly.** I-c10 is killed once, at the cell whose message was exact. And
a `tuser` red at M03-I2 is *further* from the tight window than the
`error_pulses` red the seal expected, so §3's ruling is strengthened by the
falsification, not weakened by it.

### 6. FINDING S-3 — §4(e)'s reach derivation for I-c10 is too wide, and all seven greens are explained rather than adjudicated per row

**Sealed** (`SEALED` §4(e)): thirty-five REQUIRED cells, the trigger *"a frame
closes, which every M03 unit except T-ST provides"*, and the rule *"a green is a
FINDING — it would mean a row that cannot see a spurious strobe on its own
frame's closure … adjudicated per row"*.

**Observed: 28 red, 7 green.** The greens are **T-C4, T-E1, T-E2, T-E5, T-F1,
T-F2, T-F3**, and **every one is explained by the auditor's disclosed reach**:

- `a_close_runt = a_close_terminate &: (count_cleared <:. 64)` fires only on
  frames closed by a **terminate character**. **T-E1** (`/E/` in each of eight
  mid-frame lanes), **T-E2** (`/E/` at the frame's first octet) and **T-E5**
  (`/E/` at preamble positions) close under REQ-105 with `a_close_terminate` low
  — the manifest says so in terms: *"Frames closed by `/E/`, by `/S/` or by
  REQ-108's count … are untouched entirely."*
- On a frame that is **already a runt** the mutation is the identity: the
  record's `runt` field would have been set anyway. **T-C4** is *"the 5-octet
  runt"*, **T-F1** is *"5, 16, 60 and 63-octet runts"*, **T-F2** is *"0, 1 and 4
  octets"*, **T-F3** is *"a 63-octet frame with a wrong FCS"*. All below 64.
- The rows that *do* carry a legal terminated frame reddened, including inside
  those same families: **T-E4** (*"following frame intact"*) and **T-F4**
  (*"63 is a runt, 64 is legal"*).

**Adjudication: none of the seven is a row finding.** No row is blind to anything
it should have seen. The finding is against §4(e)'s own derivation, which took
"a frame closes" as the trigger when the disclosed trigger is "a frame closes on
`/T/` **and** its true count is ≥ 64". **I-c10's true reach is 28 M03 units, not
35**, and T-ST is green as sealed, for the reason sealed.

### 7. FINDING S-4 — I-c6's member field, and a disclosure axis the seal had no column for

**Sealed**: `M03-I4 (length 64, lane 0, idles 1): delivered octets differ …` and
`M03-I6 (length 64, lane 0): delivered octets differ …`.
**Observed**: the same assertion text, character for character, at **lane 4** —
`M03-I4 (length 64, lane 4, idles 1)` and `M03-I6 (length 64, lane 4)`.
**Both cells stand unedited.**

Row set exact ({T-I4, T-I6}), branch exact (§5.6 **(i) signature** — verdict
clean, confirmed by the harvest), instrument exact (the delivered-octet
equality). The member is wrong because §5.6 branched on **one** axis, the
verdict, and the manifest disclosed a **second**: *"the class has instances at
**lane-4 starts only** … at offset 0 the aligned word *is* the previous input
word, no output word's assembly spans a held cycle, and `bubble` is identically
0."* That moves the first case that can differ from (64, lane 0, idles 1) to
(64, lane 4, idles 1) at both rows. **The disclosure was complete; the seal's
enumeration was not.** The cell scores — §5's finding condition is an unmatched
**row set**, and the row set matched.

### 8. FINDING A-1 (against the auditor's disclosure) — I-c1's "the 1518 + 7-idle crossing actually occurs: **YES**" is falsified by measurement

The round's one finding against a disclosure. Disclosures are scoring inputs, so
it is scored as its own class.

**Disclosed** (manifest §3 I-c1, repeated in its §4.2 table): *"**YES.** … at
N = 1518 with 7 idles at every in-frame boundary the mutated total passes 1518
after roughly 24 of the frame's 190 source words, so the crossing happens with an
enormous margin rather than marginally"*, with the mechanism spelled out —
*"`cap_room` falls below 8, `cap_end` binds below `a_char_end`,
`a_close_oversize` rises, the frame is truncated there, the state machine enters
`Discard`, `error_oversize` is raised"*.

**Measured**: under `mut/wo-0061-i-c1` the **whole of `test_m03_i.ml` is green** —
all five units, both members of M03-I6 included. The only reds in the 36-unit M03
bench are **T-F1, T-F2 and T-G7**, and all three are **gapless** consequences of
the disclosed lane-0-terminate reach, not REQ-108 crossings. The counter crosses;
**the truncation does not happen.**

**Why, and both reasons are in the base file the manifest read in full.**

1. `a_close_oversize = a_open &: (cap_end <: a_char_end) &: (cap_end <:
   a_hold_end) &: (cap_end <:. 8)` (base lines 361–362). On an all-idle in-frame
   word `a_hold_v = other_ctl &: ~:a_pre_mask` = `0xFF`, so **`a_hold_end` = 0**
   and `cap_end <: a_hold_end` is unsatisfiable. **Truncation is structurally
   impossible on precisely the cycles this mutation inflates.** With the count
   advancing by exactly 8 every in-frame cycle from a reload of 0, `cap_room`
   lies in [1, 7] at exactly one value — `count` = 1512 = 8 × 189 — and under
   `uniform` at k = 7 the covering words sit at in-frame cycles ≡ 0 (mod 8) while
   189 ≡ 5, so **that unique cycle is a held cycle.**
2. `cap_room = of_int ~width:count_bits 1518 -: count` (base line 342) with
   `count_bits = 11` (line 148) is an **unsigned 11-bit subtraction**. The next
   cycle takes `count` to 1520 and `cap_room` **underflows** to 2046, after which
   `cap_room >=:. 8` is permanently true and `cap_end` saturates at 8. The cap
   never binds again for the life of the frame.

At the terminate character `count_next` has wrapped to a value comfortably above
64, so `a_close_runt` is low and `has_fcs` is true; the frame closes with the
right octets, the right cycles and a clean verdict. **M03-I6 green is correct
behaviour of the bench against a mutant that, on the injected half, is
observationally equivalent to the base design.**

**Severity: MAJOR, and material.** The disclosure is what selected `SEALED`
§5.1's **wide** branch and therefore both of I-c1's REQUIRED cells, neither of
which was reachable. §3's pre-authorised escape for this class — *"say so rather
than seeding a diff that cannot fail"* — was correctly declined for the reason
offered (the arithmetic crossing is real) but should have been invoked for the
**injected half** on the observable question. The manifest's own I-c3 entry
states the deciding fact — *"`a_hold_end` no longer participates in
`a_close_oversize`, so a word whose hold lane lies below the REQ-108 cap no
longer suppresses the truncation"* — and read at I-c1 it refutes I-c1's
disclosure.

**What this does *not* change.** I-c1's adjudication was already fixed by
`SEALED` §5.8 branch (iv) before any of this was known, and that ruling stands
independently: the gate was disclosed as firing on a **lane-0 terminate
character**, a gapless event in every family, so the class *"is scored as the
class not seeded as specified — a scope report, not a bench result — and no claim
about any row is made from it in either direction."* **T-F1, T-F2 and T-G7's reds
are therefore not MUST-STAY-GREEN violations, and the green I units are not
falsified cells.** They are void. The seal earned that clause and it is applied.

For the record, because the reads are worth having: I-c1's three reds are the
disclosed +8-at-a-lane-0-`/T/` reach doing exactly what the disclosure said it
would. **T-F1**'s 60-octet runt reads 68 and its `error_runt` is suppressed
(`tuser[0] is not set on a runt`). **T-F2**'s 0-octet frame reads 8, which
crosses `fcs_min_octets` = 5, so `has_fcs` turns on and a second strobe appears
(`expected exactly one strobe pulse (error_runt only), observed 2`). **T-G7**
gains a third strobe by the same route. **The disclosed reach is confirmed; only
its injected half is refuted.**

**A-2, recorded to the auditor's credit rather than as a finding.** I-c10's
offset disclosure is exact (`+1` measured against `+1 or +2` disclosed) and it
was **volunteered under the second standing clause rather than engineered**: the
manifest explicitly refused to reach for a `+3` rendering that would have
exercised M03-I2's window, on the correct ground that it would have been a
different class. That refusal is what makes §3's ruling a measurement instead of
an artefact. **A-3**: the `tuser` co-travel note is likewise correct and
complete; the disclosure did its job and my seal failed to consume it (S-2).

### 9. The seal's hard predictions that held, recorded because the falsifications are recorded

- **I-c7's `expected 5`.** Derived in the seal from `D(0) = (8+8+12)/8 = 3`, the
  wrapper's first site at `before_cycle` = 3, shift 1, `baseline_cycle(0)` = 4.
  Sealed requirement `<mutant> < 5`, predicted value 4. **Observed: `word 0
  arrived on cycle 4, expected 5`.** Exact, including the mutant's own value.
- **I-c3's 16 and 64, and I-c5's 1 at both units.** All four derived counts exact.
- **I-c5's "one output word on either closure path".** The manifest disclosed the
  `/E/` path; the seal predicted `got 1` on **both** paths and said why. Exact.
- **I-c8's shadowing call at M03-I1** — the count guard, not the prefix scan.
- **§4(g)'s monitor prediction for I-c9**, down to the report's own
  unexpected-pulse line: `cycle 15: M03 rx pulsed "error_bad_frame" and no
  expected event claims it — a strobe the stimulus did not create
  (requirements.md §0.6, REQ-008)`, 100 high cycles for 100 `/Q/` words, and the
  **baseline green / overlay red** split that is M03-I3's anti-vacuity proof.
- **T-ST green under I-c10**, for the sealed reason: `test_m03_structural.ml`
  opens no frame, so there is no closure for the pulse to attach to.
- **§1's three iteration orders**, confirmed by every observed row prefix:
  `M03-I2 (member i, 64 octets, lane 0)`, `M03-I4 baseline (length 64, lane 0)`,
  `M03-I6 (length 64, lane 0)`.

### 10. Qualification rulings

**M03-I1 — QUALIFIED, and its scale is proven uniquely load-bearing.** Killed
I-c8 alone in the entire 116-unit suite, on its total-word count (`got 11`
against 8 — three spurious words at empty-cycles 255, 511 and 767 of its
1001-cycle prefix, at T = 255 repeating every 256; the arithmetic is exact). Also
red under I-c10, on `tuser` — blast radius, zero additional kills. `SEALED` §6
bound 3 is **resolved in the row's favour** by S-1's corrected inventory.
Standing bound, unchanged and exact per §4.5: the row is qualified on its **count
guard**; its idle-prefix `tvalid` and strobe **absence scans remain
unexercised**, and no defect of the output-word shape can reach them.

**M03-I2 — NOT QUALIFIED.** §3 above is the ruling in full. Its only qualifier
was I-c10; I-c10 died elsewhere; the row's red is blast radius on the bench's
most generic assertion; its C-14.3 window has still never spoken; and the window
is unreachable by any threshold-class defect. **This is the campaign's designed
outcome, not its failure** — the question was worth asking precisely because the
answer could be this one, and the packet fixed in advance that no packet may say
otherwise.

**M03-I3 — QUALIFIED, narrowly, and by its stimulus rather than by its
assertions.** Killed I-c9, with a row set of exactly {T-I3} out of 116 units. The
detection is **monitor-caught** (§4(g)), so what is proven is the **overlay
construction** — a `/Q/` run driven against a cycle-for-cycle idle-only baseline,
red on the overlay and green on the baseline, which is the anti-vacuity property
the row was built to guarantee and which no other row in the bench has. What is
**not** proven is either of the row's own in-window absence scans: the `tvalid`
scan is shadowed by two structural checks (§4.5, sealed) and the strobe scan by
`assert_monitors_clean` (§4(g), sealed). I-c8's contingent qualification
(branches iv–vi) did not materialise: T = 255 > 100. Also red under I-c10, on
`tuser` — blast radius.

**M03-I4 — QUALIFIED, by the widest margin in the campaign.** Killed six classes
on **five distinct instruments**: FCS verdict (I-c2), word count upward (I-c3),
strobe (I-c4), word count downward (I-c5), delivered content (I-c6), per-word
cycle (I-c7); plus the I-c10 baseline red on its own `error_pulses` check, the
one I-c10 cell whose message the seal got exactly right. Two specific debts
discharged: **(a)** the delivered-octet equality convicted for the first time
(I-c6) — `J-dv_lead-0093`'s second named kill for the count-guard-blind class,
measured rather than asserted; **(b)** the **lane-0 half of the re-based cycle
instrument convicted for the first time** (I-c7, `cycle 4, expected 5`). That
instrument had spoken once ever, at a lane-4 start (BUG-0003), and `SEALED` §7's
careful weighting stands: this does not re-prove BUG-0003, it proves the re-based
instrument convicts where it had never had to. **Left open**: `WO-0061` §8 bound
1's `tkeep` instrument at an injected run rode on I-c1's wide branch alone, and
I-c1 is void — so that bound ends this round **half measured**, exactly as it was
pre-named: the delivered-octet half is measured, the `tkeep` half is not.

**M03-I6 — QUALIFIED**, on the same five instruments as M03-I4 (I-c2 … I-c7) plus
the I-c10 blast red. **With one measured gap that is new and belongs on the
record**: every M03-I6 red in this campaign came from a **64-octet** member — at
lane 0 for I-c2/c3/c4/c5/c7/c10, at lane 4 for I-c6. **The 1518-octet member
contributed no detection anywhere.** I-c1 was the only class aimed at it and I-c1
is void; I-c8's second site was S-1's drain-length error. On this evidence
M03-I6's 1518-octet member is **unexercised by every defect class this campaign
could construct** — a coverage statement, not a criticism of the row: it exists
to hold REQ-108's threshold under injection, and no seeded class reached that
threshold observably.

**Four of five rows qualified. One — M03-I2 — is not, and the campaign's central
question is answered in the negative.**

### 11. Headline numbers, in this packet's own denominators

- **Classes seeded: 10. Branches red: 10 of 10. Scoreable classes: 9** (I-c1
  excluded by `SEALED` §5.8(iv), a rule fixed before any diff existed).
  **KILLS: 9 of 9.**
- **Sealed REQUIRED cells on the branches the disclosures select: 50** (I-c1's
  void cells excluded). **Met: 42.** Falsified: **8** — one under I-c8 (T-I6) and
  seven under I-c10 (T-C4, T-E1, T-E2, T-E5, T-F1, T-F2, T-F3). All eight stand
  unedited.
- **Worked (message-sealed) cells among them: 20. Character-exact: 13.
  Text-exact with a falsified member field: 2** (I-c6). **Falsified: 5** — one
  unreachable (I-c8 × T-I6) and four wrong-assertion (I-c10 × T-I1/I2/I3/I6).
  **UNWORKED I-c10 cells: 30** — 23 red (predicted blast, zero kills, per §4(e))
  and 7 green (S-3; none a row finding).
- **MUST-STAY-GREEN, M03: 274 cells across the nine scoreable classes
  (34 × 7 + 35 + 1). Violations: 0.**
- **MUST-STAY-GREEN, non-M03: 800 cells (80 units × 10 classes). Violations: 0.**
  No file outside `test/xgmii_rx_64/` was promoted on any branch. **No
  build-level finding**; §1's and `SEALED` §0's blast-radius argument is
  confirmed empirically at 800 cells for the fourth campaign running.
- **Instrument families exercised: 6** (word count, FCS verdict, delivered
  content, per-word cycle, row-local strobe, strobe monitor) at **9 stimulus
  geometries**.
- **Findings: 6.** Against my seal: **S-1** (major — I-c8's idle-run inventory),
  **S-2** (major — I-c10's message column), **S-3** (moderate — §4(e)'s reach),
  **S-4** (minor — I-c6's member field). Against the auditor's disclosures:
  **A-1** (major — I-c1's crossing claim). Recorded to the auditor's credit:
  **A-2**, **A-3**. **Zero findings against any bench row.**
- **Plan coverage unchanged: 38 of the plan's 62 ASSERT rows discharged.**
  Families **J, K, M, N** and **L1–L5** unwritten; the verilog-ethernet anchor
  undischarged.

### 12. Consequences

- **`SO-xgmii_rx_64.md` does not issue and is not offered.** §7's closing
  paragraph is unchanged by this result. This campaign qualifies four units and
  fails to qualify a fifth; it does not sign off a module.
- **`WO-0061` §4.2's CRITICAL-against-me branch is CLOSED.** I-c5 died at both
  units with the sealed count of exactly 1, so the wrapper's injected idle words
  demonstrably reach the design inside an open frame. **Family I's injected half
  is not vacuous**, and the hypothesis that would have been a CRITICAL finding
  against dv_lead is refuted by measurement rather than argued away. I-c2, I-c3,
  I-c4, I-c6 and I-c7 dying on the same stimulus are the corroboration.
- **The SEALED companion is not edited, now or ever.** All eight falsified cells
  stand as frozen. This block is the correction of record.
- **Owed to `test/**` at its next touch**, joining `J-dv_lead-0094`'s two carried
  notes (the count-guard identity at its own sites; guard ordering): **(iii)** a
  note at M03-I1/I2/I3/I6 that the clean-FCS `tuser` check precedes every strobe
  check — the ordering S-2 shows actually decides what a strobe-class defect
  reports; **(iv)** a note at M03-I6 recording that its 1518-octet member is
  unexercised by any constructed defect class; **(v)** a note at
  `run_i6_case`/`run_i4_case` that `drain = injected + 8` yields an **8-cycle**
  tail rather than `injected + 8` cycles of tail — S-1's misreading, written down
  where the next reader will meet it. **No bench file is opened in this round**,
  per §4.5's closing clause.
- **Two plan rows are earned and are footnoted rather than added here**, on the
  WO-0058 precedent: a prolonged-idle row whose threshold is *below* 100 cycles
  (nothing in the suite between 8 and 100 can see one), and a report-path-delay
  row for M03-I2's window.
- **Nothing is owed to the auditor beyond A-1's correction**, which is a
  disclosure defect and not a conduct defect. The blinding was complete, the ten
  diffs were faithful, the disclosures decided the scoring of four of the nine
  kills before any result existed, and the one that decided M03-I2's fate was
  volunteered rather than engineered.
