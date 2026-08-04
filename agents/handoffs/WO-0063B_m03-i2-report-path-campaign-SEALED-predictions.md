# WO-0063B SEALED: dv_lead's frozen predictions for the M03-I2 report-path-delay campaign

> **SEALED.** The auditor must not open this file until both diffs are delivered
> and the scorecard is in hand — and under `WO-0063B` §5's allowlist, **all of
> `agents/**` is out of bounds for the campaign's duration**, this file included
> and absolutely.

- **State**: **FROZEN — unopened.**
- **Frozen against**: **the commit this file's own commit immediately follows** —
  the commit carrying `J-dv_lead-0105`'s citation sweep, which is the parent of
  the commit staging this seal and its packet. I cannot state its hash: I never
  run git (PROTOCOL §2), and it has none until the orchestrator creates it. **The
  orchestrator verifies that identity at commit time**; the auditor quotes the
  hash it applied to (`WO-0063B` §5 item 6), and any disagreement is a finding
  **before** the campaign runs.
- **Frozen by**: dv_lead, `J-dv_lead-0106`, **before any diff existed**, in the
  commit that stages this file beside its packet — R-SEAL-1 (PROTOCOL §10,
  ADR-0016), redeeming `WO-0063` §6's forward commitment, which by its own terms
  falls due **here or the round has no seal**.
- **Second copy**: the class → REQUIRED-red **row mapping** (not the message
  strings) is restated in `J-dv_lead-0106`.
- **Standing rule of this file, from `RV-0055` FINDING G-1**: **every sealed cell
  that rests on a claim about the DUT's state cites the stimulus fact that
  establishes that state, or is marked UNWORKED.** Every state claim below
  carries its arithmetic or its guard, by file and line at the base SHA.
- **Second standing rule, this file's own**: every message below is the **first
  assertion to speak**, derived from the row's committed control flow and
  iteration order — never from what the row is "about". §1 states the orders the
  messages depend on.
- **Third standing rule, new this round and the reason §3 is short**: a quantity
  the specification does not fix is sealed as an **inequality with a named
  direction**, never as a value. A seal that pins a rendering's own arithmetic
  scores a correct rendering as a finding.

---

## 0. The denominator, re-measured at the freeze

`bash tools/dv_checks.sh` at this tree — the same `grep 'let%expect_test'`
inventory the tool reports:

```
    3  test/xgmii_rx_64/test_m03_a.ml     4  test/xgmii_rx_64/test_m03_b.ml
    4  test/xgmii_rx_64/test_m03_c.ml     3  test/xgmii_rx_64/test_m03_d.ml
    4  test/xgmii_rx_64/test_m03_e.ml     4  test/xgmii_rx_64/test_m03_f.ml
    7  test/xgmii_rx_64/test_m03_g.ml     4  test/xgmii_rx_64/test_m03_h.ml
    5  test/xgmii_rx_64/test_m03_i.ml     1  test/xgmii_rx_64/test_m03_structural.ml
  ---
   39  test/xgmii_rx_64/ (the M03 bench)
  119  test/ (repository-wide)
```

**39 M03 units; 119 repository-wide; 80 non-M03.** The repo-wide figure moved
from `WO-0061`'s 116 by exactly the three units family B added at `WO-0062`, so
the **non-M03 set is the same 80** four prior campaigns measured.

**Blast radius.** Only `test/xgmii_rx_64/dune` declares `hardcaml_ethernet` among
the bench libraries containing `%expect_test`s that reach M03; `test/monitors`,
`test/xgmii`, `test/golden`, `test/axi64_probe` and `test/xgmii_probe` are
DUT-independent by their own dune stanzas, and `test/cosim/**` contains no
`%expect_test` at all. **A unit outside the 39 reddening is a build-level
finding, never a behavioural one.**

---

## 1. The one iteration order every REQUIRED cell depends on

`run_i2` (`test_m03_i.ml:890`) drives six simulations in this order:

1. `run_i2_member ~member:"member i, 64 octets" ~lane:0` (`:901`)
2. `run_i2_member ~member:"member i, 64 octets" ~lane:4` (`:909`)
3. `run_i2_member ~member:"member ii, 69 octets" ~lane:0` (`:926`)
4. `run_i2_member ~member:"member ii, 69 octets" ~lane:4` (`:934`)
5. **`run_i2_zero_octet_member ~lane:0`** (`:953`)
6. **`run_i2_zero_octet_member ~lane:4`** (`:964`)

