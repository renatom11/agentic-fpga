# Gate: P1-spec-freeze

Closes when all twenty Phase-1 module specifications are FROZEN and the
sponsor signs. A spec is FROZEN only with (a) a green `ifc_check` CI run
citing the freeze SHA and (b) a dv_lead testability countersignature for
that spec (charter §5/§6, PROTOCOL §7). Signatures below are transcribed
by the orchestrator from the signing agent's journal entry, per PROTOCOL
§7's transcription rule.

## Prerequisites (architecture.md §7) — all satisfied

| # | Item | Evidence |
|---|---|---|
| 7.1 | `hardcaml_axi` in opam deps and the ethernet lib's dune | opam: build run 30724505231 (98e1607) green; lib dune entry: build run 30726680676 (1f541a9) green |
| 7.2 | `docs/specs/ifc_check/` dune wiring | Same run 30724505231 — template block compiles |
| 7.3 | dv_lead testability review before this checklist opened | WO-0003 → 16 diffs → WO-0004 applied → WO-0005 re-review CLOSED 16/16 |

## Requirements testability countersignature

> "I sign the P1-spec-freeze testability precondition at b4b4cf4."
> — dv_lead, journal `J-dv_lead-0002` (WO-0005), transcribed by the
> orchestrator 2026-08-02.

## Per-batch freeze record

| Batch | Specs | Drafted | ifc_check run | dv countersign | FROZEN at |
|---|---|---|---|---|---|
| A | M01 `Axi64`, M02 `Crc32_eth` | 22145b5 (WO-0006) | run 30727252770 superseded by f78766e edit — fresh run pending | **SIGNED** (J-dv_lead-0003); §4.1 addition awaits WO-0010 judgment | flips with batch B at WO-0010 |
| B | M03, M04, M05 | f78766e (WO-0008) | run 30729342467 green | WO-0010 in flight | — |
| C | M06, M07, M08, M09 | — | — | — | — |
| D | M10, M11, M12, M13 | — | — | — | — |
| E | M14, M15, M16 | — | — | — | — |
| F | M17, M18, M19, M20 | — | — | — | — |

## Batch-A countersignature (transcribed)

> "I countersign batch A (SPEC-M01, SPEC-M02) for P1-spec-freeze at
> 22145b5." — dv_lead, journal `J-dv_lead-0003` (WO-0007), transcribed by
> the orchestrator 2026-08-02. FROZEN flip deferred: SPEC-TEMPLATE §11
> forbids open questions in a FROZEN spec and both specs carry four;
> reconciliation is WO-0008's first deliverable, and the flip happens at
> its acceptance.

## Carry-forward ledger (WO-0005 + WO-0007, none blocking signatures)

| id | Item | Must land before |
|---|---|---|
| C-1 | §1.1 ceiling comparison unit: compare (L + h)/8, not floor(L/8) — else the ceilings chain consumes the whole 24-cycle budget with no slack | SPEC-M03 (batch B) |
| C-2 | Conservation counts discarded frames, not strobe pulses (one frame may pulse two strobes); add `clear`/receive-enable exemptions | first `SO-` packet |
| C-3 | Zero-payload datagram has no accounting observable at `nic_top` | top-level stress bench |
| C-4 | REQ-105/110 wording: `tuser`[0]-on-`tlast` cases with zero delivered octets | SPEC-M03 (batch B) |
| C-5 | `error_underflow` window bound vacuous (editorial) | any |
| C-6 | M10 pass criteria (parsed-fields module under the REQ-004 bench) | SPEC-M10 (batch D) |
| C-7 | Fifth REQ-901 divergence class for REQ-510's reply drop | first co-sim run |
| C-8 | REQ-903 quantifies over the whole inventory with no types-only exclusion; its `.mli` half unaddressed by SPEC-M01 | batch-B countersign |
| C-9 | §10's REQ-802/804 hooks name a compile check that cannot read a markdown table — dv-owned `tools/` record-vs-appendix scripts (WO-0009) | batch-B countersign |
| C-10 | SPEC-M01 §6.1 drops REQ-013's "solely" | §11 reconciliation (WO-0008) |
| C-11 | REQ-015 self-contradicts at the one-word frame (dv_lead's own WO-0003 wording, found by dv_lead in WO-0009) | WO-0010 contest loop or next spec-diff round |

## Sponsor items attached to this gate — both decided 2026-08-02

- **Receive-latency budget (REQ-006 / C-1): DELEGATED.** The sponsor
  entrusts resolution to architect_docs_lead working with dv_lead. The
  joint resolution lands with carry-forward C-1 (before SPEC-M03, batch
  B): the architect adopts dv_lead's (L + h)/8 comparison or
  counter-proposes, and dv_lead's batch-B countersignature seals the
  agreed budget/accounting. Whatever number and method they converge on
  is thereby sponsor-authorized without a further touchpoint.
- **UDP checksum posture (tx zero, no rx verification): CONFIRMED** by
  the sponsor as a design call, not a scope reduction. No E2.

## Sign-off

- [ ] All six batches FROZEN (table complete)
- [ ] Sponsor signature
