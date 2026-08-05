# AP-M03 — attack plan for `Xgmii_rx_64`

- **Module**: M03 `Xgmii_rx_64` · spec `docs/specs/modules/xgmii_rx_64.md`
- **Status**: **OPEN** — committed before the first M03 bench, as charter §3 and
  ADR-0001 require. Rows are added by appending; no row is ever renumbered.
- **Spec basis**: SPEC-M03 **FROZEN at `f78766e`**, *plus every §13 row through
  the C-18 diff* — the frozen text and its recorded diffs together are the
  specification (WO-0024's own formulation). requirements.md §0.3, §0.4, §0.5,
  §0.6, §0.7, §1.1, §2 (REQ-101 … REQ-113), §12; SPEC-M01 §6.1/§6.3 (the stream
  encoding the output must obey); SPEC-M02 §6.1 + ADR-0006/ADR-0007 (the
  finished-value convention and the 1-to-8 `octet_count` domain M03 must never
  leave). Carry-forwards realised as rows: **C-11**, **C-12**, **C-14.3**,
  **C-14.4**, **C-14.5**, **C-18**, **C-2**, **C-23**.
- **Derivation (PROTOCOL §10)**: every row below is derived from specification
  text alone. `libs/**` was not opened by the author of this plan, at this
  commit or at any earlier one. Where a row exists *because* rtl_lead returned a
  question (family N), the question is cited as a question — the expected
  observable in that row is derived from the specification, never from the
  answer rtl_lead gave.
- **Author**: dv_lead, journal `J-dv_lead-0013` (WO-0027)

---

## 0. What this document is, and the format it defines

This is the programme's **first** attack plan, so its shape is the template
every later `test/attack_plans/AP-<module>.md` follows. Sections 1 to 9 below
are the fixed skeleton; a later plan may add rows and families but not drop a
section.

An attack plan is **not** a test list. A test list says what will be run; an
attack plan says, for each attack, **which wrong design it kills**. That last
column is the one the plan exists for: a row whose "kills" cell says only "a
broken design" is a row that has not been thought about, and the auditor is
invited to mine this document for exactly that failure.

The plan is written **before** any bench, so that the bench is commissioned by
a reviewed adversarial argument rather than by whatever the bench writer
happened to think of. The `SO-` packet's coverage section maps each test back to
a row id here, and every row must end in one of: a named test, a declared gap,
or a NO-ASSERT/NO-STIMULUS ruling with the clause that forbids it.

### 0.1 A claim about a SET, carried in prose, must be re-measured at citation or carry the SHA it was measured at

Added 2026-08-06 (`J-dv_lead-0118`), minted by `FINDING WO-0066-3` and `FINDING
WO-0066-6` (`WO-0066-VERDICT` §9) — **which are one failure twice, and the
verdict says so in terms.** The rule binds this plan's own prose, every packet
that quotes this plan, and every campaign seal frozen against it.

> **A sentence asserting the result of a census is not the census.** Any claim
> that **quantifies over a set** — *"the only row that …"*, *"no unit drives …"*,
> *"the nine units that …"*, *"the threshold is …"*, *"every member of …"* —
> whether the set is of rows, bench units, stimuli, requirement clauses or
> numbers, is **re-measured at the point of citation**, or it is quoted **with
> the SHA and the command it was measured at**. **A set claim carrying neither is
> not evidence**, and a seal, `SO-` or verdict resting on one is adjudicated as
> resting on nothing.

**The two instances that minted it, both dv_lead's, both inside one round.**

1. **`WO-0066-3`** — a sealed REQUIRED-GREEN cell derived from a runt floor of
   **five** octets, quoted from the wrong requirement, where requirements.md §12's
   predicate is *"fewer than **64** octets between start and terminate"*. A
   threshold is a one-element set claim and it failed the same way a list does.
   Cost: **two MUST-STAY-GREEN violations** against the seal's author.
2. **`WO-0066-6`** — `WO-0058` §9 bound 7's premise (*"no unit drives an in-word
   abort with a frame already open on entry"*, carried at §4.H bound 2 until it
   was struck) was **false at the moment it was written**, and the census that
   refutes it was **never run because the sentence read as settled**. It was
   quoted unre-measured at every site the verdict enumerates — `WO-0058`, where
   it was written, then `WO-0061`, `WO-0062`, `WO-0063B`, `WO-0065`,
   `RV-0065-VERDICT`, `RV-0065B-VERDICT` and `WO-0066` §4. **That enumeration is
   the measurement; a bare packet count is not, and this note deliberately does
   not carry one** — which is this rule obeyed at the site that mints it. Cost:
   **two more
   MUST-STAY-GREEN violations**, and the retirement of a claim about what one row
   uniquely buys.

**Why the tool does not cover this, stated so its existence is not mistaken for
coverage.** `tools/dv_checks.sh`'s boundary-matched row-discharge census answers
exactly one question — *which plan rows are named in a committed unit title* —
and **covers neither instance above**. `WO-0066-3` is a **row-status / threshold
claim** (what a cell asserts, and which requirement's number it asserts it from);
`WO-0066-6` is a **cross-row premise claim** (which units drive a named stimulus
geometry). Neither is a title match. **The tool shipped in the same round that
produced both findings and would have caught neither**, which is worth knowing
about a tool built to prevent exactly this class.

**COMMISSIONED, NOT BUILT HERE — `DVC-1`, a two-part `tools/dv_checks.sh`
extension. Executor: dv_lead, in the next round that opens `tools/`.** It is
named with an executor precisely so it cannot evaporate into a good intention,
and it is **deliberately not built in this round**: a plan round is not where
tooling lands (`J-dv_lead-0112`'s own rule, applied here to its author). The two
parts, with what each can and cannot do:

- **`DVC-1a` — row-status census.** Print every declared row id with its
  `Status` token and every REQ id its `Attacks` cell names. Mechanical, because
  the row tables are regular. It makes *"which rows are ASSERT"* and *"which rows
  attack REQ-x"* answerable by command instead of by recollection — the shape
  `WO-0066-3` needed.
- **`DVC-1b` — stimulus-geometry census.** Per bench unit under
  `test/xgmii_rx_64/`, print the geometry its own docstring **declares** (start
  lane, aborting-character lane, whether a frame is open on entry), so a claim of
  the form *"no unit drives X"* is checkable **at the moment it is written** —
  the shape `WO-0066-6` needed. **Bounded, and the bound is part of the
  commission**: it reports what docstrings **declare**, never what stimuli
  **do**. A docstring census is evidence, not proof, and it **does not** relax the
  rule above — the measurement still ships with its SHA.

**`DVC-1` is carried here and not in §7**, deliberately: §7's table is machinery
a **row** needs, and **no row is blocked on this**. What needs it is the plan's
own discipline, which is what §0 is for.

## 1. Reading a row

Each row has six cells.

| Cell | Meaning |
|---|---|
| **Row** | Stable id, `M03-<family letter><index>`. Ids are permanent: a superseded row is struck in §9's change log and keeps its id; new rows append inside their family. Tests and `SO-` packets cite these ids. |
| **Attacks** | The REQ ids and specification sections the row attacks. A row that cannot name one is not an attack, it is an opinion. |
| **Stimulus** | What the link-partner model drives, in the specification's own units (octet times, lanes, frame lengths DA through FCS per §0.3). |
| **Observable** | Exactly what a bench asserts, at the ports only. Nothing internal ever appears here. |
| **Kills** | The wrong design this row detects, stated concretely enough that a reader can see the row fail against it. |
| **Status** | See below. |

**Status vocabulary** (the same six values in every plan):

- **ASSERT** — a bench must assert the Observable. The default.
- **NO-ASSERT** — the stimulus may be driven but the named property must **not**
  be asserted; the clause that forbids it is cited in the Observable cell.
  Asserting it would fail a conformant design, or would freeze an unconstrained
  choice into an accidental requirement.
- **NO-STIMULUS** — the stimulus must **not** be produced at all: it lies
  outside the space the specification constrains or outside REQ-018's
  link-partner contract.
- **RULING** — the frozen text does not decide the observable. The row records
  every reading and its consequence, and is **not asserted** until a ruling
  lands (the precedent is C-12, which `test/xgmii/arrival.mli` already held as
  NO-ASSERT until requirements.md settled it). A `RULING` row blocks no bench
  except its own.
- **GAP** — an attack this plan wants and cannot mount. The reason is named and
  the row is carried, not deleted, so a sign-off packet cannot claim the
  coverage by silence.
- **STRUCTURAL** — discharged by a compile-time or script check, not by a
  waveform. Recorded so no `SO-` claims a behavioural test that does not exist.

## 2. Standing obligations

These attach to **every** M03 bench and are not repeated per row.

1. **Protocol monitor** (`Dv_monitors.Protocol_monitor`) on the `rx` output
   stream, with `~max_words_per_frame:190` (REQ-015, SPEC-M03 §7). It carries
   REQ-011's contiguity and full-word rules and REQ-014's producer half.
2. **Frame-conservation monitor** (`Dv_monitors.Conservation_monitor`), §0.6.
   Two exemptions are **mandatory** and are C-2's machinery becoming
   load-bearing at its first module: a frame presented while `clear` = 1
   (REQ-009, family K) and a frame presented while `cfg_rx_enable` = 0
   (REQ-810, family J) are `frame_in_exempt`, never `frame_in`. A monitor
   without them fails a conformant M03 — that is not a hypothetical, it is what
   §7's "the one place in this specification where a frame vanishes without a
   strobe" means for a counter.
3. **Per-octet latency tagger** (`Dv_monitors.Octet_time.Latency`) configured
   `~strip_octets:8 ~tail_octets:4 ~front_offsets:[8; 12] ~ceiling:4`
   (REQ-102, REQ-103, SPEC-M03 §7, §1.1). Constancy is judged **per front-offset
   class**, never as one L across a two-lane run (§0.5 "Start lanes", C-15).
4. **Strobe accounting** follows requirements.md §0.6's counting convention as
   revised by **C-23**: a monitor counts **high cycles, never rising edges**.
   M03 is not exempt from that convention — see **M03-H4**, which produces two
   `error_start_without_terminate` events on consecutive cycles.

   **The no-output-word registration inventory — MEASURED, not recalled**
   (`J-dv_lead-0106`, confirmed by measurement at `WO-0063B-VERDICT` §1 and §5;
   transcribed here `J-dv_lead-0109`). **Nine** committed units register a
   `Strobe_monitor` expectation on §9's **no-output-word pin**, and the plan
   states them so that no later campaign re-derives the set from memory:
   `run_b2` (`test_m03_b.ml:743`), `run_b3` (`:542`), **`run_b4` (`:337`)**,
   **`run_e2` (`test_m03_e.ml:429`)**, `run_e5` (`:731`), `run_f2`
   (`test_m03_f.ml:425`), **`run_g7` (`test_m03_g.ml:1375`)**, **`run_h4`
   (`test_m03_h.ml:939` and `:951`)** and `run_i2_zero_octet_member`
   (`test_m03_i.ml:714`). **The four in bold were absent from every recalled
   enumeration this programme carried** — five was the remembered figure, nine
   is the measured one, and a campaign sealed against five would have scored
   four true reds as findings against its seeder. Three consequences, each a
   correction of text I wrote. (a) Each of the nine registers **exactly one**
   such expectation and it is that unit's only one, so the *"sub-cases"*
   vocabulary that made the set look small enough to recall is withdrawn.
   (b) **M03-G7 and M03-H4 are NOT "monitor-only"**: each carries a row-local
   strobe-set or strobe-order check that speaks first
   (`test_m03_g.ml:1463`/`:1465`, `test_m03_h.ml:1017`/`:1019`), and the
   mis-classification came of searching for two message *forms* rather than for
   the defect (`WO-0063B-VERDICT` §6.2). (c) Under `WO-0063B`'s IC-1 all nine
   reddened and **every conviction was row-local**; the standing monitor spoke
   at none of them, so the per-row assertions are the whole of this bench's
   report-path assurance and exactly one of them (M03-I2's window) reads
   against a drain bound.
5. **Every frame the link partner emits is checked against the requirement it
   encodes before it is presented** (`Arrival.check`, `Frame.residue_ok`). A
   stimulus generator nobody has checked is an unverified assertion about the
   design.
6. **No bench reads `tdata` at positions where `tkeep` is 0, or any output field
   on a cycle with `tvalid` = 0** (SPEC-M01 §6.3 item 5, SPEC-M03 §6.3 item 4).

## 3. Stimulus legality

REQ-018 fixes the link partner's contract: it emits start characters **in lane 0
and lane 4 only**, including REQ-004's alternation; it injects each condition
named in REQ-104, REQ-105, REQ-107, REQ-108 and REQ-110; and it decodes
transmit-side XGMII. Three consequences bind every row below.

- A start character in a lane other than 0 or 4 is **never driven** (§6.3 item
  3, row M03-O4). Rows that would otherwise want one are re-expressed at lane 0
  or lane 4 or they are not written.
- The six preamble filler octets and the SFD octet may hold **any** value
  (REQ-102 forbids M03 from validating them), so no bench may assert on them at
  the receiver even though the model emits 0x55/0xD5.
- The inter-frame gap is measured **from the terminate character inclusive**,
  minimum 12 octets (§0.3). Every spacing figure in this plan is in that
  convention.

---

## 4. The rows

### 4.A Start detection, alignment and byte order — REQ-101, REQ-012, REQ-021, §6.1

| Row | Attacks | Stimulus | Observable | Kills | Status |
|---|---|---|---|---|---|
| **M03-A1** | REQ-101, REQ-103, §6.1 cycle table | One 64-octet frame, lane-0 start, gapless, correct FCS | 8 output words; words 0–6 `tkeep` = 0xFF, word 7 `tkeep` = 0x0F carrying octets 56–59 with `tlast` = 1 and `tuser`[0] = 0; output word m on cycle m + 3 counted from the start word; no strobe | A pipeline one cycle early or late (ΔC ≠ 3); an FCS strip that removes 4 octets from the wrong end | ASSERT |
| **M03-A2** | REQ-101, REQ-021, §6.1's lane-4 paragraph, **C-18** | The same 64 octets, lane-4 start (`/S/` in lane 4 of cycle 0; frame octets 0–3 in lanes 4–7 of cycle 1) | The same eight words with the same `tdata`/`tkeep`/`tlast`/`tuser` tuples; output word 0 on cycle 3; **FCS verdict good** (`tuser`[0] = 0, no `error_bad_fcs`) | **The C-18 defect made executable**: a design that treats the second preamble word of a lane-4 start as covering no frame octet holds the CRC register across frame octets 0–3 and fails the FCS check of *every* lane-4 frame. Also kills a barrel shifter that aligns to the input word rather than to the frame | ASSERT |
| **M03-A3** | REQ-101 | The directed length set of M03-C1 driven twice, once per start lane | Equality of the two runs as **ordered sequences of (`tdata`, `tkeep`, `tlast`, `tuser`) tuples over words with `tvalid` = 1** | A design whose lane-4 path drops or duplicates a word, or reorders octets within word 0 | ASSERT |
| **M03-A4** | REQ-101, §6.1, §10's REQ-101 hook | (same runs as M03-A3) | **The absolute cycle of the first output word is NOT asserted equal between the lanes.** §6.1: the equality M03 happens to achieve "is a property of the constants §7 pins, not an obligation, and a bench SHALL NOT assert it as one for other modules"; §10 repeats it for this module | — (a row that exists to stop a bench freezing an unrequired property into a snapshot) | NO-ASSERT |
| **M03-A5** | REQ-012, REQ-021 | A 64-octet frame whose octets are **position-dependent** (`Frame.stress_frame`'s default filler), at both start lanes | Frame octet j appears at `tdata`[8·(j mod 8)+7 : 8·(j mod 8)] of word ⌊j/8⌋; octet 0 at `tdata`[7:0] of word 0 | Lane reversal, a byte-swapped word, or a rotation by 4 at a lane-0 start — **all three are invisible under uniform filler**, which is why the filler is position-dependent and stated | ASSERT |

### 4.B Preamble and SFD — REQ-102, §6.1, §9

| Row | Attacks | Stimulus | Observable | Kills | Status |
|---|---|---|---|---|---|
| **M03-B1** | REQ-102 | 64-octet frame whose six filler octets and SFD octet are arbitrary non-standard **data** values, both start lanes | The frame is delivered unchanged: same 60 octets, same `tkeep`, `tuser`[0] = 0, no strobe | A receiver that validates the SFD or the filler and drops a legal frame from a nonstandard-but-legal link partner (REQ-102's own reason for forbidding the check) | ASSERT |
| **M03-B2** | REQ-102, REQ-105, §0.7, §9 row 3 | **Three character members at preamble position 3, each at both start lanes** — the placement is held fixed and the character is the variable: (a) **`/E/`** — lane 3 of a lane-0 start word, lane 7 of the start word at a lane-4 start; (b) **`/I/`** — the same two placements (**WIDENED 2026-08-04**, note **B-ii**: §4.N's M03-N3 names this row as the carrier of the idle-in-preamble REQ-105 case and this cell did not carry it); **DRIVEN 2026-08-05** — `test_m03_b.ml`'s `run_b2_new`, both start lanes, landed at `88413b9` and **green** in CI `build` run `30961544649` (`RV-0065-VERDICT`); (c) **`/Q/`** — the same two placements, **DRIVEN 2026-08-05** at `88413b9` (`run_b2_new`, both start lanes, green in the same run), note B-ii's **obligation 1 DISCHARGED** by `WO-0065` §3.2.1's ruling, transcribed into note B-ii below | **No output word at all** for that frame; exactly one `error_bad_frame` high cycle, on the cycle two after the input word carrying the character; the next frame is received intact. Members (a), (b) and (c) differ in exactly one variable, so their observables are identical figure for figure — a difference between them is this row's own defect signature (the three-member form since 2026-08-05; the cell read "(a) and (b)" while `/Q/` was carried and not driven) | A design that recognises `/E/` only in `Frame` state and emits nothing *and* pulses nothing (a silent discard, REQ-008); and a design that emits a zero-octet word (`tkeep` = 0, REQ-011). **Member (b) alone** kills a design that carries REQ-113's ignore rule — a control character other than the start character occurring **outside** a frame is ignored — into a **preamble position**, which is *inside* an open frame: such a design is silent where REQ-102's third sentence demands one `error_bad_frame` and no output word, and **no `/E/` stimulus in this plan can separate it from a conforming one**, because `/E/` routes to REQ-105 under both readings. **QUALIFIED 2026-08-06 — two scoreable classes, two kills, 2/2** (`WO-0066-VERDICT` §2 and §3, disposition 1 at both; `J-dv_lead-0117`, recorded here `J-dv_lead-0118`). Recorded in this cell with the Status cell left at `ASSERT`, on the same grammar as M03-I2's and M03-N2's (§1's six-value vocabulary; `J-dv_lead-0109`). **IC-D — REQ-113's ignore rule carried into a preamble position** (disclosed `D-D2 = wide`): members **(b) `/I/`** and **(c) `/Q/`** reddened at lane 0 with seal §4.4's branch-C cells character-exact, and the raise site is `test_m03_b.ml:1297` — the **output-word** check, not the pulse check, which confirms the disclosed `D-DF1 = C` by measurement. **Member (a) `/E/` stayed GREEN, and that control is what makes the kill mean anything**: an `/E/` routes to REQ-105 under **both** readings, so a rendering that reddened it would have changed the outcome for **every** character rather than the routing for the ones REQ-113's ignore rule misses. **IC-F — the closed code table**: member **(c) `/Q/` reddened ALONE**, with **(b) `/I/` green and (a) `/E/` green**. **THE SEPARATING OBSERVABLE, AND IT IS THE RESULT THIS ROW MOST NEEDED.** IC-D and IC-F produce **identical message strings** — seal §4.4 recorded that *"the only discriminator is which diff was applied"* — so the plan's ability to tell the two classes apart rested entirely on running them as **separate transients** in the order the pre-run reading note fixed. The measured asymmetry is **`/I/` RED under IC-D and GREEN under IC-F**, with `/Q/` red under both: **the three members are separated by measurement rather than by assertion**, no red carries a combined-class signature, and this cell's *"a difference between them is this row's own defect signature"* is now a statement with a campaign behind it. **NOTE B-ii OBLIGATION 1'S RULING IS THEREBY PAID BY MEASUREMENT, not merely admitted.** `/Q/` was driven at `WO-0065` §3.2.1 over a REQ-018 objection dv_lead overruled on SPEC-M03 §6.2's own `Preamble` row; IC-F is what that ruling bought — **`/Q/` is the only stimulus in this plan that separates routing by the CONTROL BIT from routing by an ENUMERATION, and it has now done so.** A ruling carried on four grounds of argument now has a kill under it, which is the strongest form in which this plan can hold a contested sub-member. **Lane 4 is recorded UNOBSERVED — never as a pass and never as a miss**: seal §5.3 pre-fixed that `List.iter [ 0; 4 ]` runs lane 0 first, so the lane-4 cells are **structurally unobservable** in a passing-to-failing run; the auditor discharged R-DISC-1 **per lane**, so lane 4 is reachable by term-by-term evaluation and merely unobserved. Observing it needs a lane-4-only driver built for the purpose, exactly as at M03-I2. **Qualification measures an instrument: it discharges no row, moves no discharge count and changes no status** | ASSERT |
| **M03-B3** | REQ-102, REQ-107, §0.7, §9 ruling 9 | `/T/` in a preamble position (lane 5 of a lane-0 start word) | No output word; **exactly one `error_runt` high cycle and no other strobe of any kind** (an exact set, strengthened from a lower bound by §9 ruling 9 at `1fe71ca` — this frame delivers zero octets and is therefore in the sub-5 class) at the pinned cycle; next frame intact | A design routing a preamble `/T/` to REQ-106 (which would either emit a frame from preamble octets or close silently); and, through the exhaustive strobe set, a design that runs the residue comparison at every terminate character (M03-M10) | ASSERT |
| **M03-B4** | REQ-102, REQ-110, §0.7 | **Two members — the same `At_preamble 4` placement at the two start lanes, from the same 68-octet array** (4 filler octets, then a clean 64-octet frame): (a) **lane-0 start** — the `/S/` lands in **lane 4 of the word whose lane 0 carried the frame's own `/S/`** (§10's own hook): an **in-word** abort of a frame opened in that same word, alignment transition **0 → 4**; (b) **lane-4 start** (**ADDED 2026-08-04**, note **B-i**; **DRIVEN 2026-08-05** — `test_m03_b.ml`'s `run_b4b`, landed at `88413b9` and **green** in CI `build` run `30961544649`, `RV-0065-VERDICT`) — the identical placement lands in **lane 0 of the following word**: a **cross-word** abort of a frame **already open on entry** to that word, alignment transition **4 → 0**, and the only stimulus in this plan whose preamble-position control character lies outside its own frame's start word | Per member: no output word for the first frame; exactly one `error_start_without_terminate`, pinned two cycles after the word carrying the aborting `/S/` — member (a)'s own start word, member (b)'s *next* word; the second frame received intact and correct, asserted **content for content** (64 octets received, 60 delivered in 8 words, final `tkeep` 0x0F, `tuser`[0] = 0, no strobe). **The figures are identical at both members because the array is identical** — the members differ only in input geometry and in the strobe cycle | A design that ignores `/S/` while in `Preamble` — it would mis-align the second frame by four octet times and deliver a corrupt frame with a good-looking `tkeep`. **Member (b) additionally** kills a design whose preamble-position handling is scoped to the frame's own **start word**: every other preamble-position stimulus in this plan (B2's three members, B3, member (a), and M03-N2's second closure character) lies inside the start word, so such a design is green on all of them and treats member (b)'s aborting word as unvalidated preamble filler — REQ-102 forbids validating those octets' **values**, which is not licence to ignore their **control** bits. **THIS ROW CARRIES A §9 NO-OUTPUT-WORD PIN — measured, not remembered** (`J-dv_lead-0106`: `Strobe_monitor.expect` at `test_m03_b.ml:337`; §2 obligation 4 carries the whole nine-unit inventory). It is one of the **nine**, and under `WO-0063B`'s IC-1 report-path delay it reddened on its **own** row-local pinned-cycle check — `M03-B4: error_start_without_terminate pulsed on the wrong cycle` — not on the standing monitor, which spoke nowhere in that campaign (`WO-0063B-VERDICT` §1 and §5, `J-dv_lead-0109`). **A campaign enumerating the no-output-word set from memory misses this row**: it was one of the four the recalled figure of five left out | ASSERT |

**Note B-i — M03-B4's two members: the geometry, and what member (b) does and
does not pay** (added 2026-08-04, `J-dv_lead-0100`; earned by derivation at
`WO-0062` §6.2 item 1 and owed as a plan edit since `J-dv_lead-0098`).

Arithmetic, from §0.5's octet time and `Bench.frames_at`'s lane mapping
(`first_start` = 8 at a lane-0 start, 12 at a lane-4 one), with `Injection`'s
`At_preamble p` placing a character at `start_ot + p`:

| | Member (a), lane-0 start | Member (b), lane-4 start |
|---|---|---|
| Frame A's `/S/` | octet time 8 — cycle 1, lane 0 | octet time 12 — cycle 1, lane 4 |
| The aborting `/S/` (`At_preamble 4`) | octet time 12 — **cycle 1, lane 4**: the *same* word | octet time 16 — **cycle 2, lane 0**: the *next* word |
| Was A open on entry to that word? | **No** — A opened in it | **Yes** — A consumed preamble positions 1 … 3 in lanes 5 … 7 of cycle 1 |
| Alignment transition | **0 → 4** | **4 → 0** |
| Frame B's first octet | octet time 20 = array index 4 | octet time 24 = array index 4 |
| `Arrival`'s auto-terminate | octet time 16 + 68 = 84 | octet time 20 + 68 = 88 |
| Frame B receives | 84 − 20 = **64** | 88 − 24 = **64** |
| A's report (§9's no-output-word pin, two cycles after the closing word) | cycle **3** | cycle **4** |

Both members put four filler octets before the frame for the same reason and
get the same 64/60/8/0x0F expectation out; **the stimulus difference is one
parameter (the first frame's start lane) and the observable difference is one
cycle.** That is what makes the pair a controlled comparison rather than two
tests.

**What member (b) pays.** `WO-0058` §9 **bound 6** asked for a second point on
the alignment-transition instrument; member (a) supplies one, but `run_h2`'s
lane-0 member and member (a) are **both 0 → 4**. Member (b) is the bench's only
**4 → 0**, i.e. the first point in the opposite direction, and it is the plan's
first preamble-position control character outside its frame's own start word
(`WO-0062` §5's T6: at a lane-4 start, preamble positions 4 … 7 lie in the next
word).

**What member (b) does NOT pay, stated because it looks as though it should.**
`WO-0058` §9 **bound 7** wants an **in-word** REQ-110 abort with a frame
**already open on entry**. Member (b) has the second half and not the first: its
`/S/` is in **lane 0**, the word's first lane, so the abort is at a word
boundary and not in-word. ~~**Bound 7 remains open with no candidate row.**~~ A
member that looks like it closes a bound and does not is exactly how a bound
gets quietly dropped, so the non-payment is recorded next to the payment.

> **STRUCK 2026-08-06 — bound 7 is SCORED 3 of 3, and its premise was false
> when it was written** (`WO-0066-VERDICT` §7 and `FINDING WO-0066-6`;
> `J-dv_lead-0117`, landed here `J-dv_lead-0118`). *Superseded wording, kept
> because the argument that retired it is only readable against it:*
> **"Bound 7 remains open with no candidate row."** It is struck twice over —
> the bound is **paid** at `M03-H1` (lane 4) and `M03-H2` (both lanes), which
> have driven its exact conjunction since `WO-0057`, and it is **scored** at
> `M03-N2` sub-cases 4, 5 and 6 under IC-A. **§4.H bound 2 carries the score,
> the three instances' state split and the correction**; this note is not the
> place the bound is adjudicated and does not restate it. **Member (b)'s
> non-payment is UNCHANGED and remains true**: its `/S/` is still at a word
> boundary, so it still does not drive an in-word abort, and no reader may take
> the bound's closure as retrospective credit to this member.

**What member (b) turned out to buy under measurement, and it is a result rather
than an omission — SCORED-AND-UNCONVICTING, 2026-08-06** (`WO-0066-VERDICT` §6.1
and §8; `J-dv_lead-0117` open question 4, ruled here `J-dv_lead-0118`). Member
(b) was **inside the denominator of all six classes** of the family-B/N campaign
— it is one of the eleven never-before-scored members that campaign existed to
put under load — and it **convicted under none of them**: it stayed green
everywhere, including at IC-A, where it was one of the two units the auditor's
disclosure `D-A1 = O` existed to decide and where a red at it would have been a
finding against the manifest. **It killed nothing that another instrument had not
already caught.** That is recorded here in the plan, in those words, for one
reason: a member scored by six classes and named in no kill is exactly the shape
a later packet mis-reads as a campaign contributor, and the plan says which of
the two it is. **Its value is undiminished and it is the value it was added
for**: bound 6's **opposite-direction alignment point**, the bench's only
**4 → 0** transition, stated one paragraph above. **A member may be worth adding
for a geometry it uniquely supplies and still convict nothing in a campaign that
does not attack that geometry** — the two facts are independent, and no future
`SO-` may cite this member's campaign participation as coverage of anything.

**Note B-ii — the M03-B2 / M03-N3 extension conflict, RESOLVED: B2's cell
widens and N3's sentence stands** (added 2026-08-04, `J-dv_lead-0100`; owed as a
plan edit since `J-dv_lead-0098`, earned at `WO-0062` §6.2 item 2).

**The conflict.** §4.N's **M03-N3** says in terms that the assertable REQ-105
case an idle-in-preamble makes available is *"carried at M03-B2"*. M03-B2's own
stimulus cell named only `/E/`. `test/xgmii/injection.mli` accepts an `/I/` or a
`/Q/` **only** at `At_preamble` (*"REQ-102's third sentence routes it to
REQ-105"*), so the machinery exists and always did. **The plan spoke twice with
different extension**, and a plan that speaks twice decides nothing.

**Ruled for widening B2, on two grounds.**

1. **Which text is the later one.** N3's sentence lands with the WO-0029 §3b
   ruling (`541ea43`) that declined dv's requested §6.3 sentence and gave the
   wrapper constraint instead; B2's cell is batch-A text (`J-dv_lead-0013`)
   written before that ruling and never revised for it. The conflict is a stale
   earlier cell, not a wrong later sentence. Correcting N3 would delete a ruled
   consequence in order to preserve an unrevised cell.
2. **The substantive ground, which is why this is not bookkeeping.** **`/E/`
   cannot discriminate REQ-102's third sentence at all.** An `/E/` in a preamble
   position routes to REQ-105 *under* that sentence, and it routes to REQ-105
   under a design that simply treats preamble positions as frame positions —
   same observable, both readings, so the landed members test the *outcome* and
   not the *rule*. `/I/` separates them: REQ-113 requires a control character
   other than the start character occurring **outside** a frame to be ignored
   (no output word, no header effect, no strobe), while a preamble position is
   **inside** an open frame, where REQ-102's third sentence demands one
   `error_bad_frame` and no output word. A design that carries REQ-113's ignore
   rule into the preamble is silent where the specification demands a report —
   REQ-008's silent-discard hole — and nothing else in this plan sees it. A
   distinct kill makes it a member, not a duplicate.

**Why a member of B2 and not a new row.** Identical Attacks cell (REQ-102,
REQ-105, §0.7, §9 row 3), identical Observable, one variable changed in the
Stimulus. §1's row grammar makes that a member. B2 keeps its id, and its landed
`/E/` members are neither re-derived nor re-benched.

**Three derivation obligations, owed by whichever packet commissions the new
members.**

1. **DISCHARGED 2026-08-05 — `/Q/` is DRIVEN. The derivation this obligation
   asked for was made at `WO-0065` §3.2.1 and it came out *admitted*; the
   obligation's own text is kept below rather than deleted, because the
   argument that retired it is only readable against it** (`RV-0065-VERDICT`,
   `J-dv_lead-0112`; members landed at `88413b9`, green in CI `build` run
   `30961544649`). **The ruling, in four grounds, weightiest first.** (i) The
   module specification **fixes the design's obligation on this exact input,
   twice, naming `/Q/`**: SPEC-M03 §6.2's `Preamble` row leaves to `Idle` *"on
   any other control character in a preamble position — `/I/` and `/Q/`
   included"*, and the REQ-102 traceability row (`xgmii_rx_64.md:1197`) routes
   *"anything else, `/I/` and `/Q/` included, to REQ-105"*. **A specification
   that fixes the design's obligation on an input has constrained that input**,
   so **M03-O5's prohibition — the only thing holding the sub-member — does not
   bite.** (ii) REQ-018 limb (ii) reaches it through REQ-102's own composition,
   and the composition is the specification's, not dv_lead's: §6.2 and the
   traceability row both perform it in terms. (iii) REQ-018's limbs are a
   **floor, not a ceiling** — read as a closed admission set the contract would
   refuse M03-B3's `/T/` at position 5 and M03-B2's `/E/` at position 3, both
   committed and green, and §3 draws exactly **one** prohibition from REQ-018
   (a `/S/` outside lanes 0 and 4) and no other. (iv) **The four-character
   structure of a sequence ordered set is an 802.3 fact stated in no frozen
   specification of this programme** — it appears only in this note. Deferring
   a stimulus the module spec names by name, on the strength of a structural
   fact no frozen spec states, is deriving from **outside** the spec: the
   opposite failure from the one this deferral was guarding against. **The
   correction is dv_lead's own.** **What is still refused**: a `/Q/` at a
   preamble position is a *single control character*, not an ordered set, so
   REQ-113's *"sequence ordered sets … occurring outside a frame"* case is
   **untouched** by these members, remains family I's (M03-I3), and no comment,
   message or packet sentence may say otherwise. **The asymmetry, so a reader
   does not have to find it**: `/I/`'s admission rests on **two** independent
   sites (§6.2's `Preamble` row and the traceability row's verification column,
   which names M03-N3), `/Q/`'s on **one** (§6.2's `Preamble` row, by name).
   One site fixing the design's obligation is enough. **If
   architect_docs_lead later rules REQ-018 limb (ii) a closed list keyed on
   each requirement's literally-named conditions, `/Q/` converts to a declared
   gap naming that clause — never to silence**, and `/I/` survives that reading
   on its second site.

   *The obligation as it stood, kept for history:* **`/Q/` is carried and not
   driven until its position legality is derived.**
   REQ-102's third sentence is extensional — *"any other control character"* —
   so `/Q/` is inside it by text. But a sequence ordered set is a **four**-character
   set whose first character is `/Q/`, and this plan **has not derived** whether
   REQ-018's link-partner contract admits a `/Q/` at an arbitrary preamble
   position: §3 constrains the lane of `/S/` and of nothing else, and
   `injection.mli` imposes no lane restriction on `/I/`//`/Q/` at `At_preamble`.
   Driving a stimulus whose legality is underived is how a bench asserts a fact
   about a space the specification does not constrain — M03-O5's own
   prohibition, one level up. So `/I/` is commissioned; `/Q/` is a declared
   sub-member, driven only once that derivation lands or converted to a declared
   gap naming the clause that leaves it open. **This is not a split difference on
   the conflict**: the conflict is resolved and B2 carries the case; `/Q/`'s
   position legality is a separate question that was never part of it.
2. **The placement is position 3 at both lanes** — the landed `/E/` members'
   exact placement, so the new members differ from them in exactly one variable
   and the discrimination argument above is executable rather than asserted.
   Landings to re-derive and to verify at **both** sites (the schedule's own word
   and the cycle `run` actually drove): at a lane-0 start, octet time 8 + 3 = 11
   → cycle 1, lane 3; at a lane-4 start, 12 + 3 = 15 → cycle 1, lane 7. Both lie
   in the start word, so both report at W + 2.
3. **M03-N3's NO-STIMULUS is untouched and stays untouched.** N3's binding
   constraint is on the **wrapper** — *the idle-injection wrapper of M03-I4 SHALL
   NOT inject between a start character and the frame's first octet* — with
   C-45's over-breadth caveat riding on it. These members place a **single
   character at a named preamble position** through `Injection`'s `At_preamble`,
   not an injected idle **word** through M03-I4's wrapper. Nothing here relaxes
   the wrapper rule, and a packet reading it as licence to do so has misread this
   note.

**Note B-iii — two instrument findings from `RV-0062-VERDICT` §6, and what they
bind** (added 2026-08-04, `J-dv_lead-0100`).

**B-2 — the following-frame cross-check depth.** M03-B4's frame B is
cross-checked against `Dv_xgmii.Injection.outcomes` on all five delivered-side
fields plus `received`; M03-B3's and M03-B2's following frame is cross-checked
on `delivered` and `reports` only. That is the suite's **standing** depth for a
following clean frame (`test_m03_h.ml:307`, `:539`), and the `start_cycle + 3 + m`
rule those rows assert is independently anchored by `test_m03_i.ml`'s
`assert_clean_frame_structure`, which is green at both start lanes — so the
landed rows are **sound**, and this is a depth debt, not a defect. **Binding on
every new member added under this section** (B4's member (b), B2's `/I/`
members): cross-check the following frame at B4's depth. Deepening the landed
members is a suite-wide strengthening and rides a round that can run the suite.

**B-3 — byte-identical frames cannot testify to provenance.** In the landed
M03-B3 and M03-B2 units both frames are `Bench.directed_frame_octets ~length:64`,
which is deterministic in `length`, so the two frames carry the **same 64
octets**. The following frame's content comparison therefore cannot distinguish
*frame 2 delivered correctly* from *frame 1's content delivered in frame 2's
place*; only the per-word **cycle** checks discriminate provenance, and they do,
so the rows are sound and the content instrument is weaker than it reads.
**Binding on every new member and on any future two-frame stimulus in this
family**: the two frames' declared lengths must differ, or
`Injection.frame_of_length ~sequence` must distinguish them, so that content
testifies to provenance and not only to shape. The landed members' remedy is a
**stimulus** change and rides the next family-B bench round.

**Not generalised to a standing obligation here, deliberately.** Neither hazard
is family B's alone — any row driving two frames whose content must discriminate
provenance carries B-3, and every following-frame check in the suite carries
B-2. But §2's obligations bind *every* M03 bench, and minting one from a
two-row observation would claim a property of rows this plan has not re-read for
it. Both are recorded as owed at the next plan-wide pass.

### 4.C Frame extraction, terminate lanes and `tkeep` — REQ-103, REQ-106, REQ-011, REQ-015

| Row | Attacks | Stimulus | Observable | Kills | Status |
|---|---|---|---|---|---|
| **M03-C1** | REQ-103, REQ-106, REQ-011 | Frames of **64 … 71 octets** DA through FCS, at **both** start lanes (16 frames) | Delivered octets = length − 4 (60 … 67); the eight `tlast` `tkeep` patterns 0x0F, 0x1F, 0x3F, 0x7F, 0xFF, 0x01, 0x03, 0x07 occur exactly once each; the terminate character lands in lane (length mod 8), covering all eight lanes; `tuser`[0] = 0 and no strobe throughout | An FCS strip that is right at one residue and wrong at others; a `tkeep` generator that saturates at 0xFF; a terminate decoder that only looks at lane 0 | ASSERT |
| **M03-C2** | REQ-106, §6.1's second non-instance, **C-18**, ADR-0007 | The subset of M03-C1 whose terminate character lands in lane k > 0 | The k octets in lanes 0 … k−1 of the terminate word are delivered, and the FCS verdict is good | **The C-18 twin**: a design that holds the CRC register on any word containing a control character loses k octets from the CRC and fails the FCS check of seven of the eight terminate lanes. Also kills a design driving M02 with `octet_count` = 0 on the lane-0 case (ADR-0007's prohibition) | ASSERT |
| **M03-C3** | REQ-103, REQ-015, REQ-011 | One **1518**-octet frame, both start lanes | 1514 delivered octets in **190** words — 189 words of `tkeep` = 0xFF and a final word with `tkeep` = 0x03 and `tlast` = 1; FCS verdict good; no strobe | A design whose one-word lookahead breaks at the maximum length; a REQ-015 monitor bound set to 189 or 191 | ASSERT |
| **M03-C4** | REQ-015, **C-11** | The 5-octet runt of M03-F1 | A **one-word** frame whose single word carries `tlast`, `tkeep` = 0x01 — legal on this stream, and the deleted REQ-015 sentence would have forbidden it | A protocol monitor that requires a word before every `tlast`; the exact assertion C-11 deleted from REQ-015 and from SPEC-M03 §7 | ASSERT |
| **M03-C5** | REQ-103, REQ-011, **BUG-0001**, prediction **P-1** | Frames of **1513** and **1516** octets DA through FCS, at **both** start lanes (4 frames), driven through the same outcome-table machinery as M03-C1 | Delivered octets = length − 4 exactly (**1509**, **1512**); the `tlast` word's `tkeep` = **0x1F** and **0xFF**; `tuser`[0] = 0; no strobe | **A BUG-0001 fix confined to the minimum-frame region.** The two lengths are chosen so the final output word's fill is k = 5 and k = 8 — the two values BUG-0001's invariant says over-deliver by +1 and +4 — three orders of magnitude away from the 64-octet region where the defect was found, so a fix that repairs the neighbourhood rather than the rule fails here. **1516 at lane 4 additionally has terminate_lane = 0 with a full final word**, making it the second instance of R-1's observation class and the place that account is tested away from length 68 | ASSERT |

### 4.D The FCS check — REQ-104, §6.1

| Row | Attacks | Stimulus | Observable | Kills | Status |
|---|---|---|---|---|---|
| **M03-D1** | REQ-104, §9 row 1 | A 64-octet frame with **one payload bit flipped** after the FCS was computed, both start lanes | The same 60 octets delivered (the frame is forwarded in full, REQ-005), `tuser`[0] = 1 on the `tlast` word, exactly one `error_bad_fcs` high cycle **on the `tlast` cycle** (§9's pinned cycle), no other strobe | A design that drops a bad-FCS frame instead of forwarding it (store-and-forward by the back door); a design that reports on the terminate cycle instead of the `tlast` cycle | ASSERT |
| **M03-D2** | REQ-104, REQ-304 | Every good-FCS frame in this plan | `tuser`[0] = 0 and no `error_bad_fcs`, at all lengths and both lanes | A design that marks every frame invalid — the anti-vacuity partner of M03-D1, without which D1 passes against a design that always asserts the bit. **THIS ROW'S UNIT SHARES ITS RUNNER WITH M03-D3's, and the plan records it because a mechanical classification got it wrong** (`WO-0063B-VERDICT` §6.1, FINDING WO-0063B-1; transcribed `J-dv_lead-0109`). `run_mixed_pair` (`test_m03_d.ml:266`) is called from **two** units — `run_d3` at `:455` (M03-D3) and `run_d2_d1_partner` at `:408` (this row's D3-good-member half) — so its `tlast`-pinned `error_bad_fcs` registration belongs to **both rows**. A classification pass that maps each registration to its **enclosing definition** assigns it to M03-D3 alone and predicts this row green under any class that moves that registration; that is exactly what happened at `WO-0063B`'s IC-2 control, where M03-D2 reddened against a sealed MUST-STAY-GREEN prediction — a violation owed to an incomplete enumeration, **not** to the diff reaching past the class it named. **The runner-to-row relation in this bench is MANY-TO-MANY, and any per-row classification must be built from CALL SITES, never from enclosing definitions**; the mechanical form of that rule sits beside `tools/dv_checks.sh`'s inventory report so the next pass meets it without remembering this row. **The file said so in its own prose all along** (`test_m03_d.ml:330`), and a pass that reads structure cannot read prose | ASSERT |
| **M03-D3** | REQ-104, §6.1's seeding rule, §6.1's drain paragraph | **CORRECTED 2026-08-06 (`J-dv_lead-0038`) — the original ordering did not kill the design this row names.** Two 64-octet frames at the **minimum** 12-octet gap (start-to-start 10 or 11 cycles, §0.3), in **both orderings**, at both start lanes — four schedules. **Pair A, good-FCS then bad-FCS.** **Pair B, bad-FCS then good-FCS** | Pair A: frame 1 `tuser`[0] = 0 and **no strobe**; frame 2 `tuser`[0] = 1 with exactly one `error_bad_fcs` on **its own** `tlast` cycle. Pair B: frame 1 `tuser`[0] = 1 with one `error_bad_fcs` on its `tlast` cycle; frame 2 `tuser`[0] = 0 and no strobe | **CORRECTED A SECOND TIME, 2026-08-10 (`J-dv_lead-0044`) — this row's original headline kill is UNACHIEVABLE and is withdrawn.** The WO-0041 campaign seeded exactly that design (mutation D-M3) and **the whole suite passed**, which sent me back to the arithmetic: a following frame's earliest effect on the CRC register is §6.1's `Preamble` seed, triggered on its start-character cycle, and a register update at cycle X is visible from X+1. Exhaustively over every legal (terminate lane, start lane, gap ≥ §0.3's DIC floor of 9) combination, the next frame's start cycle is **never strictly before** this frame's `tlast` cycle — the tightest case is exact equality (terminate lane 0, lane-0 start, 9-octet gap). So the late read **always** sees the frame's own residue and the two designs are **behaviourally indistinguishable under all legal stimulus**. Carrying-the-verdict-with-the-frame is therefore a **realisation**, not an observable — the same class §6.3 item 1 puts residue-versus-capture in, and the same disposition **M03-D4** already carries. It is hereby NO-ASSERT and no row may claim it. **What this row does still kill, and what it is now for**: a design that **latches the abort bit and fails to clear it between frames** (pair B's frame 2 must read `tuser`[0] = 0 after a bad-FCS predecessor), and a design that mis-attributes a verdict or a strobe between two frames sharing a minimum gap. Both are real observables and neither was exercised by the WO-0041 campaign, so this row's qualification was recorded INCOMPLETE pending a latched-abort-bit mutation. **DISCHARGED 2026-08-11 (`J-dv_lead-0047`): D-M6 was seeded against it and killed it**, reddening exactly M03-D2 and M03-D3 through the `tuser` check on the **second frame of a pair-B (bad-then-good) schedule**, both messages character-for-character as frozen, with the other ten bench units silent and no strobe-shaped message anywhere. **This row keeps ASSERT on evidence rather than on a declared kill** — and the mutation that vindicates it lands on exactly the two units dv_lead wrongly predicted for D-M3, confirming what was recorded before that run: the two-frame structure was the right instrument all along; only its original target never existed. **This row's unit shares `run_mixed_pair` (`test_m03_d.ml:266`) with M03-D2's**, so the runner's `tlast`-pinned `error_bad_fcs` registration is **both rows'** and neither row owns it — see M03-D2's cell for the full record and for the many-to-many rule it cost (`WO-0063B-VERDICT` §6.1, `J-dv_lead-0109`) | ASSERT |
| **M03-D4** | REQ-104, §6.3 item 1 | — | **The realisation is not asserted.** Residue-versus-capture is unobservable (§6.3 item 1); a bench asserts the verdict, never the mechanism | — | NO-ASSERT |

### 4.E Error character inside a frame — REQ-105, §9

| Row | Attacks | Stimulus | Observable | Kills | Status |
|---|---|---|---|---|---|
| **M03-E1** | REQ-105, REQ-103's no-removal clause | `/E/` in **each of the eight lanes** of a mid-frame word of a 64-octet frame (8 frames, lane-0 start; repeated at lane-4 start) | The last delivered octet is the one immediately preceding the `/E/` (the REQ-106 rule with `/E/` in place of `/T/`, so `/E/` in lane 0 means the previous word carried the last octet); `tkeep` marks exactly those octets; `tuser`[0] = 1 on the `tlast` word; exactly one `error_bad_frame` on the `tlast` cycle; **no FCS removal** — the four octets before the error character **are** delivered | A design that applies FCS removal on the abort path (REQ-103 forbids it): it would deliver four octets too few and the row's octet-count assertion catches it at every lane | ASSERT |
| **M03-E2** | REQ-105, §0.7, §9 row 2 | `/E/` at exactly the frame's first octet position (zero delivered octets) | No output word at all; exactly one `error_bad_frame`, on the cycle **two after** the input word carrying the `/E/` — the cycle that frame's `tlast` word would have occupied | A design that emits a `tkeep` = 0 word, or a one-word frame of preamble octets, to have somewhere to put the abort bit. **THIS ROW CARRIES A §9 NO-OUTPUT-WORD PIN — measured, not remembered** (`J-dv_lead-0106`: `Strobe_monitor.expect` at `test_m03_e.ml:429`; §2 obligation 4 carries the whole nine-unit inventory). It is one of the **nine**, and under `WO-0063B`'s IC-1 report-path delay it reddened on its **own** row-local pinned-cycle check — `M03-E2 (lane 0): error_bad_frame pulsed on cycle 5, expected 4` — not on the standing monitor, which spoke nowhere in that campaign (`WO-0063B-VERDICT` §1 and §5, `J-dv_lead-0109`). **Its structure is the epoch-A aged record** (pin 4, so the closing word is the word after the start word), which is member (iii)'s structure and not M03-E5's in-word one — the split matters to any campaign that seeds one path and not the other (`WO-0063B-VERDICT` §7.1). **A campaign enumerating the no-output-word set from memory misses this row**: it was one of the four the recalled figure of five left out | ASSERT |
| **M03-E3** | REQ-105, §0.6, §9's "aborted-and-forwarded versus discarded-before-emission" | (same as M03-E2) | A monitor asserting "every abort is marked on a `tlast` word" **must not be driven for this frame** — REQ-105's own verification column says so, and the frame is accounted for in §0.6 by its strobe | — (a bench-side rule, not a design property) | NO-ASSERT |
| **M03-E4** | REQ-105's closure clause, REQ-113, **C-12** | `/E/` **after** a terminate character, in the gap between two frames | Nothing emitted, **no strobe of any kind**, and the following frame received intact | A design whose `/E/` handler is not gated on frame-open: it pulses `error_bad_frame` for a frame already counted and breaks §0.6's conservation equation | ASSERT |
| **M03-E5** | REQ-105, §9's closure list, §6.2's `Frame` row | An `/E/` in a **preamble position** (1..7) at a **lane-0 start** — a frame opened and closed inside **one input word**, zero delivered octets | No output word at all; exactly one `error_bad_frame`, on §9's no-output-word pin (two cycles after the input word carrying the `/E/`); nothing else asserted about `tuser`[0], which has no `tlast` word to live on (§4.1, and the M03-E2 prohibition applies unchanged) | A design whose in-word open-and-close path reports through a different channel from its multi-word abort path, or not at all. **Found by the WO-0045 seeder while seeding E-c2 faithfully** (`J-dv_lead-0054`): it reported that this stimulus takes an in-word path with no payload datapath, structurally distinct from the epoch-A path M03-E1/E2 exercise, and that no family-E row drives it. `Injection.placement`'s preamble-position constructor supports it and no row used it. **Deliberately NOT added during the campaign** — a row added between a freeze and its scoring moves the denominator the freeze is scored against — and added here immediately after scoring. **QUALIFIED 2026-08-03 (`RV-0050-VERDICT`, `J-dv_lead-0065`).** **F-c7** — the in-word abort detected and never reported — was killed by this row and **by nothing else in the suite: nineteen of twenty units are blind to it, and before this row existed twenty of twenty were.** That is REQ-105's in-word silently-always-pass closure, measured, and it is what the row was added for. **F-c8** — §9's no-output-word pin displaced one cycle early — also killed it, on the exact sealed arithmetic (`pulsed on cycle 2, expected 3`). **One thing this row does NOT establish, and the negative is the point**: F-c8 killed **only** this row, leaving M03-E2 and M03-F2 green, so the two no-output-word classes were **not** shown to share a report path. See §8 item 5 — the shared-path claim is unestablished and its untested half is owed a class | ASSERT |

### 4.F Runt frames — REQ-107, §0.7

> **Family note — REQ-901 declared divergence class (e)** (SPEC-M03 §10's
> REQ-107 hook and its new REQ-901 row, `62c39a7`; requirements.md REQ-107).
> **It changes no row below** — no stimulus, no observable, no kill, no status —
> and it bars exactly one thing: **no sign-off packet may offer a co-simulation
> result as the external anchor for REQ-107**, and an exclusion is never a
> licence to take an expected value from the reference (ADR-0015 D2). The
> exclusion is scoped **per requirement and per frame class, not per row**, and
> this family straddles it:
>
> - **M03-F1, M03-F3, and M03-F4's 63-octet member** lie inside (e)'s
>   **5-to-63-octet** band, where the exclusion is **`tuser`[0] alone**. The
>   delivered octets and the `tkeep` extent stay inside the comparison domain, so
>   **M03-F1's REQ-103 half — the FCS removed and checked at 1, 12, 56 and 59
>   delivered octets — remains co-simulation-anchorable**; its REQ-107 half, the
>   marking, is not. That narrowness was checked, not assumed: the reference's
>   FCS check is a lane-indexed residue array with no length gate, so it strips
>   unconditionally and the two designs deliver identical octets here
>   (`J-dv_lead-0057`).
> - **M03-F2 and M03-F5's frames** — **below five octets**, where (e) excludes
>   the frame **entirely, its accept-or-discard decision included**. The lane
>   anchors nothing at all here, and the reference's own sub-five disposition is
>   **data recorded on first drive, never adjudicated and never an expected
>   value**.
> - **M03-F4's 64-octet member** is **outside every exclusion** — (e) excludes
>   nothing in the 64-to-1518-octet range — so this row's anti-vacuity partner
>   stays fully anchorable, and the exclusion's boundary is the same boundary the
>   row attacks.
>
> The five strobes are outside the comparison domain **campaign-wide**, because
> the reference has no counterpart to §9's taxonomy at all (`J-dv_lead-0049`).
> That is a fact about the lane, not an effect of (e), and no row below may be
> read as excluded on that account.

| Row | Attacks | Stimulus | Observable | Kills | Status |
|---|---|---|---|---|---|
| **M03-F1** | REQ-107, REQ-103 | Frames of **5, 16, 60 and 63** octets DA through FCS, correct FCS, both start lanes | 1, 12, 56 and 59 delivered octets; `tuser`[0] = 1 on each `tlast` word; exactly one `error_runt` per frame on the `tlast` cycle; **the FCS is removed and checked** — these frames end with `/T/`, so REQ-103 applies to them | A design that suppresses FCS removal on a runt (delivering four octets too many), and a design that suppresses the output entirely | ASSERT |
| **M03-F2** | REQ-107, §0.7, §9 ruling 9 | Frames of **0, 1 and 4** octets between start and terminate. The 4-octet frame's filler SHALL NOT be `00 00 00 00` — or both fillers are driven — for the reason M03-M10 gives | No output word at all; **exactly one `error_runt` and no other strobe of any kind** (an exact set, strengthened from a lower bound by §9 ruling 9 at `1fe71ca`), at the pinned no-output cycle | A design that emits a `tkeep` = 0 word; a design that attempts FCS removal on a frame with nothing to remove it from and underflows its counter; and, through the exhaustive strobe set, a design that runs the residue comparison at every terminate character (M03-M10). **QUALIFIED 2026-08-03 (`RV-0050-VERDICT`, `J-dv_lead-0065`) — three seeded classes killed this row, and the second declared kill above is CONFIRMED ACHIEVABLE rather than withdrawn.** `WO-0047` §3.2 flagged that kill as at risk of the unachievable-kill shape and could not settle it, because settling it required reading `libs/**`; `RV-0047` §5(3) sent it to the campaign with the disposition pre-committed — *if a faithful underflow mutation kills nothing, the kill is withdrawn by spec diff, as M03-D3's headline kill was*. **F-c6 seeded the underflow faithfully and this row killed it, so the pre-commitment does not fire and no spec diff is owed.** **Two bounds attach, and neither is decoration.** (a) **The row convicts the underflow but cannot diagnose it**: F-c3 (a spurious emitted word) and F-c6 (the underflow) produced **byte-identical** bench output — same unit, same iteration, same assertion, same message, and the two runs' `.corrected` blobs are the same object — so a reader who sees this row's message cannot tell the two defects apart. That is the opposite disposition from M03-D3's: killable, and merely not separable. (b) **The three lengths are not interchangeable.** F-c5, a *strobe-suppressing* defect, convicts at **k = 0** because it needs no delivered octet; F-c3 and F-c6, both of which must *emit* something, are **invisible at k = 0** and first bite at **k = 1** — a zero-octet frame gives an emitting defect nothing to emit. So this row's reach against the emitting classes is **k ∈ {1, 4}**, and k = 0 earns its place against the suppressing class alone | ASSERT |
| **M03-F3** | REQ-107, REQ-104, §9's first co-occurrence ruling | A **63-octet** frame with a **wrong** FCS | **Both** `error_runt` and `error_bad_fcs` pulse once; `tuser`[0] is set **once** — it is one bit on one word, not one bit per condition | A first-match or precedence design that reports only the runt; and a design that sets the abort bit twice or widens the pulse | ASSERT |
| **M03-F4** | REQ-107, §0.3 | The adjacent pair **63** and **64** octets, correct FCS, both lanes | 63 → `error_runt` and `tuser`[0] = 1 with 59 delivered; 64 → no strobe, `tuser`[0] = 0, 60 delivered | The off-by-one threshold (`< 64` implemented as `<= 64` or as a delivered-octet rather than a received-octet count) — the two frames differ by one octet and by everything else | ASSERT |
| **M03-F5** | REQ-107, §0.7 | The 5-octet frame of M03-F1 | Exactly **one** delivered octet in one word (`tkeep` = 0x01, `tlast` = 1) | A design that treats "fewer than 5" as "fewer than or equal to 5" and emits nothing for the boundary frame REQ-107 requires to be forwarded | ASSERT |

### 4.G Oversize frames — REQ-108, §6.2's `Discard`, §9

> **Family note — REQ-901 declared divergence class (f)** (SPEC-M03 §10's
> REQ-108 hook and its REQ-901 row, `62c39a7`; requirements.md REQ-108). As with
> (e) it **changes no row below** and bars one thing: **no sign-off packet may
> offer a co-simulation result as the external anchor for REQ-108.**
>
> **(f) is the wider of the two exclusions.** A frame exceeding 1518 octets is
> excluded **entirely, including the octets between the truncation point and the
> next start character** — which is precisely the interval **M03-G3**, **M03-G4**
> and **M03-G6** exist to assert about. **The lane anchors nothing in it**, and
> that is not a gap in the rows: those three rows are and always were directed
> tests against §9's own rulings.
>
> **M03-G2's 1518-octet member is not excluded, and that is the sharp point.**
> (f) excludes nothing in the 64-to-1518-octet range, so the exclusion's boundary
> falls **exactly between M03-G2's adjacent pair**: the legal member stays fully
> anchorable, the 1519-octet member is anchorable in nothing. Note what that does
> to the row's own construction — the three observables G2 uses to separate the
> pair are the strobe, the abort bit and the FCS verdict, and **all three are
> outside the lane's reach for the oversize member** (the strobes campaign-wide,
> the other two by (f)). The row is a directed test end to end and was never
> going to be anything else.

| Row | Attacks | Stimulus | Observable | Kills | Status |
|---|---|---|---|---|---|
| **M03-G1** | REQ-108, REQ-103 | A **1600**-octet frame followed immediately by a valid 64-octet frame | Exactly **1514** octets delivered; `tuser`[0] = 1 on the `tlast` word; exactly one `error_oversize`; **no `error_bad_fcs`**; the following frame received intact | Truncation at 1518 delivered (the received-count constant used as the delivered-count constant); a design that resynchronises only on `/T/` and loses the next frame | ASSERT |
| **M03-G2** | REQ-108, REQ-103, §0.3 | The adjacent pair **1518** and **1519** octets, each with a correct FCS over its own length | Both deliver exactly **1514** octets. 1518: no strobe, `tuser`[0] = 0, FCS verdict good. 1519: one `error_oversize`, `tuser`[0] = 1, **no** `error_bad_fcs` | The off-by-one on "more than 1518". The pair is adversarial precisely because the **delivered octet count is identical** — only the strobe, the abort bit and the FCS verdict separate a legal maximum frame from an oversize one | ASSERT |
| **M03-G3** | REQ-108, REQ-110, §9's sixth ruling, **C-12** | A 1600-octet frame in which a new `/S/` arrives 100 octets past the truncation point — content index **1618**, which is in REQ-108's window and **past the frame's own terminate**: the **second epoch**, see the family note | Exactly one `error_oversize` and **no** `error_start_without_terminate`; the new frame is received normally | A design that treats the resynchronising start character as a second abort — it would double-count the frame against §0.6. **SCOPED 2026-08-05 (`J-dv_lead-0072`), and the scoping is a correction of a claim this cell made and could not support.** REQ-108's window runs from the truncation point to the **next start character**, so the oversize frame's own terminate lies **inside** it and this row's character lies **after** that terminate. The kill above is therefore established **for the second epoch only** — the interval from the frame's own terminate to the next start character. **This row does not reach the first epoch** (truncation point to the frame's own terminate), and a design that resynchronised correctly in the second while treating the start character as an abort in the first passes it. That gap is **M03-G7**'s, and it was measured rather than argued: WO-0055's G-c4 mutation survived all twenty-five units (`RV-0055-VERDICT`, FINDING G-2) | ASSERT |
| **M03-G4** | REQ-108, REQ-105, §9's seventh ruling, **C-12** | The same 1600-octet frame with an `/E/` injected 100 octets past the truncation point — content index **1618**, in REQ-108's window and **past the frame's own terminate**: the **second epoch** | Exactly one `error_oversize`, **no `error_bad_frame`**, nothing emitted after the truncation, following frame intact | The reading §9 row 2's condition text invited before C-12 landed: an `/E/` handler that reads "between the start and terminate characters" literally and pulses for a frame already closed and already reported. **SCOPED 2026-08-05 (`J-dv_lead-0072`)** on the same ground as M03-G3, and this is the row WO-0055's G-c4 walked past: the kill is established **for the second epoch only**, where the receiver has already absorbed the frame's own terminate. **An `/E/` arriving in the first epoch is not driven by this row and is M03-G8's.** Note what remains genuinely this row's, so the scoping is not read as a retirement: an `/E/` in the second epoch is *not* redundant with M03-E4's gap `/E/`, because the receiver reaches it through a **truncation** rather than through an ordinary close, and REQ-108's sentence covers the whole interval | ASSERT |
| **M03-G5** | §6.3 item 6, **C-12** | (same as M03-G4) | The **internal state** after absorbing the `/E/` in `Discard` is not asserted; both encodings produce the pinned observable identically | — | NO-ASSERT |
| **M03-G6** | REQ-108 | A 1600-octet frame with **no** further character until the next `/S/` (no `/T/` at all) | No output word and **no strobe of any kind** between the truncation point and the next start character, whatever arrives | A design that emits the tail of the discarded frame, or that pulses a second strobe on the eventual `/T/`. **Note, added 2026-08-05**: because this frame has no terminate at all, its whole window **is** the first epoch — so before M03-G7 and M03-G8 this was the only row in the programme that drove a character into it, and everything the first epoch is verified by today it is verified by here | ASSERT |
| **M03-G7** | REQ-108, REQ-110, §9's sixth ruling, **C-12**; §6.3 item 6 (as a bound on what may be asserted) | A frame exceeding 1518 octets in which a **start character arrives strictly between the truncation point and the frame's own terminate character** — the **first epoch**. For the family's 1600-octet frame that interval is content indices **1519 … 1599 inclusive**, both ends derived **and both boundary cases worked** — the discipline whose absence produced this repair. **Lower end**: a character placed at content `k` *replaces* that octet, so the data octets arriving before it are indices 0 … k−1, i.e. **k** octets; REQ-108 truncates a frame **exceeding** 1518, so `k` must be **at least 1519**. At `k = 1518` exactly 1518 octets have arrived, the frame is **not oversize at all**, and the character is REQ-110's or REQ-105's rather than REQ-108's — the row's premise fails. *(Corrected 2026-08-05, `J-dv_lead-0075`, from a stated `1518`: the figure was right for **where truncation triggers** and wrong for **where a character may be placed after it**, because placing one at 1518 removes the very octet whose arrival makes the frame oversize. Found by tb_writer's octet-time guard disagreeing with this cell — `RV-0056-VERDICT` §1.)* **Upper end**: content 1599 is the last octet before the frame's terminate, and a character there still leaves 1599 > 1518 received, so it is admissible. The interval is therefore **81 octets wide**, not the 82 first stated. The index SHALL additionally satisfy REQ-101's lane rule, which for this frame is `c ≡ 0 or 4 (mod 8)` **at both start lanes** (a lane-0 start puts content `c` at octet time 16 + c, a lane-4 start at 20 + c, and the two conditions coincide). **The row is specified as an octet-time interval and asserts NOTHING about which internal state the receiver occupies** — §6.3 item 6 makes `Discard`-versus-`Idle` unobservable and M03-G5 exists to say so | For the oversize frame: exactly one `error_oversize` on its own `tlast` cycle, 1514 delivered octets, `tuser`[0] = 1, and **no `error_start_without_terminate`** (§9's sixth ruling — the frame is already closed and already reported, so the resynchronising character is not a second abort). **And the resynchronised frame's own disposition is part of this observable and SHALL be derived, not omitted**: REQ-108 resynchronises on that start character, so content `k+8 … 1599` plus the original frame's terminate belong to the frame it opens, giving it **1592 − k** octets between start and terminate, whose disposition follows REQ-106/REQ-107 | The gap WO-0055 **measured**: a design that resynchronises correctly in the second epoch and treats the start character as a second abort in the first. G-c4 survived all twenty-five units precisely because no row reached here (`RV-0055-VERDICT` FINDING G-2). **Contingency, pre-committed**: if the resynchronised frame's disposition proves underivable from the frozen text rather than merely arithmetic, this row converts **ASSERT → RULING** pending an architect ruling and M03-G8 carries the repair alone (`WO-0056` §2.1). **Worked example offered as a derivation to check, not as an instruction**: `k = 1588` is inside the interval, satisfies `1588 mod 8 = 4`, and leaves the resynchronised frame **4 octets** — the sub-five class of M03-F2, which is benched and mutation-qualified, so its contribution to the exact strobe set is one `error_runt` at §9's no-output-word pin and nothing else. **THIS ROW CARRIES A §9 NO-OUTPUT-WORD PIN, AND ITS OWN CHECK OF IT — measured, not remembered** (`J-dv_lead-0106`: the **second** `Strobe_monitor.expect` at `test_m03_g.ml:1375`, the resynchronised sub-5 frame; §2 obligation 4 carries the whole nine-unit inventory). It is one of the **nine**, and under `WO-0063B`'s IC-1 report-path delay it reddened on its **own** row-local strobe-order check at `test_m03_g.ml:1465` — `M03-G7 (lane 0): the second strobe is not error_runt on the resynchronised frame's own pinned cycle …` — not on the standing monitor, which spoke nowhere in that campaign. **The earlier classification of this row as "monitor-only" is WITHDRAWN and the withdrawal is on the record**: the check exists and speaks first, and it was missed because the sweep searched for the message *forms* `pulsed on the wrong cycle` and `pulsed on cycle` rather than for the defect (`WO-0063B-VERDICT` §5 and §6.2, `J-dv_lead-0109`) | ASSERT |
| **M03-G8** | REQ-108, REQ-105, §9's seventh ruling, **C-12**; §6.3 item 6 (as a bound on what may be asserted) | The same frame with an **error character** in the same interval — strictly between the truncation point and the frame's own terminate character, content **1519 … 1599** for the 1600-octet frame, both ends derived **with their boundary cases worked** as in M03-G7 (81 octets, corrected 2026-08-05 from a stated 1518). **An octet-time interval, never a state claim** | Exactly one `error_oversize`, on the oversize frame's own `tlast` cycle, **and no `error_bad_frame`** (§9's seventh ruling, C-12) — an **exact strobe set**, not a lower bound; 1514 delivered octets; no output word after the truncation; the following frame received intact | An `/E/` handler that reads REQ-105's "between the start and terminate characters" literally and reports for a frame already closed and already reported — **in the epoch M03-G4's character never reaches**. This is the row that **lifts** `RV-0055-VERDICT`'s standing consequence, and it lifts it only on the evidence `WO-0056` §6 specifies: the existing `g-c4` diff replayed against the repaired bench, where **this row SHALL redden**. A green row proves nothing here — M03-G3 and M03-G4 have been green since they landed and were green for the wrong reason | ASSERT |

