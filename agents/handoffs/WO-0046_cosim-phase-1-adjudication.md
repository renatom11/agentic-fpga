# WO-0046 co-simulation, Phase 1 — what the green job discharged and what it did not

- **Type**: adjudication memo, dv_lead. Adjunct to `WO-0046_cosim-phase-1.md`;
  not a new work order and not a sign-off.
- **Author**: dv_lead. **Date**: 2026-08-09. **Tree**: `d2bdd57`.
- **Owed by**: `RV-0068B-VERDICT` §10 — *"the adjudication of what Phase 1 did
  and did not discharge is an item I owe, from committed artefacts, not a bench
  I commission."* **Discharged here rather than dated forward**, because an
  undated carrier is how a debt becomes a habit and this one needs no run to
  settle: every input below is a committed artefact at `d2bdd57` or an
  externally verifiable CI run id.
- **Sources**: `test/attack_plans/CD-xgmii_rx_64_cosim.md` (FROZEN for Phase 1);
  `docs/specs/requirements.md` REQ-901 and its §13 change-log rows;
  `test/cosim/stimulus_gen.ml`; `tools/cosim/run_cosim.sh`;
  `.github/workflows/build.yml`; `test/attack_plans/AP-xgmii_rx_64.md` §7;
  CI `build` run **30988038809** at `2dbd39b`, job **92247281222** (`cosim`),
  conclusion **success**.

---

## 1. The run, stated before anything is concluded from it

`build` run **30988038809** carries two jobs. `92247281175` (`build`) succeeded
and `92247281222` (`cosim`) succeeded. The `cosim` job is a **separate job, not a
step of `build`** (R-CI-1), and its `continue-on-error` came off after run
`30830553582`, so from that commit a `cosim` failure fails the build. The job
runs one command: `tools/cosim/run_cosim.sh`.

**The green is real and it is not the anchor.** The rest of this memo is the
difference.

## 2. What Phase 1 actually drove — from the generator, not from the plan

`test/cosim/stimulus_gen.ml` is the whole of Phase 1's stimulus:

- **one** frame, `Dv_xgmii.Frame.stress_frame ~sequence:0 ()` — SPEC-M03 §8's own
  64-octet frozen stimulus frame with a correct FCS;
- `Dv_xgmii.Arrival.create ~first_start:0 [ octets ]` — start character at octet
  time **0**, i.e. **lane 0**;
- `Arrival.check` asserted empty before a byte is written;
- 24 drain cycles appended.

So the driven stimulus class is: **one clean 64-octet good-FCS frame, one start
lane, that lane being 0.**

## 3. The three checks, and what each of them is

`tools/cosim/run_cosim.sh` §"THE THREE CHECKS":

| # | check | what it establishes |
|---|---|---|
| **4.1** | differential comparison — §2's frame into both `Xgmii_rx_64` and the vendored `axis_xgmii_rx_64`, reduced to canonical transaction files and compared under REQ-901 | the two implementations agree on this frame |
| **4.2** | deliberate-mismatch self-test, `compare --self-test`, **in the same binary as 4.1** | the comparator can report a difference — *"a comparator that has only ever agreed is worth nothing"* (CD §8) |
| **4.3** | two-run determinism — the whole pipeline against the same recorded stimulus and the same built simulator, both canonical files byte-compared | CD §4's pinned-input reproducibility, exercised rather than asserted |

## 4. DISCHARGED — stated as narrowly as the evidence supports

1. **The bridge exists and works end to end.** Stimulus generation, our
   elaboration and drive, `iverilog`/`vvp` against the vendored reference, both
   sides reduced to CD §3's canonical transaction form, compared, with the
   sidecar/hygiene constraints of CD §7 (R-CI-5) honoured on every exit path.
2. **The comparator can fail.** Check 4.2, in the production binary.
3. **Pinned-input reproducibility holds**, under its full antecedent (pinned
   reference SHA, recorded simulator version, recorded stimulus, same runner
   image). Check 4.3. CD §4 is explicit that this is **weaker than REQ-902** and
   must never be summarised as a determinism claim about the reference.
