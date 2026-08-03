# WO-0041 SEALED: dv_lead's frozen predictions for the family-D mutation campaign

> **SEALED. The auditor must not open this file until all five diffs are
> committed**, and the orchestrator must not relay any part of it before then.
> See `WO-0041_family-d-mutation-campaign.md` §0.

- **State**: **UNSEALED 2026-08-10**, results in. Scored at
  `RV-0041-VERDICT` in the companion packet, `J-dv_lead-0044`: **4 of 4
  killable mutations killed with the predicted message in every case; D-M3
  ruled an EQUIVALENT MUTANT and excluded from the denominator; one
  prediction of mine — T-D2 and T-D3 under D-M3 — FALSIFIED.** **This state
  line is the only line of this file altered since the freeze**; `git diff`
  against the freeze commit is the check. The falsified row in §2's matrix
  stands exactly as frozen — a freeze edited after its result is worthless.
- **Frozen against**: bench SHA **`447d11c`**, fully green (run 30786987392)
- **Frozen by**: dv_lead, `J-dv_lead-0041`, **before any mutation diff existed**
- **Second independent copy**: `J-dv_lead-0041`. Two append-only copies mean
  that if either is edited to fit a result, the other exposes it.

## 0. A count correction that had to happen before anything could be frozen

**The M03 bench has TWELVE `%expect_test` units, not eighteen.** The
"fifteen"/"eighteen" figures that have circulated through four packets — and
which I repeated myself in `RV-0040-VERDICT` §7 — correspond to neither
measurable quantity: `test/xgmii_rx_64/` holds **12** (nine before family D),
and the repository holds **92**. I do not know what CI's "fifteen" counts and I
am not going to guess; what I can measure, I have.

Nothing previously ruled is invalidated. `WO-0039`'s sealed table enumerated
"the nine test units CI reports" and **nine is exactly right** for the M03 bench
before family D; every one of the nine was accounted for in that campaign's
scoring. What drifted was a label, not an adjudication. But an *exhaustive*
enumeration is impossible against a wrong denominator, so the correction comes
first.

**Blast radius, checked rather than assumed.** `grep -rln Xgmii_rx_64 test/`
returns nothing outside `test/xgmii_rx_64/` except prose mentions in
`test/monitors/protocol_monitor.{ml,mli}` and `test/monitors/{octet_time.mli,
test_octet_time.ml}` — comments citing SPEC-M03, not instantiations. **No test
outside the bench directory instantiates M03.** `test/monitors/dune`,
`test/axi64_probe/dune` and `test/hardcaml_ethernet/dune` do depend on
`hardcaml_ethernet`, so a mutation that fails to *compile* would redden them —
but a compile failure is repaired-and-disclosed under §1 bar 10, so a
**behavioural** mutation's reach is exactly the twelve units below. **Any unit
outside `test/xgmii_rx_64/` reddening is a build-level finding, never a
behavioural one.**

## 1. The twelve units

| id | file | `%expect_test` |
|---|---|---|
| **T-A12** | `test_m03_a.ml` | `M03-A1, M03-A2: 64-octet frame at both start lanes …` |
| **T-A34** | `test_m03_a.ml` | `M03-A3: directed lengths 64..71 equal as tuple sequences …; M03-A4 …` |
| **T-A5** | `test_m03_a.ml` | `M03-A5: position-dependent filler pins byte order and lane placement` |
| **T-B1** | `test_m03_b.ml` | `M03-B1: nonstandard preamble filler and SFD octets, both start lanes` |
| **T-C12** | `test_m03_c.ml` | `M03-C1, M03-C2: directed lengths 64..71 at both lanes …` |
| **T-C3** | `test_m03_c.ml` | `M03-C3: one 1518-octet frame, both lanes — 1514 octets in 190 words` |
| **T-C4** | `test_m03_c.ml` | `M03-C4: the 5-octet runt is a legal one-word frame (C-11)` |
| **T-C5** | `test_m03_c.ml` | `M03-C5: 1513 and 1516-octet frames at both lanes — the P-1 probe` |
| **T-ST** | `test_m03_structural.ml` | `WO-0038 scaffolding: Xgmii_rx_64 elaborates and runs idle cycles` |
| **T-D1** | `test_m03_d.ml` | `M03-D1: 64-octet frame, one payload bit flipped post-FCS …` |
| **T-D2** | `test_m03_d.ml` | `M03-D2: good-FCS frames stay clean …` |
| **T-D3** | `test_m03_d.ml` | `M03-D3: two 64-octet frames at the minimum gap, both orderings …` |

## 2. The full matrix — every mutation against every unit

`R` = REQUIRED red. `G` = MUST STAY GREEN. Anything off-pattern is a **finding**.

