# Agentic FPGA — a Hardcaml trading NIC, built end-to-end by an agent org

An experiment in agent-driven hardware engineering: a phased, Jane-Street-style
FPGA project — a **low-latency trading NIC front end** written in
[Hardcaml](https://github.com/janestreet/hardcaml) (OCaml hardware DSL) —
where the **entire development lifecycle is executed by a hierarchy of Claude
agents**: architecture, RTL, verification, validation, documentation, and an
independent audit function, orchestrated by a Fable 5 session that reports to
a human sponsor.

## The project

| Phase | Scope |
|---|---|
| **1** | XGMII-level 10G Ethernet MAC (64-bit datapath @ 156.25 MHz, CRC-32 FCS, IFG) + ARP/IPv4/UDP hardware stack, differentially verified against [verilog-ethernet](https://github.com/alexforencich/verilog-ethernet) |
| **2** | MoldUDP64 + NASDAQ ITCH 5.0 feed handler (line-rate realignment parser) + single-symbol limit order book (BRAM hash, top-of-book + 8 levels), replaying a real NASDAQ trading day with lockstep golden-model checking and per-message latency histograms (cycles × 6.4 ns) |
| **3** (stretch) | 10GBASE-R soft PCS (64b/66b, scrambler) + wire-to-wire latency report |

Simulation-first: everything from the XGMII boundary inward is designed and
verified in Hardcaml's cycle-accurate simulator and Verilator. PMA/serdes
bring-up is explicitly out of scope; XGMII is the hardware attach point.

## The org

**Start at [`ORG_CHART.md`](ORG_CHART.md).** Every agent has a
version-controlled charter in [`agents/charters/`](agents/charters/) defining
its responsibilities, interfaces, definition of done, evaluation criteria, and
escalation rules. Shared rules live in
[`agents/PROTOCOL.md`](agents/PROTOCOL.md). Live program state is in
[`tasks/BOARD.md`](tasks/BOARD.md).

## The journaling guarantee

Every agent keeps an **append-only journal**
(`agents/journals/claude_<name>_agent.md`) and every commit couples one
agent's work with that agent's journal entry explaining it — mechanically
enforced by [`scripts/agent_commit.sh`](scripts/agent_commit.sh) and
re-verified over every pushed range by CI
([`.github/workflows/journal-check.yml`](.github/workflows/journal-check.yml)).

Consequences you can rely on:

- `git diff A..B` — for *any* two commits — shows both what changed and the
  reasoning that produced it, side by side in the same diff.
- `git log --grep 'Agent: rtl_lead'` reconstructs any one agent's entire
  thread of work.
- Journal history cannot be quietly rewritten: the append-only property is
  re-checked over the FULL history on every push (an incremental range check
  cannot detect a rewrite — AUD-0001-F3), and backstopped by branch protection
  on `main` and the working branch (a one-time sponsor setup, G0 item 9), and
  journal `Evidence` sections are falsifiable — the auditor re-executes them
  at the recorded SHA.

Run the enforcement self-test: `bash scripts/test_protocol.sh`.

## Status

**M0 — Org & charter.** The agent org, operating protocol, and enforcement
machinery are being stood up; no RTL exists yet. Toolchain and first specs
arrive in M1. Milestone↔phase map: M0 org, M1 toolchain+specs, **M2 = Phase 1,
M3 = Phase 2, M4 = Phase 3 (stretch)** — see [`tasks/BOARD.md`](tasks/BOARD.md)
for the roadmap and open gates. Sponsoring this project? Your duties live in
[`docs/SPONSOR.md`](docs/SPONSOR.md).

## Repository map

```
ORG_CHART.md          the org: chart, roster, execution model
agents/
  PROTOCOL.md         shared operating constitution (journals, commits, gates)
  charters/           per-agent instruction files — open any of them
  journals/           append-only reasoning logs, one per agent
  handoffs/           versioned work orders, sign-offs, bug packets
docs/
  adr/                architecture decision records
  gates/              committed gate checklists (signatures = journal refs)
  specs/              (M1+) frozen module specs, REQ-### requirements
  reports/audit/      auditor findings, DV-escape ledger
  reports/latency/    (M3+) latency characterization
scripts/              protocol enforcement + self-test
tasks/BOARD.md        live program state
.claude/agents/       thin spawn launchers (charters remain the truth)
libs/ top/ test/ bin/ tools/   (M1+) Hardcaml source, tests, tooling
```
