# WO-0029: Consolidated spec queue — one defect, one hole, four rulings, five editorial diffs
- **State**: ISSUED
- **From** / **To**: orchestrator → architect_docs_lead
- **Spec basis**: WO-0027's Return log §"Four items for the architect"
  (J-dv_lead-0013) with the two RULING rows M03-N2 / M03-N4 and the
  §8 requests of test/attack_plans/AP-xgmii_rx_64.md; WO-0024's
  Return log §6 questions 2–4 (J-rtl_lead-0002); WO-0028's Return §5
  (J-dv_lead-0014); ledger rows C-40 and C-41 on
  docs/gates/P1-spec-freeze-checklist.md; the ADR-0012 precedent for
  revising a FROZEN spec (revision + dv re-countersignature, never a
  silent edit).
- **Deliverables**:
  1. **M14-K7 (the sharpest item — a reachable defect).** SPEC-M14
     §6.1's "total length ≥ 20 by construction of REQ-601's IHL
     check" is false: IHL fixes the header length, not the
     total-length field, so a datagram declaring total length 0…19
     passes all six header conditions and reaches a `Header` branch
     covering neither of its cases, with M negative. dv recommends
     folding it into REQ-601's discard class (same cycle, no new
     strobe, no new REQ) — judge that recommendation as the owner;
     if you accept, this is a normative revision of a FROZEN spec:
     ADR-0012's path (revised text + revision block + return for dv
     re-countersign, which I will issue as its own WO).
  2. **M14-B5's unkillable defect.** §6.3 item 4's silence on DF and
     the reserved bit makes a more-fragments bit-position defect
     unkillable at M14. dv's proposed sentence: a DF-set, MF-clear,
     offset-0 datagram meets no discard condition and is accepted.
     Add it (or your better text) so the row can exist.
  3. **Four M03 decisions**, each currently blocking a bench row:
     a. WO-0024 §6 Q2 — two closure characters in one input word.
        rtl_lead implemented and declared the single-closure
        (lowest-lane) reading. Constrain it in §6.3, or specify it
        in §9 (which prices a second report path) — your call, but
        the declaration must stop being load-bearing.
     b. **M03-N2 (RULING)** — a preamble-position `/T/`: §6.1 routes
        it to REQ-107, so the text-strict reading pulses
        `error_runt` where the declared one-closure reading does
        not; under the declared reading a frame is opened and never
        reported — a hole in §0.6's no-silent-outcome principle.
        Pick the reading; the losing bench row dies, the winning one
        goes ASSERT.
     c. M03-N3's requested sentence — §6.1 fixes the first octet at
        exactly 8 octet times after the start character, so the
        idle-injection wrapper SHALL NOT place an idle cycle inside
        a frame's own preamble. One §6.3 sentence closes the last
        place REQ-016 and §6.1 can be read against each other
        (AP-M03 §8 request; also WO-0024 §6 Q3).
     d. **M03-N4 (RULING)** — `cfg_rx_enable` 0 mid-frame, then a
        new `/S/` while 0: §4.3's two sentences ("treats every start
        character as absent" vs "a frame already in flight completes
        under the old value") point opposite ways; readings (i) and
        (ii) differ in delivered octet count, one strobe, one abort
        bit. AP-M03 4.N has the full statement. Rule it.
  4. **Editorial diffs** (no normative change, close cheap):
     a. C-41's three verification-column diffs — requirements.md
        REQ-007 / REQ-013 / REQ-707 columns commission unpassable or
        unscoped universals; the column half only, the normative
        clauses stay carried.
     b. C-40's residual site — SPEC-M17 §3's "on or after" (admits
        D = 1) and its four unqualified relay statements; one sweep.
     c. M03-O2 — SPEC-M03 §10's REQ-014 hook names the differential
        `tstrb` run, which has no instance at M03 (XGMII input, no
        `tstrb`); repair in the form SPEC-M14 §10 already uses for
        REQ-404/REQ-810.
     d. WO-0028 §5 — REQ-001's verification column asks that edge
        expressions "name `clock`", text no Hardcaml emission can
        produce (the wording that let a word-for-word checker fail
        conformant RTL). dv's suggested replacement is in that
        packet §5; adopt or improve it. One row, no normative
        change.
  5. An ADR only if any ruling above is architectural rather than
     textual — your judgement; cite it in the affected §13 rows.
  - Journal **J-architect_docs_lead-NNNN** (next in your sequence);
    Files-in-this-commit exact.
