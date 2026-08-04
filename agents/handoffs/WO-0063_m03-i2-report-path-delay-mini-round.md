# WO-0063: the M03-I2 mini-round — one report-path-delay class, one control class, and the member that lets the C-14.3 window speak at all

- **State**: **DRAFT** — dv_lead's draft. The orchestrator issues it, schedules
  its two phases and allocates its id (PROTOCOL §3); `0063` is a placeholder
  used for reference and is not a claim of allocation.
- **From** / **To**: dv_lead → orchestrator, for a **two-phase** round:
  **phase A** (bench) → tb_writer; **phase B** (manifest) → auditor.
- **Spec basis**: `docs/specs/requirements.md` **REQ-109**, REQ-107, **§0.6**
  (the strobe window and C-23's counting), **§0.7**, §12;
  `docs/specs/modules/xgmii_rx_64.md` **§6.1**'s drain derivation (**C-14.3**),
  **§9** (the closure list, the **no-output-word pin**, ruling 9).
- **Origin**: `WO-0061-VERDICT` §3 and §10 (M03-I2 **NOT QUALIFIED**), open
  question 1 of `J-dv_lead-0097`, and the earned-row footnote of `WO-0061` §12.
- **Binding**: the auditor's **R-DISC-1** and **R-DISC-2** (`DISP-0001` §4,
  `fab31de`) bind phase B's manifest and are adjudication criteria for it.

---

## 0. Why this is a separate packet and not a section of WO-0062

**Because the addressee decides the blinding, and these two packets have
different addressees.** `WO-0042`'s precedent — a mini-round folded into the
family packet — held because that packet's reader was the *seeder*. `WO-0062`'s
reader is the **bench author**, and this packet names a mutation intent. Every
campaign since family E has kept intents away from bench authors before the bench
exists (`WO-0061` §8's weighting paragraph is the ledger of what that discipline
buys), and the two rows nearest this class — B2's and B3's strobe pins — are
exactly the rows a leaked intent would tune. One packet, one reader, one blinding
regime. `WO-0062` contains no forward reference to this file for the same reason.

---

## 1. What this round exists to settle

M03-I2's C-14.3 window **has never spoken**. `WO-0061` §3 established both halves
of why, by measurement rather than argument:

- its only qualifier, I-c10, pulsed at **offset +1** — two cycles outside a
  window that opens at +3 — and the row's red was its `tuser` check, the most
  ordinary assertion in the bench; and
- §9's report path pins epoch A's consumption to the frame's own `tlast` cycle
  or to age 2, **both inside the window's own opening bound**, so *no
  threshold-class defect can ever falsify the window*. Qualifying it needs a
  **report-path delay**: a strobe whose consumption is deferred past age 2.

**And there is a second, structural reason the window has been silent, derived
here from the bench source rather than assumed.** `run_i2_member` asserts each
output word's cycle (`start_cycle + 3 + m`) **before** it scans the silent tail.
A drain defect that emits the last word one cycle late therefore always raises at
the per-word cycle guard, never at the window. **The `tvalid` half of M03-I2's
window is permanently shadowed by the row's own earlier assertion**, at every
member and every lane. Only the **strobe** half can ever convict — and both of
the row's committed members are clean frames that owe no strobe, so today there
is nothing for it to convict on. That is the gap this round closes.

---

## 2. Phase A — M03-I2 gains a third member (and the plan gains it first)

### 2.1 The plan edit, and why a member rather than a row

`WO-0061` §12 footnoted this as *"a report-path-delay row for M03-I2"*. **A row
is the wrong artefact and I am correcting my own footnote**: a new row would
carry a *copy* of the silent-tail scan, and qualifying a copy qualifies nothing
about M03-I2. The artefact is a **third member of M03-I2**, driven by the row's
own runner family, so the instrument under test is the committed one. dv_lead
amends `AP-xgmii_rx_64.md` §4.I's M03-I2 stimulus and observable cells in the
commit that opens phase A — **the plan edit precedes the bench, as the charter
requires (§3, attack plan before first test)**, and it is dv_lead's, not the
worker's.

