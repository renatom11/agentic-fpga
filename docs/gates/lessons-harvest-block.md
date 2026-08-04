# Gate block: lessons harvest (ADR-0018)

**Reusable — this file is a template, not a gate.** Every phase-gate checklist in
`docs/gates/` and every `SO-<module>.md` sign-off section instantiates §3's block
verbatim, filling the bracketed fields. **A gate is not passed, and a module
sign-off is not complete, while any box in the instantiated block is unchecked**
(PROTOCOL §7).

Nothing here is signed. This file never records a harvest; instantiations do.

---

## 1. How to instantiate

1. Copy §3's fenced block into the gate checklist (or the `SO-` packet's sign-off
   section) under the heading `## Lessons harvest — <gate or SO- tag>`.
2. Replace `<harvest-tag>` with the gate name (`P1-module-ready`) or
   `SO-<module>`. It becomes the prefix of every candidate id minted this round:
   `LC-<harvest-tag>-<n>`.
3. One row of the span table per agent holding a persistent journal chain —
   today: `architect_docs_lead`, `rtl_lead`, `dv_lead`, `auditor`, `orchestrator`.
   Add a row for any persistent journal that exists at the time of the harvest
   (e.g. `rtl_lead_md` once activated).
4. The orchestrator fills the table from each agent's harvest note and checks the
   boxes. **Every cell's authority is the cited `J-<agent>-NNNN` entry** — the
   checklist edit is clerical, commits under `Agent: orchestrator`, and is the
   same transcription rule PROTOCOL §7 already uses for signatures.
5. Delete no rows. An agent with nothing to report gets a row reading `nil` with
   its span interval — a nil yield is declared, never omitted (ADR-0018 D4).

## 2. The bar, for the reviewer's convenience

Normative text is ADR-0018 §3.4; this is the short form.

| | Criterion | Passes when |
|---|---|---|
| **LH1** | provenance-pinned | Cites the incident commit SHA(s) **and** the entry/packet that adjudicated it; a reader at that SHA can see the thing going wrong |
| **LH2** | portable observable | The **rule statement** carries no proper noun of this program — no module, requirement, carry-forward, signal, protocol, toolchain or library name — and reads as a complete instruction on a different project with different agents. Second test: hide the provenance; if the statement then says nothing, it was the nouns talking |
| **LH3** | stated failure | Says what **breaks** without it — a concrete outcome a reviewer could recognise in someone else's repo, not a virtue |

Failing any one → **war story**: recorded with the criterion it failed, not
transcribed to the shell, re-offerable at a later harvest with new provenance.

---

## 3. The block

```markdown
## Lessons harvest — <harvest-tag>

Per ADR-0018 / PROTOCOL §7. Spans are entry-id intervals over each agent's own
journal chain and must tile with that agent's previous harvest. Transcribed by
the orchestrator; each row's authority is the cited journal entry.

### Spans mined

| Agent | Span (entry-id interval) | Harvest note | Candidates | War stories |
|---|---|---|---|---|
| architect_docs_lead | J-architect_docs_lead-NNNN … -MMMM | J-architect_docs_lead-MMMM | n | n |
| rtl_lead | … | … | n | n |
| dv_lead | … | … | n | n |
| auditor | … | … | n | n |
| orchestrator | … | … | n | n |
| _(worker spans, by commissioning lead)_ | spawn short-ids covered | (in that lead's note) | n | n |

### Yield

| id | Rule statement (one line, LH2-clean) | Mined by | Note entry | LH1 provenance | Disposition |
|---|---|---|---|---|---|
| LC-<harvest-tag>-1 | | | J-…-NNNN | `<sha>` | transcribed as `L-…` / war story / sponsor-refused |

### War stories (kept, not transcribed)

| Candidate | Mined by | Failed | Why |
|---|---|---|---|
| | | LH1 / LH2 / LH3 | |

### Checklist

- [ ] **Every persistent-journal agent has a row above**, and every span tiles
      with that agent's previous harvest — no gap, no overlap. (First harvest:
      the span opens at the agent's first entry.)
- [ ] **Each row's harvest note exists** in the named journal entry and carries
      its span interval, its candidates with LH1–LH3 discharged, its war stories
      with the criterion each failed — or an explicit nil yield.
- [ ] **Every candidate in the Yield table discharges LH1, LH2 and LH3**, checked
      by the transcriber against the note, not against the summary line.
- [ ] **No candidate was edited in transcription.** A defective statement is
      bounced to its author, never rewritten by the collator.
- [ ] **Shell transcription: exactly one commit**, containing the admissible
      candidates with permalinked provenance, and nothing else. Commit: `<link>`
- [ ] **`LC-` → `L-` pairs recorded** in the Yield table's Disposition column, so
      the shell entry is traceable back to the note that minted it.
- [ ] **Sponsor-visible**: the harvest table and the shell diff were surfaced at
      this gate. Refusals, if any, are recorded as `sponsor-refused` above.
- [ ] **Harvest declared complete** by the orchestrator: `J-orchestrator-NNNN`.
```

---

## 4. Notes for the transcriber

- **"Harvest" alone means something else in this repo** — a mutation-campaign or
  promotion-block harvest. Always write **lessons harvest** in the new sense
  (ADR-0018 §7.5).
- **You are not the selector.** Collation is clerical: you may bounce a candidate
  to its author for a defective statement, and you may not improve one. A collator
  who edits statements shapes the shell without any note showing it.
- **Run LH2's second test yourself** at transcription — you are the reader who has
  the shell's audience in mind, and it is the last point before the rule leaves
  this repo.
- **A harvest whose war-stories table is empty at every round** says something
  about the bar, not about the span. Worth a line in the note when it happens.
- **Closed gates are not retro-harvested.** `G0-checklist.md` (PASSED 2026-08-01)
  and `P1-spec-freeze-checklist.md` (CLOSED 2026-08-02) predate this practice and
  are not reopened; their spans are covered by the interval rule, since each
  agent's first harvest opens at its first entry (ADR-0018 §9).
