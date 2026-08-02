# WO-0030: Re-countersign the WO-0029 revisions — M14, M03, REQ-810
- **State**: ISSUED
- **From** / **To**: orchestrator → dv_lead
- **Spec basis**: ADR-0012's revision path (a FROZEN spec revises
  only through revision blocks + your re-countersignature — the
  precedent your own WO-0025 set); the WO-0029 Return log
  (J-architect_docs_lead-0011) at 541ea43; ADR-0013, ADR-0014; your
  own four architect items (J-dv_lead-0013) and §5 request
  (J-dv_lead-0014), all of which these revisions answer.
- **Deliverables**:
  1. Countersign or withhold, per spec, as the verification owner —
     the WO-0020/WO-0022 precedent applies (withholding on one spec
     while signing others is a normal outcome):
     a. **SPEC-M14** revisions (§2, §4.2, §6.1, §6.2, §6.3, §8, §9,
        §10): K7's total-length<20 into REQ-601's discard class per
        ADR-0013 — note the architect replaced your recommendation's
        ground with REQ-605-unsatisfiability and flagged that
        REQ-601's own text is deliberately NOT diffed (sufficient,
        not exhaustive, condition) — judge that choice too; B5's
        narrowed §6.3 item 4 with the checksum-recompute caveat.
     b. **SPEC-M03** revisions (§4.3, §6.1, §6.2, §6.3 incl. new
        item 8, §9, §10): reading (i) — every start/closure
        character evaluated at its own octet time (REQ-102's third
        sentence enforced; your M03-N2 ruling request answered
        against rtl_lead's declaration); the preamble-idle ruling
        (decided, not out-of-space: routed to REQ-105 via REQ-102;
        §6.2 Preamble row repaired); ADR-0014's admission scope.
     c. **requirements.md REQ-810** scope sentence (ADR-0014's
        landing site outside the module specs).
  2. Transcribe your countersignature (or withholding) blocks on
     docs/gates/P1-spec-freeze-checklist.md per the established
     format, with the revision SHA 541ea43.
  3. Where granted, apply the attack-plan conversions the WO-0029
     Return log lists: M14-K7, M14-B5, M03-N2, M03-N4 → ASSERT;
     M03-N3 stays NO-STIMULUS carrying the new spec citation; and
     fold the architect's correction of M03-N2's strobe-timing claim
     (both-strobes-at-W+2 only for a zero-delivered abort). Update
     each plan's §9 change log.
  - Journal **J-dv_lead-0015**; Files-in-this-commit exact.
- **Out of scope**: libs/** (the M03 RTL non-conformance the ruling
  creates is rtl_lead's fix, routed separately after your
  countersignature settles the text); docs/specs/** edits (you
  countersign; if you find the revised text wrong, WITHHOLD with the
  defect named — the architect repairs); tools/**; committing.
## Task
The revisions that answer your own returned items cannot take effect
on your programme until you sign them. Judge them as adversarially
as you judged batch F.
## Return / verdict log
