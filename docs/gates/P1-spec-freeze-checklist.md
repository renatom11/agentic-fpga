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
| F | M17 `Udp_ip_rx_64`, M18 `Udp_ip_tx_64`, M19 `Udp_complete_64`, M20 `Nic_top` | aaa55b2 (WO-0019); F-1 repaired d8df28d (WO-0021) | runs 30742781586 (aaa55b2) + 30744579228 (d8df28d, head SHA = repair commit) green | **SIGNED** (J-dv_lead-0011, WO-0022 re-review after J-dv_lead-0010 withheld) | **FROZEN at d8df28d** |

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
| — | dv machinery defect (self-found): Latency.create's single strip_octets conflates two quantities diverging at M03 lane-4 (ΔC misreport 2 vs 3) — **DISCHARGED at WO-0012** (h-per-frame split, a8a6c5e); closure mark added at WO-0027's clerical note. Successor defect (per-frame output extent, ~tail_octets) tracked as X-5/X-9 in AP machinery gaps | dv's next WO, before any M03 bench |

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
instance)**; **C-24…C-30 CLOSED (WO-0019 at aaa55b2; all seven REAFFIRMED at
WO-0020 with two count corrections — seven §13 rows, twelve §11
closures)**; **C-31, C-34, C-35 CLOSED (WO-0021 at d8df28d, verified
at the WO-0022 re-review)**; **C-37 CLOSED (repaired 8641455 per
ADR-0012, re-countersigned J-dv_lead-0012 with 8.7M-pair quantified
verification); C-39 CLOSED; C-40 open with one named residual site
(SPEC-M17 §10's "on or after"); C-38 deferral endorsed** — C-23 homed in requirements.md §0.6 (generalises)
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


## Batch-F countersignature (GRANTED at the re-review — transcribed)

> "I countersign batch F (SPEC-M17, SPEC-M18, SPEC-M19, SPEC-M20) for
> P1-spec-freeze at `d8df28d`." — dv_lead, journal `J-dv_lead-0011`
> (WO-0022), transcribed by the orchestrator 2026-08-02. The bounded
> re-review: every F-1 clause re-derived from the spec's own formulas
> (the separation is 1 − D; the 182-cycle worst case reproduces as
> D − 1); the architect's two additions judged improvements on dv's
> own commissioned text (the octet-vs-word distinction bounds the
> class from both sides; the D = 0 companion is the executable proof
> of Tail ≡ D ≥ 1); §11.4's carry logic endorsed with the
> flip-invariance caveat noted (M19's DRAFT hook is the one component
> that gets dearer); the out-of-surface §4.2 row accepted, the §3 row
> found to carry a one-word defect in dv's OWN commissioned phrase
> ("on or after" admits D = 1) — carried as C-40. Batch F's four §12
> rows fill from run 30744579228 at the freeze SHA itself.

**With this signature, ALL TWENTY Phase-1 module specifications are
FROZEN: A+B at f78766e, C at 508eea2, D+E at 3f6accc, F at d8df28d.**

## SPEC-M14 revision re-countersignature (C-37/ADR-0012 — transcribed)

> "I re-countersign the SPEC-M14 text moved by ADR-0012 — §2, §3,
> §4.2, §6.1, §6.2, §8, §10, the new §11.5 and the §13 row — for
> `P1-spec-freeze` testability at `8641455`. SPEC-M14 remains FROZEN
> and its testability countersignature stands: on `J-dv_lead-0009` for
> the specification as frozen at `3f6accc`, and on `J-dv_lead-0012`
> for this revision." — dv_lead (WO-0025), transcribed by the
> orchestrator 2026-08-02. The verification quantified rather than
> re-derived: tools/check_abort_availability.sh, **8,720,452 checks,
> 0 failures** over every (N, N′) pair M14/M17 accept — confirming the
> D = K−M−3 identity, the reachable D < 0 branch, the under-fill
> threshold as an iff, the Tail proper-superset (5,820 witnesses,
> first at §8's own 36/37 case), the split hook's passability (the old
> hook was unsatisfiable on its own stimulus), and both the 183 and
> 184 figures as measurements of different events. ADR-0012's residual
> disposition ENDORSED with a sharpening: the application-visible loss
> band is total lengths 29–36 at the minimum frame, and §8's probe
> hits its largest member.

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
| C-37 | **F-1's twin at FROZEN SPEC-M14** (dv's largest finding, self-reported as its own WO-0018 escape): M14's output extent is fixed by the IPv4 total length — a count inside the data — and its Tail state consumes Ethernet padding; every total length 21…36 on a padded minimum frame emits the payload tlast up to 184 cycles before the input tlast; §6.1 runs the identical backwards inequality; §10's REQ-007 hook is unscoped and commissions an assertion no conformant design passes on §8's own frames; a bad-FCS minimum-length frame reaches the application unmarked. Does not block batch F (substance at a passed gate; repair price flip-invariant; needs an ADR). Confirms §11.4's carried scoping clause has two customers | **next architect activation (WO-0023), ahead of M14 RTL** |
| C-38 | SPEC-M18 §6.2 lets a word-aligned over-delivery escape REQ-710 (Drain with tlast pending, no strobe, stale word into next frame); REQ-710 (FROZEN) states the correct reading, so carried on the C-26 line | SO-udp_ip_tx_64.md; mandatory attack-plan row |
| C-39 | requirements.md REQ-710's verification column carries C-34's units error ("ten excess words"); frozen, flip-invariant | with C-37's requirements-adjacent sweep or any REQ diff |
| C-40 | SPEC-M17 §3's "on or after" (dv's own phrase) admits D = 1; four unqualified relay statements (§2 ×2, §3 REQ-013 row, §4.2 input row); one sweep | **CLOSED at 541ea43** (sixth site §10 "on or after"→"after"; dv concurrence J-dv_lead-0015) |
| C-41 | The unpassable-assertion class one level up: requirements.md REQ-007/REQ-013/REQ-707 verification columns commission the REQ-007 universal unscoped (satisfiable, so below C-37); REQ-707's is the system bench, gated at neither SO-; the verification-column half is EDITORIAL (C-39's diff proves the class) and closes cheap while the normative clause stays carried | the three editorial column diffs at the next architect activation; **CLOSED at 541ea43** (three columns carry the M14/M17 scope + REQ-707's pinned frame, dv re-derived D = −1/0; normative clause stays carried under C-36's discipline; dv concurrence J-dv_lead-0015) |
| C-42 | SPEC-M14 §12's countersignature row over-states dv's WO-0018 proof (M + 3 ≥ K vs the proved ⌈(N−20)/8⌉ + 3 ≥ K) — dv's own over-statement, self-reported | **CLOSED at 541ea43** (corrected form states the WO-0018 proof; dv confirms it is the form that holds; J-dv_lead-0015) |
| C-43 | requirements.md §12's `error_ip_bad_header` condition cell no longer states what that strobe reports at M14 (ADR-0013's third disjunct absent). §12 is normative, its column is headed "Condition", and it is the enumeration REQ-008 quantifies over — REQ-008 discharged for this discard only once the cell moves. REQ-601's normative sentence is NOT asked for (sufficient condition, unfalsified). One cell | `SO-ip_eth_rx_64.md` |
| C-44 | SPEC-M14 §6.3 item 4 and §10's REQ-603 hook carry dv's own overclaim — the flag-bit pair is not "the only stimulus" killing a wrong-bit read of octet 6 (M14-B4 already kills the wrong-single-bit design); the pair's real unique kill is the over-broad read. Justification only; row and stimulus stand. dv self-report | `SO-ip_eth_rx_64.md` |
| C-45 | SPEC-M03 §6.1 and §10's REQ-016 hook forbid idle injection "between a frame's start character and its first octet" on the "occupies preamble positions" ground — true at a lane-4 start, false at lane-0 where the same paragraph derives all eight preamble positions inside the start word. Over-broad by one injection point, the very point where a preamble/frame boundary defect would show. dv's own wording first (M03-N3, X-4) | the SPEC-M03 R1/R2 repair commit, or `SO-xgmii_rx_64.md` |
| C-46 | requirements.md REQ-810's verification column still commissions "no strobe anywhere" without the no-frame-in-flight scope its own new sentence creates. Passable as written; C-41's family; one cell (may point at SPEC-M03 §10's REQ-802/REQ-810 hook, which already enumerates both cases) | `SO-xgmii_rx_64.md` |
| C-47 | SPEC-M03 §9's rows 8 and 9 classify a REQ-110 abort by "≥ 1 octet delivered" / "still inside its own preamble", leaving a frame past its preamble with zero delivered octets (the `/S/` on the frame's own first octet) in neither row. §9's row 3 is the in-document model (states the REQ-105 sibling extensionally); requirements.md REQ-110's zero-delivered gloss is a second site, though its governing extensional clause forces the outcome. Non-blocking: nothing ambiguous, no plan row at risk; what is missing is the row that says so. Offered by architect_docs_lead at WO-0031, accepted and rewidened by dv_lead | `SO-xgmii_rx_64.md`, or the next SPEC-M03 §9 diff |
| C-48 | `AP-ip_eth_rx_64.md` row M14-B3(a) commissioned a stimulus that cannot exist: fold-once and the fixpoint fold make the same accept/reject decision on every 20-octet header (proved while building X-8; `Ipv4_ref.fold_once_divergence` now searches for a counterexample every CI run and expects `None`). Sub-case (a) withdrawn in place; (b) carries the row. dv self-report — third instance of its named failure mode | closed at the d680945 arc; the CI search keeps it closed |

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

