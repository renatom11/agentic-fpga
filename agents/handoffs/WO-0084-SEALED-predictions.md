# WO-0084 SEALED: dv_lead's frozen predictions for the M04 mutation campaign

> **SEALED. The seeding seat must not open this file until all 13 defect diffs
> are committed** — this file, this packet's §3.3 facsimile form, and
> `WO-0084`'s act-2 allowlist together, and absolutely.
>
> **The reason is written here rather than only in the commissioning packet,
> because the seat being blinded is the seat that would open this file** (the
> better of the two placements `docs/PROCESS.md` §3.3 measures, adopted here):
> a seeder who knows the predicted kill set can choose the defect site that
> satisfies it, and the campaign then *confirms* the prediction instead of
> *testing the suite*. The hazard runs **one way**, against the seeder. It is
> not a blind against the seat that froze this file, and it is not a blind
> against the operating seat, which authors none of the evidence it produces.

- **State**: **FROZEN — unopened.**
  **This is the seal's single mutable line, and this header says so** (WO-0084
  act 1's own instruction). **And this seal undertakes not to mutate it**: the
  later practice `docs/PROCESS.md` §3.3 `[B.11·8]` measures over the record's
  thirteen seals — nine of which carry a `FROZEN` line that was never edited,
  six of those scored without one byte of the seal being touched — is *strictly
  stronger*, because with nothing to edit the immutability check is
  **`git diff` against the freezing commit is empty, full stop**, and requires
  no judgement from the party running it. The unsealing is therefore recorded
  in `WO-0084`'s own Return/verdict log at act 4, **not here**. If a later seat
  does flip this line, the flat check degrades to *"empty except this line"*,
  which is the weaker instrument by that document's own measurement, and the
  degradation is on the record before it could happen.
- **Frozen against**: **`6d92bf9`** —
  `6d92bf99bdd84788bab87e0c7fe6bb720a4682bf`, stated as a hash and not as a
  relation to a commit that does not exist yet. I can state it because it is an
  **existing** commit: it was `HEAD` with a clean tree at this round's precheck
  (`git rev-parse HEAD`, `git status --porcelain` empty), and it is the base the
  commissioning dispatch named. **This construction deliberately avoids the
  ambiguity `FINDING WO-0073-M1` opened** (the M03-era seals disagree with
  `docs/PROCESS.md` §3.3's facsimile about whether *"frozen against"* means the
  staging commit or its parent): here it means neither — it means a **named
  prior commit**, and the seal's own commit will be a descendant of it.
  **Every defect diff of this campaign is rendered against
  `libs/hardcaml_ethernet/src/xgmii_tx_64.ml` at `6d92bf9`.** The seeding seat
  quotes the hash it applied to, and any disagreement is a finding **before**
  the campaign runs.
- **Frozen by**: dv_lead, `J-dv_lead-0195`, **before any defect diff existed**,
  in the commit that stages this file — R-SEAL-1 (PROTOCOL §10, ADR-0016).
- **Second copy**: the **whole frozen content** — every class, its predicted
  disposition, its killing unit(s) by name and its REQUIRED cell's message
  text — is restated in `J-dv_lead-0195`. This is **more** than the M03-era
  practice duplicated (that duplicated the class → row mapping and neither the
  strings nor the matrices); the dispatch asked for the frozen content and the
  frozen content is what is duplicated. Either copy convicts an edit to the
  other.

## 0. Integrity note — why this is written twice

Everything committed here is also committed, in substance, in
`J-dv_lead-0195`. Two independent append-only copies of a freeze is not
redundancy: the journal is append-only by a mechanically enforced rule
(PROTOCOL §5 R3) that this packet file is **not** covered by, so if this file
is later edited to fit a result, the journal exposes it — and the journal
cannot be edited at all. I have been falsified on a sealed prediction before
in this programme's record, and the entire value of that episode came from the
prediction being un-adjustable afterwards.

---

## Standing rules

Inherited from the M03-era seals, each restated rather than cited, because a
seal that only points at its rules will be read as not having them.

1. (`RV-0055` `FINDING G-1`) Every sealed cell resting on a claim about the
   DUT's state cites the stimulus fact that establishes that state, or is
   marked **UNWORKED**.
2. Every message below is **the first assertion to speak**, derived from the
   unit's committed control flow and source order at `6d92bf9` — never from
   what the row is *"about"*. §2 states the order every cell depends on, and
   §2.2 states the one structural fact that makes the difference between the
   two at this port larger than it was at M03.
3. A quantity the specification does not fix, or that the mutant owns, is
   sealed as an **inequality with a named direction**, never as a value. §9
   collects them.
4. A cell resting on **two events being distinguishable** states the convention
   by which they are distinguished; where the convention cannot distinguish
   them the cell is **GREEN BY BLINDNESS** and a green there is **not**
   evidence the class fails to reach it.
5. (`FINDING WO-0066-3`) Outside the cells this seal works one by one, a
   class's predicted red set is stated as a **RULE in stimulus terms**, with
   worked instances named beneath it. **Where the rule and the instance list
   disagree, the RULE governs.**
6. (`FINDING WO-0074-S1`) **Every rule states its complete conjunct list** —
   including every gate the rendering may **not** remove — so no rule describes
   a class the packet forbids.
7. (`WO-0076` standing rule 7) A cell is scored as **qualifying a row** only if
   the message that speaks is an assertion of **that row's own observable**. A
   message from a standing-instrument arm, from a bench-side stimulus check or
   from another family's unit qualifies the row **not at all**, however red.
   **§2.2 is why this rule does more work at M04 than it did at M03**, and §3.3
   is where it costs two rows their qualification.
8. (`FINDING K-1`) Where a scored cell's message contains **no observed data**,
   this seal says so at the cell, names every other class that reaches the same
   cell, and states what — other than the branch identity — distinguishes them,
   **including "nothing"**. §7 is that enumeration.
9. **NEW THIS ROUND, and it is what §0.1 forces**: no cell of this campaign is
   scored on a **workflow-run or job conclusion**. Every cell is scored on the
   named **step** and on the failing unit's own message text. A seal whose
   scorer may read a job conclusion has handed the scorer a signal that is red
   at the base state.

---

## 0. The denominators and the censuses, re-measured at the freeze

Measured at this tree by the command quoted beside each figure, **not carried
forward** (`AP-M04` §0.1(i)):

```
  grep -rh --include=*.ml 'let%expect_test' test/ | grep -c .      # 167
```

```
    3  test_m04_a.ml     4  test_m04_b.ml     5  test_m04_c.ml
    3  test_m04_d.ml     2  test_m04_e.ml     3  test_m04_f.ml
    6  test_m04_g.ml     1  test_m04_scaffold.ml
  ---
   27  test/xgmii_tx_64/ (the M04 bench: 26 row-bearing units + U1, the
                          scaffolding smoke unit, which carries no M04- row id)
  167  test/ (repository-wide, OCaml units)
  140  non-M04
```

**The 140 non-M04 units, by what a red there would mean:**

| set | units | a red there means |
|---|---|---|
| `test/monitors/` 38, `test/xgmii/` 25, `test/golden/` 11, `test/axi64_probe/` 3, `test/xgmii_probe/` 3 | **80** | **impossible behaviourally, and the ground is structural, not statistical**: none of these five libraries depends on `hardcaml` or on `libs/**` at all — `test/xgmii/dune` says so in terms (*"No Hardcaml dependency, on purpose … libs/** is not depended on and was not opened"*) — so no RTL mutation can move them. A red here is a **scope finding** or a harness defect, never a behavioural result |
| `test/xgmii_rx_64/` 59, `test/hardcaml_ethernet/` 1 | **60** | these depend on `hardcaml_ethernet` and so **fail to build** if the mutant does not compile — a **build finding**. Behaviourally they are blind: they elaborate `Xgmii_rx_64` and `Word_counter`, and no diff to `xgmii_tx_64.ml` reaches either |
| `test/cosim/` | **0 units** | the differential lane is a **receive**-side harness. `AP-M04` §7.1's **BAR T1** is SHUT — no transmit reference is vendored, there is no transmit harness, and REQ-901 declares no divergence class at this boundary — so this lane is **blind by construction** to every class below, and a green there is worth nothing in either direction (standing rule 4) |

**MUST-STAY-GREEN outside the M04 bench, every class, every branch: 80
structurally blind + 60 build-level.** A behavioural red anywhere in the 140 is
a **scope finding against the manifest**, adjudicated at §8 disposition 4 and
never scored as a kill.

### 0.1 The base state's own red — and why the job conclusion is not this campaign's signal

**This subsection is the single most load-bearing thing in this seal, and it
exists because it can only be written before the runs.**

