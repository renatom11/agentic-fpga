# WO-0050: The family-F mutation campaign — eight seeded runt-path defects

- **State**: **DRAFT — FROZEN, awaiting seeding.** Predictions were frozen before
  any diff existed; nothing below may be revised once seeding starts.
- **From** / **To**: dv_lead → auditor (via orchestrator; *Summarizable*, with
  the restriction in §0)
- **Spec basis**: `docs/specs/modules/xgmii_rx_64.md` §6.1, §6.2's `Frame` row
  and its `/T/` and `/E/` exits, §7, §9 (the **sixth row**, the **first**
  co-occurrence ruling, **ruling 9**, the strobe-cycle pin **and its
  no-output-word clause**), §10's REQ-107/REQ-108 hooks and its REQ-901 row;
  `docs/specs/requirements.md` REQ-107, REQ-103, REQ-104, REQ-105, REQ-008,
  REQ-901, §0.3, §0.6, §0.7.
- **Subject under test**: **not M03.** Family **F** of `test/xgmii_rx_64/**`
  (`test_m03_f.ml`, rows M03-F1–F4) and row **M03-E5** (`test_m03_e.ml`), and
  whether they have teeth.
- **Base SHA**: **`616686f`**. Chosen because it is the SHA the green control
  run actually executed — CI run **30826473824**, workflow `build`, conclusion
  **success** — so no byte-identity inference is needed to establish criterion 3.
  Recorded for completeness: `git diff 8e040f0 616686f -- test/ libs/` is
  **empty**, so the compiled surface is identical to the commit that landed
  family F and the choice between them is immaterial.

> **One ordering fact, stated so nobody has to reconstruct it.** The attack plan
> `test/attack_plans/AP-xgmii_rx_64.md` was edited **after** this base and
> **before** this freeze (`J-dv_lead-0060`), to carry the REQ-901 divergence-class
> cascade landed at `62c39a7`. That edit touches **no compiled path** — it adds
> no row, converts no row, and changes no status count — so the base's compiled
> surface is untouched and the control still holds. The plan this campaign is
> **scored against** is the edited one; the tree the mutations **build from** is
> `616686f`. Those are two different things and both are named.

## 0. What is sealed, and what was published on purpose

Predictions live in
`agents/handoffs/WO-0050_family-f-mutation-campaign-SEALED-predictions.md`.
**Do not open it until all eight diffs are committed.**

This campaign runs the **intents-public / mapping-sealed** protocol that
`WO-0045` established and that has now held across two campaigns. **Five of the
eight defect classes below — F-c1 … F-c5 — were published to the bench author in
`WO-0047` §8 before the bench was written**, deliberately, so the rows were
written against a stated adversary. **Three — F-c6, F-c7, F-c8 — are new here**
and were never shown to the bench author, because the rows they attack were
already written when they were conceived.

**Sealed in every case**: which units redden, which must stay green, and the
exact failure messages.

The informative outcome remains a mutation that reddens the **wrong** unit, or
none.

## 1. What you may read — the WO-0045 allowlist, standing

**This is the complete set of repository paths you may read for this campaign.
Everything else in the repository is out of bounds.**

| | readable |
|---|---|
| 1 | **this packet** |
| 2 | **`docs/specs/**`** — SPEC-M03 and requirements.md, which you need to author faithful intents |
| 3 | **`docs/adr/**`** — the decision record |
| 4 | **`libs/**`** — the design you are mutating |
| 5 | **`docs/reports/audit/**`** — your own tree |
| 6 | **root-level build configuration** — `dune-project` and any sibling build config at the repository root |

Item 6 is the WO-0045 addendum §3(ii) ruling, promoted into the list where it
belongs: build-configuration files carry no bench content, no prediction content
and no verdict content, and making a seeder reverse-engineer library names from
error text is friction with no blinding benefit. `libs/**/dune` was already
readable under item 4.

**Out of bounds, by construction rather than by enumeration:**

- **all of `test/**`** — the bench under test, the attack plan, the comparison
  domain, the co-simulation lane, everything;
- **all of `agents/**`** — every packet, every verdict, every journal, mine and
  the workers'. That includes `WO-0047`, whose Return log and verdict describe
  `test_m03_f.ml`'s internals line by line, and it includes the sealed companion
  above.

An allowlist cannot be defeated by a document I forgot to enumerate. If you
believe you need something outside it, **ask through the orchestrator rather
than read.**

**Process bars, standing practice:**

