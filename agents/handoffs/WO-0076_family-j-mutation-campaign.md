# WO-0076: the family-J mutation campaign — five configuration classes against a capability only four units in the bench exercise, and the first campaign in this programme whose classes are *permitted* to move the datapath

- **State**: **DRAFT** — dv_lead's draft. The orchestrator issues it, operates it
  (PROTOCOL §10's transient model) and allocates its id (PROTOCOL §3); `0076` is
  the id the spawn allocated and is used throughout.
- **From** / **To**: dv_lead → **auditor** (manifest author), via the
  orchestrator (campaign operator, and — per `FINDING WO-0074-A1`, ruled
  ACCEPTED — the **sole** cutter of the transient branches; §7.1).
- **Spec basis**: `docs/specs/modules/xgmii_rx_64.md` **§4.3** in its entirety —
  the sampling sentence (*"a frame whose start character is accepted at least one
  cycle after the input changes is governed by the new value, and a frame already
  in flight completes under the old one"*), the three-clause **"What the enable
  gates"** statement, and **"The case that forced the ruling"**; **§6.1**'s
  *"When `cfg_rx_enable` is 0"* paragraph in full, including its conservation
  clause; **§6.2**'s `Idle`, `Preamble`, `Frame` and `Discard` rows at their
  `cfg_rx_enable` conditions; **§6.3 item 7** (**C-14.5**); **§7**'s
  configuration-sampling bullet; **§9**'s closure list and its **clause (b)**;
  **§10**'s REQ-802/REQ-810 hook and its REQ-110 hook; **§4.1**/**§4.2**'s
  `cfg_rx_enable` port. `docs/specs/requirements.md` **REQ-810** in full (the
  three prohibitions, the admission clause, the silent-discard disclaimer),
  **REQ-803**, **REQ-802** and **§9.1**'s `receive enable` row, **REQ-008**,
  **REQ-110**, **REQ-016**, **§0.6**, **§0.7**. **ADR-0014** in full.
- **Plan basis**: `test/attack_plans/AP-xgmii_rx_64.md` **§4.J** rows `M03-J1`
  … `M03-J4` with their Kills cells **as they read today** — in particular
  `M03-J2`'s **withdrawn** cell and the **honest kill** that replaced it
  (2026-08-09, `WO-0067` §6, `J-dv_lead-0124`), which this packet seals against
  and never against the struck text; **§4.N**'s `M03-N4`; **§2** items 1–4 (the
  standing monitors and the C-23 counting convention); **§7**'s X-rows and its
  banner **bars 1–4**.
- **Bench basis**, named because a campaign scores *files*:
  `test/xgmii_rx_64/test_m03_j.ml` (three units), `test_m03_n.ml`'s `run_n4`
  (two members), `test_m03_structural.ml`'s `Bench.Enable.change_cycles`
  witness, and `bench.ml`/`bench.mli`'s `Enable` module and its **M03-J4
  pre-scan guard** — all at the base SHA.
- **Binding**: the auditor's **R-DISC-1** and **R-DISC-2** (`DISP-0001` §4,
  `fab31de`) bind these manifests and are adjudication criteria for them.
- **Method carried in as a bar**: **`FINDING WO-0074-S4`'s corrected collision
  method** — *derive the collision inventory from the cross product of every
  class's predicted red set with every scored cell, never from the scored cells
  alone* — banked as a bar on this seal at `AP-xgmii_rx_64.md` §4.M's
  post-campaign block item 4 and §9's 2026-08-10 row item 8. **It is applied,
  and §10 says where it changed what I sealed.** So is
  **`FINDING WO-0074-S1`'s**: every rule below states its **complete conjunct
  list** — every gate the rendering may *not* remove — so that no rule silently
  describes a class this packet forbids.
- **The seal**: `WO-0076_family-j-mutation-campaign-SEALED-predictions.md`,
  frozen in **this packet's own commit**, before any diff exists. **If this
  commit does not stage that file, this round has no seal**, its cell-level
  claims may not be made, and the absence is a finding against me — my own rule,
  written against me at `J-dv_lead-0113` Open-question 1 and restated at
  PROTOCOL §10's **R-SEAL-1**.
- **Precedent carried in terms**: `WO-0063B`'s pre-run reading note. **If the
  manifest raises a question for me, it comes to me BEFORE the run**, as a
  committed reading note, not as a post-hoc reading of a scorecard. It paid for
  itself twice at `WO-0074` (rulings (b) and (c) both corrected my own seal
  before a scorecard existed) and is worth more here than there, because three
  of this round's five classes are *permitted* to move the datapath and the
  permission has to be exact.

---

## Section map

| § | what it fixes |
|---|---|
| 0 | what a capability family's campaign is, and the five things this round cannot do |
| 1 | the five intent classes and their nine mandatory disclosures |
| 2 | the denominator, re-measured at this tree — and the **enable census**, which is the number that decides this round |
| 3 | the convicting instruments, measured from the landed files: **enable-high invariance**, and the assertion order inside each of the four units |
| 4 | **what this campaign structurally cannot score, declared before it runs** — including two findings against my own plan text |
| 5 | reachability, discharged term by term — both sides |
| 6 | §4(c) as a test — and this round the check is **per class, with the permitted movement named** |
| 7 | the allowlist, the manifest-only rule, and the abort-first HEAD check |
| 8 | the base SHA, the adjudicator-ordering rule and its one live hazard; the bounded classes' scoring rules |
| 9 | mutant-owned quantities, and how they are sealed |
| 10 | collisions: **derived by `FINDING WO-0074-S4`'s cross product**, and what they cost the manifest |
| 11 | the qualification rule for a family that owns its own units |
| 12 | cost, priced before seeding |
| 13 | what this round does NOT close, and the owed list with carriers |
| 14 | weighting, discounted in advance |
| 15 | what comes back |
| 16 | not to be told |

---

## 0. What a capability family's campaign is, and the five things it cannot do

Three rows landed at `2dbd39b` and **not one of them has been scored**:
`M03-J1`, `M03-J2`, `M03-J3`. They are the **oldest unscored rows in this
programme** — landed before families L, M and K's rows existed, and passed over
by eight campaigns. This packet is the ninth campaign and it pays that debt.

Family J is unlike every family scored to date in one structural way that
governs the entire design, and it is stated first because every later section
depends on it:

> **Family J is the only family in this bench whose rows drive a
> configuration input away from its default.** Its subject is not a frame
> shape, a character or a closure kind: it is the `cfg_rx_enable` port and the
> `Bench.Enable` capability `WO-0067` built to drive it. **Measured at the base
> tree (§2): exactly four units in fifty-nine ever drive that port low** —
> `M03-J1`, `M03-J2`, `M03-J3` and family N's `M03-N4`. The other **fifty-five
> run at `Enable.high` and are byte-for-byte blind to every class here.**

That shape has two consequences that decide this packet.

**First — the qualification criterion, stated once, here, in the form every
later section uses:**

> **A class qualifies its J row iff it reddens that row's own unit at an
> assertion of that row's own observable** — the disabled window's silence, the
> re-enabled frame's delivery, or the in-flight frame's completion against its
> reference run. A red arriving through `assert_monitors_clean`'s monitor arms
> qualifies nothing (§5.4 of the seal), and a red at a bench-side guard or
> stimulus check qualifies nothing and is not a seeded class at all (§4 item 4).

**Second — and this is what makes family J different in kind from family M —
three of the five classes are *permitted* to move the datapath, and one is
*required* to.** Family M's campaign could state a single global rule (*nothing
may move but the strobe set*) because every M row's observable was a strobe set.
Family J's observables **are** the delivered stream: `M03-J1` asserts that no
word appears, `M03-J2` that eight do, `M03-J3` that eight appear
**byte-for-byte and cycle-for-cycle identical to a reference run**. A class that
moved nothing would be invisible. So §6's check is **not** the qualification
criterion this round — it is a **per-class permission list**, and writing it as a
global prohibition would have failed a conformant rendering of three of the five
classes. That inversion is this round's own methodological content and it is
declared before the run rather than discovered by a scorecard.

**Five things this round cannot do, stated first so no verdict drifts into
them.**

