# WO-0039 SEALED: dv_lead's frozen predictions for the M03 mutation campaign

> **SEALED. The auditor must not open this file until all five mutation diffs
> are committed.** The orchestrator must not relay any part of it before then.
> Reading it earlier does not merely bend a rule — it destroys the campaign's
> only claim to be a test rather than a confirmation, because a seeder who
> knows the predicted kill set can choose a mutation site that satisfies it.
> See `WO-0039_m03-mutation-campaign.md` §0.

- **State**: **UNSEALED 2026-08-06**, on the orchestrator's word that all five
  branches had run. Scored at `RV-0039-VERDICT` in the companion packet,
  `J-dv_lead-0036`. **This state line is the only line of this file that has
  been altered since the freeze** — no prediction, table, message string or
  classification below has been touched, and `git diff` against the freeze
  commit is the check. A freeze edited after its result is worthless; the
  scoring lives in the companion, not here.
- **Frozen against**: bench SHA `6bd7e5a`, green end-to-end twice
- **Frozen by**: dv_lead, `J-dv_lead-0035`, **before any mutation diff existed**
- **Companion**: `agents/handoffs/WO-0039_m03-mutation-campaign.md` (the
  auditor-facing brief; intents only, no predictions)

## 0. Integrity note — why this is written twice

Everything committed here is also committed, in substance, in
`J-dv_lead-0035`. Two independent append-only copies of a freeze is not
redundancy: if either is later edited to fit a result, the other exposes it.
I have been falsified once already in this module's history
(`J-dv_lead-0031`, the F-M03-1 experiment) and the entire value of that episode
came from the prediction being un-adjustable afterwards. Same discipline, made
structural.

## 1. The nine test units CI reports

Predictions are stated against `%expect_test` names, because that is the
granularity CI reports and therefore the granularity an adjudication can use.

| id | `%expect_test` name | rows |
|---|---|---|
| **T-A12** | `M03-A1, M03-A2: 64-octet frame at both start lanes — 8 words, tkeep/tlast pattern, m+3 timing, FCS good at lane 4 (the C-18 kill)` | A1, A2 |
| **T-A34** | `M03-A3: directed lengths 64..71 equal as tuple sequences at both lanes; M03-A4: no cross-lane absolute-cycle comparison is made` | A3, A4 |
| **T-A5** | `M03-A5: position-dependent filler pins byte order and lane placement` | A5 |
| **T-B1** | `M03-B1: nonstandard preamble filler and SFD octets, both start lanes` | B1 |
| **T-C12** | `M03-C1, M03-C2: directed lengths 64..71 at both lanes — all eight tkeep patterns once each, FCS good where terminate lands past lane 0` | C1, C2 |
| **T-C3** | `M03-C3: one 1518-octet frame, both lanes — 1514 octets in 190 words` | C3 |
| **T-C4** | `M03-C4: the 5-octet runt is a legal one-word frame (C-11)` | C4 |
| **T-C5** | `M03-C5: 1513 and 1516-octet frames at both lanes — the P-1 probe` | C5 |
| **T-ST** | `WO-0038 scaffolding: Xgmii_rx_64 elaborates and runs idle cycles` | L6 |

## 2. The three-way classification, and why a flat "named rows" list is not enough

Every row's body ends in `account_clean_frame` + `assert_monitors_clean`, so a
monitor layer runs inside all of them. A flat kill list would make every
monitor-side surprise look like a prediction failure. So each mutation is
frozen as:

- **REQUIRED** — must redden. **If any REQUIRED unit stays green, the campaign
  fails for that mutation** and `SO-M03` does not issue.
- **MUST STAY GREEN** — predicted unaffected. **A reddening here is a FINDING**:
  the bench caught the defect somewhere it was not built to catch it, which
  means either my model of the row is wrong or the mutation was not minimal.
- **PERMITTED** — named in advance as genuinely two-way, with both branches and
  what each would tell me. Neither branch is a finding; both are adjudicated.

**A REQUIRED unit that reddens with the wrong message is also a FINDING.** Which
assertion speaks is the whole content of the result — that is why §5 of the
brief demands verbatim output rather than a pass/fail summary.

## 3. M1 — output latency shifted by one cycle

Only three assertion sites in the whole suite compare an absolute cycle:
`T-A12`'s `start_cycle + 3 + m` per word, `T-A34`'s `assert_own_deltac`
(`observed <> 3`), and `T-C4`'s single-word cycle and strobe cycle. Everything
else asserts content only. The latency monitor holds a **ceiling** of 4, not an
equality, so ΔC = 4 does not trip it and ΔC = 2 does not either.

