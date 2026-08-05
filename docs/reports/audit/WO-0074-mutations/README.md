# WO-0074 — family-M mutation manifest: eight strobe-set classes, seven seeded, one declared unrenderable at this design

- **Author**: auditor (`J-auditor-0016`), spawn short-id `WO-0074-SEED/2026-08-10T01:40Z`
- **Commission**: `agents/handoffs/WO-0074_family-m-mutation-campaign.md`
- **Base SHA applied to**: `ca1bb80a80d1b7a3f4f705fe4c056e97227c2b5b` (§7 item 6)
- **State**: **manifest delivered; the seven transient branches are NOT cut** — see
  **FINDING WO-0074-A1** (§2), which is a finding against the commission's own
  mechanics and not against the packet. Every diff below is verified to apply alone
  at the base SHA and to revert clean; the operator commands are in §11.
- **This manifest is the seeding half only.** It carries no scorecard, no CI run id,
  no control-run conclusion and no `cosim` conclusion; those are the run half's
  (§15 items 4–7) and CI is the authority (ADR-0005, packet §12(c)).

---

## 0. Blinding — stated affirmatively

**What I read, and nothing else, for this campaign.**

| # | path | extent |
|---|---|---|
| 1 | `agents/charters/auditor.md`, `agents/PROTOCOL.md` | in full — my mandatory first actions, which precede the packet's allowlist |
| 2 | `agents/handoffs/WO-0074_family-m-mutation-campaign.md` | in full |
| 3 | `libs/hardcaml_ethernet/src/xgmii_rx_64.ml` | all 1011 lines, at the base SHA |
| 4 | `libs/hardcaml_ethernet/src/xgmii_rx_64.mli` | all 45 lines, at the base SHA |
| 5 | `docs/specs/modules/xgmii_rx_64.md` | §6.1 (lines 261–380, 618–713), §6.2 (714–728), §6.3 (729–801), §7 (803–813), §9 (929–1175); section-heading index of the whole file |
| 6 | `docs/specs/requirements.md` | §0.6 (394–464); rows REQ-102, REQ-103, REQ-104, REQ-105, REQ-107, REQ-108, REQ-110, REQ-007, REQ-008, REQ-013, REQ-015, REQ-018, REQ-301, REQ-304, REQ-810, REQ-901 |
| 7 | `agents/journals/claude_auditor_agent.md` | my own journal only — the tail, to derive the next entry id and the prior campaign's form |

**Not read, absolutely.** The sealed companion
`WO-0074_family-m-mutation-campaign-SEALED-predictions.md` — not opened, not
grepped, not `git show`n, no excerpt, no line count. **All of `test/**`**:
`test/xgmii_rx_64/test_m03_b.ml`, `test_m03_e.ml`, `test_m03_f.ml`, `test_m03_g.ml`,
`test_m03_h.ml` and every other unit file, `bench.ml`/`bench.mli`, `test/xgmii/`,
`test/monitors/`, `test/golden/`, `test/cosim/`, and
`test/attack_plans/AP-xgmii_rx_64.md` **by name**. **All of `agents/**`** bar the
packet and my two charter documents, including every journal but my own. Also not
read: `docs/adr/`, `docs/gates/`, `tasks/`, `tools/`, `.github/`, `scripts/`, and
every `docs/specs/` file other than the two named.

**Three exposures outside the allowlist, disclosed because a blinding statement
that omits its own leaks is worthless.**

1. `.gitignore` (contents) and `ls` of `dune-project`, `libs/hardcaml_ethernet/src/dune`,
   `~/.opam/fpga/{bin,lib}` — toolchain and tree-hygiene checks, carrying no
   campaign content. The result is recorded in §10: **the `fpga` switch contains
   `dune` and no compiler libraries, so no mutant can be elaborated locally.**
