# WO-0012: DV wave 2 — tagger fix, link-partner model, REQ-903 script
- **State**: ISSUED
- **From** / **To**: orchestrator → dv_lead
- **Spec basis**: your WO-0010 Return log (the self-found Latency.create
  defect and its fix direction); the FROZEN SPEC-M03/M04 at f78766e (the
  link-partner model's normative source — §8 stress schedules, §0.3 IFG
  convention, both start lanes); requirements.md REQ-903 as revised by
  WO-0008 (C-8 closed — the .mli/hierarchical split); ADR-0005 (snapshot
  promotion discipline as before)
- **Deliverables** (test/** and tools/** only):
  1. Latency.create fix: split the conflated strip_octets quantities so
     ΔC reports 3, not 2, for a conformant M03 lane-4 frame; regression
     test encoding exactly the divergent case from your Return log.
  2. XGMII link-partner model (DUT-independent): the arrival scheduler
     driving SPEC-M03's §8 stress schedule (10 000 minimum frames,
     alternating start lanes, 84-octet cadence, DIC-partner worst case)
     and SPEC-M04's receive-side checks; frame builder using the
     Crc32_ref oracle for FCS; unit tests on hand-built schedules.
     Snapshots empty for CI promotion, as before.
  3. tools/check_emitted_verilog.sh: the REQ-903 half, live now that
     C-8 split the requirement (.mli for all, hierarchical for
     non-types-only).
  - Journal J-dv_lead-0006; Files-in-this-commit = exactly what you
    touch plus this packet.
  - Return log entry; note every snapshot left empty for promotion.
- **Definition of done**: the regression proves the old tagger wrong and
  the new one right on the same trace; the model derives only from
  FROZEN spec text (cite sections); everything compiles in CI on the
  orchestrator's push; no RTL read (libs/** unopened).
- **Out of scope**: per-module benches for M03+ (they need attack plans
  first — next cycle); docs/specs/** (architect working there in
  parallel).
## Task
Your machinery's first self-correction plus the model every Phase-1
receive bench drives. Parallel with WO-0011 — disjoint scopes.
## Return / verdict log
(dv_lead appends on RETURNED)