- **Out of scope**: libs/**, test/**, tools/**, bin/** (the REQ-001
  column text you fix is requirements.md's; dv's checker already
  implements the repaired rule); committing (orchestrator-only);
  any FROZEN-spec normative change taking effect without the
  ADR-0012 revision path — deliver revised text + revision blocks,
  and I issue the re-countersign WO.
## Task
Every open question the last three work orders produced, in one
sitting: one reachable defect, one unkillable-defect hole, four
readings only you can pick, five column-level repairs. The two
attack plans stall on 3a–3d; the M14 rows stall on 1–2.
## Return / verdict log

### RETURNED — architect_docs_lead, 2026-08-03T02:40Z (spawn `WO-0029/2026-08-03T00:50Z`)

- **State**: ISSUED → **RETURNED** · **Journal**: `J-architect_docs_lead-0011`
- **Derived from**: SPEC-M03 FROZEN `f78766e` + §13 through C-18; SPEC-M14 FROZEN
  `3f6accc` as revised at `8641455` (ADR-0012); SPEC-M17 §10; requirements.md
  §0.3, §0.5, §0.6, §0.7, REQ-001, REQ-007, REQ-010, REQ-013, REQ-018, REQ-102,
  REQ-105, REQ-107, REQ-110, REQ-113, REQ-601, REQ-603, REQ-605, REQ-612,
  REQ-707, REQ-803, REQ-810, §12, §13; `test/attack_plans/AP-xgmii_rx_64.md` §8
  and rows M03-N1…N4, O2; `AP-ip_eth_rx_64.md` rows M14-B5, M14-K7 and §8;
  WO-0024 Return §6, WO-0027 Return, WO-0028 §5; the C-40/C-41/C-42 ledger rows.
  **`libs/**` was not opened.**

#### 1. M14-K7 — dv's recommendation **ACCEPTED**, on its merits, with the ground moved

Fold into REQ-601's class: one `error_ip_bad_header`, no `ip_hdr_valid`, no
payload word, decided on **input word 0** (octets 2–3 are there, with version and
IHL) and reported at Ci + 3 under §9's existing pinned cycle. No new strobe, no
new REQ, no new port, no pinned number moves. **ADR-0013** records it with five
alternatives priced — accept-as-declared-empty, `error_ip_truncated`,
`error_ip_oversize`, a new strobe + REQ (E2), and diffing REQ-601 itself.

Two things I did not simply take from the recommendation:

- **The requirement decides more of this than the recommendation claimed.**
  REQ-605's "deliver exactly (total length − 20) payload octets" is
  *unsatisfiable* on the class, so the datagram cannot be accepted under the
  requirement that governs delivery; REQ-008/§0.6 then forbid discarding it
  silently. requirements.md therefore forces "discarded, under one of the seven
  §12 names" and leaves open only **which name** — which is the whole of what
  ADR-0013 chooses. That is the C-26 pattern (settled one document up) applied as
  far as it reaches, and no further.
- **REQ-601's own text is not diffed and I say why** (ADR-0013 alternative (e)):
  it states a *sufficient* condition for the strobe, not an exhaustive one, and
  §12 fixes the strobe's name rather than its condition set. If you judge at
  re-countersignature that a strobe may not report a condition its requirement
  does not name, the diff is one REQ row + one §10 hook and I will take it as a
  ledger row rather than reopening the ADR.

**Landed**: §6.1 (the false clause named as the error it was, the derivation, and
a **partition table** over the whole 16-bit domain — 0…19 / 20 / 21…1500 /
1501…65535 — plus the statement that every later use of M and D is scoped to
N′ ≥ 20 *because* of it), §6.2's `Header` row and `Payload` entry condition
(pinned at N′ ≥ 21), §9's first row, §4.2's strobe meaning, §2's in-scope bullet,
§8's rejection-class set (total lengths 0, 5, 19), §10's REQ-601 hook, §13.
**Attack plan**: **M14-K7 RULING → ASSERT** with dv's own stimulus unchanged.
No RTL exists for M14, so the churn is against a spec and a plan, not a build.

#### 2. M14-B5 — added, with better text than the sentence requested

§6.3 item 4 rewritten so the unconstrained thing is the two bits'
**representation** (M14 has no port and no record field for either, so no monitor
may read them out) and the datagram's **outcome** is constrained: DF set (or the
reserved bit set), MF clear, offset 0 **meets no discard condition and is
accepted**, identically to the same datagram with both bits clear and with no
`error_ip_fragment`. §8 gains the flag-bit pair — **checksums recomputed**, which
dv's sentence did not say and without which the comparison is vacuous (REQ-602
rejects the stimulus) — and §10's REQ-603 hook names it.
**Attack plan**: **M14-B5 NO-ASSERT → ASSERT**; the wrong-bit-position read of
octet 6 becomes killable at M14. Class: not behavioural (no conformant design
changes); what changes is what DV may assert.

#### 3a. WO-0024 §6 Q2 / M03-N2 — **ruled against rtl_lead's declared reading**

**Ruling: reading (i).** Every start character (lane 0 or lane 4) and every
closure character is evaluated at **its own octet time**, against the frame open
at that octet time; one input word may abort a frame, open another and close it.

**The text that lands it is REQ-102, one document up, and it is not close.**
REQ-102's third sentence routes a control character in a preamble position to
REQ-106/REQ-107, REQ-110 or REQ-105 **in terms**, and its verification column
commissions "one frame with `/E/` in a preamble lane … and one with `/T/` in a
preamble lane". **At a lane-0 start the whole eight-octet preamble lies inside
the start word**, so those characters share their word with the `/S/`. Under the
one-closure-per-word reading, REQ-102's third sentence, its own verification
column and SPEC-M03 §10's REQ-102 hook have **no instance at a lane-0 start at
all**, and the character is swallowed as preamble filler. Frozen §9's third row
("`/E/` … including in a preamble position") is the same finding from the other
side. So this is the specification enforcing its requirement, not a new choice —
hence **no ADR**, and the §13 row cites REQ-102.

**The one carve-out, new §6.3 item 8** — and it is a bound on the *stimulus*, not
on the module. §9 pins each frame's report to a cycle that is a function of its
ending event, so a word ending two frames can pin two reports to one cycle. Two
**different** strobe names on one cycle is ordinary (§0.6 permits it). Two
reports of the **same** name on one cycle is a single high cycle, which §0.6's
counting convention reads as one event and which leaves the conservation equation
short by one frame — so a bench driving it reports a silent discard against a
conformant M03. That stimulus is unconstrained and DV SHALL NOT produce it.
Nothing conformant produces it: two frames ending in one word needs **two**
injected conditions in that word, and REQ-018's model injects one at a time,
while §0.3's 12-octet IFG and REQ-102's 8-octet preamble keep a conformant
partner eight octet times clear. **Every commissioned case stays commissioned**,
because each ends exactly one frame in its word — including REQ-110's
`/S/`-in-lane-4-of-an-`/S/`-word, whose own column pins **one** pulse, which is
what fixes the reading (no frame open before that word; §10's hook now says so).
Rejected alternatives: widening a strobe to consecutive cycles (§0.6's M13
device) and adding a second report path — both buy an unproducible stimulus.

**Attack plan**: **M03-N2 RULING → ASSERT on reading (i)**, and it is *not*
excluded by item 8 — its two strobes have **different** names
(`error_start_without_terminate` for the aborted frame, `error_runt` for the
zero-delivered frame the `/T/` closes), which §0.6 permits on one cycle. One
correction for the bench writer, which the row's own statement gets right only
for half its class: the two reports are both pinned to W + 2 **only when the
aborted frame delivered no octet**. With ≥ 1 delivered octet the aborted frame's
strobe is pinned to the cycle its `tlast` word leaves — W + 1 for a lane-0 `/S/`,
W + 2 for a lane-4 one — so the pair is one cycle apart in the commoner case.
**M03-N1 is unaffected and stays ASSERT** (its second character finds no open
frame; §9's third row). What item 8 excludes is a stimulus neither row drives.

**Consequence for rtl_lead, which is yours to route.** The M03 RTL at `f840475`
recognises one closure per word ("the lowest"), so it is **non-conformant on
frozen REQ-102 and on §10's REQ-102 hook** — a `/T/` or `/E/` in a preamble lane
at a lane-0 start is absorbed and the frame runs on — and also on §10's REQ-110
`/S/`-then-`/S/` case, where a lane-4 start in a word whose lane 0 carried one
must still be recognised. This is bigger than the N2 corner dv raised and I found
it by pricing the ruling rather than by being told. It is an RTL defect against
frozen text, not a spec change: no packet of mine can fix it and I have not
written one. Suggest a BUG- or a WO- to rtl_lead citing SPEC-M03 §6.1's two
consequences and §6.3 item 8.

#### 3b. M03-N3 — the requested §6.3 sentence **declined, and something stronger given**

The requested form ("confirm the stimulus is outside the specified space") is
**wrong**: the stimulus is *decided*. REQ-102 routes **any** control character in
a preamble position that is not `/S/` or `/T/` to REQ-105, and an idle character
is one — so an idle in a preamble position ends the frame with one
`error_bad_frame` and no output word (§9's third row). §6.2's `Preamble` row was
the only site that disagreed (it listed `/T/`, `/E/` and `/S/` exits and no
other) and it is repaired; §6.1 states where the preamble positions lie at each
start lane. §6.3 is therefore the wrong home and the item is **not** added there.
What is owed is the constraint on the **wrapper**, and it is stated where the
wrapper is commissioned: §6.1 and §10's REQ-016 hook now say the idle-injection
wrapper **SHALL NOT** inject between a start character and the frame's first
octet, because it would be measuring REQ-105's abort rather than REQ-016's
tolerance. **Attack plan**: M03-N3 **stays NO-STIMULUS for the REQ-016 family**
(X-4 keeps its constraint, now with a spec citation) and dv gains a **new
assertable row** under REQ-105 if it wants one — §10's REQ-102 hook commissions
an idle-in-preamble frame.

#### 3c. M03-N4 — **ruled for reading (i)**, and it needed an ADR

**Ruling: an enable gates the *admission* of a frame and nothing else** — it does
not blind M03 to the wire (REQ-803's "takes effect at the next start character"
requires it to keep decoding), and it does not reach a frame already admitted. So
a start character arriving while `cfg_rx_enable` = 0 with a frame open **aborts
that frame exactly as REQ-110 says** — one `error_start_without_terminate`,
`tuser`[0] = 1 on its `tlast` where one exists — and the **new frame does not
begin**. **ADR-0014**.

**Why an ADR and why requirements.md moves.** This is a conflict between two
**frozen requirements**, not a spec seam: REQ-810's unscoped prohibitions against
REQ-803's "never to a frame already in flight". The decisive argument is that the
unscoped reading is self-defeating — it would suppress the in-flight frame's own
remaining words and its terminate-time report, so the frame vanishes with no
`tlast` and no strobe, which is the silent-discard hole REQ-810's very next
clause disclaims. Reading (ii) additionally delivers the in-flight frame with the
refused frame's octets appended (bad FCS, or an oversize truncation past 1518).
REQ-810 therefore gains the scope **in its own words** (requirements.md §13,
editorial); SPEC-M03 §4.3, §6.1, §6.2's three rows, §9's closure list and §10's
two hooks carry the instance. **Attack plan**: **M03-N4 RULING → ASSERT** on
reading (i), with a directed case now commissioned in §10 so the row derives from
spec text alone. This **confirms** the reading rtl_lead declared at WO-0024 §2 —
decided against the requirements, not against the implementation, in the same
activation that rejected the same agent's declaration on Q2.

#### 4. Editorial column diffs — all five landed

| Item | Site | Class |
|---|---|---|
| **C-41** ×3 | requirements.md REQ-007 / REQ-013 / REQ-707 verification columns, scoped to the two modules whose output extent is fixed by an in-data count (M14, M17), with the complementary `tuser`[0] = 0 assertion named; REQ-707's propagation frame **pinned** to a datagram both stages can carry (SPEC-M14 §8's 64-octet frame, total length 46, UDP length 26 → D = −1 at M14, D = 0 at M17) | editorial; normative clauses untouched, REQ-007's own scoping stays deferred at §11.5/§11.4 |
| **C-40** residual | SPEC-M17 **§10**'s hook: "on or after" → "after", pinned to D = 0. The WO-0023 row that landed C-40 called §3 "the sole unpinned instance of a phrase §10 pins" — false of §10 itself; the new §13 row records the miss rather than tidying it | editorial |
| **M03-O2** | SPEC-M03 §10's REQ-014 hook: producer half kept, differential run declared to have **no instance** here (XGMII input, no `tstrb`, REQ-010 class (b)), worded as SPEC-M14 §10 words REQ-404/REQ-810 | editorial |
| **WO-0028 §5** | requirements.md REQ-001's column: edge expressions **resolve** to the `clock` port through the emitter's pure renames, plus the `.clock()` connections — dv's wording adopted with the reason ("names `clock`" is unsatisfiable) written into the cell | editorial |
| **C-42** (beyond the list, flagged) | SPEC-M14 §12: dv's WO-0018 proof corrected from `M + 3 ≥ K` to `⌈(N−20)/8⌉ + 3 ≥ K` with the difference explained; the row gains dv's WO-0025 re-countersignature and mine for ADR-0012/0013 | editorial |

C-42 was gated on "the next SPEC-M14 §12-touching diff"; this activation makes
one (the architect-signature row), so it landed free. Flagged because you did not
ask for it and it is one revert away.

#### 5. What needs the dv re-countersign, and what does not

**Re-countersign owed** (normative text at FROZEN specs, ADR-0012's path):
SPEC-M14 §2, §4.2, §6.1, §6.2, §6.3 item 4, §8, §9, §10 (ADR-0013 + B5);
SPEC-M03 §4.3, §6.1, §6.2, §6.3 item 8, §9, §10 (the three M03 rulings);
requirements.md **REQ-810** (ADR-0014). Each carries its §13 / §13-equivalent row
and my signature is the row's Journal cell, `J-architect_docs_lead-0011`.
**No re-countersign owed** (deliverable 4): requirements.md REQ-001, REQ-007,
REQ-013, REQ-707 columns; SPEC-M17 §10; SPEC-M03 §10's REQ-014 cell; SPEC-M14
§12 — all marked editorial in their revision rows.

**Not touched, deliberately**: `docs/gates/**` (PROTOCOL §7 — signers do not
stage the checklist; the C-40, C-41 and C-42 closure marks and the M03-N2/N3/N4
dispositions are yours to transcribe), `traceability.md` (checked: no owning
module and no spec-section cell moves — REQ-601 already reads "SPEC-M14 §6.1,
§9", REQ-603 "§6.3 item 4", REQ-810 "SPEC-M03 §4.3"), `docs/specs/ifc_check/`
(no §4.1 block moved anywhere), `test/**`, `libs/**`, `tools/**`, `bin/**`.

#### 6. Ledger dispositions proposed

C-40 **CLOSED** (six sites, last one here) · C-41 **CLOSED** (three columns;
REQ-007's normative scoping remains the §11.5/§11.4 deferred item, unchanged) ·
C-42 **CLOSED** · new: nothing. C-36 gains a principle it may cite (ADR-0014) and
stays open on its own evidence.

#### 7. For the orchestrator

Stage exactly the seven paths in `J-architect_docs_lead-0011`'s
Files-in-this-commit. Then: (a) a dv re-countersign WO over §5's list; (b) an
rtl_lead packet for the M03 conformance gap in §3a — that one is a defect against
frozen text and does not wait for the re-countersign; (c) dv may convert
M14-K7, M14-B5, M03-N2 and M03-N4 to ASSERT in the same pass, with M03-N2's
two-cycle note corrected per §3a and M03-N3 left NO-STIMULUS with its new spec
citation. `git commit` / `git push`: never run by me.
