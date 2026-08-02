# Program Board

**Live program state.** The orchestrator updates this file in the same commit
as any state change it describes. A fresh orchestrator session rehydrates by
reading: this board → `agents/PROTOCOL.md` → `ORG_CHART.md` → journal tails of
agents with open work.

## Current milestone

**M1 — Toolchain & first specs.** **G0 PASSED 2026-08-01**:
all 11 checklist items signed; the auditor's re-verification (AUD-0002) lifted
the CRITICAL block and signed item 11. M0 closed with the full audit cycle
exercised end-to-end: audit → disposition ADR → adversarial re-verification.

**Build lane GREEN 2026-08-01** (run 30721584772 on c5011a3): the `build`
workflow passes end-to-end — Hardcaml v0.17 stack install, `dune build`,
expect tests (waveform snapshot promoted from CI diff), RTL emission, and
the staged-diff byte-determinism check. Toolchain is CI-authoritative per
ADR-0005 (container network blocks opam; local switches are convenience
only). Bring-up findings fixed en route: untracked files were invisible to
the old `git diff --exit-code` determinism check (now stages first), and a
top-level/hierarchical name collision made Rtl.output emit a
self-instantiating shell (wrapper renamed `word_counter_top`).

Open M1 work (post WO-0002 acceptance): batch-A blockers CLOSED
2026-08-02 — `hardcaml_axi` solves in CI and the `docs/specs/ifc_check/`
compile lane builds the template Interface block (build run 30724505231
on 98e1607, green); spec batching DECIDED 2026-08-02: the
architect's six ordered batches stand as six WOs (sizing accepted as
proposed); spec-diff loop CLOSED: WO-0004 16/16
applied, WO-0005 re-review 16/16 CLOSED and SIGNED at b4b4cf4; the
P1-spec-freeze checklist is OPEN (docs/gates/P1-spec-freeze-checklist.md,
prerequisites 7.1–7.3 all satisfied) with carry-forwards C-1…C-7 tracked
against their deadline gates; batch A (WO-0006) in flight; parked:
REQ-810 tready semantics for rtl_lead at M18/M20; rulings on record: emitted-Verilog
structural checks are dv-ownable tools (not RTL-derived tests);
hardcaml_step_testbench added to deps (CI validates); Cyclesim cost
probe approved for dv's bench-setup WO; README phase-table pointer follow-up; sponsor confirmation of the
24-cycle rx latency budget (architect's figure, REQ-005-adjacent);
then P1-spec-freeze gate. Deferred dispositions closed 2026-08-01: AUD-0002 N4
scenarios landed as S25–S27 (29 green); N1/N2 residuals closed per ADR-0003
Corrections.

## Milestone roadmap

| Milestone | Scope | Status |
|---|---|---|
| M0 | Org, charters, protocol, enforcement, CI journal-check | **Done — G0 PASSED 2026-08-01** |
| M1 | Toolchain-lane ADR, dune/opam skeleton, OCaml CI, REQ-### requirements, top-level architecture spec, P1-spec-freeze gate | **In progress** |
| M2 (Phase 1) | XGMII 64-bit 10G MAC (rx/tx, CRC-32, IFG) + ARP/IPv4/UDP stack; per-module DV; differential co-sim vs verilog-ethernet | Pending |
| M3 (Phase 2) | ITCH stimulus toolchain, MoldUDP64, ITCH 5.0 realignment parser, order book (1 symbol, ToB + 8 levels), full-day replay, latency histograms | Pending |
| M4 (stretch) | 10GBASE-R soft PCS (64b/66b + scrambler), wire-to-wire latency report | Pending |

## Gates

| Gate | Status | Checklist |
|---|---|---|
| G0 | **PASSED 2026-08-01** | [docs/gates/G0-checklist.md](../docs/gates/G0-checklist.md) |
| P1-spec-freeze | OPEN — **A–E FROZEN (16/20)**, F countersign withheld on one item (F-1 repair in flight, WO-0021) — then sponsor signature | [docs/gates/P1-spec-freeze-checklist.md](../docs/gates/P1-spec-freeze-checklist.md) |

## Open work orders

| Packet | From → To | State | Note |
|---|---|---|---|
| [WO-0016](../agents/handoffs/WO-0016_m01-m02-implementation.md) | orchestrator → rtl_lead | ACCEPTED | 189d5b2: **first RTL green on first elaboration** (run 30738000890) — M01 Axi64 (types, lift-identical) + M02 Crc32_eth (64-step prefix chain, ADR-0006/0007 honoured); 2 questions queued for architect (Axi64.Axi64 convention; named module type S) |
| [WO-0022](../agents/handoffs/WO-0022_batch-f-rereview.md) | orchestrator → dv_lead | ISSUED | **Bounded batch-F re-review** at d8df28d — on PASS the pre-worded sentence freezes ALL 20/20 |
| [WO-0021](../agents/handoffs/WO-0021_f1-repair.md) | orchestrator → architect_docs_lead | ACCEPTED | d8df28d: F-1 repaired (D = word-count deficit keys everything; conditional copy; §11.4 prices the REQ-007 clause and carries it — flip-invariant cost); C-31/C-34/C-35 landed; no lift touched |
| [WO-0020](../agents/handoffs/WO-0020_batch-f-countersign.md) | orchestrator → dv_lead | ACCEPTED | 14e8999: countersign **WITHHELD** — M18/M19/M20 SIGNED (REQ-006=13 confirmed 3 routes), M17 CONTESTED (F-1: tuser copy from unarrived word, ≤182 cycles early); ADR-0011+pricing endorsed; C-31…C-36 |
| [WO-0019](../agents/handoffs/WO-0019_batch-f-specs.md) | orchestrator → architect_docs_lead | ACCEPTED | aaa55b2: **20/20 specs exist** — batch F drafted (M20: REQ-006 closes at 13/24 cycles both lanes), D/E flipped FROZEN, C-24…C-30 landed, ADR-0010 (conventions — **batch-B RTL unblocked**) + ADR-0011, 119-edge table, README refreshed |
| [WO-0018](../agents/handoffs/WO-0018_batch-de-countersign.md) | orchestrator → dv_lead | ACCEPTED | a8347e0: **both countersigns GRANTED at 3f6accc — batches D+E FROZEN (16/20)**; five answers (REQ-502=7 accepted, gate both; subnet-mask edge accepted); C-19…23 reaffirmed; C-24…C-30 raised |
| [WO-0017](../agents/handoffs/WO-0017_batch-e-specs.md) | orchestrator → architect_docs_lead | ACCEPTED | 3f6accc: D-1→R-1 (Transmitting state), D-2→D-2a + **ADR-0009**; batch E drafted (M14 ΔC=4/ceil 5; M15 1+2 cycles; M16 structural); 118-edge table; REQ-502 6→7 disclosed |
| [WO-0015](../agents/handoffs/WO-0015_batch-d-countersign.md) | orchestrator → dv_lead | ACCEPTED | 619afa7: **countersign WITHHELD** — M10/M11/M12 SIGNED (M12 clean), M13 CONTESTED (D-1 two-replies vs REQ-510; D-2 bad-FCS learn undischarged); Q1–Q5 answered, Q3 NOT breaking; C-19…C-23 |
| [WO-0014](../agents/handoffs/WO-0014_batch-d-specs.md) | orchestrator → architect_docs_lead | ACCEPTED | a9993ff: SPEC-M10–M13 DRAFT (lifts byte-identical), C-6/15/16/17/18 CLOSED, batch-C freeze flip ratified, 117-edge table; countersign next after CI |
| [WO-0013](../agents/handoffs/WO-0013_batch-c-countersign.md) | orchestrator → dv_lead | ACCEPTED | **SIGNED at 508eea2 — batch C FROZEN (9/20)**; eight amendments reaffirmed; ADR-0008 accepted; new C-16/17/18 |
| [WO-0012](../agents/handoffs/WO-0012_dv-wave2.md) | orchestrator → dv_lead | ACCEPTED | a8a6c5e: tagger h-per-frame split (+2nd same-class defect fixed), XGMII link-partner model (emitter = total function of octet time), REQ-903 both halves; 24 snapshots await promotion |
| [WO-0011](../agents/handoffs/WO-0011_batch-c-specs.md) | orchestrator → architect_docs_lead | ACCEPTED | 508eea2: SPEC-M06–M09 DRAFT, C-11/12/13/14 all applied (8 §13 records, none breaking), ADR-0008, 116-edge connection table; countersign next after CI |
| [WO-0010](../agents/handoffs/WO-0010_dual-batch-countersign.md) | orchestrator → dv_lead | ACCEPTED | **SIGNED at f78766e — batches A+B FROZEN** (5/20 specs). C-1 sealed (sponsor delegation closed). Three new ledger items C-12/13/14; dv self-found tagger defect |
| [WO-0009](../agents/handoffs/WO-0009_bench-machinery.md) | orchestrator → dv_lead | ACCEPTED | Returned + accepted at 576abe6: CRC oracle (11/11 mutation kills), protocol/conservation monitors, octet-time tagger (D-4 walk now an executable regression), cost probe, tools checks; 30 snapshots await CI promotion |
| [WO-0008](../agents/handoffs/WO-0008_batch-b-specs.md) | orchestrator → architect_docs_lead | ACCEPTED | Returned + accepted at f78766e: M03/M04/M05 DRAFT, §11 reconciled, C-1 resolved (unit change, slack restored), ADR-0006/0007, backlog diffs; batch A+B freeze together at WO-0010 |
| [WO-0007](../agents/handoffs/WO-0007_batch-a-countersign.md) | orchestrator → dv_lead | ACCEPTED | **SIGNED at 22145b5** (CRC verified via independent bit-serial implementation; 21/21 strobes exact). FROZEN flip pending §11 reconciliation; new ledger items C-8/C-9/C-10 |
| [WO-0006](../agents/handoffs/WO-0006_batch-a-specs.md) | orchestrator → architect_docs_lead | ACCEPTED | Returned + accepted at 22145b5: SPEC-M01/M02 DRAFT, lifts byte-identical, 21 strobes; ifc_check CI run pending → then dv countersign (WO-0007) freezes batch A |
| [WO-0005](../agents/handoffs/WO-0005_spec-diff-re-review.md) | orchestrator → dv_lead | ACCEPTED | 16/16 CLOSED; testability precondition **SIGNED at b4b4cf4** (J-dv_lead-0002); 7 carry-forwards C-1…C-7 tracked on the gate checklist |
| [WO-0004](../agents/handoffs/WO-0004_requirements-spec-diffs.md) | orchestrator → architect_docs_lead | ACCEPTED | Returned + accepted at b4b4cf4: 16/16 applied (D-4 metric corrected to octet times), one IFG convention at all sites, 108→110 REQs, set equality re-verified |
| [WO-0003](../agents/handoffs/WO-0003_requirements-testability-review.md) | orchestrator → dv_lead | ACCEPTED | Returned + accepted at 9a6195a: 108/108 dispositioned (55 T / 49 A / 4 U), 16 consolidated spec diffs, countersignature withheld pending diffs; REQ-004 stress feasible in Cyclesim |
| [WO-0002](../agents/handoffs/WO-0002_p1-requirements-architecture.md) | orchestrator → architect_docs_lead | ACCEPTED | Returned + accepted at 08899d3: 108 REQs, 20-module inventory (M01–M20), spec template, traceability skeleton. Spawn #1 killed by interruption (incident in Return log); spawn #2 delivered. |
| [WO-0001](../agents/handoffs/WO-0001_g0-retro-audit.md) | orchestrator → auditor | ACCEPTED | Full cycle complete: [AUD-0001](../docs/reports/audit/AUD-0001-g0-retro.md) → ADR-0003 → [AUD-0002](../docs/reports/audit/AUD-0002-g0-reverification.md) re-verification (F17 CLOSED, gate lifted) |

## Pending escalations to sponsor

_None pending. E3 toolchain lane decided 2026-08-01: released Hardcaml
v0.17.x from opam (ADR-0004). Next sponsor touchpoint: P1-spec-freeze._

## Decisions on record

- 2026-08-01 — Sponsor selected: phased NIC→feed-handler project,
  simulation-first target, M0 = org+charter only, direct-commit git flow
  (recorded in `docs/adr/ADR-0001-org-design.md`).
- 2026-08-01 — E3: toolchain lane = released Hardcaml v0.17.x from opam
  (ADR-0004); master-pin and OxCaml rejected; API gaps trigger a new E3.
- 2026-08-02 — Sponsor delegated the receive-latency budget resolution
  (REQ-006/C-1) to architect_docs_lead + dv_lead jointly (seals at the
  batch-B countersignature), and confirmed the UDP checksum posture
  (tx zero, no rx verification) as a design call, not an E2.
- 2026-08-01 — Sponsor ratified the org (G0 item 8) and set org-evolution
  policy: the current structure is the best first guess, not a commitment —
  roles may be added or reshaped as the program learns, via the existing
  E2 + ADR + journal-seed mechanism. Deferred intent on record: at program
  end, extract the generic (project-agnostic) workflow from this org using
  accumulated ADRs/journals as the lessons-learned source.