4. **REQ-901's comparison content agrees on one frame in one class**: payload
   octets, the `tkeep` extent of each word, `tuser`[0] on the `tlast`, and the
   accept-or-discard decision — the operative list, per CD §0-bis item 1, which
   supersedes CD §5.1's narrower table. CD §8's own expected instance is 60
   delivered octets, final `tkeep` = 0x0F, `tlast` on word 7, not marked invalid,
   8 words.

**That is the whole of it.** Four things, all of them about the lane's
machinery plus one frame.

## 5. NOT DISCHARGED — and the list is longer than the last one

1. **The charter §3 external anchor for `SO-xgmii_rx_64.md`.** Charter §3:
   *"Phase 1 MAC/UDP sign-off REQUIRES differential co-sim vs verilog-ethernet;
   no Phase 1 SO- PASS without it."* A run against one frame in one class anchors
   that class. It does not anchor a module.
2. **Lane 4 has never been driven at this boundary.** Phase 1's `~first_start:0`
   is a lane-0 start, and lane 4 is where every quantity SPEC-M03 §7 pins takes
   its *other* value. The co-simulation has produced no evidence at the start
   lane that half of this module's stimulus space uses.
3. **V1–V7 are unprobed, all seven.** CD §6's own "confirmed by" column
   distributes them: **V6 and V7 at Phase 2**, **V1–V5 at Phase 3**. CD §6's
   correction block says so in terms — *"Phase 1 drives one 64-octet good frame
   and probes none of V1–V3"* — and the same is true of V4–V7 by construction,
   since none of their stimulus classes is a clean 64-octet frame. **Phases 2 and
   3 are neither specified nor scheduled**, and they are the longest-lead item in
   this module's sign-off.
4. **X-1's computed outcome model is not anchored by this run.**
   `AP-xgmii_rx_64.md` §7's standing limit is about X-1(ii) — the computed
   §9 outcome per *injected* frame. **Phase 1 injects nothing.** A run whose
   stimulus contains no injected frame cannot anchor a model whose subject is
   injected frames, in any of its cells.
5. **Nothing about latency, ΔC or per-octet constancy.** CD §5.2's **X1**
   excludes all cycle timing, latency and word-to-word spacing from the
   comparison, because REQ-901's comparison is transactional by construction.
   **So family L's constants — L = 16 / 12, ΔC = 3 — are outside this lane
   permanently, not merely unprobed**, and `WO-0070` derives them from the
   specification for exactly that reason.
6. **Nothing about strobe identity or pinned cycles.** CD §5.2's **X2**, and
   CD §2-bis's better ground: *"Strobes are not in [REQ-901's comparison content]
   at all."* The strobe half of X-1's model rests on the specification and hand
   derivation alone, and the `SO-` must say so in its own words.

## 6. A FINDING against my own frozen document: CD §0-bis's "EMPTY" is stale

CD §0-bis (`J-dv_lead-0052`) closes with:

> **For the M03 pairing the permitted-divergence set is EMPTY.**

**That sentence is no longer true as a statement about the pairing, and the same
document records why.** REQ-901 gained classes **(e)** and **(f)** — runt marking
and oversize truncate-and-mark at the M03 boundary — by spec diff at `ebb3f49`,
countersigned, and CD's own §2-bis carries the resolution block naming them. So:

| statement | truth at `d2bdd57` |
|---|---|
| "for the M03 **pairing** the permitted-divergence set is empty" | **FALSE.** It contains (e) and (f) |
| "for the **64-to-1518-octet range** at this boundary the permitted-divergence set is empty" | **TRUE**, and it is REQ-901's own sentence: *"Classes (e) and (f) exclude nothing in the 64-to-1518-octet range"* |
| "for **Phase 1's own domain instance** the permitted-divergence set is empty" | **TRUE**, because §2's frame is 64 octets and therefore inside that range |

**So the operative fact for Phase 1 is unaffected** — the run compared under an
empty permitted set, correctly — **and the sentence that states it is wrong at
the scope it is written at.** The defect is one of scope, not of arithmetic, and
it is the same left-standing-summary class this programme has now paid for at
`RV-0039-VERDICT` F-2, at `AP-xgmii_rx_64.md` §7's staleness banner, and at
`bench.mli`'s own header.