1. **It cannot qualify `M03-J4`.** That row is `NO-STIMULUS`: SPEC-M03 §6.3
   item 7 and carry-forward **C-14.5** leave the outcome of a change landing on
   a start character's own cycle **deliberately unconstrained**, so *every*
   design is conformant there and every mutation of it is an **equivalent mutant
   by specification**. This is a stronger disposition than `M03-M8`'s
   no-stimulus and `M03-M9`'s no-instance: there the observable could not be
   produced; here it can be produced and **may not be asserted on**. Neither a
   gap nor a seedable row (§4 item 1).
2. **It cannot score the `Bench.Enable` guard, and no campaign ever can.** The
   M03-J4 pre-scan guard and its structural witness are **bench-side**: the
   guard reads `Enable.change_cycles` and the **driven word** before a cycle is
   driven, and the witness drives no design at all. **No RTL mutation can make
   either fire or not fire** (§4 item 4).
3. **It cannot pay the charter §3 differential co-simulation anchor**, and the
   reason is `WO-0075`'s bar 4 in its sharpest instance: the lane holds
   `cfg_rx_enable` **at 1 for the whole run on both sides** — measured, at
   `test/cosim/ours_run.ml:142` and `test/cosim/tb_xgmii_rx_64.v:63` — so **not
   one of the five classes is rendered at that stimulus at all** (§4 item 5).
4. **It cannot open an `SO-`.** Family **K** remains unscored after this round,
   and the anchor is undischarged per class.
5. **It cannot measure the lane-4 members.** `M03-J3` and `M03-N4` each iterate
   lane 0 then lane 4 inside one unit; lane 0 raises first, so every lane-4
   member is **structurally unobservable in a passing-to-failing run** and is
   recorded **unobserved — never as a miss and never as a pass** (§4 item 7).

---

## 1. The five intent classes

Each is **one kill**, never one kill per reddened unit. Each is derived from a
sentence of §4.3, §6.1, REQ-810 or REQ-803, and each is named with the row whose
cell it instantiates — **and where the plan's Kills cell does not reach the
class, §4 says so rather than letting the naming imply it did.**

### IC-J1 — the enable does not gate admission (REQ-810's first sentence)

**Ground**: REQ-810 — *"When `receive enable` is 0 the receive path SHALL accept
no frame: for every frame it refuses it emits no output word on any receive-path
stream …"* — and SPEC-M03 §4.3's *"when `cfg_rx_enable` = 0, M03 accepts no
frame — it treats every start character as absent"*.

Render a design in which the enable does not gate the **acceptance of a start
character**: a start character arriving while the enable is 0 opens a frame
exactly as it would while the enable is 1.

**Required consequence**: at `M03-J1`'s 101-frame schedule the first hundred
frames are admitted and **delivered**, so an output word appears inside the
disabled window. Everything else about those frames is unchanged — they are
well-formed 64-octet frames and a conformant design would deliver them exactly
this way *if it had admitted them*, which is precisely why this class is a
**pure admission** defect and not a datapath one.

**Permitted movement (§6)**: the delivered stream of any frame the specification
requires to be **refused**. **Not permitted**: any change to a frame the
specification requires to be **delivered** — its word count, its cycles, its
`tkeep`, its `tuser`[0] or its octets.

#### 1.1 MANDATORY DISCLOSURE **D-J1a** — what the rendering removes

Name the term you removed and confirm it is **the admission gate alone**. If the
enable input becomes **unread** anywhere else in the design as a side effect —
in particular if the state machine's `Idle → Preamble` transition is the only
site and removing it also changes the `Discard → Preamble` and `Frame →
Preamble` conditions §6.2 states separately — say so, listing every transition
your one edit reaches. The class permits reaching all of them; the seal needs to
know whether it did.

#### 1.2 MANDATORY DISCLOSURE **D-J1b** — enable-high invariance

State positively that with `cfg_rx_enable` held at **1** your rendering is
byte-identical to the base at every stimulus. **This is the single conjunct that
protects fifty-five of the fifty-nine M03 units** (§3.2), and a rendering that
fails it does not score (§8.1 rule 4).

### IC-J2 — a refused frame is reported (REQ-810's third prohibition)

**Ground**: REQ-810 — *"for every frame it refuses it emits no output word on
any receive-path stream, asserts no header-record `valid` and asserts no strobe
— no frame is accepted, so this creates no silent-discard hole under
REQ-008"* — and `AP` §4.J's `M03-J1` Kills cell, whose parenthetical names the
design in terms: *"it would **report 100 discards for frames it never
accepted**"*.

Render a design that **pulses a strobe for each frame the disable refuses** —
the design a reader of REQ-008 writes when they mistake refusal for a discard
that owes a report. The admission gate is **retained**: no output word appears,
no frame is accepted; only the report is added.

**Required consequence**: at `M03-J1` a strobe pulses inside the disabled
window, with **no output word anywhere in it**; at `M03-J2` the same stimulus
delivers frame 100 correctly and still carries the strobes; at `M03-J3` the
refused frame 1 draws a strobe the row's own last clause forbids in terms.

**Permitted movement**: the strobe set at a **refused** frame. **Not
permitted**: any output word, and any strobe belonging to an **admitted** frame.

#### 1.3 MANDATORY DISCLOSURE **D-J2a** — which strobe, and on which cycle

M03 has five error outputs (`error_bad_fcs`, `error_bad_frame`, `error_runt`,
`error_oversize`, `error_start_without_terminate`) and REQ-810 forbids **all**
of them for a refused frame, so the class is the same whichever you pick.
**Name the one you used and the cycle your rendering pulses on** — the refused
start character's own cycle, or that frame's would-be report cycle. The seal's
cell prints a **cycle**, that cycle is mutant-owned (§9), and the disclosure is
the only thing that can distinguish a rendering that fired where you meant it
from one that fired somewhere else.

#### 1.4 MANDATORY DISCLOSURE **D-J2b** — one pulse per refused frame, or a level

State whether your rendering pulses **once per refused frame** or holds a level
across the disabled window. Both are the class; **C-23's counting convention**
(`error_pulses` reports presence per name per cycle) makes them different
integers at one cell and identical at another, and §9 seals the affected
quantity as an inequality for exactly this reason.

### IC-J3 — the enable gates the datapath rather than the start character (`M03-J3`'s own Kills cell)

**Ground**: `AP` §4.J's `M03-J3` Kills cell in terms — *"A design that gates the
datapath rather than the start character: it truncates the in-flight frame with
no `tlast` and no strobe, which is a silent discard REQ-009 does **not** license
(only `clear` may do that)"* — which is **ADR-0014**'s rejected reading and the
price that ADR puts on it. SPEC-M03 §6.1: *"A frame already in flight is not
affected by the change and completes under the old value."*

Render a design in which `cfg_rx_enable` gates the **emission of output words**
continuously, rather than (or in addition to) the acceptance of a start
character: while the enable is 0 no word leaves the module, whatever admitted it.

**Required consequence**: at `M03-J3` the in-flight frame 0, admitted while the
enable was 1, loses every word from the change cycle onward — the silent discard
ADR-0014 forbids — while its **reference run at `Enable.high` is untouched**.

**This class is the round's own measurement of the `M03-J2` honest-kill
correction, and it is why that correction was worth landing.** `WO-0067` §6
withdrew *"a design that samples the enable continuously and truncates the frame
it just admitted"* from `M03-J2` on the ground that **J2's stimulus cannot
separate it from a conformant design** — the enable is 1 for the whole of frame
100's admitted extent — and re-pointed it at `M03-J3`, *"the only geometry at
which a continuously-sampling design truncates"*. **IC-J3 is that design.** The
correction predicts `M03-J3` red and `M03-J2` **green**, and §8.1 fixes both
outcomes before the run. A bench cannot make that measurement; a campaign can.

**Permitted movement**: the delivered stream of a frame in flight across a
1 → 0 change. **Not permitted**: anything at `Enable.high`, and any change to a
frame whose whole extent lies inside an enabled window.

#### 1.5 MANDATORY DISCLOSURE **D-J3a** — moved gate, or added gate

Does your rendering **move** the gate (remove the admission gate and add an
output gate) or **add** an output gate while retaining admission gating? **Both
are the class**, they are message-identical at every scored cell (§10 collision
3), and the seal branches on the disclosure alone. Answer before the run.

#### 1.6 MANDATORY DISCLOSURE **D-J3b** — what happens to the frame's own report

