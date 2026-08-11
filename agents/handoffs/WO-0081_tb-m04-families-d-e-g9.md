# WO-0081: the FCS, the terminate sweep, and the one silence a MAJOR bug was found in — families D and E complete, plus `M04-G9`

- **State**: `ISSUED` (dv_lead, `J-dv_lead-0178`, drafted at spawn-head
  `2a0a2b1`). No prior revision.
- **From** / **To**: dv_lead → tb_writer
- **Attack plan**: `test/attack_plans/AP-xgmii_tx_64.md` (**AP-M04**), **frozen
  for this round at `deace39`..`2a0a2b1`** — 82 rows in 15 families, 13
  discharged at `af06c62`, **69 outstanding**. Nothing in that file moves this
  round: the plan was repaired at `J-dv_lead-0177` (`deace39`) and this packet
  reads it, it does not edit it. **This packet commissions 12 rows**:
  `M04-D1`, `M04-D2`, `M04-D3`, `M04-D4`, `M04-D5`, `M04-D6`, `M04-E1`,
  `M04-E2`, `M04-E3`, `M04-E4`, `M04-E5`, `M04-G9`. **Ten ASSERT** (`D1`, `D2`,
  `D3`, `D4`, `D6`, `E1`, `E2`, `E3`, `E4`, `G9`) and **two NO-ASSERT** (`D5`,
  `E5`), counted row by row against the plan's own Status column at this tree —
  the count `FINDING WO-0080-2` convicted me of getting wrong last round, so it
  is measured and not summarised. Read every row **in the plan itself**; §2
  below is an index and the **Observable cell is the contract**.
- **Spec basis**: `docs/specs/modules/xgmii_tx_64.md` (**SPEC-M04**), **FROZEN at
  `f78766e`**, *plus every §13 row* — the frozen text and its recorded diffs
  together are the specification, and its current content is at **`2a0a2b1`**.
  Sections in scope: §6.1 (the normal path, the FCS paragraph's four items, the
  terminate-and-fill paragraph, the gap paragraph, and the cycle-by-cycle
  table), §6.2 (the state table, for `Fcs` and `Gap`), §6.3 items 1, 2 and 4,
  §7 (the timing contract entire), §9 (errors — for `M04-G9` and `M04-E5`),
  §10 (the REQ-202/203/205 hooks), §11.3 and §13. Supporting:
  `docs/specs/requirements.md` §0.3, §0.6, REQ-202, REQ-203, REQ-205, REQ-206,
  REQ-011, REQ-012, REQ-015, REQ-021, REQ-301 … REQ-305; **SPEC-M02 §6.1 +
  ADR-0006** (the finished-value FCS convention — read it, it is this round's
  one genuine conceptual trap, T5).
- **REQ ids this round touches**: **REQ-202** and **REQ-305** (the FCS, family
  D — this is the round that *claims* them, where `WO-0080` only *watched*
  them), **REQ-304** (the residue, as corroboration and never as a second
  anchor), **REQ-205** (terminate placement and fill, family E), **REQ-206**'s
  qualifier clause (`M04-G9`'s silence only — no underflow is driven anywhere in
  this round), and REQ-203 incidentally through every padded frame.
- **Deliverables**: **six staged files** — two extended
  (`test/xgmii_tx_64/bench.mli`, `test/xgmii_tx_64/bench.ml`), one header-only
  edit (`test/xgmii_tx_64/dune`), three new (`test_m04_d.ml`, `test_m04_e.ml`,
  `test_m04_g.ml`) — enumerated at §11.2 and nowhere else, **plus** this
  packet's Return log and your journal entry at
  `agents/journals/workers/claude_tb_writer_agent*.md`. **Eight paths in total.**
- **Definition of done**: every row in §2 mapped to a named `%expect_test` unit
  or explicitly declared not-implemented with a reason; every `[%expect]` block
  **you write** left empty (ADR-0005 rule 2 — see §6.0(d), which is the one
  place this round differs from `WO-0080` and it differs deliberately); every
  verdict asserted in OCaml; every derived constant of §6 present at the site §6
  places it, or reported as disagreed with; Return log filled to §18's shape;
  journal entry appended; no file outside §11.2 touched, and **none of the four
  landed `test_m04_*.ml` files modified**. **No doc impact. No `SO-` packet —
  that is mine (PROTOCOL §3).**
- **Context provided**: the specification sections named above; the attack-plan
  rows; the machinery contracts at §5, quoted from `.mli` files you may read in
  full; the arithmetic identity at §4 and every constant derived from it at §6.
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
| 0 | What this round is, and the one thing it inherits that `WO-0080` had to build |
| 1 | Why this slice — what rides, what is held back, and the one family-G row that rides alone |
| 2 | The twelve rows |
| 3 | The frozen references, by SHA — including the operator file `WO-0080` failed to name |
| 4 | The arithmetic identity — quoted, with its OCaml-notation gloss |
| 5 | The capability layer — what is landed, and the ONE extension this round builds |
| 6 | The derived constants, per unit |
| 7 | How to instantiate the DUT without reading it |
| 8 | What you may NOT read |
| 9 | Regime facts — the standing rules that bind this round, numbered |
| 10 | Cost — the size class, measured, and this round's ceiling |
| 11 | Unit structure and the files this round stages |
| 12 | The review bar — pre-committed, assigned by seat, each executed at the base |
| 13 | BOUNCE conditions — pre-committed, including the armed-by-condition tripwire |
| 14 | Traps — named so they are not discovered |
| 15 | Disposition classes for a red — PRE-COMMITTED, with the instrument class this table lacked |
| 16 | Incremental-write and expected-CI discipline |
| 17 | Your terms — the allow-list, unified with the dispatch precheck at this packet |
| 18 | Your return |
| 19 | What this round does NOT carry, and what I owe after it |

---

## 0. What this round is, and the one thing it inherits that `WO-0080` had to build

`WO-0080` built a capability layer and proved it: `test/xgmii_tx_64/bench.{ml,mli}`
elaborates the DUT, drives a reactive presenter, samples the wire, feeds two
standing instruments and has been green at CI on ten units. **That layer is
landed, unchanged since `af06c62`, and you extend it by exactly one function.**

So the shape of this round is the opposite of the last one. `WO-0080` was a
capability round that carried the cheapest rows available. **This is a coverage
round**: twelve rows, two complete families, and one new function of about
twenty lines. `WO-0080` §1.3 said family D would be next and said why — *"it
needs no new capability at all"* — and that promise is what this packet is
mostly redeeming.

**The one structural fact of this round, and it is about evidence rather than
about the design.** Standing obligation 1 has attached the wire decoder to every
M04 unit since the first one, and that decoder **already judges REQ-202 on every
frame it decodes**: it compares the four octets before the terminate character,
in wire order, against `Frame.fcs` of everything before them. It has been green
for ten units. **That is not coverage of REQ-202 and this round is where the
difference gets paid for.** The decoder's comparison is over the **decoded wire
frame's own octets** — it asks whether the wire is *self-consistent*. Family D's
`M04-D1` compares the wire's FCS against the oracle applied to **the source
frame this bench built and padded**, which the decoder has never seen. A design
that transmitted a corrupted payload and then computed a correct FCS *over the
corruption* passes the decoder on every frame and fails `M04-D1` on the first.
**Write that difference into your unit comments**; it is the whole reason family
D is a round rather than a paragraph, and §1.3 states which rows add what over
the standing instrument, row by row.

---

## 1. Why this slice — what rides, what is held back, and the one family-G row that rides alone

### 1.1 The claim this round makes, in one sentence

**The frame's four FCS octets are the REQ-305 oracle's own value over the padded
source frame, they sit where the arithmetic says they sit, the terminate
character follows them in each of the eight lanes it can occupy, everything after
it is idle — and the one frame shape at which REQ-206's window is empty is
silent.**

### 1.2 The scope rule, unchanged from `WO-0080` and restated because it is what excludes everything below

**Every run in this round drives exactly one frame into an idle transmitter from
a source that presents every word.** One frame, one run, one continuous source,
default configuration (`cfg_ifg` = 12, `cfg_tx_enable` = 1), `clear` driven only
as `create`'s one reset cycle. That rule is already the landed presenter's
behaviour; you are not changing it and `BM5`, `BM6` and `BM10` still forbid the
capabilities that would.

| Excluded | Why it is not in this round |
|---|---|
| `M04-A3` | 100 consecutive frames — needs a **multi-frame presenter**, which no row here needs and which must land with its own first consumer |
| `M04-A4` | drives three *predecessors*, one an underflowed frame — needs family G's stall stimulus |
| `M04-B3` | two frames back to back — a two-frame stimulus |
| family F | every row measures a **gap between two frames** — the same missing capability as `M04-A3`, and the round that builds it should carry all of them at once |
| family G except `M04-G9` | `G1`–`G8` and `G10` assert what a **pulse** does. They need a stall schedule whose *oracle* half does not exist (`AP-M04` §7 item T-3) and, for `G10`, machinery **T-7** which does not exist either. `M04-G9` asserts a **silence** on a clean single-word frame and needs neither — see §1.4 |
| family H | every row asserts a value of `tx_tready`. **This round reads it and asserts no value of it anywhere**, exactly as the last one |
| family I | 10 000 frames — a different size class (§10) |
| family J | latency. Machinery T-4 records that the committed tagger's correspondence does not hold at a *prepending* module, so no tagger is instantiated (`BM9`) |
| families K, L | configuration and `clear` schedules — a capability lands with its first consumer and neither has one here (`BM5`) |
| family M | `tuser`/`tstrb` differential runs. This round drives both **uniformly**, as the landed presenter already does (`BM10`) |
| family N | four STRUCTURAL rows discharged by scripts and a compile, not by a waveform |
| family O | five declared no-stimulus rows. Nothing to drive, by construction |

### 1.3 What rides, and what each row adds over the standing decoder

Family D is **complete** (6 of 6) and family E is **complete** (5 of 5). Two
whole families close, which is the first time that has happened at this module,
and the reason both fit in one round is that neither needs a capability the
landed layer lacks — beyond §5.3's one extension, which two rows of family D
need and which is about twenty lines.

**The honest column is the third one.** Obligation 1's decoder judges REQ-201 …
REQ-206 on every frame already; a row whose kill the decoder would also catch is
still worth commissioning (it states the claim at a named cycle from the bench's
own arithmetic, and the coverage map is built from unit titles), but the packet
says so rather than letting the round look larger than it is.

| Row | What it claims | What it adds over the standing decoder |
|---|---|---|
| `M04-D1` | the four wire FCS octets equal `Frame.fcs (Frame.pad_to_60 content)`, octet for octet in wire order, at eight lengths | **Everything.** The decoder checks the wire against *itself*; D1 checks it against **the source frame the bench built**. A design that corrupts content and recomputes the FCS over the corruption passes the decoder and dies here |
| `M04-D2` | `Frame.residue_ok` over the whole decoded frame | **Nothing D1 does not already kill**, and the plan's own cell says so. It reads the same oracle a second time. **Commissioned as corroboration and forbidden from being reported as a second anchor** (`BM8`) |
| `M04-D3` | two `P = 60` frames differing **only in octet 0** produce **different** FCS values | The decoder is satisfied by any self-consistent FCS whatever range it covers. D3 is the **anti-vacuity partner**: it proves the covered range *begins* where REQ-202 says, and it fails loudly if the two frames are accidentally identical |
| `M04-D4` | the FCS's **lane and cycle** placement — sharing the last frame word at `P = 60`, occupying the next word at `P = 64` | The decoder reads octets in wire order and never asserts *which word* they landed in. A design that pads to a multiple of eight before appending is conformant-looking at `P = 60` and dies at `P = 64` |
| `M04-D5` | **NO-ASSERT.** The CRC enable and its `octet_count` are **not** asserted anywhere, and no report claims a behavioural check of ADR-0007's mechanism at this module | A prohibition on *reporting*, binding this round's units, comments, titles and Return log |
| `M04-D6` | the all-zero 60-octet frame's FCS equals the oracle's value for it, that value is **printed**, and it is **not** `0x00000000` | The seed-instead-of-finished-value kill. The decoder would catch it too — but the row's value is the **anti-vacuity arrangement**: the one stimulus whose content equals the defect's output, driven **beside** the position-dependent frames and never instead of them |
| `M04-E1` | `/T/` at lane `t` of the word at cycle `C + 2 + ⌊F/8⌋`, for `P ∈ {60 … 67}` — **the eight-lane sweep, derived and not sampled** | The decoder judges REQ-205's *fill*, not the terminate character's *placement*. E1 is the plan's own centrepiece derivation and the reason §4's identity exists |
| `M04-E2` | every lane after `t` on the terminate word, and every lane of every word after it, carries `/I/` — **control bit set AND `xgmii_txd` = 0x07** | The decoder judges "carries an idle character"; E2 asserts the **value** at named cycles from the bench's own arithmetic, which is the form §6.3 item 2's normativity of `/I/`'s value asks for |
| `M04-E3` | the `t = 7` member has **no** fill lane and the `t = 0` member has **seven** | The empty-fill boundary. Only `t = 7` distinguishes an unguarded fill loop from a correct one, and only `t = 0` proves the loop runs at all |
| `M04-E4` | `/T/` at lane **6** of the word at cycle `C + 2 + 189`, at `P = 1514` | A lane index computed from a truncated counter: at 1518 octets any counter narrower than 11 bits gives the wrong residue, and every shorter frame in this plan hides it |
| `M04-E5` | **NO-ASSERT.** REQ-205's *"immediately after the last FCS octet"* has **no instance** on an underflowed frame (§9 appends no FCS to one), so no assertion in this round may be written as a universal over terminate characters | The trap **is** the row. A bench asserting REQ-205's placement rule universally fails a conformant M04 on every underflowed frame — the `SCR-M03-I4` shape, recorded before the assertion is written rather than repaired after it goes red |
| `M04-G9` | a **single-word frame** (`W = 1`) transmits intact and `error_underflow` is **0 on every cycle** | See §1.4. This is the row `BUG-0004`'s route 1 has never had |

