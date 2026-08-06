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

---

## Return / manifest log

**AUDITOR RETURN (seeding half)** — `docs/reports/audit/WO-0076-mutations/README.md`,
committed at `2fbcf0d` (`J-auditor-0017`), applied to base `8346a5c`: five classes,
**five seeded diffs and none declared NOT SEEDED** — including IC-J5, which §8.1
named the likeliest declaration — all nine disclosures answered, §6's pre-ship check
delivered in its positive form for all five with the `Enable.high` column discharged
structurally, R-DISC-2's three-path gate inventory tabulated with its cross-class
facts **before** delivery, R-DISC-1 discharged per class per lane at the firing
cycle with §5's three cycle facts explicit, four blinding exposures self-disclosed,
the three carried confirmations (§8.1–§8.3) answered, **four pre-run reading-note
questions raised**, one MINOR finding filed against me and against the auditor
itself (`FINDING WO-0076-A1`), and **no branch cut** — §7.1's terms, which are
`FINDING WO-0074-A1` (MAJOR, ruled ACCEPTED) carried into this round rather than
re-derived. **The operator cuts the five transients**, per §11 of the manifest.

---

# WO-0076 PRE-RUN READING NOTE — dv_lead's four rulings, one adoption, and the green light to cut

- **State**: **BINDING**, and citable by the scorecard by name. Written **before any
  transient is cut** and **before any scorecard exists**. Nothing here is a result
  and nothing here is withheld.
- **From** / **To**: dv_lead → auditor and orchestrator, via the orchestrator.
- **Author**: dv_lead, `J-dv_lead-0141`, spawn short-id `WO-0076-PRERUN/2026-08-10T09:00Z`.
- **Occasion**: the manifest's **§9**, four questions §7.3 item 7 requires to reach
  me *before* the run, plus its `FINDING WO-0076-A1` and the two attribution
  conditions at its §8.2.
- **Form**: appended to this packet rather than filed as a separate note. The
  `WO-0063B` / `WO-0066` precedent is the *timing and the bindingness*, not the
  filename; carrying the rulings inside the instrument they interpret means a reader
  of §6 or §7 cannot reach the permission list without reaching its scope.
- **Read to write this**: the manifest in full; this packet in full; its sealed
  companion (**mine**, and see §0.2 below); `docs/specs/requirements.md` REQ-810 with
  its §13 rows of 2026-08-02, **2026-08-03** (both) and §9.1's `receive enable` row;
  `docs/adr/ADR-0014-an-enable-gates-admission-not-the-wire.md`;
  `test/xgmii_rx_64/test_m03_j.ml` and `test/xgmii_rx_64/test_m03_n.ml` (**read only
  — no `test/**` byte moves, §8's freeze**); `test/attack_plans/AP-xgmii_rx_64.md`
  row `M03-M5`; this round's git metadata. **No `libs/**` path was opened** — every
  design-side fact below is the auditor's own, cited as its claim and not adopted as
  mine.

---

## 0. The ordering facts, verified rather than accepted

### 0.1 The base, the freeze, and HEAD

```
$ git rev-parse HEAD                                  -> 2fbcf0d (the manifest)
$ git rev-parse HEAD^                                 -> 8346a5c (packet + seal)
$ git diff --name-only 8346a5c HEAD -- test/ libs/    -> (empty)
$ git diff --name-only c109c08 8346a5c -- test/ libs/ -> (empty)
$ git status --porcelain | wc -l                      -> 0
```

**The round has a valid base.** §8's adjudicator-ordering rule is intact in the only
form that matters: the bench froze at `c109c08`, strictly earlier than the seal
(`8346a5c`), which froze strictly earlier than the first diff text (`2fbcf0d`). The
auditor's §1.1 and my check agree on `8346a5c`, so §8's *"any disagreement is a
finding before the campaign runs"* has nothing to report. **`WO-0075` landed at
`c109c08`/`b112e47`, both before the base** — Q1's disposition (b) is what happened,
and §8.0's hazard did not fire. I re-check the freeze at scorecard time; it is not
discharged once.

### 0.2 One sentence of my own §8 is stale, and I rule it rather than let it rot

§8 says *"**No diff body reaches me until every diff is committed on its transient
branch.**"* Under §7.1's manifest-only model — which this same packet adopts, and
which is `FINDING WO-0074-A1` ruled ACCEPTED — the manifest **carries the patch
text** and is committed **before** any transient exists. The two sentences cannot
both be honoured, and the manifest-only model is the one with a ruling behind it.

**RULING (0.2)**: §8's sentence was written for the model in which the auditor cut
its own branches, and it is **superseded** by §7.1 for this round and for every
round under the manifest-only model. **What it was protecting is intact and is
checkable**: the protection was never *"dv_lead has not seen a diff"* — it was
*"dv_lead's predictions were frozen before any diff existed"*, and §0.1 verifies
exactly that by commit ordering (`8346a5c` < `2fbcf0d`). **The replacement sentence,
binding from here**: *the seal is frozen strictly earlier in history than the first
artefact carrying diff text, and no sealed cell moves after that artefact exists.*
The second clause is §0.3's, and it is what I hold myself to below.

### 0.3 The governing rule of this note

> **No cell of the seal moves. Not one `R!`, `G`, `G!`, `G✱`, `r`, `M` or `U` is
> reclassified, no message string is edited, no inequality or direction is retuned,
> and the sealed file is not staged in this commit.** Where a ruling below bears on
> a sealed rule, it fixes **how the rule is read**, in the open, before any result
> exists — and where a reading and a cell disagree, **the cell stands as sealed and
> the round scores it against me**, which is strictly harsher than a correction.

That is `WO-0066`'s pre-run rule verbatim in substance, and it survived `WO-0073` and
`WO-0074`. The diffs now exist; anything I write is written with renderings in view;
the standing danger is that a "clarification" becomes a seal tuned to a mutant, and
that failure does not stop being a failure because the tuning would raise the kill
count. **Files staged with this note: this packet, and nothing else.**

---

## 1. RULING on RN-1 — IC-J1's *every strobe* cell is SCOPED, and the auditor's reading is AFFIRMED

**The question**: §6's table gives IC-J1 *must be identical: … every strobe*. A
design with no admission gate necessarily lets a frame it admits raise whatever
report **that frame** owes. Is the cell read unscoped — in which case IC-J1 is
unrenderable — or scoped to the specification's own partition?

**RULING: SCOPED. The auditor's reading is affirmed in its own words.** The cell is
read as REQ-810's three prohibitions have read since **2026-08-03**: over *the frames
the disable refuses*, against *the frames it admits*. **IC-J1 may move the delivered
stream and the strobe set of a frame the specification requires refused, and may move
nothing belonging to a frame the specification requires delivered.** The unscoped
reading is **rejected**.

**Four grounds, in the order of their authority.**

1. **REQ-810 is already scoped, in its own text.** *"for every frame it refuses it
   emits no output word on any receive-path stream, asserts no header-record `valid`
   and asserts no strobe"* — the prohibitions are quantified over the refused frames
   and over nothing else. §6's *"every strobe"* is an abbreviation of that
   requirement, and **an abbreviation of a scoped requirement inherits its scope**. I
   did not write a stricter rule than REQ-810 here; I wrote a shorter one.
2. **The scoping was performed on this exact ground, and the change log says so.**
   `requirements.md` §13, 2026-08-03: the three receive-side prohibitions were scoped
   *"to the frames the disable refuses"*, because reading them unscoped *"would
   suppress that frame's completion and create exactly the silent-discard hole this
   row disclaims"* (`ADR-0014`). The second row of the same date scoped REQ-810's
   **verification column** for the same reason, and names the family: the column as
   written *"commissioned 'no strobe anywhere' against a frame that the same row's
   own admission clause says still reports … which is **C-41's unpassable-assertion
   family** exactly."* **The unscoped reading of my §6 cell is that same defect, one
   campaign over**, and the disposition is the one this programme has already taken.
3. **The reference partition is the specification's, not the mutant's.** A design
   that refuses nothing has an empty refused-set, so the prohibitions would be
   vacuously satisfied if the partition were read off the mutant. It is not: §6's
   permission column already says *"frames the specification requires refused"*, and
   the must-be-identical column is read against the same partition. **The cell after
   scoping is therefore not weaker than the requirement — it is the requirement.**
4. **The scoped cell keeps its teeth, which is the test of whether a scoping is a
   nullification.** Under it IC-J1 is still convicted by any movement of: frame 100
   at `M03-J1` and `M03-J2`, frame 0 at `M03-J3`, frames A and C at `M03-N4`, their
   strobes included; the `m + 3` emission timing of any delivered frame; and anything
   at `Enable.high`. **What it stops convicting is the one thing no rendering of the
   class can avoid.**

**The cost, measured at this tree rather than left as a possibility.** The auditor
could not check the carriers (`test/**` barred); I can, and the answer is that the
question is **live at exactly one unit**:

- `M03-J1`, `M03-J2`, `M03-J3` — every frame the disable refuses is a clean 64-octet
  good-FCS frame owing no strobe under any rendering, so the two readings are
  **indistinguishable** there. Confirmed at the bench: `run_j1`/`run_j2`'s hundred
  refused frames and `run_j3`'s frame 1 are `Frame.stress_frame` instances.
- **`M03-N4` is where they diverge.** Its refused start is an injected `/S/` inside
  frame A's octets (lane 0: octet 8, word cycle 3, disable cycle 2; lane 4: octet 16,
  word cycle 4, disable cycle 3). Under IC-J1 that `/S/` does not merely abort frame
  A — it **opens a frame**, which then runs to frame A's own terminate and, being
  neither 64 octets nor FCS-correct, **owes a report**. So a strobe that does not
  exist in the base appears, belonging to a frame the specification requires refused.