Does the truncated frame still pulse the strobe it would have owed, or is that
suppressed too? Frame 0 at `M03-J3` is **clean and owes no strobe**, so the
answer changes no cell there (§4 item 6) — but it decides `M03-N4`'s behaviour
and the seal records which.

### IC-J4 — the re-enable is not honoured at the next start character (`M03-J2`'s **honest** kill)

**Ground**: REQ-803 — *"a configuration change applies to every frame whose
first word is accepted at least one cycle after the change"* — SPEC-M03 §4.3's
identical sentence, §7's *"`cfg_rx_enable` is sampled at each start character"*,
and `AP` §4.J's `M03-J2` Kills cell **as it reads today**: *"a design that
**refuses the first frame after a re-enable** — one that latches the enable to a
frame boundary that never arrives while the line is idle, or that needs more
than one cycle of settling before a start character may be admitted."*

Render a design that does not admit a frame whose start character arrives
**exactly one cycle** after the enable rises.

**Required consequence**: at `M03-J2` frame 100 is refused — no output word for
it anywhere in the run. Everything about the disabled window is unchanged: the
hundred refused frames stay refused and silent, which is what makes this class
`M03-J2`'s and not `M03-J1`'s.

**This class is sealed against the CURRENT plan text and against nothing else.**
The struck cell — the continuous-sampling truncation — is **IC-J3's**, is
scored at `M03-J3`, and **no cell in this campaign may qualify `M03-J2` on it**,
whatever a scorecard shows. That prohibition is the plan's own
(`J-dv_lead-0124`) and it binds this verdict.

**Permitted movement**: the delivered stream of the first frame admitted after a
0 → 1 change. **Not permitted**: any frame admitted two or more cycles after the
change, and anything at `Enable.high`.

#### 1.7 MANDATORY DISCLOSURE **D-J4a** — which of the two named renderings

The plan's cell names two designs: **(L)** the enable is latched at a frame
boundary that never arrives while the line is idle, and **(S)** admission needs
more than one cycle of settling after a change. **Both are the class.** State
which you rendered, and for **(S)** state the settling depth in cycles.

#### 1.8 MANDATORY DISCLOSURE **D-J4b** — the 1 → 0 direction

Does your rendering delay the **disable** as well as the enable? A design that
takes an extra cycle to *stop* admitting is a different defect: it would admit a
frame the specification requires refused, which is IC-J1's territory at a
one-cycle scale. Name the direction your edit is asymmetric in, or declare it
symmetric.

### IC-J5 — the in-flight frame is *affected* by the change (REQ-803's own words)

**Ground**: SPEC-M03 §6.1 — *"A frame already in flight is **not affected** by
the change and completes under the old value (REQ-803)"* — and REQ-803's
*"never to a frame already in flight on that path"*. `AP` §4.J's `M03-J3`
Observable states the test of it: *"its words, its `tlast`, its FCS/runt verdict
and its strobes are exactly those of the same frame with the enable held at 1."*

Render a design in which a frame in flight across a 1 → 0 change **completes,
but is marked**: every word at its own cycle, every octet, every `tkeep`, the
`tlast` where it belongs — and `tuser`[0] = 1 on that `tlast` word, reporting a
frame the change never should have touched.

**Required consequence**: at `M03-J3` the disabled run delivers **exactly eight
words at exactly the reference run's cycles with exactly its octets**, and
differs from it in **one bit**. This is the only class in this campaign that
reaches `M03-J3`'s **tuple comparison** — the instrument that row was built for
— and it reaches it *because* it changes nothing the earlier assertions read.

**Permitted movement**: `tuser`[0] on the `tlast` word of a frame in flight
across a 1 → 0 change. **Not permitted**: the word count, the cycles, the
`tkeep`, the octets, the strobe set, or anything at `Enable.high`.

#### 1.9 MANDATORY DISCLOSURE **D-J5a** — the marked quantity

State whether your rendering marks the frame via `tuser`[0], via a strobe, or
both. **The class is the first.** A strobe-only rendering does not reach the
tuple comparison at `M03-J3` (the strobe check is later in the unit, §3.3) and
scores a different cell; a both rendering reaches the tuple comparison first and
scores the class's own cell with a second, unsealed red behind it. Answer before
the run.

---

## 2. The denominator, re-measured at this tree — and the enable census

Re-measured at the base tree, **not carried forward** from `WO-0074`:

```
    3  test_m03_a.ml    7  test_m03_b.ml    4  test_m03_c.ml    3  test_m03_d.ml
    4  test_m03_e.ml    4  test_m03_f.ml    7  test_m03_g.ml    4  test_m03_h.ml
    5  test_m03_i.ml    3  test_m03_j.ml    2  test_m03_k.ml    2  test_m03_l.ml
    8  test_m03_n.ml    3  test_m03_structural.ml
  ---
   59  test/xgmii_rx_64/ (the M03 bench)
  139  test/ (repository-wide, OCaml units)
```

**59 M03 units; 139 repository-wide; 80 non-M03**, split `monitors` 37 +
`xgmii` 25 + `golden` 11 + `axi64_probe` 3 + `xgmii_probe` 3 = **79
behavioural**, and `hardcaml_ethernet` **1 build-level**. `test/cosim/`
contributes **0 units**.

> **`FINDING M-4`'s repair is VERIFIED HERE, and the contamination it removed
> has already grown.** The repaired matcher in `tools/dv_checks.sh` reads a
> **file type** and reports **139**. The old directory-scoped matcher —
> `grep -rh 'let%expect_test' test/ | grep -c .` — reports **141** at this tree,
> not the 140 it reported at `ca1bb80`: `test/attack_plans/AP-xgmii_rx_64.md`
> gained two further prose quotations of the literal when the family-M campaign
> was absorbed. **The instrument was over-reporting by one for eight campaigns
> and would be over-reporting by two for this one.** The general form was banked
> at `WO-0074` §2 and holds: *a counting instrument scoped to a directory rather
> than to a file type counts its own documentation, and the contamination grows
> in proportion to how well the project documents itself.*

**The census that decides this round — the enable census, measured and not
recalled** (`FINDING K-3`: a universal in a bar is measured at its own tree
before the bar is written, or it is not a bar):

```
grep -rn --include=*.ml '~enable' test/     ->  8 sites, of which
    test/xgmii_rx_64/bench.ml:229, :429      the capability's own plumbing
    test/xgmii_rx_64/test_m03_j.ml:223, :457 explicit ~enable:Enable.high
    test/xgmii_rx_64/test_m03_j.ml:169       M03-J1's disabled run
    test/xgmii_rx_64/test_m03_j.ml:279       M03-J2's disabled run
    test/xgmii_rx_64/test_m03_j.ml:488       M03-J3's disabled run  (both members)
    test/xgmii_rx_64/test_m03_n.ml:1256      M03-N4's disabled run  (both members)
grep -rln --include=*.ml 'Enable\.' test/   ->  4 files: bench.ml, test_m03_j.ml,
                                                test_m03_n.ml, test_m03_structural.ml
```

**Exactly four units in the whole repository drive `cfg_rx_enable` away from
`Enable.high`**: `M03-J1`, `M03-J2`, `M03-J3` (two members) and `M03-N4` (two
members). **Fifty-five of the fifty-nine M03 units and all seventy-nine non-M03
behavioural units never drive it at all** and are MUST-STAY-GREEN under every
class by a single property of the rendering (§3.2). `test_m03_structural.ml`'s
`Enable.change_cycles` unit references the module and drives **no design**.

**Family J owns 3 of the 59.** `M03-N4` is family N's, already scored at
`WO-0066`, and every red it takes here is **blast radius** (§11).

---

## 3. The convicting instruments, measured from the landed files

**Method, so it is checkable**: every `fail`/`failwith` reachable from each of
the four units was enumerated in source order at the base SHA and classified by
the object it reads — DUT output, bench model, or monitor report. The result is
the seal's §2; the parts a manifest author needs are here.

### 3.1 The three instrument kinds, and only one of them can convict a design

| kind | what it reads | can a mutation move it? |
|---|---|---|
| **bench-side stimulus derivation** — `Arrival.check`, the 101-frame count, frame 100's start cycle 1051, the change cycle 1050, the no-start-character check at 1050, the 50/50 lane split, `Injection.outcomes`, both landing checks | the schedule and the driven word, before or independently of the DUT | **No.** A message from one of these means something other than a seeded class (§5.5 of the seal) |
| **driven-window checks** — `sample.enable` against an independently written predicate | the value the bench drove, read back at the same choke point | **No.** `sample.enable` is `run`'s own argument resolved per cycle; the DUT does not produce it |
| **DUT-observable assertions** — every delivered word, every strobe, and the two reference/control runs | the design's outputs | **Yes. These, and only these, are this campaign's cells** |

