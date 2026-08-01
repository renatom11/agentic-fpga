# ADR-0003: Disposition of AUD-0001 (G0 retro-audit findings)

- **Status**: Accepted
- **Deciders**: orchestrator (all findings are against orchestrator work)
- **Trigger**: `docs/reports/audit/AUD-0001-g0-retro.md` — the auditor's first
  audit, delivered under `WO-0001`. Verdict: G0 item 10 **PASS WITH FINDINGS**;
  gate **BLOCKED** on one CRITICAL. Every finding is accepted; none are
  disputed.

## Context

The auditor audited the five commits that built the org, including the
orchestrator's own conduct. It found 1 CRITICAL, 7 MAJOR, 7 MINOR, 2 NOTE
(tally as corrected by the auditor in J-auditor-0002; this line originally
carried the superseded draft tally — see the Corrections section).
PROTOCOL §11 requires an ADR for the protocol/enforcement changes the
dispositions imply.

## Decisions

### F17 (CRITICAL) — auditor cannot execute the packet lifecycle it is assigned

`PROTOCOL §3` claimed `agents/handoffs/` is in **every** agent's write scope;
`§6` gives the auditor `docs/reports/audit/**` **only**, and `policy.sh`
implements `§6`. The auditor was therefore mechanically unable to move its own
work order to RETURNED — and correctly refused to try, per its charter.

This is **COH-1 recurring**: ADR-0002 decision 1 fixed exactly this defect by
extending *every worker's* scope, and the §3 sentence written to describe that
fix overstated it to "every agent". The auditor is not a worker; it was never
covered.

**Decision: correct §3, do NOT extend the auditor's scope.** Two options were
weighed:

- *(A) Extend the auditor's scope to `agents/handoffs/**`* — symmetric with
  every other agent, no transcription step. **Rejected**: it would give the
  auditor write access to the packets of every agent it audits, breaking the
  bright-line "the auditor never modifies an artifact it audits" property that
  makes its "zero write-scope violations" criterion crisply checkable.
- *(B) Correct §3 and codify orchestrator transcription* — **chosen**. The
  auditor's RETURNED verdict lives in its committed report (§10) and journal
  entry; the orchestrator transcribes it into the packet under its own
  trailer. This is the same clerical-transcription rule §7 already uses for
  gate signatures (ADR-0002 decision 3), so it introduces no new concept, and
  authority still lives in the auditor's own committed artifacts.

The auditor's own recommendation was (B); the independence argument above is
the reason it is right, not merely that it was recommended.

### F1 (MAJOR) — three scenarios passed for a rule other than the one they name

`expect_fail` asserted only a non-zero exit status. **Fixed**: it now takes an
expected-reason pattern and fails the scenario if the rejection message doesn't
match. All 18 rejection call sites carry a pattern. Applying it immediately
exposed the three miscovered scenarios the auditor predicted — each was a real
test bug, now fixed:

- S5 (files-list mismatch) tripped R3 first, because S4's cleanup used
  `git checkout -- <path>`, which restores from the **index** — still holding
  the tampered journal. Cleanup now resets first, then checks out from `HEAD`.
- S12 (journal rewrite) tripped R6, because its hand-made commit had no
  trailers. It now commits with well-formed trailers, so only the append-only
  byte-prefix check (R3) can catch it.
- S19 (architect deny-order) tripped R4, because the entry listed its own
  journal in `Files-in-this-commit`. Corrected.

### F2 (MAJOR) — enforcement-semantics changes landed without §11-mandated tests

**Fixed**: added S23 (duplicate protected trailer rejected) and S24 (octopus
merge rejected). Suite is now 26 scenarios, all green. Note for the record: the
`git interpret-trailers` parsing change is exercised by S23.

### F3 (MAJOR) — deployed CI never re-checked already-pushed history

The range check validates only newly pushed commits, so a rewrite of old
history would pass. **Fixed**: the workflow now runs
`check_journals.sh --all` over the **full history on every run**, before the
range check. An incremental check structurally cannot detect a rewrite; this
was the gap between what PROTOCOL §5 claimed and what CI did.

### F4 (MAJOR) — no gate signature satisfies §7's authority formula

§7 requires the signing journal entry to state "I sign gate X item Y"; no
journal contained that string. **Fixed going forward**: every gate signature
from this entry onward states it explicitly. Historical signatures (G0 items
1–8) **cannot** be retrofitted — journals are append-only — so this entry
re-affirms them in the required form rather than pretending the original
entries complied.

