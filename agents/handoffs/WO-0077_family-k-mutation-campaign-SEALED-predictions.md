# WO-0077 SEALED: dv_lead's frozen predictions for the family-K mutation campaign and its N-COMPLETION section

> **SEALED.** The auditor must not open this file until every diff is delivered
> and every scorecard is in hand — and under `WO-0077` §9's allowlist, **all of
> `agents/**` is out of bounds for the campaign's duration**, this file included
> and absolutely.

- **State**: **FROZEN — unopened.**
- **Frozen against**: **the commit that stages this seal and its packet.** Not
  its parent — the corrective drafting rule adopted at `WO-0073-VERDICT` §7 after
  `FINDING WO-0073-M1`, applied for the fourth time. I cannot state its hash: I
  never run git (PROTOCOL §2), and it has none until the orchestrator creates it.
  The auditor quotes the hash it applied to (`WO-0077` §9.3 item 6), and any
  disagreement is a finding **before** the campaign runs.
- **Frozen by**: dv_lead, `J-dv_lead-0145`, **before any diff existed**, in the
  commit that stages this file beside its packet — R-SEAL-1 (PROTOCOL §10,
  ADR-0016).
- **Two sections, sealed separately**: **§K** (six classes, family K) and **§N**
  (three classes, the N-completion section). They share one base SHA, one freeze
  window and one file; they share **no kill count, no qualification and no
  MUST-STAY-GREEN argument**. §7 is the cross product that keeps them apart and
  §7 is where that separation is measured rather than asserted.
- **Second copy**: the class → row mapping (not the message strings, not the
  matrices) is restated in `J-dv_lead-0145`.

### Standing rules

1. (`RV-0055` `FINDING G-1`) Every sealed cell resting on a claim about the DUT's
   state cites the stimulus fact that establishes that state, or is marked
   UNWORKED.
2. Every message below is the **first assertion to speak**, derived from the
   unit's committed control flow and source order at the base SHA — never from
   what the row is "about". §2 states the orders every cell depends on.
3. A quantity the specification does not fix is sealed as an **inequality with a
   named direction**, never as a value.
4. A cell resting on **two events being distinguishable** states the convention
   by which they are distinguished; where the convention cannot distinguish them
   the cell is **GREEN BY BLINDNESS** and a green there is **not** evidence the
   class fails to reach it.
5. (`FINDING WO-0066-3`, retained through `WO-0073`, `WO-0074` and `WO-0076`)
   Outside the units this seal works cell by cell, a class's predicted red set is
   stated as a **RULE in stimulus terms**, with worked instances named beneath it.
   **Where the rule and the instance list disagree, the RULE governs.**
6. (`FINDING WO-0074-S1`, carried in as a bar) **Every rule states its complete
   conjunct list** — including every gate the rendering may *not* remove — so no
   rule describes a class the packet forbids. **§3.4 records the conjunct this bar
   added this round and it is not a small one.**
7. (`WO-0076` standing rule 7, retained) A cell is scored as qualifying a row
   **only** if the message that speaks is an assertion of **that row's own
   observable**. A message from a monitor arm, from a bench-side stimulus check,
   from a driven-port check or from another family's unit qualifies the row **not
   at all**, however red.
8. **NEW THIS ROUND, and it is what `FINDING K-1` forces**: where a scored cell's
   message contains **no observed data**, the seal SHALL say so at the cell, name
   every other class that reaches the same cell, and state **what, other than the
   branch identity, distinguishes them — including "nothing".** A seal may not
   quietly present an unfalsifiable cell as a prediction.

---

## 0. The denominators and both censuses, re-measured at the freeze

Measured at this tree, **not carried forward**:

```
    3  test_m03_a.ml    7  test_m03_b.ml    4  test_m03_c.ml    3  test_m03_d.ml
    4  test_m03_e.ml    4  test_m03_f.ml    7  test_m03_g.ml    4  test_m03_h.ml
    5  test_m03_i.ml    3  test_m03_j.ml    2  test_m03_k.ml    2  test_m03_l.ml
    8  test_m03_n.ml    3  test_m03_structural.ml
  ---
   59  test/xgmii_rx_64/ (the M03 bench)
  139  test/ (repository-wide, OCaml units, --include=*.ml)
  141  test/ (the OLD directory-scoped matcher — FINDING M-4's contamination,
             REPAIRED in tools/dv_checks.sh and NOT used here)
```

**59 M03 units; 139 repository-wide; 80 non-M03**, by what a red there would
mean:

| set | units | a red there means |
|---|---|---|
| `test/monitors/` 37, `test/xgmii/` 25, `test/golden/` 11, `test/axi64_probe/` 3, `test/xgmii_probe/` 3 | **79** | the manifest reached outside its own file, **or** broke the `clear` = 0 path, the reset pulse, or the `cfg_rx_enable` = 1 path — a **scope finding** in every case |
| `test/hardcaml_ethernet/` | **1** | the mutant **does not compile** — a **build finding**, never behavioural |
| `test/cosim/` | **0 units** | a build-finding home and a behavioural detector, but **blind by stimulus** here (§6.1) |

**MUST-STAY-GREEN outside the scored units, every class, every branch: 79
behavioural + 1 build-level.**

### 0.1 The clear census

```
  M03-K1   test_m03_k.ml:228   Clear.window ~first:12 ~last:16    one member
  M03-K2   test_m03_k.ml:459   Clear.window ~first:6  ~last:10    one member
  everything else              Clear.never (run's default -> Bits.gnd every cycle)
```

**Two units of fifty-nine drive `clear` high during a schedule. Family K owns
both.** This is the narrowest instrument footprint of any campaign in this era.

### 0.2 The reset pulse — the conjunct that makes 0.1 insufficient

`bench.ml:64–68`: `create ()` drives an **idle** XGMII word, `clear` = 1 and
`cfg_rx_enable` = 1, steps the clock once, then releases `clear`. **All
fifty-nine M03 units therefore drive `clear` high exactly once, before cycle 0 of
their own schedule, with nothing in flight, no strobe owed and an idle input
word. The pulse's release cycle is cycle 0.**

**And the protecting fact is measured**: every schedule in this bench is laid out
with `first_start` ≥ 8 octet times (`Bench.frames_at` gives 8 at lane 0 and 12 at
lane 4; the three direct `Arrival.create` call sites use 8, 12 or `8 + 8k`), so
**the earliest start character anywhere in this bench is at cycle 1** and **no
unit presents one on cycle 0**.

### 0.3 The enable census, and the intersection

```
  M03-J1  test_m03_j.ml:169    M03-J2  :279    M03-J3  :488 (both members)
  M03-N4  test_m03_n.ml:1256 (both members)
  clear-driving ∩ enable-driving = EMPTY
```

**Four units drive `cfg_rx_enable` away from `Enable.high`. No unit drives both
ports.** §7 is the enumeration that follows from this and it is the whole ground
for running two sections in one campaign.

---

## 1. The row prefixes, which are how the scorecard is read

Every message below is `<row prefix>: <body>`, composed by each file's own
`let fail row msg = failwith (String.concat [ row; ": "; msg ])`
(`test_m03_k.ml:65`, `test_m03_n.ml:137`). The prefixes at the base SHA:

| unit | prefix, character-exact |
|---|---|
| `M03-K1` | `M03-K1` — **no lane suffix, ONE member** |
| `M03-K2` | `M03-K2` — **no lane suffix, ONE member** |
| `M03-N1` | `M03-N1 (lane 0)`, then `M03-N1 (lane 4)` |
| `M03-N4` | `M03-N4 (lane 0)`, then `M03-N4 (lane 4)` |

**No prefix in this campaign is content-dependent.** The two K units have one
member each, so **no K cell carries a lane suffix and no K cell is shadowed by a
sibling member** — a structural difference from every campaign since `WO-0058`
and one that costs the K section nothing. A red carrying `lane 4` at an N unit
means every lane-0 member was green — itself a finding under that class's own
rule (§5.3).

**Encoding note, as at `WO-0074` and `WO-0076`**: the bodies below are the OCaml
literals as the runtime composes them, with line-continuation backslashes elided
(as the compiler elides them). Where a body contains `—` (U+2014) the promoted
source prints the decimal escapes; comparison is against the decoded string.
**Every body in this seal is ASCII**, including the `--` sequences, which are two
hyphen-minus characters and not an em dash.

---

## 2. The orders every REQUIRED cell depends on

### 2.1 The three instrument kinds

