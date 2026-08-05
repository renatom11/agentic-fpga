# WO-0074: the family-M mutation campaign — eight strobe-set classes against twelve carrier units in five families, and the first campaign in this programme whose qualification criterion and whose datapath-silence check are the same test

- **State**: **DRAFT** — dv_lead's draft. The orchestrator issues it, operates it
  (PROTOCOL §10's transient model) and allocates its id (PROTOCOL §3); `0074` is
  the id the spawn allocated and is used throughout.
- **From** / **To**: dv_lead → **auditor** (manifest author), via the
  orchestrator (campaign operator).
- **Spec basis**: `docs/specs/modules/xgmii_rx_64.md` **§9** in its entirety —
  the strobe/condition table's nine rows, the **closure list** (*"A frame is open
  from the cycle M03 accepts its start character until the earliest of: its
  terminate character (REQ-106); an error character arriving while it is open
  (REQ-105); a new start character (REQ-110); REQ-108's truncation, on the cycle
  the received count passes 1518; or `clear` (REQ-009)"*), the two clauses stated
  twice, the **"Strobe cycle, pinned"** paragraph and its no-output-word pin, and
  above all the **eight co-occurrence rulings** and the ninth (`1fe71ca`) that
  this campaign exists to score; **§6.1** items 1–4 (the residue recipe and its
  seed), **§6.2**'s `Frame` and `Discard` rows and their exits, **§6.3** items 2
  and 6, **§7**; `docs/specs/requirements.md` **REQ-103**, **REQ-104**,
  **REQ-105**, **REQ-107**, **REQ-108**, **REQ-110**, **REQ-008**, **REQ-007**,
  **REQ-304**, **§0.6**, **§0.7**, **§12**.
- **Plan basis**: `test/attack_plans/AP-xgmii_rx_64.md` **§4.M** rows `M03-M1` …
  `M03-M10` with their Kills cells, its **row-index warning**, its
  **LANDED-STATUS block** at `70a263f` / CI run `31022685374`, `FINDING M-1` and
  `FINDING M-2` (the M6/M7 re-pointing, landed `J-dv_lead-0132`) and
  **OBSERVATION M-O1**, which this packet is the named carrier of; **§4.B**,
  **§4.E**, **§4.F**, **§4.G**, **§4.H** for the carrier rows themselves; **§2**
  items 1–4 (the standing monitors and the C-23 counting convention); **§7**'s
  X-rows.
- **Bench basis**, named because a campaign that scores message-level cells is
  scoring *files*: `test/xgmii_rx_64/test_m03_b.ml`, `test_m03_e.ml`,
  `test_m03_f.ml`, `test_m03_g.ml`, `test_m03_h.ml` at the base SHA — the twelve
  carrier units are `M03-B3`, `M03-E1`, `M03-F1`, `M03-F2`, `M03-F3`, `M03-G1`,
  `M03-G3`, `M03-G4`, `M03-G7`, `M03-G8`, `M03-H1`, `M03-H3`. **Family M owns no
  file**: it is a family of bindings, and that is the whole shape of this round
  (§0).
- **Binding**: the auditor's **R-DISC-1** and **R-DISC-2** (`DISP-0001` §4,
  `fab31de`) bind these manifests and are adjudication criteria for them.
- **The seal**: `WO-0074_family-m-mutation-campaign-SEALED-predictions.md`,
  frozen in **this packet's own commit**, before any diff exists. **If this
  commit does not stage that file, this round has no seal**, its cell-level
  claims may not be made, and the absence is a finding against me — my own rule,
  written against me at `J-dv_lead-0113` Open-question 1 and restated at
  PROTOCOL §10's **R-SEAL-1**.
- **Precedent carried in terms**: `WO-0063B`'s pre-run reading note. **If the
  manifest raises a question for me, it comes to me BEFORE the run**, as a
  committed reading note, not as a post-hoc reading of a scorecard.

---

## Section map

| § | what it fixes |
|---|---|
| 0 | what a binding family's campaign is, and the four things this round cannot do |
| 1 | the eight intent classes and their ten mandatory disclosures |
| 2 | the denominator, re-measured at this tree — and a defect in my own instrument |
| 3 | the convicting instruments, measured from the landed files: **the strobe-set assertion is LAST in all twelve carriers**, and what that forces |
| 4 | **what this campaign structurally cannot score, declared before it runs** |
| 5 | reachability, discharged term by term — both sides |
| 6 | §4(c) as a test — and this round the check IS the qualification criterion |
| 7 | the allowlist, and what the manifests must carry |
| 8 | the base SHA and the adjudicator-ordering rule; the three bounded classes' scoring rules |
| 9 | mutant-owned quantities, and how they are sealed |
| 10 | collisions: what two pairs and one triple cost the manifest |
| 11 | the carrier/bound-row rule — restated, and **corrected against my own plan text** |
| 12 | cost, priced before seeding |
| 13 | what this round does NOT close, and the owed list with carriers |
| 14 | weighting, discounted in advance |
| 15 | what comes back |
| 16 | not to be told |

---

## 0. What a binding family's campaign is, and the four things it cannot do

Seven rows landed at `70a263f` and **not one of them has been scored**:
`M03-M1` … `M03-M7`. An eighth, `M03-M10`, landed earlier still with its own two
carriers and has never been scored either. This is the **second** of the four
campaigns that convert titles into scored rows, and it is unlike the first in one
structural way that governs the entire design:

> **Family M writes no assertion of its own.** Each of its rows is a *binding*
> between one of §9's co-occurrence rulings and an assertion that already exists
> inside a carrier unit of families B, E, F, G or H. The inventory did not move
> when family M landed; the census moved by seven (`RV-0071-VERDICT`).

That shape has one consequence that decides this packet, and it is stated first
because every later section depends on it:

**A red at a carrier is not a family-M result.** The M row's assertion is *one*
of the carrier's assertions — the exact-strobe-set check — and §3 measures that
in all twelve carriers it is the **last** assertion in the unit. A mutation that
moves a word count, a `tkeep`, a `tlast` cycle, a `tuser` bit or an octet
reddens the carrier at an **earlier** assertion and the strobe-set check never
runs. `WO-0073` measured exactly that: IC-L2 and IC-L5 reddened `M03-G3`,
`M03-G4`, `M03-G7` and `M03-G8` — the four carriers `FINDING M-1`/`M-2` bound
`M03-M6` and `M03-M7` to — and **no family-M row was qualified**, correctly.

**Therefore every class in this campaign is datapath-silent by construction**, and
the qualification criterion is stated once, here, in the form every later section
uses:

> **A class qualifies its M row iff the exact **strobe SET** changes — a second
> strobe appearing beside the first, or the wrong member of the set — with the
> delivered stream unmoved, so that the carrier's own strobe-set assertion is the
> assertion that speaks.** A carrier reddening at any earlier assertion qualifies
> nothing in family M, whatever else it proves.

**Four things this round cannot do, stated first so no verdict drifts into
them.**

1. **It cannot qualify `M03-M8` or `M03-M9`.** M8 is `NO-STIMULUS` (the runt and
   oversize octet ranges are disjoint, so no stimulus exists) and M9 is
   `STRUCTURAL` (M03 is the origin of `tuser`[0] on this chain; §0.6's
   inheritance clause has no instance here). **Neither is a gap and neither is
   seedable** — §4 says so with the derivation, before a scorecard can be read as
   implying otherwise. The class ids below therefore run **IC-M1 … IC-M7, IC-M10**
   and skip 8 and 9, mirroring §4.M's own row-index warning.
