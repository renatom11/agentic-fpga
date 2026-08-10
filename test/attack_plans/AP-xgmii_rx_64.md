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
| **M03-B1** | REQ-102 | 64-octet frame whose six filler octets and SFD octet are arbitrary non-standard **data** values, both start lanes | The frame is delivered unchanged: same 60 octets, same `tkeep`, `tuser`[0] = 0, no strobe | A receiver that validates the SFD or the filler and drops a legal frame from a nonstandard-but-legal link partner (REQ-102's own reason for forbidding the check). **THIS ROW'S STIMULUS PATTERN IS DRIVEN A SECOND TIME, BY A SECOND PRODUCER, AS THE DIFFERENTIAL CO-SIMULATION'S CASE C4 — CROSS-REFERENCE ADDED 2026-08-10** (`WO-0078` §14 `RV-C4` §12 item 5, on carrier (ii) of `FINDING RV-0078-S2-13`, which was minted because a C4 dispatch named the stimulus and never named **this row**, sending a worker to discover a construction the programme already owned; `J-dv_lead-0159`). **The link is to the STIMULUS and to nothing else.** `test/cosim/stimulus_gen.ml` emits `0xA0 lor d` for d = 1…7 at a **lane-0** start, which is bit for bit this unit's own `nonstandard_preamble_octet lane = 0xA0 + lane` at its lane-0 member (`test/xgmii_rx_64/test_m03_b.ml:28`) — the same pattern, **built twice and independently**, this row through `Bench.run`'s `?word_at` substitution and C4 through the second producer's own lane arithmetic. C4 ran at `build` run **`31431123022`** / `cosim` job **`93594520735`** and **agreed on all four REQ-901 observables at branch α**, which lifted **§7 bar 1's class 5** and **falsified `WO-0078` §7's C4 prediction — the reference does not validate the filler or the SFD octet either.** **BOUNDED BY `RV-C4GAP` §5's FOUR PROHIBITIONS, QUOTED HERE SO THIS POINTER CAN NEVER BE READ AS THIS ROW BEING CO-SIM-ANCHORED: (1) "It does not co-sim-anchor `M03-B1`. B1 is a family-B bench row with its own assertions and its own mutation qualification; C4 is a two-implementation comparison on a shared stimulus pattern. Sharing a stimulus is not sharing a verdict." (2) "It does not reach the lane-4 half. `M03-B1` drives both start lanes; C4 drives one. The lane-4 nonstandard-preamble geometry — where the preamble straddles two words — is not in C4's set and no packet may imply it is." (3) It lifts no bar by itself — bar 1 lifts at the `AP-` round, per class, when a case has run and agreed. (4) "It does not open the `SO-`."** **The two axes on which the instruments differ**: this row drives **both start lanes** and asserts **absolute figures at the receiver**; C4 drives **lane 0** and asserts **agreement**. In §7's lift-cell form, **this row is class 5's ABSOLUTE half and the co-simulation is its AGREEMENT half** (`FINDING RV-0078-S2-2`), and **α never stands for both**. **Nothing about this row's status, assertions, qualification or coverage moves on it**, and no `SO-` may cite the co-simulation as evidence for anything this row asserts | ASSERT |
| **M03-B2** | REQ-102, REQ-105, §0.7, §9 row 3 | **Three character members at preamble position 3, each at both start lanes** — the placement is held fixed and the character is the variable: (a) **`/E/`** — lane 3 of a lane-0 start word, lane 7 of the start word at a lane-4 start; (b) **`/I/`** — the same two placements (**WIDENED 2026-08-04**, note **B-ii**: §4.N's M03-N3 names this row as the carrier of the idle-in-preamble REQ-105 case and this cell did not carry it); **DRIVEN 2026-08-05** — `test_m03_b.ml`'s `run_b2_new`, both start lanes, landed at `88413b9` and **green** in CI `build` run `30961544649` (`RV-0065-VERDICT`); (c) **`/Q/`** — the same two placements, **DRIVEN 2026-08-05** at `88413b9` (`run_b2_new`, both start lanes, green in the same run), note B-ii's **obligation 1 DISCHARGED** by `WO-0065` §3.2.1's ruling, transcribed into note B-ii below | **No output word at all** for that frame; exactly one `error_bad_frame` high cycle, on the cycle two after the input word carrying the character; the next frame is received intact. Members (a), (b) and (c) differ in exactly one variable, so their observables are identical figure for figure — a difference between them is this row's own defect signature (the three-member form since 2026-08-05; the cell read "(a) and (b)" while `/Q/` was carried and not driven) | A design that recognises `/E/` only in `Frame` state and emits nothing *and* pulses nothing (a silent discard, REQ-008); and a design that emits a zero-octet word (`tkeep` = 0, REQ-011). **Member (b) alone** kills a design that carries REQ-113's ignore rule — a control character other than the start character occurring **outside** a frame is ignored — into a **preamble position**, which is *inside* an open frame: such a design is silent where REQ-102's third sentence demands one `error_bad_frame` and no output word, and **no `/E/` stimulus in this plan can separate it from a conforming one**, because `/E/` routes to REQ-105 under both readings. **QUALIFIED 2026-08-06 — two scoreable classes, two kills, 2/2** (`WO-0066-VERDICT` §2 and §3, disposition 1 at both; `J-dv_lead-0117`, recorded here `J-dv_lead-0118`). Recorded in this cell with the Status cell left at `ASSERT`, on the same grammar as M03-I2's and M03-N2's (§1's six-value vocabulary; `J-dv_lead-0109`). **IC-D — REQ-113's ignore rule carried into a preamble position** (disclosed `D-D2 = wide`): members **(b) `/I/`** and **(c) `/Q/`** reddened at lane 0 with seal §4.4's branch-C cells character-exact, and the raise site is `test_m03_b.ml:1297` — the **output-word** check, not the pulse check, which confirms the disclosed `D-DF1 = C` by measurement. **Member (a) `/E/` stayed GREEN, and that control is what makes the kill mean anything**: an `/E/` routes to REQ-105 under **both** readings, so a rendering that reddened it would have changed the outcome for **every** character rather than the routing for the ones REQ-113's ignore rule misses. **IC-F — the closed code table**: member **(c) `/Q/` reddened ALONE**, with **(b) `/I/` green and (a) `/E/` green**. **THE SEPARATING OBSERVABLE, AND IT IS THE RESULT THIS ROW MOST NEEDED.** IC-D and IC-F produce **identical message strings** — seal §4.4 recorded that *"the only discriminator is which diff was applied"* — so the plan's ability to tell the two classes apart rested entirely on running them as **separate transients** in the order the pre-run reading note fixed. The measured asymmetry is **`/I/` RED under IC-D and GREEN under IC-F**, with `/Q/` red under both: **the three members are separated by measurement rather than by assertion**, no red carries a combined-class signature, and this cell's *"a difference between them is this row's own defect signature"* is now a statement with a campaign behind it. **NOTE B-ii OBLIGATION 1'S RULING IS THEREBY PAID BY MEASUREMENT, not merely admitted.** `/Q/` was driven at `WO-0065` §3.2.1 over a REQ-018 objection dv_lead overruled on SPEC-M03 §6.2's own `Preamble` row; IC-F is what that ruling bought — **`/Q/` is the only stimulus in this plan that separates routing by the CONTROL BIT from routing by an ENUMERATION, and it has now done so.** A ruling carried on four grounds of argument now has a kill under it, which is the strongest form in which this plan can hold a contested sub-member. **Lane 4 is recorded UNOBSERVED — never as a pass and never as a miss**: seal §5.3 pre-fixed that `List.iter [ 0; 4 ]` runs lane 0 first, so the lane-4 cells are **structurally unobservable** in a passing-to-failing run; the auditor discharged R-DISC-1 **per lane**, so lane 4 is reachable by term-by-term evaluation and merely unobserved. Observing it needs a lane-4-only driver built for the purpose, exactly as at M03-I2. **Qualification measures an instrument: it discharges no row, moves no discharge count and changes no status** | ASSERT |
| **M03-B3** | REQ-102, REQ-107, §0.7, §9 ruling 9 | `/T/` in a preamble position (lane 5 of a lane-0 start word) | No output word; **exactly one `error_runt` high cycle and no other strobe of any kind** (an exact set, strengthened from a lower bound by §9 ruling 9 at `1fe71ca` — this frame delivers zero octets and is therefore in the sub-5 class) at the pinned cycle; next frame intact | A design routing a preamble `/T/` to REQ-106 (which would either emit a frame from preamble octets or close silently); and, through the exhaustive strobe set, a design that runs the residue comparison at every terminate character (M03-M10). **AND THAT SECOND KILL IS DECLARED PERMANENTLY OUT OF REACH AT THIS DESIGN — `DECLARATION WO-0074-D1`, 2026-08-10, a GRAMMAR gap and not a stimulus gap** (`WO-0074-VERDICT` §7(b) and §11 item 7; `J-dv_lead-0137`, recorded here `J-dv_lead-0138`; the declaration's home is §7, beside the X-rows). This row's `/T/` sits at a **preamble position inside the start word**, so the frame is opened **and** closed inside **one** input word — the **epoch-B/C** geometry, which this file's own family header states (*every row in this family aborts a frame strictly inside its own preamble; all three pinned reports land in the START word*). At this design such a frame is reported by a **separate in-word report vector carrying no FCS-report member at all**, so **ruling 9's co-occurrence defect has no datapath-silent rendering here**. The family-M seal marked this row REQUIRED-RED against IC-M10 on a rule that read only the octet count (`FINDING WO-0074-S3`); the manifest's epoch table, **published before the run**, predicted this row GREEN, and it was — while `M03-F2`, `M03-I2`(member iii) and `M03-G7` all reddened at epoch-A closures. **This cell is rescored from REQUIRED-RED to green-by-structural-unreachability, this row is NOT qualified by that campaign, and no `SO-`, campaign or scorecard may count it as coverage of ruling 9.** The row's REQ-102/REQ-107 kill is untouched and this changes nothing about what it asserts. **Discharged only by a change to that report path, or by a directed non-datapath-silent probe outside a mutation campaign's class of evidence** | ASSERT |
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
| **M03-E1** | REQ-105, REQ-103's no-removal clause | `/E/` in **each of the eight lanes** of a mid-frame word of a 64-octet frame (8 frames, lane-0 start; repeated at lane-4 start) | The last delivered octet is the one immediately preceding the `/E/` (the REQ-106 rule with `/E/` in place of `/T/`, so `/E/` in lane 0 means the previous word carried the last octet); `tkeep` marks exactly those octets; `tuser`[0] = 1 on the `tlast` word; exactly one `error_bad_frame` on the `tlast` cycle; **no FCS removal** — the four octets before the error character **are** delivered | A design that applies FCS removal on the abort path (REQ-103 forbids it): it would deliver four octets too few and the row's octet-count assertion catches it at every lane. **QUALIFIED 2026-08-10 — one class, one kill, AND IT IS THE SAME SINGLE KILL AS BOUND ROW `M03-M3`, never two** (`WO-0074-VERDICT` §3, §6 and §8.1; seal §4.3, frozen at `ca1bb80`; `J-dv_lead-0137`, recorded here `J-dv_lead-0138`). **IC-M3** ran the residue comparison at an error-character closure, and this row's **exact-strobe-set** assertion — not its octet-count assertion — raised the sealed cell with **`observed 2`** at the **FULL** prefix variant the seal **derived** from the first member's 24 delivered octets. CI `build` run **`31054174810`**, control **`31052415338`**. **AND THIS ROW WAS THE DISCRIMINATOR THAT DECIDED COLLISION 2**: IC-M3 and IC-M5 raise the same sealed string at `M03-H3`, and this row's **state** is what separates them — it reddens under IC-M3 and would have stayed green under IC-M5. It reddened, so the `M03-H3` red is IC-M3 blast radius and qualifies neither `M03-M5` nor `M03-H3`'s own row. **Only the first of this row's sixteen members spoke**; the remaining **fifteen of sixteen** are **UNOBSERVED — never a pass and never a miss** (§5.3, R-DISC-1's per-lane, per-member discharge). **Status left at `ASSERT`** (`J-dv_lead-0109`) | ASSERT |
| **M03-E2** | REQ-105, §0.7, §9 row 2 | `/E/` at exactly the frame's first octet position (zero delivered octets) | No output word at all; exactly one `error_bad_frame`, on the cycle **two after** the input word carrying the `/E/` — the cycle that frame's `tlast` word would have occupied | A design that emits a `tkeep` = 0 word, or a one-word frame of preamble octets, to have somewhere to put the abort bit. **THIS ROW CARRIES A §9 NO-OUTPUT-WORD PIN — measured, not remembered** (`J-dv_lead-0106`: `Strobe_monitor.expect` at `test_m03_e.ml:429`; §2 obligation 4 carries the whole nine-unit inventory). It is one of the **nine**, and under `WO-0063B`'s IC-1 report-path delay it reddened on its **own** row-local pinned-cycle check — `M03-E2 (lane 0): error_bad_frame pulsed on cycle 5, expected 4` — not on the standing monitor, which spoke nowhere in that campaign (`WO-0063B-VERDICT` §1 and §5, `J-dv_lead-0109`). **Its structure is the epoch-A aged record** (pin 4, so the closing word is the word after the start word), which is member (iii)'s structure and not M03-E5's in-word one — the split matters to any campaign that seeds one path and not the other (`WO-0063B-VERDICT` §7.1). **A campaign enumerating the no-output-word set from memory misses this row**: it was one of the four the recalled figure of five left out | ASSERT |
| **M03-E3** | REQ-105, §0.6, §9's "aborted-and-forwarded versus discarded-before-emission" | (same as M03-E2) | A monitor asserting "every abort is marked on a `tlast` word" **must not be driven for this frame** — REQ-105's own verification column says so, and the frame is accounted for in §0.6 by its strobe | — (a bench-side rule, not a design property) | NO-ASSERT |
| **M03-E4** | REQ-105's closure clause, REQ-113, **C-12** | `/E/` **after** a terminate character, in the gap between two frames. **AND AT LANE 0 THAT IS AN IN-WORD DOUBLE EVENT AND NOT A SEPARATE-WORD GAP — a correction to this cell's own advertisement, derived 2026-08-11 while recording `FINDING WO-0077-N2`, against my own row** (`WO-0077-VERDICT` §9.2 at `d6fdf92`; landed here `J-dv_lead-0148`). *"In the gap"* is true in **octet time** and false in **input words** at one of this row's two members, and the difference is the whole of the two-events-in-one-input-word discrimination SPEC-M03 §6.1 turns on. **The arithmetic, from the bench's own constants and §0.3's lane mapping rather than from a packet that quotes them.** `run_e4` lays its two frames out with `Bench.frames_at ~lane`, whose `first_start` is **8** at lane 0 and **12** at lane 4 (`test/xgmii_rx_64/bench.ml:559–566 @ 22ffe13`); `Arrival.terminate_octet_time` is `start_octet_time + 8 preamble octets + frame length` (`test/xgmii/arrival.ml:17` and `:22 @ 22ffe13`); and the `/E/` is placed at `e_octet_time = terminate0 + 5` (`test/xgmii_rx_64/test_m03_e.ml:543 @ 22ffe13`). For the 64-octet first frame that gives — **lane 0**: `/T/` at octet time **80** = **cycle 10, lane 0**, `/E/` at **85** = **cycle 10, lane 5** — **the same input word**; **lane 4**: `/T/` at **84** = **cycle 10, lane 4**, `/E/` at **89** = **cycle 11, lane 1** — **different words**. **This row therefore drives TWO DIFFERENT GEOMETRIES, one per member, and only the lane-4 member is the separate-word gap this cell describes.** **Three consequences, and none of them moves this row's Observable, its status or any count.** (i) The **lane-0** member is a second, **independently constructed** carrier of `M03-N1`'s geometry — bit for bit that row's placement (§4.N: terminate at octet time 80 at lane 0, the `/E/` derived at 85), built through `Bench.run`'s `?word_at` hook instead of through an overlay — so **`M03-N1` is not the sole instance of that geometry in this bench, and no packet may claim it is.** (ii) The row's Observable is **unaffected and is not amended**: REQ-105's closure clause and C-12 say the `/E/` finds no open frame and produces nothing, and that is true at both members whichever word the `/E/` lands in. (iii) **A stimulus title is not a stimulus census** — this cell's own wording is what caused my seal's instance list to miss the unit that its rule selected, which is `FINDING WO-0077-N2`'s under-selection half, and the correction is recorded at the cell that caused it rather than only at the finding | Nothing emitted, **no strobe of any kind**, and the following frame received intact | A design whose `/E/` handler is not gated on frame-open: it pulses `error_bad_frame` for a frame already counted and breaks §0.6's conservation equation. **REDDENED BY THE FAMILY-K/N CAMPAIGN AND QUALIFIED BY IT BY NOTHING — 2026-08-11** (`WO-0077-VERDICT` §4.1's per-unit table and §9.2 at `d6fdf92`; landed here `J-dv_lead-0148`). Under **IC-N1**, `M03-E4 (lane 0)` raised `an error strobe pulsed for an /E/ that arrived with no frame open (REQ-105's closure clause, C-12, E-c4)` at `test/xgmii_rx_64/test_m03_e.ml:584 @ 22ffe13`, CI `build` run **`31075098067`**. **The red is blast radius: the class was seeded against `M03-N1`'s Kills cell and scored at `M03-N1`'s own cell, it contributes ZERO kills here, and it qualifies neither this row nor any other family-E row.** It was **not** in the seal's instance list and it **is** inside the seal's rule — seal standing rule 5 makes the rule govern — so the disposition is *"my instance list was wrong"* and **not** *"the diff reached further than the class it names"*: **no scope finding.** **The lane-4 member stayed green and its greenness was REQUIRED, not a miss** — the `/E/` is in the next input word there, so the class has nothing to mis-route, which is the same arithmetic the Stimulus cell now carries | ASSERT |
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
| **M03-F2** | REQ-107, §0.7, §9 ruling 9 | Frames of **0, 1 and 4** octets between start and terminate. The 4-octet frame's filler SHALL NOT be `00 00 00 00` — or both fillers are driven — for the reason M03-M10 gives | No output word at all; **exactly one `error_runt` and no other strobe of any kind** (an exact set, strengthened from a lower bound by §9 ruling 9 at `1fe71ca`), at the pinned no-output cycle | A design that emits a `tkeep` = 0 word; a design that attempts FCS removal on a frame with nothing to remove it from and underflows its counter; and, through the exhaustive strobe set, a design that runs the residue comparison at every terminate character (M03-M10). **QUALIFIED 2026-08-03 (`RV-0050-VERDICT`, `J-dv_lead-0065`) — three seeded classes killed this row, and the second declared kill above is CONFIRMED ACHIEVABLE rather than withdrawn.** `WO-0047` §3.2 flagged that kill as at risk of the unachievable-kill shape and could not settle it, because settling it required reading `libs/**`; `RV-0047` §5(3) sent it to the campaign with the disposition pre-committed — *if a faithful underflow mutation kills nothing, the kill is withdrawn by spec diff, as M03-D3's headline kill was*. **F-c6 seeded the underflow faithfully and this row killed it, so the pre-commitment does not fire and no spec diff is owed.** **Two bounds attach, and neither is decoration.** (a) **The row convicts the underflow but cannot diagnose it**: F-c3 (a spurious emitted word) and F-c6 (the underflow) produced **byte-identical** bench output — same unit, same iteration, same assertion, same message, and the two runs' `.corrected` blobs are the same object — so a reader who sees this row's message cannot tell the two defects apart. That is the opposite disposition from M03-D3's: killable, and merely not separable. (b) **The three lengths are not interchangeable.** F-c5, a *strobe-suppressing* defect, convicts at **k = 0** because it needs no delivered octet; F-c3 and F-c6, both of which must *emit* something, are **invisible at k = 0** and first bite at **k = 1** — a zero-octet frame gives an emitting defect nothing to emit. So this row's reach against the emitting classes is **k ∈ {1, 4}**, and k = 0 earns its place against the suppressing class alone. **QUALIFIED AGAIN 2026-08-10 — a FOURTH class, one further kill, AND IT IS THE SAME SINGLE KILL AS BOUND ROW `M03-M10`, never two** (`WO-0074-VERDICT` §8 and §8.1; seal §4.8a, frozen at `ca1bb80`; `J-dv_lead-0137`, recorded here `J-dv_lead-0138`). **IC-M10** ran the residue comparison at every terminate character — the third of this cell's declared kills, and the first time it has been seeded — and this row's **0-octet member** raised the sealed string with **`observed 2`**, the register still on §6.1 item 1's seed. CI `build` run **`31054180874`**, control **`31052415338`**. **IC-M10's kill rests on this row alone**; its other two reds are blast radius. **AND THE ROW'S OWN 4-OCTET ANTI-VACUITY MEMBER IS SHADOWED, NOT MEASURED — declared, not discovered** (`WO-0074-VERDICT` §11 declaration 6, `WO-0047` §2). The zero-octet member spoke **first**, exactly as the seal predicted, so the **4-octet member never ran** and the non-zero-filler discipline this cell and M03-M10 both impose **is not measured by this campaign and no verdict may say it was**. Under §5.3's shadowing adjudication that member is **UNOBSERVED — never a pass and never a miss** (R-DISC-1's per-member discharge), as are this row's remaining members. **The repair is cheap and it is NOT made here**: reorder `f2_received_counts` so the 4-octet member speaks first, or add a directed member. **Carrier: the next commit that opens `test/xgmii_rx_64/test_m03_f.ml`** — which this round is **not**, for the standing reason a plan round does not improve a carrier (`J-dv_lead-0112`, applied to family L's `OBSERVATION L-O1` and to `WO-0073-D3` before it) | ASSERT |
| **M03-F3** | REQ-107, REQ-104, §9's first co-occurrence ruling | A **63-octet** frame with a **wrong** FCS | **Both** `error_runt` and `error_bad_fcs` pulse once; `tuser`[0] is set **once** — it is one bit on one word, not one bit per condition | A first-match or precedence design that reports only the runt; and a design that sets the abort bit twice or widens the pulse. **QUALIFIED 2026-08-10 — one class, one kill, AND IT IS THE SAME SINGLE KILL AS BOUND ROW `M03-M1`, never two** (`WO-0074-VERDICT` §8 and §8.1, on §11's carrier/bound-row rule; seal §4.1, frozen at `ca1bb80`; `J-dv_lead-0137`, recorded here `J-dv_lead-0138`). **IC-M1**, branch **R** of `D-M1a`, at CI `build` run **`31054172382`** against control **`31052415338`**: this row's exact-strobe-set assertion raised the sealed cell with **`observed 1`** and printed cycle **11** — the campaign's only subtractive reading, and the seal's own separator for IC-M1 at a count-shaped cell. **The mechanism ran through the co-occurrence this row asserts**, which is what makes the qualification legitimate; the full argument is at M03-M1. **This row is the whole of IC-M1's red set** — the class's rule selects one unit — so it has no blast radius. **Status left at `ASSERT`** (`J-dv_lead-0109`) | ASSERT |
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
| **M03-G1** | REQ-108, REQ-103 | A **1600**-octet frame followed immediately by a valid 64-octet frame | Exactly **1514** octets delivered; `tuser`[0] = 1 on the `tlast` word; exactly one `error_oversize`; **no `error_bad_fcs`**; the following frame received intact | Truncation at 1518 delivered (the received-count constant used as the delivered-count constant); a design that resynchronises only on `/T/` and loses the next frame. **QUALIFIED 2026-08-10 — one class, one kill, AND IT IS THE SAME SINGLE KILL AS BOUND ROW `M03-M2`, never two** (`WO-0074-VERDICT` §4, §8 and §8.1; seal §4.2, frozen at `ca1bb80`; `J-dv_lead-0137`, recorded here `J-dv_lead-0138`). **IC-M2** ran the residue comparison at REQ-108's truncation point and this row raised the sealed cell with **`observed 2`**. CI `build` run **`31054177436`**, control **`31052415338`**. **This row is IC-M2's sole discriminator against IC-M6 and IC-M10 at the colliding `M03-G7` cell**, and it fired for IC-M2 alone. **AND THE ROW'S CONSTRAINED PREFIX IS WHAT PROVES THE CLASS KEYS ON THE TRUNCATION EVENT AND NOT ON FRAME LENGTH**: `M03-G2`'s red carries `(lane 0, 1519 oversize)` and **not** `(lane 0, 1518 legal maximum)`, and the four units receiving **at most** 1518 octets — `M03-C3`, `M03-C5`, `M03-I6`'s 1518 member and `M03-L5`'s 1518 members — stayed green, `test_m03_c.ml`, `test_m03_i.ml` and `test_m03_l.ml` never being promoted under the class. **Status left at `ASSERT`** (`J-dv_lead-0109`) | ASSERT |
| **M03-G2** | REQ-108, REQ-103, §0.3 | The adjacent pair **1518** and **1519** octets, each with a correct FCS over its own length | Both deliver exactly **1514** octets. 1518: no strobe, `tuser`[0] = 0, FCS verdict good. 1519: one `error_oversize`, `tuser`[0] = 1, **no** `error_bad_fcs` | The off-by-one on "more than 1518". The pair is adversarial precisely because the **delivered octet count is identical** — only the strobe, the abort bit and the FCS verdict separate a legal maximum frame from an oversize one | ASSERT |
| **M03-G3** | REQ-108, REQ-110, §9's sixth ruling, **C-12** | A 1600-octet frame in which a new `/S/` arrives 100 octets past the truncation point — content index **1618**, which is in REQ-108's window and **past the frame's own terminate**: the **second epoch**, see the family note | Exactly one `error_oversize` and **no** `error_start_without_terminate`; the new frame is received normally | A design that treats the resynchronising start character as a second abort — it would double-count the frame against §0.6. **SCOPED 2026-08-05 (`J-dv_lead-0072`), and the scoping is a correction of a claim this cell made and could not support.** REQ-108's window runs from the truncation point to the **next start character**, so the oversize frame's own terminate lies **inside** it and this row's character lies **after** that terminate. The kill above is therefore established **for the second epoch only** — the interval from the frame's own terminate to the next start character. **This row does not reach the first epoch** (truncation point to the frame's own terminate), and a design that resynchronised correctly in the second while treating the start character as an abort in the first passes it. That gap is **M03-G7**'s, and it was measured rather than argued: WO-0055's G-c4 mutation survived all twenty-five units (`RV-0055-VERDICT`, FINDING G-2) | ASSERT |
| **M03-G4** | REQ-108, REQ-105, §9's seventh ruling, **C-12** | The same 1600-octet frame with an `/E/` injected 100 octets past the truncation point — content index **1618**, in REQ-108's window and **past the frame's own terminate**: the **second epoch** | Exactly one `error_oversize`, **no `error_bad_frame`**, nothing emitted after the truncation, following frame intact | The reading §9 row 2's condition text invited before C-12 landed: an `/E/` handler that reads "between the start and terminate characters" literally and pulses for a frame already closed and already reported. **SCOPED 2026-08-05 (`J-dv_lead-0072`)** on the same ground as M03-G3, and this is the row WO-0055's G-c4 walked past: the kill is established **for the second epoch only**, where the receiver has already absorbed the frame's own terminate. **An `/E/` arriving in the first epoch is not driven by this row and is M03-G8's.** Note what remains genuinely this row's, so the scoping is not read as a retirement: an `/E/` in the second epoch is *not* redundant with M03-E4's gap `/E/`, because the receiver reaches it through a **truncation** rather than through an ordinary close, and REQ-108's sentence covers the whole interval | ASSERT |
| **M03-G5** | §6.3 item 6, **C-12** | (same as M03-G4) | The **internal state** after absorbing the `/E/` in `Discard` is not asserted; both encodings produce the pinned observable identically | — | NO-ASSERT |
| **M03-G6** | REQ-108 | A 1600-octet frame with **no** further character until the next `/S/` (no `/T/` at all) | No output word and **no strobe of any kind** between the truncation point and the next start character, whatever arrives | A design that emits the tail of the discarded frame, or that pulses a second strobe on the eventual `/T/`. **Note, added 2026-08-05**: because this frame has no terminate at all, its whole window **is** the first epoch — so before M03-G7 and M03-G8 this was the only row in the programme that drove a character into it, and everything the first epoch is verified by today it is verified by here | ASSERT |
| **M03-G7** | REQ-108, REQ-110, §9's sixth ruling, **C-12**; §6.3 item 6 (as a bound on what may be asserted) | A frame exceeding 1518 octets in which a **start character arrives strictly between the truncation point and the frame's own terminate character** — the **first epoch**. For the family's 1600-octet frame that interval is content indices **1519 … 1599 inclusive**, both ends derived **and both boundary cases worked** — the discipline whose absence produced this repair. **Lower end**: a character placed at content `k` *replaces* that octet, so the data octets arriving before it are indices 0 … k−1, i.e. **k** octets; REQ-108 truncates a frame **exceeding** 1518, so `k` must be **at least 1519**. At `k = 1518` exactly 1518 octets have arrived, the frame is **not oversize at all**, and the character is REQ-110's or REQ-105's rather than REQ-108's — the row's premise fails. *(Corrected 2026-08-05, `J-dv_lead-0075`, from a stated `1518`: the figure was right for **where truncation triggers** and wrong for **where a character may be placed after it**, because placing one at 1518 removes the very octet whose arrival makes the frame oversize. Found by tb_writer's octet-time guard disagreeing with this cell — `RV-0056-VERDICT` §1.)* **Upper end**: content 1599 is the last octet before the frame's terminate, and a character there still leaves 1599 > 1518 received, so it is admissible. The interval is therefore **81 octets wide**, not the 82 first stated. The index SHALL additionally satisfy REQ-101's lane rule, which for this frame is `c ≡ 0 or 4 (mod 8)` **at both start lanes** (a lane-0 start puts content `c` at octet time 16 + c, a lane-4 start at 20 + c, and the two conditions coincide). **The row is specified as an octet-time interval and asserts NOTHING about which internal state the receiver occupies** — §6.3 item 6 makes `Discard`-versus-`Idle` unobservable and M03-G5 exists to say so | For the oversize frame: exactly one `error_oversize` on its own `tlast` cycle, 1514 delivered octets, `tuser`[0] = 1, and **no `error_start_without_terminate`** (§9's sixth ruling — the frame is already closed and already reported, so the resynchronising character is not a second abort). **And the resynchronised frame's own disposition is part of this observable and SHALL be derived, not omitted**: REQ-108 resynchronises on that start character, so content `k+8 … 1599` plus the original frame's terminate belong to the frame it opens, giving it **1592 − k** octets between start and terminate, whose disposition follows REQ-106/REQ-107 | The gap WO-0055 **measured**: a design that resynchronises correctly in the second epoch and treats the start character as a second abort in the first. G-c4 survived all twenty-five units precisely because no row reached here (`RV-0055-VERDICT` FINDING G-2). **Contingency, pre-committed**: if the resynchronised frame's disposition proves underivable from the frozen text rather than merely arithmetic, this row converts **ASSERT → RULING** pending an architect ruling and M03-G8 carries the repair alone (`WO-0056` §2.1). **Worked example offered as a derivation to check, not as an instruction**: `k = 1588` is inside the interval, satisfies `1588 mod 8 = 4`, and leaves the resynchronised frame **4 octets** — the sub-five class of M03-F2, which is benched and mutation-qualified, so its contribution to the exact strobe set is one `error_runt` at §9's no-output-word pin and nothing else. **THIS ROW CARRIES A §9 NO-OUTPUT-WORD PIN, AND ITS OWN CHECK OF IT — measured, not remembered** (`J-dv_lead-0106`: the **second** `Strobe_monitor.expect` at `test_m03_g.ml:1375`, the resynchronised sub-5 frame; §2 obligation 4 carries the whole nine-unit inventory). It is one of the **nine**, and under `WO-0063B`'s IC-1 report-path delay it reddened on its **own** row-local strobe-order check at `test_m03_g.ml:1465` — `M03-G7 (lane 0): the second strobe is not error_runt on the resynchronised frame's own pinned cycle …` — not on the standing monitor, which spoke nowhere in that campaign. **The earlier classification of this row as "monitor-only" is WITHDRAWN and the withdrawal is on the record**: the check exists and speaks first, and it was missed because the sweep searched for the message *forms* `pulsed on the wrong cycle` and `pulsed on cycle` rather than for the defect (`WO-0063B-VERDICT` §5 and §6.2, `J-dv_lead-0109`). **QUALIFIED 2026-08-10 — one class, one kill, AND IT IS THE SAME SINGLE KILL AS BOUND ROW `M03-M6`, never two; THIS ROW IS THE FIRST-EPOCH CARRIER AND THE QUALIFICATION IS ITS ALONE** (`WO-0074-VERDICT` §4, §6, §8 and §8.1; seal §4.6, frozen at `ca1bb80`; `J-dv_lead-0137`, recorded here `J-dv_lead-0138`). **IC-M6** reported a start character arriving in `Discard` as an abort, and this row's exact-strobe-set assertion raised the sealed cell with **`observed 3`**. CI `build` run **`31054177532`**, control **`31052415338`**. **`FINDING M-1` is thereby MEASURED**: the second-epoch carrier `M03-G3` was the seal's load-bearing REQUIRED green under this class and **held**, so the epoch split this row exists for is established from a run and not from the stimulus alone. **AND THIS CELL IS WHERE THE CAMPAIGN'S FULLY-INSTANTIATED COLLISION LANDS — read it before quoting this row's red.** The identical message, `observed 3` included, was raised **three times**: by **IC-M6** (this row's kill), by **IC-M2** through ruling 2 and by **IC-M10** through ruling 9. **Only IC-M6's is a kill here**; the other two are blast radius and qualify neither this row nor `M03-M6`. Four sealed discriminators separated the triple, every one of them a measurement named in advance. **The row's resynchronised sub-five frame also carries IC-M10's reach into this unit**, which is why the IC-M10 red exists at all and why it qualifies nothing. **Status left at `ASSERT`** (`J-dv_lead-0109`) | ASSERT |
| **M03-G8** | REQ-108, REQ-105, §9's seventh ruling, **C-12**; §6.3 item 6 (as a bound on what may be asserted) | The same frame with an **error character** in the same interval — strictly between the truncation point and the frame's own terminate character, content **1519 … 1599** for the 1600-octet frame, both ends derived **with their boundary cases worked** as in M03-G7 (81 octets, corrected 2026-08-05 from a stated 1518). **An octet-time interval, never a state claim** | Exactly one `error_oversize`, on the oversize frame's own `tlast` cycle, **and no `error_bad_frame`** (§9's seventh ruling, C-12) — an **exact strobe set**, not a lower bound; 1514 delivered octets; no output word after the truncation; the following frame received intact | An `/E/` handler that reads REQ-105's "between the start and terminate characters" literally and reports for a frame already closed and already reported — **in the epoch M03-G4's character never reaches**. This is the row that **lifts** `RV-0055-VERDICT`'s standing consequence, and it lifts it only on the evidence `WO-0056` §6 specifies: the existing `g-c4` diff replayed against the repaired bench, where **this row SHALL redden**. A green row proves nothing here — M03-G3 and M03-G4 have been green since they landed and were green for the wrong reason. **QUALIFIED 2026-08-10 — one class, one kill, AND IT IS THE SAME SINGLE KILL AS BOUND ROW `M03-M7`, never two; THIS ROW IS THE FIRST-EPOCH CARRIER AND THE QUALIFICATION IS ITS ALONE** (`WO-0074-VERDICT` §4, §6, §8 and §8.1; seal §4.7, frozen at `ca1bb80`; `J-dv_lead-0137`, recorded here `J-dv_lead-0138`). **IC-M7** reported an error character arriving in `Discard`, and this row's exact-strobe-set assertion raised the sealed cell with **`observed 2`**. CI `build` run **`31054179722`**, control **`31052415338`**. **`FINDING M-2` is thereby MEASURED**: the second-epoch carrier `M03-G4` was the seal's load-bearing REQUIRED green under this class and **held**. **AND THIS CELL CARRIES THE CAMPAIGN'S FOURTH COLLISION, WHICH THE SEAL DID NOT NAME** (`FINDING WO-0074-S4`): **IC-M2** raised the **identical** string here, `observed 2` in both, at a **scored** cell — a wide class's blast radius landing on a narrow class's own cell, which is the shape a collision inventory built from marked cells alone will always miss. The discriminators existed and were already sealed (IC-M2 reddens seven units of family G, IC-M7 exactly one), so no kill was endangered; the IC-M2 red is blast radius and qualifies nothing. **What this row still does NOT do is lift `RV-0055-VERDICT`'s standing consequence** — that lift is specified against the `g-c4` diff replayed on the repaired bench (`WO-0056` §6), and `g-c4` is **not** one of this campaign's eight classes. **Status left at `ASSERT`** (`J-dv_lead-0109`) | ASSERT |

### 4.H Start without terminate — REQ-110, §9

| Row | Attacks | Stimulus | Observable | Kills | Status |
|---|---|---|---|---|---|
| **M03-H1** | REQ-110, REQ-103 | A 64-octet frame whose terminate character is **replaced by a new `/S/` in lane 0**, followed by a complete frame | The aborted frame's last delivered octet is the one immediately preceding the new `/S/`; `tuser`[0] = 1; exactly one `error_start_without_terminate`; **no FCS removed** (four octets more delivered than a clean frame of the same length); the second frame received intact | A design that strips the FCS on the abort path; a design that loses the second frame. **QUALIFIED 2026-08-10 — one class, one kill, AND IT IS THE SAME SINGLE KILL AS BOUND ROW `M03-M4`, never two** (`WO-0074-VERDICT` §8, §8.1 and §9; seal §4.4, frozen at `ca1bb80`; `J-dv_lead-0137`, recorded here `J-dv_lead-0138`). **IC-M4** ran the residue comparison at a start-character closure, and this row's exact-strobe-set assertion raised the sealed cell with **`observed 2`**. CI `build` run **`31054177858`**, control **`31052415338`**. **The red is what answers `FINDING M-O1a` in this row's favour**: the single 64-octet filler content its two cases deliver does not satisfy REQ-304's residue at the `/S/` closure, so the row is not vacuous against ruling 4's defect. The lane-4 member is **UNOBSERVED — never a pass and never a miss** (§5.3, R-DISC-1). **Status left at `ASSERT`** (`J-dv_lead-0109`) | ASSERT |
| **M03-H2** | REQ-110, REQ-101, REQ-021 | A new `/S/` in **lane 4** of a mid-frame word, i.e. lanes 0–3 of that word still belong to the aborted frame | Those **four** octets are delivered as part of the aborted frame (`tkeep` and the delivered count prove it **at a lane-0 start only** — at a lane-4 start REQ-101's absolute-lane rule forces `k ≡ 0 (mod 8)`, the aborted frame delivers a whole number of words, `tkeep` is `0xFF`, and neither instrument discriminates. The row is proved at **both** alignments by `WO-0057` §2.3's **delivered-content** assertion, which is what `run_h2` makes; this cell over-promised about the weaker instrument. `J-dv_lead-0078`, footnote owed there and discharged here); one strobe; the new frame begins at lane 4 and is received intact and correctly aligned | The highest-value row in this family: a design that switches its alignment offset on the **same** cycle it accepts the new start character rotates the aborted frame's trailing four octets by the *new* offset and **loses four delivered octets silently** — a REQ-008 hole with no strobe, invisible to every row that does not count the aborted frame's octets | ASSERT |
| **M03-H3** | REQ-110, REQ-105, §9's fifth ruling | `/E/` mid-frame, then a `/S/` two cycles later | Exactly one `error_bad_frame` and **no** `error_start_without_terminate`; the frame the `/S/` opens is received normally | A design in which `/E/` marks the frame but does not **close** it: the following `/S/` would then abort a frame that is already reported, breaking §0.6. **NOT QUALIFIED by the family-M campaign, and the reason is worth more than a qualification would have been — 2026-08-10** (`WO-0074-VERDICT` §6 collision 2, §7(a) and §8.2; `J-dv_lead-0137`, recorded here `J-dv_lead-0138`). This row **did** redden, under **IC-M3**, raising **`IC-M5`'s own sealed cell string character for character, `observed 2`** — the seal's §4.5. **It is blast radius through ruling 3 and it qualifies neither this row nor `M03-M5`.** The sealed discriminator was `M03-E1`'s state — IC-M3 reddens it, IC-M5 would have left it green, this row's stimulus driving a single frame with no later start character — and M03-E1 reddened. **The same characters meant the opposite thing, and only the diff identity plus a second carrier's state told them apart**; nothing was inferred from the message. And the class this row's bound row asserts against, **IC-M5, was never rendered at all** (`DECLARED VOID`, at M03-M5). **A future scorecard may not read this row's red as coverage of ruling 5.** **Status left at `ASSERT`** (`J-dv_lead-0109`) | ASSERT |
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
| **M03-J1** | REQ-810, §4.3 | `cfg_rx_enable` = 0 held, 100 frames injected (REQ-810's own figure) | No output word, no header effect and **no strobe** anywhere; the conservation monitor records all 100 as `frame_in_exempt` (C-2), not as discards. **THE `frame_in_exempt` DEMAND IS CORRECT AND IS NOT STALE, and this cell now says why in one clause so the next reader does not re-litigate what `WO-0067` §5.2 had to derive** (2026-08-09, `J-dv_lead-0124`). Three facts, each read at its own source rather than taken from a packet that quotes it. **(i) The equation's *presented* term is zero for a refused frame, by specification.** SPEC-M03 §6.1's disabled-state paragraph: *"a bench's frame-conservation monitor (§0.6) counts no frame presented across the disabled window"*. **(ii) The exempt ledger is outside the equation**, so calling `frame_in_exempt` is what keeps that term at zero **by construction while still recording the frames** — `test/monitors/conservation_monitor.mli`'s **deviation 3**, which names **REQ-810** by number and states in terms that `frame_in_exempt` records such frames *"with a reason, outside the equation"*. A `frame_in` here is therefore not a stricter accounting but a **wrong** one: it would put a presented frame into an equation the specification says has none, and report the silent-discard hole REQ-810's own next clause disclaims. **(iii) ADR-0014's *"the conservation monitor needs no new exemption"* does not bear against either**, and it is quoted here at its own words because the loose reading of it is how this demand comes to look stale: the ADR's claim is that the **equation needs no new term**, on two grounds — refused frames are **not presented** in §0.6's sense, and the **in-flight** frame at M03-N4 balances **under its own strobe** — and its contrast with `clear` (C-2) is about *which frame* needs an exemption, not a licence to count a refused frame as presented. **No *new* exemption is needed because C-2's already exists and already names REQ-810**, which is §2 obligation 2 of this plan read at its word. **THE CAUTION THAT RIDES WITH THE DEMAND, and it binds every later packet**: the exempt count is **bench-supplied** — it counts the calls the unit made, not anything the DUT did — so **it is not independent evidence that 100 frames were driven**, and no `SO-` may cite it as such. Same shape as the standing `Strobe_monitor` at M03-I2, measured rather than argued (`WO-0063B-VERDICT` §5). The honest evidence for the drive is the schedule's own frames array plus the mandatory anti-vacuity control — the same schedule on a fresh bench at `Enable.high` delivering all **101** frames. **AND WHAT THIS OBSERVABLE'S SILENCE CANNOT SAY — `DECLARATION J-D1`, declared before the family-J campaign ran and MEASURED by it, 2026-08-10** (`WO-0076` seal §6.7 frozen at `8346a5c`; `WO-0076-VERDICT` §7.3 and §11 item 6 at `a8d6140`; landed here `J-dv_lead-0143`). An observable expressed as an **absence** cannot distinguish a component that never produced the event from one that produced it and **suppressed** it: a design that **admits** every refused frame and **mutes** its output satisfies every clause of this cell exactly. **No `SO-`, campaign or verdict may cite this row's green as evidence that frames were not admitted.** It is measured on the **`add`** branch by IC-J3 (run `31064104902`), a rendering that refuses **and** mutes, so the green measures directly that this silence scan **cannot see an emission gate at all**; the *admitted-and-muted* design is the **`move`** branch, which was **not rendered**, and this row's green under it follows from a pre-run derivation rather than from a run — **the declaration's strongest form remains derived, and it is recorded in that wording and not in a stronger one**. The separating instrument is a **positive comparison against a reference run**, which is **M03-J3**'s and not this row's. Homed as **U-4** at §7 | A design that gates the output but leaves the strobe path live — it would report 100 discards for frames it never accepted, and a monitor without the exemption would report a silent-discard hole where REQ-810 says there is none. **QUALIFIED — 2 classes, 2 kills, on two distinct clauses of this row's own Observable** (2026-08-10, `WO-0076-VERDICT` §8 at `a8d6140`, adjudicated `J-dv_lead-0142`, landed here `J-dv_lead-0143`). **IC-J1** — *the enable does not gate admission*, REQ-810's first sentence — raised this unit's silence scan at its `tvalid` arm, `cycle 4: tvalid high during the disabled window`, CI `build` run **`31064102925`**. **IC-J2** — *a refused frame is reported*, REQ-810's third prohibition — raised the same scan at its **strobe** arm, `cycle 1: an error strobe pulsed during the disabled window`, run **`31064103812`**. **Two kills, one row, two clauses, and they are two kills and one qualification** (`WO-0066` §11: kills are counted per class). **Status left at `ASSERT`** (`J-dv_lead-0109`: §1's status vocabulary is a closed set of six values and `QUALIFIED` is not one of them). **AND `FINDING J-1` IS AGAINST THIS CELL — raised before the run, unrepaired, and the run MEASURED it rather than settling it.** **First half.** Read **narrowly** — the condition-detection machinery keeps running while the output is gated — the class this cell names is **unreachable under this row's own stimulus**: the hundred refused frames are clean, well-formed, 64-octet, good-FCS frames that **owe no strobe under any rendering**, so the class emits nothing and is indistinguishable here from a conformant design. Only the cell's own **parenthetical** — a design that *reports* refusal — is separable, and that is **IC-J2**, which killed. The narrow reading is therefore now **measured** as unreachable rather than argued: **under no class did a refused clean frame draw a report except where the class itself added one.** **This is the seventh instance in this plan of a Kills cell naming a design its row's stimulus cannot reach**, after M03-D3, M03-F2, M03-I2, M03-J2, M03-K1 and M03-N4, and it was found the way all six were — by working the row's arithmetic while authoring the packet that commissions it, **before a diff existed**. **Second half, and it is the half still OWED.** This row's Observable carries **three** clauses (no output word, no header effect, no strobe) and this cell attacks **one** of them: **the no-output-word clause — REQ-810's first sentence, IC-J1's whole ground and the source of this campaign's first kill — has no Kills cell at all**, so IC-J1's kill lands against a clause this cell never claimed. **Disposition, the precedent's, applied unchanged**: the row **stays ASSERT**, its Observable is REQ-810's own and is sound, and what the finding changes is the claim a round may make about the cell, never its status. **OWED: a Kills cell for the no-output-word clause. Carrier: the next round that opens §4.J, at or before the `SO-`** — named so it cannot evaporate. **PAID 2026-08-11, AT THE FIRST `AP-` ROUND SCHEDULED AFTER IT WAS RAISED** (`J-dv_lead-0148`; the carrier named above, discharged at the round it named, before the `SO-` rather than at it). **THE SECOND KILL THIS ROW MOUNTS, and it is derived from REQ-810's own first sentence and from nothing else — the mutant that later killed at it is retrospective corroboration, not the derivation, and the distinction is stated because a Kills cell reverse-engineered from a diff is exactly what this plan forbids itself.** requirements.md REQ-810: *"When `receive enable` is 0 the receive path SHALL accept no frame: **for every frame it refuses it emits no output word on any receive-path stream**, asserts no header-record `valid` and asserts no strobe."* **The wrong design: one that reads `cfg_rx_enable` but never consults it at the start character — the enable reaches a downstream gate, or a report gate, or nothing at all, and every refused frame is ADMITTED AND DELIVERED word for word on the receive-path stream while the enable is 0.** This row's **no-output-word** clause is what convicts it, at the silence scan's `tvalid` arm, and REQ-810's own next clause is why the design is wrong and not merely unusual: a receive path that delivers a refused frame has accepted it, so the requirement's *"no frame is accepted, so this creates no silent-discard hole under REQ-008"* is false of it in both halves at once. **Corroborated, retrospectively and from a run already on file**: this is `IC-J1` of the family-J campaign — *the enable does not gate admission* — which raised this scan's `tvalid` arm with `cycle 4: tvalid high during the disabled window`, CI `build` run **`31064102925`**, and whose kill the 2026-08-10 record above already carries. **The kill was landed and scored before this cell named it**, which is what `FINDING J-1`'s second half said and is the whole reason the cell was owed. **AND THE BOUND ON IT, so that paying this debt does not quietly enlarge the row: this new cell names the UN-GATED design — admitted AND delivered — and it does NOT name the admitted-and-MUTED one**, which `DECLARATION J-D1` (U-4 at §7) says this row's silence cannot see in any of its three clauses, and which is separated only by `M03-J3`'s positive comparison against a reference run. **`FINDING J-1` is CLOSED in both halves**: the first is measured unreachable, the second is repaired here. **No status moves, no REQ is added to this row's `Attacks` cell** — REQ-810 was already there — **and §6's coverage map is unchanged** | ASSERT |
| **M03-J2** | REQ-803, §4.3 | `cfg_rx_enable` 0 → 1 at least one cycle before a start character; then frames | The first frame whose start character is accepted at least one cycle after the change is received correctly and completely | **THE STATED KILL IS UNREACHABLE UNDER THIS ROW'S OWN STIMULUS AND IS WITHDRAWN — 2026-08-09 (`WO-0067` §6, derived `J-dv_lead-0119`; landed here `J-dv_lead-0124`). The defect is this plan's, not the bench's, and it was found the way the three before it were found — this is the shape's **fourth** instance in this plan: by working the row's own arithmetic while authoring the packet that commissions it, before a bench existed.** *The superseded cell, kept beneath the strike because the argument that retired it is only readable against it:* ~~"A design that samples the enable continuously and truncates the frame it just admitted"~~ (the cell's own words, quoted with nothing added inside the quotation marks). **Why this stimulus cannot reach it.** The row's own Stimulus takes the enable **0 → 1** at least one cycle before the start character and holds it at **1** for the whole of the admitted frame. A design that samples the enable **continuously** therefore reads 1 on every cycle of that frame and truncates nothing — the withdrawn cell's class and a conformant design produce the same output here, and a row that cannot separate them is not attacking them. **Where that kill does live: M03-J3**, whose stimulus takes the enable **1 → 0 *inside* the admitted frame**, which is the only geometry at which a continuously-sampling design truncates; M03-J3's Observable — *the in-flight frame completes under the old value* — is what convicts it, and this row must not claim it. **THE HONEST KILL, AND IT IS THIS ROW'S OWN**: a design that **refuses the first frame after a re-enable** — one that latches the enable to a frame boundary that never arrives while the line is idle, or that needs more than one cycle of settling before a start character may be admitted. §4.3's sentence is *"a frame whose start character is accepted at least one cycle after the input changes is governed by the new value"*, so the **tightest legal placement — exactly one cycle — is what makes that class reachable at all**, which is a second and independent reason the change is placed tight rather than comfortably early. **Disposition, and it is the M03-D3 / M03-F2 / M03-I2 precedent applied unchanged**: the row **stays ASSERT**, because its *observable* is sound and is REQ-803's own (a frame admitted after the change is received correctly and completely) and REQ-810's verification column commissions it in terms. What the finding changes is **the claim a round may make about this row**, never its status — and no `SO-`, campaign or verdict may cite this row as detecting continuous enable sampling. **QUALIFIED — 1 class, 1 kill, ON THE HONEST KILL ONLY** (2026-08-10, `WO-0076-VERDICT` §8 at `a8d6140`; landed here `J-dv_lead-0143`). **IC-J4** — *the re-enable is not honoured at the next start character*, which is the honest kill named above in this cell's own words — raised this row's delivered-word count, `expected 8 delivered words for frame 100, got 0`, CI `build` run **`31064106060`**. **The withdrawal above is neither re-opened nor qualified by it, and the qualification is recorded on the honest kill and on nothing else.** **AND THE PROHIBITION THIS CELL CARRIES IS NOW MEASURED RATHER THAN ARGUED — the round's own sharpest result at this row.** **IC-J3 IS a continuously-sampling design**: it gates the datapath rather than the start character, and it reddened **M03-J3** at that row's own cell (run `31064104902`) while leaving **this row GREEN**. The 2026-08-09 withdrawal was derived from this row's stimulus **before any diff existed**; a campaign has now produced the very design the withdrawn cell named, and **this row did not see it**. **A bench cannot make that measurement about itself; a campaign can, and this is the one that did** — the withdrawal is established **from a run** instead of from an argument, which is what `WO-0076` §8.1 rule 1 was written to capture. The prohibition therefore stands at full force and is not softened by a kill: **no `SO-`, campaign or verdict may cite this row as detecting continuous enable sampling**, and IC-J3's green here is **evidence for** the prohibition, never an exception to it. **Status left at `ASSERT`** | ASSERT |
| **M03-J3** | REQ-803, §4.3 | `cfg_rx_enable` 1 → 0 **mid-frame**, at least one cycle away from any start character; the frame ends with `/T/` | The in-flight frame **completes under the old value**: its words, its `tlast`, its FCS/runt verdict and its strobes are exactly those of the same frame with the enable held at 1. The **next** frame's start character is not accepted. **`FINDING J-2` IS AGAINST THIS OBSERVABLE'S STROBE CLAUSE — declared before the family-J campaign ran, and the run confirms its asymmetry** (2026-08-10, `WO-0076` §4 item 7 frozen at `8346a5c`, `WO-0076-VERDICT` §10 at `a8d6140`; landed here `J-dv_lead-0143`). *"Its strobes are exactly those of the same frame with the enable held at 1"* is **unfalsifiable in the subtractive direction**: this row's in-flight frame is **clean and owes no strobe**, so a design that **suppresses** an in-flight frame's own report — REQ-810's three prohibitions read *unscoped*, the reading ADR-0014 prices and rejects — produces exactly the same empty strobe set here as a conformant one, and is invisible at this row. The clause **can** convict a design that **adds** a strobe, and did: IC-J2's blast radius raised this unit's error-strobe arm character-exact. **The asymmetry is the finding, and no `SO-`, campaign or verdict may read this clause as covering both directions.** **The carrier that convicts the suppressing design is M03-N4**, whose in-flight frame owes an `error_start_without_terminate` — **family N's row, and not a family J qualification in either direction** — and see that row's own cell, because **M03-N4 is qualified by no campaign to date and the class that would convict through it has never been seeded**. **Unrepaired here**: the row stays ASSERT and the finding changes only what may be claimed | A design that gates the datapath rather than the start character: it truncates the in-flight frame with no `tlast` and no strobe, which is a silent discard REQ-009 does **not** license (only `clear` may do that). **QUALIFIED — 2 classes, 2 kills, at two different instruments inside this row's own unit** (2026-08-10, `WO-0076-VERDICT` §8 at `a8d6140`; landed here `J-dv_lead-0143`). **IC-J3** — *the enable gates the datapath rather than the start character*, which is **this cell's own named design** — raised the disabled run's word count, `disabled run: expected exactly 8 delivered words (frame 0 only), got 1`, CI `build` run **`31064104902`**. **IC-J5** — *the in-flight frame is affected by the change*, REQ-803's own words — raised the **tuple comparison**, `frame 0's delivered (octets, tkeep, tlast, tuser) tuples differ between the disabled and reference runs`, run **`31064107507`**. **IC-J5's rule selected exactly one unit and produced no blast radius at all** — the only class of the five of which that is true, and the tuple comparison is the instrument no other class in the campaign reached. **Two kills, one row, and the row is qualified at two instruments rather than twice at one.** **Status left at `ASSERT`** | ASSERT |
| **M03-J4** | §4.3, §6.3 item 7, **C-14.5** | — | A change landing on the **exact cycle** of a start character has no determinate outcome and **SHALL NOT** be driven-and-asserted; every enable change in this plan is placed at least one cycle away from any start character. **NOT QUALIFIED, AND UNQUALIFIABLE BY SPECIFICATION — recorded 2026-08-10** (`WO-0076` §6.2 frozen at `8346a5c`, `WO-0076-VERDICT` §11 item 2 at `a8d6140`; landed here `J-dv_lead-0143`). SPEC-M03 §6.3 item 7 and **C-14.5** leave the same-cycle case deliberately **unconstrained**, so **every rendering of it is an equivalent mutant by specification** and no mutation class can be seeded against this row — not for want of a bench, but because there is no wrong answer to give. **No kill in the family-J campaign is evidence about this row in either direction**, and the consequence is stated here rather than left for a scorecard to imply: **a five-of-five family-J scorecard is NOT full coverage of §4.J.** Three of the four rows are qualified; the fourth cannot be, ever, by this instrument class. Status stays `NO-STIMULUS` | — | NO-STIMULUS |

> **FAMILY J — POST-CAMPAIGN STATUS, 2026-08-10 (`J-dv_lead-0143`, from
> `WO-0076-VERDICT`, adjudicated `J-dv_lead-0142` and committed at `a8d6140`).**
> **§4.J has never carried a landed-status block and this block does not invent
> one retrospectively.** The ground it replaces was laid in the rows' own dated
> cells and in another family's block, and all of it stands **unedited** with the
> outcome recorded beside it: `M03-J2`'s 2026-08-09 withdrawal (now measured by a
> run rather than argued), `M03-J1`'s `frame_in_exempt` clause (untouched by this
> campaign in either direction), and §4.N's landed-status block item (1), whose
> *"family J is not mutation-scored"* is annotated as paid where it stands. Every
> status word below travels with the SHA and the CI run id it was read at (§0.1;
> `RV-0068B-VERDICT` §7).
>
> **The campaign, with its identifiers, so no later packet re-derives them.**
> **Five** sealed intent classes, **five** rendered as blinded diffs, five
> transient branches each with sole parent **`8346a5c`**, each touching
> `libs/hardcaml_ethernet/src/xgmii_rx_64.ml` and nothing else and each carrying
> exactly one class. Packet and seal frozen together at `8346a5c`; pre-run
> reading note at `5ac62b5`; manifest at `2fbcf0d`; verdict at `a8d6140`.
>
> | class | the wrong design it renders | branch / head | `build` run | outcome |
> |---|---|---|---|---|
> | **IC-J1** | REQ-810's first sentence: the enable does not gate **admission** | `mut/wo-0076-j1` / `8aaa0dd` | **`31064102925`** | **KILLED**, 1 kill |
> | **IC-J2** | REQ-810's third prohibition: a **refused** frame is reported | `mut/wo-0076-j2` / `f61157b` | **`31064103812`** | **KILLED**, 1 kill |
> | **IC-J3** | `M03-J3`'s own Kills cell: the enable gates the **datapath** rather than the start character — rendered as **D-J3a's `add` branch**, the gate ADDED and not MOVED | `mut/wo-0076-j3` / `2296840` | **`31064104902`** | **KILLED**, 1 kill |
> | **IC-J4** | `M03-J2`'s **honest** kill: the re-enable is not honoured at the next start character | `mut/wo-0076-j4` / `1c1bfb1` | **`31064106060`** | **KILLED**, 1 kill |
> | **IC-J5** | REQ-803's own words: the in-flight frame is *affected* by the change | `mut/wo-0076-j5` / `8589bfd` | **`31064107507`** | **KILLED**, 1 kill |
> | **control** | nothing — the unmutated tree | `8346a5c` | **`31061945377`** | green at **every** step of `build` and of `cosim` |
>
> **5 of 5 sealed classes seeded. 5 KILLED. Zero survived, zero void.** The
> campaign maximum was 5 and it was reached. Every transient is `success` at the
> `build` job's **step 5** (Build) and `failure` at its **step 6** (tests), so
> **there is no build finding in this campaign** and every red it scores was
> raised by an assertion inside a mutant that compiled; `journal-check` is red on
> every transient **by construction** (a mutation commit stages a work product
> with no journal append — R2) and is evidence of nothing. Each branch is **one**
> commit, sole parent `8346a5c`, **one** file, sizes `+2/−2`, `+5/−1`, `+1/−1`,
> `+5/−2`, `+7/−1` in class order — verified through the API, so the shared-anchor
> hazard flagged at the pre-run note §3 (branches 1 and 4 replace the same two
> lines) **did not fire**.
>
> **This is the first campaign in the programme whose classes were PERMITTED to
> move the datapath**, so a global *nothing may move* check would have failed a
> conformant rendering and could not be the protection. **The protection was the
> ordering, and it is verified at the tree rather than asserted**: bench frozen at
> `c109c08`, seal at `8346a5c`, first diff text at `2fbcf0d`, verdict at
> `a8d6140`, and `git diff --name-only 8346a5c HEAD -- test/ libs/` is **empty**
> re-measured at *this* commit — **not one bench byte moved between the seal and
> the scorecards, mine included**. §6's pre-ship check was therefore delivered
> **per class**, in positive form, with the enable-high column discharged
> structurally.
>
> **Denominators, re-measured here rather than carried forward (§0.1)**:
> `bash tools/dv_checks.sh` at this commit reports **59** units under
> `test/xgmii_rx_64/` and **139** repository-wide, leaving **80** non-M03 = **79**
> behavioural + **1** build-level, with `test/cosim/` contributing **0** units.
> **The enable census is the census that decides this family**: exactly **four**
> units in the whole repository drive `cfg_rx_enable` away from `Enable.high` —
> `M03-J1`, `M03-J2`, `M03-J3` (two members) and `M03-N4` (two members) — and
> `test_m03_structural.ml`'s `Enable.change_cycles` unit references the module and
> **drives no design**. **Fifty-five of the fifty-nine M03 units never drive it at
> all.**
>
> **`FINDING M-4`'s repair is CONFIRMED at this tree, and the note that confirmed
> it is itself wrong — `FINDING AP-4`, against my own campaign text, clerical.**
> The repaired matcher in `tools/dv_checks.sh` is scoped by **file type** and
> reports **139**; the old directory-scoped form reports **141**. `WO-0076` §2
> attributes the step from 140 to 141 to *"`test/attack_plans/AP-xgmii_rx_64.md`
> gained two further prose quotations of the literal when the family-M campaign
> was absorbed"*. **Re-measured at the trees it names**: this file carries
> **exactly one** occurrence at `ca1bb80`, at `bb81fe5`, at `6f0fd5b`, at
> `c109c08`, at `8346a5c` and at HEAD — **unchanged, and already present before
> the family-M absorption** — and the file that grew is **`test/cosim/dune`**,
> which gained the literal at `c109c08` in the `WO-0075` round, inside a comment
> quoting the **corrected** command. **The conclusion is unaffected and is better
> supported than it was**: a counting instrument scoped to a directory rather than
> to a file type counts its own documentation, and here it counts two separate
> quotations **of its own repair**. What is false is the attribution. **This block
> deliberately does not quote the literal**, so the naive figure is still **141**
> after this commit.
>
> **MUST-STAY-GREEN: zero violations, zero scope findings, zero build findings —
> and it is a MEASUREMENT here rather than an inference.** A file appears in a
> transient's promotion block **iff at least one unit in it changed its expect
> output**, so the `--- FILE` list is a file-level scorecard. Under **every** class
> the only files promoted are `test/xgmii_rx_64/test_m03_j.ml` and
> `test/xgmii_rx_64/test_m03_n.ml`, and under **IC-J5 only the first**. **The 55
> enable-free M03 units, the 79 non-M03 behavioural units, the 1 build-level unit
> and `test/cosim/` held green under all five** — by construction and not by care,
> exactly as disclosure **D-J1b**'s enable-high invariance claimed structurally.
> **No fifth unit reddened under any class.**
>
> | Row | Campaign status | The evidence, not the adjective |
> |---|---|---|
> | **M03-J1** | **QUALIFIED — 2 classes, 2 kills**, on two distinct clauses of one Observable | IC-J1 at the silence scan's `tvalid` arm (run `31064102925`) and IC-J2 at the same scan's **strobe** arm (run `31064103812`). `FINDING J-1`'s narrow reading is now **measured** unreachable; its second half — the no-output-word clause having no Kills cell at all — is **owed**. |
> | **M03-J2** | **QUALIFIED — 1 class, 1 kill, ON ITS HONEST KILL ONLY** | IC-J4, `got 0` (run `31064106060`). **NOT qualified on the withdrawn continuous-sampling cell**, and IC-J3's green at this row is what proves the 2026-08-09 withdrawal was right — the plan's prohibition (`J-dv_lead-0124`) is **enforced here on evidence rather than merely quoted**. |
> | **M03-J3** | **QUALIFIED — 2 classes, 2 kills, at two different instruments** | IC-J3 at the disabled run's word count (run `31064104902`) and IC-J5 at the tuple comparison (run `31064107507`), the only class of the five whose rule selected exactly one unit. `FINDING J-2`: the strobe clause stays unfalsifiable in the **subtractive** direction. |
> | **M03-J4** | **NOT QUALIFIED and UNQUALIFIABLE BY SPECIFICATION** | §6.3 item 7 and C-14.5 leave the same-cycle case unconstrained, so every rendering is an **equivalent mutant by specification**. Zero kills, **not** a survivor, **not** a bench gap, and **not** closable by any campaign. |
> | **`M03-N4`'s own row** | **QUALIFIED BY NOTHING HERE — and, measured, by nothing anywhere** | Four reds, under IC-J1, IC-J2, IC-J3 and IC-J4; **every one is blast radius**. `FINDING AP-3` corrects the verdict's own softening: five reds across two campaigns, **zero qualifications**, and `M03-N1` is in the same position. |
>
> **THREE OF THE FOUR §4.J ROWS ARE QUALIFIED AND THE FOURTH CANNOT BE.** The
> campaign pays the debt on the three **oldest unscored rows in the programme**,
> landed at `2dbd39b` and passed over by eight campaigns before this one.
>
> **THE BLAST-RADIUS ACCOUNTING — AND THE VERDICT'S OWN RED TOTAL DOES NOT SURVIVE
> RE-MEASUREMENT: `FINDING AP-2`, against my own campaign text, minted by §0.1 at
> the point of citation.** `WO-0076-VERDICT` §2 says *"Fifteen reds across five
> classes"*; **its own scorecard table in the same section enumerates FOURTEEN**,
> and fourteen is what the per-class rows below sum to. This is `FINDING
> WO-0076-S2`'s defect — a document asserting a count of its own marked cells —
> at its **second** instance in the same document, and it is exactly the failure
> harvest candidate (E) was banked against one entry earlier. **The table governs;
> no cell changes class and no kill moves.** The plan carries **fourteen**.
>
> | class | reds that are BLAST RADIUS | what they do **NOT** qualify |
> |---|---|---|
> | IC-J1 | `M03-J2`, `M03-J3` (lane 0), `M03-N4` (lane 0) | **`M03-J2` and `M03-J3`** — both are qualified in this same campaign, by **other** classes and at **their own** cells, never by this one |
> | IC-J2 | `M03-J2`, `M03-J3` (lane 0), `M03-N4` (lane 0) | the same three, for the same reason |
> | IC-J3 | `M03-N4` (lane 0) | — |
> | IC-J4 | `M03-J1` (the monitor arm, not its own observable), `M03-N4` (lane 0) | **`M03-J1`** — its two kills are IC-J1's and IC-J2's, raised at its own Observable |
> | IC-J5 | — (its rule selected one unit) | — |
>
> **FOURTEEN REDS, FIVE KILLS: NINE REDS QUALIFY NOTHING.** Kills are counted
> **per class** (`WO-0066` §11) — IC-J1's four reds are **one** kill, never four,
> and IC-J1 and IC-J2 both qualifying `M03-J1` is **two kills and one
> qualification**, as is IC-J3 and IC-J5 at `M03-J3`. **`M03-N4` alone absorbs four
> of the nine**, and this is the second campaign in which it has done so.
>
> **AND THE COLLISION METHOD EARNED ITS KEEP ON EVIDENCE FOR THE FIRST TIME.**
> `FINDING WO-0074-S4`'s corrected rule — *a collision inventory is complete only
> if it is derived from the cross product of every class's predicted red set with
> every scored cell, never from the scored cells alone* — was carried into this
> seal as a bar on **precedent**. Both collisions it found **fired**, and the
> sealed integer **directions** separated them on the first reading with no
> residue: at `M03-J2`, IC-J1's sealed `> 8` derived **808** against IC-J4's sealed
> `< 8` derived **0**; at `M03-J3`, IC-J1's sealed `> 8` derived **16** against
> IC-J3's sealed `< 8` derived **1**. **Without those two inventory rows, two of
> five scored cells would have had no bench-side discriminator at all**, because
> the colliding class's own cell sits at a different unit. The bar is now a bar on
> **evidence**.
>
> **A THIRD COLLISION, AND A PROTECTION BANKED BECAUSE IT IS THE FIRST TIME IT HAS
> EXISTED.** IC-J3's two D-J3a branches — gate **MOVED** versus gate **ADDED** —
> were sealed as having **no discriminator this bench produces**, and the whole
> guard was the disclosure, at its fourth instance in this programme. This round
> the disclosure is **corroborated by an artefact**: `2296840` is `+1/−1` at a
> single site and a `move` rendering is not expressible as a one-line
> substitution. **A branch pair whose members differ in edit *shape* can therefore
> be checked against the transient's diffstat without reading a diff body** — a
> protection that survives an author who answers a disclosure carelessly.
>
> **HONEST BREADTH, STATED BECAUSE THE SCORECARD IS NOT PERMITTED TO IMPLY IT.**
> The three J units carry **22 DUT-observable assertions**; this campaign's five
> classes reached **7** — `M03-J1`'s two silence arms, `M03-J2`'s word count and
> empty-strobe check, `M03-J3`'s word count, tuple comparison and empty-strobe
> check. **Fifteen are probed by nothing here**, including every per-word assertion
> in `M03-J2` (cycle, `tkeep`, `tlast`/`tuser`, octets, sequence number), the whole
> reference run in `M03-J3`, its cycle comparison and its refusal check, and
> `M03-J1`'s control run. **Five kills at four units is not breadth.** *(This is
> the verdict's measurement at `a8d6140` §8, carried with its SHA under §0.1 and
> **not re-derived here** — and it is flagged rather than quoted silently, because
> three other prose figures in the same two documents did not survive
> re-measurement in this round. **Carrier for verifying it: the `SO-`**.)*
>
> **Every lane-4 member is UNOBSERVED — never a miss and never a pass.**
> `run_j3 ~lane:0` and `run_n4 ~row:"M03-N4 (lane 0)"` raised first under every
> class in which their units reddened, and **no lane-4 string appears anywhere in
> the campaign**. The manifest discharged both lanes term by term; the bench
> observed one.
>
> **THE FOUR FINDINGS CARRIED INTO THIS PLAN, AND THREE MORE MINTED BY WRITING IT.
> There is no finding against the manifest and no `BUG-`: every red is a seeded
> kill or its predicted radius.** They are recorded here because this plan is where
> a later seal's author and a later `SO-`'s author will look for them.
>
> 1. **`FINDING WO-0076-S1` (MINOR, against me — the seal's §5.4/§5.6).** The seal
>    quoted a monitor-arm message it had not measured, and **the arm that fired is
>    the one it omitted**: `assert_monitors_clean` has **five** arms, not four, and
>    in source order `": latency tagger errors:"` **precedes**
>    `": latency tagger unclean:"`. IC-J4's `M` cell raised the former; the seal
>    quoted the latter. **Cost nil to the score, and structurally rather than
>    luckily** — every disposition keyed on *which instrument spoke*, not on what
>    it printed. **But the near-miss is the point**: had that cell been sealed
>    `R!` instead of `M`, this round would have scored a **correct** rendering as
>    off-pattern on a string the bench never emits. **Carrier: the family-K seal**,
>    which owes the enumeration **measured at the source before any arm's form is
>    written**.
> 2. **`FINDING WO-0076-S2` (MINOR, against me — the seal's §3.1).** A matrix and
>    its own prose count disagree: §3.1 asserts **six** load-bearing greens and its
>    bullets describe six, while the matrix marks **five**. **Cost nil, because the
>    contested cell is green under both readings** — had it reddened, the round
>    would have had to decide whether a load-bearing measurement was lost, with no
>    rule to decide by and the result already known. **Carrier: the family-K seal**,
>    which owes cell counts **re-derived from the matrix rather than written beside
>    it**. *(And see `FINDING AP-2` above: the same defect recurred in the verdict
>    that filed this one.)*
> 3. **`FINDING J-1` — raised before the run, unrepaired, and MEASURED by it.**
>    Both halves stand, at `M03-J1`'s own cell. The first is now measured
>    unreachable rather than argued; **the second — REQ-810's first sentence having
>    no Kills cell at all — is OWED, and its carrier is the next round that opens
>    §4.J, at or before the `SO-`.**
> 4. **`FINDING J-2` — raised before the run, and the run confirms its asymmetry**,
>    at `M03-J3`'s own cell. The convicting carrier for the **subtractive**
>    direction is `M03-N4`, **which no campaign has qualified** — so the suppressing
>    design is, at this date, convicted by nothing that has run.
> 5. **`FINDING WO-0076-A1` (the auditor's, MINOR) — ADOPTED, widened against me,
>    and DISCHARGED HERE.** *A bare line number is a decaying citation, true only
>    at a SHA.* Widened at `J-dv_lead-0141` §5 from `libs/**` to **any** file cited
>    from outside itself, with a document-level SHA declaration admitted as an
>    equal discharge. **This plan's whole exposure was one citation, measured**, and
>    it is repaired at `M03-M5` into the `<path>:<line> @ <SHA>` form.
> 6. **`RN-4` — the broken allowlist path, clerical, and its repair does not touch
>    this plan.** `WO-0076` §7 item 4 admitted `docs/adr/ADR-0014.md`, **a file that
>    has never existed**; the ADR is
>    `docs/adr/ADR-0014-an-enable-gates-admission-not-the-wire.md`. The auditor
>    found it by listing the directory to check the path it had been handed,
>    **honoured the narrower of two disagreeing instruments and read the ADR under
>    neither name**, and the round's cost was nil — which is luck, not design. **The
>    repair was made in the dated pre-run note and §7's body was deliberately not
>    rewritten**: an allowlist is a normative instrument another agent has already
>    worked under and disclosed compliance against, and a correction that is
>    appended and journalled is diffable where one patched into the body is not.
>    **This plan's own exposure is NIL and it is measured, not assumed**: it cites
>    **no** `docs/adr/` path anywhere, naming the ADR by number in four places, so
>    nothing here decays. The full filename is recorded in this item so that a
>    later instrument citing the ADR **from** this plan has a path that resolves.
> 7. **`FINDING AP-2`, `FINDING AP-3`, `FINDING AP-4` — minted here, all three
>    against my own campaign text, all three found by §0.1 at the point of
>    citation.** AP-2: the verdict's *"fifteen reds"* against its own table's
>    fourteen. AP-3: the packet's and the verdict's *"`M03-N4` already scored at
>    `WO-0066`"*, false — `WO-0066` qualified `M03-N2`, `M03-B2` and `M03-B4`
>    member (b), and its §13 item 2 calls `M03-N1`/`M03-N4` *"both still outstanding
>    ASSERT rows"* whose bench did not yet exist. AP-4: the contamination
>    attribution above. **Only AP-3 costs anything, and what it costs is a reader's
>    confidence rather than a score**: it removes an unearned reassurance about a
>    landed green row that no campaign has ever qualified. **`FINDING AP-1` was
>    §0.1's first conviction at citation; this round produced three more in one
>    sitting, which is the argument for the rule and not against it.**
>
> **ERA TALLY**, class-based, `WO-0050` onward, carried here because this plan is
> where the classes are argued:
>
> | | sealed | killed | survived | void by declaration |
> |---|---|---|---|---|
> | before this campaign (`WO-0074-VERDICT` §12) | 49 | 47 | 1 | 1 |
> | **family J (this campaign)** | **+5** | **+5** | **+0** | **+0** |
> | **after** | **54** | **52** | **1** | **1** |
>
> 52 + 1 + 1 = 54. The single survivor remains `G-c4` (`FINDING G-1`); the single
> void remains `IC-M5`. **Family J is the fourth campaign in the era to return a
> clean sweep, and the first whose classes were permitted to move the datapath.**
>
> **What this does and does not buy** — every clause a refusal the scorecard would
> otherwise be read as granting.
>
> 1. **Qualification measures an instrument; it discharges no row and moves no
>    discharge count.** **The census is unmoved and that is the rule, not an
>    oversight: 62 of 62**, re-measured at this commit by `tools/dv_checks.sh` —
>    **78** row ids declared, **62** named in a committed unit title under both the
>    trailing-digit boundary matcher and the naive one, − `M03-A4` (NO-ASSERT,
>    named in a title) + `M03-F5` (by citation) = **62**; the ASSERT denominator
>    counted from this file's own status cells in the same pass, before and after
>    these edits. **No unit and no title moved in this round.**
> 2. **The differential co-simulation anchor is blind to this entire campaign, and
>    the ground is STIMULUS rather than grammar.** The `cosim` job is `success`
>    under all five classes and at the control; **that green is worth nothing and
>    no verdict may cite it.** Both producers hold `cfg_rx_enable` at 1 for the
>    whole run (`test/cosim/ours_run.ml:142` and `test/cosim/tb_xgmii_rx_64.v:63`,
>    both at `8346a5c`) and the lane drives one 64-octet good-FCS frame with **no
>    configuration change anywhere**. This is §7's **bar 4** at its second instance
>    and its purest: at family M the blindness had three candidate causes and the
>    verdict named the wrong one; **here there is exactly one, because the port
>    under test is never driven.** A strobe field, a cycle column or a wider
>    canonical form would change nothing. **Discharged only by a co-simulation
>    stimulus that drives the enable**, which REQ-901's class list does not contain.
> 3. **A full five-of-five scorecard is NOT full coverage of §4.J** — see `M03-J4`.
> 4. **REQ-802 / §9.1's reset value for `receive enable` is never observed at this
>    bench, and no `SO-` may count §9.1's reset column as covered by family J.**
>    Recorded here rather than in §6 on the family-M precedent: §6's row set is
>    **unchanged** by this round, and a refusal about what a coverage line does not
>    buy belongs where the classes are argued.
> 5. **REQ-810's header-record prohibition has no instance at M03** — M03 emits no
>    header record, so `M03-J1`'s *"no header effect"* clause is discharged **by the
>    interface, not by a test**. Same disposition as `M03-M9`'s.
> 6. **The `Bench.Enable` guard and its structural witness are unreachable by any
>    mutation, and neither fired.** The guard's *entry* condition remains
>    mechanically witnessed and its *refusal* has still never fired on a real
>    violation: **a half-measured instrument, unchanged by this round in either
>    direction.**
> 7. **The portable form, and the score does not move it** (seal §6.8): **a family
>    whose rows drive a configuration input away from its default has its whole
>    convicting power bounded by the number of tests that drive it — four of
>    fifty-nine here — and that number is invisible in a coverage count**, because
>    every other test still exercises the module. **Five kills do not change it.** A
>    coverage claim over a configuration requirement must state how many stimuli
>    reach the non-default value, or it is reporting the size of the suite instead
>    of the size of the evidence.
> 8. **A kill proves the assertion convicts, never that the bench is a general
>    detector of the class.** IC-J1 was detected at four units; **this bench was not
>    blind to it**, and no reading of this block may imply it was.
> 9. **`DECLARATION J-D1` is MEASURED on the `add` branch and its strongest form
>    remains DERIVED** — U-4 at §7, with the bar restated at `M03-J1`'s own
>    Observable.
> 10. **Nothing in `test/**` is owed by this result and nothing in `test/**` moves
>    in this round.** The carried carriers are unchanged and are recorded at their
>    rows: `WO-0047` §2's 4-octet member reorder (`test_m03_f.ml`), `OBSERVATION
>    L-O1` (`test_m03_l.ml`), `WO-0073-D3`'s `M03-I4` mislabel (`test_m03_i.ml`)
>    and `OBSERVATION K-O1` (`test/monitors/`). **A plan round is not where a
>    carrier is improved** (`J-dv_lead-0112`).
> 11. **No `SO-xgmii_rx_64.md` is opened or offered.** Outstanding before any PASS:
>    the family **K** campaign — the last of the era — and the charter §3
>    verilog-ethernet differential co-sim anchor, undischarged and now blind **per
>    configuration class** as well as per stimulus class and per strobe. **The
>    lessons harvest falls due at the `SO-`**, not at a campaign verdict and not at
>    a plan round; the span since my last harvest stays **open and declared, never
>    skipped**, with candidates (C), (D) and (E) banked at `J-dv_lead-0141` and
>    `J-dv_lead-0142` and the three from `J-dv_lead-0137` untouched and unadmitted
>    here.

### 4.K Reset — REQ-009, §7

| Row | Attacks | Stimulus | Observable | Kills | Status |
|---|---|---|---|---|---|
| **M03-K1** | REQ-009 | `clear` = 1 for 5 cycles while no frame is in flight | `tvalid` = 0 and all five strobes 0 on every `clear` cycle **and on the first cycle after it returns to 0**. **AND WHAT THIS OBSERVABLE'S SILENCE CANNOT SAY — `DECLARATION K-D1`, declared before the family-K campaign ran and MEASURED by it, 2026-08-11** (the campaign seal's **§6.6**, frozen at `aced7b4`; `WO-0077-VERDICT` §10 item 1 at `d6fdf92`, adjudicated `J-dv_lead-0147`; landed here `J-dv_lead-0148`). *A row whose stimulus places its window over an interval in which a conformant design has **nothing pending and nothing arriving** can be convicted only by a defect that **CARRIES** an observable into that interval — never by one that merely fails to suppress.* **The partition the campaign produced is not close and it is not an inference**: this row went **GREEN** under `IC-K1`, `IC-K2`, `IC-K3`, `IC-K5` and `IC-K6` — five defects that fail to suppress, five distinct REQ-009 clauses between them — and **RED** under `IC-K4` alone, the one class in the campaign that carries. **No `SO-`, campaign or verdict may cite this row's green as evidence that a `clear` window suppresses anything, and this silence scan is satisfied by a design that does nothing at all under `clear`.** The declaration is about the **placement of this row's window**, not about `clear`: it transfers to any row whose observable is silence over a quiet interval, which is why it is homed as **U-5** at §7 rather than left here alone | **ONE OF THE TWO STATED CLASSES IS NOT SEPARATED BY THIS ROW'S OWN STIMULUS AND THE CLAIM IS WITHDRAWN — 2026-08-09 (`WO-0072` §7.5, derived `J-dv_lead-0130`; landed here `J-dv_lead-0132`). The defect is this plan's, not the bench's, and it was found the way the five before it were found — by working the row's own arithmetic while authoring the packet that commissions it, before a bench existed.** **Kill (a) — *"a design whose strobe registers survive `clear`"* — is REACHABLE and tightly placed.** M03's strobes are combinational in the current XGMII word (SPEC-M03 §6.1's one-word lookahead; `BUG-0001`'s R-1 finding is the evidence), so an implementation that registers a strobe output and does not gate that register with `clear` re-presents the pre-clear pulse **inside** the window; **opening the window on the cycle immediately after the frame's own strobe is what makes that class reachable at all**, which is why the placement is tight rather than comfortable. *The superseded second class, kept beneath the strike because the argument that retired it is only readable against it:* ~~"or that needs a second cycle to settle"~~ (the cell's own words, quoted with nothing added inside the quotation marks). **Why this stimulus cannot reach it**: a design whose `clear` takes effect one cycle **late** behaves un-cleared on the first window cycle — where a conformant design also produces nothing, because the frame drained before the window opened — and a design needing an extra cycle to go quiet **after release** has nothing pending to show on the release cycle. Both are **invisible here**. The only member of the class this stimulus does separate is narrow — a design that *suppresses without resetting* and re-presents the suppressed strobe on the release cycle — and that is caught, but it is **not** the general class the cell named. **THE HONEST KILL, AND IT IS THIS ROW'S OWN**: *a design whose strobe path survives `clear` — either by presenting a pre-clear strobe inside the window, or by holding it suppressed and re-presenting it on the release cycle* — plus, from the row's mandatory control run, *a design whose clear gating is off by one cycle at the leading edge*. **Where the withdrawn class DOES live: M03-K2**, whose window opens over a frame with six output words still to come and closes on a cycle carrying a start character, so a design needing an extra settling cycle either emits a held word on the release cycle or fails to accept that start character — both asserted there. **Disposition, and it is the M03-D3 / M03-F2 / M03-I2 / M03-J2 / M03-N4 precedent applied unchanged at its SIXTH instance**: the row **stays ASSERT**, because its *observable* is REQ-009's own words and §4.K commissions it in terms. What the finding changes is **the claim a round may make about this row**, never its status — and **no `SO-`, campaign scorecard or verdict may cite M03-K1 as detecting a design that needs a second cycle to settle**. **QUALIFIED — 1 class, 1 kill, ON THE FIRST DISJUNCT OF THE HONEST KILL AND ON NOTHING ELSE** (2026-08-11, `WO-0077-VERDICT` §3.4 and §6 at `d6fdf92`; campaign packet and seal frozen at `aced7b4`, manifest at `f9232c2`, pre-run rulings at `04078fd`, adjudicated `J-dv_lead-0147`; landed here `J-dv_lead-0148`). **IC-K4** — *the strobe path survives `clear`*, seeded against this cell's **honest kill in its own words** — raised this row's strobe-count assertion, `M03-K1: expected exactly one strobe pulse (error_bad_fcs only), observed 2`, at `test/xgmii_rx_64/test_m03_k.ml:257 @ 22ffe13`, CI `build` run **`31075094473`**. **The mutant-owned integer was sealed as an inequality with a direction and two named derivations, and the run settles which one ran**: `> 1`, **more**, deriving **2** under *one presentation* and **7** under *a level held across the window and its release*; the manifest disclosed `D-K4b` = one presentation and `D-K4a` = **α**, the window's first cycle; **observed 2**. Seal inequality, direction and disclosed derivation agree with the run in every particular. **The pre-fixed CARRY-versus-RE-TIMING discriminator did not fire, and that is stated rather than assumed**: the alternative message `M03-K1: error_bad_fcs pulsed on cycle <c>, expected 11` appears **nowhere** in the run and **no strobe assertion at any other family reddened**, so the rendering is a carry conditional on the neighbourhood of a `clear` and not a plain re-timing — seal §5.6 **outcome 1** governs and outcome 2 is retired by the run instead of by an argument. **THE PRE-COMMITTED *UNQUALIFIABLE BY MUTATION* DECLARATION DOES NOT FIRE**: `WO-0077` §13 fixed that disposition against this row had `IC-K4` come back `NOT SEEDED`; it was seeded, it killed, and **no `SO-` inherits the declaration**. **WHAT THE QUALIFICATION DOES NOT REACH — one of three, and the scope is why it is recorded.** The honest kill above names **three** wrong designs and this campaign rendered **one**. Member **α** — *presenting a pre-clear strobe inside the window* — killed. Member **β** — *holding it suppressed and re-presenting it on the release cycle* — was **rendered by no class**, and that is on file before the run rather than inferred after it (`D-K4a` = α). The third clause — *a design whose `clear` gating is off by one cycle at the leading edge, from this row's mandatory control run* — was rendered by **nothing in this campaign** either. **No `SO-`, campaign or verdict may read this row's qualification as covering the other two.** **AND THE 2026-08-09 WITHDRAWAL ABOVE IS NOW ESTABLISHED FROM A RUN RATHER THAN FROM AN ARGUMENT — this campaign's centrepiece, and it is this row's.** `IC-K5` **is** the withdrawn design: a `clear` gate honoured one cycle late **at both edges** (`D-K5a` = both), seeded from this cell's own derivation and from nothing else. It reddened **`M03-K2`** and left **`M03-K1` GREEN** (run **`31075095600`**) — precisely the outcome this cell derived before a bench existed, and precisely at the row this cell named as the class's home. **The programme argued this withdrawal for four rounds without ever running the design it withdrew; the design has now been run.** The prohibition is therefore not softened by this row's own kill but enforced on evidence: **IC-K5's green here is evidence FOR the prohibition, never an exception to it** — the `M03-J2`/`IC-J3` pattern one family over, at its second instance, and both instances now measured. **Status left at `ASSERT`** (`J-dv_lead-0109`: §1's status vocabulary is a closed set of six values and `QUALIFIED` is not one of them) | ASSERT |
| **M03-K2** | REQ-009, §7's reset bullet | `clear` asserted **mid-frame**, deasserted, and a new frame whose start character arrives on the **first** cycle after `clear` returns to 0 | The in-flight frame vanishes with **no `tlast` and no strobe**; the new frame is received correctly and completely. The conservation monitor records the abandoned frame as `frame_in_exempt ~reason:"clear"` — without that exemption a conformant M03 fails (C-2 at its first module) | A design that emits a `tlast` on `clear` (a phantom frame downstream); a design that needs one idle cycle before it can accept a start character; a monitor that counts the abandonment as a silent discard. **ALL THREE CELLS STAND, NO KILL IS WITHDRAWN, AND THE THIRD IS RECLASSIFIED — 2026-08-09 (`WO-0072` §8.6, `J-dv_lead-0130`; landed here `J-dv_lead-0132`).** **Kill 1 is reachable at THREE distinct sites** and is this row's principal attack: at the window's **opening** edge (a design reading `clear` as *"close the current frame"* rather than *"abandon it"*), at the **release** edge (a design that holds the abandoned frame's closure and emits it when `clear` lifts), and at **frame A's own terminate character inside the window** (a design that latches the `/T/` while cleared and closes on release) — the third site existing only because the window was placed to cover A's `/T/`, on §6.2's `Idle` row (*"ignores every lane"*), which is unambiguous for `/T/`. **Kill 2 is reachable and is the tightest legal placement**: REQ-009's last sentence names the release cycle specifically and the new frame's start character is on it, so a design needing an idle cycle first either delivers nothing for that frame or delivers it late, and the row's delivered-cycle list separates both. **Kill 3 — *"a monitor that counts the abandonment as a silent discard"* — IS NOT A DESIGN KILL, and it is RECLASSIFIED rather than dropped.** The call is the row's own; **no design can cause it to be wrong**. What the cell states correctly is that the **C-2 exemption path is a PRECONDITION of the row**: with `frame_in` in place of `frame_in_exempt`, a *conformant* M03 shows `residual` = 1 and the round reds. So it is a statement about the **monitor contract**, discharged by the row's own `frames_exempt` = 1 assertion — **not an attack this row mounts against the DUT, and no `SO-` may count it as one.** The cell is **true as written**; what it is not is a design kill, and that distinction is recorded here rather than repaired away. **QUALIFIED — 5 classes, 5 kills, ONE qualification, on five distinct clauses of REQ-009** (2026-08-11, `WO-0077-VERDICT` §3.1–§3.3, §3.5, §3.6 and §6 at `d6fdf92`; seal frozen at `aced7b4`, manifest at `f9232c2`, adjudicated `J-dv_lead-0147`; landed here `J-dv_lead-0148`). Kills are counted **per class** (`WO-0066` §11), so five kills at one row are **five kills and one qualification**. **IC-K1** — *`clear` closes the in-flight frame instead of abandoning it*, this cell's **kill 1** at the window's **opening** edge (`D-K1a` site (i), `tlast` on cycle 6) — on REQ-009's *"no `tlast` … is emitted for it"*, run **`31075090344`**. **IC-K2** — *the abandoned frame is reported* — on REQ-009's *"and no strobe"*, run **`31075091506`**, raised at `test/xgmii_rx_64/test_m03_k.ml:511 @ 22ffe13` with `M03-K2: error_pulses is not empty -- A vanishes with no strobe (REQ-009) and B is clean`; disclosed `D-K2a` = `error_oversize`, cycle 6, `D-K2b` = one pulse, **neither of which the cell prints**, so the disclosure is the whole record of what was rendered and it is on file before the run. **IC-K3** — *the release cycle is not available*, this cell's **kill 2** — on REQ-009's last sentence, run **`31075093097`**; `WO-0072` §9's **D2** is exercised for the first time against a design that holds the defect, and in its first disjunct (`D-K3a` = refused entirely). **IC-K5** — *the `clear` window honoured one cycle late at both edges* — on REQ-009's two-conjunct silence clause, run **`31075095600`**; **this kill is this row's and never `M03-K1`'s**, per `WO-0077` §5 item 9, and no cell qualifies `M03-K1` on the withdrawn *"needs a second cycle to settle"* class. **IC-K6** — *`clear` gates the state machine but not the output stream*, `WO-0072` §9's **D3** first disjunct — on REQ-009's *"every `tvalid` output SHALL be 0"*, run **`31075096955`**; `D-K6a` = exactly one window cycle leaks, the first, and the release cycle does not, so the rendering breaks REQ-009's **first** conjunct and leaves its **second** intact. **KILL 1 IS QUALIFIED AT ONE OF ITS THREE SITES AND THE OTHER TWO ARE UNTOUCHED**: the cell names the opening edge, the release edge and frame A's own terminate character inside the window, and only the **opening edge** was rendered. **KILL 2 IS QUALIFIED**, by IC-K3, at the tightest legal placement the cell claims for it. **KILL 3 is unchanged in every respect** — it is not a design kill, no campaign can render it, and this round neither confirms nor disturbs the 2026-08-09 reclassification. **Status left at `ASSERT`** (`J-dv_lead-0109`). **AND `FINDING K-1` IS MEASURED HERE, AND THE RUN IS WORSE THAN THE SEAL SAID** (raised `J-dv_lead-0145` before the campaign ran, measured `WO-0077-VERDICT` §3.7; both halves stand; landed here `J-dv_lead-0148`). The seal predicted that IC-K1, IC-K3, IC-K5 and IC-K6 would raise **one message, character for character, with no observed data** — all four at `test_m03_k.ml:468 @ 22ffe13`, `M03-K2: the delivered-cycle list is not [4;5;14;15;16;17;18;19;20;21] -- the precondition every partition below depends on`. **The run produces something stronger than an identical message: an identical FILE.** `dune`'s own `git diff --no-index` header reports the promoted source's blob on every branch — **`373f32a` under IC-K1, IC-K3, IC-K5 and IC-K6 alike**, against `dd13100` under IC-K2 and `a851663` under IC-K4. **Four classes, four distinct defects, four distinct REQ-009 clauses, one byte-identical artefact.** So `WO-0072` §9's pre-committed disposition table is confirmed **from a run** to be a taxonomy and not a discriminator, and the discrimination that did the campaign's work was the **branch identity and the disclosures** — never anything this bench emitted. **Seal §8 collision 3 fired exactly as sealed**: IC-K1 site (i) and IC-K6 with one leaked cycle produce the same *observed list* as well as the same message, separated only by a `tlast` bit **no assertion this round reaches**. **Every assertion in this unit is correct and nothing in `test/**` is owed by this result**; what is owed is a **message** that names the partition it failed at, and its carrier is unchanged and is **not this plan**: the next commit that opens `test_m03_k.ml`. **AND `FINDING WO-0077-K2` (MINOR, mine, against `WO-0072` §9's D3 row) IS DEMONSTRATED BY THE ROUND THAT MINTED IT** (`RN-4`, ruled before the run at `J-dv_lead-0146`; measured `WO-0077-VERDICT` §3.8). D3 hides **two** different defects in one disjunction — a leaked word, and a strobe pulsed for the frame `clear` abandoned — with one `BUG-` citation between them, and none of the table's other six classes owns the added-report case. **The round rendered both members and the instrument separated them**: IC-K6 raised at `:468` (the delivered-cycle list), IC-K2 at `:511` (the strobe set) — two classes, two assertions, two strings, and the verdict reports them as two classes and **never as "D3 twice"**. **The repair of record stands as ruled: D3 splits into D3a** (a leaked word, REQ-009's first clause) **and D3b** (a strobe pulsed for the abandoned frame, REQ-009's no-strobe clause). **The contrast the two findings draw is now measured and neither subsumes the other**: `K-1` is under-discrimination the instrument **cannot repair**, `WO-0077-K2` is under-discrimination the instrument **already exceeds** | ASSERT |
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

> **FAMILY K — POST-CAMPAIGN STATUS, 2026-08-11 (`J-dv_lead-0148`, from
> `WO-0077-VERDICT`, adjudicated `J-dv_lead-0147` and committed at `d6fdf92`).
> THE BLOCK ABOVE IS KEPT AND ITS GROUND IS REPLACED.** Every status word there
> was measured against a landed bench and none of it is withdrawn. Its item (1)
> declared the family **J, K, L and M** campaigns outstanding; **all four have now
> run**, and this one was the last of the era. Its item (4)'s riders all stand and
> two of them are now measured rather than argued (`M03-K1`'s withdrawn class,
> `M03-K2`'s reclassified third kill). Its item (5) — *neither pre-scan guard has
> ever fired on a real violation* — is **unchanged in both directions** and is
> re-stated below rather than quietly dropped. Every status word here travels with
> the SHA and the CI run id it was read at (§0.1; `RV-0068B-VERDICT` §7).
>
> **This block carries the WHOLE campaign's shared accounting — both sections —
> because one campaign scored two families, and a second copy is how two counts
> drift apart** (`FINDING WO-0076-S2` / `FINDING AP-2`, the same defect twice).
> §4.N's post-campaign block carries the **N-section's own** results and cites this
> table for everything shared; neither block restates the other's numbers.
>
> **The campaign, with its identifiers, so no later packet re-derives them.**
> **Nine** sealed intent classes across **two separately-sealed sections** — six in
> §K, three in §N — **nine** rendered as blinded diffs, nine transient branches each
> cut **fresh** from sole parent **`aced7b4`**, each touching
> `libs/hardcaml_ethernet/src/xgmii_rx_64.ml` and nothing else and each carrying
> exactly one class. Bench frozen at **`22ffe13`**; packet and seal frozen together
> at **`aced7b4`**; pre-run rulings `RN-1 … RN-6` at **`04078fd`**; manifest at
> **`f9232c2`**; verdict at **`d6fdf92`**.
>
> | class | the wrong design it renders | branch / head | `build` run | `cosim` | outcome |
> |---|---|---|---|---|---|
> | **IC-K1** | `WO-0072` §9's **D1**: `clear` **closes** the in-flight frame instead of abandoning it — the phantom frame | `mut/wo-0077-k1` / `519c212a` | **`31075090344`** | success | **KILLED**, 1 kill |
> | **IC-K2** | REQ-009's no-strobe clause: the **abandoned** frame is reported | `mut/wo-0077-k2` / `a46b2c7b` | **`31075091506`** | success | **KILLED**, 1 kill |
> | **IC-K3** | `WO-0072` §9's **D2**: the **release cycle** is not available | `mut/wo-0077-k3` / `37dd14e1` | **`31075093097`** | **failure** — §9.1 | **KILLED**, 1 kill |
> | **IC-K4** | `M03-K1`'s **honest kill**, member α: the strobe path survives `clear` | `mut/wo-0077-k4` / `b6fd2c66` | **`31075094473`** | success | **KILLED**, 1 kill |
> | **IC-K5** | `WO-0072` §7.5's **withdrawn** class: the `clear` window honoured one cycle **late**, both edges | `mut/wo-0077-k5` / `abd053dc` | **`31075095600`** | **failure** — §9.1 | **KILLED**, 1 kill |
> | **IC-K6** | `WO-0072` §9's **D3** first disjunct: `clear` gates the state machine but not the output stream | `mut/wo-0077-k6` / `b614fc8e` | **`31075096955`** | success | **KILLED**, 1 kill |
> | **IC-N1** | `M03-N1`'s own Kills cell: every control lane of an input word routed against the state the word **started** in | `mut/wo-0077-n1` / `01fdbe7d` | **`31075098067`** | success | **KILLED**, 1 kill |
> | **IC-N4a** | `M03-N4`'s abort geometry: the refused start character does not abort the in-flight frame | `mut/wo-0077-n4a` / `6cb3b12c` | **`31075099649`** | success | **KILLED**, 1 kill |
> | **IC-N4b** | `M03-N4`'s report clause: the report path is gated by the enable, so the in-flight frame's own abort report is suppressed | `mut/wo-0077-n4b` / `d43bc33c` | **`31075100851`** | success | **KILLED**, 1 kill |
> | **control** | nothing — the unmutated tree | working branch / `aced7b41` | **`31072617706`** | success | green at **every** step of `build` and of `cosim` |
>
> **9 of 9 sealed classes seeded. 9 KILLED. Zero survived, zero green by
> blindness, zero void.** Step 5 `Build` is `success` on all nine, so **there is no
> build finding in this campaign** and every red it scores was raised by an
> assertion inside a mutant that elaborated; `journal-check` is red on every
> transient **by construction** (a work product with no journal append — R2) and is
> evidence of nothing.
>
> **THE SHARED-ANCHOR HAZARD DID NOT FIRE, AND THE REASON IS THE OPERATOR'S CUT.**
> Branches `k4` and `n4b` both rewrite line 990 of the mutated file and **each
> anchor contains the other's**; a sequential cut would have carried two classes and
> made both unscoreable. Each was cut **fresh from `aced7b4`**, and the run shows it:
> `k4` reddens `M03-K1` **alone**, `n4b` reddens `M03-N4` **alone**, neither carries
> the other's observable anywhere. **`FINDING WO-0074-A1`'s regime — the operator
> cuts and reports branch and run id per class — paid for itself more visibly here
> than in any round before it: without that report, four of six K classes would have
> been unadjudicable**, because they are separated by nothing else (see `FINDING
> K-1` at `M03-K2`'s cell).
>
> | Row | Campaign status | The evidence, not the adjective |
> |---|---|---|
> | **M03-K2** | **QUALIFIED — 5 classes, 5 kills, ONE qualification**, on five distinct clauses of REQ-009 | IC-K1, IC-K2, IC-K3, IC-K5, IC-K6 (runs `31075090344`, `31075091506`, `31075093097`, `31075095600`, `31075096955`). Kill 1 qualified at **one of its three sites**; kill 2 qualified; kill 3 is not a design kill and no campaign can render it. |
> | **M03-K1** | **QUALIFIED — 1 class, 1 kill**, by the only class in the campaign that could | IC-K4 (run `31075094473`), on REQ-009's *"every strobe SHALL be 0"*, with the mutant-owned integer **2** matching the seal's inequality, direction and disclosed derivation. **`DECLARATION K-D1` measured**: green under all five fail-to-suppress classes, red under the one that carries. |
> | **M03-K3** | **UNSCORED AND UNSCOREABLE** | `NO-ASSERT`. It survives any outcome, and **no kill anywhere in this round is evidence about it in either direction**. A nine-of-nine scorecard is **not** full coverage of §4.K. |
>
> **BOTH §4.K ASSERT ROWS ARE NOW QUALIFIED, AND THE THIRD ROW CANNOT BE.** With
> §4.N's two, **the era's last campaign removes the last campaign debt in this
> module: no landed, green, unscored row remains.**
>
> **THE BLAST-RADIUS ACCOUNTING — and the K section produced none at all.** Under
> every K class the only file promoted in the whole repository is
> `test/xgmii_rx_64/test_m03_k.ml`, and each class reddens exactly one of the two K
> units. **Six classes, six reds, six kills, zero blast radius**, and the ground is
> the **clear census** rather than luck: measured at the base tree, **exactly two
> units in the whole repository drive `clear` high during a schedule — `M03-K1` and
> `M03-K2` — while fifty-seven of the fifty-nine M03 units and all seventy-nine
> non-M03 behavioural units drive `Clear.never`.** *(No claim is made here about
> whether an earlier campaign in this plan also produced none; that is a set claim
> over nine campaigns and §0.1 forbids asserting it unmeasured.)* **Family K owns 2
> of the 59, and its packet's comparison — *"the narrowest instrument footprint of
> any campaign in this era, narrower than family J's four"* — is carried here with
> the tree it was measured at (`WO-0077` §3.1, measured at `22ffe13`/`aced7b4`) and
> is NOT re-derived by this plan, per §0.1. It is a property of what family K IS,
> not of what its packet chose.** The N
> section's radius is a different story and is accounted at §4.N.
>
> **THE K × N CROSS PRODUCT — EIGHTEEN PREDICTED GREENS, ALL EIGHTEEN HELD.** Six K
> classes × the two N units and three N classes × the two K units, enumerated
> **before** the round ran under `FINDING WO-0074-S4`'s method, and reported
> individually in the verdict. `test_m03_n.ml` is untouched on all six K branches;
> `test_m03_k.ml` is untouched on all three N branches. **The two-section structure
> is vindicated on evidence rather than on the argument that recommended it**, and
> the ruling that adopted one campaign rather than two cost this round nothing. Nine
> further cells against the three family-J units also held, including the
> load-bearing one at `M03-J3` (§4.N's block, `FINDING J-2`). **Every `G!` in the
> seal held — seven of seven.**
>
> **MUST-STAY-GREEN — met over every unit, and FAILED at one producer that is not a
> unit.** The **79** non-M03 behavioural units and the **1** build-level unit are
> green under all nine classes; no file outside `test/xgmii_rx_64/` was promoted in
> any of the nine runs. The **57** clear-free M03 units are green under all six K
> classes and the **55** enable-free M03 units under IC-N4a and IC-N4b. **No red
> anywhere arrived through `assert_monitors_clean`'s five arms, no bench-side `test
> bug --` message fired and no driven-port `clear`/`enable` guard fired, in any of
> the nine runs**: every red in this campaign is a unit's own DUT-observable
> assertion. **The failure is `FINDING WO-0077-A1` (§9.1 of the verdict): `test/cosim/`
> reddened under IC-K3 and IC-K5, and my own seal had declared before the run that
> no class could reach it.** Its record is at **§7, beside bar 4**, because it is a
> statement about the anchor and not about a row; **both kills stand and both
> qualifications stand**, because `test/cosim/` contributes **zero** units and the
> rules whose quantifier ranges over units are not falsified.
>
> **HONEST BREADTH, STATED BECAUSE THE SCORECARD IS NOT PERMITTED TO IMPLY IT.**
> Counted exactly at scored cells: **SIX distinct raise sites in FOUR units of
> fifty-nine** — `test_m03_k.ml:468` (IC-K1, IC-K3, IC-K5 **and** IC-K6: four
> classes, **one** site), `:511` (IC-K2), `:257` (IC-K4), `test_m03_n.ml:936–941`
> (IC-N1), `:1302` (IC-N4a), `:1421` (IC-N4b), all read at `22ffe13` and unmoved at
> this commit. Including blast radius: **nine sites in six units of fifty-nine.**
> The measured upper bounds, quoted with the commands that are their own provenance
> — `grep -cE '(^|[^_a-zA-Z])fail($| )' test/xgmii_rx_64/test_m03_k.ml` → **95**
> lines, **3** of them `test bug`; the same over `test_m03_n.ml` → **94**, **33** of
> them `test bug` — are upper bounds and nothing finer. **And the thing a reader
> would assume and must not: in a campaign about `clear`, NEITHER K silence scan and
> NEITHER K control run was reached by any class**, nor `M03-K1`'s delivered-word
> count, nor any per-word assertion in either K unit, nor any conservation or
> protocol counter, nor `word_delay`, nor `frames_compared`. **Nine of nine is the
> number; what it measures is narrower than the number sounds.**
>
> **ERA TALLY**, class-based, `WO-0050` onward, carried here because this plan is
> where the classes are argued — **and the era CLOSES at this row.** The column set
> is the five-column one family M's round minted; the four-column tables in the
> §4.L, §4.M and §4.J blocks are their own rounds' and are not amended.
>
> | | sealed | killed | survived | green by blindness | void by declaration |
> |---|---|---|---|---|---|
> | before this campaign (`WO-0076-VERDICT` §12) | 54 | 52 | 1 | 0 | 1 |
> | **`WO-0077` (this campaign, both sections)** | **+9** | **+9** | **+0** | **+0** | **+0** |
> | **era at close** | **63** | **61** | **1** | **0** | **1** |
>
> **61 + 1 + 0 + 1 = 63.** `WO-0077` §14 fixed the ceiling at **61 killed** before
> the round and `RN-5` retired the ten-void floor before a branch existed; **the
> ceiling is reached exactly.** The single survivor remains **`G-c4`**
> (`FINDING G-1`); the single void remains **`IC-M5`** (`M03-M5`'s cell). **The
> GREEN-BY-BLINDNESS column is empty and that is NOT the same as saying no blindness
> was found**: it is empty because no class went green at a cell the seal marked
> `G✱`, and this round's blindness result runs the **other** way — a cell I declared
> green by blindness came back **red** (`FINDING WO-0077-A1`).
>
> **THE FINDINGS THIS ROUND CARRIES, recorded here because this plan is where a
> later seal's author and a later `SO-`'s author will look for them. There is no
> finding against the manifest and no `BUG-`: every red is a seeded kill or its
> predicted radius, and every finding below is against my own artefacts.**
>
> 1. **`FINDING K-1` (MAJOR, mine)** — confirmed and **strengthened**: four classes
>    produced not merely one message but one **byte-identical promoted file**.
>    Recorded at `M03-K2`'s Kills cell with the blob ids. **Carriers unchanged**:
>    the message repair to the next commit that opens `test_m03_k.ml`; the record,
>    here.
> 2. **`FINDING WO-0077-K2` (MINOR, mine, against `WO-0072` §9's D3 row)** —
>    confirmed by the round that minted it; the **D3 → D3a/D3b** repair of record
>    stands. Recorded at `M03-K2`'s Kills cell.
> 3. **`FINDING WO-0077-A1` (MAJOR, mine, against my own seal's §6.1 and the census
>    that grounds it)** — the differential co-simulation anchor is **not** blind to
>    this campaign. **Recorded at §7 beside bar 4**, with its census repair and with
>    its positive half.
> 4. **`FINDING WO-0077-N1` (MINOR, mine)** and **`FINDING WO-0077-N2` (MAJOR,
>    mine)** — both §N's; recorded at §4.N's block and at `M03-N1`'s cell.
> 5. **`FINDING J-2`** — **measured and NOT withdrawn**; `M03-N4` is confirmed from a
>    run as the sole carrier for the suppressing design and the debt
>    `WO-0076-VERDICT` §10 left open is **paid**. At `M03-N4`'s cell.
> 6. **`FINDING AP-3` — DISCHARGED IN THE AFFIRMATIVE.** It measured across the whole
>    class-based era that `M03-N1` had taken nothing and `M03-N4` five reds in two
>    campaigns with no qualification, every one through an admission path seeded
>    against a family-J row. **This campaign produced the first reds at either row's
>    own cells, under classes seeded against the rows' own observables.**
> 7. **`FINDING WO-0076-S1`'s enumeration bar** — the five `assert_monitors_clean`
>    arms were enumerated **from the file** in the seal and none of them fired; the
>    bar cost nothing and the enumeration was correct. **`FINDING WO-0076-S2`'s
>    re-derived-cell-count bar** and **`FINDING WO-0074-S4`'s cross product** both
>    held; **`FINDING RV-0075-3`'s bar** kept two sole exercisers and **both paid** —
>    IC-K5 established `WO-0072` §7.5's derivation from a run, IC-N4b measured
>    `FINDING J-2`, and neither measurement is available from any other class in this
>    round or any previous one.
>
> **What this does and does not buy** — every clause a refusal the scorecard would
> otherwise be read as granting.
>
> 1. **Qualification measures an instrument; it discharges no row and moves no
>    discharge count.** **The census is unmoved and that is the rule, not an
>    oversight: 62 of 62**, re-measured at this commit by `bash tools/dv_checks.sh`
>    — **78** row ids declared, **62** named in a committed unit title under both the
>    trailing-digit boundary matcher and the naive one, − `M03-A4` (NO-ASSERT, named
>    in a title) + `M03-F5` (by citation) = **62**; inventory **59** under
>    `test/xgmii_rx_64/` and **139** repository-wide; the ASSERT denominator counted
>    from this file's own status cells in the same pass, before and after these
>    edits. **No unit and no title moved in this round, and `QUALIFIED` is not a
>    status.**
> 2. **A nine-of-nine scorecard is NOT full coverage of §4.K** — see `M03-K3`, and
>    see the breadth paragraph: neither K silence scan and neither K control run was
>    reached at all.
> 3. **`M03-K1`'s green may never be cited as evidence that a `clear` window
>    suppresses anything** — `DECLARATION K-D1`, measured, homed as **U-5** at §7.
> 4. **Both pre-scan guards remain unreachable by any mutation, and the `clear`
>    guard's REFUSAL path remains unfired on a real violation.** Both K rows enter
>    the guard and find nothing: its **entry** condition is witnessed, its
>    **refusal** is not. A half-measured instrument, exactly as the `Enable` guard
>    is, and **unchanged by this round in either direction**.
> 5. **SPEC-M03 §3.2's ambiguity is untouched.** Neither K row drives a start
>    character under `clear` = 1 — the guard refuses that stimulus — so no class here
>    bears on which of §6.2's `Idle` row and §7's reset bullet governs a cycle
>    carrying both. That is the guard working, and it is **queued for
>    architect_docs_lead** (§8), not closed.
> 6. **REQ-009's header-record clause has no instance at M03** and is discharged
>    **by the interface, not by a test** — the same disposition as REQ-810's at
>    `M03-J1` and REQ-014's at `M03-O2`.
> 7. **A kill proves the assertion convicts, never that the bench is a general
>    detector of the class.** IC-N1 was detected at six units; **this bench was not
>    blind to it** and no reading of this block may imply it was.
> 8. **The differential co-simulation anchor is UNDISCHARGED**, and
>    `FINDING WO-0077-A1` does not discharge it — what changed is that the bar's
>    **blindness claim** is now known to be false for one placement and true for the
>    rest. §7's bar 4 carries both halves.
> 9. **Nothing in `test/**` is owed by this result and nothing in `test/**` moves in
>    this round.** The carried carriers are unchanged and are recorded at their
>    sites: `FINDING K-1`'s message repair (`test_m03_k.ml`), `RN-6`'s `docs/**`
>    resolve-check (`tools/dv_checks.sh`), `FINDING RV-0075-1`'s printer repair
>    (`test/cosim/**`), `WO-0047` §2's 4-octet member reorder (`test_m03_f.ml`),
>    `OBSERVATION L-O1` (`test_m03_l.ml`), `WO-0073-D3`'s `M03-I4` mislabel
>    (`test_m03_i.ml`) and `OBSERVATION K-O1` (`test/monitors/`). **A plan round is
>    not where a carrier is improved** (`J-dv_lead-0112`).
> 10. **No `SO-xgmii_rx_64.md` is opened or offered.** Outstanding before any PASS:
>    the **charter §3 differential co-simulation anchor**; the unscoreables **this
>    round** declares, quoted from the verdict's own §13 item 1 rather than
>    re-enumerated as a set (`M03-K3`, both pre-scan guards' refusal paths,
>    SPEC-M03 §3.2's ambiguity, REQ-009's header-record clause, `M03-N4`'s
>    zero-delivered branch, `M03-N3`, REQ-802/§9.1's reset column) **plus the
>    standing ones earlier rounds declared at their own rows** — each carried at its
>    row, and **deliberately not collected into a completeness claim here**, because
>    a set claim over this plan's declarations is exactly what §0.1 forbids
>    asserting unmeasured; and the
>    **lessons harvest**, which falls at the `SO-`, spans from my last harvest, and
>    now holds **nine** banked candidates. **What this round removes is the last
>    campaign debt, and it removes all of it.**

### 4.L Line rate, constancy and order — REQ-004, REQ-005, REQ-111, REQ-019, REQ-020, REQ-112, §8

| Row | Attacks | Stimulus | Observable | Kills | Status |
|---|---|---|---|---|---|
| **M03-L1** | REQ-004, §8 checks 1–2 | §8's stress run: **10 000** consecutive 64-octet frames, start lanes alternating 0 and 4, start-to-start spacing alternating **10 and 11** cycles, minimum 12-octet gap, zero error injection | 10 000 frames out for 10 000 in; every frame's 60 delivered octets equal the injected octets 0–59; the four-octet sequence numbers arrive 0, 1, 2, … with no gap and no repeat; conservation holds; no strobe pulses anywhere in the run | Word loss under sustained line rate — the only observable failure mode REQ-112 has (§10). A design with any internal backpressure or a one-cycle recovery between frames fails within the first hundred frames. **QUALIFIED 2026-08-09 — three scoreable classes, three kills, 3/3, THROUGH ONE INSTRUMENT** (`WO-0073-VERDICT` §11, disposition 1 at each; campaign `WO-0073`, sealed at `WO-0073_family-l-mutation-campaign-SEALED-predictions.md` §4.1/§4.4/§4.5 before any diff existed; adjudicated `J-dv_lead-0134`, recorded here `J-dv_lead-0135`). **IC-L1** at branch **D** (a receiver needing a cycle to re-arm drops the frame), **IC-L4** at branch **S** (the tail word is suppressed by the next frame's start character) and **IC-L5** (the last output word is delivered twice) each convicted at **unit 1's item 3** — the `tlast` count, which is §8 check 1, frames out = frames in — raising the sealed strings character-for-character: `M03-L1/L2/L3/L4: 10 000 frames presented, 5000 tlast words observed` under **both** IC-L1 and IC-L4, the mutant-owned integer included, and the same string with **`20000`** under IC-L5, separated from the pair by the **direction** §9 sealed for it (`> 10 000` against `< 10 000`) and by nothing else. **Three classes and one instrument is the whole of what this cell may claim**: item 3 is the first DUT-observable check in the unit and speaks before the per-frame walk, so nothing here is evidence that this row's octet-content, sequence-arrival, conservation or empty-strobe-set clauses convict anything, and the two identical strings were separated **only** by having been run as separate transients (`WO-0073-D4`, in the post-campaign block below). CI `build` runs **`31044630489`** (IC-L1), **`31044835612`** (IC-L4), **`31044870620`** (IC-L5), against control **`31039283863`** at `bbd4122` | ASSERT |
| **M03-L2** | REQ-005, REQ-111, §8 check 3, §0.5 | (the same run, through the latency tagger) | **One** L per front-offset class across all 10 000 frames: L = **16** at h = 8 (lane 0) and L = **12** at h = 12 (lane 4). Not a mean, not one L for the run | A design whose latency depends on frame content or on which frame it is; and a monitor asserting a single L across a two-lane run, which fails a conformant M03 on frame 2 (C-15 — observed, not hypothetical). **QUALIFIED 2026-08-09 — one scoreable class, one kill, 1/1** (`WO-0073-VERDICT` §11, disposition 1; seal §4.2; adjudicated `J-dv_lead-0134`, recorded here `J-dv_lead-0135`). **IC-L2** spent the reserve SPEC-M03 §7 deliberately leaves — the per-word delay moved 3 → 4 **uniformly**, on every output word and every strobe — and this cell's *per-front-offset-class* record convicted at **both** of its records: unit 1 raised `M03-L1/L2/L3/L4 (h = 8): latencies is not the single value this front-offset class must carry (§0.5 Start lanes)` and unit 2 raised `M03-L5 (lane 0, length 64): latencies = [24], expected [16]`, both sealed exactly, the **24** mutant-owned. CI `build` run **`31044675210`**, control **`31039283863`**. **AND THE GREEN BESIDE THE KILL IS THIS CAMPAIGN'S LARGEST RESULT.** Under the same class `Latency.errors` stayed **empty** at both units — observed, not inferred — because (L + h) = 32 closes at `word_delay = Some 4`, the ceiling test `4 > 4` is false and §0.5's start-lane pair rule admits `(4, 4)`; **and the differential co-simulation lane passed**. So REQ-005/REQ-111's pinned per-octet constant, asserted here and at M03-L5, is the programme's **only** detector of a uniform one-cycle word-delay regression: REQ-019's whole error machinery is silent on it and the charter §3 anchor cannot see it (`WO-0073-D2`, carried at §7's co-sim banner) | ASSERT |
| **M03-L3** | REQ-019, §1.1, §7 | (the same run) | Measured ΔC = (L + h)/8 = **3** in both classes, against the §1.1 ceiling of **4**; the one unspent cycle is reported as M03's reserve. The observed front offset of every frame is 8 or 12 and no other value | A ΔC computed from the octet-correspondence term instead of §0.5's front offset, which reports **2** at a lane-4 start and understates the hardest receive module by a cycle in its own sign-off packet (the WO-0012 tagger defect, fixed; this row keeps it fixed). **SCORED AND UNQUALIFIABLE 2026-08-09 — this row's own instrument cannot speak under any mutation, and that was declared BEFORE the campaign ran** (`WO-0073` §4 item 2 and seal §6.2, frozen at `bbd4122`; scored `WO-0073-VERDICT` §8 and §11; adjudicated `J-dv_lead-0134`, recorded here `J-dv_lead-0135`). Unit 1's **item 8** asserts two operands and **both are closed by assertions that speak earlier in the same unit**: the whole-run `word_delay` accessor returns the common value of the two front-offset class records **item 7** has already required to be `Some 3`; `Latency.errors` has every per-frame arm closed by **item 4** (the 60-octet count, word 0's `tkeep` = 0xFF, and the front offset, which is computed from the bench's own input trace and is 8 or 12 by construction) and every derived arm closed by item 7; `frames_compared` = 10 000 is **bench-supplied** — one call per schedule frame, incremented unconditionally, never evidence that the design delivered a frame; and `octets_compared` = 600 000 is item 4's per-frame 60 summed. **Measured across all five classes**: item 8 was never reached under IC-L1, IC-L2, IC-L4 or IC-L5, and under IC-L3 it **ran and passed** on operands items 4 and 7 had already fixed. **This row's ΔC content is discharged by `WO-0070` §6's derivation — a statement about the specification — and by no run**, and no `SO-`, campaign or scorecard may report any kill as evidence that this row's assertions convict. What it would take to make the instrument speak is a machinery question and is carried at §7 | ASSERT |
| **M03-L4** | REQ-020, §8 check 2 | (the same run) | The delivered sequence is exactly 0 … 9999 | A design holding more than one frame, or reordering across the alternating start lanes. **SCORED AND UNQUALIFIABLE 2026-08-09 — this row's own instrument is STRUCTURALLY unreachable, and that was declared BEFORE the campaign ran** (`WO-0073` §4 item 1 and seal §6.1, frozen at `bbd4122`; scored `WO-0073-VERDICT` §8 and §11; adjudicated `J-dv_lead-0134`, recorded here `J-dv_lead-0135`). Unit 1's **item 4** compares every frame's delivered octets **positionally** against `Arrival.delivered`, and §8's stimulus carries REQ-020's four-octet sequence number at offsets **14 … 17 inside those octets**; **item 6** then reads the sequence back with `Frame.sequence_of` from **the very list item 4 has just compared**. **If item 4 passed at every frame, item 6 cannot fail; if item 4 failed anywhere, item 6 is never reached.** `WO-0070` §7 called the overlap *"implied by M03-L1"*; it is stronger than implication and it is structural. **Measured**: item 6 never ran under IC-L1, IC-L4 or IC-L5, and ran and passed under IC-L2 and IC-L3 — **its greenness is evidence that item 4 ran, and is not evidence of order preservation**. This row is qualified by citation to M03-L1's pairing or not at all. **And REQ-020's reordering half has no renderable mutant at this stimulus**: frame k + 1's octets arrive strictly later than frame k's, and a cut-through module whose payload storage is bounded at two datapath words (REQ-019, SPEC-M03 §6.1) cannot emit octets it has not received — a bound the **auditor derived independently from the design side while blind to the seal** (`WO-0073` manifest §8), which is the strongest form it can take short of a proof | ASSERT |
| **M03-L5** | REQ-005, REQ-103, §8's directed set | Frames of 64 … 71 and 1518 octets at both start lanes (M03-C1, M03-C3) through the tagger | The same two constants as M03-L2 at every one of those lengths | A pipeline whose delay varies with the final `tkeep` residue — length-dependent latency that a fixed-length stress run cannot see. **QUALIFIED 2026-08-09 — one scoreable class, one kill, 1/1, AND THE LENGTH-DEPENDENCE CLAIM IS EARNED RATHER THAN SEEDED** (`WO-0073-VERDICT` §4, §7 Q5 and §11, disposition 1; seal §4.3 and §8.1 rule 1; adjudicated `J-dv_lead-0134`, recorded here `J-dv_lead-0135`). **IC-L3** made the word delay depend on the final word's residue at a disclosed residue set **R = {2}**, and this row raised `M03-L5 (lane 0, length 70): latencies = [16; 24], expected [16]` — the sealed string, at the length §2.4's residue map fixes for R, with the two-value ascending list the seal derived. **The claim in the sentence above is now measured rather than argued**: `4 ∉ R` left **unit 1 green across all 10 000 frames** — the stress frame delivers 60 octets, residue 4 — while unit 2 reddened, so the fixed-length run genuinely could not see a residue-keyed latency defect that the directed set caught. That is §8.1's rule 1, the only route by which this row's own claim can be *earned*; a set containing 4 would have reddened unit 1 too, kept the kill and forfeited the result. **This is the only class in the campaign whose entire convicting set lies outside the stress run.** Six of unit 2's eighteen members (lengths 64 … 69 at lane 0) were **observed green** ahead of the raise; the remaining eleven are **UNOBSERVED — never a pass and never a miss**, the first raise ending the run. CI `build` run **`31045274017`** (branch cut from `c66565d`, itself off `bbd4122`; the superseded run `31044805815` scores nothing), control **`31039283863`** | ASSERT |
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

> **FAMILY L — POST-CAMPAIGN STATUS, 2026-08-09 (`J-dv_lead-0135`, from
> `WO-0073-VERDICT`, adjudicated `J-dv_lead-0134` and committed at `7bedc30`).
> THE BLOCK ABOVE IS KEPT AND ITS GROUND IS REPLACED.** Every status word there
> was measured against a landed bench and none of it is withdrawn — but its item
> (2), *"landed-and-green is NOT qualified: family L is **unscored** by any
> mutation campaign … the campaign is owed **before** any `SO-`"*, was true when
> it was written and is now false for **three** of the five rows and
> **permanently unavailable** for the other two. Which of those two dispositions
> each row takes is the whole content of this block. Every status word below
> travels with the SHA and the CI run id it was read at (§0.1;
> `RV-0068B-VERDICT` §7).
>
> **The campaign, with its identifiers, so no later packet re-derives them.**
> Five intent classes, five blinded diffs, five transient branches cut from base
> **`bbd4122`**, manifest at `e5c0b11`, each diff touching
> `libs/hardcaml_ethernet/src/xgmii_rx_64.ml` and nothing else:
>
> | class | what it renders | branch / commit | `build` run | outcome |
> |---|---|---|---|---|
> | **IC-L1** (branch **D**) | the receiver needs a cycle to re-arm between frames; the frame is dropped | `mut/wo-0073-l1` / `8fe0251` | **`31044630489`** | **KILLED**, 1 kill |
> | **IC-L2** (branch **U**) | the reserve is spent: the word delay is 4, uniformly | `mut/wo-0073-l2` / `e24e523` | **`31044675210`** | **KILLED**, 1 kill |
> | **IC-L3** (**R = {2}**) | the delay varies with the final word's delivered residue | `mut/wo-0073-l3` / `60ed49c` | **`31045274017`** | **KILLED**, 1 kill |
> | **IC-L4** (branch **S**) | the tail word is lost to the next frame's start character | `mut/wo-0073-l4` / `22b538f` | **`31044835612`** | **KILLED**, 1 kill |
> | **IC-L5** (**once**) | the last output word is delivered twice | `mut/wo-0073-l5` / `806d3d5` | **`31044870620`** | **KILLED**, 1 kill |
> | **control** | nothing — the unmutated tree | `bbd4122` | **`31039283863`** | green at **every step** of `build` and of `cosim` |
>
> **5 of a sealed maximum of 5, disposition 1 at all five**: 7 of 7 REQUIRED red
> cells raised their sealed strings **character-for-character** (both
> mutant-owned integers included and both sealed directions satisfied), 3 of 3
> load-bearing REQUIRED greens held, and **zero MUST-STAY-GREEN violations** —
> the 79 behavioural and 1 build-level non-M03 units held under every class, and
> every failing path in all five step-6 outputs lies under `test/xgmii_rx_64/`.
> **The denominator behind that sentence is re-measured here rather than quoted**
> (§0.1): `grep -rc '^let%expect_test' --include=*.ml test/` at this commit gives
> **139** repo-wide and **59** under `test/xgmii_rx_64/`, so **80** non-M03,
> splitting `monitors` 37 + `xgmii` 25 + `golden` 11 + `axi64_probe` 3 +
> `xgmii_probe` 3 = **79 behavioural** and `hardcaml_ethernet` **1 build-level**
> — figure for figure what the seal froze at `bbd4122`, whose `test/**` tree this
> commit's still equals.
> Scoring was taken from **step 6's own output and the promoted `.corrected`
> hunks**, never from a run conclusion: step 5 `Build` is `success` in all five,
> which is what retires the build-finding class, and the `journal-check` red on a
> mutation commit is noise by construction.
>
> | Row | Campaign status | The evidence, not the adjective |
> |---|---|---|
> | **M03-L1** | **QUALIFIED — 3 classes, 3 kills, one instrument** | IC-L1(D), IC-L4(S) and IC-L5 at unit 1's item 3. Recorded in the row's own Kills cell with **Status left at `ASSERT`** (`J-dv_lead-0109`'s divergence ruling: §1's status vocabulary is closed at six values and `QUALIFIED` is not one of them). |
> | **M03-L2** | **QUALIFIED — 1 class, 1 kill** | IC-L2 at both front-offset class records. The green beside it is `WO-0073-D2`, at §7's co-sim banner. |
> | **M03-L5** | **QUALIFIED — 1 class, 1 kill, length-dependence EARNED** | IC-L3 at `R = {2}`, unit 1 green and unit 2 red — the row detecting what M03-L2's stimulus cannot. |
> | **M03-L3** | **SCORED AND UNQUALIFIABLE** | Item 8's two operands are closed by items 4 and 7. Declared at `WO-0073` §4 **before** the run; confirmed by measurement under all five classes. |
> | **M03-L4** | **SCORED AND UNQUALIFIABLE** | Item 6 reads back the octets item 4 has already compared positionally. Same declaration, same confirmation. |
> | **M03-L6** | **STRUCTURAL, UNMOVED** | No class touches a statement about the interface type. |
>
> **What this does and does not buy** — and every clause is a refusal the
> scorecard would otherwise be read as granting.
>
> 1. **Qualification measures an instrument; it discharges no row and moves no
>    discharge count** (`J-dv_lead-0109`, applied to three rows here). The census
>    is unmoved by this round: **62 of 62** ASSERT rows named in a committed unit
>    title, re-measured at this commit rather than carried forward — 78 row ids
>    declared, 62 named under both the trailing-digit boundary matcher and the
>    naive one (the two agree at this tree), − `M03-A4` (NO-ASSERT, named in a
>    title) + `M03-F5` (by citation) = **62**, by `tools/dv_checks.sh`'s own
>    census commands run against this file and `test/xgmii_rx_64/*.ml`.
> 2. **No family-M row is qualified by this campaign, and this is the first test
>    of §4.M's own pre-recorded rule.** IC-L2 and IC-L5 reddened `M03-G3`,
>    `M03-G4`, `M03-G7` and `M03-G8` — the carriers `FINDING M-1` and `FINDING
>    M-2` bound `M03-M6` and `M03-M7` to. Those reds are **blast radius under the
>    classes' own rules and contribute zero kills**, so they qualify neither the
>    carrier's row nor the row bound to it; §4.M's block already says *"a
>    scorecard must not report that as two kills"*, and this one does not.
>    **Fifty-one reds under IC-L5 are one kill; forty-nine under IC-L2 are one.**
> 3. **No family B, C, D, E, F, G, H, I, J, K or N row is qualified either**, for
>    the same reason and by the same rule.
> 4. **The `P1-module-ready` line-rate-stress line is not signed by any outcome
>    here.** The block above already says what that line has and has not; a
>    campaign score is not a signature.
> 5. **No `SO-xgmii_rx_64.md` is opened or offered.** Families **J**, **K** and
>    **M** are unscored, and the charter §3 co-sim anchor is undischarged per
>    stimulus class — which `WO-0073-D2` has now made **sharper rather than
>    smaller**.
> 6. **A kill qualifies a row on the class it was seeded against and on nothing
>    else**, and a kill proves the assertion convicts, never that the bench is a
>    general detector of the class. IC-L2 and IC-L5 were detected across most of
>    the M03 bench; **this bench was blind to neither**, and nothing here should
>    be read as saying it was.
>
> **THE RULE-VERSUS-INSTANCE DIVERGENCES, DERIVED PER ROW — the debt
> `WO-0073-VERDICT` §5.1 named and deliberately did not claim.** `FINDING
> WO-0066-3` cost three MUST-STAY-GREEN violations for carrying an
> **enumeration** where a **rule** was right, so this seal carried rules with
> instance lists beneath them and standing rule 5 saying the rule governs. The
> rule and the instances **did** disagree, three times, and under `WO-0066`'s
> regime those would have been three violations against the seal's author. Under
> the rule form they are none — and these are the derivations that say so.
>
> **One geometric fact governs all three, and it is §0.3's arithmetic rather
> than a property of any bench.** The link-partner model lays each next start
> character at `round_up_4(terminate_octet_time + ifg)`, never below §0.3's
> 9-octet DIC floor (`test/xgmii/arrival.ml`'s `create`, read at this round's
> base — `git show 33871b8:test/xgmii/arrival.ml`; `test/**` is byte-identical to
> the campaign base, `git diff --stat bbd4122 33871b8 -- test/ libs/ tools/
> docs/specs/` **empty**, and still empty at `9e90c8b`, this commit's parent —
> the two orchestrator commits that landed while this round was open touch
> `.github/` and that agent's own journal only). Write the terminate character's
> lane as `r` and its
> word as `k`. At the 12-octet default gap with no banked credit the next start
> lands at `8k + 12` when `r = 0`, and at `8k + 16` or `8k + 20` otherwise. **So
> a frame's start word is the previous frame's terminate word's immediate
> successor iff that terminate character occupies lane 0** — and since
> `terminate_octet_time = start_octet_time + 8 + N`, that is `N ≡ 0 (mod 8)` at a
> lane-0 start and `N ≡ 4 (mod 8)` at a lane-4 one. §8's stress run is 64-octet
> frames at alternating start lanes, so `N ≡ 0` selects **exactly the
> lane-0-started half** — the 5 000 odd-index frames the seal's §2.2 derived and
> the campaign confirmed at `5000`.
>
> **The per-file schedule census behind items 1–3, measured at this commit rather
> than recalled** (§0.1): `grep -nE '(one_frame|frames_at|Arrival\.create|Injection\.create)[^;]*\['`
> over `test_m03_f.ml`, `test_m03_g.ml` and `test_m03_i.ml` returns every
> schedule built from a list literal, and exactly **eight** of them hold two
> frames — `test_m03_f.ml:686`; `test_m03_g.ml:431`, `:741`, `:881`, `:1064`,
> `:1264`, `:1546`; `test_m03_i.ml:1112`. Every other schedule in the three files
> is a `Bench.one_frame` call or a one-element list, single-frame by the
> constructor's own contract.
>
> 1. **`test_m03_f.ml` GREEN under IC-L1, though §3.5's instance list named
>    family F through `Dv_xgmii.Injection`.** IC-L1(A)'s rule requires a frame
>    whose start word's cycle is exactly one more than the cycle of a word
>    carrying the **previous** frame's terminate character, and an assertion
>    about that frame. **M03-F1, M03-F2 and M03-F3 drive one frame each** — a
>    `one_frame` schedule, a single `Injection` case and a single bad-FCS frame
>    respectively — so the rule quantifies over a previous frame that does not
>    exist, three times over. **M03-F4 is family F's only pair**, and it is the
>    row whose own text calls adjacency its stimulus: 63 then 64 octets at §0.3's
>    minimum gap. **That adjacency is in octet times, not in words.** 63 ≡ 7 (mod
>    8), so the terminate character lands in **lane 7** at a lane-0 start (octet
>    time 79, word 9; the next start rounds up to 92, word 11) and in **lane 3**
>    at a lane-4 start (octet time 83, word 10; next start 96, word 12). **Two
>    words in both cases where the class needs one.** M03-F5 has no unit of its
>    own. **The instance list's error was to select on `Injection`'s placement
>    machinery**, which decides where a *character* goes and never how many
>    *frames* a schedule holds or where its gaps round to.
> 2. **`test_m03_g.ml` GREEN under IC-L4.** IC-L4's rule requires a frame's
>    **last output word cycle to equal the cycle of an input word carrying a
>    start character**, and an assertion about that frame's `tlast`, word count or
>    latency. A single-frame schedule can never satisfy it — the frame's own start
>    is at `start_cycle` and its first output word at `start_cycle + 3` — so the
>    condition is about a *later* start character. **Family G has six multi-frame
>    units and all six drive the same pair, 1600 octets then 64** (M03-G1, G3,
>    G4, G6, G7, G8; M03-G2's two members are single frames and M03-G5 asserts no
>    observable of its own). REQ-108 truncates the first frame at its **1519th**
>    received octet, so its last output word is pinned to the truncation point at
>    `start_cycle + 3 + 189`, while its own terminate character does not arrive
>    for another **82** octet times — and §0.3 measures the gap from **that**
>    character. The earliest next start is therefore `start_cycle + 202` (lane 0)
>    or `+ 203` (lane 4) against a last output word at `start_cycle + 192`: **at
>    least ten cycles of separation, which the wider gaps this family uses — 20
>    at M03-G3, 40 at M03-G4 — only widen.** M03-G7's **injected** start
>    character is covered by the same arithmetic and not by an exemption: at
>    content index 1588 it falls on cycle 200 or 201, seven cycles clear.
>    **REQ-108's own condition is what forbids the coincidence** — the further a
>    frame overruns the bound, the further its last output word retreats from
>    every start character that follows.
> 3. **`test_m03_i.ml` GREEN under IC-L4.** **Family I has exactly one
>    multi-frame unit and it is M03-I3**; M03-I1, all three members of M03-I2,
>    M03-I4 and M03-I6 drive one frame each, and M03-I5 asserts nothing of its
>    own. At M03-I3 the unit's own stimulus guards pin frame 1's terminate
>    character to cycle **10** and frame 2's start to cycle **113**, with frame
>    1's `tlast` word at cycle **11** and no third frame: **102 cycles of
>    separation where the class needs zero.** This is the same `~ifg:824`
>    schedule that made `test_m03_i.ml:1112` the seal's one WORKED-and-GREEN
>    instance under IC-L1, so **one geometric fact bought both greens** — which
>    is the difference between a rule and a slogan, and it is why that instance
>    was worked.
>
> **The portable part, and it is why these three are one lesson**: a class keyed
> on a **coincidence** between an output event and an input event is selected by
> the *schedule's* arithmetic and never by the family a unit sits in, so an
> instance list built from families is a **superset of the rule** every time.
>
> **`FINDING WO-0073-D4` — a claim that two events cannot be told apart must
> state the scope at which it holds** (MINOR, against my own seal's phrasing;
> `WO-0073-VERDICT` §6 and §10). Collision 1 instantiated exactly as sealed —
> IC-L1(D) and IC-L4(S) raised the identical item-3 string, integer included —
> and the seal recorded its discriminator as *"NONE that this bench produces"*.
> **That is exact at the cell and too strong at campaign scope.** `M03-K2`
> separates the two completely and by measurement: `expected 16 delivered words,
> got 8` under IC-L1(D) against `got 15` under IC-L4(S) — a **dropped frame**
> against a **lost tail word**. The auditor derived that separation independently
> at its own §6 while blind to the seal. No cell moves and no score changes; what
> changes is how such a claim is written, here and in every later seal: **scope
> the absence to the cell and seal the campaign-scope discriminator beside it.**
>
> **`FINDING WO-0073-D3` — `OBSERVATION L-O1`'s shape exists OUTSIDE family L,
> and the carrier is named so it cannot evaporate** (MINOR, against the bench,
> mine; `WO-0073-VERDICT` §10). Under IC-L2 and IC-L3, **`M03-I4`** raised
> `... test bug -- the baseline's own tlast cycle does not match the gapless m +
> 3 formula` — a **design** red wearing a bench-bug prefix, the same inversion of
> `FINDING B-1` that L-O1 carries one file over. **Disposition is the seal's
> §5.5, fixed before the run**: such a red is a design red mislabelled by the
> bench, is never read as a bench defect or a stimulus problem, and **it changed
> no score here.** **Carrier: the next commit that opens
> `test/xgmii_rx_64/test_m03_i.ml`** — which this round is not, for the reason
> §4.L's block already gives for L-O1: a plan round does not improve a carrier.

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
| **M03-M1** | §9 ruling 1 | M03-F3 | `error_runt` **and** `error_bad_fcs` both pulse once for one frame; `tuser`[0] set once | A precedence design. **QUALIFIED 2026-08-10 — one class, one kill, 1/1, and it is ONE kill shared with carrier M03-F3, never two** (`WO-0074-VERDICT` §8 and §8.1; campaign `WO-0074`, sealed at `WO-0074_family-m-mutation-campaign-SEALED-predictions.md` §4.1, frozen with its packet at `ca1bb80` **before any diff existed**; adjudicated `J-dv_lead-0137`, recorded here `J-dv_lead-0138`). **IC-M1** rendered ruling 1's precedence design at branch **R** of disclosure `D-M1a` — the suppression falls on `error_bad_fcs`, so `error_runt` is the survivor — and this row's carrier raised the sealed string with **`observed 1`**. **That is the only *subtractive* reading in the whole campaign**, and by the seal's own §9 it is the one thing separating IC-M1 from every other class at a count-shaped cell; the printed cycle **11** was likewise derived from the schedule's own start octet time and sealed as specification-fixed rather than mutant-owned, and it printed `11`. **The message prints the count and not the surviving strobe name**, so this row convicts branch R and branch B alike and **cannot diagnose which**: the separation was carried entirely by the disclosure plus the published diff, for the third campaign running. CI `build` run **`31054172382`**, against control **`31052415338`** at `ca1bb80`. **Status left at `ASSERT`** (`J-dv_lead-0109`'s divergence ruling: §1's status vocabulary is closed at six values and `QUALIFIED` is not one of them) | ASSERT |
| **M03-M2** | §9 ruling 2, REQ-108 | M03-G1 | `error_bad_fcs` does **not** pulse for the truncated frame | A design that checks the residue at the truncation point, where no FCS is present. **QUALIFIED 2026-08-10 — one class, one kill, 1/1, one kill shared with carrier M03-G1** (`WO-0074-VERDICT` §8, §8.1 and §9; seal §4.2, frozen at `ca1bb80`; adjudicated `J-dv_lead-0137`, recorded here `J-dv_lead-0138`). **IC-M2** ran the comparison at REQ-108's truncation point and M03-G1 raised the sealed string with **`observed 2`**. CI `build` run **`31054177436`**, control **`31052415338`**. **AND `OBSERVATION M-O1` IS ANSWERED IN THIS ROW'S FAVOUR AND CLOSED — the measurement a bench could not make and a campaign could.** The landed-status block above carried the worry that this row's anti-vacuity ground is one stimulus at two lanes over a **single deterministic 1518-octet prefix**, so an accidental residue match would be a 2⁻³² event that is *fixed* rather than random. The carrier reddened at its strobe-set assertion, which the seal's §8.1 rule 1 had fixed **before the result** as answering the question in the row's favour: **that prefix does not satisfy REQ-304's residue at the truncation point**, and the row is not vacuous against ruling 2's defect. **The second-content repair `OBSERVATION M-O1` would have commissioned is NOT commissioned** (`WO-0074-VERDICT` §9). The risk that remains is the same *fixed* 2⁻³² one inherited by any future campaign, and it is recorded rather than repaired. **AND THE ROW'S OWN BLAST RADIUS IS NAMED SO NO SCORECARD READS IT AS COVERAGE**: IC-M2 reddened **all seven units of family G**; six of those reds are blast radius under the class's own rule and contribute **zero** kills — in particular they qualify **neither M03-M6 nor M03-M7**, whose carriers reddened here through **ruling 2** and not through rulings 6 and 7. **Status left at `ASSERT`** (`J-dv_lead-0109`) | ASSERT |
| **M03-M3** | §9 ruling 3, REQ-105 | M03-E1 | `error_bad_fcs` does **not** pulse for a frame ended by `/E/` | A design that runs the residue comparison on every frame closure regardless of how it closed. **QUALIFIED 2026-08-10 — one class, one kill, 1/1, one kill shared with carrier M03-E1** (`WO-0074-VERDICT` §8, §8.1 and §6; seal §4.3, frozen at `ca1bb80`; adjudicated `J-dv_lead-0137`, recorded here `J-dv_lead-0138`). **IC-M3** ran the comparison at an error-character closure and M03-E1 raised the sealed string with **`observed 2`** at the **FULL** prefix variant — a cell the seal **derived** rather than transcribed, from the first member's 24 delivered octets (24 mod 8 = 0), and the FULL variant is what spoke. CI `build` run **`31054174810`**, control **`31052415338`**. **AND THIS ROW'S CARRIER IS THE DISCRIMINATOR THAT DECIDED COLLISION 2, WHICH IS THE COMMISSION'S OWN QUESTION ANSWERED** (`WO-0074-VERDICT` §6): IC-M3's blast radius reddened **M03-H3** with **IC-M5's own sealed string, character for character, `observed 2`** — the same characters meaning the opposite thing. The sealed discriminator was M03-E1's state (IC-M3 reddens it; IC-M5 would leave it green, that carrier driving a single frame with no later start character), and **M03-E1 reddened**. So the M03-H3 red is **blast radius through ruling 3** and qualifies **neither M03-M5 nor M03-H3's own row**. Only the diff identity plus a second carrier's state told them apart. **Every green at an `r` cell of this class is a REQUIRED green, not a miss**: the class retains the sub-five gate, so `M03-E2`, `M03-E5` and `M03-B2` — all zero-delivered `/E/` closures — could not fire and did not (`FINDING WO-0074-S1`, in the post-campaign block below). **Status left at `ASSERT`** (`J-dv_lead-0109`) | ASSERT |
| **M03-M4** | §9 ruling 4, REQ-110 | M03-H1 | `error_bad_fcs` does **not** pulse for a frame ended by a new `/S/` | (as M03-M3). **QUALIFIED 2026-08-10 — one class, one kill, 1/1, one kill shared with carrier M03-H1** (`WO-0074-VERDICT` §8, §8.1 and §9; seal §4.4, frozen at `ca1bb80`; adjudicated `J-dv_lead-0137`, recorded here `J-dv_lead-0138`). **IC-M4** ran the comparison at a start-character closure and M03-H1 raised the sealed string with **`observed 2`**. CI `build` run **`31054177858`**, control **`31052415338`**. **AND `FINDING M-O1a`'s WIDENING IS ANSWERED IN THIS ROW'S FAVOUR AND CLOSED WITH IT** (`WO-0074-VERDICT` §9). M-O1a widened `OBSERVATION M-O1` by naming the governing quantity as **the number of distinct delivered-octet contents at the closure point**, on which ground this row's ground is *exactly as thin as M03-M2's* rather than twice as broad — its two cases deliver one 64-octet filler content. The carrier reddened at its strobe-set assertion, so **that content does not satisfy the residue at the `/S/` closure**, and the row is not vacuous either. **Both were fixed 2⁻³² risks rather than random ones and both came out right**; no second content is commissioned at either carrier. **Blast radius, named**: IC-M4's other four reds — `M03-H2`, `M03-N2`'s two **delivered** sub-cases and `M03-N4` — contribute **zero** kills and qualify nothing. **And its four greens at `r` cells are REQUIRED greens**: `M03-H4`, `M03-B4`, `M03-B4 (b)` and `M03-N2`'s four **non-delivered** sub-cases all deliver zero octets, and the class retains the sub-five gate (`FINDING WO-0074-S1`). **Status left at `ASSERT`** (`J-dv_lead-0109`) | ASSERT |
| **M03-M5** | §9 ruling 5 | M03-H3 | Exactly one `error_bad_frame`; no `error_start_without_terminate` | A design in which `/E/` does not close the frame. **SCORED AND UNQUALIFIABLE at this design — 2026-08-10, and the NARROW form is the one adopted** (`WO-0074-VERDICT` §7(a), §8 and §11; the class was sealed as `IC-M5` at `ca1bb80` and **never rendered**; adjudicated `J-dv_lead-0137`, recorded here `J-dv_lead-0138`; the register is the one `WO-0073` opened for `M03-L3` and `M03-L4`). **IC-M5 is the era's first VOID class**: sealed, seeded in intent, and found to have **no datapath-silent rendering at this design** — zero kills, and *not* a survivor, because nothing escaped a bench. **The claim this row may make, in its exact scope**: *ruling 5 has no datapath-silent mutant reachable by modifying this design's existing terms, because this design carries exactly **one** open-frame term and that term bounds the delivered extent.* The auditor's declaration quotes that term as `a_open` at **`libs/hardcaml_ethernet/src/xgmii_rx_64.ml:296 @ ca1bb80`** — **the citation restated into the `<path>:<line> @ <SHA>` form on 2026-08-10, discharging `FINDING WO-0076-A1`** (the auditor's, MINOR, filed with the family-J manifest at `2fbcf0d`; adopted and **widened against me** at `J-dv_lead-0141` §5 — the decay is a property of the **line number**, not of the language the file is written in, so the rule binds **any** file cited from outside itself and not `libs/**` alone, and the SHA may be carried per citation **or** declared once document-wide; landed here `J-dv_lead-0143`). **A bare line number is a decaying citation, true only at a SHA.** The SHA is the one the auditor read the line at; the target has not moved since `b848d56`, so the citation is still true at `8346a5c`. **The number is a locator for falsification and is not a key**, which is condition B's operational **strike test** — delete the number and ask whether any cell changes meaning — and it was measured two ways at `J-dv_lead-0141` §5: `grep -rn a_open test/ --include=*.ml --include=*.mli` returns **zero** hits, and `git show 6f0fd5b -- test/attack_plans/AP-xgmii_rx_64.md` leaves this row's **Observable** and **Status** byte-identical across the commit that introduced the number. **This plan's entire exposure to the finding is this ONE citation, measured and not assumed** — one RTL line number plus two path-only mentions that cannot decay — and it is discharged here. The term serves REQ-110's abort detector **and** the delivery path, and records two attempted renderings that both moved the delivered stream — one stranding the aborted frame's last word, one losing its final half word, a `BUG-0003`-signature component — with a third (a new report-only register) refused as a **different design** rather than a mutant of this one. **Provenance disclosed, because it is a design-side fact and I do not read RTL**: the term, its line and the two attempts are the auditor's, published before the run in `docs/reports/audit/WO-0074-mutations/README.md` at `adac5ca` and quoted here from the committed artefact; **this plan verified none of it at the source**, and it is falsifiable at the line numbers it names. **What this row may NOT be read as saying**: it does **not** establish that ruling 5's defect is inherently unrenderable — a design carrying a separate report-side `frame_active` flag would have a datapath-silent mutant, and this design's not having one is a fact about **this design**. That distinction is the result, because it names what would have to change for this row to become scoreable. **And the row's carrier is left unqualified too**: M03-H3's only red in the campaign arrived as **IC-M3 blast radius** raising this class's own sealed string (collision 2, at M03-M3 above). **Status left at `ASSERT`** (`J-dv_lead-0109`) | ASSERT |
| **M03-M6** | §9 ruling 6 | **M03-G3 AND M03-G7** — 2026-08-09 (`FINDING M-1`, `WO-0071` §5.1, derived `J-dv_lead-0128`; landed here `J-dv_lead-0132`). **The single carrier this cell named was never re-pointed after WO-0056 built the second epoch, and it does not drive this ruling's own condition.** Ruling 6 reasons about a start character arriving **during the `Discard` state**; in M03-G3's stimulus the start character arrives at content index 1620 against a terminate at 1600, i.e. **after the oversize frame's own `/T/`**, so `Discard` has already been left. G3 witnesses the ruling's *conclusion* (never on the same frame) on a stimulus where the frame is **doubly closed**; it does not reach the state the ruling reasons about. **This is not a new discovery about the design and it is not a bench change** — both epochs are landed and green, and §4.G's own M03-G3 cell says it in terms (*"this row does not reach the first epoch … that gap is M03-G7's"*, measured rather than argued: `WO-0055`'s G-c4 mutation survived all twenty-five units). What was owed was the **binding**, and it is paid here. **What no packet may say after this: no `SO-`, campaign or scorecard may cite M03-M6 as coverage of the `Discard`-state case ON THE STRENGTH OF M03-G3. That coverage exists and it is M03-G7's**. **`FINDING M-1` IS NOW MEASURED RATHER THAN ARGUED — 2026-08-10, see this row's Kills cell** | Exactly one `error_oversize`; no `error_start_without_terminate` | A design that re-opens a truncated frame. **QUALIFIED 2026-08-10 — one class, one kill, 1/1, ON THE FIRST-EPOCH CARRIER `M03-G7` ALONE, one kill shared with it** (`WO-0074-VERDICT` §4, §8 and §8.1; seal §4.6 and §8.1 rule 1, frozen at `ca1bb80`; adjudicated `J-dv_lead-0137`, recorded here `J-dv_lead-0138`). **IC-M6** reported a start character arriving in `Discard` as an abort, and M03-G7 raised the sealed string with **`observed 3`**. CI `build` run **`31054177532`**, control **`31052415338`**. **AND `FINDING M-1` IS MEASURED, WHICH IS THIS ROW'S REAL YIELD.** The seal made it a **load-bearing REQUIRED green** (`G!`) before the run — the second-epoch carrier's `/S/`, arriving after the oversize frame's own `/T/`, cannot reach ruling 6's condition — and **`M03-G3` STAYED GREEN under IC-M6 while M03-G7 reddened**, which is exactly the pattern §8.1's rule 1 pre-fixed. So the epoch distinction this row's Stimulus cell asserted **from the stimulus** at `J-dv_lead-0132` is now established **from a run**, and the prohibition that cell states — *no `SO-`, campaign or scorecard may cite this row as coverage of the `Discard`-state case on the strength of M03-G3* — is measured rather than argued. **AND THE NEGATIVE IS THE POINT.** M03-G7 **also** reddened under **IC-M2** and **IC-M10** with the identical message, integer `3` included — collision 3, fully instantiated, verified by direct string comparison of the three promoted sources — and **only IC-M6's red is this row's kill**; the other two are blast radius through rulings 2 and 9 and qualify this row **not at all**. All four sealed discriminators behaved (M03-G1 red under IC-M2 alone; M03-F2 red under IC-M10 alone; M03-G3 red under IC-M2 but green under IC-M6 and IC-M10; M03-G6 red under IC-M2 and IC-M6 but green under IC-M10). **Status left at `ASSERT`** (`J-dv_lead-0109`) | ASSERT |
| **M03-M7** | §9 ruling 7, **C-12** | **M03-G4 AND M03-G8** — 2026-08-09 (`FINDING M-2`, `WO-0071` §5.1, derived `J-dv_lead-0128`; landed here `J-dv_lead-0132`). The same defect and the same repair, one ruling over: ruling 7 reasons about an **error character arriving in `Discard`**, and M03-G4's arrives at content index 1618 against the same terminate at 1600 — **after** the frame's own `/T/`, with `Discard` already left. **M03-G8 is the first-epoch carrier**, built at WO-0056 for exactly this gap; §4.M was written before WO-0056 and its Stimulus cells still pointed at the pre-repair carriers. Both epochs landed and green, so nothing is owed to `test/**` beyond the binding, and **the titles say which epoch each carries**. **No `SO-`, campaign or scorecard may cite M03-M7 as coverage of the `Discard`-state case on the strength of M03-G4**. **`FINDING M-2` IS NOW MEASURED RATHER THAN ARGUED — 2026-08-10, see this row's Kills cell** | Exactly one `error_oversize`; no `error_bad_frame` | (the C-12 ruling, as M03-G4). **QUALIFIED 2026-08-10 — one class, one kill, 1/1, ON THE FIRST-EPOCH CARRIER `M03-G8` ALONE, one kill shared with it** (`WO-0074-VERDICT` §4, §8, §8.1 and §10; seal §4.7 and §8.1 rule 1, frozen at `ca1bb80`; adjudicated `J-dv_lead-0137`, recorded here `J-dv_lead-0138`). **IC-M7** reported an error character arriving in `Discard`, and M03-G8 raised the sealed string with **`observed 2`**. CI `build` run **`31054179722`**, control **`31052415338`**. **AND `FINDING M-2` IS MEASURED, by the same instrument one ruling over**: the seal made `M03-G4` a load-bearing REQUIRED green — the second-epoch carrier's `/E/`, landing past the frame's own `/T/`, cannot reach ruling 7's condition — and **M03-G4 STAYED GREEN under IC-M7 while M03-G8 reddened**, §8.1 rule 1's pattern again. **AND THIS ROW'S CARRIER CARRIES THE CAMPAIGN'S FOURTH COLLISION, WHICH THE SEAL DID NOT NAME** (`FINDING WO-0074-S4`, in the post-campaign block below): M03-G8 reddened **identically** under **IC-M2**, `observed 2` in both, at a **scored** cell. No kill is endangered — IC-M2 reddens seven units of family G and IC-M7 exactly one, and both discriminators were already in the seal — but the IC-M2 red is blast radius through **ruling 2** and qualifies this row **not at all**. **Status left at `ASSERT`** (`J-dv_lead-0109`) | ASSERT |
| **M03-M8** | §9 ruling 8 | — | `error_runt` and `error_oversize` cannot co-occur: the octet ranges are disjoint, so **no stimulus exists** and none is written | **UNSCOREABLE AND UNSCORED, and it SURVIVES ANY OUTCOME — 2026-08-10** (`WO-0074-VERDICT` §8.2 and §11 declaration 2; `J-dv_lead-0138`). **This row has no mutant**, and the reason is **non-existence, not blindness**: REQ-107's and REQ-108's octet ranges are disjoint, so there is nothing for a datapath-silent diff to render. The consequence binds every scorecard reader: **a full family-M scorecard is not full coverage of §4.M**, because two of this family's ten rows cannot enter a denominator at all | NO-STIMULUS |
| **M03-M9** | §0.6, §9's closing paragraph | Every row in families E–H | M03 **inherits** no abort and never pulses a strobe to re-report one: it is the origin of `tuser`[0] on this chain, and there is no input bit to re-report | A design that would need this rule is not expressible at M03; the row is stated so no `SO-` claims §0.6's inheritance clause as tested coverage here. **Not §9's ruling 9** — see the row-index warning above. **UNSCOREABLE AND UNSCORED, and it SURVIVES ANY OUTCOME — 2026-08-10** (`WO-0074-VERDICT` §8.2 and §11 declaration 3; `J-dv_lead-0138`): **the interface forbids a mutant here** — M03 is the **origin** of `tuser`[0] on this chain, so there is no input bit to re-report and nothing a diff could silently change. **No `SO-` may claim §0.6's inheritance clause as coverage from this module**, with or without a campaign score | STRUCTURAL |
| **M03-M10** | §9 **ruling 9** (`1fe71ca`), §9's sixth row, §6.2's `Frame` row `/T/` exit, REQ-104, REQ-107 | **No new stimulus is owed**: M03-F2's 0-, 1- and 4-octet frames and M03-B3's `/T/` in a preamble position already drive the whole class. Drive them and assert the strobe set **exhaustively** | `error_bad_fcs` does **not** pulse for any frame of fewer than 5 octets between start and terminate: `error_runt` pulses **alone**, an exact set and not a lower bound. REQ-104 supplies neither operand for such a frame — no FCS is removed (§9's sixth row), so no comparison is made and there is no mismatch to report — and §6.2's `/T/` exit says the check is **not sequenced** in this class | A design that runs the residue comparison at **every** terminate character regardless of whether the frame had an FCS to check — M03-M3's kill one closure-class over. **The kill is sharp and it is not uniform across M03-F2's three lengths**: at 0 octets the register still holds §6.1 item 1's 0x00000000 seed, and at 1–3 octets a partial CRC, none of which equal REQ-304's residue, so the wrong design goes red; at **4 octets it depends on the filler**, and the single frame `00 00 00 00` yields exactly 0x2144DF1C and passes by accident. **A bench SHALL therefore use a non-zero 4-octet filler**, or drive both and assert the pair identically — an all-zero 4-octet frame alone is a vacuous test of this row. **QUALIFIED 2026-08-10 — one class, one kill, 1/1, ON `M03-F2` ALONE, one kill shared with it** (`WO-0074-VERDICT` §7(b), §8 and §8.1; seal §4.8a, frozen at `ca1bb80`; adjudicated `J-dv_lead-0137`, recorded here `J-dv_lead-0138`). **IC-M10** ran the comparison at **every** terminate character, and M03-F2's **0-octet** member raised the sealed string with **`observed 2`** — the register still holding §6.1 item 1's `0x00000000` seed, exactly as this cell's own derivation says. CI `build` run **`31054180874`**, control **`31052415338`**. **AND THIS ROW'S SECOND CARRIER IS DECLARED PERMANENTLY OUT OF REACH — `DECLARATION WO-0074-D1`, the programme's FOURTH structural blindness and a GRAMMAR gap, not a stimulus gap** (`WO-0074-VERDICT` §7(b) and §11 item 7; recorded beside the X-rows at §7, where a reader of machinery claims meets it). At this design a sub-five frame opened **and** closed inside **one** input word — the **epoch-B/C** geometry — is reported by a separate in-word report vector **carrying no FCS-report member at all**, so ruling 9's co-occurrence defect has **no rendering there by any datapath-silent mutant**. The seal marked **`M03-B3`** REQUIRED-RED at §4.8b on an octet-count rule that omitted the epoch conjunct (`FINDING WO-0074-S3`); **the manifest published the epoch table before the run**, and the run's nine-unit partition settled it and is not close — `M03-F2`(0 octets), `M03-I2`(member iii) and `M03-G7` all **RED** at epoch-A closures; **`M03-B3` and all six `M03-N2` sub-cases GREEN** at epoch-B/C ones. **`M03-B3`'s cell is therefore rescored from REQUIRED-RED to green-by-structural-unreachability, and M03-B3 is NOT qualified by this campaign — a declared non-closure, not a bench gap**, and §4.8's *"convict at both or explain the difference"* is discharged by an explanation committed **before** the run, which is the form that clause was written to accept. **Blast radius, named**: IC-M10's other two reds — `M03-G7` and `M03-I2`(member iii) — contribute **zero** kills, and the M03-G7 red qualifies **M03-M6 not at all**. **Status left at `ASSERT`** (`J-dv_lead-0109`) | ASSERT |

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

> **FAMILY M — POST-CAMPAIGN STATUS, 2026-08-10 (`J-dv_lead-0138`, from
> `WO-0074-VERDICT`, adjudicated `J-dv_lead-0137` and committed at `70cf13c`).
> THE BLOCK ABOVE IS KEPT AND ITS GROUND IS REPLACED.** Every status word there
> was measured against a landed bench and none of it is withdrawn. Two of its
> four closing items have now been paid and a third is **convicted by this
> round's own arithmetic**. Item (3) carried `OBSERVATION M-O1` *to* this
> campaign; it is **answered in both rows' favour and CLOSED**. Item (4) declared
> family M **unscored**; seven of its ten rows are now **QUALIFIED**, one is
> **SCORED AND UNQUALIFIABLE at this design**, and two can never be scored at
> all. And item (4)'s second sentence — *"a seeded class that kills a carrier
> kills its M row **by construction**"* — is **`FINDING M-3`, convicted a second
> time and from the other direction**: see the blast-radius accounting below.
> Every status word travels with the SHA and the CI run id it was read at (§0.1;
> `RV-0068B-VERDICT` §7).
>
> **The campaign, with its identifiers, so no later packet re-derives them.**
> **Eight** sealed intent classes, **seven** rendered as blinded diffs, seven
> transient branches each with parent **`ca1bb80`**, each touching
> `libs/hardcaml_ethernet/src/xgmii_rx_64.ml` and nothing else and each carrying
> exactly one class. Packet and seal frozen together at `ca1bb80`; manifest at
> `adac5ca`; verdict at `70cf13c`.
>
> | class | the wrong design it renders | branch / head | `build` run | outcome |
> |---|---|---|---|---|
> | **IC-M1** (branch **R**) | ruling 1: a precedence design at a runt with a wrong FCS — `error_runt` survives | `mut/wo-0074-m1` / `cd06175` | **`31054172382`** | **KILLED**, 1 kill |
> | **IC-M2** | ruling 2: the residue comparison runs at REQ-108's truncation point | `mut/wo-0074-m2` / `ccf7228` | **`31054177436`** | **KILLED**, 1 kill |
> | **IC-M3** | ruling 3: the residue comparison runs at an error-character closure | `mut/wo-0074-m3` / `798dc64` | **`31054174810`** | **KILLED**, 1 kill |
> | **IC-M4** | ruling 4: the residue comparison runs at a start-character closure | `mut/wo-0074-m4` / `7178c4d` | **`31054177858`** | **KILLED**, 1 kill |
> | **IC-M5** | ruling 5: `/E/` does not close the frame *for the abort detector* | **NOT RENDERED** | — | **VOID BY DECLARATION**, 0 kills |
> | **IC-M6** | ruling 6: a start character arriving in `Discard` is reported as an abort | `mut/wo-0074-m6` / `59f1c57` | **`31054177532`** | **KILLED**, 1 kill |
> | **IC-M7** | ruling 7 / **C-12**: an error character arriving in `Discard` is reported | `mut/wo-0074-m7` / `170a2c2` | **`31054179722`** | **KILLED**, 1 kill |
> | **IC-M10** | ruling 9: the residue comparison runs at **every** terminate character | `mut/wo-0074-m10` / `91cef40` | **`31054180874`** | **KILLED**, 1 kill |
> | **control** | nothing — the unmutated tree | `ca1bb80` | **`31052415338`** | green at **every** step of `build` and of `cosim` |
>
> **7 of 7 seeded classes KILLED. 7 of 8 sealed classes seeded. Zero survived.**
> The campaign maximum was 8; the missing kill is IC-M5's, and it is missing
> because the class has **no rendering at this design**, not because a bench
> failed to catch one. Every transient is `success` at the `build` job's **step 5**
> (Build) and `failure` at its **step 6** (tests), so there is **no build finding**
> in this campaign and no promotion-loop signature can arise; `journal-check` is
> red on every transient **by construction** (a mutation commit stages a work
> product with no journal append — R2) and is evidence of nothing.
>
> **The ordering rule that makes any of this evidence is verified at the tree, not
> asserted**: `git diff --name-only ca1bb80 <verdict HEAD>` returns four paths —
> two journals, `docs/reports/audit/WO-0074-mutations/README.md` and
> `tasks/BOARD.md` — and **not one byte under `test/**` moved between the seal and
> the scorecards**. Re-measured at *this* commit, `git diff --stat ca1bb80 HEAD --
> test/ libs/ tools/ docs/specs/` is still **empty**, so the denominators below are
> re-measured rather than carried forward (§0.1): **59** units under
> `test/xgmii_rx_64/`, **139** repository-wide OCaml units, **140** by the
> contaminated script matcher (`FINDING M-4`, unrepaired), leaving **80** non-M03
> = 79 behavioural + 1 build-level, and `test/cosim/` contributing **0** units.
>
> **MUST-STAY-GREEN: zero violations, zero scope findings, zero build findings.**
> M03 greens per class were 58 / 52 / 57 / 54 / 57 / 58 / 56 of **59**
> (IC-M1, M2, M3, M4, M6, M7, M10 in order); **79 of 79** non-M03 behavioural
> units and the single build-level unit held under **all seven**; no file outside
> `test/xgmii_rx_64/` was promoted under any class. **And not one red fell
> outside its class's rule** — every discrepancy between the seal's rules and the
> run ran in the *other* direction, a rule selecting units that stayed green. **A
> rule too wide costs a correction; a rule too narrow would have cost the
> verdict.**
>
> | Row | Campaign status | The evidence, not the adjective |
> |---|---|---|
> | **M03-M1** | **QUALIFIED — 1 class, 1 kill** | IC-M1 at carrier `M03-F3`, `observed 1` — the campaign's only *subtractive* sealed reading, and its printed cycle `11` derived as specification-fixed rather than mutant-owned. Run `31054172382`. |
> | **M03-M2** | **QUALIFIED — 1 class, 1 kill**, and `OBSERVATION M-O1` **CLOSED in its favour** | IC-M2 at carrier `M03-G1`, `observed 2`. Run `31054177436`. |
> | **M03-M3** | **QUALIFIED — 1 class, 1 kill** | IC-M3 at carrier `M03-E1`, `observed 2` at the **FULL** prefix variant the seal *derived* (24 delivered octets, 24 mod 8 = 0) rather than transcribed. Run `31054174810`. |
> | **M03-M4** | **QUALIFIED — 1 class, 1 kill**, and `FINDING M-O1a` **CLOSED in its favour** | IC-M4 at carrier `M03-H1`, `observed 2`. Run `31054177858`. |
> | **M03-M5** | **SCORED AND UNQUALIFIABLE at this design** | IC-M5 has no datapath-silent rendering here: **one** open-frame term, and it bounds the delivered extent. The narrow form is the adopted one — see the row's own cell. Zero kills, **not** a survivor. |
> | **M03-M6** | **QUALIFIED — 1 class, 1 kill, ON THE FIRST-EPOCH CARRIER ALONE** | IC-M6 at `M03-G7`, `observed 3`, with second-epoch carrier `M03-G3` **green**: `FINDING M-1` **MEASURED**. Run `31054177532`. |
> | **M03-M7** | **QUALIFIED — 1 class, 1 kill, ON THE FIRST-EPOCH CARRIER ALONE** | IC-M7 at `M03-G8`, `observed 2`, with second-epoch carrier `M03-G4` **green**: `FINDING M-2` **MEASURED**. Run `31054179722`. |
> | **M03-M8** | **UNSCOREABLE, UNSCORED — survives any outcome** | No mutant exists: REQ-107's and REQ-108's octet ranges are disjoint. **Non-existence, not blindness.** |
> | **M03-M9** | **UNSCOREABLE, UNSCORED — survives any outcome** | The interface forbids a mutant: M03 is the **origin** of `tuser`[0] on this chain. |
> | **M03-M10** | **QUALIFIED — 1 class, 1 kill, ON `M03-F2` ALONE** | IC-M10 at `M03-F2`'s 0-octet member, `observed 2`. **`M03-B3` is NOT qualified**: `DECLARATION WO-0074-D1`. Run `31054180874`. |
> | **`M03-H3`'s own row** | **NOT QUALIFIED** | Its only red is IC-M3 blast radius raising IC-M5's sealed string — collision 2, decided by `M03-E1`'s state. |
> | **`M03-B3`'s own row** | **NOT QUALIFIED — a declared non-closure, not a bench gap** | Structurally out of ruling 9's reach at this design: `DECLARATION WO-0074-D1`, at §7. |
>
> **SEVEN M ROWS QUALIFIED, SEVEN CARRIER ROWS QUALIFIED WITH THEM, SEVEN KILLS
> — and the pairing is what makes that arithmetic honest.** In every case the
> mechanism ran through the co-occurrence the M row asserts: the strobe **SET**
> changed, and the carrier's strobe-set assertion is the assertion that spoke. A
> carrier kill and its bound M row are **one** kill (`WO-0066` §11), and each of
> the seven is recorded in **both** rows' own cells saying so in terms.
>
> **THE BLAST-RADIUS ACCOUNTING, AND IT IS THIS ROUND'S SHARPEST RESULT —
> `FINDING M-3` CONVICTED A SECOND TIME, FROM THE OTHER DIRECTION.** The campaign
> raised **21** reds and produced **7** kills. **Fourteen of the twenty-one reds
> are blast radius and contribute zero kills.** Named per class, as the packet's
> §12 item 7 requires:
>
> | class | reds that are BLAST RADIUS | what they do **NOT** qualify |
> |---|---|---|
> | IC-M1 | — (its rule selects one unit) | — |
> | IC-M2 | `M03-G2`(1519), `M03-G3`, `M03-G4`, `M03-G6`, `M03-G7`, `M03-G8` | **`M03-M6` and `M03-M7`**, both of whose carriers reddened here through **ruling 2** |
> | IC-M3 | `M03-H3` | **`M03-M5`** — and `M03-H3`'s own row |
> | IC-M4 | `M03-H2`, `M03-N2`(S0/A0), `M03-N2`(S4/A4), `M03-N4` | — |
> | IC-M6 | `M03-G6` | — |
> | IC-M7 | — (its rule selects one unit) | — |
> | IC-M10 | `M03-G7`, `M03-I2`(member iii) | **`M03-M6`**, whose carrier reddened here through **ruling 9** |
>
> The block above says a seeded class that kills a carrier kills its M row *by
> construction*. **This round is that sentence's counter-example in both
> directions at once**: every one of the seven kills *did* run through the
> co-occurrence, so the sentence's conclusion held seven times — and it held
> **because §11's corrected carrier/bound-row rule was applied**, not by
> construction. Under the "by construction" reading, fourteen further reds at
> bound carriers would each have qualified an M row, and this family would have
> reported **twenty-one** kills instead of seven. **The corrected rule is what
> stands between those two numbers**, and it is stated here so that no later
> scorecard reaches for the larger one: **a kill qualifies a row on the class it
> was seeded against and on nothing else.**
>
> **§4(c)'s DATAPATH-SILENCE CHECK AND THE QUALIFICATION CRITERION WERE THE SAME
> TEST THIS ROUND, WHICH IS THE STRUCTURAL RESULT.** All 21 reds are
> **exact-strobe-set** messages: zero output-word-count, zero `tlast`-cycle, zero
> `tkeep`, zero `tuser`[0], zero delivered-octet, zero frame-split and zero
> following-frame messages; zero `test bug --` messages; zero
> `assert_monitors_clean` messages; every red carrying a `lane 0` prefix. Since
> the strobe-set assertion is the **last** assertion in every one of the twelve
> carriers, with every datapath assertion before it, each red is a **compound
> statement**: *the strobe set changed **and** the whole delivered stream of that
> unit — output-word count, `tlast` cycle, `tkeep`, `tuser`[0] and every
> delivered octet, for every frame in the unit — is byte- and cycle-identical to
> the conformant one.* Twenty-one such statements, across twelve units in five
> files, including two 1514-octet truncated frames and three no-output-word
> classes. At `WO-0063B` that signature had no domain at the unit it scored; at
> `WO-0073` it was a side condition; **here one body of evidence discharges both
> the silence check and the kill.**
>
> **THE FOUR FINDINGS OF THIS ROUND ARE ALL AGAINST MY OWN INSTRUMENTS. There is
> no finding against the manifest, and no `BUG-`: every red is a seeded kill or
> its predicted radius.** They are recorded here because this plan is where a
> later seal's author will look for them, and three of the four are directly
> about how a seal must be written.
>
> 1. **`FINDING WO-0074-S1` (MINOR) — a rule that names the condition a class
>    keys on must also name every gate the rendering may NOT remove.** My IC-M3
>    rule said the comparison runs *"whatever the delivered count, zero
>    included"* and my IC-M4 rule *"zero-delivered aborts included"*. Both
>    describe **combined** classes (IC-M3 ∧ IC-M10, IC-M4 ∧ IC-M10) that my own
>    packet forbids to be seeded, because the classes **retain** the sub-five
>    gate. As written they selected **seven** units that stayed green, and the
>    seal's own adjudication would have turned each green into a finding against
>    the manifest. **Corrected before the run** by the auditor's committed
>    pre-run reading note; with the conjunct restored the corrected rules bound
>    the observed red sets **exactly, in both directions** — IC-M3 = `{M03-E1,
>    M03-H3}`, IC-M4 = `{M03-H1, M03-H2, M03-N2 delivered ×2, M03-N4}`. Zero
>    scoring consequence.
> 2. **`FINDING WO-0074-S2` (MINOR) — prose counts drifting from a matrix that is
>    itself correct.** The seal asserts **seven** load-bearing greens where its
>    matrix carries and its own sentence enumerates **six**; and it says
>    *"eleven of the twelve carriers"*, calls one *"the tenth"* and elsewhere
>    says *"ten instances"*, where the measured fact is **twelve**, one per
>    carrier. The matrices govern; no cell changes class; zero scoring
>    consequence. **The general shape is §0.1's**, which is why it is filed here.
> 3. **`FINDING WO-0074-S3` (MINOR) — the IC-M10 rule read only the octet count**
>    and so selected `M03-B3` and `M03-N2`'s six sub-cases, which **no**
>    datapath-silent mutant of ruling 9 can reach at this design; the seal marked
>    `M03-B3` REQUIRED-RED on that basis. Corrected before the run by the
>    manifest's epoch table. Consequence: one sealed cell rescored, and one new
>    standing declaration — **`DECLARATION WO-0074-D1`**, whose home is §7 beside
>    the X-rows and whose row-level bars are recorded at `M03-M10`, `M03-B3` and
>    `M03-N2`.
> 4. **`FINDING WO-0074-S4` (MINOR) — a collision inventory built from the marked
>    cells alone is incomplete by construction.** The seal named three
>    collisions; the run instantiated a **fourth**, character for character at a
>    **scored** cell (`M03-G8`, IC-M2 ≡ IC-M7, `observed 2` in both), and a fifth
>    at `M03-G6` (IC-M2 ≡ IC-M6) that is scored for neither class. No kill was
>    endangered — the discriminators were already sealed — but the method failure
>    is real and general, and it is **banked as a bar on the family J and K
>    seals**: *a collision inventory is complete only if it is derived from the
>    cross product of every class's predicted red set with every scored cell —
>    never from the scored cells alone, because the classes that collide with a
>    cell are usually not the class that owns it.*
>
> **`FINDING WO-0074-A1` (MAJOR, the auditor's, ruled ACCEPTED) is recorded here
> for its DV-side consequence, which is nil, and for why.** The auditor declined
> to cut, commit and push the transient branches and filed the absence of an
> authorising ADR as a finding **before the first branch existed**; the
> orchestrator cut them itself. **What makes the campaign evidence is the
> ordering rule, and it held** — the bench was frozen strictly earlier in history
> than every mutant it judged, verified at the tree rather than assumed, every
> branch's parent `ca1bb80`, every branch one class, every class's run id
> reported.
>
> **ERA TALLY — AND A FOURTH COLUMN IS OPENED RATHER THAN A FIGURE FUDGED.**
> Program tally, class-based, `WO-0050` onward, carried here because this plan is
> where the classes are argued:
>
> | | sealed | killed | survived | **void by declaration** |
> |---|---|---|---|---|
> | before this campaign (`WO-0073-VERDICT`) | 41 | 40 | 1 | 0 |
> | **family M** | **+8** | **+7** | **+0** | **+1** |
> | **after** | **49** | **47** | **1** | **1** |
>
> 47 + 1 + 1 = 49. The one survivor is still `G-c4` (`FINDING G-1`). **`IC-M5` is
> the era's first VOID class**, and the column exists because collapsing it into
> *killed* would **overstate coverage** and collapsing it into *survived* would
> **libel a bench that was never given anything to catch**.
>
> **What this does and does not buy** — every clause a refusal the scorecard
> would otherwise be read as granting.
>
> 1. **Qualification measures an instrument; it discharges no row and moves no
>    discharge count** (`J-dv_lead-0109`, applied to fourteen rows here). **The
>    census is unmoved and that is the rule, not an oversight: 62 of 62**,
>    re-measured at this commit by `tools/dv_checks.sh`'s own census commands
>    rather than carried forward — **78** row ids declared, **62** named in a
>    committed unit title under the trailing-digit boundary matcher and 62 under
>    the naive one (the two agree at this tree, a property of today's id set and
>    not of the method), − `M03-A4` (NO-ASSERT, named in a title) + `M03-F5` (by
>    citation) = **62**; the 62 ASSERT denominator counted from this file's own
>    status cells in the same pass, **before and after these edits**. No unit and
>    no title moved in this round.
> 2. **A full family-M scorecard is not full coverage of §4.M.** Ten rows; seven
>    qualified, one unqualifiable at this design, **two that can never enter a
>    denominator at all** (`M03-M8`, `M03-M9`). A packet reporting "7/7 killed"
>    has said something true about eight classes and nothing about three rows.
> 3. **This campaign probes exactly ONE instrument family** — the exact-strobe-set
>    check, at **twelve** instances of it, one per carrier. Twelve carriers
>    reddening across five files reads like breadth and is not: it says
>    **nothing** about the datapath assertions in the same twelve units, which
>    other campaigns scored.
> 4. **The four residue classes are close relatives.** IC-M2, IC-M3, IC-M4 and
>    IC-M10 differ only in **which closure kind enables the comparison**. Four
>    kills there are **four kills of one idea evaluated at four gates**, and this
>    plan says so rather than recording four independent defects.
> 5. **A kill proves the assertion convicts, never that the bench is a general
>    detector of the class.** IC-M2 and IC-M10 were detected across many units;
>    **this bench was blind to neither**, and nothing here should be read as
>    saying it was.
> 6. **The differential co-simulation anchor is blind to this entire campaign, by
>    grammar.** The pinned canonical form is `{ tkeep; tlast; tuser0; octets }`
>    plus an accept/discard decision per input frame — **there is no strobe
>    field**. The `cosim` job was `success` under all seven classes and **that
>    green is evidence of nothing**; confirmed from the other side by the
>    manifest, not one of the seven diffs changing a delivered word, a `tkeep`, a
>    `tlast`, a `tuser`[0] or an accept/discard decision. Undischarged, and now
>    **measured**. It is a **second and independent** blindness of that lane, and
>    it is **not** §7's bar 3: bar 3 is per **quantity** (timing), this one is per
>    **field**. **Both are paid from one measurement in the cosim-lane round**,
>    whose `WO-` also carries the decision the packet named — whether the
>    canonical form gains a strobe record at all, now that a whole eight-class
>    campaign has run under it invisibly. **Neither is paid here, and the §7
>    banner entry for this one is that round's to write, not this one's**: a plan
>    round is not where machinery lands (`J-dv_lead-0112`).
> 7. **`tuser`[0]'s "set once" clause and simultaneous-strobe order remain
>    unfalsifiable**, and **C-23's same-cycle counting convention costs nothing**
>    — an equivalent-mutant fact under `WO-0069`'s ruling, not a coverage gap. No
>    kill in this campaign is evidence for or against any of the three.
> 8. **No `SO-xgmii_rx_64.md` is opened or offered.** Families **J** and **K**
>    are unscored, and the charter §3 co-sim anchor is undischarged **per
>    stimulus class** and now additionally **blind per strobe**. **The lessons
>    harvest falls due at the `SO-`**, not at a campaign verdict and not at a
>    plan round; the span since my last harvest stays **open and declared**, with
>    three candidates banked against it in `J-dv_lead-0137`.
> 9. **Nothing in `test/**` is owed by this result**, and nothing in `test/**`
>    moves in this round. The two carriers this campaign named — the 4-octet
>    member reorder at `test_m03_f.ml` and the `M03-I4` mislabel at
>    `test_m03_i.ml` — are recorded at their rows with their carriers named, and
>    a plan round is not where a carrier is improved (`J-dv_lead-0112`).

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
| **M03-N1** | §9's closure list, REQ-113, REQ-105 | Two closure characters in one input word where the **second arrives after the frame is already closed** and no frame is open: `/T/` in lane 0 and `/E/` in lane 5 | The `/T/` closes the frame normally (REQ-106, FCS checked); the `/E/` finds **no open frame** and produces nothing and pulses nothing (§9's third row, C-12) | A design evaluating every control lane of a word against the state the word *started* in. **QUALIFIED — 1 class, 1 kill, AND IT IS THE FIRST QUALIFICATION IN THIS ROW'S HISTORY** (2026-08-11, `WO-0077-VERDICT` §4.1 and §6 at `d6fdf92`; seal frozen at `aced7b4`, manifest at `f9232c2`, adjudicated `J-dv_lead-0147`; landed here `J-dv_lead-0148`). **IC-N1** — *every control lane of an input word routed against the state the word **started** in*, which is **this cell's own named design, seeded against it and against nothing else** — raised this row's **per-word `tuser` arm**, `M03-N1 (lane 0): the frame's own tlast word unexpectedly carries tuser[0] = 1 -- a clean frame is not aborted`, at `test/xgmii_rx_64/test_m03_n.ml:936–941 @ 22ffe13`, guarded to the frame's own `tlast` word by `is_last` at `:932`, CI `build` run **`31075098067`**. Disclosed: `D-N1a` = `error_bad_frame`, `D-N1b` = reading (b), `D-N1c` = **β**. **One kill. `M03-N1` QUALIFIED on its Observable clause 1** — *"the `/T/` closes the frame normally (REQ-106, FCS checked)"*, of which `tuser`[0] = 0 is part. **`FINDING AP-3` is thereby discharged in the affirmative at this row**: it measured that this row had been qualified by nothing anywhere, and this is the first red at the row's own cell under a class seeded against the row's own observable. **Status left at `ASSERT`** (`J-dv_lead-0109`). **AND MY SEALED CELL MISSED — `FINDING WO-0077-N1` (MINOR, mine, against `D-N1c`'s dichotomy and the seal's §12.1 branch derivation), PRE-DECLARED AT THE PRE-RUN NOTE §0.3 BEFORE ANY TRANSIENT WAS CUT AND SCORED AGAINST ME** (`J-dv_lead-0146`; measured `WO-0077-VERDICT` §4.1 and §9.3 item 3). **Both** sealed branches were missed and the run says why. The **α** cell (`M03-N1 (lane 0): the out-of-frame /E/ unexpectedly produced a strobe`, `:954`) was never reached, because the `tuser` arm **speaks first**. The **β** cell (`M03-N1 (lane 0): expected 8 delivered words, got <n>`, sealed `< 8`, derived 7) was never reached, because **the delivered-word count did not move**: the assertion at `:902–910` passed with eight. **My `D-N1c` dichotomy offered two branches and implicitly claimed the pair was exhaustive; the design's third route reaches a report AND `tuser`[0] while the coverage arithmetic never moves.** **The class is not penalised, and that is not generosity**: the mechanism was disclosed exactly, in the auditor's own words, before the run, together with a statement of what moves and what does not — the same disposition `RN-3` §3.2 fixed one instrument over. **What it costs is a seal's cell, and the cost is mine.** **AND A SECOND CARRIER OF THIS ROW'S OWN GEOMETRY WAS DISCOVERED BY THE ROUND — `FINDING WO-0077-N2`'s under-selection half, and it is worth a plan row and worth nothing if it is only in a verdict.** `M03-E4 (lane 0)` reddened under IC-N1 at `test/xgmii_rx_64/test_m03_e.ml:584 @ 22ffe13`, and reading its stimulus establishes why: it places an `/E/` in the **same input word** as its own frame's `/T/`, bit for bit this row's geometry, built by `Bench.run`'s `?word_at` hook instead of by an overlay. **So this bench contains TWO independently constructed carriers of the two-events-in-one-input-word discrimination, in two different families, and no packet before this one knew it.** The consequence for this row is a narrowing, not a widening: **`M03-E4` is qualified by nothing in this campaign** (its red is blast radius), and **this row is not the sole instance of its geometry** — see `M03-E4`'s own Stimulus cell, where the arithmetic is worked and where the lane-4 member is shown to be a genuine gap case and not a second instance | ASSERT |
| **M03-N2** | §6.1's "more than one event in one input word" paragraph and its cycle table, §9's closure-list clause (a) and §9's repaired "Strobe cycle, pinned" rule — all at `06c1eba`; REQ-102, REQ-107, REQ-105, REQ-110, REQ-101 | Two closure characters in one input word **W** where the second falls **inside the new frame's preamble**: `/S/` in lane 0 or lane 4 of W, and `/T/` (or `/E/`) in a higher lane of the same W. **Six sub-cases, not four** — the discriminators are the *aborting* start character's lane, the **aborted frame's own** start lane (it enters through §7's L) and whether the aborted frame delivered an octet; the table below this table enumerates them and each must be driven | **Reading (i) RULED (WO-0029 §3a), ENDORSED on a second independent ground (REQ-101, below), and now fully pinned.** The `/S/` aborts the open frame (one `error_start_without_terminate`, `tuser`[0] = 1 on its `tlast` where it emitted one, no FCS removed) and the `/T/`/`/E/` closes the frame that same `/S/` opened with zero delivered octets — no output word, one `error_runt` (REQ-107) or `error_bad_frame` (REQ-105). **Cycles, from SPEC-M03 §6.1's table**: the new frame's report is **W + 2** always; the aborted frame's is **W + 1** except when the aborting `/S/` is in lane 4 *and* the aborted frame began at lane 0, where it is **W + 2**; a zero-delivered aborted frame is **W + 2** at both lanes. So the two reports coincide in **three of the six** combinations, always under **different** strobe names — §6.3 item 8, which excludes only a same-name coincidence, has **no instance** here. **Both cycles are gap-invariant** — **the GROUND for that is REPAIRED 2026-08-07 (`J-dv_lead-0085`) and the NAMED WORD is RE-BASED 2026-08-07 (`J-dv_lead-0087`, under the D(m) re-ruling at `1f3c04c` countersigned at `J-dv_lead-0086`)**: each is pinned relative to a **named input word**, and that word is **W in every row of the table — the two whose octets lie in the word before W included**, because *"an aborted frame's last word can be proven last by nothing except the character that aborted it, so D for that report is W and the offset is the row's own"* (§6.1 at `1f3c04c`); on an injected line each is read at **W's** own injected position, which is SPEC-M03 §6.1's consequence-1 scope note and requirements.md §0.5's *deciding input word*. *The parenthesis this replaces read "(W itself, or the word carrying the aborted frame's last octet)" — the second alternative is the superseded D and is withdrawn.* The former ground — §7's per-octet constant, this plan's own Route 2 at §4.N — is **withdrawn as false** (`SCR-M03-I4`: that constant does not survive injection at either start lane). **The conclusion is unaffected, because it never rested on the constant**: these cycles are causal and keyed to input words, which is exactly what makes them survive. **Idle injection before W moves BOTH reports TOGETHER**, by the same amount, because both are read at W: rows 1 and 2 report at **W + 1** against the new frame's **W + 2** on every stimulus, gapped or gapless, so the coincidence column is unchanged at **every** `k` and is injection-proof **on the offsets alone**. The row may be run inside the M03-I4 wrapper. *The clause this replaces said injection before W moves the two lane-0-`/S/` reports **earlier**, further from the new frame's and never onto it; it read those rows against the word carrying the aborted frame's last octet and is **withdrawn in terms** at `1f3c04c`. The conclusion it supported is unchanged — the six rows, the three coincidences and §6.3 item 8's having no instance here all stand — and now rests on the offsets rather than on a direction of motion.* **Strobe set, exhaustive** (§9 ruling 9 at `1fe71ca`): on the zero-delivered sub-cases the two reports are **exactly** `error_start_without_terminate` (the aborted frame — no FCS check, §9 ruling 4) and `error_runt` (the new frame — sub-5 class, ruling 9), **and nothing else**; `error_bad_fcs` pulses for neither, which is what turns this row's strobe assertion from a lower bound into a count | Reading (ii), which rtl_lead declared and the ruling rejected: killed by the presence of the second strobe at all. Beyond it, the six sub-cases kill a design that reports both frames on one fixed offset from W regardless of the aborted frame's start lane or delivered count — the sub-case pair (lane-4 `/S/`, lane-0-started A) against (lane-4 `/S/`, lane-4-started A) differ by one cycle on otherwise identical stimulus and no other row separates them. **QUALIFIED 2026-08-06 — four scoreable classes, four kills, 4/4** (`WO-0066-VERDICT` §§1, 4, 5 and 6, disposition 1 at each; campaign `WO-0066`, sealed at `WO-0066_family-bn-mutation-campaign-SEALED-predictions.md` before any diff existed and opened only after all six scorecards did; `J-dv_lead-0117`, recorded here `J-dv_lead-0118`). **The qualification is recorded in this cell and the Status cell stays `ASSERT`** — §1's status vocabulary is a closed set of six values, `QUALIFIED` is not one of them, and M03-I2's, M03-E5's and M03-F2's qualifications already sit in their Kills cells (`J-dv_lead-0109`'s divergence ruling, followed here rather than re-decided). **Per class, with what each one measured.** **IC-C — the coincidence serialised**: three units red, three predicted, zero outside, all three messages character-exact, at sub-cases 3, 6 (zero-delivered branch) and 4 (delivered branch); **and the three REQUIRED GREENS held** — sub-cases 1, 2 and 5, whose two reports are already a cycle apart, stayed green, so the class measured **the coincidence** and not reports in general, which is the only way its kill means anything. Raise sites `test_m03_n.ml:554` and `:614`, both step 8(b); `assert_monitors_clean` (`:643`) **never executed**, so the standing `Strobe_monitor` spoke nowhere — as at `WO-0063B`, and as §2 obligation 4's measured inventory predicts. **IC-B — the zero-delivered close mis-scored**: all six N cells red with the identical body and the derived `<n>` = **1**, character-exact; **scored on branch `R` alone**, because the auditor disclosed `D-B1 = R` and declared branch `W` unrenderable at this design, which the pre-run reading note's **disposition 8, VOID BY DISCLOSURE** puts outside the scorecard — the `W` cells are **not scored, contribute zero kills, and are findings in neither direction**, and none of that is DV coverage. At the four delivering sub-cases the raise is the **pulse** message, so frame A's `tlast` cycle, `tkeep`, `tlast` bit and `tuser`[0] all passed and the rendering is report-path-only by measurement. **IC-E — the runt check on the abort path**: killed at **sub-case 2 alone** (`observed 3` against a conformant 2), which was the class's whole `R!` set. **IC-A — the in-word abort**: sub-cases 4 and 5 message-exact with the word count sealed `< 1` and observed **0**; sub-case 6 red on the **other arm** of the same check (two pulses under one name, not one pulse), a message **MISS** recorded as `FINDING WO-0066-5` against the seal and deliberately **not** absorbed into the kill. Bound 7's disposition is at **§4.H bound 2**, which carries the score, the state split and the correction; it is not restated here. **THE HONEST SCOPE, AND IT NARROWS WHAT THIS ROW UNIQUELY BUYS — `FINDING WO-0066-6`.** `M03-H1` (lane 4) and `M03-H2` (both lanes) reddened under IC-A where the seal predicted green, and reading their stimuli established why: both drive a **lane-4 in-word abort of a frame already open on entry**, and both have been in this bench since `WO-0057`. **So sub-cases 4 and 5 are NOT the first detectors of that conjunction, this bench was NOT blind to it, and no packet may imply otherwise.** **What remains genuinely this row's own is (i) the `Preamble`-state instance — sub-case 6, where `M03-H1`/`H2` abort frames in `Frame` state — and (ii) the coincidence geometry IC-C measures, which exists nowhere else in this bench.** That is a smaller claim than this row carried before the campaign and it is the measured one. **FIVE MUST-STAY-GREEN violations across the two classes, at four distinct units, are against the SEAL and not against the bench** — **three under IC-E** (`M03-N2` sub-cases 1 and 5, and `M03-H2`: `FINDING WO-0066-3`, a sealed `G` derived from a sub-five runt floor where requirements.md §12's predicate is **fewer than 64 octets**) and **two under IC-A** (`M03-H1` and `M03-H2`: `FINDING WO-0066-6`), with `M03-H2` violated under both classes from the same root cause. Every unit behaved correctly, **including every one that reddened where the seal said it would not**, and nothing in `test/**` is owed by this result. **TRAP T8's SINGLE OBSERVABILITY IS PERMANENT, AND IT IS AN INTERFACE PROPERTY, NOT A BENCH DEFECT** (`WO-0066-VERDICT` §5.2 on the pre-run reading note's ruling 1(c), adopted from the auditor's ground over the seal's own). The unit's **T8** — *A's strobe set on the delivered sub-cases is `error_start_without_terminate` ALONE, even where A delivers fewer than five octets* — is **asserted at two members (sub-cases 2 and 4) and observable at one (sub-case 2)**. At sub-case 4 the mutant's output is **bit-identical to a conformant design's**, because §0.6 counts **high cycles, never rising edges** and frame A's added `error_runt` lands on the cycle frame B's genuine one already occupies: an **equivalent mutant**, not an undetected one, and **no bench change reaches it** — the limit is in the strobe interface, which reports ~~**presence per cycle and not multiplicity**~~ **a LEVEL per cycle** (the strike and the replacement are 2026-08-09, `J-dv_lead-0132`; see the ruling paragraph below). **Two consequences bind every later packet.** (1) **No `SO-`, campaign or scorecard may claim T8 is instrumented at two members** on the strength of IC-E's kill, or read sub-case 4's green as a blind instrument. (2) ~~Whether M03's strobe contract should carry a multiplicity signal is an **architect question**, raised as one and **not** as a `BUG-`~~ — **RAISED AND ANSWERED. `WO-0069` item 2, ruled by architect_docs_lead 2026-08-09 (`J-architect_docs_lead-0031`, landed at `b6ef1cb`; accepted as landed `J-dv_lead-0126`; transcribed here `J-dv_lead-0132`), as a non-normative note appended to requirements.md §0.6's counting convention.** **The ruling, in the three clauses this cell depends on.** *(α) The rule is read on EVENTS, not on conditions, and this cell's operating assumption of "presence" is CORRECTED IN ITS SUBJECT and CONFIRMED IN ITS CONSEQUENCE*: presence is right about the **port** — one bit, one level per cycle — and wrong about the **contract**, which is per event. *(β) The obligation each reported event creates is a LEVEL, not an increment*: the event obliges the signal high on the one cycle its module specification pins, so **two same-name events pinned to one cycle are BOTH discharged by that single high cycle and the module has conformed**. *(γ) C-23's high-cycle convention is the observer's inverse, and it is exact only while no two same-name events share a cycle*: on a shared cycle it **under-counts**, and **the shortfall is in the DECODING, never in the design**. **What changes for this cell and what does not.** The equivalent-mutant conclusion at sub-case 4 is **unchanged** — bit-identity is the criterion under either reading — and consequence (1) above stands unaltered. What changes is **what a packet may say**: not *"the design is conformant here because presence held"*, but *"both events' obligations were discharged by the level, and no instrument at this port can recover the count"*. **NO MULTIPLICITY SIGNAL IS OWED**, and the ground is (β) rather than cost: the contract is already discharged by the level, so a count port buys **nothing for conformance** and only fault observability. **The question is closed and no `BUG-` was ever owed.** The `Strobe multiplicity` paragraph was **never the governing rule** for this case in any event — it is scoped to *one frame* in its own words, and this cell's case is **two frames, one name, one cycle**. This fact is stated **once**, here, where the row's coverage claims are read; the Observable cell's exhaustive strobe set is T8's spec-side origin and is not amended for it. **TOUCHED BY THE FAMILY-M CAMPAIGN IN BOTH DIRECTIONS, AND NEITHER IS A QUALIFICATION OF THIS ROW — 2026-08-10** (`WO-0074-VERDICT` §2, §7(b), §7(c) and §8.3; `J-dv_lead-0137`, recorded here `J-dv_lead-0138`). **(a) Two of this row's six sub-cases reddened under `IC-M4`** — the **delivered** ones, S0/A0 and S4/A4 — raising exact-strobe-set messages. Those reds are **blast radius** under IC-M4's own corrected rule, they contribute **zero** kills, and they qualify neither this row nor `M03-M4`. **The other four sub-cases stayed green and their greenness was REQUIRED, not a miss**: they deliver zero octets, and IC-M4 retains the sub-five gate, so no comparison runs (`FINDING WO-0074-S1` — a defect in my seal's rule, corrected before the run and costing nothing). **(b) All six sub-cases are PERMANENTLY UNSCOREABLE against §9's ruling 9 — `DECLARATION WO-0074-D1`**, whose home is §7 beside the X-rows: they share family B's in-word geometry, and at this design a frame opened **and** closed inside one input word is reported by a separate in-word report vector **carrying no FCS-report member at all**, so ruling 9's co-occurrence defect has no datapath-silent rendering here. All six were predicted GREEN by the manifest's epoch table **before the run** and all six were green. **No `SO-`, campaign or scorecard may count this row's sub-cases as coverage of ruling 9**. **TOUCHED BY THE FAMILY-K/N CAMPAIGN AND QUALIFIED BY NOTHING IN IT — and the SHAPE of the touch is a finding against my own seal, 2026-08-11** (`WO-0077-VERDICT` §4.1's per-unit table and §9.2 at `d6fdf92`; adjudicated `J-dv_lead-0147`; landed here `J-dv_lead-0148`). Under **IC-N1** this row's **four delivered** sub-cases reddened — `S lane 0, A lane 0` and `S lane 4, A lane 4` at `test/xgmii_rx_64/test_m03_n.ml:603 @ 22ffe13` (*"frame A's own tlast word tkeep does not match the delivered count"*), `S lane 0, A lane 4` and `S lane 4, A lane 0` at `:635` (*"expected exactly one delivered word for frame A, got 0"*) — and **both zero-delivered** sub-cases stayed **GREEN**. **Every one of the four reds is blast radius: they are inside IC-N1's own permission list under branch β, they contribute ZERO kills, and they qualify neither this row nor `M03-N1`** (`WO-0066` §11's per-class rule is what stands between four reds and four kills). **`FINDING WO-0077-N2` (MAJOR, mine, against my seal's IC-N1 rule and its worked-instance derivation) — half one, the OVER-selection, and this row is where it was measured.** The seal derived its instance list *"from the units' own stimulus titles"* and asserted the class runs in **two** directions — adding a strobe here, **removing** one at every selected family-B unit — closing with *"a scorecard showing only additions or only removals is a finding against this rule."* **The scorecard shows only additions, and the check fired against the rule that carried it.** All five family-B units the list named (`M03-B2`, `M03-B2 /I/`, `M03-B2 /Q/`, `M03-B3`, `M03-B4`) are **GREEN** — `test_m03_b.ml` was not promoted on the `n1` branch at all — and this row's two zero-delivered members are green as well: **seven cells the instance list selected came back green.** **Adjudicated: the rendering is asymmetric where my rule assumed symmetry.** It mis-routes a later lane past an **earlier lane's `Frame` exit** and carries the consequence on the closing frame's own **delivered** word; it does not disturb the `Idle → Preamble` transition, so family B is untouched, and **a zero-delivered frame has no delivered word for the consequence to land on**, which is exactly why this row's two zero-delivered members held. **The rule conflated *"an earlier lane effects a state change"* with *"any earlier lane transition"*, and stated a removal direction no rendering in this class need produce.** **No scope finding and no cell out of specification**: seal standing rule 5 makes the **rule** govern where rule and instance list disagree, and all six reds sit inside IC-N1's §7 permission list. **What it costs is a claim, and the claim is retracted at the verdict: the breadth this class appeared to promise was smaller and differently shaped than the seal said — six reds and one kill, five of them at two other families' units, and five units the seal listed as blast radius were never in the blast radius at all.** **No family-B row is qualified by anything in this campaign, and neither is this one** | ASSERT |
| **M03-N3** | REQ-016, REQ-102's third sentence, REQ-105, §6.1's preamble-position paragraph and §10's REQ-016 hook (both `541ea43`) | An idle word placed **between a frame's start character and its first octet** | **The stimulus is decided, not out of the specified space** — the architect declined dv's requested §6.3 sentence and gave something stronger (WO-0029 §3b), and the correction is accepted: an idle character in a preamble position is "any other control character" in REQ-102's third sentence, so it is routed to **REQ-105** and ends the frame with one `error_bad_frame` and no output word (§9's third row). The constraint that is actually owed binds the **wrapper**, and §6.1 and §10's REQ-016 hook now carry it: **the idle-injection wrapper of M03-I4 SHALL NOT inject between a start character and the frame's first octet.** The row therefore stays **NO-STIMULUS for the REQ-016 family**, now with a spec citation instead of an inference; the assertable case it makes available is REQ-105's, commissioned by §10's REQ-102 hook and carried at **M03-B2**. **Caveat carried as C-45**: at a **lane-0** start the whole preamble lies inside the start word (§6.1 says so in the same paragraph), so an injected idle word at the first inter-word boundary occupies **no preamble position** and is §6.2's ordinary C-14.4 hold — the prohibition is over-broad there and its stated ground does not hold at that lane. The constraint is honoured as written until the scope lands | A wrapper that injects uniformly across the whole frame including the preamble: at a **lane-4** start it puts idle characters in preamble positions 4 … 7 and measures REQ-105's abort while claiming to measure REQ-016's tolerance — a failure that is the bench's, not the design's | NO-STIMULUS |
| **M03-N4** | REQ-810 (revised `541ea43`), REQ-803, REQ-110, §4.3, §6.2's three rows, §9's closure-list clause (b), §10's REQ-110 and REQ-802/REQ-810 hooks, **ADR-0014** | `cfg_rx_enable` goes 0 **mid-frame**, and a new `/S/` (REQ-110's condition) arrives while it is 0, at least one cycle away from the change (§6.3 item 7, C-14.5) | **Reading (i) RULED (ADR-0014) and ENDORSED** — an enable gates the *admission* of a frame and nothing else. The commissioned observable, taken from §10's REQ-802/REQ-810 hook and not from the row's own prose: the in-flight frame is **aborted at the octet before the `/S/`** with `tuser`[0] = 1 on its `tlast` word (or **no output word at all** where it had delivered none — **that parenthesised branch has NO INSTANCE at this row; the finding is at the end of this cell and it is against my own row, not against the hook's wording**), **exactly one** `error_start_without_terminate`, **no** output word for the frame that `/S/` would have begun, and the next frame received normally after the enable returns to 1. The ruling is decided **against the two requirements**, not against the implementation — and it is worth recording that the same activation rejected the same agent's declared reading on M03-N2. **Held at RULING for one reason only, and it is not this row's**: SPEC-M03's revisions are WITHHELD at WO-0030 on the M03-N2 defects, so the §4.3/§6.2/§9 text this row derives from is not yet in force. **Converted at `06c1eba` exactly as pre-committed at WO-0030, with no change to the observable**: the R1/R2 repair touches neither §4.3, §6.2, §9's clause (b) nor §10's hooks, which `git diff 541ea43 06c1eba -- docs/specs/` confirms in three hunks. **THE PARENTHESISED ZERO-DELIVERED BRANCH HAS NO INSTANCE AT THIS ROW — a finding against my own row, derived 2026-08-07 while authoring the packet that commissions the bench (`WO-0068` §5, `J-dv_lead-0121`) and landed here 2026-08-09 (`J-dv_lead-0124`).** The parenthetical is **quoted from SPEC-M03 §10's REQ-802/REQ-810 hook and is kept**, because the hook's text is the architect's and not this plan's to edit; what changes is the claim this row may make. **THE DERIVATION, and it is arithmetic on this row's own constraints.** Frame **A** must be *admitted*, so the enable is **1** on A's own start cycle. A must deliver **zero** octets, so the aborting `/S/` lands **at or before A's first octet** (REQ-110's own zero-delivered clause) — inside the nine octet times `[first_start, first_start + 8]`, a span **beginning at A's own start character**. Therefore the aborting word **W** is A's **start word or the word immediately after it**. The enable must go **1 → 0 strictly between** A's start cycle and W — and **§6.3 item 7 (C-14.5) forbids driving a change on any start character's own cycle**, which A's start cycle is. **There is no admissible change cycle, at either start lane.** **Two escape routes are closed by the specification itself, not by convention**: `first_start` is **8 or 12** under §0.3's lane mapping, and enlarging it moves A's start cycle and W **together**, so the span never opens; and inserting an idle word between A's start character and its first octet is exactly what **M03-N3** and §10's REQ-016 hook forbid (*"the wrapper SHALL NOT inject between a frame's start character and its first octet"*). **DISPOSITION — the precedent's, at its fifth instance.** This is the **M03-D3 / M03-F2 / M03-I2 / M03-J2** unachievable-observable shape, found the same way each of those was. The **row stays ASSERT** on its delivering branch, which is REQ-110's own abort geometry conjoined with the enable and is what ADR-0014 was written to decide; §1's status vocabulary is a closed set of six values and has none for *a row one of whose observable branches has no stimulus*, so the finding is recorded **in the cell the defect lives in** — the **Observable** here, because what has no instance is a branch of the observable and not the kill, exactly as M03-J2's finding one family up sits in that row's **Kills** cell for the same reason. **WHAT IS FORBIDDEN, in terms**: no bench may assert the zero-delivered branch at this row, no comment may claim this row covers it, and **no `SO-`, campaign or verdict may read this row as coverage of a zero-delivered REQ-110 abort**. **WHERE THAT GEOMETRY *IS* COVERED: M03-N2 sub-cases 3 and 6**, under `cfg_rx_enable` = 1 — landed, green and campaign-scored. **The conjunction of *zero delivered* with *enable = 0* is a fact about the stimulus space, not a bench gap any bench could close**, which is why it is recorded here and not carried as a `GAP` row (§1 reserves `GAP` for an attack this plan wants and *cannot mount*; this is an observable that has no legal stimulus to mount). **The spec-side half of the same defect is the C-41 family** — a verification column commissioning an observable the same specification's §6.3 item 7 excludes — and it is raised with architect_docs_lead as a **non-blocking** change request in the spec queue drafted in the same round as this edit — `agents/handoffs/WO-0069_spec-queue-3-m03-hook-and-strobe-multiplicity.md`, where **`0069` is a placeholder id the orchestrator allocates at first commit** (PROTOCOL §3) — with the repair proposed in the form §10's own **REQ-014** hook already uses (*"stated so that no sign-off packet claims REQ-014 whole at M03"*). **No row of this plan moves on its resolution in either direction** | Reading (ii): the open frame is carried across a character §6.1 routes to REQ-110 and its octet count absorbs a refused frame's octets, reaching M06 with a bad FCS or (past 1518) an oversize truncation. Also a design that gates the datapath rather than admission, which suppresses the in-flight frame's own remaining words and its report — the silent-discard hole REQ-810's next clause disclaims. **NOT QUALIFIED BY THE FAMILY-J CAMPAIGN — four reds under four of its five classes, and EVERY ONE IS BLAST RADIUS** (2026-08-10, `WO-0076-VERDICT` §8 at `a8d6140`; landed here `J-dv_lead-0143`). This row's unit reddened under **IC-J1**, **IC-J2**, **IC-J3** and **IC-J4** — runs `31064102925`, `31064103812`, `31064104902`, `31064106060` — and in every case the class was seeded against a **family-J** row and scored at a **family-J** cell, so **nothing in that campaign qualifies this row in either direction**. `WO-0066` §11's per-class kill rule is what stands between four reds and four kills. **AND THE VERDICT'S OWN SOFTENING OF THAT SENTENCE IS FALSE — `FINDING AP-3`, against my own campaign text, minted by §0.1's rule at the point of citation and measured rather than recalled.** `WO-0076` §2 and `WO-0076-VERDICT` §8 both describe this row as *"already scored at `WO-0066`"*. **Re-measured against `WO-0066` itself**: that campaign qualified **`M03-N2`, `M03-B2` and `M03-B4` member (b)** and no other row, and its own §13 item 2 calls **`M03-N1`/`M03-N4`** *"both still outstanding ASSERT rows"* whose bench had not yet been written — so this row **could not** have been scored there and was not. **Measured across the whole class-based era: this row has taken FIVE reds in TWO campaigns — one under `IC-M4` at `WO-0074` and four here — and has been QUALIFIED BY NONE OF THEM.** It is a landed, green `ASSERT` row whose instrument **no campaign has ever shown to convict**, and **no `SO-` may treat it as mutation-scored**. **`M03-N1` is in the same position** and by the same measurement. The correction removes an unearned reassurance; it moves no kill, no qualification and no count. **And it leaves this row carrying a second debt**: `FINDING J-2` names it as the instrument that convicts a design **suppressing** an in-flight frame's own report — **a class no campaign has yet seeded**. **BOTH DEBTS ARE PAID, AND THE PARAGRAPH ABOVE IS LEFT UNEDITED — 2026-08-11** (`WO-0077-VERDICT` §4.2, §4.3 and §6 at `d6fdf92`; seal frozen at `aced7b4`, manifest at `f9232c2`, adjudicated `J-dv_lead-0147`; landed here `J-dv_lead-0148`; a dated claim is annotated beside itself, never rewritten into its own outcome — `J-dv_lead-0138`). **QUALIFIED — 2 classes, 2 kills, ONE qualification, on three of this row's own Observable clauses, and they are the FIRST QUALIFICATIONS IN THIS ROW'S HISTORY.** **IC-N4a** — *the refused start character does not abort the in-flight frame* — raised this row's delivered-sample cycle list at `test/xgmii_rx_64/test_m03_n.ml:1302 @ 22ffe13`, `M03-N4 (lane 0): delivered-sample cycles are [4; 5; 6; 7; 8; 9; 10; 11; 14; 15; 16; 17; 18; 19; 20; 21], expected [4; 14; 15; 16; 17; 18; 19; 20; 21]`, CI `build` run **`31075099649`**; disclosed `D-N4a-1` = the refused start character's own value is forwarded as a frame octet, `D-N4a-2` = abort and report both removed. **This is the one cell in the whole campaign whose message prints the mutant's own observation**, and the only place in either section where a seal's inequality could be checked against a number the bench reported: the seal sealed a strict superset gaining the contiguous run `5 … 11` — seven cycles — with the explicit alternative that a rendering which *holds* gains six and runs `6 … 11`, and **the observed list is the seven-cycle derivation character for character. Direction: more, as sealed.** **One kill, on Observable clauses 1 and 3** — the abort geometry and the absent output word for the frame the refused `/S/` would have begun. **IC-N4b** — *the report path is gated by the enable, so the in-flight frame's own abort report is suppressed* — raised `M03-N4 (lane 0): expected exactly one strobe (error_start_without_terminate at A's own report cycle), observed 0` at `:1421 @ 22ffe13`, run **`31075100851`**; `<n>` sealed `< 1`, derived **0**, observed **0**, **direction: fewer, as sealed**. **The seal's strongest compound claim in either section is confirmed**: the cell is reached because the class changes **nothing** the eleven assertions before it read — the delivered-sample cycle list, frame A's word count, `tlast`, `tkeep`, `tuser`[0] = 1, its content, frame C's word count, cycles, `tkeep`/`tuser`, content and sequence number. **The whole delivered stream of an aborted frame and a re-admitted one, unmoved, with only the report gone.** **One kill, on Observable clause 2** — exactly one `error_start_without_terminate`. **Status left at `ASSERT`** (`J-dv_lead-0109`). **AND `FINDING J-2` IS MEASURED — NOT WITHDRAWN — AND THIS ROW IS CONFIRMED FROM A RUN AS ITS SOLE CARRIER.** `FINDING J-2` (at `M03-J3`'s Observable) said that row's strobe clause is **unfalsifiable in the subtractive direction** because its in-flight frame is clean and owes no strobe, and named **this row** as the sole carrier that can convict the **suppressing** design. **`IC-N4b` is that design.** It reddens **`M03-N4`** and leaves **`M03-J3` GREEN** — the campaign's one load-bearing green — so the asymmetry is established **from a run rather than from an argument**, this row is confirmed as the sole carrier, `FINDING J-2` stands unwithdrawn, and **the debt `WO-0076-VERDICT` §10 left this row carrying is PAID.** **`FINDING AP-3` is discharged in the affirmative at this row**: it measured five reds across two campaigns with zero qualifications, every one arriving through an admission path seeded against a family-J row; **these two are the first reds at this row's own cells under classes seeded against this row's own observables**, and the correction it made to the *"already scored at `WO-0066`"* claim is unaffected and is not withdrawn. **WHAT REMAINS UNSCOREABLE HERE IS UNCHANGED IN EVERY RESPECT**: the zero-delivered branch above has **no legal stimulus**, this round did not reach it, and **no `SO-`, campaign or verdict may read this row as coverage of a zero-delivered REQ-110 abort**; both lane-4 members are **UNOBSERVED — never a miss and never a pass** (their lane-0 siblings raised first in all three N runs, and no lane-4 string appears in any scorecard, which is itself the confirmation that every lane-0 member raised) | ASSERT |

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
>
> **ITEM (1)'s FIRST CLAUSE IS PAID, 2026-08-10, AND THE PARAGRAPH ABOVE IS LEFT
> UNEDITED** (`J-dv_lead-0143`, from `WO-0076-VERDICT` at `a8d6140`). **Family J
> IS mutation-scored**: five classes sealed at `8346a5c`, five seeded, five
> killed, and three of its four rows QUALIFIED — §4.J's post-campaign block
> carries the identifiers, and the fourth row is unqualifiable by specification.
> **What item (1)'s second clause was reaching for is now measurable and is
> WORSE than it said, and it is about this family rather than family J**:
> `M03-N4` has taken **five** reds across two campaigns — one at `WO-0074`
> (`IC-M4`) and four at `WO-0076` — and is **qualified by none of them**, and
> `M03-N1` is qualified by nothing at all. **Two of this family's four rows are
> landed, green, and mutation-scored by no campaign**; both cells say so in their
> own words, and `FINDING AP-3` records where the contrary claim came from.
> **Item (3)'s census clause is separately dated and superseded** — families K,
> L and M were written and landed on 2026-08-09 (`J-dv_lead-0132`, §4.K/§4.L/§4.M
> landed-status blocks) and the outstanding-row figure moved with them — and it
> is flagged here rather than edited, for the reason this plan has now paid for
> five times: **a dated claim is annotated beside itself, never rewritten into
> its own outcome** (`J-dv_lead-0138`). What has **not** moved in item (3) is its
> conclusion: **no `SO-xgmii_rx_64.md` is opened or offered.**

> **FAMILY N — POST-CAMPAIGN STATUS, 2026-08-11 (`J-dv_lead-0148`, from
> `WO-0077-VERDICT`'s §N, adjudicated `J-dv_lead-0147` and committed at
> `d6fdf92`). THE TWO BLOCKS ABOVE ARE KEPT AND THEIR GROUND IS REPLACED.**
> This block carries **only the N section's own results**. The campaign's shared
> accounting — the nine classes with their branches and run ids, the K × N cross
> product, MUST-STAY-GREEN, the breadth figures, the era tally, the census and the
> findings list — is at **§4.K's post-campaign block**, written once so that two
> copies cannot drift apart. Every status word here travels with the SHA and the CI
> run id it was read at (§0.1).
>
> **THE FALSIFIABLE HALF IS ANSWERED BY EXECUTION, AND IT IS ANSWERED THE RIGHT
> WAY.** `WO-0076` commissioned this section against a condition stated before it
> could be met: *"if the auditor cannot author N-classes that assert those rows'
> own observables — the two-events-in-one-input-word discrimination of SPEC-M03
> §6.1 — then `M03-N1` and `M03-N4` are UNQUALIFIABLE BY MUTATION at this bench,
> and that SHALL be DECLARED before the `SO-`, not discovered by a sixth
> unqualifying red."* **Three such classes were authored, three were seeded, three
> killed, and both rows are qualified at their own cells.** The declaration does not
> fire and no `SO-` inherits it.
>
> **`FINDING AP-3` IS DISCHARGED IN THE AFFIRMATIVE, AND THE §4.N LANDED-STATUS
> BLOCK'S ITEM (1) IS NOW PAID IN BOTH ITS CLAUSES.** That item said family J was
> unscored and that this family's own scoring predated two of its four rows; the
> 2026-08-10 annotation paid the first clause and measured the second as **worse**
> than it read — `M03-N4` with five reds across two campaigns and no qualification,
> `M03-N1` with none of either. **Both are now qualified, at their own cells, under
> classes seeded against their own observables**, and these are the **first**
> qualifications in either row's history.
>
> | Row | Campaign status | The evidence, not the adjective |
> |---|---|---|
> | **M03-N1** | **QUALIFIED — 1 class, 1 kill; FIRST in the row's history** | IC-N1 at the per-word `tuser` arm (`test_m03_n.ml:936–941 @ 22ffe13`, run **`31075098067`**), on Observable clause 1. **My sealed cell MISSED at both branches** — `FINDING WO-0077-N1`, pre-declared before any transient was cut and scored against me. |
> | **M03-N4** | **QUALIFIED — 2 classes, 2 kills, ONE qualification; FIRST in the row's history** | IC-N4a at the delivered-sample cycle list (`:1302`, run **`31075099649`**), clauses 1 and 3; IC-N4b at the strobe count (`:1421`, run **`31075100851`**), clause 2. **`FINDING J-2` measured**: this row is confirmed from a run as the **sole** carrier for the suppressing design, and `WO-0076-VERDICT` §10's debt is **paid**. |
> | **M03-N2** | **QUALIFIED BY NOTHING HERE** | Four **delivered** sub-cases red under IC-N1 (`:603`, `:635`), **both zero-delivered members green**. Every red is blast radius and contributes zero kills. The green/red split is `FINDING WO-0077-N2`'s over-selection half, measured at this row. |
> | **M03-N3** | **NO-STIMULUS, UNMOVED** | Not a bench and never will be one. **No coverage is claimed for it anywhere**, and nothing in this campaign bears on it. |
>
> **THE N SECTION'S BLAST RADIUS, PER CLASS — and it is IC-N1's alone.** IC-N4a and
> IC-N4b each reddened **exactly one unit**, `M03-N4 (lane 0)`, and promoted only
> `test_m03_n.ml`; **neither produced any radius at all**, and `M03-J3`'s green
> under IC-N4b is the campaign's one **load-bearing** green (`FINDING J-2`, above).
> IC-N1 reddened **six** units at **four** sites: `M03-N1 (lane 0)` — its kill —
> plus `M03-N2`'s four delivered sub-cases and `M03-E4 (lane 0)`, the last of which
> was **not in the seal's instance list and IS inside the seal's rule**. **Six reds,
> one kill: five reds qualify nothing.** Kills are counted **per class**
> (`WO-0066` §11).
>
> **`FINDING WO-0077-N2` (MAJOR, mine, against my seal's IC-N1 rule and its
> worked-instance derivation) — the rule is wrong in BOTH directions at once, and
> the seal's own two-direction check is what caught it.** The seal derived the
> rule's instance set *"from the units' own stimulus titles at the base tree"*,
> asserted the class runs in two directions (adding a strobe at `M03-N1`, removing
> one at every selected family-B unit) and closed with *"a scorecard showing only
> additions or only removals is a finding against this rule, and it is the sort of
> finding the rule exists to make possible."* **The scorecard showed only
> additions.** **Half one — OVER-selection**: seven selected cells came back green
> (five family-B units, `M03-N2`'s two zero-delivered members), because the
> rendering does not disturb the `Idle → Preamble` transition and a zero-delivered
> frame has no delivered word for the consequence to land on. Recorded at
> `M03-N2`'s Kills cell. **Half two — UNDER-selection, and the omission is the unit
> that shares `M03-N1`'s own geometry**: `M03-E4 (lane 0)`, whose `?word_at`
> construction places an `/E/` in the same input word as its own frame's `/T/`.
> Recorded at `M03-E4`'s Stimulus cell with the arithmetic worked, and at
> `M03-N1`'s Kills cell as the narrowing it is. **Disposition: seal standing rule 5
> makes the RULE govern where rule and instance list disagree, so this resolves to
> *my instance list was wrong* and not to *the diff reached further than the class
> it names*. No scope finding, no out-of-specification cell, IC-N1's kill stands and
> `M03-N1`'s qualification stands.** **What it costs is a claim, and the claim is
> retracted: the breadth this class appeared to promise was smaller and differently
> shaped than the seal said.** **The portable form, and it is the half worth
> carrying off this bench**: *an instance list derived from what units are TITLED
> selects a different set from the rule that names a geometry, and the difference is
> invisible until a scorecard measures both.*
>
> **`FINDING WO-0077-N1` (MINOR, mine)** — recorded at `M03-N1`'s Kills cell:
> `D-N1c`'s dichotomy offered two branches and implicitly claimed the pair
> exhaustive; the design's third route reaches a report **and** `tuser`[0] while the
> coverage arithmetic never moves, so **neither** sealed cell was reached and the
> class killed at an arm the pre-run note had to fix in advance. **Pre-declared a
> MISS before any transient was cut, and scored against me.**
>
> **What this does and does not buy** — the refusals, stated because a
> three-of-three scorecard would otherwise be read as granting them.
>
> 1. **`M03-N3` is unmoved and unmoveable**, and **REQ-802 / §9.1's reset column is
>    still never observed at this bench** — no `SO-` may count it as covered by
>    either family J or family N.
> 2. **`M03-N4`'s zero-delivered branch has no legal stimulus and this round did not
>    reach it.** No `SO-`, campaign or verdict may read that row as coverage of a
>    zero-delivered REQ-110 abort.
> 3. **Every lane-4 member in §N is UNOBSERVED — never a miss and never a pass.**
>    `M03-N1 (lane 4)` and `M03-N4 (lane 4)` are structurally shadowed by their
>    lane-0 siblings, which raised first in all three N runs; R-DISC-1's per-lane
>    discharge was delivered and is on file, and **no lane-4 string appears in any
>    scorecard — which is itself the confirmation that every lane-0 member raised.**
> 4. **`M03-N2`'s six sub-cases remain PERMANENTLY UNSCOREABLE against §9's ruling
>    9** (`DECLARATION WO-0074-D1`, U-3 at §7) — untouched by this round in either
>    direction, and their reds here are a different class entirely.
> 5. **A kill proves the assertion convicts, never that the bench is a general
>    detector of the class.** IC-N1 was detected at **six** units in **two**
>    families — `M03-N1` and `M03-N2`'s four delivered sub-cases in §4.N,
>    `M03-E4 (lane 0)` in §4.E;
>    **this bench was not blind to it**, and no reading of this block may imply it
>    was.
> 6. **Nothing in `test/**` is owed by this result and nothing in `test/**` moves in
>    this round** — every unit behaved correctly, **including every one that
>    reddened where the seal said it would not, and every one that stayed green where
>    the seal said it would redden.**

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
>
> **BAR 3 — AND IT IS A BLINDNESS, NOT A GAP. `FINDING WO-0073-D2`, MATERIAL,
> against an instrument I own: THE DIFFERENTIAL CO-SIMULATION LANE IS
> CONTENT-COMPARING, NOT TIMING-COMPARING** (2026-08-09; measured
> `J-dv_lead-0134`, `WO-0073-VERDICT` §10; landed here `J-dv_lead-0135`). Under
> the family-L campaign's **IC-L2** — a uniform one-cycle word delay, ΔC 3 → 4
> on **every** output word and **every** strobe — the `cosim` job **passed**
> (`build` run **`31044675210`**, `cosim` job `92437186512`; control
> **`31039283863`** at `bbd4122` green at every step of both jobs). It passed
> because the lane compares **what** is delivered and not **when**. Beside it,
> REQ-019's whole error machinery was silent by construction and by measurement:
> `Latency.errors` stayed **empty**, because (L + h) = 32 closes at
> `word_delay = Some 4`, the ceiling test `4 > 4` is false, and §0.5's
> start-lane pair rule admits `(4, 4)`. **Two independent instruments, both
> blind to the same regression.** Consequences, stated so they are not
> negotiated later:
>
> - **No `SO-xgmii_rx_64.md` may cite the co-simulation anchor as timing
>   coverage of any stimulus class** — not the classes it has driven and not the
>   ones it has yet to.
> - **REQ-005/REQ-111's pinned per-octet constant (M03-L2, M03-L5) is the
>   programme's only detector of a uniform word-delay regression**, which makes
>   those two rows' latency constants load-bearing for the module's sign-off in
>   a way no other row's are. The reserve SPEC-M03 §7 leaves is not free: it buys
>   headroom and it costs detection, and the cost is now **measured** rather than
>   assumed.
> - **This is a third bar and it is not either of the two above.** Bar 1 is per
>   **row** (which rows take an expected value from X-1's computed outcome
>   model); bar 2 is per **requirement** (which requirements the lane may never
>   anchor at all); **this one is per quantity**, and it holds for every row and
>   every requirement at once.
>
> **RULED — option (a) ADOPTED: the lane gains an explicit cycle comparison**
> (`J-orchestrator-0215`, on the recommendation at `J-dv_lead-0134`
> Open-question 1; the priced alternative was to record the blindness as a
> written bound in `CD-xgmii_rx_64_cosim.md` and in every `SO-` that cites the
> anchor, which is cheap, honest and leaves the hole). The `WO-` is dv_lead's to
> draft in the **cosim-lane round** (`WO-0073-VERDICT` §12 item 3, which pays
> `WO-0073-D2`, `WO-0073-D5` and `test/cosim/dune`'s dangling
> `test/cost_probe/` reference together) — **not in this round**: a plan round is
> not where machinery lands (`J-dv_lead-0112`'s own rule). **Until that lane has
> run, the bar stands as written**, and a `SO-` that meets bars 1 and 2 does not
> thereby meet this one.
>
> **BAR 3 IS NOW DRAFTED AGAINST, AND THE DRAFT CORRECTS THE RULING'S WORDING —
> 2026-08-10, `WO-0075` (`J-dv_lead-0139`).** The `WO-` exists:
> `agents/handoffs/WO-0075_cosim-lane-cycle-comparison.md`. **What it does not do
> is compare our cycles against the reference's**, because REQ-901 says in terms
> that *"cycle alignment, internal pipelining and latency constants are
> deliberately not compared: ours are pinned by REQ-005 and REQ-111, the
> reference's are its own"* — so option (a) read literally would assert the one
> quantity the frozen requirement excludes by name, and the only way to make such
> an assertion green would be to take an expected value from the reference, which
> REQ-901's own closing sentence and ADR-0015 D2 both forbid. **The packet
> delivers the ruling's intent under the spec's constraint**: the lane **records**
> time on both sides, **asserts our side against SPEC-M03 §6.1's own `m + 3`
> gapless formula**, and **reports the reference's cycles as data, never
> adjudicated** — REQ-901's own disposition for the sub-5-octet frame, applied to
> time. IC-L2 reddens all eight words of the lane's frame under that assertion,
> so the blindness closes at the class that measured it, with no spec amendment.
> **A fourth consequence follows and it is stronger than a blindness: a cross-side
> timing comparison is not un-built, it is BARRED** — per quantity, like bar 3,
> and by specification, like bar 2. A later phase that wants one takes a REQ-901
> spec diff to architect_docs_lead; a comparator does not grant itself one.
> **Bar 3 is not lifted by the draft** and lifts only per stimulus class, on a
> green `cosim` job with both halves of `WO-0075` landed.
>
> **BAR 4 — THE SECOND BLINDNESS, AND ITS CAUSE IS NOT THE ONE I NAMED. THE LANE
> COMPARES NO STROBE OF EITHER SIDE — AND THE BINDING CONSTRAINT IS THE
> STIMULUS, NOT THE GRAMMAR** (2026-08-10; declared `WO-0074-VERDICT` §11 item 1,
> **priced and corrected here**, `J-dv_lead-0139`, `WO-0075` §9). The pinned
> canonical form is `{ tkeep; tlast; tuser0; octets }` plus an accept-or-discard
> decision per input frame: **there is no strobe field**, and the reference's
> `start_packet`, `error_bad_frame` and `error_bad_fcs` outputs are tied off in
> `test/cosim/tb_xgmii_rx_64.v`. The `cosim` job was `success` under all seven
> seeded family-M classes and **that green is evidence of nothing**.
>
> **What `WO-0074-VERDICT` §11 item 1 got wrong, corrected by this round's own
> measurement.** It said the anchor is blind to that campaign *"by grammar"*.
> The grammar is **a** cause and not **the** cause. Re-derived at this tree
> against the lane's actual stimulus — `test/cosim/stimulus_gen.ml`: **one**
> 64-octet good-FCS frame at a **lane-0** start, no second frame, no error
> character, no bad FCS, no runt, no oversize, no abort — **not one of the seven
> family-M classes is RENDERED at all**: IC-M1 needs a runt with a wrong FCS,
> IC-M2 an oversize frame, IC-M3 an error character, IC-M4 a second start
> character, IC-M6 and IC-M7 the `Discard` state, and IC-M10 differs only below
> five octets. **A strobe field added today would be an all-zero column on every
> line of every run.** The blindness is **stimulus-bound first, mapping-bound
> second, and grammar-bound only third**, and a fix applied at the third level
> buys nothing.
>
> **The price, measured over both campaigns rather than asserted.** Twelve seeded
> classes have now run with this lane in the loop (`WO-0073`'s five, `WO-0074`'s
> seven). **The comparison reported a divergence in zero of the twelve.** Two are
> rendered at the lane's stimulus at all: **IC-L5**, caught by `ours_run`'s own
> *"output word with no admitted frame open"* guard and **not** by REQ-901's
> comparison; and **IC-L2**, rendered on the wire and unrecordable — bar 3's
> class. **Four of the twelve (IC-L1, IC-L4, and by extension every future class
> whose condition needs two frames) are unreachable because the lane drives one
> frame**, which is a bound on everything this lane can ever be cited for and was
> never stated when `WO-0046` chose that stimulus.
>
> **The comparable strobe set is bounded above by ONE of M03's five, and the
> bound is in the frozen spec rather than in the harness.** `error_runt` is
> REQ-107, REQ-901's declared divergence class **(e)**; `error_oversize` is
> REQ-108, class **(f)**; for both, *"a co-simulation result is not an admissible
> external anchor … and a sign-off packet SHALL NOT offer one"* — **bar 2 already
> bars them, and bar 2 reaches their strobes too**. `error_start_without_terminate`
> has **no counterpart output** on the reference's published port list.
> `error_bad_frame` exists on both sides **and is a different signal**: the
> reference raises it on a bad FCS as well, where §9's table gives that event to
> `error_bad_fcs` alone — so a name-keyed comparison would **red a conformant
> M03**. **`error_bad_fcs` is the only candidate**, and it still needs a declared
> mapping and a stimulus that produces a bad FCS.
>
> **DECISION — the canonical form does NOT gain a strobe record, and this is a
> refusal rather than a deferral** (`WO-0075` §9, which carries the full pricing).
> An all-zero column would make the lane *look* strobe-aware to every future
> reader while asserting nothing — turning §11 item 1's *"that green is evidence
> of nothing"* from **true** into **invisible**, which is this section's own
> catalogued failure mode at its fifth instance. **Three ordered preconditions,
> so the refusal is checkable rather than open-ended: (1) stimulus** — the lane
> drives a frame whose condition makes a comparable strobe pulse on both sides,
> which today it does not; **(2) mapping** — a committed correspondence with every
> non-corresponding strobe listed **and its reason**; **(3) grammar** — only then a
> field, carrying the mapped strobes and recording the unmapped ones as *not
> compared* rather than silently absent.
>
> **The bar, in the form a sign-off packet is checked against: NO
> `SO-xgmii_rx_64.md` MAY CITE THE CO-SIMULATION ANCHOR AS STROBE COVERAGE OF ANY
> STIMULUS CLASS, AND THE REASON IT MUST GIVE IS THE STIMULUS, NOT THE GRAMMAR.**
> It composes with the other three rather than colliding: bar 1 is per **row**,
> bar 2 per **requirement**, bar 3 per **quantity** (time), and this one per
> **quantity** (strobes) — and unlike bar 3 it is **not** discharged by the
> `WO-0075` lane, which changes nothing about strobes by construction (`WO-0075`
> §8 item 5 forbids it). **`DECLARATION WO-0074-D1` at U-3 below is a different
> statement and is not this one**: U-3 says a design-side report grammar has no
> member for one defect to displace; this bar says the *anchor's* stimulus never
> creates the event in the first place.
>
> **BAR 4's THREE OWED `RV-0075` PLACEMENTS, LANDED HERE — 2026-08-11
> (`J-dv_lead-0148`, from `RV-0075-VERDICT` at `981331f`, adjudicated
> `J-dv_lead-0144`).** `RV-0075-VERDICT` §2 ruled that two of its findings are
> *"recorded in `AP-M03` §7 beside bar 4 by the next `AP-` round, not by this
> verdict"*, and `WO-0077` §15 item 1 carried all three unpaid by design, inside a
> campaign freeze. **This is that round; none of the three is a bar and none of the
> three lifts one.**
>
> 1. **`FINDING RV-0075-1` (MINOR, dv_lead's, against its own `WO-0075` §5.1 and the
>    landed printer) — an evidence-hygiene defect in the lane whose whole purpose is
>    to produce a number a sign-off packet can cite.** §5.1 requires
>    `timing_report_to_string` to print T1's expected-versus-observed table; **on the
>    clean path it prints a sentence, not a table**, so a green run carries **no
>    printed record of the eight cycles T1 asserted** — they are recoverable only by
>    subtracting T2's offset line from T2's reference profile, that is, **our side's
>    asserted numbers are legible today only through the tier that may NEVER be
>    adjudicated** (T2, §3.3, recorded and never a verdict). **Not a correctness
>    defect: the assertion ran and its verdict is sound.** **The repair, and it is
>    about ten lines with no logic change**: on `base_aligned = true` and
>    `spec_divergences = []`, print the per-word expected/observed pairs for every
>    accepted frame, so the T1 claim stands on its own line. **Carrier: the next
>    commit that opens `test/cosim/**`** — not this plan, which is where the
>    obligation is recorded and not where it is paid (`J-dv_lead-0112`). **Until it
>    is paid, an `SO-` citing T1's cycles quotes them from the run's own log and says
>    so.**
> 2. **`FINDING RV-0075-2` (MINOR today, MATERIAL the moment `WO-0075` §8 item 1 is
>    lifted) — the guard is a proxy and it is blind in exactly one direction.**
>    `WO-0075` §3.2 asked for a guard on the **stimulus** carrying an injected idle
>    inside a frame; `check_timing` sees only the two canonical files, cannot read
>    the stimulus, and guards on **our own output-word spacing** instead. Those are
>    not the same predicate and the difference is asymmetric: an idle injected
>    **after** the first output word breaks the constant spacing and the guard fires
>    correctly; an idle injected **at or before D(0)** delays **every** output word
>    by one — SPEC-M03 §6.1, *"word m is emitted as many cycles later as there are
>    idles injected at or before D(m)"* — and **a uniform shift preserves every
>    inter-word delta, so the guard is blind to it and T1 falls through on every
>    word, indistinguishable from the family-L campaign's `IC-L2` from the canonical
>    files alone.** **The implementation could not have done better from the files it
>    is given** and no repair is owed to the worker; what is owed is the statement,
>    because the consequence is a latent **false positive**: *the first work order
>    that gives this lane an idle-injecting stimulus (REQ-016's wrapper, which
>    SPEC-M03 §10 commissions at 0, 1 and 7 cycles) makes a CONFORMANT M03 red,
>    reading as a `BUG-` candidate against REQ-005/REQ-111 when the cause is the
>    stimulus.* **Bounded, not open-ended** — SPEC-M03 §6.1 forbids injection between
>    a frame's start character and its first octet (the **M03-N3** constraint, X-4's
>    own deliverable), so the blind window is narrower than it first looks and is
>    **not empty**. **Repair: T1's antecedent must be CARRIED, not inferred** — the
>    injected-idle count must reach the comparator from the stimulus, because it is
>    **not recoverable from the two canonical files**. **Carrier: the same work order
>    that lifts `WO-0075` §8 item 1 — the Phase-2/3 stimulus-widening order — and no
>    earlier one, by ruling.** **Note the shared root with bar 4**: with no idle
>    record and no strobe record in the grammar, an antecedent the specification
>    states in terms is unrecoverable at the comparator, and **bar 4's three ordered
>    preconditions (stimulus → mapping → grammar) apply unchanged to an idle
>    record.**
> 3. **BAR 4 RECONFIRMED AT THE ANCHOR'S FIRST REAL TIMING EXECUTION, AND THE
>    RECONFIRMATION IS NARROWER THAN IT SOUNDS.** `WO-0075`'s lane ran: T0 aligned,
>    our eight output words asserted against SPEC-M03 §6.1's own gapless
>    `admit_cycle + m + 3` on cycles **3 … 10**, both canonical files byte-identical
>    across two runs, and a seeded uniform shift reported through the production
>    path. **The lane learned to see time and it did NOT learn to see strobes**: it
>    still compares **no strobe of either side**, bar 4's preconditions are unmet at
>    the **first** of the three, and **the round changed the count from
>    two-rendered-one-visible to two-rendered-two-visible without changing the two.**
>    **Bar 4 is therefore unchanged in force and in wording, and bar 3 is not lifted
>    by the draft that answers it** — bar 3 lifts per stimulus class, on a green
>    `cosim` job with both `WO-0075` halves landed.
>
> **AND BAR 4's THIRD CAMPAIGN INSTANCE CAME BACK FALSE — `FINDING WO-0077-A1`
> (MAJOR, mine, against my own seal's §6.1, `WO-0077` §5 item 4, and the census at
> seal §0.2 / packet §4.2 that grounds both), 2026-08-11** (`WO-0077-VERDICT` §9.1
> at `d6fdf92`, adjudicated `J-dv_lead-0147`; the campaign's own largest finding,
> and it is against my artefact rather than against the manifest). **The
> per-campaign blindness declarations recorded beside this bar now number four —
> family M, family J, family K, and the family-K/N round's own — and the fourth is
> the first that did not hold.** My seal declared before the run that *"not one of
> the nine classes in either section is rendered at that stimulus, so the `cosim`
> job is predicted `success` under all nine and that green is worth nothing"*.
> **Under `IC-K3` (`cosim` job `92531261066`) and `IC-K5` (job `92531267799`) the
> job's comparison step FAILED, with the same divergence on both branches —
> `DEFECT: frame 0: decision mismatch (ours=discard, theirs=accept)`, our side
> carrying no output word at all against a reference that accepts and delivers eight
> words on cycles 3 … 10.** The seven other classes came back `success`, as sealed.
>
> **The ground is one measurement, and it is one measurement wide.** The census
> behind both classes' invisibility arguments — *"the earliest start character
> anywhere in this bench is at cycle 1"*, *"no unit presents a start character on
> cycle 0"* — **is true of `test/xgmii_rx_64/`, whose schedules come from
> `Bench.frames_at` and three direct `Arrival.create` call sites, and it was relied
> on as if it were true of every producer that drives the DUT.**
> **`test/cosim/ours_run.ml` is a SECOND producer, outside that census**: it drives
> one `clear` cycle and releases (`test/cosim/ours_run.ml:158–162 @ 22ffe13`), then
> begins its stimulus trace at index 0 — **so the co-simulation lane presents its
> start character on cycle 0, the one placement the whole argument assumed did not
> exist.** The reference's own first output word at cycle 3, against SPEC-M03 §6.1's
> `admit_cycle + m + 3`, puts the admit cycle at **0** and confirms it from the run.
> **The manifest is not at fault and the disclosures are why that can be said**:
> both classes' discharges cite my census **by name** and answer the question that
> was asked; the question was scoped to a bench and the DUT has two producers.
>
> **Disposition, and it is pre-classified rather than chosen after the fact.** The
> seal's own disposition 8 named this event — *"a red in `test/cosim/` → a finding
> against §6.1's derivation, and a very interesting one"* — separately from its
> scope-finding and build-finding branches, and it governs. **`test/cosim/`
> contributes ZERO units, so the rules whose quantifier ranges over units are not
> falsified: both kills stand and both `M03-K2` qualifications stand.** The
> scope-violation disposition is **not** applied, and the reason is stated rather
> than assumed: it would move a defect in my own census onto a manifest that
> disclosed the deviation, cited my measurement as its ground, and was told by me
> that the ground held.
>
> **THE REPAIR, AND IT IS A STANDING RULE RATHER THAN A CORRECTED NUMBER:
> ANY UNIVERSAL QUANTIFIED OVER "THE BENCH" IN A SEAL, A CAMPAIGN PACKET OR AN
> `SO-` IS MEASURED OVER EVERY PRODUCER THAT DRIVES THE DUT — `test/cosim/`
> INCLUDED — OR IT IS QUOTED WITH THE PRODUCER SET IT WAS MEASURED OVER.** This is
> §0.1's rule meeting its second dimension: §0.1 makes a set claim carry its SHA,
> and this makes it carry its **domain**. **Owed to the next campaign seal and, if
> none is drafted, to the `SO-` round's own accounting.**
>
> **AND THE FINDING HAS A POSITIVE HALF THAT IS WORTH MORE THAN ITS NEGATIVE ONE.**
> **This is the FIRST TIME IN THIS PROGRAMME THAT THE DIFFERENTIAL CO-SIMULATION
> ANCHOR HAS CONVICTED A MUTANT.** Across the family-L, family-M and family-J
> campaigns the bar recorded three instances of the anchor being blind by stimulus,
> and this campaign added a fourth in advance. **The lane is not blind: it is blind
> to seven of nine, and SIGHTED for exactly the two whose defect lands on a start
> character sitting on a reset-release cycle** — a placement the M03 bench does not
> contain at all. **That is the first positive statement about this anchor's
> coverage the programme has been able to make from a run, and it belongs in the
> `SO-`'s accounting of the charter §3 anchor BESIDE the bar that says the anchor is
> undischarged, never in place of it.** **It does not discharge the anchor**:
> REQ-901's class list still contains no mid-frame `clear`, one 64-octet good-FCS
> frame is still the whole stimulus, and a green there still means nothing.
>
> ---
>
> **`FINDING RV-0078-S2-13`'s RULE, FILED HERE BESIDE `WO-0077-A1`'s CENSUS RULE
> BECAUSE IT IS THE SAME RULE MEETING ITS THIRD DIMENSION — 2026-08-10**
> (`WO-0078` §14, `RV-C4GAP` §6 at `eef3fd0`, minted by me against my own C4
> dispatch; carrier (ii) of three, discharged here; `J-dv_lead-0159`). §0.1 makes a
> set claim carry its **SHA**; `WO-0077-A1` makes it carry its **domain** — every
> producer that drives the DUT, `test/cosim/` included. **This one makes it carry its
> POLARITY**, which is the dimension both of the others left open, and it binds
> workers and reviewers alike because the finding that minted it convicted one of
> each: my own readiness census cleared C4 over ten **consumption** layers and never
> asked whether the stimulus could be **emitted**, and the worker's *"no lawful hook
> exists"* was a **negative** universal measured over four modules when the
> construction it denied was landed, reviewed and mutation-scored one directory over,
> in `test/xgmii_rx_64/test_m03_b.ml` at **`M03-B1`**.
>
> > **A capability claim states the set it was measured over, and its polarity does
> > not change that obligation. A claim that a mechanism does not exist is measured
> > over every landed construction of the thing in question — not only over the
> > modules that would naturally host one. Before a case is authorised, the producer
> > that must emit its stimulus is checked for the capability to express it, and that
> > check is a read of the producer's construction surface together with every
> > existing construction of the same stimulus, never an inference from the
> > specification that commissioned it.**
>
> **What it costs to ignore, priced from the round that taught it**: one worker seat
> spent discovering a construction the programme already owned. **What it pays before
> it is next run** — `RV-C4GAP` §6 carrier (iii), also landed as Stage 3's gate
> condition **(d)** third axis: `test/xgmii/arrival.ml:157-162` refuses any frame
> below five octets, so a co-sim case at that length **cannot** be built by the
> `Arrival.create` + `check_conformant` idiom every landed case uses. **Found by one
> read; discovering it costs one round.** *Portable form, banked for the harvest
> (LH2-g candidate, no proper noun): a readiness census over the layers that consume
> an input is not a readiness census; a case is not constructible because it is
> specifiable, and "no mechanism exists" is a measurement over a stated set or it is a
> guess.*
>
> ---
>
> **BAR 1's FOUR LIFT CELLS — CO-SIM STAGE 2, ONE CELL PER STIMULUS CLASS, AT RUN AND
> JOB IDS, WITH WHAT EACH DOES NOT ANCHOR IN THE SAME CELL — 2026-08-10**
> (`WO-0078` §14, `RV-C4` §12 items 1 and 6 at `e51ca52`, which ruled this round's
> scope and **pre-authorised** it: no new evidence, run, case or verdict is required
> for what follows, and none was produced. `J-dv_lead-0159`.)
>
> **What a lift IS.** Bar 1's live condition is *"no `SO-xgmii_rx_64.md` PASS may rest
> on a computed outcome of X-1(ii) for a stimulus class the differential
> co-simulation has not driven."* It lifts **per stimulus class**, and only when a
> case has **run and agreed** — a class driven and diverging would select branch γ and
> lift nothing (`RV-C4GAP` §5 item 3). Four classes have now run and agreed at branch
> **α**, so for those four the condition is discharged **at the class**.
>
> **What a lift is NOT, and each of these is a sentence no cell below writes.** It is
> not a requirement discharged — *a class is anchored; a requirement is not*. It is
> not a row discharged: no row's status, no coverage-map line and no discharge count
> moves on a lift. It is not the **absolute** delivered values, which are the bench
> family's (`FINDING RV-0078-S2-2`). It is not a **strobe** (bar 4) and not a
> **cycle** (bar 3). And **no cell is written in module form**: no sentence of the
> form *"the co-simulation anchors this module"* appears here or may be lifted from
> here (`WO-0078` §8).
>
> **The form every cell takes, and why.** Each names **which instrument discharges the
> ABSOLUTE half** — a bench row asserting figures at the receiver — and **which
> discharges the AGREEMENT half** — this lane, which asserts that two independent
> implementations produced the same four REQ-901 observables and asserts no figure of
> its own. **α never stands for both.** This is `FINDING RV-0078-S2-2`'s shape written
> into the cells so the `SO-` can lift them without repair; **it does not re-home
> `S2-2`**, whose carrier is still the `SO-` round.
>
> **Case number and class number are OFF BY ONE and the cells say so, because the
> confusion is available**: case 0 drove class 1, C1 class 2, C2 class 3, C3 class 4,
> C4 class 5.
>
> **Class 1 — one 64-octet good-FCS frame, lane-0 start on the reset-release cycle,
> gapless, no injected idle — WAS LIFTED AT PHASE 1 AND IS NOT RE-LIFTED HERE.**
> Anchored at `build` run **`30988038809`**, `cosim` job **`92247281222`**, branch α;
> **re-observed** at `31431123022` / `93594520735`. A re-observation is not a lift and
> does not renew one. Absolute half: **`M03-A1`** (the eight words' `tdata`/`tkeep`/
> `tlast`/`tuser` tuples and ΔC = 3 at a lane-0 start). Agreement half: this lane at
> case 0. The condition's restatement that made this per-class reading possible is at
> the head of this banner (`J-dv_lead-0132`).
>
> **LIFT CELL — CLASS 2. One 64-octet good-FCS frame, LANE-4 start on the
> reset-release cycle.** Anchored at `build` run **`31096150983`**, `cosim` job
> **`92598555141`** (`RV-C1C2`, `J-dv_lead-0152`); re-observed at runs
> **`31100435961`**, **`31103977231`**, **`31108528759`** and **`31431123022`**
> (job `93594520735`) — **five observations**, byte-identical. **Branch α**, selected
> from CD §10.1's frozen terms.
> **Absolute half: `M03-A2`** — the same 64 octets at a lane-4 start, the eight words'
> tuples asserted figure for figure, the FCS verdict good, the C-18 defect made
> executable — with **`M03-A3`** and **`M03-A5`** beside it for lane-equality and byte
> order. **Agreement half: this lane at C1**, which asserted no delivered value of its
> own. **`WO-0046`-adjudication §5 item 2 is closed by it**: lane 4 has been driven at
> this boundary.
> **What class 2 does NOT anchor, in this cell so it is never lifted alone:** not
> **two clean frames at the minimum inter-frame gap** (`RV-C1C2` §11 item 1 says
> *"specifically not"*); not a lane-4 start at a **non-zero** admit cycle, which no
> case drives as a separable class; not the **absolute** delivered values, which are
> `M03-A2`'s; not any **strobe** (bar 4) and not any **cross-side cycle** (bar 3);
> not **REQ-101 or REQ-021 as requirements**; and not the T2 offset of `[1 × 8]`
> recorded beside it, which is **CD §5.2 X1 — data, never adjudicated**.
>
> **LIFT CELL — CLASS 3. TWO 64-octet good-FCS frames at the MINIMUM inter-frame gap,
> frame 0 lane-0 on the reset-release cycle, both accepted, across the re-arm path.**
> Anchored at `build` run **`31103977231`**, `cosim` job **`92624287637`**
> (`RV-C2ALPHA`, `J-dv_lead-0155`); re-observed byte-identical at **`31108528759`**
> and **`31431123022`** (job `93594520735`). **Branch α**, under CD §10.2
> **unamended**. **This class cost three landings and two voids** — the first two
> reached no comparison at all (`FINDING RV-0078-S2-1`, then `S2-6`), and a case that
> reaches no comparison **selects no branch**; the α here is the third landing's and
> nothing is banked from the first two.
> **Absolute half: `M03-L1`** — §8's stress run, 10 000 consecutive 64-octet frames at
> the minimum 12-octet gap with every frame's 60 delivered octets asserted against the
> injected octets, conservation held and no strobe anywhere — with **`M03-D3`** beside
> it for inter-frame **attribution** at the same minimum gap. **Both differ from this
> class in a stated way**: `M03-L1` alternates start lanes and runs four orders of
> magnitude more frames; `M03-D3`'s pairs each carry a **bad-FCS** member by
> construction, so neither is two good frames driven exactly twice. **Agreement half:
> this lane at C2.**
> **What class 3 does NOT anchor:** not *"a lane-4 start at a non-zero admit cycle"*
> as a separable class — frame 1 lands there by §0.3's gap arithmetic, and **per-case
> reporting attributes a result TO a case, never WITHIN one**, so a green cannot be
> attributed inside a case any better than a red can (`RV-C2ALPHA` §5); not **more
> than two frames** and not **REQ-004's line-rate cadence**, which is `M03-L1`'s and
> not this lane's; not the **absolute** delivered values; not any **strobe** and not
> any **cross-side cycle**; not **REQ-004, REQ-005, REQ-019, REQ-020 or REQ-112 as
> requirements**.
>
> **LIFT CELL — CLASS 4. One 64-octet BAD-FCS frame — one payload bit flipped at index
> 20 against an untouched, correct-for-original-content FCS — lane-0 start on the
> reset-release cycle, DELIVERED RATHER THAN DROPPED.** Anchored at `build` run
> **`31108528759`**, `cosim` job **`92639903296`** (`RV-C3ALPHA`, `J-dv_lead-0156`);
> re-observed at **`31431123022`** (job `93594520735`). **Branch α**, under CD §10.3
> **unamended**. **`WO-0078` §7's C3 prediction is FALSIFIED and SPENT**: the
> reference did **not** drop the frame.
> **Absolute half: `M03-D1`** — the same 60 octets delivered, `tuser`[0] = 1 on the
> `tlast` word, exactly one `error_bad_fcs` on the `tlast` cycle and no other strobe —
> **mutation-qualified**, with **`M03-D2`** as its anti-vacuity partner. **Agreement
> half: this lane at C3.** **REQ-104's measured fact is the PAIR** — this lane's
> `tuser`[0] agreement together with `M03-D1`'s absolute assertion — **and it is
> written as a pair or not at all.**
> **What class 4 does NOT anchor:** not the mark's **VALUE** (`FINDING RV-0078-S2-11`
> — a value this lane does not print is not a value this lane measured); not the
> **strobe** — bar 4 stands, and see its precondition record below; not bad FCS at a
> **lane-4** start, since no case crosses the two axes; not bad FCS at **any other
> length** — 64 octets exactly, and REQ-901 class (e) does not reach it; not
> **REQ-104 as a requirement**.
>
> **LIFT CELL — CLASS 5. One 64-octet good-FCS frame whose SIX preamble filler octets
> AND the SFD octet carry nonstandard DATA values (`A1 A2 A3 A4 A5 A6 A7`), lane-0
> start on the reset-release cycle, ACCEPTED RATHER THAN REJECTED.** Anchored at
> `build` run **`31431123022`**, `cosim` job **`93594520735`** (`RV-C4`,
> `J-dv_lead-0158`) — **one observation, and the cell says so.** **Branch α**, under
> CD §10.4 **unamended**. **`WO-0078` §7's C4 prediction is FALSIFIED and SPENT**: the
> reference does **not** validate the six filler octets or the SFD octet, so it did not
> reject the frame. The decision half rests on `canonical.mli`'s own
> words-empty-iff-`Discard` invariant read off a **printed** line (eight output words
> on the reference's side), not on a second instrument.
> **Absolute half: `M03-B1`** — this plan's own REQ-102 row, which drives the
> identical nonstandard pattern at **both** start lanes and asserts the delivered
> octets, `tkeep`, `tuser`[0] = 0 and the empty strobe set at the receiver.
> **Agreement half: this lane at C4.** **The two constructions are independent**:
> `M03-B1` substitutes into the schedule's start word through `Bench.run`'s `?word_at`
> hook (`test/xgmii_rx_64/test_m03_b.ml`, `nonstandard_preamble_octet lane = 0xA0 +
> lane`), and C4 emits `0xA0 lor d` for d = 1…7 from `test/cosim/stimulus_gen.ml`
> through the second producer's own lane arithmetic — **the same pattern, built twice,
> by two producers, for two instruments.**
> **What class 5 does NOT anchor, quoted from the verdict that measured it:** not the
> **lane-4** nonstandard-preamble geometry, where the preamble straddles two words;
> not a **control** character in a preamble position — REQ-102's second and third
> commissioned stimuli, which are **`M03-B2`** and **`M03-B3`** and belong to the
> bench family; not **`M03-B1`'s verdict**, only its stimulus pattern; not the
> **absolute** delivered values, which are `S2-2`'s subject and rest on the bench
> family; not **REQ-102 as a requirement**.
> **THE `M03-B1` ↔ CLASS 5 CROSS-REFERENCE, DIRECTION ONE OF TWO** (direction two is
> at `M03-B1`'s own cell in §4.B, added in the same commit). **It is bounded by
> `RV-C4GAP` §5's four prohibitions, quoted into this cell so the link can never be
> read as `M03-B1` being co-sim-anchored:**
> > **1. It does not co-sim-anchor `M03-B1`.** B1 is a family-B bench row with its own
> > assertions and its own mutation qualification; C4 is a two-implementation
> > comparison on a shared stimulus pattern. **Sharing a stimulus is not sharing a
> > verdict.**
> > **2. It does not reach the lane-4 half.** `M03-B1` drives **both** start lanes; C4
> > drives one. The lane-4 nonstandard-preamble geometry — where the preamble straddles
> > two words — is **not** in C4's set and no packet may imply it is.
> > **3. It lifts no bar** by itself: bar 1 lifts at the `AP-` round, per class, when a
> > case has run and agreed — never at a run and never in a verdict.
> > **4. It does not open the `SO-`.**
> **And the two axes on which the two instruments differ, stated so the pair is
> legible without re-derivation**: `M03-B1` drives **both start lanes** and asserts
> **absolute figures at the receiver**; C4 drives **lane 0** and asserts **agreement**
> between two implementations. Neither instrument is the other's evidence.
>
> **WHAT THE FOUR LIFTS CHANGE TODAY, MEASURED RATHER THAN ASSUMED — AND THE ANSWER IS
> "NOTHING RETROSPECTIVE".** Bar 1 gates a row **iff** its expected values are taken
> from X-1(ii)'s computed outcome model, and the re-measurement recorded below finds
> **no such row at this tree**. So the four lifts discharge a condition that **gates no
> row today**; what they buy is **prospective** — a future row taking an expected value
> from X-1(ii) at one of these five classes is ungated where before it was gated — and
> **formal**: the `SO-` may write the per-class table without a bar standing over it.
> **A lift that changes no row's status is still a lift, and saying so is what stops it
> being read as more.**
>
> ---
>
> **BAR 4's PRECONDITION RECORD — PRECONDITION (1) IS MET FOR `error_bad_fcs` AND FOR
> NOTHING ELSE; (2) AND (3) ARE UNMET; THE BAR STANDS. THIS IS MOVEMENT INSIDE A
> STANDING REFUSAL AND IT IS NOT A LIFT — 2026-08-10** (`RV-C4` §12 item 2;
> `J-dv_lead-0159`). Bar 4's refusal was made checkable by three **ordered**
> preconditions, and exactly one of them moved:
>
> - **(1) STIMULUS — MET, for `error_bad_fcs`, at C3, and for no other strobe.** The
>   lane now drives a frame whose condition creates that event on our side: one
>   64-octet frame with a payload bit flipped after its FCS was computed (class 4
>   above). When bar 4 was written, *not one* of the seven family-M classes was
>   rendered at this lane's stimulus at all. **`error_runt` and `error_oversize` are
>   still unreachable by specification** — REQ-107 and REQ-108 are REQ-901's declared
>   divergence classes (e) and (f), which **bar 2 reaches, strobes included** —
>   **`error_start_without_terminate` still has no counterpart output** on the
>   reference's published port list, and **`error_bad_frame` still exists on both sides
>   and is still a different signal.**
> - **(2) MAPPING — UNMET, and C3 made it *harder*, not easier.** A committed
>   correspondence with every non-corresponding strobe listed and its reason does not
>   exist. What C3 added is the knowledge that the mapping cannot be the identity: the
>   reference raises `error_bad_frame` on a bad FCS, where §9's table gives that event
>   to `error_bad_fcs` **alone**, so a **name-keyed** comparison would red a conformant
>   M03.
> - **(3) GRAMMAR — UNMET.** The pinned canonical form is `{ tkeep; tlast; tuser0;
>   octets }` plus an accept-or-discard decision per input frame; there is **no strobe
>   field**, and the reference's `start_packet`, `error_bad_frame` and `error_bad_fcs`
>   outputs are tied off in `test/cosim/tb_xgmii_rx_64.v`. **No strobe of either side
>   was compared at any of the five landed classes**, and none could have been.
>
> **The bar, restated in the form a sign-off packet is checked against, with its REASON
> now split by strobe — which is the whole of what this record changes:** **NO
> `SO-xgmii_rx_64.md` MAY CITE THE CO-SIMULATION ANCHOR AS STROBE COVERAGE OF ANY
> STIMULUS CLASS.** For **`error_bad_fcs`** the reason it must give is the **MAPPING
> and the GRAMMAR**, no longer the stimulus. For **every other strobe** the reason is
> still the **STIMULUS**, exactly as the bar was written. **The refusal of an all-zero
> strobe column is unchanged and is still a refusal rather than a deferral**: a column
> that makes the lane look strobe-aware while asserting nothing turns *"that green is
> evidence of nothing"* from **true** into **invisible**.
>
> ---
>
> **BARS 2 AND 3, RESTATED AS UNMOVED BY CO-SIM STAGE 2 — 2026-08-10** (`RV-C4` §12
> item 3; `J-dv_lead-0159`). Both are restated here because a round that lifts four
> cells beside them is exactly where a reader starts assuming the neighbours moved.
>
> - **BAR 2 IS PERMANENT BY SPECIFICATION, AND THAT IS ITS STATEMENT — NOT "IT HAS NOT
>   MOVED YET".** For **REQ-107** and **REQ-108**, REQ-901's declared divergence
>   classes **(e)** and **(f)**, *a co-simulation result is not an admissible external
>   anchor at all, and a sign-off packet SHALL NOT offer one.* **No stage of any phase
>   can alter this**, five landed classes included and any future class included: it is
>   a property of the frozen requirement, not of how much stimulus the lane has driven.
>   Families **F** and **G** are therefore not *waiting* on this lane, and their
>   directed rows are the whole of their verification.
> - **BAR 3 IS UNMOVED, AND THE REASON IS STRONGER THAN "NOT YET RUN".** `WO-0075`'s
>   lane has landed and has run green at all five classes, which is exactly where a
>   reader would misread a lift. What that lane does is **record** time on both sides,
>   **assert OUR side against SPEC-M03 §6.1's own `admit_cycle + m + 3` formula** (tier
>   T1), and **report the reference's cycles as data, never adjudicated** (tier T2).
>   **An assertion against our own specification is not an anchor**, and a tier that may
>   never be adjudicated is not coverage: **no cross-side cycle has been adjudicated at
>   any of the five classes, and none ever may be** — REQ-901 excludes cycle alignment,
>   internal pipelining and latency constants **by name**, so a cross-side timing
>   comparison is **BARRED, not un-built**. **No `SO-xgmii_rx_64.md` may cite the
>   co-simulation anchor as timing coverage of any stimulus class**, the five driven
>   ones included. **`M03-L2` and `M03-L5`'s pinned per-octet constants remain the
>   programme's only detector of a uniform word-delay regression**, measured under
>   `IC-L2` and unchanged by anything Stage 2 ran.
>
> ---
>
> **THE §0.1 RE-MEASUREMENT THIS ROUND OWED, AND ITS RESULT — THE SET CLAIM SURVIVES,
> AT `e51ca52`, MEASURED OVER BOTH PRODUCERS — 2026-08-10** (`J-dv_lead-0159`;
> obliged by §0.1 as cited at `RV-C4` §13 item 4, which made the `SO-`'s dependence on
> co-sim Stage 3 turn on this measurement rather than on a recollection).
>
> **The claim, quoted from bar 1 above and restated at X-1's own Note cell in the table
> below — both sites, one measurement**: *"**No row benched to date is gated by this
> bar**"*, i.e. **no row benched to date takes an expected value from X-1(ii)'s
> computed outcome model.** Its stated ground enumerated families **A–F** only, and
> seven more families have landed since it was written, so it was quoted at citation
> exactly once too often to be quoted again.
>
> **How it was measured — static reads at this tree, no build, no test, no simulation,
> no CI run**, over **both producers that drive this DUT** (`WO-0077-A1`'s domain
> rule), each command reproducible from a checkout at `e51ca52`:
>
> | | measurement | command | result |
> |---|---|---|---|
> | **(a)** | the model's **oracle join** to X-3 — the one API by which a computed pin becomes a DUT expectation | `grep -rn "expected_strobes" --include=*.ml --include=*.mli test` | **ZERO call sites outside `test/xgmii/`.** Its only caller anywhere is `test/xgmii/test_injection.ml:320`, the model's own unit test |
> | **(b)** | every executable call of `Injection.outcomes` outside its own library | `grep -rn "Injection\.outcomes" test --include=*.ml \| grep -v "^test/xgmii/"` | **17 call sites in 6 files** — `test_m03_b.ml` (5), `test_m03_e.ml` (3), `test_m03_f.ml` (1), `test_m03_g.ml` (2), `test_m03_h.ml` (4), `test_m03_n.ml` (2) |
> | **(c)** | whether any outcome value can **escape** into an expectation | `grep -rEn "let +[a-z_']+ *= *[a-z0-9_']+\.Dv_xgmii\.Injection\." test/xgmii_rx_64 --include=*.ml` | **ZERO.** No outcome field is ever bound to a name; every read is consumed in place by a comparison against an in-file hand-derived local, whose failure branch is `fail_cross` (*"Injection model cross-check disagrees on …; do not silently adopt either derivation"*) or a `fail` naming a test bug — a **construction** failure, never a DUT verdict |
> | **(d)** | family **I**, which uses X-1 but appears in neither (b) nor (c) | `grep -n "Injection\.[a-z_]*" test/xgmii_rx_64/test_m03_i.ml` | **X-1(i) only** — `corrupt`, `create`, `is_clean`, `errors`, `schedule`, `word_at`. The **placement machinery**, which bar 1 does not gate |
> | **(e)** | the **second producer** — `WO-0077-A1`'s own dimension, the one whose omission cost a MAJOR finding | `grep -rn "Injection" test/cosim` | **ONE line, and it is a docstring saying the model is absent**: `test/cosim/stimulus_gen.ml:309`, *"No [Injection] or [Idle_injection] anywhere in this builder's call…"*. The co-sim lane builds from `Frame` and `Arrival` directly |
>
> **RESULT: THE CLAIM SURVIVES RE-MEASUREMENT. No row benched to date is gated by
> bar 1**, at `e51ca52`, over **both** producers. **Its stated GROUND was stale and is
> repaired here rather than at the sentence**: the reason is not *"A, B and C predate
> X-1 and E and F were commissioned hand-derived"* but the structural fact measured at
> (a) and (c) — **the model's oracle join is called by nothing, and no bench binds an
> outcome field to a name**, so families **G**, **H** and **N**, which call
> `Injection.outcomes` and did not exist when the sentence was written, are inside the
> claim for the same reason E and F are. **A conclusion that survives on a ground its
> author did not have is exactly the case §0.1 exists to catch before an `SO-` rests on
> it.**
>
> **THE CONSEQUENCE, AND IT IS THE ONE `RV-C4` §13 ITEM 4 ROUTED HERE: THE
> `SO-xgmii_rx_64.md` IS NOT BLOCKED ON CO-SIM STAGE 3.** Bar 1 gates a row iff its
> expected values come from X-1(ii); no benched row does; therefore **no row of this
> plan is waiting on a class Stage 3 would drive**, and **Stage 3 is not on the `SO-`'s
> critical path.** **Four things this does NOT say.** It does not say Stage 3 is
> worthless — it says the `SO-` does not wait for it. It does not lift bars 2, 3 or 4,
> which are per requirement and per quantity and are untouched by any measurement of
> rows. It does not discharge the charter §3 anchor, which stays undischarged with
> REQ-901's class list unchanged. And it does not survive its own future: **the moment
> a row takes an expected value from X-1(ii) — which a fuzz campaign would do on its
> first day — this measurement is stale and the claim is re-measured before it is
> quoted again.**

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

**TWO INSTRUMENTS THIS PLAN HAS AND CANNOT REACH — recorded beside the X-rows
because they are the same kind of statement, and deliberately NOT minted as
X-rows** (2026-08-09, `J-dv_lead-0135`, from `WO-0073` §4 items 1–2 and its seal
§6.1–§6.2, both **declared before the family-L campaign ran**, and confirmed by
measurement at `WO-0073-VERDICT` §8). An X-row says *a row cannot be asserted
until machinery exists*. These two say something narrower and worse: **the
assertion exists, it is landed, it is green, and no mutation can make it speak.**

| # | The unreachable instrument | Why it cannot speak | What the plan may say |
|---|---|---|---|
| **U-1** | **`M03-L4`'s own instrument** — `test_m03_l.ml` unit 1's item 6, the REQ-020 sequence read-back | Item 4 compares each frame's delivered octets **positionally** against the schedule's own `Arrival.delivered`, and §8's stimulus carries the four-octet sequence number at offsets 14 … 17 **inside those octets**. Item 6 reads the sequence back from **the list item 4 has just compared**. If item 4 passed at every frame, item 6 cannot fail; if item 4 failed anywhere, item 6 is never reached | **M03-L4 is qualified by citation to M03-L1's pairing or not at all.** A green at item 6 is evidence that **item 4 ran** — never evidence of order preservation. Measured under five classes: never reached under three, ran and passed under two |
| **U-2** | **`M03-L3`'s own instrument** — the same unit's item 8, the whole-run ΔC and `Latency.errors` | Item 8's four checks are closed **term by term** by items 4 and 7: the whole-run `word_delay` accessor by item 7's two class records, every per-frame arm of `Latency.errors` by item 4's octet count / word-0 `tkeep` / bench-computed front offset and every derived arm by item 7, `frames_compared` by being **bench-supplied** (one call per schedule frame, never evidence the design delivered one), and `octets_compared` by item 4's per-frame 60 | **M03-L3's ΔC content is discharged by `WO-0070` §6's derivation — a statement about the specification — and by no run.** No `SO-`, campaign or scorecard may report a kill as evidence that its assertions convict |

**THE PORTABLE FORM, recorded because it is not about this bench** (seal §6.6):

> **An assertion whose subject is already compared, positionally and earlier, by
> a sibling assertion in the same unit is unreachable, and its greenness is
> evidence about the sibling.**

The consequence that makes it worth carrying: **a coverage claim counting both
assertions has counted one observation twice**, and the only way to find that out
is to derive the unit's **first-speaking order** *before* a campaign scores it —
which is what `WO-0073` §4 did, and what turned two rows from a scorecard's silent
passengers into a declared result.

**What would reach them, and it is NOT commissioned here.** Neither instrument is
blocked on machinery, so neither earns an X-row: what U-1 needs is a unit whose
sequence check is **not preceded** by a positional octet comparison of the same
octets, and what U-2 needs is a latency-record assertion **not preceded** by
per-class records that fix its operands — both of them changes to *assertion
ordering or stimulus separation*, not new capability. **`WO-0073-VERDICT` §12
records that no bench change is owed by that campaign's result** (every unit
behaved correctly, including all five that stayed green where the instance lists
said they would redden), so this note **names the shape of a repair and
commissions nothing**. Whether either is worth a unit of its own is a question
for the round that opens `test/xgmii_rx_64/test_m03_l.ml` or for the `SO-`, and
it is recorded here so that neither can be answered by silence.

**A THIRD — `DECLARATION WO-0074-D1` — AND IT IS NOT THE SAME KIND, WHICH IS THE
WHOLE REASON IT IS WRITTEN BESIDE THE OTHER TWO RATHER THAN INSIDE THEIR TABLE**
(2026-08-10, `J-dv_lead-0138`, from `WO-0074-VERDICT` §7(b) and §11 item 7,
adjudicated `J-dv_lead-0137`; **the heading and table above are left unedited on
purpose** — what moved is the world, not the sentence, which is this section's
own standing disposition for a superseded count). U-1 and U-2 are **bench-side**:
an assertion is unreachable because a **sibling assertion in the same unit** has
already compared its subject. This one is **design-side**, and it is a
**grammar** gap rather than a stimulus gap or an ordering one.

| # | The unreachable instrument | Why it cannot speak | What the plan may say |
|---|---|---|---|
| **U-3** | **The strobe assertions of `M03-B3` and of all six `M03-N2` sub-cases, read against §9's ruling 9** — the in-word (**epoch B/C**) report path | A sub-five frame opened **and** closed inside **one** input word is reported at this design by a **separate in-word report vector that carries no FCS-report member at all**, so ruling 9's co-occurrence defect — *the residue comparison runs at every terminate character* — **has no rendering there by any datapath-silent mutant**. The bench half is established on this plan's own side of the line: `test_m03_b.ml`'s family header states that every row in that family aborts a frame strictly **inside its own preamble**, that all three pinned reports land in the **start word**, and that `M03-N2`'s six sub-cases share that geometry | **No `SO-`, campaign or scorecard may count `M03-B3` or `M03-N2`'s sub-cases as coverage of ruling 9.** Ruling 9's coverage at this module is `M03-F2`'s, `M03-I2`(member iii)'s and `M03-G7`'s — the **epoch-A** closures, all three of which reddened under `IC-M10`. `M03-B3` and all six sub-cases were predicted green **before the run** by the manifest's epoch table, and all seven were green |

**The evidence, and its one honest limit, stated rather than smoothed.** The
partition the run produced is not close — three epoch-A units **RED**, seven
epoch-B/C units **GREEN**, under one diff — and the only competing explanation,
*the class was never seeded*, is refuted outright by those three reds. **The
half this plan did not verify at the source is the claim that the in-word report
vector carries no FCS-report member**: that is RTL, this seat does not read RTL
(PROTOCOL §10), and the claim is the auditor's, published **before the run** in
falsifiable form with line numbers in `docs/reports/audit/WO-0074-mutations/README.md`
at `adac5ca`. It is adopted on those three grounds and is checkable in history by
anyone who wants it at the source; **confirming it at the source is cheap and is
recommended** (`J-dv_lead-0137` Open-question 1).

**Why this is a declaration and not an X-row, and not a GAP row either.** An
X-row says *a row cannot be asserted until machinery exists*; U-1 and U-2 say *the
assertion exists, is landed, is green, and no mutation can make it speak*. **U-3
says the last of those for a reason that lives in the design's report grammar**,
so no bench change and no new machinery reaches it: it is discharged **only** by a
change to that report path, or by a directed **non-datapath-silent** probe, which
is outside a mutation campaign's whole class of evidence. **This is the
programme's fourth recorded structural blindness and the second of grammar
kind**, the first being the differential co-simulation lane's canonical form,
which carries no strobe field at all (§4.M's post-campaign block, item 6; the
cosim-lane round pays that one).

**One thing it does NOT move**, stated because the two sets overlap and a reader
will ask: §2's obligation 4 carries the measured **nine**-unit inventory of
no-output-word `Strobe_monitor` registrations, and `run_b3` and
`run_i2_zero_octet_member` are both in it. **That inventory is unchanged.** U-3 is
a statement about which **mutation classes** can reach those assertions, never
about whether the assertions exist or run — they exist, they run, and under
`WO-0063B`'s report-path class all nine reddened.

**A FOURTH — `DECLARATION J-D1` — AND IT IS A THIRD KIND AGAIN, WHICH IS WHY IT
IS WRITTEN BESIDE THE OTHER THREE AND NOT INSIDE EITHER TABLE** (2026-08-10,
`J-dv_lead-0143`, from `WO-0076` seal §6.7 frozen at `8346a5c` and
`WO-0076-VERDICT` §7.3 and §11 item 6 at `a8d6140`, adjudicated
`J-dv_lead-0142`; **the headings and tables above are left unedited on purpose**,
this section's own standing disposition for a superseded count). U-1 and U-2 are
**bench-side**: the assertion is unreachable because a **sibling assertion in the
same unit** has already compared its subject. U-3 is **design-side**: the report
grammar has no member for the defect to displace. **U-4 is neither, and it is the
uncomfortable one — the assertion is reachable, it SPEAKS, and two seeded classes
killed at it; what it cannot do is mean what its green looks like it means.** The
cause is not ordering and not grammar but the **shape of the observable**: it is
an **absence**.

| # | The instrument, and the design it cannot see | Why the green does not separate them | What the plan may say |
|---|---|---|---|
| **U-4** | **`M03-J1`'s silence scan**, read against a design that **admits** every refused frame and **mutes** its output | **An observable expressed as an ABSENCE cannot distinguish a component that never produced the event from one that produced it and suppressed it.** The scan asserts that no output word and no strobe appear while the enable is 0; the admitted-and-muted design produces exactly that. **Measured on the `add` branch** by IC-J3 (run `31064104902`), a rendering that refuses **and** mutes: the green there measures directly that the scan **cannot see an emission gate at all**. The *admitted-and-muted* design is the **`move`** branch, **not rendered** — `WO-0076` §7 collision 3 pre-committed that this bench produces **no discriminator** between the branches, so the green under `move` follows from a **pre-run derivation, not from a run** | **No `SO-`, campaign or verdict may cite `M03-J1`'s green as evidence that frames were not admitted.** The declaration **stands and is MEASURED on the `add` branch; its strongest form remains DERIVED**, and it is recorded in that wording and not in a stronger one — writing it stronger is exactly the move `WO-0076`'s §0.3 was written to forbid |

**What separates them, and this is the one difference from U-1, U-2 and U-3 that
is good news**: a **positive comparison against a reference run** does it, and
**that instrument already exists and is landed** — it is `M03-J3`'s (C), the
disabled-versus-reference tuple comparison, qualified in the same campaign by
IC-J5 (run `31064107507`). So U-4 names no machinery gap and no unreachable
assertion; it names a **division of labour between two rows that a scorecard
counting both as "family J coverage" would erase.** U-1 and U-2 have no such
sibling anywhere; U-3 has none by construction.

**Why it is not minted as an X-row, and the commission that asked for one is
honoured rather than followed literally.** `WO-0076-VERDICT` §14 item 3
commissions this as *"a §7 X-row in its measured wording"*. An X-row says **a row
cannot be asserted until machinery exists** — and no machinery is missing here:
the assertion is landed, it is green, it has killed twice, and the separating
instrument is landed too. Homing it in the X-table would make this section's own
distinction unreadable, which is precisely the trade `J-dv_lead-0138` refused when
it declined to fold U-3 into the U-1/U-2 table. **The commission's evident intent —
§7, beside the X-rows, in the verdict's measured wording — is met exactly; only
the row *kind* is narrowed, and the narrowing is disclosed here rather than
absorbed.**

**A FIFTH — `DECLARATION K-D1` — AND IT IS A FOURTH KIND AGAIN, WHICH IS WHY IT IS
WRITTEN BESIDE THE OTHER FOUR AND NOT INSIDE ANY OF THEIR TABLES** (2026-08-11,
`J-dv_lead-0148`, from the campaign seal's **§6.6**, frozen at `aced7b4`,
and `WO-0077-VERDICT` §10 item 1 at `d6fdf92`, adjudicated `J-dv_lead-0147`; **the
headings and tables above are left unedited on purpose**, this section's own
standing disposition for a superseded count). U-1 and U-2 are **bench-side**: a
sibling assertion in the same unit has already compared the subject. U-3 is
**design-side**: the report grammar has no member for the defect to displace. U-4
is the **shape of the observable**: an absence cannot distinguish a component that
never produced the event from one that produced it and suppressed it. **U-5 is the
PLACEMENT of the stimulus, and it is the only one of the five that is a property
of neither the design nor the assertion but of the interval the row chose to look
at.**

| # | The instrument, and the defect class it cannot see | Why the green does not separate them | What the plan may say |
|---|---|---|---|
| **U-5** | **`M03-K1`'s silence scan**, read against **any** defect that merely fails to suppress | **A row whose stimulus places its window over an interval in which a conformant design has NOTHING PENDING AND NOTHING ARRIVING can be convicted only by a defect that CARRIES an observable into that interval — never by one that merely fails to suppress.** The frame closed on the cycle before the window opened, every input word inside the window is idle, and there is no start character anywhere after cycle 1: a design that ignores `clear` entirely and a conformant one emit the same nothing. **Measured, and the partition is not close**: green under `IC-K1`, `IC-K2`, `IC-K3`, `IC-K5` and `IC-K6` — five defects that fail to suppress, five distinct REQ-009 clauses — and red under **`IC-K4`** alone, the one that carries (run `31075094473`) | **No `SO-`, campaign or verdict may cite `M03-K1`'s green as evidence that a `clear` window suppresses anything**, and **this silence scan is satisfied by a design that does nothing at all under `clear`.** The row is qualified, and it is qualified on the carrying class alone — see its own Kills cell for the two members of its honest kill that no class rendered |

**What separates them, and unlike U-4 the answer is not a sibling row — it is a
different STIMULUS, and the plan already contains one.** `M03-K2` places its window
over a frame with six output words still to come and closes it on a cycle carrying
a start character, so at that row a failure to suppress **is** observable: five of
the six K classes convicted there and none of them at `M03-K1`. **So U-5 names no
machinery gap and no unreachable assertion; it names a DIVISION OF LABOUR BETWEEN
TWO ROWS OF ONE FAMILY that a scorecard counting both as "family K coverage" would
erase** — the U-4 shape one family over, with the separating instrument inside the
same section rather than in another one.

**Why it is a declaration and not an X-row, a GAP row or a finding.** No machinery
is missing: the assertion is landed, green, and has killed. No attack is wanted and
unmountable: the attack the row mounts is REQ-009's own words and it is sound.
Nothing is defective: **the row's window is placed exactly where REQ-009's *"and on
the first cycle in which it is 0"* conjunct requires a bench to look, and the
placement's cost is a consequence of the requirement rather than of the bench.**
**The portable form, recorded because it is not about this bench**:

> **A silence assertion over an interval in which a conformant component is
> already silent measures only defects that ADD, never defects that FAIL TO
> REMOVE — and a coverage claim that does not say which of the two it bought has
> reported the size of the window instead of the size of the evidence.**

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
| 2026-08-09 | **The family-L campaign is ABSORBED INTO THE PLAN: three rows QUALIFIED, two recorded SCORED-AND-UNQUALIFIABLE on their own instruments, two structural unreachabilities filed at §7 with the portable form that generalises them, and the co-sim anchor gains a THIRD bar — a blindness rather than a gap (`WO-0073-VERDICT` §12 item 1, five items; `J-dv_lead-0134` adjudicated the campaign at `7bedc30`, `J-dv_lead-0135` lands this round). NO ROW ADDED, NO ROW CONVERTED, NO STATUS MOVED, NO COVERAGE-MAP LINE CHANGED: 78 rows, 62 ASSERT, 7 NO-ASSERT, 4 NO-STIMULUS, 4 STRUCTURAL, 1 GAP — counted from this file by a status-cell pass over every row table at this commit, before and after the edits, and NOT carried forward.** **Held back from every commit of the campaign on purpose**: the plan is the campaign's contract, and moving it inside the window would have violated `WO-0073` §8's ordering rule the same way `WO-0066` §8's was honoured. The campaign has scored; the window is closed; this is that round. **(1) M03-L1 → QUALIFIED on three classes, 3/3, THROUGH ONE INSTRUMENT** — IC-L1(**D**), IC-L4(**S**) and IC-L5 all convict at unit 1's item 3, the `tlast` count, the first two raising **identical strings including the integer** and the third separated from them by §9's sealed **direction** alone. The cell says *one instrument* in terms, so no later packet reads three kills as three coverages. **(2) M03-L2 → QUALIFIED on one class, 1/1** — IC-L2 at both front-offset class records; **(3) M03-L5 → QUALIFIED on one class, 1/1, with the LENGTH-DEPENDENCE CLAIM EARNED** under §8.1 rule 1: `4 ∉ R` left unit 1 green across all 10 000 frames while unit 2 reddened at length 70, so the row's own Kills sentence — *a fixed-length stress run cannot see it* — is now **measured** rather than argued, and it is the only class in the campaign whose entire convicting set lies outside the stress run. **All three recorded in their Kills cells with Status left at `ASSERT`** (`J-dv_lead-0109`'s divergence ruling: §1's status vocabulary is closed at six values and `QUALIFIED` is not one of them). **(4) M03-L3 and M03-L4 → SCORED AND UNQUALIFIABLE, in their own cells, where a future scorecard will look.** Both instruments are closed by assertions that speak earlier in the same unit — item 6 reads back the octets item 4 has already compared positionally, item 8's operands are fixed by items 4 and 7 — and **both were declared at `WO-0073` §4 before the campaign ran**, then confirmed by measurement under all five classes (never reached under three or four, ran and passed under the rest). **§12's pass criterion 6 required this to be said whatever the score was, and the score does not soften it.** **(5) §7 gains U-1 and U-2 beside the X-rows, and deliberately NOT as X-rows**: an X-row says a row cannot be asserted until machinery exists; these say the assertion exists, is landed, is green, and no mutation can make it speak. The seal's portable form is carried whole — *an assertion whose subject is already compared, positionally and earlier, by a sibling assertion in the same unit is unreachable, and its greenness is evidence about the sibling* — with its consequence: **a coverage claim counting both has counted one observation twice**, and only a first-speaking-order derivation taken **before** a campaign scores finds it. The repair shape is named and **nothing is commissioned**: `WO-0073-VERDICT` §12 records that no bench change is owed by that result. **(6) `FINDING WO-0073-D2` recorded against §7's co-sim banner as BAR 3, with the ruling.** The Phase-1 differential lane is **content-comparing, not timing-comparing**: it passed under IC-L2's uniform ΔC 3 → 4 on every output word and every strobe, while `Latency.errors` stayed **empty** by REQ-019's own arithmetic. **No `SO-` may cite the anchor as timing coverage of any stimulus class**, and REQ-005/REQ-111's pinned per-octet constant is the programme's **only** detector of a uniform word-delay regression. **RULED, option (a) ADOPTED** (`J-orchestrator-0215`): the lane gains an explicit cycle comparison, dv_lead drafts the `WO-` in the cosim-lane round — **not here**, a plan round is not where machinery lands. Bar 3 is per **quantity**, where bar 1 is per row and bar 2 per requirement, and it holds for every row and every requirement at once. **(7) The three rule-versus-instance divergences DERIVED PER ROW**, the debt `WO-0073-VERDICT` §5.1 named and declined to claim: `test_m03_f.ml` green under IC-L1 because three of family F's four units drive a single frame and M03-F4's pair rounds its next start **two** words past the terminate word (63 ≡ 7 mod 8 — the row's celebrated adjacency is in **octet times**, not words); `test_m03_g.ml` green under IC-L4 because REQ-108 pins the truncated frame's last output word 82 octet times **before** its own terminate character, which is where §0.3 starts measuring the gap, leaving ≥ 10 cycles where the class needs 0; `test_m03_i.ml` green under IC-L4 because family I has exactly **one** multi-frame unit and M03-I3's `~ifg:824` puts 102 cycles between them. **One geometric fact governs all three** — with the default gap a start word succeeds a terminate word **iff** that terminate character occupies lane 0 — and the portable half is that **a class keyed on a coincidence between an output event and an input event is selected by the schedule's arithmetic, never by the family a unit sits in, so an instance list built from families is a superset of the rule every time.** Under `WO-0066`'s enumeration regime these were three MUST-STAY-GREEN violations against me; under the rule form they are **none**, and this is the first time that lesson has been tested. **(8) `WO-0073-D4` and `WO-0073-D3` carried into the post-campaign block.** D4: collision 1's sealed discriminator *"NONE that this bench produces"* is **exact at the cell and too strong at campaign scope** — `M03-K2` separates IC-L1(D) from IC-L4(S) completely (`got 8` against `got 15`, a dropped frame against a lost tail word), and the auditor derived that separation independently while blind to the seal; no cell moves, the correction is to how the claim is scoped. D3: the `test bug --` mislabel shape exists **outside family L**, at **M03-I4** under IC-L2 and IC-L3, disposed of by the seal's §5.5 as a design red mislabelled by the bench and changing no score; **carrier: the next commit that opens `test/xgmii_rx_64/test_m03_i.ml`**, which this round is not. **THE DISCHARGE CENSUS IS UNMOVED AND THAT IS THE RULE, NOT AN OVERSIGHT: 62 of 62.** Qualification measures an instrument — it discharges no row and moves no count — and this round adds no unit and no title. Re-measured at this commit by `tools/dv_checks.sh`'s own census commands rather than carried: **78** row ids declared, **62** named in a committed unit title under the trailing-digit boundary matcher and **62** under the naive one (the two agree at this tree, which is a property of today's id set and not of the method), − `M03-A4` (NO-ASSERT, named in a title) + `M03-F5` (by citation) = **62**; the 62 ASSERT denominator counted from this file's own status cells in the same pass. **§6 is unchanged because it maps requirements to rows and not rows to kill evidence** — unqualifiability is a property of an **instrument**, and it is recorded at the row and at §7 where a reader of coverage claims will meet it. **No `SO-xgmii_rx_64.md` is opened and none is offered**: families J, K and M are unscored, the charter §3 co-sim anchor is undischarged per stimulus class and `WO-0073-D2` has just made that item sharper rather than smaller, and three qualified rows are not a module sign-off. **Nothing in `test/**` is owed by this result.** | dv_lead, `J-dv_lead-0135` |
| 2026-08-10 | **The family-M campaign is ABSORBED INTO THE PLAN: seven rows QUALIFIED with their carriers, one recorded SCORED-AND-UNQUALIFIABLE at this design on the NARROW form, two declared permanently unscoreable, a FOURTH structural blindness filed at §7 as U-3, and the era tally gains an honest FOURTH COLUMN (`WO-0074-VERDICT` §14 item 1; `J-dv_lead-0137` adjudicated the campaign at `70cf13c`, `J-dv_lead-0138` lands this round). NO ROW ADDED, NO ROW CONVERTED, NO STATUS MOVED, NO COVERAGE-MAP LINE CHANGED, NO UNIT AND NO TITLE TOUCHED: 78 rows, 62 ASSERT, 7 NO-ASSERT, 4 NO-STIMULUS, 4 STRUCTURAL, 1 GAP — counted from this file by a status-cell pass over every row table at this commit, before AND after the edits, and NOT carried forward.** **Held back from every commit of the campaign on purpose**, as family L's round was: the plan is the campaign's contract, and moving it between the seal and the scoring is what `WO-0074` §8's ordering rule forbids. That rule is **verified at the tree rather than asserted** — `git diff --stat ca1bb80 HEAD -- test/ libs/ tools/ docs/specs/` is **empty**, so the bench this campaign judged is byte-identical to the bench it was sealed against, and every denominator below is re-measured here rather than quoted (§0.1): **59** M03 units, **139** repository-wide, **140** by the contaminated matcher (`FINDING M-4`, unrepaired, carrier the cosim-lane round), **80** non-M03 = 79 behavioural + 1 build-level. The campaign has scored; the window is closed; this is that round. **(1) SEVEN M ROWS QUALIFIED, EACH ON ONE KILL, EACH SHARING THAT ONE KILL WITH ITS CARRIER** — `M03-M1`/`M03-F3` (IC-M1, run `31054172382`, `observed 1`, the campaign's only *subtractive* sealed reading), `M03-M2`/`M03-G1` (IC-M2, `31054177436`), `M03-M3`/`M03-E1` (IC-M3, `31054174810`, at the **FULL** prefix variant the seal *derived* rather than transcribed), `M03-M4`/`M03-H1` (IC-M4, `31054177858`), `M03-M6`/`M03-G7` (IC-M6, `31054177532`, **first-epoch carrier alone**), `M03-M7`/`M03-G8` (IC-M7, `31054179722`, **first-epoch carrier alone**), `M03-M10`/`M03-F2` (IC-M10, `31054180874`, **that carrier alone**); control `31052415338` at `ca1bb80`, green at every step. **All fourteen recorded in their own Kills cells with Status left at `ASSERT`** (`J-dv_lead-0109`'s divergence ruling). **(2) `M03-M5` → SCORED AND UNQUALIFIABLE AT THIS DESIGN, and the NARROW form is the one adopted.** `IC-M5` was sealed, seeded in intent and **never rendered**: this design carries exactly **one** open-frame term and that term bounds the delivered extent, so ruling 5's defect cannot be rendered here without moving the datapath — two attempted renderings both did, one stranding the aborted frame's last word and one losing its final half word. **What it does NOT establish is that ruling 5 is inherently unrenderable**; a design with a separate report-side flag would have a mutant, and the narrow claim is worth more than the wide one because it names what would have to change. The design-side fact is the auditor's, published before the run at `adac5ca` and **quoted, not verified** — this seat reads no RTL. **(3) `M03-M8` and `M03-M9` → UNSCOREABLE, UNSCORED, SURVIVING ANY OUTCOME** — no mutant exists (disjoint octet ranges) and none is expressible (M03 is `tuser`[0]'s origin on this chain). Consequence, recorded at both rows: **a full family-M scorecard is not full coverage of §4.M.** **(4) `FINDING M-1` AND `FINDING M-2` ARE NOW MEASURED RATHER THAN ARGUED.** Both were load-bearing REQUIRED greens in the seal and both held: `M03-G3` green under IC-M6 while `M03-G7` reddened, `M03-G4` green under IC-M7 while `M03-G8` reddened. The epoch distinction the two findings asserted from the stimulus at `J-dv_lead-0132` is established from a run, and the prohibition each carries — no packet may cite `M03-M6`/`M03-M7` as `Discard`-state coverage on the strength of `M03-G3`/`M03-G4` — is measured. Four `G!` cells measurable, four held; the two unmeasured belong to the void class and **no claim is made from them in either direction**. **(5) `OBSERVATION M-O1` AND `FINDING M-O1a` ARE ANSWERED IN BOTH ROWS' FAVOUR AND CLOSED** — the measurement a bench could not make and a campaign could. Both carriers reddened at their strobe-set assertions, which the seal fixed **before the result** as answering the anti-vacuity question in the rows' favour: `M03-M2`'s single 1518-octet prefix does not satisfy REQ-304's residue at the truncation point, and `M03-M4`'s single 64-octet filler content does not satisfy it at the `/S/` closure — so M-O1a's widening, that M4's ground is exactly as thin as M2's rather than twice as broad, is answered too. **The second-content repair M-O1 would have commissioned is NOT commissioned**; the residual risk is the same *fixed* 2⁻³² one, recorded rather than repaired. **(6) THE BLAST-RADIUS ACCOUNTING CONVICTS `FINDING M-3` A SECOND TIME AND FROM THE OTHER DIRECTION: 21 reds, 7 kills, FOURTEEN OF THE TWENTY-ONE QUALIFYING NOTHING.** The block above says a class killing a carrier kills its M row *by construction*; every one of the seven kills **did** run through the co-occurrence, and it is only §11's **corrected** carrier/bound-row rule that stands between seven kills and twenty-one. Named per class in the post-campaign block, with the two dangerous cases spelled out: IC-M2's six family-G reds qualify **neither** `M03-M6` **nor** `M03-M7` (their carriers reddened through **ruling 2**), and IC-M10's `M03-G7` red qualifies `M03-M6` **not at all** (**ruling 9**). Collision 3 was fully instantiated — three classes, one message, integer `3` included — and four sealed discriminators separated it. **(7) `DECLARATION WO-0074-D1` → §7's U-3, beside U-1 and U-2 and deliberately NOT inside their table, whose heading and count are left unedited.** *At this design the in-word (epoch B/C) strobe path is unfalsifiable for ruling 9*: a sub-five frame opened **and** closed inside one input word is reported by a separate in-word report vector carrying **no FCS-report member at all**. A **grammar** gap, not a stimulus gap — U-1 and U-2 are bench-side, this is design-side, and no bench change or new machinery reaches it. Consequence, recorded at `M03-B3`, `M03-N2` and `M03-M10`: `M03-B3`'s sealed cell is **rescored from REQUIRED-RED to green-by-structural-unreachability**, neither it nor `M03-N2`'s six sub-cases may ever be counted as coverage of ruling 9, and the campaign's ruling-9 coverage is the three **epoch-A** closures alone. **The programme's fourth structural blindness and the second of grammar kind**; §2's nine-unit registration inventory is **unchanged** by it. **(8) `FINDING WO-0074-S1`/`S2`/`S3`/`S4` recorded in the post-campaign block, ALL FOUR AGAINST MY OWN INSTRUMENTS** — no finding against the manifest and no `BUG-`, every red being a seeded kill or its predicted radius. S1: a rule naming the condition a class keys on must also name every gate the rendering may **not** remove, or it silently describes a combined class the packet forbids — mine selected seven units that stayed green, corrected **before** the run by the auditor's committed reading note, zero scoring consequence. S2: prose counts drifting from correct matrices (seven `G!` cells where six exist; eleven/tenth/ten where twelve is measured). S3: the IC-M10 rule read only the octet count and so marked `M03-B3` REQUIRED-RED — the finding that mints D1. S4: a collision inventory built from the marked cells alone is incomplete by construction — the run produced a fourth collision at a **scored** cell (`M03-G8`, IC-M2 ≡ IC-M7, `observed 2` in both) and a fifth scored for neither class, no kill endangered, and the corrected method is **banked as a bar on the family J and K seals**: derive the inventory from the cross product of every class's predicted red set with every scored cell. `FINDING WO-0074-A1` is the auditor's, ruled ACCEPTED, and its DV-side consequence is nil because the ordering rule — the thing that makes the evidence evidence — held and was verified at the tree. **(9) ERA TALLY, WITH A FOURTH COLUMN OPENED RATHER THAN A FIGURE FUDGED: 41/40/1/0 before, +8/+7/+0/+1 for family M, 49 SEALED / 47 KILLED / 1 SURVIVED / 1 VOID BY DECLARATION after** (47 + 1 + 1 = 49; the survivor is still `G-c4`, `FINDING G-1`). `IC-M5` is the era's first VOID class: collapsing it into *killed* would overstate coverage and into *survived* would libel a bench that was never given anything to catch. **(10) §4(c)'s datapath-silence check and the qualification criterion were THE SAME TEST this round** — all 21 reds are exact-strobe-set messages with the strobe-set assertion last in every carrier, so each red states that the strobe set changed **and** the whole delivered stream is byte- and cycle-identical to the conformant one. **(11) THE DISCHARGE CENSUS IS UNMOVED AND THAT IS THE RULE, NOT AN OVERSIGHT: 62 of 62** — re-measured at this commit by `tools/dv_checks.sh`'s own census commands, **78** declared, **62** boundary-matched and 62 naive, − `M03-A4` + `M03-F5` = **62**. Qualification measures an instrument; it discharges no row and moves no count, and this round adds no unit and no title. **§6 is unchanged**, for the reason family L's row already gives: it maps requirements to rows, not rows to kill evidence. **(12) NOTHING IN `test/**` MOVES AND NOTHING IN `test/**` IS OWED BY THIS RESULT.** Two carriers are named rather than paid, both at their rows, both for the standing reason that a plan round does not improve a carrier (`J-dv_lead-0112`): `WO-0047` §2's **4-octet anti-vacuity member is SHADOWED, not measured** — `M03-F2`'s zero-octet member spoke first exactly as sealed, so the non-zero-filler discipline this plan imposes **is not measured by this campaign and no verdict may say it was** — carrier the next commit opening `test_m03_f.ml`; and `WO-0073-D3`'s `M03-I4` mislabel, carrier the next commit opening `test_m03_i.ml`. **(13) The co-simulation anchor is blind to this entire campaign BY GRAMMAR** — the canonical form has no strobe field, the `cosim` job was `success` under all seven classes and **that green is evidence of nothing**. This is a blindness per **field**, distinct from §7's bar 3 per **quantity**; **both are paid from one measurement in the cosim-lane round**, not here. **No `SO-xgmii_rx_64.md` is opened and none is offered**: families **J** and **K** are unscored, the charter §3 anchor is undischarged per stimulus class and now blind per strobe, and seven qualified rows are not a module sign-off. **The lessons harvest falls due at the `SO-`**; the span since my last harvest stays open and declared, three candidates banked in `J-dv_lead-0137`. | dv_lead, `J-dv_lead-0138` |
| 2026-08-10 | **`WO-0075`, the cosim-lane round — §7's banner gains BAR 4 and BAR 3 gains its draft; no row moves and no count moves.** **(1) BAR 4 — THE SECOND BLINDNESS, AND ITS CAUSE IS NOT THE ONE I NAMED.** `WO-0074-VERDICT` §11 item 1 declared the lane blind to the family-M campaign *"by grammar"*; re-derived at this tree against `test/cosim/stimulus_gen.ml`'s **actual** stimulus — one 64-octet good-FCS lane-0 frame, no second frame, no error character, no bad FCS, no runt, no oversize, no abort — **not one of the seven classes is RENDERED at all**, so a strobe field would have been an all-zero column under every one of them. **The blindness is stimulus-bound first, mapping-bound second, and grammar-bound only third**, and my own declaration is corrected at the row rather than restated. **(2) THE PRICE, MEASURED OVER BOTH CAMPAIGNS: twelve seeded classes, ZERO divergences reported by the comparison.** Two of the twelve are rendered at the lane's stimulus — **IC-L5**, caught by `ours_run`'s own no-open-frame guard and **not** by REQ-901's comparison, and **IC-L2**, rendered and unrecordable, which is bar 3's class. **Four are unreachable because the lane drives ONE frame**, a bound on everything this lane can ever be cited for that was never stated when `WO-0046` chose that stimulus. **(3) THE COMPARABLE STROBE SET IS BOUNDED ABOVE BY ONE OF M03'S FIVE, BY THE FROZEN SPEC AND NOT BY THE HARNESS**: `error_runt` and `error_oversize` are REQ-901's declared divergence classes (e) and (f), which **bar 2 already reaches, strobes included**; `error_start_without_terminate` has **no counterpart output** on the reference's published port list; `error_bad_frame` exists on both sides and **is a different signal** — the reference raises it on a bad FCS as well, where §9's table gives that event to `error_bad_fcs` alone, so a name-keyed comparison would **red a conformant M03**. **(4) DECISION — THE CANONICAL FORM DOES NOT GAIN A STROBE RECORD, AS A REFUSAL AND NOT A DEFERRAL**, with three ordered preconditions (stimulus, then mapping, then grammar) so the refusal is checkable. An all-zero column would turn §11 item 1's *"that green is evidence of nothing"* from **true** into **invisible** — this section's own catalogued failure mode at its fifth instance. **The bar: no `SO-` may cite the anchor as strobe coverage of any stimulus class, and the reason it must give is the STIMULUS, not the grammar.** It is per **quantity** like bar 3, it does **not** compose away against `DECLARATION WO-0074-D1` at U-3 (that is a design-side report grammar; this is the anchor's stimulus), and unlike bar 3 it is **not** discharged by the `WO-0075` lane. **(5) BAR 3 GAINS ITS DRAFT AND THE DRAFT CORRECTS THE RULING'S WORDING.** `agents/handoffs/WO-0075_cosim-lane-cycle-comparison.md` exists; it does **not** compare our cycles against the reference's, because REQ-901 excludes cycle alignment **by name** and the only way to green such an assertion would be to take an expected value from the reference, which REQ-901's closing sentence and ADR-0015 D2 both forbid. The packet delivers the intent under the constraint: **record** time on both sides, **assert** our side against §6.1's `m + 3`, **report** the reference's as data never adjudicated — REQ-901's own sub-5-octet disposition applied to time. IC-L2 reddens all eight words under it. **A fifth consequence, stronger than a blindness: a cross-side timing comparison is BARRED, not un-built**, and a later phase that wants one takes a REQ-901 spec diff, not a comparator that grants itself the claim. **Bar 3 is not lifted**; it lifts per stimulus class on a green `cosim` job with both `WO-0075` halves landed. **(6) NO ROW, NO STATUS, NO COUNT AND NO §6 CELL MOVES: 78 rows, 62 ASSERT, 7 NO-ASSERT, 4 NO-STIMULUS, 4 STRUCTURAL, 1 GAP**, re-measured by a status-cell pass at this tree before and after the edit, and the discharge census is unmoved at **62 of 62** because no unit and no title moved. **(7) THIS ROUND IS THE CARRIER FOR THREE INSTRUMENT REPAIRS OUTSIDE THIS FILE AND THEY ARE NAMED SO THE PLAN'S OWN CITATIONS STAY TRUE**: `FINDING M-4` — `tools/dv_checks.sh`'s repository-wide matcher read a **directory** and not a **file type**, counting line 865 of this very file as a bench unit; repaired, **140 → 139**, and the plan's quotations of 139 are now what the tool prints. `WO-0073-D5` — `run_cosim.sh` labelled a producer's runtime raise `BUILD` on a run whose build had succeeded; code 3's contract is unchanged and gains a second stage name, `PRODUCE`. `test/cosim/dune`'s dangling `test/cost_probe/` reference, open since `J-dv_lead-0132` with this exact carrier, and a stale "fifteen units" count in the same comment, removed rather than updated. **(8) NO `SO-` IS OPENED AND NONE IS OFFERED**; families **J** and **K** are unscored and both their seals owe `FINDING WO-0074-S4`'s method. **The lessons harvest falls due at the `SO-`**; the span since my last harvest stays open and declared, three candidates banked in `J-dv_lead-0137` and two more added at `J-dv_lead-0139`. | dv_lead, `J-dv_lead-0139` |
| 2026-08-10 | **The family-J campaign is ABSORBED INTO THE PLAN: three rows QUALIFIED with their carriers and run ids, one recorded UNQUALIFIABLE BY SPECIFICATION, `M03-N4` recorded QUALIFIED BY NOTHING — here or anywhere — a FIFTH structural limit filed at §7 as U-4, and THREE new findings minted against my own campaign text by §0.1 at the point of citation (`WO-0076-VERDICT` §14 item 3; `J-dv_lead-0142` adjudicated the campaign at `a8d6140`, `J-dv_lead-0143` lands this round). NO ROW ADDED, NO ROW CONVERTED, NO STATUS MOVED, NO COVERAGE-MAP LINE CHANGED, NO UNIT AND NO TITLE TOUCHED: 78 rows, 62 ASSERT, 7 NO-ASSERT, 4 NO-STIMULUS, 4 STRUCTURAL, 1 GAP — counted from this file by a status-cell pass over every row table, before AND after the edits, and NOT carried forward. Census unmoved at 62 of 62, inventory 59 / 139, measured by `bash tools/dv_checks.sh` at this commit.** **One coherent edit set and not several**, on `J-dv_lead-0138`'s ground: every item below is a statement about the *same* five classes and the *same* fourteen reds, and splitting them would produce a plan in which a row says QUALIFIED before the block defining what qualification excludes exists. **(1) §4.J gains a POST-CAMPAIGN STATUS block** — five classes, five branch heads and run ids, the control at `31061945377`, the verified ordering rule, re-measured denominators and the enable census, MUST-STAY-GREEN per class from the promotion lists, the five-row status table, the blast-radius accounting, the collision method's first vindication **on evidence**, the honest-breadth line, seven findings, the era tally and eleven refusals. **§4.J has never carried a landed-status block and this one does not invent a retrospective one**; the ground it replaces was laid in the rows' own dated cells and in §4.N's block, and all of it stands unedited with the outcome recorded beside it. **(2) `M03-J1` QUALIFIED — 2 classes, 2 kills, on two distinct clauses of ONE Observable**: IC-J1 at the silence scan's `tvalid` arm (run `31064102925`), IC-J2 at the same scan's strobe arm (run `31064103812`). **Two kills, one qualification** (`WO-0066` §11). **`FINDING J-1` lands in the same cell**: its narrow reading is now MEASURED unreachable rather than argued — under no class did a refused clean frame draw a report except where the class itself added one — and its second half is **OWED**, because REQ-810's first sentence, which is IC-J1's whole ground and this campaign's first kill, **has no Kills cell at all**. Carrier named: the next round that opens §4.J, at or before the `SO-`. **(3) `M03-J2` QUALIFIED — 1 class, 1 kill, ON ITS HONEST KILL ONLY** (IC-J4, run `31064106060`), **and the 2026-08-09 withdrawal is now MEASURED FROM A RUN INSTEAD OF AN ARGUMENT** — IC-J3 *is* a continuously-sampling design, it reddened `M03-J3` at that row's own cell and left this row GREEN, so the prohibition (`J-dv_lead-0124`) is enforced on evidence rather than quoted. **A bench cannot make that measurement about itself; a campaign can, and this is the one that did.** **(4) `M03-J3` QUALIFIED — 2 classes, 2 kills, at two different instruments**: IC-J3 at the disabled run's word count (run `31064104902`), IC-J5 at the tuple comparison (run `31064107507`), the only class of five whose rule selected exactly one unit. **`FINDING J-2` lands in its Observable**: the strobe clause is unfalsifiable in the SUBTRACTIVE direction — the in-flight frame is clean and owes none — and the carrier that would convict the suppressing design is `M03-N4`, **which no campaign has qualified**. **(5) `M03-J4` NOT QUALIFIED and UNQUALIFIABLE BY SPECIFICATION**: §6.3 item 7 and C-14.5 leave the same-cycle case unconstrained, so every rendering is an equivalent mutant by specification. **A five-of-five scorecard is therefore NOT full coverage of §4.J**, and the plan says so rather than letting the score imply it. **(6) `M03-N4` QUALIFIED BY NOTHING — four reds under four of five classes, every one blast radius — and `FINDING AP-3` convicts the sentence that softened it.** `WO-0076` §2 and its verdict §8 both call this row *"already scored at `WO-0066`"*; re-measured against `WO-0066` itself, that campaign qualified `M03-N2`, `M03-B2` and `M03-B4` member (b) and no other row, and its §13 item 2 calls `M03-N1`/`M03-N4` *"both still outstanding ASSERT rows"* whose bench had not been written. **Measured across the era: five reds in two campaigns, ZERO qualifications** — two of family N's four rows are landed, green and mutation-scored by nothing, and no `SO-` may treat either as scored. **(7) `FINDING AP-2` — the verdict's own red total does not survive re-measurement**: §2 says *"fifteen reds"*, its own scorecard table in the same section enumerates **fourteen**, and fourteen is what the per-class blast-radius rows sum to. **The table governs; no cell changes class and no kill moves; the plan carries fourteen reds, five kills and NINE reds that qualify nothing.** This is `FINDING WO-0076-S2`'s defect at its second instance in the same document and exactly what harvest candidate (E) was banked against one entry earlier. **(8) `FINDING AP-4` — the contamination attribution is wrong and its conclusion is not.** `WO-0076` §2 blames the 140 → 141 step on this file gaining *"two further prose quotations"* during the family-M absorption; measured at `ca1bb80`, `bb81fe5`, `6f0fd5b`, `c109c08`, `8346a5c` and HEAD, this file carries **exactly one** occurrence throughout and already carried it **before** that absorption, and the file that grew is **`test/cosim/dune`**, which gained the literal at `c109c08` inside a comment quoting the **corrected** command. `FINDING M-4`'s repair is confirmed at this tree; the instrument now counts two separate quotations of its own repair. **(9) `FINDING WO-0076-A1` DISCHARGED at `M03-M5`**: the `a_open` citation is restated as `libs/hardcaml_ethernet/src/xgmii_rx_64.ml:296 @ ca1bb80`, the auditor's finding adopted and **widened against me** at `J-dv_lead-0141` §5 to any file cited from outside itself. **This plan's whole exposure was one citation, measured, and the number is a locator for falsification rather than a key** — the strike test leaves every cell's meaning unchanged. **(10) `RN-4` recorded, and its repair correctly does NOT touch this plan**: `WO-0076` §7 item 4 admitted `docs/adr/ADR-0014.md`, a file that has never existed; the ADR is `docs/adr/ADR-0014-an-enable-gates-admission-not-the-wire.md`, recorded in the block so a later instrument citing it FROM this plan has a path that resolves. The auditor honoured the narrower of two disagreeing instruments and read the ADR under neither name, and the repair was made in a dated appended note rather than patched into the allowlist's body — **a correction that is appended and journalled is diffable; one patched into the body makes another agent's compliance statement unverifiable.** **This plan's own exposure is NIL and measured: it cites no `docs/adr/` path anywhere.** **(11) §7 gains U-4, `DECLARATION J-D1`, and it is a THIRD KIND of unreachability** — U-1/U-2 are bench-side sibling ordering, U-3 is design-side report grammar, and **U-4 is the shape of the observable itself**: an absence cannot distinguish never-produced from produced-and-suppressed, so `M03-J1`'s green cannot say that frames were not admitted. **Measured on the `add` branch by IC-J3; its strongest form remains DERIVED and is recorded in that wording and not a stronger one.** Unlike the other three it names a **separating instrument that already exists** — `M03-J3`'s positive comparison against a reference run. **The commission asked for an X-row and the narrowing is disclosed rather than absorbed**: an X-row says a row cannot be asserted until machinery exists, and no machinery is missing here. **(12) §4.N's landed-status block item (1) is ANNOTATED as paid and LEFT UNEDITED**, with the note that what it was reaching for is worse than it said and belongs to family N rather than family J, and that item (3)'s census clause is separately dated and superseded. **A dated claim is annotated beside itself, never rewritten into its own outcome.** **(13) The era tally moves 49/47/1/1 → 54 sealed / 52 killed / 1 survived / 1 void**, 52 + 1 + 1 = 54; the survivor is still `G-c4`, the void still `IC-M5`. **Family J is the fourth clean sweep of the era and the FIRST whose classes were permitted to move the datapath**, so the protection was the ordering and not a global no-movement check — verified at the tree, `git diff --name-only 8346a5c HEAD -- test/ libs/` empty at this commit. **NOT DONE, DELIBERATELY, each with its carrier named**: `FINDING J-1`'s second half; the 22-assertion breadth figure, carried with its SHA under §0.1 and **flagged as the one figure of this round not re-derived**, carrier the `SO-`; `WO-0047` §2's 4-octet member reorder, `OBSERVATION L-O1`, `WO-0073-D3`'s `M03-I4` mislabel and `OBSERVATION K-O1`, all at their own carriers — **a plan round is not where a carrier is improved** (`J-dv_lead-0112`). **No `SO-xgmii_rx_64.md` is opened or offered**: family K is unscored and the charter §3 co-sim anchor is undischarged and now blind per configuration class as well as per stimulus class and per strobe. **The lessons harvest falls due at the `SO-`**; the span since my last harvest stays open and declared, with candidates (C), (D) and (E) banked at `J-dv_lead-0141` and `J-dv_lead-0142` alongside the three from `J-dv_lead-0137`, none admitted here. | dv_lead, `J-dv_lead-0143` |
| 2026-08-11 | **The family-K/N campaign is ABSORBED INTO THE PLAN and the CLASS-BASED ERA CLOSES: four rows QUALIFIED — two of them for the first time in their history — a SIXTH structural limit filed at §7 as U-5, the anchor's first conviction recorded beside bar 4, `FINDING J-1` CLOSED in both halves, and `FINDING AP-3` discharged in the affirmative** (`WO-0077-VERDICT` §13 item 6, which commissioned this round explicitly *before* the `SO-` and named it *"the largest single carrier this programme is holding"*; `J-dv_lead-0147` adjudicated the campaign at `d6fdf92`; recorded here `J-dv_lead-0148`). **(1) THE CAMPAIGN: nine sealed classes across two separately-sealed sections — six §K, three §N — nine seeded, NINE KILLED, zero survived, zero green by blindness, zero void.** Bench frozen `22ffe13`, packet and seal `aced7b4`, pre-run rulings `04078fd`, manifest `f9232c2`, verdict `d6fdf92`; nine transient branches each cut fresh from `aced7b4`, one class each, with branch and `build` run id per class in §4.K's post-campaign block. **The era's ceiling was fixed at 61 killed before the round and is reached EXACTLY: 63 sealed / 61 killed / 1 survived / 0 green by blindness / 1 void.** **(2) FOUR ROWS QUALIFIED, AND TWO OF THEM HAD NEVER BEEN QUALIFIED BY ANYTHING.** `M03-K2` — five classes, five kills, **one** qualification, on five distinct clauses of REQ-009. `M03-K1` — one class, one kill, by `IC-K4`, the only class in the campaign that could, with the mutant-owned integer **2** matching the seal's inequality, direction and disclosed derivation. **`M03-N1`** and **`M03-N4`** — **first qualifications in either row's history**, discharging **`FINDING AP-3`** in the affirmative: it had measured five reds across two campaigns at `M03-N4` and none at `M03-N1`, every one arriving through an admission path seeded against a family-J row, and **these are the first reds at either row's own cells under classes seeded against the rows' own observables.** **No landed, green, unscored row remains in this module.** **(3) THE CAMPAIGN'S CENTREPIECE IS A GREEN, NOT A KILL.** `IC-K5` is the design `WO-0072` §7.5 withdrew from `M03-K1` on an argument from the stimulus — a `clear` window honoured one cycle late at both edges. It reddened `M03-K2` and left `M03-K1` **green**, exactly as the withdrawal derived before a bench existed. **The programme argued that withdrawal for four rounds without ever running the design it withdrew; the design has now been run, and the prohibition is enforced on evidence rather than quoted.** The same shape paid at `M03-N4`: **`IC-N4b` measured `FINDING J-2`**, confirming from a run that `M03-N4` is the **sole** carrier for the suppressing design and paying `WO-0076-VERDICT` §10's debt. **Both were the sole exercisers `FINDING RV-0075-3`'s bar refused to let anyone mark optional, and both paid.** **(4) `FINDING K-1` IS MEASURED AND IS WORSE THAN THE SEAL SAID: four classes produced not one identical message but one BYTE-IDENTICAL PROMOTED FILE** (blob `373f32a` under IC-K1, IC-K3, IC-K5 and IC-K6 alike), so `WO-0072` §9's pre-committed disposition table is confirmed **from a run** to be a taxonomy and not a discriminator; the discrimination that did the work was branch identity and the disclosures. **`FINDING WO-0077-K2`** is demonstrated by the same round: D3's two disjuncts were both rendered and the instrument separated them at two assertions with two strings, so **D3 splits into D3a and D3b** as ruled. Both are recorded at `M03-K2`'s Kills cell; **`K-1`'s message repair stays owed to the next commit that opens `test_m03_k.ml`** and is not paid here. **(5) `FINDING WO-0077-A1` (MAJOR, mine) — THE DIFFERENTIAL CO-SIMULATION ANCHOR IS NOT BLIND TO THIS CAMPAIGN, AND MY OWN SEAL SAID NO CLASS COULD REACH IT.** Two of nine classes reddened `test/cosim/` with `DEFECT: frame 0: decision mismatch (ours=discard, theirs=accept)`. **The ground was one measurement one measurement wide**: a census of start-character placements true of `test/xgmii_rx_64/` was relied on as if it were true of every producer that drives the DUT, and `test/cosim/ours_run.ml` is a second producer that presents its start character on **cycle 0** — the one placement the whole argument assumed did not exist. **Both kills and both qualifications stand** (`test/cosim/` contributes zero units), the manifest is not at fault, and **the repair is a standing rule filed at §7 beside bar 4: any universal quantified over "the bench" is measured over every producer that drives the DUT, or it is quoted with the producer set it was measured over** — §0.1's rule meeting its second dimension, domain rather than SHA. **And its positive half is worth more than its negative one: this is the FIRST TIME IN THIS PROGRAMME THE ANCHOR HAS CONVICTED A MUTANT.** It is blind to seven of nine and **sighted for exactly the two whose defect lands on a start character sitting on a reset-release cycle** — a placement the M03 bench does not contain at all. **It does not discharge the anchor**, which stays undischarged with REQ-901's class list unchanged. **(6) `FINDING WO-0077-N2` (MAJOR, mine) — my IC-N1 rule is wrong in BOTH directions and my own two-direction check caught it.** It **over-selected** — seven cells its instance list named came back green, including five family-B units and `M03-N2`'s two zero-delivered members — and it **under-selected** the one unit that shares `M03-N1`'s own geometry: **`M03-E4 (lane 0)`**, whose `?word_at` construction places an `/E/` in the **same input word** as its own frame's `/T/`. **Worked here from the bench's own constants rather than carried from the verdict: at lane 0 the `/T/` is at octet time 80 (cycle 10, lane 0) and the `/E/` at 85 (cycle 10, lane 5) — the same word; at lane 4 they are at 84 (cycle 10, lane 4) and 89 (cycle 11, lane 1) — different words.** So **`M03-E4` drives two different geometries, one per member, only the lane-4 one is the separate-word gap its Stimulus cell advertises, and this bench contains TWO independently constructed carriers of the two-events-in-one-input-word discrimination.** `M03-N1` is not the sole instance of its geometry and no packet may claim it is. **`FINDING WO-0077-N1`** — the `D-N1c` dichotomy was not exhaustive, both sealed cells were missed, and the miss was **pre-declared before any transient was cut and scored against me**. **(7) `DECLARATION K-D1` MEASURED AND FILED AS U-5**, the fifth structural limit and a fourth kind: not bench-side ordering (U-1, U-2), not design-side grammar (U-3), not the shape of the observable (U-4), but the **placement of the stimulus** — *a row whose window covers an interval in which a conformant design has nothing pending and nothing arriving can be convicted only by a defect that carries an observable into it, never by one that merely fails to suppress*. Measured: `M03-K1` green under all five fail-to-suppress classes, red under the one that carries. **(8) `FINDING J-1` IS CLOSED IN BOTH HALVES.** Its second half — REQ-810's first sentence having no `Kills` cell at `M03-J1` — was carrier-less until an `AP-` round was scheduled; one was, and **the cell is written here, derived from REQ-810's own first sentence with the already-landed `IC-J1` kill cited as retrospective corroboration and not as the derivation**, and bounded so that paying the debt does not enlarge the row past what `DECLARATION J-D1` (U-4) says its silence can see. **(9) `RV-0075`'s THREE §7 PLACEMENTS ARE LANDED** beside bar 4 — `FINDING RV-0075-1`'s printer repair (carrier: the next commit opening `test/cosim/**`), `FINDING RV-0075-2`'s carried-antecedent repair and its latent false positive (carrier: the work order that lifts `WO-0075` §8 item 1), and bar 4's reconfirmation at the anchor's first real timing execution. **No bar is lifted and no bar's wording changes.** **(10) NO ROW, NO STATUS, NO COUNT AND NO §6 CELL MOVES: 78 rows, 62 ASSERT, 7 NO-ASSERT, 4 NO-STIMULUS, 4 STRUCTURAL, 1 GAP**, and the row-discharge census is unmoved at **62 of 62** with inventory **59** / **139**, re-measured by `bash tools/dv_checks.sh` at this tree before and after the edit, because no unit and no title moved. **`QUALIFIED` is not a status** (`J-dv_lead-0109`). **(11) THREE THINGS THIS ROUND DELIBERATELY DOES NOT DO**: it opens no `SO-` and none is offered; it pays no carrier outside this file — `FINDING K-1`'s message repair (`test_m03_k.ml`), `RN-6`'s `docs/**` resolve-check (`tools/dv_checks.sh`) and `FINDING RV-0075-1`'s printer (`test/cosim/**`) all stay owed to the first commit that opens their path, because **a plan round is not where a carrier is improved** (`J-dv_lead-0112`); and it takes no lessons harvest, which falls **at** the `SO-`, spans from my last harvest, and now holds **nine** banked candidates — the ninth banked at `J-dv_lead-0147` and unminted: *a universal asserted over one stimulus producer is measured over every producer that drives the unit under test, or the invisibility argument it grounds is true only where it was measured.* | dv_lead, `J-dv_lead-0148` |
| 2026-08-10 | **The `AP-` round of the differential co-simulation's Stage 2 — SIX RULED ITEMS AND NOTHING ELSE MOVES; this commit is where `STAGE 2 — COMPLETE` is written, and the flip carries no new evidence because none is owed** (`WO-0078` §14, `RV-C4` §12 at `e51ca52`, which ruled this round's scope, **pre-authorised** the flip and bound it to be dispatched with nothing in front of it; `J-dv_lead-0159`). **NO ROW ADDED, NO ROW CONVERTED, NO STATUS MOVED, NO COVERAGE-MAP LINE CHANGED: 78 rows, 62 ASSERT, 7 NO-ASSERT, 4 NO-STIMULUS, 4 STRUCTURAL, 1 GAP** — re-measured at this tree, before and after the edits, by a **status-cell pass** over every row table (the count is taken from the file, never carried forward; the mechanised form of this pass is `DVC-1a`, commissioned at §0.1 and **still not built**, which is why the pass is described rather than quoted as a one-liner — a table-parsing command cannot be written inside a table cell without the escaping changing it, and a command that does not reproduce is worse than a described method). **The row-discharge census and the bench inventory are NOT re-measured this round and are therefore NOT quoted as current**: no unit, no title and no line of `test/**` moves here, and their last measurement is `beb9c2a`'s (62 of 62, inventory 59 / 139) — quoted with its SHA per §0.1 rather than carried forward as a present-tense figure. **(1) §7 BAR 1 GAINS FOUR LIFT CELLS, one per stimulus class, at run **and** job ids, each carrying its own *"does NOT anchor"* list in the same cell**: class 2 (64-octet good-FCS, **lane-4** start on the reset-release cycle) at `31096150983` / `92598555141`, five observations; class 3 (**two** 64-octet good-FCS frames at the **minimum** IFG, across the re-arm path) at `31103977231` / `92624287637`, and the cell records that the class cost **three landings and two voids**, neither of which banks anything; class 4 (**bad FCS**, lane 0, **delivered rather than dropped**) at `31108528759` / `92639903296`; class 5 (**nonstandard preamble filler and SFD**, `A1…A7`, lane 0, **accepted rather than rejected**) at `31431123022` / `93594520735`, **one observation and the cell says so**. **All four at branch α. Class 1 was lifted at Phase 1 and is NOT re-lifted** — its re-observation at `31431123022` is recorded as a re-observation, because a re-observation does not renew a lift. **Each cell states which instrument discharges the ABSOLUTE half — `M03-A2`, `M03-L1` (with `M03-D3` beside it), `M03-D1` (with `M03-D2`), `M03-B1` — and which discharges the AGREEMENT half, this lane, and α never stands for both** (`FINDING RV-0078-S2-2`'s shape written into the cells; **its carrier is still the `SO-` round and this does not re-home it**). **No cell is in module form** and case numbers are recorded as **off by one** from class numbers. **(2) §7 GAINS BAR 4's PRECONDITION RECORD, AS MOVEMENT INSIDE A STANDING REFUSAL AND NOT AS A LIFT**: precondition **(1) stimulus** is **MET for `error_bad_fcs` at C3 and for no other strobe**; **(2) mapping** is UNMET **and C3 made it harder** — the reference raises `error_bad_frame` on a bad FCS where §9 gives that event to `error_bad_fcs` alone, so a name-keyed comparison would red a conformant M03; **(3) grammar** is UNMET, the canonical form has no strobe field and the reference's strobe outputs are tied off. **The bar stands, and what changes is the REASON it must give: for `error_bad_fcs` the mapping and the grammar; for every other strobe still the stimulus.** **(3) BARS 2 AND 3 ARE RESTATED AS UNMOVED, and bar 2's permanence is stated as SPECIFICATION** — REQ-901 classes (e)/(f) mean a co-simulation result is never an admissible anchor for REQ-107 or REQ-108, which no stage of any phase can alter — **while bar 3 is unmoved for a reason stronger than "not yet run"**: `WO-0075`'s lane landed and ran green at five classes, but it **asserts our side against SPEC-M03 §6.1's own formula** and **reports the reference's cycles as data never adjudicated**, and REQ-901 excludes cycle alignment **by name**, so a cross-side timing comparison is **BARRED, not un-built**. **(4) `FINDING RV-0078-S2-13`'s RULE IS FILED AT §7 BESIDE `FINDING WO-0077-A1`'s CENSUS RULE, in its polarity-bearing form** — a capability claim states the set it was measured over **and its polarity does not change that obligation**; a claim that a mechanism does not exist is measured over **every landed construction of the thing in question**. §0.1 makes a set claim carry its **SHA**, `WO-0077-A1` its **domain**, and this its **POLARITY**. **(5) THE `M03-B1` ↔ CLASS 5 CROSS-REFERENCE IS WRITTEN IN BOTH DIRECTIONS** — §7's class-5 cell and §4.B's `M03-B1` Kills cell — **each bounded by `RV-C4GAP` §5's four prohibitions quoted into the cell**, so the link can never be read as `M03-B1` being co-sim-anchored, and each stating the two axes on which the instruments differ (B1 drives **both** start lanes and asserts **absolute figures**; C4 drives **lane 0** and asserts **agreement**). The two constructions are **independent**: `0xA0 + lane` through `Bench.run`'s `?word_at` at `test_m03_b.ml:28`, and `0xA0 lor d` through the second producer's own lane arithmetic at `test/cosim/stimulus_gen.ml`. **(6) §0.1's RE-MEASURE-AT-CITATION RULE IS OBEYED ON BAR 1's OWN PROSE SET-CLAIM, AND THE CLAIM SURVIVES.** *"No row benched to date is gated by this bar"* is **TRUE at `e51ca52`**, measured over **both** producers by five static commands recorded with the claim: the model's oracle join `Injection.expected_strobes` has **ZERO** call sites outside `test/xgmii/`; `Injection.outcomes` has **17** call sites in **6** files, every read consumed in place against an in-file hand-derived local whose failure branch is `fail_cross`; **ZERO** let-bindings of an outcome field exist, so no model value can escape into an expectation; family **I** uses **X-1(i) only**; and the co-sim producer's single mention of the model is a **docstring saying it is absent**. **Its stated GROUND was stale and is repaired at the measurement rather than at the sentence** — families G, H and N call the model and postdate the sentence, and they are inside the claim for the structural reason, not the enumerated one. **THE CONSEQUENCE, ROUTED HERE BY `RV-C4` §13 ITEM 4: the `SO-xgmii_rx_64.md` IS NOT BLOCKED ON CO-SIM STAGE 3**, and the programme's shortest path to sign-off is `AP-` → the error-class sweep → `SO-`. **What the four lifts change today is NOTHING RETROSPECTIVE**: bar 1 gates no row at this tree, so the lifts buy a **prospective** ungating and the `SO-`'s right to write the per-class table without a bar over it. **(7) FOUR THINGS THIS ROUND DELIBERATELY DOES NOT DO**: it stages nothing outside `test/attack_plans/**` except the packet's `State` field and my journal; it **opens no `SO-`** and offers none; it **edits the CD nowhere** — the **seventh** consecutive refusal, on §10.7 item 3's own ground that a result is not a domain instance; and it **runs nothing** — no `dune`, no `iverilog`, no CI — so every figure above is either **lifted from a landed verdict at its own run and job id** or **re-measured by a static read at this tree**, the five §7 re-measurement commands printed beside their results and the row counts taken by the status-cell pass described above. **The lessons harvest still falls at the `SO-`**, spans from my last harvest, and this round banks **one** candidate — `FINDING RV-0078-S2-13`'s portable form, banked at `J-dv_lead-0157` and filed as a rule at §7 here. **The running TOTAL is deliberately not quoted**: my own journal's recent notes disagree about it — eleven labelled candidates `LH-cand-A` … `LH-cand-K` exist alongside a note calling a later one *"a tenth"* — and a count is a set claim under §0.1, so it is **enumerated and reconciled at the `SO-`'s harvest**, which is the document that owes the tiling, rather than propagated here as a figure nobody has re-measured. | dv_lead, `J-dv_lead-0159` |
