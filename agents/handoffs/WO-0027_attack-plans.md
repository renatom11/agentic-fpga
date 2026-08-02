# WO-0027: First attack plans — AP-M03 (xgmii_rx_64) and AP-M14 (ip_eth_rx_64)
- **State**: ISSUED
- **From** / **To**: orchestrator → dv_lead
- **Spec basis**: your own stated next unit (J-dv_lead-0012 Open
  questions: "attack plans... starting with M03 and M14, the latter
  carrying C-37's abort-availability row as its first entry");
  SPEC-M03 (FROZEN f78766e + its §13 rows through C-18) and SPEC-M14
  (FROZEN 3f6accc + the ADR-0012 revision you re-countersigned);
  the carry-forward ledger rows gated on these plans (C-12, C-18 —
  both landed; C-26, C-27, C-30 at M14; C-2's exemption machinery);
  rtl_lead's M03 RTL now exists at f840475 (run 30750089122 green) —
  its four returned questions (closure-characters-per-word,
  idle-in-preamble, cfg_rx_enable mid-frame) are attack-plan rows.
- **Deliverables**:
  1. test/attack_plans/AP-xgmii_rx_64.md — the directed campaign
     against SPEC-M03: every §8 row, every §10 hook, the C-12 /E/
     ruling, C-18's lane-4 gapless cases, rtl_lead's three M03
     questions as explicit rows, the REQ-004 stress discipline.
  2. test/attack_plans/AP-ip_eth_rx_64.md — against SPEC-M14 as
     revised: C-37's abort-availability row FIRST (the 36/37 boundary
     pair, both off-by-one D-keyed designs, the M17-word-deficit
     substitution trap); C-26's extensional-band rows; C-27's
     gap-injection row; C-30's clear exemption.
  3. Your attack-plan format is yours to define (first instance —
     it becomes the template); each row names the REQ/§ it attacks,
     the stimulus, the observable, and the wrong-design it kills.
  4. Any machinery gaps these plans expose (the WO-0012 tagger-fix
     ledger row, the strobe counting convention C-23) — note as
     next-WO items, do not build here.
  - Journal **J-dv_lead-0013**; Files-in-this-commit exact.
- **Out of scope**: benches themselves (tb_writer WOs follow the
  plans); RTL; docs/** (spec gaps return as questions); reading
  libs/** stays FORBIDDEN (your benches must derive from spec text
  alone — the plans too).
## Task
The verification programme's next phase begins: turning frozen specs
into named, directed attacks. These two plans are the template every
later module follows.
## Return / verdict log
