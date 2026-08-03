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