### 1.4 The one family-G row that rides, and why it can when its family cannot

**`M04-G9` is commissioned here and the ground is not convenience.**

1. **It needs no family-G machinery.** `G1` … `G8` assert that a strobe
   **pulses**, which needs a stall schedule and, worse, the derived oracle for
   one (`AP-M04` §7 item T-3, measured absent). `M04-G9` asserts that the strobe
   is **silent** on a clean frame nobody stalls. Its stimulus is a single-word
   frame presented to an idle transmitter — a shape this round's landed
   presenter drives today, and one `WO-0080` already drove at `P = 1`.
2. **It could not have been commissioned before this round, and that is a fact
   about its Observable rather than about scheduling.** The row's own cell
   requires *"four FCS octets equal to the REQ-305 oracle over the padded 60"*.
   That is family D's instrument. Before this packet no unit compared a wire FCS
   against the oracle over a source frame at all, so the row was not fully
   mountable. **Family D's round is `M04-G9`'s first opportunity**, not its
   second.
3. **It is the row a MAJOR bug's fix has been resting on without.** `BUG-0004`
   was a design defect at exactly this shape, found at `cbbeb76` by a **standing
   instrument on stimuli commissioned for the pad boundary**, closed at
   `af06c62`, and the plan had **no row for it** — which is why `M04-G9` was
   written afterwards (`J-dv_lead-0177`). At `J-dv_lead-0177` §9 I measured that
   the landed bench's `assert_instruments_clean` already meets G9's strobe half
   at `P = 1` and **deliberately did not count it as a discharge**, because a row
   written after a run is not discharged by that run merely because the run would
   have passed it. **This round is where that decision gets made in front of the
   measurement rather than instead of it**: the row gets its own stimulus, its
   own unit, its own content assertions, and an adjudicating verdict.

**What `M04-G9` does not do**: it does not touch `M04-G10` (the pre-loaded
handover at `C + 8`, which needs machinery **T-7** and is not mountable at this
commit), and it does not lift `AP-M04` §0.2 item 4's bar on an `SO-` reporting
REQ-206 coverage. Naming `M04-G10`, or describing REQ-206 as covered, is `BM8`.

### 1.5 Size — the one number that decided the shape

`WO-0038` took 11 rows, `WO-0080` took 13, this takes 12, and §10 measures the
stimulus at **1.08%** of the size class `WO-0070` established. Adding family F or
`M04-A3` would have taken it to 18 rows **and** a new presenter, which is the
combination `RV-C4` §12's scope-widening finding exists to prevent. The
alternative I rejected in writing: folding `M04-E4`'s `P = 1514` run into family
D's unit, which drives that length already and would have saved 216 cycles and
one elaboration. **Refused**: a unit's title is what the `SO-` coverage map is
built from by hand (§9.7(i)), and a title naming rows from two families is read
as one claim. The 216 cycles are 0.2% of the class and the legibility is not.

---

## 2. The twelve rows

Read each row **in `test/attack_plans/AP-xgmii_tx_64.md` at `2a0a2b1`**. The
table below is an index and a unit map, **not** a substitute for the Observable
cell.

| Row | Status | Unit | One-line reminder |
|---|---|---|---|
| **M04-D1** | ASSERT | U11 | The four wire octets at frame indices `F−4 … F−1` equal `Frame.fcs (Frame.pad_to_60 content)`, octet for octet, in wire order, at `P ∈ {1, 20, 59, 60, 61, 64, 67, 1514}` |
| **M04-D2** | ASSERT | U11 | `Frame.residue_ok` over the whole decoded frame is true — **corroboration, not a second anchor** |
| **M04-D4** | ASSERT | U11 | The FCS's lane/cycle placement at every length in the set; `P = 60` (lanes 4–7 of `C+9`) and `P = 64` (lanes 0–3 of `C+10`) are the contrasting pair |
| **M04-D5** | **NO-ASSERT** | U11 (title) + round-wide | The CRC **enable** and its `octet_count` are **NOT** asserted; ADR-0007's mechanism is not claimed as checked at this module |
| **M04-D3** | ASSERT | U12 | Two `P = 60` frames differing only in octet 0 → the two FCS values **differ**, and each equals its own oracle value |
| **M04-D6** | ASSERT | U13 | The all-zero 60-octet frame: FCS equals the oracle's value, that value is **printed**, and it is **not** `0x00000000` |
| **M04-E1** | ASSERT | U14 | `P ∈ {60 … 67}`: `/T/` (0xFD) at lane `t = F mod 8` of the word at cycle `C + 2 + ⌊F/8⌋`, with `xgmii_txc` bit `t` set — eight lanes, **one cycle** |
| **M04-E2** | ASSERT | U14 | Every lane after `t` on the terminate word, and every lane of every word after it to the end of the run, carries `/I/`: control bit set **and** data = **0x07** |
| **M04-E3** | ASSERT | U14 | `P = 67` (`t = 7`, **zero** fill lanes) beside `P = 60` (`t = 0`, **seven**) |
| **M04-E5** | **NO-ASSERT** | U14 (title) + round-wide | REQ-205's placement rule has **no instance** on an underflowed frame; no assertion here is written as a universal over terminate characters |
| **M04-E4** | ASSERT | U15 | `P = 1514`: `/T/` at lane **6** of the word at cycle `C + 2 + 189` |
| **M04-G9** | ASSERT | U16 | `W = 1` (`P ∈ {1, 8}`): the frame transmits intact **and** `error_underflow` is high for **0** cycles — REQ-206's window is provably empty at this shape |

**The two NO-ASSERT rows are not filler and they are not free.** `M04-D5` and
`M04-E5` are prohibitions whose subject is *the whole round*: if any unit,
comment, title or Return-log sentence asserts the CRC enable's mechanism, or
states REQ-205's placement as a universal over terminate characters, the row has
failed even though no assertion of its own fired. Both are named in a unit title
so the coverage map can reach them, and both are restated as BOUNCE conditions
(`BM8`).

---

## 3. The frozen references, by SHA

**Every reference this round derives from is pinned.**

| Reference | Pin | Note |
|---|---|---|
| `test/attack_plans/AP-xgmii_tx_64.md` | **`2a0a2b1`** | The plan of record, 82 rows. Repaired at `deace39` (`J-dv_lead-0177`) and unmodified since. **Read-only this round** |
| `docs/specs/modules/xgmii_tx_64.md` | **FROZEN `f78766e`**, current content at **`2a0a2b1`** | The frozen text **plus every §13 row** is the specification. Rows that bind here: **C-14.1**, **C-14.2**, **C-16** (the `C+8` acceptance — it is why the post-`tlast` cycle is not an underflow), **C-31**, the 2026-08-11 latency row, the 2026-08-11 `AP-M04-2` row, and the 2026-08-11 `ABS-1` correction row at §11.3 |
| `docs/specs/requirements.md` | current content at **`2a0a2b1`** | §0.3, §0.5, §0.6 (**four** reference-word clauses, the fourth with its ground repaired on 2026-08-11 — you need none of it, and §6.0(e) says why), §9.1; REQ-201 … REQ-207; REQ-301 … REQ-305; REQ-011/012/015/021 |
| **`docs/specs/modules/xgmii_tx_64.md` §6.1's FCS paragraph, items 1–4** | as above | **The four items are the whole of this round's FCS contract.** Item 4's *"least significant octet first"* is what REQ-304's residue at the far end depends on, and reversing it is the single most likely defect family D exists to catch |
| `test/xgmii/frame.mli`, `test/golden/crc32_ref.mli` | current | **Read both in full before writing a line of family D.** `crc32_ref.mli`'s *"The value convention"* section is trap **T5** and it is the one place in this round where a correct-looking number is wrong |
| `test/xgmii/tx_decoder.mli`, `test/xgmii/xgmii_word.mli`, `test/monitors/stream_word.mli`, `test/monitors/strobe_monitor.mli`, `test/xgmii_probe/xgmii_probe.ml`, `test/axi64_probe/axi64_driver.ml` | current | Read in full. They are the contracts |
| `test/xgmii_tx_64/bench.mli` and `bench.ml` | current, at **`2a0a2b1`** | **The landed capability layer — your starting point, and its `.mli` docstring is the contract you extend without breaking** |
| `test/xgmii_tx_64/test_m04_c.ml` | current | **Read it for the unit idiom**: the `fail row msg` helper, the `List.find samples ~f:(fun s -> s.cycle = …)` indexing, the shape of a length-iterating unit |
| **`test/xgmii_rx_64/test_m03_h.ml`** | current | **Cited for the OPERATOR and not for the idiom** (`FINDING WO-0080-1` repair (b)). It carries **16** `Int.rem` sites, the most of any file under `test/**`
(measured at `2a0a2b1`; the next four are `test_m03_n.ml` 9, `test_m03_g.ml` 9,
`test_m03_b.ml` 8, `test_m03_i.ml` 7). `WO-0080` §3 pointed you at `test/xgmii_rx_64/bench.{ml,mli}` — measured afterwards to contain **no modulo of any kind** — so the cure for last round's whole defect set was in the tree and outside every path that packet named. It is named now. See §4's gloss |

---

## 4. The arithmetic identity — quoted, with its OCaml-notation gloss

**Quoted in force from `AP-M04` §4**, and it is the whole expected-value
instrument for families D and E:

> **frame octet `i` is at lane `i mod 8` of the word at cycle `C + 2 + ⌊i/8⌋`**,
> where `C` is the cycle the frame's first source word is accepted;
> **the terminate character is at octet index `F`, hence lane `F mod 8`, at cycle
> `C + 2 + ⌊F/8⌋`**;
> and with the terminate character in lane `t`, the next start character is
> **`g = ⌈(cfg_ifg + t)/8⌉`** words later, an actual gap of **`8g − t`** octets.