7. Author all eight diffs **before any of them is run**.
8. **Do not revise a diff after seeing any run result.** Sole exception: a diff
   that fails to *build* — repair it to build, change nothing else, disclose the
   repair. `dune build @fmt` is inside "Build state" for this exception
   (WO-0045 addendum §3(i)); the repair must be **ocamlformat's own output**,
   never hand reformatting.
9. **Private scratch subdirectory.**
10. **Exclude out-of-bounds paths from any tree copy** you make to test build
    feasibility — `tar --exclude`, not reliance on the build failing before it
    reaches them.
11. **No unscoped `git log`**, and **a path outside the allowlist is out of
    bounds to every git subcommand**, not merely to opening the file. Commit
    subjects adjacent to this campaign are deliberately thin for exactly this
    reason; treat that as a bar on you, not as a guarantee.

**Disclosure:** your journal `Inputs` lists what you read. You have read
`agents/**` material in prior spawns; that is known, expected, and not a
disqualification. What is barred is reading it *now*.

## 2. The eight mutation intents

Behavioural specifications. **Minimality** — the smallest change producing the
described behaviour — and **fidelity** — behaves *as described*, not merely
broken nearby — matter more than elegance. If a faithful minimal diff is not
achievable, **say so rather than substituting**.

**Standing clause, and it has earned its place three times**: when a spec rule
collides with an intent, **preserve the spec rule and disclose the collision.**
An intent describes one defect and is never a licence to break a second rule on
the way to it.

### F-c1 — FCS removal suppressed on a runt closed by `/T/`

**Intent.** A frame carrying **5 to 63 octets** between the start and terminate
characters is forwarded with its four FCS octets **still attached**: four octets
too many are delivered. REQ-103 requires the FCS to be removed from every frame
that ends with a terminate character, and REQ-107's runt disposition does not
except it. Frames of 64 octets and above are unaffected, as are the abort paths
(REQ-105, REQ-110) where no removal is due in the first place, and frames below
five octets, which have nothing to remove.

### F-c2 — the runt threshold off by one at its upper boundary

**Intent.** REQ-107's "fewer than 64 octets between the start and terminate
characters" is implemented as **"64 or fewer"**, on the **received** octet count.
A 64-octet frame — the legal minimum, §0.3 — is therefore marked
`tuser`[0] = 1 on its `tlast` word and reported with a single `error_runt`,
exactly as a 63-octet frame is. Nothing else about a 64-octet frame changes: its
octets, its `tkeep` extent, its `tlast` cycle and its FCS verdict are all
untouched. Frames of 65 octets and above are unaffected.

> **Pinned to the received count deliberately.** The other reading of this
> class — the threshold applied to the *delivered* count, so that 64-to-67-octet
> frames become runts — is the same boundary reached from the other side with a
> strictly wider blast radius, and is **not** seeded this round. Seed the
> received-count off-by-one.

### F-c3 — an output word emitted for a sub-five frame that must produce none

**Intent.** A frame carrying **fewer than five octets** between the start and
terminate characters delivers nothing and, per REQ-107 and §0.7, must produce
**no output word at all**. The mutant emits one anyway — the natural
implementation being a word with `tkeep` = 0, or a word of preamble octets, "to
have somewhere to put the abort bit". The strobe is unaffected.

> **Scoped to REQ-107's sub-five disposition**, i.e. to a frame closed by its
> **terminate character**. The REQ-105 half of this shape — an `/E/`-closed
> zero-delivered frame — was already seeded as **E-c2** in the previous campaign
> and is deliberately **not** re-seeded here. Frames closed by `/E/` must be
> unaffected by this diff.

### F-c4 — first-match reporting where two conditions hold

**Intent.** Where a single frame satisfies **two** reportable conditions at once,
only the first one the design considers is reported: the second strobe never
pulses. §9's **first** co-occurrence ruling admits `error_runt` **together with**
`error_bad_fcs` on a frame of 5 octets or more, both pinned to that frame's
`tlast` cycle. Under this mutation one of the two is suppressed. **Which one
survives is yours to pick by whichever is minimal in the design; say which.**
The abort bit and the delivered extent are unaffected — `tuser`[0] is still set
once, on the same word.

### F-c5 — a sub-five-octet frame silently dropped, with no strobe at all

**Intent.** A frame carrying **fewer than five octets** between the start and
terminate characters is discarded correctly — no output word, nothing emitted —
**and `error_runt` never pulses for it.** REQ-008 forbids silent discard and
§9's sixth row requires the report; the frame simply vanishes. Frames of five
octets and above keep their report, and every other strobe is untouched.

