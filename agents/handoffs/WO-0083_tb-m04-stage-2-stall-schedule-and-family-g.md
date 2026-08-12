# WO-0083: the stall schedule and the abort law — family G's pulse rows, the gap after an abort, and the preamble word that must not remember how the last frame ended

- **State**: **DRAFT.** Not issued. Drafted by dv_lead at `J-dv_lead-0193`,
  at head **`22c60fb`**. **Issuing is the orchestrator's act — commit plus
  spawn — and only after my return and its verification.** Nothing below is
  in force until then, and no `tb_writer` may be spawned against it before
  it is `ISSUED`.
- **PACKET NUMBER — placeholder, deliberately.** PROTOCOL §3: *"the
  orchestrator — as sole committer — allocates the next `NNNN` per prefix
  when a packet is first committed; drafts circulating before commit use a
  placeholder id."* This draft's filename carried **`WO-00XX`** (committed so
  at 7f55848, exactly as the drafting entry declared it). Measured at
  this tree, the next free number is **`WO-0083`**: `WO-0082` is the highest
  committed id under `agents/handoffs/`, no `WO-0083` file exists, and
  `grep -c 'WO-0083' tasks/BOARD.md` → **0**. **The allocation is the
  orchestrator's; this is a measurement handed to it, not a claim on the
  number.** *(Allocated `WO-0083` by the orchestrator in the commit after
  7f55848 — rename plus id substitution, this parenthetical the only added
  text; the drafting seat's measurement above proved out.)* Every internal self-reference below reads *"this packet"* rather
  than an id, so the rename is one act on the filename and the head block and
  touches no cross-reference.
- **The text this packet inherits, and from where.** `WO-0082` **Revision B**
  (`J-dv_lead-0192`). Revision B's four corrections are **carried into this
  packet's own text**, not cross-referenced: the *describe, never name* rule at
  every demand that produces the sentence (§1.4, §5.4, §9.8, §11.1, `BM8`);
  *byte-identical behaviour* defined as the firing conditions and their order
  rather than the message text, with the messages permitted to move **named
  here for this round's own re-expression** (§5.2); the *name the shape, not the
  function* rule (§5.3); and **§17.1's five-item allow-list, inherited verbatim
  including item 3's plumbing clause and item 5's `date -u` carve-out** — with
  the one substitution that could not be verbatim **marked in place** (§17.1).
- **The design this packet consumes, and where it was fixed.** `WO-0082`
  **§20**, committed at `J-dv_lead-0192` — the scheduled-run postcondition class
  (`ST-1` … `ST-4`), the schedule's content and its two legality rules, the
  `Resume` trap, the instrument generalisation, and the allowance's derivation
  rule. **That design was fixed at a SHA earlier than this packet by
  construction**, which is the whole reason it was written into `WO-0082`
  instead of here: a design a worker meets for the first time in the packet
  that commissions rows against it is an invitation to invent one. §5.3 below
  **implements** that design in signatures; it does not re-open it. Where this
  packet extends it — the `word ≥ 2` rule for a back-to-back frame (§4.4), the
  abort law's own arithmetic (§4.2), the tail-frame law (§4.3) — the extension
  is marked as such with its ground.
- **From** / **To**: dv_lead → tb_writer
- **Attack plan**: `test/attack_plans/AP-xgmii_tx_64.md` (**AP-M04**), **frozen
  for this round at `22c60fb`** — 82 rows in 15 families, **31 discharged**
  (13 at `af06c62`, 12 at `aabae58`, 6 at `65ba148`), **51 outstanding**.
  **Nothing in that file moves this round**: this packet reads it, it does not
  edit it, and issuing a work order is not one of the events §9's change-log
  discipline attaches a row to. **This packet commissions 8 rows**: `M04-G1`,
  `M04-G2`, `M04-G3`, `M04-G5`, `M04-G6`, `M04-G8`, `M04-A4`, `M04-F6`.
  **All eight ASSERT**, counted row by row against the plan's own Status column
  at this tree — a count, not a summary. Read every row **in the plan itself**;
  §2 below is an index and the **Observable cell is the contract**.
- **Spec basis** — **RE-PINNED AT THIS HEAD, not inherited.**
  `docs/specs/modules/xgmii_tx_64.md` (**SPEC-M04**), **FROZEN at `f78766e`**,
  *plus every §13 row* — the frozen text and its recorded diffs together are the
  specification. Sections in scope: **§6.1 entire** (the preamble, the frame,
  padding, the FCS's four items, terminate-and-fill, the inter-frame-gap
  paragraph and its `g = ⌈(cfg_ifg + t)/8⌉` rounding, the cycle-by-cycle table,
  and **the storage paragraph — this round's central arithmetic**); **§6.2
  entire, and above all the `Frame`, `Abort`, `Gap` and `Idle` rows and the
  C-16 early-acceptance paragraph**; **§6.3 items 3 and 4**; **§7 entire — the
  C-14.1 bullet, the C-16 bullet with all four consequences, the handshake
  bullet and the reset bullet**; **§9 entire — the row, the *Strobe cycle,
  pinned* paragraph, the *No FCS on an underflowed frame* paragraph and the
  co-occurrence bullets. §9 is this round's central text.** Supporting:
  `docs/specs/requirements.md` **§0.3** (the gap convention), **§0.5**, **§0.6**
  (the counting convention, the window and its fourth reference-word clause),
  §9.1, REQ-201 … REQ-207, REQ-209, REQ-210, REQ-008, REQ-011, REQ-012,
  REQ-015, REQ-020, REQ-021, REQ-301 … REQ-305.
- **REQ ids this round touches**: **REQ-206** (family G's whole subject — and
  see §9.8: this round moves REQ-206 a long way and **does not close it**),
  **REQ-207** (the already-accepted words reach the wire — `M04-G5`'s and
  `M04-G1`'s content claims), **REQ-204** (`M04-F6`'s 15-octet gap, the one
  octet that separates conformant from not), **REQ-201** (`M04-A4`'s three
  preamble words), **REQ-008** and **REQ-802**-adjacent conservation
  (`M04-G8`), REQ-202/REQ-203/REQ-305 through `M04-G6`'s second frame.
- **Deliverables**: **six staged files** — two extended
  (`test/xgmii_tx_64/bench.mli`, `test/xgmii_tx_64/bench.ml`), one header-only
  edit (`test/xgmii_tx_64/dune`), and **three append-only edits**
  (`test_m04_g.ml`, `test_m04_f.ml`, `test_m04_a.ml` — §11.4's rule is what
  makes those safe) — enumerated at §11.2 and nowhere else, **plus** this
  packet's Return log and your journal entry at
  `agents/journals/workers/claude_tb_writer_agent*.md`. **Eight paths in
  total. This round creates no new source file.**
- **Definition of done**: every row in §2 mapped to a named `%expect_test` unit
  or explicitly declared not-implemented with a reason; every `[%expect]` block
  left **empty** (ADR-0005 rule 2 — this round commissions **no** printed value,
  so *every* block stays empty and any content in one is `BM18`); every verdict
  asserted in OCaml; every derived constant of §6 present at the site §6 places
  it, or reported as disagreed with; Return log filled to §18's shape; journal
  entry appended; no file outside §11.2 touched; **no deletion in any of the
  three appended files**; and **none of the five untouched landed
  `test_m04_*.ml` files modified**. **No doc impact. No `SO-` packet — that is
  mine (PROTOCOL §3).**
- **Context provided**: the specification sections named above; the attack-plan
  rows; the machinery contracts at §5, quoted from `.mli` files you may read in
  full; **the abort law at §4 and every constant derived from it at §6**.
  **RTL source is deliberately omitted — see §8.**
- **Out of scope**: `libs/**`, `rtl_snapshots/**`, `top/**`, `docs/**`,
  `tools/**`, `bin/**`, `.github/**`, `test/xgmii_rx_64/**` (read-only),
  `test/monitors/**`, `test/xgmii/**`, `test/golden/**`, `test/cosim/**`,
  **`test/attack_plans/**` (read-only, and frozen for this round)**; any
  attack-plan row not in §2; any co-simulation work whatsoever (§9.6, BAR T1);
  `git commit` / `git push`.

---

## Section map

| § | What |
|---|---|
| 0 | What this round is, and the one capability it exists to build |
| 1 | Why this slice — what rides, what is held back, the capability axis |
| 2 | The eight rows |
| 3 | The frozen references, by SHA — re-pinned at this head |
| **4** | **The abort law — `AP-M04` §7 `T-3`'s second half, derived here** |
| 5 | The capability layer — what is landed, the extension, what it does NOT build |
| 6 | The derived constants, per unit |
| 7 | How to instantiate the DUT without reading it |
| 8 | What you may NOT read |
| 9 | Regime facts — the standing rules that bind this round |
| 10 | Cost — the size class, measured, and this round's ceiling |
| 11 | Unit structure, the files this round stages, and the append-only rule |
| 12 | The review bar — pre-committed, assigned by seat, every tree-quantified bar executed at the base |
| 13 | BOUNCE conditions — pre-committed |
| 14 | Traps — named so they are not discovered |
| 15 | Disposition classes for a red — PRE-COMMITTED |
| 16 | Incremental-write and expected-CI discipline |
| 17 | Your terms — the allow-list, inherited verbatim |
| 18 | Your return |
| 19 | What this round does NOT carry, and what I owe after it |
| **20** | **What the spawn prompt must quote at its head — `BM17`'s arming condition (a)** |

---

## 0. What this round is, and the one capability it exists to build

**Every M04 run ever driven has presented every word the transmitter asked
for.** That is not a stylistic fact about the benches; it is written into the
landed machinery's own contract: `bench.mli`'s module docstring says *"The
presenter never withholds a word mid-frame"*, and `assert_instruments_clean_n`
fails any run in which the strobe fired or any decoded frame underflowed.
**Twenty-eight runs, thirty-one discharged rows, and not one underflow.**

`AP-M04` §7 item **T-3** is the measurement of that absence, taken at the
committed producers and not inferred, and it splits the missing machinery in
two: *"**THE PRIMITIVE EXISTS; THE ORACLE DOES NOT** … (i) Placement:
`test/axi64_probe/axi64_driver.ml` drives one `Axi64.Source` record onto the six
`Bits.t ref`s per call, so withholding a word on a chosen cycle is a bench
presenting `tvalid` = 0 there — **no new module is needed and none is
commissioned** … (ii) Computed outcome: **nothing derives, from a stall
schedule, the expected strobe cycle, the `/E/` word's cycle and the truncated
octet count**. Family G hand-derives all three from §9 and §6.1, which is the
half `AP-M03` gates and this plan simply does not have."*

**This is that round.** §4 below is `T-3`(ii) — the derivation, done once, from
SPEC-M04 §9 and §6.1, for every quantity every row in this round needs. It is
the plan's own recorded disposition executed: *family G hand-derives all three*.
§5.3 is the schedule that reaches `T-3`(i)'s primitive through the landed
presenter.

**Why family G is the largest family in the plan, restated because it decides
this round's shape.** `AP-M04` §3's closing paragraph: *"At M04 the stimulus
space is the source stream plus its timing, and the timing half has no contract
at all beyond the handshake: a source may present a word on any cycle, or not
present one. **That is not a gap in the specification — it is REQ-206.**"* Every
round before this one drove the timing half at exactly one point: always
present. This round drives the other point for the first time, and eight rows
across three families become reachable at once because they all wait on the same
thing.

**The shape of this round is `WO-0082`'s and not `WO-0081`'s.** It is a
**capability round**: one new runner, one new instrument, one new derived law,
and the rows that law makes reachable.

---

## 1. Why this slice — what rides, what is held back, the capability axis

### 1.1 The claim this round makes, in one sentence

**A source word required and not presented ends the frame exactly as SPEC-M04 §9
says it does — one strobe cycle on the cycle the word was required, the
already-accepted words on the wire and nothing else, one `/E/` `/T/` word two
cycles later with no FCS and no padding, and a gap of fifteen octets measured
from the terminate character in lane 1 — and nothing about the frame that
follows an abort, or about the frame the source resumes into, differs from a
frame that follows a clean one.**

### 1.2 The scope rule, unchanged from `WO-0080`/`WO-0081`/`WO-0082` and restated because it is what excludes everything below

**A row rides only if every capability its Stimulus cell needs is landed or is
built by this packet, and only if its Observable is assertable at the ports.**
A row whose stimulus needs a capability this round does not build does not ride,
and it does not ride "partially": **a row is discharged whole or not at all.**
This round builds exactly one capability — **the source-side stall schedule and
its derived oracle** — and rides exactly the rows that capability reaches.

### 1.3 What rides, and what each row adds over everything landed

| Row | What it adds over everything landed |
|---|---|
| **`M04-G5`** | The **first underflow this programme has ever driven**, at the earliest cycle the condition can hold (`C + 1`). Its content claim is REQ-207's: source word 0 was accepted, so its eight octets are on the wire — a design that discards them produces a frame with a preamble, no octets and an `/E/`, **well formed by §9's shape and wrong by REQ-207** |
| **`M04-G1`** | §9's row driven whole at a mid-frame withholding of a maximum-length frame: the pin, the two-cycle separation, the truncated octet count, **no FCS**, and the gap served from the `/E/` `/T/` word. Also the first `Resume` run — the tail-frame of §4.3, which the contents list never named |
| **`M04-G2`** | The **separation**, asserted as two named cycles rather than as two facts. Its Kills cell is the reason: a design pulsing the strobe when the wire consequence appears is two cycles late, still one pulse, still one `/E/` word, **and inside §0.6's window** (§4.2 item 6 derives that, and it is the concrete demonstration of why obligation 5's prohibition is a strengthening and not a weakening) |
| **`M04-G3`** | Four consecutive withheld cycles producing **exactly one** pulse. A design pulsing once per missing cycle is invisible to a single-cycle stall, and the impossible case (two underflows on one frame) is not driven — this row drives the stimulus that *looks* like it should produce two |
| **`M04-G6`** | REQ-206's *"and that the next frame transmits correctly"*. A design whose CRC register is not re-seeded after an abort produces a second frame with the right length, the right pad and the right terminate lane, and **only the REQ-305 oracle comparison speaks** |
| **`M04-G8`** | Obligation 3's conservation rule at the one class of frame this module can lose, **and the concrete demonstration of why the rule is keyed on the first accepted word**: under `Resume` the withheld frame's `tlast` word *is* accepted, and it closes the **tail**-frame, not the aborted one (§4.3, trap **T24**). A monitor keyed on `tlast` counts one where two frames reached the wire |
| **`M04-F6`** | The gap after an abort — `t = 1`, `g = 2`, **15** octets. The wrong design is **one octet** from conformant (measuring from the `/E/` at lane 0 rather than from the `/T/` at lane 1) and **passes every `≥ cfg_ifg` check**, so the observable is the exact placement and never the minimum |
| **`M04-A4`** | The preamble word after three different predecessors — `clear`, a normal frame, and an **underflowed** frame — compared byte for byte and control bit for control bit. A design whose preamble content or control marking is a function of how the previous frame ended is the state-bit reuse an all-clean-frames bench never reaches, **and this round is the first in which the third predecessor exists at all** |

### 1.4 What does NOT ride, why, and where it goes

**The split is by capability axis, and it is `WO-0082` §1.4's, one stage on.**
`WO-0082` named three axes and built the first; this round builds the second.

| Held back | Capability it needs | Why it cannot ride here |
|---|---|---|
| **`M04-G4`** — the highest-value row in the family: the faithful implementation of REQ-206 read to its first full stop, driving **nothing** at `C + 8` | **Nothing new.** It is reachable today | And it is held back **deliberately and for one round only**, because it is the row whose stimulus is *the absence of this round's stimulus* at a cycle this round never withholds at — §4.4's `word ≥ 1` rule excludes `word = 0` and `M04-G4` withholds at the post-`tlast` cycle, which is neither a word index nor a schedule entry. **It needs a different primitive — a source that stops after `tlast` and offers nothing — which `WO-0082`'s `run_stream` already provides at a single-frame run, and `M04-G9` measured it.** Filing it here would give this round a row whose machinery is last round's and whose family is this one's, and I would rather carry it as an explicit debt (§19.2) than blur the axis |
| **`M04-G7`** | — | **NO-ASSERT and already dispositioned.** §0.6's window is not asserted on `error_underflow` anywhere in this round; §6.0(e) states the form the prohibition takes here, which is **not** the form `WO-0082` §6.0(e) took, because that round expected zero events and this one expects some |
| **`M04-F3`** (`cfg_ifg ∈ {12, 13, 16, 20, 255}`) | A **`cfg_ifg` parameterisation** of `Bench.create` and of the standing decoder's own `~ifg` | The landed layer hard-wires `cfg_ifg = 12` and `cfg_tx_enable = 1` through every run, deliberately. Building it here is `BM5` |
| **`M04-F4`** (every gap in a 10 000-frame run is exactly 16) | Family **I**'s sustained run | The row's own Stimulus cell says so. ~110 000 driven cycles, **157× this round's entire ceiling** |
| **`M04-H1` … `M04-H6`** | A **handover-release scheduler** — `AP-M04` §7 `T-7`'s still-missing half | `M04-H4`'s *"whether that word was accepted at C+8 or at C+11"* needs the alternative release, which no round has built. A capability lands with its first consumer and this round is not it (`BM5`) |
| **`M04-I1` … `M04-I4`, `M04-L1` … `M04-L5`, `M04-K*`, `M04-J*`, `M04-M*`** | Family I's sustained run; a `Clear`/`Enable` schedule; the configuration axis; a latency reading; a differential `tstrb`/`tuser` stimulus | Their own rounds. **This round drives past `M04-L3`'s co-occurrence and past family H's cycles and claims neither** (§9.8, `BM8`, trap **T25**) |

**So the stage plan, updated:**

- **Stage 1 — `WO-0082`, ACCEPTED, landed `65ba148`.** The multi-frame
  continuous presenter; `M04-A3`, `B3`, `F1`, `F2`, `F5`, `G10`.
- **Stage 2 — this packet.** The stall schedule and the abort law; `M04-G1`,
  `G2`, `G3`, `G5`, `G6`, `G8`, `A4`, `F6`. **Eight rows, 51 → 43 outstanding on
  absorption.**
- **Stage 3 — the configuration axis** (`M04-F3` with families K/L), **family
  I's sustained run** (`M04-F4`, `I1` … `I4`), and **family H's release
  scheduler** (`H1` … `H6`). Order between them is not fixed here. **`M04-G4` is
  a debt of mine, not a stage** (§19.2 item 1) — it needs nothing built.

**Family G therefore does NOT complete this round, and this packet does not
describe it as completing.** G1, G2, G3, G5, G6, G8 ride; G4 is held back with
its ground; G7 is NO-ASSERT and stands; G9 and G10 are discharged. **Family F
does not complete either** — F3 and F4 remain. **Family A completes at A4 if its
verdict holds**, and that is a claim I will check at the `RV-` by a status-cell
pass, not one this packet may make in advance (§9.1).

> **THE NAMING RULE, at the site that produces the sentence.** The table above
> and the stage plan under it are exactly the kind of passage that makes a
> worker write a row id into a source file in order to disclaim it. **The rule,
> once, and the four restatements below are quotations of it**: *in the packet,
> name the row; in `test/**`, describe it — a disclaimer that names a row
> discharges it in a coverage map built by hand from titles.* A comment, title
> or string in a source file refers to a row this round does not carry **by
> description only** (*"the neighbouring family-G row that drives nothing at
> that cycle"*), because the `SO-` coverage map is built by hand from those
> titles and **no script in this tree would catch it** (§9.7). **And the
> drafting instrument that catches it**: sweep your own files for
> `M04-<letter><digits>` before finalising. Bar **M-7** measures the landed
> tree; this note is what stops the defect being drafted.

### 1.5 Size — the one number that decided the shape

**638 driven cycles across 6 elaborations** (§10), against a measured size class
of 105 010 cycles in a single run — **0.61%**. The count that decided the row set
was not cycles but **capability axes**: this round builds one, and every row it
rides is a row that axis reaches. The two rows from *other* families that ride
(`M04-A4`, `M04-F6`) ride because their predecessor must be an underflowed frame,
which is the whole reason `WO-0082` §1.4 filed them here rather than with their
own families.

---

## 2. The eight rows

**Read each row in `AP-xgmii_tx_64.md` itself.** This table is an index with the
unit assignment; the plan's **Observable cell is the contract** and where this
packet and the plan disagree, **report it** (`BM3`, class **D5**).

| Row | Family | Status | Unit | One-line subject |
|---|---|---|---|---|
| **`M04-G5`** | G | ASSERT | **U22** | Withhold at `C + 1`, the earliest cycle the condition can hold: strobe there, `/E/` `/T/` at `C + 3`, and source word 0's eight octets on the wire at `C + 2` |
| **`M04-G1`** | G | ASSERT | **U23** | `P = 1514`, withhold mid-frame and resume: one pulse at the pin, the accepted words transmitted, the `/E/` `/T/` word, **no FCS**, the gap served from it |
| **`M04-G2`** | G | ASSERT | **U23** | The strobe and the `/E/` word are **exactly two cycles apart**, each asserted at its own named cycle |
| **`M04-G8`** | G | ASSERT | **U23** | The aborted frame is counted **once** on the wire, and the run's only `tlast` acceptance closes the **tail**-frame, at a cycle later than the aborted frame's terminate cycle |
| **`M04-G3`** | G | ASSERT | **U24** | Four consecutive withheld cycles: **exactly one** pulse, at the first of them; exactly one `/E/` word; nothing at the other three |
| **`M04-G6`** | G | ASSERT | **U25** | An underflowed frame followed by a `P = 20` frame: full preamble, 40 pad octets, FCS equal to the REQ-305 oracle over its **own** padded 60, terminate at lane 0 |
| **`M04-F6`** | F | ASSERT | **U26** | The gap after an abort: **15** octets from the `/T/` in lane 1, next start character in lane 0 |
| **`M04-A4`** | A | ASSERT | **U27** | Three frames — after `clear`, after a normal frame, after an **underflowed** frame — carrying the identical preamble word, byte for byte and control bit for control bit |

**Eight rows, all ASSERT** — counted against the plan's Status column at
`22c60fb`, row by row, not summarised.

---

## 3. The frozen references, by SHA — re-pinned at this head

**Every reference this round derives from is pinned at `22c60fb`, and the pin is
an act rather than an inheritance** (`FINDING K-3`'s rule applied to references
as well as to bars).

| Reference | Pin | What this round takes from it |
|---|---|---|
| `docs/specs/modules/xgmii_tx_64.md` | FROZEN `f78766e`; **current content at this head** | §4's entire derivation. **§9 and §6.2's `Abort` row are the two passages this round exists to drive** |
| `docs/specs/requirements.md` | current content at this head | §0.3's gap convention; §0.6's counting convention, window and **fourth reference-word clause**; REQ-206, REQ-207, REQ-204, REQ-201, REQ-008 |
| `test/attack_plans/AP-xgmii_tx_64.md` | `22c60fb`, **read-only and frozen for this round** | The eight rows; §2's seven obligations; §3's stimulus legality; §7's `T-3` |
| `test/xgmii_tx_64/bench.mli` | this head, **16 exported values** | §5.1's capability table, established by reading the file |
| `test/xgmii/tx_decoder.mli` + `test/xgmii/test_tx_decoder.ml` | this head | §5.1's decoder row **and §15's class-D2 posture**, both measured by reading the committed unit suite rather than inferred |
| `test/monitors/strobe_monitor.mli` | this head | The `event` record `Strobe_monitor.expect` takes — §5.3(4)'s whole subject |
| `test/xgmii/frame.mli` | this head | `fcs`, `with_fcs`, `pad_to_60` — the REQ-305 oracle path |

### 3.1 The one thing that is NOT re-pinned, and why that is not an omission

**`WO-0082`'s §12 base figures are not carried.** Every tree-quantified bar in
§12 below was **re-measured at `22c60fb`**, and five of them moved when stage 1
landed: `M-3` 156 → **161**, `M-4` 10 → **11** tracked files, `M-7` 25 → **31**
distinct ids, `M-10`'s per-file counts, `M-19` 13 → **16** exported values.
**A bar carried across a landing is a bar that fails on the first round after
it, silently, because its failure looks like a defect in the work** — that is
`FINDING K-3` and it is why §12's base column is a measurement and not a copy.

---

## 4. The abort law — `AP-M04` §7 `T-3`'s second half, derived here

**This section is the oracle.** `AP-M04` §7 `T-3`(ii) records that *nothing
derives, from a stall schedule, the expected strobe cycle, the `/E/` word's
cycle and the truncated octet count*, and records the plan's own disposition:
*family G hand-derives all three from §9 and §6.1*. **This is that hand
derivation, done once for every row, with every step cited to the specification's
own text.**

> **A design decision, stated with the alternative I rejected.** The oracle could
> have been built as a **module** in `test/**` — a function from a schedule to
> an expected outcome. I chose the derivation-in-the-packet form for the reason
> §6.0's standing rule gives: *a unit that recomputes its own expectation from
> the same helper the runner uses cannot fail when the helper is wrong.* A
> computed oracle sharing arithmetic with the runner is one expression away from
> a bench that agrees with itself; a hand derivation stated in the packet and
> transcribed into a unit as a constant fails visibly when either is wrong.
> **The cost is that a later round re-reads this section rather than calling a
> function, and §4.2's law is written to be quotable for exactly that reason.**

### 4.1 The identity this round inherits, quoted in force

`AP-M04` §4, unchanged and still governing:

> **frame octet `i` is at lane `i mod 8` of the word at cycle `C + 2 + ⌊i/8⌋`**,
> where `C` is the cycle the frame's first source word is accepted;
> **the terminate character is at octet index `F`, hence lane `F mod 8`, at
> cycle `C + 2 + ⌊F/8⌋`**; and with the terminate character in lane `t`, the
> next start character is **`g = ⌈(cfg_ifg + t)/8⌉`** words later, an actual gap
> of **`8g − t`** octets.

**`WO-0082` §4.2's extension is also inherited and it is the form this round
uses**: for a frame after the first, the anchor is **the start character**, not
`C`. Writing the identity that way once, because every derivation below is
stated in it:

> With `S` the cycle of a frame's start character (its preamble word): **its
> source word `m` is transmitted at cycle `S + 1 + m`**; **frame octet `i` is at
> lane `i mod 8` of the word at cycle `S + 1 + ⌊i/8⌋`**; **the terminate
> character is at cycle `S + 1 + ⌊F/8⌋`, lane `F mod 8`**; and the next start
> character is at `T + g`.

Checked against §6.1's own cycle-by-cycle table at `P = 60`, where `S = C + 1`:
octets 0–7 at `C + 2` ✓, octets 56–59 with the FCS at `C + 9` = `S + 8` ✓,
terminate at `C + 10` = `S + 9` = `S + 1 + 8` ✓, next start at `C + 12` ✓.
**The table and the start-anchored form agree at the one length the table
states**, which is the whole of the cross-check available from the
specification and is stated rather than assumed.

### 4.2 The abort law, derived — eight facts, each cited

Let the withheld frame be contents element `j`, with `P_j` octets presented as
`W_j = ⌈P_j / 8⌉` source words, its start character at `S_j`, and let **`w`** be
the index of the withheld word within it.

**Fact 1 — the required cycle `R`.** Source word `m` is transmitted at
`S_j + 1 + m` (§4.1), and §6.1's storage paragraph fixes the transmit delay at
two cycles — *"a source word accepted on cycle C + m is transmitted on cycle
C + m + 2"*. **So word `m` is required at `R = S_j + m − 1`.** Checked at the
first frame of a run, where `S_j = C + 1`: `R = C + m`, which is the acceptance
cadence §6.1's table shows and which `M04-G5`'s own row states (*"the word
required at cycle `C + 1`"* for `m = 1`).

**Fact 2 — the strobe.** SPEC-M04 §9, *Strobe cycle, pinned*: `error_underflow`
pulses **for exactly one cycle**, on **`R`** — *"the cycle the word was required
and not presented — the earliest cycle the condition is decidable"*. **The
expected strobe-event set of a run with one stall is exactly `{R}` and
`high_cycles "error_underflow"` is exactly 1.**

**Fact 3 — the `/E/` `/T/` word.** §9: *"The wire consequence follows two cycles
later, when the missing word's transmit slot arrives; a bench must not expect the
strobe and the `/E/` on the same cycle."* **The abort word is at
`A = R + 2 = S_j + 1 + w`** — which is, by §4.1, exactly the transmit slot the
missing word would have filled, so the two derivations agree. Its shape is §9's
and §6.2's `Abort` row's: **`/E/` (0xFE) in lane 0, `/T/` (0xFD) in lane 1,
`/I/` (0x07) in lanes 2–7, `xgmii_txc` = 0xFF.**

**Fact 4 — the truncated octet count, and there is NO PADDING.** §9: *"the words
already accepted are transmitted (REQ-207 forbids dropping them)"*. The accepted
words are `0 … w − 1`. **Every one of them is a full eight-octet word**: the only
short word a legal source presents is the `tlast` word, which is word `W_j − 1`,
and §4.4's legality rule gives `w ≤ W_j − 1`, so every accepted word has index
`< W_j − 1`. **The aborted frame therefore carries exactly `8w` octets on the
wire**, at cycles `S_j + 1 … S_j + w`.
**And it is padded to nothing and carries no FCS.** §6.2's state table takes
`Frame → Abort` **directly**; `Pad` is entered only *"if `tlast` arrived below 60
octets"* and `Fcs` only *"if the count has reached 60 at `tlast`"*, and an
aborted frame reaches neither. §9 says the same from the other side — *"no FCS is
appended"* — and says why: *"Appending a valid FCS to a truncated frame would put
a **well-formed short frame** on the wire, which the link partner would accept as
a real frame with a real (wrong) length."* **`8w` may be far below 60 and that is
conformant** — trap **T21**.

**Fact 5 — the terminate lane, and the gap.** The terminate character is the
`/T/`, **at lane 1**, and REQ-204 counts the gap *from the terminate character
inclusive* (§6.1, §0.3). So **`t = 1`**, `g = ⌈(12 + 1)/8⌉ = ⌈13/8⌉ = **2**`
words, and the actual gap is **`8g − t = 16 − 1 = 15`** octets. **The `/E/` in
lane 0 is not part of the gap and is not the terminate character** — that is
`M04-F6`'s one-octet hazard, stated in the plan's own Kills cell, and it is the
whole content of that row.

**Fact 6 — the §0.6 window, and why `M04-G2` is the row that makes the case for
obligation 5.** §0.6's fourth reference-word clause gives this strobe its
reference word — *the cycle on which the word was required and not presented*,
i.e. `R` — with a ceiling of §0.5's **word delay ΔC = 2** and never REQ-210's
event delay. §0.6's floor is *not earlier than the cycle the condition first
becomes decidable*, which is `R` too. **So the window is `[R, R + 2]`, the pin is
`R`, and floor, reference word and pin are one event.** Now read fact 3 against
it: **`R + 2` is the `/E/` word's own cycle.** A design pulsing the strobe when
the wire consequence appears — `M04-G2`'s Kills cell exactly — pulses at `R + 2`,
which is **inside** §0.6's window and **off** §9's pin. **A bench asserting the
window rather than the pin passes the design `M04-G2` exists to kill.** That is
obligation 5's *"a bound, never a licence"* note made concrete, and it is why the
window is **supplied** to the monitor (§5.3(4) — the record demands one and the
monitor checks the pin against it, which is a check on the **specification**) and
**never asserted as the design's assurance**.

**Fact 7 — the next start character.** §6.2: `Abort → Gap`, `Gap → Idle` *"when
the gap is satisfied"*, and `Idle → Preamble` *"on the cycle a first source word
is accepted"*. §7's C-14.1 bullet pins `tx_tready` = **1 on the last cycle of the
gap**, which by fact 5 is cycle **`A + g − 1` = `A + 1`**, and §7's handshake
bullet holds the source's word stable until acceptance. **Two branches, both
derived:**

- **(a)** If the source offers a word at or before `A + 1`, it is accepted no
  later than `A + 1`, and **the next start character is at `A + 2 = S_j + w + 3`**
  — REQ-204's rounded gap fixes it, not M04's depth (§7's C-16 consequence 3
  states the principle in terms: *"back to back it is REQ-204's rounded gap, and
  not M04's depth, that fixes the start character"*).
- **(b)** If the first offer after the abort is at a cycle `X > A + 1`, M04 is in
  `Idle` (the gap having been served) with `tx_tready` = `cfg_tx_enable` = 1
  (§6.2's `Idle` row), so the word is accepted at `X` and **the next start
  character is at `X + 1`** (§4.1's identity for a frame issued into an idle
  transmitter with the gap already served).

**Fact 8 — what is NOT fixed, and no bench may assert it.** The acceptance cycle
of any word offered in the closed interval `[R, A + 1)` — that is, at `R`,
`R + 1` or `A` — is **unconstrained**. §6.3 item 3 leaves `tx_tready` free *"on
cycles when no frame is in progress"*, §6.2 says **only `Idle` accepts a first
source word** (and an aborted frame never reaches the post-`tlast` early-
acceptance cycle C-16 carves out), and §7's C-14.1 constrains nothing before the
gap's last cycle. **A runner-level or row-level assertion about when a word
offered in that interval is accepted fails a conformant design.** Fact 7's start
character is available because it is pinned by REQ-204's rounding; the
acceptance cycle behind it is not. This is `ST-4`'s second exclusion (§5.3(5))
and trap **T22**.

### 4.3 The tail-frame law — the frame nobody put in the contents list

**Under `Resume` the source presents the withheld word again. SPEC-M04 §7's
handshake bullet says *"`tx_tlast` ends the frame — M04 needs no declared
length"*, so the specification gives M04 no way to know that a word presented
after an abort is the dead frame's tail rather than a new frame's head.** It is a
new frame, and it is well formed:

- **its content is the SUFFIX of the contents element**, octets `8w … P_j − 1` —
  **`P' = P_j − 8w` octets**;
- **its word list is words `w … W_j − 1` of the original**, all full but the
  last, `tlast` on the last: **a legal frame by SPEC-M01 §6.1, with no
  construction of its own**;
- `F' = max(P', 60) + 4`; **padded to 60 if `P' < 60`**, the pad covered by the
  FCS (REQ-203); **its FCS is the REQ-305 oracle over its own padded content**;
- its start character `S'` is fact 7's, branch (a) or (b) according to the hold;
- its terminate character is at `S' + 1 + ⌊F'/8⌋`, lane `F' mod 8` (§4.1);
- its own gap follows §4.1's rule at its own `t`.

**Two consequences every row that resumes must carry:**

1. **The expected decoded-frame count is NOT `List.length contents`.** A run of
   `n` elements with one **resumed** stall decodes **`n + 1`** frames; with one
   **abandoned** stall it decodes `n`. §5.3(6)'s instrument takes the count as a
   parameter for exactly this reason.
2. **The tail's content is derived, never chosen.** It is a **suffix of the
   contents element**, and `content_octets ~p:P'` is **NOT** that suffix:
   `content_octets` gives octet `j` = `1 + (j mod 127)`, so a suffix beginning at
   octet `8w` starts at `1 + (8w mod 127)` and restarts the period only when
   `8w ≡ 0 (mod 127)`. **At both members this round drives it is non-zero**
   — `760 mod 127 = 125` and `1480 mod 127 = 83` — so the trap is live and not
   theoretical. Trap **T23**.

**And the conservation consequence, which is `M04-G8`'s content.** Under
`Resume` the **withheld frame's own `tlast` word IS eventually accepted** — as
the tail-frame's last word. It does not close the aborted frame; it closes the
tail. **A conservation rule keyed on `tlast` acceptance therefore attributes the
run's single `tlast` acceptance to the wrong frame and counts one where two
frames reached the wire** — which is precisely what obligation 3 warns about in
the abstract, made concrete by a stimulus. Trap **T24**.

### 4.4 The schedule's legality rules — two inherited, one derived here

**`WO-0082` §20.4 fixed the schedule's content and two legality rules. Both are
inherited unchanged and are restated with their grounds:**

- **`word ≥ 1`.** REQ-206's condition opens *after the start character has been
  emitted*; withholding word **0** withholds a frame that has not begun, which is
  a late frame and not an underflow. `word = 1` is the **earliest** withholding
  that can strobe, and that is `M04-G5`'s row.
- **No withheld cycle at a between-frames handover.** §7's C-16 consequence 1 —
  *"this is the one cycle in a frame's life where `tx_tready` = 1 with
  `tx_tvalid` = 0 means nothing at all"*. A schedule that places a withholding
  there produces no underflow and is a stimulus mislabelled as one. **The
  schedule of this round cannot express one**, because it withholds a **word of a
  frame** and never a **cycle**, which is the design decision §5.3(2) records.

**And one rule derived here, which `WO-0082` §20.4 could not have stated because
it belongs to a frame after the first:**

- **`word ≤ W_j − 1`**, and **for a frame that is not the run's first,
  `word ≥ 2`.** The upper bound is REQ-206's closing clause — the condition holds
  *before the frame's `tlast` word has been accepted*, and the `tlast` word is
  word `W_j − 1`, so withholding **it** is an underflow (the acceptance that
  would close the window never happens) while withholding anything beyond it is
  not a word of the frame at all. **The lower bound at a back-to-back frame is
  §7's C-16 consequences 2 and 4**: a continuous source's next frame has **word 0
  accepted at the predecessor's post-`tlast` cycle** and **word 1 accepted at the
  gap's last cycle**, both *before* its own start character is emitted, and
  `tx_tready` is **0** on its preamble cycle (consequence 4). **Words 0 and 1 of a
  back-to-back frame are therefore never "required" in REQ-206's sense**, and a
  schedule withholding one of them withholds a word the transmitter is not asking
  for. **Both bounds are checked by the runner and their violation is a
  `failwith` naming the rule, not a silent no-op** (§5.3(2)).

  **Both halves of the lower bound are CI-proven, not merely read**: `M04-G10`
  measured the `C + 8` acceptance and the `C + 11` second-word acceptance at four
  members and is green at `65ba148`. **A legality rule resting on a measured
  fact is stated as resting on one.**

### 4.5 The OCaml-notation gloss — READ THIS BEFORE YOU TRANSLITERATE ANYTHING

Every formula above is arithmetic notation, not OCaml. The transliterations this
round needs:

| Written | In OCaml, with `open! Base` |
|---|---|
| `⌈P/8⌉` | `(p + 7) / 8` — **there is no ceiling operator**; `Int.( / )` truncates |
| `⌊F/8⌋` | `f / 8` |
| `F mod 8` | `Int.rem f 8` — **`mod` under `open! Base` is not the stdlib's and this spelling bounced a previous round of this chain** (§16.3 item 1) |
| `g = ⌈(12 + t)/8⌉` | `(12 + t + 7) / 8` |
| `8g − t` | `(8 * g) - t` |
| `max(P, 60)` | `Int.max p 60` |
| `P' = P_j − 8w` | `p_j - (8 * w)` |
| the tail's content | **a suffix of the element's own octet list** (`List.drop`-shaped), never `content_octets ~p:P'` — §4.3 consequence 2, trap **T23** |

---

## 5. The capability layer — what is landed, the extension, and what it deliberately does not build

### 5.1 What is landed and CI-proven — measured at `22c60fb`, not assumed

**Every claim in this table was established by reading the committed file
named, at this tree** (`AP-M04` §0.1(iii)'s polarity rule).

| What | Where | State | You use it for |
|---|---|---|---|
| The M04 bench layer | `test/xgmii_tx_64/bench.mli` (**16** exported values) + `bench.ml` | **EXISTS, CI-green on 21 units at `65ba148`.** The 13 of `WO-0080`/`WO-0081` plus `run_stream`, `wire_frames`, `assert_instruments_clean_n` | Everything. **Read `bench.mli` in full first** |
| The multi-frame continuous presenter | `bench.ml`'s internal `drive` + `present_stream`, reached by `run_stream` | **EXISTS.** One elaboration for a run of frames, offering each next frame's word 0 on the cycle after the previous frame's last acceptance | **The loop this round's runner shares.** §5.3(2) adds a withholding predicate to it and **copies nothing** |
| The wire decoder | `test/xgmii/tx_decoder.mli` | **EXISTS and ALREADY DECODES AN ABORTED FRAME.** Measured, not inferred: its own unit suite `test/xgmii/test_tx_decoder.ml` carries a unit *"SPEC-M04 §9: the underflow word is /E/ in lane 0 then /T/ in lane 1"* which asserts, on a hand-built trace, **1 frame decoded, `octets` length 16 (two accepted words, no FCS, no pad), `terminate_lane` = 1, `underflowed` = true, 0 violations**, and separately that an error character in lane 2 **is** a REQ-206 violation | Every row here. **See §15 for the one path of it this round runs first** |
| The strobe monitor | `test/monitors/strobe_monitor.mli` | **EXISTS**, with `expect` taking an `event` record — `strobe`, `frame`, `cycle`, `not_before`, `not_after`, `why`. Its `is_clean` requires every expected event to have pulsed **exactly once** and every high cycle to be claimed | **This round's expected pulses.** §5.3(4) |
| The FCS oracle | `test/golden/crc32_ref.mli` via `test/xgmii/frame.mli`'s `fcs` / `with_fcs` | **EXISTS**, anchored on REQ-303's published `0xCBF43926`. The one external-anchor obligation at M04 discharged today | `M04-G6`'s and the tail-frames' content assertions |
| `Frame.pad_to_60` | `test/xgmii/frame.mli` | **EXISTS** — REQ-203's own arithmetic. **It does not append an FCS** (trap **T9**) | `M04-G6`'s 40 pad octets; U24's padded tail |
| **A source-side stall schedule** | — | **DOES NOT EXIST.** Read off the committed producer: `bench.mli`'s module docstring states *"The presenter never withholds a word mid-frame"* and `assert_instruments_clean_n` fails any run with a non-zero strobe count or an underflowed frame. **This is what you build** — §5.3 | Every row in §2 |
| **An instrument that tolerates a conformant abort** | — | **DOES NOT EXIST, and the absence is two of four checks rather than a missing function.** `assert_instruments_clean_n` demands `high_cycles "error_underflow" = 0` **and** *"NONE of them underflowed"*; a conformant abort produces exactly one strobe cycle and exactly one frame with `underflowed = true`. **You build the generalisation** — §5.3(6) | Every row in §2 |
| A `cfg_ifg` / `cfg_tx_enable` parameterisation | — | **NOT BUILT AND NOT COMMISSIONED.** `create` drives `cfg_ifg = 12` and `cfg_tx_enable = 1` through every run and this round changes neither (`BM5`) | — |
| A handover-release scheduler | — | **NOT BUILT AND NOT COMMISSIONED.** `AP-M04` §7 `T-7`'s still-missing half; its first consumers are family H's rows (`BM5`) | — |
| A per-octet latency tagger | `test/monitors/octet_time.mli` | **NOT APPLICABLE AS BUILT** (`AP-M04` §7 `T-4`). **Do not instantiate it** (`BM9`) | — |

### 5.2 What you may NOT change in the landed layer

- **The 16 existing values of `bench.mli` keep their signatures byte for byte.**
  You add; you do not alter. Bar **M-19**.
- **`sample_cycle`'s body is not touched at all.** Its eight-step ordering is
  CI-proven and the `Before`-view acceptance decision is what every constant in
  §6 is stated against (trap **T1**, `BM2`).
- **`run_lengths`, `run_frames`, `run_stream`, `present`, `present_stream`,
  `cycles_for` and `wire_frame` keep their observable behaviour exactly.**
  `P-ACCEPT` still fires for a single-frame run; `SP-1`/`SP-2` still fire for an
  unscheduled stream; the liveness bound is unchanged; `cycles_for`'s value is
  unchanged at every `p`; `wire_frame`'s two failure messages stay byte for
  byte. Bar **M-6b**, `BM19`.

  > **What "observable behaviour unchanged" means, inherited from `WO-0082`
  > §5.2 and applied to THIS round's one re-expression.** **It means the firing
  > conditions and their order, not the message text.** §5.3(6) orders
  > `assert_instruments_clean_n` to be re-expressed over a generalisation that
  > takes expected sets as parameters, and that necessarily moves the wording of
  > the two messages which currently say *"none of them underflowed"* and name a
  > fixed frame count. **The messages permitted to move are named here and
  > nowhere else**: `assert_instruments_clean_n`'s frame-count message and its
  > underflowed-frame message, at every `n`, **and nothing else**. The test of
  > the rule is: **at every input class of the wrapper — 0 frames, `n` clean
  > frames, a frame that underflowed, a non-zero strobe count, a decoder
  > violation — the same predicate fires, in the same order, to the same
  > outcome.** Where this packet wants a message byte-identical it says so
  > separately, as this bullet does for `wire_frame`.
- **The five landed `test_m04_{scaffold,b,c,d,e}.ml` files are not modified**,
  and **the three you append to lose no byte.** They are this round's
  **regression witness**: §5.3 re-expresses one landed function with 21 landed
  consumers, and those 21 units are what prove the re-expression changed
  nothing. Bars **M-5b**, **M-5c**, BOUNCE `BM14`.

### 5.3 The extension — one schedule type, one runner, two instruments, and the design is fixed here

**You implement this design. You do not choose it.** If any part of it cannot be
written as specified, **stop and report** — that is class **D5** and a finding I
want (`BM3`).

**(1) `Stall` — the schedule, whose content `WO-0082` §20.4 fixed.**

```
module Stall : sig
  type after =
    | Resume     (* the source presents the withheld word again *)
    | Abandon    (* the frame's remaining words are dropped *)

  type t =
    { frame : int   (* index into the contents list *)
    ; word  : int   (* index of the withheld word within that frame *)
    ; hold  : int   (* consecutive cycles it is withheld, >= 1 *)
    ; after : after
    }
end
```

**One stall per run, not a list.** A capability lands with its first consumer
and no row in §2 needs two; `M04-G3`'s four consecutive withheld cycles are
`hold = 4`, which is one stall (`BM5`).

**(2) `run_scheduled` — the third runner.**

```
val run_scheduled : int list list -> Stall.t -> int list list * t * sample list
```

**Stage 2 adds a third runner; it does not generalise the second.** The landed
`run_stream` and its `SP` set are the regression witness for stage 1's six rows,
and evidence you edited is not evidence. The **loop** is shared, never copied
(`M-8`'s rule): the internal `drive` gains a **withholding predicate** over the
presenter's own cursor, defaulting to *never withhold*, and the three
postcondition sets sit above it.

| Regime | Runner | Postconditions |
|---|---|---|
| single frame | `present` (landed) | `P-ACCEPT` — **unchanged, untouched** |
| unscheduled stream | `present_stream` (landed) | `SP-1`, `SP-2`, `SP-3` — **unchanged, untouched** |
| **scheduled stream** | **`present_scheduled`, new** | **`ST-1` … `ST-4`** |

Its body, in order:

1. **Obligation 6's contract check runs PER FRAME, on that frame's own word
   list, BEFORE anything is concatenated** — unchanged from `run_stream`, and
   trap **T5** is unchanged with it. **The check runs over the FULL word list of
   every element, including the words a schedule will later drop**: a contents
   element is a legal frame and is checked as one; the schedule truncates the
   **offer**, not the frame. Trap **T20**.
2. **Check the schedule against §4.4's three legality rules**, `failwith`ing and
   **naming the rule** on each: `0 ≤ frame < List.length contents`;
   `1 ≤ word ≤ W_frame − 1`; and `word ≥ 2` when `frame > 0`. `hold ≥ 1`.
   **This check runs before a single cycle is driven** — an illegal schedule is
   a defect in the stimulus, and a stimulus generator nobody has checked is an
   unverified assertion about the design.
3. Build the per-frame word lists (one `source_words` call per frame, results
   kept **separate**), run step 1's check over each with its frame index, **then**
   flatten them into one list in order. *(Named as a shape and not as a library
   function: step 1 forecloses any call that concatenates as it maps. `WO-0082`
   §5.3(1)'s correction, carried.)*
4. Elaborate one `t` via `create ()`.
5. Drive through **the shared loop** for `cycles_for_scheduled_run contents
   stall` cycles (§5.3(3)), with the withholding predicate of (2') below.
6. Enforce **`ST-1` … `ST-4`** of (5).

**(2') The withholding predicate is over the CURSOR, never over a cycle — and
this is the design decision that makes the schedule design-independent.** The
presenter advances its cursor only on acceptance. When the cursor reaches
`(frame, word)` and the stall has not yet been served, the presenter **drives
idle for `hold` cycles**, then:

- **`Resume`** — offers that same word again and continues normally;
- **`Abandon`** — advances the cursor past every remaining word of that frame and
  continues with the next element (or, if none, offers idle for the rest of the
  run).

**Why the cursor and not a cycle.** The cycle at which a word is required is a
function of the design's own acceptances; a schedule expressed in cycles would be
a claim about the design smuggled into the stimulus, and it would silently
mis-target on any frame after the first (§4.4's `word ≥ 2` rule is the visible
edge of that). A cursor schedule targets the same **word** whatever the design
does, and §4.2's fact 1 is then a **derivation** the unit checks rather than an
assumption the bench made.

**The bench keeps its own INTENTION RECORD**: for every cycle, whether the
schedule intended a word to be offered. **`ST-2` compares that record against
`offered.tvalid`**, and it is that comparison, not a re-reading of the schedule,
that makes the check total.

**(3) `cycles_for_scheduled_run` — the allowance, derived here because
`WO-0082` §20.8 states in terms that it does not carry over.**

The landed `cycles_for_run contents = 27 + Σ_k (⌊F_k/8⌋ + 4)`, with the `4`
derived as `1 + g_max` at `cfg_ifg = 12`. **An aborted frame does not have that
shape**, so:

```
base                        =  27                              (* inherited, unchanged *)
normal frame k              =  frame_words ~p:P_k + 4          (* landed, unchanged *)
aborted frame (word w, hold h)
                            =  w + Int.max 3 h + 1
tail frame (Resume only)    =  frame_words ~p:(P_j - 8*w) + 4  (* a normal frame of P' *)

cycles_for_scheduled_run contents stall
                            =  27 + Σ over the DERIVED frame sequence
```

- **The base `27` is inherited unchanged and the ground is stated rather than
  assumed**: it covers reset release plus the liveness bound (`C ≤ 16`) plus
  margin, and nothing in the scheduled regime changes what it covers. `ST-1`'s
  bound is `SP-1`'s.
- **The aborted frame's `w + max(3, h) + 1` is derived from §4.2 fact 7**, not
  chosen. The true cadence from `S_j` to the next start character is
  `w + 3` under branch (a) (`h ≤ 3`) and `w + h` under branch (b) (`h ≥ 4`);
  `w + max(3, h)` covers both, and the `+ 1` gives the same one-cycle head room
  the normal allowance carries.
- **The derived frame sequence** is the contents list with the withheld element
  replaced by *(aborted frame)* under `Abandon`, or by *(aborted frame, tail
  frame)* under `Resume` (§4.3).
- **`frame_words` stays unexported and `⌊F/8⌋` stays in exactly one
  expression.** Bar **M-8**. Units take their expected values from §6's tables,
  never from this helper.
- **A round that changes `cfg_ifg` must re-derive all of it** — that round is
  stage 3 and this sentence is its warning.

**(4) `underflow_event` — the window rule in exactly one expression.**

```
val underflow_event
  :  frame:int
  -> cycle:int
  -> why:string
  -> Dv_monitors.Strobe_monitor.event
```

Builds the record `Strobe_monitor.expect` takes, filling **`strobe =
"error_underflow"`** (M04's one strobe, requirements.md §12's name),
**`not_before = cycle`** and **`not_after = cycle + 2`** — §0.6's window as §4.2
fact 6 derives it, floor at the reference word and ceiling at `ΔC = 2`. `frame`
and `cycle` and **`why` are the caller's**: `why` is *"the spec clause, quoted or
cited, that produced `cycle`"*, and the monitor's own docstring says *"a bench
that cannot fill it in has not derived the cycle from the specification"* — so
**every call site fills it with SPEC-M04 §9's own pin sentence and its own row's
`R`**.

**Why the window is supplied at all, when `AP-M04` obligation 5 forbids
asserting it.** The record demands one, and the monitor uses it for a check on
the **specification** — *"A pinned cycle outside §0.6's window is a defect in the
module spec"*. Supplying `[R, R + 2]` and asserting the **pin** is not asserting
the window: §4.2 fact 6 shows that a bench which asserted the window instead
would pass the very design `M04-G2` exists to kill. **No unit in this round
asserts that a pulse lies inside a window, and no unit computes a window
anywhere but through this one function** (bar **M-21**, `BM20`).

**(5) `ST-1` … `ST-4` — the third postcondition class, `WO-0082` §20.6's, with
its failure-message obligations.**

**Prefix `ST` and not `SP-4`, deliberately**: a distinct prefix means a failure
message can never be read as the other regime's, and a search for one regime's
checks cannot return the other's.

- **`ST-1` — liveness.** The first acceptance is at or before cycle 16, the same
  bound `SP-1` and `P-ACCEPT` share, failing with the same words: a
  **bench-liveness** bound and **not** a timing assertion about `C` (`M04-A5`).
- **`ST-2` — schedule fidelity, and it is a check on the BENCH.** For every cycle
  of the run, `offered.tvalid` equals the bench's own intention record (2'):
  false on every cycle the schedule declares withheld and on every cycle the
  source is exhausted, true otherwise. **Asserted from the bench's own drive
  record, never from the design's output**, and design-independent by
  construction. **This is `M04-G10`'s route precondition generalised from one row
  to every scheduled run**: without it, a driver that quietly failed to withhold
  turns a stall round into a non-stall round, and every silence and every strobe
  assertion downstream becomes a green statement about a stimulus that never
  happened. **Its failure message says, in those words, that everything
  downstream of it is void.**
- **`ST-3` — accountability, which is what `SP-2` was reaching for.** The number
  of accepted samples equals `Σ_k W_k − abandoned`, where **`abandoned` is the
  schedule's own declared count** — `W_frame − word` under `Abandon`, **0** under
  `Resume` — **fixed before the run and never inferred from the design's
  output**. **Why this is true against a conformant M04 where `SP-2` is false**:
  the only words a conformant design can never accept are precisely the ones the
  schedule declares abandoned; every other offered word is accepted, because
  §4.2 fact 7 pins `tx_tready` = 1 at the gap's last cycle and in `Idle`, and the
  source holds its word stable until acceptance. **What it catches** is what
  `SP-2` caught: a run one cycle too short, and a design that stalls where the
  specification says it must not. **Its failure message states counted, expected,
  the schedule's own abandoned count, and the void language.**
- **`ST-4` — nothing else, and the exclusions are derived rather than cautious.**
  - **No contiguity** — `tx_tready` is 0 on the FCS and terminate words
    (C-14.1), as at `SP-3`.
  - **No acceptance-cycle claim for any word offered at or after the withheld
    cycle** — §4.2 fact 8. Those cycles are unconstrained; a runner-level
    assertion over them fails a conformant design. The **start character** is
    available to a row that derives it (fact 7); the acceptance behind it is not.
  - **No claim about the strobe, the `/E/` word, the truncated octet count or
    the gap.** Those are the row's, from §4.2 and §6's tables.
  - **No claim about the decoded frame count.** §4.3 makes it a function of the
    schedule's `after` field, so it belongs to (6)'s instrument and to the row.

**(6) `assert_instruments_scheduled` — the instrument generalised, and the
landed function re-expressed over it.**

**`assert_instruments_clean_n` CANNOT be called from a scheduled run at all, and
two of its four checks are why** (`WO-0082` §20.2, the finding this round
consumes): it demands *"the strobe monitor must be clean **AND**
`high_cycles "error_underflow"` must be **0**"* — a conformant abort strobes for
exactly one cycle — and *"the standing decoder must report exactly `frames`
completed frames, **NONE of them underflowed**"* — a conformant abort produces
exactly one frame whose `underflowed` field is true. **Under this round's
stimulus a strobe and an underflowed frame are the CONFORMANT outcome.**

```
val assert_instruments_scheduled
  :  t
  -> row:string
  -> frames:int
  -> underflowed:int list                              (* positions, transmission order *)
  -> strobe_events:Dv_monitors.Strobe_monitor.event list
  -> unit
```

It makes the same four checks, three of them parameterised:

1. **The standing decoder is clean** — obligation 1, **unchanged, and it must
   stay unchanged**. `Tx_decoder` judges §9's underflow word shape itself (its
   REQ-206 clause), so **an aborted frame that is malformed IS a violation and
   must still fail the run**. This is the check that makes the round's silence
   assertions non-vacuous.
2. **Every event in `strobe_events` is registered via `Strobe_monitor.expect`,
   then the monitor is asserted clean** — which is obligation 4's *both halves*
   at once: every expected event pulsed **exactly once** at its pin, and **no
   high cycle is unclaimed**. Additionally assert
   `high_cycles "error_underflow" = List.length strobe_events` as its own
   statement, because a count and a set are different failures and the count's
   message is the readable one.
3. **The standing decoder reports exactly `frames` completed frames.**
4. **The set of positions whose frames carry `underflowed = true` equals
   `underflowed`, as a list compared whole** — not a count, and not a membership
   test. **A count would pass a run in which the wrong frame aborted.**

Then, **the landed function becomes the zero-strobe, zero-underflow special case
at the top of that generalisation**:

```
assert_instruments_clean_n t ~row ~frames =
  assert_instruments_scheduled t ~row ~frames ~underflowed:[] ~strobe_events:[]

assert_instruments_clean   t ~row = assert_instruments_clean_n t ~row ~frames:1
```

— **byte-identical behaviour at `underflowed = []` and `strobe_events = []`**, as
§5.2's third bullet defines that phrase, which the **21 landed units** are the
witness for. The conservation rule then lives in **one** place, which is bar
`M-8`'s lesson applied to this round's one re-expression.

**Summary: `bench.mli` goes from 16 exported values to 19, plus one module.**
Three values added (`run_scheduled`, `underflow_event`,
`assert_instruments_scheduled`), one module added (`Stall`), sixteen values
unchanged byte for byte, and each addition documented in the file's own docstring
register — the landed `.mli` is a contract document, not a signature list, and
yours must match it.

### 5.4 What this extension deliberately does NOT build, stated so the residue is not lost

**`AP-M04` §7's `T-3` names two halves and this round builds both — the
placement primitive was already there, and the oracle is §4.** What it does
**not** build:

- **No `cfg_ifg` or `cfg_tx_enable` parameterisation.** `M04-F3`'s and family
  K's, `BM5`.
- **No handover-release scheduler.** `T-7`'s still-missing half, whose consumers
  are family H's rows, `BM5`.
- **No conservation monitor.** `AP-M04` §7 `T-2` is still unbuilt; the bench
  carries the counting rule itself, now at a run in which one frame's `tlast` is
  accepted into a *different* frame (§4.3). **That is a strengthening of the
  reason `T-2` exists, and it is mine to carry, not this round's to fix**
  (§19.2 item 2).
- **No multi-stall schedule.** One stall per run (§5.3(1)).

**What follows for the record**: on absorption I move `T-3`'s state cell to the
extent measured, and the sentence that says so is mine to write at the `RV-`.

> **THE NAMING RULE, at the second site that produces the sentence.** This
> section names the consumers of what is not built **by row id, because this is
> the packet.** In `test/**` those consumers are **described and never named** —
> §11.1's title rule and `BM8`, restated at the demand rather than only at the
> rule.

---

## 6. The derived constants, per unit

**Every number below is derived from §4's abort law and from SPEC-M04 §6.1/§7/§9.
Nothing is estimated and nothing is carried from another packet.** If you cannot
derive one, **report it — do not adopt it** (`BM3` protects you, `BM4` convicts a
silent adoption, class **D5** credits the report in full).

### 6.0 The round-wide rules every unit inherits

**(a) The run length** is `cycles_for_scheduled_run` (§5.3(3)), and every unit's
figure is tabulated at §10. **No unit computes its own run length.**

**(b) The content builder** is the landed `content_octets ~p` — octet `j` =
`1 + Int.rem j 127` — for **every** frame in this round. Its three properties
(never `0x00`, never `0xA5`, period 127 coprime with 8) are what keep the pad
claims and the poison positions non-vacuous. **A tail-frame's content is a SUFFIX
of its element's own list and is never rebuilt with a different `~p`** (§4.3
consequence 2, trap **T23**).

**(c) Every scan states its index domain, and every exclusion states its
reason.** In particular, for this round's new stimulus class:

- a **content** scan on a **normal** frame runs over that frame's own wire octet
  indices `0 … F−5`, with the four FCS octets at `F−4 … F−1` **excluded and the
  exclusion's reason in the comment** — the FCS is judged by comparison against
  the oracle, never by a scan (trap **T11**);
- a **content** scan on an **aborted** frame runs over **all `8w` indices**,
  because **there is no FCS to exclude** (§4.2 fact 4) — and the comment says
  that, because an aborted frame's octet list is the one place in this directory
  where the exclusion does **not** apply and a habit is more dangerous than a
  rule;
- an **idle** scan runs over the abort word's lanes **2 … 7** and every lane of
  every gap word up to but **excluding** the next start character.

**(d) No unit prints anything.** This round commissions **no** printed value, so
**every `[%expect]` block you write is `[%expect {||}]` and stays empty**, and
`dune runtest` is predicted **green** rather than red-then-promoted (§16.3). Any
content in any block is hand-authored — `BM18`, class `D4c`, a bounce.

**(e) §0.6's strobe window is NOT asserted anywhere in this round — and the form
this takes here is NOT the form it took last round.** `AP-M04` obligation 5
forbids asserting the window on `error_underflow`. `WO-0082` §6.0(e) discharged
that by expecting zero events and computing no window at all. **This round
expects events, so the discharge is different and stricter**: every window in
this round is produced by **`underflow_event` and by nothing else** (§5.3(4)),
it is `[R, R + 2]` by §4.2 fact 6, and **no unit asserts that a pulse lies inside
it**. Every unit asserts §9's **pin** and obligation 4's **exact event set**.
**Computing a window anywhere but in `underflow_event` is `BM20`.**

**(f) `C` is observed, never assumed** — `first_accepted_cycle` is the one
definition — and **no assertion, comment, title or Return-log sentence names an
absolute cycle measured from cycle 0, from reset, or from the release of
`clear`** (`M04-A5`, round-wide, `BM7`). Every cycle in §6 is written relative to
`C`; a frame after the first has its cycles written relative to `C` **through the
run law and the abort law**, never relative to a second observed acceptance
(trap **T3**).

**(g) `cfg_ifg` is 12 and `cfg_tx_enable` is 1 on every cycle of every run.** No
unit changes either, reads either, or asserts anything about a value of either
(`BM5`).

**(h) `R` is derived AND cross-checked, and the two are different acts.** Every
unit asserts the strobe at the **derived** `R` from its own table below. `ST-2`
separately guarantees that the bench withheld where the schedule said. **A unit
that took `R` from its own drive record and then asserted the strobe there would
be asserting that the design strobed where the bench stalled — which is true of
a design that strobes on every stalled cycle, four times over, and is exactly
what `M04-G3` exists to kill.** Derive `R`; do not observe it.

### 6.1 The master frame table — every frame this round drives

| `P` | `W = ⌈P/8⌉` | `F = max(P,60)+4` | `⌊F/8⌋` | `t = F mod 8` | pad | `g` | gap | used by |
|---|---|---|---|---|---|---|---|---|
| **20** | 3 | 64 | 8 | 0 | 40 | 2 | 16 | U25 (frame 1) |
| **34** *(a tail, never a contents element)* | 5 | 64 | 8 | 0 | 26 | 2 | 16 | U24's tail |
| **60** | 8 | 64 | 8 | 0 | 0 | 2 | 16 | U22, U25, U26, U27 |
| **754** *(a tail, never a contents element)* | 95 | 758 | 94 | 6 | 0 | 3 | 18 | U23's tail |
| **1514** | 190 | 1518 | 189 | 6 | 0 | 3 | 18 | U23, U24 |

**And the aborted-frame row, which has no `F` at all**: an aborted frame's wire
length is `8w` octets, its terminate lane is **1** at every member, its `g` is
**2** and its gap is **15** — independent of `P`, of `W` and of `w`. §4.2 facts
4 and 5. **That independence is the single most useful fact in this section and
the one most likely to be second-guessed at a short frame**: `M04-G5`'s aborted
frame is **8 octets** on the wire, not 60, not 64.

### 6.2 U22 — `M04-G5`. The earliest cycle the condition can hold

**Stimulus**: `run_scheduled [ content_octets ~p:60 ]
{ frame = 0; word = 1; hold = 1; after = Abandon }`. One elaboration, one
contents element, **run length 32 cycles**.

**Derived**, with `C = first_accepted_cycle samples` and `S₀ = C + 1`:

| Quantity | Value | Where it comes from |
|---|---|---|
| accepted words | word 0 only, at `C` | the schedule; `ST-3`'s `abandoned` = `8 − 1` = **7** |
| **`R` (strobe)** | **`C + 1`** | §4.2 fact 1: `R = S₀ + w − 1 = C + 1 + 1 − 1` |
| frame octets on the wire | **8** octets, at cycle **`C + 2`** | §4.2 fact 4: `8w = 8`, at `S₀ + 1` |
| **abort word** | **`C + 3`** | §4.2 fact 3: `A = R + 2` |
| terminate lane | **1** | §4.2 fact 5 |
| `gaps` | **`[]`** | no next start character, so the gap is not **completed**; the decoder lists one entry *per completed gap* |
| decoded frames | **1**, `underflowed = true` at position 0 | §4.3: `Abandon`, `n = 1` |

**Assertions, in this order:**

1. **`assert_instruments_scheduled t ~row ~frames:1 ~underflowed:[0]
   ~strobe_events:[ underflow_event ~frame:0 ~cycle:(c + 1) ~why:… ]`** —
   decoder clean, the exact strobe set `{C+1}`, one frame, and it is the
   underflowed one.
2. **The abort word at `C + 3`, read from `samples`' own raw `wire`**: lane 0 is
   `Control Xgmii_word.error_char`, lane 1 is `Control
   Xgmii_word.terminate_char`, lanes 2–7 are `Control Xgmii_word.idle_char`.
   **Assert all eight lanes**, not just the two — `xgmii_txc` = 0xFF is part of
   §9's shape.
3. **The decoded frame's octets are exactly the first 8 octets of
   `content_octets ~p:60`** — `[1;2;3;4;5;6;7;8]` by that function's own rule.
   **Assert the length is 8 as its own statement first**: a design that padded
   to 60 or appended an FCS fails on the length, and the length failure is the
   readable one (trap **T21**).
4. **`terminate_lane` is 1** and **`terminate_cycle` is `C + 3`**.
5. **`gaps` is the empty list**, asserted as its own statement with the reason in
   the comment. *(This is the one place this round asserts an absence of gaps,
   and it exists so that U26's `[15]` is read against a run that has none.)*

**What this unit does NOT assert, and the comment says so.** Nothing about
`tx_tready` on any cycle (`BM11`). Nothing about the cycles after `C + 3` beyond
the strobe-set emptiness the instrument already carries. **And it does not
describe the requirement as covered** — six rows of that family remain
outstanding after this round (§9.8).

### 6.3 U23 — `M04-G1`, `M04-G2`, `M04-G8`. Mid-frame, maximum length, resumed

**Stimulus**: `run_scheduled [ content_octets ~p:1514 ]
{ frame = 0; word = 95; hold = 1; after = Resume }`. One elaboration, **run
length 224 cycles**.

**Why `w = 95`.** The row says *"the word required at cycle `C + k` for a
mid-frame `k`"*; 95 of 190 is the midpoint, and it leaves a tail of **754**
octets — a frame long enough to need no padding and whose terminate lane
(**6**) differs from the aborted frame's (**1**), so the two gap arithmetics in
one run are visibly different rather than accidentally equal.

| Quantity | Value | Where it comes from |
|---|---|---|
| `S₀` | `C + 1` | §4.1 |
| accepted words before the abort | 0 … 94, at `C … C + 94` | §4.2 fact 1 |
| **`R` (strobe)** | **`C + 95`** | `S₀ + 95 − 1` |
| aborted frame's wire octets | **760**, at cycles `C + 2 … C + 96` | `8w`, at `S₀ + 1 … S₀ + w` |
| **abort word** | **`C + 97`** | `R + 2` |
| terminate lane / `g` / **gap** | **1** / 2 / **15** | §4.2 fact 5 |
| gap's last cycle | `C + 98` | `A + g − 1` |
| **tail-frame start character `S′`** | **`C + 99`** | §4.2 fact 7 branch (a): `hold = 1 ≤ 3`, so a word is offered at or before `C + 98` |
| tail `P′` / `W′` / `F′` / `⌊F′/8⌋` / `t′` | **754** / 95 / **758** / 94 / **6** | §4.3; `1514 − 8×95` |
| tail terminate | **`C + 194`**, lane **6** | `S′ + 1 + ⌊F′/8⌋` |
| decoded frames | **2** — position 0 underflowed, position 1 not | §4.3, `Resume` |
| `ST-3` abandoned | **0** | `Resume` |

**Assertions, in this order:**

1. **`assert_instruments_scheduled t ~row ~frames:2 ~underflowed:[0]
   ~strobe_events:[ underflow_event ~frame:0 ~cycle:(c + 95) ~why:… ]`.**
2. **`M04-G1`'s content claim**: the aborted frame's octets are **exactly** the
   first 760 octets of the element's own content list, length asserted first;
   **no FCS and no pad** — assert the length is 760 and **not** 764 and **not**
   any padded figure, with §4.2 fact 4 cited in the comment.
3. **`M04-G2`'s separation, asserted as two named cycles and then as their
   difference.** The strobe is at `C + 95`; the abort word is at `C + 97`; the
   difference is **2**. Assert all three. **The comment states why the difference
   is the assertion and not a consequence**: a design pulsing at the wire
   consequence is one pulse, one `/E/` word, and inside §0.6's window (§4.2 fact
   6) — a bench asserting only that both happened passes it.
4. **The abort word's eight lanes**, as U22 asserts them.
5. **The gap**: `Tx_decoder.gaps` has **exactly one** entry and it is **15**.
   Assert the list length first and by itself.
6. **The tail-frame**: `S′` at `C + 99`; its terminate at `C + 194` lane 6; its
   decoded octets equal `Frame.with_fcs` of **the suffix of the element's own
   content beginning at octet 760** (trap **T23** — not
   `content_octets ~p:754`); `underflowed = false`.
7. **`M04-G8`'s conservation, in two statements.** *(a)* Two frames on the wire,
   exactly one underflowed at position 0 — carried by assertion 1. *(b)* **The
   run's `tlast` acceptances are exactly one, and its cycle is greater than the
   aborted frame's terminate cycle `C + 97`.** Computed from `samples` —
   the samples whose `accepted` is true and whose `offered.tlast` is true.
   **The comment states what this catches**: a conservation rule keyed on `tlast`
   acceptance attributes this one acceptance to the tail and counts **one** frame
   where **two** reached the wire (§4.3, trap **T24**), which is the concrete form
   of the warning obligation 3 states in the abstract.

### 6.4 U24 — `M04-G3`. Four consecutive withheld cycles, one pulse

**Stimulus**: `run_scheduled [ content_octets ~p:1514 ]
{ frame = 0; word = 185; hold = 4; after = Resume }`. One elaboration, **run
length 229 cycles**.

**Why `w = 185` and not U23's 95.** The row's content is the *count* of pulses
and not the position, so the position is free — and it is spent on the half of
§4.3 that U23 does not reach: a tail of **34** octets, which is **padded to 60
and FCS'd as its own frame**. U23 drives an unpadded tail; this unit drives a
padded one; between them both halves of §4.3's derivation are measured. **This is
a deliberate choice and not an arbitrary one, and if you disagree with it, say
so** (class D5).

| Quantity | Value | Where it comes from |
|---|---|---|
| **`R` (strobe)** | **`C + 185`** | `S₀ + 185 − 1` |
| withheld cycles | `C + 185 … C + 188` | `hold = 4` |
| aborted frame's wire octets | **1480**, at `C + 2 … C + 186` | `8w` |
| **abort word** | **`C + 187`** | `R + 2` |
| gap's last cycle | `C + 188` | `A + 1` |
| resume cycle | **`C + 189`** | `R + hold` |
| **tail start character `S′`** | **`C + 190`** | §4.2 fact 7 **branch (b)**: the first offer is at `C + 189 > C + 188`, M04 is in `Idle` with `tx_tready` = `cfg_tx_enable` = 1, so the word is accepted there and the preamble follows |
| **gap** | **23** octets | lanes 1–7 of `C + 187` (7) + `C + 188` (8) + `C + 189` (8) |
| tail `P′` / `F′` / `t′` / pad | **34** / **64** / **0** / **26** | §4.3; `1514 − 1480` |
| tail terminate | **`C + 199`**, lane **0** | `S′ + 1 + 8` |
| decoded frames | **2** — position 0 underflowed | §4.3 |

**Assertions, in this order:**

1. **`assert_instruments_scheduled t ~row ~frames:2 ~underflowed:[0]
   ~strobe_events:[ underflow_event ~frame:0 ~cycle:(c + 185) ~why:… ]`** —
   **and this single call is the whole of the row's "exactly one pulse" claim**,
   because the monitor's exact-event-set check is what makes *no other pulse*
   an assertion rather than an absence. **Say so in the comment.**
2. **The named silences**: `underflow` is **false** at `C + 186`, `C + 187` and
   `C + 188`, asserted **at each named cycle** with a message saying these are the
   three later withheld cycles and that there is no open frame to underflow
   (§9's *"Two underflows on one frame: impossible — the first ends the frame"*).
   **Assertion 1 already covers them; this one names them**, because a failure
   whose message says *"a pulse at `C + 186` that no expected event claims"* is
   diagnosable and a failure that says the set differed is not.
3. **Exactly one abort word in the run**: the word at `C + 187` carries §9's
   shape, and **no other cycle of the run carries an error character in any
   lane**. Scan every sample's `wire`, domain stated.
4. **The gap** is **23** and there is exactly one completed gap. **The comment
   states why it is 23 and not 15**: `hold = 4` puts the resume past the gap's
   last cycle, so §4.2 fact 7's **branch (b)** applies. **A unit asserting 15
   here would be importing `M04-F6`'s figure into a run whose schedule forbids
   it**, and that is the shape of the mistake to expect (trap **T26**).
5. **The tail-frame**: `S′` at `C + 190`; terminate at `C + 199` lane 0; **26 pad
   octets**; decoded octets equal `Frame.with_fcs (Frame.pad_to_60 (the suffix of
   the element's own content beginning at octet 1480))` — 64 octets.

### 6.5 U25 — `M04-G6`. The next frame transmits correctly

**Stimulus**: `run_scheduled [ content_octets ~p:60 ; content_octets ~p:20 ]
{ frame = 0; word = 4; hold = 1; after = Abandon }`. One elaboration, **run
length 47 cycles**.

| Quantity | Value | Where it comes from |
|---|---|---|
| **`R` (strobe)** | **`C + 4`** | `S₀ + 4 − 1` |
| aborted frame's wire octets | **32**, at `C + 2 … C + 5` | `8w` |
| **abort word** | **`C + 6`** | `R + 2` |
| **gap** | **15** octets | §4.2 fact 5 |
| frame 1 first offered | `C + 5` | `R + hold`; `Abandon` advances to the next element |
| **frame 1's start character `S₁`** | **`C + 8`** | §4.2 fact 7 branch (a): offered at or before the gap's last cycle `C + 7` |
| frame 1 `P` / `F` / `t` / pad | 20 / 64 / **0** / **40** | §6.1 |
| frame 1 terminate | **`C + 17`**, lane **0** | `S₁ + 1 + 8` |
| decoded frames | **2** — position 0 underflowed, position 1 not | §4.3, `Abandon` |
| `ST-3` abandoned | **4** | `W₀ − word` = `8 − 4` |

**Assertions, in this order:**

1. **`assert_instruments_scheduled t ~row ~frames:2 ~underflowed:[0]
   ~strobe_events:[ underflow_event ~frame:0 ~cycle:(c + 4) ~why:… ]`.**
2. **Frame 1's preamble word at `C + 8`**, read from `samples`' own raw `wire`:
   `control` = 0x01 and `data` = `[0xFB; 0x55; 0x55; 0x55; 0x55; 0x55; 0x55;
   0xD5]`, lane 0 first, compared with `List.equal Int.equal`;
   `Xgmii_word.start_lane` returns `Some 0`. **The row's own words: *"the second
   frame carries the full preamble word"*.**
3. **Frame 1's content, the row's central claim**: its decoded octets equal
   `Frame.with_fcs (Frame.pad_to_60 (content_octets ~p:20))` — **64 octets, 20 of
   content, 40 of pad, four of FCS**, the pad **inside** the FCS computation
   (trap **T9**). **The comment states the Kills cell in its own terms**: a design
   whose CRC register is not re-seeded after an abort produces a frame with the
   right length, the right pad count and the right terminate lane, and **only
   this comparison speaks**.
4. **Frame 1's terminate character at `C + 17`, lane 0.**
5. **The aborted frame's 32 octets**, length first, no FCS, no pad.

### 6.6 U26 — `M04-F6`. The gap after an abort

**Stimulus**: `run_scheduled [ content_octets ~p:60 ; content_octets ~p:60 ]
{ frame = 0; word = 4; hold = 1; after = Abandon }`. One elaboration, **run
length 47 cycles**.

**Why a second run at nearly U25's stimulus.** The two units assert disjoint
things on different frames, they are filed in different families' files
(§11.1's convention), and **F6's claim must not ride on G6's passing**: a gap
figure asserted inside a unit whose subject is an FCS is a gap figure a later
coverage map cannot find. 47 cycles is the price and it is 0.045% of the measured
size class.

| Quantity | Value |
|---|---|
| **`R`** | `C + 4` |
| **abort word** | `C + 6`, terminate character `/T/` at **lane 1** |
| **`gaps`** | **`[15]`** — exactly one entry, and it is 15 |
| **frame 1's start character** | `C + 8`, **lane 0** |
| frame 1 terminate | `C + 17`, lane 0 |
| decoded frames | 2 — position 0 underflowed |

**Assertions, in this order:**

1. **`assert_instruments_scheduled t ~row ~frames:2 ~underflowed:[0]
   ~strobe_events:[ underflow_event ~frame:0 ~cycle:(c + 4) ~why:… ]`.**
2. **`Tx_decoder.gaps` has exactly one entry** — asserted as its own statement —
   **and it is exactly 15.**
3. **The exactness is the row, and the comment must say so in the row's own
   terms**: `15` is asserted, **not** `>= 12`. A design measuring the gap from the
   `/E/` in lane 0 rather than from the `/T/` in lane 1 produces **16**, is **one
   octet from conformant**, and **passes every `>= cfg_ifg` check**.
4. **The terminate character is at lane 1** of the abort word, read directly
   from `samples`' own raw `wire` at `C + 6` **as well as** through the decoder's
   `terminate_lane`. **Two readings of the same fact, deliberately**: this round
   is the first in the programme to measure a gap whose terminate character comes
   from an aborted frame, and a disagreement between the two readings is class
   **D2** rather than class D1 (§15).
5. **The next start character is in lane 0**, at `C + 8`, via
   `Xgmii_word.start_lane` on the raw sample.

**What this unit does NOT assert, and the comment says so.** No average gap, no
gap of 12 at any lane, and no import of §0.3's **receive**-side spacing — the
round-wide prohibition of the family's NO-ASSERT row, restated here because this
file is where it lives.

### 6.7 U27 — `M04-A4`. Three predecessors, one preamble word

**Stimulus**: `run_scheduled [ content_octets ~p:60 ; content_octets ~p:60 ;
content_octets ~p:60 ] { frame = 1; word = 4; hold = 1; after = Abandon }`.
One elaboration, **run length 59 cycles**.

**The three members, and which frame is which.** Frame 0 follows **`clear`
returning to 0** — `create` drives `clear` = 1 on cycle 0 alone and 0 for the
rest of every run, and §6.2 states that *"Reset state and `clear` state are both
`Gap` with the gap counter satisfied"*, so the run's first frame **is** the row's
first member with no capability built for it. Frame 1 follows **a normally
terminated frame**. Frame 2 follows **an underflowed frame**. **Three members,
one run, and the third exists for the first time this round.**

**The cycle derivation for frame 1, which is the only place in this round where
a withheld word is not in the run's first frame.**

| Quantity | Value | Where it comes from |
|---|---|---|
| `S₀` / `T₀` | `C + 1` / `C + 10`, lane 0 | §4.1 at `F = 64` |
| frame 1's word 0 accepted | `C + 8` | §7's C-16 consequence 2 — **and measured at `65ba148`** |
| frame 1's word 1 accepted | `C + 11` | §7's C-16 consequence 4 — **and measured at `65ba148`** |
| **`S₁`** | **`C + 12`** | `T₀ + g` = `C + 10 + 2`; C-16 consequence 3 (*"the next start character is at C+12 whether that frame's first word was accepted at C+8 or at C+11"*) |
| frame 1's words 2, 3 accepted | `C + 13`, `C + 14` | `tx_tready` = 0 at `C + 12` (C-16 consequence 4), 1 thereafter in `Frame` |
| **`R` (strobe)** | **`C + 15`** | §4.2 fact 1: `R = S₁ + w − 1 = C + 12 + 4 − 1` |
| aborted frame's wire octets | **32**, at `C + 13 … C + 16` | `8w`, at `S₁ + 1 … S₁ + w` |
| **abort word** | **`C + 17`** | `R + 2` = `S₁ + 1 + w` |
| **gap** | **15** octets | §4.2 fact 5 |
| **`S₂`** | **`C + 19`** | §4.2 fact 7 branch (a); frame 2 first offered at `C + 16`, gap's last cycle `C + 18` |
| `T₂` | **`C + 28`**, lane 0 | `S₂ + 1 + 8` |
| `gaps` | **`[16; 15]`** | frame 0's gap at `t = 0`, then the abort's at `t = 1` |
| decoded frames | **3** — position 1 underflowed | §4.3, `Abandon` |
| `ST-3` abandoned | **4** | `W₁ − word` |

**`word = 4` and not 2 or 3**, and the reason is §4.4's derived rule: words 0
and 1 of a back-to-back frame are accepted before its start character and are
never *required*, so the schedule's lower bound there is 2, and 4 is chosen to
leave two required-and-presented words between the start character and the
withholding — so that a design which aborts on the **first** required word of any
back-to-back frame fails on the strobe cycle rather than passing by coincidence.

**Assertions, in this order:**

1. **`assert_instruments_scheduled t ~row ~frames:3 ~underflowed:[1]
   ~strobe_events:[ underflow_event ~frame:1 ~cycle:(c + 15) ~why:… ]`** —
   **note `~underflowed:[1]`, a list and not a count**: a count of one would pass
   a run in which the wrong frame aborted, which at three frames is a live
   possibility and not a pedantry (§5.3(6) check 4).
2. **THE ROW'S OWN CLAIM, and it is the whole unit**: the raw `wire` words at
   `C + 1`, `C + 12` and `C + 19` are **equal to each other**, byte for byte and
   control bit for control bit — compare `control` and the eight `data` lanes
   with `List.equal Int.equal`, **and compare each against the REQ-201 literal**
   `[0xFB; 0x55; 0x55; 0x55; 0x55; 0x55; 0x55; 0xD5]` with `control` = 0x01.
   **Both comparisons, because equal-to-each-other and equal-to-the-spec are
   different failures**: three identical wrong preambles pass the first and fail
   the second.
3. **`Xgmii_word.start_lane` returns `Some 0`** at each of the three.
4. **The three start cycles are `C + 1`, `C + 12`, `C + 19`** —
   `Tx_decoder.start_cycles` has length exactly 3 and equals that list.
5. **The middle frame is the underflowed one**: position 1's `underflowed` is
   true, positions 0 and 2 false, and frame 2's decoded octets equal
   `Frame.with_fcs (Frame.pad_to_60 (content_octets ~p:60))`.
6. **`gaps` is `[16; 15]`**, asserted whole. **The comment states what the pair
   demonstrates**: the same design serves 16 after a clean terminate at lane 0
   and 15 after an abort's terminate at lane 1, in one run, which is the pair
   `M04-F6` alone cannot show.

**What this unit does NOT assert, and the comment says so.** The **start
spacings** — a cadence claim over a run belongs to the family whose rows own
REQ-209 and this unit drives past it (`BM8`, trap **T25**). And no value of
`tx_tready` at `C + 12` or anywhere else, though this run's derivation cites
it: **citing a specification clause in a derivation is not asserting the
value**, and the value is family H's (`BM11`).

---

## 7. How to instantiate the DUT without reading it

**You do not instantiate it.** `Bench.create` does, and it is landed and
unchanged (`bench.mli`'s own docstring is the contract). Its independence
discipline is stated in that docstring and it binds you: the file names three
things from SPEC-M04 alone — the library, the module and
`create : Scope.t -> Signal.t I.t -> Signal.t O.t` — and reaches every port by
**projecting a field off the live `Cyclesim.inputs`/`outputs` record**, never by
naming the module that declares those records' types. **Nothing you write this
round goes near that seam**: your new runner calls `create ()` exactly as
`run_stream` does today.

If the implementation's ports diverge from the lift at
`docs/specs/ifc_check/xgmii_tx_64_ifc.ml`, this directory fails to compile.
**That failure is REQ-010's type-identity check doing its job, and it is a
finding for dv_lead — never a bench repair.**

---

## 8. What you may NOT read

**`libs/**`, `top/**`, `bin/**`, `rtl_snapshots/**`, and
`test/third_party/**` — not at this commit and not at any earlier one.**
PROTOCOL §10, charter §3. In particular
`libs/hardcaml_ethernet/src/xgmii_tx_64.ml` exists at this tree and is not to be
opened for any purpose, **including "checking whether the abort path is really
there"**. This round drives a path no bench has driven; the temptation to look
is correspondingly higher, and **the whole value of the round is that §4's law
is derived from SPEC-M04 and not from the module**. If §4 is wrong, I want to
find that out from a red, not from a bench that was written against the design.

Your journal's `Inputs` section is the standing evidence (bar **M-16**,
`BM15`). A path from the forbidden set appearing in your `Inputs`, your Return
log or your write record is a bounce whether or not anything in the work depends
on it.

---

## 9. Regime facts — the standing rules that bind this round, numbered

### 9.1 The SHA rule — a sentence asserting a census is not the census

`AP-M04` §0.1(i). Any claim quantifying over a set — *"the only unit that …"*,
*"family A completes"*, *"no other file …"* — is a **census**, and a census is
made by running it at a stated SHA and reporting the raw output, never by
recalling it. Every count in your Return log states its method.

### 9.2 The domain rule — a universal over "the bench" is measured over every producer

A claim of the form *"no unit asserts X"* is measured over every unit, not over
the ones you wrote. §12's bars are phrased that way deliberately.

### 9.3 The polarity rule — a claim that something does not exist is measured

`AP-M04` §0.1(iii). §5.1's table records what was read to establish each absence.
If you find any row of it wrong **in either direction**, that is §18 item 8 and a
finding I want.

### 9.4 Withholding IS the stimulus here, and the prohibition it replaces

**`WO-0080` §9.4 and `WO-0082` §9.4 forbade withholding a word mid-frame
(`BM6`), and `bench.mli`'s own docstring records that prohibition.** **This round
lifts it, in exactly one direction and by commission.** The ground is `AP-M04`
§3's closing paragraph — *"Withholding a word is not an illegal stimulus here, it
is the error condition"* — and SPEC-M04 §7's handshake bullet, which makes a
required word not presented **REQ-206's underflow, not a gap**.

**What is still prohibited, and it is not a residue but a live bound:**

- **No REQ-016 idle-injection wrapper at M04's source interface.** SPEC-M04 §7
  states the prohibition normatively: *"A bench SHALL NOT build a REQ-016
  idle-injection wrapper at this module's source interface."* The distinction is
  not cosmetic. **An idle-injection wrapper injects idle cycles as a
  transport-level nuisance and expects the frame to survive; this round's
  schedule withholds a word and expects the frame to END.** A wrapper built here
  measures a frame the injection destroyed. **`BM6` survives in that form.**
- **No withholding at a between-frames handover** — §4.4's second legality rule,
  which this round's schedule cannot express.
- **`bench.mli`'s docstring paragraph stating the old prohibition is landed text
  in a file you are extending. Do not delete it; extend the register beneath it**
  (§11.4's spirit applied to a docstring: the sentence was true of every runner
  that existed when it was written and remains true of them).

### 9.5 The FCS oracle is REQ-305's and never the design's own engine

`AP-M04` §2 obligation 2. Every expected FCS in this round is
`Frame.fcs (Frame.pad_to_60 content)`, which reaches `Dv_golden.Crc32_ref`. **No
expected value comes from a loopback, from the decoder's own verdict, or from the
design's output** (`BM12`). **And the aborted frames have no expected FCS at
all** — asserting one would be demanding the well-formed short frame §9 exists to
prevent (§4.2 fact 4).

### 9.6 BAR T1 — the differential anchor at this boundary is SHUT

`AP-M04` §7.1, three independent conditions, each measured at the tree: the
transmit reference is **not vendored**; there is **no transmit harness**; and
**REQ-901 declares no divergence class** at this boundary. **No file is created
under `test/cosim/`** and no co-simulation result is cited (`BM12`). Note what a
fully opened lane would still not see: **`error_underflow`** — REQ-901 does not
compare strobes at all — which leaves this round's headline claim bench-only
either way, and is worth stating because a reader might expect a family whose
whole subject is a strobe to be the one a co-simulation would settle.

### 9.7 The census does not see M04 — measured, and it changes what your counts mean

`tools/dv_checks.sh` at this tree contains **zero** occurrences of `M04`,
`xgmii_tx_64` or `AP-xgmii_tx` — re-measured at `22c60fb`, not carried.
**No committed instrument counts an M04 row.** Every row count in this packet is
a **hand count with its method stated**, and so is every count in your Return
log. `DVC-1a` is mine and still owed (§19.2).

### 9.8 What measuring these eight rows does — and the five things it does not do

**This is the paragraph most likely to be over-read later, so it is written
before the run.**

**What it does.** If the verdicts hold, family G's pulse rows stop being
underived and undriven, the abort path of this module is measured for the first
time in either design, and **the plan goes from 31 discharged to 39, from 51
outstanding to 43** — a figure I record at absorption by `RV-`, not one this
packet or your return may state as fact (§9.1).

**What it does not do.**

1. **It does not make the underflow requirement covered.** The family's highest-
   value row — the faithful implementation read to its first full stop — is
   **not** carried here (§1.4), and one further row of the family remains
   NO-ASSERT by obligation 5. **Describing that requirement as covered anywhere
   is `BM8`** — in a title, a comment, or a Return-log sentence.
2. **It does not complete family F.** Two rows of it need capabilities this round
   does not build.
3. **It does not discharge any row of the family that asserts `tx_tready`
   values**, though this round's derivation cites their clauses and its runs
   drive their cycles. §6.7 lists what U27 must not assert.
4. **It does not discharge the sustained-cadence family's rows**, though U27
   drives three frames and a spacing is visible in every one of this round's
   runs.
5. **It does not lift BAR T1**, open an `SO-`, or license any statement about
   Phase-1 sign-off. A bar is a constraint on what a **packet** may claim, never
   on what a bench may assert.

> **THE NAMING RULE, at the third site that produces the sentence.** **The five
> exclusions above are written with row and requirement ids because this is the
> packet.** The identical content written into a unit title, a comment or a
> string in `test/**` **discharges those rows in the coverage map I build by hand
> from those titles** — so in a source file the same exclusions are carried **by
> description**: *"the family-G row that drives nothing at that cycle"*, never
> its id (§11.1, `BM8`, bar `M-7`).

---

## 10. Cost — the size class, measured, and this round's ceiling

`WO-0070`'s cost probe measured family L's stimulus at **2.036 s** total,
**105 010** cycles in one `Bench.run`. **That is the size class, and it is
measured on cycles driven.**

| Unit | Rows | Runs | Cycles per run | Cycles | Elaborations |
|---|---|---|---|---|---|
| U22 | `G5` | 1 | `27 + (1 + 3 + 1)` = **32** | 32 | 1 |
| U23 | `G1`, `G2`, `G8` | 1 | `27 + (95 + 3 + 1) + (94 + 4)` = **224** | 224 | 1 |
| U24 | `G3` | 1 | `27 + (185 + 4 + 1) + (8 + 4)` = **229** | 229 | 1 |
| U25 | `G6` | 1 | `27 + (4 + 3 + 1) + (8 + 4)` = **47** | 47 | 1 |
| U26 | `F6` | 1 | `27 + (4 + 3 + 1) + (8 + 4)` = **47** | 47 | 1 |
| U27 | `A4` | 1 | `27 + (8 + 4) + (4 + 3 + 1) + (8 + 4)` = **59** | 59 | 1 |
| **total** | **8 rows** | **6** | — | **638** | **6** |

**638 driven cycles and 6 elaborations.** `638 / 105 010` = **0.61%** — two
orders of magnitude inside the measured class on the derived quantity. **No probe
is required**, and `WO-0070` §1.5's band overlap does not need closing here. The
conditional is stated rather than assumed, because the ruling that made it mine
was explicit (`RV-0070-VERDICT`, affirmed at Q3): *if a round's stimulus leaves
the size class `WO-0070` measured, the probe shape is the precedent and §1.5's
band overlap must be closed in the new packet BEFORE its first run.* **This round
does not leave the class**, and its largest single run (U24's 229 cycles) is
**0.22%** of the probe's own single run.

**The pre-committed ceiling, so "inside the class" is checkable rather than
asserted**: **total driven cycles across the whole round ≤ 700, total
elaborations ≤ 8.** If your implementation exceeds either, **stop and flag it —
do not improvise a reduction and do not proceed.** Exceeding it means one of §6's
constants or `cycles_for_scheduled_run`'s allowance is wrong, which is a finding I
want (BOUNCE `BM13`).

---

## 11. Unit structure, the files this round stages, and the append-only rule

### 11.1 Unit structure — six `%expect_test` units across three appended files

| File | New units | Titles |
|---|---|---|
| `test_m04_g.ml` (**append**) | **4** | U22 → `M04-G5`; U23 → `M04-G1` + `M04-G2` + `M04-G8`; U24 → `M04-G3`; U25 → `M04-G6` |
| `test_m04_f.ml` (**append**) | **1** | U26 → `M04-F6` |
| `test_m04_a.ml` (**append**) | **1** | U27 → `M04-A4` |
| **total** | **6** | — |

**A file per family is this directory's convention** and the landed
`test_m04_g.ml` docstring states the expectation in terms: *"Family G's own round
appends further units to THIS file"*. **This is that round.** A row filed by
stimulus class rather than by family is a row no later family round would look
for. **The cost of the convention is that three landed files are edited, and
§11.4 is the rule that makes that safe.**

**The title rule.** Each unit title contains **its own row ids and no other
`M04-` identifier whatsoever**. U23's title carries three ids and that is
correct — they are its rows. **No title, comment or string in any file may name**
any row this round does not carry: naming one would discharge it in the coverage
map I write from these titles by hand, and **no script in this tree would catch
it** (§9.7). Where a comment needs to refer to a neighbouring row, refer to it by
description as `test_m04_g.ml` already does. Bar **M-7**.

**The rule's placement is deliberate**: it is stated at §1.4, §5.4, §9.8 and
`BM8` — at every demand that asks the round to say what it does *not* claim,
which is where the sentence that breaks it gets written — because a rule a worker
meets four sections after the demand that produces the sentence is a rule
discovered on review. **The drafting instrument that catches it**: sweep your own
files for `M04-<letter><digits>` before finalising.

The `=` must be alone on its own line, as it is in every landed unit:

```
let%expect_test "M04-G1, M04-G2, M04-G8: a mid-frame underflow of a maximum-length \
                 frame — one pulse at the pin, the /E/ /T/ word two cycles later, \
                 and the resumed tail counted as its own frame"
  =
```

### 11.2 The files this round stages — exactly six, plus two

1. `test/xgmii_tx_64/bench.mli` — **extended**: the `Stall` module and three new
   values (`run_scheduled`, `underflow_event`,
   `assert_instruments_scheduled`), documented in the file's own docstring
   register. **The 16 existing values keep their signatures byte for byte.**
2. `test/xgmii_tx_64/bench.ml` — **extended**: §5.3's additions and its one
   re-expression; `⌊F/8⌋`, the conservation rule and the §0.6 window each left in
   exactly one place.
3. `test/xgmii_tx_64/dune` — **header comment only**. Add this packet's row line
   under `WO-0082`'s, in the same form. **The `(library …)` stanza does not
   change**: no new dependency edge, and no new file.
4. `test/xgmii_tx_64/test_m04_g.ml` — **append only** (§11.4).
5. `test/xgmii_tx_64/test_m04_f.ml` — **append only** (§11.4).
6. `test/xgmii_tx_64/test_m04_a.ml` — **append only** (§11.4).

plus **this packet's Return log** and **your journal** at
`agents/journals/workers/claude_tb_writer_agent*.md`. **Eight paths in total, and
a seventh source file is `BM14`.**

### 11.3 What does NOT move, and that is not a claim that it is correct

`test/xgmii_tx_64/test_m04_scaffold.ml`, `test_m04_b.ml`, `test_m04_c.ml`,
`test_m04_d.ml`, `test_m04_e.ml` (**the regression witness — §5.2**),
`test/xgmii_rx_64/**` (17 tracked files), `test/xgmii/**`, `test/monitors/**`,
`test/golden/**`, `test/axi64_probe/**`, `test/xgmii_probe/**`, `test/cosim/**`,
`test/attack_plans/**`, `tools/**`, `docs/**`, `libs/**`, `.github/**`. If you
find a defect in any of them, **report it in the Return log and leave it
standing** — a bench round that repairs its own machinery in the same commit
makes the repair unreviewable against the round that needed it. **This is
materially more likely this round than in any previous one** (§15, class D2).

### 11.4 The append-only rule for the three landed family files

**Every edit to `test_m04_g.ml`, `test_m04_f.ml` and `test_m04_a.ml` is an
addition. No existing byte is removed and no existing line is modified.**
Two hunk classes are permitted in each:

- **the new unit or units, appended at end of file**; and
- **optionally**, an addition to the file's own header docstring naming the new
  units, in the register that file already uses.

**The mechanical form of the rule, and it is deliberately the same one PROTOCOL
§5's `R3` uses for journals**: `git diff <base> <landing> --numstat` over those
three paths must show **zero deletions**. A modified line shows as one deletion
and one insertion, so zero deletions is exactly "nothing existing was touched".
Bar **M-5c** (mine, at review), BOUNCE `BM14`.

**Why the rule exists rather than a prohibition on touching them at all.** §5.3
re-expresses `assert_instruments_clean_n`, which has **21 landed consumers**.
Those 21 units are the only evidence that the re-expression changed nothing, and
evidence you edited is not evidence.

---

## 12. The review bar — pre-committed, assigned by seat, and every tree-quantified bar executed at the base

**Each bar below whose pass condition quantifies over a whole tree or a whole
diff was executed at the base commit before this packet issued, and its base
figure is stated.** That obligation is mine and it is `FINDING K-3`'s: *a review
bar that has never been run against its own base is not a bar, it is a hope — and
it fails on the first round where the base has moved, silently, because its
failure looks like a defect in the work.*

**Base**: **`22c60fb`.** Every figure below was measured at that commit by
running the instrument named.

**Seat note**: §17's allow-list gives you **no shell beyond `ocamlc -stop-after
parsing`** and the instruments §17.1 items 4 and 5 carve in by name. Every bar
phrased as a search is therefore a file-search-and-read bar at your seat, or it
is mine.

| Bar | Whose | Instrument | Base figure at `22c60fb` | Pass condition |
|---|---|---|---|---|
| **M-1** | **dv** | `git diff 22c60fb <landing>` read **hunk by hunk** | — | every hunk belongs to one of §11.2's six paths and to a mechanism this packet specifies; no seventh path; no hunk in `test/xgmii_rx_64/**`, `test/xgmii/**`, `test/monitors/**`, `test/golden/**`, `test/attack_plans/**`, `docs/**`, `tools/**`, `libs/**` |
| **M-2** | **dv** | the CI `build` run at the landing commit, **read as a step reading at the source** | — | steps **"Build"**, **"Run tests (expect tests, waveform snapshots)"** and **"Verify nothing was left unpromoted or non-deterministic"**, each read **by name and status**. **A badge is not a reading.** A red at "Run tests" is routed through §15 and **never** through a re-run. **Class P is not expected this round** (§6.0(d)) |
| **M-3** | **dv** | `grep -rh --include=*.ml 'let%expect_test' test/ \| grep -c .` | **161** | **161 → 167**, i.e. **+6** and no other movement. Stated as a **delta**, because the base is a moving figure (§9.7) |
| **M-4** | **dv** | `git ls-files test/xgmii_tx_64/` | **11** tracked files: `bench.ml`, `bench.mli`, `dune`, `test_m04_a.ml`, `test_m04_b.ml`, `test_m04_c.ml`, `test_m04_d.ml`, `test_m04_e.ml`, `test_m04_f.ml`, `test_m04_g.ml`, `test_m04_scaffold.ml` | **exactly 11, the same set** — this round creates no file |
| **M-5** | **dv** | `git diff --stat 22c60fb <landing>` over `test/xgmii_rx_64/` | 17 tracked files | **zero** hunks. All 17 byte-identical |
| **M-5b** | **dv** | `git diff --numstat` over `test_m04_scaffold.ml`, `test_m04_b.ml`, `test_m04_c.ml`, `test_m04_d.ml`, `test_m04_e.ml` | 5 files, byte-identical is the requirement | **zero** insertions **and** zero deletions on all five |
| **M-5c** | **dv** | `git diff --numstat` over `test_m04_a.ml`, `test_m04_f.ml`, `test_m04_g.ml`, then the hunks read | 3 files, 2 / 2 / 2 units respectively | **zero deletions** on each, and every insertion in an EOF hunk or a header-docstring addition (§11.4). **This is the bar that keeps the 21 landed units a regression witness for §5.3(6)'s re-expression** |
| **M-6** | **dv** | §6's tables, cell by cell, against the landed source, read **against the computing expression and never against a comment** | — | every derived constant equals the landed assertion, or appears in your Return log as one you disagree with |
| **M-6b** | **dv** | `run_lengths`, `run_frames`, `run_stream`, `present`, `present_stream`, `cycles_for`, `wire_frame` read in full at the landing | — | **observable behaviour unchanged**: `P-ACCEPT` still enforced for single-frame runs; `SP-1`/`SP-2` still enforced for unscheduled streams; the liveness bound unchanged; `cycles_for`'s value `27 + ⌊F/8⌋` at every `p`; `wire_frame`'s two failure messages byte-identical; `assert_instruments_clean_n` = `assert_instruments_scheduled` with both expected sets empty |
| **M-7** | **dv** | file search for `M04-` across `test/**/*.ml` | **31 distinct ids** (`A1`, `A2`, `A3`, `A5`, `B1`–`B5`, `C1`–`C6`, `D1`–`D6`, `E1`–`E5`, `F1`, `F2`, `F5`, `G9`, `G10`) in **173** occurrences, **plus 2 bare `M04-` tokens** (`test_m04_scaffold.ml:1` and `:65`, that unit's own negation) | **39 distinct ids** — the base 31 plus this round's 8 — the 2 bare tokens, and **zero occurrences of any other `M04-` id anywhere in `test/**/*.ml`** |
| **M-8** | worker | Read your `run_scheduled` body, `cycles_for_scheduled_run` and `underflow_event` back in full | — | **Quote all three verbatim in your return**, and state **in which single expression** `⌊F/8⌋` lives, **in which single function** the conservation rule lives, and **in which single function** §0.6's window is computed. Two occurrences of any of the three is a defect even if both are currently equal |
| **M-9** | worker | §4's abort law against SPEC-M04 §9 and §6.1's own cycle table, **by hand**, at **U22's `w = 1`** and at **U27's frame-1 `w = 4`** | — | at U22: `R = C+1`, abort word `C+3`, `8w = 8` octets at `C+2`, terminate lane 1, gap 15 (uncompleted). At U27: `S₁ = C+12`, `R = C+15`, abort word `C+17`, `8w = 32` octets at `C+13 … C+16`, `S₂ = C+19`. **Report the values you derived, not the ones you read here** |
| **M-10** | worker | file search for `let%expect_test` across `test/xgmii_tx_64/`, **per file**, read back | base: scaffold 1, a 2, b 4, c 5, d 3, e 2, f 2, g 2 (**21**) | after: **a 3, f 3, g 6**, and scaffold/b/c/d/e **unchanged at 1/4/5/3/2**. Total **27**. **Report the raw per-file numbers** |
| **M-11** | worker | file search for `[%expect` across `test/xgmii_tx_64/`, then Read each hit | **21** blocks in the `.ml` files (a 2, b 4, c 5, d 3, e 2, f 2, g 2, scaffold 1); **20 empty, 1 carrying U13's promoted oracle value**. *(One further `[%expect]` occurrence at `dune:38` is prose in a comment and is not a block — read it and do not count it)* | **27** blocks, and **every block you write is `[%expect {||}]`, empty**. The 21 landed blocks are untouched, U13's promoted content included. **You hand-author no snapshot content whatever** (`BM18`). Report the raw count |
| **M-12** | worker | Read each of the six new unit titles back in full, and the `=` line after each | — | each contains its own row ids and **no other `M04-` identifier**; each `=` is alone on its own line |
| **M-13** | worker | file search for `tready` across `test/xgmii_tx_64/*.ml`, **then Read every hit** | **11** hits: `bench.ml:108` (the ref), `:133` (a comment), `:135` (**the read**), `:139` (the acceptance decision), `:325` (a comment); `test_m04_g.ml:14, :15, :79, :82, :83, :327` (all comment prose) | **unchanged in kind**: still exactly one read site, in `sample_cycle`, named by file and line; **no new read site**; **no unit asserts a value of it** (`BM11`) |
| **M-14** | worker | Read every scan you wrote, and quote its domain expression | — | every content scan on a **normal** frame runs over `0 … F−5` with `F−4 … F−1` excluded and the reason in the comment; every content scan on an **aborted** frame runs over all `8w` indices **with the comment saying there is no FCS to exclude**; every idle scan runs over §6.0(c)'s stated lanes and stops before the next start character. **Quote each domain expression** |
| **M-15** | worker | `ocamlc -stop-after parsing` on the five OCaml files you wrote or edited | — | exit 0 for each. **Parse is not the adjudicator; M-2 is** — it establishes syntax and nothing about types, and you should say so rather than let a green parse stand in for a build |
| **M-16** | worker | your own journal `Inputs` section, read back | — | no `libs/**`, `top/**`, `bin/**`, `rtl_snapshots/**` or `test/third_party/**` path |
| **M-17** | worker | file search for infix ` mod ` across `test/xgmii_tx_64/` | **6** occurrences, **all non-expression**: `bench.mli:151` (docstring), `test_m04_b.ml:255`, `:394`, `:404` (string literals), `:386` (a comment), `test_m04_e.ml:14` (docstring) | **zero occurrences in an expression position.** Stated as an expression bar and not as a count, because all six base hits are legitimate. **Read every hit.** §4.5 |
| **M-18** | worker | file search for `print`/`printf`/`print_s`/`Stdio`/`Stdlib.print` across `test/xgmii_tx_64/`, then Read every hit | **10** occurrences, **all in `test_m04_d.ml`**, of which **exactly one is a call site**: `Stdlib.print_string` at `:362`. The other nine are that unit's own comment and title prose | **unchanged: still exactly one printing call site in the whole directory, and it is not yours.** This round prints nothing (§6.0(d)) |
| **M-19** | worker + **dv** | Read `bench.mli`'s 16 landed values back and compare to the base file | **16** exported values (`grep -c '^val '`) | **19** plus the `Stall` module; **every existing signature byte-identical**; the only changes are the additions and their docstrings. dv re-checks by diff |
| **M-20** | worker | Read your scheduled-run precondition code back and quote it | — | **`ST-1`, `ST-2` and `ST-3` present; no contiguity check anywhere in the scheduled path; no acceptance-cycle claim for any word offered at or after the withheld cycle**; and `P-ACCEPT` and `SP-2` still present and reachable on their own paths. **State in one sentence why `SP-2` would fail a conformant M04 here** (§4.2, §5.3(5)) |
| **M-21** | worker + **dv** | file search for `not_before`/`not_after` across `test/xgmii_tx_64/` | **0** occurrences | **exactly two occurrences, both inside `underflow_event`'s single expression.** No unit computes a window, and **no unit asserts that a pulse lies inside one** (§6.0(e), `BM20`). **Quote the function** |
| **M-22** | worker | Read every `assert_instruments_scheduled` call site you wrote and quote its `~underflowed` argument | — | **every one is a list of positions, never a count, and never `[]` where a frame aborted.** U27's is `[1]` and not `[0]` — state that you checked which frame aborted rather than that one did (§5.3(6) check 4) |

---

## 13. BOUNCE conditions — pre-committed

- **`BM1` — any unit in `test/**` is red at CI at the landing commit for a reason
  in §15's classes D4a–D4d, or for any reason not in §15's table at all.**
  General by construction. **D1, D2, D3 and D5 are expressly NOT bounces** — they
  are the round working, and they are adjudicated by me.
- **`BM2` — `sample_cycle`'s ordering is altered**, or any new read of an
  `After`-view output is introduced. §5.2, trap T1.
- **`BM3` — a value ordered checked whose expected value this packet does not
  supply.** If you find one, that is **my** defect — **report it, do not invent
  the number.** Reporting it is not a bounce; adopting an invented value is.
- **`BM4` — a WRONG ASSERTED VALUE.** Any constant this packet derives in §4 or
  §6 written into the source with a different value, without the disagreement
  being reported.
- **`BM5` — a `Clear` or `Enable` schedule type is built, or a `cfg_ifg` /
  `cfg_tx_enable` parameterisation, or a handover-release scheduler, or a
  multi-stall schedule.** Capabilities land with their first consumer and none of
  the four has one here (§1.4, §5.4).
- **`BM6` — a REQ-016 idle-injection wrapper is built at M04's source port**, or
  a withholding is placed at a between-frames handover. §9.4. **Note that this
  condition CHANGED shape at this packet**: withholding a word mid-frame is this
  round's commissioned stimulus and is no longer a bounce; the normative
  prohibition SPEC-M04 §7 states is what survives, in the form §9.4 gives it.
  **Read §9.4 before you read this line.**
- **`BM7` — any assertion, comment, title or Return-log sentence names an
  absolute cycle measured from cycle 0, from reset, or from the release of
  `clear`, rather than from `C`.** `M04-A5`, round-wide.
- **`BM8` — a claim of coverage this round does not have.** Specifically: the
  underflow requirement described as covered; the family's highest-value row (the
  faithful partial reading) named or described as discharged; family F or family
  G described as complete; any family-H, family-I, family-K or family-L row named
  anywhere in `test/**` (bar M-7) or described as discharged; REQ-209's cadence
  claimed or a start spacing asserted; family D's rows described as re-discharged
  by U25 or U27; the standing decoder's own REQ-202 or REQ-204 verdict reported
  as this round's coverage; `T-3` or `T-7` described as fully discharged (§5.4).
  **The rule that makes this condition survivable is *in the packet, name the
  row; in `test/**`, describe it*** — stated at §1.4, §5.4, §9.8 and §11.1, at
  every demand that produces the sentence, because a disclaimer naming the row it
  disclaims **is** a claim of coverage in the map built from those titles.
- **`BM9` — an `Octet_time.Latency` tagger is instantiated**, or any latency
  figure for M04 appears anywhere in your output.
- **`BM10` — `tstrb` or `tuser` is varied across runs.** That is family M's
  differential stimulus and half-performing it is worse than not performing it.
- **`BM11` — any unit asserts a value of `tx_tready`.** Reading the
  **acceptance** is the bench's; asserting a per-cycle `tready` value is family
  H's. **§4.2's derivation cites C-14.1 and C-16 repeatedly; citing a clause is
  not asserting a value, and the distinction is the whole of this condition.**
- **`BM12` — an expected value is taken from the design's own output**, from a
  loopback, from a co-simulation result, **or hand-written as a literal where
  this packet says it is computed from the oracle**; or any file is created under
  `test/cosim/`.
- **`BM13` — the round drives more than 700 cycles or elaborates more than
  8 times.** §10.
- **`BM14` — any file outside §11.2's six appears in your write record**, or any
  of the five untouched landed `test_m04_*.ml` files is modified, **or any
  deletion appears in any of the three appended files** (§11.4), or any of the 17
  files under `test/xgmii_rx_64/` is modified.
- **`BM15` — `libs/**`, `top/**`, `bin/**`, `rtl_snapshots/**` or
  `test/third_party/**` appears in your `Inputs`, your Return log or your write
  record.** PROTOCOL §10.
- **`BM16` — an instrument outside §17's allow-list is used**, or an attempt at
  one is disclosed **only** in chat and not in your journal. §17.2.
- **`BM17` — the tripwire, STANDING and armed by condition.** `RV-0080B-VERDICT`
  §5 undertook that **once (a)** an enumerated tool allow-list stands at the head
  of your spawn prompt **and (b)** §17.1 carries the spawn-precheck carve-out by
  name, **a further instrument-outside-the-list instance is a bounce on its own,
  disclosed or not**. **(b) is satisfied by this packet — §17.1 below, item 4.**
  **(a) is the orchestrator's and is measured, never assumed**: §18 item 9
  requires your return to state whether your spawn prompt carried such a list and
  to quote its first line. **If it did, `BM17` is armed for this round.** If it
  did not, `BM17` is **not** armed and the finding escalates upward rather than
  being charged to you. **Disclosure is credited in full either way and under
  both branches** — the tripwire changes the consequence of a violation, never
  the value of disclosing one. **§20 states what the spawn prompt must carry so
  that (a) is satisfiable rather than accidental.**
- **`BM18` — any `[%expect]` block you write carries content**, or output differs
  between runs. **This round commissions no printed value** (§6.0(d)), so there
  is no class-P exception to reach for.
- **`BM19` — a landed path's observable behaviour changes.** `P-ACCEPT` removed,
  weakened or made conditional in a way that stops it firing for
  `run_lengths`/`run_frames`; `SP-1`/`SP-2` likewise for `run_stream`; the
  liveness bound altered; `cycles_for`'s value moved at any `p`; `wire_frame`'s
  or `assert_instruments_clean_n`'s **failure behaviour** changed at empty
  expected sets. **"Failure behaviour" is the firing conditions and their order,
  NOT the message text**: §5.3(6) orders the re-expression that moves two
  messages, and the messages permitted to move are named at §5.2's third bullet.
  A literal reading over the text would convict you of executing the packet.
- **`BM20` — a §0.6 window is computed anywhere but inside `underflow_event`**,
  or any unit asserts that a pulse lies inside a window rather than on §9's pin.
  §6.0(e), §4.2 fact 6, bar M-21. **The prohibition is `AP-M04` obligation 5's
  and this round's form of it is stricter than last round's, not looser.**
- **`BM21` — an aborted frame is asserted to carry an FCS, a pad octet, or a
  wire length of `max(8w, 60) + 4`.** §4.2 fact 4. **This is the one bounce
  condition whose violation would look like care**, which is why it has its own
  line rather than living inside `BM4`.

---

## 14. Traps — named so they are not discovered

- **T1 — `sample_cycle`'s `Before` view is the acceptance decision.** You are not
  changing it, and nothing you add may read an `After` view: an `After` read
  shifts `C` by one cycle and every constant in §6 with it, silently, against a
  conformant design.
- **T2 — `C` is not 2**, and asserting that it is fails no design today and
  freezes an unconstrained value into a snapshot tomorrow (SPEC-M04 §6.3 item 4).
  Observe `C`, assert nothing about it.
- **T3 — a frame after the first is anchored on its START CHARACTER, not on its
  own first acceptance.** §4.1. A bench computing frame `k ≥ 2`'s cycles from
  its own first acceptance is wrong by two cycles at `P = 60` — and after an
  abort it is wrong by an **unconstrained** amount, because §4.2 fact 8 leaves
  that acceptance free.
- **T4 — `P-ACCEPT` does not generalise and neither does `SP-2`.** §4.2 fact 4:
  under `Abandon` the words the schedule abandons are never accepted, so
  `accepted = offered` is false against a conformant design. `ST-3` is the
  replacement and its `abandoned` is the schedule's own declared count.
- **T5 — obligation 6's contract check runs PER FRAME, before concatenation**,
  and it runs over the **full** word list of every element including the words a
  schedule will drop (T20).
- **T6 — the landed `assert_instruments_clean_n` FAILS on any run with an
  abort**, in two of its four checks, by design (§5.1). A scheduled unit that
  calls it gets a failure whose text is about a strobe count and an underflowed
  frame and whose cause is that you called the wrong function. Call
  `assert_instruments_scheduled`.
- **T9 — `Frame.pad_to_60` does not append an FCS.** The expected wire octets of
  a **normal** frame are `Frame.with_fcs (Frame.pad_to_60 content)` — the pad
  **inside** the FCS computation.
- **T11 — the FCS octets are a computed value and may equal anything**, which is
  why every content scan on a **normal** frame excludes indices `F−4 … F−1`.
- **T12 — the poisoned `tkeep`-0 positions are still there.** `source_words`
  poisons them with `0xA5` on every run. They are not frame octets and must not
  appear on the wire.
- **T13 — the gap is measured from the terminate character INCLUSIVE**, and for
  an aborted frame the terminate character is the **`/T/` at lane 1**, not the
  `/E/` at lane 0. Measuring from the `/E/` gives 16 instead of 15 and passes
  every `≥ cfg_ifg` check. `M04-F6`'s whole content.
- **T14 — a green silence on a run that is not the stimulus is not a result.**
  `ST-2` is the general defence; every unit inherits it.
- **T20 — the contents element is a legal frame and the SCHEDULE truncates the
  OFFER.** A worker who "helpfully" builds the withheld frame as a partial word
  list has changed the stimulus into an illegal one and obligation 6 will reject
  it. §5.3(2) step 1.
- **T21 — AN ABORTED FRAME IS NOT PADDED AND CARRIES NO FCS.** §4.2 fact 4:
  §6.2's `Frame → Abort` transition bypasses `Pad` and `Fcs` entirely. `M04-G5`'s
  aborted frame is **8** octets on the wire. **Every instinct trained by the
  previous five M04 rounds says 64**, and every one of those rounds was right
  about a frame that terminated normally. `BM21`.
- **T22 — you may not assert WHEN a word offered after the abort is accepted.**
  §4.2 fact 8. The **start character** is pinned by REQ-204's rounding and is
  yours to assert; the acceptance behind it is unconstrained by §6.3 item 3 and
  an assertion over it fails a conformant design.
- **T23 — the tail-frame's content is a SUFFIX, not a fresh `content_octets`.**
  §4.3 consequence 2. `content_octets ~p:754` is not octets 760–1513 of
  `content_octets ~p:1514`, because 127 does not divide 760. **The failure looks
  like an FCS defect and is a stimulus defect**, and it will be reported as a
  family-D regression by anyone who does not read this line.
- **T24 — under `Resume` the withheld frame's `tlast` word IS accepted, and it
  closes the TAIL.** §4.3. A conservation rule keyed on `tlast` counts one frame
  where two reached the wire. This is `M04-G8`'s content, not a hazard to avoid —
  but a bench that keyed its own count on `tlast` would assert the wrong number
  and call the design wrong.
- **T25 — this round drives past three families and must claim none of them.**
  U27 drives three frames at a cadence; every run drives cycles family H's rows
  own; U25 and U27 drive frames whose FCS family D owns. **Driving a stimulus is
  not claiming a row**, and the distinction is kept by not naming the row and not
  asserting the neighbour's observable (`BM8`, bar M-7).
- **T26 — `hold` changes the gap.** U26's gap is **15** and U24's is **23**, from
  the same abort word, because U24's `hold = 4` puts the resume past the gap's
  last cycle (§4.2 fact 7 branch (b)). **A unit that carried 15 into U24 would be
  importing another row's figure into a run whose schedule forbids it.**
- **T27 — a red in this round has more meanings than in any previous one, and
  only two of them are yours.** §15, and read the class-D2 row first: this is the
  first round in the programme to run the decoder's gap arithmetic on a terminate
  character produced by an abort. Do not repair a suspected design defect, do not
  repair a suspected instrument defect, do not adjust an expected value to make a
  run agree, and do not hand-author a snapshot to make a diff go away.

---

## 15. Disposition classes for a red — PRE-COMMITTED

Written before the run, so that adjudication is not decided by whichever
explanation is most convenient afterwards.

**Naming, because two namespaces overlap**: disposition classes are written
**`class D1`, `class D2`, …**; plan rows are written **`M04-G1` … `M04-A4`**.
This packet always writes the prefix.

| Class | What it looks like | Whose | Bounce? |
|---|---|---|---|
| **class D1** | A row's assertion fails and this packet's derived constant for it is right | a **design** defect. I open a `BUG-` to rtl_lead | **No** |
| **class D2** | **A defect in a STANDING INSTRUMENT rather than in the design or in a unit** — the wire decoder, the strobe monitor, the FCS oracle and its `Frame` wrappers. **This round's specific exposure, measured rather than asserted**: `test/xgmii/test_tx_decoder.ml`'s underflow unit establishes that the decoder recognises §9's word, sets `underflowed`, reports `octets` without an FCS and puts `terminate_lane` at 1 — but **its trace ends in idle with no next start character, so `gaps` is empty in it and the decoder has NEVER measured a gap that begins at an ABORTED frame's terminate character.** Stage 1's `M04-F2` swept `t = 0 … 7` and measured a 15-octet gap at `t = 1` from a **normally** terminated frame, so the lane-1 arithmetic itself is CI-proven; **what is unproven is whether the abort path hands the gap counter the same terminate lane.** `M04-F6` is the row that runs it first | **dv_lead's, for every instrument.** Each has its own unit suite and I re-run it | **No** |
| **class D2a** | `Tx_decoder.violations` non-empty, with a REQ named | a **design** defect **or** class D2 — mine to separate, and the separation is the act, not the classification | **No** |
| **class D3a** | `P-ACCEPT` fires on a **single-frame** run, or `SP-1`/`SP-2` on an **unscheduled** stream | §5.3's re-expression broke a landed path. **Mine** | **No** |
| **class D3b** | **`ST-3` fires**: the accepted count differs from `Σ W_k − abandoned` | either the design stalls where the specification forbids it, or `cycles_for_scheduled_run`'s allowance is short, or my `abandoned` derivation is wrong — **mine to separate**, and two of the three are defects in this packet. **Every row assertion downstream is meaningless and must not be read** | **No** |
| **class D3c** | **`ST-2` fires**: the bench did not withhold where the schedule said | a **bench** defect in the withholding predicate, **or** a defect in my `word ≥ 1` / `word ≥ 2` legality rules. **The unit's every strobe and silence assertion is VOID if this fires** — the run is not a stall run (trap T14). **Mine to separate; the bench half is a bounce only if it is a coding error rather than a specification-reading one** | **No**, adjudicated |
| **class D4a** | A compile error | bench | **Yes** (`BM1`) |
| **class D4b** | An exception from the bench's own code — an out-of-range index, a `failwith` from a helper, a `Frame` builder raising | bench | **Yes** |
| **class D4c** | **A non-empty `[%expect]` block you wrote**, or output that differs between runs | bench | **Yes** (`BM18`) |
| **class D4d** | A stimulus-contract violation caught by obligation 6's own check, **or a schedule-legality violation caught by §5.3(2) step 2** | bench | **Yes** |
| **class D5** | You derive a constant of §4 or §6 and get a different number, and **report it** | the round working. Credited in full | **No** |
| **class P** | **A promotion** — CI's diff on an `[%expect]` block | **NOT REACHABLE THIS ROUND.** No printed value is commissioned (§6.0(d)), so every block is empty by design and stays empty; **any diff at all is `D4c` and a bounce.** The class is listed to say that it is closed | — |

**Why class D2 is written first among the non-bounce classes this round, against
every previous packet's ordering.** Every M04 round so far has run the standing
decoder on frames that terminated normally. **This round runs three of its paths
in anger for the first time** — the abort recognition on live design output, the
`underflowed` field on live output, and the gap that begins at an abort's
terminate character — and the third of those has no unit-suite coverage at all
(the row above states exactly what was read to establish that). **A `M04-F6`
failure at 16 instead of 15 is as likely to be the decoder as the design**, and
routing it to a `BUG-` without separating them would be a finding against me, not
against rtl_lead.

**class D5 is the class several rounds of this chain were actually decided by**,
each by a defect in my instructions rather than in the work. **§4 is the largest
single block of hand derivation this chain has issued and it has never been
executed against anything**, so I expect this class and I would rather have it
than not.

---

## 16. Incremental-write and expected-CI discipline

### 16.1 Order of work

**One round, one worker, one commit**, with the internal order staged so that
stopping early stops at a coherent point.

1. `bench.mli` then `bench.ml` — §5.3's additions and its one re-expression.
   **This is the only change that can break something already green**, so it goes
   first and alone.
2. `test_m04_g.ml` — U22 first (the simplest abort run and every later unit's
   shape follows it), then U23, U24, U25.
3. `test_m04_f.ml` — U26, appended.
4. `test_m04_a.ml` — U27, appended. **Last, because its derivation composes the
   handover cadence with the abort law and you want every other unit's shape
   already written.**
5. `dune` — the header row line, when the row list is final.

### 16.2 The five standing rules for a bench in this programme

1. **Every `[%expect]` block you write is EMPTY** (ADR-0005 rule 2). Snapshots
   are promoted from CI's own diff output, never hand-authored. **A hand-written
   snapshot is fabricated evidence.** This round writes no printed value at all.
2. **Every verdict is asserted in OCaml** — `failwith`, `raise`, or a checked
   counter — so that a promotion which captured wrong output still leaves a red
   test.
3. **No waveform snapshots and no timing figures inside `[%expect]`.**
4. **Name every unit after its rows** (§11.1) — the `SO-` coverage map is built
   from these titles by hand.
5. **`tools/precompile_check.sh` does NOT cover this directory** and is outside
   your allow-list anyway. **For this directory CI is the only compiler**
   (ADR-0005), which is exactly why rule 1 exists.

### 16.3 The expected-CI discipline — checked versus predicted

Your Return log must state, **before the run happens**, what you expect CI to do,
and must distinguish *checked* from *predicted*. The house rule: **where a claim
is checkable, run the check; where it is not, write "unverified" and say why.**

**State separately**: (a) `dune build @default`; (b) `dune runtest` — **and this
round the prediction is GREEN on its first reaching, with an empty diff**,
because no printed value is commissioned; **say so explicitly and say what it
would mean if a diff appeared** (`D4c`, a bounce, `BM18`); (c) the step *"Verify
nothing was left unpromoted or non-deterministic"*; (d) **the list of names you
could not check locally**.

**Start list (d) with these:**

1. **Every arithmetic operator whose spelling differs between the stdlib and
   `Base`** — `mod` is the one that bounced `WO-0080`, and the general form of
   the hazard is *a familiar spelling that means something else here*. `Int.rem`,
   `Int.max`, `Int.( / )`, comparison operators on non-`int` types, and
   `List.equal`'s explicit element-equality argument all live in that class.
   **Add to it this round: the ceiling `(a + t + 7) / 8`, which has no operator
   at all** (§4.5).
2. **`Dv_monitors.Strobe_monitor.expect`, its `event` record's six fields, and
   `is_clean`'s exact semantics** — **landed, unit-tested, and never yet called
   from this directory with a non-empty expected set** (`WO-0082` §6.0(e)
   expected zero events; this round is the first M04 consumer of `expect` at
   all).
3. **`Tx_decoder.frame.underflowed` read from a LIVE run**, and
   `Tx_decoder.gaps` across an abort word — §15's class-D2 exposure.
4. Whatever you use to take a suffix of an octet list (§4.3), to index the
   acceptance list, and to compare two `Xgmii_word.lane` values.
5. Any `Xgmii_word` accessor you use for the first time here — in particular
   `lane`, `is_control` and the four character constants.

---

## 17. Your terms — the allow-list, inherited verbatim

**Read this preamble; it is the standing repair of a structural defect and not
boilerplate.**

For six rounds a worker on this chain met a **forced violation**: a §17.1 that
forbade every `git` subcommand while the orchestrator's spawn dispatch
**mandated** two of them as an abort-first precheck. Six instances, six
disclosures, zero concealments. `RV-0080-VERDICT` §6 ruled that *a rule that
forces a violation and then convicts it is worse than the violation*; the
carve-out was promised, not made, and `FINDING WO-0080-6` (MATERIAL, mine)
convicted me of that. **`WO-0081` §17.1 made it, and that round produced the
chain's first zero-lapse result. `WO-0082` Revision B added the plumbing clause
and the `date -u` carve-out.** This packet carries **that five-item form,
inherited verbatim**, because it worked.

> **The one substitution, marked rather than made silently.** Item 2's text
> reads *"the seven paths §11.2 names"* in the source it is inherited from, and
> **this packet's §11.2 names six**. The numeral is the only change, it is marked
> **[six]** in place below, and **nothing else in the five items moves by a
> character.** An unmarked edit inside a passage declared *inherited verbatim* is
> the class of defect this chain has convicted twice; marking it costs one line.

### 17.1 The allow-list

Your permitted instruments are, in full:

1. **File read** — reading any file in the repository *except* the paths §8
   forbids, and file/content search over it (the Read, Grep and Glob tools).
2. **File edit and write** — **only** at the **[six]** paths §11.2 names, plus
   this packet's Return log, plus your own journal at
   `agents/journals/workers/claude_tb_writer_agent*.md`.
3. **`ocamlc -stop-after parsing`** on the OCaml files you wrote or edited.

   **What is inside this item, written here so no seat has to derive it**
   (`J-dv_lead-0191` §4(b), correction 2; the ruling was made on a disclosure the
   worker filed against its own interest). **Inside**: (i) observing the **exit
   status** of this invocation — `; echo "EXIT:$?"` or any equivalent — because
   bar `M-15` demands you report *exit 0 for each*, and a permission to run a
   command while withholding the permission to observe whether it succeeded is
   not a permission to discharge that bar; (ii) **redirecting this invocation's
   own streams** (`2>&1`); (iii) **repeating this invocation over the file set a
   bar names** (a `for` loop over those files). **Still outside, and
   unaffected**: any pipeline that transforms, searches, filters or reads
   repository content — `| grep`, `| wc`, `cat`, `find`, `ls`, `sed`, `awk` —
   *regardless of what command it is attached to*. **The distinction is between
   plumbing around a sanctioned invocation and an instrument that reads the
   tree**: (i)–(iii) observe nothing about this repository that `ocamlc` did not
   itself produce, and the prohibitions this list names exist so that a bar
   phrased as a search is executed with the file-search tool and by **reading the
   hits**, leaving your reads visible.
4. **The two spawn-precheck commands your dispatch mandates, by name:
   `git status --short` and `git rev-parse HEAD`.** Each **once**, at the head of
   your round, **before anything is read**, with their output quoted in your
   journal's Trigger section.
5. **`date -u`, once, at the moment you author your journal entry's header
   stamp** (`J-dv_lead-0189`'s ruling; `J-dv_lead-0191` §6 item 1). Record the
   reading in your journal's Evidence section as the command and its output.
   **Why it is carved rather than left to judgement**: PROTOCOL §4.1 requires
   every entry to carry a UTC ISO-8601 stamp, and a seat required to produce one
   while forbidden to read a clock will estimate — **two consecutive entries of
   this chain carry a self-qualified stamp for exactly that reason**, both
   honestly labelled, neither avoidable. A rule that forces a violation and then
   convicts it is worse than the violation (`RV-0080-VERDICT` §6); this is the
   third instrument that rule has now carved, after the two prechecks and the
   plumbing clause above. **An estimated stamp remains honest and remains
   creditable** — the carve-out removes the need for one, it does not convict the
   rounds that made one.

**Everything else is forbidden**: every **other** `git` subcommand — `diff`,
`show`, `log`, `add`, `stash`, and `status` a **second** time — `dune` (every
subcommand, ADR-0005), `tools/*.sh` (every script), the network in every form,
and **any other shell command whatsoever**, including `grep`, `sed`, `awk`,
`cat`, `find`, `ls` and `wc`. Where §12 gives you a bar phrased as a search,
execute it with the file-search tool and by **reading the hits**, never with a
shell pipeline. **The carve-outs are exactly items 3's (i)–(iii), 4 and 5 above —
enumerated, bounded, and each with the obligation it exists to make
dischargeable. Nothing else is read into this list, and a seat that thinks it
needs a further instrument stops and says so (the closing rule below) rather than
deriving a permission from the shape of these.**

**The carve-out is exactly two commands at exactly one point, and §17.3 is
unchanged by it.** The precheck is an abort-first check on the substrate *before
you write anything*. A `git status` run *after* your edits, to enumerate what you
wrote, is a different act with a different purpose and it remains forbidden by
name — see §17.3, which the carve-out does not touch.

**Flag, do not improvise.** If a bar in §12 appears to you to need an instrument
outside this list, **stop and say so in your return and in your journal**. Do not
find a way around it and do not substitute a weaker instrument silently. A bar
that cannot be executed at your seat is my defect, and it is one I want reported.

### 17.2 The durability clause — a return demand

**If you attempt an instrument outside your seat and are refused — by the
environment, by a permission prompt, or by your own judgement mid-command — that
attempt goes into your JOURNAL** (Evidence or Open-questions), not only into your
return message. A disclosure that lives only in chat does not survive the
session: `RV-0071-VERDICT` §3 had to withdraw a claim because a previous round's
disclosure was chat-only and the evidence was unrecoverable. **Disclosure is
credited in full either way**, and under both branches of `BM17`; the point is
that the credit must be readable from the repo.

### 17.3 The substitution clause

You cannot enumerate your own staged set and **must not reach for `git status` to
try** — the carve-out at §17.1 item 4 is the *pre*-round precheck and is not a
licence for this. Your instrument for the files-list obligation (PROTOCOL §4.2,
and §18 item 5) is **your own record of what you wrote, with §11.2's list as the
authority**. That is the sanctioned substitute, it is sufficient, and it is not a
second-best. Likewise you cannot compare against the base tree: **every base-side
figure any bar needs is pre-committed in §12's base column**, so you check against
this packet and never against history.

---

## 18. Your return

Append a `### RETURN — tb_writer, spawn <short-id>` section to this packet's
Return log carrying, in this order:

1. **What you built**, file by file, against §11.2's six — and for the three
   appended files, **state explicitly that your edit added lines and removed
   none**, with the hunk count per file.
2. **Every bar in §12 marked *worker*, with its raw output or the exact lines you
   read** — `M-8` through `M-22`. Quote, do not summarise, where the bar says
   *quote*.
3. **Every constant of §4 and §6 you checked, and every one you disagree with.**
   A disagreement with any number of mine is a finding I want. **Do not adopt a
   number of mine you cannot derive; report it** (`BM3`, class D5). **§4's abort
   law has never been executed against anything — if any of its eight facts
   reads wrong to you against SPEC-M04's own text, say so before you write a
   unit around it.**
4. **The verbatim `run_scheduled` body, `cycles_for_scheduled_run`,
   `underflow_event` and the `ST-1` … `ST-4` code** that `M-8`, `M-20` and `M-21`
   demand, plus the **single expression** holding `⌊F/8⌋`, the **single
   function** holding the conservation rule, and the **single function** holding
   the §0.6 window.
5. **Your files list**, from your own write record with §11.2 as the authority
   (§17.3), and your journal entry id.
6. **Your expected-CI statement** (§16.3), with *checked* and *predicted*
   separated, the unchecked-names list, and **the explicit prediction that
   `dune runtest` is GREEN on its first reaching with an empty diff** — and what
   a non-empty diff would mean.
7. **Any instrument you attempted outside §17.1's list, and its outcome** — in
   your journal as well as here (§17.2).
8. **Anything in this packet you could not execute as written**, and anything in
   §5.1's capability table you found to be wrong in either direction (§9.3).
9. **The tripwire's arming condition, measured** (`BM17`, §13): state whether the
   spawn prompt you were given carried **an enumerated tool allow-list at its
   head**, and **quote its first line** if it did. This is a factual report about
   your own dispatch, it is not a judgement about anyone's conduct, and it is the
   one input `BM17`'s arming turns on — I will not infer it.

**What you do not do**: run `dune`; run any `git` subcommand beyond §17.1 item
4's two; touch a seventh source file; delete a byte from any of the three
appended files; modify any of the five untouched landed `test_m04_*.ml` files;
adjust a constant to make something agree; hand-author a snapshot; open
`libs/**`; claim coverage `BM8` forbids; or judge whether a unit will pass.
**The verdict is CI's and the adjudication is mine.**

---

## 19. What this round does NOT carry, and what I owe after it

### 19.1 What this round does not close

- **No `SO-xgmii_tx_64.md`.** After this round 8 more rows discharge, taking the
  plan to **43 of 82 outstanding**. `BAR T1` stays SHUT and the sign-off is not
  opened or offered.
- **REQ-206 is not covered** and this round does not describe it as covered
  (§9.8).
- **Family F does not complete; family G does not complete.** §1.4.
- **`T-3` is discharged in both halves; `T-7` is not.** §5.4 names the residue.
- **The mutation campaign for these rows is not scheduled here.** PROTOCOL §10
  sequences it after the `RV-` ACCEPT and before any `SO-` PASS; scheduling is
  the orchestrator's and my recommendation remains the per-family cadence.

### 19.2 What I owe after this round — mine, named with their carriers

1. **`M04-G4`**, the family's highest-value row, **held back from this round for
   one round only and needing nothing built** (§1.4). It is the cheapest
   outstanding row at M04 and it should ride the next M04 packet whatever that
   packet's axis is. Mine, and I am recording it here so it is a debt with a
   carrier rather than a row that fell between two stages.
2. **`DVC-1a`, the M04 row-status census in `tools/dv_checks.sh`** — still
   unbuilt, now wanted by three plans, and **it should land before any `SO-`
   quotes an M04 coverage fraction**. Every M04 count in this packet is a hand
   count with its method stated (§9.7). Mine, `tools/**`.
3. **The transmit-side conservation monitor** (`AP-M04` §7 item **T-2**) — the
   bench still carries the counting rule itself, and this round makes the case
   for the monitor stronger rather than weaker: §4.3's tail-frame is a live
   instance of the `tlast`-keying defect obligation 3 warns about. Mine,
   `test/monitors/**`.
4. **The absorption acts, which are mine and not this packet's**: `AP-M04` §9's
   change-log row for whatever this round discharges, `T-3`'s state cell moved
   to the extent measured, and `M04-G10`'s and `T-7`'s cells left alone — all at
   the `RV-`, none of them here, and none of them assumed by anything above.
5. **The three `BAR T1` work orders** — vendoring the transmit reference at a pin
   (its own commit, ADR-0015 D2), a transmit harness and canonical form, and
   REQ-901's divergence classes. Orchestrator, as scheduling.

### 19.3 The two things this packet is the discharge of, stated so the next auditor can check them

- **`AP-M04` §7 item `T-3`(ii)'s oracle.** The plan recorded that *nothing
  derives, from a stall schedule, the expected strobe cycle, the `/E/` word's
  cycle and the truncated octet count*, and recorded the disposition that
  *family G hand-derives all three from §9 and §6.1*. **§4 is that derivation**,
  fixed in the packet before the round rather than left to the worker, with every
  step cited to the specification's own text and with §4.2 fact 8 naming what it
  deliberately does **not** fix.
- **`WO-0082` §20.9's enumeration**, item by item: the row set (§2), `T-3`'s
  second half (§4), the derived-constant tables per unit (§6), the run-length
  allowance (§5.3(3)), the cost ceiling (§10), the bars with their base figures
  measured at **this** round's own base (§12), the bounce conditions (§13), and
  the traps (§14). **That enumeration was written by my own seat as the
  checklist this packet would be measured against, and it is reproduced here so
  the measurement is a comparison rather than a recollection.**

---

## 20. What the spawn prompt must quote at its head — `BM17`'s arming condition (a)

**`BM17` arms only if the spawn prompt carries an enumerated tool allow-list at
its head, and that is the orchestrator's act, not this packet's.** §18 item 9
makes the worker report the fact; this section states what the fact must be, so
that arming is a decision rather than an accident.

**The spawn prompt must carry, at its head and before any task text, §17.1's
five items reproduced verbatim** — the numbered list, the *"Everything else is
forbidden"* paragraph that follows it, and the *"Flag, do not improvise"*
paragraph that closes it. **Not a summary, not a cross-reference, not "see §17.1
of your packet."** The undertaking `RV-0080B-VERDICT` §5 made was about an
**enumerated list standing at the head of the prompt**, and a pointer to a list
is not a list: the whole point of the arrangement is that the worker meets the
boundary before it meets the task, in the same message, without a read.

**Three further things the spawn prompt must carry, each because a previous round
of this chain paid for its absence:**

1. **The abort-first precheck, naming `git status --short` and
   `git rev-parse HEAD` and no other `git` subcommand** — the same two commands
   §17.1 item 4 carves in, so that the dispatch and the allow-list name the same
   set. **A dispatch mandating a third command re-creates the forced violation
   the carve-out exists to end**, and the worker is then right to disclose and
   wrong to comply.
2. **The spawn short-id** — work-order id plus spawn UTC timestamp, e.g.
   `WO-0083/2026-08-12T14:00Z` — which PROTOCOL §4.1 requires the worker to copy
   **verbatim** into its journal Trigger. It is the attribution mechanism inside
   a shared template journal and only the orchestrator can mint it.
3. **The head SHA the round is dispatched at**, so the worker's precheck is a
   comparison against a stated expectation rather than a reading with nothing to
   compare to.

**And one thing the spawn prompt must NOT carry**: any path from §8's forbidden
set, in any form — quoted, excerpted, or summarised. `BM15` charges the worker
for such a path appearing in its `Inputs`; a path that arrived in the dispatch
would be a violation the worker could not have avoided, which is the exact shape
`RV-0080-VERDICT` §6 ruled worse than the violation. **This packet's `Context
provided` is the complete list of what the round needs, and it contains no RTL.**

---

## Return / verdict log

*(empty — this packet is a DRAFT and has not been issued)*