| unit | D-M1 | D-M2 | D-M3 | D-M4 | D-M5 |
|---|---|---|---|---|---|
| T-A12 | G | **R** | G | G | G |
| T-A34 | G | **R** | G | G | G |
| T-A5 | G | **R** | G | G | G |
| T-B1 | G | **R** | G | G | G |
| T-C12 | G | **R** | G | G | G |
| T-C3 | G | **R** | G | G | G |
| T-C4 | G | **R** | G | G | G |
| T-C5 | G | **R** | G | G | G |
| T-ST | G | G | G | G | G |
| **T-D1** | **R** | **G** | G | **R** | **R** |
| **T-D2** | G | **R** | **R** | G | G |
| **T-D3** | **R** | **R** | **R** | **R** | **R** |
| red count | 2 | 10 | 2 | 2 | 2 |

## 3. Expected messages — where the discrimination actually lives

**Three of the five mutations (D-M1, D-M4, D-M5) have the identical row set
{T-D1, T-D3}.** They are told apart *only* by which assertion speaks. That is
the campaign's real content, and it is why pass criterion 2's message clause is
doing nearly all the work here.

| | first failing assertion in T-D1 | expected message fragment |
|---|---|---|
| **D-M1** | the `tuser` check (cycle check passes first) | `tuser[0] is not set on a bad-FCS frame (REQ-104)` |
| **D-M4** | the `error_pulses` cycle comparison | `error_bad_fcs pulsed on cycle 10, expected 11` |
| **D-M5** | the `error_pulses` arity match | `expected exactly one strobe pulse (error_bad_fcs only), observed 0` |

In **T-D3** the same three separate the same way, through `assert_frame`:
D-M1 on `tuser[0] does not match its own FCS status`, D-M4 and D-M5 on
`strobe set is not exactly what its own FCS status implies`. D-M4 and D-M5 are
**not** distinguished by T-D3's message — T-D1 is what separates them, which is
worth knowing.

**D-M2**: T-A12 speaks first with A1/A2's existing
`tuser[0] set — FCS verdict bad (this is the C-18 kill at lane 4)` — fired at
**lane 0**, since `run_a1_a2 ~lane:0` runs first, so the message's "at lane 4"
is misleading-but-correct-as-written and is **not** a finding. T-C12 dumps a
16-line table with **all sixteen FAIL**, each showing `tuser=1` and
`error_pulses=1`. T-A34 speaks through the **monitor** (`assert_monitors_clean`),
not through A3's tuple comparison, because both lanes acquire `tuser`=1
identically and the sequences stay equal. T-C4 speaks
`expected exactly one strobe pulse (error_runt only), observed 2`.

**D-M3**: both T-D2 and T-D3 speak on the **good** frame of the
good-then-bad pair, through the `tuser` check —
`tuser[0] does not match its own FCS status` — because the register has been
re-seeded by the following frame's `Preamble` and the seed differs from
REQ-304's residue.

## 4. The reasoning behind the non-obvious cells

**T-C4 stays green under D-M1, D-M4 and D-M5.** Its 5-octet frame is built by
`with_fcs`, so its FCS is *correct*; no `error_bad_fcs` is expected and none of
these three moves one. Its `tuser`[0] = 1 comes from REQ-107's runt path, which
§2's precision explicitly puts out of scope.

**T-D1 stays GREEN under D-M2, and that is the whole reason M03-D2 exists.**
A design that marks every frame invalid gives D1 exactly what D1 asserts —
`tuser`[0] = 1 and one `error_bad_fcs` on the pinned cycle. D1 cannot see D-M2.
The attack plan said so when it wrote D2's Kills column as "the anti-vacuity
partner of M03-D1, without which D1 passes against a design that always asserts
the bit", and this cell is that sentence made checkable.

**T-D2 reddens under D-M3, which `WO-0040` §9's published table does not say.**
That table names D-M3's kill as M03-D3. It is **incomplete, not wrong**: M03-D2's
fault-isolation calls drive the same mixed pair through `run_mixed_pair`, so the
register-read defect surfaces there too. Recorded here because an adjudication
that scored T-D2 as an "unnamed unit reddening" would be scoring my own
published table's omission as a finding against the bench.

**T-A34 reddens under D-M2 through the monitor rather than through A3.** A3
compares lane 0's tuple sequence against lane 4's; a verdict hardwired bad
affects both lanes identically, so the sequences remain equal and A3 passes.
The unit still reddens, one layer down.

**T-ST is green under everything.** It drives no frame.

## 5. The honest weighting — D-M1..D-M4 are weaker evidence than D-M5

`WO-0040` §9 published the mutation → row mapping so the bench author could
write against the mutations. That was right for the bench and it costs the
campaign: for four of five mutations, **"which row dies" was public before the
seeder was briefed.** The adjudication must weigh them accordingly.

**Two things materially soften that, and both are worth stating before the
run rather than after:**

1. **The published table gives away almost nothing here**, because D-M1, D-M4
   and D-M5 share the *same* row set {T-D1, T-D3}. A seeder steering toward
   "make T-D1 and T-D3 die" cannot thereby produce D-M1 rather than D-M4 — the
   distinguishing content is the **message**, which is sealed. My pessimism in
   `J-dv_lead-0040` was therefore somewhat overstated, and I am revising it
   upward here rather than leaving the record wrong.
2. **The MUST-STAY-GREEN columns were never published**, and for D-M1 that
   column is the entire claim: **ten of twelve units cannot see it.** That is
   the silently-always-pass demonstration and it is unguessable from the
   published table.