Only the **DUT-observable** assertions can convict a design. The **bench-side
stimulus derivations** (every `test bug --` message, `Arrival.check`, every
derived window/start/terminate/change cycle, `Frame.residue_ok`, the
no-start-character-in-the-window scans, `Injection.outcomes`, both landing
checks, the two report-cycle routes' agreement) and the **driven-port checks**
(`sample.clear` and `sample.enable` against an independently written predicate)
are evaluated on the bench's own model of the run and **no RTL mutation can move
them** (§5.5). Both pre-scan guards are the same kind and are unreachable twice
over (§6.3).

### 2.2 `M03-K1` — `run_k1`, in order

> bench-side derivation (bad-FCS construction; 1 frame; `start_octet_time` **8**,
> `start_lane` **0**, `start_cycle` **1**; `terminate_octet_time` **80**,
> terminate cycle **10**; `Arrival.cycles` **13**; the derived window
> **12 … 16**, release **17**; no start character inside it) → the
> `Strobe_monitor.expect` registration → `run` with `drain:8` → **(A) the
> delivered-word count** (`= 8`) → **(B) per word**: cycle (`start_cycle + 3 + m`,
> so **4 … 11**) → `tkeep` (0xFF, 0x0F at word 7) → `tlast`/`tuser` (word 7
> carries `tlast` and `tuser`[0] = **1**, the bad FCS) → **(C) the delivered
> octets** → **(D) the strobe set**, matched as a one-element list: **name first,
> then cycle** (`error_bad_fcs` at cycle **11**), with a **count** message on the
> non-singleton branch → the driven-`clear` check (bench-side) → **(E) the silence
> scan** over cycles **12 … 17**, `tvalid` checked **before** the strobe list,
> per sample, samples in cycle order → accounting → `cleared_mid_frame` (= 0) →
> five conservation counters → `word_delay` (`Some 3`) → **(F) the control run at
> the default schedule** (its own count, per-word facts, octets, strobe set and
> silence scan) → `assert_monitors_clean` on the clear bench, then the control
> bench.

**(A) is the FIRST DUT-observable assertion in the unit.** **And the unit's window
contains nothing a conformant design acts on**: the frame's own `tlast` and its
`error_bad_fcs` both land on cycle **11**, the cycle immediately **before** the
window; every input word from cycle 11 to the end of the drain (cycle 20) is
idle; and the schedule's only start character is at cycle **1**. **The only class
that can convict this row is one that carries a pre-clear observable forward
into the window** (§6.6).

### 2.3 `M03-K2` — `run_k2`, in order

> bench-side derivation (2 frames; A `start_octet_time` **8**, lane **0**,
> `start_cycle` **1**, `terminate_octet_time` **80**, terminate cycle **10**;
> B `start_octet_time` **92**, lane **4**, `start_cycle` **11**,
> `terminate_octet_time` **164**, terminate cycle **20**; `start_spacings`
> **[10]**, `gaps` **[12]**, `Arrival.cycles` **23**; the window **6 … 10**, the
> release-cycle identity `start_cycle_b = clear_last + 1`; no start character
> inside the window) → `run` with `drain:8` → **(A) the delivered-cycle list of
> the whole run** → the two partition-length checks → **(B) frame A's `tkeep`
> (0xFF) and its `tlast` prohibition** → **(C) frame A's octets** (the first 16 of
> `Frame.delivered a`) → **(D) frame B's per-word facts** through the shared
> helper at `start_cycle` **11**, `expected_tlast_tuser` **0** → **(E) frame B's
> octets** → **(F) frame B's sequence number** (= 1) → **(G) the whole run's
> `tlast` count and its cycle** (one, at **21**) → **(H) the strobe set over the
> whole run** (empty) → the driven-`clear` check (bench-side) → **(I) the silence
> scan** over cycles **6 … 11**, `tvalid` before the strobe list → accounting →
> `cleared_mid_frame` (= 1) → protocol `frames` 1 / `words` 10 / `aborts` 0 →
> five conservation counters (`frames_exempt` = **1**) → `word_delay` (`Some 3`)
> → `frames_compared` (= **2**) → **(J) the control run** (16 delivered words,
> `tlast` cycles **[11; 21]**, both frames' octets and sequences, no strobe,
> `cleared_mid_frame` = 0) → `assert_monitors_clean` on both benches.

**(A) is the FIRST DUT-observable assertion in the unit and it is a CHOKE POINT.**
The expected list is **`[4;5;14;15;16;17;18;19;20;21]`** — A's two escaped words
and B's eight. Every class that moves which cycles carry a delivered word raises
**(A)** and nothing after it.

> **(A)'s message names the expected list and prints NOTHING it observed.** That
> is `FINDING K-1` and standing rule 8 exists because of it. Four of the six K
> classes score there.

**The two partition-length checks immediately after (A) are UNREACHABLE while (A)
passes**: (A) pins the total at ten and the partition is a fixed `split_n … 2`.
Recorded so no scorecard implies they were probed.

### 2.4 `M03-N1` — `run_n1 ~row ~lane …`, lane 0 then lane 4, in order

> bench-side construction (the frame's own terminate at octet time **80** at lane
> 0 / **88** at lane 4, terminate lane **0** at both; the `/E/`'s derived octet
> time **85** / **93**; the overlay's two pre-drive landing checks; the driven
> word's two landing checks, which read `s.in_word`) → **(A) the delivered-word
> count** (`= 8` at both members) → **(B) per word**: cycle
> (`expected_start_cycle + 3 + m` = **4 … 11** at both members) → `tlast` position
> → final `tkeep` (**0x0F** at lane 0, **0xFF** at lane 4) → `tuser` (= 0) →
> **(C) the delivered octets** → **(D) the strobe set over the whole run —
> EMPTY**, which is the row's own kill and the row's own Observable clause 2 →
> accounting → `assert_monitors_clean`.

### 2.5 `M03-N4` — `run_n4 ~row ~lane …`, lane 0 then lane 4, in order

> `Injection.outcomes` cross-check and both landing checks, the two report-cycle
> routes' agreement, the derived change cycles, the three named enable facts and
> the driven-window check (all bench-side) → **(A) the delivered-sample cycle
> list** → frame A's word count, per-word `tlast`/`tkeep`/`tuser` and content →
> frame C's word count, per-word facts, content and sequence → **(B) the exact
> strobe set over the whole run** → accounting → `word_delay` →
> `assert_monitors_clean`.

**Unlike `M03-K2`'s, (A) PRINTS THE OBSERVED LIST**, `; `-separated, followed by
the expected one, a newline and `Enable.report enable`.

### 2.6 The derived numbers every REQUIRED cell prints or depends on

| number | derivation | fixed by |
|---|---|---|
| `M03-K1`'s **8** delivered words | 60 delivered octets (REQ-103 strips 4 FCS from 64) at 8 octets per word | **specification** |
| `M03-K1`'s strobe cycle **11** | `start_cycle` 1 + 3 + 7; SPEC-M03 §9's *"Strobe cycle, pinned"* puts `error_bad_fcs` on the frame's own `tlast` cycle | **specification** |
| `M03-K1`'s window **12 … 16**, release **17** | the cycle after the strobe, five cycles long (§4.K's own figure) | **bench-supplied** |
| `M03-K2`'s expected list `[4;5;14 … 21]` | A admitted at cycle 1, two words escape at 4 and 5 before the window opens at 6; B admitted at cycle 11, eight words at `11 + 3 + m` | **specification over a bench-supplied window** |
| `M03-K2`'s window **6 … 10**, release **11** | `last = 10` is forced (the release cycle must be B's start cycle); `first = 6` is chosen so exactly two of A's eight words escape | **bench-supplied** |
| `M03-N1`'s **8** words and **4 … 11** | 60 / 64 delivered octets; `expected_start_ot / 8` = **1** at both lanes | **specification** |
| `M03-N4`'s expected lists `[4; 14 … 21]` and `[4; 5; 15 … 22]` | A aborted at the octet before the refused start (8 / 16 octets → 1 / 2 words); C at `c_start_cycle + 3 + m` | **specification** |
| `M03-N4`'s report cycle **4** (lane 0) / **5** (lane 4) | `a_start_cycle + 3 + (a_words − 1)`, agreed by both routes inside the unit | **specification** |
| `M03-N4`'s change cycles **2/10** (lane 0) and **3/11** (lane 4) | `w_cycle − 1` and `c_start_cycle − 1` | **bench-supplied** |

---

## 3. §K — the family-K matrix

`R!` = REQUIRED red **and scored**. `G` = MUST STAY GREEN. **`G!`** = a
**load-bearing** required green — the cell carries a measurement, and a red there
changes what may be claimed (§9 disposition 2). `G✱` = green by blindness (§6).
`r` = predicted red by the class's own **rule**, contributing **zero** kills.
`M` = a red arriving through a monitor arm, qualifying nothing (standing rule 7).
`U` = unscoreable. Anything off-pattern is a **finding**.

### 3.1 The two K units, worked

| unit (row it carries) | IC-K1 | IC-K2 | IC-K3 | IC-K4 | IC-K5 | IC-K6 |
|---|---|---|---|---|---|---|
| **M03-K1** (M03-K1) | **G!** | **G!** | **G!** | **R!** | **G!** | **G!** |
| **M03-K2** (M03-K2) | **R!** | **R!** | **R!** | **G!** | **R!** | **R!** |

