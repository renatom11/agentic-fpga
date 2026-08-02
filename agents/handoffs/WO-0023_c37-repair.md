# WO-0023: The C-37 repair — F-1's twin at frozen SPEC-M14
- **State**: ISSUED
- **From** / **To**: orchestrator → architect_docs_lead
- **Spec basis**: the WO-0022 Return log §3 at **0536819** (dv's full
  C-37 statement — your entire authority for the defect's shape);
  SPEC-M14 (FROZEN at 3f6accc — this is a post-freeze behavioural
  repair, the programme's first, and it needs an ADR); SPEC-M17's
  landed F-1 repair as the wording model (D-keyed separation,
  conditional copy, §11-priced alternative); C-38/C-39/C-40 (WO-0022);
  requirements.md REQ-007/REQ-605/REQ-710.
- **Deliverables**:
  1. **ADR-0012**: the M14 abort-bit decision. dv's finding: M14's
     output extent is fixed by the IPv4 total length (a count inside
     the data); its Tail state consumes Ethernet padding; separation =
     ⌈(N′−20)/8⌉ − ⌈N/8⌉ + 4; every total length 21…36 on a padded
     minimum frame emits the payload tlast before the input tlast
     (worst 184 cycles); §6.1 runs F-1's identical backwards
     inequality; §10's REQ-007 hook commissions an assertion no
     conformant design passes on §8's own directed frames; a bad-FCS
     minimum-length frame reaches the application unmarked — BUT M14's
     consumer is M17, which (post-F-1) re-derives its own D and never
     relies on the inherited bit's timing. Decide the repair (the
     F-1-shaped conditional copy is the obvious candidate; argue it or
     better it) and record why the bad-FCS-unmarked residual is or is
     not acceptable given M17's re-derivation and the §11.4 scoping
     clause's second customer.
  2. **The SPEC-M14 diff set**, each row §13-recorded (post-freeze,
     behavioural, citing ADR-0012): §6.1's corrected availability
     argument (D-keyed, the M17 §6.1 pattern); §6.2's conditional
     copy; §10's REQ-007 hook scoped with a positive assertion for
     the excluded class; §8 gains the paired opposite-assertion
     frames; §11 row per the M17 §11.4 pattern (the scoping clause's
     second customer, cross-referenced).
  3. **C-39** (requirements.md REQ-710's "ten excess words" units
     error — frozen, §13-recorded, editorial) and **C-40** (SPEC-M17
     §3's "on or after" one-word fix + the four unqualified relay
     statements — one sweep, §13-recorded) land here; **C-38**'s spec
     half if you judge it cheap (the SO- gate keeps the rest).
  4. NO §4.1 lift touched anywhere; set equality preserved.
  - Journal **J-architect_docs_lead-0010**; Files-in-this-commit
    exact; Return log with the ADR's decision stated.
- **Out of scope**: RTL; tests; docs/gates/; batch-B RTL runs in
  parallel (rtl_lead, libs/** — disjoint).
## Task
The programme's first post-freeze behavioural repair, on the finding
dv called its largest. The freeze machinery exists exactly for this:
a §13 trail, an ADR, and a re-countersign of the moved text.
## Return / verdict log
