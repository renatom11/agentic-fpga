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

---

## WO-0058-VERDICT: seven of seven classes killed, all five scored units qualified, two sealed cells falsified — dv_lead, `J-dv_lead-0080`

**The campaign passes, and the bench is not what went wrong.** All seven seeded
classes died. Every one of the five scored units — **M03-G7, M03-H1, M03-H2,
M03-H3, M03-H4** — reddened under at least one class with the message the seal
named, so **all five are qualified**, and M03-G7's qualification discharges the
oldest open DV debt on this module: no mutation had ever reddened it before.
**No seeded defect escaped. No MUST-STAY-GREEN cell moved, anywhere, in either
denominator.** The two deviations are both **against my own sealed predictions**,
not against a bench row: one REQUIRED cell stayed green because the seal's
arithmetic was wrong, and one REQUIRED cell reddened on a different assertion
than the seal predicted. **Both falsified cells stand in the SEALED file
unedited** — the G-1 precedent — and each is convicted below by quotation.

### 0. Conduct, admissibility, and the evidence base

The auditor's manifest (`docs/reports/audit/WO-0058-mutations/README.md`,
`480c38a`, `J-auditor-0010`) affirms the blinding affirmatively rather than by
silence: no file under `test/**` opened at any revision, no file under
`agents/**` beyond this packet, the sealed companion untouched at any revision,
no unscoped `git log`, and the one unscoped `git status --porcelain` disclosed
rather than smoothed. **All seven classes SEEDED; nothing NOT-SEEDED, nothing
substituted, nothing narrowed to build.** The four mandatory disclosures are
answered in the packet's own terms in its §4, and the two judgement calls are
flagged for reversal rather than buried. **Base identity is not taken on trust**:
the mutated blob is `81cd9ed…` at `a2d090d`, byte-identical to the blob three
prior campaigns mutated. The report's write-scope deviation (§0 — the named
deliverable `agents/handoffs/WO-0058_manifests.md` was outside the auditor's
scope, and R7 would have refused it) is **correct and is the only answer
available**: `agents/handoffs/` is precisely the directory holding this
campaign's seal. **The campaign is admissible.**

| class | branch | run | `runtest` | failing file |
|---|---|---|---|---|
| gh-c1 | `39bcccb` | 30868752152 | RED | `test_m03_g.ml` |
| gh-c2 | `4e84d64` | 30868753423 | RED | `test_m03_h.ml` |
| gh-c3 | `2ddb3db` | 30868754060 | RED | `test_m03_h.ml` |
| gh-c4 | `6795ae6` | 30868754798 | RED | `test_m03_h.ml` |
| gh-c5 | `63af79d` | 30868756316 | RED | `test_m03_h.ml` |
| gh-c6 | `e996f8e` | 30868757246 | RED | `test_m03_h.ml` |
| gh-c7 | `3cf90ac` | 30868758781 | RED | `test_m03_h.ml` |

`cosim` red on all seven, as §6 said it would be: a mutated M03 must diverge from
the reference. **Out of scope, not a finding, and not scored.** No Verilog-drift
result is harvested. **No green run** — §6's campaign-failure condition is not
triggered on any branch.

### 1. Per-class scorecard — kills are classes (§4.1), cells are blast radius

`R✓` = sealed REQUIRED, observed red, **message character-exact**.
`R✗msg` = sealed REQUIRED, observed red, **wrong message**.
`R→G` = sealed REQUIRED, **observed green**.

| class | branch the disclosure selects | sealed REQUIRED | observed | cells exact | verdict |
|---|---|---|---|---|---|
| **GH-c1** | none (no scope clause) | T-G7, T-G6 | T-G7 `R✓`, T-G6 `R✓` | **2/2** | **KILL** |
| **GH-c2** | §5.1 **(i) narrow** — disclosed **NO** | T-H3 | T-H3 `R✓` | **1/1** | **KILL** |
| **GH-c3** | §5.2 **(i) narrow** — disclosed **NO/NO** | T-H1, T-H2 | T-H1 `R✓`, T-H2 `R✓` | **2/2** | **KILL** |
| **GH-c4** | §5.4 **reading (a)** — disclosed count-preserving | T-H1, T-H2 | T-H2 `R✓`, **T-H1 `R→G`** | **1/2** | **KILL** + **FINDING GH-1** |
| **GH-c5** | §5.3 **(i) narrow** — disclosed **NO** | T-H1, T-H2, T-H4 | T-H1 `R✓`, T-H2 `R✓`, **T-H4 `R✗msg`** | **2/3** | **KILL** + **FINDING GH-2** |
| **GH-c6** | none | T-H1, T-H2, T-H4 | all three `R✓` | **3/3** | **KILL** |
| **GH-c7** | none | T-H4 | T-H4 `R✓` | **1/1** | **KILL** |

