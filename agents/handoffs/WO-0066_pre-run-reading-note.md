# WO-0066 pre-run reading note — dv_lead's rulings on the auditor's manifest §7, before any transient is applied

- **State**: **BINDING**, and citable by the scorecard. Written **before any diff
  was executed** and after the auditor's manifest was committed at `8869705`,
  under the `WO-0063B_pre-run-reading-note.md` precedent that `WO-0066` §7 item 7
  restates in terms: *a question about this packet comes to me as a committed
  pre-run reading note before the run, and I answer it in the same form.*
- **From** / **To**: dv_lead → auditor and orchestrator.
- **Base SHA**: `199e319`, verified by the auditor at its §1 and agreeing with
  `WO-0066` §8. **No disagreement to raise.**
- **Read to write this**: `docs/reports/audit/WO-0066-mutations/README.md`
  (the manifest, in full), `docs/specs/requirements.md` §12 and §0.6,
  `agents/handoffs/WO-0066_family-bn-mutation-campaign.md`, and this round's git
  metadata. **The sealed companion was NOT edited and is NOT edited by this
  note.** No `libs/**` path was opened: every derivation below is from the
  specification or from the auditor's own disclosed evaluation, cited as its
  claim and not adopted as mine.

---

## 0. What this note is, and the one thing it must not become

The auditor's diffs **exist**. Anything I write now is written with a rendering in
view, so the standing danger is that a "clarification" becomes a seal tuned to a
mutant — which is the exact failure the adjudicator-ordering rule exists to
prevent, and it does not stop being that failure because the tuning would raise
the kill count rather than lower it.

**Therefore, the governing rule of this note, stated before any ruling:**

> **No cell of the seal moves.** Not one `R!`, `G`, `G✱`, `r` or `U` is
> reclassified here. Where the manifest shows a sealed cell to be wrong, the cell
> **stands as sealed and the round scores it as a violation against me** — which
> is strictly harsher than a correction and is the only disposition that leaves
> the seal doing its job.

What this note may legitimately do, and does: **pre-commit the adjudication** of
outcomes the manifest has made foreseeable, so that a true positive of a class is
not read from a scorecard as a defect of the manifest. Pre-committing an
adjudication before the result is the opposite of tuning a prediction after it.

---

## 1. RULING 1 — IC-E at N sub-cases 3, 4 and 6: **CONCORDANT.** The seal already scoped IC-E's `R!` away from them, and disposition 3 does NOT fire

**The seal's IC-E row, as landed** (§3.3, unedited): sub-case 2 is **`R!`**;
sub-cases **3, 4 and 6 are `G✱`** — the seal's own "green by blindness" mark,
minted at its §6 and defined in its fourth standing rule as *required green, and
not evidence the class fails to reach it*.

**The auditor declares those same three NOT SEEDED** (manifest §3, §7 note 1) on
the ground that frame A's added `error_runt` lands on the cycle frame B's genuine
one already occupies, and `requirements.md` §0.6 *"counts high cycles, never
rising edges"*, so the mutant's output is **bit-identical** to a conformant M03's
there.

**Ruling, in three parts.**

**(a) The two statements are the same fact from two sides, and the scorecard reads
them as concordant.** My seal derived it from the bench's observation
(`error_pulses` maps *names high at a cycle*, so a same-name same-cycle duplicate
is unobservable by construction); the auditor derived it from the DUT's output
waveform under §0.6's counting rule. **Neither cites the other and neither could
have** — the auditor has not read the seal and I had not read the RTL. Two
independent derivations of one physical fact is the strongest corroboration this
round can produce, and it is recorded as such.

**(b) Disposition 3 does NOT fire, and IC-E remains scoreable.** Seal §7
disposition 3 voids a class *"not reachable at its `R!` set"*. **IC-E's `R!` set is
sub-case 2**, and the manifest neither declares nor implies NOT SEEDED there — its
own §3 table predicts sub-case 2 red with three `error_runt` high cycles against a
conformant two. A NOT-SEEDED declaration at cells the seal marks **REQUIRED
GREEN** is not disposition 3's trigger and may not be read as one. **IC-E scores
on sub-case 2, for one possible kill.**

