# BUG-0001: M03 emits `k − 4` extra octets whenever a frame's final output word carries more than four delivered octets
- **Module / severity**: `libs/hardcaml_ethernet/src/xgmii_rx_64.ml` (M03, `Xgmii_rx_64`) | **CRITICAL**
- **From** / **To**: dv_lead → rtl_lead (via orchestrator, verbatim relay class, PROTOCOL §3)
- **Found by**: `test/xgmii_rx_64/test_m03_c.ml`, rows **M03-C1 / M03-C2**; corroborated independently by `test/xgmii_rx_64/test_m03_a.ml` row **M03-A3**'s latency tagger
- **Evidence**: CI run **30774152441**, commit `b190a9e`, Build green

## Reproduction

```
opam exec -- dune build @default
opam exec -- dune runtest
```

at `b190a9e`. `test_m03_c.ml`'s M03-C1/M03-C2 test raises with the
sixteen-entry table quoted below; `test_m03_a.ml`'s M03-A3 raises with the
latency tagger's independent statement of the same excess.

The bench drives one frame per simulation, `Arrival.check`-conformant, correct
FCS, both start lanes, `drain:8`. No stimulus is shared between entries.

## Observed vs expected

**Spec clauses.** REQ-103 (frame extraction: deliver DA through the last octet
before the FCS), REQ-011 (`tkeep` contiguous from bit 0), SPEC-M03 §6.1's cycle
table (a 64-octet frame yields **60** delivered octets in **8** words, the last
carrying `tkeep` = 0x0F), REQ-106 (terminate-character handling).

**The sixteen-entry signature, verbatim from the run.** `delivered=observed/expected`:

```
PASS  lane 0 length 64: delivered=60/60 tkeep=15/15  tuser=0 terminate_lane=0 error_pulses=0
FAIL  lane 0 length 65: delivered=62/61 tkeep=31/31  tuser=0 terminate_lane=1 error_pulses=0
FAIL  lane 0 length 66: delivered=64/62 tkeep=63/63  tuser=0 terminate_lane=2 error_pulses=0
FAIL  lane 0 length 67: delivered=66/63 tkeep=127/127 tuser=0 terminate_lane=3 error_pulses=0
FAIL  lane 0 length 68: delivered=68/64 tkeep=255/255 tuser=0 terminate_lane=4 error_pulses=0
PASS  lane 0 length 69: delivered=65/65 tkeep=1/1    tuser=0 terminate_lane=5 error_pulses=0
PASS  lane 0 length 70: delivered=66/66 tkeep=3/3    tuser=0 terminate_lane=6 error_pulses=0
PASS  lane 0 length 71: delivered=67/67 tkeep=7/7    tuser=0 terminate_lane=7 error_pulses=0
PASS  lane 4 length 64: delivered=60/60 tkeep=15/15  tuser=0 terminate_lane=4 error_pulses=0
FAIL  lane 4 length 65: delivered=62/61 tkeep=31/31  tuser=0 terminate_lane=5 error_pulses=0
FAIL  lane 4 length 66: delivered=64/62 tkeep=63/63  tuser=0 terminate_lane=6 error_pulses=0
FAIL  lane 4 length 67: delivered=66/63 tkeep=127/127 tuser=0 terminate_lane=7 error_pulses=0
FAIL  lane 4 length 68: delivered=68/64 tkeep=15/255 tuser=0 terminate_lane=0 error_pulses=0
PASS  lane 4 length 69: delivered=65/65 tkeep=1/1    tuser=0 terminate_lane=1 error_pulses=0
PASS  lane 4 length 70: delivered=66/66 tkeep=3/3    tuser=0 terminate_lane=2 error_pulses=0
PASS  lane 4 length 71: delivered=67/67 tkeep=7/7    tuser=0 terminate_lane=3 error_pulses=0
```

**The invariant, and it fits every tested point.** Let `D` = the required
delivered-octet count (frame length − 4) and let

> `k` = the number of delivered octets in the frame's **final output word**
> = `((D − 1) mod 8) + 1`

Then the observed excess is

> **excess = max(0, k − 4)**

| D | k | predicted excess | observed | source |
|---|---|---|---|---|
| 1 | 1 | 0 | 0 | M03-C4, 5-octet runt — **passes** |
| 60 | 4 | 0 | 0 | L = 64, both lanes |
| 61 | 5 | **+1** | **+1** | L = 65, both lanes |
| 62 | 6 | **+2** | **+2** | L = 66, both lanes |
| 63 | 7 | **+3** | **+3** | L = 67, both lanes |
| 64 | 8 | **+4** | **+4** | L = 68, both lanes |
| 65 | 1 | 0 | 0 | L = 69, both lanes |
| 66 | 2 | 0 | 0 | L = 70, both lanes |
| 67 | 3 | 0 | 0 | L = 71, both lanes |
| 1514 | 2 | 0 | 0 | M03-C3, 1518-octet frame — **passes** |

**Ten tested values of `D`, spanning 1 to 1514, ten agreements.** The `4` in
`k − 4` is the FCS octet count, which is what makes this look like an
interaction between the final word's fill and FCS removal — but the root cause
is rtl_lead's to establish, not mine, and the paragraph above is a
characterisation of the *observable*, not a diagnosis.

**The failure is silent.** `tuser`[0] = 0 and `error_pulses` = 0 at every one
of the sixteen entries, including all eight failures. M03 reports these frames
as good.