**Member (iii) runs LAST, and lane 0 before lane 4.** So under IC-1 the unit's
**first** raise is at **step 5**, lane 0 — members (i) and (ii) are clean frames
that owe no report and cannot move under either intent. **Lane 4's cell is
therefore shadowed by lane 0's within the same unit**, and §5 fixes how that is
adjudicated rather than leaving it to be discovered.

**The nine steps inside `run_i2_zero_octet_member`**, in source order at the base
SHA, because the REQUIRED cell is an ordering claim: 1 construction (`:663`) →
2 landing site 1 (`:698`) / registration (`:714`) / landing site 2 (`:734`) →
3 derivation guards + the anti-trap guard (`:762`) → 4 vacuity guard →
**5 no output word at all (`:801`)** → **6 the boundary scan: `tvalid` half,
then strobe half (`:845`)** → 7 anti-vacuity on the pulse → 8 conservation →
**9 `assert_monitors_clean` (`:887`), last**.

**The eight numbers, at both lanes, identical** (verified green at `c00771f`, CI
run `30949738685`): `start_ot` 8 / 12; closing `/T/` octet time 16 / 20; closing
word **W = cycle 2 at both lanes**; §9's pin **4**; §0.6's window **[2, 5]**;
**boundary = W + 3 = 5**; margin **1 cycle**; output words **0**. Last sampled
cycle **20**; samples at `cycle ≥ 5`: **16**. Conformant observed pulse:
`(cycle 4, error_runt)` at both lanes.

---

## 2. The matrix