**`G!` count in this section: 6, and here they are, enumerated so no prose count
can disagree with the matrix (`FINDING WO-0076-S2`'s bar).** Five in the
`M03-K1` row (IC-K1, IC-K2, IC-K3, IC-K5, IC-K6) plus one in the `M03-K2` row
(IC-K4) = **5 + 1 = 6**. Each with the measurement it carries:

1. **`M03-K1` under IC-K1** — the window opens **after** the frame's own `tlast`,
   so a design that closes the in-flight frame has **no frame in flight to
   close**. `cleared_mid_frame` = 0 is the unit's own witness of that state.
2. **`M03-K1` under IC-K2** — nothing is abandoned here, so a design that reports
   an abandonment has **nothing to report**. It says the class keys on a frame
   being open at the clear and not on `clear` as such.
3. **`M03-K1` under IC-K3** — the schedule's only start character is at cycle
   **1**, and the release cycle is **17**, so a design that refuses a start on a
   release cycle has **no start to refuse**. Measured from the unit's own
   no-start-character scan over 12 … 16 and from `Arrival.cycles` = 13.
4. **`M03-K1` under IC-K5** — **this is the round's centrepiece.** `WO-0072` §7.5
   derived, before a bench existed, that a one-cycle-late `clear` is *invisible
   here*: cycle 12 behaves un-cleared where a conformant design also produces
   nothing (the frame drained at 11), and cycle 17 behaves cleared where a
   conformant design is silent anyway. **If IC-K5 reddens `M03-K2` and leaves
   `M03-K1` green, that withdrawal is established from a run rather than from an
   argument** — the `IC-J3`/`M03-J2` pattern one family over.
5. **`M03-K1` under IC-K6** — no frame is in flight, so there is no word in the
   emission path to leak.
6. **`M03-K2` under IC-K4** — frame A is a clean `stress_frame` and frame B is
   clean, so **no strobe is owed anywhere in this unit's run** and a design whose
   strobe path survives `clear` has **nothing to carry**. It says the class keys
   on a pending strobe, not on `clear`.

**Every one of the six is a statement that the class keys on the conjunct it
names and not on `clear` as such**, which is what makes a kill mean something
narrower than "the design mishandles reset".

### 3.2 Kills, per class

| class | kills if §9 disposition 1 holds |
|---|---|
| IC-K1 | **1** |
| IC-K2 | **1** |
| IC-K3 | **1** |
| IC-K4 | **1**, or **0 and a declaration** (§9 disposition 3) |
| IC-K5 | **1** |
| IC-K6 | **1** |
| **§K maximum** | **6** |

### 3.3 The rows these kills qualify

| class | qualifies | reds that are blast radius and qualify nothing |
|---|---|---|
| **IC-K1** | **`M03-K2`**, on REQ-009's *"no `tlast` … is emitted for it"* | — (the rule selects one unit) |
| **IC-K2** | **`M03-K2`**, on REQ-009's *"and no strobe"* | — |
| **IC-K3** | **`M03-K2`**, on REQ-009's last sentence | — |
| **IC-K4** | **`M03-K1`**, on REQ-009's *"every strobe SHALL be 0"* — **and this is the ONLY class in the campaign that can qualify that row** | — |
| **IC-K5** | **`M03-K2`**, on REQ-009's two-conjunct silence clause | — |
| **IC-K6** | **`M03-K2`**, on REQ-009's *"every `tvalid` output SHALL be 0"* | — |

**Five classes qualify one row. That is five kills and ONE qualification**
(`WO-0066` §11), and the verdict says so rather than reporting `M03-K2` five
times. **`M03-K1` is qualified by IC-K4 or by nothing** — §9 disposition 3 fixes
what a `NOT SEEDED` there means and it is a declaration, not a gap.

**No cell in this campaign may qualify `M03-K1` on the withdrawn *"needs a second
cycle to settle"* class, whatever a scorecard shows** (`WO-0072` §7.5,
`J-dv_lead-0132`). **IC-K5 is that design and it is scored at `M03-K2`.**

### 3.4 The rules, with their COMPLETE conjunct lists (standing rule 6)

**Every rule's first TWO conjuncts are the same and both are measured (§0.1,
§0.2):**

> **(κ1)** the unit drives `clear` **high on a schedule cycle** — two units
> satisfy it and **no rule here can select a third**; and
> **(κ2)** the rendering's response to `Bench.create`'s **one-cycle reset pulse**
> — `clear` high for one cycle with an idle word, nothing in flight, no strobe
> owed, release on cycle 0 — is **unchanged**, which is what keeps the other
> fifty-seven M03 units and all seventy-nine non-M03 behavioural units green.

**(κ2) is what `FINDING WO-0074-S1`'s bar added, and without it this seal would
have been wrong rather than incomplete.** A rule carrying only (κ1) selects two
units and is **false as a complete statement of what the class touches**: every
one of the fifty-nine units drives `clear` high once. A class that mishandles a
clear with nothing pending would have reddened fifty-nine units against a seal
predicting two, and the seal would have called a correct scope finding an
unnamed-unit finding.

| class | RULE — the class reddens a unit iff (κ1) ∧ (κ2) ∧ … | further conjuncts the rendering may NOT remove |
|---|---|---|
| **IC-K1** | … a frame is **in flight** on a cycle at which the driven `clear` is high | the report path entire; the delivery of every frame the `clear` window does not cover; the `clear` = 0 path entire; §7's emission timing (`m + 3`) |
| **IC-K2** | … a frame is **abandoned** by a driven `clear` window (in flight when it opens and never closed) | the admission gate; the emission path entire — **no delivered word may move**; every strobe of a frame `clear` did not abandon; the `clear` = 0 path entire |
| **IC-K3** | … a **start character** arrives on a driven `clear` window's **release cycle** | the window's own contents entire; the report path; every frame admitted two or more cycles after a release; the `clear` = 0 path entire |
| **IC-K4** | … a **strobe is pulsed on a cycle immediately before, or owed inside**, a driven `clear` window | **every strobe cycle at every stimulus with no driven `clear` window — this is the conjunct that separates a CARRY from a RE-TIMING** (§6.6); the emission path entire; the `clear` = 0 path entire |
| **IC-K5** | … a driven `clear` window's **leading edge covers a cycle on which a word would be delivered**, **or** its **release cycle carries a start character** | the reset pulse's own release **at cycle 0** (§0.2 — a shift that reaches cycle 1 selects every unit and is a scope violation); every stimulus with no driven `clear` window; the report path |
| **IC-K6** | … a **word is in the emission path** on a cycle at which the driven `clear` is high | every `tlast`; the report path entire; the admission of a frame on the release cycle; the `clear` = 0 path entire |

### 3.5 Worked instances beneath the rules

- **IC-K1** — the rule's set is **`{M03-K2}`**, measured: `M03-K2` is the only
  unit in the bench whose `clear` window opens with a frame in flight
  (`cleared_mid_frame` = 1 there and 0 at `M03-K1`). **`M03-K1` is WORKED and
  predicted GREEN and it is the boundary**: its window opens on cycle 12, one
  cycle after the frame's own `tlast` at 11.
- **IC-K2** — the same set, for the same reason and by the same witness.
- **IC-K3** — the rule's set is **`{M03-K2}`**, measured: its release cycle is
  **11** and frame B's start character is **on it**, which is the tightest legal
  placement REQ-009's last sentence names. `M03-K1`'s release cycle is **17** and
  its schedule's only start character is at **1**.
- **IC-K4** — the rule's set is **`{M03-K1}`**, measured: its `error_bad_fcs`
  pulses on cycle **11** and the window opens on **12**. `M03-K2` owes no strobe
  anywhere (both frames clean; `error_pulses` empty in its own control run), so
  it is **WORKED and predicted GREEN**.
- **IC-K5** — the rule's set is **`{M03-K2}`**, measured on both disjuncts: its
  window's leading edge is cycle **6**, on which frame A's third word would be
  delivered under `Enable.high`/`Clear.never`; and its release cycle **11**
  carries B's start character. At `M03-K1` **neither disjunct holds** — cycle 12
  carries no delivered word (the last is at 11) and cycle 17 carries no start
  character — which is `WO-0072` §7.5's derivation restated as a rule.
