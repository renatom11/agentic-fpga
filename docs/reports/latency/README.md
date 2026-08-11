# `docs/reports/latency/` — the DV line's latency report space

**Owner: `dv_lead`.** This directory is one of four paths in `dv_lead`'s write
scope (`agents/PROTOCOL.md` §6: `test/**`, `tools/**`, `docs/reports/latency/**`,
`agents/handoffs/**`). It is the *only* part of `docs/**` the DV line may stage,
and the one part of `docs/**` `architect_docs_lead` is excluded from **by name**
in the same table — the split exists so that the agent who *measures* latency and
the agent who *narrates* it are not the same agent (`agents/charters/dv_lead.md`
§3, §4).

---

## 1. What is in here today

**Nothing but this file. No latency report has been written.** Measured at this
commit, not recalled:

```
$ git ls-files docs/reports/latency
docs/reports/latency/README.md
```

Before the commit that adds this file, that command printed **nothing at all** —
which is the fact §5 below exists to explain.

## 2. What belongs in here

Latency **artefacts**: the measured numbers and the data files behind them, never
the narrative. The narrative is `architect_docs_lead`'s, written from what is
committed here (charter §4).

| | quantity | defined by | reported as |
|---|---|---|---|
| Phase 1 | receive latency budget — XGMII start-character word → first application payload word | `docs/specs/requirements.md` REQ-006 (≤ 24 cycles / 153.6 ns), measured at `nic_top` across §0.4's receive chain | REQ-806: cycles **and** nanoseconds, **separately per start lane** (lane 0 and lane 4 may legitimately differ by one cycle, §0.5), for the `nic_top` freeze record and the Phase-1 report |
| Phase 2 | first-XGMII-word-in → book-update-out | charter §3 | per-message-type histograms over real replayed NASDAQ data, cycles × 6.4 ns at 156.25 MHz |

Two rules bind anything committed here, and they are conditions of the artefact,
not of the round that writes it:

1. **The exact reproducing command ships with the report** (charter §3), and the
   histogram must regenerate **byte-identical** from one committed command under
   `tools/`, runnable by the auditor at the report's own SHA (charter §6,
   criterion 6). A number here that cannot be regenerated is not evidence.
2. **`dv_lead` produces and commits the numbers; the architect transcribes them**
   into the `nic_top` freeze record (REQ-806's verification column). Neither side
   may write the other's copy.

## 3. Where latency figures live today, since they are not here

This directory being empty of reports does **not** mean the programme has
measured no time. It means the *end-to-end* quantity has not been measured. What
exists today is per-octet and per-module, and it lives elsewhere on purpose:

- **REQ-005's per-octet constancy** is asserted inside the REQ-004 line-rate
  stress, at rows `M03-L2` (REQ-005, REQ-111, §8 check 3, §0.5), `M03-L3`
  (REQ-019, §1.1, §7) and `M03-L5` of `test/attack_plans/AP-xgmii_rx_64.md`
  §4.L, discharged by units under `test/xgmii_rx_64/`.
- **REQ-019's word-delay ceilings** (`docs/specs/requirements.md` §1.1) were
  checked at `P1-spec-freeze` as arithmetic on the *specifications* — pinned
  latency constant `L` and stated front offset `h`, converted per §0.5. REQ-019's
  *second* check, the same ΔC measured from a REQ-004 stress run, belongs in each
  module's `SO-` packet and not here.
- **REQ-006 is a different quantity from all of those**: a sum of word delays
  across the whole chain, measured at `nic_top`. `docs/specs/modules/nic_top.md`
  is frozen; no module has reached `P1-module-ready`; **no bench has produced
  that number.** The first artefact in this directory is expected to be the one
  that does.

## 4. What the four instruments citing this directory require of its first artefact

Four committed packets point a reader here. Each is a live obligation on whoever
writes the first report, so they are listed rather than left to be rediscovered:

| citing packet | what it obliges |
|---|---|
| `agents/handoffs/WO-0003_testability-findings.md` (REQ-806) | the split of duties in §2 rule 2 — the numbers are committed here, the freeze-record copy is transcribed by the architect |
| `agents/handoffs/WO-0015_batch-d-countersign.md` (carry-forward **C-23**, REQ-502 half) | REQ-502's *measurement start* is ambiguous between two readings of "the request's last XGMII word", and the ambiguity must be resolved **before any artefact in this directory quotes that figure** |
| `agents/handoffs/WO-0018_batch-de-countersign.md` (carry-forward **C-24**) | C-23's sequel: with the start fixed, REQ-502's derived value is **not single-valued** across accepted request lengths, and that too must be settled **before any artefact here quotes the figure** |
| `agents/handoffs/SO-xgmii_rx_64.md` (§7.1 write scope, §7.2 gate ladder) | `P1-phase-accept` requires the latency report **committed under this path**, beside a clean replay and an audit report with no open CRITICAL findings |

**This file deliberately quotes no latency figure.** C-23 and C-24 both gate on
the first artefact here that quotes REQ-502's number; a README that quoted one
would discharge neither carry-forward and would trip both.

## 5. Why this file exists

Because the four citations in §4 were **broken for every reader who was not
sitting in one particular container**, and nobody could see it from inside that
container.

`docs/reports/latency/` existed there as an **empty, untracked directory**
(created 2026-08-01). Git cannot track an empty directory, so `git ls-files
docs/reports/latency` returned nothing and **every fresh clone of this repository
lacked the path entirely**. The DV resolve-check in `tools/dv_checks.sh` found
this on its first CI run — `build` run **31442295998**, step "DV mechanical
checks", 4 UNDECLARED broken citations — while the same command run locally
reported 0, because it was asking the filesystem rather than the tree.

**Both halves of that were mine, and both are repaired here:**

- The catch was a **true positive**, and the disposition is this file rather than
  four declared errata. An erratum would have recorded the four citations as
  permanently broken and then gone **stale** the moment the first real report
  landed — and one of the four citers is the module sign-off packet itself, which
  may not ship carrying a declared-broken citation of its own. A **tracked file
  that makes the citation resolve truthfully** closes the class at its root: the
  four packets point at a directory, and the directory now answers.
- The instrument resolved against the **filesystem** where the honest test is the
  **tracked tree**. It now resolves through `git ls-files`, so a local run
  measures exactly what a fresh clone measures and the empty-directory case is
  not expressible in either environment. The reasoning is written out at the
  resolve-check block in `tools/dv_checks.sh`.

The general form, which is why this section is here and not only in a journal:
**a check that resolves against the environment it runs in rather than the
artefact it governs can be green for a reason that ships with nothing.** Its
symptom is never a wrong answer — it is a divergence between two environments,
and it stays invisible until the day the two of them differ.