`R` = REQUIRED red. `G` = MUST STAY GREEN. `R!` = REQUIRED red **and scored** —
the cell the campaign turns on. `r` = predicted red, **UNWORKED**, contributing
**zero** kills (§5's adjudication rule governs). Anything off-pattern is a
**finding**.

| unit | IC-1 (narrow: `/T/` only) | IC-1 (wide: all closures) *fn* | IC-2 |
|---|---|---|---|
| **M03-I2** (member iii, both lanes) | **R!** | **R!** | **G** |
| M03-F2 | **r** | **r** | G |
| M03-B3 | **r** | **r** | G |
| M03-G7 | **r** | **r** | **r** *(it also registers a `tlast`-pinned `error_oversize`)* |
| M03-B2 | G | **r** | G |
| M03-B4 | G | **r** | G |
| M03-E2 | G | **r** | G |
| M03-E5 | G | **r** | G |
| M03-H4 | G | **r** | G |
| M03-C4, M03-D1, M03-D3, M03-E1, M03-F1, M03-F3, M03-F4, M03-G1, M03-G2, M03-G3, M03-G4, M03-G6, M03-G8, M03-H1, M03-H2, M03-H3 | G | G | **r** |
| every other M03 unit (14: family A ×3, M03-C1/C2, C3, C5, M03-D2, M03-E4, M03-I1, M03-I3, M03-I4, M03-I6, M03-ST, M03-B1) | **G** | **G** | **G** |
| **REQUIRED-red count (M03)** | **4** | **9** | **17** |
| **MUST-STAY-GREEN (M03)** | **35** | **30** | **22** |
| **non-MUST-STAY-GREEN by class** | **80** | **80** | **80** |

**The narrow / wide branch is `WO-0063B` §1.1's mandatory disclosure**, and the
seal branches on it rather than hiding the dependence. **The scored cell is the
same on both branches**: `M03-I2` member (iii). Everything else is blast radius
with a name.

**Why M03-G7 is red under BOTH intents.** `run_g7` registers **two**
expectations: an `error_oversize` pinned to a `tlast` cycle (`test_m03_g.ml:1363`)
and an `error_runt` on the no-output-word pin (`:1375`, the resynchronised sub-5
frame). It is the only unit in the bench in both sets, and its double red is
predicted here so it is not read as a cross-contamination finding.

**Why the sixteen `tlast`-registering units are `r` under IC-2 and not `R`.**
IC-2 is a **control**, not a class this round scores. Its only REQUIRED cell is a
**green** at M03-I2. Its reds elsewhere are expected and carry zero kills; a
green where this table says `r` is a **coverage finding** adjudicated per row,
not a failure of this campaign.

---

## 3. The REQUIRED cells, verbatim

### 3.1 IC-1 — the scored cells, both lanes, character for character

Quoted in a block because the exactness is character-level and the text contains
its own punctuation:

```
M03-I2 (member iii, zero octets received, lane 0): a strobe pulsed at or after cycle 5 (REQ-109, §0.6's ceiling and SPEC-M03 §9's pin -- C-14.3 bounds output words, not strobes)

M03-I2 (member iii, zero octets received, lane 4): a strobe pulsed at or after cycle 5 (REQ-109, §0.6's ceiling and SPEC-M03 §9's pin -- C-14.3 bounds output words, not strobes)
```

**Every character is exact and none of it is mutant-owned.** `5` is the boundary,
guarded against this bench's own derivation at `:762` and identical at both
lanes; the row prefix is composed at `:647–:650`; the parenthetical is
the citation as **repaired at the base SHA** by `J-dv_lead-0105` — the sweep that
had to land before this seal, and did.

**`M03-I2` raises at lane 0 first (§1), so under IC-1 the unit's observed message
is the lane-0 string.** The lane-4 string is sealed as the cell the unit *would*
raise were lane 0 removed, and is **not** independently observable in the same
run. **Adjudication, fixed here**: the unit's cell is scored on the **lane-0**
string; the lane-4 string is scored **only** if the scorecard reports it (which
requires lane 0 to have been green, itself a finding).

### 3.2 The ORDERING cell — the whole qualification turns on this

Member (iii) is in **both** convicting sets: the standing `Strobe_monitor`
registration (`:714`, an obligation-4 artefact) **and** the C-14.3-boundary scan
(step 6). They redden on the same stimulus and carry **different messages**. The
landed source guarantees which speaks: **step 6 (`:845`) raises before step 9
(`:887`) is ever reached.**

**REQUIRED**: the red arrives with §3.1's string.

**If instead it arrives through `assert_monitors_clean`** — a message of the form
`M03-I2 (member iii, zero octets received, lane 0): strobe monitor unclean:`
followed by the monitor's report — then step 6 did **not** speak first, the
window was shadowed by a monitor it was supposed to precede, and the cell scores
**UNQUALIFIED, structurally shadowed** under `WO-0063B` §6 disposition 4. **It
may not be re-read as a qualification after the fact**, and that is why the
string is frozen here rather than argued later.

**If it arrives with a datapath message** — `a tlast word was observed for a
frame that must deliver nothing (§0.7)`, `a tvalid word was observed for a frame
that must deliver nothing (§0.7)`, or `an output word was emitted at or after
cycle 5, the silence boundary 3 cycles after the closing word (REQ-109,
C-14.3)` — then the rendering perturbed the datapath, the class is **out of
specification**, and it is **reported, not scored** (`WO-0063B` §4 and §6's fifth
case). No claim about M03-I2 is made in either direction.

**If it arrives with `expected error_runt, observed <name>` or with step 7's
count message**, the class moved *which* or *how many* rather than *when*: not
IC-1, a finding, unscored.

### 3.3 IC-2 — the REQUIRED green, and it is the control's whole point

**M03-I2 stays GREEN at all three members and both lanes — six simulations, zero
raises.** The stimulus facts that make it a derivation rather than a hope:

- members (i) and (ii) are **clean frames**; `run_i2_member` asserts
  `error_pulses samples` is **empty** and registers **no** expected event, so a
  defect on the `tlast`-pinned report path has no report at those members to
  move;
- member (iii) delivers **zero output words** (§0.7) and therefore has **no
  `tlast` cycle at all** — `tlast_sample samples` is `None`, asserted at step 5.
  A deferral pinned to a `tlast` cycle has nothing to attach to.

**A red at M03-I2 under IC-2 is disposition 2**: the IC-1 red is blast radius and
**M03-I2 remains UNQUALIFIED**. That is the seal's own trap for its own author,
and it is the reason IC-2 exists.

### 3.4 The eight other IC-1 units — UNWORKED on purpose, with the rule fixed in advance

Each of M03-B2, M03-B3, M03-B4, M03-E2, M03-E5, M03-F2, M03-G7 and M03-H4 has its
own assertion order and its own message idiom, and six of the eight carry a
**direct** pinned-cycle assertion that will raise before their monitor does
(`test_m03_b.ml:802` / `:620` / `:421`, `test_m03_e.ml:463` / `:776`,
`test_m03_f.ml:472`); M03-G7 and M03-H4 are **monitor-only**. Eight worked
derivations bought with an afternoon would be eight chances to make G-1's error
again.

**Adjudication rule, fixed here**: at those eight units a **red is predicted
blast radius, contributes zero additional kills, and is not an unnamed-unit
finding**; a **green is a FINDING** — it would mean a unit that registers a
no-output-word expectation and cannot see that report move, which is a coverage
fact worth having and is adjudicated per row rather than scored against this
class. **Kills are counted per class**: IC-1's nine predicted reds are **one**
possible kill, never nine.

---

## 4. Mutant-owned quantities — inequalities with named directions

| quantity | sealed | direction |
|---|---|---|
| the deferred pulse's cycle at member (iii) | `observed ≥ 5` | **later**. IC-1 defers; a value `< 5` is not this class and is a finding. |
| the deferred pulse's cycle at the other eight | `observed > registered pin` | **later**, same reason; exact values are the rendering's and are recorded as rendering facts. |
| pulses in member (iii)'s run | **`= 1`** | **not mutant-owned** — §0.7 and §9 ruling 9 fix it. IC-1 moves *when*, never *how many*. |
| the strobe's name at member (iii) | **`= "error_runt"`** | **not mutant-owned** — §9 ruling 9's sub-5 class. |
| output words at member (iii) | **`= 0`** | **not mutant-owned** — §0.7. Nonzero is §3.2's out-of-specification case. |
| units reddening under IC-1 | `⊆` §2's wide column | a red **outside** that set is a finding: either my enumeration was incomplete or the diff reaches further than the class it names. |

---

## 5. Reasoning for the cells that are not obvious

**(a) Why the fourteen "every other M03 unit" cells are GREEN under both intents,
derived from the registration inventory rather than from a category.** All 28
`Strobe_monitor.expect` sites in the bench were enumerated and classified by their
own `cycle` field and `why` text. A unit that registers **nothing** cannot lose an
expected event and cannot gain an unclaimed high cycle from a report that merely
**moves** — `is_clean` compares expectations to observations, and both sides are
empty. And a unit whose rows assert `error_pulses samples` is empty is asserting
an **absence over the whole run**, which a one-cycle deferral of a report that
does not exist cannot disturb. The fourteen are exactly the units with no
registration and no report.

**(b) The one near-miss, named rather than left to surface.** `M03-I1`,
`M03-I3`, `M03-I4` and `M03-I6` all scan idle windows for spurious activity and
all assert `error_pulses` empty. None of them opens a frame that reports, so
neither intent has a report to defer there. **They are green on a stimulus fact,
not on a category**, and that is the distinction `RV-0055` FINDING G-1 exists to
enforce.

**(c) IC-1 and IC-2 collide at exactly one unit and the seal says so before the
result.** M03-G7 registers one of each (§2). **If IC-1 and IC-2 produce the same
message at M03-G7, the campaign has measured one defect twice** and the scorecard
records one detection, not two — the rule `WO-0061` §4(b) fixed and this round
inherits.

**(d) The `%expect` blocks do not move and no cell is scored on one.** M03-I2's
`[%expect {||}]` is empty by construction — member (iii) asserts, it does not
print. A raise anywhere in `run_i2` leaves that block untouched, so unlike
M03-I4's this unit's diff is silent. **The raised message alone scores the cell.**

**(e) The stimulus guards cannot fire under either intent, and their silence is
not coverage.** `Injection.is_clean`, the landing checks at both sites, the eight
derivation guards, the anti-trap guard and the vacuity guard are all evaluated on
the **bench's own model** of the stimulus, before or independently of the DUT.
**No RTL mutation can move them.** A `test bug --` message appearing in this
campaign means something other than the seeded defect and is a finding of its own
kind.

**(f) The idiom correlation, stated because the scorecard must state it.** IC-1 is
caught at nine units by exactly **two** instrument families: a **pinned-cycle
comparison** the bench itself computed (six units), and the **standing strobe
monitor's exact `(strobe, cycle)` match** (nine units, three of them by that route
alone). **One instrument family, at one unit, reads the report against a drain
bound** — member (iii)'s step-6 strobe scan. So this campaign probes **three**
instrument families at one stimulus geometry, and the scorecard reports it that
way rather than as nine independent measurements.

