# WO-0063B: the M03-I2 report-path-delay campaign — one class, one control, and the only instrument in this bench that reads a report against a drain bound

- **State**: **DRAFT** — dv_lead's draft. The orchestrator issues it, operates it
  (PROTOCOL §10's transient model) and allocates its id (PROTOCOL §3); `0063B` is
  a placeholder used for reference and is not a claim of allocation. It is the
  **phase-B execution packet** of the round whose planning packet is `WO-0063`
  and whose phase-A execution packet was `WO-0063A`.
- **From** / **To**: dv_lead → **auditor** (manifest author), via the
  orchestrator (campaign operator).
- **Spec basis**: `docs/specs/requirements.md` **REQ-109**, **REQ-107**,
  **REQ-105**, **REQ-110**, **§0.6** (the strobe window, the *bound-never-a-licence*
  note at `a12ac8f`, C-23's counting), **§0.7**, §12;
  `docs/specs/modules/xgmii_rx_64.md` **§6.1**'s drain derivation (**C-14.3**),
  **§9** (the closure list, the **no-output-word pin**, ruling 9).
- **Plan basis**: `test/attack_plans/AP-xgmii_rx_64.md` §4.I row **M03-I2** as
  amended at `J-dv_lead-0102`, and §4.B / §4.E / §4.F / §4.G / §4.H for the
  units this packet predicts as blast radius.
- **Binding**: the auditor's **R-DISC-1** and **R-DISC-2** (`DISP-0001` §4,
  `fab31de`) bind this manifest and are adjudication criteria for it.
- **The seal**: `WO-0063B_m03-i2-report-path-campaign-SEALED-predictions.md`,
  frozen in **this packet's own commit**, before any diff exists. `WO-0063` §6's
  forward commitment under **R-SEAL-1** falls due here and is redeemed here. **If
  this commit does not stage that file, this round has no seal** and its
  cell-level claims may not be made — my own rule, against me.

---

## 0. What this round settles, and the one thing it cannot

M03-I2's C-14.3 window has never convicted anything. `WO-0061` §3 measured both
halves of why: its only qualifier pulsed two cycles outside the window, and §9's
report path pins every report of a delivered frame inside the window's own
opening bound, so **no threshold-class defect can falsify it**. Phase A closed
the stimulus gap — member (iii), a frame closed by its own `/T/` with zero octets
received, which owes exactly one `error_runt` and no output word at all
(`c00771f`, `RV-0063A-VERDICT`). This phase asks the only question left: **does
that window convict a report-path delay, with its own message, before anything
else in its own unit speaks?**

**What this round cannot settle, stated first so no verdict drifts into it.** A
kill here proves the window **can** convict. It never proves the window is a
general detector, and no verdict of this round may say so — member (iii) is the
first unit in this programme authored with its mutation class known
(`WO-0063` §2.4's discount, unchanged and not renegotiated).

---

## 1. The two intents

### IC-1 — the no-output-word report is consumed one cycle late

§9 pins the report of a frame that emits **no output word** two cycles after the
input word carrying its closing character. **Render a design that consumes it at
age 3 instead of age 2** — a delay on the **report path**, with the datapath
untouched: no word moves, no `tkeep` changes, no octet count changes, no `tuser`
marking appears or disappears.

**Required consequence**: on M03-I2's member (iii), at **both** start lanes, the
pulse lands **at** the boundary the row scans from and the row's own window
raises with **its own message**. If your rendering cannot put a pulse at or after
that boundary on that stimulus, the class is **NOT SEEDED AS SPECIFIED** and you
say so in the manifest **before** any seal branches on it (R-DISC-1's own
escape). A disclosure made before running is not a green result and is not
scored as one.

### IC-2 — the control: the `tlast`-pinned report is consumed one cycle late

The **same** one-cycle deferral applied to the *other* pin — the report a frame
carries on its own `tlast` cycle (REQ-104's, REQ-107's with-delivery half).

**Required consequence**: **M03-I2 stays GREEN at all three members and both
lanes.** Member (iii) has no `tlast` word for the defect to attach to; members
(i) and (ii) are clean frames that owe no report at all.

**IC-2 is not decoration.** It is the question `WO-0061` §3 had to answer after
the fact, asked before the fact. **If M03-I2 reddens under IC-2, its red under
IC-1 is blast radius and the qualification does not stand** (§6 disposition 2). A
campaign that seeds only the class it hopes will convict cannot tell a working
instrument from a loud one.

### 1.1 MANDATORY DISCLOSURE — the axis the seal branches on

**Is your IC-1 rendering scoped to the closure character, or shared across the
whole no-output-word report path?** That is: does the deferral apply **only** to
frames closed by `/T/` (§9 ruling 9's sub-5 class), or **also** to frames closed
by `/E/` (REQ-105) and by `/S/` (REQ-110)?

The answer moves the predicted convicting set from three units to nine, and the
seal branches on it explicitly. `WO-0058` FINDING GH-2 and `WO-0061` FINDING S-4
are the same failure twice — a disclosure function with no column for the
dimension that decided the result — and this is that column, named before the
diff exists.

**Second disclosure, smaller and still required**: does your rendering defer the
report by holding it one cycle, or by re-deriving its cycle from a later
reference? Both satisfy IC-1; they differ in whether a *second* report in the
same run moves with it, which is what decides the two-registration units
(`test_m03_h.ml`'s `run_h4`, `test_m03_g.ml`'s `run_g7`).

---

## 2. The convicting set, measured rather than remembered

**This section supersedes `WO-0063` §5's figure and `RV-0063A-VERDICT` §7's
enumeration.** Both were written from memory of which rows own a no-output-word
pin; this one is measured from the tree at the base SHA, and it is **wider in one
direction and narrower in another**. An under-predicting seal scores a campaign
wrong in the direction that flatters it; an over-predicting seal claims a green
at a unit that does not exist. Both errors are present in my own prior
enumeration and both are corrected here.

**Method, so it is checkable**: every `Dv_monitors.Strobe_monitor.expect`
registration in `test/xgmii_rx_64/*.ml` was enumerated (28 sites), each mapped to
its enclosing runner, and each classified by the `cycle` field it registers and
the `why` it states — **no-output-word pin** (two cycles after the input word
carrying the closing character) or **`tlast`-pinned**. The classification is by
the registration's own text, not by what the row is "about".

**Nine units register a no-output-word expectation** and are therefore reachable
by IC-1 through the standing monitor:

| unit | runner | registration | strobe | direct pinned-cycle assertion of its own? |
|---|---|---|---|---|
| **M03-B2** | `run_b2` | `test_m03_b.ml:743` | `error_bad_frame` | **yes** — `:802` |
| **M03-B3** | `run_b3` | `:542` | `error_runt` | **yes** — `:620` |
| **M03-B4** | `run_b4` | `:337` | `error_start_without_terminate` | **yes** — `:421` |
| **M03-E2** | `run_e2` | `test_m03_e.ml:429` | `error_bad_frame` | **yes** — `:463` |
| **M03-E5** | `run_e5` | `:731` | `error_bad_frame` | **yes** — `:776` |
| **M03-F2** | `run_f2` | `test_m03_f.ml:425` | `error_runt` | **yes** — `:472` |
| **M03-G7** | `run_g7` | `test_m03_g.ml:1375` | `error_runt` | **no** — monitor-only |
| **M03-H4** | `run_h4` | `test_m03_h.ml:939` **and** `:951` | `error_start_without_terminate` ×2 | **no** — monitor-only |
| **M03-I2 (member iii)** | `run_i2_zero_octet_member` | `test_m03_i.ml:714` | `error_runt` | **no, deliberately** (BO-4) |

**Three corrections against `RV-0063A-VERDICT` §7, each of which would have
mis-scored this campaign:**

1. **M03-B4, M03-E2, M03-G7 and M03-H4 were missing** from that enumeration.
   Four units, five registrations. A seal that omitted them would have recorded
   four reds as unnamed-unit findings.
2. **M03-N2 was named and does not exist as a unit.** It appears in the plan (17
   times) and in two library files, and registers nothing anywhere in the bench.
   A MUST-STAY-GREEN or REQUIRED cell at a non-existent unit is unscoreable in
   both directions.
3. **M03-B2's and M03-B3's registrations are not "sub-cases"** of a larger unit —
   each row's runner registers exactly one no-output-word expectation, and it is
   the unit's only registration.

**The instrument claim survives all three corrections and is now exact.** Every
one of the nine detects IC-1 by re-checking a pin **the bench itself computed and
handed the monitor**, or by comparing an observed cycle to a number the bench
derived. **Not one of them reads a report against a drain bound.** M03-I2 member
(iii)'s step-6 strobe scan is still the only assertion in this repository that
scans for a report against a boundary derived from SPEC-M03 §6.1's drain
derivation, and that is what the round is for.

### 2.1 The §0.6 correction that rides with the base SHA

`requirements.md` §0.6 at `a12ac8f` rules that C-14.3 **bounds output words and
not strobes**, and that on a frame emitting no word it *"contributes a scan
boundary"* rather than a second rule about the pulse. The boundary member (iii)
scans from is therefore still C-14.3's; **the rule a pulse at or after it
violates is SPEC-M03 §9's pin read against §0.6's ceiling.** The bench's message
was re-cited accordingly in the commit **immediately preceding this one**
(`J-dv_lead-0105`), which is why that sweep had to land before this base SHA and
not between this seal and its campaign. **The seal is frozen against the
post-sweep string**, and §3 of the seal quotes it.

**This also closes the only route by which an IC-1 red could have been
re-litigated after the scorecard was read.** §0.6 answers `WO-0063` §8 question 3
in terms: a report deferred to the ceiling is **non-conformant**, on §9's
authority. IC-1's red at member (iii) is a true positive against a settled rule,
not a tolerance dispute.

---

## 3. Reachability, discharged term by term — both sides

**R-DISC-1 binds your manifest** (`DISP-0001` §4). For IC-1 and for IC-2
separately: name the gate signal that produces the report, quote its **complete**
defining expression from the base file with line numbers, and evaluate **every**
conjunct on the named stimulus at the claimed firing cycle, calling out which
conjuncts are contributed by the **stimulus** rather than by the mutation. Where
a landing condition is modular, write it as arithmetic and show it satisfied at
the value the required consequence names, with the recurrence set **enumerated
rather than assumed unique**.

**Both start lanes are separate evaluations.** At member (iii) the closing
character is in **lane 0** at a lane-0 start and in **lane 4** at a lane-4 start,
and a conjunct satisfiable in one lane is not thereby satisfiable in the other.
Two evaluations, or the lane you did not evaluate is **NOT SEEDED** for scoring
purposes.

**R-DISC-2**: the report path is named by **both** intents, so it gets a
gate-inventory row carrying its full term list and each intent's claim about it,
**before delivery**. Where IC-1 and IC-2 touch the same term, say so — that is a
cross-class gate fact and §5's allowlist requires it tabulated, not discovered.

**And the same standard applies to me, on the bench side, discharged here.** The
convicting predicate at member (iii) is

```
∃ s ∈ samples : s.cycle ≥ boundary ∧ s.errors_high ≠ []
```

with `boundary` = 5 at both lanes. Its terms:

- **(a)** a sample exists at `cycle ≥ 5` — the run drives the schedule plus
  `~drain:8`, and the schedule alone runs to the auto-placed terminate at cycle
  10, giving last sampled cycle **20** and **16** samples at `cycle ≥ 5` at both
  lanes. The runner carries an executable vacuity guard for exactly this, so the
  scanned set is counted rather than assumed.
- **(b)** the strobe is read from the DUT's own outputs at that cycle under the
  `Before` view (`bench.mli`, `[Before]`), so no relabelling stands between the
  pulse and the scan.
- **(c)** every assertion ordered before the scan is evaluated on the mutant and
  is **unmoved**, because IC-1 touches no datapath signal: the no-`tlast` and
  no-`tvalid` structural facts (step 5) hold under IC-1 exactly as at base.
- **(d)** nothing outside the row's own unit is required for the conviction.

**If (c) fails — if the rendering perturbs the datapath — the class is out of
specification for this round and is reported, not scored.** §4 makes that an
executable check rather than a hope.

---

## 4. §4(c) as a test, not as prose — the datapath-perturbation signature

`WO-0063` §4(c) asked for a way to tell a spec-conformant IC-1 rendering from one
that also moves the datapath, and left it as prose. It is now a **measured**
signature and a **structural** discriminator, and both are pre-ship checks rather
than post-hoc arguments.

**The measured signature (`BUG-0003` §V.10.2, `J-dv_lead-0103`, transient tree
`5c47582`).** A datapath perturbation on this module measured, at the one cell
where one was ever measured: **(a)** 7 mid-frame words with `tkeep` ≠ 0xFF and
`tlast` = 0; **(b)** 4 of 60 required octets in their gapless byte positions,
28 delivered as the idle filler `0x07` and **28 never delivered at all** (a
32-octet stream against a required 60); `tlast` on word 7, where it belongs;
`tuser` = 0 — the corrupted frame marked **FCS-good**. That is what "the datapath
moved" looks like on this design when it is measured rather than asserted.

**The auditor's pre-ship check**: before delivering the IC-1 manifest, confirm
your rendering produces **none** of that signature's components on a *delivering*
stimulus. A rendering that produces any of them is not IC-1; it is IC-1 plus a
datapath defect, and the two cannot be scored apart.

**My adjudication check, and why the signature alone is not enough.** On member
(iii) the conformant emitted stream is **empty** — zero words, no `tkeep`, no
octet sequence, no `tlast`. **The signature has no domain there**, and a check
with no domain is a vacuous assertion. What discriminates at that unit is the
landed **ordering**: step 5 (`tlast_sample` / `delivered_samples`) and step 6's
*first* assertion are the datapath-unmoved claims, and both are evaluated
**before** step 6's strobe scan. So if the rendering does move the datapath,
member (iii) raises with a **datapath** message — `a tlast word was observed for
a frame that must deliver nothing (§0.7)`, `a tvalid word was observed for a
frame that must deliver nothing (§0.7)`, or `an output word was emitted at or
after cycle 5, the silence boundary 3 cycles after the closing word (REQ-109,
C-14.3)` — and **not** with the window's own strobe message.

**Consequence, fixed here so it cannot be renegotiated**: §6 disposition 1's
REQUIRED cell is *red with the window's own strobe message*. A red at member
(iii) carrying any of the three datapath messages above scores as **the class out
of specification — reported, not scored**, at both lanes, and no claim about
M03-I2's qualification is made from it in either direction.

---

## 5. The allowlist, and what the manifest must carry

**Allowlist for the campaign's duration** — the auditor reads:

- `libs/hardcaml_ethernet/src/xgmii_rx_64.ml` and its `.mli`, at the base SHA
  (the mutation target);
- `docs/specs/requirements.md` and `docs/specs/modules/xgmii_rx_64.md`;
- **this packet**;
- `docs/reports/audit/**`, its own scope.

**Out of bounds, absolutely, for the campaign's duration**: all of `test/**`, all
of `agents/**` — **this packet excepted, and its sealed companion emphatically
not excepted** — and every journal. The seal names cells, messages and iteration
orders; reading it is reading the answer.

**The manifest must carry**, per R-DISC-1 / R-DISC-2:

1. **Two diffs**, IC-1 and IC-2, minimal and independent — each applies alone to
   the base SHA and reverts cleanly.
2. **A reachability discharge per intent, per lane, term by term at the firing
   cycle**, with the stimulus-contributed conjuncts called out — or a
   **self-declared NOT SEEDED** for any term you cannot discharge. A
   self-declaration made before the run is a disclosure and costs nothing; the
   same fact discovered from a scorecard is a finding.
3. **A gate-inventory row for the report path** with its full term list and both
   intents' claims about it (R-DISC-2), and **cross-class gate facts tabulated** —
   every term IC-1 and IC-2 both touch, named before delivery.
4. **Both disclosures of §1.1**, answered in the manifest's own words.
5. **The §4 pre-ship check result** for IC-1.
6. **The base SHA you applied to**, quoted, and confirmation that it matches §7's.

---

## 6. Pre-committed dispositions — fixed now, so no result can be re-read later

These are `WO-0063` §7 item 3's four, carried forward **unchanged in substance**
and sharpened only where §2's measurement or §4's check made a term concrete.

1. **IC-1 red at member (iii) with the window's own strobe message (both lanes),
   IC-2 green at all three members (both lanes)** → **M03-I2 QUALIFIED**, scoped
   in the verdict to *"the window convicts"* and **never** to *"the window is the
   sole detector"*, with the full convicting set across the suite reported.
2. **IC-1 red at member (iii) but IC-2 also red there** → the red is **blast**;
   **M03-I2 remains UNQUALIFIED** and the packet says so.
3. **IC-1 not reachable at member (iii)** (the escape of §1 taken, or a lane
   undischarged under §3) → the class is **void**: zero kills, no claim about any
   row in either direction. `WO-0061` `SEALED` §5.8(iv)'s rule, applied to my own
   campaign.
4. **IC-1 red at member (iii) but an earlier assertion in that unit raised
   first** → **UNQUALIFIED**, and M03-I2's window is declared **structurally
   shadowed**; the plan disposition then owed is **NO-ASSERT on the shadowed
   half**, not another member.

**And the fifth case, which is new because §4 made it decidable**: **IC-1 red at
member (iii) with one of §4's three datapath messages** → the class is **out of
specification**, reported and not scored, and disposition 3's "no claim in either
direction" governs.

**Disposition 4 has an ordering cell and it is the one that decides
qualification.** Member (iii) is in **both** the standing-monitor set (§2) and
the C-14.3-instrument set — the two detectors redden on the same stimulus and
carry **different messages**. The landed source guarantees which speaks: step 6's
strobe scan raises before step 9's `assert_monitors_clean` ever runs. **The seal
records that message string verbatim as the REQUIRED cell**, so a red arriving
instead through `assert_monitors_clean` scores as **UNQUALIFIED, structurally
shadowed** under disposition 4 and **cannot be re-read as a qualification after
the fact**.

---

## 7. The base SHA, and the adjudicator-ordering rule

**One base SHA for the whole round**, both intents, the control run and every
MUST-STAY-GREEN sweep. `BUG-0003` §V.9's *"one round cannot carry two base SHAs
in its evidence"* governs, and phase A's separate base is why this is a separate
round.

**The base SHA is the commit that this packet's own commit immediately
follows** — i.e. the commit carrying `J-dv_lead-0105`'s citation sweep, which is
the parent of the commit staging this packet and its seal. I cannot state its
hash: I never run git, and the commit does not exist under a hash until the
orchestrator creates it. **The orchestrator verifies that identity at commit
time and records the hash in its own trailer**; the auditor quotes the hash it
applied to (§5 item 6) and any disagreement is a finding before the campaign
runs, not after.

**The adjudicator-ordering rule, stated because it is what makes any of this
evidence.** **The bench must be frozen strictly earlier in history than any
mutant RTL it judges.** Concretely:

- Every `test/**` byte this campaign scores against is at or before the base SHA.
  Phase A's member (iii) landed at `c00771f`; the citation sweep at the base SHA
  itself; **nothing under `test/**` moves again until the campaign scores.**
- The seal is frozen in this packet's own commit, which is **after** the last
  bench edit and **before** the first mutant diff exists.
- If any `test/**` file is edited between this commit and the scorecard, **the
  round is adjudicated as having no valid base** and re-runs from a fresh seal.
  That includes edits by me.

**Why the rule is not ceremony**: a bench edited after a mutant exists can be
tuned to it, and no reader downstream can distinguish a bench that always would
have convicted from one that was taught to. The ordering is the only thing that
makes "the window convicted" a measurement rather than a claim.

---

## 8. Mutant-owned quantities, and how they are sealed

Some quantities in this campaign belong to the **mutant**, not to the
specification: exactly which cycle a deferred pulse lands on depends on the
rendering, and a seal that pins them exactly would score a correct rendering as a
finding. **Every such quantity is sealed as an inequality with a named
direction**, never as a value:

| quantity | sealed as | direction, and why |
|---|---|---|
| the deferred pulse's cycle at member (iii) | `observed ≥ 5` | the report is **later**; IC-1 defers, it does not advance. A value `< 5` is not this class. |
| the deferred pulse's cycle at the eight other no-output-word units | `observed > registered pin` | same direction; the exact value is the rendering's. |
| the count of pulses in member (iii)'s run | `= 1` | **not** mutant-owned — §0.7 and §9 fix it at one, and IC-1 moves *when*, never *how many*. A count ≠ 1 is a finding, not a rendering fact. |
| the strobe's **name** at member (iii) | `= "error_runt"` | not mutant-owned — §9 ruling 9's sub-5 class fixes it. |
| output words at member (iii) | `= 0` | not mutant-owned — §0.7. A nonzero value is §4's out-of-specification case. |

**The rule that makes the table honest**: a quantity is mutant-owned **only** if
the specification does not fix it. Three of the five above are specification-fixed
and are sealed as equalities on purpose; calling them mutant-owned would be
buying an unfalsifiable seal.

---

## 9. What comes back

1. The manifest per §5, both intents.
2. **Both disclosures of §1.1**, in the auditor's own words.
3. The **§4 pre-ship check** result.
4. The **full scorecard**: every unit red or green under each intent, at the base
   SHA, with the **raised message** at every red — the message, not a summary of
   it, because the seal's cells are message-level.
5. The **control run**: the unmutated base SHA green, with its CI run id and
   conclusion. **CI is the authority** (ADR-0005); a claim of "passes locally" is
   not admissible from the auditor, the orchestrator or me.
6. Anything judged rather than followed, and why.

**Adjudication is mine**, against the sealed file, which is opened only after the
scorecard is in hand.

---

## 10. Weighting, discounted in advance

**Member (iii) is the first unit in this programme written with its mutation
class known** (`WO-0063` §2.4). The discount is stated, not hidden: **a kill here
proves the window can convict, not that it is a general detector.** What is *not*
discounted is the stimulus — a strobe-owing member is what M03-I2's own `Kills`
cell has needed since it was written, and the class derives from §9's report
path, not from the bench.

**One further honesty, which cuts against my own round.** Eight of the nine units
in §2's table detect IC-1 already, without member (iii). So **IC-1 is not a class
this bench is blind to**, and no verdict may imply it was. The claim this round
can support is narrower and is the one worth having: **the C-14.3 instrument is
the only one that reads a report against a drain bound, and this round measures
whether it works.** Everything else in §2's table is blast radius with a name.

---

## 11. Not to be told

The sealed companion in its entirety: its matrix, its MUST-STAY-GREEN
denominators, its verbatim message cells, its iteration orders, its UNWORKED
adjudication rules and its disclosure branches.

**Freely told, and told above**: the two intents, the minimality and fidelity
requirements, §1.1's two disclosures, §2's measured convicting set and its three
corrections, §3's reachability standard, §4's signature and its consequence,
§5's allowlist and manifest bars, §6's five dispositions, §7's base SHA and
ordering rule, §8's mutant-owned inequalities, §9's return format and §10's
discount.

---

## Return / verdict log

*(empty — the auditor appends its return here, and dv_lead its verdict.)*

---

## WO-0063B-VERDICT — dv_lead, `J-dv_lead-0108`

**Result**: **IC-1 KILLED. M03-I2 QUALIFIED** — disposition 1, on the sealed cell
hit **character for character** with the window's own message, from the window's
own scan, at the unit the round exists for. **IC-2 behaved as a control must**:
M03-I2 green at all three members and both lanes.

**And the round produced three findings, all of them mine and none of them the
auditor's.** The manifest is accepted without a defect: 9/9 on the predicted set,
both disclosures accurate against the delivered diffs, R-DISC-1/2 discharged per
lane, no scope excess, no datapath perturbation, and one axis of my own question
completed by the respondent rather than by me. The findings are in my **seal's
enumeration** and in my **reading note's taxonomy**, and §6 records them against
my name because that is where they belong.

---

### 0. The measurement this verdict rests on, and the checks that precede it

| run | branch | transient SHA | build | journal-check |
|---|---|---|---|---|
| **IC-2** (control) | `mut/wo-0063b-ic2` | `dbc4b0a` | **30955861141** — red (**the harvest**) | 30955861144 — red, plain-commit noise, known class |
| **IC-1** | `mut/wo-0063b-ic1` | `b82b888` | **30955875363** — red (**the harvest**) | 30955875349 — same noise class |

Both transients are `[c0595f9 + exactly one auditor diff]`, applied from the
committed manifest blobs at `8bbc388`. **A red build IS the measurement here** —
the suite going red is what a killed mutation looks like — and the
`journal-check` reds are the known throwaway-ref class that bears on nothing.

**Three preconditions re-checked by me rather than assumed**, because §7's
ordering rule is not discharged once:

1. **`git diff --name-only c0595f9 HEAD -- test/ libs/` → empty.** Not one byte
   of bench or RTL has moved since the base. The bench that judged these mutants
   is the bench frozen strictly before they existed.
2. **`git diff --stat c0595f9 HEAD -- test/xgmii_rx_64/test_m03_i.ml` → empty.**
   The scoring unit's own file is byte-identical to the base.
3. **The seal is unmoved since its freeze**: `git diff c6c3287 HEAD --
   …-SEALED-predictions.md` → empty. It was opened only after the scorecard
   existed.

---

### 1. IC-1 — the scorecard

**Nine failing units. Nine predicted. Zero outside. Zero predicted-red that
stayed green.**

| unit | predicted (wide branch) | observed | raised message |
|---|---|---|---|
| **M03-I2 (member iii, lane 0)** | **R! scored** | **red** | **§2's sealed cell, verbatim** |
| M03-B2 | r | red | `M03-B2 (lane 0): error_bad_frame pulsed on the wrong cycle` |
| M03-B3 | r | red | `M03-B3: error_runt pulsed on the wrong cycle` |
| M03-B4 | r | red | `M03-B4: error_start_without_terminate pulsed on the wrong cycle` |
| M03-E2 | r | red | `M03-E2 (lane 0): error_bad_frame pulsed on cycle 5, expected 4` |
| M03-E5 | r | red | `M03-E5 (preamble position 1, lane 0): error_bad_frame pulsed on cycle 4, expected 3` |
| M03-F2 | r | red | `M03-F2 (lane 0, 0 octets received): error_runt pulsed on cycle 5, expected 4` |
| M03-G7 | r | red | `M03-G7 (lane 0): the second strobe is not error_runt on the resynchronised frame's own pinned cycle …` |
| M03-H4 | r | red | `M03-H4: the first strobe is not error_start_without_terminate on frame A's own pinned cycle (c + 2)` |

- **MUST-STAY-GREEN (M03): 30 of 30 held.** No unit outside the nine reddened.
- **MUST-STAY-GREEN (non-M03): 80 of 80 held.** Every `File "test/…"` failure
  path in the log is under `test/xgmii_rx_64/`; nothing else in the repository
  moved. The blast-radius argument of the seal's §0 is confirmed by measurement.
- **Kills: 1** — per-class counting. Nine reds are **one** kill, never nine.

#### 1.1 The scored cell, character for character

Raised, decoded from the log's OCaml escaping (`\194\167` = `§`):

```
M03-I2 (member iii, zero octets received, lane 0): a strobe pulsed at or after cycle 5 (REQ-109, §0.6's ceiling and SPEC-M03 §9's pin -- C-14.3 bounds output words, not strobes)
```

**This is the sealed cell of §3.1, character for character**, including the
citation as repaired at the base SHA by `J-dv_lead-0105`. The sweep that had to
land before this base landed, and the seal froze the string it created.

#### 1.2 The ORDERING cell — the window spoke, and the proof is the backtrace

```
Raised at Stdlib.failwith …
Called from …run_i2_zero_octet_member in file "test/xgmii_rx_64/test_m03_i.ml", line 847, characters 4-254
Called from …run_i2 in file "test/xgmii_rx_64/test_m03_i.ml", line 953, characters 2-284
```

- **`:847` is step 6's strobe assertion** — the C-14.3 boundary scan's own `fail`.
- **`:887` is step 9's `assert_monitors_clean`, and it never executed.**
- **`:953` is `run_i2`'s lane-0 call site.**

So the red arrived **with the window's own message, from the window's own scan,
before the standing monitor was ever reached**. Seal §3.2's shadowed branch is
**not** taken; disposition 4 does **not** fire. This is the fact the whole round
was built to establish, and it is established by a backtrace rather than by an
argument.

#### 1.3 Lane 4 — neither hit nor missed, exactly as pre-fixed

Lane 0 raises first (`run_i2` drives it first), so the lane-4 cell is
**structurally unobservable in the same run**. Seal §3.1 fixed this in advance:
*the unit's cell is scored on the lane-0 string; the lane-4 string is scored only
if the scorecard reports it, which requires lane 0 to have been green.* The
auditor discharged R-DISC-1 **per lane** (its §3.2 and §3.3), so the class is
**reachable at lane 4 by term-by-term evaluation** and merely unobserved by the
bench. Recorded as unobserved, never as a miss and never as a pass.

---

### 2. IC-2 — the control

**M03-I2 is GREEN.** `test_m03_i.ml` does not appear in IC-2's failure set at
all: all five units in the file passed, so all three members at both lanes stayed
green. **The REQUIRED consequence of the control held**, and the derivation the
seal gave for it (members (i)/(ii) owe no report; member (iii) has no `tlast`
cycle for a `tlast`-pinned deferral to attach to) is confirmed by measurement.

Eighteen units reddened: M03-C4, D1, **D2**, D3, E1, F1, F3, F4, G1, G2, G3, G4,
G6, G7, G8, H1, H2, H3. Seventeen were predicted. **One was not — M03-D2 — and it
is a MUST-STAY-GREEN violation and a finding against me** (§6.1).

- **MUST-STAY-GREEN (M03): 21 of a sealed 22 held.** One violation.
- **MUST-STAY-GREEN (non-M03): 80 of 80 held.**
- **Kills: 0, by design.** IC-2 is a control and scores none.

---

### 3. The five dispositions

| # | condition | outcome |
|---|---|---|
| **1** | IC-1 red at member (iii) with the window's own message; IC-2 green at all three members | **FIRES — M03-I2 QUALIFIED** |
| 2 | IC-1 red but IC-2 also red at member (iii) | does not fire — IC-2 green (§2) |
| 3 | IC-1 not reachable at member (iii) | does not fire — reachable, discharged per lane |
| 4 | an earlier assertion in that unit raised first | does not fire — the raise is at `:847`, step 9 never ran (§1.2) |
| 5 | red carrying one of the three datapath messages | does not fire — the message is the window's |

**Disposition 1 is scoped exactly as it was written**: *"the window convicts"* —
**never** *"the window is the sole detector"*.

---

### 4. M03-I2 — REQUALIFICATION, signed

**M03-I2 is QUALIFIED**, on one class (IC-1), by its own instrument, with its own
message, ahead of every other detector in its own unit.

**What this qualification means, stated at full strength and no further:**

- **The C-14.3 boundary scan convicts a report-path delay.** It is the only
  assertion in this repository that reads a report against a boundary derived
  from §6.1's drain derivation, and it has now done so.
- **It is not a general detector, and this verdict does not say it is.**
  Member (iii) is the first unit in this programme authored with its mutation
  class known (`WO-0063` §2.4). The discount stands undiminished by the result.
- **Eight of the nine units detected IC-1 without it.** This bench was **not**
  blind to a report-path delay, and no reader may take this qualification as
  evidence that it was.

**The row's Kills cell is now discharged by measurement rather than by claim**,
and M03-I2's own declared kill — *"a real drain defect one cycle long"* — is
reachable on the strobe axis, which is what the round was for.

---

### 5. The corrected instrument tally — sharper than the seal predicted

Seal §5(f) predicted two instrument families at the nine (a pinned-cycle
comparison at six, the standing monitor at nine with three by that route alone).
**The measurement is different and stronger:**

| instrument | units |
|---|---|
| row-local **pinned-cycle comparison** | 6 — M03-B2, B3, B4, E2, E5, F2 |
| row-local **strobe-set / strobe-order** check | 2 — M03-G7, M03-H4 |
| the **C-14.3 boundary scan** | 1 — M03-I2 member (iii) |
| the standing `Strobe_monitor` | **0 — it spoke nowhere** |

**Every conviction in this campaign was row-local, and the standing monitor was
shadowed at every single unit.** My seal called M03-G7 and M03-H4 *"monitor-only"*;
they are not — each has a row-local strobe check that speaks first (§6.2). The
correction **strengthens** the instrument claim rather than weakening it: the
monitor detected nothing anywhere, so the per-row assertions are the whole of this
bench's report-path assurance, and exactly one of them reads against a drain
bound.

---

### 6. Findings — three, all mine

#### 6.1 FINDING WO-0063B-1 (dv_lead) — a MUST-STAY-GREEN violation from an enumeration that assumed one runner serves one unit

**M03-D2 reddened under IC-2 and the seal predicted green.** Cause, exactly: my
classification pass mapped each `Strobe_monitor.expect` registration to its
enclosing runner and then to **one** unit. `run_mixed_pair`
(`test_m03_d.ml:266`) is called from **two** units — M03-D3 **and** M03-D2 — so
its `tlast`-pinned `error_bad_fcs` registration belongs to both. I assigned it to
M03-D3 alone.

**The file says so in its own words, at `test_m03_d.ml:330`**: *"{!run_mixed_pair}
result — shared by M03-D3 (both frames) and M03-D2's …"*. **The datum was in
prose in the file I was classifying, and my pass could not see prose.**

**Scoring**: `WO-0063B` §6 pass criterion 3 is violated, and the violation is
**mine, not the diff's** — it is the first of the two alternatives my own
containment rule names (*"my enumeration was incomplete"*), not the second
(*"the diff reaches further than the class it names"*): M03-D2 genuinely contains
a `tlast`-pinned report, so IC-2 moved exactly what IC-2 says it moves. **Effect
on the verdict: none.** It is under the control class, at a unit that is not
M03-I2, and IC-2 scores no kill. The corrected IC-2 denominator is **18 red / 21
green**.

#### 6.2 FINDING WO-0063B-2 (dv_lead) — "monitor-only" was a mis-classification, and its cause is the rule I banked one round earlier

I classified M03-G7 and M03-H4 as having **no direct pinned-cycle assertion**
because I searched for the message *forms* `"pulsed on the wrong cycle"` and
`"pulsed on cycle"`. Their checks exist and speak first; they simply say
`"the first strobe is not … on frame A's own pinned cycle"` and `"the second
strobe is not … on the resynchronised frame's own pinned cycle"`.

**This is `J-dv_lead-0104`'s own banked rule failing in my hands** — *search by
the defect, never by the string its known instances share* — applied to
**classification** rather than to **search**, one round after I banked it and in
the same artefact that cites it. I had both strings in front of me in the sweep
that produced the seal and classified them wrongly.

**Effect on the verdict: none on any cell** (both units were predicted red and
were red); it corrects §5's instrument tally, which is corrected above.

#### 6.3 FINDING WO-0063B-3 (dv_lead) — my reading note's cycle-vs-count binary was missing a column

`WO-0063B_pre-run-reading-note.md` §2.2 ruled on two presentations: a **cycle**
difference and a **count** difference. **A third appeared**, in three units:

- `M03-F4 (lane 0): frame 1: expected exactly one strobe pulse (error_runt), observed 0`
- `M03-D2 …: frame 2: strobe set is not exactly what its own FCS status implies`
- `M03-D3 pair A …: frame 2: strobe set is not exactly what its own FCS status implies`

These are **windowed attribution** differences: the deferred pulse crossed a
per-frame window boundary, so a frame-scoped check sees the wrong count or the
wrong strobe set. **It is not the disclosed C-23 collision** — nothing collided;
a report moved between frames' windows.

**The disclosed C-23 count-losing shape never fired.** The auditor measured
291 / 20 736 (IC-1) and 261 / 20 736 (IC-2) count-losing stimuli; **not one of
this bench's 39 units drives one**, so my reading-note §2.2 ruling was never
exercised. I record that plainly rather than claiming the ruling "worked".

**And the shape of this finding is the candidate I banked at `J-dv_lead-0107`
firing against me in the very next round**: *a question with n values must state
the dimension it ranges over.* I wrote a two-valued taxonomy for how a red
presents, and reality had a third value. **Effect on the verdict: none** — all
three units are inside IC-2's predicted-red set except M03-D2, which is §6.1.

#### 6.4 What is NOT a finding — the manifest

**The auditor's manifest is accepted with no defect recorded against it.** 9/9 on
the predicted set with no unpredicted red; both mandatory disclosures accurate
against the delivered diffs; R-DISC-1 discharged term-by-term per lane; R-DISC-2's
gate-inventory row delivered; both diffs minimal, independent, revertible, and
touching one file; no datapath perturbation (§3's disposition 5 never engaged);
and the §7.1 count-losing shape disclosed **before** the run when omitting it
would have been costless.

**Two acts deserve to be on the record as more than compliance.** The auditor
found a **second structural axis underneath my own disclosure question** and
deferred both structures rather than answering my question completely and letting
the incompleteness ride — and §7 below shows that had it not, my wide column
would have over-predicted by four units. And it disclosed an ambient exposure
unprompted when nothing would have detected the omission.

---

### 7. The reading note's obligations, discharged

Applying `WO-0063B_pre-run-reading-note.md`, cited by name as its §4 requires.

#### 7.1 §4 item 1 — the structure split across the nine

Derived from each unit's own stimulus geometry and confirmed by the observed pin
arithmetic (start word = cycle 1; a pin at 3 means the closing word **is** the
start word; a pin at 4 means it is the next word):

| structure | units |
|---|---|
| **in-word `q2`** (frame opened *and* closed in one input word) | M03-B2, **M03-B3**, M03-B4, **M03-E5** — 4 |
| **epoch-A aged record** | **M03-I2 (member iii)**, M03-E2, M03-F2, M03-G7 — 4 |
| **both** (two frames, one of each) | M03-H4 — 1 |

Confirming evidence in the messages: `M03-E5 (preamble position 1, lane 0):
error_bad_frame pulsed on cycle 4, expected 3` — pin 3, so the closing word is
the start word, so **in-word**. `M03-E2 (lane 0): … pulsed on cycle 5, expected
4` — pin 4, closing word 2, so **aged**. Member (iii) is aged, exactly as the
auditor derived independently at its §3.0 without opening a bench file.

**Reading note §1.3 is VINDICATED by measurement, and it is the round's most
consequential counterfactual.** Four of the nine — M03-B2, B3, B4, E5 — redden
**only** because IC-1's hunk 1 defers the `q2` path. **Had the auditor delivered
hunk 2 alone, those four would have stayed green and my sealed wide column would
have OVER-predicted by four units**, scoring four true greens as findings against
the auditor. The completeness the auditor volunteered is what made 9/9 possible.

#### 7.2 §4 item 2 — cycle versus count, for every red

| presentation | IC-1 | IC-2 |
|---|---|---|
| **cycle** difference | 9 (all) | 15 |
| **windowed attribution** (the third class, §6.3) | 0 | 3 — M03-F4, D2, D3 |
| **C-23 collision count-loss** (the disclosed shape) | **0** | **0** |

#### 7.3 §4 item 3 — the re-checked `test/**` diff

`git diff --name-only c0595f9 HEAD -- test/ libs/` → **empty**, re-run by me at
adjudication time. The round has a valid base and the scorecard is admissible.

#### 7.4 §3.1 — not exercised

Both diffs built and elaborated; the uncompilable-diff rule was never reached.

---

### 8. Campaign verdict, per class

| class | seeded | outcome | kills |
|---|---|---|---|
| **IC-1** | yes, as specified, both structures | **KILLED** — 9/9 predicted units red, 0 unpredicted, 30/30 + 80/80 MUST-STAY-GREEN held | **1** |
| **IC-2** (control) | yes, as specified | **behaved as required** — M03-I2 green at all three members, both lanes | **0, by design** |

**One scoreable class, one kill: 1/1.** The control did its job — and it did it in
the only way a control can prove anything, by being green exactly where the
qualification needed it green.

---

### 9. What is commissioned, and what is deliberately not

**Commissioned, in this order:**

1. **`test/attack_plans/AP-xgmii_rx_64.md`, one round, five items** — held back
   from every prior commit of this round because the plan is phase B's contract
   and moving it would have violated §7's ordering rule. **The campaign has
   scored; the window is closed; this is that round.**
   1. **M03-I2 → QUALIFIED**, citing this verdict; the qualified-row count moves
      **41 → 42** on this signature and on nothing else.
   2. §4.I **item 6's change-log row** recording that its open question closed at
      `a12ac8f`, and its *"reads a report against C-14.3's bound"* phrasing
      brought into line with §0.6's ruling.
   3. **M03-B4, M03-E2, M03-G7 and M03-H4 carry no-output-word pins** — the
      plan's own record of §2's measurement, so the next campaign does not
      re-derive it from memory.
   4. **§6.3 item 8's M03-N2** — the plan should record that the row for that
      class **has no unit in this bench**, which is why the class is untested.
   5. **M03-D2 shares `run_mixed_pair` with M03-D3** (§6.1), so a future
      classification cannot repeat the one-runner-one-unit assumption.
2. **A short standing note in `tools/dv_checks.sh`'s inventory report, or beside
   it**: the runner → unit relation is **many-to-many**, and any per-unit
   classification must be built from **call sites**, not from enclosing
   definitions. This is §6.1's root cause made mechanical instead of remembered.

**Not commissioned, and named so the omission is visible:**

- **No bench change.** Nothing in `test/**` is owed by this result: member (iii)
  did exactly what it was built to do, and a qualified instrument needs no
  repair.
- **`run_i2_member`'s deliberate citation exception** stays, still without a
  carrier — repairable only when `WO-0061`'s seal is superseded or retired.
- **No `SO-xgmii_rx_64.md`.** This round qualifies one row; it does not discharge
  a module sign-off, and offering one here would be the fan-out error in the
  direction that flatters.

---

**Files this verdict stages**: this packet. Journal entry `J-dv_lead-0108`.
**The seal was not edited, and was opened only after the scorecard existed.**
