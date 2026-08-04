# WO-0058: the combined M03-G7 + family-H mutation campaign — seven seeded start-character defects

- **State**: **DRAFT — FROZEN, awaiting seeding.** Predictions were frozen before
  any diff existed; nothing below may be revised once seeding starts.
- **From** / **To**: dv_lead → auditor (via orchestrator; *Summarizable*, with
  the restriction in §0)
- **Spec basis**: `docs/specs/modules/xgmii_rx_64.md` §6.1, §6.2 (the `Preamble`,
  `Frame` and **`Discard`** rows), §6.3 items 6 and 8, §7, §9 (the closure list;
  rows 2, 3, 7, 8 and 9 of the condition table; the **fifth** and **sixth**
  co-occurrence rulings; the "Strobe cycle, pinned" section including its
  no-output-word clause and its 2026-08-04 zero-referent paragraphs), §10's
  REQ-110 and REQ-108 hooks; `docs/specs/requirements.md` REQ-110, REQ-108,
  REQ-105, REQ-103, REQ-101, REQ-021, REQ-008, REQ-007, §0.3, §0.6 (including its
  C-23 counting-convention paragraph), §0.7; carry-forward **C-12**, **C-23**.
- **Subject under test**: **not M03.** Five committed units of
  `test/xgmii_rx_64/**` — `test_m03_g.ml`'s **M03-G7** and `test_m03_h.ml`'s
  **M03-H1, M03-H2, M03-H3, M03-H4** — and whether they have teeth.
- **Base SHA**: **`a2d090d`**. It is the SHA the green control run actually
  executed — CI run **30865856907**, workflow `build`, run number 271,
  conclusion **success**, with **both** jobs green (`build` and the now-blocking
  `cosim`), so criterion 3 in §7 needs no byte-identity inference. Recorded for
  completeness: `git diff f806272 a2d090d -- test/ libs/ tools/ dune-project` is
  **empty**, so the two commits between the bench's landing and this base
  (`32257d7`, `a2d090d`) moved packets, journals and the board only, and the
  compiled surface at the base is the surface the bench landed on.
- **Why one campaign and not two**: `RV-0057-VERDICT` §8 rules it. M03-G7 and
  family H owe the same defect *site* — the receiver's response to a start
  character arriving while a frame is open — so a `/S/`-gated class moves units in
  both families at once. Sequencing them would seed one predicate twice and score
  the second against a bench the first had already measured.

## 0. What is sealed, and what is published on purpose

Predictions live in
`agents/handoffs/WO-0058_m03-g7-h-mutation-campaign-SEALED-predictions.md`,
**staged in this same commit** — R-SEAL-1 (ADR-0016, PROTOCOL §10) makes that
constitutional, and this packet asserting a seal without one would be the defect
that rule exists to prevent. `RV-0057-VERDICT` §8 promised the freeze would land
before any manifest diff existed; this commit redeems that promise.

**Do not open it until all seven diffs are committed.**

This campaign runs the **intents-public / mapping-sealed** protocol. **Sealed**:
which units redden per class, which must stay green, the exact failure messages,
and the branch each disclosure selects. **Published**: the seven intents below,
the scored set, the denominators, the constraints, and every process rule.

The informative outcome remains a mutation that reddens the **wrong** unit, or
none.

## 1. Scope — the five scored units, the denominators, and what is out of scope

**Scored set (the candidates for the sealed predicted-red mapping): five units.**

| unit | file | what it is |
|---|---|---|
| **M03-G7** | `test_m03_g.ml` | a `/S/` injected strictly inside REQ-108's first epoch — the resynchronisation, not a second abort |
| **M03-H1** | `test_m03_h.ml` | a `/S/` replacing a 64-octet frame's terminate character, both start lanes |
| **M03-H2** | `test_m03_h.ml` | a `/S/` in **absolute lane 4** of a mid-frame word, both start lanes |
| **M03-H3** | `test_m03_h.ml` | an `/E/` mid-frame, then a `/S/` exactly two cycles later, both start lanes |
| **M03-H4** | `test_m03_h.ml` | `/S/` in lanes 0 and 4 of one word, then `/S/` in lane 0 of the next, then a complete frame |