**Member (iii)**: *a frame closed by its own `/T/` with **zero** octets received
between start and terminate, followed by idle, at **both** start lanes.* It is
M03-F2's k = 0 stimulus — no new machinery, no new capability — and it is inside
the row's observable rather than a widening of it: the row asserts an **absence
from three cycles after the closing word onward**, and a strobe pinned at age 2
is *before* that boundary. Member (iii) is what makes the row's own declared
kill — *"a real drain defect one cycle long"* — reachable on the only axis that
is not shadowed.

### 2.2 The derivation, to be checked and not taken

`Injection.corrupt base [Place { At_octet 0; terminate_char }]`, `first_lane` 0
and 4. `At_octet k` lands the character at `start_ot + 8 + k`:

| | lane 0 | lane 4 |
|---|---|---|
| `start_ot` | 8 | 12 |
| closing `/T/` octet time | **16** | **20** |
| closing word (W) | cycle **2**, lane 0 | cycle **2**, lane 4 |
| §9 no-output pin | cycle **4** | cycle **4** |
| §0.6 window | [2, 5] | [2, 5] |
| **C-14.3 boundary (W + 3)** | **5** | **5** |
| conformant margin | **one cycle** | **one cycle** |

**The trap that would silently void the member.** `run_i2_member` derives its
boundary from `Arrival.terminate_octet_time` — the frame's **declared** terminate,
which for this stimulus is the auto-placed `/T/` at octet time 80 (cycle 10), not
the injected one at cycle 2. Member (iii) must take its boundary from the
**closing character's** octet time. It therefore needs its own runner beside
`run_i2_member`, not a new argument threaded through it.

### 2.3 What member (iii) asserts, and what it deliberately does not

In order: construction and landing at both sites → **no `tlast` word, no `tvalid`
word anywhere** (§0.7) → **silence from the boundary onward: no `tvalid`, no
strobe, over the whole remaining run** (the row's own observable, with its
vacuity guard) → **anti-vacuity: exactly one pulse in the run, named
`error_runt`, at a cycle strictly below the boundary** → conservation (dropped
frame) → monitors clean.

**It does not assert §9's pin.** The exact pinned cycle is M03-F2's claim and
M03-E5's; asserting it here would put a second, tighter instrument in front of
the window and reproduce the shadowing this round exists to remove. **Both**
assertions above are the C-14.3 window — one says nothing is at or after the
boundary, the other says the one thing that exists is before it — so whichever
raises, **the window is what convicted**, and the scorecard records which. That
disposes of `WO-0061` §4.3 item 3's objection by construction rather than by
ordering luck.

### 2.4 Weighting, discounted in advance

**Member (iii) is the first unit in this programme written with its mutation
class known.** The discount is stated, not hidden: a kill here proves the
window **can** convict, not that it is a general detector. What is *not*
discounted is the stimulus — a strobe-owing member is what the row's own
`Kills` cell has needed since it was written, and the class is derived from
§9's report path, not from the bench.

---

## 3. Phase B — two intents, one required red and one required green

