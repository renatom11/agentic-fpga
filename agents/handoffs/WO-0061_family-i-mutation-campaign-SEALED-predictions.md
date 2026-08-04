# WO-0061 SEALED: dv_lead's frozen predictions for the family-I qualification campaign

> **SEALED.** The auditor must not open this file until all ten diffs are
> committed — and under `WO-0061` §2's allowlist, **all of `agents/**` is out of
> bounds for the campaign's duration**, this file included and absolutely.

- **State**: **FROZEN — unopened.**
- **Frozen against**: **`42b9df3`** — the SHA the green control run actually
  executed (CI run **30920890962**, **both jobs** green, `build` including its
  Generate-RTL and determinism steps and the blocking `cosim`). No byte-identity
  inference is needed: `git diff 42b9df3 172347c -- test/ libs/ tools/
  dune-project` is **empty**.
- **Frozen by**: dv_lead, `J-dv_lead-0095`, **before any diff existed**, in the
  commit that stages this file beside its packet (R-SEAL-1, ADR-0016).
- **Second copy**: the class → REQUIRED-red **row mapping** (not the message
  strings) is restated in `J-dv_lead-0095`.
- **Standing rule of this file, from `RV-0055` FINDING G-1**: **every sealed
  cell that rests on a claim about the DUT's state cites the stimulus fact that
  establishes that state, or is marked UNWORKED.** G-1 was a cell asserted from
  a category with the discriminating quantity unchecked; GH-1 was the same error
  one campaign later, in the very file whose §4(a) had repaired it. Every state
  claim below carries its arithmetic or its guard, by file and line.
- **Second standing rule, this file's own**: every message below is the **first
  assertion to speak**, derived from the row's committed control flow and
  iteration order — never from what the row is "about". `test_m03_i.ml`'s
  iteration orders are load-bearing and are stated in §1.

## 0. The denominator, re-measured at the freeze

The same `grep 'let%expect_test'` inventory `tools/dv_checks.sh` reports, run at
this tree:

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

**36 M03 units; 116 repository-wide; 80 non-M03.** The repo-wide figure moved
from `WO-0058`'s 111 by exactly the five units of `test_m03_i.ml`, so the
**non-M03 set is the same 80 units** three prior campaigns measured.

**Blast radius.** Only `test/xgmii_rx_64/dune` declares `hardcaml_ethernet`
among the bench libraries containing `%expect_test`s that reach M03;
`test/monitors`, `test/xgmii`, `test/golden`, `test/axi64_probe` and
`test/xgmii_probe` are DUT-independent by their own dune stanzas, and
`test/cosim/**` contains no `%expect_test` at all. **A unit outside the 36
reddening is a build-level finding, never a behavioural one.**

## 1. The thirty-six units, and the three iteration orders every message depends on

| id | file | row(s) |
|---|---|---|
| T-A12, T-A34, T-A5 | `test_m03_a.ml` | M03-A1/A2, M03-A3/A4, M03-A5 |
| T-B1 | `test_m03_b.ml` | M03-B1 |
| T-C12, T-C3, T-C4, T-C5 | `test_m03_c.ml` | M03-C1/C2, M03-C3 (1518), M03-C4, M03-C5 (1513, 1516) |
| T-D1, T-D2, T-D3 | `test_m03_d.ml` | M03-D1 / D2 / D3 |
| T-E1, T-E2, T-E4, T-E5 | `test_m03_e.ml` | M03-E1 / E2 / E4 / E5 |
| T-F1 … T-F4 | `test_m03_f.ml` | M03-F1 … F4 |
| T-G1, T-G2, T-G3, T-G4, T-G6, T-G7, T-G8 | `test_m03_g.ml` | M03-G1 … G8 (no G5 unit) |
| T-H1, T-H2, T-H3, T-H4 | `test_m03_h.ml` | M03-H1 … H4 |
| **T-I1** | `test_m03_i.ml` | **M03-I1 — 1000+ idle cycles, then a liveness frame** |
| **T-I2** | `test_m03_i.ml` | **M03-I2 — the drain window, 4 members** |
| **T-I3** | `test_m03_i.ml` | **M03-I3 — the `/Q/` ordered set, 2 lanes × 2 runs** |
| **T-I4** | `test_m03_i.ml` | **M03-I4 — 48 injected runs + 16 baselines** |
| **T-I6** | `test_m03_i.ml` | **M03-I6 — 4 runs at 7 idles** |
| T-ST | `test_m03_structural.ml` | M03-L6 (elaboration + idle cycles) |

**The five in bold are the scored set.** Three iteration orders decide which
member of a looping row speaks, and every message in §3 depends on them:

1. **M03-I2** (`test_m03_i.ml:511–563`): member (i) lane 0 → member (i) lane 4
   → member (ii) lane 0 → member (ii) lane 4. **The first member is
   `M03-I2 (member i, 64 octets, lane 0)`**, terminate cycle 10, boundary 13.
2. **M03-I4** (`:1285–1296`): lane 0 then lane 4; inside a lane, lengths 64…71
   ascending; inside a length, the **un-injected baseline run first**
   (`run_i4_length_lane`), then idles 0, 1, 7. So the first run of the whole
   unit is `M03-I4 baseline (length 64, lane 0)`; the first **injected** run is
   `(length 64, lane 0, idles 0)`, which is the **identity map** and can move
   under no injection-gated class; the first run any injection-gated class can
   reach is **`M03-I4 (length 64, lane 0, idles 1)`**.
