# WO-0084 — M04 mutation manifest (act 2, the seeding): thirteen genuine defects in `xgmii_tx_64`, seeded BLIND against the seal

- **Author**: auditor (`J-auditor-0027`), spawn: orchestrator dispatch WO-0084 act 2
- **Commission**: `agents/handoffs/WO-0084_m04-mutation-campaign.md`
- **Module under attack**: M04 `Xgmii_tx_64` ·
  `libs/hardcaml_ethernet/src/xgmii_tx_64.ml`
- **Base SHA the diffs apply against**: **`9dba6d5b3f2844f914220c896ca11762e4ca1c1a`**
  (HEAD of `claude/fpga-hardcaml-agent-orchestration-37ceyf`, the commit that froze
  the seal). Verified byte-identical to the seal's declared base state **`6d92bf9`**
  and to **`91f005d`** for this file:
  `git diff 6d92bf9 9dba6d5 -- libs/hardcaml_ethernet/src/xgmii_tx_64.ml` is empty,
  as is `git diff 91f005d 9dba6d5 -- …`. So a diff that applies at `9dba6d5` applies
  at the `mut/` refs act 3 cuts from the seal base.
- **State**: **manifest delivered — the thirteen never-merge refs are NOT cut and no
  diff has been run.** Act 3 (the orchestrator/operator) cuts one ref per class and
  runs CI; act 4 (dv_lead) scores. This file is the seeding half only: it carries no
  run id, no kill/survive result, no scorecard. A manifest predicts a mechanism; a
  run measures it (CI is the authority, ADR-0005).
- **Count**: **thirteen classes** (`class-01` … `class-13`), spanning the discharged
  families **A, B, C, D, E, F, G**, one unified `.diff` each.

---

## 0. The blind — attested affirmatively, with every exposure disclosed

The blind runs one way and against this seat (packet act 2): **I did not open the
seal, and I did not open dv_lead's sealing journal entry.** A seeder who knows the
predicted kill set can choose a defect site that satisfies it; the campaign's whole
value is that I cannot.

**Not read, absolutely — no open, no `grep`, no `git show`, no line count, no diff
stat:**

