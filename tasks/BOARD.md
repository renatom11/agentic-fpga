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

Open M1 work (post WO-0002 acceptance): add `hardcaml_axi` to the opam
deps + dune wiring and prove it installs in CI (blocking spec batch A);
`docs/specs/ifc_check/` dune wiring for Interface compile evidence
(blocking batch A freeze); spec batching DECIDED 2026-08-02: the
architect's six ordered batches stand as six WOs (sizing accepted as
proposed); dv_lead testability review in flight
(WO-0003); README phase-table pointer follow-up; sponsor confirmation of the
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

## Open work orders

| Packet | From → To | State | Note |
|---|---|---|---|
| [WO-0003](../agents/handoffs/WO-0003_requirements-testability-review.md) | orchestrator → dv_lead | ISSUED | Testability review of all 108 REQs at 08899d3 + REQ-004/005 bench feasibility note (dv_lead's first activation) |
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
- 2026-08-01 — Sponsor ratified the org (G0 item 8) and set org-evolution
  policy: the current structure is the best first guess, not a commitment —
  roles may be added or reshaped as the program learns, via the existing
  E2 + ADR + journal-seed mechanism. Deferred intent on record: at program
  end, extract the generic (project-agnostic) workflow from this org using
  accumulated ADRs/journals as the lessons-learned source.