3. **M03-I6** (`:1617–1624`): lane 0 length 64, lane 0 length 1518, lane 4
   length 64, lane 4 length 1518. **First run: `M03-I6 (length 64, lane 0)`**;
   the first run that can cross REQ-108 is `(length 1518, lane 0)`.

**The wrapper's own arithmetic, needed by nine of the ten classes**
(`test/xgmii/idle_injection.ml:142–156`): `uniform` places `idles` idle words at
every boundary `before_cycle` from `first_octet_cycle + 1` through the terminate
character's own cycle. At **every** length in M03-C1's directed set at a lane-0
start: `first_octet_cycle` = 2 and `terminate_cycle` = 10, so **8 boundaries**;
at `idles = 1` that is **8 injected idle words strictly inside the frame**, at
`idles = 7`, **56**. For M03-I6's 1518-octet member at lane 0:
`terminate_cycle` = (8 + 8 + 1518)/8 = **191**, so 189 boundaries and **1323**
injected idle words.

## 2. The matrix

`R` = REQUIRED red. `G` = MUST STAY GREEN. Anything off-pattern is a **finding**.
Columns marked *fn* are a **function of the seeder's disclosure** (§5); the value
shown is the **narrow / nominal** branch, which is the class as `WO-0061` §3
specifies it.

| unit | I-c1 *fn* | I-c2 *fn* | I-c3 | I-c4 *fn* | I-c5 | I-c6 *fn* | I-c7 | I-c8 *fn* | I-c9 *fn* | I-c10 |
|---|---|---|---|---|---|---|---|---|---|---|
| T-A12, T-A34, T-A5 | G | G | G | G | G | G | G | G | G | **R** |
| T-B1 | G | G | G | G | G | G | G | G | G | **R** |
| T-C12, T-C3, T-C4, T-C5 | G | G | G | G | G | G | G | G | G | **R** |
| T-D1, T-D2, T-D3 | G | G | G | G | G | G | G | G | G | **R** |
| T-E1, T-E2, T-E4, T-E5 | G | G | G | G | G | G | G | G | G | **R** |
| T-F1 … T-F4 | G | G | G | G | G | G | G | G | G | **R** |
| T-G1, T-G2, T-G3, T-G4 | G | G | G | G | G | G | G | G | G | **R** |
| **T-G6** | G *(§5.8)* | G *(§5.8)* | G *(§5.8)* | G *(§5.8)* | G *(§5.8)* | G *(§5.8)* | G *(§5.8)* | G | G | **R** |
| T-G7, T-G8 | G | G | G | G | G | G | G | G | G | **R** |
| T-H1 … T-H4 | G | G | G | G | G | G | G | G | G | **R** |
| **T-I1** | G | G | G | G | G | G | G | **R** | G | **R** |
| **T-I2** | G | G | G | G | G | G | G | G | G | **R** |
| **T-I3** | G | G | G | G | G | G | G | G *(§5.7 iv R)* | **R** | **R** |
| **T-I4** | G *(§5.1 R)* | **R** | **R** | **R** | **R** | **R** | **R** | G *(§5.7 v R)* | G | **R** |
| **T-I6** | **R** | **R** | **R** | **R** | **R** | **R** | **R** | **R** | G | **R** |
| T-ST | G | G | G | G | G | G | G | G | G | **G** |
| **red count (nominal)** | **1** | **2** | **2** | **2** | **2** | **2** | **2** | **2** | **1** | **35** |
| **MUST-STAY-GREEN (M03)** | **35** | **34** | **34** | **34** | **34** | **34** | **34** | **34** | **35** | **1** |
| **+ non-M03, every class** | **80** | **80** | **80** | **80** | **80** | **80** | **80** | **80** | **80** | **80** |

**Fifty-one REQUIRED cells on the nominal branches; 309 of the 360 M03 cells
(10 classes × 36 units) must stay green; 800 non-M03 must-stay-green cells
(10 × 80).** The wide branches move these counts and are tabulated in §5.

## 3. Expected messages

Every message is quoted as the row composes it: `<row prefix>: <text>`. Numeric
fields that are the **mutant's own value** are marked; every other character is
exact.

### I-c1 — the octet count does not hold (narrow branch: the threshold comparison only)

| unit | message |
|---|---|
| **T-I6** | `M03-I6 (length 1518, lane 0): an error strobe pulsed -- idle injection must not change which REQ-107/REQ-108 class this frame falls into` |

**Why the 1518 member and not the 64-octet one, which runs first.** With 7 idle
cycles at each of 8 boundaries, the 64-octet member's inflated count reaches
64 + 56 × 8 = **512** — above REQ-107's 5-octet floor and far below REQ-108's
1518 — so **the frame does not change class and the member stays green.** The
1518-octet member's inflated count reaches 1518 + 1323 × 8 ≈ **12 100**, which
crosses REQ-108 by three orders of magnitude. **The same arithmetic is why T-I4
is green on this branch**: its longest frame is 71 octets and its heaviest
injection adds 8 × 56 = 448, for 519 — the directed set cannot reach 1518 under
any commissioned idle figure.

**Why the strobe arm and not something earlier.** On the narrow branch the
delivered extent, the word count, every cycle, `tkeep` and `tuser` are
untouched, so `run_i6_case`'s structural assertions (`:1562`, `:1572–1592`,
`:1594`, `:1596`, `:1600`) all pass and `error_pulses` (`:1607`) is the first
thing that can differ.

### I-c2 — the CRC register does not hold

