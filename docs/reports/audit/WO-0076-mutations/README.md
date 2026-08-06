# WO-0076 — family-J mutation manifest: five configuration classes against `cfg_rx_enable`, all five seeded, none of them cut

- **Author**: auditor (`J-auditor-0017`), spawn short-id `WO-0076-SEED/2026-08-10T08:10Z`
- **Commission**: `agents/handoffs/WO-0076_family-j-mutation-campaign.md`
- **Base SHA applied to**: `8346a5ca11883381ea738cf1efa5f0dcd67d6907` (packet §7.3 item 6)
- **State**: **manifest delivered; the five transient branches are NOT cut.** This is
  not a refusal this round — `FINDING WO-0074-A1` (MAJOR, mine, ruled **ACCEPTED**)
  is carried into the packet's own terms at §7.1, so the operator cuts the five
  branches from §11's table in §10's fixed order. Every diff below is verified to
  apply alone at the base SHA, to parse, and to revert clean.
- **This manifest is the seeding half only.** It carries no scorecard, no CI run id,
  no control-run conclusion and no `cosim` conclusion; those are the run half's
  (packet §15 items 4–7) and **CI is the authority** (ADR-0005, packet §12(c)).
  Nothing below is offered as a claim that a class *does* kill: a manifest predicts
  a mechanism, a run measures it.

---

## 0. Blinding — stated affirmatively, with every exposure disclosed

**What I read for this campaign, and nothing else.**

| # | path | extent |
|---|---|---|
| 1 | `agents/charters/auditor.md`, `agents/PROTOCOL.md` | in full — my mandatory first actions, which precede the packet's allowlist |
| 2 | `agents/handoffs/WO-0076_family-j-mutation-campaign.md` | in full (all 1172 lines, in two reads) |
| 3 | `libs/hardcaml_ethernet/src/xgmii_rx_64.ml` | all 1011 lines, at the base SHA |
| 3b | `libs/hardcaml_ethernet/src/xgmii_rx_64.mli` | all 45 lines, at the base SHA — read to confirm no rendering needs an interface edit (§6) |
| 4 | `docs/specs/modules/xgmii_rx_64.md` | §4.2 (171–193), §4.3 (194–245), §5, §6.1 (261–300, 380–510, 650–713), §6.2 (714–728), §6.3 (729–802), §7 (803–880), §9 (929–1048); the section-heading index of the whole file; three `grep` hits in §10/§11/§13 |
| 5 | `docs/specs/requirements.md` | rows **REQ-802**, **REQ-803**, **REQ-810** and §9.1's `receive enable` row (835–872); the §13 change-log rows that move REQ-810 (978, 988–990); `grep -n` hit lines for REQ-008/REQ-016/REQ-110 |
| 6 | `docs/reports/audit/**` | my own tree: `WO-0074-mutations/README.md` (form, and the `a_open` provenance question), directory listing of the rest |
| 7 | `agents/journals/claude_auditor_agent.md` | my own journal only — the entry-id chain and the harvest-span boundaries (four `grep`/`sed` windows, no other reading) |

**Not read, absolutely.** The sealed companion
`WO-0076_family-j-mutation-campaign-SEALED-predictions.md` — **not opened, not
grepped, not `git show`n, no excerpt, no line count, no diff stat of its own**.
**All of `test/**`**: `test_m03_j.ml`, `test_m03_n.ml`, `test_m03_structural.ml`,
`bench.ml`/`bench.mli`, `test/xgmii/`, `test/monitors/`, `test/golden/`,
`test/cosim/`, and **the attack plan `test/attack_plans/AP-xgmii_rx_64.md` by
name**. **All of `agents/**`** bar the packet and my two charter documents,
including **every journal but my own** and every other handoff packet. Also not
read: `docs/gates/`, `tasks/`, `tools/`, `.github/`, `scripts/`, `libs/**` other
than the target, and every `docs/specs/` file other than the two named.

**One allowlist discrepancy, resolved conservatively.** My spawn prompt enumerates
the allowlist and **omits `docs/adr/ADR-0014.md`**, which the packet's own §7
item 4 admits by name. The spawn says the allowlist is *"per the packet's terms"*,
so the packet governs and ADR-0014 was readable — **I did not read it anyway.**
Every class below is derived from REQ-810, REQ-803, SPEC-M03 §4.3/§6.1/§6.2 and the
packet's own §1 text, all of which state ADR-0014's ruling in their own words
(SPEC-M03 §4.3's *"The case that forced the ruling"*, §9's clause (b), REQ-810's
admission clause). Nothing below rests on the ADR, and the narrower of the two
allowlists is the one that was honoured. **I did list `docs/adr/`** (file names
only, to check the path the packet cites) and found the packet's citation
`docs/adr/ADR-0014.md` does **not** exist: the file is
`docs/adr/ADR-0014-an-enable-gates-admission-not-the-wire.md`. That is a broken
path in an allowlist, reported at §9 RN-4, and it is why the `wc -l` that produced
this manifest's line counts returned an error for that one path.

**Four exposures outside the allowlist, disclosed because a blinding statement that
omits its own leaks is worthless.**

1. **`git log --oneline -3` at my first action**, which returned the base commit's
   own subject — *"The ninth campaign sealed: five classes against the enable
   capability, and the S4 method finds the collisions the old method missed"* — and
   the two subjects below it (`b112e47`, `c109c08`). I did not seek the subject and
   did not act on it; every clause in it is inside the packet's §16 **freely told**
   set (five classes, the capability, §10's cross-product method and the existence
   of collisions the old method missed). **No cell, no message string and no
   MUST-STAY-GREEN member is in it.**
2. **`git show --stat --name-only 8346a5c`** — **file names only, never content**.
   Three paths: the packet, the seal, and dv_lead's journal. Discharging §8's base
   rule and R-SEAL-1 requires knowing the seal is in this commit; nothing else was
   taken from it.
3. **`git log --format='%(trailers:key=Work-Order…)'` over three commits and
   `git show --stat --name-only c109c08`** — trailers and file names only, to
   settle the packet's own §8.0 hazard (§1.2 below). This exposed six paths under
   `test/**`, `tools/**` and `agents/**` **as names**; no byte of any of them was
   read.
