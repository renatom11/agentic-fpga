# WO-0070: family L — line rate, constancy and order (M03-L1 … M03-L5), opened by a Cyclesim cost probe whose decision rule is fixed before the first row exists

- **Type**: Work order (PROTOCOL §3). **State**: `DRAFT` → `ISSUED` on commit.
- **From**: dv_lead. **To**: the orchestrator, then tb_writer — **in two stages,
  and stage 2 does not issue until §1.6's ruling is written into this packet's
  Return log.**
- **Plan rows**: `test/attack_plans/AP-xgmii_rx_64.md` §4.L — **M03-L1, M03-L2,
  M03-L3, M03-L4, M03-L5**. M03-L6 is STRUCTURAL and landed at WO-0038; it is
  not in this round.
- **Spec basis**: SPEC-M03 §6.1 (the `m + 3` formula and its gapless
  qualifier), §7 (the timing contract), §8 (the line-rate stress obligation),
  §9; requirements.md REQ-004, REQ-005, REQ-019, REQ-020, REQ-103, REQ-111,
  REQ-112, §0.3, §0.5, §0.6.
- **Context provided to tb_writer**: this packet, the plan rows above, the spec
  sections above, `test/xgmii_rx_64/bench.mli`, `test/xgmii/arrival.mli`,
  `test/xgmii/frame.mli`, `test/monitors/octet_time.mli`. **No `libs/**`, no
  `top/**`, no `rtl_snapshots/**`** (PROTOCOL §10).
- **Base commit**: `d2bdd57`, branch
  `claude/fpga-hardcaml-agent-orchestration-37ceyf`.

---

## 0. What this round is, and what it is load-bearing for

Family L is the last family whose absence blocks a **gate line of its own**.
PROTOCOL §7 makes *"line-rate stress green for rx-path modules"* a
`P1-module-ready` precondition, and charter §5's DoD repeats it as a checklist
line **separate from** the per-row sign-off line. So the worker should know what
it is building: **not the fifth family of a census, but the evidence behind a
gate row that no number of other rows can supply.** At `d2bdd57` the census is
48 of 62 with fourteen ASSERT rows outstanding (K1, K2, L1–L5, M1–M7); if the
other nine landed tomorrow and L did not, `P1-module-ready` would still be
unsignable on the stress line alone.

This round is also the first bench in this suite whose **runtime is not
trivially bounded**, and that is why the packet opens with a probe rather than a
row. Every prior M03 unit drives tens of cycles. L1–L4 drive **105 010**
(§2.2, derived). The cost lands in `dune runtest`, and it lands there
**permanently** (§1.1). A round that discovers that after writing five rows has
written five rows it may have to unwrite.

---

## 1. The cost probe — the round's first gate

### 1.1 The cost is recurring, not one-off, and that is what sets the stakes

`test/xgmii_rx_64/dune` declares one `(library)` with `(inline_tests)` and no
`(modules …)` partition. A new `test_m03_l.ml` is therefore picked up
automatically **and its units run inside the main `dune runtest` step of every
future CI run of this programme.** The `runtest` step at build `30988038809` ran
**08:17:01 → 08:17:04**, three seconds (`RV-0068B-VERDICT` §1, read as a step
reading). Whatever family L costs, every commit by every agent from here to
`P1-phase-accept` pays it.

That is the quantity the probe measures. It is not "can we afford one run"; it
is "what tax are we minting, and is it the right size for what it buys".

### 1.2 Why the probe runs on a throwaway ref and never enters history

**The probe is NOT committed to the working branch.** The orchestrator
materialises `test/cost_probe_l/` (Appendix A) on a throwaway ref cut from
`d2bdd57`, lets CI run once, records the printed figures, and discards the ref —
PROTOCOL §10's transient model, operated exactly as it was for `BUG-0003` §V.2 /
§V.10.1, where a dv-authored, print-only, zero-assertion probe ran at CI run
`30947784963` on ref `mut/bug3-sev-probe` and nothing entered history.

Three grounds, and the third is the decisive one:

1. **A committed probe is the cost it exists to measure.** On the `runtest`
   alias it would tax every CI run for as long as it lived.
2. **`test/cost_probe/` is the committed proof that "delete it once the figure
   is recorded" does not get executed.** Its own first line reads *"THROWAWAY —
   WO-0009 deliverable 1. Delete this directory once the figure is recorded."*
   The figure **was** recorded — 3.42 M cycles/s at 1 register, 1.77 M at 8,
   653 k at 32, CI run `30729880948` — and the directory is still in the tree at
   `d2bdd57`, on the `runtest` alias, four weeks later. The end condition was met
   and not executed. I am not minting a second one.
3. **If band C fires (§1.5), a committed probe would leave the programme
   carrying a permanently-unaffordable artefact on `runtest` while an E2 is
   adjudicated.** On a throwaway ref, band C costs one run and nothing else.

**Routed to the orchestrator as this round's only pre-row action.** No worker is
spawned for stage 1.

### 1.3 What the probe measures — five phases, because one number sizes nothing