### 3.2 The one structural fact this campaign rests on — **enable-high invariance**

Fifty-five of the fifty-nine M03 units and all seventy-nine non-M03 behavioural
units run at `Enable.high`. **A rendering that leaves the `cfg_rx_enable` = 1
behaviour byte-identical therefore cannot redden any of them**, by construction
and not by care. That single conjunct is:

- the **whole** of the MUST-STAY-GREEN guarantee outside the four units;
- **D-J1b**'s disclosure, demanded of every class and not only of IC-J1;
- and the reason §8.1 rule 4 can dispose of a wide rendering without argument:
  a class that reddens units which never drive the enable has not rendered a
  configuration defect at all.

**Two consequences, both load-bearing.** (a) The campaign's instrument footprint
is **four units of fifty-nine** — the narrowest of any campaign in this era, and
it is a property of what family J *is*, not of what this packet chose. (b) A red
at a fifty-fifth unit is not a bigger kill; it is a **scope finding** (§8
disposition 8).

### 3.3 The assertion order inside each convicting unit — measured, not assumed

**`M03-J1`** (`run_j1`): stimulus derivation → **the disabled-window silence
scan (tvalid checked before strobes, per sample, samples in cycle order)** →
the driven-window check → the accounting calls → **the control run at
`Enable.high`** (101 `tlast` words → 101 segmented frames → sequence numbers
0 … 100) → `assert_monitors_clean` on the disabled bench, then on the control
bench.

> **The silence scan is the FIRST DUT-observable assertion in the unit**, so a
> red there is *not* a compound statement, and everything after it — including
> the control run that proves the schedule carries 101 well-formed frames — is
> **shadowed** by it. **And the unit asserts nothing directly about frame 100's
> delivery**: its only instrument for the re-enabled frame is the latency
> tagger's bench-supplied expectation, reached through `account_clean_frame`
> and reported by `assert_monitors_clean` (§4 item 8).

**`M03-J2`** (`run_j2`): stimulus derivation (shared, §5.1 of the bench) →
**the delivered-word count** → per word: cycle → `tkeep` → `tlast`/`tuser` →
delivered octets → **the sequence number** (provenance: this is frame 100 and
not merely *a* frame) → the empty strobe set → accounting →
`assert_monitors_clean`.

**`M03-J3`** (`run_j3`, lane 0 then lane 4): construction and schedule checks →
**the reference run at `Enable.high`** (2 `tlast` words → 16 delivered words →
delivered octets → empty strobe set) → **the disabled run's word count** → the
**tuple comparison** against the reference → the **cycle comparison** against
the reference → the disabled run's `tlast` count → the refusal check (no word at
or after frame 1's `start_cycle + 3`) → the empty strobe set → the driven-window
check → accounting → `assert_monitors_clean` on the disabled bench, then the
reference bench.

> **`M03-J3`'s reference run speaks first**, and it runs at `Enable.high`. So
> **every scored cell in that unit is a compound statement**: the class's own
> effect **and** the whole enable-high path unmoved, on the same schedule, in the
> same unit. That is a stronger cell than the other two units can raise, and it
> is a property of the row's own instrument rather than of anything this packet
> did.

### 3.4 Iteration and shadowing

Every unit is its own `%expect_test`, so **no unit shadows another** and all
four are independently observable in one run. **Inside a unit, members shadow**:
`M03-J3` and `M03-N4` each iterate **lane 0 then lane 4**, and only the first
reddening member is observable in a passing-to-failing run. R-DISC-1's discharge
is still required **per lane**: a member discharged term by term and merely
unobserved is recorded **unobserved**, never as a miss and never as a pass.

### 3.5 The blast-radius rule

`FINDING WO-0066-3` cost me three MUST-STAY-GREEN violations because my seal
carried an **enumeration** where the auditor's manifest carried a **rule** and
the rule was right; `WO-0073` and `WO-0074` both adopted the correction and it
held. **This round keeps it, with `FINDING WO-0074-S1`'s amendment**: every
predicted red set is stated as a **rule in stimulus terms**, the rule names its
**complete conjunct list** — including every gate the rendering may *not* remove
— and **the rule governs where rule and instance list disagree**. A red selected
by the rule is predicted blast radius and contributes **zero** additional kills;
a red outside the rule is a finding.

**Two facts about the rules' shape are told here**, because they are facts about
the bench and not about the answer:

- **Every rule in this campaign has the same first conjunct**: *the unit drives
  `cfg_rx_enable` low*. Four units satisfy it. **No rule in this campaign can
  select a fifth unit**, and a class that reddens one has failed §3.2.
- **IC-J5's rule selects exactly one unit** — the narrowest in the programme
  since IC-M1's — because it needs a 1 → 0 change **while a frame is open** and
  a unit that **asserts that frame's `tuser`**, and only `M03-J3` is both.

---

## 4. What this campaign structurally cannot score — DECLARED BEFORE IT RUNS

Every statement here is derived from committed text at the base SHA. None of it
is contingent on the result.

1. **`M03-J4` has no mutant, and the ground is stronger than a missing
   stimulus.** SPEC-M03 §6.3 item 7 and C-14.5 leave the same-cycle change
   *deliberately unconstrained*, and §4.3 says the governing sentence covers only
   a start character accepted **at least one cycle after** the change. **A design
   may do anything there and be conformant**, so every rendering of that
   behaviour is an **equivalent mutant by specification**. The bench refuses to
   drive the stimulus at all (§4 item 4). Declared, not omitted.
2. **REQ-810's "asserts no header-record `valid`" prohibition has NO INSTANCE at
   M03.** This module emits no header record — §4.1's output record is the `rx`
   stream and five error strobes. `M03-J1`'s Observable carries the clause
   (*"no header effect"*) and it is discharged **by the interface, not by a
   test**. No kill in this campaign is evidence for it and no `SO-` may claim it
   as tested coverage here. Same disposition as `M03-M9`'s.
3. **REQ-802/§9.1's reset value for `receive enable` is unobservable at this
   bench.** `Bench.create` drives `cfg_rx_enable` = 1 through the reset cycle and
   `run` drives a value **every** cycle from cycle 0, so no run ever observes the
   field's own reset behaviour. A mutation of the reset value is invisible here.
   Declared so that no `SO-` counts §9.1's reset column as covered by family J.
4. **The M03-J4 pre-scan guard and its structural witness are bench-side and
   unreachable by any mutation.** The guard walks the driven cycles, compares
   `Enable.value_at` against itself, and reads the **driven word** — all before
   the DUT's outputs are examined; the witness (`test_m03_structural.ml`)
   compares `Enable.change_cycles` against literals and drives no design. **A
   guard message in this campaign means something other than a seeded class**;
   it is reported, it scores nothing in either direction, and it is a finding of
   its own kind. **And the standing fact stays standing**: the guard's *entry*
   condition is mechanically witnessed, its *refusal* has never fired on a real
   violation, so it remains a half-measured instrument — unchanged by this round
   in either direction.
5. **The differential co-simulation anchor is blind to this entire campaign, and
   the ground is STIMULUS, not grammar.** Both producers hold `cfg_rx_enable`
   at 1 for the whole run (`test/cosim/ours_run.ml:142`;
   `test/cosim/tb_xgmii_rx_64.v:63`), and the lane drives **one** 64-octet
   good-FCS frame with no configuration change anywhere. **Not one of the five
   classes is rendered at that stimulus**, so a green `cosim` job is evidence of
   nothing. This is `WO-0075`'s **bar 4** in its purest instance — the round that
   raised it corrected `WO-0074`'s *"by grammar"* claim to a stimulus claim, and
   here there is no second candidate: adding a strobe field or a cycle column
   would change nothing, because the port under test is never driven low.
