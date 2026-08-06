# Journal: claude_dv_lead_agent — volume 06

- **Agent**: dv_lead (Opus 5 lead)
- **Charter**: agents/charters/dv_lead.md
- **Format**: v1 — entry grammar in agents/PROTOCOL.md §4
- **Volume**: 06
- **Continues-from**: J-dv_lead-0136
- **Previous-volume**: agents/journals/claude_dv_lead_agent.v05.md
- **Previous-volume-sha256**: 9aef3904d4b49116f202e1bc5a8425df6d9c318bfd1151ff6a03d24713f15503
- **Previous-volume-bytes**: 263428

This file is APPEND-ONLY. Content may only ever be added after the last line;
nothing above it is ever edited. Enforced by scripts/agent_commit.sh and CI.
Volume 05 is FROZEN: it is never appended to again, and any change to it breaks
this file's Previous-volume-sha256.

---

## [J-dv_lead-0137] 2026-08-10T04:20Z | task:WO-0074 | The eighth campaign adjudicated: seven of seven seeded classes killed with every sealed integer exact, the one unrenderable class convicting the design's single open-frame term, and three of my own rules corrected by a manifest that asked before it ran

### Trigger

Orchestrator dispatch, spawn short-id `WO-0074-ADJ-2/2026-08-10T04:20Z`, HEAD
`c38f4dc` — verified as my first action, per the dispatch's own bar. My
predecessor round stopped on a 120-commit container rollback, since restored and
journaled as incident three at `c38f4dc`; the campaign artefacts were never at
risk and I re-derived every figure at this tree rather than inheriting any.

The commission is my own: adjudicate `WO-0074`, the family-M mutation campaign,
against the sealed companion frozen with its packet at `ca1bb80`. The seeding
half landed at `adac5ca` (`J-auditor-0016`) carrying seven diffs, one self-
declared `NOT SEEDED`, ten disclosures and five pre-run questions, and **no
branch cut** — `FINDING WO-0074-A1`, ruled ACCEPTED, with the orchestrator
cutting the seven transients itself from the manifest's §11 table in the fixed
order. This entry opens volume 06: v05 crossed ADR-0017's 256 KiB threshold at
`ca1bb80` (263 428 bytes).

### Inputs

Read at `c38f4dc`, all read-only:

- `agents/charters/dv_lead.md`; `agents/PROTOCOL.md` — mandatory first actions.
- `agents/handoffs/WO-0074_family-m-mutation-campaign.md` in full, and its sealed
  companion `WO-0074_family-m-mutation-campaign-SEALED-predictions.md` in full —
  **opened only after every scorecard was in hand**, per §15.
- `docs/reports/audit/WO-0074-mutations/README.md` in full (1 083 lines,
  `adac5ca`): §0's affirmative blinding statement and its three self-disclosed
  exposures, §2's `FINDING WO-0074-A1`, §3's seven diffs and the IC-M5
  derivation, §4's inverted gate inventory, §5's per-lane per-member reachability
  discharge, §6's ten disclosure answers, §7's positive-form pre-ship check, §8's
  blast-radius rules, §9's five pre-run questions, §11's operator table.
- `docs/adr/ADR-0017-a-journal-is-a-chain-not-a-file.md` §4.3 and §4.4 — the
  rotation header fields and the four steps.
- `.github/workflows/build.yml` — to learn what the failing step prints, which is
  what made the scorecards recoverable at all.
- My own bench, for the stimulus facts two rulings turn on:
  `test/xgmii_rx_64/test_m03_b.ml`'s family header (every B-family row aborts
  strictly inside its own preamble; all three pinned reports land in the START
  word; `M03-N2`'s six sub-cases share that geometry),
  `test/xgmii_rx_64/test_m03_h.ml`'s header (`M03-H4`'s frames A and B both
  deliver zero octets), and unit counts across `test/`.
- `agents/journals/claude_orchestrator_agent.v02.md` and `tasks/BOARD.md` — for
  the era tally's prior figure, 41 sealed / 40 killed / 1 survived.
- **Disclosed RTL read, bounded**: the seven one-line patches carried by the
  transient commits, fetched through the API. No unmutated RTL was read. The
  reason is in Reasoning; the bench and the seal were frozen at `ca1bb80` before
  any diff existed, so nothing I read could reach a test.

CI, as externally verifiable references: `build` runs `31052415338` (control),
`31054172382`, `31054177436`, `31054174810`, `31054177858`, `31054177532`,
`31054179722`, `31054180874`, with their per-job STEP readings and each failing
job's promoted-source output.

### Reasoning

**Why the scorecards had to be rebuilt rather than received.** The auditor's half
is the seeding half and carries no scorecard by design; the run half is CI's, and
the dispatch is explicit that each class is scored from the `build` job's STEP
readings and test output **at the source, never the badge**. The workflow's step
6 prints, on failure, a PROMOTION BLOCK: `dune promote` applied, then sha256 plus
base64 of every promoted source. So the failing-**file** set is exactly the set of
promoted paths, and the failing-**unit** set is exactly the set of changed
`[%expect]` blocks. I recovered all seven blocks, verified every file against the
block's own sha256, and diffed each against the bench at the base SHA. That gives
a scorecard whose provenance is the job's own bytes and whose completeness is
mechanical: a unit that failed and was not listed cannot exist, because dune
promotes exactly what changed.

**The one methodological obstacle, recorded because it will recur.** The job-log
blob host is denied by this session's egress policy, so the logs were only
reachable through the MCP tool, whose output would have flooded the context. The
tool spills oversized results to disk; requesting the whole log deliberately
triggered that spill, and the seven logs were then processed locally at zero
context cost. This is worth knowing for the J and K campaigns.

**Adjudication order.** I scored the eight sealed cells character-for-character
before reading any of my own §3 matrix commentary, decoding the promoted source's
OCaml decimal escapes (`\194\167` is `§`) and treating `<n>` as the only
wildcard. Eight of the nine sealed cells instantiated; all eight matched exactly,
and **all eight derived integers were exact** — 1 at `M03-F3`, 2 at `M03-G1`,
`M03-E1`, `M03-H1`, `M03-H3`, `M03-G8`, `M03-F2`, and 3 at `M03-G7`. The one
seal in the campaign whose direction is *fewer* is the one that separates IC-M1
from every other class at a count-shaped cell, and it landed on the nose.

**The three rulings that decide the round all turn on the same defect in my own
seal, and the manifest caught all three before the run.** My rules for IC-M3,
IC-M4 and IC-M10 named the condition each class keys on but not the gates the
rendering was **not** permitted to remove. IC-M3's and IC-M4's rules said the
comparison runs "whatever the delivered count, zero included"; but the classes
retain `has_fcs`, because removing it too would make each of them *also* IC-M10 —
the combined diff my own §10 forbids. IC-M10's rule read only the octet count;
but the class reaches epoch-A closures only, because the in-word report vector
carries no FCS-report member at all. So my rules described wider classes than my
own packet permitted to be seeded, and §3.5's adjudication would have converted
seven required greens into findings against the manifest.

I sustained both questions, and I want the reason on the record: the corrections
are not concessions to the party being scored. They are derivable from my own
packet — §10 item 3 forbids the combined diff, so the sub-five conjunct is
*implied* by my own no-combination rule and I simply failed to write it — and the
run adjudicates them without ambiguity, because with the conjuncts restored the
corrected rules bound the observed red sets **exactly**, in both directions. No
red fell outside any rule, corrected or uncorrected. Every discrepancy runs in
the safe direction: my rules were too wide, never too narrow. A rule too wide
costs a correction; a rule too narrow would have cost the verdict.

I verified the load-bearing halves on my own side of the line rather than taking
the manifest's word. `M03-B3`'s and `M03-N2`'s in-word geometry is stated by my
own bench's family header; `M03-H4`'s zero-delivered frames are stated by its
own file header. The half I did not verify at the source is the claim that the
in-word report vector has no FCS bit — that is RTL, and I did not open it. I
adopt it on three grounds and say so plainly: it was declared before the run in
falsifiable form with line numbers; the run's nine-unit partition is exactly what
it predicts; and the only competing explanation, *the class was never seeded*, is
refuted by three reds elsewhere under the same diff. The claim is checkable in
history by anyone who wants it at the source.

**On IC-M5, I adopt the narrow form and think the narrow form is the better
result.** My own §8.1 rule 3 was loosely worded — "ruling 5 has no
datapath-silent mutant here" — and the auditor declined to assert the wide
reading. It is right to. What the campaign establishes is that *this* design has
exactly one open-frame term, `a_open`, and that term bounds the delivered extent,
so ruling 5's defect cannot be rendered here without moving the datapath; two
candidate renderings were attempted and both moved it, one stranding the aborted
frame's last word and one losing its final half word — a `BUG-0003`-signature
component. What it does not establish is that ruling 5 is inherently unrenderable:
a design carrying a separate report-side `frame_active` flag would have a
datapath-silent mutant. The narrow claim names what would have to change for
`M03-M5` to become scoreable; the wide one would have closed the question falsely.

**Why IC-M5 opens a fourth column in the era tally rather than folding into an
existing one.** A void class is not a kill and it is not a survivor. Folding it
into "killed" overstates coverage; folding it into "survived" libels a bench that
was never given anything to catch. 49 sealed, 47 killed, 1 survived, 1 void.

**The collision result is the round's methodological yield.** Collision 3
instantiated in full — three classes raising one message character for character,
integer included — and four sealed discriminators, every one of them a
measurement named in advance, separated them cleanly. Collision 2
half-instantiated: IC-M5's own sealed cell string was raised by IC-M3 as blast
radius, and `M03-E1`'s state is what says so, which was the commission's own
question. Collision 1 did not instantiate because only one branch was rendered,
and the separation was carried entirely by the disclosure plus the published
diff, for the third campaign running. But the run also produced a **fourth**
collision my seal did not name, at a **scored** cell: `M03-G8` under IC-M2 and
IC-M7, identical, `observed 2` in both. No kill was endangered — IC-M2 reddens
seven units of family G and IC-M7 exactly one — but the method failure is real
and general: I enumerated collisions from the cells I had marked, when the
classes that collide with a cell are usually not the class that owns it. The J
and K seals must derive the inventory from the cross product of every class's
predicted red set with every scored cell.

**The auditor's own pre-run collision prediction was wrong, and it was wrong
usefully.** It named IC-M3 ≡ IC-M4 as the branch-name-only pair. Their red sets
are disjoint, so no shared cell exists — the bench's `/E/`-abort and `/S/`-abort
families do not overlap, and the one unit carrying both characters is closed by
its `/E/` before the `/S/` arrives, which is ruling 5 itself keeping IC-M4 out.
The reasoning was sound and the premise false. It cost nothing precisely because
it was committed before the run in the form `WO-0063B`'s precedent requires. That
mechanism has now paid twice: once here, and three times over in the three
questions that corrected my rules.

**§4(c) reached its sharpest form yet and I want that recorded as the campaign's
structural result, not a footnote.** All 21 reds are exact-strobe-set messages;
not one datapath message, not one `test bug --`, not one monitor message appears
anywhere in seven scorecards. Since §3.1 measured the strobe-set assertion as the
last assertion in all twelve carriers, each of those 21 reds is a compound
statement: the strobe set changed **and** the whole delivered stream of that unit
is byte- and cycle-identical to the conformant one. At `WO-0063B` the datapath
signature had no domain; at `WO-0073` it was a side condition; here the check and
the qualification criterion are the same test, and one body of evidence
discharges both.

**What I did not let the scorecard become.** Twelve carriers reddening across
five files reads like breadth and is not. This campaign probes exactly one
instrument family, ten instances of the exact-strobe-set check, and says nothing
about the datapath assertions in the same units. Fourteen of the twenty-one reds
are blast radius contributing zero kills, and it is only §11's corrected
carrier/bound-row rule that keeps them from being read as qualifications —
`FINDING M-3` convicted a second time, now from the other direction.

### Actions

- Verified HEAD as the first action, before reading anything.
- Read the charter, the protocol, the packet, the seal and the manifest in full.
- Recovered all seven `build` jobs' promoted sources from their PROMOTION BLOCKs,
  sha256-verified each against the block's own checksum, and diffed each against
  the bench at `ca1bb80`, yielding the complete per-class scorecard.
- Verified each transient commit's parent (`ca1bb80` in all seven), its touched
  file (one), its subject, and its one-line patch against the manifest's §11
  substitution table.
- Re-measured the denominators at this tree: 59 M03 units, 139 repository-wide
  OCaml units, 140 by the contaminated script matcher, 79 non-M03 behavioural +
  1 build-level, `test/cosim/` 0.
- Scored the nine sealed cells by direct string comparison with escape decoding,
  and checked the three colliding rows for byte-identity across runs.
- Verified `test/**` unmoved between `ca1bb80` and HEAD — §8's adjudicator-
  ordering rule discharged at the tree.
- Wrote `WO-0074-VERDICT` into the packet's Return/verdict log, transcribing the
  auditor's return above it.
- Opened volume 06 with the ADR-0017 §4.3 header, recomputing
  `Previous-volume-sha256` and `Previous-volume-bytes` from the v05 blob at this
  tree rather than inheriting my predecessor's figures. They agree.
- Ran no `dune`. Ran no command that moves HEAD, the index or any ref. Committed
  nothing.

### Evidence

Reproducible at this commit; CI is the authority (ADR-0005).

```
git rev-parse HEAD                                                       -> c38f4dc
git diff --name-only ca1bb80 HEAD                                        -> 4 paths, none under test/
git show HEAD:agents/journals/claude_dv_lead_agent.v05.md | sha256sum    -> 9aef3904d4b49116f202e1bc5a8425df6d9c318bfd1151ff6a03d24713f15503
git show HEAD:agents/journals/claude_dv_lead_agent.v05.md | wc -c        -> 263428
grep -rh --include=*.ml 'let%expect_test' test/xgmii_rx_64/ | grep -c .  -> 59
grep -rh --include=*.ml 'let%expect_test' test/ | grep -c .              -> 139
grep -rh 'let%expect_test' test/ | grep -c .                             -> 140   (FINDING M-4)
```

Control: `build` run `31052415338`, head_sha `ca1bb80`, conclusion **success**;
all ten steps green including step 8 (nothing unpromoted) and step 9
(`tools/dv_checks.sh`); `cosim` job `92462381713` success; `journal-check` run
`31052415272` success.