### 4.H Start without terminate — REQ-110, §9

| Row | Attacks | Stimulus | Observable | Kills | Status |
|---|---|---|---|---|---|
| **M03-H1** | REQ-110, REQ-103 | A 64-octet frame whose terminate character is **replaced by a new `/S/` in lane 0**, followed by a complete frame | The aborted frame's last delivered octet is the one immediately preceding the new `/S/`; `tuser`[0] = 1; exactly one `error_start_without_terminate`; **no FCS removed** (four octets more delivered than a clean frame of the same length); the second frame received intact | A design that strips the FCS on the abort path; a design that loses the second frame | ASSERT |
| **M03-H2** | REQ-110, REQ-101, REQ-021 | A new `/S/` in **lane 4** of a mid-frame word, i.e. lanes 0–3 of that word still belong to the aborted frame | Those **four** octets are delivered as part of the aborted frame (`tkeep` and the delivered count prove it **at a lane-0 start only** — at a lane-4 start REQ-101's absolute-lane rule forces `k ≡ 0 (mod 8)`, the aborted frame delivers a whole number of words, `tkeep` is `0xFF`, and neither instrument discriminates. The row is proved at **both** alignments by `WO-0057` §2.3's **delivered-content** assertion, which is what `run_h2` makes; this cell over-promised about the weaker instrument. `J-dv_lead-0078`, footnote owed there and discharged here); one strobe; the new frame begins at lane 4 and is received intact and correctly aligned | The highest-value row in this family: a design that switches its alignment offset on the **same** cycle it accepts the new start character rotates the aborted frame's trailing four octets by the *new* offset and **loses four delivered octets silently** — a REQ-008 hole with no strobe, invisible to every row that does not count the aborted frame's octets | ASSERT |
| **M03-H3** | REQ-110, REQ-105, §9's fifth ruling | `/E/` mid-frame, then a `/S/` two cycles later | Exactly one `error_bad_frame` and **no** `error_start_without_terminate`; the frame the `/S/` opens is received normally | A design in which `/E/` marks the frame but does not **close** it: the following `/S/` would then abort a frame that is already reported, breaking §0.6 | ASSERT |
| **M03-H4** | REQ-110, §0.7, §0.6's counting convention, **C-23** | `/S/` in **lane 0 and lane 4 of one word** (cycle c), then `/S/` in **lane 0 of the next word** (cycle c + 1), then a complete frame. Frame A opens at 8c and is aborted at 8c + 4, strictly inside its own preamble; frame B opens at 8c + 4, its preamble runs 8c+4 … 8c+11, and it is aborted at 8c + 8 — also strictly inside. Both are §9's zero-delivered row, and both start characters are in a contract-legal lane (§3) | Two zero-delivered aborts. §9's pinned no-output cycle — two cycles after the input word carrying the closing character — puts their `error_start_without_terminate` high cycles at **c + 2 and c + 3, consecutively**; no output word for either; the final frame is received intact | **A rising-edge strobe counter**: it sees one event where a conformant M03 reported two. C-23's convention was homed in §0.6 on M13's evidence and is stated there as generalising; this row is the proof that it is load-bearing at M03 as well, and it is the row that makes the strobe monitor's counting rule testable rather than assumed. **THIS ROW CARRIES TWO §9 NO-OUTPUT-WORD PINS, AND ITS OWN CHECK OF THEM — measured, not remembered** (`J-dv_lead-0106`: `Strobe_monitor.expect` at `test_m03_h.ml:939` and `:951`, one per frame; §2 obligation 4 carries the whole nine-unit inventory). It is one of the **nine**, and under `WO-0063B`'s IC-1 report-path delay it reddened on its **own** row-local strobe-order check at `test_m03_h.ml:1017` — `M03-H4: the first strobe is not error_start_without_terminate on frame A's own pinned cycle (c + 2)` — not on the standing monitor, which spoke nowhere in that campaign. **The earlier classification of this row as "monitor-only" is WITHDRAWN** for the same reason as M03-G7's: the check exists and speaks first, and a classifier keyed on a message form is a string search wearing a different hat (`WO-0063B-VERDICT` §5 and §6.2, `J-dv_lead-0109`). **This row is also the campaign's only "both structures" unit** — two frames, one closing in-word and one on an aged epoch-A record (`WO-0063B-VERDICT` §7.1) | ASSERT |

**Two geometry bounds this family carries, discovered by `WO-0058`'s campaign
rather than by design, and neither closed by any row above.** Both are stimulus
facts about the four rows, not defects in them.

1. **The alignment-transition instrument is a single point.** An alignment
   defect on the REQ-110 path — the one M03-H2's Kills cell names — is observable
   **only** where the aborting `/S/`'s lane **differs** from the aborted frame's
   own start lane, because only then does "the new frame's offset" name a
   different offset from the old one. In this whole bench that holds at
   **`run_h2`'s lane-0 member alone** (`k = 12`, so `close_ot ≡ 4`): `run_h2`'s
   lane-4 member (`k = 16`) is offset-preserving, **M03-H1 is offset-preserving at
   both members** (`close_ot = start_ot1 + 8 + 64` and `72 ≡ 0 (mod 8)`, so the
   `/S/` lands in the frame's own start lane), and M03-H4's frames deliver
   nothing. The class dies at that one point — `WO-0058`'s GH-c4 — but one point
   is not a sweep. ~~**Owed: the second point at REQ-110's commissioned M03-B4
   geometry** (§4.B), which is where the opposite transition belongs.~~

   **PAID 2026-08-04, and this sentence's tense was stale from that date until it
   was repaired here** (paid by `J-dv_lead-0100`; the staleness observed and
   **reported rather than silently fixed** at `J-dv_lead-0118` item 5(b);
   repaired here, `J-dv_lead-0124`). **M03-B4's member (b) IS that second
   point**: the identical `At_preamble 4` placement at a **lane-4** start lands
   in **lane 0 of the following word**, giving the alignment transition
   **4 → 0** — the opposite direction to `run_h2`'s lane-0 member and to B4's own
   lane-0 member, both **0 → 4**. Note **B-i** at §4.B carries the octet-time
   arithmetic for both members side by side. **Driven at `88413b9`** and green
   there in CI `build` run **`30961544649`** (`J-dv_lead-0112`) — a run in which
   three M03-N2 sub-cases raised and **this member did not** — and green again
   in the **fully successful** `build` run **`30963617198`** at **`eb1e06a`**,
   the 11-of-11 landing (`J-dv_lead-0113`). Both readings are given because a
   unit-level green inside a failing build is a weaker claim than a green build,
   and the second is the one to quote; each travels with the SHA and run id it
   was read at, per §0.1.

   **What is paid and what is not, stated separately because they are different
   claims.** Paid: the bound's *owed direction*. **Not** paid: the bound's own
   point about **sweep**, which stands verbatim — the class now has **two**
   points and not one, and two points are still not a sweep, so the bound is
   carried for that reason and no longer for a missing direction. **And one
   thing the payment does not buy, recorded so the two are never conflated**:
   member (b) was scored in the family-B/N campaign and **killed nothing another
   instrument had not already caught** (`J-dv_lead-0118` item 3, recorded there
   as a result and not an omission). That is a measurement about the campaign;
   it neither retracts the alignment point this bound wanted nor converts it
   into coverage the campaign did not produce.
2. ~~**The in-word abort is exercised once, in one form.**~~ **STRUCK 2026-08-06
   — THIS BOUND'S PREMISE WAS FALSE AT THE MOMENT IT WAS WRITTEN, AND TWO ROWS OF
   THIS VERY FAMILY FALSIFY IT** (`FINDING WO-0066-6`, `WO-0066-VERDICT` §6.3;
   `J-dv_lead-0117`, struck in here `J-dv_lead-0118`). *The superseded wording,
   kept beneath the strike because the argument that retired it is only readable
   against it — reproduced verbatim, with its own emphasis intact:*

   > **The in-word abort is exercised once, in one form.** M03-H4's word `c` is
   > the only stimulus in the bench where a start character aborts a frame
   > **opened in that same word**, and it occurs only in the
   > nothing-open-on-entry form. No row drives an in-word abort with a frame
   > already open on entry. A defect scoped to the in-word abort path rather than
   > the cross-word one is therefore visible at **M03-H4 only**, which is exactly
   > what `WO-0058` FINDING GH-2 turned on.

   **What survives, and it is only the first sentence's first clause.**
   `M03-H4`'s word `c` **is** the bench's only **nothing-open-on-entry** in-word
   abort. Everything the bound built on top of that is refuted:

   - **`M03-H2`** drives *"a new `/S/` in **lane 4** of a **mid-frame** word, i.e.
     lanes 0-3 of that word still belong to the aborted frame"* — its own row text,
     above — at **both** start lanes, with `k` chosen per lane so the `/S/`'s
     **absolute** lane is always 4. That is an in-word abort of a frame already
     open on entry, at both members.
   - **`M03-H1` at a lane-4 start** puts its aborting `/S/` at `At_octet 64`,
     octet time `start_ot + 8 + 64` = **84**, i.e. **lane 4**, against a frame
     that has already delivered 64 octets. Same conjunction.
   - **Both landed at `WO-0057`, which is BEFORE `WO-0058` §9 wrote the bound.**
     The claim was never true.

   **`WO-0058` §9 bound 7 — SCORED 3 of 3, 2026-08-06** (`WO-0066-VERDICT` §7,
   under that packet's §4 **rule 1**: IC-A red at all three instances). The three
   instances are `M03-N2` sub-cases 4, 5 and 6, and **the plan records them
   distinguished rather than counted, because the state split is what a bare count
   could not have supported**:

   | instance | frame A's state on entry to W | sealed | observed |
   |---|---|---|---|
   | `M03-N2` sub-case 4 | **`Frame`** | `R!` | red, message-exact |
   | `M03-N2` sub-case 5 | **`Frame`** | `R!` | red, message-exact |
   | `M03-N2` sub-case 6 | **`Preamble`** | `R!` | red, **message miss** (`FINDING WO-0066-5`) |

   All three are *open* under §9's closure list, and **the conjunction is detected
   in both of its state shapes**. §4 rules 2 and 3 did not fire; **rule 4 governs
   the disposition — bound 7 is paid by the bench and scored here, and it leaves
   dv_lead's carried-bounds list now that this plan records the score, the split
   AND the correction.** A score recorded without the correction would carry a
   **false history of a true result**, which is why the three land together.

   **The consequence for what `M03-N2` uniquely buys, stated at full strength
   because it costs this plan a claim it has been carrying.** The bench was **NOT
   blind** to a lane-4 in-word abort of an already-open frame; **three members
   detected it before `M03-N2` existed**; **sub-cases 4 and 5 are NOT the first
   detectors of the conjunction**, and no verdict, `SO-` or campaign may imply
   otherwise. What is genuinely `M03-N2`'s own is the **`Preamble`-state
   instance** (sub-case 6 — `M03-H1`/`H2` abort frames in `Frame` state) and the
   **coincidence geometry** IC-C measures, which exists nowhere else.

   **How the error survived every packet that re-stated it, recorded because the
   mechanism is the lesson and not the arithmetic.** Every one — `WO-0058`, `WO-0061`,
   `WO-0062`, `WO-0063B`, `WO-0065`, `RV-0065-VERDICT`, `RV-0065B-VERDICT` and
   `WO-0066` §4 — **quoted the bound's sentence rather than re-measuring its
   claim**. The census that would have caught it in one command — *which units
   drive a `/S/` in lane 4 against an open frame* — **was never run, because the
   claim read as settled**. §0.1 above is the standing rule this instance mints.

   **Bound 1 above is untouched by any of this**: it is about the **alignment
   transition** an abort exhibits, not about the abort's word geometry, and
   `M03-H1`'s lane-4 member is **offset-preserving** (`close_ot = start_ot + 8 +
   64` and `72 ≡ 0 (mod 8)`, so the `/S/` lands in the frame's own start lane) —
   which is exactly what bound 1 already says. The two bounds select different
   properties of the same two rows, and only bound 7's premise was wrong.

### 4.I Silence, ordered sets and idle — REQ-109, REQ-113, REQ-016

| Row | Attacks | Stimulus | Observable | Kills | Status |
|---|---|---|---|---|---|
| **M03-I1** | REQ-109 | 1000 idle cycles with no frame in flight | `tvalid` = 0 and all five strobes 0 on every one of them | A design that emits a spurious word or strobe out of an empty pipeline | ASSERT |
| **M03-I2** | REQ-109, §6.1's drain derivation, **C-14.3**; at **member (iii)** additionally §9's **no-output-word report path** (ruling 9's sub-5 class) and requirements.md **§0.6**'s window — both carried as **context for the boundary derivation**, and **neither asserted** (Observable cell) | **CORRECTED 2026-08-07 (`J-dv_lead-0082`) — the original stimulus, *a 64-octet frame followed by idle*, cannot reach this row's own declared kill; it is retained as one of two members rather than replaced.** **EXTENDED 2026-08-04 (`J-dv_lead-0102`, `WO-0063` §2.1) — a THIRD member, and it is a *member* and not a new row.** A new row would carry a **copy** of this row's silent-tail scan, and qualifying a copy qualifies nothing about M03-I2; the instrument under test must be the committed one, driven by this row's own runner family. **This corrects `WO-0061` §12's own footnote**, which called for *"a report-path-delay **row** for M03-I2"* — dv_lead's footnote, corrected by dv_lead. (The 2026-08-07 banner above says *"one of two members"*; read as of that date — the count is now three.) **Three members, each followed by idle, driven separately.** **(i)** A **64-octet** frame, **both** start lanes. **(ii)** A **69**-octet frame at a **lane-0** start — a member of M03-C1's own directed set, chosen for its residue and not its length. **(iii)** A frame closed by its **own `/T/`** with **zero** octets received between its start and terminate characters, followed by idle, at **both** start lanes — **M03-F2's `k` = 0 stimulus**, placed as `Injection.corrupt base [Place { At_octet 0; terminate_char }]` with `first_lane` 0 and 4: **no new machinery and no new capability**. It is **inside** this row's declared observable rather than a widening of it — the row asserts an absence from **three cycles after the closing word** onward, and §9 pins this frame's report at **age 2**, which is strictly *before* that boundary — and it is this row's **first strobe-owing member** | No output activity of any kind **from 3 cycles after the terminate word onward** — the tight ΔC − 1 = **2**-cycle drain window §6.1 derives, *not* ΔC. **The boundary is derived per member and per lane and the two are not the same number**: on a `Bench` schedule members (i) and (ii) both put their terminate character in cycle 10 at a lane-0 start and share the boundary at cycle 13, while member (ii) at a **lane-4** start puts it in cycle 11 and its boundary at cycle 14. **MEMBER (iii)'s BOUNDARY, DERIVED HERE AND NOT INHERITED (2026-08-04, `J-dv_lead-0102`).** `At_octet k` lands the injected character at `start_ot + 8 + k`; with `start_ot` = **8** at a lane-0 start and **12** at a lane-4 one, and `k` = 0, the closing `/T/` octet time is **16** and **20** — so the **closing word W is cycle 2 at *both* start lanes** (lane 0 of cycle 2, lane 4 of cycle 2 respectively). From that one number: §9's **no-output-word pin** is at **cycle 4** at both lanes; requirements.md **§0.6**'s window `[W, W + 3]` is **[2, 5]** at both lanes; and **C-14.3's boundary, `W + 3`, is cycle 5** at both lanes. The conformant margin is therefore **one cycle** — the report sits at 4, this row's silence begins at 5 — and it is the same number at both lanes, which is the first member of this row for which that is true. **THE TRAP, named in the plan so that no bench can inherit it silently.** `run_i2_member` derives its boundary from `Arrival.terminate_octet_time`, which is the frame's **declared** terminate; for member (iii) that field is the **auto-placed** `/T/` at octet time 80 — **cycle 10** — and **not** the injected closing character at cycle 2. A member that takes the boundary from that field asserts silence from **cycle 13** onward and is **vacuous by construction**: the entire event under test lies eight cycles before the boundary it would assert. **Member (iii) SHALL derive its boundary from the closing character's own octet time**, and it therefore needs **its own runner beside `run_i2_member`**, not a new argument threaded through it. **WHAT MEMBER (iii) ASSERTS, in order**: construction and landing checked at **both** sites → **no `tlast` word and no `tvalid` word anywhere in the run** (§0.7) → **silence from the boundary (cycle 5) onward — no `tvalid`, no strobe — over the whole remaining run**, under this row's own vacuity guard → **anti-vacuity on the strobe: exactly one pulse in the run, named `error_runt`, at a cycle strictly below the boundary** → conservation (the frame is dropped) → monitors clean. **WHAT IT DELIBERATELY DOES NOT ASSERT: §9's pinned cycle 4.** That exact number is M03-F2's claim and M03-E5's; asserting it here would put a second, **tighter** instrument in front of the C-14.3 window and reproduce at member (iii) exactly the shadowing the member exists to remove (see this cell's Kills column, item (a)). **Both** of the two assertions above **are** the C-14.3 window — one says nothing exists at or after the boundary, the other says the one thing that exists is before it — so whichever of them raises, **the window is what convicted**, and any scorecard records which of the two spoke | A real drain defect one cycle long. A bench using ΔC = 3 as the bound is one cycle loose and lets it through; that looseness is the defect C-14.3 removed from the specification and this row keeps out of the bench. **Why member (ii) exists, and it is a correction of this cell rather than an addition to it.** §6.1's own derivation: with N = 8q + r octets between the start and terminate characters, a **lane-0**-started frame's terminate character lies in word q + 1 and its `tlast` word leaves at cycle q + 2 for r ≤ 4 or q + 3 for r ≥ 5 — **one or two** cycles after the terminate word — while a **lane-4**-started frame gives **zero or one**. A 64-octet frame is r = 0, so a conformant design's last output falls **one** cycle after the terminate word at both lanes and the one-cycle-long defect this cell names emits at **+2**, inside the two cycles member (i) never asserts about: **the original stimulus could not produce the design the cell claims to kill** — the M03-D3 / M03-F2 unachievable-kill shape, found by working §6.1's arithmetic while authoring `WO-0059` and repaired before the row was benched, as M03-D3's ordering was at `J-dv_lead-0038`. Member (ii) is r = 5, so a conformant `tlast` lands **exactly on** the last legal drain cycle, the defect emits at **+3** and dies here, **and a bench that mis-derives the bound one cycle tight goes red against a conformant design instead of passing in silence** — which is the second thing member (i) cannot do. **The maximum drain of 2 is reachable only at a lane-0 start with N mod 8 ≥ 5**, which is why member (ii) names its lane. **WHY MEMBER (iii) EXISTS, and it is the SECOND correction of this cell rather than an addition to it (2026-08-04, `J-dv_lead-0102`, `WO-0063` §1).** Members (i) and (ii) repaired the row's *arithmetic*; they did not make its declared kill reachable, and two facts — both derived from the committed bench and from §9 rather than assumed — say why the window **has never spoken** on either half of its own observable. **(a) The `tvalid` half is permanently shadowed by this row's own earlier assertion.** `run_i2_member` asserts each output word's cycle (`start_cycle + 3 + m`) **before** it scans the silent tail, so a drain defect that emits the last word one cycle late **always** raises at the per-word cycle guard and **never** at the window — at every member, at every lane, structurally. **(b) The strobe half can convict, but members (i) and (ii) are clean frames that owe no strobe at all**, so before member (iii) there was nothing for it to convict on; and this row's only qualifier to date pulsed at offset **+1**, two cycles outside a window that opens at +3, reddening on its `tuser` check (`WO-0061` §3). Member (iii) is the row's **first strobe-owing member** and is therefore what makes *"a real drain defect one cycle long"* reachable **on the only axis that is not shadowed**. **The class it reaches, named in the plan before any diff exists**: a **report-path delay** — a no-output-word report consumed at **age 3** instead of §9's age 2, with the **datapath untouched** (no word moves, no `tkeep` changes, no octet count changes) — which lands the pulse at **cycle 5**, i.e. **at** C-14.3's boundary and therefore outside it. **One instrument fact recorded here because it bounds what any campaign on this row may conclude.** §0.6's window for this report is `[W, W + 3]` = **[2, 5]** while C-14.3's drain bound puts the boundary at `W + 3` = **5**, so **a report deferred to cycle 5 is INSIDE §0.6's window and OUTSIDE C-14.3's bound**. **What that does and does not buy, stated exactly, because the loose form of this sentence is wrong and it was mine** (`WO-0063` §5, corrected forward here at `J-dv_lead-0102` before any bench carried it): the standing `Strobe_monitor` — the obligation-4 monitor on *every* M03 unit — makes **three** checks, and only one of them is blind. Its **pin-against-window** check (§0.6, the specification check) accepts a report at `W + 3` and therefore cannot see the class. Its other two — an expected event that never pulsed, and a high cycle no expected event claims — match **exactly on `(strobe, cycle)`**, so a report moved from `W + 2` to `W + 3` makes the registered event *missing* **and** the observed pulse *unexpected*, and `assert_monitors_clean` fails at **every unit that registers a no-output-word expectation**. **The monitor is therefore not blind — it is not INDEPENDENT**: what it compares against is the pin the bench itself computed and handed it, so it detects nothing a per-row pinned-cycle assertion does not already detect, and it says nothing whatever about C-14.3's bound. **That is the fact that bounds a campaign's claim**: no scorecard may report the standing monitor as a second, independent detector of this class, and the only assertion in this bench that reads a report against **C-14.3** rather than against a bench-supplied §9 pin is this row's window. The one-cycle disagreement between §0.6 and C-14.3 is an **open question for architect_docs_lead** (§8 item 6), not a defect: §9's pin is exact and normative, and §0.6's window is a tolerance that happens to admit one cycle the pin forbids. **And the discount is stated in the plan and not only in the packet**: member (iii) is the **first unit in this programme authored with its mutation class known**, so a kill at this member proves the window **can** convict — never that it is a general detector, and never that the class dies nowhere else (`test_m03_f.ml`'s `run_f2` asserts the pinned cycle exactly and would redden on the same class at every member and both lanes). **What is unique to M03-I2 is the instrument, not the class**: this row's window is the only assertion in the bench that reads a strobe's cycle against **C-14.3's drain bound** rather than against §9's own pin. **QUALIFIED 2026-08-05 — one scoreable class, one kill, 1/1 (`WO-0063B-VERDICT` disposition 1, `J-dv_lead-0108`; campaign `WO-0063B`, sealed at `WO-0063B_m03-i2-report-path-campaign-SEALED-predictions.md` §3.1 before any diff existed).** The killed class **IC-1** is this cell's own named class — a **report-path delay**: the no-output-word report consumed at **age 3** instead of §9's age 2, datapath untouched — and it reddened **member (iii) at lane 0** on the sealed cell hit **character for character**: `M03-I2 (member iii, zero octets received, lane 0): a strobe pulsed at or after cycle 5 (REQ-109, §0.6's ceiling and SPEC-M03 §9's pin -- C-14.3 bounds output words, not strobes)`. **Which assertion spoke is a backtrace, not an argument**: the raise is **step 6's C-14.3 boundary scan** at `test_m03_i.ml:847`, and step 9's `assert_monitors_clean` at `:887` **never executed** — so the window convicted **ahead of every other detector in its own unit**, which is the fact this member was built to establish. The control class **IC-2** left this row **green at all three members and both start lanes**, which is the only way a control proves anything here. **SCOPE, UNABRIDGED — the window convicts; it is NOT the sole detector.** **Eight of the nine units IC-1 reddened detected it without this row** (M03-B2, B3, B4, E2, E5, F2, G7, H4), so this bench was **not** blind to a report-path delay and **no packet may read this qualification as evidence that it was**; the discount two sentences above stands **undiminished by the result** — member (iii) remains the first unit in this programme authored with its mutation class known. **Lane 4 is recorded UNOBSERVED — never as a pass and never as a miss**: `run_i2` drives lane 0 first and lane 0 raises, so the lane-4 cell is structurally unobservable in the same run; the class is reachable there by the auditor's per-lane term-by-term discharge, and observing it needs a lane-4-only driver built for the purpose. **And this cell's not-independent claim is now MEASURED**: across all nine units every conviction was **row-local**, and the standing `Strobe_monitor` **spoke nowhere in the campaign** (`WO-0063B-VERDICT` §5) | ASSERT |
| **M03-I3** | REQ-113 | 100 cycles of a `/Q/` sequence ordered set between two frames, then a frame | No `tvalid`, no strobe during the ordered set; the frame after it compares **word for word** against the same frame received after idles only | A decoder that treats an unrecognised control character as data (it would open or corrupt a frame) | ASSERT |
| **M03-I4** | REQ-016, §6.1's gapless qualifier, **C-14.4**, **C-18**, §6.1's **D(m)** and requirements.md **§0.5**'s deciding input word (`a77017c`, **re-ruled at `1f3c04c`**) | The directed set of M03-C1 driven through an idle-injection wrapper at **0, 1 and 7** idle cycles inside the frame (§10's own figures). **Unchanged by the 2026-08-07 repair below**: the sites are the ones §10 commissions and §6.2's `Frame` row governs, M03-N3's one prohibited boundary is honoured by construction, and a wrapper restricted to inter-frame gaps would measure REQ-109 rather than REQ-016 | **`Observable` REPAIRED 2026-08-07 (`J-dv_lead-0085`), under the §0.5 + REQ-016 ruling at `a77017c` countersigned in `WO-0059`: the cell this replaces asserted the per-octet constant of §7, which no conformant design can satisfy under injection at either start lane.** (a) The output **word sequence** is unchanged — the ordered (`tdata`, `tkeep`, `tlast`, `tuser`) tuples, every octet in its own byte position. (b) **Each output word is delayed by exactly the idle cycles injected at or before its deciding input word D(m)**, at **both** start lanes; SPEC-M03 §6.1 names D for this module, and **D(m) is RE-RULED at `1f3c04c` (`J-architect_docs_lead-0025`), countersigned at `J-dv_lead-0086`**: **D(m) is the input word carrying whichever of two pieces of evidence arrives first — received frame octet `8m + 12`, whose arrival proves the frame runs past word m, or the character that closes the frame** (REQ-106's `/T/`, REQ-105's `/E/`, REQ-110's `/S/`, REQ-108's count). The two are **exclusive**, and `N ≥ 8m + 13 ⟺ m < W − 1` **exactly**, so the first decides precisely the **non-`tlast`** words and the second precisely the **`tlast`** word, whose `tkeep`, `tlast` and `tuser`[0] are not decidable before it (REQ-011, REQ-103, REQ-104). *The clause this replaces keyed a non-`tlast` word to the input word carrying its own **last** octet. That word decides nothing — whether word m keeps eight octets and whether it is its frame's last are both settled by what arrives **after** its octets — so pinning against it is hindsight, refutable by arithmetic: rtl_lead's E5 (`BUG-0002`) exhibited two frames, and the causality sweep at `J-dv_lead-0086` found the replaced rule violates §0.5's causality test **2 268** times over N ∈ [5,80] × k ∈ {0,1,7} × both start lanes where the ruled D(m) violates it **not once**.* **No `tlast` word's cycle moves at any `k`** and **no gapless cycle moves at all** — the (b) branch is the unchanged one — so this row's `k = 0` members and every other family are untouched by the re-ruling. **And a word whose D(m) has not arrived is NOT emitted (`tvalid` = 0)**: that half needs no separate guard, because this row's word-**count** guard and its per-word **cycle** guard cover it **as a pair** — an early emission that also repeats at the pinned cycle breaks the count, one that replaces it breaks the cycle — and neither alone suffices. FCS verdicts unchanged; no strobe of any kind. **The per-octet constant of §7 is MEASURED and REPORTED, never asserted** — §0.5 forbids demanding a single per-octet L on an injected run at a module failing either of its two tests, and M03 fails **both**: the `tlast` word is late-decided (§6.1's residue table — later at `r ∈ {0,1,2,3,4}` at a lane-0 start and `r ∈ {0,4,5,6,7}` at a lane-4 one) and `h = 12` straddles at a lane-4 start. **§6.1 item 3's carve-out — a lane-0 start with `r ∈ {5,6,7}`, where `L = 16` was said to hold octet for octet — is WITHDRAWN at `1f3c04c` and nothing in this cell rests on it**: those `tlast` octets do still measure 16, but under the re-ruled D(m) every earlier word measures `16 + 8k`, so that case has **two** classes and not one. The classes this row **reports**, for a frame of more than one output word, are: **lane 0** — `r ∈ {0…4}` → `{16 + 8k}`, `r ∈ {5,6,7}` → `{16, 16 + 8k}`; **lane 4** — `r ∈ {0,4,5,6,7}` → `{12 + 8k, 12 + 16k}`, `r ∈ {1,2,3}` → `{12, 12 + 8k, 12 + 16k}`, **three classes**, which is `J-dv_lead-0086`'s **FINDING F-1** against SPEC-M03 §6.1 item 2's lane-4 cell and is **outstanding with architect_docs_lead**. Lengths 65, 66 and 67 at a lane-4 start are the members of M03-C1's own directed set that print it. **Every one of these values is REPORTED and none is ASSERTED**, so F-1's resolution moves this row in neither direction | A design that decodes an idle word inside an open frame as eight data octets: the CRC is then corrupted and **every** frame the wrapper touches reports a false `error_bad_fcs`. This is the C-14.4 hold rule made executable. **And the class this row actually caught, on the first stimulus in this programme ever to drive an idle inside an open frame at any DUT — `BUG-0002` (CRITICAL, 2026-08-07): a design that marks `tlast` on a word the terminate character has not yet decided.** At length 64 / lane 0, at **both** `k = 1` and `k = 7`, M03 emits the conformant **eight** words at the conformant cycles with the conformant `tkeep` and sets `tlast` on **word 0** — changing the delivered tuple sequence REQ-016's own sentence forbids changing, and closing a 60-octet frame on its first word. **Clause (b)'s cycle rule PASSED at that word**: the arrival guard is not what caught this, the tuple guard is, and a row asserting cycles alone would have been green on it. **Both clauses are load-bearing and neither subsumes the other** — which is the reason the repaired cell keeps (a) as an assertion rather than folding it into (b) | ASSERT |
| **M03-I5** | REQ-016, §6.1, **C-14.4**, requirements.md **§0.5** (`a77017c`) | (same runs as M03-I4) | **§6.1's `m + 3` cycle formula is NOT asserted under injection.** It is scoped to a gapless stimulus in octet times; a bench asserting it under idle injection fails a conformant design. **REPAIRED 2026-08-07 (`J-dv_lead-0085`): the gap-invariant quantity is NOT the per-octet constant.** That claim was this cell's own, it was unsatisfiable at both start lanes, and it is what **`SCR-M03-I4`** retired (requirements.md §0.5 and SPEC-M03 §6.1 at `a77017c`). **The gap-invariant quantity is the per-output-event delay from its deciding input word D**, and that is what M03-I4 asserts; the per-octet constant is reported as data and asserted nowhere. **This row's NO-ASSERT scope therefore widens by one**: on an injected run neither `m + 3` nor a single per-octet L may be asserted — the second half is the one that would have failed a conformant design, and the first half never could | — | NO-ASSERT |
| **M03-I6** | REQ-016, REQ-107, REQ-108, §6.2's `Frame` row | A 64-octet frame and a 1518-octet frame, each with **7** idle cycles injected between every pair of words | No strobe pulses at all: the octet counts governing REQ-107 and REQ-108 are unchanged by idle cycles, so neither frame changes class | A design that counts **cycles** rather than **octets** toward the runt and oversize thresholds. Under 7-cycle injection a 1518-octet frame occupies ~1500 cycles and the wrong design pulses `error_oversize`; the 64-octet frame is the anti-vacuity partner | ASSERT |

### 4.J Configuration — REQ-802, REQ-803, REQ-810, §4.3

| Row | Attacks | Stimulus | Observable | Kills | Status |
|---|---|---|---|---|---|
| **M03-J1** | REQ-810, §4.3 | `cfg_rx_enable` = 0 held, 100 frames injected (REQ-810's own figure) | No output word, no header effect and **no strobe** anywhere; the conservation monitor records all 100 as `frame_in_exempt` (C-2), not as discards. **THE `frame_in_exempt` DEMAND IS CORRECT AND IS NOT STALE, and this cell now says why in one clause so the next reader does not re-litigate what `WO-0067` §5.2 had to derive** (2026-08-09, `J-dv_lead-0124`). Three facts, each read at its own source rather than taken from a packet that quotes it. **(i) The equation's *presented* term is zero for a refused frame, by specification.** SPEC-M03 §6.1's disabled-state paragraph: *"a bench's frame-conservation monitor (§0.6) counts no frame presented across the disabled window"*. **(ii) The exempt ledger is outside the equation**, so calling `frame_in_exempt` is what keeps that term at zero **by construction while still recording the frames** — `test/monitors/conservation_monitor.mli`'s **deviation 3**, which names **REQ-810** by number and states in terms that `frame_in_exempt` records such frames *"with a reason, outside the equation"*. A `frame_in` here is therefore not a stricter accounting but a **wrong** one: it would put a presented frame into an equation the specification says has none, and report the silent-discard hole REQ-810's own next clause disclaims. **(iii) ADR-0014's *"the conservation monitor needs no new exemption"* does not bear against either**, and it is quoted here at its own words because the loose reading of it is how this demand comes to look stale: the ADR's claim is that the **equation needs no new term**, on two grounds — refused frames are **not presented** in §0.6's sense, and the **in-flight** frame at M03-N4 balances **under its own strobe** — and its contrast with `clear` (C-2) is about *which frame* needs an exemption, not a licence to count a refused frame as presented. **No *new* exemption is needed because C-2's already exists and already names REQ-810**, which is §2 obligation 2 of this plan read at its word. **THE CAUTION THAT RIDES WITH THE DEMAND, and it binds every later packet**: the exempt count is **bench-supplied** — it counts the calls the unit made, not anything the DUT did — so **it is not independent evidence that 100 frames were driven**, and no `SO-` may cite it as such. Same shape as the standing `Strobe_monitor` at M03-I2, measured rather than argued (`WO-0063B-VERDICT` §5). The honest evidence for the drive is the schedule's own frames array plus the mandatory anti-vacuity control — the same schedule on a fresh bench at `Enable.high` delivering all **101** frames | A design that gates the output but leaves the strobe path live — it would report 100 discards for frames it never accepted, and a monitor without the exemption would report a silent-discard hole where REQ-810 says there is none | ASSERT |
| **M03-J2** | REQ-803, §4.3 | `cfg_rx_enable` 0 → 1 at least one cycle before a start character; then frames | The first frame whose start character is accepted at least one cycle after the change is received correctly and completely | **THE STATED KILL IS UNREACHABLE UNDER THIS ROW'S OWN STIMULUS AND IS WITHDRAWN — 2026-08-09 (`WO-0067` §6, derived `J-dv_lead-0119`; landed here `J-dv_lead-0124`). The defect is this plan's, not the bench's, and it was found the way the three before it were found — this is the shape's **fourth** instance in this plan: by working the row's own arithmetic while authoring the packet that commissions it, before a bench existed.** *The superseded cell, kept beneath the strike because the argument that retired it is only readable against it:* ~~"A design that samples the enable continuously and truncates the frame it just admitted"~~ (the cell's own words, quoted with nothing added inside the quotation marks). **Why this stimulus cannot reach it.** The row's own Stimulus takes the enable **0 → 1** at least one cycle before the start character and holds it at **1** for the whole of the admitted frame. A design that samples the enable **continuously** therefore reads 1 on every cycle of that frame and truncates nothing — the withdrawn cell's class and a conformant design produce the same output here, and a row that cannot separate them is not attacking them. **Where that kill does live: M03-J3**, whose stimulus takes the enable **1 → 0 *inside* the admitted frame**, which is the only geometry at which a continuously-sampling design truncates; M03-J3's Observable — *the in-flight frame completes under the old value* — is what convicts it, and this row must not claim it. **THE HONEST KILL, AND IT IS THIS ROW'S OWN**: a design that **refuses the first frame after a re-enable** — one that latches the enable to a frame boundary that never arrives while the line is idle, or that needs more than one cycle of settling before a start character may be admitted. §4.3's sentence is *"a frame whose start character is accepted at least one cycle after the input changes is governed by the new value"*, so the **tightest legal placement — exactly one cycle — is what makes that class reachable at all**, which is a second and independent reason the change is placed tight rather than comfortably early. **Disposition, and it is the M03-D3 / M03-F2 / M03-I2 precedent applied unchanged**: the row **stays ASSERT**, because its *observable* is sound and is REQ-803's own (a frame admitted after the change is received correctly and completely) and REQ-810's verification column commissions it in terms. What the finding changes is **the claim a round may make about this row**, never its status — and no `SO-`, campaign or verdict may cite this row as detecting continuous enable sampling | ASSERT |
| **M03-J3** | REQ-803, §4.3 | `cfg_rx_enable` 1 → 0 **mid-frame**, at least one cycle away from any start character; the frame ends with `/T/` | The in-flight frame **completes under the old value**: its words, its `tlast`, its FCS/runt verdict and its strobes are exactly those of the same frame with the enable held at 1. The **next** frame's start character is not accepted | A design that gates the datapath rather than the start character: it truncates the in-flight frame with no `tlast` and no strobe, which is a silent discard REQ-009 does **not** license (only `clear` may do that) | ASSERT |
| **M03-J4** | §4.3, §6.3 item 7, **C-14.5** | — | A change landing on the **exact cycle** of a start character has no determinate outcome and **SHALL NOT** be driven-and-asserted; every enable change in this plan is placed at least one cycle away from any start character | — | NO-STIMULUS |

### 4.K Reset — REQ-009, §7

| Row | Attacks | Stimulus | Observable | Kills | Status |
|---|---|---|---|---|---|
| **M03-K1** | REQ-009 | `clear` = 1 for 5 cycles while no frame is in flight | `tvalid` = 0 and all five strobes 0 on every `clear` cycle **and on the first cycle after it returns to 0** | **ONE OF THE TWO STATED CLASSES IS NOT SEPARATED BY THIS ROW'S OWN STIMULUS AND THE CLAIM IS WITHDRAWN — 2026-08-09 (`WO-0072` §7.5, derived `J-dv_lead-0130`; landed here `J-dv_lead-0132`). The defect is this plan's, not the bench's, and it was found the way the five before it were found — by working the row's own arithmetic while authoring the packet that commissions it, before a bench existed.** **Kill (a) — *"a design whose strobe registers survive `clear`"* — is REACHABLE and tightly placed.** M03's strobes are combinational in the current XGMII word (SPEC-M03 §6.1's one-word lookahead; `BUG-0001`'s R-1 finding is the evidence), so an implementation that registers a strobe output and does not gate that register with `clear` re-presents the pre-clear pulse **inside** the window; **opening the window on the cycle immediately after the frame's own strobe is what makes that class reachable at all**, which is why the placement is tight rather than comfortable. *The superseded second class, kept beneath the strike because the argument that retired it is only readable against it:* ~~"or that needs a second cycle to settle"~~ (the cell's own words, quoted with nothing added inside the quotation marks). **Why this stimulus cannot reach it**: a design whose `clear` takes effect one cycle **late** behaves un-cleared on the first window cycle — where a conformant design also produces nothing, because the frame drained before the window opened — and a design needing an extra cycle to go quiet **after release** has nothing pending to show on the release cycle. Both are **invisible here**. The only member of the class this stimulus does separate is narrow — a design that *suppresses without resetting* and re-presents the suppressed strobe on the release cycle — and that is caught, but it is **not** the general class the cell named. **THE HONEST KILL, AND IT IS THIS ROW'S OWN**: *a design whose strobe path survives `clear` — either by presenting a pre-clear strobe inside the window, or by holding it suppressed and re-presenting it on the release cycle* — plus, from the row's mandatory control run, *a design whose clear gating is off by one cycle at the leading edge*. **Where the withdrawn class DOES live: M03-K2**, whose window opens over a frame with six output words still to come and closes on a cycle carrying a start character, so a design needing an extra settling cycle either emits a held word on the release cycle or fails to accept that start character — both asserted there. **Disposition, and it is the M03-D3 / M03-F2 / M03-I2 / M03-J2 / M03-N4 precedent applied unchanged at its SIXTH instance**: the row **stays ASSERT**, because its *observable* is REQ-009's own words and §4.K commissions it in terms. What the finding changes is **the claim a round may make about this row**, never its status — and **no `SO-`, campaign scorecard or verdict may cite M03-K1 as detecting a design that needs a second cycle to settle** | ASSERT |
| **M03-K2** | REQ-009, §7's reset bullet | `clear` asserted **mid-frame**, deasserted, and a new frame whose start character arrives on the **first** cycle after `clear` returns to 0 | The in-flight frame vanishes with **no `tlast` and no strobe**; the new frame is received correctly and completely. The conservation monitor records the abandoned frame as `frame_in_exempt ~reason:"clear"` — without that exemption a conformant M03 fails (C-2 at its first module) | A design that emits a `tlast` on `clear` (a phantom frame downstream); a design that needs one idle cycle before it can accept a start character; a monitor that counts the abandonment as a silent discard. **ALL THREE CELLS STAND, NO KILL IS WITHDRAWN, AND THE THIRD IS RECLASSIFIED — 2026-08-09 (`WO-0072` §8.6, `J-dv_lead-0130`; landed here `J-dv_lead-0132`).** **Kill 1 is reachable at THREE distinct sites** and is this row's principal attack: at the window's **opening** edge (a design reading `clear` as *"close the current frame"* rather than *"abandon it"*), at the **release** edge (a design that holds the abandoned frame's closure and emits it when `clear` lifts), and at **frame A's own terminate character inside the window** (a design that latches the `/T/` while cleared and closes on release) — the third site existing only because the window was placed to cover A's `/T/`, on §6.2's `Idle` row (*"ignores every lane"*), which is unambiguous for `/T/`. **Kill 2 is reachable and is the tightest legal placement**: REQ-009's last sentence names the release cycle specifically and the new frame's start character is on it, so a design needing an idle cycle first either delivers nothing for that frame or delivers it late, and the row's delivered-cycle list separates both. **Kill 3 — *"a monitor that counts the abandonment as a silent discard"* — IS NOT A DESIGN KILL, and it is RECLASSIFIED rather than dropped.** The call is the row's own; **no design can cause it to be wrong**. What the cell states correctly is that the **C-2 exemption path is a PRECONDITION of the row**: with `frame_in` in place of `frame_in_exempt`, a *conformant* M03 shows `residual` = 1 and the round reds. So it is a statement about the **monitor contract**, discharged by the row's own `frames_exempt` = 1 assertion — **not an attack this row mounts against the DUT, and no `SO-` may count it as one.** The cell is **true as written**; what it is not is a design kill, and that distinction is recorded here rather than repaired away | ASSERT |
| **M03-K3** | REQ-009, REQ-015 | (same as M03-K2) | The protocol monitor's frame-in-progress state is reset on `clear` and **no assertion is made across the clear** | — | NO-ASSERT |

> **FAMILY K — LANDED STATUS, 2026-08-09 (`J-dv_lead-0132`). Every status word
> below travels with the SHA and the CI run id it was read at, because §0.1
> binds this paragraph and because a census figure quoted without a CI reading
> is a title count wearing a pass's clothes (`RV-0068B-VERDICT` §7).**
>
> | Row | Status | The evidence, not the adjective |
> |---|---|---|
> | **M03-K1** | **LANDED, GREEN** | One unit in `test/xgmii_rx_64/test_m03_k.ml` plus its mandatory control run at the default schedule; green at **`284225d`**, CI `build` run **`31032021108`**, step 6 *"Run tests"* and step 8 *"Verify nothing was left unpromoted or non-deterministic"* both `success`, `run_attempt: 1`. **The FIRST unit in this suite ever to drive `clear`.** Its Kills cell carries the withdrawn second class above; the row is green on its observable, not on that claim. |
> | **M03-K2** | **LANDED, GREEN** | One unit at the same SHA and run, with its own control run at the default schedule proving the schedule carries two well-formed frames. What the green positively establishes, and it is worth stating because a green is otherwise only an absence: no `tlast` attributable to the abandoned frame anywhere; the next frame present and complete at its own cycles; `tvalid` = 0 and every strobe 0 across the window **and the release cycle**; `cleared_mid_frame` = 1; `residual` = 0 with `frames_exempt` = 1. |
> | **M03-K3** | **NO-ASSERT, UNMOVED** | Not discharged and not claimed. The protocol monitor's frame-in-progress reset is machinery family K's round **wires**; it is never a design assertion that round makes, and **no unit title in `test_m03_k.ml` names M03-K3**, so the census cannot record it as discharged. |
>
> **The census, measured rather than recalled, at BOTH ends and as a SET.** At
> `284225d` by `RV-0072-VERDICT` bar K-4 and independently by CI's own step 9
> inside `build` run `31032021108`: bench inventory **56 → 59** under
> `test/xgmii_rx_64/` and **136 → 139** repository-wide; row-discharge census
> **60 → 62** under the trailing-digit **boundary** matcher and **60 → 62** naive,
> with the over-discharged set **empty at both ends**; declared adjustments **−1**
> (`M03-A4`, a NO-ASSERT row named in a title) and **+1** (`M03-F5`, discharged by
> citation), **net zero**. **Gained set = exactly `{M03-K1, M03-K2}`; lost set =
> empty** — measured as a set difference and not as a difference of totals,
> because a difference of totals cannot distinguish *"two gained"* from *"three
> gained and one lost"*. Against this plan's ASSERT denominator of **62**: **62 of
> 62, outstanding set EMPTY.** Re-measured at **`5d2beff`**, this round's own base,
> by `bash tools/dv_checks.sh`: 78 row ids declared, **62** naive, **62** boundary,
> inventory **59** / **139** — unchanged, which is the check that this round's own
> plan edits moved no count.
>
> **THE BENCH ERA OF `Xgmii_rx_64` CLOSES HERE, AND THAT IS ALL IT MEANS.** Five
> things the number does not buy, stated because silence would let them be
> assumed. (1) **It is not an `SO-` PASS and does not open one**: the family **J,
> K, L and M** mutation campaigns are outstanding, PROTOCOL §10-sequenced after
> `RV-` ACCEPT and before any `SO-` PASS, and the charter §3 **verilog-ethernet
> differential co-sim anchor** is undischarged (§7's banner, per class). (2) **It
> is a TITLE count, not a pass** — the pass is the run id, and the two are quoted
> together above or not at all. (3) **M03-K3 is not discharged** (row above).
> (4) **Every rider continues**: M03-K1's withdrawn class, M03-K2's reclassified
> third kill, and the standing rule that a `frames_exempt` count is
> **bench-supplied** and is never evidence that a frame was driven — the control
> run carries that. (5) **Neither pre-scan guard has ever fired on a real
> violation.** Both K rows *enter* the `clear` guard and find nothing, which is a
> non-violation and is exactly the status the M03-J4 guard's driven-word reading
> has carried since `2dbd39b`; the `clear` guard's **entry condition** is now
> mechanically witnessed by the structural unit, its **refusal** is not. That is a
> standing fact about both guards and it belongs beside X-6 and X-7, not inside a
> claim.
>
> **This round is silent on §3.2's spec ambiguity BY DESIGN**: neither row drives
> a start character under `clear` = 1 — the guard refuses that stimulus — so the
> green says nothing about which of SPEC-M03 §6.2's `Idle` row and §7's reset
> bullet governs a cycle carrying both. That is the guard working; the ambiguity
> is unchanged, non-blocking, and queued for architect_docs_lead (§8).

### 4.L Line rate, constancy and order — REQ-004, REQ-005, REQ-111, REQ-019, REQ-020, REQ-112, §8

| Row | Attacks | Stimulus | Observable | Kills | Status |
|---|---|---|---|---|---|
| **M03-L1** | REQ-004, §8 checks 1–2 | §8's stress run: **10 000** consecutive 64-octet frames, start lanes alternating 0 and 4, start-to-start spacing alternating **10 and 11** cycles, minimum 12-octet gap, zero error injection | 10 000 frames out for 10 000 in; every frame's 60 delivered octets equal the injected octets 0–59; the four-octet sequence numbers arrive 0, 1, 2, … with no gap and no repeat; conservation holds; no strobe pulses anywhere in the run | Word loss under sustained line rate — the only observable failure mode REQ-112 has (§10). A design with any internal backpressure or a one-cycle recovery between frames fails within the first hundred frames | ASSERT |
| **M03-L2** | REQ-005, REQ-111, §8 check 3, §0.5 | (the same run, through the latency tagger) | **One** L per front-offset class across all 10 000 frames: L = **16** at h = 8 (lane 0) and L = **12** at h = 12 (lane 4). Not a mean, not one L for the run | A design whose latency depends on frame content or on which frame it is; and a monitor asserting a single L across a two-lane run, which fails a conformant M03 on frame 2 (C-15 — observed, not hypothetical) | ASSERT |
| **M03-L3** | REQ-019, §1.1, §7 | (the same run) | Measured ΔC = (L + h)/8 = **3** in both classes, against the §1.1 ceiling of **4**; the one unspent cycle is reported as M03's reserve. The observed front offset of every frame is 8 or 12 and no other value | A ΔC computed from the octet-correspondence term instead of §0.5's front offset, which reports **2** at a lane-4 start and understates the hardest receive module by a cycle in its own sign-off packet (the WO-0012 tagger defect, fixed; this row keeps it fixed) | ASSERT |
| **M03-L4** | REQ-020, §8 check 2 | (the same run) | The delivered sequence is exactly 0 … 9999 | A design holding more than one frame, or reordering across the alternating start lanes | ASSERT |
| **M03-L5** | REQ-005, REQ-103, §8's directed set | Frames of 64 … 71 and 1518 octets at both start lanes (M03-C1, M03-C3) through the tagger | The same two constants as M03-L2 at every one of those lengths | A pipeline whose delay varies with the final `tkeep` residue — length-dependent latency that a fixed-length stress run cannot see | ASSERT |
| **M03-L6** | REQ-112, REQ-003 | — | The module exposes **no `tready`** on the stream under test and no `tready` input exists. Structural: a statement about the type, not an assertion that can fail (§8 check 4) | — | STRUCTURAL |

> **FAMILY L — LANDED STATUS, 2026-08-09 (`J-dv_lead-0132`, from
> `RV-0070-VERDICT`, `J-dv_lead-0127`). Every status word below travels with the
> SHA and the CI run id it was read at (§0.1; `RV-0068B-VERDICT` §7).**
>
> | Row | Status | The evidence, not the adjective |
> |---|---|---|
> | **M03-L1** | **LANDED, GREEN** | One 10 000-frame run, alternating start lanes, 10/11-cycle start-to-start spacing, shared with L2, L3 and L4 in a single unit of `test/xgmii_rx_64/test_m03_l.ml`; green at **`630e34a`**, CI `build` run **`31015276337`**, steps 6 and 8 both `success`, and **the units' first execution anywhere** — no predecessor run had ever elaborated them. |
> | **M03-L2** | **LANDED, GREEN** | Same run, through the latency tagger: one **L per front-offset class** across all 10 000 frames, `L = 16` at `h = 8` and `L = 12` at `h = 12`, the two constants re-derived at the packet rather than transcribed. |
> | **M03-L3** | **LANDED, GREEN** | Same run: ΔC = (L + h)/8 = **3** in both classes against §1.1's ceiling of 4, with the one unspent cycle **reported in the packet's derivation** and not printed — an empty `[%expect]` block forbids printing, which is a property of the instrument and is recorded so no reader looks for the figure in a snapshot. |
> | **M03-L4** | **LANDED, GREEN** | Same run: the delivered sequence is exactly 0 … 9999. Stated implied-by-L1 in the packet rather than hidden inside it. |
> | **M03-L5** | **LANDED, GREEN** | The directed set — 18 runs at 64 … 71 and 1518 octets, both start lanes — in the file's second unit, with the 1518 row cross-checked against landed M03-C3 **and** against `Protocol_monitor`'s own `max_words_per_frame` bound (190 words touches the bound without crossing it). |
> | **M03-L6** | **STRUCTURAL, UNMOVED** | A statement about the interface type, discharged by compilation; no waveform, no coverage claimed beyond it. |
>
> **The census, measured at both ends and never derived** (`RV-0070-VERDICT` bar
> L-14): boundary-matched census **48 → 53**, `test/xgmii_rx_64/` inventory
> **54 → 56**, repository-wide **134 → 136**, base `d943d33` measured from git
> objects and landing `630e34a` measured **twice independently** — at a clean
> working tree and by the same script's own step-9 output inside CI run
> `31015276337`. **The +5 is pinned by a NEGATIVE and not by subtraction**: no
> `M03-L` row id is named in any unit title at the base, so the five gained rows
> are exactly family L's.
>
> **The cost question, settled by measurement rather than by estimate.** The round
> opened with a Cyclesim cost probe on a throwaway ref against three
> pre-committed bands, and band A held: **T = 2.036 s** with 14.7× headroom,
> **the 10 000-frame stimulus was never reduced**, and the landed unit's own test
> step cost **4 s**, 1.16 % of the job. The rider that predicted ≤ 5 s was scored
> **against its author** and held. **The frame count is not reduced inside DV
> under any circumstances** — a reduction is an E2 scope decision with numbers
> attached, and this round produced the numbers instead.
>
> **What this does and does not buy.** (1) **The `P1-module-ready` line-rate-stress
> row now has both halves — EVIDENCED, NOT SIGNED**: PROTOCOL §7 requires
> line-rate stress green for rx-path modules, and it is; the signature is the
> orchestrator's to transcribe against a journal entry, not this plan's to claim.
> (2) **Landed-and-green is NOT qualified**: family L is **unscored** by any
> mutation campaign, no kill evidence is claimed anywhere for these five rows, and
> the campaign is owed **before** any `SO-`. (3) **OBSERVATION L-O1 is carried, not
> paid** — a leftover-remainder guard in `test_m03_l.ml` labels a design-reachable
> condition *"test bug"* (`FINDING B-1` inverted): it can mislabel a red, it can
> never flip a verdict, and its named carrier is **the next commit that opens
> `test/xgmii_rx_64/test_m03_l.ml`**, which this round is not.

### 4.M Co-occurrence — §9's rulings, §0.6

Each row is one of §9's co-occurrence statements about which conditions may
co-occur, made into an assertion. Stimuli are reused from the families above.
**Row-index warning**: M03-M1 … M03-M8 correspond to §9's rulings 1 … 8
positionally, and **that correspondence ends there**. M03-M9 is the §0.6
inheritance row and predates the ninth ruling; §9's **ruling 9** is therefore
**M03-M10**, not M03-M9. The mismatch is deliberate — renaming a committed row
id would break this plan's own §5 citation of M03-M9 — and it is stated here
because the obvious inference is the wrong one.

| Row | Attacks | Stimulus | Observable | Kills | Status |
|---|---|---|---|---|---|
| **M03-M1** | §9 ruling 1 | M03-F3 | `error_runt` **and** `error_bad_fcs` both pulse once for one frame; `tuser`[0] set once | A precedence design | ASSERT |
| **M03-M2** | §9 ruling 2, REQ-108 | M03-G1 | `error_bad_fcs` does **not** pulse for the truncated frame | A design that checks the residue at the truncation point, where no FCS is present | ASSERT |
| **M03-M3** | §9 ruling 3, REQ-105 | M03-E1 | `error_bad_fcs` does **not** pulse for a frame ended by `/E/` | A design that runs the residue comparison on every frame closure regardless of how it closed | ASSERT |
| **M03-M4** | §9 ruling 4, REQ-110 | M03-H1 | `error_bad_fcs` does **not** pulse for a frame ended by a new `/S/` | (as M03-M3) | ASSERT |
| **M03-M5** | §9 ruling 5 | M03-H3 | Exactly one `error_bad_frame`; no `error_start_without_terminate` | A design in which `/E/` does not close the frame | ASSERT |
| **M03-M6** | §9 ruling 6 | **M03-G3 AND M03-G7** — 2026-08-09 (`FINDING M-1`, `WO-0071` §5.1, derived `J-dv_lead-0128`; landed here `J-dv_lead-0132`). **The single carrier this cell named was never re-pointed after WO-0056 built the second epoch, and it does not drive this ruling's own condition.** Ruling 6 reasons about a start character arriving **during the `Discard` state**; in M03-G3's stimulus the start character arrives at content index 1620 against a terminate at 1600, i.e. **after the oversize frame's own `/T/`**, so `Discard` has already been left. G3 witnesses the ruling's *conclusion* (never on the same frame) on a stimulus where the frame is **doubly closed**; it does not reach the state the ruling reasons about. **This is not a new discovery about the design and it is not a bench change** — both epochs are landed and green, and §4.G's own M03-G3 cell says it in terms (*"this row does not reach the first epoch … that gap is M03-G7's"*, measured rather than argued: `WO-0055`'s G-c4 mutation survived all twenty-five units). What was owed was the **binding**, and it is paid here. **What no packet may say after this: no `SO-`, campaign or scorecard may cite M03-M6 as coverage of the `Discard`-state case ON THE STRENGTH OF M03-G3. That coverage exists and it is M03-G7's** | Exactly one `error_oversize`; no `error_start_without_terminate` | A design that re-opens a truncated frame | ASSERT |
| **M03-M7** | §9 ruling 7, **C-12** | **M03-G4 AND M03-G8** — 2026-08-09 (`FINDING M-2`, `WO-0071` §5.1, derived `J-dv_lead-0128`; landed here `J-dv_lead-0132`). The same defect and the same repair, one ruling over: ruling 7 reasons about an **error character arriving in `Discard`**, and M03-G4's arrives at content index 1618 against the same terminate at 1600 — **after** the frame's own `/T/`, with `Discard` already left. **M03-G8 is the first-epoch carrier**, built at WO-0056 for exactly this gap; §4.M was written before WO-0056 and its Stimulus cells still pointed at the pre-repair carriers. Both epochs landed and green, so nothing is owed to `test/**` beyond the binding, and **the titles say which epoch each carries**. **No `SO-`, campaign or scorecard may cite M03-M7 as coverage of the `Discard`-state case on the strength of M03-G4** | Exactly one `error_oversize`; no `error_bad_frame` | (the C-12 ruling, as M03-G4) | ASSERT |
| **M03-M8** | §9 ruling 8 | — | `error_runt` and `error_oversize` cannot co-occur: the octet ranges are disjoint, so **no stimulus exists** and none is written | — | NO-STIMULUS |
| **M03-M9** | §0.6, §9's closing paragraph | Every row in families E–H | M03 **inherits** no abort and never pulses a strobe to re-report one: it is the origin of `tuser`[0] on this chain, and there is no input bit to re-report | A design that would need this rule is not expressible at M03; the row is stated so no `SO-` claims §0.6's inheritance clause as tested coverage here. **Not §9's ruling 9** — see the row-index warning above | STRUCTURAL |
| **M03-M10** | §9 **ruling 9** (`1fe71ca`), §9's sixth row, §6.2's `Frame` row `/T/` exit, REQ-104, REQ-107 | **No new stimulus is owed**: M03-F2's 0-, 1- and 4-octet frames and M03-B3's `/T/` in a preamble position already drive the whole class. Drive them and assert the strobe set **exhaustively** | `error_bad_fcs` does **not** pulse for any frame of fewer than 5 octets between start and terminate: `error_runt` pulses **alone**, an exact set and not a lower bound. REQ-104 supplies neither operand for such a frame — no FCS is removed (§9's sixth row), so no comparison is made and there is no mismatch to report — and §6.2's `/T/` exit says the check is **not sequenced** in this class | A design that runs the residue comparison at **every** terminate character regardless of whether the frame had an FCS to check — M03-M3's kill one closure-class over. **The kill is sharp and it is not uniform across M03-F2's three lengths**: at 0 octets the register still holds §6.1 item 1's 0x00000000 seed, and at 1–3 octets a partial CRC, none of which equal REQ-304's residue, so the wrong design goes red; at **4 octets it depends on the filler**, and the single frame `00 00 00 00` yields exactly 0x2144DF1C and passes by accident. **A bench SHALL therefore use a non-zero 4-octet filler**, or drive both and assert the pair identically — an all-zero 4-octet frame alone is a vacuous test of this row | ASSERT |

> **FAMILY M — LANDED STATUS, 2026-08-09 (`J-dv_lead-0132`, from
> `RV-0071-VERDICT`, `J-dv_lead-0129`). Every status word below travels with the
> SHA and the CI run id it was read at (§0.1; `RV-0068B-VERDICT` §7).**
>
> **The shape of this family's round is itself the status, and it is unlike every
> other family's.** All seven of §9's co-occurrence rulings were **already
> asserted, exactly, and green** at the carriers named in the Stimulus column —
> every carrier already matched `Bench.error_pulses` against a literal, and five
> already cited the ruling by number in their failure messages. **There was no
> assertion left to commission.** What was missing was the **binding** between
> plan row and discharging unit, because the census reads row ids out of unit
> titles and no title named `M03-M1` … `M03-M7`. So the round **bound and nothing
> else**, and its signature was made checkable in advance: **the inventory does
> not move and the census moves by seven.**
>
> | Row | Status | The evidence, not the adjective |
> |---|---|---|
> | **M03-M1** … **M03-M7** | **BOUND, LANDED, GREEN** | Seven titles gained their row ids at **`70a263f`**, CI `build` run **`31022685374`** (job `92363162764`, step 6 `success` 15:59:27→15:59:30, step 8 `success`; `cosim` job `92363162503` step 6 `success`; `journal-check` run `31022684357` `success`). **M03-M6 and M03-M7 each bind to TWO carriers** — see their Stimulus cells and `FINDING M-1`/`M-2` above. |
> | **M03-M8** | **NO-STIMULUS, UNMOVED** | The octet ranges are disjoint, so no stimulus exists and none is written. No coverage claimed. |
> | **M03-M9** | **STRUCTURAL, UNMOVED** | Stated so no `SO-` claims §0.6's inheritance clause as tested coverage here. **Not §9's ruling 9** — the row-index warning above governs. |
> | **M03-M10** | **LANDED, GREEN** | Discharged by its own carriers (M03-F2 and M03-B3), landed before this round; the exhaustive strobe set is asserted at both. |
>
> **The census, measured at both ends and AS A SET** (`RV-0071-VERDICT` §1):
> boundary-matched census **53 → 60**, naive **54 → 60** with the naive matcher's
> over-discharge list going `{M03-M1} → empty`, and `test/xgmii_rx_64/` inventory
> **56 → 56** with repository-wide **136 → 136** — **unmoved at both ends, which
> is the mechanical statement that no coverage was added.** Gained set = exactly
> `{M03-M1 … M03-M7}`, lost set = empty.
>
> **AND THE DIFF WRITES NO EXPRESSION — measured from the primary source, not
> argued.** A comment-and-literal-stripping skeleton of all fourteen `.ml` files
> under `test/xgmii_rx_64/` is **identical** at both ends, while the raw diffs of
> the four touched files are non-empty — so every textual difference lies inside a
> comment or a literal. **The instrument was scored before it was believed**:
> changing one expression constant in a landing file makes the skeleton diff fire;
> changing one comment word does not.
>
> **What this does NOT buy, and the ordering matters.** (1) **A binding makes a
> title tell the truth the day its carrier landed; it does not make a round of
> coverage.** No `SO-` may read the +7 as seven new attacks. (2) **Zero of the
> seven are X-1(ii)-gated**, stated per row — the expected values are strobe
> **names** and a **pinned cycle**, both §9's own words, never model outcomes;
> this scored a standing prediction of mine **wrong against itself** and the flip
> condition is recorded. (3) **OBSERVATION M-O1 is carried to the campaign, not
> paid here**: M03-M2's anti-vacuity ground is thinner than M03-M3's — M3 has
> sixteen independent cases and M4 two, while **M2 has one stimulus at two lanes**
> over a single deterministic 1518-octet prefix, so an accidental residue match at
> M2 is a 2⁻³² event that is nonetheless *fixed* rather than random. **A bench
> cannot settle it and the mutation campaign can**: seed *"run the residue
> comparison at the truncation point"* and observe whether M03-G1 reddens while
> M03-E1 and M03-H1 kill it. **Carrier: family M's / family G's campaign packet.**
> (4) **Family M is unscored**, and its campaign has a shape that must be
> pre-recorded: **every M row's assertion IS a carrier's assertion**, so a seeded
> class that kills a carrier kills its M row *by construction*, and **a scorecard
> must not report that as two kills.**

### 4.N Questions returned by rtl_lead — WO-0024 Return log §6

These three rows exist because rtl_lead declared readings rather than leaving
them to be discovered (WO-0024 Return log §6, items 2–4). The **expected
observable in each row is derived from SPEC-M03's text**, independently of the
answer rtl_lead gave; where the text does not decide, the row is `RULING` and is
not asserted until the architect rules. That is the C-12 precedent, applied
before a bench exists rather than after one has been written against the wrong
reading.

| Row | Attacks | Stimulus | Observable | Kills | Status |
|---|---|---|---|---|---|
| **M03-N1** | §9's closure list, REQ-113, REQ-105 | Two closure characters in one input word where the **second arrives after the frame is already closed** and no frame is open: `/T/` in lane 0 and `/E/` in lane 5 | The `/T/` closes the frame normally (REQ-106, FCS checked); the `/E/` finds **no open frame** and produces nothing and pulses nothing (§9's third row, C-12) | A design evaluating every control lane of a word against the state the word *started* in | ASSERT |
| **M03-N2** | §6.1's "more than one event in one input word" paragraph and its cycle table, §9's closure-list clause (a) and §9's repaired "Strobe cycle, pinned" rule — all at `06c1eba`; REQ-102, REQ-107, REQ-105, REQ-110, REQ-101 | Two closure characters in one input word **W** where the second falls **inside the new frame's preamble**: `/S/` in lane 0 or lane 4 of W, and `/T/` (or `/E/`) in a higher lane of the same W. **Six sub-cases, not four** — the discriminators are the *aborting* start character's lane, the **aborted frame's own** start lane (it enters through §7's L) and whether the aborted frame delivered an octet; the table below this table enumerates them and each must be driven | **Reading (i) RULED (WO-0029 §3a), ENDORSED on a second independent ground (REQ-101, below), and now fully pinned.** The `/S/` aborts the open frame (one `error_start_without_terminate`, `tuser`[0] = 1 on its `tlast` where it emitted one, no FCS removed) and the `/T/`/`/E/` closes the frame that same `/S/` opened with zero delivered octets — no output word, one `error_runt` (REQ-107) or `error_bad_frame` (REQ-105). **Cycles, from SPEC-M03 §6.1's table**: the new frame's report is **W + 2** always; the aborted frame's is **W + 1** except when the aborting `/S/` is in lane 4 *and* the aborted frame began at lane 0, where it is **W + 2**; a zero-delivered aborted frame is **W + 2** at both lanes. So the two reports coincide in **three of the six** combinations, always under **different** strobe names — §6.3 item 8, which excludes only a same-name coincidence, has **no instance** here. **Both cycles are gap-invariant** — **the GROUND for that is REPAIRED 2026-08-07 (`J-dv_lead-0085`) and the NAMED WORD is RE-BASED 2026-08-07 (`J-dv_lead-0087`, under the D(m) re-ruling at `1f3c04c` countersigned at `J-dv_lead-0086`)**: each is pinned relative to a **named input word**, and that word is **W in every row of the table — the two whose octets lie in the word before W included**, because *"an aborted frame's last word can be proven last by nothing except the character that aborted it, so D for that report is W and the offset is the row's own"* (§6.1 at `1f3c04c`); on an injected line each is read at **W's** own injected position, which is SPEC-M03 §6.1's consequence-1 scope note and requirements.md §0.5's *deciding input word*. *The parenthesis this replaces read "(W itself, or the word carrying the aborted frame's last octet)" — the second alternative is the superseded D and is withdrawn.* The former ground — §7's per-octet constant, this plan's own Route 2 at §4.N — is **withdrawn as false** (`SCR-M03-I4`: that constant does not survive injection at either start lane). **The conclusion is unaffected, because it never rested on the constant**: these cycles are causal and keyed to input words, which is exactly what makes them survive. **Idle injection before W moves BOTH reports TOGETHER**, by the same amount, because both are read at W: rows 1 and 2 report at **W + 1** against the new frame's **W + 2** on every stimulus, gapped or gapless, so the coincidence column is unchanged at **every** `k` and is injection-proof **on the offsets alone**. The row may be run inside the M03-I4 wrapper. *The clause this replaces said injection before W moves the two lane-0-`/S/` reports **earlier**, further from the new frame's and never onto it; it read those rows against the word carrying the aborted frame's last octet and is **withdrawn in terms** at `1f3c04c`. The conclusion it supported is unchanged — the six rows, the three coincidences and §6.3 item 8's having no instance here all stand — and now rests on the offsets rather than on a direction of motion.* **Strobe set, exhaustive** (§9 ruling 9 at `1fe71ca`): on the zero-delivered sub-cases the two reports are **exactly** `error_start_without_terminate` (the aborted frame — no FCS check, §9 ruling 4) and `error_runt` (the new frame — sub-5 class, ruling 9), **and nothing else**; `error_bad_fcs` pulses for neither, which is what turns this row's strobe assertion from a lower bound into a count | Reading (ii), which rtl_lead declared and the ruling rejected: killed by the presence of the second strobe at all. Beyond it, the six sub-cases kill a design that reports both frames on one fixed offset from W regardless of the aborted frame's start lane or delivered count — the sub-case pair (lane-4 `/S/`, lane-0-started A) against (lane-4 `/S/`, lane-4-started A) differ by one cycle on otherwise identical stimulus and no other row separates them. **QUALIFIED 2026-08-06 — four scoreable classes, four kills, 4/4** (`WO-0066-VERDICT` §§1, 4, 5 and 6, disposition 1 at each; campaign `WO-0066`, sealed at `WO-0066_family-bn-mutation-campaign-SEALED-predictions.md` before any diff existed and opened only after all six scorecards did; `J-dv_lead-0117`, recorded here `J-dv_lead-0118`). **The qualification is recorded in this cell and the Status cell stays `ASSERT`** — §1's status vocabulary is a closed set of six values, `QUALIFIED` is not one of them, and M03-I2's, M03-E5's and M03-F2's qualifications already sit in their Kills cells (`J-dv_lead-0109`'s divergence ruling, followed here rather than re-decided). **Per class, with what each one measured.** **IC-C — the coincidence serialised**: three units red, three predicted, zero outside, all three messages character-exact, at sub-cases 3, 6 (zero-delivered branch) and 4 (delivered branch); **and the three REQUIRED GREENS held** — sub-cases 1, 2 and 5, whose two reports are already a cycle apart, stayed green, so the class measured **the coincidence** and not reports in general, which is the only way its kill means anything. Raise sites `test_m03_n.ml:554` and `:614`, both step 8(b); `assert_monitors_clean` (`:643`) **never executed**, so the standing `Strobe_monitor` spoke nowhere — as at `WO-0063B`, and as §2 obligation 4's measured inventory predicts. **IC-B — the zero-delivered close mis-scored**: all six N cells red with the identical body and the derived `<n>` = **1**, character-exact; **scored on branch `R` alone**, because the auditor disclosed `D-B1 = R` and declared branch `W` unrenderable at this design, which the pre-run reading note's **disposition 8, VOID BY DISCLOSURE** puts outside the scorecard — the `W` cells are **not scored, contribute zero kills, and are findings in neither direction**, and none of that is DV coverage. At the four delivering sub-cases the raise is the **pulse** message, so frame A's `tlast` cycle, `tkeep`, `tlast` bit and `tuser`[0] all passed and the rendering is report-path-only by measurement. **IC-E — the runt check on the abort path**: killed at **sub-case 2 alone** (`observed 3` against a conformant 2), which was the class's whole `R!` set. **IC-A — the in-word abort**: sub-cases 4 and 5 message-exact with the word count sealed `< 1` and observed **0**; sub-case 6 red on the **other arm** of the same check (two pulses under one name, not one pulse), a message **MISS** recorded as `FINDING WO-0066-5` against the seal and deliberately **not** absorbed into the kill. Bound 7's disposition is at **§4.H bound 2**, which carries the score, the state split and the correction; it is not restated here. **THE HONEST SCOPE, AND IT NARROWS WHAT THIS ROW UNIQUELY BUYS — `FINDING WO-0066-6`.** `M03-H1` (lane 4) and `M03-H2` (both lanes) reddened under IC-A where the seal predicted green, and reading their stimuli established why: both drive a **lane-4 in-word abort of a frame already open on entry**, and both have been in this bench since `WO-0057`. **So sub-cases 4 and 5 are NOT the first detectors of that conjunction, this bench was NOT blind to it, and no packet may imply otherwise.** **What remains genuinely this row's own is (i) the `Preamble`-state instance — sub-case 6, where `M03-H1`/`H2` abort frames in `Frame` state — and (ii) the coincidence geometry IC-C measures, which exists nowhere else in this bench.** That is a smaller claim than this row carried before the campaign and it is the measured one. **FIVE MUST-STAY-GREEN violations across the two classes, at four distinct units, are against the SEAL and not against the bench** — **three under IC-E** (`M03-N2` sub-cases 1 and 5, and `M03-H2`: `FINDING WO-0066-3`, a sealed `G` derived from a sub-five runt floor where requirements.md §12's predicate is **fewer than 64 octets**) and **two under IC-A** (`M03-H1` and `M03-H2`: `FINDING WO-0066-6`), with `M03-H2` violated under both classes from the same root cause. Every unit behaved correctly, **including every one that reddened where the seal said it would not**, and nothing in `test/**` is owed by this result. **TRAP T8's SINGLE OBSERVABILITY IS PERMANENT, AND IT IS AN INTERFACE PROPERTY, NOT A BENCH DEFECT** (`WO-0066-VERDICT` §5.2 on the pre-run reading note's ruling 1(c), adopted from the auditor's ground over the seal's own). The unit's **T8** — *A's strobe set on the delivered sub-cases is `error_start_without_terminate` ALONE, even where A delivers fewer than five octets* — is **asserted at two members (sub-cases 2 and 4) and observable at one (sub-case 2)**. At sub-case 4 the mutant's output is **bit-identical to a conformant design's**, because §0.6 counts **high cycles, never rising edges** and frame A's added `error_runt` lands on the cycle frame B's genuine one already occupies: an **equivalent mutant**, not an undetected one, and **no bench change reaches it** — the limit is in the strobe interface, which reports ~~**presence per cycle and not multiplicity**~~ **a LEVEL per cycle** (the strike and the replacement are 2026-08-09, `J-dv_lead-0132`; see the ruling paragraph below). **Two consequences bind every later packet.** (1) **No `SO-`, campaign or scorecard may claim T8 is instrumented at two members** on the strength of IC-E's kill, or read sub-case 4's green as a blind instrument. (2) ~~Whether M03's strobe contract should carry a multiplicity signal is an **architect question**, raised as one and **not** as a `BUG-`~~ — **RAISED AND ANSWERED. `WO-0069` item 2, ruled by architect_docs_lead 2026-08-09 (`J-architect_docs_lead-0031`, landed at `b6ef1cb`; accepted as landed `J-dv_lead-0126`; transcribed here `J-dv_lead-0132`), as a non-normative note appended to requirements.md §0.6's counting convention.** **The ruling, in the three clauses this cell depends on.** *(α) The rule is read on EVENTS, not on conditions, and this cell's operating assumption of "presence" is CORRECTED IN ITS SUBJECT and CONFIRMED IN ITS CONSEQUENCE*: presence is right about the **port** — one bit, one level per cycle — and wrong about the **contract**, which is per event. *(β) The obligation each reported event creates is a LEVEL, not an increment*: the event obliges the signal high on the one cycle its module specification pins, so **two same-name events pinned to one cycle are BOTH discharged by that single high cycle and the module has conformed**. *(γ) C-23's high-cycle convention is the observer's inverse, and it is exact only while no two same-name events share a cycle*: on a shared cycle it **under-counts**, and **the shortfall is in the DECODING, never in the design**. **What changes for this cell and what does not.** The equivalent-mutant conclusion at sub-case 4 is **unchanged** — bit-identity is the criterion under either reading — and consequence (1) above stands unaltered. What changes is **what a packet may say**: not *"the design is conformant here because presence held"*, but *"both events' obligations were discharged by the level, and no instrument at this port can recover the count"*. **NO MULTIPLICITY SIGNAL IS OWED**, and the ground is (β) rather than cost: the contract is already discharged by the level, so a count port buys **nothing for conformance** and only fault observability. **The question is closed and no `BUG-` was ever owed.** The `Strobe multiplicity` paragraph was **never the governing rule** for this case in any event — it is scoped to *one frame* in its own words, and this cell's case is **two frames, one name, one cycle**. This fact is stated **once**, here, where the row's coverage claims are read; the Observable cell's exhaustive strobe set is T8's spec-side origin and is not amended for it | ASSERT |
| **M03-N3** | REQ-016, REQ-102's third sentence, REQ-105, §6.1's preamble-position paragraph and §10's REQ-016 hook (both `541ea43`) | An idle word placed **between a frame's start character and its first octet** | **The stimulus is decided, not out of the specified space** — the architect declined dv's requested §6.3 sentence and gave something stronger (WO-0029 §3b), and the correction is accepted: an idle character in a preamble position is "any other control character" in REQ-102's third sentence, so it is routed to **REQ-105** and ends the frame with one `error_bad_frame` and no output word (§9's third row). The constraint that is actually owed binds the **wrapper**, and §6.1 and §10's REQ-016 hook now carry it: **the idle-injection wrapper of M03-I4 SHALL NOT inject between a start character and the frame's first octet.** The row therefore stays **NO-STIMULUS for the REQ-016 family**, now with a spec citation instead of an inference; the assertable case it makes available is REQ-105's, commissioned by §10's REQ-102 hook and carried at **M03-B2**. **Caveat carried as C-45**: at a **lane-0** start the whole preamble lies inside the start word (§6.1 says so in the same paragraph), so an injected idle word at the first inter-word boundary occupies **no preamble position** and is §6.2's ordinary C-14.4 hold — the prohibition is over-broad there and its stated ground does not hold at that lane. The constraint is honoured as written until the scope lands | A wrapper that injects uniformly across the whole frame including the preamble: at a **lane-4** start it puts idle characters in preamble positions 4 … 7 and measures REQ-105's abort while claiming to measure REQ-016's tolerance — a failure that is the bench's, not the design's | NO-STIMULUS |
| **M03-N4** | REQ-810 (revised `541ea43`), REQ-803, REQ-110, §4.3, §6.2's three rows, §9's closure-list clause (b), §10's REQ-110 and REQ-802/REQ-810 hooks, **ADR-0014** | `cfg_rx_enable` goes 0 **mid-frame**, and a new `/S/` (REQ-110's condition) arrives while it is 0, at least one cycle away from the change (§6.3 item 7, C-14.5) | **Reading (i) RULED (ADR-0014) and ENDORSED** — an enable gates the *admission* of a frame and nothing else. The commissioned observable, taken from §10's REQ-802/REQ-810 hook and not from the row's own prose: the in-flight frame is **aborted at the octet before the `/S/`** with `tuser`[0] = 1 on its `tlast` word (or **no output word at all** where it had delivered none — **that parenthesised branch has NO INSTANCE at this row; the finding is at the end of this cell and it is against my own row, not against the hook's wording**), **exactly one** `error_start_without_terminate`, **no** output word for the frame that `/S/` would have begun, and the next frame received normally after the enable returns to 1. The ruling is decided **against the two requirements**, not against the implementation — and it is worth recording that the same activation rejected the same agent's declared reading on M03-N2. **Held at RULING for one reason only, and it is not this row's**: SPEC-M03's revisions are WITHHELD at WO-0030 on the M03-N2 defects, so the §4.3/§6.2/§9 text this row derives from is not yet in force. **Converted at `06c1eba` exactly as pre-committed at WO-0030, with no change to the observable**: the R1/R2 repair touches neither §4.3, §6.2, §9's clause (b) nor §10's hooks, which `git diff 541ea43 06c1eba -- docs/specs/` confirms in three hunks. **THE PARENTHESISED ZERO-DELIVERED BRANCH HAS NO INSTANCE AT THIS ROW — a finding against my own row, derived 2026-08-07 while authoring the packet that commissions the bench (`WO-0068` §5, `J-dv_lead-0121`) and landed here 2026-08-09 (`J-dv_lead-0124`).** The parenthetical is **quoted from SPEC-M03 §10's REQ-802/REQ-810 hook and is kept**, because the hook's text is the architect's and not this plan's to edit; what changes is the claim this row may make. **THE DERIVATION, and it is arithmetic on this row's own constraints.** Frame **A** must be *admitted*, so the enable is **1** on A's own start cycle. A must deliver **zero** octets, so the aborting `/S/` lands **at or before A's first octet** (REQ-110's own zero-delivered clause) — inside the nine octet times `[first_start, first_start + 8]`, a span **beginning at A's own start character**. Therefore the aborting word **W** is A's **start word or the word immediately after it**. The enable must go **1 → 0 strictly between** A's start cycle and W — and **§6.3 item 7 (C-14.5) forbids driving a change on any start character's own cycle**, which A's start cycle is. **There is no admissible change cycle, at either start lane.** **Two escape routes are closed by the specification itself, not by convention**: `first_start` is **8 or 12** under §0.3's lane mapping, and enlarging it moves A's start cycle and W **together**, so the span never opens; and inserting an idle word between A's start character and its first octet is exactly what **M03-N3** and §10's REQ-016 hook forbid (*"the wrapper SHALL NOT inject between a frame's start character and its first octet"*). **DISPOSITION — the precedent's, at its fifth instance.** This is the **M03-D3 / M03-F2 / M03-I2 / M03-J2** unachievable-observable shape, found the same way each of those was. The **row stays ASSERT** on its delivering branch, which is REQ-110's own abort geometry conjoined with the enable and is what ADR-0014 was written to decide; §1's status vocabulary is a closed set of six values and has none for *a row one of whose observable branches has no stimulus*, so the finding is recorded **in the cell the defect lives in** — the **Observable** here, because what has no instance is a branch of the observable and not the kill, exactly as M03-J2's finding one family up sits in that row's **Kills** cell for the same reason. **WHAT IS FORBIDDEN, in terms**: no bench may assert the zero-delivered branch at this row, no comment may claim this row covers it, and **no `SO-`, campaign or verdict may read this row as coverage of a zero-delivered REQ-110 abort**. **WHERE THAT GEOMETRY *IS* COVERED: M03-N2 sub-cases 3 and 6**, under `cfg_rx_enable` = 1 — landed, green and campaign-scored. **The conjunction of *zero delivered* with *enable = 0* is a fact about the stimulus space, not a bench gap any bench could close**, which is why it is recorded here and not carried as a `GAP` row (§1 reserves `GAP` for an attack this plan wants and *cannot mount*; this is an observable that has no legal stimulus to mount). **The spec-side half of the same defect is the C-41 family** — a verification column commissioning an observable the same specification's §6.3 item 7 excludes — and it is raised with architect_docs_lead as a **non-blocking** change request in the spec queue drafted in the same round as this edit — `agents/handoffs/WO-0069_spec-queue-3-m03-hook-and-strobe-multiplicity.md`, where **`0069` is a placeholder id the orchestrator allocates at first commit** (PROTOCOL §3) — with the repair proposed in the form §10's own **REQ-014** hook already uses (*"stated so that no sign-off packet claims REQ-014 whole at M03"*). **No row of this plan moves on its resolution in either direction** | Reading (ii): the open frame is carried across a character §6.1 routes to REQ-110 and its octet count absorbs a refused frame's octets, reaching M06 with a bad FCS or (past 1518) an oversize truncation. Also a design that gates the datapath rather than admission, which suppresses the in-flight frame's own remaining words and its report — the silent-discard hole REQ-810's next clause disclaims | ASSERT |

**M03-N2's report cycles — derived here at WO-0030, repaired into SPEC-M03 §6.1
at `06c1eba`, and re-derived by a second route at WO-0031.** The table below is
the bench's, and it is now also the specification's: §6.1's landed table matches
it row for row. Let **W** be the input word carrying the aborting `/S/`, **S**
the aborted frame **A**'s own start word. A's last delivered octet is the octet
immediately before the `/S/` (REQ-110): lane 7 of W − 1 for a lane-0 `/S/`, lane
3 of W itself for a lane-4 one, since a lane-4 start leaves lanes 0 … 3 of its
word to the aborted frame. Frame **B** — opened by that `/S/` and closed by the
`/T/` or `/E/` in a higher lane of the same W — delivers nothing, so §9's
repaired rule pins its report **two cycles after W**, always.

Two routes give the same six rows and the second is the one to keep:

- *Route 1, WO-0030's* — §6.1's gapless "output word m is emitted on cycle
  **m + 3** counted from the word carrying the start character". Correct, and
  **scoped to a gapless stimulus**, so it cannot be quoted inside the M03-I4
  wrapper.
- *Route 2, `06c1eba`'s and the one this plan now uses* — §7's **per-octet
  constant**: an output octet at lane k of input word U leaves on cycle
  `U + ⌊(k + L)/8⌋`, with L = 16 at a lane-0 start and 12 at a lane-4 one. That
  gives 2 for every lane when L = 16, and 1 for lanes 0 … 3 / 2 for lanes 4 … 7
  when L = 12 — which is exactly why **the aborted frame's own start lane is a
  discriminator**. **Its gap-invariance clause is WITHDRAWN, 2026-08-07
  (`J-dv_lead-0085`)**: both routes are stated on a **gapless** stimulus, and the
  per-octet constant is **not** gap-invariant — `SCR-M03-I4`, ruled at
  requirements.md §0.5 and SPEC-M03 §6.1 (`a77017c`). **The table nonetheless
  holds under idle injection, on the ground §6.1's scope note gives — and the
  named word is `W`, RE-BASED 2026-08-07 (`J-dv_lead-0087`) under the D(m)
  re-ruling at `1f3c04c` countersigned at `J-dv_lead-0086`**: **every** row of
  the table is read at **W's** own injected position, the two rows whose octets
  lie in the word before W included, because an aborted frame's last word can be
  proven last by nothing except the character that aborted it. *The clause this
  replaces read each cycle at the **octet's own** input word `U`; that is the
  superseded D and it is withdrawn.* **Route 2's formula is untouched and so is
  every number it produces**: `U + ⌊(k + L)/8⌋` is a **gapless** derivation of
  the *offset*, and gapless the two readings coincide — a lane-0 `/S/` leaves the
  aborted frame's last octet at lane 7 of `W − 1`, so `U + 2 = W + 1`, which is
  W's own `+ 1` — so **the six rows and the three coincidences do not move**.
  What is re-based is only *which word the offset is read from on an injected
  line*. Route 2 is still the one to keep — it is what makes the aborted frame's
  own start lane a discriminator, which `m + 3` does not — but its ground for
  surviving injection is the named input word W and not the constant. I verified
  both routes agree on all six rows gapless, and that re-basing to W changes
  none of them.

| `/S/` lane | A's start lane | A delivered | A's `error_start_without_terminate` | B's `error_runt` | Same cycle? |
|---|---|---|---|---|---|
| 0 | 0 | ≥ 1 octet | W + 1 | W + 2 | no |
| 0 | 4 | ≥ 1 octet | W + 1 | W + 2 | no |
| 0 | either | 0 octets | W + 2 | W + 2 | **yes** |
| **4** | **0** | **≥ 1 octet** | **W + 2** | **W + 2** | **yes** |
| 4 | 4 | ≥ 1 octet | W + 1 | W + 2 | no |
| 4 | either | 0 octets | W + 2 | W + 2 | **yes** |

1. **Defect M03-R1 — a false universal in text a bench is told it may rely on.**
   §6.1's new consequence 1 ends "…and **only where it delivered no octet** do
   the two fall together, on different strobe names", under the heading "Two
   consequences a bench may rely on". Row 4 of the table above falsifies it.
   **Minimal witness**: A opens with `/S/` in lane 0 of word W − 1; word W
   carries A's octets 0 … 3 in lanes 0 … 3, a `/S/` in lane 4 and a `/T/` in
   lane 6. A delivers **four** octets, so its `tlast` word (`tkeep` = 0x0F,
   `tuser`[0] = 1) is output word 0 and leaves on (W − 1) + 3 = **W + 2**, and
   B's `error_runt` is also on **W + 2**. A bench following the sentence asserts
   the two are one cycle apart and fails a conformant M03. The parenthetical
   that precedes it — "the input word before a lane-0 start character" — is
   correct and is exactly the scope the closing clause drops.
2. **Defect M03-R2 — §9 pins B's strobe to two different cycles in one
   sentence.** §9's "Strobe cycle, pinned" reads: "For a frame that produces no
   output word, it pulses **two cycles after the input word carrying the
   character that ended the frame** — *the cycle on which that frame's `tlast`
   word would have been emitted*." For any frame whose ending character lies in
   its **own start word**, the two halves disagree by one cycle: the rule gives
   W + 2, while §6.1's m + 3 puts that frame's output word 0 at start word + 3 =
   **W + 3**. That class was a single instance before this ruling — REQ-110's
   own commissioned "`/S/` in lane 4 of a word whose lane 0 carried a `/S/`",
   frozen since batch A and **missed by me at `J-dv_lead-0005`** — and the
   ruling makes it a family. It is **already load-bearing on committed ASSERT
   rows**: M03-B2 drives `/E/` in lane 3 of a lane-0 start word *and* in lane 7
   of a lane-4 start word — both inside the frame's own start word — and pins
   the strobe "on the cycle two after the input word carrying the `/E/`", i.e.
   it has already chosen W + 2, resting on the half of §9's sentence that the
   other half contradicts; M03-B3 is the same shape and says only "at the
   pinned cycle", which §9 does not uniquely supply for it. B here is the third
   instance. The repair of R1 has to state cycles, and no cycle can be stated
   for B — or defended for B2 — while §9 says both.

Neither defect touches M03-N1, M03-N3 or M03-N4, and neither touches the
ADR-0014 material; the repair surface is two sentences.

**Both repaired at `06c1eba`, verified, and re-countersigned** (`J-dv_lead-0016`,
WO-0031). R1: the false clause is replaced by the six-row table above, derived in
the specification from route 2, carrying this row's minimal witness and stating
that the coinciding strobes always have different names. R2: the gloss is
**withdrawn**, on a ground stronger than "one half is normative" — the gloss
*cannot* be a rule, because a frame delivering no octet has no octet for §7's
constant to delay and the only thing that made the phrase look defined (`m + 3`)
is gapless-qualified while §10 commissions injection at 0, 1 and 7 cycles, so
reading it as the rule would leave a strobe cycle unpinned on a commissioned
stimulus. **M03-B2 and M03-B3 are vindicated, not moved**: W + 2 is now the only
reading of §9 for a frame ended inside its own start word.

Three things the repair added that this plan adopts rather than re-derives, each
checked here:

1. **The disagreement ran the other way too, in exactly one case** the WO-0030
   analysis did not reach: a **lane-4**-started frame whose `/T/` is in lane 0 of
   the *second* word after its start word — four octets received, none delivered,
   §9's sixth row — where the rule gives S + 4 and `m + 3` gives S + 3. I
   enumerated the no-output-word frames to confirm it is the only one: the ending
   character lies in S (differ, `m + 3` later), in S + 1 (agree), or, only there,
   in S + 2; nothing reaches S + 3, because fewer than five delivered octets puts
   every terminate character at or before lane 0 of S + 2 and REQ-105's and
   REQ-110's zero-delivered clauses reach only S + 1.
2. **That case sits at the far edge of requirements.md §0.6's window and inside
   it** — the frame's last octet is at lane 7 of S + 1 and ΔC = 3, so §0.6's
   bound is S + 4 and the report is on S + 4. Re-derived; it holds. **M03-I2's
   drain assertion is unaffected** (it is scoped to a frame that ends normally).
3. **The coincidence column is injection-proof.** Only the two lane-0-`/S/` rows
   depend on the word *before* W, so injecting an idle word there moves that
   report earlier and widens the separation; the coinciding rows are pinned to W
   itself or to the closing character's word and move with it. No injection turns
   a `no` into a `yes` or the reverse, so M03-N2 may be driven inside the M03-I4
   wrapper. **This is a different injection point from C-45's** (which is the
   first inter-word boundary after a *lane-0 start word*), so C-45 is untouched by
   the repair and carries unchanged.
4. **A fourth item the architect offered and I accept, rewidened — ledger
   C-47.** §9's rows 8 and 9 classify a REQ-110 abort by "≥ 1 octet already
   delivered" and "still inside its own preamble", and a frame that is **past its
   eighth preamble position with zero delivered octets** — the `/S/` landing
   exactly on the frame's first octet, lane 0 of S + 1 at a lane-0 start, lane 4
   of S + 1 at a lane-4 one — satisfies neither literally. The architect framed it
   as a hairline between two rows; it is sharper than that, and it has a model
   **in the same table**: §9's **row 3** states the REQ-105 sibling
   *extensionally* — "at or before the frame's first octet (including in a
   preamble position)" — which is exactly the phrase rows 8/9 want, and the two
   phrasings differ by precisely one octet time at each start lane. A **second
   site** the offer did not name: requirements.md **REQ-110**'s zero-delivered
   clause carries the same narrow gloss ("while the aborted frame is still inside
   its own eight preamble octets"), though its *governing* words ("Where the new
   start character leaves the aborted frame zero delivered octets") are
   extensional and therefore decide the outcome. **Nothing is ambiguous and no row
   of this plan is at risk** — REQ-110's governing clause plus §0.7 force no
   output word and one strobe for that frame, which is what M03-N2's rows 3 and 6
   and M03-B4 assert. What is missing is the row that says so. One phrase, and it
   is the R2 shape once more: a correct rule with a gloss narrower than itself.

**One correction against myself, and it is why the row says six and not four**
(`J-dv_lead-0016`). The table above has always been right, and the landed
specification follows it. My **prose** summary of it at WO-0030 — "three of the
four sub-cases", and "one cycle apart only for a lane-0 `/S/`" — collapsed a
three-axis classification onto two by dropping the aborted frame's **own** start
lane, and then quantified over the collapse: it reads row 4 (lane-4 `/S/`,
lane-0-started A, coincides) as the whole of the lane-4-with-delivery cell and
silently absorbs row 5 (lane-4 `/S/`, **lane-4**-started A, does **not**
coincide, W + 1 against W + 2). Of the **six** combinations, three coincide. The
architect flagged it; I concur. It is the same failure mode as C-44 — a
generalisation asserted over a table that did not support it — committed by me
twice in two activations, once about killability and once about my own arithmetic,
and it is the reason this plan now states the axes before the count.

**M03-N2 HAS NO UNIT IN THIS BENCH, and the plan says it rather than letting a
coverage map imply otherwise** (measured `J-dv_lead-0106`, commissioned at
`WO-0063B-VERDICT` §9 item 1.4, ruled and transcribed here `J-dv_lead-0109`).
`grep -rn "M03-N2" test/ --include=*.ml --include=*.mli` returns **three** hits,
all in `test/xgmii/` library files (`injection.mli:25`, `idle_injection.mli:67`,
`test_injection.ml:281`) and **none a bench unit**; the row is named **25 lines /
26 occurrences at `88413b9`** in this plan — **every name-count in this
paragraph carries the SHA it was measured at, because the figure it replaced did
not and that is exactly how it went wrong** — in **zero** `%expect_test` titles
and in **zero** `Strobe_monitor` registrations. **The two measurements are independent** — a
registration sweep and a titled-unit sweep, run for different purposes — and they
agree, which is why this is recorded as a fact and not as an impression.

> **The name-count is CORRECTED, 2026-08-05, against its author.** This
> paragraph said **17**, and 17 was measured **before the same round's own edits
> added this closing note and §6's two entries — a count taken at one state and
> published about another**. Re-measured at `88413b9` by `RV-0065`, twice, from
> the tree: `grep -c "M03-N2" test/attack_plans/AP-xgmii_rx_64.md` = **25**
> lines, `grep -o … | wc -l` = **26** occurrences. The figures above the count
> are unaffected (they are about `test/`, not about this file). **Cite the
> measurement, never the 17.** Found and reported by tb_writer at `WO-0065` §1;
> the correction is dv_lead's and lands here (`J-dv_lead-0112`).
>
> **And the same trap, one turn later, caught in my own edit before it
> committed.** The commit landing this correction **itself adds names** — this
> block, the status block below, and §6's two re-groundings — so 25/26 is the
> count at `88413b9` and **not** the count of the file a reader now holds.
> Measured after these edits: **29 lines / 33 occurrences**. The figure that
> matters is always the one with a SHA beside it; a name-count in a document
> about itself is stale the moment the document is edited, which is the whole
> lesson of the 17 and is why this paragraph now states two figures and two
> states instead of one figure and none.

> **STATUS UPDATE, 2026-08-05 — a unit now EXISTS and is RED, so this note and
> §6's two no-coverage marks STAND** (`RV-0065-VERDICT`, BOUNCE;
> `J-dv_lead-0112`). `test/xgmii_rx_64/test_m03_n.ml` landed at `88413b9` with
> **six** titled sub-cases, so the heading's *"no unit"* is superseded on its
> face — but **three of the six raise** in CI `build` run `30961544649`
> (sub-cases 3 and 6 on `Arrival.check`'s five-octet schedule rule, sub-case 4
> on a guard that asserts its two reports do **not** coincide where this plan's
> own §4.N table says they do). **A red unit has not landed.** Every prohibition
> below therefore remains in force verbatim: **no `SO-` may cite M03-N2 as
> coverage of REQ-102 or REQ-110, and no campaign may place it in a
> denominator**, until the respawned round is green and a verdict says so.
>
> > **STRUCK, 2026-08-05 — the respawned round is green and this is the verdict
> > that says so** (`RV-0065B-VERDICT`, ACCEPT; `J-dv_lead-0113`). The revision
> > landed at **`eb1e06a`** and CI `build` run **`30963617198`** (job
> > `92172708172`) is **success** at both gating steps: `dune runtest`, and
> > `git add -A; git diff --cached --exit-code` — so there is no `.corrected`
> > file and no unpromoted drift, and **all six sub-cases are silent against a
> > conforming design**. The eight members that were already green stayed green;
> > **11 of 11**. This heading's *"HAS NO UNIT"* is superseded, the
> > *"benched and not green"* re-grounding is discharged, and **both
> > prohibitions are LIFTED**: an `SO-` may cite M03-N2 as coverage of REQ-102
> > and REQ-110, and a campaign may place its six sub-cases in a denominator —
> > which the family-B/N campaign does, as **the first legitimate N2
> > denominator**. The paragraph and the two blocks above are kept, not deleted,
> > because the argument that retired them is only readable against them.
> >
> > **The effective discharge count, which is the figure this note existed to
> > protect.** The titled-unit method counts titles, not passes; at `88413b9`
> > it returned **43 titled / 42 effective**. At `eb1e06a` the census re-measures
> > (boundary-matched, by `RV-0065B-VERDICT` §5, at this tree) to the same
> > **43** — 48 titles under `test/xgmii_rx_64/`, 43 distinct plan rows named,
> > − `M03-A4` (NO-ASSERT), + `M03-F5` (by citation) — and the run id above is
> > what makes it **effective**. **43 of 62, titled and effective, which now
> > coincide.** Outstanding falls from twenty to **nineteen**; the whole of the
> > +1 is M03-N2. **A naive substring match returns 44** by discharging
> > `M03-M1` inside `M03-M10`'s title; the trailing-digit boundary is not
> > optional and is commissioned into `tools/dv_checks.sh` with the campaign
> > packet.
> **And the census caveat this exposed, recorded where the next census will be
> run**: the titled-unit method counts **titles, not passes**. Measured at
> `88413b9` it returns **43** discharged of 62 ASSERT rows (parent `88413b9^`:
> **42**), and the whole of the +1 is M03-N2's six titles — a figure that is
> arithmetically right and **not yet earned**. The **effective** discharge count
> at this SHA is **42**.

**What its absence costs, exactly.** (a) §6's **REQ-102** and **REQ-110** rows
name M03-N2; until a unit exists it contributes **no coverage to either**, and
those two entries now say so. (b) The class SPEC-M03 **§6.3 item 8** carves out
— *two frames reported on one cycle under the same strobe name*, the bound the
WO-0029 ruling placed on **DV** rather than on the module — is therefore
**untested**, and it is untested because **the row was never benched**, not
because the carve-out forbids the stimulus. (c) A cell at a non-existent unit is
**unscoreable in both directions**: a MUST-STAY-GREEN denominator containing
M03-N2 is simply wrong, and one did contain it until the phase-B seal was
measured instead of recalled.

> **This costing is DISCHARGED, 2026-08-05 (`RV-0065B-VERDICT`,
> `J-dv_lead-0113`), and one of its three limbs changes its GROUND rather than
> its truth.** (a) is paid: §6's two entries now read **DRIVEN**, green at
> `eb1e06a`. (c) is paid: the six sub-cases are scoreable in both directions and
> are the campaign's new material. **(b) remains true and its cause is now
> different, which matters more than the truth value.** SPEC-M03 **§6.3 item 8**
> — two frames reported on one cycle under the **same** strobe name — is still
> untested, but **no longer because the row was never benched**. The row is
> benched, at six sub-cases, and **three of them put both reports on one cycle**
> (3, 4 and 6, `coincides = true`) — under **different** names every time
> (`error_start_without_terminate` for A, `error_runt` for B). §6.3 item 8's
> class is untested because **the carve-out forbids the stimulus**: *"M03's
> response to such a word is deliberately unconstrained and DV SHALL NOT produce
> one."* That is a closed question, not a gap, and no `SO-` should carry it as
> an open coverage item. The file states this at its own T10 and claims no §6.3
> item 8 instance anywhere — verified line by line at `RV-0065B-VERDICT`.

**The routing, ruled here rather than left open.** This is **not** a
bench-capability item and **not** a row correction. The machinery exists and was
built with this class in mind: `test/xgmii/injection.mli` states that the
two-events-in-one-word cases — *"dv_lead's row M03-N2"* by name — are **ordinary**
for `Injection.outcomes`, each character evaluated at its own octet time, and
`At_preamble` placement is already driven by committed family-B members. And the
row's status is correct as **ASSERT**: it is spec-derived, ruled at `06c1eba`,
and its six sub-cases carry cycles from §6.1's landed table. What is missing is a
**bench round**, so M03-N2 is carried as an **outstanding ASSERT row** inside the
twenty the §9 count line leaves open — **not** converted to `GAP`, which §1
reserves for an attack that *cannot* be mounted, and this one can. **Until that
round lands, no `SO-` packet may cite M03-N2 as coverage of REQ-102 or REQ-110,
and no campaign may place it in a denominator.** It is commissioned into the next
family round beside M03-B4's member (b) and M03-B2's `/I/` members.

> **FAMILY N — LANDED STATUS, 2026-08-09 (`J-dv_lead-0124`). Every status word
> below travels with the SHA and the CI run id it was read at, because §0.1
> binds this paragraph and because a census figure quoted without a CI reading
> is a title count wearing a pass's clothes (`RV-0068B-VERDICT` §7).**
>
> | Row | Status | The evidence, not the adjective |
> |---|---|---|
> | **M03-N1** | **LANDED, GREEN** | Two members — a lane-0 start and a lane-4 start — in **one** unit in `test/xgmii_rx_64/test_m03_n.ml`; green at **`2dbd39b`**, CI `build` run **`30988038809`**. |
> | **M03-N2** | **LANDED, GREEN, CAMPAIGN-SCORED** | Six sub-cases through one shared runner; green at `eb1e06a` (run `30963617198`) and again at `2dbd39b` (run `30988038809`), and **QUALIFIED on four classes 4/4** by the family-B/N campaign — recorded in its own Kills cell with its scope unabridged. |
> | **M03-N3** | **NO-STIMULUS, CITED** | Not a bench and never will be one: the constraint carries a spec citation (SPEC-M03 §6.1 and §10's REQ-016 hook at `541ea43`) and is built into **X-4**'s wrapper. **No coverage is claimed for it anywhere.** |
> | **M03-N4** | **LANDED, GREEN — and run to completion for the first time at this commit** | Both members, every assertion downstream of the first raise, at **`2dbd39b`**, run **`30988038809`**. At the two predecessor commits the unit existed and **raised**, so nothing after the raise had ever executed; the green is the whole unit executing, both members, and not a badge. |
>
> **The census, measured rather than recalled — `bash tools/dv_checks.sh` at
> `2dbd39b`, run by me and independently by CI inside the same build
> `30988038809`, both reporting the identical figures**: bench inventory **54**
> under `test/xgmii_rx_64/`, **134** repository-wide; row-discharge census
> **48** under the trailing-digit **boundary** matcher (the one the tool tells
> you to quote); declared adjustments **−1** (`M03-A4`, a NO-ASSERT row named in
> a title) and **+1** (`M03-F5`, discharged by citation), **net zero**. Against
> this plan's own ASSERT denominator of **62**: **48 of 62**, up from 46 at
> `e4df986`, and **the whole of the +2 is M03-N1 and M03-N4**. **14 ASSERT rows
> outstanding — K1, K2, L1–L5, M1–M7** — and **48 + 14 = 62**, which is the
> check that the delta is the delta it is thought to be rather than two errors
> agreeing.
>
> **The instrument's general property is unchanged and is restated rather than
> allowed to expire with this instance: the census counts TITLES, and a title is
> not a pass.** What closed here is the divergence *for these rows* — at this
> commit the title and the pass are the same thing — not the property. **Quote
> the figure with a CI run id beside it or do not quote it.**
>
> **Three things this green does not buy, stated because silence would let them
> be assumed.** (1) **Family J is not mutation-scored**, and family N's own
> scoring **predates two of its four rows** — the campaign debt is real, grows
> with every family, and is discharged in one campaign at `SO-` time. (2) The
> M03-J4 guard's driven-word reading remains **structurally argued, not
> demonstrated**: M03-N4 enters the guard at both members and finds nothing,
> which is a non-violation and is not evidence about the reading. (3) **No
> `SO-xgmii_rx_64.md` is opened and none is offered** — fourteen ASSERT rows
> outstanding, families K/L/M unwritten, and the charter §3 verilog-ethernet
> anchor undischarged.

### 4.O Structural and declared no-instance

| Row | Attacks | Stimulus | Observable | Kills | Status |
|---|---|---|---|---|---|
| **M03-O1** | REQ-003, REQ-010, REQ-112, §4.1 | — | Interface compile check: `O` carries `Axi64.Source` with no `Dest`, `I` carries no `tready`; the six `Source` field names witness (SPEC-M01 §11.4) | A hand-rolled stream record with the same fields | STRUCTURAL |
| **M03-O2** | REQ-014, §10's REQ-014 hook (repaired `541ea43`) | — | **No instance at M03 for REQ-014's differential run**, and SPEC-M03 §10 now says so in the form SPEC-M14 §10 uses for REQ-404/REQ-810 — the request is **landed and editorial**, so no re-countersignature was owed for it and the row's citation is now the specification rather than this plan's inference. REQ-014's verification column commissions "the same stimulus with `tstrb` = 0x00 and `tstrb` = 0xFF"; M03's input is an XGMII lane pair, which has no `tstrb` to vary (REQ-010 class (b)). The **producer** half — `tstrb` driven 0 on every output word — is asserted by the standing protocol monitor. The consumer half belongs to M06 | — (stated so no `SO-` claims REQ-014 whole at M03) | GAP |
| **M03-O3** | REQ-017, REQ-018, REQ-903, REQ-808 | — | Emitted-Verilog port names `xgmii_rxd`/`xgmii_rxc`; the module whitelist (`tools/check_emitted_verilog.sh`); `.mli`, `create` and `hierarchical` present; the module name appears in `rtl_snapshots/` | A record whose `[@rtlprefix]` drifted; an instantiated primitive outside the §4 inventory | STRUCTURAL |
| **M03-O4** | §6.3 item 3 | — | A start character in a lane other than 0 or 4 is **never driven** and nothing is asserted about it | — | NO-STIMULUS |
| **M03-O5** | §6.3 items 2, 4, 5 | — | Nothing is asserted about register placement, FSM encoding, counter direction, `tdata` where `tkeep` is 0, or any field on a `tvalid` = 0 cycle. §9's strobe **cycle**, by contrast, is pinned and **is** asserted (§6.3 item 5 says so explicitly) | A snapshot that freezes an unconstrained value into an accidental requirement | NO-ASSERT |

---

## 5. Attacks considered and rejected

Charter §8 requires the rejected list, because that is what the auditor mines
for blind spots. Each entry names why the attack is *not* a row.

1. **A random-frame fuzz campaign** (random lengths, random control-character
   placement, random gaps). Rejected as a *substitute*, not on principle: every
   observable in §9 is a function of the input trace, so a fuzz run needs the
   same golden model the directed rows need, and until that model exists a fuzz
   run can only assert protocol legality — which the standing monitors already
   do on every directed row. Revisit once the link-partner model can compute a
   frame's expected §9 outcome; at that point fuzz becomes cheap and is worth a
   row of its own.
2. **Asserting the absolute-cycle equality of the two start lanes** (M03-A4) —
   forbidden by §6.1 and §10.
3. **Asserting which FCS realisation is used** (M03-D4) — §6.3 item 1 makes it
   unobservable.
4. **A start character in lane 1, 2, 3, 5, 6 or 7** (M03-O4) — §6.3 item 3 plus
   REQ-018's contract. Driving it would commission a test for a stimulus the
   programme has decided not to produce.
5. **Two frames overlapping in the same word other than through `/S/`** — not
   expressible on an XGMII lane pair; the lane pair carries one character per
   position and §9's closure list is total over them.
6. **A gap shorter than §0.3's 9-octet DIC floor.** SPEC-M03 §2 says explicitly
   that reacting to a short gap is *nobody's* job on the receive path; a bench
   asserting anything about it would be asserting a requirement that does not
   exist. The link-partner model's own `check` refuses to emit one.
7. **`tuser`[0] driven on M03's input.** M03 has no input abort bit — it is the
   origin of the chain (§9's closing paragraph, M03-M9). The attack belongs to
   M06 and above.
8. **Asserting the CRC register's intermediate values, the `octet_count` M02
   sees, or the state M03 occupies in `Discard`.** All internal; ADR-0007's
   1-to-8 domain is enforced observably instead — by M03-C2 (a held CRC fails
   seven of eight terminate lanes) and M03-A2 (a held CRC fails every lane-4
   frame). This is the deliberate choice to attack an internal invariant
   **through** its observable consequence rather than by reaching inside.
9. **A frame longer than 1600 octets, or a 9000-octet jumbo.** REQ-108's
   behaviour is already exercised at 1519 and 1600; a longer frame adds cycles,
   not classes. If a `Discard`-state counter can overflow it does so at a length
   no requirement admits, and the attack would be against an unspecified space.
10. **Deliberately illegal `xgmii_rxc` patterns** (e.g. every lane marked
    control with data values). Outside REQ-018's contract; the closest legal
    attack is M03-I3's ordered set, which is a row.
11. **Preamble longer or shorter than eight octets.** §6.1 fixes it at exactly
    eight octet times from the start character inclusive; a different preamble
    is a different stimulus, not a variant of this one, and REQ-102 forbids the
    receiver from noticing the contents anyway. M03-N3 is the boundary of this
    argument and is a NO-STIMULUS row for the same reason.

## 6. Coverage map — REQ to rows

Every REQ SPEC-M03 §10 lists appears exactly once. A REQ with no behavioural
row carries the reason.

| REQ | Rows |
|---|---|
| REQ-003 | M03-L6, M03-O1 (structural) |
| REQ-004 | M03-L1 |
| REQ-005 | M03-L2, M03-L5. **M03-I4 REMOVED 2026-08-07 (`J-dv_lead-0085`)**: REQ-005's per-octet constancy is defined and measured on a **gapless** stimulus (requirements.md §0.5 as ruled at `a77017c`, which leaves REQ-005 untouched precisely *because* its stimulus is gapless), and M03-I4's runs are injected and assert no per-octet constant at all — it reports one. A row that reports discharges nothing, and leaving it here would have claimed coverage this plan does not have |
| REQ-007 | M03-D1, M03-E1, M03-F1, M03-G1, M03-H1 (set); M03-E3, M03-F2, M03-B2, M03-B4 (the zero-delivered cases where the bit has no word — §0.7) |
| REQ-008 | M03-B2, M03-B3, M03-B4, M03-E2, M03-F2, M03-G6, M03-H4 (every discard has a strobe); standing obligation 2 (conservation) |
| REQ-009 | M03-K1, M03-K2, M03-K3 |
| REQ-011 | M03-C1, M03-C3, M03-C4; standing obligation 1 |
| REQ-012 | M03-A5 |
| REQ-014 | standing obligation 1 (producer half); **M03-O2 declares the differential half has no instance here** |
| REQ-015 | M03-C3, M03-C4; standing obligation 1 |
| REQ-016 | M03-I4, M03-I5, M03-I6, M03-N3 |
| REQ-017, REQ-018 | M03-O3 |
| REQ-019 | M03-L3 |
| REQ-020 | M03-L4 |
| REQ-021 | M03-A2, M03-A5, M03-H2 |
| REQ-101 | M03-A1, M03-A2, M03-A3, M03-A4 |
| REQ-102 | M03-B1, M03-B2, M03-B3, M03-B4, **M03-N2** (the lane-0-start placement, where the whole preamble lies inside the start word — the instance the WO-0029 ruling turns on) — **DRIVEN 2026-08-05**, `test/xgmii_rx_64/test_m03_n.ml`, six titled sub-cases, **all six green** at `eb1e06a` in CI `build` run **`30963617198`** (job `92172708172`; `RV-0065B-VERDICT`, `J-dv_lead-0113`). **The no-coverage mark is STRUCK**, by the condition it named for itself. *Superseded wording, kept because the argument that retired it is only readable against it: "**which SUPPLIES NO COVERAGE HERE TODAY** (measured `J-dv_lead-0106`, ruled at §4.N's closing note, `J-dv_lead-0109`; re-grounded 2026-08-05, `J-dv_lead-0112` — a unit landed at `88413b9` but three of its six sub-cases are RED in CI run `30961544649`, so the mark stands on the new ground "benched and not green" rather than the old "has no unit", and it is struck only by a green respawn)"*, M03-N3 (the idle-in-preamble routing) |
| REQ-103 | M03-C1, M03-C3, M03-E1, M03-F1, M03-G1, M03-H1 |
| REQ-104 | M03-D1, M03-D2, M03-D3, M03-D4, M03-M2, M03-M3, M03-M4, **M03-M10** (the sub-5 class, where REQ-104 supplies neither operand) |
| REQ-105 | M03-B2, M03-E1, M03-E2, M03-E3, M03-E4, M03-G4 (second epoch), **M03-G8** (first epoch), M03-M5, M03-M7, M03-N1 |
| REQ-106 | M03-C1, M03-C2 |
| REQ-107 | M03-B3, M03-F1 … M03-F5, M03-M1, **M03-M10** |
| REQ-108 | M03-G1 … M03-G8, M03-M2, M03-M6, M03-M7. **Read the two epochs**: G1, G3 and G4 drive REQ-108's window after the frame's own terminate; **G7 and G8 drive it before**; G6's frame has no terminate so its whole window is the first epoch |
| REQ-109 | M03-I1, M03-I2 |
| REQ-110 | M03-B4, M03-H1 … M03-H4, M03-M4, M03-M5, M03-M6, M03-G3 (second epoch), **M03-G7** (first epoch), **M03-N2** (the abort half) — **DRIVEN 2026-08-05**, `test_m03_n.ml`, six sub-cases, **all six green** at `eb1e06a` in CI `build` run **`30963617198`** (`RV-0065B-VERDICT`, `J-dv_lead-0113`); **the no-coverage mark is STRUCK** on the ground it set itself. **Sub-cases 4, 5 and 6 are this plan's three `WO-0058` bound-7 instances**, and they are **not the same shape** — 4 and 5 enter W in `Frame` state, 6 in `Preamble` state (§9's closure list makes all three *open*); the campaign seal scores them distinguished, never as a count. **Bound 7 is SCORED 3 of 3, 2026-08-06** (`WO-0066-VERDICT` §7, §4 rule 1) — and **§4.H bound 2 carries the score, the state split and `FINDING WO-0066-6`'s correction** (that `M03-H1` and `M03-H2` drove the bound's conjunction from `WO-0057`, so these three sub-cases are not its first detectors). This entry points at that adjudication and does not restate it; **the score discharges no row and does not move this map's coverage in either direction**. *Superseded wording: "**no coverage from it here today** (§4.N's closing note, `J-dv_lead-0109`; re-grounded 2026-08-05, `J-dv_lead-0112` — a unit landed at `88413b9` and is RED at three of six sub-cases in CI run `30961544649`, so the mark stands on "benched and not green" and is struck only by a green respawn)"*, **M03-N4** (the abort under a disabled receive path, ADR-0014) |
| REQ-111 | M03-L2, M03-L5 |
| REQ-112 | M03-L1, M03-L6 |
| REQ-113 | M03-E4, M03-I3 |
| REQ-802, REQ-810 | M03-J1 … M03-J4, **M03-N4** |
| REQ-803 | M03-J2, M03-J3, M03-N4 |
| **REQ-901** | **No behavioural row, and none is owed.** REQ-901 is a process obligation on the differential co-simulation lane, not a property of M03's ports, so it has no stimulus and no observable at this module's boundary. It appears here because SPEC-M03 §10 **gained a REQ-901 row at `62c39a7`** and this table's own rule is that every REQ §10 lists appears exactly once — without this entry that rule was false. Its two declared divergence classes are **homed at this module**: **(e)** runt marking (REQ-107) and **(f)** oversize truncate-and-mark (REQ-108). Their scope, and what it does and does not cost the rows, is carried at **§4.F's and §4.G's family notes**; the standing consequence for a sign-off packet is at **§7** |
| REQ-903, REQ-808 | M03-O3 |

## 7. Machinery this plan requires and does not have

> **STALE AS A GAP LIST — read §9's WO-0033 row before acting on this table
> (dv_lead, `J-dv_lead-0037`).** All five items **X-1 through X-5 were built at
> WO-0033** and **no row of this plan is blocked on machinery**. The table below
> is kept as the requirements statement each item was built against — it is
> useful for *what X-n must do*, and misleading for *whether X-n exists*. The
> banner is here because a reader who consults §7 alone would plan around gaps
> that closed three days after it was written, and this plan has already cost
> one campaign finding to exactly that failure mode (a stale inference left
> standing, `RV-0039-VERDICT` F-2).
>
> **The one live constraint is not a gap but an anchor**: WO-0033's own standing
> limit records that **X-1's outcome model is not the charter §3 external
> anchor** — that is the verilog-ethernet differential co-sim — and **no
> `SO-xgmii_rx_64.md` PASS may rest on the model until it has run.**
>
> **THE CONDITION IS PER STIMULUS CLASS, AND *"until it has run"* IS WITHDRAWN AS
> ITS STATEMENT — 2026-08-09 (found `J-dv_lead-0125` while writing the Phase 1
> adjudication, `agents/handoffs/WO-0046_cosim-phase-1-adjudication.md` §7;
> landed here `J-dv_lead-0132`).** The co-simulation **has** run: Phase 1, `build`
> run **`30988038809`** at `2dbd39b`, `cosim` job **`92247281222`**, green. **Read
> literally, the sentence above is therefore discharged** — which is plainly not
> what it means and not what the evidence supports. Phase 1 drives **one**
> 64-octet good-FCS frame at a **lane-0** start and **injects nothing**, so it
> anchors **no cell** of X-1(ii), whose subject is *injected* frames. **The
> condition, restated so it can be checked**: *no `SO-xgmii_rx_64.md` PASS may
> rest on a computed outcome of X-1(ii) for a stimulus class the differential
> co-simulation has not driven.* That is per class, it is checkable at a cell,
> and it makes `CD-xgmii_rx_64_cosim.md` §6's phase distribution **the schedule
> for discharging it** rather than a list of predictions. **It composes with bar 2
> below rather than colliding with it**: bar 2 names two requirements the lane can
> **never** anchor (REQ-107, REQ-108, under REQ-901 classes (e) and (f)), and this
> bar names, per class, what the lane has **not yet** anchored. **Neither is
> satisfied by a run happening; both are satisfied per class or not at all.** The
> superseded wording is kept above rather than struck, because the argument that
> retired it is only readable against it — and its defect is the one this plan has
> now paid for four times, a **summary sentence left standing while the world it
> summarises moved** (`RV-0039-VERDICT` F-2, this banner itself, the "Not gaps"
> paragraph below, and now the banner's own live constraint).
>
> **The per-family sentence that used to stand here is WITHDRAWN** — "families E,
> F, G and H lean on X-1's computed outcomes and are therefore gated on it for
> sign-off purposes; family D is not". It was wrong in its **unit** (a family is
> not the thing that is gated) and it is now also wrong in its **conclusion** for
> two of the families it named. **Two independent bars replace it, and the whole
> point is that they are not the same bar:**
>
> 1. **The X-1 bar — per row.** A row is gated on the differential co-sim **iff
>    its expected values are taken from X-1's computed outcome model**, never
>    merely because of the family it sits in. X-1's *placement machinery* and
>    X-1's *computed outcome model* are two different things and only the second
>    is unanchored — the correction made at `J-dv_lead-0048` and owed to this
>    section ever since. **No row benched to date is gated by this bar**: A, B and
>    C predate X-1; family D is hand-derivable from §9 end to end; families E and
>    F were commissioned hand-derived with the model used only as a *reported*
>    cross-check (`WO-0043` §1, `WO-0047` §1.3, the `cross_check_*` /
>    `fail_cross` idiom). A future row that takes an expected value from the
>    model is gated, and must say so in its own text.
> 2. **The REQ-901 bar — per requirement, and it points the other way.** For
>    **REQ-107** and **REQ-108** — declared divergence classes **(e)** and **(f)**,
>    homed at this module by spec diff and restated in SPEC-M03 §10 at
>    `62c39a7` — **a co-simulation result is not an admissible external anchor at
>    all, and a sign-off packet SHALL NOT offer one.** Families **F** and **G**
>    are therefore not *waiting* on the lane: the lane can never discharge those
>    two requirements, and their directed rows are the whole of their
>    verification. Per-class scope is at **§4.F's and §4.G's family notes**.
>
> **The consequence worth stating plainly, because it is the reason this
> paragraph had to move**: read literally, the withdrawn sentence would have held
> families F and G's sign-off hostage to a run that cannot discharge them — and a
> packet that *satisfied* it would be offering exactly the anchor §10 now
> forbids. The lane still matters to family F, but through the **other** half of
> M03-F1's own row: REQ-103's FCS removal on a 5-to-63-octet runt, which (e)
> deliberately leaves inside the comparison domain.

Deliverable 4 of WO-0027: named here, **not built here**. Each is a candidate
for the next DV work order; the numbering is local to this plan.

| # | Machinery | Which rows need it | Note |
|---|---|---|---|
| **X-1** | **The link partner's error-injection catalogue** — REQ-018's second contract clause, deliberately deferred by `test/xgmii/arrival.mli` until this plan existed. **X-1 is TWO things and this row conflated them until 2026-08-03 (`J-dv_lead-0065`); the distinction is the one §7's banner turns on.** **(i) The placement machinery** — per-frame corruption of one payload bit (bad FCS); replacement of the terminate character by `/S/` or `/E/` at a chosen octet time; placement of `/E/`, `/T/` or `/S/` at a chosen **preamble** position; over-length and under-length frames. This is **stimulus construction**, it is anchored by nothing and needs to be, and **every row below may use it freely**. **(ii) The computed expected §9 outcome** — delivered octet count, `tkeep`, abort bit, strobe name and pinned cycle, per injected frame. This is an **oracle**, it is the half WO-0033's standing limit is about, and **a row whose expected values come from it is gated on the differential co-sim while a row that hand-derives them and uses (ii) only as a *reported* cross-check is not** (§7's banner, bar 1). **No row benched to date takes an expected value from (ii)**: families E and F were commissioned hand-derived with the `cross_check_*` / `fail_cross` idiom, which is (ii) used as a tripwire rather than as an oracle | B2–B4, D1, D3, E1–E4, F1–F5, G1–G6, H1–H4, M1–M7, N1 | The largest single item. **Its (ii) half is what makes the fuzz campaign of §5 item 1 possible later, and is also the only half that was ever gated** — `J-dv_lead-0048` made the correction and it took until `J-dv_lead-0060` and this row to be written where a planner reads it |
| **X-2** | **An XGMII probe** — the `Xgmii_word`-to-live-port sampler, the counterpart of `test/axi64_probe/` on the wire side. `test/xgmii/dune` already records that it "lands with the first M03 bench" | every row | One function, same shape as `Axi64_probe.of_refs` |
| **X-3** | **A strobe monitor.** No monitor today counts strobes: `Conservation_monitor.strobe_pulse` is a call a bench makes by hand. Needed: (a) **high-cycle** counting per §0.6 as revised by **C-23** — never rising edges; (b) an **expected-cycle** check against §9's pinned cycles (the `tlast` cycle, or two cycles after the closing input word for a frame with no output); (c) the §0.6 window check — **bounded, and the bound is now normative: on a frame that received NO octet, check (c) is a tautology and proves nothing.** requirements.md §0.6 (2026-08-06, `J-architect_docs_lead-0023`, countersigned `J-dv_lead-0081`) makes such a frame's reference word its **closing word**, and §9 pins its strobe two cycles after that **same** word, so the pin lies inside the window as a matter of **arithmetic**, whatever either rule said. On that class the assurance is **(b)'s exact pin plus (d)'s exact event set, never (c)**. Check (c) keeps its teeth wherever the frame **received** an octet — there its two ends and the pin are three different quantities — and a frame of **1 to 4** octets is in that teeth-bearing class, not the vacuous one; (d) "no strobe other than those the stimulus creates" | every strobe row; **M03-H4** is the row that makes (a) load-bearing at this module — **and the row at which (c) is vacuous**, so its assurance is (a), (b), (d) and its own frame-C output check | C-23's convention was homed in requirements.md §0.6 on M13's evidence and stated there as generalising. M03-H4 is the second instance and the first on the receive chain. **(c)'s bound is `RV-0057-VERDICT` Finding 2, adopted into requirements.md §0.6's own note; it is why M03-H4's `Strobe_monitor` registration is not that row's assurance.** `WO-0058-VERDICT` §4 confirmed it empirically: three seeded classes reddened M03-H4 and **none** spoke through the window — two through the exact `error_pulses` list, one through frame C's own `tlast` word |
| **X-4** | **An idle-injection wrapper** at 0, 1 and 7 cycles (§10's figures), with the **M03-N3 constraint** built in: injection never lands between a frame's start character and its first octet. The constraint now has a spec citation — SPEC-M03 §6.1 and §10's REQ-016 hook at `541ea43` — rather than this plan's inference, and the wrapper SHALL implement it as written even where **C-45** shows it over-broad (a lane-0 start's first inter-word boundary occupies no preamble position); if the scope lands, the wrapper gains that boundary back and M03-I4 gains a case | I4, I5, I6 | The constraint is the deliverable as much as the wrapper is. **2026-08-07 — X-4's first contact with a DUT (`WO-0059` rounds 1 and 2) produced two results, and both are what it was built to produce.** It falsified `idle_injection.mli`'s own `cycle_of` docstring, whose second sentence named an **output** cycle as an argument the function could take (`RV-0059-VERDICT` FINDING 4; repaired comment-only at `81e1d33`) — a defect X-4's own unit tests could never reach, because they exercise the map and the map is correct. And it found **`BUG-0002`**. **No behaviour defect has been found in the wrapper itself** across two adjudications that each read `idle_injection.ml` and `.mli` in full |
| **X-5** | **A truncated-frame entry point on the latency tagger.** `Latency.frame_out` requires the output length to equal (input − `strip_octets` − `tail_octets`), which holds for a clean frame and is false for **every** aborted or truncated frame — families E, F, G and H all deliver a short frame. `frame_dropped` covers only the no-output case. Needed: a per-frame expected output extent | E1, F1, G1, G2, H1, H2 | Same repair serves M14 (see AP-M14 X-9), where the tail varies per datagram rather than per frame class |
| **X-6** | **A `cfg_rx_enable` schedule for the M03 bench** — a declared value-per-cycle drive for the configuration port, so that a row may state *"the enable is 0 from here to here"* as a construction rather than as one hand-written predicate per call site, each with its own hand-computed cycle — the duplicated-idiom-with-a-hand-computed-boundary shape this programme has already paid for at `RV-0057-VERDICT` Finding 1 and `RV-0062` FINDING B-1. **X-6 is TWO things and the second is not the lesser of them.** **(i) The schedule** — an initial value plus an ordered list of `(cycle, value)` changes, with the value the design was driven at each cycle **readable back off the sample** so a row asserts the window it drove instead of the window it declared. **(ii) The M03-J4 constraint, mechanised** — §4.3, §6.3 item 7 and **C-14.5** say a change landing on the exact cycle of a start character has **no determinate outcome** and **SHALL NOT** be driven-and-asserted, so the bench **refuses** such a schedule before a cycle is driven, and it refuses it against the **driven** word rather than against the declared arrival, because the row that most needs the guard (**M03-N4**) has its start character injected and absent from the arrival schedule entirely | **J1, J2, J3, N4** — and **J4 is the constraint itself**, which is the whole of why the guard is a deliverable and not a convenience | **BUILT AND LANDED at `e4df986`** (family J's three units, CI `build` run `30980439774`), **and the constraint is the deliverable as much as the schedule is — the X-4 precedent, applied to a second item and for the same reason.** X-4 records that its own note said this before its first contact with a DUT proved it; X-6 records the same shape with a measured instance of its own. **The guard's entry condition was one transition short of its own subject, and it was found by review rather than by a red** (`RV-0067-VERDICT` §6.2, a finding against the packet that specified it, not against the code that implemented it verbatim): a schedule declaring `initial = false` has a real 1 → 0 transition **between the reset drive and cycle 0** that the pre-scan never saw, because the scan was entered on the *declared changes* being non-empty rather than on the *observed transitions*. **Harmless while unreachable and reachable the moment a row drives a schedule and a word override together**, which is M03-N4's own mechanism class. **Repaired at the subject rather than at the entry condition** — the transition set now reports the boundary transition it observes, so the entry test is a projection of the subject and cannot drift from it — with a structural witness unit carrying **no** `M03-` row id, so the inventory moves and the census does not. Landed and green at **`2dbd39b`**, run **`30988038809`**. **The general form, which is the part portable off this module**: a guard whose subject is a derived set must be entered on that set, never on a hand-written predicate that reconstructs it |
| **X-7** | **A `clear` schedule for the M03 bench** — REQ-009's counterpart of X-6, and the second port of this module to get a declared value-per-cycle drive rather than one hand-written predicate per call site. **X-7 is TWO things and the second is not the lesser of them — the X-4 and X-6 precedent at its third instance.** **(i) The schedule** — `Bench.Clear`: a private `{ first; last }` window in which `last < first` encodes `never`, a **total** `value_at`, an ascending `high_cycles` (`[]` for `never`), a deterministic `report`, and the value the design was driven at each cycle **readable back off the sample** (`sample.clear`), so a row asserts the window it **drove** and not the window it **declared**. `window` refuses `last < first`, so `never` is unconstructible through it and the encoding cannot be forged by a caller. **(ii) The refuse-to-drive guard, which mechanises a spec ambiguity instead of ruling it** — SPEC-M03 §6.2's `Idle` row (*"ignores every lane"*) and §7's reset bullet do not jointly decide what a start character arriving on a cycle carrying `clear` = 1 does, so the bench **refuses such a schedule before a cycle is driven**, and it refuses it against the **driven** word rather than against the declared arrival, for X-6's own reason. The guard is why family K's round says **nothing** about that ambiguity by construction rather than by care | **K1, K2** — and the guard is the constraint itself, which is the whole of why it is a deliverable and not a convenience | **BUILT AND LANDED at `284225d`** (family K's two row units plus one structural witness, CI `build` run **`31032021108`**, steps 6 and 8 `success`), **and the constraint is the deliverable as much as the schedule is.** **The subject and the entry condition were RE-DERIVED, not transplanted, and the transplant would have been wrong twice** (`WO-0072` §2, confirmed by review at `RV-0072-VERDICT` §2). *(a) The reset polarity is inverted, so the default becomes the special case*: `create` drives `clear` = 1 and the default schedule is **never** = 0 for the whole run, so a literal copy of X-6's `(0, false)` boundary-transition prepend would make `Clear.never` report a transition, the entry condition would be TRUE for every `?clear`-omitted run, and **all fifty-six landed units would have entered a walk they do not enter today**. *(b) The subject is a different set*: X-6's guard fires on a **change** coinciding with a start character; this one fires on a **high cycle** coinciding with one, so its subject is `high_cycles` and its entry condition `is_ever_high` is that set's projection — and a transition set is neither, being non-empty for schedules whose high set is empty. **A copied guard would also have refused this round's own K2 stimulus**, whose release cycle carries frame B's start character by REQ-009's own last sentence. Entry condition **mechanically witnessed** by the structural unit (`high_cycles never = []`, `is_ever_high never = false`); its **refusal** is still only argued, which is the standing fact recorded at X-6 for the J guard and now true of both. **The reusable form, and it is the part portable off this module**: *a guard's entry condition must project the guard's own subject, and the subject must be re-derived per port — two ports of one module can share a schedule's shape and have different subjects, opposite reset polarities, and opposite verdicts on the same coincidence.* **AND A SECOND RULE, BANKED HERE BECAUSE THIS ROW IS WHERE IT WAS MINTED — `FINDING K-3` (`RV-0072-VERDICT`)**: *a review bar whose pass condition is a universal over a whole tree or a whole diff must be measured against that tree before the bar is written, or it must be expressed as a delta. A bar that has never been run against its own base is not a bar, it is a hope — and it fails on the first round where the base has moved, silently, because its failure looks like a defect in the work.* Three of the seven dv-seat bars written for this row's own round were false against the tree they pointed at, all three the same way, and all three would have been caught by executing them once at the base at draft time, which costs nothing. **That execution is now owed at draft time for every bar written from this seat** |

Not gaps: `Conservation_monitor`'s exemption machinery (C-2) exists and is used
by M03-J1 and M03-K2; `Protocol_monitor`'s `max_words_per_frame` covers
REQ-015's 190; `Latency`'s three-quantity split (WO-0012) is what M03-L3 asserts
against; `Frame`/`Arrival` already produce the §8 stress schedule and check
themselves against §0.3.

**The "Not gaps" paragraph above is UNCHANGED, and it is left unedited
deliberately — what moved is the world, not the sentence** (2026-08-09,
`J-dv_lead-0124`). It has said since WO-0027 that `Conservation_monitor`'s
exemption machinery (C-2) *"is used by M03-J1 and M03-K2"*, and until family J
landed that was a statement about which rows **would** use it. **Measured at
`8d8a239`, this round's base, by `grep -rn "frame_in_exempt" test/ --include=*.ml
--include=*.mli`**: the exemption has exactly **three call sites** in `test/**`,
**all three in `test/xgmii_rx_64/test_m03_j.ml`** (`:212`, `:358`, `:564`) —
every other hit is a docstring or a comment — and that file landed at
**`e4df986`**. So the sentence became true of **M03-J1 for the first time at
`e4df986`**, four days after §7's staleness banner was written about the
opposite failure, and it is **still not true of M03-K2**: K2 drives `clear`,
which no bench in this suite has driven, and it is one of the fourteen ASSERT
rows outstanding (§4.N's landed-status block carries that census with its run
id). Recorded **here** rather than by editing the sentence, for the reason §7
already paid for once: a requirements statement that is quietly rewritten into a
status report stops being either, and the fix is a dated note beside it, not a
tense change inside it.

**AND IT BECAME TRUE OF `M03-K2` ON 2026-08-09, AT `284225d`** (`J-dv_lead-0132`;
CI `build` run **`31032021108`**, steps 6 and 8 `success`). The sentence WO-0027
wrote about two rows is now true of **both**, and the dates are recorded rather
than the tense changed: true of **M03-J1** from `e4df986`, true of **M03-K2**
from `284225d`. K2 reaches C-2's exemption through
`Bench.account_cleared_frame` (`test/xgmii_rx_64/bench.ml:529`,
`frame_in_exempt ~reason:"clear (REQ-009)"`), called by the row's own unit at
`test/xgmii_rx_64/test_m03_k.ml:540` with `~delivered:16`. **The exemption is
therefore load-bearing for a conformant M03 in the way §2 obligation 2 says it
is** — not as a convenience: with `frame_in` in its place a *conformant* design
shows `residual` = 1 and the round reds.

**AND THE MEASUREMENT THAT ESTABLISHED IT CONVICTS THE PREVIOUS ONE — `FINDING
AP-1`, against my own text, minted by §0.1's rule at the first citation §0.1 has
governed.** The 2026-08-09 note above states that the exemption has *"exactly
**three call sites** in `test/**`, **all three in
`test/xgmii_rx_64/test_m03_j.ml`** … every other hit is a docstring or a
comment"*. **Re-measured at `8d8a239`, the commit that claim names as its own —
`git grep -n "Conservation_monitor.frame_in_exempt" 8d8a239 -- 'test/*.ml'
'test/**/*.ml'` — the figure is FIVE, not three.** The two the claim missed are
`test/monitors/test_conservation_monitor.ml:161` and `:163`, the monitor's own
unit test, and both are **calls**, not docstrings. At `284225d` and at this
round's base `5d2beff` the figure is **SIX**, the sixth being `bench.ml:529`
above. **The conclusion the claim supported is unaffected and is not withdrawn**:
neither missed site is an M03 row's call, so *"true of J1 at `e4df986`, not yet
true of K2"* was correct then and the line above completes it now. **What is
false is the set claim itself**, and its failure mode is §0.1's exactly — a
census asserted in a sentence, quoted rather than re-run, wrong in its
enumeration while right in its point. **It is recorded, not struck** (the same
disposition the paragraph it annotates gives its own subject), and it is the
standing answer to why §0.1 binds this plan's prose and not only its packets: the
rule caught this one **at the point of citation**, before a campaign or an `SO-`
rested on it, which is the first time it has done so.

