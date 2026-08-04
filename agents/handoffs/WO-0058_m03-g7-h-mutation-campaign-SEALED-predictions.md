# WO-0058 SEALED: dv_lead's frozen predictions for the combined M03-G7 + family-H campaign

> **SEALED.** The auditor must not open this file until all seven diffs are
> committed — and under `WO-0058` §2's allowlist, **all of `agents/**` is out of
> bounds for the campaign's duration**, this file included and absolutely.

- **State**: **FROZEN — unopened.**
- **Frozen against**: **`a2d090d`** — the SHA the green control run actually
  executed (CI run **30865856907**, workflow `build`, run number 271, **both
  jobs** `build` and `cosim` green, conclusion success). No byte-identity
  inference is needed. `git diff f806272 a2d090d -- test/ libs/ tools/
  dune-project` is **empty**.
- **Frozen by**: dv_lead, `J-dv_lead-0079`, **before any diff existed** — the
  forward commitment of `RV-0057-VERDICT` §8, redeemed in the commit that stages
  this file beside its packet (R-SEAL-1, ADR-0016).
- **Second copy**: the class → REQUIRED-red **row mapping** (not the message
  strings) is restated in `J-dv_lead-0079`.
- **Standing rule of this file, from `RV-0055`**: **every sealed cell that rests
  on a claim about the DUT's state cites the stimulus fact that establishes that
  state, or is marked UNWORKED.** FINDING G-1 was a cell asserted from a
  category — "T-G4 injects an `/E/` 100 octets past truncation, **in
  `Discard`**" — with no check of where the frame's own terminate fell. Every
  state claim below carries its arithmetic or its guard, by file and line.

## 0. The denominator, re-measured at the freeze

`tools/dv_checks.sh`'s inventory block, run at this tree:

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

**31 M03 units; 111 repository-wide; 80 non-M03.** Re-measured at the freeze
rather than carried from `RV-0057-VERDICT` §0, per my own rule after the
"nineteen" error of `RV-0047` §6. It agrees.

**Blast radius.** Only `test/xgmii_rx_64/dune` declares `hardcaml_ethernet` among
the bench libraries that contain `%expect_test`s reaching M03; `test/monitors`,
`test/xgmii`, `test/golden`, `test/axi64_probe` and `test/xgmii_probe` are
DUT-independent by their own dune stanzas, and `test/cosim/**` contains no
`%expect_test` at all. So a behavioural mutation's reach is exactly these 31. **A
unit outside them reddening is a build-level finding, never a behavioural one.**

## 1. The thirty-one units

| id | file | row(s) |
|---|---|---|
| T-A12 | `test_m03_a.ml` | M03-A1, M03-A2 |
| T-A34 | `test_m03_a.ml` | M03-A3, M03-A4 |
| T-A5 | `test_m03_a.ml` | M03-A5 |
| T-B1 | `test_m03_b.ml` | M03-B1 |
| T-C12 | `test_m03_c.ml` | M03-C1, M03-C2 |
| T-C5 | `test_m03_c.ml` | M03-C5 (1513 and 1516 octets) |
| T-C3 | `test_m03_c.ml` | M03-C3 — one **1518**-octet frame (legal maximum) |
| T-C4 | `test_m03_c.ml` | M03-C4 |
| T-D1 / T-D2 / T-D3 | `test_m03_d.ml` | M03-D1 / D2 / D3 |
| T-E1 | `test_m03_e.ml` | M03-E1 — `/E/` in each of eight lanes, both start lanes |
| T-E2 | `test_m03_e.ml` | M03-E2 — `/E/` at the first octet (zero delivered) |
| T-E4 | `test_m03_e.ml` | M03-E4 — `/E/` **in the inter-frame gap**, two clean frames |
| T-E5 | `test_m03_e.ml` | M03-E5 — `/E/` at preamble positions 1..7 |
| T-F1 / T-F2 / T-F3 / T-F4 | `test_m03_f.ml` | M03-F1 / F2 / F3 / F4 |
| T-G1 | `test_m03_g.ml` | M03-G1 — 1600-octet frame + a valid 64-octet frame |
| T-G2 | `test_m03_g.ml` | M03-G2 — the adjacent pair 1518 / 1519, two single-frame runs |
| T-G3 | `test_m03_g.ml` | M03-G3 — a separate frame's `/S/` at content index **1620** |
| T-G4 | `test_m03_g.ml` | M03-G4 — `/E/` 100 octets past truncation, **in the gap** |
| T-G6 | `test_m03_g.ml` | M03-G6 — **no terminate character at all** before the next `/S/` |
| **T-G7** | `test_m03_g.ml` | **M03-G7 — `/S/` injected at content index 1588, inside the first epoch** |
| T-G8 | `test_m03_g.ml` | M03-G8 — `/E/` injected at content index 1560, inside the first epoch |
| **T-H1** | `test_m03_h.ml` | **M03-H1 — terminate replaced by a `/S/`, both start lanes** |
| **T-H3** | `test_m03_h.ml` | **M03-H3 — `/E/`, then a `/S/` two cycles later, both start lanes** |
| **T-H2** | `test_m03_h.ml` | **M03-H2 — `/S/` in absolute lane 4, both start lanes** |
| **T-H4** | `test_m03_h.ml` | **M03-H4 — two `/S/` in one word, a third in the next, then a frame** |
| T-ST | `test_m03_structural.ml` | M03-L6 (elaboration + idle cycles) |

