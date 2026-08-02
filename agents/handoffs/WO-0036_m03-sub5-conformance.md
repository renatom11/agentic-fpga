# WO-0036: M03's sub-5-octet frames — the second conviction, same module
- **State**: ISSUED
- **From** / **To**: orchestrator → rtl_lead
- **Spec basis**: WO-0035's ruling on YOUR returned question
  (J-architect_docs_lead-0013 at 1fe71ca): `error_bad_fcs` SHALL
  NOT pulse for a frame below 5 octets — grounded on FROZEN REQ-104
  (the strobe reports a received-FCS-vs-CRC disagreement; this class
  supplies neither operand) and on §9's content-free declaration
  (the 4-octet all-zero frame would accidentally satisfy the residue
  — content-dependence in a content-free class). New §9 ruling 9;
  new plan row M03-M9; M03-F2/B3/N2 strengthened to exact strobe
  sets. Your J-rtl_lead-0005 kept behaviour unchanged from f840475
  and flagged exactly this question — the text has now decided it
  against the shipped behaviour.
- **Deliverables**:
  1. Repair libs/hardcaml_ethernet/src/xgmii_rx_64.ml: a frame
     ending (by any closure) with fewer than 5 received octets
     reports `error_runt` (and its abort/`tuser` marking per the
     existing rules) but NEVER `error_bad_fcs` — the residue
     comparison must not run where no FCS exists. The architect
     expects two-of-three of the 1–4-octet sub-cases to be red in
     your current RTL and the 4-octet all-zero frame to pass by
     accident — verify all three sub-cases in your self-review and
     report what each actually did at d57e028.
  2. State the expected CI outcome (the promotion loop is standard
     now: determinism red with rtl_snapshots/xgmii_rx_64.v +
     eth_mac_10g.v only; tx and word_counter still = defect).
  3. If the fix moves any observable constant dv's rows pin
     (M03-L2/L3's L = 16/12, ΔC = 3), say exactly which.
  4. Real-compile note: dv's WO-0034 harness (tools/
     precompile_check.sh, landing in parallel) may or may not be
     available at your sitting; your obligation stays ADR-0005
     blind-writing discipline either way — but if the harness IS in
     the tree, run it and report what it said.
  - Journal **J-rtl_lead-0006**; Files-in-this-commit exact.
- **Out of scope**: test/**, tools/**, docs/**, bin/**; committing.
## Task
Your own returned question, answered against you — which is the
system working. Close the gap with the same precision as WO-0032.
## Return / verdict log