**OBSERVATION K-O1 — recorded here, not repaired, and NOT this plan's to
change** (`WO-0072` §10.3, 2026-08-09, `J-dv_lead-0132`).
`Conservation_monitor.frame_out ~aborted` documents `aborted` as *"REQ-007's
`tuser`[0] marking"*, and **every landed bad-FCS call site passes
`~aborted:false`** while that frame's `tlast` carries `tuser`[0] = 1
(`test/xgmii_rx_64/test_m03_d.ml:171`, on `WO-0040` §3.1's ground, which argues
from the delivered **extent** rather than from the marking; M03-K1's call copies
it unchanged). Nothing today compares the two monitors' `aborts` counters against
each other, so **nothing is red and no row is wrong** — what exists is a
documented meaning and a landed usage that do not agree. **Not a finding against
any round, and deliberately not repaired here**: the repair is a machinery
question about `test/monitors/**`'s own contract, not a plan question, and
changing family D's landed call inside a plan round would be exactly the
improve-a-carrier move this plan's own trap list forbids. **Carrier**: the next
round that opens `test/monitors/**` — named so it cannot evaporate, and reported
rather than dated, because no round is scheduled against that path yet.

**OBSERVATION K-O2 — RAISED AND PAID IN THE SAME COMMIT** (`RV-0072-VERDICT`
§3(a), 2026-08-09, `J-dv_lead-0132`). `Bench.account_cleared_frame` shipped at
`284225d` with **two branches and one witnessed**: `delivered > 0` takes
`Latency.frame_out ~expected_octets`, `delivered = 0` takes
`Latency.frame_dropped`, and **nothing in the landed suite recorded which one
M03-K2 took.** `Latency.word_delay = Some 3` does not: frame B alone produces it.
The row's claims were sound without it — `~delivered:16` is a literal the row
asserts before the call — so this bounced nobody and withdrew nothing; what it
left was a **brand-new capability shipping with one of its two branches dead and
unwitnessed**, which is M03-K1's own §7.5 shape one level down. **Disposition:
PAID, not carried.** `Latency.frames_compared = 2` is asserted in M03-K2's unit
in this same commit — the counter is incremented by `frame_out` and **not** by
`frame_dropped` (`test/monitors/octet_time.ml:244` against `:85`), so the value
**2** is the mechanical statement that frame A was offered to the tagger as a
16-octet output frame rather than dropped, and **1** would have been the
statement that it was dropped. **The check is the landing's own CI green**; this
plan carries no coverage claim for it, no row moves, and the assertion names no
`M03-` row id that the census could read as new coverage. **The general form**: a
function whose branches are selected by a caller-supplied quantity owes a witness
of *which branch ran*, not only of the quantity — the quantity is the input and
the branch is the behaviour, and asserting the input proves the branch only to a
reader who has the body in front of them.

