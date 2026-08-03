# WO-0050 SEALED: dv_lead's frozen predictions for the family-F campaign

> **SEALED.** The auditor must not open this file until all eight diffs are
> committed — and under `WO-0050` §1's allowlist, **all of `agents/**` is out of
> bounds for the campaign's duration**, this file included.

- **State**: FROZEN
- **Frozen against**: **`616686f`** — the SHA the green control run actually
  executed (CI run **30826473824**, workflow `build`, conclusion **success**).
  No byte-identity inference is needed. For the record,
  `git diff 8e040f0 616686f -- test/ libs/` is **empty**.
- **Frozen by**: dv_lead, `J-dv_lead-0061`, **before any diff existed**.
- **Second copy**: `J-dv_lead-0061`.

## 0. The denominator, measured — and the figure it corrects is mine

**Twenty `%expect_test` units in the M03 bench**, from `tools/dv_checks.sh`'s
inventory block:

```
    3  test/xgmii_rx_64/test_m03_a.ml   1  test/xgmii_rx_64/test_m03_b.ml
    4  test/xgmii_rx_64/test_m03_c.ml   3  test/xgmii_rx_64/test_m03_d.ml
    4  test/xgmii_rx_64/test_m03_e.ml   4  test/xgmii_rx_64/test_m03_f.ml
    1  test/xgmii_rx_64/test_m03_structural.ml
  ---
   20  test/xgmii_rx_64/ (the M03 bench)     100  test/ (repository-wide)
```

Measured twice: by running the tool at the working tree, and independently
straight out of git at the base (`git show 616686f:<file> | grep -c
'let%expect_test'` over `git ls-tree -r --name-only 616686f -- test/`). Both
give **20** and **100**.

> **`RV-0047` §6 predicted "nineteen `%expect_test` units (fifteen existing,
> plus M03-E5 in `test_m03_e.ml` and F1–F4 in `test_m03_f.ml`)". Fifteen plus
> five is twenty. The figure is WRONG, it is mine, and `tasks/BOARD.md`
> transcribed it as "nineteen silent units."** The fifteen came from the tool;
> the nineteen came from adding in my head in the same sentence that enumerated
> the five additions.
>
> This is the **third** time an M03 unit count has gone wrong by not being
> counted — "fifteen" then "eighteen" circulated through four packets
> (`J-dv_lead-0042`), which is why `dv_checks.sh` grew an inventory block whose
> own banner reads *"Do not quote a unit count nobody has counted"*. **I quoted
> one anyway, one packet after using the tool correctly.** The instrument was
> not at fault and neither was anyone else's arithmetic; the freeze that matters
> is this one and it is measured, but the correction belongs on the record
> before the matrix, not after it.

**Blast radius, unchanged and re-checked**: no test outside
`test/xgmii_rx_64/` instantiates M03, so a *behavioural* mutation's reach is
exactly these twenty. A unit outside them reddening is a **build-level**
finding, never a behavioural one.

## 1. The twenty units

| id | file | row(s) |
|---|---|---|
| T-A12 | `test_m03_a.ml` | M03-A1, M03-A2 |
| T-A34 | `test_m03_a.ml` | M03-A3, M03-A4 |
| T-A5 | `test_m03_a.ml` | M03-A5 |
| T-B1 | `test_m03_b.ml` | M03-B1 |
| T-C12 | `test_m03_c.ml` | M03-C1, M03-C2 |
| T-C3 | `test_m03_c.ml` | M03-C3 |
| T-C4 | `test_m03_c.ml` | M03-C4 |
| T-C5 | `test_m03_c.ml` | M03-C5 |
| T-D1 | `test_m03_d.ml` | M03-D1 |
| T-D2 | `test_m03_d.ml` | M03-D2 |
| T-D3 | `test_m03_d.ml` | M03-D3 |
| T-E1 | `test_m03_e.ml` | M03-E1 |
| T-E2 | `test_m03_e.ml` | M03-E2 |
| T-E4 | `test_m03_e.ml` | M03-E4 |
| **T-E5** | `test_m03_e.ml` | **M03-E5** — `/E/` at preamble positions 1..7, lane-0 start |
| T-ST | `test_m03_structural.ml` | M03-L6 |
| **T-F1** | `test_m03_f.ml` | **M03-F1** — 5, 16, 60, 63-octet runts, both lanes |
| **T-F2** | `test_m03_f.ml` | **M03-F2** — 0, 1, 4 octets received, both lanes |
| **T-F3** | `test_m03_f.ml` | **M03-F3** — 63-octet frame, wrong FCS, both lanes |
| **T-F4** | `test_m03_f.ml` | **M03-F4** — the adjacent pair 63 and 64, both lanes |

