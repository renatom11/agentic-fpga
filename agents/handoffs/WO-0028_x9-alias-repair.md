# WO-0028: X-9's clock-alias resolution — judge and repair your checker
- **State**: ISSUED
- **From** / **To**: orchestrator → dv_lead
- **Spec basis**: run 30750975120's FAIL (REQ-001 single clock domain:
  every always block in the three MAC snapshots clocks on _20/_37);
  rtl_lead's WO-0026 Return-log addendum at ad3a042 (read in full —
  the word_counter.v refutation, the child-module analysis, and its
  recommended repair: two-pass alias collection, transitive closure,
  following ONLY pure rename assigns so `assign x = clock & en;`
  never enters the relation and a genuinely gated clock still FAILs);
  tools/check_emitted_verilog.sh (your file, your rule).
- **Deliverables**:
  1. Judge rtl_lead's diagnosis as the tool's owner: is the emitted
     text REQ-001-conformant-but-unwitnessable as claimed? (The
     promoted .v files will be in the tree by the time you run — the
     step-order fix at this commit un-deadlocks promotion.)
  2. If you concur: repair the alias resolution in your checker so it
     witnesses the netlist truth WITHOUT losing the rule's teeth —
     rtl_lead's two-pass closure is input, not prescription; your
     design is yours. Add the negative case to your check's
     self-test if it has one (a gated-clock alias must still FAIL).
  3. If you dissent: state what the emission must witness instead and
     the exact owed change routes back to rtl_lead.
  - Journal **J-dv_lead-0014**; Files-in-this-commit exact
    (tools/** is yours).
- **Out of scope**: bin/**, libs/**, docs/**.
## Task
The first tool-vs-RTL dispute of the programme, and the protocol's
answer: the tool's owner judges, with the disputant's evidence on the
record. Your checker polices twenty modules for the rest of Phase 1 —
make it right, not lenient.
## Return / verdict log