**Kills: 7 of 7 classes.** Not thirteen, not fourteen — §7 criterion 4 and §4.1
fix the unit as the class, and this scorecard reports classes.

### 2. The two pre-named collision rules, and the D2 test

Both were named before the result precisely so they could not be argued after it.
**Neither bites, and no kill is withdrawn for double-counting.**

- **§4(c) — GH-c3 against GH-c4(b).** The collision fires only if both classes
  report the same `M03-H1` lane label, i.e. if GH-c4 landed the count-moving
  reading. It landed **reading (a)**, disclosed and confirmed by the message
  itself: GH-c4 speaks at M03-H2 with `delivered octets differ from the k
  octets…`, GH-c3 with `unexpected output word count`. The row sets also differ
  (`{T-H1, T-H2}` against `{T-H2}`). **Two independent detections.**
- **§4(e) / §3's GH-c7 note — GH-c5 against GH-c7 at M03-H4.** The collision
  fires only if both produce a **lone** `observed 1` at M03-H4 with nothing else
  moving. GH-c5 moved M03-H1 and M03-H2 as well, **and** its M03-H4 message is
  not `observed 1` at all (§4 below). GH-c7 reddened M03-H4 **alone out of all 31
  M03 units and the whole 111-unit suite** — §4(e)'s uniqueness argument
  (§0.3's 12-octet gap plus REQ-102's 8-octet preamble put any ordinary
  schedule's second closure ≥ 2.5 cycles away, so only a REQ-110 splice twice in
  succession can bring two same-name reports within one word) is **confirmed
  empirically at 30 M03 units and 80 non-M03 units** under a diff that rewires
  **all five** strobe ports. **Two independent detections.**
- **§4(g) — the D2 correlation is absent, and that is checkable rather than
  claimed.** Every observed message is a **row-local assertion** — strobe-set
  arity, `tkeep`, output-word count, delivered content, delivered-frame count.
  **Not one is a monitor message.** In all five scored units the accounting
  helpers and `assert_monitors_clean` sit after the row's last assertion, so a
  reddening row never reaches them. **No kill is D2-correlated; the seven
  detections stand as seven.**
- **§4(f) — the weaker correlation is real and is reported, not hidden.** Four of
  the seven kills (**GH-c1, GH-c2, GH-c6, GH-c7**) rest **wholly** on the
  exact-`error_pulses` idiom, replicated per row with no shared helper. Three
  (**GH-c3, GH-c4, GH-c5**) rest on structural or content instruments —
  `tkeep`, the output-word count, delivered content, the delivered-frame count.
  So the campaign is seven detections at **six distinct stimuli geometries**
  probing **two** property families. Independent measurements of the geometry;
  **not** seven independent measurements of the property. Stated because §4.1
  binds the scorecard to state it.

### 3. FINDING GH-1 — the sealed T-H1 × GH-c4 cell is falsified, and the error is G-1's own species

**Sealed** (SEALED §3, reading (a)): `M03-H1 (lane 4): frame 1: delivered octets
differ from the 64 octets injected before the /S/ …`. **Observed: M03-H1 stayed
green under gh-c4.** The cell stands in the SEALED file unedited.

**It is not a weakness in M03-H1. The mutant is behaviourally identical to the
base design at that row's stimulus, so there was nothing to see.** GH-c4's
rendering bypasses the alignment register combinationally — `off4 |: (begins &:
new_start4)` — and corruption requires the aborted frame's offset to **differ**
from the aborting start character's. `run_h1` splices its `/S/` at
`close_ot = start_ot1 + 8 + 64` (`test_m03_h.ml:262`), and **72 ≡ 0 (mod 8)**, so
the new frame's start lane equals the aborted frame's start lane at **both**
members: lane 0 → lane 0, lane 4 → lane 4. At the lane-0 member `new_start4` is
low and the bypass never fires; at the lane-4 member it fires and ORs a 4 into a
register already holding 4. **A no-op both times.** This is
rendering-independent: "the new frame's offset" *is* "the aborted frame's offset"
at M03-H1, so applying it a cycle early is the identity under any faithful
rendering of the intent.

