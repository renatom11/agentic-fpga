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

## [J-dv_lead-0143] 2026-08-10T12:10Z | task:none | The ninth campaign is absorbed into the plan — and the round commissioned to record five kills spent most of its value convicting three prose claims in my own campaign artefacts, one of which had been telling every reader that a row no campaign has ever qualified was already scored

### Trigger

Orchestrator dispatch, spawn short-id `AP-batch-11/2026-08-10T12:10Z`, HEAD
`acfe0a0` — verified as my first action, per the dispatch's own bar, and matching
the expected SHA exactly, so no incident disposition fired. The commission is my
own: `WO-0076-VERDICT` §14 item 3, the post-campaign `AP-` round, run **first**
under the adopted **3 → 2 → 1** resequencing — the disposition I recommended at
`J-dv_lead-0142` Open-question 1 and the operator took. `WO-0076` §8's ordering
rule froze this file for the campaign's whole window; the campaign has scored, the
freeze has expired, and this is the round that spends it.

### Inputs

Read at `acfe0a0`, all read-only. **No RTL was opened in this round, at all.**

- `agents/charters/dv_lead.md`; `agents/PROTOCOL.md` — mandatory first actions.
- `agents/handoffs/WO-0076_family-j-mutation-campaign.md` — the whole
  `WO-0076-VERDICT` (§1–§15), plus §2's denominator and enable census, §4's ten
  declared non-scoreables, §6.2, §7's allowlist, §8's ordering rule, §11's
  qualification rule and §13–§14's owed list; and the **pre-run reading note**
  (`5ac62b5`) §4 (RN-4) and §5 (`FINDING WO-0076-A1`, adopted and widened).
- `agents/handoffs/WO-0076_family-j-mutation-campaign-SEALED-predictions.md`
  §6.6 (`FINDING J-1`, `FINDING J-2`), §6.7 (`DECLARATION J-D1`) and §6.8 — the
  declarations' frozen wording, read so this plan carries the sealed text rather
  than a paraphrase of it.
- `agents/handoffs/WO-0066_family-bn-mutation-campaign.md` — §13 item 2 and its
  qualification list, **opened specifically to re-measure a claim rather than to
  quote it**; this is the read that produced `FINDING AP-3`.
- `agents/handoffs/WO-0074_family-m-mutation-campaign.md` — its four `M03-N4`
  mentions, to measure that row's whole campaign history rather than this
  campaign's slice of it.
- `test/attack_plans/AP-xgmii_rx_64.md` in full: §0.1's set-claim rule, §1's
  closed status vocabulary, §4.J's four rows, §4.M's `M03-M5`, §4.N's rows and its
  landed-status block, §6's coverage map, §7's banner, X-table and U-1/U-2/U-3
  block, §9's change log — and **§4.M's post-campaign block as the template this
  round follows**.
- `agents/journals/claude_dv_lead_agent.v06.md`: `J-dv_lead-0138` (the family-M
  absorption, as method), `J-dv_lead-0141` and `J-dv_lead-0142` (my own pre-run
  and adjudication entries, for figures and banked candidates).
