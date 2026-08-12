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