The five in bold are `WO-0058` §1's scored set. **File order matters for the
messages**: `test_m03_h.ml` defines H1, then H3, then H2, then H4, and every row
that loops runs **lane 0 before lane 4** — so a lane-0 failure is what speaks.

## 2. The matrix

`R` = REQUIRED red. `G` = MUST STAY GREEN. Anything off-pattern is a **finding**.
Columns marked *fn* are a **function of the seeder's disclosure** (§5); the value
shown is the **narrow** branch, which is the class as `WO-0058` §3 specifies it.

| unit | GH-c1 | GH-c2 *fn* | GH-c3 *fn* | GH-c4 *fn* | GH-c5 *fn* | GH-c6 | GH-c7 |
|---|---|---|---|---|---|---|---|
| T-A12, T-A34, T-A5 | G | G | G | G | G | G | G |
| T-B1 | G | G | G | G | G | G | G |
| T-C12, T-C3, T-C4, T-C5 | G | G | G | G | G | G | G |
| T-D1, T-D2, T-D3 | G | G | G | G | G | G | G |
| T-E1 | G | G | G *(§5.2 R)* | G | G | G | G |
| T-E2, T-E5 | G | G | G | G | G | G | G |
| T-E4 | G | G *(§5.1 R)* | G | G | G | G | G |
| T-F1, T-F2, T-F3, T-F4 | G | G | G | G | G | G | G |
| T-G1 | G | G | G *(§5.2 R)* | G | G | G | G |
| T-G2 | G | G | G *(§5.2 R)* | G | G | G | G |
| T-G3 | G | G | G *(§5.2 R)* | G | G | G | G |
| T-G4 | G | G *(§5.1 R)* | G *(§5.2 R)* | G | G | G | G |
| **T-G6** | **R** | G | G *(§5.2 R)* | G | G *(§5.3 R)* | G | G |
| **T-G7** | **R** | G | G *(§5.2 R)* | G | G *(§5.3 R)* | G | G |
| T-G8 | G | G *(§5.1 R)* | G *(§5.2 R)* | G | G | G | G |
| **T-H1** | G | G | **R** | **R** | **R** | **R** | G |
| **T-H2** | G | G | **R** | **R** | **R** | **R** | G |
| **T-H3** | G | **R** | G *(§5.2 R)* | G | G | G | G |
| **T-H4** | G | G | G | G | **R** | **R** | **R** |
| T-ST | G | G | G | G | G | G | G |
| **red count (narrow)** | **2** | **1** | **2** | **2** | **3** | **3** | **1** |
| **MUST-STAY-GREEN (M03)** | **29** | **30** | **29** | **29** | **28** | **28** | **30** |
| **+ non-M03, every class** | **80** | **80** | **80** | **80** | **80** | **80** | **80** |

**Fourteen REQUIRED cells on the narrow branches; 203 of the 217 M03 cells
(7 classes × 31 units) must stay green; 560 non-M03 must-stay-green cells
(7 × 80).** The wide branches
move these counts and are tabulated in §5.

## 3. Expected messages

Every message below is the **first** assertion to speak, given each row's
committed assertion order and iteration order. Each is quoted as the row
composes it: `<row prefix>: <text>`.

### GH-c1 — the resynchronising `/S/` read as a second abort

| unit | message |
|---|---|
| **T-G7** | `M03-G7 (lane 0): expected exactly two strobes (error_oversize then error_runt -- NO error_start_without_terminate, §9's sixth ruling, C-12, WO-0056's own point), observed 3` |
| **T-G6** | `M03-G6 (lane 0): expected exactly one strobe (error_oversize alone), observed 2` |

**Why the strobe-set arm and not something earlier, at both.** The intent leaves
the truncation, its extent, its marking, its own `error_oversize` and the
resynchronisation unchanged, so every structural assertion in both rows passes —
including M03-G6's and M03-G7's **total-output-word** checks
(`test_m03_g.ml:1185`, `1472`), which a strobe-only defect cannot move. The
exact-`error_pulses` arm is the first thing that can differ, and it differs in
**arity**, so the `pulses ->` fallback fires with the observed count.

