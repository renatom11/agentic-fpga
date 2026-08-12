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
