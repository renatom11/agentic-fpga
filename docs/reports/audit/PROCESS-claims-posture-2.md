# PROCESS-claims-posture-2 — the scheduled re-measurement: the stamp apparatus censused against the committed eighth edition

- **Auditor**: auditor (independent), journal entry `J-auditor-0030`
- **Commissioned by**: the orchestrator, as **POSTURE-RE-MEASUREMENT-2** — queued
  on `tasks/BOARD.md` since `J-orchestrator-0285` (2026-08-12) and re-stated at
  `J-orchestrator-0309` (2026-08-22). Spawn short-id
  `POSTURE-RE-MEASUREMENT-2/2026-08-22T07:05Z`. Work-order id: **none**
  (dispatch-only round — itself an instance of row **C-70** below).
- **Predecessor**: `docs/reports/audit/PROCESS-claims-posture.md`
  (POSTURE-RE-MEASUREMENT-1, `J-auditor-0023`, landed `89998a6`, notes appended
  at `22c60fb`). Its Note 5 scheduled this round in terms: *"The full
  re-measurement is SCHEDULED, not performed… to be run against a committed
  edition after the current revision cycle stops moving."* **This is that round**,
  and it obeys that file's own protocol: nothing above this line's counterpart in
  that file is edited; it stays the measurement of `6c02f5b`, and a dated Note 6
  appended there points here.
- **The queue named the seventh edition; the eighth is what stands, and the
  eighth is what was measured.** The board's row reads *"the auditor's posture
  re-measurement against the seventh edition"* (`2ed029d`). The document has since
  moved to its **eighth edition** (`9f6336a`, 2026-08-17) and through two further
  committed acts on the same file (`9ba1138`, `8dff23a`, both 2026-08-18). A
  census pinned to a superseded edition would reproduce row `C-75`'s own decay
  class, so the subject is **the committed text at this round's HEAD**, and the
  queue's name is recorded as what it was: a name, not the subject.

## Audit subject, pinned

- **Pin**: everything below is measured against the **committed** state at
  `949b8abba0e27e0888cf78677d561d55a8d499f3`, read via `git show HEAD:<path>`,
  never from the working tree. The pin was ordered by the dispatch because a
  sibling lane may amend `docs/PROCESS.md` while this round runs; it did (below).
- **Subjects**: `docs/PROCESS.md` (6,115 lines / 410,403 bytes at HEAD),
  `docs/PROCESS-MEMOIR.md` (2,618 lines / 254,247 bytes),
  `docs/PROCESS-STE.md` (3,484 lines / 207,369 bytes).
- **Machinery re-executed against**: `scripts/policy.sh`, `scripts/agent_commit.sh`,
  `scripts/check_journals.sh`, `scripts/check_process_doc.sh`,
  `scripts/test_protocol.sh`, `.github/workflows/journal-check.yml`,
  `agents/PROTOCOL.md`, `agents/charters/**`, `docs/adr/ADR-0001..0023`,
  `docs/gates/**`, `agents/handoffs/**`, `agents/journals/**`, `tasks/BOARD.md`,
  and git history including the 86 `mut/*` references on `origin`.
- **Precheck** (PROCESS §4.1, executed before any file was opened):
  `git status --short` → **empty**; `git rev-parse HEAD` →
  `949b8abba0e27e0888cf78677d561d55a8d499f3`, exactly the expected head.
  Proceeded.
- **Outward sibling declaration** (PROCESS §4.2): one lane declared — the
  architect's amendment batch, write scope `docs/**` (except
  `docs/reports/audit/**`), `README.md`, `ORG_CHART.md`, `agents/charters/**`,
  `agents/handoffs/**`, its own journal.
- **Inward check, and it fired.** Re-checked mid-round at 2026-08-22T13:44Z:
  HEAD **unchanged** at `949b8ab`; the working tree **dirty in three paths, all
  inside the declared sibling set** — ` M docs/PROCESS.md`,
  ` M agents/handoffs/README.md`, `?? docs/adr/ADR-0024-the-constitution-is-the-last-mile.md`.
  No undeclared path. **No measurement in this report is affected**, because every
  one was taken from `git show HEAD:` rather than from disk; the working-tree
  draft `ADR-0024` is **PROPOSED, uncommitted, and applies nothing** by its own
  status block, and where it bears on a finding below it is named there.
- **Environment**: the dispatch warned that this container has twice restored from
  stale snapshots. HEAD and the tree were re-read at the start, at the midpoint
  and at the freeze; no file or commit vanished under this round.
- **Stamps**: precheck 2026-08-22T13:29Z; inward re-check 13:44Z; second inward
  re-check at freeze **13:53Z** — HEAD still `949b8ab`, the sibling lane now also
  showing ` M docs/PROCESS-MEMOIR.md` and ` M docs/PROCESS-STE.md`, both inside
  its declared scope, both irrelevant to a report read from `git show HEAD:`.

---

## 0. What this round is, and the two things it is not

**It is a re-measurement of the stamp apparatus.** `docs/PROCESS.md` carries a
posture stamp on each of its enforcement and event claims, each citing a row
`C-nn` of the predecessor's 128-row list. This round censuses every stamp in the
committed text, checks each against the row it cites, and re-measures the cited
rows **against the record as it stands at HEAD** — machinery re-executed, events
re-anchored, absences re-verified.

