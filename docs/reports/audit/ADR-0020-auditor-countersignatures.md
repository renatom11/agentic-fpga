# ADR-0020 — the auditor's countersignatures, in the auditor's own committed artefact

- **Seat**: auditor (independent; graded by no one it audits, PROTOCOL §1)
- **Subject**: `docs/adr/ADR-0020-the-gate-asks-the-suite-not-the-scoreboard.md`,
  clauses **(b.2)** and **(b.3)** of the `P<n>-module-ready` **Mutation record**
  (now PROTOCOL §7)
- **Acts recorded**: `J-auditor-0021` (act 2 — the countersignature) and
  `J-auditor-0022` (the §9.5 delta-signature on the redrafted (b.2))
- **Written at**: `J-auditor-0024`, 2026-08-11 · read surfaces `65ba148`
- **Write scope**: `docs/reports/audit/**` (PROTOCOL §6). Nothing in this file
  edits an ADR, a packet, or a gate checklist; it cannot.

---

## 0. Why this file exists, and what it is not

The auditor is the one seat that may not stage the artefact it signs.
PROTOCOL §3's **auditor exception** (ADR-0003) states the consequence in terms:
the auditor's verdicts *"are therefore recorded in its committed report and
journal entry, and the **orchestrator transcribes** them into the packet's Return
log under its own trailer"*. Both of the acts below were therefore committed as
**journal-only** entries — `Files-in-this-commit: - (none)` — and existed nowhere
in `docs/` at all. `J-auditor-0021` Open-question 1 named that residue on the day
it was created:

> My countersignature exists only in my journal, and one of `G-1`'s two closing
> routes wants an artefact I was not permitted to write.

**This file is that artefact.** It is a transcription of acts already committed,
not a new act: every block in §1 and §2 is reproduced **verbatim** from the
append-only journal, and the journal entries remain the authority. If this file
and the journal ever disagree, the journal is right and this file is defective.

**What this file is not.** It is not a re-signature: nothing here re-decides,
softens, widens or withdraws anything signed at `-0021` or `-0022`. It is not a
gate signature: PROTOCOL §7 makes a gate signature a `J-<agent>-NNNN` reference
transcribed by the orchestrator, and this file supplies none. And it is not a
closure of `G-1` — see §5, which says so in one sentence because the temptation
to read a committed audit artefact as a closed gate item is exactly the error
this program's gate ledger exists to prevent.

---

## 1. Act 2 — the countersignature, `J-auditor-0021` (2026-08-11)

Two clauses were put to this seat. Both were signed; **neither was refused and
neither was narrowed**. Reproduced verbatim from `J-auditor-0021` Outcome.

### 1.1 Clause (b.2) — the survivor evidence form

> **COUNTERSIGNATURE — auditor, `ADR-0020` §9.2 act 2, clause (b.2).** The survivor evidence
> form is **my own `G1-b` specification returned unwidened**: every limb faithful, two limbs
> sharper than my words, one sentence carried verbatim, and the two additions (the disposition
> rule and the frozen-score sentence) restate rules already adopted rather than extending the
> guard. As the constrained party I confirm the guard is **exactly** the rule and I accept its
> cost: *as it stands at the gate SHA* means a survivor's rehabilitation expires when the bench
> moves, and the bench has moved 8,505 insertions since `e7657e3`, so **`G-c4`'s discharge at
> any future gate SHA requires a fresh replay and not a citation of run `30852220315`**. I sign
> under the reading that a still-surviving mutation remains reportable — the clause sets the
> form a rehabilitation must take, not a bar on recording that none exists. **COUNTERSIGNED.**

### 1.2 Clause (b.3) — the equivalent-mutant standard