with `P` the destination-address-through-payload length (REQ-203's unit) and
`F = max(P, 60) + 4` the length DA through FCS (§0.3's unit).

### 4.1 The OCaml-notation gloss — READ THIS BEFORE YOU TRANSLITERATE ANYTHING

**`mod` above is mathematical notation. It is not OCaml, and writing it as OCaml
is what bounced the last round of this chain** (`FINDING WO-0080-1`, MATERIAL,
mine — the notation was mine, the read list did not contain the cure, and the
bar set could not catch the class).

- The files you write open `Base` (`open! Base`, as every file in this directory
  does). **`Base` shadows the stdlib's infix `mod`**, and this profile promotes
  the resulting alert to an **error**. `let t = f mod 8` is a compile error at
  `Build`, before a single test runs.
- **The spelling is `Int.rem`.** `Int.rem f 8`, `Int.rem i 8`, `Int.rem j 127`.
  The landed bench already uses it in all three places it needs it
  (`bench.ml:151`, `test_m04_b.ml:62`, `:234`) and `test/xgmii_rx_64/test_m03_h.ml`
  has sixteen more.
- Integer division `⌊i/8⌋` is plain `/` on `int` and needs no gloss — only the
  modulo is shadowed.
- **The mathematical notation stays in the prose of this packet on purpose.**
  Repairing it into OCaml everywhere would make the derivation harder to check
  against the plan and the specification, which write it mathematically too. The
  gloss is the repair, and bar **M-17** is the instrument that catches a
  transliteration before CI does.

### 4.2 Two consequences that are easy to get backwards

**(a) The terminate *cycle* does not move with the length across `P ∈ {60 … 67}`
— only the *lane* does.** All eight of family E's members terminate at
`C + 10`, at lanes `0 … 7` respectively. This is trap **T3**, it is the column
most likely to be written from intuition, and it is the entire content of
`M04-E1`'s sweep: **one cycle, eight lanes**.

**(b) `W` (source words) and `F` (wire octets) diverge under padding.** At
`P = 1`: one source word, 64 wire octets. `M04-G9` is built on exactly that
divergence — a frame whose `tlast` word is its only word, and whose wire image is
64 octets long. Sizing anything from `W` where `F` is meant produces a bench that
is correct at `P = 60` and wrong everywhere else (trap **T4**).

---

## 5. The capability layer — what is landed, and the ONE extension

### 5.1 What is landed and CI-proven — measured at `2a0a2b1`, not assumed

**Every claim in this table was established by reading the committed file named,
at this tree** (`AP-M04` §0.1(iii)'s polarity rule, §9.3).

| What | Where | State | You use it for |
|---|---|---|---|
| The whole M04 bench layer | `test/xgmii_tx_64/bench.mli` (11 exported values) + `bench.ml` | **EXISTS, CI-green on ten units at `af06c62`, byte-identical since.** `create`, `sample_cycle`, `run_lengths`, `first_accepted_cycle`, `wire_frame`, `wire_octets`, `assert_instruments_clean`, `content_octets`, `source_words`, `poison`, `decoder`/`strobes` | Everything. **Read `bench.mli` in full first** |
| The FCS oracle | `test/golden/crc32_ref.mli`, reached through `test/xgmii/frame.mli`'s `fcs` / `with_fcs` | **EXISTS**, anchored on REQ-303's published `0xCBF43926` in its own suite. **The one external-anchor obligation at M04 that is discharged today** | Every expected FCS in family D and in `M04-G9` |
| `Frame.pad_to_60` | `test/xgmii/frame.mli` | **EXISTS** — REQ-203's own arithmetic, committed and unit-tested. Takes the DA-through-payload string and returns the padded DA-through-payload string. **It does not append an FCS** (trap **T8**) | The oracle's input at every `P < 60` |
| `Frame.residue_ok` | `test/xgmii/frame.mli` | **EXISTS** — REQ-304's residue over a whole frame including its FCS | `M04-D2` only |
| The wire decoder's `frame` record | `test/xgmii/tx_decoder.mli` | **EXISTS**: `start_cycle`, `terminate_cycle`, `terminate_lane`, `octets`, `underflowed` | `M04-E1`'s and `M04-E4`'s terminate assertions, read through `wire_frame` |
| Raw per-cycle wire words | `Bench.sample`'s `wire` field | **EXISTS** — the `Before`-view `Xgmii_word.t` for every driven cycle | `M04-E2`'s idle scan and `M04-D4`'s lane placement, which the decoder cannot give you |
| **A runner taking explicit frame content** | — | **DOES NOT EXIST.** `run_lengths` builds its content from `content_octets ~p` and there is no way to hand it an octet string. Measured by reading `bench.mli` at this tree: no exported value takes an `int list` as a frame. **This is the one thing you build** — §5.3 | `M04-D3` (a one-octet variant) and `M04-D6` (an all-zero frame) |
| A source-side stall scheduler | — | **NOT BUILT AND NOT COMMISSIONED.** Family G's own round builds it, with its first consumer. Building it here is `BM6`, and `M04-G9` does not need it (§1.4) | — |
| A per-octet latency tagger | `test/monitors/octet_time.mli` | **NOT APPLICABLE AS BUILT** (`AP-M04` §7 item T-4). **Do not instantiate it** (`BM9`) | — |

### 5.2 What you may NOT change in the landed layer

- **The eleven existing values of `bench.mli` keep their signatures byte for
  byte.** You add; you do not alter. Bar **M-19**.
- **`sample_cycle`'s body is not touched at all.** Its eight-step ordering is
  `WO-0080` §5.2's, it is CI-proven, and the `Before`-view acceptance decision is
  what every constant in §6 is stated against (trap **T1**).
- **The four landed `test_m04_*.ml` files are not modified.** They are this
  round's **regression witness**: §5.3 re-expresses `run_lengths` over the new
  function, and the ten landed units are what prove the re-expression changed
  nothing. If any of them goes red, the extension is wrong. Bar **M-5b**, BOUNCE
  `BM14`.

### 5.3 The extension — `run_frames`, and `run_lengths` re-expressed over it

**What it is.** The general runner: each element of its argument is one frame's
**DA-through-payload octet string**, driven exactly as `run_lengths` drives
`content_octets ~p`.

```
val run_frames : int list list -> (int list * t * sample list) list
```

Everything else about a run is **unchanged and must remain so**: obligation 6's
source-contract check before a single cycle is driven; a **fresh** elaboration
per frame; the run length `27 + ⌊F/8⌋` with `F = max (List.length content) 60 + 4`;
the reactive presenter; the liveness bound; `P-ACCEPT`. Returned in the order
given, each entry carrying **the content string it drove** so a row can compare
against what was actually presented rather than against its own memory of it
(the `M03-I2` member (iii) discipline the landed `sample` field already applies
per cycle).

**And `run_lengths` becomes a thin wrapper over it**:

```
run_lengths ps  =  run_frames (List.map ps ~f:(fun p -> content_octets ~p))
                   |> List.map ~f:(fun (content, t, samples) ->
                        (List.length content, t, samples))
```

- **Its exported signature does not change** — `int list -> (int * t * sample list) list`,
  byte for byte, and the `int` it returns is `P` as before.
- **The run-length formula must exist in exactly one place after this change.**
  Two copies of `27 + ⌊F/8⌋` is how the two runners drift apart, and there is no
  bar that would catch a drift of one cycle. Bar **M-8** asks you to quote the
  body and to say where the formula lives.
- **Why a wrapper rather than a second independent runner**: obligation 6's
  contract check, the liveness bound and `P-ACCEPT` are the three guards every
  row's arithmetic rests on. A second runner that reimplemented them would be a
  second place for them to be subtly weaker, and the weakening would be invisible
  in a green run. If you find the wrapper cannot be written without changing
  `run_lengths`' observable behaviour, **stop and report it** — that is class D5
  and it is a finding I want, not something to work around.

---

## 6. The derived constants, per unit

**Every number below is derived from §4's identity and from SPEC-M04 §6.1.
Nothing is estimated and nothing is carried from another packet.** If you cannot
derive one, **report it — do not adopt it** (`BM3` protects you, `BM4` convicts a
silent adoption, class **D5** credits the report in full).

### 6.0 The round-wide rules every unit inherits

**(a) The run length**, unchanged: total cycles driven per run =
**`27 + ⌊F/8⌋`**, where `27 = 16 (the liveness bound on C) + 2 (the preamble
offset) + 1 (the terminate word) + 8 (drain)`. **35** for every `F` in 64 … 71,
**216** for `F` = 1518.

**(b) The content builder** is the landed `content_octets ~p` — octet `j` =
`1 + Int.rem j 127` — for every run except `M04-D3`'s variant and `M04-D6`'s
all-zero frame, which are §6.3's and §6.4's own and are the two reasons §5.3
exists. Its three properties (never `0x00`, never `0xA5`, period 127 coprime
with 8) are why the pad claims and the poison scans of the last round were
non-vacuous, and they still hold here.

**(c) Every scan states its index domain, and every exclusion states its
reason.** This is `FINDING WO-0080-4`'s repair, applied as a round-wide rule
rather than as one row's cure: *a universal over "the run" is falsifiable by
arithmetic at this module* — `/I/` is `0x07`, `/S/` is `0xFB`, `/T/` is `0xFD`,
and the four FCS octets are a **computed value that may equal any octet
whatsoever**. So:

- a **content** scan runs over wire octet indices `0 … F−5` — DA through the
  last pad octet — with the four FCS octets at `F−4 … F−1` **excluded**, and the
  exclusion's reason stated in the comment: the FCS is judged by comparison
  against the oracle (`M04-D1`), never by a scan;
- an **idle** scan runs over the lanes §6.5 names and no others: the terminate
  word's lanes `t+1 … 7`, and every lane of every word at cycles
  `terminate_cycle + 1 … (run length − 1)`. **Every earlier cycle is excluded**,
  because it carries the preamble, frame octets, pad or FCS, and an idle scan
  over it fails a conformant design.

**(d) The one printed value in this round, and the rule that makes its promotion
safe.** `M04-D6`'s Observable requires the oracle's value for the all-zero frame
to be **printed**. That makes this the first unit in `test/xgmii_tx_64/` whose
`[%expect]` block will not stay empty. Three rules, and the third is the one that
matters:

1. **You leave the block `[%expect {||}]`, empty, exactly as ADR-0005 rule 2
   requires.** Hand-authoring the value would be fabricated evidence and is
   `D4c`, a bounce.
2. **CI's first `Run tests` on this round is therefore expected RED**, with a
   diff whose entire content is that one block. That is **class P** (§15), it is
   **not** a bounce and **not** a design defect, and the promotion is a separate
   act and mine. State it in your §16.3 expected-CI statement.
3. **What is printed is the ORACLE's four octets and nothing sampled from the
   design.** `Frame.fcs zeros_60` — never `wire_octets`, never a decoded frame's
   own FCS. The reason is the whole safety of the arrangement: a promoted
   snapshot of a **design** output would launder a design defect into committed
   evidence on the next promotion, whereas a snapshot of an **oracle** value can
   only change if the oracle changes. Trap **T13**, bar **M-18**.

**(e) The §0.6 strobe window is not asserted anywhere in this round.**
`AP-M04` §2 obligation 5 forbids it, and since `ee47eee` the ground is the
better one: §0.6's fourth clause gives `error_underflow` a reference word — the
cycle the word was required and not presented — and SPEC-M04 §9 pins the strobe
on **that same cycle**, so the pin sits at the window's near edge and §0.6 says
in its own words that the window *"carries no independent information"* there.
`M04-G9` expects **zero** strobe events, so no window is supplied and none is
checked: the prohibition is honoured by construction. **Do not compute a window
ceiling anywhere.** If a later round does, it takes ΔC = **2** and never
REQ-210's 1-cycle event delay.

**(f) `C` is observed, never assumed**, and no assertion anywhere names an
absolute cycle measured from cycle 0, from reset, or from the release of
`clear` (`M04-A5`, still round-wide, `BM7`). Use `first_accepted_cycle`, which
is the one definition.

### 6.1 The master length table — every length this round drives

`W = ⌈P/8⌉` source words · `F = max(P,60) + 4` · `t = F mod 8` · terminate cycle
`= C + 2 + ⌊F/8⌋` · pad count `= max(0, 60 − P)` · frame octet `i` at lane
`i mod 8` of cycle `C + 2 + ⌊i/8⌋`.

| `P` | `W` | `tkeep` on the `tlast` word | `F` | pad | `t` | terminate cycle | FCS octet indices | FCS lanes / cycles | run cycles | driven by |
|---|---|---|---|---|---|---|---|---|---|---|
| **1** | 1 | `0x01` | 64 | 59 | 0 | **C+10** | 60–63 | lanes 4–7 of **C+9** | 35 | U11, U16 |
| **8** | 1 | `0xFF` | 64 | 52 | 0 | **C+10** | 60–63 | lanes 4–7 of **C+9** | 35 | U16 |
| **20** | 3 | `0x0F` | 64 | 40 | 0 | **C+10** | 60–63 | lanes 4–7 of **C+9** | 35 | U11 |
| **59** | 8 | `0x07` | 64 | 1 | 0 | **C+10** | 60–63 | lanes 4–7 of **C+9** | 35 | U11 |
| **60** | 8 | `0x0F` | 64 | 0 | 0 | **C+10** | 60–63 | lanes 4–7 of **C+9** | 35 | U11, U12, U13, U14 |
| **61** | 8 | `0x1F` | 65 | 0 | 1 | **C+10** | 61–64 | lanes 5–7 of **C+9**, lane 0 of **C+10** | 35 | U11, U14 |
| **62** | 8 | `0x3F` | 66 | 0 | 2 | **C+10** | 62–65 | lanes 6–7 of **C+9**, lanes 0–1 of **C+10** | 35 | U14 |
| **63** | 8 | `0x7F` | 67 | 0 | 3 | **C+10** | 63–66 | lane 7 of **C+9**, lanes 0–2 of **C+10** | 35 | U14 |
| **64** | 8 | `0xFF` | 68 | 0 | 4 | **C+10** | 64–67 | lanes 0–3 of **C+10** | 35 | U11, U14 |
| **65** | 9 | `0x01` | 69 | 0 | 5 | **C+10** | 65–68 | lanes 1–4 of **C+10** | 35 | U14 |
| **66** | 9 | `0x03` | 70 | 0 | 6 | **C+10** | 66–69 | lanes 2–5 of **C+10** | 35 | U14 |
| **67** | 9 | `0x07` | 71 | 0 | 7 | **C+10** | 67–70 | lanes 3–6 of **C+10** | 35 | U11, U14 |
| **1514** | 190 | `0x03` | 1518 | 0 | 6 | **C+191** | 1514–1517 | lanes 2–5 of **C+191** | 216 | U11, U15 |

**Read the terminate-cycle column.** Twelve of the thirteen lengths terminate at
**the same cycle** and at **eight different lanes** — §4.2(a), trap T3.

**Read the FCS-lanes column, because it is `M04-D4`'s whole claim.** At `P = 60`
the last pad octet is at lane 3 of `C+9` and the FCS occupies lanes 4–7 of **that
same word**; at `P = 64` the last frame octet is at lane 7 of `C+9` and the FCS
occupies lanes 0–3 of the **next** word. A design that always begins the FCS on a
word boundary is conformant-looking at the first and wrong at the second.

**Check three `tkeep` values by hand before you trust the column** (`tkeep` =
`0xFF` on words `0 … W−2` and `(1 << (P − 8(W−1))) − 1` on the `tlast` word):
`P=1` → `1 − 0 = 1` octet → `0x01`; `P=8` → `8 − 0 = 8` → `0xFF`; `P=65` →
`65 − 64 = 1` → `0x01`.

**Acceptance, for every length**: word `m` is accepted at cycle `C + m` for
`m = 0 … W−1`, contiguously — the `P-ACCEPT` precondition. At `P ∈ {1, 8}` that
is the single cycle `C`, and the cycle after it is C-16's post-`tlast` cycle
where `tx_tready` = 1 with `tx_tvalid` = 0 **means nothing at all** (SPEC-M04 §7).
**That is `M04-G9`'s whole subject.**

### 6.2 U11 — `M04-D1`, `M04-D2`, `M04-D4`, `M04-D5`. Eight runs, the directed set

`run_lengths [ 1; 20; 59; 60; 61; 64; 67; 1514 ]` — `M04-B4`'s own set, reused
deliberately: the set was chosen to cover the pad boundary, every terminate lane
family E sweeps, and the maximum length, and family D's oracle comparison is
worth more at eight lengths than at one.

| # | Assertion | Value |
|---|---|---|
| 1 | The decoded wire frame's octet count | `F` — from the table, per length |
| 2 | **`M04-D1`**: the four octets at wire indices `F−4 … F−1` | equal `Frame.fcs (Frame.pad_to_60 (content_octets ~p))`, **octet for octet, in list order** — which is REQ-202's wire order, least significant octet first |
| 3 | **`M04-D1`**, stated as its own check so a length mismatch is not read as a value mismatch | `Frame.fcs …` returns exactly **4** octets |
| 4 | **`M04-D2`**: `Frame.residue_ok` over the **whole** decoded frame (DA through FCS) | `true` |
| 5 | **`M04-D4`**: for each of the four FCS octets, the `(cycle, lane)` it occupies on the wire | index `k` is at lane `Int.rem k 8` of the sample at cycle `C + 2 + k/8` — read the raw `sample.wire` at that cycle and compare that lane's data octet. The table's FCS-lanes column is the expansion, per length |
| 6 | **`M04-D4`**'s contrast, asserted explicitly at the two named lengths | at `P = 60`: lane 3 of `C+9` carries pad octet 59 (`0x00`) and lanes 4–7 of `C+9` carry the FCS. At `P = 64`: lane 7 of `C+9` carries content octet 63 and lanes 0–3 of `C+10` carry the FCS |
| 7 | The standing instruments | `assert_instruments_clean t ~row`, once per run |
| 8 | **`M04-D5`** (NO-ASSERT), in the unit title and round-wide | nothing in this unit or anywhere in this round asserts the CRC **enable**, its `octet_count`, or any internal of the CRC path; §6.3 item 1 leaves the register placement and update mechanism unconstrained, and a design driving `octet_count` = 0 on a held cycle is convicted at **M02's own domain check**, not here |

**What assertion 2 must not become.** Do not compare against
`Frame.with_fcs content` and slice, and do not compare the decoded frame against
`Frame.with_fcs (Frame.pad_to_60 content)` as a whole *instead* of asserting the
four octets. The whole-frame form is a fine **additional** check and you may write
it; what the row requires is the **four octets at their indices**, because that
is what makes a byte-reversed FCS fail with a message naming the reversal rather
than a 64-octet list inequality nobody can read.

### 6.3 U12 — `M04-D3`. Two runs, `P = 60`, differing in octet 0 alone

The two frames, built with §5.3's `run_frames`:

- **frame A** = `content_octets ~p:60` — octet 0 is `1 + Int.rem 0 127` = **1**;
- **frame B** = frame A with octet 0 replaced by **2**, every other octet
  identical.

Octet 0 is the first octet of the destination address, which is where REQ-202's
coverage **begins** (*"destination address through the last payload or pad
octet"*). `2` rather than `0` keeps the variant inside `content_octets`' own
range `0x01 … 0x7F` and out of every value with a meaning on the wire.

| # | Assertion | Value |
|---|---|---|
| 1 | **Anti-vacuity, first and by itself**: the two content strings | have the same length, differ at index 0, and are **equal at every other index**. If this fails, nothing below means anything and the message says so |
| 2 | **`M04-D3`**: the two decoded frames' FCS quadruples | **differ** |
| 3 | Each frame's FCS against its own oracle value | frame A's equals `Frame.fcs frame_a`, frame B's equals `Frame.fcs frame_b` — the row's kill is *"a design seeding the CRC one octet late, or after the SFD"*, and a design that ignored octet 0 would produce **equal** FCSs, caught by assertion 2, while a design that covered a **shifted** range is caught by assertion 3 |
| 4 | The two frames' wire octets outside the FCS | equal their own content at indices `0 … 59` — so a difference in the FCS cannot be a side effect of a difference the design introduced elsewhere |
| 5 | The standing instruments | `assert_instruments_clean` on **both** runs |

### 6.4 U13 — `M04-D6`. One run, `P = 60`, all-zero content

The frame is **60 octets of `0x00`**, built with `run_frames` — the one stimulus
whose content is the same as the defect's output, which is exactly why the row
exists and why it is driven **beside** U11's position-dependent frames and never
instead of them.

| # | Assertion | Value |
|---|---|---|
| 1 | **`M04-D6`**: the four wire FCS octets | equal `Frame.fcs zeros_60`, where `zeros_60 = List.init 60 ~f:(fun _ -> 0)` — **computed from the oracle at run time and never written as a literal**. A hand-written four-octet constant here is a fabricated expectation (`BM12`) |
| 2 | **`M04-D6`**'s anti-vacuity half | the four octets are **not** `[0; 0; 0; 0]` — the kill is a design that emits the CRC **seed** (`0x00000000`, SPEC-M04 §6.1 item 1) instead of the finished value |
| 3 | **The print** (§6.0(d)) | the **oracle's** four octets, and their 32-bit value, printed once, in a deterministic format, lane-order stated. Nothing sampled from the design is printed |
| 4 | The pad region | there is none — `P = 60` — and the unit says so rather than scanning an empty range |
| 5 | The standing instruments | `assert_instruments_clean t ~row` |

**The derivation behind assertion 2, and its honest edge.** The oracle's identity
element is `0x00000000` because that is `CRC32("")`: REQ-301's initial value
`0xFFFFFFFF` and its final XOR `0xFFFFFFFF` are both internal and cancel over an
empty input (`crc32_ref.mli`, *"The value convention"*). So the assertion is
non-vacuous **unless** the oracle's value over sixty zero octets happens to be
the identity, which for the REQ-301 polynomial it is not. **You are not asked to
prove that.** You are asked to compute the value from the oracle and assert the
inequality; if the assertion fires, that is either the design defect the row
hunts or the coincidence — and **the printed value distinguishes them**, which is
the second reason the print earns its promotion.

### 6.5 U14 — `M04-E1`, `M04-E2`, `M04-E3`, `M04-E5`. Eight runs, `P ∈ {60 … 67}`

`run_lengths [ 60; 61; 62; 63; 64; 65; 66; 67 ]` — **the eight-lane sweep,
derived from §4's identity and not sampled**. `t = F mod 8` runs `0, 1, 2, 3, 4,
5, 6, 7` across the eight members in order, and **all eight terminate at
`C + 10`**.

| # | Assertion | Value |
|---|---|---|
| 1 | **`M04-E1`**: the terminate character's cycle | `C + 2 + ⌊F/8⌋` = **`C + 10`** for all eight |
| 2 | **`M04-E1`**: its lane | `t` = `Int.rem F 8` = the table's column, `0 … 7` across the eight members |
| 3 | **`M04-E1`**: the lane's content | `xgmii_txc` bit `t` **set**, and `xgmii_txd` lane `t` = **0xFD**. Assert both — a decoder reading only the control bit cannot see a wrong character value, and §6.3 item 2 makes the character's own value normative |
| 4 | **`M04-E1`**: cross-check against the decoder | `(wire_frame samples).terminate_cycle` and `.terminate_lane` agree with assertions 1 and 2. **Stated as a cross-check and not as the assertion**: the decoder is a second reading of the same wire, and the row's claim is against the bench's own arithmetic |
| 5 | **`M04-E2`**: the terminate word's fill lanes | every lane `k` with `t < k ≤ 7` of the word at `C + 10`: control bit **set** and data = **0x07** |
| 6 | **`M04-E2`**: everything after the terminate word | every lane of every sample at cycles `C + 11 … (run length − 1)`: control bit **set** and data = **0x07**. The scan's domain is stated in the comment, with the exclusion's reason (§6.0(c)) |
| 7 | **`M04-E3`**: the boundary pair | at `P = 67` (`t = 7`) the terminate word has **zero** fill lanes and assertion 5's loop runs zero times — **assert that the count is 0 rather than letting an empty loop pass silently**; at `P = 60` (`t = 0`) it has **seven** |
| 8 | The standing instruments | `assert_instruments_clean` on all eight runs |
| 9 | **`M04-E5`** (NO-ASSERT), in the unit title and round-wide | **no assertion in this round is written as a universal over terminate characters.** REQ-205's *"immediately after the last FCS octet"* has **no instance** on an underflowed frame — SPEC-M04 §9 appends **no FCS** to one and its terminate character is at lane 1 of the `/E/` word — so every assertion here is scoped to the frames this round drives, which all carry an FCS. A helper written as *"for every terminate character, ..."* would fail a conformant M04 the first time family G drives one |

**What assertion 6 does not reach, stated so the discharge is not read wider than
it is.** In a one-frame run there is no next start character, so `M04-E2`'s fill
is asserted **to the end of the run** rather than **to the next preamble**. The
plan's own Stimulus cell for `M04-E2` is *"(E1's eight members)"*, so this is the
stimulus the row was written for and the discharge is on its own terms. The one
shape it cannot reach — a stale lane on the **last** gap word before a following
preamble — belongs to the two-frame round (family F, `M04-A3`, `M04-B3`), and I
carry it at §19 rather than leaving it to be inferred.

### 6.6 U15 — `M04-E4`. One run, `P = 1514`

| # | Assertion | Value |
|---|---|---|
| 1 | **`M04-E4`**: the terminate character | lane **6** of the word at cycle `C + 2 + 189` = **`C + 191`**, control bit 6 set, data = **0xFD** |
| 2 | The wire octet count | **1518** |
| 3 | The FCS octets | at wire indices 1514–1517, lanes 2–5 of `C + 191` — the same word as the terminate character, which is the placement `M04-D4`'s claim generalises |
| 4 | The standing instruments | `assert_instruments_clean t ~row` |

**Why this is its own unit and not a member of U14's sweep.** `F mod 8` = 6 at
`P = 1514` and 6 again at `P = 66`, so the lane adds nothing; what adds
everything is `⌊F/8⌋` = **189**, which no counter narrower than 11 bits computes
correctly and which every shorter frame in this plan hides.

### 6.7 U16 — `M04-G9`. Two runs, `P ∈ {1, 8}` — the single-word frame

`W = 1` at both: the one source word carries the frame's first octet **and** its
`tlast`. `P = 1` is the minimum and poisons seven `tkeep`-0 positions; `P = 8` is
the maximum single-word frame and poisons none. **Both are driven** because the
class's two ends differ in exactly the thing that made `BUG-0004` reachable — how
much of the accepting word is frame.

| # | Assertion | Value |
|---|---|---|
| 1 | **`M04-G9`**, the row's own load-bearing half: the strobe | `Strobe_monitor.high_cycles "error_underflow"` = **0** over the whole run, and the monitor's exact event set is **empty**. `assert_instruments_clean` asserts both; **call it and say in the comment that this is the row's assertion and not a background check** |
| 2 | Acceptance | exactly **one** accepted cycle, at `C`; `P-ACCEPT` holds trivially; the cycle `C + 1` is C-16's post-`tlast` cycle and **nothing is asserted about `tx_tready` there** (`BM11`) |
| 3 | The frame transmits intact: the preamble | one start character, lane 0, cycle `C + 1` |
| 4 | its content | wire octets `0 … P−1` equal `content_octets ~p` |
| 5 | its pad | wire octets `P … 59` are all **0x00** — 59 of them at `P = 1`, 52 at `P = 8` |
| 6 | its FCS | wire octets 60–63 equal `Frame.fcs (Frame.pad_to_60 (content_octets ~p))` — **family D's instrument, which is why this row rides this round** (§1.4) |
| 7 | its terminate character | octet index `F` = **64**, lane **0**, cycle **`C + 10`** |
| 8 | The standing instruments | `assert_instruments_clean t ~row` on both runs |

**The claim this unit may NOT make.** It does not discharge `M04-G4` (which
additionally asserts `tx_tready` = 1 at the post-`tlast` cycle, and this round
asserts no value of `tx_tready` anywhere), it does not discharge `M04-G10`, and
it does not make REQ-206 covered. Naming `M04-G4` or `M04-G10` in a title, a
comment or the Return log is `BM8`.

---

## 7. How to instantiate the DUT without reading it

**You do not instantiate it. `Bench.create` already does**, and it is landed,
CI-proven and unchanged this round. Read `bench.mli`'s docstring for the contract;
the three things it names from SPEC-M04 alone are the library
`Hardcaml_ethernet`, the module `Xgmii_tx_64` and the entry point
`create : Scope.t -> Signal.t I.t -> Signal.t O.t`. Every port after that is
reached by **projecting a field off the live `Cyclesim.inputs` / `Cyclesim.outputs`
record**, never by naming the concrete module that defines `Axi64.Source.t` or
`Xgmii.t`. **Your new units touch no port at all** — they call `run_lengths` or
`run_frames` and read `sample` records.

**The reset cycle's numbering, corrected here because `WO-0080` §7.1's wording was
wrong about its own bench** (`OBSERVATION WO-0080-O2`, mine): `create` drives the
one `clear` cycle **inside itself**, *outside* `sample_cycle`'s numbering, so
`sample_cycle`'s cycle 0 is the **first post-reset cycle** and not the reset cycle.
`WO-0080` §7.1 said *"`clear` = 1 for exactly one cycle (cycle 0's drive)"*, which
reads as though the reset cycle were cycle 0 of the sample numbering. The bench's
choice is the better one — it keeps the choke-point guard exact and keeps every
row's arithmetic anchored on `C` — and `bench.mli` documents it. **Nothing you
write this round depends on the reset cycle**, and no instrument sees it
(`OBSERVATION WO-0080-O1`): obligation 1's decoder and obligation 4's monitor are
both constructed after it. That is correct for this round and it is family G's
round that must decide it deliberately.

---

## 8. What you may NOT read

**`libs/**`, `top/**`, `rtl_snapshots/**`, `bin/**` and `test/third_party/**` are
closed to you for this round.** PROTOCOL §10: DV derives every test from
specifications, never from the implementation, and this packet is written so that
a leaked-context violation would be visible in the diff — every expected value
here is derived from SPEC-M04 §6.1, from requirements.md, or from a committed
oracle you may read.

If a unit goes red, **that is not a licence to open the design**. Report it; the
disposition is §15's and mine. `BM15` fires if any of those paths appears in your
`Inputs`, your Return log or your write record.

**You may read**, in full: `test/**` (except `test/third_party/**`),
`docs/specs/**`, `agents/**`, `.github/workflows/**`, `tools/**` (reading a script
is not running one).

---

## 9. Regime facts — the standing rules that bind this round, numbered

**These are obligations, not background.** They are numbered because the packet is
the rule-propagation vehicle: you read this packet, not the org's history, and a
rule that lives only in a journal has not reached you (`L-F02`).

### 9.1 The SHA rule — a sentence asserting a census is not the census

`AP-M04` §0.1(i).

> Any claim that **quantifies over a set** — *"the only unit that …"*, *"no test
> drives …"*, *"every block is empty"* — is **re-measured at the point of
> citation**, or quoted **with the SHA and the command it was measured at**. A set
> claim carrying neither is not evidence.

**Your instance**: every count in your Return log (§18 item 2) is a raw figure you
measured, per file, with the instrument named. Not a recollection, and not a total
you computed once and re-quoted.

### 9.2 The domain rule — a universal over "the bench" is measured over every producer

`AP-M04` §0.1(ii). **Your instance, and it is favourable**: at M04 there is
**exactly one producer** today — the bench you are extending. §9.6's BAR T1 is
why. So any universal this round asserts is true over the producer set
`{ the M04 bench }` and **must be re-measured the day a second producer lands**,
never merely re-quoted. Where you write such a universal in a comment, write the
producer set beside it.

### 9.3 The polarity rule — a claim that something does not exist is measured

`AP-M04` §0.1(iii). **A capability claim states the set it was measured over, and
its polarity does not change that obligation.** §5.1's table is that measurement,
made at my seat at `2a0a2b1`, with the file that establishes each absence named —
including the one that matters this round, *no exported value of `bench.mli` takes
an `int list` as a frame*, which is why §5.3 exists. **If you conclude mid-round
that some capability is missing, measure it the same way before you say so** —
name the file you read. If you find §5.1 wrong in either direction, that is a
finding I want (§18 item 8).

### 9.4 The underflow family does not ride this round — except `M04-G9`'s silence

Three facts bind your driver, and the third is new this round.

1. **REQ-016's idle tolerance does not extend to M04's source interface.** A
   missing word on a required cycle is an **underflow**, not a gap. The landed
   presenter never withholds mid-frame; **you must not build an idle-injection
   wrapper at M04's source** — since `ee47eee` that is the **specification's own
   normative prohibition** (SPEC-M04 §7: *"A bench SHALL NOT build a REQ-016
   idle-injection wrapper at this module's source interface: the first injected
   cycle on a required cycle is an underflow, and a monitor measuring L across it
   measures a frame the injection destroyed."*). BOUNCE `BM6`, and it is the
   condition I would most regret discovering late: it manufactures aborted frames
   while looking like conformance stimulus.
2. **The cycle after the `tlast` word is accepted is not an underflow.** SPEC-M04
   §7's C-16 bullet, consequence 1, verbatim: *"this is the one cycle in a frame's
   life where `tx_tready` = 1 with `tx_tvalid` = 0 means nothing at all."* Every
   run in this round passes through it, and at `P ∈ {1, 8}` it is the cycle
   immediately after the **only** acceptance.
3. **`M04-G9` asserts a silence and nothing else about REQ-206.** Its empty strobe
   set is **not** a discharge of `M04-G4` (which additionally asserts
   `tx_tready` = 1 at that cycle, and this round asserts no value of it anywhere)
   and **not** a discharge of `M04-G10` (which needs machinery T-7 and is not
   mountable at this commit). **Do not name `M04-G4` or `M04-G10` in a title, a
   comment or the Return log** (`BM8`), and do not describe REQ-206 as covered:
   `AP-M04` §0.2 item 4 bars an `SO-` from claiming it while `M04-G10` is neither
   measured nor declared a gap, and that bar is not this round's to lift.

### 9.5 The FCS oracle is REQ-305's, and never the design's own engine

`AP-M04` §2 obligation 2, and REQ-202's verification column states both the rule
and its reason: *"Feeding the frame back through the receiver and through the
REQ-304 residue check is a supplementary check only: both share the design's own
`Crc32_eth` engine, so a systematically wrong but self-consistent CRC would pass
them."*

**This is the round where that rule does its work.** Every expected FCS in family
D and in `M04-G9` comes from `Frame.fcs`, which reaches `Dv_golden.Crc32_ref`, the
bit-serial REQ-305 reference anchored on REQ-303's published `0xCBF43926`. **No
expected value in this round is ever taken from a loopback through M03, from a
co-simulation result, or from the design's own output** — including, and
especially, from a printed or promoted snapshot of one (§6.0(d) rule 3). That last
clause is `M04-O5`, a plan-wide prohibition: a divergence resolves as a defect
against our RTL, a documented-divergence entry, or a spec diff with its own ADR —
**never** by amending an expectation to agree (`BM12`).

### 9.6 BAR T1 — the differential anchor at this boundary is SHUT

`AP-M04` §7.1, quoted in force:

> **No `SO-xgmii_tx_64.md` PASS may rest on a differential co-simulation result at
> this boundary.** Three independent conditions block it, each measured at the tree
> and each requiring an act outside a bench round: **(a)** the reference module
> `axis_xgmii_tx_64.v` is **not vendored**; **(b)** there is **no transmit
> harness** and `test/cosim/canonical.mli`'s pinned grammar is a per-word
> AXI-stream record, which a lane pair has none of; **(c)** **REQ-901 declares no
> divergence class at this boundary**, and its own rule forbids citing a class not
> listed there.

**Your instance, in one line: no co-simulation work of any kind is in this round,
and no sentence you write may promise, prepare for or claim one.** Do not create
anything under `test/cosim/`, do not read the vendored `.v` files, do not name a
divergence class.

**What BAR T1 does not bar, said so it is not read wider than it is**: family D's
FCS claims are **not** gated. Obligation 2's oracle is independent, committed and
externally anchored, so **family D stands on its own external anchor today** — it
is the one anchor obligation at M04 that is discharged, and this round is what
spends it. BAR T1 is about the *differential* anchor.

### 9.7 The census does not see M04 — measured, and it changes what your counts mean

`tools/dv_checks.sh` at `2a0a2b1` contains **zero** occurrences of `M04`,
`xgmii_tx_64` or `AP-xgmii_tx`. Its row-discharge census is hard-keyed to
`AP-xgmii_rx_64.md` / `M03-` / `test/xgmii_rx_64/*.ml` and reports M03's rows; its
per-file bench inventory loops over `test/xgmii_rx_64/*.ml`. **No M04 row appears
as discharged or undischarged in that report, at any figure.**

**Consequences, both concrete.** (i) Your unit titles are read by **no script in
this tree** — they are read by *me*, when I write the `SO-` coverage map, so
§11.1's title rule is a real obligation and not a mechanical one. (ii) The only
figure that moves is the repository-wide expect-test inventory, **149 → 155**, and
bar **M-3** is stated as that delta. Extending `dv_checks.sh` to carry an M04
census is **mine** and `tools/**` is not yours to stage (§19 item 1).

---

## 10. Cost — the size class, measured, and this round's ceiling

`WO-0070`'s cost probe measured family L's stimulus at **2.036 s** total at
`count` = 10 000, driving **105 010** cycles in one `Bench.run`. **That is the size
class, and it is measured on cycles driven** — the quantity both packets derive
rather than estimate.

| Unit | Runs | Cycles per run | Cycles | Elaborations |
|---|---|---|---|---|
| U11 (D1, D2, D4, D5) | 8 | 35 ×7, 216 ×1 | **461** | 8 |
| U12 (D3) | 2 | 35 | 70 | 2 |
| U13 (D6) | 1 | 35 | 35 | 1 |
| U14 (E1, E2, E3, E5) | 8 | 35 | 280 | 8 |
| U15 (E4) | 1 | 216 | 216 | 1 |
| U16 (G9) | 2 | 35 | 70 | 2 |
| **total** | **22** | — | **1 132** | **22** |

**1 132 driven cycles and 22 elaborations.** `1 132 / 105 010` = **1.08%** — two
orders of magnitude inside the measured class on the derived quantity. **No probe
is required**, and `WO-0070` §1.5's band overlap therefore does not need closing
in this packet. The conditional is stated rather than assumed, because the ruling
that made it mine was explicit (`RV-0070-VERDICT`, affirmed at Q3): *if a round's
stimulus leaves the size class `WO-0070` measured, the probe shape is the
precedent and §1.5's band overlap must be closed in the new packet BEFORE its
first run.* This round does not leave the class.

**The pre-committed ceiling, so "inside the class" is checkable rather than
asserted**: **total driven cycles across the whole round ≤ 1 700, total
elaborations ≤ 28.** If your implementation exceeds either, **stop and flag it —
do not improvise a reduction and do not proceed.** Exceeding it means one of §6's
constants is wrong, which is a finding I want (BOUNCE `BM13`).

---

## 11. Unit structure and the files this round stages

### 11.1 Unit structure — six `%expect_test` units across three new files

| File | Units | Titles |
|---|---|---|
| `test_m04_d.ml` | **3** | U11 → `M04-D1`, `M04-D2`, `M04-D4`, `M04-D5`; U12 → `M04-D3`; U13 → `M04-D6` |
| `test_m04_e.ml` | **2** | U14 → `M04-E1`, `M04-E2`, `M04-E3`, `M04-E5`; U15 → `M04-E4` |
| `test_m04_g.ml` | **1** | U16 → `M04-G9` |
| **total** | **6** | — |

**The title rule, and §9.7 is why it is a real obligation rather than a mechanical
one.** Each unit title contains **its own row ids and no other `M04-` identifier
whatsoever**. In particular **no title may name `M04-A3`, `M04-A4`, `M04-B3`,
`M04-D7` (there is no such row), `M04-F*`, `M04-G1` … `M04-G8`, `M04-G10`, or any
row this round does not carry** — naming one would discharge it in the coverage
map I write from these titles, and no script in this tree would catch it.

The `=` must be alone on its own line, as it is in every landed unit:

```
let%expect_test "M04-E1, M04-E2, M04-E3: the eight-lane terminate sweep, the \
                 fill lanes, and M04-E5's scope"
  =
```

**`test_m04_g.ml` is created with one unit and that is deliberate.** Family G's own
round appends to it. A file per family is this directory's convention and putting
`M04-G9` in `test_m04_d.ml` because it happens to use family D's oracle would put a
family-G row where no family-G round would look for it.

### 11.2 The files this round stages — exactly six, plus two

1. `test/xgmii_tx_64/bench.mli` — **extended**: one new value, `run_frames`,
   documented in the file's own docstring style (the landed `.mli` is a contract
   document, not a signature list, and yours must match its register). The eleven
   existing values keep their signatures byte for byte.
2. `test/xgmii_tx_64/bench.ml` — **extended**: `run_frames` implemented,
   `run_lengths` re-expressed over it (§5.3), the run-length formula left in
   exactly one place.
3. `test/xgmii_tx_64/dune` — **header comment only**. Add this packet's row line
   under `WO-0080`'s, in the same form; the header is a *standing per-packet row
   list, not a snapshot*, and its own text records what a stale summary cost.
   **The `(library …)` stanza itself does not change**: no new dependency edge —
   `Frame.fcs` reaches the oracle through `dv_xgmii`, so `dv_golden` is still not
   named directly.
4. `test/xgmii_tx_64/test_m04_d.ml` — new.
5. `test/xgmii_tx_64/test_m04_e.ml` — new.
6. `test/xgmii_tx_64/test_m04_g.ml` — new.

plus **this packet's Return log** and **your journal** at
`agents/journals/workers/claude_tb_writer_agent*.md`. **Eight paths in total, and
a seventh source file is `BM14`.**

### 11.3 What does NOT move, and that is not a claim that it is correct

`test/xgmii_tx_64/test_m04_scaffold.ml`, `test_m04_a.ml`, `test_m04_b.ml`,
`test_m04_c.ml` (**the regression witness — §5.2**), `test/xgmii_rx_64/**` (17
tracked files), `test/xgmii/**`, `test/monitors/**`, `test/golden/**`,
`test/axi64_probe/**`, `test/xgmii_probe/**`, `test/cosim/**`,
`test/attack_plans/**`, `tools/**`, `docs/**`, `libs/**`, `.github/**`. If you find
a defect in any of them, **report it in the Return log and leave it standing** — a
bench round that repairs its own machinery in the same commit makes the repair
unreviewable against the round that needed it.

---

## 12. The review bar — pre-committed, assigned by seat, and every tree-quantified bar executed at the base

**Each bar below whose pass condition quantifies over a whole tree or a whole diff
was executed at the base commit `2a0a2b1` before this packet issued, and its base
figure is stated.** That obligation is mine and it is `FINDING K-3`'s: *a review
bar that has never been run against its own base is not a bar, it is a hope — and
it fails on the first round where the base has moved, silently, because its
failure looks like a defect in the work.*

**Seat note**: §17's allow-list gives you **no shell beyond
`ocamlc -stop-after parsing`** and the two spawn-precheck commands §17.1 now carves
in by name. Every bar phrased as a search is therefore a file-search-and-read bar
at your seat, or it is mine. That is a consequence of the allow-list, not a change
of standard.

| Bar | Whose | Instrument | Base figure at `2a0a2b1` | Pass condition |
|---|---|---|---|---|
| **M-1** | **dv** | `git diff 2a0a2b1 <landing>` read **hunk by hunk** | — | every hunk belongs to one of §11.2's eight paths and to a mechanism this packet specifies; no ninth path; no hunk in `test/xgmii_rx_64/**`, `test/xgmii/**`, `test/monitors/**`, `test/attack_plans/**`, `docs/**`, `tools/**`, `libs/**` |
| **M-2** | **dv** | the CI `build` run at the landing commit, **read as a step reading at the source** | — | steps **"Build"**, **"Run tests (expect tests, waveform snapshots)"** and **"Verify nothing was left unpromoted or non-deterministic"**, each read **by name and status**. **A badge is not a reading.** A red at "Run tests" is routed through §15 — as **class P** if its whole diff is U13's block, otherwise as D1/D2/D3/D4 — and **never** through a re-run |
| **M-3** | **dv** | `grep -rh --include=*.ml 'let%expect_test' test/ \| grep -c .` | **149** | **149 → 155**, i.e. **+6** and no other movement. Stated as a **delta**, because the base is a moving figure (§9.7) |
| **M-4** | **dv** | `git ls-files test/xgmii_tx_64/` | **7** tracked files: `bench.ml`, `bench.mli`, `dune`, `test_m04_a.ml`, `test_m04_b.ml`, `test_m04_c.ml`, `test_m04_scaffold.ml` | exactly **10**, and they are the base seven plus §11.2's three new ones as a **set**, not as a count |
| **M-5** | **dv** | `git diff --stat 2a0a2b1 <landing>` over `test/xgmii_rx_64/` | 17 tracked files | **zero** hunks. All 17 byte-identical |
| **M-5b** | **dv** | `git diff 2a0a2b1 <landing> -- test/xgmii_tx_64/test_m04_scaffold.ml test_m04_a.ml test_m04_b.ml test_m04_c.ml` | 4 files, byte-identical is the requirement | **zero** hunks. **This is the bar that makes the ten landed units a regression witness for §5.3's re-expression**; if any of them is edited, the witness is destroyed and the re-expression is unproven |
| **M-6** | **dv** | §6's tables, cell by cell, against the landed source, read **against the computing expression and never against a comment** | — | every derived constant equals the landed assertion, or appears in your Return log as one you disagree with |
| **M-7** | **dv** | file search for `M04-` across `test/**/*.ml` | **13 commissioned ids** (`A1`, `A2`, `A5`, `B1`, `B2`, `B4`, `B5`, `C1`, `C2`, `C3`, `C4`, `C5`, `C6`) **plus 2 bare `M04-` tokens** (the scaffold's own negation); zero others | every occurrence is one of those 13, one of the 2 bare tokens, or one of the **12** ids §2 commissions. **Zero occurrences of any other `M04-` id anywhere in `test/**/*.ml`** |
| **M-8** | worker | Read your `run_frames` body and your re-expressed `run_lengths` back in full | — | **Quote both verbatim in your return**, and state **in which single expression** the run-length formula `27 + ⌊F/8⌋` lives. Two occurrences of it is a defect even if both are currently equal |
| **M-9** | worker | §4's identity against SPEC-M04 §6.1's own cycle table, by hand, at `P = 60` **and** at `P = 67` | — | at `P = 60`: `F = 64`, `t = 0`, terminate at `C + 10`, FCS at lanes 4–7 of `C + 9`. At `P = 67`: `F = 71`, `t = 7`, terminate at `C + 10`, FCS at lanes 3–6 of `C + 10`. **Report the eight values you derived, not the eight you read here** |
| **M-10** | worker | file search for `let%expect_test` across `test/xgmii_tx_64/`, **per file**, read back | base: scaffold 1, a 1, b 3, c 5 | `test_m04_d.ml` **3**, `test_m04_e.ml` **2**, `test_m04_g.ml` **1**, and the four landed files **unchanged at 1/1/3/5**. **Report the raw per-file numbers** |
| **M-11** | worker | file search for `[%expect` across `test/xgmii_tx_64/`, then Read each hit | 10 blocks, all `{||}` | **every block you write is `{||}`**, and the four landed files' ten blocks are untouched. **You hand-author no snapshot content whatever**, including U13's — CI's own diff is where that content comes from (§6.0(d)). Report the raw count too |
| **M-12** | worker | Read each of the six new unit titles back in full, and the `=` line after each | — | each contains its own row ids and **no other `M04-` identifier**; each `=` is alone on its own line |
| **M-13** | worker | file search for `tready` across `test/xgmii_tx_64/*.ml`, **then Read every hit** **4** hits, all in `bench.ml`'s `sample_cycle` — `:108` (the ref), `:133` (a comment), `:135` (the read), `:139` (the acceptance decision); **zero** in any `test_m04_*.ml` | **unchanged**: still exactly one read site, in `sample_cycle`, named by file and line; **no new read site**, and **no unit asserts a value of it** (`BM11`) |
| **M-14** | worker | Read every scan you wrote, and quote its domain expression | — | every content scan runs over wire indices `0 … F−5` with the FCS at `F−4 … F−1` **excluded and the exclusion's reason in the comment**; every idle scan runs over §6.5's stated lanes and cycles and no earlier cycle. **Quote each domain expression** (§6.0(c)) |
| **M-15** | worker | `ocamlc -stop-after parsing` on the five OCaml files you wrote or edited | — | exit 0 for each. **Parse is not the adjudicator; M-2 is** — it establishes syntax and nothing about types, and you should say so rather than let a green parse stand in for a build |
| **M-16** | worker | your own journal `Inputs` section, read back | — | no `libs/**`, no `top/**`, no `rtl_snapshots/**`, no `test/third_party/**` path |
| **M-17** | worker | file search for infix ` mod ` across `test/xgmii_tx_64/` | **2** occurrences, **both non-expression**: `bench.mli:151` (inside a docstring) and `test_m04_b.ml:255` (inside a string literal) | **zero occurrences in an expression position.** Stated as an expression bar and not as a count, because the base is 2 and both base hits are legitimate. **Read every hit** — this is the bar `FINDING WO-0080-1(d)` commissioned and it is the one that would have caught last round's entire defect set at your own seat |
| **M-18** | worker | file search for `print`/`printf`/`print_s`/`Stdio` across `test/xgmii_tx_64/`, then Read every hit | **0** occurrences | **exactly one** printing site in the whole directory, in **U13**, and its argument is derived from **`Frame.fcs`** — never from `wire_octets`, never from a `sample`, never from a decoded frame. **Quote the call** (§6.0(d) rule 3, trap T13) |
| **M-19** | worker + **dv** | Read `bench.mli`'s eleven landed values back and compare to the base file | 11 exported values | **every existing signature byte-identical**; the only change is the addition of `run_frames` and its docstring. dv re-checks by diff |

---

## 13. BOUNCE conditions — pre-committed

- **`BM1` — any unit in `test/**` is red at CI at the landing commit for a reason
  in §15's classes D4a–D4d, or for any reason not in §15's table at all.**
  General by construction. **D1, D2, D3, D5 and P are expressly NOT bounces** —
  they are the round working, and they are adjudicated by me.
- **`BM2` — `sample_cycle`'s ordering is altered**, or any new read of an
  `After`-view output is introduced. §5.2, trap T1.
- **`BM3` — a value ordered checked whose expected value this packet does not
  supply.** If you find one, that is **my** defect — **report it, do not invent the
  number.** Reporting it is not a bounce; adopting an invented value is.
- **`BM4` — a WRONG ASSERTED VALUE.** Any constant this packet derives in §6
  written into the source with a different value, without the disagreement being
  reported.
- **`BM5` — a `Clear` or `Enable`-style schedule type is built**, or a multi-frame
  presenter, or a stall scheduler. Capabilities land with their first consumer and
  none of the three has one here.
- **`BM6` — the source withholds a word mid-frame, or an idle-injection wrapper is
  built at M04's source port.** §9.4(1), and since `ee47eee` it is the
  specification's own prohibition.
- **`BM7` — any assertion, comment, title or Return-log sentence names an absolute
  cycle measured from cycle 0, from reset, or from the release of `clear`, rather
  than from `C`.** `M04-A5`, still round-wide.
- **`BM8` — a claim of coverage this round does not have.** Specifically: REQ-206
  described as covered, or `M04-G4` or `M04-G10` named or described as discharged
  (§9.4(3)); `M04-D2`'s residue reported as a **second anchor** for REQ-202
  (§1.3); ADR-0007's CRC-enable mechanism claimed as behaviourally checked
  (`M04-D5`); REQ-205 stated as a universal over terminate characters
  (`M04-E5`); the standing decoder's own REQ-202 verdict reported as family D's
  coverage (§0).
- **`BM9` — an `Octet_time.Latency` tagger is instantiated**, or any latency figure
  for M04 appears anywhere in your output.
- **`BM10` — `tstrb` or `tuser` is varied across runs.** That is family M's
  differential stimulus and half-performing it is worse than not performing it.
- **`BM11` — any unit asserts a value of `tx_tready`.** Reading it is the bench's;
  asserting it is family H's.
- **`BM12` — an expected value is taken from the design's own output**, from a
  loopback, from a co-simulation result, **or hand-written as a literal where this
  packet says it is computed from the oracle** (§6.4 assertion 1); or any file is
  created under `test/cosim/`.
- **`BM13` — the round drives more than 1 700 cycles or elaborates more than 28
  times.** §10.
- **`BM14` — any file outside §11.2's eight appears in your write record**, or any
  of the four landed `test_m04_*.ml` files, or any of the 17 files under
  `test/xgmii_rx_64/`, is modified.
- **`BM15` — `libs/**`, `top/**`, `rtl_snapshots/**` or `test/third_party/**`
  appears in your `Inputs`, your Return log or your write record.** PROTOCOL §10.
- **`BM16` — an instrument outside §17's allow-list is used**, or an attempt at one
  is disclosed **only** in chat and not in your journal. §17.2.
- **`BM17` — the tripwire, armed by condition, pre-committed before its facts
  exist.** `RV-0080B-VERDICT` §5 undertook that **once (a)** an enumerated tool
  allow-list stands at the head of your spawn prompt **and (b)** §17.1 carries the
  spawn-precheck carve-out by name, **a further instrument-outside-the-list
  instance is a bounce on its own, disclosed or not**.
  **(b) is satisfied by this packet — §17.1 below.**
  **(a) is the orchestrator's and is measured, never assumed**: §18 item 9 requires
  your return to state whether your spawn prompt carried such a list and to quote
  its first line. **If it did, `BM17` is armed for this round and a `BM16` instance
  is a bounce.** If it did not, `BM17` is **not** armed, the two prior rounds'
  disposition stands (accept, disclosure credited in full, no sanction), and the
  finding escalates upward again rather than being charged to you. **Disclosure is
  credited in full either way and under both branches** — the tripwire changes the
  consequence of a violation, never the value of disclosing one.

---

## 14. Traps — named so they are not discovered

- **T1 — `sample_cycle`'s `Before` view is the acceptance decision.** You are not
  changing it, and nothing you add may read an `After` view: an `After` read shifts
  `C` by one cycle and every constant in §6 with it, silently, against a conformant
  design.
- **T2 — `C` is not 2**, and asserting that it is fails no design today and freezes
  an unconstrained value into a snapshot tomorrow. SPEC-M04 §6.3 item 4 leaves the
  idle-word count before the first frame unconstrained. Observe `C`, assert nothing
  about it.
- **T3 — the terminate cycle does not move with the length across `P ∈ {60 … 67}`.**
  All eight say `C + 10`; only the lane moves. §4.2(a).
- **T4 — `W` and `F` diverge under padding**, and `M04-G9` is built on the
  divergence: at `P = 1`, one source word and 64 wire octets.
- **T5 — the FCS value convention, and it is this round's one genuine conceptual
  trap.** `Crc32_ref`'s port convention is the **finished** value, whose identity
  element is `0x00000000` because that is `CRC32("")` — REQ-301's initial value
  `0xFFFFFFFF` and its final XOR `0xFFFFFFFF` are both internal and cancel over an
  empty input. **A caller seeds a frame with zero, not with `0xFFFFFFFF`.** Both
  numbers are individually correct; only their pairing is wrong, and taking
  REQ-301's number as the seed builds a bench that fails a conformant design on its
  first vector. **You never seed anything anyway** — `Frame.fcs` does it — and the
  trap is here so you do not "correct" it when the number looks unfamiliar.
- **T6 — `Frame.pad_to_60` does not append an FCS.** It takes the
  DA-through-payload string and returns the padded DA-through-payload string.
  `M04-D1`'s expected value is `Frame.fcs (Frame.pad_to_60 content)` — the pad
  **inside** the FCS computation, which is the whole content of REQ-203's *"pad
  covered by the CRC"*. `Frame.with_fcs` is a separate call.
- **T7 — `Frame.stress_frame` is fixed at 64 octets DA through FCS and has no
  length parameter.** It is **not** this round's content builder; `content_octets`
  and §6.3/§6.4's two explicit strings are. Do not truncate or extend it.
- **T8 — the decoder's `frames` list is empty for a frame still in progress.** A
  frame is listed only once its terminate character has been observed. If `frames`
  is empty, the run was too short or the design never terminated, and those are
  different findings — say which in the failure message.
- **T9 — the wire also carries idle and control characters**, so a naive scan of
  "every octet on the wire" is not a scan of the frame. `/I/` is `0x07`, `/S/` is
  `0xFB`, `/T/` is `0xFD`, `/E/` is `0xFE`. Scan the **decoded frame octets**, or
  the lanes of **named cycles**, never every lane of every cycle without saying
  which. §6.0(c).
- **T10 — the FCS octets are a computed value and may equal anything**, including
  `0x00`, `0xA5` and `0x07`. That is why every content scan excludes indices
  `F−4 … F−1`, and why `M04-D6`'s inequality is asserted against the **oracle's**
  computed value rather than by a scan.
- **T11 — the poisoned `tkeep`-0 positions are still there.** `source_words`
  poisons them with `0xA5` on every run including U13's all-zero frame. They are
  **not** frame octets and must not appear on the wire; if one does, the decoded
  frame's content and its FCS both change, and the failure will look like a family
  D defect when its cause is `M04-C4`'s. **Say which you are diagnosing in the
  message**: the content assertion fires first, so write it first.
- **T12 — a red in this round has six possible meanings and only two of them are
  yours.** §15. Do not repair a suspected design defect, do not adjust an expected
  value to make a run agree, and do not hand-author a snapshot to make a diff go
  away.
- **T13 — a promoted snapshot of a DESIGN output would launder a design defect into
  committed evidence.** U13 prints the **oracle's** value and nothing else. This is
  the reason §6.0(d) rule 3 exists and it is bar M-18.

---

## 15. Disposition classes for a red — PRE-COMMITTED

Written before the run, so that adjudication is not decided by whichever
explanation is most convenient afterwards.

**Naming, because two namespaces overlap in this round**: disposition classes are
written **`class D1`, `class D2`, …, `class P`**; plan rows are written
**`M04-D1` … `M04-D6`**. This packet always writes the prefix.

| Class | What it looks like | Whose | Bounce? |
|---|---|---|---|
| **class D1** | A row's assertion fails and this packet's derived constant for it is right | a **design** defect. I open a `BUG-` to rtl_lead | **No** |
| **class D2** | **A defect in a STANDING INSTRUMENT rather than in the design or in a unit** — the wire decoder, the strobe monitor, the FCS oracle and its `Frame` wrappers, or the bench's own conservation rule. Its signature: an instrument's own report contradicts a reading a unit makes directly from the samples, or an instrument fires on a stimulus this packet derives as conformant | **dv_lead's, for every instrument and not only for the decoder.** Each has its own unit suite and I re-run it | **No** |
| **class D2a** | `Tx_decoder.violations` non-empty, with a REQ named | a **design** defect **or** class D2 — mine to separate, and the separation is the act, not the classification | **No** |
| **class D3** | `P-ACCEPT` fires: the accepted cycles are not contiguous from `C` | either the design stalls mid-frame or §6's derivation is wrong. **Mine.** Every row assertion downstream of it is meaningless and must not be read | **No** |
| **class D4a** | A compile error | bench | **Yes** (`BM1`) |
| **class D4b** | An exception from the bench's own code — an out-of-range index, a `failwith` from a helper, a `Frame` builder raising | bench | **Yes** |
| **class D4c** | **A non-empty `[%expect]` block the worker hand-authored**, or output that differs between runs | bench | **Yes** |
| **class D4d** | A stimulus-contract violation caught by obligation 6's own check | bench | **Yes** |
| **class D5** | You derive a constant of §6 and get a different number, and **report it** | the round working. Credited in full | **No** |
| **class P** | **CI's own diff on the one block this packet commissions a print into (U13), and nothing else in the diff** | a **promotion**, not a defect: the block is empty by design and CI's diff is where its content comes from (ADR-0005 rule 2). Routed to a promotion act, **mine** | **No** |

**Why class D2 is stated over "a standing instrument" and not over the decoder's
name — `FINDING WO-0080-5` (MINOR, mine), repaired here.** `WO-0080`'s §15 named
the **decoder** as the instrument-defect vehicle (*"or a decoder defect. Mine to
separate"*) while that round attached **two** standing instruments. Had the fault
been in the strobe monitor's own expectation model rather than in the design, that
table would have had **no class for it**: `D2` named one instrument, and
`D4a`–`D4d` are all bench-seat classes that would have routed a **dv-owned**
instrument defect to the worker. It did not fire, so it changed no route and I did
not fill the gap by improvising after seeing a result. **It is filled here, before
the facts, and this round attaches a third instrument to the set — the FCS
oracle — which is precisely the case the old wording would have mis-routed.**

**Why class P is new, and why it is not a licence.** This round commissions the
first printed value in this directory (§6.0(d)). A red whose whole diff is that
block is a promotion, not a defect — but the class is narrow on purpose: **any
other content in the diff, and it is not class P.** A diff touching a second block,
or a block in another directory, is `D4c` and a bounce.

**class D5 is the class the last several rounds of this chain were actually decided
by**, each by a defect in my instructions rather than in the work. Reporting a
disagreement is the behaviour `BM3` and §17.3 ask for; adopting a number you cannot
derive is `BM4`.

---

## 16. Incremental-write and expected-CI discipline

### 16.1 Order of work

**One round, one worker, one commit**, with the internal order staged so that
stopping early stops at a coherent point.

1. `bench.mli` then `bench.ml` — `run_frames`, and `run_lengths` re-expressed over
   it. **This is the only change that can break something already green**, so it
   goes first and alone.
2. `test_m04_d.ml` — U11, then U12, then U13 (U11 is the expensive one but it is
   also the one every other family-D unit's shape follows).
3. `test_m04_e.ml` — U14, then U15.
4. `test_m04_g.ml` — U16.
5. `dune` — the header row line, last, when the row list is final.

### 16.2 The five standing rules for a bench in this programme

1. **Every `[%expect]` block you write is EMPTY** (ADR-0005 rule 2). Snapshots are
   promoted from CI's own diff output, never hand-authored. **A hand-written
   snapshot is fabricated evidence**, and that includes U13's printed value.
2. **Every verdict is asserted in OCaml** — `failwith`, `raise`, or a checked
   counter — so that a promotion which captured wrong output still leaves a red
   test. A test whose only judge is its snapshot is a test that passes as soon as
   someone promotes it. **U13 is the unit where this rule earns its keep**: its two
   assertions are the verdict and the print is data.
3. **No waveform snapshots and no timing figures inside `[%expect]`.**
   `hardcaml_waveterm` is not in this directory's `dune` stanza and no unit needs a
   waveform.
4. **Name every unit after its rows** (§11.1) — the `SO-` coverage map is built
   from these titles by hand.
5. **`tools/precompile_check.sh` will NOT cover this directory** — it excludes any
   library depending on `hardcaml_ethernet`, because stubbing the design under test
   would mean reading it. It is also outside your allow-list. **For this directory
   CI is the only compiler** (ADR-0005), which is exactly why rule 1 of §16.1
   exists.

### 16.3 The expected-CI discipline — checked versus predicted

Your Return log must state, **before the run happens**, what you expect CI to do,
and must distinguish *checked* from *predicted*. The house rule, paid for at
`WO-0033`: **where a claim is checkable, run the check; where it is not, write
"unverified" and say why.**

*"Build is expected green"* on the strength of care is not evidence. *"Build is
unverified — no local toolchain reaches this directory (ADR-0005) and my seat has
only `ocamlc -stop-after parsing`; the names new to this repository's proven API
surface are X, Y, Z"* is.

**State separately**: (a) `dune build @default`; (b) `dune runtest` — **expected
RED on its first reaching, with a diff confined to U13's `[%expect]` block and
nothing else** (§6.0(d), class P); (c) the step *"Verify nothing was left
unpromoted or non-deterministic"*; (d) **the list of names you could not check
locally**.

**Start list (d) with these, and the first entry is the repair
`FINDING WO-0080-1(c)` commissioned**:

1. **Every arithmetic operator whose spelling differs between the stdlib and
   `Base`** — `mod` is the one that bounced the last round of this chain, and the
   general form of the hazard is *a familiar spelling that means something else
   here*, not an unfamiliar name. `Int.rem`, `Int.max`, `Int.( / )`, comparison
   operators on non-`int` types, and `List.equal`'s explicit element-equality
   argument all live in that class. §4.1.
2. `Frame.fcs`, `Frame.pad_to_60`, `Frame.residue_ok` — landed and unit-tested,
   **never yet called from this directory**.
3. Any `Xgmii_word` accessor you use for the first time here (`lane`,
   `is_control`, the `data` array's own indexing).
4. Whatever printing function you choose for U13 — it is the first in this
   directory and its module may not be in scope where you expect.

---

## 17. Your terms — the allow-list, unified with the dispatch precheck at this packet

**Read this preamble; it is the repair of a structural defect and not boilerplate.**

For six rounds a worker on this chain has met a **forced violation**: this packet's
§17.1 forbade every `git` subcommand, while the orchestrator's spawn dispatch
**mandated** two of them as an abort-first precheck. Six instances, six
disclosures, zero concealments (`RV-0071-VERDICT` §3's tally of four, which I quote
with its provenance and have not re-measured, plus the two I read myself at
`J-dv_lead-0175` and `J-dv_lead-0176`). At `RV-0080-VERDICT` §6 I ruled that *a
rule that forces a violation and then convicts it is worse than the violation*, and
undertook to carve the precheck out by name on the re-issue — **and then did not
do it**, so the next worker met the same conflict uncured (`FINDING WO-0080-6`,
MATERIAL, mine). I escalated the structural half to the orchestrator at
`J-dv_lead-0176`; it is owned at `J-orchestrator-0249` with **the next `WO-`
dispatch as the closing event**.

**This is that packet, and the two instrument sets are unified here**: the
allow-list below and the dispatch precheck now name the same set. §17.1 carves the
two precheck commands in **by name**; the tripwire `BM17` is written at §13 before
its facts exist; and the disposition table's instrument-defect gap
(`FINDING WO-0080-5`) is repaired at §15. **A later auditor reading this section
can see the repair happened and where.**

### 17.1 The allow-list

Your permitted instruments are, in full:

1. **File read** — reading any file in the repository *except* the paths §8
   forbids, and file/content search over it (the Read, Grep and Glob tools).
2. **File edit and write** — **only** at the six paths §11.2 names, plus this
   packet's Return log, plus your own journal at
   `agents/journals/workers/claude_tb_writer_agent*.md`.
3. **`ocamlc -stop-after parsing`** on the OCaml files you wrote or edited.
4. **The two spawn-precheck commands your dispatch mandates, by name:
   `git status --short` and `git rev-parse HEAD`.** Each **once**, at the head of
   your round, **before anything is read**, with their output quoted in your
   journal's Trigger section. This is the carve-out
   `RV-0080-VERDICT` §6 promised and `FINDING WO-0080-6` convicted me of not
   making.

**Everything else is forbidden**: every **other** `git` subcommand — `diff`,
`show`, `log`, `add`, `stash`, and `status` a **second** time — `dune` (every
subcommand, ADR-0005), `tools/*.sh` (every script), the network in every form, and
**any other shell command whatsoever**, including `grep`, `sed`, `awk`, `cat`,
`find`, `ls` and `wc`. Where §12 gives you a bar phrased as a search, execute it
with the file-search tool and by **reading the hits**, never with a shell pipeline.

**The carve-out is exactly two commands at exactly one point, and §17.3 is
unchanged by it.** The precheck is an abort-first check on the substrate *before
you write anything*. A `git status` run *after* your edits, to enumerate what you
wrote, is a different act with a different purpose and it remains forbidden by name
— see §17.3, which is the clause that act violates and which this carve-out does
not touch.

**Flag, do not improvise.** If a bar in §12 appears to you to need an instrument
outside this list, **stop and say so in your return and in your journal**. Do not
find a way around it and do not substitute a weaker instrument silently. A bar that
cannot be executed at your seat is my defect, and it is one I want reported.

### 17.2 The durability clause — a return demand

**If you attempt an instrument outside your seat and are refused — by the
environment, by a permission prompt, or by your own judgement mid-command — that
attempt goes into your JOURNAL** (Evidence or Open-questions), not only into your
return message. A disclosure that lives only in chat does not survive the session:
`RV-0071-VERDICT` §3 had to withdraw a claim precisely because a previous round's
disclosure was chat-only and the evidence was unrecoverable. **Disclosure is
credited in full either way**, and under both branches of `BM17`; the point is that
the credit must be readable from the repo.

### 17.3 The substitution clause

You cannot enumerate your own staged set and **must not reach for `git status` to
try** — the carve-out at §17.1 item 4 is the *pre*-round precheck and is not a
licence for this. Your instrument for the files-list obligation (PROTOCOL §4.2, and
§18 item 5) is **your own record of what you wrote, with §11.2's list as the
authority**. That is the sanctioned substitute, it is sufficient, and it is not a
second-best. Likewise you cannot compare against the base tree: **every base-side
figure any bar needs is pre-committed in this packet** (§12's base column), so you
check against this packet and never against history.

---

## 18. Your return

Append a `### RETURN — tb_writer, spawn <short-id>` section to this packet's Return
log carrying, in this order:

1. **What you built**, file by file, against §11.2's six.
2. **Every bar in §12 marked *worker*, with its raw output or the exact lines you
   read** — `M-8` through `M-19`. Quote, do not summarise, where the bar says
   *quote*.
3. **Every constant of §6 you checked, and every one you disagree with.** A
   disagreement with any number of mine is a finding I want, and the last several
   rounds of this chain were each decided by a defect in my instructions rather
   than in the work. **Do not adopt a number of mine you cannot derive; report it**
   (`BM3`, class D5).
4. **The verbatim `run_frames` body and the re-expressed `run_lengths`** that `M-8`
   demands, and the **single expression** in which the run-length formula lives.
5. **Your files list**, from your own write record with §11.2 as the authority
   (§17.3), and your journal entry id.
6. **Your expected-CI statement** (§16.3), with *checked* and *predicted* separated,
   the unchecked-names list, and **the explicit prediction that `dune runtest` is
   red on its first reaching with a diff confined to U13's block**.
7. **Any instrument you attempted outside §17.1's list, and its outcome** — in your
   journal as well as here (§17.2).
8. **Anything in this packet you could not execute as written**, and anything in
   §5.1's capability table you found to be wrong in either direction (§9.3).
9. **The tripwire's arming condition, measured** (`BM17`, §13): state whether the
   spawn prompt you were given carried **an enumerated tool allow-list at its
   head**, and **quote its first line** if it did. This is a factual report about
   your own dispatch, it is not a judgement about anyone's conduct, and it is the
   one input `BM17`'s arming turns on — I will not infer it.

**What you do not do**: run `dune`; run any `git` subcommand beyond §17.1 item 4's
two; touch a seventh source file; modify any of the four landed `test_m04_*.ml`
files; adjust a constant to make something agree; hand-author a snapshot; open
`libs/**`; claim coverage `BM8` forbids; or judge whether a unit will pass. **The
verdict is CI's and the adjudication is mine.**

---

## 19. What this round does NOT carry, and what I owe after it

### 19.1 What this round does not close

- **No `SO-xgmii_tx_64.md`.** After this round 12 more rows discharge, taking the
  plan to **57 of 82 outstanding**. `BAR T1` stays SHUT, `AP-M04` §0.2 item 4's
  REQ-206 bar stays in force, and the sign-off is not opened or offered.
- **REQ-202 is claimed, REQ-206 is not.** Family D discharges REQ-202 and REQ-305
  against a committed external anchor; `M04-G9` discharges one silence and
  **nothing else** of REQ-206 (§9.4(3)).
- **`M04-E2`'s fill is asserted to the end of a one-frame run, not to a following
  preamble** (§6.5). The stale-lane-before-the-next-preamble shape is the
  two-frame round's and I carry it below.
- **The mutation campaign for these families is not scheduled here.** PROTOCOL §10
  sequences it after the `RV-` ACCEPT and before any `SO-` PASS; scheduling is the
  orchestrator's and my recommendation remains the per-family cadence.

### 19.2 What I owe after this round — mine, named with their carriers

1. **`DVC-1a`, the M04 row-status census in `tools/dv_checks.sh`** — still unbuilt,
   now wanted by three plans, and **it should land before any `SO-` quotes an M04
   coverage fraction**. Every M04 count in this packet is a hand count with its
   method stated (§9.7). Mine, `tools/**`.
2. **The transmit-side conservation monitor** (`AP-M04` §7 item **T-2**) — the
   bench still carries the counting rule itself. Mine, `test/monitors/**`.
3. **Machinery T-7 and `M04-G10`** — a direct-drive continuous source with a
   controllable handover at `C + 8`, for `BUG-0004`'s two derived-and-never-measured
   routes. Mine, in the round that first opens a back-to-back bench at M04. It is a
   **sign-off gate condition**, not a convenience.
4. **The two-frame round** — `M04-A3`, `M04-A4`, `M04-B3` and family F, all of
   which need the multi-frame presenter, plus `M04-E2`'s
   last-gap-word-before-a-preamble residue (§6.5). One capability, four families'
   worth of rows, and it is the natural round after this one.
5. **The three `BAR T1` work orders** — vendoring the transmit reference at a pin
   (its own commit, ADR-0015 D2), a transmit harness and canonical form, and
   REQ-901's divergence classes. Orchestrator, as scheduling; (c) gates what (b)
   may compare and (a) gates (b) entirely.
6. **The promotion of U13's snapshot** (class P, §15) — mine, from CI's own diff,
   in a separate act, and the round's `RV-` cannot ACCEPT before it lands because
   bar `M-2` requires a green `Run tests`.

### 19.3 The two lessons this packet is the discharge of, stated so the next auditor can check them

- **`FINDING WO-0080-6` (MATERIAL, mine)**: *the packet repairs a verdict promises
  must land before the next round meets them.* Six were promised at
  `RV-0080-VERDICT` §8 and none was made, so the next worker met the same forced
  conflict uncured. **All six are in this packet**: the `Int.rem` gloss (§4.1), the
  operator-bearing reference file (§3, `test_m03_h.ml`), §16.3's operator clause
  (list item 1), the infix-`mod` bar (**M-17**), §17.1's precheck carve-out (item
  4), and `WO-0080` §7.1's reset-cycle wording brought into agreement with the
  bench (§7). **This packet is the proof they landed**, and `M-17`'s base figure is
  the measurement that the seventh — the scan-domain quantifier of
  `FINDING WO-0080-4` — is a round-wide rule here (§6.0(c)) rather than one row's
  cure.
- **`FINDING WO-0080-5` (MINOR, mine)**: repaired at §15's class D2, restated over
  *a standing instrument* rather than over one instrument's name, routing to
  dv_lead in every case.

---

## Return / verdict log

*(Empty at issue. The worker appends its `### RETURN` section here per §18; the
`RV-0081-VERDICT` follows it.)*
