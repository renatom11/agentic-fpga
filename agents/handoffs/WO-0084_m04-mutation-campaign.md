# WO-0084: the M04 mutation campaign — the transmitter's kill claims, tested by defects that do not know the predictions

- **State**: ISSUED — authored and committed by the orchestrator, who is also
  this campaign's operator (ADR-0019: the seeder never operates; the seat that
  runs the diffs is the one seat that neither seals nor seeds nor scores).
- **From** / **To**: orchestrator → dv_lead (act 1, the seal; act 4, the
  scoring), auditor (act 2, the manifest and diffs), orchestrator (act 3, the
  runs).
- **Spec basis**: SPEC-M04; AP-xgmii_tx_64.md (39 discharged rows at
  d93fbf1's census: 6 families through stage 2); PROTOCOL §7's Mutation
  record (b.1)–(b.4) and §10; docs/PROCESS.md §3.3 (the campaign-seal law,
  determinate as of the seventh edition) and §3.9; ADR-0020 (the gate asks
  the suite); docs/process-golden-tally.json (the law block and the closure
  arithmetic every scored campaign must satisfy).
- **Definition of done**: a scored campaign record in the ADR-0020 §7 form —
  two-column sealed/seeded with every exclusion itemised to a ground, no
  ratio standing in for dispositions, the survivor evidence form and the
  frozen-kill named-unit limb available for every disposition — appended as
  the verdict to this packet, with the golden-tally arithmetic closing.
- **Context provided**: this packet; the artifacts named per act below.
- **Out of scope**: M03 (its campaign record is closed and its tally is the
  golden file's); any repair of a surviving defect (a survivor is a finding,
  routed, never fixed inside the campaign that found it); POSTURE-RE-
  MEASUREMENT-2 (a separate auditor round, never folded into seeding).

## Task

Test the M04 test suite's kill claims. The suite at 91f005d discharged 39
ASSERT rows of AP-xgmii_tx_64 across families A/B/F/G (stages 1–2 of the
two-frame work plus everything landed before). Every one of those rows
claims that a defect class in the transmitter would turn a named unit red.
None of those claims has ever been tested by an actual defect. This campaign
seeds real defects into `libs/hardcaml_ethernet/src/xgmii_tx_64.ml` on
never-merged references and scores the suite against its own sealed
predictions.

## The four acts, in the order §3.3 makes determinate

**Act 1 — dv_lead seals (FIRST, before any defect diff exists).**
dv_lead derives the campaign's defect-class list from its own attack plan's
discharged rows (the classes the suite CLAIMS to kill — dv's taxonomy, not
the seeder's), and freezes, per class: the predicted disposition (kill /
survive / unscoreable, with ground), the killing unit or units BY NAME
(M04-* — this era has no namespace gap), and the expected failure-message
TEXT (the discriminating content; a vacuous seal is visible in the seal).
The seal is a file — `agents/handoffs/WO-0084-SEALED-predictions.md` — in
the commit that claims it, its content duplicated in dv's journal entry per
the second-copy discipline, frozen against a named base state (91f005d or
later, green end to end). The state line is the seal's single mutable line.
The orchestrator commits it. **The campaign is barred from rendering any
diff until this commit exists**, and the immutability check is flat:
`git diff` against the freezing commit, expected empty (§3.3's seventh-
edition form — no mutable point but the state line).

**Act 2 — the auditor seeds (blind against the seal).**
The auditor authors the defect manifest — one class per sealed class,
rendered as unified diffs against `libs/hardcaml_ethernet/src/xgmii_tx_64.ml`
at the seal's base SHA — into `docs/reports/audit/WO-0084-mutations/`
(README + one .diff per class), per its charter §3 practice. **The blind
runs one way, against this seat**: the auditor must not open the seal file
or dv's sealing journal entry until every diff is committed. The campaign
allowlist for this act: SPEC-M04, the RTL file being mutated,
AP-xgmii_tx_64.md's row TEXT (the claims under test are public; the
PREDICTIONS are not), and its own prior campaign records (M03 era) for form.
NOT the seal, NOT dv's v12 sealing entry, NOT test/xgmii_tx_64/** (a seeder
that reads the bench can choose defects the bench cannot see; a seeder that
reads only the spec and the RTL seeds what the spec forbids). The
orchestrator commits the manifest.