## 2. The matrix — every class against every unit

`R` = REQUIRED red. `G` = MUST STAY GREEN. Anything off-pattern is a **finding**.

| unit | F-c1 | F-c2 | F-c3 | F-c4 | F-c5 | F-c6 | F-c7 | F-c8 |
|---|---|---|---|---|---|---|---|---|
| T-A12 | G | **R** | G | G | G | G | G | G |
| T-A34 | G | **R** | G | G | G | G | G | G |
| T-A5 | G | **R** | G | G | G | G | G | G |
| T-B1 | G | **R** | G | G | G | G | G | G |
| T-C12 | G | **R** | G | G | G | G | G | G |
| T-C3 | G | G | G | G | G | G | G | G |
| T-C4 | **R** | G | G | G | G | G | G | G |
| T-C5 | G | G | G | G | G | G | G | G |
| T-D1 | G | **R** | G | G | G | G | G | G |
| T-D2 | G | **R** | G | G | G | G | G | G |
| T-D3 | G | **R** | G | G | G | G | G | G |
| T-E1 | G | G | G | G | G | G | G | G |
| T-E2 | G | G | G | G | G | G | G | **R** |
| T-E4 | G | G | G | G | G | G | G | G |
| **T-E5** | G | G | G | G | G | G | **R** | **R** |
| T-ST | G | G | G | G | G | G | G | G |
| **T-F1** | **R** | G | G | G | G | G | G | G |
| **T-F2** | G | G | **R** | G | **R** | **R** | G | **R** |
| **T-F3** | **R** | G | G | **R** | G | G | G | G |
| **T-F4** | **R** | **R** | G | G | G | G | G | G |
| red count | 4 | 9 | 1 | 1 | 1 | 1 | 1 | 3 |

**21 REQUIRED cells, 139 MUST-STAY-GREEN cells.**

## 3. Expected messages

All row prefixes below are the bench's own `row` strings, and every message is
the **first** assertion to speak, given each row's committed assertion order and
its committed iteration order (`WO-0047` §4.2's contract, honoured in the
Return log). Where a row loops, only the **first** iteration determines the
message: these rows fail fast.

### F-c1 — four units

| unit | message |
|---|---|
| T-C4 | `M03-C4 (lane 0): tkeep is not 0x01 on the one-word frame` |
| T-F1 | `M03-F1 (lane 0, length 5, delivered 1, final word fill 1): tlast tkeep = 31, expected 1` |
| T-F3 | `M03-F3 (lane 0): tlast tkeep = 127, expected 7` |
| T-F4 | `M03-F4 (lane 0): frame 1: tkeep does not match its own 59 delivered octets` |

**Why `tkeep` and not the word count**, at all four — this is the cell I worked
rather than assumed, and it is the E-c1 lesson applied before the run instead of
after. Suppressing a four-octet strip changes the delivered count by four, but
each of these rows checks the **output-word count first**, and in every one of
the four cases the count is **unchanged**: 1 → 1 at C4 (5 octets still fit one
word), 1 → 1 at F1's first iteration, 8 → 8 at F3 (59 and 63 both need eight
words), 8 → 8 at F4's frame 1. The `tlast` **cycle** is likewise unchanged,
because it is a function of the word count. So the third assertion — `tkeep` —
is the first to differ, at every one of them.

### F-c2 — nine units