| unit | prediction | expected message |
|---|---|---|
| **T-A12** | **REQUIRED** | `word 0 expected on cycle <start+3>, observed on cycle <start+4>` — at **lane 0**, word 0, since lane 0 runs first |
| **T-A34** | **REQUIRED** | **A4's**: `word 0 arrived ΔC = 4 cycles after this lane's OWN start cycle, expected 3 (REQ-019)` |
| **T-C4** | **REQUIRED** | either `the single output word did not arrive on start_cycle + 3 (REQ-019)` **or** `error_runt pulsed on cycle X, expected Y` — which one depends on whether the strobe path shifted with the data path; both admissible |
| T-A5, T-B1, T-C12, T-C3, T-C5, T-ST | **MUST STAY GREEN** | content-only assertions; a uniform shift moves no content |

**FINDING conditions specific to M1.** (a) `T-A34` reddening with **A3's**
message (`lane-0 and lane-4 ... sequences differ`) means the shift was **not
lane-uniform** — the mutation is not M1. (b) Any of the five
MUST-STAY-GREEN units reddening means the mutation moved content as well as
timing.

**What a green T-A5/T-B1/T-C12/T-C3/T-C5 teaches, and it is not a defect:**
five of nine test units are blind to a one-cycle latency error. That is by
design — they are content rows — but it should be on the record that M03's
timing is asserted by exactly three units, and a future D–H bench should not
assume otherwise.

## 4. M2 — CRC holds across a lane-4 start's frame octets 0–3 (C-18)

SPEC-M03 §9 row for REQ-104: a computed-residue mismatch pulses
**`error_bad_fcs`** and forwards **the frame in full** with `tuser`[0] = 1. So
every lane-4-start frame acquires both a set `tuser` and an extra strobe, while
lane-0 frames are untouched. Delivered octets, `tkeep` and timing do not move.

| unit | prediction | expected message |
|---|---|---|
| **T-A12** | **REQUIRED** | `tuser[0] set — FCS verdict bad (this is the C-18 kill at lane 4)` — this row exists for this mutation |
| **T-A34** | **REQUIRED** | **A3's**: `lane-0 and lane-4 (octets, tkeep, tlast, tuser) sequences differ` — `tuser` is inside the compared tuple, so a lane-asymmetric FCS verdict is exactly what A3 is for |
| **T-A5** | **REQUIRED** | `tuser[0] set unexpectedly` (lane 4) |
| **T-B1** | **REQUIRED** | `M03-B1 (lane 4): tuser[0] set on a legal, standard-FCS frame` |
| **T-C12** | **REQUIRED** | batched table: **8 FAIL lines at lane 4, 8 PASS at lane 0**, each FAIL showing `tuser=1` *and* `error_pulses=1` |
| **T-C3** | **REQUIRED** | `tuser[0] set unexpectedly` (lane 4) |
| **T-C5** | **REQUIRED** | batched table: 2 FAIL at lane 4, 2 PASS at lane 0 |
| **T-C4** | **PERMITTED** | see below |
| **T-ST** | **MUST STAY GREEN** | drives no frame |

**T-C4 is a two-way probe of SPEC-M03 §9's ninth co-occurrence ruling, and I am
recording both branches rather than guessing.** C4's frame is **exactly 5**
octets — 1 delivered, 4 FCS. §9's ninth ruling bars the
`error_runt` + `error_bad_fcs` pairing for frames of **fewer than** 5 octets,
and the change-log entry that added it says "the first ruling bounds the
admitted pairing **at** 5 octets". Read that way the pairing is admitted here.

- **Branch A (my primary expectation): T-C4 reddens** with
  `expected exactly one strobe pulse (error_runt only), observed 2`. `tuser` is
  already 1 for a runt, so the strobe set is the only observable that moves.
- **Branch B: T-C4 stays green** — the pairing is barred at exactly 5 octets
  too. Then the bound in §9's ninth ruling is above 5, not at it, and that is a
  **specification question for architect_docs_lead**, routed by me, not a bench
  defect and not a campaign failure.

Neither branch is a finding. This is the campaign's one free piece of
specification information and I would rather harvest it than pretend certainty.

**The size of M2's REQUIRED set is the point, not a weakness.** Seven of nine
units must die, because a broken FCS verdict on half the stimulus is exactly
the kind of defect a spine bench should be unable to miss. A mutation that
kills only some of them is a finding about the bench, and a valuable one.

**Alternative-disposition clause.** If M03 turns out to *drop* bad-FCS frames
rather than forward them, the REQUIRED set above is **unchanged** — every unit
still dies — but the messages become drop-shaped (`no tlast word observed`,
`expected 8 output words, got 0`). That would be information about M03's
disposition, not a bench finding, and I name it here so it cannot be scored as
a surprise. §9 says forwarded-in-full, so I expect the primary shapes.

## 5. M3 — `tkeep` from the terminating input word

The terminating input word's occupied lanes include the four FCS octets, which
are not delivered, so input-derived and frame-derived `tkeep` differ by up to
four lanes. Because `Stream_word.octets` is masked by `tkeep`, a wrong `tkeep`
also corrupts the delivered octet *sequence* — so content rows die too.

| unit | prediction | expected message |
|---|---|---|
| **T-A12** | **REQUIRED** | a `word m tkeep = X, expected 0x0F` at word 7, **or** `delivered octets differ from the injected frame minus its FCS` |
| **T-A5** | **REQUIRED** | `delivered octet j is not the position-dependent filler's octet j` or `word m byte order is wrong` — A5's position-dependent filler exists precisely so a masking error cannot hide |
| **T-C12** | **REQUIRED** | the batched table, and/or `the eight tkeep patterns were not each observed exactly once` |
| **T-C3** | **REQUIRED** | `word 189 tkeep = 0x3F, expected 0x03` (terminate lane 6 at a lane-0 start) |
| **T-C4** | **REQUIRED** | `tkeep is not 0x01 on the one-word frame` — at **lane 0**, where the terminating word carries five frame octets (input-derived 0x1F). At lane 4 the two happen to coincide, so lane 0 is what speaks |
| **T-C5** | **REQUIRED** | the batched table at all four entries |
| **T-B1** | **REQUIRED** | `delivered octets differ from the injected frame minus its FCS` |
| **T-A34** | **PERMITTED** | see below |
| **T-ST** | **MUST STAY GREEN** | drives no frame |