**Why `observed 3` at M03-G7 and `observed 2` at M03-G6.** `error_pulses`
returns one `(cycle, name)` pair per high cycle per name
(`test/xgmii_rx_64/bench.ml:233`), so a spurious pulse adds one entry whatever
cycle it lands on. M03-G7's conformant set is two entries (`error_oversize`,
`error_runt`) and M03-G6's is one (`error_oversize` alone).

### GH-c2 — a frame an `/E/` closed, re-aborted by the next `/S/`

| unit | message |
|---|---|
| **T-H3** | `M03-H3 (lane 0): expected exactly one strobe (error_bad_frame alone -- NO error_start_without_terminate, §9's fifth ruling, since the /E/ already closed the frame before the /S/ arrives), observed 2` |

The scope clause leaves the `/E/`'s truncation point, delivered octets, `tuser`,
`tkeep`, cycle and the second frame's reception untouched, so `run_h3`'s
structural and content assertions all pass and the arity arm speaks.

### GH-c3 — FCS removal attempted on a `/S/`-aborted frame

| unit | message |
|---|---|
| **T-H1** | `M03-H1 (lane 0): frame 1: tkeep is not 0xFF -- all 64 octets are delivered, no FCS removed (REQ-103's no-removal clause)` |
| **T-H2** | `M03-H2 (lane 0): frame 1: unexpected output word count` |

**Why `tkeep` and not the word count at M03-H1 — worked, not assumed.** The row
checks the output-word count first (`test_m03_h.ml:338`). `delivered1 = 64` gives
`(64 + 7) / 8 = 8` words; the mutant's 60 gives `(60 + 7) / 8 = 8` — **the count
is unchanged.** So is the `tlast` cycle: the last delivered octet moves from
content index 63 (octet time `start_ot + 71`, input word `(8 + 71)/8 = 9` at a
lane-0 start) to index 59 (octet time `start_ot + 67`, **the same input word
9**), and §7's per-octet constant maps one input word to one output cycle, so
`expected_tlast_cycle1 = start_cycle + 3 + 7` still holds. The third assertion,
`tkeep` (0x0F observed against 0xFF expected), is the first to differ.

**Why the word count and not `tkeep` at M03-H2.** `k = 12` at the lane-0 member
(`test_m03_h.ml:634`), so `words1 = (12 + 7) / 8 = 2` and the mutant's 8 octets
give `(8 + 7) / 8 = 1`. The count moves, and it is checked first
(`test_m03_h.ml:733`). **The two scored units of this class therefore speak at
two different assertions, which is what makes the class self-checking.**

### GH-c4 — the new frame's alignment applied to the aborted frame's octets

Reading **(a)**, count-preserving and content-destroying (the signature class):

| unit | message |
|---|---|
| **T-H1** | `M03-H1 (lane 4): frame 1: delivered octets differ from the 64 octets injected before the /S/ -- REQ-110's no-removal clause, not Frame.delivered's FCS-removal identity (WO-0057 §2.1)` |
| **T-H2** | `M03-H2 (lane 0): frame 1: delivered octets differ from the k octets injected before the /S/ -- the silent-rotation/silent-drop defect this row exists to kill (WO-0057 §2.3)` |

Reading **(b)**, count-moving (the four octets dropped rather than rotated):

| unit | message |
|---|---|
| **T-H1** | `M03-H1 (lane 4): frame 1: tkeep is not 0xFF -- all 64 octets are delivered, no FCS removed (REQ-103's no-removal clause)` |
| **T-H2** | `M03-H2 (lane 0): frame 1: unexpected output word count` |

**The lane label at M03-H1 is load-bearing and is the whole discrimination
between GH-c4 and GH-c3.** See §4(c).

**Why the content assertion can fire at all under reading (a)** — i.e. why the
rotated octets are guaranteed to differ from the correct ones: `filler n`
(`test_m03_h.ml:177`) is `j * 13 + 5 land 0xFF`, **position-dependent by
construction and documented as such**, and the octets that would replace them are
either their own neighbours or `preamble_tail`'s `0xC0 + j`
(`test_m03_h.ml:183`). No rotation of that array maps a four-octet window onto
itself.

### GH-c5 — the aborting `/S/` opens no new frame

| unit | message |
|---|---|
| **T-H1** | `M03-H1 (lane 0): expected two delivered frames (one tlast word each), got fewer` |
| **T-H2** | `M03-H2 (lane 0): expected two delivered frames (one tlast word each), got fewer` |
| **T-H4** | `M03-H4: expected exactly two error_start_without_terminate high cycles, consecutive (c + 2 and c + 3) -- observed 1` |

**Why M03-H1 and M03-H2 lose their second frame entirely.** Both build **one**
`Injection` `frame_case` whose array splices the following frame's octets after
the injected `/S/` (`test_m03_h.ml:241`, `636`); there is **no second `/S/`
anywhere in the stimulus**. A receiver that does not open a frame at the aborting
character therefore never opens one at all, `split_at_first_tlast rest` returns
an empty list, and the emptiness check at `test_m03_h.ml:336` / `731` fires
before any per-frame assertion.

