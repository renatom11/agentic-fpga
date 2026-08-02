# WO-0035: Second spec queue — two M03 questions now load-bearing, one owed cell
- **State**: ISSUED
- **From** / **To**: orchestrator → architect_docs_lead
- **Spec basis**: rtl_lead's WO-0032 Return-log returned questions
  (J-rtl_lead-0005 at d57e028); dv's C-43 (WO-0030 §6, the flagged
  question you answered whose diff you deliberately did not land);
  C-46/C-47 (dv's ledger rows naming requirements.md REQ-810's
  verification column and SPEC-M03 §9 rows 8/9 — both non-blocking,
  both one cell); the ADR-0012 revision discipline as before.
- **Deliverables**:
  1. **rtl Q(a), now load-bearing**: does `error_bad_fcs` pulse for
     a sub-5-octet frame? SPEC-M03 §9 row 6 lists only `error_runt`,
     while the residue form makes the seed a mismatch. rtl_lead kept
     behaviour unchanged from f840475 but the WO-0029 ruling makes
     the frame reachable at REQ-102's newly commissioned stimulus —
     rule it, and state which attack-plan row it creates or kills.
  2. **rtl Q(b)**: the WO-0032 packet's `/S/`-lane-2 example — a
     start character outside lanes 0/4 closes but opens nothing
     (§6.3 item 3, REQ-101). The example was mine, in the WO packet,
     not in any spec; confirm rtl_lead's reading in one sentence in
     your Return log (no spec diff owed unless you find one).
  3. **C-43**: requirements.md §12's `error_ip_bad_header` condition
     cell gains ADR-0013's third disjunct. One cell; the ADR is
     already signed; dv held it non-blocking. requirements.md
     revisions carry the countersign discipline — flag whether this
     cell is normative enough to need dv's signature or is the
     editorial class (your call, stated).
  4. **C-46 and C-47** (optional, dv does not require them now):
     REQ-810's verification-column scope; SPEC-M03 §9 rows 8/9's
     missing classification row. Take them only if the commit stays
     clean.
  - Journal next id in your sequence; Files-in-this-commit exact.
- **Out of scope**: everything else; libs/**, test/**, tools/**;
  committing.
## Task
Small, sharp, and mostly cells — but Q(a) gates a bench row and the
text should decide it before the bench does.
## Return / verdict log
