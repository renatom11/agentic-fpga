# Journal: claude_dv_lead_agent — volume 11

- **Agent**: dv_lead (Opus 5 lead)
- **Charter**: agents/charters/dv_lead.md
- **Format**: v1 — entry grammar in agents/PROTOCOL.md §4
- **Volume**: 11
- **Continues-from**: J-dv_lead-0186
- **Previous-volume**: agents/journals/claude_dv_lead_agent.v10.md
- **Previous-volume-sha256**: ee441697dab3696924090feb08742249952c432791c014b27b8c91975770ae75
- **Previous-volume-bytes**: 288336

This file is APPEND-ONLY. Content may only ever be added after the last line;
nothing above it is ever edited. Enforced by scripts/agent_commit.sh and CI.
Volume 10 is FROZEN: it is never appended to again, and any change to it breaks
this file's Previous-volume-sha256.

---

## [J-dv_lead-0187] 2026-08-11T20:23Z | task:none | The rotation opened and the three named debts paid in the artifacts that carry them — two provenance corrections annotated beside the sentences they convict, and REC-7's disposition table measured rather than asserted: thirty classes, twenty-eight frozen kills, twenty-eight mappings, zero disposition failures, and the green half named as still owed

### Trigger

Orchestrator dispatch, **one round, three acts, every one of them a debt I named
against my own seat and carried deliberately** rather than paid on a round whose
permissions did not reach the artifacts: the **ADR-0017 rotation to volume 11**;
**`FINDING REC-1`** and **`FINDING REC-2`**, the two MINOR provenance corrections
filed at `J-dv_lead-0184` and carried at `J-dv_lead-0186` item 5 with their carrier
named as *"the next round that opens `agents/handoffs/` for me"*; and
**`FINDING REC-7`** (MAJOR), the disposition table owed at `J-dv_lead-0186`
Open-question 4. **This is that carrier**, and the dispatch opens exactly the two
packets the corrections live in.

**Abort-first head check, before reading anything.**

    git status --short              # zero lines
    git rev-parse HEAD              # 49f04c0f5a9d63154919dd5631b45f03ece711bf
    git rev-parse --abbrev-ref HEAD # claude/fpga-hardcaml-agent-orchestration-37ceyf

Byte-equal to the dispatched expectation `49f04c0`, tree clean. **Neither branch of
the abort procedure was reached.** **HEAD did not move across the round** —
re-verified at authoring time, still `49f04c0` — and the chain values in the header
above were taken from `git show HEAD:` at that re-verification, not from disk alone,
with the two agreeing.

**The declared sibling fired mid-round, and it lands squarely inside its declared
lane.** At my closing check the tree carried one dirty path that is not mine:
`docs/reports/audit/WO-0041-mutations/README.md`. The dispatch declares the auditor
live on a parallel round scoped to *"its journal + `docs/reports/audit/**` only"*, and
that path is the auditor's **exclusive** scope under PROTOCOL §6 and ADR-0003 — it is
also, by name, `ADR-0020` §10 item 4's owed act, the `D-M3` equivalence exclusion
recorded in the seeder's own artefact. **So it is a sibling discharging a named debt,
not an anomaly**, and the dispatch's rule is to proceed. I record it rather than let
a later reader find an unexplained third path in the round's working tree, and I note
what it does **not** do: it touches nothing §2.2-D reads — the four `T-`-era campaign
packets, the bench at five trees, and `tasks/BOARD.md` are all byte-unchanged, and
`WO-0041` is a **pre-class-era** campaign outside the ten this table spans. **My
`Files-in-this-commit` excludes it**; under `R1` it is the auditor's own commit,
never mine.

### Inputs

- `agents/charters/dv_lead.md`; `agents/PROTOCOL.md` — §3 (packet classes and the
  numbering rule, which decides §2.2-D.1 ground 3), §4 (entry grammar), §5 (`R2`,
  `R3`, `R5`, `R10`), **§6 (the write-scope table, which decides §2.2-D.1 ground 2)**,
  §7's **Mutation record** with `(b.1)`–`(b.4)` as amended and in force, §10.
- `docs/adr/ADR-0017-a-journal-is-a-chain-not-a-file.md` §4.3 (the five header
  fields), §4.4 (the four-step rotation), §5 (`S` and `H`), §6.3 (`Continues-from`
  equality), §6.5 (what a green chain does and does not certify).