**Why M03-H4 loses exactly one strobe and keeps frame C.** Frame A opens at
`start_ot_a` from an idle receiver — not an abort — so it is untouched. The
second `/S/` (lane 4, cycle `c`) aborts frame A and still reports at `c + 2`; it
simply opens no frame B. The third `/S/` (lane 0, cycle `c + 1`, octet time
`ot_3 = start_ot_a + 8`) then arrives with **no frame open**, so it opens a frame
by the ordinary Idle → Preamble transition — and `ot_3` **is** frame C's own
start octet time in the conformant reading too (`let start_ot_c = ot_3`,
`test_m03_h.ml:868`). Frame C is therefore bit-identical and every assertion
about it passes, including the total-output-word check at `test_m03_h.ml:971`.
`error_pulses` holds one entry, the two-element pattern fails, and the fallback
arm prints `observed 1`.

### GH-c6 — `error_start_without_terminate` never pulses

| unit | message |
|---|---|
| **T-H1** | `M03-H1 (lane 0): expected exactly one strobe (error_start_without_terminate alone -- no error_bad_fcs, §9 ruling 4), observed 0` |
| **T-H2** | `M03-H2 (lane 0): expected exactly one strobe (error_start_without_terminate alone), observed 0` |
| **T-H4** | `M03-H4: expected exactly two error_start_without_terminate high cycles, consecutive (c + 2 and c + 3) -- observed 0` |

**GH-c5 and GH-c6 share their row set exactly and are separated ONLY by the
message** — `got fewer` against `observed 0` at M03-H1/H2, and `observed 1`
against `observed 0` at M03-H4. This is the fifth campaign in this programme
where row sets do not discriminate and messages do (D-M1/D-M4/D-M5,
E-c3/E-c5, F-c3/F-c5/F-c6, G-c1/G-c3/G-c5, now GH-c5/GH-c6).

### GH-c7 — two consecutive same-name reports collapsed into one high cycle

| unit | message |
|---|---|
| **T-H4** | `M03-H4: expected exactly two error_start_without_terminate high cycles, consecutive (c + 2 and c + 3) -- observed 1` |

**Identical to GH-c5's M03-H4 message, and the row sets are what separate the two
classes**: GH-c5 also reddens M03-H1 and M03-H2, GH-c7 reddens nothing else at
all. If both classes are seeded and **both** produce a lone `observed 1` at
M03-H4 with **no** other unit moving, the campaign has measured one defect twice
and §4(e) governs.

## 4. Reasoning for the cells that are not obvious

**(a) The GH-c1 cells are the cells `RV-0055` FINDING G-1 got wrong, re-derived
from the stimulus geometry rather than from a category.** A `/S/` is "after the
truncation point **and still in `Discard`**" only if the receiver has not already
left that state, and §6.2's `Discard` row exits on the frame's own terminate
character. Every G row, checked against its own committed arithmetic:

- **T-G7 — REQUIRED.** `run_g7` guards `inject_ot > start_ot1 + 8 + 1518 &&
  inject_ot < terminate1` (`test_m03_g.ml`, the k-guard block) with `k = 1588`.
  The injected `/S/` is therefore **strictly inside** the first epoch, before the
  frame's own terminate. **In `Discard`, by the row's own guard.**
- **T-G6 — REQUIRED.** `run_g6` replaces frame 1's own terminate character with
  an **idle** character at `Arrival.terminate_octet_time frame1` via `?word_at`,
  and asserts before driving that the substitute landed. There is no terminate
  character at all, so frame 2's own `/S/` is the first closure after the
  truncation. **In `Discard`, because nothing could have left it.**
- **T-G3 — GREEN, and this is the cell whose category-reasoning cost a campaign.**
  `run_g3` computes `terminate1 = first_start + 8 + 1600` and
  `target_start2 = first_start + 8 + 1620`; the second frame's `/S/` arrives
  **20 octet times after** frame 1's terminate. The receiver left `Discard` at
  that terminate. Green **by arithmetic in the row's own source**, not by
  category.
- **T-G4 — GREEN.** `run_g4` guards `inject_ot > terminate1 && inject_ot <
  start_ot2`: its `/E/` is in the gap, and frame 2's `/S/` is later still.
- **T-G8 — GREEN.** `run_g8` injects an `/E/` at `k = 1560`, inside the first
  epoch, but frame 1 keeps its **own natural terminate** at content 1600 (the row
  overrides nothing at `terminate_octet_time`), so the receiver leaves `Discard`
  there and frame 2's `/S/` arrives from `Idle`.
- **T-G1 — GREEN.** An ordinary two-frame `Arrival` schedule; frame 1's own
  terminate at content 1600 precedes the gap and frame 2's `/S/`.
