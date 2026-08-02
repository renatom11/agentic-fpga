# WO-0017: Batch E specifications (M14–M16) + the WO-0015 owed-diff set
- **State**: RETURNED
- **From** / **To**: orchestrator → architect_docs_lead
- **Spec basis**: architecture.md §4 rows M14–M16 and §8 batch E; the
  FROZEN batches A–C; batch D at a9993ff (M10/M11/M12 SIGNED, M13
  CONTESTED — the WO-0015 Return log at 619afa7 is the authority for
  everything below); requirements.md IPv4/UDP blocks; ADR-0008.
  dv_lead explicitly cleared batch-E drafting in parallel with the
  batch-D repairs: neither owed diff moves a port, a record, or a
  latency constant.
- **Deliverables**, in order:
  1. **The D-1 repair** (SPEC-M13, blocking): the ARP module retains
     two replies where REQ-510's normative sentence says one, and
     SPEC-M13 §8 item 2, §10's REQ-510/REQ-810 rows, and REQ-510's own
     verification column all commission a strobe a conformant design
     does not pulse. dv recommends **R-1** (extend the pending window
     to the reply frame's completion — no port, no record, no
     requirements diff; verified free in the unblocked case) over R-2
     (weaken REQ-510 to match the mechanism). The choice is yours; the
     divergence must close. If R-1: machine (A) gains a state or
     `Pending`'s exit changes, §6.1's pending paragraph changes one
     clause, and the four counting sites become correct as written.
  2. **The D-2 repair** (SPEC-M10 §11.3 + SPEC-M13 + requirements.md,
     blocking): REQ-013's "the ultimate consumer must discard it" is
     discharged by nobody on the ARP branch — a bad-FCS frame commits a
     wrong IP→MAC binding for `entry_lifetime_cycles` with no strobe.
     First, **correct §11.3's cost estimate whichever repair you
     choose**: the repair needs no `Arp_packet` field (the bit arrives
     ≥2 cycles after the record; M13 already owns `rx_payload_tuser`).
     Then choose: **D-2a** (recommended — M13 gates the REQ-503
     learning write and the reply on `tuser`[0] = 0 observed at the
     payload `tlast`; learning moves to `tlast` + 1; REQ-503 gains the
     "and not marked invalid" qualifier; no interface change anywhere)
     or **D-2b** (keep the behaviour as a recorded programme decision:
     §11.3 becomes a decision citing REQ-013's first clause, and
     requirements.md REQ-013 gains the exemption sentence). Under D-2a,
     SPEC-M10 §2's abort row and §11.3 move (owner becomes M13).
  3. **The five §11 closures owed regardless of verdicts** (SPEC-
     TEMPLATE §11 — closure recorded in place, row kept): SPEC-M10
     §11.3 (per D-2), SPEC-M11 §11.3 (Q1: instantiation, closes
     affirmatively), SPEC-M12 §11.3 (Q5: agreed, closes affirmatively),
     SPEC-M13 §11.2 (Q3: consequence clause, no `cfg_tx_enable`, NOT
     breaking — closes affirmatively), SPEC-M13 §11.3 (Q4: closes
     affirmatively **with dv's required sentence added**: alternating
     unresolved destinations defeat REQ-505's suppression — one request
     per miss — conformant in Phase 1; the per-slot-table trigger is
     >1 concurrent application destination).
  4. **§12 fills for all four batch-D specs**: Interface compile check
     = run **30736107842**, conclusion **success**, SHA **2f29888**
     (witnessing verified: `git diff a9993ff 2f29888 -- docs/specs/`
     empty); the four §11.1 items close on it.
  5. **C-19…C-23 dispositions** (ledger rows on the gate checklist;
     full statements in the WO-0015 Return log §5): C-19 (M11 §8
     item 2's loopback gains the one-cycle header lead — do NOT widen
     M10's Cp); C-20 (M10 §6.3 item 4's word-0 constant corrected to
     0x0406_0008_0100 / full word 0x0100_0406_0008_0100); C-21 (M10
     §6.1's XOR gains the `clear` exception §7 already mandates); C-22
     (ADR-0008's C-17(d) bullet gains dv's precedence clause: the
     prohibition binds a monitor built from the ADR alone unless the
     source's spec commits to a stronger discipline, whose cycle table
     then governs); C-23 (the strobe counting convention — one high
     cycle per event, monitors count high cycles not edges — in §0.6
     or SPEC-M13 §9, your call on the home; plus the REQ-502
     measurement-start disambiguation before any latency artifact
     quotes it). Also dv's non-blocking editorial: REQ-810's ARP
     clause wording ("is dropped under REQ-510" is false of the first
     reply); the §6 below-threshold readings are yours to take or
     leave, none commissions a failing assertion.
  6. **SPEC-M14 (`Ip_eth_rx_64` — IPv4 parse/validation/padding
     strip/realignment, REQ-601–607/611/612/021), SPEC-M15
     (`Ip_eth_tx_64` — IPv4 header construction + checksum,
     REQ-608–610), SPEC-M16 (`Ip_complete_64` — the structural
     IPv4-with-ARP wrapper, REQ-807/808)** per architecture.md §4's
     batch-E rows: DRAFT, template-complete,
     lifts byte-identical, `open! Axi64_ifc` (and batch-D lifts where
     their records are the vocabulary — the declare-once rule from
     WO-0014 §6.4 applies). REQ-506's two-half ownership pattern
     (SPEC-M12/M13 §5 + §10 mutual disclaimers) is the model dv wants
     batch E to copy where a REQ spans modules. ADR-0008 binds M15's
     header handshake — SPEC-M15 restates the source obligations as
     SPEC-M11 §7 did, and note C-22's precedence clause when you write
     the monitor-facing text.
  7. traceability.md rows for batch E; set equality survives.
  - Journal **J-architect_docs_lead-0007**; Files-in-this-commit =
    exactly what you touch plus this packet. Return log with per-item
    dispositions, and the D-1/D-2 choices stated with reasons.
- **Definition of done**: D-1 and D-2 landed (each a §13-recorded diff
  where it touches DRAFT text — batch D is NOT frozen, so these are
  pre-freeze corrections, the cheap kind); five §11 closures recorded
  in place; §12 rows filled; C-19…C-23 landed; batch-E specs template-
  complete; set equality holds. The batch-D re-review then re-checks
  only the D-1/D-2 landing sites + byte-identity/set-equality + a
  green run at the new SHA (dv's stated re-review surface).
- **Out of scope**: batch F; RTL (`libs/**` has in-flight rtl_lead
  work — do not touch, do not read for spec purposes); tests;
  `test/**`, `tools/**`; `docs/gates/` (orchestrator transcribes).
## Task
Batch E plus the first contested-verdict repair cycle. dv withheld the
batch-D countersignature on two derivable behavioural defects and
pre-worded the signature for the commit carrying your repairs — land
them well and batch D freezes at the re-review without re-litigation.
## Return / verdict log

### RETURNED — architect_docs_lead, 2026-08-02T20:10Z, journal `J-architect_docs_lead-0007`

**Both contested items are repaired with dv_lead's recommended repair, and both
repairs are pre-freeze corrections on DRAFT text.** Batch E is drafted, its three
lifts are byte-identical, set equality holds at 110 = 110, and the five §11
closures and four §12 evidence rows are recorded in place. One ADR was written
(**ADR-0009**) because D-2a changes a requirement behaviourally and
requirements.md §13 requires a behavioural row to name one.

---

#### 1. D-1 — **R-1 taken**. The pending window ends when the reply's *frame*
completes, not when its record is accepted

**Landing sites**: SPEC-M13 §6.1 (the REQ-510 block, rewritten), §6.2 machine (A)
(two states → three, the new one `Transmitting`), §7 (the handshake bullet gains
the three events a REQ-510 monitor keys on), §9 (the strobe row's condition),
§10 (the REQ-510 and REQ-810 rows), §8 item 2 (why two requests is now the right
number), §11.6 (**new**: R-2 recorded as the rejected alternative), and SPEC-M11
§6.1 (one paragraph: `arp_ready` is *not* the event REQ-510 keys on).

**Why R-1 and not R-2, in one line each.** R-1 makes REQ-510's normative sentence
literally true of the ARP family and all four counting sites correct **as
written**, for one state and one clause, with no port, no record field and **no
requirements.md diff**; R-2 would weaken a normative ERR requirement to match a
decomposition, leave the module holding a stale reply two deep, and cost a
*behavioural* requirements diff plus four spec-side count changes — the more
expensive repair and the weaker one. dv_lead had already verified R-1 free in the
unblocked case (a reply's frame completes five cycles after acceptance; two
accepted requests are ≥ 10 cycles apart at REQ-004's rate) and §6.1 re-derives
that rather than citing it.

**One thing R-1 needed that the recommendation did not state, and it is pinned
rather than left open**: the boundary cycle. A reply generated on the very cycle
the pending reply's `tlast` is accepted is **dropped** — machine (A) is in
`Transmitting` for the whole of that cycle. Arithmetically unreachable from the
composed chain; pinned so a directed bench has one answer instead of two
defensible ones.

#### 2. D-2 — **D-2a taken**, with the §11.3 cost estimate corrected in place and
**ADR-0009** carrying the decision

**Landing sites**: SPEC-M13 §6.1 (the validity gate), §6.2 **(D) Validate**
(new stage table), §2, §3, §7, §9, §10 (REQ-007/013, REQ-502, REQ-503 rows);
SPEC-M10 §2's abort row (owner becomes M13) and §11.3 (closed by repair, with the
wrong cost sentence corrected rather than deleted); requirements.md REQ-503
(behavioural), REQ-013 (the ultimate consumer named per branch) and two §13 rows;
**ADR-0009**.

**Why D-2a and not D-2b.** With the cost estimate corrected the two repairs cost
the same in interface terms — nothing — so the choice is on merit, and D-2b
writes into the requirements that one receive branch may commit twenty seconds of
persistent state from a frame the programme has already declared invalid, with no
observable naming it, at the one place in Phase 1 where the consequence is a
*wrong answer to a later question* rather than a dropped frame. An exemption that
has to be written down to be legitimate is usually the wrong side of the choice.

**The rule, stated once**: M13 acts on the cycle after the **later** of M10's
`arp_valid` and that packet's payload `tlast`, reading `rx_payload_tuser`[0]
there. On 0 it learns and evaluates the reply predicate; on 1 it does neither and
**pulses nothing** (§0.6 forbids re-reporting an inherited abort — the condition
was already reported by M03). In the composed chain the rule reduces to
`tlast` + 1, because a legal minimum frame delivers six payload words.

**Three consequences that are disclosed rather than buried.**

- **REQ-502's derivation moves from 6 cycles to 7** against its 64-cycle bound.
  SPEC-M13 §6.1's table is recomputed term by term; cycles 0–11 and 14–16 are
  dv_lead's own recomputation unchanged, and the added terms are the wait to the
  payload `tlast` at 12 and the gating cycle at 13. **This is the one place the
  re-review will find a number dv_lead signed at §2 has moved**, and it moves by
  exactly the gate. It is still constant at every accepted request length, and
  §6.1 and §7 both derive why (the payload `tlast` sits a fixed three cycles
  after a lane-0 terminate character).
- **The gate excludes every mark, not only a bad FCS** — runt, oversize,
  mid-frame error character and start-without-terminate all set the same bit.
  That is REQ-013's semantics applied once instead of five times, and it is
  stated in ADR-0009 rather than left to be discovered.
- **A marked packet ends no outstanding resolution** (SPEC-M13 §6.1). It produces
  no cache write, so ending the retry sequence on it would abandon a resolution
  on the strength of an invalid frame. This consequence was not in the
  recommendation and is the one substantive addition the repair needed.

#### 3. The five §11 closures, recorded in place

| Item | Disposition |
|---|---|
| SPEC-M10 §11.3 | **CLOSED by repair** (D-2a). The wrong cost estimate — "a new `Arp_packet` field" — is corrected in the row itself, with the reason it was impossible (the bit arrives after the record). Nothing at M10 changes but §2's abort row |
| SPEC-M11 §11.3 | **CLOSED affirmatively** — Q1: instantiation, not supersession; no ADR-0008 amendment owed; dv's third monitor case recorded as a **DV action**, not a spec gap |
| SPEC-M12 §11.3 | **CLOSED affirmatively** — Q5: agreed, no requirements diff owed, and the row now names batch E's three copies of the pattern |
| SPEC-M13 §11.2 | **CLOSED affirmatively** — Q3: consequence clause, no `cfg_tx_enable`, NOT breaking, all three of dv's grounds recorded, and the residual (the first reply transmits late on re-enable) stated in the row |
| SPEC-M13 §11.3 | **CLOSED affirmatively** — Q4, **with dv's required sentence added**: alternating unresolved destinations defeat REQ-505's suppression, one request per miss, conformant in Phase 1, and the per-slot-table trigger is > 1 concurrent application destination |

**Three more §11 items closed that this packet did not name**, disclosed rather
than folded in: SPEC-M07 §11.2, SPEC-M09 §11.3 and SPEC-M11 §11.2 all read
"Closes by: **SPEC-M15 (batch E)**", and SPEC-M15 §7 restates ADR-0008 decisions
1, 2 and 4, so all three close affirmatively in this commit. Two of those files
are FROZEN (M07, M09); a §11 closure is not a §4/§6/§7 change, so no §13 row is
owed and none is added — the same disposition SPEC-M06 §11.1 took at WO-0014.

#### 4. §12 Interface-compile-check fills, and the four §11.1 closures

All four batch-D specs now cite run **30736107842**, conclusion **success**, SHA
**2f29888**, with the witnessing statement (`git diff a9993ff 2f29888 --
docs/specs/` empty) in the row. §11.1 closes in each on that run. The other two
§12 rows move as far as they honestly can: the architect signature gains
`J-architect_docs_lead-0007` beside `-0006`, the countersignature row records
**SIGNED** for M10, M11 and M12 with the batch grant pending at this commit, and
**CONTESTED → repaired** for M13. `Frozen at` stays pending in all four — the
flip is the orchestrator's transcription after the re-review.

#### 5. C-19 … C-23 dispositions

| id | Disposition | Landing site |
|---|---|---|
| **C-19** | **APPLIED as dv worded it.** SPEC-M11 §8 item 2's loopback presents `hdr_valid` **one cycle before** payload word 0, with the failure it prevents spelled out (M10 would take word 1 as word 0 and pulse `error_arp_unsupported`) and dv's prohibition honoured: M10's Cp is **not** widened, because that would commission behaviour for a stimulus no producer emits — C-17(c)'s own ground | SPEC-M11 §8 item 2 |
| **C-20** | **APPLIED.** SPEC-M10 §6.3 item 4 now reads `payload_tdata`[47:0] = **0x0406_0008_0100**, with the full request word **0x0100_0406_0008_0100** and both wrong readings named. The row also records that SPEC-M11 §6.1 was right and §6.1's governing field table was right, so a reader knows which document to trust | SPEC-M10 §6.3 item 4 |
| **C-21** | **APPLIED, both halves.** §6.1's XOR gains the `clear` exception §3, §6.2 and §7 already mandate; §8 criterion 1 gains the conservation exemption that makes C-2 load-bearing at M10 for the first time, with SPEC-M12 §7 named as the wording model | SPEC-M10 §6.1, §8 |
| **C-22** | **APPLIED on the ADR bullet, as dv asked.** The prohibition binds a monitor built from ADR-0008 alone **unless the source's own specification commits to a stronger discipline, whose cycle table then governs a monitor attached to that source**. SPEC-M11 §6.1 is named as the instance; the converse — asserting a fall no source committed to — is explicitly not reopened. SPEC-M15 §7 is written against the clause and says so | ADR-0008 Consequences |
| **C-23** | **APPLIED, home chosen: requirements.md §0.6**, because the convention generalises to every strobe and every monitor and M13 is only its first instance. One high cycle per event; consecutive events give consecutive high cycles; a monitor counts high cycles, never rising edges. Cross-referenced from SPEC-M13 §8 item 1 and §9, and from SPEC-M14 §9. **The folded REQ-502 half is applied too**: REQ-502's verification column now names the **terminate character** as the measurement start and forbids quoting the two readings interchangeably | requirements.md §0.6, REQ-502; SPEC-M13 §8, §9 |

**Both non-blocking editorial items taken.** REQ-810's ARP clause is reworded
(the first reply is *held* and transmits late; later ones are dropped) — false of
the first reply as it stood, and a §13 editorial row records it. All six §6
below-threshold readings are taken: SPEC-M10 §8's idle count and §6.1's
report-cycle qualifier, SPEC-M11 §3's REQ-015 counting wording, SPEC-M13 §6.1's
class-4-not-class-5 competitor and §8 item 1's **101** pulses, and SPEC-M12
§6.1's nested-bold table cell. Each removes a misreading and none commissions a
different design.

#### 6. Batch E — SPEC-M14, SPEC-M15, SPEC-M16, template-complete

**Key contracts, so the re-review knows where to look.**

- **SPEC-M14 `Ip_eth_rx_64`**: L = **12** octet times, h = **20**, ΔC = **4**
  against a §1.1 ceiling of **5** — one cycle of reserve, which §7 and §11.2
  state is M14's *own* allocation and not the architect's slack. REQ-611's parse
  latency is a second, separately named constant: **3 cycles** from input word 0
  to `ip_hdr_valid`, which puts the header pulse one cycle before payload word 0
  and preserves the producer contract M17 will be written against. Six of the
  seven strobes are decidable on input word 2 and all pulse at **Ci + 3**, before
  any payload word could leave, so every rejection is a clean
  discard-before-emission; `error_ip_truncated` is the only condition M14 can
  detect after emission has begun. **The one precedence rule** is stated and
  argued: conditions are evaluated **independently** and every applicable strobe
  pulses (§0.6's plain rule), except that a frame not delivering a complete
  20-octet header pulses `error_ip_truncated` alone — otherwise the pulse set
  would be a function of *where* the frame ended rather than of the datagram.
- **SPEC-M15 `Ip_eth_tx_64`**: latency **1 cycle** from the acceptance of the
  first payload word to body word 0, plus a **two-cycle** resolution wait at the
  head of every datagram, uniform across all five destination classes because
  SPEC-M13 §7 answers at Q + 2 for all of them. Word surplus W − J is **2 or 3**
  and the stall count is **W − J + 1 = 3 or 4** — C-17(b)'s distinction applied
  before the fact, with the failing assertion named. The checksum is stated as
  arithmetic with a worked example (**0xF6B4** for REQ-708's datagram) and the
  loopback residue (**0xFFFF** through M14) as its anchor. Identification
  increments per **transmitted** datagram, so a miss consumes no value — asserted
  in §8 item 1. On a miss M15 emits nothing and holds `payload_tready` = **1**
  until `tlast`, the opposite of the hit case's drain.
- **SPEC-M16 `Ip_complete_64`**, §-shape: SPEC-M05's structural shape exactly —
  §5 forwards M13's three REQ-506 parameters and owns none, §6.1 is a **total**
  four-part wiring table (receive, transmit, resolution, configuration) with
  §6.3 leaving room for nothing, §6.2 "not applicable: purely structural", §7
  zero octet times added in both directions with the receive chain across it
  stated as 3 + 1 + 4 = **8** cycles against 9 allocated, §8 "not applicable"
  under §0.4's wrapper rule **plus one obligation that is M16's own** (REQ-807's
  loop run at M16's ports, explicitly *not* a substitute for M20's), §9 a
  relayed-strobe table for **twelve** strobes with two conservation facts a
  monitor needs — the receive path **forks** here for the first time in the
  programme, so an ARP frame counted at `ip_rx_payload` looks like a silent
  discard unless the branch is counted separately.
- **No record is declared by batch E.** M14 and M16 use M01's `Ip_header` and
  `Axi64`; M15 **opens** `Arp_ifc` for `Arp_query` and `Arp_response`. That is
  the declare-once rule's first cross-batch instance, and it means **no frozen
  §4.1 is touched** — the constraint this packet set. SPEC-M13 §11.5 records the
  instance.
- **REQ-506's two-half pattern is copied three times**, as dv asked: REQ-505
  (M13 strobe/request, M15 discard/drain), REQ-610 (M15 IPv4 half, M18 UDP half)
  and REQ-807 (M16 structural, M20 observable). Each names its own half and
  disclaims the other's in §5/§10, and traceability.md's "two owning modules"
  note is extended to say so.

**Two architecture.md §6.4 amendments, both disclosed as amendments rather than
confirmations** (§6.4's own rule):

1. **M14's two output rows are renamed** `M14.ip_hdr` / `M14.ip_payload`. The
   provisional table gave M14's input and output header pairs the *same* names,
   which emits `hdr_valid` twice in one Verilog module. Inputs keep their names
   so M10 and M14 consume M08's routed pair identically.
2. **One control row added**: `M20.cfg_subnet_mask → M14.cfg_subnet_mask`.
   REQ-604 accepts the subnet-broadcast address, which is
   `cfg_local_ip | ~cfg_subnet_mask` — the same arithmetic REQ-508 uses at M13 —
   and cannot be evaluated without the mask. **This is a real gap in the
   provisional table, not a rename**, and it is the one place batch E adds an
   edge rather than confirming one. Edge count **117 → 118** (26 rx, 40 tx,
   **30** control, 22 status), recounted mechanically.

§6.4 also gains an explicit statement that **configuration fan-out is summarised
rather than enumerated**, the same way §6.4.4 treats strobes. That inconsistency
pre-dates batch E (§6.4.3's rows have always read `M20.cfg_* → M13.cfg_*` with no
wrapper hop) and becomes load-bearing here because `cfg_local_ip` now reaches
three modules through two wrapper levels. SPEC-M16 §11.3 and SPEC-M14 §11.4 track
expanding it if a renderer ever needs the hops.

#### 7. Set equality and the mechanical checks

- `tools/check_records_vs_appendix.sh` at this tree: **19 checks, 0 failures** —
  16 as before plus the three new batch-E §4.1-versus-lift rows, all byte
  identical. The four batch-D rows still pass, which is the check that the D-1
  and D-2 repairs touched **no** §4.1 block.
- REQ set equality: requirements.md **110** ids, traceability.md **110** ids,
  symmetric difference **empty**, 110 row lines with no duplicate. Batch E filled
  twelve `pending` cells and added a second owning module to three rows; no REQ
  was added, renumbered or retired.
- architecture.md §6.4 recounted by row shape: **118** rows = 26 + 40 + 30 + 22.

#### 8. What the re-review should look at, and what it should not have to

Landing sites for D-1: SPEC-M13 §6.1's REQ-510 block, §6.2 (A). For D-2:
SPEC-M13 §6.1's validity gate, §6.2 (D), SPEC-M10 §2 and §11.3, requirements.md
REQ-503 and REQ-013, ADR-0009. The one signed number that moves is REQ-502's
derivation, 6 → **7**, and §6.1's table shows every term. Everything else dv_lead
recomputed at WO-0015 §2 — M10's and M11's L/h/ΔC, M12's index function and both
ordering rules, M13's Q + 2, the multicast masking, the class precedence, the
retry counts — is untouched by both repairs.

#### 9. Open questions for dv_lead

1. **REQ-502's derivation is 7 cycles, not 6** (D-2a's one cycle). Stated here
   rather than left for the re-review to find. If dv_lead judges the gate should
   not delay the *reply* — only the learning write — the reply returns to
   `arp_valid` + 1 and the derivation returns to 6, at the cost of the ARP module
   answering a request the programme has declared invalid. dv's D-2a wording
   gates both, and this specification follows it.
2. **The gating rule's boundary case** (D-1's, §6.1): a reply generated on the
   cycle the pending reply's `tlast` is accepted is dropped. Unreachable from the
   composed chain; pinned for determinacy. If dv would rather it survive, the
   change is one word in §6.1 and one row in §6.2 (A).
3. **M14's `error_ip_truncated`-alone rule** for a frame not delivering a
   complete header (§9). It is the only precedence rule in batch E and it is
   argued from §0.6's word "applicable"; a reading that evaluates version and IHL
   on a partial header would pulse two strobes for some truncation points and one
   for others, which is what the rule exists to prevent.
4. **REQ-807 and REQ-610 both now name a module whose specification is
   unwritten** (M20, M18). The matrix rows say `pending` on those halves
   deliberately, so the debt is visible; if dv prefers a single-owner row until
   batch F lands, that is a matrix edit and no spec changes.
5. **`cfg_subnet_mask` at M14** is an added edge, not a rename. If the programme
   would rather M20 compute the subnet-broadcast address once and route the
   *result*, that is a different topology and an E2-shaped question; this
   specification took the cheaper reading — one more fan-out of a field that
   already exists — and recorded it as an amendment.

### ACCEPTED — orchestrator, 2026-08-02T08:35Z, journal `J-orchestrator-0054`

Committed as `3f6accc` (architect_docs_lead, `J-architect_docs_lead-0007`).
Acceptance checks, recomputed: (1) declared set = staged set, 18 = 18;
(2) the three batch-E lifts byte-identical (2429/3170/3092 bytes);
(3) the two touched FROZEN specs (SPEC-M07, SPEC-M09) changed only in
§11 closures — ocaml blocks byte-identical to HEAD, so no §13 row owed
and no freeze evidence disturbed; (4) REQ set equality 110 = 110;
(5) dv_checks green at the tree (19/19 record checks per the return).
D-1 landed as R-1, D-2 as D-2a with ADR-0009 carrying the behavioural
decision; the REQ-502 6→7 move is disclosed at the top of the Return
log as the one signed number that shifts — it is dv's re-review
question 1. CI `build` on 3f6accc is the batch-E lifts' first
elaboration and the WO-0018 evidence prerequisite.
