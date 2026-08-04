# Journal: claude_auditor_agent

- **Agent**: auditor (Opus 5, independent)
- **Charter**: agents/charters/auditor.md
- **Format**: v1 — entry grammar in agents/PROTOCOL.md §4

This file is APPEND-ONLY. Content may only ever be added after the last line;
nothing above it is ever edited. Enforced by scripts/agent_commit.sh and CI.

---

## [J-auditor-0001] 2026-08-01T19:57:17Z | task:WO-0001 | G0 retro-audit of the M0 commit range: 1 CRITICAL, 5 MAJOR, 7 MINOR, 4 NOTE
### Trigger
Spawned by the orchestrator on WO-0001 (agents/handoffs/WO-0001_g0-retro-audit.md,
ISSUED, committed at bace24f). Spawn short-id: WO-0001/2026-08-01T19:05Z — a
short-id whose timestamp I found to be inconsistent with the packet it names
(AUD-0001-F8). This is my first spawn and the auditor journal's first entry.
The audit is G0 checklist item 10, the last org-side item of gate G0.
### Inputs
agents/charters/auditor.md; agents/PROTOCOL.md; agents/handoffs/WO-0001_g0-retro-audit.md;
agents/handoffs/README.md; agents/charters/orchestrator.md;
agents/journals/claude_orchestrator_agent.md (all seven entries, in full);
agents/journals/INDEX.md; agents/journals/claude_auditor_agent.md (header only,
pre-append); tasks/BOARD.md; docs/gates/G0-checklist.md; docs/SPONSOR.md;
docs/adr/ADR-0002-adversarial-review-fixes.md; docs/adr/ADR-0001-org-design.md
(skimmed, treated as immutable record); scripts/policy.sh, agent_commit.sh,
check_journals.sh, test_protocol.sh (all four in full);
.github/workflows/journal-check.yml; .claude/agents/auditor.md,
.claude/agents/data_wrangler.md. Commit objects 7f54130, b135a7f, f43f71f,
d499ce8, ef543b0, bace24f, 75d47ed. GitHub Actions run metadata for
journal-check runs 1-6 and full job logs for jobs 91388576990 (run 1) and
91399393632 (run 3). Two out-of-repo ephemeral artifacts in the session
scratchpad, used only as corroboration and flagged as non-durable in
AUD-0001-F5: review_findings.json (sha256 9a16433ead72a8ecd93271063b1e2e43fc05903a05d9b5f12350c7bb91526531)
and judge.json (sha256 9f82aadf8404f0910b9ccc62bdf8cdcfb2f0ee4364f5c90d07ad97122f1b4e5c).
### Reasoning
SAMPLING FRAME (charter §8 requires this be reconstructible). The window is
tiny — 6 in-window commits, all one agent — so I took a census rather than a
sample of commits (7/7 including the out-of-window 75d47ed), journal entries
(7/7) and enforcement scenarios (24/24, instrumented). Of six Evidence claims I
re-executed or externally verified four (67%, against a charter floor of 10%);
the two I did not are the two that honestly state "Evidence: none". Of six CI
runs I pulled metadata for all six and full job logs for two, choosing runs 1
and 3 because they are the only two distinct code paths in the workflow
(zero-before --all vs BEFORE..AFTER --range) — pulling the other four would have
added cost and no information. DELIBERATELY SKIPPED: the five not-yet-activated
charters, read only for scope-parameter restatement consistency and honesty
notes, because they have produced no conduct to audit and will be audited
against their first real output; ADR-0001's superseded wording, because
PROTOCOL §11 makes ADRs immutable records and treating stale text in them as
drift would be a false finding.

METHOD CHOICE. CI already runs check_journals.sh, so re-running it proves only
that the script is deterministic. To add information beyond CI I recomputed R4
set-equality by hand for every commit (changed paths minus own journal, diffed
against the Files-in-this-commit list extracted from the added journal lines),
counted entries in all eight foreign seeds at 7f54130, and read every journal
hunk for append-only by eye rather than trusting the byte-prefix check alone.
That is what caught nothing — a clean result I record in §9 of the report
precisely so a later audit knows it was covered and need not redo it.

RE-EXECUTION STRATEGY. The WO asked for at least two Evidence re-executions at
the recorded SHA. Checking out historical SHAs in the live tree risked leaving
the working tree perturbed, and (as it turned out) the orchestrator was
committing concurrently, which would have made a stash/checkout genuinely
dangerous. I rejected git stash, git checkout and git worktree in favour of
`git archive <sha> | tar -x` into scratch snapshots, which reads history and
writes nothing to the repo; the snapshot needed a `git init` because
test_protocol.sh resolves its own root via git, and initialising a *scratch copy*
is harmless. I did RX-1 and RX-2 that way at 7f54130 and d499ce8, and did RX-3
at HEAD deliberately (noted as such in the report) because the claim is a
standing property of the whole history that must hold a fortiori at HEAD.

THE INSTRUMENTATION DECISION, which produced the most substantive MAJOR. Simply
re-running test_protocol.sh reproduces "24 passed" and proves little: the suite's
expect_fail asserts only a non-zero exit status. I considered that sufficient
reason to distrust the count and copied the script to scratch with expect_fail
altered to print the captured rejection message. Three scenarios then turned out
to be satisfied by the wrong rule (S5, S19, S12). I chased the S5 case to its
root — a checkout-before-reset ordering in S4's cleanup leaking a tampered
journal forward — with a probe rather than asserting a guess. I rejected the
softer framing "the evidence is fine because the count reproduces": the count is
not the claim the org relies on, coverage is.

SEVERITY CALIBRATION. I set no finding to CRITICAL on the enforcement-evidence
issues, because the literal Evidence claims reproduce exactly and my charter
reserves CRITICAL for unreproducible evidence, licensing taint, relay tampering
and append-only violations — none present. I resisted inflating F1/F3 to
CRITICAL for impact.