CI at `6d92bf9`, read at source from the job record by step **name, number and
status** — not from a badge, not from a summary:

```
  run 31577965739  build          job build  (id 94054290693)   conclusion FAILURE
      step  5  Build                                                     success
      step  6  Run tests (expect tests, waveform snapshots)              success
      step  7  Generate RTL                                              success
      step  8  REQ-902 two-run determinism (second process, scratch cwd) success
      step  9  Verify nothing was left unpromoted or non-deterministic    success
      step 10  DV mechanical checks (C-9 record-vs-appendix, X-9 …)      FAILURE
      step 11  Abort-bit availability quantifier (C-37/ADR-0012)         skipped
  run 31577965739  job cosim (id 94054290782)                 conclusion success
  run 31577965794  journal-check                              conclusion success
```

**The DV suite is green end to end at the base**: steps 5, 6, 8 and 9 are all
`success`, the co-simulation job is `success`, and `journal-check` is
`success`. **The `build` job's conclusion is nevertheless `failure`**, and the
whole of the reason is step 10, whose failing limb is reproducible from a
checkout at this commit:

```
  bash tools/dv_checks.sh
  #   === docs/** citation resolve-check (RN-6) ===
  #   BROKEN   agents/handoffs/WO-0084_m04-mutation-campaign.md
  #            cites <docs/reports/audit/ + the manifest directory name>
  #            (the path is ELIDED here, and only here: spelling it would add a
  #             SECOND undeclared broken citation and worsen the very red this
  #             block exists to name. The elided token is WO-0084's own §act-2
  #             directory, verbatim in that packet.)
  #            nothing git carries resolves it …
  #   …  1  UNDECLARED broken citations
  #   === docs/** citation resolve-check: FAILED ===
  #   dv_checks: at least one check FAILED
```

Every other limb of step 10 passes (`check_records_vs_appendix` 23/23,
`check_emitted_verilog` 5/5, `precompile_check` 31+12 units 0 errors). **The
sole undeclared item is `WO-0084`'s own forward citation of the mutation
directory the seeding seat has not created yet.** It has nothing to do with the
DUT, nothing to do with the suite, and nothing to do with any class below.

**Four consequences, frozen here:**

1. **Every `mut/wo-0084-<class>` ref inherits this red.** Each ref is
   `6d92bf9` + one unified diff to `libs/hardcaml_ethernet/src/xgmii_tx_64.ml`;
   none of them creates the manifest directory under `docs/reports/audit/`; so **all 13
   refs will report `build` job conclusion `failure` — including a class that
   survives, and including a class whose diff does nothing at all.**
2. **A scorer reading job conclusions would therefore score 13 of 13 "kills"
   off a citation checker.** That is not a hypothetical failure mode; it is the
   default one, and it is why standing rule 9 exists. **The campaign is scored
   on step 6, `Run tests (expect tests, waveform snapshots)`, and on the
   failing units' own message text — never on the job.**
3. **The red is transient and its cure is act 2's own commit.** Once the
   auditor commits the manifest under `docs/reports/audit/`, the
   citation resolves and step 10 goes green *on the branch*. **The refs do not
   inherit that cure**, because they are rendered against `6d92bf9`, which
   predates it. So a ref built on the seal's base will show step 10 red while
   the branch shows it green — **an asymmetry a scorer could read as a defect
   signal, and it is not one.** If the operating seat instead rebases a ref
   onto the manifest commit, step 10 will be green there and the *base has
   changed*, which is a finding under §8 disposition 6, not a convenience.
4. **A step-10 red is not evidence about any class, in either direction, and a
   step-10 GREEN on a ref would be evidence that the ref is not the ref this
   seal was frozen against.**

### 0.2 The stimulus censuses this campaign's rules quantify over

Measured at this tree from the units' own call sites, not from recollection:

```
  cfg_ifg          12 on every cycle of every unit (Bench.create; no unit drives another value)
  cfg_tx_enable     1 on every cycle of every unit
  clear             1 on cycle 0 alone (Bench.create's reset pulse), 0 thereafter, every unit
  stall schedules   6 units drive Bench.run_scheduled: U22, U23, U24, U25, U26, U27
  hold > 1          1 unit: U24 (M04-G3), hold = 4. Every other stall has hold = 1
  multi-frame runs  8 units: U17, U18, U19, U20, U21, U25, U26, U27 (+U23's resumed tail)
  W = 1 frames      P in {1, 8} at U16; B in {1, 8} at U21; P = 1 at U5, U7, U10, U11
  tkeep < 0xFF      every frame whose P mod 8 <> 0 — i.e. every driven length except
                    P in {8, 16, 64}
```

**`cfg_ifg` = 12 everywhere is a conjunct of two rules below (IC-9, IC-10) and
is the whole ground of IC-10's predicted SURVIVE.** `AP-M04`'s row `M04-F3`,
the `cfg_ifg` parameterisation, is **outstanding**; no committed unit drives
any other value, and this seal may not quantify over one.

---

## 1. The unit inventory, the row prefixes, and where each unit's standing instruments sit

Every message below is `<row prefix>: <body>`, composed by each file's own
`let fail row msg = failwith (String.concat [ row; ": "; msg ])`. The prefixes
at `6d92bf9`, character-exact, with the position of the standing-instrument
call — **the column that decides which message speaks**:

| unit | file | row prefix, character-exact | standing instruments |
|---|---|---|---|
| U1 | `test_m04_scaffold.ml` | `U1 scaffold` | **none** (drives no frame) |
| U2 | `test_m04_a.ml` | `M04-A1, M04-A2, M04-A5` | **LAST** |
| U19 | `test_m04_a.ml` | `M04-A3` | **FIRST** |
| U27 | `test_m04_a.ml` | `M04-A4` | **FIRST** |
| U3 | `test_m04_b.ml` | `M04-B1` | **LAST** |
| U4 | `test_m04_b.ml` | `M04-B2` | **LAST** |
| U5 | `test_m04_b.ml` | `M04-B4/B5 (P=<p>)`, 8 members | **LAST**, per member |
| U20 | `test_m04_b.ml` | `M04-B3 (long -> short)`, `M04-B3 (short -> long)` | **FIRST** |
| U6 | `test_m04_c.ml` | `M04-C1, M04-C6` | **LAST** |
| U7 | `test_m04_c.ml` | `M04-C2 (P=<p>)`, 4 members | **LAST**, per member |
| U8 | `test_m04_c.ml` | `M04-C3` | **LAST** |
| U9 | `test_m04_c.ml` | `M04-C4` | **LAST** |
| U10 | `test_m04_c.ml` | `M04-C5 (P=<p>)`, 3 members | **LAST**, per member |
| U11 | `test_m04_d.ml` | `M04-D1, M04-D2, M04-D4, M04-D5 (P=<p>)`, 8 members; then `… (P=60 contrast, M04-D4)` and `… (P=64 contrast, M04-D4)` | **LAST**, per member |
| U12 | `test_m04_d.ml` | `M04-D3` | **LAST** (both runs) |
| U13 | `test_m04_d.ml` | `M04-D6` | **LAST** |
| U14 | `test_m04_e.ml` | `M04-E1, M04-E2, M04-E3, M04-E5 (P=<p>)`, 8 members | **LAST**, per member |
| U15 | `test_m04_e.ml` | `M04-E4` | **LAST** |
| U17 | `test_m04_f.ml` | `M04-F1` | **FIRST** |
| U18 | `test_m04_f.ml` | `M04-F2 (P1=<p>)`, 8 members | **FIRST**, per member |
| U26 | `test_m04_f.ml` | `M04-F6` | **FIRST** |
| U16 | `test_m04_g.ml` | `M04-G9 (P=<p>)`, 2 members | **FIRST**, per member |
| U21 | `test_m04_g.ml` | `M04-G10 (a) (B=1)`, `(a) (B=8)`, `(b) (B=9)`, `(b) (B=16)` | **THIRD** (after the route precondition and the named silence) |
| U22 | `test_m04_g.ml` | `M04-G5` | **FIRST** |
| U23 | `test_m04_g.ml` | `M04-G1, M04-G2, M04-G8` | **FIRST** |
| U24 | `test_m04_g.ml` | `M04-G3` | **FIRST** |
| U25 | `test_m04_g.ml` | `M04-G6` | **FIRST** |

**Twelve of the twenty-six row-bearing units call their standing instruments
FIRST.** That single column is what §2.2 turns into this campaign's central
prediction, and it is measured here rather than asserted.

**Encoding note.** Bodies below are the OCaml literals as the runtime composes
them, with line-continuation backslashes elided (as the compiler elides them).
Integers are `Int.to_string`, i.e. **decimal**; list separators are `"; "`
(`String.concat ~sep:"; "`). Every body in this seal is ASCII except where a
quoted body itself carries `§` or `—`, which are the source's own bytes.