6. **`M03-J1`'s Kills cell names a design its own stimulus cannot separate —
   `FINDING J-1`, against my own plan text.** The cell reads *"A design that
   gates the output but leaves the strobe path live"*. Under the **narrow**
   reading — the condition-detection machinery keeps running while the output is
   gated — **the hundred refused frames are clean, well-formed, 64-octet,
   good-FCS frames that owe no strobe under any rendering**, so the class emits
   nothing and is identical to a conformant design at this stimulus. Only the
   cell's own **parenthetical** reading — *"it would report 100 discards for
   frames it never accepted"*, i.e. a design that **reports refusal** — is
   separable, and that is IC-J2. **This is the seventh instance in this plan of a
   Kills cell naming a design its row's stimulus cannot reach**, after M03-D3,
   M03-F2, M03-I2, M03-J2, M03-K1 and M03-N4, and it is found the same way all
   six were: by working the row's own arithmetic while authoring the packet that
   commissions it, before a diff exists. **Disposition, and it is the precedent
   applied unchanged**: the row **stays ASSERT** — its Observable is REQ-810's
   own and is sound — and what the finding changes is **the claim a round may
   make about the row**, never its status. **A second half of the same finding**:
   the row's Observable has *three* clauses (no output word, no header effect, no
   strobe) and its Kills cell attacks **one** of them; the no-output-word clause,
   which is REQ-810's first sentence and this campaign's IC-J1, has **no Kills
   cell at all**. **Carrier: the post-campaign `AP-` round** (§13.1).
7. **`M03-J3`'s strobe clause is unfalsifiable in the subtractive direction —
   `FINDING J-2`.** The row's Observable says the in-flight frame's *"strobes are
   exactly those of the same frame with the enable held at 1"*. **That frame is
   clean and owes none**, so a design that **suppresses** an in-flight frame's own
   strobe — REQ-810's three prohibitions read *unscoped*, the reading ADR-0014
   prices and rejects — is invisible at `M03-J3`. The row **can** convict a design
   that **adds** a strobe (its `disabled run: an error strobe pulsed` clause, which
   IC-J2 reaches), and the asymmetry is what this finding names. **The carrier
   that does convict the suppressing design is `M03-N4`**, whose in-flight frame
   A owes an `error_start_without_terminate` — family N's row, scored at
   `WO-0066`, and **not** a family J qualification in either direction. Declared
   before the run; **carrier: the post-campaign `AP-` round.**
8. **`M03-J1` asserts nothing directly about frame 100.** Its title says *"the
   re-enabled frame 100 is received correctly"*; no assertion in the unit reads
   frame 100's delivered stream. The only instrument that sees a refusal there is
   the **latency tagger**, through `account_clean_frame`, reported by
   `assert_monitors_clean` — a **bench-supplied** expectation, not the row's own
   observable. **IC-J4 measures exactly this**, and §8.1 fixes what may be said
   in both directions. The claim in the title is not false; what it is not is an
   assertion.
9. **The `frames_exempt` count is bench-supplied and is not evidence a frame was
   driven.** It counts the calls the unit made. This standing caution is the
   plan's own (`J-dv_lead-0124`) and this campaign neither strengthens nor
   weakens it: no mutation can move it.
10. **Every lane-4 member is shadowed, not measured** (§3.4), and so is every
    assertion ordered after the first reddening one in each unit.

**None of items 1–10 is a defect in the bench and none moves a row.** Items 6
and 7 are defects in **my own plan text**, found here and repaired nowhere here.

---

## 5. Reachability, discharged term by term — both sides

**R-DISC-1 binds your manifests** (`DISP-0001` §4). For **each** of the five
classes separately: name the gate signal, quote its **complete** defining
expression from the base file with line numbers, and evaluate **every** conjunct
on the named stimulus at the claimed firing cycle, calling out which conjuncts
are contributed by the **stimulus** rather than by the mutation.

**Per-lane evaluation is required wherever the class's own consequence names
more than one.** `M03-J3` and `M03-N4` each drive **both** start lanes; discharge
at **both** for every class that selects them. A lane you did not evaluate is
**NOT SEEDED** for scoring purposes.

**Three cycle facts must be discharged explicitly, because every class turns on
one of them**: (a) the cycle at which the driven `cfg_rx_enable` changes;
(b) the cycle at which the start character your class must admit or refuse is
**accepted**; (c) the distance between them, in cycles, against §4.3's *"at
least one cycle after"*. At `M03-J1`/`M03-J2` that distance is **exactly one**
(change 1050, start 1051) and it is the tightest legal placement — which is what
makes IC-J4 reachable at all and what makes a rendering with two cycles of
settling reddening there a *conformant-looking* design that is not.