2. `git show --stat --name-only ca1bb80` — **file names only, never content**. It
   returned three paths (the packet, the seal, dv_lead's journal) and, unavoidably,
   the commit's **subject line**: *"The eighth campaign sealed: eight
   datapath-silent classes, seven load-bearing greens, and the by-construction
   claim convicted by its own family"*. I did not seek it and I did not act on it.
   Two of its three clauses restate the packet (§0's datapath-silence, §11's
   `FINDING M-3`). The third — *"seven load-bearing greens"* — is a count I
   cannot map onto any cell, and it did not enter any rendering. **The IC-M5
   derivation in §3.5 was complete before this command was run**, which is checkable
   against my journal's Actions ordering.
3. `git log --oneline -1 -- libs/hardcaml_ethernet/src/xgmii_rx_64.ml`, returning
   `b848d56 BUG-0003 fixed: …` — the mutation target's own last-touching commit
   subject, read to confirm the file I read is the file at the base SHA.

**Nothing in `test/**` was read, listed, counted or inferred from.** Where this
manifest needs a fact about a carrier's stimulus it says so and states a **rule in
stimulus terms** instead (packet §3.3); no diff below was chosen against a written
expectation.

---

## 1. The base SHA, and §8's own rule discharged

§7 item 6 requires the base SHA quoted and confirmed against §8's. §8 fixes it as
*"the commit that stages this packet and its seal. Not its parent."*

```
$ git rev-parse HEAD
ca1bb80a80d1b7a3f4f705fe4c056e97227c2b5b
$ git show --stat --name-only ca1bb80        (names only — the seal was not opened)
agents/handoffs/WO-0074_family-m-mutation-campaign-SEALED-predictions.md
agents/handoffs/WO-0074_family-m-mutation-campaign.md
agents/journals/claude_dv_lead_agent.v05.md
$ git rev-parse ca1bb80^
2761ec5af245379a931a299a80229a288d9bbd8d
```

`ca1bb80` stages this packet **and** its seal in one commit. **§8's rule and the
operating base agree, and there is nothing to file.** This is the first
application of the corrective drafting rule adopted at `WO-0073-VERDICT` §7 after
`FINDING WO-0073-M1` — which I filed against §8's previous form — and it works:
last round the literal base (`8acd28d`) and the operating base (`bbd4122`) were
different commits and cost a MINOR finding; this round they are one commit.
**R-SEAL-1 is satisfied on its face**: the seal is a file in the packet's own
commit, so its `Files-in-this-commit` list contains it, and no diff existed when it
was frozen.

The mutation target has not moved since `b848d56` (BUG-0003's repair), which is an
ancestor of the base. All eight classes, the control run and every
MUST-STAY-GREEN sweep are against this one SHA (`BUG-0003` §V.9).

---

## 2. FINDING WO-0074-A1 (MAJOR) — the branches are not cut, and why

**Subject: the commission's mechanics, not the packet.** My spawn instructs me to
cut, commit and push seven `mut/wo-0074-m<N>` branches carrying mutated RTL. Three
committed instruments forbid it and none of them carries an exception I can find
from inside this campaign's allowlist:

- **PROTOCOL §2**: *"the orchestrator is the sole spawner … and the sole operator
  of git. No other agent ever runs `git commit` or `git push`."*
- **PROTOCOL §6 / R7**: the auditor may stage `docs/reports/audit/**` **only**. A
  commit whose diff is `libs/hardcaml_ethernet/src/xgmii_rx_64.ml` under my
  identity is a path-isolation violation by construction, and it additionally
  fails R2 (no journal append), R4 and R6 (no trailers).
- **PROTOCOL §10's transient model**, restated in my charter §3: *"the
  **orchestrator** applies each manifest transiently in an uncommitted working
  tree … and never lets mutated RTL enter history."* The packet's own header
  agrees — *"The orchestrator issues it, **operates it** (PROTOCOL §10's transient
  model)"*.

**This is not new, and that is the finding.** My own committed journal records the
same instruction being followed at the previous campaign:
`agents/journals/claude_auditor_agent.md` lines 3458–3464 (`J-auditor-0015`,
Actions) — *"Cut, committed (plain `git commit`, never `agent_commit`) and pushed
five transient branches"* — and the same at `J-auditor-0014` for `WO-0066`. So the
practice is **established, journaled and never authorised**: PROTOCOL §11 requires
an ADR for any change to the protocol or a charter, and no ADR authorising
auditor-operated transient branches is cited in PROTOCOL §2, §6, §10, my charter,
or this packet. I **cannot check `docs/adr/` without breaking this campaign's
blinding**, so the finding is stated in the falsifiable form: *if such an ADR
exists, cite its number and this finding closes in one line; if it does not, three
campaigns have run on an unamended exception and one is owed.*

**What I did instead, and why the round is not blocked.** Deciding this myself in
favour of acting is irreversible — `J-auditor-0015` lines 3461–3464 record that
R9's no-force-push guarantee holds on transient refs too, so a wrong push cannot
be withdrawn by me. Deciding it in favour of *not* acting costs the orchestrator
seven `git` commands, which §11 supplies verbatim. The asymmetry is not close.
Every diff below is byte-exact, `git apply --check`-verified at the base SHA and
round-trip reverted, so the operator step is mechanical.

**Severity MAJOR, not CRITICAL**: nothing false has been claimed and no gate is
blocked by it; what is missing is an authorising instrument for a practice three
campaigns deep. It is filed **before the first branch exists**, which is the
window §8 says a disagreement belongs in.

---

## 3. The eight classes — seven diffs, one derivation

Every diff below touches `libs/hardcaml_ethernet/src/xgmii_rx_64.ml` and nothing
else, applies **alone** at `ca1bb80`, and reverts clean. Delivery order is §10
item 2's, fixed: **IC-M1, IC-M2, IC-M3, IC-M4, IC-M5, IC-M6, IC-M7, IC-M10.**

### 3.1 IC-M1 — a precedence design at a runt with a wrong FCS (ruling 1)

```diff
--- a/libs/hardcaml_ethernet/src/xgmii_rx_64.ml
+++ b/libs/hardcaml_ethernet/src/xgmii_rx_64.ml
@@ -997,7 +997,7 @@
       ; tlast = emit_tlast &: ~:(i.clear)
       ; tuser = emit_tlast &: abort
       }
-  ; error_bad_fcs = strobe sel_bad_fcs
+  ; error_bad_fcs = strobe (sel_bad_fcs &: ~:sel_runt)
   ; error_bad_frame = strobe sel_error |: q_strobe 0
   ; error_runt = strobe sel_runt |: q_strobe 1
   ; error_oversize = strobe sel_oversize
```

The precedence is rendered **at the strobe port**, which is the narrowest site the
class has: `error_bad_fcs` (1000) is read by nothing in this module, so the
rendering is datapath-silent by *reachability* rather than by argument. Where a
frame is both a runt and wrong in its FCS, one strobe pulses where §9's first
ruling requires two; the surviving one is `error_runt`.

**Rejected**: gating the record bit at 513 with `~:a_close_runt`. It computes the
same observable but routes the suppression through `sel_bad_fcs` → `abort` (975)
→ `tuser` (998), and although `sel_runt` keeps `abort` high on exactly the frames
concerned, the class would then rest on that coincidence instead of on
reachability. §6's check is stronger when it needs no argument.

### 3.2 IC-M2 — the residue comparison runs at REQ-108's truncation point (ruling 2)

```diff
@@ -510,7 +510,7 @@
       ~error:a_close_error
       ~start:a_close_start
       ~oversize:a_close_oversize
-      ~fcs:(a_close_terminate &: bad_fcs)
+      ~fcs:((a_close_terminate |: a_close_oversize) &: bad_fcs)
       ~runt:a_close_runt
   in
```

### 3.3 IC-M3 — the residue comparison runs at an error-character closure (ruling 3)

```diff
@@ -510,7 +510,7 @@
-      ~fcs:(a_close_terminate &: bad_fcs)
+      ~fcs:((a_close_terminate |: a_close_error) &: bad_fcs)
```

### 3.4 IC-M4 — the residue comparison runs at a start-character closure (ruling 4)

```diff
@@ -510,7 +510,7 @@
-      ~fcs:(a_close_terminate &: bad_fcs)
+      ~fcs:((a_close_terminate |: a_close_start) &: bad_fcs)
```

**IC-M2, IC-M3 and IC-M4 replace the same line (513).** That is the shared
FCS-report enable §5 predicted, and `WO-0073-VERDICT` §7 Q4 governs: a shared site
is not a combined diff. They are three separate branches and **cannot** be
combined — a combined diff would make all three unscoreable and, because they
share a line, is not even textually expressible as one hunk of this shape.

**All three retain `has_fcs` (470).** The sub-five-octet suppression is ruling 9's
subject and is IC-M10's class; leaving it in place is what keeps IC-M2/M3/M4
independent of IC-M10 rather than each being two classes at once.

### 3.5 IC-M5 — **NOT SEEDED**, self-declared under D-M5a, with the shared term quoted

**D-M5a's own test is met: one signal serves both paths, and it is `a_open`.**

```ocaml
296:  let a_open = in_preamble |: in_frame in
```

`a_open` is read at exactly three sites (`grep -n '\ba_open\b'`, comments excluded):

| site | line | which path |
|---|---|---|
| `a_close_oversize` | 362 | report |
| `a_char_acts` → `a_closes_with` → `a_close_terminate` / `a_close_error` / `a_close_start` | 364, 365, 366, 372, 375 | **report** — this is the REQ-110 abort detector's open-frame term |
| `bubble` | 732 | **delivery** — the alignment window's advance and mask |

and `a_open` is itself the FSM state (`in_preamble` 260, `in_frame` 261), which
also fixes `cov_first` (297–302) — the delivered extent — and `a_pre_mask` (308).
**There is no separate report-path open-frame term in this design to leave
uncleared.** The class is defined as *"the REQ-110 abort detector's open-frame
term is not cleared by an error character"*; that term does not exist apart from
the delivery path's.

**Two candidate renderings were attempted and both move the datapath. Both are
recorded so the declaration is falsifiable rather than asserted.**

1. **Drop `a_close_error` from `a_close_char` (376) so the FSM does not leave
   `Frame` on an `/E/`.** `a_close_char` feeds `a_close_now` (377) which feeds
   `r0`'s `~valid` (508). Removing the error arm therefore never births the
   closure record: `error_bad_frame` stops pulsing, `closed` (956) is never
   raised for that frame, and its last word is never released — `emit_full` (962)
   needs `ev12`, which is 0 once the frame's octets stop. The word is stranded.
   Datapath-visible, and not the class in either direction.
2. **Keep `a_close_now` intact and remove the error arm only from the FSM's
   `Frame`/`Preamble` transitions (622, 632), so `a_open` stays high.** This
   renders the report, but `bubble` (732) is `off4 &: a_open &: ~:cov_nonempty &:
   ~:a_close_now`. At **offset 4**, on the first idle word after the `/E/` word,
   base has `a_open` = 0 so `bubble` = 0 and the window advances, giving
   `al_keep = {cov[3:0], cov_d[7:4]}` = the aborted frame's remaining upper-half
   octets; the mutant has `a_open` = 1, `cov_nonempty` = 0, `a_close_now` = 0, so
   `bubble` = 1 and `al_keep` is forced to zero (741). **The aborted frame's final
   half word is lost.** That is the `BUG-0003` signature's own component — octets
   never delivered — and §6's consequence governs: reported, not scored.

**A third rendering — adding a new report-only open-frame register that this
design does not contain — was rejected for two reasons, and the second is the
load-bearing one.** First, it is not a modification of the abort detector's term
but the construction of a term the design has none of, which is a different design
rather than a mutant of this one. Second, such a register necessarily births a
spurious `r0` (508) whose `sel_valid` reaches `strip` (800), `closed` (956),
`decided` (958), `emit_last_a` (959), `emit_full` (962), `hold` (971) and
`consume` (977); §6 item 1 obliges me to confirm **positively** that the delivered
stream at the class's own carrier is identical, and **I cannot see that carrier**
(the packet's allowlist bars it) nor elaborate the mutant (§10). Shipping a class
whose datapath-silence I can only argue and not confirm is precisely what §6 exists
to refuse.

**Disposition claimed**: §8.1 IC-M5 rule 3 — the class is void, `M03-M5` is
recorded **SCORED AND UNQUALIFIABLE at this design**, zero kills, no claim about
the row in either direction. **The claim is stated in its narrow form and not its
wide one**: what is established is that *ruling 5 has no datapath-silent mutant
reachable by modifying this design's existing terms, because it has exactly one
open-frame term and that term bounds the delivered extent.* It is **not**
established that no conceivable implementation of ruling 5's defect is
datapath-silent — a design carrying a separate `frame_active` flag for reporting
would have one, and this design does not.

**No branch is cut for IC-M5, and no CI job is spent on it.** Price: seven jobs,
not eight — §12's figures become **7 × 344 s ≈ 40.1 minutes**, saving ≈ 5.7
minutes against the packet's ≈ 45.9. Declared before any run, per the spawn's
extra-rendered-branch rule read in its subtractive direction.

### 3.6 IC-M6 — a start character arriving in `Discard` is reported as an abort (ruling 6)

```diff
@@ -372,7 +372,9 @@
   let a_close_error =
     a_closes_with (lanes.is_error |: (other_ctl &: a_pre_mask))
   in
-  let a_close_start = a_closes_with lanes.is_start in
+  let a_close_start =
+    (a_char_acts |: sm.is State.Discard) &: any (lanes.is_start &: a_close_oh)
+  in
   let a_close_char = a_close_terminate |: a_close_error |: a_close_start in
   let a_close_now = (a_close_char |: a_close_oversize) &: ~:(i.clear) in
```

Where `a_char_acts` is high the mutated expression is **identical** to
`a_closes_with lanes.is_start` (365), so the base behaviour is preserved
everywhere except in `Discard`. The added disjunct is the class and nothing else.

### 3.7 IC-M7 — an error character arriving in `Discard` is reported (ruling 7, C-12)

```diff
@@ -370,7 +370,8 @@
   let a_close_error =
-    a_closes_with (lanes.is_error |: (other_ctl &: a_pre_mask))
+    (a_char_acts |: sm.is State.Discard)
+    &: any ((lanes.is_error |: (other_ctl &: a_pre_mask)) &: a_close_oh)
   in
   let a_close_start = a_closes_with lanes.is_start in
```

In `Discard`, `a_pre_mask` (308) is `repeat (in_preamble &: frame_start4) 8 &: 0x0f`
= 0, so the added disjunct reduces to `is_error &: a_close_oh` — **keyed on the
error character alone**, which is what D-M7a's first reading requires.

**IC-M6 and IC-M7 are adjacent in the file (372–378) and each applies alone**;
they are separate branches and must never be combined, because a combined diff
would redden both epochs of both rows through one conviction and destroy the
`FINDING M-1` / `FINDING M-2` measurement §8.1 prices.

### 3.8 IC-M10 — the residue comparison runs at every terminate character (ruling 9)

```diff
@@ -133,7 +133,7 @@
    check, which is the site an implementation codes and is where the gate
    below sits. *)
 let runt_threshold = 64
-let fcs_min_octets = 5
+let fcs_min_octets = 0
```

`fcs_min_octets` (136) is read at exactly one non-comment site — `has_fcs` (470)
— so setting it to 0 makes `has_fcs` identically 1 on an 11-bit unsigned count and
removes the sub-five suppression **without editing the comparison's own
expression**. That is the minimal rendering of *"at a terminate closure it always
compares, whatever the received count"*, and it is a constant corruption rather
than a structural edit, which keeps it visibly disjoint from IC-M2/M3/M4's site.

**Rejected**: `let has_fcs = vdd in` at 470. It renders the same class but leaves
`fcs_min_octets` (136) unreferenced, which is an unused-value declaration in a
module whose `.mli` does not export it — a **build** failure, and a branch red at
build scores nothing.

---

## 4. R-DISC-2 — the gate inventory, **inverted** for this campaign

**Stated explicitly, as §5 requires: every class in this campaign names the report
path, and NO class names the datapath.** This is the exact inverse of `WO-0073`'s
inventory, where every class named the datapath.

### 4.1 The report path — named by all seven seeded classes

Full term list, in evaluation order, with each class's claim about it.

| # | term | line | IC-M1 | IC-M2 | IC-M3 | IC-M4 | IC-M6 | IC-M7 | IC-M10 |
|---|---|---|---|---|---|---|---|---|---|
| R1 | `a_closing_v` / `a_close_oh` / `a_char_end` | 313, 315, 316 | reads | reads | reads | reads | **reads** | **reads** | reads |
| R2 | `a_open` | 296 | reads | reads | reads | reads | reads | reads | reads |
| R3 | `a_char_acts` | 364 | — | — | — | — | **widened (∨ `Discard`)** | **widened (∨ `Discard`)** | — |
| R4 | `a_closes_with` | 365 | — | — | — | — | bypassed for the start arm | bypassed for the error arm | — |
| R5 | `a_close_terminate` | 366 | reads | reads | reads | reads | — | — | reads |
| R6 | `a_close_error` | 372–374 | — | — | **reads** | — | — | **REPLACED** | — |
| R7 | `a_close_start` | 375 | — | — | — | **reads** | **REPLACED** | — | — |
| R8 | `a_close_oversize` | 361–363 | — | **reads** | — | — | — | — | — |
| R9 | `a_close_runt` / `runt_threshold` | 502, 135 | reads (via `sel_runt`) | — | — | — | — | — | co-fires |
| R10 | `fcs_min_octets` | 136 | — | — | — | — | — | — | **REPLACED** |
| R11 | `has_fcs` | 470 | — | reads | reads | reads | — | — | **changed via R10** |
| R12 | `bad_fcs` / `fcs_residue` / `crc_final` | 471, 154, 451 | reads | reads | reads | reads | — | — | reads |
| R13 | `r0` field `~fcs` | 513 | — | **REPLACED** | **REPLACED** | **REPLACED** | — | — | changed via R11 |
| R14 | `r0` fields `~valid` `~start` `~error` | 508, 511, 510 | — | — | — | — | **set spuriously** | **set spuriously** | — |
| R15 | `r1` / `r2` ageing, `sel*` | 526–534 | reads | reads | reads | reads | reads | reads | reads |
| R16 | `consume` | 977 | reads | reads | reads | reads | reads | reads | reads |
| R17 | `strobe` / `q_strobe` | 990, 991 | reads | reads | reads | reads | reads | reads | reads |
| R18 | `inword_strobes` / `q2` (epoch B/C path) | 571–590 | untouched | untouched | untouched | untouched | untouched | untouched | **structurally out of reach — see §5.7** |
| R19 | the five `error_*` ports | 1000–1004 | **REPLACED** (`error_bad_fcs`) | changed via R13 | changed via R13 | changed via R13 | changed via R14 | changed via R14 | changed via R13 |

### 4.2 The datapath — as a **negative**, named by no class

**Output-word emission gates.** `cov_first` (297), `cov_end` (353), `cov` (382),
`cov_count` (383), `first_v` (390), `count` / `count_next` (341, 398), `bubble`
(732), `window_advance` (733), `data_d` / `cov_d` / `first_d` (734–736), `al_data`
(740), `al_keep` (741), `al_new` (745), `hold` (779, 971), `al_data_d` /
`al_keep_d` (781, 782), `pc` (795), `nc` (799), `strip` (800), `have_word` (831),
`fcs_tail_pending` / `fcs_tail_now` (829, 830), `ev12` (955), `closed` (956),
`closure_aligned` (957), `decided` (958), `emit_last_a` (959), `emit_last_b`
(960), `emit_full` (962), `emit_tlast` (963), `keep_count` (972), `abort` (975),
`tvalid` (976), and the six `rx` fields (992–999).

**Frame-acceptance gates.** `b_exists` / `c_exists` (421, 422), `b_closing` /
`c_closing` (423, 424), `survivor_b` / `survivor_c` (428, 429), `begins` (430),
`new_start4` (431), `frame_start4` (432), `start4_pending` (663), `off4`
(664–667), and the `Always` switch (611–647).

**No class edits any term in either list.** Two classes *perturb* two of them and
both perturbations are discharged to identity in §5.6 and §5.7: `bubble` (732),
because it conjoins `a_open` which is 0 in `Discard`; and the `Always` switch,
because its `Discard` row (635–645) reads only `to_preamble` and `have_terminate`
and never `a_close_char`. A term touched in the emission or acceptance path is a
term outside every class here and is the fastest route to a red that scores
nothing — so this table is the statement that no such term was touched.

### 4.3 Cross-class gate facts, tabulated before delivery

| # | shared term | classes | what it costs, and why it is not a combined diff |
|---|---|---|---|
| X1 | the `~fcs:` argument, **line 513 itself** | IC-M2, IC-M3, IC-M4 | Three classes replace the **same source line** with three different expressions. `WO-0073-VERDICT` §7 Q4 governs. Not combinable even textually; **which branch was applied is the only discriminator at any cell that prints only a count** |
| X2 | the FCS-report enable **chain** `fcs_min_octets → has_fcs → bad_fcs → r0[5]` | IC-M2, IC-M3, IC-M4, **IC-M10** | §5's predicted four-class share. IC-M10 enters the chain one stage earlier (136) than the other three (513); four diffs remain mandatory |
| X3 | `sel_bad_fcs` (533) | IC-M1 (removes a pulse) **and** IC-M2/M3/M4/M10 (add one) | IC-M1 is the campaign's only **subtractive** class. If IC-M1 and IC-M10 were ever combined the two would cancel exactly at a sub-5 terminate closure — `sel_runt` is 1 there — so their separation is load-bearing, not cosmetic |
| X4 | `sel_runt` (534) | IC-M1 (its gate term) and IC-M10 (co-fires on the same frames) | Both classes live on frames with `a_close_runt` = 1, at disjoint octet counts: IC-M1 at 5…63, IC-M10 at 0…4 |
| X5 | `a_char_acts` (364) | IC-M6, IC-M7 | Both widen this one open-frame gate, each on exactly one arm. Combined, the epoch measurement §8.1 prices is destroyed |
| X6 | `sm.is State.Discard` | IC-M6, IC-M7 | **D-M6a and D-M7a have the same answer**, and that is a property of the design, not a hedge |
| X7 | `a_close_oh` (315) | IC-M6, IC-M7 | Both added disjuncts reuse the design's own lowest-closure-lane search unchanged, which is what keeps them narrow |
| X8 | `a_close_char` (376) → `a_close_now` (377) | IC-M6, IC-M7 | The single datapath **adjacency** in this campaign. Discharged identically for both in §5.6/§5.7 |
| X9 | `abort` (975) → `tuser` (998) | IC-M2, IC-M3, IC-M4, IC-M6, IC-M7, IC-M10 | Every class that **adds** a record bit reaches `tuser` through this OR. Discharged per class: either the co-condition already holds `abort` high, or no output word exists for the frame |

---

## 5. R-DISC-1 — reachability discharged term by term, per lane, per member

**Method for every subsection**: the gate signal is named, its complete defining
expression is quoted from the base file with line numbers, and every conjunct is
evaluated at the claimed firing cycle. Conjuncts contributed by the **stimulus**
are marked **[S]**; by the **mutation**, **[M]**; by the **design, unchanged**,
**[D]**.

**A standing limit of this discharge, declared once.** The packet's §7 bars all of
`test/**`, so I know the twelve carriers only by the row names in §0's Bench basis
and cannot see one stimulus. **Every "per member" discharge below is therefore
taken over the design's own parameter space** — start lane, closure lane, received
octet count, closure kind — and not over a carrier's member list. Where a carrier
iterates a parameter I have not named, the class's **rule** (§8) governs, per
§3.3's blast-radius discipline: *a red selected by the rule is predicted radius; a
red outside the rule is a finding.* Every class below is discharged at **both**
start lanes.

### 5.1 IC-M1

**Gate**: `error_bad_fcs`, line 1000, mutated to `strobe (sel_bad_fcs &: ~:sel_runt)`.
Expanded through `strobe` (990):
`consume &: sel_bad_fcs &: ~:sel_runt &: ~:(i.clear)`.

Feeding chain: `sel_bad_fcs = bit sel 5` (533); `sel_runt = bit sel 6` (534);
`sel = mux2 sel_is_r2 r2 (mux2 sel_is_r1 r1 r0)` (525); record bit 5 =
`a_close_terminate &: bad_fcs` (513); bit 6 = `a_close_runt` (502) =
`a_close_terminate &: (count_next <:. runt_threshold)`, `runt_threshold` = 64
(135); `bad_fcs = has_fcs &: (crc_final <>: of_int ~width:32 fcs_residue)` (471);
`has_fcs = count_next >=:. fcs_min_octets` (470), `fcs_min_octets` = 5 (136);
`a_close_terminate = a_closes_with lanes.is_terminate` (366) =
`a_char_acts &: any (lanes.is_terminate &: a_close_oh)` (365);
`a_char_acts = a_open &: ~:a_close_oversize` (364).

At the closure cycle **C** of a frame closed by `/T/` with 5 ≤ received octets ≤ 63
and a mismatching FCS:

| conjunct | value | source |
|---|---|---|
| `a_open` (296) | 1 — the frame is open, state `Frame` | **[S]** |
| `a_close_oversize` (361–363) | 0 — `count_next` ≤ 63 < 1518, so `cap_end` = 8 and `cap_end <: a_char_end` is false | **[S]** |
| `any (lanes.is_terminate &: a_close_oh)` | 1 — the `/T/` is the lowest closure character in its word | **[S]** |
| `count_next >=:. 5` | 1 | **[S]** |
| `crc_final <>: 0x2144DF1C` | 1 — the injected FCS is wrong | **[S]** |
| ⇒ record bit 5 (`fcs`) | 1 | [D] |
| `count_next <:. 64` ⇒ record bit 6 (`runt`) | 1 | **[S]** |
| `consume` (977) on the frame's `tlast` cycle | 1 | **[D]** |
| `~:sel_runt` | **0** | **[M]** — the sole mutation conjunct |

⇒ `error_bad_fcs` = **0** where the base gives 1. `error_runt = strobe sel_runt |:
q_strobe 1` (1002) is untouched and = 1. **Observed set {`error_runt`}; §9's first
ruling requires {`error_runt`, `error_bad_fcs`}.**

**Per lane.** Every conjunct above is computed from `count_next`, `crc_final`,
`a_close_oh` and the FSM state, none of which is a function of the start lane;
`cov_first` differs (0 at lane 0, 4 during `Preamble` at lane 4, then 0) and **no
conjunct reads it**. The report cycle differs — `closure_aligned = closed &:
(~:sel_is_r0 |: off4)` (957) admits an age-0 record at lane 4 and requires age ≥ 1
at lane 0 — but `sel_runt` and `sel_bad_fcs` are bits of the **same** record
whichever age it is selected at. **Fires at both lanes.**

**Per member — the two required greens that separate this class from a design that
merely dislikes runts** (packet §1's own test):

- **a runt with a *correct* FCS**: `crc_final` = residue ⇒ `bad_fcs` = 0 ⇒
  `sel_bad_fcs` = 0 ⇒ `error_bad_fcs` = 0 in base **and** mutant. Identical.
- **a ≥ 64-octet frame with a wrong FCS**: `count_next <:. 64` = 0 ⇒ `sel_runt` = 0
  ⇒ `~:sel_runt` = 1 ⇒ `error_bad_fcs` = 1, as the base. Identical.

### 5.2 IC-M2

**Gate**: record bit 5, line 513, mutated to
`((a_close_terminate |: a_close_oversize) &: bad_fcs)`.
`a_close_oversize = a_open &: (cap_end <: a_char_end) &: (cap_end <: a_hold_end)
&: (cap_end <:. 8)` (361–363); `cap_room = 1518 - count` (342); `cap_end`
(343–351).

At the truncation cycle **T** of a frame exceeding 1518 received octets:

| conjunct | value | source |
|---|---|---|
| `a_open` | 1 — state `Frame` | **[S]** |
| `cap_end <:. 8` | 1 — `cap_room` < 8 on the word whose coverage would carry the count past 1518 | **[S]** |
| `cap_end <: a_char_end` | 1 — `a_char_end` = 8, no closure character in that word | **[S]** |
| `cap_end <: a_hold_end` | 1 — `a_hold_end` = 8, no other-control lane in that word | **[S]** |
| ⇒ `a_close_oversize` | 1 | [D] |
| `has_fcs` (`count_next` = 1518 ≥ 5) | 1 | **[S]** |
| `crc_final <>: 0x2144DF1C` | **the measured quantity** — see below | **[S]** |
| the `|: a_close_oversize` disjunct | — | **[M]** |

⇒ record bit 5 = 1 **beside** bit 4 (`oversize`), and `error_bad_fcs` pulses on the
cycle `error_oversize` does — both through `strobe` (990) on the same `consume`
(977). §9's second ruling admits exactly one strobe there.

**Per lane.** `cap_end` is built from `cov_first` and `cap_room`; by the truncation
point the state is `Frame` at both lanes, so `cov_first` = 0 at both and the
expression is lane-identical. The truncation **cycle** differs by one input word
between lanes (SPEC-M03 §9's own note: *s* + 191 at lane 0 against *s* + 190 for
the last delivered octet at lane 4), and no conjunct above reads the cycle number.
Delivered count is 1514 at both. **Fires at both lanes.**

**Per member — the anti-vacuity measurement, which is this class's actual point.**
`crc_final` at T is the CRC over the **1518 received octets** of that one prefix.
§8.1 rules 1–3 are pre-fixed and I add nothing: a red qualifies `M03-M2` and
answers `OBSERVATION M-O1` in the row's favour; a green with the class seeded is a
finding **against the carrier's stimulus** and is worth more than the kill. I
cannot compute the residue over a stimulus I may not read, and I do not guess: the
manifest's contribution is that the class **is** seeded and **is** reachable, which
is what makes the green interpretable at all.

### 5.3 IC-M3

**Gate**: record bit 5, mutated to `((a_close_terminate |: a_close_error) &: bad_fcs)`.
`a_close_error = a_closes_with (lanes.is_error |: (other_ctl &: a_pre_mask))`
(372–374).

At the closure cycle **C** of a frame ended by an `/E/` after ≥ 5 received octets:

| conjunct | value | source |
|---|---|---|
| `a_open` | 1 | **[S]** |
| `a_close_oversize` | 0 — count ≤ 1518 | **[S]** |
| `any ((lanes.is_error \|: (other_ctl &: a_pre_mask)) &: a_close_oh)` | 1 — the `/E/` is the lowest closure character in its word | **[S]** |
| `has_fcs`: `count_next >=:. 5` | 1 — `count_next` = octets received through the lane immediately **below** the `/E/`, since `cov_end = a_char_end` = the `/E/`'s lane index (353, 316–317) | **[S]** |
| `crc_final` = CRC over exactly those octets (447–451) `<>` residue | 1 | **[S]** |
| the `|: a_close_error` disjunct | — | **[M]** |

⇒ a second strobe beside `error_bad_frame`. §9's third ruling admits one.

**Per lane.** `a_close_oh` (315) is a search over all eight lanes and is
lane-independent; `count_next` accumulates from `cov_count` (383) whose start
differs by lane only in the frame's first two words. **Fires at both lanes.**

**Per member.** REQ-105's verification column commissions the `/E/` in each of the
eight lanes of a mid-frame word. For a mid-frame word deep in the frame,
`count_next` ≥ 5 at every one of the eight, so **all eight members fire** at both
lanes. The two members REQ-105 commissions at or before the frame's first octet
(`/E/` in a preamble position, `/E/` at the first frame octet) give `count_next`
< 5 ⇒ `has_fcs` = 0 ⇒ **no fire**, which is a **required green of this class** and
is what keeps IC-M3 disjoint from IC-M10.

### 5.4 IC-M4

**Gate**: record bit 5, mutated to `((a_close_terminate |: a_close_start) &: bad_fcs)`.
`a_close_start = a_closes_with lanes.is_start` (375).

At the closure cycle **C** of a frame aborted by a new `/S/` after ≥ 5 received
octets: identical table to §5.3 with `any (lanes.is_start &: a_close_oh)` in place
of the error term, and with the extent being the octets received **before** the new
`/S/` and **no** REQ-103 removal attempted (`strip` = 0 for a start closure, 800).

**One design fact worth naming, because it widens the class's reach and is
spec-mandated**: `a_closing_v` (313) tests `lanes.is_start` **ungated by
`cfg_rx_enable`**, which is §9's clause (b) — a new start character closes the open
frame whether or not the enable permits a new frame to begin. **So IC-M4 also fires
on a REQ-110 abort taken while `cfg_rx_enable` = 0**, and any unit driving that
stimulus is inside the rule.

**Per lane and per member.** REQ-110 commissions the `/S/` in lane 0 and in lane 4,
at both start lanes. At `/S/` in lane 4, lanes 0…3 belong to the aborted frame
(REQ-110's lane rule), so `cov_end` = 4 and `count_next` = count + 4; at `/S/` in
lane 0, `cov_end` = 0 and `count_next` = count. Both give `count_next` ≥ 5 on any
frame with ≥ 5 octets already received; **fires at both, at both start lanes.**
REQ-110's third commissioned stimulus — `/S/` in lane 4 of a word whose lane 0 was
`/S/` — is **epoch B/C** (421–430, 571–590) and has no FCS bit, so it does **not**
fire: a required green. `FINDING M-O1a` puts M4's anti-vacuity ground at one
distinct delivered content, exactly as M2's; §8.1 rules 1–3 govern both alike.

### 5.5 IC-M10

**Gate**: `has_fcs` (470), via `fcs_min_octets` (136) set to 0, so
`count_next >=:. 0` is identically 1 on an 11-bit unsigned count.

At the closure cycle **C** of a frame closed by `/T/` with 0 ≤ received octets ≤ 4:

| conjunct | value | source |
|---|---|---|
| `a_open` | 1 — state `Preamble` or `Frame` | **[S]** |
| `a_close_oversize` | 0 | **[S]** |
| `any (lanes.is_terminate &: a_close_oh)` | 1 | **[S]** |
| `count_next` ∈ [0, 4] | — | **[S]** |
| `has_fcs` | **1** where the base gives 0 | **[M]** — the sole mutation conjunct |
| `crc_final <>: 0x2144DF1C` | see the member table | **[S]** |
| `a_close_runt` (502) ⇒ `sel_runt` | 1 | **[D]** |

⇒ `error_bad_fcs` pulses beside `error_runt` on a frame §9's ninth ruling requires
to show **`error_runt` alone — an exact strobe set**. The frame still delivers **no
output word**: `emit_last_a`'s guard `pc >: strip` (959) has `pc` ≤ 4 = `strip`, so
§9's no-output-word pin (consume at age 2, 977) is unmoved.

**Per member** — `crc_final = mux2 crc_update crc_out crc_reg` (451),
`crc_update = cov_count <>:. 0` (447):

| received octets | `crc_final` | fires? |
|---|---|---|
| 0 | `cov_count` = 0 on every cycle of the frame's life ⇒ the register is never updated ⇒ **the §6.1 item 1 seed `0x00000000`**, which is not `0x2144DF1C` | **yes** |
| 1, 2, 3 | CRC over those octets | yes for every content this design can produce |
| 4, content `00 00 00 00` | exactly `0x2144DF1C` (SPEC-M03 §9's ninth ruling; `zlib.crc32(bytes(4))`) | **no** — a required green of this class |
| 4, any other content | ≠ residue | yes |

**Per lane, and the one structural scope limit this class has — declared before the
run.** The class reaches **epoch-A closures only**. Sub-five frames opened *and*
closed inside one input word are reported by `inword_strobes` (571–582), whose
vector is **three bits and carries no `error_bad_fcs` at all** (the comment at
544–554 removes it rather than driving it low), so IC-M10 **cannot** fire there.
Concretely:

| start lane | `/T/` position | epoch | fires? |
|---|---|---|---|
| 0 | lanes 1…7 of the `/S/` word | B | **no — structurally out of reach** |
| 0 | lane 0 of the next word (`cov_first` = 0, `a_char_end` = 0 ⇒ `count_next` = 0) | A | **yes**, on the seed |
| 0 | lanes 1…4 of the next word ⇒ `count_next` = 1…4 | A | yes, per the content table |
| 4 | lanes 5…7 of the `/S/` word | C | **no — structurally out of reach** |
| 4 | lanes 0…3 of the next word (`cov_first` = 4 > `cov_end` ⇒ `cov_nonempty` = 0 ⇒ `count_next` = 0) | A | **yes**, on the seed |
| 4 | lanes 4…7 of the next word ⇒ `count_next` = 0…3 | A | yes |

**Fires at both start lanes** on the epoch-A members. The epoch-B/C exclusion is a
real limit on what a kill here proves and is stated so that no verdict reads a kill
as covering the in-word path.

### 5.6 IC-M6

**Gate**: `a_close_start` (375), mutated to
`(a_char_acts |: sm.is State.Discard) &: any (lanes.is_start &: a_close_oh)`.

At cycle **V**, the input word carrying a `/S/` that arrives while the module is in
`Discard`:

| conjunct | value | source |
|---|---|---|
| `sm.is State.Discard` | 1 — the frame exceeded 1518 octets, `a_close_oversize` fired at word T, `to_discard` (610) took the FSM to `Discard` (621, 631), and no `/T/` and no `/S/` has arrived since (the `Discard` row, 635–645) | **[S]** |
| `a_char_acts` | **0** — `a_open` = 0 in `Discard` (296), so the surviving disjunct is entirely the mutation's | **[D]** |
| `any (lanes.is_start &: a_close_oh)` | 1 — the resynchronising `/S/` is present and is the lowest closure character in its word; `a_closing_v` (313) tests `is_start` unconditionally and `a_pre_mask` = 0 in `Discard`, so the other-control term contributes nothing | **[S]** |
| the `|: sm.is State.Discard` disjunct | — | **[M]** |

⇒ `a_close_char` = 1 (376) ⇒ `a_close_now` = 1 (377) ⇒ `r0` = {`valid`, `start`},
every other field 0 (`a_close_terminate`, `a_close_error`, `a_close_oversize`,
`a_close_runt` all conjoin `a_open` or `a_close_terminate` and are 0) ⇒ the record
ages to r2 and `consume` fires at `sel_is_r2` (977) ⇒
`error_start_without_terminate = strobe sel_start` (1004) pulses at **V + 2**. §9's
sixth ruling requires it to pulse **nothing**.

**Per lane.** The resynchronising `/S/` may be in lane 0 or lane 4;
`a_close_oh = lowest_set a_closing_v` (315) marks whichever, and
`any (lanes.is_start &: a_close_oh)` = 1 in both. The truncated frame's own start
lane sets `off4` and the truncation cycle and is read by no conjunct above.
**Fires at both lanes and for a `/S/` in either lane.**

**Per member — the epoch discrimination, which is this class's point.** `M03-M6`
binds two carriers of different epochs:

- **first epoch** — the `/S/` is driven **into the `Discard` state**: the table
  above holds and the carrier reddens.
- **second epoch** — the `/S/` is driven **after the oversize frame's own terminate
  character**: a `/T/` in `Discard` takes the FSM to `Idle` (623, 643), so
  `sm.is State.Discard` = 0 at that `/S/` and **the class does not fire — a
  required green.**

That is §8.1 IC-M6 rule 1's pattern exactly, and it is produced by D-M6a's first
reading. **The second reading — "any start character that finds no open frame" —
would redden every ordinary inter-frame start character in the whole bench and is
not rendered here.**

### 5.7 IC-M7

**Gate**: `a_close_error` (372–374), mutated to
`(a_char_acts |: sm.is State.Discard) &: any ((lanes.is_error |: (other_ctl &: a_pre_mask)) &: a_close_oh)`.

At cycle **V**, the input word carrying an `/E/` that arrives while the module is in
`Discard`: the table is §5.6's with `is_error` in place of `is_start`, plus one
term:

| conjunct | value | source |
|---|---|---|
| `a_pre_mask` (308) = `repeat (in_preamble &: frame_start4) 8 &: 0x0f` | **0** in `Discard`, so the disjunct reduces to `is_error &: a_close_oh` — keyed on the error character alone | **[D]** |

⇒ `r0` = {`valid`, `error`} ⇒ `error_bad_frame = strobe sel_error |: q_strobe 0`
(1001) pulses at **V + 2**. §9's seventh ruling and carry-forward **C-12** require
it to pulse **nothing** and to emit nothing.

**Per lane and per member.** The `/E/` may be in any of the eight lanes of a
post-truncation word and fires iff it is the lowest closure character there;
independent of the truncated frame's start lane. **Fires at both lanes.** The
second-epoch carrier — the `/E/` driven after the oversize frame's own terminate
character — finds the FSM in `Idle` and **does not fire: a required green**, which
is §8.1 IC-M7 rule 1.

### 5.8 The one datapath adjacency, discharged for IC-M6 and IC-M7 together

Both classes perturb `a_close_char` (376) and therefore `a_close_now` (377), whose
consumers are exactly two (`grep -n '\ba_close_now\b'`, comments excluded): `r0`'s
`~valid` (508) and `bubble` (732). Three discharges, and the first two are
**structural** — they hold on every stimulus, not merely at a carrier:

1. **`bubble` (732)** is `off4 &: a_open &: ~:cov_nonempty &: ~:a_close_now`. Both
   mutations fire only where `sm.is State.Discard`, hence where `a_open` = 0 (296).
   **`bubble` = 0 in base and mutant alike on every cycle either mutation can
   fire.** The alignment window, `data_d`/`cov_d`/`first_d` (734–736), `al_data`
   (740) and `al_keep` (741) are therefore bit-identical.
2. **The `Always` switch (611–647)** reads `a_close_char` at exactly two sites,
   622 (`Preamble` row) and 632 (`Frame` row). Both mutations fire only in
   `Discard`, whose row (635–645) reads `to_preamble` (609) and `have_terminate`
   (235) and **never `a_close_char`**. **The FSM is bit-identical**, and §6.3
   item 6's deliberately unobservable post-`/E/` state choice is untouched.
3. **The spurious `r0`** reaches the datapath only through `sel_valid` (528),
   whose consumers are `strip` (800), `closed` (956) and `consume` (977), and
   through `abort` (975).
   - **`strip`** is `mux2 (sel_valid &: (sel_terminate |: sel_oversize)) 4 0`. The
     spurious record has `sel_terminate` = `sel_oversize` = 0, so `strip` = 0 —
     **the same value the base has with no record at all**.
   - **`closed`**, **`abort`** and every emission arm that reads them conjoin
     `have_word` (831): `emit_last_a` (959), `emit_last_b` (960), `emit_full`
     (962), `hold` (971), and `tuser = emit_tlast &: abort` (998). So the whole
     residual reach collapses to one question: **is `have_word` = 0 on every cycle
     the spurious record is *selected*?**

   **It is, and here is the derivation.** In `Discard`, `cov_first` = 8 (297–302)
   so `cov` = 0 (382) and `cov_nonempty` = 0 (381); the state has covered no octet
   for every cycle it has been in `Discard`. Hence `cov_d`, `al_keep` and
   `al_keep_d` are 0 at V and V + 1, and `pc` (795) = 0, so `have_word` = 0 at
   V, V + 1 and V + 2. For IC-M6, where the `/S/` opens a new frame at V, the
   resynchronised frame's first aligned word does not reach `al_keep_d` until
   **V + 3** at either start lane: at a lane-0 start `off4` is forced to 0 on V
   (664–667, `begins &: ~:new_start4`) so `al_keep(V+1) = cov_d(V+1) = cov(V) = 0`;
   at a lane-4 start `cov(V+1)` has bits 4…7 only (`cov_first` = 4) so
   `rotate_hi` (737, 741) reads `cov(V+1)[3:0]` = 0 and `al_keep(V+1)` = 0 again.
   The spurious record is consumed at **V + 2** by `sel_is_r2` (977, 522).
   **`have_word` = 0 throughout its selected life.**

   **And where the truncated frame is still draining**, the oversize record is
   *older* and `sel` takes the oldest (522–525), so the spurious age-0 record is
   shadowed and `sel` is bit-identical to the base until the real record is
   consumed — by which point `emit_tlast` has fired and either `nc` = 0 or
   `fcs_tail_now` (830) suppresses the residue word, giving `have_word` = 0 from
   the next cycle (the design's own invariant, 813–828 and 966–970).

⇒ **`rx.tvalid`, `tdata`, `tkeep`, `tstrb`, `tlast` and `tuser` are bit-identical
under IC-M6 and IC-M7.**

---

## 6. The ten mandatory disclosures, answered in my own words

### D-M1a — which member survives
**R.** `error_runt` survives; `error_bad_fcs` is suppressed. The rendering gates
the `error_bad_fcs` **port** (1000) with `~:sel_runt`, so on a frame that is both a
runt and wrong in its FCS the runt report is the one that speaks.

### D-M1b — the strobe, or the whole condition
**The strobe output only** — the first, which is the class. The mutated term is at
line 1000 and `error_bad_fcs` is read by **nothing** in this module (`grep` on
`sel_bad_fcs` returns 533, 975, 1000; the port itself has no consumer). The
condition survives intact in the closure record's bit 5 (513) and therefore in
`abort` (975), so **`tuser`[0] on that frame cannot go to 0** — it is 1 through
`sel_bad_fcs` *and* independently through `sel_runt`. §8.1 rule 3 is not reached.

### D-M2a — the extent and the constant
**Extent: the 1518 octets the frame received while open** — every octet
`cov_count` (383) counted from the frame's first octet up to REQ-108's cap, which
is exactly `count_next` = 1518 at the truncation cycle because `cap_end` (343–351)
caps coverage there. **Not** the 1514 delivered, **not** the whole 1600.
**Constant: REQ-304's residue `0x2144DF1C`** (`fcs_residue`, 154) — the design's own
one-equality residue form (§6.1 item 4), **not** a computed CRC compared against a
received FCS field. The comparison is `crc_final <>: fcs_residue` (471) with
`crc_final = mux2 crc_update crc_out crc_reg` (451), i.e. the value **after** the
truncation word's own update.

### D-M3a — the extent
**Yes: the octets delivered before the error character, with the `/E/`'s own octet
position excluded**, and **no** REQ-103 four-octet removal attempted on the abort
path. Mechanically: `cov_end = min(a_char_end, cap_end, a_hold_end)` (353) and
`a_char_end` (316–317) is the **index** of the `/E/` lane, so `cov` (382) covers
lanes strictly below it; `strip` (800) is 0 for an error closure because it reads
`sel_terminate |: sel_oversize`. **One scope note the disclosure does not ask for
but the adjudication needs**: the rendering **retains** `has_fcs` (470), so it
fires only where ≥ 5 octets were received while open. Removing that gate as well
would make IC-M3 also IC-M10, and §10's no-combined-diff rule forbids it.

### D-M4a — the extent
**As D-M3a, for the start-character closure**: the octets received before the new
`/S/` (`a_char_end` = the `/S/`'s lane index, so at `/S/` in lane 4 the aborted
frame keeps lanes 0…3 — REQ-110's lane rule), with **no** REQ-103 removal
attempted (`strip` = 0), and the same retained `has_fcs` ≥ 5 gate. Constant and
comparison as D-M2a.

### D-M5a — is the delivered extent unchanged?
**NOT SEEDED, self-declared.** The shared term, quoted:

```ocaml
296:  let a_open = in_preamble |: in_frame in
```

One signal serves both paths. It is the REQ-110 abort detector's open-frame term —
via `a_char_acts` (364) → `a_closes_with` (365) → `a_close_start` (375) — **and**
the delivery path's, via `bubble` (732) and, as the FSM state behind it,
`cov_first` (297–302) and `a_pre_mask` (308). Both attempted renderings move the
delivered stream, and both are derived in §3.5: the first strands the aborted
frame's last word (the closure record is never born), the second forces `bubble`
high at offset 4 on the word after the `/E/` and **loses the aborted frame's final
half word** — a `BUG-0003`-signature component. §8.1 IC-M5 rule 3 governs;
`M03-M5` is **SCORED AND UNQUALIFIABLE at this design**, and the claim is made in
the narrow form §3.5 states, not the wide one.

### D-M5b — the complete clear set
**Not applicable to a rendering, because there is none.** Answered instead for the
**shared** term, which is what the disclosure is really asking about: the events
that clear `a_open` are the FSM's exits from `Preamble`/`Frame` (611–647) —
`a_close_terminate` (366), `a_close_error` (372–374), `a_close_start` (375, with
`begins` (430) overriding to `Preamble` where a new frame opens),
`a_close_oversize` (361–363, to `Discard`), and `clear` through `Reg_spec.create
~clear:i.clear` (232). **The class would have removed exactly the error-character
member** and cannot, because the same term bounds the delivered extent. The
truncation member is **not** dropped by anything here, so §10's collision 2 with
IC-M6's red set is not created by this manifest.

### D-M6a — the gate term
**The `Discard` state.** The term is literally `sm.is State.Discard`, ORed into the
open-frame gate of the start arm only (375). **Not** "any start character that
finds no open frame" — that second reading pulses on ordinary inter-frame start
characters, would redden most of the bench, scores zero under §8.1 rule 3 and
destroys the epoch measurement. **Not** IC-M5's wide branch either: `a_open` is
untouched, so no collision with §10's second pair is created from this side.

### D-M7a — the gate term
**The `Discard` state**, identically: `sm.is State.Discard` ORed into the open-frame
gate of the error arm only (372–374). **Not** "any error character that finds no
open frame". In `Discard`, `a_pre_mask` (308) is 0, so the added disjunct reduces
to `is_error &: a_close_oh` and no stray `/E/` in an inter-frame gap — which §9's
third table row and C-12 both forbid — is reached, because in a gap the state is
`Idle`, not `Discard`.

### D-M10a — the zero-octet operand
**The rendering compares §6.1 item 1's seed, `0x00000000`.** At a frame of zero
received octets `cov_count` (383) is 0 on every cycle of the frame's life, so
`crc_update` (447) is never asserted, `crc_final` (451) is `crc_reg` and `crc_reg`
was loaded with `zero 32` at `begins` (478). `0x00000000` ≠ `0x2144DF1C`, so
**the class fires at the zero-octet member** — it does not skip the frame and does
nothing else. That is what makes the zero-octet member speak first and, per the
packet's §4 item 6, shadows the 4-octet anti-vacuity member behind it; the
`00 00 00 00` 4-octet content is the class's one required green (§5.5's table).

---

## 7. §6's pre-ship check — all eight classes, in its POSITIVE form

The measured signature (`BUG-0003` §V.10.2, `J-dv_lead-0103`, transient tree
`5c47582`) is (a) mid-frame words with `tkeep` ≠ 0xFF and `tlast` = 0; (b) octets
delivered at wrong byte positions, octets replaced by the idle filler `0x07`,
octets never delivered at all; `tlast` on the wrong word; `tuser` = 0 on a
corrupted frame. **None of its components is produced by any class below**, and
the positive statement — that the delivered word count, every `tkeep`, every
`tlast` placement, every `tuser`[0] and every delivered octet are **identical to
the base** — is made per class with its ground.

| class | delivered stream vs base | ground, and its strength |
|---|---|---|
| **IC-M1** | **identical, on every stimulus** | The mutated term is the `error_bad_fcs` **port** (1000). Its only consumers are outside the module. No datapath signal reads it. **Reachability, not argument** |
| **IC-M2** | **identical, on every stimulus** | The mutated bit is record bit 5 → `sel_bad_fcs` (533), whose only consumers are `abort` (975) and the port (1000). `abort` reaches `tuser` (998) alone — and the class fires only where `a_close_oversize` = 1, so `sel_oversize` already holds `abort` high. `strip` (800) reads `sel_terminate \|: sel_oversize`, not `sel_bad_fcs`. **`tuser`[0] = 1 either way** |
| **IC-M3** | **identical, on every stimulus** | As IC-M2, with `sel_error` (530) already holding `abort` high wherever the class fires |
| **IC-M4** | **identical, on every stimulus** | As IC-M2, with `sel_start` (531) already holding `abort` high |
| **IC-M5** | **not seeded** — no rendering ships, so nothing to check. Both attempted renderings **failed** this check and that failure is the declaration's evidence (§3.5) | — |
| **IC-M6** | **identical** | Three discharges in §5.8: `bubble` = 0 structurally (`a_open` = 0 in `Discard`); the FSM's `Discard` row never reads `a_close_char`; and `have_word` = 0 on every cycle the spurious record is selected, with the drain case covered by record ageing order |
| **IC-M7** | **identical** | §5.8, identically. Additionally the absorbed `/E/` emits nothing in base and mutant alike, and §6.3 item 6's unobservable state choice is untouched |
| **IC-M10** | **identical, on every stimulus** | The mutated constant (136) reaches only `has_fcs` (470) → `bad_fcs` (471) → record bit 5 → `sel_bad_fcs` → `abort` and the port. The class fires only on frames with `a_close_runt` = 1, so `sel_runt` already holds `abort` high; and every such frame emits **no output word** (`pc >: strip` fails, 959), so `emit_tlast` = 0 and `tuser` = 0 in base and mutant alike |

**Six of the seven seeded classes pass this check by reachability** — the mutated
term is not read by any signal on a path to an `rx` field — which is a stronger
result than "identical at the carrier": it is identical **everywhere**, at every
stimulus, including ones no carrier drives. **IC-M6 and IC-M7 pass by the
three-part discharge of §5.8**, of which two parts are structural and one
(`have_word` = 0) is derived from `Discard`'s zero coverage and the alignment
window's own latency.

**One honest limit on all eight rows.** These are derivations from the base
source, not elaborations: no mutant was built or simulated, because the switch in
this environment carries `dune` and no compiler libraries (§10). CI is the
authority (ADR-0005, §12(c)) and a divergence between this table and a scorecard
is a finding against this manifest, which is the correct direction for it to run.

---

## 8. Blast-radius rules — one per class, in stimulus terms (§3.3)

**The rule governs where a rule and an enumeration disagree.** A red selected by
the rule is predicted radius and contributes **zero** additional kills; a red
outside the rule is a **finding**. I name no instances beneath these rules,
because naming instances would require the unit list the allowlist bars.

| class | rule — the red set outside its own carrier is exactly the units whose stimulus … |
|---|---|
| **IC-M1** | … drives a frame closed by `/T/` with 5 ≤ received octets ≤ 63 **and** a residue mismatch at that closure. Narrow: it needs *both* conditions on one frame |
| **IC-M2** | … drives a frame whose received count passes 1518 (a REQ-108 truncation), **and** whose 1518-octet received prefix does not satisfy REQ-304's residue |
| **IC-M3** | … closes an open frame with an `/E/` — or with any other control character standing in one of epoch A's preamble positions — after ≥ 5 octets received while open, that character being the lowest closure character in its word, and the CRC over those octets ≠ residue |
| **IC-M4** | … closes an open frame with a new `/S/` after ≥ 5 octets received while open (the `/S/` being lowest in its word), CRC ≠ residue. **Includes** REQ-110 aborts taken while `cfg_rx_enable` = 0 (§5.4) |
| **IC-M5** | *(no rendering — empty rule)* |
| **IC-M6** | … drives a start character while the module is in `Discard`: i.e. after a REQ-108 truncation and **before** the `/T/` or `/S/` that leaves `Discard`. **Excludes** every start character arriving after the oversize frame's own terminate character |
| **IC-M7** | … drives an error character while the module is in `Discard`, that `/E/` being the lowest closure character in its word. **Excludes** every `/E/` in an ordinary inter-frame gap (state `Idle`) |
| **IC-M10** | … closes a frame with `/T/` at a received count of 0 to 4 octets **through epoch A** — i.e. the `/T/` is not in the frame's own start word — excepting a 4-octet frame whose four octets are `00 00 00 00`. **Excludes** every sub-five frame opened and closed inside one input word (epochs B and C carry no FCS bit) |

**Two facts about their shape, restated from the packet and confirmed against the
source.** The four residue classes (M2, M3, M4, M10) have **wide** rules, because
each selects every unit whose stimulus contains the closure kind it keys on.
IC-M1, IC-M6 and IC-M7 have **very narrow** ones. Neither costs a class anything —
kills are counted **per class**, never per reddened unit (`WO-0066` §11) — and
neither may be reported as coverage.

**And the campaign's own governing rule, restated so this manifest is read against
it** (packet §11's correction of `FINDING M-3`): a carrier kill kills its bound M
row **iff the mechanism runs through the co-occurrence the row asserts** — iff the
strobe SET changes and the carrier's strobe-set assertion is the assertion that
speaks. Every class here is built to satisfy that antecedent and none is built to
redden a carrier at an earlier assertion.

---

## 9. Pre-run reading note — questions for dv_lead, **before** the run

Per §7 item 7 and the `WO-0063B` precedent: *a question about this packet comes to
dv_lead as a committed pre-run reading note before the run.* Five, and each names
what turns on the answer.

1. **IC-M5's declaration, and whether §8.1 rule 3's scope is the one I claim.**
   I declare `M03-M5` **SCORED AND UNQUALIFIABLE at this design** on the narrow
   ground that this design has exactly one open-frame term and that term bounds
   the delivered extent (§3.5, D-M5a). §8.1 rule 3's own wording is wider —
   *"ruling 5 has no datapath-silent mutant here"*. **Does the verdict adopt the
   narrow form?** I decline to assert the wide one: a design carrying a separate
   report-side `frame_active` flag would have a datapath-silent mutant, and this
   design's not having one is a fact about **this** design.

2. **IC-M10's epoch-B/C exclusion, declared before the run.** The class
   structurally **cannot** fire on a sub-five frame opened and closed inside one
   input word, because `inword_strobes` (571–582) carries no `error_bad_fcs` bit
   at all. If any member of `M03-F2`'s or `M03-B3`'s carrier is such a frame, that
   member is a **required green of IC-M10** and not a miss. **Does the seal branch
   on the epoch, or only on the octet count?** Cells that read only the count would
   score a structural green as a failure to seed.

3. **The residue classes retain the sub-five gate, deliberately.** IC-M2, IC-M3 and
   IC-M4 keep `has_fcs` (470), so none of them fires at a closure with < 5 received
   octets. That is what keeps each one class rather than two, but it means **the
   zero-delivered members of the `/E/` and `/S/` abort families are required greens
   of IC-M3 and IC-M4**. If a seal cell expects a red at a zero-octet abort under
   IC-M3 or IC-M4, it is expecting the combined class §10 forbids.

4. **The price changed, and it changed downward.** Seven transients, not eight:
   **7 × 344 s ≈ 40.1 minutes** against §12's ≈ 45.9, a saving of ≈ 5.7 minutes.
   §12(b)'s recommendation to keep IC-M10 is honoured — IC-M10 rides. The
   reduction is IC-M5's absence and nothing else, and it is **declared before any
   run** as the spawn requires.

5. **A collision prediction offered before the run, as last round's was.** §10
   tells me one pair is discriminated *only* by which diff was applied. From this
   side, the candidate is **IC-M3 and IC-M4**: both add exactly one
   `error_bad_fcs` pulse to a zero-`strip` abort of a frame with ≥ 5 received
   octets, both leave the delivered stream identical, and at a count-shaped cell
   that prints neither the strobe's name nor its cycle the two messages can be
   character-for-character identical. **They are not the same edit** — different
   disjuncts, `a_close_error` (372) against `a_close_start` (375), selecting
   disjoint closure kinds — and the discriminator that always exists is the
   branch name, which §10 item 2's fixed ordering preserves. Offered as a
   derivation, not as a reading of the seal, which is unopened.

---

## 10. What this manifest does not carry, and why

1. **No scorecard, no CI run ids, no control-run conclusion, no `cosim`
   conclusion.** This is the seeding half. §4 item 5 has already declared what a
   green `cosim` means here — the pinned canonical form
   (`{ tkeep; tlast; tuser0; octets }` plus an accept/discard decision) **has no
   strobe field**, so the anchor is blind to every class in this campaign by
   construction; I confirm that independently from the class list: **not one of
   the seven seeded diffs changes a delivered word, a `tkeep`, a `tlast`, a
   `tuser`[0] or a frame's accept/discard decision.**
2. **No compilation result.** The `fpga` opam switch in this environment contains
   `dune` (3.24.1) and **no compiler libraries and no Hardcaml**, so no mutant —
   and no base — can be elaborated here. Every diff is verified by
   `git apply --check` plus round-trip revert (§11) and by source inspection
   against the surrounding code's own idioms; **a mutant that does not compile is
   a build finding whose evidence is the CI build step's conclusion**, never
   anything from me. `dune` was not run, on the working branch or anywhere.
3. **No formatting guarantee.** I could not check the repository's formatter
   configuration without leaving the allowlist. The two multi-line renderings
   (IC-M6, IC-M7) are written in the shape the base file's own `a_close_error`
   (372–374) already uses. If CI gates on a formatter, that is a build finding of
   the same class as (2).
4. **No AP edit, no `tools/` edit, no `test/**` byte.** §13's owed list stands
   untouched, which is what preserves §8's *"nothing under `test/**` moves again
   until the campaign scores."* **This manifest and my journal entry are the only
   files this round asks the orchestrator to commit**, and both are inside
   `docs/reports/audit/**`.

---

## 11. Operator instructions — the seven branches, ready to cut

Verified at `ca1bb80` with a clean tree. Each patch applies **alone**, touches one
file, and reverts clean:

```
IC-M1 : anchors=1  apply-check OK  applied[ M libs/hardcaml_ethernet/src/xgmii_rx_64.ml]  reverted-clean
IC-M2 : anchors=1  apply-check OK  applied[ M libs/hardcaml_ethernet/src/xgmii_rx_64.ml]  reverted-clean
IC-M3 : anchors=1  apply-check OK  applied[ M libs/hardcaml_ethernet/src/xgmii_rx_64.ml]  reverted-clean
IC-M4 : anchors=1  apply-check OK  applied[ M libs/hardcaml_ethernet/src/xgmii_rx_64.ml]  reverted-clean
IC-M6 : anchors=1  apply-check OK  applied[ M libs/hardcaml_ethernet/src/xgmii_rx_64.ml]  reverted-clean
IC-M7 : anchors=1  apply-check OK  applied[ M libs/hardcaml_ethernet/src/xgmii_rx_64.ml]  reverted-clean
IC-M10: anchors=1  apply-check OK  applied[ M libs/hardcaml_ethernet/src/xgmii_rx_64.ml]  reverted-clean
$ git rev-parse HEAD   -> ca1bb80a80d1b7a3f4f705fe4c056e97227c2b5b   (unmoved)
$ git status --porcelain | wc -l -> 0
```

Each diff is a **single-line or single-hunk** replacement whose old text occurs
**exactly once** in the file, so it can be reproduced from §3 with a one-line
substitution rather than from a patch blob:

| branch | file line | replace | with |
|---|---|---|---|
| `mut/wo-0074-m1` | 1000 | `  ; error_bad_fcs = strobe sel_bad_fcs` | `  ; error_bad_fcs = strobe (sel_bad_fcs &: ~:sel_runt)` |
| `mut/wo-0074-m2` | 513 | `      ~fcs:(a_close_terminate &: bad_fcs)` | `      ~fcs:((a_close_terminate \|: a_close_oversize) &: bad_fcs)` |
| `mut/wo-0074-m3` | 513 | *(same old line)* | `      ~fcs:((a_close_terminate \|: a_close_error) &: bad_fcs)` |
| `mut/wo-0074-m4` | 513 | *(same old line)* | `      ~fcs:((a_close_terminate \|: a_close_start) &: bad_fcs)` |
| `mut/wo-0074-m6` | 375 | `  let a_close_start = a_closes_with lanes.is_start in` | the three-line form in §3.6 |
| `mut/wo-0074-m7` | 372–374 | the three-line `a_close_error` binding | the four-line form in §3.7 |
| `mut/wo-0074-m10` | 136 | `let fcs_min_octets = 5` | `let fcs_min_octets = 0` |

**Delivery order is §10 item 2's and is fixed**: m1, m2, m3, m4, (m5 skipped), m6,
m7, m10 — one branch each, cut from `ca1bb80`, one commit each, message
`MUTATION RUN IC-M<N> -- never merge`, one CI `build` run each. **`journal-check`
is expected red on every one of them** (a mutation commit stages a work product
with no journal append — R2 by construction); the `build` job's conclusion is the
campaign's evidence and the only job that is. **None of these branches may ever be
merged.**

---

## 12. Summary

| class | seeded | site | one-line intent | disclosure answers |
|---|---|---|---|---|
| IC-M1 | ✅ `mut/wo-0074-m1` | 1000 | precedence: `error_runt` suppresses `error_bad_fcs` on a runt | D-M1a **R**, D-M1b **strobe only** |
| IC-M2 | ✅ `mut/wo-0074-m2` | 513 | compare the residue at REQ-108's truncation point | D-M2a **1518 received octets vs `0x2144DF1C`** |
| IC-M3 | ✅ `mut/wo-0074-m3` | 513 | compare at an `/E/` closure | D-M3a **octets before the `/E/`, no removal, `has_fcs` retained** |
| IC-M4 | ✅ `mut/wo-0074-m4` | 513 | compare at a `/S/` closure | D-M4a **octets before the `/S/`, no removal, `has_fcs` retained** |
| IC-M5 | ❌ **NOT SEEDED** | — | ruling 5 has no datapath-silent mutant reachable in this design's terms | D-M5a **shared term `a_open` (296)**, D-M5b **the FSM's own exits** |
| IC-M6 | ✅ `mut/wo-0074-m6` | 375 | a `/S/` in `Discard` reported as an abort | D-M6a **the `Discard` state** |
| IC-M7 | ✅ `mut/wo-0074-m7` | 372–374 | an `/E/` in `Discard` reported | D-M7a **the `Discard` state** |
| IC-M10 | ✅ `mut/wo-0074-m10` | 136 | compare at every terminate character | D-M10a **the `0x00000000` seed; it fires** |

**Seven seeded, one declared, ten disclosures answered, §6's check positive for all
eight, R-DISC-2's inventory inverted as §5 requires, and no branch cut — pending
the ruling on FINDING WO-0074-A1.**