---

## 6. §4(c) as this seal's own check

`WO-0063` §4(c) — *"every assertion ordered before the scan is unmoved, because
IC-1 touches no datapath signal"* — is discharged **structurally** rather than by
a new assertion, and the seal records why so it is not rediscovered.

**The measured datapath-perturbation signature** (`BUG-0003` §V.10.2,
`J-dv_lead-0103`, transient tree `5c47582`) is: 7 mid-frame words with
`tkeep` ≠ 0xFF and `tlast` = 0; 4 of 60 required octets in their gapless byte
positions, 28 delivered as `0x07` filler and 28 never delivered; `tlast` on word
7; `tuser` = 0 on a corrupted frame. **That signature is the auditor's pre-ship
check** (`WO-0063B` §4) and it is **not** evaluable at member (iii), whose
conformant emitted stream is empty — a check with no domain is a vacuous
assertion.

**What discriminates at member (iii) is the landed ordering, and it is already
executable**: step 5 and step 6's *first* assertion are the datapath-unmoved
claims, both evaluated **before** step 6's strobe scan. So a rendering that moves
the datapath raises with a **datapath** message and never reaches §3.1's string.
**A rendering that perturbs the datapath is out of specification for this round:
reported, not scored** — in both my adjudication and the auditor's own pre-ship
check, which is why the two agree by construction rather than by negotiation.