- `agents/handoffs/WO-0084-SEALED-predictions.md` (the seal file).
- `J-dv_lead-0195` and the whole of `agents/journals/claude_dv_lead_agent.v12.md`
  (the seal's second copy).
- **All of `test/xgmii_tx_64/**`** — bench, monitors, expect-tests. A seeder that
  reads the bench can craft defects the bench happens not to see; a seeder that reads
  only the spec and the RTL seeds what the spec forbids, which is the point.

**Read for this campaign, and nothing else that bears on it:**

| # | path | extent |
|---|---|---|
| 1 | `agents/charters/auditor.md`, `agents/PROTOCOL.md` | in full — mandatory first actions |
| 2 | `agents/handoffs/WO-0084_m04-mutation-campaign.md` | in full — my packet |
| 3 | `libs/hardcaml_ethernet/src/xgmii_tx_64.ml` | all 434 lines at `9dba6d5` — the mutation target |
| 4 | `docs/specs/modules/xgmii_tx_64.md` (SPEC-M04) | in full — the requirements the defects violate |
| 5 | `test/attack_plans/AP-xgmii_tx_64.md` | §0–§4 (the row tables through family K): the **public** Kills-claim TEXT the packet allows — the claims under test. **The predictions are not public and were not sought.** |
| 6 | `docs/reports/audit/WO-0077-mutations/README.md` | its head only, for form/precedent |
| 7 | `agents/journals/claude_auditor_agent.v03.md` | my own journal only — the entry-id chain (`grep` of headers) |

**The one seal fact I was told, and why it is not a leak (packet, seal §0.1 /
standing rule 9).** The base's `build` JOB conclusion is `failure` on **step 10**
(DV mechanical checks) alone, because WO-0084's packet forward-cites this directory
before it exists; the DV **suite** (step 6, "Run tests") is GREEN. Acts 3 and 4 score
**step 6, never the job**. This is a property of the base state, not of any
prediction. Creating this manifest directory is what clears that forward citation.

## 1. Derivation — my own class set, independently, not dv's partition

The packet tells me dv sealed **13 classes across families A–G from 34 discharged
ASSERT rows**, and instructs me **not** to reverse-engineer or match dv's partition:
*"seed against the SPEC's defect space and the AP's public claims. A mismatch in count
or partition between your manifest and dv's seal is itself data act 4 will reconcile."*

Accordingly every class below is derived from **SPEC-M04's requirements** and the
**public Kills text** of a discharged `AP-M04` ASSERT row — never from any prediction.
The arrival at thirteen is a coincidence of independent derivation, not an attempt to
align: I picked the cleanest genuine representative of each distinct defect class the
plan's discharged families claim to kill, and thirteen fell out. Where the AP text
names several distinct kills inside one family (C names pad-target, pad-value and
CRC-coverage as three separate wrong designs; E names terminate-lane and idle-fill;
F and G name two each) I seeded each distinct class, so families are not seeded
uniformly and are not meant to be. dv's count, partition and my own are three
measurements act 4 reconciles.

**Every seed is a genuine spec violation with a port-observable consequence** — none
is an equivalent mutant (§3 records the observation that separates each from a
conformant M04), and each is **type-correct OCaml/Hardcaml** so it compiles and the
**test suite**, not the compiler, is the instrument under test.

## 2. The thirteen classes

Each row: the class id and its `.diff`; the SPEC-M04 requirement the defect violates;
the **public** `AP-M04` row(s) whose Kills claim the seed tests; the RTL site (line
at `9dba6d5`); and the injected defect. The "AP row(s) tested" column names the row
whose public claim asserts a conformant design is distinguishable from this defect —
it is **not** a prediction of the seal's disposition, which I have not seen.

| Class / diff | REQ violated | AP row(s) tested (public Kills claim) | RTL site (L@9dba6d5) | Injected defect |
|---|---|---|---|---|
| **class-01** `preamble-txc` | REQ-201, §6.3 item 2 | M04-A1 (*"marking … as control, which a checker reading only `xgmii_txd` cannot see"*) | 136 (`preamble_word`) | SFD lane (7) control bit `gnd → vdd`: `xgmii_txc` on the preamble word becomes `0x81`, not `0x01` |
| **class-02** `frame-lane-reversal` | REQ-012, REQ-021 | M04-B1 (*"Lane reversal within a word"*) | 280 (`body_word` payload octet) | payload octet select reversed: lane `j` emits source octet `7 − j` |
| **class-03** `tkeep-ignored` — active diff **`class-03-tkeep-ignored.v2.diff`** (v1 `class-03-tkeep-ignored.diff` **superseded — non-compiling**, §6) | REQ-011 | M04-B2, M04-C4 (*"transmitting the whole final word"*) | **198 (`held_keep`)** — v1 site was 211 (`held_count`) | `held_keep` sourced from constant `ones 8` instead of `i.tx.tkeep`: `tkeep` is ignored, the last-word octet count is always `8`, and the poison/short-word octets are transmitted. Identical wire behaviour to v1's intended constant-`8` count, but `held_keep` stays consumed (line 211's `popcount`), so the module compiles (§6). |
| **class-04** `pad-target-64` | REQ-203 | M04-C1, M04-C2 (*"padding to 64 rather than 60"*) | 85 (`pad_target`) | pad target `60 → 64`: pads to 64 octets before the FCS |
| **class-05** `pad-value-nonzero` | REQ-203 | M04-C1, M04-C4 (*"padding with 0xFF"*) | 283 (`body_word` pad octet) | pad octet value `zero 8 → ones 8`: pad octets are `0xFF` on the wire (CRC still covers them as zero) |
| **class-06** `crc-omits-pad` | REQ-202, REQ-203 | M04-C3 (*"closes the CRC at `tlast` and pads afterwards"*) | 225 (`crc_count`) | CRC coverage keyed on `d_payload` not `d_pad`: pad octets are **not** covered — FCS equals the ref over the unpadded frame |
| **class-07** `fcs-byte-reversed` | REQ-202 (§6.1 item 4) | M04-D1 (*"A byte-reversed FCS"*) | 266 (`fcs_octets`) | FCS octets emitted MSB-first (`k → 3 − k`): the exact wire-order defect REQ-202's sentence forbids |
| **class-08** `terminate-lane-late` | REQ-205 | M04-E1, M04-E3 (*"off-by-one … leaves a stale octet at lane `t`"*) | 275 (`is_term`) | terminate comparison `==: d_term → ==: (d_term +:. 1)`: `/T/` one lane late, `/I/` where `/T/` belongs |
| **class-09** `idle-fill-value` | REQ-205, §6.3 item 2 | M04-E2 (*"leaving the previous word's data … `/I/`'s value is normative"*) | 287 (`body_word` fill octet) | terminate-word fill lanes carry `0x00`, not `/I/` `0x07` (control bit still set) |
| **class-10** `gap-no-roundup` | REQ-204 | M04-F1, M04-F4 (*"one word of gap"* / never-shortened) | 299 (`gap_words`) | round-up term `+:. 7 → +:. 0`: `g = ⌊(ifg+t)/8⌋`, gap 8 octets at the default instead of 16 |
| **class-11** `gap-ignores-ifg` | REQ-204, REQ-802 | M04-F3 (*"ignoring `cfg_ifg` and hard-wiring 16"*) | 299 (`gap_words`) | `cfg_ifg` replaced by constant `12`: identical to conformant at the default gap, wrong only when the bench **varies** `cfg_ifg` (distinguished at F3's members 20 and 255) |
| **class-12** `underflow-qualifier-dropped` | REQ-206, §7's C-16 | M04-G4 (*"the requirement read to its first full stop"*) | 350 (`underflow`) | drops `&: ~:last_accepted`: a false `error_underflow` strobe at `C+8`, the post-`tlast` cycle the qualifier exists to exclude |
| **class-13** `abort-word-swapped` | REQ-206, §9 | M04-G1 (*the §9 underflow-word shape*) | 149/151 (`abort_word`) | `/E/` and `/T/` swapped between lanes 0 and 1: the abort word is `/T/ /E/`, not `/E/ /T/` |

## 3. Why each is genuine (the observation that separates it from a conformant M04)

A seed that no conformant observation can distinguish is an equivalent mutant and is
worthless. Each class below names the port-visible consequence, so act 4 can see the
row could have gone red.

- **class-01** — the preamble word's `xgmii_txc` is `0x81`; a bench that decodes only
  `xgmii_txd` is blind to it, which is exactly why A1 names it. Observable on the
  control lanes.
- **class-02** — with a position-dependent filler (B1's own stimulus), frame octet `j`
  lands at lane `7 − j`; invisible only under uniform filler, which B1 forbids.
- **class-03** — a `P = 20` frame's last word puts four poison octets (positions 4–7)
  on the wire that a conformant M04 masks; observable at wire indices 20–23.
  (**v2** renders this by forcing `held_keep = ones 8` at line 198, so `popcount` is
  `8` on every last word — the same wire consequence as v1's intended constant-`8`
  `held_count`, but with `held_keep` still consumed. §6 records the v1→v2 correction.)
- **class-04** — `F = 68` not 64: the terminate lane, the octet count and the
  pre-FCS octet count all move.
- **class-05** — wire pad octets are `0xFF` where REQ-203 requires `0x00`; the FCS is
  still the zero-pad value, so the two disagree on the wire.
- **class-06** — the four wire FCS octets equal the ref CRC over the **unpadded** 20
  octets, not over the padded 60 — C3's negative clause.
- **class-07** — the four FCS octets are in reversed byte order; the REQ-305 oracle
  comparison (obligation 2) sees it directly, and REQ-304's residue goes non-constant.
- **class-08** — `/T/` at lane `t+1`, `/I/` at lane `t`; at `t = 7` the terminate
  vanishes from the word entirely.
- **class-09** — fill lanes read `0x00`; `/I/`'s value is normative (§6.3 item 2), so
  a bench asserting the value (not only the control bit) reddens.
- **class-10** — the measured gap is 8 octets at the default `cfg_ifg`, below the
  12-octet floor and off REQ-204's 16.
- **class-11** — **conditional**, and stated so: identical to conformant at
  `cfg_ifg = 12`, divergent (gap 16 vs 24, 256) only when the bench drives
  `cfg_ifg ∈ {20, 255}`. This seed is a direct test of whether the suite **varies**
  the gap configuration; if it only ever drives the default, this survives — which is
  a coverage fact, not a defect in the seed.
- **class-12** — `error_underflow` pulses at `C+8` on a frame that transmits intact;
  G4 asserts the strobe is 0 on every cycle of that run.
- **class-13** — the underflow word is `/T/` in lane 0 and `/E/` in lane 1; a decoder
  checking §9's `/E/`-then-`/T/` shape reddens.

## 4. How the operator applies a class (act 3)

Each diff is a `git apply`-ready unified diff against the module at the base SHA. For
class `NN`, on a never-merge ref cut from the seal base:

```sh
git checkout -b mut/wo-0084-<class> 6d92bf9        # or 9dba6d5 — identical for this file
git apply docs/reports/audit/WO-0084-mutations/class-NN-<slug>.diff
# build + run the DV suite; read step 6 ("Run tests"), never the job conclusion (§0)
```

The operator never edits a diff: a diff that fails to apply is a **finding**
(F-0022-1's drift class), not something to fix. Each diff is stand-alone against the
pristine module — apply exactly one per ref.

**Verification performed before delivery (read-only, tree never modified):**

- `git apply --check` passes for all thirteen at `9dba6d5` (the working tree, which
  equals the base for this file).
- Each diff's anchor string is **unique** in the module (single-match), so the hunk
  cannot mis-place.
- Each mutation is type-correct by construction (same-width `Signal` / same-type `int`
  substitutions), so the module compiles and the suite is the instrument.

> **Correction (2026-08-12, §6).** The third bullet's *"so the module compiles"*
> clause was **falsified for class-03 v1**. That diff applies clean (`git apply
> --check` green) but does **not** compile: it replaced `held_count = uresize
> (popcount held_keep) position_bits` with a constant, removing the **sole**
> consumer of `held_keep` (its only use in the module), and the resulting unused
> `let` binding is fatal under the project's dune dev-profile warnings-as-errors.
> The operator run recorded step-5 Build FAILURE / step-6 skipped
> (`J-orchestrator-0281`); dv scored it UNSCOREABLE / MANIFEST DEFECT, IC-2 left
> untested (`J-dv_lead-0196`, finding WO-0084-S3). The other twelve diffs are
> unaffected — the attestation stands for them. class-03 **v2**
> (`class-03-tkeep-ignored.v2.diff`) restores the clause: `git apply --check`
> green at `712002f` (file byte-identical to base `9dba6d5`), `held_keep` stays
> consumed (line 211), and `ones 8 : Signal.t` width 8 matches `i.tx.tkeep`'s
> width, so the module compiles. Not operated as a campaign mutant this round.

## 5. What this manifest does not carry

No scorecard, no run id, no CI conclusion, no `cosim` conclusion, no kill/survive
disposition, and no claim that any class *does* die — those are act 3's runs and act
4's scoring, against the seal, never against my expectation. Nothing here is a
prediction: the "AP row(s) tested" column names a **public** claim, not the sealed
disposition, which I have not seen. A survivor, if any, is a finding act 4 routes with
the survivor-evidence form; a mismatch between my thirteen and dv's thirteen is data
act 4 reconciles.

---

## 6. Correction record — class-03 v1 did not compile; v2 is the cure (2026-08-12)

This is a correction to **my own artifact** (this manifest), landed under the same
discipline my posture-list self-corrections use: the record shows the defect and its
cure, dated, and **nothing is silently overwritten**. The v1 diff file
(`class-03-tkeep-ignored.diff`) is left **byte-untouched** — it is the frozen
historical artifact the operator ran and dv scored, and their citations of it stay
valid. The corrected diff is added **beside** it as `class-03-tkeep-ignored.v2.diff`,
now the **active** class-03 diff.

**What was wrong (v1).** `class-03-tkeep-ignored.diff` replaced, at line 211,

    let held_count = uresize (popcount held_keep) position_bits in
with
    let held_count = of_int ~width:position_bits 8 in

That is behaviourally the intended class — last-word octet count forced to `8`,
`tkeep` ignored — but line 211 is the **sole consumer of `held_keep`** in the module
(`held_keep` appears only at its definition, line 198, and at this popcount). Removing
it orphans the `held_keep` binding, and an unused `let` binding is **fatal** under the
project's dune dev-profile warnings-as-errors (warning 26). So the mutated module
**fails to build**: the diff *applies* clean but does not *compile*. The operator's run
recorded **step-5 Build FAILURE, step-6 (Run tests) skipped** (`J-orchestrator-0281`),
and dv ruled it **UNSCOREABLE / MANIFEST DEFECT** with **IC-2 left untested**
(`J-dv_lead-0196`, finding **WO-0084-S3**). This **falsified §4's attestation** —
*"each … type-correct … so the module compiles and the suite is the instrument"* —
**for class-03, and only class-03**; the other twelve diagnostics stand.

**The cure (v2).** `class-03-tkeep-ignored.v2.diff` moves the injection to the **keep
source**, line 198:

    let held_keep = hold 8 i.tx.tkeep in
becomes
    let held_keep = hold 8 (ones 8) in

- **Compiles.** `held_keep` remains **consumed** at the unchanged line 211
  (`popcount held_keep`), so no binding is orphaned — v1's exact failure is cured.
  Dropping the read of the `i.tx.tkeep` record **field** raises no warning (record
  fields are not bindings; `i` and `i.tx` remain heavily used). `ones 8 : Signal.t` of
  width 8 matches `i.tx.tkeep`'s width, so `hold 8 (ones 8)` type-checks exactly as
  `hold 8 i.tx.tkeep` did. `ones` is in scope (used at line 242).
- **Same live defect, same class (IC-2).** `held_keep = ones 8` for all inputs, so
  `popcount held_keep = 8` on every last word and `held_count = 8` always — **byte-for-
  byte the wire behaviour v1 intended** with its constant-`8` count. `tkeep` is ignored;
  the last word is always treated as a full 8-octet word. Violates REQ-011; tests the
  public **M04-B2 / M04-C4** Kills claim ("transmitting the whole final word").
- **Non-equivalent, live.** For any last word with `tkeep ≠ 0xFF` (a partial final
  word, e.g. `P = 20` → `tkeep = 0x0F`, conformant count 4), the mutant computes 8,
  moving `payload_end`, `pad_end` and the terminate lane. A conformant M04 masks the
  poison octets; the mutant transmits them — the same §3 observable, wire indices
  20–23 for `P = 20`. It is not an equivalent mutant.

**Verification this round (read-only; the tree was never modified).**

    git apply --check docs/reports/audit/WO-0084-mutations/class-03-tkeep-ignored.v2.diff
    # → clean at HEAD 712002f
    git diff 9dba6d5 712002f -- libs/hardcaml_ethernet/src/xgmii_tx_64.ml
    # → empty (file byte-identical to the manifest's declared base, so a diff that
    #   applies at HEAD applies at 9dba6d5 / the mut/ base)

Compile-correctness is established by **`git apply --check` + the type-correctness
argument above**, per the round's scope. The mutant is **not** operated this round —
no `mut/` ref is cut and no CI is run; that is a fresh operator act, deferred to a
commissioned re-run.

**IC-2 disposition and re-run recommendation.** IC-2 is presently the **one** seeded
M04 class with **no behavioural measurement** — v1's compile-fail left it untested and
v2's existence is a manifest fact, not a run (a manifest predicts a mechanism; a run
measures it, ADR-0005). **Recommendation: a single-class supplemental operator run of
`class-03-tkeep-ignored.v2.diff` is warranted before M04's `P<n>-module-ready` gate
signs** — not a re-run of the full thirteen-class campaign. Grounds: (a) IC-2 is the
tkeep / last-word-octet-count defect class, which governs frame-length and pad-boundary
correctness — a coverage hole there is worth closing; (b) it is cheap: one `mut/` ref,
one build, step-6 read; (c) it does **not** reopen or re-score the frozen campaign — the
campaign's score is a frozen measurement (ADR-0020), and a v2 run is a **separate**
supplemental measurement scored against the already-frozen IC-2 = KILL seal prediction;
(d) the blind is discharged, so nothing is compromised by running it now. Until such a
run exists, IC-2 must be carried in the gate tally as an **exclusion named with its
ground** ("class-03 v2 rendered — awaiting operator run"), **not** read as a kill on the
strength of the diff alone. If v2 is killed, IC-2 closes; if it survives, that is a real
coverage finding (like S2's `cfg_ifg` gap) the gate must weigh. The decision to
commission is the orchestrator's; this seat supplies the compiling mutant and the
recommendation.