- **IC-K6** — the rule's set is **`{M03-K2}`**: it is the only unit whose window
  covers cycles on which a conformant design would have emitted words (7 … 11 of
  frame A's 4 … 11). At `M03-K1` the window opens after the last word.

**All 57 other M03 units and all 79 non-M03 behavioural units are
MUST-STAY-GREEN under every class in §K**, and the guarantee is (κ1) ∧ (κ2)
together and neither alone.

**Adjudication for every `r` cell, fixed here**: a red selected by a class's own
rule is predicted blast radius, contributes zero additional kills and is not an
unnamed-unit finding; a **green** at a unit the rule selects is a **FINDING** and
is adjudicated per row. **§K contains no `r` cells at all** — every rule selects
exactly one unit — which is a property of a two-unit family and is the reason §K's
scorecard is unusually clean and unusually narrow.

---

## 4. §K — the REQUIRED cells, verbatim

`<n>` marks a **mutant-owned** integer, sealed at §10 as an inequality; every
other character is exact.

### 4.0 The raise sites, with their line numbers at the base SHA

Standing rule 2 obliges every message here to be derived from the unit's own
committed source rather than from what the row is "about". **`WO-0076-S1` is
carried in because that obligation was honoured for the scored cells and not for
the monitor arms.** So both are given line numbers this round, and every string
below and in §12 was read back from these lines at the base tree:

| cell | file:line | shape |
|---|---|---|
| §4.1 / §4.3 / §4.5 / §4.6 — `M03-K2`'s delivered-cycle list | `test_m03_k.ml:470` | no integer, **no observed data** |
| §4.2 — `M03-K2`'s strobe-set emptiness | `test_m03_k.ml:511` | no integer |
| §4.4 — `M03-K1`'s strobe-set count arm | `test_m03_k.ml:260` | one mutant-owned integer |
| §4.4's disposition-7 alternative — `M03-K1`'s strobe cycle arm | `test_m03_k.ml:251` | prints observed and expected cycles |
| §4.4's shadowed sibling — `M03-K1`'s delivered-word count | `test_m03_k.ml:232` | reached by no class |
| §12.1 α — `M03-N1`'s strobe-set emptiness | `test_m03_n.ml:954` | no integer |
| §12.1 β — `M03-N1`'s delivered-word count | `test_m03_n.ml:906–910` | one mutant-owned integer |
| §12.2 — `M03-N4`'s delivered-sample cycle list | `test_m03_n.ml:1305–1311` | **prints the observed list**, `"; "`-separated, then a newline and `Enable.report` |
| §12.3 — `M03-N4`'s exact-strobe-set check | `test_m03_n.ml:1424` | one mutant-owned integer |

**SIX distinct raise sites carry every one of this campaign's nine scored cells
in §K and §N together — seven if `D-N1c` returns branch β — and ONE of the six
takes four classes by itself.** That one is `test_m03_k.ml:470`, and it is
`FINDING K-1`.

### 4.1 IC-K1 — `M03-K2`, the delivered-cycle list — **THE CHOKE POINT**

```
M03-K2: the delivered-cycle list is not [4;5;14;15;16;17;18;19;20;21] -- the precondition every partition below depends on
```

**Sealed under `D-K1a` sites (i), (ii) and (iii) alike, and the message is
character-exact under all three because it prints nothing it observed.**
Predicted observed lists, sealed as predictions **no cell reads** (§10):
site **(i)**, the opening edge — `[4;5;6;14 … 21]`; sites **(ii)** and **(iii)**,
the release edge and the latched `/T/` — `[4;5;11;14 … 21]`, **identical to each
other**.

**Standing rule 8's statement, made at the cell**: this message contains **no
observed data**. IC-K3, IC-K5 and IC-K6 reach the same cell with the same
characters. **What distinguishes IC-K1 from them at this bench: NOTHING that any
message prints.** The discriminators are the branch identity, `D-K1a`, and
`M03-K1`'s colour — which is green under all four. **§8 collision 1 is where this
is scored.**

**Branch (ii)/(iii) note, sealed as a finding before the run**: `AP` §4.K's
`M03-K2` cell says kill 1 is *"reachable at THREE distinct sites"*. **Measured
against the row's own instrument, the three sites produce ONE message and TWO
distinct observed lists.** Reachable is not separable — `FINDING K-1`'s second
half, and it is against my own plan text.

### 4.2 IC-K2 — `M03-K2`, the strobe set over the whole run

```
M03-K2: error_pulses is not empty -- A vanishes with no strobe (REQ-009) and B is clean
```

**No integer: this cell is exact in every character.** It is reached only because
the class changes nothing the seven assertions before it read — the delivered-cycle
list, frame A's `tkeep` and `tlast` prohibition, frame A's octets, frame B's
per-word facts, frame B's octets, frame B's sequence and the run's single `tlast`
at cycle 21. **It is the only cell in §K that a class reaches by leaving the
datapath entirely alone**, and it is reached whichever strobe `D-K2a` names and
whichever cycle in 6 … 11 it pulses on, because the assertion reads the whole
run's pulse list and the silence scan is **later** in the unit (§2.3).

### 4.3 IC-K3 — `M03-K2`, the delivered-cycle list

```
M03-K2: the delivered-cycle list is not [4;5;14;15;16;17;18;19;20;21] -- the precondition every partition below depends on
```

Predicted observed lists, **unread**: under `D-K3a` *refused* — `[4;5]`; under
`D-K3a` *late* — `[4;5]` followed by B's eight words shifted by the settling
depth `d`, i.e. `[4;5;14+d … 21+d]`. **Standing rule 8: no observed data in the
message; IC-K1, IC-K5 and IC-K6 reach the same cell; nothing printed distinguishes
them.**

### 4.4 IC-K4 — `M03-K1`, the strobe set's non-singleton branch

```
M03-K1: expected exactly one strobe pulse (error_bad_fcs only), observed <n>
```

`<n>` is **mutant-owned**, sealed **`> 1`**, with **two named derivations**:
under `D-K4b` *one presentation* it is **2** (the frame's own pulse at cycle 11
plus one carried high cycle); under `D-K4b` *a level held across the window and
its release* it is **7** (cycle 11 plus cycles 12 … 17). **Direction: more** — a
carry adds high cycles and cannot remove one.

**This is the ONLY cell in §K at `M03-K1` and the only cell in the campaign whose
message carries a mutant-owned integer with a bench-side direction.**

**The pre-fixed discriminator between a CARRY and a RE-TIMING, and it is
executable**: if the message that speaks is instead

```
M03-K1: error_bad_fcs pulsed on cycle <c>, expected 11
```

with `<c>` ≠ 11 and exactly one pulse in the run, the rendering **shifted** the
strobe rather than carrying it, `D-K1b` is violated (every pinned strobe cycle in
the suite moves), and **§9 disposition 7 governs: reported, not scored.** A
scorecard showing that message together with reds at other families' strobe
assertions is the confirmation, not the discovery.

### 4.5 IC-K5 — `M03-K2`, the delivered-cycle list

```
M03-K2: the delivered-cycle list is not [4;5;14;15;16;17;18;19;20;21] -- the precondition every partition below depends on
```

Predicted observed list, **unread**: **`[4;5;6]`** — the leading edge leaks the
word at cycle 6, the shifted window covers 7 … 11 so A's remaining words are
suppressed **and** B's start character on cycle 11 arrives while the design is
still cleared, so B never opens and its own `/T/` at cycle 20 arrives in `Idle`
and is ignored (§6.2's `Idle` row).

**Standing rule 8: no observed data in the message; IC-K1, IC-K3 and IC-K6 reach
the same cell; nothing printed distinguishes them.** **`M03-K1`'s green is this
class's whole measurement and it is at a different unit, which is why §3.1 item 4
marks it `G!` rather than `G`.**

### 4.6 IC-K6 — `M03-K2`, the delivered-cycle list

```
M03-K2: the delivered-cycle list is not [4;5;14;15;16;17;18;19;20;21] -- the precondition every partition below depends on
```

Predicted observed list, **unread**: `[4;5]` plus one entry per leaked cycle,
from `[4;5;6;14 … 21]` (one leaked cycle) to `[4;5;6;7;8;9;10;11;14 … 21]` (the
whole window and the release cycle leaked, `D-K6a`'s widest branch). **Every
leaked word carries `tlast` = 0**, which is what separates the class from IC-K1
**at a cell no class reaches**, because (B)'s `tlast` prohibition is shadowed by
(A). **Standing rule 8: nothing printed distinguishes it from IC-K1, IC-K3 or
IC-K5.**

---

## 5. §K — the UNWORKED and unscored cells, with adjudication pre-fixed

### 5.1 A rendering that is neither disclosed branch

If a manifest delivers a rendering that is neither branch of a disclosure — an
IC-K1 whose `tlast` lands outside all three sites, an IC-K3 that also delays the
output path (`D-K3b`), an IC-K5 shifted at one edge only where `D-K5a` claims
both, an IC-K4 whose carry mechanism is not the one `D-K4c` names — every cell of
that class is `U` and disposition 5 governs.

### 5.2 The cells shadowed in every class of §K

Recorded so that no scorecard implies they were probed. **At `M03-K1`**, under
IC-K4: nothing — (A), (B) and (C) all pass and (D) is the fourth assertion, so
only (E), the accounting, the counters and the control run are shadowed. **At
`M03-K2`**, under IC-K1, IC-K3, IC-K5 and IC-K6: **everything after (A)** — frame
A's `tkeep` and `tlast` prohibition, frame A's octets, all of frame B's per-word
facts, its octets, its sequence, the run's `tlast` count, the strobe set, the
silence scan, `cleared_mid_frame`, the protocol and conservation counters,
`word_delay`, `frames_compared` and **the whole control run**. Under IC-K2:
everything after (H).

**The breadth figure, with its definition, its measurement and its limit stated —
because this is the figure `J-dv_lead-0143` flagged as the one it could not
re-derive and this seal will not repeat that without saying so.**

- **Measured, by a command whose output is its own provenance**:
  `grep -cE '(^|[^_a-zA-Z])fail($| )' test/xgmii_rx_64/test_m03_k.ml` → **95**
  matching lines at the base tree, of which **3** carry `test bug` and are
  bench-side by their own text. That figure counts the helper definition and every
  raise site in both units together; it is an upper bound on the file's raise
  sites and nothing finer.
- **Counted exactly, because it is small and it is the numerator that matters**:
  this section's six classes reach **THREE distinct raise sites** in the whole
  file — `M03-K1`'s strobe-set count arm (IC-K4), `M03-K2`'s delivered-cycle list
  (IC-K1, IC-K3, IC-K5, IC-K6 — **four classes, one site**) and `M03-K2`'s
  strobe-set emptiness check (IC-K2).
- **Not reached by anything in this campaign, and named because a reader would
  assume otherwise**: **both silence scans** — the `tvalid` and strobe arms over
  each unit's window and release cycle, which are the assertions a reader assumes
  a `clear` campaign exercises; `M03-K1`'s delivered-word count; every per-word
  assertion in both units; every conservation and protocol counter; `word_delay`;
  `frames_compared`; and **both control runs entire**.
- **The limit, stated rather than smoothed**: classifying every one of the file's
  raise sites as DUT-observable, bench-side or monitor-fed is **a judgement over
  assertion bodies and not a grep**, so this seal states the numerator exactly and
  the denominator only as the measured upper bound above. **The verdict must
  reproduce it the same way rather than quote a ratio nobody counted.**

### 5.3 Shadowed members

**The two K units have ONE member each**, so §K has no shadowed-member problem at
all. §N's two units have two each and §5.3 of the N section governs there.

### 5.4 A red arriving through `assert_monitors_clean`

The five arms, **enumerated from `test/xgmii_rx_64/bench.ml` at the base SHA in
source order** (`FINDING WO-0076-S1`'s bar, discharged rather than recalled):

| # | line | form |
|---|---|---|
| 1 | `:604` | `<prefix>: protocol monitor unclean:` |
| 2 | `:610` | `<prefix>: conservation monitor unclean:` |
| 3 | `:616` | `<prefix>: strobe monitor unclean:` |
| 4 | `:632` | `<prefix>: latency tagger errors:` |
| 5 | `:638` | `<prefix>: latency tagger unclean:` — **gated on `frames_compared > 0`** |

**Arm 4 precedes arm 5.** `WO-0076`'s seal enumerated four arms from memory, in
the wrong order, and the arm that fired was the one it omitted; this enumeration
is from the file. **Both K units assert `word_delay` before reaching this
function and `M03-K2` asserts `frames_compared = 2` before it, so arm 5's gate is
satisfied at every unit this campaign scores.** A message of any of these five
forms means the unit's **own** assertions all passed and a monitor spoke
afterwards. **By standing rule 7 such a red qualifies no row.**

### 5.5 A red at a bench-side check or a driven-port check

Every `test bug --` message, `Arrival.check`'s report, the derived-window checks
(`test bug -- the derived clear window is not 12 .. 16 (release 17)`), the
no-start-character scans, and both driven-`clear` checks (`cycle <n>: clear = <b>,
expected <b>`) are evaluated on the bench's own model of the run, before or
independently of the DUT. **No RTL mutation can move them.** Such a message means
something other than a seeded class: it is reported, it scores nothing in either
direction, and it is a finding of its own kind.

### 5.6 A `NOT SEEDED` at IC-K4 — the three outcomes, pre-fixed

1. **Seeded, red at §4.4's count arm, `M03-K2` green** → **PREDICTED**. IC-K4 is
   killed, **`M03-K1` is QUALIFIED**, and it is the only class in the campaign
   that could have done it.
2. **Seeded, red at §4.4's cycle arm instead** → the rendering re-timed rather
   than carried; §4.4's pre-fixed discriminator and disposition 7 govern. **The
   class scores zero and `M03-K1` stays UNQUALIFIED.**
3. **Self-declared `NOT SEEDED` under `D-K4c`** → the class is **void**: zero
   kills, no claim about `M03-K2` in either direction — **and `M03-K1` is recorded
   UNQUALIFIED AND DECLARED UNQUALIFIABLE BY MUTATION AT ITS OWN STIMULUS**, on
   the ground §2.2 states: its window contains no frame, no strobe condition and
   no start character, so the only conviction available is a carry, and a carry
   that satisfies `D-K1b` is a design that behaves differently in the
   neighbourhood of a clear. **That declaration is a RESULT of this campaign in
   the register `WO-0074` used for `M03-M5`, it goes into the `SO-` in those
   words, and it is not a gap.**

---

## 6. §K — GREEN BY BLINDNESS, and the structural unreachability this round declares

Every claim here is derived from committed text at the base SHA. **A green at any
of these is not vigilance and no verdict may cite it as evidence.**

### 6.1 The differential co-simulation anchor is blind by STIMULUS — bar 4's THIRD instance

Both producers drive `clear` **for exactly one cycle at reset, with an idle word
and nothing in flight** — `test/cosim/ours_run.ml:159`/`:162` and the reference's
`rst` held for the first cycle and released at `test/cosim/tb_xgmii_rx_64.v:257`
— and both hold `cfg_rx_enable` at **1** for the whole run
(`ours_run.ml:160`; `tb_xgmii_rx_64.v:63`). The lane drives **one** 64-octet
good-FCS frame at a lane-0 start with no injection and no second frame.

**Not one of the nine classes in either section is rendered at that stimulus, so
the `cosim` job is predicted `success` under all nine and that green is worth
nothing.** As at family J there is only one candidate cause and it is the
stimulus: the port under test is never driven with anything pending. A strobe
field, a cycle column or a wider canonical form would change nothing. Discharged
only by a co-simulation stimulus that drives `clear` mid-frame — which REQ-901's
own class list does not contain.

### 6.2 `M03-K3` has no assertion, so it has no mutant

`M03-K3` is `NO-ASSERT`: the protocol monitor's frame-in-progress reset is
machinery family K's round **wires**, and no unit title in `test_m03_k.ml` names
the row. **A campaign cannot score an instrument that does not exist.** Recorded
so that a full §K scorecard is not read as full coverage of §4.K.

### 6.3 Both pre-scan guards are unreachable, twice

The `clear` guard (`bench.ml:387–410`) walks cycles `0 … total − 1`, reads the
**driven** clear value and the **driven** word, and raises before the DUT's
outputs are examined; the `Enable` guard (`:346–371`) does the same on
transitions; the structural witness compares `Clear.high_cycles` and
`Clear.value_at` against literals and drives no design at all. **No RTL mutation
can make any of the three fire or not fire.** And the standing fact stands
unchanged: both K rows *enter* the `clear` guard and find nothing, so its **entry**
condition is mechanically witnessed and its **refusal** has never fired on a real
violation — a half-measured instrument, exactly as the `Enable` guard is.

### 6.4 SPEC-M03 §3.2's ambiguity is untouched, by design

Neither K row drives a start character under `clear` = 1 — the guard refuses that
stimulus — so nothing in this campaign says which of §6.2's `Idle` row and §7's
reset bullet governs a cycle carrying both. **That is the guard working**, the
ambiguity is unchanged, and no class here may be read as bearing on it.

### 6.5 REQ-009's header-record clause has no instance at M03

REQ-009 requires *"every header-record `valid` SHALL be 0"* under `clear`. M03
emits **no header record** — SPEC-M03 §4.1's output record is the `rx` stream and
five error strobes. The clause is discharged **by the interface, not by a test**.
Same disposition as `M03-M9`'s and as REQ-810's header clause at family J.

### 6.6 The two plan cells this section convicts before it runs

- **`FINDING K-1` (MAJOR, against my own `WO-0072` §9 and, secondarily, against a
  bench message).** `WO-0072` §9 pre-committed **D1**, **D2** and **D3** as three
  distinct disposition classes with three distinct `BUG-` citations, to be applied
  *"against the CI `build` run at the landing commit"*. **All three move which
  cycles carry a delivered word, so all three raise `M03-K2`'s first
  DUT-observable assertion, whose message names the expected list and prints
  nothing it observed.** Four of this section's six classes land there. The same
  bench contains the same assertion shape at `M03-N4` **printing its observed
  list** (`test_m03_n.ml:1300–1311`), so this is a defect in one message and not a
  limitation of the form. **Second half**: `M03-K2`'s Kills cell claims kill 1 is
  *"reachable at THREE distinct sites"*; the three sites produce **one message**
  and **two** distinct observed lists. **Neither half moves a row; `M03-K2` stays
  `ASSERT` and every assertion in it is correct.** Carriers: the message repair to
  the next commit opening `test_m03_k.ml`; the record to the post-campaign `AP-`
  round.
- **`DECLARATION K-D1`, stated before the run and measured by IC-K4's outcome.**

  > **A row whose stimulus places its window over an interval in which a
  > conformant design has nothing pending and nothing arriving can be convicted
  > only by a defect that CARRIES an observable into that interval — never by one
  > that merely fails to suppress.** `M03-K1`'s window opens one cycle after the
  > frame's own `tlast` and its `error_bad_fcs`, contains only idle input words,
  > and is followed by no start character. Its silence scan is therefore
  > **satisfied by a design that does nothing at all under `clear`**, and its
  > green may never be cited as evidence that `clear` gates anything.

  If IC-K4 kills, this is measured and the row is qualified on the one mechanism
  the declaration names. If IC-K4 is declared `NOT SEEDED`, the declaration
  **stands and hardens into §5.6 outcome 3's unqualifiable finding**. **Either
  way no verdict may cite `M03-K1`'s green as evidence that a `clear` window
  suppresses anything.**

### 6.7 The portable form, recorded because it is not about this bench

**An assertion that names its expected value and does not report the observed one
converts every distinct cause into one indistinguishable effect, and a
disposition table written against such an assertion is a taxonomy rather than a
discriminator.** The cost is invisible while the assertion is green and is paid in
full at the first red, by which time the round that would have repaired it is the
round that needs it. **A pre-committed disposition table SHALL be checked against
the message its own tell will produce, before the run that applies it.**

---

## 7. The K × N CROSS PRODUCT, enumerated before it runs

**Method (`FINDING WO-0074-S4`, carried in as a bar)**: the inventory below is the
cross product of **every class's predicted red set** with **every unit either
section scores**, not an enumeration over the marked cells. **This round the
method's most valuable yield is a NEGATIVE, and the negative is what the
one-campaign ruling rests on.**

### 7.1 The K classes against the N units — 6 × 2 = 12 cells, all `G`

| | `M03-N1` | `M03-N4` |
|---|---|---|
| IC-K1 … IC-K6 | **G** | **G** |

**Ground, measured at §0.1 and §0.3**: neither unit passes `?clear`, so both run
at `Clear.never` and `run` resolves `clear` to `Bits.gnd` on every schedule cycle.
The only `clear` either sees is `create`'s reset pulse, and **(κ2)** excludes it
for every class. **Not one K class's rule (κ1) is satisfied at either unit.**

### 7.2 The N classes against the K units — 3 × 2 = 6 cells, all `G`

| | `M03-K1` | `M03-K2` |
|---|---|---|
| IC-N1, IC-N4a, IC-N4b | **G** | **G** |

**Ground, measured**: both K units run at `Enable.high` (neither passes
`?enable`), so IC-N4a's and IC-N4b's first conjunct fails at both; and no input
word in either K schedule carries a control character in a lane **later** than one
that effects a state change — `M03-K1`'s only closure is a lane-0 `/T/` in an
otherwise-idle-suffixed word and `M03-K2`'s frame A never closes at all — so
IC-N1's rule is not satisfied either.

### 7.3 The N classes against the family-J units — 3 × 3 = 9 cells

| | `M03-J1` | `M03-J2` | `M03-J3` |
|---|---|---|---|
| **IC-N1** | G | G | G |
| **IC-N4a** | G | G | **G** — worked, see below |
| **IC-N4b** | G | G | **G!** |

- **`M03-J3` under IC-N4a is WORKED and predicted GREEN**: its frame 1's start
  character arrives at cycle 11 (lane 0) / 12 (lane 4) while the enable is 0, but
  **frame 0 closed on its own `/T/` at cycle 10**, so there is no frame in flight
  for the refused start to fail to abort. That is a stimulus fact, not a category.
  `M03-J1` and `M03-J2` never admit a frame while disabled, so nothing is ever in
  flight when a refused start arrives.
- **`M03-J3` under IC-N4b is the section's ONE LOAD-BEARING GREEN**, and it
  measures `FINDING J-2` from a run. That finding says `M03-J3`'s strobe clause is
  unfalsifiable in the **subtractive** direction because its in-flight frame is
  clean and owes no strobe. **IC-N4b is the subtractive design.** If it reddens
  `M03-N4` and leaves `M03-J3` green, the asymmetry is established from a run
  rather than from an argument, and `M03-N4` is confirmed as the sole carrier
  `FINDING J-2` named. **A red at `M03-J3` withdraws `FINDING J-2` and the verdict
  says which assertion spoke.**

### 7.4 The pre-committed disposition, in BOTH directions

- **A K-class red at `M03-N1` or `M03-N4`** → **blast radius, qualifying nothing
  in either direction, AND a scope finding**, because it means the rendering
  reached a unit that never drives `clear` on a schedule cycle — a failure of
  **(κ2)** or of the `clear` = 0 column. **Both consequences apply; neither
  substitutes for the other.**
- **An N-class red at `M03-K1` or `M03-K2`** → the same, mirrored, against that
  class's `Enable.high` column.
- **This is the price I named before the ruling, discharged by measurement rather
  than by promise.** At family J the same enumeration produced four blast-radius
  cells at `M03-N4` that a scorecard would otherwise have read as breadth. **Here
  it produces eighteen predicted greens, and if every one of them holds, the
  two-section structure is vindicated on evidence rather than on the argument that
  recommended it.**

---

## 8. §K — collisions, with their discriminators

**Collision 1 — FOUR CLASSES ON ONE CELL, and it is the largest collision this
programme has sealed.** IC-K1 (all three `D-K1a` sites), IC-K3 (both `D-K3a`
branches), IC-K5 and IC-K6 (every `D-K6a` branch) all raise §4.1's message at
`M03-K2`, **character for character, with no integer and no observed data**.

- **Discriminator 1 — the branch identity.** Each class is one diff on one
  transient with one CI run id, in `WO-0077` §12's fixed delivery order. **This is the only
  discriminator that is always available.**
- **Discriminator 2 — `M03-K1`'s colour.** Green under all four. **It does not
  separate them from each other**; it separates all four from IC-K4.
- **Discriminator 3 — the disclosures.** `D-K1a`, `D-K3a`, `D-K5a` and `D-K6a`
  are, for their classes, the only record of what was rendered that a scorecard
  cannot supply.
- **Discriminator 4 — NONE that this bench prints.** Stated in those words under
  standing rule 8. This is `WO-0066`'s IC-D/IC-F situation, `WO-0073`'s collision
  1, `WO-0074`'s collision 1 and `WO-0076`'s collision 3 at their **fifth**
  instance — and the first at which the colliding set has **four** members rather
  than two.
- **Where the cross-product method earned its place here**: three of the four
  members mark that cell, so the old scored-cells-only method would have found a
  three-way collision. **IC-K1's arrival is branch-dependent — under `D-K1a` its
  own marked cell is decided by a disclosure — so under the old method it would
  not have been in the inventory at all.** That is exactly the shape `WO-0074`'s
  fourth collision had.

**Collision 2 — IC-K4's two disclosed members (`D-K4a`: α, presented inside the
window, versus β, held and re-presented on the release cycle)** at §4.4's cell,
character for character **including the derived integer 2** whenever α presents
once.

- **Discriminator: NONE that this bench produces**, because the message prints a
  count and never a cycle. **Carried entirely by `D-K4a`.**
- **`D-K4b` is the only thing that can move the integer**, and a level held across
  the window gives **7** under either member, so the integer separates
  *pulse from level* and never *α from β*.

**Collision 3 — IC-K1 site (i) against IC-K6 with one leaked cycle** produce
**the same observed list** `[4;5;6;14 … 21]` as well as the same message. The
`tlast` on the leaked word is the only difference and **no assertion this round
reaches reads it**, because (B) is shadowed by (A). Carried by `D-K1a` and
`D-K6a` together.

**Near-collisions, named and costing nothing**: IC-K2's cell (§4.2) and IC-K4's
cell (§4.4) are both strobe-set assertions and share **no** characters — different
units, different prefixes, different bodies. §N's three cells share no characters
with any §K cell. **No two classes across the two sections share a scored cell at
all**, which §7 predicts and which the verdict must confirm rather than assume.

---

## 9. §K — pre-committed dispositions

1. **A class red at exactly its `R!` cell, with §4's verbatim string for the
   branch its manifest disclosed, and green at every `G` and `G!`** → **the class
   is KILLED, one kill**, and the row §3.3 names is **QUALIFIED on that class and
   on nothing else**.
2. **A class red at its `R!` cell but also red at a `G!`** → the class's kill still
   counts where its own mechanism is unchanged, **but the measurement the green
   carried is NOT claimed**, and the loss is fixed per class here:
   **IC-K5 at `M03-K1`** withdraws `WO-0072` §7.5's *"invisible here"* derivation
   and the verdict reports which assertion spoke — the withdrawal was argued from a
   stimulus and a red there means the argument was wrong, which is a finding
   against `WO-0072` and **not** against the bench;
   **IC-K1, IC-K2, IC-K3 or IC-K6 at `M03-K1`** means the rendering keys on
   `clear` as such rather than on the class's own conjunct, **the reds are blast
   radius, the class scores ZERO, and `M03-K2` stays UNQUALIFIED**;
   **IC-K4 at `M03-K2`** means the carry is not conditional on a pending strobe,
   same disposition, **class scores ZERO and `M03-K1` stays UNQUALIFIED**.
3. **A class not reachable at its `R!` cell** — a self-declared `NOT SEEDED` — is
   **void**: zero kills, **no claim about any row in either direction**. **IC-K4 is
   the one class whose void carries a positive result**, and §5.6 outcome 3 states
   it: `M03-K1` is then declared **UNQUALIFIABLE BY MUTATION at its own stimulus**,
   in the verdict and in the `SO-`.
4. **A class red at an `R!` unit through `assert_monitors_clean`, through a
   bench-side check, or through a driven-port check** → §5.4 and §5.5 govern; the
   class's kill is not counted from that red and standing rule 7 forbids the
   qualification.
5. **A rendering that is neither disclosed branch** → §5.1: every cell of that
   class is `U`, reported rather than scored.
6. **Two classes delivered in one diff** → **both are unscoreable**, reported as a
   manifest defect and not as a result. **A shared `clear` gate term across IC-K1,
   IC-K5 and IC-K6 is NOT this case** (`WO-0073-VERDICT` §7 Q4).
7. **ANY class red at a cell outside its own §7-of-the-packet permission list** —
   a moved word count, cycle, `tkeep`, `tuser` or octet at a frame the class may
   not touch, a strobe cycle at a stimulus with no driven `clear` window, or any
   red at a unit that never drives `clear` on a schedule cycle — → the rendering
   reached further than the class, **it is out of specification: reported, not
   scored**, and disposition 3's *"no claim in either direction"* governs.
   **§4.4's cycle-arm message is this disposition's named instance.**
8. **A red at any of the 79 non-M03 behavioural units, or at any of the 57 M03
   units that never drive `clear` on a schedule cycle** → a **scope finding**
   against the manifest, and specifically a failure of **(κ1)/(κ2)** — most likely
   **(κ2)**, the reset pulse, which is this section's newest and least obvious
   conjunct. **A red at `test/hardcaml_ethernet/`'s single unit, or a failing build
   step** → a **build finding**, never behavioural. **A red in `test/cosim/`** → a
   finding against §6.1's derivation, and a very interesting one.
9. **No kill anywhere is evidence about `M03-K3`, about either pre-scan guard,
   about SPEC-M03 §3.2's ambiguity, about REQ-009's header-record clause, or about
   the `frames_exempt` count's independence** (§6.2–§6.5). This disposition binds
   the verdict, not the manifest.
10. **A `NOT SEEDED` at any class is priced as a job either way** and is never a
    reason to re-order or re-cut the remaining transients.

---

## 10. §K — mutant-owned quantities

| quantity | sealed | direction |
|---|---|---|
| `<n>` at `M03-K1` under **IC-K4** (§4.4) | **`> 1`**, two derivations named (**2** under `D-K4b` *pulse*, **7** under `D-K4b` *level*) | **more** — a carry adds high cycles; **the only mutant-owned integer with a bench-side direction in the whole of §K** |
| the **cycle** an IC-K4 rendering presents on | `12 ≤ c ≤ 17` — the window and its release — **and UNPRINTED at the scored cell** | which is why `D-K4a` exists |
| the **observed delivered-cycle list** at `M03-K2` under IC-K1, IC-K3, IC-K5, IC-K6 | **mutant-owned and deliberately UNREAD** — §4's per-class predictions are stated so a scorecard that somehow reports the list can be checked against them, and a disagreement is **information, never a finding** | the cell prints none of it (`FINDING K-1`) |
| the **name and cycle** of the strobe an IC-K2 rendering adds | **class-fixed and UNPRINTED at the scored cell** | REQ-009 forbids all five equally; §4.2's message prints neither, which is why `D-K2a` exists |
| the settling depth `d` under IC-K3 *late* | `d ≥ 1`, **UNPRINTED** | `D-K3b` |
| `M03-K1`'s **8** delivered words, its strobe cycle **11**, `M03-K2`'s expected list, every `tkeep`, `tuser`, octet and sequence outside a class's permission list | **not mutant-owned** — spec-fixed by REQ-005, REQ-011, REQ-103, REQ-104, REQ-106, §6.1, §7, §9 | the packet's §7 as a seal: any movement is out of specification, not a rendering's prerogative |
| `sample.clear`, every derived window/start/terminate cycle, `Arrival.cycles`, `start_spacings`, `gaps`, `frames_exempt`, both guards | **not mutant-owned** — bench-supplied | evaluated on the bench's own model before or independently of the DUT (§5.5) |
| **units reddening under a class** | `⊆` the class's **RULE** at §3.4, **(κ1)** and **(κ2)** included | a red outside the rule is a finding: either my rule was wrong or the diff reaches further than the class it names |

**Three of the seven rows are specification-fixed or bench-supplied and are sealed
as equalities on purpose**; calling them mutant-owned would be buying an
unfalsifiable seal. **The third row is the confession this seal owes its reader**:
at four of §K's six scored cells there is **no mutant-owned axis to seal at all**,
because the cell prints nothing a mutant chose. A previous seal would have written
those cells as exact strings and called them predictions. **They are predictions
about WHICH ASSERTION SPEAKS AND AT WHICH UNIT, and about eighty-four other units
staying green — and they are not predictions about anything the mutant computed.**
Standing rule 8 exists so that this is said at the cell rather than discovered at
adjudication.

---

## 11. §N — the N-completion matrix

### 11.1 The units, worked

| unit (row it carries) | IC-N1 | IC-N4a | IC-N4b |
|---|---|---|---|
| **M03-N1** (M03-N1) | **R!** | G | G |
| **M03-N4** (M03-N4) | G | **R!** | **R!** |
| **M03-N2** (M03-N2, family N, already qualified at `WO-0066`) | ***r*** | G | G |
| **M03-B2**, **M03-B2 /I/**, **M03-B2 /Q/**, **M03-B3**, **M03-B4** (family B) | ***r*** | G | G |
| **M03-J3** (M03-J3, family J, qualified at `WO-0076`) | G | G | **G!** |
| **M03-J1**, **M03-J2** (family J) | G | G | G |
| **M03-K1**, **M03-K2** | G | G | G |

**`G!` count in this section: 1** — `M03-J3` under IC-N4b, §7.3's load-bearing
green. **Total across both sections: 6 + 1 = 7**, enumerated at §3.1 (six) and
§7.3 (one), and the arithmetic is shown at both places so no prose count can
disagree with a matrix (`FINDING WO-0076-S2`'s bar).

### 11.2 Kills and qualifications, per class

| class | kills | qualifies | reds that are BLAST RADIUS and qualify nothing |
|---|---|---|---|
| **IC-N1** | **1** | **`M03-N1`**, on §9's third row / C-12 — *"the `/E/` finds no open frame and produces nothing and pulses nothing"* | `M03-N2`'s six sub-cases; `M03-B2`, `M03-B2 /I/`, `M03-B2 /Q/`, `M03-B3`, `M03-B4` — **eleven or more reds, one kill, and NOT ONE of them qualifies a family-B or family-N row** |
| **IC-N4a** | **1** | **`M03-N4`**, on its Observable clauses 1 and 3 (the abort geometry and the absent output word for the refused start) | — (the rule selects one unit) |
| **IC-N4b** | **1** | **`M03-N4`**, on its Observable clause 2 (**exactly one** `error_start_without_terminate`) | — |
| **§N maximum** | **3** | | |

**Two classes qualify `M03-N4`. That is two kills and ONE qualification.**
**`M03-N1` and `M03-N4` have been qualified by NO campaign before this one**
(`FINDING AP-3`, measured across the whole class-based era at `J-dv_lead-0143`);
these are the first reds at either row's own cells under classes seeded against
the rows' own observables, and the verdict says so in those words.

### 11.3 The rules, with their COMPLETE conjunct lists

**IC-N4a's and IC-N4b's first conjunct is the same and is measured (§0.3)**: *the
unit drives `cfg_rx_enable` low at some cycle of its run.* Four units satisfy it
and **no rule here can select a fifth.** **IC-N1's first conjunct is different in
kind** and is the reason its blast radius is the widest of the nine.

| class | RULE — the class reddens a unit iff … | conjuncts the rendering may NOT remove |
|---|---|---|
| **IC-N1** | … the unit drives an input word in which an **earlier** lane effects a state change **and** a **later** lane carries a control character whose routing depends on that state | every word in which **no** lane effects a state change — **every all-idle word in the suite, all eight of whose lanes are control**; every delivered word at a frame no such word closes; the `Idle` row's *"ignores every lane"* where no earlier lane moved the state |
| **IC-N4a** | … a **start character arrives while a frame is open and `cfg_rx_enable` is 0** | the admission gate (**retained** — no frame may begin at the refused start); the `cfg_rx_enable` = 1 path entire; the report path; every frame untouched by a refused start |
| **IC-N4b** | … a **strobe is owed on a cycle at which `cfg_rx_enable` is 0** | the `cfg_rx_enable` = 1 path entire; the emission path entire — **no delivered word may move**; every strobe owed on a cycle at which the enable is 1 |

### 11.4 Worked instances beneath the rules

- **IC-N1** — the rule's set is **`{M03-N1, M03-N2 (six sub-cases), M03-B2,
  M03-B2 /I/, M03-B2 /Q/, M03-B3, M03-B4}`**, derived from the units' own stimulus
  titles at the base tree. **And the class runs in TWO DIRECTIONS, which is the
  strongest check the rule has**: at `M03-N1` the word starts in **`Frame`** and
  the later lane should have seen **`Idle`**, so the class **ADDS** a strobe; at
  every selected family-B unit the word starts in **`Idle`**, the earlier lane's
  `/S/` moves it to **`Preamble`**, and the later lane should have seen
  `Preamble`'s exits, so the class **REMOVES** one. **A scorecard showing only
  additions or only removals is a finding against this rule**, and it is the sort
  of finding the rule exists to make possible. `M03-B4 (b)` is **UNWORKED**: its
  two start characters are in **different** input words, so the rule's same-word
  conjunct is not obviously satisfied and this seal does not claim it either way.
- **IC-N4a** — the rule's set is **`{M03-N4}`**, measured: it is the only unit in
  the bench whose stimulus places a start character inside an open frame while the
  enable is 0. **`M03-J3` is WORKED and predicted GREEN and it is the boundary**:
  its frame 1's start arrives at cycle 11/12 while the enable is 0, but frame 0
  closed on its own `/T/` at cycle 10, so nothing is in flight.
- **IC-N4b** — the rule's set is **`{M03-N4}`**, measured: it is the only unit in
  the bench in which a strobe is **owed** on a cycle at which the enable is 0.
  `M03-J1`'s hundred refused frames are clean and owe none; `M03-J2`'s frame 100
  is clean; **`M03-J3`'s in-flight frame 0 is clean and owes none, which is
  precisely `FINDING J-2`** (§7.3).

---

## 12. §N — the REQUIRED cells, verbatim

### 12.1 IC-N1 — `M03-N1`, the strobe set over the whole run — branch **α**

```
M03-N1 (lane 0): the out-of-frame /E/ unexpectedly produced a strobe
```

**No integer: this cell is exact in every character.** It is the row's own kill
cell and the direct assertion of its Observable's second clause. It is reached
only because the class changes nothing the three assertions before it read — the
delivered-word count (**8**), the per-word cycles (**4 … 11**), `tlast` position,
final `tkeep` (**0x0F**) and `tuser` (**0**), and the delivered octets.

**Sealed under `D-N1c` branch α (report only).** Under branch **β** (report and
suppress) the class reaches an **earlier** assertion and the cell is instead

```
M03-N1 (lane 0): expected 8 delivered words, got <n>
```

with `<n>` **mutant-owned**, sealed **`< 8`**, derived **7** — the mis-routed
character's own no-output-word consequence applied to the frame the `/T/` was
closing, which costs the word at cycle 11. **Direction: fewer.** **Both branches
score IC-N1 and both qualify `M03-N1`**, because both are assertions of the row's
own Observable — clause 2 under α, clause 1 (*"the `/T/` closes the frame
normally"*) under β. `D-N1c` decides which, and an unanswered `D-N1c` makes both
cells `U`.

**`D-N1a`'s strobe name and cycle are UNPRINTED at branch α's cell** — the
assertion tests emptiness and prints neither.

### 12.2 IC-N4a — `M03-N4`, the delivered-sample cycle list

```
M03-N4 (lane 0): delivered-sample cycles are [<observed>], expected [4; 14; 15; 16; 17; 18; 19; 20; 21]
```

followed by a newline and `Enable.report enable`, which is **bench-supplied and
UNREAD**. The separator inside both lists is `"; "` — semicolon and space.

`<observed>` is **mutant-owned**, sealed as **a strict superset of the expected
list, in ascending order, gaining the contiguous run `5 … 11` — seven cycles —**
so the derived list is
`[4; 5; 6; 7; 8; 9; 10; 11; 14; 15; 16; 17; 18; 19; 20; 21]`. **Direction: more**
— a frame that is not aborted delivers the words it would have delivered with the
enable held at 1, and frame A's own `/T/` at octet time 80 closes it at cycle 10,
putting its eighth word at cycle 11. **`D-N4a-1` is the only thing that can change
the count**: a rendering that *holds* on W (§6.2's C-14.4 hold) gains **six**
rather than seven and the run is `6 … 11`. **A gained set that is not a contiguous
run beginning at 5 means the rendering moved something else and disposition 7
governs.**

**This is the ONE cell in the campaign whose message prints the mutant's own
observation**, which is why its direction is a real bench-side discriminator here
and is not at `M03-K2`. Stated as a contrast rather than as a boast: it is the
same assertion shape as §4.1's, in the same bench, written to report.

### 12.3 IC-N4b — `M03-N4`, the exact strobe set over the whole run

```
M03-N4 (lane 0): expected exactly one strobe (error_start_without_terminate at A's own report cycle), observed <n>
```

`<n>` is **mutant-owned**, sealed **`< 1`**, derived **0** — the class suppresses
every strobe on a cycle at which the enable is 0, and frame A's own report is owed
at cycle **4** (lane 0) / **5** (lane 4), inside the disabled window
(`disable_cycle` 2 / 3, `enable_cycle` 10 / 11). **Direction: fewer** — a
suppression cannot add a pulse.

**It is reached because the class changes nothing the eleven assertions before it
read**: the delivered-sample cycle list, frame A's word count, its `tlast`, its
`tkeep`, its `tuser`[0] = **1**, its content, frame C's word count, its cycles,
its `tkeep`/`tuser`, its content and its sequence number. **That is the strongest
compound statement in either section** — the whole delivered stream of an aborted
frame and a re-admitted one, unmoved, with only the report gone.

---

## 13. §N — UNWORKED cells, shadowed members, and pre-fixed adjudication

### 13.1 Shadowed members

`M03-N1`'s and `M03-N4`'s **lane-4 members** are structurally unobservable in a
passing-to-failing run: `run_n1 ~row:"M03-N1 (lane 0)"` and
`run_n4 ~row:"M03-N4 (lane 0)"` are called first and raise first.
**Adjudication, fixed here**: a unit's cell is scored on the **lane-0** member; a
lane-4 string is scored **only** if the scorecard reports it, which requires lane
0 to have been green — itself a finding under the class's own rule. R-DISC-1's
per-lane discharge is still required: **a lane discharged term by term and merely
unobserved is recorded as unobserved, never as a miss and never as a pass.**

**The lane-4 derived values, sealed so a lane-4 report can be scored if one
arrives**: `M03-N1 (lane 4)` — 8 words at cycles 4 … 11, final `tkeep` **0xFF**,
64 delivered octets, terminate octet time **88**, `/E/` at **93**.
`M03-N4 (lane 4)` — expected list `[4; 5; 15; 16; 17; 18; 19; 20; 21; 22]`,
`w_cycle` **4** lane **4**, `a_delivered` **16**, change cycles **3** and **11**,
frame C at cycle **12** lane **0**, A's report cycle **5**; under IC-N4a the
gained run is `6 … 11` **plus** cycle **12** is already C's start, so the derived
observed list is `[4; 5; 6; 7; 8; 9; 10; 11; 15; 16; 17; 18; 19; 20; 21; 22]`.

### 13.2 The blast-radius cells, adjudication pre-fixed

Every IC-N1 red at `M03-N2` or at a family-B unit **qualifies nothing**, in either
family, and contributes **zero** additional kills. **A green at any unit the rule
selects is a FINDING** under standing rule 5, adjudicated per row. **The messages
at those units are UNWORKED**: this seal does not enumerate family B's or
`M03-N2`'s message strings, because no cell scores them and working them would be
sealing predictions this round cannot spend. **Their appearance in a scorecard is
information, never a cell.**

### 13.3 The assertions shadowed in every §N class

At `M03-N1` under branch α: everything after (D) — the accounting call and
`assert_monitors_clean`. Under branch β: everything after (A). At `M03-N4` under
IC-N4a: everything after (A) — frame A's whole per-word block, its content, frame
C's whole block, the strobe set, the accounting and `word_delay`. Under IC-N4b:
the accounting, `word_delay` and `assert_monitors_clean`.

**The breadth figure, on §5.2's terms exactly.** Measured:
`grep -cE '(^|[^_a-zA-Z])fail($| )' test/xgmii_rx_64/test_m03_n.ml` → **94**
matching lines at the base tree, of which **33** carry `test bug` and are
bench-side by their own text — and that file carries **eight** units, only two of
which this section scores, so the figure is a loose upper bound and is offered as
nothing else. **Counted exactly**: this section's three classes reach **THREE
distinct raise sites** (branch α) or **FOUR** (if `D-N1c` returns branch β, which
moves IC-N1's cell to a different site) — `M03-N1`'s strobe-set emptiness check or
its delivered-word count, `M03-N4`'s delivered-sample cycle list, and `M03-N4`'s
exact-strobe-set check.

**Across the whole campaign: six distinct raise sites, seven if `D-N1c` returns
β, in four units of fifty-nine.** That is the breadth number, it is the numerator
counted exactly, and **the verdict states it that way rather than as a ratio whose
denominator nobody counted.**

### 13.4 A `NOT SEEDED` in §N

Any §N class self-declared `NOT SEEDED` is **void**: zero kills, no claim about
any row in either direction. **`IC-N4b` is the one whose void would be
expensive**: it is the sole carrier for `FINDING J-2`'s named uncovered class, and
a void there leaves that finding raised and unmeasured for a third campaign
running. Named here so a void is read as the cost it is rather than as a tidy
result.

---

## 14. Bounds this campaign does NOT close, named before the result

1. **`M03-K3` is unscoreable and stays unscored** (§6.2). Survives any outcome.
2. **`M03-K1` may end UNQUALIFIED**, and §5.6 outcome 3 is what that means and
   what the `SO-` must then say.
3. **The differential co-simulation anchor is blind to every class here by
   stimulus** (§6.1), and remains undischarged besides — bar 4's third instance.
4. **Both pre-scan guards are unreachable by any mutation and the `clear` guard's
   refusal path remains unfired** (§6.3).
5. **SPEC-M03 §3.2's ambiguity and REQ-009's header-record clause are not testable
   at this module or this bench** (§6.4, §6.5).
6. **`M03-N4`'s zero-delivered branch has no legal stimulus** and nothing here
   reaches it; **`M03-N3` is `NO-STIMULUS`**; **REQ-802/§9.1's reset column is
   unobservable at this bench.**
7. **Every lane-4 member in §N is unobserved, not tested**, and **the campaign
   reaches six distinct raise sites in four units** — both silence scans, both
   control runs, every per-word assertion and every counter among the untouched
   (§5.2, §13.3).
8. **`FINDING K-1` and `DECLARATION K-D1` are raised and unrepaired**; both are
   plan and bench text and both have named carriers (§6.6).
9. **`FINDING J-1`'s second half is unrepaired** and its carrier is still
   unscheduled.
10. **A kill proves the assertion convicts, never that the bench is a general
    detector of the class.** IC-N1 is detected at up to twelve units; **this bench
    was NOT blind to it** and no verdict may imply it was.
11. **Nothing here bears on the `SO-`'s remaining gates other than the campaign
    debt itself**: the charter §3 anchor and the lessons harvest both survive a
    clean sweep.

---

## 15. Pass criteria

1. **Each class reddens exactly its `R!` cell**, with §4's or §12's verbatim string
   for the branch its manifest disclosed, and **stays green at every `G` and
   `G!`**.
2. **No unit outside the class's own RULE (§3.4, §11.3) reddens** — and in
   particular **all 57 clear-free M03 units, all 79 non-M03 behavioural units and
   `test/cosim/` hold under every K class**, and **all 55 enable-free M03 units
   hold under IC-N4a and IC-N4b**. A red at `test/hardcaml_ethernet/` or a failing
   build step is read as a **build** finding.
3. **The unmutated control is green at the base SHA**, with its CI run id and
   conclusion quoted. **CI is the authority** (ADR-0005).
4. **Kills are counted per class**: nine classes, at most **nine** kills — six in
   §K and three in §N, reported as two numbers and never summed into one row's
   evidence.
5. **All nineteen disclosures are answered before the run.** A branch inferred by
   me from a scorecard is not a disclosure and the affected cells score as `U`.
   **This round is stricter than its predecessors on this point and §8 collision 1
   is why**: four classes share one character-exact cell, so an unanswered
   disclosure is not a gap in the record, it is the loss of the record.
6. **The verdict states §6's and §14's declarations whatever the score is** — the
   anchor's stimulus blindness, `M03-K3`'s unscoreability, both guards'
   unreachability, §3.2's untouched ambiguity, the header clause's non-instance,
   `FINDING K-1` in both halves, and `DECLARATION K-D1`'s outcome. They are the
   round's own contribution and they are not contingent on a kill.
7. **The verdict states, per class, which reds are blast radius** (§11.2), names
   no family-B or family-N row qualified by IC-N1's radius, and states explicitly
   that **`M03-N2` is qualified by nothing here** and **`M03-J3` is qualified by
   nothing here**.
8. **The verdict states §5.2's and §13.3's breadth figures in their own form** —
   **six distinct raise sites reached across four units of fifty-nine, seven if
   `D-N1c` returns branch β** — with the numerator counted and the denominator
   quoted only as the measured upper bound, never as a ratio nobody counted. **And
   it states that neither K silence scan and neither control run is reached by any
   class in a campaign about `clear`.**
9. **The verdict reports the K × N cross product's eighteen predicted greens
   individually as held or not held** (§7). If all eighteen hold, the two-section
   structure is vindicated on evidence and the verdict says so in those words; if
   any fails, it is a scope finding **and** the ruling that adopted one campaign is
   recorded as having cost something, with the amount stated.
10. **The verdict reports each class's branch name and CI run id.** Without them
    §8 collision 1 makes four of the six K classes unadjudicable, and a verdict
    that scores them anyway is scoring a scorecard rather than a campaign.

---

## 16. Not to be told

§0's MUST-STAY-GREEN sets and both censuses' consequences, §1's row prefixes, §2's
orders and derived numbers, §3's and §11's matrices, kill tables,
qualification/blast-radius tables, rules with their conjunct lists and worked
instances, §4's and §12's verbatim strings and predicted lists, §5's and §13's
shadowed sets and pre-fixed adjudications, §6's blindness declarations and
`DECLARATION K-D1` in its entirety, §7's cross-product matrices and its one
load-bearing green, §8's named collisions and their discriminators, §9's
dispositions, §10's inequality table, §14's bounds, §15's pass criteria.

**Freely told, and told in `WO-0077`**: the nine classes and the sentence each is
derived from; the nineteen mandatory disclosures; the denominator and both
censuses and their empty intersection; the structural facts of clear-low
invariance and the reset pulse, and the three instrument kinds; the twelve
declarations of what the campaign cannot score, including `FINDING K-1` in full;
the reachability standard and the five-path gate inventory; the per-class
permission lists; the allowlist, the manifest-only rule and the abort-first
direction check; the base SHA, the ordering rule and the absent hazard; the
mutant-owned axes and the confession that four cells have none; the *existence* of
a four-class collision and a branch pair and the fact that the cross product found
them and proved eighteen cells empty; the qualification rule and the two sections'
separation; the price and the two sole exercisers; the non-closures and carriers;
the weighting; the return format and the three questions.