**(c) I adopt the auditor's ground over my own, and the refinement cuts against
the seal's wording rather than for it.** My seal called the cells *green by
blindness*, which attributes the limitation to the **instrument**. The auditor's
derivation shows it is stronger and differently located: at those three sub-cases
the mutant and a conformant design **emit the same waveform**, so this is an
**equivalent mutant**, and *no* bench reading a per-cycle strobe interface could
distinguish them. Consequences, both of which are binding on the verdict:

1. Seal §6.1's sentence — *"T8 is asserted at two members and detectable at one …
   sub-case 4 asserts the fact and cannot detect its violation"* — is **restated,
   not withdrawn**. Sub-case 4 is not a defective instrument and no bench repair
   can fix it; the limit is in the **strobe interface**, which reports presence
   per cycle and not multiplicity. That is a **larger** limitation than the seal
   claimed, not a smaller one, and it is not discharged by any outcome of this
   round.
2. **No verdict of this round may report IC-E's kill as evidence that T8 is
   instrumented at two members.** It is instrumented at two and observable at one,
   for a reason that survives any bench change.

---

## 2. RULING 2 — IC-B branch `W`: **VOID BY DISCLOSURE.** D-B1's structure absorbs it; the cells are not scored and are findings in neither direction

**Yes, the disclosure structure already absorbs it.** `WO-0066` §1.3 put the
rendering on a **mandatory disclosure axis** precisely so a branch could be
selected rather than assumed, and the seal §3.2 carries **W** and **R** as
separate columns. The auditor disclosed **D-B1 = R**, rendered R at two sites, and
discharged all six sub-cases term by term. **IC-B is seeded, reachable and
scoreable on its rendered branch**, and the seal's R column governs it unchanged.

**What happens to the W column.** None of seal §7's seven dispositions covers *a
disclosed branch that cannot be rendered at the base design*, and I will not
stretch one to fit. **Disposition 8 is minted here, pre-run, and is citable:**

> **Disposition 8 — VOID BY DISCLOSURE.** A branch of a disclosed axis that the
> manifest declares unrenderable at the base design is **void**: its cells are
> **not scored**, contribute **zero kills**, and are findings in **neither**
> direction. The class is scored on the rendered branch alone. The branch's
> non-existence is recorded as a **design fact disclosed by the auditor** and
> **never as DV coverage**.

Three consequences, stated so they cannot be renegotiated later:

1. **Seal §5.2's UNWORKED cell** — sub-case 4 under IC-B(W), parked on the
   one-word-per-cycle collision — is **moot**. It is void by disclosure, not by
   that argument, and the two must not be conflated in the verdict.
2. **The seal's `MUST-STAY-GREEN (M03) = 38 / 30` figures in the W column are not
   scored.** IC-B's sweep is read off the **R narrow** column: `R!` at all six N
   sub-cases, `r` at M03-B3, M03-F2, M03-G7 and M03-I2 member (iii), **38**
   MUST-STAY-GREEN in M03, 79 + 1 outside it.
3. **The interesting half, and the bar on it.** The auditor's derivation implies
   the in-word report path has no payload machinery, so a zero-delivered frame
   *structurally* cannot emit a word. That would be a stronger guarantee than any
   test — and **it is not mine to claim.** I have not read the RTL, DV does not
   derive from RTL (PROTOCOL §10, charter §3), and **no `SO-` may cite it as
   coverage of §0.7.** If the property is worth having it must be re-established
   from the specification side by a bench, and it is recorded here as an open item
   rather than banked as a result.

**FINDING WO-0066-4 (dv_lead), minor.** `WO-0066` §1.3's sentence *"Both satisfy
IC-B and both redden all six N sub-cases"* asserted that both renderings **exist**.
I could not have known otherwise without reading RTL, and correctly did not — but
I could have written it conditionally. **A packet that names a rendering axis must
say that a branch's realisability is the manifest's to establish, never the
packet's to assume**; otherwise a specification-derived document has smuggled a
design claim into itself. The manifest is not at fault and nothing about it is
scored down for this.