---

## 2. The two instrument kinds, and the shadowing law this port has and M03 did not

### 2.1 The kinds

Only **DUT-observable** assertions can convict a design. The **bench-side
derivations** (`run_lengths`' `P-ACCEPT`, `run_stream`'s `SP-1`/`SP-2`,
`run_scheduled`'s `ST-1` … `ST-4`, obligation 6's source-contract check,
`M04-C3`'s assertion 0, `M04-D3`'s assertion 1, `M04-D6`'s anti-vacuity
assertion 2, every derived cycle constant) are evaluated on the bench's own
model of the run and **no RTL mutation can move them** — a red at one of them
is a finding against the bench or against the operator, never a kill (§8
disposition 5).

### 2.2 The shadowing law — measured, and the reason standing rule 7 costs rows here

At M03 the standing protocol monitor judged an `Axi64` stream. **At M04 the
standing wire decoder `Dv_xgmii.Tx_decoder` judges REQ-201, REQ-202, REQ-203,
REQ-204, REQ-205 and REQ-206 on every frame of every run**, and
`assert_instruments_clean{,_n,_scheduled}` runs its four checks in this fixed
order:

> **(i)** `Tx_decoder.is_clean` → `"<row>: wire decoder unclean:\n<report>"` →
> **(ii)** register the expected strobe events, then `Strobe_monitor.is_clean`
> → `"<row>: strobe monitor unclean:\n<report>"` → **(iii)**
> `high_cycles "error_underflow"` vs the expected count →
> `"<row>: error_underflow high for <n> cycles, expected <m>"` → **(iv)**
> conservation: the frame count, then the underflowed-position **list**.

**The consequence, frozen before any diff exists:** in the twelve units that
call this FIRST, a defect the decoder can see makes **(i)** speak and the
unit's own row assertions **never run**. Under standing rule 7 such a red
**qualifies the row not at all** — it is the suite killing the class through
obligation 1's standing instrument, which is a real kill and a real
measurement, and it is *not* evidence that the row's own instrument works.

**This is not a complaint about the bench; it is a prediction about the
campaign**, and §3.3 names the two rows it costs (`M04-B3` and `M04-G6`, under
IC-6) and the three it does not (because their own observable *is* the standing
instrument: `M04-G9`, and the strobe-pin half of `M04-G1`/`M04-G5`).

### 2.3 The decoder's four blind spots, measured from its own committed source

A class that the decoder cannot see is a class whose rows must speak for
themselves. Read off `test/xgmii/tx_decoder.ml` at `6d92bf9`:

1. **REQ-203 is judged as `n < 64` and nothing else** — the decoder's own
   `close_frame` violates only when the decoded frame is *shorter* than 64
   octets DA through FCS. **A frame that is too LONG is invisible to it.**
   (IC-2 and IC-3 both live here.)
