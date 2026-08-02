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

### RETURNED — dv_lead, 2026-08-02T21:40Z (spawn `WO-0027/2026-08-02T20:50Z`)

- **State**: ISSUED → **RETURNED** · **Journal**: `J-dv_lead-0013`
- **Derived from**: SPEC-M03 FROZEN `f78766e` + its §13 rows through C-18;
  SPEC-M14 FROZEN `3f6accc` as revised by ADR-0012 at `8641455` (the text I
  re-countersigned at `J-dv_lead-0012`); requirements.md §0.3 … §0.7, §1.1, §2,
  §7, §12; ADR-0006/0007/0008/0009/0012; the WO-0024 Return log §6 questions.
  **`libs/**` was not opened**, at this commit or any earlier one — including
  the M03 RTL that now exists at `f840475`.

#### Deliverables 1 and 2 — the two plans

| Plan | Rows | ASSERT | NO-ASSERT | NO-STIMULUS | RULING | GAP | STRUCTURAL |
|---|---|---|---|---|---|---|---|
| `test/attack_plans/AP-xgmii_rx_64.md` | **73** in 15 families | 55 | 7 | 4 | 2 | 1 | 4 |
| `test/attack_plans/AP-ip_eth_rx_64.md` | **63** in 11 families | 49 | 5 | 2 | 1 | 0 | 6 |

C-37's abort-availability row is **M14-A1** and is the first row of the first
family, with §0 of that plan stating why. The 36/37 pair kills six named wrong
designs, the two off-by-one D-keyed ones included; **M14-A2** (total length 40,
residue 0) kills the M17-word-deficit substitution at a second residue so the
claim is tested rather than witnessed once.

#### Deliverable 3 — the format, which is now the template

`AP-xgmii_rx_64.md` §0 and §1 define it: six cells per row
(**Row · Attacks · Stimulus · Observable · Kills · Status**), stable
`M<nn>-<family letter><index>` ids that are never renumbered, a six-value status
vocabulary (ASSERT / NO-ASSERT / NO-STIMULUS / RULING / GAP / STRUCTURAL), a
§2 standing-obligations section so monitors are stated once, a §3
stimulus-legality section, §5 *attacks considered and rejected*, §6 REQ→row
coverage map, §7 machinery gaps, §8 rulings requested, §9 change log. The
**Kills** cell is the load-bearing one: a row whose kill is "a broken design" is
a row that was not thought about.

#### Deliverable 4 — machinery gaps (named, not built)

X-1 link-partner **error-injection catalogue** with per-frame expected §9
outcomes (the clause `arrival.mli` deferred until this plan existed) · X-2 XGMII
probe · **X-3 strobe monitor** (C-23 high-cycle counting, §9 pinned-cycle check,
§0.6 window) · X-4 idle-injection wrapper carrying M03-N3's preamble constraint ·
X-5/X-9 **per-frame output extent on the latency tagger** (`~tail_octets` is a
run constant; M03's aborts and M14's per-datagram padding both break it — one
repair, two customers) · X-6 `Axi64` stream driver · X-7 M08-output stimulus
model composed from the existing link-partner model · X-8 IPv4 header builder +
**externally anchored** one's-complement checksum oracle in `test/golden/` ·
X-10 OCaml D oracle beside `tools/check_abort_availability.sh` · X-11 M14's
seven strobe cycles.

#### Ledger rows landed as rows

C-12 → M03-E4, G4, G5, M7 · C-18 → M03-A2, C2 · C-26 → M14-E1, E2, E3 ·
C-27 → M14-F2 · C-30 → M14-H2 (with §8 criterion 1's exemption) ·
C-2 → both plans' standing obligation 2 · C-11 → M03-C4 · C-14.3/4/5 → M03-I2,
I4/I5, J4 · C-17(e) → M14-D1 · C-23 → M03-H4, which is the first receive-chain
instance of the high-cycle convention.

#### rtl_lead's three returned questions (WO-0024 §6, items 2–4)

Family N of AP-M03. Q2 → **M03-N1** (decided by §9's closure list: ASSERT) and
**M03-N2** (RULING: §6.1 routes a preamble-position `/T/` to REQ-107, so the
text-strict reading pulses `error_runt` where rtl_lead's declared one-closure
reading does not — the readings differ in one observable, and under the declared
one a frame is opened and never reported, a hole in §0.6). Q3 → **M03-N3**
(NO-STIMULUS, and it pins the idle-injection wrapper's contract). Q4 →
**M03-N4** (RULING: §4.3's two sentences point opposite ways).

#### Four items for the architect (via the orchestrator)

1. **M14-K7 — new, and the sharpest**: SPEC-M14 §6.1's "total length ≥ 20 by
   construction of REQ-601's IHL check" is **false** — IHL fixes the header
   length, not the total-length field — so a datagram declaring total length
   0 … 19 passes all six header conditions and reaches a `Header` branch that
   covers neither of its cases, with M = ⌈(N′ − 20)/8⌉ negative. C-26's family,
   reachable and adversary-controlled. Recommendation: fold it into REQ-601's
   class (same cycle, no new strobe, no new REQ).
2. **M14-B5 / open question 2**: §6.3 item 4's silence on DF and the reserved
   bit makes a more-fragments **bit-position** defect unkillable at M14. One
   sentence (a DF-set, MF-clear, offset-0 datagram meets no discard condition
   and is accepted) converts it into a row.
3. **M03-O2 (editorial, one cell)**: SPEC-M03 §10's REQ-014 hook names the
   differential run, which has **no instance** at M03 — the input is an XGMII
   lane pair with no `tstrb` (REQ-010 class (b)). C-41's family; repair in the
   form SPEC-M14 §10 already uses for REQ-404/REQ-810.
4. **Clerical**: the `P1-spec-freeze` ledger's unnumbered dv-machinery row
   (`Latency.create`'s conflated quantities) was discharged at WO-0012 and
   carries no id and no closure mark.

#### For the orchestrator

Stage exactly the three paths in `J-dv_lead-0013`'s Files-in-this-commit. No
`test/**` code, no `docs/**`, no `docs/gates/**`, no benches. `git commit` /
`git push`: never run.