**D-M5 carries the full WO-0039 blinding** — its row mapping appears in no
document the seeder may read. If exactly one mutation in this campaign should
be weighted as heavily as WO-0039's five, it is this one.

## 6. Pass criteria — all three, per mutation

1. The suite goes red.
2. Red in the REQUIRED units **with the expected message**, and no
   MUST-STAY-GREEN unit reddens. Either half violated is a **finding**,
   adjudicated, never silently scored as a pass.
3. The unmutated control is green — structural via the parent-SHA rule, and
   re-confirmed at the campaign's first and last runs.

**D-M1 is the mutation this family was written for.** It is the
silently-always-pass class the WO-0039 campaign contained no instance of, and
whose absence is why that campaign could not discover that REQ-104's positive
direction was unverified. **A family D that does not die on D-M1 has closed
nothing**, and `SO-M03` does not issue.

## 7. What the auditor must not be told

1. §2's matrix in full — above all the **MUST-STAY-GREEN** columns.
2. §3's expected messages.
3. **D-M5's row mapping**, which is the one genuinely blinded item.
4. §4's reasoning and §5's weighting.
5. Pass criterion 2's message clause.

Freely tellable, and told: every intent in the brief's §2, the bars, the
mechanics, the return format, and the plain statement that D-M1 will look
quiet on purpose.

---

## SEALED ADDENDUM — D-M6's frozen prediction (WO-0042's mini-round)

> **RE-SEALED for the D-M6 round.** Everything above is scored and unsealed;
> **this section is not.** The auditor must not open this file until the D-M6
> diff is committed — bar 6 of `WO-0042` §1.

- **Frozen against**: bench SHA **`447d11c`**, verified byte-identical to HEAD
  under `test/xgmii_rx_64/` (`git diff 447d11c HEAD -- test/xgmii_rx_64/` is
  empty), so the previous five and this one share one base and one control.
- **Frozen by**: dv_lead, `J-dv_lead-0045`, **before the diff existed**.
- **Second copy**: `J-dv_lead-0045`.

### D-M6 — the latched abort bit

**Observability argument, stated first because it determines the whole matrix.**
The defect is visible only where a *single simulation* drives **two or more
frames** and a **later** frame is asserted to carry `tuser`[0] = 0 after an
**earlier** one set it. Every other unit in the suite builds a **fresh bench per
frame** — `one_frame`, `run_length` and `run_directed_lengths` each call
`create ()` per entry — so no latch can survive into an assertion. Only
`run_mixed_pair`'s two-frame schedules qualify.

### The matrix

| unit | D-M6 |
|---|---|
| T-A12 | G |
| T-A34 | G |
| T-A5 | G |
| T-B1 | G |
| T-C12 | G |
| T-C3 | G |
| T-C4 | G |
| T-C5 | G |
| T-ST | G |
| T-D1 | G |
| **T-D2** | **R** |
| **T-D3** | **R** |

**REQUIRED red: 2. MUST-STAY-GREEN: 10.**

### Expected messages — both on the **second** frame of a **pair B** schedule

**T-D3** — `run_d3` passes lane 0 / pair A (frame 1 has no predecessor; frame 2
is genuinely bad and expects the set bit), then fails at lane 0 / pair B, whose
second frame is good:

```
M03-D3 pair B (bad-then-good), lane 0: frame 2: tuser[0] does not match its own FCS status
```

**T-D2** — its four calls run in order; the first three pass (two single-frame
partners, then pair A whose asserted member is frame 1). The fourth fails:

```
M03-D2 (D3's good member, pair B (bad-then-good), lane 0): frame 2: tuser[0] does not match its own FCS status
```

**Both speak through `assert_frame`'s `tuser` check**, which runs *after* the
octet-sequence comparison and *before* the strobe-set comparison — so a strobe
message here would be a **finding**, and would mean the seeder latched the
reporting path along with the marking bit, contrary to the intent's §2
precision.

### PERMITTED

**None.** Every cell above is REQUIRED or MUST-STAY-GREEN. There is no
genuinely two-way case in this round.

### Why this round matters, and one thing it accidentally proves

M03-D3's *headline* kill was withdrawn as unachievable at `RV-0041-VERDICT` §3.
This is the row's **surviving** declared kill and the only one still unevidenced
— so this single diff decides whether the row earns its ASSERT status or is a
two-frame stimulus asserting nothing that any mutation can reach.

**And the row set is the same {T-D2, T-D3} I wrongly predicted for D-M3.** That
is worth recording rather than hiding: my D-M3 prediction was not wrong about
*which units can see a cross-frame defect* — it was wrong about whether D-M3
*was* one. The instrument was correctly identified; the target was not. If D-M6
lands on exactly those two units, it vindicates M03-D3's two-frame structure
while confirming that the thing it was originally built to catch never existed.

### Not to be told

The matrix, both message strings, the observability argument, and the
`assert_frame` ordering that makes a strobe message a finding. **Freely told and
told**: the intent, the strobes-do-not-move precision, the nine bars, and the
plain warning that this defect will look quiet.