---

## 7. The adjudicator-ordering rule, sealed

**The bench is frozen strictly earlier in history than any mutant RTL it judges.**
Member (iii) landed at `c00771f`; its citation was repaired at the base SHA
itself; **this seal is frozen in the commit immediately after, before any mutant
diff exists.** If any `test/**` file is edited between this commit and the
scorecard — **including by me** — the round has no valid base and re-runs from a
fresh seal.

**Why this is sealed rather than merely stated in the packet**: a bench edited
after a mutant exists can be tuned to it, and nothing downstream can distinguish
a bench that always would have convicted from one that was taught to. The
ordering is what makes "the window convicted" a measurement.

---

## 8. Bounds this campaign does NOT close, named before the result

1. **M03-I2 is qualified by exactly one class.** If IC-1 survives, or lands
   outside §3.1's string, the row ends this campaign **unqualified** and no
   packet may say otherwise.
2. **A kill proves the window can convict, never that it is a general detector**
   (`WO-0063` §2.4's discount, undiminished by any result).
3. **The `tvalid` half of M03-I2's window stays structurally shadowed** and this
   round does not test it: `run_i2_member` asserts each output word's cycle
   before it scans the silent tail, so a drain defect always raises at the
   per-word guard. Only the **strobe** half is reachable, and only at member
   (iii).
4. **Eight of the nine IC-1 units detect the class already.** This campaign
   therefore cannot claim the bench was blind to a report-path delay — only that
   the drain-bound instrument works or does not.
5. **IC-2 is a control and scores no kill in its own right.** Its green at
   M03-I2 is a precondition of disposition 1, not a measurement of anything.
6. **Lane 4's cell at member (iii) is shadowed by lane 0's** within the same unit
   (§1) and is not independently observed in a passing-to-failing run.
7. **The narrow branch leaves five of the nine units unexercised** (M03-B2, B4,
   E2, E5, H4), so a narrow disclosure buys a smaller measurement — correctly,
   and the seal prices it rather than hiding it.

---

## 9. Pass criteria

1. **The suite goes red on IC-1** at M03-I2 member (iii), lane 0, **with §3.1's
   verbatim string**. The `NOT SEEDED AS SPECIFIED` escape of `WO-0063B` §1 is a
   disclosure made before running, not a green result.
2. **The suite stays green on IC-2 at M03-I2**, all three members, both lanes.
3. **No MUST-STAY-GREEN unit reddens** under either intent, and no unit outside
   §2's predicted sets reddens. Either half violated is a **finding** — except at
   the cells §3.4 marks UNWORKED, where its rule governs instead.
4. **The unmutated control is green at the base SHA**, with its CI run id and
   conclusion quoted. **CI is the authority** (ADR-0005).
5. **Kills are counted per class**: IC-1's nine predicted reds are **one**
   possible kill; IC-2 scores none by design.

---

## 10. Not to be told

§1's iteration orders, §2's matrix — above all its MUST-STAY-GREEN columns —
§3's verbatim cells and the ordering ruling that decides qualification, §4's
inequality table, §5's reasoning (especially (a)'s registration inventory and
(c)'s collision datum), §6's discrimination argument, §8's bounds.

**Freely told, and told in `WO-0063B`**: the two intents, §1.1's two mandatory
disclosures, the measured convicting set and its three corrections, the
reachability standard, the datapath signature and its consequence, the allowlist
and manifest bars, the five dispositions, the base SHA and the ordering rule, the
mutant-owned inequality principle, the return format and the discount.