- **T-G2 — GREEN.** Both members are built with `one_frame`, i.e. **a single
  frame each**; no `/S/` follows either truncation at all.
- **Every non-G unit — GREEN.** `Discard` is entered only by REQ-108's
  truncation, which needs **more than 1518 octets between start and terminate**.
  No unit outside family G drives a frame above 1518: T-C3's frame is exactly
  1518 (legal maximum, no truncation) and T-C5's are 1513 and 1516.

**(b) The REQ-110 event exists at exactly four units, and that is what bounds
GH-c3, GH-c4, GH-c5 and GH-c6.** `grep -n start_char test/xgmii_rx_64/*.ml`
returns hits in `test_m03_g.ml` and `test_m03_h.ml` **and nowhere else** — every
other row's start characters are ordinary frame starts placed by `Arrival`, which
open frames from `Idle` and abort nothing. Within those two files the `/S/`
arrives while a frame is **open** at M03-H1, M03-H2 and M03-H4 only; M03-G7's
arrives while the frame is **closed** (truncated, (a) above) and M03-H3's arrives
while the frame is **closed** (by its `/E/`, §9's fifth ruling). Of the three
REQ-110 units, only M03-H1 and M03-H2 have an aborted frame that **delivers**
anything — M03-H4's frames A and B deliver zero by construction (`oa.delivered
<> 0` and `ob.delivered <> 0` are cross-check failures in the row itself) — which
is why GH-c3 and GH-c4 reach two units and GH-c5/GH-c6 reach three.

**(c) GH-c3 and GH-c4(b) are separated by exactly one datum, and I am recording
that before the result rather than discovering it after.** Their M03-H2 messages
are **character-for-character identical**, and their M03-H1 messages differ
**only in the lane label** — `(lane 0)` for GH-c3, `(lane 4)` for GH-c4(b). The
reason is geometric and is worth writing out:

- M03-H1's `/S/` sits at `close_ot = start_ot1 + 8 + 64`, and 72 is a multiple of
  8, so it lands in **the same lane as the frame's own start**: lane 0 at a
  lane-0 start, lane 4 at a lane-4 start (`test_m03_h.ml:263-265`).
- GH-c3 (FCS removal) is **lane-independent** — it shortens the delivered extent
  at both members, so the **lane-0** member speaks first.
- GH-c4 needs aborted-frame octets in the `/S/`'s **own word**, which exists only
  where the `/S/` is in lane 4 with lanes 0..3 still belonging to the aborted
  frame. At M03-H1's lane-0 member the whole word belongs to the **new** frame's
  preamble, so that member passes and the **lane-4** member speaks.

**If both classes are seeded and both report `M03-H1 (lane 0)`, or both report
`M03-H1 (lane 4)`, the campaign has measured one defect twice** and the
scorecard must say so rather than record two kills. This is the inflation
`RV-0055` paid for, caught in advance at the one place it could recur here.

**(d) M03-H2's `/S/` is in absolute lane 4 at BOTH start lanes, and the row
guards it.** `k = 12` at a lane-0 start and `k = 16` at a lane-4 start
(`test_m03_h.ml:634`), with `if Int.rem close_ot 8 <> 4 then fail row "test bug
-- the spliced /S/ does not land in lane 4 (this row's own point)"`
(`test_m03_h.ml:657`). At the lane-0 member lanes 0..3 of that word carry content
indices 8..11; at the lane-4 member, 12..15. **Both members are exposed to
GH-c4**, and the lane-0 one speaks. This is the cell whose analogue at M03-H1 is
lane-asymmetric, and the asymmetry is the row's own design, not an accident.

**(e) GH-c7's stimulus exists at exactly one unit in the bench, and the reason is
arithmetic rather than inventory.** Two same-name reports on **consecutive**
cycles require the two frames' closures to fall exactly 8 octet times apart. For
two frames in any ordinary schedule that is unreachable: requirements.md §0.3's
**12-octet minimum inter-frame gap** plus REQ-102's **8-octet preamble** put a
second frame's earliest possible closure at least 20 octet times after the
first's, i.e. at least **2.5 cycles**, so its report lands **two or more** cycles
later. Only a REQ-110 splice — where the new frame begins **at** the aborting
character with no gap at all — can bring two closures within one word, and in
this bench only M03-H4 does it **twice in succession**. M03-H1 and M03-H2 splice
once, and their second frame is clean and reports nothing. **No other unit can
see GH-c7, and a green elsewhere is not evidence of anything.**

**(f) The `error_pulses` arity arm is the detector for four of the seven classes,
and that is a shared IDIOM, not a shared device.** GH-c1, GH-c2, GH-c6 and GH-c7
are all caught by "the observed `(cycle, name)` list is not the exact list this
row expects". That assertion is written per row — five separate `match
error_pulses samples with` blocks across the five scored units, with five
different literal texts — and shares no helper, so the units are independent
measurements of the **stimulus geometry**. They are **not** independent
measurements of the **property**: one property (a strobe set is exactly what §9
says) is being probed at several stimuli. `WO-0058` §4.1 binds the scorecard to
say so.

**(g) D2 does not appear anywhere in this seal, and that is checkable.** The
correlation `RV-0057-VERDICT` §9 identified — one accounting path for a frame the
stimulus opened, at five sites covering all five scored units — cannot produce
any message above, because in every one of those rows the accounting calls
(`account_spliced_forwarded`, `account_spliced_dropped`,
`account_resync_runt_frame`) and `assert_monitors_clean` come **after** every
assertion (`test_m03_h.ml:392-395`, `594-597`, `778-781`, `1007-1012`;
`test_m03_g.ml:1502-1507`). A row that reddens never reaches them. **If any class
is caught only by `assert_monitors_clean`, that is off-pattern for this seal and
is a finding**, and its kill is D2-correlated — one detection however many units
carry it.

**(h) M03-H4's window check contributes nothing to any cell here, by
construction.** `expected_cycle_a = expected_not_before_a + 2` and
`expected_not_after_a = expected_not_before_a + 3` (`test_m03_h.ml:862-867`): the
pin is inside the window as a matter of arithmetic, so `Strobe_monitor.expect`'s
window test cannot fail at this row (`RV-0057-VERDICT` FINDING 2). **Every M03-H4
cell above is scored on the exact two-element `error_pulses` list and on
nothing else**, exactly as `WO-0058` §4.3 requires.

**(i) The spurious-third-frame blind spot cannot be confused with a survival
here, and here is why per class.** `run_h1`, `run_h2` and `run_h3` do not assert
that nothing follows the second frame (`RV-0057-VERDICT` FINDING 3). None of the
seven classes produces an extra frame: GH-c1/GH-c2/GH-c6/GH-c7 change strobes
only, GH-c3/GH-c4 change one frame's extent or content, and GH-c5 **removes** a
frame rather than adding one. So no cell above depends on the missing check. **If
a diff nevertheless produces an extra output frame, its survival at M03-H1/H2/H3
is expected and is not evidence about those rows' strength** — `WO-0058` §4.2
governs the adjudication.

## 5. The disclosure functions — sealed branch by branch

`WO-0058` §3's second standing clause requires the seeder to state what each diff
reaches. **The mapping below is the prediction; the seeder cannot see it, and
every branch of it is exact.** If an observed row set matches **none** of a
class's branches, that is a **finding** — either my enumeration was incomplete or
the diff reaches further than the class it names. This is `WO-0055` §4(d)'s
method, which was the repair for over-specifying F-c8.

### 5.1 GH-c2 — branches on where the diff fires

| disclosed reach | REQUIRED | MSG (M03) |
|---|---|---|
| **(i) narrow** — only where an `/E/` closed an **open** frame | **T-H3** | 30 |
| **(ii) wide** — also where an `/E/` arrived with **no frame open** | **T-H3, T-E4, T-G4, T-G8** | 27 |

Branch (ii)'s three added units, with their stimulus facts and messages:

- **T-E4** — `run_e4` places its `/E/` at `terminate0 + 5`, guarded strictly
  inside the gap, and then frame 2's own `/S/` arrives. Its **first** assertion
  after the placement check is the negative one, so it speaks:
  `M03-E4 (lane 0): an error strobe pulsed for an /E/ that arrived with no frame open (REQ-105's closure clause, C-12, E-c4)`
- **T-G4** — `/E/` in the widened gap, frame 2's `/S/` after it:
  `M03-G4 (lane 0): expected exactly one strobe (error_oversize alone -- NO error_bad_frame, §9's seventh ruling, C-12, this row's own point), observed 2`
- **T-G8** — `/E/` inside the first epoch, frame 2's `/S/` after frame 1's own
  terminate:
  `M03-G8 (lane 0): expected exactly one strobe (error_oversize alone -- NO error_bad_frame, §9's seventh ruling, C-12, in the epoch M03-G4's character never reaches), observed 2`

**T-E1, T-E2 and T-E5 stay GREEN on both branches**, and the ground is the
construction rather than the rule: each builds `Injection.create ~first_lane:…
[ case ]` with **one** `frame_case`, so **no start character follows the `/E/`
anywhere in the stimulus**. There is nothing for either branch to fire on.

> **UNWORKED — a third rendering, and it is not sealed.** If the only faithful
> minimal diff is one where the `/E/` **no longer closes the frame at all** (the
> receiver keeps receiving past it), that is a different and much wider defect —
> it would move T-E1, T-E2, T-E5 and T-H3's delivered extents, their `tkeep`,
> their strobe cycles and possibly their FCS results. **I have not worked those
> cells and this seal does not cover them.** Adjudication rule, fixed here: such
> a disclosure is scored as **the class not seeded** — a scope report, not a
> bench result — and no claim is made about the bench from it either way.

### 5.2 GH-c3 — branches on which no-removal paths the diff reaches

| disclosed reach | REQUIRED | MSG (M03) |
|---|---|---|
| **(i) narrow** — REQ-110 aborts only | **T-H1, T-H2** | 29 |
| **(ii)** — also REQ-105 aborts | **+ T-H3, T-E1** | 27 |
| **(iii)** — also REQ-108 truncations | **+ T-G1, T-G2, T-G3, T-G4, T-G6, T-G7, T-G8** | 20 |

Branch (ii)'s added units:

- **T-H3** — `delivered1 = e_idx = 24` at the lane-0 member; `(24 + 7)/8 = 3`
  words and the mutant's 20 octets also give 3, and the last delivered octet
  stays in the same input word (content index 23 → octet time `start_ot + 31`,
  word 4; index 19 → `start_ot + 27`, word 4), so the count and the `tlast` cycle
  both hold and `tkeep` speaks — expected `0xFF` (24 ≡ 0 mod 8), observed `0x0F`:
  `M03-H3 (lane 0): frame 1: tkeep does not match its own delivered octets`
- **T-E1** — the first member is `lane 0, e_lane 0`, so `delivered =
  e1_word_octet0 + 0 = 24` (`test_m03_e.ml:171`, `199`). Same arithmetic: 3 words
  either way, so the word-count check passes and the **content** check speaks —
  and its text names this exact defect:
  `M03-E1 (start lane 0, /E/ in lane 0 of octets 24-31; final delivered word FULL -- section3's sampling declaration, R-1's disagreement class): delivered octets differ from the octets immediately preceding the /E/ (REQ-106 rule); a design applying FCS removal on the abort path would be four octets short here (REQ-103, E-c1)`
- **T-E2 and T-E5 stay GREEN even on branch (ii)**: both are zero-delivered
  aborts that emit no output word, and four octets removed from nothing is
  nothing.

Branch (iii)'s added units — a truncated frame delivering 1510 instead of 1514
gives `(1510 + 7)/8 = 189` words against `truncated_words = 190`
(`test_m03_g.ml:349-350`), and **the word count is checked before anything else**
in every one of them:

| unit | message |
|---|---|
| T-G1 | `M03-G1 (lane 0): frame 1: expected 190 output words, got 189` |
| T-G2 | `M03-G2 (lane 0, 1519 oversize): expected 190 output words (the 1514-octet truncation), got a different count` |
| T-G3 | `M03-G3 (lane 0): frame 1: expected 190 output words (the 1514-octet truncation)` |
| T-G4 | `M03-G4 (lane 0): frame 1: expected 190 output words (the 1514-octet truncation)` |
| T-G6 | `M03-G6 (lane 0): frame 1: expected 190 output words (the 1514-octet truncation)` |
| **T-G7** | `M03-G7 (lane 0): frame 1: expected 190 output words (the 1514-octet truncation)` |
| T-G8 | `M03-G8 (lane 0): frame 1: expected 190 output words (the 1514-octet truncation)` |

**T-C3 stays GREEN on every branch** and the reason is worth stating: its
1518-octet frame delivers 1514 octets by **REQ-103's ordinary removal** at a
genuine terminate character, which no branch of this class touches. The
coincidence of the two numbers — the trap M03-G2 exists to expose — does not make
it a truncation.

> **On branch (iii), T-G7 reddens on its WORD COUNT, not on its strobe set.**
> That is a kill of GH-c3 at a scored unit, and it is **not** evidence about
> M03-G7's first-epoch strobe assertion, which is GH-c1's business. Scored
> accordingly.

### 5.3 GH-c5 — branches on whether REQ-108's resynchronisation is reached

| disclosed reach | REQUIRED | MSG (M03) |
|---|---|---|
| **(i) narrow** — REQ-110's abort path only | **T-H1, T-H2, T-H4** | 28 |
| **(ii) wide** — also `Discard` → new frame on `/S/` (REQ-108) | **+ T-G7, T-G6** | 26 |

Branch (ii)'s added units:

- **T-G7** — the frame the injected `/S/` opens never opens, so its `error_runt`
  never pulses and it delivers nothing (it delivered nothing before either, being
  a sub-5-octet runt, so the structural checks still pass):
  `M03-G7 (lane 0): expected exactly two strobes (error_oversize then error_runt -- NO error_start_without_terminate, §9's sixth ruling, C-12, WO-0056's own point), observed 1`
- **T-G6** — frame 2's `/S/` arrives **in `Discard`** ((a) above), so under this
  branch frame 2 never opens at all and the row loses its second delivered frame:
  `M03-G6 (lane 0): expected two delivered frames (one tlast word each), got fewer`
- **T-G1, T-G3, T-G4, T-G8 stay GREEN on both branches**: each of their following
  frames opens on a `/S/` that arrives from `Idle`, after the first frame's own
  terminate character — the same arithmetic as (a).

**Branch (ii) is the one case in this seal where a class reaches BOTH of GH-c1's
units.** If GH-c5 is disclosed wide and GH-c1 lands as sealed, the two classes
share T-G6 and T-G7 as REQUIRED cells but differ in every message. That is
discrimination by message over an identical partial row set, and it is expected —
not a sign that one of the two diffs was mis-seeded.

### 5.4 GH-c4 — branches on the reading, not on the reach

Both readings are tabulated in §3; the row set is **T-H1, T-H2** either way and
the MUST-STAY-GREEN count is **29** either way. §4(c) governs the collision with
GH-c3(i).

## 6. Bounds this campaign does NOT close, named before the result

1. **M03-H3 is qualified by exactly one class** (GH-c2). If GH-c2 is disclosed
   under §5.1's unworked third rendering, **M03-H3 ends this campaign
   unqualified**, and no packet may say otherwise.
2. **M03-G7 is qualified by exactly one class on the narrow branches** (GH-c1).
   §5.2(iii) and §5.3(ii) would add kills at that unit, but they are contingent
   on disclosures I do not control.
3. **The spurious-third-frame class is unseeded** (§4(i)) — deliberately: three
   of the five scored units have no instrument for it.
4. **REQ-110's zero-delivered class is exercised in preamble positions only.**
   A `/S/` landing exactly on an aborted frame's **first octet** — the other
   member of C-47's extensional gloss — has no unit, so no class here can be
   scored against it.
5. **No class seeds the `cfg_rx_enable` interaction** (§4.3, ADR-0014): a new
   start character closes the open frame whether or not the enable permits a new
   one to begin. Family N is unwritten.
6. **One offset per row.** M03-G7's first-epoch `/S/` is at `k = 1588` and its
   resynchronised frame is four octets; M03-H2's `k` is 12/16. Neither is swept.
7. **`fail_cross` cannot fire under any class here, and its absence is not
   coverage.** The `Injection` model cross-checks in all five scored units are
   evaluated **before** `run` (`test_m03_h.ml:280`, `483`, `676`, `876`;
   `test_m03_g.ml`'s `outcomes` block), on the bench's own model of the
   stimulus. **No RTL mutation can move them.** A `fail_cross` message appearing
   in this campaign would mean something other than the seeded defect.

## 7. Weighting

**No discount is available in adjudication and none is claimed.** These seven
intents were **not** published to the bench author before the bench was written
— unlike families E, F and G, whose intents were published in their commissioning
packets — because they did not exist then; `WO-0057` §6 disclosed only that a
`/S/`-gated class was coming. **But three of the seven (GH-c1, GH-c4, GH-c7) are
the defects the rows' own attack-plan and docstring text name as their targets**,
so a kill there proves the row does what it claims and not that it is a general
detector. The other four derive from the specification clauses the rows cite.
Row mapping, MUST-STAY-GREEN columns and messages are sealed together.

## 8. Pass criteria

1. The suite goes red on all seven. **No exempt class this round.**
2. Red in the REQUIRED units **with the expected message**, on the branch the
   disclosure selects, and no MUST-STAY-GREEN unit reddens. Either half violated
   is a **finding**.
3. The unmutated control is green — `a2d090d`, CI run **30865856907**, both jobs
   green.
4. **Kills are counted per class** (`WO-0058` §4.1). Fourteen REQUIRED cells on
   the narrow branches are **seven** possible kills, never fourteen.

**GH-c1 is the class this campaign exists for.** M03-G7 has never been reddened
by any mutation; a campaign in which GH-c1 survives has qualified nothing at that
row, whatever the other six do. And **GH-c6 is the class the H family is most
blind to by design**: two of the five scored units assert that very strobe's
absence, so they cannot see its suppression — if M03-H1, M03-H2 and M03-H4 do not
kill it, nothing in this repository does.

## 9. Not to be told

§1's unit table, §2's matrix — above all its MUST-STAY-GREEN columns — §3's
messages including the `tkeep`-not-count derivations and the lane labels, §4's
reasoning (especially (c)'s one-datum discrimination and (e)'s uniqueness
argument), §5's disclosure functions, §6's bounds and §7's weighting.

**Freely told, and told**: the seven intents, the minimality and fidelity
requirements, the scope clauses and the instruction that scope collisions are
disclosed rather than substituted, the scored set and the denominators, the
allowlist and process bars, the kill-counting rule and the three constraints of
`WO-0058` §4, the `cosim`-is-expected-red note, the return format, and the plain
warnings that GH-c6 will look quiet and GH-c5 will look drastic.
