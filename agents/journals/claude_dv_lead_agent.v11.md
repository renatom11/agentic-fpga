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