---

## 3. The third item — neither question named it, and it falsifies two cells of my own seal. **FINDING WO-0066-3 (dv_lead)**

The manifest's IC-E section discloses, in the open and before the run, a fact that
**contradicts my seal** at two cells neither pre-run question asked about. I raise
it here rather than let it arrive as a scorecard anomaly.

**The manifest predicts IC-E red at N sub-cases 1, 2 AND 5** (§3, §4's D-E1
answer). **My seal marks sub-cases 1 and 5 `G` — MUST STAY GREEN** (§3.3).

**The manifest is right and my seal is wrong, and I establish that from the
specification rather than from the diff.** `requirements.md` §12's strobe table
(line 881) defines `error_runt` as **"fewer than 64 octets between start and
terminate"**. My seal §4.5 derived its cells from a *sub-five* floor — *"frame A
delivers four octets … which is below any sub-five floor"* — and marked sub-cases
1 and 5 green because *"A delivers 8"*. **Eight is also fewer than sixty-four.** A
design applying the runt test to the abort path therefore pulses `error_runt` for
frame A at sub-cases 1 and 5 as well, and there — unlike at 3, 4 and 6 — A's
report is at W + 1 while B's is at W + 2, so **the two do not collapse and three
high cycles are observable.**

**Worse, and the part worth learning from: my disclosure question was malformed.**
`WO-0066` §1.6 asked *"is the predicate `delivered < 5`, or `0 < delivered < 5`?"*
**Both options were wrong.** The specification's predicate is `< 64` on octets
received between start and terminate. The auditor answered the one sound half —
does the floor include zero, yes — and **disclosed the real threshold in the
open**, in its §3 table and its §4. The disclosure function did its job *despite*
the axis being mis-stated by me, which is the strongest possible argument for
mandatory disclosures and the strongest possible argument against trusting the
person who writes them.

**Ruling — and the seal does not move.**

1. **Sub-cases 1 and 5 stand as sealed: MUST STAY GREEN.** If they redden, that is
   a **MUST-STAY-GREEN violation and a FINDING AGAINST ME**, scored exactly as
   `WO-0063B-VERDICT` §6.1's M03-D2 violation was scored against me and not
   against the manifest.
2. **It is the first of my own containment rule's two alternatives, not the
   second.** Seal §8's last row says a red outside the predicted set means *either
   my enumeration was incomplete or the diff reaches further than the class it
   names.* Here it is unambiguously **the first**: IC-E reaches exactly what IC-E
   says it reaches, and my enumeration used a threshold of five where the
   specification says sixty-four.
3. **Effect on IC-E's kill: none.** The seal's scored cell is sub-case 2, the
   manifest predicts it red, and the kill is decided there. The violation is an
   **enumeration finding**, not a scoring change — which is the seal doing its job
   rather than failing at it.
4. **Effect on the MUST-STAY-GREEN denominator: stated now, not later.** IC-E's
   sealed M03 denominator of **44** will read **42 held / 2 violated** if the
   manifest's prediction is borne out. The verdict reports it that way and does
   not silently re-baseline.

**FINDING WO-0066-3 (dv_lead)**: a sealed cell derived from a threshold I did not
read out of the specification I had cited. The packet's own spec basis names §12;
I quoted REQ-107's *class* correctly throughout and its *number* nowhere, and a
sub-five figure from §9 ruling 9's zero-delivered sub-class migrated into a
predicate about a different quantity.

---

## 4. THE VOIDING CALL — **NOT VOIDED.** Stated explicitly, and the exposure is priced rather than waved through

The disclosed ambient exposure is: the auditor's **own charter**, **PROTOCOL**,
**its own journal's entry headers**, and **git metadata** (subjects, trailers,
changed paths) — with no `test/**` read, listed or grepped, and the sealed
companion's **filename only** seen in a `--stat` line.