**T-A34 is two-way and the reason is structural.** A3 compares lane 0 against
lane 4; it is deliberately blind to any error that is *lane-symmetric*. Whether
input-derived `tkeep` errs symmetrically depends on the terminate lane, which
differs between the two starts at every length. So:

- **A3 reddens** — the error is lane-asymmetric at some length. Expected.
- **A3 stays green while seven other units die** — the error is lane-symmetric.
  This would be a clean demonstration that **A3 is a cross-lane equality row,
  not a general content check**, which is a property worth having on the record
  before families D–H are written.

**Fidelity note carried into adjudication.** At a lane-0 start with a 64-octet
frame the terminating word carries **zero** frame octets (`terminate_lane = 0`),
so "the input word's occupied lanes" is degenerate there. I told the auditor its
minimal diff may change delivered octets and to say so. If the report says so,
the octet-sequence messages above are the expected shape rather than the
`tkeep` ones — still REQUIRED, still the same units.

## 6. M4 — maximum-words-per-frame reduced to 189

| unit | prediction | expected message |
|---|---|---|
| **T-C3** | **REQUIRED** | `expected 190 output words, got 189` — C3's 1518-octet frame is the only stimulus in the suite that needs 190 |
| **T-C5** | **PERMITTED** | see below |
| T-A12, T-A34, T-A5, T-B1, T-C12, T-C4, T-ST | **MUST STAY GREEN** | every other stimulus needs **8 words or fewer** |

**T-C5 is the boundary discriminator, and this is the sharpest prediction in the
campaign.** C5's two lengths deliver 1509 and 1512 octets — **189 words each**,
exactly one below C3's 190.

- **C5 stays green** ⟹ the bound landed exactly where the intent asked: 189
  words still complete, 190 do not. This is my expectation.
- **C5 reddens** ⟹ the bound landed at 188, or the comparison is strict where
  the intent assumed non-strict. That is a **fidelity note about the diff**, to
  be confirmed against the auditor's own boundary statement — not a bench
  finding and not a campaign failure.

**M4's REQUIRED set is a single unit, deliberately.** A mutation only one row
can see is the strongest possible evidence that the row is load-bearing, and
the seven MUST-STAY-GREEN units make it a two-sided test rather than a
one-sided one.

## 7. M5 — re-introduce BUG-0001's over-delivery at `k` > 4

`excess = max(0, k − 4)`, `k = ((D − 1) mod 8) + 1`. Worked for every stimulus
in the suite, **before the diff exists**:

| stimulus | `D` | `k` | excess |
|---|---|---|---|
| lengths 64, 69, 70, 71 (C1/C2) | 60, 65, 66, 67 | 4, 1, 2, 3 | **0** |
| lengths **65, 66, 67, 68** (C1/C2) | 61, 62, 63, 64 | 5, 6, 7, 8 | **+1, +2, +3, +4** |
| **1513** (C5) | 1509 | 5 | **+1** |
| **1516** (C5) | 1512 | 8 | **+4** |
| A1/A2, A5, B1 (64 octets) | 60 | 4 | **0** |
| C3 (1518 octets) | 1514 | 2 | **0** |
| C4 (5 octets) | 1 | 1 | **0** |