Transients — every one `success` at the `build` job's step 5 (Build) and
**failure** at step 6 (tests), with `cosim` **success**:

| class | branch | head | run | scored cell | observed |
|---|---|---|---|---|---|
| IC-M1 | `mut/wo-0074-m1` | `cd06175` | `31054172382` | `M03-F3` | `observed 1 pulse(s)` |
| IC-M2 | `mut/wo-0074-m2` | `ccf7228` | `31054177436` | `M03-G1` | `observed 2` |
| IC-M3 | `mut/wo-0074-m3` | `798dc64` | `31054174810` | `M03-E1` | `observed 2` |
| IC-M4 | `mut/wo-0074-m4` | `7178c4d` | `31054177858` | `M03-H1` | `observed 2` |
| IC-M6 | `mut/wo-0074-m6` | `59f1c57` | `31054177532` | `M03-G7` | `observed 3` |
| IC-M7 | `mut/wo-0074-m7` | `170a2c2` | `31054179722` | `M03-G8` | `observed 2` |
| IC-M10 | `mut/wo-0074-m10` | `91cef40` | `31054180874` | `M03-F2` | `observed 2` |

Reds per class, in file order: IC-M1 `{F3}`; IC-M2 `{G1, G2(1519), G3, G4, G6,
G7, G8}` — all seven units of family G; IC-M3 `{E1, H3}`; IC-M4 `{H1, H2,
N2(S0/A0 delivered), N2(S4/A4 delivered), N4}`; IC-M6 `{G6, G7}`; IC-M7 `{G8}`;
IC-M10 `{F2(0 octets), G7, I2(member iii)}`. Twenty-one reds, every one an
exact-strobe-set message, every one carrying a `lane 0` prefix. MUST-STAY-GREEN:
58/52/57/54/57/58/56 of 59 M03 units, **79 of 79** non-M03 behavioural units and
the single build-level unit green under all seven, `test/cosim` green under all
seven and worth nothing.

Load-bearing greens: `M03-F1` green under IC-M1 and under IC-M10; `M03-G3` green
under IC-M6 (`FINDING M-1` **measured**); `M03-G4` green under IC-M7
(`FINDING M-2` **measured**). Four measurable, four held. The remaining two `G!`
cells belong to IC-M5 and are unmeasured.

### Outcome

**DoD met.** `WO-0074-VERDICT` is committed into the packet, not asserted in
chat, and it carries every item §15 asks for: per-class verdict with run id and
scored cell, the load-bearing greens, the MUST-STAY-GREEN denominators, the
collisions with their discriminators, the four rulings, the qualified rows, the
blast-radius inventory per class, the declarations, the findings, the era tally,
the non-closures and what I commission next.

**Verdict**: 7 of 7 seeded classes **KILLED**; 7 of 8 sealed classes seeded;
**IC-M5 VOID by declaration**; zero survived; zero MUST-STAY-GREEN violations;
zero scope findings; zero build findings; no `BUG-`.

**QUALIFIED** — seven M rows, each on one kill, with the carrier row named
alongside it: `M03-M1`/`M03-F3`, `M03-M2`/`M03-G1`, `M03-M3`/`M03-E1`,
`M03-M4`/`M03-H1`, `M03-M6`/`M03-G7` (first-epoch carrier alone),
`M03-M7`/`M03-G8` (first-epoch carrier alone), `M03-M10`/`M03-F2` (that carrier
alone). **NOT and cannot be**: `M03-M5` (SCORED AND UNQUALIFIABLE at this
design), `M03-M8` (no stimulus), `M03-M9` (no instance), `M03-B3`'s own row
(structurally out of reach), `M03-H3`'s own row (its only red is blast radius).

**Era tally**: 41/40/1 before; **49 sealed, 47 killed, 1 survived, 1 void by
declaration** after — family L's 5/5 inside the prior figure, family M
contributing 8 sealed / 7 killed / 1 void.

**Four findings, all against my own instruments**: `WO-0074-S1` (the IC-M3 and
IC-M4 rules omit the retained sub-five conjunct), `WO-0074-S2` (the `G!` count is
six, not seven), `WO-0074-S3` (the IC-M10 rule reads only the octet count),
`WO-0074-S4` (the collision inventory is incomplete, and the method that made it
so). S2 additionally covers the seal's instrument-count slip — §2.2 and §10(g)
say eleven/tenth/ten where §2.1's own measured fact gives twelve, one per
carrier. All MINOR, all counting or scoping errors in prose over matrices that
are themselves correct, none changing a kill. `FINDING WO-0074-A1` is the auditor's and
was ruled ACCEPTED; its DV-side consequence is nil and the verdict records why.

**One new standing declaration**, `WO-0074-D1`: at this design the in-word
(epoch B/C) strobe path is unfalsifiable for ruling 9, the in-word report vector
carrying no FCS-report member at all. A grammar gap, like the co-simulation
anchor's, not a stimulus gap. Carrier: the post-campaign `AP-` round.

`OBSERVATION M-O1` and `FINDING M-O1a` are **answered in both rows' favour and
CLOSED**; the second-content repair they would have commissioned is not
commissioned.

**No `SO-` issues and none is offered**: families J and K are unscored and the
charter §3 differential co-sim anchor is undischarged per class and now blind per
strobe.

**Handoff**: `agents/handoffs/WO-0074_family-m-mutation-campaign.md`. Commissioned
next, in order: (1) the post-campaign `AP-` round, whose window §8 has now
reopened; (2) the cosim-lane round, which pays five items from one measurement;
(3) the family J campaign packet, then (4) family K; then the `SO-`.

**Lessons harvest**: **not due this round.** ADR-0018 and PROTOCOL §7 place it at
every `SO-` and every phase gate; this is a campaign verdict and `WO-0074` §13
item 8 already named the `SO-` as its carrier. The span from my last harvest
stays open and is declared rather than skipped. Three candidates are banked
against it, none admitted here: (i) a rule that names the condition a class keys
on must also name every gate the rendering may **not** remove, or it silently
describes a wider class than the campaign permits; (ii) a collision inventory
must be derived from the cross product of predicted red sets with scored cells,
because the classes that collide with a cell are usually not the class that owns
it; (iii) where a condition has more than one physical reporter, a coverage claim
must name which reporter each bound assertion observes. Each will be tested
against LH1–LH3 at the harvest.

### Open-questions

1. **`DECLARATION WO-0074-D1`'s source-side half is adopted, not verified by
   me.** The claim that the in-word report vector carries no FCS-report member is
   the auditor's, made before the run with line numbers, and I did not open the
   RTL to check it. The run's nine-unit partition is consistent with it and
   inconsistent with the only alternative, and my bench supplies the in-word
   geometry independently. If the auditor's re-execution sampling or the `AP-`
   round wants it confirmed at the source, that is cheap and I recommend it.
2. **The residual anti-vacuity risk at `M03-M2` and `M03-M4` is now measured but
   remains *fixed*, not random.** Both rows drive one distinct delivered content
   each, and both were shown to mismatch. A future campaign inherits the same two
   contents. I judge no repair owed; a second content at either carrier remains
   cheap insurance if a later round wants it.
3. **`WO-0047` §2's 4-octet member is still shadowed.** The repair is a member
   reorder in `test_m03_f.ml` costing no stimulus, and the `AP-` round is the
   first commit that may make it now that §8's window has closed.
4. **Nothing is escalated.** No `BUG-`, no `E`-class item, no spec-queue
   addition — a nil escalation, declared rather than omitted.

### Files-in-this-commit
- agents/handoffs/WO-0074_family-m-mutation-campaign.md

## [J-dv_lead-0138] 2026-08-10T05:30Z | task:none | The eighth campaign is absorbed into the plan — and writing the blast-radius table row by row is what shows that the plan's own "kills its M row by construction" sentence is the difference between seven kills and twenty-one

### Trigger

Orchestrator dispatch, spawn short-id `AP-batch-10/2026-08-10T05:30Z`, HEAD
`bb81fe5` — verified as my first action, per the dispatch's own bar, and matching
the expected SHA exactly. The commission is my own: `WO-0074-VERDICT` §14 item 1,
the post-campaign `AP-` round, named there as *the next commit opening
`test/attack_plans/**`, and the first thing that should run*. `WO-0074` §8's
ordering rule froze this file for the campaign's whole window; the campaign has
scored, so the window has reopened and this is that round.

### Inputs

Read at `bb81fe5`, all read-only. **No RTL was opened in this round, at all.**

- `agents/charters/dv_lead.md`; `agents/PROTOCOL.md` — mandatory first actions.
- `agents/handoffs/WO-0074_family-m-mutation-campaign.md`, the whole
  `WO-0074-VERDICT` section (§1–§15) plus §8's ordering rule, §10's collision
  inventory, §11's carrier/bound-row rule and §12's pass criteria — this round's
  entire source material.
- `test/attack_plans/AP-xgmii_rx_64.md` in full: §0.1's set-claim rule, §1's
  closed status vocabulary, §2's obligation 4 inventory, §4.M's rows and its
  landed-status block, §4.B/E/F/G/H/N's carrier rows, §7's X-rows and its U-1/U-2
  block, §9's change log — and §4.L's post-campaign block **as the template this
  round follows**.
- `agents/journals/claude_dv_lead_agent.v06.md`, `J-dv_lead-0137` — my own
  adjudication entry, for the figures and the three banked harvest candidates.
- `tasks/BOARD.md` and `agents/journals/claude_orchestrator_agent.v02.md` — for
  the era tally's prior figure (41 sealed / 40 killed / 1 survived).