| unit | message |
|---|---|
| **T-I4** | `M03-I4 (length 64, lane 0, idles 1): tuser[0] set -- FCS content is unchanged by injection, expected a clean verdict` |
| **T-I6** | `M03-I6 (length 64, lane 0): tuser[0] set -- expected a clean FCS verdict, this frame's own class is unchanged` |

**Why `tuser` and not the strobe, worked rather than assumed.** A corrupted
residue produces both a `tuser`[0] marking on the `tlast` word and an
`error_bad_fcs` pulse, and the rows check them in that order: `tuser` at
`:1097` (M03-I4) and `:1596` (M03-I6), `error_pulses` at `:1156` and `:1607`.
Everything before `tuser` — word count, per-word cycle, `tkeep`, `tlast`
position, the `tlast` word's own cycle — is untouched by a residue-only defect.

**Why the first case is `idles 1` and not `idles 0`.** At `idles = 0` the
wrapper places **no** sites (`idle_injection.ml:153`, `if idles = 0 then []`),
so there is no held cycle for the class to fire on and the run is the identity.

### I-c3 — a held cycle produces an output word

| unit | message |
|---|---|
| **T-I4** | `M03-I4 (length 64, lane 0, idles 1): expected 8 output words, got 16` |
| **T-I6** | `M03-I6 (length 64, lane 0): expected 8 output words, got 64` |