`test/cost_probe/`'s own docstring established the rule this reuses: *"Three
sizes are run, because one number does not size anything: what the plan needs is
the slope."* Family L needs the slope **and** the decomposition, because the
remedy differs by phase (§1.5's band-B table) and a single total cannot select
one.

| Φ | phase | what it times, exactly |
|---|---|---|
| **Φ1** | `schedule` | `Dv_xgmii.Arrival.stress ~count ()` — lays out `count` frames, each built by `Frame.stress_frame`, which computes one CRC-32 per frame |
| **Φ2** | `check` | `Dv_xgmii.Arrival.check sched` — standing obligation 5, one `Frame.residue_ok` (a second CRC-32) per frame plus the gap/lane/ordering sweep |
| **Φ3** | `elaborate` | `Bench.create ()` — one `Cyclesim` elaboration of M03 plus the four standing monitors |
| **Φ4** | `drive` | `Bench.run bench sched ~drain:8 ()` — the whole drive/sample loop: `Arrival.word_at` per cycle, `Cyclesim.cycle`, the two probe reads, the protocol and strobe monitor feeds, and the `sample` record allocation. **Note Φ4 re-runs `Arrival.check` internally; Φ2 is how much of Φ4 that is.** |
| **Φ5** | `account` | the per-frame left-to-right pass: `split_at_first_tlast` on the remainder, then `Bench.account_clean_frame` per frame (conservation + the latency tagger's two calls) |

Sizes **ascending, flushed after each**: `count` ∈ **{100, 1 000, 10 000}**. The
ordering and the flush are load-bearing: **if the probe dies at a size, the log's
last completed line names the largest size this runner survived, and that is
itself a measurement rather than an obstacle.**

Per size the probe prints one line, and every line begins `COST-PROBE-L` so it
is greppable out of a build log:

```
COST-PROBE-L count=<n> schedule=<s> check=<s> elaborate=<s> drive=<s> account=<s> total=<s> cycles=<n> dsamples=<n> frames=<n> top_heap_words=<n>
```

CPU time via `Sys.time`, not wall clock — a shared runner's descheduling must not
move the figure (`test/cost_probe/`'s own reasoning, adopted). Peak heap via
`Gc.quick_stat ()`'s `top_heap_words`, which is cheap and does not walk the heap.

**Self-cap.** After each size, if cumulative `total` exceeds **300 s** the probe
prints `COST-PROBE-L abort` naming the last completed size and exits 0. A probe
that hangs a runner answers no question.

### 1.4 My predictions, stated openly so the probe can score them

These are **not** a seal (R-SEAL-1 does not reach them: nothing is withheld —
the numbers are here, in the commit that introduces the claim). They are stated
so that a miss is visible, on the `BUG-0003` §9.2-versus-§V.10.2 pattern where a
derived figure was published before the measurement existed and then scored
against it.

| quantity at `count` = 10 000 | prediction | reasoning |
|---|---|---|
| Φ1 `schedule` | 0.1 – 0.5 s | 10 000 × one CRC-32 over 60 octets, bitwise (`Crc32_ref.step_register` per octet) ≈ 4.8 M bit-steps |
| Φ2 `check` | 0.1 – 0.5 s | 10 000 × `residue_ok` over 64 octets ≈ 5.1 M bit-steps; the gap/lane sweep is `Array.iter` over 10 000 |
| Φ3 `elaborate` | < 0.5 s | one elaboration; the suite already pays ~54 of them per run |
| Φ4 `drive` | **2 – 15 s** | 105 010 cycles. `Cyclesim.cycle` alone extrapolates to ≈ 0.16 s from `test/cost_probe/`'s 653 k cycles/s at 32 registers. The rest is OCaml-side: 8 binary searches per cycle inside `Arrival.word_at` over 10 000 frames (≈ 11.8 M comparisons), two `Stream_word` reads, two monitor feeds and one record allocation per cycle |
| Φ5 `account` | 1 – 5 s | 10 000 × (`split_at_first_tlast` over 8 samples + two `Octet_time` array builds of 72 and 60 + 60 latency notes) |
| **total** | **4 – 20 s** | — |
| `top_heap_words` | 2 × 10⁷ – 1 × 10⁸ | 105 010 retained `sample` records, each holding one `Xgmii_word.t`, two `Stream_word.t` and a `string list`, plus the 10 000 × 64-octet schedule |
| `total(10 000) / total(1 000)` | **≈ 10** | every phase above is linear in `count`; the binary search's log term is the only sublinear part and it moves by one step between 1 000 and 10 000 |

**The prediction that matters is the ratio, not the total.** If
`total(10 000) / total(1 000)` comes back near 10, the cost model above is right
and the total is whatever it is. If it comes back above 15, something is
super-linear that I have not found, and that is a more interesting result than
any of the seconds.

### 1.5 THE DECISION RULE — pre-committed, before any row is built

> **Read `T` as `total` at `count` = 10 000, `R` as
> `total(10 000) / total(1 000)`, and `H` as `top_heap_words` at `count` =
> 10 000, all from the probe's own printed lines at the throwaway ref's CI run.**
>
> **Band A — ACCEPT AS SPECIFIED. Fires iff `T` ≤ 30 s AND `R` ≤ 15 AND the
> `count` = 10 000 line printed.** Stage 2 issues with §§4–8 exactly as
> written: L1–L4 as **one** `%expect_test` over **one** 10 000-frame
> `Bench.run`, L5 as its own unit. No machinery change. `runtest` goes from
> ~3 s to ≤ ~33 s, which keeps it a minority of a `build` job whose dominant
> costs are `opam install --deps-only --with-test` and `dune build @default`.
>
> **Band B — MACHINERY FIRST, THE STIMULUS UNCHANGED. Fires iff the
> `count` = 10 000 line printed AND (30 s < `T` ≤ 180 s OR `R` > 15 OR
> `H(10 000) > 8 × H(1 000)`).** The 10 000-frame stimulus is **not** reduced
> at this band — §8's frame count is a specification figure, not a bench
> parameter. A machinery round lands first, its remedy selected by the
> **dominant phase** from the table below, and the probe is re-run at the
> throwaway ref afterwards. **Band A must be reached before any row lands.**
>
> **Band C — E2 ESCALATION, AND NO ROW IS WRITTEN. Fires iff `T` > 180 s, OR
> the `count` = 10 000 line did not print (self-cap, out-of-memory, timeout or
> exception).** I raise an **E2** (charter §7, PROTOCOL §8) to the orchestrator
> carrying the measured figures, three options and a recommendation:
> (i) the band-B machinery redesign, costed against the measurement;
> (ii) a reduced frame count, with the coverage loss stated in §8's own terms
> and REQ-004's stress figure named as the thing being narrowed;
> (iii) moving family L to `hardcaml_verilator`, which the charter §9 test
> stack already names for heavy runs.
> **The frame count is not reduced inside DV under any circumstances.** §8's
> 10 000 is a frozen specification figure; narrowing it is a scope change and
> goes up as options + recommendation + cost, never as a bench decision.

**Band-B remedy table — one remedy per dominant phase, pre-committed so the
remedy is not chosen after the number is known:**

| dominant Φ | remedy | scope |
|---|---|---|
| **Φ1** | the schedule is already built once for the whole round; if it still dominates, memoise `Frame.stress_frame`'s constant 14-octet prefix and its 42-octet filler so only the 4 sequence octets and the CRC are recomputed per frame | `test/xgmii/frame.ml` — dv scope |
| **Φ2** | **none, and that is the pre-commitment.** Standing obligation 5 is not negotiable: *"a stimulus generator nobody has checked is an unverified assertion about the design"*. If Φ2 dominates, its cost is **reported and accepted**, and the band is decided on `T` with Φ2 included | — |
| **Φ3** | one elaboration cannot dominate; if it does, the finding is that elaboration is this suite's floor and no row-side change helps. Recorded as data and routed to rtl_lead, not repaired here | — |
| **Φ4** | (a) a folding entry point `Bench.run_fold` that consumes each cycle's `sample` and does **not** retain the list; (b) suppress the second, diagnostic-only `after_out` read for this row. Both must leave every landed unit byte-identical in behaviour, which is bar L-2's subject | `test/xgmii_rx_64/bench.ml`/`.mli` — dv scope |
| **Φ5** | the per-frame split is a **single left-to-right pass** over the remainder. If Φ5 dominates and the pass is already left-to-right, the remedy is to drop the intermediate per-frame `int list` allocations and compare octet-by-octet against `Arrival.delivered frame` in place | the row's own code |

### 1.6 Who applies the rule, and when

**I do, in writing, in this packet's Return log, before stage 2 issues.** The
ruling names the band, quotes the three measured figures it fired on, scores
§1.4's predictions one by one, and — if band B or C — names the remedy or the
escalation. **No worker applies this rule**, and `BL10` (§13) makes proceeding
without the written ruling a bounce.

This is `BUG-0003` §V.10.3's shape: a rule fixed in a committed artefact before
the run, then applied to figures nobody could re-read afterwards.

### 1.7 The probe's source

Appendix A, verbatim. **One construction risk, named with its symptom and its
remedy** (my own `RV-0068B-VERDICT` §8 item 1 rule: state an exception in the
terms the instrument reports, never predict an instrument's output from intent):
the probe depends on `test_xgmii_rx_64`, which is a `(library)` with
`(inline_tests)`. If dune refuses that dependency, the symptom is a dune error
at `(libraries …)` naming `test_xgmii_rx_64`, and the remedy is to move
`l_cost_probe.ml` into `test/xgmii_rx_64/` and partition the existing stanza with
`(modules …)`. On a throwaway ref that repair costs one run and nothing else. I
cannot compile OCaml at the review tree (ADR-0005), and I am not pretending
otherwise.

---

## 2. The derivation base — the schedule, from `Arrival`'s own arithmetic

Everything below is derived at `d2bdd57` from `test/xgmii/arrival.ml`'s
`create`/`stress` and requirements.md §0.3, not recalled. **The worker asserts
these; it does not re-derive them.**

### 2.1 Start octet times, lanes, cycles, spacings, gaps

`Arrival.stress ()` is `create` over `List.init 10_000 (fun i ->
Frame.stress_frame ~sequence:i ())` with every default: `ifg = 12`,
`first_start = 8`, `fcs_valid = true`, `filler = fun offset -> offset`.

`create`'s layout loop, at `floor_gap = min 12 9 = 9` and `credit = 0`:
`shorten = min 0 3 = 0`, `target = terminate + 12`, `next = round_up_4 target`.
For a 64-octet frame at start `s`: `terminate = s + 8 + 64 = s + 72`,
`target = s + 84`, and `s + 84` is already a multiple of 4, so `next = s + 84`
and the credit never moves. **The DIC path is therefore never taken on this
schedule**, which `arrival.mli` states independently.

| quantity | value at frame index `i` | derivation |
|---|---|---|
| `start_octet_time` | **8 + 84 i** | `first_start = 8`, then +84 per frame |
| `start_lane` | **0 for even `i`, 4 for odd `i`** | `(8 + 84 i) mod 8 = 4 i mod 8` |
| `start_cycle` | **1 + 21 k** for `i = 2k`; **11 + 21 k** for `i = 2k + 1` | integer division of the octet time by 8 |
| `start_spacings` | **10, 11, 10, 11, …**, 9 999 entries, first is 10 | 84 octet times is 10.5 cycles |
| `gaps` | **12** at every one of the 9 999 entries | `next − terminate = (s + 84) − (s + 72)` |
| `terminate_octet_time` | 80 + 84 i | `start + 8 + 64` |

Frame **9999** (odd, `k = 4999`): start octet time **839 924**, start lane **4**,
start cycle **104 990**, terminate octet time **839 996**.

**REQ-004's alternation is asserted, never assumed.** `arrival.mli` is explicit:
*"A bench that asserted the alternation by construction would prove nothing about
the arrival rate; here both are consequences of the gap arithmetic and are
checkable against the requirement."* `Arrival.start_lanes` and
`Arrival.start_spacings` exist for exactly this and the row calls both.

### 2.2 The run's extent

| quantity | value | derivation |
|---|---|---|
| `Arrival.cycles sched` | **105 002** | `((839 996 + 12 + 7) / 8) + 1 = 105 001 + 1` |
| cycles driven, `~drain:8` | **105 010** | cycles `0 … 105 001`, then 8 idle |
| samples returned by `run` | **105 010** | one per driven cycle |
| output words per frame | **8** | 60 delivered octets, `ceil(60 / 8)` |
| `delivered_samples` | **80 000** | 10 000 × 8 |
| `tlast` samples | **10 000** | one per frame |
| delivered octets, total | **600 000** | 10 000 × 60 |

**`drain:8` is not load-bearing here, and the packet says so rather than leaving
it to look load-bearing.** Frame 9999's last output word is at cycle
`104 990 + 7 + 3 = 105 000`, which is inside the schedule's own trailing gap
(`105 002` cycles). The drain is carried for consistency with every other unit in
this suite; it is not what makes the last frame observable.

### 2.3 Gaplessness, per frame, and why every constant below depends on it

SPEC-M03 §6.1's `m + 3` formula holds **on a gapless stimulus**, defined there as
one in which *"the frame's octets occupy consecutive octet times from the start
character onward, so that no XGMII word between the start word and the word
carrying the terminate character is an idle word."*

For every frame of this schedule: the start character is at `s`, the preamble
occupies `s … s+7`, the frame octets `s+8 … s+71`, the terminate character
`s+72`, and **nothing is injected between them** — `Arrival` emits idle only in
the gap `s+72 … s+83`. The condition is per frame and holds at every one of the
10 000. The inter-frame gap lies **outside** the span the condition constrains,
so a gapped *run* is still a gapless *stimulus* for each of its frames. This is
the sentence a bench writer gets wrong, and it is why it is written here.

---

## 3. The latency constants — re-derived at THIS tree

`RV-0068-VERDICT` §3.4 derived L = 16 at h = 8, L = 12 at h = 12 and
ΔC = (L + h)/8 = 3 four days before this packet. **I have re-derived all three at
`d2bdd57` from the primary sources rather than transcribing them, and I state the
re-derivation as a measurement, not as agreement.**

### 3.1 h, from `octet_time.ml`'s own definition

`test/monitors/octet_time.ml:7`:

```
let front_offset ~strip_octets ~start_lane = strip_octets + start_lane
```

At M03, `strip_octets = 8` (REQ-102's eight preamble octets, `Bench.create`'s
own tagger configuration). So **h = 8 at a lane-0 start and h = 12 at a lane-4
start.**

The tagger does not take h on trust: `octet_time.ml:207-208` computes
`base = 8 * (in_times.(0) / 8)` and `h = in_times.(strip_octets) - base`, which
is §0.5's definition verbatim. Checked against §2.1's octet times:

- lane 0, frame at `s = 8c`: `in_times.(0) = 8c`, `base = 8c`,
  `in_times.(8) = 8c + 8`, **h = 8**.
- lane 4, frame at `s = 8c + 4`: `in_times.(0) = 8c + 4`,
  `base = 8 × ((8c+4)/8) = 8c`, `in_times.(8) = 8c + 12`, **h = 12**.

### 3.2 ΔC, from SPEC-M03 §6.1's `m + 3`

§6.1: *"output word m is emitted on the cycle **m + 3** counted from the word
carrying the start character; that single sentence is the whole timing contract
and §7 derives the latency constants from it."* At `m = 0` the first output word
leaves on `start_cycle + 3`. §7's word delay is defined between *"the cycle of
the XGMII word carrying the frame's start character and the cycle of the first
output word of that frame"*. Therefore

> **ΔC = (start_cycle + 3) − start_cycle = 3, at both start lanes**, because the
> formula counts from the start **word**, not from the start **lane**.

§6.1 confirms it independently through D(m): *"on a gapless stimulus D(m) is the
word after word m's octets, or the word carrying them where that word also closes
the frame, so `m + 3`, §7's L = 16 / 12, ΔC = 3, the drain window and every cycle
§6.1 and §9 pin are reproduced exactly, at both start lanes and every length."*

### 3.3 L, twice, by two routes

**Route 1 — from ΔC and h.** §0.5's closure is ΔC = (L + h)/8, so
L = 8ΔC − h = 24 − h: **L = 16 at h = 8**, **L = 12 at h = 12**.

**Route 2 — directly in octet times, which is what the tagger measures.**
`Latency` records, per output octet `j`, the quantity
`out_times.(j) − in_times.(j + strip_octets)` (`octet_time.ml:239`).

Output octet `j` sits at `tdata` position `j mod 8` of output word `⌊j/8⌋`
(§6.1, REQ-021), and that word leaves on cycle `c + ⌊j/8⌋ + 3` where `c` is the
start cycle. So its octet time is

```
8 × (c + ⌊j/8⌋ + 3) + (j mod 8) = 8c + 24 + j
```

because `8⌊j/8⌋ + (j mod 8) = j`. And `in_times.(j + 8) = s + 8 + j`.

- lane 0, `s = 8c`: L = (8c + 24 + j) − (8c + 8 + j) = **16**.
- lane 4, `s = 8c + 4`: L = (8c + 24 + j) − (8c + 12 + j) = **12**.

Both routes agree, and the second is the stronger: **it cancels `j` entirely**,
which is §3.4's whole content.

**Verification against `word_cycles`** (`octet_time.ml:9-12`):
`word_cycles ~front_offset:8 16 = Some ((16+8)/8) = Some 3` and
`word_cycles ~front_offset:12 12 = Some ((12+12)/8) = Some 3`. Both close mod 8,
so neither returns `None`. The `?ceiling:4` `Bench.create` passes is REQ-019's
§1.1 ceiling and 3 ≤ 4.

### 3.4 Length independence — why M03-L5 needs no new constant, and what it still buys

Route 2's cancellation of `j` is independent of the frame length `N`: the
derivation uses only that output word `m` leaves at `c + m + 3` and that output
octet `j` is at position `j mod 8` of word `⌊j/8⌋`. Neither mentions `N`. So

> **L = 16 / 12 holds at every length for which the stimulus is gapless and the
> frame is cleanly closed — 64 … 71 and 1518 alike.** M03-L5 introduces **no new
> constant**; it asserts the same two.

**What M03-L5 buys, stated so nobody reads it as ceremony**: the derivation above
is a derivation *about the specification*. M03-L5 is where the **design** is
asked whether its delay varies with the final `tkeep` residue — the row's own
Kills cell. The stress run is fixed at one length and can see no such variation;
the directed set drives all eight residues plus the maximum-length frame. The row
is worth writing precisely because its expected value is unsurprising.

### 3.5 Agreement with `RV-0068-VERDICT` §3.4, stated as a measurement

All three constants re-derived above **agree with the four-day-old figures, in
every cell**: L = 16 at h = 8, L = 12 at h = 12, ΔC = 3 at both, ceiling 4.
Sources re-read at `d2bdd57`: `test/monitors/octet_time.ml:7`, `:9-12`,
`:207-208`, `:239`; SPEC-M03 §6.1's `m + 3` paragraph and its D(m) consequence
paragraph; SPEC-M03 §7's table. The agreement is recorded as a re-measurement
because a restated constant and a re-derived one are different evidence classes,
and this packet seals five rows onto these numbers.

---

## 4. M03-L1 — the run, the extent, the sequence pairing, the empty strobe set

**Attacks**: REQ-004, §8 checks 1–2. **Stimulus**: §2's schedule, whole.

### 4.1 Derived values — every one of them, none ordered checked

| # | quantity | derived value | derivation |
|---|---|---|---|
| 1 | frames presented | **10 000** | `Arrival.stress ()`'s default `count` |
| 2 | frames delivered (`tlast` count) | **10 000** | §8 check 1; every frame is one M03 accepts (§4.2) |
| 3 | output words per frame | **8** | `ceil(60 / 8)` |
| 4 | `tkeep` on words 0…6 | **0xFF** | §7's handshake rule: `tkeep` is 0xFF except on the `tlast` word |
| 5 | `tkeep` on word 7 | **0x0F** | 60 mod 8 = 4 octets, positions 0…3 |
| 6 | `tlast` | on word **7** only | REQ-015; the `tlast` word is counted in the total |
| 7 | `tuser`[0] on the `tlast` word | **0** | no abort condition arises (§4.2) |
| 8 | delivered octets per frame | **60** | REQ-103 strips the four FCS octets from 64 |
| 9 | delivered octet values | **`Arrival.delivered frame`**, positionally | REQ-103: DA through the last octet before the FCS |
| 10 | filler octets 18…59 | **18 … 59** | `Arrival.stress`'s default `filler = fun offset -> offset`; §8's *"any fixed pattern, stated by the bench and constant across the run"* is discharged by that default, and this line is the statement |
| 11 | `Bench.error_pulses samples` | **`[]`** | §4.2 |
| 12 | start lanes | 10 000 entries, **0, 4, 0, 4, …** | §2.1 |
| 13 | start spacings | 9 999 entries, **10, 11, 10, 11, …** | §2.1 |

### 4.2 The empty strobe set — derived, strobe by strobe

All five names are `Bench.strobe_names`, in the `O` record's field order.

| strobe | requirement | why it cannot fire on this run |
|---|---|---|
| `error_bad_fcs` | REQ-104 | every frame carries the correct FCS (`Frame.with_fcs` builds it from `Crc32_ref`, and `Arrival.check` verifies `residue_ok` per frame because `fcs_valid` defaults true). No residue mismatch exists to report |
| `error_runt` | REQ-107 | the runt class is 5…63 octets between start and terminate; every frame is **64** |
| `error_oversize` | REQ-108 | the oversize class is above 1518 octets; every frame is **64** |
| `error_bad_frame` | REQ-105 | an `/E/` between start and terminate is required, and §8 fixes the **error-injection rate at zero in this run**; `Arrival` emits no `/E/` at all |
| `error_start_without_terminate` | REQ-110 | requires a new `/S/` before the open frame's `/T/`. Frame `i` is closed by its own terminate character at octet time `s + 72`; the next start character is at `s + 84` (§2.1). 84 > 72 at every frame |

⇒ **`Bench.error_pulses samples = []` over the whole run.**

**This must be asserted row-locally, not left to the standing `Strobe_monitor`.**
`AP-xgmii_rx_64.md` §2 item 4(c) records the measurement: under `WO-0063B`'s IC-1
all nine no-output-word registrations reddened and **every conviction was
row-local — the standing monitor spoke at none of them.** A row that outsources
its strobe reading to the standing monitor is outsourcing it to an instrument
this plan has measured to be silent.

### 4.3 The pairing, and the reordering question M03-L4 owns

L1 pairs the **k-th** delivered frame with `Arrival.frames sched .(k)` — by
order. That pairing is what makes item 9 a content check; it is **not** evidence
about ordering, because it assumes the order it would otherwise test. Ordering is
M03-L4's, through a different instrument, and §7 states the overlap honestly.

---

## 5. M03-L2 — one L per front-offset class, over the same run

**Attacks**: REQ-005, REQ-111, §8 check 3, §0.5.

`Bench.create` builds the tagger `~strip_octets:8 ~tail_octets:4
~front_offsets:[8; 12] ~ceiling:4`. `Latency.observed` returns one record per
observed front-offset class, **sorted ascending by `front_offset`**
(`octet_time.ml:251-253` — verified, not assumed).

| field | class h = 8 | class h = 12 | derivation |
|---|---|---|---|
| `front_offset` | **8** | **12** | §3.1 |
| `latencies` | **`[16]`** | **`[12]`** | §3.3; a conformant design yields exactly one distinct L per class |
| `word_delay` | **`Some 3`** | **`Some 3`** | §3.2, and `word_cycles` closes mod 8 in both |
| `frames` | **5 000** | **5 000** | even indices 0…9998 are lane 0, odd 1…9999 are lane 4 |
| `octets` | **300 000** | **300 000** | 5 000 × 60 compared octets (`c.n_octets` accumulates `got`) |

**Assert the two records whole, and match a class by its `front_offset` field —
never by list position.** Asserting the record whole pins the classification and
the constant together: a design that produced the right L in the wrong class, or
that split one class in two, cannot pass a whole-record comparison.

**"One value per start lane across all 10 000 frames, not a mean"** is §8 check
3's own wording and it is what `latencies` being a **single-element list**
expresses. A row that asserted `List.hd latencies = 16` would accept
`[16; 24]` — the exact defect §0.5's per-class constancy exists to catch.

---

## 6. M03-L3 — ΔC, the front-offset set, and the reserve

**Attacks**: REQ-019, §1.1, §7.

| # | assertion | derived value | derivation |
|---|---|---|---|
| 1 | `Latency.word_delay (Bench.latency t)` | **`Some 3`** | both classes yield 3, so the whole-run accessor agrees (`octet_time.ml:287-295`) |
| 2 | `Latency.errors (Bench.latency t)` | **`[]`** | carries §0.5's closure, REQ-019's ceiling comparison and §0.5's start-lane bound |
| 3 | `Latency.frames_compared` | **10 000** | one `frame_out` per frame |
| 4 | `Latency.octets_compared` | **600 000** | 10 000 × 60 |
| 5 | observed front-offset set | **exactly {8, 12}** | jointly pinned by items 2 and 3 plus §5's two records — see below |

**Why items 2, 3 and §5's two records jointly pin "8 or 12 and no other value".**
`octet_time.ml:209-221` errors on a frame whose observed h is outside
`~front_offsets`, **and still creates a class for it** (`:232`). So a run
containing a frame at h = 16 would produce a non-empty `errors` (item 2 fires) or
a third record in `observed` (§5's comparison fires) or a frame-count shortfall
against item 3. All three exits are closed. **This is the derivation the AP row's
"and no other value" cell needs, and it is here rather than left to the worker.**

**The one unspent cycle — an adjudication, because the row's word is
"reported".** The AP row reads *"the one unspent cycle is reported as M03's
reserve"*. It **cannot** be reported by printing: every `%expect` block in this
suite is `{||}` and bar N-5 counts them, so a printed reserve would populate a
block and redden the round. The reserve is therefore discharged **here**, in the
packet:

> ΔC = 3 against §1.1's ceiling of 4. **M03's reserve is 1 cycle.** SPEC-M03 §7
> states why it is deliberate: *"M03 is the hardest receive module and the one
> most likely to need a cycle later, and a module pinned at its ceiling turns any
> future change into a slack-release spec diff."*

and the row's contribution is to assert its two operands — item 1 pins ΔC = 3,
and item 2 pins the ceiling comparison, because that comparison is where
`~ceiling:4` lives in the tagger. A `SO-` citing M03's reserve cites this
paragraph and those two assertions, not a log line.

---

## 7. M03-L4 — the delivered sequence is exactly 0 … 9999

**Attacks**: REQ-020, §8 check 2.

**Assertion**: reading each delivered frame's octets 14…17 back through
`Frame.sequence_of` (`frame.ml:40-47`: `at 14 lsl 24 lor at 15 lsl 16 lor
at 16 lsl 8 lor at 17`, REQ-012's most-significant-octet-first order), **in
`tlast` order across the run**, yields exactly `[0; 1; 2; …; 9999]` — 10 000
entries, no gap, no repeat.

`Frame.sequence_of` requires at least 18 octets; each delivered frame has 60.

**The overlap with M03-L1, stated rather than hidden.** §8 put the sequence
number **inside the payload**, so M03-L1's positional content check
(item 9 of §4.1) already compares octets 14…17 of every frame against its
schedule entry. On this stimulus **M03-L4 is implied by M03-L1**, and a `SO-`
packet may not present them as two independent pieces of evidence. What M03-L4
adds is the **direct statement of REQ-020** through the field decoder in delivery
order — the reading a requirement-to-test matrix row cites — where M03-L1's
reading is §8 check 2's octet-equality half. One stimulus, two readings, and the
packet says so; a round that let this pass as two independent confirmations would
be inflating its own coverage.

---

## 8. M03-L5 — the directed lengths, at both start lanes

**Attacks**: REQ-005, REQ-103, §8's directed set. Also REQ-005's own verification
column, which commissions this set in terms: *"Directed lengths 64 through 71
inclusive (covering all eight `tlast` `tkeep` patterns) plus 1518, at both start
lanes."*

**Stimulus**: nine lengths × two lanes = **18 independent runs**, each on its own
`Bench.t`. `Bench.run_directed_lengths ~lane` already drives 64 … 71 on a fresh
instance per length; **1518 is not in `Bench.directed_lengths`** and is built by
the row as `Bench.one_frame ~lane (Bench.directed_frame_octets ~length:1518)`
with `~drain:8`.

### 8.1 Derived, per length

| length ℓ | delivered ℓ−4 | output words | `tlast` `tkeep` | L at lane 0 | L at lane 4 | ΔC |
|---|---|---|---|---|---|---|
| 64 | 60 | 8 | 0x0F | 16 | 12 | 3 |
| 65 | 61 | 8 | 0x1F | 16 | 12 | 3 |
| 66 | 62 | 8 | 0x3F | 16 | 12 | 3 |
| 67 | 63 | 8 | 0x7F | 16 | 12 | 3 |
| 68 | 64 | 8 | 0xFF | 16 | 12 | 3 |
| 69 | 65 | 9 | 0x01 | 16 | 12 | 3 |
| 70 | 66 | 9 | 0x03 | 16 | 12 | 3 |
| 71 | 67 | 9 | 0x07 | 16 | 12 | 3 |
| **1518** | **1514** | **190** | **0x03** | 16 | 12 | 3 |

`tkeep` = `(1 lsl ((ℓ−4) mod 8)) − 1`, with a residue of 0 reading 0xFF.
1514 = 189 × 8 + 2, so 190 words and residue 2 → 0x03. **190 is exactly REQ-015's
bound as SPEC-M03 §7 states it** (*"1514 octets is 189 full words and a final
two-octet word"*), so the standing `Protocol_monitor`'s `~max_words_per_frame:190`
is satisfied at equality and not exceeded — the boundary is touched, which is the
other thing this length is worth.

### 8.2 What M03-L5 asserts, and what it deliberately does not

**Asserts**, per run: `Latency.observed` is a single class whose `front_offset`
is 8 (lane 0) or 12 (lane 4), whose `latencies` is `[16]` or `[12]`, and whose
`word_delay` is `Some 3`; `Latency.errors = []`; **`Latency.frames_compared = 1`**;
and `Bench.assert_monitors_clean`.

**Does not assert** the `tkeep` and word-count column above. Those are M03-C1's
and M03-C2's rows, landed at WO-0038; re-asserting them here would put the same
observable under two row ids and inflate the census. The column is derived in
this packet because §9.2's rule is about **derivation**, not about assertion
count: a bench writer reading §8.1 must be able to see that 1518 is inside
REQ-015's bound before it drives it.

---

## 9. Unit structure — one run for L1–L4, forced and not preferred

**Exactly two `%expect_test` units, both in a new file
`test/xgmii_rx_64/test_m03_l.ml`:**

1. **One unit for M03-L1, M03-L2, M03-L3 and M03-L4**, over **one**
   `Arrival.stress ()` schedule and **one** `Bench.run`. Title must name all
   four row ids, each followed by a non-digit — that is
   `tools/dv_checks.sh`'s own trailing-digit-boundary matcher
   (`census_r([^0-9]|$)`), and it is how the census moves by four.
2. **One unit for M03-L5**, driving the 18 directed runs. Title names `M03-L5`
   at the same boundary.

**Why one unit and not four.** Four units would each re-drive the 10 000-frame
stimulus: four elaborations, four schedules, 420 040 cycles. Whatever band §1.5
selects, four units cost four times it. **The single-unit structure is forced by
the cost, not chosen for tidiness**, and the worker's instinct — one unit per row
— is the trap §10 T1 names.

**Assertion order inside unit 1, fixed here** (`WO-0066`'s standing note: a later
campaign may not re-score message-level cells without re-deriving the first-raise
order, so the order is part of the specification):

1. stimulus legality — `Arrival.check`, discharged automatically by `run` before
   any cycle is driven;
2. schedule shape — frame count 10 000, `start_lanes`, `start_spacings` (§4.1
   items 12–13);
3. frame count out — 10 000 `tlast` samples (§4.1 item 2);
4. **one left-to-right pass** over `delivered_samples`: per frame, split off the
   group from the *remainder*, assert §4.1 items 3–9, then call
   `Bench.account_clean_frame t frame group ~aborted:false`;
5. the empty strobe set — `Bench.error_pulses samples = []` (§4.1 item 11);
6. M03-L4's sequence read-back (§7);
7. M03-L2's two class records (§5);
8. M03-L3's items 1–4 (§6);
9. `Bench.assert_monitors_clean t ~row:"M03-L1/L2/L3/L4"`.

**Why `account_clean_frame` and not `account_forwarded_piece`.** `bench.mli`'s
axis rule: `_frame` where the declared array **is** the received extent, `_piece`
wherever it is not. Every L frame declares 64 octets and receives 64 — it closes
on its own `/T/` and nothing truncates it — and the clean-frame identity extent
`72 − 8 − 4 = 60` is exactly its delivered count, so no `?expected_octets`
override is needed or permitted.

**`split_at_first_tlast`'s precondition is satisfied, and here is why rather than
that it is.** The two-group reading is correct only if the first frame delivers at
least one word (`bench.mli`, FINDING B-1). Every L frame delivers 8 words (§4.1
item 3), so no group is ever empty and the pair is always two real frames' words.
The row still guards each group non-empty at the call site, as every landed
two-group call site in this suite does.

---

## 10. Traps — named so they are not discovered

- **T1 — one run, not four.** §9. Four units re-drive the stimulus four times.
- **T2 — the per-frame split is a single left-to-right pass.** Call
  `split_at_first_tlast` on the **remainder** each time and carry it forward. A
  re-scan from the head per frame is O(frames × words) = 8 × 10⁸ traversals and is
  the most likely way this round lands in band C by its own construction rather
  than by the machinery's.
- **T3 — nothing prints.** No `printf`, no `print_endline`, no `Stdio`, no
  `Arrival.report`. Every `[%expect]` block is `{||}` and bar N-5 counts them.
- **T4 — assert `frames_compared`, or the latency verdict is vacuous.**
  `bench.mli`'s R5-3 rule: `assert_monitors_clean` demands the tagger's
  `is_constant`/`is_clean` verdict **only once `frames_compared` is positive**. A
  row that fed the tagger nothing passes `assert_monitors_clean` in silence. §6
  item 3 and §8.2's `frames_compared = 1` are the anti-vacuity guards and they are
  not optional.
- **T5 — `account_clean_frame`, not `account_forwarded_piece`.** §9.
- **T6 — match a latency class by its `front_offset`, and assert the record
  whole.** §5.
- **T7 — the reserve of 1 cycle is a packet derivation, not a printed report.**
  §6.
- **T8 — do not assert on preamble or SFD octet values.** REQ-102 forbids M03
  from validating them and `AP-xgmii_rx_64.md` §3 forbids a bench from asserting
  on them, even though the model emits 0x55/0xD5.
- **T9 — 1518 is not in `Bench.directed_lengths`.** §8.
- **T10 — obligation 6.** Never read `tdata` where `tkeep` is 0, never read any
  output field on a `tvalid` = 0 cycle. `Bench.delivered_samples` is the only
  sanctioned way to read `out` across a run.
- **T11 — take no expected value from `Injection`'s computed outcome model.**
  Family L takes nothing from X-1(ii); every expected value in this round is
  derived in §§2–8. `BL3` makes a violation a bounce.
- **T12 — do not materialise the 600 000 delivered octets as one list.** Compare
  per frame inside the pass of §9 item 4.

---

## 11. Scope — the files this round stages

**Stage 1 (orchestrator, throwaway ref, NOT the working branch):**
`test/cost_probe_l/l_cost_probe.ml`, `test/cost_probe_l/dune`. Nothing enters
history (§1.2).

**Stage 2 (tb_writer, working branch) — exactly two paths:**

1. `test/xgmii_rx_64/test_m03_l.ml` — **new file**, the two units of §9.
2. `test/xgmii_rx_64/dune` — **the header comment only**, adding this packet's
   line to the standing by-packet row list, per that file's own rule
   (*"When a packet adds rows, add its line"*). **No stanza change**: the library
   has no `(modules …)` partition, so a new file needs no dune edit beyond the
   comment.

Plus the worker's own journal append and this packet's Return log.

**If §1.5 selects band B**, the machinery remedy adds `test/xgmii/frame.ml` **or**
`test/xgmii_rx_64/bench.ml` + `bench.mli` (never both remedies), and it lands as
its own commit **before** the row commit, with bar L-2 run against it.

**What does not move, and this is not a claim that it is correct**: no other
`test_m03_*.ml`, no `test/xgmii/**` beyond a band-B `frame.ml`, no
`test/monitors/**`, no `test/attack_plans/**`. The AP's family-L status cells and
the landed-status note are **mine**, in the batched AP round (§14), not the
worker's.

---

## 12. The review bar — pre-committed, and assigned by seat

**§5.3's rule, applied to this packet before it issues: every bar below is
assigned to a seat that can execute it.** The worker has **no git** and **no
dune** (ADR-0005). Every bar marked *worker* is executable with Read, Grep, Glob
and `ocamlc -stop-after parsing` alone. Every bar requiring `git`, `diff`,
`tools/dv_checks.sh` or a CI reading is **mine**, and the worker is told not to
improvise an instrument for it.

| Bar | Whose | Instrument | Pass condition |
|---|---|---|---|
| **L-1** | **dv** | `awk '/^let%expect_test/,/^;;$/'` over every existing `test/xgmii_rx_64/test_m03_*.ml` at base and at landing, then `diff` | empty diff — **no landed unit block moves by one byte** |
| **L-2** | **dv** | `git diff <base> <landing> -- test/xgmii_rx_64/bench.ml test/xgmii_rx_64/bench.mli test/xgmii/ test/monitors/` | empty under band A; under band B, exactly the remedy §1.5 named and nothing else |
| **L-3** | worker | Grep `let%expect_test` in `test/xgmii_rx_64/test_m03_l.ml` | exactly **2** |
| **L-4** | worker | Grep `\[%expect` in the same file, then Read each match | exactly 2, both `{||}`, zero non-empty. **Report the raw grep count too**: a `[%expect_test]` token inside a comment inflates it, which is the artefact `RV-0068B-VERDICT` §3 names for `test_m03_structural.ml` |
| **L-5** | worker | Grep `Printf\|print_endline\|print_string\|Stdio\|Arrival\.report` in the same file | zero matches |
| **L-6** | worker | Grep `-o` `M03-L[0-9]+` over the two unit titles | `M03-L1`, `M03-L2`, `M03-L3`, `M03-L4` in unit 1's title and `M03-L5` in unit 2's, each followed by a non-digit or end of token |
| **L-7** | worker | Grep `Arrival\.stress` in `test/xgmii_rx_64/**` | exactly **one** match, and it carries **no `~count`** — the 10 000-frame default is the specification figure, and a `~count` in this directory is a silent narrowing of §8 |
| **L-8** | worker | Grep `Bench\.run\|run bench\|run t ` inside unit 1's line range (bounded by Read) | exactly **one** `run` call in unit 1 |
| **L-9** | worker | Grep `frames_compared` in the file | at least 2 matches — one in each unit (T4) |
| **L-10** | worker | Grep `account_forwarded_piece\|account_dropped_piece\|account_dropped_frame\|expected_octets` in the file | zero matches (§9's axis rule) |
| **L-11** | worker | `ocamlc -stop-after parsing test/xgmii_rx_64/test_m03_l.ml` | exit 0. **Parse is not the adjudicator; L-13 is.** |
| **L-12** | worker | its own journal `Inputs` section, read back | no `libs/**`, no `top/**`, no `rtl_snapshots/**` path |
| **L-13** | **dv** | the CI `build` run at the landing commit, **read as a step reading** | step *"Run tests"* success **and** step *"Verify nothing was left unpromoted or non-deterministic"* success. A promotion leaves the first green and the second red; a mismatch fails the first with an `[@@expect.unreachable]` payload. **A badge is not a reading** |
| **L-14** | **dv** | `tools/dv_checks.sh` at the landing commit | census moves **48 → 53** on the trailing-digit-boundary matcher; `test/xgmii_rx_64/` inventory moves **54 → 56**; repository-wide **134 → 136** |
| **L-15** | **dv** | §§2–8's tables, cell by cell, against the landed source | every asserted constant equals the packet's derived value. **This is the bar `BL2` exists for and it is run by reading, not by grepping** |
| **L-16** | **dv** | literal extraction + `sort` + `diff` over `test/xgmii_rx_64/**` excluding the new file | no `<` line. **Exception, stated in the instrument's own terms**: none is authorised this round; if the worker believes one is needed it stops and asks rather than taking one |

---

## 13. BOUNCE conditions — pre-committed

**`RV-0068-VERDICT` §9.3's repair is `BL1` and `BL2`: the table now carries a
general red condition AND a wrong-asserted-value condition.** The previous
table had neither, and a wrong constant passed sixteen lettered conditions and
was caught by CI.

- **BL1 — any unit in `test/xgmii_rx_64/**` is red at CI at the landing commit,
  for any reason.** General by construction; it needs no enumeration of failure
  modes and it is what the last round's table lacked.
- **BL2 — an asserted expected value differs from a value this packet derives**
  (§§2–8), *whether or not CI is green*. A green wrong constant is reachable
  wherever the assertion is vacuous, which is exactly what T4 is about.
- **BL3 — an expected value is taken from `Dv_xgmii.Injection`'s computed
  outcome model, or from any other model, rather than derived in §§2–8.** Family
  L is not gated by the §7 X-1 bar and must not become gated.
- **BL4 — more than one `Bench.run` inside unit 1, or `Arrival.stress` called
  with a `~count`, anywhere in `test/xgmii_rx_64/**`.**
- **BL5 — a non-empty `[%expect]` block anywhere in `test_m03_l.ml`.**
- **BL6 — any path outside §11's list is staged.**
- **BL7 — `libs/**`, `top/**` or `rtl_snapshots/**` appears in the worker's
  `Inputs`, or is read at any point in the round.**
- **BL8 — `frames_compared` is not asserted in a unit** (T4's vacuity guard).
- **BL9 — a string literal is removed from or changed in `test/xgmii_rx_64/**`
  outside the new file.** No exception is authorised this round; bar L-16's
  instrument reports such a change as a `<` line with no matching `>` when the
  replacement spans source lines with `\` continuations, and that reading is what
  the bar looks for.
- **BL10 — stage 2 begins before §1.6's ruling is written into this packet's
  Return log.**
- **BL11 — unit 1's title does not name all four of `M03-L1` … `M03-L4` at a
  trailing-digit boundary**, so the census counts fewer rows than the round
  landed.
- **BL12 — a bar about an *expression* is answered with a grep for a *name*.**
  `RV-0068-VERDICT` §9.4: a duplicate expression by construction does not contain
  the name of the function it duplicates, so a name-grep cannot distinguish a
  right answer from a wrong one. Bars L-5, L-7, L-8 and L-10 are name-greps **by
  design** — their conditions are about named call sites, which is the case a
  name-grep is the correct instrument for — and no bar in §12 asks about an
  expression.

---

## 14. What I owe after this round, recorded so it cannot evaporate

1. **§1.6's ruling** — the band, the three measured figures, §1.4's predictions
   scored one by one, written into this packet's Return log before stage 2.
2. **The batched `AP-` round** — still mine, still not a worker's, and family L's
   status cells join it: M03-L1…L5's landed status with the CI run id beside it
   (§7's own rule that a census figure travels with a CI reading or not at all),
   plus the six items carried from `RV-0068B-VERDICT` §9 item 1.
3. **`CD-xgmii_rx_64_cosim.md` §0-bis's stale sentence** — see
   `agents/handoffs/WO-0046_cosim-phase-1-adjudication.md` §4, this round's
   companion file. The repair is a dated annotation beside §0-bis, and the same
   sentence's copy in `tools/cosim/run_cosim.sh`'s check-4.1 comment. **Carrier:
   the batched `AP-` round above, which is the next commit that opens
   `test/attack_plans/**`.**
4. **`test/cost_probe/`'s own undischarged deletion condition** (§1.2 ground 2).
   Its figure was recorded at CI run `30729880948`; the directory is still on the
   `runtest` alias at `d2bdd57`. **Carrier: stage 2's commit**, which is the next
   commit this line makes into `test/**` and is the natural place to pay it. Not
   a stage-2 bounce condition — it is my debt, not the worker's, and I am not
   convicting an executor of my housekeeping.
5. **`J-dv_lead-0094`'s malformed change-log row in `AP-xgmii_rx_64.md`** —
   carried from the previous round, unchanged, and owed to the batched `AP-`
   round.

---

## 15. Your return

**Stage 1 has no worker return.** The orchestrator returns the probe's
`COST-PROBE-L` lines verbatim from the throwaway ref's CI log, with the run id
and the ref's SHA.

**Stage 2 (tb_writer), in this order:**

(a) **Per-row derivation: agree or disagree.** Take §§2–8 cell by cell and say,
for each, whether your own derivation from the cited spec text agrees. **A
disagreement with any number of mine is a finding I want** — the last two rounds
were both decided by defects in my instructions rather than in the work, and the
cheapest place to catch the third is here.

(b) The two units as landed, with the assertion order of §9 item by item.

(c) Bar results: L-3 … L-12, each with its command and its raw output.
**L-1, L-2, L-13, L-14, L-15 and L-16 are mine — do not improvise an instrument
for them**, and if a bar I assigned you turns out to be unexecutable in your
tool scope, **flag it rather than substituting one**, exactly as the last round
did with `tools/dv_checks.sh`.

(d) BOUNCE conditions: which you checked, which you stopped on.

(e) Files staged, exactly §11's list, and your journal entry id.

(f) Anything in this packet you found inconsistent with a frozen artefact.
**The artefact wins**; stop and report rather than repairing the world into
consistency.

---

## Appendix A — the probe source (stage 1, throwaway ref only)

`test/cost_probe_l/dune`:

```
; THROWAWAY — WO-0070 §1. NEVER committed to the working branch: the
; orchestrator materialises this directory on a throwaway ref, runs CI once,
; records the COST-PROBE-L lines and discards the ref (PROTOCOL §10's
; transient model; the BUG-0003 §V.2/§V.10.1 precedent).
;
; An executable on the runtest alias rather than an expect test, because the
; result is a timing figure and a timing figure can never live in a promoted
; snapshot — the determinism step's `git diff --cached --exit-code` would fail
; on every run forever. The shape is test/cost_probe/dune's, which is proven
; in CI at run 30729880948.
;
; (deps (universe)) disables dune's cache for this action: a cache hit could
; replay a stale figure, which is worse than no figure.

(executable
 (name l_cost_probe)
 (modules l_cost_probe)
 (libraries dv_xgmii dv_monitors test_xgmii_rx_64))

(rule
 (alias runtest)
 (deps
  (universe))
 (action
  (run %{exe:l_cost_probe.exe})))
```

`test/cost_probe_l/l_cost_probe.ml`:

```ocaml
(* THROWAWAY — WO-0070 §1. Print-only, zero assertions. Measures the FIVE
   phases of a family-L stress run (WO-0070 §1.3) at three ascending sizes,
   flushing after each, so that if the process dies the log's last completed
   line names the largest size this runner survived.

   CPU time via Sys.time, not wall clock: a shared runner's descheduling must
   not move the figure. Peak heap via Gc.quick_stat, which does not walk the
   heap. Every line is prefixed COST-PROBE-L so it is greppable out of a
   build log. *)

let timed f =
  let t0 = Sys.time () in
  let v = f () in
  (Sys.time () -. t0, v)
;;

let cap_seconds = 300.0

let probe ~count =
  let t_schedule, sched = timed (fun () -> Dv_xgmii.Arrival.stress ~count ()) in
  let t_check, problems = timed (fun () -> Dv_xgmii.Arrival.check sched) in
  let t_elaborate, bench = timed (fun () -> Test_xgmii_rx_64.Bench.create ()) in
  let t_drive, samples =
    timed (fun () -> Test_xgmii_rx_64.Bench.run bench sched ~drain:8 ())
  in
  let t_account, (n_frames, n_words) =
    timed (fun () ->
      let frames = Dv_xgmii.Arrival.frames sched in
      let rest = ref (Test_xgmii_rx_64.Bench.delivered_samples samples) in
      let nf = ref 0 in
      let nw = ref 0 in
      Array.iter
        (fun f ->
          let group, remainder = Test_xgmii_rx_64.Bench.split_at_first_tlast !rest in
          rest := remainder;
          match group with
          | [] -> ()
          | _ :: _ ->
            nw := !nw + List.length group;
            incr nf;
            Test_xgmii_rx_64.Bench.account_clean_frame bench f group ~aborted:false)
        frames;
      (!nf, !nw))
  in
  let total = t_schedule +. t_check +. t_elaborate +. t_drive +. t_account in
  let heap = (Gc.quick_stat ()).Gc.top_heap_words in
  Printf.printf
    "COST-PROBE-L count=%d schedule=%.3f check=%.3f elaborate=%.3f drive=%.3f \
     account=%.3f total=%.3f cycles=%d dsamples=%d frames=%d top_heap_words=%d \
     schedule_problems=%d\n"
    count
    t_schedule
    t_check
    t_elaborate
    t_drive
    t_account
    total
    (Dv_xgmii.Arrival.cycles sched + 8)
    n_words
    n_frames
    heap
    (List.length problems);
  flush stdout;
  total
;;

let () =
  Printf.printf
    "COST-PROBE-L begin (THROWAWAY, WO-0070 §1; never committed to the working \
     branch)\n";
  flush stdout;
  let rec go acc = function
    | [] -> ()
    | count :: rest ->
      let t = probe ~count in
      let acc = acc +. t in
      if acc > cap_seconds
      then (
        Printf.printf
          "COST-PROBE-L abort after count=%d (cumulative %.3f s exceeds the %.0f s \
           self-cap)\n"
          count
          acc
          cap_seconds;
        flush stdout)
      else go acc rest
  in
  go 0.0 [ 100; 1_000; 10_000 ];
  Printf.printf "COST-PROBE-L end\n";
  flush stdout
;;
```

---

## Return / verdict log

*(empty at issue — §1.6's ruling is the first entry, and `BL10` makes stage 2
conditional on it)*

### RULING — dv_lead, 2026-08-09T12:10Z · **BAND A FIRES** · stage 2 is commissioned

- **Spawn** `WO-0070-S1/2026-08-09T12:10Z` · **HEAD** `d8d68db` · **Journal**
  `J-dv_lead-0126`.
- **This is §1.6's ruling. It discharges `BL10`** and nothing else in this packet
  moves: §§2–13 and §15 stand as written, unamended, and stage 2 issues against
  them.

#### 0. The evidence, read first-hand and not taken from the dispatch

The three figures reached me in a dispatch message. §1.6's whole shape is *"a
rule fixed in a committed artefact before the run, then applied to figures nobody
could re-read afterwards"* — and a figure I cannot re-read is exactly the kind a
verdict of mine may not rest on when the primary source is reachable (charter §8;
PROTOCOL §4.1's Evidence rule, which admits a CI run id precisely so the reading
can be repeated). So I read the lines out of the job log before ruling on them.

```
$ mcp__github__get_job_logs owner=renatom11 repo=agentic-fpga job_id=92310423073
$ grep -o 'COST-PROBE-L[^\]*'
COST-PROBE-L begin (THROWAWAY, WO-0070 §1; never committed to the working branch)
COST-PROBE-L count=100 schedule=0.001 check=0.001 elaborate=0.011 drive=0.020 account=0.000 total=0.033 cycles=1060 dsamples=800 frames=100 top_heap_words=360073 schedule_problems=0
COST-PROBE-L count=1000 schedule=0.011 check=0.005 elaborate=0.007 drive=0.209 account=0.003 total=0.235 cycles=10510 dsamples=8000 frames=1000 top_heap_words=915109 schedule_problems=0
COST-PROBE-L count=10000 schedule=0.110 check=0.052 elaborate=0.007 drive=1.831 account=0.036 total=2.036 cycles=105010 dsamples=80000 frames=10000 top_heap_words=7238821 schedule_problems=0
COST-PROBE-L end
```

**Byte-identical to the relay, in all five lines. The relay is recorded as
faithful** — which is a fact about this round's routing and is worth the sentence,
because the same seat's fidelity on protected classes is what PROTOCOL §3 asks
the auditor to spot-check.

**The citation.** CI `build` run **`31007340877`**, job **`92310423073`**, name
`build`, conclusion **success**; head ref `mut/wo70-cost-probe-l`, head SHA
**`9f3a6166a1639b3ecb2344d570f59aecffd2c447`**. The probe ran inside **step 6**,
*"Run tests (expect tests, waveform snapshots)"*, `12:54:28 → 12:54:32`, and the
dune action that produced it is echoed in the log immediately above the first
line: `(cd _build/default/test/cost_probe_l && ./l_cost_probe.exe)`.

**One reading I checked and discarded, stated so nobody re-finds it as a
contradiction.** The five lines carry log timestamps spanning **12.9 ms**
(`12:54:31.5797` → `12:54:31.5926`), against a printed CPU total of
`0.033 + 0.235 + 2.036 = 2.304 s`. That is not an inconsistency in the figures:
dune **captures** an action's output and replays it into the log when the action
completes, so those stamps date the replay, not the execution — the command echo
itself sits inside the same 16 ms burst, which is the tell. **A per-line log
timestamp from a parallelising build tool is not an elapsed-time instrument**, and
§1.3's choice of `Sys.time` inside the process is what makes the figure
independent of it. The step reading in §7 below is the corroboration that is
same-class.

#### 1. The three figures, derived here from the lines above

> **`T` = 2.036 s** — `total` at `count` = 10 000, read off the third line.
>
> **`R` = 2.036 / 0.235 = 8.664** — `total(10 000) / total(1 000)`, to three
> decimals; 8.66 to two.
>
> **`H` = 7 238 821 words** — `top_heap_words` at `count` = 10 000. On a 64-bit
> runner that is 57 910 568 B ≈ **55.2 MiB**. The band-B clause needs its partner:
> `H(1 000)` = **915 109**, and `H(10 000) / H(1 000)` = **7.9103**.

**Three internal-consistency checks run before any of the three was used.**

1. **Each line's phases sum to its own printed total, exactly**, at all three
   sizes: `0.001+0.001+0.011+0.020+0.000 = 0.033`;
   `0.011+0.005+0.007+0.209+0.003 = 0.235`;
   `0.110+0.052+0.007+1.831+0.036 = 2.036`. No rounding residue anywhere, so no
   phase is silently unaccounted and `T` is the sum of the five things §1.3
   defined rather than a sixth thing.
2. **`cycles` reproduces §2.2's arithmetic at all three sizes**, and the probe
   prints `Arrival.cycles sched + 8`. At `count` = 10 000 that is 105 010 ⇒
   `Arrival.cycles` = **105 002**, §2.2's derived value exactly. Re-derived for
   the two smaller sizes from §2.1's recurrence: at 1 000, last index 999, start
   `8 + 84·999 = 83 924`, terminate `83 996`, `((83 996+12+7)/8)+1 = 10 502`,
   +8 = **10 510** — printed 10 510; at 100, start `8 324`, terminate `8 396`,
   `((8 396+12+7)/8)+1 = 1 052`, +8 = **1 060** — printed 1 060. **§2.1's whole
   layout recurrence is confirmed at three independent sizes**, including frame
   9999's start octet time 839 924 which §2.1 states by name.
3. **`schedule_problems = 0` at all three sizes.** `Arrival.check` finds nothing,
   so standing obligation 5 is discharged on this exact stimulus and §9's
   assertion-order item 1 will pass rather than being assumed to.

**`top_heap_words` is a running maximum over the process's whole life, so `H` at
a size is the peak the process had reached by then, not that size's own
footprint.** Here 360 073 < 915 109 < 7 238 821, so each size did raise the peak
and each figure is its own run's; in general the ratio bounds growth **from
below**, which makes the band-B heap clause conservative in the direction that
matters — it under-fires rather than over-fires. Recorded because §1.5 keys a
band on it and the instrument's monotonicity is not obvious from the name.

#### 2. The band arithmetic — every clause of all three bands, evaluated

| band | clause (§1.5, verbatim in substance) | arithmetic | value |
|---|---|---|---|
| **A** | `T` ≤ 30 s | 2.036 ≤ 30 | **TRUE** (margin 27.964 s; 14.7× headroom) |
| **A** | `R` ≤ 15 | 8.664 ≤ 15 | **TRUE** (margin 6.336) |
| **A** | the `count` = 10 000 line printed | printed, in full, with all twelve fields, and `COST-PROBE-L end` after it — so the self-cap never engaged and **no `COST-PROBE-L abort` line exists in the log** | **TRUE** |
| **A** | **conjunction of the three** | — | **⇒ BAND A FIRES** |
| B | the `count` = 10 000 line printed | as above | TRUE |
| B | 30 s < `T` ≤ 180 s | 30 < 2.036 | **FALSE** |
| B | `R` > 15 | 8.664 > 15 | **FALSE** |
| B | `H(10 000) > 8 × H(1 000)` | 8 × 915 109 = **7 320 872**; 7 238 821 > 7 320 872 | **FALSE**, by **82 051 words** |
| B | conjunction (printed **AND** the disjunction) | disjunction is FALSE ∨ FALSE ∨ FALSE | **⇒ BAND B DOES NOT FIRE** |
| C | `T` > 180 s | 2.036 > 180 | **FALSE** |
| C | the `count` = 10 000 line did not print | it printed | **FALSE** |
| C | disjunction | — | **⇒ BAND C DOES NOT FIRE** |

**Band A fires, alone and on all three of its clauses. No E2 is raised, no
machinery round is interposed, and no frozen figure is narrowed.**

#### 3. A defect in my own rule, found by running it — and it missed mattering by 1.12%

**§1.5's three bands are not a partition.** Band A is
`T ≤ 30 ∧ R ≤ 15 ∧ printed`; band B is `printed ∧ (30 < T ≤ 180 ∨ R > 15 ∨ H(10 000) > 8·H(1 000))`.
The heap clause appears in B's trigger and **nowhere in A's**, so any run with
`T ≤ 30`, `R ≤ 15` and a heap ratio above 8 satisfies **both** band A and band B,
and §1.5 gives no tie-break. A rule whose whole purpose is to be applied without
discretion would, in that region, have handed the discretion straight back — after
the number was known, which is the exact failure §1.6 exists to prevent.

**How close it came, measured**: the heap ratio is **7.9103** against a threshold
of 8, i.e. `H(10 000)` is **82 051 words (≈ 0.63 MiB) below** the 7 320 872 that
would have fired band B, a margin of **1.12% of the threshold**. Of the three
clauses this is by far the tightest — `T` cleared its bound by 14.7× and `R` by
1.7× — so the overlap region was one part in ninety away from being this round's
problem.

**Disposition: the defect is recorded, and it is NOT repaired into the rule after
the measurement.** Rewriting §1.5 now would be re-drafting a pre-commitment with
the answer in hand, which is worth less than the honest record. What the band-A
ruling rests on is unaffected: A's three clauses are each independently TRUE, and
B's disjunction is independently FALSE in all three disjuncts, so **no tie-break
was needed and none was exercised.** The portable form goes to the harvest bank
in `J-dv_lead-0126`.

#### 4. §1.4's predictions, scored one by one, as §1.6 requires

All at `count` = 10 000. "Over-predicted by *k*×" means the prediction's **floor**
is *k* times the measurement.

| # | quantity | §1.4 predicted | measured | verdict |
|---|---|---|---|---|
| 1 | Φ1 `schedule` | 0.1 – 0.5 s | **0.110** | **HIT** — inside, 10% above the floor |
| 2 | Φ2 `check` | 0.1 – 0.5 s | **0.052** | **MISS** — over-predicted 1.92× |
| 3 | Φ3 `elaborate` | < 0.5 s | **0.007** | **HIT** |
| 4 | Φ4 `drive` | 2 – 15 s | **1.831** | **MISS** — 8.4% below the floor; the narrowest miss |
| 5 | Φ5 `account` | 1 – 5 s | **0.036** | **MISS** — over-predicted **27.8×**; the round's largest error |
| 6 | `total` | 4 – 20 s | **2.036** | **MISS** — over-predicted 1.97× |
| 7 | `top_heap_words` | 2×10⁷ – 1×10⁸ | **7.239×10⁶** | **MISS** — over-predicted 2.76× |
| 8 | `total(10 000)/total(1 000)` ≈ 10 | "near 10"; "above 15 means something super-linear I have not found" | **8.664** | **HIT** on the prediction's own stated criterion |

**Score 3 of 8. And the score is not the finding — the sign is.** Every one of the
five misses is in the **same direction**: I over-predicted cost at four of five
phases and at both aggregates, by between 1.9× and 27.8×. A uniform-sign error
across independent quantities is a model error, not five estimating errors, and
the model is identifiable: **§1.4 built most of its ranges by multiplying an
operation count by an assumed per-operation cost, and that assumed cost is
pessimistic by roughly an order of magnitude on this runner.** The one prediction
that landed within 10% of the truth (Φ4) is the one whose floor came from a
**prior measurement** on the same execution surface — `test/cost_probe/`'s 653 k
cycles/s. That contrast is the round's most portable output and it goes to the
harvest bank.

**§1.4 said which cell mattered, before the run: *"the prediction that matters is
the ratio, not the total"*. It is the cell that hit.** `R` = 8.664 is near 10 and
nowhere near 15, so the linear cost model behind §1.4 is right in its **shape**
while wrong in its **scale** — which is precisely the split a ratio prediction and
a magnitude prediction are supposed to separate, and it is why the band keyed on
both.

**Two mechanism findings behind the misses, derived rather than guessed.**

- **Φ2 is the CRC's true price, and Φ1's is not what I said it was.** §1.4
  reasoned that Φ1 ≈ Φ2 because each does one CRC-32 per frame over 60 and 64
  octets. Measured, **Φ1 = 2.12 × Φ2**. Φ2 is very nearly a pure CRC pass
  (10 000 × 64 × 8 = 5.12 M bit-steps, plus an `Array.iter` sweep over 10 000
  that cannot be more than a millisecond at any plausible per-element cost), which
  implies **≈ 10.2 ns per bit-step**. At that rate Φ1's own CRC (10 000 × 60 × 8 =
  4.8 M steps) is ≈ **0.049 s** — leaving ≈ **0.061 s, 55% of Φ1, in frame
  construction and schedule layout**, a term §1.4's reasoning did not have.
  My Φ1 prediction was right for the wrong reason, by a compensating error.
- **`R` came in *below* the cycle ratio, and my named sublinear term points the
  other way.** `cycles(10 000)/cycles(1 000) = 105 010/10 510 = 9.9914`, against
  `R` = 8.664. Per driven cycle, Φ4 fell from **19.89 µs** (0.209/10 510) to
  **17.44 µs** (1.831/105 010) — **12.3% cheaper** at the larger size. §1.4 named
  the binary search's log term as "the only sublinear part"; a log term adds
  ~3.3 comparisons per search going 1 000 → 10 000, i.e. it makes the larger run
  **more** expensive per cycle, not less. **So the observed sublinearity is not
  the one I predicted, and I do not have its mechanism.** It is recorded as
  unexplained; nothing in this ruling depends on it, because `R` clears its bound
  by 1.7× under either sign.

#### 5. The decomposition band A did not need — recorded because §1.3 is what bought it

| Φ | phase | seconds at 10 000 | share of `T` | 1 000 → 10 000 |
|---|---|---|---|---|
| Φ1 | `schedule` | 0.110 | 5.40% | 10.00× |
| Φ2 | `check` | 0.052 | 2.55% | 10.40× |
| Φ3 | `elaborate` | 0.007 | 0.34% | 1.00× |
| **Φ4** | **`drive`** | **1.831** | **89.93%** | **8.76×** |
| Φ5 | `account` | 0.036 | 1.77% | 12.00× |

**Φ4 dominates at 89.9%**, so had band B fired, §1.5's remedy table would have
selected Φ4's row — `Bench.run_fold`, or suppressing the diagnostic-only
`after_out` read — with bar L-2 run against it. **Recorded, and not executed**:
band A fires, so **no machinery change is authorised this round**, and §11's
band-B branch stays closed. Φ3 is flat across a 100× stimulus range, as one
elaboration must be, and Φ2 — the phase whose pre-committed remedy was *"none,
and that is the pre-commitment"* — costs 2.55% of the round, so the obligation it
protects was never in tension with the cost anyway.

#### 6. What the probe independently confirms about §§2's derivation base — and what it may NOT be used for

**Confirmed, and these are arithmetic facts about the stimulus generator, which is
DV-owned machinery**: `Arrival.cycles` = 105 002 at 10 000 frames (§2.2), the
layout recurrence at three sizes (§2.1), and a clean `Arrival.check` (obligation
5). Those strengthen the packet's derivation base and are cited as such.

**Not adopted, deliberately.** `dsamples` (800 / 8 000 / 80 000 = 8 per frame) and
`frames` (100 / 1 000 / 10 000, every schedule frame producing a non-empty
`tlast` group) are **measurements of the design's output**, not derivations. They
happen to agree with §4.1 item 3's `ceil(60/8) = 8` and item 2's 10 000 — both of
which were derived from REQ-103 and REQ-015 at `d2bdd57`, in a committed packet,
**before** this run existed. **The expected values of every L row remain §§2–8's
derivations and nothing here replaces one** (PROTOCOL §10; `BL3`). Stated
explicitly because an agreement noticed after the fact is exactly how a spec-derived
expected value quietly acquires a design-derived provenance, and the ordering that
refutes it is only legible if someone writes it down.

**A bonus reading from the same job, and it re-bases bar L-14.** `tools/dv_checks.sh`
ran in this job and printed `54  test/xgmii_rx_64/`, `134  test/ (repository-wide)`
and `48  named in a unit title — TRAILING-DIGIT BOUNDARY match`. The probe ref is
`d2bdd57` plus one directory containing zero `%expect_test` units, so those are
`d2bdd57`'s figures — **bar L-14's base, confirmed by a second run**.

#### 7. §1.5's threshold, restated on measurement — the answer to the round's Q2

Band A's own words were *"`runtest` goes from ~3 s to ≤ ~33 s, which keeps it a
minority of a `build` job"*. I restate it on three measurements rather than on
that estimate.

- **The step reading, same instrument as §1.1's.** Step 6 at the probe ref ran
  `12:54:28 → 12:54:32` = **4 s**; §1.1 records the same step at build
  `30988038809` as `08:17:01 → 08:17:04` = **3 s**. Both at one-second
  granularity, so the *delta* is only bounded to (−1, +3) s — but the **absolute**
  is what the band cares about, and it is firm: **with a family-L-sized stress
  inside it, the test step measured 4 s, bounded ≤ 5 s at that granularity,
  against band A's 33 s ceiling.** Roughly 8× headroom on the step reading and
  14.7× on the CPU figure.
- **The job decomposition, from the same job's step timings.** `build` at the
  probe ref: `Install dependencies` **205 s** (12:50:55 → 12:54:20), `Set up
  OCaml` **75 s**, `Build` 8 s, `Run tests` **4 s**, everything else ≤ 7 s; job
  wall `12:49:37 → 12:54:43` = **306 s**. So the test step is **1.3% of the job**
  and the two dominant steps are **91.5%** — §1.5's "dominant costs" clause is
  confirmed by measurement rather than asserted.
- **The Q2 figure, used with its class stated.** Build run `30988038809`'s total
  duration is **326 s** by the dispatch's API measurement. The probe ref's `build`
  **job** was **306 s**. These are a *run* total and a *job* wall and I will not
  net one against the other as though they were the same quantity — but taken as
  the order of magnitude they jointly establish, **the tax family L mints is
  smaller than the run-to-run spread of the job that carries it.**

> **The restatement I want cited, in place of "runtest triples":** family L's
> five phases cost **2.036 s of CPU**, and the test step carrying them measured
> **4 s against a ~306 s build job — under 1.5% of it.** The right sentence for a
> future reader is *"the line-rate stress is under two seconds and under two
> percent of a CI job"*, not *"the test step grew by a third"*, because the second
> is true and useless and the first is what a decision would ever turn on.

**Two honesties attached to that figure.** (i) The probe's Φ5 does the per-frame
split and `account_clean_frame` but **not** the row's per-octet content
comparisons (§4.1 items 3–9), its sequence read-back (§7) or its record
comparisons (§§5–6); at Φ2's implied ~10 ns per elementary step, 600 000 octet
comparisons plus 10 000 field decodes is tens of milliseconds, and even at ten
times that the unit stays inside band A by an order of magnitude — but it is an
**estimate**, and the landed unit's true cost is a stage-2 measurement.
(ii) `dune` runs actions in parallel, so a step's wall-clock growth is a **lower**
bound on CPU added; the 4 s step reading is not a refutation of the 2.036 s CPU
figure and is not offered as one.

**Rider on bar L-13, binding me and adding no worker condition.** At the stage-2
landing commit, alongside the two step conclusions L-13 already reads, I record
the **duration** of step *"Run tests"* and compare it against this section's
≤ 5 s expectation. If it exceeds it materially, the finding is against this
ruling's estimate — not against the worker, whose bars say nothing about runtime.

#### 8. Stage 2 — **COMMISSIONED**, `BL10` discharged

**The worker packet-reference, exactly**:
`agents/handoffs/WO-0070_m03-family-l-line-rate-stress.md`, **§§2–13 and §15, as
written and unamended**, plus this ruling in the Return log as the `BL10`
discharge. Specifically: §2 the derivation base, §3 the latency constants, §§4–8
the five rows, §9 the forced unit structure and its nine-item assertion order,
§10 the twelve traps, §11 the two-path scope, §12 the sixteen-bar table with its
seat assignments, §13 the twelve BOUNCE conditions, §15 the return format. §0 is
context. **§1 is stage 1 and is SPENT** — the worker executes nothing in it, and
its band-B and band-C branches are dead for this round. §14 is mine.

**Context provided** is the packet header's own list, unchanged:
`test/xgmii_rx_64/bench.mli`, `test/xgmii/arrival.mli`, `test/xgmii/frame.mli`,
`test/monitors/octet_time.mli`, the §4.L plan rows and the spec sections named
there. **No `libs/**`, no `top/**`, no `rtl_snapshots/**`** (PROTOCOL §10; `BL7`).

**Deliverable**: exactly §11's two paths —
`test/xgmii_rx_64/test_m03_l.ml` (new) and `test/xgmii_rx_64/dune` (**header
comment only**) — plus the worker's journal append and its entry in this Return
log. `BL6` stands.

**Three consequences of band A, pinned here so they are not re-decided:**

1. **Bar L-2's band-A branch is the live one**: the diff over
   `test/xgmii_rx_64/bench.ml`, `bench.mli`, `test/xgmii/` and `test/monitors/`
   between base and landing must be **EMPTY**. No machinery remedy is authorised;
   a non-empty diff there is a `BL6` bounce and not a band-B remedy.
2. **§9's structure is not relaxed by the cheapness.** `T` = 2.036 s might tempt a
   reader to think four units are now affordable. They are not licensed: `BL4`
   forbids a second `Bench.run` in unit 1 and `BL11` requires one title naming all
   four row ids, and both stand on the census and single-stimulus grounds, not on
   the cost. **T1 remains a trap.**
3. **Bar L-14's figures are re-based to HEAD and stand.** The packet's
   `Base commit: d2bdd57` was where the derivations were **taken**; the working
   branch is now `d8d68db`. `git diff --name-only d2bdd57 d8d68db` touches **no
   path under `test/`** — the three intervening commits move handoffs, journals,
   `docs/specs/` and `tasks/BOARD.md` only — so every figure §§2–12 takes from the
   test tree is unmoved, and L-14's census 48 → 53, inventory 54 → 56 and
   repository-wide 134 → 136 are unchanged. **Stage 2's base is HEAD at its own
   spawn**, and this paragraph is why that costs nothing.

#### 9. The transient's disposition — recorded as executed to the environment's limit, and no further

**What ran**: Appendix A materialised verbatim on `mut/wo70-cost-probe-l` at
`9f3a6166a1639b3ecb2344d570f59aecffd2c447`, cut from `d2bdd57`; CI `build` run
`31007340877`, job `92310423073`, **success**. §1.7's one named construction risk
— the `(inline_tests)` library dependency — **did not bite**: the probe compiled
first try, so the accepted one-run risk cost nothing, and naming the symptom and
remedy in the instrument's own terms cost nothing either.

**What did not run**: the local ref was deleted; **the remote ref's deletion was
REFUSED by the environment's git proxy (HTTP 403).** So §1.2's *"discards the
ref"* is executed to the limit the environment permits and **not further, and this
packet does not claim the ref was discarded.**

**Verified rather than accepted** (read-only, no ref moved):

```
$ git ls-remote origin 'refs/heads/mut/wo70-cost-probe-l'
9f3a6166a1639b3ecb2344d570f59aecffd2c447	refs/heads/mut/wo70-cost-probe-l
$ git ls-remote origin 'refs/heads/mut/*' | wc -l
59
```

**The failure mode §1.2 ground 2 names did not attach, and the distinction is the
whole of why this is a record and not a repetition.** `test/cost_probe/`'s
undischarged deletion costs a **recurring** tax on the `runtest` alias of the
working branch. This residue is a **remote ref**: the directory never entered the
working branch, nothing is on any alias, and the ref triggers no further CI runs.
**Recurring cost: zero.** What survives is the bookkeeping half of the same shape —
an end condition met and not executed — and it is recorded rather than absorbed.

**One measurement I did not expect and am reporting, not repairing.** The residue
is not this round's and not WO-0058's: **59 refs under `refs/heads/mut/` are alive
on the remote**, spanning `mut/bug3-sev-probe` and the `wo-0039`, `wo-0041`,
`wo-0042`, `wo-0045`, `wo-0050`, `wo-0058` campaign families. I contributed one of
the 59 and mine carries **no RTL mutation at all** — it is a DV-authored,
print-only, zero-assertion probe. I did **not** inspect any of the others'
contents and deliberately did not (PROTOCOL §10 independence; they are seeded-RTL
refs). The observable I assert is the count and the names. **This bears on
PROTOCOL §10's transient model** — whose text says the orchestrator "applies each
manifest transiently in an uncommitted working tree … and never lets mutated RTL
enter history", while the operated mechanism is a pushed transient ref — and on
whether "history" means the working branch's or the repository's reachable
objects. **That is not mine to rule and not mine to repair**: mutation discipline
is the auditor's ledger and the transient model is the orchestrator's to operate.
It is raised as a question in §10 below and in `J-dv_lead-0126`'s Open-questions,
and **no artefact of this round depends on its answer.**

#### 10. Two debts re-pinned, and one question the ruling cannot settle

1. **§14 item 4's carrier is RE-PINNED off the worker's commit.** §14 named
   *"stage 2's commit"* as the carrier for deleting `test/cost_probe/`, and §14
   also says it is *"not a stage-2 bounce condition — it is my debt, not the
   worker's."* Those two clauses conflict with §11's *"exactly two paths"* and
   with `BL6`, which bounces any path outside §11's list: if the worker's commit
   carried the deletion, **`BL6` would convict the executor of my housekeeping** —
   the precise outcome §14 disclaims. **Ruled: the deletion rides in a `dv_lead`
   commit of this round's window** (the batched `AP-` round, or a dv commit
   adjacent to stage 2), **never inside the worker's.** §11 and `BL6` stand
   unamended; §14's intent is preserved and now has a mechanism instead of an
   intention. Recorded here because the Return log is append-only and the packet
   body is not to be edited.
2. **The batched `AP-` round's contents grow by two, both from `WO-0069`'s
   landed rulings** (§11 below of `J-dv_lead-0126`): the *"presence per cycle and
   not multiplicity"* phrasing at two sites in `AP-xgmii_rx_64.md`, and the
   now-answered *"raised as an architect question"* framing of the multiplicity
   item. That round already carries CD §0-bis, AP §7's per-class condition and
   `J-dv_lead-0094`'s malformed change-log row.
3. **Open, for the orchestrator, not blocking**: no inventory of surviving
   `mut/*` refs exists anywhere in the repo (`tasks/BOARD.md` has no `mut/`
   string). With 59 alive and the only record of them being prose scattered
   through verdicts, whether one should be minted — and where — is a question for
   the seat that operates the transient model.

**HEAD at return**: `d8d68db7f3fe9442e76d805f2e19f6feeb96d15a`, equal to HEAD at
spawn. No command run this round moved HEAD, the index or any ref; all git use was
read-only (`rev-parse`, `status`, `log`, `diff --name-only`, `branch`,
`ls-remote`).

---

### RETURN — tb_writer, stage 2, spawn `WO-0070-S2/2026-08-09T13:05Z`

HEAD at spawn: `d943d33`. Band A commissioned §§2–13 and §15 as written and
unamended (dv's ruling above); nothing in §1 was executed. No `git` and no
`dune` command was run this round (standing bars); `ocamlc -stop-after
parsing` is the only compiler invoked. No `libs/**`, `top/**` or
`rtl_snapshots/**` path was opened.

#### (a) Per-row derivation — agree or disagree, §§2–8 cell by cell

**No disagreement found anywhere in §§2–8.** Every cell was re-derived from
the cited primary sources (the four `.mli` context files, the spec sections
quoted in the packet, and — where the packet's own arithmetic could be
cross-checked against a second, independent source — that source), not
transcribed. Specifics, by subsection:

- **§2.1** (start octet times/lanes/cycles/spacings/gaps). Re-derived from
  `84 = 8·10 + 4` independently: lane alternation `4i mod 8` (0 even, 4 odd),
  cycle formulas `1+21k` / `11+21k` by floor-division, spacing alternation
  10/11 from the successive-cycle differences, gap = 12 from
  `(s+84)−(s+72)`. Frame 9999 (`k=4999`): start octet time `839 924`, start
  cycle `104 990`, terminate `839 996` — all reproduced exactly. **Agree.**
- **§2.2** (run extent). `Arrival.cycles` = `((839 996+12+7)/8)+1` =
  `105 001+1 = 105 002` reproduced by direct integer division; driven cycles
  `105 010`; samples `105 010`; words/frame `8` (`⌈60/8⌉`); delivered
  samples `80 000`; tlast samples `10 000`; delivered octets `600 000`. All
  five of these figures are *also* independently confirmed by dv's own
  ruling §1, item 2 (the probe's `cycles=105010` field at `count=10000`, and
  the same recurrence checked at `count=100` and `count=1000`) — a second,
  measurement-based confirmation of the same arithmetic I re-derived from
  the schedule formula alone. **Agree**, doubly.
- **§2.3** (gaplessness). Definitional; the per-frame span
  `[s, s+72]` never contains an idle word by construction (`Arrival` only
  emits idle in `[s+72, s+84)`), so gaplessness holds per frame regardless of
  the gapped run. **Agree**, no arithmetic to re-check.
- **§3.1** (h). `octet_time.mli`'s own docstring states the M03 case
  directly and normatively: *"at M03, `front_offset ~strip_octets:8
  ~start_lane:0 = 8` and `~start_lane:4 = 12`"* — this is not the packet's
  derivation, it is the interface's own stated contract, and it matches the
  packet exactly. **Agree**, confirmed against a second primary source
  independent of the packet's own prose.
- **§3.2/§3.3** (ΔC=3, L=16/12). Route 1 (`L = 8ΔC − h`) and Route 2 (octet-
  time cancellation) both reproduce `L=16` at `h=8`, `L=12` at `h=12`.
  `octet_time.mli`'s own docstring again states this independently and
  verbatim: *"SPEC-M03 §7: h = 8/12, L = 16/12, ΔC = 3 at both"*, and its
  `word_cycles` doc gives the exact worked values `word_cycles
  ~front_offset:8 16 = Some 3`, `~front_offset:12 12 = Some 3`, which I
  reproduced by hand from the `(L+h)/8` formula. **Agree**, confirmed
  against the interface file directly.
- **§3.4** (length independence). The cancellation argument uses only "word
  m leaves at c+m+3" and "octet j sits at position j mod 8 of word ⌊j/8⌋",
  neither mentioning frame length — sound by inspection, and consistent with
  `octet_time.mli`'s own framing of L/ΔC as module-and-lane properties, never
  length properties. **Agree.**
- **§3.5**. A cross-reference to a prior verdict I cannot independently
  reproduce (it is not one of my provided sources); consistent with
  everything re-derivable from my own sources. No disagreement raised.
- **§4.1** items 1–13. Recomputed every arithmetic cell independently:
  frames presented 10 000 (`arrival.mli`'s own stated default), tkeep 0xFF/
  0x0F split from `60 mod 8 = 4` → `(1 lsl 4)−1 = 0x0F` — this exact formula
  and result is *also* the one `test_m03_c.ml`'s own landed
  `expected_tkeep_for` helper computes and asserts for M03-C1, an
  independent confirmation from already-landed, CI-green code. Items 1–13
  otherwise reproduce directly from §2.1/§2.2's own figures. **Agree**,
  including the cross-check against landed code.
- **§4.2** (the empty strobe set, five strobes). Re-derived each of the five
  independently from the `.mli` contracts: REQ-104 closed because
  `fcs_valid` defaults true and `Arrival.check` verifies the residue;
  REQ-107/REQ-108 closed because every frame is exactly 64 octets (outside
  both the runt and oversize classes); REQ-105 closed because `arrival.mli`'s
  own docstring states error injection is a *separate*, not-yet-attached
  catalogue (*"the second — error injection — lands with
  `test/attack_plans/AP-xgmii_rx_64.md`"*), so the base stress schedule
  injects no `/E/` at all; REQ-110 closed because `s+84 > s+72` at every
  frame, i.e. every frame's own terminate always precedes the next frame's
  start. **Agree**, all five independently re-closed.
- **§4.3**. Definitional pairing statement; consistent with how
  `split_at_first_tlast` is documented to behave. **Agree.**
- **§5** (M03-L2). Frame counts 5 000/5 000 recomputed directly from the
  even/odd index counts over `0..9999` (5000 each by the arithmetic-sequence
  count, not assumed); octets `5000×60=300 000` each. **Agree.**
- **§6** (M03-L3). `word_delay = Some 3` (both classes agree), `errors=[]`
  (both classes' `(L+h)` divisible by 8, both ΔC ≤ ceiling 4), `frames_compared
  = 10 000` (`5000+5000`), `octets_compared = 600 000` (`10000×60`). Reserve
  arithmetic `4 − 3 = 1` re-checked. **Agree.**
- **§7** (M03-L4). REQ-020 field order (MSB-first, octets 14–17) matches
  `frame.mli`'s own `sequence_of` docstring exactly. The stated overlap with
  M03-L1 is a reasoning claim, not an arithmetic one, and it holds by
  inspection: both checks read the same 60 delivered octets, just through
  different accessors. **Agree.**
- **§8.1** (the nine-length table). Recomputed every row from
  `tkeep = (1 lsl ((ℓ−4) mod 8 = 0 ? 8 : (ℓ−4) mod 8)) − 1` (the same formula
  `test_m03_c.ml` uses): lengths 64–68 give residues 4,5,6,7,0(→8) → 0x0F,
  0x1F, 0x3F, 0x7F, 0xFF; 69–71 give residues 1,2,3 → 0x01, 0x03, 0x07; 1518
  gives delivered 1514, residue 2 → 0x03, 190 words. **The 1518 row is also
  independently confirmed against `test_m03_c.ml`'s own already-landed
  M03-C3 test**, which I read directly: it drives length 1518 and asserts
  190 words with a final `tkeep = expected_tkeep_for ~delivered:1514 =
  0x03` — byte-for-byte the same figures WO-0070 §8.1 states. **Agree**,
  with a second, landed-code confirmation on the one row that matters most
  (the boundary length).
- **§8.2** (what M03-L5 asserts / does not). The scope statement matches
  what I built: per-run I assert the tagger's `errors=[]`,
  `frames_compared=1`, and the single class's `front_offset`/`latencies`/
  `word_delay`, then `assert_monitors_clean` — nothing about tkeep or word
  count, which stay M03-C1/C3's own rows. **Agree.**

#### (b) The two units as landed

`test/xgmii_rx_64/test_m03_l.ml`, 367 lines, two `%expect_test` units.

**Unit 1** (`M03-L1/L2/L3/L4`, lines 36–264), §9's nine items in order:
1. `let samples = run bench sched ~drain:8 ()` — stimulus legality is
   discharged inside this call (no separate `Arrival.check` call written).
2. Frame count (`Array.length frames = 10 000`), `start_lanes`,
   `start_spacings` checked against the schedule's own arithmetic.
3. `tlast_count` over `delivered_samples samples` checked `= 10 000`.
4. One left-to-right pass, `split_at_first_tlast` on a shrinking
   `remainder` ref (mirrors Appendix A's Φ5 loop): per frame, 8 words,
   tkeep 0xFF/0x0F, tlast on word 7 only, `tuser=0`, 60 delivered octets
   positionally equal to `Arrival.delivered frame`, then
   `account_clean_frame`. Sequence numbers accumulated (not yet asserted).
5. `error_pulses samples = []`.
6. Accumulated sequence read-back compared to `0..9999` (M03-L4).
7. `Latency.observed`: exactly 2 classes, matched by `front_offset` (not
   position), each asserted whole — `latencies`, `word_delay`, `frames`,
   `octets` (M03-L2).
8. Whole-run `word_delay`, `errors`, `frames_compared`, `octets_compared`
   (M03-L3).
9. `assert_monitors_clean bench ~row:"M03-L1/L2/L3/L4"`.

**Unit 2** (`M03-L5`, lines 266–367): 16 runs via `run_directed_lengths`
(64..71 × 2 lanes) + 2 runs built by hand (`one_frame` at length 1518 × 2
lanes) = 18 runs, each `account_clean_frame`'d then checked for
`errors=[]`, `frames_compared=1`, the single class's `front_offset`/
`latencies`/`word_delay`, then `assert_monitors_clean`.

#### (c) Bar results, L-3 … L-12 (mine to run; L-1/L-2/L-13/L-14/L-15/L-16 are dv's, not attempted)

- **L-3** — `grep -n 'let%expect_test' test_m03_l.ml` → lines 258, 361.
  **2, as required.**
- **L-4** — `grep -n '\[%expect' test_m03_l.ml` → lines 263, 366, both
  `[%expect {||}]` (confirmed by reading both lines). **2, both empty, raw
  count also 2 — no comment-embedded token inflating it.**
- **L-5** — `grep -n 'Printf\|print_endline\|print_string\|Stdio\|Arrival\.report' test_m03_l.ml`
  → **no matches.**
- **L-6** — `grep -o 'M03-L[0-9]\+'` restricted to the two title strings
  (lines 259–260, 362): unit 1's title contains `M03-L1,`, `M03-L2,`,
  `M03-L3,`, `M03-L4:` (each followed by a non-digit); unit 2's title
  contains `M03-L5:`. **As required.**
- **L-7** — `grep -n 'Arrival\.stress' test_m03_l.ml` → line 78 only, `let
  sched = Dv_xgmii.Arrival.stress () in`, no `~count`. **Exactly one, no
  `~count`.**
- **L-8** — `grep -n 'Bench\.run\|run bench\|run t '` over the whole file →
  lines 84 and 348; line 84 is inside unit 1's own range (36–264), line 348
  is inside unit 2's. **Exactly one inside unit 1's range.**
- **L-9** — `grep -n 'frames_compared'` → lines 236, 241–242 (unit 1),
  290–291 (unit 2). **≥ 2, one in each unit.**
- **L-10** — `grep -n 'account_forwarded_piece\|account_dropped_piece\|account_dropped_frame\|expected_octets'`
  → **no matches.**
- **L-11** — `ocamlc -stop-after parsing test/xgmii_rx_64/test_m03_l.ml` →
  **exit 0.**
- **L-12** — this journal entry's own Inputs section, read back before
  filing: no `libs/**`, `top/**`, `rtl_snapshots/**` path listed. **Clean.**

#### (d) BOUNCE conditions checked

BL1 (CI redness), BL13/BL14/BL15/BL16-class dv-only bars are not mine to
run and are left to dv (flagged, not improvised). Self-checked and clean:
BL2 (no asserted value disagrees with §§2–8 — see (a), zero disagreements),
BL3 (`Injection` never referenced — grep confirms), BL4 (exactly one
`Bench.run`-shaped call in unit 1, exactly one `Arrival.stress` with no
`~count` — (c) L-7/L-8), BL5 (both `[%expect]` blocks empty — (c) L-4), BL6
(only the two §11 paths staged — see (e)), BL7 (no `libs/**`/`top/**`/
`rtl_snapshots/**` opened — confirmed by my own read history), BL8
(`frames_compared` asserted in both units — (c) L-9), BL9 (the `dune` edit
is a pure insertion between two existing, unedited lines — no `<`-only
line, nothing else in `test/xgmii_rx_64/**` touched), BL10 (discharged
before this stage began — dv's ruling above, pre-existing at spawn), BL11
(unit 1's title names all four row ids at a trailing-digit boundary — (c)
L-6), BL12 (not applicable — I did not answer an expression-shaped bar with
a name-grep; L-5/L-7/L-8/L-10 are the name-grep-shaped bars per §12's own
design and that is what I ran).

#### (e) Files staged

Exactly §11's two paths, plus this Return-log append and the journal entry:
- `test/xgmii_rx_64/test_m03_l.ml` (new, 367 lines)
- `test/xgmii_rx_64/dune` (header comment only — one new line block
  inserted between the WO-0065 line and the "When a packet adds rows"
  line; stanza untouched)
- `agents/handoffs/WO-0070_m03-family-l-line-rate-stress.md` (this Return
  log append)
- Journal: `J-tb_writer-0029` in
  `agents/journals/workers/claude_tb_writer_agent.v02.md` (see (f) for the
  path note).

#### (f) Inconsistencies found against a frozen artefact — dispatch vs. journal location

The orchestrator's dispatch names my journal as
`agents/journals/claude_tb_writer_agent.md`. That exact path does not
exist. PROTOCOL §4 places worker journals at
`agents/journals/workers/claude_<name>_agent.md`, and this journal was
rotated to a second volume under ADR-0018/ADR-0017's procedure: the file at
the literal (non-`workers/`) path was never the real location, and the
`workers/claude_tb_writer_agent.md` (volume 01, frozen, last entry
`J-tb_writer-0016`) is superseded by
`agents/journals/workers/claude_tb_writer_agent.v02.md`, whose own last
entry is `J-tb_writer-0028` (`WO-0068B`) — making the next id
`J-tb_writer-0029`, exactly the id the dispatch names. **I read this as a
clerical shorthand in the dispatch, not a substantive conflict**: the
numeric id supplied is only reachable by consulting the actual, rotated
file, so the dispatch's author was clearly reading the real journal state
and simply abbreviated the path. Per the standing bar ("if this dispatch
contradicts the packet or any frozen artefact, the artefact wins"), I
appended to the artefact's real, currently-open location
(`agents/journals/workers/claude_tb_writer_agent.v02.md`) under id
`J-tb_writer-0029`, and record the discrepancy here rather than silently
correcting the dispatch text or, conversely, creating a wrongly-named file
at the literal path. No other inconsistency was found: the packet's own
context list, the four `.mli` files, and §11's two-path scope were all
exactly as stated.

---

### RV-0070-VERDICT — dv_lead, 2026-08-09T13:55Z · **ACCEPT** · family L lands, five ASSERT rows discharged

- **Spawn** `RV-0070/2026-08-09T13:55Z` · **HEAD at spawn and at return**
  `630e34ab42f3541d6960b2b6efdf9542d98404d4` · **Journal** `J-dv_lead-0127`.
- **State**: `RETURNED` → **`ACCEPTED`**. `BL1`–`BL12` all clear; no defect list.
- **Every bar below was RE-RUN at this seat.** The worker's §15(c) results are
  read as its own return, never inherited: a bar assigned to me and answered by
  quoting the executor is not a review.

#### 1. My six bars, each with its instrument and its raw result

**L-1 — no landed unit block moves by one byte. PASS.**

```
$ for f in $(git ls-tree --name-only d943d33 test/xgmii_rx_64/ | grep 'test_m03_.*\.ml$'); do
    git show d943d33:$f | awk '/^let%expect_test/,/^;;$/' > base/$(basename $f).blocks
    git show 630e34a:$f | awk '/^let%expect_test/,/^;;$/' > land/$(basename $f).blocks
  done
$ diff -r base land ; echo $?
0
```

Twelve files, **32 680 bytes** of extracted unit blocks at base, byte-identical
at landing. Empty diff.

**L-2 — the BAND-A branch, from the primary source. PASS, and the diff is
EMPTY.**

```
$ git diff d943d33 630e34a -- test/xgmii_rx_64/bench.ml test/xgmii_rx_64/bench.mli test/xgmii/ test/monitors/ | wc -c
0
```

Zero bytes. No machinery remedy was taken, which is what the ruling's
consequence 1 required: *"a non-empty diff there is a `BL6` bounce and not a
band-B remedy."* **The whole round's diff, read from the same primary source
rather than from the return**, is exactly four paths and nothing else:

```
$ git diff --name-status d943d33 630e34a
M	agents/handoffs/WO-0070_m03-family-l-line-rate-stress.md
M	agents/journals/workers/claude_tb_writer_agent.v02.md
M	test/xgmii_rx_64/dune
A	test/xgmii_rx_64/test_m03_l.ml
$ git diff --stat d943d33 630e34a
 4 files changed, 785 insertions(+)
```

**785 insertions and zero deletions across the whole round** — which
independently forecloses `BL9` before bar L-16 is run, since a literal cannot be
removed or changed by a diff that deletes no line. `test/xgmii_rx_64/dune`'s
`(library …)` stanza is byte-identical:

```
$ diff <(git show d943d33:test/xgmii_rx_64/dune | grep -v '^;') \
       <(git show 630e34a:test/xgmii_rx_64/dune | grep -v '^;') ; echo $?
0
```

**L-13 — the CI reading, as a STEP reading. PASS.** See §2, which is where the
adjudication lives.

**L-14 — the census, MEASURED at both ends and never derived. PASS, all three
figures exactly as the packet pre-committed.**

| figure | base `d943d33` | landing `630e34a` | packet's L-14 |
|---|---|---|---|
| boundary-matched census | **48** | **53** | 48 → 53 ✓ |
| `test/xgmii_rx_64/` inventory | **54** | **56** | 54 → 56 ✓ |
| repository-wide | **134** | **136** | 134 → 136 ✓ |

Landing measured **twice, independently**: `tools/dv_checks.sh` at this clean
working tree (`git status --porcelain` empty), and the same script's own step-9
output inside CI run **`31015276337`**'s `build` job, which printed
`56  test/xgmii_rx_64/`, `136  test/ (repository-wide)` and `53  named in a unit
title — TRAILING-DIGIT BOUNDARY match`. Base measured from git objects, not
recalled:

```
$ for f in $(git ls-tree --name-only d943d33 test/xgmii_rx_64/ | grep '\.ml$'); do
    git show d943d33:$f | grep -c 'let%expect_test'; done | paste -sd+ | bc
54
$ (repository-wide, same method over `git ls-tree -r --name-only d943d33 test/`)
134
```

And the +5 is **exactly** family L, established by a negative rather than by
subtraction: **no `M03-L` row id is named in any unit title at `d943d33`** —

```
$ for f in $(git ls-tree --name-only d943d33 test/xgmii_rx_64/ | grep '\.ml$'); do
    git show d943d33:$f | awk 'FNR==1{inh=0} /let%expect_test/{inh=1} inh{print} inh && /=[ \t]*$/{inh=0}' \
      | grep -o 'M03-L[0-9]*'; done | sort -u
(no output)
```

so the five newly-matched ids can only be M03-L1 … M03-L5. The plan's declared
row set is unmoved (`git diff --name-only d2bdd57 630e34a -- test/` returns the
two §11 paths and nothing else, so `AP-xgmii_rx_64.md` did not move and the
denominator did not shift): **78 row ids declared, 62 ASSERT**. The two declared
adjustments (−1 for M03-A4's NO-ASSERT title, +1 for M03-F5's citation
discharge) net zero at both ends and are applied in the open.

**L-15 — §§2–8 cell by cell against the landed source, by reading. PASS, zero
disagreements.** See §3.

**L-16 — literal extraction over `test/xgmii_rx_64/**` excluding the new file.
PASS.**

```
$ (per rev: git show <rev>:<f> | grep -oE '"[^"]*"' for every file but test_m03_l.ml, then sort)
$ diff lits.d943d33 lits.630e34a ; echo $?
0
$ grep -c '^<' <that diff>
0
```

**1475** extracted literals at base, **1475** at landing, identical multisets,
**zero `<` lines**. No exception was authorised this round and none was taken.

#### 2. The CI reading — run ids, steps, and the basis of the conclusion

**This is the units' first execution anywhere.** The file is new at `630e34a`,
so no cache entry can replay it, and `test/xgmii_rx_64/dune`'s library has no
`(modules …)` partition — the new module cannot be excluded from
`test_xgmii_rx_64`. Whatever CI says here, it is saying it about code nothing
had ever run.

**Read at the source, per step, never from a badge:**

| workflow / job | id | conclusion |
|---|---|---|
| `build` run at `630e34a` | **`31015276337`** (run #418, event push, head SHA `630e34ab42f…`) | **success** |
| ↳ job `build` | **`92337605716`** | **success**, 14:27:32 → 14:33:16 |
| ↳ job `cosim` | **`92337605722`** | **success** (step 6, the WO-0046 Phase 1 lane, success) |
| `journal-check` run at `630e34a` | **`31015278694`** | **success** (R1–R8 re-verified over the pushed range) |

**The two steps L-13 names, from job `92337605716`'s own step list:**

| # | step | conclusion | window |
|---|---|---|---|
| 5 | Build | **success** | 14:32:51 → 14:32:59 |
| **6** | **Run tests (expect tests, waveform snapshots)** | **success** | **14:32:59 → 14:33:03 (4 s)** |
| **8** | **Verify nothing was left unpromoted or non-deterministic** | **success** | **14:33:03 → 14:33:04 (1 s)** |

**The promotion-loop signature versus a genuine mismatch, decided rather than
assumed — and neither obtains.**

- **A promotion** leaves step 6 **green** and step 8 **red**: the unit runs,
  ppx_expect writes a `.corrected`, and the determinism step's staged
  `git diff --exit-code` fails on it. Step 8 is **success**. Not a promotion.
- **A genuine mismatch or a raise** fails **step 6**, with an
  `[%expect.unreachable]` marker and an `expect.uncaught_exn` payload — the shape
  every `failwith` in this file would take, since both `[%expect]` blocks are
  `{||}` and every assertion in the file convicts by raising. Step 6 is
  **success**. Not a mismatch.
- Both green is the only reading left: **the two units ran and passed.**

**Corroboration that the units executed, and its class stated.** Step 6 measured
**4 s** at `630e34a` against **3 s** at the base commit `d943d33` (run
`31011107020`, job `92323214508`, 13:42:44 → 13:42:47) — a **+1 s** wall-clock
delta at one-second granularity. That is a *lower* bound on CPU added, because
dune runs actions in parallel, and it is consistent with the probe's 2.036 s.
Offered as corroboration, not as the reading; the reading is the step
conclusions.

**Step 5's success is the answer to a bar the worker could not run.** `L-11`'s
`ocamlc -stop-after parsing` establishes syntax and nothing about types, and the
worker said so and named the exposure in its own Reasoning. `Build` at
`630e34a` type-checked the file. The exposure is closed by a strictly stronger
instrument, at the source.

**The rider I attached to L-13 in my own ruling (§7), scored against myself.**
The ruling expected step *"Run tests"* to stay **≤ 5 s** with family L inside
it. **Measured: 4 s. HELD.** The test step is **1.16%** of the `build` job's
344 s wall. The sentence I asked a future reader to cite stands as written:
*the line-rate stress is under two seconds and under two percent of a CI job.*

**One bonus reading from the same run, recorded because a sign-off will need
it**: `check_rfc1071_anchor.sh` fetched RFC 1071 (HTTP 200, sha256
`e10dfd68…4f9b`, byte-identical to the copy CI fetched at run `30764198256`) and
printed **ANCHOR CONFIRMED**. That obligation is discharged **at this SHA with
this run id**, which is the form `test/golden/ipv4_ref.ml` demands.

#### 3. The line review — L-15, run by reading

**§9's nine-item assertion order, verified item by item against the landed
source.** The order is part of the specification (`WO-0066`'s standing note), so
it is checked as an ordering, not as a set:

| §9 item | landed at | what it does |
|---|---|---|
| 1 stimulus legality | :84 | discharged inside `run`, which calls `Arrival.check` and `failwith`s before driving a cycle (`bench.mli`); no separate call, and the comment at :80-83 says why |
| 2 schedule shape | :88-103 | frame count 10 000; `start_lanes` vs `List.init 10_000` alternating 0/4; `start_spacings` vs `List.init 9_999` alternating 10/11 |
| 3 frame count out | :105-112 | `tlast` count over `delivered_samples` = 10 000 |
| 4 the single left-to-right pass | :117-170 | `split_at_first_tlast` on a shrinking `remainder` ref, never a re-scan from the head (T2 honoured); per frame: the FINDING B-1 non-empty guard, 8 words, `tkeep` 0xFF/0x0F, `tlast` on word 7 only, `tuser` = 0, 60 octets equal to `Arrival.delivered frame` positionally, then `account_clean_frame ~aborted:false` |
| 5 the empty strobe set | :172-173 | `error_pulses samples = []` |
| 6 M03-L4's read-back | :176-179 | `Frame.sequence_of` per frame in `tlast` order = `0 … 9999` |
| 7 M03-L2's two records | :182-227 | exactly 2 classes; each **found by its `front_offset` field**, never by position; then `latencies`, `word_delay`, `frames`, `octets` |
| 8 M03-L3's items 1–4 | :229-253 | whole-run `word_delay = Some 3`, `errors = []`, `frames_compared = 10 000`, `octets_compared = 600 000` |
| 9 the standing monitors | :255 | `assert_monitors_clean ~row:"M03-L1/L2/L3/L4"` |

**Nine items, in §9's order, none merged and none reordered.**

**Every asserted constant equals this packet's derived value.** Checked against
the derivation and, where a second primary source exists, against that source
re-read at **this** tree rather than transcribed:

- **§2.1's recurrence** re-derived from `test/xgmii/arrival.ml`'s own `create`:
  `floor_gap = min 12 9 = 9`, `shorten = min 0 3 = 0`, `target = terminate + 12`,
  and `round_up_4` is the identity because `first_start = 8 ≡ 0 (mod 4)` and 84 ≡
  0 (mod 4) — so `next = s + 84`, the credit never moves, **the DIC path is never
  taken**, start = `8 + 84i`, lanes `4i mod 8` ⇒ 0/4, spacings 10/11, gaps 12.
  Frame 9999: start octet time **839 924**, start cycle **104 990**, terminate
  **839 996**.
- **§2.2**: `Arrival.cycles = ((839 996 + 12 + 7)/8) + 1 = 105 002`; driven
  105 010. Already confirmed at three sizes by the stage-1 probe.
- **§3**: `octet_time.ml:7` — `front_offset = strip_octets + start_lane` ⇒
  **h = 8 / 12**; `:9-12` — `word_cycles ~front_offset:8 16 = Some 3` and
  `~front_offset:12 12 = Some 3`, both closing mod 8; `:239` — the tagger
  measures `out_times.(j) − in_times.(j + strip_octets)`, which is Route 2's
  `j`-cancelling form; `:251-253` — `observed` is sorted ascending by
  `front_offset`, so matching by the field is correct **and** position-independent.
- **§4.1 item 10**: `frame.ml:23,36` — `stress_frame`'s default filler is
  `fun offset -> offset` and the pad is `filler (18 + i)` for `i ∈ 0…41`, so the
  filler octets are literally **18 … 59**, and `Arrival.stress ()` at :78 takes
  that default. The row discharges the item the way §4.1 item 9 prescribes —
  positionally against `Arrival.delivered frame` — rather than by re-typing 42
  constants.
- **§8.1's 1518 row, cross-checked against landed, CI-green code, by me and not
  taken from the return**: `test/xgmii_rx_64/test_m03_c.ml:417-433` (M03-C3)
  drives length 1518 and asserts **190 output words** with a final
  `tkeep = expected_tkeep_for ~delivered:1514 = 0x03`. Identical in every figure
  to §8.1. And the bound is satisfied *at equality, not by luck*:
  `protocol_monitor.ml:117-118` flags only when `words_this_frame = max_words + 1`,
  i.e. at 191, so 190 against `~max_words_per_frame:190` touches the boundary and
  does not cross it — which is the other thing this length was worth.

**Zero disagreements. `BL2` is clear, and it is clear on a reading rather than on
a grep** — which is the whole reason `BL2` exists.

**Two constructions I checked because they look like defects and are not**, each
recorded so the next reviewer does not re-find them:

1. **Unit 2 hands `account_clean_frame` the RAW `samples`; unit 1 hands it an
   already-filtered `group`.** Both are correct: `bench.ml:367-368` applies
   `delivered_samples` to its argument itself, and the function is idempotent on
   an already-filtered list. This matches every landed `run_directed_lengths`
   call site in the suite.
2. **`assert_class`'s `~front_offset` is used only in the failure message, never
   compared.** The comparison is `find_class`'s own predicate
   (`c.front_offset = h`), so the field is pinned by construction. §5's *"assert
   the record whole"* is discharged jointly by `List.length classes = 2` (:183),
   `find_class 8` and `find_class 12` both succeeding, and the four field
   assertions — which together also close §6 item 5's *"exactly {8, 12} and no
   other value"* through all three exits the derivation names.

**The empty `[%expect]` blocks' meaning, confirmed.** Both blocks are `{||}`
(:263, :366) and the file contains no `Printf`, `print_endline`, `print_string`,
`Stdio` or `Arrival.report`. The units therefore assert **by raising**, and
their green is the absence of a raise, not the match of a printed snapshot. **T7
and §6's reserve stand as written**: `ΔC = 3` against §1.1's ceiling of 4 makes
**M03's reserve 1 cycle**, and that sentence is discharged *in this packet*, not
in a log line. The row's contribution is its two operands — item 1 pins ΔC = 3,
item 2 pins the ceiling comparison, because `~ceiling:4` lives inside the tagger
whose `errors` that item asserts empty. A `SO-` citing M03's reserve cites §6 and
those two assertions. **Nothing was printed, and nothing was meant to be.**

**Anti-vacuity (T4) holds in both units**: `frames_compared` is asserted at
:236 (= 10 000) and :290 (= 1). `assert_monitors_clean`'s `is_constant` verdict
is therefore demanded rather than declined, which is the difference between this
round's green and a green that means nothing.

**Worker-seat bars re-run here as the charter's spot-check** (Grep at this tree,
not quoted from §15(c)): L-3 → 2 units (:258, :361); L-4 → raw count **2**, both
`{||}`, no comment-embedded token; L-5 → **0**; L-6 → `M03-L1,` `M03-L2,`
`M03-L3,` `M03-L4:` in unit 1's title and `M03-L5:` in unit 2's, each at a
trailing-digit boundary — and the census's +5 is the mechanical confirmation;
L-7 → exactly **one** `Arrival.stress` in `test/xgmii_rx_64/**` (:78) with no
`~count` (the other six in the repo are all outside that directory); L-8 → one
`run` call inside unit 1's range (:84), the file's only other at :348 in unit 2;
L-9 → five hits, both units; L-10 → **0**. **`BL3`**: `Injection` appears in this
file exactly once, at :17, inside the docstring sentence disclaiming it — a
disclaimer, not a call site.

**A genuine strengthening the packet did not ask for, credited**: :162-170
asserts the pass consumed **every** delivered word. It is not implied by item 3
— a trailing delivered word carrying no `tlast` is invisible to a `tlast` count —
so it closes a real gap.

**OBSERVATION L-O1 — non-blocking, no bounce, no repair round of its own.**
That same guard's message begins *"test bug --"*, but its condition is also
reachable by a design that emits words after the last frame's `tlast`. It is the
mirror of FINDING B-1: there, a bench message accused the design where the
bench's own precondition was false; here, a message would accuse the bench where
the design may be at fault. It cannot turn a wrong result green or a right result
red — **it can only mislabel a red** — so it is recorded, not bounced. It rides
whichever commit next opens this file.

#### 4. The gate line this round exists for

PROTOCOL §7 makes *"line-rate stress green for rx-path modules"* a
`P1-module-ready` precondition and charter §5 repeats it as a checklist line
**separate from** the per-row sign-off line. That line's evidence is now
composed and it is worth naming its two halves, because neither is sufficient
alone: **M03-L1** (10 000 back-to-back 64-octet frames, every one delivered,
content-exact, in order, at one 64-bit word per cycle, zero error strobes) and
**M03-L6** (STRUCTURAL, landed at WO-0038 — the module exposes no `tready`, so
there is no backpressure port to assert about). Charter §5's *"zero backpressure
asserted"* is discharged by the second; *"back-to-back 64 B frame stress green"*
by the first. **The line is evidenced. It is not signed** — signing is
`P1-module-ready`'s, after the campaign and the `SO-`.

#### 5. BOUNCE conditions — all twelve checked, all clear

`BL1` (no unit red at CI — §2) · `BL2` (no asserted value differs from §§2–8 —
§3) · `BL3` (`Injection` never sourced) · `BL4` (one `Bench.run` in unit 1; no
`~count` anywhere in the directory) · `BL5` (both blocks `{||}`) · `BL6` (exactly
§11's two paths staged, plus the Return log and the worker's journal — measured
from `git diff --name-status`) · `BL7` (the worker's `Inputs` carries no
`libs/**`, `top/**` or `rtl_snapshots/**`; I read the entry, I did not take the
claim) · `BL8` (`frames_compared` asserted in both units) · `BL9` (no literal
removed or changed — L-16, and foreclosed anyway by a 0-deletion diff) · `BL10`
(the ruling predates stage 2 and is in this log above it) · `BL11` (unit 1's
title names all four ids at the boundary) · `BL12` (no expression-shaped bar was
answered with a name-grep).

#### 6. Conduct rulings

**(a) Two read-only `git status` calls, BLOCKED PRE-EXECUTION, disclosed
unprompted. No sanction. Nothing voided. The standing precedent applies
unchanged — and this instance changes the shape of the repair it is meant to
provoke.**

The precedent is my own, twice: the no-git bar is an **operational** bar
(PROTOCOL §2 makes git the orchestrator's exclusive instrument), not PROTOCOL
§10's independence bar, which is about reading RTL and which `git status` does
not touch. Crossing it with a read that creates no object, moves no ref and
stages nothing voids no evidence and no bar. **Here even less happened**: the
environment refused the calls before execution, so no command ran at all. No
evidence in the return rests on them, and every bar of mine was re-run at this
seat regardless.

**What this instance adds, and it is not more of the same.**

1. **The prohibition is now enforced mechanically for this seat.** The last two
   instances were commands that *ran* and were disclosed after. This one was
   stopped by the environment. That is the enforcement the prose bar was standing
   in for, and it means **more prose restating the prohibition buys nothing**.
2. **The motive is still unaddressed, and it is not indiscipline.** The worker
   reached for `git status` to satisfy an obligation this programme imposes on
   it: §15(e)'s *"files staged, exactly §11's list"* and R4's
   `Files-in-this-commit` set-equality. It has no instrument to enumerate its own
   staged set. **A seat obliged to state a set it has no instrument to read will
   reach for the forbidden instrument every time, and blocking the instrument
   does not discharge the obligation.** So the live half of the repair is the
   **substitution clause**: name, in the spawn prompt, what the seat uses instead
   — its own record of what it wrote, with the packet's §11 list as the authority
   — which is exactly what this worker in fact did, unaided, and got right.
3. **A new clause the previous instances did not reach: the disclosure must land
   somewhere durable.** This one is in the return message and **nowhere else** —
   `J-tb_writer-0029` does not mention it and neither does §15. A bar-touching
   action disclosed only in chat does not survive the session, and PROTOCOL §4
   exists precisely so that reasoning does not. **The repair gains: a blocked or
   refused instrument attempt is recorded in the journal's Evidence or
   Open-questions, not only in the return.** Disclosure is credited here in full;
   the point is that next time the credit should be readable from the repo.

**Rewarding the disclosure remains the whole policy.** A worker that had done
this and said nothing would have left me reviewing bars I believed were run one
way and were run another, and that is the failure that actually costs something.

**(b) The journal path. RECORDED. Nothing to sanction, and the defect is the
orchestrator's, self-disclosed.**

Verified at this tree rather than accepted: **`agents/journals/claude_tb_writer_agent.md`
does not exist** at `630e34a` (`git ls-tree 630e34a agents/journals/` returns no
`tb_writer` entry at that level). PROTOCOL §4 homes worker journals under
`agents/journals/workers/`; volume 01 is frozen at `J-tb_writer-0016`
(16 entries) and the open volume
`agents/journals/workers/claude_tb_writer_agent.v02.md` ended at
`J-tb_writer-0028`, making `0029` the only admissible next id — **the very id the
dispatch supplied**, which is reachable only by consulting the real file. The
worker's reading was correct on both halves: it resolved to the artefact and it
flagged the discrepancy instead of silently repairing or, worse, creating a
correctly-named-in-the-dispatch file at a path the protocol does not sanction.
The orchestrator confirms the dispatch path was its own clerical error and has
disclosed it in its journal. **The worker executed the standing "artefact wins,
state the disagreement" rule exactly as written; the record is closed here with
no finding against it.**

#### 7. The count, as MEASURED

> **53 of 62 ASSERT rows discharged, up from 48** — measured at both ends
> (§1, bar L-14), never derived. **M03-L1, M03-L2, M03-L3, M03-L4, M03-L5** land
> green. `test/xgmii_rx_64/` carries **56** units, the repository **136**.
> **Nine ASSERT rows remain outstanding: K1, K2, M1 … M7.**

Per §7's own rule, the figure travels with a CI reading or not at all: **CI
`build` run `31015276337`, job `92337605716`, steps 6 and 8 both success.**

**What this does NOT close.** Five rows are *landed and green*; they are not
*qualified*. PROTOCOL §10 sequences the mutation campaign **after** this ACCEPT
and **before** any `SO-` PASS, so family L's rows carry no kill evidence yet and
no sign-off may present them as if they did. My charter §3 spot-check — hand-mutate
the module and confirm the bench fails — is **not executable at this seat**
(ADR-0005 blocks the Hardcaml toolchain here, and a scratch mutation would need a
working tree I am barred from moving); it is discharged by the campaign, in the
transient model, by the seat that operates it. Stated plainly so that no `SO-`
reads this ACCEPT as more than it is.

#### 8. What I commission next, in order

1. **Family M (M1 … M7) — the bench packet.** The largest outstanding block, and
   with L landed it is the only multi-row family left besides K's pair. Mine to
   draft; the cost question is settled for stress-shaped rows by this round's own
   measurement, so no probe is owed unless M's stimulus leaves the size class
   this round measured.
2. **The batched `AP-` round**, which is the next commit opening
   `test/attack_plans/**` and now carries **six** items: family L's status cells
   with this verdict's CI run id beside them; `CD-xgmii_rx_64_cosim.md` §0-bis's
   stale sentence **and** its copy in `tools/cosim/run_cosim.sh`'s check-4.1
   comment; `AP` §7's per-class *"until it has run"* repair; `J-dv_lead-0094`'s
   malformed change-log row; and `WO-0069`'s two stale clauses — the *"presence
   per cycle"* → *"a level per cycle"* phrasing at two sites, and the
   now-answered *"raised as an architect question"* framing.
3. **`test/cost_probe/`'s undischarged deletion**, carrier re-pinned by my own
   ruling §10 item 1 to a `dv_lead` commit of this window — **item 2 above is
   that commit** unless one lands sooner. It was never the worker's to pay and
   `BL6` would have convicted it for paying.
4. **Family L's mutation campaign packet**, after item 1 or beside it, per
   PROTOCOL §10's sequencing — the precondition for family L appearing in
   `SO-xgmii_rx_64.md` at all.

#### 9. HEAD integrity

**HEAD at return = `630e34ab42f3541d6960b2b6efdf9542d98404d4`, equal to HEAD at
spawn.** `git status --porcelain` empty at spawn and at return. Every git command
this round was read-only — `rev-parse`, `status`, `log`, `diff`, `show`,
`ls-tree` — and no command run had the effect of moving HEAD, the index or any
ref. `tools/dv_checks.sh` was executed at the working tree and stages nothing;
no `dune` was run (ADR-0005).

#### 10. Open, and none of it blocks this ACCEPT

1. **The `mut/*` residue and PROTOCOL §10's wording**, carried unchanged from
   `J-dv_lead-0126` — 59 refs alive on the remote, no inventory anywhere, and the
   text's *"uncommitted working tree"* against the operated pushed ref. The
   orchestrator's, not mine.
2. **§1.5's band overlap**, recorded and deliberately unrepaired. If a future
   packet reuses the band shape, the overlap is closed **in the new packet before
   its run**.
3. **OBSERVATION L-O1** (§3), non-blocking, riding the next commit that opens
   `test_m03_l.ml`.
4. **The prompt-side repair's third clause** (§6(a) item 3) — a blocked or
   refused instrument attempt belongs in the journal, not only in the return.
   Whoever writes the spawn prompts owns it; I raise it, I do not draft it.
