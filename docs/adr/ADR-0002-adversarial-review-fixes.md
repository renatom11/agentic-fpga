# ADR-0002: Pre-G0 adversarial review — accepted findings and protocol amendments

- **Status**: Accepted
- **Deciders**: orchestrator (sponsor ratification folded into G0 item 8)
- **Context**: Before G0 ratification, three independent reviewers attacked
  the charter set from distinct lenses — role coherence (COH), protocol
  enforceability (ENF), sponsor readability (RD) — returning 26 findings
  (1 CRITICAL, 9 MAJOR, 16 MINOR) plus dispositions of the ten open questions
  left by the charter writers. All 26 were accepted; PROTOCOL §11 requires
  this ADR because the fixes amend the protocol, charters, and enforcement
  scripts.

## Key decisions (the load-bearing subset)

1. **COH-1 (CRITICAL)** — the WO- Return-log lifecycle was unexecutable:
   worker charters required writing to `agents/handoffs/**` but their write
   scopes forbade it. **Fixed by extending every worker's scope with
   `agents/handoffs/**`** (PROTOCOL §6, policy.sh, charters, launchers).
   Tampering risk is bounded: packet edits are diff-visible, R4-listed,
   lead-reviewed, auditor-sampled. Rejected alternative: routing worker
   returns through lead-transcribed commits (extra hop, attribution blur).
2. **Mutation discipline is the transient model, sequenced** (COH-2/3/5):
   auditor authors manifests under `docs/reports/audit/mutations/`; the
   orchestrator is the chartered mutation-window operator (apply transiently
   in an uncommitted tree, run DV suite, revert; no RTL-line/worker spawns
   during a window); campaigns run after `RV-` ACCEPT and before `SO-` PASS,
   so every PASS reports kills N/N (N ≥ 3). Mutated RTL never enters history.
3. **Gate signatures are orchestrator-transcribed** (COH-4): signers cannot
   stage `docs/gates/**`; authority lives in the signer's own journal entry
   ("I sign gate X item Y"), the checklist edit is clerical.
4. **Merge commits must be trivial** (ENF-4): CI now rejects any 2-parent
   merge whose tree differs from both parents (and all octopus merges) —
   closing the hole where conflict-resolution content escaped journal-check.
5. **Branch protection extends to the working branch** (ENF-3/RD-2): G0
   item 9 rewritten as a novice-executable click-path covering `main` AND the
   working branch, including "Do not allow bypassing" — without which the
   admin account could force-push away the append-only guarantee.
6. **Honesty corrections** (ENF-1/2, COH-8): §4.1 retitled — only entry
   *structure* is machine-checked, narrative is audit-enforced; R1 noted as
   audit-enforced for orchestrator-attributed commits; data_wrangler's blob
   limit re-labeled `.gitignore`+audit-guarded until a mechanical size gate
   arrives with M1 CI.
7. **Trailer hardening** (ENF-7): CI parses only the final trailer block
   (`git interpret-trailers`), rejects duplicate protected trailers;
   `agent_commit.sh` rejects protected keys via `--extra-trailer`.
8. **data_wrangler pinned to Sonnet** (COH-9): the launcher's `model:` field
   is what actually executes; a per-WO Haiku/Sonnet split had no mechanism.
   (Immutable artifacts — journal seed header, ADR-0001 — retain the old
   Haiku/Sonnet wording as historical record; this ADR supersedes.)
9. **New sponsor-facing artifacts** (RD-1): `docs/SPONSOR.md` (the sponsor's
   duties, E1–E6 in plain language, the canary program) linked from README;
   milestone↔phase map stated in README and ORG_CHART.
10. **Open-question rulings adopted**: golden book model lives at
    `test/golden/` (outside the stimulus generator's scope); attack plans at
    `test/attack_plans/AP-<module>.md` are canonical; orchestrator allocates
    packet numbers and authors the rtl_lead_md scope-partition WO;
    rtl_snapshots regeneration rides rtl_lead's acceptance commit; canary
    *mechanism* documented, instances never; spawn short-id defined
    (WO id + spawn UTC timestamp); same-template worker spawns serialized
    through the journal-append/commit step (COH-11).

## Consequences

- Enforcement self-test grew from 13 to 24 scenarios (foreign-seed-with-
  entries, journal deletion, multi-entry append, trailer mismatch,
  journal-only-with-work, missing files-section, architect deny-order,
  worker handoffs scope, protected extra-trailer, trivial vs content-bearing
  merges).
- Charters now claim nothing the scripts don't check without saying which
  compensating control applies — the honesty property the org's credibility
  rests on.
- Remaining accepted debt: mechanical blob-size gate deferred to M1 CI;
  code-fence-aware journal parsers rejected in favor of a documented
  no-fake-header rule (§4.1) plus audit.
