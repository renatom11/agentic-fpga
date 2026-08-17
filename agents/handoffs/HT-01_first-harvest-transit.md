# HT-01 — The first harvest transit (collation record)

- **State**: EXECUTED — the inbox PR is open; the shell side (screens, transcription, id mapping, hand merge) is the maintainer's (§5)
- **Author**: orchestrator, as collator (ADR-0018 §4.1; Amendment A2 in force at
  `41fead6`, acceptance act `J-orchestrator-0235`)
- **Feeds**: the programme's first shell write under ADR-0018 §4.2 — the generic
  shell (`generic-agentic-fpga-org`) unfreezes for exactly ONE commit, delivered
  as an inbox PR so §4.4's sponsor refusal is exercisable candidate-by-candidate
  before any shell history moves. The moment question A2 leaves open
  ("may the shell commit land before the gate that ratifies it") is not decided
  here; the PR form preserves every party's position (ruled at
  `J-orchestrator-0236`).
- **Trigger**: `SO-xgmii_rx_64` **PASS**, fourteen of fourteen, one token, at
  sign-off SHA `41fead6` (`J-dv_lead-0168`, landed `69f1475`), after two honest
  FAILs both preserved quoted beneath it.

## 1. Census — the seven minting chains, at their landed SHAs

Derived from `git show HEAD:` and `git log --grep` at `be4de65`. Counts are the
notes' own and are re-measured at extraction (§3) before any statement moves.

| seat / chain | harvest note | span, as the note states it | landed SHA |
|---|---|---|---|
| dv_lead | `SO-xgmii_rx_64.md` §4.2–§4.7 (the packet carries the note; signing entry `J-dv_lead-0161`, corrected through the rounds) | `J-dv_lead-0001 … -0165`, reconciled bank at §4.5 | packet current at `69f1475`; note landed `b80fef1` |
| dv_lead (round 4) | `J-dv_lead-0168` | declared **nil over an empty span** per A2-D10 (prior notes mined `-0001 … -0165` and `-0166 … -0167`) | `69f1475` |
| architect_docs_lead | `J-architect_docs_lead-0034` | `J-architect_docs_lead-0001 … -0034` (A2-D10 re-reads the end exclusive) | `54b2553` |
| rtl_lead | `J-rtl_lead-0013` | `J-rtl_lead-0001 … -0012` | `c55c754` |
| auditor | `J-auditor-0019` | `J-auditor-0001 … -0018` | `185ae66` |
| orchestrator (walk) | `J-orchestrator-0233` | `J-orchestrator-0001 … -0232` | `d53d795` |
| orchestrator (admissibility record) | `J-orchestrator-0234` — the successor note; same eighteen ids, grades and LH3 discharged | same span; ids `LC-orchestrator-H1-1 … -18` unrenumbered | `b4814b0` |
| tb_writer (workers chain) | `J-tb_writer-0041` | `J-tb_writer-0001 … -0040` | `59942de` |
| data_wrangler (workers chain) | `J-data_wrangler-0009` | the seat's chain to its note | `2d47871` |

## 2. Method — binding on this collation