- **Not opened**: `libs/**`, `docs/reports/audit/**`, `scripts/**`, any worker
  journal. The one design-side fact this plan carries (`M03-M5`'s `a_open` term)
  is the auditor's, quoted from its committed artefact with its non-verification
  stated in the plan text, exactly as `J-dv_lead-0138` left it.

Independence (PROTOCOL §10, charter §8): this round derives nothing from RTL and
writes no test. Every figure in it is either re-measured at this tree or carried
with the SHA it was measured at, and the one figure that is carried rather than
re-derived is **flagged as such in the plan itself**.

### Reasoning

**Why one commit and not several, and it is the same argument as last time because
the situation is the same.** The verdict enumerated six debts against this file and
every one is a statement about the *same* five classes and the *same* fourteen
reds. Splitting them would produce a plan in which a row says QUALIFIED before the
block that defines what qualification **excludes** exists — the failure family L's
round was built to avoid and family M's round repeated the fix for. One coherent
edit set, history kept and ground replaced.

**The commissioned work took about a third of the round. The rest was
re-measurement, and the re-measurement is what the round is worth.** §0.1 says a
claim about a set carried in prose must be re-measured at citation or carry the SHA
it was measured at. I was carrying nine such claims out of two documents I had
written myself six hours earlier. **Three of them are false**, and all three came
out of measuring instead of quoting:

- **`FINDING AP-2`** — the verdict's §2 says *"fifteen reds across five classes"*;
  its own scorecard table in the same section enumerates **fourteen**, and fourteen
  is what the per-class blast-radius rows sum to (4 + 4 + 2 + 3 + 1). **This is
  `FINDING WO-0076-S2`'s defect at its second instance inside the same document,
  one section from where I filed the first** — precisely what harvest candidate
  (E), banked one entry earlier, says will happen without the rule. The
  blast-radius figure is the number a later scorecard quotes, so the plan carries
  **fourteen reds, five kills, nine reds that qualify nothing**, and the correction
  is stated rather than the number quietly changed.
- **`FINDING AP-3`, and it is the one with teeth.** `WO-0076` §2 and the verdict §8
  both call `M03-N4` *"already scored at `WO-0066`"* — a clause whose entire
  function is to soften **QUALIFIED BY NOTHING HERE** into *qualified elsewhere*.
  Measured against `WO-0066` itself: that campaign qualified `M03-N2`, `M03-B2` and
  `M03-B4` member (b), and its own §13 item 2 calls `M03-N1`/`M03-N4` *"both still
  outstanding ASSERT rows"* whose bench **had not been written**. The row could not
  have been scored there and was not. Widened to the whole era: `M03-N4` has taken
  **five** reds across **two** campaigns — one under `IC-M4` at `WO-0074`, four
  here — and has been **qualified by none of them**, and `M03-N1` is qualified by
  nothing at all. **Two of family N's four rows are landed, green, and
  mutation-scored by nothing**, and until this round the plan's own text told a
  reader otherwise. That is not a scoring error; it is an unearned reassurance
  sitting directly in the path of an `SO-`.
- **`FINDING AP-4`** — clerical, and recorded anyway because the rate is the
  argument. `WO-0076` §2 blames the naive matcher's step from 140 to 141 on *this
  file* gaining *"two further prose quotations"* during the family-M absorption.
  Measured at all six SHAs it names, this file carries **exactly one** occurrence
  throughout and already carried it **before** that absorption; the file that grew
  is `test/cosim/dune`, at `c109c08`, inside a comment quoting the **corrected**
  command. The conclusion — a directory-scoped counting instrument counts its own
  documentation — is unaffected and better supported than it was, because the
  instrument now counts two separate quotations of its own repair.

**All three are mine, all three are §0.1's shape, and all three were caught at the
point of citation.** `FINDING AP-1` was that rule's first conviction; this round
produced three more in one sitting. **The honest reading is not that my prose is
deteriorating but that the rule is finally being executed** — a claim quoted
forward is invisible, and a claim re-measured at citation is either confirmed or
convicted. It cost about twenty minutes and it stopped a false coverage statement
from reaching an `SO-`.

**The one figure I did NOT re-derive, and I flagged it rather than quietly carrying
it.** The honest-breadth line — 22 DUT-observable assertions across the three J
units, 7 reached — is a judgement over assertion bodies rather than a grep, and
§0.1 permits carrying it with the SHA it was measured at. I carried it with
`a8d6140` **and said in the plan that it is the one figure of this round not
re-derived, with the `SO-` named as its carrier**. Having just convicted three
figures from the same two documents, quoting a fourth without marking it would have
been the exact failure I was convicting.

**Where each commissioned item landed, and why there rather than elsewhere.**
Qualification is a property of an **instrument**, so it belongs in the row whose
instrument it is — hence three J rows carrying their own kills with carriers and
run ids, and `M03-J4` and `M03-N4` carrying their **negatives** in their own cells,
because a scorecard reader meets those there and nowhere else. A finding about a
**Kills** cell goes in that cell (`FINDING J-1`); a finding about an **Observable**
goes in that one (`FINDING J-2`, `DECLARATION J-D1`'s bar) — the plan's own
disposition, stated at `M03-N4` and applied here without exception. `FINDING
WO-0076-S1` and `S2` are findings about **how a seal is written**, and the next
seal's author reads the plan rather than the packet, so they land in the
post-campaign block where family M's four sit.

**The one place I narrowed a commission, and the narrowing is disclosed rather than
absorbed.** The verdict asks for `DECLARATION J-D1` *"as a §7 X-row"*. §7's own
taxonomy makes that impossible to honour literally without damage: **an X-row says
a row cannot be asserted until machinery exists**, and here nothing is missing —
the assertion is landed, it is green, **it has killed twice**, and the separating
instrument is landed too at another row. So J-D1 lands in §7 **beside** the X-rows
as **U-4**, exactly the disposition `J-dv_lead-0138` took for `DECLARATION
WO-0074-D1` and for the same reason. **And U-4 is a third kind again**, which is
why it is not folded into the U-1/U-2 table either: U-1 and U-2 are bench-side (a
sibling assertion already compared the subject), U-3 is design-side (the report
grammar has no member to displace), and **U-4 is the shape of the observable
itself** — an absence cannot distinguish never-produced from produced-and-
suppressed. The instrument speaks; what it cannot do is **mean what its green looks
like it means**. Folding that into either table would have destroyed the
distinction the section exists to keep.

**Why `M03-J2` is the row this campaign vindicated and `M03-J1` is the row it
embarrassed.** On 2026-08-09 I withdrew `M03-J2`'s stated kill as unreachable under
its own stimulus, from arithmetic, before a bench existed. **IC-J3 rendered exactly
the design the withdrawn cell named, reddened `M03-J3` at that row's own cell, and
left `M03-J2` green.** A bench cannot make that measurement about itself; a
campaign can, and this is the one that did — the prohibition is now enforced **on
evidence** rather than quoted. `M03-J1` went the other way: `FINDING J-1`'s second
half says REQ-810's **first sentence**, which is IC-J1's whole ground and this
campaign's **first kill**, has **no Kills cell at all**. The kill landed against a
clause my own cell never claimed. I recorded it as **owed** with a named carrier
rather than repairing it here, because writing a Kills cell is authoring an attack
and this round is not commissioned to author one — the same line `J-dv_lead-0112`
draws around improving a carrier inside a plan round.

**What I considered and declined, each with the reason, because the declined list
is what an auditor mines.** (a) **Repairing `FINDING J-1`'s second half in this
commit** — declined: a new Kills cell is a new attack, it wants the derivation
discipline a bench packet gives it, and slipping one into an absorption round is
how an unreviewed attack enters a plan. (b) **Annotating §6's coverage map** with
the REQ-802 reset-column bar — declined on the family-M precedent: §6's row set is
unchanged by this round, a refusal about what a coverage line does **not** buy
belongs where the classes are argued, and the block carries it as item 4. (c)
**Editing §4.N's landed-status block item (1)** into its own outcome — declined
absolutely; it is annotated beside itself, and while I was there I flagged item
(3)'s separately-stale census clause rather than leave a known-stale sentence
unmarked next to a freshly-paid one. (d) **Converting any status** — declined, and
it is the rule rather than a choice: §1's vocabulary is closed at six values,
`QUALIFIED` is not one of them, and qualification measures an instrument without
discharging a row (`J-dv_lead-0109`). (e) **Opening any carrier under `test/**`** —
declined: `WO-0047` §2's member reorder, `OBSERVATION L-O1`, the `M03-I4` mislabel
and `OBSERVATION K-O1` all stay at their own carriers.

**One deliberate authorial constraint worth recording because it is measurable.**
The new block discusses the contaminated matcher without ever **quoting** the
unit-declaration literal, so the naive figure is still **141** after this commit —
stated in the block and checkable in one command. A document that discusses a
counting bug and then feeds it is not describing the bug, it is participating in
it.

**Harvest note (ADR-0018, PROTOCOL §7): NOT DUE, declared rather than skipped.**
The harvest falls at the `SO-` and at phase gates; this is a plan round. The span
since my last harvest stays **open**, and the candidates banked against it are
untouched and unadmitted: (C) at `J-dv_lead-0141`, (D) and (E) at
`J-dv_lead-0142`, and the three at `J-dv_lead-0137`. **One further candidate is
banked from this round's own three findings**, stated with the provenance hidden:
**(F)** *A document that absorbs another document's result re-derives every
quantity it carries forward, and marks in its own text any quantity it could not
re-derive.* **LH1**: this round — `FINDING AP-2`, `AP-3` and `AP-4`, three false
prose claims carried out of two documents in one absorption, against one figure
carried with its provenance and marked. **LH2-g** — no proper noun of any kind.
**LH3**: without it, an absorbing document launders an unmeasured claim into a
durable one, and the later artefact resting on it has no way to tell a measured
figure from a copied one.

### Actions

- Verified `HEAD` as the **first action, before reading anything**: `acfe0a0`, the
  expected SHA, so no rollback or divergence disposition fired.
- Read the charter, the protocol, the whole `WO-0076` packet, its seal, its pre-run
  note and its verdict, and this plan in full including §4.M's post-campaign block
  as the template.
- **Re-measured before writing**, rather than quoting: the campaign's per-class red
  sets and their sum; `M03-N4`'s and `M03-N1`'s whole campaign history across every
  campaign packet in `agents/handoffs/`; the naive-matcher contamination at six
  named SHAs; the plan's status-cell census before and after the edits; the unit
  inventory and row-discharge census; the seal-to-verdict freeze.
- **Edited six row lines** in one file, all by appending to a cell and never by
  rewriting one: `M03-J1` (Observable — `DECLARATION J-D1`'s bar; Kills —
  QUALIFIED ×2 with carriers and run ids, plus `FINDING J-1`'s two halves),
  `M03-J2` (Kills — QUALIFIED on the honest kill only, plus the withdrawal now
  measured from a run), `M03-J3` (Observable — `FINDING J-2`; Kills — QUALIFIED ×2
  at two instruments), `M03-J4` (Observable — unqualifiable by specification),
  `M03-N4` (Kills — qualified by nothing here **or anywhere**, plus `FINDING
  AP-3`), and `M03-M5` (Kills — the `a_open` citation repaired into
  `<path>:<line> @ <SHA>` form, discharging `FINDING WO-0076-A1`).
- **Inserted the FAMILY J — POST-CAMPAIGN STATUS block** after §4.J's row table:
  the five-class identifier table with branch heads and run ids, the control, the
  verified ordering rule, re-measured denominators and the enable census, the
  corrected contamination note, MUST-STAY-GREEN from the promotion lists, the
  five-row status table, the blast-radius accounting with `FINDING AP-2`, the
  collision method's first vindication on evidence, the third collision's new
  diffstat protection, the honest-breadth line with its provenance flagged, seven
  findings, the era tally and eleven refusals.
- **Added `DECLARATION J-D1` as U-4** at §7 beside U-1/U-2/U-3, with the
  three-kinds distinction stated and the X-row narrowing disclosed.
- **Annotated §4.N's landed-status block** item (1) as paid and item (3) as
  separately stale, **editing neither sentence**.
- Appended the **§9 change-log row**, thirteen numbered items, counts stated before
  and after.
- Ran **no `dune`**, no command that moves `HEAD`, the index or any ref, and no
  `git` verb outside `rev-parse`, `status`, `diff`, `log`, `show` and `grep`.
  Committed nothing. **`test/**` outside this one file is untouched.**

### Evidence

Reproducible at this commit.

```
git rev-parse HEAD                                 -> acfe0a0  (spawn HEAD, unmoved)
git status --porcelain                             -> M test/attack_plans/AP-xgmii_rx_64.md
git diff --stat                                    -> 1 file, 384 insertions(+), 6 deletions(-)
git diff --name-only 8346a5c HEAD -- test/ libs/   -> (empty)   the campaign freeze, re-verified
```

**Plan counts, measured from this file by a status-cell pass over every row table,
before AND after the edits — not carried forward:**

```
before:  78 rows | ASSERT 62 | NO-ASSERT 7 | NO-STIMULUS 4 | STRUCTURAL 4 | GAP 1
after:   78 rows | ASSERT 62 | NO-ASSERT 7 | NO-STIMULUS 4 | STRUCTURAL 4 | GAP 1
```

**Unmoved, and that is the rule rather than an oversight**: qualification measures
an instrument, discharges no row and moves no count. All 78 row lines still parse
to exactly six cells (seven pipes) after the edits, verified mechanically; the six
deleted lines in the diff are exactly the six rows edited, and every other change
is a pure insertion.

```
bash tools/dv_checks.sh   -> 78 declared / 62 naive / 62 boundary; inventory 59 and 139
                             every check that COULD run passed; 1 obligation OPEN (RFC 1071)
naive whole-tree matcher over test/            -> 141  (unchanged by this commit)
```

**The three findings this round minted, each with the measurement that produced
it:**

```
AP-2  WO-0076-VERDICT §2 says "Fifteen reds"; its own table enumerates
      4 + 4 + 2 + 3 + 1 = 14.  Fourteen reds, five kills, nine qualifying nothing.

AP-3  grep -c 'M03-N4' agents/handoffs/WO-00*mutation-campaign.md
        -> WO-0066: 1 (a forward reference to an unwritten bench, its §13 item 2)
           WO-0074: 4 (IC-M4 blast radius, qualifying nothing)
           WO-0076: 40
      WO-0066's qualification list: M03-N2, M03-B2, M03-B4 member (b). No N4, no N1.
      => M03-N4: 5 reds / 2 campaigns / 0 qualifications.  M03-N1: 0 of everything.

AP-4  git show <sha>:test/attack_plans/AP-xgmii_rx_64.md piped to a count of the
      unit-declaration literal -> 1 at ca1bb80, bb81fe5, 6f0fd5b, c109c08,
      8346a5c and HEAD (unchanged);  git grep -c ... 8346a5c -- test/ shows the
      added file is test/cosim/dune, which gained it at c109c08.
```

**Externally verifiable references carried into the plan** — CI run ids and their
conclusions, quoted at the rows and in the block: control `31061945377`
(`success`, `8346a5c`); IC-J1 `31064102925`, IC-J2 `31064103812`, IC-J3
`31064104902`, IC-J4 `31064106060`, IC-J5 `31064107507` — each `failure` at the
`build` job's step 6 and `success` at step 5, each branch one commit with sole
parent `8346a5c` touching one file.

**Nothing in this round is a test result**: no bench ran, no `dune` was invoked,
and every claim in the plan is either a citation of a run already in history at
`a8d6140`'s verdict or a measurement re-run at this tree and shown above.

### Outcome

**DoD met**, against `WO-0076-VERDICT` §14 item 3's enumeration, item by item:

| commissioned | where it landed |
|---|---|
| §4.J's rows gaining the campaign's score and per-row qualification cells | `M03-J1` (2 classes), `M03-J2` (1, honest kill only), `M03-J3` (2), `M03-J4` (unqualifiable), each in its own cell with carriers and run ids |
| `M03-N4` recorded explicitly unqualified | `M03-N4`'s own Kills cell — and, measured, unqualified by **every** campaign, which is `FINDING AP-3` |
| `FINDING J-1`'s two halves | `M03-J1`'s Kills cell, half one MEASURED and half two OWED with a named carrier |
| `FINDING J-2` | `M03-J3`'s Observable cell, with the convicting carrier named and its own unqualified state disclosed |
| `DECLARATION J-D1` as a §7 X-row in its measured wording | §7 as **U-4**, beside U-1/U-2/U-3, in the verdict's exact wording; the row-**kind** narrowing disclosed |
| `FINDING WO-0076-A1`'s citation repair at `M03-M5` | `M03-M5`'s Kills cell, `libs/hardcaml_ethernet/src/xgmii_rx_64.ml:296 @ ca1bb80` |
| `RN-4`'s ADR filename repair | the post-campaign block, item 6, with this plan's own exposure **measured at nil** |
| `FINDING WO-0076-S1` / `S2` | the post-campaign block, where a later seal's author reads them, with the family-K seal named as carrier for both |
| the honest-breadth line | the block, 7 of 22, carried with its SHA and **flagged as the one figure not re-derived** |
| era tally 54 / 52 / 1 / 1 | the block's tally table, with 52 + 1 + 1 = 54 shown |
| the change-log row | §9, thirteen numbered items, counts stated before and after |

**Beyond the commission**: `FINDING AP-2`, `FINDING AP-3` and `FINDING AP-4`, all
three against my own campaign text, all three minted by §0.1 at the point of
citation — and **AP-3 is the one that mattered**, because it removes a false
statement that a landed green row was mutation-scored when no campaign has ever
qualified it.

**Not done, deliberately, each with its carrier named in the plan**: `FINDING
J-1`'s second half (a new Kills cell is a new attack); the 22-assertion breadth
figure's re-derivation (carrier: the `SO-`); `WO-0047` §2's member reorder,
`OBSERVATION L-O1`, `WO-0073-D3`'s `M03-I4` mislabel and `OBSERVATION K-O1` (all at
their own carriers — a plan round is not where a carrier is improved).

**No `SO-` is opened or offered**, and the lessons harvest is **not due this
round**: it falls at the `SO-`, the span stays open and declared, and one further
candidate **(F)** is banked above alongside the five already held.

**Handoff**: `test/attack_plans/AP-xgmii_rx_64.md`, to the orchestrator for commit.
Commissioned next, in the adopted order: `WO-0075`'s build round, then the family
**K** campaign — which now has the clean freeze window the resequencing was chosen
to buy.

### Open-questions

1. **`FINDING AP-3` is a correction to a committed verdict, and the verdict is not
   edited.** `WO-0076-VERDICT` §8 still reads *"already scored at `WO-0066`"* in
   history, and it should — a verdict is a dated artefact. The correction lives in
   the plan, at the row the claim was about, which is where a later reader meets
   it. **If the operator judges that a verbatim-class packet carrying a convicted
   sentence needs an appended correction of its own, that is a second commit and
   the orchestrator's call; I would take it, and it is not in this one.**
2. **`M03-N4` and `M03-N1` are landed, green, `ASSERT`, and mutation-scored by
   nothing** — the first time this plan has been able to say that about two rows at
   once. Family K's campaign is the last of the era and is not aimed at them.
   **Whether the `SO-` may issue with two rows in that state is a question I raise
   now rather than at the gate**, because the answer changes what family K's packet
   should carry.
3. **`FINDING J-1`'s second half is OWED and its carrier is a round that is not yet
   scheduled** — the next one opening §4.J. If none is scheduled before the `SO-`,
   it must ride the `SO-`'s own round, and an undated carrier is how a debt becomes
   a habit.
4. **Nothing is escalated.** No `BUG-`, no `E`-class item, no spec-queue addition —
   a nil escalation, declared rather than omitted.
5. **The lessons-harvest span stays OPEN** and falls due at the `SO-`; candidate
   (F) is banked above, alongside (C), (D), (E) and the three from
   `J-dv_lead-0137`.
6. **Carried, unchanged and not this round's to pay**: the family **K** campaign,
   owed before any `SO-`; the charter §3 differential co-sim anchor, undischarged
   and blind by **stimulus** per configuration class; `WO-0047` §2's 4-octet member
   reorder (`test_m03_f.ml`); `OBSERVATION L-O1` (`test_m03_l.ml`);
   `WO-0073-D3`'s `M03-I4` mislabel (`test_m03_i.ml`); `OBSERVATION K-O1`
   (`test/monitors/`).

### Files-in-this-commit
- test/attack_plans/AP-xgmii_rx_64.md

## [J-dv_lead-0144] 2026-08-10T14:20Z | task:WO-0075 | The anchor's first real execution read at the source: T1's eight cycles are legible only through the tier that may never be adjudicated, and the guard that catches a uniform shift is blind to the one idle placement that produces one

### Trigger

Orchestrator dispatch, spawn short-id `RV-0075/2026-08-10T14:20Z`, HEAD `22ffe13`
— verified as my first action, matching the dispatch's expected SHA exactly, so no
rollback or divergence disposition fired. The commission is my own `WO-0075` §7:
review both landed halves of the cosim-lane cycle round; rule tb_writer's two
stated disagreements and the round's conduct disclosures; and, in the same round,
append the correction to `WO-0076-VERDICT` that `J-dv_lead-0143`'s re-measurement
made owing.

### Inputs

Read at `22ffe13`, all read-only. **No RTL was opened in this round, at all.**

- `agents/charters/dv_lead.md`; `agents/PROTOCOL.md` §§1–11 — mandatory first
  actions.
- `agents/handoffs/WO-0075_cosim-lane-cycle-comparison.md` in full, §0–§12,
  including tb_writer's RETURNED note — my own packet, as the thing being
  measured against.
- `agents/handoffs/WO-0076_family-j-mutation-campaign.md` §2 (line 424), §4 item 7
  (line 609), §11 (line 991) and `WO-0076-VERDICT` §2 (the scorecard table and its
  "Fifteen reds" sentence) and §8 — the four sentences the correction addresses.
- `agents/handoffs/WO-0066_family-bn-mutation-campaign.md` **§13 item 2** and its
  §1126 qualification list — **re-opened and re-measured rather than quoted from
  `J-dv_lead-0143`**, which is the whole point of `FINDING AP-3`'s own rule.
- `docs/specs/modules/xgmii_rx_64.md` **§6.1** in full — the `m + 3` sentence, its
  worked 64-octet lane-0 table, the preamble/idle-injection paragraph (*"Injection
  begins at the frame's first octet"*) and the *"as many cycles later as there are
  idles injected at or before D(m)"* clause, which is what `FINDING RV-0075-2`
  rests on.
- The two commits' diffs at the source: `5705e3a` (`tools/cosim/run_cosim.sh`,
  `J-data_wrangler-0004`) and `22ffe13` (`canonical.mli`, `canonical.ml`,
  `ours_run.ml`, `tb_xgmii_rx_64.v`, `compare.ml`, `J-tb_writer-0032`).
- Current `test/cosim/ours_run.ml` (the `run`/`accumulate` bodies),
  `test/cosim/tb_xgmii_rx_64.v` (the reading loop's statement order),
  `test/cosim/compare.ml` (`perturbed_transaction`, the seven `check` calls),
  `test/cosim/canonical.ml` (`index_map`, `Int_map`, `compare_words`),
  `test/cosim/dune`, `.github/workflows/build.yml`.
- `test/attack_plans/AP-xgmii_rx_64.md` §7's banner — bars 1–4, to confirm bar 4
  landed in the companion commit and to place this round's carriers.
- `agents/handoffs/WO-0072_m03-family-k-clear.md` §17.2 (the durability clause's
  frozen wording) and §17.3.
- `agents/journals/workers/claude_tb_writer_agent.v02.md` `J-tb_writer-0032` and
  `agents/journals/workers/claude_data_wrangler_agent.md` `J-data_wrangler-0004`
  — **the only worker journals opened, and both are returns I am commissioned to
  review.**
- `agents/journals/claude_dv_lead_agent.v06.md`: `J-dv_lead-0139` (this packet's
  drafting round and its companion commits) and `J-dv_lead-0143` (`FINDING AP-2`,
  `AP-3`, `AP-4`).
- **CI at the source**, GitHub Actions API: run `31069799617` @ `22ffe13`, both
  jobs, and the `cosim` job's **full printed log**.
- **Not opened**: `libs/**`, `top/**`, `rtl_snapshots/**`, `docs/reports/audit/**`,
  `scripts/**`.

Independence (PROTOCOL §10, charter §8): every expected value in this round is
derived from `docs/specs/`, never from RTL and never from the reference. I
re-derived SPEC-M03 §6.1's `{3 … 10}` set **before** reading tb_writer's
implementation of it, so that agreeing with the worker was a check and not an
inheritance.

### Reasoning

**The round's first decision was to refuse to read the green as the verdict, and
that decision is where everything else came from.** `run_cosim.sh` exiting 0 says
three checks passed. It does not say T0 aligned, it does not say eight words
landed on cycles 3 … 10, and it does not say the seeded shift reddened — those are
three separate claims my own §10 pinned as the meaning of the colour, and a
verdict that reads the colour instead of the log is the failure this programme
has paid for repeatedly. So I pulled the `cosim` job's printed output and
discharged §10's green condition term by term.

**Two of the three terms printed themselves. The second did not, and that is
`FINDING RV-0075-1`.** T0 printed `aligned`. Case (d) printed both
`Spec_cycle_mismatch` lines with their expected and observed cycles, which is the
tier doing exactly the job `WO-0073-D2` said it could not do. But **T1's clean
path prints a sentence, not a table** — so the eight cycles the tier asserted are
recoverable at this run **only** by subtracting T2's offset line from T2's
reference profile. `theirs = [3 4 5 6 7 8 9 10]`, `theirs − ours = [0 …]`, hence
`ours = [3 … 10]`; eight words, `tlast` at 10, and word-count equality is
independently guaranteed by the content comparison having found no
`Word_count_mismatch`. **The arithmetic is sound and the claim is established.
What is wrong is that our side's ASSERTED numbers are legible only through the
tier that MAY NEVER BE ADJUDICATED.** §5.1 asked for an expected-vs-observed
*table*; a clean run got a sentence. That is a real defect in a lane whose entire
purpose is to produce a number a sign-off packet can cite, and it is against my
own §5.1 as much as against the printer. MINOR, non-blocking, carrier named.

**`FINDING RV-0075-2` is the round's real find, and it came from taking the
worker's disagreement seriously instead of just ruling it.** tb_writer asked a
narrow question about an exit code. Working out *why* the question was hard
exposed something neither of us had stated: **§3.2 asked for a guard on the
STIMULUS carrying an injected idle; `check_timing` cannot see the stimulus, so
the landed guard tests OUR OWN OUTPUT-WORD SPACING instead.** Those predicates
are not the same, and their difference is asymmetric. §6.1: *"word m is emitted
as many cycles later as there are idles injected at or before D(m)."* An idle
before D(0) is before every D(m), so it delays every word **uniformly** — and a
uniform shift preserves every inter-word delta, which is the exact property §7
case (d) is built on. **The guard is therefore blind to precisely the idle
placements that produce a uniform delay, and T1 would report them as
`Spec_cycle_mismatch` on every word: a conformant M03 reading as `EXIT_TIMING(10)`
and thence as a `BUG-` candidate.**

**I checked whether the spec closes the hole and it closes only part of it**,
which is why the finding is bounded rather than either dismissed or alarming.
§6.1 forbids REQ-016's wrapper from placing an injected idle between a frame's
start character and its **first octet** (*"Injection begins at the frame's first
octet"*), so the blind window is narrower than it first looks — but an idle at or
after octet 0 and at or before D(0) is **both conformant and invisible**, and
§10 commissions that wrapper at 0, 1 and 7 cycles. The window is not empty.

**And the implementation could not have done better**, which is why this is a
finding against the *design of the tier* and not against the worker. A guard wide
enough to catch the uniform case would swallow IC-L2, the class the whole packet
exists to make visible. The antecedent is simply **not recoverable from the two
canonical files** — which is the same absence §9 refused a strobe record for,
seen from the other side. §9's refusal and this finding share one root: a
grammar that records neither idles nor strobes cannot carry an antecedent the
spec states in terms. I said so rather than treating them as unrelated.

**On the exit-code disagreement I affirmed the landed behaviour and still gave
the worker's question its win, because both halves are true.** Fail-closed to 4
is right today: 0 is the one unacceptable answer (a tier that declines to certify
is not clean), 5 would falsely claim T0 was unaligned, and inventing a third
bucket the packet does not have is exactly the improvisation the charter forbids.
**But mapping an `Unassertable` to 4 puts a STIMULUS condition on the
DESIGN-DEFECT axis**, and §6's own words for code 10 are *"a defect against OUR
OWN specification … a `BUG-` candidate"*. By §6's own partition a refusal belongs
on the *did-not-reach* side beside 11. So the successor code is owed —
**conditionally, on a dated trigger**: it becomes required in the same work order
that gives the lane a second frame or an injected idle, because from that commit
onward the path is reachable and the mislabelling becomes live. Not before: a
dead exit code is a summary sentence a machine writes, which is §9(c)'s own
argument turned on my own proposal.

**I also conceded the fixture defect the worker declined to resolve, because it
is mine.** §7 case (e) was specified against a two-word frame in which shifting
the last word breaks the only delta there is — so the case **cannot** separate
the two constructors, by construction. The worker was right to report that and
right not to silently lengthen the fixture; rebuilding it to test a distinction
that has no exit code yet would be work in the wrong order.

**The optional T0 case is the item where the worker's judgement beat my packet's,
and I recorded it that way round.** §7 hedged it as *"if it costs you nothing"*.
The log settles it: it is the **only** self-test path exercising exit 5, T0's red
branch, and `timing_report_to_string`'s withholding paragraph — a paragraph §5.1
made **normative** (*"never an empty section, which reads as a pass"*). Had the
worker taken the hedge, a normative print requirement would have shipped
unexecuted on the lane's first real run. **A case that is the sole exerciser of a
branch is not optional**, and a packet that marks it optional is inviting the
branch to ship dark. Minted as `FINDING RV-0075-3` against my own drafting and
banked as a harvest candidate.

**Conduct: three disclosures, no finding against either worker, and one repair
that is mine.** tb_writer's scratch `ocamlc` probe engages **no** PROTOCOL rule —
§6 constrains *staged* paths and nothing was staged; §10 constrains independence
and a stdlib-availability probe carries no design information; §8 item 6 names
`dune`, `git` and `iverilog`, none of which ran. The deviation is against a
**spawn-level allow-list phrased as a command string** where it meant an
**effect**. The worker disclosed it in its journal **and** its Return log — twice
in the repo — when the durability clause (`WO-0072` §17.2) binds only on
*refused* attempts and therefore did not even reach this act. **That is the
behaviour the clause exists to produce**, and `RV-0071-VERDICT` §3 is the entry
that had to withdraw a claim because a prior disclosure was chat-only. The repair
is mine and the orchestrator's: **state a worker's allow-list by effect, not by
literal command string**, because a string-shaped list turns an obviously
harmless act into a disclosable deviation and taxes the honesty it depends on.

**data_wrangler went narrower than its own precedent and said so, which is the
right direction of error and the right disclosure.** Round 3 used `shellcheck`, a
stub harness and `bash -n`; this round used `bash -n` alone, because this spawn's
list was narrower and its instruction was *"flag, never improvise"*. All three
choices ruled correct. **The honest consequence, recorded rather than smoothed**:
`bash -n` establishes syntax only, and §1 item 2 of the verdict confirms the CI
did not exercise the new arms either — so a fourth consecutive round has landed a
shell change whose only check is a parse. A future dispatch for that seat should
restore `shellcheck` explicitly.

**The `*)`-paragraph edit is the round's best worker act and I said so rather
than merely permitting it.** §6 says the `*)` branch *"stays exactly as it is"*;
data_wrangler left the arm byte-identical and edited the **paragraph above the
`case`**, which asserted that anything outside `{0,1,3}` is unrecognised — false
the instant `4)` and `5)` exist two lines below. Leaving it would have planted a
comment contradicting the code beneath it: §9(c)'s failure mode inside the very
packet that names it. Intent read correctly against letter, disclosed, and round
3's attribution preserved by appending rather than rewriting.

**Two clerical notes recorded against tb_writer's journal, and the reason they
are recorded is that I convicted three of my own prose claims one entry ago.**
`J-tb_writer-0032` says *"all five touched OCaml files"* and lists four; and its
Open-question 2 says *"no forbidden tool used or attempted"* three lines after
its own Evidence discloses one. Cost nil, no repair owed — but the rule that
convicted `FINDING AP-2` is an enumeration-versus-prose-count rule, and it does
not get to apply only to me.

**Why the `WO-0076` correction is APPENDED and lists four sites rather than the
two I was sent for.** `J-dv_lead-0143` convicted the "already scored at
`WO-0066`" clause; measuring it at this tree shows it standing in **four** places
across the packet and its verdict, not two. **A correction that repairs two of
four instances of one false claim is itself a false reassurance** — the exact
shape of the defect being corrected. So the block names all four, quotes each,
and edits none. **I re-verified the ground at the source rather than inheriting
it**: `WO-0066` §13 item 2 does say `M03-N1`/`M03-N4` are *"both still outstanding
ASSERT rows"* whose bench had not been written, and its qualification list is
`M03-N2`, `M03-B2`, `M03-B4` member (b). Re-measuring a conviction before
publishing it is the same rule that produced it.

**Q2, and the answer costs something either way so I priced it.** Family K's
campaign should carry the N-completion classes as a **declared, separately-sealed
section** rather than a separate pre-`SO-` mini-campaign. Both families' benches
are landed, so a second campaign buys only a second seal, a second pre-run round
and a second `test/**` freeze window — and two freeze windows before the `SO-` is
`WO-0076` §14's own silent hazard doubled. The machinery to keep two families
apart inside one campaign exists and is now vindicated on evidence (§11's
qualification rule; `FINDING WO-0074-S4`'s cross product, which found both of
`WO-0076`'s collisions in another class's blast radius), and `WO-0058` is the
two-family precedent. **The price, stated before the round rather than discovered
inside it**: four of five family-J classes reddened `M03-N4` through the admission
path, and a K class touching admission will do the same — so the seal must
enumerate the K × N cross product **before it runs** and pre-declare every K-class
red at an N row as blast radius.

**And the falsifiable half, which matters more than the sequencing.** `M03-N1`
and `M03-N4` have taken five reds across two campaigns and been qualified by none
— every one through the admission path rather than through an assertion of the
row's own observable. **If N-classes asserting those rows' own observables cannot
be authored, the rows are unqualifiable by mutation at this bench and that SHALL
be declared before the `SO-`.** A declared unqualifiable row is an honest gap; an
undeclared one is precisely the unearned reassurance I spent this round
correcting out of two documents.

**What I considered and declined.** (a) **Opening `libs/**` to check whether T1's
green is a coincidence of the implementation** — declined absolutely; charter §8
and PROTOCOL §10, and a verdict that reaches for RTL to explain a spec-derived
green has stopped being spec-derived. (b) **Editing the four `WO-0076` sentences
in place** — declined; a correction that rewrites its own subject destroys the
evidence that the error occurred, and the rate of these errors is the argument.
(c) **Filing `FINDING RV-0075-2` as MATERIAL today** — declined: §8 item 1 bars
the stimulus from changing, so the path is unreachable at this tree, and inflating
an unreachable latent defect is the mirror of the reassurance I am correcting.
Filed MINOR-today with a dated escalation. (d) **Amending `AP-M03` §7 in this
round** — declined: `test/attack_plans/**` is not this commit's business, the
carrier is the next `AP-` round, and my own R4 files list is the two packets. (e)
**Withholding ACCEPT until the producer half's new arms are exercised** —
declined: they are fail-paths, a green run cannot exercise them by definition,
and the correct response is to say so in the verdict rather than to hold a
correct half hostage to a colour it cannot produce.

**Harvest note (ADR-0018, PROTOCOL §7): NOT DUE, declared rather than skipped.**
The harvest falls at the `SO-` and at phase gates; this is a review round. The
span since my last harvest stays **open** and the candidates banked against it are
untouched and unadmitted: the three at `J-dv_lead-0137`, (C) at `J-dv_lead-0141`,
(D) and (E) at `J-dv_lead-0142`, (F) at `J-dv_lead-0143`. **One further candidate
is banked from this round**, stated with the provenance hidden: **(G)** *A test
case that is the only exerciser of a branch may not be specified as optional; a
specification that marks it optional is specifying that the branch may ship
unexecuted.* **LH1**: this round — the optional base-alignment case was the sole
exerciser of one exit code, one refusal branch and one normative print
requirement, and was written as optional. **LH2-g** — no proper noun of any kind.
**LH3**: without it, the branch a specification most wants proven is the one its
own hedge invites the implementer to skip, and the first execution that would
have proven it passes silently instead. **A second candidate is banked**: **(H)**
*A guard specified against a condition of the input cannot be implemented by a
detector reading the output, unless the mapping from that condition to the output
is injective; where it is not, the specification must carry the condition
forward as data rather than expect it to be inferred.* **LH1**: this round —
`FINDING RV-0075-2`, where two different causes produce one identical output
signature. **LH2-g** — no proper noun. **LH3**: without it, a guard looks
implemented, tests green, and is blind in exactly the direction its
specification cared about.

### Actions

- Verified `HEAD` as the **first action, before reading anything**: `22ffe13`,
  the spawn SHA, so no rollback disposition fired.
- Read the charter, the protocol, `WO-0075` in full, both workers' commits and
  journals, SPEC-M03 §6.1 in full, `WO-0066` §13 item 2 at the source, and
  `AP-M03` §7's banner.
- **Re-derived SPEC-M03 §6.1's expected cycle set independently** (`{3 … 10}`,
  `tlast` at 10, from `admit_cycle + m + 3` at `admit_cycle = 0` over eight
  delivered words) **before** reading the landed constant.
- **Verified the shared time base at both producers by reading the code**, not by
  accepting the claim: `List.mapi`'s index against the `Side.Before` sampling
  order on our side; `stimulus_lines`'s single increment at the top of the loop
  body, before both tasks, on the reference's.
- **Traced all seven self-test fixtures by hand through `run_comparison`** and
  predicted each exit code before reading the CI log; all seven matched.
- **Pulled run `31069799617`'s two job results and the `cosim` job's full printed
  log from the GitHub API**, and discharged §10's green condition term by term
  against the log rather than the exit code.
- **Appended `RV-0075-VERDICT`** to `WO-0075` (§1 the CI reading with its three
  terms and its three non-claims; §2/§3 the two line reviews; §4 the two
  disagreement rulings; §5 the conduct rulings; §6 what the anchor now measures
  versus what remains; §7 the commissions including Q2's answer; §8 the verdict),
  and updated that packet's `State` header field `DRAFT` → `ACCEPTED` — the only
  line of the original packet this round edits.
- **Appended the dated correction block** to `WO-0076`, naming **four** sites of
  the `M03-N4` claim and the one site of the red count, quoting each and editing
  none.
- Ran **no `dune`**, no command that moves `HEAD`, the index or any ref, and no
  `git` verb outside `rev-parse`, `log`, `show`, `status` and `diff`. Committed
  nothing. **No file under `test/**`, `tools/**` or `libs/**` was written.**

### Evidence

Reproducible at this commit.

```
git rev-parse HEAD          -> 22ffe136fd53b5d90b86770410b1272acac69538  (spawn HEAD, unmoved)
git status --porcelain      -> M agents/handoffs/WO-0075_cosim-lane-cycle-comparison.md
                               M agents/handoffs/WO-0076_family-j-mutation-campaign.md
git diff --stat             -> 2 files, 677 insertions(+), 1 deletion(-)
git log -1 --format=%H -- test/cosim/dune   -> c109c08  (Agent: dv_lead, J-dv_lead-0139, WO-0075)
```

**CI at the source — GitHub Actions run `31069799617` @ `22ffe13`, both jobs
`success`** (externally verifiable per ADR-0003/F5):

```
build  job 92515154870  success   step5 dune build @default = success
                                   step6 dune runtest       = success
                                   steps 7,8,9,10           = success
cosim  job 92515154840  success   step6 run_cosim.sh        = success (all three checks)
```

`cosim` job printed output, quoted from the log:

```
CHECK 1/3   frames compared: 1 / frames matching: 1 / divergences: none
            T0: aligned -- every frame index present on both sides shares one admit-cycle
            T1: clean -- ... (admit_cycle + m + 3) cycles
            frame 0: theirs cycles = [3 4 5 6 7 8 9 10]
            frame 0: theirs - ours per word = [0 0 0 0 0 0 0 0]
              => ours = [3 4 5 6 7 8 9 10], eight words, tlast at 10   (derived)
self-test   (a) exit 0   (b) exit 1   (c) exit 3   (d) exit 4   (e) exit 4
            (f) exit 3   (T0, optional) exit 5      -> "compare --self-test: OK"
(d) printed frame 0 word 0: pins cycle 3, observed 4
            frame 0 word 1: pins cycle 4, observed 5
(e) printed frame 0: T1 UNASSERTABLE -- output words 0 and 1 are 2 cycle(s) apart
(f) printed line 1: F line is missing its admit-cycle token
(T0) printed T0: RED ... / T1: WITHHELD ... / T2: WITHHELD ...
CHECK 3/3   ours.canon and theirs.canon byte-identical between run1 and run2
```

**Not exercised by this run, stated so no later packet may cite it**:
`EXIT_TIMING(10)`, `EXIT_TIMING_NO_VERDICT(11)` and `run_cosim.sh`'s `*)` arm.
`compare` returned 0 from check 1/3 and 0 from the self-test aggregate; the
self-test's internal 4s and 5s never reach `case "$DIFF_RC"`.

**Correction ground, re-measured rather than inherited**:
`WO-0066` §13 item 2 (line 563–564) — `M03-N1`/`M03-N4` *"both still outstanding
ASSERT rows"*, bench unwritten; `WO-0066` §1126 qualification list — `M03-N2`,
`M03-B2`, `M03-B4` member (b), no `M03-N4`. `WO-0076-VERDICT` §2's own table sums
4 + 4 + 2 + 3 + 1 = **14**.

### Outcome

**`WO-0075` ACCEPTED, both halves** — data_wrangler at `5705e3a`, tb_writer at
`22ffe13`. Both §10 checklists met; the landing CI, which §10 names as the only
check, is green on both jobs and its green means what §10 said it would, verified
against the printed log. **`FINDING WO-0073-D2` is CLOSED**: the lane can see
time, asserted against SPEC-M03 and never against the reference.

Three findings raised, all MINOR at this tree, none blocking, all with named
carriers: **`RV-0075-1`** (T1 prints no numbers on the clean path — my §5.1 and
the printer); **`RV-0075-2`** (the guard is a proxy and is blind to the uniform
idle placement — latent false positive, escalates the moment §8 item 1 lifts);
**`RV-0075-3`** (a sole-exerciser case may not be marked optional — my drafting).
Both disagreements ruled; three conduct disclosures ruled with **no finding
against either worker**; the `test/cosim/dune` sighting verified as my own
companion commit and the worker's disposition credited.

**`WO-0076` carries a dated appended correction** covering `FINDING AP-2`'s red
count (fourteen, not fifteen) and `FINDING AP-3`'s coverage claim at **all four**
of its sites. Neither correction moves the score; the second removes an unearned
reassurance from the path of the `SO-`.

`SO-xgmii_rx_64.md` does not issue and none is offered.

### Open-questions

- **`FINDING RV-0075-2`'s escalation is dated, not open-ended, and the date is a
  commit rather than a clock**: the first work order giving this lane a second
  frame or an injected idle must carry the antecedent repair, the
  `EXIT_TIMING_UNASSERTABLE(12)` code and the case-(e) fixture rebuild **in the
  same round**. If that work order is drafted without them, a conformant M03
  reddens as a `BUG-` candidate.
- **Q2 is answered but the answer is a recommendation, not a ruling I own alone**:
  one campaign with a separately-sealed N section. If the operator prefers a
  separate mini-campaign, the falsifiable condition (N1/N4 declared unqualifiable
  if their own observables cannot be asserted) transfers unchanged and is the part
  that must not be dropped.
- **`AP-M03` §7 owes three placements from this round** — `RV-0075-1`'s and
  `RV-0075-2`'s carriers beside bar 4, and bar 4's own reconfirmation at the
  anchor's first timing execution. Owed to the next `AP-` round, not to this
  commit.
- **The producer half has now landed four consecutive rounds whose only check is
  a parse.** Not a finding this round; it becomes one if a fifth lands the same
  way.
- **Still owed, carried forward unchanged**: the family-K campaign (the last of
  the era, and the `SO-`'s remaining gate alongside the `N/N` mutation clause);
  `FINDING J-1`'s second half (REQ-810's first sentence has no `Kills` cell);
  `FINDING J-2`; `WO-0047` §2's 4-octet anti-vacuity question; `OBSERVATION L-O1`;
  `WO-0073-D3`'s `M03-I4` mislabel; `OBSERVATION K-O1`; AP-M14's §6 invariant; the
  `precompile_check.sh` side-effect lane; the RFC 1071 anchor; X-7, X-10, X-11
  deferred; L1–L5 as a separate packet. **The lessons harvest falls at the `SO-`;
  the span stays open with eight candidates banked.**

### Files-in-this-commit
- agents/handoffs/WO-0075_cosim-lane-cycle-comparison.md
- agents/handoffs/WO-0076_family-j-mutation-campaign.md

## [J-dv_lead-0145] 2026-08-10T15:10Z | task:WO-0077 | The era's last campaign sealed: nine classes across two separately-sealed sections, the K × N cross product measured EMPTY before it runs — and the round's largest finding is that my own pre-committed disposition table asks a scorecard to tell three defect classes apart at an assertion that prints nothing it observed

### Trigger

Orchestrator dispatch, spawn short-id `WO-0077/2026-08-10T15:10Z`, HEAD `981331f`
— verified as my **first action**, before reading anything, per the dispatch's own
bar and matching the expected SHA exactly, so no rollback or divergence
disposition fired.

The commission is my own, adopted from `RV-0075`'s Q2 answer: the **family-K
mutation campaign** as packet `WO-0077`, freeze-first, with its SEALED companion
in the same commit — **one campaign carrying a declared, separately-sealed
N-completion section**, not a separate mini-campaign. My own stated terms bind
the shape: the seal SHALL enumerate the K × N cross product **before it runs** and
pre-declare every K-class red at an N row as blast radius; and **the falsifiable
half** — if N-classes asserting `M03-N1`'s and `M03-N4`'s own observables cannot
be authored, those rows are unqualifiable by mutation at this bench and that SHALL
be declared before any `SO-`, never discovered by a sixth unqualifying red.

### Inputs

Read at `981331f`, all read-only. **No RTL was opened in this round, at all.**

- `agents/charters/dv_lead.md`; `agents/PROTOCOL.md` §§1–11 — mandatory first
  actions.
- `agents/handoffs/WO-0076_family-j-mutation-campaign.md` §0–§16 in full, its
  pre-run reading note, `WO-0076-VERDICT` §10 (`FINDING WO-0076-S1`, `S2`,
  `FINDING J-1`, `FINDING J-2`) and §12–§14, and my own appended correction — read
  as the template this packet follows and as the source of two of the five
  inherited bars.
- `agents/handoffs/WO-0076_family-j-mutation-campaign-SEALED-predictions.md` in
  full — the seal whose form this one takes and whose §5.4 defect I am carrying a
  bar against.
- `agents/handoffs/WO-0072_m03-family-k-clear.md` **§9** (the pre-committed D1–D6
  disposition table, verbatim), §7.5 and §8.6 — the ground for four of six K
  classes and the subject of `FINDING K-1`.
- `agents/handoffs/WO-0058_m03-g7-h-mutation-campaign.md` section map — the
  two-family precedent, read for its structure and not for its content.
- `test/attack_plans/AP-xgmii_rx_64.md`: **§4.K** in full (both rows, the
  withdrawn class, the honest kill, the reclassified third kill, the landed-status
  block), **§4.N**'s `M03-N1`, `M03-N2`, `M03-N3` and `M03-N4` rows in full
  including `FINDING AP-3`'s correction as it now reads there, and §7's banner.
- `docs/specs/requirements.md` **REQ-009** and **REQ-015** in full;
  `docs/specs/modules/xgmii_rx_64.md` **§7**'s Reset bullet, **§6.2**'s state
  table in full, **§9**'s *"one real exception"* paragraph and its *"When a frame
  is open"* list, and **§4.1**'s `clear` port row.
- `test/xgmii_rx_64/test_m03_k.ml` in full (661 lines, both units);
  `test_m03_n.ml`'s `run_n1` and `run_n4` in full; `test_m03_b.ml`'s seven unit
  titles; `bench.ml`'s `create` (lines 49–83), `sample_cycle`, `run` (both
  pre-scan guards, the `?clear` plumbing), `assert_monitors_clean` (599–639),
  `frames_at`/`one_frame` and `delivered_samples`.
- `test/cosim/ours_run.ml` (lines 150–170) and `test/cosim/tb_xgmii_rx_64.v`
  (`rst` at `:62`/`:257`, `cfg_rx_enable` at `:63`) — for §5 item 4's stimulus
  claim, read at the source rather than carried from `WO-0076`.
- `agents/journals/claude_dv_lead_agent.v06.md`: `J-dv_lead-0143` (the family-J
  absorption and `FINDING AP-3`), `J-dv_lead-0144` (my own `RV-0075` round, whose
  Q2 answer this packet executes).
- **Not opened**: `libs/**`, `top/**`, `rtl_snapshots/**`, `docs/reports/audit/**`,
  `scripts/**`, any worker journal.

Independence (PROTOCOL §10, charter §8): every class in this packet is derived
from a REQ- or SPEC- sentence or from a plan cell that was itself derived from
one. **No RTL was read, and no class describes a mechanism I have seen.** Where a
rendering's internal shape is under-determined by the specification, the packet
asks the auditor for it as a disclosure rather than guessing (`D-K4c`,
`D-N4a-1`), which is the honest form of not having looked.

### Reasoning

**The round's first real decision was to stop trusting my own class list and work
the bench's assertion order instead, and that is where everything else came
from.** I could have written six K classes from `WO-0072` §9's D1/D2/D3 and §4.K's
Kills cells in an hour. Instead I traced both K units' `fail` sites in source order
and asked, per class, *which assertion speaks first*. **The answer is that
`M03-K2`'s FIRST DUT-observable assertion is the whole run's delivered-cycle list,
and its message names the expected list and prints nothing it observed
(`test_m03_k.ml:470`).** Every class that moves which cycles carry a delivered word
— a phantom closure (D1), a lost or late frame B (D2), a leaked word (D3), a
shifted window — raises **that** assertion, **character for character**, and
nothing after it.

**`FINDING K-1`, and it is against my own artefact rather than the bench's.**
`WO-0072` §9 pre-committed D1, D2 and D3 as three *distinct* dispositions with
three *distinct* `BUG-` citations — D1 citing REQ-009's truncation sentence, D2 its
last sentence, D3 its first clause — to be applied *"against the CI `build` run at
the landing commit"*. **That table asks the adjudicator to tell three classes apart
from what a scorecard prints, and at this row a scorecard prints one identical
sentence for all three.** Reachable is not separable. And the finding has a second
half from the same reading: `M03-K2`'s Kills cell says kill 1 is *"reachable at
THREE distinct sites"*, and measured against the row's own instrument the three
sites produce **one message** and **two** distinct observed lists. **The clinching
evidence is inside the same bench**: `M03-N4`'s equivalent assertion, the same
shape at `test_m03_n.ml:1305`, **prints its observed list**. So this is a defect in
one message, not a limitation of the form — which is what makes it repairable and
what makes leaving it unrepaired a choice with a named carrier rather than a
shrug.

**I refused to repair it here and the refusal is the ordering rule, not
squeamishness.** §10's freeze says every `test/**` byte this campaign scores
against is at or before the base SHA and nothing moves until it scores. **Editing
the assertion that scores four of six classes, inside the window that scores them,
would void the round by its own rule** — and it would do it while making the seal
look better. Carrier named: the next commit opening `test_m03_k.ml`.

**The falsifiable half came back AFFIRMATIVE, and the derivation is what matters
rather than the answer.** I worked both N rows' Observables against their units'
assertion orders. `M03-N1`'s second clause (*"produces nothing and pulses
nothing"*) is asserted by a strobe-set emptiness check at `:954`, and its own Kills
cell names the design that breaks it. `M03-N4`'s four Observable clauses split
across **two** assertions: clauses 1 and 3 at the delivered-cycle list, clause 2 at
the exact-strobe-set check — and **neither is the admission gate**. That is the
whole reason the rows are qualifiable: every one of `M03-N4`'s five historical reds
came through admission, which is why all five were family-J blast radius, and the
two classes I authored come through the **abort geometry** and the **report path**
instead. **I recorded the counterfactual in the packet** — had both assertable
clauses been reachable only through admission, no class asserting the row's own
observable could have been authored without being a family-J class, and the row
would have been unqualifiable — because a falsifiable claim that cannot say what
would have falsified it is not one.

**`IC-N4b` is the class I am most pleased with and it is not mine.** `FINDING J-2`
named `M03-N4` as the sole carrier that convicts a design **suppressing** an
in-flight frame's own report, and recorded that no campaign had ever seeded one.
That debt has been open across two verdicts. **`IC-N4b` is that design**, it
reddens `M03-N4` alone, and its green at `M03-J3` measures `FINDING J-2`'s
subtractive asymmetry from a run rather than from an argument. A finding raised in
one campaign and paid in the next is the shape this programme is supposed to have
and rarely achieves.

**Where each inherited bar changed what I sealed, stated concretely because "the
bar was applied" is not evidence.**

- **`FINDING WO-0074-S1` (complete conjunct lists) changed the seal from
  incomplete to correct, and it was the largest single correction of the round.**
  My first rule for every K class had one conjunct: *the unit drives `clear` high
  during its schedule*. That selects two units and is **false as a complete
  statement**, because `Bench.create` drives `clear` = 1 for one cycle with an idle
  word before **every one of the fifty-nine** M03 schedules (`bench.ml:64–68`). A
  class mishandling a clear with nothing pending would have reddened fifty-nine
  units against a seal predicting two, and the seal would have scored a correct
  scope finding as an unnamed-unit finding. **The seal now carries (κ1) ∧ (κ2), and
  the protecting fact is measured rather than assumed**: every schedule's
  `first_start` is ≥ 8 octet times, so the earliest start character anywhere in
  this bench is cycle **1** and no unit presents one on cycle **0**, which is the
  reset pulse's release cycle. `D-K5b` exists solely to make the auditor discharge
  that.
- **`FINDING WO-0074-S4` (the cross product) yielded three different things and
  one of them is a negative.** It found the fourth member of the four-class
  collision — `IC-K1`'s arrival at `M03-K2`'s choke point is *branch-dependent*
  under `D-K1a`, so the scored-cells-only method would not have had it in the
  inventory at all. It found collision 3 (IC-K1 site (i) and IC-K6's one-leaked-
  cycle rendering produce the **same observed list** as well as the same message).
  **And it proved the K × N and N × K cross products EMPTY — eighteen predicted
  greens — which is the machinery the one-campaign ruling rests on.** At family J
  the same enumeration cost four blast-radius cells at `M03-N4`; here the census
  intersection is empty and the price I named before the ruling is discharged by
  measurement rather than by promise.
- **`FINDING WO-0076-S1` (arms from the file, never memory) is discharged in the
  OPEN as well as in the seal.** Five arms at `bench.ml:604`, `:610`, `:616`,
  `:632`, `:638`, in source order, with arm 4 (`latency tagger errors:`)
  **preceding** arm 5 (`latency tagger unclean:`) and arm 5 gated on
  `frames_compared > 0` — the exact ordering `WO-0076`'s seal got wrong from
  memory. It changed something: `M03-K2` asserts `frames_compared = 2` before
  reaching the function, so arm 5's gate is satisfiable at every unit this
  campaign scores, which a seal written from memory would not have checked.
- **`FINDING WO-0076-S2` (matrix counts re-derived) caught me mid-draft.** The
  `G!` count is stated as **5 + 1 = 6** in §K and **1** in §N with the arithmetic
  beside the matrix at both places, and all seven are enumerated with the
  measurement each carries. **And it caught a worse one**: I had written
  "the two K units carry 34 DUT-observable assertion sites" and "3 of 34" — a
  denominator I had not counted. `grep -cE` gives **95** matching `fail` lines in
  that file, of which 3 carry `test bug`; classifying the rest is a judgement over
  assertion bodies and not a grep. **So the seal states the numerator exactly (six
  distinct raise sites, seven under `D-N1c` branch β) and the denominator only as
  a measured upper bound, and says so.** That is `J-dv_lead-0143`'s own
  §0.1 conviction applied to me before publication instead of after.
- **`FINDING RV-0075-3` (no sole-exerciser marked optional) bound §14 and it bound
  it against a real temptation.** Nine transients is 51.6 minutes and the obvious
  economy is to drop a class. **`IC-K5` is the only class in the campaign that
  measures `WO-0072` §7.5's *"invisible at `M03-K1`"* derivation, and `IC-N4b` is
  the only class that reaches a strobe-set assertion at a frame the enable did not
  refuse.** Both are named as sole exercisers, both are MANDATORY, and the trade is
  stated in figures. **No class, cell or lane in this packet is hedged with "if it
  costs you nothing."**

**One thing I minted rather than inherited, and it is the finding turned into a
rule.** **Standing rule 8**: where a scored cell's message contains no observed
data, the seal SHALL say so at the cell, name every other class that reaches the
same cell, and state what — other than the branch identity — distinguishes them,
**including "nothing"**. Four of §K's six cells now carry that sentence. A previous
seal would have written them as exact strings and called them predictions; they
are predictions about **which assertion speaks at which unit** and about
eighty-four other units staying green, and about nothing the mutant computed.
Saying so at the cell is the difference between a weak seal and a seal that
conceals its weakness.

**What I considered and declined, each with the reason, because the declined list
is what an auditor mines.**

(a) **Dropping `IC-K6` (D3) to shrink the collision cluster from four classes to
three** — declined. It lands on an already-crowded cell and adds nothing to
discrimination, which is the case *for* dropping it; but `WO-0072` §9 committed D3
as a disposition class in writing, and an `SO-` claiming family K is
mutation-scored while a named pre-committed class went unseeded is exactly the
unearned reassurance I spent `RV-0075` correcting out of two documents.

(b) **Inventing an "early leading edge" class to give `M03-K1` a second chance at
qualification** — declined, and the declining is a real result. I worked it: to
act *early* the gate would have to see `clear` a cycle ahead, which is not
physical under the bench's `Before` sampling. The physical off-by-one is **late**,
and `WO-0072` §7.5 already derived that it is invisible at `M03-K1`. **So the
honest position is that `M03-K1` has exactly one convicting surface — a carry —
and `IC-K4` is it.** §5.6 outcome 3 pre-commits what a `NOT SEEDED` there means:
the row is declared **UNQUALIFIABLE BY MUTATION at its own stimulus**, with the
derivation, in the verdict and in the `SO-`. That is the N1/N4 falsifiable-half
discipline applied to a K row, and I would rather declare it than let a seventh
campaign discover it.

(c) **Specifying `IC-K4`'s carry mechanism myself** — declined absolutely. I have
not read the RTL and a plain registered strobe would move every pinned strobe
cycle in the suite, which is a scope violation and not a class. **`D-K4c` asks the
auditor to name the mechanism or declare NOT SEEDED**, and §4.4 pre-fixes an
executable discriminator: if the message that speaks is the *cycle* arm rather than
the *count* arm, the rendering re-timed instead of carrying and disposition 7
governs. That is a prediction I can be wrong about, which is the point.

(d) **Enumerating `IC-N1`'s blast radius exhaustively** — declined, and the
narrowing is disclosed. I measured the family-B unit titles and derived that
`M03-B2`, `M03-B2 /I/`, `M03-B2 /Q/`, `M03-B3` and `M03-B4` are selected by the
rule alongside `M03-N2`'s six sub-cases; `M03-B4 (b)` is marked **UNWORKED**
because its two start characters are in different input words. **Standing rule 5
governs: the RULE governs where rule and instance list disagree.** And working it
produced something better than a list: **the class runs in two directions** — it
ADDS a strobe at `M03-N1` (the word starts in `Frame`) and REMOVES one at every
selected family-B unit (the word starts in `Idle`), so a scorecard showing only
one direction is a finding against my rule.

(e) **Repairing `FINDING J-1`'s second half, `OBSERVATION L-O1`, the `M03-I4`
mislabel or `WO-0047` §2 while I was here** — declined; all are `test/**` and all
are inside the freeze. Carriers unchanged.

(f) **Opening `libs/**` to check whether `IC-K4` is renderable at all** — declined
absolutely. Charter §8 and PROTOCOL §10, and a packet that reaches for RTL to
decide whether its own class exists has stopped being spec-derived. The question
goes to the auditor as a disclosure, which is where it belongs.

**Harvest note (ADR-0018, PROTOCOL §7): NOT DUE, declared rather than skipped.**
The harvest falls at the `SO-` and at phase gates; this is a campaign-drafting
round. The span since my last harvest stays **open** and the eight candidates
banked against it are untouched and unadmitted: the three at `J-dv_lead-0137`, (C)
at `J-dv_lead-0141`, (D) and (E) at `J-dv_lead-0142`, (F) at `J-dv_lead-0143`, (G)
and (H) at `J-dv_lead-0144`. **One further candidate is banked from this round**,
stated with the provenance hidden: **(I)** *An assertion that names its expected
value without reporting the observed one collapses every distinct cause into one
indistinguishable effect; a disposition table written against such an assertion is
a taxonomy rather than a discriminator, and SHALL be checked against the message
its own tell will produce before the run that applies it.* **LH1**: this round —
`FINDING K-1`, where three pre-committed disposition classes with three distinct
remedies all resolve to one character-exact sentence, and a sibling assertion of
the same shape in the same suite reports its observation. **LH2-g** — no proper
noun of any kind. **LH3**: without it, a team writes its adjudication rules against
what it believes the failure means rather than against what the failure will say,
and discovers the gap in the round that most needs the distinction.

### Actions

- Verified `HEAD` as the **first action, before reading anything**: `981331f`, the
  spawn SHA, so no rollback or divergence disposition fired.
- Read the charter, the protocol, `WO-0076`'s packet, seal, reading note and
  verdict, `WO-0072` §9/§7.5/§8.6, `WO-0058`'s section map, `AP-M03` §4.K and
  §4.N, REQ-009/REQ-015 and SPEC-M03 §6.2/§7/§9, and both bench files in full.
- **Traced every `fail` site in `run_k1`, `run_k2`, `run_n1` and `run_n4` in
  source order** and classified each as bench-side, driven-port or DUT-observable
  — the trace that produced `FINDING K-1`.
- **Re-measured at this tree rather than carrying forward**: the unit denominators
  (59 / 139, `bash tools/dv_checks.sh`); the **clear census** (2 units); the
  **enable census** (4 units); their **empty intersection**; `create`'s reset pulse
  and its cycle-0 release; every schedule's `first_start` (all ≥ 8 octet times);
  `assert_monitors_clean`'s five arms with line numbers; the last `test/**` edit
  (`22ffe13`); and both cosim producers' `clear`/`cfg_rx_enable` stimulus.
- **Read back every sealed message literal from its own source line** after
  drafting, and recorded the line numbers in the seal's §4.0.
- **Wrote `agents/handoffs/WO-0077_family-k-mutation-campaign.md`** — eighteen
  sections, nine classes, nineteen disclosures, twelve declarations of what the
  campaign cannot score, the cross-product enumeration, the per-class permission
  lists, the allowlist, the ordering rule, the price and three questions.
- **Wrote `agents/handoffs/WO-0077_family-k-mutation-campaign-SEALED-predictions.md`**
  — eight standing rules including one minted this round, two separately-sealed
  sections, both matrices with their arithmetic shown, every rule with its complete
  conjunct list, the verbatim cells with their raise-site line numbers, the
  eighteen-cell cross product, three collisions with their discriminators, ten
  pre-committed dispositions, the mutant-owned table, eleven bounds and ten pass
  criteria.
- Ran **no `dune`**, no command that moves `HEAD`, the index or any ref, and no
  `git` verb outside `rev-parse`, `log`, `status` and `diff`. Committed nothing.
  **No file under `test/**`, `tools/**` or `libs/**` was written, and the attack
  plan was not touched.**

### Evidence

Reproducible at this commit.

```
git rev-parse HEAD          -> 981331f90c66d6269b7f91e77cedebce89480b1c  (spawn HEAD, unmoved)
git status --porcelain      -> ?? agents/handoffs/WO-0077_family-k-mutation-campaign.md
                               ?? agents/handoffs/WO-0077_family-k-mutation-campaign-SEALED-predictions.md
                               M  agents/journals/claude_dv_lead_agent.v06.md
git log -1 --format=%h -- test/   -> 22ffe13   (the last test/** edit; this commit adds none)
```

**Denominators and censuses, measured at this tree and not carried forward:**

```
bash tools/dv_checks.sh
  -> 59 test/xgmii_rx_64/ | 139 test/**/*.ml | 78 row ids | 62 naive | 62 boundary
     every check that COULD run passed; 1 obligation OPEN (RFC 1071)

clear census   grep -rn --include=*.ml '~clear\|Clear\.' test/
  -> test_m03_k.ml:228 (M03-K1), :459 (M03-K2)          TWO units of 59
     bench.ml (plumbing, K guard, create's reset pulse); test_m03_structural.ml (witness)

enable census  grep -rn --include=*.ml '~enable' test/
  -> test_m03_j.ml:169, :279, :488 ; test_m03_n.ml:1256  FOUR units of 59

intersection { M03-K1, M03-K2 } ∩ { M03-J1, M03-J2, M03-J3, M03-N4 } = EMPTY
```

**The reset-pulse conjunct, measured rather than assumed:**

```
bench.ml:64-68   create () drives an idle word, clear := vdd, cfg_rx_enable := vdd,
                 one Cyclesim.cycle, then clear := gnd
                 -> ALL 59 M03 units drive clear high once; release cycle = 0
first_start      Bench.frames_at -> 8 (lane 0) / 12 (lane 4); the three direct
                 Arrival.create sites use 8, 12 or 8 + 8k (test_m03_i.ml:285)
                 -> earliest start character anywhere in this bench is CYCLE 1
```

**`assert_monitors_clean`'s arms, enumerated from the file at this tree**
(`FINDING WO-0076-S1`'s bar discharged, not recalled):

```
bench.ml:599  let assert_monitors_clean t ~row =
        :604    ": protocol monitor unclean:\n"
        :610    ": conservation monitor unclean:\n"
        :616    ": strobe monitor unclean:\n"
        :632    ": latency tagger errors:\n"          <- arm 4, PRECEDES arm 5
        :638    ": latency tagger unclean:\n"         <- gated on frames_compared > 0
```

**Every sealed message literal read back from its own source line at this tree**
— the seal's §4.0 table, verified after drafting rather than before:

```
test_m03_k.ml:470  M03-K2 delivered-cycle list   no integer, NO OBSERVED DATA
test_m03_k.ml:511  M03-K2 error_pulses empty     no integer
test_m03_k.ml:260  M03-K1 strobe count arm       one mutant-owned integer
test_m03_k.ml:251  M03-K1 strobe cycle arm       prints observed and expected cycles
test_m03_k.ml:232  M03-K1 delivered-word count   reached by no class
test_m03_n.ml:954  M03-N1 strobe emptiness       no integer
test_m03_n.ml:906  M03-N1 delivered-word count   one mutant-owned integer
test_m03_n.ml:1305 M03-N4 delivered-cycle list   PRINTS THE OBSERVED LIST
test_m03_n.ml:1424 M03-N4 exact strobe count     one mutant-owned integer
```

**`FINDING K-1`'s ground, stated as the two measurements that produced it:**

```
test_m03_k.ml:470  is M03-K2's FIRST DUT-observable assertion, and its message is
                   "the delivered-cycle list is not [...] -- the precondition every
                    partition below depends on"  -- the EXPECTED list, nothing observed.
                   IC-K1, IC-K3, IC-K5 and IC-K6 all raise it, character-identical.
test_m03_n.ml:1305 is the SAME assertion shape in the SAME bench and it prints
                   "delivered-sample cycles are [<observed>], expected [<expected>]".
=> a defect in one message, not a limitation of the form.
```

**The breadth figure, with its limit stated** (`FINDING WO-0076-S2`'s discipline
applied to a denominator I had written and not counted):

```
grep -cE '(^|[^_a-zA-Z])fail($| )' test/xgmii_rx_64/test_m03_k.ml -> 95  (3 carry "test bug")
grep -cE '(^|[^_a-zA-Z])fail($| )' test/xgmii_rx_64/test_m03_n.ml -> 94  (33 carry "test bug")
```

Numerator counted exactly: **six distinct raise sites reached across four units of
fifty-nine, seven if `D-N1c` returns branch β**. The denominator is quoted only as
that measured upper bound; the DUT-observable classification is a judgement over
assertion bodies and **not** a grep, and both artefacts say so.

**Nothing in this round is a test result**: no bench ran, no `dune` was invoked, no
transient exists, and every claim in both files is either a citation of committed
text at this tree or a measurement shown above.

### Outcome

**DoD met.** Two files staged, and they are exactly the two the R4 files list
names: the packet and its SEALED companion, in one commit, base = the staging
commit (freeze-first, `WO-0073-VERDICT` §7's corrective drafting rule at its
fourth application). **R-SEAL-1 is satisfied by construction**: the seal is a file
in this commit's own `Files-in-this-commit` list, so no claim in the packet is a
withheld result without an artefact.

**The campaign, in one table:**

| section | classes | scored cells | qualifies |
|---|---|---|---|
| **§K** | IC-K1 … IC-K6 (six) | 3 distinct raise sites | `M03-K2` (five classes, one qualification); `M03-K1` (IC-K4 alone, or nothing) |
| **§N** | IC-N1, IC-N4a, IC-N4b (three) | 3 sites, 4 under branch β | `M03-N1` (IC-N1); `M03-N4` (IC-N4a and IC-N4b) |

**The falsifiable half is ANSWERED, affirmatively, with its derivation and its
counterfactual in the packet** (§2.1): `M03-N1` and `M03-N4` **are** qualifiable
by mutation at this bench, because clause 2 of `M03-N4`'s Observable is a
report-path observable and clause 1 an abort-geometry one, and **neither is the
admission gate** through which all five of the row's historical reds arrived.
**What remains unqualifiable is declared instead**: `M03-N4`'s zero-delivered
branch (no legal stimulus), `M03-N3` (`NO-STIMULUS`), `M03-K3` (`NO-ASSERT`), and
— conditionally and pre-committed — `M03-K1` if `IC-K4` returns `NOT SEEDED`.

**The K × N cross product is enumerated before the run and predicted EMPTY of
reds** — eighteen cells, twelve K-against-N and six N-against-K — on a measured
census intersection rather than an argument. **The price I named when I
recommended one campaign is therefore discharged by measurement**, and pass
criterion 9 obliges the verdict to report all eighteen individually so the ruling
that adopted this shape is scored rather than assumed.

**One MAJOR finding raised before the run, against my own artefacts**:
`FINDING K-1`, in two halves, with two carriers and neither paid here.
**One declaration**: `DECLARATION K-D1`, on a row whose window contains nothing a
conformant design acts on. **Nine more declarations** of what the campaign cannot
score, at §5.

**Not done, deliberately, each with its carrier named**: `FINDING K-1`'s message
repair (the next commit opening `test_m03_k.ml` — repairing it inside the window
would void the round); the AP's own edits including `RV-0075`'s three §7 placements
(the post-campaign `AP-` round, carried by ruling); `FINDING J-1`'s second half;
`RV-0075-1/2/3`'s repairs (the Phase-2/3 stimulus-widening work order I draft
**after** this campaign scores, dated by the commit that carries it).

**No `SO-` is opened or offered**, and the lessons harvest is **not due**: it falls
at the `SO-`, the span stays open, and candidate **(I)** is banked above alongside
the eight already held.

**Handoff**: both files to the orchestrator for commit in one commit, trailer
`Agent: dv_lead`, `Work-Order: WO-0077`.

### Open-questions

1. **`FINDING K-1` is a correction to a committed, pre-committed disposition table
   and the table is not edited.** `WO-0072` §9 still reads as three separable
   dispositions in history, and it should — a dated artefact is a dated artefact.
   **Q3 of the packet asks whether that warrants an escalation of its own.** My
   reading is no: it is a defect in a bench message and in my own table, not in the
   design, and PROTOCOL §10 mints no `R`-rule for it. **But it changes what a
   committed table may be used for, and that is the operator's to surface or file.**
2. **`M03-K1` may end this campaign unqualified**, and §5.6 outcome 3 pre-commits
   what that means: **UNQUALIFIABLE BY MUTATION at its own stimulus**, declared in
   the verdict and carried into the `SO-`. **I raise it now rather than at the
   gate**, because whether an `SO-` may PASS with one landed green `ASSERT` row in
   that state is the same question `J-dv_lead-0143` raised about `M03-N1` and
   `M03-N4` — and this campaign answers that one and may open this one.
3. **Q1 of the packet (K first or N first) is a real choice and I recommended
   rather than ruled it.** Nine transients is 51.6 minutes of wall in one freeze
   window; a container incident inside it costs less if the older debt has already
   scored. I recommend K first for the reasons stated; the operator has the figures.
4. **The nine-diff manifest is the largest this programme has commissioned** and
   the delivery order is load-bearing in a way it has not been before: §8 collision
   1 makes four of six K classes unadjudicable without their branch identity.
   **Pass criterion 10 says so in terms**, and if a scorecard arrives without run
   ids I will not score those four rather than infer them.
5. **Nothing is escalated.** No `BUG-`, no `E`-class item, no spec-queue addition —
   a nil escalation, declared rather than omitted.
6. **Carried, unchanged and not this round's to pay**: the charter §3 differential
   co-sim anchor, undischarged and now blind by **stimulus** per reset class as
   well as per configuration class and per strobe; `FINDING J-1`'s second half;
   `WO-0047` §2's 4-octet anti-vacuity question; `OBSERVATION L-O1`;
   `WO-0073-D3`'s `M03-I4` mislabel; `OBSERVATION K-O1`; AP-M14's §6 invariant; the
   `precompile_check.sh` side-effect lane; the RFC 1071 anchor; X-7, X-10, X-11
   deferred; L1–L5 as a separate packet. **The lessons harvest falls at the `SO-`;
   the span stays open with nine candidates banked.**

### Files-in-this-commit
- agents/handoffs/WO-0077_family-k-mutation-campaign.md
- agents/handoffs/WO-0077_family-k-mutation-campaign-SEALED-predictions.md

## [J-dv_lead-0146] 2026-08-10T18:00Z | task:WO-0077 | The era's last pre-run round: nine of nine seeded including the class I predicted would not be, six questions ruled before a branch exists — and the one that mattered pre-declares my own seal's cell missed rather than let a scorecard find it

### Trigger

Orchestrator dispatch, spawn short-id `WO-0077-PRERUN/2026-08-10T18:00Z`, HEAD
`f9232c2` — verified as my first action per the dispatch's own abort-first bar, and
it matches the spawn HEAD, so no `git merge-base` direction test was needed.

The occasion is the auditor's seeding return for `WO-0077`, the tenth and last
campaign of the class-based era: `docs/reports/audit/WO-0077-mutations/README.md`
(`J-auditor-0018`, opening the auditor's volume 02), landed at `f9232c2` against base
`aced7b4`. Its **§8 raises six pre-run questions** and its **§0 discloses five
exposures**. My own packet's §9.3 item 7 requires both to reach me **before** the run
and to be answered in the same form: *"a question answered after a scorecard exists is
not a question, it is a negotiation."* This entry rules all six, rules the conduct of
all five exposures, and gives or withholds the green light for the nine transients.

### Inputs

Read at `f9232c2`, all read-only. **No `libs/**` path was opened**; every design-side
fact in the note is the auditor's, cited as its claim and never adopted as mine.

- `agents/charters/dv_lead.md`, `agents/PROTOCOL.md` — mandatory first actions.
- `docs/reports/audit/WO-0077-mutations/README.md` — **in full**, all 1474 lines: the
  nine diffs, R-DISC-1's per-class per-lane discharges, R-DISC-2's five-path
  inventory, the nineteen disclosures, §6's pre-ship check, §7's blast-radius rules,
  §8's six questions, §10's operator table.
- `agents/handoffs/WO-0077_family-k-mutation-campaign.md` — in full (my own packet).
- `agents/handoffs/WO-0077_family-k-mutation-campaign-SEALED-predictions.md` —
  **mine**, opened deliberately: RN-2, RN-3 and RN-5 are questions *about the seal*
  and cannot be ruled without reading it. Nothing from it is disclosed in the note
  beyond what §18 already tells freely.
- `agents/handoffs/WO-0076_family-j-mutation-campaign.md` §§1193–1612 — the pre-run
  precedent whose §0.3 rule this note carries.
- `agents/handoffs/WO-0072_m03-family-k-clear.md` §9 (the pre-committed disposition
  table, D1 … D6) and §10.1–§10.2 (its own two closed findings) — the documents RN-4
  turns on and the auditor is barred from.
- `test/xgmii_rx_64/test_m03_n.ml:895–960` and `test/attack_plans/AP-xgmii_rx_64.md`
  row `M03-N1` — **read only; no `test/**` byte moves** (§10's freeze).
- `docs/specs/requirements.md` REQ-113's row; `docs/adr/ADR-0017-a-journal-is-a-chain-not-a-file.md`
  §4.1–§4.4 (read to rule exposure E5 on evidence rather than on the auditor's
  assurance); `ls docs/adr/` for RN-6's filename.
- Git metadata only: `rev-parse`, `diff --name-only`, `log --oneline`, `status`.

### Reasoning

**RN-1 and RN-2 are confirmations and cost nothing.** The derived window `6 … 10` and
release `11` reach the bench's own committed constants exactly, so the manifest's four
cycle-naming discharges stand unedited; frame A is a lane-0 start, so the offset-
dependent leading-edge half of `IC-K5` renders. I confirmed `M03-K2`'s numbers and
deliberately did **not** print `M03-K1`'s: that discharge is symbolic and needs none,
and a note that volunteers figures a seal derives is spending blinding for nothing.

**RN-3 is the round's real question and it goes against me.** The manifest's `IC-N1`
adds one `error_bad_frame` **and** sets `tuser`[0] = 1 on the already-closing frame's
`tlast` word, while leaving that frame's word count, cycles, `tkeep` and octets
bit-identical. My `D-N1c` offered two branches — α (report only) and β (report **and**
the mis-routed character's own no-output-word consequence applied to the closing
frame) — and the seal worked β as a **lost word**. The delivered rendering is neither:
it is a record bit reaching both a report and `tuser`[0] with the coverage arithmetic
untouched, because that arithmetic reads the closure search directly.

Three ways to rule it, and I rejected two.

1. *Neither disclosed branch → the class is `U`, zero kills, `M03-N1` unqualified.*
   Rejected. §5.1's disposition exists to catch a rendering whose mechanism the
   disclosure cannot **recognise**; here the mechanism was disclosed exactly, before
   the run, with a statement of what moves and what does not. Ruling it out would
   punish an answer more precise than the question and would reproduce at `M03-N1`
   the defect I ruled out at `WO-0076` RN-1 — a reading that makes a row's own
   commissioned kill unscoreable is not a strict reading of it.
2. *Move the cell to the assertion that will actually speak.* Rejected, and this is
   the one that matters. The diffs exist; a string I write now is not a seal, and a
   "clarification" that becomes a seal tuned to a mutant does not stop being a failure
   because it would raise the kill count. §0.2's rule is carried verbatim in substance
   from `WO-0066`/`WO-0076` §0.3 and it binds hardest exactly when obeying it costs me
   a cell.
3. **Adopted**: the rendering is **β** (the dividing line is whether the consequence
   reaches the closed frame's delivered stream, and `tuser`[0] is delivered-stream
   state, which §7's permission list grants under β **only**); the per-word `tuser`
   arm **is** an assertion of the row's own Observable clause 1, verified at the bench
   rather than argued (`test_m03_n.ml:936–941`, guarded to the frame's own `tlast`
   word at `:932`, ordered before the octets and before the strobe-set check at
   `:954`, its own text about a clean frame not being aborted) — **and my dichotomy
   was incomplete, which is `FINDING WO-0077-N1`, MINOR, mine.** The sealed cell is
   **pre-declared MISSED**, both branches, and the adjudication is pre-fixed in five
   branches so it cannot be argued backward from whatever prints.

The packet's own §2.1 settled the qualification half before I got there: the class's
Required-consequence sentence names `tuser`[0] = 0 as part of the frame's own
delivery. Having commissioned it as the frame's observable, I do not get to call it
somebody else's now that a rendering has reached it.

**RN-4 resolves a conditional the auditor could not check.** Its observation was that
`WO-0072` §9's **D3** tell is a disjunction satisfied by `IC-K6` (a leaked word) and
by `IC-K2` (an added report) — different defects, one row — and it asked whether one
of the table's six other classes already owns the added-report case. It does not:
D4a–D4d are bench-or-worker classes, D5 is a spec class and D6 is an adjudication rule
for the two rows disagreeing. So the added-report design has **no class of its own**
in a table I pre-committed. The table convicts itself in its own sentence — D3's
disposition separates itself from D1 on *"different root causes"*, which is exactly
the test its own disjunction fails internally — and the operational cost is a
**mis-cited requirement clause in a verbatim-relay `BUG-` packet**, which is why it is
recorded rather than shrugged off. It is **independent of `FINDING K-1` and points the
other way**: K-1 is under-discrimination the instrument cannot repair (the cell prints
nothing it observed); this is under-discrimination the instrument already **exceeds**
(the two members raise at two different assertions with two different strings).
MINOR; `WO-0072` is **not** edited, because rewriting a pre-committed table after the
fact is the failure it exists to prevent; repair of record is D3 → D3a/D3b with the
`AP-` round as carrier, beside `FINDING K-1`'s record. Minted round-scoped as
`FINDING WO-0077-K2` because this round's `FINDING K-1` already collides with
`WO-0072` §10.1's closed finding of that name and a rename would break the frozen seal
and both journals.

**RN-5 is a confirmation with a correction attached.** The seal carries `IC-K4` as a
**scored** class with its own rule, worked instances and a cell whose mutant-owned
integer is sealed as an inequality above one with both `D-K4b` derivations named — so
the auditor's inference from §11 is right, and §5.6's **outcome 1 (SEEDED)** governs.
§13's pre-committed **UNQUALIFIABLE BY MUTATION** declaration **does not fire** and the
`SO-` does not inherit it. What I refused to let the confirmation buy: the seal's
**outcome 2** stays live in full (a rendering that shifted rather than carried is
reported and not scored, `M03-K1` unqualified), §5's declarations are untouched, and
the mechanism is the auditor's design-side claim measured by the run and not by this
ruling. The era floor stated at §14 (*"10 void if nothing seeds"*) is **retired**: nine
of nine seeded, so the void column gains nothing by declaration, the era closes at 63
sealed with a ceiling of 61 killed, and the single survivor and single existing void
stand.

**RN-6 is my own defect at its second round.** I ruled the broken `ADR-0014` path at
`WO-0076` §4 with the note as carrier — and then copied the broken path into the very
next packet I drafted. The instance was repaired; the **drafting** was not bound.
A second occurrence converts *"clerical"* into an obligation to mechanise, so the
durable carrier is **not** a third note: it is a resolve-check in `tools/dv_checks.sh`
over the `docs/**` paths cited in `agents/handoffs/**`, owed to the first commit
opening `tools/` **after** the campaign scores. It may **not** be paid inside the
window, and I ruled that as an **extension** of §10's freeze rather than pretending
the letter reaches it: this packet's denominator, both censuses and the seal's §0 are
measured by that script, so moving it inside the window would put the round's own
denominator on a different tree from the seal that quotes it. No new harvest candidate
— candidate (C) at `J-dv_lead-0141` gains its second incident and a strengthened
observable (*verified by the check that runs, not by the reader who honours it*).

**The five exposures: no finding on any.** E1, E2 and E4 are metadata; E3 verified
**my** freeze claim from history rather than accepting it, and I would commission it if
it were not taken — an unverified freeze is what voids a round, and the exposure is a
property of my instrument, not of the auditor's discipline. **E5** is the one that
needed grounds rather than goodwill: the auditor read `ADR-0017` §4.1–§4.4 outside its
allowlist because its spawn made the journal rotation mandatory and specified the
header fields *"per ADR-0017 §4.3"* while the allowlist omitted the ADR. Two
instruments collided and the **protocol** wins — a malformed volume header is a defect
in the permanent record that the chain's back-link and the commit scripts key on,
while the blinding it traded against protects a mutation campaign. I discharged the
content half **by reading those sections myself** rather than accepting the claim:
layout, entry-ID continuation, the five header fields, the rotation procedure — no
`test/**` fact, no cell, no message string, no MUST-STAY-GREEN member. Minimal, and
disclosed at the point of use in the same document that states the blinding, which is
the conduct a blinding statement exists to produce. The **instrument** defect is not
the auditor's and I did not rule it: a blinded spawn whose allowlist omits a path its
own mandatory actions compel has issued an instrument that cannot be honoured as
written, and that is the orchestrator's drafting to fix — `RN-6`'s family one document
over.

**Green light, not hold.** The one ruling that would have moved a sealed cell was held
at the cell and scored against me instead, which is the lawful pre-run disposition and
is what §0.2 is for; nothing in the manifest justifies withholding nine transients
whose only remaining risk is operational. The fresh-cut bar is the sharpest of the
seven and it is `WO-0076` §3's hazard at its second instance: branches `k4` and `n4b`
both replace line 990 and `n4b`'s anchor **contains** `k4`'s, so a sequential cut from
an unclean tree carries two classes and makes both unscoreable.

### Actions

- Verified HEAD and the ordering facts read-only: `f9232c2` (manifest), `HEAD^` =
  `aced7b4` (packet + seal), the manifest commit touching only the audit report and
  the auditor's journal, and **no `test/**`, `libs/**` or `tools/**` byte moved since
  `22ffe13`**. Clean tree throughout. No ref, index or HEAD movement; no `dune`.
- Read the manifest in full, my packet in full and my own sealed companion; read the
  two barred documents RN-4 turns on; read the `M03-N1` assertion block and the AP row
  at the source; read `ADR-0017` §4.1–§4.4 to rule E5 on evidence.
- Appended to `agents/handoffs/WO-0077_family-k-mutation-campaign.md`: the auditor's
  manifest-return row in the Return log, and the **`WO-0077` PRE-RUN READING NOTE** —
  six rulings, one conduct ruling over five exposures, two findings against my own
  artefacts, a one-table summary, and the **GREEN LIGHT** under seven operating bars.
- **Minted**: `FINDING WO-0077-N1` (MINOR, mine — an incomplete disclosure dichotomy)
  and `FINDING WO-0077-K2` (MINOR, mine — a second under-discrimination in
  `WO-0072` §9's D3 row). Both carried to the post-campaign `AP-` round.
- **Not done, deliberately**: the sealed companion is not staged and not one byte of it
  is edited; §9's allowlist body is not rewritten; `WO-0072` §9's table is not edited;
  no replacement message string is written for the missed cell; no `test/**` or
  `tools/**` byte moves.

### Evidence

Commands run at `f9232c2`, all read-only, reproducible at this SHA:

```
$ git rev-parse HEAD                                    -> f9232c2  (== spawn HEAD)
$ git rev-parse HEAD^                                   -> aced7b4  (packet + seal; §10's base)
$ git diff --name-only aced7b4 f9232c2
      agents/journals/claude_auditor_agent.v02.md
      docs/reports/audit/WO-0077-mutations/README.md
$ git diff --name-only 22ffe13 f9232c2 -- test/ libs/ tools/   -> (empty)
$ git status --porcelain | wc -l                        -> 0
```

Facts checked at the source rather than recalled:

- **RN-1**: the seal's own clear census and `M03-K2` order give window `6 … 10`,
  release `11`, and the release-cycle identity `start_cycle_b = clear_last + 1` — the
  manifest's three-figure derivation agrees in every figure.
- **RN-2**: `M03-K2`'s frame A is lane **0** (frame B lane **4**, admitted on the
  release cycle); the seal's `IC-K5` REQUIRED cell is one message either way and its
  leading-edge prediction is sealed **UNREAD**.
- **RN-3**: `test/xgmii_rx_64/test_m03_n.ml` @ `aced7b4` — the `M03-N1` per-word block
  runs cycle → `tlast` position → (`is_last` at `:932`) final `tkeep` `:934–935` →
  **`tuser` `:936–941`**, then the delivered octets, then the strobe-set emptiness
  check at **`:954`**; the delivered-word count is at `:902–910`. The `tuser` arm reads
  a DUT output, fires only on the frame's own `tlast` word, and prints no observed
  data. `AP-xgmii_rx_64.md` row `M03-N1` Observable clause 1 reads *"The `/T/` closes
  the frame normally (REQ-106, FCS checked)"*.
- **RN-4**: `WO-0072` §9 carries **D1, D2, D3, D4a, D4b, D4c, D4d, D5, D6**; D4a–D4d
  are bench-or-worker classes, D5 is SPEC, D6 is an adjudication rule. **No class owns
  the added-report case.** D3's disposition text separates itself from D1 on *"the two
  have different root causes"*.
- **RN-5**: the seal works `IC-K4` as a scored class with three pre-fixed outcomes;
  outcome 1 is SEEDED and governs.
- **RN-6**: `ls docs/adr/` → the file is
  `ADR-0014-an-enable-gates-admission-not-the-wire.md`; `docs/adr/ADR-0014.md` does not
  exist.
- **E5**: `ADR-0017-a-journal-is-a-chain-not-a-file.md` §4.1–§4.4 read in full —
  volume layout, entry-ID continuation, the five header fields, the rotation
  procedure. No campaign-bearing fact of any kind.

**No test suite was run and none is claimed**: this round stages a packet and moves no
executable byte. **CI is the authority** for everything the campaign measures
(ADR-0005), and the campaign's evidence is the nine `build` runs the operator now
cuts, reported per §17 item 6.

### Outcome

**DoD met** against the spawn's commission. Six rulings appended to the packet's
pre-run section with their grounds; the conduct of all five disclosed exposures ruled
(no finding on any, E3 commended, E5 ruled correct on four grounds); **GREEN LIGHT**
given for the nine transients under seven operating bars, of which the fresh-cut
shared-anchor bar (`k4` and `n4b` at line 990, one anchor containing the other) is the
one that fires silently if it is missed. **No sealed cell moved**; the one ruling that
would have moved one is held at the cell and **pre-declared a MISS against me**, with
adjudication pre-fixed in five branches. **Files list is the packet alone**, as the
commission required.

**Handoff**: the orchestrator cuts `mut/wo-0077-k1 … k6, n1, n4a, n4b` from `aced7b4`
in §12's fixed order and returns §17's eight items; adjudication against the sealed
companion is mine, and the seal is opened only when every scorecard is in hand.

**Harvest**: **not due this round** — it falls at the `SO-`, the span since
`J-dv_lead-0137` stays open, and no candidate is minted here. Candidate (C) at
`J-dv_lead-0141` gains a second incident and a strengthened observable; the banked set
is **extended, not enlarged**.

### Open-questions

1. **The spawn-allowlist defect is the orchestrator's to fix, not mine to rule.** A
   blinded spawn whose allowlist omits a path its own mandatory actions compel forces
   the agent to choose which instrument to break. The auditor chose correctly and
   disclosed; the next one may not. Raised, not decided.
2. **`FINDING WO-0077-K2` is a second reason Q3 may deserve surfacing.** Two
   independent under-discriminations in one pre-committed disposition table, both
   found before the run that would have used it. My reading is still that neither is a
   `BUG-`-class escalation — both are my artefacts, not the design's — but the
   operator now has two, not one.
3. **`M03-N1`'s qualification will rest on a cell I did not seal.** §3.4 pre-fixes the
   five branches, and I will hold to that table whichever way it goes; but the honest
   statement for the verdict is that the row's first qualification, if it comes,
   arrives at an assertion my seal predicted wrongly.
4. **The nine-branch cut is 51.6 minutes of CI wall in one freeze window** and the
   shared-anchor hazard makes a sequential cut silently wrong. If a container incident
   interrupts it, the surviving branches are still valid — each is cut fresh from
   `aced7b4` — but the round re-seals if any `test/**` or `tools/dv_checks.sh` byte
   moves in the meantime.
5. **Nothing is escalated.** No `BUG-`, no `E`-class item, no spec-queue addition — a
   nil escalation, declared rather than omitted.

### Files-in-this-commit
- agents/handoffs/WO-0077_family-k-mutation-campaign.md
