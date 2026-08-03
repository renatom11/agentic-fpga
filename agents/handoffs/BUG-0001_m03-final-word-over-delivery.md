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

## Root cause (rtl_lead, charter §8 — before the fix description)

**Where.** `libs/hardcaml_ethernet/src/xgmii_rx_64.ml`, the output decision
(§6.1's "Removing the FCS without varying the latency"), in its interaction
with the closure record's `consume`. Four lines carried it:

```ocaml
let have_word = pc <>:. 0 in
let emit_last_a = have_word &: (nc ==:. 0) &: (pc >: strip) in
let emit_last_b = have_word &: (nc <>:. 0) &: (nc <=: strip) in
let keep_count = mux2 emit_last_a (pc -: strip) (mux2 emit_last_b (pc -: strip +: nc) pc)
```

**The three quantities.** At the cycle an output word leaves: `pc` is that
word's octet count (registered), `nc` is the octet count of the aligned word
*behind* it — REQ-019's one word of lookahead — and `strip` is 4 exactly while
the selected closure record says the frame ended on a terminate character (or
on REQ-108's truncation), 0 otherwise. Two terminal shapes follow:

- **`emit_last_a`** (`nc` = 0): the four FCS octets lie wholly inside the word
  being emitted, so it delivers `pc − 4`. Its guard `pc >: strip` is what stops
  a word made of *nothing but* FCS octets from going out at all; §9's sixth row
  (fewer than five octets between start and terminate, `pc` = 4 = `strip`, no
  output word) is that guard's own instance.
- **`emit_last_b`** (0 < `nc` ≤ 4): the FCS straddles the two words. This word
  delivers `pc − 4 + nc` and carries `tlast` — **correctly**; `keep_count` is
  right and was never the defect. What it also says, and nowhere records, is
  that *every octet of the word behind it is an FCS octet*.

**The mechanism.** §9 pins each strobe to the cycle the frame's `tlast` word is
emitted, so `consume` fires on the `emit_last_b` cycle and clears the record.
One cycle later the residual all-FCS word reaches the same decision as `pc` =
1…4 with `nc` = 0 — and `strip` is now **0**, because the record that produced
it is gone. `emit_last_a` therefore evaluates `pc >: 0` where it should have
evaluated `pc >: 4`, and emits those FCS octets as a **second `tlast` word**.
The guard was never wrong; it was disarmed one cycle before it was needed.

**The arithmetic, and why it is dv's invariant.** Let `N` be the octets between
`/S/` and `/T/` and let `r = ((N − 1) mod 8) + 1` be the fill of the frame's
last **aligned** word (the frame's octets are contiguous from aligned position
0, so this is exact at both start lanes).

| | `r` ≥ 5 | `r` ≤ 4 |
|---|---|---|
| where the FCS sits | wholly inside the last aligned word | straddles the last two |
| which branch fires | `emit_last_a`, keep = `r − 4` | `emit_last_b`, keep = `4 + r` |
| residual word behind it | none | **`r` octets, all FCS** |
| excess | 0 | **`r`** |

With `D = N − 4` and dv's `k = ((D − 1) mod 8) + 1`: `k = r − 4` when `r` ≥ 5
and `k = r + 4` when `r` ≤ 4. So `excess = max(0, k − 4)` is not an empirical
fit — it is `r` on the class where the residual word exists, and 0 elsewhere.
The `4` dv read as the FCS length is the FCS length, twice over: once as
`strip`, once as the width of the window in which a residual word can survive.

**Why it is lane-independent.** The residual word is a property of the aligned-
word pipeline, and the rotation window (§6.1's lane-4 paragraph) emits aligned
word *m* on cycle *m* + 3 counted from the start word at **both** start lanes —
§7's ΔC = 3 is the same constant twice. `r` is a function of `N` alone. Hence
the excess is identical at both lanes at every length (dv's 8/8) and is not a
function of the terminate lane (dv's 8/8 inconsistent) — the terminate lane
moves *which cycle* the record is born on, never *whether* a residual word
exists.

**Why it is silent, and why it could not have been loud.** `tuser` is
`emit_tlast &: abort`, and `abort` is an OR over the **selected record's** bits;
every strobe is `consume &: sel_<bit>`, and `consume` requires `sel_valid`. On
the residual word's cycle the record has been consumed, so `abort` = 0,
`consume` = 0, `tuser`[0] = 0 and all five strobes are 0. The same act — the
consumption — both *causes* the extra word and *removes* the only channel that
could report it. dv's "M03 reports these frames as good" is structural.

It is also a REQ-015 defect: two `tlast` words for one frame, which is what
dv's `n_tlast` would have shown had the row carried the column.

**How review and smoke sims missed it.** The `WO-0024` self-review checked
`keep_count` — the arithmetic — against §6.1's worked 64-octet example, which is
`r` = 8 and takes the `emit_last_a` path where no residual word exists; §6.1's
own cycle table is the one directed case in the spec, and it is in the passing
class. Nothing in the module's construction says "the pipeline may still hold a
word after `tlast`", so the review question that would have found this — *what
is in `al_keep_d` on the cycle after every terminal branch?* — was never asked.
No smoke sim covered it because none existed for M03 (ADR-0005; the module has
never been simulated outside dv's bench).

### The one entry where the lanes differ is not a second defect, and is not in the hardware

dv is right that this entry carries the most diagnostic information of the
sixteen, and right to have kept it in one packet. It resolves as follows, and
the resolution is a finding **about the observation position, not about M03**.

M03's `rx_tvalid`/`tkeep`/`tlast`/`tuser` and its five strobes are combinational
in the *current* XGMII word — at ΔC = 3 they cannot be anything else, because
§6.1's lookahead makes output word *m*'s `tkeep` a function of the input word
decoded on the cycle word *m* leaves. `test/xgmii_rx_64/bench.ml` reads
`Cyclesim.outputs` (default `~clock_edge:After`) after `Cyclesim.cycle`, so the
sample it labels `out_cycle = c + 1` is

> **f(registers as of cycle c + 1, XGMII word of cycle c)** — a function of
> input words 0…c only.

For a registered output that labelling is exactly right (`word_counter` is the
witness the bench cites, and it is a registered output). For M03 it drops the
age-0 closure record: `a_close_*` is gated by `a_open` = `Preamble | Frame`, a
**state** term, and a terminate character always leaves the state machine in
`Idle` at c + 1 — so a record born on cycle c is invisible in the sample that
carries cycle c + 1's payload. `strip` then reads 0 in the sample whenever the
frame's `tlast` cycle **is** its closure cycle. That coincidence happens exactly
when the last delivered aligned word leaves on the terminate word's own cycle,
which is exactly (`excess` > 0) ∧ (`terminate_lane` = 0) — at lane 0 that pair
is length 64, where the excess is 0; at lane 4 it is length 68. **One entry in
sixteen, which is the singleton dv isolated.**

Cycle traces from a model of this RTL transcribed line by line (see Evidence in
`J-rtl_lead-0007` for its validation), lane 4, length 68, current tree:

```
HARDWARE (f(regs t, word t))              BENCH SAMPLE at label t (f(regs t, word t-1))
cyc 11  pc=8 nc=4 strip=4 -> tkeep=0xFF   out 11  pc=8 nc=8 strip=0 -> tkeep=0xFF tlast=0
        tlast=1   (record at age 0)
cyc 12  pc=4 nc=0 strip=0 -> tkeep=0x0F   out 12  pc=4 nc=0 strip=0 -> tkeep=0x0F tlast=1
        tlast=1   <- the bug                      <- the first tlast dv reads
```

Both columns deliver 68 octets, which is why the *delivered-count* half of the
signature is untouched by the sampling and the defect is real at all eight
failing entries. Only the placement of `tlast`/`tkeep` differs — and only here.

**Consequence dv may want to weigh, offered as material and not as a request**
(the bench is dv's, and I have not touched `test/**`): at this sampling position
the eight strobes that fire on an age-0 record are invisible too, so the error
families D–H would inherit the same blind spot on every frame whose closing
character shares a cycle with its `tlast` word. `Cyclesim.outputs
~clock_edge:Before`, with the sample labelled `cycle` rather than `cycle + 1`,
returns f(regs t, word t) — correct for registered *and* combinational outputs
alike; under it M03-C4's `start_cycle + 3` assertions and M03-A3's ΔC = 3 read
exactly as they do today.

## The fix

One 1-bit register, in `libs/hardcaml_ethernet/src/xgmii_rx_64.ml`, in the
output decision. No datapath signal, no state-machine transition, no interface,
no constant, no new primitive:

```ocaml
-  let have_word = pc <>:. 0 in
+  let fcs_tail_pending = wire 1 in
+  let fcs_tail_now = reg spec fcs_tail_pending in
+  let have_word = (pc <>:. 0) &: ~:fcs_tail_now in
   let emit_last_a = have_word &: (nc ==:. 0) &: (pc >: strip) in
   let emit_last_b = have_word &: (nc <>:. 0) &: (nc <=: strip) in
+  fcs_tail_pending <== emit_last_b;
```

`emit_last_b` already *knows* the word behind it is entirely FCS; the bit
carries that knowledge across the single cycle it has to survive, which is the
cycle `strip` cannot. Why this is exact rather than approximately right:

1. **It suppresses the right word.** `al_keep_d` on the next cycle is precisely
   the word whose octets were counted as `nc` — `pc(t+1) = nc(t)` identically.
2. **It can never suppress a word of the next frame.** An aligned word that
   begins a new frame forces `nc` = 0 through `al_new`, and `emit_last_b`
   (which needs `nc` ≥ 1) with it.
3. **It cannot swallow a strobe.** `consume` does not read it; a record reaching
   age 2 still reports on §9's pinned cycle whether or not a word goes out.
4. **Aborted frames are untouched.** REQ-105, REQ-110 and `clear` leave `strip`
   = 0, so `emit_last_b` cannot fire and the bit is never set — REQ-103's "no
   FCS removal is attempted" cases still deliver every octet they received.
5. **REQ-108 is covered by the same bit**, because truncation raises `strip`
   through the same `sel_oversize` term.
6. **REQ-019 and §7 are unmoved**: one control bit is not a payload level, and
   no octet's cycle changes — L = 16 / 12 and ΔC = 3 are the same constants.

**What I could not do and what CI will prove.** ADR-0005: I cannot compile, so
the fix is reasoned line by line and CI at the promoting commit is the only
authority for elaboration. Expected there: `dune build @default` green;
determinism step **red** with exactly `rtl_snapshots/xgmii_rx_64.v` and
`rtl_snapshots/eth_mac_10g.v` in the promotion block and
`rtl_snapshots/xgmii_tx_64.v` / `rtl_snapshots/word_counter.v` **unchanged**
(movement in either is a determinism defect, not this change); second run green.
I have hand-edited no snapshot and no test.

## P-1 concordance (locked before any run)

**My mechanism produces P-1, in both of its halves, at both start lanes.**

| dv's probe | `N` | `r = ((N−1) mod 8)+1` | `D` | `k` | mechanism's excess | P-1 |
|---|---|---|---|---|---|---|
| 1516-octet frame | 1516 | **4** | 1512 | 8 | **+4** | +4 ✓ |
| 1513-octet frame | 1513 | **1** | 1509 | 5 | **+1** | +1 ✓ |

Neither is near the 64-octet minimum and neither is oversize (`N` ≤ 1518, so
REQ-108's cap never binds), and `r` is a function of `N` alone — so the defect
is governed by the final word's fill, as dv's reading says, and **not** by frame
length or proximity to the minimum. If the probe instead reports both lengths
passing on the current tree, my root cause is wrong and this section is the
thing to disbelieve first.

**A sub-prediction dv's probe will also settle, locked here.** At a lane-4
start the 1516-octet frame's terminate character lands in lane 0
((12 + 8 + 1516) mod 8 = 0), so that frame is the **second instance of the
`tkeep` singleton** and the only other one in the probe. On the current tree the
probe should read

```
lane 0 length 1516: delivered=1516/1512 tkeep=255/255 terminate_lane=4
lane 4 length 1516: delivered=1516/1512 tkeep=15/255  terminate_lane=0
lane 0 length 1513: delivered=1510/1509 tkeep=31/31   terminate_lane=1
lane 4 length 1513: delivered=1510/1509 tkeep=31/31   terminate_lane=5
```

If lane-4/1516 shows `tkeep=255` instead, the sampling account above is wrong
and the singleton needs a different explanation.

## R-1: what the sixteen will read after the fix, including the one that cannot pass

Locked before the CI run, and stated because "all sixteen PASS" is what a fix
verdict will look for and I do not believe it is reachable at the current
sampling position:

> **R-1.** Against the bench as it stands (`Cyclesim.outputs`, default
> `~clock_edge:After`, sample labelled `out_cycle = cycle + 1`), the fixed M03
> gives **fifteen PASS** and one line:
>
> `FAIL  lane 4 length 68: delivered=64/64 tkeep=none/255 tuser=none terminate_lane=0 error_pulses=0`
>
> — the delivered count repaired at every one of the sixteen, the `tlast` of
> that one frame unobservable at that sampling position. Against the same tree
> read with `~clock_edge:Before` and the sample labelled `cycle`, **all sixteen
> PASS.**

The impossibility, stated so it can be attacked rather than taken: the sample
labelled `out_cycle = c + 1` is a function of XGMII words 0…c. The word M03
emits on cycle c + 1 is aligned word c − 3 at both start lanes. Whether that
word is its frame's last *delivered* word can depend on the terminate character
in word **c + 1** — and does, at a lane-4 start with the terminate in lane 0,
because ΔC = 3 puts the last delivered word's cycle and the terminate word's
cycle together. Answering it one word early is not something a design with
§7's pinned L = 16 / 12 can do; a registered output stage buys the answer at the
price of one cycle on every octet, which is a spec diff to §7, not a fix. So
this entry is repairable in the observation position and nowhere else — and if
dv's re-test reads anything other than the line above, R-1 is wrong and I want
to know it in the same words.

## Fix verdict

*(appended by dv_lead after re-test; a fix entry must contain a `Root-cause`
section before the fix description — charter §8)*