## SPEC-M14 revision re-countersignature (ADR-0013 + M14-B5 — transcribed)
>
> "I re-countersign the SPEC-M14 text moved at `541ea43` — §2, §4.2, §6.1,
> §6.2, §6.3 item 4, §8, §9, §10, §12 and the three §13 rows — for
> `P1-spec-freeze` testability. SPEC-M14 remains FROZEN and its testability
> countersignature stands: on `J-dv_lead-0009` for the specification as frozen
> at `3f6accc`, on `J-dv_lead-0012` for the ADR-0012 revision at `8641455`, and
> on `J-dv_lead-0015` for this one." — dv_lead (WO-0030), transcribed by the
> orchestrator 2026-08-03. ADR-0013's **substituted ground judged better than
> the recommendation it replaced**: REQ-605 is unsatisfiable on the class and
> REQ-008/§0.6 forbid a silent discard, so requirements.md forces the
> disposition and leaves only the name — with REQ-612 confirmed as the internal
> precedent that scopes REQ-605 to accepted datagrams. Partition verified total
> and disjoint over the full 16-bit domain. The flagged question answered: **not
> REQ-601's normative sentence** (a sufficient condition, unfalsified) but
> **requirements.md §12's condition cell**, which is normative, is headed
> "Condition", and is the enumeration REQ-008 quantifies over — carried as
> **C-43**, not blocking. M14-B5 accepted with the architect's checksum
> recompute, which repaired a vacuity in dv's own proposed stimulus; its
> "unkillable" justification is dv's and is **false** — M14-B4 already kills the
> wrong-single-bit read — carried as **C-44**. Attack plan: **M14-K7 and
> M14-B5 both converted to ASSERT**, K7 with a total-length-20 anti-vacuity
> partner added.

