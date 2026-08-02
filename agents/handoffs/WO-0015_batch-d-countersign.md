# WO-0015: Batch D testability countersignature (SPEC-M10–M13)
- **State**: ISSUED
- **From** / **To**: orchestrator → dv_lead
- **Spec basis**: SPEC-M10 (`arp_eth_rx`), SPEC-M11 (`arp_eth_tx`),
  SPEC-M12 (`arp_cache`), SPEC-M13 (`arp`) as drafted at **a9993ff**
  (WO-0014, `J-architect_docs_lead-0006`); requirements.md ARP block
  REQ-501–512; ADR-0008; architecture.md §6.4 (now 117 edges — one
  amendment, `M11.arp_ready → M13.arp_tx_ready`); the WO-0014 Return
  log (the architect's per-item C-17 judgements and the four open
  questions below); the P1-spec-freeze checklist's C-item closures at
  the acceptance commit.
- **Deliverables**, in order:
  1. Countersignature verdict for each of the four specs, per your
     charter: derivability of a bench from §6/§8 alone, observability of
     every §3 claim, no assertion commissioned that a conformant design
     fails. Recompute, don't trust: the architect's arithmetic
     (M10 L=32/h=0/ΔC=4 with no §1.1 ceiling; M11 L=8/ΔC=1; M12
     1-cycle lookup, write visible T+1; M13 response at Q+2, REQ-502
     derived at 6 cycles) and the C-17 fixes you supplied
     (a: M+2 ≤ K+1; b: stall count W−J+1 in five places; c: withdrawal;
     d: ADR-0008 Consequences bullet; e: N=22) are yours to re-derive.
  2. **Answers to the architect's four questions, by name** (each lives
     in a §11 item with a "meanwhile" reading, so answering is closing):
     - **Q1, SPEC-M11 §11.3** — the ADR-0008 substitution: M11's `arp`
       input has no payload stream, so §7 substitutes `arp_valid` &
       `arp_ready` for the ADR's acceptance event. Instantiation or
       supersession? Your monitor is the artifact at stake.
     - **Q2, SPEC-M10 §11.3** — a bad-FCS frame is learned from
       (`payload_tuser`[0] lands ≥2 cycles after M10's pinned report).
       Accept the meanwhile reading, or raise a requirements diff?
     - **Q3, SPEC-M13 §11.2** — REQ-810's ARP clause vs the
       drop-second-hold-first mechanism. **Potentially breaking**: the
       alternative needs a `cfg_tx_enable` port at M13 that §6.4.3 does
       not route. If you judge the requirement means drop-all, say so
       now — after freeze it costs a breaking port addition.
     - **Q4, SPEC-M13 §11.3** — a miss for a *different* target
       replaces the outstanding resolution (REQ-505 constrains only
       same-target). Specification decision or missing requirement?
  3. New carry-forward items if found (C-19+), each with a
     must-land-before gate; reaffirm or contest the closure of C-6,
     C-15, C-16, C-17, C-18 as transcribed on the checklist.
  4. If all four verdicts are positive: the countersignature sentence
     for batch D at a9993ff, for orchestrator transcription onto the
     gate checklist (PROTOCOL §7). If any verdict is negative: the exact
     diff set the architect owes, as with WO-0007/0010/0013.
  - Journal `J-dv_lead-0008`; Files-in-this-commit = exactly what you
    touch plus this packet (expect: this packet + your journal; any
    `test/**`/`tools/**` machinery you add is yours to declare).
- **Definition of done**: four verdicts + four answers + ledger
  reaffirmation; countersignature sentence or owed-diff list.
- **Out of scope**: batches E–F; RTL; editing any spec (diffs are the
  architect's to make); `docs/gates/` (orchestrator transcribes).
- **Evidence**: CI `build` run **30736107842**, conclusion **`success`**,
  SHA 2f29888 (whose tree carries a9993ff's specs unchanged —
  `git diff a9993ff 2f29888 -- docs/specs/` is empty). All 13 lifts
  elaborate, the four batch-D lifts for the first time; dv_checks step
  green. This is the run SPEC-M10…M13's §12 rows cite when the
  architect fills them at the freeze flip.
## Task
Fourth countersign cycle. Batch D is the first protocol-logic batch —
your verdict decides whether the ARP family freezes at a9993ff or the
architect owes a diff set first.
## Return / verdict log