> **This is the class this family was written for, and it will look quiet.** It
> is invisible to everything outside the sub-five class by construction. That is
> the defect class, not a weak diff — the same warning applied to D-M1 and to
> E-c5, and both were the mutation their campaign most needed.

### F-c6 — the FCS-strip underflow, faithful

**Intent.** The FCS removal is attempted **unconditionally at the terminate
character**, including on a frame with fewer than four octets to remove it from,
and the resulting octet count is **allowed to underflow** rather than being
clamped at zero. This is a **faithful** rendering of a specific declared kill,
not a free hand: seed the underflow, do not engineer its consequence.

> **This diff answers a question rather than proving a point, and its disposition
> is pre-committed here so it cannot be decided after the fact.**
> `AP-xgmii_rx_64.md` M03-F2 declares a second kill — "a design that attempts FCS
> removal on a frame with nothing to remove it from and underflows its counter" —
> which I flagged at `WO-0047` §3.2 as **at risk of the unachievable-kill shape**
> and could not settle, because settling it requires reading `libs/**`, which I
> may not. `RV-0047` §5(3) ruled that **the campaign settles it.**
>
> **So F-c6 is EXEMPT from pass criterion 1** (see §5). A green run on F-c6 is
> **not** a campaign failure: it is the answer, and it withdraws M03-F2's second
> declared kill by spec diff, exactly as M03-D3's headline kill was withdrawn
> when D-M3 proved an equivalent mutant. **If a faithful minimal underflow is not
> expressible in this design at all — for instance because the count is
> structurally unable to go negative — say that plainly instead of substituting
> a diff. That statement is itself the answer**, and a better one than a run.

### F-c7 — the in-word open-and-close abort detected, and never reported

**Intent.** A frame **opened and closed inside one input word** — a control
character in a preamble position at a lane-0 start, where §6.1 puts all eight
preamble positions inside the start word itself — is closed correctly and
produces no output word, **but `error_bad_frame` never pulses for it.** Aborts
reached on any other path, including an error character at the frame's first
octet position or in a mid-frame word, keep their report. REQ-008 forbids the
silent discard and §9's third row requires the strobe; this is a conformance
defect in the reporting path of one structurally distinct route through the
design.

> **Expect this one to look quiet too**, for a sharper reason than F-c5's: the
> route it attacks was **found by your predecessor** reading this design during
> the family-E campaign, and until the row that covers it was written, **no unit
> anywhere in the suite drove it.**

### F-c8 — the no-output-word strobe pin displaced by one cycle

**Intent.** §9 pins a strobe reporting a frame that produces **no output word**
to **two cycles after the input word carrying the character that ended the
frame**. The mutant reports it **one cycle after** that word instead — one cycle
early, at every such frame, whatever the strobe's name and whatever character
closed it. **Frames that do produce an output word are unaffected**: their pin is
their own `tlast` cycle and it does not move. The verdict, the delivered extent,
the marking and the strobe's *name* are all unchanged; only the cycle moves, and
only for the no-output-word class.

> **This is the shared-path class**, and it is the one diff in this campaign
> whose value is a *cross-family* claim rather than a single row's teeth. It is
> distinct from the previous campaign's E-c3, which moved one named strobe onto
> its own closing character's cycle; this moves **the pin itself**, for every
> frame in the class. Displace it **earlier by one**, not later, and not by two.

## 3. What you produce

A report under `docs/reports/audit/**`: each diff in full, applying cleanly to
`616686f`; file and function touched; a one-paragraph fidelity argument; any
build-only repair and why; anything you could not do faithfully, said plainly.
Plus a scope statement listing what you read against §1's allowlist.

For **F-c4**, state which of the two strobes your diff suppresses. For **F-c6**,
state whether a faithful underflow was expressible at all.

**You do not run the diffs and you do not see the results.**

## 4. Mechanics and return

Throwaway branch = `616686f` + one diff, nothing else; never merged; marked
never-merge with the greppable MUTATION marker. Per run the relay states the
parent SHA, the mutation id, the CI run id, Build state, and `dune runtest`'s
**verbatim** output — the complete raised message and **the name of every
`%expect_test` that failed**, not a summary.

**A green run on any of F-c1 … F-c5, F-c7 or F-c8 is a campaign failure** and
must be relayed prominently. **F-c6 is the exception and it is pre-committed in
§2.**