2. **It cannot pay the charter §3 differential co-simulation anchor**, and §4
   item 5 states a new and sharper reason than "it has not been driven": the
   pinned canonical form has **no strobe field at all**, so the anchor is blind
   to *every* class in this campaign by construction and not merely by stimulus.
3. **It cannot open an `SO-`.** Families **J** and **K** remain unscored and the
   anchor is undischarged per class.
4. **It cannot settle the 4-octet anti-vacuity question `WO-0047` §2 raised.**
   `M03-F2`'s zero-octet member speaks before its 4-octet one (§4 item 6); the
   4-octet member is **shadowed, not unreachable**, and the difference is
   recorded rather than glossed.

---

## 1. The eight intent classes

Each is **one kill**, never one kill per reddened unit. Each is derived from a
sentence of §9 — in seven cases from a co-occurrence ruling and in one from the
ninth ruling — and each is named with the row whose Kills cell it instantiates.
**Every one of them changes only which strobes pulse.**

### IC-M1 — a precedence design at a runt with a wrong FCS (ruling 1)

**Ground**: §9's first co-occurrence ruling: *"`error_runt` with
`error_bad_fcs`: yes, and both pulse. A frame of 5 to 63 octets ends with a
terminate character, so its FCS is removed and is checked (REQ-103); if it is
also wrong, two locally detected conditions apply to one frame and
requirements.md §0.6 makes each pulse once. `tuser`[0] is set once."* `AP` §4.M's
`M03-M1` Kills cell names the class in one word: **a precedence design**.

Render a design that reports **one** of the two conditions on a frame to which
both apply, instead of both.

**Required consequence**: at a 5–63-octet frame whose received FCS mismatches,
exactly one strobe pulses where the specification requires two. **Everything else
is unchanged**: the frame is still forwarded, still delivers its
FCS-removed extent, and still carries `tuser`[0] = 1 — because *either* surviving
condition marks it (REQ-007), which is what makes this class datapath-silent.

**Why the ruling's second sentence matters to the class**: a runt with a
**correct** FCS pulses `error_runt` **alone** in a conformant design. A rendering
that keys on "this frame is a runt, so suppress the FCS report" must therefore
leave that case identical, and a rendering that keys the other way must too. The
seal makes that a **required green**, and it is what separates the class from a
design that merely dislikes runts.

#### 1.1 MANDATORY DISCLOSURE **D-M1a** — which member survives

- **R** — `error_runt` survives, `error_bad_fcs` is suppressed.
- **B** — `error_bad_fcs` survives, `error_runt` is suppressed.

Both are the class. **They are message-identical at the scored cell** (§10
collision 1) and the seal branches on the disclosure alone.

#### 1.2 MANDATORY DISCLOSURE **D-M1b** — the strobe, or the whole condition

Does your rendering suppress **only the strobe output**, or the **condition**
itself, including its contribution to `tuser`[0]? **The class is the first.** If
`tuser`[0] on that frame can go to 0, the rendering has moved the datapath, an
earlier assertion speaks, and §8.1 rule 3 governs. Answer before the run.

### IC-M2 — the residue comparison runs at REQ-108's truncation point (ruling 2)

**Ground**: §9's second ruling: *"`error_oversize` with `error_bad_fcs`: never.
REQ-108 says so explicitly, and the reason is that no FCS is present at the
truncation point, so no check is performed and no result exists to report."*
`AP` §4.M's `M03-M2` Kills cell: *"A design that checks the residue at the
truncation point, where no FCS is present."*

Render a design that, when REQ-108's truncation closes a frame, runs §6.1's
residue comparison over the octets it has received and pulses `error_bad_fcs` on
the outcome.

**Required consequence**: the truncated frame is still truncated to exactly 1514
delivered octets, still carries `tuser`[0] = 1, still emits 190 words on the same
pinned cycle — and now reports **two** strobes where §9 admits one.

**This is `OBSERVATION M-O1`'s own seeded class, and this packet is its named
carrier.** M-O1 records that `M03-M2`'s anti-vacuity ground is thinner than
`M03-M3`'s: M3 has sixteen cases and M4 two, while **M2 has one stimulus at two
lanes over a single deterministic 1518-octet prefix**, so an accidental residue
match at M2 is a 2⁻³² event that is nonetheless *fixed* rather than random. **A
bench cannot settle that and this campaign can**: seed the class and observe
whether the carrier reddens.

> **And the observation is widened here, by a derivation done at draft time
> rather than by the run — `FINDING M-O1a`.** The quantity that governs
> anti-vacuity is not the number of *cases* but the number of **distinct
> delivered-octet contents at the closure point**, because the residue is a
> function of the content alone. Measured at the base tree: `M03-M3`'s carrier
> drives **eight** distinct contents (prefixes of one 64-octet base at delivered
> lengths 24…31, each at two start lanes); `M03-M2`'s drives **one** (the same
> 1518-octet prefix at both lanes); and **`M03-M4`'s drives one as well** — its
> two cases deliver the identical 64-octet filler at both lanes. **So M4's ground
> is exactly as thin as M2's, and M-O1's own ranking of "two versus one" is
> wrong in the direction that matters.** IC-M4 therefore rides this campaign for
> the same reason IC-M2 does, and §8.1 rule 2 scores both the same way.

#### 1.3 MANDATORY DISCLOSURE **D-M2a** — the extent and the constant

