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
| D | M10, M11, M12, M13 | a9993ff (WO-0014); D-1/D-2 repaired 3f6accc (WO-0017: R-1 + D-2a/ADR-0009) | runs 30736107842 (2f29888) + 30739442056 (3f6accc) green | **SIGNED** (J-dv_lead-0009, WO-0018 re-review after J-dv_lead-0008 withheld) | **FROZEN at 3f6accc** |
| E | M14 `Ip_eth_rx_64`, M15 `Ip_eth_tx_64`, M16 `Ip_complete_64` | 3f6accc (WO-0017) | run 30739442056 green (head SHA = spec commit; no witnessing owed) | **SIGNED** (J-dv_lead-0009) | **FROZEN at 3f6accc** |
| F | M17 `Udp_ip_rx_64`, M18 `Udp_ip_tx_64`, M19 `Udp_complete_64`, M20 `Nic_top` | aaa55b2 (WO-0019) | run 30742781586 green (head SHA = spec commit) | **WITHHELD** (J-dv_lead-0010, WO-0020) — M18/M19/M20 SIGNED, M17 CONTESTED (F-1); repair in flight (WO-0021) | — |

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

## Carry-forward ledger (WO-0005 + WO-0007 + WO-0010 + WO-0013 + WO-0015)

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

| C-15 | requirements.md §0.5 constancy definition carries its start-lane exception seventy lines away — a monitor built from the unqualified sentence fails a conformant M03 (dv's clause supplied in the WO-0012 Return log; row transcribed late, at closure) | batch-D return |
| C-16 | SPEC-M04 §7 tx_tready bullet correct but incomplete — the omitted C+8 cycle is the one the composed 11-cycle cadence turns on | before M04/M07 tb_writer WO (batch-D return) |
| C-17 | Five batch-C readings/coverage claims (M06 inequality inversion; M07 drain W−J+1; M08 §6.3 same-cycle-header; ADR-0008 valid-drop monitor rule; M06 §8 needs 22) | batch-D return |
| C-18 | C-14.4 repair's example covers four frame octets — read literally, amended §6.2 Frame row fails every lane-4 FCS | before AP-xgmii_rx_64 (batch-D return) |
| C-19 | SPEC-M11 §8 item 2's M10 loopback is a zero-lead producer as written — M10 would take word 1 as word 0 and pulse `error_arp_unsupported`; repair: loopback presents `hdr_valid` one cycle before payload word 0 | AP-arp_eth_tx.md and the M11 tb_writer WO |
| C-20 | SPEC-M10 §6.3 item 4's word-0 constant wrong under both its own readings (correct value 0x0406_0008_0100; full word 0 = 0x0100_0406_0008_0100); M11 §6.1's table is right, M10 §6.1's governing table is right | AP-arp_eth_rx.md and the M10 tb_writer WO |
| C-21 | SPEC-M10 §6.1's report XOR does not except the `clear` abandonment §7 mandates; C-2's conservation exemption becomes load-bearing for the first time here | C-2's gate (first SO- packet); the §6.1 clause before AP-arp_eth_rx.md |
| C-22 | ADR-0008's C-17(d) bullet vs SPEC-M11 §6.1: monitor-prohibition precedence unstated (dv's own repair carried the defect, self-reported); one clause on the ADR bullet resolves | first transmit-side tb_writer WO (M07/M09/M11) |
| C-23 | M13's strobes can be high on consecutive cycles; §0.6's one-cycle pulse rule needs the counting convention (high cycles, not edges); + editorial: REQ-502's measurement-start ambiguity (cycle 8 vs 9) | before AP-arp.md; REQ-502 half before any latency artifact quotes it |
| C-24 | REQ-502's derived figure is 7 or 8 cycles by input-length residue (gap 3 for N ≡ 0,1,2 mod 8, else 4), while SPEC-M13 §6.1/§7 assert one constant — C-1's class (octet time divided without residue); no committed hook asserts 7, so carried not contested | AP-arp.md REQ-502 rows; before any docs/reports/latency/ artifact quotes it |
| C-25 | SPEC-M13's "later of" branch stated for one payload length where it holds for five (28–32); frame priced at 42 octets vs §0.3's 46–50; no §6.2 (D) stage holds tuser[0] in branch (1) — observable well-defined, stage model not | AP-arp.md and the M13 tb_writer WO |
| C-26 | SPEC-M14 §9 truncation row: temporal branch condition vs extensional case list disagree over 21–27 delivered octets; REQ-605 settles it (extensional reading); + the exactly-20-octets ip_hdr_valid undecided case | AP-ip_eth_rx_64.md and the M14 rtl_lead WO |
| C-27 | SPEC-M14 §7's REQ-611 parse constant is gap-sensitive (idle inside the header moves only the output event) while REQ-611 claims gap-invariance; a REQ-611+REQ-016 bench fails a conformant M14 under idle injection | the M14 tb_writer WO and AP-ip_eth_rx_64.md |
| C-28 | REQ-505's two-half split does not tile on M13's side (header claims REQ-505 unqualified; §10 row lacks half/disclaimer; §8 item 1 commissions an observable at M15's port) — double-claim at sign-off; batch-D text outside the re-review surface, does NOT reopen the countersignature | first SO- packet claiming REQ-505; AP-arp.md |
| C-29 | SPEC-M16 §7's transmit anchor off by one event: tx is 1 cycle after M15 emits body word 0 (2 after acceptance), not 2 after emission — a §7-built monitor asserts 2, observes 1 | the M16 bench WO; any transmit-chain latency monitor |
| C-30 | SPEC-M14 §8 criterion 1 lacks the clear conservation exemption C-21 just landed at M10 §8, while §10's REQ-009 hook commissions the mid-datagram clear test — C-2 load-bearing at its second module | C-2's gate (first SO- packet); the §8 sentence before AP-ip_eth_rx_64.md |

Status marks: C-1 SEALED (WO-0010); C-4, C-8, C-10 CLOSED (WO-0008,
confirmed WO-0010); C-9 partially closed (scripts live + CI-wired;
REQ-903 half unblocks now that C-8 is closed); **C-19, C-20, C-21,
C-22, C-23 CLOSED (WO-0017 at 3f6accc, all five REAFFIRMED at the
WO-0018 re-review; C-22 additionally discharged at its first new
instance)**; **C-24…C-30 CLOSED (WO-0019 at aaa55b2, each a
§13-recorded diff on frozen text touching no §4.1 lift — verified at
acceptance; pending dv reaffirmation at the WO-0020 countersign)** — C-23 homed in requirements.md §0.6 (generalises)
+ REQ-502 disambiguation; note REQ-502's derivation moved 6→7 under
D-2a, dv re-review question 1; **C-6, C-15, C-16, C-17
(all five items), C-18 CLOSED (WO-0014 at a9993ff)** — dispositions
transcribed from the architect's Return log: C-6 closes in SPEC-M10 §8
(parsed-fields form of REQ-004's four criteria); C-15 applies dv's
clause verbatim in requirements.md §0.5; C-16 pins tx_tready = 1 at C+8;
C-17(b) landed in five places not three, C-17(d) in ADR-0008 not
SPEC-M07; C-18's twin sentence in SPEC-M03 §3 moved in the same diff.
Each carries a §13 record; no frozen §4.1 lift changed, so runs
30729342467 and 30733153172 still witness every frozen interface.

## Batch-D countersignature (WITHHELD — transcribed)

> "The batch-D countersignature is WITHHELD at a9993ff." — dv_lead,
> journal `J-dv_lead-0008` (WO-0015), transcribed by the orchestrator
> 2026-08-02. SPEC-M10, SPEC-M11, SPEC-M12 **SIGNED** (M12 clean, no
> findings of any class); SPEC-M13 **CONTESTED** on two blocking items:
> **D-1** (the ARP module retains two replies where REQ-510's normative
> sentence says one — three verification hooks across two documents
> commission a strobe a conformant design does not pulse; repairs R-1
> recommended / R-2) and **D-2** (REQ-013's "ultimate consumer must
> discard" clause is discharged by nobody on the ARP branch, and
> SPEC-M10 §11.3 prices the repair wrongly as a record addition when
> D-2a touches no interface; repairs D-2a recommended / D-2b). First
> withheld countersignature since WO-0005. The four architect questions
> answered: Q1 instantiation (no ADR-0008 amendment), Q2 = D-2, Q3
> **consequence clause — no `cfg_tx_enable` at M13, NOT breaking**, Q4
> specification decision (one sentence owed), plus Q5 (M12 §11.3)
> agreed. §12 `Interface compile check` rows for all four specs are
> dischargeable now from run 30736107842 / success / 2f29888; the four
> §11.1 items close. The countersignature sentence is pre-worded in the
> Return log for the commit carrying the D-1/D-2 diffs; the re-review
> re-checks only the landing sites, byte-identity/set-equality, and a
> green run at the new SHA — the recomputed arithmetic and Q1/Q3/Q4/Q5
> do not reopen. Batch E may be drafted in parallel (neither repair
> moves a port, record, or latency constant).


## Batch-F countersignature (WITHHELD — transcribed)

> "Batch-F countersignature WITHHELD at `aaa55b2`." — dv_lead, journal
> `J-dv_lead-0010` (WO-0020), transcribed by the orchestrator
> 2026-08-02. SPEC-M18, SPEC-M19, SPEC-M20 **SIGNED** (M20's REQ-006
> closure at 13 cycles confirmed by three routes; M18's W−J = 1
> confirmed by event). SPEC-M17 **CONTESTED** on **F-1**: §6.2 directs
> M17 to copy `tuser`[0] from an input `tlast` word that, for
> under-declaring UDP lengths (⌈N′/8⌉ < ⌈N/8⌉), has not yet arrived —
> up to 182 cycles early at the worst case; §6.1's contrary proof runs
> one inequality the wrong way and proves only the full-delivery case.
> Owed: three clauses (+1 optional) in DRAFT text, plus a §13 diff at
> SPEC-M04 §9 (C-31: ADR-0011's Consequences and REQ-709 cite it as
> "ordered-and-unpinned" while it still reads "pulse together"). All
> seven architect questions answered — ADR-0011's decision AND pricing
> endorsed; the cfg_tx_enable → M18 edge accepted, not E2. C-24…C-30
> reaffirmed (with two count corrections: seven §13 rows, twelve §11
> closures); ADR-0010 accepted. The re-review surface is bounded in
> advance and the countersignature sentence pre-worded for
> `J-dv_lead-0011` at the repair SHA. Withholding rationale, quoted:
> the last signature of the gate "is a reason to hold the line rather
> than to relax it" — repairing F-1 in DRAFT costs one activation;
> after the flip it is a post-freeze §6 behavioural diff, the exact
> cost ADR-0011 refuses at M04.

| C-31 | ADR-0011 Consequences + REQ-709 cite SPEC-M04 §9 as "ordered-and-unpinned" while §9 still reads "pulse together" — §13 diff owed at M04 | the F-1 repair commit (WO-0021) |
| C-32 | M20 §9's conservation decision procedure gap (zero-payload / stimulus-supplied ARP term) | top-level stress bench (with C-3) |
| C-33 | The gapless-only `hdr_valid` one-cycle lead stated unconditionally at four sites — C-27's class one module down | the M17 tb_writer WO |
| C-34 | SPEC-M18 §6.2 `Body`/`Excess` exit overlap on §8 item 4's own stimulus (editorial; lands free in the F-1 commit) | the F-1 repair commit |
| C-35 | SPEC-M18 §3's 184-vs-185 REQ-015 bound (editorial; lands free in the F-1 commit) | the F-1 repair commit |
| C-36 | cfg_tx_enable's two readers (M04, M18) composed — the disable window's joint observable unstated | AP-udp_ip_tx_64.md and the M20 bench WO |

## Batch-D + batch-E countersignatures (transcribed)

> "I countersign batch D (SPEC-M10, SPEC-M11, SPEC-M12, SPEC-M13) for
> P1-spec-freeze at `3f6accc`." — dv_lead, journal `J-dv_lead-0009`
> (WO-0018), transcribed by the orchestrator 2026-08-02. The bounded
> re-review of the WO-0015 withholding: D-1/R-1 holds including at the
> M11-frees/machine-(A)-exits boundary and the request-drains-first
> case; D-2a holds at all landing sites with ADR-0009; no
> requirements.md diff for D-1, verified byte-identical to a9993ff.

> "I countersign batch E (SPEC-M14, SPEC-M15, SPEC-M16) for
> P1-spec-freeze at `3f6accc`." — dv_lead, journal `J-dv_lead-0009`
> (WO-0018), transcribed by the orchestrator 2026-08-02. All three
> signed on recomputation (M14 L=12/h=20/ΔC=4 vs ceiling 5, abort
> inequality proved per residue; M15's 0xF6B4 and stall counts over the
> whole payload range; M16's wiring table orphan-free both directions).
> The five architect questions answered: (i) REQ-502 = 7 accepted, gate
> both halves; (ii) boundary cycle stays pinned (dropped); (iii)
> truncated-alone endorsed, copy at M17 (C-26 scoping); (iv) two-owner
> rows kept; (v) cfg_subnet_mask edge accepted, not E2. C-19…C-23 all
> REAFFIRMED. Batch-E §12 rows dischargeable from run 30739442056 /
> success / 3f6accc. Spec Status-line flips for batches D and E ride
> the next architect packet (WO-0019), per the batch-C precedent.

**Batch-C spec-status flip ratified (WO-0014).** The architect flipped
SPEC-M06…M09 from "Status: DRAFT" to FROZEN-at-508eea2 and completed
their §12 rows (run 30733153172 at f457efc, `J-dv_lead-0007`), matching
what this checklist has recorded since 55e78f2 — a doc-truthfulness
repair, disclosed in the Return log, §12 being the architect's section
(charter §5). The orchestrator verified `docs/gates/` untouched and
ratifies the transcription here.

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
