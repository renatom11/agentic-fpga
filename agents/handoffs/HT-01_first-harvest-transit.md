# HT-01 — The first harvest transit (collation record)

- **State**: OPEN — census and method fixed; collation in progress
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
   (`docs/LESSONS.md`, 44 entries `L-A01 … L-F08` at the shell's seeding pin) is
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

## 3. The collation

OPEN — built seat by seat under §2. Nothing below §2 is citable until this
artifact's State says so.

## 4. `LC-`/`LD-` → `L-` pairs

OPEN — recorded as §3 closes each seat.

## 5. The shell commit

OPEN — recorded when the inbox PR exists (repo, branch, PR number, one commit
SHA).