**Generated-Verilog drift at the determinism step is expected under every RTL
mutation, is never an unnamed-unit finding, and is never harvested** — it sits
outside the unit matrix by construction.

### 4.1 One stimulus artefact named in advance, so adjudication is not confused by it

`RV-0047` §3 recorded a property of M03-F2's construction that this campaign has
to know. F2's sub-five frames are built by **placing a terminate character early
on a normal 64-octet base frame** — the only construction this bench's own
schedule check accepts — and `Injection` performs no truncation for a placed
terminate, so roughly **59 octets of the base frame follow the placed `/T/` into
the inter-frame gap**. F2's stimulus is therefore a **superset** of its row text:
`k` octets between start and terminate, *plus* data in the gap.

That data is inert — M03-E4 establishes that a closed frame reports nothing, and
F2's exact-strobe-set assertion would catch it if it were not. **It is named here
because an unexpected strobe under an F-class mutation could be this artefact
rather than the mutation, and would present as an unnamed-unit finding.** If one
appears, it is adjudicated against this paragraph before it is scored.

## 5. Pass criteria

1. The suite goes red — **on F-c1 … F-c5, F-c7 and F-c8. F-c6 is exempt by the
   pre-commitment in §2**, and its green result, if that is what comes back, is
   a result rather than a failure.
2. Red in the units dv_lead named in advance, **with the expected message**. An
   unnamed unit reddening, or a named unit reddening with the wrong message, is
   a **finding** — adjudicated, never silently scored as a pass.
3. The unmutated control is green — established at `616686f` itself by CI run
   **30826473824**, conclusion success.

**Family F's rows and M03-E5 cannot carry a sign-off until this campaign
completes**, and `SO-M03` does not issue on family F regardless: §9 of `WO-0047`
already counts 21 of the plan's 60 ASSERT rows discharged after it, with families
G, H, I, J, K, M, N and L1–L5 unwritten.

**No discount is available in adjudication for F-c6, F-c7 or F-c8** — they carry
full blinding, intents and all, and were never shown to the bench author. **Nor
for F-c1 … F-c5**: only their *intents* were published, exactly as family E's
were, and the row mapping, the MUST-STAY-GREEN columns and the messages were
sealed together. A class that fails to land is a bench finding, full stop.

---

## RV-0050-VERDICT: eight of eight killed — and the campaign's four deviations are three against my own seal and one that says WO-0047 §1.2's folding argument may be false — dv_lead, `J-dv_lead-0064`

**Branches** `mut/wo-0050-f-c1` … `f-c8`, each `616686f` + one auditor diff
(diffs at `4ef6628`); control green at `616686f` itself, CI run **30826473824**,
conclusion success. Criterion 3 met. Run ids: c1 `30831751819`, c2 `30831753190`,
c3 `30831754811`, c4 `30831757587`, c5 `30831759516`, c6 `30831766262`,
c7 `30831762104`, c8 `30831763240`.

**No build failure on any branch.** The auditor's flagged `@fmt` concern never
materialised; every failure is at `dune runtest`. The `cosim` job was red on all
eight and is **out of scope by construction** — those branches predate the
WO-0049 format fix, and only the build job's `runtest` is scored here.

### 0. How green was measured, since it is not stated by absence alone

`ppx_expect` promotes **per test block**. Each run's `.corrected` diff therefore
contains one hunk per **failing unit**, and every unit whose block is absent from
that diff **ran and passed**. Green is read off the hunks, not inferred from
silence. Hunk counts: 4, 10, 1, 1, 1, 1, 1, 1 — **twenty red cells across the
eight runs**, against a frozen matrix of 21 REQUIRED and 139 MUST-STAY-GREEN over
20 units.

**Blast radius held**: every `FAILING` file in all eight runs is under
`test/xgmii_rx_64/`. No unit outside the twenty reddened, so there is no
build-level finding anywhere in the campaign.

**`fail_cross` never fired**, in any of the eight — the finding condition I named
as structurally impossible stayed impossible. Fourth campaign, fourth time.

### 1. Scorecard

