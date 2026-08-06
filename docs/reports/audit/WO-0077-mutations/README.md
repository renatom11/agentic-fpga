# WO-0077 — family-K + N-completion mutation manifest: nine classes against `clear` and the enable, all nine seeded, none of them cut

- **Author**: auditor (`J-auditor-0018`), spawn short-id `WO-0077-SEED/2026-08-10T16:30Z`
- **Commission**: `agents/handoffs/WO-0077_family-k-mutation-campaign.md`
- **Base SHA applied to**: `aced7b41ef83c497b81cba411e51045627260f20` (packet §9.3 item 6)
- **State**: **manifest delivered; the nine transient branches are NOT cut.** The
  packet carries `FINDING WO-0074-A1` (MAJOR, mine, ruled **ACCEPTED**) into its own
  terms at §9.1, so the operator cuts `mut/wo-0077-k1 … k6, n1, n4a, n4b` from §10's
  table in §12's fixed order. Every diff below is verified to apply alone at the base
  SHA, to parse, and to revert clean.
- **This manifest is the seeding half only.** It carries no scorecard, no CI run id,
  no control-run conclusion and no `cosim` conclusion; those are the run half's
  (packet §17 items 4–7) and **CI is the authority** (ADR-0005, packet §14(d)).
  Nothing below is offered as a claim that a class *does* kill: a manifest predicts a
  mechanism, a run measures it.
- **Headline, stated first because the packet pre-committed the other branch**:
  **`IC-K4` is SEEDED.** The packet named it the likeliest `NOT SEEDED` of the nine
  (§1.6, §14(c), Q2) and pre-committed `M03-K1` **UNQUALIFIABLE BY MUTATION** as the
  disposition if it came back declared (§13). It does not come back declared. §2.4
  gives the carry mechanism and §5's `D-K4c` states in my own words how it satisfies
  both of `D-K1b`'s conjuncts — the thing the packet doubted was expressible.
  **Nine classes, nine diffs, nine seeded, zero `NOT SEEDED`.**

---

## Section map

| § | what it carries |
|---|---|
| 0 | blinding, stated affirmatively, with every exposure disclosed |
| 1 | the base SHA, §9.2's abort-first direction check, §10's freeze, R-SEAL-1 |
| 2 | the nine classes — nine diffs, with the rejected alternatives |
| 3 | R-DISC-2 — the five-path gate inventory with cross-class facts tabulated |
| 4 | R-DISC-1 — reachability discharged per class, per lane, term by term |
| 5 | the nineteen mandatory disclosures, answered in my own words |
| 6 | §7's pre-ship check, in its POSITIVE form, for all nine |
| 7 | blast-radius rules — one per class, complete conjunct lists |
| 8 | pre-run reading note — six questions for dv_lead, **before** the run |
| 9 | what this manifest does not carry, and why |
| 10 | operator instructions — the nine branches, ready to cut |
| 11 | summary |

---

## 0. Blinding — stated affirmatively, with every exposure disclosed

**What I read for this campaign, and nothing else.**

| # | path | extent |
|---|---|---|
| 1 | `agents/charters/auditor.md`, `agents/PROTOCOL.md` | in full — my mandatory first actions, which precede the packet's allowlist |
| 2 | `agents/handoffs/WO-0077_family-k-mutation-campaign.md` | in full (all 1641 lines, in four reads) |
| 3 | `libs/hardcaml_ethernet/src/xgmii_rx_64.ml` | all 1011 lines, at the base SHA — the mutation target |
| 3b | `libs/hardcaml_ethernet/src/xgmii_rx_64.mli` | all 45 lines, at the base SHA — read to confirm no rendering needs an interface edit (§6) |
| 4 | `docs/specs/requirements.md` | rows **REQ-005**, **REQ-008**, **REQ-009**, **REQ-011**, **REQ-015**, **REQ-016**, **REQ-101** … **REQ-113**, **REQ-802**, **REQ-803**, **REQ-810**; the section index of the whole file |
| 5 | `docs/specs/modules/xgmii_rx_64.md` | the section index; §4.3 (194–245), §6.1's disabled-state paragraph (700–713), §6.2 (714–728), §6.3 (729–802), §7 (803–880), §9 (929–1050), and `grep -n` hit lines for `cfg_rx_enable` across §4.2/§10/§13 |
| 6 | `docs/reports/audit/**` | my own tree: `WO-0061-mutations/DISP-0001_A-1.md` §4 (R-DISC-1 and R-DISC-2, which bind these manifests), `WO-0076-mutations/README.md` (form and precedent), directory listing of the rest |
| 7 | `agents/journals/claude_auditor_agent.md` | **my own journal only** — the entry-id chain, the harvest-span boundary, the v01 header block and the file tail (four `grep`/`sed` windows; no other reading) |
| 8 | `docs/adr/ADR-0017-a-journal-is-a-chain-not-a-file.md` | §4.1–§4.4 only (224–330), the volume-header specification — **an exposure outside the packet's allowlist, disclosed at (E5) below** |

**Not read, absolutely.** The sealed companion
`WO-0077_family-k-mutation-campaign-SEALED-predictions.md` — **not opened, not
grepped, not `git show`n, no excerpt, no line count, no diff stat of its own.**
**All of `test/**`**: `test_m03_k.ml`, `test_m03_n.ml`, `test_m03_structural.ml`,
`bench.ml`/`bench.mli`, `test/xgmii/`, `test/monitors/`, `test/golden/`,
`test/cosim/`, and **the attack plan `test/attack_plans/AP-xgmii_rx_64.md` by name**
— which the packet bars by name because seven of the nine classes are quoted from its
cells. **All of `agents/**`** bar the packet and my two charter documents: **every
other journal**, every other handoff packet, and **`WO-0072` specifically**, whose §9
disposition table is `FINDING K-1`'s subject and which the packet bars by the same
rule. Also not read: `docs/gates/`, `tasks/`, `tools/`, `.github/`, `scripts/`,
`libs/**` other than the target and its `.mli`, and every `docs/specs/` file other
than the two named.

**`ADR-0014` was not read.** The packet's allowlist item 4 admits it; my spawn
prompt's allowlist omits it; **the narrower of the two was honoured**, as at
`WO-0076`. Both `M03-N4` classes below are derived from **REQ-810**'s own admission
clause, **SPEC-M03 §4.3**'s three-clause *"What the enable gates"* statement and its
*"The case that forced the ruling"* paragraph, **§6.1**'s disabled-state paragraph,
**§6.2**'s `Frame` row and **§9**'s clause (b) — every one of which states the ADR's
ruling in its own words. Nothing below rests on the ADR. **The broken path the last
round reported is unrepaired at this base**: the packet cites `docs/adr/ADR-0014.md`
and the file is `docs/adr/ADR-0014-an-enable-gates-admission-not-the-wire.md` (§8
RN-6; established from a directory listing, file names only, no content).

**Five exposures outside the allowlist, disclosed because a blinding statement that
omits its own leaks is worthless.**

- **(E1) `git show --stat --name-only aced7b4`** — **file names and the subject line**,
  never content. Three paths: the packet, **the seal**, and dv_lead's journal v06.
  Discharging §10's base rule and R-SEAL-1 requires knowing the seal is in this
  commit; nothing else was taken from it. The subject line came with the format
  string and is quoted at §1.1 — every clause in it is inside the packet's §18
  **freely told** set (nine classes, the N rows answered qualifiable, the cross
  product proven empty, the disposition table convicted before the run). **No cell,
  no message string, no MUST-STAY-GREEN member is in it.**
