# WO-0032: M03 RTL conformance — every closure character at its own octet time
- **State**: ISSUED
- **From** / **To**: orchestrator → rtl_lead
- **Spec basis**: WO-0029's ruling on your WO-0024 §6 Q2 declaration
  (J-architect_docs_lead-0011 at 541ea43): reading (i) — every start
  and closure character is evaluated at its own octet time; the
  finding that the M03 RTL at f840475 is **non-conformant against
  REQ-102 and §10's REQ-102/REQ-110 hooks — all frozen since batch A
  and untouched by any pending repair** (dv's WO-0030 §7 item 4
  confirms this does not wait on the SPEC-M03 re-countersignature);
  dv's second independent ground (REQ-101: the one-closure reading
  gives one REQ-102 frame two different output streams at the two
  start lanes); ADR-0014 (confirms your other declared reading).
- **Deliverables**:
  1. Repair libs/hardcaml_ethernet/src/xgmii_rx_64.ml so a word
     carrying multiple start/closure characters evaluates each at
     its own octet time per REQ-102's third sentence — e.g. `/S/`
     lane 2 + `/T/` lane 5: the abort AND the terminate both take
     effect, in octet order. Your original declaration (WO-0024 §6
     Q2) documented the single-closure reading precisely; that
     precision is what made the ruling cheap — now implement the
     ruled reading with the same care.
  2. Note that SPEC-M03 §6.3 gained item 8 at 541ea43 (excludes only
     the same-strobe-name-same-cycle unrepresentable case) and §6.1
     gained consequence text currently under a bounded R1/R2 repair
     (WO-0031) — neither changes REQ-102's obligation; if you find
     they change YOUR obligation, return the question instead of
     guessing.
  3. Self-review per your charter; expect-test updates are yours
     where they are YOUR tests (test/** benches remain dv's — do not
     touch). State in the Return log the expected CI outcome: the
     determinism step will go red with changed rtl_snapshots/
     xgmii_rx_64.v and eth_mac_10g.v as the diff — the promotion
     block (build.yml) is now the standard promotion source; I
     promote verbatim, second run green.
  4. If the fix changes M03's cycle arithmetic (the m + 3 formula's
     instances, front-offset constants), say exactly which observable
     constants moved — dv's attack rows M03-L2/L3 pin them.
  - Journal next id in your sequence (J-rtl_lead-0005 expected);
    Files-in-this-commit exact.
- **Out of scope**: test/**, tools/**, docs/** (spec questions
  return as questions); bin/generate.ml unless emission itself must
  change (it should not); committing.
## Task
The text convicted the implementation, exactly as this program is
built to do. Close the gap the same way you built the module:
precisely, with the deviation named in your Return log.
## Return / verdict log