**It is lane-independent.** The excess is identical at both start lanes for
every length (8/8), and it is **not** a function of the terminate lane (8/8
inconsistent across lanes). A downstream reader should not look for a
start-lane or terminate-lane story in the delivered count.

## The one entry where the lanes differ — `tkeep`, lane 4, length 68

`tkeep` matches its expectation at fifteen of sixteen entries. The exception is
**lane 4, length 68: observed 0x0F, expected 0xFF**, while the delivered count
(68) is the same as lane 0's at that length.

`tkeep` here is read from the **first** output word carrying `tlast`. So at
lane 0 that word holds 8 octets and at lane 4 it holds 4 — the excess octets
and the `tlast` marker are placed differently between the lanes, even though
the same number of octets is delivered.

This is the only entry satisfying **(excess > 0) ∧ (terminate_lane = 0)** —
the case where the terminate character sits alone in lane 0 of its word, which
SPEC-M03 §6.1 calls out explicitly for REQ-106 ("the terminate character in
lane 0 of cycle 9 means the previous word carried the last octet"). At lane 0
the `terminate_lane` = 0 entry is length 64, where the excess is zero, so the
two conditions coincide exactly once in sixteen.

It is reported here as part of this bug rather than as a second one: there is
no evidence the two observables are independent, and this entry carries the
most diagnostic information of the sixteen.

## Independent corroboration

Two observers with **different code paths** agree, in the same run:

1. `test_m03_c.ml`'s delivered-octet count, from `Stream_word.octets` over
   `tvalid` samples.
2. `test_m03_a.ml`'s **latency tagger** (`Dv_monitors.Octet_time.Latency`),
   which derives its octet counts from output-word octet times, verbatim:

   > `M03-A3 (length 65) lane 0: latency tagger errors:`
   > `frame 0: 73 input octets less 8 stripped from the front and 4 from the
   > back is 61, but 62 octets were emitted`

A third, weaker corroboration: **M03-A3's cross-lane tuple-sequence comparison
passed**, so the two lanes produce identical output streams — REQ-101 holds,
and whatever is wrong is deterministic and identical at both alignments.

## Why this is not a bench-oracle defect

Stated because dv_lead's own instrument was the defect in four earlier rounds
of WO-0038, so the question deserves an answer rather than an assurance:

1. **The oracle is exact at six tested points** — `D` = 1, 60, 65, 66, 67 and
   1514 — spanning three orders of magnitude, and wrong only at `D` ∈
   {61, 62, 63, 64}. An oracle that is right at 1 and at 1514 and wrong at 61
   is not an oracle error.
2. **SPEC-M03 §6.1's own worked example is the passing case.** The table's
   64-octet frame → 60 octets in 8 words, last `tkeep` 0x0F — reproduced
   exactly by the design and by the bench.
3. **`tkeep` agrees at 15/16 entries.** If the bench's delivered-count model
   were wrong, its `tkeep` model — derived from the same count — would
   disagree broadly, not once.
4. **Two independent observers**, above.
5. **No timing assertion fired anywhere in this run**, at either lane, after
   the sampling-convention repair of WO-0038 round 5. The bench's timing model
   is no longer in question.

## Severity: CRITICAL

Not for ceremony. M03 **silently** emits a frame longer than the one it
received — `tuser`[0] = 0, no strobe — for an ordinary class of legal
Ethernet frames. Every downstream stage (M06's demux, M14's IPv4 header check,
and eventually the MoldUDP64/ITCH parser) would consume a frame whose length
and trailing octets are wrong, with nothing anywhere reporting it. A loud
failure would be a lesser bug.

Per dv_lead's charter §7, a CRITICAL `BUG-` is **normal packet flow**, not an
escalation.

## A locked prediction, so the fix can be checked against something

The invariant above says the defect is governed by `k`, the final output
word's fill — **not** by frame length, and **not** by proximity to the
64-octet minimum. Those two readings diverge at large lengths, and the
programme should not have to guess which is right:

> **P-1.** A 1516-octet frame (`D` = 1512, `k` = 8) over-delivers by **+4**;
> a 1513-octet frame (`D` = 1509, `k` = 5) over-delivers by **+1**.
> If instead both pass, the defect is confined to short frames and the `k`
> invariant is wrong away from the minimum-frame region — in which case this
> packet's characterisation is corrected and the table above still stands as
> the observable.

dv_lead will add those two lengths as a probe alongside M03-C3 and report the
result on this packet, whether or not it agrees. **The prediction is recorded
before the run, and will not be restated after it.**

## What dv_lead is NOT claiming

- **No root cause.** dv_lead has not read `libs/**` and will not; the
  mechanism is rtl_lead's to establish and its `Root-cause` section is the
  precondition for the fix verdict below (charter §8).
- **No claim about untested `D`.** Only `D` ∈ {1, 60…67, 1514} has been
  driven. P-1 above is the experiment that extends it.
- **No claim that C1/C2 are the only affected rows.** Families D–H, which
  inject errors, have not been written yet; their interaction with this defect
  is unknown.

## Consequences for the sign-off path

**`SO-xgmii_rx_64.md` cannot issue.** M03-C1 and M03-C2 FAIL; eight of sixteen
directed-length entries are wrong. The mutation spot-check (WO-0038 §8) and the
line-rate stress rows L1–L5 remain owed on top of this.

## Fix verdict

*(appended by dv_lead after re-test; a fix entry must contain a `Root-cause`
section before the fix description — charter §8)*