State **over which octets** your comparison runs (the 1518 received, the 1514
delivered, the whole 1600, or another extent) and **against which constant**
(REQ-304's residue, or a computed CRC compared to a received field). The cell
does not read the extent; **the reachability discharge does**, and so does
`OBSERVATION M-O1`, whose whole subject is whether a *particular* content
produces a mismatch. A manifest that does not answer D-M2a has not seeded a
class whose vacuity question can be adjudicated.

### IC-M3 — the residue comparison runs at an error-character closure (ruling 3)

**Ground**: §9's third ruling: *"`error_bad_frame` with `error_bad_fcs`: never,
for the same reason — a frame ended by an error character has no terminate
character, so REQ-103 attempts no FCS removal and M03 performs no check."*
`AP` §4.M's `M03-M3` Kills cell: *"A design that runs the residue comparison on
every frame closure regardless of how it closed."*

Render a design that runs the comparison when an **error character** closes an
open frame, and pulses `error_bad_fcs` on the outcome.

**Required consequence**: the aborted frame still delivers exactly the octets
strictly preceding the `/E/`, still carries `tuser`[0] = 1, still emits on its own
pinned cycle — and reports a second strobe.

#### 1.4 MANDATORY DISCLOSURE **D-M3a** — the extent

Does the comparison run over the octets **delivered before** the error character
(the `/E/`'s own octet position excluded)? A rendering that includes the error
character's position, or that first applies REQ-103's four-octet removal on an
abort path, is a different class and the seal's cells do not apply to it.

### IC-M4 — the residue comparison runs at a start-character closure (ruling 4)

**Ground**: §9's fourth ruling: *"`error_start_without_terminate` with
`error_bad_fcs`: never, likewise."* `AP` §4.M's `M03-M4` Kills cell: *"(as
M03-M3)"* — and the plan is right that it is the same defect, one closure kind
over, which is exactly why it is a **separate diff** here (§10).

Render a design that runs the comparison when a **new start character** closes an
open frame.

**Required consequence**: the aborted frame still delivers all its received
octets with **no FCS removed** (REQ-110's no-removal clause), still carries
`tuser`[0] = 1 — and reports a second strobe.

#### 1.5 MANDATORY DISCLOSURE **D-M4a** — the extent

As D-M3a, for the start-character closure: the octets delivered before the new
`/S/`, with no REQ-103 removal attempted.

### IC-M5 — the error character does not close the frame *for the abort detector* (ruling 5)

**Ground**: §9's fifth ruling: *"`error_bad_frame` with
`error_start_without_terminate`: never on the same frame. An error character
**ends** the frame (§6.2 leaves to `Idle`), so a start character after it begins
a new frame and aborts nothing. A bench that injects `/E/` and then `/S/` SHALL
see exactly one `error_bad_frame` and no `error_start_without_terminate`."*
`AP` §4.M's `M03-M5` Kills cell: *"A design in which `/E/` does not close the
frame."*

Render a design in which the **REQ-110 abort detector's** open-frame term is not
cleared by an error character, so that a later start character reports an abort of
a frame the datapath has already closed. **The delivery path is untouched**: the
frame is still truncated at the octet before the `/E/`, still marked, still
emitted on its own pinned cycle.

**Why the class is restricted to the report path, stated before the run.** The
unrestricted reading — the frame stays open for *everything* — necessarily moves
the delivered extent, an earlier assertion speaks, and by §0 the M row is not
qualified. **The unrestricted rendering is not a better class, it is a class this
bench cannot attribute**, and saying so before the run is the difference between
a declaration and an excuse.

#### 1.6 MANDATORY DISCLOSURE **D-M5a** — is the delivered extent unchanged?

**Must be YES for the class.** If your minimal diff cannot separate the abort
detector's open-frame term from the delivery path's — i.e. one signal serves
both — **declare it NOT SEEDED and quote the shared term**. That declaration is
a result of this campaign, not a failure of it: it would establish that ruling 5
has no datapath-silent mutant at this design, and §8.1 rule 4 fixes what may then
be said about `M03-M5`.

#### 1.7 MANDATORY DISCLOSURE **D-M5b** — the complete clear set

Name the **complete set** of events that still clear the report-path open-frame
term in your rendering (terminate character, new start character, REQ-108
truncation, `clear`). **The class removes exactly the error-character member.**
A rendering that also drops the truncation member is a different and wider class
whose red set overlaps IC-M6's, and §10's collision 2 prices that overlap.

### IC-M6 — a start character arriving in `Discard` is reported as an abort (ruling 6)

**Ground**: §9's sixth ruling: *"`error_oversize` with
`error_start_without_terminate`: never on the same frame. REQ-108's truncation
has already closed the frame with `tlast` and `tuser`[0] = 1; a start character
arriving during the `Discard` state is the resynchronisation REQ-108 requires,
not a second abort, and it pulses nothing."* `AP` §4.M's `M03-M6` Kills cell:
*"A design that re-opens a truncated frame."*

Render a design that pulses `error_start_without_terminate` when a start
character arrives while the module is in `Discard`.

**Required consequence**: the truncated frame is unchanged in every delivered
respect; the resynchronised frame the `/S/` opens is unchanged in every delivered
respect; **one additional strobe appears**.

**This class is the round's own measurement of `FINDING M-1`, and it is why the
finding was worth landing.** `M03-M6` binds **two** carriers of different epochs
(`WO-0056`; `AP` §4.M's Stimulus cell). One drives a start character **into the
`Discard` state**, which is the state ruling 6 is written about; the other drives
one **after the oversize frame's own terminate character**, where `Discard` has
already been left and the frame is doubly closed. **The finding asserted that the
second cannot reach the ruling's condition. This class measures it**, and the
epoch discrimination is a sealed required green rather than an argument.

#### 1.8 MANDATORY DISCLOSURE **D-M6a** — the gate term

Does your rendering key on the **`Discard` state**, or on **any start character
that finds no open frame**? Name the term. The second reading pulses on ordinary
inter-frame start characters and reddens most of the bench — it is **not** the
class, it scores zero under §8.1 rule 3, and it destroys the epoch measurement.
A third reading — *any start character while no terminate character has been seen
since the last one* — is IC-M5's wide branch and collides (§10).

### IC-M7 — an error character arriving in `Discard` is reported (ruling 7, C-12)

**Ground**: §9's seventh ruling: *"`error_oversize` with `error_bad_frame`: never
on the same frame, for the same reason and by the same ruling (carry-forward
**C-12**, dv_lead's proposed ruling adopted). REQ-108's truncation closes the
frame; an `/E/` arriving in `Discard` therefore finds no open frame, emits
nothing and pulses nothing."* `AP` §4.M's `M03-M7` Kills cell: *(the C-12
ruling)*.

Render a design that pulses `error_bad_frame` when an error character arrives
while the module is in `Discard`.

**Required consequence**: nothing is emitted for the absorbed character; the
truncated frame and the following frame are unchanged; **one additional strobe
appears**.

**This class is the round's own measurement of `FINDING M-2`**, exactly as IC-M6
is of `FINDING M-1`, and against the same two-epoch structure.

#### 1.9 MANDATORY DISCLOSURE **D-M7a** — the gate term

`Discard`-state-keyed, or keyed on **any error character that finds no open
frame**? The second reading pulses on every stray `/E/` in an inter-frame gap —
which §9's third table row and C-12 both forbid — reddens rows this class does
not name, and destroys the epoch measurement. Name the term.

### IC-M10 — the residue comparison runs at every terminate character (ruling 9)

**Ground**: §9's ninth ruling (`1fe71ca`): *"`error_runt` with `error_bad_fcs` on
a frame of fewer than 5 octets: **never** … a frame with nothing to remove an FCS
from supplies neither operand, so no comparison is made and there is no mismatch
to report … **A bench SHALL assert `error_runt` alone on every frame of 0 to 4
octets — an exact strobe set, not a lower bound**."* `AP` §4.M's `M03-M10` Kills
cell: *"A design that runs the residue comparison at **every** terminate
character regardless of whether the frame had an FCS to check."*

Render a design that removes the sub-five-octet suppression: at a terminate
closure it always compares, whatever the received count.

**Required consequence**: the sub-five frame still delivers **no output word**;
`error_runt` still pulses at §9's no-output-word pin; a second strobe appears.

**Why this class is in a campaign about seven bindings, and its price is named.**
`M03-M10` is §4.M's remaining `ASSERT` row, it is scored by no campaign, and its
carriers sit in families B and F whose campaigns have already run. **Family M's
own campaign is the last natural home for it**; the alternative is an orphan row.
It costs one transient (§12), and §12 states what dropping it would save and
what it would cost.

#### 1.10 MANDATORY DISCLOSURE **D-M10a** — the zero-octet operand

At a frame of **zero** received octets, what does your comparison compare? §6.1
item 2 never updates the register there, so item 4's *"that final value"* is
§6.1 item 1's **0x00000000 seed**, which is not REQ-304's residue `0x2144DF1C`.
State whether your rendering compares the seed, skips the frame, or does
something else — the answer decides whether the class fires at the member that
speaks first.

---

## 2. The denominator, re-measured at this tree — and a defect in my own instrument

Re-measured at the base tree, **not carried forward** from `WO-0073`:

```
    3  test_m03_a.ml    7  test_m03_b.ml    4  test_m03_c.ml    3  test_m03_d.ml
    4  test_m03_e.ml    4  test_m03_f.ml    7  test_m03_g.ml    4  test_m03_h.ml
    5  test_m03_i.ml    3  test_m03_j.ml    2  test_m03_k.ml    2  test_m03_l.ml
    8  test_m03_n.ml    3  test_m03_structural.ml
  ---
   59  test/xgmii_rx_64/ (the M03 bench)
  139  test/ (repository-wide, OCaml units)
```

**59 M03 units; 139 repository-wide; 80 non-M03**, split `monitors` 37 +
`xgmii` 25 + `golden` 11 + `axi64_probe` 3 + `xgmii_probe` 3 = **79
behavioural**, and `hardcaml_ethernet` **1 build-level**. The row-discharge
census at the same tree reads **78 rows declared, 62 named in a unit title**
under **both** matchers, with the two declared adjustments (`M03-A4` subtract 1,
`M03-F5` add 1) leaving **62 of 62 ASSERT rows discharged** — unmoved from
`WO-0073`'s base, as it must be, since no `test/**` byte has moved except the
attack plan's own.

> **`FINDING M-4` — my own inventory instrument is contaminated, and it was
> contaminated by the sentence that recommends the better instrument.**
> `tools/dv_checks.sh`'s repository-wide line runs
> `grep -rh 'let%expect_test' test/ | grep -c .` — **over every file under
> `test/`, not only `*.ml`**. At this tree it reports **140**. The 140th match is
> `test/attack_plans/AP-xgmii_rx_64.md:865`, a line added at `2761ec5` whose own
> content is the *anchored, `--include=*.ml`* matcher this programme now prefers.
> Three commands, at this tree: the script's matcher gives **140**; the same
> matcher restricted to `*.ml` gives **139**; anchored and restricted gives
> **139**. **The OCaml unit count is 139 and this packet uses 139.** The repair
> is a one-word change to a `tools/**` file and is **owed, with a carrier**
> (§13.4) — it is not made here, because §8's freeze is worth more than a tidier
> script and because `tools/` is not this commit's business. The general form,
> banked for the harvest: *a counting instrument that reads a directory rather
> than a file type will eventually count its own documentation.*

**Family M is 0 of the 59.** Its twelve carriers are 12 of the 59, spread across
five files; the other **47** are governed by each class's stated **rule** (§3.3).

---

## 3. The convicting instruments, measured from the landed files

**Method, so it is checkable**: for each of the twelve carrier units, every
`fail`/`failwith` reachable from the unit was enumerated in source order at the
base SHA and classified by the object it reads. The result is the seal's §2; the
parts a manifest author needs are here.

### 3.1 The one structural fact this campaign rests on

**In all twelve carrier units the exact-strobe-set assertion is the LAST assertion
in the unit**, immediately before the monitor sweep, and every datapath
assertion — output-word count, `tlast` cycle, `tkeep`, `tuser`, delivered octet
content, and (where the row has one) the same five facts for the following
frame — precedes it. In the oversize family this ordering is not incidental: the
files' own headers record it as a stated convention (*"structural first, specific
after, the strobe set last where it is the row's own point"*).

Two consequences, and both are load-bearing:

1. **A datapath-moving mutation can never qualify a family-M row.** It reddens
   the carrier earlier and the strobe-set assertion never runs. This is §0's
   criterion, now measured rather than asserted.
2. **A strobe-set mutation reaches the assertion only if every datapath
   assertion passes** — which makes each REQUIRED red in this campaign a
   *compound* statement: the class's own strobe change **and** the untouched
   correctness of the whole delivered stream, in one message. That is a stronger
   cell than family L's, and it is a property of the ordering rather than of my
   seal.

### 3.2 Iteration and shadowing

Every carrier is its own `%expect_test`, so **no carrier shadows another** and
every one of them is independently observable in a single run. Inside a carrier,
members shadow: the multi-member carriers iterate start lane **0 then 4**
(outer), and where a second parameter exists it is the inner loop. **Only the
first reddening member of a carrier is observable in a passing-to-failing run**,
and the R-DISC-1 discharge is still required **per lane and per member**: a
member discharged term by term and merely unobserved is recorded as
**unobserved**, never as a miss and never as a pass.

### 3.3 The blast-radius rule

`FINDING WO-0066-3` cost me three MUST-STAY-GREEN violations because my seal
carried an **enumeration** where the auditor's manifest carried a **rule** and
the rule was right; `WO-0073` adopted the correction and it held. **This round
keeps it**: for every class, the predicted red set outside its own carrier is
stated as a **rule in stimulus terms**, with the instances I worked named
beneath it, and **the rule governs where the two disagree**. A red selected by
the rule is predicted blast radius and contributes **zero** additional kills; a
red outside the rule is a finding.

The rules are stated per class in the seal. **Two facts about their shape are
told here**, because they are facts about the bench and not about the answer:

- **The four residue-comparison classes (IC-M2, IC-M3, IC-M4, IC-M10) have wide
  rules**, because each selects every unit whose stimulus contains the closure
  kind it keys on, and those closures are the subject of four whole families.
- **IC-M1, IC-M6 and IC-M7 have very narrow rules.** IC-M1's is the narrowest in
  the programme to date: measured at this tree, **exactly one unit in the whole
  M03 bench drives a frame that is both a runt and wrong in its FCS**. A class
  whose entire convicting set is one unit says something precise when it kills
  and something precise when it does not.

Neither fact costs a class anything — kills are counted **per class**, never per
reddened unit — and neither may be reported as coverage.

---

## 4. What this campaign structurally cannot score — DECLARED BEFORE IT RUNS

Every statement here is derived from committed text at the base SHA: from §9, or
from the landed files' own control flow, or from the pinned co-simulation
grammar. None of it is contingent on the result.

1. **`M03-M8` has no mutant, and the ground is the specification's own
   arithmetic.** Ruling 8 says `error_runt` and `error_oversize` cannot co-occur
   because the octet ranges are disjoint: REQ-107's condition is 5–63 (and §9's
   sixth row 0–4), REQ-108's is > 1518, and one frame's received count cannot
   satisfy both. A design that pulsed both would have to mis-evaluate a *count*,
   which is a REQ-107 or REQ-108 defect that families F and G already score — not
   a co-occurrence defect. **There is no stimulus, so there is no cell, so there
   is no kill.** Declared, not omitted.
2. **`M03-M9` has no mutant, and the ground is the interface.** M03 is the origin
   of `tuser`[0] on this chain; §0.6's *"a module SHALL NOT re-report an
   inherited abort"* quantifies over an input bit this module does not have.
   **A mutation cannot make a design re-report something it cannot receive.** The
   row exists so that no `SO-` claims §0.6's inheritance clause as tested
   coverage here, and this campaign does not change that.
3. **No class here scores `tuser`[0] "set once".** `M03-M1`'s observable includes
   it, and it is **structurally unfalsifiable**: `tuser`[0] is one bit on one
   word, so "twice" has no rendering. The clause is a statement about the
   specification's own consistency, not a testable observable, and no kill in
   this campaign may be reported as evidence for it.
4. **No class here scores strobe ORDER within a cycle.** §9 pins each strobe's
   *cycle*, not its position among simultaneous strobes; the bench's own carrier
   for the two-strobe case sorts before comparing and its header says in terms
   that the physical order is a bench-probe artefact. **A mutation that
   reorders simultaneous strobes is invisible and is not a defect** — the seal
   records it as green by blindness so that the green is not read as vigilance.
5. **The differential co-simulation anchor is blind to this entire campaign, and
   the ground is stronger than "it has not driven the stimulus."** The pinned
   canonical transaction form (`test/cosim/canonical.mli`, `WO-0046` §2.3) is
   `{ tkeep; tlast; tuser0; octets }` per word plus an `Accept`/`Discard`
   decision per input frame. **It has no strobe field.** Every class here changes
   only which strobes pulse, and none changes a delivered word, a `tuser0` or a
   frame's accept/discard decision — so **even a co-simulation driving these
   stimuli could not convict any of them**. This is a third blindness beside
   `WO-0073-D2`'s (the lane is content-comparing, not timing-comparing) and it is
   a **standing property of the grammar**, not of the Phase-1 stimulus. A green
   `cosim` job in this campaign is therefore evidence of nothing, and §13.5
   carries the consequence into the cosim-lane round.
6. **`M03-F2`'s 4-octet anti-vacuity member is SHADOWED, not measured.** `WO-0047`
   §2 required a non-all-zero 4-octet filler, because `zlib.crc32(bytes(4))` is
   exactly REQ-304's residue and an all-zero 4-octet frame would pass a wrong
   design by accident. That discipline is **real and unmeasured by this round**:
   the carrier's members run 0, 1 then 4 received octets at lane 0 first, and the
   zero-octet member reddens under IC-M10 by §6.1's seed alone, so the 4-octet
   member never speaks in a passing-to-failing run. **Declared before the run**;
   the question stays open with a carrier (§13.6).
7. **A kill at a carrier is not a kill of the carrier's own row.** Families B, E,
   F, G and H were scored by their own campaigns against their own classes. This
   campaign's classes are co-occurrence classes; where one reddens a carrier, the
   verdict names the M row it qualifies and says explicitly which carrier reds
   are blast radius (§11).

**None of items 1–7 is a defect in the bench and none moves a row.**

---

## 5. Reachability, discharged term by term — both sides

**R-DISC-1 binds your manifests** (`DISP-0001` §4). For **each** of the eight
classes separately: name the gate signal, quote its **complete** defining
expression from the base file with line numbers, and evaluate **every** conjunct
on the named stimulus at the claimed firing cycle, calling out which conjuncts
are contributed by the **stimulus** rather than by the mutation.

**Per-lane and per-member evaluation is required wherever the class's own
consequence names more than one.** Every carrier in this campaign drives **both
start lanes**; three of them iterate a second parameter as well. Discharge at
**both lanes** for every class, and at **every member** of a multi-member
carrier — a lane or a member you did not evaluate is **NOT SEEDED** for scoring
purposes. Where a class's condition is a state (`Discard`), discharge the state's
**entry and exit** on the named stimulus, in octet times, and say which input word
the character in question lands in relative to both.

**R-DISC-2**: **every class in this campaign names the report path** — the strobe
generation and its per-condition enables — and **no class names the datapath**.
That inverts `WO-0073`'s inventory exactly, and it is the whole content of §6:
say so explicitly in the gate inventory, because a term you touch in the emission
or acceptance path is a term outside every class here and is the fastest route to
a red that scores nothing. Each path gets a gate-inventory row carrying its full
term list and every intent's claim about it, **before delivery**, with
**cross-class gate facts tabulated** — every term two classes both touch, named
before delivery rather than discovered. **Four of the eight classes (IC-M2,
IC-M3, IC-M4, IC-M10) will touch the same FCS-report enable**; that is expected,
it is a fact about the file's layout, and `WO-0073-VERDICT` §7 Q4 already ruled
that a shared site is not a combined diff. **Four separate diffs remain
mandatory.**

**And the same standard applies to me, on the bench side, discharged here.**
Every `R!` cell in the seal is a message raised by an assertion whose own terms
are:

- **(a)** the stimulus reaches the assertion — every carrier is its own
  `%expect_test`, so no carrier shadows another; inside a carrier the members
  shadow and §3.2's order is the whole of the adjudication;
- **(b)** the observable is read from the DUT's own error outputs under the
  `Before` view, so the pulse belongs to the cycle whose input word was driven
  and no relabelling stands between the pulse and the check;
- **(c)** every assertion ordered **before** the scored one is unmoved under the
  class — which for this campaign means **every datapath assertion in the unit**,
  and is discharged per class at §6;
- **(d)** nothing outside the unit is required for the conviction.

---

## 6. §4(c) as a test — and this round the check IS the qualification criterion

**The measured datapath-perturbation signature** (`BUG-0003` §V.10.2,
`J-dv_lead-0103`, transient tree `5c47582`): **(a)** 7 mid-frame words with
`tkeep` ≠ 0xFF and `tlast` = 0; **(b)** 4 of 60 required octets in their gapless
byte positions, 28 delivered as the idle filler `0x07` and **28 never delivered
at all**; `tlast` on word 7; `tuser` = 0 on a corrupted frame.

`WO-0063B` had to record that the signature had **no domain** at the unit it was
scoring. `WO-0073` recorded the opposite extreme. **This round is different from
both**: the signature's domain here is every carrier's delivered stream — ten
units across five families, including two 1514-octet truncated frames, an
eight-lane sweep of abort extents and three no-output-word classes — and, more
importantly, **the check is not a side condition of this campaign. It is the
qualification criterion, stated at §0 and measured at §3.1.**

1. **The auditor's pre-ship check, for ALL EIGHT classes** — no exceptions this
   round, because no class here is entitled to move the datapath. Before
   delivering each manifest, confirm the rendering produces **none** of the
   signature's components on a delivering stimulus, and confirm positively that
   the delivered word count, every `tkeep`, every `tlast` placement, every
   `tuser`[0] and every delivered octet are **identical** to the base at the
   class's own carrier. A rendering that changes any of them is not the class; it
   is the class plus a datapath defect, and the two cannot be scored apart.
2. **My adjudication check, and it is executable.** In every carrier the datapath
   assertions are evaluated **before** the strobe-set assertion (§3.1). So a
   rendering that moves the datapath raises a **datapath** message and never the
   strobe-set message. The enumerated datapath messages are sealed; the rule is
   not.

**Consequence, fixed here so it cannot be renegotiated**: for **every** class in
this campaign, a red at a carrier carrying a datapath message scores as **the
class out of specification — reported, not scored**, no claim about the affected
M row is made in either direction, and the class's kill is not counted from that
red. **There is no class in this campaign to which this check does not apply**,
and saying that is the difference between a check and a ritual.

---

## 7. The allowlist — BLINDED, and absolute

**This is the complete set of repository paths you may read for this campaign's
duration. Everything else is out of bounds, absolutely.**

| | readable |
|---|---|
| 1 | `libs/hardcaml_ethernet/src/xgmii_rx_64.ml` **and its `.mli`**, at the base SHA — the mutation target |
| 2 | `docs/specs/requirements.md` and `docs/specs/modules/xgmii_rx_64.md` — the specs this packet names |
| 3 | **this packet** |
| 4 | `docs/reports/audit/**` — your own tree |

**Out of bounds, absolutely, for the campaign's duration**: **all of `test/**`** —
which includes all five carrier files, `bench.ml`/`bench.mli`, `test/xgmii/`,
`test/monitors/`, `test/cosim/` **and the attack plan
`test/attack_plans/AP-xgmii_rx_64.md`** — **all of `agents/**`, this packet
excepted and its sealed companion emphatically not excepted**, and every journal.
The seal names cells, message strings, assertion orders and MUST-STAY-GREEN sets;
reading it is reading the answer. **The AP is barred by name because this
campaign's classes are quoted from its Kills cells**, and a manifest author who
reads the row that authored the class is choosing a diff against a written
expectation rather than against the specification.

**The manifests must carry**, per R-DISC-1 / R-DISC-2:

1. **Eight diffs** — IC-M1, IC-M2, IC-M3, IC-M4, IC-M5, IC-M6, IC-M7, IC-M10 —
   each **minimal and independent**: each applies alone to the base SHA,
   elaborates, and reverts cleanly. **No diff may combine two classes**; a
   combined diff makes both unscoreable, and §10 says why that matters more here
   than in any prior round.
2. **A reachability discharge per class, per named lane and per named member,
   term by term at the firing cycle**, with the stimulus-contributed conjuncts
   called out — or a **self-declared NOT SEEDED** for any term you cannot
   discharge.
3. **Gate-inventory rows** for the report path (every strobe's enable) and — as a
   negative — for the output-word emission and frame-acceptance gates, with every
   class's claim about each, and **cross-class gate facts tabulated**.
4. **All ten disclosures answered in your own words**: **D-M1a**, **D-M1b**,
   **D-M2a**, **D-M3a**, **D-M4a**, **D-M5a**, **D-M5b**, **D-M6a**, **D-M7a**,
   **D-M10a**.
5. **The §6 pre-ship check result for all eight classes**, in its positive form
   (the delivered stream is identical at the class's carrier), not merely the
   negative one.
6. **The base SHA you applied to**, quoted, and confirmation that it matches
   §8's.
7. **Anything the packet made you guess.** Per the `WO-0063B` precedent, a
   question about this packet comes to me as a committed **pre-run reading note**
   **before** the run, and I answer it in the same form. A question answered after
   a scorecard exists is not a question, it is a negotiation.

---

## 8. The base SHA, and the adjudicator-ordering rule

**One base SHA for the whole round** — all eight classes, the control run and
every MUST-STAY-GREEN sweep. `BUG-0003` §V.9's *"one round cannot carry two base
SHAs in its evidence"* governs.

**The base SHA is the commit that stages this packet and its seal.** Not its
parent. This is the corrective drafting rule adopted at `WO-0073-VERDICT` §7
after `FINDING WO-0073-M1` — my own defect, filed by the auditor before the first
branch was cut — and this is its first application: the packet and the seal are
not scored paths, so the correct base is the commit that stages them, which is
also the only commit an operator can be dispatched against. I cannot state its
hash: I never run git (PROTOCOL §2), and the commit has none until the
orchestrator creates it. **The orchestrator records the hash when it lands**; the
auditor quotes the hash it applied to (§7 item 6), and any disagreement is a
finding **before** the campaign runs, not after.

**The adjudicator-ordering rule, stated because it is what makes any of this
evidence.** **The bench must be frozen strictly earlier in history than any
mutant RTL it judges.** Concretely:

- Every `test/**` byte this campaign scores against is at or before the base
  SHA. The last `test/**` edit before this packet is the post-campaign plan
  round's (`J-dv_lead-0135`, the commit that absorbed the seventh campaign);
  **nothing under `test/**` moves again until the campaign scores.**
- The seal is frozen in this packet's own commit — **after** the last bench edit
  and **before** the first mutant diff exists.
- **No diff body reaches me until every diff is committed on its transient
  branch.** I adjudicate against the seal, and the seal is opened only when the
  scorecards are in hand.
- If any `test/**` file is edited between this commit and the scorecard, **the
  round is adjudicated as having no valid base** and re-runs from a fresh seal.
  **That includes edits by me**, and §13 is where I hold myself to it.

**Why the rule is not ceremony**: a bench edited after a mutant exists can be
tuned to it, and no reader downstream can distinguish a bench that always would
have convicted from one that was taught to.

### 8.1 Scoring rules for the classes whose value is bounded by a disclosure or by a vacuity question

**IC-M2 and IC-M4 — `OBSERVATION M-O1` and `FINDING M-O1a`, fixed before the
result:**

1. **Carrier red at the strobe-set assertion → the class is KILLED, the row is
   QUALIFIED, and the anti-vacuity question is ANSWERED in the row's favour**:
   the single content that carrier drives does produce a mismatch, so the row is
   not vacuous against this class. That is a measurement a bench cannot make.
2. **Carrier GREEN, with the class demonstrably seeded (R-DISC-1 discharged, the
   rendering confirmed to fire elsewhere) → the class scores ZERO at that row,
   the row stays UNQUALIFIED, and this is a `FINDING against the carrier's
   stimulus`, not against the manifest**: it would mean the one content that
   carrier drives happens to satisfy REQ-304's residue at the closure point, and
   the row passes a wrong design by accident. **That outcome is worth more than
   the kill would have been**, it is exactly what M-O1 asked for, and its repair
   (a second content at that carrier) is commissioned by the verdict, not by this
   packet.
3. **A green whose ground is that the class was never reachable** → disposition 3:
   void, zero kills, no claim in either direction.

**IC-M6 and IC-M7 — the epoch discrimination, fixed before the result:**

1. **The first-epoch carrier red AND the second-epoch carrier GREEN** → the class
   is KILLED, the row is QUALIFIED **on the first-epoch carrier alone**, and
   `FINDING M-1` / `FINDING M-2` are **measured**: the second-epoch carrier
   cannot reach the ruling's condition, which the finding argued from the
   stimulus and this round establishes from a run.
2. **Both carriers red** → the class is KILLED and the row is QUALIFIED, **but
   the epoch claim is NOT made**: a rendering that reddens both keys on something
   wider than the `Discard` state (D-M6a / D-M7a's second reading), and no
   verdict may report the finding as measured.
3. **The second-epoch carrier red and the first-epoch carrier green** → the
   rendering keys on something else entirely; the class scores **zero** and the
   row stays UNQUALIFIED.

**IC-M5 — the shared-term case, fixed before the result:**

1. **Delivered extent unchanged, carrier red at the strobe-set assertion** →
   KILLED, `M03-M5` QUALIFIED.
2. **Delivered extent changed** → §6's consequence governs: out of
   specification, reported, not scored.
3. **Self-declared NOT SEEDED with the shared term quoted** (D-M5a) → the class
   is void, `M03-M5` is recorded **SCORED AND UNQUALIFIABLE at this design**, and
   the declaration — that ruling 5 has no datapath-silent mutant here — is
   reported as the round's own result, in the same register `WO-0073` used for
   `M03-L3` and `M03-L4`.

---

## 9. Mutant-owned quantities, and how they are sealed

A quantity is **mutant-owned only if the specification does not fix it**. Every
such quantity is sealed as an **inequality with a named direction**, never as a
value; a seal that pins a rendering's own arithmetic scores a correct rendering as
a finding. The axes, with the cells in the seal:

| quantity | sealed as | direction, and why |
|---|---|---|
| the observed pulse **count** at the carrier of a class that adds a strobe (IC-M2, IC-M3, IC-M4, IC-M5, IC-M6, IC-M7, IC-M10) | an inequality **above** the row's own specified count, with the derived value stated | **more** — a second strobe appears beside the first. The specified count is §9's and is not mutant-owned |
| the observed pulse **count** at IC-M1's carrier | an inequality **below** 2, with the derived value stated | **fewer** — a precedence design reports one of two conditions. **This direction is the only thing separating IC-M1 from every other class at a count-shaped cell** |
| the **cycle** the added strobe pulses on | **mutant-owned and deliberately UNREAD** | no REQUIRED cell in this campaign reads it: every scored message is raised by the count-shaped arm of its carrier's match. Its appearance in a scorecard is information, never a cell, and a disagreement about it is not a finding |
| the **name** of the added strobe | **not mutant-owned at the scored cell** — the class fixes it, and the cell does not print it | §9 fixes which strobe each rendering can add; the count-shaped messages do not name it, which is precisely why §10's collisions exist |
| `tuser`[0] on every carrier frame this campaign touches | **not mutant-owned** — `= 1` | every such frame is already marked by its own primary condition (REQ-007). A rendering that clears it has moved the datapath and §6 governs |
| every delivered word count, `tkeep`, `tlast` cycle and delivered octet at every carrier | **not mutant-owned** — spec-fixed by REQ-103, REQ-108, REQ-110, §0.7 and §7 | this is §6's check restated as a seal: any movement is a datapath perturbation, not a rendering's prerogative |
| the observed **front offset** and the schedule facts every carrier checks before driving | **not mutant-owned** — bench-supplied | computed from the input trace alone; their appearance in a message means something other than a seeded class |
| **units reddening under a class** | `⊆` the class's **rule** (§3.3), not `⊆` an enumeration | a red outside the rule is a finding: either my rule was wrong or the diff reaches further than the class it names |

**Five of the eight rows are specification-fixed or bench-supplied and are sealed
as equalities on purpose**; calling them mutant-owned would be buying an
unfalsifiable seal. **The third row is the one to read twice**: it seals a
quantity as *unread*, which is a third disposition beside mutant-owned and
spec-fixed, and it is honest only because §3.1's measured ordering says which arm
of each match speaks.

---

## 10. Collisions — two pairs, one triple, and what they cost you

**Freely told**: this campaign contains **two pairs** whose messages at a shared
cell are **character-for-character identical** — one of them a pair of *branches
of a single class*, the other a pair of *different classes meeting at a carrier
one of them only reaches as blast radius* — and **one triple** of classes whose
messages at a shared third-party cell are identical, integer included. Which they
are, and the strings, are sealed.

**What that costs you, and it is operational rather than theoretical:**

1. **Every class is delivered as its own diff and run as its own transient.** For
   **one** of the two pairs, **which diff was applied is the only discriminator
   that exists** — the `IC-D`/`IC-F` situation of `WO-0066` and the collision-1
   situation of `WO-0073`, where the separation was carried entirely by the
   manifests.
2. **The delivery order is fixed**: IC-M1, IC-M2, IC-M3, IC-M4, IC-M5, IC-M6,
   IC-M7, IC-M10, each on its own branch, each with its own CI run id reported. A
   scorecard that cannot say which branch produced which message cannot be
   adjudicated.
3. **A combined diff makes both members of a colliding pair unscoreable** and is
   reported as a manifest defect, not as a result. The four residue classes
   sharing one enable term (§5) does **not** make them a combined diff —
   `WO-0073-VERDICT` §7 Q4 governs — but four diffs are still four diffs.

**Told because it is a fact about the bench and not about the answer**: for the
triple and for the second pair the discriminator **does** exist and is a
*measurement* — the state of other carriers under the same class — which is a
strictly better position than the first pair's, and the seal records which.

**And one consequence of the second pair is worth stating in the open, because it
is the commission's own question**: a class can redden a *carrier of another M
row* through its own ruling rather than through that row's, and produce a message
identical to the one that row's own class would produce. **That red is blast
radius and qualifies nothing**, however exactly it matches. The seal names every
such cell per class; §11's corrected rule is what governs them.

---

## 11. The carrier/bound-row rule, restated and CORRECTED against my own plan text

`WO-0073` §11 stated the era's rule at the era's first packet, and
`WO-0073-VERDICT` applied it correctly at its first test:

> **A carrier kill and its bound row are never two kills.** Where a campaign
> class reddens a unit that discharges both its own row and a row bound to it,
> the class scores **one** kill, and the verdict names both rows as qualified by
> **that one** conviction.

**That rule stands unamended and binds this campaign directly.** What does not
stand is a sentence of my own plan text that reaches further than the evidence —
recorded here as **`FINDING M-3`**, against `AP-xgmii_rx_64.md` §4.M's
landed-status block, item 4:

> *"every M row's assertion IS a carrier's assertion, so a seeded class that
> kills a carrier kills its M row **by construction**"*

**The antecedent is true and the consequent is false.** The M row's assertion is
*one* of the carrier's assertions and, measured at §3.1, it is the **last** one.
A class that reddens the carrier at an earlier assertion never reaches it, so it
kills the carrier's row and **not** the M row. `WO-0073` measured precisely that
case — four carriers of `M03-M6` and `M03-M7` reddened under IC-L2 and IC-L5, and
no family-M row was qualified — and the plan's §4.L block records the outcome
correctly while §4.M's sentence, written earlier, still asserts the general form.

**The corrected form, which this campaign is designed around:**

> A carrier kill kills its bound M row **iff the mechanism runs through the
> co-occurrence the row asserts** — iff the strobe SET changes and the carrier's
> strobe-set assertion is the assertion that speaks. Then it is **one** kill and
> **both** rows are named. Otherwise it is a kill of the carrier's row alone, and
> the M row is untouched in both directions.

**Carrier for the plan edit: the post-campaign `AP-` round** (§13.1). The
correction is stated here, before the run, so that it is not invented later by
whoever needs it — and so that this campaign's own scorecard is read against it.

Two companion rules of the same kind, both already earned and both binding here:

- **Kills are counted per class**, never per reddened unit (`WO-0066` §11).
- **A kill proves the assertion convicts, never that the bench is a general
  detector of the class** (`WO-0066` §10 item 4).

---

## 12. Cost — priced before the transients are seeded

**This campaign adds no stimulus.** Every unit it scores is already in the landed
suite and already runs in every CI job; there is no new schedule, no probe and no
frame-count decision to make. **Its marginal test cost is therefore exactly zero**
and its whole price is job walls — which is a different cost shape from `WO-0073`,
where a 10 000-frame schedule had to be measured before it could be defended.

The reference figures, quoted with their provenance rather than estimated: the
`build` job's whole wall was **344 s** at run `31015276337` (job `92337605716`),
of which the entire `dune runtest` step was **4 s**; family M's own binding round
landed at `70a263f` / run `31022685374` and family K's at `284225d` / run
`31032021108`, neither moving the step-6 wall materially.

| item | figure |
|---|---|
| classes | **8** |
| transient branches | **8** (one per class; §10 forbids combining) |
| CI `build` runs | **8** |
| CI wall, at the measured 344 s job | **≈ 45.9 minutes** |
| of which the whole `dune runtest` step | 8 × 4 s = **32 s** |
| of which stimulus added by this campaign | **0 s — it adds none** |

**Three consequences fixed before seeding.** (a) **No reduction proposal can be
made on stimulus grounds**, because the campaign contributes no stimulus; the
only lever is the class count. (b) **Dropping IC-M10 saves one job — 344 s,
≈ 5.7 minutes — and costs the only scoring `M03-M10` is scheduled to receive**,
since its carriers' own families have already had their campaigns. **My
recommendation is to keep it**, and the trade is stated in figures so the
operator can decide rather than infer. (c) **The control run is the base commit's
own CI run** and costs nothing extra; **CI is the authority** (ADR-0005) and
*"passes locally"* is not admissible from the auditor, the orchestrator or me.

---

## 13. What this round does NOT close, and the owed list with its carriers

**Named before the result, so no omission is invisible.**

1. **The attack plan does not move in this round's commit.** Every AP edit this
   campaign wants — §4.M's landed-status block gaining the campaign score, the
   per-row qualification cells, `FINDING M-3`'s correction of item 4, `FINDING
   M-O1a`'s widening of `OBSERVATION M-O1`, §7 gaining the §4 declarations, and
   the change-log row — is **owed, with a named carrier: the post-campaign `AP-`
   round**, which is the next commit that opens `test/attack_plans/**`. The reason
   is §8: moving a `test/**` byte between this seal and the scorecard costs the
   sentence *"nothing under `test/**` moves again until the campaign scores"* for
   zero measurement gain.
2. **`OBSERVATION M-O1` is carried into the run, not paid by this packet.** It is
   paid by IC-M2's and IC-M4's outcome under §8.1, and recorded by the verdict
   and then by the AP round. **This packet is its named carrier and this is the
   discharge of that carrier obligation** — the observation now rides a class,
   with a pre-fixed scoring rule for both of its outcomes.
3. **`FINDING M-O1a` and `FINDING M-3` are raised here and repaired nowhere
   here.** Both are AP text. **Carrier: the post-campaign `AP-` round.**
4. **`FINDING M-4` — `tools/dv_checks.sh`'s repository-wide inventory matcher —
   is raised and not repaired.** **Carrier: the next commit that opens
   `tools/**`**, which by the standing commission is the cosim-lane round. The
   contaminated figure is a *report*, not a check, and it cannot manufacture a
   green or redden a suite; the packet quotes the corrected 139 everywhere.
5. **§4 item 5's anchor blindness is recorded and not repaired.** The canonical
   grammar has no strobe field. **Carrier: the cosim-lane round** (commissioned
   at `WO-0073-VERDICT` §12 item 3), which now has **two** blindnesses to price
   rather than one — timing (`WO-0073-D2`) and strobes (here) — and a decision to
   make about whether the canonical form gains a strobe record at all. **I
   recommend that round be drafted after this campaign's verdict**, so it pays
   both from one measurement.
6. **`WO-0047` §2's 4-octet anti-vacuity question is not settled** (§4 item 6).
   It is shadowed rather than unreachable, and a directed measurement would need
   either a member reordering or a second carrier — both `test/**` edits, both
   forbidden until the campaign scores. **Carrier: the next commit that opens
   `test/xgmii_rx_64/test_m03_f.ml`.**
7. **Carried unchanged and not this packet's to pay**: `OBSERVATION L-O1`'s
   one-line repair (carrier: the next commit opening `test_m03_l.ml`);
   `WO-0073-D3`'s `M03-I4` mislabel (carrier: the next commit opening
   `test_m03_i.ml`); `OBSERVATION K-O1` (carrier: the next round opening
   `test/monitors/`); `test/cosim/dune`'s dangling `test/cost_probe/` reference
   and `WO-0073-D5`'s mislabelled BUILD verdict (carrier: the cosim-lane round).
8. **No `SO-xgmii_rx_64.md` issues and none is offered.** Outstanding before any
   PASS: the family **J** and **K** campaigns, and the charter §3
   verilog-ethernet differential co-sim anchor, undischarged **per class** and now
   additionally **blind per strobe**. The **lessons harvest falls due at the
   `SO-`**, spanning from my last harvest.
9. **A kill here qualifies a row on the class it was seeded against and on
   nothing else.**

---

## 14. Weighting, discounted in advance

**In favour of this round**: none of the eight rows was authored with a mutation
class known — all twelve carriers predate this packet by weeks — and the campaign's
classes are quoted from §9's own rulings rather than invented for the bench.
Three of the eight (IC-M1, IC-M6, IC-M7) key on conditions **only one unit each in
the whole bench produces**, which makes their kills attributable to a single
assertion rather than to a family. And the two epoch classes measure a finding
this programme argued and never ran.

**Against it, five ways, all stated before the scorecard:**

1. **Two of the ten §4.M rows cannot be scored at all** (M8, M9 — §4 items 1–2),
   and no verdict may imply the family is fully covered by a full scorecard.
2. **Every class here is a strobe-set class, so the campaign probes exactly one
   instrument family**: the exact-strobe-set check, twelve instances of it. That is
   the narrowest instrument footprint of any campaign in this era, and it is the
   direct consequence of what family M *is*. It says nothing about the datapath
   assertions in the same units, which other campaigns scored.
3. **The four residue classes are close relatives.** They differ only in which
   closure kind enables the comparison. Four kills there are four kills of one
   idea evaluated at four gates, and the verdict must say so rather than report
   four independent defects.
4. **IC-M5 may not be renderable at all** as a datapath-silent diff (§8.1); if it
   is not, the round returns a declaration where it hoped for a kill, and the
   declaration is worth less than the kill.
5. **`M03-F2`'s 4-octet member and every non-first member of every multi-member
   carrier are shadowed** (§3.2, §4 item 6). Shadowed is not tested, and the seal
   records every one of them as unobserved.

---

## 15. What comes back

1. The **eight manifests** per §7.
2. **All ten disclosures**, in the auditor's own words.
3. The **§6 pre-ship check** result for **all eight** classes, in its positive
   form.
4. The **full scorecard**: every unit red or green under each class, at the base
   SHA, with the **raised message at every red — the message, not a summary of
   it**, because the seal's cells are message-level. Where a unit raises inside a
   `List.iter` over lanes or members, the **row prefix** distinguishes the member
   and must be reproduced verbatim.
5. The **control run**: the unmutated base SHA green, with its **CI run id and
   conclusion**.
6. The **per-class CI run id and branch name**, so §10's ordering is auditable.
7. **The `cosim` job's conclusion under each class**, reported and explicitly
   **not** offered as evidence — §4 item 5 has already declared what a green
   there means.
8. Anything judged rather than followed, and why.

**Adjudication is mine**, against the sealed file, which is opened **only after
every scorecard is in hand**.

---

## 16. Not to be told

The sealed companion in its entirety: its matrix and its MUST-STAY-GREEN sets,
its verbatim message cells, the assertion orders inside every carrier, its row
prefixes, its UNWORKED adjudication rules, its disclosure-branch tables, **which**
classes collide and with what strings, its GREEN-BY-BLINDNESS section, its
per-class rules and worked instances, and its dispositions.

**Freely told, and told above**: the eight classes and the sentence of §9 each is
derived from; the ten mandatory disclosures; §2's denominator and `FINDING M-4`;
§3's structural fact that the strobe-set assertion is last in every carrier, and
the blast-radius rule form; **§4's seven declarations of what this campaign cannot
score**, including the anchor's blindness and F2's shadowing; §5's reachability
standard and the inverted gate inventory; §6's signature and the identity of the
check with the qualification criterion; §7's allowlist and manifest bars; §8's
base SHA, ordering rule and the three bounded classes' scoring rules; §9's
mutant-owned axes; §10's *existence* of one collision pair and one triple and what
they cost the manifest; §11's corrected carrier/bound-row rule; §12's price;
§13's non-closures and carriers; §14's weighting; §15's return format.

---

## Return / verdict log

*(empty — the auditor appends its return here, and dv_lead its verdict.)*

---