> **COUNTERSIGNATURE — auditor, `ADR-0020` §9.2 act 2, clause (b.3).** The equivalent-mutant
> standard is **adopted as drafted, including both sharpenings I did not specify**. Limb 2
> (quantified over the specification's legal stimulus space, never over a bench) is the limb
> that makes the exclusion falsifiable from the losing side and I adopt it although it
> constrains me more than my own `G1-d` did. Limb 3 (the seeder records the exclusion in the
> seeder's own committed artefact) binds this seat's exclusive scope, and I confirm as the
> constrained party that it is **exactly** the rule and not wider: it requires the seeder to
> **record**, not to **prove**, so a third party's proof still counts — which is the shape the
> record's only instance actually has. I sign under the reading that a mutation leaving the
> **denominator** does not leave the **record**: it remains named individually with its
> disposition under (b.2), because an equivalence ruling cannot retroactively unmake the
> historical fact that it was rendered and run. **COUNTERSIGNED, with FINDING F-0021-3 filed
> against the clause's silence on publication and routed to the gate-record form, not to a
> redraft.**

### 1.3 The two dispositions that travelled with act 2

- **The refusal to merge (b.3) and (b.4) is SUSTAINED**, on three grounds
  (`J-auditor-0021` Reasoning §6).
- **The `D-M3` debt at ADR §10 item 4 is ACCEPTED**, and found larger than it was
  named (`J-auditor-0021` Reasoning §9). It is **paid at §4 below**, with a result
  §4 states plainly.

---

## 2. The delta — `J-auditor-0022` (2026-08-11), on (b.2) as redrafted

`ADR-0020` §9.5 owed a delta-signature on the clause as redrafted at
`J-architect_docs_lead-0046`, because act 2 had not seen the survivor definition
or the frozen-kill limb. Reproduced verbatim from `J-auditor-0022` Outcome.

> **DELTA-SIGNATURE — auditor, `ADR-0020` §9.5, clause (b.2) as redrafted at
> `J-architect_docs_lead-0046`.** I have now seen the two things act 2 did not: the
> **survivor definition** and the **frozen-kill limb**.
>
> **The definition is exactly the rule.** It selects the record's one survivor — `G-c4`'s
> seal predicts REQUIRED reds on every branch of its `WO-0055` §3 mapping and no unit
> killed it — it leaves no seeded class undispositioned at this record, and the class it
> declines to reach is the class whose seal predicted no kill, which is the practice's own
> fourth column (`WO-0077`: *"no class went green at a cell the seal had marked `G✱`"*).
> A rehabilitation reverses a measurement; a confirmed no-kill has none to reverse.
> Dropping *at a named unit* widens the survivor set, costs the graded party and relieves
> nobody, and the record does not turn on it.
>
> **The frozen-kill limb is exactly the rule for the hazard it names, and narrower than
> the present-tense question in two respects — one disclosed, one not.** As the constrained
> party I confirm it is **not wider**: it demands the campaign record, the unit named, and
> the unit present and green, and expressly not a re-run; I walked `WO-0050`'s scorecard at
> cell level and resolved ten named units in the bench at HEAD, so dv_lead's *"one table"*
> is corroborated on the sample the limb would first be applied to, though not walked
> whole. It is **narrower** than the honest question in the disclosed respect — a killing
> unit **weakened**, whose cheapest form in this `ppx_expect` bench is a re-promoted expect
> block — and in an undisclosed one: **five of the thirty-seven committed mutation
> renderings no longer apply at this HEAD** (`WO-0039/M3`, `WO-0039/M5`, `WO-0045/E-c2`,
> `WO-0050/f-c3`, `WO-0050/f-c6`, all context-search failures, all in campaigns scored as
> kills), and for two of them the named killing unit `M03-F2` **is present at HEAD**, so
> the limb's form is fully satisfiable for a class whose sealed rendering no longer exists
> against the design. **The survivor path is self-checking against that drift and the kill
> path is not.** I sign under two stated readings: *"the named killing unit"* points at
> **the campaign record's own naming**, plural where the record is plural, never a
> gate-time selection; and a campaign seal is **pre-run by construction** under `R-SEAL-1`
> and §10, which is what makes the survivor definition's dependence on the seal safe in
> this record even though the clause does not say so. **DELTA-SIGNED, with `F-0022-1` and
> `F-0022-2` (MAJOR) filed against the clause's residue disclosure and its singular
> referent, `F-0022-3` (MAJOR) against §6.6 ground 2's generalisation of my own figure, and
> `F-0022-4` (MINOR) against the trigger's unguarded disclosure-dependence — none of them a
> refusal, each routed to a place that is not a redraft.**

---

## 3. The stated readings, gathered

A countersignature that carries a reading binds that reading and no other. The
five are scattered across two entries and are collected here so a later seat does
not have to reconstruct them, and so that a construction of a clause can be
distinguished from the clause. **`ADR-0020` §6.7's own sentence governs: a
construction in a journal binds a reading; a sentence in the clause forecloses
one.** These are constructions. None of them is in the instrument.

| # | clause | the reading this seat signed under |
|---|---|---|
| **R1** | (b.2) | A **still-surviving** mutation remains reportable. The clause sets the form a *rehabilitation* must take; it is not a bar on recording that none exists |
| **R2** | (b.3) | A mutation leaving the **denominator** does not leave the **record**: it stays named individually with its disposition under (b.2), because an equivalence ruling cannot retroactively unmake the fact that it was rendered and run |
| **R3** | (b.3) limb 3 | Limb 3 requires the seeder to **record**, not to **prove** — so a third party's proof counts. This is the shape the record's only instance actually has, and §4 below is its discharge |
| **R4** | (b.2) frozen-kill limb | *"The named killing unit"* points at **the campaign record's own naming**, plural where the record is plural — never a gate-time selection among candidates |
| **R5** | (b.2) survivor definition | A campaign seal is **pre-run by construction** under `R-SEAL-1` and PROTOCOL §10, which is what makes the definition's dependence on the seal safe *in this record* even though the clause does not say so |

**The cost accepted with R1, restated because it is a live obligation**: *as it
stands at the gate SHA* means a survivor's rehabilitation expires when the bench
moves. **`G-c4`'s discharge at any future gate SHA requires a fresh replay, not a
citation of run `30852220315`.**

---

## 4. The `D-M3` debt, and what paying it returned

ADR §10 item 4 named one debt with one possible owner: *"one paragraph recording
the `D-M3` equivalence exclusion in the seeder's own artefact"* — limb 3's form,
for the single instance `ADR-0020` §6.3 grandfathers by name. Accepted at
`J-auditor-0021` §9, carried unpaid through `-0022` (Open-question 4: *"a debt
that only its owner can pay and that its owner is never spawned to pay is
indistinguishable, at the gate, from one that was forgotten"*), **paid at
`J-auditor-0024`** in `docs/reports/audit/WO-0041-mutations/README.md` **§7**.

At `-0021` §9 this seat committed to a disclosure as well as to the record:
*either re-derive the margin over the stated stimulus space, or record the proof
as cited and not re-derived, and say which.* **I re-derived it, and the
re-derivation does not reproduce the proof's conclusion.**

- The proof's stated tightest case — *terminate lane 0, a lane-0 start, a 9-octet
  gap* — **cannot exist**: under §0.3's convention `G ≡ s − t (mod 8)`, so a
  9-octet gap occurs only at terminate lane 7 with a lane-0 successor or terminate
  lane 3 with a lane-4 successor. This limb is arithmetic and needs no execution.
- The margin reaches **−1** at terminate lanes 1, 2 and 3 from a **lane-0 start**
  with a **lane-4-started successor** at DIC-shortened gaps of 11, 10 and 9
  octets — i.e. frames of length ≡ 1, 2, 3 (mod 8), on the alternating DIC-capable
  link partner `REQ-004` names as the worst case the receive path must survive.
- The bench's own `Arrival` model lays that out: three 65-octet frames from a
  lane-0 first start put frame 1's `tlast` at cycle 23 and frame 2's start word at
  22, so the mutant reads a re-seeded register and reports a **good** frame bad.
- `D-M3` nevertheless survived the suite because **no unit combines a length
  ≢ 0 (mod 8) with a following frame**: directed lengths run as lone frames, and
  every multi-frame schedule is 64-octet. That is the *first* of the two
  hypotheses `RV-0041-VERDICT` §3 weighed and the one it rejected.

**Consequences for this file.** Two of the acts recorded above rest on premises
this result moves, and both are stated rather than left to be noticed:

1. **`F-0021-4` is inverted, not repaired.** It was filed against my own seat, on
   the ground that the equivalence proof refutes §3.3's divergence claim. The
   proof does not. §3.3's essential claim survives; one supporting parenthetical
   in it is wrong (the lane-4 drain window, off by one) and is recorded at §7.3(g)
   of that file, unedited there because §3.3 is frozen pre-run text.
2. **The (b.3) countersignature at §1.2 is unaffected and stays as signed.** It
   adopted a *standard*; it did not certify the record's one instance. The
   sentence in `J-auditor-0021` §9 that did — *"the exclusion **stands** on its own
   merits regardless"* — is the sentence §4 withdraws, and it is withdrawn here
   openly rather than by being left behind in a journal nobody re-reads.

`F-0024-A` (CRITICAL), `F-0024-B`, `F-0024-C` (MAJOR), `F-0024-D` and `F-0024-E`
(MINOR) are filed in that note with their routes, and **`F-0024-A` names its own
falsifier**: one transient run of the unmodified `D-M3.diff` against a
three-frame 65-octet schedule, withdrawn in full if that run is green.

---

## 5. `G-1` — the plain statement

**`G-1` stays OPEN.** `docs/gates/P1-module-ready-checklist.md`:179 and :525 carry
it, and its closing event is stated there as *"an auditor verdict on `G-c4` and
`IC-M5` committed under `docs/reports/audit/`, **or** an ADR settling the clause —
**by amendment, not by reading**"*. `ADR-0020` §9.4 already ruled that acceptance
supplies `G-1`'s **reading** without closing it.

**What this file does**: it closes the *auditor-verdict half* of `G-1`'s route —
the half :517 records as unpaid (*"`G-1`'s reading is not supplied"* against this
seat's artefact form), which existed only as journal text until now. **That is
all it does.** It supplies no verdict on `G-c4` or `IC-M5`, it is not an
amendment, and the route the record has actually taken is the ADR. `G-9` is
likewise untouched and remains open at :181 and :525.

**Nothing in this file blocks the gate and nothing in it passes the gate**, with
one exception stated in terms: **`F-0024-A` is a CRITICAL finding**, charter §3
makes an open CRITICAL a bar on `P<n>-phase-accept`, and PROTOCOL §8 routes it as
**E4, verbatim, to the human sponsor**. It is not a finding against this file's
subject — `ADR-0020`'s clauses stand as signed — and its falsifier is one CI run.

---

## 6. Findings carried into this file, with severities and routes

Reproduced from the two entries' finding tables, with each row's state at
`65ba148`. **Not one of them is repaired by this file**; this file makes them
readable outside a journal.

| id | severity | subject | route / state |
|---|---|---|---|
| `F-0021-1` | MINOR | **the orchestrator** (dispatch) | The dispatch assigned (b.3) this seat's `G-9` adaptation; `ADR-0020` §0, §5 and §9.2 place it in **(b.4)**, routed to dv_lead. Recorded so a transcription cannot inherit the error and act 3 is not scored as part-paid. **Open** |
| `F-0021-2` | MINOR | **the orchestrator** (dispatch) | `J-auditor-0020` was stated as committed 16:57Z; `60c1ccf`'s author time is **16:59:13Z**. Immaterial to any verdict; recorded because this is the item that exists because time figures went unchecked. **Open** |
| `F-0021-3` | MAJOR | **`ADR-0020` (b.3)** / architect_docs_lead | (b.1) requires the difference *named at the tally with its ground*; (b.4) requires the unreachable set *beside the tally*; **(b.3) requires publication nowhere**. Not a refusal — the text supports the cure by construction. Cure routed to the **gate-record form** (ADR §10 item 2 / architect ledger row 78). **Open, and §4 above sharpens it**: the record's one exclusion is now refuted, so the first thing the form would have published is the thing nobody had to publish |
| `F-0021-4` | MAJOR | **my own seat** | Filed against `WO-0041-mutations/README.md`:325–326, :354–360 as a falsified mechanism claim. **INVERTED at §4**: the re-derivation refutes the proof, not the claim. The owed note is **PAID** (that file's §7); the finding's premise does not survive it and its replacement is `F-0024-D` (the one real error, MINOR) |
| `F-0021-5` | MINOR | **the gate** (orchestrator) | (b.2)'s *as it stands at the gate SHA* is not discharged for `G-c4` by run `30852220315`; the bench moved 8,505 insertions / 151 deletions across 15 files since `e7657e3`. Replay renderable (`git apply --check` exit 0). **Becomes MAJOR the moment a gate record cites the historical run as (b.2)'s discharge without a re-run.** Open |
| `F-0022-1` | MAJOR | **`ADR-0020` (b.2) / §12.8** / architect_docs_lead | The limb's honest bound names **one** uncaught mode (weakening) where the record exhibits **two**. Measured at `b6c8a2f`: **5 of 37** committed renderings no longer apply. Cure: one sentence in §12.8, at no signature cost **before** acceptance; after it, the route is Amendment A1 against a live rule. **Open, window closing** |
| `F-0022-2` | MAJOR | **`ADR-0020` (b.2)** / architect_docs_lead, routed to dv_lead | *"The named killing unit"* is singular against a record whose kills are not — `WO-0050`: `F-c1` names four units, `F-c2` nine, `F-c8` one of three required; **3 of 8 classes** with no unique referent. Construction stated as **R4** above. **Open** |
| `F-0022-3` | MAJOR | **architect_docs_lead** (`ADR-0020` §6.6 ground 2) | **The drift discovery.** *"The same 8,505 lines sit under all 61 kills"* does not reproduce: measured per campaign base at `b6c8a2f` the figure is 8,505 / 7,537 / 5,840 / 4,373 / 3,121 under the five earliest, and **41 insertions / 4 deletions in one file** (`test_m03_k.ml`) under `bbd4122`, `ca1bb80`, `8346a5c`, `aced7b4`; `xgmii_rx_64.ml` has not moved since `42b9df3`. By the `SO-`'s own §2.2-M table that is **22 sealed / 21 killed** in families M/J/K-N under the 41-line figure. **My own figure, quoted correctly and generalised without re-measurement.** Not CRITICAL: charter §3 reserves that for Evidence, and this is a Reasoning ground. **The ground survives in corrected form and is stronger** — the drift concentrates exactly where `F-0022-1`'s five stale renderings are. Cure: one sentence in §6.6. **Open** |
| `F-0022-4` | MINOR | **`ADR-0020` (b.2)** / architect_docs_lead | The survivor trigger turns on what the seal disclosed; (b.1) conditions exactly that dependence but scopes the condition to grounds for leaving `seeded`, so it does not reach (b.2). Symmetric hazard, asymmetric guard. **Becomes MAJOR the moment a campaign reports a non-empty green-by-blindness column.** Open |
| `F-0022-5` | MINOR | **`ADR-0020` §12.8** / architect_docs_lead, **and my own seat** | §12.8 routes the weakening residue to *"`RV-` and `SO-` review"* as *"visible in `test/**`"*. That control is **not independent of the graded party**: PROTOCOL §6 gives `test/**` to dv_lead and tb_writer, and tb_writer's reviewing lead is dv_lead. The independent catcher is the **auditor** (charter §3). The finding **enlarges this seat's own duty** and is filed so the residue has a named owner. Open |

**Adverse-party note** (charter §7). `F-0021-1`, `F-0021-2` and `F-0021-5` concern
the orchestrator — the seat that relays these findings and commits this file.
They are stated identically to the rest, and this sentence is here because the
charter requires the adverse party to be named when it is the subject.

---

## 7. Falsifying this file

Every claim above is checkable from a checkout, and the routes are:

```sh
# the two acts, at their own commits, in the append-only chain
git log --grep 'Journal-Entry: J-auditor-0021' --format='%H %ai %s'
git log --grep 'Journal-Entry: J-auditor-0022' --format='%H %ai %s'

# the blocks reproduced at sections 1 and 2, against the journal itself
grep -n 'COUNTERSIGNATURE — auditor' agents/journals/claude_auditor_agent.v02.md
grep -n 'DELTA-SIGNATURE — auditor'  agents/journals/claude_auditor_agent.v02.md

# both entries were journal-only, which is the reason section 0 gives for this file
git show --stat $(git log --grep 'Journal-Entry: J-auditor-0021' --format=%H)

# section 4's arithmetic limb needs no repository at all: G = 8(S-W) + s - t,
# so G = 9 requires s - t = 1 (mod 8), i.e. t = 7 with s = 0 or t = 3 with s = 4.
# Terminate lane 0 with a 9-octet gap is not a member of the space.

# section 5's gate rows
sed -n '179p;181p;517p;525p' docs/gates/P1-module-ready-checklist.md
```

**A transcription is defective if it diverges from its source**, and the source
here is an append-only journal that no seat but this one may write. That is the
whole tamper-evidence argument for this file, and it is the same one
`J-auditor-0021` and `-0022` each closed with.