| unit | message |
|---|---|
| T-A12 | `M03-A1/A2 (lane 0): tuser[0] set — FCS verdict bad (this is the C-18 kill at lane 4)` |
| T-A34 | `M03-A3 (length 64) lane 0: strobe monitor unclean:` followed by `Strobe_monitor.report` — **an `error_runt` pulse that no expected event claims** |
| T-A5 | `M03-A5 (lane 0): tuser[0] set unexpectedly` |
| T-B1 | `M03-B1 (lane 0): tuser[0] set on a legal, standard-FCS frame` |
| T-C12 | the batched signature table: `M03-C1/M03-C2: per-length signature, both lanes, one run (RV-0038-R5 R5-4); each FAILING entry's protocol monitor report follows (RV-0038-R7 R6-4):` — with **exactly two failing entries, length 64 at each lane, on `tuser=1`** |
| T-D1 | `M03-D1 (lane 0): expected exactly one strobe pulse (error_bad_fcs only), observed 2` |
| T-D2 | `M03-D2 (D1's own frame, uncorrupted, lane 0): tuser[0] set on a legal, good-FCS frame` |
| T-D3 | `M03-D3 pair A (good-then-bad), lane 0: frame 1: tuser[0] does not match its own FCS status` |
| T-F4 | `M03-F4 (lane 0): frame 2 (64 octets): tuser[0] set -- this is a LEGAL frame, not a runt` |

### F-c3, F-c5 and F-c6 — one unit each, and they are the same unit

**All three kill T-F2 alone and are separated ONLY by which assertion speaks.**
This is the fourth campaign with that structure — D-M1/D-M4/D-M5, then
E-c3/E-c5, and now a **three-way** discrimination — and the sealed messages do
all the work.

| | T-F2 speaks |
|---|---|
| **F-c3** | `M03-F2 (lane 0, 0 octets received): a tlast word was observed for a frame that must deliver nothing (section0.7, F-c5)` |
| **F-c5** | `M03-F2 (lane 0, 0 octets received): expected exactly one strobe pulse (error_runt only -- F-c5's own kill), observed 0` |
| **F-c6** | `M03-F2 (lane 0, 0 octets received): a tvalid word was observed for a frame that must deliver nothing` |

**F-c3's second admissible message.** The intent's natural implementation is a
`tkeep` = 0 or preamble-octet word emitted **carrying `tlast`** — the stated
motive is "somewhere to put the abort bit" — and `run_f2` matches
`tlast_sample` first, so that is the message above. **If the mutant emits a
`tvalid` word without `tlast`**, the next assertion speaks instead: `a tvalid
word was observed for a frame that must deliver nothing`. **Both are
admissible.** Any third shape is a finding. (Identical in structure to E-c2's
two admissible shapes, and for the identical reason.)

**F-c6's second admissible message is F-c3's first**, symmetrically: an
underflowed count most plausibly drives output words with no `tlast` among them,
which is why the `tvalid` message is primary here and the `tlast` message is the
alternative. **Both are admissible.**

> **F-c6's THIRD outcome is not a message and is pre-committed.** If the diff is
> faithful and **all twenty units are green**, that is not a finding and not a
> failure: it is the answer `RV-0047` §5(3) sent the campaign to fetch, and
> **M03-F2's second declared kill — "attempts FCS removal on a frame with
> nothing to remove it from and underflows its counter" — is WITHDRAWN by spec
> diff**, on the M03-D3 precedent. If instead the auditor reports that a faithful
> minimal underflow is **not expressible** in this design, the same withdrawal
> follows on a stronger ground, and no diff is owed.
>
> **F-c6 reddens at `k = 0`, the first iteration**, which is why the row prefix
> above says `0 octets received`. At `k = 4` there is no underflow at all
> (4 − 4 = 0), and at `k = 1` there is; the first iteration decides the message.

### F-c4 — one unit

| unit | message |
|---|---|
| T-F3 | `M03-F3 (lane 0): expected exactly {error_runt, error_bad_fcs}, each once, both on cycle N -- the precedence/widened-pulse kill this row exists for; observed 1 pulse(s)` |

`N` is `expected_tlast_cycle`, the row's own derived value. **The message is
deliberately robust to which of the two strobes the mutant suppresses** — the
comparison is against a sorted set and reports only the count — so the auditor's
free choice in `WO-0050` §2 cannot move the seal.

### F-c7 — one unit