1. **No statement is edited.** A merge's surviving statement is one of the two
   verbatim, never a third sentence (A2-D8). The seeded shell corpus
   (the shell's LESSONS file,
   <https://github.com/renatom11/generic-agentic-fpga-org/blob/main/docs/LESSONS.md>,
   44 entries `L-A01 … L-F08` at the shell's seeding pin) is
   a merge partner: a candidate whose statement matches a seeded lesson merges
   TO it, pair recorded, both provenances kept.
2. **Ids transfer seat-qualified and unrenumbered** (§4.3 as amended by A2;
   grandfathered ranges per A2's own table). The `LC-`/`LD-` → `L-` pairing is
   recorded at §4 of this artifact.
3. **Tier routing**: `LH2-g` candidates are the shell-LESSONS payload. `LH2-d`
   (domain) candidates do not enter the generic LESSONS body; they are listed
   in the transit PR under a separate domain heading for the shell to home per
   its own conventions (A1's tier 2; the shell side stays the shell's).
   Project-tier statements never leave this repo.
4. **The hide test runs at transcription** (block §4; A2-D4's allocation), over
   every candidate that moves — with `OBSERVATION SO-O1`'s two named candidates
   (`LC-orchestrator-H1-2`, `LC-orchestrator-H1-8` — each carries a
   version-control tool noun under a stated LH2-g) tested explicitly and the
   result recorded either way.
5. **Provenance is a permalink per entry** (ADR-0018 §4.2): incident commit(s)
   in this repo plus the entry id, in the shell file's existing citation form.
6. **Extraction before judgement**: each note's candidate table is extracted
   verbatim to a working file, byte-checked against `git show <landed-sha>:`
   at the source, and counted, before any merge decision is taken. Extraction
   instruments may be delegated; every merge decision, tier routing, hide-test
   verdict and the final assembly are the collator's own, and the collator
   verifies extraction fidelity against the source before use.
7. **One shell commit** (A2-D5). Several harvests at one gate would be several
   commits; this PR carries exactly this harvest's one.

## 3. The collation — executed

1. **Extraction** (§2.6): seven parallel instrument passes, one per chain, each
   byte-verifying its own output against `git show <landed-sha>:` at the
   source; then the collator's independent check — fourteen statements sampled
   across all seven seats, each verified against the source directly:
   **14 of 14 identical**. Measured counts matched every note's stated count
   (353 total: dv 94+1, architect 94, auditor 54, rtl 50, tb_writer 28,
   orchestrator 18, data_wrangler 14).
2. **Cross-seat merge walk**: TF-IDF similarity over all cross-seat pairs,
   calibrated on the top 25 — every top pair thematically adjacent, none
   stating the same rule. **Zero cross-seat merges** beyond the seats' own
   in-note routing (dv §4.7, auditor M8, tb `SELFWALK-28`). The proposal list
   is `clusters_proposed.md`/`pairs.json` in the session scratchpad (ephemeral,
   ADR-0003/F5 — stated as such).
3. **Seeded-corpus merge walk**: provenance-intersection sweep (candidate LH1
   entry-ids × seeded `L-` provenance ids; 28 collisions, all auditor-seat)
   plus a rule-text similarity sweep of all 353 against the 44 seeded rule
   statements (16 pairs above threshold). Judged one by one: **four true
   merges** — `ADL-45`→`L-B15`, `rtl H1-8`→`L-D03`, `AUD-14`→`L-C15`,
   `AUD-10`→`L-E06`; in each the seeded statement survives (A2-D8) and the
   candidate's provenance joins it. Everything else: shared incidents or
   adjacent themes, distinct rules — transits as new.
4. **Hide test** (§2.4): mechanical project-noun scan over all 353 —
   **zero hits**; the tier-1 gradings hold at transcription. Twenty
   version-control-noun flags: eighteen false positives ("branch" as control
   flow, "commit" as the protocol act — vocabulary the seeded general corpus
   itself uses); the two real ones are exactly `OBSERVATION SO-O1`'s
   (`LC-orchestrator-H1-2`, `-8`). **Disposition, recorded as bound at
   J-orchestrator-0236**: both transit as general — the shell's operating
   substrate is git-native and its seeded general lessons already carry the
   vocabulary (L-A01, L-B03); grades stay the miner's as minted; A1.4's
   later-harvest regrade stays available; the sponsor can refuse either on
   the PR. dv's `LD-SO-xgmii_rx_64-1` keeps its miner's domain grade, marked
   domain-tier in the transit file, outside the general body.
5. **War stories do not transit** — refused candidates are not admissible
   (§4.2 transits admissible candidates); ADR-0018 §3.5 keeps them local and
   re-offerable. Counts recorded in the transit file header.
6. **Source anomalies preserved, not repaired** — each disclosed by extraction
   and carried into the transit file's anomaly register verbatim (architect's
   62-vs-94 self-contradiction; rtl's 12-vs-11 war-story accounting and stale
   section pointer; tb's `SELFWALK-28` bank-row-vs-prose tension; auditor's
   `-AUD-52`/`-AUD-33` provenance-placement quirks; dv's dup-label markers on
   61/64).

## 4. `LC-`/`LD-` → `L-` pairs

**Deterministic rule** (renumbers nothing): `L-H1-<TAG>-<n>` where TAG ∈
{DV, ADL, AUD, RTL, TBW, ORCH, DW} and `<n>` is the candidate's own number —
e.g. `LC-SO-xgmii_rx_64-7` ⇄ `L-H1-DV-7`, `LC-orchestrator-H1-5` ⇄
`L-H1-ORCH-5`, `LC-tb_writer-SELFWALK-12` ⇄ `L-H1-TBW-12`.

**Exceptions, exhaustively**:

| candidate | pairs to | why |
|---|---|---|
| `LC-SO-xgmii_rx_64-ADL-45` | seeded `L-B15` | merge (§3.3) |
| `LC-rtl_lead-H1-8` | seeded `L-D03` | merge (§3.3) |
| `LC-SO-xgmii_rx_64-AUD-14` | seeded `L-C15` | merge (§3.3) |
| `LC-SO-xgmii_rx_64-AUD-10` | seeded `L-E06` | merge (§3.3) |
| `LD-SO-xgmii_rx_64-1` | `L-H1-DV-D1` | domain tier (pack `version-control`) |

The full 353-row pairing is enumerable from the rule plus this table.

**Superseded in part by the shell's own landing law (2026-08-11, correction
appended, not rewritten).** FETCH FIRST caught the shell 31 commits ahead of
the census-time fetch: it now carries FEDERATION.md, an inbox perimeter, and a
landing pipeline under which **final ids are allocated at the landing fence**
(FEDERATION §4, §8.1 step 4 — thematic-section numbering, not a per-harvest
scheme), and the maintainer returns the id-mapping table when the PR closes.
The `L-H1-` scheme above is therefore demoted to this repo's **local
provisional index** — it appears in no shell-bound artifact; the export packet
carries `LC-`/`LD-` ids only. The four seeded merges and the `LD-` row stand
as this collation's redundancy/tier pre-judgments, which the fence's screens
re-run independently.

## 5-pre. Conformance to the shell's landing law (discovered at transit time)

The shell's law reshaped the delivery, and the reshape is recorded here:

- **Form** (FEDERATION §6): export packet — header (source org, parent record,
  date), tier-1 table under `LC-` ids, tier-2 row under its `LD-` id with
  target pack named, war-story appendix. Committed in THIS repo at the fixed
  path `docs/federation/outbox/SO-xgmii_rx_64.md` (§6's one-convention rule).
- **Citations** (shell ADR-0017 A1): a citation base binds every bare SHA and
  entry id to this repository's URL; section headers carry permalinks at the
  notes' landed SHAs.
- **Self-containment** (§9): stated honestly per section — 216 rows carry
  per-row LH3 text; 137 rows (dv, tb_writer, data_wrangler) discharge at the
  cited entry and the packet says so rather than papering over it; the fence
  may bounce those rows individually.
- **Delivery** (§7, inbox README): ONE PR adding exactly ONE file at
  `agentic-fpga-nic-SO-xgmii_rx_64.md` under the shell's federation-inbox
  directory; the PR touches
  nothing else; it is a delivery vehicle, never a merge candidate — the
  maintainer stages, screens (four screens per candidate), transcribes, and
  merges by hand (§8's canonical-fence clause; §10 gives the origin program no
  privileged lane).
- **Transmission authority**: an `SO-` defers its outer hop to the next
  sponsor-signed gate by default (§7). Authority here is the sponsor's own
  standing in-session direction for this specific first harvest ("on a PASS:
  the harvest transit — as inbox PR"), stated in the packet header — not a
  default acted on.
- **The earlier plan's shell-side file** (a `LESSONS-H1-` companion file plus a
  pointer edit to the shell's LESSONS file) is **withdrawn unsent** — the
  perimeter rejects any PR
  touching outside the inbox directory, and transcription into LESSONS is the
  maintainer's act, not the contributor's.

## 5. The shell delivery — executed 2026-08-11

- **PR**: <https://github.com/renatom11/generic-agentic-fpga-org/pull/3> — one
  PR, one file — `agentic-fpga-nic-SO-xgmii_rx_64.md` in the shell's
  federation-inbox directory,
  <https://github.com/renatom11/generic-agentic-fpga-org/blob/inbox/agentic-fpga-nic-SO-xgmii_rx_64/docs/federation/inbox/agentic-fpga-nic-SO-xgmii_rx_64.md> —
  byte-identical to this repo's `docs/federation/outbox/SO-xgmii_rx_64.md`
  (7fb2c99); branch `inbox/agentic-fpga-nic-SO-xgmii_rx_64` from shell main
  `2ad82c3`; nothing outside the perimeter touched.
- **What this PR is not**: a merge candidate. Its commit carries no shell
  journal entry by design; the maintainer stages, screens, transcribes with
  fence-allocated final ids, merges the staging branch by hand, and closes
  the PR with the landing commits and the id-mapping table (FEDERATION §8.1).
  When that mapping arrives, it supersedes §4's local provisional index and
  is recorded beside this section by an appended note.
- **The one-commit rule**: this repo's side of the harvest transit is the
  packet's outbox commit; the shell's side is whatever protocol-conforming
  commits its maintainer lands — counted at the shell, per its own law.

## 6. Disposition under ADR-0023 (2026-08-17, appended, not rewritten)

**The mechanism this packet executed was retracted before any landing.** The
sponsor's direction of 2026-08-17 — executed in the shell as its ADR-0018
(the federation retraction, shell main `cb8a9f3`: the inbox perimeter and
FEDERATION law this packet §5-pre conformed to are deleted) and mirrored in
this program as ADR-0023 — retires the transit as a class. Dispositions:

- **EXECUTED stands as history.** Everything above is true of what happened.
- **PR #3 is closed unlanded by the shell's maintainer**, citing the shell's
  ADR-0018. The maintainer's id-mapping table §5 anticipated will never
  arrive; §4's local provisional index is a local index, and local is now the
  only kind there is.
- **The 353 candidates landed locally** as the first landing in this
  repository's own `docs/LESSONS.md` — the travel copy — seeded verbatim from
  the frozen outbox packet (`docs/federation/outbox/SO-xgmii_rx_64.md`,
  7fb2c99), A2-D8's no-statement-edited bar applied unchanged. The four
  shell-corpus merge pre-judgments (§3.3) and the `LD-` domain row travel as
  recorded annotations; the merge partners live in another repository this
  program does not inherit from, so the judgments are preserved, not
  executed.
- **The outbox file stays frozen in place** as the record of the one delivery
  ever performed; no `HT-02` will exist.

Authority: ADR-0023 (sponsor-directed), acceptance `J-orchestrator-0305`
(0fe5f8c); this note `J-orchestrator-0306`.