**The counts are derived, not guessed.** At (64, lane 0, idles 1) the wrapper
puts **8** idle words strictly inside the frame (§1); decoded as eight data
octets each they add 64 received octets, so the mutant's frame is 128 received
→ 124 delivered (REQ-103's FCS removal) → ⌈124/8⌉ = **16** output words against
the conformant 8. At M03-I6's (64, lane 0) the figure is 56 idle words → 448
octets → 512 received → 508 delivered → ⌈508/8⌉ = **64**.

**Adjudication rule, fixed here**: the cell is scored on **the word-count guard
with an observed count strictly greater than the expected one**. The observed
value is the mutant's; a value other than 16 / 64 is a rendering fact to be
recorded with the disclosure, **not** a bench finding. A **different assertion**
speaking is a finding.

### I-c4 — a held cycle raises a condition

| unit | message |
|---|---|
| **T-I4** | `M03-I4 (length 64, lane 0, idles 1): an error strobe pulsed -- an idle-injected clean frame must not trip one` |
| **T-I6** | `M03-I6 (length 64, lane 0): an error strobe pulsed -- idle injection must not change which REQ-107/REQ-108 class this frame falls into` |

**Why nothing earlier speaks.** The intent leaves content, count, cycles,
`tkeep`, `tlast` and the FCS verdict untouched; the delay-identity loop
(`:1133–1155`) reads shifts off raw octet times and is likewise untouched. The
first divergence is the strobe check. **This is the quiet class**: it agrees
with every positive assertion in both rows.

### I-c5 — a held cycle closes the frame

| unit | message |
|---|---|
| **T-I4** | `M03-I4 (length 64, lane 0, idles 1): expected 8 output words, got 1` |
| **T-I6** | `M03-I6 (length 64, lane 0): expected 8 output words, got 1` |

**Why exactly one word, at both, on both closure paths.** The wrapper's first
site is `before_cycle = first_octet_cycle + 1 = 3` (§1), so the first idle word
arrives **after** the source word carrying frame octets 0–7 (source cycle 2,
octet times 16–23). A receiver that closes on it has received **8 octets**. On
the `/T/`-like path REQ-103 removes four and delivers 4 → one output word
(`tkeep` = 0x0F); on the `/E/`-like abort path REQ-103's no-removal clause
delivers all 8 → one output word (`tkeep` = 0xFF). **Either way ⌈·/8⌉ = 1**, and
the two paths differ only in fields the count guard reaches first. Nothing later
in the stimulus reopens a frame — there is no second `/S/` anywhere in either
row's schedule — so the count stays at 1.

**Adjudication rule**: scored on the word-count guard with an observed count
**strictly less** than expected; the exact value is the mutant's.

### I-c6 — silent content corruption at the held-cycle boundary (signature reading)

| unit | message |
|---|---|
| **T-I4** | `M03-I4 (length 64, lane 0, idles 1): delivered octets differ -- REQ-016 must not alter frame content` |
| **T-I6** | `M03-I6 (length 64, lane 0): delivered octets differ -- REQ-016 must not alter frame content` |

**Why the content assertion can fire at all — i.e. why the substituted octets are
guaranteed to differ from the true ones.** The idle word's lanes carry
`Xgmii_word.idle_char` = **0x07**. `directed_frame_octets ~length` builds octet
*j* as `(length * 3 + 5j + 7) land 0xFF` (`bench.ml:276–282`); at length 64 that
is `(199 + 5j) mod 256`, which equals 7 only at **j = 64** — 5 is invertible mod
256 (5⁻¹ = 205) and 64 × 205 ≡ 64 — and the delivered payload runs j = 0…59.
**No delivered octet of this frame is 0x07**, so any substitution is visible.

**Why `tuser` does not speak first here and does under I-c2.** The signature
reading leaves the CRC computed over the frame's true octets, so the verdict
stays clean and the checks at `:1097` / `:1596` pass; the content comparison
(`:1101` / `:1600`) is the next thing that can differ. **This is the one class
in the campaign whose detector is the delivered-octet equality** —
`J-dv_lead-0093`'s second named kill for the count-guard-blind class.

### I-c7 — the output word is emitted on the superseded evidence

Quoted in a block rather than inline, because both texts contain backticks of
their own and the seal's exactness is character-level:

```
T-I4:  M03-I4 (length 64, lane 0, idles 1): word 0 arrived on cycle <mutant>, expected 5 (SPEC-M03 §6.1's D(m) (`1f3c04c`): baseline_cycle(m) + (cycle_of(D m) - D m), not m + 3 alone -- M03-I5)

T-I6:  M03-I6 (length 64, lane 0): word 0 arrived on the wrong cycle (SPEC-M03 §6.1's D(m) (`1f3c04c`): baseline_cycle(m) + (cycle_of(D m) - D m), not m + 3 alone)
```

**`expected 5` is exact and is derived here rather than read off a run.**
`D(0) = (start_octet_time + 8 + 8·0 + 12)/8 = (8 + 8 + 12)/8 = 3`
(`dependency_source_cycle`, `:954`). The wrapper's sites begin at
`before_cycle = 3`, so source cycle 3 lands at injected cycle 4 and the shift is
`cycle_of(3) − 3 = 1`. `baseline_cycle(0) = start_cycle + 3 = 4`, so the
conformant injected cycle is **5**. Under the superseded rule the deciding word
is the one carrying word 0's **own last octet** — content index 7, octet time
23, source cycle **2**, which has no site at or before it — so the shift is 0
and the mutant emits at **4**. **The predicted observed value is 4 and the
sealed requirement is `<mutant> < 5`**: any early value scores the cell, a value
≥ 5 is a finding.

**Why word 0 and not a later word, and why the whole loop does not matter.** The
per-word loop (`:1069`) tests in ascending m and every non-`tlast` word is early
under this class, so **m = 0 speaks**. The `tlast` word never moves (its
evidence is the closing character under both rules), which is why the class
cannot be confused with BUG-0002's or BUG-0003's defects.

**Why M03-I6's message carries no numbers.** `run_i6_case`'s cycle message
(`:1580–1585`) omits the observed and expected values; M03-I4's (`:1077–1086`)
carries both. That asymmetry is the bench's, is recorded here so it is not read
as a wrong message, and is the reason the exact-value prediction is sealed at
M03-I4 alone. (At M03-I6 the conformant value for word 0 at (64, lane 0) is
4 + 7 = **11**; the row simply does not print it.)

### I-c8 — a spurious output word out of an empty pipeline (nominal branch: 100 < T ≤ 1001)

| unit | message |
|---|---|
| **T-I1** | `M03-I1: expected 8 output words after the idle window, got <mutant>` (> 8) |
| **T-I6** | `M03-I6 (length 1518, lane 0): expected 190 output words, got <mutant>` (> 190) |

**Why T-I1's headline absence scan does NOT speak, and this is the campaign's
sharpest shadowing prediction.** `run_i1` checks the total delivered-word count
(`:290`) **before** it scans the idle prefix for a spurious `tvalid` (`:334`),
and `delivered_samples` counts every `tvalid` cycle in the run — so a spurious
word in the idle window breaks the **count** first. The idle-prefix scan can
only ever speak for a defect that both adds a word inside the window and removes
one elsewhere. `WO-0061` §4.5 binds the adjudication to score this as exact.

**Why T-I6 and not T-I4 on this branch.** Trailing idle runs, derived from
`drain = Idle_injection.injected inj + 8` (`:1050`, `:1557`): M03-I6's 1518-octet
member at lane 0 injects 1323 idle words → **1331** drain cycles (lane 4: 1330 →
1338); its 64-octet members inject 56 → **64**. M03-I4's heaviest run injects 56
(lane 0) or 63 (lane 4, lengths ≥ 68) → at most **71**. M03-I3's gap is
**100** cycles; M03-I1's prefix is **1001**; every other unit's longest idle run
is its 8-cycle drain. So a threshold in (100, 1001] is seen by M03-I1's prefix
and M03-I6's 1518 drains and by nothing else.

**Why the 1518 member speaks at M03-I6 rather than the 64-octet member that runs
first**: 64 < T, so that member is green — the same shape of derived green as
I-c1's.

### I-c9 — the ordered set is not ignored (branch (a): it opens a frame or emits)

| unit | message |
|---|---|
| **T-I3** | `M03-I3 (lane 0): overlay frame 2: expected 8 output words, got <mutant>` |

**Why "overlay frame 2" and not frame 1, and not the in-window scan.** The
window is cycles **13…112** (`:701–707`, guarded); frame 1's `tlast` is at cycle
11 (64 octets, r = 0, `start_cycle + 3 + 7`), so every word the ordered set
provokes lands **after** frame 1's `tlast` and is swallowed by
`split_at_first_tlast`'s remainder (`:771–772`). `assert_clean_frame_structure`
for **overlay frame 1** therefore passes, and the count check inside the call for
**overlay frame 2** (`:637`, label `"overlay frame 2"`) is the first thing that
can differ. Frame 2 is 68 octets → 64 delivered → **8** expected words.
The row's own in-window `tvalid` scan (`:796`) sits two calls later and is
shadowed, exactly as `WO-0061` §4.5 predicts.

**Why the baseline run stays green and what that proves.** The baseline drives
the same schedule with an **idle** gap and no `/Q/` anywhere, so no branch of
this class can fire in it. A red confined to the overlay is the proof that the
overlay stimulus reaches the design — the anti-vacuity fact M03-I3's
construction exists to guarantee.

### I-c10 — a spurious strobe at every clean frame's closure

| unit | message |
|---|---|
| **T-I1** | `M03-I1: an error strobe pulsed somewhere in this run -- a long idle window followed by a clean frame must not trip one` |
| **T-I2**, offset ≤ +2 | `M03-I2 (member i, 64 octets, lane 0): an error strobe pulsed on a clean frame` |
| **T-I2**, offset ≥ +3 | `M03-I2 (member i, 64 octets, lane 0): a strobe pulsed at or after cycle 13 (REQ-109, C-14.3)` |
| **T-I3** | `M03-I3 (lane 0): baseline: an error strobe pulsed on an idle-only gap` |
| **T-I4** | `M03-I4 baseline (length 64, lane 0): an error strobe pulsed on the plain, un-injected baseline run` |
| **T-I6** | `M03-I6 (length 64, lane 0): an error strobe pulsed -- idle injection must not change which REQ-107/REQ-108 class this frame falls into` |

Thirty further M03 units are **REQUIRED red with UNWORKED messages** (§4(e)).
**T-ST is GREEN**: `test_m03_structural.ml` opens no frame at all, so there is no
closure for the pulse to attach to.

**Why M03-I4's *baseline* row speaks and not an injected one.** The first
simulation in the whole unit is `run_i4_length_lane`'s un-injected baseline at
(64, lane 0), and its own `error_pulses` check (`:1267`) precedes every injected
case. The row prefix is therefore `M03-I4 baseline (...)`, which is a different
string from every other M03-I4 message in this file.

**Why M03-I1's prefix scan does not speak.** The pulse attaches to the liveness
frame's closure at cycle ≈ 1011, which is **after** `start_cycle` = 1001, so it
is outside the idle prefix (`:281`) the scan at `:340` covers; `error_pulses`
(`:346`) is next.

**Why the offset decides M03-I2's message, and why that is the campaign's one
measurement of C-14.3.** `run_i2_member` computes `boundary = terminate_cycle +
3` (`:404`) and scans the tail at or after it (`:483–504`) **before** the
run-wide `error_pulses` check (`:505`). Member (i) at lane 0 has
`terminate_cycle` = 10 and `boundary` = 13. A pulse at + 1 or + 2 lands at cycle
11 or 12, is invisible to the tail scan, and is caught by the run-wide check
every row in the bench has. **A pulse at + 3 or later lands at or after 13 and is
caught by the tight window and by nothing else** — that is precisely the
coverage C-14.3's tightening bought, and it has never been exercised.

## 4. Reasoning for the cells that are not obvious

**(a) Why every unit outside T-I4 and T-I6 is GREEN under the seven held-cycle
classes — derived from the stimulus inventory, not from a category.** A held
cycle is *"an input word covering no frame octet"* arriving inside an open
frame. Measured over the whole bench:

- `Dv_xgmii.Idle_injection` reaches a DUT in **one file only**,
  `test_m03_i.ml` (`:1052`, `:1559`); `test/xgmii/test_idle_injection.ml`
  exercises the library and instantiates no design.
- Every other schedule's words come from `Arrival.word_at`, which fills a
  frame's own cycles with that frame's octets by construction, so no idle word
  can appear inside an open frame there.
- The `?word_at` overlays outside family I substitute **characters within** a
  word and never present an all-idle word inside an open frame: M03-B1's
  preamble octets (`test_m03_b.ml:30–51`), families E/F/G/H's `Injection`
  placements, and M03-G6's single-lane substitution.
- **The one near-miss, named rather than left to surface**: `run_g6`
  (`test_m03_g.ml:1099–1107`) replaces frame 1's terminate **lane** with
  `idle_char` in an otherwise-data word. Two facts keep T-G6 green on the narrow
  branches: the word still carries seven frame octets, so it is **not a held
  cycle** under §6.2's own definition; and by that cycle the receiver has been in
  **`Discard`** since the count passed 1518, 82 octet times earlier (the frame is
  1600 octets), so it is not in `Frame` either. **§5.8 is the branch that covers a
  gate loose enough to reach it.**

**(b) I-c2 and I-c6 are separated by exactly one datum, recorded before the
result.** Both corrupt something on the held-cycle boundary; I-c2 moves the
**verdict** (`tuser`[0], `error_bad_fcs`) and leaves the octets, I-c6 moves the
**octets** and leaves the verdict. Their row sets are identical — `{T-I4, T-I6}`
— and only the message discriminates: `tuser[0] set …` against `delivered octets
differ …`. **If both classes report the same message at the same unit, the
campaign has measured one defect twice** and the scorecard says so rather than
recording two kills. This is the sixth campaign in which row sets do not
discriminate and messages do (D-M1/D-M4/D-M5, E-c3/E-c5, F-c3/F-c5/F-c6,
G-c1/G-c3/G-c5, GH-c5/GH-c6, now I-c2/I-c6).

**(c) I-c2 and I-c4 collide if and only if the seeded condition also marks
`tuser`.** I-c4 pulses a strobe and moves nothing else; if its rendering also
sets `tuser`[0] on the `tlast` word, its M03-I4 message becomes I-c2's exactly.
The disclosure that decides it is I-c4's *"which strobe, and on which cycle"*
plus whether `tuser` moves. Same rule as (b): identical messages at identical
units are one detection.

**(d) I-c3 and I-c5 share an instrument and are separated by the DIRECTION of
the count.** Both speak at the word-count guard at both units; I-c3's observed
count **exceeds** the expected (the frame grew), I-c5's is **strictly below**
(the frame was cut). If both produce the **same** observed count at the same
unit, one defect has been measured twice. The direction is not a matter of
taste: it is the sign of the octets the held cycle contributes.

**(e) I-c10's thirty-five REQUIRED cells, and why thirty of them are UNWORKED on
purpose.** The trigger is *"a frame closes"*, which every M03 unit except T-ST
provides; so the reach is derivable in one line and the **messages are not** —
each of the thirty non-scored rows has its own assertion order and its own
strobe-set idiom, and thirty derivations bought with an afternoon would be
thirty chances to make G-1's error again. **Adjudication rule, fixed here**: at
those thirty units a **red is predicted blast radius, contributes zero
additional kills, and is not an unnamed-unit finding**; a **green is a FINDING**
— it would mean a row that cannot see a spurious strobe on its own frame's
closure, which is a coverage fact worth having and is adjudicated per row rather
than scored against this class.

**(f) The idiom correlation, stated because §4.1 binds the scorecard to state
it.** Four classes (I-c1, I-c4, I-c9 branch (b), I-c10) are ultimately caught by
"a strobe pulsed that the row's own text says must not"; three (I-c3, I-c5, and
I-c1 on its wide branch) by the word-count guard; one (I-c2) by the FCS verdict;
one (I-c6) by delivered content; one (I-c7) by the per-word cycle. So the
campaign probes **five instrument families at ten stimuli geometries**, and the
scorecard reports it that way rather than as ten independent measurements of ten
properties.

**(g) The monitors, and the one cell that can reach them.** In M03-I1, M03-I2,
M03-I4 and M03-I6 every row-local assertion precedes `assert_monitors_clean`
(`:358`, `:508`, `:1235`, `:1614`), so a reddening row never reaches a monitor.
**M03-I3 is the exception**: `assert_monitors_clean overlay_bench` (`:789`) runs
**before** the in-window scan (`:793`), so a strobe-only rendering of I-c9 is
**monitor-caught**. Its message is the strobe monitor's, `M03-I3 (lane 0)
overlay: strobe monitor unclean:` followed by the report, whose unexpected-pulse
line has the form `cycle <c>: M03 rx pulsed "<strobe>" and no expected event
claims it — a strobe the stimulus did not create (requirements.md §0.6,
REQ-008)` (`strobe_monitor.ml:178–184`). **That kill is reported as one
detection and the row's own in-window strobe scan is recorded as blind to it.**

**(h) The count-guard identity of `J-dv_lead-0093`, and why it decides no cell
here.** At a **lane-4** start a conformant emission mechanism fires exactly `W`
times per frame, so the word-count guard cannot disagree there and the
`tlast`-position check is blind with it. Three facts keep that out of this seal:
the identity constrains **emission-timing** defects (I-c7's class), not defects
that change how many octets the design believes it received (I-c1, I-c3, I-c5);
**every sealed cell in this file lands at a lane-0 case**, because both looping
rows drive lane 0 first; and I-c7's own detector is the **cycle** guard, not the
count guard. The identity is therefore live as a caution and idle as an
adjudicator. (The two bench notes it earned — the identity at the count guard's
own sites, and guard ordering — remain owed at the next round that opens
`test/xgmii_rx_64/` for editing, per `J-dv_lead-0094`.)

**(i) `fail_cross` and the stimulus guards cannot fire under any class here, and
their silence is not coverage.** `Idle_injection.is_clean`, `errors`,
`c45_sites` and every `test bug --` guard in the file are evaluated on the
bench's own model of the stimulus before or independently of the DUT
(`:1025–1039`, `:1540–1550`, `:1000–1020`). **No RTL mutation can move them.** A
`test bug --` message appearing in this campaign means something other than the
seeded defect and is a finding of its own kind.

**(j) M03-I4's expect block will diff at every red, and no cell is scored on
it.** `Stdlib.print_string` at `:1234` runs at the end of each completed case, so
a raise partway through the 64 simulations leaves a truncated report against the
promoted block. That diff accompanies **every** M03-I4 red mechanically;
`WO-0061` §4.4 fixes that the raised message alone scores the cell.

## 5. The disclosure functions — sealed branch by branch

`WO-0061` §3's second and third standing clauses require the seeder to state what
each diff reaches. **The mapping below is the prediction; the seeder cannot see
it, and every branch of it is exact.** If an observed row set matches **none** of
a class's branches, that is a **finding** — either my enumeration was incomplete
or the diff reaches further than the class it names.

### 5.1 I-c1 — branches on which consumers the moved counter feeds

| disclosed reach | REQUIRED | MSG (M03) |
|---|---|---|
| **(i) narrow** — REQ-107/REQ-108 threshold comparison only | **T-I6** | 35 |
| **(ii) wide** — the same counter also feeds REQ-103's delivered extent | **T-I6, T-I4** | 34 |

On branch (ii) the design believes every injected frame is longer than it is, so
**T-I4 reddens at (length 64, lane 0, idles 1)** and T-I6's **first** failing run
moves forward to (length 64, lane 0). Which assertion speaks then depends on
whether the inflated extent reaches the **word count** or only the `tlast`
word's **`tkeep`**:

- word count reached: `M03-I4 (length 64, lane 0, idles 1): expected 8 output
  words, got <mutant>` (> 8);
- `tkeep` only: `M03-I4 (length 64, lane 0, idles 1): word 7 tkeep does not match
  the expected pattern`.

**UNWORKED sub-branch, adjudication fixed here**: either message scores the T-I4
cell; which of the two appeared is recorded as a rendering fact. **This is the
only branch in the campaign that exercises the `tkeep` instrument at an injected
run** (`WO-0061` §8 bound 1).

### 5.2 I-c2 — branches on whether the delivered octets move with the verdict

| disclosed reach | REQUIRED | MSG (M03) |
|---|---|---|
| **(i) narrow** — the residue only | **T-I4, T-I6** | 34 |
| **(ii) wide** — the delivered octets move too | **T-I4, T-I6** | 34 |

The row set is identical; **only the message discriminates**, and on branch (ii)
it is still the `tuser` message, because the verdict is checked before the
content at both units (§3). **So branch (ii) makes I-c6's instrument
unreachable through this class** and §4(b)'s collision rule governs.

### 5.3 I-c3 — branches on what moves with the forwarded octets

| disclosed reach | REQUIRED | MSG (M03) |
|---|---|---|
| **(i) count and CRC move with the octets** (the natural rendering) | **T-I4, T-I6** | 34 |
| **(ii) octets forwarded, count and CRC held** | **T-I4, T-I6** | 34 |

Same row set, same messages, same instrument: the word count moves either way
and speaks first. The branch is recorded because it changes **nothing
observable**, and a seal that pretends a distinction it cannot see is worse than
one that says so.

### 5.4 I-c4 — branches on whether the raised condition also marks the frame

| disclosed reach | REQUIRED | MSG (M03) |
|---|---|---|
| **(i) narrow** — a strobe only | **T-I4, T-I6** | 34 |
| **(ii)** — the strobe also sets `tuser`[0] | **T-I4, T-I6** | 34 |

On branch (ii) the M03-I4 message becomes `tuser[0] set -- FCS content is
unchanged by injection, expected a clean verdict` — **I-c2's cell, character for
character** — and §4(c) governs.

### 5.5 I-c5 — branches on the closure path

| disclosed reach | REQUIRED | MSG (M03) |
|---|---|---|
| **(i) `/T/`-like** — runt and FCS checks sequenced | **T-I4, T-I6** | 34 |
| **(ii) `/E/`-like** — abort with `tuser`[0] marking | **T-I4, T-I6** | 34 |

Identical row sets and identical messages (§3's derivation gives one output word
on both paths). The disclosure is required anyway, because it decides whether a
strobe also pulses — which would be **invisible here** (the count guard speaks
first) and is exactly the sort of silent extra reach that must be on the record
before it is discovered.

### 5.6 I-c6 — branches on whether the verdict survives

| disclosed reach | REQUIRED | MSG (M03) |
|---|---|---|
| **(i) signature** — verdict clean, octets wrong | **T-I4, T-I6** | 34 |
| **(ii)** — the residue moves too | **T-I4, T-I6** | 34 |

On branch (ii) the messages become I-c2's `tuser` pair and §4(b) governs. **The
delivered-octet instrument is then unexercised by the whole campaign** — named
in `WO-0061` §8 bound 1 as the thing that would leave `J-dv_lead-0093`'s
two-kills claim half measured.

### 5.7 I-c8 — branches on the disclosed threshold T

Derived from the trailing- and leading-idle-run inventory in §3.

| disclosed T (idle cycles) | REQUIRED | MSG (M03) |
|---|---|---|
| **(0) T > 1338** | **none — NOT SEEDED**, the diff cannot fail anywhere | 36 |
| **(i) 1331 < T ≤ 1338** | **T-I6** (its lane-4 1518 member) | 35 |
| **(ii) 1001 < T ≤ 1331** | **T-I6** | 35 |
| **(iii) 100 < T ≤ 1001** — the nominal branch | **T-I1, T-I6** | 34 |
| **(iv) 71 < T ≤ 100** | **+ T-I3** | 33 |
| **(v) 8 < T ≤ 71** | **+ T-I4** | 32 |
| **(vi) T ≤ 8** | **every unit with a drain** — UNWORKED beyond the scored five | — |

Added units' messages, with their stimulus facts:

- **T-I3** (branch iv) — the 100-cycle gap is idle in **both** runs, and the
  baseline runs first: `M03-I3 (lane 0): baseline frame 2: expected 8 output
  words, got <mutant>`.
- **T-I4** (branch v) — the first case whose own drain reaches T; at T ≤ 16 that
  is (length 64, lane 0, idles 1) with drain 16, at 16 < T ≤ 64 it is (length 64,
  lane 0, idles 7) with drain 64: `M03-I4 (length <L>, lane 0, idles <k>):
  expected <W> output words, got <mutant>`.
- **Branch (vi) is UNWORKED beyond the scored five**, and the adjudication is
  fixed: reds elsewhere are predicted blast radius and contribute zero kills;
  the class is still scored on T-I1's cell.

### 5.8 The `Discard` / `Preamble` gate — the standing branch for I-c1 … I-c7

| disclosed gate | added REQUIRED | note |
|---|---|---|
| **(i) narrow** — held cycles inside `Frame` only | none | the nominal column of §2 |
| **(ii) also `Discard`** | **T-G6 UNWORKED** | the bench's only unit where idle words arrive while the machine is not in `Idle` (§4(a)) |
| **(iii) also `Preamble`** | none | no unit drives an idle word inside a preamble: REQ-102's preamble octets are data, and the wrapper is forbidden to inject there by M03-N3 |
| **(iv) also a lane-0 terminate character** (§6.2's other held cycle) | **T-I3 UNWORKED**, plus any gapless row whose frame length puts its `/T/` in lane 0 | this is a **gapless** trigger and therefore reaches families A–H |

**T-G6 is UNWORKED and its adjudication is fixed in advance.** Under branch (ii)
the design would act on the idle words that arrive after `run_g6`'s substituted
terminate — but it is already in `Discard`, where it delivers nothing and (by
§9's closure list) has already made its only report. **A red at T-G6 under a
disclosed wide gate is predicted blast radius, not an unnamed-unit finding, and
contributes zero kills; a green is equally consistent with this seal.** No cell
is scored there in either direction. I have not worked those cells and this seal
does not cover them.

**Branch (iv) is the dangerous one and is called out for the seeder rather than
sealed.** A gate on "any input word covering no frame octet" fires on a lane-0
terminate character too — a **gapless** event that exists in every family — so a
diff disclosed under (iv) has a reach this seal does not enumerate. Adjudication
rule: such a disclosure is scored as **the class not seeded as specified** — a
scope report, not a bench result — and no claim about any row is made from it in
either direction.

## 6. Bounds this campaign does NOT close, named before the result

1. **M03-I2 is qualified by exactly one class** (I-c10). If I-c10 survives, the
   row ends this campaign **unqualified** and no packet may say otherwise.
2. **M03-I3 is qualified by one class and one contingent** (I-c9; I-c8 on
   branches iv–vi, which I do not control).
3. **M03-I1 is qualified by two classes** (I-c8, I-c10), both of which speak at
   instruments it shares with the rest of the bench; **its own 1000-cycle scale
   is proven load-bearing by neither** — a defect with T ≤ 8 would have been
   caught by any row, and this campaign cannot distinguish the two unless the
   disclosed T lands in (100, 1001].
4. **The `tkeep` instrument at an injected run rides on I-c1's branch (ii)
   alone** (§5.1).
5. **The delivered-octet instrument rides on I-c6's branch (i) alone** (§5.6).
6. **Four M03-I4 instruments are unreachable by construction** — the
   word-granular delay identity, the front-offset `h` check, the cross-run class
   assertions, and every `Idle_injection` stimulus guard (§4(i), `WO-0061` §8
   bound 2).
7. **The absence scans of M03-I1, M03-I2 and M03-I3 are shadowed for
   output-word defects** (`WO-0061` §4.5); only their strobe halves are reached,
   and only M03-I2's is reached by a class of its own.
8. **Injection is exercised at `uniform` only**, at 0/1/7; no class needs a
   non-uniform site list, so `Idle_injection.create`'s site form stays
   unexercised.
9. **M03-I5 is NO-ASSERT and unscoreable**; its prohibition is exercised only
   negatively, by I-c7 (§7).

## 7. Weighting

**No discount is available in adjudication and none is claimed.** None of these
ten intents was published to the bench author — they did not exist when the
bench was written. **But five of the ten (I-c1, I-c2, I-c3, I-c5, I-c8) are the
defects the rows' own attack-plan text names as their targets**, so a kill there
proves the row does what it claims and not that it is a general detector. The
other five derive from specification clauses the rows cite.

**I-c7 carries the campaign's one adjacency to a settled measurement and it is
stated rather than buried.** BUG-0003 was a defect in the same clause and the
committed bench convicted it — at a **lane-4** start. I-c7 lands at **lane 0**,
by the row's own iteration order, where the re-based cycle instrument has never
spoken; and its rendering (the superseded last-octet rule) is a different defect
from BUG-0003's (no delay at all at one lane). A kill here says the re-based
instrument convicts where it has never had to. It does **not** re-prove
BUG-0003, which is on the record already.

**I-c4 is the class this family is most blind to by design.** All five rows
assert that **no strobe pulses**; a spurious strobe is the one defect class every
one of them is pointed at — which is why I-c4's failure would be the campaign's
most informative outcome, not its least. If M03-I4 and M03-I6 do not kill it,
nothing in this repository does.

**I-c5 is the wrapper's liveness proof.** If the injected idle words are not
reaching the design, I-c1 … I-c6 all survive and family I's injected half is
vacuous. `WO-0061` §4.2 fixes that this is adjudicated as a finding against
**me**, not against the rows.

## 8. Pass criteria

1. The suite goes red on all ten. **No exempt class this round.** The three
   NOT-SEEDED escapes named in `WO-0061` §3 are disclosures made before running,
   not green results.
2. Red in the REQUIRED units **with the expected message**, on the branch the
   disclosure selects, and no MUST-STAY-GREEN unit reddens. Either half violated
   is a **finding** — except at the cells this file marks UNWORKED, where the
   adjudication rule fixed in advance governs instead.
3. The unmutated control is green — `42b9df3`, CI run **30920890962**, both
   jobs.
4. **Kills are counted per class** (`WO-0061` §4.1). Fifty-one REQUIRED cells on
   the nominal branches are **ten** possible kills, never fifty-one; I-c10's
   thirty-five cells are **one**.

## 9. Not to be told

§1's unit table and its three iteration orders, §2's matrix — above all its
MUST-STAY-GREEN columns — §3's messages including every derived count (16, 64,
1, 190) and the `expected 5` derivation, §4's reasoning (especially (a)'s T-G6
near-miss, (b)/(c)/(d)'s collision data, and (h)'s identity ruling), §5's
disclosure functions, §6's bounds and §7's weighting.

**Freely told, and told**: the ten intents, the minimality and fidelity
requirements, the scope clauses and the three standing clauses, the scored set
and the denominators, the allowlist and process bars, the kill-counting rule and
the five constraints of `WO-0061` §4, the `cosim`-is-expected-red note, the
M03-I4 expect-block mechanics, the return format, the mandatory disclosure
table, and the plain warnings that I-c4 will look quiet and I-c5 will look
drastic.