4. **`git log -1 -- libs/…/xgmii_rx_64.ml`** (→ `b848d56`, BUG-0003's repair) and
   **`git log --diff-filter=A -- docs/reports/audit/WO-0074-mutations/README.md`**
   (→ `adac5ca`), both for the provenance arbitration at §8.2. Subjects only.

**Nothing in `test/**` was read, listed for content, counted or inferred from.**
Where this manifest needs a fact about a carrier's stimulus it takes it **from the
packet's own freely-told sections** and says so at the point of use, or it states a
**rule in stimulus terms** instead (packet §3.5). **No diff below was chosen
against a written expectation**: each is the narrowest edit that renders its class's
own sentence of REQ-810 / REQ-803 / SPEC-M03 §4.3 in this design's terms.

---

## 1. The base SHA, §8's rule, and the freeze

### 1.1 The abort-first HEAD check (§7.2) and §8's base rule

```
$ git rev-parse HEAD
8346a5ca11883381ea738cf1efa5f0dcd67d6907
$ git show --stat --name-only 8346a5c        (names only — the seal was NOT opened)
agents/handoffs/WO-0076_family-j-mutation-campaign-SEALED-predictions.md
agents/handoffs/WO-0076_family-j-mutation-campaign.md
agents/journals/claude_dv_lead_agent.v06.md
$ git rev-parse 8346a5c^
b112e475f3a6117c6bf17b1cca85782c7b8afdbb
```

HEAD **matches** the base the operator supplied, so §7.2's abort does not fire.
§8 fixes the base as *"the commit that stages this packet and its seal. Not its
parent"*: `8346a5c` stages **both**, so the literal base and the operating base are
one commit and **there is nothing to file** — the second clean application of the
corrective drafting rule adopted at `WO-0073-VERDICT` §7. **R-SEAL-1 is satisfied on
its face**: the seal is a file in the packet's own commit, so it appears in that
commit's `Files-in-this-commit` list, and it was frozen before any diff existed.

The mutation target has not moved since **`b848d56`** (BUG-0003's repair), an
ancestor of the base. All five classes, the control run and every MUST-STAY-GREEN
sweep are against this one SHA (`BUG-0003` §V.9).

### 1.2 The §8.0 hazard, and a fact the packet could not have

§8.0 names one live hazard — *"`WO-0075` is outstanding and its return edits
`test/cosim/**`"* — and makes it **question Q1**. From git metadata alone
(trailers and file names; no content):

```
8346a5c | Work-Order: WO-0076 | Agent: dv_lead     <- the base commit
b112e47 | Work-Order: WO-0075 | Agent: orchestrator
c109c08 | Work-Order: WO-0075 | Agent: dv_lead     <- last test/** edit before the base
   files: agents/handoffs/WO-0075_cosim-lane-cycle-comparison.md, dv_lead's journal,
          test/attack_plans/AP-xgmii_rx_64.md, test/cosim/dune,
          tools/cosim/run_cosim.sh, tools/dv_checks.sh
```

**`WO-0075`'s return landed at `c109c08` and its rulings at `b112e47`, both
strictly before the base commit.** So the packet's own §8 sentence — *"the last
`test/**` edit before this packet is `c109c08` … and nothing under `test/**` moves
again until the campaign scores"* — is **verified at the base**, and Q1's
disposition (b) (*land `WO-0075` before the commit that stages this packet*) is what
actually happened. **The freeze holds at seeding time**: `8346a5c` stages no
`test/**` byte, and the working tree is clean (`git status --porcelain` → 0 lines,
before and after every patch trial at §11).

**The limit of that check, stated rather than glossed**: `b112e47`'s subject says a
further bound was *"commissioned before the sign-off"*. Whether a **successor**
work order derived from `WO-0075` will edit `test/**` inside this campaign's window
is not answerable from metadata, and the packet's own rule governs if one does —
the round re-seals. That is the operator's to answer, not mine; I record only that
**as of the base SHA nothing under `test/**` is pending in history.**

---

## 2. The five classes — five diffs, all seeded

Every diff touches `libs/hardcaml_ethernet/src/xgmii_rx_64.ml` and **nothing else**,
applies **alone** at `8346a5c`, and reverts clean. **Delivery order is §10 item 2's
and is fixed: IC-J1, IC-J2, IC-J3, IC-J4, IC-J5.** Line numbers below are the base
file's at `8346a5c`.

**The one design fact every class rests on, measured before any class was written**
(`grep -n '\bcfg_rx_enable\b'`, comments and the port declaration excluded):

```
82:    ; cfg_rx_enable : 'a          (the I record's field — a declaration, not a read)
421:  let b_exists = bit lanes.is_start 0 &: i.cfg_rx_enable &: ~:(i.clear) in
422:  let c_exists = bit lanes.is_start 4 &: i.cfg_rx_enable &: ~:(i.clear) in
```

**The base design reads the enable at exactly two sites, and both are the admission
gate.** That is SPEC-M03 §4.3's *"gates the admission of a frame, and nothing
else"* realised as a two-line fact, and it is why IC-J1's removal is total and why
IC-J2, IC-J3 and IC-J5 each have to *introduce* a read at a path the enable does not
currently reach (packet §5's expected shape, confirmed here rather than assumed).

### 2.1 IC-J1 — the enable does not gate admission (REQ-810's first sentence)

```diff
@@ -418,8 +418,8 @@ let create (scope : Scope.t) (i : Signal.t I.t) : Signal.t O.t =
   let inword_closing above =
     (lanes.is_terminate |: lanes.is_error |: lanes.is_start |: other_ctl) &: above
   in
-  let b_exists = bit lanes.is_start 0 &: i.cfg_rx_enable &: ~:(i.clear) in
-  let c_exists = bit lanes.is_start 4 &: i.cfg_rx_enable &: ~:(i.clear) in
+  let b_exists = bit lanes.is_start 0 &: ~:(i.clear) in
+  let c_exists = bit lanes.is_start 4 &: ~:(i.clear) in
   let b_closing = inword_closing (of_int ~width:8 0xfe) in
   let c_closing = inword_closing (of_int ~width:8 0xe0) in
```

The class is *"a start character arriving while the enable is 0 opens a frame
exactly as it would while the enable is 1"*, and in this design that is the deletion
of one conjunct from each of the two admission gates. **After the edit the enable is
read nowhere in `create`** — verified on the mutant file: the only surviving
occurrence is the port declaration at 82. That is the strongest form D-J1a can be
answered in: the removal is **the admission gate alone** because there was nothing
else to reach.

**Both lanes, deliberately.** Removing the conjunct from 421 only would render a
**lane-asymmetric** design, which is a different defect and would be **NOT SEEDED**
at lane 4 for every carrier that drives both start lanes (packet §5's per-lane rule).

**Rejected**: gating `to_preamble` (609) or the `Always` switch's four arms (614,
617, 627, 637) instead. Same observable, four sites instead of two, and it would put
the edit *downstream* of `survivor_b`/`survivor_c`, leaving the in-word report path
(588, 589) still gated — a design that admits frames but does not report the ones it
closes in their own word. That is two classes, not one.

### 2.2 IC-J2 — a refused frame is reported (REQ-810's third prohibition)

```diff
@@ -1000,7 +1000,11 @@ let create (scope : Scope.t) (i : Signal.t I.t) : Signal.t O.t =
   ; error_bad_fcs = strobe sel_bad_fcs
   ; error_bad_frame = strobe sel_error |: q_strobe 0
   ; error_runt = strobe sel_runt |: q_strobe 1
-  ; error_oversize = strobe sel_oversize
+  ; error_oversize =
+      strobe sel_oversize
+      |: ((bit lanes.is_start 0 |: bit lanes.is_start 4)
+          &: ~:(i.cfg_rx_enable)
+          &: ~:(i.clear))
   ; error_start_without_terminate = strobe sel_start |: q_strobe 2
   }
```

**The admission gate is retained verbatim** (421, 422 untouched), so no frame is
accepted and no output word appears: the rendering violates REQ-810's *third*
prohibition and only that one. The added term is combinational in the current XGMII
word, so it pulses on the **refused start character's own cycle**.

**Why `error_oversize` and not one of the other four** (D-J2a says the class is the
same whichever, so the choice is mine to justify): it is the only strobe with **one**
report path — `error_oversize` (1003) and `error_bad_fcs` (1000) carry epoch A's
path alone, and of those two only `error_oversize` has **no genuine instance in any
64-octet stimulus**, because REQ-108 needs more than 1518 received octets. So the
added report cannot collide with a conformant report **by name** at any carrier in
this campaign, and the strobe **count** — which is the quantity the packet's §9
seals — stays a clean discriminator. Choosing `error_start_without_terminate` would
have put the added pulse under the same name as the genuine REQ-110 abort the packet
says family N's in-flight frame owes (§4 item 7), where §6.3 item 8's counting
convention can read two events as one high cycle.

**Rejected**: adding the term at `strobe` (990) or at `consume` (977). Both are
shared by three or four outputs and would move reports of *admitted* frames, which
is outside this class's permission list.

### 2.3 IC-J3 — the enable gates the datapath rather than the start character

```diff
@@ -973,7 +973,7 @@ let create (scope : Scope.t) (i : Signal.t I.t) : Signal.t O.t =
   let abort = sel_bad_fcs |: sel_error |: sel_start |: sel_oversize |: sel_runt in
-  let tvalid = (emit_full |: emit_tlast) &: ~:(i.clear) in
+  let tvalid = (emit_full |: emit_tlast) &: ~:(i.clear) &: i.cfg_rx_enable in
   consume <== (sel_valid &: (emit_tlast |: sel_is_r2));
```

`tvalid` (976) is read at exactly one site — the output record (993) — so the edit
gates **the emission of output words continuously and nothing else**: while the
enable is 0 no word leaves the module, whatever admitted it. This is ADR-0014's
**rejected** reading rendered at the narrowest site that expresses it.

**This is the `add` branch of D-J3a, and the choice is forced by §7.3 item 1.** The
`move` branch is *"remove the admission gate and add an output gate"* — which is
IC-J1's edit plus this one, in one diff. That diff would be **two classes**, would
make both unscoreable, and is exactly what the packet forbids. Retaining admission
gating is therefore not a preference; it is the only way IC-J3 and IC-J1 can be five
independent diffs rather than four.

**Rejected**: gating `emit_full`/`emit_tlast` (962, 963) instead. `emit_tlast` feeds
`consume` (977), so that edit would also strand or move the **strobes of frames
admitted while the enable was 1** — outside the permission list, and it would make
D-J3b's answer an accident of the site rather than a disclosed choice.

### 2.4 IC-J4 — the re-enable is not honoured at the next start character

```diff
@@ -418,8 +418,11 @@ let create (scope : Scope.t) (i : Signal.t I.t) : Signal.t O.t =
   let inword_closing above =
     (lanes.is_terminate |: lanes.is_error |: lanes.is_start |: other_ctl) &: above
   in
-  let b_exists = bit lanes.is_start 0 &: i.cfg_rx_enable &: ~:(i.clear) in
-  let c_exists = bit lanes.is_start 4 &: i.cfg_rx_enable &: ~:(i.clear) in
+  let not_en = ~:(i.cfg_rx_enable) in
+  let not_en_d = reg spec not_en in
+  let settling = not_en_d |: reg spec not_en_d in
+  let b_exists = bit lanes.is_start 0 &: i.cfg_rx_enable &: ~:settling &: ~:(i.clear) in
+  let c_exists = bit lanes.is_start 4 &: i.cfg_rx_enable &: ~:settling &: ~:(i.clear) in
```

Rendering **(S)** of D-J4a, at **settling depth 2**: a start character is admitted
only where the enable was high at its own cycle *and* at the two preceding cycles.
REQ-803 and §4.3 require admission at **one** cycle after the change; this design
needs two, so it refuses exactly the frame at the specification's tightest legal
placement and admits everything two or more cycles out — which is the permission
list read as an equation.

**The blocking signal defaults to non-blocking, and that is load-bearing.** `not_en`
is `~:(i.cfg_rx_enable)`, so at `Enable.high` it is the constant 0, both registers
hold 0 **including through `clear` and from time zero**, and `settling` is
identically 0. Had I written the natural form — `reg spec i.cfg_rx_enable`, a
delayed *enable* — the register would read 0 during and immediately after `clear`,
and the design would refuse **a frame whose start character arrives on the first
cycle after `clear` returns to 0**, which SPEC-M03 §7's Reset bullet requires to be
received correctly. That rendering would redden units which never drive the enable
low, which §8.1 rule 4 disposes of without argument. **The complement form has no
reset-adjacent side effect at all**, and the difference is a whole class's validity.

**Rejected**: rendering **(L)** (latch the enable at a frame boundary). It needs an
enable-gated register whose update condition is itself derived from `begins` — a
larger edit, and one that couples the class to the admission path it is supposed to
delay.

### 2.5 IC-J5 — the in-flight frame is *affected* by the change

```diff
@@ -972,7 +972,13 @@ let create (scope : Scope.t) (i : Signal.t I.t) : Signal.t O.t =
   let keep_count =
     mux2 emit_last_a (pc -: strip) (mux2 emit_last_b (pc -: strip +: nc) pc)
   in
-  let abort = sel_bad_fcs |: sel_error |: sel_start |: sel_oversize |: sel_runt in
+  let touched =
+    reg_fb spec ~width:1 ~f:(fun d ->
+      mux2 begins gnd (d |: (a_open &: ~:(i.cfg_rx_enable))))
+  in
+  let abort =
+    sel_bad_fcs |: sel_error |: sel_start |: sel_oversize |: sel_runt |: touched
+  in
   let tvalid = (emit_full |: emit_tlast) &: ~:(i.clear) in
```

**The packet named IC-J5 the likeliest NOT SEEDED, and the question is settled by a
grep rather than by an argument**: `abort` (975) is read at **exactly one** site,
`tuser` (998). So `tuser`[0] **is** separable from every strobe in this design, and
the class is **SEEDED**.

`touched` is set on any cycle where a frame is open (`a_open`, 296 — `in_preamble |:
in_frame`, this design's own term for §9's *"a frame is open"*) **and** the enable is
low, and is cleared when a new frame is admitted (`begins`, 430). A frame in flight
across a 1 → 0 change therefore carries `tuser`[0] = 1 on its `tlast` word — one
bit — while its word count, its cycles, its `tkeep`, its octets and every strobe are
produced by expressions the edit does not reach.

**Rejected**: setting the mark inside the closure record (503–515) or at `r0`'s
`~fcs`/`~error` fields. Every one of those routes through `sel_*` (528–534) into
both `abort` **and** the strobe outputs (1000–1004), which is D-J5a's *both*
rendering — a second, unsealed red ahead of the class's own cell.

---

## 3. R-DISC-2 — the gate inventory, three paths, with cross-class facts tabulated

**The campaign's gate inventory is admission / emission / report** (packet §5).
Each row carries its **full term list at the base**, then every class's claim.

### 3.1 The admission path — the enable's gate on start-character acceptance

**Complete term list**, base, in dependency order:

```
421  b_exists      = bit lanes.is_start 0 &: i.cfg_rx_enable &: ~:(i.clear)
422  c_exists      = bit lanes.is_start 4 &: i.cfg_rx_enable &: ~:(i.clear)
423  b_closing     = inword_closing 0xfe        (a closure character in lanes 1…7)
424  c_closing     = inword_closing 0xe0        (a closure character in lanes 5…7)
428  survivor_b    = b_exists &: ~:(any b_closing)
429  survivor_c    = c_exists &: ~:(any c_closing)
430  begins        = survivor_b |: survivor_c
```

**Everything `begins` reaches** — this is D-J1a's list and it is the same list for
every class that moves this path: `frame_start4` (432), the CRC reload (478), the
octet-count reload (479), the in-word report path's existence gates (588, 589),
`to_preamble` (609) and through it **all four** `Always` arms — `Idle → Preamble`
(614), `Preamble → Preamble` (617), `Frame → Preamble` (627), `Discard → Preamble`
(637) — plus `start4_pending` (663) and `off4` (666).

| class | claim about the admission path |
|---|---|
| **IC-J1** | **removes** `i.cfg_rx_enable` from 421 **and** 422. Every other term retained: `bit lanes.is_start k`, `~:(i.clear)`, `b_closing`/`c_closing`, and the whole of `begins`' fan-out above |
| **IC-J2** | **untouched, verbatim.** The class needs the gate intact — a reported refusal is still a refusal |
| **IC-J3** | **untouched, verbatim** (this is D-J3a's `add` branch; see §3.4) |
| **IC-J4** | **adds** `~:settling` to 421 **and** 422; `i.cfg_rx_enable` and every other term retained |
| **IC-J5** | **untouched, verbatim**; reads `begins` (430) as its clear condition only |

### 3.2 The emission path — the output-word path

**Complete term list**, base: `ev12` (955), `closed` (956), `closure_aligned` (957),
`decided` (958), `emit_last_a` (959), `emit_last_b` (960), `fcs_tail_pending` (961),
`emit_full` (962), `emit_tlast` (963), `hold` (971), `keep_count` (972–974), `abort`
(975), `tvalid` (976), and the output record's five stream fields (992–999), fed by
`al_data_d`/`al_keep_d` (781, 782) out of the alignment window (732–745).
**The enable reaches none of them at the base.**

| class | claim about the emission path |
|---|---|
| **IC-J1** | **untouched.** Words appear for frames the specification refuses only because those frames were *admitted*; every word that leaves is produced by the base expressions |
| **IC-J2** | **untouched.** The class adds a report and no word |
| **IC-J3** | **adds** `i.cfg_rx_enable` as a conjunct of `tvalid` (976) — **the only edit** — introducing the enable to this path for the first time |
| **IC-J4** | **untouched** |
| **IC-J5** | **adds** `touched` as a disjunct of `abort` (975), which reaches `tuser` (998) and **nothing else**. No word-presence term (`tvalid`, `tlast`, `tkeep`, `tdata`) is reached |

### 3.3 The report path — the five strobes' enables

**Complete term list**, base: the closure record and its ageing (503–534), `consume`
(977), `strobe` (990), the in-word vector `inword_strobes` (570–582) and its two
fixed stages `q2` (583–590), `q_strobe` (991), and the five outputs (1000–1004).
**The enable reaches this path at the base only *indirectly*, through `b_exists`/
`c_exists` at the `~exists` arguments (588, 589).**

| class | claim about the report path |
|---|---|
| **IC-J1** | **no direct edit**, but the class **does** reach this path through 588/589: a frame the mutant admits and closes inside its own word raises the in-word strobes a conformant design never raises, because the frame never began. Disclosed rather than discovered; see §9 RN-1 for what it costs |
| **IC-J2** | **adds** one disjunct at `error_oversize` (1003). `strobe sel_oversize` retained; no other output, and neither `consume` nor `q_strobe` is touched |
| **IC-J3** | **untouched — and that is D-J3b's answer.** A frame the output gate mutes still pulses whatever strobe it owes, on its own pinned cycle |
| **IC-J4** | **no direct edit**; reaches 588/589 in the same *direction as the base* — a refused frame raises no in-word strobe either way, so no report a conformant design makes is moved |
| **IC-J5** | **untouched.** Verified, not assumed: no expression at 1000–1004 reads `abort` |

### 3.4 Cross-class gate facts, tabulated **before** delivery

| fact | classes | disposition |
|---|---|---|
| **Lines 421–422 are edited by two classes** — IC-J1 removes a conjunct, IC-J4 adds one | IC-J1, IC-J4 | **A shared site is not a combined diff** (`WO-0073-VERDICT` §7 Q4). Two branches, two diffs; they are not even textually combinable, since both replace the same two lines |
| **All five renderings read `i.cfg_rx_enable`**; the base reads it at two sites, and IC-J2/J3/J5 each add a read at a path the enable does not currently reach (1003, 976, 975) | all five | The packet's §5 expected shape, **confirmed and extended**: it named IC-J2 and IC-J3 as the two classes touching a path the enable does not reach; IC-J5 is a third |
| **`~:(i.clear)` is a conjunct of every gate any class moves** (retained in IC-J1/J3/J4, added in IC-J2) | all five | **No rendering can fire while `clear` is high** |
| **`begins` (430)** is downstream of IC-J1's and IC-J4's edits and is read by IC-J5 as its clear term | IC-J1, IC-J4, IC-J5 | Different roles at different sites; no diff overlap |
| **`a_open` (296)** is read by IC-J5 only | IC-J5 | Its other readers (362, 364, 732) are untouched by every class |
| **The packet's §5 expectation that IC-J1 and IC-J3 would share the admission gate does not hold** | IC-J1, IC-J3, IC-J4 | Because D-J3a's `add` branch was chosen (§2.3), IC-J3 does not touch admission at all; the admission gate is shared by **IC-J1 and IC-J4** instead. **Declared here, before the run** — §9 RN-3 |

---

## 4. R-DISC-1 — reachability discharged term by term, per class, per lane

**Convention, stated once.** Absolute cycle numbers are bench-supplied and `test/**`
is barred, so every cycle below is named **relative to a stimulus event the packet
itself states in the open** (§1, §5): the change cycle, the start character's cycle,
and the distance between them. Where the packet gives absolute numbers — the
re-enable at **1050** and the start character at **1051** — they are used verbatim.
A conjunct is marked **[S]** where the *stimulus* contributes it and **[M]** where
the *mutation* does.

### 4.1 IC-J1

**Gate**: `b_exists` (421) / `c_exists` (422), complete defining expressions quoted
at §2. **Firing cycle**: the cycle of **each** refused frame's start character inside
the disabled window.

| conjunct | base value at the firing cycle | mutant | source |
|---|---|---|---|
| `bit lanes.is_start 0` (lane 0) / `bit lanes.is_start 4` (lane 4) | 1 | 1 | **[S]** the schedule drives a start character |
| `i.cfg_rx_enable` | **0** | **removed** | **[S]** contributes the 0; **[M]** removes the conjunct |
| `~:(i.clear)` | 1 | 1 | **[S]** no `clear` mid-run |

So `b_exists`/`c_exists` = **0 → 1**. Downstream, at the same cycle: `b_closing` =
`inword_closing 0xfe` = 0 **[S]** (a well-formed start word carries `/S/` in lane 0
and preamble octets in lanes 1…7, none of them control), so `survivor_b` = 1 and
`begins` = 1 — the frame is admitted, `to_preamble` fires, the CRC and count reload,
and the frame is delivered by the unmodified pipeline. **Lane 4** is identical with
`c_closing` = `inword_closing 0xe0` = 0 **[S]** over lanes 5…7.

**The three cycle facts.** (a) the driven change: the 1 → 0 edge that opens the
disabled window, which REQ-810's verification column and the packet's §1 place
**with no frame in flight**; (b) acceptance: each refused frame's own start cycle,
inside the window; (c) distance: **≥ 1 cycle** for every one of them, because the
disable is established before the window's frames arrive. So every frame this class
admits is one §4.3 **governs** — none of them is C-14.5's deliberately unconstrained
same-cycle case, and the class attacks constrained behaviour only.

**The mutant-owned quantity and its direction**: the delivered-word count at any
carrier rises, because an ungated admission adds frames and can remove none. The
**cycle** of the first delivered word is **not** mutant-owned — §6.1's `m + 3` over
the schedule's own first admitted start word fixes it, and the edit changes no
pipeline term, so a first-word cycle other than *(that start word's cycle) + 3*
would mean the rendering moved the fixed delay, which it does not.

**Per lane**: the edit is symmetric across 421 and 422, so the discharge above holds
at **both** start lanes for every carrier that drives both. Where a carrier iterates
lane 0 then lane 4 in one unit, the lane-4 member is **unobserved** if lane 0 raises
first (packet §3.4) — never a miss and never a pass.

### 4.2 IC-J2

**Gate**: the added disjunct at `error_oversize` (1003), whose complete term list is
`(bit lanes.is_start 0 |: bit lanes.is_start 4) &: ~:(i.cfg_rx_enable) &:
~:(i.clear)`. **Firing cycle**: the **refused start character's own cycle** (D-J2a),
read under the packet §5(b) `Before` view — the cycle whose input word was driven.

| conjunct | value at the firing cycle | source |
|---|---|---|
| `bit lanes.is_start 0 \|: bit lanes.is_start 4` | 1 | **[S]** |
| `~:(i.cfg_rx_enable)` | 1 | **[S]** the disabled window |
| `~:(i.clear)` | 1 | **[S]** |
| *(the whole disjunct)* | **1**, where the base expression is 0 | **[M]** the disjunct exists |

The retained term `strobe sel_oversize` is **0 at every cycle of every carrier in
this campaign** **[S]**: `sel_oversize` requires `a_close_oversize` (361), which
requires the received count to pass **1518** — unreachable in a 64-octet stimulus.
So every `error_oversize` pulse a carrier sees under IC-J2 is the added one, and its
count is exactly the number of **cycles carrying a refused start character**.

**The three cycle facts.** (a) the 1 → 0 change opening the window; (b) each refused
start character's cycle; (c) ≥ 1, as §4.1. **Per lane**: the disjunct covers lane 0
and lane 4 symmetrically, so both members of a two-lane carrier fire.

**Mutant-owned quantity**: the **cycle** the strobe prints is the refused start
character's own cycle — the earliest candidate derivation, since the term is
combinational and not registered. The **count** at a carrier rises by one per
refused-start cycle; it can never fall.

### 4.3 IC-J3

**Gate**: `tvalid` (976), complete defining expression `(emit_full |: emit_tlast) &:
~:(i.clear) &: i.cfg_rx_enable`. **Firing cycle**: **every** cycle at which the base
design would assert `tvalid` while the driven enable is 0.

| conjunct | value at the firing cycle | source |
|---|---|---|
| `emit_full \|: emit_tlast` | 1 | **[S]** + base design: a frame admitted before the change has words to emit |
| `~:(i.clear)` | 1 | **[S]** |
| `i.cfg_rx_enable` | **0** | **[S]** the disabled window; **[M]** the conjunct exists |

so `tvalid` = **1 → 0** at those cycles, and the frame loses every word from the
change cycle onward. Nothing else moves: `emit_full`, `emit_tlast`, `hold`,
`keep_count`, `consume` and every strobe are the base expressions on the base
values, so the words that **do** leave (before the change) leave on their base cycles
carrying their base octets and `tkeep`.

**The three cycle facts.** (a) the 1 → 0 change, landing **while a frame is open**;
(b) the start character of that frame was accepted **before** the change — so
REQ-803 governs it and requires completion under the old value; (c) the distance is
whatever the schedule gives, and **the class does not depend on it**: any 1 → 0
change strictly inside a frame's emission span produces the defect.

**Per lane**: the gate is at the emission choke point, downstream of the alignment
window, so it is **independent of the start lane** and fires identically at lane 0
and lane 4. The *number* of muted words is bench-derived (it depends on where the
change falls among the frame's word cycles) and is therefore stated as a direction —
**fewer than the reference**, never more.

**One edge inherent to the class, declared before the run.** The gate keys on the
**cycle of emission**, not on the enable value at the frame's admission. So a frame
whose *input* extent ended before the change but whose last word is still in the
two-cycle drain window (§6.1's ΔC − 1 = 2) also loses that word. A rendering that
could tell those apart would have to know when the frame was admitted — which is the
**conformant** design. The edge is what *"gates the datapath rather than the start
character"* means, not a defect in the rendering; §9 RN-2 asks dv_lead to confirm
the reading.

### 4.4 IC-J4

**Gate**: `b_exists` (421) / `c_exists` (422) with `~:settling`, where `settling` =
`not_en_d |: reg spec not_en_d` and `not_en` = `~:(i.cfg_rx_enable)` — so
`settling(t)` = `¬enable(t−1) ∨ ¬enable(t−2)`. **Firing cycle: 1051**, the start
character exactly one cycle after the re-enable at 1050 (packet §5).

| conjunct | value at cycle 1051 | source |
|---|---|---|
| `bit lanes.is_start k` | 1 | **[S]** frame 100's start character at 1051 |
| `i.cfg_rx_enable` | 1 | **[S]** re-enabled at 1050 |
| `~:(i.clear)` | 1 | **[S]** |
| `~:settling` | **0**, because `settling(1051)` = `¬enable(1050) ∨ ¬enable(1049)` = `0 ∨ 1` = **1** | **[M]** the term exists; **[S]** supplies `enable(1049) = 0` — the disabled window extends to 1049 |

So `b_exists`/`c_exists` = **1 → 0** at 1051, `begins` = 0, and **frame 100 is
refused: no output word for it anywhere in the run.** At a hypothetical start at
**1052**, `settling` = `¬enable(1051) ∨ ¬enable(1050)` = `0 ∨ 0` = 0 and the frame
is admitted — so the defect is **exactly one cycle wide** and every frame admitted
two or more cycles after a change is untouched, which is the permission list
discharged as arithmetic rather than asserted.

**The three cycle facts.** (a) change **1050**; (b) acceptance **1051**;
(c) distance **exactly one** — §4.3's *"at least one cycle after"* is satisfied, so
the specification **requires** admission and the mutant refuses. This is the tightest
legal placement and the only distance this round measures (packet §14 item 5).

**Per lane**: symmetric across 421/422; whichever start lane the re-enabled frame
uses, the discharge is the same three-conjunct evaluation.

**The 1 → 0 direction, discharged too** (D-J4b): at a 1 → 0 change at cycle *d*,
`i.cfg_rx_enable(d)` = 0 already blocks admission at *d* through the **retained**
conjunct, and `settling` blocks *d+1* and *d+2* where the enable is 0 anyway. **No
cycle exists at which the mutant admits a frame the base refuses.** The edit is
asymmetric in the **rising** direction only.

### 4.5 IC-J5

**Gate**: `tuser` (998) = `emit_tlast &: abort`, with `abort` (975) extended by
`touched`. `touched`'s complete term list: **set** on `a_open &: ~:(i.cfg_rx_enable)`,
**clear** on `begins`, registered (`reg_fb`, so the effect appears the cycle after
the set condition). **Firing cycle**: the cycle the in-flight frame's `tlast` word is
emitted.

| conjunct | value at the firing cycle | source |
|---|---|---|
| `emit_tlast` | 1 | **[S]** + base design: the frame completes under the old value (REQ-803), unmoved by this edit |
| `sel_bad_fcs \|: sel_error \|: sel_start \|: sel_oversize \|: sel_runt` (base `abort`) | **0** | **[S]** the frame in flight is clean — well-formed, good FCS, closed by its own `/T/` |
| `touched` | **1** | **[M]** the register exists; **[S]** supplies both of its terms — a 1 → 0 change **while `a_open` is high**, and **no `begins` between that cycle and the `tlast` cycle**, the latter because the retained admission gate refuses the next start character while the enable is 0 |

so `tuser` = **0 → 1** on exactly that word: **the disabled run differs from its
reference in one bit**, at the same cycles, with the same octets, the same `tkeep`
and the same (empty) strobe set.

**The three cycle facts.** (a) the 1 → 0 change, **inside the frame's open extent**
(`a_open` = `in_preamble |: in_frame`); (b) the frame's start character was accepted
**before** the change, so REQ-803 governs and §6.1 requires it to be *"not
affected"*; (c) the distance is bench-supplied and the class does not turn on it —
any change strictly inside the open extent sets the bit.

**Per lane**: `touched` is independent of the start lane; both members of a two-lane
carrier are reached, subject to §3.4's shadowing.

**Where `touched` is *not* set, stated because it is what keeps the class narrow**:
a disabled window with **no frame open** (`a_open` = 0 throughout) never sets it, so
a carrier that drives the enable low between frames — REQ-810's own verification
geometry — sees `tuser` unchanged under IC-J5.

---

## 5. The nine mandatory disclosures, answered in my own words

### D-J1a — what the rendering removes
**The `i.cfg_rx_enable` conjunct at 421 and 422, and nothing else.** It **is** the
admission gate alone, in the strongest available sense: those two lines are the
design's **only** reads of the port, and after the edit the enable is read **nowhere
in `create`** (verified on the mutant: the sole surviving occurrence is the `I`
record's field declaration at 82). **Every transition the one edit reaches**, through
`begins`: `Idle → Preamble` (614), `Preamble → Preamble` (617), **`Frame →
Preamble`** (627) and **`Discard → Preamble`** (637) — all four, including the two
§6.2 states separately — plus the CRC reload (478), the octet-count reload (479),
the start-lane capture (432), `start4_pending` (663), `off4` (666) and the in-word
report path's existence gates (588, 589). **The class permits reaching all of them
and it does; the seal now knows that it did.**

### D-J1b — enable-high invariance (demanded of every class)
**Positive, and structural rather than empirical, for all five.** At
`cfg_rx_enable` ≡ 1:

- **IC-J1**: the removed conjunct is the constant 1 and `x &: 1 ≡ x`, so both gates
  are the same function of the same signals.
- **IC-J2**: the added disjunct carries `~:(i.cfg_rx_enable)` ≡ 0 as a conjunct, so
  it is identically 0 and `error_oversize` is its base expression.
- **IC-J3**: the added conjunct is ≡ 1, so `tvalid` is its base expression.
- **IC-J4**: `not_en` ≡ 0, so both registers hold 0 at every cycle — including
  through `clear` and from time zero — `settling` ≡ 0, `~:settling` ≡ 1, and both
  gates are their base expressions.
- **IC-J5**: `touched`'s set term carries `~:(i.cfg_rx_enable)` ≡ 0, and the register
  is 0 at time zero and can only be cleared thereafter, so `touched` ≡ 0 and `abort`
  is its base expression.

**None of the five can redden a unit that never drives the enable low**, by
construction and not by care (packet §3.2). Two of them (IC-J4, IC-J5) add flops
whose outputs are constants at `Enable.high`; that is a netlist difference with no
observable, and it is disclosed rather than glossed.

### D-J2a — which strobe, and on which cycle
**`error_oversize`**, pulsed on **the refused start character's own cycle** (not the
frame's would-be report cycle). The term is combinational in the current XGMII word,
so under the packet §5(b) `Before` view the pulse belongs to the cycle whose input
word carried the `/S/`. **Why that name**: it is the only one of the five with a
single report path *and* no genuine instance at a 64-octet stimulus, so the added
report cannot be confused with a conformant one by name or by cycle at any carrier
in this campaign.

### D-J2b — one pulse per refused frame, or a level
**One pulse per refused frame** — a single high cycle on the refused start
character's own cycle, never a level held across the window. **One caveat, stated
because C-23 counts presence per name per cycle**: an input word carrying start
characters in **both** lane 0 and lane 4 while disabled refuses **two** frames and
produces **one** high cycle. I cannot check whether any carrier drives such a word
(`test/**` is barred); if one does, the count there is short by one **by the
counting convention, not by the rendering**.

### D-J3a — moved gate, or added gate
**Added.** The admission gate is retained verbatim at 421/422 and one conjunct is
added at `tvalid` (976). **The choice is forced, not preferred**: the `move` branch
is IC-J1's edit plus this one in a single diff, which is two classes in one diff and
makes both unscoreable under §7.3 item 1. Answered before the run, as §10 collision 3
requires.

### D-J3b — what happens to the frame's own report
**Not suppressed.** `consume` (977), `strobe` (990), the closure record and its
ageing (503–534) and all five outputs (1000–1004) are untouched, so a frame whose
words the output gate mutes still pulses whatever strobe it owes, on its own pinned
cycle. At `M03-J3` the frame in flight is clean and owes none, so the answer changes
no cell there (§4 item 6); at `M03-N4` it is the answer that decides the behaviour,
and it is **strobes stay live**.

### D-J4a — which of the two named renderings
**(S)**, admission needs more than one cycle of settling. **Settling depth: 2
cycles** — the enable must be high at the start character's own cycle and at the two
preceding cycles. The specification requires admission **one** cycle after the
change (REQ-803, §4.3), so the rendering refuses exactly the tightest legal placement
and admits every start two or more cycles out.

### D-J4b — the 1 → 0 direction
**Asymmetric, in the rising direction only.** `i.cfg_rx_enable` is retained as its
own conjunct, so a disable takes effect on its own cycle exactly as in the base:
there is **no cycle at which the mutant admits a frame the base refuses**, and the
class therefore never enters IC-J1's territory at a one-cycle scale.

### D-J5a — the marked quantity
**`tuser`[0] only** — the class's own first alternative. Evidence rather than
assertion: `abort` (975) is read at **exactly one** site, `tuser` (998), so no strobe
can move. This is also the answer to the packet's expectation that IC-J5 was the
likeliest **NOT SEEDED**: the shared term the declaration would have quoted does not
exist in this design, `tuser`[0] is separable, and **the class is SEEDED**.

---

## 6. §6's pre-ship check — all five classes, in its POSITIVE form

**The signature, first, for all five together** (`BUG-0003` §V.10.2): components
(a) *seven mid-frame words with `tkeep` ≠ 0xFF and `tlast` = 0* and (b) *4 of 60
octets in position, 28 delivered as `0x07`, 28 never delivered; `tlast` on word 7;
`tuser` = 0 on a corrupted frame*. **No class produces any component, and the reason
is reachability rather than argument**: not one of the five diffs touches `cov`,
`cov_first`, `cov_end`, `cov_count` (378–383), the alignment window or `bubble`
(732–745), `al_keep_d`/`al_data_d` (781–782), `pc`/`nc`/`strip` (795–800),
`keep_count` (972–974) or `tdata`/`tkeep` (994–995). **The octet and byte-enable
arithmetic is byte-identical to the base in every rendering**, so no rendering can
emit a short mid-frame word, substitute an idle filler octet or lose an octet.

**Per class, against that class's own permission list, every right-hand cell
positive:**

| class | must be identical → **confirmed**, and how |
|---|---|
| **IC-J1** | *every frame the specification requires delivered*: **identical** — on every cycle where the enable is 1 both gates are bit-identical (`x &: 1 ≡ x`), so such a frame is admitted on its base cycle and processed by unmodified expressions; the one bound is stated at §7. *every strobe*: **no strobe moves at any carrier whose refused frames are clean**, which is the geometry REQ-810's verification column fixes; where a now-admitted frame owes a report of its own the literal cell and the scoped reading disagree — **§9 RN-1**, raised before the run. *everything at `Enable.high`*: **identical** (D-J1b) |
| **IC-J2** | *every delivered word anywhere*: **identical** — `error_oversize` (1003) is an output leaf read by nothing in the module, so the edit is datapath-silent **by reachability**. *every strobe of an admitted frame*: **identical** — the added disjunct requires `~:(i.cfg_rx_enable)`, and a frame this design admits requires the enable **high** at its start cycle, so the two sets are disjoint by construction; the four other strobe expressions are untouched. *everything at `Enable.high`*: **identical** |
| **IC-J3** | *every frame whose whole extent lies inside an enabled window*: **identical** — `tvalid` is gated only on cycles where the driven enable is 0, and the words that leave carry base `tdata`, base `tkeep`, base `tlast` on their base cycles; one inherent edge (a drain-window word) is declared at §4.3 and asked at **§9 RN-2**. *everything at `Enable.high`*: **identical** |
| **IC-J4** | *every frame admitted two or more cycles after a change*: **identical** — `settling` is 0 whenever the enable was high at both preceding cycles, discharged as arithmetic at §4.4. *every refused frame*: **still refused** — the `i.cfg_rx_enable` conjunct is retained. *everything at `Enable.high`*: **identical**, including through `clear` and from time zero, which is the whole reason for the complement form (§2.4) |
| **IC-J5** | *that frame's word count, cycles, `tkeep` and octets*: **identical** — `abort` reaches `tuser` (998) and nothing else, verified by enumeration, so no word-presence or byte-enable term is reached. *every strobe*: **identical** — no expression at 1000–1004 reads `abort`. *everything at `Enable.high`*: **identical** |

**The interface does not move, for any class.** `xgmii_rx_64.mli` (45 lines at the
base) exports `I.t`, `O.t`, `create` and `hierarchical`; **all five edits are inside
`create`'s body**, none adds or removes a record field or a top-level binding, and
**no branch needs an `.mli` edit** — one file per branch, as §11 states. IC-J1 leaves
`cfg_rx_enable` **declared but unread**; that is a record *field*, not a binding, so
it raises no unused-variable warning and the signature still matches.

**No class is delivered with a known movement outside its own permission list.** The
two places where the *reading* of a permission cell is in question — IC-J1's *every
strobe*, IC-J3's *in flight* — are raised as pre-run questions at §9 and not resolved
unilaterally here.

---

## 7. Blast-radius rules — one per class, in stimulus terms, with the complete conjunct list

Per packet §3.5 (`FINDING WO-0066-3`'s correction as amended by `FINDING
WO-0074-S1`): each predicted red set is a **rule**, the rule names every gate the
rendering may **not** remove, and **the rule governs where rule and instance list
disagree**. **Every rule's first conjunct is the same** — *the unit drives
`cfg_rx_enable` low* — and no rule can select a unit that does not.

- **IC-J1.** A unit reddens iff **(1)** it drives `cfg_rx_enable` low, **(2)** a
  start character in lane 0 or lane 4 is driven while it is low and `clear` is low,
  and **(3)** the unit asserts something about the delivered stream, the strobe set,
  or a frame-accounting monitor over that window. **Not removed**: `bit
  lanes.is_start k`, `~:(i.clear)`, `b_closing`/`c_closing`, and every expression
  downstream of `begins` — so a frame the mutant admits is delivered exactly as a
  conformant design would have delivered it **had it been admitted**.
- **IC-J2.** A unit reddens iff **(1)** it drives the enable low, **(2)** a start
  character in lane 0 or lane 4 is driven while it is low and `clear` is low, and
  **(3)** the unit asserts an exact strobe set, or a strobe count, covering that
  cycle. **Not removed**: the admission gate in full, `strobe sel_oversize`, and
  every other strobe expression.
- **IC-J3.** A unit reddens iff **(1)** it drives the enable low and **(2)** the base
  design asserts `tvalid` on at least one cycle at which it is low — which requires a
  frame admitted before the change with words still to leave, **including a word in
  the two-cycle drain window** — and **(3)** the unit asserts the delivered stream.
  **Not removed**: the admission gate, the whole alignment and emission pipeline,
  `consume` and every strobe.
- **IC-J4.** A unit reddens iff **(1)** it drives the enable from 0 to 1 at some
  cycle *r* and **(2)** a start character in lane 0 or lane 4 is driven at *r* or
  *r + 1* with `clear` low, and **(3)** the unit asserts the delivered stream or the
  strobe set of the frame that start character would have begun, or a monitor over
  it. *(A start at *r* itself is C-14.5's deliberately unconstrained same-cycle case;
  the rule includes it because the mutant refuses there, and a red there is not
  evidence about constrained behaviour.)* **Not removed**: `i.cfg_rx_enable` itself,
  `bit lanes.is_start k`, `~:(i.clear)`, and everything downstream of `begins`.
- **IC-J5.** A unit reddens iff **(1)** it drives the enable low for at least one
  cycle **while a frame is open** (`a_open` high — the state machine in `Preamble` or
  `Frame`), **(2)** that frame subsequently emits a `tlast` word with **no
  intervening admitted frame**, and **(3)** the unit asserts that frame's `tuser`[0]
  or a tuple containing it. **Not removed**: everything. **This rule selects the
  narrowest set of the five** — a disabled window with no frame open never sets the
  bit, and a frame already aborted under REQ-110 already carries `tuser`[0] = 1
  through `sel_start`, so the mark is invisible there.

**A red outside the rule that selected it is a finding, not a bigger kill** — either
my rule is wrong or the diff reaches further than the class it names. **A red at a
unit that does not drive the enable low is a §3.2 violation and disposes of the
class** (§8.1 rule 4); §6 above argues each rendering cannot produce one.

---

## 8. The three confirmations carried to this round (ruled at J-orchestrator-0220/0221)

All three are **read-only confirmations inside this campaign's allowlist**, answered
from the RTL and the specification at `8346a5c` and from nothing else.

### 8.1 `DECLARATION WO-0074-D1`'s source-side half — **CONFIRMED**

**The proposition as it was put to me**: *the in-word report vector carries no FCS
member.* **True at the base SHA, and structurally rather than by a gate.**

```ocaml
570:  let inword_strobes ~exists ~closing =
        …
576:    (* bit 0 `error_bad_frame`, 1 `error_runt`, 2
577:       `error_start_without_terminate`. …*)
581:    concat_lsb [ error; terminate; start ]
583:  let q2 = reg spec (reg spec (inword_strobes … |: inword_strobes …))
991:  let q_strobe k = bit q2 k &: ~:(i.clear) in
1000:  ; error_bad_fcs = strobe sel_bad_fcs
1001:  ; error_bad_frame = strobe sel_error |: q_strobe 0
1002:  ; error_runt = strobe sel_runt |: q_strobe 1
1003:  ; error_oversize = strobe sel_oversize
1004:  ; error_start_without_terminate = strobe sel_start |: q_strobe 2
```

Four independent checks, each falsifiable at those lines:

1. **The vector has three members, not five** (581) — `error`, `terminate` (→ runt)
   and `start`. There is no FCS member to gate.
2. **`q2` is that same three-bit vector, registered twice** (583–590), so
   `bit q2 k` for *k* ∈ {0, 1, 2} **exhausts** it: no fourth bit exists to be read,
   and no unread FCS bit is lurking in the vector.
3. **The two outputs that carry no `q_strobe` term are `error_bad_fcs` (1000) and
   `error_oversize` (1003)** — each has epoch A's path alone. So the in-word path
   cannot report an FCS condition even by accident of consumption.
4. **The design says so in its own comment** (545–554): *"Three bits, not five … The
   bit is removed from the vector rather than driven low: this path has no octet
   count to test, so a gate would be a constant, and a constant is better written as
   an absent wire than as a wire that is always zero."* The spec agrees at §9's sixth
   row and §6.2's `Frame` row (a frame of fewer than five octets has no FCS to check,
   so **no check is sequenced**).

**The limit of this confirmation, stated so it is not over-read.** I confirm **the
proposition as quoted in my commission**, not `DECLARATION WO-0074-D1`'s own text:
the declaration lives in an artifact outside this campaign's allowlist, and I have
not read it. **If D1's wording differs from the quoted proposition, this
confirmation does not transfer** — re-put the differing sentence and I will confirm
or refute that one at the same lines.

### 8.2 The RTL line number (`a_open` 296) the AP now carries — **acceptable as attributed, under two conditions, with one standing hazard**

**Fact 1 — the number is right.** At `8346a5c`, line 296 of the target is exactly

```ocaml
296:  let a_open = in_preamble |: in_frame in
```

**Fact 2 — the number's provenance is an audit artifact, not an RTL read.** The pair
(`a_open`, 296) was published by **me**, in a committed report inside every agent's
read scope: `docs/reports/audit/WO-0074-mutations/README.md` line 226 (the D-M5a
answer, quoting the line verbatim) and line 1075 (the §12 summary row *"D-M5a shared
term `a_open` (296)"*), first committed at **`adac5ca`**.

**Fact 3 — the direction of travel is checkable by commit ordering.** Family J's rows
landed at **`2dbd39b`**, which is an ancestor of `adac5ca` with **35 commits between
them**. **No family-J row can have been derived from the manifest that published the
number**, because the rows predate it.

**The ruling.** PROTOCOL §10 forbids DV **deriving tests from RTL**; it does not
forbid DV **citing a fact the auditor published in a committed report**. The rule
protects a *direction of derivation*, and a plan that quotes an audit artifact is
travelling in the permitted direction. **So: not an independence violation per se —
acceptable as attributed**, subject to two conditions, both falsifiable by the
orchestrator without reading anything I cannot:

- **Condition A — attribution.** The AP must name where the number came from (this
  round, or the `WO-0074` manifest). Independence is evidenced by `Inputs` discipline
  and citation and by nothing else (charter §9's honest-enforcement note: audit
  sampling **is** the enforcement). **An unattributed RTL line number in a DV plan is
  indistinguishable from a DV read of the RTL**, and the smell is then real — not
  because the fact is secret, but because the artifact has destroyed its own
  evidence of provenance.
- **Condition B — no assertion may rest on it.** The number may appear in prose
  *about a campaign result*; **no row's Observable, no Kills cell and no expect-test
  may be keyed to it**. The test is diffable in one command: did any row's assertion
  text move in the commit that introduced the line number? If it did, that is a
  **MAJOR** independence finding and this ruling does not shelter it.

**The standing hazard — `FINDING WO-0076-A1` (MINOR), and it is against me too.**
A bare line number is a **decaying citation**: it is true only at a SHA, and `a_open`
sits at 296 today only because the target has not moved since `b848d56`. The next RTL
commit silently falsifies every such citation in `test/**` **and** in
`docs/reports/audit/**`, with no mechanical check anywhere that would notice.
**Rule**: an RTL line number carried in any artifact outside `libs/**` is written
`<path>:<line> @ <SHA>` or it is not a citation. I hold this manifest to it — every
line number above is stated at `8346a5c`, named at §1.1 — and the same repair is owed
by the AP's carrier round and by my own prior manifests. *Falsifiable*: `grep` any
committed artifact for a bare `<identifier> (<number>)` naming an RTL line without a
SHA in its sentence.

### 8.3 `T1`'s derived constant {3 … 10} against SPEC-M03 §6.1's worked table — **AGREES**

§6.1's worked table (`docs/specs/modules/xgmii_rx_64.md` 658–674), a 64-octet frame
at a lane-0 start, cycle 0 being the word carrying the start character:

| cycle | output |
|---|---|
| 0, 1, 2 | `tvalid` = 0 |
| **3** | **word 0**, octets 0–7, `tkeep` = 0xFF |
| **4 – 9** | **words 1–6**, octets 8–55, `tkeep` = 0xFF |
| **10** | **word 7**, octets 56–59, `tkeep` = 0x0F, `tlast` = 1 |

**Eight output words at cycles {3, 4, 5, 6, 7, 8, 9, 10} = {3 … 10}. The constant is
correct**, and it is correct **twice over**: the table row by row, and independently
§6.1's `m + 3` formula (399) evaluated at *m* = 0 … 7. Sixty delivered octets in
eight words is the same arithmetic from the other side (672–674).

**Four scope conditions the constant carries, because a derived constant of this
shape is where a bench usually goes wrong** — none of them is a defect, all are the
specification's own:

1. **It is the 64-octet case.** N changes the top of the range: the word count is
   *q* or *q + 1* for N = 8q + r (692–698), so any other length gives a different set.
2. **It is the *gapless* case, and the qualifier is load-bearing** (§6.1, 412–424,
   C-14.4). Under REQ-016 injection the set does **not** hold; §6.1's D(m) rule and
   `requirements.md` §0.5 govern there, and §7's per-octet constant is **withdrawn**
   at both start lanes (856–862). A bench asserting {3 … 10} on an injected run
   fails a conformant design.
3. **Cycle 0 is the word carrying the start character**, not the run's cycle 0
   (659–660). Expressed in run-absolute cycles the set is correct only where the
   start word is run cycle 0.
4. **It holds at both start lanes in absolute cycle** *at this module* (676–683) —
   but §6.1 says in terms that this is *"a property of the constants §7 pins, not an
   obligation, and a bench SHALL NOT assert it as one for other modules"*.

**Limit**: I checked the constant **against the specification**, which is what was
asked. I did **not** read `T1` — `test/**` is barred — so I confirm the *value and
its conditions*, not that `T1` derives it the way the table does or applies it inside
its scope. If `T1` asserts the set on an injected run, or in run-absolute cycles with
a start word elsewhere, condition 2 or 3 convicts it; that check needs one line of
`test/**` and is the carrier round's.

---

## 9. Pre-run reading note — questions for dv_lead, **before** the run

Per the packet's carried `WO-0063B` precedent and §7.3 item 7: *if the manifest
raises a question, it comes before the run, as a committed reading note*. **All four
are answerable from the packet and the specification alone and none needs a
scorecard.** Every diff is delivered regardless; none of these blocks the round.

**RN-1 — IC-J1's *every strobe* must-be-identical cell, read unscoped, cannot be
satisfied by any rendering of IC-J1's own class.** §6's table gives IC-J1 *permitted:
the delivered stream of frames the specification requires refused* and *must be
identical: … every strobe*. But a design with **no admission gate** necessarily lets
an admitted frame raise whatever report **that frame** owes — through 588/589 for an
epoch closed inside its own word, and through the closure record otherwise. A
rendering that admitted frames while suppressing their reports would be **two**
defects, not IC-J1. **My reading, offered for confirmation**: the cell is scoped the
way REQ-810's three prohibitions were scoped on 2026-08-03 (`requirements.md` §13,
ADR-0014) — to *the frames the disable refuses* against *the frames it admits* — so
IC-J1 may move the delivered stream **and the strobe set** of a frame the
specification requires refused, and may move nothing belonging to a frame the
specification requires delivered. **What it costs either way**: nothing at the three
family-J rows, whose refused frames are clean 64-octet good-FCS frames owing no
strobe under any rendering; possibly something at `M03-N4`, whose reds are blast
radius in every class of this campaign (§11) and qualify nothing. **If the unscoped
reading is affirmed, IC-J1 is unrenderable and the cell is the defect** — the
unpassable-assertion family, one campaign over.

**RN-2 — for IC-J3, is *"a frame in flight across a 1 → 0 change"* read input-side or
output-side?** §4.3 and §6.1 use *in flight* for the frame between admission and
closure. An emission gate keys on the **cycle a word leaves**, so it also mutes the
`tlast` word of a frame whose closure preceded the change but whose last word is
still in the two-cycle drain window (§6.1's ΔC − 1 = 2). **My reading**: for this
class *in flight* must be read output-side — words still resident in the pipeline —
because a gate that could tell the two apart would have to know the enable value at
admission, which is the **conformant** design. **Cost**: nil unless a carrier's
schedule puts a drain word inside a disabled window, which I cannot check.

**RN-3 — the packet's §5 expected shape does not survive D-J3a's `add` branch, and
the packet permits both.** §5 says *"IC-J1 and IC-J3 will both touch the admission
gate (one removes it, one moves it)"*. Choosing `add` (forced, §2.3) means **IC-J3
touches admission not at all**, and the shared admission site is **IC-J1 and IC-J4**
instead. Nothing about the gate inventory is thereby hidden — §3.4 tabulates the
actual pairing before delivery — but if the seal's collision inventory was derived
against the expected pairing, **this is the sentence to check it against**, and
checking it now is cheaper than reading it off a scorecard.

**RN-4 — the packet's allowlist item 4 cites a path that does not exist.** §7 admits
`docs/adr/ADR-0014.md`; the file is
`docs/adr/ADR-0014-an-enable-gates-admission-not-the-wire.md`. Clerical, and it cost
this round nothing (§0: I did not read the ADR under either name), but an allowlist
is a normative instrument and a broken path in one is worth one line in the carrier
round.

---

## 10. What this manifest does not carry, and why

1. **No scorecard, no CI run id, no control-run conclusion, no `cosim` conclusion.**
   Those are the run half's (packet §15 items 4–7). **CI is the authority**
   (ADR-0005): *"passes locally"* is not admissible from me either, and in this
   environment it is not even available — see item 3.
2. **No branch, no commit, no push.** `FINDING WO-0074-A1` is carried into the
   packet's own §7.1 and ruled ACCEPTED, so this is the terms of the round and not a
   refusal inside it. PROTOCOL §2 (sole operator of git), §6/R7 (`libs/**` outside my
   scope) and §10 (the orchestrator applies manifests transiently) all point the same
   way. **The only files this round asks the orchestrator to commit are this manifest
   and my journal entry**, both inside `docs/reports/audit/**` and my own journal.
3. **No elaboration and no simulation.** There is no `dune` and no compiler library
   in this environment, so no mutant can be built here. What I **did** run, and it is
   the strongest local check available: **each mutant file was parsed** with
   `ocamlc -stop-after parsing` (4.14.1) and **each parse tree was printed back**
   with `-dsource` to verify operator grouping, because in OCaml `|:` and `&:` share
   one left-associative precedence level and an unparenthesised mix would silently
   mean something else. All five parse; all five group as written (§11). **A parse
   check is not a type check**: a width or label error would still surface first in
   CI's `build` job, which is the authority.
4. **No prediction of which cells go red.** The seal holds those and I have not read
   it. §7's rules state mechanisms and directions; where a quantity is bench-derived
   it is named as a direction, never as a number.
5. **No AP edit, no `SO-` input, no attack-plan text.** `test/**` is barred and the
   packet's §13 names the carriers.
6. **No lessons harvest.** My charter fixes harvests at every `SO-` and every phase
   gate; this round is neither. **The open span is `J-auditor-0015` … (open)** —
   declared so a skipped harvest stays visible as a gap rather than becoming one.

---

## 11. Operator instructions — the five branches, ready to cut

Verified at `8346a5c` with a clean tree. Each patch applies **alone**, touches **one
file**, parses, and reverts clean:

```
IC-J1  anchors=1 line=421  apply-check=OK applied=[M libs/hardcaml_ethernet/src/xgmii_rx_64.ml] revert=OK clean-after=yes parse=OK
IC-J2  anchors=1 line=1003 apply-check=OK applied=[M libs/hardcaml_ethernet/src/xgmii_rx_64.ml] revert=OK clean-after=yes parse=OK
IC-J3  anchors=1 line=976  apply-check=OK applied=[M libs/hardcaml_ethernet/src/xgmii_rx_64.ml] revert=OK clean-after=yes parse=OK
IC-J4  anchors=1 line=421  apply-check=OK applied=[M libs/hardcaml_ethernet/src/xgmii_rx_64.ml] revert=OK clean-after=yes parse=OK
IC-J5  anchors=1 line=975  apply-check=OK applied=[M libs/hardcaml_ethernet/src/xgmii_rx_64.ml] revert=OK clean-after=yes parse=OK
$ git rev-parse HEAD          -> 8346a5ca11883381ea738cf1efa5f0dcd67d6907   (unmoved)
$ git status --porcelain | wc -l -> 0
```

**The mechanical table.** Every edit's old text occurs **exactly once** in the file,
so each branch is reproducible by a single substitution rather than from a patch
blob. Old text is quoted **with its leading two spaces**; `→` separates old from new.

| # | branch | file line(s) | replace this exact text | with this exact text |
|---|---|---|---|---|
| 1 | `mut/wo-0076-j1` | 421–422 | `  let b_exists = bit lanes.is_start 0 &: i.cfg_rx_enable &: ~:(i.clear) in`<br>`  let c_exists = bit lanes.is_start 4 &: i.cfg_rx_enable &: ~:(i.clear) in` | `  let b_exists = bit lanes.is_start 0 &: ~:(i.clear) in`<br>`  let c_exists = bit lanes.is_start 4 &: ~:(i.clear) in` |
| 2 | `mut/wo-0076-j2` | 1003 | `  ; error_oversize = strobe sel_oversize` | `  ; error_oversize =`<br>`      strobe sel_oversize`<br>`      \|: ((bit lanes.is_start 0 \|: bit lanes.is_start 4)`<br>`          &: ~:(i.cfg_rx_enable)`<br>`          &: ~:(i.clear))` |
| 3 | `mut/wo-0076-j3` | 976 | `  let tvalid = (emit_full \|: emit_tlast) &: ~:(i.clear) in` | `  let tvalid = (emit_full \|: emit_tlast) &: ~:(i.clear) &: i.cfg_rx_enable in` |
| 4 | `mut/wo-0076-j4` | 421–422 | *(the same two lines as branch 1)* | `  let not_en = ~:(i.cfg_rx_enable) in`<br>`  let not_en_d = reg spec not_en in`<br>`  let settling = not_en_d \|: reg spec not_en_d in`<br>`  let b_exists = bit lanes.is_start 0 &: i.cfg_rx_enable &: ~:settling &: ~:(i.clear) in`<br>`  let c_exists = bit lanes.is_start 4 &: i.cfg_rx_enable &: ~:settling &: ~:(i.clear) in` |
| 5 | `mut/wo-0076-j5` | 975 | `  let abort = sel_bad_fcs \|: sel_error \|: sel_start \|: sel_oversize \|: sel_runt in` | `  let touched =`<br>`    reg_fb spec ~width:1 ~f:(fun d ->`<br>`      mux2 begins gnd (d \|: (a_open &: ~:(i.cfg_rx_enable))))`<br>`  in`<br>`  let abort =`<br>`    sel_bad_fcs \|: sel_error \|: sel_start \|: sel_oversize \|: sel_runt \|: touched`<br>`  in` |

*(In the table above `\|` is markdown's escape for a literal `|`; the file text is
`|:` and `|` throughout. §2's diff blocks carry the unescaped, authoritative text —
where the table and §2 disagree, **§2 governs**.)*

**Branches 1 and 4 replace the same two lines.** That is the shared admission site
§3.4 tabulates, and `WO-0073-VERDICT` §7 Q4 governs: **a shared site is not a
combined diff.** They are two branches and **cannot** be combined — a combined diff
would make both unscoreable and is not textually expressible as one hunk.

**Delivery order is §10 item 2's and is fixed**: j1, j2, j3, j4, j5 — one branch
each, cut from `8346a5c`, **one commit each**, message
`MUTATION RUN IC-J<N> -- never merge`, one CI `build` run each, and the branch name
plus run id reported per §15 item 6. **`journal-check` is expected red on every one
of them** (a mutation commit stages a work product with no journal append — R2 by
construction); **the `build` job's conclusion is the campaign's evidence and the only
job that is**, with `cosim`'s conclusion reported but explicitly not evidence
(packet §4 item 5). **None of these branches may ever be merged.**

---

## 12. Summary

| class | seeded | site | one-line intent | disclosures |
|---|---|---|---|---|
| **IC-J1** | ✅ `mut/wo-0076-j1` | 421–422 | the admission gate deleted: the enable is read nowhere in the design | D-J1a **both gates, all four `to_preamble` arms + reloads + in-word `~exists`**; D-J1b **`x &: 1 ≡ x`** |
| **IC-J2** | ✅ `mut/wo-0076-j2` | 1003 | a refused frame draws a report: `error_oversize` on its own start cycle | D-J2a **`error_oversize`, the refused start character's own cycle**; D-J2b **one pulse per refused frame** |
| **IC-J3** | ✅ `mut/wo-0076-j3` | 976 | the enable gates emission continuously: no word leaves while it is 0 | D-J3a **add** (admission retained); D-J3b **strobes stay live** |
| **IC-J4** | ✅ `mut/wo-0076-j4` | 421–422 | the re-enable needs two cycles of settling, so the frame one cycle out is refused | D-J4a **(S), depth 2**; D-J4b **asymmetric, rising only** |
| **IC-J5** | ✅ `mut/wo-0076-j5` | 975 | the in-flight frame completes but is marked: `tuser`[0] = 1 on its `tlast` | D-J5a **`tuser`[0] only — `abort` has exactly one reader** |

**Five classes, five diffs, five seeded — none NOT SEEDED**, including the one the
packet expected to come back declared. **Nine disclosures answered, §6's check
positive for all five in its positive form with the `Enable.high` column discharged
structurally for each, R-DISC-2's three-path inventory tabulated with its cross-class
facts before delivery, R-DISC-1 discharged per class per lane at the firing cycle
with the three cycle facts explicit, and four questions raised as a pre-run reading
note.** **No branch cut — the operator cuts them, per §7.1.**
