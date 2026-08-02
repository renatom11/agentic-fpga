# WO-0031: SPEC-M03 R1/R2 repair — two sentences, bounded
- **State**: ISSUED
- **From** / **To**: orchestrator → architect_docs_lead
- **Spec basis**: WO-0030's WITHHELD verdict (J-dv_lead-0015 at
  0a5ce45): both rulings endorsed on merits, two sentences contested;
  the WO-0021/WO-0022 bounded-repair precedent; dv's pre-worded
  re-countersignature sentence (WO-0030 §5, end).
- **Deliverables**:
  1. **M03-R1**: §6.1's "Two consequences a bench may rely on",
     consequence 1, final clause — "only where it delivered no octet
     do the two fall together" is false by the spec's own m + 3
     formula + REQ-110's lane rule (dv's minimal witness: `/S/` lane
     0 of W−1; word W = four octets in lanes 0–3, `/S/` lane 4, `/T/`
     lane 6 → four octets delivered, both strobes on W+2; the strobes
     coincide in three of four sub-cases). Repair cannot avoid
     stating cycles — dv says so — so state them.
  2. **M03-R2**: §9's "Strobe cycle, pinned" — rule says W+2, its own
     gloss says W+3, whenever the ending character lies in the
     frame's own start word (a family under reading (i), reaching
     committed ASSERT rows M03-B2/B3). One coherent statement.
  3. Nothing else. dv bounded the re-review surface to R1+R2 and
     pre-worded the next signature on that condition — a repair
     confined to the two sentences makes the re-countersign
     clerical. If you conclude the repair genuinely cannot be
     confined, say so in the Return log and stop; do not widen
     silently.
  4. Optional, only if you want them in the same commit: ledger
     C-43 (requirements.md §12 `error_ip_bad_header` third
     disjunct), C-44 (your §6.3 item 4 / §10 REQ-603 justification
     de-overclaim), C-45 (idle-injection prohibition lane-0
     over-breadth), C-46 (REQ-810 verification-column scope). dv
     explicitly does not require them here.
  - Journal next id in your sequence; Files-in-this-commit exact.
- **Out of scope**: everything WO-0029 already landed (endorsed in
  terms — do not re-touch); libs/**, test/**, tools/**; committing.
## Task
Two sentences stand between the M03 rulings and force. dv has
already agreed to everything else in your commit.
## Return / verdict log