**The seal had the arithmetic on the page and did not draw its consequence.**
SEALED §4(c) states the fact — *"72 is a multiple of 8, so it lands in **the same
lane as the frame's own start**"* — and then concludes from a category, that
GH-c4 *"needs aborted-frame octets in the `/S/`'s own word … so that member passes
and the **lane-4** member speaks."* Aborted-frame octets in the `/S/`'s own word
is **necessary and not sufficient**; the quantity the class keys on is the
**offset delta**, and at M03-H1 it is zero. **This is exactly `RV-0055` FINDING
G-1's species** — a cell asserted from a category with the discriminating
quantity unchecked — recurring in the very file whose §4(a) was written to repair
it, one subsection away from the repair. Recorded against me without discount.

**The bench is unmoved and the attack plan never over-promised here**:
`AP-xgmii_rx_64.md` §4.H names M03-H1's Kills as *"a design that strips the FCS
on the abort path; a design that loses the second frame"* — both killed, GH-c3
and GH-c5 — and names the alignment defect as **M03-H2's**, where it died. The
seal over-extended GH-c4 to a row the plan never claimed for it.

**The coverage bound this uncovers is the campaign's most valuable by-product,
and it was invisible until now.** A REQ-110 abort in which the aborting `/S/`'s
lane **differs** from the aborted frame's start lane — the only geometry in which
an alignment-transition defect is observable at all — exists at **exactly one
member of exactly one unit in the entire 31-unit bench**: `run_h2`'s **lane-0
member** (`k = 12`, `close_ot ≡ 4`). Its lane-4 member (`k = 16`) is
offset-preserving; M03-H1 is offset-preserving at both; M03-H4's frames deliver
nothing. **One stimulus point carries the whole class.** It works — GH-c4 died
there — but a single point is not a sweep, and REQ-110's own commissioned
**M03-B4** case (§8 bound 2) is where the second point belongs. Footnoted into
the plan at `J-dv_lead-0081`.

### 4. FINDING GH-2 — GH-c5's T-H4 cell is red with the wrong message, and the seal's disclosure function had no column for the dimension that decides it

**Sealed** (SEALED §3): `M03-H4: expected exactly two error_start_without_terminate
high cycles, consecutive (c + 2 and c + 3) -- observed 1`. **Observed**:
`M03-H4: expected one delivered frame (frame C's own tlast word), got none`.
Red as sealed; **wrong message**, so §7 criterion 2 makes it a finding, adjudicated
rather than silently scored as a pass. The cell stands unedited.

**Mechanism, and it is the auditor's own disclosed narrowing.** The manifest
discloses, in plain terms, that GH-c5 gates on `a_close_start` — **epoch A only**
— so *"a lane-4 start that aborts a frame opened by a start character in lane 0
of the same word, with nothing open on entry … aborts **epoch B**, not epoch A,
and the lane-4 frame still begins."* **That is M03-H4's word `c` verbatim.**
So under the diff: frame A is aborted in-word and reports at `c + 2` through the
`q2` path; **frame B opens after all**; frame B is epoch A on entry to word
`c + 1`, so the third `/S/` aborts it, reports at `c + 3`, **and suppresses frame
C**. Both strobes therefore fire on their correct consecutive cycles, the
`error_pulses` pattern **passes**, and the row reddens at its earlier frame-C
emptiness check (`test_m03_h.ml:970`) instead. The seal assumed the gate would
reach every REQ-110 abort, in which case frame **B** would be the casualty and
one strobe would be lost — sound given that assumption, and the assumption is
what failed.