- **Quoted, not verified**: `docs/reports/audit/WO-0074-mutations/README.md` is
  cited at two places in the plan text for design-side facts (`a_open` at line
  296; the in-word report vector's missing FCS-report member). I did **not** open
  it in this round and I did not open the RTL either; both are quoted from the
  committed artefact with the provenance and the non-verification stated **in the
  plan text itself**, at `M03-M5` and at §7's U-3.

Independence (PROTOCOL §10, charter §8): this round derives nothing from RTL.
The one bounded RTL read in this thread was the seven one-line transient patches
at `J-dv_lead-0137`, disclosed there; nothing read then reaches a test, and
nothing is read now.

### Reasoning

**Why one commit and not several.** The verdict enumerated nine debts against
this file and every one of them is a statement about the *same* eight classes and
the *same* twenty-one reds. Splitting them would have produced a plan in which a
row says QUALIFIED before the block that defines what qualification excludes
exists — which is the failure family L's round was built to avoid. One coherent
edit set, history kept and ground replaced, exactly as `J-dv_lead-0135` did it.

**The keep-and-replace discipline, and why it is not cosmetic here.** §4.M's
landed-status block made four closing claims. Two were promises to a future
round: item (3) carried `OBSERVATION M-O1` *to* the campaign, item (4) declared
the family unscored. Both are now paid, and the honest way to record that is to
**leave both sentences standing** and say beside them what the world did — never
to edit a dated claim into its own outcome. The third is different in kind and
worse: item (4)'s second sentence says a class killing a carrier kills its M row
*"by construction"*. That is `FINDING M-3`, and this round is where it is
convicted for the second time.

**The blast-radius table is the round's real work, and writing it out is what
made the number visible.** Twenty-one reds, seven kills. Fourteen reds — two
thirds of the campaign's whole output — qualify nothing. Every one of those
fourteen landed on a **bound carrier**, which is precisely the population the
"by construction" sentence quantifies over. So the sentence is not merely loose:
under it this family reports **twenty-one** kills instead of seven, and the only
thing standing between those two numbers is §11's corrected rule. I wrote the
per-class table into the plan rather than the summary figure, because the
summary figure is the thing a later scorecard would quote and the table is the
thing that survives §0.1.

**Where each item landed, and why there rather than elsewhere.** Qualification is
a property of an **instrument**, so it belongs in the row whose instrument it is —
which is why the seven M rows *and* their seven carriers each carry it, each
saying in terms that the kill is **one** kill shared, never two. The two
permanent negatives (`M03-M8`, `M03-M9`) belong in their own cells because a
scorecard reader meets them there and nowhere else. `DECLARATION WO-0074-D1` is a
statement about what **no mutation class can reach**, which is exactly what §7's
U-1/U-2 block is for — so it lands there as **U-3**, with its row-level bars at
`M03-B3`, `M03-N2` and `M03-M10`. The four seal findings land in the
post-campaign block, where family L's `WO-0073-D3`/`D4` are, because they are
findings about **how a seal is written** and the next seal's author reads the
plan, not the packet.

**Why U-3 is written beside the U-table's heading rather than inside it.** The
heading says *"TWO INSTRUMENTS"* and the block is dated. U-1 and U-2 are
**bench-side** unreachabilities — an assertion closed by a sibling in the same
unit. U-3 is **design-side**: the report grammar has no member for the defect to
displace. Same consequence class, different cause, and folding the second into
the first would have destroyed the distinction while silently falsifying a
committed count. So the heading and its table are left unedited and the third is
recorded beneath with the difference stated — this section's own standing
disposition, the one it paid for at `RV-0039-VERDICT` F-2.

**Three precision errors I made and caught before finishing, recorded because
they are the same error each time.** (a) I first wrote `M03-E1`'s shadowed
members as *"the remaining fifteen, and every lane-4 member"* — double-counting,
since the lane-4 members are inside the sixteen. (b) I first wrote `M03-F2`'s as
*"every lane-4 member of this file"*, a claim about a file I had not measured.
(c) I first called the co-simulation lane's strobe blindness *"the third
recorded blindness of that lane"*, an ordinal I had not counted; there are two.
All three are set claims asserted in prose without measurement — §0.1's own
failure mode, committed by §0.1's author while writing a block that cites §0.1.
They cost nothing because they were caught, and I record them because the rate at
which they appear is the argument for the rule.

**What I declined to do, and it was commissioned as conditional.** The verdict
says `WO-0047` §2's 4-octet member reorder *"should ride this round **if** it
opens `test_m03_f.ml`"*. This round does not open it, and it should not: the
dispatch scopes me to the plan file, and a plan round does not improve a carrier
(`J-dv_lead-0112`, applied to `OBSERVATION L-O1` and to `WO-0073-D3` before it).
The condition is unmet, so the item is **recorded at `M03-F2` with its carrier
named** — the next commit opening that file — rather than evaporating into a
good intention. Same disposition for `FINDING M-4` (carrier: the cosim-lane
round, which opens `tools/`) and for the co-simulation lane's strobe blindness,
whose §7 banner entry is that round's to write, not this one's.

**The fourth column, and why the plan carries the era tally at all.** A void
class is not a kill and not a survivor. The tally lives in `tasks/BOARD.md`,
which is the orchestrator's; but the *argument* for the fourth column is a
statement about what a mutation class can and cannot establish, and that argument
belongs where the classes are argued. So the plan carries the line — 49 sealed,
47 killed, 1 survived, 1 void by declaration, 47 + 1 + 1 = 49 — with the reason
beside it: collapsing the void into *killed* overstates coverage, and collapsing
it into *survived* libels a bench that was never given anything to catch.

### Actions

- Verified HEAD as the first action, before reading anything: `bb81fe5`, the
  expected SHA.
- Read the charter, the protocol, the whole `WO-0074-VERDICT`, and this plan in
  full including §4.L's post-campaign block as the template.
- Edited **twenty row lines** in one file, adding to their `Kills` cells (and, at
  `M03-M6`/`M03-M7`, a pointer clause in the `Stimulus` cell where each finding
  is stated): the seven M rows QUALIFIED with carrier and run id; `M03-M5` SCORED
  AND UNQUALIFIABLE at this design on the narrow form; `M03-M8`/`M03-M9`
  unscoreable and unscored; the seven carrier rows (`M03-F3`, `M03-G1`,
  `M03-E1`, `M03-H1`, `M03-G7`, `M03-G8`, `M03-F2`) each recording that its kill
  is the **same single kill** as its bound row; and the three declared negatives
  (`M03-H3`, `M03-B3`, `M03-N2`).
- Inserted the **FAMILY M — POST-CAMPAIGN STATUS** block after the landed-status
  block, keeping the latter whole: campaign identifier table with all seven
  branch heads and run ids, the verified ordering rule, re-measured denominators,
  MUST-STAY-GREEN per class, the twelve-row status table, the blast-radius
  accounting, §4(c)'s result, the four seal findings, the era tally with its
  fourth column, and nine "what this does and does not buy" refusals.
- Added **`DECLARATION WO-0074-D1` as U-3** at §7, beside U-1/U-2, leaving their
  heading and table unedited and stating the bench-side/design-side distinction.
- Appended the §9 change-log row.
- Re-measured the plan's status counts by a status-cell pass **before and after**
  the edits, and re-ran `tools/dv_checks.sh`'s census.
- Ran no `dune`. Ran no command whose effect moves HEAD, the index or any ref.
  Committed nothing. `test/**` outside this file is untouched.

### Evidence

Reproducible at this commit.

```
git rev-parse HEAD                                     -> bb81fe5   (spawn HEAD, unchanged)
git status --porcelain                                 -> M test/attack_plans/AP-xgmii_rx_64.md   (one path)
git diff --stat ca1bb80 HEAD -- test/ libs/ tools/ docs/specs/   -> empty  (the campaign base's tree)
grep -rh --include=*.ml 'let%expect_test' test/xgmii_rx_64/ | grep -c .   -> 59
grep -rh --include=*.ml 'let%expect_test' test/ | grep -c .               -> 139
grep -rh 'let%expect_test' test/ | grep -c .                              -> 140   (FINDING M-4, unrepaired)
bash tools/dv_checks.sh                                -> 78 declared / 62 boundary / 62 naive; every check that COULD run passed
```

**Plan counts, measured from this file by a status-cell pass over every row
table, before AND after the edits — not carried forward:**

```
before:  78 rows | ASSERT 62 | NO-ASSERT 7 | NO-STIMULUS 4 | STRUCTURAL 4 | GAP 1
after:   78 rows | ASSERT 62 | NO-ASSERT 7 | NO-STIMULUS 4 | STRUCTURAL 4 | GAP 1
```

**Unmoved, and that is the rule rather than an oversight**: qualification measures
an instrument, discharges no row and moves no count. Every one of the 78 row lines
still parses to exactly six cells after the edits, verified mechanically; the
diff removes 20 lines and re-adds them modified, and removes nothing else.

**Discharge census, re-measured rather than quoted (§0.1)**: 78 row ids declared,
**62** named in a committed unit title under the trailing-digit boundary matcher
and 62 under the naive one, − `M03-A4` (NO-ASSERT, named in a title) + `M03-F5`
(by citation) = **62 of 62**. No unit and no title moved in this round.

Externally verifiable references carried into the plan — CI run ids and their
conclusions, all quoted at the rows and in the block: control `31052415338`
(`success`, `ca1bb80`); IC-M1 `31054172382`, IC-M2 `31054177436`, IC-M3
`31054174810`, IC-M4 `31054177858`, IC-M6 `31054177532`, IC-M7 `31054179722`,
IC-M10 `31054180874` — each `failure` at the `build` job's step 6, `success` at
step 5, `success` at its `cosim` job.

**Nothing in this round is a test result**: no bench ran, no `dune` was invoked,
and the plan's claims are all citations of runs already in history at
`70cf13c`'s verdict.

### Outcome

**DoD met**, against `WO-0074-VERDICT` §14 item 1's enumeration, item by item:

| commissioned | where it landed |
|---|---|
| Seven M rows QUALIFIED with carriers and run ids | `M03-M1`…`M03-M4`, `M03-M6`, `M03-M7`, `M03-M10` Kills cells, **and** the seven carrier rows' own Kills cells, each stating the kill is one kill shared |
| `M03-M5` SCORED AND UNQUALIFIABLE at this design | `M03-M5`'s Kills cell, narrow form, with the design-side fact quoted and its non-verification disclosed |
| `M03-M8`/`M03-M9` unscoreable | their own Kills cells, with the consequence that a full scorecard is not full coverage of §4.M |
| `FINDING M-3`'s correction of item 4 | the post-campaign block's blast-radius accounting: 21 reds, 7 kills, 14 qualifying nothing |
| `FINDING M-1`/`M-2` MEASURED | `M03-M6`/`M03-M7` Kills cells + a pointer in each Stimulus cell where the finding is stated, and at `M03-G7`/`M03-G8` |
| `OBSERVATION M-O1` / `FINDING M-O1a` CLOSED in both rows' favour | `M03-M2` and `M03-M4` Kills cells, and the block; the second-content repair is **not** commissioned |
| `DECLARATION WO-0074-D1` | §7 as **U-3**, beside U-1/U-2, plus row-level bars at `M03-B3`, `M03-N2` and `M03-M10` |
| `FINDING WO-0074-S1`/`S2`/`S3`/`S4` | the post-campaign block, with S4's corrected method banked as a bar on the family J and K seals |
| Era tally, fourth column named | the post-campaign block: 49 / 47 / 1 / 1 |
| Change-log row | §9, thirteen numbered items, counts stated before and after |

**Not done, deliberately, each with its carrier named in the plan**: `WO-0047`
§2's 4-octet member reorder (condition unmet — this round does not open
`test_m03_f.ml`); `FINDING M-4`'s matcher repair (cosim-lane round); the
co-simulation lane's strobe-blindness §7 banner entry (cosim-lane round);
`WO-0073-D3`'s `M03-I4` mislabel and `OBSERVATION L-O1` (their own carriers,
unchanged).

**No `SO-` is opened or offered**, and the lessons harvest is **not due this
round**: ADR-0018 and PROTOCOL §7 place it at every `SO-` and every phase gate,
`WO-0074` §13 item 1 named the `SO-` as its carrier, and this is a plan round.
The span since my last harvest stays **open and declared, never skipped**, with
the three candidates banked at `J-dv_lead-0137` untouched and unadmitted here.

**Handoff**: `test/attack_plans/AP-xgmii_rx_64.md`, to the orchestrator for
commit. Commissioned next, unchanged in order: the cosim-lane round (five items
from one measurement), then the family J campaign packet, then family K, then the
`SO-`.

### Open-questions

1. **`DECLARATION WO-0074-D1`'s source-side half is adopted in the plan, not
   verified by me**, and the plan says so at U-3 in terms. Carried forward from
   `J-dv_lead-0137` Open-question 1 because it is now written into a standing
   declaration rather than a verdict: confirming at the source that the in-word
   report vector carries no FCS-report member is cheap, and I recommend the
   auditor's re-execution sampling take it.
2. **`M03-M5`'s `a_open` line reference is a design-side citation inside a DV
   artefact.** I judge it admissible — it is quoted from a committed audit
   artefact, attributed, and marked unverified — but it is the first line number
   of RTL this plan has carried, and if the auditor reads that as an
   independence smell I will replace it with a citation to the audit README
   without the line.
3. **Nothing is escalated.** No `BUG-`, no `E`-class item, no spec-queue
   addition — a nil escalation, declared rather than omitted.

### Files-in-this-commit
- test/attack_plans/AP-xgmii_rx_64.md

## [J-dv_lead-0139] 2026-08-10T06:20Z | task:WO-0075 | Five debts paid from one round — and the round's own measurement corrects the declaration that commissioned it: the anchor's strobe blindness is bound by its STIMULUS, not by its grammar, so the field I was asked to price would have bought nothing

### Trigger

Orchestrator dispatch, spawn short-id `WO-0075/2026-08-10T06:20Z`, HEAD
`6f0fd5b` — verified as my first action, before reading anything, and matching
the expected SHA exactly. Working tree clean at that verification.

The commission is my own: `WO-0074-VERDICT` §14 item 2, **the cosim-lane
round**, which pays five items measured across two campaigns —
`WO-0073-D2` (the lane is content-comparing, not timing-comparing; option (a)
ADOPTED at `J-orchestrator-0215`), `WO-0074-VERDICT` §11 item 1's strobe
blindness with the decision the packet named, `FINDING M-4`, `WO-0073-D5`, and
`test/cosim/dune`'s dangling `test/cost_probe/` reference. The dispatch left the
scoping call to me: one `WO-` packet, or a direct dv round.

### Inputs

Read at `6f0fd5b`, all read-only. **No `libs/**` and no `rtl_snapshots/**` were
opened at any point in this round.**

- `agents/charters/dv_lead.md`; `agents/PROTOCOL.md` — mandatory first actions.
- `docs/specs/requirements.md` — **REQ-901** in full (the *"transactional, not
  cycle-by-cycle"* sentence, the cycle-alignment exclusion, the lettered class
  list including **(e)** and **(f)**, and the closing "never a licence to take an
  expected value from the reference"); **REQ-107**, **REQ-108**, REQ-005,
  REQ-111, §0.2's strobe definition.
- `docs/specs/modules/xgmii_rx_64.md` — §4.1's output record, §6.1's `m + 3`
  formula, its D(m) paragraph and its **cycle-by-cycle worked table**, §7's drain
  bound, §9's strobe table.
- `agents/handoffs/WO-0074_family-m-mutation-campaign.md` — §11 items 1–10, §12's
  tally, §13, §14, the IC-M class definitions and §11's branch/run table;
  `agents/handoffs/WO-0073_family-l-mutation-campaign.md` — §10's findings table
  (D1–D5), §10.2's adjudicated co-sim red, the IC-L class definitions, §12.
- `test/cosim/**` in full: `canonical.mli`, `canonical.ml`, `compare.ml`,
  `ours_run.ml`, `stimulus_gen.ml`, `tb_xgmii_rx_64.v`, `dune`;
  `tools/cosim/run_cosim.sh` and `tools/dv_checks.sh` in the regions touched.
- `test/attack_plans/AP-xgmii_rx_64.md` §7's banner in full (bars 1, 2, 3 and the
  X-table), §9's tail.
