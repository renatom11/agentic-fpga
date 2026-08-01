# Program Board

**Live program state.** The orchestrator updates this file in the same commit
as any state change it describes. A fresh orchestrator session rehydrates by
reading: this board → `agents/PROTOCOL.md` → `ORG_CHART.md` → journal tails of
agents with open work.

## Current milestone

**M0 — Org & charter** (awaiting sponsor + audit re-verification).
Org ratified (item 8). The auditor's first audit (AUD-0001) returned
1 CRITICAL / 6 MAJOR / 6 MINOR / 4 NOTE against orchestrator work; all
accepted and dispositioned in ADR-0003. Enforcement hardened to 26 scenarios
with reason-asserting rejection tests and full-history CI re-checking.
**G0 remains BLOCKED** until the auditor re-verifies F17 and the MAJOR fixes.
Exit: item 9 (sponsor, branch protection) + audit re-verification.

## Milestone roadmap

| Milestone | Scope | Status |
|---|---|---|
| M0 | Org, charters, protocol, enforcement, CI journal-check | **Awaiting sponsor (items 8–10)** |
| M1 | Toolchain-lane ADR, dune/opam skeleton, OCaml CI, REQ-### requirements, top-level architecture spec, P1-spec-freeze gate | Pending |
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
| [WO-0001](../agents/handoffs/WO-0001_g0-retro-audit.md) | orchestrator → auditor | RETURNED | G0 retro-audit delivered ([AUD-0001](../docs/reports/audit/AUD-0001-g0-retro.md)); findings dispositioned in ADR-0003; re-verification pending |

## Pending escalations to sponsor

- **E1/G0 item 9**: branch protection on `main` AND the working branch —
  exact click-path in `docs/gates/G0-checklist.md`. Sponsor chose to make the
  repository public (2026-08-01) because GitHub does not enforce rulesets on
  private repos without a paid plan; rulesets bite once visibility flips.
  (Item 8 ratified; item 10 delivered PASS WITH FINDINGS.)

## Decisions on record

- 2026-08-01 — Sponsor selected: phased NIC→feed-handler project,
  simulation-first target, M0 = org+charter only, direct-commit git flow
  (recorded in `docs/adr/ADR-0001-org-design.md`).
- 2026-08-01 — Sponsor ratified the org (G0 item 8) and set org-evolution
  policy: the current structure is the best first guess, not a commitment —
  roles may be added or reshaped as the program learns, via the existing
  E2 + ADR + journal-seed mechanism. Deferred intent on record: at program
  end, extract the generic (project-agnostic) workflow from this org using
  accumulated ADRs/journals as the lessons-learned source.
