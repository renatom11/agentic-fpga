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
| P1-spec-freeze | OPEN — prerequisites done, batches A–F pending | [docs/gates/P1-spec-freeze-checklist.md](../docs/gates/P1-spec-freeze-checklist.md) |

## Open work orders

| Packet | From → To | State | Note |
|---|---|---|---|
| [WO-0006](../agents/handoffs/WO-0006_batch-a-specs.md) | orchestrator → architect_docs_lead | ISSUED | Batch A per-module specs: SPEC-M01 `Axi64`, SPEC-M02 `Crc32_eth` + their ifc_check lifts |
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
