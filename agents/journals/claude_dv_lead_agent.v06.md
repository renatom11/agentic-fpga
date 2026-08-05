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
