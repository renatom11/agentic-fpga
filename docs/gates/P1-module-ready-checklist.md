# Gate: P1-module-ready

**Status: OPEN — opened 2026-08-11.** One Phase-1 module carries a `PASS`
sign-off (`SO-xgmii_rx_64`, M03); nineteen do not. This file exists now, ahead of
the gate convening, because two obligations already name it as their carrier: the
collation half of the programme's first lessons harvest (ADR-0018 A2-D1, deferred
here **by name** at `SO-xgmii_rx_64.md` §4.10) and the module-ready homes of eight
specification deferrals. **A gate whose checklist is written after its evidence is
a gate that grades itself.**

Signatures below are **journal-entry references** and are transcribed by the
orchestrator from the signing agent's own journal entry (PROTOCOL §7). Nothing in
this file is signed by its author, and **no box in this file is checked by its
author**.

---

## 0. What this gate is, and what this file may not do

### 0.1 The conditions, quoted rather than paraphrased

PROTOCOL §7's table gives this gate's precondition in one sentence. Its
`P<n>-module-ready` row's *Precondition to pass* cell is quoted here **verbatim**,
so that every row below can be traced to a clause of it:

> Per-module DV sign-off packets (`SO-*.md`) PASS; auditor's seeded mutations all
> killed by the DV suite; line-rate stress green for rx-path modules.

Three clauses: **(a)** the sign-off packets, **(b)** the mutation record, **(c)**
the line-rate stress. PROTOCOL §7's lessons-harvest paragraph adds a fourth,
stated there as a gate condition and not as a follow-up:

> A gate is not passed while any box of the instantiated
> `docs/gates/lessons-harvest-block.md` is unchecked.

Two further conditions are owed to this gate by **normative requirements** rather
than by the constitution — REQ-903's repository-surface check and REQ-904's
traceability currency, each of which names "each module-ready gate" / "its owning
module's `P1-module-ready` gate" in its own verification column (§5 below).

### 0.2 This file states no condition its cited source does not contain

**Stated first, because this instrument's own family has failed exactly here.**
`docs/gates/lessons-harvest-block.md` line 5 extended PROTOCOL §7's gate condition
to module sign-offs while citing §7 for the extension; the constitution never
contained the clause. The over-reach produced `FINDING SO-5`, cost a sign-off two
rounds, and was repaired by ADR-0018 Amendment A2 (§A2.1) with the diagnosis
*"the packet quoted its source accurately; the source was wrong."*

So, for this file:

1. **Every condition below cites the artefact that creates it**, and where the
   citation is a quotation it is marked as one.
2. **Where the record and a source's wording do not line up, the discrepancy is
   recorded as an open gate item with an owner and a closing event** (§9) — it is
   **not** resolved by re-wording it here. A checklist that settles a
   constitutional reading in its own prose is the A2.1 defect repeated.
3. **This file adds no condition of its own.** Its §6 rows are homed here by the
   specifications that deferred them; its §9 items are questions, not conditions.

### 0.3 Who fills what

| Cell class | Filled by | Authority |
|---|---|---|
| Structure, citations, the questions in §9 | architect_docs_lead (`docs/gates/**` is its write scope, PROTOCOL §6) | this file's own journal entry |
| Every signature cell | **orchestrator**, transcribing | the cited `J-<agent>-NNNN` entry, which must itself say "I sign gate X item Y" (PROTOCOL §7) |
| The harvest tables and all eleven boxes (§7) | **orchestrator as collator** | each row's cited journal entry (ADR-0018 §4.1, A2-D4) |
| The mutation N/N record (§3) | **orchestrator**, transcribing the auditor's committed report | the auditor's `docs/reports/audit/**` artefact and its journal entry (auditor charter §3; ADR-0003's auditor exception, PROTOCOL §3) |
| The DV evidence cells (§2, §4) | orchestrator, transcribing from the `SO-` packet | the packet and its signing entry |

**dv_lead, rtl_lead and the auditor cannot stage `docs/gates/**`** (PROTOCOL §6).
That is why every cell here has an off-file authority, and why a cell disagreeing
with its authority is a defect in this file and never in the authority.

---

## 1. Scope — the modules this gate reads

The inventory is `docs/specs/architecture.md` §4: **twenty modules, M01 … M20**,
all twenty FROZEN at `P1-spec-freeze` (CLOSED 2026-08-02T16:53Z). This gate is
**phase-level**: it convenes once, over the phase's modules, and PROTOCOL §7's
clause (a) is plural. It is not a per-module ceremony.

**Which modules owe an `SO-` is not pinned by any artefact measured at this
file's landing** — see `G-2` in §9. Three candidate classes exist and the
distinction is real, not clerical: M01 `Axi64` is types-only and instantiates
nothing (REQ-903 excludes it from the `hierarchical` half **by name**); M05, M16
and M19 are structural wrappers whose stress obligation REQ-905 discharges
through their children; the remaining sixteen are ordinary. The table below
therefore lists all twenty and marks the question rather than answering it.

### 1.1 Per-module record

`SO-` = the sign-off packet and its verdict token. `Mut` = the mutation record
(§3). `Stress` = the line-rate stress row, **owed only by REQ-905's list** (M03,
M06, M08, M10, M14, M17, M20 — `n/a` elsewhere, and a wrapper joins the list only
by spec diff). `RTL` = whether an implementation exists at this file's landing.

| # | Module | RTL | `SO-` | Verdict | Sign-off SHA | Mut | Stress | Row state |
|---|---|---|---|---|---|---|---|---|
| M01 | `Axi64` | types | — | — | — | — | n/a | see `G-2` (types-only) |
| M02 | `Crc32_eth` | yes | — | — | — | — | n/a | not started |
| M03 | `Xgmii_rx_64` | yes | [`SO-xgmii_rx_64.md`](../../agents/handoffs/SO-xgmii_rx_64.md) | **PASS** (one token, 14/14) | `41fead6` | §3.1 | §4.1 | **DV rows supplied** |
| M04 | `Xgmii_tx_64` | yes | — | — | — | — | n/a | not started |
| M05 | `Eth_mac_10g` | yes | — | — | — | — | n/a (wrapper) | see `G-2` |
| M06 | `Eth_axis_rx` | no | — | — | — | — | owed | not started |
| M07 | `Eth_axis_tx` | no | — | — | — | — | n/a | not started |
| M08 | `Eth_demux` | no | — | — | — | — | owed | not started |
| M09 | `Eth_arb_mux` | no | — | — | — | — | n/a | not started |
| M10 | `Arp_eth_rx` | no | — | — | — | — | owed | not started |
| M11 | `Arp_eth_tx` | no | — | — | — | — | n/a | not started |
| M12 | `Arp_cache` | no | — | — | — | — | n/a | not started |
| M13 | `Arp` | no | — | — | — | — | n/a | not started |
| M14 | `Ip_eth_rx_64` | no | — | — | — | — | owed | not started |
| M15 | `Ip_eth_tx_64` | no | — | — | — | — | n/a | not started |
| M16 | `Ip_complete_64` | no | — | — | — | — | n/a (wrapper) | see `G-2` |
| M17 | `Udp_ip_rx_64` | no | — | — | — | — | owed | not started |
| M18 | `Udp_ip_tx_64` | no | — | — | — | — | n/a | not started |
| M19 | `Udp_complete_64` | no | — | — | — | — | n/a (wrapper) | see `G-2` |
| M20 | `Nic_top` | no | — | — | — | — | owed | not started |