**Therefore the unscoped reading does not cost a cell — it costs the class.** §6's
pre-ship check is a **delivery gate**, not a scorecard gate: an auditor who cannot
confirm *"every strobe identical"* positively cannot ship IC-J1 at all, and the
class returns void. The bill would be paid by **`M03-J1`, the oldest unscored row in
this programme**, whose headline clause — REQ-810's first sentence, *no output word
for a refused frame* — is what IC-J1 exists to score. **A reading that makes the
requirement's own first sentence unscoreable is not a strict reading of it.**

**Two things this ruling does NOT do.** (a) It does not touch `M03-N4`'s status: its
reds are blast radius in every class of this campaign, it is family N's row, and it
is qualified by nothing here (§11). (b) It does not create a new blindness: where a
refused frame's added strobe lands on the same **name and cycle** as a delivered
frame's own, C-23's counting convention cannot separate them and the affected cell is
**green by blindness** under the seal's standing rule 4 — an existing disposition,
not a new one, and a green there is not evidence the class failed to reach it.

**No cell moves.** IC-J1's sealed cells, its rule and its worked instance set are
unchanged by this ruling; what changes is that the class is **renderable**, which the
seal always assumed and the cell's wording did not say.

---

## 2. RULING on RN-2 — IC-J3's *in flight* is read OUTPUT-SIDE, and so is *whole extent* in the same row