- `test/third_party/verilog-ethernet/axis_xgmii_rx_64.v` — **its published port
  list and the six assignment sites of `error_bad_frame`/`error_bad_fcs`**, read
  under charter §9's MIT permission and used only to establish that the
  reference's `error_bad_frame` is raised on a bad FCS as well as on an error
  character. This is the differential oracle, not our design; nothing derived
  from it enters an expectation (REQ-901's own last sentence, ADR-0015 D2).
- `agents/journals/claude_dv_lead_agent.v06.md`, `J-dv_lead-0137` and
  `J-dv_lead-0138`; `agents/journals/claude_orchestrator_agent.v02.md`,
  `J-orchestrator-0215` (the ruling itself, read rather than quoted from my own
  verdict).

### Reasoning

**The scoping call, and it is a split rather than a choice between the two
offered shapes.** Three of the five items are one-line defects in shipped
instruments — a matcher that reads a directory, a label that names the wrong
stage, a comment that points at a deleted directory. Sending those through a
worker loop would cost two rounds each to change eleven characters of behaviour,
and one of them (`test/cosim/dune`) has a declared carrier that is *this commit
by definition*: "the first commit to open `test/cosim/`". **They land directly.**
The other two are not small: the D2 extension changes a **pinned grammar** across
two independent producers, one OCaml and one Verilog, in a lane that **cannot be
executed anywhere in this programme's development environment** — no Hardcaml
toolchain, no iverilog, ADR-0005. A change nobody can run is a change whose only
review is the `RV-` loop, and writing it myself would make me sole author and
sole reviewer of exactly the artefact class where that is least defensible.
**Those two go out as `WO-0075`**, which is also what §7's own banner already
ruled ("the `WO-` is dv_lead's to draft in the cosim-lane round"). The decision
content — what is compared, what is refused, what a red means — is mine and is
frozen **in** the packet rather than left to a worker to invent.

**The round's real finding is against my own declaration, and I found it by
reading the stimulus generator instead of my own verdict.** `WO-0074-VERDICT`
§11 item 1 states that the anchor is blind to the family-M campaign **"by
grammar"** — the canonical form has no strobe field. That sentence is true and it
is not the binding constraint. The lane drives **one 64-octet good-FCS lane-0
frame**: no second frame, no error character, no bad FCS, no runt, no oversize,
no abort. I walked all seven seeded classes against that stimulus and **not one
is rendered**: IC-M1 needs a runt with a wrong FCS, IC-M2 an oversize frame, IC-M3
an error character, IC-M4 a second start character, IC-M6 and IC-M7 the `Discard`
state, IC-M10 differs only below five octets. **A strobe field added today would
be an all-zero column on every line of every run, under every one of the seven.**
The blindness is **stimulus-bound first, mapping-bound second, grammar-bound
third**, and I named the third.

**So the decision the packet asked for is NO, and it is a refusal rather than a
deferral, because the deferral would have been the more comfortable answer and
the wrong one.** Three grounds, all measured. (a) Zero of twelve — a strobe field
buys detection of no class either campaign has seeded. (b) The comparable set is
bounded above by **one** of M03's five strobes, and the bound is in the **frozen
spec**: `error_runt` is REQ-901's class (e) and `error_oversize` its class (f),
both of which bar 2 already reaches; `error_start_without_terminate` has no
counterpart output at all; and `error_bad_frame` exists on both sides **and is a
different signal** — the reference raises it on a bad FCS too, where §9's table
gives that event to `error_bad_fcs` alone, so a name-keyed comparison would red a
**conformant** M03. (c) An all-zero column would make the lane *look*
strobe-aware to every future reader, turning §11 item 1's *"that green is
evidence of nothing"* from **true** into **invisible** — this programme's
catalogued failure at its fifth instance. A refusal with three ordered
preconditions is checkable; a deferral is not.

**And the D2 extension collides with the ruling that commissioned it, which is
the hardest thing in this round and the thing I will not paper over.**
`J-orchestrator-0215` adopted option (a) in the words *"the lane gains an
explicit cycle comparison"*. **REQ-901 says, in terms: "Cycle alignment, internal
pipelining and latency constants are deliberately not compared: ours are pinned
by REQ-005 and REQ-111, the reference's are its own."** A cross-side cycle
comparison would assert the one quantity the frozen requirement excludes **by
name** — and it would be wrong on the merits too, since two independently
designed receivers owe each other no pipeline depth, so the assertion would red a
conformant design and the only way to green it would be to take an expected value
from the reference, which REQ-901's own closing sentence and ADR-0015 D2 both
forbid outright.

**I therefore implemented the ruling's intent and not its wording, and recorded
the divergence rather than resolving it quietly.** The intent is *the anchor must
be able to see time*. The packet delivers exactly that in three tiers: **T0**
asserts that the two producers index the same stimulus identically — a
cross-side check whose subject is the *stimulus file*, not either design, so the
exclusion does not reach it; **T1** asserts **our** side against **SPEC-M03
§6.1's own `m + 3` formula and its worked cycle table** — spec-derived, taking
nothing from the reference, and reddening on all eight words under IC-L2's
uniform ΔC 3 → 4; **T2** records the reference's cycles and reports them as
data, *never adjudicated* — which is not an invention but REQ-901's own
disposition for the sub-5-octet frame, applied to time.

**Two design choices inside that shape are load-bearing and I record why each
survived, because both had an attractive wrong version.** *First*, I nearly
specified the cross-side offset as a fitted constant K, required equal across the
run. **That design is blind to IC-L2 and I nearly shipped it**: a *uniform* shift
moves K uniformly, so "K is constant" still holds and the class that motivated
the whole finding walks straight through. The blindness of the fix would have
reproduced the blindness it was fixing, one level up. *Second*, the cycle token is
**decimal, not hex**, and that is not a style choice: it sits immediately before
the variable-length octet list, so a decimal token makes an old-format file
**unparseable rather than misparseable** — feed today's writer's output to the new
reader and `0f` fails at the cycle position, `compare` exits 3, NO-VERDICT, loud.
**A half-landed grammar change can therefore never produce a false green**, which
is the property that makes either landing order safe (§11 of the packet) and is
the reason for the choice rather than a consequence of it.

**On the `AP` moving, against the dispatch's line.** The dispatch says the plan
does not move this round and pre-resolves the conflict in favour of my artefacts.
My artefacts do say otherwise — `WO-0074-VERDICT` §14 item 2 and `J-dv_lead-0138`
both name this round as the §7 banner entry's carrier — but the decisive argument
is not precedence, it is **that the home already holds half the statement**. §7's
banner carries bar 3, the timing blindness, in full. A second blindness of the
same instrument recorded anywhere else leaves the banner telling half the story
to the one reader it exists for: the author of the next sign-off packet, who
checks bars and not journals. **So bar 4 lands beside bar 3, and the edit is
confined to §7's banner plus one §9 row** — no cell, no status, no count, so the
plan's own numbers are untouched and re-measured to prove it.

**What I declined.** I did not add `EXIT_TIMING` to `run_cosim.sh` while I was in
that file. It would be a code with no producer — dead contract shipped ahead of
its use — and the exit-code table went through the `RV-` loop at `WO-0049` §8, so
it moves with its half and not with a convenience. I did not touch the stimulus,
the two sampling conventions, or `compare_words`; the packet forbids all three
explicitly, and the reason for the first is that a second frame folded into a
grammar change makes a failing CI run un-diagnosable between two independent
causes.

**One repair I made that was not commissioned, declared rather than folded in.**
`tools/dv_checks.sh`'s repaired line also carried `|| printf '0'` — the exact
double-zero bug the same file's comment eighteen lines above forbids by name,
recording that it was *"fixed once at WO-0034 and reintroduced here — left
commented so it is not a third time"*. It was a third time. Latent, never fired,
and removed here because the line was open and the warning it violates is four
inches above it. Same disposition for `test/cosim/dune`'s stale *"the main
suite's fifteen %expect_test units"*: **removed rather than updated**, because the
claim it supports is true at every value and a count restated where nothing needs
it is a standing invitation to the staleness it had just demonstrated.

### Actions

- Verified HEAD **first**, before any read: `6f0fd5b`, the expected SHA.
- **`FINDING M-4` repaired** — `tools/dv_checks.sh`'s repository-wide inventory
  matcher gains `--include=*.ml`; **140 → 139**. Comment records the finding, the
  contaminating line, and the portable form. Second, distinct repair on the same
  line declared in the comment (the `|| printf '0'` double-zero). Report label
  now names the scope it measures.
- **`WO-0073-D5` repaired** — `tools/cosim/run_cosim.sh` gains a `produce_reason`
  helper and a second **stage name** under exit code 3: `BUILD` for compilation
  and its inputs, **`PRODUCE`** for a pinned executable that built, ran, and then
  failed or did not write its file. Three call sites relabelled (`ours_run`,
  `vvp`, `stimulus_gen`), each now naming the producer, the side, the run and
  which of the two failure modes occurred. **The exit code and its contract are
  unchanged** — that contract went through the `RV-` loop.
- **`test/cosim/dune`'s dangling `test/cost_probe/` reference removed** and the
  rule restated positively (no `runtest` alias in the file at all), plus the
  stale "fifteen units" count removed with its measurement recorded.
- **`agents/handoffs/WO-0075_cosim-lane-cycle-comparison.md` drafted** — twelve
  sections: the twelve-class measurement, the amended grammar, the three tiers
  with what each red means, the REQ-901 argument, tb_writer's half,
  data_wrangler's half, the six-case self-test with the uniform-shift case named
  as the most important test in the packet, the prohibitions, the strobe refusal
  with its price, the DoD with CI's colours spelled out, and the landing-order
  safety proof.
- **`test/attack_plans/AP-xgmii_rx_64.md` §7 gains BAR 4** (the strobe blindness,
  priced, with the corrected diagnosis and the three preconditions) and a **note
  on bar 3** recording that its draft exists and corrects the ruling's wording;
  §9 gains one change-log row. **No row line, no status cell, no count, no §6
  cell touched.**
- Ran no `dune`. Ran no `iverilog`. Ran no command whose effect moves HEAD, the
  index, or any ref. Committed nothing.

### Evidence

Reproducible at this commit.

```
git rev-parse HEAD                      -> 6f0fd5b   (spawn HEAD, unchanged)
git status --porcelain                  -> 4 modified + 1 untracked, exactly the Files list

grep -rh 'let%expect_test' test/ | grep -c .                 -> 140   (the old matcher)
grep -rh --include=*.ml 'let%expect_test' test/ | grep -c .  -> 139   (the repaired one)
bash tools/dv_checks.sh | grep repository-wide
    ->  139  test/**/*.ml (repository-wide, FILE-TYPE scoped — FINDING M-4)
bash tools/dv_checks.sh ; echo $?       -> "every check that COULD run passed" ; 0

bash -n tools/dv_checks.sh              -> clean
bash -n tools/cosim/run_cosim.sh        -> clean
tools/cosim/run_cosim.sh --help ; echo $?  -> header renders, PRODUCE present ; 0
ls test/cost_probe                      -> No such file or directory
git log --oneline --diff-filter=D -- test/cost_probe -> 1702f0f  (the deletion)
```

**Plan counts, re-measured at this tree by a status-cell pass over the last cell
of every row line, before AND after the edit — not carried forward:**

```
before:  78 rows | ASSERT 62 | NO-ASSERT 7 | NO-STIMULUS 4 | STRUCTURAL 4 | GAP 1
after:   78 rows | ASSERT 62 | NO-ASSERT 7 | NO-STIMULUS 4 | STRUCTURAL 4 | GAP 1
```

Sum 78 both times. Every row line still parses to exactly six cells (an
eight-field `awk -F'|'` pass reports no exception). **Discharge census unmoved at
62 of 62**: 78 declared, 62 boundary-matched, 62 naive, − `M03-A4` + `M03-F5` —
re-measured by `tools/dv_checks.sh`'s own census block, not quoted.

**The twelve-class measurement, derived per class at this tree from
`test/cosim/stimulus_gen.ml` (one 64-octet good-FCS lane-0 frame, 12-octet gap,
24 drain cycles) against each campaign's own class definitions:** rendered at the
lane's stimulus — **IC-L2** (uniform ΔC 3 → 4) and **IC-L5** (last word
duplicated) — **two of twelve**. Not rendered — IC-L1 and IC-L4 (need a second
frame), IC-L3 (`R = {2}`; the lane delivers 60 octets, 60 mod 8 = 4), and all
seven family-M classes (each needs a condition this stimulus never creates).
**The comparison reported a divergence in zero of the twelve**; IC-L5's red came
from `ours_run.ml:119`'s own guard, quoted at `WO-0073-VERDICT` §10.2, and not
from REQ-901's comparison.

**Reference-side fact, established by reading the vendored MIT source's
assignment sites (`axis_xgmii_rx_64.v` lines 248, 265–266, 293–294) and used only
to bound what could ever be compared**: the reference raises `error_bad_frame`
**together with** `error_bad_fcs` at a bad-FCS terminate, where SPEC-M03 §9's
table gives that event to `error_bad_fcs` alone.

**Nothing in this round is a test result.** No bench ran, no `dune` was invoked,
no simulator exists here. `WO-0075`'s own §10 states what the landing CI's green
and red will each mean, per exit code, and that the landing run is the only check
either half will ever get before it is cited.

### Outcome

**DoD met.** Five commissioned items, five dispositions:

| item | disposition |
|---|---|
| **`WO-0073-D2`** — explicit cycle comparison | **DRAFTED as `WO-0075`**, design frozen: three tiers, T1 asserting our side against SPEC-M03 §6.1, T2 recording the reference's cycles and never adjudicating them. **The ruling's wording is corrected on REQ-901's own text and the divergence is recorded, not papered over** |
| **The strobe blindness** (`WO-0074-VERDICT` §11 item 1) | **PRICED AND DECIDED: NO strobe record, as a refusal with three ordered preconditions.** `AP` §7 **BAR 4** carries it, with the corrected diagnosis — **stimulus-bound, not grammar-bound** — and the comparable-set bound of one strobe in five |
| **`FINDING M-4`** | **REPAIRED**, 140 → 139, with the portable form recorded and a second latent defect on the same line declared |
| **`WO-0073-D5`** | **REPAIRED**: exit code 3 keeps its contract and gains the stage name `PRODUCE`; three call sites now name producer, side, run and failure mode |
| **`test/cosim/dune`'s dangling reference** | **REPAIRED**, plus a stale unit count removed rather than updated |

**The seal-method bar's home**: `FINDING WO-0074-S4`'s method — *derive the
collision inventory from the cross product of every class's predicted red set
with every scored cell, and state every rule's complete conjunct list* — is
recorded as a bar on the **family J and family K seals** in
`AP-xgmii_rx_64.md` §9's row for this round (item 8) **and** in §4.M's
post-campaign block, which is where `J-dv_lead-0138` banked it and where the next
seal's author reads it. **It is not restated in `WO-0075`**, which commissions no
seal and no campaign; a bar written into a packet that closes is not a home.

**No `SO-xgmii_rx_64.md` is opened or offered.** Families **J** and **K** are
unscored, the charter §3 anchor is undischarged per stimulus class, blind per
strobe (bar 4) and blind per quantity until `WO-0075` lands (bar 3). **The
lessons harvest is not due this round** — ADR-0018 and PROTOCOL §7 place it at
every `SO-` and every phase gate, and this is neither. The span since my last
harvest stays **open and declared, never skipped**: three candidates banked at
`J-dv_lead-0137`, and **two added here**, both LH1-cited and both stated for a
stranger to this project — *(i) an inventory of a language construct must be
scoped by file type, never by directory, because a project that documents its own
instruments contaminates a directory-scoped count in proportion to how well it is
documented, and the symptom is a plausible integer* (incident: `FINDING M-4`,
raised `WO-0074` §2, repaired this commit); *(ii) where one exit code covers
several stages, the stage must be named in the text, because the code is read by
a machine and the text is read by the person who has to fix it — widening a
code's contract is free, widening its label silently is how the two drift apart*
(incident: `WO-0073-D5`, `cosim` job `92437812511`). Neither is admitted here.

**Handoff**: the four modified files plus `WO-0075` to the orchestrator for
commit; `WO-0075` to tb_writer and data_wrangler for the two halves, in either
order (its §11). Commissioned next, unchanged: the family **J** campaign packet,
then family **K**, then the `SO-`.

### Open-questions

1. **The one disagreement with this dispatch, stated plainly: the `AP` moved.**
   The dispatch says it does not, and pre-resolves the conflict in favour of my
   artefacts; my artefacts (`WO-0074-VERDICT` §14 item 2, `J-dv_lead-0138`) name
   this round as the §7 banner entry's carrier, and §7's banner already holds
   bar 3, so a second blindness recorded elsewhere would leave the banner telling
   half the story to the only reader it exists for. **The edit is confined to §7's
   banner and one §9 row; no cell, status, count or §6 entry moves**, so it is
   droppable as a single file if the orchestrator disagrees — but the journal's
   Files list would then need rewriting before commit, and I would rather be told
   than guess.
