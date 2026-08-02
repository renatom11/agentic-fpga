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