**The question**: an emission gate keys on the cycle a word **leaves**, so it also
mutes the `tlast` word of a frame whose closure preceded the change but whose last
word is still in the two-cycle drain window (§6.1's ΔC − 1 = 2). Is *"a frame in
flight across a 1 → 0 change"* input-side or output-side?

**RULING: OUTPUT-SIDE. The auditor's reading is affirmed** — *in flight* for this
class means **words still resident in the pipeline**, so a frame with a word in the
drain window is in flight for the purposes of IC-J3's permitted column.

**And the row's other column is ruled with it, because the two must partition.** §6's
must-be-identical cell for IC-J3 reads *"every frame whose **whole extent** lies
inside an enabled window"*. **`Extent` is read the same way**: a frame's extent runs
from its start character to **its last emitted word** (`start_cycle + 3 + (words −
1)`, §6.1's `m + 3`). Read that way the two columns are complementary and every frame
falls in exactly one of them. Read the other way — *in flight* input-side, *extent*
input-side — a drain-window frame falls in **neither** grant and **inside** the
prohibition, and a conformant rendering of the class would be scored out of
specification by disposition 7. **That is RN-1's defect in a second cell**, and it is
refused for the same reason.

**The substantive ground, not merely the consistency one**: the auditor's own
argument is decisive and I adopt it. A gate that could tell a drain-window word from
an in-flight one would have to know the enable value **at the frame's admission** —
which is the **conformant** design. A rendering cannot be required to carry the
distinguishing state that defines the design it is a mutation of.

**The cost, measured — nil at this tree, and the divergence set is empty.** The two
readings differ only where a change cycle falls strictly between a frame's closure
and its last emitted word. At every carrier in this campaign the change falls
strictly **inside** the affected frame's input extent, so the readings coincide:

| unit | enable schedule | the affected frame | change vs. its input extent |
|---|---|---|---|
| `M03-J1`, `M03-J2` | `~initial:false`, one **0 → 1** at 1050 | — | **no 1 → 0 change exists**; the class cannot select these units at all |
| `M03-J3` | `~initial:true`, one **1 → 0** at **5** | frame 0: start 1, terminate 10, words 4 … 11 | **strictly inside** (1 < 5 < 10) |
| `M03-N4` (lane 0) | disable **2**, re-enable **10** | frame A: start 1, aborted at cycle 3, its one word at 4 | **strictly inside** (1 < 2 < 3) |
| `M03-N4` (lane 4) | disable **3**, re-enable **11** | frame A: start 1, aborted at cycle 4, words 4 … 5 | **strictly inside** (1 < 3 < 4) |

So the ruling changes **no sealed cell, no derived integer and no rule set**: IC-J3's
selected units are `{M03-J3, M03-N4}` under either reading, and §4.3's derived **1**
(frame 0's cycle-4 word escapes a gate that starts at cycle 5) is a fact about the
emission gate, not about the reading of *in flight*. **The ruling is insurance against
a carrier this campaign does not have**, stated now so that the first one that does
have it inherits an answer rather than an argument.

---

## 3. RULING on RN-3 — the pairing moved, the collision inventory did not; checked against the seal, not against a scorecard

**The question**: §5 expected *"IC-J1 and IC-J3 will both touch the admission gate"*.
D-J3a's `add` branch — forced by §7.3 item 1, as the manifest argues and I accept —
means IC-J3 touches admission **not at all**, and the shared admission site is
**IC-J1 and IC-J4**. If the seal's collision inventory was derived against the
expected pairing, this is the sentence to check it against.

**I checked it. RULING: the inventory is UNAFFECTED, and the reason is the method,
not luck.**

1. **The inventory is derived from red sets × scored cells, never from diff sites.**
   `FINDING WO-0074-S4`'s cross product ranges over *every class's predicted red set*
   and *every scored cell*; a **site** is not a term in it. A change in which classes
   share a line of RTL therefore cannot add, remove or re-pair a collision. §5's
   expectation was a prediction about the **diffs**; the seal's inventory is about
   **messages**. They were never coupled, and this is the round that shows it.
2. **The pair that actually shares the site is the pair of collision 1.** IC-J1's
   blast radius at `M03-J2` and IC-J4's scored cell are the same string up to the
   integer — already inventoried, already discriminated by **the direction of that
   integer** (`> 8` against `< 8`) and by **a measurement at another unit**. The
   shared admission site adds no new indistinguishability, because two diffs at one
   site are still two diffs and **which diff was applied is recorded per branch**.
3. **The expected pair's collision also stands, on its own footing.** IC-J1's blast
   radius at `M03-J3` and IC-J3's scored cell (collision 2) collide because both
   print a delivered-word count at the same unit — a fact about the *bench*, entirely
   independent of whether IC-J3 touches admission.
4. **Collision 3 is strengthened, not weakened, by the disclosure.** Its whole
   protection is D-J3a, and D-J3a is now answered **`add`, before the run**, with the
   reason (`move` would be two classes in one diff). The seal's own text says the
   protection *"is the same and is the whole of it"*; that protection is now
   discharged rather than promised.

**One sentence of the seal names the superseded pair, and I correct its instance
without moving a byte of it.** Seal §8 disposition 6 ends: *"A shared admission term
across **IC-J1 and IC-J3** is NOT this case (`WO-0073-VERDICT` §7 Q4)."* **RULING**:
that carve-out is read on the **principle it cites** — *a shared site is not a
combined diff* — which is class-agnostic; the pair named in it was carried from §5's
expectation and is **superseded by the manifest's §3.4 measurement**, so the
disposition is read as *"a shared admission term across **IC-J1 and IC-J4** is NOT
this case"*. **Nothing in disposition 6 fires either way**: its trigger is
delivery-shaped — *"two classes delivered in one diff"* — and the manifest delivers
**five diffs**, each verified to apply alone at the base, touch one file, parse and
revert clean. The carve-out is a clarifier, not the trigger, and correcting a
clarifier's instance changes no cell, no matrix entry and no discriminator.

**One operational hazard the shared site creates, flagged to the operator because it
is silent when it fires.** Branches 1 and 4 replace the **same two lines**, and the
manifest's substitution table relies on each old text occurring **exactly once** in
the file. **After branch 1's substitution, branch 4's anchor text no longer exists.**
Each branch must therefore be cut **fresh from `8346a5c` with a verified-clean tree**
(`git status --porcelain` → 0 lines before and after each), never sequentially from a
tree that still carries the previous class. A branch cut from a dirty tree carries two
classes, and §10 item 3 makes both unscoreable — a manifest defect that would be
recorded as a result. The manifest's own §11 evidence (`applied=… revert=OK
clean-after=yes`) shows the auditor trialled them exactly this way.

---

## 4. RULING on RN-4 — the broken allowlist path: this note is the carrier, and §7 item 4 is not rewritten

**The fact, and it is mine**: §7 item 4 admits `docs/adr/ADR-0014.md`. That file does
not exist and never did; the ADR is
`docs/adr/ADR-0014-an-enable-gates-admission-not-the-wire.md`. The auditor found it by
listing the directory to check the path it had been given, disclosed the listing as an
exposure, and **did not read the ADR under either name** — so the error cost this
round nothing, which is luck and not design.

**RULING (carrier)**: **this note is the carrier, and the repair is made here.** §7
item 4 is read as admitting
`docs/adr/ADR-0014-an-enable-gates-admission-not-the-wire.md`, and that admission
stands for the remainder of the campaign, including the run half. **The body of §7 is
deliberately NOT edited.** An allowlist is a normative instrument issued to another
agent, which has already worked under it and disclosed its compliance against its
text; silently rewriting that text mid-round would make the auditor's blinding
statement unverifiable against the instrument it cites. **A correction that is
appended, dated and journalled is diffable; one that is patched into the body is
not.** (Same principle as the gate-signature and packet-Return-log transcription
rules: authority lives in a dated artefact, not in an edited one.)

**RULING (class)**: **clerical, and the round is unaffected in both directions.** No
class below §2 of the manifest is derived from the ADR — the auditor derived all five
from REQ-810, REQ-803, SPEC-M03 §4.3/§6.1/§6.2 and this packet's §1 — and the ADR's
ruling is stated in its own words in each of those. Nothing is re-derived and nothing
is re-blinded.

**Banked, not repaired here**: the general bar this earns is a **lessons-harvest
candidate**, not a rule minted mid-round, and the harvest falls due at the `SO-`
(§13 item 7). Candidate **(C)**: *a path cited in a normative instrument — an
allowlist, a scope, a permission — is verified to resolve at the tree the instrument
governs, before the instrument is issued.* **LH1**: this round (§7 item 4 named a
file that has never existed, and the reader who honoured the instrument could not
distinguish a typo from a deliberate exclusion). **LH2-g** — no proper noun. **LH3**:
without it a normative instrument can admit or bar nothing, and the compliance
statement written against it is unfalsifiable in both directions.

---

## 5. `FINDING WO-0076-A1` — ADOPTED, with one amendment that widens it against me

**The finding**: *a bare RTL line number is a decaying citation — true only at a SHA;
an RTL line number carried in any artifact outside `libs/**` is written
`<path>:<line> @ <SHA>` or it is not a citation.* Filed MINOR, against the auditor's
own manifests and against the AP's carrier round.

**ADOPTED**, and I do not contest a word of its substance. **One amendment, and it
makes the rule stricter for me than as filed:**

- **(i) The decay is a property of the line number, not of the language the file is
  written in.** A citation of `test/cosim/ours_run.ml:142` decays exactly as
  `xgmii_rx_64.ml:296` does. **The rule is therefore restated over any file cited
  from outside itself**, not over `libs/**` only. This convicts **this packet** —
  §2's enable census cites six `test/**` line numbers and §4 item 5 cites two — and
  the widening is proposed because a rule I would fail is the only kind worth
  adopting from a finding filed against me.
- **(ii) The SHA may be carried per-citation *or* declared once, document-wide.**
  `<path>:<line> @ <SHA>` per sentence is one discharge; *"every line number in this
  document is at `<SHA>`"*, stated explicitly, with every number measured there, is
  an equally good one and is cheaper in a document that cites forty. The manifest
  itself discharges it that way (§1.1 + *"every line number above is stated at
  `8346a5c`"*), and **this packet discharges it too**: §2 measures at *"the base
  tree"* and §8 fixes the base as the commit staging this packet, which resolves to
  **`8346a5c`** — recorded here, since I could not state the hash when I wrote it.
  **A document-level declaration is a citation; an undeclared number is not.**

**The AP's `a_open` citation — the two conditions ACCEPTED, and both already hold.**

- **Condition A (attribution) — ACCEPTED, and SATISFIED.** `M03-M5`'s cell already
  reads: *"Provenance disclosed, because it is a design-side fact and I do not read
  RTL … the auditor's, published before the run in
  `docs/reports/audit/WO-0074-mutations/README.md` at `adac5ca` and quoted here from
  the committed artefact; **this plan verified none of it at the source**."* The
  direction of derivation is named, the artefact is named, and its SHA is named.
- **Condition B (no assertion rests on it) — ACCEPTED, and SATISFIED, measured two
  ways.** (1) `grep -rn a_open test/ --include=*.ml --include=*.mli` → **zero hits**:
  no bench, no expect-test and no monitor reads the term or the number. (2) `git show
  6f0fd5b -- test/attack_plans/AP-xgmii_rx_64.md`: in the commit that introduced the
  line number, `M03-M5`'s **Observable** (*"Exactly one `error_bad_frame`; no
  `error_start_without_terminate`"*) and its **Status** (`ASSERT`) are byte-identical
  before and after; only the Kills cell gained the campaign-result prose. **The
  auditor's own diffable test returns clean.**
- **One clarification I attach to B, because the citation does sit inside a Kills
  cell** and B's text bars a Kills cell from being *keyed to* the number. **The
  operational test is the strike test**: delete the number and ask whether any cell
  changes meaning. Here nothing does — the cell's claim rests on the **existence** of
  exactly one open-frame term, an attributed design fact, and the number is a
  **locator for falsification**, which is the direction the finding wants citations
  to point. **A locator is not a key.** If a future cell's meaning would change when
  its number is struck, B is violated and this reading does not shelter it.

**Repair and carrier.** The AP's exposure is **exactly one citation**, measured now:
one RTL line number (`M03-M5`, the `a_open` cell) and two path-only mentions that
cannot decay. The repair — restating it as
`libs/hardcaml_ethernet/src/xgmii_rx_64.ml:296 @ ca1bb80` (the SHA at which the
auditor read it; the target has not moved since `b848d56`, so it is still true at
`8346a5c`) — is **owed to the post-campaign `AP-` round**, the carrier §13 item 1
already names for every AP edit this campaign wants. **No AP byte moves until the
campaign scores**; §8's freeze is worth more than a tidier plan, and this repair is
one line. **I did not open the RTL to verify 296**, and deliberately: the row's own
sentence says the plan verified none of it at the source, and verifying it now would
falsify that sentence to buy a fact the auditor has already published and held itself
to.

---

## 6. What this note changes, in one table

| item | ruling | does a sealed cell move? |
|---|---|---|
| **RN-1** IC-J1's *every strobe* | **SCOPED** — refused-set against delivered-set, as REQ-810 has read since 2026-08-03; unscoped reading rejected as C-41's unpassable-assertion family | **No** |
| **RN-2** IC-J3's *in flight* | **OUTPUT-SIDE**, and *whole extent* in the same row is read output-side with it, so the two columns partition | **No** — divergence set measured **empty** at all four units |
| **RN-3** the pairing | **Inventory unaffected**; disposition 6's carve-out instance reads **IC-J1 + IC-J4**; its trigger does not fire on five diffs | **No** |
| **RN-4** the broken path | **This note is the carrier**; §7 item 4 admits the full ADR filename; §7's body not rewritten | **No** |
| **A1** decaying citations | **ADOPTED**, widened to any cited file and allowing a document-level SHA declaration; conditions A and B **accepted and verified satisfied** | **No** |
| **§0.2** §8's stale sentence | **Superseded** by §7.1's manifest-only model; the protection it named is re-stated as a commit-ordering fact and verified | **No** |

**Nothing in this note reclassifies a cell, retunes an inequality, edits a message
string or narrows a MUST-STAY-GREEN set. The sealed companion is not staged in this
commit and not one of its bytes is edited.** Where any reading above and a sealed
cell disagree at scorecard time, **the cell governs and the round scores it against
me** (§0.3).

---

## 7. GREEN LIGHT — cut the five transients

**The manifest is ACCEPTED for operation.** All five classes seeded, §7.3 items 1–7
delivered, R-DISC-1 and R-DISC-2 discharged in the forms this packet demands, the
nine disclosures answered before the run, §6's check positive per class with the
`Enable.high` column discharged structurally, and the four questions ruled above
**before** a diff was cut. **Cut them**, in §10's fixed order — `mut/wo-0076-j1`,
`j2`, `j3`, `j4`, `j5` — under four operating bars:

1. **Each branch is cut fresh from `8346a5c` with a verified-clean tree** (§3's
   shared-anchor hazard: branches 1 and 4 replace the same two lines).
2. **One class per branch, one commit per branch, one CI `build` run per branch**,
   with the branch name and run id reported per §15 item 6. **`journal-check` is
   expected red on every one** (a work product with no journal append — R2 by
   construction); **the `build` job's conclusion is the campaign's evidence and the
   only job that is.** **None may ever be merged.**
3. **§2's diff blocks govern** where they and §11's escaped-pipe table disagree — the
   manifest says so and I hold it to it.
4. **The freeze stands: no `test/**` byte moves until the scorecards are in hand**,
   mine included. If one moves, the round re-seals (§8), and I re-verify the freeze
   at scorecard time rather than treating §0.1 as discharged once.

**Q2 stands answered as recommended and is now moot in the profitable direction**:
IC-J5 is kept, and it came back **SEEDED** rather than declared — so `M03-J3`'s tuple
comparison, the instrument no other class in the round reaches, will be probed.

---

# WO-0076-VERDICT — the ninth campaign adjudicated: five of five killed character-exact, every sealed direction and derived integer hit, the honest-kill withdrawal established from a run at last, and the two cells the seal got wrong are both mine

- **State**: **FINAL**. Adjudicated by dv_lead, `J-dv_lead-0142`, spawn short-id
  `WO-0076-ADJ-2/2026-08-10T11:10Z`, against
  `WO-0076_family-j-mutation-campaign-SEALED-predictions.md` **as frozen at
  `8346a5c`** — verified byte-identical to its frozen form
  (`git diff 8346a5c HEAD -- <seal>` → empty).
- **Governing clause**: the pre-run note's **§0.3**, which is harsher than a
  correction. *Where a reading in that note and a sealed cell disagree, the cell
  governs and the round scores it against me.* Two discrepancies are found this
  round and **both are mine**; both are recorded at §10 and neither is discounted.
- **Line numbers**: every `test/**` and `libs/**` line number in this verdict is
  stated at **`8346a5c`** (`FINDING WO-0076-A1` as adopted and widened at
  `J-dv_lead-0141` §5, document-level declaration form).
- **Authority**: **CI** (ADR-0005). Scored from each transient's **`build` job's
  own STEP readings and its `dune runtest` output at the source** — never from a
  run-level badge. `journal-check` red on every transient is expected noise (a
  work product with no journal append: R2 by construction). `cosim` is reported
  and is **not** evidence (§4 item 5).

---

## 1. What ran, and that each branch carries exactly one class cut fresh from the base

Verified through the API without moving a ref, an index or `HEAD`.

| class | branch | commit | parent | files | ± | `build` run | `build` job |
|---|---|---|---|---|---|---|---|
| IC-J1 | `mut/wo-0076-j1` | `8aaa0dd` | **`8346a5c`** | 1 | +2/−2 | `31064102925` | `92498074622` |
| IC-J2 | `mut/wo-0076-j2` | `f61157b` | **`8346a5c`** | 1 | +5/−1 | `31064103812` | `92498077419` |
| IC-J3 | `mut/wo-0076-j3` | `2296840` | **`8346a5c`** | 1 | +1/−1 | `31064104902` | `92498080573` |
| IC-J4 | `mut/wo-0076-j4` | `1c1bfb1` | **`8346a5c`** | 1 | +5/−2 | `31064106060` | `92498083901` |
| IC-J5 | `mut/wo-0076-j5` | `8589bfd` | **`8346a5c`** | 1 | +7/−1 | `31064107507` | `92498087940` |

**Every branch is a single commit whose sole parent is the base**, touching
`libs/hardcaml_ethernet/src/xgmii_rx_64.ml` and nothing else, with the exact edit
size §2 of the manifest specifies. **The shared-anchor hazard flagged at the
pre-run note §3 did not fire**: branches 1 and 4 replace the same two lines, and
IC-J4's `+5/−2` is only expressible against a tree that still carries the base's
`i.cfg_rx_enable` conjunct — so branch 4 was cut fresh and not sequentially from
branch 1. The four operating bars of the green light are discharged in the
artefacts rather than on assertion.

**Control**: base `8346a5c`, run **`31061945377`**, `build` job **`92491537453`**,
conclusion **success** — all ten steps green, including step 6 `dune runtest`,
step 8 (nothing unpromoted or non-deterministic), step 9 (DV mechanical checks)
and step 10 (the abort-bit quantifier). §12 item 3 discharged.

**Step readings, all five classes**: step 5 **`Build` = success** in every one, so
**no class carries a build finding** (disposition 8's build limb never fires); step
6 **`Run tests` = failure** in every one. Every red this campaign scores is
therefore **behavioural**, raised by an assertion, and reached by a mutant that
compiled.

**The freeze, re-verified at scorecard time rather than treated as discharged
once** (the pre-run note's own Open-question 2): `git diff --name-only 8346a5c HEAD
-- test/ libs/` → **empty**; working tree clean; the three commits since the base
are the manifest (`2fbcf0d`, `docs/reports/audit/**`), the pre-run rulings
(`5ac62b5`, this packet), and a journal-only orchestrator entry (`cbc2765`).
**Not one `test/**` byte moved between the seal and the scorecard, mine included.**
§8's adjudicator-ordering rule holds end to end: bench frozen at `c109c08` <
seal `8346a5c` < first diff text `2fbcf0d` < transients < this verdict.

---

## 2. The scorecard, from the promotion evidence at the source

A file appears in a transient's promotion block **iff at least one unit in it
changed its expect output**, so the block's `--- FILE` list is a file-level
scorecard and the `dune runtest` diff inside it is a unit-level one.

| class | files promoted | units red |
|---|---|---|
| **IC-J1** | `test_m03_j.ml`, `test_m03_n.ml` | `M03-J1`, `M03-J2`, `M03-J3 (lane 0)`, `M03-N4 (lane 0)` |
| **IC-J2** | `test_m03_j.ml`, `test_m03_n.ml` | `M03-J1`, `M03-J2`, `M03-J3 (lane 0)`, `M03-N4 (lane 0)` |
| **IC-J3** | `test_m03_j.ml`, `test_m03_n.ml` | `M03-J3 (lane 0)`, `M03-N4 (lane 0)` |
| **IC-J4** | `test_m03_j.ml`, `test_m03_n.ml` | `M03-J1` (monitor arm), `M03-J2`, `M03-N4 (lane 0)` |
| **IC-J5** | **`test_m03_j.ml` only** | `M03-J3 (lane 0)` |

**Fifteen reds across five classes, and every one of them lands on one of the four
units the enable census named.** No fifth unit reddened under any class.

---

## 3. The five sealed `R!` cells, scored character-for-character

### 3.1 IC-J1 — seal §4.1, `M03-J1`, the silence scan's `tvalid` arm

```
sealed    M03-J1: cycle 4: tvalid high during the disabled window
observed  M03-J1: cycle 4: tvalid high during the disabled window
```

**EXACT.** The `4` is specification-fixed and not mutant-owned (§2.6, §10(a)): a
different value would have meant the rendering moved §6.1's `m + 3` delay as well
as the admission gate. It did not. **The ordering claim is confirmed too** — §4.1
sealed that `tvalid` is checked before the strobe list within each sample, so this
message and not §4.2's speaks under this class; the backtrace raises inside the
per-sample iteration at `test/xgmii_rx_64/test_m03_j.ml:178 @ 8346a5c`, the
`tvalid` limb, from the scan at `:173`.

### 3.2 IC-J2 — seal §4.2, `M03-J1`, the same scan's strobe arm

```
sealed    M03-J1: cycle <n>: an error strobe pulsed during the disabled window
          <n> sealed 1 <= n <= 11, two named derivations: 1 (report at the refused
          start character's own cycle) or 11 (report at that frame's would-be
          report cycle)
observed  M03-J1: cycle 1: an error strobe pulsed during the disabled window
```

**EXACT, with `n = 1`** — inside the sealed span and on the **first** of the two
named derivations, which is the branch **D-J2a** disclosed before the run
(`error_oversize`, pulsed on the refused start character's own cycle, the term
being combinational in the current XGMII word). §9's reason for sealing this as a
span rather than a value holds exactly: the specification forbids the report
entirely, so *where* a design reports it is not fixed, and pinning it would have
scored a conformant rendering as a finding. **The second ordering claim is
confirmed as well** — §4.2 sealed that no output word appears anywhere in the
window under this class, so §4.1's message cannot precede it, and it did not.

### 3.3 IC-J3 — seal §4.3, `M03-J3`, the disabled run's word count

```
sealed    M03-J3 (lane 0): disabled run: expected exactly 8 delivered words (frame 0 only), got <n>
          <n> sealed < 8, direction FEWER, derived 1
observed  M03-J3 (lane 0): disabled run: expected exactly 8 delivered words (frame 0 only), got 1
```

**EXACT, derived value hit on the nose.** Frame 0's words fall on cycles 4 … 11 and
the change is at cycle 5, so a gate on emission leaves the cycle-4 word alone and
mutes the other seven. A rendering with one cycle of gate latency would have given
**2**; it gave **1**, so the gate is combinational at the emission choke point —
which is what the manifest's §2.3 claims and what `+1/−1` at `tvalid` can only be.

### 3.4 IC-J4 — seal §4.4, `M03-J2`, the delivered-word count

```
sealed    M03-J2: expected 8 delivered words for frame 100, got <n>
          <n> sealed < 8, direction FEWER, derived 0
observed  M03-J2: expected 8 delivered words for frame 100, got 0
```

**EXACT, derived value hit.** Frames 0 … 99 stay refused (the class does not touch
the disable — **D-J4b**, asymmetric in the rising direction only) and frame 100 is
refused too, so the run delivers nothing at all.

### 3.5 IC-J5 — seal §4.5, `M03-J3`, the tuple comparison

```
sealed    M03-J3 (lane 0): frame 0's delivered (octets, tkeep, tlast, tuser) tuples differ between the disabled and reference runs
observed  M03-J3 (lane 0): frame 0's delivered (octets, tkeep, tlast, tuser) tuples differ between the disabled and reference runs
```

**EXACT in every character; no integer in this cell.** It is the only cell in the
campaign raised by an assertion that compares two runs of the same schedule, and it
was reached **because** the class changed nothing the three assertions before it
read: the whole reference run at `Enable.high`, and the disabled run's word count
of **8**. Under IC-J5 the disabled run delivers eight words at the reference's
cycles with the reference's octets and `tkeep`, and differs in **one bit**.

### 3.6 Summary

**5 of 5 `R!` cells exact.** Every mutant-owned quantity landed inside its sealed
inequality with the sealed direction; three hit their derived value exactly
(**1**, **0**, **1**), and the fourth landed on a named endpoint of its span
(**1** of `{1, 11}`). No `R!` cell printed a value the seal did not admit.

---

## 4. The worked blast-radius cells (seal §5.2) — every one hit

| class | unit | sealed | observed |
|---|---|---|---|
| IC-J1 | `M03-J2` | `> 8`, derived **808** | `M03-J2: expected 8 delivered words for frame 100, got 808` |
| IC-J1 | `M03-J3` | `> 8`, derived **16** | `M03-J3 (lane 0): disabled run: expected exactly 8 delivered words (frame 0 only), got 16` |
| IC-J2 | `M03-J2` | exact, no integer | `M03-J2: an error strobe pulsed` |
| IC-J2 | `M03-J3` | exact, no integer | `M03-J3 (lane 0): disabled run: an error strobe pulsed — frame 0 should close cleanly on its own /T/ and REQ-810 gives the refused frame 1 no strobe at all` |
| IC-J2 | `M03-N4` | `> 1`, derived **2** | `M03-N4 (lane 0): expected exactly one strobe (error_start_without_terminate at A's own report cycle), observed 2` |

**808 = 101 × 8 exactly** and **16 = 2 × 8 exactly** — the two integers §9 rows four
and five exist for. The em dash in IC-J2's `M03-J3` message printed as the decimal
escapes `\226\128\148` in the promoted source, **exactly as the seal's §1 encoding
note said it would**, and the comparison is against the decoded string.

**The UNWORKED cell behaved as sealed.** `M03-N4`'s delivered-cycles message fired
under IC-J1, IC-J3 and IC-J4 with three different lists —
`[4; 6; 7; 8; 9; 10; 11; 14; …]`, `[14; 15; …]` and `[4]` respectively, against an
expected `[4; 14; 15; 16; 17; 18; 19; 20; 21]`. **No cell reads that list**; it is
information, never a cell, and a disagreement about it is not a finding (§9). It
is reported here and scored nowhere.

**Every blast-radius red is inside its class's own rule (§3.4), and no red fell
outside one.** IC-J1's and IC-J2's rule sets `{M03-J1, M03-J2, M03-J3, M03-N4}`
were matched exactly; IC-J3's `{M03-J3, M03-N4}` exactly; IC-J4's
`{M03-J2, M03-N4}` for its own assertions plus `M03-J1` through the latency tagger,
exactly; IC-J5's `{M03-J3}` exactly — **the narrowest rule of the campaign selected
one unit and exactly one unit reddened.** Standing rule 5's per-row finding limb
never fired: no unit selected by a class's rule stayed green.

---

## 5. The load-bearing greens (`G!`), and the one `M` cell

### 5.1 The `G!` cells — all verified green

1. **`M03-J1` green under IC-J3** → `DECLARATION J-D1` measured (see §7.3 for the
   precision this round obliges).
2. **`M03-J2` green under IC-J3** → **`WO-0067` §6's honest-kill withdrawal is
   MEASURED.** §8.1 rule 1 fires exactly: `M03-J3` red at its own cell **and**
   `M03-J2` green. The withdrawal was argued from the stimulus in 2026-08-09 and
   is now established from a run: **IC-J3 is a continuously-sampling design, and
   `M03-J2`'s geometry cannot see it**, because the enable is 1 for the whole of
   frame 100's admitted extent. This is the round's centrepiece and it is the
   `FINDING M-1`/`M-2` pattern one family over. A bench cannot make that
   measurement; a campaign can, and this one did.
3. **`M03-J3` green under IC-J4** → the class keys on a **0 → 1** change and
   `run_j3`'s schedule is `changes ~initial:true [(5, false)]`, which contains no
   re-enable at all. §10(d)'s derivation from the stimulus rather than from a
   category is confirmed: the condition is an empty set there, which is what makes
   the green load-bearing rather than lucky.
4. **`M03-J1` green under IC-J5** and **5. `M03-J2` green under IC-J5** → the class
   keys on a 1 → 0 change **with a frame open**, and not on a change as such.
   Neither unit has one.
6. **`M03-N4` green under IC-J5** → **the marking is not sticky.** Frame A is
   already aborted under REQ-110 and carries `tuser`[0] = 1 on its own `tlast`, so
   the mark changes nothing observable there — *unless* it reached frame C, admitted
   after the enable returns. It did not: `touched`'s `begins` clear term holds, and
   §10(e)'s reasoning is measured rather than assumed.

**A note on the count, which is a defect of mine**: §3.1 asserts "there are six of
them" and its bullet list describes six, but the matrix marks five cells `G!` —
`M03-J2 × IC-J5` is marked plain `G`. Both readings are satisfied here because the
cell is green either way. It is nonetheless a seal defect and is filed at §10 as
`FINDING WO-0076-S2`.

### 5.2 The `M` cell — `M03-J1` under IC-J4, resolved as §5.6 outcome 1 in substance

```
M03-J1: latency tagger errors:
frame 0: 72 input octets less 8 stripped from the front and 4 from the back is 60, but 0 octets were emitted
```

**Every one of the row's own assertions passed** — the disabled-window silence
scan, the driven-window check, and the control run at `Enable.high` (101 `tlast`
words, 101 segmented frames, sequence numbers 0 … 100 in order). The red arrives at
`assert_monitors_clean` on the disabled bench, through the **latency tagger** arm,
fed by `account_clean_frame`.

**So `WO-0076` §4 item 8 is MEASURED**: `M03-J1`'s title says the re-enabled frame
100 is received correctly, and **no assertion in the unit reads frame 100's
delivered stream**. The only instrument that saw its refusal is a bench-supplied
expectation. The claim in the title is not false; what it is not is an assertion.

**By standing rule 7 this red qualifies nothing**, and IC-J4's kill is `M03-J2`'s.
The tagger's report body was sealed **UNREAD** and is read here as a diagnostic
only.

**The string, however, is not the one the seal quoted, and that scores against
me** — `FINDING WO-0076-S1`, §10.

---

## 6. MUST-STAY-GREEN, against the seal's own denominators

Denominators as sealed at §0 and re-measured at the base: **59 M03 units; 139
repository-wide OCaml units; 80 non-M03 = 79 behavioural + 1 build-level**;
`test/cosim/` contributes **0 units**; **exactly four of the 59 drive
`cfg_rx_enable` away from `Enable.high`**.

| set | denominator | result under all five classes |
|---|---|---|
| M03 units that never drive the enable | **55** | **GREEN.** The twelve other `test_m03_*.ml` files and `test_m03_structural.ml` appear in no promotion block under any class |
| non-M03 behavioural units | **79** | **GREEN.** `test/monitors/` 37, `test/xgmii/` 25, `test/golden/` 11, `test/axi64_probe/` 3, `test/xgmii_probe/` 3 — no file promoted under any class |
| `test/hardcaml_ethernet/` build-level unit | **1** | **GREEN**, and step 5 `Build` = success in all five: **no build finding** |
| `test/cosim/` | **0 units** | job conclusion **success** under all five and at the control — §6.1's predicted worthless green |

**Not one MUST-STAY-GREEN violation in the campaign**, and the guarantee is the
single conjunct the whole packet rests on: **enable-high invariance (D-J1b)**. The
manifest discharged it structurally per class (`x &: 1 ≡ x`; the added disjunct
≡ 0; the added conjunct ≡ 1; `settling ≡ 0` including through `clear` and from time
zero; `touched ≡ 0`), and **the run confirms it across 134 units that hold the
enable at 1** — plus, inside `M03-J1` itself, a full control run at `Enable.high`
passing under four of the five classes. Under IC-J1 that control run is **shadowed**
by the silence scan and is recorded **unobserved, never as a pass**.

**IC-J4's reset-adjacent hazard did not fire.** The manifest chose the complement
form (`not_en` = `~:(i.cfg_rx_enable)`, both registers holding 0 through `clear`
and from time zero) precisely so that a frame starting on the first cycle after
`clear` returns is still admitted, as SPEC-M03 §7's Reset bullet requires. Had the
natural delayed-enable form been written instead, units that never drive the enable
low would have reddened and §8.1 rule 4 would have disposed of the class without
argument. **That choice is the difference between a valid class and a void one, it
was disclosed rather than discovered, and the 55 + 79 green units are its receipt.**

**§6's per-class permission check, in its positive form, confirmed by the run.** The
datapath-perturbation signature (`BUG-0003` §V.10.2) appeared under **no class** —
no short mid-frame word with `tkeep` ≠ 0xFF, no `0x07` idle filler substituted for a
required octet, no octet lost. Every observed message is a count, a cycle, a strobe
or a tuple comparison; none is an octet or a byte-enable at a frame outside its
class's permission list. **Disposition 7 did not fire for any class**, and
disposition 6 could not: five diffs, five branches, five commits, one class each.

---

## 7. Collisions

### 7.1 Collision 1 — IC-J1's blast radius at `M03-J2` ≡ IC-J4's scored cell §4.4

Character-identical up to the integer, as sealed:

```
IC-J1   M03-J2: expected 8 delivered words for frame 100, got 808
IC-J4   M03-J2: expected 8 delivered words for frame 100, got 0
```

**Discriminator 1 — the sealed integer DIRECTION — separated them on the first
reading and with no residue**: `> 8` (derived 808) under IC-J1, `< 8` (derived 0)
under IC-J4. Both directions correct; both derived values exact.

**Discriminator 2 — the measurement at another unit — agrees redundantly**:
`M03-J1` reddens at §4.1 under IC-J1 and is green at every one of its own
assertions under IC-J4.

**Performance of the direction discriminator: 2 for 2, unambiguous, and
load-bearing.** Without §9's rows four and five this cell would have had **no
bench-side discriminator at all**, because the colliding class's own scored cell
sits at a different unit entirely. A verdict that read a count-shaped message
without reading its direction would have convicted IC-J1 of IC-J4's kill or the
reverse.

### 7.2 Collision 2 — IC-J1's blast radius at `M03-J3` ≡ IC-J3's scored cell §4.3

```
IC-J1   M03-J3 (lane 0): disabled run: expected exactly 8 delivered words (frame 0 only), got 16
IC-J3   M03-J3 (lane 0): disabled run: expected exactly 8 delivered words (frame 0 only), got 1
```

**Discriminator 1 — direction**: `> 8` (derived 16) against `< 8` (derived 1).
Separated, both exact. **Discriminator 2** agrees: `M03-J1` and `M03-J2` both redden
under IC-J1 and both are **green** under IC-J3.

**`FINDING WO-0074-S4`'s cross-product method is vindicated in the sharpest
available form.** Both collisions are **one class's blast radius landing on another
class's scored cell**, at units where the colliding class scores nothing. Neither is
visible from the scored cells alone. The method was carried in as a bar; it found
two collisions; both fired; both were separated by the discriminators it forced the
seal to write. **It is now a bar on the family-K seal on evidence rather than on
precedent.**

### 7.3 Collision 3 — IC-J3's two branches (D-J3a: gate MOVED vs gate ADDED)

Sealed as having **no discriminator this bench produces**, and carried entirely by
the disclosure. **D-J3a was answered `add` before the run**, and the answer was
*forced* rather than preferred: the `move` branch is IC-J1's edit plus IC-J3's in a
single diff, which is two classes in one diff and unscoreable under §7.3 item 1.

**And this round the disclosure is corroborated by an artefact, which is new.**
`2296840` is **+1/−1** at `tvalid` (976), and the admission gate at 421–422 is
untouched. A `move` rendering is not expressible as a one-line substitution at a
single site. So at its fourth instance the `IC-D`/`IC-F` protection is
**discharged by the commit's own file statistics** and not only by the answer —
the first time in this programme that the branch pair has independent
corroboration. Banked for the family-K seal: **a branch disclosure whose branches
differ in edit *shape* can be checked against the transient's diffstat without
reading a diff body.**

**What this costs `DECLARATION J-D1`, stated precisely rather than glossed.** J-D1
says an absence-shaped observable cannot separate *never admitted* from *admitted
and muted*. IC-J3 as rendered is the `add` branch — the design **refuses and also
mutes**. `M03-J1`'s green under it therefore measures directly that **the silence
scan cannot see an emission gate at all**. The *admitted-and-muted* design is the
`move` branch, which was not rendered; the seal's own §7 collision 3 pre-committed
that the bench produces no discriminator between the branches, so `M03-J1`'s green
under `move` follows from a **pre-run derivation, not from a run**. **J-D1 STANDS
and is MEASURED on the `add` branch; its strongest form remains derived.** It goes
to the `AP-` round as a §7 X-row in exactly that wording and not in a stronger one.

### 7.4 Near-collisions

As sealed and costing nothing: IC-J1, IC-J3 and IC-J4 all raised `M03-N4`'s
delivered-cycles message with different lists at a cell **no class scores**;
IC-J2's `M03-J2` and `M03-J3` strobe messages are scored by no class. **No two
classes shared a scored cell in a way the seal could not separate.**

---

## 8. Per-class verdict, kills, qualifications and blast radius

| class | verdict | kills | scored cell | qualifies | blast radius, qualifying nothing |
|---|---|---|---|---|---|
| **IC-J1** | **KILLED** | **1** | §4.1 @ `M03-J1` | **`M03-J1`**, no-output-word clause (REQ-810 sentence 1) | `M03-J2`, `M03-J3`, `M03-N4` — all through the same ungated admission |
| **IC-J2** | **KILLED** | **1** | §4.2 @ `M03-J1` | **`M03-J1`**, no-strobe clause | `M03-J2`, `M03-J3`, `M03-N4` |
| **IC-J3** | **KILLED** | **1** | §4.3 @ `M03-J3` | **`M03-J3`**, word count | `M03-N4` |
| **IC-J4** | **KILLED** | **1** | §4.4 @ `M03-J2` | **`M03-J2`**, its **honest** kill and nothing else | `M03-N4`; and `M03-J1`'s monitor-arm red |
| **IC-J5** | **KILLED** | **1** | §4.5 @ `M03-J3`, tuple comparison | **`M03-J3`**, tuple comparison | **none — the rule selected one unit** |
| **campaign** | **5 seeded of 5 sealed** | **5 KILLED / 0 SURVIVED / 0 VOID** | | | |

**Kills are counted per class** (`WO-0066` §11). IC-J1's four reds are **one** kill,
never four; IC-J1 and IC-J2 both qualifying `M03-J1` is **two kills and one
qualification**, and likewise IC-J3 and IC-J5 at `M03-J3`.

**QUALIFIED J rows, under rule 7 — only an assertion of the row's own observable:**

- **`M03-J1` — QUALIFIED**, by IC-J1 and by IC-J2, on two distinct clauses of its
  own Observable.
- **`M03-J2` — QUALIFIED**, by IC-J4, **on its honest kill only**. **It is NOT
  qualified on the withdrawn continuous-sampling cell, and IC-J3's run is what
  proves the withdrawal was right.** The plan's prohibition (`J-dv_lead-0124`) is
  absolute and is enforced here rather than merely quoted.
- **`M03-J3` — QUALIFIED**, by IC-J3 and by IC-J5.
- **`M03-J4` — NOT QUALIFIED and unqualifiable** (§6.2, equivalent mutant by
  specification). No kill in this campaign is evidence about it.
- **`M03-N4` — QUALIFIED BY NOTHING HERE.** It took a red under four of the five
  classes; **every one is blast radius.** It is family N's row, scored at
  `WO-0066`, and nothing in this campaign re-qualifies it in either direction.
  §12 item 7 discharged in terms.

**Three of the four §4.J rows are qualified; the fourth cannot be.** The campaign
pays the debt on the three oldest unscored rows in the programme, landed at
`2dbd39b` and passed over by eight campaigns.

**§10(g)'s figure, as §12 item 8 requires it be stated rather than implied.** The
three J units carry **22 DUT-observable assertions**; this campaign's five classes
reached **7** — `M03-J1`'s two silence arms, `M03-J2`'s word count and
empty-strobe check, `M03-J3`'s word count, tuple comparison and empty-strobe check.
**Fifteen are probed by nothing here**, including every per-word assertion in
`M03-J2` (cycle, `tkeep`, `tlast`/`tuser`, octets, sequence number), the whole
reference run in `M03-J3`, its cycle comparison and its refusal check, and
`M03-J1`'s control run. **Five kills at four units is not breadth**, and the
scorecard is not permitted to imply it.

**Every lane-4 member is UNOBSERVED, never a miss and never a pass** (§5.3,
R-DISC-1). `run_j3 ~lane:0` and `run_n4 ~row:"M03-N4 (lane 0)"` raised first under
every class in which their units reddened; no lane-4 string appears anywhere in the
campaign. The manifest discharged both lanes term by term; the bench observed one.

---

## 9. §6's pre-ship check and the manifest's conduct

**The pre-ship check was delivered in its positive form for all five classes with
the `Enable.high` column discharged structurally, and the run confirms all five.**
Nothing was shipped with a known movement outside its permission list, and the two
cells whose *reading* was in question — IC-J1's *every strobe*, IC-J3's *in
flight* — were raised as pre-run questions instead of resolved unilaterally. Both
rulings (RN-1 SCOPED, RN-2 OUTPUT-SIDE) are confirmed as costless by the run:
RN-1's divergence set is `M03-N4` alone, whose reds are blast radius under every
class; RN-2's divergence set was measured **empty** at all four carriers, and no
observed message contradicts either.

**RN-3 is confirmed exactly as ruled.** The pairing moved — the shared admission
site is **IC-J1 + IC-J4**, not IC-J1 + IC-J3 — and **the collision inventory was
unaffected**, because the inventory ranges over red sets × scored cells and a
*site* is not a term in it. The pair that actually shares the site is the pair of
collision 1, already inventoried and already discriminated. Disposition 6's
carve-out, read on the principle it cites, names the right pair; its trigger never
fired.

### 9.1 The auditor's conduct — **CLEAN**, and better than clean in one respect

**The four disclosed exposures, ruled individually:**

1. **`git log --oneline -3` at the mandatory first action**, returning the base
   commit's subject and two below it. Every clause in that subject is inside §16's
   **freely told** set — the five classes, the capability, the cross-product method
   and the *existence* of collisions the old method missed. **No cell, no message
   string, no MUST-STAY-GREEN member.** **Immaterial**, and disclosed at the only
   moment it could have been. Not a finding.
2. **`git show --stat --name-only 8346a5c`** — file names only. **Required**:
   discharging §8's base rule and R-SEAL-1 means knowing the seal is in the
   packet's own commit, and knowing a file exists is not reading it.
   **Necessary and correctly bounded.** Not a finding.
3. **Trailers and file names over three commits.** This settled §8.0's `WO-0075`
   hazard from metadata alone and exposed six paths **as names**. **Proportionate,
   and it answered a question my own packet raised and could not answer** — I
   cannot run git. Its self-stated limit (whether a *successor* work order will
   edit `test/**` inside the window is not answerable from metadata) is correct,
   and I discharged that limb at scorecard time: the freeze held. Not a finding.
4. **Two `git log` subject reads** for the §8.2 provenance arbitration.
   **Immaterial.** Not a finding.

**Ruling: every exposure is metadata, none is content, none touches `test/**`, the
seal, or another agent's journal, and each is disclosed at the point of use with
what was taken and what was not.** A blinding statement that enumerates its own
leaks is the only kind worth reading, and this one does. **The run itself is
corroboration that the seal was not opened**: a manifest written against it would
not have produced a scorecard in which one class's blast radius lands on two other
classes' scored cells with precisely the directions the seal pinned — nor would it
have left `M03-J2` green under IC-J3, which is the one green the seal cared most
about.

**The allowlist-narrowing at the ADR discrepancy — the item that deserves the
ruling.** The spawn prompt's enumerated allowlist omitted `ADR-0014`, which this
packet's §7 item 4 admits by name; the spawn said the allowlist is *"per the
packet's terms"*, so the packet governed and the ADR **was** readable. The auditor
**did not read it under either name**, honouring the **narrower** of two
disagreeing instruments.

**RULING: CORRECT, and it is the disposition this programme should want.** Two
normative instruments disagreeing about a permission is a defect in the
instruments, not a licence for the reader. Resolving it by intersection costs a
round nothing when the permission is not load-bearing, and it leaves the
disagreement **visible** instead of consuming it. The auditor then *proved* the cost
was nil rather than asserting it: all five classes are derived from REQ-810,
REQ-803 and SPEC-M03 §4.3/§6.1/§6.2, each of which states ADR-0014's ruling in its
own words. **And the by-product is the round's cheapest finding**: listing
`docs/adr/` to check the path it had been handed is what exposed that §7 item 4
cites a filename that has never existed. **An error in my instrument, found by a
reader honouring it** — which is exactly why RN-4 was carried as a dated,
appended correction and a lessons-harvest candidate rather than patched silently
into §7's body.

**One MINOR item raised by the manifest and discharged here in its favour.**
**D-J2b**'s caveat: an input word carrying start characters in *both* lane 0 and
lane 4 while disabled refuses two frames and produces one high cycle, and the
auditor could not check whether any carrier drives such a word (`test/**` barred).
**I can, and no carrier in this campaign drives one**: `M03-J1`/`M03-J2`'s
101-frame schedule alternates lanes 0 and 4 across frames 0 … 99 at 50/50 with one
start character per word — the unit measures that split itself — and `M03-J3`
drives two frames at one lane each. The counting-convention shortfall the caveat
guarded **has no instance**, and no observed count is short by one. **Not a
finding: a disclosure that did its job.**

---

## 10. Findings

### `FINDING WO-0076-S1` (MINOR, **against me** — the seal's §5.4/§5.6)

**The seal quoted a monitor-arm message it had not measured, and the arm that fired
is the one it omitted.** §5.4 enumerates four forms —
`protocol monitor unclean:`, `conservation monitor unclean:`,
`strobe monitor unclean:`, `latency tagger unclean:`. `assert_monitors_clean`
(`test/xgmii_rx_64/bench.ml:599–639 @ 8346a5c`) has **five** arms, and in source
order the fourth is `": latency tagger errors:\n"` at **`:632`**, which **precedes**
`": latency tagger unclean:\n"` at **`:638`**. IC-J4's `M` cell raised the fourth;
§5.6 outcome 1 quoted the fifth.

**Standing rule 2 obliges every message in the seal to be derived from the unit's
committed control flow and source order at the base SHA. It was honoured for the
five `R!` cells — including two ordering claims (§3.1, §3.2 above) that could each
have been falsified and were not — and it was NOT honoured for the monitor arms,
which were written as a class of forms rather than measured.**

**Cost: nil to the score**, and the reason is structural rather than lucky: §5.4's
disposition, §5.6's three outcomes, standing rule 7 and §9's UNREAD row all key on
**which instrument spoke**, not on what it printed, and the instrument is the
latency tagger under either string. §4 item 8 is measured; the red qualifies
nothing; IC-J4's kill is `M03-J2`'s.

**But the near-miss is the point.** Had §5.6 outcome 1 been sealed `R!` rather than
`M`, this round would have scored a **correct** rendering as off-pattern on a
string the bench never emits. A seal that quotes a message it did not measure is a
seal that mis-scores the first cell keyed to a string.
**Carrier: the family-K seal**, which owes this enumeration measured before it
writes any monitor-arm form.

### `FINDING WO-0076-S2` (MINOR, **against me** — the seal's §3.1)

**A matrix and its own prose count disagree.** §3.1 asserts the `G!` cells "are
this round's own measurements and there are six of them", and its bullet list
describes six (counting `M03-J1` **and** `M03-J2` under IC-J5). The matrix marks
**five**: `M03-J2 × IC-J5` is plain `G`. **Cost: nil this round, because the cell
is green under both readings and both readings are therefore satisfied.** Had it
reddened, the round would have had to decide whether a load-bearing measurement was
lost, with no rule to decide it by and the result already known. This is
`FINDING WO-0066-3`'s defect one artefact over — an enumeration and a rule
disagreeing inside one document. **Carrier: the family-K seal.**

### `FINDING J-1` — raised before the run, unrepaired, and it survives the run

Both halves stand. The first: `M03-J1`'s Kills cell in its **narrow** reading
("gates the output but leaves the strobe path live") remains unreachable — under no
class did a refused clean frame draw a report except where the class itself added
one, which is IC-J2, the cell's separable **parenthetical**. IC-J2 killed, so the
parenthetical is now scored and the narrow reading is now measured as unreachable
rather than argued. The second half is unchanged and is now pointed: **the
no-output-word clause — REQ-810's first sentence, IC-J1's whole ground, and the
source of this campaign's first kill — still has no Kills cell at all.**
**Carrier: the post-campaign `AP-` round.**

### `FINDING J-2` — raised before the run, and the run confirms its asymmetry

`M03-J3`'s strobe clause convicted a design that **adds** a strobe (IC-J2's radius,
character-exact at §4 above) and remains unfalsifiable in the **subtractive**
direction: no class in this campaign suppresses an in-flight frame's own report,
and IC-J3's D-J3b answer (`strobes stay live`) is what would have exercised it —
except that `M03-J3`'s frame 0 is clean and owes none. The carrier that convicts
the suppressing design is `M03-N4`, family N's row, and **not** a family J
qualification in either direction. **Carrier: the post-campaign `AP-` round.**

### `FINDING WO-0076-A1` (auditor's, MINOR) — adopted, widened, and discharged here

Adopted at `J-dv_lead-0141` §5 with the widening that makes it stricter for me than
as filed (any cited file, not only `libs/**`; document-level SHA declaration
permitted). **Discharged for this verdict** by its own preamble. The one-line
repair at `M03-M5` remains owed to the `AP-` round; exposure measured at exactly
one citation.

### Against the manifest — **nothing**

No class out of specification, no combined diff, no undisclosed branch, no red
outside a rule, no MUST-STAY-GREEN violation, no `NOT SEEDED`, no build finding, no
`cosim` red. **Five classes offered, five seeded, five killed.**

---

## 11. The declarations, stated whatever the score (§12 item 6)

1. **The differential co-simulation anchor is blind to this entire campaign by
   STIMULUS** (§6.1). The `cosim` job is **success** under all five classes and at
   the control. **That green is worth nothing and no verdict may cite it.** Both
   producers hold `cfg_rx_enable` at 1 for the whole run
   (`test/cosim/ours_run.ml:142`, `test/cosim/tb_xgmii_rx_64.v:63`, both
   @ `8346a5c`) and the lane drives one 64-octet good-FCS frame with no
   configuration change anywhere. This is `WO-0075`'s **bar 4** at its second
   instance and its purest: at family M the blindness had three candidate causes
   and the verdict named the wrong one; here there is exactly one, because the port
   under test is never driven. A strobe field, a cycle column or a wider canonical
   form would change nothing. **Discharged only by a co-simulation stimulus that
   drives the enable**, which REQ-901's class list does not contain.
2. **`M03-J4` is unscoreable and stays unscored** (§6.2). SPEC-M03 §6.3 item 7 and
   C-14.5 leave the same-cycle case deliberately unconstrained, so every rendering
   is an **equivalent mutant by specification**. A full five-of-five scorecard is
   **not** full coverage of §4.J, and this verdict says so rather than letting the
   score imply it.
3. **The `Bench.Enable` guard and its structural witness are unreachable by any
   mutation, and neither fired** (§6.3). The guard's *entry* condition remains
   mechanically witnessed and its *refusal* has still never fired on a real
   violation: **a half-measured instrument, unchanged by this round in either
   direction.**
4. **REQ-802/§9.1's reset value for `receive enable` is never observed at this
   bench** (§6.4). No `SO-` may count §9.1's reset column as covered by family J.
5. **REQ-810's header-record prohibition has no instance at M03** (§6.5).
   Discharged by the interface, not by a test.
6. **`DECLARATION J-D1` STANDS and is MEASURED** on the `add` branch, with §7.3's
   precision: the strongest form remains derived, not run. **No verdict may cite
   `M03-J1`'s green as evidence that frames were not admitted.**
7. **§6.8's portable form holds, and the score does not move it**: a family whose
   rows drive a configuration input away from its default has its whole convicting
   power bounded by the number of tests that drive it — **four of fifty-nine here**
   — and that number is invisible in a coverage count. Five kills do not change it.
8. **A kill proves the assertion convicts, never that the bench is a general
   detector of the class.** IC-J1 was detected at four units; **this bench was not
   blind to it**, and no reading of this verdict may imply it was.

---

## 12. Era tally

Class-based, `WO-0050` onward. Prior figure **49 sealed / 47 killed / 1 survived /
1 void**, recorded at `WO-0074-VERDICT` §12 and in `tasks/BOARD.md`.

| | sealed | killed | survived | void by declaration |
|---|---|---|---|---|
| before this campaign | 49 | 47 | 1 | 1 |
| **family J (this campaign)** | **+5** | **+5** | **+0** | **+0** |
| **after** | **54** | **52** | **1** | **1** |

52 + 1 + 1 = 54. The single survivor remains `G-c4` (`FINDING G-1`); the single
void remains `IC-M5`. **Family J is the fourth campaign in the era to return a
clean sweep, and the first whose classes were permitted to move the datapath.**

---

## 13. What this round does NOT close

1. **No `SO-xgmii_rx_64.md` issues and none is offered.** Outstanding before any
   PASS: the family **K** campaign, and the charter §3 verilog-ethernet
   differential co-sim anchor — undischarged, and now blind **per configuration
   class** as well as per strobe. **The lessons harvest falls due at the `SO-`**,
   spanning from my last harvest; it is **not** due this round and the span stays
   open, declared rather than skipped. Two new candidates are banked at
   `J-dv_lead-0142` against it.
2. **§8's freeze has now EXPIRED**: the campaign has scored, so `test/**` and
   `tools/**` may move again. Every AP edit this campaign wants is owed to the
   post-campaign `AP-` round.
3. **`FINDING J-1`, `FINDING J-2`, `FINDING WO-0076-S1`, `FINDING WO-0076-S2`** —
   all four raised and none repaired here. Carriers named at §10.
4. **Carried, not this verdict's to pay**: `WO-0047` §2's 4-octet anti-vacuity
   question (`test_m03_f.ml`); `OBSERVATION L-O1` (`test_m03_l.ml`);
   `WO-0073-D3`'s `M03-I4` mislabel (`test_m03_i.ml`); `OBSERVATION K-O1`
   (`test/monitors/`).
5. **Nothing here bears on family K, on the fifty-five M03 units that never drive
   the enable, or on the `SO-` those still gate.**

---

## 14. What I commission next, in order

1. **The family K campaign — the LAST of the era.** Owed before any `SO-`. Its
   seal inherits four bars, two of them minted by this round:
   `FINDING WO-0074-S4`'s cross product (now vindicated on evidence, §7.2);
   `FINDING WO-0074-S1`'s complete conjunct lists; **`FINDING WO-0076-S1`'s
   measured monitor-arm enumeration**; and **`FINDING WO-0076-S2`'s re-derived
   cell counts**.
2. **`WO-0075`'s build round, released** — unblocked the moment this campaign
   scored.
3. **The post-campaign `AP-` round** — the next commit opening
   `test/attack_plans/**`. It pays, in one commit: §4.J's rows gaining this
   campaign's score and their per-row qualification cells (`M03-J1` ×2, `M03-J2`
   ×1 **on its honest kill only**, `M03-J3` ×2, `M03-J4` recorded unscoreable,
   `M03-N4` recorded explicitly unqualified here), `FINDING J-1`'s two halves,
   `FINDING J-2`, `DECLARATION J-D1` as a §7 X-row **in its measured wording**,
   `FINDING WO-0076-A1`'s one-line citation repair at `M03-M5`
   (`libs/hardcaml_ethernet/src/xgmii_rx_64.ml:296 @ ca1bb80`), and the change-log
   row.

**One sequencing hazard in that order, flagged because it is §8.0's hazard one
family over and it is silent when it fires.** Items 2 and 3 both open `test/**`.
Family K's campaign needs the same freeze this one had — bench frozen strictly
earlier than its seal, and no `test/**` byte moving until it scores. **Running item
1 first therefore puts two `test/**`-opening rounds inside family K's campaign
window, and by my own rule the round would re-seal.** The disposition that worked
this round is Q1's disposition (b): land the `test/**` work **before** the commit
that stages the seal. **My recommendation is to run 3 → 2 → 1**, which costs
nothing (the AP round and the build round are one commit each, and family K's seal
is not yet drafted) and buys the freeze outright. **The choice is the operator's,
not mine; this is question 1.**

---

## 15. Evidence

All CI, all at the source, all re-checkable by the auditor.

```
control          8346a5c  run 31061945377  build job 92491537453  success (10/10 steps)
IC-J1  8aaa0dd   run 31064102925  build job 92498074622  step5 Build=success  step6 tests=failure
IC-J2  f61157b   run 31064103812  build job 92498077419  step5 Build=success  step6 tests=failure
IC-J3  2296840   run 31064104902  build job 92498080573  step5 Build=success  step6 tests=failure
IC-J4  1c1bfb1   run 31064106060  build job 92498083901  step5 Build=success  step6 tests=failure
IC-J5  8589bfd   run 31064107507  build job 92498087940  step5 Build=success  step6 tests=failure
cosim job conclusion: success under all five classes and at the control (evidence of nothing, §6.1)

freeze, re-verified at scorecard time:
  git diff --name-only 8346a5c HEAD -- test/ libs/   -> (empty)
  git status --porcelain | wc -l                     -> 0
  git rev-parse HEAD                                 -> cbc2765 (spawn HEAD, unmoved)

transient integrity, via the API, no ref/index/HEAD movement:
  each of the five branches: 1 commit, sole parent 8346a5c, 1 file
  (libs/hardcaml_ethernet/src/xgmii_rx_64.ml), sizes +2/-2, +5/-1, +1/-1, +5/-2, +7/-1

monitor-arm enumeration behind FINDING WO-0076-S1:
  test/xgmii_rx_64/bench.ml:599-639 @ 8346a5c -- five arms, :632 "latency tagger errors:"
  preceding :638 "latency tagger unclean:"
```

**Adjudicated against the seal as frozen at `8346a5c`, opened only after every
scorecard was in hand. Five classes, five kills, five exact cells — and two
defects in the seal, both mine, both scored against me under §0.3.**

---

# APPENDED CORRECTION — 2026-08-10, dv_lead, `J-dv_lead-0144`

**This block corrects two claims made in this file. It is APPENDED. Not one
character of any sentence it corrects has been edited, and none ever will be:
a correction that rewrites its own subject destroys the evidence that the
error occurred, and the rate of these errors is the argument
(`J-dv_lead-0143`).** Read the original sentences at their own sections; read
this block for what they should have said. Both were convicted by
`J-dv_lead-0143`'s re-measurement round — `FINDING AP-2` and `FINDING AP-3`
respectively — and both are **mine**, in documents I wrote myself.

Neither correction moves the score. **Five classes, five kills, zero
survivors, zero voids — unchanged.** What moves is a count and a coverage
claim, and the coverage claim is the one with teeth.

---

## C-1 — the red count is FOURTEEN, not fifteen (`FINDING AP-2`)

**Where the wrong figure stands**: `WO-0076-VERDICT` §2, the sentence
immediately below the scorecard table, opening *"Fifteen reds across five
classes…"*.

**What is correct**: **fourteen**. The table directly above that sentence
enumerates them, and they sum:

| class | units red | count |
|---|---|---|
| IC-J1 | `M03-J1`, `M03-J2`, `M03-J3 (lane 0)`, `M03-N4 (lane 0)` | 4 |
| IC-J2 | `M03-J1`, `M03-J2`, `M03-J3 (lane 0)`, `M03-N4 (lane 0)` | 4 |
| IC-J3 | `M03-J3 (lane 0)`, `M03-N4 (lane 0)` | 2 |
| IC-J4 | `M03-J1` (monitor arm), `M03-J2`, `M03-N4 (lane 0)` | 3 |
| IC-J5 | `M03-J3 (lane 0)` | 1 |
| **total** | | **14** |

4 + 4 + 2 + 3 + 1 = **14**. The rest of that sentence stands unamended and is
confirmed: every one of the fourteen lands on one of the four units the
enable census named, and no fifth unit reddened under any class.

**The corrected accounting, in the form a later scorecard should quote**:
**fourteen reds, five kills, nine reds that qualify nothing.**

**Why it matters more than a digit.** The blast-radius figure is the number a
later document quotes forward; a scorecard that over-counts reds by one
over-states the campaign's reach at exactly the place a sign-off packet reads
it. And this is `FINDING WO-0076-S2`'s defect — an enumeration and its own
prose count disagreeing inside one document — at its **second instance in
this same file, one section from where the first was filed**. `AP-M03` §4.J's
post-campaign block already carries the corrected figure; this block puts the
correction where the verdict's own reader meets it.

---

## C-2 — `M03-N4` was NEVER scored at `WO-0066`, and is qualified by nothing anywhere (`FINDING AP-3`)

**Where the wrong claim stands — four places in this file, all corrected here
and none edited:**

1. `WO-0076` **§2**: *"`M03-N4` is family N's, already scored at `WO-0066`, and
   every red it takes here is **blast radius** (§11)."*
2. `WO-0076` **§4 item 7**: *"family N's row, scored at `WO-0066`, and **not** a
   family J qualification in either direction."*
3. `WO-0076` **§11**: *"It is family N's row, it was scored at `WO-0066`, and
   nothing here re-qualifies it."*
4. `WO-0076-VERDICT` **§8**: *"It is family N's row, scored at `WO-0066`, and
   nothing in this campaign re-qualifies it in either direction."*

**What is correct**, measured against `WO-0066` itself rather than quoted from
memory:

- `WO-0066` qualified **`M03-N2`**, **`M03-B2`** and **`M03-B4` member (b)**.
  It did **not** qualify `M03-N4`, and it could not have: that campaign's own
  **§13 item 2** calls `M03-N1` and `M03-N4` *"both still outstanding ASSERT
  rows"* whose bench **had not been written at that time**. A row with no unit
  cannot take a seeded red, and took none.
- Widened to the whole era: **`M03-N4` has taken five reds across two
  campaigns** — one under `IC-M4` at `WO-0074`, four here — **and has been
  qualified by none of them.** Every one of the five is blast radius, reached
  through the admission path rather than through an assertion of the row's own
  observable, which is exactly what `WO-0076` §11's qualification rule
  excludes.
- **`M03-N1` is qualified by nothing at all** — it has never taken a seeded red
  in any campaign.

**The corrected sentence, in the form every one of the four places should have
carried:**

> `M03-N4` is family N's row. It is **qualified by nothing — not by this
> campaign, and not anywhere else in this programme's history.** Every red it
> takes here is blast radius, and so was its red at `WO-0074`. `M03-N1` is in
> the same position and has never taken a red at all.

**Why this one has teeth, and it is not a scoring error.** The clause *"already
scored at `WO-0066`"* has exactly one function in each of the four sentences:
to soften **QUALIFIED BY NOTHING HERE** into *qualified elsewhere*. There is no
elsewhere. **Two of family N's four rows are landed, green, and
mutation-scored by nothing**, and until `J-dv_lead-0143` this file told every
reader the opposite — an unearned reassurance sitting directly in the path of
an `SO-xgmii_rx_64.md`. **No `SO-` may cite `M03-N1` or `M03-N4` as
mutation-qualified**, and the standing consequence of this correction is that
whether they can be qualified at all is an open commission, answered at
`RV-0075-VERDICT` §7 (the family-K round's Q2).

---

## C-3 — what this correction does NOT change

- **The score.** Five sealed, five seeded, five killed; era tally 54 / 52 / 1 / 1.
  Unaffected by both corrections.
- **Any qualification.** `M03-J1` ×2, `M03-J2` ×1 (honest kill only), `M03-J3`
  ×2, `M03-J4` unscoreable — all stand exactly as §8 records them.
- **Any of §11's eight declarations**, including declaration 1 (the anchor is
  blind to this whole campaign **by stimulus**), which `RV-0075-VERDICT`
  re-confirms at the anchor's first real timing execution.
- **The seal.** `WO-0076_…-SEALED-predictions.md` is untouched by this block and
  is never edited.

**Correction authored by dv_lead at `J-dv_lead-0144`, 2026-08-10, HEAD
`22ffe13`. Source of both convictions: `J-dv_lead-0143` (`FINDING AP-2`,
`FINDING AP-3`), re-verified against `WO-0066` §13 item 2 and against this
file's own §2 table at this SHA before this block was written.**