- **(E2) `git log --oneline -3 -- libs/hardcaml_ethernet/src/xgmii_rx_64.ml`** —
  subjects only, to establish that the target has not moved since `b848d56`
  (BUG-0003's repair), an ancestor of the base. No `test/**` path is in that output.
- **(E3) `git log --oneline -3 -- test/`** — **subjects and SHAs only, no content and
  no file names**, to verify the packet's §10 sentence *"the last `test/**` edit
  before this packet is `22ffe13`"* against history rather than accept it. Result at
  §1.2. This is the one exposure I would have avoided if the packet's freeze claim
  were self-verifying; it is not, and an unverified freeze is what voids a round.
- **(E4) `ls docs/adr/`** — file names only, to resolve the allowlist's broken
  `ADR-0014` path (above) and to locate ADR-0017 for (E5).
- **(E5) `docs/adr/ADR-0017-a-journal-is-a-chain-not-a-file.md` §4.1–§4.4** — read in
  full for those sections. **This is outside the packet's allowlist and I record it as
  a leak rather than argue it away.** The ground: my spawn prompt makes the journal
  rotation MANDATORY and specifies the header fields *"per ADR-0017 §4.3"*, and v01 of
  my journal carries no rotation header to copy. Guessing a header format that the
  commit scripts key on would risk a malformed chain — a protocol defect — to protect
  a blinding whose subject is a mutation campaign. **An ADR about journal file
  mechanics can contain no campaign answer**: I read §4.1 (layout), §4.2 (entry-ID
  continuation), §4.3 (the five header fields) and §4.4 (the rotation procedure), and
  nothing else in that file. No `test/**` fact, no cell, no message string is in it.

**Nothing in `test/**` was read, listed for content, counted or inferred from.**
Where this manifest needs a fact about a carrier's stimulus it takes it **from the
packet's own freely-told sections** and says so at the point of use — §3's censuses,
§4.2's reset-pulse measurement, §4.3's assertion orders, §5's twelve declarations,
and the packet's front-matter quotation of `WO-0072` §9's three tells. Where it needs
a fact the packet does not supply (frame A's start lane at `M03-K2`; the absolute
window cycles at `M03-K1`) it states a **rule in stimulus terms**, parameterises the
discharge, and raises the gap as a reading-note question at §8. **No diff below was
chosen against a written expectation**: each is the narrowest edit that renders its
class's own sentence of REQ-009 / REQ-810 / SPEC-M03 §4.3 / §6.2 / §9 in this
design's terms.

---

## 1. The base SHA, the direction check, the freeze and R-SEAL-1

### 1.1 §9.2's abort-first direction check — first action, before reading anything

```
$ git rev-parse HEAD
aced7b41ef83c497b81cba411e51045627260f20
$ git show --stat --name-only --format='%H%n%s' aced7b4      (names only — the seal was NOT opened)
aced7b41ef83c497b81cba411e51045627260f20
The tenth and last campaign sealed: nine classes, the N rows answered qualifiable,
the cross product proven empty - and the disposition table convicted before the run
agents/handoffs/WO-0077_family-k-mutation-campaign-SEALED-predictions.md
agents/handoffs/WO-0077_family-k-mutation-campaign.md
agents/journals/claude_dv_lead_agent.v06.md
```

HEAD **matches** the base the operator supplied, so §9.2's abort does not fire and no
`git merge-base` direction test was needed. **§10 fixes the base as *"the commit that
stages this packet and its seal. Not its parent"*: `aced7b4` stages both, so the
literal base and the operating base are one commit and there is nothing to file** —
the fifth clean application of the corrective drafting rule adopted at
`WO-0073-VERDICT` §7 after `FINDING WO-0073-M1`.

**R-SEAL-1 is satisfied on its face** (PROTOCOL §10, ADR-0016): the seal is a **file**
in the packet's own commit, so it appears in that commit's `Files-in-this-commit`
list, and it was frozen **before any diff existed** — this manifest is the first
artefact in the round that contains a diff, and it is written after that commit.
The packet's own sentence — *"If this commit does not stage that file, this round has
no seal"* — is discharged affirmatively, from the commit rather than from the claim.

The mutation target has not moved since **`b848d56`** (BUG-0003's repair), an ancestor
of the base (E2). All nine classes, the control run and every MUST-STAY-GREEN sweep
are against this one SHA (`BUG-0003` §V.9, packet §10).

### 1.2 §10's adjudicator-ordering rule, verified rather than accepted

The packet asserts the freeze; a manifest that repeats the assertion adds nothing.
From history (E3), subjects and SHAs only:

```
$ git log --oneline -3 -- test/
22ffe13  The comparator half: three tiers landed fail-closed, and the anchor's first
         real execution belongs to CI
1e5d58a  The plan absorbs the ninth campaign - and convicts the verdict's own
         reassurance standing in the path of the sign-off
c109c08  Five debts paid in one round: the anchor learns to see time lawfully, and
         the ruling that asked for it stands corrected
```

**`22ffe13` is the most recent `test/**` edit reachable from the base**, which is
exactly the packet's §10 sentence, and `aced7b4` itself stages **no `test/**` byte**
(§1.1's three paths). So at seeding time:

- every `test/**` byte this campaign scores against is at or before the base;
- the seal is frozen **after** the last bench edit and **before** the first mutant
  diff exists;
- the working tree is clean — `git status --porcelain` returns **0 lines**, before
  every patch trial and after every revert (§10's table).

**The limit of that check, stated rather than glossed**: it is a statement about
history *as of the base*, not a promise about the window. §10.1's hazard analysis
(`WO-0075` `ACCEPTED`, both halves landed, no outstanding work order touching
`test/**` or `tools/**`) is the operator's to keep true; if any `test/**` file is
edited between `aced7b4` and the scorecard, the packet's own rule governs and the
round re-seals. **This manifest stages nothing outside `docs/reports/audit/**`**
(PROTOCOL §6, my write scope), so it cannot itself break the freeze.

---

## 2. The nine classes — nine diffs, all seeded

Every diff touches `libs/hardcaml_ethernet/src/xgmii_rx_64.ml` and **nothing else**,
applies **alone** at `aced7b4`, parses, and reverts clean. **Delivery order is §12
item 2's and is fixed: IC-K1, IC-K2, IC-K3, IC-K4, IC-K5, IC-K6, IC-N1, IC-N4a,
IC-N4b.** Line numbers are the base file's at `aced7b4`.

**The design facts every K class rests on, measured on the target before any class was
written** (`grep -n '\bi\.clear\b'`, the port declaration excluded):

```
232:  let spec = Reg_spec.create ~clock:i.clock ~clear:i.clear () in   <- the register clear
377:  let a_close_now = (a_close_char |: a_close_oversize) &: ~:(i.clear) in
421:  let b_exists = bit lanes.is_start 0 &: i.cfg_rx_enable &: ~:(i.clear) in
422:  let c_exists = bit lanes.is_start 4 &: i.cfg_rx_enable &: ~:(i.clear) in
971:  hold <== (have_word &: ~:decided &: ~:(i.clear));
976:  let tvalid = (emit_full |: emit_tlast) &: ~:(i.clear) in
990:  let strobe s = consume &: s &: ~:(i.clear) in
991:  let q_strobe k = bit q2 k &: ~:(i.clear) in
997:      ; tlast = emit_tlast &: ~:(i.clear)
```

**`clear` enters this design in exactly two ways**: as `spec`'s **synchronous register
clear** (232), which is what makes REQ-009's *second* conjunct — silence on the first
cycle in which `clear` is 0 — true without any combinational term at all, since every
payload, record and state register is zero on the release cycle; and as **eight
combinational output/decision gates** (377, 421, 422, 971, 976, 990, 991, 997), which
are what make REQ-009's *first* conjunct true inside the window. **A consequence I
depended on and state once here because six discharges use it**: a `reg spec` register
samples its clear at the same edge as its data, so a register whose input was high on
the cycle **before** the window still presents that value on the window's **first**
cycle and is zeroed only at the end of it. That is what makes `IC-K4` expressible with
no added clock domain and no clear-free flop (§2.4), and it is what makes `IC-K3`'s
`reg spec vdd` an exact *"the previous cycle was cleared"* signal (§2.3).

**And the fact both N classes rest on**, unchanged from `WO-0076` §2 and re-measured
here: the base design reads `cfg_rx_enable` at exactly **two** sites, 421 and 422, and
**both are the admission gate** — SPEC-M03 §4.3's *"gates the admission of a frame,
and nothing else"* realised as a two-line fact. Both N4 classes therefore have to
*introduce* a read of the enable at a path it does not currently reach (`IC-N4a` at
the abort path, `IC-N4b` at the report path), which is what makes each of them the
**rejected** reading of REQ-810 rather than a re-arrangement of the accepted one.

### 2.1 IC-K1 — `clear` closes the in-flight frame instead of abandoning it (`WO-0072` §9's **D1**)

```diff
@@ -990,11 +990,11 @@ let create (scope : Scope.t) (i : Signal.t I.t) : Signal.t O.t =
   let strobe s = consume &: s &: ~:(i.clear) in
   let q_strobe k = bit q2 k &: ~:(i.clear) in
   { O.rx =
-      { Axi64.Source.tvalid
+      { Axi64.Source.tvalid = tvalid |: (have_word &: i.clear)
       ; tdata = al_data_d
       ; tkeep = keep_of_count keep_count
       ; tstrb = zero 8 (* REQ-014 *)
-      ; tlast = emit_tlast &: ~:(i.clear)
+      ; tlast = (emit_tlast &: ~:(i.clear)) |: (have_word &: i.clear)
       ; tuser = emit_tlast &: abort
       }
```

The class is REQ-009's mid-frame sentence read as *"close"* where it says
*"truncate … **no `tlast`** … is emitted for it"*. In this design the frame's octets
are already assembled in the emission register when the window opens; what stops them
is the pair of clear gates at 976 and 997. **The rendering releases exactly the word
that is resident on the window's first cycle and marks it `tlast`** — the phantom
frame, closed with a terminating word REQ-009 licenses none of.

**Why the word is well-formed rather than a stub, which matters for the permission
list.** `tkeep` is `keep_of_count keep_count` (972, 995) and `keep_count` falls to
`pc` when neither `emit_last_a` nor `emit_last_b` is asserted — which is the case
here, because both are conjoined with `decided`/`closed` and no closure record exists
under `clear` (377 is gated). So the phantom word carries `tkeep` = `0xFF`, `tuser`
= 0 and frame A's own octets: it looks exactly like a frame closed normally, which is
the defect this class is named for and **not** the §7 datapath-perturbation signature
(§6).

**Both added terms are conjoined with `i.clear` and both are read by the output record
alone.** `tvalid` (976) has exactly one reader — the record at 993 — and `emit_tlast`'s
other readers (959–963, 977) are untouched, so **nothing internal moves**: `consume`,
`hold`, the record ages, the alignment window and the state machine are bit-identical
under every stimulus. That is the strongest form the isolation demand can take, and it
is what makes frame B's delivery structurally unreachable from this diff.

**Rejected**: adding the closure at `a_close_now` (377) instead. It renders nothing —
the record it creates is destroyed by `spec`'s own clear at the first window edge, and
`tvalid`/`tlast` remain gated, so the design is observationally identical to the base.
**Rejected**: `D-K1a`'s site (ii), holding the closure across the window and emitting
on the release cycle. It cannot be minimal in this design: the payload registers are
cleared, so the released word would carry `tkeep` = 0 with `tvalid` = 1 — a word
REQ-011 says is never producible — and reconstructing a well-formed one needs the
whole emission stage lifted out of the clear domain. **Rejected**: site (iii), latching
a `/T/` inside the window. `M03-K2`'s window contains no terminate character (the
frame is abandoned, not terminated), so the site has no instance at the only unit that
can score it.

### 2.2 IC-K2 — the abandoned frame is reported (REQ-009's no-strobe clause)

```diff
@@ -1000,7 +1000,7 @@ let create (scope : Scope.t) (i : Signal.t I.t) : Signal.t O.t =
   ; error_bad_fcs = strobe sel_bad_fcs
   ; error_bad_frame = strobe sel_error |: q_strobe 0
   ; error_runt = strobe sel_runt |: q_strobe 1
-  ; error_oversize = strobe sel_oversize
+  ; error_oversize = strobe sel_oversize |: (a_open &: i.clear)
   ; error_start_without_terminate = strobe sel_start |: q_strobe 2
   }
```

The design a reader of REQ-008 writes when they mistake an abandonment for a discard
that owes a report. **The truncation is retained verbatim** — 976, 977, 990, 991 and
997 are untouched, so no word and no `tlast` appears inside the window and nothing is
added to any admitted frame's report. Only the report of the frame `clear` abandoned
is added, and `a_open` (296) is precisely *"a frame is open on this cycle"*: the
conjunction `a_open &: i.clear` is **the abandoned frame and nothing else**.

**Why `error_oversize`, given `D-K2a` says the class is the same whichever.** It is
the only strobe with **one** report path and **no genuine instance** in any stimulus
this campaign scores: `error_oversize` (1003) and `error_bad_fcs` (1000) carry epoch
A's path alone, and of the two only `error_oversize` requires more than 1518 received
octets (REQ-108), which no family-K schedule reaches. So the added report cannot
collide **by name** with a conformant report at either K unit — and at `M03-K1` the
conformant strobe is `error_bad_fcs` (packet §4.3), which choosing `error_bad_fcs`
would have merged with under §0.6's high-cycle counting convention. The strobe *set*
therefore stays a clean discriminator, which is what §11 seals it as.

**One pulse, structurally, not by care**: `a_open` is a function of the state
register, and the state register is cleared to `Idle` at the window's **first** edge,
so `a_open &: i.clear` is high on the window's first cycle and low on every later one.
`D-K2b` is answered by construction rather than by a count.

**Rejected**: adding the term at `strobe` (990) or at `consume` (977). Both are shared
by four or five outputs and would move reports of **admitted** frames, which is
outside this class's permission list — and 990 is `IC-K4`'s and `IC-N4b`'s site, where
a third claim on the same term would have made §3.5's cross-class table
irreconcilable rather than merely shared.

### 2.3 IC-K3 — the release cycle is not available (`WO-0072` §9's **D2**)

```diff
@@ -418,8 +418,9 @@ let create (scope : Scope.t) (i : Signal.t I.t) : Signal.t O.t =
   let inword_closing above =
     (lanes.is_terminate |: lanes.is_error |: lanes.is_start |: other_ctl) &: above
   in
-  let b_exists = bit lanes.is_start 0 &: i.cfg_rx_enable &: ~:(i.clear) in
-  let c_exists = bit lanes.is_start 4 &: i.cfg_rx_enable &: ~:(i.clear) in
+  let settled = reg spec vdd in
+  let b_exists = bit lanes.is_start 0 &: i.cfg_rx_enable &: ~:(i.clear) &: settled in
+  let c_exists = bit lanes.is_start 4 &: i.cfg_rx_enable &: ~:(i.clear) &: settled in
   let b_closing = inword_closing (of_int ~width:8 0xfe) in
   let c_closing = inword_closing (of_int ~width:8 0xe0) in
```

REQ-009's last sentence — *"A frame whose first word is presented on the first cycle
after `clear` returns to 0 SHALL be received correctly"* — denied by one cycle of
settling. `reg spec vdd` is the whole mechanism and it needs no new signal: a register
whose data input is constant 1 and whose clear is the design's own reads **0 exactly
on the cycle after any cycle in which `clear` was high**, and 1 everywhere else. That
is the *"needs one idle cycle after `clear`"* design written in the smallest form this
module admits, and it is the reset-release settling flop that real receivers grow.

**Both lanes, deliberately.** Gating 421 only would render a **lane-asymmetric**
design — a different defect — and would be `NOT SEEDED` at lane 4 for any carrier
driving both start lanes (packet §6's per-lane rule).

**It delays admission and nothing else**, which is `D-K3b`'s question. `settled` is
read at 421 and 422 and nowhere else; the emission path (976, 971), the report path
(990, 991), the closure record (377) and the state machine's own clear (232) are
textually untouched. A rendering that delayed the whole clear release would be
`IC-K5`, and §12 says what delivering one under the other's name costs.

**The one cycle at which this rendering differs from the base under `Clear.never`, and
why it is invisible**: the reset pulse `Bench.create` drives before every schedule
makes `settled` = 0 on **cycle 0**. Admission is therefore refused on cycle 0 of every
unit in the repository — and **no unit presents a start character on cycle 0**
(packet §4.2, measured at this tree: every schedule's `first_start` is 8, 12 or 8 + 8k
octet times, all ≥ 8, all cycle ≥ 1). The conjunct the mutation gates is 0 there in
both designs, so the response is identical. This is `D-K1b`(b) discharged **by
measurement**, and it is stated as a measurement rather than as a construction because
that is what it is.

**Rejected**: a clear-free `Reg_spec` holding a *"just released"* bit. Same observable,
a second clock domain in the diff, and an API surface the parse check cannot confirm —
`reg spec vdd` gets there with a construct the base file already uses eleven times.

### 2.4 IC-K4 — the strobe path survives `clear` (`M03-K1`'s **honest kill**) — **SEEDED**

```diff
@@ -987,7 +987,7 @@ let create (scope : Scope.t) (i : Signal.t I.t) : Signal.t O.t =
      no octet (REQ-108's count never advances there, and §9's ninth ruling
      leaves such a frame with no FCS to check). Their union is therefore a
      one-term union and is written as one. *)
-  let strobe s = consume &: s &: ~:(i.clear) in
+  let strobe s = (consume &: s &: ~:(i.clear)) |: (reg spec (consume &: s) &: i.clear) in
   let q_strobe k = bit q2 k &: ~:(i.clear) in
```

**The packet expected this class to come back `NOT SEEDED` and pre-committed the
disposition. It is seeded, and the mechanism is the one §1.6 said would have to
exist**: a carry *conditional on the neighbourhood of a clear*, not a re-timing.

Read the added term left to right. `reg spec (consume &: s)` is the previous cycle's
value of *this strobe's own report term*; it is conjoined with `i.clear`; and it is
**disjoined** with the conformant term, which is left byte-identical. So:

- **it adds a presentation and moves none.** Every pinned strobe cycle in the suite is
  produced by the first disjunct, unchanged. A plain registered strobe — the rendering
  §1.6 rules out — would have *moved* them and been a scope violation;
- **it vanishes identically where `clear` is 0**, at every cycle of every stimulus,
  because the second disjunct's last conjunct is `i.clear`. `D-K1b`(a) is satisfied
  structurally, not by inspection;
- **it does nothing at the reset pulse.** The carry register holds the pulse-preceding
  value of `consume &: s`, which is its power-up 0 — nothing has run. `D-K1b`(b) is
  satisfied structurally too, and this is the only class of the nine for which **both**
  conjuncts are structural rather than measured;
- **it fires exactly where `M03-K1`'s stimulus puts something to carry.** The register
  samples its clear at the same edge as its data, so a report term high on the cycle
  **immediately before** the window — which at `M03-K1` is the frame's own
  `error_bad_fcs`, on the same cycle as its `tlast` (packet §4.3) — is still presented
  on the window's **first** cycle, and is zeroed at that cycle's own edge. **One added
  high cycle**, which is `D-K4b`.

This is member **α** of the class as `AP` §4.K states it through the packet:
*"presenting a pre-clear strobe inside the window"*. Member **β** (holding it
suppressed and re-presenting on the release cycle) is not rendered, and §5's `D-K4a`
says so.

**Why this is a class and not a scope violation, in one sentence**: the diff cannot
raise a strobe on any cycle at which `clear` is 0, so its whole reachable surface is
`{ the two units that drive clear during a schedule } × { cycles inside a window }`,
and at `M03-K2` the surface is empty because nothing is consumed on the cycle before
that window (the frame is mid-flight and owes no report) — which is why this class is
`M03-K1`'s and only `M03-K1`'s.

**Rejected**: carrying the *output* strobe rather than the report term, i.e. adding
the register after 1000–1004. Five separate edits for one class, and the carried value
would then include `q_strobe`'s in-word path, which reports frames this class has
nothing to say about. **Rejected**: a level held across the window. It is the same
class (`D-K4b` says so), it costs a `reg_fb` and a second conjunct, and it makes the
sealed count a function of the window's *length* rather than of the defect.

### 2.5 IC-K5 — the `clear` window is honoured one cycle LATE at both edges

```diff
@@ -229,6 +229,8 @@ let index_of_onehot v = Signal.uresize (Signal.onehot_to_binary v) 4

 let create (scope : Scope.t) (i : Signal.t I.t) : Signal.t O.t =
   let open Signal in
+  let clear_late = ~:(reg (Reg_spec.create ~clock:i.clock ~clear:i.clear ()) vdd) in
+  let i = { i with I.clear = clear_late } in
   let spec = Reg_spec.create ~clock:i.clock ~clear:i.clear () in
   let sm = Always.State_machine.create (module State) spec in
   let lanes = decode_lanes i.xgmii_rx in
```

REQ-009's clause has two conjuncts — *"on every cycle in which `clear` = 1 **and on the
first cycle in which it is 0**"* — and a window shifted by one satisfies neither. **The
rendering shifts the whole gate, once, at its source**: `clear_late` is
*"the previous cycle's `clear`"* (a register with constant-1 data and the design's own
clear reads 0 exactly after a cleared cycle, so its complement is the delayed clear),
and rebinding `i` retargets **every** consumer — `spec`'s register clear at 232 and all
eight combinational gates — to the delayed value in one edit. Shifting only the
register side, or only the output gates, would be a *partial* shift: a different defect
with no sentence of REQ-009 behind it.

**This class is the round's own measurement of a derivation this programme argued and
never ran.** `WO-0072` §7.5 withdrew a class from `M03-K1` on an argument from the
stimulus; `IC-K5` is that design, seeded against `M03-K2`, and §7's rule fixes
`M03-K1` **green** before the run. A kill at `M03-K2` is `M03-K2`'s and never
`M03-K1`'s (packet §5 item 9), and this manifest makes no claim on the withdrawn row
in either direction.

**What it does to the reset pulse, quoted in cycles** (`D-K5b`, the conjunct the
packet says decides whether this is a class or a scope violation): the pulse cycle
behaves **un-cleared** — harmless, because every register is at its power-up zero and
the driven word is idle — and **cycle 0** behaves **cleared**, which is invisible for a
reason REQ-009 itself supplies: cycle 0 *is* the pulse's release cycle, on which the
requirement already demands `tvalid` = 0 and every strobe 0. From **cycle 1** onward
`clear_late` is 0, and cycle 1 is where the earliest start character in the whole bench
sits (packet §4.2). **The shift therefore pushes the reset's effect onto cycle 0 and
never onto cycle 1**, which is the half of `D-K5b`'s test that must come out this way.

**Rejected**: `Reg_spec.create ~clock:i.clock ()` for the delay flop — a clear-free
register would give `clear_late` = `clear`(t−1) exactly, with no power-up special
case, but it introduces an API form the parse check cannot confirm and buys a
difference only on the pulse cycle, which is unobservable in both readings. The
complement-of-`reg spec vdd` form uses only constructs the base file already contains.
**Rejected**: shifting `i.clear` at each of the nine consumer sites separately. Nine
hunks, one class, and any drift between them is a partial shift no requirement
describes.

### 2.6 IC-K6 — `clear` gates the state machine but not the output stream (`WO-0072` §9's **D3**)

```diff
@@ -973,7 +973,7 @@ let create (scope : Scope.t) (i : Signal.t I.t) : Signal.t O.t =
     mux2 emit_last_a (pc -: strip) (mux2 emit_last_b (pc -: strip +: nc) pc)
   in
   let abort = sel_bad_fcs |: sel_error |: sel_start |: sel_oversize |: sel_runt in
-  let tvalid = (emit_full |: emit_tlast) &: ~:(i.clear) in
+  let tvalid = ((emit_full |: emit_tlast) &: ~:(i.clear)) |: (have_word &: i.clear) in
   consume <== (sel_valid &: (emit_tlast |: sel_is_r2));
```

REQ-009's **first** clause alone: *"On every cycle in which `clear` = 1 … every
`tvalid` output SHALL be 0"*. The state machine still goes to `Idle` (232 untouched),
the record still records no closure (377 untouched), no strobe pulses (990, 991
untouched) and **no `tlast` is emitted** (997 untouched) — the word already formed for
the in-flight frame is simply presented. `WO-0072` §9's own text is the separation:
*"Distinct from D1 because a leaked word is not a phantom frame and the two have
different root causes"*, and here that distinction is one disjunct at one line versus
two at another.

`tvalid` has exactly one reader — the output record at 993 — so this diff, like
`IC-K1`'s, moves nothing internal. Exactly **one** cycle leaks (the window's first,
where the emission register still holds its pre-window word; every later window cycle
finds it cleared), and the **release** cycle does not leak, because `have_word` reads
`pc`, and `al_keep_d` is zero there. `D-K6a` is answered from the mechanism rather
than from a run.

**Rejected**: removing `&: ~:(i.clear)` from 976 outright. It is the smaller edit and
it renders **nothing** at a lane-4-started frame: `bubble` forces `al_keep` to zero
under an idle word at offset 4, so `ev12` and therefore `decided` are low on the
window's first cycle and no arm of the emission decision fires. The disjunctive form
is one token longer and is offset-independent, which is the difference between a class
and a coin toss.

### 2.7 IC-N1 — every control lane is routed against the state the word STARTED in

```diff
@@ -362,7 +362,7 @@ let create (scope : Scope.t) (i : Signal.t I.t) : Signal.t O.t =
     a_open &: (cap_end <: a_char_end) &: (cap_end <: a_hold_end) &: (cap_end <:. 8)
   in
   let a_char_acts = a_open &: ~:a_close_oversize in
-  let a_closes_with v = a_char_acts &: any (v &: a_close_oh) in
+  let a_closes_with v = a_char_acts &: any v in
   let a_close_terminate = a_closes_with lanes.is_terminate in
```

**`a_close_oh` is where this design realises *"the state as the earlier lanes of that
same word have left it"*.** `lowest_set` marks the one closure character that acts on
epoch A; every character above it belongs to a frame epoch A is no longer, which is
§9's clause (a) — *"each event is evaluated at its own octet time"* — compiled to a
lane search. **Deleting the `&: a_close_oh` conjunct is that sentence deleted**: every
control lane of the word is now routed against the state epoch A was in when the word
began.

At `M03-N1` that is exactly the row's own Kills cell: the `/E/` five octet times after
the frame's own `/T/`, in the same input word, is routed to REQ-105 against a `Frame`
state the `/T/` has already left, and the frame's closure record gains an `error` bit
it should not have. The **coverage** arithmetic is untouched — `a_char_end` (316–318)
reads `a_close_oh` directly and is not routed through `a_closes_with` — so the frame's
delivered word count, its cycles, its final `tkeep` and its octets are bit-identical;
what moves is the record, hence one added `error_bad_frame` and `tuser`[0] on the
frame's own `tlast` word. §5's `D-N1c` states that in its own words and declares the
branch.

**This is `D-N1b`'s reading (b), and the choice is deliberate rather than incidental.**
Reading (a) — freeze the state for the whole word — additionally silences the in-word
epochs, because a lane-4 `/S/` or a preamble-position control character would then be
evaluated against the `Idle` the word began in; that is the wider design, and its extra
reds are **removals** at family-B geometries. Reading (b) fails to apply an *earlier
lane's exit* and leaves the in-word epochs alone. **Every unit reddened by (b) is
reddened by (a)**, so whichever branch the seal's rule was written for, §11's `⊆`
requirement holds; and (b) is the narrower blast radius, which §16 item 7 says is the
thing standing between one class and a breadth claim.

**Rejected**: adding the mis-routed report at `error_bad_frame` (1001) instead, to keep
`tuser` still and land branch α exactly. The report would have to be delayed to the
frame's own `tlast` cycle to be a report at all (§9's pinned cycle), which needs a
private two-stage path beside the record — a bigger diff that renders a *reporting*
defect rather than a *routing* one, and this class is named for the routing.

### 2.8 IC-N4a — the refused start character does not abort the in-flight frame

```diff
@@ -310,7 +310,10 @@ let create (scope : Scope.t) (i : Signal.t I.t) : Signal.t O.t =
      lanes. An other-control character closes it only in a preamble position
      (REQ-102 → REQ-105); elsewhere it is the REQ-016 hold, below. *)
   let a_closing_v =
-    lanes.is_terminate |: lanes.is_error |: lanes.is_start |: (other_ctl &: a_pre_mask)
+    lanes.is_terminate
+    |: lanes.is_error
+    |: (lanes.is_start &: repeat i.cfg_rx_enable 8)
+    |: (other_ctl &: a_pre_mask)
   in
```

The base file names this exact edit as the thing it is **not** doing. Its comment at
413–417 reads: *"`cfg_rx_enable` gates only the beginning of a frame … which is why
`a_closing_v` above tests `lanes.is_start` **ungated** while the two epochs below are
gated"*. **The rendering gates it** — the rejected reading ADR-0014 prices, reached by
adding the enable to one of four terms in one vector.

**Required consequence, term by term**: with the enable low, the refused `/S/` is no
longer in `a_closing_v`, so `a_close_oh` does not mark its lane, so (i) `a_char_end`
(316–318) no longer stops coverage there and the open frame absorbs the refused
frame's octets — the delivered stream gains cycles the row's own list does not
contain — and (ii) `a_close_start` (375) is 0, so no `error_start_without_terminate` is
recorded for the abort. The rendering is **exactly** ADR-0014's rejected reading in
both of its priced consequences, and neither is bolted on.

**`D-N4a-1`'s question — what the refused start's own octet position forwards — is
answered by the same deletion**: the `/S/` lane is neither a closure (removed from
`a_closing_v`) nor a hold (`a_hold_v` at 328 reads `other_ctl`, which excludes
`is_start` by construction at 244), so **the control character's own data value is
forwarded as a frame octet** and the frame's octet count advances through it and
through every lane above it. The specification fixes nothing here because under it the
character is never forwarded at all — which is why §11 seals the affected quantity as
an inequality with a direction, and this is the disclosure that pins the rendering.

**Byte-identical at `Enable.high`**: `repeat i.cfg_rx_enable 8` is `0xff` when the
enable is 1, and `v &: 0xff` = `v`. Fifty-five of the fifty-nine M03 units and all
seventy-nine non-M03 behavioural units are protected structurally, not by care.

**Rejected**: gating `a_close_start` (375) alone. It removes the report and leaves the
abort, which is neither half of the row's reading (ii) and would collide with `IC-N4b`
at the same observable. **Rejected**: gating `a_char_end` (316). Same observable, but
it moves the truncation without moving the closure, so the frame would run on
**and** still be reported — a design no reading of REQ-810 produces.

### 2.9 IC-N4b — the report path is gated by the enable (`FINDING J-2`'s named carrier)

```diff
@@ -987,8 +987,8 @@ let create (scope : Scope.t) (i : Signal.t I.t) : Signal.t O.t =
      no octet (REQ-108's count never advances there, and §9's ninth ruling
      leaves such a frame with no FCS to check). Their union is therefore a
      one-term union and is written as one. *)
-  let strobe s = consume &: s &: ~:(i.clear) in
-  let q_strobe k = bit q2 k &: ~:(i.clear) in
+  let strobe s = consume &: s &: ~:(i.clear) &: i.cfg_rx_enable in
+  let q_strobe k = bit q2 k &: ~:(i.clear) &: i.cfg_rx_enable in
```

REQ-810's three prohibitions read **unscoped**: *"no strobe is emitted on any
receive-path stream while `cfg_rx_enable` = 0"*, including a report owed by a frame
admitted while the enable was 1. **Both report paths are gated, because the class's own
sentence says *any* receive-path stream** — 990 is epoch A's aged-record path and 991
is the in-word path for a frame opened and closed in one word, and gating only the
first would render *"the epoch-A report path is gated"*, which is a narrower claim than
the reading ADR-0014 rejects.

**The delivered stream does not move at all**, and that is checkable rather than
asserted: `strobe` and `q_strobe` are read at 1000–1004 and nowhere else, so
`tvalid`, `tdata`, `tkeep`, `tlast` and `tuser` cannot see this diff. Frame A's single
aborted word and frame C's eight stay exactly where they are, with the same `tkeep`,
the same `tlast` and the same `tuser` — which is the required consequence stated as a
property of the reader set.

**Sampled, not latched** (`D-N4b-2`): both gates read `i.cfg_rx_enable` combinationally
on the cycle the strobe would pulse. The latched-at-admission variant would suppress
nothing at this stimulus — the frame was admitted while the enable was 1 — and would
have been `NOT SEEDED`.

**This class measures `FINDING J-2` from a run rather than from an argument**, and its
green is as load-bearing as its red: `M03-J3`'s in-flight frame is clean and owes no
report, so this diff cannot reach it, while `M03-N4`'s in-flight frame owes one.

**Rejected**: gating `consume` (977). It is read by the record ageing at 526–527, so
gating it would strand records and change **which cycle** later reports pulse on — a
report-path defect with a datapath signature, outside the permission list.

---

## 3. R-DISC-2 — the gate inventory, five paths, with cross-class facts tabulated

`R-DISC-2` (`DISP-0001` §4): *"any signal named in more than one class entry gets one
row in a gate-inventory table carrying its full term list and every claim each class
makes about it. A fact one entry relies on and another entry contradicts is a blocking
defect in the manifest, repaired before delivery."* The packet fixes the inventory at
five paths (§6) and predicts the shape; both are discharged here **before delivery**.

### 3.1 The admission path — a start character's acceptance

| | |
|---|---|
| **full term list** | `b_exists = bit lanes.is_start 0 &: i.cfg_rx_enable &: ~:(i.clear)` (421); `c_exists = bit lanes.is_start 4 &: i.cfg_rx_enable &: ~:(i.clear)` (422); `survivor_b/c` (428, 429); `begins` (430); `to_preamble = begins` (609); the `Always` switch's four `to_preamble` arms (614, 617, 627, 637); the reloads `crc_reg`/`count` (478, 479) and `frame_start4` (432) |
| **IC-K3** | **adds one conjunct** to 421 and 422: `&: settled`, where `settled = reg spec vdd`. Claims the enable and clear conjuncts are unchanged and that nothing below 422 is edited |
| **IC-K5** | **reaches 421 and 422 through `i.clear`**, whose value is now `clear_late`. Claims no textual edit at either line and no change to the enable conjunct |
| **IC-N4a**, **IC-N4b**, **IC-K1**, **IC-K2**, **IC-K4**, **IC-K6**, **IC-N1** | do not touch this path |
| **cross-class fact** | IC-K3 and IC-K5 **both** delay admission across a `clear` release, by different terms and with different reach: IC-K3's `settled` is read at 421/422 **only**; IC-K5's `clear_late` is read at every one of the nine `i.clear` sites. **No contradiction**: neither claims the other's term is unchanged, and the two are separable by any observable outside admission (§7) |

### 3.2 The emission path — the output-word path

| | |
|---|---|
| **full term list** | `have_word` (831); `ev12` (955); `closed`/`closure_aligned`/`decided` (956–958); `emit_last_a`, `emit_last_b`, `emit_full`, `emit_tlast` (959–963); `hold` (971); `keep_count` (972); `tvalid` (976); the record's `tvalid`, `tdata`, `tkeep`, `tstrb`, `tlast`, `tuser` (993–998) |
| **IC-K1** | **adds a disjunct** to the record's `tvalid` **and** to `tlast` (993, 997): `have_word &: i.clear` in both. Claims 976 is untouched, `emit_tlast` is untouched, and nothing internal reads either field |
| **IC-K6** | **adds a disjunct** to `tvalid` at **976**: `have_word &: i.clear`. Claims 997 is untouched, so no `tlast` is added |
| **IC-K5** | **reaches 971, 976 and 997 through `i.clear`**. Claims no textual edit at any of them |
| **IC-N4a** | reaches this path **indirectly and only through coverage**: `a_closing_v` feeds `a_char_end` → `cov_end` → `cov`, so the delivered stream of a frame open across a refused start character lengthens. Claims no edit at any term in this list |
| **IC-N1** | does **not** reach this path: `a_char_end` reads `a_close_oh` directly, not `a_closes_with` |
| **cross-class fact** | IC-K1, IC-K6 and IC-K5 **all** touch the emission path's clear gate — exactly the shape the packet's §6 predicted. **They are three different edits at three different lines**: IC-K6 at 976, IC-K1 at 993 + 997, IC-K5 at the source of `i.clear`. `WO-0073-VERDICT` §7 Q4 governs — **a shared path is not a combined diff**, and nine separate diffs remain mandatory |
| **cross-class fact** | IC-K1 and IC-K6 both add the **same** term `have_word &: i.clear`. IC-K1 adds it to `tvalid` **and** `tlast`; IC-K6 adds it to `tvalid` **only**. Their observables therefore differ by exactly one bit on one cycle — `tlast` — which is `WO-0072` §9's own D1/D3 distinction and the only thing that separates them at the scored cell |

### 3.3 The report path — the five strobes' enables

| | |
|---|---|
| **full term list** | `consume` (518 wire, 977 assign); `strobe s = consume &: s &: ~:(i.clear)` (990); `q_strobe k = bit q2 k &: ~:(i.clear)` (991); `inword_strobes` (570–582); `q2` (583–590); the five record fields (1000–1004); the record bits `sel_bad_fcs`/`sel_error`/`sel_start`/`sel_oversize`/`sel_runt` (529–534) |
| **IC-K2** | **adds a disjunct** to `error_oversize` at **1003**: `a_open &: i.clear`. Claims 990 and 991 are untouched and that no other strobe field is edited |
| **IC-K4** | **adds a disjunct inside `strobe`** at **990**: `reg spec (consume &: s) &: i.clear`, instantiated once per call site. Claims the conformant disjunct is byte-identical, and that 991 and 1000–1004 are untouched |
| **IC-N4b** | **adds a conjunct** to `strobe` **and** to `q_strobe` at **990 and 991**: `&: i.cfg_rx_enable`. Claims 1000–1004 are untouched and no delivered-stream term is reached |
| **IC-N1** | reaches this path **through the record**: `a_closes_with` sets the `error` bit, which `sel_error` carries to `error_bad_frame` (1001) on the frame's pinned cycle. Claims no edit at any term in this list |
| **IC-N4a** | reaches this path **subtractively and through the record**: the `start` bit is never set, so `error_start_without_terminate` does not pulse for the abort. Claims no edit at any term in this list |
| **cross-class fact — the one the packet named** | IC-K2, IC-K4 and IC-N4b all touch the report path, **two under `clear` and one under the enable**, precisely as §6 predicted. **IC-K4 and IC-N4b both edit line 990** and their claims about it are compatible rather than contradictory: IC-K4 says the conformant term `consume &: s &: ~:(i.clear)` is unchanged and disjoins a clear-gated carry; IC-N4b says the same term gains one conjunct `&: i.cfg_rx_enable` and disjoins nothing. **Neither entry relies on a fact the other denies** — IC-K4 makes no claim about the enable, IC-N4b makes none about a carry — and the two diffs are textually incompatible as one hunk, which is what makes them two branches and not a combined diff |
| **cross-class fact** | IC-K2 and IC-K4 both add a strobe **inside a `clear` window**. They are distinguishable by **which strobe and on what evidence**: IC-K2's is `error_oversize`, gated on a frame being open (`a_open`), and fires at `M03-K2`; IC-K4's is whichever name was consumed on the cycle before the window, gated on a carry register, and fires at `M03-K1`. **Their reachable cells are disjoint**, which §4 discharges term by term |

### 3.4 The state path — the state machine's reset

| | |
|---|---|
| **full term list** | `spec = Reg_spec.create ~clock:i.clock ~clear:i.clear ()` (232); `sm` (233); the `Always` switch (611–647); `to_discard` (610); every `reg spec` in the module (11 sites) |
| **IC-K5** | **replaces the clear source** at 232 with `clear_late`, so every register in the module — state, record, payload, alignment, CRC and count — clears one cycle late. Claims the switch's arms (611–647) are untouched |
| **IC-K3** | **adds a register** on this path (`reg spec vdd`) but does not change the clear source, and reads the new register only at 421/422 |
| **IC-K4** | **adds registers** on this path (`reg spec (consume &: s)`, one per call) and does not change the clear source |
| **all others** | do not touch this path |
| **cross-class fact** | IC-K3, IC-K4 and IC-K5 all instantiate or re-source `spec`. **No contradiction**: IC-K3 and IC-K4 rely on `spec`'s clear being `i.clear` (that is what makes `reg spec vdd` the "previously cleared" signal and what zeroes the carry at the window's end); IC-K5 *changes* it, and makes no claim about either added register because neither exists in its diff |

### 3.5 The abort path — REQ-110's `Frame`-exit on a start character

| | |
|---|---|
| **full term list** | `a_closing_v` (312–314); `a_close_oh` (315); `a_char_end` (316–318); `a_char_acts` (364); `a_closes_with` (365); `a_close_terminate`/`a_close_error`/`a_close_start` (366–375); `a_close_char` (376); `a_close_now` (377); the record `r0` (506–515); `abort` (975); `tuser` (998) |
| **IC-N4a** | **removes the `/S/` from `a_closing_v` while the enable is 0** (312–314). Claims `a_closes_with` (365) is unedited and that the removal reaches `a_close_start` only through `a_close_oh` |
| **IC-N1** | **removes the `a_close_oh` conjunct from `a_closes_with`** (365). Claims `a_closing_v` (312–314) and `a_char_end` (316–318) are unedited, so coverage is unmoved |
| **IC-K1**, **IC-K6** | make **no** claim on this path; both are downstream of the record and add output terms only |
| **cross-class fact — the one to read twice** | IC-N1 and IC-N4a both act on the epoch-A closure search, **four lines apart**, and their claims about `a_close_oh` are **complementary, not contradictory**: IC-N4a changes **what enters** the search (the vector `a_closing_v`), IC-N1 changes **what the search's result is used for** (the route conjunction). Each entry's discharge at §4 evaluates the other's term at its base value and neither relies on the other's edit. **They are separable at every stimulus**: IC-N4a is inert at `Enable.high` (55 of 59 M03 units), IC-N1 is inert at any word carrying one control character or none |

---

## 4. R-DISC-1 — reachability discharged per class, per lane, at the firing cycle

`R-DISC-1`: name the gate signal, quote its **complete** defining expression from the
base file with line numbers, evaluate **every** conjunct on the named stimulus at the
claimed firing cycle, and call out the conjuncts contributed by the **stimulus** rather
than by the mutation. A conjunct that cannot be discharged makes the class
`NOT SEEDED` **here**, by me, not by the adjudicator afterwards.

### 4.0 The cycle facts, and the one thing I had to derive

**§6 demands four cycle facts for every K class**: (a) the cycles at which the driven
`clear` is high; (b) the release cycle; (c) what is pending on the cycle immediately
before the window opens; (d) whether any cycle in `[window first − 1, release]` carries
a start character. **I am blinded from the bench** (§0), so these come from the
packet's freely-told text or they are parameterised — never from a file I may not read.

**`M03-K2`, derived**: the packet's front matter quotes `WO-0072` §9's three tells
verbatim — **D1** *"a `tlast` = 1 delivered word inside cycles 6 … 11"*, **D3**
*"`tvalid` = 1 or any strobe high on a cycle in 6 … 11"*, **D2** *"frame B absent,
short, or delivered on cycles other than 14 … 21"* — and §16 item 5 states the window
is **five cycles**, closing on a cycle carrying a start character. Five cycles inside
`6 … 11` with the release cycle carrying frame B's start character gives

```
  (a) clear high on cycles  6, 7, 8, 9, 10        (five)
  (b) release cycle          11                    (first cycle at which clear is 0)
  (c) pending at cycle 5     a frame in flight with six output words still to come
                             (§5 item 1), i.e. the emission register is loaded and
                             no closure record exists
  (d) start characters in [5, 11]:  exactly one, frame B's, ON the release cycle 11
                             — §6's "the distance is zero"
```

and the cross-check closes it: ΔC = 3 at **both** start lanes (§7's pinned table), so a
frame admitted at cycle 11 delivers its first word at **14**, which is the low end of
D2's own `14 … 21`, and its eight words run to **21**, which is the high end. **Three
independently quoted figures agree**, so I take the derivation as sound and raise it as
**RN-1** rather than rely on it silently.

**`M03-K1`, parameterised**: the packet gives the geometry but no cycle numbers. Write
the window as `[W, W + n − 1]` and the release as `R = W + n`. Then, from §4.3 and §5
item 1 as measured by dv_lead at this tree: (c) the cycle `W − 1` carries the frame's
own `tlast` **and** its `error_bad_fcs`, and nothing else is pending; (a) every input
word in `[W, R]` is idle; (d) `[W − 1, R]` contains **no** start character — the
schedule's only one is at cycle 1. Every `M03-K1` discharge below is evaluated at
`W − 1`, `W` and `R` symbolically and depends on no absolute cycle.

**The N units' two cycle facts** (§6): the enable's change cycles are the bench's and I
am blinded from them; what both N classes need is only that (i) the 1 → 0 change lands
**at least one cycle before** the refused start character — which §6.3 item 7 /
**C-14.5** requires of any conformant bench, and which the packet's §5 item 5
derivation depends on — and (ii) the observable each class moves is produced at or
after that start character's own word. Both are stimulus-contributed and neither is
mutation-contributed.

### 4.1 IC-K1 — one member (`M03-K2`), firing cycle 6

| conjunct | source | value at cycle 6 |
|---|---|---|
| `have_word = (pc <>:. 0) &: ~:fcs_tail_now` (831) | base | **1**. `pc = popcount al_keep_d` (795), and `al_keep_d` is the aligned word loaded at the cycle-5 edge; the frame is mid-flight with six output words still to come (**stimulus**), and gapless flow leaves `advance = ~:hold` high at cycle 5, so `al_keep_d` = the next full aligned word. `fcs_tail_now` (830) is `emit_last_b` registered, which is 0 mid-frame |
| `i.clear` | **stimulus** | **1** — cycle 6 is the window's first cycle |
| `tvalid`'s first disjunct `(emit_full \|: emit_tlast) &: ~:(i.clear)` (976) | base | **0** — the clear gate |
| `tlast`'s first disjunct `emit_tlast &: ~:(i.clear)` (997) | base | **0** — the same |
| ⇒ record `tvalid` (993) | **mutation** | **1** |
| ⇒ record `tlast` (997) | **mutation** | **1** |
| `tkeep = keep_of_count keep_count` (995, 972) | base | `keep_count` = `pc` because `emit_last_a` (959) and `emit_last_b` (960) are both conjoined with `decided` and `closed`, and `sel_valid` is 0 (no closure record: 377 is clear-gated) ⇒ `tkeep` = `0xFF` |
| `tuser = emit_tlast &: abort` (998) | base | **0** — `emit_tlast` is unmoved by this diff |
| every strobe (1000–1004) | base | **0** — `consume` (977) needs `sel_valid`, which is 0 |

**Firing cycle 6, with `tlast`.** Cycles 7–10: `al_keep_d` was zeroed at the cycle-6
edge by `spec`'s clear, so `pc` = 0, `have_word` = 0 and nothing further is presented.
Cycle 11 (release): `have_word` = 0 for the same reason, and `i.clear` = 0, so both
added disjuncts are 0. **Exactly one added delivered word, carrying `tlast`, inside
`6 … 11`** — `WO-0072` §9's **D1** tell.

**The stimulus-contributed conjunct, called out**: `have_word` at cycle 6 is the
stimulus's, not the mutation's. If the bench's window opened on a cycle at which the
emission register happened to be empty, this class would render nothing at this unit —
that is a property of the placement, and §5 item 1's *"six output words still to
come"* is what discharges it. **Lane**: the K units have one member each (§6), so
there is no second lane to evaluate.

### 4.2 IC-K2 — one member (`M03-K2`), firing cycle 6

| conjunct | source | value at cycle 6 |
|---|---|---|
| `a_open = in_preamble \|: in_frame` (296) | base + stimulus | **1** — frame A is in flight; the state register still holds `Frame` on the window's first cycle and is cleared at that cycle's edge |
| `i.clear` | **stimulus** | **1** |
| `strobe sel_oversize` (1003, 990) | base | **0** — `consume` needs `sel_valid`; no record exists |
| ⇒ `error_oversize` | **mutation** | **1** |
| cycles 7–10 | base | `a_open` = 0 (state cleared to `Idle` at the cycle-6 edge) ⇒ **0** |
| cycle 11 | base | `i.clear` = 0 ⇒ **0** |
| every delivered word | base | unmoved — no term in the emission path is edited |

**One high cycle, at cycle 6, on the name `error_oversize`.** At `M03-K1` the same
gate is evaluated at `W`: `a_open` is **0** there, because the frame closed before the
window opened (§4.3 — its `tlast` and `error_bad_fcs` landed at `W − 1`), so the class
**cannot** fire at that unit. That is the disjointness §3.3's last row asserts,
discharged rather than assumed.

### 4.3 IC-K3 — one member (`M03-K2`), firing cycle 11

| conjunct | source | value at cycle 11 |
|---|---|---|
| `bit lanes.is_start 0` / `bit lanes.is_start 4` (421/422, 184–194) | **stimulus** | **1** at frame B's own start lane — cycle 11 carries frame B's start character (§6: *"the release cycle IS a start character's cycle and the distance is zero"*) |
| `i.cfg_rx_enable` | **stimulus** | **1** — `M03-K2` is not an enable-driving unit (§3.3's census: the clear-driving and enable-driving sets have empty intersection) |
| `~:(i.clear)` | **stimulus** | **1** — cycle 11 is the release cycle |
| `settled = reg spec vdd` | **mutation** | **0** — `clear` was high at cycle 10, so the register is zeroed at the cycle-10 edge |
| ⇒ `b_exists`/`c_exists` | **mutation** | **0** ⇒ `begins` (430) = 0 ⇒ `to_preamble` (609) = 0 ⇒ the state machine stays in `Idle` |
| frame B thereafter | consequence | **no output word anywhere in the run** — the schedule contains no later start character, so nothing re-admits it |

**`D-K3a` = refused entirely**, and the tell is `WO-0072` §9's **D2** in its first
disjunct (*"frame B absent"*). At `M03-K1` the same gate is evaluated at `R`: `[W − 1,
R]` carries **no** start character (§4.3), so `bit lanes.is_start k` = 0 and the class
cannot fire — `M03-K1` green. **At every unit in the repository that drives
`Clear.never`**, `settled` is 0 on cycle 0 alone and `bit lanes.is_start k` is 0 there
(packet §4.2, measured), so the conjunction is 0 in both designs.

### 4.4 IC-K4 — one member (`M03-K1`), firing cycle `W`

| conjunct | source | value at cycle `W` |
|---|---|---|
| `reg spec (consume &: s)` with `s = sel_bad_fcs` | **mutation** | **1**. Its data input `consume &: sel_bad_fcs` is high at `W − 1`: §4.3 puts the frame's `tlast` **and** its `error_bad_fcs` on that cycle, and `consume <== sel_valid &: (emit_tlast \|: sel_is_r2)` (977) is what makes a strobe pulse at all. `spec`'s clear is sampled at the same edge and `clear` is **0** at `W − 1` (**stimulus** — the window has not opened), so the register loads rather than clears |
| `i.clear` | **stimulus** | **1** — `W` is the window's first cycle |
| `strobe`'s conformant disjunct `consume &: s &: ~:(i.clear)` (990) | base | **0** — the clear gate |
| ⇒ `error_bad_fcs` (1000) | **mutation** | **1** |
| cycle `W + 1` | base | the carry register is zeroed at the `W` edge (`clear` = 1 there) ⇒ **0**. **One added high cycle** |
| cycle `R` | base | `i.clear` = 0 ⇒ the added disjunct is 0 ⇒ **0** |
| the delivered stream | base | unmoved — `strobe` has five readers, all of them strobe fields (1000–1004) |

**The one conjunct that is the stimulus's and not the mutation's**: that *something is
consumed at `W − 1`*. §6 states it as measured — *"At `M03-K1` (c) is a strobe and
nothing else"* — and it is the whole reason this class is `M03-K1`'s. **At `M03-K2`
the same gate is evaluated at cycle 6 and the carry is 0**, because at cycle 5 the
frame is mid-flight, `sel_valid` = 0 and `consume` = 0: nothing is owed, so nothing is
carried. **The class cannot fire at `M03-K2`**, which is what keeps §12's four-class
collision at four.

**Both `D-K1b` conjuncts, structurally**: at `Clear.never` the added disjunct's last
conjunct `i.clear` is 0 on every cycle; at the reset pulse the carry register holds its
power-up 0 because no cycle precedes the pulse. **Neither is a measurement — both are
the shape of the term.**

### 4.5 IC-K5 — one member (`M03-K2`), firing cycles 6 and 11

`clear_late = ~:(reg (Reg_spec.create ~clock:i.clock ~clear:i.clear ()) vdd)`. The
inner register carries constant 1 and the design's own clear, so it reads 0 exactly on
a cycle whose predecessor was cleared; its complement is *"the previous cycle's
`clear`"*, with the single power-up exception discharged below.

```
 cycle    5   6   7   8   9  10  11  12
 clear    0   1   1   1   1   1   0   0     (stimulus: window 6…10, release 11)
 clear_late   0   0   1   1   1   1   1   0     shifted by one at BOTH edges
```

| firing cycle | conjunct | source | value |
|---|---|---|---|
| **6** (leading edge) | `~:(i.clear)` at 976/997/990/991/377, now `~:clear_late` | **mutation** | **1** — cycle 6 behaves **un-cleared** |
| | `have_word` (831) | base + stimulus | **1** (as §4.1) |
| | `decided = ev12 \|: closure_aligned` (958) | base + stimulus | `ev12 = ~:al_new &: bit al_keep 4` (955). **Offset-dependent**: at a lane-0-started frame A, `bubble` (732) is 0 and `al_keep` = `cov_d` = the previous word's full coverage ⇒ `ev12` = 1 ⇒ **a word escapes at the leading edge**; at a lane-4-started frame A, `bubble` = 1 forces `al_keep` = 0 ⇒ `decided` = 0 ⇒ `hold` = 1 and no word escapes. **Frame A's start lane is a bench fact I am blinded from — RN-2** |
| **11** (trailing edge) | `settled`-free admission: `b_exists`/`c_exists` (421/422) read `~:(i.clear)` = `~:clear_late` | **mutation** | **0** — cycle 11 behaves **cleared** ⇒ frame B's start character is not accepted ⇒ **frame B absent from the whole run** |

**So `IC-K5`'s red at `M03-K2` does not depend on RN-2**: the trailing-edge half fires
at either start lane, and the leading-edge half is an *additional* observable at one of
them. `D-K5a` = **both edges**, and the manifest says which half is offset-dependent
rather than letting a scorecard discover it.

**`M03-K1` green, derived**: at `W` the design behaves un-cleared, and a conformant
design produces nothing there either — the record was consumed at `W − 1` so
`sel_valid` = 0, and `al_keep_d` is empty because the frame's last word left at
`W − 1`, so `have_word` = 0. At `R` the design behaves cleared, and nothing was owed
there — `[W − 1, R]` carries no start character. **This is `WO-0072` §7.5's
*"invisible at `M03-K1`"* derivation, and this class is the first thing in the
programme that can measure it.**

**The reset pulse, in cycles** (`D-K5b`): the pulse cycle behaves un-cleared (every
register is at its power-up zero, the driven word is idle, nothing is pending);
**cycle 0** behaves cleared, which REQ-009 itself already requires of a conformant
design on a release cycle; **cycle 1** — the earliest start character anywhere in the
bench, packet §4.2 — behaves un-cleared and admits normally. The shift lands on cycle
0 and never on cycle 1.

### 4.6 IC-K6 — one member (`M03-K2`), firing cycle 6

Identical conjunct-by-conjunct to §4.1 with one difference: the added disjunct reaches
`tvalid` (976) **only**, so `tlast` (997) evaluates to `emit_tlast &: ~:(i.clear)` = 0
at cycle 6.

| | value at cycle 6 |
|---|---|
| record `tvalid` | **1** (mutation) |
| record `tlast` | **0** (base — the clear gate is intact) |
| `tkeep` | `0xFF` (as §4.1) |
| every strobe | 0 |
| cycles 7–10, and 11 | 0 — `have_word` = 0 after the cycle-6 edge; `i.clear` = 0 at 11 |

**`D-K6a` = one window cycle presents a word; the release cycle does not.** The tell is
`WO-0072` §9's **D3** — *"`tvalid` = 1 … on a cycle in 6 … 11, with no `tlast`"*.
`M03-K1`: `have_word` = 0 at `W` (§4.5), so green.

### 4.7 IC-N1 — two members (lane 0 and lane 4), firing at the `/E/`'s own word

**Gate**: `a_close_error = a_closes_with (lanes.is_error |: (other_ctl &: a_pre_mask))`
(372–374), whose definition after the mutation is
`a_char_acts &: any (lanes.is_error |: (other_ctl &: a_pre_mask))`.

| conjunct | source | value |
|---|---|---|
| `a_char_acts = a_open &: ~:a_close_oversize` (364) | base + stimulus | **1** — the frame is open on entry to this word, and no REQ-108 truncation is in play at a 64-octet stimulus |
| `any lanes.is_error` (192, 219) | **stimulus** | **1** — the word carries an `/E/` |
| `&: a_close_oh` | **deleted by the mutation** | in the base this is **0**, because `a_close_oh = lowest_set a_closing_v` (315) marks the `/T/`, which lies **below** the `/E/` |
| ⇒ `a_close_error` | **mutation** | **1** where the base has 0 |
| ⇒ `r0`'s `error` bit (506–515) | consequence | set, alongside the `terminate` bit the base already sets |
| ⇒ `sel_error` (530) at the frame's `tlast` cycle | consequence | 1 ⇒ `error_bad_frame` (1001) pulses **once**, on §9's pinned cycle, and `abort` (975) ⇒ `tuser`[0] = 1 on that word |
| `a_char_end` (316–318), `cov_end` (353), `cov` (382) | base | **unmoved** — they read `a_close_oh` directly, so the frame's coverage, word count, cycles and final `tkeep` are bit-identical |
| `strip` (800) | base | **unmoved** — `sel_terminate` is still 1, so `strip` is still 4 and the FCS is still removed |

**Per-lane discharge, and it is the same discharge twice.** The mutated gate contains
**no lane index and no lane mask**: it is `a_char_acts &: any v`, a reduction over all
eight lanes. Whichever lane the frame's `/T/` occupies and whichever lane the `/E/`
occupies, the gate's value depends only on *"epoch A is open on entry and the word
carries an error character"*. **Both the lane-0 and lane-4 members are therefore
discharged by construction**, and neither is `NOT SEEDED` for want of an evaluation.
The packet's §5 item 8 says the lane-4 member is **shadowed** in a
passing-to-failing run because lane 0 raises first; it is recorded **unobserved**,
never as a miss and never as a pass.

**The conjunct that protects every idle word in the suite, called out because it is the
whole MUST-STAY-GREEN argument**: `a_char_acts` requires `a_open`. An idle word
**outside** a frame reaches this gate with `a_open` = 0. An idle word **inside** a
frame carries eight `other_ctl` lanes and **no** `lanes.is_error`, and `other_ctl &:
a_pre_mask` is non-zero only in a preamble position at a lane-4 start — so the mutated
`any v` is 0 there, exactly as the base's `any (v &: a_close_oh)` is. **The mutation is
inert at every word carrying one control character or none.**

### 4.8 IC-N4a — two members (lane 0 and lane 4), firing at the refused `/S/`'s word

**Gate**: `a_closing_v` (312–314) → `a_close_oh = lowest_set a_closing_v` (315) →
`a_char_end` (316–318) and `a_close_start = a_closes_with lanes.is_start` (375).

| conjunct | source | value at the refused start's word |
|---|---|---|
| `bit lanes.is_start k` | **stimulus** | **1** — the word carries the aborting `/S/` |
| `i.cfg_rx_enable` | **stimulus** | **0** — the bench has driven the 1 → 0 change at least one cycle earlier (§6.3 item 7 / **C-14.5** forbids a same-cycle change, so every conformant bench does) |
| `repeat i.cfg_rx_enable 8` | **mutation** | `0x00` ⇒ the `/S/` lane is **not** in `a_closing_v` |
| `a_close_oh` at the `/S/` lane | consequence | **0** ⇒ `a_close_start` (375) = 0 ⇒ **no `error_start_without_terminate`** for the abort |
| `a_char_end` (316–318) | consequence | no longer stops at the `/S/` lane; the next closure above it, or 8, governs ⇒ `cov_end` (353) rises ⇒ the open frame **covers the refused start's own octet position and every lane above it** |
| `a_hold_v = other_ctl &: ~:a_pre_mask` (328) | base | **0 at the `/S/` lane** — `other_ctl` (243–245) excludes `is_start` by construction, so the lane is not a hold either and its **data value is forwarded as a frame octet** (`D-N4a-1`) |
| ⇒ delivered-sample cycle list at `M03-N4` | consequence | a **strict superset** of the base's: the frame delivers the words it would have delivered under `Enable.high` |
| frame C | base | untouched — admitted after the enable returns to 1, through gates this diff does not edit |

**Per-lane discharge.** The mutated term `lanes.is_start &: repeat i.cfg_rx_enable 8`
is an eight-lane vector operation with no lane index in it: at the lane-0 member the
`/S/` sits in `lanes.is_start` bit 0, at the lane-4 member in bit 4, and the conjunction
masks **both** identically. **Both members are discharged**; the lane-4 member is
recorded **unobserved** per §5 item 8.

**The stimulus conjunct that bounds the blast radius**: `i.cfg_rx_enable` = 0. The
packet's §3.2 census names the only four units that drive the enable away from
`Enable.high` — `M03-J1`, `M03-J2`, `M03-J3`, `M03-N4` — and of those only a unit whose
frame is **open across a refused start character** can reach this gate at all.

### 4.9 IC-N4b — two members (lane 0 and lane 4), firing at frame A's own report cycle

**Gate**: `strobe s = consume &: s &: ~:(i.clear) &: i.cfg_rx_enable` (990).

| conjunct | source | value at frame A's report cycle |
|---|---|---|
| `consume = sel_valid &: (emit_tlast \|: sel_is_r2)` (977) | base | **1** — the record born at the aborting `/S/`'s word is consumed on frame A's `tlast` cycle (§9's pinned cycle) |
| `s = sel_start` (531) | base | **1** — the abort was recorded under REQ-110 |
| `~:(i.clear)` | **stimulus** | **1** — `M03-N4` is not a clear-driving unit (§3.3's census: empty intersection) |
| `i.cfg_rx_enable` | **stimulus** | **0** — the report is owed at a cycle at which the enable is still 0. **This is the conjunct the class exists to test and it is the stimulus's, not the mutation's** |
| ⇒ `error_start_without_terminate` (1004) | **mutation** | **0** where the base has **1** — a strobe count **below one**, which is §11's sealed direction |
| the delivered stream | base | unmoved at every word — `strobe`/`q_strobe` have five readers and all five are strobe fields |
| at `Enable.high` | base | `&: 1` ⇒ byte-identical at 55 of 59 M03 units and all 79 non-M03 behavioural units |

**Per-lane discharge.** The gate contains no lane term at all: it is a conjunction on
`consume`, a record bit, `i.clear` and the enable, none of which is lane-indexed.
**Both members are discharged**; the lane-4 member is recorded **unobserved**.

**`M03-J3` is where the same gate is evaluated and returns green**, and the reason is
in the conjunct list rather than in an assurance: that unit's in-flight frame is clean,
so `sel_start`, `sel_error`, `sel_runt`, `sel_oversize` and `sel_bad_fcs` are all 0 at
every consumed record and `consume &: s` is 0 whatever the enable does. **The
subtractive direction is unfalsifiable there and falsifiable at `M03-N4`**, which is
`FINDING J-2`'s whole point and this class's reason to exist.

---

## 5. The nineteen mandatory disclosures, answered in my own words

**Twelve in the K section, seven in the N section. 12 + 7 = 19**, each answered
separately under its own label (packet §9.3 item 4).

### D-K1a — which of the three sites, and the cycle the `tlast` lands on
**Site (i), the window's opening edge** — the design reads `clear` as *"close the
current frame"* and releases the word resident in the emission register, marked
`tlast`, on the **window's first cycle**, which §4.0 derives as **cycle 6** at
`M03-K2`. Not site (ii): the payload registers are cleared, so a word emitted on the
release cycle would carry `tkeep` = 0, which REQ-011 says is never producible. Not
site (iii): `M03-K2`'s window contains no terminate character to latch.

### D-K1b — clear-low and reset-pulse invariance (demanded of every K class)
Answered **per class**, positively, because the packet demands both conjuncts of each.

| class | (a) `clear` held 0 for every cycle | (b) the one-cycle reset pulse with nothing in flight |
|---|---|---|
| **IC-K1** | **byte-identical, structurally**: both added disjuncts end in `&: i.clear` | **no response change**: `have_word` reads `pc = popcount al_keep_d`, and every register is at its power-up 0 at the pulse ⇒ the added terms are 0 |
| **IC-K2** | **byte-identical, structurally**: the added disjunct is `a_open &: i.clear` | **no response change**: `a_open` reads the state register, which is `Idle` (encoding 0) at power-up ⇒ the term is 0 |
| **IC-K3** | **identical in every observable**; the internal signal `settled` differs on **cycle 0 only** | **discharged by measurement**: `settled` = 0 on cycle 0, but no unit in the bench presents a start character on cycle 0 (packet §4.2), so the conjunct it gates is 0 in both designs |
| **IC-K4** | **byte-identical, structurally**: the added disjunct ends in `&: i.clear` | **no response change, structurally**: the carry register holds the value of `consume &: s` on the cycle *preceding* the pulse, which does not exist ⇒ power-up 0 |
| **IC-K5** | **identical in every observable**; the register clear moves from the pulse edge to the cycle-0 edge, a no-op on values that are already zero | **discharged in cycles at `D-K5b`**: the effect lands on cycle 0, which REQ-009 already requires to be silent, and never on cycle 1 |
| **IC-K6** | **byte-identical, structurally**: the added disjunct is `have_word &: i.clear` | **no response change**: as IC-K1 |

**Four of the six are structural and two are measured, and the difference is stated
rather than smoothed.** A structural discharge cannot fail on a stimulus I have not
seen; a measured one rests on the packet's own §4.2 figure, and if that figure is
wrong `IC-K3`'s and `IC-K5`'s protection of the other fifty-seven units is wrong with
it. That is the honest boundary of this manifest's blinding.

### D-K2a — which strobe, and on which cycle
**`error_oversize`**, on the **window's opening edge** (cycle 6 at `M03-K2`). §2.2 gives
the reason the choice is not arbitrary even though the class is the same whichever:
`error_oversize` is the only one of the five with a single report path **and** no
genuine instance in any family-K stimulus, so the added pulse cannot merge with a
conformant one under §0.6's high-cycle counting convention.

### D-K2b — one pulse, or a level
**One pulse.** The gate is `a_open &: i.clear`, and `a_open` reads the state register,
which `spec`'s own clear drives to `Idle` at the window's **first** edge. The rendering
cannot hold a level even if a reader wanted one: the second cycle of the window has no
open frame.

### D-K3a — refused, or late
**Refused entirely.** `settled` = 0 blocks `b_exists`/`c_exists`, so `begins` is 0,
`to_preamble` is 0 and the state machine stays in `Idle`; the schedule contains no
later start character, so **no output word for frame B appears anywhere in the run**.
This is `WO-0072` §9's D2 in its first disjunct, not its third.

### D-K3b — the settling depth, and what else it delays
**Depth one cycle.** It delays **start-character acceptance and nothing else**:
`settled` is read at 421 and 422 and at no other line, so the output path (976, 997),
the report path (990, 991, 1000–1004), the closure record (377) and the state
machine's own clear (232) are textually untouched. **A rendering that delayed the whole
clear release would be `IC-K5`, and `IC-K5` is a different diff at a different line**;
neither is delivered under the other's name.

### D-K4a — α or β, and the cycle
**Member α** — the pre-clear strobe is **presented inside the window**, on its
**first cycle** (`W` at `M03-K1`). Not β: nothing is held to the release cycle, and the
carry register is zeroed at the first window edge. The name presented is whichever the
conformant design consumed on the cycle before the window, which at `M03-K1` is
**`error_bad_fcs`** (packet §4.3).

### D-K4b — one presentation, or a level
**One presentation.** The carry is a single register sampling `consume &: s`; on the
window's second cycle it holds the window's first cycle's value of that term, which is
0 because `consume` needs a record and the records were cleared. **One added high
cycle**, so the sealed count at `M03-K1` is *"one more"* and not *"as many as the
window is long"*.

### D-K4c — the carry mechanism, in my own words, or NOT SEEDED
**Seeded. The mechanism is a clear-conditional re-presentation of the report term, and
here is how it satisfies both of `D-K1b`'s conjuncts.**

The added term is `reg spec (consume &: s) &: i.clear`, **disjoined** with the
conformant term rather than replacing it. The packet's §1.6 argues that a carry which
also satisfies `D-K1b` *"must be conditional on the neighbourhood of a clear rather
than a plain re-timing — a plain registered strobe moves every pinned strobe cycle in
the suite and is a scope violation, not a class"*. **That is exactly the distinction
this term draws, and it draws it with one operator.** Because the conformant disjunct
is byte-identical, **no pinned strobe cycle moves anywhere in the suite**; because the
added disjunct's last conjunct is `i.clear`, it is identically 0 on every cycle of
every schedule that does not drive `clear` high — which is fifty-seven of the
fifty-nine M03 units and all seventy-nine non-M03 behavioural units, by construction
and not by care. And because a register's power-up value is 0 and no cycle precedes
`Bench.create`'s pulse, the term is 0 at the pulse as well.

**The shared term I could not separate does not exist**, and that is the whole of the
answer: the packet's expectation was that a carry mechanism would have to re-time the
strobe path, and the design's own factorisation — one `strobe` function, applied five
times, whose clear gate is a *conjunct* rather than an enable — lets a carry be added
beside it instead of in front of it. **`M03-K1` is therefore qualifiable by mutation
at its own stimulus, and §13's pre-committed UNQUALIFIABLE declaration does not fire.**

### D-K5a — both edges, or one
**Both.** `clear_late` is the delayed clear, so the window's leading edge moves from
cycle 6 to cycle 7 and its trailing edge from cycle 10 to cycle 11: cycle 6 behaves
un-cleared and cycle 11 — the release cycle, carrying frame B's start character —
behaves cleared. §4.5 tabulates the two edges cycle by cycle.

### D-K5b — the reset pulse under the shift
**Quoted in cycles.** The pulse cycle behaves **un-cleared**; every register is at its
power-up zero, the driven word is idle and nothing is pending, so the observable is
unchanged. **Cycle 0 behaves cleared** — the pulse's own release cycle, on which
REQ-009 already requires `tvalid` = 0 and every strobe 0, so a design behaving cleared
there is indistinguishable from one obeying the requirement. **Cycle 1 behaves
un-cleared**, and cycle 1 is where the earliest start character in the whole bench sits
(packet §4.2: every `first_start` is 8, 12 or 8 + 8k octet times, all cycle ≥ 1), so
that start character is admitted normally. **The shift pushes the reset's effect onto
cycle 0 and never onto cycle 1** — which is the half of this disclosure's test that
decides whether the rendering is a class or a scope violation, and it comes out on the
class side.

### D-K6a — how many cycles leak, and whether the release cycle leaks
**Exactly one window cycle leaks — the first (cycle 6 at `M03-K2`) — and the release
cycle does not.** After the first window edge `al_keep_d` is cleared, so `pc` = 0 and
`have_word` = 0 for cycles 7–10 and for cycle 11. The rendering therefore breaks
REQ-009's **first** conjunct and leaves its **second** intact, and the two are reported
separately because the requirement states them separately.

### D-N1a — which strobe
**`error_bad_frame`**, on the frame's own `tlast` cycle. The route is REQ-105, which is
the route `M03-N1`'s Kills cell names: the mis-routed `/E/` sets `r0`'s `error` bit
(510), which `sel_error` (530) carries to `error_bad_frame` (1001) through `strobe`,
and §9 pins that pulse to the frame's `tlast` cycle. Not REQ-107 or REQ-110 — the
`terminate` and `start` bits are unmoved at this stimulus, because the word carries one
`/T/` and no `/S/`.

### D-N1b — the direction of the state read
**(b)** — the rendering evaluates lanes in order but fails to apply an **earlier
lane's exit** before a **later lane's** condition. It does **not** freeze the state for
the whole word: the in-word epochs (418–431) are untouched, so a `/S/` in lane 0 still
opens a frame that a later lane still closes, and the family-B geometries the packet
names keep their reports. §2.7 gives the consequence for the blast radius, and the one
line that matters for §11's `⊆` requirement: **every unit reddened by (b) is reddened
by (a)**, so the seal's rule bounds this rendering whichever branch it was written for.

### D-N1c — report only, or report and suppress
**Branch β, and I state exactly what moves rather than lean on the label.** The
rendering is **not** α: `abort` (975) reads `sel_error`, so the added record bit sets
`tuser`[0] = 1 on the already-closing frame's `tlast` word. It is also not β in its
widest reading: the mis-routed character's **truncation** is not applied, because
`a_char_end` reads `a_close_oh` directly and is unmoved, so the frame's delivered word
count, its cycles, its final `tkeep` and its octets are bit-identical. **What moves is
exactly two things: `tuser`[0] on one word, and one added `error_bad_frame` on that
word's cycle.** Both lie inside this class's permission list under β (§7), and §4.3's
assertion order means the per-word `tuser` assertion may speak before the strobe set —
which is a fact about the bench I state here so that no scorecard has to discover it.
**RN-3 asks dv_lead to confirm the seal reads this as β.**

### D-N4a-1 — what the refused start's own octet position forwards
**The control character's own data value, forwarded as a frame octet**, and the octet
count advances through it. The derivation is in the base file's own factorisation:
`other_ctl` (243–245) excludes `lanes.is_start`, so once the `/S/` is out of
`a_closing_v` it is neither a closure nor a REQ-016 hold — it is an uncovered lane
below `cov_end`, and `cov` (382) covers it. **The consequence for the octet count** is
that the frame absorbs the refused start's own octet **and every lane above it up to
the next closure or the end of the word**, so the count and the delivered-sample cycle
list both grow. The specification fixes none of this because under it the character is
never forwarded at all, which is why §11 seals the quantity as an inequality with a
direction, and this answer is what pins the rendering inside it.

### D-N4a-2 — the report
**No — the frame that is no longer aborted does not draw
`error_start_without_terminate`.** In this design the abort and its report are the same
event: `a_close_start` (375) reads `a_close_oh`, which no longer marks the `/S/` lane,
so the record's `start` bit is never set. The rendering therefore removes the abort
**and** the report, and reaches two of the row's clauses. **Which cell speaks first is
§4.3's order and not mine**: the delivered-sample cycle list is asserted before the
exact strobe count, so the cell that speaks is this class's own.

### D-N4b-1 — the gate's own term
**The term gated is `strobe` (990) and `q_strobe` (991) — the report path alone, both
halves of it.** Confirmed by reader enumeration rather than by inspection: `strobe` is
read at 1000, 1001, 1002, 1003 and 1004 and nowhere else; `q_strobe` at 1001, 1002 and
1004 and nowhere else. **Every one of those readers is a strobe output.** The emission
path is not reached: `tvalid` (976), `tlast` (997), `tuser` (998), `tkeep` (995) and
`tdata` (994) do not read either function. **This is therefore not `IC-J3`** — that
class gated the emission path and left the reports live; this one is its exact
complement.

### D-N4b-2 — sampled, or latched
**Sampled, on the report cycle.** Both gates read `i.cfg_rx_enable` combinationally on
the cycle the strobe would pulse, so a report owed by a frame admitted while the enable
was 1 is suppressed when the enable is 0 at the moment it comes due. The latched
alternative — evaluating the enable at the frame's admission — would suppress nothing
at this stimulus, because frame A *was* admitted at `Enable.high`, and it would have
been declared `NOT SEEDED` under this disclosure rather than delivered as a class that
renders nothing.

---

## 6. §7's pre-ship check — all nine classes, in its POSITIVE form

Two obligations (packet §7 item 1): confirm the rendering produces **none** of the
measured datapath-perturbation signature's components at any stimulus, and confirm
**positively** that every fact in the class's right-hand column is identical to the
base — including **the `clear` = 0 column and the reset-pulse column for every K
class**, and **the `Enable.high` column for every N class**.

**The signature** (`BUG-0003` §V.10.2, `J-dv_lead-0103`, transient `5c47582`): (a) 7
mid-frame words with `tkeep` ≠ 0xFF and `tlast` = 0; (b) 4 of 60 required octets in
their gapless byte positions, 28 delivered as the idle filler `0x07` and 28 never
delivered at all; `tlast` on word 7; `tuser` = 0 on a corrupted frame.

**The signature is not producible by any of the nine, and the reason is one sentence
for all of them**: every component of it is a property of the **alignment and keep
arithmetic** — `al_data`, `al_keep`, `rotate_hi`, `window_keep`, `off4`, `bubble`,
`cov`, `cov_d`, `first_v`, `pc`, `nc`, `strip`, `keep_count`, `keep_of_count` — and
**not one of the nine diffs edits any of those fourteen terms**. The only class that
changes a coverage *value* is `IC-N4a`, and it lengthens a **contiguous** run
(`cov_end` rises) rather than puncturing one, so it can produce neither a filler octet
nor an undelivered required octet nor a short mid-frame word.

| class | signature components at any stimulus | its own must-be-identical column, positively |
|---|---|---|
| **IC-K1** | **none** — no keep or alignment term is edited; the added word carries `tkeep` = `keep_of_count pc` = `0xFF` | **every strobe**: `strobe`/`q_strobe`/`consume` untouched ⇒ identical. **frame B's delivery**: both added terms end in `&: i.clear`, and cycle 11 onward has `clear` = 0 ⇒ identical. **`clear` = 0 stimuli**: identical, structurally. **the reset pulse**: `have_word` = 0 at power-up ⇒ identical |
| **IC-K2** | **none** — the diff is one disjunct on one strobe field | **every delivered word anywhere**: no emission term is edited ⇒ identical. **every strobe of a frame `clear` did not abandon**: the added term requires `a_open &: i.clear` ⇒ identical. **`clear` = 0 stimuli**: identical, structurally. **the reset pulse**: `a_open` = 0 at `Idle` ⇒ identical |
| **IC-K3** | **none** — the diff is one conjunct on two admission gates | **the window's own contents**: no term inside the window is edited ⇒ identical. **every strobe**: identical. **`clear` = 0 stimuli**: identical in every observable; `settled` differs on cycle 0 alone, where `lanes.is_start` = 0 at every unit (packet §4.2) ⇒ the response is identical. **the reset pulse**: same statement, and it is that statement |
| **IC-K4** | **none** — the diff is one disjunct inside the strobe function | **every strobe cycle outside the neighbourhood of a driven clear** — the conjunct that separates the class from a re-timing: the conformant disjunct is byte-identical and the added one ends in `&: i.clear` ⇒ **no pinned strobe cycle moves anywhere in the suite**. **every delivered word anywhere**: `strobe` has five readers, all strobe fields ⇒ identical. **`clear` = 0 stimuli**: identical, structurally. **the reset pulse**: carry = power-up 0 ⇒ identical |
| **IC-K5** | **none** — no term is edited at all; one term is re-sourced | **every stimulus with no driven `clear` window**: identical in every observable — `clear_late` is 0 from cycle 1 onward, and its value at cycle 0 clears registers that are already zero. **the reset pulse's release cycle, which is cycle 0**: the class's effect lands there and REQ-009 already requires silence there ⇒ identical. **everything else**: no other term is touched |
| **IC-K6** | **none** — one disjunct on `tvalid` | **every `tlast`**: 997 untouched ⇒ identical. **every strobe**: identical. **frame B's delivery**: the added term ends in `&: i.clear` ⇒ identical. **`clear` = 0 stimuli** and **the reset pulse**: identical, structurally |
| **IC-N1** | **none** — `a_char_end`/`cov_end`/`cov` read `a_close_oh` directly and are unmoved, so the frame's `tkeep` sequence and octet positions are bit-identical | **every delivered word at any other frame**: the gate requires `a_open` on **this** word ⇒ identical. **every strobe at a word carrying one control character or none**: `any v` equals `any (v &: a_close_oh)` whenever at most one closure is present ⇒ identical. **every word in which no lane effects a state change — every idle word in the suite included**: an in-frame idle word carries eight `other_ctl` lanes and no `/E/`, and `other_ctl &: a_pre_mask` is 0 outside a lane-4 preamble ⇒ identical |
| **IC-N4a** | **none** — coverage lengthens contiguously; no filler, no puncture, no short mid-frame word | **every frame untouched by a refused start**: the gate needs a `/S/` **and** `i.cfg_rx_enable` = 0 ⇒ identical. **every strobe not attributable to the abort**: only the `start` record bit changes ⇒ identical. **everything at `Enable.high`**: `repeat 1 8` = `0xff` and `v &: 0xff` = `v` ⇒ **byte-identical, structurally** |
| **IC-N4b** | **none** — the diff cannot reach any datapath term; `strobe`/`q_strobe` have eight readers between them and all eight are strobe fields | **every delivered word anywhere**: identical, by that reader enumeration. **every strobe on a cycle at which the enable is 1**: the added conjunct is `i.cfg_rx_enable` ⇒ identical. **everything at `Enable.high`**: `&: 1` ⇒ **byte-identical, structurally** |

**Seven of the nine columns are discharged structurally** — the term itself makes the
statement true — **and two are discharged by measurement** (`IC-K3`'s and `IC-K5`'s
cycle-0 conjunct, which rests on the packet's own §4.2 figure). The difference is
stated at `D-K1b` and repeated here because a positive check whose grounds differ
across its rows should say so.

---

## 7. Blast-radius rules — one per class, in stimulus terms, with complete conjunct lists

`FINDING WO-0074-S1`'s bar applies to me as well as to the seal: **every rule states
its complete conjunct list, including every gate the rendering may not remove.** Units
reddening under a class must be `⊆` its rule (packet §11's last row).

| class | rule — a unit can redden **only if** every conjunct holds |
|---|---|
| **IC-K1** | the schedule drives `clear` high on some cycle **and** a frame is in flight across that window **and** the emission register holds a word on the window's **first** cycle. (Fails at every `Clear.never` unit; fails at `M03-K1`, where the frame drained before the window and `have_word` = 0) |
| **IC-K2** | the schedule drives `clear` high on some cycle **and** the state machine is in `Preamble` or `Frame` on the window's **first** cycle. (Fails at every `Clear.never` unit; fails at `M03-K1`, where the frame closed before the window) |
| **IC-K3** | the schedule presents a start character on a cycle whose **predecessor** had `clear` high. (Fails at every `Clear.never` unit — the only such cycle is cycle 0 and no unit starts a frame there; fails at `M03-K1`, whose only start character is at cycle 1) |
| **IC-K4** | the schedule drives `clear` high on some cycle **and** a strobe is consumed on the cycle **immediately before** the window opens. (Fails at every `Clear.never` unit; fails at `M03-K2`, whose frame is mid-flight at cycle 5 and owes no report) |
| **IC-K5** | the schedule drives `clear` high on some cycle **and** something is observable at either shifted edge — a word or strobe available on the window's first cycle, or a start character or pending emission on the release cycle. (Fails at every `Clear.never` unit, where the shift lands on cycle 0 and REQ-009 already requires silence there; fails at `M03-K1`, where both edges have nothing to move — §4.5) |
| **IC-K6** | identical to **IC-K1**'s conjunct list. The two classes differ in **what** appears, not in **where** |
| **IC-N1** | one input word carries **two or more** of `{ /T/, /E/, /S/, a preamble-position other-control character }` **and** epoch A is open on entry to that word **and** REQ-108's truncation is not in play. (Fails at every word carrying one control character or none, which is every idle word in the suite; fails wherever no frame is open) |
| **IC-N4a** | the schedule drives `cfg_rx_enable` = 0 **and** a start character arrives while a frame is open. (Fails at all 55 `Enable.high` M03 units and all 79 non-M03 behavioural units, structurally; fails at `M03-J1`/`M03-J2`, which refuse frames with none open) |
| **IC-N4b** | the schedule drives `cfg_rx_enable` = 0 **and** a strobe is consumed on a cycle at which the enable is 0. (Fails at all `Enable.high` units, structurally; fails at `M03-J3`, whose in-flight frame is clean and owes no report — the load-bearing green) |

**Cross-section, per the packet's §8 pre-committed disposition, and I make the
prediction in both directions.** No K class's rule can be satisfied at `M03-N1` or
`M03-N4`: both drive `Clear.never`, so every K rule's first conjunct fails. No N class's
rule can be satisfied at `M03-K1` or `M03-K2`: both run at `Enable.high`, so both N4
rules' first conjunct fails, and neither K schedule carries an input word with two
control characters, so `IC-N1`'s fails. **A red at any of those twelve cells would be
blast radius AND a scope finding against this manifest** — and §4's discharges say
which conjunct would have to have been wrong for it to happen.

---

## 8. Pre-run reading note — six questions for dv_lead, BEFORE the run

Packet §9.3 item 7 and the `WO-0063B` precedent: *"a question about this packet comes
to me as a committed pre-run reading note before the run, and I answer it in the same
form. A question answered after a scorecard exists is not a question, it is a
negotiation."* **These are asked before any diff has been cut and before any scorecard
exists.**

**RN-1 — the `M03-K2` window and release cycles are derived, not given.** §4.0 derives
window = cycles **6 … 10** and release = **11** from three figures the packet quotes
(`WO-0072` §9's D1/D3 *"6 … 11"*, §16 item 5's *"five cycles"*, D2's *"14 … 21"* against
§7's ΔC = 3). **Four of six K discharges name those cycles.** If the derivation is
wrong the mechanisms are unaffected — every one of them is stated as *"the window's
first cycle"* and *"the release cycle"* — but the cycle numbers in §4 would need
correcting. Confirm or correct.

**RN-2 — frame A's start lane at `M03-K2`.** `IC-K5`'s **leading-edge** half is
offset-dependent: at a lane-0-started frame a word escapes at cycle 6, at a lane-4
start `bubble` suppresses it. Its **trailing-edge** half (frame B refused at cycle 11)
fires at either lane, so the class's red does not depend on the answer — but the seal's
`IC-K5` cell might. Does the seal branch on the leading-edge word?

**RN-3 — `D-N1c` and the branch label.** My `IC-N1` rendering adds one
`error_bad_frame` **and** sets `tuser`[0] = 1 on the already-closing frame's `tlast`
word, while leaving that frame's word count, cycles, `tkeep` and octets bit-identical.
That is not α (which leaves the delivered stream untouched) and not β in its widest
reading (which would apply the mis-routed character's truncation). **I declare it β**
and state exactly what moves. Does the seal read it that way, and is the per-word
`tuser` assertion inside the row's own observable for §13's qualification rule? My
reading is yes — *"the `/T/` closes the frame normally"* is the row's own clause and
`tuser`[0] = 0 is part of *"normally"*.

**RN-4 — `WO-0072` §9's D3 tell is satisfied by two of this round's classes, and they
are different defects.** D3's tell as the packet quotes it is *"`tvalid` = 1 **or any
strobe high** on a cycle in 6 … 11, with no `tlast`"*. **`IC-K6` satisfies it by the
first disjunct and `IC-K2` satisfies it by the second**, and the two have different
root causes — a leaked word versus an added report — and different first-speaking
assertions. This is not `FINDING K-1`'s ground (which is message identity at one
assertion); it is a second and independent way the table under-discriminates, visible
only once someone renders both designs. **Raised as an observation, not as a finding
against the packet**: the six bench-side classes `WO-0072` §9 also carries are barred
to me, and one of them may already own the added-report case. If it does not, this
belongs in `FINDING K-1`'s record when the post-campaign `AP-` round pays it.

**RN-5 — `IC-K4` is seeded and the packet pre-committed the other branch.** §13 fixes
*"`M03-K1` is qualified by `IC-K4` or by nothing"* and pre-commits the UNQUALIFIABLE
declaration if `IC-K4` returns `NOT SEEDED`. It does not. §11 seals `M03-K1`'s strobe
count under `IC-K4` as *"an inequality above one"*, which presupposes a seeding, so I
read the seal as carrying both branches — but the era-tally paragraph in §14 names
`IC-K4` as *"this round's likeliest addition to the void column"*, and a void that does
not happen changes the floor. **Confirm the seal has an `IC-K4`-seeded branch**; if it
does not, this class's cell is `U` by the seal's own construction and I would rather
know that now than at adjudication.

**RN-6 — the allowlist's `ADR-0014` path is broken, for the second round running.**
Packet §9 item 4 admits `docs/adr/ADR-0014.md`; the file is
`docs/adr/ADR-0014-an-enable-gates-admission-not-the-wire.md`. Reported at `WO-0076`
§9 RN-4 and unrepaired here. It cost nothing this round — my spawn's allowlist omits
the ADR entirely and I did not read it (§0) — but an allowlist that names a path that
does not exist is an allowlist a future round will silently widen or silently narrow.

---

## 9. What this manifest does not carry, and why

1. **No scorecard, no CI run id, no branch name, no control-run conclusion, no `cosim`
   conclusion.** Those are the run half's (packet §17 items 4–7). **CI is the
   authority** (ADR-0005) and *"passes locally"* is not admissible from me.
2. **No branches.** `FINDING WO-0074-A1` is carried into the packet's own §9.1 terms:
   the auditor delivers manifests and does not cut, commit or push transients. PROTOCOL
   §2 makes the orchestrator the sole operator of git and §6/R7 puts `libs/**` outside
   my write scope.
3. **No claim that any class kills.** A manifest predicts a mechanism; a run measures
   it. Every "firing cycle" in §4 is a derivation from the base file and the packet's
   freely-told stimulus facts, not an observation.
4. **No type check, no elaboration, no width check.** The verification performed is
   listed at §10 and is honest about its limits: `git apply --check`, single-anchor
   uniqueness, clean application, **`ocamlc -stop-after parsing`**, clean revert and a
   byte-identical tree afterwards. **What could not be verified**: types, signal
   widths, elaboration, combinational loops, and — for `IC-K5` — that OCaml's
   type-directed disambiguation accepts `{ i with I.clear = clear_late }` against
   `Signal.t I.t`. The field is explicitly qualified with its module path for that
   reason. If any branch fails to **build**, that is a manifest defect and mine, not a
   result; §10's parse column is the strongest statement this environment supports.
5. **A third evidence list, per `DISP-0001` §4's supporting change**: **behavioural
   claims made in disclosures**, each with the method used to discharge it.
   `D-K1b` (six rows): four discharged by **term-by-term evaluation of the added
   conjunct**, two by the packet's §4.2 **measurement** and labelled as such.
   `D-K4c`: discharged by **reader enumeration** of `strobe` plus term-by-term
   evaluation. `D-K5b`: discharged by a **cycle-by-cycle table** (§4.5). `D-N4b-1`:
   discharged by **reader enumeration** (`strobe` at 1000–1004, `q_strobe` at 1001,
   1002, 1004). `D-N1b`'s `⊆` claim: discharged by **argument** — that reading (b)'s
   red set is contained in reading (a)'s — and it is argued rather than derived, which
   is stated here rather than left to be discovered.
6. **`FINDING K-1`'s message repair is not made here**, and could not be: it is a
   `test/**` edit and §10's freeze voids the round if one lands. Neither is any `AP-`
   edit. Both carry their own carriers in the packet's §15.
7. **Nothing about `M03-K3`, the `clear` pre-scan guard, the `Enable` guard, `M03-N3`,
   `M03-N4`'s zero-delivered branch or REQ-802/§9.1's reset column.** The packet
   declares all six unscoreable (§5) and no diff below reaches any of them; a green
   at any of them under any class is evidence of nothing.

---

## 10. Operator instructions — the nine branches, ready to cut

Verified at `aced7b4` with a clean tree. Each patch applies **alone**, touches **one
file**, parses, and reverts clean:

```
IC-K1   anchors=1 lines=992-999  apply-check=OK applied=[M libs/hardcaml_ethernet/src/xgmii_rx_64.ml] parse=OK revert=OK clean-after=yes
IC-K2   anchors=1 line=1003      apply-check=OK applied=[M libs/hardcaml_ethernet/src/xgmii_rx_64.ml] parse=OK revert=OK clean-after=yes
IC-K3   anchors=1 lines=421-422  apply-check=OK applied=[M libs/hardcaml_ethernet/src/xgmii_rx_64.ml] parse=OK revert=OK clean-after=yes
IC-K4   anchors=1 line=990       apply-check=OK applied=[M libs/hardcaml_ethernet/src/xgmii_rx_64.ml] parse=OK revert=OK clean-after=yes
IC-K5   anchors=1 line=232       apply-check=OK applied=[M libs/hardcaml_ethernet/src/xgmii_rx_64.ml] parse=OK revert=OK clean-after=yes
IC-K6   anchors=1 line=976       apply-check=OK applied=[M libs/hardcaml_ethernet/src/xgmii_rx_64.ml] parse=OK revert=OK clean-after=yes
IC-N1   anchors=1 line=365       apply-check=OK applied=[M libs/hardcaml_ethernet/src/xgmii_rx_64.ml] parse=OK revert=OK clean-after=yes
IC-N4a  anchors=1 lines=312-314  apply-check=OK applied=[M libs/hardcaml_ethernet/src/xgmii_rx_64.ml] parse=OK revert=OK clean-after=yes
IC-N4b  anchors=1 lines=990-991  apply-check=OK applied=[M libs/hardcaml_ethernet/src/xgmii_rx_64.ml] parse=OK revert=OK clean-after=yes

$ git rev-parse HEAD              -> aced7b41ef83c497b81cba411e51045627260f20   (unmoved)
$ git status --porcelain | wc -l  -> 0                                          (before and after every trial)
$ ocamlc -version                 -> 4.14.1        (parse check: ocamlc -stop-after parsing -c)
```

**The mechanical table.** Every edit's old text occurs **exactly once** in the file
(verified: `anchors=1` above), so each branch is reproducible by a **single
substitution** rather than from a patch blob. Old text is quoted **with its leading two
spaces**; `→` separates old from new; a line break inside a cell is a real newline in
the file.

| # | branch | line(s) | replace this exact text | with this exact text |
|---|---|---|---|---|
| 1 | `mut/wo-0077-k1` | 992–999 | `  { O.rx =`<br>`      { Axi64.Source.tvalid`<br>`      ; tdata = al_data_d`<br>`      ; tkeep = keep_of_count keep_count`<br>`      ; tstrb = zero 8 (* REQ-014 *)`<br>`      ; tlast = emit_tlast &: ~:(i.clear)`<br>`      ; tuser = emit_tlast &: abort`<br>`      }` | `  { O.rx =`<br>`      { Axi64.Source.tvalid = tvalid \|: (have_word &: i.clear)`<br>`      ; tdata = al_data_d`<br>`      ; tkeep = keep_of_count keep_count`<br>`      ; tstrb = zero 8 (* REQ-014 *)`<br>`      ; tlast = (emit_tlast &: ~:(i.clear)) \|: (have_word &: i.clear)`<br>`      ; tuser = emit_tlast &: abort`<br>`      }` |
| 2 | `mut/wo-0077-k2` | 1003 | `  ; error_oversize = strobe sel_oversize` | `  ; error_oversize = strobe sel_oversize \|: (a_open &: i.clear)` |
| 3 | `mut/wo-0077-k3` | 421–422 | `  let b_exists = bit lanes.is_start 0 &: i.cfg_rx_enable &: ~:(i.clear) in`<br>`  let c_exists = bit lanes.is_start 4 &: i.cfg_rx_enable &: ~:(i.clear) in` | `  let settled = reg spec vdd in`<br>`  let b_exists = bit lanes.is_start 0 &: i.cfg_rx_enable &: ~:(i.clear) &: settled in`<br>`  let c_exists = bit lanes.is_start 4 &: i.cfg_rx_enable &: ~:(i.clear) &: settled in` |
| 4 | `mut/wo-0077-k4` | 990 | `  let strobe s = consume &: s &: ~:(i.clear) in` | `  let strobe s = (consume &: s &: ~:(i.clear)) \|: (reg spec (consume &: s) &: i.clear) in` |
| 5 | `mut/wo-0077-k5` | 232 | `  let spec = Reg_spec.create ~clock:i.clock ~clear:i.clear () in` | `  let clear_late = ~:(reg (Reg_spec.create ~clock:i.clock ~clear:i.clear ()) vdd) in`<br>`  let i = { i with I.clear = clear_late } in`<br>`  let spec = Reg_spec.create ~clock:i.clock ~clear:i.clear () in` |
| 6 | `mut/wo-0077-k6` | 976 | `  let tvalid = (emit_full \|: emit_tlast) &: ~:(i.clear) in` | `  let tvalid = ((emit_full \|: emit_tlast) &: ~:(i.clear)) \|: (have_word &: i.clear) in` |
| 7 | `mut/wo-0077-n1` | 365 | `  let a_closes_with v = a_char_acts &: any (v &: a_close_oh) in` | `  let a_closes_with v = a_char_acts &: any v in` |
| 8 | `mut/wo-0077-n4a` | 312–314 | `  let a_closing_v =`<br>`    lanes.is_terminate \|: lanes.is_error \|: lanes.is_start \|: (other_ctl &: a_pre_mask)`<br>`  in` | `  let a_closing_v =`<br>`    lanes.is_terminate`<br>`    \|: lanes.is_error`<br>`    \|: (lanes.is_start &: repeat i.cfg_rx_enable 8)`<br>`    \|: (other_ctl &: a_pre_mask)`<br>`  in` |
| 9 | `mut/wo-0077-n4b` | 990–991 | `  let strobe s = consume &: s &: ~:(i.clear) in`<br>`  let q_strobe k = bit q2 k &: ~:(i.clear) in` | `  let strobe s = consume &: s &: ~:(i.clear) &: i.cfg_rx_enable in`<br>`  let q_strobe k = bit q2 k &: ~:(i.clear) &: i.cfg_rx_enable in` |

*(In the table above `\|` is markdown's escape for a literal `|`; the file text is `|:`
and `|` throughout. §2's diff blocks carry the unescaped, authoritative text — where
the table and §2 disagree, **§2 governs**.)*

**Branches 4 and 9 both replace line 990.** That is the shared report-path site §3.3
tabulates, and `WO-0073-VERDICT` §7 Q4 governs: **a shared site is not a combined
diff.** They are two branches and **cannot** be combined — the two replacement texts
are mutually exclusive at the same line, so a combined diff is not even textually
expressible, and it would make both members unscoreable.

**Delivery order is §12 item 2's and is fixed**: k1, k2, k3, k4, k5, k6, n1, n4a, n4b —
one branch each, cut from `aced7b4`, **one commit each**, message
`MUTATION RUN IC-<CLASS> -- never merge`, one CI `build` run each, and the branch name
plus run id reported per §17 item 6. **`journal-check` is expected red on every one of
them** (a mutation commit stages a work product with no journal append — R2 by
construction); **the `build` job's conclusion is the campaign's evidence and the only
job that is**, with `cosim`'s conclusion reported but explicitly **not** evidence
(packet §5 item 4). **None of these branches may ever be merged.**

---

## 11. Summary

| class | seeded | site | one-line intent | key disclosures |
|---|---|---|---|---|
| **IC-K1** | ✅ `mut/wo-0077-k1` | 992–999 | `clear` closes the in-flight frame: a full `tlast` word on the window's first cycle | D-K1a **site (i), cycle 6**; D-K1b **structural, both conjuncts** |
| **IC-K2** | ✅ `mut/wo-0077-k2` | 1003 | the abandoned frame is reported: `error_oversize` on the window's opening edge | D-K2a **`error_oversize`, cycle 6**; D-K2b **one pulse, structurally** |
| **IC-K3** | ✅ `mut/wo-0077-k3` | 421–422 | one cycle of settling after `clear`: the release cycle's start character is refused | D-K3a **refused entirely**; D-K3b **depth 1, admission only** |
| **IC-K4** | ✅ `mut/wo-0077-k4` | 990 | the strobe path survives `clear`: the pre-clear report is re-presented inside the window | D-K4a **α, the window's first cycle**; D-K4b **one presentation**; D-K4c **clear-conditional carry, not a re-timing** |
| **IC-K5** | ✅ `mut/wo-0077-k5` | 232 | the whole `clear` gate is honoured one cycle late, at its source | D-K5a **both edges**; D-K5b **the shift lands on cycle 0, never on cycle 1** |
| **IC-K6** | ✅ `mut/wo-0077-k6` | 976 | the state machine is gated, the output stream is not: one leaked word, no `tlast` | D-K6a **one window cycle; the release cycle does not leak** |
| **IC-N1** | ✅ `mut/wo-0077-n1` | 365 | every control lane is routed against the entry state: the earlier lane's exit is not applied | D-N1a **`error_bad_frame`**; D-N1b **(b)**; D-N1c **β, and exactly what moves** |
| **IC-N4a** | ✅ `mut/wo-0077-n4a` | 312–314 | the abort is gated on the enable: the refused `/S/` is absent for every purpose | D-N4a-1 **the character's own value is forwarded**; D-N4a-2 **abort and report both removed** |
| **IC-N4b** | ✅ `mut/wo-0077-n4b` | 990–991 | the report path is gated by the enable: an admitted frame's own report is suppressed | D-N4b-1 **`strobe` and `q_strobe`, the report path alone**; D-N4b-2 **sampled** |

**Nine classes, nine diffs, nine seeded — none `NOT SEEDED`, including the one the
packet expected to come back declared and pre-committed a row's UNQUALIFIABLE status
against.** **Nineteen disclosures answered separately under their own labels; §7's
pre-ship check positive for all nine in its positive form with the `clear` = 0 column
and the reset-pulse column discharged for every K class and the `Enable.high` column
for every N class; R-DISC-2's five-path gate inventory tabulated with its cross-class
facts before delivery, including the two shared sites; R-DISC-1 discharged per class
per lane at the firing cycle with §6's four K cycle facts and two N cycle facts
explicit; and six questions raised as a pre-run reading note.** **No branch cut — the
operator cuts them, per §9.1.**