- `docs/adr/ADR-0020-the-gate-asks-the-suite-not-the-scoreboard.md` §10 (the owed-acts
  list — **item 2 is the form my table borrows and item 2's file is not mine**), §6.6
  (the frozen-kill limb as adopted).
- `agents/journals/claude_dv_lead_agent.v10.md` — `J-dv_lead-0184` (the
  reconciliation and the three findings, read in full), `J-dv_lead-0186` (`REC-7`'s
  two statements of itself, the plural-naming construction, Open-question 4's
  routing).
- **The four `T-`-era campaign packets, read at their verdicts rather than recalled**:
  `WO-0050_family-f-mutation-campaign.md` (§0–§7 of `RV-0050-VERDICT`),
  `WO-0055_family-g-mutation-campaign.md` (subject line, §1–§4),
  `WO-0058_m03-g7-h-mutation-campaign.md` (§1's scope table, §1–§7 of the verdict),
  `WO-0061_family-i-mutation-campaign.md` (§1's scope table, §1, §5, §11).
- The six non-`T-` campaign packets, **read only for the namespace measurement**:
  `WO-0063B`, `WO-0066`, `WO-0073`, `WO-0074`, `WO-0076`, `WO-0077`.
- `agents/handoffs/SO-xgmii_rx_64.md` §2.2-M; `tasks/BOARD.md` at `33871b8`.
- **The bench, at five trees**: `test/xgmii_rx_64/**` at `49f04c0` and at the four
  campaign base SHAs `616686f`, `2e8994f`, `a2d090d`, `42b9df3`, read through
  `git show` for its `let%expect_test` heads only.
- **No RTL source read, for any purpose.** This round did not open
  `libs/**` at all — not as identity evidence, not as anything. The one prior
  disclosure (`J-dv_lead-0184`'s 64 mutation hunks) is not cited by anything here,
  and §2.2-D rests on bench labels and committed verdicts exclusively.

### Reasoning

**ACT 0 — the rotation, and the one number in it that had to be re-measured rather
than carried.** `R10` warned at `6019846`; v10 closed at **288,336 bytes**, over `S`
(262,144) and well under `H` (524,288). ADR-0017 §4.4's four steps are mechanical, so
the only thing worth reasoning about is the failure mode I recorded against myself at
`J-dv_lead-0186` Open-question 7: **my pre-write fit test passed and the entry
crossed the soft ceiling by 26,192 bytes anyway.** The fit test was falsified by its
own subject. I therefore did not re-run it and did not use it to argue that v10 could
take one more entry — **the rotation is unconditional this round**, which is also
what the dispatch ordered. The chain values are taken from `git show
HEAD:agents/journals/claude_dv_lead_agent.v10.md` piped to `sha256sum` and `wc -c`,
**not** from the working file, and the two were then compared and agree; v10 is
**untouched and unstaged**, which §6.4's frozen-volume rule requires and which
`verify_journal_chain.sh` will read.

**ACT 1 — `REC-1`, and why the cure is an annotation and not an edit.** §2.2-M's
method sentence claims the tally *"is re-derived by walking the campaign verdicts,
never quoted from the last one"*, and the table's own first row — the 41 — is
quoted, from `WO-0074` §12, which quotes it in turn. **The sentence is false of the
row directly beneath it.** The temptation is to fix the sentence, and it is the wrong
move twice over: §2.2-M is a **measured block at `2183d71`**, and this packet's own
practice — six dated annotations already in it — is that a measurement stands and its
correction is written beside it. **Rewriting the sentence would erase the fact that
the packet once claimed a method it had not performed**, which is exactly the
provenance-laundering the finding is about. So the sentence stands unedited and the
annotation convicts it, carries the arithmetic that *was* performed at
`J-dv_lead-0184` (`8+5+7+9+1+6+5 = 41` sealed, `8+4+7+9+1+6+5 = 40` killed), and says
plainly that **no column moves** — the figure was correct all along and only the
method claim overreached.

**ACT 2 — `REC-2`, re-verified at the source before I would write it.** I did not
carry my own finding's facts from `J-dv_lead-0184`; I re-measured all three:
`WO-0073`'s packet has **no** `Era tally` or `Program tally` section (case-insensitive
search, zero hits) and contains the string `41 sealed` **zero** times; `git log
-S'41 sealed' --reverse` over `tasks/BOARD.md` and `agents/handoffs/` returns
**`33871b8` first** — `tasks/BOARD.md`, `Agent: orchestrator`,
`Journal-Entry: J-orchestrator-0215` — **and `70cf13c` second**, which is `WO-0074`'s
own landing. The claim reproduces exactly and the annotation quotes the board's
sentence verbatim so the credit is legible without a second lookup. **A dv figure
sourced to a dv packet that does not carry it is a small thing that produces a large
one**: the next reader walks to `WO-0073`, finds nothing, and cannot tell a missing
record from a mis-citation.

**ACT 3 — the disposition table. What the cure had to be, before deciding where it
goes.** `REC-7` is mine, filed against a limb I myself offered and which both
constrained parties have now signed under. Its measurement stands: `T-F2`, `T-I4`,
`T-G7`, `T-E5`, `T-C4` return **zero** occurrences under `test/` while their `M03-`
counterparts are present in force, so a **literal** application of *"the named killing
unit, present and green at the gate SHA"* fails at every class of `WO-0050`,
`WO-0055`, `WO-0058` and `WO-0061`. The hazard is not the failure — it is what the
relay did instead: **it reported `M03-F2` present where the record names `T-F2`, so
the mapping was performed silently, by the seat least likely to get it wrong, and is
invisible in the artefact.** A cure that consisted of me asserting the namespaces
correspond would reproduce that defect one level up, in a document rather than a
relay. **So the table's whole design question is: what makes the mapping checkable by
someone who does not trust me?**

**The answer I built to, and it decided the structure.** Three grades of evidence,
strongest first, each row carrying its own:

- **`E1` — the record maps itself.** The bench emits its failure messages in the
  `M03-` namespace, so a campaign packet that quotes its own observed output *contains
  both names for the same class*. `WO-0050` §2 quotes all four of `F-c1`'s messages;
  §4 and §5 and §6 do the same for `F-c3`/`F-c5`/`F-c6`, `F-c4`, `F-c7`, `F-c8`.
  **Nine rows are pure `E1`, and on those rows I perform nothing at all**; three more
  (`F-c2`, `GH-c1`, `GH-c3`) carry an `E1` component.
- **`E2` — the record maps itself one level wider.** `WO-0058` §1 and `WO-0061` §1
  publish scope tables naming the scored units `M03-…` **with their files and rows**,
  while the same packets' scorecards score them as `T-…`; `WO-0055`'s subject line
  names *"rows M03-G1, G2, G3, G4, G6"* and its scorecard scores *"all five G rows"*.
  **Fourteen rows are pure `E2`.**
- **`E3` — the bench registry**, for the handful of units no packet names in the
  present namespace. **An `E3` component appears on exactly two rows**: `G-c2` (for
  `T-C3`) and `F-c2` (for its three composites and four family-A/B/D units).
- **`D` — derived**, exactly once, at `I-c10`.

**9 + 14 + 3 + 1 + 1 = 28**, and the mixed rows are counted once each — the split is
stated because a grade distribution is the first thing an adversary should recompute.

**And two measurements that carry the whole rule, because grades alone would still be
me reading labels.** The first kills the ambiguity: **the `T-` namespace is not a
bench namespace at this tree at all** — zero `"T-` string literals under `test/`, zero
`let%expect_test` heads beginning `T-`. There is only one live namespace, so no
mapping can be a collision. I also chased the three `T-` strings that *do* survive
under `test/` before claiming zero, because a careless grep returns them: all are
historical prose (the attack plan's change log, one comment at
`test_m03_i.ml:574` quoting `WO-0061`), none is a unit label, and I recorded them in
the annotation rather than letting a later reader find them and think the measurement
was sloppy.

**The second is the one I would not have thought to take, and it is the strongest
thing in the section.** A namespace mapping is a claim about **populations**, not
spelling — so I enumerated the `let%expect_test` heads from the tree at each
campaign's own base SHA and compared them against that campaign's own declared M03
denominator:

| base | heads | the campaign's own figure |
|---|---|---|
| `616686f` | **20** | *"a frozen matrix of 21 REQUIRED and 139 MUST-STAY-GREEN over 20 units"* |
| `2e8994f` | **25** | 5 red + 20/20 MUST-STAY-GREEN |
| `a2d090d` | **31** | *"M03-H4 alone out of all 31 M03 units"* |
| `42b9df3` | **36** (35 `M03-`-labelled) | I-c10's 35-cell REQUIRED set |

**Four campaigns, four exact reconciliations, no residue.** The set the record scores
in `T-` names and the set the tree carries in `M03-` names are demonstrably the same
set at every base. That is a fact about the trees, checkable by anyone, and it is what
promotes the mapping from a plausible reading of two label schemes to a measurement.

**`I-c10` is the one derived row and I am flagging it rather than smoothing it.** The
record names a **35-cell** REQUIRED set and names only the **seven greens**
individually (`T-C4, T-E1, T-E2, T-E5, T-F1, T-F2, T-F3`, §11), so the killing units
are the complement and must be computed. The derivation is: enumerate the `M03-` heads
at `42b9df3`, subtract those seven. **Two independent checks and both are exact** —
the enumeration returns **35**, matching the record's cell count, and `35 − 7 = 28`,
matching the record's *"28 red, 7 green"*. Two arithmetics that were free to disagree
and did not. **I still wrote it as `D` and attached the falsifier**: if the 35-cell
set is ever shown to be a different population, that row is a **disposition failure
until re-derived**. The alternative — presenting a computed set in the same column as
twenty-seven transcribed ones — is precisely the silent-mapping defect `REC-7` exists
to convict, committed by its own cure.

**The plural naming, and the shape that vindicates the withdrawal of my C3.** The
column is written to the construction both constrained parties signed under — *the
record's own naming, plural where the record is plural, never a gate-time selection*.
Sorting the twenty-eight by shape produced something I had not anticipated and which
is the best argument for that construction I have: **three rows are plural-sealed and
singular-killed** — `F-c8` (1 of 3), `GH-c4` (1 of 2), `I-c8` (1 of 2). **Under C3
those three would each have required a gate-time pick from a set the campaign never
ranked.** Under the adopted reading the killing unit and the sealed-but-green cells
are both named side by side and the `R→G` cell is never folded into the kill. **C3
was withdrawn on `WO-0050`'s table; these three rows are what it would have cost had
it stood**, and all three greens are falsified seal predictions of my own, standing
unedited in their SEALED files, which is where they belong.

**Where the table lives — named, with the ground for each option I did not take.**
Three candidates were put to me and I take the first with reasons rather than
preference. **It lives in `SO-xgmii_rx_64.md`, immediately beneath the tally it
disposes**, as new §2.2-D. `(b.1)` and `(b.2)` require the itemisation **at the
tally** — a movement I signed for at `J-dv_lead-0186` on the ground that it aligns the
list's closing sentence with its operative one — and a disposition table filed away
from its tally is the split that clause was redrafted to forbid. **A
`docs/reports/audit/` table was never mine to write**: PROTOCOL §6 and ADR-0003 give
that path to the auditor **exclusively**, and I recorded that ground in the section
itself rather than let the option read as declined on taste. **A new handoffs file**
would need a packet prefix and an orchestrator-allocated number (§3) for content that
is one column of an existing section — buying a filename at the cost of the adjacency
that makes the column readable. **No file outside `agents/handoffs/**` and my own
journal was needed, so no confirmation was owed and none was sought**, which is the
dispatch's own condition read literally.

**What I refused to write, and this is the part a reader should check hardest.**
`(b.2)`'s limb is *present **and green** at the gate SHA*. **This table measures
presence only.** There is no gate SHA — §8 of the packet carries `FAIL` — and the
whole-suite verdict is CI's, a position my chain has held since `J-dv_lead-0183`. I
could have run something local and called it green; the honest statement is that
**`REC-7` proved the *naming* half undischargeable and this table discharges exactly
that half**, and §2.2-D.6 item 1 says so in terms that make a reader who stops there
visibly wrong. I also declined to let the table absorb `F-0022-1`: the auditor's
finding is the same hazard from the other end — a **rendering** that no longer applies
rather than a **name** that no longer resolves — and I re-state its two verified
instances beside mine instead of implying a cure I have not written. **A name that
resolves does not make a diff that applies.**

**Harvest.** **Not due, declared rather than skipped** (charter §8, PROTOCOL §7): this
round is neither an `SO-` issuance nor a phase gate — §2.2-D is an annotation to a
packet that already carries `FAIL`, and it re-statuses nothing. **My open span
continues unbroken from `J-dv_lead-0183`/`-0184`/`-0185`/`-0186` and this entry joins
it.** **Two candidates banked**, LH1–LH3 discharged, both **LH2-g** (no proper noun of
any kind); lettering continues the arc's shared sequence after (h)/(i)/(j) at
`J-dv_lead-0186`.

- **(k)** *When a record and the artefact it grades use different names for the same
  thing, publish the mapping as a table with per-item evidence before anyone reasons
  across the two; a mapping performed inside a summary is invisible to everyone who
  reads the summary.* **LH1** this round's `T-`/`M03-` era mapping, and the relay that
  performed it silently for two classes. **LH3** without it, a party checks a rule
  against a name that cannot resolve, silently substitutes the one that does, and the
  substitution — not the check — becomes the thing nobody audits.
- **(l)** *A claimed correspondence between two naming schemes is checkable by
  comparing the populations they name at the moments each was written, not by
  comparing the names; identical counts at every anchor is evidence, matching spelling
  is not.* **LH1** this round's four base-SHA reconciliations (20 / 25 / 31 / 36),
  each matching its own record's independently-stated denominator. **LH3** without it,
  a mapping rests on the reader finding the labels obvious, which is exactly the
  condition under which a renamed-and-also-split item passes unnoticed.

### Actions

- Ran the abort-first precheck; verified `49f04c0` and a clean tree, and re-verified
  both at authoring time before writing the chain header.
- **Opened volume 11** per ADR-0017 §4.4: computed `sha256sum` and byte count of v10
  **from `git show HEAD:`**, cross-checked against the working file, wrote the §4.3
  header with `Continues-from: J-dv_lead-0186`. **v10 was not touched and is not
  staged.**
- Re-read `J-dv_lead-0184` and `J-dv_lead-0186` at the source for the three findings'
  own statements of themselves, rather than working from the dispatch's summary.
- **Re-verified `REC-2`'s three factual claims independently** before writing a
  correction that asserts them: no era-tally section in `WO-0073`; zero `41 sealed`
  in it; `git log -S'41 sealed' --reverse` returning `33871b8` then `70cf13c`.
- **Annotated `SO-xgmii_rx_64.md` §2.2-M** with `REC-1`'s cure — dated-annotation
  form, method sentence left unedited.
- **Annotated `WO-0074` §12** with `REC-2`'s cure — same form, sourcing sentence left
  unedited.
- **Measured the namespace of all ten class-era campaign packets**: four carry `T-`
  names (`WO-0050`, `0055`, `0058`, `0061`), six carry none.
- **Measured the bench at `49f04c0`**: zero `"T-` string literals under `test/`, zero
  `T-`-prefixed `let%expect_test` heads, 59 heads under `test/xgmii_rx_64/`; chased
  and classified the three surviving historical `T-` prose strings.
- **Enumerated the `let%expect_test` heads at the four campaign base SHAs** via
  `git show`, and reconciled each against that campaign's own declared M03
  denominator: 20 / 25 / 31 / 36, four exact matches.
- **Derived `I-c10`'s 28 killing units** as the 35-head set at `42b9df3` less the
  seven greens the record names, with both checks stated.
- **Wrote `SO-xgmii_rx_64.md` §2.2-D** — six sub-sections, a thirty-row per-class
  table, the plural-naming discharge and the four non-discharges.
- Wrote this entry. **No file outside the two named packets and this new journal
  volume was created, edited or staged. No `git commit` or `git push` was run, and no
  stop-hook commit demand was honoured.**

### Evidence

All commands run from a clean checkout at `49f04c0`; the tree at that SHA is what
every figure below is taken from.

**Rotation chain values** (ADR-0017 §4.3, §6.3):

    git show HEAD:agents/journals/claude_dv_lead_agent.v10.md | sha256sum
    # ee441697dab3696924090feb08742249952c432791c014b27b8c91975770ae75
    git show HEAD:agents/journals/claude_dv_lead_agent.v10.md | wc -c
    # 288336
    grep -o '^## \[J-dv_lead-[0-9]*\]' agents/journals/claude_dv_lead_agent.v10.md | tail -1
    # ## [J-dv_lead-0186]        -> Continues-from
    git diff --exit-code -- agents/journals/claude_dv_lead_agent.v10.md   # exit 0, v10 untouched

`sha256sum` on the working file returns the same digest, so the two readings agree.

**`REC-2`'s claims, re-verified:**

    grep -ic 'era tally\|program tally' agents/handoffs/WO-0073_family-l-mutation-campaign.md   # 0
    grep -c  '41 sealed'                agents/handoffs/WO-0073_family-l-mutation-campaign.md   # 0
    git log --oneline -S'41 sealed' --reverse -- tasks/BOARD.md agents/handoffs/
    # 33871b8 Board: the seventh campaign closes five of five ...
    # 70cf13c The eighth campaign: seven of seven killed character-exact ...
    git log -1 --format='%(trailers)' 33871b8   # Agent: orchestrator / Journal-Entry: J-orchestrator-0215

**`M1` — the `T-` namespace is not a bench namespace at `49f04c0`:**

    grep -rn '"T-' test/                                    # no matches
    grep -rhA2 'let%expect_test' test/ | grep -oE '"T-[A-Za-z0-9]+'   # no matches
    grep -rh 'let%expect_test' test/xgmii_rx_64/ | wc -l    # 59
    grep -rn 'T-A34\|T-D2\|T-D3\|T-I2' test/                # 4 lines, all prose:
    #   test/attack_plans/AP-xgmii_rx_64.md:3756, :3875, :3880 (change log)
    #   test/xgmii_rx_64/test_m03_i.ml:574 (comment quoting WO-0061)

**`M2` — per-base denominator reconciliation.** For each base SHA:

    git ls-tree -r --name-only <base> test/xgmii_rx_64/ \
      | while read f; do git show "$base:$f" | grep -c 'let%expect_test'; done | paste -sd+ | bc

    616686f -> 20 heads (19 M03-labelled)      WO-0050 verdict §0: "over 20 units"
    2e8994f -> 25 heads (24 M03-labelled)      WO-0055 verdict §1: 5 red + 20/20 MSG
    a2d090d -> 31 heads (30 M03-labelled)      WO-0058 verdict §2: "all 31 M03 units"
    42b9df3 -> 36 heads (35 M03-labelled)      WO-0061 verdict §1: I-c10's 35 cells

**Campaign namespaces**, `\bT-[A-Z]…` against each of the ten class-era packets:
`WO-0050` 16 distinct `T-` names, `WO-0055` 7, `WO-0058` 14, `WO-0061` 15;
**`WO-0063B`, `WO-0066`, `WO-0073`, `WO-0074`, `WO-0076`, `WO-0077`: zero each.**

**`I-c10`'s derivation**, both checks: heads at `42b9df3` = 35 `M03-`-labelled
(= the record's 35 REQUIRED cells); less the seven `R→G` the record names
(`T-C4, T-E1, T-E2, T-E5, T-F1, T-F2, T-F3`) = **28**, matching the record's
*"28 red, 7 green"*.

**Table arithmetic**, checkable against §2.2-D.4 by counting rows: 30 classes
(8 + 5 + 7 + 10) − `G-c4` (survivor limb) − `I-c1` (unscoreable) = **28 frozen kills**;
by shape 17 plural-killed + 8 singular + 3 plural-sealed-singular-killed = **28**;
**28 mappings established, 0 disposition failures.** The 28 also reconciles against
the era columns independently: `WO-0050` 8 killed + `WO-0055` 4 + `WO-0058` 7 +
`WO-0061` 9 = **28**.

**The annotations rewrote nothing — measured, not asserted:**

    git diff --stat -- agents/handoffs/SO-xgmii_rx_64.md \
                       agents/handoffs/WO-0074_family-m-mutation-campaign.md
    # SO-xgmii_rx_64.md  199 +++++   WO-0074_...  14 ++
    # 2 files changed, 213 insertions(+)      <- ZERO deletions

**213 insertions, 0 deletions.** Both corrected sentences and every frozen figure in
both packets survive byte-identical; the corrections are additions beside them. That
is the closed-packet discipline discharged as a number rather than a promise.

**Read surfaces byte-unchanged across the round**, re-checked at authoring time:

    git diff --stat -- test/ tasks/BOARD.md \
        agents/handoffs/WO-0050_... WO-0055_... WO-0058_... WO-0061_... \
        agents/journals/claude_dv_lead_agent.v10.md      # empty

**Not measured this round, and named as such**: **green**. No suite was run; no CI run
id is claimed for the gate SHA, which does not exist. `dune runtest` was not
executed at this tree and no promotion state is asserted.

### Outcome

**All three acts complete; nothing partially met, nothing deferred without a named
carrier.**

- **ACT 0 — rotation: DONE.** Volume 11 opened per ADR-0017 §4.3/§4.4, chain values
  verified my side from `git show HEAD:`, `Continues-from: J-dv_lead-0186`. **v10
  untouched and unstaged**; the orchestrator verifies at commit per §6.3. This round's
  entry is the volume's first and only entry.
- **ACT 1 — `REC-1`: PAID**, as a dated annotation at `SO-xgmii_rx_64.md` §2.2-M with
  the method sentence left unedited. **No column moves.**
- **ACT 2 — `REC-2`: PAID**, same form at `WO-0074` §12, sourcing sentence unedited,
  the orchestrator credited by SHA and journal entry, and all three underlying facts
  re-verified at the source before the correction was written.
- **ACT 3 — `REC-7`: PAID**, as new §2.2-D of `SO-xgmii_rx_64.md`, **home named in the
  section itself with the ground for each option not taken**. Thirty classes, twenty-
  eight frozen kills, **twenty-eight mappings established with per-row evidence
  grades, zero disposition failures**; the plural naming discharged in the same table
  per `J-dv_lead-0186`'s owed item; **the green half named as still owed** and the
  `F-0022-1` residue re-stated rather than absorbed.

**Handoff**: to the orchestrator for commit. `Files-in-this-commit` lists the **two**
packet files; the journal volume is the committing agent's own and is excluded per
§4.2. Trailers `Agent: dv_lead`, `Work-Order: none`, `Journal-Entry: J-dv_lead-0187`.
**Not `Journal-Only`** — this commit carries work. **I staged nothing outside
`agents/handoffs/**` and my own journal chain**, ran no git write command, and
honoured no stop-hook commit demand.

### Open-questions

1. **The green half of `(b.2)` is unpaid and cannot be paid by me alone.** §2.2-D
   discharges *present*; *green at the gate SHA* needs a CI run at a SHA that does not
   yet exist. **Carrier**: the round that produces a `P1-module-ready` candidate SHA,
   at which point §2.2-D.4's `present name(s)` column becomes the input to a run, not
   a claim about one. **Nobody may read §2.2-D as a discharged disposition before
   then**, and item 1 of §2.2-D.6 is written to make that misreading visible.
2. **`REC-3` remains the live one and it is not mine to close.** The sealed column
   excludes a seeded class (`I-c1`) and includes an unseeded one (`IC-M5`); `(b.1)` as
   ratified now carries the three itemised grounds that fix it prospectively, and the
   **`sealed` figure moves 63 → 65 under the codified reading**. `SO-` §2.2-M is mine
   to move when it moves; `tasks/BOARD.md` and `docs/gates/P1-module-ready-checklist.md`
   are the orchestrator's. **Nothing moved this round** — §2.2-D says so explicitly —
   and when it does, the movement is a **definition change with no measurement behind
   it** and must say so in the same sentence. From `J-dv_lead-0186` item 4.
3. **`REC-7` and `F-0022-1` are still one hazard read from two ends, and only one end
   is now instrumented.** A disposition's referent can go stale by **name** (mine,
   cured here) or by **rendering applicability** (the auditor's: `f-c3.diff` and
   `f-c6.diff` no longer apply at HEAD). §2.2-D.6 item 2 records the second beside the
   first rather than implying a cure. **If a later round wants one clause for both**,
   the honest version remains the one I declined to propose on a delta round: *a
   disposition citing a frozen measurement must state what it re-verified and what it
   could not.* I do not propose it here either — the table is the instrument that
   would have to carry it, and it is one round old.
4. **`FINDING REC-6` (six words in ADR-0020 §2 `D5`) is the architect's and I do not
   know its state.** Recorded so the debt is not lost between chains. From
   `J-dv_lead-0186` item 1.
5. **Carried, unchanged**: `DVC-1a` remains unbuilt and every attack-plan count I quote
   remains a hand count with its method stated; the whole-suite verdict is still CI's
   and the `9a596e7` repair's CI adjudication is still open — from `J-dv_lead-0183`
   items 6 and 7, carried at `-0184`, `-0185` and `-0186`. **`J-dv_lead-0184` item 5
   also stands**: no test, plan row or spec claim of mine may cite that round's
   mutation-hunk reads, and this round cites none.
6. **`docs/PROCESS.md`'s verification-discipline read-and-confirm is not this round's**
   and is untouched; the dispatch scopes it to a later round and I did not open it.

### Files-in-this-commit
- agents/handoffs/SO-xgmii_rx_64.md
- agents/handoffs/WO-0074_family-m-mutation-campaign.md

## [J-dv_lead-0188] 2026-08-11T21:20Z | task:none | The two-frame presenter commissioned with its own machinery's design fixed rather than delegated — the run law re-anchored on the start character because the plan's identity does not generalise, the landed precondition found FALSE against a conformant design at two frames, and the route's own identity made an assertion so a silence on the wrong stimulus cannot be read as a result

### Trigger

Orchestrator dispatch, **one round: author `WO-0082`, the two-frame presenter
packet — the `SO-M04` long pole**. It is the packet four of my own plan sites have
been naming since `BUG-0004` closed: `AP-M04` §7 item **T-7** (the machinery
absence, measured at the producer and carrying my seat as executor), §0.2 item 4
(the REQ-206 prohibition), row `M04-G10`, and `BUG-0004` §10.4's carrier table.

**This entry covers a round that died mid-response and was resumed.** The first
attempt reached the end of its reading and design work and was killed by a server
error at the moment it began to write; the orchestrator's resume message states,
and the tree confirmed, that **no packet file existed** — the death was before the
first write, so nothing partial had to be distrusted and nothing was inherited
except my own reading, which I re-verified against a moved head before writing a
line.

**Abort-first head check, before reading anything.**

    git status --short   # 3 lines, all auditor-lane (below)
    git rev-parse HEAD   # 53ada46e2d257347d9e1d3bb6e84ce875e710fd6
    git rev-parse --abbrev-ref HEAD   # claude/fpga-hardcaml-agent-orchestration-37ceyf

`53ada46` is the dispatched expectation exactly. The three dirty paths were
`docs/reports/audit/WO-0041-mutations/README.md` (modified) and two untracked
files, `agents/journals/claude_auditor_agent.v03.md` and
`docs/reports/audit/ADR-0020-auditor-countersignatures.md` — **all three inside
the auditor's declared and exclusive lane** (PROTOCOL §6, ADR-0003), which the
dispatch declared mid-round. Neither branch of the abort procedure was reached.

**The head moved twice under the round and I re-verified rather than trusted the
report.** At resume, `HEAD` = `6c02f5b`. The dispatch's own rule is to
re-verify read surfaces, and the measurement is the whole of the clearance:

    git diff 53ada46 6c02f5b -- docs/specs/ test/ agents/handoffs/ \
                                agents/PROTOCOL.md agents/charters/
    # empty

**Every surface this packet reads is byte-unchanged across both landings.** The
movement is `d84d36a` (`libs/hardcaml_ethernet/src/eth_axis_tx.ml`, rtl_lead's
C-RL-9 comment repair) and `6c02f5b` (`docs/reports/process-council/**`, the
orchestrator's council transcription) plus those two seats' own journals — three
declared sibling lanes, none of them mine, and **the empty diff above is why the
base figures I measured at `53ada46` are quoted at `6c02f5b` rather than
re-measured for form.**

**One substrate fact I record rather than let a later reader find unexplained.**
At my closing check the auditor's three paths had **disappeared from the working
tree without `HEAD` moving** — the modified file is clean and the two untracked
files no longer exist. That is entirely inside the auditor's own lane, it is not
mine to adjudicate, and **I touched none of the three at any point**; I note it
because a reader comparing this entry's opening and closing tree states would
otherwise see a silent deletion and have to guess.

### Inputs

- `agents/charters/dv_lead.md` (§3's attack-plan and delegation duties, §5's DoD,
  §8's journaling rules, §9's honest-enforcement note — the last is what §17.1 of
  the packet exists to instrument).
- `agents/PROTOCOL.md` — §3 (packet classes; the numbering rule, which is why the
  packet's State block says the number is the orchestrator's to allocate), §4,
  §5, §6, §7's **Mutation record** as in force, §10 (independence, the mutation
  sequencing, **R-SEAL-1**).
- **`test/attack_plans/AP-xgmii_tx_64.md` at `9a596e7`, read at the rows and not
  recalled**: §0.1's three standing rules, §0.2 item 4 in full, §1's status
  vocabulary, §2's seven standing obligations, §3's stimulus legality, §4's
  identity, the family-A/B/F/G/H row tables, §5 item 11, §6's coverage map,
  **§7's machinery table (T-1 … T-7) and §7.1's BAR T1**, §9's last two change-log
  rows.
- **`agents/handoffs/BUG-0004_…md` §9.3 (routes 2 and 3, derived), §9.4 (the
  `W = 2` derivation), §10.3 (the three-way routing and the `SO-` precondition),
  §10.4 (the carrier table)** — read at the source, because this packet's whole
  subject is two derivations that packet never measured.
- `agents/handoffs/WO-0080_…md` and **`WO-0081_…md` in full** — §3, §4.1, §5.1–5.3,
  §6.0, §10, §11.1–11.3, §12, §13, §15, §16, §17.1–17.3, §18, §19; and
  `RV-0081-VERDICT`'s own §4 and §6.
- **`docs/specs/modules/xgmii_tx_64.md` at `292596c`**: §6.1 entire (the preamble,
  FCS items 1–4, terminate-and-fill, **the gap paragraph**, the cycle table, the
  storage paragraph), §6.2, §6.3, **§7 entire — the latency bullet, the
  throughput bullet, the C-14.1 bullet and the C-16 bullet with all four
  consequences**, §9, §13's four 2026-08-11 rows.
- **`docs/specs/requirements.md` at `f67a57a`**: §0.5 entire as amended (the `q`
  definition, the **halved** silence default, the structural-wrapper clause, the
  identity `L = 8·ΔC − h + q`), §0.3, §0.6, §9.1, REQ-016, REQ-019, REQ-204,
  REQ-206, REQ-209, REQ-210.
- **The bench layer, read as the contract it is**: `test/xgmii_tx_64/bench.mli`
  (all 259 lines) and `bench.ml`'s presenter, `check_words`, `run_one_frame`,
  `run_lengths`, `wire_frame` and `assert_instruments_clean`;
  `test/xgmii_tx_64/test_m04_a.ml` (the preamble idiom), `test_m04_g.ml` (the
  strobe idiom and its own docstring), `test_m04_d.ml` (the promoted block),
  `test/xgmii_tx_64/dune`.
- `test/xgmii/tx_decoder.mli`, `frame.mli`, `xgmii_word.mli`;
  `test/monitors/stream_word.mli`, `strobe_monitor.mli`;
  `test/golden/crc32_ref.mli`.
- My own chain: `J-dv_lead-0179` (Open-question 3, **the re-pin flag this round
  discharges**), `-0180` (Open-questions 2 and 7), `-0181` (the §4.D straddle
  re-pin, read at its diff), `-0187`.
- **No RTL source read, for any purpose.** `libs/**`, `top/**`, `bin/**`,
  `rtl_snapshots/**` and `test/third_party/**` were not opened at this commit or
  any earlier one — not for `BUG-0004`'s fix, which is the one place the
  temptation was real, and the packet's §8 says in terms that the derivation is
  deliberately the only route to it.

### Reasoning

**The packet's subject in one sentence, because it decides everything below.**
Every M04 run ever driven has contained exactly one frame, and that is enforced in
the machinery rather than merely true of the benches: `assert_instruments_clean`
fails unless exactly one frame decodes, `wire_frame` fails unless exactly one
frame decodes. Twenty-five discharged rows and **not one handover**. `T-7` is the
measurement of that absence and it names my seat as executor. A seat discharges a
machinery obligation by **commissioning it with its design fixed**, not by
handing a worker a capability request — so §5.3 of the packet specifies the
runner, the split of the presenter, the run-length allowance, the two generalised
instruments and the four re-expressions, and says in terms *"you implement this
design, you do not choose it"*.

**1. The re-pin is an act, and four movements had to be answered separately.**
`J-dv_lead-0179` Open-question 3 flagged that `requirements.md` moved **inside
`WO-0081`'s own spec basis** while that round ran, and required the next packet to
re-pin rather than inherit. A re-pin that only refreshed SHAs would not have been
one, so §3.1 answers each movement with its own ground: **(a)** §0.5 gained `q`
and halved its silence default — *nothing here turns on it, and the reason is a
measurement*: `q = 0` at M04 by two independent routes I derived at
`J-dv_lead-0180` §4, and family J does not ride at all; **(b)** SPEC-M04 §7's
straddle citation was repaired at `292596c` — *nothing moves*, but it matters
because §7 is the section this round reads hardest and the worker is reading a §7
edited eleven days into the module's life; **(c)** the plan-side twin was
**already re-pinned by me** at `9a596e7`, which is why this round makes no plan
edit at all; **(d)** PROTOCOL §7's Mutation record is in force — *nothing*,
because no campaign rides this packet and §10 sequences one after the `RV-`.
**§3.2 then records the thing that makes the discipline non-ceremonial**: five
base figures would have been **wrong** if carried from the previous packet — the
expect-test census (149→156), the tracked-file count (7→10), `bench.mli`'s value
count (12→13), the `M04-` id census (13→25 ids) and the print census (0→10).

**2. The stage split is by capability axis, not by family, and the dispatch asked
me to scope it honestly.** Four families have back-to-back rows; **three distinct
capabilities** reach them. Building all three in one round would have doubled the
machinery of a round whose machinery already re-expresses four landed functions.
So: this packet builds **one** — the multi-frame continuous presenter — and rides
the six rows it reaches (`A3`, `B3`, `F1`, `F2`, `F5`, `G10`). Held back with the
reason named per row: `A4` and `F6` need an **underflowed predecessor**, i.e.
family G's withholding polarity, and two of A4's three members riding is not a
discharge; `F3` drags in the **configuration axis** (`cfg_ifg` is hard-wired at 12
in `create`, deliberately, "with its first consumer"); `F4` is **family I's
10 000-frame run**, 47× this round's whole ceiling, and its own Stimulus cell says
so. **Family F therefore does not complete and the packet does not describe it as
completing** — the temptation to call a four-of-six family "closed" is exactly the
coverage-by-silence the charter's DoD forbids.

**3. The run law, and it is the round's central derivation because the plan's
identity does not generalise by substitution.** `AP-M04` §4's identity is stated
for one frame issued into an idle transmitter with the gap already served. For
frame `k ≥ 2` the anchor is **not** that frame's own first acceptance: REQ-210
says in its own text that *"back-to-back transmission legitimately delays a start
character until the gap is served"*, and the start character is fixed by REQ-204's
rounded gap rather than by M04's depth (SPEC-M04 §7's C-16 consequence 3 says so
directly). So I re-anchored everything on `S_k`, the start-character cycle:
`S₁ = C + 1`; `T_k = S_k + 1 + ⌊F_k/8⌋`; `S_{k+1} = T_k + g_k`. **It reduces to
the plan's identity at `k = 1` byte for byte**, and at `P = 60` it reproduces
every figure §6.1's own cycle table states independently — terminate at `C + 10`,
next start at `C + 12`, gap 16 octets, 11 cycles, 88 octets. A bench that computed
frame 2's cycles from frame 2's own `C` is wrong by two cycles at `P = 60` and by
a different amount at every other length, which is trap **T3**.

**4. The finding that would have produced a bench failing conformant designs, and
it is against the landed machinery rather than against anything new.** The landed
`P-ACCEPT` asserts the accepted cycles are `C … C+W−1`, **contiguous**. It has
been green for twenty-two runs. **It is false at two frames against a conformant
M04**: `tx_tready` is 0 on the FCS word and the terminate word (C-14.1), so every
multi-frame acceptance stream has holes. A worker generalising the presenter "by
analogy" carries the check across and the resulting red reads as a design defect.
So §5.3(4) splits the presenter's loop from its checks — `present` keeps
`P-ACCEPT` for the single-frame path, `present_stream` gets **`SP-1` liveness and
`SP-2` completeness and nothing else** — and the packet states the prohibition
twice, as trap **T4** and as bar **M-20**, which asks the worker to write down in
one sentence *why* contiguity would fail a conformant design. **A bar that asks
for the reason catches a copied check that a bar asking for the code would
not.**

**5. `T-7` is discharged in half and I named the half rather than glossing it.**
The row asks for a *"controllable"* handover cycle. This round builds the
continuous source and the handover, and **not** an arbitrary-cycle release
scheduler. The honest analysis is that the half built is the half `M04-G10`
needs — a continuous source presents the next frame's word 0 at exactly `C + 8` by
construction, which is *why* routes 2 and 3 exist at all — and the half not built
has **no consumer among this round's rows** (its consumers are family H's), so
building it would land a capability with none, which is the standing rule `BM5`
enforces. I considered driving the `C + 11` alternative to give the scheduler a
consumer and rejected it: that alternative **is** a family-H row's observable, and
inventing a use to justify a capability is how a round acquires coverage it did
not commission. §5.4 states the residue and §19.2 item 4 puts the state-cell
movement in my own hands at the `RV-`, to the extent measured and no further.

**6. The append-only rule, and it is the third answer to a question with two bad
answers.** Three of this round's five units belong to families whose files are
landed, and §5.3 re-expresses four landed functions whose **only** evidence of
harmlessness is the sixteen landed units staying byte-identical. Option one —
forbid touching the family files, put everything in one new file — files rows
where no later family round would look for them, and the landed `test_m04_g.ml`
docstring already anticipates the opposite in terms (*"Family G's own round
appends further units to THIS file"*). Option two — edit freely — destroys the
regression witness. **The third answer is PROTOCOL §5's own `R3` borrowed one
directory over**: additions only, `--numstat` deletions **zero**, which is exactly
"nothing existing was touched" because a modified line shows as one deletion and
one insertion. The family convention survives permanently, the witness survives
this round, and the bar is mechanical rather than a reading.

**7. The disposition class I would not have written a year ago, and it is the most
valuable pre-commitment in the packet.** `M04-G10` asserts a **silence**. A
silence is worthless if the run was not the experiment: if the handover does not
land at `C + 8`, `error_underflow` may well be 0 for reasons with nothing to do
with `BUG-0004`. So the unit asserts **the route's own identity first** — the
whole acceptance list, `C … C+8` for shape (a) and `C … C+8` plus `C + 11` for
shape (b), the second with its hole at `C + 9`/`C + 10` — and **class D3c**
pre-commits that a failure there **voids every silence assertion downstream**,
with the void condition written into the unit's own failure message rather than
left to adjudication. `WO-0081`'s table had one `D3` because a single-frame round
had one run-level precondition; folding `D3c` into it would have routed *"the run
was not the route"* to *"the run stalled"* and let a reader take the silence at
face value.

**8. What I refused to write, three times.** **No plan edit** — issuing a work
order is not an event `AP-M04` §9's change-log discipline attaches a row to; that
discipline attaches to an edit of the plan and to the **absorption** of a round's
results, which is my act at the `RV-`. The one annotation the plan was owed at
issuing time (§4.D's straddle citation) **was already paid** at `9a596e7`, and I
checked that rather than assuming it. **No sealed prediction** — my form seals
mutation campaigns, not bench rounds, and `WO-0080`/`WO-0081` carry no seal file
either; a bench packet withholds nothing, so **R-SEAL-1 has no subject here** and
I have not claimed a withheld result anywhere in the packet. The one
prediction-shaped thing in it, §16.3's expected-CI statement, is **disclosed by
construction** and this round's is *green with an empty diff*, which is a
tightening rather than a loosening: no printed value is commissioned, so class P
is **closed** and any diff at all is a bounce.

**9. Cost, and why the ceiling moved.** 2 354 driven cycles across 16
elaborations — 2.24% of the measured size class, the largest single run (the
hundred-frame one) 1.2% of the probe's own run. The ceiling rises from 1 700 to
**2 600** and from 28 to **20** elaborations: cycles up because one row's stimulus
is a hundred frames, elaborations **down** because a multi-frame run is one
elaboration where the last round's twenty-two runs were twenty-two. Both figures
are derived from §6's tables and the packet says that exceeding either means one
of **my** constants is wrong.

**Harvest.** **Not due, declared rather than skipped** (charter §8, PROTOCOL §7):
this round is neither an `SO-` issuance nor a phase gate — it issues a work order.
**My open span continues unbroken from `J-dv_lead-0183` through `-0187` and this
entry joins it.** **Two candidates banked**, LH1–LH3 discharged, both **LH2-g**
(no proper noun of any kind); lettering continues the arc's shared sequence after
(k)/(l) at `J-dv_lead-0187`.

- **(m)** *An experiment that reports the absence of an event must first assert
  the precondition that identifies which experiment was performed, and must
  declare its own result void when that precondition fails.* **LH1** this round's
  handover precondition and its pre-committed void class, written against a row
  whose entire content is a silence. **LH3** without it, a negative result is
  reported on a stimulus that was never produced, and the absence of evidence
  enters the record as evidence of absence — undetectably, because the run is
  green.
- **(n)** *A precondition proven over a single instance does not survive its
  generalisation to a sequence, and the ones already hardened into assertions are
  the dangerous half: such an assertion keeps passing review by looking unchanged
  while failing every conformant subject.* **LH1** this round's contiguity check
  — true of one frame, false of two against a conformant subject, green for
  twenty-two prior runs. **LH3** without the rule, the generalisation ships a
  checker whose failure is read as a defect in the thing checked rather than in
  the checker, which is the most expensive misreading available.

### Actions

- Ran the abort-first precheck at `53ada46`; on resume after the mid-response
  death, **re-ran the head check and executed the dispatch's re-verification
  clause** — `git diff 53ada46 6c02f5b` over `docs/specs/`, `test/`,
  `agents/handoffs/`, `agents/PROTOCOL.md` and `agents/charters/` returned empty.
- Read the charter, the protocol, `AP-M04` at its rows, `BUG-0004` §9.3/§10.3/
  §10.4, `WO-0080`/`WO-0081` in full, SPEC-M04 §6.1/§6.2/§6.3/§7/§9/§13, and
  `requirements.md` §0.3/§0.5/§0.6 as amended.
- Read the landed bench layer as a contract: `bench.mli` in full, `bench.ml`'s
  presenter and four guard sites, and the three family files whose idioms the new
  units follow. **No RTL was opened.**
- **Measured the base at `53ada46` and re-verified it unmoved at `6c02f5b`**: the
  expect-test census, the per-file unit counts, the tracked-file set, `bench.mli`'s
  value count, the `M04-` id census and its two bare tokens, the infix-`mod`
  sites, the printing sites, the `tready` sites, the `[%expect]` block census and
  its one non-empty member, `test/xgmii_rx_64/`'s file count, and
  `tools/dv_checks.sh`'s zero M04 occurrences.
- **Derived the run law** and checked its reduction to `AP-M04` §4's identity at
  `k = 1` and against SPEC-M04 §6.1's own cycle table at `P = 60`.
- **Derived every constant of the five units** — 14 frame shapes, the eight-member
  gap sweep, the two `M04-B3` orders, and `M04-G10`'s acceptance lists and three
  named cycles — from the run law and from §7's C-16 consequences 2, 3 and 4.
- **Wrote `agents/handoffs/WO-0082_tb-m04-two-frame-presenter-and-g10.md`** — 19
  sections plus a header block and section map, six commissioned rows, five units,
  20 review bars with base figures, 19 bounce conditions, 16 traps, 12
  disposition classes, and the §17.1 allow-list in `WO-0081`'s proven unified
  form.
- Wrote this entry. **No file outside the new packet and this journal was
  created, edited or staged; `test/attack_plans/**` was not touched; no
  `git commit` or `git push` was run and no stop-hook commit demand was
  honoured.**

### Evidence

All commands run from the checkout at `53ada46` and re-verified at `6c02f5b`; the
empty diff below is what licenses quoting the first set at the second commit.

**Head movement and surface clearance:**

    git rev-parse HEAD                       # 6c02f5b2b21be63c1091e6b026be17aeb7159bbe
    git diff 53ada46 6c02f5b -- docs/specs/ test/ agents/handoffs/ \
        agents/PROTOCOL.md agents/charters/  # empty
    git diff 53ada46 6c02f5b --stat          # 12 files: two sibling journals,
    #   docs/reports/process-council/round-1/** (9), libs/hardcaml_ethernet/src/eth_axis_tx.ml

**The base figures every §12 bar is stated against:**

    grep -rh --include=*.ml 'let%expect_test' test/ | grep -c .      # 156
    git ls-files test/xgmii_tx_64/ | wc -l                           # 10
    git ls-files test/xgmii_rx_64/ | wc -l                           # 17
    grep -c '^val ' test/xgmii_tx_64/bench.mli                       # 13
    grep -rho --include=*.ml 'M04-[A-Z][0-9]*' test/ | sort -u | wc -l   # 25 distinct
    grep -rho --include=*.ml 'M04-' test/ | wc -l                     # 145 = 143 + 2 bare
    grep -rn ' mod ' test/xgmii_tx_64/                                # 3, all non-expression
    grep -rn 'print\|Stdio' test/xgmii_tx_64/*.ml | wc -l             # 10, all in test_m04_d.ml
    grep -rn 'tready' test/xgmii_tx_64/*.ml | wc -l                   # 9
    grep -c 'M04\|xgmii_tx_64\|AP-xgmii_tx' tools/dv_checks.sh        # 0

Per-file `%expect_test` counts: scaffold 1, a 1, b 3, c 5, d 3, e 2, g 1 = **16**.
`[%expect` blocks: **16**, of which **15 are `{||}`** and one carries U13's
promoted oracle value at `test_m04_d.ml:392` — read individually, not counted.
The three infix-` mod ` hits are `bench.mli:151` (docstring),
`test_m04_b.ml:255` (string literal) and `test_m04_e.ml:14` (docstring); the ten
print hits contain **exactly one call site**, `Stdlib.print_string` at
`test_m04_d.ml:362`.

**The run law checked against the specification's own table**, at `P = 60`:
`F = 64`, `t = 0`, `S₁ = C+1`, `T₁ = C+1+1+8 = C+10`, `g = ⌈12/8⌉ = 2`,
`S₂ = C+12`, spacing 11 cycles, gap `16 − 0 = 16` octets, **88 octets between
start characters** — every figure independently stated in SPEC-M04 §6.1's cycle
table and its closing paragraph. The `t = 4` member: `F = 68`, `g = ⌈16/8⌉ = 2`,
gap `16 − 4 = **12**` — §6.1 names that number too (*"16 octets for t = 0 and 12
octets for t = 4"*).

**`M04-G10`'s three cycles, each traced to a specification sentence rather than
to `BUG-0004`**: the acceptance at `C + 8` is §7's C-16 consequence 2; the second
word at `C + 11` is consequence 4; the start character unmoved at `C + 12` is
consequence 3. `BUG-0004` §9.3 supplies only the two cycles at which the
**unfixed** design strobed, `C + 12` and `C + 13`, which the packet uses to name
the assertion and never as an expected value.

**Cost arithmetic**, checkable by summing §10's table: 51 + 408 + 1 227 + 464 +
204 = **2 354** cycles over 1+8+1+2+4 = **16** elaborations; `2 354 / 105 010` =
**2.24%**.

**Not measured this round, and named as such**: **green**. No suite was run, no
`dune` invoked, no CI run id claimed — this round writes a packet and no code.
Every claim about the landed bench's behaviour is a read of the committed file,
and every claim about the design's behaviour is a derivation from the
specification, which is what the round exists to commission a measurement of.

### Outcome

**Met.** The packet is authored, complete, and `DRAFT` pending the orchestrator's
number allocation and spawn.

- **`agents/handoffs/WO-0082_tb-m04-two-frame-presenter-and-g10.md`** — 19
  sections. §0 what the round is; §1 the slice and **the honest stage split**;
  §2 the six rows; **§3 the re-pinned references with §3.1's four movements and
  §3.2's five would-have-been-wrong figures**; **§4 the run law**; **§5 the
  capability layer, the fixed design of the extension, and §5.4's named `T-7`
  residue**; §6 every derived constant per unit; §7/§8 the DUT seam and the read
  prohibition; §9 the regime facts including **§9.8, what measuring `M04-G10`
  does and the four things it does not**; §10 cost and the pre-committed ceiling;
  §11 units, files and **§11.4's append-only rule**; §12 twenty bars, every
  tree-quantified one executed at the base; §13 nineteen bounce conditions;
  §14 sixteen traps; §15 twelve pre-committed dispositions including **D3c**;
  §16 the expected-CI discipline; §17 the allow-list in the proven unified form;
  §18 the return; §19 what the round does not carry and what I owe after it.
- **Worker**: tb_writer. **Round count**: one, and the family set is split across
  three stages with stage 2 and stage 3 named at §1.4.
- **`T-7`'s executor obligation** is discharged as a commissioning act with the
  machinery's design fixed by me; its residue is named at §5.4 and its state cell
  moves only at absorption, only to the extent measured.

**Handoff**: to the orchestrator, to allocate the packet number, commit, and
spawn tb_writer against it. `Files-in-this-commit` lists the one new packet file;
this journal volume is the committing agent's own and is excluded per §4.2.
Trailers `Agent: dv_lead`, `Work-Order: none`, `Journal-Entry: J-dv_lead-0188`.
**Not `Journal-Only`** — this commit carries work.

### Open-questions

1. **The packet number is not mine to allocate** (PROTOCOL §3). The file is named
   `WO-0082` because that is the next free number measured at this tree
   (`grep -c 'WO-0082' tasks/BOARD.md` → 0) and the State block says so; if the
   orchestrator allocates differently, the filename and the four internal
   self-references move together.
2. **`BM17`'s arming condition is measured by the worker and not by me.** It turns
   on whether the spawn prompt carries an enumerated allow-list at its head —
   the orchestrator's act, reported as a fact in §18 item 9. It was armed last
   round and did not fire; **that is a precedent about the arrangement working,
   not a reason to relax it**, and the packet says so in the condition itself.
3. **The auditor's three working-tree paths disappeared mid-round without `HEAD`
   moving** (Trigger). Inside its own exclusive lane, not mine to adjudicate, and
   I touched none of them. Recorded so a reader comparing tree states is not left
   to guess; if it was an aborted round, the debt it was paying is that seat's to
   re-carry.
4. **`DVC-1a` remains unbuilt** and every M04 count in this packet is a hand count
   with its method stated (§9.7 of the packet says so in the worker's own terms).
   It must land before any `SO-` quotes an M04 coverage fraction. Carried from
   `J-dv_lead-0179` item 6 through `-0187` item 5, unchanged.
5. **Class D2 is materially more likely this round than in any previous M04
   round**, and I say so in the packet rather than discovering it: the decoder's
   `gaps`, `start_spacings` and multi-frame `frames` are landed, unit-tested, and
   **have never been called from this directory**, because a one-frame run
   completes no gap. If one of them is wrong, the red will look like a design
   defect and it is mine to separate.
6. **Carried, unchanged**: the whole-suite verdict is CI's and the `9a596e7`
   repair's CI adjudication is still open; `J-dv_lead-0184` item 5 still stands
   (no test, plan row or spec claim of mine may cite that round's mutation-hunk
   reads, and this packet cites none); `SO-xgmii_rx_64.md` §2.2-D's green half
   remains owed against a gate SHA that does not exist.

### Files-in-this-commit
- agents/handoffs/WO-0082_tb-m04-two-frame-presenter-and-g10.md

## [J-dv_lead-0189] 2026-08-11T21:57Z | task:none | Three subjects countersigned and no clause refused outright — the noise-bound scenario proven unwritable against its own harness, the ground offered for the CI warning found to convict the blob gate that already refuses, and the refusal's second ground naming the wrong rule; and the slow bound fired live during the round, on my own worker, from a defect in my own work order

### Trigger

Orchestrator dispatch, **one round**: my design countersignature on
`ADR-0021` subjects **1**, **2** and **4**, per that ADR's own §9 route.
Subject 3 is rtl_lead's and I did not read it for verdict. Write allowance:
this journal, volume 11, and nothing else. Verdicts return verbatim; I do not
commit.

**Abort-first precheck, run before any file was opened.**

    git status --short                 #  M test/xgmii_tx_64/{bench.ml,bench.mli,dune,
                                       #    test_m04_a.ml,test_m04_b.ml,test_m04_g.ml}
                                       #  ?? test/xgmii_tx_64/test_m04_f.ml
    git rev-parse HEAD                 # 287b5eee39b98f8ab8ce23e319f141a0e32cddad
    git rev-parse --abbrev-ref HEAD    # claude/fpga-hardcaml-agent-orchestration-37ceyf
    date -u                            # Tue Aug 11 21:43:46 UTC 2026

HEAD byte-equal to the dispatched `287b5ee`. Every dirty path sat inside
`test/xgmii_tx_64/**` — the tb_writer lane the dispatch declared, executing my
own `WO-0082`, inside the scope that work order names. No path outside a
declared lane's scope appeared, so the forensic-refusal branch was not reached.

**The sibling clause fired twice and I record both discharges.** Mid-round HEAD
moved to `65ba148` (`Agent: tb_writer`, `J-tb_writer-0045`, `WO-0082` stage one)
and the tree's dirty set changed to ` M docs/PROCESS.md` — the architect lane,
also declared, also in scope. I re-verified rather than re-read: **eleven** read
surfaces compared by blob hash at `287b5ee` and `65ba148` — the ADR, all four
`scripts/`, `agents/PROTOCOL.md`, both workflows, the architect's `v05`, my
`v11`, and the auditor's posture report — **all eleven identical** (Evidence).
Every number below is then re-measured at `65ba148`, which is the SHA this
countersignature is pinned to.

### Inputs

- `agents/charters/dv_lead.md` and `agents/PROTOCOL.md` **in full**, first.
- `docs/adr/ADR-0021-a-check-is-only-where-it-runs.md` **whole**, twice — §2,
  §3 and §5 line by line; §4 read once for context and **not for verdict**
  (subject 3 is rtl_lead's countersignature, §9).
- `agents/journals/claude_architect_docs_lead_agent.v05.md`
  `J-architect_docs_lead-0049` **whole**, including its Evidence and its
  Open-questions.
- `scripts/agent_commit.sh`, `scripts/check_journals.sh` **in full**;
  `scripts/policy.sh` for the parameter block and the chain resolvers;
  `scripts/test_protocol.sh` for its harness (`expect_ok`, `expect_fail`,
  `seed_journal`, `seed_volume`, `entry`) and for `S37`, `S38`, `S39`.
- `.github/workflows/journal-check.yml` **in full**.
- `docs/adr/ADR-0016-a-seal-is-a-file-or-it-is-not-a-seal.md` §6.1–§6.5 —
  my own rider at §6.4 note 5, and §6.4's shell-form notes, both of which bear
  directly on this ADR's three new advisory instances.
- `docs/reports/audit/PROCESS-claims-posture.md` rows `C-46`, `C-55`, `C-56`,
  `C-57` and its `F3` row (the auditor's, not mine — see §4 below).
- My own chain: `J-dv_lead-0185` §10 (`FINDING REC-5`) and §11 lesson (e);
  `J-dv_lead-0188`'s harvest for the banked-candidate lettering.
- `agents/journals/workers/claude_tb_writer_agent.v03.md` `J-tb_writer-0045`
  header, Trigger and Open-questions — read **after** the mid-round HEAD move,
  because the census flagged it (§1.9).
- **No RTL, no spec text, no `libs/**` or `top/**` source read.** No
  `Essenceia/Nasdaq-HFT-FPGA` material consulted.

### Reasoning

#### 0. What a countersignature has to be, and what I refused to let it be

The §9 route asks this seat for a **design** countersignature on two mechanisms
and, on subject 4, for something narrower and harder: *the constrained party's
check that the refusal grounds are exactly right.* Neither is discharged by
agreeing. My rule for the round, stated before I opened the ADR: **every number
in the file gets re-measured at my own SHA, and every mechanism gets checked
against the harness that has to hold it** — because a design countersignature
that certifies a mechanism nobody has tried to build is the same object as a
green suite that never ran.

That rule produced the round's four substantive findings, and three of them are
things the file cannot see from where it was written: the ADR was drafted by the
seat that owns `docs/**`, and the two objects that convict it are
`scripts/test_protocol.sh`'s fixture generator and `R11`'s own text.

**Verdicts up front**, each detailed below:

| subject | verdict |
|---|---|
| **1 — `WARN-STAMP`** | **COUNTERSIGNED**, narrowed at four points (this entry §1.2–§1.5), with **one scenario owed and three not writable as specified** (§1.6) and one implementation constraint carried forward from `ADR-0016` §6.4 (§1.7) |
| **2 — `R10` size on CI** | **COUNTERSIGNED** on the predicate, the granularity and the posture; **one ground REFUSED as stated** (this entry §2.1) because this repository's own `R11` is its counterexample, with a replacement ground supplied |
| **4 — `REC-5`** | **dispositions COUNTERSIGNED**; the three-limb byte-check **ADOPTED**, limb 2 endorsed and **promoted** (this entry §3.3); the ADR's §5.1 second ground **NARROWED** — it names the wrong rule (§3.2); its §5.2 completeness claim **NOT COUNTERSIGNED** — a third case exists and is untraced (§3.4) |
| `FINDING ADR21-1` | **CORROBORATED and sharpened**: it is not merely an enumeration gap, it is the realised form of the hazard my own `ADR-0016` §6.4 rider named (this entry §4) |

Nothing here is refused outright. Two things are refused **as written** and both
come with the text that fixes them.

---

#### 1. Subject 1 — what I sign, and one ground the ADR does not state

I countersign, in full: the ±60-minute band on **both** surfaces; **warning,
never refusal**; the fast/slow bounds exposed as **separate parameters**; the
`compliant-run` counter with reset-on-drift; and the per-entry / per-chain
output split. The predicate at §2.2 is exact, the join is exact, and the
`--all` summary block **reproduces at my SHA** to the tenth of a minute on all
seven chains (§1.1 below).

**The ground for warning-never-refusal that §2.1 omits, and which I supply as
the seat that would be constrained by the alternative.** Constraint (i) is
recorded as *"`R3` freezes committed stamps; a blocking check makes a legitimate
re-commit of an already-authored entry unfixable, and the defect guarded is
testimony, not structure."* True, and insufficient. The decisive ground is
harsher: **a blocking stamp check pays its subject to lie.** `R3` makes the
stamp unfixable *by honest means* — the entry is written, the stamp was read at
authoring, and the only edit that clears a refusal is to write a stamp that is
not the time the entry was written. A gate whose sole available remedy is to
falsify the evidence it grades does not measure honesty; it selects for the
falsification. That is why this may only ever be a counter, and it is a stronger
statement than "unfixable", because it says what the round *would* do rather
than what it could not do.

§1.9 below turns this from an argument into an observation: the check's first
live out-of-band entry after the ADR was proposed is one whose author is
**forbidden by my own work order** from reading a clock, disclosed the estimate
in the header and in Open-questions, and asked for a ruling. A refusal would
have blocked the most honest behaviour available to that seat under a constraint
imposed by me.

##### 1.1 The §2.4 block is real — re-measured at my SHA, on a moved record

§2.4 stakes the design as a **testable prediction**, so I tested it rather than
quoting it. At `287b5ee` (602 entries) the per-chain table matched the ADR's
`b19ff91` figures exactly, with the two intervening entries appearing where the
design says they must: both in band, so `out` did not move and two
`compliant-run` columns incremented (architect 8 → 9, auditor 4 → 5). The
"latest" cell of all seven chains reproduced **to the tenth of a minute**.

At `65ba148` (603 entries): **372 out of 603**, fast 369, slow **3**,
unparseable **0**, merges 0. `dv_lead 188/153 run 10 · orchestrator 265/150
run 15 · architect_docs_lead 49/36 run 9 · tb_writer 45/19 run 0 · rtl_lead
24/7 run 16 · auditor 23/4 run 5 · data_wrangler 9/3 run 0`. The fraction the
auditor measured holds; the counts move with the record, exactly as §2.1 says.

##### 1.2 …and the one column that does not say what it is

Reproducing the block is how I found this. The ADR prints, per chain,
`latest J-dv_lead-0178 (+164.9m)` beside `compliant-run 10`. Two readings fit
that shape: *the chain's latest entry*, or *the chain's latest out-of-band
entry*. **The numbers admit only the second** — I computed both and only
"latest out-of-band" reproduces all seven cells (dv_lead's actual latest entry
at my SHA is `-0188` at −3.1 min, not `-0178` at +164.9 min; the block's own
`compliant-run 10` is what forces the reading, since 0179–0188 are the ten
in-band entries).

Why this is not pedantry: §2.4 declares the block a prediction and names its
falsifier as *"different totals or a different line count"*. **Neither
discriminates the two readings.** An implementation that prints the chain's
latest entry produces identical totals and an identical line count while
contradicting the block cell for cell — it would pass the ADR's own stated test
and fail the ADR. **Required before acceptance**: one clause fixing the column
as *the most recent out-of-band entry of that chain, with its drift*. The rest
of the block is unambiguous.

##### 1.3 The tip signal has a documented fallback where it is not a tip signal

§2.3's design rests on a real property of `journal-check.yml` — `--all` and
`--range` are already separate steps with separate logs — and the conclusion
drawn is *"a new violation appears as its own line in the range step."* Checked
against the workflow: the range step computes `RANGE` from the event, and
**when it cannot** (`github.event.before` absent or all-zero, or not present in
the fetched history) it runs **`check_journals.sh --all`** as its fallback
(`journal-check.yml`:33–47). On that push both steps are `--all`, both emit the
chain aggregate, and **no per-entry line is emitted at all** — the tip signal
the design is built around is unavailable on exactly the push where history is
least well known.

This is narrow and it is not a defect in the design; it is a limit of the
surface the design leases. It must be **stated**, because it is precisely this
ADR's own thesis — a check is only where it runs — applied to itself. One
sentence in §2.3: *on the fallback path the range step degrades to the history
view and the new violation is visible only inside its chain's aggregate.*

##### 1.4 The stream is unspecified, and one scenario counts lines on it

Neither §2.4 nor §2.5 says whether `WARN-STAMP` goes to stdout or stderr. It
matters twice: `S43` asserts `grep -c '^WARN-STAMP'` equals exactly `3 + 2`, and
the summary is specified to print *"immediately before the final `OK:` line"* —
which is a claim about interleaving that is only true within one stream.
`agent_commit.sh`'s existing `WARN-JOURNAL` goes to **stderr** (`:181`), and
constraint (ii)'s whole ground is that this is *"a new instance, not a new
class"*. **Pin it to stderr on both surfaces**, and restate the placement claim
as *last output before the verdict line*, which is what a merged CI log shows
and what a scenario capturing `2>&1` can assert.

##### 1.5 `compliant-run` is cheaper than the ADR claims, and I verified it

§2.4 argues the counter is zero-state. It is more than that, and the stronger
property is worth recording because it answers the only real objection to
putting a counter in a full-history checker — cost, which is what gets checks
deleted:

- **Single pass, one integer per chain.** `check_journals.sh --all` already
  walks commits **oldest-first** (`:24`, `git rev-list --reverse`). So
  `run[agent] = run[agent] + 1` when in band and `0` when not, evaluated in the
  loop that already exists, leaves `run[agent]` equal to the consecutive
  most-recent in-band count at the end. No second walk, no sort, no state file.
  The same pass yields the totals, the per-chain `out` counts and the
  latest-out-of-band cells.
- **Zero added git invocations per commit**, if `ref` is taken from the
  `git show -s` call the loop already makes (`:58`) by extending its format to
  `%at%n%B` and stripping the first line. A naive implementation adds one
  `git log -1` per commit — 603 subprocesses per push today, growing linearly
  forever, on a check whose entire justification is that it is cheap.

Both are implementation notes, not conditions of my signature; I record them
because the ADR's own noise argument is about what makes a check survive.

##### 1.6 The scenario set: one owed, and three not writable as specified

§11(3) is binding here and `S40`–`S46` is what discharges it. I read them
against `scripts/test_protocol.sh` as it stands, which is the only test the
scenarios can be judged by, and **three of the seven cannot be written as
specified**:

- **`entry()` hard-codes the stamp `2026-08-01T00:00:00Z`** (`:78–100`) for
  every fixture entry in the suite, while the fixture's commit is created at the
  suite's real run time. Consequence: after this lands, **every pre-existing
  fixture in the suite is days out of band and grows further out of band with
  wall-clock time.**
  - **`S40` — the positive control — is unwritable.** It requires *"a commit
    whose entry stamp is 10 minutes before the run"* and asserts the **absence**
    of output. The generator cannot express "10 minutes before the run".
  - **`S43` — the noise bound — is uncountable.** It asserts `grep -c` equals
    exactly `3 + 2` over *"a history with five out-of-band entries across two
    chains"*. The suite's scratch repo reaches `S43` already carrying dozens of
    fixture commits across **three or more** chains, all out of band by the
    hard-coded stamp. The count cannot be 5 unless `S43` builds its own repo.
  - **The fix is one line and it is strictly better than a workaround**: make
    `entry()` take an optional stamp defaulting to `date -u
    +%Y-%m-%dT%H:%M:%SZ`. Every existing fixture becomes in-band, `S40`'s
    silence assertion becomes the suite-wide default, `S43`'s count becomes
    exact, and the suite stops being time-fragile. `S41`/`S44`/`S45` then pass
    their stamps explicitly, which they must do anyway.
- **`S45` — the boundary — is a race on the surface it is written for.** It
  sets `JOURNAL_STAMP_FAST_MAX` to *"the fixture's exact drift in seconds"* and
  asserts strict `>`. On the **commit** surface `ref` is the script's own
  `date -u +%s`, read **after** the fixture is written and staged; the drift the
  check computes therefore differs from any drift the scenario can compute, by
  the elapsed runtime, and a one-second boundary assertion flips on scheduling.
  **On the history surface it is deterministic**: `ref` is the commit's author
  time, a frozen value the scenario can read back with `git log -1 --format=%at`
  after committing. **`S45` must be placed on `check_journals.sh`**, and the
  commit surface gets the coarse case (`S41`) only.
- **`expect_ok` discards both streams** (`:20`, `> /dev/null 2>&1`). `S40`
  (assert absence), `S41` (assert exit 0 **and** a line) and `S43` (count lines)
  all need a capturing assertion. `S39` is the suite's precedent for a bespoke
  inline form, so this costs a helper, not a redesign. Recording it because the
  failure mode is specific and ugly: written with `expect_ok`, `S40` passes
  **vacuously and permanently**, and `S40` is the scenario whose entire job is to
  prove the mechanism is not firing unconditionally.

**One scenario owed and not in the set — `S50`, the rotation case.** Of the
seven failure modes, `F7` is the only one whose mechanism is non-obvious and
whose assertion appears nowhere: on a rotation commit the appended region is the
**whole new volume**, beginning with the §4.3 header block, and the design's
claim is that extraction keys on the `## [J-…]` line rather than on position. I
verified the claim holds against both scripts as written (the appended region is
computed identically, and `R5`'s single-header count is what makes "the ONE
entry" single-valued). But an unasserted claim about a fixture shape that only
occurs at rotations is exactly the claim that breaks silently three volumes
later. **`S50`: a rotation commit whose entry stamp is out of band emits exactly
one `WARN-STAMP`, naming the entry id — not the volume header, not two lines.**
`S37` already builds the rotation fixture, so the cost is a few lines.

**One offered, not required — `S51`.** `--range`'s `JOURNAL_STAMP_LIST_MAX`
aggregation path (§2.3) has no scenario, and by §6's own sizing it will
essentially never execute in production, which is the argument for testing it
rather than against. Cheap via the parameter: `JOURNAL_STAMP_LIST_MAX=2` over a
three-violation range gives two entry lines plus an aggregate.

##### 1.7 The shell-form constraint, inherited rather than invented

`ADR-0016` §6.4 recorded, for an advisory check in these same two scripts:
*"`if [ … ]; then fail; fi`, never `[ … ] && fail`. Both scripts run
`set -euo pipefail`; a bare `[ … ] && …` whose test is false returns 1 and kills
the script on the compliant path — the check would then fail **only** the commits
it approves of."* This ADR adds **three** advisory instances to those same two
scripts and does not carry the note forward. It applies unchanged, and it
applies with extra force to `F4`'s `date -u -d` probe and to every subsequent
`date -u -d` call, which must be guarded so that a parse failure cannot become
an exit — the worst possible outcome for a warning-never-refusal decision is a
warning that turns into a refusal by shell accident. `S44` and `S46` assert exit
0 on **both** surfaces, so the scenario set does cover it; the note belongs in
the ADR so the implementer does not have to rediscover it from a red suite.

Two smaller extraction notes, both cheap and both invisible from the doc side:
strip through the **first** `]` (a title containing `]` breaks a greedy strip),
and account for the space that follows it — `^[0-9]{4}-…` anchored against the
raw remainder matches nothing. `S40` catches both, which is the argument for
`S40` being written first, as §2.7 says.

##### 1.8 The two chains whose counter routes to me

§3.3's principle — *report at the granularity of the seat that can act* — is
right, and it has a wrinkle on exactly two of the seven chains. `tb_writer` and
`data_wrangler` are **shared worker-template journals**: the chain is written by
a succession of transient spawns, not by a persistent seat. A `compliant-run`
reset there does not indict an identity that will read it; the identities that
can act are the **orchestrator**, which mints the spawn short-id (the auditor's
identified transmission vector), and the **commissioning lead** — which for both
of those chains is **me**. At my SHA both read **0**. I take the routing rather
than note it: §2.9 is the first instalment.

##### 1.9 The slow bound fired live, on my worker, from a defect in my own work order

The mid-round sibling commit `65ba148` landed `J-tb_writer-0045`. My census
flagged it immediately: **−382.5 minutes**, the **third** slow-side violation in
603 entries, and `tb_writer`'s `compliant-run` went **10 → 0**. I read the entry
rather than scoring it, and the cause is mine:

> *"`date -u` is not in this round's allow-list (only `git status --short` and
> `git rev-parse HEAD`, each once, are carved out), and `BM17` is armed this
> round … so I chose NOT to attempt `date -u` at all rather than
> attempt-and-disclose. This entry's UTC timestamp is therefore the
> system-provided `currentDate` context with an estimated time-of-day … stated
> here as an estimate rather than presented as measured. If this reasoning is
> wrong, it is a live disagreement I want dv_lead's or the orchestrator's ruling
> on."* — `J-tb_writer-0045`, Open-questions

Five things follow, and each is evidence about the ADR rather than about the
worker.

1. **It is a true positive, not `F5`'s false positive.** §2.5 `F5` pre-declares
   the review trigger: *"if the slow bound ever fires on an entry whose round
   genuinely ran long, that is a false positive and the bound moves — the
   practice does not."* The trigger has now fired, **before implementation**, and
   this instance does **not** meet its condition: the drift is not a long round
   honestly stamped at authoring, it is a stamp that was never measured. **The
   bound does not move on this case**, and I record that so the first datum
   cannot be used to widen the band.
2. **A second transmission vector, which no stamp check can cure.** The
   auditor's diagnosis located the vector in `PROTOCOL` §4.1's spawn short-id.
   Here it is a **missing command permission in the work order I wrote**: a seat
   required by §4.1 to produce a UTC stamp, and forbidden by its `WO` allow-list
   from reading a clock, will estimate. The counter would surface it on the next
   push; only I can fix it.
3. **My ruling on the live disagreement, since the worker asked for it by
   name.** The worker's conduct was correct on every axis available to it —
   it did not exceed its allow-list, it did not present an estimate as a
   measurement, it disclosed in the header *and* in Open-questions, and it
   escalated. **The defect is my allow-list.** `date -u` is read-only,
   side-effect-free, and is the instrument §4.1 requires the output of; omitting
   it from an allow-list while demanding its result is a work order that cannot
   be satisfied honestly. **From my next `WO` revision, `date -u` is carved out
   explicitly, with the instruction to read it at authoring and to record the
   reading in Evidence.** I cannot pay it this round — `agents/handoffs/**` is
   in my scope but not in this round's write allowance — so it is carried as an
   Open-question with an owner, which is me.
4. **The estimate class is not a one-off, and the ADR's measured ground moves.**
   §2.2 records *"one carries a trailing parenthetical"* and §10 repeats it as
   *"one of 600 stamps"*. At `65ba148` it is **two of 603** — the same chain, the
   consecutive entry, the same recorded reason — and the reason is **structural**,
   so it recurs until I fix the `WO`. The design handles it correctly and its
   justification survives intact; the sentence describing it as a singleton does
   not. One clause: *a self-qualified stamp is a recurring practice of at least
   one chain, with a recorded cause outside the grammar.*
5. **And it demonstrates precisely what the counter measures.** `-0044` carried
   the same qualifier and the same estimation method and landed **in band** at
   −11.8 min; `-0045` carried them and landed 382 minutes out. Same practice,
   twelve hours apart, opposite verdicts — the in-band result was **luck**. That
   is §2.6's first bound, empirically: *the check separates drift from
   compliance, not truth from falsehood.* I know of no better illustration and
   the ADR does not have one yet.

---

#### 2. Subject 2 — countersigned, and one ground refused as stated

I countersign the size limb into `check_journals.sh`; the **active-volume**
predicate; the **frozen-aggregate / active-itemise** granularity; and the
**warning** posture. My standing here is the both-surfaces corollary the ADR
credits to my `ADR-0016` §6.4 rider, and I take the attribution with one
correction of direction: my rider argued the **CI** check belonged **also on the
commit path** (*"the higher-value of the two placements and the one I would
implement first"*) and named the failure mode as the check becoming the
operative authority by accident. Subjects 1 and 2 run the corollary the other
way. Same rule, both directions; the credit is fair and the record should say
which way it pointed. The rows the dispatch attributes to me — `C-46`, `C-55`,
`C-56` — are the **auditor's**, in the auditor's report; I rely on them, I do not
own them.

**The measurements reproduce at `65ba148`** (Evidence): 95 commits with an
active volume over `S`, 48 over `H`, **18** distinct `(agent, volume)` pairs ever
over `S` while active, **1** ever over `H` — my own frozen
`claude_dv_lead_agent.md` at 1,123,442 B. The `--all` size block is therefore
three lines today, exactly as §3.3 predicts. The active-volume predicate is
correct and its justification is not aesthetic: a whole-tree predicate would
flag my frozen volume on every commit from its rotation to the end of the
program, an alarm with no act attached — and I am the seat that would be named
by it forever, which is why I am the right seat to confirm the choice is not
self-serving. It is forced by the fact that `agent_commit.sh`'s subject is the
**staged active volume** (`:177`), and the point of the change is that the two
surfaces evaluate the same predicate.

##### 2.1 The ground offered for warning-not-refusal convicts `R11`

§3.4 states, in bold, the ground the whole posture decision rests on:

> **A rule whose only remedy is forbidden cannot be a refusal in a full-history
> checker.**

**I do not countersign that sentence, and the reason is one file away.** This
repository already contains a refusal in a full-history checker whose only
remedy is equally forbidden: **`R11`**, the CI blob gate. `check_journals.sh`
reads `git cat-file -s "$C:$path"` **at the commit where the path changed**
(`:203–210`), so a landed oversized blob fails `--all` at that commit forever; a
later deletion does not clear it, because the check never looks at HEAD. The
only remedy is a history rewrite, which `R9` forbids — the identical structure,
the identical bypass-only entry path, and the ADR **accepts it** two bullets
later (*"a permanent red is proportionate"*).

So the sentence, read as the general principle its bolding invites, convicts a
rule this program enforces and intends to keep. The work is actually done by the
**second** bullet, and it should be promoted to the ground:

> **A permanent red is proportionate to harm that persists in every future
> reader, and disproportionate to harm bounded by one file's readability.** A
> landed multi-megabyte blob costs every future clone until someone deals with
> it; an oversized journal volume costs the readability of one file and its cure
> is available prospectively and unilaterally to its owner. That is why `R11`
> refuses where `R10`'s size limb warns.

Bullet 1 survives as a **premise** of that test — it establishes that the cost of
refusing is permanent — not as the test itself.

**Why this is not a wording quibble.** §8 drafts the `R10` sentence for
`agents/PROTOCOL.md` and recites the refuted form verbatim: *"CI evaluates the
same bound over history and reports it as a warning, **because the only remedy
for a landed oversized volume is a rotation that lies in the future and a history
rewrite is forbidden by `R9`**."* If that text is adopted, the **constitution**
will state a principle that its own `R11` — two paragraphs later in the same
draft — breaks. `FINDING ADR21-1`'s repair would then import a contradiction as
its first act. **Required before that text is applied**: the proportionality
ground, not the remedy ground.

##### 2.2 The alternative §3.4 does not name

For completeness, and because the grounds are the appealable object: the variant
that escapes bullet 1 entirely is **refuse on the active volume at HEAD, warn
over history**. Its remedy — rotation — is available, unilateral and in the
owner's own hands, so no history rewrite is ever implied. Bullet 1 does not
reach it; **bullet 3 does** (a block that stops every other seat's push until one
seat rotates, which is a round). I name it so a later round does not present it
as an unconsidered option, and I **do not press it**: the warning is the right
posture, on the proportionality ground above.

##### 2.3 The block's third line is one entry from changing, on two chains

§3.3's third line reads *"active volumes at HEAD: all within `S`"*. At
`65ba148`, against `S` = 262,144: the auditor's active volume is **258,341 B**
(3,803 B of headroom) and tb_writer's is **246,595 B** (15,549 B). Both chains
write entries of tens of kilobytes. **The first itemised active-volume line is
one entry away, and probably two lines within two rounds.** That is worth
recording for three reasons: it dates the design's first live output; it is the
strongest available argument that itemising the active volume was the right
call, since the itemised line will be actionable by a named seat on the day it
appears; and it means `S49`'s predicate — the one thing a later simplification
would get wrong — will be exercised by production almost immediately.

---

#### 3. Subject 4 — the constrained party's check

`REC-5` is my finding, disclosed against myself, and the seat whose practice the
adopted procedure binds is the sole committer, not me. So what §9 asks for here
is not agreement but adversarial reading of the grounds *by the party with the
motive to accept them too easily*. I countersign the dispositions and I contest
two grounds.

##### 3.1 Signed

- **ADOPTED AS PROCEDURE / REFUSED AS MECHANISM** — signed. The tree-watcher
  refusal is right twice over: there is no process between rounds to run it in,
  and my own banked lesson (e) already says the durable rule is about **where a
  preview is built**, not about watching.
- **§5.3's re-framing of the residue from paths to hunks** — signed, and it is
  the correct correction to the dispatch's framing. `R4` compares two **sorted
  path lists** (`agent_commit.sh`:187–196); it cannot see inside a file. The
  residue is an unintended hunk inside a legitimately staged path, it requires
  two conditions to coincide, and no mechanism reaches it — *prevented by
  procedure, caught by audit, mechanically refusable at neither end*. That is my
  own `ADR-0016` §5.3 distinction and I sign it in the form given.
- **The three-limb byte-check** — adopted, including the evidence form. §5.4's
  ground is the one that matters: `J-orchestrator-0226`'s habit decayed in three
  entries, and adopting a second unmeasurable habit in the document whose
  subject 1 exists *because* of that decay would have been self-refuting. A
  practice that leaves a grep-able trace in Evidence is a practice an auditor can
  measure over the whole record without owning the scripts or the constitution.

##### 3.2 §5.1's second ground names the wrong rule

The refusal-as-mechanism grounds are recorded as three, of which the second is:

> *`agent_commit.sh` already refuses the commit path under any non-orchestrator
> trailer (`R7` — the actual landing gate held even during the incident).*

**True as a sentence about non-orchestrator trailers, and it does not reach the
hazard my own disclosure recorded.** From `J-dv_lead-0185` §10, in my words at
the time: *"`R7` binds at commit time and I never commit, so this could not have
entered history by my hand. **It could have entered by another's**"* — and the
another is the **orchestrator**, which has `agents/PROTOCOL.md` **inside** its
`§6` scope. For the one agent that could actually have landed the stray write,
`R7` is not a gate at all; it permits the path by construction.

So the accurate statement of what stood between the incident and a landed
unauthorised constitutional amendment is:

- **`R7`** — irrelevant in the live window, because the seat at risk of staging
  it was the one seat allowed to.
- **`R4`** — the real gate: the orchestrator's entry, authored from its round's
  intent, would not have listed `agents/PROTOCOL.md`, and set-equality would have
  refused the commit and printed the path in its `--- claimed vs staged ---`
  diff.
- **and, in fact, nothing** — because no commit was attempted in the window. My
  own summary stands: *the guard that would have caught it was luck plus a status
  read, which is not a guard.*

**Required**: ground 2 cites **`R4`**, not `R7`. This is not bookkeeping. `R4`
is the gate §5.2 then proves is **conditional on limb 2** — so correcting the
citation promotes limb 2 from a bonus discovered in passing to **the condition on
which the refusal's second ground depends**. A reader of the uncorrected text
would conclude the incident was covered by a mechanism that in fact never
engaged.

##### 3.3 Limb 2 is the round's best output; one clause of it is stronger than it needs to be

The tautology trace is correct and it is new: `PROTOCOL` §4.1 requires the entry
before the **commit**, not before the **staging**, so a files list transcribed
from `git diff --cached --name-only` satisfies `R4` by deriving the claim from
the thing the claim is supposed to check. I verified the mechanism against
`agent_commit.sh`:187–196 — both sides are `LC_ALL=C sort -u`'d and compared, so
the check is a pure set comparison with no provenance anywhere in it. The
conclusion holds and I endorse limb 2 without reservation.

One precision, offered because a later round will try to mechanise it: the ADR
says *"no script can tell the two authoring orders apart — the index looks
identical either way."* The claim about the **index** is exactly right. The claim
about **scripts** is very slightly overbroad: one residual signal survives in the
**entry text**, namely the list's **ordering**, since `git diff --cached
--name-only` emits sorted paths while an intent-authored list usually follows the
round's narrative order — and `R4` discards it by sorting both sides before
comparison. It is a weak signal, degenerate for one- and two-path commits, and
unusable as a gate. **Say "no reliable script"**, and record that the one signal
that exists is ordering, so the next round that wants a mechanical limb 2 starts
from what is actually there rather than from scratch.

##### 3.4 The offered warning's refusal: not countersigned as complete, because §5.2 produced a third case

§5.2 refuses the offered `agents/PROTOCOL.md`-staging warning on the ground that
it *"fires in neither of the two cases that matter"* — Case A (accidental stage:
`R4` already refuses, so a warning is strictly weaker) and Case B (legitimate
amendment: the entry's body names the path, so the predicate is false and the
warning is silent). Both traces are correct **and the enumeration is not
exhaustive**, because the same section then discovers the case that breaks it:

> **Case A′ — the accidental stage with an index-derived files list.** The
> committer stages first and transcribes `Files-in-this-commit` from
> `git diff --cached --name-only`. The stray `agents/PROTOCOL.md` is carried into
> the list. **`R4` passes** — tautologically, which is limb 2's whole point. And
> the offered predicate — *the path is staged and the entry's body does not name
> it* — **is true**, because the narrative was written from a round whose subject
> is something else.

So the warning is **redundant** in Case A, **silent** in Case B, and **live in
Case A′ — the only case in which the mechanical guard is defeated**. That is the
opposite of the refusal's stated ground.

**The refusal may still be correct; the ground as written is not.** Whether the
warning fires in A′ turns on a reading the ADR never pins: if *"the entry's
body"* includes the `Files-in-this-commit` section, the transcribed list names
the path and the warning is silent in A′ too, and the refusal is complete as
argued. If *"body"* means the narrative sections — which is the only reading
under which the predicate carries information, since the files list is `R4`'s
operand — it fires. **The two readings differ in exactly the case that decides
the subject, and the ADR chooses neither.**

What I require before acceptance, stated as alternatives so the seat that owns
the decision keeps it:

1. **Pin the predicate's reading**, and if it is the broad one, say so — the
   refusal then stands as argued and A′ is disposed of in one clause; or
2. **Trace A′ under the narrow reading and refuse it on a ground that survives
   contact with it.** The available grounds are weaker than they look and I say
   so as the party who would benefit from the easy answer. *"The seat that
   transcribed from the index is the seat reading the warning"* is not much of a
   ground: transcribing from the index is a convenience, not a decision to evade
   — exactly the shape of `REC-5`'s own applier defaulting to the repository —
   and a seat taking a shortcut is not a seat that would ignore a line naming the
   constitution. And §5.5's *"the value of a warning channel is the silence
   around it"* does not reach this one: it was written to refuse an
   **unconditional** diffstat, and its force comes from that check having **no
   predicate**. A warning gated on *a constitutional path staged with no
   narrative mention* is not routine chatter; by the record it would fire
   approximately never.

**And I record the honest counterweight against my own point**, because a
countersignature that only pushes one way is advocacy. `REC-5` was caught by *a
status read reaching an attentive operator* — a low-grade advisory signal, which
is exactly what this warning would automate — and this ADR's subject 1 rests on
the doctrine that automating such a signal buys a schedule. That symmetry is the
strongest argument for adopting the warning, and it is why the refusal needs its
third case traced rather than assumed.

**Everything else in subject 4 I countersign as written.**

---

#### 4. `FINDING ADR21-1` — it is my own rider, realised

Within scope by the dispatch's leave, and I take it, because I have standing on
it that neither the raising seat nor the auditor has.

The finding is exact — I re-ran both greps at `65ba148`: `R10|R11|volume|rotate`
in `agents/PROTOCOL.md` returns **0**, and
`JOURNAL_SOFT_MAX|JOURNAL_HARD_MAX` in `scripts/check_journals.sh` returns
**0**. It corroborates the auditor's `C-46`/`C-55`/`C-56` and exceeds them:
those rows convict the *scripts'* asymmetry, this convicts the *constitution's*
silence, and the two are independent defects that happen to share a rule family.

**What I add is the failure mode, and it is one I already named.** My rider at
`ADR-0016` §6.4 note 5 said, of a check whose naming convention was not in the
rule text: *"otherwise the rule and its check disagree about what compliance
**is**, and the check becomes the operative authority by accident."* I wrote that
as a precondition on flipping a switch. `R10` and `R11` are that hazard in its
completed form — not a check drifting from a rule, but **a check with no rule at
all**. Consequences that follow immediately, and that neither `C-46` nor §3.5
states:

- **The threshold's value is currently amendable without an ADR.**
  `JOURNAL_SOFT_MAX` and `JOURNAL_HARD_MAX` are env-overridable defaults in
  `scripts/policy.sh`. `ADR-0017` §5.1 makes a threshold change *"a policy edit
  that restates the anchor"* — which presupposes a rule the anchor belongs to.
  With no constitutional text, the only statement of `R10` **is** the script, so
  editing the script does not *implement* a rule change, it *is* the rule change,
  and §11's ADR requirement has nothing to bind to.
- **`PROTOCOL` §5's own CI paragraph is affirmatively wrong**, not merely
  incomplete: it says CI *"re-checks `R1`–`R8`"* while `check_journals.sh`
  refuses under `R10`'s chain limb and `R11`. A fresh orchestrator rehydrating
  from `BOARD.md` → `PROTOCOL` → charters (§9) cannot discover from the
  constitution the two rules most likely to stop its first push.
- **It raises the cost of getting §8's draft text right** — which is this entry's §2.1 above.
  The repair is the first constitutional statement these two rules will ever
  have; the ground it carries becomes the ground.

**My recommendation to the orchestrator**, which is all a countersignature can
be here: route it in the implementing act rather than as its own round, applying
`ADR-0017` §8.1–§8.3 plus §8's two sentences **with the proportionality ground
substituted**. And I agree it is correctly **not** a precondition of this ADR.

---

#### 5. What I did not do, stated so the boundary is visible

- **I did not read subject 3 for verdict.** §9 assigns it to rtl_lead as a
  factual check that its derivation is transcribed, and blocks it on that seat
  alone. I read §4 once for context and my signature says nothing about it —
  including nothing about §4.6's remark that `tools/` is *"dv_lead's scope, which
  would make an RTL-line instrument a DV artifact and put the verifying seat
  inside the instrument it verifies with."* I agree with the conclusion and note
  only that it is the correct reason, not a scoping convenience.
- **I ran no build, no `dune`, no `opam`** — absent from this container, as my
  prior rounds record. Every measurement below is `git` and coreutils.
- **I wrote no file but this journal**, and I did not stage, commit or push. No
  stop-hook commit demand was honoured.

#### 6. Harvest

**Not due, declared rather than skipped** (charter §8, `PROTOCOL` §7): this round
is neither an `SO-` issuance nor a phase gate — it is a countersignature. **My
open span continues unbroken from `J-dv_lead-0183` through `-0188` and this entry
joins it.** **Three candidates banked**, LH1–LH3 discharged, all **LH2-g** (no
proper noun of any kind inside the rule statement); lettering continues the arc's
shared sequence after (m)/(n).

- **(o)** *A self-test whose fixture generator hard-codes a value that the rule
  under test compares against the run's own clock can assert neither the rule's
  silence nor its count; the generator must derive that value at run time.*
  **LH1** this round's reading of the three owed scenarios against the harness —
  the positive control unwritable and the noise-bound count unreachable, both
  from one hard-coded constant in the fixture generator. **LH3** without it the
  owed cases are written by weakening their assertions until they pass, and the
  check ships with its own positive control disabled — which is indistinguishable
  from shipping no check.
- **(p)** *An exact-threshold case belongs on the surface where both operands are
  frozen values; where one operand is the checking process's own clock, read
  after the fixture is written, the case is a race and its green means nothing.*
  **LH1** this round's boundary scenario, specified for the surface whose
  reference is a live clock read. **LH3** without it a boundary test passes or
  fails on scheduling and is eventually stabilised by widening the tolerance until
  it no longer pins the boundary it was written for.
- **(q)** *A ground stated as a general principle must be run against the rules
  the system already enforces; a principle that convicts an accepted rule is a
  preference wearing a principle's clothes, and adopting it into constitutional
  text imports the contradiction along with the repair.* **LH1** this round's
  remedy-availability ground, refuted by the full-history refusal already in the
  same checker, with the refuted form already drafted for constitutional
  adoption. **LH3** without it the amendment that repairs an enumeration gap is
  the amendment that installs a rule the system's own practice breaks, and the
  contradiction is discovered by whoever next reasons from the text.

A fourth is **noted and not banked**: *a warning that fires only where a
mechanical guard is defeated is not redundant with that guard, and enumerating a
guard's cases without enumerating the case where it is defeated understates the
residue* (§3.4). It is close to LH2-g and I will re-test it at the next round
that traces a guard's coverage rather than admit it on the round that found it.

### Actions

- Ran the abort-first precheck; read charter and `PROTOCOL` in full; read
  `ADR-0021` whole twice and `J-architect_docs_lead-0049` whole.
- Read `agent_commit.sh`, `check_journals.sh` in full and `policy.sh`,
  `test_protocol.sh`, `journal-check.yml` for the specific mechanisms the ADR
  specifies against; re-read my own `ADR-0016` §6.4 for the rider and its
  shell-form notes.
- **Re-ran the ADR's §7.4 commands 1–4 in full at `287b5ee`, then again at
  `65ba148`** after the sibling move, and additionally derived the per-chain
  `compliant-run` and latest-out-of-band columns that §2.4's block asserts —
  the check the ADR's own falsifier does not perform (§1.2).
- Re-verified **eleven** read surfaces byte-identical across the HEAD move by
  blob hash before re-measuring.
- Checked `S40`–`S49` against `scripts/test_protocol.sh`'s actual harness
  (`entry`, `expect_ok`, `S37`, `S39`), which is what produced §1.6.
- Traced the `REC-5` refusal's grounds against my own `J-dv_lead-0185` §10 text
  and against `agent_commit.sh`'s `R4`/`R7` blocks, which produced §3.2 and §3.4.
- Read `J-tb_writer-0045`'s header, Trigger and Open-questions **after** the
  census flagged it, and ruled on the live disagreement it addressed to me
  (§1.9).
- Wrote this entry. **No file outside this journal is staged; no `git commit` or
  `git push` was run; no stop-hook commit demand was honoured.**

### Evidence

All commands read-only, from a checkout at **`65ba148`**, reproducible.
The ADR's own §7.4 carries commands 1–4 in its text; the derivations at (E2) and
(E5) are mine and are not in it.

**(E1) Precheck, the sibling move, and the read surfaces.**

    $ git rev-parse HEAD                 # at spawn
    287b5eee39b98f8ab8ce23e319f141a0e32cddad
    $ git status --short                 # at spawn: 7 paths, all test/xgmii_tx_64/**
    $ git rev-parse HEAD                 # mid-round
    65ba1480488d28f7163099ffb7598a768b62b646
    $ git log --oneline 287b5ee..HEAD
    65ba148 WO-0082 stage one executed …  # Agent: tb_writer, J-tb_writer-0045
    $ git diff --name-status 287b5ee..HEAD
    M agents/handoffs/WO-0082_…md · M agents/journals/workers/claude_tb_writer_agent.v03.md
    M test/xgmii_tx_64/{bench.ml,bench.mli,dune,test_m04_a.ml,test_m04_b.ml,test_m04_g.ml}
    A test/xgmii_tx_64/test_m04_f.ml
    $ git status --short                 # after the move
     M docs/PROCESS.md                   # the declared architect lane

    $ for f in <the eleven>; do
        [ "$(git rev-parse 287b5ee:$f)" = "$(git rev-parse HEAD:$f)" ] \
          && echo "SAME  $f" || echo "MOVED $f"; done
    SAME  (all eleven: the ADR, policy.sh, agent_commit.sh, check_journals.sh,
           test_protocol.sh, agents/PROTOCOL.md, journal-check.yml, build.yml,
           architect v05, my v11, PROCESS-claims-posture.md)

**(E2) Stamp census at `65ba148`** — §7.4 command 1, extended with the two
columns §2.4 asserts and the ADR does not give a command for:

    603 commits, 0 merges, 603 entry appends, 0 unparseable stamps
    372 outside +/-3600 s (61.7%)      fast 369    slow 3
    formats: 379 minute-precision, 222 second-precision, 2 with a trailing
             parenthetical qualifier  (was 1 of 600 at b19ff91 — J-tb_writer-0044;
             J-tb_writer-0045 is the second, same chain, next entry)
    per chain  entries / out / compliant-run:
      orchestrator 265/150/15 · dv_lead 188/153/10 · architect_docs_lead 49/36/9
      tb_writer 45/19/0 · rtl_lead 24/7/16 · auditor 23/4/5 · data_wrangler 9/3/0

    latest OUT-OF-BAND entry per chain, with drift:
      dv_lead J-dv_lead-0178 (+164.9m) · orchestrator J-orchestrator-0250 (+204.1m)
      architect_docs_lead J-architect_docs_lead-0040 (+703.8m)
      rtl_lead J-rtl_lead-0008 (+834.5m) · auditor J-auditor-0018 (+6422.3m)
      data_wrangler J-data_wrangler-0009 (+797.4m)
      tb_writer J-tb_writer-0045 (-382.5m)   <- new this round; was -0034 (+7404.9m)

    -> All seven cells of ADR §2.4's block reproduce EXACTLY under the reading
       "latest out-of-band entry", and NONE reproduce under "latest entry"
       (dv_lead's latest entry is -0188 at -3.1m, not -0178 at +164.9m). This is
       the derivation behind section 1.2.

**(E3) Active-volume size census at `65ba148`** — §7.4 command 2:

    603 commits: 95 with an active volume over S (262,144); 48 over H (524,288)
    18 distinct (agent, volume) ever over S while active; 1 ever over H
      (agents/journals/claude_dv_lead_agent.md, max 1,123,442 B, frozen)
    active volumes at HEAD:
      orchestrator        …v02.md  238,883
      auditor             …v02.md  258,341   <- 3,803 B below S
      tb_writer (worker)  …v03.md  246,595   <- 15,549 B below S
      architect_docs_lead …v05.md  115,301 · rtl_lead …v03.md 74,199
      dv_lead             …v11.md   58,358 · data_wrangler …md 145,608
    -> all within S today; two chains are one entry from crossing it (section 2.3)

**(E4) The reference clock, and the two `FINDING ADR21-1` greps** — §7.4
commands 3 and 4:

    $ git log --format='%at %ct' | awk '$1!=$2{d++} END{print NR, d+0}'
    603 0
    $ grep -c -E 'R10|R11|volume|rotate' agents/PROTOCOL.md                    # 0
    $ grep -c -E 'JOURNAL_SOFT_MAX|JOURNAL_HARD_MAX' scripts/check_journals.sh # 0

**(E5) The mechanisms I checked in the scripts, by line, since my findings cite
them:**

    agent_commit.sh:155   TMPDIR_P/appended      — the region section 2.2 reads
    agent_commit.sh:162-4 R5 exactly-one-header  — what makes "the ONE entry" single-valued
    agent_commit.sh:177-82 R10 size: staged_bytes from TMPDIR_P/staged; H refuses,
                           S emits WARN-JOURNAL to stderr  (the ADR's ":177" is exact)
    agent_commit.sh:187-96 R4: both sides LC_ALL=C sort -u, diff -u, prints
                           "--- claimed vs staged ---"  — path-granular, no provenance
    agent_commit.sh:214-7  R7: iterates WORK_PATHS only; orchestrator scope is total
    check_journals.sh:24   git rev-list --reverse  — oldest-first, so compliant-run
                           is a one-integer-per-chain forward accumulation
    check_journals.sh:58   git show -s --format=%B — where %at can ride for free
    check_journals.sh:162  TMP/appended · :168-70 R5 · :203-10 R11 blob gate reading
                           "$C:$path" AT THE COMMIT — the permanence in section 2.1
    check_journals.sh:256  the final OK line the summary must precede
    journal-check.yml:33-47 the range step's fallback to --all  (section 1.3)
    test_protocol.sh:20    expect_ok discards BOTH streams  (section 1.6)
    test_protocol.sh:78-100 entry() hard-codes 2026-08-01T00:00:00Z  (section 1.6)
    policy.sh:13-14        JOURNAL_SOFT_MAX/HARD_MAX, env-overridable  (section 4)

**(E6) The live case, quoted from the artifact rather than characterised:**
`J-tb_writer-0045`'s header stamp is `2026-08-11T15:30Z (estimated, see
Open-questions)`; its commit `65ba148` has author time 6 h 22 m later; its
Open-questions attributes the estimate to `date -u` being absent from
`WO-0082` §17.1's allow-list. Quoted in section 1.9.

**Not claimed.** No CI run is cited — this round triggered none, and the
`WARN-STAMP`/`WARN-JOURNAL` outputs discussed above **do not exist yet**: every
figure I attribute to them is the output of my own re-derivation of their
specified predicates, not of an implementation. `S40`–`S49` have not been written
and cannot have been run. My census reproduces the ADR's numbers; it is not the
check.

### Outcome

**DoD met for the dispatched round.** Three subjects countersigned, none refused
outright, two grounds refused as written with replacement text supplied, and one
completeness claim held open pending a trace the raising seat is better placed to
finish than I am.

- **Subject 1 — COUNTERSIGNED.** Conditions before acceptance, all one-clause or
  one-line: the `latest` column's semantics stated (§1.2); the range step's
  fallback declared (§1.3); the output stream pinned to stderr (§1.4);
  `entry()`'s stamp derived at run time and the boundary scenario moved to the
  history surface (§1.6); `S50` added for the rotation case (§1.6); `ADR-0016`
  §6.4's shell-form note carried forward (§1.7); §2.2's "one of 600" restated as
  a class with a cause (§1.9 item 4). None of these touches the decision, the
  band, the posture or the parameters.
- **Subject 2 — COUNTERSIGNED**, with the ADR's §3.4 bolded ground **refused as stated**
  and replaced by proportionality (this entry §2.1) — a correction that must reach §8's
  PROTOCOL draft text, which currently recites the refuted form.
- **Subject 4 — dispositions and limbs COUNTERSIGNED**; ground 2 must cite `R4`
  rather than `R7` (§3.2); §5.2's *"neither of the two cases"* **not
  countersigned** until Case A′ is traced or the predicate's reading pinned
  (§3.4); limb 2's *"no script"* → *"no reliable script"*, with ordering named as
  the residual signal (§3.3).
- **`FINDING ADR21-1` — corroborated and sharpened** (§4): it is the completed
  form of my own `ADR-0016` §6.4 rider, its live consequence is that a threshold
  edit is currently a rule change with nothing to bind it, and the repair must
  carry §2.1's ground rather than §8's drafted one.

**Handoff**: to the orchestrator, verbatim, for routing to architect_docs_lead
(the six one-clause conditions and the two ground corrections), and for its own
§11(2) decision on `FINDING ADR21-1`. **Nothing is in force by this entry; my
signature is on the design, and per §9 subject 1 additionally awaits the
auditor's and, in force terms, `S40`–`S46` green — which §1.6 says cannot yet be
written as specified.**

### Open-questions

1. **Mine to pay, and the round's most actionable finding: `date -u` is missing
   from my worker allow-lists.** `J-tb_writer-0045` estimated its stamp because
   `WO-0082` §17.1 does not carve out `date -u`, and `J-tb_writer-0044` did the
   same for the same reason — two consecutive entries, one in band by luck and
   one 382 minutes out. From my next `WO` revision the carve-out is explicit,
   with the instruction to read at authoring and record the reading in Evidence.
   `agents/handoffs/**` is in my scope but outside this round's write allowance,
   so it is owed, not done.
2. **The `F5` review trigger has fired pre-implementation and its first case does
   not discriminate.** The slow bound's first live firing is an *estimated*
   stamp, not a genuinely long round, so it is a true positive and **the bound
   does not move on it**. The asymmetry question (369 fast, 3 slow) stays where
   the ADR left it — the auditor's to advise, since the 0-of-16 measurement is
   its own.
3. **Case A′ is open and it is not mine to close.** Whether the offered warning
   is refused or adopted, §5.2 needs the third case traced; I have stated both
   grounds I can see and rejected the easy one against my own interest.
4. **Whether a self-declared estimated stamp should be counted differently** —
   I say no, and the design as written already gets it right: the qualifier must
   not suppress the band computation (an estimate 382 minutes out is exactly what
   a counter should show) and must not be treated as malformed. Recorded because
   the class is now recurring and someone will propose the exemption.
5. **Carried, unchanged**: `J-dv_lead-0184` item 5 still stands (no test, plan row
   or spec claim of mine may cite that round's mutation-hunk reads);
   `SO-xgmii_rx_64.md` §2.2-D's green half remains owed against a gate SHA that
   does not exist; the `9a596e7` repair's CI adjudication is still open.

### Files-in-this-commit
- (none)

## [J-dv_lead-0190] 2026-08-11T22:27Z | task:none | Three subjects confirmed and four corrections filed — the survivor exhibit describes a failure this record does not contain and omits the decay that is filed against it, the frozen-kill limb discloses one of its three known limits, the sign-off form exports a verdict with no external anchor in it, and the relay section's benign exhibit has been overtaken twice on my own receiving side

### Trigger

Orchestrator dispatch, **one round, journal-only**: the confirmation `docs/PROCESS.md`
Annex B.1 assigns my seat, before council round 2 convenes. Three subjects, each
either confirmed or corrected — **both a legitimate return**, per the dispatch and per
§4.8 of the text under review:

1. **§3.9's scoring block and its three anonymized exhibits**, rebuilt from rulings
   that are substantially my seat's — faithful to what was ruled, or corrected; and
   whether the **import-as-rules** marking carrying `C-104`'s single citation is right
   against my own calibration-preservation argument from the `ADR-0020` round.
2. **§3.8's sign-off form** — whether it states my `SO-` practice truly: honest `FAIL`s
   preserved, the verdict one token, and the property floor my `SC-5`/`SC-8` exceed.
3. **§4.3's relay classes** — the verbatim-relay discipline with the relayer's
   additions marked, against the practice my seat both exercises and polices.

**Abort-first precheck, before any file was opened** (§4.1 of the document under
review, and charter practice):

    git status --short              # zero lines
    git rev-parse HEAD              # 2f32e45d86f6c04f1ad50eaff1a08f71605a5125
    git rev-parse --abbrev-ref HEAD # claude/fpga-hardcaml-agent-orchestration-37ceyf
    date -u                         # Tue Aug 11 22:16:04 UTC 2026

Byte-equal to the dispatched expectation `2f32e45`, tree clean. **Neither branch of the
abort procedure was reached**, and no undeclared dirty path existed to adjudicate.
**HEAD did not move across the round** (re-checked at authoring: still `2f32e45`).

**Declared siblings**: the **auditor** on the parallel confirmation (its `v03` journal
only); and the transient remote ref `mut/wo-0041-dm3-falsifier` — the `F-0024-A`
falsifier, the CRITICAL against my `RV-0041` ruling, **whose CI verdict pends and which
is NOT this round's subject**. Nothing of it is adjudicated below; where the scoring
block touches the clause it tests, I state the bound and stop (Reasoning §1.6).

**Honest stamp**: `date -u` at authoring — `Tue Aug 11 22:27:46 UTC 2026`.

**No rotation.** `v11` stands at **114,699 bytes** before this append against
`JOURNAL_SOFT_MAX` = 262,144; volume 10's sha256 re-measured equal to this volume's
`Previous-volume-sha256` header field (Evidence), so the chain is intact.

### Inputs

- `agents/charters/dv_lead.md` and `agents/PROTOCOL.md` **in full** — §3's relay table,
  §7's **Mutation record** (b.1)–(b.4), §10's floor and anchor bullets are the four
  texts the three subjects codify, and all were read at the live file rather than
  through the reviewed document's account of them.
- `docs/PROCESS.md` at `2f32e45`: **§3.8** (1562–1598), **§3.9** (1600–1825) clause by
  clause, **§4.3** (1936–1970), **§4.1**–**§4.2** (for the document's own use of
  *round*), **§1.4** (a)–(d), **Annex A**, **Annex B.1**–**B.6**.
- `agents/handoffs/SO-xgmii_rx_64.md` — header and State block (1–86), §0.1's four
  prohibitions, §1's fourteen criteria in full (`SC-5` :191, `SC-8` :218, `SC-14` :261),
  §2.2 and §2.2-M (714–859), §2.2-D's head, §8's section map.
- `docs/adr/ADR-0020-the-gate-asks-the-suite-not-the-scoreboard.md` — §1.1 (the survivor
  and void paragraphs), §1.2 (both grounds), the (b.2) adaptation block at 680–709,
  §12.1–§12.7.
- **My own chain, read at the committed text rather than recalled**: `J-dv_lead-0184`
  (the ten-campaign walk, `FINDING REC-1`/`REC-2`/`REC-3`, step 5's class-not-branch
  ruling), `J-dv_lead-0185` (the four countersignatures, `FINDING REC-4`, §5's offered
  frozen-kill limb, §9's five-property/floor argument, `FINDING REC-5`),
  `J-dv_lead-0186` (`F-0022-2` sustained, `C3` withdrawn, `FINDING REC-7`),
  `J-dv_lead-0187` (`REC-1`/`REC-2` cures, `REC-7`'s disposition table).
- `docs/reports/audit/ADR-0020-auditor-countersignatures.md` (§3's five stated readings;
  the `F-0022-*` row block) and `agents/journals/claude_auditor_agent.v02.md`
  2440–2495 (`J-auditor-0021`'s two countersignature acts and its five findings,
  `F-0021-5` among them), 2842 and 3296 (`F-0022-2` as filed).
- `agents/journals/claude_architect_docs_lead_agent.v05.md` 728–760 and 945–955 — the
  round that **stopped** `F-0022-2`'s cure, read for the grounds it actually gives.
- `docs/reports/audit/PROCESS-claims-posture.md` rows `C-94`…`C-110` — read as the
  auditor's own measured postures, to check my confirmations against them rather than
  to replace them.
- `agents/journals/claude_auditor_agent.v03.md` 639 and 673 — `F-0024-A`'s severity and
  its self-declared falsifier, read only far enough to state the bound and stop.
- **No RTL source read.** No mutation branch fetched, no `mut/` ref created; the only
  mutation reads are committed campaign packets and manifests, read as adjudication
  record on an already-signed module. No `Essenceia/Nasdaq-HFT-FPGA` material consulted.

### Reasoning

#### 1. Subject 1 — §3.9's scoring block: CONFIRMED, with two corrections and two precisions

**1.1 The fifteen bullets, walked against the clauses they compress.** I read each
bullet against `PROTOCOL` §7 (b.1)–(b.4) and §10's floor at the live file, and against
the ruling each compresses in my own chain. **Every bullet is faithful**, and three are
faithful in the strong sense that they carry the operative sentence of the ruling
rather than a summary of it: the two-column subtraction with the difference itemised
(`REC-3`'s repair), the class-not-branch unit with its ground intact (`J-dv_lead-0184`
step 5 — a ref population is monotone by infrastructure accident and *a denominator
that can only grow, for reasons outside the program's control, cannot be a
denominator*), and ground 1's folding argument in the words it was first written in
(`J-dv_lead-0137`). Ground 3's added sentence — *a campaign with no negative control
cannot distinguish a suite with teeth from an apparatus that reports failure whatever
it is fed* — is not in any ruling of mine; it is sound, it is the reason a control is
cut, and I confirm it as a correct addition rather than a misquotation.

**One construction I signed under, which the bullet preserves and a reader could still
lose.** *The unit of the record is the defect class, not the branch or file that
delivered it* contrasts a class with a **delivery vehicle**; it does not re-unit the
four pre-class campaigns (`WO-0039`, `0041`, `0042`, `0045`), whose records are scored
per mutation and which my `SO-` reports separately with their domain stated
(`J-dv_lead-0185` §8). The bullet's own contrast preserves that. I note it because a
re-uniting would violate this same block's frozen-measurement rule.

**1.2 CORRECTION 1 — exhibit 2, *The survivor argued dead*, states as an event
something this record does not contain, and omits the hazard the record actually
filed.**

The exhibit opens: *"A defect that its own campaign recorded as surviving was later
said to be handled, on the strength of a suite that had grown since."* **No weaker
evidence form was ever used for this record's one survivor.** `G-c4`'s disposition was
the strict form from the first statement of it: branch `mut/wo-0056-gc4-replay` =
`c95c9f4` = `e7657e3` + the **unmodified** `g-c4.diff`, CI run `30852220315`, `runtest`
RED, **`M03-G8` the only failing unit of twenty-seven**, on the exact assertion the row
was written to make. My packet's own sentence is *"the repair was PROVED BY THE
MUTATION, not by the landing"*, and it publishes the two facts side by side under a
prohibition on quoting either alone. **The rule was written from a practice, not
against a failure**, and the exhibit as worded credits the record with a lapse it did
not have — which is the class of claim this whole revision exists to remove.

**And the record's real hazard is the mirror image of the exhibit's, it is filed, and
it is absent from the block.** `F-0021-5` (auditor, MINOR, filed against **the gate**):
(b.2)'s *as it stands at the gate SHA* is **not** discharged for `G-c4` by run
`30852220315`, because the bench moved **8,505 insertions / 151 deletions across 15
files** and the RTL 248 insertions since the replay base `e7657e3`; the diff still
applies, so the cost is one CI run; and *"this becomes MAJOR the moment a gate record
cites the historical run as (b.2)'s discharge without a re-run."* The auditor accepted
that cost in terms when it countersigned: *a survivor's rehabilitation expires when the
bench moves*. **A survivor is not argued dead in this record by a weak form; it would
be argued dead by a strong form quoted after its expiry**, and that is the failure an
adopter will actually meet, because the strong form looks identical on the day it stops
being true.

**Proposed repair, and it costs one clause**: open the exhibit on the hazard rather
than on an event (*"the form is narrow, and the record's own auditor found it is also
perishable"*), keep every element of the evidence form as written, and add: **a
rehabilitation is good only at the SHA it was taken at; citing an aged run id is the
same defect wearing the approved form.**

**1.3 CORRECTION 2 — the frozen-kill bullet discloses one of its three known limits and
claims the disclosure as a virtue.**

The bullet reads: *"That form catches a killing check deleted or disabled since; it does
not catch one weakened, and the clause says so rather than leaving the limit to a
footnote."* The weakened-unit limit is disclosed, correctly, and it is disclosed in the
constitution. **Two further limits of the same form are filed findings, both landed
after that sentence was drafted, and neither is a footnote:**

- **`F-0022-1`** (auditor): **five of the thirty-seven committed mutation renderings no
  longer apply at HEAD**, all in campaigns scored as kills. I verified the mechanism at
  two instances rather than taking it whole — against `git show HEAD:` copies outside
  the repository, `f-c3.diff` and `f-c6.diff` **fail to apply**, `f-c1.diff` applies
  clean. The survivor form replays an unmodified diff and therefore **self-checks
  against design drift**; the kill form asks only that a unit be present and green and
  **cannot notice that the class's rendering no longer exists against the design it is
  scored on**.
- **`FINDING REC-7`** (MAJOR, mine, filed by the offerer of the limb): the unit names
  the campaign records carry are in the retired `T-` namespace. Measured at HEAD,
  `T-F2`, `T-I4`, `T-G7`, `T-E5` and `T-C4` return **zero** occurrences under `test/`,
  while `M03-F2`, `M03-I4`, `M03-G7`, `M03-E5` and `M03-C4` are present in force — so a
  **literal** application of *"the named killing unit, present and green at the gate
  SHA"* fails at every class of the `T-`-era campaigns, not because an instrument was
  deleted but because record and bench speak different namespaces. Paid at
  `J-dv_lead-0187` as a measured mapping table (thirty classes, twenty-eight frozen
  kills, twenty-eight mappings, zero disposition failures).

**Proposed repair**: *"it does not catch one weakened"* → *"it does not catch one
weakened, nor a class whose rendering no longer applies to the artifact, nor a record
whose unit names no longer exist in the suite — the first is disclosed in the clause and
the other two were found afterwards."* The sentence as it stands invites an adopter to
believe the form's limits are known and stated; two of the three were found by the
clause being applied, which is the more useful lesson.

**1.4 PRECISION A — exhibit 1's *"in the same round"*.** The two items are `REC-3`
(`I-c1` excluded from `sealed` though the record declared it sealed; `IC-M5` included
though never rendered; the two grounds never stated together anywhere) at
`J-dv_lead-0184`, **17:17Z**. The third item is `REC-4` (`IC-2`, the negative control,
which (b.1) as drafted would have made `seeded` and therefore *killed* by its own
eighteen predicted reds) at `J-dv_lead-0185`, **17:47Z** — **a separate dispatch of
mine**, inside the drafting seat's single codification round. Under this document's own
use of *round* (§4.1 and §4.2 both mean one agent's working session), *"in the same
round"* reads false. **And the exact version is sharper than the approximate one**: the
first two items were found by walking the record, the third was found by reading the
**drafted clause** against the record — the codification surfacing a third instance of
the defect it was being written to cure.

**1.5 PRECISION B — exhibit 1's italicised qualifier.** The record's word is
**`scoreable`**, in two campaign verdict lines: `WO-0061`'s *"Scoreable classes: 9"* and
`WO-0063B`'s *"One scoreable class, one kill: 1/1"*. The exhibit italicises *of the
scoreable classes*, which appears in no packet as a phrase. The claim the qualifier
carries — that the word appears in **no normative document** — is true and is `REC-4`'s
own finding. Recommend quoting the single word.

**Exhibit 3 — *The killing unit that had no unique referent* — CONFIRMED whole, with
one omission worth repairing.** Every element checks at the source: `F-c1` names **four**
units (`T-C4`, `T-F1`, `T-F3`, `T-F4`), `F-c2` **nine**, `F-c8` **one of three
required** (`T-E5` only) — three of eight classes with no unique referent, measured by
me first-hand at `WO-0050`'s verdict table rather than from the relay; the two readings
differ exactly as stated (*all must still stand*, wider than the hazard; *any one
suffices*, a gate-time selection by the party discharging); the filing seat had
countersigned that clause (auditor, `J-auditor-0021`, act 2 on (b.2) and (b.3)) and
filed against it at its delta; and it routed the width to the seat it falls on, where I
sustained it, **withdrew my own construction `C3`**, and adopted the filer's reading.
**The omission**: PROCESS gives one ground for the stop — authority and constitution
would disagree — and the round gives two. The second is that `PROTOCOL` **is not the
drafting seat's to stage**: refused mechanically by `policy.sh` and forbidden by the
dispatch. §4.8's point is stronger with it, because the stop was then **not
discretionary**; a refusal that a machine also enforces is a different exhibit from a
refusal someone chose.

*Available sharpening, not a correction*: the singular sits in a limb that **I offered
one round earlier, against my own interest** (`J-dv_lead-0185` §5). The exhibit is a
clean instance of a rule authored by the graded party, signed by the independent one,
and broken by the record of the graded party's own campaigns.

**1.6 The one live bound on this block, stated and not adjudicated.** The equivalence
bullet's **sole instance in this record** — `D-M3`, `WO-0041`, the one exclusion
`ADR-0020` §6.2 tests the new clause against — is under a **CRITICAL** falsifier,
`F-0024-A`, filed against my `RV-0041` ruling at `J-auditor-0024` (`d4be71b`), which
names its own single falsifying run and is **withdrawn in full if that run is green**.
The run pends on `mut/wo-0041-dm3-falsifier`. **Nothing in the bullet is wrong** — the
proof standard is stated correctly and I countersigned it — but a reader should know
that the block's most-likely-to-be-misused rule has one measured instance and that
instance is contested. My response round comes separately, with the run id in hand;
**this round adjudicates none of it.**

#### 2. Subject 1 continued — the import-as-rules marking and `C-104`: RIGHT, and the boundary it needs stated

**The `[RE · C-104]` posture is right and one citation is the correct economy.** No
script reads a tally, a column, an equivalence proof or the floor; `PROTOCOL` §7's own
clause declares the posture in its own text and states why §11(3) owes no test case; I
countersigned (b.1), (b.2), (b.4) and §4 knowing that the only thing between these
rules and a wrong number is a reader. **Confirmed as stamped.** *(One precision for the
transcription row, which is the auditor's: the posture list measures `C-104` over
**thirteen** scoring bullets; the block now carries **fifteen**, the three grounds
having been promoted to bullets of their own. The posture does not change — no script
reads any of the fifteen — but the citation's referent grew after the measurement.)*

**Now the question the dispatch actually asks: is *"Import these as rules; do not
re-derive them"* right against my calibration-preservation argument?** **It is right,
and it is right about the rules only.** My argument at `J-dv_lead-0185` §9 was that
what a constitution can guarantee is a set of **properties** — every non-kill named
individually, no non-kill folded into a kill, no ratio standing in for the
dispositions, the survivor's two facts side by side, the unreachable set beside the
tally — **and not a reporting schema**; that `ADR-0020` §12.2 refuses to freeze my five
columns precisely because *"dv's fifth column exists because a fourth was found
insufficient one campaign earlier"*; and that complying with the clause I was
countersigning **required my own schema to change on the day it landed** (`sealed` moves
63 → 65 as two invisible exclusions become a visible subtraction). **The calibration
lives in the schema's history, not in the rules.** So the instruction must not be read
across into two things it does not govern, and neither exclusion is currently stated:

- **Not the schema.** An adopter who imports the fifteen bullets and freezes a column
  set has imported the rule and lost the calibration; the block should say that it
  guarantees properties, and that a schema a campaign shows insufficient is **expected
  to move** — twice in nine days, in this record, once by my hand and once by the
  clause.
- **Not the figures the rules govern.** My own standing rule is the opposite
  instruction: **a figure carried across rounds is re-derived by the method its carrier
  claims, or the carrier states that it was quoted** — `FINDING REC-1`, filed by me
  against my own packet's method sentence, whose seven-campaign total had never been
  derived campaign by campaign anywhere in the record until `J-dv_lead-0184`, and whose
  cure landed as a dated annotation beside the sentence it convicts. *Do not re-derive*
  is right for rulings and inverts `REC-1`'s cure the moment it is carried across to a
  number.

**Recommended repair: one sentence in the import paragraph** — *these are the
properties the record must be able to answer for, not a reporting form; the form is the
reporter's and is expected to move when a campaign shows it insufficient. Import the
rules; re-derive the numbers.*

#### 3. Subject 2 — §3.8's sign-off form: CONFIRMED on all three checks, with one correction

**(a) Honest `FAIL`s preserved — TRUE, and measured rather than recalled.** The live
`PASS` quotes **two** earlier failing verdicts inside itself, unedited and beneath the
live token: round 2's `FAIL` on `SC-2` and `SC-12` (§8.1, at `2183d71`) and round 3's
`FAIL` on `SC-12` (§8.0, at `14615f8`, on `FINDING SO-6`). The State block's own
sentence is *"Every superseded statement is preserved where it was written and none is
rewritten into its own outcome."* The extension §3.8 draws — that the same holds for a
wrong prediction and a superseded measurement — is also true here: the `survived`
column stays at **1** permanently, and a falsified sealed prediction of mine is left
standing in its freeze (`J-dv_lead-0044`).

**(b) The verdict is one token — TRUE, and stronger in the packet than in the
description.** `SC-14` is in terms: *"`PASS` or `FAIL`. No third value, no 'PASS with
reservations', no 'PASS subject to'... A verdict that needs a qualifier in the same
sentence is a `FAIL` whose author has not admitted it."* The twelve bounds the module
has not earned live **inside** the `PASS` at §8.R4.4, which is what makes the single
token survivable.

**(c) The floor my `SC-5`/`SC-8` exceed — CONFIRMED, and this is the relationship I put
on record.** §3.8's element list is a **floor**, not a description of the packet.
`SC-5` forbids a ratio **at all** where the block's bullet only forbids one *standing
in for* the dispositions; `SC-8` publishes the unreachable-instrument register
(`U-1`…`U-5` plus `DECLARATION WO-0074-D1`), which has **no counterpart in §3.8's list
at all**. That is deliberate on my side: *the unfrozen clause is a floor under my
practice and never a ceiling on it*, and the compensating control is that `SC-5` and
`SC-8` are **committed criteria in my own write scope**, so a later seat lowering them
must edit a signed packet where the edit shows in a diff. **§3.8 states a floor
truly.** I would add four words saying it is one, because `C-94`'s *"it carries every
element named above"* is true and reads, at speed, as *these are the elements*.

**CORRECTION 3 — the described form omits the external anchor, and the document omits
it everywhere.** Measured, not assumed: `docs/PROCESS.md` contains **no** treatment of
an oracle-anchoring rule — no reference implementation used as an oracle, no
differential co-simulation, no golden-model agreement requirement; the word *anchor*
occurs in the document only in its own claim-stamping sense, and §1.4's four
separations do not draw this one. In this program that element is:

- **constitutional** — `PROTOCOL` §10's second bullet: *golden models must agree with an
  external anchor before they may judge RTL*, one of the two properties §1 of the
  constitution calls non-negotiable;
- **a charter precondition** — no Phase 1 sign-off without differential co-simulation;
- **a criterion of the one sign-off** — `SC-6`, which reports the anchor **per stimulus
  class** at run and job ids, states in terms that the module-level anchor is
  **undischarged**, and forbids the sentence *"the co-simulation anchors this module"*
  anywhere in the packet.

**As it stands, §3.8 exports a sign-off form under which an unanchored oracle may grade
an artifact**, and the adopting seat has nothing in the document telling it that its
own golden model must first agree with something it did not write. That is the largest
single gap I found in the three subjects, and it is one element and one sentence to
close. *(Route: architect_docs_lead; I do not stage `docs/PROCESS.md`.)*

#### 4. Subject 3 — §4.3's relay classes: CONFIRMED, with one correction on the exhibit

**The classification is right.** `PROTOCOL` §3's table makes `SO-` and `BUG-` packets
and all auditor findings verbatim class; my own packet's header carries it
(*"this document is a sign-off packet and is in the **verbatim** relay class"*), with
the honest nuance that a **DRAFT is not yet in that class**. The two rules — additions
marked as the relayer's, and the receiving seat checking a relay against the source when
fidelity matters to an argument — are the practice my seat exercises and polices, and
the practice is measurable in my chain: `J-dv_lead-0185` (I recorded the architect's
source-check of a relay of my own finding — *the behaviour I would want and did not ask
for*) and `J-dv_lead-0186` (an auditor delta arriving as relay: I verified its claims at
my own artefacts **before using any of it**, then read the committed act when it landed
mid-round).

**CORRECTION 4 — the section's closing sentence is no longer true of the record, and its
only exhibit is the weakest one available.** `C-110` says the mechanism *"failed in the
benign case and was therefore visible before it failed in a case that mattered."* The
benign case is real and is mine (*"dispositioned **as** UNSCOREABLE"* → *"dispositioned
UNSCOREABLE"*; nothing turned on it). **But the same relay had already failed in a way
that did matter, and a later one failed again**, both on my receiving side, both caught
only because a receiving seat read the committed source:

- **An unmarked relayer addition.** The relay of `F-0022-1` reported *"the named killing
  unit `M03-F2` **IS** present"* for the two classes whose campaign record names
  **`T-F2`**. The namespace mapping was **performed silently, by the seat least likely
  to get it wrong, and is invisible in the artefact** — an addition absorbed rather than
  attacked, which is exactly the second-order failure §4.3's marking rule exists to
  prevent. And the gap it silently closed is the subject of `REC-7` (MAJOR): under a
  literal reading of the constitutional clause, that namespace difference fails the
  disposition of **every class of four campaigns**.
- **A faithful relay that omitted three findings.** The same round's relay of the
  auditor's delta said what the committed act said — and **the committed act carried
  three findings the relay did not** (`J-dv_lead-0186`). Compression removed what nobody
  had asked for, which is the failure class the section names, in its non-benign form.

**And §4.3's second and third paragraphs — additions marked, receiving seat checks the
source — currently carry no exhibit at all.** The first instance above is an exhibit for
the first rule; the second is an exhibit for the second; both are anchorable at journal
entries and campaign packets. **Recommended repair**: keep the benign exhibit as the
opening (it is a good one, and its point about visibility stands), and drop the claim
that the mechanism has not yet failed in a case that mattered.

**One precision on `C-109`'s `PLANNED` stamp.** *"No spot-check followed"* is right as
to the duty it names — the **auditor's** charter §3 relay-fidelity sampling of protected
classes, which I find no performance of — and it should not be read as *no fidelity
check has ever happened here*. Two have, both by **receiving seats**. That is a
different control with a different failure mode: it fires only where a receiver happens
to look, and it cannot sample the relays nobody contested. The owed instrument stays
owed; the record is not empty.

*(Annex B.1's second dv row states its "On what" cell for §3.8 only — *that the described
form matches the one sign-off in the record* — and says nothing for §4.3. I have
confirmed §4.3 against the dispatch's statement of it; if the annex intends a narrower
question there, it should say so, because an unstated criterion is how a
countersignature comes to mean whatever a later reader needs it to mean.)*

#### 5. What I did not do

I did not touch `docs/PROCESS.md`, the `SO-`, the attack plan, the gate file or any
packet. All four corrections are edits to a file outside my write scope and are routed,
not performed. **`WO-0082` §17.1's date-`u` carve-out remains owed at my next packet
revision** — my own ruling at `J-dv_lead-0189`, and not this round's business.

#### 6. Harvest

**Not due, declared rather than skipped** (charter §8, `PROTOCOL` §7): this round is
neither an `SO-` nor a phase gate. The span opened at my last harvest stays open and
this entry joins it, continuous with `J-dv_lead-0187`/`-0188`/`-0189`. **Two candidates
banked**, both LH1–LH3 discharged, both **LH2-g** (no proper noun of any kind):

- **(f)** *An exhibit written to teach a rule must describe the incident that produced
  the rule, not the failure the rule prevents; where the record shows the discipline
  was volunteered rather than imposed after a lapse, saying otherwise credits the record
  with a fault it does not have and teaches the reader to expect the wrong warning
  sign.* **LH1** this round's survivor exhibit against the disposition it describes.
  **LH3** without it, a corrected document acquires new false claims in the act of
  illustrating true rules, and they are the hardest kind to find because they are
  attached to something correct.
- **(g)** *When an evidence form is adopted because it cannot be argued with, record its
  expiry conditions in the same clause; a form that is checkable today and silently
  perishable is more dangerous than a weak form, because it keeps its authority after
  it stops carrying information.* **LH1** this round's `F-0021-5` bound on the survivor
  replay, and the two undisclosed limits of the frozen-kill limb. **LH3** without it, a
  gate record cites a strong-form artefact past its validity and every reader downstream
  reads the form rather than the date.

### Actions

- Ran the abort-first precheck; read charter and `PROTOCOL` in full; read
  `docs/PROCESS.md` §3.8, §3.9, §4.3, §4.1–§4.2, §1.4 and Annex B whole.
- Walked all **fifteen** scoring bullets against `PROTOCOL` §7 (b.1)–(b.4) and §10 at
  the live file, and against the rulings they compress in my own chain.
- Checked each of the three exhibits at its primary source rather than at the reviewed
  document's account of it: exhibit 1 at `J-dv_lead-0184`/`-0185` and the two campaign
  verdict lines; exhibit 2 at `SO-xgmii_rx_64` §2.2-M and at `J-auditor-0021`'s
  `F-0021-5`; exhibit 3 at `WO-0050`'s verdict table, the auditor's countersignature
  file, and the architect's stopping round.
- Measured the anchor gap: greps over `docs/PROCESS.md` for every form of the
  oracle-anchoring rule, returning nothing.
- Measured the `mut/` ref population on the remote (**86**) as a datum for the §3.9
  margin note, which is the auditor's row and not mine.
- Verified the journal chain and volume headroom; wrote this entry.
- **No file outside this journal is staged; no `git commit` or `git push` was run; no
  stop-hook commit demand was honoured.**

### Evidence

All commands from the checkout at `2f32e45`, branch
`claude/fpga-hardcaml-agent-orchestration-37ceyf`.

**Precheck and stamps:**

    $ git status --short                 # zero lines, at entry and at authoring
    $ git rev-parse HEAD
    2f32e45d86f6c04f1ad50eaff1a08f71605a5125
    $ date -u                            # entry 22:16:04Z; authoring 22:27:46Z

**Journal chain and headroom (`R3`, ADR-0017):**

    $ sha256sum agents/journals/claude_dv_lead_agent.v10.md
    ee441697dab3696924090feb08742249952c432791c014b27b8c91975770ae75
      == v11 header field Previous-volume-sha256
    $ wc -c agents/journals/claude_dv_lead_agent.v11.md
    114699                                # < JOURNAL_SOFT_MAX 262144

**The scoring block's size, for the `C-104` referent note:**

    $ awk 'NR>=1709 && NR<=1776 && /^- \*\*/ {c++} END {print c}' docs/PROCESS.md
    15                                    # posture row C-104 measures "thirteen"

**The anchor gap (Correction 3), measured over the whole document:**

    $ grep -c "oracle\|reference implementation\|differential\|cosim\|co-sim" docs/PROCESS.md
      -> the only hits are §"Included: the reference implementation" (the document
         describing itself), §6.2 step 0, and §5.7's bullet; none is the anchoring rule
    $ grep -c "independent implementation\|second implementation\|cross-check against" docs/PROCESS.md
    0
    $ grep -n "anchor" docs/PROCESS.md    # all hits are claim-stamp/parameter senses

**Exhibit sources, quoted at their files:**

    agents/handoffs/SO-xgmii_rx_64.md:14   round 2 FAIL (SC-2, SC-12), round 3 FAIL (SC-12)
    agents/handoffs/SO-xgmii_rx_64.md:261  SC-14 "THE VERDICT IS ONE TOKEN"
    agents/handoffs/SO-xgmii_rx_64.md:191  SC-5 five columns, never a ratio
    agents/handoffs/SO-xgmii_rx_64.md:218  SC-8 unreachable-instrument register
    agents/handoffs/SO-xgmii_rx_64.md:825  the G-c4 replay: c95c9f4, run 30852220315,
                                           "M03-G8 alone, out of twenty-seven units"
    agents/journals/claude_auditor_agent.v02.md:2484   F-0021-5 (8,505 / 151 / 15 files)
    agents/journals/claude_auditor_agent.v02.md:3296   F-0022-2 (F-c1 four, F-c2 nine,
                                                       F-c8 one of three required)
    agents/journals/claude_architect_docs_lead_agent.v05.md:739  the stop, both grounds
    agents/journals/claude_dv_lead_agent.v10.md:2892   the dropped word
    agents/journals/claude_dv_lead_agent.v10.md:3947   the unmarked namespace mapping
    agents/journals/claude_dv_lead_agent.v10.md:3894   "three findings the relay did not carry"

**Remote transient population (datum for the margin note, auditor's row):**

    $ git ls-remote --heads origin 'refs/heads/mut/*' | wc -l
    86

**Ephemeral**: nothing in this entry rests on an ephemeral artefact. `F-0024-A`'s
falsifying run is **pending** and is cited as pending, never as a result.

### Outcome

**DoD met for the dispatched act. All three subjects returned: CONFIRMED, with four
corrections and three precisions. No refusal, and nothing here blocks council round 2.**
The transcribable act:

> **CONFIRMATION — dv_lead on `docs/PROCESS.md` Annex B.1, its two dv rows, at
> `2f32e45`. Journal ref `J-dv_lead-0190`.**
>
> **§3.9's scoring block — CONFIRMED.** All fifteen bullets are faithful to the rulings
> they compress and to `PROTOCOL` §7 (b.1)–(b.4) and §10 as they now stand; three carry
> the operative sentence of the ruling rather than a summary. The **`[RE · C-104]`**
> marking is right — no script reads a tally, a column, an equivalence proof or the
> floor — and *"import these as rules; do not re-derive them"* is right **about the
> rules**, provided the block says what it guarantees: **properties, not a reporting
> schema** (a schema a campaign shows insufficient is expected to move; mine moved
> twice in nine days, once by the very clause being codified), and **not the figures**
> (a figure carried across rounds is re-derived by the method its carrier claims, or the
> carrier says it was quoted — `FINDING REC-1`, filed against my own packet).
>
> **Exhibit 1 — CONFIRMED in substance**, with two precisions: the third item is at the
> **next** dispatch, not the same one, and it was surfaced by the drafted clause rather
> than by the walk; and the record's word is **`scoreable`**, in two campaign verdict
> lines.
>
> **Exhibit 2 — CORRECTED.** No weaker evidence form was ever used for this record's one
> survivor: the strict form was the practice from the first statement of it, and the
> rule was written **from** it, not against a lapse. The record's filed hazard is the
> mirror image and is missing: **`F-0021-5`** — the bench has moved 8,505 insertions
> since the replay base, so a **rehabilitation expires when the bench moves**, and
> citing the historical run at a later gate SHA is a survivor argued dead **in the
> approved form**.
>
> **Exhibit 3 — CONFIRMED whole**, every element verified at `WO-0050`'s verdict table,
> the filer's countersignature and the stopping round; with one omission: the stop had a
> second ground — the constitution is not the drafting seat's to stage, refused
> mechanically — and a refusal a machine also enforces is a stronger exhibit than a
> chosen one.
>
> **The frozen-kill bullet — CORRECTED.** It discloses one of **three** known limits.
> The other two are `F-0022-1` (five of thirty-seven renderings no longer apply at HEAD;
> the kill form cannot notice that a class's rendering no longer exists) and `REC-7`
> (the record's unit names are in a retired namespace and return zero occurrences at
> HEAD, so a literal application fails at every class of four campaigns).
>
> **§3.8's sign-off form — CONFIRMED on all three checks.** Honest `FAIL`s are preserved
> and the live `PASS` quotes two of them unedited; the verdict is one token, with every
> unearned bound listed **inside** the `PASS`; and the described elements are a **floor**
> that `SC-5` (no ratio at all) and `SC-8` (the unreachable-instrument register, which
> has no counterpart in the list) exceed by design, the compensating control being that
> both are committed criteria in my own write scope. **One correction: the form omits the
> external anchor, and the document omits it everywhere** — measured. It is
> constitutional (`PROTOCOL` §10), a charter precondition, and `SC-6` of the one
> sign-off. As written, §3.8 exports a sign-off under which an **unanchored oracle may
> grade an artifact**.
>
> **§4.3's relay classes — CONFIRMED**, and the practice is mine to exercise and to
> police; two source-checks of relays are in my chain. **One correction: the closing
> claim that the mechanism has not yet failed in a case that mattered is no longer true
> of the record.** The same relay silently performed a namespace mapping and reported the
> mapped name as the record's name — an **unmarked relayer addition, invisible in the
> artefact**, over the gap that is `REC-7`'s subject — and a later relay was faithful in
> its quotation while **omitting three findings** the committed act carried. §4.3's
> marking rule and its source-check rule currently carry **no exhibit**; these are the
> two, and they are anchorable.
>
> **`C-109`'s `PLANNED` stamp stands**: the **auditor's** relay-fidelity sampling has not
> been performed. It should not be read as *no fidelity check has happened* — two have,
> by receiving seats, which is a different control that fires only where a receiver
> happens to look.
>
> **Nothing above is adjudicated against `F-0024-A`**, whose CI verdict pends; where the
> block touches the clause that finding tests, the bound is stated and stopped there.
> **CONFIRMED, with the four corrections above filed for the owning seat.**

**Handoff**: to the orchestrator for commit as a **journal-only** commit —
`Files-in-this-commit` is `- (none)`, so `Journal-Only: true`, trailers
`Agent: dv_lead`, `Work-Order: none`, `Journal-Entry: J-dv_lead-0190` (`R2`, `R6`).
The block above is the transcribable act; this entry is its tamper evidence. **The four
corrections are edits to `docs/PROCESS.md` and route to architect_docs_lead**; none is
performed here.

### Open-questions

1. **Correction 3 (the missing external anchor) is the one I would not ship the edition
   without.** The other three improve exhibits; this one closes a hole through which an
   adopter's oracle grades an artifact it was never checked against. **Route**:
   architect_docs_lead. If the omission is deliberate — the element being judged
   domain-specific — then say so in the text, because its absence currently reads as an
   oversight rather than a decision.
2. **`F-0024-A` (CRITICAL, against my `RV-0041` ruling) is unresolved and its run
   pends.** My response round is separate and comes with the run id. If it is sustained,
   §3.9's equivalence bullet keeps its rule and **loses its only measured instance**, and
   the block may owe a fourth exhibit — the equivalence proof that did not hold. Flagged,
   not adjudicated.
3. **`WO-0082` §17.1's date-`u` carve-out remains owed at my next packet revision**
   (`J-dv_lead-0189`), carried unchanged.
4. **`C-104`'s referent grew from thirteen bullets to fifteen after the posture was
   measured.** Substance unchanged; the transcription row is the auditor's, and I record
   it rather than reasoning from it.
5. **Annex B.1's second dv row states a criterion for §3.8 and none for §4.3.** I
   answered against the dispatch's statement of the §4.3 question; if a narrower one was
   intended, the annex should carry it.

### Files-in-this-commit
- (none)