| unit | message |
|---|---|
| T-E5 | `M03-E5 (preamble position 1, lane 0): expected exactly one strobe pulse (error_bad_frame only), observed 0` |

### F-c8 — three units, one message shape

| unit | message |
|---|---|
| T-E2 | `M03-E2 (lane 0): error_bad_frame pulsed on cycle X, expected Y` |
| T-E5 | `M03-E5 (preamble position 1, lane 0): error_bad_frame pulsed on cycle X, expected Y` |
| T-F2 | `M03-F2 (lane 0, 0 octets received): error_runt pulsed on cycle X, expected Y` |

**In all three, `Y − X = 1` exactly** — the intent displaces the pin one cycle
early and no further. A displacement of two, or in the other direction, or a
different cycle at different units, is a **finding** against the diff's fidelity
rather than against the bench.

## 4. Reasoning for the cells that are not obvious

**(a) T-A34 is the most interesting cell in this matrix, and it answers a
standing open item.** Under F-c2 a 64-octet frame gains `tuser`[0] = 1 — and
`tuser` **is inside the tuple M03-A3 compares across the two start lanes**. Both
lanes are affected identically, so the sequences stay **equal** and *M03-A3's own
assertion passes*. The unit reddens anyway, one line later, through
`assert_monitors_clean`: the `Strobe_monitor` sees an `error_runt` pulse that no
`expect` claims, and `run_directed_lengths` registers none.

> **That is `AP-xgmii_rx_64.md` §8's third standing fact becoming measured.**
> "M03-A3's blindness to *lane-symmetric* errors is UNTESTED" has stood since
> `J-dv_lead-0037`, because WO-0039's mutation M3 was predicted to demonstrate it
> and took the reddening branch instead. **F-c2 is a lane-symmetric content error
> and this prediction says A3's own comparison is blind to it.** If T-A34 instead
> reddens on the tuple-equality message, my model of that row is wrong and it is a
> finding against me, not against the diff.

**(b) T-C4 reddening under F-c1 is expected and is not a defect in the campaign's
design.** A *pre-existing* unit catching a family-F class looks odd until you
read `WO-0047` §1.1: M03-C4 already drives a 5-octet runt at both lanes and
asserts seven facts about it, so **REQ-107's report path was already verified at
five octets before family F existed**. F-c1 is therefore *not* a
silently-always-pass class and was never claimed to be. The classes that are
silently-always-pass here are F-c5 and F-c7.

**(c) F-c5's blindness, counted: nineteen of twenty units cannot see it.** Only
T-F2 drives a frame below five octets between start and terminate. **Before
`test_m03_f.ml` existed, twenty of twenty could not** — that is the hole
`WO-0047` §1.1 identified and the reason the packet was written. Same shape as
D-M1's ten-of-twelve and E-c5's thirteen-of-fifteen.

**(d) F-c7's blindness, counted: nineteen of twenty.** Only T-E5 drives a frame
opened and closed inside one input word. **Before M03-E5 was added — after the
family-E campaign had been scored, from a finding your predecessor made by
reading this design — twenty of twenty could not.** M03-B2 drives a single
preamble-position `/E/` but is unbenched; no committed unit reached this route.

**(e) F-c8 is the only class here whose claim spans two families, and it is the
claim `WO-0047` §1.2 was written to make testable.** M03-E5 (REQ-105) was folded
into family F's packet on an explicitly *verification* ground: E5 and F2 are the
programme's two no-output-word classes, and "a defect in the shared no-output
path would have to be scored against **both** to be understood… in separate
packets they get separate freezes and separate denominators, and a mutation
seeded against one cannot be scored against the other." **F-c8 is that defect,
and this row of the matrix is the folding argument being cashed**: three units
across two families die together, and — the discriminating half — **T-E1 stays
green**, because a frame that delivers octets is pinned to its own `tlast` cycle
and that pin does not move. A campaign in which T-E1 also reddens has seeded
something wider than the intent.