**It has propagated.** `tools/cosim/run_cosim.sh`'s check-4.1 comment reads
*"For M03 the permitted-divergence set is EMPTY (CD-xgmii_rx_64_cosim.md
§0-bis)"* — a second file carrying a sentence that is true of the frame it drives
and false of the boundary it names. A future phase driving a runt through this
same script would read that comment and mis-adjudicate its own result.

**Repair, and it is a dated annotation beside §0-bis, never an edit inside it.**
CD is FROZEN for Phase 1 and CD §9's change discipline requires every change to
state the section, what moved, the justifying clause, and whether a run has
probed the area. A run **has** probed the area — Phase 1's own — so the entry may
not move outward; but §0-bis's statement is not moving outward, it is being
**narrowed to the scope it was always true at**, which §0's rule permits and
§9 requires be recorded. The same annotation is owed at `run_cosim.sh`'s comment.

**Carrier**: the batched `AP-` round (`RV-0068B-VERDICT` §9 item 1), which is the
next commit that opens `test/attack_plans/**`, plus `tools/**` for the script
comment. `WO-0070` §14 item 3 carries it forward so it cannot evaporate.

## 7. A SECOND FINDING, against `AP-xgmii_rx_64.md` §7's own wording

§7's banner says:

> **no `SO-xgmii_rx_64.md` PASS may rest on the model until it has run.**

**"Until it has run" is too coarse, and Phase 1 is the counterexample that shows
it.** The co-simulation *has run*. Read literally, the condition is satisfied and
the standing limit is discharged — which is plainly not what the sentence means
and not what the evidence supports (§5 item 4: Phase 1 injects nothing, so it
anchors no cell of X-1(ii)).

**The condition the sentence should state**: *no `SO-` PASS may rest on a
computed outcome of X-1(ii) for a stimulus class the differential co-simulation
has not driven.* That is per-class, it is checkable, and it makes the phase
distribution of CD §6 the schedule for discharging it rather than a list of
predictions. **Finding against my own text**, carried to the same `AP-` round.

## 8. RULING

> **The charter §3 external anchor for `SO-xgmii_rx_64.md` is NOT discharged by
> build `30988038809`.** Phase 1 discharged the lane's machinery, its
> comparator's ability to fail, its pinned-input reproducibility, and REQ-901's
> comparison content on **one clean 64-octet good-FCS frame at a lane-0 start**.
> The anchor is discharged for that class and for nothing else.
>
> **The standing precondition is unchanged in force and sharpened in wording**:
> no `SO-xgmii_rx_64.md` PASS may rest on a computed outcome of `Injection`'s
> model for a stimulus class this lane has not driven. Phases 2 and 3 remain
> unspecified and unscheduled and are this module's longest-lead sign-off item.
>
> **Nothing in this memo blocks family L, K or M.** `WO-0070` §13's `BL3` keeps
> family L from becoming gated by taking an expected value from the model; the
> co-sim could not anchor L's constants in any case (§5 item 5).

## 9. What would discharge more of it, in the order that buys most per round

1. **Lane 4, same clean frame.** One line in `stimulus_gen.ml`
   (`~first_start:4`), no new machinery, and it closes §5 item 2 — the start lane
   at which every §7 constant differs.
2. **Phase 2 as CD §6 distributes it** — **V7** (bad FCS) and **V6**
   (nonstandard preamble). V7 is the one CD §6 flags to watch: if the reference
   drops bad-FCS frames, family D's entire subject matter is outside the
   comparison domain and REQ-104's verification rests on family D's
   mutation-qualified bench alone — *"which is a perfectly good place for it to
   rest, but the `SO-` must say so rather than imply the co-sim covered it."*
3. **Phase 3** — V1–V5, i.e. the length-derived and abort classes. Note that
   REQ-901 classes (e) and (f) already bound what Phase 3 can return there:
   `tuser`[0] is excluded on 5-to-63-octet frames and an over-1518-octet frame is
   excluded entirely, **so V1's and V3's marking halves are not anchorable by
   this lane at all** — while family F's core observable, REQ-103's FCS removal
   on a runt, **remains anchorable** (CD §2-bis's resolution block, on the
   reference's length-gate-free residue array).

**None of the three is commissioned by this memo.** Sequencing them is a
scheduling decision that belongs beside the row queue, and `RV-0068B-VERDICT`
§10's read stands: **the co-sim lane should run beside the row work, not after
it.**
