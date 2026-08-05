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