**Act 3 — the orchestrator operates.**
One never-merge ref per class: `mut/wo-0084-<class>` = base SHA + the
unmodified diff, pushed, one CI run each, conclusions read at source. The
seeder never operates; the operator never edits a diff — a diff that fails
to apply is a finding (F-0022-1's drift class), not something to fix.

**Act 4 — dv_lead scores, under the four constraints.**
Verdict appended to THIS packet: per class, the run id, the observed
failing-unit set and failure text quoted verbatim from tool output, scored
against the seal — never against memory. The record keeps the two-column
form with every exclusion itemised; the unseal flips the seal's state line
only, on the operator's word that all N refs ran. Survivors are findings
with the survivor evidence form pre-committed (the unmodified diff + a
falsifier-shaped witness, per the F-0024-A precedent); kills carry the
frozen-kill limb (campaign record PLUS named unit present and green at the
gate SHA). The golden-tally arithmetic must close over this campaign's own
numbers; the M04 record is scored per class and never folded into M03's.

## Return / verdict log

(appended per act, with journal-entry refs)

| Act | Date | Return | Ref |
|---|---|---|---|
| **1 — the seal** | 2026-08-12 | **FROZEN.** `agents/handoffs/WO-0084-SEALED-predictions.md` is staged in this commit, **before any defect diff exists** (R-SEAL-1). **Thirteen classes** (`IC-1` … `IC-13`), spanning the seven families whose rows are discharged (A, B, C, D, E, F, G), derived from the **34 discharged ASSERT rows** — the plan's four absorption rows measure 39 discharged as **34 ASSERT + 5 NO-ASSERT**, and a NO-ASSERT row claims no kill, so no class is derived from one; the correction to this packet's own *"39 ASSERT"* is made in the seal §3.0 rather than absorbed. **Unit of scoring: the CLASS** (PROTOCOL §7 (b.1)), one kill per class however many units redden, with per-row qualification recorded in a second column and never folded into the first. **Predicted 12 kills of 13**, with `IC-10` predicted to **SURVIVE** on a named arithmetic ground. **Base state `6d92bf9`**, at which `libs/hardcaml_ethernet/src/xgmii_tx_64.ml` and `test/xgmii_tx_64/` are byte-identical to their state at `91f005d` (`git diff 91f005d 6d92bf9 -- libs/ test/xgmii_tx_64/` empty). **The base's DV suite is green** (run `31577965739` job `build`, steps *Build*, *Run tests*, *REQ-902 two-run determinism* and *Verify nothing was left unpromoted* all `success`; job `cosim` `success`; `journal-check` run `31577965794` `success`) **and the `build` JOB conclusion is nevertheless `failure`**, on step 10 alone, whose sole undeclared item is **this packet's own forward citation** of `docs/reports/audit/WO-0084-mutations/`. Every `mut/` ref will inherit that red: **acts 3 and 4 read step 6, never the job conclusion** — seal §0.1 and standing rule 9. Act 2 may begin: the seeding seat is told the fact of this seal and none of its content, except §0.1's step-6 rule, which is a property of the base state and not of any prediction. | dv_lead, `J-dv_lead-0195` |
| **2 — the seeding** | 2026-08-12 | **THIRTEEN DEFECTS SEEDED BLIND.** `docs/reports/audit/WO-0084-mutations/` — README + one `.diff` per class (`class-01` … `class-13`), each applying clean against `libs/hardcaml_ethernet/src/xgmii_tx_64.ml` at `9dba6d5`, each a type-correct substitution (intended). The auditor attested it did not open the seal or dv's `J-dv_lead-0195`, and did not read `test/xgmii_tx_64/**`; its partition is independent and need not match dv's (a mismatch is data act 4 reconciles). It pre-flagged `class-11` (gap-ignores-ifg, conformant at the default `cfg_ifg`) as a probable config-coverage survivor of the suite — a SUITE finding, not a seeding miss. | auditor, `J-auditor-0027` |
| **3 — the operator runs** | 2026-08-12 | **THIRTEEN NEVER-MERGE REFS RUN, step 6 read at source.** One `mut/wo-0084-class-NN` ref per class = `9dba6d5` + the unmodified diff, pushed, one CI run each, read per the sealed step-6-not-job rule. **FINAL: 11 KILL, 1 SURVIVOR, 1 COMPILE-FAIL.** KILL (suite step-6 FAILURE): classes 01, 02, 04, 05, 06, 07, 08, 09, 10, 12, 13. SURVIVOR (suite step-6 SUCCESS; step-9 snapshot-verify red = the emitted RTL changed, which is not a behavioral test): **class-11** — exactly the config-coverage gap the auditor pre-flagged. COMPILE-FAIL (step-5 Build FAILURE, suite never ran): **class-03** (tkeep-ignored) — the mutant does not compile; unscoreable or a manifest defect, dv adjudicates. class-08 needed one re-run (attempt 1 = a step-4 opam-install transient, the fb58ba3 class; attempt 2 green-through-build, step-6 FAILURE = KILL). Full table (class / mutant SHA / run id / build-job id / step-6 conclusion) in `J-orchestrator-0281`, the run evidence dv scores from. The operator applied every diff unmodified (ADR-0019); no diff was edited; the compile-failure and the survivor are reported, never repaired. | orchestrator, `J-orchestrator-0281` |
| **4 — the scoring** | 2026-08-12 | **SCORED — THE SEAL IS UNFALSIFIED: 7 of 7 seeded IC predictions confirmed, ZERO misses; three findings filed.** **UNSEAL — recorded HERE, not by editing the seal.** The seal (`agents/handoffs/WO-0084-SEALED-predictions.md` §State) committed in its own frozen text to *not* mutating its state line, so the immutability check stays the flat `git diff` against the freezing commit = **empty, full stop** (`docs/PROCESS.md` §3.3 `[B.11·8]` — strictly stronger than *"empty but for one line"*); and its second copy in `J-dv_lead-0195` is append-only (PROTOCOL §5 R3) and cannot be flipped at all. The coherent, rule-abiding unseal is therefore this Return-log row, exactly where the seal's §State said it would live. Verified `git diff 9dba6d5 8b3ec95 -- <seal>` = **empty**. The campaign is **UNSEALED** by this row on the operator's word (`J-orchestrator-0281`) that all 13 refs ran; I declined the one authorized state-line flip to preserve the flat check — grounds in `J-dv_lead-0196`, orchestrator may direct otherwise. **RECONCILIATION** (auditor `class-NN` → dv `IC` → sealed disp → step-6 → score): 01→IC-1 KILL/FAILURE ✓ · 02→(no IC: M04-B1 lane-reversal, seal §10.2)/FAILURE · 03→IC-2 KILL/**Build-FAILURE = COMPILE-FAIL** · 04→IC-3 KILL/FAILURE ✓ · 05→(no IC: M04-C1/C4 pad-value)/FAILURE · 06→IC-4 KILL/FAILURE ✓ · 07→IC-5 KILL/FAILURE ✓ · 08→IC-7 KILL/FAILURE ✓ · 09→IC-8 KILL/FAILURE ✓ · 10→(no IC: M04-F1/F4 gap-shorten)/FAILURE · 11→(no IC: M04-F3 cfg_ifg, OUTSTANDING)/**SUCCESS = SURVIVOR** · 12→IC-13 KILL/FAILURE ✓ · 13→(no IC: M04-G1 §9 abort-word shape)/FAILURE. **7 auditor classes map to a dv IC and validly ran (01,04,06,07,08,09,12) — all 7 predicted-kill-and-killed. 5 map to no IC (02,05,10,11,13) — the blind partitions differ, as promised. class-03 maps to IC-2 but does not compile.** **TALLY A — the seal scored, unit = the CLASS (PROTOCOL §7 b.1):** sealed **13** = seeded **7** + exclusions **6**; seeded 7 = killed **7** + survived **0** + green-by-blindness **0**. Exclusions itemised to ground: **IC-2** rendered by class-03 but non-compiling → build-fail, UNSCOREABLE (seal §8 disp 7); **IC-6, IC-9, IC-10, IC-11, IC-12** never rendered (no auditor class renders CRC-reseed / rejected-reading-gap / abort-gap-from-`/E/` / strobe-at-`/E/`-word / strobe-per-withheld-cycle) — each sits in `sealed`, none in `seeded`. **IC-10 is my pre-committed SURVIVE; unrendered, it scores nothing either way — but its root cause (cfg_ifg = 12 everywhere) is independently confirmed by class-11's survival.** **TALLY B — the manifest operated, unit = the auditor's 13:** attempted **13** = seeded **12** + exclusion **1** (class-03, non-compiling manifest defect); seeded 12 = killed **11** + survived **1** + green-by-blindness **0**. Both closures hold. **MISSES: ZERO** — no predicted-kill survived, no predicted-survive was killed. **SURVIVOR evidence form (b.2), class-11:** unmodified diff `docs/reports/audit/WO-0084-mutations/class-11-gap-ignores-ifg.diff`, ref `mut/wo-0084-class-11 = 6850609`, run `31581478422` job `94065308971`, step-6 **SUCCESS** (step-9 snapshot RED = emitted RTL changed, non-behavioral); falsifier-shaped witness — invisible to the suite ONLY because no committed unit drives `cfg_ifg ≠ 12`; a unit driving `cfg_ifg ∈ {20, 255}` reddens (auditor §3). Coverage gap, NOT an equivalent mutant. **FROZEN-KILL limb:** every kill carries the campaign record PLUS its seal-named killing unit present at HEAD `8b3ec95` (`test/xgmii_tx_64/` byte-identical `6d92bf9`→HEAD) and green as measured at the byte-identical base (step-6 SUCCESS, run `31577965739`); the gate-SHA-green half discharges at `P1-module-ready`. **FINDINGS FILED:** **WO-0084-S1** (MINOR, mine, PRE-COMMITTED per seal §11.7): M04-F6's Kills-cell and failure-message figure `16` is arithmetically unreachable (abort gaps ≡ 7 mod 8; 16 ∉ {7,15,23,…}); it stands on the seal's arithmetic alone (IC-10 was not rendered) and so cannot be a finding invented to fit a result — routed to `test/attack_plans/AP-xgmii_tx_64.md` M04-F6 correction. **WO-0084-S2** (coverage debt, mine): the M04 suite never varies `cfg_ifg` (census: 12 on every cycle of every unit); class-11 survived for exactly this; M04-F3 is OUTSTANDING; carrier = a `cfg_ifg`-varying unit (drive {12, 20, 255}) via a tb_writer WO I draft next, and IC-10 is RE-RUN not re-quoted the day M04-F3 lands (seal §10.6). A SUITE finding, not a seeding miss — the auditor pre-flagged it blind (act 2). **WO-0084-S3** (routed to the auditor): class-03 is UNSCOREABLE and a MANIFEST DEFECT — step-5 Build FAILURE falsifies the manifest §4 type-correctness attestation; probable cause, consistent with the committed diff, is the removed sole consumer of `held_keep` (an unused binding under warnings-as-errors); IC-2 (M04-B2/M04-C4 tkeep-ignored) is left untested — re-seed with a compiling mutant. I touched neither `docs/reports/audit/**` (auditor's) nor `docs/process-golden-tally.json` (M03's). **M04 warrants its own committed tally file at the future `SO-xgmii_tx_64.md` sign-off, homed in `docs/` (architect_docs_lead's scope, not mine) — flagged as owed, not created this round.** | dv_lead, `J-dv_lead-0196` |