**The gate does not convene while any row of this table is unresolved** — either
carrying a `PASS` with its three DV rows, or excluded from clause (a) by the
ruling `G-2` asks for. **An empty row is not a satisfied row.**

---

## 2. The DV rows — what this gate reads from an `SO-`

An `SO-` is a **packet and a merge precondition** (PROTOCOL §3), not a gate
decision and not a gate signature; `SO-xgmii_rx_64.md` §8.R4.2 states this against
itself. What this gate takes from one is exactly five things:

1. **The verdict token.** One token, `PASS`, with no qualifier and no "subject
   to". A qualified `PASS` is not a `PASS` — the packet's own `SC-14`.
2. **The sign-off SHA** and the signing journal entry, so every measurement in the
   packet is re-runnable at a commit.
3. **The mutation record** as reported (§3).
4. **The line-rate stress result**, where REQ-905's list obliges one (§4).
5. **The bound list**, if the packet carries one.

### 2.1 A bound is not a qualifier — how this gate reads a bound list

`SC-14`'s own second sentence: *"Everything the module has not earned is a listed
bound inside a `PASS`, or it is a `FAIL`."* **A bound therefore does not weaken
the token, and this gate may not read one as if it did.** What a bound does is
tell the gate what the evidence does **not** reach — which is gate information,
because some of it lands on gate rows.

The rule this file uses, so the reading is fixed before there is an interest in
it: **each bound is dispositioned into exactly one of three** — `NOT A GATE ROW`
(it bounds a claim no gate condition makes), `GATE ROW, SATISFIED ELSEWHERE`
(cite where), or `OPEN GATE ITEM` (carried in §9 with an owner). **A bound is
never dispositioned by being quoted.**

### 2.2 M03 `Xgmii_rx_64` — the row as supplied

Every cell cites the packet; nothing here is a signature.

| item | value | source |
|---|---|---|
| Verdict | **PASS** — one token, fourteen of fourteen criteria MET | `SO-xgmii_rx_64.md` §8.R4, §1.4 |
| Signed | `J-dv_lead-0168`, dv_lead | §8.R4 |
| Sign-off SHA | `41fead6` (packet landed `69f1475`) | §8.R4 |
| Prior tokens | two honest `FAIL`s (`2183d71`, `14615f8`), both preserved quoted beneath the live verdict | §8.0 … §8.3 |
| CI at the sign-off SHA | `build` run `31453108454`, job `93661268366`, thirteen steps `success`; `cosim` job `93661268386` `success`, quoted separately; `journal-check` run `31453108435` `success` | §2.9-R2 |
| Attack-plan census | 78 rows = 62 `ASSERT` + 7 `NO-ASSERT` + 4 `NO-STIMULUS` + 4 `STRUCTURAL` + 1 `GAP` | §2.1-M, §2.12 |
| Open `BUG-` | none — measured over the `agents/handoffs/BUG-*.md` glob | §2.11, §2.12 |
| Traceability rows delivered | 34 of this module's hooks transcribed | §2.8-R |
| Bound list | twelve bounds, §8.R4.4 | dispositioned at §2.3 |

### 2.3 M03's twelve bounds, dispositioned per §2.1

| # | the bound, short | disposition at this gate |
|---|---|---|
| 1 | The charter §3 **external anchor is undischarged as a module-level anchor**; the co-simulation anchors classes, one of them | **OPEN GATE ITEM `G-10`** — PROTOCOL §10 requires an external anchor before a golden model may judge RTL; whether that binds at module-ready or at phase-accept is the question, not the fact |
| 2 | `dune runtest` cannot execute in this container (ADR-0005), so suite evidence is a CI run id | **NOT A GATE ROW** — ADR-0005 is the programme's accepted execution posture; the run ids are cited at §2.2 |
| 3 | "Zero rx backpressure asserted" discharged **structurally**, not observed | **GATE ROW, SATISFIED ELSEWHERE** — §4.1; REQ-003's verification column commissions exactly the structural check |
| 4 | The mutation era has **one survivor**, `G-c4`; the column stays 1 | **OPEN GATE ITEM `G-1`** — this is clause (b)'s wording against the measured column |
| 5 | One attack-plan row is a declared `GAP` (`M03-O2`); four `NO-STIMULUS`, four `STRUCTURAL`, seven `NO-ASSERT` | **NOT A GATE ROW** — no gate condition quantifies over plan rows; recorded because a coverage claim built on 78 would be false |
| 6 | Five landed green assertions are **unreachable by any mutation** (`U-1` … `U-5`, `DECLARATION WO-0074-D1`) | **OPEN GATE ITEM `G-9`** — it bounds any N/N reading that counts such an assertion as an observation |
| 7 | Co-simulation **Stage 3 is refused**; REQ-901's (g)/(h) reduce what the lane can anchor | **NOT A GATE ROW** — no gate condition names Stage 3; it is an input to `G-10` |
| 8 | The traceability matrix is **34 of 110** populated; 76 empty, 97 `OPEN` | **OPEN GATE ITEM `G-4`** — REQ-904 and charter §6 both bind currency to this gate |
| 9 | **Five findings unrepaired**, carriers unopened: `SO-2`, `SO-3`, `SO-4`, `M-4`, `P-1`'s residue | **OPEN GATE ITEM `G-8`** |
| 10 | **The harvest's collation has not happened** — no `L-` id, no shell commit, no sponsor sight, no completeness declaration at `41fead6` | **GATE ROW — this gate is the named carrier** (§7.1). *[annotated 2026-08-18] The bound stands as the packet measured it at `41fead6` and is not rewritten; three of its four terms name a mechanism the law retired on 2026-08-17, so the **disposition** is re-pointed to the current Part B (ADR-0023 D3, D5; block as amended). The collation **has now happened, locally**: `docs/LESSONS.md` landing H1, commit `5d2264d`, collator's entry `J-orchestrator-0306`. Term by term — the landed ids are the candidates' own, seat-qualified and **unrenumbered**, so no separate `L-` id is awaited; **no shell commit is owed** (D3); **sponsor sight retires with the transit it gated** (D4); the **completeness declaration is still owed here** (§7.1, box 11). What this gate re-verifies is the **landing and the dedup record**, per A2-D3 and D5* |
| 11 | `OBSERVATION SO-O1` — two of eighteen candidates in one seat's note carry a version-control tool noun under a stated `LH2-g` | **OPEN GATE ITEM `G-6`**, routed to the collator's hide test at gate-time transcription |
| 12 | **Thirty of forty `tb_writer` entries carry no harvest note** (`-0001 … -0020`, `-0031 … -0040`) | **OPEN GATE ITEM `G-5`** — it lands on box 1's tiling claim for the worker row |

---

## 3. The mutation record — PROTOCOL §7 clause (b)

**Sequencing, quoted from PROTOCOL §10**: the auditor authors the manifests; the
orchestrator applies each transiently and reverts; *"for each module, the campaign
runs **after** rtl_lead's `RV-` ACCEPT and **before** dv_lead may issue `SO-`
PASS, so every PASS reports kills N/N (N ≥ 3, spanning distinct defect classes)
and `module-ready` merely re-checks it."* The auditor's charter §3 adds: *"You
record N/N results in the gate checklist"* — recorded here, transcribed by the
orchestrator under ADR-0003's auditor exception, because the auditor stages
`docs/reports/audit/**` and nothing else.

**This gate re-checks; it does not re-run.** A campaign re-run at gate time would
put mutated RTL in the tree after a sign-off, which §10 forbids and ADR-0019
re-homed onto a transient branch.