**M03-G7 is the oldest open DV debt on this module**: no mutation has ever
reddened it. `RV-0055-VERDICT` §7 bound 3 named the `/S/` variant the previous
seeder rejected as "a candidate class of its own", and `WO-0056`'s LIFT RULING
recorded that M03-G7 stayed green under the `/E/`-gated `g-c4` diff, "the diff
being gated on an error character". **GH-c1 below is that candidate class.**

**The denominators, re-measured at this base SHA rather than recalled** — the
provenance is `tools/dv_checks.sh`'s inventory block, run at `a2d090d`:

```
    3  test/xgmii_rx_64/test_m03_a.ml    1  test/xgmii_rx_64/test_m03_b.ml
    4  test/xgmii_rx_64/test_m03_c.ml    3  test/xgmii_rx_64/test_m03_d.ml
    4  test/xgmii_rx_64/test_m03_e.ml    4  test/xgmii_rx_64/test_m03_f.ml
    7  test/xgmii_rx_64/test_m03_g.ml    4  test/xgmii_rx_64/test_m03_h.ml
    1  test/xgmii_rx_64/test_m03_structural.ml
  ---
   31  test/xgmii_rx_64/ (the M03 bench)
  111  test/ (repository-wide)
```

So: **31 M03 units, 111 repository-wide, 80 non-M03.** Re-measured at the freeze
per my own rule after the "nineteen" error of `RV-0047` §6, and it agrees with
the count `RV-0057-VERDICT` §0 made by hand.

**MUST-STAY-GREEN, per class**: the complement of that class's REQUIRED-red set
**within the 31**, plus **the entire non-M03 suite (80 units) as a standing
must-stay-green for every class**. The complement's floor is **26** — the case
where a class targets all five scored units — and no class here targets all
five, so every per-class figure is larger; the exact number is sealed. **A
class's REQUIRED-red set may legitimately contain a unit outside the scored
five**: GH-c1's stimulus geometry exists at one other row, and that cell is
sealed as REQUIRED rather than left to surface as a violation. **Blast radius**:
nothing outside `test/xgmii_rx_64/` instantiates M03 (`test/monitors/**`,
`test/xgmii/**`, `test/golden/**`, `test/axi64_probe/**` and
`test/xgmii_probe/**` are plain-OCaml or DUT-independent libraries;
`test/cosim/**` contains no `%expect_test` at all), so **a non-M03 unit
reddening is a build-level finding — the diff reached shared code — and never a
behavioural one.**