| | REQUIRED | MUST-STAY-GREEN | message | verdict |
|---|---|---|---|---|
| **F-c1** | **4/4** T-C4, T-F1, T-F3, T-F4 | **16/16** | all four **sealed verbatim** | **KILL, exact** |
| **F-c2** | **9/9** T-A12, T-A34, T-A5, T-B1, T-C12, T-D1, T-D2, T-D3, T-F4 | **10/11** — **T-E4 reddened** | all nine **sealed verbatim** | **KILL; F-1** |
| **F-c3** | **1/1** T-F2 | **19/19** | sealed text, **wrong iteration** (`k=1`, sealed `k=0`) | **KILL; F-2** |
| **F-c4** | **1/1** T-F3 | **19/19** | **sealed verbatim**, `N` = 11 | **KILL, exact** |
| **F-c5** | **1/1** T-F2 | **19/19** | **sealed verbatim**, including `k=0` | **KILL, exact** |
| **F-c6** | **1/1** T-F2 | **19/19** | the sealed **alternative** of two admissible | **KILL, admissible** |
| **F-c7** | **1/1** T-E5 | **19/19** | **sealed verbatim** | **KILL, exact** |
| **F-c8** | **1/3** T-E5 only | **17/17** | sealed shape, `Y − X = 1` exact | **KILL; F-4** |
| | **19/21** | **138/139** | | **8/8 killed, 3 findings** |

**Every class killed.** Every observed message is either the sealed string
character-for-character or a shape I sealed as admissible. The deviations are in
*which cells fired*, not in what they said.

### 2. F-c1 — four units, and the `tkeep`-not-word-count call was right

```
M03-F1 (lane 0, length 5, delivered 1, final word fill 1): tlast tkeep = 31, expected 1
M03-F3 (lane 0): tlast tkeep = 127, expected 7
M03-F4 (lane 0): frame 1: tkeep does not match its own 59 delivered octets
M03-C4 (lane 0): tkeep is not 0x01 on the one-word frame
```

All four sealed verbatim, and the seal's §3 paragraph explaining *why* `tkeep`
speaks rather than the word count is confirmed at all four sites: suppressing a
four-octet strip leaves the word count unchanged (1→1, 1→1, 8→8, 8→8) and the
`tlast` cycle with it, so the third assertion is the first to differ. **This is
the E-c1 lesson applied before the run instead of after it** — last campaign I
predicted from a reported mechanism and was wrong; here I read the code and the
iteration order first.

**T-C4's kill is expected and is not a design flaw in the campaign.** `WO-0047`
§1.1 established that C4 already verifies REQ-107's report path at five octets,
so F-c1 was never a silently-always-pass class and was not claimed to be.

### 3. F-c2 — nine of nine exact, and one cell I never worked

All nine REQUIRED messages sealed verbatim, including the two whose failure
channel was the prediction rather than the string:

- **T-C12** produced the batched signature table with **exactly two FAILING
  entries, length 64 at each lane, on `tuser=1`** — the count and the placement
  as sealed, with the other fourteen entries PASS.
- **T-A34 reddened through the strobe monitor, not through its own assertion** —
  `M03-A3 (length 64) lane 0: strobe monitor unclean:` with
  `error_runt=1` unclaimed. **The cross-lane tuple comparison PASSED**, exactly as
  §4(a) predicted, because `tuser` is inside the compared tuple and F-c2 moves it
  identically at both lanes.

> **This discharges a standing open item.** `AP-xgmii_rx_64.md` §8 has carried
> *"M03-A3's blindness to lane-symmetric errors is UNTESTED"* since
> `J-dv_lead-0037`, because WO-0039's mutation M3 was predicted to demonstrate it
> and took the reddening branch instead. **F-c2 is a lane-symmetric content error
> and M03-A3 is measurably blind to it.** The row's value is a cross-lane
> equality check; it is not a content check, and no packet may credit it as one.
> The unit survives on its monitor, which is a different guarantee.

**FINDING F-1 — T-E4 reddened where I sealed MUST-STAY-GREEN.**

```
M03-E4 (lane 0): an error strobe pulsed for an /E/ that arrived with no frame
open (REQ-105's closure clause, C-12, E-c4)
```

**The unit is right to redden and my matrix was wrong.** M03-E4 drives 64-octet
frames and asserts that **no** strobe pulses anywhere in the run; F-c2 marks a
64-octet frame as a runt, so `error_runt` fires and E4's strobe-emptiness check
catches it. Ten units drive a 64-octet frame, not nine.

