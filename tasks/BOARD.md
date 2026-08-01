# Program Board

**Live program state.** The orchestrator updates this file in the same commit
as any state change it describes. A fresh orchestrator session rehydrates by
reading: this board → `agents/PROTOCOL.md` → `ORG_CHART.md` → journal tails of
agents with open work.

## Current milestone

**M1 — Toolchain & first specs** (just opened). **G0 PASSED 2026-08-01**:
all 11 checklist items signed; the auditor's re-verification (AUD-0002) lifted
the CRITICAL block and signed item 11. M0 closed with the full audit cycle
exercised end-to-end: audit → disposition ADR → adversarial re-verification.
Open M1 work: E3 toolchain-lane escalation (with sponsor), dune/opam skeleton,
architect activation (REQ-### requirements + top-level architecture spec),
P1-spec-freeze gate. Deferred dispositions due before P1-spec-freeze:
AUD-0002 N4 scenarios (auditor/handoffs denial; trailer final-block parse),
N1/N2 residuals closed per ADR-0003 Corrections.

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
| G0 | Open | [docs/gates/G0-checklist.md](../docs/gates/G0-checklist.md) |

## Open work orders

| Packet | From → To | State | Note |
|---|---|---|---|
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