2. **`WO-0075` corrects a ruling I asked for, and the orchestrator should read
   that as a position rather than as compliance.** `J-orchestrator-0215`'s option
   (a) as worded commissions a cross-side cycle comparison; REQ-901 excludes cycle
   alignment by name. I have delivered the intent under the constraint and said so
   in the packet's §4 and in the plan's banner. **If the orchestrator reads the
   correction as a refusal of the ruling, the packet is a position paper and the
   ruling stands until re-ruled.** I do not escalate it: it is a drafting
   correction inside my own scope, on evidence the ruling did not have, and it is
   not E5.
3. **T1's constant is derived and unverified by execution, and it cannot be
   verified here.** `admit + m + 3` is SPEC-M03 §6.1's formula and the lane's
   expected set is `{3 … 10}` from §6.1's own worked table. If the landing CI reds
   at `EXIT_TIMING`, the packet says in terms that the resolution is a `BUG-` or a
   finding against my derivation — **never a constant edited to match an
   observation**. I recommend the auditor's re-execution sampling take that
   derivation, since it is the one number in this round that no test has touched.
4. **The lane drives one frame, and four of twelve classes are unreachable for
   that reason alone.** That bound was never stated when `WO-0046` chose the
   stimulus and it is now measured. **It is not commissioned here** — a second
   frame is a different work order with a different risk profile — but it is the
   single largest thing standing between this lane and the charter §3 anchor, and
   it should be commissioned before the `SO-` rather than discovered at it.
5. **Carried, unchanged**: `DECLARATION WO-0074-D1`'s source-side half is adopted
   and not verified by me; `M03-M5`'s `a_open` line reference is a design-side
   citation inside a DV artefact; `WO-0047` §2's 4-octet member reorder
   (`test_m03_f.ml`); `OBSERVATION L-O1` (`test_m03_l.ml`); `WO-0073-D3`'s
   `M03-I4` mislabel (`test_m03_i.ml`); `OBSERVATION K-O1` (`test/monitors/`);
   AP-M14's §6 invariant; the `precompile_check.sh` side-effect-in-combinator
   lane; the RFC 1071 anchor on the next fetching run; X-7, X-10, X-11 deferred.
6. **Nothing is escalated.** No `BUG-`, no `E`-class item, no spec-queue addition
   — a nil escalation, declared rather than omitted.

### Files-in-this-commit
- agents/handoffs/WO-0075_cosim-lane-cycle-comparison.md
- test/attack_plans/AP-xgmii_rx_64.md
- test/cosim/dune
- tools/cosim/run_cosim.sh
- tools/dv_checks.sh

---

## [J-dv_lead-0140] 2026-08-10T07:20Z | task:WO-0076 | The ninth campaign frozen against the era's oldest unscored rows — and the two things that made it different from its eight predecessors are that its classes are PERMITTED to move the datapath, and that the collision method I was made to carry found both of its collisions in another class's blast radius

### Trigger

Orchestrator dispatch, spawn short-id `WO-0076/2026-08-10T07:20Z`, HEAD
`b112e47` — verified as my first action, before reading anything, and matching
the expected SHA exactly.

The commission is my own: `WO-0074-VERDICT` §14 item 3, **the family J campaign
packet**, with its SEALED companion in the same commit under R-SEAL-1
(freeze-first, base = the staging commit). Family J's three ASSERT rows —
`M03-J1`, `M03-J2`, `M03-J3` — landed at `2dbd39b` and have been passed over by
eight campaigns. **They are the oldest unscored rows in this programme** and this
packet is the debt.

### Inputs

Read at `b112e47`, all read-only. **No `libs/**`, `top/**` or
`rtl_snapshots/**` was opened at any point in this round.**

- `agents/charters/dv_lead.md`; `agents/PROTOCOL.md` — mandatory first actions.
- `docs/specs/modules/xgmii_rx_64.md` — **§4.3** entire (the sampling sentence,
  the three-clause "What the enable gates", "The case that forced the ruling"),
  **§6.1**'s *"When `cfg_rx_enable` is 0"* paragraph, **§6.2**'s four rows at
  their enable conditions, **§6.3 item 7** (C-14.5), **§7**'s
  configuration-sampling and reset bullets, **§9**'s closure list and clause (b),
  **§10**'s REQ-802/REQ-810 and REQ-110 hooks, §4.1/§4.2's port table.
- `docs/specs/requirements.md` — **REQ-810** in full, **REQ-803**, **REQ-802**,
  **§9.1**'s `receive enable` row, §13's REQ-810 change-log rows (C-46, ADR-0014).
- `test/attack_plans/AP-xgmii_rx_64.md` — **§4.J** entire (all four rows, with
  `M03-J2`'s **withdrawn** cell and the honest kill that replaced it read at
  their own words), §4.K's landed-status block, §4.M's post-campaign block item 4
  and §9's 2026-08-10 row item 8 (**`FINDING WO-0074-S4`'s method, banked as a
  bar on this seal**), §4.I's `M03-I2` cell, §4.L's `M03-L1` cell, `FINDING K-3`.
- `test/xgmii_rx_64/test_m03_j.ml` in full; `test_m03_n.ml`'s `run_n4` and its
  two members; `test_m03_structural.ml`'s `Enable.change_cycles` witness;
  `bench.mli`'s `Enable`, `Clear` and `sample` docstrings; `bench.ml`'s
  `run` pre-scan guards, `account_clean_frame`, `delivered_samples`,
  `error_pulses` and `assert_monitors_clean`; `test_m03_a.ml`'s
  `tuple_of_sample`/`tuple_equal`; `test/monitors/octet_time.ml`'s
  `Latency.frame_out` and `of_words`; `test/cosim/ours_run.ml:138–142` and
  `test/cosim/tb_xgmii_rx_64.v:63`; `tools/dv_checks.sh`'s inventory block.