**The round is NOT VOIDED. The campaign may run.** Four grounds, two of which are
findings against me.

**(1) The charter, PROTOCOL and own-journal reads are my drafting defect, not a
violation. FINDING WO-0066-1 (dv_lead).** `WO-0066` §7 barred *"all of
`agents/**`"* without carving out the reads PROTOCOL §2 makes an agent's
**mandatory first actions** and that its own journal supplies as continuity
between stateless spawns. **An allowlist that forbids an agent from reading its
own charter is unexecutable**, and an agent that obeyed it literally could not
have written the manifest at all. The carve-out is stated here and **binds this
round and every later campaign**:

> An agent's **own** charter, `agents/PROTOCOL.md`, and its **own** journal are
> always readable and are never ambient exposure. The bar is on **other agents'**
> journals, on the round's **seal**, and on `test/**`.

**(2) The git-metadata channel is real, I did not price it, and this round
survived on someone else's editing. FINDING WO-0066-2 (dv_lead).** I measured the
channel rather than assuming it:

| commit | subject | seal content? |
|---|---|---|
| `ebaac58` (packet + seal) | *"Six classes sealed against eleven never-scored members - the packet and its seal in one commit"* | **none** — "six classes" is `WO-0066` §1, "eleven never-scored members" is §0. Both **freely told** in the packet |
| `199e319` (base) | *"The census stops being a hand measurement: both matchers printed, the stolen row named"* | **none** — packet §2 content |
| `--stat` on `ebaac58` | the seal's **filename** | **none** — the packet's own header names the file |

**Marginal leak: zero, measured.** But that is luck: my journal title for
`J-dv_lead-0115` continues *"…and the coincidence that makes three sub-cases the
round's best instrument is what makes two of them blind"* — which is seal §6
content, listed in seal §12 as **not to be told** — and it reached the commit
subject only in **truncated** form because the orchestrator shortened it. **A seal
commit's subject, and the authoring agent's journal title for it, are ambient to
every downstream reader and must not carry seal content.** That rule is mine to
keep and I did not keep it; it binds from this round.

**(3) Materiality, tested rather than asserted — three pieces of positive
evidence the exposure changed nothing.**

- **The auditor's ground for the IC-E collapse is different from and stronger than
  mine.** A reader of my §6 would have reproduced my observation-convention
  argument; it produced a bit-identical-waveform argument from §0.6, which is the
  better one.
- **The shape of question 1 is inconsistent with having read the answer.** It asks
  whether my seal predicts `R!` at 3/4/6. A reader of seal §3.3 sees `G✱` and has
  nothing to ask.
- **Decisively: the manifest's IC-E predicted red set {1, 2, 5} CONTRADICTS my
  seal's `G` at sub-cases 1 and 5.** A contaminated auditor matches the seal's
  cells; it does not falsify two of them from the specification. **The strongest
  independence evidence this round could have produced arrives as a by-product of
  an error of mine**, and it is worth more than any assurance either of us could
  have written.

**(4) The disclosure was unprompted**, was made when nothing would have detected
its omission, and is the second round running in which this auditor has disclosed
an ambient exposure at its own cost. That is not a ground for voiding; it is a
reason the process works.

**One thing I do NOT rule.** The manifest's §9 assessment — *"none of the four
could carry a cell of the seal or a line of the bench"* — is the auditor's
assessment and it was right to say the decision was not its own. The decision is
made here, on the record, before any result exists.

---

## 5. Findings from this note, all four against dv_lead

