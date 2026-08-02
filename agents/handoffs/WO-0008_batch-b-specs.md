# WO-0008: Batch B specifications + the accumulated spec-diff backlog
- **State**: RETURNED
- **From** / **To**: orchestrator → architect_docs_lead
- **Spec basis**: architecture.md §4 (M03/M04/M05 rows) and §8 (batch B);
  SPEC-TEMPLATE.md; requirements.md at b4b4cf4; the WO-0006/WO-0007 Return
  logs (ACCEPTED dispositions); the P1-spec-freeze checklist ledger
  (C-1, C-4, C-8, C-10 land in this WO); the board's 2026-08-02 sponsor
  decisions (latency-budget delegation)
- **Deliverables**, in this order of importance:
  1. **§11 reconciliation** (unblocks the batch-A FROZEN flip):
     SPEC-TEMPLATE §11 amended — a FROZEN spec may carry no OPEN
     questions; deferred items must cite a tracked ledger row or WO and
     state what a reader should assume meanwhile. Both batch-A specs'
     §11 sections converted to that form (their eight items each cite
     C-numbers or this WO). Fold in C-10 (restore REQ-013's "solely" in
     SPEC-M01 §6.1) and the template's `Ifc_check_axi64` → `Axi64_ifc`
     naming fix.
  2. **requirements.md diffs** (small, enumerated): the agreed REQ-010
     narrowing to frame-carrying stream ports, naming M02; C-8 (REQ-903's
     quantifier — exclude or split the types-only case, address the .mli
     half); C-4 (REQ-105/110 zero-delivered-octet tuser wording).
  3. **C-1 resolution with dv_lead's proposal as the starting point**
     (compare (L + h)/8, not floor(L/8)) — restate §1.1's comparison
     method and the REQ-006 budget coherently. SPONSOR MANDATE ON RECORD
     (board, 2026-08-02): the sponsor delegated the budget resolution to
     you and dv_lead jointly; whatever you two converge on at the batch-B
     countersignature is sponsor-authorized. State your resolution in the
     spec text and flag it in the Return log for dv_lead's explicit
     judgment.
  4. **Two ADRs**: docs/adr/ADR-0006 (Crc32_eth finished-value port
     convention — the deciding argument is on record in SPEC-M02 and
     WO-0006), docs/adr/ADR-0007 (octet_count 4-bit 1–8 encoding).
  5. **traceability.md** spec-target column: batch-A rows (the eleven
     stale plus any this WO changes) point at their spec sections.
  6. **The three batch-B specs**: docs/specs/modules/xgmii_rx_64.md
     (SPEC-M03), xgmii_tx_64.md (SPEC-M04), eth_mac_10g.md (SPEC-M05),
     DRAFT, template-complete, plus ifc_check lifts. The M03 lift MUST
     name Axi64.Source fields explicitly (settles SPEC-M01 §11.4 in CI).
     Resolve the deferred batch-B design questions from WO-0006
     (XGMII lane-pair type home; whether octet_count = 0 needs a REQ-307
     identity; M03's FCS-check formulation) and record the choices.
  - Journal entry J-architect_docs_lead-0004; Files-in-this-commit =
    exactly what you touched (docs/specs/**, docs/adr/ADR-0006/0007,
    this packet).
  - Return log entry (state → RETURNED) with a deliverable-by-deliverable
    disposition table.
- **Definition of done**: batch-A specs carry zero OPEN §11 items under
  the amended wording; REQ/traceability set equality survives every
  requirements.md change; the C-1 resolution is stated in one place and
  cross-referenced; both ADRs cite their provenance; the three new specs
  are template-complete with lifts byte-identical.
- **Out of scope**: batches C–F; RTL; tests; bench design (dv_lead's
  WO-0009, running in parallel — do not touch test/** or tools/**).
## Task
Batch B plus the backlog the first freeze cycle accumulated. The §11
reconciliation comes first because a signed batch is sitting un-frozen
on its account.
## Return / verdict log
(architect appends on RETURNED)

### RETURNED — architect_docs_lead, 2026-08-02T07:40Z

- **State**: ISSUED → **RETURNED** (awaiting orchestrator commit, then the
  batch-B `ifc_check` run, then dv_lead's batch-B countersignature)
- **Journal**: `J-architect_docs_lead-0004`
- **Spawn short-id**: WO-0008/2026-08-02T05:55Z

#### Deliverable-by-deliverable disposition

| # | Deliverable | Disposition | Where |
|---|---|---|---|
| 1 | SPEC-TEMPLATE §11 amended; both batch-A §11 sections converted; C-10; `Ifc_check_axi64` → `Axi64_ifc` | **DONE.** Batch A carries zero OPEN items | `SPEC-TEMPLATE.md` §11, §7, §4.1; `template_ifc.ml`; SPEC-M01 §6.1, §11; SPEC-M02 §11 |
| 2 | requirements.md diffs: REQ-010 narrowing; C-8 (REQ-903); C-4 (REQ-105/110) | **DONE.** 110 REQs before and after; set equality with `traceability.md` re-verified | `requirements.md` REQ-010, REQ-903, REQ-105, REQ-110, §0.7 |
| 3 | C-1 resolution from dv_lead's (L + h)/8 proposal | **DONE — identity adopted, remedy differs.** Unit changed, allocation kept | `requirements.md` §0.5, §1.1, REQ-006, REQ-019; `architecture.md` §4; each spec §7 |
| 4 | ADR-0006, ADR-0007 | **DONE** | `docs/adr/ADR-0006-crc32-finished-value-ports.md`, `docs/adr/ADR-0007-octet-count-encoding.md` |
| 5 | traceability.md spec-target column | **DONE.** 53 rows filled (batch A + batch B), plus the invariant-row convention | `traceability.md` |
| 6 | SPEC-M03, SPEC-M04, SPEC-M05 + lifts; three design questions resolved | **DONE.** DRAFT, template-complete (§1–§13 all present), lifts byte-identical, M03 lift names the `Source` fields | `docs/specs/modules/xgmii_rx_64.md`, `xgmii_tx_64.md`, `eth_mac_10g.md`; three new `ifc_check` lifts |

**Files staged**: seventeen — this packet, the two ADRs, `SPEC-TEMPLATE.md`,
`architecture.md`, `requirements.md`, `traceability.md`, the five module specs
and the five `ifc_check` lifts (three new, `axi64_ifc.ml` and
`template_ifc.ml` edited). `docs/gates/**` deliberately untouched (PROTOCOL §7:
the orchestrator transcribes ledger and signature changes); `test/**` and
`tools/**` untouched (WO-0009 in flight).

#### 1. The §11 reconciliation, in one paragraph

A FROZEN spec may carry no **open question** — an item whose answer is unknown
and which blocks someone downstream. It MAY carry a **deferred item**: a
decision already made and stated in the spec's own normative sections, whose
remaining work is tracked elsewhere. Every deferred item must state where it is
tracked (a `C-n` ledger row or a WO id), **what a reader assumes meanwhile** in
one actionable sentence, and its owner and closing gate. An item that cannot
state the middle one is an open question whatever it is called. Item numbers
are permanent and closed items keep their rows, because `J-dv_lead-0003` and
two Return logs cite them by number.

Result: **SPEC-M02 — four items, all CLOSED.** **SPEC-M01 — 11.1, 11.2, 11.3
CLOSED; 11.4 and 11.5 DEFERRED** (the pending compile witness for
`hardcaml_axi`'s field names, and C-9's dv-owned record-versus-appendix
script), each with its "meanwhile" sentence.

#### 2. The four requirements.md diffs, enumerated

| Diff | REQ | Change |
|---|---|---|
| D-17 | REQ-010 | Subject narrowed to frame-carrying **stream** ports, defined as ports carrying frame octets *together with* `tvalid`, `tkeep`, `tlast`, `tuser`. M02's `data` named as the one frame-carrying non-stream port in the inventory, with REQ-306 as the reason. Verification column gains the converse check at M02 (its lift declares no stream record). Any further non-stream port is a spec diff, not a local reading |
| D-18 | REQ-903 | Split. **Every** inventory module owes an `.mli`; every module **whose role is not types-only** additionally owes `hierarchical` taking a `Scope.t`; M01 is named as the only types-only module and is excluded from the second half only. This is dv_lead's C-8 choice (b): exempt M01 from `hierarchical`, not from the `.mli`, because the `.mli` is what fixes M01's exported record set — the surface every other module's REQ-010 check binds to. The check becomes two determinable parts |
| D-19 | REQ-105, REQ-110, §0.7 | C-4. Both REQs now state the **zero-delivered-octet** case: no output word, **no `tlast` word to mark**, the strobe as the frame's only report, and frame conservation counting it under that strobe. REQ-105's case is an `/E/` at or before the first frame octet (including a preamble position); REQ-110's is a start character arriving inside the previous frame's own preamble. Verification columns gain both, and REQ-105's says explicitly that "every abort is marked on a `tlast` word" is a **false** assertion for these cases |
| D-20 | §0.5, §1.1, REQ-006, REQ-019 | C-1, below |

REQ count unchanged at 110; `traceability.md` row set still set-equal
(re-verified, evidence item 3 of `J-architect_docs_lead-0004`); the §12 strobe
appendix still 21 rows and SPEC-M01's `Status` record untouched.

#### 3. C-1 — the resolution, flagged for your explicit judgment

**dv_lead: this is the item the sponsor delegated to the two of us. Your
batch-B countersignature seals it, and nothing further goes to the sponsor.**

*Your identity is adopted verbatim and is now normative.* §0.5 gains a
**front offset h** (the octet times between a module's input measurement event
and the first octet it emits, measured at that input — the strip length, plus
the frame's first-octet position in the measured word) and a **word delay**
ΔC = (L + h)/8. I recomputed your stage-by-stage result before adopting it and
reproduce it exactly: under floor(L/8) the §1.1 ceilings admit word delays of
5, 5, 1, 8, 5 at a lane-0 start (**24 cycles — the whole budget**) and
6, 5, 1, 8, 5 at a lane-4 start (**25 — over it**).

*What I did differently.* The obvious remedy is to lower the five ceilings
until they fit under floor(L/8). I rejected it: that changes five numbers to
preserve a unit that is wrong, and the unit is what is wrong — floor(L/8) is
not additive, and the quantity REQ-006 measures is a **sum of word delays**. So
**the allocation stands (4/3/1/5/4 = 17, slack 7, budget 24) and the unit
changes to ΔC.** §1.1 becomes arithmetic instead of aspiration: a chain on
every ceiling costs exactly 17 cycles, and the per-module gate now measures the
quantity the top-level gate measures. I checked feasibility first — the five
stages need roughly 3, 3, 1, 4 and 2 cycles to do their jobs — so the
allocation is comfortable, not merely coherent.

*Two free checks fell out and are now normative.* (a) (L + h) SHALL be a
multiple of 8, so a spec pinning an impossible constant is caught by arithmetic
at freeze, before RTL. (b) The §0.5 start-lane bound is exactly
ΔC(lane 4) ∈ { ΔC(lane 0), ΔC(lane 0) + 1 }.

*Cost to your side*: the §1.1 comparison in a sign-off packet takes h from the
module spec and computes (L + h)/8 from the measured L. The tagger is
unchanged — it already records lane and byte position (your WO-0005 §(a)).

*If you disagree*, the alternative on record is lowering the ceilings; my M03
constants (below) survive either resolution, so this is not a blocker for batch
B's other content.

#### 4. Both copies changed together

`architecture.md` §4's ceiling table is the other copy and its own text
requires them to move together. It now carries the h column, the ΔC unit and
the reason. `architecture.md` §4's M01 row also now names the `Xgmii` record
and REQ-017 (see §5).

#### 5. The three deferred design questions — resolved

**(a) XGMII lane-pair type home (SPEC-M01 §11.1): homed in M01.** Batch B made
the cost visible exactly on schedule — M03, M04 and M05 all need the pair, M20
would have been the fourth restatement. `Xgmii = { d : 64; c : 8 }`, and the
prefixes `xgmii_rx` / `xgmii_tx` emit `xgmii_rxd`, `xgmii_rxc`, `xgmii_txd`,
`xgmii_txc` — REQ-017's exact names, which a longer field name could not
produce.

> **dv_lead, this one needs your explicit word.** It edits SPEC-M01 §4.1 —
> a section you countersigned at 22145b5. It is an *addition* (nothing you
> judged changed: `Status`, `Config` and the three header records are
> untouched), and it lands before the FROZEN flip, so your batch-B
> countersignature is the right place to cover it. I am flagging it rather
> than letting silence imply consent.

**(b) `octet_count` = 0 identity (SPEC-M02 §11.2): no, and no REQ-307.**
Writing M03's and M04's sequencing answered the question §11.2 deferred to
them: the running-CRC register has an **enable**, so a cycle covering no frame
octet is a cycle in which it holds and M02's result is ignored — no
update-by-zero reaches M02's ports. On whether to define the identity anyway
for totality: rejected, and the deciding argument is observability, not cost.
With 0 unconstrained an accidental zero produces a visibly wrong CRC in the
caller's own bench; with 0 defined as the identity the same accident is
indistinguishable from correct behaviour. §6.3 item 1 stands, DV still asserts
nothing outside 1–8, formal still assumes it. ADR-0007.

**(c) M03's FCS-check formulation (SPEC-M02 §11.4): the residue.** Seed
0x00000000 at the frame's first octet, update over every received octet
**including the four FCS octets**, compare the value covering the octet before
the terminate character against REQ-304's **0x2144DF1C**. Chosen because it
needs no capture register and — decisively — **no octet-order reassembly of the
received FCS**, the exact operation whose convention error this programme has
already paid for once. SPEC-M03 §6.3 records honestly that the comparison form
is the same function by REQ-304 and that no bench distinguishes them, so the
choice is specified rather than pretended to be observable.

#### 6. The three new specs — the contracts to read hardest

| | SPEC-M03 `Xgmii_rx_64` | SPEC-M04 `Xgmii_tx_64` | SPEC-M05 `Eth_mac_10g` |
|---|---|---|---|
| Latency | **L = 16 octet times (lane-0 start), 12 (lane-4)**; h = 8 / 12; **ΔC = 3 cycles at both lanes**, ceiling 4 | **8 octet times = 1 cycle**, first accepted word to start character (REQ-210) | **zero added**, both directions; ΔC = 0 |
| Key structural fact | the FCS is removed by `tkeep`/`tlast` placement in a fixed-delay pipeline, **never** by holding octets back — that is what makes REQ-103 and REQ-005 compatible, and it fixes payload storage at two words | an inserted preamble word is one output slot, which fixes storage at two words and makes `tready` bubble-free; 11 cycles per minimum frame follows from REQ-204's lane-0 rounding | §6.1's wiring table is **total**, and there is no wire between the receive half and the transmit half (REQ-208's structural half) |
| Strobes | five, pulse cycle pinned to the frame's `tlast` cycle (or where it would have been) | one, pulse cycle pinned to the cycle the word was required and not presented; the wire `/E/` follows two cycles later | none of its own; six relayed |

**Why ΔC = 3 at both start lanes, since it is the number everything else hangs
off.** To strip the FCS at constant latency M03 needs exactly one word of
lookahead, so output word 0 needs input through the second word after the start
word — at a lane-0 start (where output word 0 *is* an input word) and at a
lane-4 start (where it spans two) alike. Both lanes therefore emit output word
0 on the same cycle, which is why L differs by 4 octet times and ΔC does not.
(L + h) = 24 in both rows. I pinned 3 rather than the ceiling of 4 so the
hardest receive module keeps a cycle of its own.

#### 7. Rulings that are mine, not requirements.md's — please contest or confirm

1. **SPEC-M03 §9**: an error character **closes** the frame, so a start
   character after it begins a new frame and pulses **no**
   `error_start_without_terminate`.
2. **SPEC-M03 §9**: a start character during REQ-108's post-truncation discard
   is the resynchronisation REQ-108 demands, **not** a second abort, and pulses
   nothing.
3. **SPEC-M03 §9**: `error_runt` and `error_bad_fcs` **do** co-occur (a
   5–63-octet frame ends with a terminate character, so its FCS is checked);
   `error_bad_fcs` never co-occurs with `error_oversize`, `error_bad_frame` or
   `error_start_without_terminate`, because none of those frames has an FCS to
   check.
4. **SPEC-M04 §9**: on underflow the already-accepted words are transmitted
   **before** the `/E/`, because REQ-207 forbids dropping an accepted word. If
   you read REQ-207 as yielding to REQ-206, that is a requirements.md diff.
5. **SPEC-M04 §9**: **no FCS is appended** to an underflowed frame — appending
   one would put a well-formed short frame on the wire.
6. **SPEC-M03 §4.3**: REQ-810's receive half is implemented **in M03**, because
   it is the only place from which "no receive-path stream carries a word"
   follows without every module implementing the same control. The
   `traceability.md` row still names M20; SPEC-M20 will name M03.

#### 8. For the orchestrator — ledger dispositions to transcribe (`docs/gates/`)

I did not edit the checklist: PROTOCOL §7 puts gate-file edits with you.

| id | Disposition |
|---|---|
| C-1 | **CLOSED at this WO**, subject to dv_lead's batch-B countersignature — unit changed to ΔC = (L + h)/8, allocation unchanged (`requirements.md` §0.5/§1.1/REQ-006/REQ-019, `architecture.md` §4) |
| C-4 | **CLOSED** — REQ-105 and REQ-110 zero-delivered-octet wording, §0.7 extended |
| C-8 | **CLOSED** — REQ-903 split; M01 excluded from the `hierarchical` half only; SPEC-M01 §4.1 bullet corrected and a §10 REQ-903 row added |
| C-10 | **CLOSED** — REQ-013's "solely" restored in SPEC-M01 §6.1 with a §0.6 clause |
| C-5 | **still open**, and now explicitly harmless: SPEC-M04 §9 pins `error_underflow`'s cycle exactly, so nothing depends on §0.6's vacuous window. SPEC-M04 §11.3 tracks it |
| C-9 | **architect's half done** (SPEC-M01 §10's REQ-802/804 hooks now name the two mechanisms separately and attribute the field-list comparison to the dv-owned script); dv_lead's script lands under WO-0009. SPEC-M01 §11.5 tracks it |

**Batch-A FROZEN flip.** Blocked on nothing decidable. Both specs' §12 carry
the architect signature (`J-architect_docs_lead-0004`, conditional on the run)
and the dv countersignature reference; the two remaining rows are the
`ifc_check` run id for **this** commit and the SHA it cites (ADR-0005). Note
`axi64_ifc.ml` changed in this commit (the `Xgmii` record), so run 30727252770
at 22145b5 is **no longer** the right evidence for either batch-A spec — the
run on your commit is. The flip is then a two-row edit per spec plus the gate
table.

**No `dune` change is needed** for the three new lifts:
`docs/specs/ifc_check/dune` has no `(modules)` field, so they are picked up
automatically. Checked, not assumed.

#### DoD check against this packet

- Batch-A specs carry zero OPEN §11 items under the amended wording: **yes**.
- REQ/traceability set equality survives every requirements.md change:
  **yes** — 110/110, symmetric difference empty.
- The C-1 resolution is stated in one place and cross-referenced: **yes** —
  `requirements.md` §0.5, cited from REQ-006, REQ-019, §1.1, `architecture.md`
  §4 and each module spec's §7.
- Both ADRs cite their provenance: **yes** — ADR-0006 cites SPEC-M02 §6.1,
  WO-0006 and dv_lead's WO-0007 verification; ADR-0007 cites SPEC-M02 §11.2 and
  the batch-B modules that answered it.
- The three new specs are template-complete with byte-identical lifts:
  **yes** — sections 1–13 present in all three; the five spec/lift pairs
  compare equal byte for byte; all six lifts parse under `ocamlc -stop-after
  parsing`. Type checking and ppx elaboration have **not** run — hardcaml is
  not installed in this container and ADR-0005 makes CI the only acceptable
  evidence.
- `test/**` and `tools/**` untouched: **yes**.
- `git commit` / `git push`: never run.

### ACCEPTED — orchestrator, 2026-08-02T07:05Z, journal `J-orchestrator-0039`

DoD met at f78766e. Re-checks: REQ set equality 110/110; all five
spec-§4.1-to-lift identities byte-exact (including the two revised
batch-A lifts). Dispositions:
1. §11 reconciliation ACCEPTED as designed — but the batch-A FROZEN flip
   is further deferred, on the architect's own honest flag: axi64_ifc.ml
   changed after countersignature, so run 30727252770 is superseded and
   the SPEC-M01 §4.1 addition needs dv_lead's explicit post-signature
   judgment. Batch A flips FROZEN together with batch B at the WO-0010
   countersign, against fresh CI evidence.
2. C-1 resolution (unit changes, allocation stands, 7-cycle slack real
   again) NOTED — dv_lead judges it at WO-0010 per the sponsor mandate.
3. The six §9 rulings that are the architect's own are enumerated for
   dv_lead's judgment in WO-0010's packet.
4. Ledger: C-4, C-8, C-10 addressed in this commit (dv confirms at
   WO-0010); C-11 (REQ-015 one-word-frame contradiction, dv_lead's own
   wording, found by dv_lead) added — architect disposes in the next
   spec-diff round or WO-0010 contest loop.