### 3.1 M03 — the record as reported

| era | sealed | killed | survived | green-by-blindness | void | source |
|---|---|---|---|---|---|---|
| Class-based campaigns `WO-0050` … `WO-0077` (ten) | **63** | **61** | **1** (`G-c4`) | **0** | **1** (`IC-M5`) | `SO-xgmii_rx_64.md` §2.2-M, walked campaign by campaign |
| Pre-class era, scored in a different unit (the mutation, not the class) — `WO-0039` 5/5, `WO-0041` 4/4 on the killable set with `D-M3` ruled an **equivalent mutant** and excluded from the denominator, `WO-0042`'s `D-M6` killed exact on both required cells, `WO-0045` 5/5 | — | **15 of 15** | — | — | — | §2.2-M; aggregate re-read at `SC-5` |

**Re-measured at the sign-off SHA and unmoved, with the negative half stated**:
`docs/reports/audit/` is byte-identical at `41fead6`, *"so no manifest was authored
and no campaign ran in the interval — no new class to kill and none to fold"*
(`SC-5`). **The tally is not a fresh campaign's output; it is the same one,
re-read.**

**The four columns are not folded and no ratio is formed**, on the packet's own
ground: *"collapsing a never-rendered class into 'killed' would overstate coverage
and into 'survived' would libel a bench that was never given anything to catch."*
The survivor's defect is separately **measured dead at the repaired bench** (run
`30852220315`), and the packet reports the two facts side by side rather than
folding them.

**The reading this gate needs, and does not take here**: clause (b) says *"all
killed"* and §10 says *"N/N"*; the measured column is 61 of 63 with one survivor
and one void. Whether a survivor whose defect is dead at a repaired bench, and a
void that was never rendered, satisfy the clause is **`G-1`** — an open gate item
with an owner, not a sentence in this file (§0.2).

---

## 4. The line-rate stress — PROTOCOL §7 clause (c)

The normative definition of "receive path" and the **by-name list of modules owing
a stress bench** is `requirements.md` §0.4 / REQ-905: **M03, M06, M08, M10, M14,
M17, M20**. Structural wrappers M05, M16, M19 are covered by their children unless
the wrapper introduces datapath logic of its own, *"which puts it on the list by
spec diff"*. REQ-905's own verification column makes this gate's question
checkable: *"Sign-off packets list the stress test per module against that
enumeration."*

REQ-004 fixes what green means: ≥ 10 000 consecutive 64-octet frames at minimum
IFG, start lanes alternating, **frames-out equals frames-in, payload octets
compare equal, per-octet latency constant, frame conservation holds**.

### 4.1 M03 — the row as reported

| item | value | source |
|---|---|---|
| Bench row | `M03-L1` — 10 000 consecutive 64-octet frames, start lanes alternating 0/4, start-to-start 10/11 cycles (minimum IFG), all eight output words asserted per frame, sixty delivered octets read positionally, empty strobe set | `SO-xgmii_rx_64.md` §2.10 |
| Result | **green** at the sign-off SHA — `build` run **`31453108454`**, step 6, subject byte-identical (`test/` blob `9a8871c89d36`); first taken at `2183d71` in run `31444471834`, job `93635620822`, step 6. The unit's own guard asserts the schedule carries exactly `10_000` frames before the DUT is read | §2.10, `SC-4` |
| Latency constants | `M03-L2` L = 16 at h = 8 and L = 12 at h = 12, word delay `Some 3` in each class; `M03-L3` whole-run ΔC = 3 against the §1.1 ceiling of 4 | §2.10 |
| Zero rx backpressure | **STRUCTURAL, not observed** (`M03-L6`): the stream under test exposes no `tready` and none exists, so there is no signal a consumer could assert — REQ-003's own verification column commissions the interface check | §2.10, bound 3 |
| Not covered by the green | `M03-L3`'s ΔC content is discharged by derivation, not by the run (`U-2`); `M03-L4`'s sequence read-back is qualified by citation to `M03-L1` or not at all (`U-1`) | §2.10, `G-9` |

---

## 5. The mechanical repository rows

These are not PROTOCOL §7 clauses; each is a **normative requirement whose own
verification column names this gate**. They are listed so the gate has a
determinable answer rather than an argument.

| Row | What is checked | Source | State |
|---|---|---|---|
| **REQ-903 (a)** | An `.mli` exists for **every** inventory module, M01 included | `requirements.md` REQ-903; implemented in `tools/check_emitted_verilog.sh`, run from `tools/dv_checks.sh` at CI `build` step 9 | **runs every build; currently PENDING** — the script reports how many of the twenty inventory modules have an `.mli` and names the unbuilt ones. Its own note: *"REQ-903 passes only when this list is empty; that is a `P1-module-ready` condition"* |
| **REQ-903 (b)** | `hierarchical` is exported by every inventory module **except M01** — the exclusion list is one name, stated so the check has a determinable answer | same | same run; the M01 exclusion is checked as an exclusion, not assumed |
| **REQ-904** | Exact set equality between the REQ id set of `requirements.md` and the row id set of `traceability.md`, run in CI so currency is continuous | `requirements.md` REQ-904 | **the commissioned script does not exist.** `traceability.md`'s own REQ-904 row carries an **empty `Test(s)` cell** and reads `OPEN`, naming *"the CI set-equality script requirements.md REQ-904's verification column commissions"* as the thing it is waiting for. **A gate condition whose instrument is unbuilt is `G-4`** |
| **Traceability split** | REQ-001 … REQ-021 and REQ-801 … REQ-810: how system-level coverage divides between `nic_top` system tests and per-module restatements — *"the architect and dv_lead agree the split at the first module-ready gate"* | `traceability.md` Open dependencies item 3 | **owed at this gate**; M03's half is already on the record per row (16 programme-invariant rows plus REQ-802/808/810 carry an `M03:`-prefixed cell and stay `OPEN`) |
| **`PARTIAL` question** | Whether a third `Status` value is minted for a row whose module-side contributions exist and whose own test does not | `traceability.md`, ruled at WO-0079 to be **this gate's** to decide; the 21 rows the rule governs are its candidate set | **owed at this gate** |

---

## 6. Specification items homed at this gate

Eight `§11` deferral rows name a module's `P1-module-ready` as their disposition
gate. Each is a decision already made and stated; what is owed here is the
**review of the deferral**, not a re-litigation.

| Spec | Row | The item | Owner |
|---|---|---|---|
| SPEC-M06 `eth_axis_rx.md` | 11.2 | M06 is pinned **exactly at its §1.1 ceiling** (ΔC = 3 of 3), no reserve; a repair would be a slack release, never a local decision | architect_docs_lead |
| SPEC-M14 `ip_eth_rx_64.md` | 11.2 | M14 pins ΔC = 4 against a ceiling of 5 — one cycle of **module** reserve, not programme slack | architect_docs_lead |
| SPEC-M15 `ip_eth_tx_64.md` | 11.2 | The two-cycle resolution wait is charged to **every** datagram, including broadcast destinations needing no cache — deliberately uniform | architect_docs_lead |
| SPEC-M17 `udp_ip_rx_64.md` | 11.2 | M17 pins ΔC = 2 against a ceiling of 4 — the largest reserve on the chain; re-allocating it is deliberately **not** done in the spec | architect_docs_lead |
| SPEC-M19 `udp_complete_64.md` | 11.2 | Fifteen strobes as fifteen scalars; aggregation happens exactly once, at M20 | architect_docs_lead |
| SPEC-M19 `udp_complete_64.md` | 11.3 | The three REQ-506 parameters forwarded through four levels with defaults restated at each — recorded so a fifth restatement is noticed as a cost | architect_docs_lead |
| SPEC-M20 `nic_top.md` | 11.2 | REQ-806 wants **measured** end-to-end figures; §7 derives 13 cycles / 83.2 ns from five pinned constants. *"A measured figure that differs from 13 is a defect, not a correction"* | architect_docs_lead, dv_lead |
| SPEC-M20 `nic_top.md` | 11.3 | Eleven of REQ-006's twenty-four cycles unspent (7 slack + 4 module reserve) while §1.1 still allocates 17 — *"the right moment to tighten §1.1 is after the first `P1-module-ready`"* | architect_docs_lead |

