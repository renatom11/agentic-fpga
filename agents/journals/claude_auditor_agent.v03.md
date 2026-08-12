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

## [J-auditor-0026] 2026-08-12T02:54Z | task:none | My CRITICAL is withdrawn by the falsifier it sealed, and the derivation that produced it is defective at one located step — received octets for delivered, one cycle, in a claim whose whole content was one cycle; the coverage finding beside it was half false when I filed it; and the census my list owes is scheduled rather than smuggled into a six-item round

### Trigger

Orchestrator dispatch, one round, this seat: the **reconciliation** owed since
`F-0024-A`'s falsifier ran, plus the two corrections against my own artefact that
`J-auditor-0025` filed and could not stage (dispatch-scope, writes restricted to
that journal), plus two re-measurement notes for rows whose referent has grown,
plus a scope ruling that is mine to make. No work order — the fifth consecutive
dispatch-only round for this seat, which is still an instance of my own row
`C-70`.

**Abort-first precheck, before any file was opened** (`2026-08-12T02:34:21Z`):
`git rev-parse HEAD` → **`a39c8e7`**, exactly as the dispatch predicted;
`git status --porcelain` → **empty**; branch
`claude/fpga-hardcaml-agent-orchestration-37ceyf`. Proceeded.

**HEAD moved once mid-round and a fourth lane opened, both declared.** At
`02:41:37Z` HEAD became **`1b684c7`** (*"The sponsor grades the fourth edition
from outside…"*, landing
`docs/reports/process-council/sponsor-report-card-2026-08-12.md`), and the
orchestrator announced in flight that **architect_docs_lead** has begun a **fifth
edition** of `docs/PROCESS.md` (its write scope: that file and its own journal).
Re-verified rather than assumed: the only dirty path at re-check is
`agents/handoffs/WO-0082_tb-m04-two-frame-presenter-and-g10.md` — declared sibling
(2), dv_lead's stage-2 packet revision — and `git diff --stat d4be71b HEAD` over
every read surface this entry depends on
(`libs/hardcaml_ethernet/src/xgmii_rx_64.ml`, `test/xgmii_rx_64/`,
`test/xgmii/arrival.ml`) is **empty**. Declared siblings (1) rtl_lead's
`C-RL-11/12` corrections and (3) the transient `mut/wo-0041-dm3-falsifier` touch
nothing of mine. **The fourth lane changed one of my answers**, and I say so where
it did: it is the reason items 4 and 5 are pinned to `9362aef` rather than to
*current text*.

**Honest stamp**: `date -u` read at authoring — `Wed Aug 12 02:54:17 UTC 2026` —
carried to the minute in the header above. No spawn short-id: lead-class seat, not
a worker (PROTOCOL §4.1). **Size arithmetic (ADR-0017 §4.4), checked myself**:
`v03` stands at **68,411 bytes** against `JOURNAL_SOFT_MAX` = 262,144
(`scripts/policy.sh`:13) — 193,733 bytes of headroom, so **no rotation**; this
entry appends to `v03` and `v02` stays frozen.

### Inputs

- `agents/charters/auditor.md` (whole); `agents/PROTOCOL.md` (whole) — mandatory
  first actions.
- My own `J-auditor-0024` (whole, :20–702) and `J-auditor-0025` (whole,
  :704–1029), read from the committed file rather than from memory.
- `docs/reports/audit/WO-0041-mutations/README.md` §3.3 (:320–402), §7 whole
  (:716–950), and `D-M3.diff` whole.
- **The design and its contract, at the falsifier's own base**:
  `libs/hardcaml_ethernet/src/xgmii_rx_64.ml` — the header at :15–65 (ΔC = 3,
  *"the FCS is removed by `tkeep` and never by holding octets back"*), :230–380
  (epochs, coverage), :390–479 (`begins`, the CRC recurrence), :480–534 (the
  three-age closure record), :940–1006 (`emit_last_a`/`emit_last_b`, `consume`,
  the strobes).
- `test/xgmii/arrival.ml` whole (the DIC layout, hand-executed again);
  `test/xgmii_rx_64/bench.mli`:440–450 and `bench.ml`:455–468 (`error_pulses`);
  **`test/xgmii_rx_64/test_m03_f.ml`:660–800** — the unit §7 did not open;
  `test_m03_d.ml`, `_e`, `_g`, `_i`, `_j`, `_k`, `_l`, `_n` at their `frames_at`
  call sites; `docs/specs/requirements.md` §0.3 (:95–115).
- `528b045` (the never-merged falsifier commit) and GitHub Actions run
  **31541276523** with its two jobs, read at the API.
- `docs/reports/audit/PROCESS-claims-posture.md` (my own artefact, all 128 rows);
  `docs/PROCESS.md` at **`6c02f5b`** (:806–812, :887–937) and at **`9362aef`**
  (:2725–2760, :2936–3054); `agents/handoffs/SO-xgmii_rx_64.md` §0.1, §1.1–§1.4's
  `SC-6` rows, §2.3; `agents/journals/claude_architect_docs_lead_agent.v02.md`:1179–1183
  and `.v05.md`:684 and :940–955.

**Not read, deliberately**: the in-flight fifth edition of `docs/PROCESS.md` (a
sibling's uncommitted working text is not a read surface, and pinning to it is the
very error item 5 rules against); `docs/reports/process-council/sponsor-report-card-2026-08-12.md`
beyond the fact of its landing (it drives another seat's round, not mine, and
dispatch item 6 marks the scoring question as separately commissioned); the other
nine campaign manifests.

### Reasoning