**(f) F-c2's nine-unit kill is a measurement, not an accident.** The runt
threshold's upper boundary sits at 64 octets, and **nine of the twenty units
drive a 64-octet frame**, because the legal minimum is what almost every earlier
row was built from. So M03-F4's *primary* declared kill is massively
over-determined — which means **M03-F4's unique contribution is not the boundary
but its adjacency construction**: two frames one octet apart in one schedule,
where the delivered counts are 59 and 60 and only the strobe and the abort bit
separate them. That is worth knowing before a sign-off packet credits F4 with the
boundary.

**(g) T-E1 must stay green under F-c1, and the reason is not "it is family E".**
E1's frames deliver 24–31 octets — inside F-c1's 5-to-63 band by count — but they
are closed by `/E/`, and REQ-103 forbids FCS removal on the abort path, so there
is no removal for the mutation to suppress. Whether the diff is gated on the
runt disposition or on the received count, this cell is green either way.

**(h) The embedded model-vs-hand cross-checks must stay silent under all eight.**
`cross_check_f2` (in `run_f2`) and `cross_check_e5` (in `run_e5`) compare
hand-derived values against `Dv_xgmii.Injection`'s model — **both of which live
in `test/`**, and neither of which an RTL mutation can touch. They also run
**before** `Bench.run` is called. **A `fail_cross` message anywhere in this
campaign is a FINDING**, and would mean something other than the seeded defect
moved. The campaign is structurally unable to produce one. (Third campaign with
this condition named; it has never fired.)

## 5. Bounds this campaign does NOT close, named before the result

1. **M03-F5's own declared kill is not seeded.** F5 — `< 5` read as `<= 5`,
   emitting nothing for the 5-octet boundary frame — was **discharged by citation
   to M03-C4** (`WO-0047` §3.3), and no class here seeds that boundary. F-c1's
   kill of T-C4 is *evidence that C4 has teeth on the runt path*, and it is not
   proof that the citation holds. **The discharge-by-citation remains
   unqualified**, and a future round may want the lower-boundary off-by-one for
   exactly that purpose. Stated so no sign-off packet reads this campaign as
   having qualified it.
2. **M03-F1 is exercised at four lengths and fails fast**, so a kill demonstrates
   the row convicts at its **first** case (lane 0, length 5), not at all eight.
   The breadth is exercised on green runs only. Same bound family E carried, and
   §3's F-c1 paragraph is what it looks like when it bites.
3. **F-c2 is seeded on the received-count reading only.** The delivered-count
   reading of the same threshold is not seeded (`WO-0050` §2 says so and why).
4. **REQ-107's positive direction below five octets rests entirely on T-F2**, one
   unit, at three values of `k`. That is the whole of the sub-five coverage in
   this programme.

## 6. Weighting

**Three of the eight — F-c6, F-c7, F-c8 — carry full blinding including their
intents**, which were never shown to the bench author because the rows they
attack were already written. **The other five carry the family-E blinding**:
intents published in `WO-0047` §8, row mapping and MUST-STAY-GREEN columns and
messages sealed together.

**No discount is available in adjudication for any of the eight**, and equally no
excuse. A class that fails to land is a bench finding, full stop.

## 7. Pass criteria

1. The suite goes red on **F-c1 … F-c5, F-c7 and F-c8**. **F-c6 is exempt** and
   its green outcome is pre-disposed in §3.
2. Red in the REQUIRED units **with the expected message**, and no
   MUST-STAY-GREEN unit reddens. Either half violated is a **finding**,
   adjudicated, never silently scored as a pass.
3. The unmutated control is green — established at `616686f` itself, CI run
   **30826473824**, conclusion success.

**F-c5 and F-c7 are the classes this round was written for.** A family F that
does not die on F-c5 has closed nothing, and an M03-E5 that does not die on F-c7
was not worth adding.

## 8. Not to be told

§1's unit table, §2's matrix — above all its MUST-STAY-GREEN columns — §3's
messages including F-c3's and F-c6's admissible pairs and F-c8's `Y − X = 1`,
§4's reasoning, §5's bounds, §6's weighting, and the cross-check finding
condition.

**Freely told, and told**: the eight intents, the minimality and fidelity
requirements, F-c6's pass-criterion exemption and its pre-committed disposition,
the allowlist and process bars, the F2 stimulus-superset artefact, the return
format, and the plain warning that F-c5 and F-c7 will look quiet.