**The `P1-spec-freeze` carry-forward ledger is a separate instrument and is not
duplicated here.** Its rows close on their own named artefacts — several on
`SO-` packets by name (`C-2`, `C-38`, `C-43`, `C-44`, `C-45`, `C-46`, `C-47`,
`C-49`, `C-50`), others on benches. The gate reads the ledger's **open set** as an
input to `G-3`; it does not re-home any row.

---

## 7. The lessons harvest

**Two harvests are ratified at this gate**, and this is the first time in the
programme that a gate carries more than one. A2-D5 fixes the consequence in
advance. **What this paragraph said until 2026-08-17, kept as written**:

> A2-D5 fixes the consequence in advance: *"They are transcribed as several
> commits, one per harvest, in harvest order"* — never one commit per gate,
> because the sponsor's review stays one diff **per harvest**.

*[annotated 2026-08-18] A2-D5 was **restated, not deleted**, on 2026-08-17
(ADR-0023 D3), and this paragraph is re-quoted to the restatement here.* The
**count** and the **ordering** survive; the **site** moves inside this
repository; and the rationale clause —
the sponsor's per-harvest diff — does not survive at all, because the review it
named retires with the transit it reviewed (D4). **A2-D5, as restated**:

> **one local landing commit per harvest, in this repository — never one per
> gate.** Several harvests ratified at one gate land as several commits, one per
> harvest, in harvest order.

**The property the count buys is unchanged, and it is the reason the count was
fixed**: the record reads as a **list of harvests** rather than as a stream of
edits. Harvest 1's landing commit is **`5d2264d`**; harvest 2's is owed and
unlanded.

| # | Harvest | Trigger | Part A | Part B |
|---|---|---|---|---|
| 1 | `SO-xgmii_rx_64` | the module sign-off, `PASS` at `41fead6` | **checked at the packet**, seven of seven, `SO-xgmii_rx_64.md` §4.10 | **owed here** — §7.1 |
| 2 | `P1-module-ready` | this gate | **owed here** over this gate's own spans — §7.3 | **owed here** — §7.3 |

**Harvest 1's Part A is not re-checked here and harvest 2's Part A is not
inherited from it** (A2-D3): different triggers, different spans. A gate whose
Part A cites a sign-off packet instead of the notes for the gate's own spans is
A2.8's first named failure mode.

### 7.1 Harvest 1 — `SO-xgmii_rx_64`, Part B (the four collation boxes)

Deferred here by name at `SO-xgmii_rx_64.md` §4.10 — **quoted as the packet froze
it at `41fead6`, and left unedited because a signed packet is a dated record**:

> **Part B — collation, deferred to `P1-module-ready`.** Shell transcription, the
> `LC-`/`LD-` → `L-` pairing, sponsor visibility and the completeness declaration
> are the collator's acts at the gate that ratifies this harvest (ADR-0018 §4.2,
> §4.4, D6; A2.2).

*[annotated 2026-08-18] Two of those four acts no longer exist.* The deferral line's
current form is `docs/gates/lessons-harvest-block.md` §3 **as amended**
(ADR-0023 §5.2), and it is the form **this gate owes**, because a gate
instantiates the block **as it stands at the gate** and not as it stood at the
deferral (block §1, A2-D2). Quoted with the block's `<gate>` field filled with
this gate's name, which is instantiation and not an edit:

> **Part B — collation, deferred to `P1-module-ready`.** The local landing, the
> `LC-`/`LD-` → `L-` pairing, the dedup record and the completeness declaration
> are the collator's acts at the gate that ratifies this harvest (ADR-0018 §4.2,
> A2.2; ADR-0023 D1, D3).

**The count is unchanged at four and exactly one act is swapped**: *shell
transcription* becomes *the local landing*, and *sponsor visibility* — a power
over a movement that no longer happens — is **retired outright**, its seat taken
by *the dedup record* (ADR-0023 D4, §5.2). **Not one Part A box moves** (A2.3),
and Part A is not re-checked here in any case (§7 above, A2-D3).

**Transit state at this file's landing (2026-08-11), kept as written and now
historical** — read at source and not carried from a summary,
`agents/handoffs/HT-01_first-harvest-transit.md` was **EXECUTED**:

- The collation is committed at `HT-01` — census of seven minting chains,
  extraction byte-verified per chain with an independent 14-of-14 fidelity sample,
  cross-seat merge walk (zero cross-seat merges), seeded-corpus walk (four true
  merges, seeded statement surviving each), mechanical hide test over all 353
  (zero project-noun hits).
- The **export packet** is committed in this repo at
  [`docs/federation/outbox/SO-xgmii_rx_64.md`](../federation/outbox/SO-xgmii_rx_64.md)
  — 353 candidates, 352 tier-1 `LC-` rows and one tier-2 `LD-` row (pack
  `version-control`), statements verbatim, ids seat-qualified and unrenumbered.
- The **inbox PR is open** at the generic shell:
  `renatom11/generic-agentic-fpga-org` **PR #3**, one PR, one file, inside the
  perimeter, base `main` at `2ad82c3`. It is a **delivery vehicle, never a merge
  candidate**: the maintainer stages, screens, transcribes with fence-allocated
  final ids, merges by hand, and closes the PR.

*[annotated 2026-08-18] The three bullets above are true of 2026-08-11 and stay as the
record of what happened; the second and third describe a mechanism retracted
before it landed anything anywhere.* **State now**, read at source — `HT-01` §6,
the packet's own appended disposition note, and ADR-0023 D5:

- **PR #3 is closed unlanded** by the shell's maintainer, citing the shell's own
  ADR-0018. **The maintainer's id-mapping table the old box 9 waited for will
  never arrive**, and no shell commit is owed by this harvest or any other
  (ADR-0023 D3 — the `HT-` form is retired as a class and no `HT-02` will exist).
- **The 353 candidates landed locally** on 2026-08-17 as landing **H1** of
  [`docs/LESSONS.md`](../LESSONS.md) — the travel copy — seeded **verbatim** from
  the frozen outbox packet, A2-D8's no-statement-edited bar applied unchanged.
  Landing commit **`5d2264d`**, collator's entry **`J-orchestrator-0306`**.
- **The outbox file stays frozen in place** as the record of the one delivery
  ever performed (ADR-0023 §6.3); this repository deletes nothing it did.

**The four boxes, wording taken verbatim from the block as amended (ADR-0023
§5.2), each with what it reads here.** No box is checked by this file's author
and no evidence field is filled by it (§0.3); what is supplied below is the
citation each box's checker reads.