**It is not a claim-by-claim census of the whole document.** The predecessor
measured 1,445 lines; the text is now 6,115. This round measures the **147 live
stamp citations and the 125 rows they reach**, plus the claim-drift of all 128
rows against both volumes. The **~4,600 lines that carry no row** are counted and
characterised in §6 and are *not* graded here. The document's own boundary block
(`docs/PROCESS.md`:380–420) says the same thing from the other side, and the
complete repair it names — *"the re-measurement owed at B.2 item 8"* — is
**partly, not wholly, paid by this file**. §6 states exactly which part.

**It is not a findings report about the whole program.** Severity-graded findings
appear in §5 and are confined to what this round measured.

### 0.1 Posture vocabulary — the five carried, and the one minted

Carried unchanged from the predecessor (`PROCESS-claims-posture.md` §0.1):
**MACHINE-CHECKED** (a script or CI step refuses or fails on violation),
**REVIEW-ENFORCED** (a named seat, form or artifact carries it; no instrument),
**PERFORMED-ONCE** (asserted as an event, and the event happened),
**PLANNED** (owed; the instrument does not exist),
**FALSE** (contradicted by the machinery or the record), plus **NOT SAMPLED**.

**One grade is minted here, and the reason is the same reason the document minted
its own seventh grade.** Since the first measurement the program has built
instruments that **run on both surfaces and never refuse** — `WARN-STAMP`, and
`R10`'s size limb on the pushed-history surface. Against the frozen definitions
such an instrument is neither MACHINE-CHECKED (nothing refuses) nor PLANNED (the
instrument exists, runs, and is exercised by twelve self-test scenarios). Forcing
it into either grade would misreport it in one direction or the other, so:

| Posture | Meaning | What the evidence column must show |
|---|---|---|
| **BUILT-ADVISORY** | An instrument exists and runs on the surfaces the rule names, and **never refuses**; its output is a warning whose absence is not a clearance | script path:line on every surface, the self-test scenario ids, and the decision record that set the posture deliberately |

This is exactly the defect the document convicted itself of at `[B.12·7]` — *a
vocabulary a document uses in its running text and omits from its own legend is a
vocabulary that cannot be corrected, only argued about* — arriving in the
measuring apparatus rather than in the measured text. It is recorded as a mint,
not smuggled in as a re-grade.

### 0.2 Sampling frame (charter §8, mandatory)

**In the window**: every posture stamp in the committed `docs/PROCESS.md`; every
`C-nn` token in it; the same in `docs/PROCESS-MEMOIR.md` and `docs/PROCESS-STE.md`;
and the record each cited row rests on.

**Sampled and executed**: all 193 stamp tokens; all 152 `C-nn` tokens; all 128
frozen rows for claim-drift across both volumes; **the full protocol self-test**
(`bash scripts/test_protocol.sh` → **68 passed, 0 failed**); **14 live probes** of
`agent_may_write` by sourcing `scripts/policy.sh`; **86 ancestry tests** over
`origin/mut/*`; the document's own printed seam-derivation command, re-run; and
~40 targeted greps and `git log`/`git show` queries over history, journals,
packets, ADRs, gates and scripts. No commit, no push, no state mutation, nothing
staged outside `docs/reports/audit/**`.

**Deliberately skipped, and why**:
1. **The unstamped body of the document** — §6 item 1. Counting it is in frame;
   grading it is a larger round and pretending otherwise would produce the
   coverage illusion this apparatus exists to prevent.
2. **The STE rendition's fidelity to the core.** It is non-normative by its own
   text and was cold-probed once on 2026-08-18 (thirteen defects, repaired). This
   round verifies only its two structural promises (§1.4).
3. **The charter's per-phase ≥10% journal-Evidence sampling** (`agents/charters/auditor.md`:65).
   Not discharged here; still owed. Stated in §6 so the sample is reconstructible.
4. **Re-execution of the shell repository's half of the export unit.** Out of
   reach from this seat, as the document itself says.

---

## 1. The census

### 1.1 Headline