- `agents/handoffs/WO-0074_family-m-mutation-campaign.md` and its SEALED
  companion, both in full (the template this packet is built against, and the
  four findings against my own seal that it must not repeat);
  `agents/handoffs/WO-0075_cosim-lane-cycle-comparison.md` (§8.0's hazard).
- `agents/journals/claude_dv_lead_agent.v06.md` — `J-dv_lead-0137`, `0138`,
  `0139`; `claude_dv_lead_agent.v05.md`'s `FINDING K-3` statement.

### Reasoning

**Family J is not family M, and the first hour went on establishing exactly how
far that goes.** Family M's campaign could carry one global rule — *nothing may
move but the strobe set* — because every M row's observable was a strobe set, and
that rule was simultaneously the qualification criterion and the datapath check.
**Family J's observables ARE the datapath.** `M03-J1` asserts that no word
appears, `M03-J2` that eight do, `M03-J3` that eight appear byte- and
cycle-identical to a reference run. A class that moved nothing would be
invisible; a check that forbade movement would fail a correct rendering of three
of the five classes. **So §6 is written as a per-class permission list instead of
a global prohibition** — each class declares in advance the exact set of
delivered-stream facts it may move, and everything else must be identical. That
inversion is this round's own methodological content, and I would rather have
written it before the run than discovered it in a scorecard the way `WO-0063B`
discovered the signature had no domain.

**The number that decides the round is four.** I measured, rather than recalled
(`FINDING K-3`), how many units in the repository drive `cfg_rx_enable` away from
`Enable.high`: `grep -rn --include=*.ml '~enable' test/` returns eight sites, of
which two are the capability's own plumbing and two are explicit
`~enable:Enable.high`. **Four units drive it low** — J1, J2, J3 and family N's
N4 — and fifty-five of the fifty-nine M03 units never touch it. That single fact
does three jobs: it makes the MUST-STAY-GREEN guarantee mechanical (one conjunct,
*enable-high invariance*, protects all 134 other behavioural units), it bounds
what the round may claim (four units is the narrowest instrument footprint of any
campaign in this era), and it turns a wide rendering into an immediately
disposable finding rather than an argument.

**Two of my own plan cells are convicted before a diff exists, and both were
found the same way the six before them were — by working the row's own arithmetic
while authoring the packet that commissions it.** `FINDING J-1`: `M03-J1`'s Kills
cell names *"a design that gates the output but leaves the strobe path live"*,
and the hundred refused frames in that row's own schedule are clean, 64-octet,
good-FCS frames that **owe no strobe under any rendering that merely leaves the
detection machinery running**. The narrow reading is unreachable; only the cell's
own parenthetical — a design that *reports* refusal — is separable, and that is
IC-J2. Its second half is worse and quieter: the row's Observable has three
clauses and its Kills cell attacks one, so REQ-810's **first sentence** — no
output word — has no Kills cell at all, which is IC-J1's whole ground.
`FINDING J-2`: `M03-J3`'s promise that the in-flight frame's *"strobes are
exactly those of the same frame with the enable held at 1"* is unfalsifiable in
the **subtractive** direction, because that frame is clean and owes none; the row
can convict a design that *adds* a strobe and not one that *suppresses* one, and
the carrier that convicts the suppressor is `M03-N4`, family N's. Both rows stay
`ASSERT` — their observables are REQ-810's and REQ-803's own — and what the
findings change is the claim a round may make about them. That disposition is the
M03-D3 / M03-F2 / M03-I2 / M03-J2 / M03-K1 / M03-N4 precedent at its seventh
instance and I applied it unchanged rather than inventing a status for it.

**The round's centrepiece is a green, and it measures a correction this
programme argued and never ran.** `WO-0067` §6 withdrew *"a design that samples
the enable continuously and truncates the frame it just admitted"* from
`M03-J2`'s Kills cell on a derivation — the enable is 1 for the whole of frame
100's admitted extent, so such a design truncates nothing there — and re-pointed
it at `M03-J3`. **IC-J3 is that design.** If it reddens `M03-J3` and leaves
`M03-J2` green, the withdrawal stops being an argument, exactly as `FINDING M-1`
and `FINDING M-2` did one family over. I sealed `M03-J2` green under IC-J3 as a
load-bearing `G!` and pre-fixed all three outcomes, including the one that runs
*in the row's favour*: a red there would mean the withdrawn cell was reachable
after all, which is a restoration question for the plan and not a bench defect.
And I wrote the prohibition into the seal's own qualification table rather than
into prose: **no cell may qualify `M03-J2` on the withdrawn class, whatever a
scorecard shows.**

**`FINDING WO-0074-S4`'s method changed the seal in a place I could not have
reached without it, and this is the report the commission asked for.** The old
method — enumerate collisions from the cells you have marked — would have found
**none** here, because each of the five scored cells is owned by exactly one
class. The cross product of every class's *predicted red set* against every
*scored cell* finds **two**, and both come from the same place: **IC-J1's blast
radius**. IC-J1 is the widest class in the round (it reddens all four
enable-driving units) and its own scored cell is at `M03-J1`; its reds at
`M03-J2` and `M03-J3` land character-for-character on IC-J4's and IC-J3's scored
cells, because all three are the same count-shaped message with a different
integer. **The concrete change**: §9's inequality table gained two rows it would
not otherwise have had — `> 8, derived 808` at `M03-J2` and `> 8, derived 16` at
`M03-J3` — and the *direction* is now the discriminator of record at both
collisions, with a second-unit measurement behind it. Without those rows a
scorecard reading `got 16` at `M03-J3` would have been read against IC-J3's
`< 8` cell and could have been scored as its kill. That is precisely the shape
S4 named: *the classes that collide with a cell are usually not the class that
owns it.* I also applied `FINDING WO-0074-S1`'s method — every rule in §3.4
carries its complete conjunct list, including the gates the rendering may not
remove — which is what stops IC-J3's rule from silently describing IC-J1 ∧ IC-J3.

**Where I chose to stop.** Five classes, not eight. A sixth was available — the
unscoped reading of REQ-810's three prohibitions, a design that suppresses an
**in-flight** frame's own strobe, which ADR-0014 prices and rejects — and I
declined to seed it, because `FINDING J-2` shows it is invisible at every family
J unit and visible only at `M03-N4`, whose row is family N's and was scored at
`WO-0066`. Seeding it would have bought a red that qualifies nothing, at 344 s.
**It is declared instead of seeded**, which is the honest disposition and the one
`WO-0074` used for `M03-M8`/`M03-M9`.

**One symbol in the matrix is new, and inventing it was the alternative to
guessing.** `M03-J1` contains **no assertion that reads frame 100's delivered
stream** — its title says the re-enabled frame is received correctly, and the
only instrument that would see it refused is the latency tagger, reached through
`account_clean_frame` and reported by `assert_monitors_clean`. Sealing that cell
`R!` would pin a prediction on an instrument the row does not have; sealing it
`G` would claim a refusal is invisible when the tagger contradicts it. I sealed
it **`M`** — a monitor-arm red that qualifies nothing under standing rule 7 —
and pre-fixed all three outcomes at §5.6. Whichever fires is a measurement about
the row's own instruments, and none of them is a kill.

**On the hazard I would rather name than discover.** `WO-0075` is outstanding
and its return edits `test/cosim/**`. §8's freeze binds *all* of `test/**` by its
own words, so landing it inside this campaign's window invalidates the base. I
considered writing myself a carve-out — `test/cosim/` contributes zero units and
is blind to every class here by stimulus — and refused it: a freeze with an
exception invented for the author's convenience is exactly the "hope" shape
`FINDING K-3` names. It goes up as **question 1 for ruling** with a
recommendation (hold `WO-0075` for the ≈ 29 minutes this campaign costs) and a
priced alternative (land it before the base commit and re-freeze).

**On the anchor, one line, because the correction is recent and mine.**
`WO-0075` established that the co-simulation lane's blindness is **stimulus-bound
first**. Here there is no second candidate at all: both producers hold
`cfg_rx_enable` at 1 for the whole run, measured at
`test/cosim/ours_run.ml:142` and `tb_xgmii_rx_64.v:63`, so no class in this
campaign is *rendered* at that stimulus and a green `cosim` job is evidence of
nothing. Bar 4's second instance, and its purest.

### Actions

- Authored `agents/handoffs/WO-0076_family-j-mutation-campaign.md` — five intent
  classes with nine mandatory disclosures; the enable census; enable-high
  invariance as the campaign's structural fact; ten declarations of what the
  round cannot score; R-DISC-1/2 terms with a three-path gate inventory
  (admission, emission, report); §6's **per-class permission lists**; the
  blinded allowlist with the **manifest-only** rule (`FINDING WO-0074-A1`: the
  operator cuts the transients, not the auditor) and the **abort-first HEAD
  check**; the base-SHA and adjudicator-ordering rules with §8.0's `WO-0075`
  hazard; §8.1's pre-fixed scoring rules for the three bounded measurements;
  price (5 × 344 s ≈ 28.7 min, zero added stimulus); non-closures with carriers;
  weighting; return format and two questions for ruling.
- Authored `agents/handoffs/WO-0076_family-j-mutation-campaign-SEALED-predictions.md`
  — **frozen in the same commit, before any diff exists** (R-SEAL-1): seven
  standing rules; the denominator and the enable census re-measured at this tree;
  row prefixes; the per-unit assertion orders; the matrix (four units × five
  classes) with six `G!` cells and one `M`; kills, qualification and
  blast-radius tables; per-class rules **with complete conjunct lists**; five
  verbatim `R!` cells; the blast-radius cells worked; §6's eight
  green-by-blindness declarations including `DECLARATION J-D1`; **three
  collisions derived by the cross product**; nine pre-committed dispositions;
  the mutant-owned inequality table; the reasoning; the bounds; the pass
  criteria.
- Ran **no** `dune` command (standing bar) and **no** git command that moves
  HEAD, the index or a ref. Every git call was `rev-parse`, `log`, `show --stat`,
  `status`.

### Evidence

Reproducible at this commit; CI is the authority (ADR-0005).

```
git rev-parse HEAD                                                        -> b112e47
grep -c 'let%expect_test' test/xgmii_rx_64/test_m03_j.ml                  -> 3
grep -rh --include=*.ml 'let%expect_test' test/xgmii_rx_64/ | grep -c .   -> 59
grep -rh --include=*.ml 'let%expect_test' test/ | grep -c .               -> 139
grep -rh 'let%expect_test' test/ | grep -c .                              -> 141
grep -rn --include=*.ml '~enable' test/                                   -> 8 sites
grep -rln --include=*.ml 'Enable\.' test/                                 -> 4 files
```

The **141** is the old directory-scoped matcher, kept as a running measurement
rather than a quotation: `FINDING M-4` was repaired in `tools/dv_checks.sh` at
`c109c08`, the repaired matcher reports **139**, and the contamination the repair
removed has already grown from 140 to 141 because the plan absorbed the family-M
campaign. The eight `~enable` sites are: `bench.ml:229`, `bench.ml:429` (the
capability's plumbing), `test_m03_j.ml:223` and `:457` (explicit `Enable.high`
control and reference runs), and the four disabled runs `test_m03_j.ml:169`,
`:279`, `:488` and `test_m03_n.ml:1256`.

Cell derivations an auditor can re-execute from a checkout, since they are the
seal's own arithmetic and no test asserts them today: frame 0 of the 101-frame
schedule starts at octet time **8** → cycle **1** → its first output word at
`start_cycle + 3` = **4** (§4.1's sealed integer); frame 99 closes at cycle
**1049**, the change is at **1050** and frame 100 starts at **1051**, so
`M03-J1`/`M03-J2` carry **no frame in flight across their change**;
`M03-J3`'s frame 0 delivers on cycles **4 … 11** with its change at **5**;
`101 × 8 = 808` and `2 × 8 = 16` are the two blast-radius integers of §5.2.

No CI run is claimed for this round: **it stages no code and no test**, and its
own campaign has not run. The control run will be the base commit's own `build`
job, quoted by the verdict.

### Outcome

**DoD met.** The commission — `WO-0074-VERDICT` §14 item 3, the family J campaign
packet with its SEALED companion in the same commit — is delivered as two files,
frozen against the commit that stages them.

- **Handoff**: `agents/handoffs/WO-0076_family-j-mutation-campaign.md` (DRAFT,
  dv_lead → auditor via the orchestrator) and its sealed companion, to be issued
  once the orchestrator lands them and records the base SHA.
- **Not delivered and not owed this round**: no `SO-`, no `RV-`, no `BUG-`, no
  `test/**` byte, no plan edit. §8's freeze is the reason for the last of those
  and it is stated in the packet rather than assumed.
- **Lessons harvest**: **not due this round** — it falls due at the `SO-`, and
  the span since my last harvest stays open and declared rather than skipped.
  **Two candidates banked against it here**, beside the three at `J-dv_lead-0137`
  and the two at `J-dv_lead-0139`. **(A)** *An observable expressed as an absence
  cannot distinguish a component that never produced the event from one that
  produced it and suppressed it; only a positive comparison against a reference
  run separates them, and a coverage claim over such a requirement must say which
  of the two it excludes.* LH1: this round's `DECLARATION J-D1`, pending IC-J3's
  measurement. LH2-**g** — no proper noun. LH3: without it, a green silence
  assertion is read as evidence of a mechanism it never observed. **(B)** *A test
  harness's own refusal guard — a check that declines to drive a stimulus the
  specification leaves unconstrained — is evaluated before the component under
  test is read, so no mutation of that component can score it; a campaign that
  reports such a guard as covered is reporting its own scaffolding.* LH1: this
  round's §6.3 and family K's identical finding about its `clear` guard. LH2-**g**.
  LH3: without it, a suite's guards inflate its measured coverage by exactly the
  number of things it refuses to test.

### Open-questions

1. **The `WO-0075` sequencing hazard (packet §8.0), for the orchestrator's
   ruling.** `WO-0075`'s return edits `test/cosim/**`; §8's freeze binds all of
   `test/**`. **Recommendation: hold that return until this campaign scores** —
   the campaign costs ≈ 29 minutes of CI and the cosim lane is blind to every
   class in it. The alternative is to land `WO-0075` **before** the commit
   staging this packet, moving the base forward one commit and re-freezing the
   seal against it. **If it lands inside the window, the round re-seals**, and I
   have deliberately not written myself a `test/cosim/**` carve-out.
2. **IC-J5's price against its risk (packet §15 Q2).** It is the only class
   reaching `M03-J3`'s tuple comparison — the row's own instrument — and the
   likeliest of the five to come back NOT SEEDED, since a design whose `tuser`[0]
   is not separable from its abort term cannot render it. **Recommendation: keep
   it**; a NOT SEEDED declaration there is a result in the register `WO-0074`
   used for `M03-M5`, not a wasted job.
3. **Owed to the post-campaign `AP-` round, with this packet as the named
   carrier of the findings**: `FINDING J-1`'s two halves (the `M03-J1` Kills
   cell's unreachable narrow reading; REQ-810's first sentence having no Kills
   cell), `FINDING J-2` (`M03-J3`'s subtractive strobe clause), and
   `DECLARATION J-D1` as a §7 X-row if it survives the run. **No AP byte moves
   until the campaign scores.**
4. **Carried, unchanged and not this round's to pay**: the family **K** campaign,
   owed before any `SO-`, whose seal owes the same two methods this one applies;
   the charter §3 anchor, undischarged and now blind per configuration class;
   `WO-0047` §2's 4-octet member reorder (`test_m03_f.ml`); `OBSERVATION L-O1`
   (`test_m03_l.ml`); `WO-0073-D3`'s `M03-I4` mislabel (`test_m03_i.ml`);
   `OBSERVATION K-O1` (`test/monitors/`).
5. **Nothing is escalated.** No `BUG-`, no `E`-class item, no spec-queue
   addition — a nil escalation, declared rather than omitted.

### Files-in-this-commit
- agents/handoffs/WO-0076_family-j-mutation-campaign.md
- agents/handoffs/WO-0076_family-j-mutation-campaign-SEALED-predictions.md

## [J-dv_lead-0141] 2026-08-10T09:00Z | task:WO-0076 | The pre-run round pays for itself a third time: the manifest's four questions ruled before a branch exists, and the one that mattered would have made the era's oldest unscored row unscoreable by its own permission list

### Trigger

Orchestrator dispatch, spawn short-id `WO-0076-PRERUN/2026-08-10T09:00Z`, with an
abort-first HEAD check against `2fbcf0d` — run as my first action and matching, so
the round proceeds. The occasion is the auditor's `WO-0076` manifest
(`docs/reports/audit/WO-0076-mutations/README.md`, `J-auditor-0017`), whose §9
raises four questions that `WO-0076` §7.3 item 7 requires to reach me **before** the
run, plus `FINDING WO-0076-A1` and two attribution conditions at its §8.2. **The five
transients are not cut**; the deliverable is rulings, and the round is the
`WO-0063B` pre-run reading-note precedent at its third instance.

### Inputs

- `agents/charters/dv_lead.md`, `agents/PROTOCOL.md` — mandatory first reads.
- `docs/reports/audit/WO-0076-mutations/README.md` — in full (1088 lines, two reads),
  at `2fbcf0d`.
- `agents/handoffs/WO-0076_family-j-mutation-campaign.md` — in full, my own packet.
- `agents/handoffs/WO-0076_family-j-mutation-campaign-SEALED-predictions.md` — in
  full, **my own seal**, read as its author to answer RN-3's demand that the
  collision inventory be checked now rather than off a scorecard. **Not one byte of
  it was edited and it is not staged in this commit.**
- `docs/specs/requirements.md` — REQ-810 in full with §9.1's `receive enable` row and
  the §13 change-log rows of 2026-08-02 and **both** of 2026-08-03 (lines 978, 988,
  990).
- `docs/adr/ADR-0014-an-enable-gates-admission-not-the-wire.md` — Context, Decision
  items 1–5, Alternatives head.
- `test/xgmii_rx_64/test_m03_j.ml` (`j1_j2_stimulus`, `run_j1`, `run_j2`, `run_j3`)
  and `test/xgmii_rx_64/test_m03_n.ml` (`run_n4` and both member call sites) —
  **read only**, to measure RN-2's divergence set and RN-1's cost at the carriers.
  No `test/**` byte moves in this commit; §8's freeze holds.
- `test/attack_plans/AP-xgmii_rx_64.md` row `M03-M5` — the `a_open` citation A1
  names.
- `agents/handoffs/WO-0063B_pre-run-reading-note.md`, `WO-0066_pre-run-reading-note.md`,
  `WO-0074_family-m-mutation-campaign.md` (§7's rulings, the Return/verdict log form)
  — the precedent's form and its governing rule.
- Git metadata only: `rev-parse HEAD`/`HEAD^`, two `diff --name-only` freeze checks,
  `status --porcelain`, `show --stat 6f0fd5b`, `log -S`.
- **No `libs/**` path was opened.** Every design-side fact in the note is the
  auditor's, cited as its claim and not adopted as mine — including `a_open` at 296,
  which I deliberately did not verify at the source (see Reasoning).

### Reasoning

**The ruling that decides the round is RN-1, and it is not a wording question.** §6's
permission table gives IC-J1 *must be identical: … every strobe*. Read unscoped, no
rendering of the class can satisfy it: a design with no admission gate necessarily
lets a frame it admits raise whatever report that frame owes, and one that admitted
frames while suppressing their reports would be two defects rather than the class.
The auditor read it scoped to REQ-810's 2026-08-03 prohibitions and asked me to rule.
**I affirm the scoped reading**, on four grounds in authority order: REQ-810 is
already quantified over *"every frame it refuses"*, and my §6 cell is an abbreviation
of it — an abbreviation of a scoped requirement inherits its scope; the 2026-08-03
change log performed that scoping **on this exact ground** and named the family in
terms (*"C-41's unpassable-assertion family exactly"*); the partition is the
specification's, not the mutant's, so the cell after scoping **is** the requirement
rather than a weakening of it; and the scoped cell keeps its teeth at every frame the
specification requires delivered, which is the test of whether a scoping is a
nullification.

**What made the ruling worth an hour is that I could price it and the auditor could
not.** `test/**` is barred to it; it is mine. Measured at the bench: at `M03-J1`,
`M03-J2` and `M03-J3` every refused frame is a clean 64-octet good-FCS
`Frame.stress_frame` owing no strobe under any rendering, so the two readings are
**indistinguishable** there — the question is live at exactly one unit. At `M03-N4`
the refused start is an injected `/S/` **inside frame A's octets** (lane 0: octet 8 →
word cycle 3, disable 2; lane 4: octet 16 → word cycle 4, disable 3), so under IC-J1
that character does not merely abort frame A, it **opens** a frame which runs to
frame A's own terminate and, being neither 64 octets nor FCS-correct, owes a report.
A strobe absent from the base therefore appears — belonging to a frame the
specification requires refused. **Under the unscoped reading that is not a lost cell
but a lost class**: §6's check is a *delivery* gate, so an auditor unable to confirm
*"every strobe identical"* positively cannot ship IC-J1 at all, and the bill is paid
by `M03-J1` — the oldest unscored row in this programme — whose headline clause,
REQ-810's first sentence, is the only thing IC-J1 exists to score. A reading that
makes a requirement's own first sentence unscoreable is not a strict reading of it.

**RN-2 is the same defect one cell over, and I ruled it the same way but had to rule
its complement with it.** Affirming *in flight* output-side is easy on the auditor's
own argument — a gate that could separate a drain-window word from an in-flight one
would need the enable value **at admission**, which is the conformant design, and a
rendering cannot be required to carry the state that defines the design it mutates.
The part the manifest did not ask about is the same row's other column, *"every frame
whose whole extent lies inside an enabled window"*. If *in flight* is output-side and
*extent* stays input-side, a drain-window frame falls in **neither** grant and
**inside** the prohibition, and disposition 7 scores a conformant rendering out of
specification. So I ruled `extent` output-side with it, and the two columns partition
again. Then I measured the divergence set and it is **empty**: `M03-J1`/`M03-J2` have
no 1 → 0 change at all (`Enable.changes ~initial:false [(1050, true)]`), and at
`M03-J3` (change 5, frame 0 spanning 1 … 10) and both `M03-N4` members (disable 2
with frame A aborted at 3; disable 3 with frame A aborted at 4) the change falls
**strictly inside** the affected frame's input extent. The ruling is insurance
against a carrier this campaign does not have.

**RN-3 asked me to check the seal, and checking it is what showed the method was
doing its job.** §5 expected IC-J1 and IC-J3 to share the admission gate; D-J3a's
`add` branch — forced, since `move` is IC-J1's edit plus IC-J3's in one diff — means
IC-J3 touches admission not at all and the shared site is **IC-J1 + IC-J4**. The
inventory is untouched, and the reason is structural rather than lucky: the cross
product ranges over **red sets × scored cells**, and a *site* is not a term in it.
Better than untouched — the pair that actually shares the site **is** the pair of
collision 1, already discriminated by the direction of its integer and by a
measurement at another unit, so the sharing adds no indistinguishability that the
seal does not already separate. One sentence does name the superseded pair:
disposition 6's carve-out. I ruled its **instance** corrected and its **principle**
(a shared site is not a combined diff) untouched, and noted that the disposition does
not fire either way because its trigger is delivery-shaped and five diffs were
delivered.

**The rejected option, and it is the one the commission explicitly left open**: edit
the seal. I refused. `WO-0066`'s pre-run rule — *no cell of the seal moves; where the
manifest shows a cell wrong, the cell stands and the round scores it against me* —
has held through two campaigns, and it is strictly harsher than a correction, which
is exactly why it is credible. The seal's evidential value is a **byte-freeze at a
commit earlier than any diff text**; editing it now, with five renderings in view,
would convert every later "the seal said so" into a claim requiring a byte-level
diff to believe, and it would do so to fix a clarifier's instance and two readings
that move no cell. Publishing the readings in a dated, committed, binding note buys
the same clarity at none of that cost. **No seal cell moved and the seal file is not
staged.**

**RN-4: the carrier is the note, not a patch of §7's body.** The allowlist named a
file that has never existed. The temptation is to fix §7 item 4 in place — it is one
word, in my own scope, in the same commit. I refused for the reason gate signatures
and Return logs are transcribed rather than authored: the auditor has already written
a compliance statement **against that instrument's text**, and silently rewriting the
text makes its statement unverifiable against the thing it cites. An appended, dated
correction is diffable; a patched body is not. The general bar is banked as a harvest
candidate rather than minted mid-round.

**A1 I adopted and widened against myself.** The decay is a property of the line
number, not of the language the cited file is written in — `test/cosim/ours_run.ml:142`
decays exactly as `xgmii_rx_64.ml:296` does, and this packet cites eight such numbers.
So I restated the rule over any file cited from outside itself, and added the
discharge the auditor's own manifest uses: a **document-level SHA declaration** is a
citation, and cheaper than forty per-sentence ones. Conditions A and B I accepted and
then verified rather than asserting: zero `a_open` hits anywhere under `test/**`'s
OCaml, and `M03-M5`'s Observable and Status byte-identical across `6f0fd5b`, the
commit that introduced the number. The one clarification B needs is that the citation
sits **inside** a Kills cell: I fixed the operational test as the **strike test** —
delete the number and ask whether any cell changes meaning. Here nothing does, because
the cell's claim rests on the *existence* of one open-frame term, an attributed design
fact; the number is a locator for falsification, and a locator is not a key. **I did
not verify 296 at the source**, deliberately: the AP row's own sentence says the plan
verified none of it there, and confirming it would have falsified that sentence to buy
a fact already published and held to by its author.

**One inconsistency of my own I judged rather than followed.** §8 says *"no diff body
reaches me until every diff is committed on its transient branch"*, which cannot hold
under §7.1's manifest-only model — the model this same packet adopts, and the one with
a ruling behind it — because the manifest carries the patch text and is committed
before any transient exists. I ruled §8's sentence superseded and restated what it was
actually protecting as a checkable commit-ordering fact: **the seal froze at
`8346a5c`, strictly before the first artefact carrying diff text at `2fbcf0d`**. The
protection is intact; only the mechanism sentence was stale. Stopping on it would have
cost the round five jobs to repair a sentence that guards nothing the ordering does not
already guarantee.

**Value added beyond the four questions**: the shared-anchor hazard. Branches 1 and 4
replace the same two lines, and the substitution table relies on each old text
occurring exactly once. Cut sequentially from a tree that still carries branch 1, the
branch-4 substitution finds no anchor — or worse, finds a tree carrying two classes,
which §10 item 3 makes unscoreable and which would be recorded as a result rather than
as a manifest defect. Stated as an operating bar with a mechanical check
(`git status --porcelain` → 0 before and after each cut).

### Actions

- Verified HEAD `2fbcf0d`, parent `8346a5c`, clean tree — first action, before reading.
- Read the manifest, the packet and the seal in full; the REQ-810 rows; ADR-0014; the
  two bench files' enable geometry; the AP's `M03-M5` row; the two prior pre-run notes.
- Re-verified the adjudicator-ordering rule read-only:
  `git diff --name-only c109c08 8346a5c -- test/ libs/` and
  `git diff --name-only 8346a5c HEAD -- test/ libs/`, both empty.
- Measured RN-1's cost at all four carriers and RN-2's divergence set at all four;
  cross-checked the seal's collision inventory against the delivered pairing.
- Appended the pre-run reading note (§§0–7, 443 lines) to
  `agents/handoffs/WO-0076_family-j-mutation-campaign.md`, with the auditor's return
  recorded in a new Return/manifest log above it. **Pure EOF append**; nothing above
  line 1171 is touched.
- **Not done, deliberately**: no seal edit, no `test/**` edit, no AP edit, no §7-body
  patch, no branch, no commit, no ref/index movement, no `dune`.

### Evidence

Commands run at this tree, with their observed results:

```
$ git rev-parse HEAD                                  -> 2fbcf0d3318d65be4a4896864abc0f58beca1bf5
$ git rev-parse HEAD^                                 -> 8346a5ca11883381ea738cf1efa5f0dcd67d6907
$ git diff --name-only 8346a5c HEAD -- test/ libs/    -> (0 lines)
$ git diff --name-only c109c08 8346a5c -- test/ libs/ -> (0 lines)
$ git status --porcelain | wc -l                      -> 0   (before the append)
$ git diff --stat                                     -> 1 file changed, 443 insertions(+)
$ git diff -U0 … | grep '^@@'                         -> @@ -1171,0 +1172,443 @@   (single EOF hunk)
$ grep -rn a_open test/ --include=*.ml --include=*.mli -> (no hits)
$ git show 6f0fd5b -- test/attack_plans/AP-xgmii_rx_64.md
      -> M03-M5's Observable "Exactly one `error_bad_frame`; no
         `error_start_without_terminate`" and Status `ASSERT` byte-identical
         across the commit; only the Kills cell gained campaign-result prose
$ grep -rn 'xgmii_rx_64\.ml' test/ --include=*.md
      -> 3 hits: one line-number citation (AP:1054, the a_open cell), two path-only
```

Bench geometry, read from the committed sources at `8346a5c` (unchanged at HEAD):

```
test_m03_j.ml:156   M03-J1/J2  Enable.changes ~initial:false [ (1050, true) ]   (no 1->0 change)
test_m03_j.ml:442-452 M03-J3   change_cycle 5; Enable.changes ~initial:true [ (5, false) ]
                               start_cycle0 1, terminate_cycle0 10, start_cycle1 11 (lane 0)
test_m03_n.ml:1459-1470 M03-N4 (lane 0) s_idx 8,  w cycle 3, disable 2, re-enable 10, C start 11
                        M03-N4 (lane 4) s_idx 16, w cycle 4, disable 3, re-enable 11, C start 12
```

**No suite was run and none is claimed**: this round elaborates nothing, and ADR-0005
makes CI the authority for the five branches that follow. **No `%expect` block, no
RTL and no test byte moves in this commit.**

### Outcome

**DoD met for the commissioned unit of work.** Four rulings delivered before any
transient exists (RN-1 scoped/affirmed; RN-2 output-side/affirmed, with *extent* ruled
with it; RN-3 inventory unaffected, disposition 6's carve-out instance corrected;
RN-4 carriered to this note), `FINDING WO-0076-A1` **adopted** with one widening
amendment, its conditions **A and B accepted and verified satisfied**, one stale
sentence of my own §8 ruled superseded, one operational hazard flagged, and the
**green light given** to cut `mut/wo-0076-j1 … j5` in §10's fixed order under four
operating bars.

**No sealed cell moved and the seal is not staged.** Handoff: the packet's appended
pre-run section, `agents/handoffs/WO-0076_family-j-mutation-campaign.md` §§0–7 of the
note — binding, citable by name at scorecard time, and the instrument the verdict
reads §6's permission lists through.

**Not delivered and not owed this round**: no `SO-`, no `RV-`, no `BUG-`, no
scorecard, no `test/**` byte, no AP edit, no seal byte.

**Lessons harvest**: **not due this round** — it falls due at the `SO-`, and the span
since my last harvest stays open and declared rather than skipped. **One candidate
banked here**, beside the three at `J-dv_lead-0137`, the two at `J-dv_lead-0139` and
the two at `J-dv_lead-0140`. **(C)** *A path cited in a normative instrument — an
allowlist, a scope, a permission — is verified to resolve at the tree the instrument
governs, before the instrument is issued.* LH1: this round's RN-4 (§7 item 4 named a
file that has never existed; the reader who honoured the instrument could not
distinguish a typo from a deliberate exclusion) together with `FINDING WO-0076-A1`'s
decaying line numbers, of which it is the degenerate case — a citation that was never
true rather than one that stopped being true. LH2-**g** — no proper noun. LH3: without
it a normative instrument can admit or bar nothing, and every compliance statement
written against it is unfalsifiable in both directions.

### Open-questions

1. **Nothing is escalated.** No `BUG-`, no `E`-class item, no spec-queue addition — a
   nil escalation, declared rather than omitted.
2. **Owed at the scorecard, by me**: re-verify §8's freeze rather than treating §0.1
   as discharged once, and adjudicate against the seal **as frozen**, with §0.3's
   harsher clause standing — where a reading in this note and a sealed cell disagree,
   the cell governs and the round scores it against me.
3. **Owed to the post-campaign `AP-` round**, carrier unchanged (§13 item 1):
   `FINDING J-1`'s two halves, `FINDING J-2`, `DECLARATION J-D1` as a §7 X-row if it
   survives, and now **`FINDING WO-0076-A1`'s one-line citation repair** at `M03-M5`
   (`libs/hardcaml_ethernet/src/xgmii_rx_64.ml:296 @ ca1bb80`). Exposure measured:
   exactly one citation.
4. **Owed by me prospectively, not repaired here**: A1's widened form applies to my
   own future packets' `test/**` line numbers. This packet discharges it document-wide
   via §2 + §8, whose base now resolves to `8346a5c` and is recorded in the note.
5. **Carried, unchanged and not this round's to pay**: the family **K** campaign, owed
   before any `SO-`; the charter §3 anchor, undischarged and blind per configuration
   class; `WO-0047` §2's 4-octet member reorder (`test_m03_f.ml`); `OBSERVATION L-O1`
   (`test_m03_l.ml`); `WO-0073-D3`'s `M03-I4` mislabel (`test_m03_i.ml`);
   `OBSERVATION K-O1` (`test/monitors/`).

### Files-in-this-commit
- agents/handoffs/WO-0076_family-j-mutation-campaign.md

## [J-dv_lead-0142] 2026-08-10T11:10Z | task:WO-0076 | The ninth campaign adjudicated: five of five killed with every sealed direction and derived integer exact, the honest-kill withdrawal established from a run instead of an argument at last — and the only two cells the seal got wrong are both mine, both in the parts I wrote from memory rather than measured

### Trigger

Orchestrator spawn, short-id `WO-0076-ADJ-2/2026-08-10T11:10Z`, to adjudicate the
family-J campaign against my sealed companion **as frozen at `8346a5c`**, under the
pre-run note's own §0.3 clause: where a reading in that note and a sealed cell
disagree, **the cell governs and the round scores it against me**. My predecessor
spawn stopped on incident four — a 129-commit container rollback, since restored
losslessly and journalled at `J-orchestrator-0222`. First action this spawn was the
direction-checked HEAD comparison; `HEAD` was `cbc2765` and matched, so no incident
disposition fired.

### Inputs

- `agents/charters/dv_lead.md`, `agents/PROTOCOL.md` — mandatory first actions.
- `agents/handoffs/WO-0076_family-j-mutation-campaign-SEALED-predictions.md`
  **at `8346a5c`**, verified byte-identical to the working-tree copy
  (`git diff 8346a5c HEAD -- <seal>` → empty) before a single cell was read.
- `agents/handoffs/WO-0076_family-j-mutation-campaign.md` in full — the packet
  (`8346a5c`) and the pre-run reading note (`5ac62b5`, `J-dv_lead-0141`: RN-1
  scoped/affirmed, RN-2 output-side + whole-extent, RN-3 inventory unaffected,
  RN-4 this-note-is-the-carrier, `FINDING WO-0076-A1` adopted and widened).
- `docs/reports/audit/WO-0076-mutations/README.md` at `2fbcf0d`
  (`J-auditor-0017`) in full — five manifests, nine disclosures, both discharges,
  the §6 positive-form check, four exposures, four pre-run questions.
- **CI, at the source**: the five `build` jobs' step readings and `dune runtest`
  output (`92498074622`, `92498077419`, `92498080573`, `92498083901`,
  `92498087940`), and the control (`92491537453`). Fetched through the GitHub API;
  the log-download redirect target is blocked by this container's proxy, so the
  scoring evidence is the job-log content itself, retrieved and filtered locally.
- `test/xgmii_rx_64/bench.ml:599–639 @ 8346a5c` — **read post-verdict, and only to
  characterise a finding against my own seal** (§10's `FINDING WO-0076-S1`). It is
  bench source, not RTL; **no `libs/**` path was opened at any point in this
  round**, and every design-side fact in the verdict is the auditor's, cited as its
  claim.
- Transient metadata via the API only: five branch heads, their sole parents and
  their diffstats. **No `git fetch`, no ref, index or `HEAD` movement.**

### Reasoning

**Why the seal was opened only after every scorecard was in hand, and why that
matters more this round than last.** Three of this campaign's five classes were
*permitted* to move the datapath — the first campaign in the programme where a
global "nothing may move" check would have failed a conformant rendering. The
protection against tuning an adjudication to a mutant was therefore not the check
but the ordering: bench frozen at `c109c08`, seal at `8346a5c`, first diff text at
`2fbcf0d`, and §0.3's promise that a disagreement scores against me. I re-verified
the freeze at scorecard time rather than treating §0.1 as discharged once, which
was my own Open-question 2: `git diff --name-only 8346a5c HEAD -- test/ libs/` is
empty, so not one bench byte moved between the seal and the verdict, mine included.

**Why the promotion block is the right scoring instrument and the badge is not.**
A run-level conclusion says only that something failed. The `build` job's step
readings separate a **build** finding from a **behavioural** one — step 5 `Build`
is `success` under all five classes, so every red this campaign scores was raised
by an assertion inside a mutant that compiled. And the promotion block's
`--- FILE` list is a *file-level scorecard*: a file appears iff at least one unit
in it changed its expect output. That is what lets me state MUST-STAY-GREEN as a
measurement rather than an inference — under every class the only files promoted
are `test_m03_j.ml` and `test_m03_n.ml`, and under IC-J5 only the first. Fifty-five
enable-free M03 units and seventy-nine non-M03 behavioural units green, by
construction and not by care, exactly as **D-J1b** claimed structurally.

**What I got right, and it is the part that was measured.** All five `R!` cells are
character-exact. Every mutant-owned integer landed inside its sealed inequality
with its sealed direction, and three hit their derived values on the nose (1, 0, 1)
with the fourth on a named endpoint of its span (1 of {1, 11}). Both *ordering*
claims — that `tvalid` is read before the strobe list within a sample under IC-J1,
and that no output word can precede the strobe message under IC-J2 — were
falsifiable and were not falsified. The two collisions the cross-product method
found both fired, and **the sealed integer directions separated them on the first
reading with no residue**: `> 8` derived 808 against `< 8` derived 0 at `M03-J2`,
`> 8` derived 16 against `< 8` derived 1 at `M03-J3`. Without those two rows, two
of five scored cells would have had no bench-side discriminator at all, because the
colliding class's own cell sits at a different unit. `FINDING WO-0074-S4` was
carried in as a bar on precedent; it is now a bar on evidence.

**What I got wrong, and it is the part I wrote from memory.** Two defects, both
mine, both in the seal, both in sections where I stated a *class of forms* instead
of measuring the source:

- §5.4 enumerated four monitor-arm messages. `assert_monitors_clean` has **five**,
  and the one I omitted — `": latency tagger errors:\n"` at `bench.ml:632`, which
  **precedes** `": latency tagger unclean:\n"` at `:638` — is precisely the arm the
  campaign's only `M` cell raised. §5.6 outcome 1 quoted the fifth arm's string for
  an event raised by the fourth. Standing rule 2 says every message is derived from
  committed control flow and source order at the base SHA. I honoured it for the
  five cells I worked and not for the arms I listed.
- §3.1 says the `G!` cells number **six** and its bullets describe six; the matrix
  marks **five**, because `M03-J2 × IC-J5` is plain `G`. A table and its own count
  disagreeing is `FINDING WO-0066-3`'s defect one artefact over.

**Both cost nil, and I refuse to treat that as exoneration.** S1 costs nothing only
because §5.4, §5.6, standing rule 7 and §9's UNREAD row all key on *which
instrument spoke* rather than on what it printed — had that cell been sealed `R!`
instead of `M`, this round would have scored a correct rendering as off-pattern on
a string the bench never emits. S2 costs nothing only because the cell is green
under both readings; had it reddened, I would have been deciding whether a
load-bearing measurement was lost with no rule to decide by and the answer already
visible. **The near-miss is the finding.** Recording them as costless would be
recording the luck rather than the defect, which is the failure mode the whole
seal-before-diff discipline exists to prevent.

**Why `M03-J2`'s green under IC-J3 is the round's centrepiece and not a
formality.** `WO-0067` §6 withdrew a Kills cell from `M03-J2` on an argument from
the stimulus: the enable is 1 for the whole of frame 100's admitted extent, so a
continuously-sampling design truncates nothing there. IC-J3 **is** a
continuously-sampling design. It reddened `M03-J3` at its own cell and left
`M03-J2` green, so §8.1 rule 1 fires and the withdrawal is established **from a
run** rather than from an argument. A bench cannot make that measurement about
itself; a campaign can, and this is the one that did.

**Where I refused to let a green say more than it earned.** `DECLARATION J-D1`
claims an absence-shaped observable cannot separate *never admitted* from
*admitted and muted*. IC-J3 came back as D-J3a's **`add`** branch — admission
retained, emission gated — so the rendering *refuses and also mutes*. `M03-J1`'s
green under it measures directly only that the silence scan cannot see an emission
gate; the *admitted-and-muted* design is the `move` branch, which was not rendered,
and its green follows from the seal's own pre-run derivation that this bench
produces no discriminator between the branches. So J-D1 stands and is measured **on
the add branch**, with its strongest form still derived. Writing it stronger would
have been the exact move §0.3 was written to forbid.

**A new protection, banked because it is the first time it has existed.** Collision
3's whole guard is the disclosure, at its fourth instance in this programme. This
round the disclosure is **corroborated by an artefact**: `2296840` is `+1/−1` at a
single site, and a `move` rendering is not expressible as a one-line substitution.
A branch pair whose members differ in edit *shape* can therefore be checked against
the transient's diffstat without reading a diff body — which is a protection that
survives an author who answers a disclosure carelessly.

**The auditor's conduct, and the item that deserved a ruling rather than a nod.**
All four exposures are metadata, none is content, and each is disclosed at the
point of use with what was taken and what was not. The one worth the ruling is the
allowlist narrowing: the spawn prompt's enumerated allowlist omitted `ADR-0014`,
which my §7 item 4 admits by name, and the spawn deferred to the packet — so the
ADR *was* readable and the auditor read it under neither name, honouring the
narrower of two disagreeing instruments. That is the correct disposition: a
disagreement between normative instruments is a defect in the instruments, and
resolving it by intersection leaves the disagreement visible instead of consuming
it. The auditor then proved the cost was nil instead of asserting it. **And the
by-product is the round's cheapest finding** — listing `docs/adr/` to check the
path it had been handed is what exposed that my allowlist cites a filename which
has never existed. An error in my instrument, found by a reader honouring it.

**Harvest note (ADR-0018, PROTOCOL §7).** **Not due this round** — the harvest falls
at the `SO-`, and the span from my last harvest **stays open and is declared rather
than skipped**. Two candidates are banked against it from this round's own defects,
both stated with the provenance hidden:
**(D)** *An artefact that quotes a component's diagnostic message derives it from
that component's own source at the frozen revision, enumerating every branch that
can emit one.* **LH1**: this round, `FINDING WO-0076-S1` — a four-item list where
the source has five, and the omitted branch is the one that fired. **LH2-g** — no
proper noun of any kind. **LH3**: without it, a prediction keyed to a message string
scores a correct implementation as an anomaly, and the error stays invisible until
the rare branch fires.
**(E)** *When a document asserts a count of its own marked cells, the count is
re-derived from the table rather than written beside it.* **LH1**: this round,
`FINDING WO-0076-S2`. **LH2-g**. **LH3**: without it, an adjudication reaching a
cell the two readings classify differently has no rule to decide by, and will
invent one after the result is known.

### Actions

- Verified `HEAD` = `cbc2765` = spawn HEAD before reading anything; re-verified at
  return. Tree clean throughout; no commit, no fetch, no ref/index/`HEAD` movement.
- Confirmed the seal byte-identical to its frozen form at `8346a5c` before opening
  it; read it, the packet, the pre-run note and the manifest in full.
- Scored the five classes from the `build` jobs' step readings and `dune runtest`
  output at the source — never from a run-level badge — including the file-level
  promotion lists that carry MUST-STAY-GREEN.
- Verified through the API that each of the five transients is a single commit whose
  **sole parent is `8346a5c`**, touching one file with the manifest's own edit size:
  the shared-anchor hazard I flagged at the pre-run note §3 did not fire.
- Re-verified §8's freeze at scorecard time (`git diff --name-only 8346a5c HEAD --
  test/ libs/` → empty), discharging my own Open-question 2.
- Read `test/xgmii_rx_64/bench.ml:599–639` **after** scoring, solely to characterise
  `FINDING WO-0076-S1` against my own seal.
- Appended `WO-0076-VERDICT` to the campaign packet: fifteen sections, five sealed
  cells scored character-for-character, six `G!` cells and the one `M` cell, three
  collisions with the direction discriminator's performance, per-class
  KILLED/SURVIVED/VOID, the qualified rows, the era tally, four findings (two
  against me), the eight declarations, and the next commissions with their
  sequencing hazard.

### Evidence

```
control       8346a5c  run 31061945377  build job 92491537453  success, 10/10 steps
IC-J1 8aaa0dd run 31064102925 job 92498074622 Build=success tests=failure
IC-J2 f61157b run 31064103812 job 92498077419 Build=success tests=failure
IC-J3 2296840 run 31064104902 job 92498080573 Build=success tests=failure
IC-J4 1c1bfb1 run 31064106060 job 92498083901 Build=success tests=failure
IC-J5 8589bfd run 31064107507 job 92498087940 Build=success tests=failure
cosim: success under all five and at the control -- evidence of nothing (seal 6.1)
```

The five scored cells, observed verbatim in the `dune runtest` output at each
transient:

```
IC-J1  M03-J1: cycle 4: tvalid high during the disabled window
IC-J2  M03-J1: cycle 1: an error strobe pulsed during the disabled window
IC-J3  M03-J3 (lane 0): disabled run: expected exactly 8 delivered words (frame 0 only), got 1
IC-J4  M03-J2: expected 8 delivered words for frame 100, got 0
IC-J5  M03-J3 (lane 0): frame 0's delivered (octets, tkeep, tlast, tuser) tuples differ between the disabled and reference runs
```

The two collision cells, separated by their sealed directions:

```
IC-J1  M03-J2: expected 8 delivered words for frame 100, got 808     (sealed > 8, derived 808)
IC-J4  M03-J2: expected 8 delivered words for frame 100, got 0       (sealed < 8, derived 0)
IC-J1  M03-J3 (lane 0): disabled run: expected exactly 8 delivered words (frame 0 only), got 16  (sealed > 8, derived 16)
IC-J3  M03-J3 (lane 0): disabled run: expected exactly 8 delivered words (frame 0 only), got 1   (sealed < 8, derived 1)
```

MUST-STAY-GREEN, from the promotion lists: under every class the only files
promoted are `test/xgmii_rx_64/test_m03_j.ml` and `test/xgmii_rx_64/test_m03_n.ml`,
and under IC-J5 only the first. **55 enable-free M03 units, 79 non-M03 behavioural
units, the 1 build-level unit and `test/cosim/` green under all five.**

Freeze and integrity, at return:

```
git rev-parse HEAD                                -> cbc2765 (spawn HEAD, unmoved)
git status --porcelain | wc -l                    -> 0
git diff --name-only 8346a5c HEAD -- test/ libs/  -> (empty)
five branches: 1 commit each, sole parent 8346a5c, 1 file each,
  +2/-2, +5/-1, +1/-1, +5/-2, +7/-1
```

Finding S1's basis: `test/xgmii_rx_64/bench.ml:599-639 @ 8346a5c` carries **five**
monitor arms, `:632` `"latency tagger errors:"` preceding `:638`
`"latency tagger unclean:"`; the seal's §5.4 lists four and omits the former.

### Outcome

**DoD met.** `WO-0076-VERDICT` is appended to the campaign packet: **five classes
seeded of five sealed, five KILLED, zero survived, zero void**; all five `R!` cells
character-exact; every mutant-owned quantity inside its sealed inequality with its
sealed direction; every worked blast-radius cell exact; six `G!` cells green
(five on the matrix reading — see `FINDING WO-0076-S2`); the one `M` cell resolved
as §5.6 outcome 1 in substance; no MUST-STAY-GREEN violation, no build finding, no
red outside a class's own rule, no class out of specification.

**Rows QUALIFIED**: `M03-J1` (IC-J1, IC-J2), `M03-J2` (IC-J4, **on its honest kill
only**), `M03-J3` (IC-J3, IC-J5). `M03-J4` unqualifiable by specification.
**`M03-N4` is qualified by nothing here** — four reds, all blast radius.

**Era tally: 49/47/1/1 → 54 sealed / 52 killed / 1 survived / 1 void.**

**Auditor conduct: CLEAN** on all four disclosed exposures, and its allowlist
narrowing at the ADR discrepancy is ruled **CORRECT** — the intersection of two
disagreeing normative instruments, taken without cost and without consuming the
disagreement.

**Findings**: `FINDING WO-0076-S1` and `FINDING WO-0076-S2`, both MINOR and both
**against me**, carried to the family-K seal; `FINDING J-1` and `FINDING J-2` raised
before the run and surviving it, carried to the post-campaign `AP-` round.
**Nothing against the manifest.**

**Handoff**: `agents/handoffs/WO-0076_family-j-mutation-campaign.md`
(`WO-0076-VERDICT`), to the orchestrator.

### Open-questions

1. **Question 1 — the sequencing of the last three rounds, and it is §8.0's hazard
   one family over.** The commissioned order is family K, then `WO-0075`'s build
   round, then the post-campaign `AP-` round. Items 2 and 3 both open `test/**`,
   and family K's campaign needs the same freeze this one had — so running item 1
   first puts two `test/**`-opening rounds **inside** family K's window, and by my
   own rule the round re-seals. **My recommendation is 3 → 2 → 1**, which is Q1's
   disposition (b) — the one that worked this round — and costs nothing, since both
   are one commit each and family K's seal is not yet drafted. **The choice is the
   operator's.**
2. **Nothing is escalated.** No `BUG-`, no `E`-class item, no spec-queue addition —
   a nil escalation, declared rather than omitted.
3. **Owed to the post-campaign `AP-` round** (§13 item 2 of the verdict, carrier
   unchanged): §4.J's landed-status and per-row qualification cells,
   `FINDING J-1`'s two halves, `FINDING J-2`, `DECLARATION J-D1` as a §7 X-row **in
   its measured wording — add branch, strongest form still derived**, and
   `FINDING WO-0076-A1`'s one-line citation repair at `M03-M5`.
4. **Owed to the family-K seal by me**: `FINDING WO-0076-S1`'s monitor-arm
   enumeration **measured at the source before any arm's form is written**, and
   `FINDING WO-0076-S2`'s cell counts **re-derived from the matrix rather than
   written beside it**.
5. **The lessons-harvest span stays OPEN** and falls due at the `SO-`; candidates
   (D) and (E) are banked above, alongside (C) from `J-dv_lead-0141` and the three
   from `J-dv_lead-0137`.
6. **Carried, unchanged and not this round's to pay**: the family **K** campaign,
   owed before any `SO-`; the charter §3 differential co-sim anchor, undischarged
   and blind by **stimulus** to every configuration class; `WO-0047` §2's 4-octet
   member reorder (`test_m03_f.ml`); `OBSERVATION L-O1` (`test_m03_l.ml`);
   `WO-0073-D3`'s `M03-I4` mislabel (`test_m03_i.ml`); `OBSERVATION K-O1`
   (`test/monitors/`).

### Files-in-this-commit
- agents/handoffs/WO-0076_family-j-mutation-campaign.md
