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
| A | M01 `Axi64`, M02 `Crc32_eth` | 22145b5 (WO-0006), revised f78766e | run 30729342467 green | **SIGNED** (J-dv_lead-0003; §4.1 addition accepted J-dv_lead-0005) | **FROZEN at f78766e** |
| B | M03, M04, M05 | f78766e (WO-0008) | run 30729342467 green | **SIGNED** (J-dv_lead-0005) | **FROZEN at f78766e** |
| C | M06, M07, M08, M09 | 508eea2 (WO-0011) | run 30733153172 green | **SIGNED** (J-dv_lead-0007) | **FROZEN at 508eea2** |
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

## Dual-batch countersignature (transcribed)

> "I countersign batches A and B (SPEC-M01, SPEC-M02, SPEC-M03,
> SPEC-M04, SPEC-M05) for P1-spec-freeze at f78766e." — dv_lead, journal
> `J-dv_lead-0005` (WO-0010), transcribed by the orchestrator 2026-08-02.
> All five verdict groups positive; the C-1 acceptance SEALS the
> sponsor's delegated latency-budget decision (board, 2026-08-02) —
> ΔC = (L + h)/8 normative, allocation 4/3/1/5/4 = 17 of 24, slack 7.

## Carry-forward ledger (WO-0005 + WO-0007 + WO-0010)

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
| C-11 | REQ-015 self-contradicts at the one-word frame — DISPOSED in WO-0010 (deletion + counting-convention clause, replacement text in the packet); diff lands in batch C | batch-C return |
| C-12 | `/E/` during REQ-108 Discard — §9 row 2's condition reads true after frame closure; dv ruling supplied in WO-0010 | before AP-xgmii_rx_64 (batch-C return) |
| C-13 | REQ-010's "exactly one non-stream frame-carrying port" census false since the Xgmii record added six; the row's own spec-diff clause unhonoured | batch-C return |
| C-14 | Five readings that alone commission assertions failing conformant designs (sharpest: SPEC-M04 §7 tx_tready-during-gap vs its own §6.1 and REQ-209) | batch-C return |
| — | dv machinery defect (self-found): Latency.create's single strip_octets conflates two quantities diverging at M03 lane-4 (ΔC misreport 2 vs 3) | dv's next WO, before any M03 bench |

| C-16 | SPEC-M04 §7 tx_tready bullet correct but incomplete — the omitted C+8 cycle is the one the composed 11-cycle cadence turns on | before M04/M07 tb_writer WO (batch-D return) |
| C-17 | Five batch-C readings/coverage claims (M06 inequality inversion; M07 drain W−J+1; M08 §6.3 same-cycle-header; ADR-0008 valid-drop monitor rule; M06 §8 needs 22) | batch-D return |
| C-18 | C-14.4 repair's example covers four frame octets — read literally, amended §6.2 Frame row fails every lane-4 FCS | before AP-xgmii_rx_64 (batch-D return) |

Status marks: C-1 SEALED (WO-0010); C-4, C-8, C-10 CLOSED (WO-0008,
confirmed WO-0010); C-9 partially closed (scripts live + CI-wired;
REQ-903 half unblocks now that C-8 is closed).

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
