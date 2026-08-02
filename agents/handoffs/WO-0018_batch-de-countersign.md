# WO-0018: Batch-D re-review + batch-E testability countersignature
- **State**: ISSUED
- **From** / **To**: orchestrator → dv_lead
- **Spec basis**: the WO-0017 return at **3f6accc** (D-1 repaired as
  R-1, D-2 as D-2a with ADR-0009; batch E SPEC-M14–M16 drafted; your
  five C-19…C-23 items landed); your own WO-0015 Return log §8's
  stated re-review surface; the P1-spec-freeze checklist as updated at
  the acceptance commit.
- **Deliverables**, in order:
  1. **Batch-D re-review, on the surface you bounded**: re-check D-1
     and D-2 at their landing sites (SPEC-M13 §6.1/§6.2 machine (A)
     now three states with `Transmitting`; §7/§8/§9/§10; §11.6's R-2
     appeal record; SPEC-M11 §6.1's one-paragraph clarification;
     SPEC-M10 §11.3/§2 moves; ADR-0009; requirements.md REQ-503/510
     rows), re-run byte-identity and set-equality, confirm a green
     `ifc_check` run at the new SHA (appended below before spawn). Per
     your own §8: the recomputed arithmetic and Q1/Q3/Q4/Q5 do NOT
     reopen. **Answer the architect's five questions** (Return log
     "Open questions" section): (i) REQ-502 now derives at **7** — the
     one signed number that moves; accept, or direct the gate to delay
     only the learning write (back to 6, at the cost of replying to an
     invalid frame); (ii) D-1's boundary cycle (a reply generated on
     the exact tlast-acceptance cycle is dropped — pinned, reversible
     in one word); (iii) M14's error_ip_truncated-alone precedence
     rule; (iv) REQ-610/REQ-807 rows naming unwritten M18/M20 with
     pending halves; (v) the added M20→M14 cfg_subnet_mask edge (the
     untaken alternative was E2-shaped). If the repairs hold: the
     countersignature sentence you pre-worded, with the SHA filled.
  2. **Batch-E countersignature** (SPEC-M14, M15, M16), per charter:
     recompute rather than trust — M14's L=12/h=20/ΔC=4 against its
     own ceiling of 5 (the reserve is M14's allocation), the REQ-611
     3-cycle parse with one-cycle header lead, the six-of-seven
     strobes at input word 2; M15's 1-cycle + 2-cycle resolution wait,
     stall count W−J+1 = 3 or 4, the 0xF6B4 worked checksum and 0xFFFF
     loopback residue; M16's total wiring table, the 3+1+4=8 receive
     chain against 9 allocated, REQ-807's loop obligation, the twelve
     relayed strobes and the receive-path fork's two conservation
     facts. The REQ-506 two-half pattern is copied at REQ-505/610/807
     — verify the mutual disclaimers actually tile.
  3. New carry-forwards C-24+ with must-land-before gates; reaffirm or
     contest C-19…C-23 as landed.
  4. Countersignature sentence(s) for transcription: batch D at its
     repair SHA (per your pre-wording) and batch E at its draft SHA —
     or the exact owed-diff list per contested spec.
  - Journal **J-dv_lead-0009**; Files-in-this-commit = exactly what
    you touch plus this packet (expect: packet + journal; declare any
    test/** or tools/** machinery you add).
- **Definition of done**: batch-D re-review verdict + five answers;
  three batch-E verdicts; ledger reaffirmation; sentences or owed
  diffs.
- **Out of scope**: batch F; RTL; editing specs (architect's) or
  docs/gates/ (orchestrator's).
- **Evidence**: CI `build` run on 3f6accc — id and conclusion appended
  below before spawn.
## Task
Fifth countersign cycle: close the loop you opened at WO-0015, and
judge the first IPv4 batch. If both land, 16 of 20 specs are frozen
and only batch F stands between the programme and the gate's sponsor
signature.
## Return / verdict log