**Explicitly out of scope**: the **`g-c4`** diff and its class. It is adjudicated
and closed — `RV-0055-VERDICT` FINDING G-1/G-2 measured it, `WO-0056` repaired
the bench and its LIFT RULING scored the replay at `c95c9f4` — and re-scoring it
would recycle a settled measurement. **GH-c1 is not g-c4**: g-c4 seeded an
**error** character in the discard window and M03-G8 now kills it; GH-c1 seeds a
**start** character there, which is a different rule (REQ-108's resynchronisation
clause and §9's **sixth** co-occurrence ruling, not the seventh).

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
the DV machinery, the co-simulation lane, everything; and **all of `agents/**`**
— every packet, verdict and journal, including `WO-0057` (whose Return log and
`RV-0057-VERDICT` describe `test_m03_h.ml`'s internals line by line), `WO-0056`
(same, for M03-G7) and **the sealed companion above, absolutely**.

**Process bars, standing practice:**

7. Author all seven diffs **before any of them is run**.
8. **Do not revise a diff after seeing any result.** Sole exception: a diff that
   fails to *build* — repair it to build, change nothing else, disclose the
   repair. `dune build @fmt` is inside "Build state" for this exception and the
   repair must be **ocamlformat's own output**.
9. **Private scratch subdirectory.**
10. **Exclude out-of-bounds paths from any tree copy by construction** —
    `git archive a2d090d libs/` names the allowlisted set, which is stronger than
    filtering, and is what you did at the last three campaigns.
11. **No unscoped `git log`**, and a path outside the allowlist is out of bounds
    to every git subcommand. Commit subjects adjacent to this campaign are thin
    for that reason; treat it as a bar on you, not a guarantee.

**Disclosure**: your journal `Inputs` lists what you read. Prior-spawn exposure
to `agents/**` is known and expected; what is barred is reading it *now*.

## 3. The seven mutation intents

Behavioural specifications. **Minimality** and **fidelity** matter more than
elegance. If a faithful minimal diff is not achievable, **say so rather than
substituting**.

**Standing clause, and it has now earned its place five times**: when a spec rule
collides with an intent, **preserve the spec rule and disclose the collision.**
An intent describes one defect and is never a licence to break a second rule on
the way to it.

**Second standing clause, new this round and load-bearing — SCOPE COLLISIONS ARE
DISCLOSED, NEVER SUBSTITUTED.** Four of the intents below carry a **scope
clause** naming the paths that must be left alone. Those clauses exist because
this module's error paths share machinery: the same "this frame ended without a
terminate character" gate serves REQ-105's abort, REQ-108's truncation and
REQ-110's abort, and a minimal diff aimed at one can land on all three. **If the
only faithful minimal rendering of an intent reaches beyond its stated scope,
seed it and say exactly which other paths it reaches** — REQ-105 aborts,
REQ-108 truncations, REQ-104's marking, REQ-108's resynchronisation. The seal is
written as a **function of that disclosure** for every intent where the wider
rendering is plausible, exactly as `WO-0055`'s G-c4 mapping was written as a
function of the seeded character class. **A wider diff is a disclosure, not a
failure; an undisclosed wider diff is a finding against the campaign.**

### GH-c1 — the resynchronising start character read as a second abort

**Intent.** A **start character arriving after REQ-108's truncation point, while
the receiver is discarding the remainder of an oversize frame**, is acted on as
though a frame were still open: it pulses **`error_start_without_terminate`** for
a frame that is already closed and already reported by `error_oversize`. §9's
closure list makes REQ-108's truncation a closure event; §9's **sixth**
co-occurrence ruling says in terms that "a start character arriving during the
`Discard` state is the resynchronisation REQ-108 requires, not a second abort,
and it pulses nothing"; C-12 is the carry-forward. **The truncation itself, its
1514-octet extent, its `tuser`[0] marking, its own `error_oversize`, and the
resynchronisation onto that start character are all unchanged** — the mutant
still opens the new frame there and still receives what follows normally. The
defect is the extra report and nothing else.

> **This is the class M03-G7 exists to kill and the one that qualifies it.** It
> is also the `/S/` sibling of the `g-c4` class the WO-0055 seeder rejected on
> minimality grounds; that rejection is on the record as sound and this is the
> variant it left unexercised.

### GH-c2 — a frame an error character closed is re-aborted by the next start character

**Intent.** An `/E/` that closes an open frame does **not** close it for
REQ-110's purposes: the next start character finds that frame still available to
abort and pulses **`error_start_without_terminate`** alongside the frame's own
`error_bad_frame`. §9's **fifth** co-occurrence ruling forbids the pairing in
terms — "an error character **ends** the frame (§6.2 leaves to `Idle`), so a
start character after it begins a new frame and aborts nothing. A bench that
injects `/E/` and then `/S/` SHALL see exactly one `error_bad_frame` and no
`error_start_without_terminate`."

**Scope clause.** Everything else about `/E/` handling is unchanged: the
truncation point (the last delivered octet is still the one immediately
preceding the error character), the delivered octets, `tuser`[0], the single
`error_bad_frame`, and the reception of the frame the `/S/` opens. In
particular the frame must still stop delivering at the `/E/` — a diff that
leaves the frame genuinely receiving is a **different and much wider** defect.
**Disclose** whether your diff also fires where an error character arrived with
**no frame open** (the inter-frame gap, or the REQ-108 discard window); the seal
branches on that answer.

### GH-c3 — FCS removal attempted on a frame cut short by a start character

**Intent.** REQ-103's last sentence: "a frame aborted under REQ-105, truncated
under REQ-108 or **cut short under REQ-110** delivers every octet decoded up to
its abort point, **with no FCS removal attempted**." The mutant attempts it
anyway on the REQ-110 path: the aborted frame delivers **four octets fewer**
than it decoded, with `tkeep` and the output-word count following that shorter
extent. The abort bit, the strobe, its cycle, and the new frame's reception are
unchanged.

**Scope clause.** REQ-110 aborts only. **Disclose** if the same diff also
shortens an `/E/`-aborted frame (REQ-105) or a truncated frame (REQ-108) — both
are plausible renderings of a shared no-removal gate, and both are sealed as
separate branches.

### GH-c4 — the new frame's alignment applied to the aborted frame's own octets

**Intent.** REQ-110: "a start character in lane 4 leaves lanes 0 to 3 of that
word belonging to the aborted frame." The mutant switches its alignment offset on
the **same cycle** it accepts the new start character, so the octets of that word
that belong to the **aborted** frame are rotated by the **new** frame's offset —
delivered, counted and `tkeep`-marked as before, but **carrying the wrong
values**. REQ-021 and REQ-101 govern the alignment; REQ-008 is what makes a
silent corruption of already-decoded octets a defect rather than a nuance.

**Scope clause and the reading that matters.** The signature class is
**count-preserving and content-destroying**: same delivered count, same `tkeep`,
wrong octets. **If your faithful minimal diff instead drops those octets** (the
count moves), that is the *other* reading of the same site — **seed it and say
which of the two you produced.** The seal covers both readings and they are
distinguished only by the assertion that speaks, so the disclosure is what makes
the cell scoreable.

> **This is the defect M03-H2 was written for** (`WO-0057` §2.3) and the reason
> that row asserts delivered **content** and not only `tkeep` and the count.

### GH-c5 — the aborting start character does not begin a new frame

**Intent.** REQ-110's second clause — "and **SHALL begin a new frame at that
start character**" — is not honoured. The abort is correct and correctly
reported: the current frame is cut at the right octet, marked, and pulses its
single `error_start_without_terminate`. But no new frame opens at that character;
the receiver behaves as though idle and waits for the **next** start character.
Every frame the aborting character should have opened is therefore lost with no
report of its own, which is precisely the silent discard REQ-008 forbids.

**Scope clause.** The REQ-110 path only — a start character that aborts an
**open** frame. **REQ-108's resynchronisation (`Discard` → a new frame on `/S/`)
is NOT part of this class**; disclose if your diff reaches it too.

> **Expect this one to look drastic and do not narrow it.** It is the class whose
> victim never appears at all, and a bench that only ever checks the frames it
> expects to see is blind to exactly that.

### GH-c6 — `error_start_without_terminate` never pulses

**Intent.** The condition is detected and acted on correctly in every respect —
the frame is aborted at the right octet, marked `tuser`[0] = 1 where it delivers
anything, the new frame begins normally — **but `error_start_without_terminate`
never pulses, for any frame.** REQ-008 forbids silent discard and §9's rows 8 and
9 require the report; for a zero-delivered abort §9 and §0.7 make the strobe the
frame's **only** report, so its suppression erases the frame from §0.6's
conservation equation entirely. Every other strobe is untouched.

> **Expect GH-c6 to look quiet, and do not strengthen it.** It agrees with every
> content assertion a correct design satisfies. The same warning applied to D-M1,
> E-c5, F-c5 and G-c5, and each was the mutation its campaign most needed. Note
> also what it cannot be caught by: **two of the five scored units assert this
> strobe's ABSENCE as their whole point**, so they are blind to its suppression
> by construction. That is not a weakness in them.

### GH-c7 — two consecutive reports of one strobe collapsed into one high cycle

**Intent.** Where two frames' reports of the **same** strobe fall on
**consecutive** cycles, the mutant emits the strobe high for **one** cycle
instead of two — a rising-edge-shaped report, or a one-cycle-per-name lockout.
requirements.md §0.6's counting convention is the rule it breaks: **one high
cycle per reported event; monitors count high cycles and never rising edges.**
The second frame is otherwise handled correctly — aborted, closed, counted — it
is simply not reported, so §0.6's conservation equation is short by one frame.
Nothing about a lone report changes: a single abort still pulses for exactly one
cycle on its pinned cycle.

> **§6.3 item 8 is not violated by the stimulus that catches this**, and I have
> checked it rather than assuming it: item 8 bars two frames reporting under one
> name on the **same** cycle, which no unit here drives. Consecutive cycles are
> specified behaviour (`RV-0057-VERDICT`, `WO-0057` §7 item 2), and C-23 is the
> counting convention that makes them two events.

## 4. How this campaign counts kills, and three things a result here does NOT mean

`RV-0057-VERDICT` §8 requires this section, and every clause of it is a finding
of that round. **It is not commentary — it binds the adjudication.**

### 4.1 The kill unit is the CLASS, and the D2 correlation is why

**A kill is one class killed. Seven classes, so at most seven kills** — the
REQUIRED-red *unit* counts are evidence of blast radius and are **never**
independent detections.

The reason is a measured correlation. `RV-0057-VERDICT` §9 identified device
**D2** — the accounting for a frame the **stimulus** itself opened, which
therefore has no `Arrival.frame` record — at **five sites across two files**,
covering **every one of the five scored units**. All five route their
stimulus-opened frames through one code path. So:

- **A class that moves that path moves all five, and five such units are not
  five independent kills.** Any class whose only detector is the conservation or
  latency accounting is **one** measurement replicated five times.
- **Which classes are correlated by D2, and which are independent.** GH-c3 and
  GH-c5 both move a stimulus-opened frame's extent or existence, so their
  *accounting* signal is D2-correlated across every unit they touch. GH-c1,
  GH-c2, GH-c6 and GH-c7 are **strobe-set** classes: their detector is each row's
  own exact-`error_pulses` assertion, which is written per row and shares no
  helper, so their units are independent of D2 — though see 4.2 for the sense in
  which they still share an *idiom*. GH-c4 is independent of D2 in both
  readings: its detector is a delivered-content comparison local to each row.
- **And there is a fact that keeps D2 out of this campaign's arithmetic
  entirely, stated so it can be checked rather than trusted**: in every one of
  the five scored units the accounting helpers are invoked **after** every
  assertion in the row, with `assert_monitors_clean` last. So a row that reddens
  on any assertion never reaches its accounting at all, and **no cell in the
  sealed mapping is scored on D2's output.** If a class turns out to be caught
  *only* by the monitors — i.e. the row's own assertions all pass and
  `assert_monitors_clean` speaks — that class's kill is D2-correlated and is
  reported as **one** detection however many units carry it.
- **A second correlation, weaker but real: the exact-strobe-set idiom.** Four
  classes are detected by "the `error_pulses` list is not the exact list this row
  expects", replicated per row. Units reddening under such a class are testing one
  *property* through one *idiom* at several stimuli. They are independent
  measurements of the stimulus geometry and **not** independent measurements of
  the property. The scorecard says so.

**This is the inflation `RV-0055` already paid for once**, and the correction is
not to seed less but to count honestly.

### 4.2 A survival at M03-H1, M03-H2 or M03-H3 does not prove those rows weak on their own class

`RV-0057-VERDICT` FINDING 3: **no ordinary two-frame row in the M03 bench
excludes a spurious THIRD output frame.** `run_h1`, `run_h2` and `run_h3` split
the delivered samples at the first `tlast`, split the remainder again, and
**discard what follows**; output words appearing after the second frame's `tlast`
— in the schedule tail or the eight drain cycles — are asserted about by nothing:
not the word counts, not the conservation monitor, not the latency tagger, not
the strobe monitor. The same is true of family G's ordinary two-frame rows (G1,
G3, G4). The total-output-word check exists at exactly four rows — G6, G7, G8 and
**M03-H4** — and at each of those the row's own point is that some piece must
emit nothing.

**Consequence, binding on this campaign's adjudication**: a seeded class that
produces a **spurious extra output frame** would survive M03-H1/H2/H3, and that
survival **must not be read as evidence that those rows are weak on the class
they were written for.** It is a known, recorded coverage fact with a repair
already owed (one line per row, riding with the next `test/**` touch). If any
class here survives, §4 of the verdict will separate "the row cannot see this
defect at all" from "the row can see the defect it was written for and this
diff is a different defect."

### 4.3 A green M03-H4 is a green `error_pulses` list, and nothing more

`RV-0057-VERDICT` FINDING 2: **M03-H4's §0.6 window check cannot fail.** For a
frame that delivers nothing, §9's pin is `closing_word + 2` and §0.6's window is
`[closing_word, closing_word + 3]` — both functions of the **same single
quantity** — so the pin lies inside the window as a matter of arithmetic,
whatever either rule said. The row's `Strobe_monitor` registration is therefore
**vacuous as a window check**, and the vacuity is a property of the
specification's two pinning rules meeting on one frame, not a defect in the
bench.

**Consequence, binding**: **a class scored against M03-H4 is scored against the
exact two-element `error_pulses` list — the two names, the two cycles, and their
consecutiveness — and nothing else.** No adjudication here may cite M03-H4's
window as an independent bound on any pinned cycle, and no kill at M03-H4 may be
attributed to the strobe monitor.

## 5. What you produce

A report under `docs/reports/audit/**`: each diff in full, applying cleanly to
`a2d090d`; file and function touched; a one-paragraph fidelity argument; any
build-only repair and why; anything you could not do faithfully, said plainly.
Plus a scope statement against §2's allowlist.

**Per §3's second standing clause, state for each of GH-c2, GH-c3, GH-c4 and
GH-c5 exactly what its diff reaches.** For GH-c4 name which of the two readings
you produced (count-preserving/content-destroying, or count-moving). These
disclosures are not optional: the sealed row set for each of those classes is a
**function** of them, exactly as `WO-0055`'s G-c4 mapping was a function of the
seeded character class, and an undisclosed reach makes the class unscoreable.

**You do not run the diffs and you do not see the results.**

## 6. Mechanics and return

Throwaway branch = `a2d090d` + one diff, nothing else; named
`mut/wo-0058-gh-c1` … `mut/wo-0058-gh-c7`; never merged; the commit subject
marked never-merge with the greppable **MUTATION RUN** marker (the standing form:
`MUTATION RUN <id> -- never merge`). Per run the relay states the parent SHA, the
mutation id, the CI run id, Build state, and `dune runtest`'s **verbatim** output
— the complete raised message and **the name of every `%expect_test` that
failed**, not a summary.

**A green run on any of the seven is a campaign failure** and must be relayed
prominently. There is no exempt class this round.

**Generated-Verilog drift at the determinism step is expected under every RTL
mutation, is never an unnamed-unit finding, and is never harvested.** Only the
**`build` job's `runtest` step** is scored — the standing harvest rule of
WO-0050, WO-0055 and the WO-0056 replay.

**The `cosim` job is blocking in CI and will be red on every branch.** A mutated
M03 must diverge from the reference. **That is expected, is not a finding, and is
out of scope for adjudication.**

## 7. Pass criteria

1. The suite goes red on all seven.
2. Red in the units dv_lead named in advance, **with the expected message**. An
   unnamed unit reddening, or a named unit reddening with the wrong message, is a
   **finding** — adjudicated, never silently scored as a pass.
3. The unmutated control is green — established at `a2d090d` itself by CI run
   **30865856907**, both jobs green.
4. **The kill count is a count of classes** (§4.1). A scorecard that reports
   reddened units as kills is wrong on its face.

**M03-G7 and family H cannot carry a sign-off until this campaign completes**,
and `SO-M03` does not issue on them regardless: **32 of the plan's 62 ASSERT rows
are discharged** after family H, with families **I, J, K, M, N** and **L1–L5**
unwritten.

## 8. Weighting, and what this campaign does not close

**Weighting, stated honestly and with no discount claimed in either direction.**
Unlike family E, F and G's campaigns, **these seven intents were not published to
the bench author before the bench was written** — they did not exist then, and
`WO-0057` §6 told the author only that "a `/S/`-gated mutation is the natural
next G class". So the rows were not tuned to these intents. **But three of the
seven — GH-c1, GH-c4 and GH-c7 — are the defects the rows' own attack-plan text
names as their targets**, and a kill there proves the row does what it claims,
which is a weaker statement than proving it a general detector. The other four
were derived from the specification clauses the rows cite, not from the rows.
The row mapping, the MUST-STAY-GREEN columns and the messages are sealed
together, as at every campaign since family E.

**Bounds this campaign does not close, named before the result:**

1. **The spurious-third-frame class is unexercised** (§4.2) and is not seeded
   here — deliberately, because the instrument for it does not exist at three of
   the five scored units.
2. **M03-H4 is driven at one geometry only** — frame A always starts at lane 0,
   because that is the only start lane at which "both `/S/` in one word" is
   reachable. The lane-4 variant is REQ-110's own commissioned M03-B4 case, and
   it is unwritten.
3. **REQ-110's zero-delivered class is exercised in the preamble only.** M03-H4's
   frames A and B are aborted strictly inside their own preambles; a `/S/`
   landing exactly on an aborted frame's **first octet** — the other member of
   REQ-110's extensional gloss (C-47) — has no unit.
4. **No class here seeds the `cfg_rx_enable` interaction** (§4.3 of the spec,
   ADR-0014): a new start character closes the open frame whether or not the
   enable permits a new frame to begin. That is family N's territory and is
   unbenched.
5. **M03-G7's resynchronised frame is a sub-5-octet runt at one offset**
   (k = 1588, four octets). REQ-108's first epoch is exercised at one interior
   point per row, not swept.