- [ ] **Local landing: exactly one commit**, transcribing this harvest's
      admissible candidates — general and domain — into `docs/LESSONS.md`, and
      nothing else. Commit: `<sha>`
  - *Reads*: **`5d2264d`**, collator's entry `J-orchestrator-0306` — **checkable
    now**, and the first Part B box in this programme's history whose evidence is
    in this repository. One commit, one harvest: it carries H1's 353 and nothing
    of harvest 2's, whose landing is owed separately (A2-D5 as restated, §7
    above). **The "and nothing else" clause is about what is transcribed, not
    about the commit's file list**, and the citation for that is the amending
    record itself: `5d2264d` also carries `tasks/BOARD.md` and `HT-01`'s
    disposition note, and ADR-0023 §6.1 directs that note into *"the same commit
    as … the one that seeds the file"* while §7 row 4 homes the board's
    re-pointing in the same round (the fourth path is the collator's own journal,
    which R2 obliges). A collator meeting a four-path commit reads the clause
    against the file's contents, where what it excludes is another harvest's
    candidates. *(The box this one replaced, and its `Reads`, are kept verbatim
    beneath the four — nothing here is erased.)*
- [ ] **`LC-`/`LD-` → `L-` pairs recorded** in the Yield table's Disposition
      column, with **ids local, seat-qualified and unrenumbered** (A2-D6,
      A2-D7), so each landed entry is traceable back to the note that minted it.
  - *Reads*: the pairing is an **identity**, and the box's own clause is why —
    ids land *unrenumbered*, so a candidate's landed id **is** its minted id
    (`LC-SO-xgmii_rx_64-7` landed as `LC-SO-xgmii_rx_64-7`; `docs/LESSONS.md`
    states in its own front matter that these *"are this file's landed local
    ids"*). Traceability is therefore carried by the id itself plus each seat
    section's header, which cites the minting note and its span. **The site of the
    record is off-file, exactly as it was before**: harvest 1's Yield table is the
    packet's, frozen at signing, so this box has always read an authority outside
    this file — it read the maintainer's promised mapping, and it now reads the
    landed file. **A pairing invented on this side is still barred**; what changed
    is that nothing needs inventing. *The box's `L-` spelling is the retired
    fence's naming and is vestigial under the identity — the reading rests on the
    unrenumbered clause, not on the prefix.*
- [ ] **Dedup against the file recorded**: every candidate checked against what
      `docs/LESSONS.md` already holds, and the outcome recorded on its row.
      Dedup is clerical — a drop carries its reason; composition is selection
      and is never performed (A2-D8, §4.1).
  - *Reads*: harvest 1 is the **first** landing and the file it landed into was
    **created by the landing commit**, so *what the file already holds* is the
    empty set and the outcome is one whole-set fact rather than 353 distinct
    ones: **353 landed, none deduped, none dropped**, against the file's own
    stated baseline (*"Baseline: none inherited"*) and census. **The four merge
    pre-judgments are the one place a drop could have hidden and did not**:
    `HT-01` §3.3 judged four candidates as merging to seeded entries of the
    **shell's** corpus, and those partners live in a repository this programme
    inherits nothing from — so all four landed as ordinary entries carrying the
    pre-judgment as a **recorded annotation**, reason stated (ADR-0023 §6.2).
    **What the collator checks is whether the whole-set form answers a box
    written for per-row outcomes**; over an empty file the answer is determinate
    either way, and this is both the first exercise of this box and the last
    trivial one — harvest 2 lands against a file holding 353 entries (§7.3).
    *This box took the retired* **Sponsor-visible** *box's seat; that box, its
    `Reads` and the whole reading behind it are kept — beneath the four, and at
    §7.2.*
- [ ] **Harvest declared complete** by the orchestrator: `J-orchestrator-NNNN`.
  - *Reads*: **the declaration is owed at this gate, and `J-orchestrator-0306`
    does not discharge it.** Adjudicated here rather than left implicit, because
    the landing entry is the obvious candidate and reads close enough to be
    mistaken for one. Three grounds. **(i)** `J-orchestrator-0306` declares
    *"Part B of harvest 1 is DISCHARGED locally"*, which is a statement about the
    **act**; box 11 is a declaration about the **harvest**, and a harvest is
    complete only once the boxes constituting it are checked at the gate that
    ratifies it. **(ii)** A2-D3's principle — a gate inherits no box from another
    trigger — is why a landing is *evidence the boxes read* and not the check
    itself; ADR-0023 D5 says exactly this of exactly this landing, discharging
    the obligation to land and providing that it is *"re-verified at
    `P1-module-ready` exactly as A2-D3 already provides"*. **(iii)**
    `J-orchestrator-0306`'s own Outcome names *"the `P1-module-ready` checklist's
    own §7.1 re-quote"* as work still outstanding — **an entry recording this
    gate's record as still quoting a retired law cannot be the entry that closes
    this gate's last harvest box.** What is owed: a **fresh orchestrator entry,
    written at the gate**, declaring harvest 1 complete in the collator's own
    words and citing the landing entry and the three boxes above. *(The
    counter-reading, recorded because it was weighed: a second declaration adds
    ceremony to an act already performed. It is rejected because the second
    declaration has content the first cannot have — it asserts three boxes
    checked **against this record**, and it is the entry the auditor samples for
    this gate.)*

**The four boxes as this file rendered them from 2026-08-11 to 2026-08-18, kept
verbatim and superseded in place** — a live gate record annotates and never
erases, and the second of these carried a ruling (*"checked against the
maintainer's returned mapping and against nothing else"*) that a later reader of
this record's history may need to see as it stood:

> - [ ] **Shell transcription: exactly one commit**, containing the admissible
>       candidates — general and domain — with permalinked provenance, and nothing
>       else. Commit: `<link>`
>   - *Reads*: this repo's side is the outbox commit `7fb2c99`. **The shell's side
>     is counted at the shell** — whatever protocol-conforming commits its
>     maintainer lands under its own law, since the foreign PR is never merged.
>     One harvest, one shell commit; harvest 2 gets its own (A2-D5).
> - [ ] **`LC-`/`LD-` → `L-` pairs recorded** in the Yield table's Disposition
>       column, so each shell entry is traceable back to the note that minted it.
>   - *Reads*: the shell's `FEDERATION.md` §8.1 step 5 has the maintainer close the
>     PR with the landing commits **and the id-mapping table**
>     (`LC-nn → L-Xnn`, `LD-nn → <PREFIX>-nn`). **While the PR is open there is no
>     `L-` id to pair to**: final ids are allocated at the landing fence (§4, §8.1
>     step 4), and `HT-01` §4's `L-H1-` scheme is demoted by its own appended
>     correction to this repo's **local provisional index**, appearing in no
>     shell-bound artefact. **This box is checked against the maintainer's returned
>     mapping and against nothing else** — a pairing invented on this side would be
>     a second name for something the fence has not yet named.
> - [ ] **Sponsor-visible**: the harvest table and the shell diff were surfaced at
>       this gate. Refusals, if any, are recorded as `sponsor-refused` above.
>   - *Reads*: §7.2.
> - [ ] **Harvest declared complete** by the orchestrator: `J-orchestrator-NNNN`.
>   - *Reads*: the collator's declaration, by definition not the miner's.

**The boxes above are quoted, not live**: they are inside a blockquote precisely
so that no reader and no checker can mistake them for the instantiation, and the
four live boxes are the four unquoted ones. Box 11 is the one box common to both
renderings, and its `Reads` moved from a sentence to an adjudication.

**Box 8 and box 9 are not the same box, and they now fail apart rather than
together.** A2.8's second failure mode is *"a gate record whose Part B is checked
with no shell commit linked"*; the inverse — a landing linked with no pairing
recorded — is the same defect from the other side. Both are now satisfiable from
evidence inside this repository, which is itself new: until 2026-08-17 neither
could be checked at all, because both waited on a party that owed this programme
nothing.

### 7.2 Sponsor visibility — what "surfaced at this gate" meant, and what retired

*[annotated 2026-08-18] **This section states the law until 2026-08-17.** The
power it describes was retired that day by ADR-0023 D4 and its box is gone from
Part B; this annotation is the gate record catching up. The section
is kept, quoted whole and unedited below, because a live gate record annotates
and never erases, and because §8's sponsor row, `G-7` and `G-12` all point here.*

**The law until 2026-08-17, kept verbatim:**

> ADR-0018 §4.4, in its own words: *"At gates the sponsor does not personally sign,
> the harvest table is in the checklist and the shell diff is one commit —
> ratification means the sponsor **may refuse a candidate**, and a refusal is
> recorded in the gate record's disposition column."*
>
> **PROTOCOL §7 names no sponsor signature at `P<n>-module-ready`** — sponsor
> approval is E1 and it lands at `P<n>-phase-accept`. So box 10 is discharged by
> **surfacing**, not by a signature, and concretely it is:
>
> 1. **The harvest table** — §7.1's four boxes and §7.3's tables, in this file.
> 2. **The shell diff, one per harvest** (A2-D5). For harvest 1 the diff the sponsor
>    sees is the inbox PR's one file (PR #3) and, once the maintainer lands it, the
>    shell's own landing commits.
> 3. **The refusal, exercisable candidate-by-candidate before shell history moves.**
>    `HT-01` records this as the reason the transit took PR form at all; the
>    orchestrator's ruling is at `J-orchestrator-0236`. A refusal is recorded as
>    `sponsor-refused` in the Disposition column of the harvest it belongs to.
>
> **What a refusal converts a candidate into is parked** (ADR-0018 §13, unamended by
> A2). If a refusal happens at this gate, that question becomes live and is `G-7`'s
> neighbour, not a thing this file may answer.

**What retired, and why it is a retirement rather than a reduction** — ADR-0023
D4, in its own words: the refusal power *"existed to gate what **left** the
program. Nothing leaves. A refusal power over a movement that does not happen is
not a reduced power, it is a power over nothing, and keeping it as a ceremony
would be worse than retiring it: it would put a human signature on a decision
with no object."* Concretely, each of the three items above loses its object:
there is no shell diff to surface, the block's Disposition column no longer
offers a `sponsor-refused` value (ADR-0023 §5.1), and PR #3 — the vehicle the
refusal was exercisable against — is closed unlanded.

**What stands in its place**, quoted from the block as amended:

> **The landing rides the gate-closing commits the sponsor already signs**, which
> is the sponsor's whole lessons touchpoint: nothing leaves this repository, so
> there is no diff to surface for refusal and no refusal column to fill
> (ADR-0023 D4).

**And that standing line meets this gate at an angle, which this file records
rather than resolves** (§0.2): **PROTOCOL §7 gives `P<n>-module-ready` no sponsor
signature at all** — the very fact the quoted passage above was constructed
around, and the reason the retired box discharged by *surfacing* instead. So for
the two harvests ratified here, either the touchpoint is empty until the next
gate that carries a sponsor signature, or the standing line names a gate class
this one is not in. **This file takes neither reading**; it is `G-12`.

**What a refusal converts a candidate into stays parked** (ADR-0018 §13,
unamended by A2) — and is now parked with its subject: no refusal can be
exercised, so the question cannot become live here. Like `G-7`, it is answered by
the retirement of the thing it was about rather than by a ruling.

### 7.3 Harvest 2 — `P1-module-ready`'s own harvest

Instantiated from `docs/gates/lessons-harvest-block.md` §3, **all eleven boxes**
(A2-D2), filled and checked by the orchestrator as collator (A2-D4). Every cell's
authority is the cited `J-<agent>-NNNN` entry. **Everything from the heading below
to the end of this section is the instantiation**; §8 resumes the checklist.

## Lessons harvest — P1-module-ready

Per ADR-0018 as amended by A2 / PROTOCOL §7. Spans are entry-id intervals over
each agent's own journal chain and must tile with that agent's previous harvest.
Transcribed by the orchestrator; each row's authority is the cited journal entry.

### Spans mined

| Agent | Span (entry-id interval) | Harvest note | T1 general | T2 domain | T3 |
|---|---|---|---|---|---|
| architect_docs_lead | | | | | |
| rtl_lead | | | | | |
| dv_lead | | | | | |
| auditor | | | | | |
| orchestrator | | | | | |
| _(worker spans, by commissioning lead)_ | | | | | |

**Span openings under A2-D10, derived as an aid and not as an authority.** The
rule is *"a harvest's span ends at the last entry before the note that carries
it, and every later span opens at the first entry not already inside a mined
span."* Computed over the five landed first-harvest notes, the openings are:
architect_docs_lead `-0035`; rtl_lead `-0013`; dv_lead `-0168`; auditor `-0019`;
orchestrator `-0233`. **Each seat's own note is the authority and the box reads
the note** — this line is re-derived at gate time, never copied forward, and a
declared next opening that differs is a prediction that *"consumes nothing"*
(A2-D11).

### Yield — tiers 1 and 2

`LC-` = tier 1, general, to the lessons file's general sections. `LD-` = tier 2,
domain, to a domain-titled section of the same file, grade noted on the entry.
*[re-quoted 2026-08-18: the two sentences above are taken from the block as
amended on 2026-08-17; until this round they read "to the shell's universal set"
and "to the named pack" (ADR-0023 §5.1). The prefixes, their independence and
the id scheme below are unchanged.]* The two prefixes number independently; ids
are seat-qualified, `LC-<seat>-H<k>-<n>` (A2-D6), and **no landed id is
renumbered** (A2-D7). Each
seat mints under its **own** ordinal, so the seats may sit at different `H<k>` at
one gate: the four seats whose only harvest is their first mint `H2` here
whatever their grandfathered range looks like, and dv_lead — whose second harvest
already minted `LC-dv_lead-H2-<n>` — mints `H3`.

| id | Rule statement (one line) | Grade | Domain pack | Mined by | Note entry | LH1 provenance | Disposition |
|---|---|---|---|---|---|---|---|
| | | | | | | | |

### Tier 3 — war stories and local accretions (not transcribed to the lessons file)

*[re-quoted 2026-08-18: the heading read "(not transcribed to the shell)" until
this round and is taken from the block as amended on 2026-08-17 (ADR-0023 §5.1).
**Tier 3's substance does not move** — only the destination it excludes them
from; the fork it names,
war story kept and re-offerable / local accretion bound by its own artefact, is
untouched.]*

| Candidate | Mined by | Failed | Why | Tier-3 disposition |
|---|---|---|---|---|
| | | | | |

### Checklist — Part A (mining)

- [ ] **Every persistent-journal agent has a row above**, and every span tiles
      with that agent's previous harvest — no gap, no overlap. (First harvest:
      the span opens at the agent's first entry.)
- [ ] **Each row's harvest note exists** in the named journal entry and carries
      its span interval, its candidates with LH1–LH3 discharged, its war stories
      with the criterion each failed — or an explicit nil yield.
- [ ] **The classifier was run on every candidate** (block §2.1), starting from the
      most general honest statement — no candidate reached `LD-` without a
      general statement having been attempted and found hollow.
- [ ] **Every candidate in the Yield table discharges LH1, LH3 and LH2 at its
      stated grade**, checked by the transcriber against the note, not against
      the summary line.
- [ ] **Every `LD-` row names a domain pack**, as a slug naming the technical
      domain and not this program.
- [ ] **Pack names checked against those already in use** in previous harvests;
      an existing name was reused rather than a near-duplicate minted, and any
      normalisation is noted here: `<none / LD-… : "<as offered>" → "<in use>">`
- [ ] **No candidate was edited in transcription.** A defective statement is
      bounced to its author, never rewritten by the collator. (Normalising a
      *pack name* is metadata, permitted, and noted on the line above.)

### Checklist — Part B (collation)

*[re-quoted 2026-08-18: the four boxes below are taken verbatim from the block as
amended on 2026-08-17 (ADR-0023 §5.2). Until this round this section rendered
the same four boxes §7.1 did, and they are **kept verbatim at §7.1** rather than
copied twice —
"Shell transcription: exactly one commit … with permalinked provenance",
"`LC-`/`LD-` → `L-` pairs recorded … so each shell entry is traceable",
"Sponsor-visible … refusals recorded as `sponsor-refused`", and the completeness
declaration. **The partition is still
7 / 4 and this gate still instantiates eleven boxes**: no Part A box moved, in
wording or in site, and within Part B the sponsor-visibility box retired and the
dedup box took its seat.]*

- [ ] **Local landing: exactly one commit**, transcribing this harvest's
      admissible candidates — general and domain — into `docs/LESSONS.md`, and
      nothing else. Commit: `<sha>`
  - *Reads*: **harvest 2's own landing commit, owed and unlanded.** It is not
    `5d2264d` — that commit is harvest 1's, and A2-D5 as restated makes two
    harvests ratified at one gate two commits, in harvest order (§7).
- [ ] **`LC-`/`LD-` → `L-` pairs recorded** in the Yield table's Disposition
      column, with **ids local, seat-qualified and unrenumbered** (A2-D6,
      A2-D7), so each landed entry is traceable back to the note that minted it.
  - *Reads*: the Disposition column of the Yield table above, which for this
    harvest **is rendered in this file** — unlike harvest 1's, whose table is the
    packet's (§7.1).
- [ ] **Dedup against the file recorded**: every candidate checked against what
      `docs/LESSONS.md` already holds, and the outcome recorded on its row.
      Dedup is clerical — a drop carries its reason; composition is selection
      and is never performed (A2-D8, §4.1).
  - *Reads*: **the first non-trivial exercise of this box in the programme.**
    Harvest 1 landed into an empty file; harvest 2 is checked against the **353**
    entries H1 landed, so a drop is now possible and each one carries its reason
    on its row. The bar is A2-D8's and unamended: **dedup is clerical,
    composition is selection.**
- [ ] **Harvest declared complete** by the orchestrator: `J-orchestrator-NNNN`.
  - *Reads*: this harvest's own declaration, distinct from harvest 1's (§7.1) —
    two harvests, two declarations, neither standing in for the other.

**The landing rides the gate-closing commits the sponsor already signs**, which
is the sponsor's whole lessons touchpoint: nothing leaves this repository, so
there is no diff to surface for refusal and no refusal column to fill
(ADR-0023 D4).

*[added 2026-08-18: the standing line above is the block's, carried into this
instantiation because the block carries it beneath Part B — it replaced a box and
is not one, so it is checked nowhere and read everywhere. **At this gate it has
no object**, PROTOCOL §7 giving `P<n>-module-ready` no sponsor signature: `G-12`,
and §7.2 for what the retired box did in its place.]*

---

## 8. Signatures

Every signature is a `J-<agent>-NNNN` reference whose entry says, in the signer's
own words, that it signs the named item. The orchestrator transcribes; the
transcription is clerical and commits under `Agent: orchestrator` (PROTOCOL §7).

| Signer | Signs | Authority it must cite | State |
|---|---|---|---|
| **dv_lead** | Each module's `SO-` `PASS` — supplied as the gate's DV rows, **not** as a gate signature (`SO-xgmii_rx_64.md` §8.R4.2: *"It is the DV rows of `P1-module-ready`, supplied as satisfied"*) | the packet and its signing entry | M03 supplied (`J-dv_lead-0168`); 19 modules outstanding |
| **rtl_lead** | The `P<n>-module-ready` signature its charter §4 names | its own journal entry | not sought — the gate has not convened |
| **auditor** | The mutation N/N record per module (charter §3), plus any finding that blocks | its committed `docs/reports/audit/**` artefact, transcribed under ADR-0003's exception | M03's record supplied at §3.1; **`G-1`'s reading is not supplied** |
| **architect_docs_lead** | **No gate signature.** PROTOCOL §7 names an architect countersignature at `P<n>-spec-freeze` and **none here**, and this file does not invent one. What is owed is content: §5's traceability split, §6's eight deferral rows | its journal entries | this file is the first payment |
| **orchestrator** | The gate's passage; every transcription; the harvest collation and box 11's completeness declaration | its own journal entry | gate OPEN |
| **sponsor** | **Nothing at this gate.** Sponsor approval is E1 at `P<n>-phase-accept`; here the sponsor is a **viewer with a refusal**, §7.2. *[annotated 2026-08-18] The refusal retired on 2026-08-17 with the transit it gated (ADR-0023 D4): **a viewer, and nothing else**. Whether the amended law's "gate signature already given" touchpoint is satisfied at a gate PROTOCOL §7 gives no sponsor signature is `G-12`* | — | — |

---

## 9. Open gate items

Each carries an owner and a closing event, in the ledger discipline
`P1-spec-freeze-checklist.md` established. **None of these is a condition invented
by this file** (§0.2); each is a question the record already poses.

| id | Item | Owner | Closes by |
|---|---|---|---|
| `G-1` | **Clause (b)'s wording against the measured column.** PROTOCOL §7 says *"all killed"* and §10 says *"N/N"*; M03's class-based era is 63 sealed / **61 killed / 1 survived / 1 void**, with the survivor's defect measured dead at a repaired bench (run `30852220315`) and the void narrow (unrenderable *at this design*). Two readings exist and this file takes neither | auditor (the record and its verdict); dv_lead (the score); orchestrator (the gate reading) | an auditor verdict on `G-c4` and `IC-M5` committed under `docs/reports/audit/`, or an ADR settling the clause — **by amendment, not by reading**, on A2.1's precedent |
| `G-2` | **Which modules owe an `SO-`.** Clause (a) is plural and enumerates nothing. M01 is types-only (REQ-903 excludes it from the `hierarchical` half by name); M05/M16/M19 are structural wrappers whose stress obligation REQ-905 discharges through their children — neither fact settles whether a sign-off packet is owed | architect_docs_lead (the enumeration); dv_lead (testability) | a ruling landing in `architecture.md` §4 or `requirements.md`, before the gate convenes |
| `G-3` | **The `P1-spec-freeze` ledger's open set at gate time.** Several rows close on `SO-` packets by name; the gate reads the residue as an input and re-homes nothing | architect_docs_lead | the ledger's own rows closing on their named artefacts |
| `G-4` | **Traceability currency, in two halves that are different claims.** (i) The matrix is 34 of 110 populated, 76 empty, 97 `OPEN`; charter §6 binds *"every REQ-### has a matrix row before its module's `P<n>-module-ready` gate"*. (ii) **REQ-904's own instrument is unbuilt** — the CI set-equality script its verification column commissions does not exist, and `traceability.md`'s REQ-904 row records that by carrying an empty `Test(s)` cell. **A gate condition whose check has never run is not a satisfied condition** | architect_docs_lead (the matrix, and the script is a `WO-` request since `tools/` is dv-scoped); dv_lead (the test-side rows and the script) | each module's rows landing with its `SO-`; the script landing and going green; the split ruling at §5 |
| `G-5` | **Thirty of forty `tb_writer` entries carry no harvest note** (`-0001 … -0020`, `-0031 … -0040`) — found real at the lead-level pass and not closed there. It lands on box 1's tiling claim for the worker row | dv_lead (commissioning lead, ADR-0018 §3.3) | a lead-mined worker span covering them, or a declared and reasoned gap in the note |
| `G-6` | **`OBSERVATION SO-O1`** — two of eighteen candidates in the orchestrator's note carry a version-control tool noun under a stated `LH2-g`. Recorded, owned by the miner, **not charged**: re-grading another miner's statement makes the reader a selector (A2-D4) | orchestrator (miner); collator (the hide test at transcription); A1.4's later-harvest regrade is the instrument | the gate-time hide test recording a verdict either way — the shell's own leak/LH screens also run it independently. *[annotated 2026-08-18] **The second instrument is gone**: PR #3 closed unlanded and the shell's screens with it, so this row's closing event narrows to one — **the gate-time hide test is now the only instrument**. Two facts it does not close: the landing recorded 353/353 clean on a **mechanical project-noun scan** (`docs/LESSONS.md` landing H1, `HT-01` §3.4), which is not this row's verdict; and the disposition that let the two candidates travel as general was reasoned partly on the **shell corpus's own vocabulary** (`J-orchestrator-0236`), a ground the local destination removes. Grades stay the miner's as minted; A1.4's later-harvest regrade is still the instrument* |
| `G-7` | **May a shell commit land before the gate that ratifies it?** A2-D5 fixed the **count** and left the **moment** open (ADR-0018 §4.4, §12). The question is now live rather than theoretical: `HT-01` executed the transit before this gate, on the sponsor's standing in-session direction for this specific first harvest, and the shell's own `FEDERATION.md` §7 defers an `SO-`'s outer hop to the next sponsor-signed gate by default. **ANSWERED BY RETIREMENT — ADR-0023 §7 (2026-08-17), recorded here 2026-08-18** — the answer is the ADR's, recorded in the finding's own row and not ruled here: *"the moment question A2 left open had a shell commit for its subject, and there is no shell commit."* The transit is retired as a class, PR #3 is closed unlanded, and A2-D5's count is now a count of **local landing commits** (D3). **The local analogue is answered too, and by an act rather than by silence**: harvest 1's landing commit `5d2264d` landed **before** this gate, on ADR-0023 D5's own direction, which provides that the landing is *"re-verified at `P1-module-ready` exactly as A2-D3 already provides"* — so a local landing may precede the gate that ratifies it, and what the gate holds is the **re-verification**, not the permission. The refusal half retired with the power (D4, §7.2) | orchestrator as collator; sponsor on the refusal half | ~~this gate ratifying harvest 1, or an ADR item~~ — **CLOSED by ADR-0023 §7 (2026-08-17), recorded 2026-08-18**; nothing is owed on either half |
| `G-8` | **Five findings unrepaired with carriers unopened** — `SO-2` (census producer domain), `SO-3` (the 22-assertion figure does not reproduce; measured 7 of 29), `SO-4` (`AP-M03` §7 row (b), 24 vs 17), `M-4` (141 contaminated vs 139 honest), `P-1`'s residue (1 of 49 citations false). None is closed by being inside a `PASS` | dv_lead | each finding's own carrier opening |
| `G-9` | **Five landed green assertions are unreachable by any mutation** (`U-1` … `U-5`, `DECLARATION WO-0074-D1`), and *"a coverage claim counting such an assertion has counted one observation twice."* It bounds any N/N reading built at `G-1` | auditor (the reading); dv_lead (the register) | `G-1`'s settlement, which must state whether unreachable assertions count |
| `G-10` | **The charter §3 external anchor is undischarged at module level.** PROTOCOL §10 requires a golden model to agree with an external anchor before it may judge RTL; the differential co-simulation anchors classes, one of them, and Stage 3 is refused. Whether that binds at `P1-module-ready` or at `P1-phase-accept` is unstated | architect_docs_lead (the reading); dv_lead (the evidence) | a ruling before the gate convenes, or the anchor discharging |
| `G-11` | **The §1.1 ceiling tightening.** SPEC-M20 §11.3: eleven of REQ-006's twenty-four cycles are unspent and *"the right moment to tighten §1.1 is after the first `P1-module-ready`"* — so this gate's passage opens it, and it moves numbers in three documents together | architect_docs_lead | a spec diff after this gate, or an explicit decision to leave the allocation |
| `G-12` | **[opened 2026-08-18] The sponsor's harvest touchpoint at a gate that carries no sponsor signature.** ADR-0023 D4 retires the candidate-by-candidate refusal and leaves *"exactly one: the gate signature they were already giving"*; the block's standing line has the landing *"ride the gate-closing commits the sponsor already signs"*. **PROTOCOL §7 gives `P<n>-module-ready` no sponsor signature** — sponsor approval is E1 at `P<n>-phase-accept`, which is the very fact the retired sponsor-visibility box was constructed around (§7.2). So for the two harvests ratified here the touchpoint is either **empty until `P1-phase-accept`**, or the standing line is written for a gate class this one is not in. **This file takes neither reading** (§0.2), and records that the previous law covered the same gap by *surfacing* — an act that retired with the diff it surfaced | orchestrator as collator (the reading); architect_docs_lead (the block's wording, if it moves) | the next sponsor-signed gate carrying these harvests, or an ADR item settling which gate class the standing line names |

---

## 10. Exit

The gate passes when, and only when:

1. Every row of §1.1 carries a `PASS` with its DV rows supplied, **or** is
   excluded from clause (a) by `G-2`'s ruling.
2. The mutation record satisfies clause (b) on a reading settled at `G-1`.
3. Every module on REQ-905's list has a green line-rate stress row (clause (c)).
4. §5's mechanical rows are run and green, and the traceability split is agreed.
5. §6's eight deferral rows are reviewed.
6. **Every box of every harvest instantiated at this gate is checked** — §7.1's
   four and §7.3's eleven (PROTOCOL §7, A2-D2). *A gate is not passed while any
   box is unchecked*, and this is the whole of that sentence: it binds gates, and
   the file that once said it also bound sign-offs has been repaired (§0.2).
   *[annotated 2026-08-18] The counts are unchanged — four and eleven, the
   partition still 7 / 4 — and they count the **live** boxes. §7.1 additionally
   keeps the four boxes it rendered until this round inside a blockquote: those
   are record, not
   conditions, and a checker counting them has counted a retired law twice.*
7. Every `G-` item above is closed, or is explicitly carried with the sentence
   naming what carries it.

Then the orchestrator declares `P1-module-ready` passed in its journal, transcribes
the declaration here, and updates `tasks/BOARD.md`'s gate row in the same commit.

**What passing this gate starts** (PROTOCOL §7's hardening paragraph): the window
between `P1-module-ready` and `P1-phase-accept` is *"P1 hardening"* — the
**activation window for `formal_dv`** and the **overlap trigger for the contingent
`rtl_lead_md`**. Passing this gate is therefore a staffing event as well as a
verification one, and neither seat is spawned before it.
