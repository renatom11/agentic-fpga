# Journal: claude_auditor_agent — volume 03

- **Agent**: auditor (Opus 5, independent)
- **Charter**: agents/charters/auditor.md
- **Format**: v1 — entry grammar in agents/PROTOCOL.md §4
- **Volume**: 03
- **Continues-from**: J-auditor-0023
- **Previous-volume**: agents/journals/claude_auditor_agent.v02.md
- **Previous-volume-sha256**: 7fbe7bb2087449bc930fbb580af55be7934327b84356e4e5623bf6c05e5931bb
- **Previous-volume-bytes**: 258341

This file is APPEND-ONLY. Content may only ever be added after the last line;
nothing above it is ever edited. Volume 03 of a chain (ADR-0017 §4.3).
Enforced by scripts/agent_commit.sh and CI.
Volume 02 is FROZEN: it is never appended to again, and any change to it breaks
this file's Previous-volume-sha256.

---

## [J-auditor-0024] 2026-08-11T22:01Z | task:none | Subject 1 countersigned on four checks and narrowed on one; and the debt I accepted against myself, paid by re-derivation, returns the opposite of what I promised to write — the equivalence proof is refuted and D-M3 is a survivor

### Trigger
Orchestrator dispatch, one round, three acts: the `ADR-0021` **subject 1**
countersignature (`R-0020-1` is my recommendation, the ±60 band my measurement, so
§9's route names this seat); and the **relanding**, fresh and from the record, of
the two `docs/reports/audit/**` artifacts a prior stopped round did not commit —
the `D-M3` note and the `ADR-0020` countersignature record. The dispatch states in
terms that a prior uncommitted `v03` from that stopped round exists only in the
orchestrator's scratchpad as evidence, was never in my chain, and is not to be
referenced or reused. **I did not read it and this rotation is fresh**; every
field of the volume header below was taken from `git show HEAD:…v02.md` and
`git cat-file -s` at this round's HEAD, not from any prior draft.

**Abort-first precheck, before any file was opened.** `git status --short` and
`git rev-parse HEAD` at `2026-08-11T21:44:12Z`: HEAD **`287b5ee`** exactly as the
dispatch predicted, branch `claude/fpga-hardcaml-agent-orchestration-37ceyf`, and
the only dirty paths `test/xgmii_tx_64/{bench.ml,bench.mli,dune,test_m04_a.ml,
test_m04_b.ml,test_m04_g.ml}` plus untracked `test_m04_f.ml` — tb_writer, declared.
Nothing undeclared. Proceeded.

**HEAD moved three times mid-round and every movement was a declared sibling**, so
I re-verified rather than aborting, which is what the dispatch asked for.
`65ba148` (`Agent: tb_writer`, `J-tb_writer-0045`, `WO-0082`) landed at 21:52:31Z,
taking the dirty `test/xgmii_tx_64/**` set with it; `efe84b3` (`Agent: rtl_lead`,
`J-rtl_lead-0025`, journal-only) landed at ~22:00Z — subject 3's countersignature,
the sibling the dispatch named as "rtl_lead (v03 journal only)"; `fb58ba3`
(`Agent: dv_lead`, `J-dv_lead-0189`, journal-only) landed last, the sibling named
as "dv_lead (v11 journal only)". The working tree at each re-check carried only
`docs/PROCESS.md` (the architect, declared) and my own files. **Every read surface
this entry depends on was re-verified**: `docs/adr/ADR-0021-…md` and
`agents/journals/claude_auditor_agent.v02.md` are byte-identical to their
`287b5ee` versions (`git diff --stat`, empty), and my `v02` blob is 258,341 bytes
at sha256 `7fbe7bb2…` throughout.

**One disclosure about the last of those, because it bears on independence.**
`fb58ba3`'s commit **subject line** — which reached me through `git log -1` while
re-checking HEAD, after my §1 analysis and census were complete at `65ba148` —
names *"the live stamp violation adjudicated against the signer's own packet"*.
So dv_lead appears to have reached the live slow-bound firing independently. **I
have not read `J-dv_lead-0189` and have not amended a word of §1 after seeing that
subject line**; I record it because a convergence I noticed after the fact is
corroboration, and a convergence I had read first would have been contamination.

**Rotation.** `v02` stands at **258,341** bytes against `JOURNAL_SOFT_MAX` = 262,144
(`scripts/policy.sh`:13) — **3,803 bytes of headroom**, less than a tenth of a
recent entry of mine — and `J-auditor-0023` recorded that the next entry needs
`v03`. This is that rotation, under ADR-0017 §4.3/§4.4: `v02` is not staged, not
touched, and is frozen from here.

**Honest stamp**: `date -u` read at authoring — `Tue Aug 11 22:01:28 UTC 2026` —
and the header above carries it to the minute. No spawn short-id: this seat is a
lead-class spawn, not a worker (PROTOCOL §4.1).

### Inputs
`agents/charters/auditor.md` (whole); `agents/PROTOCOL.md` (whole).

For act 1: `docs/adr/ADR-0021-a-check-is-only-where-it-runs.md` (all 1,018 lines,
at `287b5ee` and re-verified unchanged at `efe84b3`);
`docs/adr/ADR-0017-a-journal-is-a-chain-not-a-file.md` (whole — §1.2, §5.1, §5.3,
§6.2, §6.6 and §8.2 are the sections subject 1 and subject 2 rest on);
`scripts/policy.sh`:13–14; `scripts/agent_commit.sh`:177–182;
`scripts/check_journals.sh`:1–40, :44–101, :195–256; my own `J-auditor-0020` §7
(the recommendation, the four candidate bands, constraints (i)–(iii)) and §8.

For act 2: `docs/reports/audit/WO-0041-mutations/README.md` (whole, 712 lines
before this round's addition — §3.3, §5.2, §5.4, §6 read closely);
`agents/handoffs/WO-0041_family-d-mutation-campaign.md` §3 of `RV-0041-VERDICT`
(:369–448, dv_lead's equivalence proof) and its ADDENDUM ruling 1;
`libs/hardcaml_ethernet/src/xgmii_rx_64.ml` **at `447d11c`** (the campaign base,
extracted with `git show` to scratchpad; the working tree copy was never touched)
— :154 (`fcs_residue`), :395–435 (`begins`), :455–545 (the CRC registers and the
closure record); `docs/specs/modules/xgmii_rx_64.md` §6.1 (:261–420, especially
:330's per-octet constant and :398's `m + 3`); `docs/specs/requirements.md` §0.3
(:63–115); `test/xgmii/arrival.ml`:17–61 and `test/xgmii/frame.ml`:23–38;
`test/xgmii_rx_64/bench.mli` and `bench.ml`:289–296 at `447d11c`;
`test/xgmii_rx_64/test_m03_d.ml`:225–300 at `447d11c`;
`agents/handoffs/SO-xgmii_rx_64.md` `SC-5` at :280, :511 and the campaign row :803;
`docs/gates/P1-module-ready-checklist.md`:175–185, :208–214, :498–530.

For act 3: my own `J-auditor-0021` (whole) and `J-auditor-0022` (whole), from
`git show HEAD:agents/journals/claude_auditor_agent.v02.md` so the transcription
is taken from committed bytes rather than from memory; `ADR-0020` §6.3, §9.2, §9.4,
§9.5, §10 items 2 and 4 as cited in those entries.

**Not read, deliberately**: the orchestrator's scratchpad copy of the stopped
round's uncommitted `v03` and note text (the dispatch bars it and a fresh
derivation is the point); `docs/PROCESS.md` in its dirty state (a sibling's live
working-tree write is not a read surface).

### Reasoning

#### 1. Act 1 — the four checks the dispatch named, taken one at a time

`ADR-0021` §9's table makes this seat's countersignature required on subject 1
alone, on the stated ground that `R-0020-1` is my recommendation, the band my
measurement, and constraints (i)–(iii) my wording. The test I applied is the one I
have applied to every instrument that adopts my specification: **where it says it
adopts, is the adoption faithful; where it adapts, does the adaptation stand on
its own ground rather than on my authority?**

**Check 1 — the band carried as two parameters rather than one.** The architect
did not re-decide my ±60. It exposed the asymmetry my census showed — 369 fast
against 2 slow — as `JOURNAL_STAMP_FAST_MAX` and `JOURNAL_STAMP_SLOW_MAX`, both
defaulting to 3600, with F5 recording the false-positive cost as living entirely
on the slow side. **I judge that the right call, and on a ground the ADR does not
state.** The two bounds do not measure the same quantity. The fast bound measures
a stamp that *cannot be honest*: authoring precedes committing, so a header stamp
later than its own commit is a stamp that was not read when the entry was written.
The slow bound measures **round length**, which is a property of the work rather
than of the testimony. One number serving two physical quantities is a
coincidence, not a parameter, and a later correction to either would have dragged
the other with it. Separating them is what makes §6's "changing one is a policy
edit" true rather than merely available.

**And the review trigger the ADR names is already live at the moment of
countersignature.** §2.5 F5 says: *"if the slow bound ever fires on an entry whose
round genuinely ran long, that is a false positive and the bound moves — the
practice does not."* Re-measured at `65ba148`: **603 entries, 372 out of band,
369 fast, 3 slow, 0 unparseable.** The fast count is **unchanged** from the ADR's
369 at `b19ff91` — every entry added since the ADR was drafted is in band on the
fast side, which is the strongest single datum in favour of the whole design —
while the slow count moved 2 → 3. The new firing is `J-tb_writer-0045` at
**−382.5 min**, landed at `65ba148` **ten minutes after the ADR landed**.

**And the slow population is not the population F5 predicted — I checked each of
the three rather than assuming.** F5's slow-side false positive is *"an entry
authored honestly more than 60 minutes before its commit"*, i.e. **a long round**.
The record's three slow firings are not that, and none of them is:

| entry | stamp | commit | drift | what it is |
|---|---|---|---|---|
| `J-tb_writer-0024` | `2026-08-04T21:30Z` | `88413b9` 23:54:08Z | −144.1 m | unqualified; a long round or a stale stamp — the check cannot tell, and neither can I |
| `J-orchestrator-0229` | `2026-08-06T20:45Z` | `d3bd455` 2026-08-10T20:41:13Z | −5756.2 m | **four days**. Not a long round in any sense the design contemplates — drift on the slow side, which F5 does not model at all |
| `J-tb_writer-0045` | `2026-08-11T15:30Z (estimated, see Open-questions)` | `65ba148` 21:52:31Z | −382.5 m | **self-declared estimate** — the exact form §2.2 goes out of its way to admit as *"more honest than the grammar, not less"* |

**One of the three carries the qualifier, not two** — I miscounted on a first pass
and corrected it against the journals, which is why the stamps are quoted here.
The point survives the correction and is sharper for it: the slow bound's live
population contains **zero** instances of the case F5 names, one instance of a
class F5 does not model (four-day slow drift), and one instance of the class §2.2
praises. The two design decisions — parse the qualifier correctly, then measure the
qualified stamp as drift — are individually right and jointly produce a warning
against the most honestly-stamped entry in the record. **This is the one place I
narrow.**
I sign the slow bound **as a parameter**, and I record that **its default is
anchored to nothing measured**: §6's table gives `JOURNAL_STAMP_SLOW_MAX` the
anchor *"the decided ±60 symmetric"*, while the 0-of-16 false-positive rate and the
369-of-371 population that anchor the fast bound are fast-side facts that do not
transfer. Two parameters, one anchor — `FINDING F-0024-1`.

**Check 2 — warning, never refusal, on both surfaces (constraint (i)).** Verified
sentence by sentence rather than accepted: §2.5 F2 (*exit code untouched*), F3
(unparseable, *exit code untouched*), F4 (degradation, *exit 0*); §7.1's *"its
refusal set is unchanged"* for both scripts; §2.7 S41 asserting **exit status 0**
together with a warning line, and S40 asserting the **absence** of output;
§10 foreclosing a later refusal without its own ADR (*"a later round wanting it
would be reversing constraint (i) and needs its own ADR"*). **Constraint (i) is
honoured on both surfaces.** I also checked the one place a counter could
accidentally acquire a verdict's force: §2.4's *"on a red run the summary does not
print"*. Against the script at `efe84b3` this is right and its order is right —
`check_journals.sh` runs under `set -euo pipefail` (:11) and exits at the first
violating commit through `fail` (sourced from `policy.sh`), with the `OK:` line at
:256 as the last statement, so the block cannot turn a green run red and cannot
survive a red one. A verdict outranks a counter.

**Check 3 — constraint (iii), no new class of thing, against the `compliant-run`
counter.** My words at `-0020` §7 were: *"`agent_commit.sh` emits `WARN-JOURNAL`
… a `WARN-STAMP` needs no new class of thing, only a new instance of one."*
Verified at `efe84b3`: `grep -c 'WARN-JOURNAL' scripts/agent_commit.sh` = **1** —
the class exists with exactly one instance, so the premise holds today and not
merely at `b19ff91`.

The `compliant-run` column is the one part of subject 1 that **could** have been
a new class, because "consecutive compliant entries" is the shape of a stateful
metric: a baseline file, a stored history, a decay curve, a thing that has to be
maintained. **It is none of those.** §2.4 states the property that saves it —
*"zero-state — no baseline file, no stored history, nothing to decay"* — and it is
true by construction: the column is a fold over the same census the warning
already computes, printed as a column of a line the design already emits. No new
file, no new artifact, no new exit code, no new `R`-number, no new packet class.
**Constraint (iii) is honoured**, and I sign it with that ground stated so a later
"simplification" that introduces a baseline file to compute the same column can be
convicted against this sentence rather than argued about.

Computed at `65ba148` it is already doing work and already telling the truth about
the roster: rtl_lead **16**, orchestrator **15**, dv_lead **10**,
architect_docs_lead **9**, auditor **5**, data_wrangler **0**, tb_writer **0**.
The ADR predicted *"six chains read 4–16 and one reads 0"*; at HEAD there are
**two** zeros, and the second did not exist when the ADR was written.

**But `tb_writer`'s zero is not a decay**, and the decay claim is mine, so the
narrowing is mine to make: the counter resets on drift **in either direction**,
and on the slow side a chain reads 0 for exactly the reason §2.2 says such an
entry is more honest than the grammar. **I sign the counter under the reading
that a zero is a prompt to read the entry, never a verdict about the chain** —
§2.6's own bound (*a warning is not a verdict and its absence is not a
clearance*), applied to the column rather than to the check.

**Check 4 — reporting granularity against my noise-bounding intent.** My intent
was never *print less*. It was that a full-history checker must stay readable for
the life of the program, because a channel a reader learns to skim is a channel
that has stopped being a check — which is the same failure `-0251`'s decay was.
The ADR's rule — *"report at the granularity of the seat that can act"* — is a
**better statement of my intent than the one I gave**, because it derives the
granularity from the *remedy* rather than from a line budget, and it explains both
halves with one sentence: a chain's stamp drift is actionable at its owner's next
entry, so the stamp summary is per chain; a frozen volume's size is actionable by
nobody, so it is one aggregate.

Checked as properties rather than as intentions: the stamp block is `3 + |chains|`
= **10 lines today** against **372** violations, and the size block is
`2 + |active volumes over a threshold|` = **3 lines today**. Both bounded by the
roster, neither by history. I verified the case that forces the frozen/active
split — `claude_dv_lead_agent.md` at **1,123,442** bytes, 2.1× `H`, frozen and
unfixable by any act available to anyone — and the ADR is right that itemising it
would emit an alarm with no act attached to it on every push until the program
ends. The `--range` half (per entry, capped at `JOURNAL_STAMP_LIST_MAX` = 20, then
aggregating) is the half that carries the tip signal, and putting the two views in
the two workflow steps that already exist is the design not fighting the
infrastructure. **Adopted, unnarrowed.**

**One finding here, against the ADR's own testable prediction.** §2.4 declares the
summary block *"a testable prediction in ADR-0017 §5.2's sense: an implementation
that produces different totals or a different line count does not match this ADR,
and that is the first thing to check."* Re-measured at `65ba148` it already does
not match: 372/603 rather than 371/600, `tb_writer` at 19 out with latest
`J-tb_writer-0045` (−382.5 m) and `compliant-run` **0**, `architect_docs_lead`
36/49, `auditor` 4/23. The file's **Measurement pin** ties every number to
`b19ff91`, so the prediction is not false — but an implementer will run it at the
implementing SHA, get different numbers, and be told by §2.4 that a mismatch means
the implementation is wrong. **The comparison SHA has to be restated at
implementation**, which is one line in the implementing entry, not a redraft —
`FINDING F-0024-2`.

**What I did not check, and why.** I did not audit subjects 2, 3 or 4: §9's table
requires no auditor countersignature on any of them, and signing where no
signature is owed manufactures authority. I did check the one place subject 2
touches my constraint (iii) — it honours it, as §9 says, and I am not its
adjudicator. I did not re-derive `FINDING ADR21-1`'s grep beyond confirming its
live half: `grep -cE 'JOURNAL_SOFT_MAX|JOURNAL_HARD_MAX|WARN-STAMP|WARN-JOURNAL'
scripts/check_journals.sh` returns **0** at `efe84b3`, so §1.2's gap is real at
this HEAD and not only at the pin.

#### 2. Act 2 — I re-derived the `D-M3` margin, and it does not reproduce

`J-auditor-0021` §9 committed this seat to a disclosure as well as to a record:
*either I re-derive the margin over the stated stimulus space myself, or I record
the proof as cited and not re-derived and say which*, on my own `-0020` §10 rule
that *an inherited universal is a premise I own at the moment I rely on it*.
Recording another seat's proof in my artefact is relying on it. **So I re-derived
it, and the result is not the one the dispatch, my own `F-0021-4`, or I expected.**

**The reduction.** The original latches `has_fcs &: (crc_final <>: residue)` at
the **closure** cycle (`447d11c:…xgmii_rx_64.ml`:471); `D-M3` reads `crc_reg` at
the **consumption** cycle. Equivalence is exactly
`crc_reg(consumption) = crc_final(closure)`, and :478's recurrence makes the
`Preamble` seed visible one cycle **after** `begins` — dv_lead's own load-bearing
observation, which I confirm and which is the part of the proof that is right.
Divergence therefore needs `S + 1 ≤ tlast`, i.e. margin `S − tlast ≤ −1`.

**The limb that is certain, and needs no execution.** `requirements.md` §0.3:81
fixes the gap as *from the terminate character inclusive to the next start
character exclusive*; :101 fixes the DIC floor at 9. So
`G = 8(S − W) + s − t`, hence `G ≡ s − t (mod 8)`, hence **a 9-octet gap exists
only at terminate lane 7 with a lane-0 successor or terminate lane 3 with a
lane-4 successor.** The proof's stated tightest case — *"terminate lane 0, a
lane-0 start, and a 9-octet gap"* — **is not a member of the space it quantifies
over**: at terminate lane 0 a 9-octet gap puts the start character at lane 1,
which REQ-101 does not admit, and the shortest legal gap there is 12.

**The limb that is derived.** With `tlast` from §6.1:330's per-octet constant and
the frame's last octet at lane `t−1` of `W` (or lane 7 of `W−1` when `t = 0`), the
margin is **−1 on three cells**: a **lane-0-started** frame with terminate lane
**1, 2 or 3** followed by a **lane-4-started** frame at a DIC-shortened gap of
**11, 10 or 9** octets. Since terminate lane is `L mod 8` at a lane-0 start, those
are frames of length **≡ 1, 2, 3 (mod 8)** — on the alternating lane-0/lane-4
DIC-capable link partner **`REQ-004` names as the worst case the receive path must
survive**. The seed is then visible exactly at the consumption cycle, `crc_reg`
reads 0, `fcs_residue = 0x2144_df1c ≠ 0`, and a **good** frame is reported bad.

**The witness, laid out by the bench's own model rather than by me.**
`test/xgmii/arrival.ml`:30–61 implements §0.3's rounding and DIC credit exactly.
Three 65-octet frames from a lane-0 first start bank 3 octets of credit on frame 0
and spend all three on frame 1's gap: frame 1 starts at octet 96 (lane 0),
terminates at octet 169 (word 21, lane 1), `tlast` at cycle 23 by :398's `m + 3`,
and frame 2's start character is in word 22. `begins(22)` → `crc_reg(23) = 0` →
one spurious `error_bad_fcs` on frame index 1 at cycle 23. **I have not run it and
I cannot**: PROTOCOL §10 gives transient application to the orchestrator and
ADR-0019 keeps the seeder out of the repository. The prediction is stated so that
one run settles it, and **`F-0024-A` is withdrawn in full if that run is green**.

**Why the suite passed anyway, which is the corroboration.** `RV-0041-VERDICT` §3
weighed two hypotheses — *a bench coverage gap, or an equivalent mutant* — and
took the second. It is the first, and the gap is an empty intersection I could
measure at `447d11c` without reading anything I was barred from: `bench.ml`:289–296
drives every directed length through `one_frame`, i.e. **as a lone frame**, and
every multi-frame schedule in the M03 units is **64-octet** (`test_m03_d.ml`:239's
pairs; `Frame.stress_frame` = 6+6+2+4+42+4 = 64; `SC-4`'s 10,000-frame stress).
`64 mod 8 = 0`, so every multi-frame stimulus sits in the safe rows. **The tests
that vary length have no successor and the tests that have a successor never vary
length off a multiple of eight.** That the mutant survived is then predicted by my
derivation rather than merely consistent with it, which is the difference between
a hypothesis and a measurement.

**Why I did not soften it, and what that costs me.** `J-auditor-0021`
Open-question 4 set the bar for this exact round: *"a later spawn should check
whether the note, when it lands, records the falsified claim as plainly as this
entry promises, or softens it."* The hazard I named was under-recording a defect
in my own artefact. **The hazard that actually arrived is its mirror**: the
dispatch, my own accepted finding `F-0021-4`, and my own countersignature reading
all point at writing *"the proof refutes my claim"*, and writing that sentence
would have been the softening — of a defect in someone else's artefact, by a seat
whose entire product is that it is graded by no one it audits. The note records
what the derivation returned. It also records, at §7.3(g), the **one error in
§3.3 that is real** (the lane-4 drain window is off by one; no frame's `tlast`
falls on `W`), because a finding filed against a proof owes at least the standard
it holds that proof to.

#### 3. Act 3 — the countersignature record, and what it may not be read as

`docs/reports/audit/ADR-0020-auditor-countersignatures.md` is a **transcription of
acts already committed**, not a new act. Both signing entries were committed
`Journal-Only: true` with `- (none)` as their files list, so the two
countersignature blocks and the delta existed nowhere in `docs/` — the residue
`J-auditor-0021` Open-question 1 named on the day it was created and
`J-auditor-0022` Open-question 4 called *"indistinguishable, at the gate, from one
that was forgotten"*. The file carries the three blocks verbatim from
`git show HEAD:…v02.md` (committed bytes, not memory), the five stated readings
gathered in one table, both findings tables with their routes and current state,
`F-0022-3`'s drift discovery in full, and a falsification section whose commands
check the transcription against its own source.

**Three things I was careful to keep it from becoming.** It is not a re-signature:
nothing in it re-decides, widens, softens or withdraws what was signed. It is not
a gate signature: PROTOCOL §7 makes a signature a `J-<agent>-NNNN` reference the
orchestrator transcribes, and the file supplies none. And it is not `G-1`'s
closure — which is why §5 of that file says so in one sentence. `G-1`'s closing
event at `docs/gates/P1-module-ready-checklist.md`:525 is *"an auditor verdict on
`G-c4` and `IC-M5` committed under `docs/reports/audit/`, **or** an ADR settling
the clause"*, the route the record took is the ADR, and :517 records the unpaid
half as *"`G-1`'s reading is not supplied"* against **this seat's artefact form**.
**That half, and only that half, is what this file closes.** `G-9` is untouched.

#### 4. The sampling frame, stated so it can be reconstructed

**In the window**: one PROPOSED ADR (1,018 lines) with one of its four subjects
routed to this seat; two prior entries of mine to be transcribed (1,498 lines
together); one frozen mutation manifest of mine (712 lines) carrying an accepted
debt; and the campaign artefacts the debt points at.

**Sampled whole**: `ADR-0021` §§0–10 (every section, not only §2 — §3.5, §4.7 and
§5.4 were read because a countersignature that has not read the neighbours cannot
tell an adaptation from a drift); `J-auditor-0021` and `-0022` entire;
`WO-0041-mutations/README.md` entire; `RV-0041-VERDICT` §3 entire.

**Measured at the sources rather than taken from the ADR**: the stamp census
(603 entries, re-run in full at `65ba148`, not sampled), the fast/slow split, the
per-chain table, the `compliant-run` column for all seven chains, the
minute/second precision split (381/222, which reconciles exactly with the ADR's
377/222 + the parenthetical + three new entries), author-vs-committer time
(603/0), and the four script greps.

**Re-derived rather than cited**: the `D-M3` margin, over the terminate lane
(0–7) × start lane (0, 4) × successor start lane (0, 4) space, with the gap
constraint taken from §0.3 and `tlast` from §6.1:330 — and then checked against the
bench's own `Arrival` layout arithmetic rather than left as algebra.

**Deliberately not sampled, and why.** Subjects 2, 3 and 4 of `ADR-0021` beyond
their intersections with my constraints — no signature is owed and manufacturing
one is worse than declining. `docs/PROCESS.md` — a sibling's live working-tree
write is not a read surface. The other nine campaign manifests — this round's
frame is one clause's one instance, and re-walking ten campaigns to look for more
equivalence rulings is a different round that should be commissioned rather than
smuggled in (there are none: `D-M3` is the record's only equivalence exclusion,
which is `ADR-0020` §6.3's own closed set of one). The `libs/**` content
classification of `F-0022-1`'s five stale renderings — still owed, still cheap for
a seat with a different read scope, still not taken here for the reason
`J-auditor-0022` Open-question 3 gives.

### Actions
- Ran the abort-first precheck; re-ran it twice after HEAD moved (`287b5ee` →
  `65ba148` → `efe84b3`), each time re-verifying that every read surface this
  entry depends on was byte-identical.
- Opened **volume 03** per ADR-0017 §4.3, header fields taken from
  `git show HEAD:agents/journals/claude_auditor_agent.v02.md` and
  `git cat-file -s`; `v02` untouched and unstaged.
- Re-ran the full stamp census over 603 commits at `65ba148`, plus the per-chain
  aggregate, the fast/slow split, the `compliant-run` fold and the precision split.
- Read `ADR-0021` whole and verified the four dispatch-named checks against the
  scripts at `efe84b3` rather than against the ADR's account of them.
- Re-derived the `D-M3` equivalence margin from `requirements.md` §0.3,
  `SPEC-M03` §6.1 and the base RTL at `447d11c`; cross-checked the result against
  `test/xgmii/arrival.ml`'s DIC layout and against the M03 bench's stimulus set.
- Wrote `docs/reports/audit/WO-0041-mutations/README.md` **§7** as an EOF addition;
  **nothing above it edited** (verified by `git diff` — the diff is a pure append).
- Wrote `docs/reports/audit/ADR-0020-auditor-countersignatures.md` (new).
- Wrote this entry. **No `git commit`, no `git push`, no staging, and no
  `git apply` of any mutation** — PROTOCOL §2, §10, ADR-0019.

### Evidence

**Precheck and the two sibling movements** (each command's observed output):

```
$ git rev-parse HEAD                         # 21:44:12Z
287b5eee39b98f8ab8ce23e319f141a0e32cddad
$ git status --short
 M test/xgmii_tx_64/bench.ml ... ?? test/xgmii_tx_64/test_m04_f.ml     # tb_writer, declared
$ git rev-parse HEAD                         # 21:56Z
65ba1480488d28f7163099ffb7598a768b62b646     # Agent: tb_writer / J-tb_writer-0045
$ git rev-parse HEAD                         # 22:01Z
efe84b387a2d003bc0acbba7b8ea2ae4a36d6529     # Agent: rtl_lead / J-rtl_lead-0025 / Journal-Only
$ git rev-parse HEAD                         # 22:0xZ
fb58ba31d8e5ed185d4caea342426f381dc76778     # Agent: dv_lead  / J-dv_lead-0189  / Journal-Only
$ git diff --stat 287b5ee HEAD -- docs/adr/ADR-0021-a-check-is-only-where-it-runs.md \
                                  agents/journals/claude_auditor_agent.v02.md
(empty)
```

**Volume chain, checked at the append** (ADR-0017 §4.3, and the fields this
header asserts):

```
$ git cat-file -s HEAD:agents/journals/claude_auditor_agent.v02.md
258341
$ git show HEAD:agents/journals/claude_auditor_agent.v02.md | sha256sum
7fbe7bb2087449bc930fbb580af55be7934327b84356e4e5623bf6c05e5931bb  -
$ grep -c '^## \[J-auditor-' <(git show HEAD:...v02.md)   # last is J-auditor-0023
6                                        # -0018 … -0023, so Continues-from = J-auditor-0023
$ grep -nE 'JOURNAL_SOFT_MAX|JOURNAL_HARD_MAX' scripts/policy.sh
13:JOURNAL_SOFT_MAX="${JOURNAL_SOFT_MAX:-262144}"
14:JOURNAL_HARD_MAX="${JOURNAL_HARD_MAX:-524288}"
```
258,341 against 262,144 is **3,803 bytes** of headroom; the rotation is forced
rather than chosen.

**The stamp census, re-run in full at `65ba148`** (`ADR-0021` §7.4 command 1,
verbatim):

```
603 entries, 372 outside +/-3600 s (61.7%), 0 unparseable
fast (> +60m) = 369      slow (< -60m) = 3
orchestrator         265 entries  150 out  latest J-orchestrator-0265  (-1.0m)
dv_lead              188 entries  153 out  latest J-dv_lead-0188       (-3.1m)
architect_docs_lead   49 entries   36 out  latest J-architect_docs_lead-0049 (-5.8m)
tb_writer             45 entries   19 out  latest J-tb_writer-0045     (-382.5m)
rtl_lead              24 entries    7 out  latest J-rtl_lead-0024      (-6.0m)
auditor               23 entries    4 out  latest J-auditor-0023       (-5.9m)
data_wrangler          9 entries    3 out  latest J-data_wrangler-0009 (+797.4m)
```

Compare `ADR-0021` §2.4 at `b19ff91`: 600 entries, 371 out, 369 fast, 2 slow.
**The fast population has not grown by one entry since the ADR was drafted.**

**compliant-run, computed as specified** (consecutive most-recent in-band entries):

```
rtl_lead 16   orchestrator 15   dv_lead 10   architect_docs_lead 9
auditor 5     data_wrangler 0   tb_writer 0
```

**The three slow firings, each stamp and each commit read rather than inferred**
(the class F5 predicted, against the class the record has):

```
J-tb_writer-0024      stamp 2026-08-04T21:30Z                          commit 88413b9 2026-08-04T23:54:08Z   -144.1 min
J-orchestrator-0229   stamp 2026-08-06T20:45Z                          commit d3bd455 2026-08-10T20:41:13Z  -5756.2 min
J-tb_writer-0045      stamp 2026-08-11T15:30Z (estimated, see Open-q)  commit 65ba148 2026-08-11T21:52:31Z   -382.5 min
```
**Exactly one of the three carries the `(estimated, …)` qualifier.** I wrote "two"
on a first pass, checked it against `agents/journals/workers/claude_tb_writer_agent.v02.md`:1750
and `agents/journals/claude_orchestrator_agent.v02.md`:3215, and corrected it; the
stamps are quoted above so the correction is checkable rather than asserted.
`J-tb_writer-0044` — the ADR's parenthetical case — measures **−11.8 min**, in band,
reproducing §2.2's figure exactly.

**Precision split, reconciled** (the check that §2.2's ground is a measurement):

```
minute-precision 381   second-precision 222   total 603
```
`377 + 222` at `b19ff91` = 599, plus the one parenthetical = 600, plus three new
entries = **381 + 222 = 603**. Every term accounted for.

**The reference clock, and the script surfaces**:

```
$ git log --format='%at %ct' | awk '$1!=$2{d++} END{print NR, d+0}'
603 0
$ grep -c 'WARN-JOURNAL' scripts/agent_commit.sh
1
$ grep -cE 'JOURNAL_SOFT_MAX|JOURNAL_HARD_MAX|WARN-STAMP|WARN-JOURNAL' scripts/check_journals.sh
0
$ sed -n '178,182p' scripts/agent_commit.sh
[ "$staged_bytes" -le "$JOURNAL_HARD_MAX" ] || fail "... rotate to volume ... (R10, ADR-0017 §4.4)"
if [ "$staged_bytes" -gt "$JOURNAL_SOFT_MAX" ]; then echo "WARN-JOURNAL: ..." >&2; fi
```
The first confirms `ref` is single-valued on the history surface; the second
confirms constraint (ii)/(iii)'s premise at this HEAD; the third confirms
`FINDING ADR21-1`'s live half and §1.2's gap; the fourth confirms the refuse/warn
split subject 2 extends.

**The `D-M3` re-derivation — the sources, quoted at their lines**:

```
requirements.md:81   "measured **from the terminate character inclusive** to the
                      next start character exclusive, and its minimum is 12 octets"
requirements.md:101  "shorten a later gap — never below 9 octets"
SPEC-M03 §6.1:330    "an output word leaves **two** cycles after the input word
                      carrying its last octet when its frame began at lane 0 (L=16),
                      and two or **one** cycle after it when its frame began at
                      lane 4 (L=12), according as that octet lies in lanes 4…7 or 0…3"
SPEC-M03 §6.1:398    "output word m is emitted on the cycle m + 3"
447d11c:…xgmii_rx_64.ml:430   let begins = survivor_b |: survivor_c
447d11c:…xgmii_rx_64.ml:471   let bad_fcs = has_fcs &: (crc_final <>: ...residue)
447d11c:…xgmii_rx_64.ml:478   crc_reg <== reg spec (mux2 begins (zero 32) crc_final)
447d11c:…xgmii_rx_64.ml:154   let fcs_residue = 0x2144_df1c
```

`G = 8(S − W) + s − t`, so `G ≡ s − t (mod 8)`; `G = 9` ⟺ `t = 7, s = 0` or
`t = 3, s = 4`. **Terminate lane 0 with a 9-octet gap is not in the space**, which
is the proof's stated tightest case. Margin `= −1` at `t ∈ {1,2,3}` from a lane-0
start with a lane-4 successor at `G ∈ {11,10,9}`.

**The witness, from the bench's own layout code** (`arrival.ml`:30–61, hand-executed):

```
frames_at ~lane:0 [f65; f65; f65]      ifg=12, first_start=8, dic_floor=9
frame 0: start   8 (lane 0)  terminate  81 (word 10, lane 1)  credit 0 -> 3  gap 15
frame 1: start  96 (lane 0)  terminate 169 (word 21, lane 1)  credit 3 -> 2  gap 11
frame 2: start 180 (lane 4)
frame 1 tlast = 12 + 8 + 3 = 23 = W+2 ;  frame 2 start word = 22 ;  begins(22)
=> crc_reg(23) = 0 != 0x2144_df1c  => error_bad_fcs on a GOOD frame, cycle 23
```

**NOT EXECUTED, and labelled so.** I did not apply `D-M3.diff` and cannot
(PROTOCOL §10, ADR-0019). Nothing is withheld — every number is derived in the
open from committed documents — so this is a prediction and not a seal
(`R-SEAL-1`).

**The coverage gap, measured at `447d11c` from committed test source**:

```
bench.ml:289-296      run_directed_lengths -> one_frame   (every length, LONE)
test_m03_d.ml:239     "two 64-octet frames at frames_at's default 12-octet gap"
frame.ml:23-38        stress_frame = 6+6+2+4+42 + 4 FCS   = 64 octets
SO-xgmii_rx_64.md SC-4  "10 000 consecutive 64-octet frames"
64 mod 8 = 0  =>  every multi-frame stimulus lands in a margin-0 or margin-+1 row
```

**Mandatory charter §9 / §5 checks for this round**:
- **Write scope**: the two files below are both under `docs/reports/audit/**`;
  nothing else was written. `git status --short` at hand-off shows exactly them
  plus a sibling's `docs/PROCESS.md`, which is not mine and is not staged by me.
- **Frozen text**: `git diff docs/reports/audit/WO-0041-mutations/README.md` is a
  **pure append** — every hunk is an addition at EOF, no line above §7 changed.
- **No repo operation**: no `git commit`, no `git push`, no `git add`, no
  `git apply`.

**Labelled as construction, not measurement**: my readings at Reasoning §1 of what
constraint (iii) admits, and the disposition at §2 that a self-declared estimated
stamp is not a decay signal, are **constructions of drafted text**, not
measurements. They bind my signature and nothing else.

**Harvest**: **not owed at this round.** PROTOCOL §7 and charter §8 attach the
note to an `SO-` or a phase gate and this round is neither; my last harvest was
`J-auditor-0019` over `-0001 … -0018` and the span since (`-0019 … -0024`) tiles
onto it and remains open for the next `SO-` or gate. Declared rather than omitted.

### Outcome

**DoD met on all three acts.** Subject 1 is countersigned; the two relanded
artifacts exist as committed-ready files; and the debt accepted two rounds ago is
paid, with a result that inverts one of my own prior findings.

The transcribable act, written so the orchestrator can carry it verbatim under
ADR-0003's exception:

> **COUNTERSIGNATURE — auditor, `ADR-0021` §9, SUBJECT 1 (`WARN-STAMP`).** The
> route names this seat because `R-0020-1` is my recommendation, the ±60 band my
> measurement and constraints (i)–(iii) my wording, and on all three the
> instrument is faithful. **Constraint (i)** — warning, never refusal — is
> honoured on **both** surfaces and I verified it sentence by sentence rather
> than accepting it: F2, F3 and F4 leave the exit code untouched, §7.1 leaves
> both refusal sets unchanged, S40/S41 assert the silence and the exit-0 as a
> pair, and §10 forecloses a later refusal without its own ADR. **Constraint
> (iii)** — a new instance, not a new class — is honoured, including by the
> `compliant-run` column, which is the one part of the design that could have
> broken it and does not: it is a zero-state fold over a census the check already
> computes, with no baseline file, no stored history, no new artifact and no new
> `R`-number. **The two-parameter band is right** and I sign it on a ground the
> ADR does not state: the fast bound measures a stamp that cannot be honest,
> the slow bound measures round length, and one number serving two quantities is
> a coincidence rather than a parameter. **The granularity rule is a better
> statement of my noise-bounding intent than the one I gave**, because it derives
> the granularity from the remedy; both blocks are bounded by the roster and not
> by history, at 10 and 3 lines today against 372 violations, and the
> frozen-aggregate / active-itemise split is forced by the one volume that is
> 2.1× `H` and unfixable by anybody. **Re-measured at `65ba148`: 603 entries,
> 372 out of band, 369 fast, 3 slow, 0 unparseable — the fast population has not
> grown by one entry since the ADR was drafted.** **COUNTERSIGNED**, with two
> narrowings that are not refusals: **(1)** `JOURNAL_STAMP_SLOW_MAX`'s default is
> anchored to nothing measured — the 0-of-16 and 369-of-371 figures are fast-side
> facts and do not transfer — and **the review trigger §2.5 F5 names is already
> live**, `J-tb_writer-0045` firing the slow bound at −382.5 min ten minutes after
> the ADR landed while carrying the very `(estimated, …)` qualifier §2.2 admits as
> more honest than the grammar — and **none of the record's three slow firings is
> F5's predicted long-round case**, one being four-day drift the model does not
> reach; and
> **(2)** I sign `compliant-run` under the reading that **a zero is a prompt to
> read the entry, never a verdict about the chain** — §2.6's own bound applied to
> the column. `FINDING F-0024-1` and `FINDING F-0024-2` are filed; neither blocks
> subject 1 and neither asks for a redraft.

**Findings, five in the note plus two here — and one CRITICAL is opened.**

| id | severity | subject | finding |
|---|---|---|---|
| **F-0024-A** | **CRITICAL** | **dv_lead** (`RV-0041-VERDICT` §3, `J-dv_lead-0044`) | The `D-M3` equivalence proof does not hold. Its stated tightest case cannot exist (`G ≡ s − t (mod 8)` — arithmetic, certain), and the margin reaches **−1** at terminate lanes 1–3 from a lane-0 start with a lane-4 successor at gaps 11/10/9 — the `REQ-004` worst case. Charter §3 reserves CRITICAL for Evidence that does not reproduce; this is one, in a **verbatim**-class packet, supporting a live denominator exclusion. **E4.** **Falsifier named and cheap**: one transient run of the unmodified `D-M3.diff` against `frames_at ~lane:0 [f65;f65;f65]`; **withdrawn in full if green** |
| **F-0024-B** | MAJOR | `SO-xgmii_rx_64.md` `SC-5` (:280, :511, :803) and `P1-module-ready-checklist.md`:211 | With A standing, the pre-class figure is not *"15 of 15"*: `D-M3` returns to the denominator as a **survivor**, `WO-0041` becomes **4 of 5**, and (b.2)'s survivor form cannot be met — **there is no killing unit** |
| **F-0024-C** | MAJOR | dv_lead / tb_writer (`test/xgmii_rx_64/**`) | No unit combines a length ≢ 0 (mod 8) with a following frame; the DIC-shortened-gap rows are undriven, floor included. **Not a DV-escape ledger entry** — the ledger's subject is a divergence of the *design* and there is none; the defect is in the score and the stimulus, and filing it as an escape would misname it |
| **F-0024-D** | MINOR | **my own seat** | §3.3's lane-4 drain window is off by one (`W`/`W+1` where the truth is `W+1`/`W+2`). Conservative for the claim it served. Recorded, **not repaired** — §3.3 is frozen pre-run text |
| **F-0024-E** | MINOR | `ADR-0020` §6.3 / architect_docs_lead, orchestrator | If A stands, the (b.3) grandfathered set's single member loses its substantive ground and **the record contains no surviving equivalence exclusion at all**. Grandfathering excuses the missing record, not a refuted proof |
| **F-0024-1** | MINOR | `ADR-0021` §6 and §2.5 F5 / architect_docs_lead | Two parameters, one anchor: `JOURNAL_STAMP_SLOW_MAX`'s row cites *"the decided ±60 symmetric"*, while the measured anchor (0 of 16, 369 of 371) is entirely fast-side and does not transfer. And F5's review trigger is **already live** at countersignature — `J-tb_writer-0045`, −382.5 min, ten minutes after the ADR landed — on a slow population containing **zero** instances of the long-round case F5 models: one four-day drift, one unqualified −144 min, one self-declared estimate |
| **F-0024-2** | MINOR | `ADR-0021` §2.4 / architect_docs_lead, orchestrator | §2.4's block is declared a testable prediction whose mismatch means *"the implementation does not match this ADR"*; at `65ba148` it already does not match (372/603, three chain rows moved). The **comparison SHA must be restated at implementation** — one line in the implementing entry |

**`F-0021-4` is INVERTED, not repaired.** It was filed against my own seat on the
premise that the equivalence proof refutes my §3.3 claim. The proof does not.
§3.3's essential claim survives and `F-0024-D` replaces it. The (b.3)
countersignature at `J-auditor-0021` is **unaffected and stays as signed** — it
adopted a standard, not an instance — but the sentence in that entry's §9 that
said *"the exclusion **stands** on its own merits regardless"* is **withdrawn**,
openly, here and in the transcription file.

**Nothing here passes a gate.** `G-1` and `G-9` remain open
(`P1-module-ready-checklist.md`:179, :181, :517, :525); the new file closes only
the auditor-verdict half of `G-1`'s route and says so in terms. **One thing here
blocks one**: `F-0024-A` is CRITICAL, charter §3 makes an open CRITICAL a bar on
`P<n>-phase-accept`, and its falsifier is a single CI run. Carried unrepaired from
prior rounds: `F-0021-1`, `F-0021-2`, `F-0021-3`, `F-0021-5`, `F-0022-1` …
`F-0022-5`, all restated with routes in the new file. `F-0024-1`, `F-0024-2`,
`F-0021-1`, `F-0021-2` and `F-0021-5` concern the relaying party or the drafting
seat and are stated identically to the rest, per charter §7's adverse-party clause.

**Handoff**: to the orchestrator for commit. Trailers `Agent: auditor`,
`Work-Order: none`, `Journal-Entry: J-auditor-0024`; **not** journal-only — two
work-product paths are staged, both inside `docs/reports/audit/**` (`R7`). This is
a **rotation** commit: `v03` is new, `v02` is not staged and must not be
(`R3`, `R10`). The countersignature block above is the transcribable act; this
entry is its tamper evidence.

### Open-questions
1. **`F-0024-A` is the first CRITICAL this seat has opened, and it is falsifiable
   by one run that only the orchestrator can perform.** PROTOCOL §10 gives
   transient mutation application to the orchestrator and ADR-0019 keeps me out of
   the repository, so **the finding and its refutation both sit with the party it
   is relayed through**. That is the structure charter §7 anticipates, and it is
   why the witness is written out in full rather than described: if the run is
   never commissioned, a reader can execute the arithmetic without it.
2. **If `F-0024-A` stands, two artefacts carry a figure that no seat in this round
   may edit.** `SO-xgmii_rx_64.md` is dv_lead's and `P1-module-ready-checklist.md`
   is written only by the orchestrator; I can find the defect and never touch it.
   **Nobody has been commissioned to re-score `WO-0041`**, and a `4 of 5` that
   nobody writes down leaves the gate reading `15 of 15`.
3. **The (b.3) standard's first live application would now be a re-run, not a
   record.** `ADR-0020` §6.3 closes the grandfathered set at one member and that
   member's proof is refuted; limb 2 asks the proof to quantify over the
   specification's legal stimulus space, and **this is a worked example of a proof
   that said it did and did not**. Whether the clause wants an
   independent-re-derivation limb is a question for the seat that drafted it, and
   I raise it without proposing text — I am the seat it would bind.
4. **My `-0021` Open-question 4 asked a later spawn to check whether this note
   softens a defect in my own artefact. It should now be read in both
   directions.** The pressure this round actually applied was toward writing the
   *dispatch's* sentence rather than the derivation's, and the guard that held was
   a disclosure I had bound myself to a round earlier. **A promise to say which of
   two methods you used is worth more than a promise to reach a particular
   conclusion**, and that is a harvest candidate for the next `SO-` rather than a
   claim I bank here.
### Files-in-this-commit
- docs/reports/audit/ADR-0020-auditor-countersignatures.md
- docs/reports/audit/WO-0041-mutations/README.md

## [J-auditor-0025] 2026-08-11T22:29Z | task:none | The seating, the placement and the founding sequence confirmed against my own practice; the stamp transcription censused at 100% of kinds and dates and returns one wrong date, one dateless stamp and one correction the margin was made to carry alone — and B.5 resolves against my own artefact, where the cure is an appended line and not a rewritten cell

### Trigger

Orchestrator dispatch, one round, journal-only: the confirmation Annex B.1 of the
revised `docs/PROCESS.md` assigns this seat, before council round 2 convenes.
Dispatch-only, no work order — itself an instance of the class my own row `C-70`
names, and the second consecutive round of that class for this seat. Declared
siblings: dv_lead on the parallel confirmation (its journal only); the transient
`mut/wo-0041-dm3-falsifier` on the remote, executing my `F-0024-A` falsifier
under the orchestrator's operator hand, verdict pending and outside this round's
surface.

### Inputs

- `agents/charters/auditor.md` (whole), `agents/PROTOCOL.md` (whole) — mandatory
  first actions.
- `docs/PROCESS.md` at `2f32e45`, 2,685 lines: §3.9 and §1.5 line by line, §1.7
  whole, the stamp table at :60–91, §2.6's rule table, Annex B whole, and the
  fifteen `[CORRECTED]` sites with their margins.
- `docs/reports/audit/PROCESS-claims-posture.md` (my own artefact, all 128 rows) —
  the source against which transcription is measured.
- `docs/reports/audit/AUD-0001-g0-retro.md` §1 and :19; `docs/gates/G0-checklist.md`
  whole; `docs/SPONSOR.md`:37–44.
- `docs/adr/ADR-0017` header and §6.6; `ADR-0019` §1.1–§1.2 and header;
  `ADR-0020` :138–170, :650–730, :1543–1560; `ADR-0021` header.
- `agents/journals/claude_architect_docs_lead_agent.v05.md`:684, :735–745, :946–954
  (the six-cure round); `.v02.md`:670, :972, :1170–1195 (the anchor my own row
  `C-117` cites, read to check it); `claude_dv_lead_agent.v10.md`:2743, :2880–2895;
  `claude_orchestrator_agent.v02.md`:4723; `claude_auditor_agent.v02.md`:1570–1600,
  :3286–3300.
- `scripts/policy.sh`, `scripts/agent_commit.sh`, `scripts/check_journals.sh`,
  `.github/workflows/`, and git history at `2f32e45`.

### Reasoning

**Sampling frame, stated first because an audit whose sample cannot be
reconstructed is vacuous (charter §8).**

*In the window*: the four scope items of the dispatch — §3.9 whole plus the §1.5
seating; every posture stamp's transcription fidelity; §1.7's founding sequence,
record half; and the `B.5` discrepancy in my own artefact.

*Sampled, and at what depth.* Three different depths, chosen by where a defect
could hide rather than by a uniform percentage:

1. **Stamp kind — census, 100%.** All 135 stamp occurrences carrying a `C-nn`
   citation were extracted mechanically from `docs/PROCESS.md` and diffed against
   the posture cell of all 128 rows. This is the only part of the transcription
   that is mechanically decidable, so it is the part that gets a census rather
   than a sample.
2. **Stamp date — census, 100%.** All 26 `[P1]` citations, each re-anchored to a
   commit, a gate row or an entry header. Dates are the only stamp field carrying
   information that is not already in the kind, and they are testimony by §5.4's
   own classification, so a sample would have been the wrong instrument.
3. **Claim text — stratified sample, 49 of 128 rows = 38.3%**: all 15 `CORRECTED`
   rows (the class where the revision *rewrote* the claim, so the only class where
   a mis-rewrite is possible), all 8 `PLANNED`, all 26 `P1`. Plus, outside the
   strata, the whole of §3.9's fifteen-bullet block and §1.5 read line by line
   because they are this seat's own scope item.

*Deliberately skipped, and why.* The claim texts of the 44 `RE` and 34 `MC` rows
were not re-read one by one except where they fall inside §3.9, §1.5, §1.7, §2.6's
table or the strata above. Their *kinds* are censused. The ground is specific and
checkable: those postures were re-executed against the machinery at `6c02f5b`
thirteen hours earlier, and `scripts/` has not moved since `678948b` (2026-08-04)
— re-verified this round — so a second re-execution would re-measure an unmoved
surface. Two were re-executed anyway as controls, chosen because they are the two
that bear directly on my own scope items (the auditor write scope, and the
no-script-reads-a-tally claim under `C-104`). Both hold. I also did not audit the
`RV-` ACCEPT half of §3.9's placement clause from the implementing line's side —
see the residue in Outcome; that limb belongs to the seats Annex B.1 rows 2 and 3
bind, and asserting it from a partial read would be the defect this round exists
to catch.

**1. The seating (§1.5) is stated correctly, and it is stated for the right
reason.** The reading that a defect manifest **is** one of this seat's own reports
is exactly the reading I operate under, and the text's ground for stating it is
the ground that matters: without it the mechanism has no author, because the
verification lead is the subject under test and the orchestrator is the operator.
Re-executed rather than agreed: every one of the 24 commits trailered
`Agent: auditor` touches only `docs/reports/audit/**` plus this chain — zero
out-of-scope paths — and the manifests themselves sit at
`docs/reports/audit/WO-00NN-mutations/*.diff`. Nothing is relaxed by the reading;
the scope check is unchanged and it is the same instrument `C-25` and `C-26` cite.
The sentence that generalises it — *a roster that forbids more precisely than it
enumerates will eventually forbid a duty it also requires* — is the transferable
part and I would not weaken it.

**2. The placement is true at its boundaries and singular in its framing.** The
rule as written is faithful to the constitution's §10 sequencing, and the record's
boundary conditions hold: the last campaign sealed at `aced7b4` (2026-08-06) and
the module's only sign-off issued its PASS at `69f1475` (2026-08-11), so no
campaign in this program ran after a sign-off, and none ran on a calendar. What
the singular framing under-describes is the shape the record actually has: fifteen
campaigns on one artefact across nine days, interleaved with four defect packets
and their repairs. A campaign *era* bounded by acceptance and sign-off is what an
adopter will find here; one campaign in one gap is what the sentence draws. I do
not file that as a defect in the rule — the rule is the constitution's and it is
stated accurately — but it bears on the exhibit-level accuracy of the same
section, and it is why `F-0025-D` matters more than its size suggests.

**3. The scoring block's rebuilt referents are faithful, and the rebuild is an
improvement on what it anonymises.** All fifteen bullets check against the
constitution's §7 (b)–(b.4) and §10's floor. The two-column rule, the three
grounds, the openness-of-grounds with the closed naming duty, the
disclosure-frozen-before-the-run condition, the class-not-branch unit, the
individually-named non-kills, the survivor form, the frozen-kill form with its
stated limit, the equivalence proof standard with its three guards, the
unreachable/seeding-gap distinction, and the floor measured before exclusion — all
present, none weakened. Three referents are spelled out where the constitution
leaves them compressed (what a never-rendered class looks like, what a falsified
seeding looks like, why a negative control exists), and every one of those
expansions is right against the cases they generalise. Three referents are dropped
that I would carry: *which* grounds turn on the seal's disclosure (the second and
third), the definition of *survived its own campaign* (the seal predicted a kill
and no unit killed it), and the rehabilitation-asymmetry ground under the
frozen-kill limb. None of the three changes a rule; each costs a reader one
inference. I record them as carried-forward observations rather than findings,
because a portable document that states every rule and half the rationale is still
a document that states every rule.

**4. Two of the three exhibits are incidents; the middle one is a hazard, and the
framing promises three incidents.** Exhibit 1 reproduces at every clause,
including both additions the revision makes — the two grounds that had never been
stated together (nine days apart, under different words) and the discovery route
(the draft taken from the practice's columns while the operative word lived in its
verdict lines, which the codifying seat records against itself). Exhibit 3
reproduces exactly, and it is my own finding: four units, nine units, one of three
required; filed against a clause I had signed in the same entry; routed to the
seat the width would fall on; stopped at the constitution's edge. Exhibit 2's
underlying case is `G-c4`, and in the record `G-c4`'s rehabilitation was proved in
the **strong** form from the beginning — the unmodified diff, a run id, the killing
unit named. The rule was minted *from* that case as its exemplar; my own verdict
sentence says so. An exhibit set introduced as *a ruling without its case is a rule
nobody can apply* will be read as three cases of a defect, and the middle one is
not one. One clause fixes it and the exhibit gets stronger, not weaker: a rule
generalised from a case that went right is a better advertisement than a rule
generalised from a case that went wrong.

**5. The founding sequence's record half is confirmed, item by item.** The
retro-audit declares its own weakness in the terms §1.7 attributes to it, in its
own §1: *the auditor did not exist during the window it audits … I witnessed none
of it* — and it does more than the document claims, naming two further weaknesses
(single-author attribution degenerating to substance-vs-narrative, and R1 being
audit-enforced for that agent, so that one section is the whole of the enforcement
for the range). Seventeen findings, one CRITICAL, at `:19`. The gate blocked on it
and could not be signed around: `G0-checklist.md` item 11 is a row of its own —
*gate release: AUD-0001 CRITICAL (F17) dispositioned by ADR and re-verified by the
auditor* — signed `J-auditor-0003` against the second report. Eleven items, every
one signed by an entry reference, two of them the sponsor's, one closing only on
this seat's re-verification, and the first module work order after G0 passed. The
owed-weaknesses paragraph is also accurate, including the one that is against my
own chain: the retro-audit's tally *was* published wrong and corrected in place by
its author, at `de85393`, whose subject line says so.

That last fact decided how I answer `B.5`, and it is the substantive half of my
answer.

**6. `B.5` resolves for 15 and 8 — and the cure is an appended line, not a
rewritten cell.** The figures are not a matter of judgement: recounted mechanically,
posture cell by posture cell, over all 128 rows, `FALSE` = 15 and `PLANNED` = 8,
and both agree with the summary table, the per-section table, the collected-FALSE
table and the PLANNED table, with the row-total identity closing at 128. The wrong
figure is in my own row `C-126`'s evidence cell. But the record already names
in-place correction by the author as a weakness of exactly the artefact class this
is — §1.7 carries it, §5.4 rules that a frozen record is not repaired by rewriting
it, and `de85393` is the instance both point at. So the correction owed is a
**dated appended note** naming the wrong figure and the right one, not a silent
edit of the cell. I could not establish where `12/4` came from within this round's
frame and it does not bear on the resolution; I say so rather than construct a
provenance.

**7. And one discrepancy in my own artefact that `B.5` did not route, found while
checking a stamp date.** My row `C-117` anchors §4.8's six-cure exhibit at
`claude_architect_docs_lead_agent.v02.md`:1181. That line is inside
`J-architect_docs_lead-0025` (2026-08-04) and its *sixth* is the sixth check of a
countersignature, not the sixth cure of a cure basket — a text-similarity match I
did not falsify at the time. The true anchor is `J-architect_docs_lead-0047`
(2026-08-11T19:34Z), whose disposition table has six rows with row 6
`F-0022-2` **STOPPED**. The consequence runs in the document's favour: the
`[P1 · 2026-08-11 · C-117]` stamp is **correct** and my row's anchor is wrong. I
record it here because a posture list whose anchors are not falsifiable is the
same defect it was written to measure, and because the seat that finds an error in
its own artefact should be the seat that says so first.

### Actions

- Abort-first precheck (§4.1) before any file was opened.
- Extracted all stamp occurrences from `docs/PROCESS.md` and diffed kinds against
  all 128 posture cells; re-anchored all 26 dated stamps; read the 15 `CORRECTED`
  sites with their margins.
- Re-executed the `mut/*` never-merged measurement, the auditor write-scope
  measurement, and the no-script-reads-a-tally measurement at `2f32e45`.
- Re-read §3.9's fifteen bullets against `PROTOCOL` §7 (b)–(b.4) and §10, and the
  three exhibits against `ADR-0020` and the campaign record.
- Verified §1.7's record half against `AUD-0001`, `AUD-0002` and
  `docs/gates/G0-checklist.md`.
- Wrote no file but this journal. Ran no git write command. Refused no stop-hook
  demand because none arrived; the standing refusal holds either way.

### Evidence

All at `2f32e45` on `claude/fpga-hardcaml-agent-orchestration-37ceyf`, tree clean
at precheck (`git status --short` → empty, `git rev-parse HEAD` →
`2f32e45d86f6c04f1ad50eaff1a08f71605a5125`, `date -u` → `2026-08-11T22:15:54Z`).

1. **Stamp-kind census.** 135 citations extracted; every one of the 128 rows is
   stamped at least once; nine rows carry two stamps; **zero rows unstamped**;
   exactly one row (`C-08`) carries two different kinds, and it is correct — `[RE]`
   at :219 on the surviving limb (single-authority allocation) and `[CORRECTED]` at
   :223 on the refuted limb (*monotonic by construction*). All 15 `FALSE` rows map
   to `[CORRECTED]`, all 8 `PLANNED` to `[PLANNED]`, the one `NOT SAMPLED` row to
   `[UNANCHORED]` (twice, §1.4(d) and §5.7, correctly the same episode).
2. **Stamp-date census, and the one that fails.** `[P1 · 2026-08-04 · C-55]` at
   :920. `git log -S'R11' -- scripts/check_journals.sh` → `a0454b4`, and
   `git log -1 --format='%ad' --date=iso a0454b4` → **2026-08-03 20:20:04 +0000**;
   `S38` enters `test_protocol.sh` in the same commit; `ADR-0017` is added at
   `8d83371` (2026-08-03) and accepted at `J-orchestrator-0140`
   (2026-08-03T18:55Z). The only `scripts/` commit dated 2026-08-04 is `678948b`,
   a SIGPIPE-race fix (S39) — the commit my own row `C-54` cites for a different
   fact. Every other dated stamp re-anchors: `AUD-0001` added `bd7fbcf`
   (2026-08-01); `G0-checklist.md`:17 (2026-08-01); `61e0c76` (2026-08-11);
   `SO-xgmii_rx_64.md` PASS at `69f1475` (2026-08-11) with the preserved FAILs in
   the same file; `ADR-0020` added `8264183` (2026-08-11);
   `J-dv_lead-0185` (2026-08-11T17:47Z); `J-orchestrator-0260` (2026-08-11T17:06Z);
   `J-architect_docs_lead-0047` (2026-08-11T19:34Z); M0 root range 2026-08-01
   against the first RTL work order 2026-08-02.
3. **Never-merged, re-measured at HEAD.** `git for-each-ref
   'refs/remotes/origin/mut/*'` → **86** references; `git merge-base --is-ancestor`
   over each against `HEAD` → **0 merged**, 86 checked. Grouped by campaign prefix:
   **15** `wo-00NN` campaigns plus two probe prefixes. `ADR-0019` §1.1's measured 85
   is consistent with a population that grows; the *class* count is not ninety.
4. **No script reads a tally.** `grep -rniE
   'seeded|sealed|mutat|unreachab|equivalen|kill|tally|denominator|floor'
   scripts/ .github/` → three hits, all unrelated: two `R8` foreign-volume-*seed*
   messages and one workflow step name containing *re-checked*. `[RE · C-104]`
   re-executes true.
5. **Auditor write scope.** 24 commits trailered `Agent: auditor`; the union of
   their non-journal paths, filtered against `docs/reports/audit/`, is **empty**.
   Manifests confirmed at `docs/reports/audit/WO-0041-mutations/D-M1..D-M5.diff`.
6. **`B.5` recount.** All 128 rows parsed; `MACHINE-CHECKED` 34, `REVIEW-ENFORCED`
   44, `PERFORMED-ONCE` 26, `PLANNED` 8, `FALSE` 15, `NOT SAMPLED` 1; total 128,
   127 with a posture. FALSE set: `C-07, C-08, C-32, C-33, C-40, C-56, C-67, C-70,
   C-77, C-80, C-82, C-93, C-97, C-114, C-123`. PLANNED set: `C-23, C-41, C-51,
   C-53, C-54, C-71, C-109, C-119`. `docs/PROCESS.md` carries 15/8 at :21–25, :667,
   :2430, :2437 and :2454 and nowhere carries 12/4 outside `B.5`'s own flag.
7. **§1.7's record half.** `AUD-0001-g0-retro.md`:32–49 (three declared weaknesses,
   the first verbatim as §1.7 describes it), `:19` (*1 CRITICAL, 7 MAJOR, 7 MINOR,
   2 NOTE — 17 findings*), `:735` (F17), `G0-checklist.md` items 1–11 all signed,
   items 8 and 9 the sponsor's, item 11 closing on `J-auditor-0003`/`AUD-0002`, and
   the in-place tally correction at `de85393`.
8. **Exhibit anchors.** Exhibit 1: `ADR-0020`:650–672 (three checks, `I-c1`
   declared SEEDED then VOID, `IC-M5` never rendered yet inside `sealed`, *nine days
   after*, and the codifying seat's own *would have frozen a `sealed` column that
   omits a class the seeder itself declared seeded*); the qualifier *9 of 9
   scoreable classes* at `WO-0061_family-i-mutation-campaign.md`:646 and :749, in
   the verdict lines, in no normative document. Exhibit 2: `ADR-0020`:145–160
   (`G-c4`, `mut/wo-0056-gc4-replay` = `c95c9f4`, run `30852220315`, `M03-G8` the
   only failing unit) and the minting sentence at `claude_auditor_agent.v02.md`:1583
   — *exactly the evidence form `G-c4` already has*. Exhibit 3:
   `claude_auditor_agent.v02.md`:3296 and
   `claude_architect_docs_lead_agent.v05.md`:739, :952.
9. **The canary residue.** `docs/PROCESS.md`:512–515 against `docs/SPONSOR.md`:43–44
   (*This page documents the mechanism; never document the instances*), which is
   inside the specification lead's own write scope per `scripts/policy.sh`:174–178.

### Outcome

**Confirmed, with six MINOR corrections and no CRITICAL and no MAJOR.** All four
dispatch items are answered: the §1.5 seating and §3.9's separations match this
seat's practice and are stated correctly; the placement is true at its boundaries;
the scoring block is faithful to the rulings it anonymises; §1.7's record half
reproduces item by item; and `B.5` resolves for **15 FALSE and 8 PLANNED**, with
the wrong figure in my own artefact and the cure owed as an appended dated note
rather than an edited cell.

Findings `F-0025-A` … `F-0025-F`, all MINOR, none blocking: a stamp date one day
late (`C-55`); a stamp missing the date its own grammar requires (`C-125`); one
`[CORRECTED]` site where the false sentence is preserved and the correction left
entirely to the margin (`C-32`); an ambiguous *some ninety* in the one section
that rules a ref population cannot be a denominator; the second exhibit reading as
an incident that did not occur; and a contradiction cured in the copy, left in the
source, and not rowed in Annex B. Two corrections are owed against **my own**
artefact: `C-126`'s figures and `C-117`'s anchor. The full text is returned to the
orchestrator verbatim as the round's product; nothing is committed by me.

**Residue, declared.** The *after the implementing line's review has accepted the
artefact* limb of §3.9's placement was **not** audited from the implementing line's
side this round. The record's `RV-` verdicts that I read are the verification
line's — bench reviews and campaign adjudications — and I found no rtl_lead
acceptance gating a campaign start within the frame I sampled. That is an
unmeasured limb, not a negative finding, and it belongs to the seats Annex B.1
rows 2 and 3 bind.

**Harvest**: none owed. `PROTOCOL` §7 attaches the lessons harvest to every
sign-off and every phase gate; this round is neither, and the span since
`J-auditor-0019` stays open and untiled rather than being closed by a round that
does not carry one. Declared so the gap is visible rather than inferred.

### Open-questions

1. **The two corrections against my own artefact are mine to state and not mine to
   make this round** — writes were restricted to this journal by dispatch. If the
   round that applies them is not this seat's, note that `C-126`'s cure is an
   **appended** note by §5.4's own rule and by `de85393`'s example, and that
   silently rewriting the cell would reproduce, in the file that measures the
   program's honesty, the exact weakness §1.7 lists as still owed.
2. **`F-0025-E` is a judgement about how an exhibit will be read, not about
   whether a fact reproduces**, and dv_lead holds the parallel confirmation on the
   same block. If dv_lead reads the exhibit as accurate, the disagreement is worth
   one written round rather than a split, and the fact under it is not in dispute:
   `G-c4` was rehabilitated in the strong form and the rule was minted from it.
3. **`F-0024-A` remains open and CRITICAL** while its falsifier runs on
   `mut/wo-0041-dm3-falsifier`. Nothing in this round touches it, and nothing in
   this round should be read as a disposition of it. If the run is green the
   finding is withdrawn in full, as sealed.
4. **The charter names a manifest directory this seat has never used.**
   `agents/charters/auditor.md`:22 says `docs/reports/audit/mutations/`; the
   practice is `docs/reports/audit/WO-00NN-mutations/`. `PROCESS` §1.5 is right
   because it says *its report directory* and not a path. The charter is
   orchestrator scope; recorded so a later reader does not take the charter's path
   for the record's.

### Files-in-this-commit
- (none)
