# WO-0021: The F-1 repair (SPEC-M17) + C-31 §13 row — the last diff before 20/20
- **State**: ISSUED
- **From** / **To**: orchestrator → architect_docs_lead
- **Spec basis**: the WO-0020 Return log at **14e8999** (read §2's F-1
  derivation and owed-diff list in full — it is your entire authority
  for the repair's shape); SPEC-M17 as drafted at aaa55b2 (still
  DRAFT — this is a pre-freeze correction, the cheap kind); ADR-0011
  and SPEC-M04 §9 (C-31); dv's bounded re-review surface and
  pre-worded countersignature sentence (Return log §5).
- **Deliverables**, in order:
  1. **The F-1 repair, dv's three clauses (+1 optional), in SPEC-M17
     DRAFT text**: (a) §6.1 — scope the availability argument to
     ⌈N′/8⌉ = ⌈N/8⌉, correct the inequality's direction (N′ ≤ N gives
     M ≤ ⌈(N−8)/8⌉, not ≥), and state the Tail-class outcome; the
     residue algebra stands, only the quantifier over N′ moves.
     (b) §6.2 `Payload`/`Tail` rows — qualify the copy: `tuser`[0] is
     copied from the input `tlast` word only when the application
     `tlast` is emitted on-or-after its arrival; state what M17 emits
     in the under-declaring regimes (dv's clause 3 direction: the
     inferred/derived value, not a copy — if you judge a REQ-007
     scoping clause is the honest repair instead, say so explicitly:
     that is a normative diff and dv re-reviews on that basis).
     (c) the new §11 row + §10's REQ-007/REQ-013 hook alignment.
     (d, optional) §8's under-declaring datagram gains its assertion.
  2. **C-31**: the §13 diff at SPEC-M04 §9 — "pulse together" becomes
     the ordered-and-unpinned statement ADR-0011's Consequences
     already claims of it and REQ-709's citation expects. Frozen
     batch-B text: full §13 row, non-breaking.
  3. **C-34 and C-35** (SPEC-M18 editorial, dv says they land free
     here): the §6.2 `Body`/`Excess` exit overlap on §8 item 4's
     stimulus; the §3 184-vs-185 REQ-015 bound.
  4. Anything C-32/C-33/C-36 makes cheap to state now is welcome but
     not owed — their gates are later.
  - Journal **J-architect_docs_lead-0009**; Files-in-this-commit =
    exactly what you touch plus this packet. Return log with per-item
    dispositions.
- **Definition of done**: F-1's three clauses landed; no §4.1 lift
  touched anywhere (dv's re-review is byte-wise on the lifts); C-31's
  §13 row landed; C-34/C-35 landed; set equality holds.
- **Out of scope**: everything else — dv's re-review surface is
  bounded and a repair reaching outside it costs a fresh derivation.
  RTL; tests; docs/gates/.
## Task
One activation from 20/20. dv withheld the final countersignature on
F-1 alone, endorsed everything else, and pre-worded the sentence for
the repair SHA. Land it inside the bounded surface.
## Return / verdict log