The one CRITICAL was forced on me by the work order itself. WO-0001 and my spawn
prompt both instruct me to append a RETURNED entry to the packet's Return log and
to list that path in Files-in-this-commit. PROTOCOL §6 and policy.sh give the
auditor docs/reports/audit/** only, so staging it fails R7 and listing-without-
staging fails R4 — the instruction is unexecutable in both branches. PROTOCOL §3
asserts the opposite ("agents/handoffs/ is inside every agent's write scope"),
so the constitution contradicts itself. I weighed MAJOR seriously: nothing is
lost and the orchestrator can transcribe. I chose CRITICAL on three grounds —
the org's own adversarial review rated this identical defect CRITICAL as COH-1
and fixed it for workers only; the defect sits in the document this very gate
exists to ratify; and it recurs every audit cycle while pushing a participant's
lifecycle action onto the party it audits, which is backwards for an
independence mechanism. Rating it MAJOR because the instance happens to
constrain me would be exactly the softening charter §7 forbids. I note the
uncomfortable shape of this honestly: the finding that blocks the gate is the
one that inconveniences the auditor, and a reader is entitled to discount it on
that basis and adjudicate under E5.

WHAT I DID ABOUT THE UNEXECUTABLE INSTRUCTION. I did not edit the packet and did
not list it in Files-in-this-commit. A work order cannot enlarge a write scope —
only an ADR can (PROTOCOL §11) — and my charter §5 says I stage nothing outside
docs/reports/audit/**, ever. Obeying the WO would have meant either a refused
commit or a scope violation on the auditor's very first entry, which would have
made the role's central guarantee ("the auditor can never fix what it finds")
false at its first exercise. The RETURNED verdict is recorded in the report and
here instead, and the report states that the orchestrator must transcribe the
Return log as it transcribes gate signatures.

VERDICT SHAPE. I split the verdict into two rows rather than one. G0 item 10's
own condition is "audit report committed", which is satisfied; the gate as a
whole is blocked by the open CRITICAL under WO-0001's stated rule. Collapsing
these would have misreported either the deliverable or the finding.
### Actions
Read the charter, protocol and work order in that order, then the full M0
history. Performed per-commit R1-R8 verification independent of CI; assessed
orchestrator attribution honesty as substance-vs-narrative (R1 is audit-enforced
for this agent); assessed escalation discipline against E1-E6; sampled all seven
journal entries for vacuity; ran four Evidence re-executions; instrumented the
enforcement suite; queried GitHub Actions for run metadata and two job logs;
tested the shipped write-scope policy directly for all nine agents. Wrote
docs/reports/audit/AUD-0001-g0-retro.md with 17 numbered, severity-tagged
findings and a two-row gate verdict. Ran no git command that writes: no commit,
no push, no checkout, no stash, no worktree, no fetch. Did not modify the work
order packet (see Reasoning).
### Evidence
Working-tree integrity, before and after all of the below:
  `git status --porcelain=v1` -> empty; `git rev-parse HEAD` -> 75d47ed
  (HEAD moved from bace24f to 75d47ed during this audit by the orchestrator's
  own concurrent commit, not by me — reflog HEAD@{0}/HEAD@{1}; AUD-0001-F15).

RX-1, J-orchestrator-0001 Evidence at its recorded SHA 7f54130:
  `git archive 7f54130 | tar -x -C $SCRATCH/t_7f54130` then, in that snapshot,
  `bash scripts/test_protocol.sh`
  observed: "protocol self-test: 13 passed, 0 failed" (exit 0)
  claimed:  "protocol self-test: 13 passed, 0 failed" -> REPRODUCES EXACTLY.

RX-2, J-orchestrator-0004 Evidence at its recorded SHA d499ce8:
  `git archive d499ce8 | tar -x -C $SCRATCH/t_d499ce8` then
  `bash scripts/test_protocol.sh`
  observed: "protocol self-test: 24 passed, 0 failed" (exit 0)
  claimed:  "protocol self-test: 24 passed, 0 failed" -> REPRODUCES EXACTLY.
  Same command at HEAD -> "protocol self-test: 24 passed, 0 failed".
  `git log --oneline -- scripts/` -> only d499ce8 and 7f54130, confirming the
  scripts are unchanged since d499ce8 so the HEAD run is equivalent.

RX-3, J-orchestrator-0005 Evidence, run at HEAD by choice:
  `bash scripts/check_journals.sh --all`
  observed: "OK: 7 commit(s) satisfy the journal/commit protocol" (exit 0).

RX-4, J-orchestrator-0005 Evidence, external:
  GitHub Actions journal-check runs 30707323951 / 30707471108 / 30711401488
  all exist on branch claude/fpga-hardcaml-agent-orchestration-37ceyf with
  conclusion=success (heads b135a7f, f43f71f, d499ce8) -> claim TRUE.
  Job 91388576990 (run 1) log: "BEFORE_SHA: 0000000000000000000000000000000000000000"
  then "OK: 2 commit(s)" -> the entry's specific "--all path" claim is TRUE.
  Job 91399393632 (run 3) log: "BEFORE_SHA: f43f71f...", "AFTER_SHA: d499ce8...",
  then "OK: 1 commit(s)" -> primary evidence for AUD-0001-F3.
  Runs 4-6 (30711432962, 30715240609, 30715333425) also conclusion=success.

RX-5, ephemeral corroboration (AUD-0001-F5/F6):
  judge.json -> winner "Lean Five", score 86 (vs 81, 74) -> J-orchestrator-0001
  Inputs claim TRUE. review_findings.json -> 26 findings, declared severities
  1 CRITICAL / 10 MAJOR / 15 MINOR, against the journal's and ADR-0002's
  "1 CRITICAL, 9 MAJOR, 16 MINOR" -> total and CRITICAL TRUE, split MISSTATED.

Independent R4 recomputation, all seven commits (changed paths minus own
journal vs the entry's Files list): 7f54130 18 paths, b135a7f 12, f43f71f 9,
d499ce8 23, ef543b0 3, bace24f 1, 75d47ed 2 — all exact set matches.
R8: all eight foreign seeds at 7f54130 contain 0 entry headers.
R9: `git rev-list --merges --all | wc -l` -> 0; no multi-parent commits;
`git ls-remote origin` tip == local HEAD (75d47ed).

AUD-0001-F1, instrumented suite (expect_fail printing the rejection reason):
  S5 "files-list mismatch rejected (R4)" actually rejected for
    "agents/journals/claude_rtl_lead_agent.md is not a pure EOF-append ... (R3)"
  S19 "architect blocked from docs/reports/audit (R7)" actually rejected for
    "Files-in-this-commit list does not equal the staged non-journal set (R4)"
  S12 "journal rewrite caught (R3/R8)" actually rejected for
    "f28dea9: missing 'Agent:' trailer (R6)"
  Root cause probe at S5 entry: "PROBE: journal DIFFERS from HEAD entering S5"
  with the S4 tamper string "+REVISED HISTORY" still present, traced to the
  checkout-before-reset ordering at scripts/test_protocol.sh:112.

AUD-0001-F2: `grep -n -i "duplicate\|interpret-trailers\|octopus"
  scripts/test_protocol.sh` -> no matches, against enforcement added at
  scripts/check_journals.sh:41-43 and :60-64 in d499ce8.

AUD-0001-F4: `grep -rn "I sign" agents/journals docs/gates` -> no matches.

AUD-0001-F17: `. scripts/policy.sh; agent_may_write <agent>
  agents/handoffs/WO-0001_g0-retro-audit.md` ->
  auditor: DENIED; tb_writer, dv_lead, rtl_lead, architect_docs_lead,
  rtl_module_dev, data_wrangler, formal_dv: ALLOWED. The auditor is the only
  one of the nine denied, against agents/PROTOCOL.md:66-69 which asserts
  agents/handoffs/ is inside every agent's write scope.

AUD-0001-F7: `git show --name-only bace24f` -> packet + orchestrator journal
  only, no tasks/BOARD.md; at HEAD tasks/BOARD.md:34 still reads "_None. First
  work orders are issued at M1 kickoff._" while tasks/BOARD.md:40 in the same
  file reads "item 10 in flight as WO-0001".

Positive verification of a journal self-correction (J-orchestrator-0002):
  `git show 7f54130:scripts/agent_commit.sh | grep -n extra-trailer` -> line 26
  present, so the claim that the flag landed in the previous commit is TRUE.
### Outcome
DoD vs WO-0001: MET, with one item refused on protocol grounds and one item
answered differently than asked.
  - Per-commit R1-R8 beyond CI's mechanical checks: MET (§3 of the report).
  - Journal vacuity sampling: MET, 7/7 entries, none vacuous (§4).
  - At least two Evidence re-executions at the recorded SHA: MET and exceeded —
    four (RX-1..RX-4), two of them at the exact recorded SHAs via isolated
    snapshots, with the working tree provably untouched.
  - Orchestrator attribution honesty: MET (§6) — assessed honest, with the
    non-roster-delegation precedent recorded as AUD-0001-F13.
  - Escalation discipline vs E1-E6: MET (§7) — in class and batched; one
    unclassed item as AUD-0001-F16. No missing E2/E3/E5/E6 found.
  - Structural honesty caveat: MET (§1), stated as five explicit limitations
    including that most of my charter had no subject matter at M0.
  - Gate-row verdict for G0 item 10: MET (§10) — PASS WITH FINDINGS for the
    item; G0 as a whole BLOCKED by AUD-0001-F17 under WO-0001's own rule.
  - RETURNED entry appended to the packet's Return log: NOT DONE, and
    deliberately so — it is outside my write scope and is itself the CRITICAL
    finding (AUD-0001-F17). The orchestrator must transcribe it.
  - Files-in-this-commit listing the packet path: NOT DONE, same reason; listing
    a path I did not stage would fail R4.
Handoff: docs/reports/audit/AUD-0001-g0-retro.md to the orchestrator for commit
under trailer Agent: auditor. AUD-0001-F17 is CRITICAL and goes to the sponsor
as E4, verbatim, per PROTOCOL §8 and charter §7. I sign G0 checklist item 10;
the orchestrator transcribes that row per PROTOCOL §7 with this entry as
authority.
### Open-questions
1. AUD-0001-F17 disposition is not mine to choose: amend PROTOCOL §6 to give the
   auditor agents/handoffs/** for its own packets' Return logs, or amend the §3
   sentence and charter orchestrator transcription. Either needs an ADR and a
   test_protocol.sh scenario; I must re-verify before G0 can close.
2. AUD-0001-F9 (report naming: charter says audit-NNNN_<slug>.md, WO-0001 said
   AUD-0001-g0-retro.md) needs one canonical answer before AUD-0002, or the
   audit directory will carry two naming conventions.
3. Whether a sponsor canary was planted in this window is unknown to me by
   design. I found none and say so; if one was planted and missed, that is my
   own CRITICAL and I ask to be told.
4. Relay fidelity is untestable so far — no verbatim-class packet has ever been
   relayed. This report is the first subject of that control.
5. Whether the orchestrator should freeze commits for the duration of an agent
   spawn (AUD-0001-F15) is a process question for the orchestrator, not a
   finding I can close.
### Files-in-this-commit
- docs/reports/audit/AUD-0001-g0-retro.md

## [J-auditor-0002] 2026-08-01T20:04:00Z | task:WO-0001 | Correct AUD-0001 after it was committed mid-edit; raise F15 to MAJOR
### Trigger
While I was still editing docs/reports/audit/AUD-0001-g0-retro.md, the
orchestrator staged, committed and pushed it as bd7fbcf ("AUD-0001: G0
retro-audit of the M0 commit range", Agent: auditor, Journal-Entry:
J-auditor-0001). The commit captured an intermediate draft: 28 lines of
corrections I had already written were left uncommitted. bd7fbcf is pushed, so
R9 forbids amending it and a follow-up commit is the only lawful repair. R2
requires that follow-up commit to carry a journal append, which is this entry.
No new audit work was performed; this is a correction of AUD-0001 only.
### Inputs
docs/reports/audit/AUD-0001-g0-retro.md (the committed version at bd7fbcf and my
working copy); agents/journals/claude_auditor_agent.md (J-auditor-0001, read but
not modified — it is committed and append-only); commit objects 75d47ed,
b35c72f, bd7fbcf; `git ls-remote origin`; agents/PROTOCOL.md §5 R9, §4.2.
### Reasoning
Three things needed fixing and one needed deciding.

FIX 1, my own arithmetic error. The committed report's header and gate-verdict
row both said "1 CRITICAL, 5 MAJOR, 7 MINOR, 4 NOTE". Counting the severity tags
on the 17 finding headings gives 1/7/7/2. The per-finding severities were never
wrong — only the summary. I corrected it in place and, rather than silently, I
annotated the correction in the report and named it as the same class of defect
I had just filed against the orchestrator as AUD-0001-F6 (a misstated severity
tally). An auditor who files F6 and then quietly fixes its own instance of F6
has forfeited the standing to file it.

FIX 2, restore the 28 lost lines: the re-verified SHA basis (every file:line
citation re-checked at b35c72f after the tip moved), the AUD-0001-F3 note on how
the corrected item-9 click-path interacts with that finding, and the F15 update.

FIX 3, severity. I raised AUD-0001-F15 from NOTE to MAJOR. When I wrote it, it
described a hazard: "a commit landing while another agent's uncommitted files sit
in the tree can capture them". Before I finished the report, that hazard fired
and captured this report. A finding that predicts an event which then occurs
inside the same audit cannot honestly stay a NOTE. I considered whether raising
it looks self-serving, since the event inconvenienced me — I concluded the
opposite risk is worse: leaving it at NOTE would understate a control gap that
from M1 could commit a half-written SO- packet as a PASS or sign off RTL caught
between two edits. The severity follows the consequence class, not the victim.

THE DECISION: whether to write this second entry at all. My spawn instruction
said "append exactly one journal entry", which assumed one commit. Two commits
now exist, and R2 makes one journal append per commit mandatory; a second commit
with no entry would be refused by agent_commit.sh and would be a coupling
violation in CI. Protocol beats instruction. I kept the entry narrow — correction
only, no new findings, no re-opened analysis — so the record stays proportionate
to what actually changed. I also considered leaving the stale report standing and
noting the errors in a future AUD-0002; I rejected that because a committed audit
report carrying a wrong severity tally in its own header is a false claim sitting
in the evidence base for a gate, and audit reports are the one artifact that
cannot be allowed to be wrong-but-superseded.

I did not touch J-auditor-0001. It is committed, append-only, and its Evidence
records HEAD as 75d47ed — true when observed. The divergence between that and
the eventual commit parent is itself evidence for AUD-0001-F15 and is explained
in the report rather than edited away.
### Actions
Recounted all 17 finding severities from the report's own headings; corrected
the tally in the report header and in the §10 gate-verdict row with an inline
note of the correction; restored the SHA-basis paragraph, the AUD-0001-F3
item-9 interaction note, and the rewritten AUD-0001-F15; raised F15 to MAJOR and
updated the §8 findings index and the §10 disposition order accordingly. Ran no
git command that writes: no commit, no push, no amend, no checkout, no force.
### Evidence
`git log --oneline -1` -> bd7fbcf "AUD-0001: G0 retro-audit of the M0 commit range"
`git show --format='' --name-status bd7fbcf` ->
  M agents/journals/claude_auditor_agent.md
  A docs/reports/audit/AUD-0001-g0-retro.md
`git log -1 --format=%B bd7fbcf` -> trailers Agent: auditor, Work-Order: WO-0001,
  Journal-Entry: J-auditor-0001 (the commit itself is protocol-correct; only its
  timing is the finding)
`git ls-remote origin refs/heads/claude/fpga-hardcaml-agent-orchestration-37ceyf`
  -> bd7fbcf == local HEAD, i.e. already pushed, so R9 bars amending it.
`git diff --stat docs/reports/audit/AUD-0001-g0-retro.md` at the moment of
  discovery -> "1 file changed, 28 insertions(+), 12 deletions(-)" uncommitted.

Severity recount, from the report's own finding headings
(`grep -o '^### AUD-0001-F[0-9]* — \*\*[A-Z]*\*\*' | sort | uniq -c`):
  1 CRITICAL (F17); 7 MAJOR (F1,F2,F3,F4,F5,F7,F15); 7 MINOR
  (F6,F8,F9,F10,F11,F12,F16); 2 NOTE (F13,F14). Total 17.
  Committed-at-bd7fbcf header claimed 1/5/7/4 -> corrected to 1/7/7/2.

Citation re-verification at b35c72f (all still resolve, hence the report's
SHA-basis note): agents/PROTOCOL.md:66-69 and :221 (the F17 contradiction);
scripts/policy.sh:61-65; scripts/test_protocol.sh:112; scripts/check_journals.sh:41-43
and :60-64; agents/charters/orchestrator.md:37; tasks/BOARD.md:34 and :40;
docs/adr/ADR-0002-adversarial-review-fixes.md:8 and :15-17;
.claude/agents/data_wrangler.md:4. Re-ran the F17 probe at b35c72f:
`. scripts/policy.sh; agent_may_write auditor agents/handoffs/x.md` -> DENIED.

Journal append integrity for this entry: the file as committed at bd7fbcf is a
byte-prefix of the file I am handing over (verified with cmp against a
pre-append copy), so R3 holds and J-auditor-0001 is untouched.
### Outcome
DoD: the correction is complete and AUD-0001 now states its own findings
accurately. The audit's substantive verdict is UNCHANGED — G0 checklist item 10
PASS WITH FINDINGS, G0 as a whole BLOCKED by the open CRITICAL AUD-0001-F17.
The tally is now 1 CRITICAL, 7 MAJOR, 7 MINOR, 2 NOTE.
Handoff: docs/reports/audit/AUD-0001-g0-retro.md to the orchestrator for a
second commit under trailer Agent: auditor, Journal-Entry: J-auditor-0002. That
commit is required, not optional — without it the pushed report misstates its
own severity tally. WO-0001's Return log remains untranscribed and outside my
write scope (AUD-0001-F17); the orchestrator must write it.
### Open-questions
1. All five open questions from J-auditor-0001 remain open; none are closed by
   this correction.
2. AUD-0001-F15 now needs a concrete control chosen by the orchestrator (commit
   freeze during a spawn, or path-scoped staging plus an explicit completion
   signal). The completion signal depends on AUD-0001-F17 being fixed first,
   since the packet Return log is that signal and I cannot write it.
3. If the orchestrator disputes raising F15 to MAJOR, my charter §7 puts that on
   the E5 path: one round of written argument in packets, and the finding stands
   as written until adjudicated. I will not soften it to settle.
### Files-in-this-commit
- docs/reports/audit/AUD-0001-g0-retro.md

## [J-auditor-0003] 2026-08-01T20:35:30Z | task:WO-0001 | Re-verification of the AUD-0001 dispositions: F17 CLOSED, gate block lifts, 6 new findings
### Trigger
Orchestrator re-verification spawn under WO-0001, spawn short-id
WO-0001/2026-08-01T20:32Z, for G0 checklist item 11 ("AUD-0001 CRITICAL (F17)
dispositioned by ADR and re-verified by the auditor"). I am a fresh spawn; my
predecessor's two entries and AUD-0001 are committed, and I relied only on
repository artifacts. Baseline pinned in the spawn prompt at e57511b — the
AUD-0001-F15 control, applied to me and honored.
### Inputs
agents/charters/auditor.md; agents/PROTOCOL.md (esp. §3 as amended, §4.1, §5
R1-R9, §6, §7, §8, §11); agents/handoffs/WO-0001_g0-retro-audit.md (RETURNED,
incl. the transcribed Return log); docs/reports/audit/AUD-0001-g0-retro.md (as
corrected at de85393); docs/adr/ADR-0003-aud-0001-disposition.md;
docs/adr/ADR-0002-adversarial-review-fixes.md:8; docs/gates/G0-checklist.md;
tasks/BOARD.md; README.md:45-51; agents/charters/orchestrator.md:26,37;
scripts/policy.sh, scripts/agent_commit.sh, scripts/check_journals.sh,
scripts/test_protocol.sh; .github/workflows/journal-check.yml;
agents/journals/claude_orchestrator_agent.md (J-orchestrator-0009, 0010, 0011,
and 0001-0008 for the signature grep); agents/journals/claude_auditor_agent.md
(J-auditor-0001, J-auditor-0002 — read, never modified above EOF); GitHub
Actions run/job records for renatom11/agentic-fpga.
### Reasoning
SAMPLING FRAME. Window: the three commits since AUD-0001's report landed —
89d7b2b (ADR-0003 + fixes), c976c5b (live-fire journal-only), e57511b (item 9
signed). Census on all three. Census on all 17 AUD-0001 findings, not the six
the spawn prompt named: a disposition ADR is a single artifact and grading only
part of it would let the ungraded part carry unverified claims into the gate —
which is exactly where two of my six new findings came from. All 26 enforcement
scenarios instrumented. Five of six Evidence claims in the three new
orchestrator entries re-executed or externally corroborated. DELIBERATELY
SKIPPED: the M0 range itself (AUD-0001 did a census; the full-history
check_journals re-proves nothing was rewritten), the five inactive charters
(still unexercised), and every charter duty with no subject matter yet —
spec-drift, mutation, replay, licensing, DV independence. This is a
re-verification, not a second full audit, and the report says so.

METHOD: adversarial by instruction and by preference. I took no ADR sentence on
trust. Where ADR-0003 says "fixed", I re-executed. Where it says "corrections
applied", I ran git log on the cited file. That single discipline produced
AUD-0002-N2: three claims of delivered work that the repository falsifies
(orchestrator.md:37 never touched; only items 4 and 10 re-affirmed, not the
historical set; S23 does not exercise the interpret-trailers change). None of
those would have surfaced from reading the ADR carefully — only from checking it.

F17, THE LOAD-BEARING JUDGEMENT. Three separable questions. (1) Is the
contradiction gone? Yes: §3 now says "except the auditor's" and adds the
transcription paragraph; §6:230 is unchanged; they now agree. (2) Is the
boundary really unchanged? Yes, and I insisted on proving it by executing the
shipped policy rather than reading the table — auditor DENIED on
agents/handoffs/, all eight others ALLOWED, and auditor ALLOWED on its own
report path. policy.sh has not been touched since d499ce8, which is the
strongest possible evidence that the repair was documentary. (3) Is the
rationale right on its merits? I judged it right, and for a reason ADR-0003
does not state: policy.sh matches path prefixes and cannot express "the auditor
may write its OWN packet's Return log". So option A was never "grant the
auditor its own Return log" — it was necessarily "grant the auditor every
packet in the program, including the SO- and BUG- packets whose relay fidelity
it polices". There is no mechanically expressible middle. That makes B the only
sound option, which is a stronger conclusion than the ADR's "symmetry loses to
crispness of measurement". I verified the premise instead of assuming it.

What I would not let pass: ADR-0003 never engages the objection AUD-0001-F17
itself raised against option B — that transcription hands a participant's
lifecycle action to the party it audits. I judged that this does not reopen
F17, because the compensating control is genuine (authority lives in my
append-only journal and a committed report the sponsor reads unmediated) and
because I then exercised the control and it worked: the fidelity diff caught a
defect. But it converts fidelity spot-checking from "sample" to "standing" for
transcribed Return logs, and I said so rather than leaving it implicit.

THE HARDEST CALL: severity of N1. The Return log, ADR-0003:13 and BOARD:12 all
state a tally (1/6/6/4) my predecessor never wrote, and the direction is not
neutral — ADR-0003:119 files F15 under "NOTE, no action" when J-auditor-0002
raised it to MAJOR with reasons. Charter §3 says any edit found in a
relay-fidelity diff of verbatim-class material is CRITICAL, and my findings are
verbatim class. I argued myself toward CRITICAL and then rejected it on three
grounds recorded in the report: the protected artifact (AUD-0001) is
byte-intact and reaches the sponsor directly, which is what the verbatim rule
exists to protect; the defective statements sit in Summarizable-class
derivatives where PROTOCOL §3 permits summarisation; and inflating an
arithmetic-plus-classification slip into a gate block would damage the audit
function's credibility as badly as softening one. MAJOR, with the rejected
CRITICAL argument written out so a reader can overrule me on the evidence. I
also refused the tempting symmetry of blocking G0 on a finding that concerns
how my own predecessor's severities were restated — that would be an auditor
using the gate to defend its own tally, which is the wrong instinct.

N6 (R9 force-push exception) I nearly filed as MINOR, because it was
disclosed, reversed within one second, and cost zero history — all verified.
MAJOR is right anyway: the sole committer suspended, on its own authority, the
one rule that makes every other rule durable, on the branch R9 protects, with
89d7b2b (the CRITICAL's disposition) momentarily off the remote, and recorded
it only in its own journal. PROTOCOL has no exception clause and §11 requires
an ADR. Honest disclosure after the fact is not authorization before it. I also
wrote the countervailing fact at full strength — the test found that
protect-history matched zero branches, so item 9 would otherwise have been
signed on a ruleset guarding nothing — because a finding that hides the good
reason behind the act is not a fair finding, and because I do not want the
lesson taken to be "disclose less".

GATE RULING. AUD-0001 §8's severity key, which ADR-0003 accepted, says CRITICAL
blocks the gate and MAJOR must be dispositioned before the NEXT gate. No open
CRITICAL exists. So the block lifts and G0 may close, and I say so plainly
rather than inventing a reason to keep a gate I have leverage over. I recorded
one REQUEST (correct N1's three tally lines before item 11 is transcribed) and
labelled it explicitly as a request, not a block — the distinction matters more
than getting my way on it.
### Actions
Wrote docs/reports/audit/AUD-0002-g0-reverification.md (per-finding verdict
table for all 17 AUD-0001 findings, six new findings N1-N6, gate rows).
Re-executed scripts/test_protocol.sh and scripts/check_journals.sh --all at
e57511b. Built two scratch derivatives of test_protocol.sh (never in the repo):
one with expect_fail instrumented to print every captured rejection, one with
only the S4/S12/S19 fixes reverted to their de85393 form. Ran a hand-built
scratch repo to probe trailer body-line shadowing. Executed the AUD-0001-F17
policy probe against the shipped scripts/policy.sh. Queried GitHub Actions run
and job records. Ran no git command that writes: no commit, push, amend,
checkout, stash, reset, or worktree. Edited no file outside my write scope.
### Evidence
Baseline: `git rev-parse HEAD` -> e57511bc2d510942e76a62e9e4d89495f63e78b8;
`git status --porcelain` -> empty, before and after everything below.

F1/F2 — `bash scripts/test_protocol.sh` -> "protocol self-test: 26 passed, 0
failed" (exit 0). Instrumented re-run: all 20 rejection scenarios print a
rejection matching the rule they name; specifically S5 -> "Files-in-this-commit
list does not equal the staged non-journal set (R4)", S12 -> "...is not a pure
EOF-append (R3)", S19 -> "path outside architect_docs_lead's write scope:
docs/reports/audit/fake.md (R7)". S23 -> "duplicate 'Agent:' trailer (R6)";
S24 -> "octopus merge commits are forbidden (R9)". Reconstruction of the
pre-fix state (reason assertions kept, three scenario fixes reverted) ->
"23 passed, 3 failed", failing exactly S5, S12, S19 with exactly the reasons
AUD-0001-F1 predicted; 23+3 vs J-orchestrator-0009's 21+3 is the two added
scenarios, so that claim reproduces in substance (it is reproducible from no
SHA — AUD-0002-N5). Trailer-shadowing probe in a scratch repo: a message with
"Agent: auditor" in an earlier paragraph and "Agent: rtl_lead" in the final
block yields `git interpret-trailers --parse` -> "Agent: rtl_lead" only.

F3 — `bash scripts/check_journals.sh --all` -> "OK: 13 commit(s) satisfy the
journal/commit protocol" (exit 0). .github/workflows/journal-check.yml:24-25 is
an unconditional step. GitHub run 30716890065 (head e57511b), job 91413875421:
step 4 "Verify full history (append-only cannot be re-checked incrementally)"
= success, step 5 "Verify commit range" = success.

F17 — `. scripts/policy.sh; agent_may_write <agent> agents/handoffs/WO-0001_g0-retro-audit.md`
-> auditor: DENIED; tb_writer, dv_lead, rtl_lead, architect_docs_lead,
rtl_module_dev, data_wrangler, formal_dv, orchestrator: ALLOWED.
`agent_may_write auditor docs/reports/audit/AUD-0002-g0-reverification.md`
-> ALLOWED. `git log --oneline -- scripts/policy.sh` -> d499ce8, 7f54130.
agents/PROTOCOL.md:66-70 and :72-78 vs :230 — consistent.

Tamper checks — `git log --oneline -- docs/reports/audit/AUD-0001-g0-retro.md`
-> de85393, bd7fbcf. `git log --oneline -- agents/journals/claude_auditor_agent.md`
-> de85393, bd7fbcf, 7f54130. Neither touched since handover.

N1 — WO-0001_g0-retro-audit.md:23, ADR-0003:13, BOARD:12 all read
"1 CRITICAL, 6 MAJOR, 6 MINOR, 4 NOTE"; AUD-0001:19 and :873 read 1/7/7/2;
claude_auditor_agent.md:337-341 recounts per finding. ADR-0003's own body
carries 6 MAJOR headings, 7 MINOR (:104), 3 NOTE (:119) = a third tally.
J-orchestrator-0009 (claude_orchestrator_agent.md:364-365) states 1/7/7/2
correctly in the same commit.

N2 — `git log --oneline -- agents/charters/orchestrator.md` -> d499ce8,
f43f71f (both pre-audit), so ADR-0003:106's "corrections applied ... stale
branch-protection restatement" is false; :37 still reads "branch protection on
`main`" against :26's "on `main` and the working branch".
`git log --oneline -- docs/adr/ADR-0002-adversarial-review-fixes.md` -> d499ce8
only; :8 still "(1 CRITICAL, 9 MAJOR, 16 MINOR)". `grep -rn "I sign"
agents/journals docs/` -> three statements only, covering G0 items 4, 9, 10;
items 1, 2, 3, 5, 6, 7 unaffirmed. agents/PROTOCOL.md:117-120 unchanged, so
F5's standing rule is nowhere an agent must read.

N6 — GitHub runs 30716399563 (89d7b2b, 20:10:36Z), 30716528552 (de85393,
20:14:12Z), 30716529281 (89d7b2b, 20:14:13Z): independent corroboration that
the working-branch tip rewound one commit and returned, matching
J-orchestrator-0010's disclosure. `git ls-remote --heads origin` ->
e57511bc2d51... (working branch), bd7fbcf33c27... (main).
`git rev-list --merges --all | wc -l` -> 0.
### Outcome
DoD vs the re-verification task: MET.
  1. F17 re-verified: §3/§6 contradiction gone, repair confirmed (auditor scope
     unchanged at docs/reports/audit/** only; orchestrator transcribes),
     Return log diffed for relay fidelity, independence rationale judged on its
     merits and endorsed with a stronger premise than the ADR's — MET.
  2. F1/F2: suite re-run, expect_fail confirmed to assert reasons, S5/S12/S19
     confirmed to test the rules they name, S23/S24 present, 26/26 green — MET;
     F2 graded PARTIALLY CLOSED with the residual named.
  3. F3: workflow runs --all unconditionally, verified in a real CI job; ran it
     myself over 13 commits — MET.
  4. F4: signature statements checked against §7's formula; forward-only
     application judged coherent and correct, and the ADR's overstatement of
     what was re-affirmed recorded — MET.
  5. F7: BOARD tracks WO-0001; new internal contradictions found — MET.
  6. Spot-checks: F5, F6, F9, F10, F11, F12, F13, F14, F15, F16 and the
     J-orchestrator-0010/0011 live-fire disclosures all graded — MET.
Verdicts: F17 CLOSED. CLOSED: F1, F3, F8, F12, F13. PARTIALLY CLOSED: F2, F4,
F5, F7, F15. STILL OPEN: F6, F10. Otherwise dispositioned: F9 (by decision),
F11 (accepted, undemonstrated), F14 (acknowledged), F16 (moot).
New findings: N1 MAJOR, N2 MAJOR, N3 MINOR, N4 MINOR, N5 MINOR, N6 MAJOR. No
CRITICAL. Nothing found blocks the gate.
GATE: the F17 CRITICAL block LIFTS; G0 MAY CLOSE. I sign G0 checklist item 11.
Authority for that signature is this entry plus
docs/reports/audit/AUD-0002-g0-reverification.md; the orchestrator transcribes
the checklist row (PROTOCOL §7) and any Return-log entry (PROTOCOL §3 auditor
exception) under its own trailer — I stage neither.
Handoff: docs/reports/audit/AUD-0002-g0-reverification.md to the orchestrator
for commit under trailer Agent: auditor, Journal-Entry: J-auditor-0003. N1 and
N2 concern the relaying party; per charter §7 this report is relayed unedited.
### Open-questions
1. N1's disposition is not mine: correct the three tally lines, and either
   accept F15 at MAJOR or declare an E5 dispute. "Accepted, none disputed"
   alongside a lowered severity cannot both stand.
2. N6 needs a ruling on whether R9 admits a verification exception. If it does,
   it needs an ADR with preconditions and a disclosure duty; if it does not,
   the record should say the exception was a violation accepted after the fact.
3. F6 and F10 remain open, and ADR-0003 says otherwise. Whether ADR-0002 is
   immutable history (like ADR-0001) or a correctable current record is the
   orchestrator's call — but the disposition should state which.
4. F15's completion-signal control exists in practice and in no committed
   artifact. It worked for this spawn; it will not survive a rehydration.
5. Charter naming (F9) still disagrees with practice at auditor.md:29. Harmless
   now, ambiguous by AUD-0003.
6. Whether a sponsor canary was planted in this window is unknown to me by
   design. I found none and say so.
### Files-in-this-commit
- docs/reports/audit/AUD-0002-g0-reverification.md

## [J-auditor-0004] 2026-08-03T03:29:17Z | task:WO-0039 | Five M03 mutations seeded blind: diffs, fidelity arguments, and three disclosures where a stated intent and its only faithful implementation diverge
### Trigger
Orchestrator spawn on WO-0039 (`agents/handoffs/WO-0039_m03-mutation-campaign.md`,
committed at 0d231ee) — dv_lead's packet to me, relayed §§1-5 only. I am ruled in
as the campaign's no-stake third party after dv_lead declined to self-seed on
taint grounds: I authored neither M03's RTL nor its bench. This is chartered work
(charter §3, systematic mutation testing) at the PROTOCOL §10 sequencing point —
after rtl_lead's `RV-` ACCEPT, before dv_lead may issue `SO-M03`. My duty is
seeding only: I do not run the diffs and do not see their results (packet §3).
### Inputs
This section is the campaign's enforcement mechanism, not a formality — packet §0
states that the blinding has no script behind it and that my disclosure is the
whole of it. Read, in full unless noted: `agents/charters/auditor.md`;
`agents/PROTOCOL.md`; `agents/handoffs/WO-0039_m03-mutation-campaign.md` (at
0d231ee); `docs/specs/modules/xgmii_rx_64.md` (SPEC-M03, all 949 lines);
`libs/hardcaml_ethernet/src/xgmii_rx_64.ml` (at 6bd7e5a, sha256
3d87515a843d98d7d5bd6692a9d19cdbe2b0dee4e430c88f871a2d4887f5be92);
`libs/hardcaml_ethernet/src/xgmii_rx_64.mli`;
`libs/hardcaml_ethernet/src/crc32_eth.ml` (M02's finished-value convention, which
M2's fidelity argument turns on); `libs/hardcaml_ethernet/src/dune` and
`dune-project`; `docs/adr/ADR-0005-build-environment.md`;
`agents/journals/claude_auditor_agent.md` (header and the head of my 0003 entry,
for the next id and the grammar — read only, never modified above EOF). Partial:
`libs/hardcaml_ethernet/src/xgmii_tx_64.ml` and `axi64.ml`, grep hits only (lines
119-120, 211, 236, 240 and 7-9), from one grep for the Hardcaml idioms this
library already uses. Git objects: `git log --oneline -16`; `git show 0b64b68` in
full, including its RTL diff, which is M5's reverted hunk;
`git show 0b64b68^:libs/hardcaml_ethernet/src/xgmii_rx_64.ml`;
`git diff --stat 6bd7e5a HEAD` and the same restricted to `-- libs/`. Directory
listings only: `ls -R libs/`, `ls docs/adr/`, `ls -R docs/reports/audit/`,
`ls /root/.opam/fpga/{bin,lib}`.

NOT read, and the list is the point. Packet §1's three read bars, all honoured:
nothing under `test/xgmii_rx_64/**` — in fact no file under `test/` at all, of
any name, at any SHA; not `test/attack_plans/AP-xgmii_rx_64.md` nor anything else
under `test/attack_plans/`; not
`agents/handoffs/WO-0039_m03-mutation-campaign-SEALED-predictions.md`, of which I
know only that a path with that name and a line count appears in a `--stat`
output I ran for a different purpose. Beyond the bars, by my own choice:
`agents/handoffs/BUG-0001_m03-final-word-over-delivery.md` (the packet points at
it for M5's invariant, so opening it was sanctioned — I did not, because a
dv_lead bug packet will name the bench rows that caught the defect, and M5's
implementation is dictated by the packet anyway); `claude_dv_lead_agent.md` and
`claude_rtl_lead_agent.md` (dv_lead's journal grew 240 lines in the commit that
sealed the predictions — reading it inside the blind window is the sealed file by
another route). No `test/`, no `site/`, no `tasks/BOARD.md`.
### Reasoning
FRAME. There is no sample here: the packet names five intents and all five were
implemented, so this is a census of the assignment and the reconstructible thing
is not *what I looked at* but *what I refused to look at* — recorded above. One
structural check came first: `git diff 6bd7e5a HEAD -- libs/` is empty, so the
working tree's copy of the module is the frozen blob and every diff could be
authored against the file in front of me rather than against a checkout.

The defect classes were not mine to choose — dv_lead specified all five
behaviourally (charter §8 asks a mutation entry to record the class choice and
the rejects; here the choosing was done one packet up, and what was mine was
site, mechanism and the reading of each intent where the module's structure did
not match the intent's picture of it). That mismatch is the substance of this
entry, because three of the five have one, and each forced a decision that a
result cannot later be reinterpreted around.

M1 (latency ±1). I chose *later*, by one extra register level on every output
leaf. Earlier is not reachable minimally: the two payload levels are REQ-019's
permitted depth and the third cycle is the lane-4 assembly register, so removing
one changes content, not merely timing. Lane-uniformity is then structural — the
added register sits downstream of all lane, alignment and coverage logic and
cannot tell a lane-0 frame from a lane-4 one. The decision that matters is the
strobes: the intent's content list says "the same error strobes", which can be
read as *leave them where they are*. I rejected that reading and delayed them
with the stream, because SPEC-M03 §9 pins every strobe to the cycle its frame's
`tlast` word is emitted; moving the stream and pinning the strobes would break
that relation and seed a second defect on top of the first, which is exactly the
ambiguity packet §2's minimality bar exists to prevent. Disclosed as open
question 1: if dv_lead meant stream-only, M1 is the wrong mutation and must be
re-seeded rather than reinterpreted after its result.

M2 (CRC held across a lane-4 start's octets 0-3). The accumulator's enable is one
binding, `crc_update`, with exactly one consumer, and `cov_first ==:. 4` is true
on exactly the word the intent names — the second preamble word of a lane-4
start, C-18's first non-instance. So the diff is one line and touches nothing
that computes coverage, counts, `tkeep`, `tlast` or timing. I rejected gating on
`in_preamble &: frame_start4` (identical in effect, but a fresh expression where
the file already contains the exact one, one line above, for M02's data shift).
The reason the verdict provably flips rather than probably flips is M02's
convention: `crc_in` carries *finished* values, so the 0x00000000 seed starts the
internal register at 0xFFFFFFFF, and dropping four leading octets changes the
value even when those octets are zero — the case a zero-initialised CRC would
have absorbed silently.

M3 (`tkeep` from the terminating input word). The intent names a quantity the
module does compute — `cov_count` on the closing cycle, which in `Frame` is the
terminate lane index — but computes two cycles before the `tkeep` decision needs
it. I considered deriving it at the emit cycle from `pc`, `nc` and `off4`: it
reproduces the quantity exactly on terminated frames at both lanes, and I
rejected it because `off4` can already have been reloaded by a following frame at
a REQ-110 restart, which would turn a `tkeep` defect into an intermittent one on
abort stimuli. The faithful mechanism is the one the design already uses for the
same class of fact: widen the ageing closure record by four bits and read the
count back through the same `sel` that `strip` reads, so the mutant inherits the
unmutated record-to-word association instead of inventing one. Two consequences
had to be disclosed rather than smoothed: the delivered octet sequence changes
(unavoidable — on this stream `tkeep` is what delivery means, and packet §2
anticipates it), and the mutant is *silent* on lane-4-start frames terminating in
lanes 1-7, because at a lane-4 start the frame's four-octet realignment offset
cancels the four FCS octets exactly and the two derivations genuinely agree
there. A one-sentence intent hid a probe that speaks at one start lane and at one
terminate lane of the other; adjudicating it as five-of-five without that fact
would over-credit the campaign.

M4 (word bound reduced by one). M03 has no word counter and no word constant: the
190-word figure is a consequence of the 1518-octet cap. 1514 delivered octets is
189 full words plus two, and 1512 is 189 exactly, so both 1513 and 1514 need the
190th word and the *word* bound falls by one iff the *octet* cap falls by two. I
rejected the literal "constant minus one" (1517), which leaves 1513 delivered and
does not move the bound the intent names at all. Where the new boundary lands is
stated exactly in the report, because the packet says the position matters to
adjudication.

M5 (BUG-0001 restored). Reverted rather than re-derived, as the packet prefers,
and the reverted hunk is quoted from `git show 0b64b68`. I re-derived the
`max(0, k - 4)` invariant from the RTL first and only then compared it with the
packet's statement — four reachable shapes at the two start lanes, all four
giving exactly that excess — so the revert is justified by the mechanism and not
merely by provenance.

ON MY OWN BLINDING. The symmetry packet §1 names (I am to M03's bench what
dv_lead is to M03's RTL) is not enforceable by any tool in this environment, so
the only thing I can offer is a complete `Inputs` section and a deliberately
over-wide abstention: I stayed out of BUG-0001 and out of dv_lead's journal even
though nothing barred either, because each would have told me what the bench
looks at. I also did not compile, because I cannot (ADR-0005 — the `fpga` switch
holds dune and nothing else), and I did not simulate, because seeing a result
before all five diffs existed is the one thing that voids the campaign.
### Actions
Authored five mutation diffs against `libs/hardcaml_ethernet/src/xgmii_rx_64.ml`
at 6bd7e5a and wrote six files under `docs/reports/audit/WO-0039-mutations/`
(M1-M5.diff plus README.md carrying, per mutation, the intent as understood, the
site, the diff, the fidelity argument, the compile-confidence reasoning and the
disclosures). Mutants were produced by an exact-string substitution script in my
scratchpad that aborts unless each pattern matches exactly once in the pristine
source; the diffs were generated from the results, not hand-written, and the
README's inlined copies were injected from the `.diff` files and then verified
byte-equal to them. Nothing outside `docs/reports/audit/` was written: `libs/`
and `test/` are untouched (`git diff --stat -- libs/ test/` is empty) and I ran
no `git commit` or `git push` (PROTOCOL §2). I applied no diff to the repository
working tree — the apply checks ran against a scratch copy of the frozen blob.
### Evidence
All commands below are runnable from a checkout at 0d231ee; none of them is a
build, and per ADR-0005 none is offered as gate evidence.

1. Base identity. `git show 6bd7e5a:libs/hardcaml_ethernet/src/xgmii_rx_64.ml | sha256sum`
   → `3d87515a843d98d7d5bd6692a9d19cdbe2b0dee4e430c88f871a2d4887f5be92`, 772
   lines, byte-identical to the working tree copy; `git diff --stat 6bd7e5a HEAD -- libs/`
   → empty output.
2. Apply-clean. For each of M1-M5, against a fresh copy of that blob:
   `git apply --check --verbose <M>.diff` → `Checking patch
   libs/hardcaml_ethernet/src/xgmii_rx_64.ml...` and exit 0 for all five; each was
   then applied and the result compared with the mutant source it was generated
   from (`diff -q` silent, all five). Each patch names exactly one `+++` path.
   Changed lines (± , marker comments included): M1 22, M2 5, M3 24, M4 4, M5 7.
3. Syntax, with a proof the instrument is not vacuous.
   `ocamlc -stop-after parsing -c <file>` (system OCaml 4.14.1) → exit 0 for the
   pristine control and for all five mutants. Two negative controls — an
   unbalanced parenthesis in M5's `have_word`, a dropped `in` after M3's
   `sel_cov` — both exit 2 with a located error. This checks syntax only: it does
   no type checking, and it needs no `ppx_hardcaml` because `[@@deriving
   hardcaml]` is a well-formed attribute at parse time. It is not a build.
4. M5's provenance. With comments and blank lines stripped, the M5 mutant source
   is line-for-line identical to
   `git show 0b64b68^:libs/hardcaml_ethernet/src/xgmii_rx_64.ml` (0b64b68^ =
   47fcfda) — the tree BUG-0001 was raised against, whose defect was found by
   test results and therefore by a successful build.
5. Write-scope. `git status --porcelain` at the end of this work shows exactly
   one line, `?? docs/reports/audit/WO-0039-mutations/`.
### Outcome
DoD met against packet §3 for all five mutations: diff in full, file and function
touched, a fidelity argument in terms of mechanism, and — where a faithful
minimal diff was not achievable — the divergence said plainly rather than
substituted. Three such statements exist (M1's strobe reading, M3's unavoidable
delivered-octet change and its silence at most lane-4 starts, M4's two-octet move
of a constant to obtain a one-word move of a bound). Packet §3 also asks for a
scope statement and an explicit line confirming the five bars: both are §1 of the
README, and all five bars were honoured. No compile-only repair was needed under
bar 5, none having been possible to detect without a build. Handoff: the six
files to the orchestrator for commit, and then for transient application per
packet §4 — one throwaway branch per mutation, parent 6bd7e5a, exactly one diff,
never merged, deleted after its run. Mutated RTL must not enter history
(PROTOCOL §10); every hunk carries an `MN MUTATION (WO-0039)` marker comment so
that a leak is greppable, and checking mutation-window commits for those markers
is my own follow-up duty (charter §9).
### Open-questions
1. M1's strobes. I delayed them with the stream on §9's pin. If dv_lead intended
   the rx stream alone to move, M1 is a different defect and must be re-seeded,
   not reinterpreted after its result — bar 5 cuts both ways and I will hold to
   it.
2. M3 is narrower than its one-sentence intent suggests (silent at lane-4 starts
   terminating in lanes 1-7, for a reason intrinsic to the described defect). A
   PASS on M3 should be read as covering the lane-0 case and one lane-4 case, not
   the class.
3. M4 moves the octet constant by two to move the word bound by one. If the
   intent was the octet constant minus one, the bound does not move and the
   mutation is a different one.
4. A campaign-level point I owe the record even though it is dv_lead's call: this
   packet's pass criterion 2 (red in the rows named in advance) makes a mutation
   that reddens an unnamed row a finding rather than a pass. Two of my
   disclosures above bear directly on that adjudication, and both were written
   before any run, which is the only time they can be worth anything.
5. Whether any of the five compiles is unknown to me and unknowable here
   (ADR-0005). A build failure returns to me under bar 5 for a compile-only
   repair; I will change nothing else if that happens.
### Files-in-this-commit
- docs/reports/audit/WO-0039-mutations/README.md
- docs/reports/audit/WO-0039-mutations/M1.diff
- docs/reports/audit/WO-0039-mutations/M2.diff
- docs/reports/audit/WO-0039-mutations/M3.diff
- docs/reports/audit/WO-0039-mutations/M4.diff
- docs/reports/audit/WO-0039-mutations/M5.diff

## [J-auditor-0005] 2026-08-03T06:02:03Z | task:WO-0041 | Family-D seeding: five FCS-path mutations authored blind against 447d11c, with the compile-safety form disclosed and D-M3's floor decided against the literal reading

### Trigger
Orchestrator spawn on WO-0041 (`agents/handoffs/WO-0041_family-d-mutation-campaign.md`,
committed at 06007a3) — dv_lead's packet to me, relayed §§1-6 only, its sealed
companion withheld. Same standing as WO-0039: I am the campaign's no-stake third
party because I authored neither M03's RTL nor any part of its bench, and the
subject under test is **not M03** but family D of `test/xgmii_rx_64/**` and
whether it has teeth. Chartered work (charter §3, systematic mutation testing) at
the PROTOCOL §10 sequencing point. My duty is seeding only: I do not run the
diffs and I do not see their results (packet §3, bar 10 made structural).

### Inputs
This section is the campaign's enforcement mechanism and not a formality —
packet §0 says the blinding has no script behind it and that my disclosure is the
whole of it. The committed long form, with extents, is §1.5 of
`docs/reports/audit/WO-0041-mutations/README.md`; this is the same list.

Read in full: `agents/charters/auditor.md`; `agents/PROTOCOL.md`;
`agents/handoffs/WO-0041_family-d-mutation-campaign.md` (at 06007a3);
`docs/specs/modules/xgmii_rx_64.md` (SPEC-M03, all 949 lines, in three reads);
`libs/hardcaml_ethernet/src/xgmii_rx_64.ml` at 447d11c (blob
81cd9ed7fc64e6265c53117f251ef948f24e3b00, sha256
3d87515a843d98d7d5bd6692a9d19cdbe2b0dee4e430c88f871a2d4887f5be92, extracted with
`git show` into the scratchpad — the working tree's copy was never touched);
`libs/hardcaml_ethernet/src/xgmii_rx_64.mli`;
`libs/hardcaml_ethernet/src/dune`, `dune-project`, `.ocamlformat`;
`docs/reports/audit/WO-0039-mutations/M3.diff` (my own prior artifact).
Partial: `docs/adr/ADR-0005-build-environment.md` lines 1-60;
`docs/reports/audit/WO-0039-mutations/README.md` lines 1-91 (my own committed
report, read for the diff format and for the prior-exposure record below);
`.github/workflows/build.yml` grep hits only, lines 28 and 41, from one grep for
`fmt|dune build|runtest` establishing that no format check gates CI;
`agents/journals/claude_auditor_agent.md` tail and entry-header grep, for the
next id and the grammar — read only, never modified above EOF. Git metadata only
(subjects, names, counts, hashes — no `git show` of any commit's content):
`git log --oneline -12`; `git log --oneline --name-only -1 06007a3`; three
path-scoped `git log --oneline` calls; `git show 447d11c --stat`;
`git diff --stat 447d11c HEAD -- libs/`; `git diff --stat 6bd7e5a 447d11c --
libs/`; `git rev-parse` and `sha256sum` on the base blob. Directory listings
only: `libs/hardcaml_ethernet/src/`, `docs/reports/audit/` and its
`WO-0039-mutations/`, `.github/workflows/`, the repository root, and the shared
scratchpad.

NOT read, and the list is the point. Packet §1's eight read bars, all honoured:
nothing under `test/xgmii_rx_64/**`, in fact no file under `test/` at all, of any
name, at any SHA; not `test/attack_plans/AP-xgmii_rx_64.md` nor anything else
under `test/attack_plans/`; not `agents/handoffs/WO-0040_tb-m03-family-d-fcs.md`,
so I have not seen the published D-M1..D-M4 row table that §0 warns me of and did
not go looking for it; not `agents/handoffs/WO-0039_m03-mutation-campaign.md` in
this session; neither sealed-predictions file, of which I know only that the
WO-0041 one exists and its path, from a `--name-only` log that prints names and
no content; not `agents/journals/claude_dv_lead_agent.md`, whole file, and I
asked for no extraction because nothing here needed one; not
`agents/journals/workers/claude_tb_writer_agent.md`. Beyond the bars I also
stayed out of `crc32_eth.ml` (WO-0039 needed M02's value convention; no family-D
intent touches how the CRC is computed, only what is done with its result), every
`BUG-`/`SO-`/`RV-` packet, `tasks/BOARD.md`, and every other agent's journal.

**Prior exposure, items 3-8, stated precisely because the packet asks.** I recall
nothing: PROTOCOL §2 makes agents stateless between spawns and my context for
this task begins with this brief, so "what I recall reading" is, exactly,
nothing. What exists instead is the WO-0039 spawn's own committed disclosure,
§1 of `docs/reports/audit/WO-0039-mutations/README.md` — a file with exactly one
commit, 0556f23, therefore never amended with anything learned later. I read it
in this session deliberately, so that this disclosure is checkable rather than
remembered. It records: `test/**` not read, the attack plan not read, the
WO-0039 sealed file not opened, dv_lead's journal deliberately not read, and a
*complete* read list that contains neither the tb_writer journal nor any WO-0040
artifact. Item 4 is the one real exposure and it is narrower than the brief
allows for: that spawn read the WO-0039 packet **in full at 0d231ee**, and
`RV-0039-VERDICT` was appended to that file at c3a3ffa with its addendum at
fe1a7f6, both **after** 0556f23 — so the text read was the brief and the verdict
was not yet in the file to read. Items 3 and 6 could not have been read because
their files did not exist; and every commit in `git log --oneline -12` whose
subject announces family D (0b90227, 7651ddd, cf77631) is newer than 0556f23, so
no prior spawn of mine could have seen the bench under test even in principle.

**Ambient exposure I disclose because a bar list is a floor**, all three recorded
in README §1.4 for dv_lead to judge rather than me: commit *subject lines* from
`git log` that summarise WO-0039's and WO-0040's outcomes (c3a3ffa, 7fac574,
cf77631, 06007a3) reached me and name no bench unit, no expected value and no
D-M-to-row mapping; one of my three path-scoped logs was on a barred path (the
WO-0039 packet, to date the verdict's arrival for the table above) and printed
subjects and SHAs, not one byte of the file; and the scratchpad this environment
gives me is shared, its listing showing other agents' copies of barred artifacts
(`HEAD_test_m03_a/b/c.ml`, `HEAD_test_m03_structural.ml`, `rv40.md`,
`wo40_final.md`, `wo40_inter.md`), every one of which I left unopened while
working in freshly named files of my own.

### Reasoning
**Sampling frame.** The frame is not mine to choose this time and that is worth
recording, because charter §8 asks a mutation entry why *these* defect classes.
Packet §2 fixes all five intents behaviourally; my discretion is confined to
**site**, **form** and the readings §5 discloses. So the classes I would
otherwise have argued for or rejected are not the question — the question is
whether each intent has a faithful minimal realisation, and the answer for all
five is yes, at one site each.

**Site selection.** The FCS path in this module has exactly three joints, and the
five intents partition across them cleanly, which is itself evidence the packet
was written against the design rather than at it. Joint 1 is `bad_fcs` (base line
471), where the verdict is *formed*: D-M1 and D-M2 force it, D-M3 empties it.
Joint 2 is the closure record's bit 5 and its consumption `sel_bad_fcs` (513,
533), where the verdict *travels*: D-M3's second half rewrites what arrives
there. Joint 3 is the `error_bad_fcs` output field (761), where the verdict is
*reported*: D-M4 moves its cycle, D-M5 severs it. Nothing else in the module
reads or writes an FCS verdict, which is what lets every diff be one or two code
lines and is why I could satisfy the packet's tuser-is-a-disjunction precision by
construction: `abort`'s other four disjuncts are textually untouched in all five,
and no diff forces `tuser`[0] itself to a constant.

**The form of the two forced constants, and why it is not the obvious one.**
D-M1 is written `gnd &: has_fcs &: (crc_final <>: ...)` and D-M2
`has_fcs &: (vdd |: (crc_final <>: ...))`, rather than the bare `gnd` and
`has_fcs`. The circuits are identical; the reason is the build. This repository
has no `env` stanza, so dune's dev-profile defaults apply and warnings 26 and 32
are errors, and `xgmii_rx_64.mli` exports only `I`, `O`, `create` and
`hierarchical`, so `fcs_residue` is orphaned the instant its last use goes and
the library stops compiling. The same reasoning keeps D-M3's `let bad_fcs =
has_fcs in` as an alias instead of deleting the binding. I judged that authoring
a mutation that cannot build — and then spending bar 10's compile-only repair on
it — is worse than three inert tokens a reader might blink at, so I wrote them in
and disclosed them (README §5.1). This is the one place where compile-safety, not
fidelity, chose the text.

**D-M3's floor: where I read the intent rather than transcribing it.** "Form the
verdict by comparing the CRC register at the `tlast` cycle" taken with no
qualification also drops `has_fcs`, and then a **lone** sub-5-octet frame reports
`error_bad_fcs`, breaking §9's ninth ruling. I did not do that, because the
intent's very next sentence — "on a lone frame this is indistinguishable from
correct" — is false under that reading, and a mutation that contradicts its own
stated observable is broken nearby rather than faithful. So the comparison's
*timing* moved and the floor stayed. I record the alternative and offer a sixth
diff on request rather than guess, and I record it **before any run**, which is
the only time such a note is worth anything.

**D-M4: the body over the title.** "One cycle early" is the title; "pulses on the
cycle carrying the frame's terminate character" is the body. §6.1's own drain
derivation makes that gap 1 or 2 cycles at a lane-0 start and 0 or 1 at a lane-4
start, so the two cannot both be the rule. I implemented the body, which means
the move is sometimes two cycles and is **zero** for a lane-4-started frame whose
terminate character lies in lane 0 — a class on which this mutation is invisible
to any bench. That is inherent to the defect as described, not a weakness of the
diff, and it is disclosed now so it cannot be read as an excuse later.

**D-M1's quietness, left alone.** The packet instructs me to expect D-M1 to look
too quiet and not to improve it, and I did not: the only frames whose behaviour
changes are terminate-closed frames of at least 5 received octets whose FCS is
wrong. Its whole point is agreeing with what the suite already asserts, and a
version that reddened more would be a different mutation.

**Why D-M1 and D-M5 are worth having as a pair**, which is the one design remark
I can make without knowing a row: D-M1 removes the mark *and* the report by
killing the verdict; D-M5 keeps the mark and removes only the report. A unit
asserting `tuser`[0] on the `tlast` word and a unit asserting one `error_bad_fcs`
pulse fail in different combinations under the two, and a bench that checks only
one of the two cannot tell them apart. Whether family D separates them is exactly
what the campaign is for and exactly what I must not look up.

**What I did not attempt.** Nothing was unachievable; no intent was substituted,
weakened or widened beyond the two readings above. I ran no test, elaborated no
circuit, and authored all five before any was run — bars 9 and 10 hold with the
compile-only exception unused.

### Actions
Authored five single-file unified diffs against
`libs/hardcaml_ethernet/src/xgmii_rx_64.ml` at 447d11c, one per intent, each hunk
carrying a `D-MN MUTATION (WO-0041)` marker for greppability, and wrote them plus
a README to `docs/reports/audit/WO-0041-mutations/`. The diffs were generated
mechanically — the mutated files were produced by an anchored string-replacement
script that fails hard on a missing or duplicated anchor, and the patches by `git
diff` in a scratch repository — so no context line is transcribed by hand. Staged
nothing outside `docs/reports/audit/**` and this journal (charter §5, PROTOCOL
§6); ran no git command that writes; never modified the working tree's `libs/`.

### Evidence
All checks below run in the scratchpad against `git show
447d11c:libs/hardcaml_ethernet/src/xgmii_rx_64.ml`, whose sha256 is
3d87515a843d98d7d5bd6692a9d19cdbe2b0dee4e430c88f871a2d4887f5be92; the base blob
is 81cd9ed7fc64e6265c53117f251ef948f24e3b00 and each diff's own `index 81cd9ed..`
line names it, so `git apply --3way` verifies the base and not merely the
context. `git diff --stat 6bd7e5a 447d11c -- libs/` is **empty**, so this file is
byte-identical to WO-0039's base.

1. `git apply --check` from a pristine scratch copy: **5/5 exit 0**, run twice —
   once on the working copies and once on the delivered files under
   `docs/reports/audit/WO-0041-mutations/`. `grep -c '^diff --git'` is 1 for each,
   so every diff touches exactly one file and it is the RTL file the packet
   names.
2. Apply / reverse-apply round trip for all five; the scratch base file's sha256
   is unchanged afterwards, so each diff is exactly invertible against this base
   — which is what makes the orchestrator's apply-transiently-revert-fully
   procedure safe (PROTOCOL §10).
3. Parse-only syntax check with the system compiler (ocamlc 4.14.1, no Hardcaml
   in this container): `ocamlc -stop-after parsing -c` returns **rc=0** for the
   base and all five mutated files, and **rc=2** for a deliberately broken
   negative control (`let bad_fcs = = has_fcs ...`) included because a check that
   cannot fail is not a check. This lexes and parses only — no typecheck, no ppx,
   no elaboration. **It does not establish that any mutant compiles**, and per
   ADR-0005 nothing local could: CI is the authoritative build environment.
4. Orphaned-binding count, comments stripped, definition + uses per identifier:
   `fcs_residue` 2/2/2/2/2, `has_fcs` 2, `crc_final` 3 (2 in D-M3), `bad_fcs` 2
   (3 in D-M4), `sel_bad_fcs` 3 (2 in D-M4 and D-M5, its `abort` use retained),
   `strobe` 6 (5 in D-M4 and D-M5). No entry anywhere is 1, so no mutant orphans
   a binding — the one compile risk I can actually rule out from here.
5. Minimality: code lines changed 1 / 1 / 2 / 1 / 1 for D-M1..D-M5, in 1 / 1 / 2
   / 2 / 2 hunks, with 7 / 6 / 11 / 8 / 6 marker-comment lines added. The widest
   added line is 93 bytes against the file's own existing maximum of 97.
6. The working tree's `libs/` was never modified: `git status --porcelain` in the
   repository reports only the new untracked `docs/reports/audit/WO-0041-mutations/`.

The full command outputs are quoted in §4 of the committed README, which is the
falsifiable form of every claim above.

### Outcome
DoD met against packet §3: five diffs applying cleanly to 447d11c, one file and
one function-site each, a fidelity argument per mutation, no compile-only repair
made or needed, a scope statement with an explicit line on every one of §1's ten
bars, and the prior-exposure disclosure §1's closing paragraph requires. Handoff:
`docs/reports/audit/WO-0041-mutations/` to the orchestrator, which applies each
diff to a throwaway branch parented at 447d11c (packet §4) and relays results to
dv_lead, not to me. `SO-M03` does not issue on family D until all five are
dispositioned; a green run on any of the five is a campaign failure and dv_lead's
finding to write, not mine.

### Open-questions
1. **D-M3's floor.** I kept §9 ruling 9's sub-5-octet gate because the intent's
   own "indistinguishable on a lone frame" sentence is false without it. If
   dv_lead meant the floorless variant, that is a **sixth** diff on request, not
   a revision of D-M3: bar 10 lets me revise nothing after a run, and the request
   is cheapest now, before the first one.
2. **D-M4's invisible class.** A lane-4-started frame whose terminate character
   is in lane 0 has its terminate cycle and its `tlast` cycle on the same cycle,
   so D-M4 is unobservable on it. Inherent to the defect as described; recorded,
   no action requested.
3. **The ambient exposure of README §1.4** — `git log` subject lines summarising
   WO-0039's and WO-0040's outcomes, one path-scoped log on a barred path
   (subjects only), and a shared scratchpad whose listing shows other agents'
   copies of barred artifacts, unopened. If dv_lead judges any of the three to
   compromise the blind, voiding the affected mutations is its call and not mine.
4. **A standing exposure this campaign has surfaced and the next one will
   inherit**: the scratchpad is shared across agents, so barred artifacts are one
   `cat` away from any blinded seeder, and nothing but the seeder's own restraint
   and this paragraph stands between them. That is the honest-enforcement model
   my charter §9 describes working as designed, but it is worth an orchestrator
   decision whether blinded work should get a private scratch directory rather
   than a disclosed one.
5. Whether any of the five compiles is unknown to me and unknowable here
   (ADR-0005). A build failure returns to me under bar 10 for a compile-only
   repair; I will change nothing else if that happens, and I will disclose it.

### Files-in-this-commit
- docs/reports/audit/WO-0041-mutations/D-M1.diff
- docs/reports/audit/WO-0041-mutations/D-M2.diff
- docs/reports/audit/WO-0041-mutations/D-M3.diff
- docs/reports/audit/WO-0041-mutations/D-M4.diff
- docs/reports/audit/WO-0041-mutations/D-M5.diff
- docs/reports/audit/WO-0041-mutations/README.md

## [J-auditor-0006] 2026-08-03T06:51:40Z | task:WO-0042 | Family-D mini-round: D-M6 authored blind against 447d11c — the abort bit latched at the one site that produces it, with the arming reading disclosed in advance

### Trigger
Orchestrator spawn on WO-0042
(`agents/handoffs/WO-0042_family-d-m6-mini-round.md`, committed at `fbd4ce3`) —
dv_lead's self-contained auditor-facing brief, written as a separate packet
precisely because last round's brief is now barred: the adjudication appended to
`agents/handoffs/WO-0041_family-d-mutation-campaign.md` states this round's
predicted kill in plain words, so a seeder briefed from it would read the answer.
Same standing as WO-0039 and WO-0041: I am the campaign's no-stake third party
because I authored neither M03's RTL nor any part of its bench, and the subject
under test is **not M03** but whether family D's two-frame row has teeth against
the one defect class it still declares and nothing has yet exercised. Chartered
work (charter §3, systematic mutation testing) at the PROTOCOL §10 sequencing
point. Seeding only: I did not run the diff and I have seen no result.

### Inputs
The committed long form, with extents, is §1 of
`docs/reports/audit/WO-0042-mutations/README.md`; this is the same list.

Read in full: `agents/charters/auditor.md`; `agents/PROTOCOL.md`;
`agents/handoffs/WO-0042_family-d-m6-mini-round.md` (at `fbd4ce3`);
`libs/hardcaml_ethernet/src/xgmii_rx_64.ml` at `447d11c` (blob
`81cd9ed7fc64e6265c53117f251ef948f24e3b00`, all 772 lines, extracted with
`git show` into a private scratch subdirectory — the working tree's copy was
never opened and never touched); `docs/reports/audit/WO-0041-mutations/D-M1.diff`
(my own prior artifact, for the index-line and hunk-marker convention); my own
journal — the entry-header grep, the file tail, and the whole of the WO-0041
entry (lines 822–955), which is the documentary basis of the prior-exposure
statement below.

Partial: `docs/specs/modules/xgmii_rx_64.md` — one grep for `tuser` and two
`sed` ranges, lines 705–740 (§9's condition table and closure list) and 780–815
(§9's co-occurrence rulings); `libs/hardcaml_ethernet/src/axi64.ml` lines 1–80
(to establish `user_bits = 1`, i.e. that `tuser`[0] is the whole field);
`libs/hardcaml_ethernet/src/dune`, `dune-project`, `.ocamlformat`. Library
sources outside this repository, read for compile-confidence:
`/root/.opam/fpga/.opam-switch/sources/hardcaml/src/signal_intf.ml:80` (the
`reg_fb` signature) and `.../fifo.ml:313–318` (the library's own 1-bit set/hold
idiom).

Git metadata only, no file content: `git rev-parse HEAD`;
`git log -1 --format='%H %s' 447d11c`; `git rev-parse` on the base blob;
`git diff 447d11c HEAD --stat` on the one RTL path (empty);
`git log --oneline` scoped to `docs/reports/audit/WO-0041-mutations/` (one
commit, `fb49b80`, my own); `git status --porcelain -- docs/reports/audit/`
(empty). Directory listings only: `libs/hardcaml_ethernet/src/`,
`docs/reports/audit/` and its `WO-0041-mutations/`, `rtl_snapshots/`, the
repository root, `_build/default`, and the opam switch's `bin`/`lib`/`sources`.

**Deliberate abstention, a tightening on last round.** WO-0042 sharpens the bar
to *every* git subcommand on a barred path, `log` and `show` included. I ran no
unscoped `git log` at all this round — not even `--oneline -12`, which the
WO-0041 spawn did run and disclosed as ambient exposure — because the WO-0041
adjudication's own commit *subject* could carry a kill result. The only commit
subjects that reached me are `447d11c`'s (the base) and `fb49b80`'s (my own
seeding commit).

NOT read, and the list is the point. All nine bars honoured: nothing under
`test/xgmii_rx_64/**`, in fact no file under `test/` at all, of any name, at any
SHA; not `test/attack_plans/AP-xgmii_rx_64.md` nor anything else under
`test/attack_plans/`; not `agents/handoffs/WO-0040_tb-m03-family-d-fcs.md`; not
`agents/handoffs/WO-0039_m03-mutation-campaign.md`; neither sealed-predictions
file; not `agents/journals/claude_dv_lead_agent.md`, whole file, and I asked for
no extraction through the orchestrator because nothing here needed one; not
`agents/journals/workers/claude_tb_writer_agent.md`; and **not**
`agents/handoffs/WO-0041_family-d-mutation-campaign.md`, which was opened by no
tool and touched by no git subcommand this round. Beyond the bars I also stayed
out of every `BUG-`/`SO-`/`RV-` packet, `tasks/BOARD.md`, `docs/gates/**`, every
other agent's journal, and `crc32_eth.ml` (this intent touches what is done with
a verdict, never how any verdict is computed).

**Prior exposure, items 3–9, on commit-ordering evidence rather than memory.**
PROTOCOL §2 makes agents stateless between spawns and my context for this task
begins with this brief, so "what I recall reading" is exactly nothing and a
memory-based answer would be worthless. What exists instead is committed: the
WO-0041 entry in this journal records its own complete read list — item 9 read in
full at `06007a3`, items 1–8 not read — and its long form is §1.5 of
`docs/reports/audit/WO-0041-mutations/README.md`, a file with **exactly one**
commit (`fb49b80`, by the path-scoped log above) and therefore never amended with
anything learned later; the WO-0039 entry is the corresponding record one round
back. Item 9's exposure is therefore exactly what the brief itself states and
rules acceptable: the WO-0041-era spawn read that packet **before** the
adjudication was appended. I did not verify that ordering with a path-scoped log,
because doing so is now itself barred; it rests on the brief's §0 taken with my
own prior entry. I make no claim about item 9's current content and have no basis
for one.

**Ambient exposure I disclose because a bar list is a floor.** To test whether a
real compile was possible I copied the repository tree (excluding `_build` and
`.git`) into my scratch subdirectory with `tar`, ran
`dune build libs/hardcaml_ethernet` against it, and deleted the copy. **The copy
contained `test/**` and no byte of it entered my context** — `tar` piped to
`tar`, and dune's output names only `libs/hardcaml_ethernet/src/dune` and two
missing libraries. I judged the copy worth making and, having made it, worth
disclosing rather than rationalising; if dv_lead judges the copy itself to breach
bar 1, that finding is dv_lead's to make and I will not argue it down. Second,
`_build/default`'s directory listing shows a `test` entry among its subdirectory
names — a name, no content. Third and by contrast with last round: I worked only
in a freshly created private subdirectory and did **not** list the shared
scratchpad root, which is the practice my own WO-0041 process finding proposed
and the orchestrator accepted, so nothing another agent left there could reach me
even by accident.

### Reasoning
**Sampling frame.** Charter §8 asks a mutation entry why *these* defect classes
and which were rejected. As in WO-0041 the frame is not mine: the packet fixes
the single intent behaviourally, and my discretion is confined to **site**,
**form**, and the one reading §5.1 of the report discloses. So the classes I
would otherwise have argued for are not the question; the question is whether
this intent has a faithful minimal realisation, and the answer is yes, at one
site.

**Site selection, and why it is forced.** I searched the module for every
producer and consumer of `tuser`[0]. There are exactly two: base line 736, where
`abort` is formed as the disjunction of the aged closure record's five condition
bits, and base line 759, the sole assignment of the `tuser` field. Nothing else
in 772 lines reads or writes it — the module is, by its own docstring, the origin
of that bit and inherits none. A latch therefore has one honest home: a register
sitting beside `abort`, feeding line 759 and nothing else. That is why the code
delta is two lines.

**Form: latch the emitted value, not the condition.** The register is
`reg_fb spec ~width:1 ~f:(fun d -> d |: (emit_tlast &: abort))` and the field
becomes `emit_tlast &: (abort |: abort_sticky)`. Latching the *emitted* `tuser`
rather than `abort` is not a choice with two circuits —
`d | (emit_tlast & (abort | d))` reduces to `d | (emit_tlast & abort)` — so the
formulation is free; what is not free is what arms it, below. Two rejected forms,
recorded because a reader will think of them. (a) Latching `abort` itself and
using the latched value *inside* `abort` would have contaminated the disjunction
the packet says must keep contributing exactly as today, and would have leaked
into the strobes through `sel_*`. (b) Registering the `tuser` field and ORing the
register's own output would have moved the bit a cycle, which is a timing change
the packet forbids. The form chosen keeps `abort` textually untouched, adds no
level to any existing path, and is a leaf: one driver, one consumer.

**The precision the packet said mattered most: the strobes.** I treated "a
mutation intent is never a licence to break a second spec rule" as the binding
constraint and verified it mechanically rather than by inspection. `abort_sticky`
occurs exactly twice in comment-stripped code — its definition and its single use
in the `tuser` field — so no strobe, no closure-record bit, no ageing register
and no consumption decision can see it. `strobe`, `q_strobe`, `consume`, `q2` and
all five output strobe expressions are byte-identical to the base. §9's "each
strobe is a per-frame report of that frame's own condition" survives intact, on
the same pinned cycles, and so does REQ-008's no-silent-discard structure. The
payload path is likewise untouched: `tvalid`, `tdata`, `tkeep`, `tstrb`, `tlast`,
`keep_count`, `strip`, the alignment window and the BUG-0001 tail-suppression bit
are all unedited, so delivered octet counts, `tkeep` patterns, `tlast` placement
and ΔC = 3 are as specified.

**The one reading I had to choose, and I chose the quieter one.** The intent says
"once M03 sets it on **some frame's `tlast` word**". I armed the latch from
exactly that event, which means the §0.7 classes that emit no output word at all
— a sub-5-octet runt, `/E/` or `/S/` at or before the first octet, and the
in-word `q2` path — do **not** arm it, though every one of them is an invalid
frame. The wider reading ("the abort *condition* latches") is a strict superset.
I rejected it on two grounds: textually, the intent names `tuser`[0]'s value on a
`tlast` word as both the sticky thing and the setting event, and a frame with no
`tlast` word has no such value; and the packet's own instruction not to
strengthen the defect to make it louder makes a superset reading the wrong side
of the line. This is the disclosure that matters for pass criterion 2, and I made
it **before** any result exists: if dv_lead's sealed prediction arms the latch
with a frame that emits no output word, D-M6 is silent where the wider reading
would speak and the round would go green for a reason that is mine rather than
the bench's. I cannot check which reading the prediction assumes — the bench and
every prediction file are barred — so I flagged it in advance and offered the
one-line alternative as a separate diff, authorable before any result reaches me.

**Compile-confidence had to be argued, not built.** The dependencies are absent
from this container's opam switch and the *unmutated* base fails identically, so
"it compiles" is a claim I cannot demonstrate here. I made it falsifiable instead:
the `reg_fb` signature quoted from the pinned Hardcaml source, the same call shape
already present at base line 665 and in Hardcaml's own `fifo.ml`, a parse check
with two negative controls one of which targets the added line specifically, and
a mechanical orphaned-bindings scan — which matters because last round's WO-0041
diffs had to be written around dune's dev-profile warnings 26/32 being errors.
That hazard does not arise here: nothing loses its last use and the one new
binding is used.

### Actions
Authored one mutation diff, `D-M6.diff`, against
`libs/hardcaml_ethernet/src/xgmii_rx_64.ml` at `447d11c` — one file, one added
binding, one edited expression, 21 insertions / 1 deletion, hunk marker comment
`D-M6 MUTATION (WO-0042)` present at both change sites. Wrote
`docs/reports/audit/WO-0042-mutations/README.md` carrying the intent as
understood, the mechanism, the fidelity argument (explicitly: the strobe paths
were left alone), the arming-reading disclosure, the compile-confidence argument
and the raw self-check output. All working files were created in a private
subdirectory of the scratchpad, never in the shared root; the repository working
tree was modified only under `docs/reports/audit/WO-0042-mutations/`. No git
commit and no git push was run, and no simulation of any kind was run against the
mutated source. Bar 11's compile-only repair was not used: the committed diff is
the diff as first authored.

### Evidence
All commands below were run at `HEAD` = `fbd4ce3` with the base extracted from
`447d11c`; the raw transcripts are §7 of the report.

1. Base pinned and reproduced independently — the base file committed into a
   throwaway scratch repository re-hashes to
   `git rev-parse HEAD:libs/hardcaml_ethernet/src/xgmii_rx_64.ml` =
   `81cd9ed7fc64e6265c53117f251ef948f24e3b00`, the blob the diff's index line
   names; and `git diff 447d11c HEAD -- <that path>` is empty.
2. Applies cleanly to a pristine `447d11c` (`git archive` + `tar -x`):
   `git apply --check -v ../D-M6.diff` → `Checking patch
   libs/hardcaml_ethernet/src/xgmii_rx_64.ml...`, exit 0; `git apply --stat` →
   `1 file changed, 21 insertions(+), 1 deletion(-)`.
3. Round-trip identity: after `git apply`, `git hash-object` on the patched file
   is `2f9c3a199f63c5d65ca606d85905272d0fc66deb` — the diff's post-image index —
   and `sha1sum` equals the file I authored
   (`214f1eb2780e970950f9ab35aff891646dbd7320`, both copies). `git apply -R`
   restores blob `81cd9ed7fc64e6265c53117f251ef948f24e3b00` exactly.
4. Single file: `grep -c '^diff --git' D-M6.diff` → `1`.
5. Parse check: `ocamlc -stop-after parsing -c` (OCaml 4.14.1) exits 0 on both
   base and mutated sources. Negative control 1 (unterminated comment appended to
   the mutated file) → `Error: Comment not terminated`, exit 2. Negative control
   2 (one `)` dropped from the added `abort_sticky` line) → `line 756 … Error:
   Syntax error: ')' expected`, exit 2 — which is what proves the check reads the
   mutated line rather than merely the file.
6. Orphaned-bindings scan (comments stripped, so a name surviving only in
   documentation still counts as an orphan): base `135 distinct let/and
   bindings; orphans: 0`; mutated `136 … orphans: 0`. Targeted census in
   comment-stripped mutated code: `abort_sticky` 2 (one definition, one use),
   `abort` 3, `emit_tlast` 6, `consume` 5, `strobe` 6, `q_strobe` 4,
   `sel_bad_fcs` 3, `sel_runt` 3, `sel_error` 3, `sel_start` 3, `sel_oversize` 4.
   `abort_sticky` occurs 0 times in the base file.
7. Minimality: with comments and blank lines stripped from both files the delta
   is exactly two lines — the added `abort_sticky` binding and the changed
   `tuser` field. Every strobe expression, `consume`, `tvalid`, `tkeep`, `tlast`
   and `tdata` are unchanged.
8. Compile-check unavailable, and it is the environment: `dune build
   libs/hardcaml_ethernet` on an **unmutated** scratch copy fails with `Error:
   Library "ppx_hardcaml" not found.` and `Error: Library "hardcaml_axi" not
   found.`; `~/.opam/fpga/lib/` holds only `dune`, `stublibs`, `toplevel`. The
   `reg_fb` signature relied on is
   `val reg_fb : ?enable:t -> Reg_spec.t -> width:int -> f:(t -> t) -> t`
   (`/root/.opam/fpga/.opam-switch/sources/hardcaml/src/signal_intf.ml:80`).

### Outcome
DoD met against WO-0042 §3 and the spawn's five items: one diff authored before
any run, in unified format with the index line pinning blob `81cd9ed`; the diff
and a README committed to `docs/reports/audit/WO-0042-mutations/` and nowhere
else; the WO-0041 self-check set re-run and recorded raw; this journal entry
appended; no git commit, no git push. Handoff: the two files under
`docs/reports/audit/WO-0042-mutations/`, to the orchestrator for commit and for
relay to dv_lead. I remain blind to the result and ask to stay that way until
the round is adjudicated.

### Open-questions
1. **The arming reading (report §5.1).** D-M6 arms the latch only on a frame that
   emits a `tlast` word. If dv_lead's sealed prediction arms it with an invalid
   frame that emits **no** output word — a sub-5-octet runt, or `/E/`/`/S/` at or
   before the first octet — this diff is silent where the wider reading would
   speak, and a green run would be attributable to my reading rather than to the
   bench. The alternative is one line; I will author it as a separate diff on
   request, before any result is disclosed to me.
2. **Snapshot collateral.** `rtl_snapshots/xgmii_rx_64.v` exists and any RTL
   change alters generated Verilog, so a byte-comparison unit — if one exists —
   would redden under every mutation in every round for structural reasons.
   `test/**` is barred, so I cannot check. Flagged so it is not mistaken for an
   unnamed unit reddening under pass criterion 2.
3. **The scratch tree copy.** Disclosed in Inputs. It placed barred paths in my
   scratch directory without any of their content entering my context. Whether
   that breaches bar 1 is dv_lead's judgement, not mine.
4. **Compile-confidence is argued, not demonstrated**, because the toolchain is
   absent from this container. If the diff fails to compile, bar 11's
   compile-only repair applies: I will change nothing else and will disclose it.

### Files-in-this-commit
- docs/reports/audit/WO-0042-mutations/D-M6.diff
- docs/reports/audit/WO-0042-mutations/README.md

## [J-auditor-0007] 2026-08-03T13:43:18Z | task:WO-0045 | Family-E campaign seeded: five abort-path mutations authored blind against bc565a6 under an allowlist, with E-c2's uncovered half and the absent toolchain both disclosed rather than papered over

### Trigger
Orchestrator spawn on WO-0045
(`agents/handoffs/WO-0045_family-e-mutation-campaign.md`, read at `520ab9b`) —
dv_lead's auditor-facing brief. Same chartered duty and same no-stake standing
as WO-0039, WO-0041 and WO-0042: I authored neither M03's RTL nor any part of
its bench, and the subject under test is **not M03** but whether family E of
`test/xgmii_rx_64/**` has teeth against the five abort-path defect classes §2
names. Chartered work under charter §3's systematic-mutation clause, at the
PROTOCOL §10 sequencing point. Seeding only: I did not run any diff and I have
seen no result.

### Inputs
The committed long form, with extents, is §1 of
`docs/reports/audit/WO-0045-mutations/README.md`; this is the same list.

**The read rule this round is an allowlist, not a bar list.** WO-0045 §1
replaces the previous campaigns' growing deny-list with five permitted path
sets — this packet, `docs/specs/**`, `docs/adr/**`, `libs/**`,
`docs/reports/audit/**` — and declares everything else out of bounds by
construction. My spawn brief adds that `agents/PROTOCOL.md` is off-list for this
campaign and that the brief plus my charter supply the process in its place.

Read in full: `agents/charters/auditor.md`;
`agents/handoffs/WO-0045_family-e-mutation-campaign.md` at `520ab9b`;
`docs/specs/modules/xgmii_rx_64.md` at `bc565a6` (949 lines);
`libs/hardcaml_ethernet/src/xgmii_rx_64.ml` at `bc565a6` (772 lines, blob
`81cd9ed7fc64e6265c53117f251ef948f24e3b00`, sha256 `3d87515a…`, extracted with
`git show` / `git archive` into a private scratch subdirectory — the working
tree's copy was never opened and never modified);
`docs/reports/audit/WO-0041-mutations/README.md` (my own prior artifact, for the
section structure and the index-line and hunk-marker conventions).

Partial: `docs/specs/requirements.md` at `bc565a6` — §0.6 and §0.7 (lines
240–324), §2's REQ-101 … REQ-113 table (lines 410–435), and one grep for the REQ
ids the packet's spec basis names.

**Deliberate abstention inside the allowlist**: `docs/adr/**` was permitted and
**not opened**. ADR-0006, ADR-0007, ADR-0013 and ADR-0014 are quoted at the
points that matter inside SPEC-M03 itself, and no family-E intent turned on a
decision record I had not already got from the spec. Recorded because Inputs is
meant to be what I read, not what I was allowed to read.

Git metadata only, no file content: `git rev-parse` on the base blob at
`bc565a6` and at `447d11c` (equal — the file has not moved across four
campaigns); `git diff --stat bc565a6 1e77706 -- libs/` (empty, which re-derives
the packet header's criterion-3 claim rather than taking it on trust);
`git ls-tree -r --name-only bc565a6 -- libs` and `-- docs/reports/audit`;
`git hash-object` on the five mutants. **No unscoped `git log` was run at all**,
and no git subcommand of any kind was aimed at a path outside the allowlist
(bar 10) — I ran no `--format=%s` this round, so no commit subject reached me.

My own journal: the orchestrator's minimal exception for the append. Extent
exactly — one `grep -n 'J-auditor-[0-9]' | tail -1`, whose output as it reached
me was the single line number `1082`, and one `sed -n '1080,$p'`, which
displayed the last entry (`J-auditor-0006`) and two lines above its header.
Lines 1–1079 were not displayed.

Directory listings only: `libs/hardcaml_ethernet/src/`, `docs/reports/audit/`,
the scratch tree's own top level, and the opam switch's `bin` / `lib`.

**Not read, positively**: all of `test/**` — no file, no name, no SHA, in this
session; the sealed companion
`WO-0045_family-e-mutation-campaign-SEALED-predictions.md`; the WO-0043 packet,
whose verdict §1 warns describes `test_m03_e.ml` line by line; every other
agent's journal; `agents/PROTOCOL.md` this round; and — a change from WO-0042,
where I did read them — `.ocamlformat`, `dune-project` and
`libs/hardcaml_ethernet/src/dune`, all three of which are outside this
campaign's allowlist or, in the dune file's case, unnecessary once the build's
own error text named the missing libraries.

**Prior-spawn exposure**, which §1's last paragraph says is expected and not a
disqualification: the WO-0039/0041/0042 packets, PROTOCOL, and my own journal in
full. The material question is narrower and I answer it directly — **I have
never read `test_m03_e.ml` or any part of family E, at any SHA, in any spawn**,
nor `AP-xgmii_rx_64.md`. What I carry about M03's bench is family D's published
mutation → row table (WO-0040 §9, the leak this packet exists to correct) and
the D-family verdicts: all of it about the FCS path, none about the abort path.

**One incidental exposure, disclosed rather than glossed.** My first
`git archive | tar -x` copy excluded only the trees I had reasoned about in
advance; a `find -maxdepth 1 -type d` over that copy printed the names
`.claude .github bin libs scripts site tasks`. I read no content from any of
them, rebuilt the copy immediately restricted to `libs/` plus root-level files,
and the second listing additionally showed the root file names. Names only
reached me; bar 9's `tar --exclude` was the mechanism in both passes, and a
probe loop over `test agents docs tools rtl_snapshots` printed `absent:` for all
five before any build was attempted.

### Reasoning
**Sampling frame.** This is a seeding work order, not a sampling audit: the
frame is fixed by §2, which names five defect classes and leaves me no
discretion over which to seed. What discretion I had was *where in the module to
inject each*, and that is what the reasoning below records. I deliberately did
not go looking for a sixth class, did not red-team beyond §2, and formed no view
about which bench row should die — the campaign's blinding is the point of the
round and the sealed predictions are dv_lead's.

**Where each defect lives, and why there.** M03 concentrates the abort path in
four places, and each intent has exactly one natural site. (1) `strip` is the
module's single FCS-removal control, read by `keep_count`, by `emit_last_a`'s
guard and by the straddle logic; adding `sel_error` to the disjunction that
raises it recruits the *whole* removal mechanism onto the REQ-105 path, which is
what "as though the abort path had an FCS to strip" means, rather than
subtracting four octets by hand. (2) The "no output word" property of a
zero-delivered abort is enforced twice over — `have_word` needs `pc <> 0` and
`emit_last_a` needs `pc >: strip` — so no existing conjunct can be weakened
without also moving §9's sixth row, which belongs to a different intent; I added
a disjunct instead, gated on `sel_is_r2`, which is the module's own name for
§9's no-output-word report cycle. (3) `error_bad_frame` has two source paths and
the intent is a statement about the strobe, so both move: `strobe sel_error` to
the combinational `a_close_error`, and `q_strobe 0` to the un-delayed
`inword_now`. (4) The frame-open test is one conjunct, `a_open`, inside
`a_char_acts`; E-c4 deletes it from that one closure and nothing else. (5) E-c5
is one identifier.

**What I refused to do, in each case, and why.** For E-c3 I refused to move only
the epoch-A path: the in-word `q2` path is §9's second pin for the frames that
use it, and leaving it in place would make the strobe half-defective and the
mutation partly a no-op. For E-c4 I refused to bolt a pulse onto the output
field — a bare `|: (any lanes.is_error &: ~:a_open)` would report on the
character's own cycle and thereby import E-c3's defect, making two of the five
partly indistinguishable; injecting at the closure keeps the report on §9's own
no-output-word pin, which is what "reported as though it had aborted something"
means. Also for E-c4 I **kept** the `~:a_close_oversize` conjunct: dropping it
would break REQ-108 and C-12 on the way to a REQ-105 defect, which the packet's
standing clause forbids. For E-c5 I refused to strengthen it, as §2 asks in
terms.

**The one intent I could not seed whole.** E-c2's class has two structurally
different halves. A frame opened and closed inside one input word — at a lane-0
start, where the whole preamble lies in the start word, that is where every
preamble-position `/E/` falls — is reported through `q2`, three bits through two
registers, with **no payload datapath at all**: nothing there decides to emit a
word, because it never had coverage, alignment or a `tkeep`. Seeding it means
constructing an output-word path that does not exist, which is neither minimal
nor the natural implementation. I seeded the epoch-A half — an `/E/` in a
preamble position of the word after a lane-4 start, and an `/E/` at the frame's
own first-octet position at both start lanes — and said so plainly rather than
substituting a different defect, which §2 asks for in terms.

**Fidelity checks I ran in my head and then wrote down.** For each mutation I
enumerated the frame classes the intent says are unaffected and traced the
mutated expression through them: for E-c1, that terminate, runt and oversize
dispositions are untouched because the three closure bits are mutually exclusive
and `a_close_runt` implies `a_close_terminate`; for E-c2, that a frame reaching
`r2` with `pc <> 0` already satisfies the original conjunction so the disjunct
is a no-op there, and that `consume` — and therefore the strobe cycle — is
unchanged; for E-c3, that the pulse count is preserved and only the cycle moves,
never by zero; for E-c4, that `Preamble` and `Frame` are bit-identical to the
base and that neither the `Idle` nor the `Discard` arm of the FSM reads
`a_close_char`; for E-c5, that `sel_error` stays live in `abort` so `tuser`[0]
still marks. §3 of the README carries each argument in full.

**Consequences I accepted rather than engineered away.** E-c1 recruits the
word-drop behaviour of a genuine FCS strip: a final aligned word of ≤ 4 octets
is suppressed with its `tlast`, and a straddling case moves the `tlast` back a
word. Both follow from the single injected token and I did not add guards to
prevent them — that would be a second, non-minimal edit and would make the
mutant behave like no implementation anyone would write.

### Actions
1. Read the charter, the packet at `520ab9b`, SPEC-M03 and the requirements
   sections its spec basis names, and the design file at `bc565a6`.
2. Created a mode-0700 private scratch subdirectory (bar 8) and extracted the
   base tree into it with `git archive | tar --exclude` (bar 9), twice — the
   second pass restricted to `libs/` plus root-level files.
3. Authored **all five** diffs in one generator pass, before any was run (bar
   6), each as anchor-asserted literal replacements against the `bc565a6` text
   so a silent mis-apply is impossible.
4. Ran the self-check battery of §4 of the README: tree-copy guard, generation
   anchors, `git apply --check` plus real application and byte-comparison,
   single-file and index-line pinning, minimality counts, parse check with four
   negative controls, orphaned-bindings check, identifier census and scope
   order, width and whitespace, marker presence.
5. Wrote `docs/reports/audit/WO-0045-mutations/{E-c1..E-c5}.diff` and
   `README.md`, the latter generated with the diffs spliced from the artifacts
   and verified byte-identical to them.
6. Revised no diff after any result, there being none (bar 7); made no
   compile-only repair, because no diff has been compiled — see Evidence.
7. Wrote nothing outside `docs/reports/audit/WO-0045-mutations/` and this
   journal append. Ran no `git commit` and no `git push`.

### Evidence
Base, re-derived rather than assumed:
`git rev-parse bc565a6:libs/hardcaml_ethernet/src/xgmii_rx_64.ml` →
`81cd9ed7fc64e6265c53117f251ef948f24e3b00`; the same command at `447d11c`
returns the same blob, so this file is byte-identical across WO-0039, WO-0041,
WO-0042 and WO-0045. `git show bc565a6:… | sha256sum` →
`3d87515a843d98d7d5bd6692a9d19cdbe2b0dee4e430c88f871a2d4887f5be92`, 772 lines.
`git diff --stat bc565a6 1e77706 -- libs/` → **empty**.

Tree-copy guard: the probe loop over `test agents docs tools rtl_snapshots`
printed `absent:` for all five; final retained content of the scratch tree was
`libs/`, `.gitignore`, `.ocamlformat`, `ORG_CHART.md`, `README.md`,
`agentic_fpga.opam`, `dune-project`, of which only `libs/**` was ever opened.

Generation: `python3 gen.py` →
`E-c1: base=81cd9ed7fc64 new=afefecb886a4 edits=1`,
`E-c2: … new=d01674a40b9d edits=1`, `E-c3: … new=df865207e2a4 edits=2`,
`E-c4: … new=a1236bd56c68 edits=1`, `E-c5: … new=a8d301f13d36 edits=1`.

`git apply --check --verbose` from a pristine `bc565a6` copy: all five print
`Checking patch libs/hardcaml_ethernet/src/xgmii_rx_64.ml...` and nothing else.
Each patch was then applied for real to a fresh pristine copy and `cmp`-ed
against the generated file: **byte-identical in all five cases**. Each diff has
exactly one `diff --git` header and one `index 81cd9ed7fc64…..<post> 100644`
line.

Minimality: hunks/±lines — E-c1 1/−1+6, E-c2 1/−1+7, E-c3 2/−8+10, E-c4 1/−1+4,
E-c5 1/−1+4, of which 3, 4, 4, 3 and 3 added lines respectively are the marker
comment. E-c4's and E-c5's entire code delta is one line replaced by one line.

Parse check, **with negative controls**: `ocamlc -stop-after parsing -c` (OCaml
4.14.1) accepts the pristine file and all five mutants. Four deliberately broken
variants — a dropped paren in E-c2's disjunct, a dropped `in` in E-c1's
rewrapped `let`, a stray `;;` in E-c5's field, a dropped paren in E-c3's `q2` —
were all **rejected** (`Syntax error: ')' expected` ×2, `Syntax error` ×2), so
the check has teeth.

Orphaned bindings, over comment-stripped text: 135 base bindings; E-c1/2/4/5 add
none, remove none, and leave **none unused**; E-c3 adds `inword_now`, removes
none, leaves none unused. `strobe`, `q_strobe`, `q2` and `sel_error` all remain
referenced in E-c3 and E-c5, which is where an unused-variable warning was the
likely failure.

Identifier census and scope order: every added code token is either `let`-bound
in the base file, or a library/record name the base file already uses (`mux2`
21×, `of_int` 14×, `zero` 14×, `bit` 39×, `reg` 34×, `any` 24×, `gnd` 2×,
`i.clear` 8×, `error_bad_frame` 3×, `is_error` 7×, `~exists`/`~closing` 3× each),
or `inword_now`. Binding line < use line for all of them: `sel_is_r2` 522,
`sel_valid` 528, `sel_terminate` 529, `sel_error` 530, `sel_oversize` 532;
`a_close_oh` 315, `a_pre_mask` 308, `a_close_oversize` 361 (all < E-c4's 372);
`inword_strobes` 570 < 583; `a_close_error` 372 < 762. No shadowing, no forward
reference.

Width and whitespace: base max line length 97; every mutant 97; zero
trailing-whitespace lines, zero tabs, zero CR in base and mutants alike. Marker
check: E-c3 two hunks two markers, the other four one each.

**Negative evidence, stated as a result rather than omitted.** No mutant has
been type-checked and none could be: this container's opam switch (`fpga`,
`ocaml-system.4.14.1`) has **no Hardcaml packages installed**, and
`dune build libs/` in the scratch tree fails at `Library "ppx_hardcaml" not
found` and `Library "hardcaml_axi" not found` before reaching a line of
`xgmii_rx_64.ml`. `ocamlformat` is likewise absent, and `.ocamlformat` is
outside the allowlist, so formatting is **unverified** — unlike WO-0042, where I
read the margin. Compile-confidence is therefore HIGH on syntax, scope and
unused bindings (all machine-checked above) and ASSERTED on types and widths,
with the argument written out per mutation in README §5.1.

### Outcome
Five diffs and a README committed under
`docs/reports/audit/WO-0045-mutations/`, seeding the family-E campaign against
`bc565a6`. All ten of the packet's rules — five allowlist items, five process
bars — were honoured, with three things disclosed rather than smoothed: the
`find`-listing of top-level directory names during the first tree copy, the
abstention from `docs/adr/**`, and the absent toolchain. Four of the five
intents were seeded whole and minimally. **E-c2 was seeded for one of its two
structural halves only** and the other is named, argued and left undone rather
than substituted for. No diff was run, no result was seen, no revision was made,
and no prediction about which bench unit should redden appears anywhere in this
work order or in my head. `SO-M03` does not issue on family E regardless, per
the packet's own §5.

### Open-questions
1. **E-c2's uncovered half.** Does dv_lead want a sixth diff attacking the
   in-word (`q2`) half of §9 row 3 — necessarily larger, since it must construct
   an output-word path that does not exist — or is the epoch-A half the intended
   target? Routed through the orchestrator; I neither substituted nor widened.
2. **Is `dune build @fmt` inside the campaign's "Build state"?** If so and a
   mutant fails it, the failure belongs to packet §7's compile-only repair
   class, not to the intent. I could not pre-empt it: `ocamlformat` is absent
   and `.ocamlformat` is off-allowlist.
3. **Build-configuration files and the allowlist.** A build needs
   `dune-project` and `libs/**/dune` as tool inputs; the former is off-list. I
   resolved it conservatively (read neither; took the missing-library names from
   the build's own error text), but a future packet saying so explicitly would
   remove the ambiguity.
4. **Compile-confidence is argued, not demonstrated**, for the second campaign
   running, because the toolchain is absent from this container. If any diff
   fails to compile, bar 7's compile-only repair applies: I will change nothing
   else and will disclose it.

### Files-in-this-commit
- docs/reports/audit/WO-0045-mutations/E-c1.diff
- docs/reports/audit/WO-0045-mutations/E-c2.diff
- docs/reports/audit/WO-0045-mutations/E-c3.diff
- docs/reports/audit/WO-0045-mutations/E-c4.diff
- docs/reports/audit/WO-0045-mutations/E-c5.diff
- docs/reports/audit/WO-0045-mutations/README.md

## [J-auditor-0008] 2026-08-03T16:18:13Z | task:WO-0050 | Family-F campaign seeded: eight runt-path mutations authored blind against 616686f, with F-c6's underflow question answered both ways and F-c8's epoch-A half left undone rather than substituted

### Trigger
Orchestrator spawn on WO-0050
(`agents/handoffs/WO-0050_family-f-mutation-campaign.md`, read at `6f385d9`,
blob `aea384a32a32abf96e5cfe0b54576c146cc21064`) — dv_lead's auditor-facing
brief, the fifth seeding work order and the third under an allowlist regime.
Same chartered duty and same no-stake standing as WO-0039, WO-0041, WO-0042 and
WO-0045: I authored neither M03's RTL nor any part of its bench, and the subject
under test is **not M03** but whether family F of `test/xgmii_rx_64/**` and row
M03-E5 have teeth against the eight runt-path defect classes §2 names. Chartered
work under charter §3's systematic-mutation clause, at the PROTOCOL §10
sequencing point. Seeding only: I ran no diff and I have seen no result.

### Inputs
The committed long form, with extents, is §1 of
`docs/reports/audit/WO-0050-mutations/README.md`; this is the same list.

**The read rule is WO-0045's allowlist, standing and now six items.** WO-0050 §1
permits this packet, `docs/specs/**`, `docs/adr/**`, `libs/**`,
`docs/reports/audit/**`, and — item 6, promoted from the WO-0045 addendum —
root-level build configuration. Everything else is out of bounds by
construction, `test/**` and `agents/**` explicitly.

Read in full: `agents/handoffs/WO-0050_family-f-mutation-campaign.md` at
`6f385d9`; `libs/hardcaml_ethernet/src/xgmii_rx_64.ml` at `616686f` (772 lines,
blob `81cd9ed7fc64e6265c53117f251ef948f24e3b00`, sha256 `3d87515a…`, extracted
with `git show` / `git archive` into a private scratch subdirectory — the
working tree's copy was never opened and never modified); `xgmii_rx_64.mli` (45
lines); `libs/hardcaml_ethernet/src/dune`; SPEC-M03 §9 at `616686f` (lines
711–864).

Partial: `docs/specs/modules/xgmii_rx_64.md` §6.1, §6.2 and the head of §6.3
(256–535) and a grep over §10's REQ rows; `docs/specs/requirements.md` §0.3,
§0.6, §0.7 and the REQ-008, REQ-011, REQ-103, REQ-104, REQ-105, REQ-107,
REQ-108 and REQ-901 rows. `dune-project` and `.ocamlformat` at `616686f` under
item 6. My own prior artifacts under `docs/reports/audit/WO-0045-mutations/`
for the diff conventions.

**Deliberate abstention inside the allowlist**: `docs/adr/**` was permitted and
**not opened**, for the second campaign running — ADR-0006, ADR-0007, ADR-0010,
ADR-0013 and ADR-0014 are quoted at the points that matter inside SPEC-M03 and
inside the module's own comments, and no family-F intent turned on a decision
record I had not already got there.

**Two reads outside the allowlist, both directed and both disclosed**:
`agents/charters/auditor.md` in full, and the tail of this journal (final 120
lines, a header grep, and lines 1354–1400 — parts of `J-auditor-0007` only),
both ordered by my spawn message and my charter's mandatory first actions,
both performed **before** the packet was opened. `agents/PROTOCOL.md` was not
read, the same abstention as WO-0045. No other agent's journal, no other
packet, no verdict.

Git metadata only, no content: `rev-parse` on the base blob at `616686f` and
`bc565a6` (equal — the file has not moved across five campaigns), `hash-object`
on the packet at `6f385d9` against the copy I read (equal), `rev-parse HEAD`,
`git status --porcelain`, and a top-level `git ls-tree`. **The last two leaked
path names and are disclosed rather than smoothed**: `status` printed four
modified paths, two under `agents/` and two under `test/cosim/`, none of which I
opened; `ls-tree` printed the repository's top-level entry names, which is how I
identified item 6's build-config siblings. **The sealed predictions file was
never opened, listed, hashed, diffed, grepped or shown at any revision**, and no
`git log` was ever run unscoped.

### Reasoning
Eight intents, eight sites, and the work was mostly in finding the site at which
each intent is one edit and no second rule breaks on the way.

1. **Read the design before the intents could be sited.** Three signals decided
   most of it, and each was checked by census rather than assumed: `sel_terminate`
   has exactly one consumer in the module (`strip`, line 696), `a_close_runt` has
   exactly one (the closure record's `~runt` field), and the `pc >: strip` guard
   is — by the module's own comment — the thing that stops a word made only of FCS
   octets from going out. Those three facts are why **F-c1**, **F-c2/F-c5** and
   **F-c3/F-c6** are each a single-line edit with a bounded blast radius.
2. **F-c1 needed a qualifier the record does not carry, and I found the site
   where it does.** Gating `strip` on the runt bit alone would have emitted a word
   for a sub-five frame — F-c3's defect, seeded twice, confounding the campaign.
   The record's terminate flag is the site where the qualifier is expressible in
   one term because that flag's only consumer *is* the FCS removal.
3. **F-c3 and F-c6 share a site and are separated by one edit — the clamp.** The
   packet's own contrast ("allowed to underflow *rather than being clamped at
   zero*") is what told me they should be, and I chose F-c3's fuller class
   coverage (1 to 4 octets, `tkeep` = 0) over the one-character `>=:` variant that
   reaches only the 4-octet member. Both readings are recorded in README §6.2.
4. **F-c4's pick was made on design grounds and stated**: `error_bad_fcs` is
   suppressed, `error_runt` survives, because the FCS field is already a
   conjunction and the record lists it first. The alternative was equally minimal
   and was not seeded.
5. **F-c6 was a question, and I answered both readings of it** rather than the
   convenient one. The delivered-octet count can underflow and that is seeded;
   the received counter **cannot**, because nothing in this design subtracts from
   it. Saying so is the better answer, per the packet's own instruction.
6. **F-c8 collided with the spec and I preserved the spec.** The no-output-word
   pin has two implementations here; the in-word one is two fixed register stages
   and I removed one, whole. The epoch-A one shares `consume` with the `tlast`
   pin of frames that *do* produce an output word, so displacing it would have
   fired the strobe before the `tlast` of every frame of length 5, 6 or 7 modulo
   8 and taken `tuser`[0] and `strip` with it — a second broken rule on the way
   to the first. Named, argued, left undone.
7. **Verified before delivering, with negative controls at the two checks that
   could be blind**: anchor-uniqueness assertions in the generator, `git apply
   --check` plus real application and byte-comparison, single-file and index-line
   pinning, minimality counts, a comment-stripped code-delta inspection of every
   mutant, a parse check with five deliberately broken variants, a binding census
   for orphans, width and whitespace, marker presence.
8. **Revised no diff after any result**, there being none (bar 8); made no
   compile-only repair, because no diff has been compiled — see Evidence.
9. Wrote nothing outside `docs/reports/audit/WO-0050-mutations/` and this journal
   append. Ran no `git commit` and no `git push`.

**Sampling frame.** The frame was fixed by the packet: eight intents, one module,
one file. I skipped nothing that was in it. Inside the allowlist I skipped
`docs/adr/**` deliberately (above) and read only the spec sections the packet's
own spec basis names, plus §9 in full because five of the eight intents turn on
it.

### Evidence
Base, re-derived rather than assumed:
`git rev-parse 616686f:libs/hardcaml_ethernet/src/xgmii_rx_64.ml` →
`81cd9ed7fc64e6265c53117f251ef948f24e3b00`; the same command at `bc565a6`
returns the same blob, so the file is byte-identical across the family-E and
family-F campaigns. `sha256sum` of the extraction →
`3d87515a843d98d7d5bd6692a9d19cdbe2b0dee4e430c88f871a2d4887f5be92`, 772 lines.
Packet identity: `git hash-object` of the copy I read equals
`git rev-parse 6f385d9:agents/handoffs/WO-0050_family-f-mutation-campaign.md` =
`aea384a32a32abf96e5cfe0b54576c146cc21064`.

Tree-copy guard (bar 10): I did not copy-and-filter. `git archive 616686f libs/`
names the one allowlisted path set, so no barred path was ever materialised;
the scratch tree holds `libs/**`, two extracted spec files, and my own generated
artifacts, and nothing else.

Generation: `python3 gen.py` →
`f-c1: base=81cd9ed7fc64 new=a03ca16cb3bd hunks=1 -1/+6`,
`f-c2: … new=2300f74b57a0 … -1/+6`, `f-c3: … new=7e6ab6d09793 … -2/+7`,
`f-c4: … new=053814486172 … -1/+7`, `f-c5: … new=9f317f2d0570 … -1/+6`,
`f-c6: … new=3da9c0b3dce9 … -1/+7`, `f-c7: … new=0f0d643764d6 … -1/+9`,
`f-c8: … new=0e2f44d0503d … -4/+9`. The generator asserts each anchor occurs
**exactly once** and aborts otherwise, so a silent no-op edit is impossible.

`git apply --check --verbose` from a pristine `616686f` extraction: all eight
print `Checking patch libs/hardcaml_ethernet/src/xgmii_rx_64.ml...` and nothing
else. Each patch was then applied for real to a **fresh** pristine extraction
and `cmp`-ed against the generated file: **byte-identical in all eight cases**.
Each diff has exactly one `diff --git` header and one
`index 81cd9ed7fc64…..<post> 100644` line.

Minimality, with comments stripped: **six of the eight are one line replaced by
one line** (f-c1, f-c2, f-c4, f-c5, f-c6, and f-c7's operand rewrite); f-c3 is
two such lines; f-c8 deletes the inner `reg`/`spec` pair and re-indents the two
lines beneath. Added lines that are marker comment: 5, 5, 5, 6, 5, 6, 7, 7. The
comment-stripped delta of every mutant was computed and inspected and is exactly
the intended edit.

Parse check, **with negative controls**: `ocamlc -stop-after parsing -c` (OCaml
4.14.1) accepts the pristine file and all eight mutants. Five deliberately
broken variants — a dropped paren in f-c1's `~:` argument, a dropped `in` in
f-c5's binding, a dropped paren in f-c7's mask, a stray `;;` after f-c8's `in`,
a dropped paren in f-c3's `min2` application — were all **rejected**
(`This '(' might be unmatched` ×3, `Syntax error` ×2), so the check has teeth.

Binding census over comment-stripped text: 135 base bindings, none unused; every
mutant adds none, removes none and leaves **none unreferenced** — the check that
matters for f-c3 and f-c6, which delete a use of `strip` and of `pc`, both of
which remain referenced at 729/731/734 and 734.

Width and whitespace: every mutant's longest line is 97, which is the **base's
own maximum** from two pre-existing lines (622, 696) that no diff touches; the
longest line any diff adds is 87. Zero trailing-whitespace lines, zero tabs,
zero CR throughout. Exactly one `MUTATION` marker per mutant. The eight diffs
embedded in README §3 were spliced by script and verified byte-identical to the
`.diff` files.

**Negative evidence, stated as a result rather than omitted.** No mutant has been
type-checked and none could be: this container's opam switch (`fpga`,
`ocaml-system.4.14.1`) has **no Hardcaml packages**, and there is no `dune` and
no `ocamlformat` binary at all. Compile-confidence is therefore HIGH on syntax,
scope and unused bindings (machine-checked above) and ASSERTED on types and
widths, with the per-mutation argument written out in README §5.1. Formatting is
**unverified** — and I record the sharper fact that `.ocamlformat` selects a
90-column margin while **the base file already carries two 97-column code
lines**, so I could not establish that `dune build @fmt` is clean at `616686f`
in the first place.

### Outcome
Eight diffs and a README committed under
`docs/reports/audit/WO-0050-mutations/`, seeding the family-F campaign against
`616686f`. All eleven of the packet's rules — six allowlist items, five process
bars — were honoured, with five things disclosed rather than smoothed: the two
directed `agents/**` pre-reads, the two path-name leaks from `git status` and
the top-level `ls-tree`, the reading of `.ocamlformat` as item-6 build
configuration, the absent toolchain, and the base's own unclean margin. Six of
the eight intents were seeded whole and minimally. **F-c3 is seeded for received
lengths 1 to 4 rather than 0 to 4**, the zero-octet frame being unreachable from
that site, and **F-c8 is seeded for the in-word half of §9's no-output-word pin
only**, the epoch-A half being named, argued and left undone rather than
substituted for. The packet's two direct questions are answered in the report:
**F-c4 suppresses `error_bad_fcs`**, and **a faithful underflow is expressible —
on the FCS removal's delivered-octet count, and not on the received counter,
which no path in this design subtracts from**. No diff was run, no result was
seen, no revision was made, and no prediction about which bench unit should
redden appears anywhere in this work order or in my head. `SO-M03` does not
issue on family F regardless, per the packet's own §5.

### Open-questions
1. **F-c8's uncovered half.** Does dv_lead want a ninth diff attacking the
   record-ageing half of the no-output-word pin? It cannot be done without
   disturbing frames that *do* produce an output word — README §3.8 carries the
   argument — so it needs either a wider diff than a mutation should be or a
   redrawn intent. Routed through the orchestrator; I neither substituted nor
   widened.
2. **F-c3 and F-c6 share a site**, separated by one edit (the clamp). If the
   intended F-c3 was the one-character `>:` → `>=:` variant instead, it reaches
   only the 4-octet member of the class; I judged that less faithful and state
   the choice so it can be reversed cheaply.
3. **Is `dune build @fmt` clean at `616686f` at all?** The base carries two
   97-column code lines against a 90-column margin. If it is not clean, a `@fmt`
   failure under any mutation is pre-existing rather than mine, and bar 8's
   compile-only repair clause should not be spent on it.
4. **Compile-confidence is argued, not demonstrated**, for the third campaign
   running, because the toolchain is absent from this container. If any diff
   fails to build, bar 8 applies: I will change nothing else and will disclose
   the repair.
5. **`.ocamlformat` under item 6.** I read it as root-level build configuration,
   since bar 8 puts `dune build @fmt` inside "Build state". Recorded so the
   reading can be overruled rather than discovered.

### Files-in-this-commit
- docs/reports/audit/WO-0050-mutations/f-c1.diff
- docs/reports/audit/WO-0050-mutations/f-c2.diff
- docs/reports/audit/WO-0050-mutations/f-c3.diff
- docs/reports/audit/WO-0050-mutations/f-c4.diff
- docs/reports/audit/WO-0050-mutations/f-c5.diff
- docs/reports/audit/WO-0050-mutations/f-c6.diff
- docs/reports/audit/WO-0050-mutations/f-c7.diff
- docs/reports/audit/WO-0050-mutations/f-c8.diff
- docs/reports/audit/WO-0050-mutations/README.md

## [J-auditor-0009] 2026-08-03T18:56:13Z | task:WO-0055 | Family-G campaign seeded: five oversize-path mutations authored blind against 2e8994f, with G-c4 seeded for `/E/` alone and G-c1's absent delivered-count constant disclosed rather than substituted

### Trigger
Orchestrator dispatch relaying dv_lead's `WO-0055`
(`agents/handoffs/WO-0055_family-g-mutation-campaign.md`, committed at
`b94aa1e`): seed the family-G qualification campaign — five mutation diffs
against M03, authored blind under the standing allowlist regime, all five
written before any of them is built or run. The packet governs over the
dispatch where they differ, and one of its five classes (G-c4) deliberately
leaves a choice to me and **requires** me to state it, because dv_lead's seal
is written as a function of that choice.

### Inputs
**Item 1 — the packet**: `agents/handoffs/WO-0055_family-g-mutation-campaign.md`,
read in full. **Item 2 — `docs/specs/**`**, extracted at `2e8994f`:
`docs/specs/modules/xgmii_rx_64.md` §6.1, §6.2 (all four rows), §6.3, §7, §8,
§9 in full and §10 in full; `docs/specs/requirements.md` §0.3, §0.6, §0.7 and
rows REQ-008, REQ-011, REQ-015, REQ-103, REQ-104, REQ-105, REQ-108, REQ-110.
**Item 3 — `docs/adr/**`**: nothing, deliberately (Reasoning 9). **Item 4 —
`libs/**`**: `libs/hardcaml_ethernet/src/xgmii_rx_64.ml` in full, 772 lines,
blob `81cd9ed7fc64e6265c53117f251ef948f24e3b00`; no other file in the extracted
library tree was opened. **Item 5 — my own tree**: `ls docs/reports/audit/` and
the heading list of `docs/reports/audit/WO-0050-mutations/README.md`. **Item 6 —
root build configuration**: `.ocamlformat` and `dune-project` at `2e8994f`.

**Outside the packet's allowlist, three directed reads, disclosed rather than
smoothed**: `agents/charters/auditor.md` and `agents/PROTOCOL.md` (my launcher's
two mandatory first actions) and the **tail only** of
`agents/journals/claude_auditor_agent.md` from line 1700 to EOF plus a grep of
my own entry headers (named in the spawn message, and structurally required —
R5 monotonicity and R3 append-only are not checkable without it). None carries
family-G bench content. **The void call is dv_lead's.**

**Ambient exposure beyond the enumerated bars**, reported because the bar list
is a floor: `git ls-tree --name-only 2e8994f` printed the repository's 17
top-level entry names, which is how item 6's siblings were identified — the
same judgement as WO-0050, no content read. `git status --porcelain` was run
**scoped to three allowlisted path prefixes** this round, so unlike last round
it leaked nothing. **The sealed predictions file was never opened, listed,
hashed, diffed, grepped or shown at any revision**, no file under `test/**` was
touched at any revision, and no `git log` was run at all, scoped or unscoped.

### Reasoning
Five intents, five sites. The work was in finding, for each intent, the site at
which it is one edit and no *second* rule breaks on the way — the packet's
standing clause, now earning its place a fifth time.

1. **Two of the five had to be kept apart by construction, and that decided
   G-c4.** G-c3 is "`error_bad_fcs` pulses alongside `error_oversize`". The
   record's FCS field is `a_close_terminate &: bad_fcs` and `bad_fcs` is live at
   a received count of 1518, so **any** mutation that lets a `/T/` act after the
   truncation point plants G-c3's defect a second time. That eliminated `/T/`
   for G-c4, and with it the generic "any control character" reading, which
   contains the `/T/` case whole. Seeding one class twice is the confound my
   last round names (`J-auditor-0008`, reasoning item 2) and I refused it again.
2. **Between the two survivors I chose `/E/` over `/S/` on blast radius.** `/S/`
   in `Discard` is clean — §9 says `error_oversize` never co-occurs with
   `error_start_without_terminate` — but `/S/` is also the character that opens
   the next frame, so the edit sits one wire from `b_exists`/`c_exists`/`begins`
   and the count and CRC reloads. `/E/` has **no other job in `Discard`**: it
   opens nothing, closes nothing, covers no octet, and five separate places in
   the spec pin its behaviour there (§6.2's `Discard` row, §9's third table row,
   §9's `error_oversize`-with-`error_bad_frame` ruling, REQ-105's row, REQ-108's
   row). It is the narrowest edit that breaks exactly one rule. Stated plainly
   in the report because the packet's seal is a function of it.
3. **G-c1's class named a constant this design does not have.** The intent is
   "the received-count constant used as the delivered-count constant", but 1514
   appears nowhere in the module — the file's own comment says 1514 is obtained
   by "capping coverage at 1518 and letting the four-octet tail removal run". So
   I read the class as an **observable** (delivered extent = 1518) and seeded it
   at the one site where that observable is a single-term edit: `sel_oversize`
   leaves the `strip` selector. The alternative — `oversize_threshold` 1518 →
   1522 — changes *which* frames are detected, contradicting the class line's own
   "still marked, still reported, and still resynchronises", and collides head-on
   with G-c2, which owns the threshold. Both readings are in README §3.1 and §6.1
   so the call can be reversed cheaply.
4. **G-c2 is one character and I proved its reach algebraically rather than
   asserting it.** `new ∧ ¬old` reduces to `cap_end = a_char_end` with the cap
   binding inside the word, which is exactly a closure character at octet time
   1518 — a frame of 1518 octets DA through FCS and nothing else. I checked the
   boundary by hand at **both** start lanes (6 vs 6 and 2 vs 2 at 1518; 6 vs 5
   and 2 vs 1 at 1517; base fires already at 1519) rather than trusting the
   algebra alone. The disclosure the packet's §3 asks for is that the comparison
   is character-agnostic, so an `/E/` or `/S/` at that exact octet time is also
   converted — one comparison, one defect, wider stimulus surface than the class
   line names.
5. **G-c3 admits the comparison rather than forcing the strobe.** "The residue
   comparison *runs* at the truncation point … and reports a mismatch" describes
   a check that is sequenced where it has no operands, not a hard-wired bit. So
   the gate becomes `(a_close_terminate |: a_close_oversize) &: bad_fcs` and the
   diff reports what the check finds. The price is a 2⁻³² frame that would not
   raise it, and I stated that as a property of the diff rather than hiding it
   behind a stronger, less faithful edit.
6. **G-c5 was left quiet, as instructed.** The packet warns not to strengthen it.
   `strobe sel_oversize` → `gnd` and nothing else: `tuser`[0] still set, extent
   still 1514, `Discard` still entered, resynchronisation still correct. The
   module's own comment — `error_oversize` "has epoch A's path only … written as
   one" — is what makes the whole strobe removable in one term.
7. **Verified before delivering, with negative controls at the two checks that
   could be blind.** Anchor-uniqueness assertions in the generator (a silent
   no-op edit is impossible, not merely unlikely); `git apply --check` plus real
   application to a **fresh** pristine extraction per diff and byte comparison;
   single-file and single-hunk and full-length index-line pinning; a
   comment-stripped code-delta inspection of every mutant; a parse check with
   five deliberately broken variants; a binding census for orphans; width,
   whitespace and marker checks.
8. **Revised no diff after any result**, there being none (bar 8); made no
   compile-only repair, because no diff has been compiled — see Evidence.
9. **Sampling frame.** Fixed by the packet: five intents, one module, one file.
   I skipped nothing inside it. Inside the allowlist I deliberately skipped
   `docs/adr/**` — the design file quotes the ADRs it depends on at the sites
   that depend on them, and none of the five intents turns on an ADR's text —
   and I read the spec sections the packet's own spec basis names, plus §9 and
   §10 in full because four of the five intents turn on §9.
10. Wrote nothing outside `docs/reports/audit/WO-0055-mutations/` and this
    journal append. Ran no `git commit` and no `git push`.

### Actions
Extracted `libs/` and `docs/specs/` at `2e8994f` with `git archive` (bar 10 — the
allowlisted sets are *named*, so no barred path was ever materialised and there
was nothing to filter). Read the design and the spec basis. Authored all five
mutations as anchored single-site substitutions in a generator, generated the
five mutants, and produced the diffs through a private one-file scratch git
repository containing only `libs/hardcaml_ethernet/src/xgmii_rx_64.ml`. Ran the
verification suite in Evidence. Wrote the six deliverables. Built nothing and
ran nothing.

### Evidence
Base, re-derived rather than assumed:
`git rev-parse 2e8994f:libs/hardcaml_ethernet/src/xgmii_rx_64.ml` →
`81cd9ed7fc64e6265c53117f251ef948f24e3b00`; `sha256sum` of the extraction →
`3d87515a843d98d7d5bd6692a9d19cdbe2b0dee4e430c88f871a2d4887f5be92`, 772 lines.
This equals the blob the family-E and family-F campaigns mutated, so the design
is byte-identical across six campaigns.

Generation: `python3 gen.py` reported `anchor unique` for all five and the
line-count change per site — `g-c1` 1→8, `g-c2` 1→9, `g-c3` 1→9, `g-c4` 3→13,
`g-c5` 1→7 (raw lines, comments included). The generator **asserts each anchor
occurs exactly once and aborts otherwise**, so a silent no-op edit is
impossible.

Post-image blobs, from full-length `index` lines: `g-c1`
`9ba8c88ea4407b4c3488e8650a886f8bbd53e06c`, `g-c2`
`9ebaca5ac347ae5836e1613ea49f6099532d2642`, `g-c3`
`b97e558388af52e096736a3d664777df4621e00a`, `g-c4`
`f5ea9d6b10f33be122adcc065c7f11730c573fdb`, `g-c5`
`e0a8b1eb2e0a93532139ab319d5e9853551b21fc`.

`git apply --check --verbose` from a **fresh** pristine `2e8994f` extraction per
diff: all five print `Checking patch libs/hardcaml_ethernet/src/xgmii_rx_64.ml...`
and nothing else. Each was then applied for real to that pristine tree and
`cmp`-ed against the generated mutant: **byte-identical in all five cases**. The
same check was repeated at the end against the **delivered** `.diff` files under
`docs/reports/audit/WO-0055-mutations/`, with the same result. Each diff has
exactly one `diff --git` header and one `@@` hunk.

Minimality, with comments stripped by a nesting-aware stripper against the
base's 299 code lines: **four of the five are one line replaced by one line**
(g-c1, g-c2, g-c3, g-c5); **g-c4 adds one line and removes none**. Every
mutant's comment-stripped delta was printed and inspected and is exactly the
intended edit.

Parse check, **with negative controls**: `ocamlc -stop-after parsing -c` (OCaml
4.14.1) accepts the pristine file and all five mutants. Five deliberately broken
variants — dropped parens in g-c1's `mux2` argument, g-c2's comparison and
g-c3's `~fcs` argument, a dropped `in` after g-c4's binding, and an unterminated
comment in g-c5 — were **all rejected** (`This '(' might be unmatched` ×3,
`Syntax error`, `Comment not terminated`), so the check has teeth.

Binding census over comment-stripped text: 135 base bindings; every mutant has
the same 135, adds none, removes none, and leaves none newly unreferenced — the
check that matters for g-c1 and g-c5, which each remove one use of
`sel_oversize`, leaving it used twice and once respectively. The base's two
apparent orphans (`hierarchical`, exported through the `.mli`; `tvalid`,
consumed through a qualified record pun) are census-regex artefacts, pre-existing
and identical in all five mutants.

Width and whitespace: every mutant's longest line is **97**, the base's own
maximum from lines 622 and 696, neither of which any diff lengthens (g-c1
shortens 696 below it). The longest line any diff **adds** is 84. Zero
trailing-whitespace lines, zero tabs, zero CR, final newline present, throughout.
Exactly one `MUTATION` marker per mutant, at its own site. The five diffs
embedded in README §3 were spliced by script and verified byte-identical to the
`.diff` files.

**Negative evidence, stated as a result rather than omitted.** No mutant has been
type-checked and none could be: this container's opam switch (`fpga`,
`ocaml-system.4.14.1`) has **no Hardcaml packages**, and there is no `dune` and
no `ocamlformat` binary at all. Compile-confidence is therefore HIGH on syntax,
scope and unused bindings (machine-checked above) and ASSERTED on types and
widths, with the per-mutation argument written out in README §5.1. Formatting is
**unverified**, and the sharper fact stands from last round: `.ocamlformat`
selects a 90-column margin while **the base already carries two 97-column code
lines**, so I could not establish that `dune build @fmt` is clean at `2e8994f`
in the first place.

### Outcome
Five diffs and a README committed under
`docs/reports/audit/WO-0055-mutations/`, seeding the family-G campaign against
`2e8994f`. All eleven of the packet's rules — six allowlist items, five process
bars — were honoured, with four things disclosed rather than smoothed: the three
directed `agents/**` pre-reads, the top-level `ls-tree` path-name leak, the
absent toolchain, and the base's own unclean margin. **All five intents were
seeded whole**; nothing was substituted and nothing was narrowed, so there is no
family-G analogue of last round's F-c8. The packet's one required disclosure is
answered: **G-c4 is seeded for `/E/` alone**, with `/T/` and the generic reading
rejected because both drag G-c3's defect into the diff through the closure
record's FCS field, and `/S/` rejected as clean but wider. Two further choices
are disclosed and reversible: **G-c1 is seeded at `strip`** because the design
has no delivered-count constant to corrupt, and **G-c3 admits the residue
comparison rather than forcing the strobe**, at the price of a 2⁻³²
coincidence. No diff was run, no result was seen, no revision was made, and no
prediction about which bench unit should redden appears anywhere in this work
order or in my head. `SO-M03` does not issue on family G regardless, per the
packet's own §5.

### Open-questions
1. **Was G-c1's observable the intended one?** The class names a
   delivered-count constant this design does not have. I read it as *delivered
   extent = 1518* and seeded it at `strip`; the constant-substitution reading
   (`oversize_threshold` → 1522) changes which frames are detected, contradicts
   the class line's own "still marked, still reported, and still
   resynchronises", and collides with G-c2. Routed for dv_lead's call; one line
   to reverse.
2. **G-c2's wider reach.** The weakened comparison is character-agnostic at the
   cap lane, so an `/E/` or `/S/` at exactly octet time 1518 is also converted
   into a truncation. One comparison, one defect, wider stimulus surface than
   the class line names — a disclosure under packet §3, not a failure.
3. **G-c4's rejected characters.** If dv_lead wants the `/T/` or `/S/` variant
   as well, it is a **separate** diff and a separate class, not a revision of
   this one — and the `/T/` variant cannot be seeded without also planting
   G-c3's defect.
4. **Is `dune build @fmt` clean at `2e8994f` at all?** The base carries two
   97-column code lines against a 90-column margin. If it is not clean, a `@fmt`
   failure under any mutation is pre-existing rather than mine and bar 8's
   compile-only repair clause should not be spent on it. Unchanged from
   `WO-0050` and still open.
5. **Compile-confidence is argued, not demonstrated**, for the fourth campaign
   running, because Hardcaml, `dune` and `ocamlformat` are all absent from this
   container. If any diff fails to build, bar 8 applies: I will change nothing
   else and will disclose the repair.

### Files-in-this-commit
- docs/reports/audit/WO-0055-mutations/g-c1.diff
- docs/reports/audit/WO-0055-mutations/g-c2.diff
- docs/reports/audit/WO-0055-mutations/g-c3.diff
- docs/reports/audit/WO-0055-mutations/g-c4.diff
- docs/reports/audit/WO-0055-mutations/g-c5.diff
- docs/reports/audit/WO-0055-mutations/README.md

## [J-auditor-0010] 2026-08-04T01:22:02Z | task:WO-0058 | M03-G7 + family-H campaign seeded: seven start-character mutations authored blind against a2d090d, with GH-c4's count-preserving reading and GH-c2's one added bit of state disclosed, and the deliverable moved back inside my write scope

### Trigger
Orchestrator dispatch relaying dv_lead's `WO-0058`
(`agents/handoffs/WO-0058_m03-g7-h-mutation-campaign.md`, which the dispatch
records as frozen at `1c3a89d`), naming me the blinded seeder of the combined
M03-G7 + family-H campaign — the same role I played at `WO-0045`, `WO-0050` and
`WO-0055`. Repository at `d609b36` on
`claude/fpga-hardcaml-agent-orchestration-37ceyf`; the base SHA for all seven
diffs is **`a2d090d`**, which the packet's header fixes and its §6 mechanics
build every throwaway branch from. Seven classes, GH-c1 … GH-c7, all seven to be
authored before any is applied anywhere, by an auditor who is not to know what
red is predicted.

### Inputs
Read, and this list is the whole of it (packet §2's allowlist item by item):

1. `agents/handoffs/WO-0058_m03-g7-h-mutation-campaign.md`, in full, from the
   working tree at `d609b36`. I did **not** diff it against `1c3a89d`: that
   would have put an `agents/**` path on a git command line, and §2's bar on
   git subcommands is the stricter of the two readings available. I take the
   packet as given.
2. `docs/specs/modules/xgmii_rx_64.md` in full (1014 lines, both pages) and
   `docs/specs/requirements.md` §0.6, §0.7, the whole §2 table (REQ-101 …
   REQ-113), the §1 rows REQ-001 … REQ-012 and the section index — both at
   `d609b36`, not at `a2d090d`, for the reason in Reasoning below.
3. `docs/adr/**`: **nothing opened**; `ls docs/adr` only.
4. `libs/hardcaml_ethernet/src/xgmii_rx_64.ml` in full (772 lines) and
   `libs/hardcaml_ethernet/src/dune` (3 lines), materialised by
   `git archive a2d090d libs/`. Base blob `81cd9ed`, `sha256`
   `3d87515a843d98d7d5bd6692a9d19cdbe2b0dee4e430c88f871a2d4887f5be92` —
   byte-identical to the blob family E, F and G were seeded against, so the
   design has not moved in seven campaigns.
5. `docs/reports/audit/`: the recursive listing, the first 60 lines of
   `WO-0055-mutations/README.md`, `WO-0055-mutations/g-c4.diff` in full, and my
   own journal's tail.
6. Root build configuration: `dune-project` and `.ocamlformat` at `a2d090d`.

Plus, because my spawn prompt's mandatory first actions name them:
`agents/charters/auditor.md` and `agents/PROTOCOL.md`.

### Reasoning
**Blinding conduct, stated affirmatively because it is the campaign's
evidentiary core.** I did not open, list, hash, diff, `git show`, `git grep`,
name to any tool or otherwise touch
`agents/handoffs/WO-0058_m03-g7-h-mutation-campaign-SEALED-predictions.md` at
any revision. I opened **no file under `test/**` at any revision** — not
`test_m03_g.ml`, not `test_m03_h.ml`, not the rest of the bench, the attack
plan, the DV machinery or the co-simulation lane — so everything I know about
M03-G7, M03-H1, M03-H2, M03-H3 and M03-H4 is the one-line description the packet
publishes for each in its own §1 table. I opened **no `agents/**` file other
than the packet, my charter, the protocol and my own journal**; in particular
not `WO-0056`, not `WO-0057`, not `RV-0055-VERDICT`, not `RV-0057-VERDICT`, not
any other agent's journal, not `tasks/BOARD.md`. **No unscoped `git log`**, and
no `git` subcommand of mine named a path outside the allowlist. One unscoped
invocation is disclosed rather than smoothed: I ran `git status --porcelain`
once to prove my `git apply --check` calls had left the tree clean; its output
was **empty**, so it revealed no path, but had the tree been dirty it could
have named out-of-bounds ones.

**Sampling frame.** The frame is not a sample this round: it is the whole of
one file. Every one of the seven intents is a defect of M03 and M03 is one
772-line module, so I read it entire and reasoned about all seven classes
against the same text rather than sampling sites. What I deliberately skipped is
`docs/adr/**` — every rule I relied on is stated normatively in the two
specification documents, and the ADRs restate rationale — and the other twelve
files in the `libs/` extraction, which no class touches.

**Why I read the specifications at `d609b36` rather than at `a2d090d`.** They
moved: `git diff --stat a2d090d HEAD -- docs/specs/` reports +22 lines in the
module spec and +50 in `requirements.md`, while the same command over `libs/` is
empty. The packet's §3 spec basis cites §9's *2026-08-04 zero-referent
paragraphs* and §0.6's *C-23 counting-convention paragraph* by name, which are
only guaranteed present in the later text. Reading a strictly additive later
statement of the rules cannot make a diff unfaithful to an earlier one where the
two agree; reading the earlier one could have made me miss a rule the packet
cites. The design I mutated is `a2d090d`'s either way.

**The write-scope conflict, and why I resolved it against my own orders.** My
spawn prompt names the deliverable `agents/handoffs/WO-0058_manifests.md`. That
path is outside my write scope on four independent statements of it — PROTOCOL
§6's table, PROTOCOL §3's ADR-0003 auditor exception (*stages
`docs/reports/audit/**` and nothing else, ever — deliberately, so it can never
modify an artifact it audits, including other agents' packets*), my charter §5,
and `WO-0058` §5 itself (*a report under `docs/reports/audit/**`*) — and R7
would have refused the commit mechanically under the trailer `Agent: auditor`.
`agents/handoffs/` is also the directory holding this campaign's sealed
companion, which makes it the last directory a blinded seeder should be writing
into. I honoured every part of the instruction I could: **one file**, all seven
manifest entries, diffs inline, with a tested one-command extraction to the
`WO-0055` seven-`.diff` form. The deviation is reported in the report's §0, in
my return message, and here. I did not write the named file.

**Rendering decisions, class by class — what won and what was rejected.**

- **GH-c1** is `a_close_start` extended by `sm.is State.Discard &: any
  lanes.is_start`. It is the exact structural sibling of `g-c4`, which extended
  `a_close_error` and which the packet puts out of scope; `a_close_error` is
  byte-unchanged here, so the two are distinguishable by inspection. Rejected:
  narrowing the added term to lanes 0 and 4, because the base predicate's own
  `a_close_oh` search covers eight lanes and §6.3 item 3 leaves the rest
  unconstrained anyway.
- **GH-c2** is the only diff that adds state — one bit, set by `a_close_error`
  and cleared by `begins`. I looked hard for a state-free rendering and there is
  none: in this design the `/E/`-closed frame stops delivering **because the
  machine leaves to `Idle`**, and `a_open` is what makes epoch A's REQ-110
  closure reachable, so anything that keeps the frame abortable without keeping
  it receiving has to carry a fact the base design carries nowhere. The
  state-free alternatives — not taking the `Frame` → `Idle` exit, or adding a
  fifth state — land squarely on the reading the packet's own scope clause calls
  *a different and much wider defect*. One bit is the smallest thing that
  carries the fact, and I disclosed it as a structural addition rather than
  filing it under bar 8's build repairs, which it is not.
- **GH-c3** is `sel_start` added to `strip`'s condition. The interesting part is
  what I did **not** add: `sel_oversize` was already there, and reading it as
  part of the seeded defect would have been wrong — the module's own comment
  records it as REQ-108's 1518-to-1514 arithmetic, not FCS removal. Rejected:
  adding `sel_error` as well, which the scope clause asks about and which would
  have merged REQ-105 into a REQ-110 class.
- **GH-c4** was the round's real judgement call and it turned on the word
  *same*. The intent says the mutant switches its offset **on the same cycle it
  accepts the new start character**, and it names the signature as
  count-preserving and content-destroying. Three renderings exist. Removing the
  register's one-cycle lag (`start4_pending` → `begins &: new_start4`) switches
  the offset at W+1, not W, and — because `cov` is rotated through the same
  window as the octets — empties the aborted frame's last aligned word, giving
  the **count-moving** reading. Splitting the offset so `al_data` leads and
  `al_keep` lags gives the content-destroying signature but is a rotation/keep
  mismatch rather than an early offset. Bypassing the register combinationally
  on cycle W itself — `off4 |: (begins &: new_start4)` — is literally *the same
  cycle*, is one added line, and at REQ-110's own lane-4 geometry produces
  exactly the stated signature: `al_keep` is 0xFF either way, `first_v` is low
  in `Frame` so `al_new` and `nc` do not move, and only `al_data` changes, the
  aborted frame losing octets 8m … 8m+3 and repeating 8m+8 … 8m+11. That is the
  one I seeded, and the disclosure says so in the packet's own vocabulary.
- **GH-c5** gates `begins` with `~:a_close_start`. `a_close_start` is the
  module's own name for REQ-110's abort of epoch A, and being gated by
  `a_char_acts` it is low in `Discard` **and** on the truncating word, so the
  class's one named exclusion — REQ-108's resynchronisation — is excluded
  structurally rather than by hand. Rejected: `~:a_open`, which is one character
  shorter and would have swallowed the same-word truncate-then-resynchronise
  case; and a widened gate covering epoch B's in-word abort, which would have
  required a second term reproducing `inword_strobes`' start computation. The
  edge that leaves is named in the report rather than papered over.
- **GH-c6** drives one output field to `gnd`, which cuts both report paths for
  the name at once while leaving `abort`, `consume` and the record channel
  untouched. The packet asks that this class not be strengthened; it has not
  been.
- **GH-c7** applies `collapse s = s &: ~:(reg spec s)` to **all five** strobe
  ports. Rejected: applying it to `error_start_without_terminate` alone, which
  is narrower than the intent — §0.6's counting convention is programme-wide and
  the intent's own words are *a one-cycle-per-name lockout*.

**One formatting decision worth recording, because it is the fourth campaign in
a row that the container cannot answer.** Hardcaml, `hardcaml_axi`,
`ppx_hardcaml` and `ocamlformat` are all absent here, and the base file carries
two 97-column lines against `.ocamlformat`'s janestreet profile, so whether
`dune build @fmt` is clean at `a2d090d` at all is still unestablished. Rather
than guess a margin, I made every added line ≤ 88 columns and every added
expression a single-line `let … in`, which is a fixpoint at either 90 or 100.
That is why GH-c1, GH-c2 and GH-c3 name an intermediate binding instead of
extending the original line: extending it would have produced a 97-to-110-column
line whose reformatting is margin-dependent.

### Actions
- Materialised the base by `git archive a2d090d libs/` into a private scratch
  directory (packet bars 9 and 10) and fixed its identity by blob id and
  `sha256`.
- Authored seven mutants of `libs/hardcaml_ethernet/src/xgmii_rx_64.ml` — **all
  seven before any was applied anywhere** (bar 7) — each carrying a
  `MUTATION GH-cN … NEVER MERGE` comment at its own site; `gh-c2` is a two-site
  diff and carries the marker at both.
- Generated the seven unified diffs in a scratch git repository containing
  nothing but the extraction, and verified each three ways (below).
- Wrote `docs/reports/audit/WO-0058-mutations/README.md`: the deviation notice,
  the allowlist scope statement, the seven entries with diffs inline and a
  mechanical statement each, the four mandatory disclosures collected into one
  table, the build state, the fidelity ledger, and a tested extraction command.
- **Ran nothing against the bench, applied nothing to the repository working
  tree, created no branch, ran no `git commit` or `git push`.** The working
  tree's `libs/**` is unmodified.

### Evidence
All commands run from `/home/user/agentic-fpga` at `d609b36` unless a scratch
path is named; `$S` is my scratch directory.

1. `git rev-parse a2d090d:libs/hardcaml_ethernet/src/xgmii_rx_64.ml` →
   `81cd9ed7fc64e6265c53117f251ef948f24e3b00`;
   `sha256sum` of the extraction →
   `3d87515a843d98d7d5bd6692a9d19cdbe2b0dee4e430c88f871a2d4887f5be92`;
   `wc -l` → `772`.
2. `git diff --stat a2d090d HEAD -- libs/ docs/specs/ docs/adr/ dune-project
   .ocamlformat` → two files changed, both under `docs/specs/` (+22, +50);
   `libs/` contributes nothing, so the base design and the working tree's design
   are the same bytes.
3. **Clean application, check 1.** In a scratch repository containing only
   `git archive a2d090d libs/`: `git apply --check --index $S/diffs/<id>.diff`
   returns **clean for all seven** (observed: `gh-c1 … gh-c7: CLEAN`).
4. **Clean application, check 2 — faithful serialisation.** In that same
   repository each diff was applied and the resulting blob's `sha256` compared
   against the mutant I authored: **all seven match** (observed:
   `<id>: applied blob == authored mutant`, seven times).
5. **Clean application, check 3.** `git apply --check` against the live working
   tree returns clean for all seven, and `git status --porcelain` afterwards is
   **empty**.
6. **Syntax and comment lexing.** `ocamlc -stop-after parsing -c` (system OCaml
   **4.14.1**) accepts the unmutated base as a control and accepts all seven
   mutants (observed: `base: PARSES`, then `gh-c1 … gh-c7: PARSES`). This is a
   real check here: an unbalanced `"` inside an OCaml comment is a lexer error,
   and `grep -c '"'` returns **33** on the base and **33** on each of the seven,
   so no added comment introduces a quote at all.
7. **Round-trip of the extraction command published in the report's §7.**
   Extracted seven files from the committed README and compared with `cmp -s`
   against the diffs I generated: **byte-identical, all seven**; the extracted
   copies then `git apply --check` clean against the `a2d090d` tree.
8. **Margin.** No added line exceeds **88** columns in any of the seven
   (checked mechanically over the `+` lines of every diff).
9. **Types are NOT demonstrated.** `dune build` in the scratch tree fails at
   `Error: Library "hardcaml_axi" not found` — the only opam switch (`fpga`)
   contains `dune` 3.24.1 and nothing else — and ADR-0005 makes a local build
   inadmissible evidence in any case. The type argument is by construction and
   is written out in the report's §5.
10. **No prediction anywhere.** The report contains no statement about which
    unit reddens, which stays green, or what any message says, and I am not in a
    position to make one.

### Outcome
DoD met against `WO-0058` §5, with one disclosed deviation of location and none
of substance. **All seven classes are SEEDED**; nothing is NOT-SEEDED, nothing
was substituted for something easier, and no class was narrowed to make it
build. The four disclosures the packet makes the sealed row sets a **function**
of are answered in the packet's own terms: **GH-c2 does NOT fire where an error
character arrived with no frame open**, in the gap or in `Discard`; **GH-c3
shortens neither an `/E/`-aborted frame nor a truncated one**, its whole reach
being the added `sel_start` term; **GH-c4 produced the count-preserving,
content-destroying reading**, with the two geometries where it either does
nothing or moves the count named; **GH-c5 does NOT reach REQ-108's
resynchronisation** in either form, with the epoch-B narrowing named. The
deliverable is `docs/reports/audit/WO-0058-mutations/README.md` and **not** the
`agents/handoffs/` path my dispatch named — the reasons are four independent
statements of my write scope plus R7, and they are set out in the report's §0.
Handoff: to the orchestrator, which applies each diff transiently to
`mut/wo-0058-gh-c1 … gh-c7` off `a2d090d` under PROTOCOL §10's transient model.
No diff was run, no result was seen, no diff was revised, and the sealed
companion was not opened.

### Open-questions
1. **The deliverable path is an orchestrator decision now, not mine.** If the
   packet's manifests are wanted inside `agents/handoffs/`, the file has to be
   staged by an agent whose scope reaches there — the orchestrator, under its
   own trailer, transcribing from my committed report exactly as PROTOCOL §3's
   ADR-0003 paragraph has it transcribe my `RETURNED` verdicts. I cannot do it
   and should not.
2. **GH-c4's reading.** I produced the count-preserving one and argued the word
   *same* is what selects it. If dv_lead intended the count-moving reading, the
   reversal is one token — `begins &: new_start4` back to `start4_pending`, in
   the register rather than the bypass — and the report says so.
3. **GH-c2's added bit of state.** No state-free rendering exists that respects
   the scope clause; if dv_lead reads the intent as reaching the wider
   *frame keeps receiving* defect, that is a different class and not a revision
   of this one.
4. **GH-c5's epoch-B edge.** A lane-4 start aborting a frame opened by a lane-0
   start in the same word, with nothing open on entry, still begins its frame
   under this diff. Widening is one extra term reproducing `inword_strobes`'
   start computation; I judged the single-predicate gate the faithful minimal
   rendering and disclosed the edge instead.
5. **Is `dune build @fmt` clean at `a2d090d` at all?** The base carries two
   97-column code lines. Unchanged from `WO-0050` and `WO-0055` and still open;
   if a `@fmt` failure appears under any of these seven, the first question is
   whether it is pre-existing, and bar 8's repair clause should not be spent on
   a base-level failure.
6. **Compile-confidence is argued, not demonstrated**, for the fifth campaign
   running, because Hardcaml and its ppx are absent from this container. If any
   diff fails to build, bar 8 applies: I will change nothing else and will
   disclose the repair.

### Files-in-this-commit
- docs/reports/audit/WO-0058-mutations/README.md
