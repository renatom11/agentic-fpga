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