2. **REQ-202 is judged as self-consistency** — the wire FCS against
   `Frame.fcs` of *everything before it on the wire*. **A design that corrupts
   the payload and then computes a correct FCS over the corruption passes.**
   (IC-2 and IC-3 again; `test_m04_d.ml`'s own header says this in terms.)
3. **REQ-204 is judged as `n < ifg`** — a gap that is too *large* raises
   nothing. (IC-9 lives here.)
4. **An underflowed frame's FCS and length are not judged at all** —
   `close_frame` returns early when `underflowed`. (IC-13's abort branch.)

---

## 3. The classes, the matrix, and what each kill qualifies

### 3.0 The unit of scoring, stated before any number

**The unit of scoring is the CLASS** (PROTOCOL §7 (b.1): *"the unit of this
record is the class, not the branch, ref or file that delivered it"*). Thirteen
classes; **one kill per class at most**, however many units redden. A class's
predicted reds across twenty units are **one** kill, never twenty. Per-row kill
claims live **inside** each class, at §3.3, and are scored separately from the
class's own disposition — a class may be **killed** while qualifying **no row**
(IC-6 is predicted to be exactly that).

**Derivation of the class list.** Thirteen classes, derived from the **34
discharged ASSERT rows** of `AP-xgmii_tx_64.md` — every row the suite claims to
kill something with — in my taxonomy and not the seeder's.

> **A count correction, made here because a seal may not carry a figure it has
> not measured** (`AP-M04` §0.1(i)). The commissioning packet and the dispatch
> both say *"39 discharged ASSERT rows"*. **The plan's own four absorption rows
> measure 39 rows DISCHARGED, of which 34 are ASSERT and 5 are NO-ASSERT** —
> 11+2 at `af06c62`, 10+2 at `aabae58`, 5+1 at `65ba148`, 8+0 at `91f005d`. The
> five NO-ASSERT rows are `M04-A5`, `M04-C6`, `M04-D5`, `M04-E5`, `M04-F5`.
> **A NO-ASSERT row claims no kill** — it is a prohibition on the suite, not a
> claim about the design — so **no defect class is derived from one, and none
> can be**: there is no assertion for a mutation to turn red. The campaign's
> denominator of claims is therefore **34**, not 39, and the difference is
> named here rather than absorbed. Cross-check: 34 ASSERT discharged of 58
> ASSERT total, 5 NO-ASSERT of 12, plus 6 NO-STIMULUS + 5 STRUCTURAL + 1 GAP
> undischargeable → 39 discharged, 43 outstanding, 82 rows. Closes.

| id | class — the transmitter behaves as if … | derived from the Kills cells of |
|---|---|---|
| **IC-1** `PREAMBLE-WORD` | … the preamble word's octets are not REQ-201's literal `[0xFB; 0x55 ×6; 0xD5]` in lane order | `M04-A1` |
| **IC-2** `TKEEP-WHOLE-WORD` | … `tkeep` is ignored on the `tlast` word: all eight octets reach the wire | `M04-B2`, `M04-C4` |
| **IC-3** `PAD-TO-64` | … REQ-203's pad target is **64** octets rather than 60 | `M04-C1`, `M04-C2`, `M04-C5` |
| **IC-4** `PAD-OUTSIDE-CRC` | … the CRC closes at the `tlast` word and the pad is appended after it | `M04-C3` |
| **IC-5** `FCS-VALUE` | … the four FCS octets are not the REQ-305 value in REQ-202's wire order | `M04-D1` |
| **IC-6** `CRC-NOT-RESEEDED` | … the CRC register is not re-seeded between frames | `M04-B3`, `M04-G6` |
| **IC-7** `TERMINATE-LANE-0` | … the terminate character always lands in lane 0 of the word after the last FCS octet | `M04-E1`, `M04-E3` |
| **IC-8** `FILL-CONTROL-ONLY` | … fill lanes get the control bit set over whatever data was underneath, not `/I/`'s value | `M04-E2` |
| **IC-9** `GAP-AFTER-CONVENTION` | … the gap is twelve idle octets **after** the terminate character (§0.3's rejected reading) | `M04-F2` |
| **IC-10** `ABORT-GAP-FROM-E` | … the abort gap is measured from the `/E/` character rather than from the `/T/` | `M04-F6` |
| **IC-11** `STROBE-AT-CONSEQUENCE` | … `error_underflow` pulses when the `/E/` word appears, not at REQ-206's pinned cycle | `M04-G2` |
| **IC-12** `STROBE-PER-MISSING-CYCLE` | … the underflow condition is re-evaluated on every withheld cycle, not once per frame | `M04-G3` |
| **IC-13** `QUALIFIER-OMITTED` | … REQ-206's *"before it has accepted that frame's `tlast` word"* qualifier is absent | `M04-G9`, `M04-G10` |

### 3.1 The predicted dispositions

`R!` = REQUIRED red **and scored**, the class's killing cell. `G!` = a
**load-bearing** required green — the cell carries a measurement and a red
there changes what may be claimed. `M` = a predicted red arriving through a
standing-instrument arm, qualifying **nothing** (standing rule 7). `r` =
predicted red by the class's own rule, UNWORKED or worked-but-unscored,
contributing **zero** kills. Anything off-pattern is a **finding**.

| class | disposition | killing unit(s), BY NAME | kills |
|---|---|---|---|
| IC-1 | **KILL** | `M04-A1, M04-A2, M04-A5` (U2) | 1 |
| IC-2 | **KILL** | `M04-B2` (U4); `M04-C4` (U9); `M04-D6` (U13) | 1 |
| IC-3 | **KILL** | `M04-C1, M04-C6` (U6); `M04-C2` (U7); `M04-C5` (U10) | 1 |
| IC-4 | **KILL** | `M04-C3` (U8) | 1 |
| IC-5 | **KILL** | `M04-D1, M04-D2, M04-D4, M04-D5` (U11) | 1 |
| IC-6 | **KILL — qualifying NO ROW** | every multi-frame unit, all through arm (i) | 1 |
| IC-7 | **KILL** | `M04-E1, M04-E2, M04-E3, M04-E5` (U14) | 1 |
| IC-8 | **KILL** | `M04-E1, M04-E2, M04-E3, M04-E5` (U14) | 1 |
| IC-9 | **KILL** | `M04-F2 (P1=64)` (U18), **and that member alone** | 1 |
| IC-10 | **SURVIVE** — branches α, β; **KILL** only under branch γ | (α, β: none) | 0 |
| IC-11 | **KILL** | `M04-G5` (U22); `M04-G1, M04-G2, M04-G8` (U23); `M04-G3` (U24); `M04-G6` (U25); `M04-F6` (U26); `M04-A4` (U27) | 1 |
| IC-12 | **KILL** | `M04-G3` (U24), **and that unit alone** | 1 |
| IC-13 | **KILL** | `M04-G9` (U16); `M04-G10` (U21) | 1 |
| | | **campaign maximum** | **12 of 13** |

**The campaign's predicted score is 12 kills of 13 seeded classes**, with
IC-10 predicted to **survive on a named ground** (§6). A seal that predicts
only kills has predicted nothing that can fail; this one has one cell whose
whole content is a claim that my own attack plan names a design its own
stimulus cannot reach.

### 3.2 The rules, with their COMPLETE conjunct lists (standing rule 6)

| class | RULE — the class reddens a unit iff … | conjuncts the rendering may NOT remove |
|---|---|---|
| **IC-1** | … the unit reads the preamble word's octets or control field, **or** calls a standing-instrument arm on a run containing a frame | the start character's lane and cycle (lane 0 at `C+1`); the frame's octet placement; every FCS, pad, gap and terminate behaviour |
| **IC-2** | … the unit drives a frame whose `P mod 8 <> 0` **and** reads the wire at or after that frame's `tlast` word's own octets | the `tkeep = 0xFF` path entire; the pad target (60); the CRC's coverage of what is transmitted; the terminate arithmetic keyed on the emitted count |
| **IC-3** | … the unit drives a frame with `P < 64` **and** reads that frame's octet count, its FCS position, its terminate lane, or its decoded octets against an oracle | the `P >= 64` path entire (no frame of 64 or more octets may move); the FCS's coverage of the padded frame; the gap arithmetic; the strobe |
| **IC-4** | … the unit drives a frame with `P < 60` **and** reads that frame's FCS, directly or through a standing arm | the pad octets themselves (still 60, still `0x00`); the length; the terminate lane; every `P >= 60` frame |
| **IC-5** | … the unit reads any transmitted FCS, directly or through a standing arm | the covered range (DA through the last pad octet); the length; the pad; the terminate placement; the gap |
| **IC-6** | … the unit's run contains **two or more frames** and it reads the second or later frame's FCS, directly or through a standing arm | the **first** frame of every run (which must stay conformant, or the class is a different one); the length, pad and terminate arithmetic of every frame |
| **IC-7** | … the unit drives a frame whose `F mod 8 <> 0` **and** reads that frame's terminate lane, its terminate word's content, or its decoded octet count | the `t = 0` case entire (`F mod 8 = 0` must stay conformant — it is the case the class is *correct* at, and removing it destroys the class); the FCS value; the pad |
| **IC-8** | … the unit reads the **value** of a fill lane (not merely its control bit), **or** calls a standing arm on a run with a gap or a terminate word carrying fill | the terminate character's own lane and value; the start character; the gap's **length** |
| **IC-9** | … the unit reads a gap whose terminate lane is `t = 4`, **or** a start cycle downstream of one | `cfg_ifg` = 12 (a rendering that also changes the configured value is a different class); the gap at every other residue; the terminate arithmetic |
| **IC-10** | … the rendering changes the **word** in which the next start character falls after an abort **and** the unit reads that gap or a cycle downstream of it | `cfg_ifg` = 12; the `/E/` `/T/` word's own shape and cycle; the strobe's pin; every non-abort gap |
| **IC-11** | … the unit registers an `underflow_event`, **or** reads `error_underflow`'s high cycles | the `/E/` `/T/` word's cycle, lanes and values; the aborted frame's octet count; the gap; the **number** of pulses (still exactly one) |
| **IC-12** | … the unit drives a stall with `hold > 1` | the first pulse's own cycle (still the pin); the `/E/` word (still exactly one); the abort's wire shape; every `hold = 1` stall |
| **IC-13** | … the unit's run contains a frame whose first accepted word is also its `tlast` word (`W = 1`) | every `W >= 2` frame's silence; the wire shape of every frame; the pad, FCS, terminate and gap arithmetic |

### 3.3 The rows these kills qualify — and the reds that qualify nothing

| class | qualifies, on the row's OWN observable | reds that are blast radius and qualify nothing |
|---|---|---|
| IC-1 | **`M04-A1`**, on its preamble-content clause | **`M04-A3`** and **`M04-A4`** — both units call arm (i) FIRST, so the per-frame preamble comparison `M04-A3` was written for (*"with the frame index in every failure message"*) and `M04-A4`'s three-way equality **never run**. Also `M04-G6`'s own preamble check, shadowed the same way, and every other unit through arm (i) |
| IC-2 | **`M04-B2`** (its `tkeep`-mask clause), **`M04-C4`** (its poison scan), **`M04-D6`** (its oracle comparison) | `M04-C1`'s pad-region scan, `M04-C3`'s FCS comparison, `M04-B1`'s terminate-word control check, `M04-B4/B5`'s prefix comparison, `M04-D3`'s anti-vacuity cell, `M04-G9`'s pad scan — every one a real red at a real assertion, none of them a claim **this class** was seeded against |
| IC-3 | **`M04-C1`** (the pad target), **`M04-C2`**, **`M04-C5`** | `M04-B2`, `M04-B4/B5`, `M04-D1`, `M04-D3`, `M04-D6`, `M04-E1`, `M04-G9`, `M04-G10`, `M04-B3`, `M04-G6`, `M04-A4`, `M04-F1` |
| IC-4 | **`M04-C3`**, on assertion 1 — **and NOT on assertion 2**, which is the discriminating half (*"does NOT equal the unpadded oracle"*) and is **shadowed**, because assertion 1 fires first (§5.2) | `M04-D1`'s oracle comparison; every unit reaching arm (i) |
| IC-5 | **`M04-D1`** | `M04-C3`, `M04-D3`, `M04-D6`, `M04-G9`, `M04-E4`; every unit reaching arm (i) |
| IC-6 | **NONE, and this is the class's whole content.** `M04-B3` and `M04-G6` are the two rows that claim this kill — `M04-G6`'s own failure message says *"a design whose CRC register is not re-seeded after an abort would still pass the length and pad count and fail only here"* — and **both units call arm (i) FIRST**, so under this class **neither row's own comparison ever runs**. The suite kills the class; the two rows that claim it are not exercised by it | every multi-frame unit, all through arm (i) |
| IC-7 | **`M04-E1`**, and **`M04-E3`**'s `t = 7` half | `M04-B4/B5`, `M04-D1`, `M04-E4`, `M04-F1`, `M04-F2`, `M04-B3`, `M04-G10`, `M04-A4`; every unit reaching arm (i) |
| IC-8 | **`M04-E2`**, on its value clause — the row that exists because §6.3 item 2 makes `/I/`'s **value** normative | `M04-F1`'s assertion 5 (shadowed by arm (i)); every unit reaching arm (i) |
| IC-9 | **`M04-F2`**, at `P1 = 64` and nowhere else | — (the rule selects one member of one unit) |
| IC-10 | (α, β: none — the class is not observable at `cfg_ifg` = 12); (γ: **`M04-F6`**, and `M04-G1`'s and `M04-G3`'s gap assertions) | — |
| IC-11 | **`M04-G1`** and **`M04-G5`** and **`M04-G3`** and **`M04-G6`**, on their **pin** clause, which each unit's own `underflow_event` carries. **`M04-G2` is qualified on its first clause ONLY**: its own separation assertion (`test_m04_g.ml`'s assertion 3, *"read independently from `samples`"*) is **shadowed** by assertion 1 and does not run. The campaign therefore does **not** demonstrate that `M04-G2`'s discriminating instrument works, and says so before the run | `M04-F6`'s and `M04-A4`'s strobe registrations |
| IC-12 | **`M04-G3`**, on its *"exactly one pulse"* clause, carried by the monitor's exact-event-set check — which the unit's own comment names as *"the whole of the row's claim"*, so this arm **is** the row's own observable | — under branch α. Under branch β, every unit (§5.1) |
| IC-13 | **`M04-G9`** — its Observable cell is *"`error_underflow` is 0 on every cycle of the run"* and the unit's own comment calls `assert_instruments_clean` *"THIS ROW'S assertion rather than a background check"*, so arm (ii)/(iii) **is** this row's own observable and standing rule 7 is satisfied. **`M04-G10`** on its named-cycle silence, if the rendering strobes at the derived cycle (§4.13) | `M04-B4/B5 (P=1)`, `M04-C2 (P=1)`, `M04-C5 (P=1)`, `M04-D1 (P=1)` — all through arm (ii), none of them a `W = 1` row |

**Three rows are qualified by no class in this campaign and cannot be**:
`M04-D2` (corroboration only, by its own Kills cell — *"Nothing D1 does not
already kill"*), `M04-A5`/`M04-C6`/`M04-D5`/`M04-E5`/`M04-F5` (NO-ASSERT, no
assertion to redden), and `M04-A2` (§10 item 1).

---

## 4. The REQUIRED cells, verbatim

`<n>` marks a **mutant-owned** integer, sealed at §9 as an inequality; `<C>`
marks the run's own **first accepted cycle**, a base-owned constant identical
in the mutant and the base for every class here (none of them moves the
handshake — a class that does is a finding under §8 disposition 6). Every other
character is exact.

### 4.1 IC-1 — `M04-A1, M04-A2, M04-A5` (U2), the preamble word

Branch **α** (the octet pattern is wrong, the control marking is not):

```
M04-A1, M04-A2, M04-A5: preamble word data does not match [0xFB; 0x55 x6; 0xD5], lane 0 first
```

**Exact in every character; no integer.** Derivation: U2 filters the run's
start-carrying samples, matches the singleton, then checks the cycle (`C+1`,
unmoved), the start lane (`0`, unmoved), the control field (`0x01`, unmoved
under α), and only then the data. The four checks before it are all green under
α, which is what makes this — and not §4.1's β cell — the message that speaks.

Branch **β** (the whole preamble word is marked control, `xgmii_txc = 0xFF` —
`M04-A1`'s second named kill, *"which a checker reading only `xgmii_txd` cannot
see"*):

```
M04-A1, M04-A2, M04-A5: preamble word control = 255, expected 1 (bit 0 set, bits 1-7 clear)
```

**`255` is not mutant-owned: it is the branch's own definition.** A rendering
that sets some other subset of the control bits gives `<n>`, sealed
`<> 1`. `start_lane` still returns `Some 0` under β — lane 0 still carries
`/S/` — which is why the lane check does not precede this one.

### 4.2 IC-2 — three cells, one per qualifying row

`M04-B2` (U4), assertion 3 — **and not assertion 4, the poison scan the row is
"about"**, because the `tlast` word's kept octets and the first four pad octets
share the word at `C+4` and assertion 3 reads it first:

```
M04-B2: wire octets 20-23 (lanes 4-7 of C+4) are not all 0x00
```

`M04-C4` (U9), assertion 1 — here the poison scan **is** first:

```
M04-C4: poison 0xA5 present among wire octets 0..F-5
```

`M04-D6` (U13), assertion 1 — the all-zero frame's `tlast` word carries four
poisoned positions (`60 mod 8 = 4`), so the four octets at wire indices 60..63
are the poison rather than the FCS:

```
M04-D6: wire FCS octets = [165; 165; 165; 165], expected Frame.fcs(zeros_60) = [8; 137; 18; 4]
```

**Both lists are exact and neither is mutant-owned.** `165` is
`Bench.poison` = `0xA5`, a bench constant. `[8; 137; 18; 4]` is the REQ-305
oracle over sixty zero octets — `0x08 0x89 0x12 0x04` = `0x04128908`, the value
this unit's own promoted `[%expect]` block already carries at `6d92bf9`, and
independently confirmed here against `zlib.crc32(bytes(60))`. **A red at this
cell whose second list is not `[8; 137; 18; 4]` means the manifest reached the
DV machinery, not the design** — §8 disposition 4.

**This class's decoder blindness is load-bearing and is asserted, not assumed**:
the frame is *longer* than conformant and its FCS is computed over what was
transmitted, so §2.3 blind spots 1 and 2 both apply and
`Tx_decoder.is_clean` is **true** on every run of this class. **If any unit of
this campaign reports `wire decoder unclean` under IC-2, the rendering is not
this class** (§8 disposition 6).

### 4.3 IC-3 — `M04-C1, M04-C6` (U6), the pad target

```
M04-C1, M04-C6: wire octet count = 68, expected 64
```

**`68` is exact under the class as stated** (64 padded octets + 4 FCS), and is
sealed at §9 as `> 64` for any rendering that pads to some other target above
60. The two sibling cells, both exact:

```
M04-C2 (P=1): wire octet count = 68, expected F = 64
M04-C5 (P=1): wire octet count = 68, expected F = 64
```

**`M04-C4` (U9) is a load-bearing GREEN under this class** (`G!`): its scan
domain is `0 .. f-4` with `f` hard-coded to 64, its prefix check reads 20
octets and its pad-region check reads indices 20..59 — all of which are
conformant when the pad merely runs four octets further. **The row that exists
to catch a padding defect does not see this padding defect**, and that green is
a measurement this campaign makes on purpose.

**`M04-E1`'s sweep splits four-four and the split is the cell**: members
`P ∈ {60, 61, 62, 63}` redden (they are padded), members
`P ∈ {64, 65, 66, 67}` are **required green** (`P >= 64`, no pad, conformant).
**A red at `P = 64` or above means the rendering is not this class.**

### 4.4 IC-4 — `M04-C3` (U8), the pad's CRC coverage

```
M04-C3: wire octets (lanes 4-7 of C+9) do not equal Frame.fcs(pad_to_60(content))
```

**Exact; no integer.** And the cell this campaign does **not** reach is named
beside it: `M04-C3`'s assertion 2 — *"and does NOT equal the unpadded
oracle … this is what proves the row could have failed"* — is the row's
discriminating half, and under this class **it never runs**, because assertion
1 fires on the same sample. The row is qualified on assertion 1 and on nothing
else, and §10 item 4 carries the bound.

### 4.5 IC-5 — `M04-D1, M04-D2, M04-D4, M04-D5 (P=1)` (U11), the FCS value

```
M04-D1, M04-D2, M04-D4, M04-D5 (P=1): wire FCS octets = [<a>; <b>; <c>; <d>], expected Frame.fcs(pad_to_60(content)) = [135; 7; 193; 206]
```

**The expected list is exact and base-owned**: the REQ-305 oracle over
`pad_to_60 (content_octets ~p:1)` = `[1]` followed by 59 zeros, computed
independently here as `0xCE C1 07 87` → least significant octet first
`[135; 7; 193; 206]`. The observed four are mutant-owned and sealed **by
relation, not by value** (§9):

- branch **α** (wire order reversed): `[<a>;<b>;<c>;<d>]` is the exact
  **reverse** of the expected list — `[206; 193; 7; 135]` at this member.
- branch **β** (the finished-value convention dropped: the raw register rather
  than its final XOR): each observed octet is the expected octet **XOR 0xFF** —
  `[120; 248; 62; 49]` at this member.
- any other rendering: sealed only as `<> [135; 7; 193; 206]`.

**The remaining seven members' expected lists, sealed so the whole sweep is
checkable and no member can be quietly skipped** (decimal, least significant
octet first):

| member | `Frame.fcs (pad_to_60 (content_octets ~p))` |
|---|---|
| `P=1` | `[135; 7; 193; 206]` |
| `P=20` | `[165; 123; 95; 248]` |
| `P=59` | `[179; 48; 207; 77]` |
| `P=60` | `[52; 76; 160; 98]` |
| `P=61` | `[101; 247; 188; 171]` |
| `P=64` | `[153; 251; 128; 40]` |
| `P=67` | `[73; 59; 177; 75]` |
| `P=1514` | UNWORKED — not computed here, and no cell of this seal reads it |

### 4.6 IC-6 — no REQUIRED cell, and that IS the cell

The class is predicted **killed** and predicted to qualify **no row**. The
message that speaks, in every multi-frame unit, is arm (i):

```
M04-B3 (long -> short): wire decoder unclean:
M04-G6: wire decoder unclean:
M04-F1: wire decoder unclean:
M04-A3: wire decoder unclean:
```

each followed by `Tx_decoder.report`, whose discriminating content is a
`VIOLATION` line of the form

```
  VIOLATION cycle <n> REQ-202: FCS on the wire is [<hex>]; the REQ-305 bit-serial reference over the <m> preceding octets gives [<hex>], least significant octet first
```

at the **second** frame's terminate cycle and **not the first's**. `<n>`, `<m>`
and both hex strings are mutant-owned. **The frozen prediction is the
placement, not the values**: the violation list contains **no** entry at the
first frame of any run, and at least one at a later frame. A violation at a
**first** frame means the rendering is not this class.

**And the frozen finding, stated before the run:** `M04-B3`'s own octet
comparison (*"a design whose CRC register or length counter is not re-seeded
between frames produces a wrong FCS on frame 2, and the row's Kills cell names
exactly that"*) and `M04-G6`'s (*"only this comparison speaks"*) are **both
unreached**, because both units call arm (i) before them. Two rows written
expressly for this defect class are not exercised by it.

### 4.7 IC-7 — `M04-E1, M04-E2, M04-E3, M04-E5 (P=61)` (U14), the terminate lane

`P = 60` (`t = 0`) is the class's **required green** — it is the case the
defect is *correct* at, and it is the member every suite drives first. The
first reddening member is `P = 61`:

Branch **α** (the lanes between the last FCS octet and the displaced `/T/`
carry `/I/`):

```
M04-E1, M04-E2, M04-E3, M04-E5 (P=61): lane 1 of cycle <C+10> = 7, expected 0xFD
```

Branch **β** (those lanes keep stale data):

```
M04-E1, M04-E2, M04-E3, M04-E5 (P=61): lane 1 of cycle <C+10> does not carry a control character, expected /T/
```

Under α the `is_control` test passes (the lane *is* a control character, just
the wrong one) and the value test speaks; under β the `is_control` test speaks
first. **`7` under α is `/I/`'s own value and is not mutant-owned.**

### 4.8 IC-8 — `M04-E1, M04-E2, M04-E3, M04-E5 (P=60)` (U14), the fill value

```
M04-E1, M04-E2, M04-E3, M04-E5 (P=60): terminate word, lane 1 = <n>, expected 0x07 (/I/)
```

`<n>` is **mutant-owned**, sealed `<> 7`, with one named derivation: under the
disclosed *"the previous word's octet at the same lane is left underneath"*
rendering, lane 1 of the terminate word at `P = 60` carries the octet that lane
1 of `C+9` carried, which is content octet 57 = `1 + (57 mod 127)` = **58**.
The `is_control` test immediately before it **passes** — the class sets the
control bit, which is the whole point of the row (*"A decoder reading only
`xgmii_txc` passes it"*) — so this value message, and not a control message, is
the one that speaks. A green at the `is_control` test with a red at the value
test is the signature of this class and of no other.

### 4.9 IC-9 — `M04-F2 (P1=64)` (U18), the gap convention — **the campaign's narrowest cell**

```
M04-F2 (P1=64): the one gap = <n>, expected 12
```

`<n>` is **mutant-owned**, sealed **`> 12`**, derived **20**. The derivation,
worked at every residue so the narrowness is a measurement and not a hope. This
specification: `g = ceil((12 + t)/8)` words after the terminate word, actual gap
`8g − t`. The rejected reading (twelve idle octets *after* the terminate
character): `m = ceil((5 + t)/8)` further whole words, actual gap `8(1 + m) − t`.

| `t` | 0 | 1 | 2 | 3 | **4** | 5 | 6 | 7 |
|---|---|---|---|---|---|---|---|---|
| this specification | 16 | 15 | 14 | 13 | **12** | 19 | 18 | 17 |
| the rejected reading | 16 | 15 | 14 | 13 | **20** | 19 | 18 | 17 |

**They agree at seven residues of eight and differ only at `t = 4`.** The
predicted red set of this class is therefore **one member of one unit out of
twenty-six** — `P1 = 64` at U18 — and **every other unit and member in the
repository is required green**, including U17 (`M04-F1`, `t = 0`, gap 16 under
both), U19 (`M04-A3`, a hundred `t = 0` gaps), U20 (`M04-B3`, `t ∈ {6, 0}`),
U21 (`M04-G10`, `t = 0`), U26/U23 (`t = 1`, abort gaps), U24 (`M04-G3`, gap 23,
source-limited rather than `ifg`-limited: the rejected reading's minimum at
`t = 1` is 15 < 23, so the resume cycle still fixes it) and U27 (`M04-A4`,
gaps `[16; 15]`, `t ∈ {0, 1}`).

**And the standing decoder is blind to this class** (§2.3 blind spot 3): 20 is
not below `cfg_ifg`, so arm (i) raises nothing, and U18's own gap assertion —
which the plan drove **whole and not sampled** for exactly this reason — is the
only thing in the repository that speaks. **A bench that had sampled this sweep
had a seven-in-eight chance of scoring this class a survivor.**

### 4.10 IC-11 — six units, one shape

```
M04-G5: strobe monitor unclean:
M04-G1, M04-G2, M04-G8: strobe monitor unclean:
M04-G3: strobe monitor unclean:
M04-G6: strobe monitor unclean:
M04-F6: strobe monitor unclean:
M04-A4: strobe monitor unclean:
```

each followed by `Strobe_monitor.report`, whose discriminating content is the
pair of problem lines the monitor's `match_up` produces — one **missing**, one
**unexpected**, and the pairing is what makes this class distinguishable from
IC-12:

```
frame 0: error_underflow was expected on cycle <r> and was not high there (<the unit's own why string>); high cycles for this strobe over the run: <r+2>
cycle <r+2>: xgmii_tx_64 pulsed "error_underflow" and no expected event claims it — a strobe the stimulus did not create (requirements.md §0.6, REQ-008)
```

`<r>` is **base-owned per unit** and stated here so no scorer derives it at
scoring time: `C+1` at U22, `C+95` at U23, `C+185` at U24, `C+4` at U25, `C+4`
at U26, `C+15` at U27 (frame 1). `<r+2>` is the mutant's own, sealed **exactly
`r + 2`** under the class as stated — the class *is* the two-cycle lateness —
and any other offset means the rendering is not this class. The monitor's own
name string in the second line is `Bench.create`'s and is not mutant-owned.

**The count check (arm (iii)) is NOT reached**: `high_cycles` is still 1 and
the expected count is still 1, so it would pass; arm (ii) speaks first. **One
pulse, one `/E/` word, both present — this class is invisible to any bench that
asserts only that both happened, which is `M04-G2`'s Kills cell in its own
words, and the assertion that is not fooled here is the pin, not the
separation.**

### 4.11 IC-12 — `M04-G3` (U24), and that unit alone

Branch **α** (the strobe re-arms across the withholding; the wire is
unchanged — one `/E/` word, the frame ends once):

```
M04-G3: strobe monitor unclean:
```

followed by a report whose discriminating content is **three** unexpected lines
and **no** missing line:

```
cycle <C+186>: xgmii_tx_64 pulsed "error_underflow" and no expected event claims it — a strobe the stimulus did not create (requirements.md §0.6, REQ-008)
cycle <C+187>: … (same body)
cycle <C+188>: … (same body)
```

**The presence of the expected event at `C+185` as a MATCH — no missing
line — is what separates IC-12 from IC-11 at the same arm**, and that
separation is stated here rather than left to the scorer (standing rule 8, §7
collision 3). `hold = 4` is driven by exactly one unit in the repository (§0.2),
so **every other unit is required green**, and this is the campaign's second
single-unit class.

Branch **β** (the disarm is removed entirely, so the strobe follows source
idleness rather than a frame's underflow): every unit reddens through arm (ii)
or (iii), including units with no stall at all, and the class becomes
indistinguishable from a blast-radius event. §5.1 governs: every cell is `U`
and the class is scored under disposition 5, not as a kill.

### 4.12 IC-13 — `M04-G9 (P=1)` (U16), REQ-206's qualifier

Branch **α** (the strobe fires; the frame still completes):

```
M04-G9 (P=1): strobe monitor unclean:
```

followed by exactly one unexpected line and no missing line. **This arm is
`M04-G9`'s own observable** — the row's Observable cell is *"`error_underflow`
is 0 on every cycle of the run — obligation 4's exact strobe-event set is
empty"* and the unit's own comment names this call as *"THIS ROW'S assertion
rather than a background check"* — so standing rule 7 is satisfied and the red
qualifies the row. **This is one of only three places in the campaign where a
standing-instrument message qualifies a row**, and the ground is written in the
row and in the unit, not invented here.

Branch **β** (the strobe fires **and** aborts the frame, `/E/` `/T/` on the
wire): arm (i) speaks first instead —

```
M04-G9 (P=1): wire decoder unclean:
```

— and the qualification survives, because obligation 3's underflowed-frame
check and obligation 1 are both `M04-G9`'s own *"the frame transmits intact"*
clause. Both branches kill; they are distinguished by which arm speaks.

### 4.13 IC-13 at `M04-G10` (U21) — the named-cycle cell

If the rendering strobes at the cycle `BUG-0004` §9.3 derives, U21's assertion
2 speaks and it is `M04-G10`'s **own** named-cycle observable:

```
M04-G10 (a) (B=1): error_underflow is high at cycle C+12 — the cycle route 2's unfixed design strobed at, by BUG-0004 §9.3's own derivation
```

(and `C+13` / `route 3` at the `(b)` members). If it strobes at any other
cycle, assertion 2 stays green and the following `assert_instruments_clean_n`
speaks with `M04-G10 (a) (B=1): strobe monitor unclean:` — a red that kills the
class but **does not** qualify `M04-G10`'s named-cycle claim, because the named
cycle was not the one that fired. **Both outcomes are pre-committed; neither is
adjudicated after the fact.**

---

## 5. UNWORKED and unscored cells, with adjudication pre-fixed

### 5.1 A rendering that is neither disclosed branch

If a manifest delivers a rendering that is neither branch of a disclosure — an
IC-1 that also moves the start cycle, an IC-3 that also changes the CRC's
covered range, an IC-12 branch β, an IC-10 that also changes `cfg_ifg` — every
cell of that class is **U** and §8 disposition 5 governs. The class is scored as
**UNSCOREABLE**, its run is a scope report rather than a bench result, and it
supports no claim about any row in either direction (PROTOCOL §7 (b.1)).

### 5.2 The assertions shadowed in every class of this campaign

Named here so no scorecard is read as exercising them:

- **`M04-C3` assertion 2** (the wire FCS does *not* equal the unpadded oracle) —
  shadowed by assertion 1 under IC-4, IC-2, IC-3, IC-5 and IC-6 alike. **No
  class in this campaign reaches it.**
- **`M04-G2` assertion 3** (the strobe-to-`/E/` separation, read independently
  from `samples`) — shadowed by assertion 1 under IC-11, the only class that
  attacks it. **No class in this campaign reaches it.**
- **`M04-B3`'s and `M04-G6`'s octet comparisons** — shadowed by arm (i) under
  IC-6, the only class that attacks them (§4.6).
- **`M04-A3`'s per-frame preamble comparison with the frame index in its
  message** — shadowed by arm (i) under IC-1.
- **`M04-B2` assertion 4** (the poison scan) — shadowed by assertion 3 under
  IC-2, its own class. The row is qualified on assertion 3.
- **`M04-A4` assertion 6** (`gaps = [16; 15]` in one run) — shadowed by
  assertion 5 under IC-2 and IC-3, and unreached under IC-10 (§6).

### 5.3 A red at a bench-side check

A red at `P-ACCEPT`, `SP-1`/`SP-2`, `ST-1` … `ST-4`, obligation 6's contract
check, `M04-C3`'s assertion 0, `M04-D3`'s assertion 1 or `M04-D6`'s assertion 2
is **not a kill**. These are evaluated on the bench's own model of the run and
no RTL mutation can move them — except through the handshake, which is §8
disposition 6's subject. Such a red is routed as a finding against the bench or
the operator and scored zero for the class.

### 5.4 A `NOT SEEDED` at any class — the three outcomes, pre-fixed

If the manifest delivers **no** diff for a sealed class: the class is
**never rendered**, it sits in `sealed` and **not** in `seeded`, it is named at
the tally with that ground, and it is *"not a seeded mutation the suite failed
to kill but a mutation that does not exist"* (PROTOCOL §7 (b.1)). It scores
nothing in either direction and no coverage claim rests on it.

### 5.5 A diff that does not apply

A diff that fails to apply at `6d92bf9` is a **finding** of `F-0022-1`'s drift
class, recorded by the operating seat and **not repaired** by it (`WO-0084`
act 3). The class becomes `never rendered` per §5.4.

---

## 6. IC-10 — the predicted SURVIVE, worked in full

**This is the seal's falsifiable cell and the only one whose content is a claim
against my own attack plan.**

`M04-F6`'s Kills cell names two designs. The first — *"a design serving **no**
gap after an abort (the next preamble immediately)"* — is reachable and would
die at U26. The second is this class: *"a design measuring the gap from the
`/E/` character rather than from the `/T/`"*, and the cell states its
consequence as **`(t = 0, gap 16)`**.

**That consequence is arithmetically unreachable, and the row's own unit is
what proves it.** `Tx_decoder.gaps` counts octets from the terminate character
**inclusive** to the next start character **exclusive**. The abort word's
terminate character is the `/T/` at **lane 1**. REQ-201 places every start
character in **lane 0**, and the decoder violates REQ-201 if it is anywhere
else. So every gap this decoder can record after an abort is

> `(8 − 1) + 8(k − 1) = 8k − 1` octets for some whole number of words `k ≥ 1`,

i.e. **`gaps ∈ {7, 15, 23, 31, …}`, always `≡ 7 (mod 8)`. 16 is not in the
set and cannot be.**

And the substitution the class names has **no effect at all** at this bench's
one configured `cfg_ifg`:

| rendering | `g` | next start | gap the decoder records |
|---|---|---|---|
| conformant, from the `/T/` at `t = 1` | `ceil((12+1)/8) = 2` | terminate word + 2 | **15** |
| branch **α**, from the `/E/` at `t = 0` | `ceil((12+0)/8) = 2` | terminate word + 2 | **15** |
| branch **β**, twelve octets after the `/E/`'s own lane | `ceil((12+1+1)/8) = 2` | terminate word + 2 | **15** |

**`ceil((12 + t)/8) = 2` for every `t` in `0 … 3`, so at `cfg_ifg = 12` the
`/E/`-based and `/T/`-based renderings place the next start character in the
same word and the wire is byte-identical.** Predicted disposition: **SURVIVE**,
in every unit, with the scoreboard entirely green.

**Three things this prediction is careful not to be.**

1. **It is not an equivalent-mutant claim.** PROTOCOL §7 (b.3) requires the
   equivalence be proven over the **specification's** legal stimulus space, and
   over that space it is false: at `cfg_ifg ∈ {13, …, 16}` the two renderings
   separate at `t = 1`, and `AP-M04` §11/§9.1 permit any `cfg_ifg ≥ 12`. So
   IC-10 is **not** an equivalent mutant, it does **not** leave the
   denominator, and its disposition is a **survivor** under (b.2) — a coverage
   gap, whose cause is that `M04-F3`, the `cfg_ifg` parameterisation, is
   **outstanding** and no committed unit drives a second value.
2. **It is not a claim that `M04-F6` is vacuous.** The row's unit asserts the
   gap **exactly** (`= 15`, never `>= cfg_ifg`) and would kill branch **γ** —
   any rendering that changes the *word* in which the next start character
   falls, giving 7 or 23. The message would be
   `M04-F6: the one gap = <n>, expected EXACTLY 15 (§4.2 fact 5: t = 1, g = 2 words, 8g - t = 15 octets — 16 is one octet from conformant and is what a design measuring from the /E/ in lane 0 rather than the /T/ in lane 1 gives, trap T13)`
   with `<n> ∈ {7, 23}` — **and that failure message would itself quote the
   unreachable figure**, which is the second half of this finding.
3. **It is a finding against `AP-xgmii_tx_64.md`, filed by its own author, and
   it is filed before the run rather than after it.** `M04-F6`'s Kills cell and
   `test_m04_f.ml`'s own comment both name *"16"* as the wrong design's output;
   16 is not in the reachable set; and the row's real discriminating power is
   over the **word count**, not over the one octet the cell describes. **The
   correction is not made here** — this seal edits nothing — it is routed at
   §11 as the campaign's first pre-committed finding, `FINDING WO-0084-S1`
   (MINOR, mine), to be filed at act 4 whatever the runs return.

**If IC-10 is scored a KILL under branch α or β, this seal is falsified at this
cell**, and the falsification is worth more than the twelve kills beside it: it
would mean the gap is served by machinery this derivation does not describe.

---

## 7. Collisions, with their discriminators

Cells reachable by more than one class, each with what distinguishes them
(standing rule 8):

1. **`M04-D3`'s anti-vacuity cell** — `M04-D3: the two frames' FCS quadruples
   are equal, expected different` — is reached by **IC-2** (both quadruples are
   the poison, `[165; 165; 165; 165]`) and by **IC-3** (both are pad zeros,
   `[0; 0; 0; 0]`). **The message text is identical and contains no observed
   data.** Discriminator: the sibling cell at U13, which prints its four octets
   — `[165; …]` under IC-2, `[0; 0; 0; 0]` under IC-3. **Without U13 these two
   classes are indistinguishable at U12**, and that is said here rather than
   discovered at scoring.
2. **`wire octet count = 68`** is reached by **IC-2** (at `P` where
   `P mod 8 ≠ 0` and `P ≥ 60`) and by **IC-3** (at `P < 64`). Discriminator:
   `M04-C4` (U9) is **green** under IC-3 and **red** under IC-2; and IC-3 leaves
   `P ≥ 64` conformant while IC-2 does not.
3. **`strobe monitor unclean`** is reached by **IC-11**, **IC-12** and
   **IC-13**. Discriminators, in the report body: IC-11 pairs **one missing
   with one unexpected** at `r` and `r+2`; IC-12 has **no missing** and **three
   unexpected** at consecutive cycles, in one unit only; IC-13 has **no
   missing** and **one unexpected**, in units that drive no stall at all.
4. **`wire decoder unclean`** is reached by **IC-1**, **IC-4**, **IC-5**,
   **IC-6**, **IC-7**, **IC-8** and IC-13 branch β at every unit that calls arm
   (i) first. Discriminator: the `VIOLATION` line's own **REQ id** (REQ-201 for
   IC-1; REQ-202 for IC-4/IC-5/IC-6; REQ-205 for IC-7/IC-8; REQ-206 for IC-13β)
   and, for IC-6 alone, the fact that **no violation is recorded at any run's
   first frame**.

---

## 8. Pre-committed dispositions

1. **A class whose REQUIRED cell speaks the sealed text** is scored a **KILL**,
   one kill, at the class. The killing unit is the one named at §3.1.
2. **A class that reddens only through cells this seal marks `M`** is scored a
   **KILL of the class** and **NO qualification of any row** — recorded in both
   columns, never folded into one. IC-6 is predicted to be exactly this and is
   the test of whether this disposition is written honestly in advance.
3. **A class predicted to kill that no unit reddens** is a **SURVIVOR**, a
   **finding**, and takes the `F-0024-A` survivor evidence form: the
   **unmodified** committed diff, replayed against the suite as it stands, at a
   **run id**, with a falsifier-shaped witness. It is **never repaired inside
   this campaign** (`WO-0084` "Out of scope").
4. **A behavioural red anywhere in the 140 non-M04 units** is a **scope
   finding** against the manifest — the diff reached outside
   `libs/hardcaml_ethernet/src/xgmii_tx_64.ml` — and the class's own cells are
   `U`.
5. **A rendering that is neither disclosed branch** → **UNSCOREABLE** (§5.1),
   named at the tally with that ground, supporting no claim in either
   direction.
6. **A class that moves the handshake** — any change to `tx_tready`'s
   acceptance pattern, visible as a red at `P-ACCEPT`, `SP-2`, `ST-2`/`ST-3` or
   at `M04-G10`'s route precondition — invalidates every `<C>`-relative
   constant in this seal for that class. Its cells are `U` and the class is
   **UNSCOREABLE**, because a seal frozen on `C` cannot score a run that moved
   `C`. **This is disclosed before the run precisely because the alternative is
   arguing about it afterwards.**
7. **A build failure** (the mutant does not compile) is a **build finding**:
   all 167 units fail, step 5 is red, step 6 never runs, and **no behavioural
   claim of any kind may be read off that ref**.
8. **A step-10 red on any ref** is disposed of by §0.1 and is **not** evidence
   about the class.

---

## 9. Mutant-owned quantities — inequalities with named directions

| cell | quantity | sealed as | derived instance |
|---|---|---|---|
| §4.1 β | preamble control field | `<> 1` | `255` |
| §4.3 | `M04-C1`'s octet count | `> 64` | `68` |
| §4.5 | `M04-D1`'s observed FCS list | `<> [135; 7; 193; 206]`; α = its exact reverse, β = its octetwise XOR with `0xFF` | α `[206; 193; 7; 135]`, β `[120; 248; 62; 49]` |
| §4.6 | the REQ-202 violation's cycle, count and hex strings | UNWORKED — only the **placement** is sealed (no violation at any first frame) | — |
| §4.8 | `M04-E2`'s fill-lane value | `<> 7` | `58` |
| §4.9 | `M04-F2 (P1=64)`'s gap | **`> 12`** | `20` |
| §4.10 | the unexpected strobe cycle | **exactly `r + 2`** | per unit: `C+3`, `C+97`, `C+187`, `C+6`, `C+6`, `C+17` |
| §4.11 α | the three unexpected strobe cycles | `r+1`, `r+2`, `r+3` | `C+186`, `C+187`, `C+188` |
| §6 γ | `M04-F6`'s gap | `≡ 7 (mod 8)` and `<> 15` | `7` or `23` |

**`<C>` is base-owned, not mutant-owned**, for every class here (§8
disposition 6 is what happens if that stops being true).

---

## 10. Bounds this campaign does NOT close, named before the result

1. **`M04-A2` is attacked by no class.** Its kill — *"a design that inserts the
   preamble as octets rather than as a word and so rotates the frame by the
   preamble length; a design emitting two preamble words"* — is a distinct
   mechanism from IC-1's, and it is **not seeded**. Nothing this campaign
   returns is evidence that `M04-A2`'s absolute-cycle assertion works.
2. **`M04-B5`'s 8-bit-counter kill, `M04-E4`'s truncated-lane-index kill and
   `M04-B1`'s lane-reversal/byte-swap/rotate-by-4 kills are not seeded.** They
   are counter-width and permutation defects; no class below renders one.
3. **`M04-G8`'s `tlast`-keyed-conservation kill is not seeded**, and cannot be
   by an RTL mutation: it names a **monitor** defect beside a design defect, and
   a manifest cannot mutate the bench.
4. **`M04-C3` assertion 2, `M04-G2` assertion 3, and `M04-B3`'s and `M04-G6`'s
   own comparisons are reached by nothing** (§5.2). Four rows' discriminating
   instruments go unexercised by this campaign, and no `SO-` may report them as
   mutation-tested.
5. **`BAR T1` stays SHUT.** Every figure this campaign will produce is
   **bench-only**: no transmit reference is vendored, there is no transmit
   harness, REQ-901 declares no divergence class at this boundary, and
   `test/cosim/` is blind by stimulus (§0). A fully opened differential lane
   would not have seen `error_underflow` in any case.
6. **`cfg_ifg` is 12 in every unit.** IC-9's and IC-10's rules both carry it as
   a conjunct, and IC-10's predicted survive rests on it entirely. **The day
   `M04-F3` lands, IC-10 must be re-run, not re-quoted.**
7. **This campaign scores 13 classes against 34 discharged ASSERT rows.** It is
   not a coverage measurement of the suite and no `N/N` figure from it may be
   read as one (PROTOCOL §7 (b.4)).

---

## 11. Pass criteria — what "this campaign went as sealed" means

All of the following, and a failure of any one is recorded rather than
explained:

1. **13 diffs authored, 13 refs run, 13 step-6 results read at source**, each
   with its run id. Any class not rendered is named at the tally with §5.4's
   ground.
2. **12 kills, 1 survive** — the split at §3.1, class by class, with no ratio
   standing in for a disposition (PROTOCOL §7 (b.2)).
3. **Every REQUIRED cell's message matches its sealed text** in the characters
   this seal marks exact, and every mutant-owned integer satisfies its §9
   inequality.
4. **Every load-bearing green holds**: `M04-C4` green under IC-3; `M04-A3` and
   `M04-F6` and `M04-G5` green under IC-2; U14's members `P ≥ 64` green under
   IC-3; U18's seven non-`t=4` members green under IC-9; every non-`hold>1`
   unit green under IC-12. **A red at a load-bearing green is a finding against
   this seal and is scored as one.**
5. **The 140 non-M04 units stay green behaviourally** under every class.
6. **No cell is scored from a job conclusion** (standing rule 9, §0.1).
7. **`FINDING WO-0084-S1` is filed at act 4 whatever the runs return** — the
   `M04-F6` Kills-cell figure `16` is unreachable (§6). It is pre-committed
   here so that it cannot become a finding invented to explain a result.
8. **The immutability check passes**: `git diff <the freezing commit> -- agents/handoffs/WO-0084-SEALED-predictions.md`
   is **empty**, and this file's content agrees with `J-dv_lead-0195`.

---

## 12. Not to be told

Until every defect diff is committed, the seeding seat is told **the fact of
this seal and none of its content** (`docs/PROCESS.md` §4.3, the routing rule):
not the class list, not the class count, not the family spread, not which rows
are predicted qualified, not that any class is predicted to survive, and above
all **not §6** — a seeder who knew that one named class is predicted
unobservable would be told exactly which defect not to compose. The operating
seat needs one thing from this file and it is in §0.1: **score step 6, not the
job.** That much may be relayed, because it is a property of the base state
rather than of any prediction.
