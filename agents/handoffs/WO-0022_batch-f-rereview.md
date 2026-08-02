# WO-0022: Batch-F bounded re-review — the last signature
- **State**: ISSUED
- **From** / **To**: orchestrator → dv_lead
- **Spec basis**: the WO-0021 return at **d8df28d** (F-1 repaired;
  C-31/C-34/C-35 landed; no §4.1 lift touched anywhere); your own
  WO-0020 Return log §5's bounded surface and pre-worded sentence.
- **Deliverables**:
  1. **The re-review, on exactly the surface you bounded**: SPEC-M17
     §6.1's corrected availability argument (now a separation formula
     keyed on D = ⌈N/8⌉ − ⌈N′/8⌉, the word-count deficit — including
     the architect's added octet-vs-word distinction: N=25/N′=24 is
     D=1, N=32/N′=25 is D=0); §6.2's Payload/Tail rows (conditional
     copy, driven-0 on D ≥ 1, Tail ≡ D ≥ 1 pinned); the new §11.4
     (the REQ-007 scoping clause written out, priced, and carried at
     the SO-udp_ip_rx_64.md gate — judge the carry logic: the clause's
     cost is flip-invariant because requirements.md is already FROZEN,
     where F-1's was not); §10's split hook with the D=0 boundary
     companion; §8's paired opposite-assertion datagrams; byte-wise,
     the two SPEC-M18 corrections (C-34 at three sites, C-35's
     184→185) and SPEC-M04's §13 row (C-31, citing ADR-0011).
  2. **The two disclosed out-of-surface sites**: SPEC-M17 §3's REQ-007
     row and §4.2's payload_tuser row gained pointers only, text
     quoted verbatim in the Return log — your C-28 precedent governs
     (say so and re-derive what moved, or accept the quoted text).
  3. If the repairs hold: your pre-worded sentence at d8df28d for
     transcription — "I countersign batch F (SPEC-M17, SPEC-M18,
     SPEC-M19, SPEC-M20) for P1-spec-freeze at `d8df28d`."
     (J-dv_lead-0011). On it, ALL TWENTY specifications are FROZEN.
     If not: the exact residual list.
  - Journal **J-dv_lead-0011**; Files-in-this-commit = exactly what
    you touch plus this packet.
- **Definition of done**: re-review verdict on the bounded surface +
  the out-of-surface judgment; sentence or residuals.
- **Out of scope**: everything signed at WO-0020 (per your own §5:
  L/h/ΔC, precedence scoping, strobe cycles, stress arithmetic, and
  all of M18/M19/M20 beyond the two byte-wise corrections).
- **Evidence**: CI `build` run on d8df28d — id and conclusion appended
  below before spawn; head SHA = the repair commit, so batch F's four
  §12 rows fill from it with no witnessing argument owed.
## Task
The re-review you pre-priced. On your sentence the gate's sign-off
section reduces to one line: the sponsor's signature.
## Return / verdict log