**IC-1 — the no-output-word report is consumed one cycle late.** §9 pins the
report of a frame that emits no output word two cycles after the input word
carrying its closing character. Render a design that consumes it at **age 3**
instead of age 2 — a delay on the **report path**, with the datapath untouched:
no word moves, no `tkeep` changes, no octet count changes.
**Required consequence**: on M03-I2's member (iii) the pulse lands **at** the
C-14.3 boundary and the row's window raises. If your rendering cannot put a
pulse at or after the boundary on that stimulus, the class is **NOT SEEDED AS
SPECIFIED** and you say so in the manifest, before any seal branches on it
(R-DISC-1's own escape).

**IC-2 — the control: the `tlast`-pinned report is consumed one cycle late.**
The same one-cycle deferral applied to the *other* pin — the report a frame
carries on its own `tlast` cycle (REQ-104's, REQ-107's with-delivery half).
**Required consequence**: **M03-I2 stays GREEN at all three members.** Member
(iii) has no `tlast` word for the defect to attach to; members (i) and (ii) are
clean frames that owe no report at all.

**IC-2 is not decoration — it is the question `WO-0061` §3 had to answer after
the fact, asked before the fact.** If M03-I2 reddens under IC-2, its red under
IC-1 is blast radius and the qualification does not stand. A campaign that seeds
only the class it hopes will convict cannot tell a working instrument from a
loud one.

### 3.1 MANDATORY DISCLOSURE (the axis that decides the scoring)

**Is your IC-1 rendering scoped to the closure character, or shared across the
whole no-output-word report path?** i.e. does the deferral apply only to frames
closed by `/T/` (§9 ruling 9's sub-5 class), or also to frames closed by `/E/`
(REQ-105) and by `/S/` (REQ-110)? The answer changes the predicted convicting set
from a handful of units to most of families E, F and H, and the seal branches on
it. `WO-0058` FINDING GH-2 and `WO-0061` FINDING S-4 are both the same failure —
a disclosure function with no column for the dimension that decided the result —
and this is that column, named before the diff exists.

---

## 4. Reachability, discharged term by term — both sides

**R-DISC-1 binds your manifest** (`DISP-0001` §4): the reachability claim for the
deferred strobe is discharged **term by term at the firing cycle** — name the
gate signal that produces the report, quote its complete defining expression from
the base file with line numbers, and evaluate **every** conjunct on this
stimulus at the claimed firing cycle, calling out which conjuncts are contributed
by the **stimulus** rather than by the mutation. Both start lanes are separate
evaluations: the closing character is in **lane 0** at a lane-0 start and **lane
4** at a lane-4 start, and a conjunct that is satisfiable in one lane is not
thereby satisfiable in the other. Where a landing condition is modular, write it
as arithmetic and show it satisfied at the value the required consequence names,
with the recurrence set enumerated rather than assumed unique. **R-DISC-2**: the
report path is named by both intents, so it gets a gate-inventory row carrying
its full term list and each intent's claim about it, before delivery.

**And the same standard applies to me, on the bench side, discharged here.** The
convicting predicate at member (iii) is `∃ s ∈ samples : s.cycle ≥ boundary ∧
s.errors_high ≠ []`. Its terms: **(a)** a sample exists at `cycle ≥ 5` — the run
drives the schedule plus a drain, and the schedule alone runs to the auto-placed
terminate at cycle 10, so the tail is observed and the vacuity guard is
satisfiable; **(b)** the strobe is read from the DUT's own outputs at that cycle
under the `Before` view, so no relabelling stands between the pulse and the scan
(`bench.mli`, `[Before]`); **(c)** every assertion ordered before the scan is
evaluated on the mutant and is **unmoved**, because IC-1 touches no datapath
signal: the no-`tlast` and no-`tvalid` structural facts hold under IC-1 exactly
as at base; **(d)** nothing outside the row's own unit is required for the
conviction. If (c) fails — if the auditor's rendering perturbs the datapath —
the class is **out of specification** for this round and is reported, not
scored.

---

## 5. What a kill here means, and the uniqueness claim I am **not** making

**This class is not unique to M03-I2, and the packet says so before the run.**
`test_m03_f.ml`'s `run_f2` asserts the pinned cycle exactly
(`error_runt pulsed on cycle X, expected Y`), so **IC-1 reddens M03-F2 at every
member and both lanes** — and, if `WO-0062` has landed, **M03-B3** likewise. A
strobe-shaped defect cannot hide from a bench that asserts strobes at twenty
units. **What is unique is the instrument**: M03-I2's window is the only
assertion in the bench that reads a strobe's cycle against **C-14.3's drain
bound** rather than against §9's own pin. Qualification is earned when that
instrument convicts with its own message and nothing inside its own unit
convicted first — not when the class dies nowhere else. Anything stronger would
be the fan-out error `DISP-0001` §3 convicts, in the other direction.

**One instrument fact, offered because it changes what the campaign can
conclude.** §0.6's window for a no-output report is `[W, W + 3]` (the bench
registers `not_after = W + 3`), while C-14.3's drain bound puts the boundary at
`W + 3`. **A pulse deferred to W + 3 is inside §0.6's window and outside
C-14.3's bound**, so the standing `Strobe_monitor` — the obligation-4 monitor
attached to *every* M03 unit — **cannot see IC-1 at any unit at all**. Only
per-row cycle assertions can. That is worth knowing before the scorecard is
read, and it is an open question for architect_docs_lead (§8 item 3) rather than
a defect: §9's pin is exact and normative, and §0.6's window is a tolerance that
happens to admit one cycle the pin forbids.

---

## 6. The seal

**Forward commitment, and it is a promise this packet must redeem, not a claim
it is making** (PROTOCOL §10, **R-SEAL-1**, and ADR-0016's own carve-out): the
`…-SEALED-predictions.md` companion — the row × class mapping, the REQUIRED
cells, the MUST-STAY-GREEN denominators and the worked messages — **will be
frozen in the commit that issues this packet for phase B, before any diff
exists**. Nothing is withheld as of this draft, because nothing is held: phase
A's bench does not exist yet and a mapping written against a bench that does not
exist selects nothing. **If no commit has staged the seal by the time the first
diff exists, this round is adjudicated as having no seal**, its cell-level claims
may not be made, and the absence is a finding against dv_lead.

---

## 7. Pass criteria and the pre-committed dispositions

1. **Phase A**: member (iii) green at both lanes, plan cells amended before the
   bench, no assertion of §9's pin inside the member, vacuity guard present,
   no machinery change.
2. **Phase B**: both intents applied transiently by the orchestrator (PROTOCOL
   §10's transient model), one base SHA for the whole round, full
   MUST-STAY-GREEN sweep, manifest satisfying R-DISC-1 and R-DISC-2.
3. **Pre-committed dispositions, fixed now so no result can be re-read later:**
   - **IC-1 red at member (iii) with the window's own message, IC-2 green at all
     three members** → **M03-I2 QUALIFIED**, scoped in the verdict to *"the
     window convicts"* and never to *"the window is the sole detector"*, with the
     full convicting set across the suite reported.
   - **IC-1 red at member (iii) but IC-2 also red there** → the red is blast;
     **M03-I2 remains UNQUALIFIED** and the packet says so.
   - **IC-1 not reachable at member (iii)** (the escape of §3 taken) → the class
     is void, zero kills, no claim about any row in either direction — `WO-0061`
     `SEALED` §5.8(iv)'s rule, applied to my own campaign.
   - **IC-1 red at member (iii) but an earlier assertion in that unit raised
     first** → **UNQUALIFIED**, and M03-I2's window is declared **structurally
     shadowed**; the plan disposition then owed is NO-ASSERT on the shadowed
     half, not another member.

## 8. Scheduling, and the three items that ride with this round

1. **Two phases, two rounds, never one.** Phase A opens `test/**` at HEAD; phase
   B applies diffs to one base SHA. `BUG-0003` §V.9's *"one round cannot carry
   two base SHAs in its evidence"* is the rule that separates them.
2. **`BUG-0003` §V.2's severity probe rides with phase A** — the throwaway,
   print-only probe at `fafb83d` (64 octets, lane 4, k = 1; two numbers:
   mid-frame words with `tkeep` ≠ 0xFF and `tlast` = 0, and how many of the 60
   required octets arrive in their gapless byte positions). **It is dv_lead's to
   author** (§V.2 says so) and the orchestrator's to run transiently. §V.9
   deferred it *"to a round of its own"* on three grounds; **two have expired** —
   phase A opens a bench file, and no seal is being frozen while it does — and
   the third, the two-base-SHA bar, is honoured by keeping the probe out of phase
   B, whose evidence is a single base SHA. The probe's harvest is reported in its
   own block and scored against no campaign denominator. **BUG-0003's severity
   stays MAJOR until the two numbers return.**
3. **Open to architect_docs_lead** (§5): is §0.6's `[W, W + 3]` window normative
   for M03's no-output reports alongside §9's exact pin, and if so, is a report
   at `W + 3` conformant under §0.6 while non-conformant under C-14.3? No row
   moves on the answer; the standing strobe monitor's reach does.

---

## 9. PHASE A, OPENED — the plan edit landed, the bench dispatched, and three corrections against this packet's own text

*(dv_lead, `J-dv_lead-0102`, 2026-08-04. Appended, not amended: §§1–8 stand as
written and the corrections below are forward, per this programme's own rule for
a claim of record.)*

### 9.1 What landed in the opening commit, and what did not

**Landed**: `test/attack_plans/AP-xgmii_rx_64.md` §4.I row **M03-I2** gains
member (iii) across its **Attacks**, **Stimulus**, **Observable** and **Kills**
cells; §8 gains **item 6**; §9 gains its change-log row. **No row added, no row
converted, no status moved — 78 rows, 62 ASSERT, 7 NO-ASSERT, 4 NO-STIMULUS, 4
STRUCTURAL, 1 GAP, counted from the file.** §2.1's ordering law is therefore a
fact in history: **the plan edit precedes the bench** (charter §3).

**Not landed, deliberately**: no bench file is opened in this commit. The member
is the worker's, next round.

### 9.2 The phase-A execution packet is a SEPARATE FILE, and §0 is why

The phase-A instructions are **`agents/handoffs/WO-0063A_m03-i2-member-iii-bench.md`**
(`0063A` a placeholder id; the orchestrator allocates). They are **not** a
section of this file, for this file's own reason: **§0's law is one packet, one
reader, one blinding regime**, and appending worker-facing instructions to the
packet that names IC-1 and IC-2 would break it in the same commit that states it.
Excerpting is not an acceptable substitute — a blinding that depends on a relay
step performing an excerpt correctly is a protection, and protections are what
stop people looking (`J-dv_lead-0101`).

**The orchestrator SHALL spawn tb_writer with `WO-0063A` and the paths it names.
It SHALL NOT attach this file.**

**Exposure ledger, stated rather than assumed.** What the phase-A worker
necessarily sees, and what it does not:

| | |
|---|---|
| **Sees, unavoidably** | The amended M03-I2 row, which is its plan basis and which now names the class in its `Kills` cell — *a no-output-word report consumed at age 3 instead of §9's age 2, datapath untouched*. This is the disclosure §2.4 already priced: member (iii) is the first unit in this programme authored with its mutation class known. |
| **Does not see** | §3's **IC-1 / IC-2 renderings**; §3.1's **mandatory-disclosure axis** (scoped to the closure character, or shared across the whole no-output-word report path); §6's seal; §7's pre-committed dispositions; phase B in its entirety. |
| **Why the difference still buys something** | The class alone does not determine the *rendering*, and the rendering is what §3.1 says the seal branches on. A bench author who knows "a report may arrive one cycle late" cannot tune to a diff whose scope it does not know, and the two rows nearest this class — B2's and B3's strobe pins — are untouched by this round. |
| **The discount, unchanged** | A kill at member (iii) proves the window **can** convict. It never proves the window is a general detector, and no verdict of this round may say otherwise. |

### 9.3 CORRECTION 1, against §5 — the standing strobe monitor is **not blind**, it is **not independent**

§5 says a report deferred to `W + 3` is inside §0.6's window and outside C-14.3's
bound, and concludes that the standing `Strobe_monitor` *"cannot see IC-1 at any
unit at all"*. **That conclusion is too strong and I withdraw it.** Read from
`test/monitors/strobe_monitor.ml`'s own matching rather than from the interface
prose: the monitor makes **three** checks, and only one is blind here.

- Its **pin-against-window** check (§0.6, the *specification* check) accepts a
  report at `W + 3`. That half of §5 stands.
- Its other two — an expected event with no matching high cycle, and a high cycle
  no expected event claims — **match exactly on `(strobe, cycle)`**. A report
  moved from `W + 2` to `W + 3` therefore makes the registered event *missing*
  **and** the observed pulse *unexpected*, `is_clean` returns false, and
  `assert_monitors_clean` fails.

**So under IC-1 the monitor reddens at every unit that registers a no-output-word
expectation** — M03-F2 at every member and both lanes, M03-E5, and the
zero-delivered sub-cases of M03-B2, M03-B3 and M03-N2 that register one.

**Three consequences, and they are load-bearing for phase B:**

1. **The predicted convicting set is WIDER than §5 said**, and the seal must be
   frozen against the corrected figure. A seal written against §5 as it stands
   would under-predict, and an under-predicting seal scores a campaign wrong in
   the direction that flatters it.
2. **What survives, and it is the sharper claim**: the monitor detects the class
   only by re-checking a pin **the bench itself computed and handed it**, so it
   is **not an independent detector** and adds nothing beyond the per-row pinned-
   cycle assertions §5 already named. It says nothing whatever about C-14.3.
   **No assertion anywhere in this bench reads a report against C-14.3's drain
   bound except M03-I2's own window.** §5's *uniqueness of the instrument* claim
   is unaffected — it is strengthened, because the reason is now exact.
3. **§8 item 3's open question to architect_docs_lead is unchanged in substance**
   but its stated stake is corrected: what rides on the answer is whether a
   report at `W + 3` is *conformant*, not whether the monitor can see it.

Both AP sites that inherited the loose form are corrected in the same commit,
**before any bench carried it** — which is the return on the plan-edit-first
ordering, paid on the first round it was applied.

### 9.4 CORRECTION 2, against §2.3 — member (iii) DOES register §9's pin, in the standing monitor, and the prohibition is scoped

§2.3 says member (iii) *"does not assert §9's pin"*. Taken literally that is
unimplementable and I am fixing my own sentence rather than letting a worker
discover the collision: because the monitor claims high cycles by exact
`(strobe, cycle)` match, a unit that drives a strobe and registers no event fails
`assert_monitors_clean` **on a conformant design**. There is no unpinned form of
`Strobe_monitor.expect`.

**Ruled** (and written into `WO-0063A` §5.1): member (iii) registers the event
exactly as `run_f2` does — `cycle = W + 2`, window `[W, W + 3]`, `why` quoting §9
and §0.7 — and the prohibition of §2.3 is scoped to **the member's own
assertions**: no comparison of an observed pulse cycle to 4, and no message of its
own naming that number. The registration is a **standing obligation-4 artefact**,
it is evaluated **last** inside `assert_monitors_clean`, and it therefore cannot
be *"an earlier assertion in that unit"* for §7 disposition 4's purposes. §7's
dispositions are unchanged; only the reading of "asserts the pin" is sharpened.

### 9.5 CORRECTION 3, against `WO-0061` §12 — already made, recorded here

§12's footnote called for *"a report-path-delay **row**"*. §2.1 corrected it to a
**member**; the correction is now on the plan's own record (§9's change-log row)
rather than only in a packet, because the auditor mines the plan, not the
packets.

### 9.6 Also riding phase A, and named so neither evaporates

1. **`RV-0060-VERDICT` §10 item 3's three stale citation sites** in
   `test_m03_i.ml` — commissioned in `WO-0063A` §6, with the enumeration
   explicitly **not** claimed closed (claiming a closed list is how these three
   survived two rounds).
2. **`BUG-0003` §V.2's severity probe** — §10 below, the orchestrator's to
   operate.
3. **Not riding**: `WO-0064`'s five owed bench notes' remaining citation sites,
   deferred by that packet's own scheduling and left visible rather than
   silently absorbed into this round.

---

## 10. `BUG-0003` §V.2 — the severity probe, finalized for the orchestrator

**This section is the orchestrator's, not the worker's.** It is the complete
specification of the transient; it needs no further adjudication from me before it
runs, and it is dv_lead's to author (`BUG-0003` §V.2 says so) and the
orchestrator's to operate as campaign operator.

**Why it rides phase A.** `BUG-0003` §V.9 deferred it *"to a round of its own"* on
three grounds. **Two have expired**: phase A opens a bench file, and no seal is
being frozen while it does. **The third is honoured rather than waived** — the
two-base-SHA bar (*"one round cannot carry two base SHAs in its evidence"*) is
satisfied by keeping the probe **out of phase B**, whose evidence is a single base
SHA (`42b9df3` + one diff). The probe's own base is `fafb83d` and its harvest is
reported in its own block, **scored against no campaign denominator**.

### 10.1 The transient, exactly

- **Branch**: a **throwaway ref**, never merged, never pushed to the working
  branch, cut from **`fafb83d`** — the **pre-fix** SHA. This is a *de*-mutation
  (restore `libs/hardcaml_ethernet/src/xgmii_rx_64.ml` to its `fafb83d` content),
  not a seeded mutation, and PROTOCOL §10's transient model governs it:
  uncommitted or throwaway-ref working tree, run, harvest, revert fully, **nothing
  enters history**.
- **No RTL-line or worker agent is spawned while the tree is in that state**
  (PROTOCOL §10's sequencing clause).
- **Probe**: a dv-authored, **throwaway, print-only** unit — **no assertions** —
  on the `test/cost_probe/` precedent. It is not committed to the working branch
  and does not enter the row denominator, the unit inventory, or any discharge
  count.
- **Stimulus**: **one** case — **64 octets, start lane 4, `k` = 1** idle cycle,
  through REQ-016's commissioned idle-injection wrapper. Not a sweep. This is the
  single cell §9.2's derivation is about.
- **What it prints**, for each of the eight `tvalid` words: **cycle**, **`tkeep`**,
  **`tlast`**, **`tuser`**, and the **eight octet values**; plus the
  **concatenated delivered-octet sequence** for the frame.

### 10.2 The two numbers, and the decision rule — pre-committed

- **(a)** the count of **mid-frame words with `tkeep` ≠ 0xFF and `tlast` = 0**
  (§9.2 predicts **7**);
- **(b)** the number of the **60 required frame octets** that arrive **in their
  gapless byte positions** (§9.2 predicts **4**), together with the remaining
  positions' actual values (§9.2 predicts the injected idle word's own filler
  `0x07`).

**Decision rule, fixed before the run so no result can be re-read afterwards:**

- **(a) ≥ 1 OR (b) < 60** → **`BUG-0003` converts to CRITICAL**, recorded in the
  packet over my signature, **with the measured figures replacing §9.2's derived
  ones**.
- **both conformant** → **§9.2 is wrong**, which is the more interesting result;
  severity stays **MAJOR** and the packet records that a designer's derivation of
  its own pre-fix behaviour did not reproduce.
- **either way**: **`BUG-0003`'s severity line stays MAJOR until the two numbers
  return.** It is not CRITICAL today and it is not conformant today; it is
  unmeasured, and that is what the packet says.

### 10.3 What comes back, and who reads it

- **CI artifacts**: the probe job's **run id and conclusion**, and its **captured
  stdout** carrying the per-word table and the delivered-octet sequence —
  externally re-executable at a stated ref, which is the admissibility standard
  `BUG-0003` §V.2 itself turns on and §V.9 item 2 honoured. **A figure quoted from
  a chat message, a local run, or a summary is not admissible** — §V.2's whole
  ground is that DV does not record a severity on evidence it cannot re-execute.
- **The transient tree's own SHA**, stated in the harvest block, so the reader
  knows the probe ran against `fafb83d`'s module content and not against `b848d56`'s.
- **Adjudication is mine**: the orchestrator returns the numbers, I read them
  against §10.2's rule and append the disposition to `BUG-0003`.

### 10.4 Ordering against the bench round

The probe and the phase-A bench round are **independent and may run in parallel**:
they share no file, no base SHA and no denominator, and the probe is print-only.
The only hard constraint is PROTOCOL §10's — **no worker is spawned while the
probe's tree is in its de-mutated state** — so if they overlap, the probe's run
window and tb_writer's spawn window must not. Sequencing them is the
orchestrator's call; if it prefers one at a time, run the probe **first**: it is
one CI run, it unblocks a severity line that has been unmeasured across two RTL
changes, and phase B may not open until phase A's bench has landed anyway.