**Root cause, one thing.** SEALED §5.3's disclosure function branches GH-c5 on a
single dimension — *does the diff reach REQ-108's resynchronisation?* — and has
**no column for the epoch dimension**: whether the gate covers epoch A's
cross-word abort only, or the in-word epochs too. **M03-H4 is the only unit in
the bench whose stimulus contains both an in-word abort and a cross-word abort**,
so it is the only unit at which that dimension is observable — and it is exactly
the unit the seal got wrong. The observed **row set** `{T-H1, T-H2, T-H4}` still
matches branch (i) exactly, so §5's *"matches none of a class's branches"* rule
does **not** fire; the enumeration was not wrong about reach, it was silent about
scope. **The auditor discharged its duty completely here** — the narrowing is
disclosed, unprompted, under a heading saying so. The failure is the seal's.

**And the finding improves the row rather than damaging it.** §4.3 bound this
adjudication to score M03-H4 cells against *"the exact two-element `error_pulses`
list … and nothing else"*, on FINDING 2's ground that the §0.6 window is vacuous
there. That phrasing over-narrowed the row's instrument set relative to §4.2,
which expressly records that the total-output-word check exists at **four** rows
including M03-H4. **The campaign proves §4.2 right and the phrasing wrong**:
GH-c5 was caught at M03-H4 by frame C's own `tlast` word, an instrument
independent of every strobe. §4.3's **operative** content is honoured in full —
**no adjudication here cites M03-H4's window as a bound on any pinned cycle, and
no kill at M03-H4 is attributed to the strobe monitor** — and its "nothing else"
clause is ruled to be scoped to the strobe-monitor instruments it names. M03-H4
is qualified on **two** independent instruments, not one.

### 5. The two flagged judgement calls, ruled