## 8. Open questions and rulings requested

Routed through the orchestrator to architect_docs_lead. None blocks a bench
other than its own row.

> **All four ANSWERED at `541ea43` (WO-0029); dv's countersignature WITHHELD at
> WO-0030** (`J-dv_lead-0015`). Item by item:
>
> - **1 (M03-N2)** — ruled for reading (i), **against rtl_lead's declared
>   reading**, on REQ-102 one document up rather than on a preference, and dv's
>   own §9-versus-§6.3 recommendation is superseded by a better instrument: the
>   ruling costs no new text at all, and the one stimulus it cannot report
>   (**two frames reported on one cycle under the same strobe name**) is carved
>   out at new §6.3 item 8 as a bound on DV, not on the module. **Endorsed, with
>   a second and independent ground the ruling did not use**: REQ-101 requires
>   *identical output streams for the same frame received at either alignment*,
>   and the one-closure-per-word reading breaks it — a `/T/` or `/E/` at
>   preamble position 4 … 7 shares the start word at a **lane-0** start (so it
>   is swallowed) and lies in the **following** word at a lane-4 start (so it is
>   recognised), giving two different output streams for one frame. **The row
>   does not convert**: the reading is settled, the report **cycles** are not —
>   defects **M03-R1** and **M03-R2**, derived under §4.N, are the withholding
>   ground. **Repaired at `06c1eba` and re-countersigned** (`J-dv_lead-0016`,
>   WO-0031), confinement verified across the whole tree: `docs/specs/**` moves
>   in one file and three hunks. **M03-N2 → ASSERT**, six sub-cases, cycles from
>   §6.1's landed table.
> - **2 (M03-N3)** — the requested §6.3 sentence **declined and bettered**: the
>   stimulus is *decided*, not unconstrained, so §6.3 was the wrong home and the
>   constraint that is owed binds the wrapper. Accepted. Residue **C-45**: the
>   prohibition is over-broad at a lane-0 start and its stated ground ("such a
>   cycle occupies preamble positions") does not hold there.
> - **3 (M03-N4)** — ruled for reading (i), **ADR-0014**; the enable gates
>   admission and nothing else. Endorsed on its merits, and the argument that
>   carries it is the right one: the unscoped reading of REQ-810 is
>   self-defeating, because it would suppress the in-flight frame's own words
>   and its own report and open the silent-discard hole REQ-810's next clause
>   disclaims. **M03-N4 → ASSERT at `06c1eba`**, unchanged, exactly as
>   pre-committed at WO-0030 — the repair touches none of the text it derives
>   from.
> - **4 (M03-O2)** — landed, editorial, no re-countersignature owed.
>
> **Consequence outside this plan, and it is not dv's to route**: the M03 RTL at
> `f840475` recognises one closure per input word, so it is non-conformant
> against **frozen** REQ-102 and §10's REQ-102 and REQ-110 hooks. That is an RTL
> defect against text frozen since batch A, not a change this ruling makes, and
> it is rtl_lead's under its own packet.

1. **M03-N2 (RULING, from rtl_lead's returned question 2)** — two closure
   characters in one input word where the second falls inside the new frame's
   preamble. §6.1 routes a control character in a preamble position to §9 in
   terms; rtl_lead has implemented one closure per word. The readings differ in
   exactly one observable (whether `error_runt` pulses), and under the
   one-closure reading a frame is opened and never reported, which is a hole in
   §0.6's conservation equation. **Cheapest repair either way: one row in §6.3
   (unconstrained) or one row in §9 (specified).** Recommendation: §9, because
   the text-strict reading is already what §6.1 says and the conservation
   equation prefers it.
2. **M03-N3 (from returned question 3)** — an idle word inside a frame's own
   preamble. §6.1's "exactly 8 octet times" already decides it; the request is
   one sentence in §6.3 confirming the stimulus is outside the specified space,
   which closes the last place REQ-016 and §6.1 can be read against each other
   and pins the idle-injection wrapper's contract (X-4).
3. **M03-N4 (RULING, from returned question 4)** — `cfg_rx_enable` = 0 arriving
   with a REQ-110 start character while a frame is open. §4.3's two sentences
   point opposite ways and the observable differs in a delivered octet count, a
   strobe and an abort bit. REQ-810's own "no frame is accepted, so this creates
   no silent-discard hole" is an argument for the reading in which the in-flight
   frame **is** reported.
4. **M03-O2 (editorial, one cell)** — SPEC-M03 §10's REQ-014 hook names
   "REQ-014's differential run", which has no instance at M03: the input is an
   XGMII lane pair with no `tstrb` (REQ-010 class (b)). This is the C-41 family
   — a verification column commissioning something a bench cannot build here —
   and the repair is the form SPEC-M14 §10 already uses for REQ-404 and REQ-810:
   "none — stated so that no sign-off packet claims coverage here", with the
   producer half left where it is.
5. **The carry-forward ledger's unnumbered dv-machinery row** (`P1-spec-freeze`
   checklist, the row between C-14 and C-15: "Latency.create's single
   strip_octets conflates two quantities") **was discharged at WO-0012** and
   carries no id and no closure mark. Clerical, and the orchestrator's to
   transcribe; noted here because this plan's M03-L3 is the row that keeps the
   fix honest and a reader of the ledger cannot tell it is done.

> **Carried in from `BUG-0001` (rtl_lead's open question 2), for families D–H
> — dv_lead, `J-dv_lead-0032`.** The bench observes M03's outputs at
> `Cyclesim`'s `~clock_edge:After` position, which pairs the post-edge register
> state with the *previous* input word. Any observable that is combinational in
> the **current** XGMII word is therefore read in a state that never exists in
> hardware. At M03-C1 this bit exactly once in sixteen (lane 4, length 68 — the
> `terminate_lane = 0` entry, R-1). **rtl_lead's warning is that in the
> error-injection families the coincidence is common rather than rare**: a
> strobe consumed from an age-0 closure record — an `/E/`, a `/T/` or an `/S/`
> whose §9 outcome is decided in the same cycle the closing word is emitted —
> is invisible at that sampling position. Round 6 of WO-0038 moves the
> asserted view to `~clock_edge:Before`; **no family D–H row may be written
> against the old position**, and the first D–H bench must state which of its
> rows depend on an age-0 record, because a silently-missed strobe is a
> NO-ASSERT row that looks like a PASS.

> **Carried in from the WO-0039 mutation campaign — four standing facts for
> families D–H, dv_lead, `J-dv_lead-0037`.** Five seeded RTL defects and two
> seeded bench defects, all eight scored against predictions frozen before any
> diff existed (`RV-0039-VERDICT`). What the campaign established about *this
> bench*, as distinct from about M03:
>
> 1. **Three of the nine test units are blind to a one-cycle latency error, not
>    five.** M03-A5, M03-B1 and M03-C3 are. M03-C1/C2 and M03-C5 are **not**,
>    because since WO-0038 round 6 they also carry
>    `check_disagreement_matches_r1`, which is pipeline-coupled. The figure
>    "five of nine", recorded at `J-dv_lead-0035` and headed for this section,
>    is **WITHDRAWN** — M1 falsified it. Timing in this suite is asserted by
>    M03-A1/A2, M03-A3/A4 and M03-C4 directly, and by C1/C2 and C5 indirectly.
> 2. **A `check_disagreement_matches_r1` firing routes to re-deriving the
>    sampling model, never to adjusting the oracle.** It is a design-coupling
>    tripwire; a firing shows every content column PASSing. The full statement
>    lives beside the function in `test/xgmii_rx_64/test_m03_c.ml`. Any D–H
>    bench that inherits a two-view diagnostic inherits this rule with it.
> 3. **M03-A3's blindness to *lane-symmetric* errors is MEASURED — it is blind
>    (`RV-0050-VERDICT` §3, `J-dv_lead-0065`).** *Superseded 2026-08-03; the
>    original entry, retained per this plan's own rule for a recorded miss,
>    read: "UNTESTED. M3 was predicted to possibly demonstrate it and instead
>    took the reddening branch, so the demonstration did not happen. A3 is a
>    cross-lane equality row; D–H may not assume it catches content errors that
>    affect both start lanes identically, and may not assume it misses them
>    either."* **WO-0050's F-c2 settled it.** F-c2 marks a 64-octet frame as a
>    runt, so `tuser`[0] moves to 1 — and `tuser` **is inside the tuple
>    `tuple_of_sample` compares across the two start lanes**. Both lanes move
>    identically, the sequences stay equal, and **M03-A3's own assertion
>    PASSED**. T-A34 reddened one line later through `assert_monitors_clean`, on
>    a `Strobe_monitor` report of an `error_runt` pulse no expected event
>    claimed. **So: M03-A3 catches lane-*asymmetric* errors and is blind to
>    lane-symmetric ones. No packet may credit it as a content check**, and the
>    row's surviving value — a genuine one — is the cross-lane equality REQ-101
>    requires. The unit's survival under a content error is its **monitor's**
>    work, not the row's, and the two must not be conflated in an `SO-`.
> 4. **REQ-104's positive direction is entirely unverified by the WO-0038
>    suite, and this is a live hole rather than a planning note.** All fifteen
>    tests assert `tuser`[0] = 0 and *no* strobe on good frames — the M03-D2
>    direction. **Nothing anywhere drives a bad-FCS frame.** A design that
>    hardwired the FCS verdict to good and never pulsed `error_bad_fcs` would
>    pass every test in the suite today. The mutation campaign did not catch
>    this because none of its five mutations was a *silently-always-pass*
>    mutation — M2 broke the CRC and was caught by seven units precisely
>    because it made the verdict go **bad**. **M03-D1 is the closure**, and it
>    is why family D leads the next wave.
>
> **Item 5, added 2026-08-03 (`J-dv_lead-0065`) — the two no-output-word classes
> are NOT known to share a report path, and the claim that they do is mine.**
> `WO-0047` §1.2 folded M03-E5 into family F's packet on an explicit
> *verification* ground: that M03-E5 and M03-F2 are the programme's two
> no-output-word classes, and "a defect in the shared no-output path would have
> to be scored against **both** to be understood". `WO-0050`'s **F-c8** was the
> diff written to test that, and it killed **M03-E5 alone**. **The disposition
> is UNTESTED, not refuted**, and the discriminator is on the record in the
> seeder's own disclosure rather than in the result: the auditor seeded the
> in-word half of §9's pin whole and **deliberately left the other half undone**,
> under WO-0050 §2's standing spec-collision clause, disclosing the narrowing
> before any run. So M03-E2 and M03-F2 stayed green **because their pin was
> never displaced**, which says nothing either way about whether it is shared.
>
> **Two consequences bind future work.** (a) **No packet may cite WO-0047
> §1.2's shared-no-output-path claim as established** — it is a claim I made
> about the design, from a DV packet, without an instrument, and the first
> instrument that could test it did not. (b) **The untested half is owed a
> campaign class, and it is not structurally unseedable — it was unseedable in
> the direction I pinned.** My F-c8 intent specified the displacement as
> "earlier by one, not later, and not by two", which bought an exact sealed
> message (`Y − X = 1`) and cost the coverage the class existed for. **A future
> class states the observable — the epoch-A no-output-word report moves by one
> cycle — and leaves the direction to the seeder, disclosed.** The trade is
> worth naming because I made it without noticing: **message exactness and class
> coverage were in tension and I paid coverage for exactness.**
>
> **Item 6, added 2026-08-04 (`J-dv_lead-0102`, `WO-0063` §5 and §8 item 3) —
> OPEN TO architect_docs_lead: is requirements.md §0.6's `[W, W + 3]` window
> normative for M03's no-output-word reports alongside SPEC-M03 §9's exact pin,
> and if so, is a report at `W + 3` conformant under §0.6 while non-conformant
> under C-14.3?** The two texts disagree by exactly one cycle on the same event.
> **What made the question worth asking is an instrument fact, and it is stated
> here so a planner meets it before a scorecard does**: the standing
> `Strobe_monitor` (§2's obligation 4, attached to *every* M03 unit) checks a
> report against §0.6's window **and** against the pin the bench hands it. Only
> the **window** half is blind to a one-cycle deferral to `W + 3`: the pin half
> matches exactly on `(strobe, cycle)` and fails at every unit registering a
> no-output-word expectation. So the monitor is **not independent** here rather
> than blind — it re-checks a number the bench derived — and **no assertion
> anywhere in this bench reads a report against C-14.3's bound except this
> row's window**. (`WO-0063` §5 stated this as blindness; that is too strong and
> is corrected here before any bench carried it — `J-dv_lead-0102`.)
> M03-I2's member (iii) is the first row in this plan whose boundary is
> **C-14.3's** rather than §9's, which is why it is the row that meets the
> disagreement. **No row moves on the answer, in either direction** — member
> (iii) asserts C-14.3's boundary and deliberately does not assert §9's pin, and
> M03-F2 and M03-E5 assert §9's pin and say nothing about §0.6 — so this is
> recorded as a question and not as a blocker. What the answer changes is the
> **reach of the standing monitor**, and therefore what any campaign may claim
> about how widely a report-path class is detected.
>
> **ITEM 6 IS CLOSED — answered at `a12ac8f`, transcribed here 2026-08-05**
> (`J-dv_lead-0109`, commissioned at `WO-0063B-VERDICT` §9 item 1.2). The
> closure was found by the `J-dv_lead-0105` citation sweep and **held back from
> this file** because the plan is phase B's contract and the campaign's seal was
> frozen against it; moving the contract between a seal and its scoring is what
> that round's own ordering rule forbids. **The campaign has scored, so the hold
> expires here.**
>
> **The answer.** requirements.md **§0.6** at `a12ac8f` rules that C-14.3
> *"bounds output **words** and not strobes"*, and that on a frame emitting no
> output word it *"contributes a scan boundary at the same cycle rather than a
> second rule about strobes."* So the two texts never disagreed about a
> **strobe** at all. The **boundary** at `W + 3` is C-14.3's — that citation is
> correct wherever a site names the *boundary* — and the rule a pulse at or
> after it violates is **SPEC-M03 §9's pin (`W + 2`) read against §0.6's ceiling
> (`W + 3`)**. A report deferred to `W + 3` is **inside §0.6's window and off
> §9's pin**: a §9 violation, not a C-14.3 one.
>
> **The consequence for this plan's own phrasing, stated rather than edited in.**
> The question's sentence *"no assertion anywhere in this bench reads a report
> against C-14.3's bound except this row's window"* is **loose in the direction
> that flatters**, and its closed form is: **M03-I2's member (iii) carries the
> only strobe scan in this bench whose boundary is taken from C-14.3's drain
> bound rather than from a bench-supplied §9 pin** — the boundary is C-14.3's,
> the violated rule is §9's read against §0.6's ceiling. The same repair landed
> in the bench's own message strings at `J-dv_lead-0105`, with one **deliberate,
> documented exception** at `run_i2_member`, whose string is quoted verbatim in a
> frozen seal and may not move until that seal is superseded or retired.
> **The question's own words are NOT rewritten**: editing a dated question into
> its answer's language destroys the record of what was asked, and an answer
> belongs beside a question, dated (`J-dv_lead-0105` §6).
>
> **No row moved on the answer, in either direction**, exactly as the question
> predicted — and the campaign run under it is the evidence: member (iii) raised
> on its own boundary scan carrying the citation in its repaired form, character
> for character with the sealed cell (`WO-0063B-VERDICT` §1.1).

## 9. Change log

| Date | Change | Author |
|---|---|---|
| 2026-08-02 | Created (WO-0027). **73 rows** across 15 families (A 5, B 4, C 4, D 4, E 4, F 5, G 6, H 4, I 6, J 4, K 3, L 6, M 9, N 4, O 5) — 55 ASSERT, 7 NO-ASSERT, 4 NO-STIMULUS, 2 RULING, 1 GAP, 4 STRUCTURAL; the format defined in §0–§1 becomes the template for every later `AP-`. | dv_lead, `J-dv_lead-0013` |
| 2026-08-03 | **WO-0030, on the SPEC-M03 revisions WITHHELD at `541ea43`.** **No row converts**, and the reason is recorded rather than the conversion: both rulings are endorsed, but the text they land in carries two defects — a false universal in §6.1's consequence 1 (**M03-R1**) and §9's strobe-cycle sentence pinning a no-output-word frame to two different cycles when its ending character lies in its own start word (**M03-R2**, which already reaches the committed ASSERT rows M03-B2 and M03-B3). **M03-N2** stays RULING with the ruling recorded, the four sub-cases enumerated and the report cycles derived from §6.1's own m + 3 formula — including the correction of the architect's own correction of dv's original claim: the two strobes coincide in **three** of the four sub-cases and are one cycle apart only for a lane-0 `/S/` aborting a frame that delivered at least one octet. **M03-N4** stays RULING with the ADR-0014 reading endorsed and its conversion **pre-committed, unchanged**, at the re-countersignature. **M03-N3** stays NO-STIMULUS, now citing SPEC-M03 §6.1 and §10's REQ-016 hook instead of an inference, with **C-45** on the constraint's over-breadth at a lane-0 start; X-4 carries the same. **M03-O2** cites its landed §10 repair. §6's REQ-102, REQ-105, REQ-110 and REQ-802/REQ-810 rows gain the N-family entries they were missing. Status counts unchanged. | dv_lead, `J-dv_lead-0015` |
| 2026-08-03 | **WO-0031, on the R1/R2 repair COUNTERSIGNED at `06c1eba`.** Confinement verified across the whole tree, not only the claim: `docs/specs/**` moves in one file and **three hunks** — §6.1's consequence 1, §9's "Strobe cycle, pinned", one appended §13 row — and `docs/gates/**` only under the orchestrator's own trailer. **M03-N2 RULING → ASSERT** with the cycles taken from §6.1's landed table (which matches this plan's row for row) and re-derived by the specification's **second** route, §7's per-octet constant `U + ⌊(k + L)/8⌋`, which is gap-invariant where `m + 3` is not; the row is restated as **six** sub-cases, the coincidence count as **three of six**, and the coincidence column recorded as injection-proof so the row may run inside the M03-I4 wrapper. **M03-N4 RULING → ASSERT**, unchanged, exactly as pre-committed at WO-0030. **Self-correction against my own WO-0030 prose** (the architect flagged it and I concur): "three of the four sub-cases" and "one cycle apart only for a lane-0 `/S/`" collapsed the aborted frame's own start lane out of a three-axis classification and then quantified over the collapse, absorbing the (lane-4 `/S/`, lane-4-started A) row; the **table** was always right and the row above is left standing rather than tidied, per this programme's own rule for a recorded miss. New ledger row **C-47** proposed on §9's rows 8/9 (offered by the architect, accepted and rewidened to name requirements.md REQ-110 as a second site). Counts: **57 ASSERT, 7 NO-ASSERT, 4 NO-STIMULUS, 0 RULING, 1 GAP, 4 STRUCTURAL** (73 rows, unchanged). | dv_lead, `J-dv_lead-0016` |
| 2026-08-03 | **WO-0033, the machinery.** All five of §7's items are **built** and no row of this plan is now blocked on machinery. **X-1** `test/xgmii/injection.ml` — the error-injection catalogue, whose expected §9 outcome is **computed** by running §6.2's state machine and §9's closure list over the emitted octet-time line rather than tabulated, so §6.1's two-events-in-one-word cases are ordinary and a frame the *stimulus* opens gets an outcome too; its strobe cycles come from §7's per-octet constant and §9's no-output-word clause, both gap-invariant, so the outcomes survive idle injection under `Idle_injection.cycle_of` and the WO-0031 scope note applies unchanged. `test_injection.ml` drives §6.1's consequence-1 **minimal witness** and confirms both reports on **W + 2** with different names — the row M03-N2 exists for and the one dv's own WO-0030 prose got wrong. **X-2** `test/xgmii_probe/` (drive and sample, both directions of the boundary). **X-3** `test/monitors/strobe_monitor.ml` — C-23 high-cycle counting, the §9 pinned-cycle comparison, the §0.6 window checked **against the pin itself** (a pin outside its window is a *specification* defect, the M03-R2 class), and "no strobe the stimulus created". **X-4** `test/xgmii/idle_injection.ml` — §10's 0, 1 and 7 cycles, carrying the **M03-N3 constraint as repaired at `06c1eba`**, refusing exactly one boundary per frame at both start lanes, with **C-45**'s lane-0 instances named in `c45_sites` and released only by `~allow_c45:true`, which defaults false and may be set only if C-45 lands. **X-5** the per-frame output extent on `Octet_time.Latency.frame_out` (one repair, shared with M14's X-9). **Standing limit, stated so no packet blurs it**: X-1's outcome model is cross-checked against this plan's hand-derived rows and is **not** the charter §3 external anchor — that is the verilog-ethernet differential co-sim, and no `SO-xgmii_rx_64.md` PASS may rest on the model until it has run. Status counts unchanged: 57 ASSERT, 7 NO-ASSERT, 4 NO-STIMULUS, 0 RULING, 1 GAP, 4 STRUCTURAL. | dv_lead, `J-dv_lead-0017` |
| 2026-08-03 | **WO-0035, on the SPEC-M03 additions COUNTERSIGNED at `1fe71ca`.** Confinement verified against the tree: 8 hunks, 2 files, nothing outside `docs/**` and `agents/handoffs/**`. §9's **ruling 9** — `error_bad_fcs` NEVER below 5 received octets — endorsed; the architect's content-free-class ground reproduced independently (`zlib.crc32(bytes(4))` = `0x2144df1c` = REQ-304's residue, and it is the **unique** 4-octet member; at 0 octets §6.1 item 1's seed `0x00000000` is what item 4 would compare). **CREATES one row, and NOT the one the Return log named**: the ruling's row is **M03-M10**, because **M03-M9 is already taken** by the §0.6 inheritance row this plan cites in its own §5 — the architect protected §9's *ruling* indices by appending last and then proposed a colliding *row* index; the M-family index/ruling correspondence therefore ends at 8 and §4.M now warns of it. **STRENGTHENS three rows from a lower bound to an exact strobe set**: **M03-F2** and **M03-B3** ("exactly one `error_runt`" → *and no other strobe of any kind*), and **M03-N2**, whose zero-delivered sub-cases now assert exactly {`error_start_without_terminate`, `error_runt`} and nothing else. **One anti-vacuity constraint added that the ruling's own ground implies and neither packet stated**: M03-F2's 4-octet frame SHALL NOT use an all-zero filler, since that single frame passes a wrong design by accident — the content-dependence the ruling names is also a hole in the bench that tests it. Converts nothing; kills nothing; 0 RULING remain. New counts: **58 ASSERT**, 7 NO-ASSERT, 4 NO-STIMULUS, 0 RULING, 1 GAP, 4 STRUCTURAL (**74 rows**). Ledger **C-49** and **C-50** raised, both non-blocking, C-50 against text I signed myself at `06c1eba`. | dv_lead, `J-dv_lead-0020` |
| 2026-08-05 | **BUG-0001's fix round: one row added, no row changed.** New row **M03-C5** — 1513- and 1516-octet frames at both start lanes, commissioned by dv_lead's locked prediction **P-1** in `BUG-0001` and by rtl_lead's **R-1**. It exists because BUG-0001's invariant (`excess = max(0, k − 4)`, k = the final output word's fill) is a rule about the *last word*, not about frame length, and every length that found it lay in 64…71: a fix that repairs the neighbourhood rather than the rule passes M03-C1 and fails M03-C5. **1516 at lane 4 carries terminate_lane = 0 with a full final word** — the second instance of the class in which R-1 says the closure is unobservable at `~clock_edge:After`, so the same row tests the sampling-position account away from length 68. **Also recorded, for families D–H's planning** (§8): rtl_lead's open question 2 — a strobe consumed from an age-0 closure record is invisible at the current sampling position, and in the error-injection families that coincidence is common rather than 1-in-16. Row and status counts: **75 rows**, 59 ASSERT, 7 NO-ASSERT, 4 NO-STIMULUS, 4 STRUCTURAL, 1 RULING→ASSERT. | dv_lead, `J-dv_lead-0032` |
| 2026-08-06 | **WO-0039's mutation campaign, adjudicated (`RV-0039-VERDICT`). No row added, no row converted, no status count changed** — the campaign qualified the *instrument*, and this plan records only what it taught about the bench. §7 gains a **staleness banner**: its five items were built at WO-0033 and it reads as a gap list, which is the same failure mode (a stale inference left standing) that cost the campaign finding F-2. The banner also promotes WO-0033's standing limit to where a planner will see it — **X-1's outcome model is not the charter §3 external anchor, so families E–H are gated on the verilog-ethernet differential co-sim for sign-off, and family D is not**, being hand-derivable from §9. §8 gains four standing facts for D–H: the corrected **three-of-nine** timing-blindness count (the "five of nine" figure from `J-dv_lead-0035` is **withdrawn**, falsified by mutation M1); the rule that a `check_disagreement_matches_r1` firing routes to re-deriving the sampling model and never to adjusting the oracle; **M03-A3's blindness to lane-symmetric errors recorded as UNTESTED** (mutation M3 took the other branch); and the live hole that **REQ-104's positive direction is unverified — a design hardwiring the FCS verdict good passes all fifteen WO-0038 tests**, which is why **M03-D1** leads the next wave. Counts unchanged: 75 rows, 59 ASSERT, 7 NO-ASSERT, 4 NO-STIMULUS, 4 STRUCTURAL. | dv_lead, `J-dv_lead-0037` |
| 2026-08-06 | **Family D corrected before it was benched, and WO-0040 issued against the corrected row.** **M03-D3's stimulus ordering was wrong for its own declared kill**: with a bad-FCS frame first, a design that reads the CRC register at the `tlast` cycle reads the next frame's fresh `Preamble` seed, which differs from REQ-304's residue, and reports **bad** — the same verdict the correct design gives, so the row passed vacuously against the design it names. Found by working the octet-time arithmetic while authoring WO-0040 (terminate at octet time 80 = cycle 10; `tlast` at cycle 11; `ifg` = 12 puts the next start at octet time 92 = **cycle 11**), not by running anything. The row now drives **both orderings at both lanes** — **pair A (good then bad) carries the kill**, and pair B is retained because it kills a design that latches the abort bit across frames. **Also recorded**: `J-dv_lead-0037`'s claim that M03-D1's lane-0 case is "in the age-0 class" is **loosened to what is true** — lane-0/64 shares `terminate_lane` = 0 with R-1's class but is excluded from it by `expected_disagree`'s full-final-word conjunct; the distinction that survives is whether the terminating word carries frame octets (lane 0: none, and §6.2 **holds** the frame; lane 4: four). No family-D row depends on an age-0 record, since §9 pins each strobe to the `tlast` cycle, one cycle after the terminate word at both lanes. Row and status counts unchanged: 75 rows, 59 ASSERT, 7 NO-ASSERT, 4 NO-STIMULUS, 4 STRUCTURAL. | dv_lead, `J-dv_lead-0038` |
| 2026-08-10 | **WO-0041's family-D campaign adjudicated; M03-D3 corrected a second time.** 4 of 4 killable mutations killed, each with the exact message frozen before the run; **D-M3 ruled an EQUIVALENT MUTANT** — proven, not conceded — so this row's headline kill ("a design that reads the CRC register at the `tlast` cycle") is **withdrawn as unachievable** and the carried-verdict property is reclassified into **M03-D4's NO-ASSERT realisation class** (§6.3 item 1). The proof is a margin computation over every legal (terminate lane, start lane, gap ≥ 9) combination: the next frame's start cycle is never strictly before this frame's `tlast` cycle, tightest margin exactly 0. **dv_lead's own WO-0040 §4 correction to this row rested on the same falsified premise** (that the seed is visible on the cycle it is triggered) and is corrected here, as is the sealed prediction that T-D2 and T-D3 would redden under D-M3 — **falsified, left standing in the freeze**. Row retained as ASSERT on its surviving observables (no abort-bit leakage between frames; per-frame verdict and strobe attribution across the minimum gap) with its qualification recorded INCOMPLETE pending **D-M6**. Row and status counts unchanged: 75 rows, 59 ASSERT. | dv_lead, `J-dv_lead-0044` |
| 2026-08-11 | **Family D's qualification CLOSED (`RV-0042-VERDICT`).** Six seeded RTL defects across WO-0041/WO-0042: **five killed, every one in its frozen row set with its frozen message; one (D-M3) proven an equivalent mutant over the whole legal stimulus space; zero findings** — no unnamed unit reddened and no named unit spoke through an unexpected assertion, in six diffs. **D-M6 (latch `tuser`[0] once set) killed M03-D2 and M03-D3**, discharging M03-D3's surviving declared kill and settling its ASSERT status on evidence, per dv_lead's pre-commitment that the single diff would decide it. Family D's four rows are the **first in this plan to be discharged by a mutation-qualified instrument**, which makes **REQ-104 the first requirement in the programme verified in both directions** — a bad FCS marked and reported, a good FCS left clean — **bounded to frames of 5 or more received octets**, since §9 ruling 9's sub-5 class remains asserted by nothing and is owed to family F. Row and status counts unchanged: 75 rows, 59 ASSERT; **16 rows now benched, 13 of the 59 ASSERT rows discharged**. | dv_lead, `J-dv_lead-0047` |
| 2026-08-15 | **Family E's qualification CLOSED, and one row ADDED (`RV-0045-VERDICT`).** Five seeded RTL defects, **all five killed, each in its sealed row set with its sealed message, 7/7 REQUIRED and 68/68 MUST-STAY-GREEN, zero findings** — and the twelve pre-family-E units stayed green under every mutant, which is the claim family E was written to make. First campaign under the **intents-public / mapping-sealed** compromise, so all five carried full blinding and no discount applies. **E-c5** — the abort detected and never reported — was invisible to thirteen of fifteen units and, before family E existed, to the entire suite: **REQ-105's silently-always-pass closure**. **NEW ROW M03-E5**, the preamble-position `/E/` at a lane-0 start, found by the blinded seeder reading the design and recorded during the campaign but added only after scoring. **REQ-105 is now verified in both directions by a mutation-qualified instrument**, bounded to: the mid-frame word at octets 24–31 and the first-octet position (not every offset); frames whose abort is reached on the epoch-A path (M03-E5 covers the in-word path and is unbenched); and M03-E1's fail-fast, which means a kill demonstrates the row convicts at its first case rather than at all sixteen. Counts: **76 rows, 60 ASSERT** (was 75/59); **20 rows benched, 16 ASSERT rows discharged, 44 outstanding**. | dv_lead, `J-dv_lead-0054` |
| 2026-08-21 | **The REQ-901 cascade ruled, on the architect's notification of `62c39a7`. NO ROW CHANGES — not a stimulus, not an observable, not a kill, not a status, and not a count** — and that answer is defended rather than asserted: SPEC-M03's own §13 row classes the edit as *verification-column only, no normative text moves*, and I checked the classification rather than take it (§6.1, §6.2, §7 and §9 byte-unchanged; REQ-107 and REQ-108 mean what they meant; every directed frame already commissioned stays commissioned). **What the cascade does move is what a sign-off packet may CLAIM, and three things in this plan said the wrong thing about that.** **(1) §7's anchor paragraph** — its per-family sentence is **WITHDRAWN** and replaced by two explicitly separate bars: the **X-1 bar** (per *row*, and satisfied by every row benched to date, which is `J-dv_lead-0048`'s correction finally written where a planner reads it) and the new **REQ-901 bar** (per *requirement*: for REQ-107 and REQ-108 a co-simulation result is not an admissible anchor **at all**). Read literally the old sentence held families F and G's sign-off hostage to a run that cannot discharge them, and a packet satisfying it would have offered precisely the anchor §10 now forbids — so this was a live contradiction with a SHALL NOT, not a staleness. **(2) §6's coverage map** gains a **REQ-901** entry: §10 gained a REQ-901 row, and without the entry §6's own stated rule ("every REQ SPEC-M03 §10 lists appears exactly once") was false. **(3) §4.F and §4.G gain family notes** carrying each class's exclusion scope, in the same form and for the same reason the architect put pointers on §10's REQ-107/REQ-108 hooks rather than resting on the REQ-901 row alone — a reader working from a family reads the family. The notes record what the narrow scope **buys**: (e) leaves payload and `tkeep` compared at 5-to-63 octets, so **M03-F1's REQ-103 half stays co-simulation-anchorable** while its REQ-107 half does not; and (f)'s boundary falls **exactly between M03-G2's adjacent pair**, leaving the legal member anchorable and the oversize member anchorable in nothing. Also stated once, in both notes: the five strobes are outside the comparison domain **campaign-wide** because the reference has no counterpart to §9's taxonomy (`J-dv_lead-0049`) — a fact about the lane, not an effect of (e) or (f), and not a licence to read any row as excluded on that account. Counts unchanged: **76 rows, 60 ASSERT**, 7 NO-ASSERT, 4 NO-STIMULUS, 4 STRUCTURAL, 1 GAP. **Deliberately landed BEFORE family F's qualification freeze**, in its own commit, so the ordering is a fact in history rather than a claim in a packet: the campaign seals against the plan, and the plan must already be right. | dv_lead, `J-dv_lead-0060` |
| 2026-08-05 | **REQ-108's window has TWO epochs and this plan drove only one — two rows ADDED, two scoped (`RV-0055-VERDICT` FINDING G-2, `WO-0056`).** WO-0055's **G-c4 mutation survived all twenty-five units**, which is how the gap was found: a row that tests the wrong half of a window is green on every correct design and is indistinguishable from a row that works. **The correction that shaped the repair is against my own verdict.** `RV-0055` §4 called M03-G3's and M03-G4's characters *outside* REQ-108's window; **they are inside it.** REQ-108's own sentence runs the window from the truncation point to **the next start character** and says "neither a terminate character nor an error character reopens it", so the oversize frame's own terminate is **within** the window. I had conflated REQ-108's window — a **stimulus interval** fixed by the specification — with the `Discard` **state**, which §6.3 item 6 and M03-G5 make explicitly **unobservable**; they are different objects, and it is the same error in kind as the two sealed branches that convicted me at `J-dv_lead-0070` (reasoning about a state where the text gives a position). **The finding survives, differently shaped**: the window's **first epoch** runs from the truncation point to the frame's own terminate, its **second** from that terminate to the next start character, and every existing row drove the second. **So the repair is an ADDITION, not an offset change** — moving G3 and G4 earlier would buy the first epoch by giving up the second, and net zero is not a repair. **NEW: M03-G7** (a start character in the first epoch, carrying the resynchronised frame's own disposition as part of its observable, with an ASSERT → RULING contingency pre-committed if that disposition proves underivable) and **M03-G8** (an error character in the first epoch, the row that lifts the standing consequence). **Both are specified as octet-time intervals with both ends derived — content 1519 … 1599 for the 1600-octet frame, subject to REQ-101's `c ≡ 0 or 4 (mod 8)` — and neither asserts anything about the receiver's internal state**, which §6.3 item 6 forbids and which is the discipline `J-dv_lead-0070` adopted after a state claim I made without deriving it. **SCOPED: M03-G3 and M03-G4** keep their ids, stimuli and observables and have their `Kills` cells cut back to the second epoch, the half they actually cover — a correction of a claim, not a retirement, and G4's second-epoch case is expressly *not* redundant with M03-E4's since the receiver reaches it through a truncation. **M03-G6 gains a note**: its frame has no terminate, so its whole window is the first epoch and it was the only row reaching there. §6's REQ-105, REQ-108 and REQ-110 rows carry the epoch split. Counts: **78 rows, 62 ASSERT** (was 76/60), 7 NO-ASSERT, 4 NO-STIMULUS, 4 STRUCTURAL, 1 GAP. **Landed in the between-campaigns window with no campaign open and no denominator in motion**; these rows enter a denominator for the first time at the next freeze, and **WO-0055's seal — including its two falsified G-c4 branches — stands unedited**, a mapping being re-derived fresh against the bench as it then is, never retro-fitted. | dv_lead, `J-dv_lead-0072` |
| 2026-08-03 | **Family F's qualification CLOSED, M03-E5's with it, and the round's most useful output is a negative (`RV-0050-VERDICT`).** Eight seeded RTL defects: **8 of 8 killed, 19 of 21 REQUIRED cells, 138 of 139 MUST-STAY-GREEN, every message sealed verbatim or a sealed admissible alternative, no `fail_cross`, no build-level finding** — and **three of the four deviations were against my own seal, not against the bench**. **No row added, no row converted, no status count changed**; the campaign qualified rows that already existed. **M03-F2** gains two bounds: its second declared kill (the FCS-strip underflow) is **CONFIRMED ACHIEVABLE, not withdrawn** — `RV-0047` §5(3)'s pre-commitment fired in the row's favour and no spec diff is owed — but the row **convicts it without diagnosing it**, because F-c3 and F-c6 produced byte-identical bench output; and its reach against the *emitting* classes is **k ∈ {1, 4}**, since a zero-octet frame gives an emitting defect nothing to emit while the *suppressing* class F-c5 convicts at k = 0 exactly as sealed. **M03-E5** is qualified by F-c7 — **nineteen of twenty units blind to it, twenty of twenty before the row existed** — which is REQ-105's in-word closure measured. **§8 item 3 is SUPERSEDED**: M03-A3's blindness to lane-symmetric errors is no longer UNTESTED but **measured, and it is blind** — F-c2 moved `tuser` identically at both lanes, the compared tuple stayed equal, **M03-A3's own assertion PASSED**, and T-A34 reddened through its strobe monitor instead. No packet may credit M03-A3 as a content check. **§8 gains item 5**, the round's negative: `WO-0047` §1.2's shared-no-output-path claim — my own — is **UNTESTED rather than refuted**, because the seeder disclosed that it seeded only the in-word half of §9's pin under the standing spec-collision clause; the untested half is **owed a future class**, and it was unseedable only in the direction I over-pinned, which is a defect in my intent-writing rather than in the design. **§7's X-1 row is split** into the placement machinery (anchored by nothing, free to use) and the computed outcome model (the oracle, the only half ever gated) — the `J-dv_lead-0048` correction finally written where a planner reads it. Counts unchanged: **76 rows, 60 ASSERT**, 7 NO-ASSERT, 4 NO-STIMULUS, 4 STRUCTURAL, 1 GAP; **25 rows benched, 21 ASSERT rows discharged, 39 outstanding**. | dv_lead, `J-dv_lead-0065` |
| 2026-08-07 | **Family I authored, and one of its rows corrected before it was benched (`WO-0059`).** **M03-I2's stimulus could not reach M03-I2's own declared kill.** §6.1's drain derivation, worked at both ends rather than quoted: with N = 8q + r octets between the start and terminate characters, a lane-0-started frame's `tlast` word leaves **one** cycle after the terminate word for r ≤ 4 and **two** for r ≥ 5, and a lane-4-started frame's leaves **zero or one**. The row's single 64-octet member is r = 0, so a conformant design's last output falls at **+1** while the row asserts silence only from **+3** — and the one-cycle-long drain defect the `Kills` cell names emits at **+2**, in the gap the row never asserts about. That is the **M03-D3 / M03-F2 unachievable-kill shape**, the third instance this plan has carried, and it is repaired the way `J-dv_lead-0038` repaired M03-D3: **before the row is benched, in the same round as the work order that commissions it**, because a campaign seals against the plan and the plan must already be right. **The repair is a second member, not a new row**: a **69-octet** frame at a **lane-0** start — already in M03-C1's directed set, chosen for its residue (r = 5) and not its length — puts a conformant `tlast` **exactly on** the last legal drain cycle, so the defect emits at +3 and dies, **and a bench that mis-derives the bound one cycle tight goes red against a conformant design instead of passing in silence**, which the original member also could not do. The `Observable` cell gains the per-member, per-lane boundary derivation (both lane-0 members share cycle 13; member (ii) at lane 4 is cycle 14) because a bench giving the two lanes one boundary is wrong. **The maximum drain of 2 is reachable only at a lane-0 start with N mod 8 ≥ 5** — derived, and the reason member (ii) names its lane. **No row added, no row converted, no status moved**: 78 rows, **62 ASSERT**, 7 NO-ASSERT, 4 NO-STIMULUS, 4 STRUCTURAL, 1 GAP, unchanged. **Landed with no campaign open and no denominator in motion**, in the same commit as `WO-0059` itself; the row enters a denominator for the first time at family I's own freeze. Recorded in `WO-0059` §1.1 as well, so a reader working from the packet meets the correction before the stimulus. | dv_lead, `J-dv_lead-0082` |
| 2026-08-07 | **The §0.5 + REQ-016 ruling COUNTERSIGNED at `a77017c`, and the four cells of this plan it convicts are repaired in the same commit (`J-dv_lead-0085`). NO ROW ADDED, NO ROW CONVERTED, NO STATUS MOVED: 78 rows, 62 ASSERT, 7 NO-ASSERT, 4 NO-STIMULUS, 4 STRUCTURAL, 1 GAP — counted from the file, not carried forward.** The signature is on **seven checks** rather than on assertion (`WO-0059`'s COUNTERSIGNATURE block): the residue table re-derived independently at both start lanes from §6.1's own octet-time geometry (**later at `r ∈ {0,1,2,3,4}` at a lane-0 start, `r ∈ {0,4,5,6,7}` at a lane-4 one** — exact); §6.1 item 3's survival case checked to be genuinely octet-for-octet rather than merely terminate-sharing (at lane 0 with `r ∈ {5,6,7}` the `tlast` word carries **one, two and three** octets and all of them lie in the terminate's own word, so nothing straddles and nothing is late-decided); the straddle verdicts against §1.1's own **h** column (12, 14, 20 straddle; 8, 0, 8 do not); the ruling's worked `L = 24` example reproduced to the octet time; the **instrument** checked rather than the claim (`Latency.is_constant`'s contract is exactly the predicate §0.5 now forbids demanding, and the committed bench holds it at both sites while keeping `Latency.errors` asserted); REQ-016's repaired column matched line-for-line against what `test_m03_i.ml` actually asserts; and confinement checked across the tree (three files, the named sections only). **One note returned with the signature and withholding nothing (N-1)**: REQ-016's repaired column gates the extra per-octet assertion on a **module**-level property while survival is a property of the **(start lane, residue)** pair — harmless at M03, where §7 makes no such claim, and offered as a clause for whichever WO next opens REQ-016. **Repairs landed here, and three of the four are against text I wrote or signed.** **M03-I4's `Observable`** — it asserted §7's per-octet constant, which no conformant design can satisfy under injection at either lane; replaced by REQ-016's two achievable clauses, (a) the ordered tuple sequence and (b) the per-output-word delay from **D(m)**, with the constant demoted to *measured and reported*. **M03-I5's `Observable`** — its "the gap-invariant quantity is the per-octet constant" was the same false claim stated as a rule; the gap-invariant quantity is the **per-output-event delay from D**, and this row's NO-ASSERT scope widens by one to bar a single per-octet L on an injected run. **M03-N2's `Observable`** and **§4.N's Route 2** — both cited §7's per-octet constant as the *ground* for the two-events-in-one-word table surviving injection; that ground is withdrawn as false and replaced by §6.1's repaired one, each cycle pinned to a **named input word** and read at that word's own injected position. **The table's six rows and three coincidences are unaffected, because they never rested on the constant.** **§6's REQ-005 row loses M03-I4**: REQ-005's constancy is defined on a gapless stimulus, M03-I4's runs are injected and now report rather than assert, and a reporting row discharges nothing. **§7's X-4 note** records the wrapper's first contact with a DUT — two results, both of them the point of building it, and **no behaviour defect in the wrapper across two full readings**. **And the round's other output is a hardware defect, not a plan repair**: **`BUG-0002` (CRITICAL)** — at length 64 / lane 0, at both `k = 1` and `k = 7`, M03 emits the conformant eight words at the conformant cycles and marks **`tlast` on word 0**. M03-I4's `Kills` cell now names the class. **The row's clause-(b) cycle rule PASSED at that word**, so the arrival guard is not what caught it and a row asserting cycles alone would have been green — which is why the repaired cell keeps (a) as a separate assertion instead of folding it into (b). **M03-I4 and M03-I6 are BUILT AND CORRECT and NOT DISCHARGED**; the discharge count stands at **36 of 62** at `4901161`, unchanged from `6001630`, forward 38 and blocked on the fix rather than on any bench work. | dv_lead, `J-dv_lead-0085` |
| 2026-08-07 | **The re-ruled D(m) COUNTERSIGNED at `1f3c04c` (`J-dv_lead-0086`, transcribed in force at `155c9b2`), and the three sites of this plan it convicts are repaired here (`J-dv_lead-0087`). NO ROW ADDED, NO ROW CONVERTED, NO STATUS MOVED: 78 rows, 62 ASSERT, 7 NO-ASSERT, 4 NO-STIMULUS, 4 STRUCTURAL, 1 GAP — counted from the file, not carried forward.** **The repair is clerical by construction**: every replacement sentence was fixed in the COUNTERSIGNATURE block before this commit existed, and this commit only installs it — the same `J-dv_lead-0084` → `J-dv_lead-0085` sequencing, repeated deliberately, because **a ruling not yet in force does not license a repair** and the signature commit therefore touched no plan. **What the ruling is.** D(m) is now **one object for every output word**: the input word carrying whichever arrives first of received frame octet `8m + 12` or the character that closes the frame. The two are exclusive and `N ≥ 8m + 13 ⟺ m < W − 1` exactly, so (a) decides precisely the non-`tlast` words and (b) precisely the `tlast` one; the (b) bullet is **unchanged**, which is why **no `tlast` word's cycle moves at any `k` and no gapless cycle moves at all**. What was replaced is the non-`tlast` bullet, which keyed a word to its **own last octet** — a word that decides nothing, since whether word m keeps eight octets and whether it is its frame's last are both settled by what arrives **after** its octets. **Signed on four independent derivations, not on the ruling's prose** (`J-dv_lead-0086`): the two refutations re-worked by hand **and** the causality test itself swept — over all length pairs N ∈ [5,80] × k ∈ {0,1,7} × both start lanes the replaced rule violates §0.5's causality test **2 268** times (1 620 at lane 0, all `k = 7`; 648 at lane 4) and the ruled D(m) **not once**; `k = 0` invariance checked at **0** deviations from `m + 3` over N = 5…199 at both lanes, with the offsets recovered rather than read (**1** for (a) and **1 or 2** for (b) at lane 0, **0** and **0 or 1** at lane 4) and **0 of 6 630** frames moving their `tlast` word over `k = 0…16`; and the new M03-I4 / M03-I6 pinned cycles re-derived (5, 7, 9, 11, 13, 15, 17, **19** at `k = 1`; 11, 19, 27, 35, 43, 51, 59, **67** at `k = 7`; `tkeep` `FF`×7 then `0F`; `tlast` word 7 only; `tuser` 0). **Three sites repaired, and all three are against text I wrote or signed.** **M03-I4's `Observable`** — it named D as *the input word carrying output word m's last octet* for every non-`tlast` word, the superseded rule stated as this plan's own contract, and it cited §6.1 item 3's lane-0 `r ∈ {5,6,7}` carve-out as a live fact; the first is replaced by the ruled D(m) with the branch equivalence derived, the second by the carve-out's **withdrawal** and by the class tables now **reported** (lane 0: `{16+8k}` at `r ∈ {0…4}`, `{16, 16+8k}` at `r ∈ {5,6,7}` — the **inversion** of what the withdrawn item predicted; lane 4: `{12+8k, 12+16k}`, and `{12, 12+8k, 12+16k}` at `r ∈ {1,2,3}`). **M03-N2's `Observable`** — two false clauses, both withdrawn in terms at `1f3c04c`: the named word is **W in every row**, the two whose octets lie in the word before W included, and idle injection before W therefore moves **both** reports **together** rather than moving the two lane-0-`/S/` rows *earlier*. **§4.N's Route 2** — re-based to **W**; its `U + ⌊(k + L)/8⌋` formula is a **gapless** derivation of the offset and is untouched, and gapless the two readings coincide (`U + 2 = W + 1` at a lane-0 `/S/`), so **the six rows and the three coincidences do not move** and only the injected reading changes. **One finding is outstanding against the ruling and it is recorded here because a bench will meet it before the architect answers it**: `J-dv_lead-0086`'s **FINDING F-1** — SPEC-M03 §6.1 item 2's *"every output word, at a lane-4 start"* is false for the `tlast` word at seven of eight lane-4 residues and yields a **third** latency class `{12, 12+8k, 12+16k}` at `r ∈ {1,2,3}`, which is §6.1 derivation 1's own residue table read at lane 4. M03-C1's directed lengths **65, 66 and 67** at a lane-4 start print it. **F-1 cannot move any row of this plan in either direction**, because every one of these values is REPORTED and none is ASSERTED — which is exactly what the `J-dv_lead-0085` repair bought and is the reason the plan absorbs a live spec dispute without a status change. **And one claim of mine died this round, in my own packet**: `BUG-0002` §2.3 called the design's measured word-0 cycle 4 the first hardware confirmation of §6.1's D(m); the conformant value is **5** at `k = 1` and **11** at `k = 7`, the design reached 4 through the emptiness test that packet convicted, and **a guard passing is not evidence for the rule it encodes when the design under it is already known to compute that guard's quantity by the wrong mechanism.** **M03-I4 and M03-I6 remain BUILT AND NOT DISCHARGED**; discharge stands at **36 of 62**, unchanged, and the bench repair this plan now licenses is predicted to take the red count from 2 to **36** — all at word 0, `expected − observed = k`, every `k = 0` member green — before rtl_lead's elastic-emission round lands. | dv_lead, `J-dv_lead-0087` |
| 2026-08-07 | **Family I DISCHARGED at `b848d56` + promotion, and the plan's own carried debt paid: `RV-0060-VERDICT` §6's no-row ruling now sits on the plan's record and not only in a journal (`J-dv_lead-0094`). NO ROW ADDED, NO ROW CONVERTED, NO STATUS MOVED: 78 rows, 62 ASSERT, 7 NO-ASSERT, 4 NO-STIMULUS, 4 STRUCTURAL, 1 GAP — counted from the file, not carried forward.** **The carried debt, discharged.** `RV-0060-VERDICT` §6 ruled rtl_lead's escalation 2 (**sub-word granularity** — a word that truncates its own coverage) **no row, and none owed**, and §9 of that verdict recorded that a §9 change-log row was owed "at the next round that opens the plan". This is that round and this is that row: the rejected attack is now on the plan's own record, which is where the auditor mines rejected attacks (charter §8), rather than only in `J-dv_lead-0089`. The ruling is unchanged — a word that truncates its own coverage **covers octets**, so it is a word of the aligned stream and no `bubble`-class question reaches it; rtl_lead's `b848d56` fix deliberately does not touch that configuration and it stands exactly as it did at `fafb83d`. **Family I's two red rows are green.** **M03-I4** (48 injected runs + 16 baselines, both start lanes, `k` ∈ {0,1,7}, lengths 64–71) and **M03-I6** (4 runs, both lanes, 64- and 1518-octet members at `k` = 7) are **DISCHARGED**; M03-I4's **cross-run tail assertions executed for the first time in this program's history** (exactly two front-offset classes, `h` = 8 and `h` = 12, 24 accumulated frames each) and passed. Discharge count **38 of 62**, re-derived from the tree and not inherited from `RV-0060-VERDICT` §9's forward figure: 38 rows named in committed `%expect_test` titles, minus the one titled NO-ASSERT row (**M03-A4**) = 37 ASSERT rows titled, plus **M03-F5** by citation, with **nothing subtracted**. **FINDING F-1 is now MEASURED, and it selects.** The class tables this plan recorded as *reported* at `J-dv_lead-0087` are printed in a committed expect block at `test_m03_i.ml:1348`: lane 0 `{16+8k}` at `r ∈ {0…4}` and `{16, 16+8k}` at `r ∈ {5,6,7}`; lane 4 `{12+8k, 12+16k}`, and the **third class** `{12, 12+8k, 12+16k}` at **`r ∈ {1,2,3}` and there only** — present at the 6 cells F-1 named (lengths 65/66/67 × `k` ∈ {1,7}) and **absent at the 10 lane-4 cells it excluded**. 48 printed cells, 48 agreements with the tables above; the **retired** §6.1 item 3 lane-0 carve-out is refuted at **16** cells and confirmed at none, in exactly the inversion the `J-dv_lead-0087` row predicted. **F-1 still moves no row in either direction** — every one of these values is REPORTED and none is ASSERTED, which is what the `J-dv_lead-0085` repair bought — but it is now hardware evidence against a live clause of a frozen spec (SPEC-M03 §6.1 item 2's *"every output word, at a lane-4 start"*) and is escalated as such. **A DV instrument limit found by rtl_lead and ruled here, with NO row added.** At a **lane-4** start the aligned emission fires exactly `W` times per frame at any `k`, so `delivered_samples`' emitted-word count equals `W` **by identity** and cannot disagree; the `tlast`-position check is blind for the same reason. This is **not** a coverage gap: the defect class already has **two independent kills inside the committed bench** — M03-I4's per-word `tkeep` assertion and its delivered-octet equality — which would have fired at `fafb83d` had an earlier guard not raised first. A row for coverage that exists would inflate the denominator, so none is added; what is owed is a **bench note** at the guard's own sites (`test_m03_i.ml:290`, `:445`; definition `bench.ml:222`) plus a **guard-ordering note**, both landing in the next round that opens `test/xgmii_rx_64/` for editing, alongside `RV-0060-VERDICT` §10 item 3's three citation sites. They are deliberately **not** landed in the promotion commit, whose whole auditability rests on its bytes being identical to CI's. **And one sweep result recorded as a rejected attack**: rtl_lead's `J-rtl_lead-0011` §9.6 item 4 asked whether any unit outside `Idle_injection` drives a whole non-covering word mid-frame at a **lane-4** start — a legitimate second site for the same fix. Swept across all of `test/**`: **none exists.** All 36 expect blocks under `test/xgmii_rx_64/` are `{\|\|}` (these benches assert, they do not print streams), so the discriminator rtl_lead gave — *an old block containing a `tvalid` word with `tkeep` ≠ 0xFF and `tlast` = 0* — selects the **empty set**; `Idle_injection` is referenced by exactly two units, one of which instantiates no RTL; the cosim lane is lane-0-start-only by its generator's own contract; and the single RTL-instantiating unit tree-wide with a non-empty expect block (`test/hardcaml_ethernet/test_word_counter.ml:25`) drives a different module with no XGMII interface. The promotion block listing exactly one file was therefore **the only conformant outcome available**, which makes `BUG-0003` §7 item 2 a tighter trap than it read when written. **`BUG-0003` is FIX ACCEPTED and NOT CLOSED**: `rtl_snapshots/**` regeneration under REQ-902 is unmet for the **second** consecutive RTL change, and the packet's §5 severity conversion to CRITICAL is warranted in substance but rests on rtl_lead's derivation from the RTL, which is not an evidence class DV records a severity on — a transient-tree measurement at `fafb83d` is owed first. `SO-xgmii_rx_64.md` remains unopened and is not offered: 24 ASSERT rows outstanding, family I's qualification campaign unrun, the verilog-ethernet anchor undischarged. | dv_lead, `J-dv_lead-0094` |
| 2026-08-04 | **The two plan edits owed since `J-dv_lead-0098` are paid, and the plan stops speaking twice about the preamble (`WO-0062` §6.2 items 1 and 2, earned by derivation at that packet and deliberately not written by its worker). NO ROW ADDED, NO ROW CONVERTED, NO STATUS MOVED, NO COVERAGE-MAP LINE CHANGED: 78 rows, 62 ASSERT, 7 NO-ASSERT, 4 NO-STIMULUS, 4 STRUCTURAL, 1 GAP** — both edits are **member additions to committed rows**, which §1's row grammar makes a plan edit rather than a new row, and §6 already lists M03-B2 under REQ-102/REQ-105 and M03-B4 under REQ-102/REQ-110. **(1) M03-B4 gains its lane-4 member** — the identical `At_preamble 4` placement at a lane-4 start lands in **lane 0 of the following word**, aborting a frame **already open on entry** to that word with the alignment transition **4 → 0**, the direction `run_h2`'s single point and B4's own lane-0 member (both **0 → 4**) do not reach, and the plan's first preamble-position control character outside its frame's own start word. Note **B-i** carries the octet-time arithmetic for both members side by side: the same 68-octet array, the same 64/60/8/`0x0F` expectation, one parameter of stimulus difference and one cycle of observable difference. It pays `WO-0058` §9 **bound 6**'s owed *direction*; it **does not** pay **bound 7**, which wants an *in-word* abort and gets a lane-0, word-boundary one — recorded next to the payment, because a member that looks as though it closes a bound and does not is how a bound gets quietly dropped. **(2) The M03-B2 / M03-N3 extension conflict is RULED, not split**: M03-N3 said the idle-in-preamble REQ-105 case is *"carried at M03-B2"* while B2's stimulus cell named only `/E/`. **B2's cell widens; N3's sentence stands** — N3 is the later, ruled text (WO-0029 §3b at `541ea43`) and B2's cell is unrevised batch-A text, and, substantively, **`/E/` cannot discriminate REQ-102's third sentence at all** (it routes to REQ-105 both under that sentence and under a design that treats preamble positions as frame positions), where `/I/` separates it from a design carrying REQ-113's outside-a-frame ignore rule into the preamble — a silent discard REQ-008 forbids and nothing else in this plan sees. `/Q/` is **carried and not driven**, on a stated obligation: REQ-102's third sentence admits it extensionally, but this plan has never derived whether REQ-018's contract admits a `/Q/` — the first character of a four-character ordered set — at an arbitrary preamble position, and §3 constrains the lane of `/S/` and of nothing else. Note **B-ii** carries the ruling, the two grounds and three derivation obligations, including that **M03-N3's NO-STIMULUS and its M03-I4 wrapper prohibition are untouched**: these members place a *character* through `Injection`'s `At_preamble`, never an idle *word* through the wrapper. **(3) Note B-iii** records `RV-0062-VERDICT` §6's findings **B-2** (the following-frame `Injection.outcomes` cross-check is five fields deep at M03-B4 and two at M03-B3/B2 — the suite's standing depth, so a debt and not a defect) and **B-3** (both frames in the landed B3/B2 units are `directed_frame_octets ~length:64` and therefore byte-identical, so only the cycle checks discriminate provenance). Both are made **binding on every new member added here** and left as debts on the landed ones, and both are deliberately **not** minted as §2 standing obligations — that would claim a property of rows this plan has not re-read for it. | dv_lead, `J-dv_lead-0100` |
| 2026-08-04 | **M03-I2 gains a THIRD member, and the plan edit lands BEFORE the bench that carries it (`WO-0063` phase A, charter §3). NO ROW ADDED, NO ROW CONVERTED, NO STATUS MOVED: 78 rows, 62 ASSERT, 7 NO-ASSERT, 4 NO-STIMULUS, 4 STRUCTURAL, 1 GAP — counted from the file, not carried forward.** **What this pays.** `WO-0061-VERDICT` §3 and §10 left M03-I2 **NOT QUALIFIED**, and the reason was not a weak intent: **the row's C-14.3 window has never spoken, on either half of its own observable.** The `tvalid` half is **structurally shadowed** — `run_i2_member` asserts every output word's cycle (`start_cycle + 3 + m`) *before* it scans the silent tail, so a one-cycle-late last word always raises at the per-word guard and never at the window, at every member and every lane — and the strobe half is the only unshadowed axis, but members (i) and (ii) are **clean frames that owe no strobe**, so it has never had anything to convict on. The row's sole qualifier to date pulsed at offset **+1**, two cycles outside a window that opens at +3, and reddened on its `tuser` check. **The artefact is a MEMBER, not a row, and that corrects `WO-0061` §12's own footnote** (*"a report-path-delay **row** for M03-I2"*, dv_lead's own words): a new row would carry a **copy** of the silent-tail scan, and qualifying a copy qualifies nothing about M03-I2 — the instrument under test has to be the committed one, driven by this row's own runner family. **Member (iii)**: a frame closed by its **own `/T/`** with **zero** octets received between start and terminate, followed by idle, at **both** start lanes — **M03-F2's `k` = 0 stimulus** (`Injection.corrupt base [Place { At_octet 0; terminate_char }]`), **no new machinery and no new capability**, and **inside** the row's declared observable rather than a widening of it. **The derivation, landed in the Observable cell and stated here so it is diffable**: `At_octet k` lands at `start_ot + 8 + k`, so with `start_ot` 8 / 12 and `k` = 0 the closing `/T/` octet time is **16 / 20**, the closing word **W is cycle 2 at both start lanes**, §9's no-output pin is **cycle 4**, §0.6's window is **[2, 5]**, and **C-14.3's boundary `W + 3` is cycle 5** — a **one-cycle** conformant margin, the same number at both lanes, which is the first member of this row for which that is true. **The trap the cell now names so no bench can inherit it silently**: `run_i2_member` derives its boundary from `Arrival.terminate_octet_time`, which for this stimulus is the frame's **declared** terminate — the auto-placed `/T/` at octet time 80, **cycle 10** — not the injected closing character at cycle 2; a member taking the boundary from that field asserts silence from **cycle 13** and is **vacuous by construction**, with the entire event under test eight cycles before it. Member (iii) SHALL derive its boundary from the **closing character's own octet time** and therefore needs its own runner beside `run_i2_member`, not a new argument threaded through it. **What it deliberately does NOT assert: §9's pinned cycle 4** — that number is M03-F2's claim and M03-E5's, and asserting it here would put a second, tighter instrument in front of the window and reproduce exactly the shadowing the member exists to remove. **The discount is written into the plan and not left in the packet**: member (iii) is the **first unit in this programme authored with its mutation class known**, so a kill here proves the window **can** convict and never that it is a general detector — and the class is **not** unique to this row (`run_f2` asserts the pinned cycle exactly and would redden on the same class at every member and both lanes); **what is unique is the instrument**, M03-I2's window being the only assertion in the bench that reads a strobe's cycle against **C-14.3's drain bound** rather than against §9's own pin. **§8 gains item 6**, an open question to architect_docs_lead that no row rides on: §0.6's `[W, W + 3]` admits a report at `W + 3` that C-14.3 forbids. **And one claim of my own died while this edit was being written, which is the return on writing the plan before the bench.** `WO-0063` §5 said the standing `Strobe_monitor` therefore **cannot see** a one-cycle report-path deferral at any unit; that is too strong. Only the monitor's §0.6 **window** check is blind to `W + 3`; its other two checks match exactly on `(strobe, cycle)`, so the deferral makes the registered event *missing* and the observed pulse *unexpected* and `assert_monitors_clean` fails at **every unit registering a no-output-word expectation** — read from `strobe_monitor.ml`'s own matching, not inferred. The monitor is **not independent**, not blind: it re-checks a pin the bench itself supplied and says nothing about C-14.3. Corrected at both sites in this edit **before any bench inherited it**, and the surviving true claim is the sharper one — **no assertion anywhere in this bench reads a report against C-14.3's drain bound except M03-I2's own window**. **Landed in its own commit, before any bench file is opened and with no campaign seal frozen**, so the ordering — plan first, bench second — is a fact in history rather than a claim in a packet. **Riding with the bench round this commit commissions, and named here so neither evaporates**: `RV-0060-VERDICT` §10 item 3's **three stale `RV-0059-VERDICT §8` citation sites** in `test_m03_i.ml` (the authority for the cycle rule is SPEC-M03 §6.1's D(m) at `1f3c04c`; §8 of that verdict is the rule that was **refuted**), and `BUG-0003` §V.2's **print-only severity probe at `fafb83d`**, whose two numbers hold that packet at **MAJOR** until they return. | dv_lead, `J-dv_lead-0102` |
| 2026-08-05 | **M03-I2 QUALIFIED, and the four plan debts phase B's ordering rule held back are paid in the same round (`WO-0063B-VERDICT` §9 items 1.1–1.5 and item 2; `WO-0063B` adjudicated at `J-dv_lead-0108`). NO ROW ADDED, NO ROW CONVERTED, NO STATUS MOVED: 78 rows, 62 ASSERT, 7 NO-ASSERT, 4 NO-STIMULUS, 4 STRUCTURAL, 1 GAP — counted from the file, not carried forward.** **(1) M03-I2 → QUALIFIED**, on one scoreable class and one kill (1/1): IC-1, a report-path delay with the datapath untouched, reddened member (iii) at lane 0 carrying the campaign's sealed cell **character for character**, from **step 6's C-14.3 boundary scan** (`test_m03_i.ml:847`) with step 9's `assert_monitors_clean` (`:887`) **never reached**, while the IC-2 control left the row green at all three members and both lanes. **The qualification is recorded in the Kills cell and the Status cell stays `ASSERT`, and that is this plan's own grammar rather than a hedge**: §1's status vocabulary is a closed set of six values, `QUALIFIED` is not one of them, and M03-E5's and M03-F2's qualifications already sit in their Kills cells — qualification is a **measured property of the Kills claim**, not a seventh status. **The scope sentence is carried unabridged into the cell**: the window convicts, it is **not** the sole detector; **eight of the nine units detected IC-1 without it**; the authored-with-its-class-known discount stands undiminished; lane 4 is **unobserved**, never a pass and never a miss. **(2) §8 item 6 CLOSED at `a12ac8f`** — §0.6 rules that C-14.3 *"bounds output words and not strobes"* and contributes a **scan boundary** rather than a second rule about strobes, so the boundary is C-14.3's and the violated rule is §9's pin read against §0.6's ceiling; the closure is appended **beside** the question, dated, and the question's own words are **not** rewritten, because editing a dated question into its answer's language destroys the record of what was asked. This is the site held back at `J-dv_lead-0105` when the plan was phase B's contract; the campaign has scored and the hold expires. **(3) The no-output-word registration inventory lands in §2 obligation 4, MEASURED** — nine units, each with its `Strobe_monitor.expect` file and line — **and M03-B4, M03-E2, M03-G7 and M03-H4 each carry the pin in their own cells**, because those four were absent from every enumeration this programme carried from memory (five recalled, nine measured) and a seal frozen against five would have scored four true reds as findings against its seeder. Two corrections ride with it: the *"sub-cases"* vocabulary is withdrawn (each unit registers exactly one), and **M03-G7 and M03-H4 are NOT "monitor-only"** — each has a row-local strobe-order check that speaks first, mis-classified because the sweep searched message *forms* instead of the defect. **(4) M03-N2 HAS NO UNIT IN THIS BENCH** — 17 mentions here, three hits in `test/`, all in library files, zero titles, zero registrations, agreed by two independent sweeps — so §6's REQ-102 and REQ-110 entries now say it supplies no coverage, and §6.3 item 8's carved-out class is **untested because the row was never benched**, not because the carve-out forbids it. **Routing ruled: a bench round, not a capability item and not a row correction.** `Injection.outcomes` already models the two-events-in-one-word class and names this row while doing it, `At_preamble` is driven by committed family-B members, and the row is spec-derived and ruled — so it stays **ASSERT and outstanding**, not converted to `GAP`, which §1 reserves for an attack that cannot be mounted. Until it is benched **no `SO-` may cite it as coverage and no campaign may put it in a denominator**. **(5) M03-D2's unit shares `run_mixed_pair` with M03-D3's** (`test_m03_d.ml:266`, called at `:408` and `:455`), so one runner's `tlast`-pinned registration belongs to two rows; a pass that maps registrations to **enclosing definitions** assigned it to M03-D3 alone and is what put a MUST-STAY-GREEN violation into the IC-2 control. The rule — **runner-to-row is many-to-many; classify from call sites, never from enclosing definitions** — is made mechanical beside `tools/dv_checks.sh`'s inventory report in this same commit, because the file said so **in prose** at `:330` all along and no structural pass can read prose. **The count line, and it moves for a reason that is not this signature.** Discharge stands at **42 of 62**, re-derived from the tree by the `J-dv_lead-0094` method and not inherited: **42** distinct rows named in committed `%expect_test` titles under `test/xgmii_rx_64/`, minus **M03-A4** (a NO-ASSERT row named in a title) = **41**, plus **M03-F5** by citation (`test_m03_f.ml:809`) = **42**, with nothing subtracted; **20 ASSERT rows outstanding** — M03-J1…J3, K1, K2, L1…L5, M1…M7, N1, N2, N4. **`WO-0063B-VERDICT` §9 item 1.1 said this count moves 41 → 42 on the M03-I2 signature; the number is right and the cause is wrong, and the correction is mine to make.** M03-I2's unit has been titled since family I landed, so the row was **already inside** the count, and **qualification measures an instrument — it discharges no row and moves no discharge count**. The move to 42 happened at family B's landing, which titled **four** rows and not three: B2, B3, B4 and **M03-M10**, which shares M03-B3's `%expect_test` title at `test_m03_b.ml:636`. `J-dv_lead-0099`'s forward figure of 41 undercounted for the same reason every corrected figure in this programme has — it was derived rather than measured. **`SO-xgmii_rx_64.md` remains unopened and is not offered**: twenty ASSERT rows outstanding, families J/K/L/M/N largely unwritten, the verilog-ethernet anchor undischarged, and one qualified row is not a module sign-off. | dv_lead, `J-dv_lead-0109` |
| 2026-08-05 | **`RV-0065` BOUNCED, and the four plan edits it owed land anyway — three of them re-grounded rather than struck, because a RED unit has not landed (`RV-0065-VERDICT`, `J-dv_lead-0112`). NO ROW ADDED, NO ROW CONVERTED, NO STATUS MOVED: 78 rows, 62 ASSERT, 7 NO-ASSERT, 4 NO-STIMULUS, 4 STRUCTURAL, 1 GAP — counted from the file, not carried forward.** **(1) FAMILY B IS COMPLETE.** M03-B4's member (b) and M03-B2's `/I/` and `/Q/` members are **DRIVEN** at `88413b9` (`test_m03_b.ml`'s `run_b4b` and `run_b2_new`, both start lanes) and **green** in CI `build` run `30961544649`; the cells say so. B2's Observable cell moves from *"Members (a) and (b)"* to *"(a), (b) and (c)"*, the superseded wording kept beside it. **(2) Note B-ii's obligation 1 is DISCHARGED and `/Q/` is driven**, on `WO-0065` §3.2.1's ruling transcribed here in full: SPEC-M03 §6.2's `Preamble` row and the REQ-102 traceability row (`xgmii_rx_64.md:1197`) each **fix the design's obligation on this exact input, naming `/Q/`**, and a specification that fixes the obligation has constrained the input — so **M03-O5, the only thing holding the sub-member, does not bite**. REQ-018's limbs are a floor, not a ceiling (read closed they would refuse B3's position-5 `/T/` and B2's position-3 `/E/`, both committed and green), and the four-character ordered-set structure that grounded the deferral **is stated in no frozen specification of this programme** — deferring on it was deriving from outside the spec, the opposite failure from the one the deferral guarded. **The correction is dv_lead's own.** What is still refused: these members do **not** test REQ-113's ordered-set case, which stays family I's (M03-I3). The obligation's text is kept below its discharge, because the argument that retired it is only readable against it. **(3) §4.N's closing note and §6's two no-coverage marks are NOT struck — they STAND, re-grounded.** `test_m03_n.ml` landed at `88413b9` with six titled M03-N2 sub-cases, so *"HAS NO UNIT"* is false on its face — but **three of the six RAISE** in run `30961544649` (sub-cases 3 and 6 on `Arrival.check`'s five-octet schedule rule, sub-case 4 on a guard asserting its two reports do **not** coincide where §4.N's own table says they do), and **a red unit has not landed**. The marks move from the ground *"has no unit"* to the ground *"benched and not green"*, and both §6 rows now name what strikes them: a green respawn and a verdict. **No `SO-` may cite M03-N2 as coverage of REQ-102 or REQ-110, and no campaign may place it in a denominator**, unchanged. **(4) The name-count is CORRECTED against its author: 17 → 25 lines / 26 occurrences**, re-measured twice from the tree; the 17 was taken **before the same round's own edits added this closing note and §6's two entries** — a count taken at one state and published about another, the fourth quantity in this programme to move on measurement after being published from derivation or a pre-edit state. Cite the measurement, never the 17. **The count line, measured at both ends and reproducing its predecessor.** Discharge is **43 of 62** at `88413b9` by the `J-dv_lead-0094` titles method (48 titles under `test/xgmii_rx_64/`, 43 distinct rows named, − `M03-A4`, + `M03-F5` by citation), against **42** at `88413b9^` whose outstanding list of twenty reproduces `J-dv_lead-0109` **row for row** — which is what licenses the new figure. The whole of the +1 is **M03-N2**, so `WO-0065` §10's derived 42 → 43 is right **in its number and in its cause**, the first time in four attempts both have held. **But 43 is not yet earned**: the titles census counts **titles, not passes**, and M03-N2's are red, so the **effective** discharge at this SHA is **42**. Both figures are carried in §4.N so no later reader has to choose. **And the census has a defect of its own, found by running it twice**: a naive substring match discharges **`M03-M1` on `M03-M10`'s title**, inflating the count by one and silently retiring an outstanding row — the `M03-M10`/`M03-B3` shared-title problem biting from a **third** direction. The first pass made exactly that error and reported 44. Boundary-matched row ids are commissioned into `tools/dv_checks.sh` with the campaign packet, not here: a review commit is not where tooling changes belong. | dv_lead, `J-dv_lead-0112` |
| 2026-08-05 | **`RV-0065B` ACCEPTED, and the three re-groundings the bounce left standing are now STRUCK by the condition each named for itself (`RV-0065B-VERDICT`, `J-dv_lead-0113`). NO ROW ADDED, NO ROW CONVERTED: 78 rows, 62 ASSERT. ONE STATUS MOVED — M03-N2 to DRIVEN.** The `WO-0065B` revision landed at `eb1e06a`; CI `build` run **`30963617198`** (job `92172708172`) is **success** at both gating steps — `dune runtest`, and `git add -A; git diff --cached --exit-code` — so no `.corrected` file exists and **all six M03-N2 sub-cases are silent against a conforming design**. The three that were RED at `88413b9` (3, 4, 6) are green; the eight that were green stayed green; **11 of 11**. Struck here: §4.N's closing note (*"HAS NO UNIT"*, then *"benched and not green"*), §6's **REQ-102** mark, and §6's **REQ-110** mark. **Both standing prohibitions LIFTED** — an `SO-` may cite M03-N2 for REQ-102 and REQ-110, and a campaign may place its six sub-cases in a denominator, which the family-B/N campaign does as **the first legitimate N2 denominator**. **Superseded wording kept beneath every strike, never deleted.** Two figures land with it. **The discharge count is now EFFECTIVE, not merely titled: 43 of 62** (48 titles under `test/xgmii_rx_64/`, 43 distinct rows boundary-matched, − `M03-A4`, + `M03-F5` by citation) — outstanding twenty → **nineteen**, the whole of the +1 M03-N2; the census is the numerator's provenance and the run id is the adjective's. A **naive substring match returns 44**, discharging `M03-M1` inside `M03-M10`'s title — the trailing-digit boundary is commissioned into `tools/dv_checks.sh` with the campaign packet. And **`WO-0058` bound 7 now has three instances in this plan, distinguished rather than counted**: sub-cases 4 and 5 enter W in **`Frame`** state, sub-case 6 in **`Preamble`** state, all three *open* under §9's closure list. §4.N's *"absence costs"* costing is **discharged**, with limb (b) re-grounded: SPEC-M03 **§6.3 item 8** is still untested, but now because **the carve-out forbids the stimulus** (*"DV SHALL NOT produce one"*), not because the row was never benched — a closed question, not an open coverage item. | dv_lead, `J-dv_lead-0113` *(Author cell SUPPLIED 2026-08-09, `J-dv_lead-0124`: this row was committed with two fields where the table has three. Nothing is rewritten and nothing is replaced — the attribution was always recoverable from inside the Change cell, which names `RV-0065B-VERDICT` and `J-dv_lead-0113` in its first sentence; what was missing was the field. Observed and **reported rather than silently fixed** at `J-dv_lead-0118` item 5(a), repaired under `WO-0067` §11 item 4.)* |
| 2026-08-06 | **The family-B/N campaign is ABSORBED INTO THE PLAN: two rows QUALIFIED, one member recorded scored-and-unconvicting, `WO-0058` bound 7 SCORED and its premise STRUCK, and one standing discipline rule minted (`WO-0066-VERDICT` §10 item 1, six items; `J-dv_lead-0117` adjudicated the campaign, `J-dv_lead-0118` lands the round). NO ROW ADDED, NO ROW CONVERTED, NO STATUS MOVED, NO COVERAGE-MAP ROW GAINED OR LOST A ROW ID: 78 rows, 62 ASSERT, 7 NO-ASSERT, 4 NO-STIMULUS, 4 STRUCTURAL, 1 GAP — counted from the file at `9293ef1`, not carried forward.** **Held back from every commit of the campaign on purpose**: the plan is the campaign's contract and moving it inside the window would have violated `WO-0066` §8's ordering rule. The campaign has scored; the window is closed; this is that round. **(1) M03-N2 → QUALIFIED on four classes, 4/4** — IC-C (the coincidence serialised: 3/3 red, all message-exact, and the three REQUIRED GREENS held, so the class measured the coincidence and not reports in general), IC-B (6/6 with the derived `<n>` = 1, scored on branch **R** alone under the pre-run reading note's **disposition 8, VOID BY DISCLOSURE**, the `W` cells scored in neither direction and never as coverage), IC-E (killed at sub-case 2 alone) and IC-A (sub-cases 4 and 5 message-exact; sub-case 6 red on the other arm of the same check — `FINDING WO-0066-5`, a message miss recorded and **not** absorbed into the kill). **Recorded in the Kills cell with Status left at `ASSERT`**, on `J-dv_lead-0109`'s divergence ruling: §1's status vocabulary is closed at six values and `QUALIFIED` is not one of them. **(2) M03-B2 → QUALIFIED on two classes, 2/2** — IC-D reddens `/I/` **and** `/Q/`; IC-F reddens `/Q/` **alone** and leaves `/I/` green; the `/E/` control held under both. The two classes emit **identical strings**, so the separation rested entirely on running them as separate transients — and **the `/I/`-red-under-IC-D / `/I/`-green-under-IC-F asymmetry is the separating observable**, measured rather than asserted. **Note B-ii obligation 1's `/Q/` ruling is thereby PAID BY MEASUREMENT**: `/Q/` is the only stimulus in this plan that separates routing by the **control bit** from routing by an **enumeration**, and IC-F is where it did it. Lane 4 is **UNOBSERVED** at both rows — never a pass and never a miss (lane 0 runs first and raises; R-DISC-1 discharged per lane). **(3) M03-B4 member (b) → SCORED-AND-UNCONVICTING**, recorded in note B-i as a **result and not an omission**: it sat in all six classes' denominator — one of the eleven never-before-scored members the campaign existed to load — and **killed nothing another instrument had not already caught**, including at IC-A where a red at it would have been a finding against the manifest (`D-A1 = O`, confirmed). **Its value is unchanged and is the one it was added for**: bound 6's opposite-direction **4 → 0** alignment point. Stated in the plan so no later packet reads it as a campaign contributor, and so no `SO-` cites its participation as coverage. **(4) `WO-0058` bound 7 → SCORED 3 of 3, with the state split (sub-cases 4 and 5 in `Frame`, sub-case 6 in `Preamble`) — AND `FINDING WO-0066-6` STRUCK IN, with the superseded wording kept beneath the strike.** §4.H bound 2's premise — *"no row drives an in-word abort with a frame already open on entry"* — **was false at the moment it was written**: `M03-H2` drives a lane-4 `/S/` in a mid-frame word at **both** start lanes, and `M03-H1` at a lane-4 start puts its aborting `/S/` at octet time 84, lane 4, against a frame that has delivered 64 octets; **both landed at `WO-0057`, before `WO-0058` §9 wrote the bound**. What survives is only that `M03-H4`'s word `c` is the bench's only **nothing-open-on-entry** in-word abort. **Consequences recorded at full strength because they cost this plan a claim it was carrying**: the bench was **not** blind to the conjunction, `M03-N2` sub-cases 4 and 5 are **not** its first detectors, and what remains genuinely M03-N2's own is the **`Preamble`-state instance** and the **coincidence geometry** IC-C measures. **Bound 7 leaves dv_lead's carried list here**, under `WO-0066` §4 rule 4, because the plan now records the score, the split **and** the correction — a score recorded without the correction would carry a false history of a true result. §6's REQ-110 entry points at §4.H rather than restating it. **(5) Trap T8's single observability is recorded as PERMANENT and as an INTERFACE PROPERTY, not a bench defect** (`WO-0066-VERDICT` §5.2 on the reading note's ruling 1(c)): T8 is **asserted at two members and observable at one**, because at M03-N2 sub-case 4 the mutant's waveform is **bit-identical** to a conformant design's — §0.6 counts high cycles, and frame A's added `error_runt` lands on the cycle frame B's genuine one already occupies. **An equivalent mutant, not an undetected one, and no bench change reaches it**: the limit is in a strobe interface that reports **presence per cycle and not multiplicity**. **No future packet may claim two-member instrumentation for T8** on the strength of IC-E's kill; the multiplicity question is raised to architect_docs_lead as a **specification** question and not as a `BUG-`. Stated once, in the row's Kills cell where its coverage claims are read. **(6) NEW STANDING RULE, §0.1 — a claim about a SET, carried in prose, must be re-measured at citation or carry the SHA it was measured at.** `WO-0066-3` (a runt floor of five quoted where requirements.md §12 says fewer than 64) and `WO-0066-6` (a census never run because its asserted result read as settled) are **one failure twice**, and the verdict says so. **Filed in §0 and deliberately not in §2**: §2's obligations attach to *every M03 bench* by their own opening sentence, and this rule binds **prose**, not benches — minting it as a seventh bench obligation would mis-file it. **And the tool built in the same round covers neither instance**, which the note says rather than leaving its existence to imply coverage: the boundary-matched census answers *which rows are named in a unit title*, while these were a **row-status/threshold** claim and a **cross-row premise** claim. **`DVC-1` is COMMISSIONED with an executor (dv_lead, in the next round that opens `tools/`) and deliberately NOT BUILT HERE** — `DVC-1a` a row-status census, `DVC-1b` a docstring-declared stimulus-geometry census, the second bounded in its own commission to what docstrings **declare** rather than what stimuli **do**. A plan round is not where tooling lands. **THE COUNT LINE IS UNCHANGED, AND THAT IS THE RULE AND NOT AN OVERSIGHT: 43 of 62, nineteen outstanding.** **Qualification measures an instrument — it discharges no row and moves no discharge count** (`J-dv_lead-0109`, applied to two rows here). Re-measured at `9293ef1` rather than carried forward, by `tools/dv_checks.sh`'s own census block: **78** row ids declared, **43** named in a committed unit title under the trailing-digit **boundary** matcher, **44** under the naive one (over-discharging `M03-M1` inside `M03-M10`'s title, the same defect at a fourth SHA), − `M03-A4` (NO-ASSERT, named in a title) + `M03-F5` (by citation) = **43**; the 62 ASSERT denominator counted from this file's own status cells in the same pass. **No `SO-xgmii_rx_64.md` is opened and none is offered**: nineteen ASSERT rows outstanding, families J/K/L/M largely unwritten, the verilog-ethernet anchor undischarged, and two qualified rows are not a module sign-off. **Nothing in `test/**` is owed by this result** — the **five** MUST-STAY-GREEN violations the campaign produced (three under IC-E, two under IC-A, at **four distinct units**, `M03-H2` violated under both) are the **seal's** errors, not the bench's, and every unit behaved correctly, including every one that reddened where the seal said it would not. | dv_lead, `J-dv_lead-0118` |
| 2026-08-09 | **Six carried plan debts paid in one batched round — four from `WO-0067` §11, one from `WO-0068` §5, one from `RV-0068B-VERDICT` §7 — commissioned at `RV-0068B-VERDICT` §9 item 1. NO ROW ADDED, NO ROW CONVERTED, NO STATUS MOVED, NO COVERAGE-MAP LINE CHANGED: 78 rows, 62 ASSERT, 7 NO-ASSERT, 4 NO-STIMULUS, 4 STRUCTURAL, 1 GAP — counted from the file at `8d8a239` by a status-cell pass over every row table, not carried forward.** **Batched deliberately**: five of the six were single-cell edits parked with named carriers, and a plan round is the cheapest place to pay them, but a round per debt is how a debt becomes a habit. **(1) M03-J2's Kills cell — the stated kill is WITHDRAWN as unreachable under the row's own stimulus**, superseded wording kept beneath the strike. The row's enable goes 0 → 1 *before* the start character and holds at 1 for the whole admitted frame, so a **continuously**-sampling design truncates nothing and is indistinguishable here from a conformant one; that kill belongs to **M03-J3**, whose enable drops *inside* the admitted frame. The **honest kill is named**: a design refusing the first frame after a re-enable, which is what makes §4.3's *"at least one cycle after"* — and therefore the tightest legal placement — load-bearing. **The row stays ASSERT**: its observable is REQ-803's own and REQ-810's verification column commissions it in terms. **The M03-D3 / M03-F2 / M03-I2 precedent applied unchanged, at its fourth instance**, and found the same way all four were — by working the row's arithmetic before a bench existed (`WO-0067` §6, `J-dv_lead-0119`). **(2) M03-J1's Observable cell gains the clause that stops its `frame_in_exempt` demand reading as stale**, each of its three facts read at its own source rather than taken from a packet quoting it: the equation's *presented* term is **zero** by SPEC-M03 §6.1's disabled paragraph; `frame_in_exempt` keeps it zero **by construction while still recording the frames**, because `conservation_monitor.mli`'s **deviation 3** names REQ-810 and puts that ledger *"outside the equation"*; and **ADR-0014's *"needs no new exemption"*, read at its own words, is a claim that the EQUATION needs no new term** — on two grounds, that refused frames are not *presented* and that the **in-flight** frame at M03-N4 balances under its own strobe — not a licence to count a refused frame as presented. **This is narrower than `WO-0067` §11 item 2 asked for and the narrowing is disclosed rather than absorbed**: that item reads the ADR sentence as being about the in-flight frame *alone*, and the ADR's first ground is plainly about the refused frames, so the sentence is reconciled by **what it claims** rather than by **which frame it is about**. The **not-independent caution** rides with the demand: the exempt count is bench-supplied, it counts the unit's own calls, and no `SO-` may read it as evidence that 100 frames were driven — the anti-vacuity control run is what carries that. **(3) §7 gains X-6, the `cfg_rx_enable` schedule, on the X-4 precedent**: **BUILT AND LANDED at `e4df986`** (run `30980439774`), and **its M03-J4 constraint is the deliverable as much as the schedule is** — with a measured instance rather than only the claim. The guard's **entry condition was one transition short of its own subject** and was caught by review, not by a red (`RV-0067-VERDICT` §6.2, a finding against the packet that specified it and not against the code that implemented it verbatim); repaired **at the subject** so the entry test is a projection of it, with a structural witness carrying **no** `M03-` row id, green at `2dbd39b` (run `30988038809`). **§7's "Not gaps" paragraph is UNCHANGED and left unedited on purpose**, with a dated note beside it: measured at `8d8a239`, C-2's exemption has **three call sites in `test/**`, all in `test_m03_j.ml`**, so *"used by M03-J1 and M03-K2"* became true of **J1 for the first time at `e4df986`** and is **still not true of K2**. A requirements statement quietly rewritten into a status report stops being either — which is the failure §7's own staleness banner exists for. **(4) The two clerical residues of `J-dv_lead-0118` item 5 are paid, both of them observed and REPORTED at the time rather than silently fixed.** §4.H **bound 1**'s *"Owed: the second point at REQ-110's commissioned M03-B4 geometry"* is struck: **M03-B4's member (b) IS that point** (the 4 → 0 alignment transition), driven and green at `88413b9`, run `30961544649` — **paid 2026-08-04, stale in its tense from that date until here**. What is **not** paid is the bound's own point about **sweep**: two points are still not a sweep, and the bound is carried for that reason now. And §9's `J-dv_lead-0113` row, committed with **two fields where this table has three**, has its **Author cell supplied** — nothing rewritten, the attribution having always been recoverable from inside the Change cell. **(5) M03-N4's Observable cell records that its PARENTHESISED ZERO-DELIVERED BRANCH HAS NO INSTANCE** — a finding against my own row, derived while authoring the bench packet (`WO-0068` §5, `J-dv_lead-0121`). A zero-delivered abort puts the aborting `/S/` at or before frame A's first octet, i.e. within the nine octet times beginning at A's own start character, so **W is A's start word or its successor**; the enable must fall strictly between A's start cycle and W; and **§6.3 item 7 forbids a change on any start character's cycle**, which A's start cycle is — **no admissible cycle exists at either start lane**. Both escapes are closed by the specification and not by convention: `first_start` ∈ {8, 12} moves A's start and W **together**, and injecting between a start character and its first octet is what **M03-N3** forbids. **The M03-D3 / M03-F2 / M03-I2 / M03-J2 shape at its fifth instance**; the row **stays ASSERT** on its delivering branch, the branch is **unassertable**, and **where the zero-delivered geometry IS covered is M03-N2 sub-cases 3 and 6** under enable = 1. It is **not** a `GAP` row: §1 reserves that for an attack this plan wants and cannot mount, and this is an observable with **no legal stimulus**. The **spec-side half is C-41** and is raised non-blocking with architect_docs_lead. **(6) §4.N gains a LANDED-STATUS block for the whole family, every status word travelling with its SHA and CI run id.** M03-N1 and **M03-N4** are **landed and green at `2dbd39b`, `build` run `30988038809`** — N4 **run to completion for the first time at that commit**, since at both predecessors the unit raised and nothing downstream of the raise had ever executed. M03-N2 landed, green and campaign-scored; M03-N3 NO-STIMULUS with its spec citation and no coverage claimed anywhere. **The census, measured by `bash tools/dv_checks.sh` at `2dbd39b` by me and independently by CI inside the same build**: inventory **54** / **134**, boundary-matched census **48**, adjustments −1 (`M03-A4`) +1 (`M03-F5`) net zero, so **48 of 62** with **14 outstanding — K1, K2, L1–L5, M1–M7** — and 48 + 14 = 62 closes with nothing left over. **The instrument's property is restated rather than allowed to expire with the instance that closed: the census counts TITLES, and a title is not a pass — quote it with a CI run id beside it or do not quote it** (`RV-0068B-VERDICT` §7). **Three things the green does not buy, stated because silence would let them be assumed**: family J is unscored and family N's scoring predates two of its rows; the M03-J4 guard's driven-word reading is still structurally argued and not demonstrated (M03-N4 enters it and finds nothing, which is a non-violation); and **no `SO-xgmii_rx_64.md` is opened or offered** — fourteen ASSERT rows outstanding, families K/L/M unwritten, the charter §3 verilog-ethernet anchor undischarged. | dv_lead, `J-dv_lead-0124` |
| 2026-08-09 | **FOURTEEN carried plan debts paid in one batched round — eight from `WO-0071` §12 item 2 (re-pinned at `RV-0071-VERDICT` §7 item 2), five from `WO-0072` §18 item 2, and one added by `RV-0072-VERDICT` §5 item 1 — plus `test/cost_probe/`'s undischarged deletion, which rides here because its carrier was re-pinned to a `dv_lead` commit of this window and was never a worker's to pay. NO ROW ADDED, NO ROW CONVERTED, NO STATUS MOVED, NO COVERAGE-MAP LINE CHANGED: 78 rows, 62 ASSERT, 7 NO-ASSERT, 4 NO-STIMULUS, 4 STRUCTURAL, 1 GAP — counted from the file by a status-cell pass over every row table at this commit, before and after the edits, and NOT carried forward. The census is unmoved at 62 of 62 and the inventory at 59 / 139, measured by `bash tools/dv_checks.sh` at `5d2beff`.** **Batched deliberately, and the batch is larger than the last one for a reason that is itself the point**: three families landed between plan rounds and each left single-cell debts with named carriers, so the alternative to one batch is fourteen rounds. **(1) §7's banner gains the PER-CLASS restatement of its own live constraint, and *"until it has run"* is WITHDRAWN as that constraint's statement.** The co-simulation **has** run — Phase 1, `build` run `30988038809` at `2dbd39b`, `cosim` job `92247281222` — so read literally the banner was discharged by a run that drives **one** 64-octet good-FCS lane-0 frame and **injects nothing**, anchoring no cell of X-1(ii), whose subject is injected frames. The condition restated: *no `SO-` PASS may rest on a computed outcome of X-1(ii) for a stimulus class the differential co-simulation has not driven*. It **composes** with the REQ-901 bar rather than colliding with it — that bar names two requirements the lane can never anchor, this one names per class what it has not yet anchored — and it makes `CD-xgmii_rx_64_cosim.md` §6's phase distribution a schedule rather than a list of predictions. Found while writing the Phase 1 adjudication (`J-dv_lead-0125`), which is the round that ran the instrument against its own text. **(2) §7 gains X-7, the `clear` schedule, on the X-4/X-6 precedent: BUILT AND LANDED at `284225d`, run `31032021108`, and the guard is the deliverable as much as the schedule is.** The row records that the subject and the entry condition were **re-derived, not transplanted**, and that the transplant would have been wrong **twice** — the reset polarity is inverted, so a copied boundary-transition prepend would have made every one of the fifty-six landed units enter a walk they do not enter today; and the subject is `high_cycles` rather than a transition set, which is neither the same set nor a projection of it. **A copied guard would also have refused this round's own K2 stimulus**, whose release cycle carries a start character by REQ-009's last sentence. X-7's note also **banks `FINDING K-3`**: *a review bar whose pass condition is a universal over a whole tree or a whole diff must be measured against that tree before the bar is written, or expressed as a delta* — three of seven dv-seat bars in family K's round were false against the tree they pointed at, all three the same way, and executing them once at the base at draft time costs nothing. **(3) §7's "Not gaps" paragraph gains its second dated line and its first CONVICTION.** *"Used by M03-J1 and M03-K2"* became true of **M03-K2 at `284225d`** (through `Bench.account_cleared_frame`, `bench.ml:529`, called by the row's own unit), so the WO-0027 sentence is now true of both rows it names — dates recorded beside it, tense unchanged inside it, per the discipline the paragraph's own first note states. **And the measurement that established it convicts the previous one — `FINDING AP-1`.** The 2026-08-09 note above claims *"exactly three call sites in `test/**`, all three in `test_m03_j.ml`"*; re-measured at `8d8a239`, the commit it names, the figure is **FIVE** — the two it missed are `test/monitors/test_conservation_monitor.ml:161` and `:163`, the monitor's own unit test, and both are calls. At `284225d` and `5d2beff` it is **SIX**. **The conclusion is unaffected and is not withdrawn** (neither missed site is an M03 row's call), but the set claim is false as written, and this is **§0.1's own shape caught at the point of citation for the first time** — before a campaign or an `SO-` rested on it, which is the whole of what §0.1 was minted to do. **(4) §4.K's two ASSERT rows have their Kills cells audited before the campaign rather than after it.** **M03-K1**: *"or that needs a second cycle to settle"* is **WITHDRAWN as unreachable under this row's own stimulus**, superseded wording kept beneath the strike — a late-acting clear is invisible where a conformant design also produces nothing, and a slow-to-quiet design has nothing pending on the release cycle. The **honest kill is named** (a strobe path that survives `clear`, by presenting inside the window or by re-presenting on release, plus an off-by-one leading edge from the control run), the withdrawn class is located **at M03-K2**, and this is the **M03-D3 / F2 / I2 / J2 / N4 shape at its SIXTH instance**, taking the same disposition all five took: the row **stays ASSERT** and what changes is the claim a round may make about it. **M03-K2**: all three kills stand and **the third is RECLASSIFIED from design-kill to monitor-precondition** — the call is the row's own and no design can make it wrong; what the cell states correctly is that C-2's exemption path is a **precondition** of the row, since `frame_in` in its place reds a *conformant* M03. **(5) §4.K, §4.L and §4.M each gain a LANDED-STATUS block, every status word travelling with its SHA and CI run id.** Family K at `284225d` / run `31032021108` — the first units in this suite ever to drive `clear`, census **60 → 62** with the gained set measured **as a set** (`{M03-K1, M03-K2}`, lost set empty) and inventory **56 → 59** / **136 → 139**; M03-K3 stays `NO-ASSERT` and is named in no title. Family L at `630e34a` / run `31015276337` — census **48 → 53** with the +5 pinned **by a negative** (no `M03-L` id in any unit title at the base), the 10 000-frame stimulus **never reduced**, and the cost question settled by measurement (T = 2.036 s at the probe, 4 s at the landed step, 1.16 % of the job). Family M at `70a263f` / run `31022685374` — a **binding** round and not a coverage round: **the inventory does not move (56 / 136 at both ends) while the census moves by seven**, and the diff **writes no expression**, measured by a comment-and-literal-stripping skeleton that is identical at both ends while the raw diffs are not. **The bench era of `Xgmii_rx_64` closes at 62 of 62 and that is ALL it means** — four families are unscored by any campaign, the charter §3 anchor is undischarged per class, and no `SO-` is opened or offered. **(6) §4.M's M03-M6 and M03-M7 Stimulus cells are RE-POINTED — `FINDING M-1` and `FINDING M-2`.** Ruling 6's condition is a start character arriving **during `Discard`** and ruling 7's is an error character arriving in `Discard`; in M03-G3 and M03-G4 the character arrives **after the oversize frame's own `/T/`** (content index 1620 and 1618 against a terminate at 1600), so `Discard` has already been left and the carriers witness the rulings' *conclusion* on a doubly-closed frame. §4.G's own cells say so in terms, and **M03-G7 / M03-G8 were built at WO-0056 for exactly that gap**; §4.M was written before WO-0056 and never re-pointed. **M6 now binds G3 and G7, M7 binds G4 and G8**, both epochs landed and green, so **nothing is owed to `test/**`** beyond the binding — and **no `SO-`, campaign or scorecard may cite M6 or M7 as `Discard`-state coverage on the strength of G3 or G4.** **(7) §4.N's M03-N2 Kills cell has its two clauses made stale by `WO-0069`'s strobe ruling STRUCK AND REPLACED IN PLACE.** *"Presence per cycle and not multiplicity"* becomes **a LEVEL per cycle**, and *"an architect question, raised as one"* becomes **RAISED AND ANSWERED** (`J-architect_docs_lead-0031`, landed `b6ef1cb`, accepted `J-dv_lead-0126`). The ruling: the rule is read on **events**, not conditions, so the cell's operating assumption of presence is **corrected in its subject and confirmed in its consequence**; each event's obligation is a **level**, so two same-name events on one cycle are both discharged by that single high cycle and **the module has conformed**; C-23's convention is the observer's inverse and **under-counts on a shared cycle — the shortfall is in the decoding, never in the design**; and **no multiplicity signal is owed**, on that ground rather than on cost. The equivalent-mutant conclusion is unchanged; what changes is what a packet may say. **The 2026-08-06 change-log row below carries the same superseded phrasing and is LEFT UNEDITED DELIBERATELY** — it is a dated record of what was decided then, not a live requirement, and rewriting a change log is how a change log stops being one; this row is its annotation. **(8) `J-dv_lead-0094`'s change-log row is repaired CLERICALLY and in its rendering only**: it carried two literal `\|` characters inside an inline code span, which GFM reads as cell delimiters, so the row rendered as **five** fields where this table has three. The two are now escaped. **Not one word of that row is changed**, on the `J-dv_lead-0113` precedent (an Author cell supplied, nothing rewritten). **(9) OBSERVATION K-O2 is RAISED AND PAID IN THIS SAME COMMIT.** `Bench.account_cleared_frame` shipped at `284225d` with two branches and **one witnessed**; `Latency.frames_compared = 2` is now asserted in M03-K2's unit, and since `frame_out` increments that counter while `frame_dropped` does not, **2 is the mechanical statement that the abandoned frame was offered to the tagger as a 16-octet output frame rather than dropped**. The row's claims were sound without it and it bounces nobody; what it removes is a brand-new capability shipping with a dead, unwitnessed branch. **The check is this landing's own CI green**, and **no row moves and no coverage is claimed** — the assertion names no `M03-` row id. **(10) OBSERVATION K-O1 is RECORDED and NOT repaired**, with its carrier named: `Conservation_monitor.frame_out ~aborted` documents `aborted` as REQ-007's marking while every landed bad-FCS call site passes `~aborted:false`; nothing compares the two monitors' abort counters, so nothing is red — the repair is a `test/monitors/**` contract question and changing family D's landed call inside a plan round would be the improve-a-carrier move this plan's own trap list forbids. **(11) `test/cost_probe/` is DELETED, and its deletion condition was met on 2026-08-02.** Its own `dune` header set the condition — *"delete this whole directory once the cycles-per-second figure is recorded in a journal entry with its CI run id"* — and `J-orchestrator-0041` recorded 3.42 M / 1.77 M / 653 k cycles per second at CI run `30729880948`. **The directory then sat in the tree for seven days across four carriers**, each of which correctly declined it (a worker's write scope would have convicted an executor of dv_lead's housekeeping). It contains **no `%expect_test`**, so neither inventory figure moves; nothing outside a **comment** in `test/cosim/dune` references it. **The general form, and it is this round's own**: *a self-deleting artefact needs a named executor as well as a named condition — a condition with no executor is met by nobody, and the artefact outlives the question it was built to answer.* **(12) Two files outside this plan carry the same repair as item 1's neighbour**: `CD-xgmii_rx_64_cosim.md` §0-bis's *"for the M03 pairing the permitted-divergence set is EMPTY"* gains a **dated annotation** narrowing it to the scope it was always true at — REQ-901 gained classes **(e)** and **(f)** at the M03 boundary at `ebb3f49`, and CD's own §2-bis carries the resolution block naming them — and `tools/cosim/run_cosim.sh`'s check-4.1 comment, which had **propagated** that sentence into a script a future phase driving a runt would read, gains the same. **Annotated, never edited inside the frozen entry**, per CD §9's change discipline: a run has probed the area (Phase 1's own), and the statement is not moving **outward**, it is being narrowed to where it was always true. | dv_lead, `J-dv_lead-0132` |