| unit | prediction | expected message |
|---|---|---|
| **T-C12** | **REQUIRED** | batched table with **exactly 8 FAIL lines** — lengths 65, 66, 67, 68 at **both** lanes — and 8 PASS |
| **T-C5** | **REQUIRED** | batched table, **all four entries FAIL**: 1513 over by 1, 1516 over by 4, both lanes |
| **T-A34** | **REQUIRED** | **not** A3's tuple message — the **monitor/latency accounting** from `assert_monitors_clean bench0 ~row:"M03-A3 (length 65) lane 0"`, the first length where the excess bites. The excess is lane-**independent** (`J-dv_lead-0031`), so the two lanes' tuple sequences stay equal and A3's own compare passes |
| T-A12, T-A5, T-B1, T-C3, T-C4, T-ST | **MUST STAY GREEN** | every one of them has `k` ≤ 4 |

**M5 is the best-calibrated prediction here, because most of it has already been
observed.** Run **30774152441** carried exactly this defect, and reported
exactly this shape: C1/C2 convicting, and `test_m03_a.ml`'s **latency tagger**
corroborating — not its tuple comparison. M5 replays a known kill set.

**Its novel content is T-C5 alone.** C5 did not exist at 30774152441. It is the
only row in the suite that **has never been red**, and it carries fix-verdict
condition 4 of `BUG-0001`. If M5 leaves T-C5 green, then the row on which I
closed a CRITICAL bug cannot fail, and the fix verdict is retrospectively
unsupported. **That single cell is the most important result this campaign will
produce.**

## 8. Bench-side self-mutations B1–B3 — and their weaker evidentiary class

Stated plainly, because it bears on how much they are worth: **I author both
the mutation and the prediction here, so these grade my own instrument with my
own hand.** They cannot show that a check *discriminates* M03's behaviour. They
show only that a check is **reachable and wired** — which the five RTL
mutations may never reach, since none of them targets the round-6 machinery.
They are a complement to M1–M5 and in no way a substitute.

| id | mutation (in `test/xgmii_rx_64/**`, my scope) | expected outcome |
|---|---|---|
| **B1** | drop the `Int.rem o.expected_delivered 8 = 0` conjunct from `expected_disagree` | **T-C12 reddens** from `check_disagreement_matches_r1`, and the dumped table **must name lane 0 / length 64** — the sole entry with `terminate_lane = 0` and a non-full final word, i.e. exactly what that conjunct excludes. If it names a different entry my §4 enumeration at `RV-0038-R7-VERDICT` was wrong |
| **B2** | force one `length_outcome`'s `observed_tkeep` to `None` | **T-C12 reddens** from `outcome_ok`'s `None -> false` branch — the branch carrying fix-verdict condition 2, never exercised since the fix |
| **B3** | `run_c5` drives zero lengths | **T-C5 PASSES, SILENTLY.** Expected. Not a test — an **exhibit**: every check in `run_c5` iterates a list, so an empty list satisfies all of them and the suite is green. This is the green-run gap made concrete. **If B3 fails, my whole argument for why this campaign is necessary is wrong, and I want to know that more than I want to be right.** |

## 9. Pass criteria — all three, per RTL mutation

1. **The suite goes red.**
2. **Red in the REQUIRED units, with the expected message; no MUST-STAY-GREEN
   unit reddens.** Violations of either half are FINDINGS, adjudicated, not
   silently scored as passes.
3. **The unmutated control is green** — structural, via the brief's
   parent-SHA-is-`6bd7e5a` rule, re-confirmed at the campaign's first and last
   runs.

A green run on any of M1–M5 is a **campaign failure**: a seeded defect the bench
did not catch. **`SO-M03` does not issue** until all five kill.

## 10. What the auditor must not be told — the explicit list

1. **Every prediction in §3–§7**: the REQUIRED sets, the MUST-STAY-GREEN sets,
   the PERMITTED branches, and every expected message string.
2. **Pass criterion 2** — that reddening the *named* units is required. A
   seeder who knows this can steer a diff toward a kill set; a seeder who knows
   only "make the described defect faithfully" cannot.
3. **§8 entirely.** B1–B3 are mine, and B3's expected-green telegraphs the
   argument in §7 of the brief.
4. **The row inventory in §1**, and anything that discloses which rows assert
   timing versus content. Hence the brief's bar on reading
   `test/xgmii_rx_64/**` and `test/attack_plans/AP-xgmii_rx_64.md`.

**What the auditor may freely be told, and should be:** every word of the
brief — the five intents, the minimality and fidelity requirements, the five
bars, the report format, and §7's statement of why the campaign exists. Nothing
in the intents is weakened by disclosure; they are behavioural specifications
of defects, and a seeder who understands *why* the campaign matters will author
better diffs, not worse ones.