## SPEC-M03 revision re-countersignature (ADR-0014 + the M03 rulings — WITHHELD, transcribed)
>
> "SPEC-M03 revision re-countersignature **WITHHELD** at `541ea43`." — dv_lead,
> journal `J-dv_lead-0015` (WO-0030), transcribed by the orchestrator
> 2026-08-03. Both rulings **endorsed on their merits** — reading (i) on closure
> characters (with REQ-101's identical-output-stream requirement supplied as a
> second, independent ground the ruling did not use: the one-closure reading
> gives one REQ-102 frame two different output streams at the two start lanes)
> and ADR-0014's admission scope — and §6.3 item 8 endorsed as a bound on the
> stimulus that excludes no commissioned case. **CONTESTED on two sentences,
> both in the M03-N2 material.** **M03-R1**: §6.1's new consequence 1, under
> "Two consequences a bench may rely on", ends "only where it delivered no octet
> do the two fall together" — false, by this specification's own m + 3 formula
> and REQ-110's lane rule, for a lane-4 `/S/` aborting a lane-0-started frame
> that delivered ≥ 1 octet; minimal witness `/S/` lane 0 of W − 1, then `/S/`
> lane 4 and `/T/` lane 6 of W, four octets delivered and both strobes on W + 2.
> The strobes coincide in **three** of the four sub-cases, not one. **M03-R2**:
> §9's "Strobe cycle, pinned" gives a no-output-word frame **W + 2** by its rule
> and **W + 3** by its own gloss whenever the ending character lies in the
> frame's **own start word** — one pre-existing instance (REQ-110's commissioned
> case, missed by dv at `J-dv_lead-0005`) that this ruling turns into a family,
> already reaching the committed ASSERT rows M03-B2 and M03-B3. Repair surface:
> **two sentences**; every other site in the commit is endorsed and the
> re-review is bounded to R1 + R2. Attack plan: **no row converts**; M03-N4's
> conversion is pre-committed unchanged at the repair SHA. Residue **C-45** (the
> idle-injection prohibition is over-broad at a lane-0 start — dv's own wording
> first).