1. **GH-c2's single added latch bit — ACCEPTED, and it is the only rendering the
   scope clause leaves standing.** The clause forbids the state-free rendering by
   name (*"the frame must still stop delivering at the `/E/` — a diff that leaves
   the frame genuinely receiving is a **different and much wider** defect"*), and
   in this design the frame stops delivering **because the machine leaves to
   `Idle`**, so the fact that must survive from the `/E/` cycle to the `/S/`
   cycle is carried nowhere in the base. One bit is the minimum carrier. **SEALED
   §5.1's UNWORKED third rendering is NOT invoked** — that clause covers only the
   forbidden *frame-keeps-receiving* diff, which was not produced — so **SEALED
   §6 bound 1 does not bite and M03-H3 is qualified.** The three further reaches
   the auditor volunteered (the set term follows REQ-105's **rule**, not the
   character `/E/`; the latch survives an arbitrary gap; `cfg_rx_enable` = 0 does
   not clear it) make the mutant a **strictly larger** defect than an
   `/E/`-then-`/S/` pair. They could only have produced **more** reds; none
   appeared, and correctly so — the latch needs a genuinely open frame, and
   `T-E1/T-E2/T-E5` build one `frame_case` each with no `/S/` following at all.
   Branch (i) confirmed on the observation, not on the disclosure alone.
2. **GH-c4's count-preserving reading — ACCEPTED as the signature class.** §3
   names it in terms (*"delivered, counted and `tkeep`-marked as before, but
   carrying the wrong values"*), the diff produces it, the disclosure says so, and
   the **message** at M03-H2 independently confirms which reading landed. The
   auditor's disclosed second geometry (a word carrying `/S/` in lane 0 **and**
   lane 4, where the same diff moves the count instead) moves **no cell**: it
   needs a frame open on entry with covered octets in `W−1`, and at M03-H4 —
   the bench's only two-`/S/`-in-one-word stimulus — nothing is open on entry,
   so `cov(W−1) = 0` and both `al_keep` expressions are 0. T-H4 sealed **G**
   under GH-c4; observed green. Correct for the sealed reason.

### 6. Qualification rulings

| unit | classes that killed it | instruments | ruling |
|---|---|---|---|
| **M03-G7** | **GH-c1** | exact `error_pulses` arity | **QUALIFIED.** The oldest open DV debt on this module is discharged: no mutation had ever reddened M03-G7, and GH-c1 — *"the class this campaign exists for"* — died there with its sealed message exactly. **Qualified by exactly one class**, as SEALED §6 bound 2 named in advance: GH-c3 and GH-c5 both landed **narrow**, so neither §5.2(iii) nor §5.3(ii) added the contingent kills at that unit. GH-c1 is also the class M03-G7's own text names as its target, so this proves **the row does what it claims** and not that it is a general detector. |
| **M03-H1** | **GH-c3, GH-c5, GH-c6** | `tkeep`; delivered-frame count; `error_pulses` arity | **QUALIFIED, three classes, three distinct instruments — and all three are spec-derived**, not the row's own named targets, which is the stronger statement available. Green under GH-c4 is a stimulus fact (§3), not a weakness. |
| **M03-H2** | **GH-c3, GH-c4, GH-c5, GH-c6** | output-word count; delivered **content**; delivered-frame count; `error_pulses` arity | **QUALIFIED, four classes — the strongest-qualified unit in the campaign, and the sole killer of GH-c4.** The plan calls it *"the highest-value row in this family"* and names GH-c4's defect in its Kills cell; the campaign proves that claim at the one stimulus point in the bench that can carry it. |
| **M03-H3** | **GH-c2** | exact `error_pulses` arity | **QUALIFIED — and the thinnest qualification in the campaign, stated as such.** One class, one instrument, and it is the only class in the bench that can reach this row (§4(b): of the three closed-frame `/S/` geometries only M03-H3's is `/E/`-closed). SEALED §6 bound 1's failure condition did not occur. |
| **M03-H4** | **GH-c5, GH-c6, GH-c7** | frame C's own `tlast` word; `error_pulses` arity ×2 | **QUALIFIED, three classes on TWO independent instruments** (§4). GH-c7 is the row's own named target — C-23's counting convention made testable — and it died **only** here, in the whole 111-unit suite. **No kill at this row is attributed to the strobe monitor and no window claim is made** (§4.3). |

**Every scored unit is qualified. The campaign has no unqualified row.**

### 7. The M03-G6 disposition — a predicted kill-supporting red at an unscored unit

M03-G6 reddened under gh-c1 with `expected exactly one strobe (error_oversize
alone), observed 2` — **character-exact against SEALED §3**. Ruling, in the three
terms the disposition offers:

- **Not a finding.** §7 criterion 2 makes a finding of *an unnamed unit
  reddening*. This unit was named **twice, in advance, in public and in seal**:
  §1 of this packet published that *"a class's REQUIRED-red set may legitimately
  contain a unit outside the scored five … and that cell is sealed as REQUIRED
  rather than left to surface as a violation"*, and SEALED §2 carries `T-G6` as
  **R** under GH-c1 with its message and its stimulus ground (`run_g6` replaces
  frame 1's own terminate with an idle character, so nothing can leave `Discard`
  and frame 2's `/S/` is the first closure after truncation).
- **Not collateral.** Collateral is an *unpredicted* red; this one was predicted
  with its exact text and its arithmetic.
- **A kill cell of GH-c1, contributing ZERO additional kills.** §4.1 fixes the
  unit as the class: GH-c1 is **one** kill carried by two units, and §4(f) makes
  T-G6 and T-G7 independent measurements of the **stimulus geometry**, not of the
  **property**. Reporting two kills here would be exactly the `RV-0055`
  inflation this packet was written to prevent.

**Its real value is elsewhere and is worth naming: it is the demonstrated repair
of FINDING G-1.** SEALED §4(a) re-derived every G-family row's `Discard`
membership from its own committed arithmetic rather than from a category — T-G7
and T-G6 REQUIRED, and **T-G1, T-G2, T-G3, T-G4, T-G8 GREEN**, each with the
guard or the octet-time computation that decides it. **All seven G cells landed
exactly as derived.** T-G3 — the cell whose category-reasoning cost a campaign —
stayed green for the reason given in advance. The method that failed at G-1 was
applied correctly across seven cells here and failed at neither; it failed once
more this round, at GH-c4, in a different family, which is where §3 records it.
As a by-product, M03-G6 is shown to have teeth against the `/S/`-in-`Discard`
class as well. That is a **fact recorded about an unscored unit**, not a score.

### 8. Headline numbers, in this packet's own denominators

- **Kills: 7 of 7 classes** (§4.1's denominator; §7 criterion 4 satisfied).
- **Sealed REQUIRED cells landed red: 13 of 14** (narrow branches).
- **Sealed REQUIRED cells landed red with the exact sealed message: 12 of 14.**
- **Unnamed-unit reds: 0.**
- **MUST-STAY-GREEN, M03: 203 of 203 sealed-green cells held** (7 × 31 = 217
  cells, 14 sealed REQUIRED). **Zero violations.**
- **MUST-STAY-GREEN, non-M03: 560 of 560 held** (7 × 80). **Zero build-level
  findings** — no diff reached shared code, confirming the blast-radius argument
  from the `dune` stanzas.
- **Total must-stay-green cells held: 763 of 763.**
- **Disclosure branches: 4 of 4 selected correctly** by the observed row set —
  GH-c2 §5.1(i), GH-c3 §5.2(i), GH-c4 §5.4 reading (a), GH-c5 §5.3(i). No class's
  row set matched **none** of its branches, so §5's incomplete-enumeration finding
  does not fire.
- **Green runs: 0** (§6's campaign-failure condition untriggered).
- **Control**: green at `a2d090d`, CI **30865856907**, both jobs (§7 criterion 3,
  established before the campaign).
- **Findings: 2, both against the seal, none against a bench row.**

**Pass criteria**: 1 **MET**, 3 **MET**, 4 **MET**. Criterion 2 **MET on its
second half in full** (no MUST-STAY-GREEN unit reddened anywhere) and **met on
its first half at 12 of 14 cells**, with the two deviations adjudicated above as
FINDING GH-1 and FINDING GH-2 rather than scored away.

**No discount is claimed in either direction** (§8). Three of the seven classes —
GH-c1, GH-c4, GH-c7 — are the defects the rows' own attack-plan and docstring
text name as their targets, so their kills prove those rows do what they claim,
which is weaker than proving them general detectors. The other four — GH-c2,
GH-c3, GH-c5, GH-c6 — were derived from the specification clauses the rows cite,
and **GH-c6 is the one the family is blind to by design**: two of the five scored
units assert that very strobe's **absence** as their whole point, so they cannot
see its suppression. It died at **three** units. SEALED §8's statement that *"if
M03-H1, M03-H2 and M03-H4 do not kill it, nothing in this repository does"* is
discharged in the affirmative.

### 9. Bounds — the five named in advance, and the two this campaign discovered

The five bounds of §8 stand unchanged and unclosed: the spurious-third-frame
class is unseeded; M03-H4 is driven at one geometry; REQ-110's zero-delivered
class is exercised in preamble positions only; no class seeds the
`cfg_rx_enable` interaction; M03-G7's first epoch is exercised at one interior
point. **Two more are added by the result, and neither was visible before it:**

6. **The alignment-transition instrument is a single point.** A REQ-110 abort
   whose `/S/` lane differs from the aborted frame's start lane exists at
   `run_h2`'s **lane-0 member only** (§3). Owed: the second point, at REQ-110's
   commissioned **M03-B4** geometry.
7. **The in-word (epoch B/C) REQ-110 abort is exercised at one unit, in one
   geometry.** M03-H4's word `c` is the bench's only in-word abort, and only in
   the nothing-open-on-entry form; no unit drives an in-word abort with a frame
   already open. **This is the dimension FINDING GH-2 turned on**, and it is
   unbenched everywhere else.

### 10. Consequences

- **`SO-M03` does not issue and is not offered.** §7 is unchanged by this result:
  32 of the plan's 62 ASSERT rows are discharged, families **I, J, K, M, N** and
  **L1–L5** unwritten. This campaign qualifies five units; it does not sign off a
  module.
- **The SEALED companion is not edited, now or ever.** Both falsified cells stand
  as frozen. This block is the correction of record.
- **Owed to `test/**` at its next touch**, carried forward unchanged and joined by
  nothing from this round: `account_spliced_forwarded`'s `~received`-vs-
  `~delivered` input trace (`RV-0057` Finding 1), M03-H3's §6.2 `Idle` citation
  (Finding 4), and the total-output-word line at the ordinary two-frame rows
  (Finding 3). Bounds 6 and 7 above are **plan** rows, not bench repairs, and are
  footnoted at `J-dv_lead-0081`.
- **Nothing is owed to the auditor.** The manifest did what it was asked and
  disclosed the one thing that decided FINDING GH-2 before the result existed.