| Measure | At HEAD (`949b8ab`) |
|---|---:|
| Stamp tokens in `docs/PROCESS.md` | **193** |
| — of them, in the two legend blocks (`:331–339`, `:5320–5327`) | 16 |
| — of them, row-less by design: `[SF]` (substrate fact) | **8** (4 live) |
| **Live stamp citations** (a stamp attached to a claim, carrying a `C-nn`) | **147** |
| Distinct rows reached by a live citation | **125 of 128** |
| Rows never cited anywhere in the core | **3** — `C-01`, `C-06`, `C-40` |
| Live citations transcribing their row's frozen posture exactly | **143 / 147 (97.3%)** |
| Live citations whose stamp kind contradicts the row's frozen posture | **4** |
| `C-nn` tokens in the file, total (the seam column's subject) | **152** |

**Live citations by kind**: `[RE]` 48 · `[MC]` 37 · `[P1]` 29 · `[PLANNED]` 16 ·
`[CORRECTED]` 15 · `[UNANCHORED]` 2.

**Reproduce it**: `git show HEAD:docs/PROCESS.md`, extract
`\[(MC|RE|P1|PLANNED|CORRECTED|UNANCHORED|SF)\b[^]]*\]` over the file with
newlines flattened (two stamps are line-wrapped — `[P1 · 2026-08-03 · C-55]` at
`:2151–2152` and one other — and a line-based extractor misses both, which is how
the first pass of this round briefly and wrongly recorded `C-55` as uncited).

### 1.2 The seam column, re-derived rather than adopted

The document publishes a per-section seam count and prints the command that
derives it (`docs/PROCESS.md`:710–726), declaring **72 headings**. Re-run
verbatim at HEAD: **72 headings, and the column sums to 152.** Both figures
reproduce.

**What the 152 decomposes into, which the document does not state**: 147 stamp
citations + **5 bare prose mentions**, all of one shape — *"Row `C-46` measured
the world before that limb landed"* (`:1966`), and the same at `:2138` (C-54),
`:2161` (C-55), `:2321` (C-46), `:4536` (C-119). Those five are **staleness
disclosures**: sentences whose content is that the cited row no longer describes
the world. They are counted by the column as measurement. This is inside the
column's own declared limit (*"it counts citations, not claims"*) and is therefore
recorded as a decomposition, **not filed as a finding** — but a reader taking 152
as a coverage figure should know that five of it point the other way.

### 1.3 Claim drift: does the stamped sentence still say what the row measured?

For each of the 128 rows, the frozen quote cell was normalised and its longest
fragment searched in both volumes at HEAD:

| Result | Rows |
|---|---:|
| The measured claim still occurs **verbatim in the core** | **111** |
| Occurs **only in the companion** (superseded margin) | **1** — `C-40` |
| Occurs in **neither** volume verbatim — the claim was re-worded | **16** |

The sixteen: `C-07, C-09, C-13, C-15, C-23, C-33, C-41, C-43, C-67, C-72, C-73,
C-80, C-93, C-97, C-113, C-127`. Six of them (`C-07, C-33, C-67, C-80, C-93,
C-97`) are FALSE rows whose claim was *deliberately* rewritten — that is the
apparatus working. The other ten are re-wordings of surviving claims, and **a
stamp on a re-worded claim is a posture measured over the earlier wording**.

**Spot-check, four of the ten, read in place**: `C-13` (`:1017–1019`), `C-15`
(`:1037–1039`), `C-43` (`:1880–1883`), `C-73` (`:2748–2751`). All four are
condensations or *disclosed strengthenings* — `C-73`'s site says in terms that
the property is now per-chain and *"stronger than the first edition's per
journal"*; `C-43`'s names the `R8` seeding exception the frozen quote omitted.
**None extends the claim's extent.** The remaining six were not read, and no
posture is asserted about them here.

### 1.4 The two companion volumes

- **`docs/PROCESS-STE.md`** makes two structural promises: that it is not law and
  that **it restates no `C-nn` row**. Measured: `grep -c "C-[0-9][0-9]"` → **0**.
  It carries 22 bare posture tokens (`[MC]` 5, `[RE]` 5, `[SF]` 3, `[PLANNED]` 3,
  `[CORRECTED]` 2, `[P1]` 2, `[UNANCHORED]` 2) as calibration words, none citing a
  row. **The promise holds.**
- **`docs/PROCESS-MEMOIR.md`** holds the superseded record: **69 sentinel blocks**
  (`SUPERSEDED — historical record`), against **0** in the core — falsifier 1 of
  the split, re-run here and green, and also enforced per push by
  `scripts/check_process_doc.sh` (wired at `.github/workflows/journal-check.yml`:25).
  Eleven of the twelve `[CORRECTED · C-nn]` stamps in the core have an anchored
  margin in the companion under the matching core section; **one does not** —
  finding **F-0030-6**.

---

## 2. Transcription fidelity, and the three uncited rows

**143 of 147 live citations carry the kind their row decides.** The four
deviations, all in §1.0–§1.1, all on the sole-committer/packet-numbering family:

| Site | Stamp | Frozen row posture | What the sentence says |
|---|---|---|---|
| `:836` | `[RE · C-07]` | **FALSE** | *"Sole-committer: `[RE · C-07]` — no repo instrument binds who runs the version-control tool, **and the row deciding it graded the unqualified claim false**"* — the deviation is disclosed in the same sentence |
| `:854` | `[RE · C-07]` | **FALSE** | *"the **sole committer**: no other agent runs a commit or a push"* — **this is the exact sentence the row graded FALSE**, restated in the indicative under a stamp that does not say so |
| `:879` | `[RE · C-07]` | **FALSE** | *"No instrument in this repository binds who runs the version-control tool"* — a different, true claim; `[RE]` is the right posture for it |
| `:914` | `[RE · C-08]` | **FALSE** | *"Packet numbers are allocated at commit time by the one seat that commits, which puts allocation under one authority"* — the repaired claim; the false half (*"monotonic by construction"*) is preserved with its own `[CORRECTED · C-08]` at `PROCESS-MEMOIR.md`:454–456 |

Three rows are reached by no live citation:

- **`C-01`, `C-06`** — deliberately, and disclosed. The spawning monopoly was
  re-graded from `[RE]` to the newly minted `[SF]` (`:341–353`, `:833`, `:852`,
  `:866`), and `[SF]` *"carries no `C-nn` row, deliberately"* by the legend's own
  text. **Re-measured and concurred**: `agents/PROTOCOL.md`:30–31 asserts the
  substrate fact, no repo instrument refuses a spawn, and the frozen `C-06` row
  said as much. The re-grade improves the apparatus; it does not lose a
  measurement, because the committing limb it was fused to now carries `C-07`
  separately.
- **`C-40`** — not deliberate in the same way. Its `[CORRECTED · C-40]` marker
  lives at `PROCESS-MEMOIR.md`:603; the core carries the corrected text at
  `:1845–1862` with **no marker at all**. Finding **F-0030-5**.

---

## 3. Movement since re-measurement 1

Rows whose posture or whose supporting world moved between `6c02f5b`
(2026-08-11) and `949b8ab` (2026-08-22). Every cell is re-executed, not carried.

| Row | Frozen | **At HEAD** | What moved, and the evidence |
|---|---|---|---|
| **C-54** | PLANNED | **BUILT-ADVISORY** | `WARN-STAMP` exists and runs on **both** surfaces: `scripts/agent_commit.sh`:184–208, `scripts/check_journals.sh`:35–41, :217–243, :327–352; band at `scripts/policy.sh`:16; `ADR-0021` §2. Self-test **S40–S46** green in this round's run. It never refuses (`exit 0` asserted by S40/S41/S44/S46) — hence the new grade, not `[MC]`. |
| **C-119** | PLANNED | **BUILT-ADVISORY** | Same instrument; the latency-buying warning the corollary is stated about now exists. Core states the landing at `:2120–2132`. |
| **C-46** | MACHINE-CHECKED *(one surface only)* | **MACHINE-CHECKED** *(both surfaces, postures differing per limb)* | Commit surface refuses at `agent_commit.sh`:178–179 and warns at :180–181; the history surface now evaluates the same subject as a **warning** at `check_journals.sh`:105–118 and aggregates at :356–383 (`ADR-0021` §3). Self-test **S47–S51**. |
| **C-55** | PERFORMED-ONCE *(with a live unrepaired instance)* | **PERFORMED-ONCE** *(instance closed)* | The corollary's own family counterexample — the unmirrored size limb — closed 2026-08-12. The row's qualification is spent; the posture is not. |
| **C-56** | FALSE | **corrected text stands** | *"Every rule the commit script enforces is re-verified by CI over the entire pushed history"* `[CORRECTED · C-56]` at `:2178–2181`. Re-executed: both scripts now carry R2–R11 predicates (`check_journals.sh` additionally R9); the one former exception is present on both surfaces, and the core states the per-limb posture difference explicitly at `:2189–2199` rather than claiming identity. |
| **C-53** | PLANNED | **PLANNED** *(for the subject the row measured)* | `grep -rn "WARN-SEAL" scripts/ .github/` → **0 hits**, unchanged. A *different* note of the same class was **refused with grounds** (`ADR-0021` §5.2) and the core says so at `:2075–2106`, correctly distinguishing the two. **No movement in the measured subject.** |
| **C-109** | PLANNED | **PLANNED** *(and the row's evidence sentence is over-broad — F-0030-2)* | Zero relay-fidelity spot-checks on any `SO-`/`BUG-` packet, of which **five** now exist. But one was performed on 2026-08-01 on a verbatim-class relay and found a defect: `AUD-0002-g0-reverification.md`:126–152, finding `AUD-0002-N1` (MAJOR). |
| **C-11 / C-27** | PERFORMED-ONCE | **PERFORMED-ONCE as a cycle; the control has fired twice** | `FINDING WO-0074-A1` (MAJOR, auditor) was filed against the orchestrator's own dispatches and ruled ACCEPTED 2026-08-10 (`ADR-0019`:3–5, :21, :80). F-0030-3. |
| **C-97** | FALSE | **corrected in this document; still false in its source** | Core `:3591` states the per-artifact placement correctly. `agents/PROTOCOL.md`:404–408 still prescribes the transient uncommitted-tree model. **F-0030-1.** |
| **C-100** | REVIEW-ENFORCED | **REVIEW-ENFORCED, re-executed true** | 86 `origin/mut/*` refs; `git merge-base --is-ancestor <ref> HEAD` over every one → **0 ancestors**. Population grew from 85 to 86; the property holds and nothing but discipline holds it. |
| **C-105** | REVIEW-ENFORCED, performed | **REVIEW-ENFORCED, and the harvest gained a local landing** | `docs/LESSONS.md` exists as of `5d2264d` (2026-08-17), the travel copy `ADR-0023` mandates. No instrument reads it. |
| **C-32** | FALSE | **corrected text accurate; the underlying decay deepened** | Core `:1520–1522` now says *"written once at the founding and never refreshed since"* — true: `agents/journals/INDEX.md` unchanged since `550df53` (2026-08-01), 21 days and one passed gate boundary ago. **F-0030-7.** |
| **C-08 / C-70** | FALSE | **corrected text stands; its printed count is now short by two** | Six work-order identifiers are live in reasoning-log headers with **no packet file at any commit**: `WO-0048/0051/0052/0053` (the measured four) plus `WO-0065B` and `WO-0068B`. **F-0030-8.** |
| **C-104** | REVIEW-ENFORCED (block) | **unchanged** | The scoring block still carries **15** top-level bullets (`:3732`–`:3860`), exactly as Note 3 measured at `9362aef`; `grep` over `scripts/ .github/` finds no script reading a tally, a sealed column, an equivalence proof or the floor. |
| **C-94** | PERFORMED-ONCE, sample size one | **unchanged, eleven days on** | `git ls-tree -r --name-only HEAD agents/handoffs/` lists exactly one `SO-` packet, `SO-xgmii_rx_64.md`. The element list still carries the seventh element (`:3487–3496`) and now declares itself *"a floor, not a description of any packet."* |
| **C-24** | NOT SAMPLED | **still UNANCHORED** | Two live `[UNANCHORED · C-24]` stamps (`:1299`, `:4721`), unchanged since 2026-08-11. The exhibit remains owed an anchor or a removal. |
| **Row-less tier** | — | **one moved, in the right direction** | Between `2ed029d` and HEAD exactly one row-less stamp changed: `[PLANNED — no posture row; the instrument does not exist]` became `[MC — no posture row; added after the measurement]` for the governance check (`:5195–5196`), which does exist (`scripts/check_process_doc.sh`, wired at `journal-check.yml`:25) and **refuses** on every check it makes. Correct grade, correctly disclosed. |

---

## 4. Re-executed and unchanged

These rows were re-executed in full because they are the load-bearing
machine-checked claims, and a re-measurement that only reports movement cannot be
distinguished from one that did not look.

- **`C-02` / `C-25` / `C-26` — the auditor's confinement.** Probed live by
  sourcing `scripts/policy.sh`: `auditor → docs/reports/audit/x.md` **ALLOW**;
  `→ docs/gates/…` **DENY**; `→ agents/handoffs/…` **DENY**; `→ libs/…` **DENY**;
  `→ docs/PROCESS.md` **DENY**. Refusal sites `agent_commit.sh`:243,
  `check_journals.sh` path-isolation limb; self-test **S6**, **S25**. Unchanged.
- **`C-21` — line separation.** `rtl_lead → test/` DENY, `rtl_module_dev → test/`
  DENY, `dv_lead → libs/` DENY, `tb_writer → libs/` DENY. Unchanged.
- **`C-10`** — `orchestrator → docs/reports/audit/x.md` **ALLOW**. Unchanged.
- **`C-40`'s underlying fact** — the scopes are still **not disjoint**:
  `agents/handoffs/*` ALLOW for all seven non-orchestrator seats; `libs/*` for
  `rtl_lead` and `rtl_module_dev`; `test/*` for `dv_lead`, `tb_writer`,
  `formal_dv`. Unchanged.
- **`C-93`'s underlying fact** — `architect_docs_lead → docs/gates/P1-module-ready-checklist.md`
  **ALLOW**. The control is still a sentence inside the checklist, not the scope
  table. Unchanged.
- **`C-50`** — `rtl_module_dev → libs/anything/at/all.ml` **ALLOW**; no per-packet
  narrowing exists in `policy.sh`. Unchanged.
- **`C-72`** — no enforcement script mentions `Trigger`, `Inputs`, `Reasoning`,
  `Evidence` or `Open-questions`; only `test_protocol.sh` does, as fixture text.
  An entry with no Reasoning section still commits clean. Unchanged.
- **`C-44`** — `grep -rn "Previous-volume-bytes" scripts/` returns **one** hit,
  `test_protocol.sh`:93, a fixture generator. The field is still verified nowhere.
  Unchanged.
- **`C-58` / `C-115`** — branch protection configured and live-fire verified
  (`docs/gates/G0-checklist.md`:17). Unchanged.
- **The self-test itself** — `bash scripts/test_protocol.sh` → **68 passed, 0
  failed** (51 at the first measurement; the 17 new cases are `ADR-0017`/`ADR-0021`
  scenarios). `git status --short` empty before and after; HEAD unchanged.
- **The three figures the boundary block states about itself** — 6,115 lines,
  410,403 bytes for the core and 254,247 bytes for the companion — all three
  reproduce **exactly** at HEAD, as does the ratio *"past four times"* (4.23).
  The block's rule of re-measuring in the act that moves it is being kept.

---

## 5. Findings

Eight findings. **No CRITICAL** — nothing here blocks a gate. Severity uses the
program's four grades; each finding names the seat it routes to and the artifact
that would falsify it.

### FINDING F-0030-1 — **MAJOR** — routes to: **orchestrator**

**The constitution and the auditor's charter still teach a mutation model the
record retracted twelve days ago, and the decision record that would repair them
has been PROPOSED, unapplied, for the whole of that period.**

`agents/PROTOCOL.md`:404–408 states: *"the auditor authors mutation manifests
(patches) under `docs/reports/audit/mutations/`; the **orchestrator applies each
manifest transiently in an uncommitted working tree**, runs the DV suite against
it, reverts fully, and never lets mutated RTL enter history."*

Measured against the record at HEAD:
- **86 `mut/*` references** exist on `origin`, every campaign in the record ran as
  pushed commits on them, and **0 of the 86 are ancestors of HEAD** (re-executed
  this round, `git merge-base --is-ancestor`).
- The manifests live in **sixteen `docs/reports/audit/WO-*-mutations/`
  directories**; `docs/reports/audit/mutations/` **has never existed**.
- `ADR-0019` — the record of this — carries **`Status: PROPOSED`** at line 3
  while stating in the same block that the rule *"has been in force since
  `J-orchestrator-0218`"* (2026-08-10). Its §7.1/§7.2/§7.3 hold the repairing
  diffs as source text, **written and unapplied**: `grep -c "operator table"` over
  `agents/PROTOCOL.md` → **0**.
- **The charter of the seat writing this report is one of the misdescribing
  files**: `agents/charters/auditor.md`:22 instructs its reader to file manifests
  under `docs/reports/audit/mutations/` and states that the orchestrator applies
  them *"transiently in an uncommitted working tree — mutated RTL never enters
  history."* This spawn read that instruction as its first mandatory action, as
  every auditor spawn since 2026-08-10 has.

**Why MAJOR and not MINOR**: the affected files are the two a stateless agent must
read before acting (`PROTOCOL` §2, every charter §1). A false mechanism in the
constitution is not a documentation defect; it is the input to every future spawn,
and it is the exact class `PROCESS` §2.1 names — *a control that is claimed to be
mechanical and is not is worse than a control known to be advisory.* **Why not
CRITICAL**: no artifact was mis-graded by it, the practice is correct, and the
divergence is disclosed in three places (`ADR-0019` §1.1, `PROCESS` `:3591`,
`PROCESS-MEMOIR` B.2 item 13).

**Recorded in fairness, and it does not close the finding**: the sibling lane's
**uncommitted** working-tree draft `docs/adr/ADR-0024-the-constitution-is-the-last-mile.md`
carries this as its subject **A8**, with the replacement hunk drafted at its §11
and five charter re-quotes at its §12. It is `PROPOSED`, applies nothing by its own
status block, and is at no commit. **Closing event**: the orchestrator's `PROTOCOL`
§11(2) acceptance act landing the `ADR-0019` §7 or `ADR-0024` §11/§12 hunks into
`agents/PROTOCOL.md` and `agents/charters/**`. Until an act lands, the finding
stands.

### FINDING F-0030-2 — **MINOR** — routes to: **auditor (this seat, against its own frozen row)** and **architect_docs_lead**

**Row `C-109`'s evidence sentence — *"Zero spot-checks in the program's history"* —
is refuted by the program's own record, and `docs/PROCESS.md` has inherited the
error into its instrument register.**

`docs/reports/audit/AUD-0002-g0-reverification.md`:126 opens *"### 3.4
Relay-fidelity diff of the transcribed Return log"*, states at :129 that this is
*"the first verbatim-class relay in the program's life, so this is the first time
the control has had a subject"*, diffs eight relayed claims line by line against
their sources, and convicts one: :146 — a findings tally relayed as *"1 CRITICAL,
6 MAJOR, 6 MINOR, 4 NOTE"* against a source reading 1/7/7/2 — filed as
**`AUD-0002-N1` (MAJOR)** at :574. **A relay-fidelity spot-check was performed on
2026-08-01 and it caught a defect.**

`docs/PROCESS.md`:975 restates the frozen row as *"Relay-fidelity spot-check on
protected classes | §4.3 `[PLANNED · C-109]` | **Never.** Two receiving-seat
checks fired instead"*, citing the row faithfully — which is why this finding
routes first to the seat that wrote the row.

**The corrected statement**: one relay-fidelity spot-check has been performed
(2026-08-01, on the transcription of the auditor's own verdict into a packet
Return log — the verbatim class by `PROTOCOL` §3); **none has been performed on
any `SO-` or `BUG-` packet**, of which five now exist (`SO-xgmii_rx_64.md`,
`BUG-0001`–`BUG-0004`). The **PLANNED posture stands** for that limb. The word
*"never"* does not.

### FINDING F-0030-3 — **MINOR** — routes to: **auditor (this seat)** and **architect_docs_lead**

**The register cell *"Audit of the orchestrator | Once, at ratification"*
(`docs/PROCESS.md`:982, citing `C-27`; same fact at `C-11`) undercounts the
control's exercise.**

`FINDING WO-0074-A1` (**MAJOR**, filed by the auditor **against the orchestrator's
own dispatches**, before any branch existed) was ruled **ACCEPTED** by the
orchestrator on 2026-08-10 and is the proximate cause of `ADR-0019`
(`ADR-0019`:3–5, :21, :80; `agents/journals/claude_auditor_agent.v02.md`:27, :269,
:438).

**The distinction that keeps both statements honest, and which neither the row
nor the cell draws**: an *audit cycle whose subject is the orchestrator* has
happened once (`AUD-0001` §6–§7, 2026-08-01). A *finding filed against the
orchestrator's conduct and accepted* has happened twice — 2026-08-01 and
2026-08-10 — and a third time in this file (**F-0030-1**, **F-0030-7**). A reader
of the cell judges whether the independence control is dormant; on the second
measure it is not.

### FINDING F-0030-4 — **MINOR** — routes to: **architect_docs_lead**

**`docs/PROCESS.md`:76–77 misidentifies which edition the evidentiary spine
measured, in the sentence that tells a reader what the stamps cover.**

It reads: *"The second edition was measured claim-by-claim at one commit; that
measurement is what every `C-nn` stamp below cites."*

Measured: `git show 6c02f5b:docs/PROCESS.md` and `git show f67a57a:docs/PROCESS.md`
are **byte-identical** (sha256 both `3e877c9870a00357…`, **1,445 lines**);
`f67a57a` is the first edition's landing commit. The second edition is `2f32e45`
at **2,685 lines** and was *produced from* the measurement, so it cannot have been
its subject. The document says so correctly twice elsewhere — `:381–382`
(*"measured `docs/PROCESS.md` as it stood at one commit, at 1,445 lines"*) and
`:326–328` (*"The first edition stated that rule and did not apply it to itself,
and every false claim found in it…"*). **Falsified by**: the two hashes differing,
or the 1,445-line text being the second edition's.

### FINDING F-0030-5 — **MINOR** — routes to: **architect_docs_lead**

**`docs/PROCESS.md`:258–259 — *"Every one of the fifteen is corrected below and
carries a marker saying so"* — holds for twelve of the fifteen in this volume.**

Census of the fifteen FALSE rows against the committed core:

- **Twelve carry `[CORRECTED · C-nn]`**: C-32, C-33, C-56, C-67, C-70, C-77, C-80,
  C-82, C-93, C-97, C-114, C-123.
- **`C-07` (three sites: `:836`, `:854`, `:879`) and `C-08` (`:914`) carry
  `[RE]`.** By the legend's own table (`:334`, `:337`), `[RE]` says *"a named
  seat, form or artifact carries it"* and only `[CORRECTED]` says *"this text
  replaces a claim the posture list found false."* The sharpest instance is
  `:852–854`, where the sentence the row graded FALSE — *"the sole committer: no
  other agent runs a commit or a push"* — is restated in the indicative under
  `[RE · C-07]`. The disclosure exists (18 lines earlier at `:836–838`, and in the
  companion at `PROCESS-MEMOIR.md`:437 and :454) — **the stamp does not carry it**.
- **`C-40` carries no marker in this volume at all.** Its `[CORRECTED · C-40]`
  lives at `PROCESS-MEMOIR.md`:603; the core's corrected text at `:1845–1862` is
  accurate and unmarked, so *"below"* — which scopes the sentence to this file —
  is short by one.

**Falsified by**: a `[CORRECTED]` marker for C-40 in the core, or a legend that
admits `[RE]` as a correction marker.

### FINDING F-0030-6 — **MINOR** — routes to: **architect_docs_lead**

**One live `[CORRECTED]` stamp promises a preservation that does not exist, and
never did.**

The legend (`docs/PROCESS.md`:337) states that for a `[CORRECTED · C-nn]` stamp,
*"what the superseded claim said, and what refuted it, is preserved in **the
companion volume**, under the section this text sits in."*

`[CORRECTED · C-77]` sits at `:2806`, in **§3.2**. `docs/PROCESS-MEMOIR.md` Part I
carries anchored blocks for §1.1–§1.6, §2.1–§2.7, §3, §3.1, §3.3, §3.4, §3.7,
§3.9, §3.10, §4.3, §4.7, §5, §5.1, §5.5, §6.0, §6.2 and A.7 — **there is no
"Anchored at — 3.2" block**, and the superseded claim (*"The review verdict itself
is a packet… signed with the reviewer's journal entry id"*) appears nowhere in
either volume; searched by content, not by token.

**This is not a split loss.** The fifth edition's passage (`d96a5b1:docs/PROCESS.md`:2336–2342)
is character-for-character the current one: no margin ever existed to lose. So
this is the seventh edition's fourteen-margin repair **class recurring in the
promise rather than in the file** — the stamp legend states a universal that one
of its own instances does not meet. Two lawful cures: write the margin, or qualify
the legend. **Falsified by**: a §3.2 block in the companion, or a copy of the
superseded sentence anywhere in either volume.

### FINDING F-0030-7 — **MINOR** — routes to: **orchestrator**

**`agents/journals/INDEX.md` — the rehydration aid `PROTOCOL` §9 makes the second
artifact of the recovery sequence — has not been touched in twenty-one days, and a
gate boundary passed inside that window.**

`git log -1 -- agents/journals/INDEX.md` → `550df53`, 2026-08-01. At HEAD it still
reads *"rtl_lead … Not yet activated (first spawn: M2)"*, *"dv_lead … Not yet
activated"* (dv_lead is twelve volumes deep), *"orchestrator … J-orchestrator-0012"*
(against `J-orchestrator-0310`), and *"auditor … J-auditor-0003"* (against
`J-auditor-0029`). **Five of its nine rows are false.** `PROTOCOL` §9 says the file
is *"Updated by the orchestrator at gate boundaries"*; `P1-spec-freeze` was signed
through 2026-08-02…04 (`docs/gates/P1-spec-freeze-checklist.md`) and
`P1-module-ready` has been open and edited as recently as `dbbee41` (2026-08-18).

**Why MINOR**: `PROTOCOL` §9 words the duty as a *"best-effort aid, not the live
source of truth"*, and `tasks/BOARD.md` is current. **Why it is still a finding**:
`PROCESS` `:1520–1522` now states the decay as current law with a `[CORRECTED · C-32]`
marker — the document is accurate and the record is the defect, which is the one
direction a documentation round cannot repair.

### FINDING F-0030-8 — **MINOR** — routes to: **architect_docs_lead**

**The printed count of packet-less work-order identifiers is four; its own
predicate selects six.**

`docs/PROCESS.md`:2657–2660 states *"Four work-order identifiers in this program's
record have **no packet file at any commit**, while being live in reasoning-log
headers and in program state"*, and the companion repeats *"four identifiers"* at
`PROCESS-MEMOIR.md`:458.

Measured at HEAD — `git log --all -- 'agents/handoffs/<id>*'` returning zero
commits, against `task:` headers in committed journals:

| id | packet file at any commit | live in a `task:` header |
|---|---|---|
| WO-0048, WO-0051, WO-0052, WO-0053 | none | yes (the measured four) |
| **WO-0065B** | none | `claude_dv_lead_agent.v04.md`:858, `claude_orchestrator_agent.v02.md`:2014, `workers/claude_tb_writer_agent.v02.md`:1986 |
| **WO-0068B** | none | `claude_orchestrator_agent.v02.md`:2203, `workers/claude_tb_writer_agent.v02.md`:2613 |

**The benign reading, stated so the repair is a choice and not a correction**: the
two extra ids are *revision* suffixes whose base packets (`WO-0065`, `WO-0068`) do
exist, and §3.2 `:2801` already distinguishes a letter meaning *revision on a state
line* from one meaning *part in a filename*. The defect is therefore in the
**predicate**, not necessarily in the number: as written, the sentence selects six.
Either qualify it (*"four commissions"*) or move the count. This is the
count-stated-over-a-non-matching-list class the document convicts itself of at
`[B.12·6]`, arriving in a sentence that survived eight editions.

---

## 6. What this round did not do, stated so the sample is reconstructible

1. **It did not grade the unstamped body of the document.** 72 headings carry
   seam counts; **five read `· 0`** and are wholly outside the spine, and every
   other section carries unmeasured text beside its measured sentences. The core
   carries **41 explicit *(no posture row)* markers** (line-wrap-aware count; a
   line-based one returns 37 and misses four): **28** name the *added after the
   measurement* class, **2** are the document's own drafting rules binding no
   seat, and **26 of the 41 state a posture word within 260 characters of the
   marker**, as the legend at `:367–375` requires. The remaining fifteen are
   exhibit-class or state their posture further off; **this round did not
   adjudicate them one by one**. The legend also says such claims are *"owed a
   row at the next audit"*.
   **This audit does not supply those rows, and says so rather than letting the
   round's existence imply payment.** Grading ~4,600 lines of unmeasured prose is
   its own commission, with its own scope and its own frame.
2. **`B.2 item 8` is therefore PARTLY paid.** What is paid: the stamp apparatus,
   its transcription, the 125 rows it reaches, the claim-drift of all 128 rows,
   and the machinery behind every machine-checked claim. What is not: the rows
   owed to the post-measurement text.
3. **The charter's per-phase Evidence duty (`agents/charters/auditor.md`:65 — ≥10%
   of journal Evidence sections re-executed, plus one manifest-driven replay) is
   not discharged here.** This round re-executed the *document's* claims and the
   *machinery*, not the *record's* journal Evidence. Still owed, now over a longer
   phase than when the predecessor said the same thing.
4. **`C-24` and disguise 3 of §5.7 remain unanchored** — unchanged from the
   predecessor; no new anchoring attempt was made this round.
5. **The STE rendition was checked only for its two structural promises**
   (§1.4); its fidelity to the core is not re-measured here.
6. **No remote-side measurement** (push discipline, `C-111`) was performed.
7. **The DV-escape ledger (`docs/reports/audit/dv_escapes.md`) has still never
   existed** — re-verified this round (`git log --all` → empty). No escape has
   been discovered, so there is nothing the ledger would hold; it is recorded
   here as a standing observation rather than filed as a finding, exactly as the
   core's own §1.5 item 5 records it.

---

## 7. The measurement headline, in one paragraph

At `949b8ab` the eighth edition carries **193 posture stamp tokens**, of which
**147 are live citations** reaching **125 of the 128 measured rows**; **143 of the
147 transcribe their row's posture exactly**, and the four that do not are the
sole-committer family, three of them disclosed in place. The document's own
derived seam column reproduces to the token (**72 headings, 152**). **111 of the
128 measured claims still occur verbatim in the core**, one in the companion only,
sixteen re-worded. Against the record as it stands, **three rows have moved**
(`C-54` and `C-119` from PLANNED to the newly named **BUILT-ADVISORY**; `C-46`
from one surface to both), **one row's qualification is spent** (`C-55`), **one
row's correction now stands on machinery that did not exist when it was written**
(`C-56`), and **the rest re-execute unchanged** — including every machine-checked
scope claim, probed live, and the self-test at **68 passed, 0 failed**. The
apparatus is in better repair than the world it indexes: **the sharpest finding of
this round is not against a stamp but against the constitution the stamps quote**
(F-0030-1), where a retracted mechanism is still the text every stateless seat
reads first.

---

*Committed by the orchestrator under `Agent: auditor`; write scope
`docs/reports/audit/**` (PROTOCOL §6, ADR-0003). The auditor ran no git write
command in producing it, modified no artifact it audits, and staged nothing else.
Findings §5 are relayed verbatim (PROTOCOL §3); none is CRITICAL, so none is E4.*