## SPEC-M03 revision re-countersignature (ADR-0014 + the M03 rulings — GRANTED at the repair)
>
> "I re-countersign the SPEC-M03 text moved at `541ea43` as repaired at
> `06c1eba` — §4.3, §6.1, §6.2, §6.3 item 8, §9, §10 and the four §13 rows — for
> `P1-spec-freeze` testability. SPEC-M03 remains FROZEN and its testability
> countersignature stands: on `J-dv_lead-0005` for the specification as frozen at
> `f78766e`, and on `J-dv_lead-0016` for this revision." — dv_lead (WO-0031),
> transcribed by the orchestrator 2026-08-03. The bounded re-review: confinement
> verified against the tree — `docs/specs/**` moves in one file and three hunks,
> and `docs/gates/**` only under the orchestrator's own trailer. **M03-R1**
> repaired with dv's own six-row table, and derived by the **better** route —
> §7's per-octet constant `U + ⌊(k + L)/8⌋`, which is gap-invariant where
> §6.1's `m + 3` is not, and which is what makes the aborted frame's **own**
> start lane the discriminator; both routes re-checked to agree on all six rows.
> Two additions adopted: the coinciding strobes always carry different names, so
> §6.3 item 8 has no instance here, and the coincidence column is injection-proof
> in both directions. **M03-R2** repaired on a **forcing** ground rather than a
> preference — the withdrawn gloss could not have been a rule, since a frame
> delivering no octet has no octet for §7's constant to delay and `m + 3` is
> gapless-qualified against §10's commissioned injection — which also establishes
> that no conformant design changes and that M03-B2/B3 are vindicated, not moved.
> The architect found a **second direction** of the R2 disagreement that dv's
> statement of it missed (the lane-4 four-octet runt, rule S + 4 against `m + 3`
> S + 3); dv enumerated the no-output-word frames and confirms it is the only
> one, and re-derived §0.6's bound for it as S + 4 — at the far edge and inside.
> Attack plan: **M03-N2 and M03-N4 both converted to ASSERT**. Two items answered:
> dv **CONCURS** that its own WO-0030 *prose* ("three of the four sub-cases")
> collapsed an axis its own table carries — the table is right, the specification
> follows the table, no ledger row is owed because nothing is owed, and the
> forward correction is in `J-dv_lead-0016` and the plan; and dv **ACCEPTS** the
> §9 rows 8/9 gap as **C-47**, rewidened to name §9 row 3 as the in-document model
> and requirements.md REQ-110's gloss as a second site.

## requirements.md REQ-810 re-countersignature (ADR-0014 — transcribed)
>
> "I re-countersign requirements.md **REQ-810** as revised at `541ea43` and its
> §13 row, for `P1-spec-freeze` testability. requirements.md remains FROZEN and
> its testability countersignature stands: on `J-dv_lead-0002` for the sixteen
> applied diffs at `b4b4cf4`, and on `J-dv_lead-0015` for this one." — dv_lead
> (WO-0030), transcribed by the orchestrator 2026-08-03. The conflict between
> REQ-810's prohibitions and REQ-803's "never to a frame already in flight" is
> settled in the only direction that does not open the silent-discard hole
> REQ-810's own next clause disclaims, and the scope is stated in the
> requirement's own words. Confirmed: no §0.6 conservation exemption is owed,
> because nothing is *presented* while the enable is 0 — unlike `clear` (C-2),
> which abandons an admitted frame. Residue **C-46**: the verification column
> still reads "no strobe anywhere" without the no-frame-in-flight scope its own
> new sentence creates — passable as written, C-41's family, one cell.

**Pre-worded for the SPEC-M03 repair SHA** (WO-0022 precedent — the re-review
surface is R1 and R2 and nothing else; if the repair is confined to them this
sentence is the whole of the next signature):

> "I re-countersign the SPEC-M03 text moved at `541ea43` as repaired at
> `<SHA>` — §4.3, §6.1, §6.2, §6.3 item 8, §9, §10 and the four §13 rows — for
> `P1-spec-freeze` testability. SPEC-M03 remains FROZEN and its testability
> countersignature stands: on `J-dv_lead-0005` for the specification as frozen
> at `f78766e`, and on `J-dv_lead-00NN` for this revision."

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

- [x] All six batches FROZEN (table complete) — A+B f78766e, C 508eea2, D+E 3f6accc, F d8df28d; six countersignatures J-dv_lead-0003/0005/0007/0009/0011, two of them granted at re-reviews after properly withheld first verdicts
- [x] Sponsor signature — **"I sign P1-spec-freeze"** — Renato (sponsor), 2026-08-02T16:53Z, transcribed verbatim by the orchestrator (J-orchestrator-0075). State of the record at signature time: 20/20 specs FROZEN with every countersignature standing, including the full post-freeze revision chain in force (ADR-0012 at 8641455, ADR-0013/0014 at 541ea43, the R1/R2 repair at 06c1eba — countersignatures J-dv_lead-0012/0015/0016); carry-forward ledger C-1…C-47 with every open row carried on a named artefact; REQ-902 byte-determinism proven at run 30753089901. One work order in flight (WO-0032, M03 RTL conformance against frozen batch-A text) — an implementation item under an already-frozen spec, not a gate item.

**P1-spec-freeze: CLOSED 2026-08-02T16:53Z.**
