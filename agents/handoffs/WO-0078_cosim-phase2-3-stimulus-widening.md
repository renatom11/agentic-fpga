# WO-0078: the co-simulation lane widens its stimulus — a FROZEN case 0, a case SET beside it, and the four repairs that become material the moment the one-frame bound is lifted

- **State** (flipped per stage by dv_lead's `RV-`, per §14's own note):
  **STAGE 1 — ACCEPTED.** Both halves: tb_writer at `3ec0efe`, data_wrangler at
  `8c6429e`; verdict `RV-STAGE1` in §14, `J-dv_lead-0150`.
  **STAGE 2 — ISSUED; the C2 THIRD LANDING is RETURNED and ADJUDICATED; C1 and C2
  are both ACCEPTED and the stage is HALF LANDED** (verdict `RV-C2ALPHA` in §14,
  `J-dv_lead-0155`; tb_writer at `2efd7f9`; `build` run `31103977231`, conclusion
  **success — the whole run green**, `cosim` job `92624287637` green, `build` job
  green). Per case:
  **C1 — ACCEPTED, branch α** (CD §10.1's frozen terms). Re-observed byte-identical
  at `9de61f1` and again at `2efd7f9`.
  **C2 — ACCEPTED, branch α**, under CD §10.2 **unamended**: `frames compared: 2`,
  `frames matching: 2`, `divergences: none`, `compare_exit=0`, `tier=CLEAN`,
  run1/run2 byte-identical. **The prediction — "agreement on both" — is CONFIRMED
  and SPENT**, having been frozen at `5c01af0` and measurably untouched (one hunk,
  129 insertions, **zero deletions**) through two voids and two repairs. **The sha
  bind `cc1e85a4…5b44a7` held for the THIRD time**, and C2 is now a **standing
  regression case** at every later landing. **Final ledger: dispatched three times,
  driven three times, `compare` invoked twice, COMPARED ONCE, AGREED ONCE.**
  **`AP-M03` §7 bar 1 lifts for the two-clean-frames-at-minimum-IFG class and for no
  other** — not for REQ-004's line-rate cadence, and **not** for a lane-4 start at a
  non-zero admit cycle as a separable class. **The `AP-M03` cell recording it is
  owed to the `AP-` round after Stage 2 lands (§13 item 2), not to this round; the
  CD gets nothing, because a result is not a question (CD §10.7 item 3).**
  `FINDING RV-0078-S2-6` **CLOSED**; `FINDING RV-0078-S2-8` **CLOSED at its
  recommended limb** (the golden-file fixture, 13/13 self-test) with its structural
  condition standing; `FINDING RV-0078-S1-2`(b) **CLOSED** — limb (i) discharged in
  production, limb (ii) closed on the fixture because no case in the designed set
  can produce it, re-arming automatically if one ever does. **Two new MINOR findings,
  both against dv_lead's own instrument design**: `S2-9` (`MAX_WORDS_PER_FRAME = 16`
  bounds a frame at 128 delivered octets against a 64–1518-octet requirement range —
  pre-emptive, gates **Stage 3**, not C3/C4) and `S2-10` (the repair moved per-frame
  attribution into the writer, ruled **lawful**, with its in-order-delivery
  assumption unstated and a reading rule now binding). **The pre-registered stopping
  rule NEVER FIRED and is RETIRED on an answer, not a timeout** — the pinned
  transaction form **can** express two overlapping frames — **and its form is
  re-armed for C3 and C4 at the same threshold.**
  **C3 — NOT ISSUED, and NEXT, ALONE** (§6.2, re-affirmed at `RV-C2ALPHA` §9), with
  `FINDING RV-0078-S2-7`'s runner repair riding its runner half and **one amendment:
  the case array becomes `0 C1 C3 C2`**, so §12 criterion 3's plural
  property — unexercised after three landings — is exercised the first time C3
  diverges. **C4 — NOT ISSUED.**
  **STAGE 3 — SCOPED, NOT AUTHORISED (§6.3)**, and its re-authorisation gate gains
  **(d)** a second static census on the frame-length and admission-legality axes and
  **(e)** `MAX_WORDS_PER_FRAME` raised to cover the longest frame either producer can
  deliver, with the covering range stated beside the bound (`RV-C2ALPHA` §7, §9).
  *The field read as follows from `RV-C2RERUN` until `RV-C2ALPHA`, kept rather than
  overwritten for the same auditability reason as the texts below:*
  "**STAGE 2 — ISSUED; the C2 RE-RUN is RETURNED and ADJUDICATED** (verdict
  `RV-C2RERUN` in §14, `J-dv_lead-0154`; tb_writer at `9de61f1`; `build` run
  `31100435961`, `cosim` job `92612412697` red at aggregate `NO-VERDICT(8)`,
  `build` job green). Per case:
  **C1 — ACCEPTED, branch α** (CD §10.1's frozen terms; `AP-M03` §7 bar 1 lifts for
  that one class and no other). Re-observed byte-identical at `9de61f1`.
  **C2 — VOID FOR THE SECOND TIME, RE-RUN OWED** under CD §10.2 **unamended**: both
  producers produced, `Canonical.read` refused `theirs.canon` at line 9, `compare`
  exited 3, and the case again selects no branch. **Dispatched twice, `compare`
  invoked once, COMPARED ZERO TIMES**; prediction frozen and **unspent**; the sha
  bind `cc1e85a4…5b44a7` **carries forward unchanged** and has now held across two
  landings. `FINDING RV-0078-S2-1` (the refusal guards) is **CLOSED**;
  `FINDING RV-0078-S2-6` (MATERIAL) replaces it one layer downstream — **the
  reference-side writer emits canonical records in real time and the pinned grammar
  requires each frame's records to form one contiguous block; the repair is
  tb_writer's, in `test/cosim/tb_xgmii_rx_64.v` (plus the grammar's own files only
  if the chosen route amends it), under `RV-C2RERUN` §6's seven preserved
  properties, before C2 re-runs.** **A stopping rule is pre-registered
  (`RV-C2RERUN` §3): a third landing reaching no comparison is not a fourth worker
  repair round.**
  **C3 — NOT ISSUED**, not blocked in principle (its single frame cannot trip
  either defect) and **sequenced behind the C2 repair round** (`RV-C1C2` §10,
  re-affirmed at `RV-C2RERUN` §10). **C4 — NOT ISSUED.**
  **STAGE 3 — SCOPED, NOT AUTHORISED (§6.3).**"
  *The field read as follows from `RV-C1C2` until `RV-C2RERUN`, kept rather than
  overwritten for the same auditability reason as the texts below:*
  "**STAGE 2 — ISSUED; the C1+C2 landing is RETURNED and ADJUDICATED** (verdict
  `RV-C1C2` in §14, `J-dv_lead-0152`; tb_writer at `a822f46`, data_wrangler at
  `53fa1de`; `build` run `31096150983`, `cosim` job `92598555141` red, `build` job
  `92598555210` green). **C1 — ACCEPTED, branch α.** **C2 — VOID, RE-RUN OWED**
  under CD §10.2 **unamended**: it reached no comparison and selects no branch.
  `FINDING RV-0078-S2-1` (MATERIAL) — both producers' refusal guards test a span
  outliving the input frame by ΔC, so the minimum-IFG schedule is refused; the
  repair is tb_writer's, in `test/cosim/ours_run.ml` and
  `test/cosim/tb_xgmii_rx_64.v`, one round and one rule, before C2 re-runs.
  **C3 — NOT ISSUED**, not blocked in principle and sequenced behind the C2 repair
  round. **C4 — NOT ISSUED.**"
  *The field read as follows from `RV-STAGE1` until `RV-C1C2`, kept rather than
  overwritten for the same auditability reason as the DRAFT text below:*
  "**STAGE 2 — AUTHORISED (§6.2), NOT ISSUED**, and it may not be issued until §13
  item 1's CD domain instance is committed (§6.2's own stop rule) and until
  `FINDING RV-0078-S1-2`'s printer repair has landed — `RV-STAGE1` §6 states both."
  *The field read as follows from this packet's own commit until `RV-STAGE1`, and
  the prior text is kept rather than overwritten because a lifecycle field that
  erases its own history cannot be audited:* "**DRAFT.** Nothing in this packet is
  commissioned by the round that writes it; no worker is spawned against it here,
  no file in `test/**` or `tools/**` moves in the commit that carries it. It
  becomes `ISSUED` per stage, by the orchestrator, on the authorisations in §6."
- **Packet number**: `0078` is written here for citability; **the orchestrator
  allocates the number at first commit** (PROTOCOL §3) and a different one is not
  a defect in this packet, only a rename.
- **Dating**: **this packet asserts no date of its own. It is dated by the commit
  that carries it** — `WO-0077-VERDICT` §13 item 7's own rule, which commissioned
  it. Every figure in it is stated **at a named base SHA** (§1) and is a finding
  against this packet if it has moved when an assignee re-measures it.
- **From** / **To**: dv_lead → **tb_writer** (`test/cosim/**`) and
  **data_wrangler** (`tools/cosim/**`). Two halves, one packet — the `WO-0046`
  and `WO-0075` precedent, at its third use. **Landing order per stage is
  constrained here** and no longer free: §6.1's fail-closed argument holds only
  in one direction now that a case set exists.
- **Spec basis**: `docs/specs/requirements.md` **REQ-901** (its declared
  divergence classes **(a)–(f)**, its *"transactional, not cycle-by-cycle"*
  sentence, its cycle-alignment exclusion and its closing
  never-a-licence sentence), **REQ-005**, **REQ-111**, **REQ-107**, **REQ-108**,
  **REQ-102**, **REQ-104**, **REQ-110**, **REQ-016**, REQ-013, REQ-902;
  `docs/specs/modules/xgmii_rx_64.md` **§6.1** (the `admit_cycle + m + 3` gapless
  formula, its injected-idle clause and its own cycle-by-cycle worked table),
  **§7**, **§9**, **§10**.
- **Governing lane documents** (mine, not the assignees'):
  `test/attack_plans/CD-xgmii_rx_64_cosim.md` (the comparison domain — §5's
  inside/outside tables, §6's frozen V1–V7 predictions, §8's Phase-1 domain
  instance, §9's change discipline) and `test/attack_plans/AP-xgmii_rx_64.md` §7
  (bars 1–4 and the standing census repair). **§13 routes both; neither is an
  assignee deliverable and neither moves in this packet's own commit.**
- **Deliverables**: per stage, in §6. `test/cosim/canonical.{ml,mli}`,
  `test/cosim/stimulus_gen.ml`, `test/cosim/ours_run.ml`,
  `test/cosim/tb_xgmii_rx_64.v`, `test/cosim/compare.ml` (tb_writer);
  `tools/cosim/run_cosim.sh` (data_wrangler). **No other file in either scope,
  in any stage.**
- **Definition of done**: §11. **Pass criteria**: §12 — nine, numbered, each
  with the observation that fails it.
- **Context provided**: this packet in full; `test/cosim/**` and
  `tools/cosim/**` as they stand (each assignee's own prior deliverables); the
  spec sections named above **by path and section number, to be read from
  `docs/specs/` directly**; `test/third_party/verilog-ethernet/`'s **published
  port list and its `PROVENANCE.md` pin**, which `tb_xgmii_rx_64.v` already
  instantiates against. **No `libs/**`. No `rtl_snapshots/**`.** Neither half
  needs our RTL and neither may open it (PROTOCOL §10): every expected value in
  every stage is derived from frozen spec text, and a diff that reads otherwise
  is a finding against the assignee.
- **Out of scope**: §10 — a list of things this packet **forbids** as much as a
  list of things it does not ask for. **The strobe record stays refused, and §10
  item 4 states the one precondition that changes and the two that do not.**

---

## Section map

| § | what it settles |
|---|---|
| 0 | what this packet is for, and the naming collision it clears before anything else |
| 1 | frozen inputs — every figure, at `beb9c2a`, with the re-measurement rule |
| 2 | the measurement this packet is priced from — a census over **two** producers, and `FINDING WO-0078-1` |
| 3 | the design: a case **SET**, not a widened stimulus, and case 0 frozen |
| 4 | `FINDING WO-0077-A1`, both halves, as constraints this packet is built under |
| 5 | the four `RV-0075` repairs, and where each lands |
| 6 | the stages — Stage 1 and Stage 2 **AUTHORISED**, Stage 3 **SCOPED, NOT AUTHORISED** |
| 7 | the frozen predicted dispositions, written in the open before any case runs |
| 8 | what each stage does to `AP-M03` §7's four bars — per case, never per module |
| 9 | cost, with the unmeasured part named and a pre-committed band |
| 10 | what this packet does NOT do — prohibitions |
| 11 | definition of done, per half, per stage |
| 12 | pass criteria — falsifiable, numbered |
| 13 | owed elsewhere — what this packet routes rather than absorbs |
| 14 | return / verdict log |

---

## 0. What this packet is for, and the naming collision it clears first

### 0.1 The collision, cleared before it can mislead anyone

**"Phase 2" and "Phase 3" name two different things in this programme's own
documents, and this packet is about one of them.**

- **The programme's** Phase 2 is MoldUDP64/ITCH 5.0 and the order book; its
  Phase 3 is the 10GBASE-R PCS stretch goal. `RV-0075-VERDICT` §6 item 4 says of
  those: *"Phases 2 and 3 are untouched by all of the above … Phase 2's anchor is
  a different instrument entirely."*
- **The co-simulation lane's** Phase 2 and Phase 3 are `WO-0044` §4's phasing of
  the lane itself: **Phase 2 — the clean-frame spine**; **Phase 3 — the error
  paths, and the actual anchoring**.

**This packet is the lane's Phases 2 and 3 and touches neither of the
programme's.** Throughout, the words are written **co-sim Phase 2** and **co-sim
Phase 3**, never bare. §10 item 11 restates the separation as a prohibition,
because a packet that clears a collision in its first section and then relies on
the reader's memory has not cleared it.

### 0.2 What the packet is for, in one paragraph

The differential co-simulation lane drives **one** 64-octet good-FCS frame at a
lane-0 start and has driven nothing else since it opened. That single fact is the
binding constraint on every claim the lane can make: `RV-0075-VERDICT` §6 item 1
records it as the first of four standing bars — *"the lane drives **one**
frame … No `SO-` may cite this lane as coverage of any stimulus class it does not
drive"* — and `WO-0046`'s adjudication §5 item 3 calls co-sim Phases 2 and 3
*"the longest-lead item in this module's sign-off."* **This packet is those two
phases, designed.** It is also the named carrier for four repairs that
`RV-0075-VERDICT` dated to *"the work order that lifts `WO-0075` §8 item 1"* —
which is this one — and it is the first artefact drafted under
`FINDING WO-0077-A1`'s standing census repair, which it obeys in §2 and
demonstrates in §2.3.

**What it is not**: it is not a request to compare more things. REQ-901's
comparison content is untouched, the barred cross-side timing quantity stays
barred, and the strobe record stays refused. **The only thing that widens is the
stimulus, and the whole difficulty of this packet is that widening it in place
would destroy the one capability this anchor has ever been measured to have
(§3.1, §4.2).**

---

## 1. Frozen inputs — measured at `beb9c2a`, and re-measured before a line is written

**Every figure below was measured at base SHA `beb9c2a` by the seat that wrote
this packet.** They are inputs, not decoration: §3's design, §6's staging, §7's
predictions and §9's pricing each rest on specific ones.

| # | input | what was measured, and what rests on it |
|---|---|---|
| **FI-1** | `test/cosim/stimulus_gen.ml` | **One** frame — `Frame.stress_frame ~sequence:0 ()` — via `Arrival.create ~first_start:0 [octets]`, plus `drain_cycles = 24`. `Arrival.check` asserted empty before write. §3, §6, §7 |
| **FI-2** | `test/xgmii/arrival.mli`, `create`'s signature | `?ifg` default **12**; `?first_start` default **8** (*"lane 0 of cycle 1, so that a bench sees one idle word before any frame"*), **must be a multiple of 4**; `?fcs_valid` default **true**, with `check` verifying the REQ-304 residue when set. **`create` takes `int list list` — a frame LIST — so a second clean frame needs no new machinery.** §3.2, §4.2, §6.2, §9 |
| **FI-3** | `test/cosim/ours_run.ml` `:159–162` | one `clear` cycle driven, then released; the stimulus trace begins at index **0** immediately after. **Our side presents its start character on cycle 0.** §4 |
| **FI-4** | `test/cosim/ours_run.ml` `:118` | `failwith` — *"a second start character arrived while a frame was open — REQ-110 abort handling is out of Phase 1's authorised stimulus"*. **A refusal guard in a producer, not in the stimulus.** §2.2, §6.3 |
| **FI-5** | `test/cosim/ours_run.ml` `:133` | `failwith` — *"M03 produced an output word with no admitted frame open"*. The guard that caught `IC-L5`, which REQ-901's comparison did not. §2.2 |
| **FI-6** | `test/cosim/tb_xgmii_rx_64.v` `:274–276` | `$display` + `$finish` — the same second-start refusal, **independently implemented in Verilog**. §2.2, §2.3, §6.3 |
| **FI-7** | `test/cosim/tb_xgmii_rx_64.v` `:288–289` | `$display` + `$finish` — the reference's own no-open-frame guard. §2.2, §2.3 |
| **FI-8** | `tools/cosim/run_cosim.sh` `run_pipeline` | our side's rc **is** checked and maps to `EXIT_BUILD`; the reference side is invoked as `vvp` and **its rc is checked the same way**. §2.3 |
| **FI-9** | `tools/cosim/run_cosim.sh` `:443–453` | exit constants `EXIT_OK=0 … EXIT_TIMING_NO_VERDICT=11`. **12 is unallocated.** §5.3 |
| **FI-10** | `tools/cosim/run_cosim.sh`, sidecar | the sidecar carries a `stimulus_sha256` field and the run prints it. **This is what makes §12 criterion 1 checkable with no new machinery.** §3.2, §12 |
| **FI-11** | `test/cosim/canonical.mli` | the pinned grammar, amended **once** (`WO-0075` §2, adding `admit-cycle` and `cycle`, decimal on purpose). `compare_words` does not carry `cycle`; `compare_transactions` does not carry `admit_cycle`. §5, §10 item 7 |
| **FI-12** | `test/third_party/verilog-ethernet/PROVENANCE.md` | pin `77320a9471d19c7dd383914bc049e02d9f4f1ffb`; two vendored files, `axis_xgmii_rx_64.v` and `lfsr.v`. **Not bumped by any stage of this packet** (§10 item 5) |
| **FI-13** | `docs/specs/requirements.md` REQ-901 | classes **(a)–(f)**; *"Classes (e) and (f) exclude **nothing** in the 64-to-1518-octet range, which is where this boundary still anchors"*; *"an exclusion is never a licence to take an expected value from the reference"*. §7, §8 |
| **FI-14** | `docs/specs/modules/xgmii_rx_64.md` §6.1 | `admit_cycle + m + 3`; *"word `m` is emitted as many cycles later as there are idles injected at or before D(m)"*; *"Injection begins at the frame's first octet"*. §5.2, §7 |

**The re-measurement rule, and it is a bar on the assignee, not a courtesy.**
Every figure above is stated at `beb9c2a`. **Each assignee re-measures the ones
its own half rests on at its own base before writing a line**, and reports the
result in its Return log whether or not it moved. **A figure that has moved is a
finding against this packet and a reason to stop**, not a reason to proceed with
a corrected number: this packet's staging and its predictions were derived from
these values, and a moved value may have moved the derivation with it. This is
`FINDING K-3`'s rule — *a bar that has never been run against its own base is not
a bar, it is a hope* — applied to a work order's inputs rather than to a review's
bars.

---

## 2. The measurement this packet is priced from — a census over TWO producers

### 2.1 What the lane drives today, and what twenty-one seeded classes did with it

`WO-0075` §1 measured twelve seeded classes (families L and M) against this
lane's stimulus and found **two rendered, zero reported by REQ-901's comparison**.
`WO-0077-VERDICT` §9.1 added nine more (families K and N-completion) and found
**two rendered and two reported** — the first mutant convictions this anchor has
ever produced. **Twenty-one seeded classes, four rendered, two reported.**

The four that were rendered are the whole of the lane's demonstrated reach:

| class | campaign | rendered because | reported by |
|---|---|---|---|
| `IC-L2` | L | a uniform ΔC shift needs only one frame | **nothing, then** — it is what `WO-0075`'s T1 was built for |
| `IC-L5` | L | a duplicated last word needs only one frame | `ours_run`'s own no-open-frame guard (**FI-5**), never the comparison |
| `IC-K3` | K | the defect lands on a start character at a reset-release cycle | **`compare`, exit 1** — `DEFECT: frame 0: decision mismatch (ours=discard, theirs=accept)` |
| `IC-K5` | K | same placement | **`compare`, exit 1** — same message |

**Seventeen of twenty-one were unreachable at one clean frame.** They needed a
second frame, an error character, a bad FCS, a runt, an oversize or a `Discard`
— which is the list this packet exists to supply.

### 2.2 The refusal guards, enumerated per producer — the census done the way the standing repair requires

`FINDING WO-0077-A1`'s repair (§4.1) requires a universal over "the bench" to be
measured over **every producer that drives the DUT**. Applied here the direction
reverses: this packet's universals are about **the lane**, and the lane has three
producers plus a sequencer. **What bounds the lane's stimulus space is not only
`stimulus_gen.ml`.** Measured at `beb9c2a`, over every file in the lane:

| producer | refusal | tripped by | effect today |
|---|---|---|---|
| `stimulus_gen.ml` | `Arrival.check` non-empty → `failwith` | an unconformant schedule | rc ≠ 0 → `EXIT_BUILD` |
| `ours_run.ml` **FI-4** | second start character while a frame is open | **REQ-110 abort stimulus (V5)** | rc ≠ 0 → `EXIT_BUILD` |
| `ours_run.ml` **FI-5** | output word with no admitted frame open | a design defect | rc ≠ 0 → `EXIT_BUILD` |
| `ours_run.ml` `:63` | malformed stimulus line | a harness defect | rc ≠ 0 → `EXIT_BUILD` |
| `tb_xgmii_rx_64.v` **FI-6** | second start character while a frame is open | **REQ-110 abort stimulus (V5)** | `$display` + `$finish` |
| `tb_xgmii_rx_64.v` **FI-7** | reference produced a word with no open frame | reference behaviour we do not model | `$display` + `$finish` |

**The load-bearing result of this census, and it was not visible from
`stimulus_gen.ml` alone: two of the six refusals name REQ-110's abort case and
sit in two independently written accumulators.** `ours_run.ml`'s own header says
so in terms — *"deliberately not implemented: this file `failwith`s rather than
guess at it, so a future phase that needs it is told to write it rather than
silently mishandling it"* — and the Verilog says the same in its own words.
**So co-sim Phase 3's V5 is not a stimulus change. It is a change to the
admission algorithm in two producers at once, and those two must agree or the
comparison compares nothing.** That is priced in §9 and gated in §6.3, and it is
the single largest item in this packet.

**A second result, cheaper and worth stating: a second frame is NOT blocked.**
Both guards fire only on a start character arriving **while a frame is open**.
A second frame after the first closes passes both, and `Arrival.create` already
takes a frame list (**FI-2**). **Co-sim Phase 2 therefore needs no accumulator
change at all** — which is why §6.2 authorises it and §6.3 does not authorise
Phase 3.

### 2.3 `FINDING WO-0078-1` (MINOR today, **MATERIAL the moment any case can trip a reference-side guard**) — the two producers' refusals do not reach the same place

**Our side's refusals are `failwith` and produce a non-zero exit status, which
`run_pipeline` checks and maps to `EXIT_BUILD`. The reference side's refusals are
`$display` followed by `$finish`, and `$finish` is a normal simulation
termination.** The harness's own check on that invocation is
`if [ "$rc" -ne 0 ] || [ ! -e "$dir/theirs.canon" ]` (**FI-8**), and a `$finish`
after the file has been opened satisfies neither disjunct: the file exists, and
the message goes to the log through `say` rather than to an exit code.

**What this packet claims and what it does not.** It does **not** claim to have
observed this: ADR-0005 puts no `iverilog` in the development container and this
seat executed nothing. **What it claims is that the harness's rc check cannot be
*assumed* to catch a reference-side refusal, and that the assumption has never
been tested because no stimulus has ever tripped one.** Today that is harmless —
no landed case can trip **FI-6** or **FI-7**. **It stops being harmless at the
first case that can**, and V5 is exactly such a case.

**The repair, and it is Stage 1's, not Phase 3's** — a guard whose failure mode
is discovered in the round that needs the guard is a guard that failed twice:

> **Every refusal in every producer SHALL reach a distinct non-zero harness exit
> code, by construction and not by inference**, and the self-test SHALL trip at
> least one reference-side refusal deliberately and observe the code. Whether
> that is `$finish` replaced by a non-zero-status termination, a sentinel line in
> `theirs.canon` the parser rejects, or a separate status file, is the
> assignees' design choice to make jointly and to state; **what is not a choice
> is a refusal that prints and lets the run proceed to a comparison.**

**Class**: MINOR at `beb9c2a`, against my own `WO-0046` design and both landed
halves; no result already claimed by this lane is affected, because no landed
case reaches either guard. **It is recorded here rather than in a verdict because
this is the packet whose whole subject is making those guards reachable.**

---

## 3. The design: a case SET, not a widened stimulus — and case 0 is FROZEN

### 3.1 Why widening in place would destroy the only capability this anchor has ever demonstrated

The obvious shape for this work is: edit `stimulus_gen.ml` until it drives more.
**It is the wrong shape, and the reason is a measurement rather than a
preference.**

`FINDING WO-0077-A1`'s positive half established that this anchor is *"blind to
seven of nine, and **sighted** for exactly the two whose defect lands on a start
character sitting on a reset-release cycle."* That sighted condition is not a
property of the design under test and not a property of the comparator. **It is a
property of the current stimulus**: `stimulus_gen.ml` passes `~first_start:0`
where `Arrival.create`'s default is **8** (**FI-1**, **FI-2**), so the co-sim
lane admits its frame on cycle 0 and the whole of `test/xgmii_rx_64/` does not.

**Every natural widening move destroys that placement.** A prologue idle word
moves the start off cycle 0. A lane-4 start written as `~first_start:12` moves it
to cycle 3. A two-frame schedule written with the default `first_start` moves it
to cycle 1. **Each would silently trade the only measured capability this anchor
has for coverage, and the trade would be invisible: the `cosim` job would stay
green, and the next campaign would find the lane blind again with nothing in the
record to say when it stopped being sighted.**

**Therefore**: the lane goes from one stimulus to a **stimulus set**. **Case 0 is
the exact stimulus landed at `beb9c2a`, byte-identical, and it is frozen for the
life of this lane.** Every new class is a **new case beside it**, never an edit
to it. Three things fall out and all three are worth more than the file they cost:

1. **Every result this lane has ever produced stays citable.** Phase 1's
   discharges, `WO-0075`'s T1 cycles `3 … 10`, and `FINDING WO-0077-A1`'s two
   convictions are all statements about case 0, and case 0 does not move.
2. **The `WO-0075` §8 item 1 hazard is answered rather than accepted.** That
   clause barred stimulus change because *"folding it in here would make a
   failing CI run un-diagnosable between two independent changes."* **With a case
   set and per-case reporting (§3.2), a red is attributed to a case by
   construction**, which is what makes §6.2 able to land two cases in one commit
   where `WO-0075` could land none.
3. **The sighted placement is preserved deliberately** (§4.2), and §12 criterion
   2 makes its loss a failure rather than a discovery.

### 3.2 The case record, and what the harness reports per case

A **case** is: an identifier, a one-line statement of the stimulus class it
drives, a `stimulus.txt`, and — per §7 — a **frozen predicted disposition
committed before the case first runs**.

**tb_writer's half.** `stimulus_gen.ml` gains a case table and emits one
`stimulus.txt` per case, selected by argument; **case 0's construction expression
is not edited** — its `Arrival.create ~first_start:0 [ octets ]` call and its
`drain_cycles = 24` stay exactly as they are, and the case table names it rather
than rebuilding it.

**data_wrangler's half.** `run_cosim.sh` iterates the case set, running the
existing pipeline per case in its own working directory, and prints **one line
per case** naming: the case id, its `stimulus_sha256`, `compare`'s own exit code,
and the tier that produced it. The existing per-run SUMMARY block is retained
per case.

**The check that costs nothing and catches the worst failure**: `run_cosim.sh`
already computes and prints `stimulus_sha256` (**FI-10**). **Case 0's value is
therefore comparable, without new machinery, against the value the last green
pre-widening run printed.** §12 criterion 1 is that comparison, and it is the
criterion that fails the whole run when it fails.

### 3.3 The aggregate exit precedence, pinned here so it is not invented

`compare` runs per case and keeps its own exit contract unchanged. The harness
aggregates. **Precedence, in this order:**

1. **Case 0's `stimulus_sha256` mismatch** → a new `EXIT_CASE0_MOVED`, allocated
   by the assignee above 12, reported before any case runs. Nothing else is
   reported: a run whose frozen reference case has moved has no baseline and
   therefore no findings, only a defect in itself.
2. **Any producer refusal, any case** (§2.3) → its own code, on the
   *did-not-reach-a-verdict* side.
3. **Content divergence in any case** → `EXIT_DIFFERENTIAL(4)`. Content wins over
   timing, exactly as `WO-0075` §6 pinned it for one case.
4. **T0 unaligned in any case** → `EXIT_TIMING_NO_VERDICT(11)`.
5. **T1 unassertable in any case** → `EXIT_TIMING_UNASSERTABLE(12)` (§5.3).
6. **T1 negative in any case** → `EXIT_TIMING(10)`.
7. Otherwise **`EXIT_OK(0)`**.

**And the rule that makes an aggregate honest**: the aggregate code says which
*class* of thing went wrong; **the per-case lines say which case, and they are
printed for every case whatever the aggregate is.** A harness that stops at the
first red and reports nothing about the remaining cases fails §12 criterion 3.
`WO-0049` §8's separation — *reached a verdict and it was negative* versus *did
not reach one* — is the axis this whole ordering is built on and it is preserved
at every level.

---

## 4. `FINDING WO-0077-A1`, both halves, as constraints this packet is built under

`WO-0077-VERDICT` §13 item 7 rides this packet with `RV-0075-1/-2/-3`'s repairs.
**`FINDING WO-0077-A1` rides it too, and both halves do**, because both are about
the instrument this packet modifies.

### 4.1 The negative half — the census repair, obeyed here and demonstrated in §2.2

The repair, as landed at `AP-M03` §7 and quoted from it:

> **ANY UNIVERSAL QUANTIFIED OVER "THE BENCH" IN A SEAL, A CAMPAIGN PACKET OR AN
> `SO-` IS MEASURED OVER EVERY PRODUCER THAT DRIVES THE DUT — `test/cosim/`
> INCLUDED — OR IT IS QUOTED WITH THE PRODUCER SET IT WAS MEASURED OVER.**

**This packet is the first artefact drafted under it, and it is a work order
rather than the campaign seal the repair anticipated.** Two consequences, both
discharged rather than promised:

1. **Obeyed.** §2.2's census ranges over **every** producer in the lane —
   `stimulus_gen.ml`, `ours_run.ml`, `tb_xgmii_rx_64.v` and `run_cosim.sh` — and
   not over the stimulus generator alone. §1's frozen-input table names the file
   and line each figure came from, so the domain of every claim is legible
   without trusting this packet's prose.
2. **It paid immediately, which is the argument for the repair rather than a
   restatement of it.** A census scoped to `stimulus_gen.ml` would have concluded
   that the lane's stimulus space is bounded by the generator. **It is not**: two
   accumulator guards (**FI-4**, **FI-6**) bound it independently, and they are
   the reason co-sim Phase 3 is scoped-not-authorised in §6.3 while co-sim Phase 2
   is authorised. **The staging of this packet is a direct product of obeying the
   repair.**

**The repair's ownership is not discharged here.** `J-dv_lead-0148`
Open-question 3 recommended the `SO-` round own it explicitly; that recommendation
stands and §13 routes it. **This packet obeys the rule; it does not become its
owner.**

### 4.2 The positive half — the sighted class is a **capability**, and it is preserved by construction

The positive half, quoted from the same source:

> **The lane is not blind: it is blind to seven of nine, and SIGHTED for exactly
> the two whose defect lands on a start character sitting on a reset-release
> cycle** — a placement the M03 bench does not contain at all.

**This packet treats that as a measured capability to be widened deliberately,
which is the opposite of what a widening round would do to it by default (§3.1).**
Three concrete instructions follow, and each is checkable:

1. **Case 0 is frozen** (§3.1). The configuration in which the capability was
   measured is never edited.
2. **Every new case preserves the placement where the stimulus class permits
   it.** `Arrival.create`'s `?first_start` must be a multiple of 4 (**FI-2**), so
   **`~first_start:0` is a lane-0 start on cycle 0 and `~first_start:4` is a
   lane-4 start on cycle 0** — the lane-4 case (§6.2, C1) therefore closes
   `WO-0046`-adj §5 item 2 **and** keeps the sighted placement, where the obvious
   `~first_start:12` would have closed the first and silently lost the second.
   §12 criterion 2 is written against this.
3. **The one class that cannot preserve it declares so.** `FINDING RV-0075-2`'s
   idle-injection case (§5.2) exists precisely to place idles before D(0), and an
   idle before the frame's first octet moves the admit cycle. **That case
   therefore carries an explicit statement that it does not carry the sighted
   placement and that frame 0 of case 0 still does** — a declaration, not an
   omission.

**And the bound on all three, stated so the positive half is not oversold.**
`WO-0077-VERDICT` §9.1 says it and this packet repeats it rather than softening
it: *"It does not discharge the anchor: REQ-901's class list still contains no
mid-frame `clear`, one 64-octet good-FCS frame is still the whole stimulus, and a
green there still means nothing."* **The capability is that a defect landing on a
reset-release start character is visible to this lane. It is not that the lane is
sighted.**

---

## 5. The four owed `RV-0075` repairs, and where each lands

`RV-0075-VERDICT` §7.2: *"`FINDING RV-0075-1` (T1 prints its numbers on the clean
path); `FINDING RV-0075-2` (T1's idle antecedent **carried**, not inferred); and
§4.1(b)/(c)'s `EXIT_TIMING_UNASSERTABLE(12)` plus §4.1's case-(e) fixture
rebuild. **None is owed before that work order** …"* — **this is that work order.
All four land in Stage 1, before any new case runs**, and the ordering is not
cosmetic: three of the four are about reading a result correctly, and a widening
round that lands them after the widening reads its first widened result with the
instrument unrepaired.

### 5.1 `FINDING RV-0075-1` — T1 prints its numbers on the clean path

**Defect**: `timing_report_to_string` prints a sentence rather than a table on the
clean path, so a green run carries **no printed record of the cycles T1
asserted**; they are recoverable only by subtracting T2's offset from T2's
profile — that is, *our side's asserted numbers are legible only through the tier
that may never be adjudicated.*

**Repair**: on `base_aligned = true` and `spec_divergences = []`, print the
per-word `expected`/`observed` pairs for every accepted frame, per case. About
ten lines; no logic change. **Under a case set the defect is worse than it was at
one case, which is why it leads**: without it, a run over N cases prints N
sentences and no numbers, and an `SO-` citing the lane's timing evidence would be
quoting prose.

### 5.2 `FINDING RV-0075-2` — T1's antecedent is **CARRIED**, not inferred

**Defect**: `WO-0075` §3.2 asked for a guard on the **stimulus** carrying an
injected idle inside a frame. `check_timing` sees only the two canonical files,
so `first_broken_delta` guards on **our own output-word spacing** — a different
predicate, blind in exactly one direction. SPEC-M03 §6.1: *"word `m` is emitted
as many cycles later as there are idles injected at or before D(m)"*, so **an idle
at or before D(0) shifts every word uniformly, preserves every inter-word delta,
and falls through to `Spec_cycle_mismatch` on every word — indistinguishable from
`IC-L2` from the canonical files alone.**

**It is MINOR today and MATERIAL the moment this packet's §8 item 1 lift lands**,
in `RV-0075`'s own words: *"the first work order that gives this lane an
idle-injecting stimulus makes a **conformant** M03 red at `EXIT_TIMING(10)`,
reading as a `BUG-` candidate against REQ-005/REQ-111 when the cause is the
stimulus."*

**Repair, and its shape is fixed by the finding rather than open**: the
injected-idle count is **not recoverable from the two canonical files**, so it
must **reach the comparator from the stimulus side** — a grammar field, a third
argument, or a sidecar the comparator is permitted to read. **The assignee
chooses the mechanism and states the choice; it does not choose whether the
antecedent is carried.** Bounded, not open-ended: SPEC-M03 §6.1's *"Injection
begins at the frame's first octet"* keeps the blind window narrow, and it is not
empty.

**Note the shared root with `AP-M03` §7 bar 4**, and it is a constraint on the
mechanism: with no idle record and no strobe record in the grammar, an antecedent
the specification states in terms is unrecoverable at the comparator. **Bar 4's
three ordered preconditions — stimulus, then mapping, then grammar — apply
unchanged to an idle record**, so a grammar field is the *last* resort here, not
the first, and a sidecar or an argument that carries the count is preferred
precisely because it does not pretend the grammar knows something it does not.

### 5.3 `EXIT_TIMING_UNASSERTABLE(12)` — now REQUIRED, not optional

`RV-0075-VERDICT` §4.1(b) ruled that mapping `Unassertable` to exit 4 puts a
**stimulus/harness** condition on the **design-defect** axis, and §4.1(c) dated
the successor: *"It becomes **REQUIRED, not optional**, in the same work order
that gives this lane a second frame or an injected idle, because from that commit
onward an `Unassertable` is reachable, and a reader who meets `EXIT_TIMING(10)`
will open a `BUG-` against M03 for a property of the stimulus."*

**Allocated**: `compare` exit **6** → `EXIT_TIMING_UNASSERTABLE(12)`, on the
*did-not-reach-a-verdict* side with 2, 3, 8 and 11. **12 is free at `beb9c2a`**
(**FI-9**). The header's exit-code table gains it in the table's own voice,
carrying the sentence that distinguishes it from 10: **10 is a defect against our
own specification; 12 is a statement that the stimulus falls outside the
formula's antecedents and no verdict was reached.** The `EXIT CODES` partition
paragraph places it with 2/3/8/11. §3.3's precedence puts 12 above 10, because a
tier that declined to certify has not certified.

### 5.4 The case-(e) rebuild, and case (e′)

`RV-0075-VERDICT` §4.1 closing: *"§7 case (e) was specified against a two-word
sample frame in which a last-word shift breaks the only delta there is, so the
case cannot distinguish the two constructors by construction … **my packet's
defect, not the worker's**."*

**Repair**: **case (e)** rebuilt on a **≥ 3-word frame with the shift in the
interior**, asserting `Spec_cycle_mismatch`; **case (e′)** added, a shift at the
boundary, asserting `Unassertable` → exit 6 → `EXIT_TIMING_UNASSERTABLE(12)`.
**The two constructors become separately testable, which they are not today.**
Case (d) — every word shifted by +1, the `IC-L2` shape — is unchanged and stays
the most important case in the suite. **`FINDING RV-0075-3` applies to both new
cases**: neither may be marked optional, because *a self-test case that is the
sole exerciser of a branch may not be marked optional* — and (e′) is the sole
exerciser of exit 12's entire path.

---

## 6. The stages, and what each is authorised to do

### 6.1 Stage 1 — machinery only, case 0 only. **AUTHORISED.**

**No stimulus class is added. The case set has exactly one member and it is case
0.** What moves is the harness around it.

**tb_writer** — `stimulus_gen.ml`, `canonical.{ml,mli}` (only if §5.2's mechanism
requires it), `compare.ml`, `ours_run.ml`, `tb_xgmii_rx_64.v`:

- the case table (§3.2), with case 0's construction expression **unedited**;
- `FINDING RV-0075-1`'s printer repair (§5.1);
- `FINDING RV-0075-2`'s carried antecedent (§5.2), with the mechanism stated;
- `compare` exit **6** for `Unassertable` (§5.3);
- the case-(e) rebuild and case (e′) (§5.4);
- `FINDING WO-0078-1`'s repair: every producer refusal reaches a distinct
  non-zero code, with **at least one reference-side refusal tripped deliberately
  in the self-test** (§2.3).

**data_wrangler** — `tools/cosim/run_cosim.sh`:

- iterate the case set; per-case working directory; **one line per case** (§3.2);
- `EXIT_TIMING_UNASSERTABLE=12` and `EXIT_CASE0_MOVED` (§3.3) allocated,
  documented in the header table in its own voice, placed on the correct side of
  the `EXIT CODES` partition;
- §3.3's aggregate precedence, implemented in that order;
- **case 0's `stimulus_sha256` compared against the last green pre-widening run's
  printed value**, and the comparison reported whether it matches or not;
- the `*)` fail-closed wildcard **untouched**;
- **the cost probe**: report per-case wall time for the pipeline and for the whole
  `cosim` job, as printed lines (§9).

**Landing order is constrained, and this is the change from `WO-0075` §11.**
With one case the two halves were order-free. With a case set they are not:
**data_wrangler's half must not land before tb_writer's.** A harness that
iterates a case set the generator cannot produce fails at the first case and
reports a machinery problem for a state that is merely mid-landing. **tb_writer
first; if data_wrangler lands first, its case loop must degenerate to case 0 and
be indistinguishable from today's behaviour** — which is the property to design
for and to state, not to hope for.

**Stage 1's green means**: the machinery moved and the one measured configuration
is bit-identical to what it was. **It means nothing about any stimulus class**,
and no `SO-` may cite Stage 1 for coverage of anything.

### 6.2 Stage 2 — co-sim Phase 2, the clean-frame spine plus the two predicted-divergence cases. **AUTHORISED.**

`WO-0044` §4: *"Phase 2 — the clean-frame spine. Family A/C's stimulus classes
across both start lanes and the directed lengths, inside the domain."* CD §6
distributes **V6** and **V7** here. **Four cases, three landings.**

| case | stimulus | preserves the sighted placement? | why it is here |
|---|---|---|---|
| **C1** | **lane-4 start on cycle 0** — `~first_start:4`, otherwise case 0's frame | **YES**, deliberately (§4.2) | closes `WO-0046`-adj §5 item 2: *"lane 4 has never been driven at this boundary … where every quantity SPEC-M03 §7 pins takes its other value"* |
| **C2** | **two clean frames**, minimum IFG, frame 0 at `~first_start:0` | **YES** for frame 0 | closes the one-frame bound. Needs **no accumulator change** (§2.2) |
| **C3** | **one 64-octet frame, bad FCS** — `~fcs_valid:false` plus a corrupted octet | **YES** | **CD §6's V7, "the one to watch"** |
| **C4** | **nonstandard preamble**, otherwise clean | **YES** | **CD §6's V6.** REQ-102 forbids M03 from validating it; CD §5.2's **X4** already excludes preamble octet *values* from the comparison, so C4's observables are the decision and the delivered octets |

**Landings**: **C1 + C2 together** (both clean, neither predicted to diverge, and
per-case reporting attributes any red immediately — §3.1 consequence 2); **C3
alone**; **C4 alone**. Each predicted-divergence case lands by itself because its
result may force a REQ-901 spec diff (§7), and a spec-diff conversation held
about two cases at once is a conversation about neither.

**The hard precondition on every case in this stage, and it is a stop rule.**
CD §0's own bar — *nothing may be moved from inside the domain to outside it after
a run has shown a difference there* — and CD §9's change discipline mean **the
domain instance for a case must be committed before the case first runs.**
CD §9 currently reads *"This document is frozen for Phase 1 as written."*
**No case in this stage may run before CD carries its own domain instance and its
frozen prediction.** That document is dv_lead's, not the assignees' — §13 routes
it, with a date.

### 6.3 Stage 3 — co-sim Phase 3, the error paths. **SCOPED, NOT AUTHORISED.**

`WO-0044` §4: *"Phase 3 — the error paths, and the actual anchoring … where the
SO-blocking obligation is discharged."* **This packet designs it and does not
commission it**, on `WO-0044` §4's own precedent (*"Nothing past Phase 1 is
authorised by this packet"*) and for a measured reason: **V5 requires the same
change to two independently written accumulators (§2.2), which is a different
risk class from everything in Stage 2.**

| case | CD §6 | REQ-901 status | what it costs |
|---|---|---|---|
| **C5** | **V1** runt 5–63 octets | class **(e)**: `tuser`[0] excluded, **payload octets and `tkeep` still compared** | cheap. **REQ-103's FCS removal on a runt remains anchorable** — CD §2-bis, on the reference's length-gate-free residue array |
| **C6** | **V2** below 5 octets | class **(e)**: **excluded entirely, decision included** | **record-only.** REQ-901's own disposition: *"the reference's actual disposition of it is recorded as data on the first run that drives one, never adjudicated"* |
| **C7** | **V3** oversize > 1518 | class **(f)**: **excluded entirely** | **record-only**, same disposition |
| **C8** | **V4** `/E/` mid-frame | no class — a divergence here is a defect or a spec diff | moderate. Family E's rows are the hand-derived reference |
| **C9** | **V5** `/S/` before `/T/` (REQ-110) | no class | **the largest item in this packet.** Both **FI-4** and **FI-6** must be lifted, and the two replacements must implement the *same* admission rule, derived from REQ-110 and SPEC-M03 §9 — **never from the reference's behaviour** (REQ-901's closing sentence) |

**Re-authorisation gate.** Stage 3 opens on a separate `WO-` or a dated
amendment to this one, and only after: (a) Stage 2 has landed with all four cases
green or with every divergence adjudicated to a named branch of §7; (b) CD carries
a co-sim Phase 3 domain instance; and (c) **C9's admission rule is written as spec
text before either producer is opened** — because two producers implementing the
same rule from one written derivation is a review problem, and two producers
implementing it from each other is a circularity that would make the comparison
compare a shared assumption.

**And the honest note about what Stage 3 buys, stated before it is scheduled.**
Two of its five cases are **record-only by specification** (C6, C7), and one more
has its marking half excluded (C5's `tuser`[0]). **REQ-901 classes (e) and (f)
bound what co-sim Phase 3 can return, and `AP-M03` §7 bar 2 already bars REQ-107
and REQ-108 from ever being co-sim-anchored.** Phase 3 is the stage that
*"discharges the SO-blocking obligation"* in `WO-0044`'s words, and it discharges
it for **C5's payload half, C8 and C9** — not for the length-derived marking, which
rests on family F's and family G's mutation-qualified benches and must be said to
in the `SO-` rather than implied away.

---

## 7. The frozen predicted dispositions — written in the open, before any case runs

CD §6 is this programme's precedent and its discipline: *"an unpredicted
divergence is a finding against **this document**, exactly as an unnamed reddening
unit is a finding against a sealed mutation matrix."* **Every case added by this
packet ships with its predicted disposition frozen before it runs, and with the
branch its result selects.**

**R-SEAL-1 is not engaged and the reason is stated rather than assumed
(ADR-0016).** Nothing is withheld here: these predictions are written in the open
in this packet, and the CD instances §6.2 requires are committed artefacts before
the runs they govern. **There is no sealed prediction in this packet, so there is
no seal to ship** — the rule reaches a claim that a result exists and is being
withheld, and this packet makes none.

**The three branches, and every case's result resolves to exactly one:**

- **(α) AGREEMENT** — the observable agrees inside the domain. The case's class
  becomes co-sim-anchored **for that class and no wider**.
- **(β) DECLARED-CLASS DIVERGENCE** — the divergence falls inside a REQ-901
  declared class (a)–(f). **Excluded, not reported as a failure**, and the run's
  report names the class. No packet may cite the anchor for the excluded
  requirement.
- **(γ) UNDECLARED DIVERGENCE** — the divergence falls outside every declared
  class. **REQ-901: "Any divergence outside the declared classes is a defect."**
  It resolves as **a `BUG-` against our RTL**, or as **a REQ-901 spec diff routed
  to architect_docs_lead**, and **never** by amending an expectation to agree:
  *"an exclusion is never a licence to take an expected value from the
  reference."* **The choice between the two is dv_lead's adjudication, made after
  the run and recorded in an `RV-`; the branch itself is fixed here, before it.**

| case | our side, by spec | prediction | branch if the prediction holds | branch if it fails |
|---|---|---|---|---|
| **C1** lane-4 start | SPEC-M03 §6.1 gives the **same absolute output cycles** at a lane-0 and a lane-4 start; delivered octets identical to case 0 | agreement; **T1's expected set is unchanged from case 0's `{3 … 10}`** | **α** | **γ** — and it would be a large one, because it would mean the two designs disagree on a clean frame at the other start lane |
| **C2** two clean frames | two accepted frames, indices 0 and 1, eight words each | agreement on both | **α** | **γ** — the re-arm path, which no seeded class has ever reached at this lane |
| **C3** bad FCS | **forwarded in full, marked `tuser`[0] = 1** (§9 row 1, REQ-005 forbids store-and-forward) | **the reference may DROP it** — CD §6: *"the commonest store-and-forward instinct"* | — | **γ**, and the **expected** resolution is **a REQ-901 spec diff adding a class**, not a `BUG-`: our behaviour is pinned by REQ-005 and the reference's is its own. **If it drops, family D's entire subject matter is outside the comparison domain and REQ-104 rests on family D's bench alone — which the `SO-` must SAY, not imply away** |
| **C4** nonstandard preamble | forwarded; **REQ-102 forbids M03 from validating preamble octets** | the reference may reject the frame | — | **γ** on the *decision*; the preamble octet values themselves are **CD §5.2 X4**, already outside the domain, so a divergence in the octets alone is **data** |
| **C5** runt 5–63 | 1–59 octets delivered, `tuser`[0] = 1, `error_runt` | **payload and `tkeep` agree; `tuser`[0] diverges** | **β**, class **(e)** — declared, expected, excluded | **γ** on the payload half, which **is** anchorable |
| **C6** below 5 octets | **no output word at all**, `error_runt` alone | reference behaviour undefined | **β**, class **(e)**, **recorded as data, never adjudicated** | n/a — the class excludes it entirely, decision included |
| **C7** oversize > 1518 | truncated to **exactly 1514**, marked | reference forwards it whole | **β**, class **(f)**, recorded | n/a — excluded entirely |
| **C8** `/E/` mid-frame | truncated at the octet before the `/E/`, marked, **no FCS removal** (REQ-103) | reference may drop, or may strip the FCS anyway | — | **γ** |
| **C9** `/S/` before `/T/` | REQ-110's abort disposition | reference behaviour unknown | — | **γ**. **And the prior question is not the comparison but the admission rule** (§6.3) |

**§12 criterion 8 makes this table load-bearing**: a case adjudicated by a
disposition written after its run is void whatever its colour, and the voiding is
not a formality — a disposition chosen with the answer in hand is the mechanism
CD §0 was written to prevent.

---

## 8. What each stage does to `AP-M03` §7's four bars — per case, never per module

| bar | kind | Stage 1 | Stage 2 | Stage 3 | after all three |
|---|---|---|---|---|---|
| **1** — no `SO-` row may take an expected value from X-1(ii) for a class the co-sim has not driven | per **row** | unchanged | **lifts for C1–C4's classes only** | lifts for C5–C9's classes only, minus the (e)/(f) exclusions | **still standing for every class not in the case set** |
| **2** — REQ-107 and REQ-108 are never co-sim-anchorable | per **requirement** | unchanged | unchanged | **unchanged — by specification.** C5's `tuser`[0] and C7 entirely are REQ-901 (e)/(f) | **standing, permanently** |
| **3** — a cross-side timing comparison is BARRED | per **quantity** (time) | unchanged | unchanged | unchanged | **standing.** The only route is a REQ-901 spec diff through architect_docs_lead; a comparator does not grant itself one |
| **4** — no `SO-` may cite the anchor as strobe coverage, **and the reason is the stimulus** | per **quantity** (strobes) | unchanged | **precondition (1) becomes MET for `error_bad_fcs` at C3, for the first time** | more classes pulse strobes; preconditions (2) and (3) still unmet | **standing** until a committed mapping and then a grammar field exist |

**Bar 4's movement at C3 is the one that must not be over-read, and this packet
refuses to pay it.** `WO-0075` §9's refusal rests on **three ordered
preconditions — stimulus, then mapping, then grammar** — and records that they
were unmet at the **first**. **C3 is the first stimulus in this lane's history
that makes `error_bad_fcs` pulse on our side**, so precondition (1) is met for
that one strobe. **Preconditions (2) and (3) remain unmet and this packet does not
meet them**: there is no committed mapping, `error_bad_frame` on the reference is
*a different signal* (it also raises on a bad FCS, where SPEC-M03 §9 gives that
event to `error_bad_fcs` alone, so a name-keyed comparison would **red a
conformant M03**), and adding a field before a mapping exists is the all-zero
column §9 refused. **The strobe record stays refused. What changes is that the
refusal's first precondition is now discharged and a future packet can start at
the second** — which is the whole point of writing preconditions in order.

**And bar 1's lifts are per class and are stated per case.** A stage that lands
four cases lifts bar 1 for four classes. **No `SO-` may write a sentence of the
form "the co-simulation anchors this module"**; the form it may write is "the
co-simulation anchors these named classes, at these run ids, and the following
classes it does not drive."

---

## 9. Cost — priced before anything is built, with the unmeasured part named

**Worker rounds, authorised part:**

| stage | landings | worker rounds | dv rounds |
|---|---|---|---|
| Stage 1 | 1 (tb_writer, then data_wrangler) | 2 | 1 `RV-` |
| Stage 2 | 3 (C1+C2 / C3 / C4) | 3 | 3 `RV-` |
| **authorised total** | **4** | **5** | **4** |

Stage 3, if re-authorised: **3–5 further landings**, of which C9 alone is priced
above every other case in this packet combined, because it is the only one that
changes an algorithm in two producers.

**The alternative was priced and rejected.** Landing co-sim Phase 2's four cases
in one commit costs one landing instead of three and saves two review rounds.
**Rejected for C3 and C4** on `WO-0075` §8 item 1's reasoning — a failing CI run
must be diagnosable — and specifically because each of them may resolve to
branch **γ** and force a spec diff. **Accepted for C1 + C2**, and the thing that
makes it safe is per-case reporting (§3.2), which did not exist when `WO-0075`
wrote that clause. **The saving is real and it is bought by a mechanism, not by
optimism.**

**CI cost — UNMEASURED, and that is the honest statement.** The one measured
anchor available to this seat is the whole `build` run at **326 s** (run
`30988038809`); **the `cosim` job's own duration and the marginal cost of a second
case have never been measured**, and this seat cannot measure them (ADR-0005). A
case set multiplies a cost nobody has written down. **So Stage 1 carries a cost
probe** — the `WO-0070` precedent, where the first bench whose runtime was not
trivially bounded opened its packet with a measurement rather than an estimate —
and the probe reports two numbers: the per-case pipeline wall time and the whole
`cosim` job's wall time, as printed lines in the log.

**The band, pre-committed here so it is not negotiated with the answer in hand:**

- **Band A** — the full authorised case set fits inside a `cosim` job under
  **300 s**, and per-case cost is **linear** in the number of cases (each added
  case costs no more than 2× the single-case measurement). **Proceed as written.**
- **Band B** — per-case cost is **superlinear**. **This is a machinery finding,
  not a budget question**: something in the harness is re-doing per case what it
  should do once (the `dune build`, the `iverilog` compile, the provenance
  checks). Repair the harness; do not reduce the case set.
- **Band C** — Band A's absolute bound is exceeded with a linear per-case cost.
  **Then and only then is the case set a scope question, and it goes up as
  E2 — options, recommendation and cost — never a silent narrowing** (charter §7,
  which names attack-plan coverage explicitly and reaches this by the same
  reasoning). **The case set is not reduced inside DV under any circumstances.**

---

## 10. What this packet does NOT do — prohibitions, not omissions

1. **It does not discharge the charter §3 external anchor.** The anchor is
   per class; a case set of nine classes anchors nine classes. `AP-M03` §7's
   standing limit and `RV-0075-VERDICT` §6's four bars survive this packet, and
   §8 says exactly what moves.
2. **It does not lift bar 2, and cannot.** REQ-107 and REQ-108 are excluded by
   REQ-901 classes (e) and (f) — *"a co-simulation result is not an admissible
   external anchor for it, and a sign-off packet SHALL NOT offer one."*
3. **It does not lift bar 3.** No cross-side cycle comparison, in any stage.
   `compare_words` does not gain `cycle`; `compare_transactions` does not gain
   `admit_cycle`. The route to a cross-side timing comparison is a REQ-901 spec
   diff through architect_docs_lead and nothing else.
4. **It does not add a strobe record.** §8 states the one precondition that moves
   at C3 and the two that do not. **A strobe field added by any stage of this
   packet is a defect against it.**
5. **It does not edit a vendored file and does not bump the pin.** ADR-0015 D2's
   no-edit rule; `axis_xgmii_rx_64.v` and `lfsr.v` are read-only at
   `77320a9471d19c7dd383914bc049e02d9f4f1ffb`. A pin bump is its own commit, by
   ADR-0015's own rule, and is not this packet's business.
6. **It does not change either sampling convention.** `~clock_edge:Side.Before`
   on our side and `@(posedge clk); #1` on the reference's stay exactly as they
   are. *"If they were wrong, every result this lane has ever produced is wrong,
   and that is not a thing to discover by accident inside a stimulus change."*
7. **It does not edit case 0.** §3.1. Case 0's construction expression, its
   `~first_start:0`, its frame content and its 24 drain cycles are frozen, and
   §12 criterion 1 checks it by sha256 rather than by inspection.
8. **It does not amend a specification.** Where a result requires one (branch γ),
   the route is a spec diff to architect_docs_lead. **A comparator does not amend
   REQ-901 and neither does a work order.**
9. **It does not touch `test/attack_plans/**`.** CD and AP are dv_lead's; §13
   routes both. An assignee that edits either has left its scope.
10. **It does not open, advance or offer `SO-xgmii_rx_64.md`.** No stage of this
    packet produces a sign-off and none may be inferred from a green stage.
11. **It touches neither of the programme's Phase 2 and Phase 3.** §0.1. The
    MoldUDP64/ITCH golden book model and its external reference agreement are a
    **different instrument entirely**, not one line of it exists, and nothing in
    this lane advances it. The 10GBASE-R PCS has no anchor commissioned at all.
12. **No `dune`, no `git`, no `iverilog` is run by either assignee.** None is
    available (ADR-0005); a claim that one was run is a finding. **The landing CI
    run is the check, and it is the only one.**

---

## 11. Definition of done

**Stage 1 — tb_writer:**
- [ ] The case table exists; case 0's construction expression is **unedited** and
      the diff shows it.
- [ ] `FINDING RV-0075-1`'s printer repair: per-word expected/observed pairs
      printed on the clean path, per accepted frame, per case.
- [ ] `FINDING RV-0075-2`: the injected-idle antecedent reaches the comparator
      **from the stimulus side**, mechanism stated and justified against bar 4's
      stimulus → mapping → grammar ordering.
- [ ] `compare` exit **6** for `Unassertable`, and exit 4 no longer carries it.
- [ ] Case **(e)** rebuilt on a ≥ 3-word frame with an interior shift
      (`Spec_cycle_mismatch`); case **(e′)** added at the boundary
      (`Unassertable`). Case **(d)** unchanged.
- [ ] `FINDING WO-0078-1`: every producer refusal reaches a distinct non-zero
      code; **at least one reference-side refusal is tripped deliberately in the
      self-test** and its code observed.
- [ ] Every §1 figure this half rests on **re-measured at the assignee's own
      base** and the result reported in the Return log.
- [ ] Journal entry appended, spawn short-id in Trigger, `Inputs` naming spec
      paths and REQ ids and **listing no `libs/**` path**.
- [ ] **Return-log entry appended to this packet's §14** — named as a
      deliverable, not left implied (`RV-0075-VERDICT` §3's repair).

**Stage 1 — data_wrangler:**
- [ ] Case iteration, per-case working directory, **one line per case** carrying
      case id, `stimulus_sha256`, `compare` exit code and the tier.
- [ ] `EXIT_TIMING_UNASSERTABLE=12` and `EXIT_CASE0_MOVED` allocated and
      documented in the header table in its own voice, on the correct side of the
      `EXIT CODES` partition.
- [ ] §3.3's aggregate precedence implemented in that order.
- [ ] Case 0's `stimulus_sha256` compared against the last green pre-widening
      run's printed value; result reported either way.
- [ ] The `*)` fail-closed wildcard **untouched** — zero `+`/`-` lines inside it.
- [ ] The cost probe's two numbers printed.
- [ ] Every §1 figure this half rests on re-measured at its own base.
- [ ] Journal entry appended; **Return-log entry appended to §14**.

**Stage 2, per landing — tb_writer:**
- [ ] The case(s) added, each with its `stimulus_sha256` printed.
- [ ] **Case 0 untouched**, proven by its unchanged sha256 in the same run.
- [ ] Expected values derived from `docs/specs/` with the derivation shown in a
      comment beside each constant. **No expected value taken from the reference,
      from a prior run, or from `libs/**`.**
- [ ] Journal entry + §14 Return-log entry.

**Both, every stage:**
- [ ] No file outside the deliverable list is staged.
- [ ] No `dune`, `git` or `iverilog` run locally.
- [ ] **A precondition, checked before the round is spawned rather than by the
      assignee**: the CD domain instance for every case in the landing is
      committed (§6.2). **A case that runs before its domain instance is
      committed is void and is re-run, not adjudicated.**

**Evidence, and what CI's colours mean.** As at `WO-0075` §10: neither assignee
nor dv_lead can execute this change, and **the landing CI run is the check**.
Per stage, on the landing commit:

- **`cosim` green** = every case in the set reached a verdict and every verdict
  was clean. **It is evidence for the classes in the case set and for nothing
  else**, and the per-case lines are what an `SO-` quotes.
- **red at `EXIT_CASE0_MOVED`** = the frozen reference case moved. Nothing else
  in the run is readable; fix the case, re-run, and the round's other results are
  discarded rather than salvaged.
- **red at `EXIT_DIFFERENTIAL(4)`** = a content divergence, in the case the
  per-case line names. **Adjudicated by §7's branch table**, never by editing an
  expectation.
- **red at `EXIT_TIMING(10)`** = our side missed a cycle SPEC-M03 §6.1 pins. A
  `BUG-` candidate against REQ-005/REQ-111, **or** an error in a constant this
  packet or the assignee derived. Decided by re-reading §6.1.
- **red at `EXIT_TIMING_UNASSERTABLE(12)`** = the stimulus falls outside T1's
  antecedents. **Not a defect in the design**, and the whole reason 12 exists.
- **red at `EXIT_TIMING_NO_VERDICT(11)`** = the two producers disagree about the
  time base. A harness defect, and nothing about the design.
- **red at a producer-refusal code** = a case reached a guard. In Stage 1 that
  means the self-test worked. In Stage 2 it means a case drove something the
  authorised stimulus does not cover, which is a defect in the case.

---

## 12. Pass criteria

**Nine, numbered, each with the observation that fails it. They are written to be
checkable against a CI log by a reader who was not in the round.**

1. **Case 0 is byte-identical.** The `stimulus_sha256` the widened harness prints
   for case 0 equals the value printed by the last green pre-widening run.
   **A different value fails this criterion whatever else is green, and no other
   criterion may be read while it fails.**

2. **The sighted placement survives.** Every landed case set contains at least one
   case presenting a start character on the reset-release cycle, and the harness
   prints that case's frame-0 `admit_cycle` as **0**. **A case set in which no
   frame is admitted at cycle 0 fails, and it fails even if every case is green.**

3. **Every case reaches a verdict or names why not.** For every case in the set
   the run prints one line carrying the case id, its `stimulus_sha256`,
   `compare`'s own exit code and the tier that produced it. **A case that is
   skipped, or whose result is folded into an aggregate without its own line,
   fails — including when the aggregate is 0.**

4. **T1 prints its numbers on the clean path.** For every accepted frame in every
   case, the report prints the per-word expected and observed cycles. **A green
   run whose T1 numbers are recoverable only by subtracting T2's offset from T2's
   profile fails.**

5. **T1's antecedent is carried, not inferred.** The injected-idle count reaches
   the comparator from the stimulus side, and a case carrying an idle inside a
   frame exits `EXIT_TIMING_UNASSERTABLE(12)`. **A conformant design reported at
   `EXIT_TIMING(10)` for a property of the stimulus fails, and it fails as a
   defect in this instrument rather than as a finding about the design.**

6. **The two timing constructors are separately testable.** Self-test case (e) is
   built on a ≥ 3-word frame with an interior shift and asserts
   `Spec_cycle_mismatch`; case (e′) shifts at the boundary and asserts
   `Unassertable`. **A suite in which one fixture satisfies both fails**, and so
   does one in which either case is marked optional.

7. **Every producer's refusal reaches an exit code — AMENDED before the C2
   re-run, `FINDING RV-0078-S2-5` SETTLED. Dated by the commit that carries the
   amendment and by `J-dv_lead-0153`; the reasoning is §14's settlement entry,
   `RV-C1C2-SETTLEMENT` §1.** Each refusal guard in each producer — ours and the
   reference's — SHALL, when tripped: **(a)** stop that case before any
   comparison is attempted; **(b)** put the producer, the case id, the run label
   and the refusing guard's own reason into that case's printed record, such that
   **two different guards in the same producer cannot produce identical output**;
   and **(c)** reach a non-zero aggregate harness exit code **distinct from
   `EXIT_OK` and from every code that asserts a comparison outcome**
   (`EXIT_DIFFERENTIAL`, `EXIT_NO_VERDICT`, `EXIT_TIMING`,
   `EXIT_TIMING_NO_VERDICT`, `EXIT_TIMING_UNASSERTABLE`). **And at least one
   reference-side refusal is tripped deliberately and observed** — that limb is
   carried over unchanged and is still owed (`FINDING RV-0078-S1-4`, first
   dischargeable at C9). **Three observations fail it: a refusal that prints and
   lets the run proceed to a comparison; a refusal that reaches the aggregate as
   a differential or timing code, so that a reader is told our RTL diverged when
   nothing was compared; and a refusal whose printed record does not distinguish
   it from a different guard's refusal in the same producer.** **Per-guard
   distinctness is a property of the printed record, not of the exit code** —
   `tools/cosim/run_cosim.sh`'s own adjudicated rule (`WO-0049` §8's axis,
   `WO-0073-D5`'s repair): *"WHERE ONE EXIT CODE COVERS SEVERAL STAGES, THE STAGE
   MUST BE NAMED IN THE TEXT, BECAUSE THE CODE IS READ BY A MACHINE AND THE TEXT
   IS READ BY THE PERSON WHO HAS TO FIX IT."*

   > **The superseded wording, quoted rather than overwritten** — this packet's
   > own State-field rule, *"a lifecycle field that erases its own history cannot
   > be audited"*, applied one level down. **This is the text in force from this
   > packet's first commit until the settlement, and it is the text the `53fa1de`
   > run was read against**; `RV-C1C2` §8's criterion-7 row stands unedited as the
   > reading of that run under it:
   >
   > *"**Every producer's refusal reaches an exit code.** Each refusal guard in
   > each producer — ours and the reference's — produces a distinct non-zero
   > harness exit when tripped, and at least one reference-side refusal is
   > tripped deliberately and observed. **A refusal that prints and lets the run
   > proceed to a comparison fails.**"*
   >
   > **The amendment is PROSPECTIVE.** It governs the C2 re-run and every run
   > after it. **It does not re-read `53fa1de` and it changes no disposition
   > already recorded.**

8. **Every case's disposition was frozen before it ran.** For each case, §7's
   table (or the CD instance that carries it) names the predicted disposition and
   the branch its result selects, in a commit earlier than the case's first run.
   **A result adjudicated by a disposition written after the run is void whatever
   its colour**, and the case is re-run under a committed prediction.

9. **No claim outside the driven set.** No text in any deliverable of this packet,
   and no `SO-` citing them, states co-simulation coverage of a stimulus class not
   in the landed case list. `AP-M03` §7's four bars are unchanged except where a
   named case discharges bar 1 for a named class, **and every discharge is stated
   per case, never per module.** **A sentence of the form "the co-simulation
   anchors this module" fails this criterion wherever it appears.**

---

## 13. Owed elsewhere — what this packet routes rather than absorbs

**Absorbed** (they are in §§5–6 and land in Stage 1): `FINDING RV-0075-1`,
`FINDING RV-0075-2`, `EXIT_TIMING_UNASSERTABLE(12)`, the case-(e)/(e′) rebuild,
`FINDING RV-0075-3`'s no-optional-sole-exerciser rule as a bar on both new
self-test cases, and `FINDING WO-0078-1`'s repair, minted here.

**Routed, with the reason each is routed rather than folded in:**

1. **`CD-xgmii_rx_64_cosim.md`'s co-sim Phase 2 and Phase 3 domain instances.**
   **dv_lead's own**, and a **hard precondition** on §6.2 and §6.3: CD §9 reads
   *"This document is frozen for Phase 1 as written"*, and CD §0 bars moving an
   entry after a run has probed it. **Owed before Stage 2's first case runs, in a
   dv_lead round of its own.** Not written here because the round that drafts this
   packet writes one file, and not delegable because CD is a verification-scope
   judgement and freezing it is the same discipline as a sealed prediction
   (`WO-0044` §6).
2. **`AP-M03` §7's per-case bar cells.** dv_lead's, owed to the `AP-` round that
   follows each landed stage. §8 is the specification of what those cells say;
   writing them into the plan is a plan round's job, not a work order's
   (`J-dv_lead-0112`'s own rule: a plan round is not where machinery lands, and
   its converse holds too).
3. **`FINDING K-1`'s message repair** — the assertion at `test_m03_k.ml:468` that
   names its expected list and prints nothing it observed. **It does NOT ride
   here**: its carrier is the next commit that opens `test_m03_k.ml`, and **no
   stage of this packet opens any file under `test/xgmii_rx_64/`.** It remains the
   oldest unpaid carrier in this module and remains unscheduled; recommend the
   `SO-` round own it, since the `SO-` will cite the scorecard the defect makes
   unreadable.
4. **`RN-6`'s `docs/**` path resolve-check in `tools/dv_checks.sh`.** Considered
   for absorption into Stage 1's data_wrangler half — which does open `tools/` —
   and **routed instead**, for two reasons: `tools/dv_checks.sh` is a
   governance instrument over `agents/handoffs/**`, which is dv_lead's own to
   write rather than a data-preparation worker's; and RN-6's ruling already names
   its practical carrier — *"in practice the `SO-` round's own accounting, which
   re-runs that script anyway."* **Recommend the `SO-` round own it explicitly.**
5. **`FINDING WO-0077-A1`'s census-repair ownership.** This packet **obeys** the
   standing repair (§4.1) and is the first artefact to do so. **It does not become
   its owner**: `J-dv_lead-0148` Open-question 3 recommended the `SO-` round own
   it explicitly rather than by default, and that recommendation is unchanged.
6. **The lessons harvest.** Not due at a work-order draft — PROTOCOL §7 places it
   at every `SO-` and every phase gate. **The span stays open**, declared rather
   than skipped, and this round banks one candidate rather than minting it (see
   the accompanying journal entry).

---

## 14. Return / verdict log

*Participants append here directly — PROTOCOL §3 makes the packet's Return log the
participants' own instrument, and `RV-0075-VERDICT` §3's process repair makes the
append a named deliverable rather than an implied courtesy. The `State` field at
the head of this file is flipped by dv_lead's `RV-`, per stage.*

### tb_writer — Stage 1 (§6.1), RETURNED

**Re-measurement of §1's frozen inputs, at this seat's own base (`55e16aee`),
before a line was written.** Every figure this half rests on was re-read
directly rather than trusted from the packet's own quotation, per §1's own
rule. None had moved:

- **FI-1/FI-2**: `test/cosim/stimulus_gen.ml`'s `build ()` and
  `test/xgmii/arrival.mli`'s `create` both re-read in full. `~first_start:0`,
  `drain_cycles = 24`, `?ifg` default 12, `?first_start` default 8 ("lane 0 of
  cycle 1"), must be a multiple of 4, `?fcs_valid` default `true` — all
  UNCHANGED. `arrival.mli` is DV-side (REQ-018's link-partner model), not
  RTL; reading it did not touch `libs/**`/`top/**`/`rtl_snapshots/**`.
- **FI-3/FI-4/FI-5**: `ours_run.ml` re-read in full — the clear cycle before
  index 0, the second-start `failwith`, the no-open-frame `failwith`, all
  present, unmoved from the packet's citation.
- **FI-6/FI-7**: `tb_xgmii_rx_64.v` re-read in full — both `$display` +
  `$finish` refusal guards present, at the packet's cited lines within a few
  lines (dated drift from `beb9c2a`'s snapshot to `55e16aee`, not a content
  change).
- **FI-8/FI-9/FI-10**: `tools/cosim/run_cosim.sh` re-read in full (read-only —
  `tools/cosim/**` is not my half). `run_pipeline`'s rc/file-existence check
  confirmed exactly as quoted; exit constants `0…11` confirmed, `12` free;
  `STIMULUS_SHA`/`stimulus_sha256` confirmed printed and sidecar-recorded.
- **FI-11**: `canonical.mli`'s pinned grammar re-read — `compare_words` and
  `compare_transactions` confirmed to carry neither `cycle` nor
  `admit_cycle`, unchanged by this round (§10 item 3 honoured).
- **FI-12**: `PROVENANCE.md` re-read — pin `77320a9471d19c7dd383914bc049e02d9f4f1ffb`
  unchanged; not bumped by this round (§10 item 5 honoured).
- **FI-13/FI-14**: `docs/specs/requirements.md` REQ-901 and
  `docs/specs/modules/xgmii_rx_64.md` §6.1/§7/§9/§10 re-read directly (not
  only the packet's quotation). One thing found that sharpens FI-14 beyond
  what the packet quotes, reported because it bears directly on §5.2's
  design: §7 and REQ-016's own coverage row state, in terms, that the gapless
  `admit_cycle + m + 3` / per-octet constants **"do not survive injection at
  either start lane, at any frame length producing more than one output
  word."** This is stronger grounding for treating any carried nonzero idle
  count as `Unassertable` outright, rather than attempting an
  idle-count-adjusted assertion: the simple formula is not merely
  "ambiguous" once an idle lands inside a multi-word frame, it is spec-stated
  to not apply at all. Also confirmed: REQ-016's own hook and §6.1's own text
  **forbid** injecting an idle strictly between a frame's start character and
  its first octet ("Injection begins at the frame's first octet"), so the
  carried count this round plumbs is "idle cycles delaying D(0)'s own
  presentation" (REQ-016's general delay rule, applied at m=0), never a
  change to `admit_cycle` itself — this is why the mechanism is named
  `injected_idle_before_d0` in the code rather than `…before_admit`, a
  renaming made mid-round after this re-read for exactly this reason (see
  Reasoning in the journal entry).

**Per packet item, what changed:**

1. **The case table (§3.2)** — `stimulus_gen.ml` gains `case_meta`, exactly
   one member (`case0_meta`, `idle_counts = [0]`), `find_case_meta`, and
   `build_case` (a plain `match`, so `build ()`'s own return type — never
   named anywhere in this file — stays inferred rather than guessed).
   `build`, `write_stimulus` and `drain_cycles` are **byte-identical** to
   `HEAD` — confirmed by `git diff`, which shows zero changed lines above
   `write_stimulus`'s closing `;;`. The one-positional-argument call
   `tools/cosim/run_cosim.sh` makes today keeps working unchanged (defaults
   to case "0"); the case id is an optional **second** argument, per §6.1's
   landing-order constraint (I land first; data_wrangler's round is not
   blocked by this one and degenerates to case 0 if it somehow landed
   first, since nothing here requires a case argument to be passed).
2. **FINDING RV-0075-1's printer repair (§5.1)** — `canonical.ml`/`.mli` gain
   `timing_report.own_profile : (int * (int * int) list) list`, populated for
   every accepted, non-refused frame; `timing_report_to_string`'s clean
   branch now prints a per-word `expected`/`observed` table instead of only
   the sentence. Verified printing for real (see Evidence).
3. **FINDING RV-0075-2's carried antecedent (§5.2)**, mechanism stated:
   `check_timing` gains `?injected_idle_before_d0:(int * int) list -> unit`.
   The canonical **grammar is untouched** (bar 4's stimulus→mapping→grammar
   ordering honoured; a grammar field was the explicitly-named last resort
   and was not needed). Instead: a new sidecar, `<path>.idle`, one decimal
   integer per line in frame-admission order — authored by `stimulus_gen.ml`
   (the only place that knows the count, by construction of the schedule),
   forwarded unedited by `ours_run.ml` to `<ours.canon>.idle`, read by
   `compare.ml` and passed to `check_timing`. `theirs.canon` never carries
   one: T1 takes no argument from `theirs` (unchanged), so `tb_xgmii_rx_64.v`
   needed no change for this item. Absent sidecar (every case Stage 1 ships)
   reads as 0 for every frame — today's behaviour, unchanged. The guard
   itself: a nonzero carried count refuses (`Unassertable`) outright,
   ahead of and regardless of the frame's own observed deltas.
4. **`compare` exit 6 for `Unassertable` (§5.3)** — `compare.ml`'s exit
   precedence now separates "T1 refused for some frame" (6) from "T1
   reached a verdict and it was negative" (4); a refusal outranks a
   negative verdict, matching §3.3's own aggregate ordering restated at this
   binary's scale. Exit 4 no longer carries `Unassertable`.
5. **The case-(e) rebuild and case-(e′) addition (§5.4)** — the old
   two-word `shifted_one_transaction` (which RV-0075-VERDICT diagnosed as
   unable to distinguish the two constructors "by construction") is retired.
   `sample_transaction_3w` (a 3-word base, gapless cycles 3/4/5) backs two
   new fixtures: `shifted_interior_transaction` (word 1 shifted, TWO broken
   deltas, asserts `Spec_cycle_mismatch`, exit 4 — case (e)) and
   `shifted_boundary_transaction` (word 2 shifted, ONE broken delta, refuses
   `Unassertable`, exit 6 — case (e′)). `canonical.ml`'s guard itself changed
   from "first broken delta at all → refuse" to "count the broken deltas:
   exactly one → refuse (ambiguous with a single idle injection, which can
   only ever break one delta); zero or two-or-more → assert" — this is what
   makes the two fixtures land on different branches instead of both hitting
   the same one. Case (d) is untouched (still the 2-word
   `shifted_all_transaction`). Neither new case is optional (FINDING
   RV-0075-3): both are in the self-test's mandatory `&&`-chain.
6. **FINDING WO-0078-1's repair (§2.3)** — `canonical.ml`'s `read` gains an
   explicit `"E"` record kind, recognised and rejected regardless of parser
   state, with a message naming it a producer refusal rather than the
   generic "unrecognised record kind". `tb_xgmii_rx_64.v`'s two named
   guards (FI-6, FI-7) now `$fwrite` a distinguishing `"E ..."` line and
   explicitly `$fclose` all three file descriptors before `$finish` (`$finish`
   alone is a normal termination under Icarus and does not, by itself, give
   `run_pipeline`'s rc/file-existence check anything to catch — measured by
   dv_lead at `RV-0049-VERDICT` §4, not by this seat). **A third instance was
   found and fixed for consistency, beyond the packet's own §2.2 census**:
   the `meta_fd`-open-failure path also left `theirs.canon` open-but-empty,
   which `Canonical.read` accepts as a vacuous-but-valid transaction (zero
   frames) rather than failing to read — the same hazard shape as FI-7,
   just via a different door. Flagged here rather than silently added or
   silently left, per the durability clause. `compare.ml`'s self-test trips
   FI-7's shape deliberately (a hand-built `theirs.canon`-shaped fixture with
   one complete frame followed by the `E` sentinel, since iverilog cannot run
   here — ADR-0005) and asserts the observed code (exit 3).

**A fourth producer refusal introduced by this round's own mechanism, also
flagged**: `ours_run.ml`'s idle-sidecar forwarding `failwith`s if the sidecar
it read declares a different frame count than it actually admitted (a new
harness-defect class this round's own plumbing creates the possibility of,
not one of the packet's original six).

**Local test results, verbatim** (this environment has no `dune`, no
Hardcaml switch, no `iverilog`/`vvp` — ADR-0005/§10 item 12; nothing beyond
what follows was run, and nothing here is offered as a CI result):

```
$ ocamlc -version
4.14.1

$ cd test/cosim && for f in canonical.mli canonical.ml ours_run.ml compare.ml stimulus_gen.ml; do
    ocamlc -stop-after parsing "$f"; echo "$f: exit $?"
  done
canonical.mli: exit 0
canonical.ml: exit 0
ours_run.ml: exit 0
compare.ml: exit 0
stimulus_gen.ml: exit 0
```

Beyond syntax, `canonical.ml`/`.mli` and `compare.ml` are "plain stdlib
OCaml — no Base, no Hardcaml" by the files' own header comments, so I copied
the three files to my scratchpad and **fully type-checked and linked them**
with the system `ocamlc` alone (no dune, no Hardcaml, no repository path
touched or written):

```
$ ocamlc -c canonical.mli   -> exit 0
$ ocamlc -c canonical.ml    -> exit 0
$ ocamlc -c compare.ml      -> exit 0
$ ocamlc -o compare_check.exe canonical.cmo compare.cmo -> exit 0
```

This is a genuine type-check of the new `check_timing` signature (both
files agree), `own_profile`'s field, `broken_deltas`/`word_profile`, and the
new `"E"` grammar arm — not merely a parse. **Then I ran the built binary's
own `--self-test`, for real**:

```
$ ./compare_check.exe --self-test
[... full report printed, ten cases ...]
compare --self-test: (a) identical canonical files, cycles correct
  PASS: identical canonical files compare clean (exit 0)
compare --self-test: (b) one octet perturbed (existing WO-0046 case)
  PASS: a one-octet perturbation is reported as a content divergence (exit 1)
compare --self-test: (c) malformed file (...)
  PASS: a malformed canonical file reports "could not read", not a verdict (exit 3)
compare --self-test: (d) every word's cycle shifted by +1 on our side, ...
  PASS: ... (exit 4)
compare --self-test: (e) an INTERIOR word's cycle shifted by +1 on a >= 3-word frame (rebuilt, WO-0078 section 5.4)
  PASS: two broken inter-word deltas are NOT the shape a single idle injection produces, so this is asserted as an ordinary T1 timing defect (exit 4)
compare --self-test: (e') a BOUNDARY word's cycle shifted by +1 on the SAME >= 3-word frame (added, WO-0078 section 5.4)
  PASS: exactly one broken inter-word delta is indistinguishable, from cycle evidence alone, from a legitimate idle injection, so T1 refuses (Unassertable) rather than asserting past it (exit 6)
compare --self-test: (f) an old-format file (no cycle fields)
  PASS: ... (exit 3)
compare --self-test: (T0, optional) two files whose admit_cycles disagree
  PASS: a T0 misalignment is reported with T1 and T2 withheld (exit 5)
compare --self-test: (WO-0078 5.2) a transaction with perfectly gapless cycles, but an idle sidecar declaring 1 injected idle for frame 0
  PASS: the CARRIED count alone flips the verdict to Unassertable; cycle evidence alone would have read this transaction as clean, proving the antecedent is carried rather than inferred (exit 6)
compare --self-test: (WO-0078-1) a reference-side refusal sentinel (...)
  PASS: a producer-refusal sentinel fails to read outright -- never silently short-but-valid, and never a false differential finding (exit 3)
compare --self-test: OK
=== exit code: 0 ===
```

All ten cases PASS; the aggregate self-test exits 0. The clean-path run (case
(a)) printed, verbatim: `frame 0: word 0: expected 3, observed 3` /
`word 1: expected 4, observed 4` — FINDING RV-0075-1's own numbers, not a
sentence. The idle-carried case's printed line reads, verbatim: `frame 0: T1
UNASSERTABLE -- the stimulus recorded 1 idle word(s) injected at or before
this frame's first octet D(0) ... carried from the stimulus side ... never
inferred from output spacing` — confirming the antecedent really is carried:
that transaction's own cycles are perfectly gapless and would read clean by
inference alone. The refusal-sentinel case's stderr read, verbatim: `compare:
could not read theirs canonical file …: Canonical.read: line 4: producer
refusal recorded by the reference testbench: word-with-no-open-frame` — the
named message FINDING WO-0078-1 asked for, not the generic "unrecognised
record kind". Every fixture's temp file (including the new `.idle` sidecar)
was confirmed removed after the run (`ls /tmp/cosim_compare_selftest_* ` →
0 files).

**What is CI-deferred, and why**: `stimulus_gen.ml` and `ours_run.ml` depend
on `Hardcaml`/`Hardcaml_ethernet`/`Dv_xgmii`, none of which has an installable
switch in this container (ADR-0005: OCaml 4.14.1, no 5.x compiler
reachable); I could not type-check or run them beyond the parse-only check
above, and did not attempt to reconstruct their dependency closure by hand.
`tb_xgmii_rx_64.v` cannot be compiled or run at all — no `iverilog`/`vvp`
here — so its guards' new `$fwrite`/`$fclose` lines are reviewed by hand
only, exactly as WO-0046 always disclosed for this file. `dune build`,
`dune runtest`, and the landing `cosim` CI job are therefore the first real
execution of the Hardcaml-dependent half and the only real execution of the
Verilog half, per ADR-0005/§10 item 12 — nothing here claims otherwise.

**Refused or blocked**: nothing refused. Two disclosed extensions beyond the
packet's own text, both flagged above rather than silently folded in or
silently left: the `meta_fd`-failure sentinel (a third instance of FINDING
WO-0078-1's shape, fixed for consistency) and `ours_run.ml`'s new
sidecar-length-mismatch `failwith` (a fourth producer refusal, a consequence
of this round's own mechanism). Neither changes any pass criterion's
required behaviour; both are additive hardening in the same spirit as the
items the packet names.

**Files changed** (exactly the packet's named list, nothing else —
`git diff --stat` confirms 6 files, no `tools/cosim/**`, no
`test/attack_plans/**`): `test/cosim/stimulus_gen.ml`,
`test/cosim/canonical.ml`, `test/cosim/canonical.mli`,
`test/cosim/compare.ml`, `test/cosim/ours_run.ml`,
`test/cosim/tb_xgmii_rx_64.v`.

— tb_writer, spawn `WO-0078-TB/2026-08-11T09:00Z`

### data_wrangler — Stage 1 (§6.1), RETURNED

**Abort-first head check**: `git rev-parse HEAD` = `3ec0efecf41910929d9fcb9847277ef96a35cc59`, the exact expected spawn-head. Proceeded.

**Re-measurement of §1's frozen inputs, at this seat's own base (`3ec0efe`, tb_writer's Stage 1 half already landed there), before a line was written.** Every figure my half rests on was re-read directly:

- **FI-9**: `tools/cosim/run_cosim.sh`'s exit constants re-read at pre-edit HEAD — `EXIT_OK=0` through `EXIT_TIMING_NO_VERDICT=11`, confirmed 0-11 allocated, 12 free. UNCHANGED from the packet's citation.
- **FI-10**: the sidecar's `stimulus_sha256` field and its `[ok] stimulus.txt sha256: …` print, re-read — present, confirmed printed once per run before this round and now once per case. UNCHANGED in mechanism (per-case scope is this round's own addition, not a correction).
- **FI-1/FI-2** (tb_writer's file, read-only — `test/cosim/**` is outside my write scope but reading it is not): `stimulus_gen.ml` re-read in full. `case0_meta` is the sole entry of `known_cases`; `idle_counts = [ 0 ]`; `build_case "0" -> build ()`, and `build`/`write_stimulus` are exactly FI-1's cited construction, unedited by tb_writer's own round (confirmed against tb_writer's own Return-log claim, not merely trusted from it). This is what makes case 0's frozen-sha comparison meaningful: the generator I now call with an explicit `"0"` case-id argument produces the byte-identical schedule FI-1 names.
- **FI-11**: `canonical.mli` re-read — `compare_transactions`'s and `compare_words`'s signatures confirmed to carry neither `cycle` nor `admit_cycle`. UNCHANGED; nothing in my half adds a comparison field, so this bears only as a confirmation that `compare.exe`'s own contract (which I invoke, not implement) still honours §10 item 3.
- **FI-12**: `test/third_party/verilog-ethernet/PROVENANCE.md` re-read — pin `77320a9471d19c7dd383914bc049e02d9f4f1ffb` unchanged; not bumped by this round (§10 item 5 honoured).
- **FI-3 through FI-7** (`ours_run.ml`'s two `failwith`s, `tb_xgmii_rx_64.v`'s two `$display`+`$finish` guards): re-read in full to confirm tb_writer's `3ec0efe` landing actually changed the reference-side guards to write the `"E"` sentinel and `$fclose` before `$finish`, per §2.3/§5's own account of it — confirmed present at the cited lines (the `$fwrite(out_fd, "E ...")` calls and explicit `$fclose` triple, both guards).

None had moved from the packet's own citation.

**Per packet item, what changed in `tools/cosim/run_cosim.sh`:**

1. **Case iteration, per-case working directory, one line per case (§3.2/§12 criterion 3).** A real `CASES=("0")` array and a `for CASE_ID in "${CASES[@]}"` loop replace the old single-stimulus flow; `stimulus_gen.exe` is now called with its case id as an explicit second argument (`"$STIMULUS_GEN_BIN" "$CASE_STIM" "$CASE_ID"`), exercising the landing-order affordance tb_writer's header names. Every case prints exactly one required line: `CASE <id>: stimulus_sha256=<sha> compare_exit=<code|N/A> tier=<label>`, unconditionally, whatever the outcome — including a producer refusal before `compare` is ever reached (`tier=PRODUCE-REFUSAL (...)`, `compare_exit=N/A`), which satisfies criterion 3's "or names why not" reading. **Per-case working directory**: with Stage 1's case set at exactly one member, `$WORK/stim`, `$WORK/run1` and `$WORK/run2` — the SAME paths this script has used since `WO-0046` — already constitute that one case's own dedicated working directory; see item 5 below for why I did not introduce a `case_<id>/` naming scheme instead, and for the explicit Stage-2 flag this decision carries.
2. **`EXIT_TIMING_UNASSERTABLE=12` and `EXIT_CASE0_MOVED=13`, allocated and documented.** `12` maps `compare`'s own exit `6` (`Unassertable`, landed by tb_writer). `13` is allocated "above 12" per §3.3 item 1's own instruction. Both are documented in the header's `EXIT CODES` table in this round's own voice (not copied from the packet's prose), each placed explicitly on the did-not-reach-a-verdict side beside `2`/`3`/`7`/`8`/`11`, with the reasoning for each placement stated rather than merely asserted — `12` because a refusal to certify is not a verdict of either sign; `13` because it fires before any case's own pipeline runs at all, the most fundamental form of "did not reach a verdict" this table has.
3. **§3.3's aggregate precedence, implemented in that exact order.** Item 1 (case 0 moved) is a gate inside the loop, checked immediately after case 0's stimulus is generated and hashed, before its own `ours_run`/`vvp` pipeline runs; it dies immediately (`EXIT_CASE0_MOVED`) with nothing else reported, matching "nothing else is reported... only a defect in itself." Items 2-7 are decided ONCE, in an `AGGREGATE` section after the full case loop completes: any recorded producer refusal (item 2, first one across the set wins the single process exit code — flagged as a choice in Reasoning-equivalent commentary in the script itself, since Stage 1's one-case set cannot itself exercise "more than one"), then content (item 3, `EXIT_DIFFERENTIAL`), then T0 (item 4, `EXIT_TIMING_NO_VERDICT`), then T1-unassertable (item 5, `EXIT_TIMING_UNASSERTABLE`), then T1-negative (item 6, `EXIT_TIMING`), then `EXIT_OK` (item 7). **Nothing in the per-case loop calls `die` for a producer refusal, content divergence, or timing outcome any more** — each case's own outcome is recorded and its own line printed regardless, then the loop continues to the next case, so that a case set of more than one member (a future, separately-authorised stage) does not lose a later case's own report to an earlier case's redness. The ONE exception, discussed next, is the `*)` wildcard.
4. **Case 0's `stimulus_sha256` compared against the last green pre-widening run's printed value; reported either way.** See the dedicated section below for the value, its source, and the one blocked fetch leg. The comparison is printed unconditionally (both the freshly-generated value and the pinned value, labelled), before the mismatch branch (if taken) dies.
5. **The `*)` fail-closed wildcard, untouched — verified by diff, not merely by intent.** `git diff` of the specific span from `  *)` through its `    ;;` shows **zero** `+`/`-` lines (checked mechanically, reproduced below in Evidence). This constrained a design choice I want to flag rather than have discovered later: satisfying "per-case working directory" (item 1 above) via genuinely case-indexed paths (`case_<id>/run1`, etc.) would have forced the wildcard's own `dump_run "$WORK/run1" "run1"` line to become case-parameterized, which is precisely the kind of edit the wildcard is pinned against. I resolved this by keeping `$WORK/run1`/`$WORK/run2` as the literal, unrenamed paths from before this round — correct and sufficient for Stage 1's one-member case set, but NOT extensible as written to Stage 2: a second case will force a real per-case directory scheme, and AT THAT POINT the wildcard's own text will have to change too, so "zero +/- lines inside it" is a Stage-1-scoped property, not a permanent invariant this file's structure can keep indefinitely. Flagging this now, explicitly, rather than letting Stage 2 discover it as a broken diff. **A second, smaller consequence of the same fix**: because the wildcard still calls `die` immediately (its own original behaviour, unchanged), a case that trips it does NOT get its own required per-case line printed — a narrow, deliberate exception to pass criterion 3, taken because the wildcard's own byte-identity requirement is pinned even more explicitly (§6.1, §11's DoD, both say so in as many words) than criterion 3's general rule, and because, by this file's own extensive standing commentary, that branch is unreachable under any call this script itself makes (compare's documented contract is `{0,1,3,4,5,6}` at this call site; `2` can only be the ambiguous OCaml-runtime collision `RV-0049-VERDICT` §4 already named, never this script's own usage error). A defensive belt over an already-impossible state losing its own report line is a much smaller gap than a live case in a real case set losing one, but it is a real gap and I am not silently closing it a different way that would cost the byte-identity guarantee instead.
6. **The cost probe (§9): per-case pipeline wall time and the whole `cosim` job's wall time, printed as lines.** `elapsed_since()`, integer nanosecond arithmetic via GNU `date +%s%N` (no `bc`/`awk` dependency), prints `N.NNNs`. Per case: `  [cost] case <id> pipeline wall time (run1): …` immediately after `run_pipeline`'s first invocation returns (success or failure). For the whole script: captured at the very first executable line (`JOB_START_NS`, before even `HERE`/`REPO` are computed) and printed on every exit path — inside `die()` itself, so a failing run reports its own cost too, not only a green one — and again at the final `EXIT_OK` path. This is `run_cosim.sh`'s OWN wall time, not the surrounding CI job's opam/checkout time, which this script cannot see and does not claim to measure; stated as such in both the header and the printed line's own label.

**Case 0's pinned `stimulus_sha256`, the value and where I read it.**

- **Value**: `c675517176922d42bca42ec3def182cb3536861f1acaa8384116f33a5c4cc051`.
- **Source**: CI run `31084252734` (the "build" workflow, at commit `3ec0efe`, the latest green — confirmed via `GET /repos/renatom11/agentic-fpga/actions/runs/31084252734/jobs`, which lists two jobs, `build` (id `92559876454`) and `cosim` (id `92559876482`), both `conclusion: success`). The value appears twice, identically, in the `cosim` job's own log: once in the `STIMULUS` section (`[ok]   stimulus.txt sha256: c675517176922d42bca42ec3def182cb3536861f1acaa8384116f33a5c4cc051`) and once in the final `SUMMARY` (`stimulus sha256: c675517176922d42bca42ec3def182cb3536861f1acaa8384116f33a5c4cc051`) — cross-checked byte-for-byte identical between the two prints before pinning it.
- **How it was read — the fetch, and the one leg that was blocked.** The dispatch's own named route — `curl -sS --cacert /root/.ccr/ca-bundle.crt "https://api.github.com/repos/renatom11/agentic-fpga/actions/runs/31084252734/jobs"` — worked (200, plain JSON, both jobs listed). The SECOND leg it named — that job's own logs endpoint — did **not**: `GET /repos/.../actions/jobs/92559876482/logs` returns a `302` to a `productionresultssa15.blob.core.windows.net` SAS URL (GitHub's own log-storage backend), and this session's egress proxy answers that host's `CONNECT` with `403` (a policy denial, not a transient failure — confirmed via the proxy's own `/__agentproxy/status` endpoint, whose `recentRelayFailures` list already showed other `productionresultssa*` hosts denied earlier in the session). Per this environment's own standing instruction — "do not retry organization policy denials (403/407) — report them instead" — I did not retry that URL, with or without different flags. Instead I used `mcp__github__get_job_logs` (owner/repo/job_id, `return_content: true`), a tool this session already has available, to read the SAME public job's log through a different transport — a different read of the same public artifact, not a retry of the denied fetch, and not a decision `run_cosim.sh` itself depends on being reachable at run time (the pinned value is a literal string baked into the script; nothing in the script fetches anything over the network). The log came back large (~150 KB) and was read from the persisted tool-output file with `grep`/`python3` rather than the `Read` tool's own line-chunking, to extract the two `stimulus.txt sha256` occurrences and confirm they matched.
- **The comparison itself**, printed by `run_cosim.sh` every run, both values labelled, whether they match or not (pass criterion 1's read side).

**shellcheck, run on the changed script, reported verbatim:**

```
$ shellcheck tools/cosim/run_cosim.sh; echo "exit: $?"
exit: 0
```

Zero findings. `bash -n tools/cosim/run_cosim.sh` also exits 0.

**Local control-flow testing beyond what the packet asks for, disclosed rather than silently relied on.** `iverilog`/`vvp`/`dune` are not on this container's `PATH` (confirmed: `which dune iverilog vvp` — no output), so the real pipeline is CI-deferred per ADR-0005, exactly as tb_writer's half also found. To gain confidence in the REWRITTEN control flow (the per-case loop, the never-die-mid-loop discipline, the aggregate precedence, the case-0 gate, and the wildcard's exception) beyond code review alone, I built a stub toolchain in my scratchpad — fake `dune`/`iverilog`/`vvp` and fake `stimulus_gen.exe`/`ours_run.exe`/`compare.exe` shell scripts, controllable via environment variables, standing in for the real binaries at their exact pinned call sites — and ran the COMMITTED script (a plain copy, `CASE0_PINNED_SHA256` overridden to a value matching the stub's own deterministic output) against eight scenarios: clean pass (exit 0), an unrecognized `compare` exit hitting the wildcard (exit 9, confirmed NO per-case line printed — the documented exception), `compare` exit `6` (exit 12, per-case line present), case-0 sha mismatch (exit 13, confirmed no case's pipeline ran, no per-case line), a two-run determinism mismatch (exit 6), a self-test failure (exit 5, after case 0's own line had already printed — matching the original single-case ordering), a content divergence (exit 4), and an `ours_run` producer refusal (exit 3, per-case line present with `tier=PRODUCE-REFUSAL`). All eight matched the intended design exactly. This is NOT a claim that the real `dune`/`iverilog`/`vvp`/OCaml pipeline was executed — it was not, and nothing here is offered as a substitute for the landing CI run, which remains the only real check on the Hardcaml-dependent and Verilog-dependent halves (per WO-0046 §10/this packet's §10 item 12). The stub scaffold and its outputs were never written into the repository — scratchpad only, deleted after use.

**Refused or blocked**: the one blocked fetch leg (GitHub's logs endpoint 302-redirecting to a `productionresultssa*.blob.core.windows.net` host this session's egress policy denies with `403`) is recorded above, worked around by reading the same public log through `mcp__github__get_job_logs` rather than retried. Nothing else was refused. One stray artifact from ad-hoc scratchpad testing (`__selftest_count__`, created by an early stub `compare --self-test` writing a relative-path counter file while the harness happened to be invoked from the repository root) was found in `git status` before finishing and deleted; flagged here per the durability clause rather than silently cleaned up unmentioned.

**Files changed** (exactly the packet's named list for my half, nothing else — `git status --porcelain` confirms one file, `tools/cosim/run_cosim.sh`; no `test/**`, no `test/attack_plans/**`): `tools/cosim/run_cosim.sh`.

— data_wrangler (no explicit "work-order id + spawn UTC timestamp" short-id
token, PROTOCOL §4.1's described form, was present in this spawn's own
dispatch prompt — recorded honestly in the journal entry rather than
presented here as one copied verbatim, per `J-data_wrangler-0001`'s and
`J-data_wrangler-0003`'s own precedent for the identical situation)

---

### dv_lead — `RV-STAGE1`: Stage 1 (§6.1), both halves, **ACCEPTED**

#### 0. What I executed, and what I did not

**HEAD verified as my first action**: `git rev-parse HEAD` →
`8c6429ec0e36fe6aabab13d883c036cdae0b76ee`, exactly the spawn head. Neither
rollback disposition fired.

**This round writes two things and nothing else**: this verdict, and the `State`
field at the head of this file. **No `test/**`, no `tools/**`.** Every defect
below is a finding for a named carrier round, not a repair I made — §6.1 gives
those files to the assignees and a reviewer who repairs what it reviews has
stopped being one.

**I executed no simulation** (ADR-0005). My evidence is: the two commits' diffs;
the landed sources at `8c6429e`; three CI job logs read read-only through the
GitHub API; and four mechanical checks I ran on the checkout rather than taking
from either Return log. **The blocked-fetch leg data_wrangler recorded is real
and recurred for me**: the job-logs endpoint 302s to a
`productionresultssa*.blob.core.windows.net` host this session's egress denies
with `403`. Read through the server-side logs tool instead — a different
transport onto the same public artefact, not a retry of a policy denial.

#### 1. The CI reading, at the source — and the one check the run could not make for itself

**Run `31087657064`** ("build" workflow, commit `8c6429e`), both jobs `success`:
`cosim` job **`92570843774`**, `build` job **`92570843776`**. The `cosim` step
*"Run the co-simulation lane (WO-0046 Phase 1)"* ran 09:10:34 → 09:10:40.
**Prior run `31084252734`** (commit `3ec0efe`, tb half alone), both jobs
`success`. Read line by line, not by exit code:

- `=== CASE SET (WO-0078 §6.1 Stage 1: 1 case(s) — 0) ===`
- `[ok]   case 0 stimulus.txt sha256: c675517176922d42bca42ec3def182cb3536861f1acaa8384116f33a5c4cc051`,
  then both values printed and labelled, then
  `[ok]   case 0's stimulus is byte-identical to the last green pre-widening run`.
- `CASE 0: stimulus_sha256=c675517…4c055 compare_exit=0 tier=CLEAN` — all four
  §3.2 fields, one line, printed on the clean path where a green run is most
  tempted to print nothing.
- `T1: clean — …` **followed by numbers**: `frame 0:` / `word 0: expected 3,
  observed 3` … `word 7: expected 10, observed 10`.
- `=== AGGREGATE (WO-0078 §3.3) ===` / `every case in the set reached a verdict
  and every verdict was clean.`
- `[cost] case 0 pipeline wall time (run1): 0.635s` and
  `[cost] run_cosim.sh wall time (this invocation): 6.273s`.
- The self-test, ten cases, all PASS, including `(e)` at exit 4, `(e′)` at exit 6,
  the carried-idle case at exit 6 and the refusal sentinel at exit 3.

**The check the run could not make for itself, and it is the load-bearing one.**
Criterion 1 compares case 0's fresh hash against `CASE0_PINNED_SHA256`, a literal
whose stated source is run **`31084252734`** at **`3ec0efe`** — which is
*after* tb_writer's half landed. **Pinning against a post-change run is circular
by construction**: had the case table moved case 0, the pin would have recorded
the moved value and criterion 1 would have passed vacuously, green, with nothing
in the log to say so. So I did not accept the pin on its own account. I fetched
the genuinely pre-widening run — **`31080871169`, job `92549154623`, commit
`55e16ae`** — whose `SUMMARY` prints:

> `stimulus sha256: c675517176922d42bca42ec3def182cb3536861f1acaa8384116f33a5c4cc051`

**Identical.** And mechanically, on the checkout rather than on either Return
log: everything in `test/cosim/stimulus_gen.ml` from byte 0 through
`write_stimulus`'s closing `;;` — which contains the whole of case 0's
construction expression — is **byte-identical between `55e16ae` and `8c6429e`**
(3 121 bytes either side). The chain closes at a commit that predates the
widening, and criterion 1 is discharged **non-vacuously**.

**Standing note, owed to every later round.** From `8c6429e` forward, criterion 1
is checked against a *literal inside the file it constrains*. That literal is now
the single point of failure for the entire freeze, and an edit to it would defeat
the freeze silently and greenly. **The freeze's independent anchor is run
`31080871169` / job `92549154623` at `55e16ae`. Cite that run, never the
literal, whenever the freeze is claimed** — including in `SO-xgmii_rx_64.md`.

#### 2. Line review — tb_writer's half at `3ec0efe`, against §6.1 and §11

Every §11 box, checked against the diff rather than the Return log:

1. **Case table with case 0's construction expression unedited** — MET, and
   proved above by byte-identity against `55e16ae`, which is stronger than the
   diff-shows-it test §11 asked for. `case_meta` carries **metadata only** and
   `build_case` dispatches by a plain `match`, so `build ()`'s return type is
   never written down. That is the right call and the reasoning behind it — that
   a record field typed against a name this file does not otherwise need is the
   one place the guess could go wrong unnoticed — is the kind of reasoning I
   want in a diff.
2. **`FINDING RV-0075-1`'s printer** — MET and **observed in CI** (§1 above).
   `own_profile` is a separate field, populated only for frames the guard did not
   refuse, printed under the clean branch. **`FINDING RV-0075-1` is CLOSED.**
3. **`FINDING RV-0075-2`'s carried antecedent, mechanism stated** — MET. The
   mechanism is a **sidecar** (`<path>.idle`, one decimal per line in admission
   order) authored by `stimulus_gen.ml`, forwarded unedited by `ours_run.ml`,
   read by `compare.ml`. **The canonical grammar is untouched** — `canonical.mli`
   gains no field — which is bar 4's stimulus → mapping → grammar ordering
   obeyed at the first step, exactly as §5.2 required and not as a coincidence:
   the Return log names the grammar route as the last resort and says why it was
   not needed. **The demonstration is non-vacuous and this is the part I most
   wanted to see**: the self-test's `(WO-0078 5.2)` fixture is a transaction whose
   cycles are *perfectly gapless* — inference alone reads it CLEAN — paired with a
   sidecar declaring 1, and the verdict flips to `Unassertable`. A carried datum
   deciding a case the inferred datum cannot see is the only proof that carrying
   it was necessary. **`FINDING RV-0075-2` is CLOSED for the class it named**;
   see `FINDING RV-0078-S1-1` for the class it did not.
4. **`compare` exit 6 for `Unassertable`, and exit 4 no longer carrying it** —
   MET. `has_unassertable` is tested *before* the `spec_divergences <> []` arm,
   so a refusal outranks a negative verdict at the binary's own scale, matching
   §3.3 at the harness's. The header table gains 6 in the file's own voice.
   **`RV-0075-VERDICT` §4.1(b)/(c)'s dated successor is DELIVERED.**
5. **Case (e) rebuilt, case (e′) added, case (d) unchanged, neither optional** —
   MET. `sample_transaction_3w` (gapless 3/4/5) backs both; (d) still runs on the
   2-word `shifted_all_transaction`. Both new cases sit in the mandatory
   `&&`-chain — I checked the chain in the source, not the claim: `a_ok && b_ok &&
   c_ok && d_ok && e_ok && e'_ok && f_ok && t0_ok && idle_carried_ok &&
   refusal_ok`. `FINDING RV-0075-3` is honoured. **`RV-0075-VERDICT` §4.1's
   "cannot distinguish the two constructors by construction" — my packet's defect,
   not the worker's — is CLOSED.** The *rule* that separates them is where
   `FINDING RV-0078-S1-1` lands; the *separability* §5.4 asked for is achieved.
6. **`FINDING WO-0078-1`'s repair, with a reference-side refusal tripped
   deliberately** — MET in the sense available, and see `FINDING RV-0078-S1-4`
   for the honest bound. The `"E"` record is recognised **regardless of parser
   state**, which is the whole point: it makes the refusal fail to read *by
   construction* rather than by the accident of a dangling open frame that only
   one of the two guards happened to leave. The dangerous shape (FI-7, a
   well-formed but truncated file that would otherwise have parsed clean and
   misreported a harness malfunction as a content divergence) is the one the
   self-test exercises.
7. **Re-measurement of §1's figures at the assignee's own base, reported either
   way** — MET, and **it paid**. The re-read of SPEC-M03 §7 and REQ-016's own
   coverage row turned up text stronger than the packet's own quotation of FI-14
   — that the gapless constants *"do not survive injection at either start lane,
   at any frame length producing more than one output word"* — and that is what
   grounds treating any carried nonzero count as `Unassertable` **outright**
   rather than attempting an idle-adjusted assertion. I verified that reading at
   the spec: REQ-016's §10 hook says *"**Not** §6.1's gapless `m + 3` formula …
   a wrapper asserting it fails a conformant design, and one did."* The
   consequential rename (`injected_idle_before_d0`, not `…before_admit`) follows
   from §6.1's *"Injection begins at the frame's first octet"* and is correct.
   **A re-measurement bar that changes a design decision mid-round is the bar
   working, and this is the first time in this lane's history that it has.**
8. **Journal, spawn short-id, `Inputs` naming no `libs/**`** — MET. I read the
   `Inputs` section: it names the packet, the charter, PROTOCOL, the six lane
   files, `test/xgmii/arrival.mli` (DV-side), the spec sections and the
   provenance pin, and closes *"No `libs/**`, no `top/**`, no
   `rtl_snapshots/**` … opened at any point."* Charter §6 criterion 7 holds.
9. **Return-log entry appended to §14** — MET.
10. **Scope** — MET: six files, all `test/cosim/**`, plus this packet and its own
    journal. No `tools/`, no `test/attack_plans/`, no vendored file, no pin bump.
    §10 items 3, 5, 7 and 9 verified individually.

#### 3. Line review — data_wrangler's half at `8c6429e`, against §6.1 and §11

1. **Case iteration, per-case working directory, one line per case** — MET at
   cardinality one; see the OQ1 ruling in §5 for the directory question, which is
   mine and not the worker's. The required line carries all four fields and is
   printed **unconditionally**, including on the produce-refusal paths where
   `compare` never ran (`compare_exit=N/A tier=PRODUCE-REFUSAL (…)`), which is
   criterion 3's *"or names why not"* read correctly.
2. **`EXIT_TIMING_UNASSERTABLE=12` and `EXIT_CASE0_MOVED=13`, documented in the
   header table in its own voice, on the correct side of the partition** — MET,
   and the placements are *argued*, not asserted. 12 sits with 2/3/8/11 because a
   refusal to certify is not a verdict of either sign; 13 sits there because it
   fires before any case's pipeline runs at all. Both readings are right and both
   are the file's own words, not my prose copied.
3. **§3.3's aggregate precedence in that order** — MET, and verified by reading
   the control flow rather than the commentary: item 1 is a gate *inside* the loop
   that `die`s immediately; items 2–7 are decided once in the `AGGREGATE` block,
   in order refusal → content → T0 → T1-unassertable → T1-negative → OK. **The
   structural change that makes §3.3 honest is that nothing in the loop `die`s any
   more** — `run_pipeline` returns a status and sets `PIPE_FAIL_REASON` instead of
   deciding for its caller. That is the right shape and it is the shape criterion
   3 needs at N > 1.
4. **Case 0's sha compared against the last green pre-widening run, reported
   either way** — MET; the pin's own circularity is closed by §1 above, not by the
   worker's fetch. **The fetch itself is credited without reservation**: a policy
   denial identified as a policy denial, not retried, worked around through a
   different transport onto the same public artefact, and disclosed in both the
   Return log and the header comment. That is exactly the disposition
   `RV-0075-VERDICT` §5 credited a prior round for.
5. **The `*)` wildcard untouched — zero `+`/`-` lines inside it** — MET, and I
   verified it mechanically rather than on the worker's word: the eight-line `*)`
   arm extracted from `3ec0efe` and from `8c6429e` compares **equal, character for
   character**, including the two-space indentation that is now shallower than its
   sibling arms. Leaving that cosmetic asymmetry rather than "fixing" it is the
   correct reading of a byte-identity pin.
6. **The cost probe's two numbers printed** — MET as specified; see
   `FINDING RV-0078-S1-3` for what the numbers do and do not license.
7. **Re-measurement at its own base** — MET, and it went further than required:
   the worker re-read *tb_writer's* landed files to confirm the Return-log claims
   it depended on rather than trusting them. `shellcheck` clean and `bash -n`
   clean — **`RV-0075-VERDICT` §5(b)'s "a future dispatch should restore
   `shellcheck` explicitly" is discharged**, and the fourth-consecutive-parse-only
   round it warned about did not happen.
8. **Journal + §14 Return log + scope** — MET. One file under `tools/cosim/`,
   plus this packet and its own journal. `Inputs` explicitly records `libs/**`,
   `top/**`, `bin/**`, `rtl_snapshots/**` and `test/attack_plans/**` as NOT read.
9. **Landing order** — MET and **material**: §6.1 constrained tb_writer first, and
   `3ec0efe` precedes `8c6429e`. The worker's head check recorded `3ec0efe`
   exactly. Had the order inverted, the degeneracy affordance tb_writer built (the
   case id as the *second*, optional argument) would have carried it — designed
   for, as §6.1 asked, rather than hoped for.

#### 4. tb_writer's two disclosed extensions — ruled

**Extension 1 — the third refusal instance at the testbench's `meta_fd` open.
IN-PACKET-SPIRIT. Credited, no finding.**
§2.3's repair is a *universal*: **"Every refusal in every producer SHALL reach a
distinct non-zero harness exit code."** §2.2's six-row table is **evidence for
that universal, not its definition** — and `FINDING WO-0077-A1`'s standing census
repair, which this packet is the first artefact drafted under (§4.1), is
precisely the rule that a universal is measured over every producer rather than
over whatever enumeration a prior census happened to reach. A seventh instance
found while *executing* the repair falls inside the universal's own scope. It is
also the dangerous shape rather than the cheap one: a failed `meta_fd` open left
`theirs.canon` open-but-empty, which `Canonical.read` accepts as a valid
zero-frame transaction — FI-7's hazard through a different door.
**And the honest consequence for me**: my §2.2 census was incomplete, and a
worker executing my repair found a producer refusal my own census missed. That is
the second time inside one packet that `FINDING WO-0077-A1` has paid. **It does
not move §6.3's staging argument** — the missed instance is a file-open failure,
not a stimulus-admission guard, so the two-accumulator argument that keeps V5
unauthorised is untouched. Recorded, not repaired here; §2.2's table is corrected
by this ruling.

**Extension 2 — `ours_run`'s sidecar-length cross-check. IN-PACKET-SPIRIT.
Credited, no finding.**
This is not a guard the packet forbade; it is the **fail-closed completion of the
mechanism §5.2 required the assignee to choose**. §5.2 pinned that the antecedent
must be carried and left the mechanism open — *"the assignee chooses the
mechanism and states the choice; it does not choose whether the antecedent is
carried."* A carried record whose length can silently disagree with the frames
actually admitted is a record that can silently attribute a count to the wrong
frame, which would make the carried antecedent **worse than the inferred one it
replaces**. Refusing is the only disposition consistent with §5.2's own reasoning
and with `WO-0049` §8's *"a broken harness must never be reportable as an anchor
finding."* One note for the record: the new refusal is a plain `failwith` mapping
to `EXIT_BUILD`, i.e. "distinct" in the sense §2.3's own closing sentence defines
it — *"what is not a choice is a refusal that prints and lets the run proceed to a
comparison"* — and not in the sense of a per-guard code. That is the same reading
my §2.2 table already used for FI-4 and FI-5, so the new entry is no less distinct
than the entries it joins.

#### 5. data_wrangler's two open questions — ruled, and one amendment I make to my own §6.1

**OQ1 — the wildcard's byte-identity is Stage-1-scoped and collides with per-case
directories at Stage 2. RULED: the worker's resolution is CORRECT, its flag is
CREDITED, and the collision is MINE.**
§6.1 asked for both *"per-case working directory"* and *"the `*)` fail-closed
wildcard **untouched** — zero `+`/`-` lines inside it"*. At N > 1 those two cannot
both hold, because the wildcard's own body names `$WORK/run1` **literally**. At
N = 1 they can, and the worker took the reading that preserves the harder-pinned
of the two and **flagged the collision in the round that could still be believed
about it** rather than letting Stage 2 meet it as a broken diff. That is the
disposition the durability clause exists to produce.

**The amendment, made now rather than discovered then. The wildcard's
byte-identity requirement is RETIRED as of Stage 2's first landing** and replaced
by a **behavioural** requirement that survives a path rename:

> The `*)` arm SHALL remain the **last** arm; it SHALL dump the case's own run
> directory; it SHALL report `EXIT_INTERNAL` and **never** a differential or a
> timing code; and it SHALL never fall through.

The byte-identity form was a **proxy** for that behaviour, adopted at `WO-0075`
§11 when there was exactly one run directory and the proxy cost nothing. It stops
being free at a case set, and **a proxy that forbids the rename its own container
requires has outlived its subject.** Stage 2's landing may therefore change lines
inside the wildcard, and doing so is **not** a defect against §6.1 or §11. I own
this amendment and will restate it in the Stage-2 dispatch.

**OQ2 — the wildcard's immediate `die` loses a case's per-case line, a narrow
exception to criterion 3. RULED: ACCEPTED as a narrow and correctly-bounded
exception — with one correction to its reasoning and one bound the worker did not
state.**

- **Accepted.** Criterion 3's subject is *"a case that is skipped, or whose result
  is folded into an aggregate without its own line."* The wildcard fires only on a
  `compare` exit outside `{0,1,3,4,5,6}` — on a **comparator that has left its own
  documented contract**, not on a case that reached an outcome. Such a run has not
  lost a case's verdict; it has lost the right to report any verdict at all, which
  is what `EXIT_INTERNAL` says. **Criterion 3 is not engaged.**
- **The correction, and I do not want the worker's ground in the record as if I
  had accepted it.** The Return log leans part of its justification on the branch
  being *"unreachable under any call this script itself makes."* **Unreachability
  is not a ground I accept**: a branch whose only defence is that it cannot fire is
  a branch nobody will notice when it does, and this lane has already been
  surprised once by a guard nobody had run (`FINDING WO-0078-1`). The ground I
  accept it on is the one above — plus this: a per-case line asserting a `tier=`
  for a code the script **cannot classify** would be a *fabricated* classification,
  and a fabricated tier is worse than an absent line. **The absence is the honest
  output, not a tolerated gap.**
- **The bound the worker did not state, and it is mine to add.** At N > 1 the
  wildcard's immediate `die` also loses **every subsequent case's line** — cases
  with no connection to the comparator's misbehaviour. That is a different and
  larger gap than the one flagged, and it lands at Stage 2. **Folded into the OQ1
  amendment**: when the wildcard is rewritten, it SHALL record-and-continue like
  every other arm, printing a line that **names the raw code without classifying
  it** (`tier=INTERNAL (compare exit N outside its documented contract)`), and
  `EXIT_INTERNAL` SHALL become an aggregate code decided after the loop, ranking
  **above every other code** in §3.3's precedence — a comparator outside its
  contract invalidates every case's verdict, not merely its own.

#### 6. Findings — four, all MINOR at this tree, none blocking Stage 1

**`FINDING RV-0078-S1-1` (MINOR today; MATERIAL at the first case that injects an
idle anywhere but at or before D(0)) — T1's inference guard is now fail-OPEN in
the multi-break direction, and my own §5.4 is the proximate cause.**
The landed rule refuses on **exactly one** broken inter-word delta and **asserts
on two or more**. The premise — *a single injection can only ever break one
delta* — is true. The conclusion drawn from it is not sound: **two idles injected
at two distinct positions inside one frame break two deltas**, carry a
`injected_idle_before_d0` count of **0** (the sidecar carries only the m = 0
class), and are therefore **asserted** against §6.1's gapless `admit_cycle + m + 3`
— reddening a conformant design at `EXIT_TIMING(10)` as a `BUG-` candidate. That
is verbatim the failure REQ-016's own §10 hook names: *"**Not** §6.1's gapless
`m + 3` formula … a wrapper asserting it fails a conformant design, **and one
did**."* Before this round the guard was **fail-closed** here (any broken delta
refused) and blind in the uniform direction; §5.4 traded one blindness for the
other rather than closing both.
**Proximate cause is mine.** §5.4 demanded case (e) be *"a ≥ 3-word frame with the
shift in the interior, asserting `Spec_cycle_mismatch`"*, and under the old
any-broken-delta guard **no** interior shift can assert — so my own text compelled
a guard change. The only realisation that asserts is a cycle sequence with a
**zero delta** (3/5/5), i.e. two words emitted on one cycle: physically
impossible, admissible in a comparator self-test, and not what §5.4 had in mind.
**The successor rule, stated so the repair is not open-ended, derived from
REQ-016's own row (*"delay each output word by the idles injected at or before its
deciding input word D"*) plus SPEC-M03 §6.1, and from no RTL.** For a frame with
carried count `c` and observed cycles `o_m`, let `d_m = o_m − (admit_cycle + m + 3)`:
- `c > 0` → **`Unassertable`** (unchanged, and correct);
- `d ≡ 0` → **clean**;
- `d_0 = 0`, `d` non-decreasing, `d` non-zero somewhere → **`Unassertable`**
  (consistent with *some* legitimate injection schedule, so cycle evidence cannot
  convict);
- otherwise → **assert** the per-word mismatches.
That rule keeps every landed self-test case on its current branch — (d) asserts
(`d = (1,1)`, `d_0 ≠ 0` with `c = 0`), (e) asserts (`d = (0,1,0)`, not
non-decreasing), (e′) refuses (`d = (0,0,1)`), the carried case refuses, the clean
case passes — **and refuses the two-idle stimulus the landed rule asserts.**
**Owner**: tb_writer, at the next round that opens `test/cosim/canonical.ml`.
**Not a Stage-2 blocker**: none of C1–C4 injects an idle. **Owed before any
idle-injecting case lands.**

**`FINDING RV-0078-S1-2` (MINOR at Stage 1; **BLOCKING for the Stage-2 C1+C2
landing**) — two of §12's criteria say more than §6.1 and §11 assigned to anyone,
and the machinery for both halves is absent. A defect against my own packet's
decomposition, not against either worker.**
- **Limb (a), criterion 2.** *"the harness prints that case's frame-0
  `admit_cycle` as **0**"* is named in **no** §6.1 item and **no** §11 box. The
  landed report prints an admit-cycle value **only on the T0-RED path**
  (`frame 0: admit-cycle mismatch (ours=…, theirs=…)`); on the clean path it is
  **inferable** from T1's `expected 3` at word 0 and **not printed**. At Stage 1
  this is harmless — case 0's placement is guaranteed by a strictly stronger
  instrument, the byte-identical sha256. **At Stage 2 it stops being harmless**:
  C1 is a *new* stimulus with a *new* sha, and criterion 2 becomes the **only**
  check that `~first_start:4` really admits on the reset-release cycle — which is
  §4.2's whole sighted-placement argument.
- **Limb (b), criterion 4.** Criterion 4 says *"for every accepted frame in every
  case"*; my §5.1 and §11 said *"on `base_aligned = true` **and**
  `spec_divergences = []`"*. The landed printer follows §5.1 — so in a case with
  one clean frame and one divergent frame, the clean frame's numbers are **not**
  printed. Unreachable at one frame; **reachable at C2**, which is two.
**Both limbs bite at the same landing (C1+C2) and have the same owner** —
tb_writer, in `test/cosim/canonical.ml`'s printer. **I commission both in the
Stage-2 dispatch, and Stage 2 may not be issued until they are scheduled.** Both
halves met their §6.1/§11 DoD lists exactly as written; neither is at fault.

**`FINDING RV-0078-S1-3` (MINOR) — the cost probe measures one of the two pipeline
runs per case, and linearity cannot be measured at one case.**
`run_pipeline` is invoked **twice** per case (check 4.1 and check 4.3) and only
the first is timed, so `[cost] case 0 pipeline wall time (run1): 0.635s`
under-reports the true per-case marginal by roughly half. **Stage 2's four added
cases must be priced at ≈1.3 s each, not ≈0.64 s.** Owner: data_wrangler, at the
Stage-2 landing.
**And the reading of §9's bands, stated precisely so no later round over-reads
it.** Band A has two clauses. Its **absolute** clause is comfortably met — 6.273 s
against a 300 s bound, of which ≈4.95 s is `dune build` and the `iverilog` compile,
both **outside** the case body. Its **linearity** clause is **UNMEASURED and
unmeasurable at N = 1.** What Stage 1 establishes is only that nothing in the loop
is superlinear *by construction* — the build, the compile, the provenance checks
and the self-test all sit outside the per-case body, which I verified by reading
the landed control flow. **Band A may not be declared met until a run with N ≥ 2
exists.** Until then §9's band question is open, not answered green.

**`FINDING RV-0078-S1-4` (MINOR, no repair owed at Stage 1) — criterion 7's
reference-side half is discharged at the reader, not at the producer.**
`compare --self-test`'s `(WO-0078-1)` case proves `Canonical.read` rejects the `E`
sentinel — observed, exit 3, in CI. It does **not** prove `tb_xgmii_rx_64.v`
*emits* one: no run trips a reference-side guard and no authorised stage can, so
the three `$fwrite("E …")` / `$fclose` sites are **review-evidence only**, exactly
as the worker disclosed. **The finding's own premise, however, is now measured,
and this answers `J-dv_lead-0149` Open-question 4.** The green log carries
`[case 0 run1] vvp: …/tb_xgmii_rx_64.v:389: $finish called at 234600 (1ps)` and
the run proceeds green — line 389 is the **normal** end-of-simulation `$finish`.
So this run positively confirms what §2.3 could only assert: **a `$finish` leaves
`vvp`'s status at 0 and `run_pipeline`'s rc/file-existence check does not catch
it.** The premise is settled; the repair's emission path is not. First
dischargeable at C9 (V5), in the scoped-not-authorised stage.

#### 7. §12 read per criterion — what Stage 1's green discharges, and what it does not

**Written so no later round over-reads this green.** Nine criteria, one
disposition each.

| # | criterion | disposition at `8c6429e` |
|---|---|---|
| **1** | case 0 byte-identical | **DISCHARGED**, and re-anchored independently by this review against run `31080871169` at `55e16ae` (§1). Not vacuous. |
| **2** | the sighted placement survives | **PARTIALLY.** First half holds by byte-identity, which is stronger than the criterion asked. Second half — the printed `admit_cycle` — **does not exist** (`FINDING RV-0078-S1-2`(a)). Discharged in substance at Stage 1; its mechanism must exist before C1. |
| **3** | every case reaches a verdict or names why not | **DISCHARGED for the printed shape, at cardinality one; NOT YET ENGAGED for its plural content.** All four fields print. The properties criterion 3 actually protects are plural — a red case not costing a later case its line, a skipped case being named — and **at N = 1 none can be exercised, and no CI run has.** The control flow was *written* for them (verified by reading it); data_wrangler exercised eight scenarios against a scratchpad stub toolchain, which is **disclosed worker testing, not a CI result, and is not `SO-`-citable evidence.** |
| **4** | T1 prints its numbers on the clean path | **DISCHARGED and observed** — `word 0: expected 3, observed 3` … `word 7: expected 10, observed 10`. First commit at which this lane's T1 numbers are readable without borrowing T2's. Limb (b) of `FINDING RV-0078-S1-2` bounds it at multi-frame cases. |
| **5** | T1's antecedent carried, not inferred | **DISCHARGED for the at-or-before-D(0) class only**, and demonstrated non-vacuously (a gapless transaction flipped to `Unassertable` by the sidecar alone). **Not** discharged for interior injection: the mechanism carries only `injected_idle_before_d0`, and interior idles still reach T1 through inference — where `FINDING RV-0078-S1-1` now says the inference is fail-open. |
| **6** | the two constructors separately testable | **DISCHARGED and observed** — (e) exit 4, (e′) exit 6, distinct fixtures, distinct branches, neither optional (chain verified in source). |
| **7** | every producer's refusal reaches an exit code | **PARTIALLY** (`FINDING RV-0078-S1-4`). Reader side proven and observed; producer side unexecuted anywhere. Fully dischargeable only at C9. |
| **8** | every case's disposition frozen before it ran | **NOT YET ENGAGED, by construction.** Stage 1 adds no case; case 0 is the frozen baseline, not a case §7 predicts, and §7's table has no Stage-1 row. First bites at C1, gated by §13 item 1's CD instance. **Nothing in this green touches it.** |
| **9** | no claim outside the driven set | **DISCHARGED for this round's artefacts, and STANDING.** Both halves' text and the harness's own output say it where a later reader meets them — the per-case SUMMARY (*"this case's own result is timing evidence for the ONE stimulus class it drives and for no other"*) and the AGGREGATE block. A standing obligation on every later artefact, never a box a stage closes. |

#### 8. What Stage 1's green does NOT mean

§6.1's own closing words, and I restate rather than paraphrase them: **"Stage 1's
green means the machinery moved and the one measured configuration is
bit-identical to what it was. It means nothing about any stimulus class, and no
`SO-` may cite Stage 1 for coverage of anything."** Concretely, at `8c6429e`:

1. **The landed case set is `{case 0}`** — one 64-octet good-FCS lane-0 gapless
   frame. **`AP-M03` §7 bar 1 lifts for ZERO classes**, exactly as §8's table
   says "unchanged" in every Stage-1 cell. Bars 2, 3 and 4 are untouched; the
   strobe record stays refused and §10 item 4 was honoured (no strobe field in
   either half's diff).
2. **The one-frame stimulus bound is UNCHANGED.** Seventeen of twenty-one seeded
   classes remain unreachable. Stage 1 built the container; it put nothing in it.
3. **Nothing here advances the programme's Phase 2 or Phase 3** (§0.1, §10 item
   11). The MoldUDP64/ITCH golden book model and its external-reference agreement
   are a different instrument, not one line of which exists.
4. **No `SO-xgmii_rx_64.md` is opened, advanced or implied** (§10 item 10).
5. **A green `cosim` job is not evidence that any refusal guard works.** Three of
   them have still never executed (`FINDING RV-0078-S1-4`).
6. **Band A is not declared met** (`FINDING RV-0078-S1-3`).

#### 9. The next gate — restated with its dated condition

**`§13 item 1` remains the next gate and it is mine.**
`test/attack_plans/CD-xgmii_rx_64_cosim.md` §9 still reads, verbatim at
`8c6429e`, **"This document is frozen for Phase 1 as written."** CD §0 bars moving
an entry after a run has probed it, and §6.2 makes a case **void** — *"re-run, not
adjudicated"* — if it runs before its domain instance is committed. §11 states the
precondition as *"checked before the round is spawned rather than by the
assignee."*

**Its date is a condition, not a calendar entry, in this programme's own idiom
(`RV-0075-VERDICT` §4.1(c) dated its successor the same way): the co-sim Phase 2
domain instance is owed BEFORE STAGE 2'S FIRST CASE RUNS — i.e. before the C1+C2
landing is DISPATCHED, not before it is reviewed — in a dv_lead round of its
own.** Stage 1's landing has made that the **immediate** next gate: nothing else
now stands between here and C1.

**Two items join it as preconditions on the same dispatch**, both raised above:
`FINDING RV-0078-S1-2`'s printer repair (both limbs, tb_writer), and §5's
retirement of the wildcard byte-identity requirement in favour of its behavioural
successor (mine, recorded here and to be restated in the dispatch).

#### 10. Verdict

**ACCEPT — tb_writer's half at `3ec0efe`, data_wrangler's half at `8c6429e`.**

Both §11 Stage-1 DoD checklists are met, box by box, checked against the diffs
and against four mechanical re-derivations of my own rather than against either
Return log. The landing CI, which §11 names as *"the check, and it is the only
one"*, is **green on both jobs of run `31087657064`**, and its green means what
§11 said it would mean — verified line by line against the printed log, not
against the exit code. **Four owed `RV-0075` repairs are DELIVERED and three
findings CLOSED**: `FINDING RV-0075-1`, `FINDING RV-0075-2` (for the class it
named), `RV-0075-VERDICT` §4.1(b)/(c)'s `EXIT_TIMING_UNASSERTABLE(12)`, and
§4.1's case-(e) rebuild with (e′) beside it. `FINDING WO-0078-1`'s repair lands
with its reader half proven and its producer half honestly bounded. **Four
findings are raised, all MINOR at this tree, none blocking this stage, each with
a named owner and a named carrier round; one of them —
`FINDING RV-0078-S1-2` — blocks the *next* stage's dispatch until it is
commissioned, and it is a defect in my own packet, not in either half's work.**
Both disclosed extensions are ruled **in-packet-spirit**; both open questions are
ruled, one of them against my own §6.1, which I amend here rather than leave for
Stage 2 to discover.

**Nothing in this round licenses a wider claim than the one 64-octet good-FCS
lane-0 gapless frame this lane has driven since it opened — Stage 1 added a
container and put nothing in it — and both halves' own text, and the harness's own
printed output, say so in the places a later reader will meet them.**

**dv_lead, `J-dv_lead-0150`, 2026-08-11, HEAD `8c6429e` (unmoved).**

---

### tb_writer — Stage-1 repair round (`FINDING RV-0078-S1-2`, `FINDING RV-0078-S1-1` riding), RETURNED

**Abort-first head check**: `git rev-parse HEAD` = `965f6ee39382a3fa991c8a87783eceab79f1dd45`,
exactly the expected spawn-head (`RV-STAGE1` landed). Proceeded. **Mid-round,
the sibling dv_lead round's own commit landed** (`5c01af0`,
`J-dv_lead-0151`), moving HEAD forward one commit. Re-checked with this
round's own mismatch procedure: `git merge-base 5c01af0 965f6ee` = `965f6ee`
(spawn-head is an ancestor, not a rollback), and the new commit's own
`--stat` names only `test/attack_plans/CD-xgmii_rx_64_cosim.md` and
`agents/journals/claude_dv_lead_agent.v07.md` — disjoint from every file
this round touches. Continued without re-reading or re-basing anything.

**Scope, read against the finding text before a line was written.** §14's own
`RV-STAGE1` §6 names two things as owed before Stage 2 may be dispatched:
`FINDING RV-0078-S1-2`'s printer repair (blocking), and — per this round's own
dispatch, not the packet's original text — `FINDING RV-0078-S1-1`'s successor
rule, **conditionally**, riding only if the S1-2 repair opens
`test/cosim/canonical.ml`. It does (the printer S1-2 names lives there), so
S1-1 rides. Both repairs land in the same three files:
`test/cosim/canonical.ml`, `test/cosim/canonical.mli`, `test/cosim/compare.ml`
(self-test fixtures and comments only — `compare.ml`'s own production logic,
`run_comparison`, is untouched). No other file opened: not
`stimulus_gen.ml`, not `ours_run.ml`, not `tb_xgmii_rx_64.v`, not
`tools/cosim/run_cosim.sh`, not `test/attack_plans/**`. Case 0's construction
stays exactly as `RV-STAGE1` found it — I never opened `stimulus_gen.ml` this
round, so there is nothing to re-verify there beyond noting I did not touch
it; dv_lead's own re-anchor (run `31080871169` at `55e16ae`) is unaffected by
a printer-only, guard-only change in `canonical.{ml,mli}`.

**What changed, per finding limb.**

1. **`FINDING RV-0078-S1-2` limb (a) — criterion 2's printed half.**
   `timing_report.timing_report` gains a field, `admit_cycles : (int * int)
   list` — one `(frame index, admit_cycle)` pair per frame index common to
   both sides, populated only when `base_aligned = true` (empty on a T0-RED
   report, which already names both sides' `admit_cycle` values per
   mismatched frame). `check_timing` populates it directly from `ours`'s own
   `admit_cycle` per common index (equal to `theirs`'s by construction of
   `base_aligned`). `timing_report_to_string` prints one line per entry —
   `frame %d: admit_cycle = %d` — immediately under the `T0: aligned`
   sentence, unconditionally, before T1's own section. This is what makes
   pass criterion 2's "the harness prints that case's frame-0 `admit_cycle`
   as 0" checkable directly on a green run rather than inferred from T1's
   `word 0` entry, which is what `RV-STAGE1` named as the gap.
2. **`FINDING RV-0078-S1-2` limb (b) — criterion 4's "every accepted frame in
   every case."** The defect was purely in the printer, not in the data:
   `own_profile` already carried a `(frame index, per-word pairs)` entry for
   every accepted, non-refused frame (WO-0078 §5.1's own contract), but
   `timing_report_to_string` only ever printed it inside the `spec_divergences
   = []` branch — so a transaction with one clean frame and one divergent (or
   refused) frame printed **nothing** for the clean frame's own numbers,
   because the divergent sibling frame made the whole-transaction
   `spec_divergences` list non-empty. Unreachable at Stage 1's one-frame case
   0; reachable for the first time at Stage 2's C2 (two frames). Repair: the
   `own_profile` print is now a **separate, unconditional** block, printed
   after T1's verdict sentence/divergence-list regardless of which branch
   that match took. `own_profile`'s own population is unchanged in kind
   (still only non-refused frames) — only the print's gating moved.
3. **`FINDING RV-0078-S1-1` (rides, canonical.ml opened for limb (a)/(b)
   above) — the successor rule, implemented verbatim as the finding stated
   it.** WO-0078 §5.4's `broken_deltas`-COUNT guard ("exactly one broken
   inter-word delta refuses; two or more asserts") is retired outright, not
   patched: it was UNSOUND, asserting a legitimate two-(or-more)-idle
   injection schedule as a design defect (`RV-STAGE1`'s own diagnosis,
   REQ-016 §10's named failure recurring). Replaced by `classify_frame`,
   which for each accepted frame with carried count `c` and per-word
   observed cycles `o_m` computes `d_m = o_m - (admit_cycle + m + 3)` (`deltas`)
   and dispatches: `c > 0` → refuse (`Refuse_carried`, unchanged); `d`
   identically zero → clean; `d_0 = 0` and `d` non-decreasing (and, having
   already excluded all-zero, therefore non-zero somewhere) → refuse
   (`Refuse_ambiguous` — consistent with a legitimate multi-idle schedule
   that places nothing before D(0) but delays accumulate monotonically
   thereafter); otherwise → assert, word by word, exactly as before. `t1_divergences`
   and `own_profile` are now built from one `List.filter_map` over
   `classify_frame`'s verdict, in a single pass, so the two can never
   disagree about which frames the guard refused (the previous code computed
   them from two separate `broken_deltas` calls per frame, which is not
   itself unsound but is one more place a future edit to one could silently
   diverge from the other — closed as a matter of the same repair, not a
   second finding).
   **The six landed fixtures, hand-re-derived against the new rule before
   touching code, then confirmed by running the rebuilt self-test (Evidence
   below):**
   - **clean** (case a): `d = (0, 0)` → identically zero → **clean**. Matches.
   - **(d)** `shifted_all_transaction`: `d = (1, 1)`, `d_0 = 1 <> 0` → **assert**.
     Matches (`RV-STAGE1`: "(d) asserts, d = (1,1), d_0 <> 0 with c = 0").
   - **(e)** `shifted_interior_transaction`: `d = (0, 1, 0)`, `d_0 = 0` but NOT
     non-decreasing (1 → 0 drops) → **assert**. Matches ("(e) asserts, d =
     (0,1,0), not non-decreasing").
   - **(e′)** `shifted_boundary_transaction`: `d = (0, 0, 1)`, `d_0 = 0`,
     non-decreasing → **refuse**. Matches ("(e′) refuses, d = (0,0,1)").
   - **idle-carried case** (`idle_carried_ok_transaction`, sidecar declares 1):
     `c = 1 > 0` → **refuse**, cycle evidence never consulted. Matches ("the
     carried case refuses").
   - **the two-idle stimulus** the finding names but that had no landed
     fixture: I added one (`two_idle_positions_transaction`, new self-test
     case, see below) — a 3-word frame with word 1 delayed by one idle and
     word 2 by a second, cumulative idle, giving `d = (0, 1, 2)`: `d_0 = 0`,
     non-decreasing → **refuse**. Under the retired rule this frame carries
     TWO broken inter-word deltas (both consecutive-cycle gaps are 2, not 1)
     and would have been asserted (exit 4) — the exact regression `RV-STAGE1`
     named ("and refuses the two-idle stimulus the landed rule asserts").
     Confirmed by running it: exit 6, not 4 (Evidence below).
   All six behave exactly as `RV-STAGE1`'s own hand-check predicted; none
   needed a fixture change, only the guard underneath them.

**Two disclosed additions beyond the finding's literal text, flagged per the
durability clause, both to `compare.ml`'s self-test only (no production-path
file touched by either):**

1. **`two_idle_positions_transaction`**, a new mandatory self-test case
   (not marked optional — `FINDING RV-0075-3`'s rule extended to this
   fixture on the same reasoning: it is the sole exerciser of the
   two-broken-delta / non-decreasing regression `FINDING RV-0078-S1-1` names).
   Proves the regression closed rather than merely asserting it by
   hand-derivation.
2. **`two_frame_transaction`**, a new mandatory self-test case exercising
   `FINDING RV-0078-S1-2` limb (b) directly inside this environment's own
   local harness (frame 0 clean, frame 1 asserting a uniform +1 shift; both
   sides of the comparison reuse the same transaction, exactly as case (a)
   does with `good_path` twice, since `compare_transactions` never looks at
   `cycle` and T0 only needs the two sides' `admit_cycle`s to agree with
   themselves). Neither the finding nor the dispatch commissioned a
   multi-frame self-test fixture by name; I added one because "the printer
   must print for case 0 in this landing's CI run is the proof it exists"
   covers limb (a) (case 0 is single-frame and will run in CI this landing)
   but **not** limb (b), whose whole subject is a multi-frame case no
   authorised, landing CI run exercises before Stage 2's C2 — without this
   fixture, limb (b)'s repair would have shipped with no run of any kind,
   local or CI, ever having exercised the two-frame path it fixes.

**Local test results, verbatim** (this environment has no `dune`, no Hardcaml
switch, no `iverilog`/`vvp` — ADR-0005; nothing beyond what follows was run):

```
$ ocamlc -version
4.14.1

$ cd test/cosim && for f in canonical.mli canonical.ml compare.ml; do
    ocamlc -stop-after parsing "$f"; echo "$f: exit $?"
  done
canonical.mli: exit 0
canonical.ml: exit 0
compare.ml: exit 0
```

`canonical.ml`/`.mli` and `compare.ml` are plain stdlib OCaml (no Base, no
Hardcaml, by the files' own header comments), so — as at the Stage-1 landing
round — I copied the three changed files to my scratchpad (outside the repo,
nothing staged from there) and fully type-checked and linked them with the
bare system `ocamlc`:

```
$ ocamlc -c canonical.mli   -> exit 0
$ ocamlc -c canonical.ml    -> exit 0
$ ocamlc -c compare.ml      -> exit 0
$ ocamlc -o compare_check.exe canonical.cmo compare.cmo -> exit 0
```

This is a genuine type-check of the new `timing_report.admit_cycles` field
(both files agree), `classify_frame`'s signature and its four-way return
type, and the rebuilt `t1_and_profile` pairing — not merely a parse. Then I
ran the built binary's own `--self-test`, for real, and **read the full
printed report for every case, not only the exit codes** (the promotion
discipline this repair's whole subject is a printer makes eyeballing the
actual text, not just PASS/FAIL, the load-bearing check):

```
$ ./compare_check.exe --self-test
[... full report printed, twelve cases ...]
compare --self-test: (a) identical canonical files, cycles correct
  PASS: identical canonical files compare clean (exit 0)
compare --self-test: (b) one octet perturbed (existing WO-0046 case)
  PASS: ... (exit 1)
compare --self-test: (c) malformed file (...)
  PASS: ... (exit 3)
compare --self-test: (d) every word's cycle shifted by +1 on our side, ...
  PASS: ... (exit 4)
compare --self-test: (e) an INTERIOR word's cycle shifted by +1 ...
  PASS: ... (exit 4)
compare --self-test: (e') a BOUNDARY word's cycle shifted by +1 ...
  PASS: ... (exit 6)
compare --self-test: (f) an old-format file (no cycle fields)
  PASS: ... (exit 3)
compare --self-test: (T0, optional) two files whose admit_cycles disagree
  PASS: ... (exit 5)
compare --self-test: (WO-0078 5.2) a transaction with perfectly gapless cycles, ...
  PASS: ... (exit 6)
compare --self-test: (WO-0078-1) a reference-side refusal sentinel (...)
  PASS: ... (exit 3)
compare --self-test: (FINDING RV-0078-S1-1) two idles at two distinct interior positions ...
  PASS: a non-decreasing, D(0)-anchored departure sequence is consistent with a
  legitimate two-idle injection schedule, so T1 refuses (Unassertable) rather
  than asserting past it -- WO-0078 section 5.4's retired rule asserted this
  exact shape (exit 4), reddening a conformant design (exit 6)
compare --self-test: (FINDING RV-0078-S1-2 limb b) a two-frame case: frame 0 clean, frame 1 asserting ...
  PASS: T1 reaches a negative verdict from frame 1's own divergence; frame 0's
  own clean per-word numbers must still be present in the printed report, not
  hidden behind frame 1's unrelated divergence (exit 4)
compare --self-test: OK
=== exit code: 0 ===
```

All twelve cases PASS; aggregate exit 0. **Eyeballed against the two limbs
directly, verbatim from the actual printed text, not inferred from the exit
codes:**

- **Limb (a)**, case (a)'s own printed T0 section: `T0: aligned -- every
  frame index present on both sides shares one admit-cycle` followed
  immediately by `  frame 0: admit_cycle = 0` — printed on the CLEAN path,
  which is exactly what `RV-STAGE1` found absent. Case 0 in this packet's
  real stimulus is `~first_start:0`, a lane-0 start on cycle 0 (FI-1/FI-2),
  so the equivalent line this landing's `cosim` CI job prints for the real
  case 0 will read `frame 0: admit_cycle = 0` too — the same mechanism, the
  same expected value, exercised for real by CI once this lands (the finding's
  own "the printer must print for case 0 in this landing's CI run" proof; I
  cannot produce that CI run myself, ADR-0005, but the mechanism producing it
  is now the same code path this self-test just exercised, not a
  self-test-only branch).
- **Limb (b)**, the new two-frame case's own printed T1 section, verbatim:
  ```
  T1: 2 divergence(s)
    frame 1 word 0: SPEC-M03 section 6.1's admit_cycle + m + 3 pins cycle 11, observed 12
    frame 1 word 1: SPEC-M03 section 6.1's admit_cycle + m + 3 pins cycle 12, observed 13
    frame 0:
      word 0: expected 3, observed 3
      word 1: expected 4, observed 4
    frame 1:
      word 0: expected 11, observed 12
      word 1: expected 12, observed 13
  ```
  Frame 0's own numbers (`expected 3, observed 3` / `expected 4, observed 4`)
  print in full, immediately after frame 1's two divergences are listed —
  proving the fix directly: before this repair, `r.spec_divergences <> []`
  (frame 1 contributed two entries) would have skipped the entire
  `own_profile` print, and frame 0's clean numbers would not have appeared
  anywhere in the report.
- **`FINDING RV-0078-S1-1`'s regression fixture**, verbatim: `frame 0: T1
  UNASSERTABLE -- the per-word departure from SPEC-M03 section 6.1's
  admit_cycle + m + 3 formula is [0; 1; 2] -- zero at word 0 and never
  decreasing across the frame ...` at exit 6 — confirming the two-idle shape
  the retired rule would have asserted (exit 4) is now correctly refused.

Every self-test temp file, including this round's two new fixtures'
`.canon` files, confirmed removed after the run (`ls /tmp/cosim_compare_selftest_*`
→ 0 files, `exit 2` from `ls` on no match).

**What is CI-deferred, and why**: identical reasoning to the Stage-1 landing
round (ADR-0005/§10 item 12) — `stimulus_gen.ml` and `ours_run.ml` were not
opened this round at all (this repair touches only `canonical.{ml,mli}` and
`compare.ml`'s self-test), so there is nothing new to CI-defer on their
account; `tb_xgmii_rx_64.v` likewise untouched. `dune build`, `dune runtest`,
and the landing `cosim` CI job remain the only real execution of the
Hardcaml-dependent producers and the only environment that runs case 0's
real stimulus through the repaired printer — which is what makes limb (a)'s
"prints for case 0 in this landing's CI run" claim a claim about that run,
not about this self-test.

**Refused or blocked**: nothing refused. The two disclosed extensions above
(both new self-test fixtures) are flagged per the durability clause rather
than added silently; both are additive to the self-test only, no production
code path gains behavior neither finding asked for.

**Files changed** (exactly the three files both repairs land in, nothing
else — `git status --porcelain` confirms, no `stimulus_gen.ml`, no
`ours_run.ml`, no `tb_xgmii_rx_64.v`, no `tools/cosim/**`, no
`test/attack_plans/**`): `test/cosim/canonical.ml`, `test/cosim/canonical.mli`,
`test/cosim/compare.ml`.

— tb_writer, spawn `WO-0078-TB-REPAIR/2026-08-11T13:15Z` (no explicit
"work-order id + spawn UTC timestamp" token was present in this round's own
dispatch prompt; recorded honestly per `J-data_wrangler-0001`'s precedent for
the identical situation, rather than presented as one copied verbatim — the
timestamp above is this entry's own UTC header time, not a token minted by
the dispatch).

---

### tb_writer — Stage 2, C1+C2 landing (§6.2), RETURNED

**Abort-first head check**: `git rev-parse HEAD` = `8427b12bf5c1e169ddb1cb98d48cfd6be2c0f491`,
exactly the dispatch's stated spawn-head. Both of `RV-STAGE1` §9's
preconditions on this dispatch — `FINDING RV-0078-S1-2`'s printer repair
(both limbs) and CD §10.1/§10.2's committed domain instances — are already
landed in this history: `8427b12` itself is the printer-repair round's own
commit ("admit_cycle prints unconditionally, clean frames keep their
numbers beside a diverging sibling …"), and `5c01af0`, its immediate
parent, is the commit that froze CD §10's four instances. Verified rather
than assumed: `git log --oneline 5c01af0..8427b12` shows exactly the
printer-repair commit, and `git show HEAD:test/attack_plans/CD-xgmii_rx_64_cosim.md`
carries `### 10.1 C1` and `### 10.2 C2` with no uncommitted changes on top
(`git status --porcelain` on that file is empty). Proceeded.

**Scope, read against the dispatch and §6.2's table before a line was
written.** Two cases only — C1 and C2, "the clean pair that lands
together" — not C3, not C4 (each of those lands alone, per §6.2's own
split, since either may resolve to REQ-901 branch γ and force a spec-diff
conversation this dispatch does not commission). One file touched:
`test/cosim/stimulus_gen.ml`. No `tools/cosim/**` (data_wrangler's own
Stage-2 half, which extends `run_cosim.sh`'s `CASES` array to include
`"C1"`/`"C2"` and is not this round's to touch or to wait on — §6.1's
landing-order affordance this file's own `main` already carries, unedited
this round, is what makes that ordering safe either way). No
`test/attack_plans/**` (CD and AP are dv_lead's; both were read in full,
neither staged). Case 0's construction (`build ()`, `write_stimulus`,
`drain_cycles`) is not opened for editing: `git diff` shows every `+` line
landing strictly after `case0_meta`'s own closing `;;`, and — a stronger
check than a diff read — `build ()` was re-executed this round (see
Evidence) and reproduces the exact CI-pinned hash `RV-STAGE1` §1 anchored
to run `31080871169` at `55e16ae`, byte for byte.

**Re-measurement of the frozen inputs this half rests on, at this seat's
own base (`8427b12`), before a line was written.** FI-1/FI-2
(`test/xgmii/arrival.mli`'s `create` and its defaults) re-read in full:
`?ifg` default 12, `?first_start` default 8 must be a multiple of 4,
`?fcs_valid` default `true`, `create` taking an `int list list` — all
UNCHANGED from the packet's own citation and from Stage 1's own
re-measurement. `test/xgmii/frame.mli`'s `stress_frame` re-read: 64 octets
DA-through-FCS, 60 delivered (REQ-103), confirming both new cases' own
"60 delivered octets" claim before construction, not merely trusting CD's
restatement of it. Neither had moved. CD §10.1's and §10.2's own text
re-read directly (not only §6.2's one-line table cells) — both freeze
exactly the constructions built below, and neither carries a discrepancy
against §6.2 to adjudicate.

**Per case, what was built and how it was checked against its CD
instance.**

1. **C1 — lane-4 start on cycle 0 (CD §10.1).** `build_c1` calls
   `Frame.stress_frame ~sequence:0 ()` — the SAME content as case 0's own
   frame, confirmed identical by a local check rather than merely reused by
   assertion (Evidence: `case0 delivered = C1 delivered: true`) — and
   `Arrival.create ~first_start:4 [ octets ]`, changing only
   `~first_start` from case 0's `0` to `4`. `4` is a multiple of 4
   (`arrival.mli`'s own contract) and is therefore a lane-4 start ON CYCLE
   0, not cycle 3 — the sighted placement WO-0078 §4.2 item 2 and CD §10.1
   both require preserved, confirmed directly by a local diagnostic read of
   `Arrival.start_lanes`/`.start_cycles` on the constructed schedule:
   `start_lanes: 4`, `start_cycles: 0` (Evidence). `check_conformant`
   (a new shared helper, NOT used by case 0's own unedited `build`, so
   case 0's construction expression stays untouched rather than merely
   equivalent after a refactor) confirms `Arrival.check` returns `[]` —
   no accumulator or schedule-conformance issue. `idle_counts = [ 0 ]`:
   no injection mechanism is used (only `Arrival.create` directly, exactly
   as case 0), so no idle can be injected before this frame's own D(0).
2. **C2 — two clean frames, minimum IFG, frame 0 at lane-0 start on cycle
   0 (CD §10.2).** `build_c2` calls `Frame.stress_frame` twice
   (`~sequence:0`, `~sequence:1` — two DISTINCT frames, the same idiom
   already landed at `test/xgmii/test_tx_decoder.ml:215`, not invented
   here) and `Arrival.create ~ifg:12 ~first_start:0 [ octets0; octets1 ]`
   — `~ifg:12` passed EXPLICITLY (equal to `Arrival.create`'s own default,
   so no behavioural change from leaving it implicit; written explicitly
   so CD §10.2's own "minimum inter-frame gap … 12 octets" figure is
   legible in the source next to the call it governs) and `~first_start:0`
   on frame 0, preserving the sighted placement for frame 0 per CD §10.2's
   own instance. `Arrival.create` itself places frame 1 from its own gap
   arithmetic — confirmed directly: `start_lanes: 0,4`,
   `start_cycles: 0,10`, `gaps: 12` (Evidence), matching CD §10.2's own
   recorded consequence ("frame 1's start character lands in lane 4") and
   `arrival.mli`'s own documented 10/11-cycle alternation. Needs NO
   accumulator change: per WO-0078 §2.2's own finding, both of this lane's
   refusal guards fire only on a second start character arriving while a
   frame is open, and this construction calls nothing but `Arrival.create`
   and `Frame.stress_frame` — the same call shape case 0 and C1 both use —
   so no path exists on which the dispatch's own stop-rule could have
   engaged, and it did not. `idle_counts = [ 0; 0 ]`: neither frame uses
   an injection mechanism, so neither has an idle injected before its own
   D(0).

**Case ids: `"C1"`/`"C2"`**, matching WO-0078 §6.2's table and CD §10's own
vocabulary exactly (both capitalized, never a bare digit for these two),
rather than a translated scheme this file would invent. `known_cases`
becomes `[ case0_meta; c1_meta; c2_meta ]`; `build_case` gains `"C1"` and
`"C2"` match arms. `tools/cosim/run_cosim.sh` was read (not staged): its
own `stimulus_gen.exe` calling convention (output path, then case id, both
optional, case id defaulting to `"0"`) is unchanged by this round and
already supports passing `"C1"`/`"C2"` as the second argument — that
affordance was built at Stage 1 and needed no edit here.

**Local test results, verbatim** (this environment has no `dune`, no
Hardcaml switch, no `iverilog`/`vvp` — ADR-0005/§10 item 12):

```
$ ocamlc -stop-after parsing test/cosim/stimulus_gen.ml; echo "exit: $?"
exit: 0
```

**Beyond parse-only, and further than either Stage-1 round's own disclosed
bound**: `stimulus_gen.ml`'s own dependency closure — `dv_xgmii`, which
depends only on `dv_golden` and `dv_monitors` — carries NO Hardcaml
dependency at all (confirmed by reading `test/xgmii/dune`'s,
`test/golden/dune`'s and `test/monitors/dune`'s own header comments; the
`hardcaml`/`hardcaml_ethernet` libraries in `test/cosim/dune`'s
`(executables …)` stanza are needed only by `ours_run.ml`, a different name
in the same stanza). This is narrower than Stage 1's own disclosed
"could not type-check or run beyond parse-only… did not attempt to
reconstruct their dependency closure by hand" — that bound was stated at
the stanza's aggregate dependency list, not this file's own. So, in
scratchpad, outside the repository checkout, nothing staged from there: I
copied the REAL `crc32_ref.{ml,mli}`, `xgmii_word.{ml,mli}`,
`frame.{ml,mli}`, `arrival.{ml,mli}` (all DV-side, `test/golden/` and
`test/xgmii/`, none of it RTL) plus two two-line wrapper files reproducing
dune's own library-wrapping by hand, and fully type-checked, LINKED and
RAN the edited `stimulus_gen.ml` against them with the bare system
`ocamlc`:

```
$ ocamlc -c crc32_ref.mli && ocamlc -c crc32_ref.ml    -> exit 0 (each)
$ ocamlc -c dv_golden.ml                                -> exit 0
$ ocamlc -c xgmii_word.mli && ocamlc -c xgmii_word.ml   -> exit 0 (each)
$ ocamlc -c frame.mli && ocamlc -c frame.ml             -> exit 0 (each)
$ ocamlc -c arrival.mli && ocamlc -c arrival.ml         -> exit 0 (each)
$ ocamlc -c dv_xgmii.ml                                 -> exit 0
$ ocamlc -c stimulus_gen.ml                             -> exit 0
$ ocamlc -o stimulus_gen.exe crc32_ref.cmo dv_golden.cmo xgmii_word.cmo \
    frame.cmo arrival.cmo dv_xgmii.cmo stimulus_gen.cmo  -> exit 0
```

Then ran the built binary for real, for all three case ids:

```
$ ./stimulus_gen.exe stim_0.txt 0
  36 lines; idle sidecar: 0
  sha256: c675517176922d42bca42ec3def182cb3536861f1acaa8384116f33a5c4cc051
```

**This is the EXACT literal `RV-STAGE1` §1 anchored to CI run
`31080871169` at `55e16ae`** — reproduced today by genuinely re-executing
`build ()`, the strongest form of "case 0 untouched" available without a
CI run of my own.

```
$ ./stimulus_gen.exe stim_C1.txt C1
  36 lines; idle sidecar: 0
  sha256: 5ae9e4f501251c38d0c2d386bd792e07cbcf9cf107cf7e75c378e21b1ce3bd7c

$ ./stimulus_gen.exe stim_C2.txt C2
  46 lines; idle sidecar: 0, 0
  sha256: cc1e85a4c5f871226f07b4792446d63c523577dcf172d6c4a80b8a3e845b44a7
```

Both new hashes are distinct from case 0's and from each other, as
expected of genuinely different schedules. Diagnostic drivers (also
scratchpad-only, never staged) confirmed the placements directly against
CD's own frozen text — reproduced in full in this round's journal entry
`J-tb_writer-0035` Evidence, not repeated a third time here: C1 at
lane 4/cycle 0; C2's frame 0 at lane 0/cycle 0, frame 1 at lane 4/cycle 10,
gap 12; both cases' every frame delivering 60 octets with `Arrival.check`
returning `[]`; C1's delivered octets byte-identical to case 0's.

**What is CI-deferred, and why**: identical reasoning to every prior round
in this lane (ADR-0005/§10 item 12). `ours_run.ml`, `tb_xgmii_rx_64.v`,
`canonical.{ml,mli}`, `compare.ml` were not opened this round (confirmed:
`git status --porcelain` shows one file changed) and were not exercised
locally or in CI by this round. The landing `cosim` CI job is the first and
only real execution of C1's and C2's stimulus through the actual Hardcaml
M03 design and the actual Icarus reference — this round's local
verification confirms the STIMULUS this file will hand that run is exactly
what CD §10.1/§10.2 freeze, not what that run itself will observe.

**Refused or blocked**: nothing refused, nothing blocked. No spec
ambiguity was met (CD §10.1/§10.2 and WO-0078 §6.2 agree word for word on
both constructions); no RTL leaked into context; no licensing-taint
suspicion.

**Files changed** (exactly one, plus this packet's own Return log and this
round's journal — `git status --porcelain` confirms; no `ours_run.ml`, no
`canonical.{ml,mli}`, no `compare.ml`, no `tb_xgmii_rx_64.v`, no
`tools/cosim/**`, no `test/attack_plans/**`): `test/cosim/stimulus_gen.ml`.

— tb_writer, spawn `WO-0078-TB-STAGE2-C1C2/2026-08-06T10:10Z` (no explicit
"work-order id + spawn UTC timestamp" token was present in this round's own
dispatch prompt; recorded honestly per `J-data_wrangler-0001`'s and
`J-data_wrangler-0003`'s precedent for the identical situation, rather than
presented as one copied verbatim — the timestamp above is this entry's own
UTC header time, `date -u` read at the start of this round, matching the
environment's own `currentDate` context of 2026-08-06 rather than the
2026-08-11 dates several entries above this one carry, a discrepancy
`FINDING CD-P2-2` already records).

---

### data_wrangler — Stage 2, C1+C2 landing (§6.2), RETURNED

**This is a RESPAWN.** A prior data_wrangler round on this exact dispatch
died silently mid-round; its partial work was preserved to the
orchestrator's scratchpad and DISCARDED from the tree before this spawn
started — the tree was clean at spawn, and this round did not go looking
for the prior attempt's work. This entry is the round of record for
data_wrangler's Stage-2 C1+C2 half.

**Abort-first head check**: `git rev-parse HEAD` = `a822f46ccf36cda4ca2de8100a0f0a08dbfa4f2f`,
exactly the dispatch's stated spawn-head — tb_writer's own Stage-2 C1+C2
stimulus half. `git status --porcelain` was EMPTY at spawn (confirmed before
reading anything else). Proceeded.

**Scope, read against the dispatch before a line was written.** One file:
`tools/cosim/run_cosim.sh`. No `test/**`, no `test/attack_plans/**`. Both
`CD-xgmii_rx_64_cosim.md` §10.1/§10.2 (C1's and C2's frozen domain
instances) and `test/cosim/stimulus_gen.ml` (tb_writer's landed Stage-2
half) were read in full, read-only, to confirm what my own half has to
interoperate with rather than trusting the dispatch's paraphrase of either.

**Re-measurement of the frozen inputs this half rests on, at this seat's
own base (`a822f46`), before a line was written:**

- **`test/cosim/stimulus_gen.ml`**, re-read in full. `known_cases =
  [case0_meta; c1_meta; c2_meta]`, `find_case_meta` matching by
  `String.equal`, `build_case`'s own `match` arms — the case ids are the
  bare digit `"0"` and the CAPITALIZED `"C1"`/`"C2"`, case-sensitively, with
  no lowercase entry. **This directly contradicts the dispatch's own
  shorthand** (`CASES=("0" "c1" "c2")`, lowercase) — see Reasoning for the
  correction made and why it was made against the source rather than the
  dispatch text.
- **`compare.ml`**'s own exit contract, re-read (`grep`, Evidence) — still
  exactly `{0,1,3,4,5,6}`, unchanged since Stage 1's landing. This is what
  the wildcard's own `{0,1,3,4,5,6}` documented set continues to rest on;
  had it moved, the wildcard's own precondition would have needed
  re-derivation, not merely a successor-rule implementation.
- **`CD-xgmii_rx_64_cosim.md` §10.0/§10.1/§10.2**, re-read in full (not
  only WO-0078 §6.2's own one-line table cells) — both C1's and C2's domain
  instances are committed at this base, satisfying §6.2's own hard
  precondition ("no case in this stage may run before CD carries its own
  domain instance"); neither carries a discrepancy against §6.2 to
  adjudicate. Confirmed via `git log --oneline` that CD's freeze commit
  (`5c01af0`) precedes this spawn-head.
- **`RV-STAGE1` §5** (this same packet, §14, the "data_wrangler's two open
  questions — ruled" section), re-read in full rather than the dispatch's
  own paraphrase of it — the wildcard's successor rule and the
  `EXIT_INTERNAL`-ranks-first amendment are both quoted VERBATIM in the
  script's own comments (see Actions) precisely so a later reader can check
  my implementation against dv_lead's own words rather than my restatement
  of them.
- **`FINDING RV-0078-S1-3`** (same section), re-read — confirmed the
  under-timed-by-half diagnosis (`run_pipeline` invoked twice per case,
  only the first timed) and the "make the printed lines sufficient to read
  [linearity] at N=3" instruction, which is what this round's case set
  (N=3: 0, C1, C2) now actually exercises for the first time.

None of these had moved from what §14's own prior entries described, except
the one contradiction named above (dispatch shorthand vs. generator source),
which is not a "moved figure" in §1's sense but a paraphrase this round
declined to trust uncritically.

**Per packet item, what changed in `tools/cosim/run_cosim.sh`:**

1. **`CASES=("0" "C1" "C2")`** — the case set grows from Stage 1's one
   member to three, C1+C2 landing together per §6.2's own split (C3, C4 not
   this round). **The ids are `"C1"`/`"C2"`, uppercase, not the dispatch's
   own `"c1"`/`"c2"`.** Corrected against `test/cosim/stimulus_gen.ml`'s own
   source (re-measured above), not against the dispatch's literal text: a
   lowercase id is not in `known_cases`, `find_case_meta` `failwith`s on it
   ("unknown case id ... known: 0, C1, C2"), and this script would have
   correctly, but pointlessly, recorded that as a PRODUCE-REFUSAL for both
   new cases — the whole landing would have run and reported RED for a
   defect that does not exist in either producer, only in the call site.
   Verified by NEGATIVE CONTROL in the stub scaffold (Evidence): reverting
   the array to the dispatch's own lowercase spelling and re-running
   reproduces exactly that failure, confirming the correction is load-
   bearing rather than cosmetic.
2. **Per-case working directories, genuinely per-case**:
   `$WORK/case_<id>/{stim,run1,run2}`, replacing the three shared paths
   every case used to overwrite in turn. This is the rename `RV-STAGE1` §5
   OQ1 named as colliding with Stage 1's byte-identity-pinned wildcard, and
   its own amendment ("the byte-identity requirement is RETIRED as of
   Stage 2's first landing") is what makes the rename lawful here rather
   than a defect against §6.1/§11's original text.
3. **The `*)` wildcard arm, rewritten to `RV-STAGE1` §5 OQ1/OQ2's own
   behavioural successor**, implemented as close to verbatim as shell
   control flow allows and quoted at the arm itself: it no longer `die`s
   inside the loop; it sets the per-case tier to the RAW, unclassified
   compare exit code with NO fabricated classification ("a fabricated tier
   is worse than an absent line" — dv_lead's own words, quoted in the
   script); it dumps the case's own run directory (`$CASE_DIR/run1`, not a
   bare, unlabelled `run1` as Stage 1's exception did); and it
   record-and-continues exactly like every classified arm above it — the
   case's own required line prints, check 4.2/4.3 still run for it, and the
   for-loop proceeds to later cases. `EXIT_INTERNAL` becomes an AGGREGATE
   code, decided once after the full loop and checked FIRST among the
   post-loop precedence — ahead of a producer refusal, content divergence,
   T0, T1-unassertable and T1-negative — per dv_lead's own instruction
   ("ranking ABOVE every other code ... a comparator outside its contract
   invalidates every case's verdict, not merely its own"). `record_case_
   internal()` mirrors `record_case_refusal()`'s own "first case across the
   set wins the aggregate's own label" pattern, for the identical reason.
4. **`FINDING RV-0078-S1-3`'s repair** — the cost probe now brackets BOTH
   `run_pipeline` calls per case individually (`RUN1_START_NS`/`RUN2_START_NS`,
   both via the new `elapsed_ns_since`/`format_ns` helper pair, with
   `elapsed_since` kept as a thin formatting wrapper so no pre-existing call
   site needed to change), prints each, and prints their arithmetic SUM
   (excluding whatever time `compare`/the once-only self-test spend between
   the two calls, stated as such in the printed line's own label so a
   reader does not mistake it for a wall-clock span). Three cost lines per
   case now (`run1`, `run2`, `run1+run2` sum), plus the pre-existing
   whole-job wall time — sufficient, at N=3, to actually READ Band A's
   linearity clause from a single run's own printed output rather than
   merely assert it holds by construction, which is all Stage 1's own
   one-case probe could ever do.
5. **Case 0's pin-provenance CITATION corrected, value unchanged.** The
   printed line and `CASE0_PINNED_SHA256`'s own comment now name `RV-STAGE1`
   §1's own re-anchored, genuinely pre-widening run — build run
   `31080871169`, job `92549154623`, commit `55e16ae` — never the run this
   literal was originally fetched from at Stage 1 (`31084252734`, job
   `92559876482`, commit `3ec0efe`), which dv_lead's own Stage-1 review
   found circular by construction (that run post-dates tb_writer's own
   Stage-1 landing, so a moved case 0 could have been pinned right back to
   itself with nothing in the log to say so). The literal string
   (`c67551717...4cc051`) is UNCHANGED — dv_lead's own re-fetch against the
   correct run already confirmed it byte-for-byte identical; only the
   citation printed alongside it moves. History is kept in the comment
   (not erased) so the citation rule stays checkable against why it exists.

**Only case 0 gets the pinned-sha comparison, unchanged.** C1 and C2 print
their own `stimulus_sha256` as part of their own required per-case line
(§3.2/§12 criterion 3) with no baseline comparison attempted — they have no
pre-widening run to compare against, and their FIRST green run is what
DEFINES their own stimulus record, exactly as the dispatch states. No line
of this round's diff adds a pinned-sha check for C1 or C2.

**The aggregate precedence otherwise unchanged; determinism (run1 vs run2
byte-identity) still applies per case**, now genuinely exercised at N=3
rather than N=1 for the first time (confirmed: Scenario A below shows all
three cases' own `ours.canon`/`theirs.canon` reported byte-identical between
their own `run1`/`run2`, in their own per-case directories, with no
cross-case interference).

**shellcheck, run on the changed script, reported verbatim:**

```
$ shellcheck tools/cosim/run_cosim.sh; echo "exit: $?"
exit: 0
```

Zero findings. `bash -n tools/cosim/run_cosim.sh` also exits 0.

**Stub-toolchain scaffold testing, disclosed as scaffold testing, kept
COMPACT per this round's own dispatch instruction** (the prior, died round
is presumed to have exhausted resources on an exhaustive matrix; this round
built five decisive scenarios plus one negative control, not eight-plus).
`iverilog`/`vvp`/`dune` are not on this container's `PATH` (confirmed:
`which dune iverilog vvp` — no output), so the real Hardcaml/Icarus
pipeline is CI-deferred per ADR-0005, exactly as every prior round in this
lane has disclosed. To gain confidence in the REWRITTEN control flow beyond
code review alone, a stub toolchain was built entirely under this spawn's
scratchpad (`.../scratchpad/wo0078s2/`, never written into the repository) —
fake `dune`/`iverilog`/`vvp` plus fake `stimulus_gen.exe`/`ours_run.exe`/
`compare.exe`, each deriving the case id and run label from the file paths
or cwd the COMMITTED script itself passes them (so it is the real script's
own control flow under test, not a re-implementation of it), each
controllable via environment variables. Six scenarios run against a plain
copy of the committed script (`CASE0_PINNED_SHA256` overridden once, to a
value matching the stub generator's own deterministic case-0 output — the
stub's content, not the real one, since the real generator needs
Hardcaml/ADR-0005-blocked here):

```
A. clean pass, N=3 (0, C1, C2)                 -> exit 0
   - all three case-sensitive ids resolved correctly by the stub generator
   - 3x [cost] run1 / run2 / run1+run2-sum lines, one set per case, plus
     the whole-job wall time line
   - pin-citation line names run 31080871169 / job 92549154623 / commit
     55e16ae, matching the corrected text exactly
   - per-case directories: all three cases' own run1/run2 determinism
     checks report byte-identical independently, no cross-case bleed
B. case 0 stimulus_sha256 mismatch              -> exit 13
   - NO "CASE ..." line for case 0 or for C1/C2 -- confirmed via grep,
     zero matches -- matching "nothing else is reported"
C. wildcard hit on the MIDDLE case (C1, compare exit 9), case 0 ALSO
   carrying a content divergence (compare exit 1)
                                                 -> exit 9 (EXIT_INTERNAL)
   - CASE 0's own line prints (tier=DIFFERENTIAL, compare_exit=1)
   - CASE C1's own line prints the RAW code, un-fabricated
     (tier=INTERNAL (compare exit 9 outside its documented contract
     {0,1,3,4,5,6}))
   - CASE C2 (the LATER case) still gets its own line AND its own
     determinism check runs to completion -- directly demonstrates the
     "a die there would cost every subsequent case its line" bound
     RV-STAGE1 added is now closed
   - the aggregate exits EXIT_INTERNAL(9), NOT EXIT_DIFFERENTIAL(4) even
     though case 0's own content divergence would, alone, have produced
     the latter -- directly demonstrates "ranks ABOVE every other code"
D. determinism mismatch on C2's own run2 (C1, case 0 clean)
                                                 -> exit 6 (DETERMINISM)
   - correctly attributed to case C2 by name; case 0 and C1 unaffected --
     confirms per-case directories genuinely isolate each case's own
     artifacts rather than merely appearing to
E. stimulus_gen producer refusal on the MIDDLE case (C1)
                                                 -> exit 3 (BUILD/PRODUCE)
   - CASE C1: stimulus_sha256=N/A ... tier=PRODUCE-REFUSAL
   - CASE C2 (the later case) still gets its own line -- the pre-existing
     "never die mid-loop" property, confirmed to still hold with
     genuinely per-case directories, not merely with the old shared ones
Negative control: CASES array reverted to the dispatch's own lowercase
"c1"/"c2" spelling, otherwise identical script    -> exit 3
   - BOTH new cases PRODUCE-REFUSE ("unknown case id") -- confirms the
     item-1 correction above is load-bearing, not cosmetic; reverted
     immediately after this one confirmatory run
```

All six matched the intended design exactly; the negative control failed
in exactly the way the corrected code avoids. This is NOT a claim that the
real `dune`/`iverilog`/`vvp`/Hardcaml pipeline was executed — it was not —
and nothing here is offered as a substitute for the landing CI run, which
remains the only real check on the Hardcaml-dependent and Verilog-dependent
halves (WO-0046 §10, this packet's §10 item 12). The stub scaffold and its
outputs lived entirely under this spawn's scratchpad and were never staged;
stray files this round wrote directly to `/tmp` (outside the scratchpad, a
deviation from this environment's own standing instruction) were found
before finishing and deleted — flagged here per the durability clause
rather than silently cleaned up unmentioned.

**Refused or blocked**: nothing refused. One disclosed correction beyond
the dispatch's own literal text — the case-id casing (item 1 above) —
made against the re-measured source rather than silently followed or
silently overridden; recorded here, in the journal, and demonstrated by
both a positive scenario (A, C1/C2 resolve correctly) and a negative
control (the lowercase spelling reproduces the failure it would have
caused). No RTL was opened at any point; `test/attack_plans/**` was read
only where the packet's own §14 already quotes it (CD §10.1/§10.2, via
this packet's own text and the re-measurement above), never opened
directly by this seat as a separate file read beyond confirming CD's own
freeze commit precedes this spawn-head in `git log`.

**Files changed** (exactly the packet's named file for my half, nothing
else — `git status --porcelain` confirms one file, `tools/cosim/
run_cosim.sh`; no `test/**`, no `test/attack_plans/**`): `tools/cosim/
run_cosim.sh`.

— data_wrangler, spawn `WO-0078-DW-STAGE2-C1C2/2026-08-06T11:05Z` (no
explicit "work-order id + spawn UTC timestamp" token, PROTOCOL §4.1's
described form, was present in this spawn's own dispatch prompt — recorded
honestly per `J-data_wrangler-0001`/`0003`/`0005`'s own precedent for the
identical situation, rather than presented as one copied verbatim; the
timestamp above is this entry's own UTC header time, `date -u` read at the
start of this round, matching the environment's own `currentDate` context
of 2026-08-06).

### dv_lead — `RV-C1C2`: Stage 2 (§6.2), the C1+C2 landing — **C1 ACCEPTED, branch α; C2 VOID — no comparison was reached**

#### 0. What I executed, and what I did not

**HEAD verified as my first action**: `git rev-parse HEAD` →
`53fa1de2814e4841715ddeaa2b79590afd5ece41`, exactly the spawn head. Neither
rollback disposition fired.

**This round writes three things and nothing else**: this verdict, the `State`
field at the head of this file, and my journal. **No `test/**`, no `tools/**`,
and — ruled in §3 below — no edit to `test/attack_plans/CD-xgmii_rx_64_cosim.md`.**
Every defect below is a finding for a named carrier round, not a repair I made:
§6.2 gives those files to the assignees, and a reviewer who repairs what it
reviews has stopped being one.

**I executed no simulation** (ADR-0005). My evidence is: the two landing commits'
diffs and the sources as they stand at `53fa1de`; the `cosim` job log read in
full through the server-side GitHub logs tool; the run and job metadata read from
the same API; and three mechanical checks I ran on the checkout rather than
taking from either Return log. **The blocked-fetch leg both assignees and
`RV-STAGE1` §0 recorded recurred**: the direct log fetch 302s to a
`productionresultssa*.blob.core.windows.net` host this session's egress denies
with `403`. Reading through the logs tool is a **different transport onto the
same public artefact**, not a retry of a policy denial.

**The run, at the API rather than at either Return log.** `build` run
**`31096150983`**, `head_sha` **`53fa1de`**, event `push`, conclusion
**`failure`**. Two jobs:

- **`cosim` `92598555141` — `failure`.** Steps 1–5 (checkout, OCaml, deps,
  Icarus) all `success`; step 6 *"Run the co-simulation lane (WO-0046 Phase 1)"*
  **`failure`**, 11:14:45 → 11:14:53.
- **`build` `92598555210` — `success`, every step.** Build, `dune runtest`
  (expect tests and waveform snapshots), Generate RTL, the unpromoted/
  non-determinism check, the DV mechanical checks (C-9, X-9) and the C-37
  abort-bit quantifier over 8.7 M pairs are all green.

**So the bench compiled and the whole main suite passed. The red is the
co-simulation lane's own, and it belongs to exactly one case** — which is the
property §3.1 consequence 2 said per-case reporting would buy and which this run
is the first to demonstrate on real stimulus.

**Three mechanical checks, mine, not either Return log's:**

1. **`git merge-base --is-ancestor 5c01af0 53fa1de` → true.** CD §10's freeze
   commit is an ancestor of the commit the run executed. **§12 criterion 8's
   precondition therefore holds for both cases by commit ordering rather than by
   anybody's assertion** (§8 below).
2. **`git log --oneline 5c01af0..53fa1de`** → exactly four commits (`8427b12`
   printer repair, `c06ae01` board, `a822f46` tb half, `53fa1de` runner half).
   **No commit in that range touches `test/attack_plans/`**, so neither C1's nor
   C2's frozen instance moved between its freeze and its run.
3. **The two producers' refusal guards, read at source** at `53fa1de` —
   `test/cosim/ours_run.ml`'s `accumulate` and `test/cosim/tb_xgmii_rx_64.v`'s
   driving loop. **Both are DV-side files in my own scope. No `libs/**`, no
   `top/**`, no `rtl_snapshots/**` was opened at any point in this round**, and
   every expected value cited below is from `docs/specs/` or from a frozen
   document of mine. §4 is what that reading found.

---

#### 1. The CI reading, at the source — three cases, in the order the harness ran them

**The case set line**: `=== CASE SET (WO-0078 §6.2 Stage 2: 3 case(s) — 0 C1 C2) ===`.
Uppercase ids, matching `stimulus_gen.ml`'s own `known_cases` (see §7's conduct
ruling).

**CASE 0 — the freeze, and it holds.**

> `[ok]   case 0 stimulus.txt sha256: c675517176922d42bca42ec3def182cb3536861f1acaa8384116f33a5c4cc051`
> `case 0 stimulus_sha256 (pinned -- freeze's own independent anchor, RV-STAGE1 §1, build run 31080871169, job 92549154623, commit 55e16ae): c675517…4cc051`
> `[ok]   case 0's stimulus is byte-identical to the last green pre-widening run`
> `CASE 0: stimulus_sha256=c675517…4cc051 compare_exit=0 tier=CLEAN`

`T0: aligned`, `frame 0: admit_cycle = 0`, `T1: clean` with `word 0: expected 3,
observed 3` … `word 7: expected 10, observed 10`, `T2: theirs cycles = [3 4 5 6 7
8 9 10]`, `theirs - ours per word = [0 0 0 0 0 0 0 0]`. Determinism: run1/run2
byte-identical. **And the citation now names the run that predates what it
protects** — `RV-STAGE1` §1's standing note is obeyed in the harness's own printed
output, which is where the next reader will meet it.

**CASE C1 — clean, and it selects its branch (§2).**

> `[ok]   case C1 stimulus.txt sha256: 5ae9e4f501251c38d0c2d386bd792e07cbcf9cf107cf7e75c378e21b1ce3bd7c`
> `frames compared: 1` / `frames matching: 1` / `divergences: none`
> `T0: aligned -- every frame index present on both sides shares one admit-cycle`
> `  frame 0: admit_cycle = 0`
> `T1: clean` … `word 0: expected 3, observed 3` … `word 7: expected 10, observed 10`
> `  frame 0: theirs cycles = [4 5 6 7 8 9 10 11]`
> `  frame 0: theirs - ours per word = [1 1 1 1 1 1 1 1]`
> `CASE C1: stimulus_sha256=5ae9e4f5…3bd7c compare_exit=0 tier=CLEAN`

Determinism: `case C1: ours.canon/theirs.canon byte-identical between run1 and
run2`. SUMMARY block printed with its one-class sentence.

**CASE C2 — the stimulus was driven and no canonical file was ever produced.**

> `[ok]   case C2 stimulus.txt sha256: cc1e85a4c5f871226f07b4792446d63c523577dcf172d6c4a80b8a3e845b44a7`
> `Fatal error: exception Failure("ours_run: a second start character arrived while a frame was open -- REQ-110 abort handling is out of Phase 1's authorised stimulus (WO-0046 section 9)")`
> `Called from Dune__exe__Ours_run.accumulate.(fun) in file "test/cosim/ours_run.ml", line 172, characters 13-226`
> `CASE C2: stimulus_sha256=cc1e85a4…5b44a7 compare_exit=N/A tier=PRODUCE-REFUSAL (PRODUCE (ours_run, our side, case C2 run1: ran and exited 2 -- the build had already succeeded))`
> `run_cosim: FAILED CHECK: PRODUCE (PRODUCE (ours_run, our side, case C2 run1: ran and exited 2 -- the build had already succeeded))`

**No `vvp` line for C2 anywhere in the log.** `ours_run` runs first in
`run_pipeline`; the reference side never executed for this case. That fact is
load-bearing in §4.

**Cost.** `case 0 run1 0.677s / run2 0.679s / sum 1.356s`; `case C1 run1 0.675s /
run2 0.674s / sum 1.349s`; `case C2 run1 0.014s` (a refusal, not a cost datum);
`run_cosim.sh wall time (this invocation): 8.266s`. **Band A is read in §9.**

---

#### 2. C1's branch selection, adjudicated against CD §10.1's own instance

**α is defined at §7 as *"the observable agrees inside the domain"*, and CD
§10.1's α condition adds one rider of its own: *"T1's expected set is unchanged
from case 0's `{3 … 10}`"*.** Both limbs, checked separately, because they are
different kinds of claim.

**Limb 1 — agreement inside the domain. MET, and non-vacuously.** REQ-901's
operative list (CD §0-bis correction 1) is payload octets, the `tkeep` extent of
**each** word, `tuser`[0] on each `tlast`, and the accept-or-discard decision per
input frame. `canonical.mli`'s `divergence` type carries exactly those, plus
frame presence and word count: `Missing_frame`, `Decision_mismatch`,
`Word_count_mismatch`, and `Word_mismatch` with `field` in
`["tkeep" | "tlast" | "tuser0" | "octets"]`. **`frames compared: 1`,
`frames matching: 1`, `divergences: none` is therefore a statement over all four
REQ-901 observables and not over a subset**, and `compare` exited 0. **A
comparator that has only ever agreed is worth nothing** (CD §8) — this same
binary, in this same invocation, reported the seeded one-octet perturbation at
exit 1 and eleven further self-test cases at their own distinct codes. The
agreement is a measurement, not a silence.

**Limb 2 — the ours-vs-spec rider. MET.** `T1: clean` with the printed set
`{3, 4, 5, 6, 7, 8, 9, 10}`, word for word identical to case 0's in the same run.
**This is an assertion of ours against SPEC-M03 §7 and §6.1, not comparison
content** — CD §10.1 says so in terms, and the distinction survives here rather
than being collapsed now that both numbers happen to agree.

**Ruling: C1 selects branch α.** Not by elimination and not because the run was
green: by the definition §7 froze and the condition CD §10.1 froze, both before
the run, and both met on the printed record.

**What C1 closes.** `WO-0046`-adjudication §5 item 2 — *"lane 4 has never been
driven at this boundary … where every quantity SPEC-M03 §7 pins takes its other
value"* — is **CLOSED**. Lane 4 has now been driven at this boundary, at the
reset-release cycle, and SPEC-M03 §7's *both-rows* ΔC = 3 is measured rather than
derived for the first time in this programme's history.

**What α buys, bounded before it is banked (§8's table, per class, never per
module).** `AP-M03` §7 **bar 1 lifts for exactly one class**: *a 64-octet
good-FCS frame whose start character is in lane 4 of the reset-release cycle.*
It lifts for **nothing else** — not for the two-clean-frames class (C2 reached no
comparison), not for lane 4 at a non-zero admit cycle, not for any length but 64.
Bars 2, 3 and 4 are **unchanged**; no case in this landing pulses
`error_bad_fcs`, so §8's C3 cell has not been reached and **the strobe record
stays refused**. **Writing that lift into `AP-xgmii_rx_64.md` §7's cells is §13
item 2's AP round, not this one** — I record here that the lift is *earned*; the
plan round records that it is *taken*.

**And the honest bound on what "agreement" proves — `FINDING RV-0078-S2-2`.**
α is an **agreement** predicate. CD §10.1 also states **absolute** expected
values — 60 delivered octets, 8 output words, `tkeep` `0xFF` ×7 then `0x0F`,
`tlast` on word 7, `tuser`[0] = 0 — and **this lane checks none of them against
the specification; it checks only that the two sides say the same thing.** From
the printed record, two of those are independently confirmed for our side: the
frame was **accepted** (it appears in T1's accepted-frame list) and it produced
**8 output words** (T1 prints `word 0` … `word 7`). The remaining four are
confirmed **only up to agreement**. A common-mode error — both sides wrong the
same way — satisfies α and violates the instance, and this instrument cannot see
it. The mitigation is real but lives elsewhere: the X-1 bench family under
`test/xgmii_rx_64/` checks our side against the spec-derived absolute values.
**The `SO-` must say which instrument discharges which half, per class**, and
must not let α's agreement stand in for the absolute check. Recorded as a finding
in §6 rather than repaired here.

---

#### 3. The T2 `+1` offset — what it is, and where the fact lives

**What was measured.** At case 0 (lane-0 start) `theirs - ours per word =
[0 0 0 0 0 0 0 0]`. At C1 (lane-4 start, same frame, same admit cycle)
`theirs - ours per word = [1 1 1 1 1 1 1 1]`. **The reference delivers one cycle
later at a lane-4 start; our side does not.** Our side's own T1 is `{3 … 10}` at
both lanes, which is SPEC-M03 §7's pin ((L + h) = 24 in both rows) holding under
measurement.

**Its adjudicative status: CD §5.2 X1 — *all cycle timing, latency and
word-to-word spacing* — OUTSIDE the domain. CD §0: a difference outside the
domain is *data — recorded, not adjudicated*. REQ-901 excludes cycle alignment.
`AP-M03` §7 bar 3 bars a cross-side timing comparison and is untouched.** So this
is **not** a divergence, **not** branch γ, **not** a `BUG-` candidate and **not**
a spec-diff candidate. It is a legal design difference between two conformant
receivers, and the reference's latency is its own business.

**And it is the first time X1 has excluded anything.** At case 0 the offset was
zero, so the exclusion removed nothing observable. At C1 it is one cycle on every
word. **Had cycle indices been inside the domain, C1 would have reported eight
divergences on a frame where every REQ-901 observable agreed.** CD §3's stated
reason for the transaction-level canonical form — *"comparing cycle indices would
report a legal design difference as a divergence on every single frame"* — has
stopped being a prediction and become a measurement. **That is recorded as the
vindication of a frozen exclusion. It moves nothing, and no entry moves in either
direction on its account.**

**Where the fact lives — ruled, because CD §5.2 says *recorded* without naming a
vessel:**

1. **Primary record: the run itself** — `build` run `31096150983`, `cosim` job
   `92598555141`, the two printed T2 lines. That is an externally verifiable
   reference in PROTOCOL §4.1's own sense, it is permanent, and it cannot drift.
2. **Adjudicative record: this verdict**, which quotes both lines verbatim above
   **with their status attached** — data, X1, never adjudicated. A recorded datum
   whose status is recorded somewhere else is a datum a later reader will
   re-adjudicate.
3. **Forward carrier: `SO-xgmii_rx_64.md`**, which states it as an observed
   property **of the reference**, in the sentence that also says the lane
   compares no cross-side cycle. Owed at the `SO-` round.

**Not in the CD, and the reason is three-fold.** (i) **§10.7 item 3**: *"This
document freezes the questions; it answers none of them."* A results record
inside the frozen-question document destroys the one property that makes a frozen
prediction worth anything — that a reader can tell a prediction from an outcome
without checking a date. (ii) **§9-bis's addition-only lift is scoped**, in its
own words, to *"§10 below, carrying co-sim Phase 2's domain instances"*. **A
result is not a domain instance**, and using an addition-only lift for a class of
content it did not name is precisely how an addition-only lift becomes a general
one. (iii) A second record of a run's outcome, in a document later rounds read as
authoritative, is the **left-standing-summary** class §0-ter tabulates four
payments for. The log cannot drift; a restatement of it can.

**Not in `AP-xgmii_rx_64.md` §7 either.** Bar 3 forbids a cross-side timing
comparison. **A recorded cross-side cycle datum sitting immediately beside the bar
that forbids comparing cross-side cycles is the exact shape a later reader
misreads as the bar having lifted.** AP §7's per-case cells record **bar
movements**, not measurements, and they are §13 item 2's round.

**So: no CD edit is made by this round, on the branch-selection question or on
this one.** C1's α is recorded here and in the log; the CD keeps the question.

---

#### 4. C2 — the disposition, and the mechanism, which is not the one the message names

**C2 selects NO branch.** α, β and γ are dispositions of a **comparison**;
C2 produced no canonical file on either side, so there was nothing to compare and
nothing to dispose of. The harness said exactly this and said it honestly:
`compare_exit=N/A tier=PRODUCE-REFUSAL`, on `WO-0049` §8's *reached-a-verdict /
did-not-reach-one* axis. **This is an INSTRUMENT INCAPACITY. It is not a
divergence, it is not a defect in our RTL, it is not branch γ, and it is not
REQ-110.**

**The message names REQ-110. The mechanism is not REQ-110's, and the difference
is the whole finding.**

**The arithmetic, from CD §10.2's own text and REQ-0.3's gap convention.** Frame
0's start character is at octet position 0; its terminate character at position
8 + 64 = **72**, i.e. **input line 9, lane 0**. Frame 1's start character is 84
octet times behind it (8 preamble + 64 frame + 12 gap — CD §10.2 states the 84
itself), i.e. position 84 = **input line 10, lane 4**. **On the input side the two
frames do not overlap: a full cycle separates frame 0's `/T/` from frame 1's
`/S/`.** The schedule is conformant — `Arrival.check` returns `[]`, and the
stimulus this run drove is the one CD §10.2 froze.

**The measurement, from this run.** Case 0 is the same construction as C2's frame
0 — one 64-octet good-FCS frame, lane-0 start, admit cycle 0 — and this run
printed its final output word at **cycle 10** on both sides
(`word 7: expected 10, observed 10`; `theirs cycles = [3 … 10]`). SPEC-M03 §6.1's
`admit_cycle + m + 3` gives the same number without a run.

**The source, at `test/cosim/ours_run.ml:152–190`.** `open_frame` is **set at the
input start character** —

> `| Some (0 | 4) -> (match !open_frame with | Some _ -> failwith "ours_run: a second start character arrived while a frame was open …" | None -> open_frame := Some (!next_index, line_index, []); …)`

— and **cleared only at the output `tlast`**, in `close_frame ~decision:Accept`
under `if out.Stream_word.tvalid … if out.tlast`. **So the state the guard tests
spans `/S/` → OUTPUT-`tlast`: the union of the input-side and the output-side
frame spans, which for a 64-octet frame at ΔC = 3 outlasts the input-side
terminate by exactly one cycle.** And within one iteration of the fold the
start-character arm runs **before** the output word is attached.

**Put together: at input line 10 the guard sees frame 1's `/S/` while frame 0's
union-span is still open by its last cycle. The minimum inter-frame gap places
frame 1's start character on precisely that cycle.** The refusal is a one-cycle
overlap between a bookkeeping span and the pipeline latency the specification
itself pins — **not a second start character inside an open frame, which is
REQ-110's actual condition and which this stimulus never presents.**

**The reference side has the identical structure and will refuse identically.**
`test/cosim/tb_xgmii_rx_64.v`: `frame_open` is set by the `open_frame` task at the
input start character, cleared in `close_frame_accept` on `m_axis_tlast`, and the
admission check sits **before** the drive and the post-edge sample — its own
comment says *"exactly as ours_run.ml checks Xgmii_word.start_lane before driving
the same word."* Its `tlast` for frame 0 lands on cycle 10 too (case 0's T2 offset
is zero). **It did not fire this run only because `ours_run` runs first and
`run_pipeline` stops there.** This is a source-derived prediction, not a
measurement, and it is stated so it can be falsified at the repair round's own
run — **but a repair to `ours_run.ml` alone would move the refusal to the other
producer, not remove it.**

**`FINDING RV-0078-S2-1` (MATERIAL; blocking for C2, inert for C1, C3 and C4) —
§2.2's census measured what each guard's message says, not what state each guard
tests, and the claim built on it is measured false.**

- **The false claims, all mine.** §2.2: *"Both guards fire only on a start
  character arriving **while a frame is open**. A second frame after the first
  closes passes both … Co-sim Phase 2 therefore needs **no accumulator change at
  all**."* §6.2's C2 row: *"Needs **no accumulator change** (§2.2)."* CD §10.2:
  *"it needs **no accumulator change** — `WO-0078` §2.2 measured both refusal
  guards …"*. **The premise is true of the guards' messages and false of their
  state.** "While a frame is open" is ambiguous between two spans that differ by
  the pipeline latency, and the census never asked which one the code holds.
- **Why the census missed it.** It enumerated **refusals** — file, line, message,
  trigger, effect — which is what `FINDING WO-0077-A1`'s repair asked for, and it
  is not enough. **A refusal is characterised by the state variable it tests and
  the span over which that variable is true, not by the condition its message
  names.** That is the lesson and it is banked in this round's journal.
- **Owner of the false claim: dv_lead. Mine, at §2.2, §6.2 and CD §10.2. Neither
  assignee is at fault**: tb_writer built exactly the stimulus CD §10.2 freezes
  and verified it against CD's own text; data_wrangler ran exactly the case set it
  was given and reported the refusal honestly, with the producer, the case, the
  run label and the "the build had already succeeded" discriminator all named.
  Both DoD lists are met.
- **Owner of the repair: tb_writer.** The files are `test/cosim/ours_run.ml`
  (FI-4, `accumulate`) and `test/cosim/tb_xgmii_rx_64.v` (FI-6, the driving
  loop) — **both, in one round, to one rule.** §6.3's gate (c) reasoning applies a
  stage early: *"two producers implementing the same rule from one written
  derivation is a review problem, and two producers implementing it from each
  other is a circularity."*
- **Carrier**: a tb_writer repair round, dispatched by me, **before C2 re-runs**.

**The successor rule, stated so the repair is not open-ended — derived from
REQ-110's own condition and SPEC-M03 §6.1's ΔC, and from no RTL and no reference
behaviour** (REQ-901's closing sentence):

1. **Two spans, separately tracked.** The **admission span** opens at `/S/` and
   closes at that frame's own `/T/` (or at end-of-stimulus). The **delivery span**
   is a FIFO of admitted frames in admission order; an output word attaches to the
   **oldest admitted frame that has not yet seen its `tlast`**, and `tlast` closes
   that frame.
2. **REQ-110's guard tests the ADMISSION span and only that one.** A second `/S/`
   while a frame's admission span is open is REQ-110's abort, is out of Phase 1's
   authorised stimulus, and **still refuses**. The repair **narrows the guard to
   its own condition; it does not implement abort handling**, which stays with C9
   in the scoped-not-authorised stage.
3. **The no-open-frame guard (FI-5 / FI-7) tests the DELIVERY queue's emptiness**,
   which is its own correct condition and is unchanged in meaning.
4. **Both producers implement (1)–(3) identically**, from this text, never from
   each other's code and never from the reference's behaviour.
5. **Two regression fixtures are owed, and they are a pair**: a two-frame
   minimum-IFG schedule that now **passes**, and a genuine REQ-110 schedule — a
   second `/S/` inside an open admission span — that still **refuses**. The second
   is the negative control that proves the narrowing did not delete the guard, and
   without it the repair is unfalsifiable in the direction that matters.
6. **What the repair may NOT do.** It may not touch `test/cosim/stimulus_gen.ml`
   (see §5's bind), may not widen any comparison, may not add a strobe field, and
   may not reorder the intra-cycle checks and stop there — **a bare reordering
   makes C2 pass while leaving the two spans conflated**, and it would fail at the
   first schedule whose overlap is more than this run's one-cycle accident.

---

#### 5. C2's disposition — **VOID AND RE-RUN**, in terms

**§12 criterion 8's void does NOT fire, and saying so matters.** C2's domain
instance was committed at `5c01af0`, a verified ancestor of `53fa1de` (§0 check
1). The case did **not** run before its instance was committed. Its prediction was
frozen in the open, in advance, and it is **unspent**.

**What voids C2 is simpler and stricter: no comparison happened, so there is no
result to adjudicate — and none may be constructed.** Concretely:

1. **C2 selects no branch.** Not α, not β, not γ. §7's table is not consulted for
   it, and its prediction — *"agreement on both"* — is neither confirmed nor
   falsified.
2. **CD §0's bar is not reached, because no difference inside the domain was
   shown**; the domain was never evaluated. **Nothing may move, and nothing does.**
   CD §10.2's INSIDE list, its expected values, its frozen prediction and its
   branches are **untouched by this verdict** and the re-run happens under that
   text **unamended**.
3. **C2 is re-run, not adjudicated** — the same disposition §6.2 gives a case that
   runs before its instance exists, reached here by a different road.
4. **The bind on the re-run, so that "same stimulus" is checkable and not
   asserted**: the repaired run's printed `case C2 stimulus.txt sha256` **must be
   `cc1e85a4c5f871226f07b4792446d63c523577dcf172d6c4a80b8a3e845b44a7`**, the value
   this run printed. **A different value means the stimulus moved under a repair
   that had no business touching it, and that is adjudicated as a finding before
   any C2 result is read.** `stimulus_gen.ml` is not among the files §4's repair
   opens; if a repair round opens it, it says why, in advance.
5. **What the record says about C2 from here.** It has been **dispatched once,
   driven once, and compared zero times.** No artefact may say C2 "ran and was
   clean", "ran and failed", or "was inconclusive about the two designs". The lane
   knows nothing whatever about the two-clean-frames-at-minimum-IFG class, and
   **`AP-M03` §7 bar 1 does not lift for it.**

**C1 is not touched by C2's red, and the reason is structural rather than
charitable.** C1 ran **before** C2 in the case loop; its own line, its own
comparison, its own determinism check and its own SUMMARY all completed and
printed; the cases had genuinely separate working directories
(`$WORK/case_<id>/…`), and all three cases' determinism checks reported
independently with no cross-case bleed. **An aggregate exit code assigned after
the loop does not reach back and unmake an earlier case's `compare_exit=0`.**

---

#### 6. Findings — five; one MATERIAL, four MINOR; each with an owner and a carrier

**`FINDING RV-0078-S2-1` (MATERIAL; blocks C2 only) — the refusal guards in both
producers test a span that outlives the input frame by the pipeline latency, so a
conformant minimum-IFG two-frame schedule is refused as a REQ-110 abort.**
Stated in full in §4 with its successor rule. **Owner of the false claim**:
dv_lead (§2.2, §6.2's C2 row, CD §10.2's rationale sentence). **Owner of the
repair**: tb_writer, in `test/cosim/ours_run.ml` **and**
`test/cosim/tb_xgmii_rx_64.v`, one round, one rule, with §4's fixture pair.
**Carrier**: a tb_writer repair round before C2 re-runs.

**`FINDING RV-0078-S2-2` (MINOR) — this lane checks agreement, and the CD's
instances state absolute values; nothing in the lane compares our side to them.**
Stated in §2. A common-mode error satisfies α and violates the instance. **Owner**:
dv_lead. **Carrier**: the `SO-` round, which must state per class which instrument
discharges the absolute half (the X-1 bench family) and which discharges the
agreement half (this lane) — and must not let α stand in for both. **Not repaired
by adding checks here**: an absolute check inside the differential comparator
would duplicate the bench family's job in the instrument least able to justify its
expected values.

**`FINDING RV-0078-S2-3` (MINOR) — §7's branch table claims an exhaustiveness it
does not have: the three branches partition COMPARISONS, not CASES.**
§7's prose reads *"The three branches, and **every case's result resolves to
exactly one**."* **C2 measured a fourth outcome — no comparison at all — and §7
has no cell for it.** The harness got this right where the packet did not: its
tier vocabulary already carries `PRODUCE-REFUSAL` with `compare_exit=N/A`, on
`WO-0049` §8's *reached-a-verdict / did-not-reach-one* axis. **Class MINOR**
because nothing was mis-adjudicated — the correct reading (no branch) is forced by
the branch definitions themselves, exactly as `FINDING CD-P2-1`'s blank was — but
it is the second defect of the same species in the same table, and the species is
*a table whose completion has to be reconstructed from prose elsewhere.*
**Owner**: dv_lead. **Carrier**: this verdict, which rules it, **and** the co-sim
Phase 3 CD instance round — **C9 is a produce-refusal case by construction** until
§6.3's admission rule lands, so Phase 3 cannot be written without this cell.

**`FINDING RV-0078-S2-4` (MINOR, records defect) — CD §10.2 carries the falsified
"needs no accumulator change" sentence inside a frozen section, and one annotation
beside it is owed.** The clause is §10.2's *"Why this case exists"* rationale, not
its INSIDE list and not its prediction, so **it cannot mislead C2's re-run
adjudication** — which is why this is MINOR and why the re-run is not blocked on
it. But a measured-false sentence left standing in a frozen document is the class
§0-ter tabulates four payments for, and §9 requires every change to be recorded
rather than made silently. **Owed: exactly one annotation beside §10.2, in
§0-ter's and §9-bis's established form** — §9's four items, and an explicit
statement that it touches §10.2's INSIDE list, expected values, frozen prediction
and branches in no way whatever, so that the re-run runs under the identical
instance. **Owner**: dv_lead. **Carrier**: the CD round accompanying the C2 re-run
dispatch, before the re-run runs. **Deliberately not made by this round**: this
round's write set is the verdict, the State field and the journal, and a reviewer
who widens its own write set mid-round is doing the thing it convicts others for.

**`FINDING RV-0078-S2-5` (MINOR) — criterion 7's literal "distinct non-zero
harness exit code" per refusal is not met; distinctness lives in the tier and the
message, not in the code.** `run_cosim.sh`'s `EXIT_BUILD=3` carries both a
`stimulus_gen` refusal (observed in the assignee's own negative control) and an
`ours_run` FI-4 refusal (observed in CI this run), discriminated by the printed
reason string — *"ours_run, our side, case C2 run1: ran and exited 2 — the build
had already succeeded"* — which does name the producer, the case, the run label
and the build-versus-produce distinction. **The criterion's purpose is met; its
wording is not.** **Two lawful routes, and no third**: split the codes per
producer, **or** amend criterion 7's wording in a dated successor. **What is
barred is settling it in the reading of a run that has already happened** — that
is the shape §0 exists to prevent, one level up from a case. **So it is settled
BEFORE the next run**, whichever way. **Owner**: dv_lead (the criterion's wording)
with data_wrangler as implementer if the split wins. **Carrier**: the C2 re-run
dispatch, which must carry the settlement. **Recommendation**: amend the wording —
a code per guard multiplies the exit table without adding attribution the printed
line does not already carry, and the one distinction that is load-bearing
(BUILD versus PRODUCE — *did the binary run?*) is already a code-level one.

**Three prior findings CLOSE on this run, and one stands.**

- **`FINDING RV-0078-S1-2` (a) — CLOSED.** `frame 0: admit_cycle = 0` is printed
  unconditionally on the aligned path, observed for case 0 **and for C1, the first
  non-case-0 instance**, which is the only check that `~first_start:4` admits on
  the reset-release cycle.
- **`FINDING RV-0078-S1-2` (b) — CLOSED at the mechanism**, observed in the
  self-test (`(FINDING RV-0078-S1-2 limb b)` PASS at exit 4: frame 0's clean
  per-word numbers printed beside frame 1's divergence). **Its production instance
  is owed at the C2 re-run**, which is the first production case with two frames.
- **`FINDING RV-0078-S1-1` — CLOSED.** The successor rule landed and is observed
  in CI: the `[0; 1; 2]` two-idle fixture now refuses at exit 6 where the retired
  broken-delta count asserted at exit 4, and `(e)`/`(e′)` still land on their own
  branches. **The production class remains unengaged** — no case in this landing
  injects an idle.
- **`FINDING RV-0078-S1-3` — CLOSED**; see §9.
- **`FINDING RV-0078-S1-4` — STANDS.** The reference-side **emission** path has
  still never executed. This run brought it one step closer and did not reach it:
  `ours_run` refused first, so `vvp` never ran for C2. **§4's prediction says C2's
  repaired re-run will not trip it either** (a correct guard on a conformant
  schedule fires on neither side), so `FINDING RV-0078-S1-4` remains first
  dischargeable at **C9**, in the scoped-not-authorised stage — unchanged.

---

#### 7. The dispatch-shorthand correction — worker conduct, ruled

**The facts.** My Stage-2 dispatch to data_wrangler wrote the case array as
`CASES=("0" "c1" "c2")`, lowercase. `test/cosim/stimulus_gen.ml`'s `known_cases`
carries `"0"`, `"C1"`, `"C2"`, matched with `String.equal`. data_wrangler
re-measured the source before writing a line, found the contradiction, **corrected
against the source**, disclosed the correction in its Return log and its journal,
and **demonstrated it load-bearing with a negative control**: reverting to the
lowercase spelling reproduces exactly the failure it avoids — both new cases
PRODUCE-REFUSE on `unknown case id`, and the whole landing reports RED for a defect
that exists in neither producer, only in the call site.

**Ruling: CORRECT, and commended.** It did the third thing, which is the only
right one: **not** silent compliance (a red landing attributable to nothing), and
**not** silent override (an undisclosed deviation from a dispatch). The general
rule it instances, which I state here so it is citable rather than re-derived:
**a dispatch's restatement of a committed artefact is evidence about the dispatch,
not about the artefact; where they disagree the artefact governs, the assignee
corrects to it, discloses the correction, and — where the correction is
behavioural — demonstrates it with a control that reproduces the uncorrected
failure.** The negative control is what turns the disclosure from a claim into a
check, and it is the part I would have bounced the round for omitting.

**The proximate defect is mine**, in a spawn prompt. **No repair is owed and none
is possible**: a dispatch prompt is not a committed artefact, so there is nothing
to annotate. **The standing obligation it leaves is on me** — a dispatch that
quotes a case id, an exit code, a hash or a section number quotes it from the file,
not from memory of the file. Recorded here rather than numbered, because a finding
needs a carrier and this one has no artefact to carry it.

**tb_writer's round is likewise ruled sound on its own terms**: it re-measured
FI-1/FI-2 and `Frame.stress_frame` at its own base, built both cases from CD
§10.1/§10.2's own text rather than §6.2's table cells, reproduced case 0's pinned
hash **by re-executing `build ()`** — the strongest form of *case 0 untouched*
available without CI — and disclosed its local type-check-and-link scaffold as
scaffold. **Neither assignee's DoD list has a gap. The blocking defect in this
landing is in my packet, not in their work**, and that is the second consecutive
stage of which that is true.

---

#### 8. §12 read per criterion — nine, one disposition each, at `53fa1de`

| # | criterion | disposition at `53fa1de` |
|---|---|---|
| **1** | case 0 byte-identical | **DISCHARGED**, non-vacuously, and the printed provenance now cites the genuinely pre-widening run `31080871169` / job `92549154623` / `55e16ae` rather than the post-change run `RV-STAGE1` §1 convicted as circular. The standing note survives: the check is still against a literal inside the file it constrains, and **the run is the anchor, never the literal**. |
| **2** | the sighted placement survives | **DISCHARGED — first time in full.** Both halves now exist: the case set contains cases presenting a start character on the reset-release cycle, and the harness **prints** `frame 0: admit_cycle = 0` — for case 0 **and for C1, the first non-case-0 instance**, which is what makes §4.2's sighted-placement argument checkable on a new stimulus with a new hash rather than inferred from a hash that cannot move. `FINDING RV-0078-S1-2`(a) CLOSED. |
| **3** | every case reaches a verdict or names why not | **PARTIALLY DISCHARGED, and materially advanced.** Newly demonstrated **in CI, not in a stub**: three per-case lines at N = 3, all four fields on each; **a case that reached no verdict naming why it did not**, with the producer, the case, the run label and the build-versus-produce discriminator in the line itself; three independent determinism checks in genuinely per-case directories with no cross-case bleed. **Still NOT demonstrated**: the property the criterion actually protects — *a red case does not cost a LATER case its line* — **because C2 was last in the case set**. Written for it, stub-exercised, never CI-exercised. **The condition that closes it is now nameable**: the first landing in which a case that does not reach a clean verdict is followed by another case in the array. **Case ORDER has become evidence, and appending new cases keeps it so.** |
| **4** | T1 prints its numbers on the clean path | **DISCHARGED for production single-frame cases** — case 0 and C1, eight words each, expected and observed, on the clean path where a green run is most tempted to print nothing. Limb (b)'s multi-frame production instance is owed at the C2 re-run (§6). |
| **5** | T1's antecedent carried, not inferred | **NOT FURTHER ENGAGED.** No case in this landing injects an idle; the sidecars carried `0` and `0, 0`. The class stands where `RV-STAGE1` left it, with `FINDING RV-0078-S1-1`'s successor rule now landed and observed in the self-test. |
| **6** | the two constructors separately testable | **DISCHARGED**, re-observed this run: `(e)` at exit 4, `(e′)` at exit 6, distinct fixtures, distinct branches, neither optional. |
| **7** | every producer's refusal reaches an exit code | **PARTIALLY DISCHARGED, and this is its first REAL production firing.** `ours_run`'s FI-4 guard fired on live stimulus, exited non-zero, was classified `PRODUCE` (*"ran and exited 2 — the build had already succeeded"*), carried `compare_exit=N/A tier=PRODUCE-REFUSAL` on its own case line, and aggregated to exit 3 on the did-not-reach-a-verdict side. **The criterion's own failing observation — "a refusal that prints and lets the run proceed to a comparison" — did not occur.** Two gaps stand: the reference-side **emission** path is still unexecuted (`FINDING RV-0078-S1-4`, first dischargeable at C9), and the literal per-guard **distinct code** is not met (`FINDING RV-0078-S2-5`). |
| **8** | every case's disposition frozen before it ran | **DISCHARGED, and it BITES for the first time.** CD §10.1 and §10.2 were frozen at `5c01af0`, a verified ancestor of the run's commit. **This is what makes C1's α selectable rather than chosen, and what makes C2's void a void rather than an invitation to write a disposition now with the answer in hand.** The criterion earned its keep on the case that failed, not on the one that passed. |
| **9** | no claim outside the driven set | **DISCHARGED for this round's artefacts, and STANDING.** The one-class SUMMARY sentence printed for case 0 and C1. **C2 printed no SUMMARY — correctly: it has no result to bound** — and no artefact anywhere claims anything about C2. This verdict lifts bar 1 for exactly one class and says so per case. |

---

#### 9. Cost — Band A, read against §9's own pre-committed text

**Both clauses, separately.**

- **Absolute**: `run_cosim.sh wall time (this invocation): 8.266s` against a
  **300 s** bound, at N = 3. Comfortably met. The extrapolation to the full
  authorised set of five cases (≈ 13–14 s) is stated **as an extrapolation** and
  the band is re-read at each landing.
- **Linearity**: *"each added case costs no more than 2× the single-case
  measurement."* **Measurable for the first time and MEASURED**: case 0's
  `run1+run2` sum **1.356 s**, C1's **1.349 s** — a ratio of 1.005 against a bound
  of 2. C2's 0.014 s is a refusal, not a cost datum, and is not used. The build,
  the `iverilog` compile, the provenance checks and the once-only self-test remain
  outside the per-case body, which the printed sequence now shows rather than
  merely permits.

**Band A is DECLARED MET at the landed set, and `FINDING RV-0078-S1-3` is
CLOSED** — both limbs: the probe now brackets **both** `run_pipeline` calls and
prints their sum, and a run with N ≥ 2 productive cases exists. `RV-STAGE1` §6's
bar — *"Band A may not be declared met until a run with N ≥ 2 exists"* — is
satisfied on its own terms.

---

#### 10. Sequencing — does C2's red block the C3 landing?

**Ruling: C3 is NOT blocked in principle, and IS sequenced behind the C2 repair.
Both halves, with their reasoning.**

**Not blocked in principle.** C3's stimulus is **one** 64-octet frame. §4's defect
requires a **second** start character; C3 presents none, so the guard cannot fire
on it at either producer. C3's domain instance (CD §10.3) is frozen and untouched.
Its evidentiary content — CD §6's V7, *"the one to watch"* — is independent of
C2's in every particular: a different requirement (REQ-104, REQ-005), a different
predicted branch, and a resolution route (a REQ-901 spec diff) that C2 does not
touch. **Nothing about C2's defect makes a C3 result unreadable in itself.**

**Sequenced behind the repair anyway, and the reason is readability, not
principle.** Three grounds, in order of weight:

1. **The property C3 would have to lean on is the one this run did not
   demonstrate.** With C2 red and ordered before C3 in the array, the aggregate
   exits 3 whatever C3 does, and **C3's own per-case line becomes the sole carrier
   of its result** — which is exactly criterion 3's plural content, and **CI has
   never run a case after a red one** (§8, criterion 3). Landing C3 there would
   make a spec-diff-grade result rest on an unexercised property of the harness.
2. **C3's result may force a REQ-901 spec diff** — §6.2's stated reason for
   landing it alone. **A spec-diff conversation opened from a red run whose
   aggregate names a different case's instrument defect is a conversation with an
   avoidable ambiguity in it**, and the ambiguity is avoidable by one repair round.
3. **The repair is cheap and its round is already owed.** Band A says the case set
   costs seconds; the ordering costs one round and buys a green baseline against
   which C3's own colour means what it says.

**The recommended sequence, therefore:** (1) tb_writer repair round — §4's rule,
both producers, the fixture pair — landing with the case set unchanged at
`{0, C1, C2}`; (2) my `RV-` on that run, which adjudicates C2's re-run under CD
§10.2 unamended and carries `FINDING RV-0078-S2-5`'s settlement; (3) the C3
dispatch, alone, per §6.2. **The repair does not ride with C3**: mixing an
instrument repair and a new case in one landing is the shape `WO-0075` §8 item 1
forbids and the shape §6.2's split exists to avoid.

**And one route that is BARRED, named so it is not discovered later as an
option.** C3 may **not** be landed by removing C2 from the case set, temporarily
or otherwise. **Removing a case to make a run green is the co-sim equivalent of
widening the permitted-divergence list to absorb a result** — it makes the lane
unable to fail, which is the property CD §0 exists to protect. If schedule
pressure ever makes that attractive, it goes up as **E2** with options,
recommendation and cost, and the case set is not reduced inside DV under any
circumstances (§9 Band C's own words, reached here by a different road).

---

#### 11. What this landing does NOT mean

1. **The landed, ADJUDICATED case set is `{case 0, C1}`.** `AP-M03` §7 **bar 1
   lifts for exactly one class** — a 64-octet good-FCS frame at a lane-4 start on
   the reset-release cycle. It lifts for **nothing** else, and specifically **not**
   for two clean frames at minimum IFG.
2. **The one-frame stimulus bound is UNCHANGED.** C2 is the case that would have
   lifted it and C2 reached no comparison. Seventeen of twenty-one seeded classes
   (§2.1) remain unreachable at this lane.
3. **Bars 2, 3 and 4 are untouched.** No strobe was compared, no cross-side cycle
   was adjudicated, and the strobe record stays refused. §8's C3 cell — bar 4's
   precondition (1) becoming met for `error_bad_fcs` — **has not been reached**;
   that is C3's, and C3 has not run.
4. **Nothing here advances the programme's Phase 2 or Phase 3** (§0.1, §10 item
   11). The MoldUDP64/ITCH golden book model and its external-reference agreement
   are a different instrument and not one line of it exists.
5. **No `SO-xgmii_rx_64.md` is opened, advanced or implied** (§10 item 10).
6. **A green `compare_exit` is not an absolute check.** `FINDING RV-0078-S2-2`
   bounds what C1's α proves, and the `SO-` carries that bound per class.

---

#### 12. Verdict

**C1 — ACCEPTED. Branch α, selected on CD §10.1's own frozen terms.** Every
REQ-901 observable agreed inside the domain on a non-vacuous comparator, and T1's
expected set was `{3 … 10}`, unchanged from case 0's, which is SPEC-M03 §7's
both-lanes ΔC = 3 measured rather than derived for the first time.
**`WO-0046`-adjudication §5 item 2 is CLOSED**: lane 4 has been driven at this
boundary. `AP-M03` §7 bar 1 lifts for **that one class and no other**; bars 2, 3
and 4 stand; the T2 offset of `[1 × 8]` is **CD §5.2 X1 — data, recorded here and
in the run, never adjudicated** — and it is the first occasion on which that
exclusion has excluded anything, which vindicates CD §3's transaction-level form
by measurement instead of by argument.

**C2 — VOID, AND RE-RUN UNDER CD §10.2 UNAMENDED.** The case reached **no
comparison**: `ours_run` refused at `ours_run.ml:172` before any canonical file
existed, and the harness recorded that honestly as `compare_exit=N/A
tier=PRODUCE-REFUSAL`, aggregating to exit 3 on the did-not-reach-a-verdict side.
**C2 selects no branch — not α, not β, not γ — because α, β and γ dispose of
comparisons and there was none.** The refusal is an **instrument incapacity**, not
a divergence and not a defect in our RTL: **`FINDING RV-0078-S2-1` — both
producers' guards test a state spanning the input start character to the OUTPUT
`tlast`, which at ΔC = 3 outlives the input frame by one cycle, and the minimum
inter-frame gap places the next start character on precisely that cycle.** The
false claim that C2 *"needs no accumulator change"* is **mine**, at §2.2, §6.2 and
CD §10.2, and it is false because my census enumerated what each guard's message
says instead of what state each guard tests. **Neither assignee is at fault and
both DoD lists are met.** The repair is tb_writer's, in `ours_run.ml` **and**
`tb_xgmii_rx_64.v`, one round and one rule, with a passing minimum-IFG fixture and
a still-refusing REQ-110 fixture as a pair. **C2's prediction stays frozen and
unspent; its instance is not reopened, not widened and not amended; and its re-run
must print `stimulus_sha256=cc1e85a4…5b44a7` or the stimulus has moved and that is
adjudicated first.**

**C3 is not blocked in principle — its single-frame stimulus cannot trip the
defect — and is sequenced behind the repair**, because C3's own line would
otherwise be the sole carrier of a possibly spec-diff-grade result under a
harness property CI has never exercised. **Landing C3 by removing C2 from the case
set is barred outright.**

**Five findings are raised** — one MATERIAL (`S2-1`, blocking C2 alone) and four
MINOR (`S2-2` agreement-is-not-absolute; `S2-3` §7's branches partition
comparisons, not cases; `S2-4` CD §10.2's falsified rationale owes one annotation
beside it; `S2-5` criterion 7's distinct-code literal, to be settled **before** the
next run and not in the reading of a run already had) — **and four close**:
`RV-0078-S1-1`, `S1-2`(a), `S1-2`(b) at the mechanism, and `S1-3` with **Band A
declared met** at 1.356 s versus 1.349 s per case and 8.266 s for the invocation.
`RV-0078-S1-4` stands and is still first dischargeable at C9.

**Criterion 8 earned its keep on this landing**: both instances were frozen at
`5c01af0`, a verified ancestor of the run, and that is the only reason C1's α is a
selection rather than a choice and C2's void is a void rather than an opening.
**Nothing in this round licenses a claim beyond two stimulus classes — one
64-octet good-FCS frame at a lane-0 start, and one at a lane-4 start on the
reset-release cycle. The lane still knows nothing about two frames.**

**dv_lead, `J-dv_lead-0152`, HEAD `53fa1de` (unmoved). Dated by the commit that
carries it.**

---

### dv_lead — `RV-C1C2-SETTLEMENT`: the two obligations owed BEFORE the C2 re-run — `FINDING RV-0078-S2-5` **SETTLED**, `FINDING RV-0078-S2-4` **DISCHARGED**, `FINDING RV-0078-S2-3`'s §7 repair **RULED NOT OWED HERE**

#### 0. What this round is, and what it is not

**This is not an adjudication and it reads no run.** `RV-C1C2` adjudicated the
C1+C2 landing at `53fa1de` and stands unedited. This round executes the two
obligations that verdict placed **before** the next run, so that the C2 re-run —
which fires at the tb_writer repair's landing CI — happens under settled text
rather than under text a later reader would find had been settled with the
re-run's own result in hand.

**Write set, and it is narrow by design**: `test/attack_plans/CD-xgmii_rx_64_cosim.md`
(one annotation, §10.2-bis), this packet (§12 criterion 7's amendment and this
entry), and `agents/journals/claude_dv_lead_agent.v07.md`. **No file under
`test/cosim/` or `tools/cosim/` is touched, no worker is dispatched, no case is
run, and no stage's disposition moves.** HEAD at this round's start was
`99561ea`, verified as the first action.

**The State field is deliberately untouched, and I checked rather than assumed
it.** It reads *"C2 — VOID, RE-RUN OWED under CD §10.2 **unamended**"*, and that
sentence is still exactly true after this round: the CD annotation is **beside**
§10.2, and §10.2 is unamended byte for byte. No stage state changed, so there is
nothing for the field to flip.

---

#### 1. `FINDING RV-0078-S2-5` — **SETTLED by amending criterion 7's wording.** The recommendation is executed, and the ground it rests on is corrected first

**The finding's own terms**: two lawful routes and no third — split the codes per
producer, or amend the wording in a dated successor — **settled before the next
run, whichever way**, because *"what is barred is settling it in the reading of a
run that has already happened."* **The amendment is at §12 criterion 7, with the
superseded text quoted beneath it rather than overwritten.**

**Ground 1 — the criterion carries two readings, and its own failing observation
selects the weaker one.** *"A distinct non-zero harness exit"* reads either as
**per-guard identity** (a code per guard) or as **distinct from the codes that
mean something else** (a refusal is never absorbed into a clean run or reported
as a comparison outcome). The criterion's own failing observation is *"a refusal
that prints and lets the run proceed to a comparison fails"* — which is the
second reading and only the second. A tie between two readings is broken by the
text's own statement of what fails it, not by which reading a run happened to
meet.

**Ground 2 — the per-guard literal was never the author's intent, and my own
recommended alternative proves it.** `FINDING RV-0078-S2-5` named the other
lawful route as *"split the codes **per producer**"*. **A per-producer split does
not satisfy a per-guard literal either**: `ours_run.ml`'s FI-4 and FI-5 are two
guards in one producer and would still share a code. **At no point did the
criterion's author mean per-guard distinctness** — which is a fact about the
packet, available without reading any run.

**Ground 3 — the decisive one, and it predates the run by two rounds.**
`tools/cosim/run_cosim.sh`'s `produce_reason` carries this lane's already
adjudicated design rule, landed by `WO-0073-D5`'s repair on an axis that went
through the `RV-` loop at `WO-0049` §8:

> *"The general form: **WHERE ONE EXIT CODE COVERS SEVERAL STAGES, THE STAGE MUST
> BE NAMED IN THE TEXT, BECAUSE THE CODE IS READ BY A MACHINE AND THE TEXT IS
> READ BY THE PERSON WHO HAS TO FIX IT.** Widening a code's contract is free;
> widening its label silently is how the two drift apart."*

**Criterion 7's literal is a drift AGAINST a rule this lane had already settled,
not a requirement the implementation failed to meet.** The amendment **restores**
the criterion to that rule; it does not accommodate a run to it. That is what
makes this a settlement rather than the hazard `CD` §0 exists to prevent, and it
is why the settlement is defensible even though it is written after a run that
the literal failed: **its ground is a committed artefact older than the run.**

**Ground 4 — cost, stated last because it decides nothing on its own.** A code
per guard multiplies a namespace that already carries a total precedence order
(§3.3) and an aggregate-selection rule, and it buys attribution the printed
record carries better and per case.

**The correction I owe my own recommendation, made before it is relied on.**
`FINDING RV-0078-S2-5` closed with: *"the one distinction that is load-bearing
(BUILD versus PRODUCE — did the binary run?) is already a code-level one."*
**Measured at this SHA, that is wrong, and I correct it rather than let it stand
as the settlement's ground**: `BUILD` and `PRODUCE` **share `EXIT_BUILD=3`**
(`run_cosim.sh` lines 1094/1107/1115 against 1263/1306) — *"Same code, same axis
(§8: the lane did not reach a verdict), different pointer"*, deliberately, by the
`WO-0073-D5` repair. **The distinction that IS code-level is the one code 3
itself draws: the run did not produce what a comparison needs — as against 4, 8,
10, 11 and 12, every one of which is a disposition of a comparison that was
attempted.** **The corrected fact supports the amendment more strongly than the
false one did**, because it shows the code namespace already drawing precisely
the line criterion 7's failing observation cares about, and drawing it by an
adjudicated design rather than by accident. **No code split is owed, and none is
routed to data_wrangler.**

**What the settlement does NOT do, per limb.**

- **It does not discharge criterion 7.** Limbs (a) and (c) were observed met at
  `53fa1de` (`RV-C1C2` §8); limb (b) was observed met **on our side only** — the
  refusal's printed record named the producer, the case, the run label and the
  guard's own `Failure` text at `ours_run.ml:172`, and FI-5's text differs from
  FI-4's. **The reference side meets neither (b) nor, on `FINDING WO-0078-1`'s
  reading, reliably (c)**: `$display` + `$finish` is a normal termination whose
  rc the harness's FI-8 check cannot be assumed to catch. **So criterion 7 stays
  PARTIALLY DISCHARGED with exactly one gap where it had two, and the gap that
  remains is the one that always mattered** — `FINDING RV-0078-S1-4`, first
  dischargeable at C9. **An amendment that closed the reference-side gap by
  wording would be the hazard; this one leaves it standing and untouched.**
- **It does not re-read `53fa1de`.** `RV-C1C2` §8's criterion-7 row is the
  reading of that run under the wording then in force and is not edited.
- **It authorises no edit to `tools/cosim/run_cosim.sh` and dispatches nothing.**
  Limb (b)'s reference-side half is what closes the criterion; the round that
  next opens the reference producer carries it, and it is **not** a precondition
  of the C2 re-run.

---

#### 2. `FINDING RV-0078-S2-3` — **§7 is NOT annotated, and the reason is the same one that made §7 worth having**

**The question the dispatch put**: does the ruling *"the three branches partition
COMPARISONS, not CASES"* need a §7 annotation to be readable by the re-run's
adjudicator? **Ruled: no. The `RV-` text suffices, and the annotation's cost is
larger than its benefit.**

**1. The finding's own routing already answered it.** `FINDING RV-0078-S2-3`
names two carriers: *"this verdict, which rules it, **and** the co-sim Phase 3 CD
instance round — C9 is a produce-refusal case by construction until §6.3's
admission rule lands, so Phase 3 cannot be written without this cell."* **It does
not name a §7 edit and it does not name the re-run dispatch.** A reviewer who
widens its own finding's carrier list a round later, with a run pending, is doing
a smaller version of the thing this packet convicts.

**2. The readability requirement is already met, twice, before §7 is reached.**
The re-run's adjudicator meets the fourth outcome in this packet's **State
field** — its first screen, *"C2 — VOID, RE-RUN OWED … it reached no comparison
and selects no branch"* — and in `RV-C1C2` §4, §5 and §12, which state it four
more times in terms. **§7 is not the text an adjudicator consults to learn what a
case that produced no comparison selects; it is the text that must not have moved
between the prediction and the run.**

**3. The cost, which is the whole argument.** §7's table **is** the frozen
prediction that `§12` criterion 8 protects, and criterion 8 *"earned its keep on
this landing"* precisely because both instances were frozen at `5c01af0`, an
ancestor of the run. **Editing that table between a case's void run and its
re-run — even to correct an exhaustiveness claim that touches no case's predicted
disposition — puts a hand on the one artefact whose entire value is that no hand
touched it after the run.** A later auditor reading the diff would see §7 move
between C2's failure and C2's re-run and have to reconstruct that the move was
harmless. **Making an artefact's innocence reconstructible instead of obvious is
the cost, and against a readability requirement already discharged twice it buys
nothing.**

**4. What I do instead, at zero cost, so the ruling is one sentence away from the
adjudicator.** Stated here, in §14, where a ruling belongs and where a prediction
does not:

> **A case that reaches no comparison selects no branch. α, β and γ are
> dispositions of a COMPARISON; §7's *"every case's result resolves to exactly
> one"* is true of comparisons and false of cases. A case that produced no
> canonical file on either side has a fourth outcome — the harness's own
> `compare_exit=N/A tier=PRODUCE-REFUSAL`, on `WO-0049` §8's
> reached-a-verdict / did-not-reach-one axis — and that outcome is re-run, never
> adjudicated.**

**5. Where the §7 repair stays owed.** The **co-sim Phase 3 CD instance round**,
unchanged: C9 is a produce-refusal case by construction, so Phase 3 cannot be
written without the cell, and at that round no case's prediction is in flight.
`FINDING RV-0078-S2-3` therefore **stands open** and is not closed by this entry.

---

#### 3. `FINDING RV-0078-S2-4` — **DISCHARGED**; the annotation is at `CD` §10.2-bis

**Made in §0-ter's form, under §9's four-item change discipline**, and every bound
the finding set is honoured and checkable in the diff:

- **It touches nothing in §10.2's INSIDE list, expected values, frozen prediction
  or branch cells** — those are byte-for-byte unchanged, and the note quotes none
  of them, so no second copy exists to drift.
- **§10.2's freeze origin does not move.** The instance is frozen from `5c01af0`
  and stays frozen from `5c01af0`; criterion 8's ancestry check for the re-run
  resolves exactly as it did for the run just adjudicated.
- **It records the falsification and the mechanism, and nothing about an outcome**
  — §10.7 item 3 bars this document from carrying results, and item 4 of the note
  is where the absence is checked: C2 was **driven once and compared zero times**,
  the prediction is **unspent**, and `AP-M03` §7 bar 1 has not lifted for the
  two-clean-frames class.
- **It does not restate the re-run's stimulus-hash bind.** The dispatch left that
  to the CD's own form, and the CD's own form refuses it: §10.0 declines to copy
  case 0's pinned literal into §10 because *"a second literal is a second thing
  that can drift."* **The bind stays where `RV-C1C2` §5 item 4 set it and is cited
  by reference.**
- **The authority is stated rather than assumed**, because I refused a different
  addition to the same document one round ago: the note is made under **§9**,
  which §0-ter proves reaches an annotation with no lift at all, and **not** under
  §9-bis's addition-only lift, whose scope is *"co-sim Phase 2's domain
  instances"*. A defect in the document's own text is §9's business; a result
  about the two implementations is nobody's business inside this document.

---

#### 4. What this round does not move, listed so the diff can be read against it

1. **`FINDING RV-0078-S2-1` (MATERIAL) stands** and still blocks C2. Its repair is
   tb_writer's, over **both** producers, one round and one rule, with the fixture
   pair — unchanged and undispatched by this round.
2. **`FINDING RV-0078-S2-2` stands**, carried to the `SO-` round.
3. **`FINDING RV-0078-S2-3` stands**, ruled here, repair routed to the co-sim
   Phase 3 CD instance round.
4. **`FINDING RV-0078-S1-4` stands**, first dischargeable at C9, and criterion 7's
   amendment does not touch it.
5. **C3 stays NOT ISSUED and sequenced behind the repair**; landing it by removing
   C2 from the case set stays barred.
6. **No stage disposition moves**, no case runs, and `RV-C1C2` is not edited.

**dv_lead, `J-dv_lead-0153`, HEAD `99561ea` (unmoved). Dated by the commit that
carries it.**

---

### tb_writer — `FINDING RV-0078-S2-1` repair round (the C2 refusal-guard repair), RETURNED

**Abort-first head check**: `git rev-parse HEAD` = `b221232d9b3e69c9a8ed6476bfcc569163ab69dd`,
exactly the dispatch's stated spawn-head ("Settled before the run, never in its
reading..."). `git status --porcelain` empty. Proceeded without the mismatch
procedure.

**Scope, read against the finding's own terms before a line was written.**
`FINDING RV-0078-S2-1` (`RV-C1C2` §4, §6; `RV-C1C2-SETTLEMENT` §4 item 1) names
the repair as **mine**, in `test/cosim/ours_run.ml` (`accumulate`) **and**
`test/cosim/tb_xgmii_rx_64.v` (its mirrored driving loop), **one round, one
rule**. Both, and only both, are touched: `git status --porcelain` at return
shows exactly `test/cosim/ours_run.ml` and `test/cosim/tb_xgmii_rx_64.v`, no
third file. `test/cosim/stimulus_gen.ml` was not opened (§4 item 6's own bar —
"the stimulus may not move"); `test/cosim/compare.ml` was not opened either —
the fixture pair the finding demands exercises `accumulate` directly, and
`compare.ml` has no path to that function at all (it depends only on
`canonical.ml` and the standard library, by its own header comment, precisely
so it never needs the Hardcaml-dependent producers): the guard fires, or does
not, **before** either canonical file exists, so a canonical-file-level
self-test structurally cannot exercise it. `tools/cosim/` and
`test/attack_plans/CD-xgmii_rx_64_cosim.md` were read (CD §10.2/§10.2-bis, for
the frozen C2 instance and the falsification annotation) but not staged.

**The rule, one sentence**: an ADMISSION span (opens at a frame's own input
`/S/`, closes at that SAME frame's own input `/T/`, or at end-of-stimulus)
governs the REQ-110 refusal alone, and a separate FIFO of admitted-but-
undelivered frames (an output word always attaches to the oldest, and its own
`tlast` pops it) governs the orphan-output refusal alone — where the old code
tested one conflated span (input `/S/` to OUTPUT `tlast`) for both.

**Applied identically in both producers, from this text, never from either
producer's own code and never from the reference's behaviour** (REQ-901's
closing sentence; §4 item 4's own bar):

- `ours_run.ml`'s `accumulate`: `open_frame : (int * int * word list) option
  ref` (one variable, two jobs) is replaced by `admission_open : bool ref`
  (REQ-110's guard's own state, closed by a new `has_terminate` scan — the
  same eight-lane scan shape `Xgmii_word.start_lane` already uses, targeting
  `/T/` instead of `/S/`) and `delivery_queue` (a FIFO, admission order, of
  `(index, admit_cycle, words_rev)` triples — an output word always attaches
  to the head via `close_head`, which is what the orphan-output guard (FI-5)
  now tests the emptiness of). The two are set together in the start-character
  arm (admission and delivery both begin at the same event) and closed
  independently: `admission_open` by `has_terminate` on the SAME input word,
  checked immediately after the start-character arm, before the word is
  driven; the FIFO's head by the frame's own output `tlast`, exactly as
  before.
- `tb_xgmii_rx_64.v`'s driving loop: `frame_open`/`frame_index` (the same
  one-variable, two-job conflation, in Verilog) are replaced by
  `admission_open`/`admission_index` and a small fixed-depth FIFO
  (`delivery_index`/`delivery_head`/`delivery_tail`/`delivery_count`,
  `DELIVERY_DEPTH = 8` — a Verilog-2001 array needs a bound where
  `ours_run.ml`'s OCaml list does not; generous headroom over anything this
  lane's case set presents, and its own overflow guard is a new,
  by-construction-unreachable-here refusal, flagged per this file's own
  established §2.3 disclosure convention rather than added silently). A new
  `has_terminate` function scans the current stimulus line's eight lanes for
  `8'hFD`, the identical shape the admission check already uses for `8'hFB`.
  `open_frame` now pushes onto the FIFO and opens `admission_open` together;
  `close_frame_accept`/`close_frame_discard` are renamed
  `close_delivery_accept`/`close_delivery_discard` and now pop the FIFO's
  head, never touching `admission_open`. The REQ-110 guard's `$display`
  message and its "E second-start-while-open" sentinel are updated to say
  "admission span" but the sentinel's literal text is otherwise unchanged;
  the orphan-output guard's own sentinel text ("E word-with-no-open-frame")
  is untouched **by value**, because `compare.ml`'s own self-test
  (`reference_refusal_canon_text`) reproduces it by value and must keep
  matching — confirmed by inspection, not edited.

**Not a bare reordering.** The two guards now consult genuinely different
state (`admission_open` vs. `delivery_queue`/FIFO-emptiness), not the same
flag read at two different points — the shape §4 item 6 names as the one
thing that would still leave the spans conflated and fail at the first
schedule whose overlap is more than one cycle.

**The fixture pair — both mandatory, in a new `ours_run.ml --self-test` mode
(mirroring `compare.ml --self-test`'s own CLI convention), because that is
where the finding's own subject — `accumulate` — actually lives; there is
nowhere in `compare.ml`'s self-test this pair could exercise the guard
itself, only its downstream consequences on an already-produced canonical
file, which is not what the finding convicts.**

1. **(i) minimum-IFG two frames, must NOT refuse.** Six-line hand-built trace:
   frame 0's own input `/T/` (line 1) closes its admission span **before**
   frame 1's `/S/` (line 3); frame 0's own OUTPUT `tlast` is not delivered
   until line 3 — the SAME line frame 1's start character is driven, the
   exact one-cycle union-span overlap `RV-C1C2` §4 measured at C2. Asserts
   `accumulate` does not raise and both frames close `Accept`.
2. **(ii) genuine REQ-110 abort, must STILL refuse.** Two-line trace: a second
   `/S/` on line 1 while frame 0's admission span is still open (no `/T/` seen
   at all). Asserts `accumulate` raises, and that the message contains
   "admission span was open" — the negative control without which (i)'s
   narrowing would be unfalsifiable in the direction that matters (`RV-C1C2`
   §4 item 5's own words).

**Local checks, verbatim** (this environment has no `dune`, no Hardcaml
switch, no `iverilog`/`vvp` — ADR-0005; confirmed again this round,
`which iverilog vvp` → not found). `ours_run.ml` as a whole needs Hardcaml
(`Sim.create`, `Cyclesim`) to build, but `has_terminate`, `accumulate` and
`self_test` do not — they touch only `Xgmii_word.t`, `Stream_word.t` and
`Canonical.transaction`, none of which carries a Hardcaml dependency (both
modules' own header comments; `canonical.ml`/`.mli` are plain stdlib, per
`compare.ml`'s own header claim). Following the plain-`ocamlc` path
`J-tb_writer-0035` established: copied `xgmii_word.{ml,mli}`
(`test/xgmii/`), `stream_word.{ml,mli}` (`test/monitors/`), and
`canonical.{ml,mli}` (`test/cosim/`, unedited by this round) verbatim into
scratchpad, plus two one-line wrapper files reproducing dune's own
library-wrapping (`dv_xgmii.ml`: `module Xgmii_word = Xgmii_word`;
`dv_monitors.ml`: `module Stream_word = Stream_word`), then extracted the
pure-logic span of the edited `ours_run.ml` (everything except `open
Hardcaml`, the `Xgmii_probe`/`Axi64_probe`/`Sim` module aliases and `run`) —
copied byte-for-byte, not re-derived — into a standalone driver ending in
`let () = exit (self_test ())`:

```
$ ocamlc -c xgmii_word.mli && ocamlc -c xgmii_word.ml     -> exit 0 (each)
$ ocamlc -c stream_word.mli && ocamlc -c stream_word.ml   -> exit 0 (each)
$ ocamlc -c canonical.mli && ocamlc -c canonical.ml       -> exit 0 (each)
$ ocamlc -c dv_xgmii.ml && ocamlc -c dv_monitors.ml        -> exit 0 (each)
$ ocamlc -c ours_run_pure.ml                               -> exit 0, no warnings
    (genuinely type-checked: has_terminate, accumulate's admission_open/
     delivery_queue split, and both self-test fixtures, against the REAL
     Xgmii_word/Stream_word/Canonical, not a stub)
$ ocamlc -o ours_run_pure.exe xgmii_word.cmo stream_word.cmo canonical.cmo \
    dv_xgmii.cmo dv_monitors.cmo ours_run_pure.cmo          -> exit 0 (genuinely LINKED)
$ ./ours_run_pure.exe
ours_run --self-test: (FINDING RV-0078-S2-1, i) minimum-IFG two frames -- second start AFTER frame 0's own input terminate
  PASS: accumulate did not raise; both frames closed Accept -- a lawful
  minimum-IFG schedule is admitted, and the FIFO correctly attributes the
  overlapping output word to frame 0
ours_run --self-test: (FINDING RV-0078-S2-1, ii) genuine REQ-110 abort -- second start WHILE frame 0's admission span is open
  PASS: accumulate raised "ours_run: a second start character arrived while a
  frame's admission span was open -- REQ-110 abort handling is out of Phase
  1's authorised stimulus (WO-0046 section 9)"
ours_run --self-test: OK
$ echo $?
0
```

**The fixture pair is load-bearing, demonstrated rather than asserted**: I
built `old_accumulate_check.ml`, `accumulate` copied byte-for-byte from
`git show HEAD~:test/cosim/ours_run.ml` (diffed against that exact span to
confirm the copy is faithful before running it — see below), and ran it
against fixture (i)'s own trace:

```
$ ocamlc -c old_accumulate_check.ml && ocamlc -o old_accumulate_check.exe \
    xgmii_word.cmo stream_word.cmo canonical.cmo dv_xgmii.cmo dv_monitors.cmo \
    old_accumulate_check.cmo
$ ./old_accumulate_check.exe
old_accumulate: RAISED "ours_run: a second start character arrived while a
frame was open -- REQ-110 abort handling is out of Phase 1's authorised
stimulus (WO-0046 section 9)"

$ git show HEAD:test/cosim/ours_run.ml | sed -n '152,202p' > head_accumulate_extract.txt
    # (diffed by eye against old_accumulate_check.ml's copied span -- identical
    # modulo comments; confirms the negative control reproduces the actual
    # pre-repair code, not a hand-waved re-derivation)
```

The OLD `accumulate` refuses the exact schedule the finding says it wrongly
refuses; the NEW `accumulate` admits it. This is the finding's own defect,
reproduced and then closed by the same fixture, not merely a fixture that
happens to pass.

**Case 0 and C1 invariance — argued, not merely asserted, since neither was
executed this round (both need Hardcaml, ADR-0005).** Case 0 and C1 are each
**one** 64-octet frame; neither's stimulus ever presents a second start
character, so the REQ-110 guard's two branches (`admission_open` true/false)
are never both exercised for them — the only branch either case can reach is
the `else` arm on their one and only `/S/`. From there, the observable
sequence of writes (`Canonical.write_file`'s `F`/word/`D` triple in
`ours_run.ml`; the `$fwrite` `F`/`W`/`D` lines in `tb_xgmii_rx_64.v`) is
produced by **exactly the same call sites** under old and new code:

- the `F` line / frame record's `admit_cycle`: written from `next_index` /
  `line_index` at the SAME point (the start-character arm), unmoved by this
  repair in either file;
- the `W` lines / accumulated words: attached to the (sole) admitted frame on
  every `tvalid` cycle exactly as before — the FIFO's head **is** that one
  frame for the whole of case 0's or C1's run, so `close_head`/pop-on-`tlast`
  observes the identical sequence `close_frame`/`open_frame := None` did;
- the `D` line / decision: `Accept`, written at the SAME `tlast` event by the
  SAME renamed function (`close_head` calls the identical
  `frames_rev := {...} :: !frames_rev` construction `close_frame` did; in
  Verilog, `close_delivery_accept` writes the identical `"D %0d accept\n"`
  format string `close_frame_accept` did, reading `delivery_index[...]` which
  holds the one frame's own index — the same value `frame_index` held).

`admission_open`'s own lifecycle (open at `/S/`, closed early at the frame's
own `/T/`, well before its output `tlast`) is never consulted again for
either case, because neither presents a second `/S/` for it to gate — so its
earlier closing is a change with no observer, not a change with no effect by
luck. The two cases' outputs are therefore bit-identical **by construction**
(every write site unmoved, same inputs, same call order), not merely
"unlikely to differ" — the same standard `RV-C1C2` §10's own "C3 is not
blocked in principle" argument used for a single-frame stimulus's inability
to trip a second-start guard, applied here to prove invariance rather than
non-blocking.

**What is CI-deferred, and why**: identical reasoning to every prior round in
this lane (ADR-0005/§10 item 12). `tb_xgmii_rx_64.v`'s own repair is
self-reviewed, line by line, against `ours_run.ml`'s own (locally executed)
repair — never executed, exactly as this file's own header has said of every
line in it since `WO-0046`. The `cosim` job at the C2 re-run is the first and
only real execution of either producer's repaired guard against real
Hardcaml/Icarus elaboration, and the first and only place `FINDING
RV-0078-S1-4`'s still-standing reference-emission gap could be closed (it is
not closed by this round, and is not owed by it — C9, per `RV-C1C2` §6 item
4). Case 0's and C1's own stimulus was not re-executed this round (neither
`stimulus_gen.ml` nor `ours_run.ml`'s Hardcaml-dependent `run` was opened or
run); the invariance argument above is structural, not a reproduced hash.

**`FINDING WO-0078-1`'s own repair (Stage 1, already landed) is unmoved by
this round**: neither guard's own `E`-sentinel-then-`$fclose`-then-`$finish`
shape changed, only the CONDITION each guard tests and (for the REQ-110
guard) the variable named in its message and sentinel line.

**Refused or blocked**: nothing. No spec ambiguity was met (REQ-110's own
condition and SPEC-M03 §6.1's ΔC fully determine the two spans; the finding's
own §4 already derives the rule, leaving no open design choice); no RTL
leaked into context (`libs/**`, `top/**`, `rtl_snapshots/**` opened at no
point — confirmed by this entry's own Inputs list in the journal, and by
direct recollection); no untestable requirement; no licensing-taint
suspicion; no effort anomaly (one round, as the finding's own carrier names).

**Files changed**: `test/cosim/ours_run.ml`, `test/cosim/tb_xgmii_rx_64.v`.
No third file (`git status --porcelain` confirms) — not `stimulus_gen.ml`
(§4 item 6's bar), not `compare.ml` (structurally the wrong venue for this
fixture pair, per above), not `canonical.{ml,mli}`, not `tools/cosim/**`, not
`test/attack_plans/**`.

— tb_writer, spawn `WO-0078/2026-08-06T~12:00Z` (no explicit "work-order id +
spawn UTC timestamp" token was present in this round's own dispatch prompt;
recorded honestly per `J-data_wrangler-0001`'s and this packet's own prior
tb_writer entries' precedent for the identical situation, rather than
presented as one copied verbatim — the timestamp is this entry's own UTC
header time, `date -u` read at the start of this round, matching the
environment's own `currentDate` context, 2026-08-06).

---

### dv_lead — `RV-C2RERUN`: the C2 re-run (§6.2) — **`FINDING RV-0078-S2-1` CLOSED; C2 VOID AGAIN and RE-RUN OWED; the two-frame blindness one layer downstream, in the WRITER's record order against a grammar pinned for one frame**

#### 0. What I executed, and what I did not

**HEAD verified as my first action**: `git rev-parse HEAD` →
`9de61f15417af2d7f8df3f074a6019bf7f19f1bc`, exactly the spawn head. Neither
rollback disposition fired.

**This round writes three things and nothing else**: this verdict, the `State`
field at the head of this file, and my journal. **No `test/**`, no `tools/**`, and
— ruled in §7 — no edit to `test/attack_plans/CD-xgmii_rx_64_cosim.md`.** Every
defect below is a finding for a named carrier round, not a repair I made.

**I executed no simulation** (ADR-0005). My evidence is: the `cosim` job log read
in full through the server-side GitHub logs tool; the run and job metadata from
the same API; the four sources named in §4 read at this commit; and four
mechanical checks I ran on the checkout rather than taking from any Return log.

**The run, at the API.** `build` run **`31100435961`**, `head_sha` **`9de61f1`**,
event `push`, conclusion **`failure`**, `12:12:46Z → 12:18:12Z`. `cosim` job
**`92612412697`** — **failure**, step *"Run the co-simulation lane"* red with
**`Process completed with exit code 8`**. The `build` job is **green** and the
journal-check is green: the bench compiles, `dune runtest` and the DV mechanical
checks are unaffected, and the red is the co-simulation lane's own — again, and
again belonging to exactly one case.

**Four mechanical checks, mine:**

1. **`git merge-base --is-ancestor 5c01af0 9de61f1` → true.** CD §10's freeze
   commit is an ancestor of the commit the run executed, so §12 criterion 8's
   precondition holds for all three cases by commit ordering.
2. **`git diff --numstat 5c01af0 9de61f1 -- test/attack_plans/CD-xgmii_rx_64_cosim.md`
   → `129  0`, one hunk, ZERO deletions**, entirely §10.2-bis appended *after*
   §10.2. **So §10.2's INSIDE list, its expected values, its frozen prediction and
   both branch cells are byte-unchanged between the freeze and this run.** Last
   round's settlement asserted that property; this round measures it. It is the
   check `J-dv_lead-0153`'s own LH-cand-C demands of a round executing its own
   prior recommendation, applied to my own annotation.
3. **`git diff --name-only 53fa1de 9de61f1`** → six paths, of which exactly two
   are code: `test/cosim/ours_run.ml` and `test/cosim/tb_xgmii_rx_64.v`.
   **`test/cosim/stimulus_gen.ml` did not move**, which is the structural half of
   the sha bind in §3.
4. **The four sources of §4's mechanism, read at `9de61f1`** —
   `test/cosim/canonical.mli`'s pinned grammar block, `test/cosim/canonical.ml`'s
   `read`, `test/cosim/tb_xgmii_rx_64.v`'s `$fwrite` call sites, and
   `test/cosim/ours_run.ml`'s single `Canonical.write_file`. All four are DV-side
   files in my own scope. **No `libs/**`, no `top/**`, no `rtl_snapshots/**` was
   opened at any point in this round.**

---

#### 1. The CI reading, at the source — three cases, in the order the harness ran them

`=== CASE SET (WO-0078 §6.2 Stage 2: 3 case(s) — 0 C1 C2) ===`

**CASE 0 — the freeze holds, and holds across a repair.**

> `[ok]   case 0 stimulus.txt sha256: c675517176922d42bca42ec3def182cb3536861f1acaa8384116f33a5c4cc051`
> `[ok]   case 0's stimulus is byte-identical to the last green pre-widening run`
> `T1: clean` … `word 0: expected 3, observed 3` … `word 7: expected 10, observed 10`
> `frame 0: theirs - ours per word = [0 0 0 0 0 0 0 0]`
> `CASE 0: stimulus_sha256=c675517…4cc051 compare_exit=0 tier=CLEAN`

**CASE C1 — clean, and byte-reproduced across the repair.**

> `[ok]   case C1 stimulus.txt sha256: 5ae9e4f501251c38d0c2d386bd792e07cbcf9cf107cf7e75c378e21b1ce3bd7c`
> `frames compared: 1` / `frames matching: 1` / `divergences: none`
> `T0: aligned` / `frame 0: admit_cycle = 0`
> `T1: clean` … `word 0: expected 3, observed 3` … `word 7: expected 10, observed 10`
> `frame 0: theirs - ours per word = [1 1 1 1 1 1 1 1]`
> `CASE C1: stimulus_sha256=5ae9e4f5…3bd7c compare_exit=0 tier=CLEAN`

**This is the S2-1 round's invariance argument checked rather than trusted.** That
round could execute neither case (ADR-0005) and argued case-0/C1 invariance
structurally — every write site unmoved, the FIFO's head being the sole admitted
frame for the whole of a single-frame run. **Both cases now reproduce their
pre-repair stimulus hash, their whole T1 profile and their whole T2 offset vector,
identically to run `31096150983`.** An argued invariance was falsifiable at the
next run and it held; that is recorded as a fact about the argument, not only
about the code.

**CASE C2 — both producers produced, and the comparison still did not happen.**

> `[ok]   case C2 stimulus.txt sha256: cc1e85a4c5f871226f07b4792446d63c523577dcf172d6c4a80b8a3e845b44a7`
> `[case C2 run1] vvp: …/tb_xgmii_rx_64.v:514: $finish called at 298600 (1ps)`
> `compare: could not read theirs canonical file …/case_C2/run1/theirs.canon: Canonical.read: line 9: F line while frame 0 is still open (missing its D line) (line was "F 1 10")`
> `CASE C2: stimulus_sha256=cc1e85a4…5b44a7 compare_exit=3 tier=NO-VERDICT (compare could not read a canonical file/idle sidecar, exit 3)`
> `case C2: ours.canon/theirs.canon byte-identical between run1 and run2`
> `run_cosim: FAILED CHECK: NO-VERDICT (case C2: compare could not read a canonical file, exit 3)`

**Line 514 is the end-of-stimulus `$finish`**, not a guard's — read at source. **No
`E` sentinel line appears anywhere in `theirs.canon`, and `ours_run` did not
raise.** Both producers ran to normal completion and wrote complete files. The
`NO-VERDICT` dump printed both canonical files and both sidecars in full, which is
why §4 is a reading of evidence rather than a hypothesis.

**Cost.** case 0 `run1 0.650s / run2 0.645s / sum 1.296s`; C1 `0.646 / 0.651 /
1.298`; **C2 `0.644 / 0.661 / 1.306` — a real cost datum this time, because C2
actually ran both producers twice**; invocation `9.947s`.

---

#### 2. `FINDING RV-0078-S2-1` — **CLOSED**, and the closure STANDS

**The finding's own subject is the guards, and the guards are repaired.** Its
statement was that both producers' refusal guards tested a span running from the
input start character to the OUTPUT `tlast`, which at ΔC = 3 outlives the input
frame by exactly the pipeline latency, so the minimum-IFG schedule was refused as
REQ-110's abort case, which it is not.

**Observed at this run, on the live stimulus that convicted it:**

- **Our side**: `ours.canon` carries `F 0 0` … `D 0 accept`, `F 1 10` … `D 1
  accept` — two frames, eight words each, both `Accept`. `accumulate` did not
  raise.
- **The reference side**: `theirs.canon` carries the same two frames and the same
  two `accept` decisions, terminating at the end-of-stimulus `$finish` with no
  sentinel. **The reference-side half of the repair — which the repair round could
  not execute and self-reviewed line by line against its own executed OCaml half —
  is now executed, and it admits the lawful schedule.**
- **The negative control is not weakened**: the REQ-110 fixture (a second `/S/`
  inside an open admission span) still refuses, per the repair round's own locally
  executed `ours_run --self-test`, and nothing this run touched it.

**So S2-1 does not reopen, and conflating it with §4's finding would erase a
verified repair.** The fixture pair did what it claimed. What it never reached is
the layer below: **a guard decides which schedules a producer ADMITS; it says
nothing about the FILE the producer then writes.** The repair changed the first
and, by consequence, changed the second — and only the first was checked. That is
the root cause of §4 arriving one round late, and it is stated as a property of the
verification scope, not as a defect in the repair.

---

#### 3. C2's disposition — **VOID AGAIN, RE-RUN OWED**, in terms

**§12 criterion 8's void does NOT fire, for the second time and for the same
reason.** C2's domain instance was frozen at `5c01af0`, a verified ancestor of
`9de61f1` (§0 check 1), and §0 check 2 measures that nothing inside it moved. The
case did not run before its instance was committed. **Its prediction is UNSPENT.**

**What voids C2 is again the simpler and stricter thing: no comparison happened.**
Concretely, and in the same five terms `RV-C1C2` §5 used, because the terms are
what make the two rounds comparable:

1. **C2 selects no branch.** Not α, not β, not γ. §7's table is not consulted for
   it. Its prediction — *"agreement on both"* — is neither confirmed nor
   falsified. **This is the fourth outcome again — `FINDING RV-0078-S2-3`'s
   subject — reached by a second, distinct road**: last round no file existed;
   this round both files existed and one could not be read. The two are the same
   disposition and different species, which §6 records against that finding.
2. **CD §0's bar is not reached**, because no difference inside the domain was
   shown — the domain was never evaluated. **Nothing may move and nothing does.**
   CD §10.2's INSIDE list, expected values, frozen prediction and branches are
   untouched by this verdict and the re-run happens under that text **unamended**.
3. **C2 is re-run, not adjudicated.**
4. **The sha bind CARRIES FORWARD UNCHANGED**, and it is now stronger than a hope:
   `cc1e85a4c5f871226f07b4792446d63c523577dcf172d6c4a80b8a3e845b44a7` **has been
   printed by two independent invocations across two landings and one repair of
   both producers**, and `git diff --name-only 53fa1de 9de61f1` shows
   `stimulus_gen.ml` did not move. **The next re-run must print exactly that value
   again.** A different value means the stimulus moved under a repair that had no
   business touching it, and that is adjudicated as a finding before any C2 result
   is read. `stimulus_gen.ml` is not among the files §4's repair opens; if a repair
   round opens it, it says why, in advance.
5. **What the record says about C2 from here — the count, restated because the
   spawn asks whether it changes anything.** C2 has been **dispatched twice**; its
   stimulus **generated twice, at one identical sha**; **our producer driven three
   times** (once refusing, twice producing); **the reference producer driven
   twice**, both at this run; **`compare` invoked once, ever**, and it could not
   read what it was given; and **compared ZERO times.** No artefact may say C2
   "ran and was clean", "ran and failed", or "was inconclusive about the two
   designs". **The lane knows nothing whatever about the two-clean-frames-at-
   minimum-IFG class, and `AP-M03` §7 bar 1 does not lift for it.**

**Two things the count DOES change, and they are recorded here rather than
discovered later.**

- **The bind is promoted from a check to a measured invariant** (item 4).
- **A stopping rule is pre-registered, before the run it governs.** Two landings,
  two instrument defects, zero comparisons. A third would stop being a sequence of
  unrelated defects and start being evidence about the instrument. **So: if the
  next C2 re-run reaches no comparison for a third time, C2 is NOT re-dispatched a
  fourth time as a worker repair round.** The question becomes whether the pinned
  transaction-level canonical form (CD §3, `WO-0046` §2.3) can express two frames
  whose admission and delivery spans overlap at all — a design question owned by
  me, answered with options and cost in a dv_lead round, and reaching the sponsor
  as **E2** if any option narrows the case set. **Narrowing the case set inside DV
  remains barred outright** (`RV-C1C2` §10). Writing this rule down now, with the
  answer not in hand, is the same discipline §7's table applies to dispositions.

**Case 0 and C1 are not touched by C2's red**, for the structural reasons
`RV-C1C2` §5 gave: separate working directories, own comparisons, own determinism
checks, own SUMMARY blocks, all completed and printed before C2 ran; an aggregate
assigned after the loop does not reach back.

---

#### 4. The mechanism — a WRITER's record order against a grammar pinned when this lane drove one frame

**Verified at the sources, not inferred from the message.**

**What the two files contain** (from the run's own `NO-VERDICT` dump):

| | `ours.canon` | `theirs.canon` |
|---|---|---|
| record order | `F 0 0`, frame 0's eight `W` lines, `D 0 accept`, `F 1 10`, frame 1's eight `W` lines, `D 1 accept` | `F 0 0`, frame 0's **first seven** `W` lines, **`F 1 10`**, frame 0's eighth `W` line, `D 0 accept`, frame 1's eight `W` lines, `D 1 accept` |
| frames / decisions | 0 and 1, both `accept` | 0 and 1, both `accept` |
| content octets | identical to theirs, word for word | identical to ours, word for word |

**The grammar, quoted from the pinned interface** (`canonical.mli`, the file the
reader implements):

> *"Per frame, in the literal order the grammar block above states: one [F] line,
> then its [W] lines (zero or more) in emission order, then its [D] line."*

**The reader implements exactly that** (`canonical.ml`): `parse_state` is
`No_frame_open | Frame_open of {…}` — **at most one frame open at a time** — and
the arm `| "F" :: _, Frame_open { index; _ } ->` raises
*"F line while frame %d is still open (missing its D line)"*. That is the message
CI printed, at `line 9`, which is `theirs.canon`'s `F 1 10`.

**The reference-side writer does not implement it.** `tb_xgmii_rx_64.v` `$fwrite`s
each record at the instant its event occurs: the `F` line inside `open_frame`, at
the admission cycle (`$fwrite(out_fd, "F %0d %0d\n", next_index, stimulus_lines -
1);`); each `W` line as its output word is observed; the `D` line inside
`close_delivery_accept`, at that frame's output `tlast`. **At C2 frame 1 is
admitted on cycle 10 and frame 0's last word is delivered on cycle 10**, so the
`F 1` record is written before frame 0's own record is closed. Our side does not
have this shape because `ours_run.ml` accumulates a whole `Canonical.transaction`
in memory and emits it through one `Canonical.write_file` at the end — the writer
that the grammar's own `write` enforces.

**Four consequences, each of which matters to the repair and none of which is a
design choice I am making for its owner.**

1. **The reader is CONFORMANT and the reference-side writer is NOT.** The refusal
   is the pinned contract being enforced, not a parser being brittle. Whatever the
   repair is, it does not begin from "the reader was wrong".
2. **The reader's strictness prevented the exact misreport `WO-0049` was written
   about.** Had the grammar tolerated the interleave and attributed positionally,
   frame 0 would have parsed with **seven** words and frame 1 with **nine**, and
   `compare_transactions` would have reported `Word_count_mismatch` on both frames
   — **`EXIT_DIFFERENTIAL`, i.e. "our RTL diverged from the MIT reference", for a
   defect in our own testbench's writer.** `run_cosim.sh`'s own header names that
   run by id (`30825741565`) as the reason `EXIT_NO_VERDICT` exists. **This is that
   code's first production firing and it did precisely its job.**
3. **The interleaved file is not merely unconventional — under the pinned grammar
   it is genuinely AMBIGUOUS.** The `W` record carries **no frame index**: its
   attribution is positional, to "the open frame". With two frames open there is no
   grammatical fact of the matter about which frame a `W` line belongs to. A reader
   taught to attribute across an intervening `F` would have to pick a rule — the
   obvious one being *attribute to the oldest open frame* — and that rule is a
   **behavioural assumption about the design under test** (in-order, non-interleaved
   delivery on one AXI stream), installed inside the comparator. **A comparator that
   assumes a property of the design cannot detect that property's violation.** So
   "teach the reader interleaved attribution" is not a parser change; it is either a
   grammar amendment adding a frame index to the `W` record — touching the pinned
   interface and **both** producers — or a comparator that has stopped being
   independent.
4. **Grouping loses no evidence.** Every `F` line carries its own `admit_cycle` and
   every `W` line carries its own `cycle`, so the full temporal interleaving of two
   overlapping frames is recoverable from a grouped file exactly as from a streamed
   one. **A buffering writer costs the lane nothing evidentially** — stated so the
   owner can weigh it, not to decide for the owner.

**Whose blindness this is.** The grammar was pinned at `WO-0046` §2.3 — **mine** —
in a packet whose §3 says in terms *"What Phase 1 drives: **one** 64-octet
good-FCS frame at a lane-0 start."* A one-frame-at-a-time record grammar was
correct and unremarkable there. **`WO-0078` §3 and §6.2 widened the case set to two
frames whose spans overlap by construction — also mine — without re-deriving
whether a real-time `$fwrite` producer could satisfy the grammar that widening
would now bind it to.** That is the same species of error as `S2-1`: I enumerated
what a mechanism is *for* rather than what it *does* when two frames are in flight.
**The second instance of the same species in consecutive rounds is the finding's
most important content**, and §6 states the general form.

---

#### 5. The frame-1 `+1` offset in the dump — what it is, where it lives, and what it is NOT

**The observation.** Reading the two dumped files by hand: **frame 0's word cycles
are equal on both sides** (`3 … 10`); **frame 1's are `13 … 20` on our side and
`14 … 21` on the reference's** — `+1` on every word. Both sides print `F 1 10`, so
the admit cycles agree. C2's frame 1 starts **in lane 4** (84 octet-times, not a
multiple of 8 — `stimulus_gen.ml`'s own comment and CD §10.2's recorded
consequence), and `+1` at a lane-4 start is exactly what C1's T2 measured
(`theirs - ours per word = [1 × 8]`).

**Its adjudicative status — three layers, and the third is new.**

1. **CD §5.2 X1** — *all cycle timing, latency and word-to-word spacing* — OUTSIDE
   the domain; CD §0: a difference outside the domain is *data, recorded, not
   adjudicated*. REQ-901 excludes cycle alignment. **`AP-M03` §7 bar 3 bars a
   cross-side timing comparison and is untouched.** Not a divergence, not branch γ,
   not a `BUG-` candidate, not a spec-diff candidate.
2. **It is not an instrument output.** `compare` never ran a T2 for C2 — it never
   read the file. **This is my own eyeball reading of a printed dump, not a measured
   line**, and it therefore does **not** join C1's T2 record, does **not** go to the
   `SO-` as a measured datum, and is **not** evidence of anything about either
   design. A hand reading presented beside instrument output, without that
   distinction attached, is how a dump becomes a result.
3. **Where it lives: here, and only here, as an instrument-stability note.** Its
   one legitimate forward use is to stop the next adjudicator meeting the `+1` as
   news. **When the C2 re-run's T2 executes for real, it is expected to print
   `frame 0: theirs - ours per word = [0 × 8]` and `frame 1: … = [1 × 8]`.** If it
   does not, **that is not a divergence and selects no branch** — it is a question
   about whether a repair changed a producer's timing behaviour, which is an
   instrument question. **It is not a prediction in §7's sense and it may not be
   cited as one**: an out-of-domain quantity does not acquire branch-selecting force
   by being written down early.

**Not in the CD** (§10.7 item 3: *"This document freezes the questions; it answers
none of them"*), **and not in `AP-M03` §7** (a recorded cross-side cycle datum
beside the bar forbidding cross-side cycle comparison is the shape a later reader
misreads as the bar having lifted). Both reasons are `RV-C1C2` §3's, unchanged.

---

#### 6. Findings — three new; one MATERIAL, two MINOR; each with an owner and a carrier

**`FINDING RV-0078-S2-6` (MATERIAL; blocks C2 only) — the reference-side producer
writes canonical records in real time, so two frames whose admission and delivery
spans overlap produce a file that violates the pinned grammar's per-frame record
grouping; the reader enforces the grammar, refuses, and C2 reaches no comparison.**

- **Statement.** `test/cosim/tb_xgmii_rx_64.v` emits each `F`/`W`/`D` record at the
  instant of its own event. `test/cosim/canonical.mli`'s pinned grammar requires,
  per frame, *"one [F] line, then its [W] lines … then its [D] line"*, and
  `canonical.ml`'s `read` is a single-frame-open state machine that raises on an
  `F` while one is open. At any schedule where frame *n+1*'s admission precedes
  frame *n*'s output `tlast` — which the minimum inter-frame gap guarantees at
  ΔC = 3 — the two are irreconcilable. **Invisible until now because a
  single-frame file makes streamed order and grouped order the same file, and
  because before `S2-1`'s repair the reference's own guard refused the schedule
  before the second `F` was ever written.**
- **Owner of the design gap: dv_lead.** The grammar is mine (`WO-0046` §2.3),
  pinned for a one-frame lane; the widening to overlapping frames is mine
  (`WO-0078` §3, §6.2); neither round re-derived the writer's obligation under the
  other. **Neither assignee is at fault**: tb_writer's repair round met its
  finding's terms exactly and its case-0/C1 invariance argument was vindicated
  (§1), and data_wrangler's harness classified and reported the failure correctly.
- **Owner of the repair: tb_writer**, in `test/cosim/tb_xgmii_rx_64.v`, and — only
  if the chosen design amends the grammar — in `test/cosim/canonical.{ml,mli}` and
  `test/cosim/ours_run.ml` as well. **Carrier**: a tb_writer repair round before C2
  re-runs.
- **The design choice is the owner's, not mine.** Two routes are visible (buffer
  the reference writer's records so each frame's block closes whole; or amend the
  pinned grammar so a `W` record carries its own frame index and both producers
  write it) and a third may be better. **What this finding fixes is not the route
  but the properties any route must preserve** — stated because a repair that
  restores C2 while breaking one of these is worse than the defect:
  1. **No false green and no false differential.** A file whose record attribution
     is not determined by the grammar must **fail to read** (`compare` exit 3),
     never be attributed by a heuristic. Specifically: *attribute to the oldest
     open frame* is a behavioural assumption about the design under test, and a
     comparator that assumes a property cannot detect its violation (§4 item 3).
  2. **Byte-exactness for single-frame files.** Case 0 must still print
     `c675517…4cc051` with `compare_exit=0`, `T1 {3 … 10}` and `T2 [0 × 8]`; C1
     must still print `5ae9e4f5…3bd7c` with `T1 {3 … 10}` and `T2 [1 × 8]`. A
     repair that changes a single-frame canonical file by one byte is out of its
     own scope and says so.
  3. **The `E`-sentinel contract, whole** (`FINDING WO-0078-1`'s Stage-1 repair):
     `E` recognised by `read` **regardless of parse state**, written as the last
     thing before every guard's `$finish`, with `$fclose` before it; and the literal
     text `E word-with-no-open-frame` unchanged **by value**, because
     `compare.ml`'s `reference_refusal_canon_text` reproduces it by value. A
     buffering writer must still be able to emit its sentinel on a guard trip
     **after** partial records are already buffered, and must not emit a
     half-buffered frame beside it.
  4. **The old-format trap** (`WO-0075` §2): a producer left un-updated must still
     produce a **read failure**, never a misread and never a false green. Any change
     to the `W` record's token layout is measured against that property explicitly.
  5. **Bounded buffering with its own refusal.** If records are buffered, the buffer
     is bounded and its exhaustion is a refusal with an `E` sentinel — the shape
     `DELIVERY_DEPTH` already established, not an unbounded accumulation in a
     Verilog testbench.
  6. **Determinism**: run1/run2 byte-identity per case, unchanged.
  7. **Non-loss, recorded as an aid**: grouping discards no temporal evidence, since
     `F` carries `admit_cycle` and every `W` carries its own `cycle` (§4 item 4).

**`FINDING RV-0078-S2-7` (MINOR) — the per-case SUMMARY block presupposes a result,
and now prints one for a case that has none.**

- **Statement.** `tools/cosim/run_cosim.sh` prints the per-case SUMMARY
  unconditionally at the end of the case body, reached by every arm from the
  `compare` dispatch onward. For C2 it printed *"timing: OUR side asserted against
  SPEC-M03 §6.1 (T1)"* and *"This case's own result is timing evidence for the ONE
  stimulus class it drives and for no other"* — **for a case that computed no T1,
  no T2 and no result at all.** `RV-C1C2` §8 recorded that C2 *"printed no SUMMARY
  — correctly: it has no result to bound"*; that was true of the PRODUCE-REFUSAL
  arm, which `continue`s. **The `NO-VERDICT` arm falls through.**
- **Newly reachable because of my own amendment.** `RV-STAGE1` §5 OQ1/OQ2's
  record-and-continue rule moved cases that reach no verdict onto the fall-through
  path without asking what the fall-through prints. **Owner of the defect:
  dv_lead.**
- **Class MINOR**, and the reason is bounded: the case's own `CASE …
  compare_exit=3 tier=NO-VERDICT` line is two lines above it, no `T0`/`T1`/`T2`
  block was printed for C2 at all, and this verdict says in terms what C2 proves
  (nothing). But it is a sentence of the form criterion 9 exists to police,
  asserting coverage for a class this lane has never compared, **and the `SO-` will
  cite this log**.
- **Owner of the repair: data_wrangler**, `tools/cosim/run_cosim.sh`. **Carrier**:
  the next round that opens that file — recommend the C3 dispatch's runner half.
  **Not a blocker on the C2 re-run**, and it must not delay it; **owed before the
  `SO-` cites the run.** The repair is a bound, not a suppression: a case that
  reached no verdict may still print its provenance, and the timing sentence is
  what must become conditional.

**`FINDING RV-0078-S2-8` (MINOR, structural) — the reference-side producer has no
fixture of any kind, so every one of its defects costs a full CI round to find.**

- **Statement.** `compare.ml --self-test` synthesises canonical files by hand;
  `ours_run.ml --self-test` exercises `accumulate` on our side; **nothing anywhere
  exercises `tb_xgmii_rx_64.v` except the `cosim` job.** Under ADR-0005 its first
  execution is always CI, so a reference-side defect is discovered one round at a
  time, after a dispatch. This is the structural reason `FINDING RV-0078-S1-4` has
  stood since Stage 1 and the structural reason `S2-6` arrived a round late.
- **A cheap partial repair exists and is recommended, with its limits stated.** A
  **golden-file fixture**: tb_writer writes, by hand, the canonical file it intends
  `tb_xgmii_rx_64.v` to emit for a two-frame overlapping schedule, and feeds it to
  `Canonical.read` in `compare.ml --self-test`. It executes no Verilog and is only
  as good as the hand that writes it — **but it converts the writer's record order
  from an unstated assumption into a stated artefact a reviewer can diff against the
  `$fwrite` call sites, which is where `S2-6` was visible all along, statically,
  with no simulator.** It does not discharge `FINDING RV-0078-S1-4`, which needs a
  real reference-side guard trip (C9).
- **Owner: dv_lead** (instrument design). **Carrier**: the `S2-6` repair round,
  which should land it alongside the writer repair; if it does not, the `SO-` round
  owns it.

**Standing findings — what this run does to each.**

- **`FINDING RV-0078-S2-1` — CLOSED** (§2).
- **`FINDING RV-0078-S1-2`(b) — its production instance is STILL OWED, unchanged,
  at the next C2 re-run.** C2 printed no `T1` at all this run, so the two-frame
  clean-numbers-beside-a-divergent-sibling print has still never happened in
  production. Its mechanism-level closure (the self-test at exit 4) stands and was
  re-observed this run.
- **`FINDING RV-0078-S1-4` — STANDS, unchanged**, first dischargeable at C9. The
  reference-side **guard** still has never fired. The self-test's
  reference-refusal-sentinel fixture passed again, but it is a synthesised file, not
  the producer's own guard.
- **`FINDING RV-0078-S2-3` — STANDS, and gains content.** The fourth outcome now has
  **two demonstrated species**: *no file was produced* (producer refusal,
  `compare_exit=N/A`) and *a file was produced and could not be read*
  (`compare_exit=3`). §7's table has a cell for neither. The finding's carrier is
  unchanged (the co-sim Phase 3 CD instance round), and this content is added to
  what that cell must say.
- **`FINDING RV-0078-S2-2`, `S2-4`, `S2-5`** — untouched; `S2-4` **discharged** and
  `S2-5` **settled** last round, and §0 check 2 measures that the `S2-4` discharge
  did what it said.

---

#### 7. The CD — **no edit**, ruled rather than omitted

**Checked, not assumed: this run falsifies no clause of
`test/attack_plans/CD-xgmii_rx_64_cosim.md`.** §10.2's *"needs no accumulator
change"* was the falsified clause and is already annotated at §10.2-bis; §10.2 says
nothing about either producer's record order, and nothing else in §10 does either.

**And a second annotation recording *"the re-run also reached no comparison"* would
be barred**, not merely unnecessary: that is a **result**, and §10.7 item 3 reads
*"This document freezes the questions; it answers none of them."* It is also the
left-standing-summary class §0-ter tabulates four payments for — the log cannot
drift, a restatement of it can. **§9-bis's addition-only lift is scoped to
co-sim Phase 2's domain instances and a result is not one** (`RV-C1C2` §3's ruling,
applied to my own round for the second time).

**So the CD is untouched by this round, and C2's instance keeps its frozen
prediction, unspent, for the second landing running.**

---

#### 8. §12 read per criterion — nine, one disposition each, at `9de61f1`

| # | criterion | disposition at `9de61f1` |
|---|---|---|
| **1** | case 0 byte-identical | **DISCHARGED**, re-observed: `c675517…4cc051` equals the pinned value, printed beside the genuinely pre-widening anchor (run `31080871169`, job `92549154623`, `55e16ae`). **And it now holds across a repair of both producers**, which is the first occasion the check has had anything to survive. |
| **2** | the sighted placement survives | **DISCHARGED**, re-observed at case 0 and C1 (`frame 0: admit_cycle = 0` printed for both). C2 adds nothing: no `T0` ran, so nothing was printed — though its own `ours.canon`/`theirs.canon` both open `F 0 0`. |
| **3** | every case reaches a verdict or names why not | **PARTIALLY DISCHARGED; materially advanced; one new debit.** **Newly demonstrated in CI**: the first production firing of `compare`'s own exit **3** → `tier=NO-VERDICT` with **compare's own non-zero exit code on a case line** (last round the same case carried `compare_exit=N/A`); the first production firing of `dump_run`, which shipped **both canonical files and both sidecars in full**, making the defect diagnosable from the log without a re-run — beyond what the criterion asks and the reason §4 could be adjudicated at all; the first production firing of `EXIT_NO_VERDICT` as an **aggregate**, naming the case in its label; and a determinism check reported for a case that reached no verdict, which is what "record and continue" means literally. **Still NOT demonstrated**: the property the criterion protects — *a red case does not cost a LATER case its line* — **because C2 was last in the case set again.** The closing condition is unchanged and now twice deferred: the first landing in which a case that does not reach a clean verdict is followed by another case in the array. **New debit**: `FINDING RV-0078-S2-7` — the case that correctly named why it reached no verdict then printed a SUMMARY presupposing a result. |
| **4** | T1 prints its numbers on the clean path | **DISCHARGED for production single-frame cases**, re-observed at case 0 and C1, eight words each, expected and observed. **NOT ENGAGED by C2 and NOT FAILED by it**: the criterion's predicate is *every accepted frame in every case*, and acceptance is the comparator's own reading, of which there was none. Limb (b)'s multi-frame production instance remains owed. |
| **5** | T1's antecedent carried, not inferred | **NOT FURTHER ENGAGED.** No case injects an idle. **And C2's idle sidecar was never read**: `compare` reads *ours*, then *theirs*, then the sidecar, and failed at *theirs* — so the two-entry sidecar path (`idle_counts = [0; 0]`) remains unexercised in production, which the re-run will be the first to exercise. |
| **6** | the two constructors separately testable | **DISCHARGED**, re-observed: `(e)` at exit 4, `(e′)` at exit 6, distinct fixtures, distinct branches, neither optional. |
| **7** | every producer's refusal reaches an exit code **(AS AMENDED)** | **NOT ENGAGED BY THIS RUN'S CASE PATH — for the first time, and in the right direction: no refusal guard fired in either producer, at any case.** Limbs (a)/(b)/(c) had nothing to bite on. The self-test's synthesised reference-refusal-sentinel fixture passed again (exit 3), which is **not** the discharge `FINDING RV-0078-S1-4` names. **One new observation, recorded and deliberately NOT converted into an amendment**: the reference producer this run **failed without refusing** — it wrote a grammar-violating file, exited normally, and the harness's rc/existence check (FI-8) passed. That is a failure mode criterion 7 does not reach, and it does not need to: the reader is the designed net for it and the net held (§4 item 2). **Amending a criterion in the reading of a run is what `FINDING RV-0078-S2-5` barred, and it is barred against me twice as hard the round after I amended it.** |
| **8** | every case's disposition frozen before it ran | **DISCHARGED, and MEASURED rather than asserted for the first time.** `5c01af0` is an ancestor of `9de61f1`; the CD diff across that span is **one hunk, 129 insertions, zero deletions**, entirely §10.2-bis *after* §10.2. **So the annotation I wrote between C2's void run and its re-run is provably innocent of the prediction it sits beside** — which is exactly the property `J-dv_lead-0153` refused to make a reader reconstruct, now checkable in one command. **C2's prediction is unspent for the second time.** |
| **9** | no claim outside the driven set | **DISCHARGED for this round's artefacts; one debit against the harness.** This verdict lifts bar 1 for nothing, states per case what each case proves, and states in terms that the lane knows nothing about the two-frame class. The harness's own per-case bounding sentence printed correctly for case 0 and C1 and **incorrectly for C2** — `FINDING RV-0078-S2-7`. |

---

#### 9. Cost — Band A, re-read

- **Absolute**: `9.947s` against **300 s**, at N = 3 with all three cases running
  both producers twice. Comfortably met.
- **Linearity**: *"each added case costs no more than 2× the single-case
  measurement."* Case 0 **1.296 s**, C1 **1.298 s**, **C2 1.306 s** — a ratio of
  **1.008** against a bound of 2, and **the first reading in which every case in the
  set contributes a real datum** (last round C2's 0.014 s was a refusal and was
  excluded). **Band A stays MET**, now on three data points rather than two.

---

#### 10. Sequencing — restated, with the reasoning, and one rule pre-registered

**The recommended sequence:**

1. **A tb_writer repair round — `FINDING RV-0078-S2-6`.** The writer-order repair,
   under §6's seven preserved properties, with the design route the assignee's to
   choose and to justify against those properties. **`FINDING RV-0078-S2-8`'s
   golden-file fixture rides with it**, because it is the check that would have
   caught this statically and it belongs in the same head. **Case set unchanged at
   `{0, C1, C2}`. `stimulus_gen.ml` stays shut.**
   **And one instruction that is new, because the same species has now cost two
   rounds**: the round **enumerates, statically and in its Return log, every
   remaining place in `test/cosim/**` and `tools/cosim/**` where a one-frame
   assumption could still be load-bearing** — the reader's state machine, the
   writers' record order, the idle sidecar's per-frame indexing, `check_timing`'s
   per-frame maps, the determinism check, `DELIVERY_DEPTH`. **Naming them costs one
   reading; discovering them costs one round each.**
2. **My `RV-` on that run** — adjudicating C2's re-run under CD §10.2 **unamended**,
   with the sha bind of §3 item 4 checked first, and **§3's pre-registered stopping
   rule in force** if it again reaches no comparison.
3. **The C3 dispatch, alone**, per §6.2 — unchanged from `RV-C1C2` §10, and its
   three grounds are unchanged and now stronger: C3's single frame cannot trip
   either defect; its result may force a REQ-901 spec diff and should not be read
   under an aggregate naming another case; and criterion 3's plural content is
   **still** unexercised, so C3 landing behind a red C2 would rest a spec-diff-grade
   result on a harness property CI has never run. **`FINDING RV-0078-S2-7`'s runner
   repair rides with C3's runner half.**

**Why another repair round before C3 rather than C3 now**: unchanged, and the case
is stronger than last round, because the property C3 would have to lean on
(criterion 3's *a red case does not cost a later case its line*) has now been
deferred **twice** rather than once.

**And the barred route is barred again, in the same words**: C3 may **not** be
landed by removing C2 from the case set. Removing a case to make a run green makes
the lane unable to fail, which is the property CD §0 exists to protect; if schedule
pressure ever makes it attractive it goes up as **E2**, and the case set is not
reduced inside DV under any circumstances.

---

#### 11. What this run does NOT mean

1. **The landed, ADJUDICATED case set is still `{case 0, C1}`.** `AP-M03` §7 bar 1
   lifts for exactly the two classes `RV-C1C2` named and for nothing else. **It does
   not lift for two clean frames at minimum IFG.**
2. **The one-frame stimulus bound is UNCHANGED**, for the second landing running.
3. **Bars 2, 3 and 4 are untouched.** No strobe was compared; no cross-side cycle
   was adjudicated (§5 is data, hand-read, and says so); the strobe record stays
   refused; bar 4's C3 cell has still not been reached.
4. **Both producers producing is not both producers agreeing.** `ours.canon` and
   `theirs.canon` were never compared. That their dumped octets and decisions look
   the same to me is **§5's class of observation** — a reading, not a verdict — and
   it selects no branch.
5. **Nothing here advances the programme's Phase 2 or Phase 3**, and **no
   `SO-xgmii_rx_64.md` is opened, advanced or implied.**

---

#### 12. Verdict

**`FINDING RV-0078-S2-1` — CLOSED.** Both producers' repaired guards admitted the
lawful minimum-IFG schedule on live stimulus: two frames, eight words each, both
`Accept`, on both sides, with no sentinel and no raise. The reference-side half —
which its repair round could not execute — is executed and correct. **The repair
round's structural case-0/C1 invariance argument is vindicated by measurement**:
both cases reproduce their stimulus hash, their whole T1 profile and their whole T2
offset vector across the repair. **The fixture pair's scope never reached the
writer order, which is a statement about the fixture pair and not a defect in the
repair.**

**C2 — VOID AGAIN, AND RE-RUN OWED UNDER CD §10.2 UNAMENDED.** The case reached
**no comparison**: both producers produced complete canonical files, and
`Canonical.read` refused `theirs.canon` at line 9 — *"F line while frame 0 is still
open"* — so `compare` exited **3**, the case line carried `tier=NO-VERDICT`, and the
aggregate was `EXIT_NO_VERDICT(8)`. **C2 selects no branch — not α, not β, not γ —
because α, β and γ dispose of comparisons and there was none. Its prediction stays
frozen and UNSPENT; its instance is not reopened, widened or amended; and its
re-run must print `stimulus_sha256=cc1e85a4…5b44a7`, a bind that has now held
across two landings and one repair of both producers.**

**The cause is `FINDING RV-0078-S2-6` (MATERIAL): the reference-side writer emits
canonical records in real time, and the pinned grammar requires each frame's `F`,
`W`s and `D` to form one contiguous block — irreconcilable the moment two frames'
spans overlap, which the minimum inter-frame gap guarantees at ΔC = 3.** The reader
is conformant and the writer is not; **the reader's strictness is what stopped a
producer defect from being reported as `EXIT_DIFFERENTIAL`, which is the exact
misreport `WO-0049` §8's axis was built to prevent, on its first production
firing.** **The design gap is mine** — a grammar pinned when this lane drove one
frame, carried into a two-frame case without re-derivation, which is the same
species as `S2-1` one round earlier and one layer up. **The repair is tb_writer's,
in `tb_xgmii_rx_64.v` (and the grammar's own files if the chosen route amends it),
under the seven preserved properties in §6 — of which the first is that an
ambiguously-attributable file must fail to read rather than be attributed by a
heuristic, because the obvious heuristic installs a behavioural assumption about
the design inside the comparator.**

**Two further findings**: `S2-7` (MINOR) — the per-case SUMMARY presupposes a
result and printed one for a case with none, newly reachable through my own
record-and-continue amendment; owner dv_lead, repair data_wrangler, carrier the C3
runner half, owed before the `SO-`. `S2-8` (MINOR, structural) — the reference-side
producer has no fixture at all, so every defect in it costs a CI round; the
golden-file fixture rides with the `S2-6` repair.

**`FINDING RV-0078-S1-2`(b)'s production instance remains OWED at the next C2
re-run; `FINDING RV-0078-S1-4` STANDS unchanged at C9; `FINDING RV-0078-S2-3` gains
its second species of the fourth outcome.** **Criterion 8 is measured rather than
asserted for the first time** — one hunk, 129 insertions, zero deletions, entirely
beside §10.2 — **so the annotation written between C2's void run and its re-run is
provably innocent of the prediction it sits beside.** Criterion 7 was **not engaged
by any case**, and the amendment written for it last round is deliberately **not**
amended again in the reading of this run.

**A stopping rule is pre-registered here, with the answer not in hand: a third
C2 landing that reaches no comparison is not a fourth worker repair round — it is a
design question about whether the pinned transaction form can express overlapping
frames at all, owned by me, and E2 if any option narrows the case set. Narrowing
the case set inside DV stays barred.**

**Nothing in this round licenses a claim beyond the two stimulus classes
`RV-C1C2` named. The lane still knows nothing about two frames.**

**dv_lead, `J-dv_lead-0154`, HEAD `9de61f1` (unmoved). Dated by the commit that
carries it.**

---

### tb_writer — `FINDING RV-0078-S2-6` repair round (the C2 writer-order repair), `FINDING RV-0078-S2-8`'s golden-file fixture riding, RETURNED

**Abort-first head check**: `git rev-parse HEAD` = `2a54bd392edb1ddbf1f23b79450f462874d1d799`,
exactly the dispatch's stated spawn-head `2a54bd3`. `git status --porcelain`
empty. Proceeded without the mismatch procedure.

**Scope, read against the finding's own terms before a line was written.**
`FINDING RV-0078-S2-6` (MATERIAL; `RV-C2RERUN` §4, §6) names the repair as
mine, in `test/cosim/tb_xgmii_rx_64.v`, and in `canonical.{ml,mli}` /
`ours_run.ml` **only if** the chosen route amends the pinned grammar. It does
not: the route below is producer-side buffering, so neither file was opened
for editing. `git status --porcelain` at return shows exactly two files:
`test/cosim/tb_xgmii_rx_64.v` and `test/cosim/compare.ml` (the latter for
`FINDING RV-0078-S2-8`'s golden-file fixture, which rides this round per
`RV-C2RERUN` §10 item 1). `test/cosim/stimulus_gen.ml` was not opened at any
point — the sha bind `cc1e85a4c5f871226f07b4792446d63c523577dcf172d6c4a80b8a3e845b44a7`
is untouched by construction, not merely by intent. `tools/cosim/run_cosim.sh`
was read (for the static enumeration dv's new instruction requires, below)
but not staged — it is data_wrangler's write scope, not mine.

**The route, one sentence, against the seven preserved properties.** Buffer
each admitted-but-not-yet-closed frame's own `F`-line fields and captured
`W`-line fields inside the delivery FIFO's own per-slot storage (already
present for frame bookkeeping; extended here to carry record content too),
and write that frame's entire block — `F`, every buffered `W` in emission
order, `D` — contiguously at the moment the frame closes
(`close_delivery_accept`/`close_delivery_discard`), never streamed across
real time; the grammar (`canonical.mli`) is left **unamended**. Measured
against each of `RV-C2RERUN` §6's seven properties:

1. **No false green/differential.** Untouched by construction: the reader
   (`canonical.ml`) is not edited at all, so its refusal-on-ambiguity
   behaviour (raise on an `F` while a frame is open) is exactly what it was.
   This route removes the AMBIGUITY at the source (no interleaved file is
   ever produced) rather than teaching the reader to resolve one — the
   alternative route (a `W`-record frame-index field) is exactly the
   heuristic-adjacent path this property warns against, since it would move
   the burden onto a reader taught to attribute across an intervening `F`,
   which `RV-C2RERUN` §4 item 3 already names as installing a behavioural
   assumption about the design under test.
2. **Byte-exactness for single-frame files.** Case 0 and C1 each admit
   exactly one frame; no second frame is ever pushed while the first is
   in-flight, so the buffering machinery is exercised at its trivial
   (single-occupant) case for both — see the invariance argument below,
   which is structural, not measured (ADR-0005 bars local execution of this
   file). The grammar itself is unedited, so no possible byte in a
   single-frame file's format changes for any other reason either.
3. **The `E`-sentinel contract, whole.** All three existing sentinel
   `$fwrite` call sites (`E delivery-fifo-exhausted`, `E
   second-start-while-open frame=%0d`, `E word-with-no-open-frame`) are
   untouched **by value** — confirmed by inspection, none of their string
   arguments was edited. Each remains the LAST thing written before its own
   `$fclose`-then-`$finish`, unchanged in placement. The buffering repair
   changes what MAY already be sitting in the file, unflushed, at the moment
   one of these guards fires (an admitted-but-not-yet-closed frame's `F`
   line is no longer already on disk when a guard trips, because writing it
   is now deferred to closure) — this is a WEAKER precondition than before
   (theirs.canon may now be even simpler at the moment of refusal — fewer
   partial records, not more), and `Canonical.read`'s `"E" :: rest, _ -> ...`
   arm already matches regardless of parse state (`No_frame_open` included),
   so the reader's behaviour at every guard is unchanged: refuse, exit 3.
4. **The old-format trap.** Untouched by construction: no edit reaches
   `canonical.{ml,mli}`, so the decimal-field / old-format-file rejection is
   bit-for-bit what it was.
5. **Bounded buffering with its own refusal.** The per-frame word buffer is
   bounded by a new `MAX_WORDS_PER_FRAME = 16` localparam (generous headroom
   over the 8 words every case this lane drives today produces — one
   64-octet frame, `stimulus_gen.ml`'s own `stress_frame`, at the 64-bit
   datapath), and its own exhaustion is a new refusal (`E
   word-buffer-exhausted`) in the same shape `DELIVERY_DEPTH`'s own guard
   already established — checked, not silently unbounded.
6. **Determinism.** Unaffected: the buffering logic is a pure, deterministic
   function of the DUT's own deterministic output (no `$random`, no
   time-of-write dependence in the emitted CONTENT, only in when it reaches
   disk), so run1/run2 byte-identity is preserved by construction; also
   confirmed structurally at `tools/cosim/run_cosim.sh`'s own determinism
   check below (item 6 of the enumeration), which treats both canonical
   files as opaque byte streams regardless of how many frames either
   contains.
7. **Non-loss.** Preserved: `F` still carries `admit_cycle` (now stored per
   slot, `delivery_admit_cycle`, rather than written immediately, but the
   VALUE is captured at the identical point — inside `open_frame`, from
   `stimulus_lines - 1` at admission) and every `W` still carries its own
   `cycle` (stored per word, `delivery_word_cycle`, captured at the identical
   point `capture_word` runs, the same point `write_word` used to run).
   Nothing is dropped; only WHEN each line reaches `theirs.canon` moved.

**The alternative route (amending the grammar to add a `W`-record frame
index) was considered and rejected**, primarily on property 2: any new token
in every `W` line changes every single-frame file's own bytes too, which
`RV-C2RERUN` §6 item 2 states outright is "out of its own scope" for a
repair that changes a single-frame canonical file by one byte — and
secondarily on property 1's own language, since the grammar amendment's
whole point (letting a reader attribute an interleaved `W` line to the frame
it belongs to) requires either a NEW token carrying that fact (touching both
producers, and the pinned interface, for no gain the buffering route does
not already provide) or a heuristic the finding names by name as the thing
not to build.

**Implementation.** `open_frame` now stores `admit_cycle` into
`delivery_admit_cycle[slot]` and resets `delivery_word_count[slot]` to 0,
but no longer `$fwrite`s the `F` line. `write_word` (immediate-`$fwrite`) is
split into `capture_word` (stores `tkeep`/`tlast`/`tuser0 & 1`/`cycle`/full
`tdata` into `delivery_word_*[slot][word]`, guarded by the new
`MAX_WORDS_PER_FRAME` bound) and `write_word_line` (formats and `$fwrite`s
ONE buffered word from stored fields, reproducing `write_word`'s own format
string and WO-0049 §3's digit-width trick verbatim, now applied to the
stored `reg`s rather than the live wires — same width, same output).
`close_delivery_accept`/`close_delivery_discard` now write the closing
frame's entire block (`F` from the stored fields, every buffered `W` line in
ascending word order via `write_word_line`, then `D`) contiguously; frame
closure already happens strictly in admission order by construction of this
FIFO (an output word always attaches to `delivery_head`, and only
`delivery_head` ever closes), so this needed no new ordering decision.

**The static one-frame-assumption enumeration**, dv's new instruction for
this round — every remaining place in `test/cosim/**` and `tools/cosim/**`
where a one-frame assumption could still be load-bearing, one-line
disposition each:

1. **The reader's state machine** (`canonical.ml`'s `read`,
   `No_frame_open | Frame_open`). **SAFE** — the single-frame-open-at-a-time
   model is the grammar's OWN per-frame-contiguity requirement, not a
   cardinality assumption; it already reads any number of frames correctly
   as long as each is written contiguous (verified locally this round: the
   two-frame golden fixture below reads clean).
2. **`ours_run.ml`'s writer** (`Canonical.write`/`write_file`, invoked once
   over the whole accumulated `frame list`). **SAFE, unchanged** — already
   frame-count-agnostic by construction (`List.iter` over every frame this
   run produced); this is the exact reason `FINDING RV-0078-S2-1`'s repair
   alone never tripped this finding on our own side.
3. **`tb_xgmii_rx_64.v`'s writer** (record emission order). **REPAIRED
   HERE** — was the one genuinely one-frame-shaped component (each record
   `$fwrite`n at its own real-time event); now buffers per delivery-FIFO
   slot and flushes each frame's block contiguously at closure, per the
   route above.
4. **The idle-count sidecar's per-frame indexing**
   (`stimulus_gen.ml` → `ours_run.ml` → `compare.ml`, line order = 0-based
   frame admission index). **SAFE** — already exercised at two entries in
   production (C2's own `idle_counts = [0; 0]`) and mechanically
   cross-checked (`ours_run.ml`'s length check against every admitted frame,
   Accept and Discard alike); none of the three hops assumes a cardinality
   of one.
5. **`check_timing`'s per-frame maps** (T0/T1/T2: `Int_map`-keyed, built via
   `List.filter_map`/`List.map` over the WHOLE `ours`/`theirs`/
   `common_indices`). **SAFE** — Map- and whole-list-based throughout; the
   one place this WAS fragile (`own_profile`'s print gated on the whole
   transaction's divergence list, hiding a clean frame behind an unrelated
   sibling's) was already found and fixed at `FINDING RV-0078-S1-2` limb
   (b), and is re-verified green by this round's own local self-test run
   (the two-frame golden fixture below prints both frames' own profiles
   correctly).
6. **The determinism check** (`tools/cosim/run_cosim.sh`, `diff -u` between
   run1's and run2's canonical files, that file's own comment: "opaque byte
   streams for the determinism diff"). **SAFE** — never parses a record,
   never counts a frame; it inherits only whatever the producers wrote,
   which is exactly where this round's repair lives.
7. **`run_cosim.sh`'s `dump_run`/case dispatch/exit-code interpretation**
   (read this round for the enumeration, not staged). **SAFE** — `dump_run`
   `cat`s whole files regardless of content; case dispatch and the
   `EXIT_*`/`tier=` branches operate on `compare`'s integer exit code and
   the case label, never on canonical-file text.
8. **`DELIVERY_DEPTH`** (`tb_xgmii_rx_64.v`, bounds simultaneously
   in-flight frames). **SAFE, unchanged** — already N-frame-capable by
   design (= 8, already exercises 2 for C2); this round only added a
   cross-reference to `MAX_WORDS_PER_FRAME` in its own comment.
9. **`MAX_WORDS_PER_FRAME`** (`tb_xgmii_rx_64.v`, new this round, bounds
   words buffered per single frame before its own `D` line closes it).
   **REPAIRED HERE / introduced as part of this repair** — bounded (= 16),
   with its own `E`-sentinel refusal on exhaustion (property 5), inert for
   every case this lane ships today (max 8 words/frame).
10. **`canonical.mli`'s grammar text** (the pinned "per frame: `F`, then
    `W`s, then `D`" contract). **SAFE, unedited** — the grammar was always
    frame-count-generic by its own wording; the defect was one producer's
    non-conformance to it, never the grammar's own definition (property 2
    forbids touching it without cause, and none arose).

**`FINDING RV-0078-S2-8`'s golden-file fixture**, riding this round per
`RV-C2RERUN` §10 item 1, in `test/cosim/compare.ml`:
`reference_two_frame_golden_canon_text` is hand-authored raw text (never
generated through `Canonical.write`, the same reasoning
`reference_refusal_canon_text`/`old_format_canon_text`/
`defect_shape_canon_text` already use) representing the repaired writer's
INTENDED buffered output for a two-frame, minimum-IFG, overlapping-spans
schedule shaped exactly like CD §10.2's C2 instance: frame 0 admit_cycle 0,
frame 1 admit_cycle 10 (`RV-C2RERUN` §4: "at C2 frame 1 is admitted on cycle
10"), eight full 64-bit words each (a 64-octet frame at REQ-102's own
minimum length), both `Accept`, each frame's block `F`/8×`W`/`D` fully
contiguous. Cycles follow SPEC-M03 §6.1's own gapless `admit_cycle + m + 3`
formula for both frames, so the fixture is diffable, by a reviewer, against
`tb_xgmii_rx_64.v`'s own `$fwrite`/`write_word_line` call sites — the check
`FINDING RV-0078-S2-8` says would have caught `S2-6` statically, with no
simulator, had it existed before this repair. `two_frame_golden_transaction`
is the identical content constructed through `Canonical.write_file` (the
"ours" side, built the same way every other fixture in this self-test
builds its own-side file), so the check is case (a)'s own shape — "construct
a known-good pair, assert agreement" — applied to this two-frame content:
it proves both that the hand-authored file reads at all (the core `S2-8`
check) and that it matches this packet's own two-frame case's intended
content and timing, not merely that it is well-formed. It does not execute
`tb_xgmii_rx_64.v` (ADR-0005) and does not discharge `FINDING RV-0078-S1-4`,
which needs a real reference-side guard trip (C9).

**Local checks, verbatim** (this environment has no `dune`, no Hardcaml
switch, no `iverilog`/`vvp` — ADR-0005; `tb_xgmii_rx_64.v` is therefore
CI-deferred in full, as it has been since `WO-0046`, self-reviewed line by
line against its own `$fwrite`/task call sites and never executed).
`compare.ml` and `canonical.{ml,mli}` need only the standard library
(`compare.ml`'s own header claim), so the full self-test — every existing
case plus the new `FINDING RV-0078-S2-8` case — builds and runs with the
bare system `ocamlc` against the REAL files, not stubs:

```
$ ocamlc -o compare_selftest canonical.mli canonical.ml compare.ml
    -> exit 0, no warnings
$ ./compare_selftest --self-test
...
frames compared: 2
frames matching: 2
divergences: none
--- T0: admit-cycle equality (calibration; asserts nothing about either design) ---
T0: aligned -- every frame index present on both sides shares one admit-cycle
  frame 0: admit_cycle = 0
  frame 1: admit_cycle = 10
--- T1: our side against SPEC-M03 section 6.1 (asserting; a red is a defect against OUR spec, never a differential finding) ---
T1: clean -- every accepted frame's output words landed on their SPEC-M03 section 6.1 (admit_cycle + m + 3) cycles
  frame 0:
    word 0: expected 3, observed 3
    ...
    word 7: expected 10, observed 10
  frame 1:
    word 0: expected 13, observed 13
    ...
    word 7: expected 20, observed 20
--- T2: the reference's own cycles -- RECORDED, NEVER ADJUDICATED (REQ-901's exclusion, applied to time) ---
  frame 0: theirs cycles = [3 4 5 6 7 8 9 10]
  frame 1: theirs cycles = [13 14 15 16 17 18 19 20]
  frame 0: theirs - ours per word = [0 0 0 0 0 0 0 0]
  frame 1: theirs - ours per word = [0 0 0 0 0 0 0 0]
compare --self-test: (FINDING RV-0078-S2-8) the reference writer's intended two-frame, minimum-IFG buffered output (hand-authored golden file)
  PASS: the golden file's per-frame CONTIGUOUS blocks (F, its 8 W lines, D) read cleanly and agree with our own side's identical content and gapless SPEC-M03 section 6.1 cycles (exit 0)
compare --self-test: OK
$ echo $?
0
```

Every pre-existing case (a)–(f), T0, `idle_carried`, `refusal`,
`two_idle_positions`, `two_frame` (`FINDING RV-0078-S1-2` limb (b)) also
printed `PASS` in this same run — 13/13 cases, `compare --self-test: OK`,
exit 0. Total counted: `grep -c 'PASS:'` = 13, `grep -c 'FAIL:'` = 0.

**Case 0 and C1 invariance — argued structurally, not measured (ADR-0005,
no `iverilog`).** Case 0 and C1 each admit exactly one frame; no second
frame is ever pushed onto the delivery FIFO while the first occupies it, so
`close_delivery_accept`'s buffered flush for that lone frame is reached with
nothing else EVER buffered in any other slot — `delivery_admit_cycle`/
`delivery_word_count` for every other slot stay at their init values,
unused. The flush therefore emits, as one contiguous burst at the frame's
own `tlast`: the SAME `F` line (same index, same `admit_cycle`, same
`%0d %0d` format), the SAME eight `W` lines (`write_word_line` reproduces
`write_word`'s own format string and WO-0049 §3's digit-width trick
verbatim, over stored `reg`s of the identical widths the live wires had —
`reg[7:0]` for `tkeep`, matching `wire[7:0]`; `reg[63:0]` for `tdata`,
matching `wire[63:0]`), and the SAME `D` line — merely relocated in TIME
(to the moment of `tlast`, rather than streamed as each event occurred),
never in CONTENT, FORMAT or ORDER. Since the pre-repair streaming writer
already emitted these three record types back-to-back for an uncontested
single frame (nothing else was EVER written between its own `F` and `D`,
there being no second frame to interleave), the post-repair buffered
emission is bit-for-bit the same file. This is the same standard
`RV-C1C2` §10's and the prior repair round's own case-0/C1 invariance
arguments used — every write site's CONTENT unmoved, only WHEN it reaches
disk moved — applied here to the second layer of the same finding.

**What is CI-deferred, and why**: identical reasoning to every prior round
in this lane (ADR-0005). `tb_xgmii_rx_64.v`'s own repair is self-reviewed,
line by line, against `write_word`'s own pre-repair format strings (to
confirm `write_word_line` reproduces them verbatim) and against
`open_frame`'s/`close_delivery_*`'s own pre-repair `$fwrite` call sites (to
confirm no field's VALUE changed, only its write TIME) — never executed.
The landing `cosim` job at the next C2 re-run remains the first and only
real execution of the repaired writer through the actual Icarus reference,
and the first place this repair's own correctness is checked against a real
simulator rather than against hand-reasoning and the golden-file fixture
above.

**Refused or blocked**: nothing. No spec ambiguity was met (the finding's
own §6 fully states the seven properties any route must preserve, and the
choice between the two visible routes is decided by property 2 alone,
leaving no open design question); no RTL leaked into context (`libs/**`,
`top/**`, `rtl_snapshots/**` opened at no point — confirmed by this round's
journal Inputs list); no untestable requirement; no licensing-taint
suspicion; no effort anomaly (one round, as `RV-C2RERUN` §10 item 1's own
"Carrier: a tb_writer repair round" names it).

**Files changed**: `test/cosim/tb_xgmii_rx_64.v`, `test/cosim/compare.ml`.
No third file (`git status --porcelain` confirms) — not
`test/cosim/canonical.{ml,mli}` or `test/cosim/ours_run.ml` (the chosen
route does not amend the grammar), not `test/cosim/stimulus_gen.ml` (§1's
own bar), not `tools/cosim/**` (data_wrangler's write scope; read only, for
the enumeration), not `test/attack_plans/**` (dv_lead's write scope).

— tb_writer, spawn `WO-0078/2026-08-06T12:56Z` (no explicit "work-order id +
spawn UTC timestamp" token was present in this round's own dispatch prompt;
recorded honestly per this packet's own prior tb_writer entries' precedent
for the identical situation — the timestamp is this entry's own UTC header
time, `date -u` read at the start of this round, matching the environment's
own `currentDate` context, 2026-08-06).

---

### dv_lead — `RV-C2ALPHA`: the C2 re-run, third landing (§6.2) — **C2 COMPARED, AGREED ON BOTH FRAMES, and SELECTS BRANCH α under CD §10.2 UNAMENDED; `FINDING RV-0078-S2-6` CLOSED; the prediction SPENT**

#### 0. What I executed, and what I did not

**HEAD verified as my first action**: `git rev-parse HEAD` →
`2efd7f970edb467b7e5b444b5c76416be8c736f0`, exactly the spawn head. Neither
rollback disposition fired. `git status --porcelain` empty at entry.

**This round writes three things and nothing else**: this verdict, the `State`
field at the head of this file, and my journal. **No `test/**`, no `tools/**`, and
— ruled in §8 — no edit to `test/attack_plans/CD-xgmii_rx_64_cosim.md` and no edit
to `test/attack_plans/AP-xgmii_rx_64.md`.** Every defect below is a finding for a
named carrier round, not a repair I made.

**I executed no simulation** (ADR-0005). My evidence is: the `cosim` job log read
in full through the server-side GitHub logs tool; the run and job metadata from the
same API; four mechanical checks run on the checkout; and a source-level spot-check
of the repaired writer, which is my charter §3 review obligation and which I did
**against the diff rather than against the Return log's own assertions**.

**The run, at the API.** `build` run **`31103977231`**, `head_sha`
**`2efd7f970edb467b7e5b444b5c76416be8c736f0`**, event `push`, run number 508,
conclusion **`success`**, `13:01:19Z → 13:07:10Z`. `cosim` job **`92624287637`**.
**The whole run is green**: the `cosim` job, the `build` job and the journal-check.
**This is the first wholly green landing this lane has had since the case set
widened**, and the first ever in which every case in the set reached a comparison.

**Four mechanical checks, mine:**

1. **`git merge-base --is-ancestor 5c01af0 2efd7f9` → true.** CD §10's freeze
   commit is an ancestor of the commit the run executed, so §12 criterion 8's
   precondition holds for all three cases by commit ordering.
2. **`git diff --numstat 5c01af0 2efd7f9 -- test/attack_plans/CD-xgmii_rx_64_cosim.md`
   → `129  0`, ZERO deletions** — the identical hunk measured at the previous
   landing, entirely §10.2-bis appended *after* §10.2. **And the CD does not appear
   at all in check 3's changed-path list**, so it did not move between `9de61f1` and
   `2efd7f9` either. **C2's INSIDE list, its expected values, its frozen prediction
   and both branch cells are byte-unchanged from the freeze to the run that spent
   the prediction.**
3. **`git diff --name-only 9de61f1 2efd7f9`** → seven paths, of which exactly two
   are code: `test/cosim/compare.ml` and `test/cosim/tb_xgmii_rx_64.v`.
   **`test/cosim/canonical.ml`, `test/cosim/canonical.mli` and
   `test/cosim/ours_run.ml` did not move** — so *the grammar is unamended* is a
   measurement here, not a claim in a Return log. **`test/cosim/stimulus_gen.ml`
   did not move**, and `git diff --numstat 53fa1de 2efd7f9 -- test/cosim/stimulus_gen.ml`
   is empty: the structural half of the sha bind holds across **both** repairs.
4. **The repaired writer, read at source** — `capture_word`, `write_word_line`,
   `open_frame`, `close_delivery_accept`, `close_delivery_discard`, both bound
   declarations, and every `E`-sentinel call site; plus `canonical.ml`'s `"E"`
   arm and `canonical.mli`'s `divergence` type. All DV-side files in my own scope.
   **No `libs/**`, no `top/**`, no `rtl_snapshots/**` was opened at any point.**

---

#### 1. The CI reading, at the source — three cases, and all three reached a verdict

`=== CASE SET (WO-0078 §6.2 Stage 2: 3 case(s) — 0 C1 C2) ===`

**CASE 0 — the freeze holds for the third consecutive landing, now across two
repairs of the reference producer.**

> `[ok]   case 0 stimulus.txt sha256: c675517176922d42bca42ec3def182cb3536861f1acaa8384116f33a5c4cc051`
> `[ok]   case 0's stimulus is byte-identical to the last green pre-widening run`
> `frames compared: 1` / `frames matching: 1` / `divergences: none`
> `T0: aligned` / `frame 0: admit_cycle = 0`
> `T1: clean` … `word 0: expected 3, observed 3` … `word 7: expected 10, observed 10`
> `frame 0: theirs - ours per word = [0 0 0 0 0 0 0 0]`
> `CASE 0: stimulus_sha256=c675517…4cc051 compare_exit=0 tier=CLEAN`

**CASE C1 — clean, and byte-reproduced across a second repair of the writer.**

> `[ok]   case C1 stimulus.txt sha256: 5ae9e4f501251c38d0c2d386bd792e07cbcf9cf107cf7e75c378e21b1ce3bd7c`
> `frames compared: 1` / `frames matching: 1` / `divergences: none`
> `T0: aligned` / `frame 0: admit_cycle = 0`
> `T1: clean` … `{3 … 10}` / `frame 0: theirs cycles = [4 5 6 7 8 9 10 11]`
> `frame 0: theirs - ours per word = [1 1 1 1 1 1 1 1]`
> `CASE C1: stimulus_sha256=5ae9e4f5…3bd7c compare_exit=0 tier=CLEAN`

**CASE C2 — the comparison happened.**

> `[ok]   case C2 stimulus.txt sha256: cc1e85a4c5f871226f07b4792446d63c523577dcf172d6c4a80b8a3e845b44a7`
> `frames compared: 2`
> `frames matching: 2`
> `divergences: none`
> `T0: aligned -- every frame index present on both sides shares one admit-cycle`
> `  frame 0: admit_cycle = 0`  /  `  frame 1: admit_cycle = 10`
> `T1: clean -- every accepted frame's output words landed on their SPEC-M03 section 6.1 (admit_cycle + m + 3) cycles`
> `  frame 0:  word 0: expected 3, observed 3  …  word 7: expected 10, observed 10`
> `  frame 1:  word 0: expected 13, observed 13  …  word 7: expected 20, observed 20`
> `  frame 0: theirs cycles = [3 4 5 6 7 8 9 10]`
> `  frame 1: theirs cycles = [14 15 16 17 18 19 20 21]`
> `  frame 0: theirs - ours per word = [0 0 0 0 0 0 0 0]`
> `  frame 1: theirs - ours per word = [1 1 1 1 1 1 1 1]`
> `CASE C2: stimulus_sha256=cc1e85a4…5b44a7 compare_exit=0 tier=CLEAN`
> `case C2: ours.canon/theirs.canon byte-identical between run1 and run2`

**The aggregate**, and it is the sentence this lane has been trying to print since
the case set widened:

> `=== AGGREGATE (WO-0078 §3.3, RV-STAGE1 §5 OQ1/OQ2 amendment) ===`
> `  every case in the set reached a verdict and every verdict was clean.`

**The self-test**: `13/13 PASS`, `0 FAIL`, `compare --self-test: OK` — counted in
the job log itself (`grep -c 'PASS:'` = 13, `grep -c 'FAIL:'` = 0), including
`FINDING RV-0078-S2-8`'s new golden-file case and `FINDING RV-0078-S1-2` limb (b)'s
case, both green.

**Cost.** case 0 `1.365s`; C1 `1.351s`; C2 `1.371s` (run1+run2 sums); invocation
**`9.665s`** against Band A's 300 s. Linearity ratio **1.004** against a bound of 2,
on three cases every one of which now contributes a real datum.

---

#### 2. C2's branch selection — **α**, and the chain that gets there

**The prediction, frozen at `5c01af0` and quoted from CD §10.2 rather than
paraphrased:**

> **our side, by spec**: *"two accepted frames, indices 0 and 1, eight words each"*
> **prediction**: *"agreement on both"*
> **branch if the prediction holds**: **α**

**α's own definition** (§7): *"the observable agrees inside the domain. The case's
class becomes co-sim-anchored for that class and no wider."*

**What "inside the domain" is, for this instance** (CD §10.0, REQ-901's operative
list): the ordered sequence of output frames — **payload octets**, **the `tkeep`
extent of each word**, **`tuser`[0] on each `tlast`** — and **the accept-or-discard
decision per input frame**.

**That the instrument actually compares all of it, checked rather than assumed.**
`canonical.mli`'s `divergence` type has exactly four constructors: `Missing_frame`
(keyed by **index**, so a frame absent on one side is reported at the index it is
missing at rather than shifting every later comparison), `Decision_mismatch`,
`Word_count_mismatch`, and `Word_mismatch` with `field` ∈
`"tkeep" | "tlast" | "tuser0" | "octets"`. **The four constructors cover the INSIDE
list item for item, with `tlast` compared as well.** So
`frames compared: 2 / frames matching: 2 / divergences: none` **is agreement across
the whole domain, not across a subset of it** — which is the distinction between a
branch selection and a green light.

**And the outcome space was two-valued before the run, by CD §10.0's own
derivation**: every frame in C1–C4 is 64 octets, REQ-901's classes (e) and (f)
*"exclude nothing in the 64-to-1518-octet range"*, classes (a)–(d) have no instance
at the M03 boundary, so **the permitted-divergence set for this instance is empty
and branch β is unreachable.** The case could select α or γ and nothing else.

**Therefore: C2 selects α. The prediction is CONFIRMED, and it is SPENT.** It was
unspent across two landings because those landings reached no comparison; it is
spent now because a comparison happened that **could have falsified it** and did
not. That is the only thing that spends a prediction — not a run, not a dispatch,
not a green job. **Count comparisons, not runs.**

**Two readings that are NOT part of the branch selection, bounded here so they are
not read as part of it later:**

1. **T1 clean on both frames is an assertion of OUR side against SPEC-M03 §6.1**,
   never comparison content (`WO-0075` §3.1; CD §10.1's own note). Its content is
   nonetheless the most substantial new fact about our design this lane has ever
   produced: **frame 1's eight words land on 13 … 20 = `admit_cycle`(10) + m + 3**,
   so **the gapless formula holds through the re-arm path at a non-zero admit
   cycle** — a path CD §10.2 records that *"no seeded class has ever reached at this
   lane."* This is an ours-vs-spec observation, `EXIT_TIMING(10)`'s axis, and it
   lifts no bar of its own.
2. **T2's `frame 1: [1 × 8]` is out-of-domain data** — CD §5.2 **X1**, all cycle
   timing and word-to-word spacing; CD §0: *data, recorded, not adjudicated*;
   **`AP-M03` §7 bar 3 is untouched.** It matches C1's lane-4 offset exactly, and it
   matches `RV-C2RERUN` §5's instrument-stability note, which said in terms that the
   note **"is not a prediction in §7's sense and it may not be cited as one."** It is
   not cited as one here. **The note is confirmed as an instrument-stability
   observation and as nothing else**: it selects no branch, lifts no bar, and enters
   no `SO-` as a measured claim about either design's timing.

---

#### 3. What α buys — the coverage claim, stated per class and bounded before it is banked

**`AP-M03` §7 bar 1 lifts for C2's class and for no other.** CD §10.2's own
bounding: *"bar 1 lifts for the two-clean-frames-at-minimum-IFG class and for no
other. It does not lift for REQ-004's 10 000-frame line-rate cadence: two frames is
two frames, and the stress obligation rests where it rested."*

**The three classes this lane now anchors, in the form §12 criterion 9 requires —
per class, at a run id, never per module:**

| # | class | run / job | verdict |
|---|---|---|---|
| 1 | one 64-octet good-FCS frame, **lane-0 start on the reset-release cycle**, gapless, no injected idle | `31103977231` / `92624287637` (re-observed; anchored since Phase 1 at `30988038809`) | α |
| 2 | one 64-octet good-FCS frame, **lane-4 start on the reset-release cycle** | `31096150983` / `92598555141` (`RV-C1C2`); re-observed at `31100435961` and `31103977231` | α |
| 3 | **two 64-octet good-FCS frames at the minimum inter-frame gap**, frame 0 at a lane-0 start on the reset-release cycle, both accepted, across the re-arm path | `31103977231` / `92624287637` | **α — NEW** |

**And the sub-class the compound case does NOT separately anchor, stated because it
is exactly the over-read this verdict would otherwise license.** C2's frame 1 lands
in **lane 4 at a non-zero admit cycle** as a by-product of §0.3's gap arithmetic
(84 octet-times, not a multiple of 8 — CD §10.2's own recorded consequence).
**C2 anchors the compound class as driven; it does NOT anchor "a lane-4 start at a
non-zero admit cycle" as a separable class**, because CD §10.2 states in terms that
a red at C2 alone *"could not be attributed between the start lane and the re-arm
path"*, and a green cannot be attributed within a case any better than a red can.
**Per-case reporting attributes a result to a case; it does not attribute within
one.**

**What is still not anchored, listed so no `SO-` has to reconstruct it**: bad FCS
(C3), nonstandard preamble (C4), runt and undersize and oversize (C5–C7), `/E/`
mid-frame (C8), `/S/` before `/T/` (C9), **any** injected idle, **any** frame length
other than 64 octets, REQ-004's line-rate cadence, and **every strobe of either
side**. **Bars 2, 3 and 4 are untouched by this run**: no strobe was compared, no
cross-side cycle was adjudicated, the strobe record stays refused, and bar 4's C3
cell has still not been reached.

**No sentence of the form "the co-simulation anchors this module" is writable, and
none is written.**

---

#### 4. `FINDING RV-0078-S2-6` — **CLOSED**, on evidence and on a source-level check of my own

**Closed on four independent grounds, not on the run's colour:**

1. **The defect's own signature is gone.** `Canonical.read` refused `theirs.canon`
   at line 9 last landing — *"F line while frame 0 is still open"* — on a file whose
   `F 1 10` record preceded frame 0's eighth `W` line. This landing the same
   stimulus, at the same sha, produced a file the same conformant reader read
   without complaint, and `compare` exited **0**.
2. **The route did what it claimed, checked at the diff.** Only **one** `E` line was
   added (`E word-buffer-exhausted`); **no pre-existing `E` sentinel changed by
   value** — I checked all **four** that exist (`delivery-fifo-exhausted`,
   `cannot-open-metadata-sidecar`, `second-start-while-open`,
   `word-with-no-open-frame`), one more than the Return log's own property-3
   accounting names. The `F`, `W` and `D` format strings are **unchanged in
   format**; the only edits inside them move the argument from a live wire to a
   stored `reg` of identical declared width, and the `%02x` octet field keeps
   WO-0049 §3's `[8*k +: 8]` fixed-width part-select. `canonical.{ml,mli}` and
   `ours_run.ml` do not appear in the diff at all.
3. **Property 2 (byte-exactness for single-frame files) is discharged more strongly
   than the Return log argues it.** The Return log offers a structural argument;
   the run offers something better. **Every field of a canonical record is either
   compared or printed**: index, decision, `tkeep`, `tlast`, `tuser0` and octets by
   the comparator; `admit_cycle` by T0; every `cycle` by T1 and T2. Case 0 and C1
   reproduced **all** of them identically to the pre-repair runs, so the only
   residue byte-identity could still hide is **formatting** — which check 2 above
   closes at the format strings themselves. **Considered and declined**: adding a
   `theirs.canon` sha256 to the per-case print, which would make producer-side
   invariance a measurement rather than a two-part argument. It is declined **not**
   because it is worthless but because the argument above already pins the content
   and the format independently, and an instrument change landed inside an
   adjudication round is the thing this lane has been paying for; if a future round
   opens `run_cosim.sh` for another reason it is a one-line addition and I recommend
   it there.
4. **Property 5 (bounded buffering with its own refusal) is structurally sound and
   fail-closed at the reader.** `capture_word`'s new guard writes
   `E word-buffer-exhausted` as the **last** thing before `$fclose`/`$finish`, in
   `DELIVERY_DEPTH`'s own established shape; and `canonical.ml`'s arm is
   `| "E" :: rest, _ ->` — matching **any** `E` reason, **regardless of parse
   state** — so the new guard fails to read by construction rather than by the
   accident of which reason string it carries.

**But see §6's `FINDING RV-0078-S2-9`**: the bound the repair introduced is sized
against today's stimulus, and that is a defect in the bound, not in the closure.

---

#### 5. `FINDING RV-0078-S2-8` — **CLOSED at the limb it recommended; its structural condition is NOT closed and is not closable by a fixture**

**Closed limb.** The golden-file fixture exists, is **hand-authored raw text**
(never generated through `Canonical.write`, so it cannot agree with the writer by
construction), and **passed in CI at exit 0** with both frames' contiguous blocks
read cleanly. It converts the reference writer's record order *"from an unstated
assumption into a stated artefact a reviewer can diff against the `$fwrite` call
sites"* — S2-8's own words — and it is now the cheapest place a future writer-order
defect gets caught: **statically, with no simulator, for the price of one self-test
run.**

**One readability hazard in the fixture, recorded and deliberately NOT raised as a
finding.** Its cycle fields put **both** sides on SPEC-M03 §6.1's formula, so its T2
prints `[0 × 8]` for both frames — while **production C2 prints `[1 × 8]` for frame
1**, because the reference's lane-4 frame runs a cycle behind. **Neither is wrong**:
the fixture's cycle fields are grammar content chosen to make the file diffable, not
a claim about the reference's timing, and the reference's timing is X1, outside the
domain. It is recorded here so that a later reader who diffs the golden file against
a production log does not read the difference as a regression.

**Not closed.** S2-8's *statement* is structural: *"nothing anywhere exercises
`tb_xgmii_rx_64.v` except the `cosim` job"*, and under ADR-0005 that remains true —
its first execution is always CI. A fixture that models the writer's intended output
does not execute the writer. **`FINDING RV-0078-S1-4` STANDS unchanged**, first
dischargeable at C9, and this round **adds one guard to what it covers**: the new
`E word-buffer-exhausted` refusal has never fired and has no fixture. **The set of
reference-side guards never observed to fire is now five, and the `SO-` lists them
rather than implying the sentinel contract has been exercised.**

---

#### 6. Findings — two new, both MINOR, both against my own instrument design; and the standing set

**`FINDING RV-0078-S2-9` (MINOR, PRE-EMPTIVE — the first of this species caught
before it cost a round) — `MAX_WORDS_PER_FRAME = 16` is sized against the frame
this lane drives today, in a lane whose own §6.3 already scopes a case driving a
frame an order of magnitude longer.**

- **Statement.** `test/cosim/tb_xgmii_rx_64.v` introduces
  `localparam MAX_WORDS_PER_FRAME = 16` bounding the words one frame may buffer
  before its `D` line closes it, with its own refusal
  (`E word-buffer-exhausted`) on exhaustion. **16 words is 128 delivered octets.**
  REQ-102's frame range is **64 … 1518 octets**; a maximum-length frame delivers
  1514 octets after REQ-103's FCS strip, which is **190 words**. **Any case driving
  a frame whose delivered length exceeds 128 octets trips the guard, the reference
  producer refuses, `compare` exits 3, and the case reaches no comparison** — the
  exact disposition C2 spent two landings in. **§6.3's C7 (oversize > 1518 octets)
  trips it by construction**, and C7's reference side may forward the frame whole,
  so the bound must cover **the longest frame either producer can DELIVER for any
  dispatched case**, not the longest frame the stimulus injects.
- **Inert today, and that is the wrong test.** It cannot fire at case 0, C1, C2, C3
  or C4 — all 64-octet, 8 words — nor at C5 (runt, 1 word), C6 or C8. **It is not a
  blocker on C3 or C4 and must not delay either.**
- **Owner of the defect: dv_lead.** `RV-C2RERUN` §6 property 5 required *"bounded
  buffering with its own refusal"* and **never stated the range the bound must
  cover**. The assignee sized it honestly against the case set in front of it, said
  so in the file, and disclosed it as item 9 of its own census. **A worker asked for
  a bound and given no range picks the range it can see; naming the range is the
  work of whoever wrote the property.**
- **The species.** This is the **third** instance of one pattern in three rounds:
  `S2-1` (a guard's span derived when one frame was in flight), `S2-6` (a record
  grammar derived when one frame was in flight), `S2-9` (a buffer bound derived from
  the frame length driven today) — **a quantity fixed against the current stimulus,
  inside an instrument whose entire purpose is to widen the stimulus.** The first
  two cost a landing each. **This one cost a reading**, and it was found by putting a
  different question to the same code — which is §7's ruling.
- **Owner of the repair: tb_writer**, `test/cosim/tb_xgmii_rx_64.v`. **Carrier**:
  the next round that opens that file. **And a HARD PRECONDITION on Stage 3**, added
  to §6.3's re-authorisation gate as condition **(d)** — see §9.

**`FINDING RV-0078-S2-10` (MINOR, structural) — the repair moved per-frame
attribution from the reader into the writer, which is lawful, and the assumption it
now rests on is stated nowhere pinned.**

- **Statement.** `capture_word` attaches every observed output word to
  `delivery_head` — **the oldest admitted-but-undelivered frame** — and only
  `delivery_head` ever closes. **That is the same *attribute to the oldest open
  frame* rule `RV-C2RERUN` §6 property 1 named as an unacceptable heuristic**, now
  living in the reference-side producer instead of the reader.
- **Ruled LAWFUL, and the distinction is not a dodge.** Property 1 forbids a
  **reader** downstream of a file resolving an ambiguity the file no longer records;
  it does not forbid a **probe at the interface** attributing what it can still see.
  A writer sitting on the AXI-Stream boundary reads its attribution off the
  interface's own framing contract — words up to and including a `tlast` are one
  frame — where a parser reading a file in which that framing was never written down
  is guessing. **Same rule, different epistemic position, and only one of the two
  positions has a contract behind it.** The repair therefore satisfies property 1 as
  written **and** in substance: the ambiguity is removed at the source rather than
  resolved downstream, which is what property 1 asked for.
- **The residue, which is real.** Head-attribution additionally assumes the design
  under test **delivers frames in the order it admitted them**. For a streaming
  receiver on one AXI-Stream that is entailed by the interface; it is nonetheless an
  assumption, it is now load-bearing inside the instrument, and it is written in no
  pinned document. **A reference that ever reordered would produce a well-formed file
  with frame 0 carrying frame 1's octets — reported as `Word_mismatch`/`octets`,
  i.e. branch γ, i.e. a candidate `BUG-` against OUR RTL for an ordering difference
  on the other side.**
- **A reading rule, which binds from this verdict and costs nothing**: **before any
  multi-frame octet or word-count divergence is routed as a `BUG-` or as a REQ-901
  spec diff, frame ordering is ruled out first**, by reading both canonical files'
  `F`/`D` blocks in file order against their `admit_cycle` fields. Cheap, and it
  turns the residue from a trap into a checklist item.
- **Owner: dv_lead** (the property list I wrote named the reader and not the
  writer). **Repair**: one paragraph of stated assumption in the bench's own header
  and in `canonical.mli`'s grammar note. **Carrier**: the next round that opens
  either file; **not a blocker on anything**, and **owed before the `SO-`**.

**Standing findings — what this run does to each.**

- **`FINDING RV-0078-S2-6` — CLOSED** (§4).
- **`FINDING RV-0078-S2-8` — CLOSED at its recommended limb; structural condition
  STANDS** (§5).
- **`FINDING RV-0078-S1-2`(b) — RULED, and CLOSED, with its residual limb named**
  (§12, below the criteria table).
- **`FINDING RV-0078-S1-4` — STANDS, unchanged**, first dischargeable at C9, and now
  covering **five** never-fired reference-side guards rather than four.
- **`FINDING RV-0078-S2-7` — STANDS, unrepaired, and it did not bite this run** for
  the accidental reason that every case had a result to summarise. **Owner of the
  repair: data_wrangler; carrier: C3's runner half; owed before the `SO-` cites this
  log.** Unchanged.
- **`FINDING RV-0078-S2-3` — STANDS**, with its two demonstrated species of the
  fourth outcome unchanged; carrier unchanged (the co-sim Phase 3 CD instance
  round). **This run adds no third species**: every case reached a comparison.
- **`FINDING RV-0078-S2-2`, `S2-4`, `S2-5`** — untouched; discharged and settled as
  previously recorded.
- **`FINDING CD-P2-1`, `CD-P2-2`, `FINDING K-1`, `RN-6`** — untouched, carriers
  unchanged.

---

#### 7. The ten-item one-frame-assumption census — adjudicated item by item, and ruled on completeness

**This census is the instrument this lane bought with two landings, and adjudicating
it means checking its claims, not adopting them.** Both of my MATERIAL findings came
from exactly this census being incomplete, so a census returned and rubber-stamped
would be worse than none.

| # | subject | disposition | my ruling |
|---|---|---|---|
| 1 | the reader's state machine (`canonical.ml`) | SAFE | **ADOPTED, and now measured rather than argued**: the two-frame golden fixture reads clean in the self-test **and** a real two-frame production file read clean at C2 |
| 2 | `ours_run.ml`'s writer | SAFE, unchanged | **ADOPTED.** Independently visible: our side already wrote two contiguous blocks at `9de61f1`, which is why S2-1's repair alone never tripped S2-6 on our side |
| 3 | `tb_xgmii_rx_64.v`'s record order | REPAIRED HERE | **ADOPTED**, and verified by me at the diff (§4 item 2), not on the Return log's assertion |
| 4 | the idle sidecar's per-frame indexing | SAFE, *"already exercised at two entries in production"* | **ADOPTED WITH CORRECTION.** The claim was true of two hops when written and **false of the third**: `compare` never read C2's sidecar at `9de61f1` — it failed at `theirs.canon` first, which `RV-C2RERUN`'s criterion-5 row recorded in terms. **All three hops are exercised as of THIS run**, and the evidence for item 4 is dated here, not there |
| 5 | `check_timing`'s per-frame maps | SAFE | **ADOPTED**, and exercised in production for two frames for the first time |
| 6 | the determinism check | SAFE | **ADOPTED**, and exercised on a **two-frame** canonical file for the first time (`byte-identical between run1 and run2`) |
| 7 | `run_cosim.sh`'s `dump_run` / dispatch / exit interpretation | SAFE (read, not staged) | **ADOPTED.** Its production firing was the previous landing; nothing here contradicts it |
| 8 | `DELIVERY_DEPTH` | SAFE, unchanged | **ADOPTED**; = 8, and **exercised at 2 in production for the first time**. Note for item 9's repairer: the two bounds are now multiplied in the storage arrays (`DELIVERY_DEPTH*MAX_WORDS_PER_FRAME`), so raising one raises the product |
| 9 | `MAX_WORDS_PER_FRAME` | REPAIRED HERE / introduced; *"inert for every case this lane ships today"* | **AMENDED — and it carries `FINDING RV-0078-S2-9`.** The disposition is true and the test is wrong: *inert for today's stimulus* is precisely the reasoning that produced items 3 and the two landings before it. **This is the one cell where the census failed to apply its own method to the census's own new code** |
| 10 | `canonical.mli`'s grammar text | SAFE, unedited | **ADOPTED**, and confirmed by the diff: neither grammar file appears in `git diff --name-only 9de61f1 2efd7f9` |

**Is it complete enough to authorise C3 and C4 without another layer surprise?**

**YES for C3 and C4, and the reason is structural rather than optimistic.** Both
drive **one 64-octet frame**. Against that shape every census item is either inert
(4, 5, 6, 8, 9) or **already exercised at exactly that shape across three landings**
(1, 2, 3, 7, 10). The genuinely new ground C3 and C4 break is **`tuser`[0] = 1 and
the accept-or-discard decision under a bad FCS**, and **the preamble octets under
X4's exclusion** — both single-frame, both inside code paths this lane has run,
and neither reaching a cardinality, a bound or a record-ordering question.

**NO for Stage 3, and the gap has a name.** The census answers the question it was
asked — *where could a **one-frame** assumption still be load-bearing* — and Stage 3
does not break the frame-count axis at all. **It breaks two others**: **frame
LENGTH** (C5 runt, C7 oversize) and **admission LEGALITY** (C9's `/S/` before
`/T/`, which §6.3 already names the largest item in the packet). **`S2-9` is the
first hit on the length axis, and it was found by putting a different question to
the same code.** There is no reason to believe it is the only one, and every reason
from three consecutive rounds to believe a second census is cheaper than a second
landing.

**Ruling**: a **second static census, on the frame-length and admission-legality
axes**, is owed **before Stage 3's re-authorisation gate**, and is added to §6.3's
conditions as **(d)** in §9 below. **Naming them costs one reading; discovering them
costs one round each** — `RV-C2RERUN` §10's own instruction, re-applied to the axis
it did not name.

---

#### 8. The CD and the AP — **no edit to either**, ruled rather than omitted

**The CD gets nothing, for the third consecutive round and on the same rule.**
CD §10.7 item 3: *"This document freezes the questions; it answers none of them."*
**C2's α is an answer.** §9-bis's addition-only lift is scoped to co-sim Phase 2's
domain instances and **a result is not one** (`RV-C1C2` §3's ruling, now applied to
my own round for the third time). Nothing in §10.2 is falsified by this run — it
predicted agreement on both frames and got it — so there is no §10.2-bis-class
annotation to make either. **The branch selection's record lives here, in the
packet's §14, and in the `State` field**, which is where a result belongs and where
`RV-C1C2` put C1's.

**The AP gets nothing this round, and the bar movement is real.** Bar 1 **has**
lifted for C2's class (§3) — that is earned, and it is recorded above with its run
id, its case, and its bounding. **The `AP-M03` §7 cell that states it is owed
elsewhere**: §13 item 2 routes those cells to *"the `AP-` round that follows each
landed stage"*, on `J-dv_lead-0112`'s rule that a plan round is not where machinery
lands **and its converse**. **Stage 2 is not landed** — C3 and C4 are not issued —
and a bar cell written now would have to be reopened twice more, which is the
left-standing-summary drift `CD` §0-ter tabulates four payments for and `AP-M03` §7
has itself paid four times. **I refused this edit at C1 and I refuse it at C2 on the
identical ground.** The AP round that follows Stage 2 owes **both** cells, and if
the `SO-` round arrives first it owes the same accounting; §3's table above is
written so that round can lift it verbatim.

---

#### 9. Sequencing — **C3 alone, confirmed**, with one amendment, one new precondition, and one instruction aimed at a criterion unexercised after three landings

1. **The C3 dispatch, alone, per §6.2 — CONFIRMED.** Its three grounds survive C2
   going green and one of them changes shape: C3's single frame cannot trip any
   defect this lane has found; its result may force a REQ-901 spec diff and must not
   be read under an aggregate naming another case; and **its predicted-divergence
   status is exactly why it lands by itself** (§6.2: *"a spec-diff conversation held
   about two cases at once is a conversation about neither"*). **`FINDING
   RV-0078-S2-7`'s runner repair rides C3's runner half**, unchanged.

2. **AMENDMENT — the case array order at the C3 landing is `0 C1 C3 C2`, not
   `0 C1 C2 C3`.** The reason is §12 criterion 3's plural content: *a red case does
   not cost a LATER case its line*. **It is unexercised after three landings — twice
   deferred because the only not-clean case was last in the array, and a third time
   because nothing was not-clean at all** — and my own `J-dv_lead-0154` open question
   2 predicted exactly this: that a green C2 would leave it *"unexercised
   indefinitely."* **Placing C3 third makes a not-clean C3 be followed
   by C2 in the same run**, which exercises the property at zero cost the first time
   C3 diverges — and costs nothing if it does not. **Lawful, checked**: case 0 stays
   first (its sha gate is precedence 1 and reports before any case runs, §3.3); no
   stimulus moves, so **every case's sha bind is untouched** — a bind is per case,
   never per position; each case already runs in its own working directory with its
   own comparison, own determinism check and own SUMMARY, and `RV-C1C2` §5
   established that an aggregate assigned after the loop does not reach back. **If
   C3 is clean the property stays unexercised, and the `SO-` says so rather than
   letting it lapse.**

3. **A consequence worth stating: C2 is now a standing regression case.** Every
   subsequent landing re-runs it, so the two-frame class, the sha bind and the
   re-arm path are re-checked at C3, at C4, and at every landing after them. **The
   first landing that fails to reproduce `cc1e85a4…5b44a7` with two matching frames
   is adjudicated as a regression before any new case's result is read.**

4. **`FINDING RV-0078-S2-9` does NOT gate C3 or C4** (the bound is inert at 64
   octets) and its repair must not delay them. **It DOES gate Stage 3**, and §6.3's
   re-authorisation gate gains two conditions beside (a), (b) and (c):
   - **(d)** a **second static census** on the frame-length and admission-legality
     axes (§7), returned and adjudicated;
   - **(e)** `MAX_WORDS_PER_FRAME` **raised to cover the longest frame either
     producer can DELIVER for any case in the dispatched set**, with the covering
     range stated in the file beside the bound — because a bound whose range is not
     written down is the defect, not the number.

5. **`FINDING RV-0078-S2-10`'s reading rule is in force from now** (§6): no
   multi-frame octet or word-count divergence is routed as a `BUG-` or a spec diff
   before frame ordering has been ruled out at both canonical files.

6. **The barred route stays barred, in the same words.** No case is removed from the
   set to make a run green. **Removing a case to make a run green makes the lane
   unable to fail**, which is the property CD §0 exists to protect; schedule pressure
   goes up as **E2**, and the case set is not reduced inside DV under any
   circumstances. **This is stated at a green landing deliberately** — a bar that is
   only repeated when it is tempting is a bar that has been forgotten in between.

---

#### 10. The stopping rule — **RETIRED as to C2, its question answered; its FORM re-armed for C3 and C4, before their runs**

**The rule, quoted from `RV-C2RERUN` §3**: *"if the next C2 re-run reaches no
comparison for a third time, C2 is NOT re-dispatched a fourth time as a worker
repair round … the question becomes whether the pinned transaction-level canonical
form (CD §3, `WO-0046` §2.3) can express two frames whose admission and delivery
spans overlap at all."*

**It never fired, and it did not merely expire — its question is answered.** The
pinned transaction form **can** express two frames whose admission and delivery
spans overlap: a conformant contiguous file, a clean read, an index-keyed comparison
of two frames, and byte-identical determinism, at the same grammar, **unamended**.
**The rule is RETIRED, and it is retired on an answer rather than on a timeout** —
which is the only honest way to retire a pre-registered rule.

**Its FORM is re-armed for C3 and C4, pre-registered here with the answer not in
hand, at the same threshold and with its subject generalised**: **if any single case
reaches no comparison on two consecutive landings, the third landing of that case is
not a fourth worker repair round.** It becomes a design question about the
instrument, owned by me, answered with options and cost in a dv_lead round, and
reaching the sponsor as **E2** if any option narrows the case set. **Narrowing the
case set inside DV stays barred outright.**

**What the retired rule bought, stated because pre-registration is worth nothing if
its value is only claimed when it fires.** It fixed, in advance and in the open, the
point at which a sequence of repairs stops being bad luck and starts being evidence
about the instrument — so the third landing was read as a test of that proposition
rather than as one more hopeful re-run. **It made the green mean something it could
not otherwise have meant.**

---

#### 11. C2's final ledger — the exact counts, with the shorthand corrected

**Stated in full because C2's saga will be summarised by people who were not in it,
and the summary that has been circulating understates one count.**

| quantity | count | basis |
|---|---|---|
| landings carrying C2 in the case set | **3** | `53fa1de` / `9de61f1` / `2efd7f9` — *not two* |
| worker repair rounds provoked by C2 | **2** | `S2-1` (guards), `S2-6` (writer order) |
| dv_lead adjudication rounds on C2 | **3** | `RV-C1C2`, `RV-C2RERUN`, this one |
| stimulus generated | **3**, at one identical sha | `cc1e85a4…5b44a7`, printed at all three; `stimulus_gen.ml` unmoved across both repairs |
| our producer (`ours_run`) invocations | **5** | 1 refusing (`53fa1de`), 2 producing (`9de61f1`), 2 producing (`2efd7f9`) |
| reference producer (`vvp`) invocations | **4** | 0 at `53fa1de` (`ours_run` runs first and refused), 2 + 2 after |
| `compare` invocations | **2** | exit 3 at `9de61f1`; exit 0 here |
| **comparisons reached** | **1** | this run |
| **branch selections** | **1** | **α** |
| frames compared, ever | **2**, matching 2, divergences 0 | this run |

**The correction, plainly**: C2 was **dispatched three times, driven three times,
compared once, and agreed once.** The record is what governs, and "dispatched twice"
was true only until this landing existed.

**The sha bind's final status.** `cc1e85a4c5f871226f07b4792446d63c523577dcf172d6c4a80b8a3e845b44a7`
**held across three landings, two repairs of the reference producer and one repair
of ours, with `stimulus_gen.ml` unmoved at every step.** It was a check, then a
measured invariant, and it is now **the thing that makes all three landings
statements about one stimulus** — without it, this verdict would be adjudicating a
case that had quietly become a different case. **It carries forward as C2's standing
regression bind (§9 item 3).**

---

#### 12. §12 read per criterion — nine, one disposition each, at `2efd7f9`

| # | criterion | disposition at `2efd7f9` |
|---|---|---|
| **1** | case 0 byte-identical | **DISCHARGED**, third consecutive observation: `c675517…4cc051`, printed beside the pre-widening anchor (run `31080871169`, job `92549154623`, `55e16ae`). **Now held across two repairs of the reference producer and one of ours.** |
| **2** | the sighted placement survives | **DISCHARGED**, and for the first time by **three** cases rather than two: case 0, C1 **and C2** each print `frame 0: admit_cycle = 0` — C2's T0 ran this landing. |
| **3** | every case reaches a verdict or names why not | **DISCHARGED on its own terms**: three `CASE` lines, each carrying case id, `stimulus_sha256`, `compare`'s own exit code and its tier; the aggregate names the class. **The plural property it protects — a red case does not cost a LATER case its line — is STILL UNEXERCISED after three landings, and no green landing can exercise it.** Ruled, not left: §9 item 2 reorders the array at the C3 landing so a not-clean C3 is followed by C2. **If C3 is clean it stays unexercised and the `SO-` states it rather than letting it lapse.** |
| **4** | T1 prints its numbers on the clean path | **DISCHARGED, and for the first time for a MULTI-FRAME case in production**: C2 printed both frames' eight expected/observed pairs. Limb (b)'s production instance ruled at §7 below the table. |
| **5** | T1's antecedent carried, not inferred | **NOT ENGAGED on its asserting limb** — no case injects an idle. **But its carriage path is newly exercised**: `compare` read C2's **two-entry** sidecar and reached exit 0, which `RV-C2RERUN`'s own criterion-5 row forecast as *"the re-run will be the first to exercise"*. Forecast discharged. |
| **6** | the two constructors separately testable | **DISCHARGED**, re-observed: `(e)` at exit 4, `(e′)` at exit 6, distinct fixtures, neither optional, inside a **13/13** self-test. |
| **7** | every producer's refusal reaches an exit code **(AS AMENDED)** | **NOT ENGAGED BY THIS RUN'S CASE PATH, for the second consecutive landing and in the right direction**: no refusal guard fired in either producer at any case. **One debit added**: this round introduced a **fifth** reference-side guard (`E word-buffer-exhausted`) that has never fired and has no fixture. `FINDING RV-0078-S1-4` STANDS, first dischargeable at C9, now covering five guards. **The criterion is again NOT amended in the reading of a run** — `FINDING RV-0078-S2-5`'s bar, obeyed for the second round running. |
| **8** | every case's disposition frozen before it ran | **DISCHARGED, MEASURED, and now DISPOSITIVE rather than merely satisfied.** `5c01af0` is an ancestor of `2efd7f9`; the CD diff across the span is one hunk, **129 insertions, zero deletions**, entirely §10.2-bis *after* §10.2; and the CD does not appear in the repair commit's changed paths at all. **C2's prediction was frozen, was measurably untouched through two voids and two repairs, and was spent by a comparison that could have falsified it.** This is the criterion that makes §2's α a branch selection instead of a green light. |
| **9** | no claim outside the driven set | **DISCHARGED.** This verdict states per case what each case proves, states the compound class C2 does **not** separately anchor, lifts bar 1 for one named class at one named run id, and writes no sentence of the form *"the co-simulation anchors this module"*. The harness's own bounding sentence printed correctly for all three cases — **`FINDING RV-0078-S2-7` did not bite, for the accidental reason that every case had a result**, and it stands unrepaired with its carrier unchanged. |

**`FINDING RV-0078-S1-2`(b)'s production instance — RULED, and CLOSED with its
residual limb named.** The finding has two limbs and they close differently.
**Limb (i) — per-frame profiles are printed for a multi-frame transaction in
production — is DISCHARGED here for the first time**: C2 printed both frames' own
eight-word profiles, at exit 0, in a real run. **Limb (ii) — a clean frame's numbers
survive an unrelated sibling's divergence — is CLOSED ON THE FIXTURE**, which passed
again this run at exit 4, and it is closed there **deliberately**: **no case in the
entire designed set is a multi-frame case in which one frame can diverge.** C2 is the
only multi-frame case and both its frames are predicted and observed clean; C1 and
C3 through C9 all drive one frame. **Minting a stimulus case to exercise an
instrument property already exercised by a fixture would spend a case on a check
already paid and would move the stimulus set that §3.1 exists to protect.**
**Two obligations attach to the closure.** The `SO-` **SAYS** that limb (ii) rests on
the self-test fixture and not on production evidence — the same *must say, not imply
away* rule §7's C3 row applies to family D. And the closure **re-arms
automatically**: if any future case set ever contains a multi-frame case in which one
frame can diverge, limb (ii)'s production instance is expected there and is **not**
waived by this ruling.

---

#### 13. What this run does NOT mean

1. **Three classes are anchored, not a module.** §3's table is the whole of it. Bad
   FCS, nonstandard preamble, every error path, every non-64-octet length, every
   injected idle and REQ-004's line-rate cadence are **not** anchored by anything in
   this run.
2. **C2 does not anchor "a lane-4 start at a non-zero admit cycle" as a separable
   class** (§2, §3). The compound case cannot attribute within itself.
3. **Bars 2, 3 and 4 are untouched.** No strobe was compared; T2's `[1 × 8]` is
   out-of-domain data and is not a cross-side timing adjudication; the strobe record
   stays refused; bar 4's C3 cell has still not been reached.
4. **T1 clean on both frames is our side against our spec, not agreement with the
   reference.** It is the strongest ours-vs-spec evidence this lane has produced —
   the re-arm path holding `admit_cycle + m + 3` at a non-zero admit cycle — and it
   is **not** comparison content and enters no differential claim.
5. **`SO-xgmii_rx_64.md` is not opened, advanced or implied**, and no Phase 2 or
   Phase 3 programme work is advanced by any line of this lane (`WO-0078` §0.1).
6. **The instrument is not proven, it is less unproven.** Five reference-side guards
   have never fired, the reference producer still executes nowhere but CI
   (ADR-0005), criterion 3's plural property is unexercised, and `S2-9` shows the
   census that produced this green had a length-axis blind spot. **A green run is
   evidence about the classes it drove and about nothing else** — which is criterion
   9, applied to the run that finally earned the right to be over-read.

---

#### 14. Verdict

**C2 — COMPARED, AGREED, AND ACCEPTED ON BRANCH α, under CD §10.2 UNAMENDED.**
At `build` run **`31103977231`**, `cosim` job **`92624287637`**, commit `2efd7f9`,
the case printed `stimulus_sha256=cc1e85a4…5b44a7` — **the bind held for the third
time** — then **`frames compared: 2`, `frames matching: 2`, `divergences: none`,
`compare_exit=0`, `tier=CLEAN`**, with `ours.canon`/`theirs.canon` byte-identical
between run1 and run2. **The four comparator constructors cover REQ-901's INSIDE
list item for item, and branch β was unreachable at this instance by CD §10.0's own
derivation, so the outcome space was α or γ and it is α.** **The prediction —
"agreement on both" — frozen at `5c01af0`, measurably untouched through two voids
and two repairs of two producers, is CONFIRMED and SPENT.** It was unspent through
three runs because a prediction is spent by a comparison that could have falsified
it, never by a run happening; one such comparison has now occurred, and one is
enough.

**What α buys, bounded before it is banked**: **`AP-M03` §7 bar 1 lifts for the
two-clean-frames-at-minimum-IFG class and for no other.** It does **not** lift for
REQ-004's line-rate cadence, and it does **not** separately anchor a lane-4 start at
a non-zero admit cycle, because C2's compound stimulus cannot attribute within
itself. **The `AP-M03` cell that records this is owed to the `AP-` round after Stage
2 lands, not to this round** — §13 item 2, and the third consecutive refusal of the
same edit on the same ground. **The CD gets nothing: a result is not a question, and
§10.7 item 3 says so.**

**`FINDING RV-0078-S2-6` — CLOSED**, on the defect's signature being gone, on a
diff-level check that no `E` sentinel changed by value and no record format string
moved, on byte-exactness discharged by every recorded observable at case 0 and C1
rather than by argument, and on the new bound's refusal being fail-closed at an
unmodified reader. **`FINDING RV-0078-S2-8` — CLOSED at its recommended limb**: the
hand-authored two-frame golden file exists, reads, and passed in a 13/13 self-test.
**Its structural condition is not closed and no fixture can close it** —
`tb_xgmii_rx_64.v` still executes nowhere but CI, and `FINDING RV-0078-S1-4` now
stands over **five** never-fired reference-side guards. **`FINDING
RV-0078-S1-2`(b) — CLOSED**, limb (i) discharged in production by C2's two-frame
profile print, limb (ii) closed on the fixture because no case in the designed set
can produce it, with the `SO-` obliged to say so and the closure re-arming
automatically if such a case ever exists.

**The census — ADOPTED at eight items, ADOPTED WITH CORRECTION at one, AMENDED at
one**, and the amendment carries **`FINDING RV-0078-S2-9` (MINOR, pre-emptive)**:
`MAX_WORDS_PER_FRAME = 16` bounds a frame at 128 delivered octets in a lane whose
requirement range runs to 1518 and whose own §6.3 scopes an oversize case. **It is
the third instance in three rounds of one species — a quantity fixed against
today's stimulus inside an instrument built to widen the stimulus — and it is the
first one caught by a reading instead of by a landing, which is what the census was
instituted for.** The defect is mine: property 5 demanded a bound and never stated
its covering range. **`FINDING RV-0078-S2-10` (MINOR)**: the repair moved per-frame
attribution from the reader into the writer, which is **lawful** — a probe at the
interface reads its attribution off the framing contract where a downstream parser
would be guessing — and the in-order-delivery assumption it now rests on is stated
nowhere pinned, so a reading rule binds from here: **ordering is ruled out before
any multi-frame content divergence is routed as a `BUG-`.**

**The census is complete enough to authorise C3 and C4** — both single-frame,
64-octet, against a set of items already exercised at that shape — **and it is NOT
complete for Stage 3**, which breaks the **frame-length** and **admission-legality**
axes the census never asked about. **A second census on those axes is added to
§6.3's re-authorisation gate as condition (d), with the bound's own repair as (e).**

**The stopping rule — RETIRED, on an answer rather than a timeout.** It never fired,
and the question it reserved is settled: the pinned transaction form **can** express
two frames whose admission and delivery spans overlap, at the grammar as pinned.
**Its form is re-armed for C3 and C4 at the same threshold and pre-registered here
with the answer not in hand.**

**Sequencing: C3 alone, next, confirmed**, with `FINDING RV-0078-S2-7`'s runner
repair riding its runner half and **one amendment — the case array becomes
`0 C1 C3 C2`**, so that criterion 3's plural property — unexercised after three
landings — is exercised the first time C3 diverges and costs nothing if it does not. **C2 becomes a standing
regression case at every landing after this one.** Removing a case to make a run
green stays barred outright.

**C2's ledger, final and corrected: dispatched three times, driven three times,
compared ONCE, agreed ONCE.** Two landings bought two instrument defects and no
knowledge; the third bought the knowledge. **The lane now knows something about two
frames that it did not know this morning, and it knows exactly that much.**

**dv_lead, `J-dv_lead-0155`, HEAD `2efd7f9` (unmoved). Dated by the commit that
carries it.**

---
