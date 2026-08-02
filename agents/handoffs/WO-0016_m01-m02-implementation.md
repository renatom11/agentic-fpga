# WO-0016: Implement M01 `Axi64` and M02 `Crc32_eth` (first RTL activation)
- **State**: ISSUED
- **From** / **To**: orchestrator → rtl_lead
- **Spec basis** (PROTOCOL §10 — this packet is your whole authority):
  SPEC-M01 (docs/specs/modules/axi64.md) and SPEC-M02
  (docs/specs/modules/crc32_eth.md), both **FROZEN at f78766e** and
  byte-unchanged since (the working tree's copies ARE the frozen text;
  §13 of each records the only amendments, none touching §4). ADR-0004
  (Hardcaml v0.17.x from opam), ADR-0005 (CI is the authoritative build
  environment), ADR-0006 (CRC finished-value ports, seed 0x00000000).
  The compile-checked lifts docs/specs/ifc_check/axi64_ifc.ml and
  crc32_eth_ifc.ml elaborate green in CI (latest witness: run
  30736107842) — your modules must expose interfaces the rest of the
  library can `open` with those exact record shapes.
- **Deliverables**, in order:
  1. `libs/hardcaml_ethernet/src/axi64.ml` — SPEC-M01. Types only, no
     circuit: the programme stream types at 64 bits, the `Xgmii`
     lane-pair record, `Eth_header`/`Ip_header`/`Udp_header`,
     `Config`/`Status`, exactly as §4 writes them. This module is the
     vocabulary every later module opens; field names, widths and
     `rtlprefix` attributes are normative from the spec, not stylistic.
  2. `libs/hardcaml_ethernet/src/crc32_eth.ml` — SPEC-M02, on your
     personally-implemented list (charter §2). Combinational CRC-32
     (IEEE 802.3) update for 1–8 octets per cycle: the finished-value
     port convention and seed 0x00000000 per ADR-0006; the per-octet-
     count update matrices per §6/§7. REQ-301…306 govern; §8's anchor
     vectors (residue 0xCBF43926 / complement 0x2144DF1C) are what dv's
     oracle will hold you to.
  3. `.mli` interfaces if and only if the spec's §4 implies a narrower
     public surface than the `.ml` (REQ-903's `.mli` half is still an
     open C-8-adjacent item — do not invent policy; if unclear, return
     the question).
  4. dune wiring so `dune build` covers both modules in CI. Do NOT
     register RTL emission tops for these (M01 has no circuit; M02's
     emission decision belongs to a later packet).
  - Journal **J-rtl_lead-0001** (your first entry — the seed header is
    in agents/journals/claude_rtl_lead_agent.md); Files-in-this-commit
    = exactly what you touch plus this packet. Return log in this
    packet with per-REQ implementation notes and your line-by-line
    self-review (charter §3 requires it even for your own code).
- **Definition of done**: both files written to compile against
  hardcaml v0.17 + hardcaml_axi from reading alone (the container
  cannot run dune — ADR-0005; I round-trip CI and relay the log
  verbatim if red); interfaces record-compatible with the frozen §4.1
  lifts; no REQ silently narrowed; ambiguities returned as questions,
  never guessed.
- **Out of scope**: tests of any kind (dv_lead owns every test that
  gates your modules — charter red line); `test/**`, `tools/**`,
  `docs/**` (spec problems come back as Return-log questions for the
  architect, not edits); M03+ (later packets); RTL emission registration.
## Task
First RTL activation of the programme. M01/M02 have been FROZEN longest
(f78766e, two countersign cycles ago) and sit at the bottom of every
dependency chain — the vocabulary module and the CRC engine the MAC
builds on. Write them as the frozen text says, and say so where the
text made you choose.
## Return / verdict log