#### 1. The withdrawal is not a formality, and I took the run apart before taking it

`F-0024-A` sealed its own executioner: *withdrawn in full if that run is green*.
The dispatch reports it green. **A seat that accepts its own refutation on the
word of the party the finding was relayed through has not been refuted, it has
been told** — so every fact went back to its source. The run exists at the API
(31541276523, workflow `build`, `head_sha` `528b045`), and the step-level read is
what matters rather than the run-level rollup: **Build, Run-tests and Generate-RTL
all `success`; the single red is *Verify nothing was left unpromoted or
non-deterministic***, which is red for **any** mutated tree by construction. The
`cosim` job is green end to end, which is a second datum in the same direction.

Then the four things that decide whether a green run means anything: the applied
RTL is **byte-identical** to `d4be71b` + the committed `D-M3.diff` (re-applied and
diffed, not eyeballed); the oracle `error_pulses` is real and is the same one a
dozen M03 units use to assert strobes that **do** fire; the driven window (35
schedule cycles plus a drain) contains the predicted cycle 23 with twelve cycles
to spare; and the design has not moved between the falsifier's base and HEAD, so
the observation transfers. **Only then did I write WITHDRAWN.**

#### 2. The divergence step, and why locating it mattered more than withdrawing

The dispatch is right that a derivation which produced a false CRITICAL is an
instrument with a measured defect, and that the record needs the defect's
**location**. I re-executed the chain step by step against the RTL rather than
against my own note. Steps (i)–(iv) — the DIC layout, the terminate word and lane,
the successor's `begins` word, the re-seed's arrival at `crc_reg(23)` — **all
reproduce exactly**. Step (v), the consumption cycle, does not: I wrote 23, the
design does 22.