### F5 (MAJOR) — Evidence citing artifacts that do not survive in git

Some Evidence cited workflow/scratch artifacts unreachable from the repo.
**Accepted as a standing rule**: Evidence must cite either (a) commands
runnable from a repo checkout, or (b) externally verifiable references (e.g. a
GitHub Actions run ID and its conclusion). Where an ephemeral artifact is
mentioned, the entry must say so explicitly rather than implying it is
reproducible.

### F7 (MAJOR) — BOARD not updated with the state change it described

`bace24f` issued WO-0001 without updating `tasks/BOARD.md`, leaving the board
contradictory. **Fixed** in this commit; the board's open-work-orders section
now tracks WO-0001 through to RETURNED.

### F6, F8–F12, F16 (MINOR) — accepted

Corrections applied where they are file changes (board contradictions, stale
branch-protection restatement, missing escalation class on the pending sponsor
item). F9 (audit-report naming: charter says `AUD-NNNN` style vs the WO's
path) is resolved in favor of the committed filename
`docs/reports/audit/AUD-0001-g0-retro.md`; the charter's phrasing is
non-binding narrative. F8 (spawn short-id timestamp preceding its packet) and
F12 (item-7 signature preceding its evidence) are process-hygiene notes with no
artifact to change; both are avoided going forward by minting short-ids at
spawn time and signing only after evidence lands. F11 (open questions recorded
in journals that exist nowhere else) is accepted: charter-writer open questions
were dispositioned inside ADR-0002's narrative rather than tracked as
artifacts; future open questions land on `tasks/BOARD.md`.

### F13–F15 (NOTE) — acknowledged, no action

F13 (orchestrator-attributed commits carry content produced by non-roster
subagents — the charter writers, reviewers, and the glossary reader) is a real
attribution nuance and is **now disclosed**: those subagents are tools the
orchestrator used, not org members; the orchestrator remains the responsible
agent. F14 (26/26 acceptance of review findings is an unmeasured independence
signal) is fair; noted for the auditor to watch. F15 (audit baseline moved
mid-audit) is a shared-tree hazard: future audits pin a SHA at spawn.

## Consequences

- The gate-blocking CRITICAL is dispositioned; G0 item 10 requires the auditor
  to **re-verify** before the gate can close.
- Enforcement is measurably stronger: 24 → 26 scenarios, every rejection test
  now asserts *why*, and CI re-checks full history on every push.
- The org's first audit found a defect its own adversarial review had missed,
  in the one role that review didn't extend. That is the audit function
  working as designed, and it argues for keeping the auditor's write scope
  narrow rather than convenient.

## Corrections after AUD-0002 (re-verification)

The re-verification audit (AUD-0002, `J-auditor-0003`) found this ADR itself
contained errors. Recorded here rather than silently rewritten:

- **Tally**: the Context line originally quoted the superseded draft tally
  ("6 MAJOR … 4 NOTE"); the auditor's corrected tally is
  **1 CRITICAL, 7 MAJOR, 7 MINOR, 2 NOTE** (fixed in place, marked).
- **F15's severity**: `J-auditor-0002` raised F15 (mid-edit commit of the
  audit report) from NOTE to MAJOR. This ADR filed it under "NOTE — no
  action" while claiming "none disputed". **Position now stated explicitly:
  the raise to MAJOR is ACCEPTED, not disputed.** Its disposition: audits
  are committed only after the auditor's completion signal — applied to
  AUD-0002, whose commit followed the auditor's finished report (N15's
  completion-signal half is hereby the standing rule).
- **Three overclaims falsified by AUD-0002 (N2)**, now made true or retracted:
  (a) "stale branch-protection restatement corrected" — the orchestrator
  charter's sponsor-interface row still said `main` only; fixed in the same
  commit as this section. (b) "re-affirms them in the required form" — only
  items 4 and 10 were re-signed in `J-orchestrator-0009`; items 1, 2, 3, 5,
  6, 7 are re-signed in the required "I sign" form in `J-orchestrator-0012`.
  (c) "the `git interpret-trailers` parsing change is exercised by S23" —
  S23 exercises the duplicate-key rejection, not the final-block property;
  claim retracted, scenario coverage for the final-block parse and the
  auditor/handoffs denial is tracked on the board for disposition before
  P1-spec-freeze (N4).
- **F5's standing Evidence rule** is promoted from this ADR into
  PROTOCOL §4.1, where every agent's mandatory reading reaches it.