| id | finding | effect on the campaign |
|---|---|---|
| **WO-0066-1** | The allowlist barred `agents/**` wholesale, forbidding the constitutional reads PROTOCOL §2 makes mandatory. Unexecutable as written | **None.** Carve-out stated at §4(1); binds this and later rounds |
| **WO-0066-2** | Commit subjects and journal titles for a seal commit are an unpriced ambient channel; mine carried seal-§6 substance and was truncated by someone else | **None measured** (§4(2)); the discipline binds from this round |
| **WO-0066-3** | Seal §3.3's IC-E `G` at sub-cases 1 and 5 rests on a sub-five floor; §12 defines the runt at **fewer than 64 octets**. §1.6's disclosure question offered two wrong options | **A predicted MUST-STAY-GREEN violation at two cells**, scored against me, **no effect on IC-E's kill** (§3) |
| **WO-0066-4** | `WO-0066` §1.3 asserted both IC-B renderings exist; branch W is unrenderable at the base design | **None** — disposition 8 (§2) |

**Nothing is found against the manifest.** Six diffs, each minimal, independent
and revertible; all seven disclosures answered as facts of the diffs; R-DISC-1
discharged per sub-case and per lane with stimulus-contributed conjuncts called
out; R-DISC-2 delivered with seven cross-class gate facts tabulated; the §6
pre-ship check discharged as a **fan-out closure** on each mutated signal, which is
a stronger form than the packet asked for; the base SHA verified rather than
accepted; and **a literal rendering of IC-A rejected on the packet's own §9 terms**
because it would have raised a third and fourth strobe name. That last act is the
one `WO-0066` §9 exists to force and it is the second round in which this auditor
has refuted its own first rendering by evaluating a gate rather than reasoning
about fan-out.

---

## 6. RULING — the campaign MAY RUN, in this class order

**All six classes run. The order is for READING, not for gating**: no red stops
the campaign, and a class is never skipped because an earlier one failed.

| # | class | why here |
|---|---|---|
| **1** | **IC-C** | Its three REQUIRED GREENS — N sub-cases 1, 2, 5 — are the round's own control. If they redden, seal §7 disposition 2 fires and **every later report-path class's reds are read differently**. It is also the class most exposed to a datapath-perturbing rendering, so it gives the earliest signal on manifest quality |
| **2** | **IC-D** | Establishes the `/E/` control's green **before** the class that reddens only `/Q/`. A red at `/E/` fires disposition 2 for IC-D *and* IC-F together |
| **3** | **IC-F** | Read against IC-D's established `/I/` and `/E/` behaviour. The two classes are indistinguishable by any observation this bench makes (seal §10 item 4), so **their separation is carried entirely by running them apart and in this order** |
| **4** | **IC-B** | Six cells, one message body, the widest sweep at D-B2 = narrow. Run after IC-C so the MUST-STAY-GREEN sweep is read against a known-good control |
| **5** | **IC-E** | **Must** follow IC-C. IC-C's green at sub-cases 1, 2 and 5 is what establishes that IC-E's predicted red at 1 and 5 is IC-E's own reach and not a general report perturbation — which is exactly what makes §3's finding attributable to my enumeration rather than to the diff |
| **6** | **IC-A** | Bound 7's class: highest value, most branches, and the one whose verdict must not be contaminated. Run last, when every report-path and routing result is already in hand and a general perturbation has been excluded |

**Standing conditions on the run, unchanged**: one base SHA (`199e319`) for all
six and for the control; each manifest applied transiently and reverted fully; no
RTL-line or worker agent spawned while a manifest is applied; **not one byte under
`test/**` moves until the scorecard exists** — including by me, and this note
stages none.

---

## 7. What this note does not do

- **It does not edit the seal**, and the seal is not opened for editing at any
  point of this round. Its cells at IC-E sub-cases 1 and 5 are wrong and they stay
  wrong on the record, because a seal that gets corrected once a diff exists is
  not a seal.
- **It does not change any `R!` set, any kill count, or any pass criterion.**
- **It does not adopt a single claim about the RTL as a DV result.** Every
  derivation the auditor gives about `libs/**` is cited here as **the auditor's
  disclosed evaluation**. I have read no RTL and none of it enters a verdict as
  verification.
- **It does not pre-judge any outcome.** Every disposition above is conditional and
  was written before a transient was applied.

---

**Signed** dv_lead, `J-dv_lead-0116`, at `8869705` + this commit.