**The root cause is mine and it is the familiar one.** Every other cell in the
F-c2 column carries a worked ground in the seal's §4. **T-E4 is the one cell I
recorded as `G` with no working** — I reasoned from its *family* ("E4 is family E,
F-c2 is about runt thresholds, therefore green") instead of from *what it
drives*. That is the fourth consecutive round in which my defect is a conclusion
reached without deriving it.

The consequence for the campaign is nil — a MUST-STAY-GREEN violation whose cause
is correct DUT-detection strengthens the class rather than weakening it — but the
finding stands against the seal, not against the diff.

### 4. F-c3, F-c5, F-c6 — one unit, three classes, and two of them are the same defect at this bench

All three kill **T-F2 alone**, separated only by which assertion speaks. That is
the fourth campaign with this structure and the first **three-way** instance.

| | observed |
|---|---|
| **F-c3** | `M03-F2 (lane 0, 1 octets received): a tlast word was observed for a frame that must deliver nothing (section0.7, F-c5)` |
| **F-c5** | `M03-F2 (lane 0, 0 octets received): expected exactly one strobe pulse (error_runt only -- F-c5's own kill), observed 0` |
| **F-c6** | `M03-F2 (lane 0, 1 octets received): a tlast word was observed for a frame that must deliver nothing (section0.7, F-c5)` |

**FINDING F-2 — F-c3 convicts at `k = 1`, not at the `k = 0` I sealed.** The
message *text* is the sealed primary, character-for-character; the row prefix is
not. The mechanism is informative and the contrast with F-c5 proves it: **a
frame that receives zero octets gives an emitting defect nothing to emit**, so
F-c3 is invisible at `k = 0` and first bites at `k = 1`; a *strobe-suppressing*
defect needs no octets and F-c5 duly convicts at `k = 0`, exactly as sealed.
**Bound created: F-c3's reach inside T-F2 is `k ∈ {1, 4}`, not `{0, 1, 4}`.**

**RESULT R-1 — F-c3 and F-c6 are indistinguishable at this bench, and it is
provable rather than argued.** Both runs produced a **byte-identical corrected
file**: `index e7a9f8d..eafc324` in each. Same unit, same iteration, same
assertion, same message.

**FINDING-adjacent disposition of F-c6, and the pre-commitment settles it
cleanly.** `WO-0050` §2 pre-committed that a **green** F-c6 would withdraw
M03-F2's second declared kill by spec diff, on the M03-D3 precedent. **F-c6 went
red.** Therefore:

> **M03-F2's second declared kill — "a design that attempts FCS removal on a
> frame with nothing to remove it from and underflows its counter" — is
> CONFIRMED ACHIEVABLE and is NOT withdrawn.** No spec diff is owed. `RV-0047`
> §5(3) sent the campaign to settle this and it is settled in the direction the
> row claimed.
>
> **With one bound, from R-1: the row convicts the underflow but cannot
> discriminate it.** A reader who sees this message cannot tell an underflowing
> strip from a spurious emission — the two defects reach the ports through the
> same channel. The kill is real; the diagnosis is not unique to it. That is the
> opposite disposition from D-M3, which was proven *unkillable*; this one is
> killable and merely not separable.

**On F-c6's message, against myself**: I sealed the `tvalid`-without-`tlast`
shape as primary, reasoning that an underflowed count would drive words with no
`tlast` among them, and named the `tlast` shape as the admissible alternative.
**The alternative is what fired.** Both were sealed admissible so this is not a
finding — but the reasoning behind my ordering was wrong, and it was wrong the
same way E-c1's correction was: I ranked two admissible shapes by a mechanism I
could not observe.

### 5. F-c4 and F-c7 — exact, and F-c7 is the class M03-E5 was added for

```
M03-F3 (lane 0): expected exactly {error_runt, error_bad_fcs}, each once, both on
cycle 11 -- the precedence/widened-pulse kill this row exists for; observed 1 pulse(s)
M03-E5 (preamble position 1, lane 0): expected exactly one strobe pulse
(error_bad_frame only), observed 0
```

**F-c4**: `N = 11` confirmed by derivation — 63 octets, 59 delivered, 8 words,
`start_cycle` 1 + 3 + 7. The sorted-set comparison made the message robust to
which strobe the auditor chose to suppress, as designed.

**F-c7**: sealed verbatim. **Nineteen of twenty units cannot see this class, and
before M03-E5 was added — from a finding the WO-0045 seeder made by reading the
design — twenty of twenty could not.** The row was worth adding, and this run is
what says so.

### 6. FINDING F-4 — F-c8 killed one of three, and the folding argument is now in doubt

```
M03-E5 (preamble position 1, lane 0): error_bad_frame pulsed on cycle 2, expected 3
```

The message shape is sealed and **`Y − X = 1` exactly**, so the displacement is
faithful where it landed. But I sealed **three** REQUIRED units — T-E2, T-E5,
T-F2 — and **only T-E5 fired.** T-E2 and T-F2 held green under a mutation that
was specified to move the pin *"at every such frame, whatever the strobe's name
and whatever character closed it."*

**Two hypotheses, and I cannot choose between them from the DV side:**

- **(a) the diff is narrower than its intent** — the displacement was seeded on
  the in-word closure path only, not on every no-output-word frame. Then F-c8's
  claim is **untested**, not refuted, and a re-seed is owed.
- **(b) my matrix was wrong** — the three frames do not share a pin computation,
  so a displacement reaching the in-word route cannot reach the epoch-A routes.
  Then the claim is **refuted**.

**The discriminator is in the diff at `4ef6628`, which I may not read** — it is
`libs/**` under an active campaign and reading it now would contaminate the next
round. **This is routed to the auditor and the orchestrator**: one look at
whether the diff touches one code path or a shared pin settles it.

> **Either way, one thing is settled and it is the consequential one.**
> `WO-0047` §1.2 folded M03-E5 into family F's packet on an explicit
> *verification* ground — that E5 and F2 are the programme's two no-output-word
> classes and "a defect in the shared no-output path would have to be scored
> against **both** to be understood". **F-c8 was the diff written to cash that
> argument, and it did not.** The folding argument is **not confirmed by this
> campaign and may be false.** No later packet may cite WO-0047 §1.2's shared-path
> claim as established.

### 7. Campaign verdict

**PASS on the instrument, with three findings and one result.**

**8 of 8 classes killed. 19 of 21 REQUIRED cells. 138 of 139 MUST-STAY-GREEN
cells. Every observed message sealed verbatim or a sealed admissible
alternative. No `fail_cross`. No build-level finding.**

**No discount is available** and none is claimed: F-c6, F-c7 and F-c8 carried
full blinding including their intents; F-c1 … F-c5 carried the family-E blinding,
intents published and everything else sealed together.

**Three of the four deviations are against my own seal** — T-E4's unworked cell,
F-c3's iteration index, and F-c8's over-broad row set if hypothesis (b) holds.
The bench did what it was written to do in every one of them; the predictions
were what missed. That is the campaign working in the direction it is supposed to
work, and it is the third consecutive campaign in which the sealed **messages**
did all the discriminating while the **row sets** did not.

### 8. What family F licenses for REQ-107 — with its bounds attached

**REQ-107 is now verified in both directions by a mutation-qualified
instrument**: the FCS is removed on a runt closed by `/T/` (F-c1), the 5-to-63
band's upper boundary holds (F-c2), a sub-five frame produces no output word
(F-c3, F-c6), the co-occurrence with REQ-104 is not first-match (F-c4), and
**the sub-five discard is actually reported** (F-c5). **REQ-105's in-word
open-and-close route is closed by F-c7.**

**Bounded, and the bounds are not decoration:**

1. **M03-F5's own declared kill was not seeded**, as `WO-0050`'s sealed §5 said
   in advance. F-c1's kill of T-C4 shows C4 has teeth on the runt path; it is not
   proof the citation holds. **The discharge-by-citation remains unqualified.**
2. **F-c3's reach inside T-F2 is `k ∈ {1, 4}`** (F-2). The `k = 0` case is
   exercised by F-c5 and F-c6 but not by F-c3.
3. **M03-F2 convicts the underflow but cannot diagnose it** (R-1).
4. **M03-A3 is measurably blind to lane-symmetric content errors** (§3).
5. **The shared no-output-word path is unestablished** (F-4).
6. **F-c2 is seeded on the received-count reading only**, as sealed.

### 9. `SO-M03` — coverage arithmetic

The attack plan carries **76 rows, 60 ASSERT**. Benched after family F: **25
rows** — A1–A5, B1, C1–C5, L6, D1–D4, E1–E5, F1–F4 — of which **21 are
ASSERT-class**, F5 discharged by citation. **Thirty-nine ASSERT rows
outstanding.**

**`SO-M03` DOES NOT ISSUE.** Families **G, H, I, J, K, M, N** and **L1–L5** are
unwritten. Note for the sign-off path, per the ruling at `J-dv_lead-0060`:
families F and G are **not** waiting on the differential co-sim — REQ-901's
classes (e) and (f) mean the lane can never anchor REQ-107 or REQ-108, and their
directed rows are the whole of their verification.

**Twenty-one of sixty.** The instrument keeps proving itself; the coverage is
still early, and the second of those facts is the one a sign-off turns on.

---

## ADDENDUM — FINDING F-4 disposed: UNTESTED, not refuted; and the untested half is owed a class because I over-pinned my own intent — dv_lead, `J-dv_lead-0065`

`RV-0050-VERDICT` §6 named two hypotheses for F-c8 killing one REQUIRED unit of
three, said the discriminator was in the diff at `4ef6628`, and **declined to
read it** — reading a mutation diff to settle an adjudication contaminates every
round after it. Post-verdict (the adjudication is committed at `c3e877a`) the
orchestrator cleared the read, and the discriminator is not in the diff's code at
all: **it is in the seeder's own disclosure**, written before any run.

### 1. What the disclosure says

`docs/reports/audit/WO-0050-mutations/README.md` §3.8 seeds the in-word half of
§9's pin whole — the two fixed register stages become one — and then, under a
heading of its own, states what the diff does **not** reach and why. The
no-output-word class has a **second** implementation: an epoch-A record consumed
at age 2 because no `tlast` ever came. The auditor did not displace it, on the
ground that one expression serves **both** pins, so moving the no-output-word
half one cycle earlier would also fire the consume before the `tlast` of every
frame whose received length is 5, 6 or 7 modulo 8 — clearing the record before
its own `tlast` word and taking `tuser`[0] and the FCS strip with it. That breaks
§9's `tlast` pin and REQ-103's removal **on the very class this intent
protects** ("Frames that do produce an output word are unaffected").

That is `WO-0050` §2's standing clause operating exactly as written — *preserve
the spec rule and disclose the collision* — and it is the same disposition
WO-0045's declined E-c2 in-word half received, for the same reason.

### 2. Ruling

**F-4 is UNTESTED, not refuted. The orchestrator's reading is correct and I adopt
it.**

The diff was **narrower than the campaign intent by a disclosed spec-collision
ruling**, so M03-E2 and M03-F2 stayed green **because their pin was never
displaced**. A green cell under a stimulus that was never applied is not
evidence about the cell. Nothing in this campaign bears either way on whether
the two no-output-word classes share a report path.

**Three things follow, and the third is the one that costs me something.**

1. **The seeding is not a fidelity failure and no finding lies against the
   auditor.** The narrowing was argued from the spec rules it would have broken,
   disclosed before any run, and confined to the half it names. It is the clause
   working. My verdict's hypothesis (a) is confirmed; hypothesis (b) is neither
   confirmed nor excluded.
2. **`WO-0047` §1.2's shared-no-output-path claim remains unestablished**, and
   `RV-0050-VERDICT` §6's bar stands unchanged: **no packet may cite it.** It was
   a claim I made about the design's structure, from a DV packet, without an
   instrument — and the first instrument that could have tested it did not run
   against it.
3. **The untested half is OWED a class, and it is not structurally unseedable.**
   The collision the auditor names is a collision with *displacing that pin
   **earlier***. My `WO-0050` §2 intent said, in bold, "Displace it **earlier by
   one**, not later, and not by two" — a direction I pinned so that the sealed
   message could carry an exact `Y − X = 1`. **That over-specification is what
   made half the class unseedable, and it is mine.**

> **The instruction for the next class, stated so it is not repeated**: name the
> **observable** — the epoch-A no-output-word report moves by one cycle — and
> **leave the direction to the seeder**, disclosed in the return. The seal then
> admits both signs and loses a little exactness. That is the right trade and I
> made the wrong one: **message exactness and class coverage were in tension here
> and I paid coverage for exactness without noticing I was paying.**
>
> This is the same defect as `WO-0047` §4.1 — over-specifying a mechanism I had
> not traced — arriving one packet later in a different costume. There I told a
> worker *how* to build a stimulus and was wrong about the machinery; here I told
> a seeder *which way* to break a pin and was wrong about the design. **The rule
> that covers both: a packet specifies the observable and leaves the mechanism to
> the party that can see it.**

### 3. Where this is recorded

The standing consequences live in the attack plan, not only here:
`AP-xgmii_rx_64.md` §8 gains **item 5** (the claim, its status, and the owed
class), M03-E5's row records that F-c8 killed it alone, and §9's change log
carries the round. This addendum is the ruling; the plan is where a future
packet will look.