**The substitution is `received` for `delivered`.** §6.1/§7's rule is *"output word
`m` leaves on cycle `m + 3`"*, and `m` indexes **output** words — the payload after
`REQ-103`'s four FCS octets have been removed by `tkeep`. I computed `m` from the
frame's received octet count: ⌈65/8⌉ = 9 words, last index 8, `tlast = 12 + 8 + 3
= 23`. The design emits ⌈61/8⌉ = 8 words, last index 7, `tlast = 22`. One
substitution, one step, **exactly one cycle** — and the entire finding was a
one-cycle margin: `crc_reg(22)` is still the frame's own final CRC and only
`crc_reg(23)` is the re-seeded zero. The mutant reads the register one cycle
before the seed lands.

**What makes this a located defect rather than a plausible story** is that the
correct arithmetic is written out in the suite I was auditing, three files from
where I was reading: `test_m03_f.ml`:695–697 computes `words0` from `delivered0 =
63 - 4`, and that unit's own header calls the delivered-versus-received
distinction its whole point. §7 sampled `bench.ml` and `test_m03_d.ml` and never
opened it.

**And then I went further than the withdrawal required, because a withdrawal that
leaves the question open is not a reconciliation.** With step (v) repaired the
general case closes, the other way: consumption is at most `C + 2`; `C + 2`
requires terminate lane ≥ 5; the successor's `begins` word is at least `C + 1` and
equals it only if its start lane is ≥ `t + 1`; divergence needs both bounds tight
at once, hence a start lane ≥ 6, which `REQ-101` forbids. **`D-M3` is an
equivalent mutant over the whole legal stimulus space, and the load-bearing fact
is the FCS strip — which neither dv_lead's proof nor my refutation had named.**
The minimum margin is **exactly one cycle** and it is attained twice: at the
witness's own cell, and at `M03-F4`'s. So the green run refutes **at the boundary
of the space**, not somewhere in its interior. That is the strongest form the
refutation could have taken, and it is worth more to the record than my finding
was.

**One thing I deliberately did not do.** §7.3(c)'s arithmetic limb survives
untouched — `RV-0041-VERDICT` §3's stated tightest case still is not a member of
the space it quantifies over. I recorded that as an **observation** and refused to
file it as a smaller finding. The seal said *withdrawn in full*; a seat that
withdraws in full and re-files a fragment under a new number has not withdrawn in
full, and the value of a seal is exactly that it binds the seat that wrote it when
the wind changes.

#### 3. `F-0024-C`, re-graded — and the second defect, which is not the same as the first

The dispatch put it to me that the coverage gap *"stays factually true regardless
of A's withdrawal"* and that its first-ever exercise was the falsifier. **I
checked that rather than adopting it, and both halves are wrong.**

`F-0024-C` was two claims in one row. **Limb 1 — *no unit combines a length ≢ 0
(mod 8) with a following frame* — is false**, and was false when I filed it:
`M03-F4` (`test_m03_f.ml`:684–686, both lanes) drives a 63-octet frame followed by
a 64-octet frame and asserts **exactly one strobe pulse in the whole run**. The
file did not exist at `447d11c` (verified: `git cat-file -t` fails there) and
landed at `8e040f0` ten hours later — **eight days before I filed the row**. §7's
Evidence pinned the measurement to `447d11c` honestly; the **row** then stated an
unbounded present-tense universal over the suite, and a reader acts on rows.
That is `F-0026-B`, and it is a **different** defect from `F-0026-A`: the first is
arithmetic, the second is quantifier discipline. Two defects, one round, one
instrument — which is what makes §8.8's boundary owed rather than ornamental.

Worse for my original claim and better for the program: **`M03-F4`'s lane-0 cell
is at margin 1** — the minimum over the entire legal space, the same margin as my
witness. The suite had a unit in the tightest row for eight days before I said it
had none, and had `D-M3` diverged at margin 0, that unit would have killed it.

**Limb 2 survives and I downgrade it to MINOR.** Re-measured at HEAD: **no
committed unit ever spends DIC credit.** Credit banks only from a length ≢ 0 (mod
4) and is spent only on a later gap, so a shortened gap needs ≥ 3 frames with a
non-final one off the grid; every committed ≥3-frame schedule is 64-octet stress
and every off-grid schedule has at most two frames. So every committed gap is ≥
12, the 9-octet floor is undriven, and the link-partner model implements a
behaviour no schedule asks it to emit.

**The grade moved for reasons I had to be careful about.** The tempting reason —
*the mutant turned out equivalent, so the gap conceals nothing* — is exactly the
reasoning an auditor must refuse: it grades a coverage gap by the accident of what
was seeded through it. I set it aside explicitly and moved the grade on three
other measurements: the tight row **is** driven (`M03-F4`), **no packet
overstates** (`grep -i dic` returns nothing in the `SO-` or the `AP-`, so this is
an unclaimed gap and not a false claim — `PROCESS` §2.1's own distinction), and
`REQ-004`'s named worst case — the alternating-lane 84-octet budget — **is**
driven by the 10 000-frame stress; it is the DIC *shortening*, not the alternation,
that is missing. The cure is exhibited rather than described, and the one thing
genuinely unobserved is named in terms: **the witness schedule has never run
against the unmutated design.**

#### 4. The two cures against my own artefact, and why they are lines and not edits

`J-auditor-0025` resolved `B.5` for 15 FALSE / 8 PLANNED and found `C-117`'s
anchor wrong, and could stage neither. Both are now appended, dated, as **notes**
— never as rewritten cells. The ground is not squeamishness: `docs/PROCESS.md`
§5.4 rules that a frozen record is not repaired by rewriting it, §1.7 lists
**in-place correction by the author** among the weaknesses this program still
owes, and `de85393` — where a findings tally was corrected in place by its author
— is the instance both point at. **A posture list that cured its own arithmetic by
silently editing a cell would reproduce, in the file that measures this program's
honesty, the exact weakness it measures.** For `C-117` the correction runs in the
document's favour and I said so: the document's stamp is right and my citation was
wrong.

#### 5. The two grown referents, and the pin I changed mid-round

`C-104`: re-measured, and it returns **two** corrections rather than one. The
block at `6c02f5b`:890–936 carries **twelve** bullets, not the thirteen my row
says — an off-by-one at the moment of measurement — and at `9362aef` it carries
**fifteen**, the growth being one compressed *known grounds* bullet becoming that
bullet plus three flat ones. The **posture is unchanged and re-executes true**: I
re-ran the no-script-reads-a-tally grep at HEAD (3 hits, all unrelated) and
confirmed `git diff 6c02f5b HEAD -- agents/PROTOCOL.md scripts/ .github/` is
empty.

`C-94`: §3.8's element list grew from six elements to seven, the seventh being the
external anchor's disposition per stimulus class. The document discloses the
growth in its own stamp text — **and the disclosure is the drafting seat's while
the row is mine**, so I re-measured rather than adopted: `SO-xgmii_rx_64.md` §2.3
states the anchor per class with each *"does NOT anchor"* list in the same cell
and declares the module-level anchor **undischarged**, `SC-6` scored MET at all
four read-backs. The row's evidence sentence survives the growth, now over seven
elements.

**The pin changed mid-round and that is a decision, not an accident.** The
dispatch asked for these two notes *against the CURRENT text*. Between the
dispatch and this entry the orchestrator announced a **fifth** edition in flight.
A note that says *current* would have been false within the hour, so both notes
are pinned to the **committed fourth edition at `9362aef`** and say so, with the
command that reproduces them. This is the same failure mode as `F-0026-B` — a
measurement whose pin does not survive into the sentence a reader acts on — and I
would rather apply the lesson in the same round that paid for it.

#### 6. Item 5: SCHEDULED, not folded. The grounds, since the ruling is mine

The full re-measurement of all 128 rows against the fourth edition **does not fit
honestly in this round**, and I decline to fold it in.

1. **Scale.** 5,044 lines against the 1,445 the rows measure — 3.5×. The stamp
   census alone, over the 2,685-line second edition, took a full round with three
   sampling strata. A 128-row re-measurement is a round, not an item.
2. **The target is moving under it.** The fifth edition was commissioned this
   hour. A census pinned to `9362aef` and landing after the fifth edition would be
   a measurement of a superseded edition **at the moment it lands** — precisely my
   own row `C-75`'s decay class, and precisely the defect I am reconciling in this
   same entry.
3. **This round's own lesson forbids it.** The defect I located today is a
   hand-execution that substituted one quantity for another at the end of a long
   derivation. Executing a 128-row census as item 5 of a six-item round is that
   hazard with more surface and less attention.
4. **A rushed census is worse than an owed one.** The dispatch's words; I adopt
   them as the ruling's ground rather than as permission.

**The scheduled round, named and scoped so a skipped one is a visible gap:**

> **`POSTURE-RE-MEASUREMENT-2`** — the second execution of `C-126`'s own
> instruction. **Trigger**: the revision cycle stops moving (an edition committed
> with no further edition commissioned at dispatch time). **Subject**: that
> edition at its SHA. **Scope**: all 128 rows re-measured, plus four classes this
> round shows are stale by construction — (a) every row's line-range citation;
> (b) rows whose **claim text grew**, of which this round found two by accident
> rather than by enumeration (`C-104`, `C-94`), because a grown claim means a
> posture measured over a smaller claim; (c) rows whose claim has **left the
> document**, a class nobody has looked for; (d) claims the third, fourth and
> fifth editions **add**, which have no rows at all. **Deliverable**: a new
> numbered report under `docs/reports/audit/` — the 128-row list stays frozen as
> the measurement of `6c02f5b` that it is. **Preconditions**: none from this
> round; the five appended notes are the interim carrier. **Shape**: one
> dedicated round, no other items.

Note 5 of the appended section says all of this inside the artefact itself, so a
reader of the posture list learns its own staleness from the list rather than from
my journal.

#### 7. Ledger note, no action (dispatch item 6)

Recorded and not acted on: the fourth edition discloses campaign **self-scoring**
per the record, and routes **post-diff auditor scoring** as an **OPTION** (Annex
B.2 item 12). The seats' grounds-on-record answer is separately commissioned. I
note only that I am the seat such an option would bind, and that the question
belongs with the seat that drafted the annex — the same posture I took at
`J-auditor-0024` Open-question 3 on the (b.3) re-derivation limb.

#### 8. The sampling frame, stated so it can be reconstructed

*In the window*: one green CI run and its never-merged branch; five findings of my
own from two rounds ago, one of them CRITICAL; four rows of my own artefact; and
one scope question.

*Sampled whole*: the falsifier commit and its two files; run 31541276523's two
jobs step by step; `xgmii_rx_64.ml`'s five relevant regions; `arrival.ml` entire;
`test_m03_f.ml`'s `run_f4` entire; **every `frames_at` call site in
`test/xgmii_rx_64/**`** — the enumeration `F-0024-C` should have had and did not.

*Re-derived rather than cited*: the consumption cycle, over the whole legal space
(terminate lane × start lane × successor start lane × gap), from `REQ-101`, §0.3's
floor and the three-age record — then checked against the extremal cell the
machine actually ran.

*Deliberately not sampled, and why*: the in-flight fifth edition (a sibling's
uncommitted text is not a read surface); the 122 posture rows outside the four the
dispatch named (that is `POSTURE-RE-MEASUREMENT-2`'s subject, and taking a bite of
it here is the smuggling item 5 forbids); the other nine campaign manifests (no
equivalence exclusion in any of them — `ADR-0020` §6.3's closed set of one);
`F-0022-1`'s five stale renderings, still owed, still not mine to take this round.

### Actions

- Ran the abort-first precheck; re-ran it after HEAD moved `a39c8e7` → `1b684c7`,
  re-verifying every read surface byte-identical.
- Verified run **31541276523** at the GitHub API (run + both jobs, step by step)
  rather than accepting the dispatch's summary; verified `528b045` is
  `d4be71b` + the **unmodified** committed `D-M3.diff` by re-applying the manifest
  and diffing; verified the oracle, the window and the design's immobility.
- Re-executed the `D-M3` derivation step by step against the RTL, located the
  divergence at the consumption cycle, and re-derived the equivalence over the
  whole legal stimulus space.
- Enumerated every `frames_at` call site in `test/xgmii_rx_64/**`, found
  `M03-F4`, dated it at `8e040f0`, and computed its margin.
- Wrote **§8** of `docs/reports/audit/WO-0041-mutations/README.md` as an EOF
  addition; **nothing above it edited**.
- Wrote **§7, five appended dated notes**, at EOF of
  `docs/reports/audit/PROCESS-claims-posture.md`; **no cell above rewritten**.
- Wrote this entry. **No `git commit`, no `git push`, no `git add`, no
  `git apply`** — PROTOCOL §2, §10, ADR-0019. No stop-hook commit demand arrived;
  the standing refusal holds either way.

### Evidence

All at `1b684c7` unless stated. Precheck `2026-08-12T02:34:21Z`: HEAD `a39c8e7`,
`git status --porcelain` empty.

**1. The run, at the API** (`actions/runs/31541276523` and `/jobs`):

```
run 31541276523  workflow build  #625  head_sha 528b045  branch mut/wo-0041-dm3-falsifier
  job build 93943973189  conclusion failure
    5 Build ................................................. success
    6 Run tests (expect tests, waveform snapshots) ........... success
    7 Generate RTL .......................................... success
    8 Verify nothing was left unpromoted or non-deterministic  FAILURE   <- the only red
    9,10 (DV mechanical checks; abort-bit quantifier) ........ skipped
  job cosim 93943973133  conclusion success   (incl. "Run the co-simulation lane")
```

**2. The applied mutation is the committed manifest, unmodified**:

```
$ git show d4be71b:libs/hardcaml_ethernet/src/xgmii_rx_64.ml > base
$ patch -p1 < D-M3.diff ; diff <patched> <(git show 528b045:libs/.../xgmii_rx_64.ml)
(no output)   => IDENTICAL
$ git show --stat 528b045      # 2 files: xgmii_rx_64.ml +15/-2, test_m03_d.ml +26
$ git merge-base --is-ancestor 528b045 HEAD ; echo $?    # 1 -> never merged
```

**3. The design has not moved since the falsifier's base**:

```
$ git diff --stat d4be71b HEAD -- libs/hardcaml_ethernet/src/xgmii_rx_64.ml \
      test/xgmii_rx_64/ test/xgmii/arrival.ml
(empty)
```

**4. The divergence step, at its sources**:

```
xgmii_rx_64.ml:22-27   "the four FCS octets ... may lie in the input word AFTER the one
                        carrying the octets of output word m ... the FCS is removed by
                        [tkeep] and never by holding octets back"
xgmii_rx_64.ml:46      "Output word m leaves on cycle m + 3"
xgmii_rx_64.ml:949-950 "the `tlast` word is released by [closure_aligned] on the cycle
                        after the terminate word, its record then at age 1"
xgmii_rx_64.ml:977     consume <== (sel_valid &: (emit_tlast |: sel_is_r2))
test_m03_f.ml:695-697  let delivered0 = 63 - 4 in
                       let words0 = (delivered0 + 7) / 8 in
                       let expected_tlast_cycle0 = start_cycle0 + 3 + (words0 - 1) in
```

Witness frame 1, `L` = 65 at a lane-0 start, start word 12: **hand-executed**
⌈65/8⌉ = 9 words, `m` = 8, `tlast` = 23. **Design** ⌈61/8⌉ = 8 words, `m` = 7,
`tlast` = **22**. `crc_reg(22)` = `crc_final(21)` = residue → no strobe.
`begins(22)` → `crc_reg(23)` = 0, one cycle late.

**5. The corrected equivalence, and the margin**: divergence requires `B + 1 ≤ T`
with `T ≤ C + 2`, `T = C + 2` only for terminate lane ≥ 5, and `B = C + 1` only
for successor start lane ≥ `t + 1` ≥ 6 — excluded by `REQ-101` (`s ∈ {0,4}`).
Minimum margin **1 cycle**, attained at the witness cell (`t` = 1, `G` = 11:
`T` = `B` = 22) and at `M03-F4` lane 0 (`t` = 7, `G` = 13: `T` = `B` = 11).

**6. `F-0024-C` limb 1 is false, with dates**:

```
$ git cat-file -t 447d11c:test/xgmii_rx_64/test_m03_f.ml
fatal: ... exists on disk, but not in '447d11c'
$ git log -S'octets63' --format='%h %ci' -- test/xgmii_rx_64/test_m03_f.ml
8e040f0 2026-08-03 15:13:06 +0000        # 447d11c is 2026-08-03 05:22:29 +0000
$ git diff --stat 447d11c HEAD -- test/xgmii_rx_64/test_m03_f.ml   # 826 insertions
test_m03_f.ml:684-686  frames_at ~lane ~fcs_valid:true [ octets63; octets64 ]
test_m03_f.ml:753-767  exactly one strobe pulse asserted in the whole run
```

**7. Limb 2, re-measured at HEAD**: every `frames_at` site enumerated. ≥3-frame
schedules are 64-octet only (`test_m03_l.ml`:78 · 10 000; `test_m03_j.ml`:83 ·
101; `test_m03_n.ml`:1037–1047); off-grid lengths appear only in 2-frame
schedules (`_f`:686 · 63+64, `_e`:527 · 64+68, `_i`:1109 · 64+68). Credit banks
from a length ≢ 0 (mod 4) and is spent on a **later** gap (`arrival.ml`:56–59), so
`shorten` = 0 everywhere. `grep -i dic agents/handoffs/SO-xgmii_rx_64.md
test/attack_plans/AP-xgmii_rx_64.md` → **no hits**.

**8. The four posture rows**:

```
$ git show 6c02f5b:docs/PROCESS.md | sed -n '890,936p' | grep -c '^- \*\*'   -> 12   (row says 13)
$ git show 9362aef:docs/PROCESS.md | sed -n '2964,3054p' | grep -c '^- \*\*' -> 15
$ git diff 6c02f5b HEAD -- agents/PROTOCOL.md scripts/ .github/              -> empty
$ grep -rniE 'seeded|sealed|mutat|unreachab|equivalen|kill|tally|denominator|floor' \
      scripts/ .github/ | wc -l                                              -> 3 (all unrelated)
9362aef:docs/PROCESS.md:2733-2739   the 7th element (external anchor per class)
SO-xgmii_rx_64.md:1047-1089, :281, :352, :512   the packet carries it; SC-6 MET x4
v02.md:1181 -> inside J-architect_docs_lead-0025 (2026-08-04, BUG-0002)  [wrong anchor]
v05.md:684  -> J-architect_docs_lead-0047 (2026-08-11T19:34Z), 6-row table, row 6 STOPPED
B.5 recount: MC 34, RE 44, P1 26, PLANNED 8, FALSE 15, NOT SAMPLED 1 = 128
```

**9. Mandatory charter §5/§9 checks**: **write scope** — the two files below are
both under `docs/reports/audit/**` and nothing else was written; **append-only in
fact** — `git diff --stat docs/reports/audit/` shows `484 insertions(+)` and
**zero deletions**, hunks `@@ -429,0 +430,162 @@` and `@@ -950,0 +951,322 @@`,
i.e. pure EOF additions to both files; **no repo operation** — no `git commit`,
`push`, `add` or `apply`.

**Labelled as construction, not measurement**: the severity grades at §8.7 and the
boundary at §8.8 are **constructions** — judgements about how a defect should bind
this seat — not measurements. They bind my practice and nothing else. §8.4's
derivation is a construction that has been **confirmed at one cell** by machine and
nowhere else; I do not claim it is machine-checked over the space.

**Harvest**: **not owed at this round.** PROTOCOL §7 and charter §8 attach the note
to an `SO-` or a phase gate and this round is neither. My last harvest was
`J-auditor-0019` over `-0001 … -0018`; the span `-0019 … -0026` tiles onto it and
stays open. **One candidate is banked for it in the artefact rather than here**
(§8.8, `LH2-g` grade, incident commits `d4be71b`/`528b045` and run 31541276523),
so a later harvest finds it written rather than remembered.

### Outcome

**DoD met on all six dispatch items.**

1. **The divergence step is located**: the drain rule instantiated with the
   frame's **received** octet count where the design uses its **delivered** count
   — `m` = 8 instead of 7, consumption at 23 instead of 22, one cycle, in a claim
   whose entire content was one cycle.
2. **`F-0024-A` — WITHDRAWN IN FULL**, by its own sealed term, after independent
   verification of the run and four non-vacuity checks. **`F-0024-B` and
   `F-0024-E` fall with it** (both were conditioned on A standing): `WO-0041` is
   **5 of 5**, the era figure **15 of 15** stands, and nothing is owed by dv_lead
   or the orchestrator on their account. **`F-0021-4` is REINSTATED** and
   `J-auditor-0024`'s withdrawal of `J-auditor-0021` §9's sentence is itself
   **withdrawn** — the exclusion does stand on its own merits.
3. **`F-0024-C` re-graded by splitting**: limb 1 **withdrawn as false**
   (`M03-F4`, in the tree eight days before I filed the row, and at the tightest
   margin in the space); limb 2 **re-measured and downgraded to MINOR** as
   `F-0026-C`, on grounds that deliberately exclude *"the mutant was equivalent"*.
4. **Three findings filed, two of them against my own seat**: `F-0026-A` MAJOR
   (the false CRITICAL's located arithmetic defect), `F-0026-B` MAJOR (an
   unbounded universal from a partial enumeration at a superseded SHA),
   `F-0026-C` MINOR (dv_lead, the undriven DIC class). **No CRITICAL is open from
   this seat. Nothing here blocks a gate; the withdrawal releases one.**
5. **Five appended dated notes** on `PROCESS-claims-posture.md`: `C-126`'s
   figures (15/8, not 12/4), `C-117`'s anchor (`J-architect_docs_lead-0047`,
   `v05`:684), `C-104` (twelve at the audited SHA, not thirteen; fifteen at
   `9362aef`; posture unchanged and re-executed), `C-94` (seven elements now, and
   the packet carries the seventh), and Note 5 declaring the list's own staleness.
6. **Item 5 ruled: SCHEDULED, not folded** — `POSTURE-RE-MEASUREMENT-2`, scoped
   above, triggered when the revision cycle stops moving.

**The transcribable act, for the orchestrator to carry verbatim under ADR-0003's
exception:**

> **WITHDRAWAL — auditor, `F-0024-A` (CRITICAL, E4), WITHDRAWN IN FULL.** The
> finding sealed its own falsifier — the unmodified `D-M3.diff` against
> `frames_at ~lane:0 [f65; f65; f65]`, *withdrawn in full if that run is green*.
> Run **31541276523** on `mut/wo-0041-dm3-falsifier` (`528b045`, never merged) is
> green on the witness: **Build, Run-tests and Generate-RTL all `success`**, the
> `cosim` job `success`, and the only red the snapshot check that is red for any
> mutated tree by construction. **Verified at source, not adopted**: the applied
> RTL is byte-identical to the committed manifest, the oracle is the one a dozen
> M03 units use to assert strobes that do fire, the driven window contains the
> predicted cycle by twelve cycles, and the design has not moved since the
> falsifier's base. **The equivalence proof's conclusion is correct and `D-M3` is
> an equivalent mutant over the specification's legal stimulus space** — a result
> this seat has now re-derived independently, with the load-bearing fact being the
> `REQ-103` FCS strip, which no version of the proof had named. **`WO-0041` is 5
> of 5 and the era figure 15 of 15 stands. `F-0024-B` and `F-0024-E` are withdrawn
> with it; `SO-xgmii_rx_64.md` and `P1-module-ready-checklist.md` are released and
> owe nothing.** **My derivation was defective at one located step** — the drain
> rule instantiated from the frame's received octet count where the design uses
> its delivered count, one cycle, in a claim whose whole content was one cycle —
> and it is filed against this seat as `F-0026-A` (MAJOR), with `F-0026-B` (MAJOR)
> for a second, different defect found in the same round. **The method now carries
> a boundary**: a hand-executed cycle-level derivation may not carry a severity
> above MINOR while its conclusion turns on a margin no larger than the pipeline's
> own quantum — below that, it is a hypothesis with a named falsifier, and the
> falsifier runs before the severity is assigned.

**Handoff**: to the orchestrator for commit. Trailers `Agent: auditor`,
`Work-Order: none`, `Journal-Entry: J-auditor-0026`; **not** journal-only — two
work-product paths staged, both inside `docs/reports/audit/**` (`R7`), both pure
EOF appends. No rotation (ADR-0017 §4.4 arithmetic above).

### Open-questions

1. **The finding was wrong for eleven hours and the machinery that caught it was
   my own seal, not another seat's review.** No one reviewed `F-0024-A` between
   filing and execution; the orchestrator executed the falsifier the finding named
   and the result did the work. That is the design working — but it means the
   program's defence against a bad auditor finding is currently *the auditor's own
   discipline in sealing falsifiers*, which is a compensating control resting on
   the seat it compensates for. I raise it without proposing text; I am the seat
   any remedy would bind.
2. **`F-0026-C` leaves one thing genuinely unobserved and nobody is commissioned
   for it**: the witness schedule has run only against the **mutated** tree. The
   unmutated design has never been driven at a DIC-shortened gap. One unit in
   dv_lead's scope closes it; the exact text exists at
   `528b045:test/xgmii_rx_64/test_m03_d.ml` and cannot be lifted by me
   (`test/**` is not my scope).
3. **Two defects in one round from one instrument is a rate, and a rate needs a
   denominator I have not built.** Charter §6 item 7 asks whether repeat findings
   of the same class decrease phase over phase. `F-0024-D` and `F-0026-A` are the
   same class one round apart. Whether §8.8's boundary is working is not knowable
   from inside the round that wrote it, and the next seat to audit this seat should
   test it against the next cycle-level derivation I file rather than against my
   statement that I now hold it.
4. **`POSTURE-RE-MEASUREMENT-2` has a trigger nobody owns.** *"The revision cycle
   stops moving"* is observable but unassigned: the fifth edition is commissioned,
   a sixth may be, and this seat is not told when a cycle closes. If the round is
   never dispatched, the posture list stays a frozen measurement of `6c02f5b` with
   an appended note saying so — which is honest, and is not the same as current.

### Files-in-this-commit
- docs/reports/audit/PROCESS-claims-posture.md
- docs/reports/audit/WO-0041-mutations/README.md

## [J-auditor-0027] 2026-08-12T09:03Z | task:WO-0084 | Thirteen genuine M04 transmit defects seeded BLIND against the frozen seal — one clean `.diff` per class, all applying at 9dba6d5, none matched to a prediction I never read

### Trigger
Orchestrator dispatch, WO-0084 act 2 (the seeding). The seal is frozen (dv_lead
`J-dv_lead-0195`, committed `9dba6d5`); I seed the defects that test the M04 suite's
kill claims **without** knowing what the seal predicts. Commission:
`agents/handoffs/WO-0084_m04-mutation-campaign.md`.

### Inputs
- `agents/charters/auditor.md`, `agents/PROTOCOL.md` — mandatory first reads.
- `agents/handoffs/WO-0084_m04-mutation-campaign.md` — my packet, in full,
  including the act-1 Return-log line that tells me the *fact* of the seal and its
  §0.1 step-6 rule (a property of the base state, not a prediction).
- `libs/hardcaml_ethernet/src/xgmii_tx_64.ml` at `9dba6d5` — the mutation target,
  all 434 lines.
- `docs/specs/modules/xgmii_tx_64.md` (SPEC-M04), in full — the requirements the
  defects violate.
- `test/attack_plans/AP-xgmii_tx_64.md` §0–§4 — the **public** Kills-claim TEXT of
  the discharged ASSERT rows (families A–K read; A–G are the discharged set the
  seal names). The predictions are not public and were not sought.
- `docs/reports/audit/WO-0077-mutations/README.md` head — my own prior campaign, for
  form only.
- My own journal `agents/journals/claude_auditor_agent.v03.md` — the entry-id chain.
- **NOT READ, ATTESTED**: `agents/handoffs/WO-0084-SEALED-predictions.md` (the seal)
  and `agents/journals/claude_dv_lead_agent.v12.md` incl. `J-dv_lead-0195` (its
  second copy) — never opened, grepped, `git show`n, counted or diff-statted; and
  **all of `test/xgmii_tx_64/**`** — the bench never read. The blind held.

### Reasoning
The campaign tests whether the M04 suite kills a *real* defect of each class its
discharged rows CLAIM to kill. So I derived my class set from two public sources —
SPEC-M04's requirements and the AP rows' Kills cells — and from nothing else. The
packet warned me off dv's partition explicitly (*"you do not know dv's exact
partition and must not try to match it … a mismatch … is itself data act 4 will
reconcile"*), so I did not reverse-engineer toward thirteen; I picked the cleanest
**genuine** representative of each distinct defect class the discharged families name
and thirteen fell out, which I record as a coincidence of independent derivation and
not an alignment. Families are seeded non-uniformly on purpose: C names three
distinct wrong designs (pad-target, pad-value, CRC-coverage), E and F and G two each,
A/B/D fewer, so the manifest mirrors the *defect space* the rows describe, not a
per-family quota.

Two disciplines governed every choice. First, **genuineness over cleverness**: each
seed had to be a real REQ violation with a port-observable consequence, so no
equivalent mutant slips in as a false survivor. I deliberately rejected the pad
predicate `>=+ → >+` flip (C2's off-by-one site) precisely because both branches
yield 60 at equality — it is an equivalent mutant at the boundary — and seeded the
pad-target `60 → 64` (C1) instead, which is genuinely distinguishable. `class-11`
(gap ignores `cfg_ifg`, hard-wired 12) is genuine but **conditional**, and I said so
in the manifest and here: it is byte-identical to a conformant M04 at the default
gap and diverges only when the bench drives `cfg_ifg ∈ {20, 255}` (F3's own
members) — which makes it a sharp test of whether the suite *varies* the gap
configuration at all. Second, **type-correctness**, so the compiler is never the
instrument: every substitution keeps signal width and type (`gnd/vdd`, `zero 8/ones
8`, `d_pad/d_payload`, same-width `of_int`), so each mutated module compiles and the
**test suite** is what must catch it.

Classes considered and **not** seeded, with the ground: the two-word-preamble /
frame-rotation defect (A2) and the "FCS always on a word boundary" defect (D4) are
structural, not clean single-site genuine mutations at this composition model, so
they were left for a campaign that can render them faithfully; the CRC-seeded-late
defect (D3) collapses into "wrong FCS", which `class-07` (byte-reversal) already
represents as the canonical distinct REQ-202 wire-order class; and families H/I/J/K
(cadence-12, per-octet latency, config-sampling) sit outside the discharged A–G set
this round attacks, so I did not seed into them.

The base-SHA subtlety mattered and I checked it rather than assumed it: the seal
freezes against `6d92bf9` but my dispatch and HEAD are `9dba6d5`. I verified the
module is byte-identical across `6d92bf9`, `91f005d` and `9dba6d5`
(`git diff … -- libs/hardcaml_ethernet/src/xgmii_tx_64.ml` empty both ways), so a
diff that applies at `9dba6d5` applies at the ref act 3 cuts from the seal base.

### Actions
- Authored `docs/reports/audit/WO-0084-mutations/README.md` — the manifest: blind
  attestation, base SHA and its byte-identity proof, the thirteen-class table (REQ,
  public AP row tested, RTL site, injected defect), the genuineness note per class,
  and the operator apply command. Stated it carries no scores.
- Authored thirteen unified diffs `class-01 … class-13`, one per class, generated in
  the scratchpad against a copy of the module (the tracked RTL in the tree was never
  edited — I render diffs as files), each anchored on a string verified **unique**
  in the module.
- Did **not** cut any `mut/` ref, did **not** run any diff, staged nothing, ran no
  `git commit`/`push` — that is act 3's (the operator's) and I return for commit.

### Evidence
Reproducible at `9dba6d5` (HEAD; tree clean):
- Base identity: `git diff 6d92bf9 9dba6d5 -- libs/hardcaml_ethernet/src/xgmii_tx_64.ml`
  → empty; `git diff 91f005d 9dba6d5 -- …` → empty.
- Applicability (read-only, tree never modified): for each
  `docs/reports/audit/WO-0084-mutations/class-*.diff`, `git apply --check <diff>`
  exits 0 — all thirteen OK, observed in this session.
- Uniqueness: each diff's `old` anchor occurs exactly once in the module (the
  generator refused any anchor with count ≠ 1; all thirteen wrote successfully).
- Type-correctness: verified by inspection per class — every substitution preserves
  `Signal` width / `int` type (recorded in manifest §4).
- The thirteen classes and their sites are in the manifest table; not restated here.

### Outcome
DoD (packet act 2) **met**: a defect manifest under
`docs/reports/audit/WO-0084-mutations/` — a README plus one clean unified `.diff`
per class against `libs/hardcaml_ethernet/src/xgmii_tx_64.ml` at base `9dba6d5`,
every diff verified to apply. Thirteen classes across the discharged families A–G,
derived from SPEC-M04 and the AP's public claims, blind to the seal. Handoff: to the
orchestrator for commit (act 3 cuts the refs and runs; act 4 scores against the
seal). Trailers `Agent: auditor`, `Work-Order: WO-0084`,
`Journal-Entry: J-auditor-0027`; **not** journal-only — fourteen work-product paths
staged, all inside `docs/reports/audit/**` (`R7`), all pure EOF appends / new files.

**Harvest note (ADR-0018, PROTOCOL §7).** A lessons harvest is owed at each `SO-`
and each phase gate; this act-2 seeding round is neither, so no harvest is
discharged here. Span carried open from `J-auditor-0024` (last harvest boundary) and
this entry `J-auditor-0027` is inside it — the interval tiles forward to the next
`SO-`/gate round, where the M04 campaign's own lessons (the equivalent-mutant
rejection at the C2 site; the conditional `class-11` seed as a config-variation
probe) are candidates. Nil yield **declared for this round**, not omitted.

### Open-questions
1. **`class-11` predicts a coverage question, not only a defect.** It survives a
   suite that never drives `cfg_ifg` off its default — which would be a real gap in
   REQ-802/REQ-204 coverage, not a defect in the seed. If act 4 scores it a
   survivor, the disposition is a coverage finding against the suite, and the
   survivor-evidence form should record that the seed is conformant at `ifg = 12`
   by construction. I flag it now so a `survive` is read correctly and not as a
   miss on my side.
2. **My thirteen and dv's thirteen may not be the same thirteen.** The count
   coincides; the partition is independent and I did not seek to align it. Act 4
   reconciles the two two-column records; a class of mine with no dv counterpart
   (or the reverse) is data about the partition, not a fault in either seat, and I
   record that I expect the reconciliation rather than a clean one-to-one.
3. **Discharged-set boundary is dv's to confirm, not mine to observe.** I seeded
   against families A–G on the packet's word that they are the discharged set; I did
   not read the bench to confirm which rows are actually mounted. If a seed lands on
   a row that is claimed-discharged but in fact unbenched, it survives — again a
   finding about the suite, surfaced by act 4, not a seeding error. The blind is
   what forbids me the check that would have told me in advance.

### Files-in-this-commit
- docs/reports/audit/WO-0084-mutations/README.md
- docs/reports/audit/WO-0084-mutations/class-01-preamble-txc.diff
- docs/reports/audit/WO-0084-mutations/class-02-frame-lane-reversal.diff
- docs/reports/audit/WO-0084-mutations/class-03-tkeep-ignored.diff
- docs/reports/audit/WO-0084-mutations/class-04-pad-target-64.diff
- docs/reports/audit/WO-0084-mutations/class-05-pad-value-nonzero.diff
- docs/reports/audit/WO-0084-mutations/class-06-crc-omits-pad.diff
- docs/reports/audit/WO-0084-mutations/class-07-fcs-byte-reversed.diff
- docs/reports/audit/WO-0084-mutations/class-08-terminate-lane-late.diff
- docs/reports/audit/WO-0084-mutations/class-09-idle-fill-value.diff
- docs/reports/audit/WO-0084-mutations/class-10-gap-no-roundup.diff
- docs/reports/audit/WO-0084-mutations/class-11-gap-ignores-ifg.diff
- docs/reports/audit/WO-0084-mutations/class-12-underflow-qualifier-dropped.diff
- docs/reports/audit/WO-0084-mutations/class-13-abort-word-swapped.diff