**R-DISC-2**: **name the three paths and say which your class touches.** This
campaign's gate inventory is **admission** (the enable's gate on start-character
acceptance), **emission** (the output-word path) and **report** (the five
strobes' enables). Each path gets a gate-inventory row carrying its full term
list and every intent's claim about it, **before delivery**, with **cross-class
gate facts tabulated** — every term two classes both touch, named before delivery
rather than discovered. Expected shape, stated so a shared site is not mistaken
for a combined diff: **IC-J1 and IC-J3 will both touch the admission gate** (one
removes it, one moves it) and **IC-J2 and IC-J3 will both touch a path the enable
does not currently reach**. `WO-0073-VERDICT` §7 Q4 governs: a shared site is not
a combined diff. **Five separate diffs remain mandatory.**

**And the same standard applies to me, on the bench side, discharged here.**
Every `R!` cell in the seal is a message raised by an assertion whose own terms
are:

- **(a)** the stimulus reaches the assertion — every unit is its own
  `%expect_test`, so no unit shadows another; inside a unit the members shadow
  and §3.4's order is the whole of the adjudication;
- **(b)** the observable is read from the DUT's own outputs under the `Before`
  view, so a pulse belongs to the cycle whose input word was driven and a
  delivered word belongs to the cycle it left on;
- **(c)** every assertion ordered **before** the scored one is unmoved under the
  class — which for `M03-J3` means the **whole reference run** (§3.3), and is
  discharged per class at §6;
- **(d)** nothing outside the unit is required for the conviction.

---

## 6. §4(c) as a test — and this round the check is PER CLASS, with the permitted movement named

**The measured datapath-perturbation signature** (`BUG-0003` §V.10.2,
`J-dv_lead-0103`, transient tree `5c47582`): **(a)** 7 mid-frame words with
`tkeep` ≠ 0xFF and `tlast` = 0; **(b)** 4 of 60 required octets in their gapless
byte positions, 28 delivered as the idle filler `0x07` and **28 never delivered
at all**; `tlast` on word 7; `tuser` = 0 on a corrupted frame.

`WO-0063B` recorded that the signature had **no domain** at the unit it was
scoring. `WO-0073` recorded a domain and a side condition. `WO-0074` recorded the
check and the qualification criterion as **the same test**. **This round is
different from all three, and the difference is the honest one**: three of five
classes are *supposed* to change which frames are delivered, so a global
prohibition would fail a correct rendering. The check therefore takes the form
it should have taken wherever a family's observable is its datapath:

> **Every class declares, before it is seeded, the exact set of delivered-stream
> facts it is permitted to move. Everything else must be byte- and
> cycle-identical to the base. The signature's components are permitted to NO
> class in this campaign.**

The permission lists are in §1 and are repeated here as the check:

| class | permitted to move | must be identical |
|---|---|---|
| **IC-J1** | the delivered stream of frames the specification requires **refused** | every frame the specification requires **delivered**; every strobe; everything at `Enable.high` |
| **IC-J2** | the strobe set at a **refused** frame | every delivered word anywhere; every strobe of an **admitted** frame; everything at `Enable.high` |
| **IC-J3** | the delivered stream of a frame in flight across a **1 → 0** change | every frame whose whole extent lies inside an enabled window; everything at `Enable.high` |
| **IC-J4** | the delivered stream of the **first** frame admitted after a **0 → 1** change | every frame admitted two or more cycles after a change; every refused frame; everything at `Enable.high` |
| **IC-J5** | `tuser`[0] on the `tlast` word of a frame in flight across a **1 → 0** change | that frame's word count, cycles, `tkeep` and octets; every strobe; everything at `Enable.high` |

1. **The auditor's pre-ship check, for ALL FIVE classes.** Before delivering
   each manifest, confirm the rendering produces **none** of the signature's
   components at any stimulus, and confirm **positively** that every fact in the
   right-hand column above is identical to the base — in particular the
   `Enable.high` column, which is `D-J1b` and is demanded of every class.
2. **My adjudication check, and it is executable.** In `M03-J2` and `M03-J3` the
   delivered-word count is asserted before the per-word facts, and in `M03-J3`
   the whole reference run is asserted before the disabled run. So a rendering
   that moves something outside its permission list raises a message this seal
   places at a **different** assertion from the class's own cell, and the seal's
   §4 records which. A red at a permitted-movement class's own cell is therefore
   still a compound statement — just a smaller one than family M's.

**Consequence, fixed here so it cannot be renegotiated**: a class red at a cell
**outside** its own permission list is scored as **the class out of
specification — reported, not scored**, no claim about the affected J row is
made in either direction, and the class's kill is not counted from that red.

---

## 7. The allowlist — BLINDED, and absolute

**This is the complete set of repository paths you may read for this campaign's
duration. Everything else is out of bounds, absolutely.**

| | readable |
|---|---|
| 1 | `libs/hardcaml_ethernet/src/xgmii_rx_64.ml` **and its `.mli`**, at the base SHA — the mutation target |
| 2 | `docs/specs/requirements.md` and `docs/specs/modules/xgmii_rx_64.md` — the specs this packet names |
| 3 | **this packet** |
| 4 | `docs/adr/ADR-0014.md` — named because three of the five classes are derived from a reading it adjudicates, and reading the ADR is reading normative reasoning, not an answer |
| 5 | `docs/reports/audit/**` — your own tree |

**Out of bounds, absolutely, for the campaign's duration**: **all of `test/**`**
— which includes `test_m03_j.ml`, `test_m03_n.ml`, `test_m03_structural.ml`,
`bench.ml`/`bench.mli`, `test/xgmii/`, `test/monitors/`, `test/cosim/` **and the
attack plan `test/attack_plans/AP-xgmii_rx_64.md`** — **all of `agents/**`, this
packet excepted and its sealed companion emphatically not excepted**, and every
journal. The seal names cells, message strings, assertion orders and
MUST-STAY-GREEN sets; reading it is reading the answer. **The AP is barred by
name because three of this campaign's classes are quoted from its Kills cells**,
and a manifest author who reads the row that authored the class is choosing a
diff against a written expectation rather than against the specification.

### 7.1 Manifest only — the auditor does not cut a branch

**`FINDING WO-0074-A1` (MAJOR, auditor's, ruled ACCEPTED) is carried into this
round's terms rather than left to be re-derived.** The auditor delivers
**manifests**: patch text, the substitution table, the discharges, the
disclosures and the pre-ship check. It does **not** cut, commit or push the
transient branches — PROTOCOL §2 makes the orchestrator the sole operator of
git and §6/R7 puts `libs/**` outside the auditor's scope. **The operator cuts
the five transients itself, from the manifest's own table, in §10's fixed
delivery order**, and reports each branch name and CI run id. This is stated
before the round rather than discovered inside it.

### 7.2 The abort-first HEAD check

**First action, before reading anything**: run `git rev-parse HEAD` and compare
it against §8's base SHA as the operator supplies it. **If it does not match,
STOP and report in one line.** A manifest authored against one tree and applied
to another is not a manifest, and the failure is silent in every artefact the
round produces.

### 7.3 What the manifests must carry

Per R-DISC-1 / R-DISC-2:

1. **Five diffs** — IC-J1, IC-J2, IC-J3, IC-J4, IC-J5 — each **minimal and
   independent**: each applies alone to the base SHA, elaborates, and reverts
   cleanly. **No diff may combine two classes**; a combined diff makes both
   unscoreable, and §10 says why that matters here.
2. **A reachability discharge per class, per named lane, term by term at the
   firing cycle**, with the stimulus-contributed conjuncts called out and §5's
   three cycle facts explicit — or a **self-declared NOT SEEDED** for any term
   you cannot discharge.
3. **Gate-inventory rows** for the **admission**, **emission** and **report**
   paths, with every class's claim about each, and **cross-class gate facts
   tabulated**.
4. **All nine disclosures answered in your own words**: **D-J1a**, **D-J1b**,
   **D-J2a**, **D-J2b**, **D-J3a**, **D-J3b**, **D-J4a**, **D-J4b**, **D-J5a**.
5. **The §6 pre-ship check result for all five classes**, in its positive form,
   against that class's own permission list — including the `Enable.high`
   column for every class.
6. **The base SHA you applied to**, quoted, and confirmation that it matches
   §8's and the HEAD check of §7.2.
7. **Anything the packet made you guess.** A question about this packet comes to
   me as a committed **pre-run reading note** **before** the run, and I answer it
   in the same form. A question answered after a scorecard exists is not a
   question, it is a negotiation.

---

## 8. The base SHA, and the adjudicator-ordering rule

**One base SHA for the whole round** — all five classes, the control run and
every MUST-STAY-GREEN sweep. `BUG-0003` §V.9's *"one round cannot carry two base
SHAs in its evidence"* governs.

**The base SHA is the commit that stages this packet and its seal.** Not its
parent — the corrective drafting rule adopted at `WO-0073-VERDICT` §7 after
`FINDING WO-0073-M1`, applied for the third time. I cannot state its hash: I
never run git (PROTOCOL §2), and the commit has none until the orchestrator
creates it. **The orchestrator records the hash when it lands**; the auditor
quotes the hash it applied to (§7.3 item 6), and any disagreement is a finding
**before** the campaign runs, not after.

**The adjudicator-ordering rule, stated because it is what makes any of this
evidence.** **The bench must be frozen strictly earlier in history than any
mutant RTL it judges.** Concretely:

- Every `test/**` byte this campaign scores against is at or before the base
  SHA. The last `test/**` edit before this packet is `c109c08`
  (`J-dv_lead-0139`, the cosim-lane round, which touched
  `test/attack_plans/AP-xgmii_rx_64.md` and `test/cosim/dune`); **this packet
  stages no `test/**` byte**, and **nothing under `test/**` moves again until
  the campaign scores.**
- The seal is frozen in this packet's own commit — **after** the last bench edit
  and **before** the first mutant diff exists.
- **No diff body reaches me until every diff is committed on its transient
  branch.** I adjudicate against the seal, and the seal is opened only when the
  scorecards are in hand.
- If any `test/**` file is edited between this commit and the scorecard, **the
  round is adjudicated as having no valid base** and re-runs from a fresh seal.
  **That includes edits by me.**

### 8.0 The one live hazard, named before it fires

**`WO-0075` is outstanding and its return edits `test/cosim/**`.** Landing it
inside this campaign's window would break the freeze above by its own words.
Two dispositions, and **the choice is the operator's, not mine**:

- **(recommended)** hold `WO-0075`'s return until this campaign scores. The
  campaign costs ≈ 29 minutes of CI (§12) and the cosim lane is blind to every
  class in it (§4 item 5), so the hold buys the freeze for nothing.
- or land `WO-0075` **before** the commit that stages this packet, moving the
  base forward by one commit. The seal is re-frozen against that commit and
  §2's denominators re-measured; nothing else changes.

**If it lands inside the window anyway, the round re-seals.** I am not writing
myself a carve-out for `test/cosim/**` on the ground that it contributes no unit:
`FINDING K-3`'s rule is that a bar unmeasured against its own tree is a hope, and
a freeze with an exception I invented after the fact is worse than that. **This
is question 1 for ruling** (§15).

### 8.1 Scoring rules for the classes whose value is bounded by a measurement

**IC-J3 and the `M03-J2` honest-kill correction — fixed before the result:**

1. **`M03-J3` red at its own cell AND `M03-J2` GREEN** → the class is KILLED,
   `M03-J3` is QUALIFIED, and **`WO-0067` §6's withdrawal is MEASURED**: J2's
   stimulus really cannot separate a continuously-sampling design, which the
   finding argued from the stimulus and this round establishes from a run. This
   is the `FINDING M-1`/`M-2` pattern one family over.
2. **Both red** → the class is KILLED and `M03-J3` is QUALIFIED, **but the
   measurement is NOT claimed**, and the *finding runs in `M03-J2`'s favour*: a
   red there would mean the withdrawn cell was reachable after all, which is a
   `FINDING against the withdrawal` and a **restoration question** for the AP
   round, not a defect in the bench. Either way `M03-J2` is **not** qualified on
   this class — the plan's prohibition is absolute.
3. **`M03-J2` red and `M03-J3` green** → the rendering keys on something other
   than a continuous sample; the class scores **zero** and `M03-J3` stays
   UNQUALIFIED.

**IC-J3 and `M03-J1`'s absence-shaped observable — fixed before the result:**

1. **`M03-J1` GREEN under IC-J3** → **`DECLARATION J-D1` stands and is
   measured**: a silence assertion cannot distinguish *never admitted* from
   *admitted and muted*, and `M03-J1`'s green may never be cited as evidence of
   the former.
2. **`M03-J1` red under IC-J3** → the declaration is **withdrawn** and the
   mechanism by which it reddened is reported; the class's kill still counts at
   `M03-J3` where its own mechanism is unchanged.

**IC-J4 and `M03-J1`'s frame-100 instrument — fixed before the result:**

1. **`M03-J1` red under IC-J4 through a monitor arm only** (a
   `latency tagger unclean` message, with every one of the row's own assertions
   green) → **§4 item 8 is measured**: the row's own observable does not read
   frame 100, and the catch belongs to a bench-supplied expectation. The red
   **qualifies nothing** (§11), and the class's kill is `M03-J2`'s.
2. **`M03-J1` red at one of its own assertions** → §4 item 8's derivation is
   wrong and is corrected in the verdict; the kill is still `M03-J2`'s.
3. **`M03-J1` fully GREEN under IC-J4** → the monitor arm does not see it
   either, which is a **stronger** version of item 8 and is reported as such:
   the unit would then be blind to the refusal of the very frame its title
   names. No claim about `M03-J1` is made in either direction from a green.

**A class self-declared NOT SEEDED** → the class is **void**: zero kills, no
claim about any row in either direction, and the shared term quoted. IC-J5 is
the likeliest candidate — a design whose `tuser`[0] is not separable from its
abort term would have to say so — and the declaration would be a **result** of
this campaign in the register `WO-0074` used for `M03-M5`, not a failure of it.

---

## 9. Mutant-owned quantities, and how they are sealed

A quantity is **mutant-owned only if the specification does not fix it**. Every
such quantity is sealed as an **inequality with a named direction**, never as a
value; a seal that pins a rendering's own arithmetic scores a correct rendering
as a finding. The axes, with the cells in the seal:

| quantity | sealed as | direction, and why |
|---|---|---|
| the **cycle** printed by `M03-J1`'s strobe message under IC-J2 | an inequality **inside the first refused frame's own span**, with both candidate derivations named | **earliest** — the scan raises at the first violating sample, and which cycle that is depends on where the rendering reports (D-J2a). The *span* is bench-supplied and is not mutant-owned |
| the **delivered-word count** at `M03-J3` under IC-J3 | an inequality **below 8**, with the derived value stated | **fewer** — a gate that mutes cannot add a word |
| the **delivered-word count** at `M03-J2` under IC-J4 | an inequality **below 8**, with the derived value stated | **fewer** — a refused frame delivers nothing |
| the **delivered-word count** at `M03-J3` and `M03-J2` under **IC-J1** | inequalities **above 8**, with the derived values stated | **more** — an ungated admission adds frames. **This direction is the only bench-side discriminator between IC-J1's blast radius and the scored cells of IC-J3 and IC-J4** (§10 collisions 1 and 2) |
| the **cycle** printed by `M03-J1`'s tvalid message under IC-J1 | **not mutant-owned** — spec-fixed, derived and stated exactly | §6.1's `m + 3` over the schedule's own first start cycle; a different value means the rendering also moved the fixed delay, and the verdict says which |
| the **strobe count** at `M03-N4` under IC-J2 | an inequality **above 1**, with the derived value stated | **more** — one added report beside the frame's own |
| the **name** of the strobe an IC-J2 rendering adds | **not printed at any scored cell** | the scored messages print a cycle or a count, never a name — which is why D-J2a exists |
| every delivered word count, cycle, `tkeep`, `tuser` and octet at a frame **outside** the class's permission list | **not mutant-owned** — spec-fixed by REQ-016, REQ-103, §6.1, §7 | §6's check restated as a seal: any movement is out of specification, not a rendering's prerogative |
| `sample.enable`, the schedule's derived cycles, the 50/50 lane split, `Injection.outcomes`, both landing checks | **not mutant-owned** — bench-supplied | evaluated on the bench's own model before or independently of the DUT; a message from one means something other than a seeded class |
| the `Enable` guard's refusal and the structural witness | **not mutant-owned and not reachable** | §4 item 4 |
| **units reddening under a class** | `⊆` the class's **rule** (§3.5), whose first conjunct is *the unit drives the enable low* | a red outside the rule is a finding: either my rule was wrong or the diff reaches further than the class it names |

**Five of the eleven rows are specification-fixed or bench-supplied and are
sealed as equalities on purpose**; calling them mutant-owned would be buying an
unfalsifiable seal. **The fourth row is the one to read twice**: it is the row
`FINDING WO-0074-S4`'s method put there, and without it two of this campaign's
five scored cells would have had no bench-side discriminator at all.

---

## 10. Collisions — derived by the cross product, and what they cost you

**Freely told**: this campaign's collision inventory was built by
`FINDING WO-0074-S4`'s corrected method — **the cross product of every class's
predicted red set with every scored cell**, never from the scored cells alone.
It contains **two collisions on scored cells** and **one pair of branches of a
single class**. Which cells, which strings and which discriminators are sealed.

**And the method's yield is stated in the open, because it is the point of
carrying it**: **both collisions on scored cells come from ONE class's blast
radius landing on TWO other classes' cells** — and neither would have been found
from the scored cells alone, because the colliding class's own cell is at a
different unit entirely. That is exactly the shape `WO-0074`'s fourth collision
had and exactly the shape the old method could not see.

**What that costs you, and it is operational rather than theoretical:**

1. **Every class is delivered as its own diff and run as its own transient.** For
   the branch pair, **which diff was applied is the only discriminator that
   exists** — the `IC-D`/`IC-F` situation of `WO-0066`, `WO-0073`'s collision 1
   and `WO-0074`'s collision 1, at its fourth instance.
2. **The delivery order is fixed**: IC-J1, IC-J2, IC-J3, IC-J4, IC-J5, each on
   its own branch, each with its own CI run id reported. A scorecard that cannot
   say which branch produced which message cannot be adjudicated.
3. **A combined diff makes both members unscoreable** and is reported as a
   manifest defect, not as a result. Two classes touching the same admission
   term does **not** make them a combined diff — `WO-0073-VERDICT` §7 Q4 governs
   — but five diffs are still five diffs.

**Told because it is a fact about the bench and not about the answer**: for both
scored-cell collisions the discriminator is a **direction on a printed integer**
plus a **measurement at another unit**, and the seal records both. A verdict that
reads a count-shaped message without reading its direction convicts the wrong
class.

---

## 11. The qualification rule for a family that owns its own units

`WO-0073` §11's rule and `WO-0074` §11's correction were written for **bound**
rows — a family whose assertions live inside other families' units. **Family J
owns its three units outright**, so the corrected rule applies here in its
simplest form and one clause of it does the work:

> A red qualifies a row **iff the assertion that spoke is an assertion of that
> row's own observable**. A red at another family's unit qualifies that row at
> most and this family not at all; a red arriving through a monitor arm or a
> bench-side guard qualifies nothing anywhere.

Three consequences, all binding:

- **`M03-N4`'s reds are blast radius in every class of this campaign.** It is
  family N's row, it was scored at `WO-0066`, and nothing here re-qualifies it.
- **`M03-J1`'s monitor-arm red under IC-J4 qualifies nothing** — §8.1 fixes what
  it *does* buy, which is a measurement about the row's instruments.
- **Two classes may qualify one row** (IC-J1 and IC-J2 both target `M03-J1`;
  IC-J3 and IC-J5 both target `M03-J3`). **Kills are counted per class** —
  `WO-0066` §11 — so that is two kills and one qualification each time, and the
  verdict says so rather than reporting a row twice.

And two companion rules of the same kind, both already earned and both binding:

- **A kill proves the assertion convicts, never that the bench is a general
  detector of the class** (`WO-0066` §10 item 4).
- **A qualification measures an instrument; it discharges no row and moves no
  count** (`J-dv_lead-0138`).

---

## 12. Cost — priced before the transients are seeded

**This campaign adds no stimulus.** Every unit it scores is already in the landed
suite and already runs in every CI job; there is no new schedule, no probe and
no frame-count decision to make. **Its marginal test cost is exactly zero** and
its whole price is job walls.

The reference figure, quoted with its provenance rather than estimated: the
`build` job's whole wall was **344 s** at run `31015276337` (job
`92337605716`), of which the entire `dune runtest` step was **4 s**. That figure
is **carried** from `WO-0074` §12 with its provenance rather than re-measured —
I cannot run CI (ADR-0005) — and the eight transients of the family-M campaign
were priced against it and came in at that shape.

| item | figure |
|---|---|
| classes | **5** |
| transient branches | **5** (one per class; §10 forbids combining) |
| CI `build` runs | **5** |
| CI wall, at the measured 344 s job | **≈ 28.7 minutes** |
| of which the whole `dune runtest` step | 5 × 4 s = **20 s** |
| of which stimulus added by this campaign | **0 s — it adds none** |

**Three consequences fixed before seeding.** (a) **No reduction proposal can be
made on stimulus grounds**; the only lever is the class count. (b) **Dropping
IC-J5 saves one job — 344 s, ≈ 5.7 minutes — and costs the only scoring
`M03-J3`'s tuple comparison is scheduled to receive**, since that instrument is
reached by no other class in the round (§3.3); **my recommendation is to keep
it**, and the trade is stated in figures so the operator can decide rather than
infer. (c) **The control run is the base commit's own CI run** and costs nothing
extra; **CI is the authority** (ADR-0005) and *"passes locally"* is not
admissible from the auditor, the orchestrator or me.

---

## 13. What this round does NOT close, and the owed list with its carriers

**Named before the result, so no omission is invisible.**

1. **The attack plan does not move in this round's commit.** Every AP edit this
   campaign wants — §4.J's rows gaining qualification cells and a landed-status
   block, **`FINDING J-1`'s two halves** (the `M03-J1` Kills cell's unreachable
   narrow reading, and the no-output-word clause having no Kills cell at all),
   **`FINDING J-2`** (`M03-J3`'s subtractive strobe clause), **`DECLARATION
   J-D1`** as a §7 X-row if it survives the run, and the change-log row — is
   **owed, with a named carrier: the post-campaign `AP-` round**, the next commit
   that opens `test/attack_plans/**`. §8's freeze is worth more than a tidier
   plan.
2. **`FINDING J-1` and `FINDING J-2` are raised here and repaired nowhere
   here.** Both are AP text. **Carrier: the post-campaign `AP-` round.**
3. **The family K campaign is not this one** and is owed before any `SO-`. Its
   seal owes the same two methods this one applies (`FINDING WO-0074-S4`'s cross
   product, `FINDING WO-0074-S1`'s complete conjunct lists).
4. **The charter §3 differential co-sim anchor is undischarged and now blind
   per configuration class** (§4 item 5), which is `WO-0075`'s **bar 4** gaining
   its second instance. **Carrier: the `SO-` round's own accounting** — there is
   nothing to repair, because the bar is a refusal and not a deferral.
5. **`WO-0047` §2's 4-octet anti-vacuity question** is not settled and is not
   this packet's to pay. **Carrier: the next commit that opens
   `test_m03_f.ml`.**
6. **Carried unchanged and not this packet's to pay**: `OBSERVATION L-O1`'s
   one-line repair (carrier: the next commit opening `test_m03_l.ml`);
   `WO-0073-D3`'s `M03-I4` mislabel (carrier: the next commit opening
   `test_m03_i.ml`); `OBSERVATION K-O1` (carrier: the next round opening
   `test/monitors/`); `WO-0075`'s own return (carrier: `WO-0075`, and §8.0's
   sequencing question).
7. **No `SO-xgmii_rx_64.md` issues and none is offered.** Outstanding before any
   PASS: the family **K** campaign and the charter §3 anchor. **The lessons
   harvest falls due at the `SO-`**, spanning from my last harvest; it is **not
   due this round** and the span stays open, declared rather than skipped.
8. **A kill here qualifies a row on the class it was seeded against and on
   nothing else.**

---

## 14. Weighting, discounted in advance

**In favour of this round**: none of the three rows was authored with a mutation
class known — all three landed at `2dbd39b`, weeks before this packet — and
three of the five classes are quoted from the plan's own Kills cells rather than
invented for the bench. Two of the five (IC-J3, IC-J5) key on a geometry **only
one unit in the whole bench produces**, which makes their kills attributable to a
single assertion rather than to a family. And IC-J3 measures a correction this
programme argued and never ran.

**Against it, five ways, all stated before the scorecard:**

1. **One of the four §4.J rows cannot be scored at all** (`M03-J4` — §4 item 1),
   and no verdict may imply the family is fully covered by a full scorecard.
2. **The campaign's instrument footprint is four units of fifty-nine** (§3.2) —
   the narrowest of any campaign in this era. Fifty-five units are MUST-STAY-GREEN
   by a single conjunct, and that is a *protection*, never a coverage claim.
3. **`M03-N4` takes a red in four of the five classes and is qualified by none of
   them.** A five-class scorecard listing it four times is not breadth; §11
   governs and the verdict must say so per class.
4. **Two of my own plan cells are convicted before the run** (§4 items 6 and 7),
   which means the family's *written* attack surface was thinner than its
   observables. The campaign attacks the observables; the plan text catches up
   later, at a carrier.
5. **The re-enable geometry is tested at exactly one distance** — one cycle,
   the tightest legal placement. A design that needs three cycles of settling and
   one that needs two are the same class here, and nothing in this round
   measures the boundary at any other distance.

---

## 15. What comes back

1. The **five manifests** per §7.3.
2. **All nine disclosures**, in the auditor's own words.
3. The **§6 pre-ship check** result for **all five** classes, in its positive
   form, against each class's own permission list — the `Enable.high` column
   included for every one.
4. The **full scorecard**: every unit red or green under each class, at the base
   SHA, with the **raised message at every red — the message, not a summary of
   it**, because the seal's cells are message-level. Where a unit raises inside a
   lane iteration, the **row prefix** distinguishes the member and must be
   reproduced verbatim.
5. The **control run**: the unmutated base SHA green, with its **CI run id and
   conclusion**.
6. The **per-class CI run id and branch name**, so §10's ordering is auditable.
7. **The `cosim` job's conclusion under each class**, reported and explicitly
   **not** offered as evidence — §4 item 5 has already declared what a green
   there means and why the ground is the stimulus.
8. Anything judged rather than followed, and why.

**Two questions for the orchestrator's ruling, raised here rather than at the
scorecard:**

- **Q1 — the `WO-0075` sequencing hazard (§8.0).** Hold its return until this
  campaign scores (my recommendation), or land it before the base commit? A
  landing inside the window re-seals the round.
- **Q2 — IC-J5's price against its risk.** It is the only class reaching
  `M03-J3`'s tuple comparison and the likeliest of the five to come back NOT
  SEEDED. Keeping it is my recommendation (§12); the alternative is a four-class
  round that leaves the row's own instrument unprobed, and the figures for both
  are above.

**Adjudication is mine**, against the sealed file, which is opened **only after
every scorecard is in hand**.

---

## 16. Not to be told

The sealed companion in its entirety: its matrix and its MUST-STAY-GREEN sets,
its verbatim message cells, the assertion orders' exact message strings, its row
prefixes, its UNWORKED adjudication rules, its disclosure-branch tables,
**which** classes collide and with what strings, its GREEN-BY-BLINDNESS section,
its per-class rules and worked instances, and its dispositions.

**Freely told, and told above**: the five classes and the sentence each is
derived from; the nine mandatory disclosures; §2's denominator and the enable
census; §3's structural fact of enable-high invariance and the three instrument
kinds; **§4's ten declarations of what this campaign cannot score**, including
the two findings against my own plan text and the anchor's stimulus blindness;
§5's reachability standard and the three-path gate inventory; §6's signature and
the **per-class permission lists**; §7's allowlist, manifest-only rule and
abort-first HEAD check; §8's base SHA, ordering rule, the `WO-0075` hazard and
the bounded classes' scoring rules; §9's mutant-owned axes; §10's *existence* of
two scored-cell collisions and one branch pair, the fact that the cross-product
method is what found them, and what they cost the manifest; §11's qualification
rule; §12's price; §13's non-closures and carriers; §14's weighting; §15's
return format and the two questions.
