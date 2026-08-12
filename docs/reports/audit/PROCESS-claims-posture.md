# PROCESS-claims-posture — every enforcement and event claim in `docs/PROCESS.md`, re-executed

- **Auditor**: auditor (independent), journal entry `J-auditor-0023`
- **Commissioned by**: the orchestrator, as the process council's *One Thing to Do
  First* (`docs/reports/process-council/round-1/verdict.md` §"The One Thing to Do
  First"), **before any text of `docs/PROCESS.md` is edited**. Work-order id: none
  (dispatch-only round — itself an instance of claim **C-70** below).
- **Audit subject**: `docs/PROCESS.md` at `6c02f5b`, 1,445 lines.
- **Machinery checked against**: `scripts/policy.sh`, `scripts/agent_commit.sh`,
  `scripts/check_journals.sh`, `scripts/test_protocol.sh`,
  `scripts/verify_journal_chain.sh`, `.github/workflows/{journal-check,build,site-deploy}.yml`,
  `agents/PROTOCOL.md`, `docs/adr/ADR-0001..0020`, `docs/gates/**`,
  `agents/handoffs/**`, `agents/journals/**` (26 volumes), `tasks/BOARD.md`,
  `docs/SPONSOR.md`, and git history.
- **Precheck** (PROCESS §4.1, executed before any file was opened for editing):
  `git status --short` → empty; `git rev-parse HEAD` → `6c02f5b2b21be63c1091e6b026be17aeb7159bbe`,
  exactly the expected head, on `claude/fpga-hardcaml-agent-orchestration-37ceyf`.
  Declared siblings (dv_lead WO-0082, orchestrator journal/board/site) had landed
  or had not yet begun; no undeclared dirty path existed. Proceeded.
- **Inward sibling check** (PROCESS §4.2, the direction usually forgotten):
  HEAD moved mid-round, from `6c02f5b` to `b19ff91`. Verified rather than
  assumed: `git merge-base --is-ancestor` confirms descent; the landing is
  `Agent: dv_lead`, "WO-0082 drafted…", touching exactly
  `agents/handoffs/WO-0082_tb-m04-two-frame-presenter-and-g10.md` and
  `agents/journals/claude_dv_lead_agent.v11.md` — declared sibling (1) of the
  dispatch. `git diff --stat 6c02f5b HEAD` over every read surface of this audit
  (`docs/PROCESS.md`, `scripts/`, `.github/workflows/`, `agents/PROTOCOL.md`,
  `docs/adr/`, `docs/gates/`, `agents/charters/`, `docs/SPONSOR.md`,
  `agents/journals/INDEX.md`, both auditor volumes,
  `docs/reports/process-council/`) is **empty**: no measurement in this report
  was taken against a state that has since moved, and none needed re-running.
  Every citation resolves identically at `6c02f5b` and at `b19ff91`.
- **A third concurrent lane, undeclared to this round, and what it does not
  change.** After this report was written, the working tree showed
  `docs/adr/ADR-0021-a-check-is-only-where-it-runs.md` (untracked) and two
  modified `test/xgmii_tx_64/` files. The second pair is dv_lead's declared lane.
  The first is an `architect_docs_lead` draft (proposed at
  `J-architect_docs_lead-0049`) commissioned to build instruments for residues
  this report measures — a ±60-minute stamp warning on both surfaces (rows C-54,
  C-119) and the journal-size limb on the CI surface (rows C-46, C-56). **No
  posture below changes.** Every posture is measured against the **committed**
  record; ADR-0021 is uncommitted, **PROPOSED, NOT IN FORCE**, and states in its
  own Deciders block that it carries "**no diffs to those paths**" because
  `scripts/**` and `.github/**` are orchestrator scope. `git diff` over
  `scripts/`, `.github/`, `agents/PROTOCOL.md` and `docs/PROCESS.md` in the
  working tree is empty. Recorded here so that a later reader can date this
  measurement against that instrument rather than infer the order: **if
  ADR-0021's route completes and the size limb lands in
  `scripts/check_journals.sh`, row C-56 ceases to be FALSE and rows C-46 and
  C-55 change with it — by a later act, on a later commit, and not by this
  file being edited.**
- **Stamps**: `date -u` at spawn `2026-08-11T21:09:42Z`; at report freeze
  `2026-08-11T21:18:51Z`; inward re-verification `2026-08-11T21:23:08Z+`.

---

## 0. What this document is, and the one thing it is not

This is a **posture list**, not a findings report. Each row states what
`docs/PROCESS.md` claims, what posture that claim actually holds, and the
evidence that decides it. The architect's revision consumes it directly: every
edit should be citable to a row here.

**It is not a findings report**, and no row below is filed as a numbered
CRITICAL/MAJOR/MINOR finding. Severity grading of these claims belongs to the
round that adjudicates the revision, not to the round that measures the claims.
Fifteen rows are marked **FALSE** and each names its contradicting artifact; a
reader who wants a severity may read a FALSE row as at least MAJOR by PROCESS's
own §2.1 standard (*"A control that is claimed to be mechanical and is not is
worse than a control known to be advisory, because the claim suppresses the
compensating vigilance"*).

### 0.1 Posture definitions (as commissioned)

| Posture | Meaning | What the evidence column must show |
|---|---|---|
| **MACHINE-CHECKED** | A script or CI step refuses or fails on violation | script path:line, or CI workflow step |
| **REVIEW-ENFORCED** | A named seat, form or artifact carries it; no instrument | the reviewing seat and the form it uses |
| **PERFORMED-ONCE** | Asserted as an event, and the event happened | date + commit / journal entry / run id |
| **PLANNED** | Owed; the instrument does not exist | what is absent, and where it was promised |
| **FALSE** | Contradicted by the machinery or the record | the contradicting artifact, named |

One row (**C-24**) is marked **NOT SAMPLED** rather than forced into a posture:
its subject is an anonymized episode I could not anchor within this round's
frame, and asserting a posture I did not verify would be exactly the defect this
report exists to measure. It is counted separately.

### 0.2 Sampling frame (charter §8, mandatory)

**In the window**: every sentence of `docs/PROCESS.md` asserting (a) mechanical
enforcement, (b) that CI checks something, (c) that an event was performed, or
(d) that a prohibition is structural. I read all 1,445 lines and grepped the
enforcement/event vocabulary (`cannot`, `refus*`, `enforce*`, `mechanic*`,
`machine*`, `checked`, `re-check*`, `verif*`, `continuous integration`,
`exercised`, `spot-check`, `re-execut*`, `forbid`, `impossible`) to guard the
manual sweep — 213 candidate lines, reduced to the 128 claims below after
removing failure-class narrative, which asserts nothing about this program's
controls.

**Sampled and executed**: every claim below. Executions performed: the full
protocol self-test (`bash scripts/test_protocol.sh` → **51 passed, 0 failed**);
14 direct probes of `agent_may_write` by sourcing `scripts/policy.sh`; 92
ancestry tests over `mut/*` refs; and ~30 targeted greps and `git log` queries
over history, journals, packets and ADRs. No commit, no push, no state mutation.

**Deliberately skipped, and why**:
1. **Severity assignment and finding numbers** — out of this round's scope
   (§0 above).
2. **Re-execution of PROCESS's *failure-class* prose** — those sentences make no
   claim about this program.
3. **The residual-risk-routing episode of §1.4(d)** — see C-24; not anchored.
4. **Whether the four §5.7 disguises each map to a distinct incident** — I
   anchored four of six and grouped them (C-128) rather than claiming six.
5. **Bob's four calibration claims were re-executed from the machinery, not
   adopted.** All four reproduce; one of Bob's supporting citations does not
   (see §5).

---

## 1. Summary counts

**128 rows. 127 claims carry a posture; 1 is NOT SAMPLED (C-24).**

| Posture | Count | Share of the 127 |
|---|---:|---:|
| **MACHINE-CHECKED** | 34 | 26.8% |
| **REVIEW-ENFORCED** | 44 | 34.6% |
| **PERFORMED-ONCE** | 26 | 20.5% |
| **PLANNED** | 8 | 6.3% |
| **FALSE** | 15 | 11.8% |
| *(NOT SAMPLED, uncounted)* | *1* | — |

Per section, for the architect's edit budget:

| Section | Rows | MACHINE | REVIEW | PERFORMED | PLANNED | FALSE | Not sampled |
|---|---:|---:|---:|---:|---:|---:|---:|
| §1 The shape of the organization | 33 | 9 | 14 | 4 | 1 | 4 | 1 |
| §2 The constitution and its enforcement | 36 | 22 | 5 | 2 | 4 | 3 | — |
| §3 The artifact grammar | 37 | 3 | 19 | 8 | 1 | 6 | — |
| §4 The operating disciplines | 11 | — | 6 | 3 | 1 | 1 | — |
| §5 The failure museum | 8 | — | — | 6 | 1 | 1 | — |
| §6 Adopting this | 3 | — | — | 3 | — | — | — |
| **Total** | **128** | **34** | **44** | **26** | **8** | **15** | **1** |

**Three things the shape says.**

1. **§2 is the document's honest section and §3 is not.** 22 of §2's 36 claims
   are machine-checked and every citation resolves; §3 carries 19
   review-enforced and 6 FALSE against only 3 machine-checked. The document is
   accurate exactly where it describes scripts and least accurate where it
   describes artifacts.
2. **Every FALSE claim is a claim of mechanism or of a performed event.** Not
   one of them is a judgement call. Each is refuted by a file the architect can
   open — §3 lists all fifteen with their artifacts.
3. **The document's own §6.1 instruction had never been executed.** *"Any
   statement in this document that a control is mechanically enforced. Check it
   in your own machinery before you repeat it."* Executed for the first time
   here, it returns **15 FALSE and 8 PLANNED** out of 127.

---

## 2. The posture list

Line numbers are `docs/PROCESS.md` at `6c02f5b`. Quotes are exact; `…` marks an
elision I made, never the source's own.

### §1 — The shape of the organization

| # | Section · lines | Exact quote | Posture | Evidence |
|---|---|---|---|---|
| C-01 | §1.0 · 51–53 | "One **orchestrator** — a single long-running session — is the only seat that starts other agents and the only seat that writes to version control." | **REVIEW-ENFORCED** | No repo instrument binds who runs `git`. Stated at `agents/PROTOCOL.md`:30–33. Enforced by charter text + dispatch content; the auditor's own charter §8 (`agents/charters/auditor.md`:81) says "You never run git". Contradicted once — see C-07. |
| C-02 | §1.0 · 56–57 | "sits an **auditor** that can write only its own findings and can never fix what it finds" | **MACHINE-CHECKED** | `scripts/policy.sh`:189–193 (`auditor` → `docs/reports/audit/*` only); refused at `scripts/agent_commit.sh`:213–217 and re-refused at `scripts/check_journals.sh`:193–198. Probed live: `auditor→docs/gates/…` DENY, `auditor→agents/handoffs/…` DENY, `auditor→docs/reports/audit/…` ALLOW. Self-test S6 and S25. |
| C-03 | §1.0 · 59–60 | "the pairing is enforced by a script and re-checked by continuous integration" | **MACHINE-CHECKED** | R2 coupling: `agent_commit.sh`:94–95, `check_journals.sh`:141; CI step `.github/workflows/journal-check.yml`:24–25 (`--all`, full history) plus :44–48 (range). |
| C-04 | §1.0 · 58–59 | "Every commit carries exactly one agent's work" | **REVIEW-ENFORCED** | R1 for the orchestrator is audit-enforced by the constitution's own words (`PROTOCOL.md`:165–171) and PROCESS concedes it at 318–322. The claim that it is *emergent* for scoped seats is separately FALSE — C-40. |
| C-05 | §1.0 · 60–61 | "Nothing normative changes without a numbered decision record and a signature from a seat that did not write it." | **REVIEW-ENFORCED** | No script tests for an accompanying ADR or countersignature. Partially load-bearing machinery exists: all 8 commits touching `agents/PROTOCOL.md`, all 7 touching `scripts/`, all 4 touching `agents/charters/` are `Agent: orchestrator` (R7). Counterexample in the document's own family: `docs/PROCESS.md` landed at `f67a57a` with `Work-Order: none`, one seat, no countersignature. |
| C-06 | §1.1 · 65–66 | "The orchestrator is the **sole spawner** — no other agent starts an agent" | **REVIEW-ENFORCED** | Asserted as a substrate fact at `PROTOCOL.md`:30–31. Not verifiable from a checkout and not enforced by any repo instrument; the eight launchers in `.claude/agents/` define spawnable agents but nothing refuses a spawn. |
| C-07 | §1.1 · 66 | "and the **sole committer** — no other agent runs a commit or a push." | **FALSE** | `docs/adr/ADR-0019-the-seeder-never-operates-the-repo.md` §1.2: at WO-0073 the auditor "did" cut, commit and push five transient branches (`J-auditor-0015`), on the orchestrator's own dispatch, plus "three prior deviations" (§1.1/§1.2). The rule has been standing only since `J-orchestrator-0218` (2026-08-10). The authorizing instrument is still **PROPOSED**. |
| C-08 | §1.1 · 87–89 | "Packet numbers are allocated at commit time by the one seat that commits, so they are monotonic by construction rather than by convention." | **FALSE** | `ls agents/handoffs/` contains `WO-0063A` and `WO-0063B`, outside the `NNNN` scheme; and WO-0048, WO-0051, WO-0052, WO-0053 have **no packet file at any commit** (`git log --all -- 'agents/handoffs/WO-0048*'` etc. → empty) while being live ids in journal `task:` headers. Construction required improvisation in both directions. |
| C-09 | §1.1 · 89–90 | "History is serialized on one branch, so there is a single order of events." | **MACHINE-CHECKED** | Merge triviality and octopus refusal: `check_journals.sh`:41–56 (self-test S22, S24). Residue the sentence does not name: 85 `mut/*` refs exist on `origin` beside the working branch (ADR-0019 §1.1) — verified never merged, C-101. No-force-push is not in any script — C-58. |
| C-10 | §1.1 · 98–101 | "its own correct behavior is the one thing the machinery cannot check mechanically — every other seat is constrained by write scopes, and the orchestrator's scope is everything." | **MACHINE-CHECKED** | True as a negative, and verifiable: `policy.sh`:170–172 — `orchestrator) return 0 ;;` for every path. Probed: `orchestrator→docs/reports/audit/x.md` ALLOW. |
| C-11 | §1.1 · 101–103 | "That residue is covered by the auditor, which audits the orchestrator like anyone else" | **PERFORMED-ONCE** | 2026-08-01, `AUD-0001-g0-retro.md` §6 "Orchestrator attribution honesty (R1 is my check here)" and §7 "Escalation discipline (E1–E6)", `J-auditor-0001`. **Nothing since**: entries `J-auditor-0004`…`-0018` are all mutation-seeding rounds; `-0019` harvest, `-0020` census, `-0021`/`-0022` countersignatures. The residue has been uncovered for the entire build phase. |
| C-12 | §1.2 · 115 | "Never authors the evidence it is asked to judge." | **REVIEW-ENFORCED** | No instrument. The mutation model routes composition to the auditor and operation to the orchestrator (ADR-0019 §1.1) — the separation is packet-borne, not checked. |
| C-13 | §1.2 · 124 | "**The implementation lead.** … Never writes the tests that grade it." | **MACHINE-CHECKED** | `policy.sh`:179–183 — `rtl_lead`/`rtl_lead_md` allow only `libs/`, `top/`, `bin/`, `rtl_snapshots/`, `agents/handoffs/`. Probed: `rtl_lead→test/foo.ml` DENY. Self-test S6:159–165. |
| C-14 | §1.2 · 127–128 | "Derives everything from the specification, never from the implementation." | **REVIEW-ENFORCED** | No read denial exists in any agent runtime; PROCESS concedes this at 199–205. The compensating audit leg has never run — C-23. |
| C-15 | §1.2 · 135–136 | "Writes to one directory — its own reports — and to no other, ever." | **MACHINE-CHECKED** | As C-02. One imprecision worth an edit: the scope check governs *work products*; the auditor's own journal under `agents/journals/` is staged in every one of its commits by R2 and is carved out of the scope test by `is_journal_path` (`policy.sh`:48–57). "One directory" is two. |
| C-16 | §1.2 · 136 | "its verdicts reach the sponsor unedited" | **REVIEW-ENFORCED** | Relay class is declared at `PROTOCOL.md`:51–61 and §8 E4. Never spot-checked — C-112. |
| C-17 | §1.3 · 150–151 | "An agent's first mandatory action on every spawn is to read its own charter and the shared rules." | **REVIEW-ENFORCED** | Present in the prompt surface: `.claude/agents/auditor.md`:10–12 — "MANDATORY FIRST ACTIONS, in order: 1. Read `agents/charters/auditor.md` … 2. Read `agents/PROTOCOL.md`" — and in all eight launchers. No instrument verifies the read occurred; the journal `Inputs` section is the only evidence, and it is audit-enforced (C-23). |
| C-18 | §1.3 · 153–154 | "Charters change only by the amendment procedure (§2.7) — a numbered decision record, not an instruction." | **REVIEW-ENFORCED** | All 4 commits touching `agents/charters/` are `Agent: orchestrator` (R7-backed), but no script tests for the ADR. ADR-0019 §7.2/§7.3 currently hold **owed, unapplied** charter diffs while the rule they record is in force. |
| C-19 | §1.3 · 163–167 | "Before ratification, three independent reviewers were set on the charter set with different lenses … They returned twenty-six findings, one of them critical. All were accepted." | **PERFORMED-ONCE** | 2026-08-01, pre-repo. Re-executed at `AUD-0001-g0-retro.md`:186–187 (RX-4): "not resolvable from the repository … Resolvable only because the pre-repo scratch artifacts survive at `judge.json` … and `review_findings.json` … in the session scratchpad" — 26 findings and 1 CRITICAL **TRUE**; the severity split as first stated was **MISSTATED** (AUD-0001-F5/F6). The exhibit's evidence does not survive in git. |
| C-20 | §1.4(a) · 171–172 | "**No seat reviews its own work.** Every output is accepted by a seat that did not produce it." | **REVIEW-ENFORCED** | No instrument. Counterexample inside the document's own family: `f67a57a` — `docs/PROCESS.md`, `Agent: architect_docs_lead`, `Work-Order: none`, no lifecycle, no countersignature, no audit until the council round at `6c02f5b`. |
| C-21 | §1.4(b) · 181–184 | "The implementation line cannot write in the test tree, and the verification line cannot write in the implementation tree. This is enforced at the boundary — as a refusal at commit time — and not as an instruction." | **MACHINE-CHECKED** | Probed all four directions: `rtl_lead→test/*` DENY, `rtl_module_dev→test/*` DENY, `dv_lead→libs/*` DENY, `tb_writer→libs/*` DENY (`policy.sh`:179–213). Refusal sites `agent_commit.sh`:213–217, `check_journals.sh`:193–198. Self-test S6. |
| C-22 | §1.4(c) · 199–203 | "This is the one separation that cannot be enforced by file permissions — nothing in a general agent runtime can deny read access to a path — and the process is explicit that it is enforced instead by prompt content, packet content…" | **REVIEW-ENFORCED** | Accurate and evidenced: `agents/handoffs/WO-0040_tb-m03-family-d-fcs.md`:254 carries a "## 7. What you may NOT read" section. One overstatement: it is not *the one* — the CC BY-NC consult-only boundary (`PROTOCOL.md`:434–436) is a second read restriction with the same non-enforceability. |
| C-23 | §1.4(c) · 202–203 | "…and audit of the \"inputs\" section of each reasoning log" | **PLANNED** | No Inputs-sampling audit exists over the build phase. The auditor's 22 entries contain none; the only Inputs/vacuity sampling in the record is `AUD-0001-g0-retro.md` §4 (2026-08-01), before the build phase began. The compensating control the blinding rule routes to has not run in ten days and ~85% of the record. |
| C-24 | §1.4(d) · 212–216 | "*Anonymized pattern.* A residual risk in an amendment was routed, in the amendment's own text, to \"review by the ordinary reviewing lead\" — where that lead was the party the rule under discussion measured…" | **NOT SAMPLED** | I could not anchor this episode to an ADR, packet or entry within this round's frame (greps over `docs/adr/**` and the dv/auditor countersignature entries returned nothing on "residual risk"/"ordinary review"). It is not marked FALSE — absence of a located anchor is not a contradiction. The architect should ask the author for the anchor, or drop the exhibit. |
| C-25 | §1.5(1) · 222–225 | "**It can write only its own reports.** Not the specifications it audits, not the tests, not the artifacts, not even the shared task packets. This is enforced mechanically." | **MACHINE-CHECKED** | `policy.sh`:189–193; self-test S6 (auditor→`libs/` refused, R7) and S25 (auditor→`agents/handoffs/` refused, R7). This is the one "enforced mechanically" claim in the document that survives its own §6.1 test unqualified. |
| C-26 | §1.5(2) · 226–228 | "**It never fixes what it finds.** A finding is routed to the owner, who repairs it." | **MACHINE-CHECKED** | Same instrument as C-25 — the auditor cannot stage the artifact it would repair. |
| C-27 | §1.5(3) · 229 | "**It audits the orchestrator too** — including the seat that spawns it." | **PERFORMED-ONCE** | See C-11: `AUD-0001-g0-retro.md` §6–§7, 2026-08-01, `J-auditor-0001`. Not repeated since. |
| C-28 | §1.5(4) · 230–232 | "**It re-executes evidence.** Claims in a reasoning log's evidence section must reproduce at that commit; the auditor re-runs samples. This is what makes the evidence sections falsifiable rather than decorative." | **PERFORMED-ONCE** | `AUD-0001-g0-retro.md` §5, five re-executions RX-1…RX-5, 2026-08-01, `J-auditor-0001`. Zero since — the present tense is unearned for the build phase. This report is the second instance in the program's history. |
| C-29 | §1.5 · 234–237 | "Because the auditor cannot write into shared packets, its verdicts on those packets are recorded in its own committed report, and the orchestrator transcribes them into the packet under its own identity" | **REVIEW-ENFORCED** | The prohibition half is machine-checked (C-25); the transcription duty is not. Its authority route is `PROTOCOL.md`:72–78 (ADR-0003 auditor exception) and §7:258–262. Performed for gate signatures (e.g. `1af9e4c`, `9b6cec4`). |
| C-30 | §1.5 · 244–248 | "The sponsor may deliberately plant a process violation … A missed canary is a critical finding against the auditor. The mechanism is documented; the instances never are." | **REVIEW-ENFORCED** | Documented at `docs/SPONSOR.md` ("You may occasionally plant a deliberate process violation … never document the instances") and `agents/charters/auditor.md`:36, :61. No instance is discoverable by construction; the auditor recorded finding none in-window at `claude_auditor_agent.md`:250–252. |
| C-31 | §1.6 · 262–263 | "**the program-state file** — the live picture: current milestone, open work, gate status, pending escalations…" | **REVIEW-ENFORCED** | `tasks/BOARD.md` exists and is maintained by convention (`PROTOCOL.md`:379–382). The "live" property demonstrably decayed and needed a census: `claude_orchestrator_agent.v02.md`:120 records "WO-0044 (a real packet round never rowed), and WO-0048/0052/0053" missing. |
| C-32 | §1.6 · 264–265 | "**a journal index** — one row per log with its last entry and a one-line summary, refreshed at boundaries as a navigation aid." | **FALSE** | `agents/journals/INDEX.md` was last touched at `550df53` (2026-08-01, G0). It still reads "rtl_lead … Not yet activated (first spawn: M2)" and "dv_lead … Not yet activated" while dv_lead is eleven volumes deep, and "auditor … J-auditor-0003" against a true `J-auditor-0022`. It predates the volume-chain era entirely. Letter-compliant on "at boundaries"; materially false as a description of a live aid. |
| C-33 | §1.6 · 269–270 | "This is exercised once mid-program as a drill — killed and rehydrated on purpose." | **FALSE** | Zero occurrences of a performed drill in 26 journal volumes, `tasks/BOARD.md` or `docs/gates/**` (grep for `drill`/`rehydrat*` returns only forward-looking discussion and `PROTOCOL.md`:387 — "deliberately exercised once mid-Phase 1", future tense). Phase 1 has reached its first module PASS (`SO-xgmii_rx_64.md`, 2026-08-11) with no drill. By the document's own next sentence — "an untested recovery procedure is a hypothesis" — the recovery claim may not currently be made. |

### §2 — The constitution and its enforcement

| # | Section · lines | Exact quote | Posture | Evidence |
|---|---|---|---|---|
| C-34 | §2 · 282–283 | "There is one shared rules document — the **protocol** — that every agent reads before acting." | **REVIEW-ENFORCED** | Prompt-surface only; see C-17. |
| C-35 | §2 · 284–285 | "It is amended only by the procedure in §2.7, and only the orchestrator commits it." | **MACHINE-CHECKED** (second limb) | `policy.sh` grants no non-orchestrator agent any `agents/` path except `agents/handoffs/*`; probed `architect_docs_lead→agents/PROTOCOL.md` is outside its `docs/*` allow-list. Confirmed in history: all 8 commits touching `agents/PROTOCOL.md` are `Agent: orchestrator`. First limb ("amended only by the procedure") is REVIEW-ENFORCED — C-69. |
| C-36 | §2 · 290–292 | "**Traceability** — for any two commits, the diff between them shows both the change and, adjacent in the same diff, the responsible agent's own explanation of it." | **MACHINE-CHECKED** | R2 (coupling) + R4 (files-list set-equality) together: `agent_commit.sh`:94–95, :184–196; `check_journals.sh`:141, :183–191. This is the property the whole rule set buys, and it holds. |
| C-37 | §2.1 · 298–300 | "Every commit … must also carry a pure end-of-file append to that agent's own reasoning log containing a new entry. Work without an entry is refused." | **MACHINE-CHECKED** | `agent_commit.sh`:94–95 ("no staged append … (R2 — work without journal)"); `check_journals.sh`:141. Self-test S2. |
| C-38 | §2.1 · 300–301 | "An entry without work is allowed only when explicitly marked as such." | **MACHINE-CHECKED** | `agent_commit.sh`:96–102; `check_journals.sh`:143–149 (`Journal-Only: true`). Self-test S9, S17. |
| C-39 | §2.1 · 303–305 | "The commit message ends in fixed metadata: the agent's name, the work-order identifier or `none`, and the entry id." | **MACHINE-CHECKED** | Written at `agent_commit.sh`:220–228; re-parsed and uniqueness-checked at `check_journals.sh`:62–78 (final trailer block only; duplicates refused). Self-test S23, S26. |
| C-40 | §2.1 · 318–320 | "For seats with narrow write scopes, one-agent-per-commit falls out of the scope rules automatically — a commit physically cannot mix two scoped agents' files." | **FALSE** | The scopes are **not disjoint**. `policy.sh` grants `agents/handoffs/*` to `architect_docs_lead` (:176), `rtl_lead`/`rtl_lead_md` (:181), `dv_lead` (:186), and all four workers (:194–213); `libs/*`+`top/*` to both `rtl_lead` and `rtl_module_dev`; `test/*` to `dv_lead`, `tb_writer` and `formal_dv`; `tools/*` to `dv_lead` and `data_wrangler`. A commit staging two handoff packets authored by two different leads passes R7 under either identity. The emergence is real only for disjoint pairs, and the document states it universally. |
| C-41 | §2.1 · 320–322 | "For the orchestrator, whose scope is everything, correct splitting is enforced by audit and not by machine. The constitution says so in those words." | **PLANNED** (enforcement limb) | The documentary limb is **true**: `PROTOCOL.md`:165–171 says it in those words. The audit limb is owed — no orchestrator-splitting audit exists after `AUD-0001` §6 (2026-08-01). See C-11. |
| C-42 | §2.2 · 328–332 | "…thereafter grows *only* by whole entries appended at the end. Nothing above the last byte is ever edited. … The commit gate verifies this byte-wise: the version at the previous commit must be a prefix of the version being committed." | **MACHINE-CHECKED** | `is_byte_prefix` `policy.sh`:268–276; invoked `agent_commit.sh`:152 and `check_journals.sh`:159. Journal deletion/rename refused `agent_commit.sh`:63–64, `check_journals.sh`:101–102. Self-test S4, S12, S14. |
| C-43 | §2.2 · 330 | "No agent writes another agent's journal." | **MACHINE-CHECKED** | R8: `agent_commit.sh`:66–73 and :104–116 (foreign journals only as brand-new volume-01 seeds of a chainless agent, zero entries); `check_journals.sh`:104–121. Self-test S8, S13, S34. |
| C-44 | §2.2 · 347–350 | "each new volume carries, in its frozen header, the previous volume's path, its SHA-256 and its byte count" | **MACHINE-CHECKED** (two of three fields) | Path and SHA-256 verified: `agent_commit.sh`:130–136, `check_journals.sh`:229–235; plus `Volume` and `Continues-from`. **`Previous-volume-bytes` is verified nowhere** — `grep -rn "Previous-volume-bytes" scripts/` returns only the self-test's fixture generator (`test_protocol.sh`:71). It is testimony sitting in a list of structure, in a document that at §5.4 demands a record "say which of its fields is testimony and which is structure". |
| C-45 | §2.2 · 349–350 | "every earlier volume is frozen and any change to it breaks the successor's recorded hash" | **MACHINE-CHECKED** | Whole-chain re-verification per commit at `check_journals.sh`:216–251 (gapless 01..N, back-link path, sha256 over the bytes at that commit, `Continues-from`, contiguous ids); staging-side at `agent_commit.sh`:84–91 and :118–141. Self-test S29–S34, S36 (a flipped frozen byte turns both `verify_journal_chain.sh` and CI red). |
| C-46 | §2.2 · 356–359 | "There are two size thresholds: a soft one that warns and a hard one that refuses" | **MACHINE-CHECKED** (one surface only) | `agent_commit.sh`:177–182 (`JOURNAL_HARD_MAX` refuses, `JOURNAL_SOFT_MAX` emits `WARN-JOURNAL`), parameters at `policy.sh`:13–14. **`check_journals.sh` contains no size check at all.** This is the exact both-surfaces asymmetry C-55 declares to be "itself the defect", and the reason C-56 is FALSE. |
| C-47 | §2.3 · 363–365 | "The scope table is part of the constitution, and it is checked at commit time and re-checked in continuous integration." | **MACHINE-CHECKED** | `agent_commit.sh`:213–217; `check_journals.sh`:193–198; CI `.github/workflows/journal-check.yml`:24–25. Self-test S6, S19, S20, S25. |
| C-48 | §2.3 · 365–367 | "Read access is unrestricted except where a charter says otherwise, and where it does, the document says plainly that the restriction is enforced by prompt and audit rather than by the filesystem." | **REVIEW-ENFORCED** | Accurate as written: `PROTOCOL.md`:225–228 says exactly that, and `agents/charters/auditor.md`:100 carries the "Honest-enforcement note". The audit half of the compensation is nonetheless owed — C-23, C-51. |
| C-49 | §2.3 · 369–371 | "the implementation line cannot stage tests, the verification line cannot stage implementation, the auditor cannot stage anything but its own reports" | **MACHINE-CHECKED** | As C-21 and C-02. |
| C-50 | §2.3 · 371–372 | "and each worker is narrowed further by its packet" | **REVIEW-ENFORCED** | Sits inside the sentence that says scopes are "checked at commit time and re-checked in continuous integration", but no per-packet narrowing exists in `policy.sh`: `rtl_module_dev` is granted all of `libs/*` and `top/*` (:194–198) — probed `rtl_module_dev→libs/anything/at/all.ml` ALLOW. The narrowing lives in the work order and is review-enforced. A document that names its residues leaves this one unnamed. |
| C-51 | §2.3 · 380–383 | "The program states this rather than implying coverage it does not have, and compensates with three things it can check: what a packet contained, what an agent recorded reading, and an auditor that samples both." | **PLANNED** (third leg) | Legs one and two are real artifacts (packet `Context provided` sections; journal `Inputs`). Leg three has not run over the build phase — C-23. Two of three checkable things are checked by nobody. |
| C-52 | §2.4(a) · 397–401 | "the program mints no machine rule at all — the posture is declared **review-enforced**, and the document says so in the clause itself" | **REVIEW-ENFORCED** | True, and the complete set is three clauses: `PROTOCOL.md`:329–330 (§7 Mutation record), :357–359 (§7 Lessons harvest), :427–429 (§10 R-SEAL-1). Bears on C-126, where PROCESS generalizes three clauses into "each clause". |
| C-53 | §2.4(a) · 399–401 | "A script may emit an advisory note, and the clause states in the same breath that the note's absence proves nothing." | **PLANNED** | `PROTOCOL.md`:430–431 contemplates `WARN-SEAL`; `grep -rn "WARN-SEAL" scripts/ .github/ tools/` → **absent**. Its implementation exists only as proposed shell inside `docs/adr/ADR-0016-…md`:484. The clause's honesty ("its absence is not a clearance") is real; the note it qualifies does not exist. |
| C-54 | §2.4(b) · 408–412 | "Where the thing being checked is an agent's own attestation and the record of it is already frozen, a blocking check makes a legitimate correction impossible. **A warning is right there**" | **PLANNED** | The designed class has exactly one implemented member, `WARN-JOURNAL` (`agent_commit.sh`:181), and that one is a size rule, not testimony. The testimony case that motivated the corollary — timestamps — has no warning: `WARN-STAMP` was designed with measured bands at `J-auditor-0020` (2026-08-11) and **not built**; `scripts/` has been unmodified since `678948b` (2026-08-04). |
| C-55 | §2.4 · 421–423 | "*Corollary, adopted after a measurement.* If a check exists on one surface — the local commit path — and not on the other — the re-check over pushed history — the asymmetry is itself the defect. Both surfaces or neither." | **PERFORMED-ONCE** | Adopted and applied once: the blob gate was mirrored into CI as R11 (`check_journals.sh`:200–210, ADR-0017 §6.6/D6, self-test S38). It was **not** applied to the journal size cap in the same act — C-46 — so the corollary stands with a live unrepaired instance inside the very rule family that minted it. |
| C-56 | §2.5 · 427–429 | "Every rule the commit script enforces is re-verified by continuous integration over the entire pushed history, not merely over the newly pushed range." | **FALSE** | The commit script enforces the R10 size thresholds (`agent_commit.sh`:177–182); `check_journals.sh` has no size check (`grep JOURNAL_HARD_MAX scripts/check_journals.sh` → no hit). A `git commit --no-verify` over-append passes CI clean. Everything else in the claim is true — full-history re-check is real at `journal-check.yml`:24–25 — which is why the unqualified "every" is the defect. |
| C-57 | §2.5 · 429–430 | "A locally bypassed check — and every commit tool has a bypass flag — still fails before merge." | **MACHINE-CHECKED** (one named exception) | Proven by self-test S11 ("raw git commit caught by check_journals.sh", R2\|R6) and S12 (history rewrite caught, R3) and S38 (parameter-override evasion caught by R11). The exception is the size cap — C-56. |
| C-58 | §2.5 · 439–444 | "force pushes are prevented by branch protection configured in the hosting platform … The program names this as a one-time sponsor duty, on a gate checklist, and states plainly that until it is done the no-rewrite guarantee is convention rather than enforcement." | **PERFORMED-ONCE** | The naming is real (`PROTOCOL.md`:205–208, 213–218) **and the duty was discharged**: `docs/gates/G0-checklist.md`:17 — item 9, ✅, "Sponsor configured 2026-08-01 (rulesets protect-history all-branches + main-requires-ci); rejection verified by live fire on both branches — J-orchestrator-0011". Re-proved in anger on a transient ref: ADR-0019 §1.2 — `git push --force-with-lease` "the repository rules refused it", `J-auditor-0015`. The document undersells its own strongest evidence: it presents the dependency as open when the record closed it twice. |
| C-59 | §2.6 · 457 | table row: "One agent per commit \| Mixed-agent changes are split into sequential commits; the mechanical invariant is one journal append per commit" | **MACHINE-CHECKED** (as qualified) | The qualification is exact: one own-chain append per commit is enforced at `agent_commit.sh`:84–91 and `check_journals.sh`:130–139 (self-test S33). The unqualified splitting is not — C-04, C-40, C-41. |
| C-60 | §2.6 · 458 | "Coupling \| Work must stage a pure append to the responsible agent's journal; journal-only commits are legal but must be marked" | **MACHINE-CHECKED** | C-37, C-38. |
| C-61 | §2.6 · 459 | "Append-only \| The previous version of the journal must be a byte prefix of the staged one; journal deletion and renaming are always refused" | **MACHINE-CHECKED** | C-42. |
| C-62 | §2.6 · 460 | "Files-list equality \| The entry's declared file list must set-equal the commit's changed paths, excluding the author's own journal" | **MACHINE-CHECKED** | `agent_commit.sh`:184–196; `check_journals.sh`:183–191. Self-test S5, S18. |
| C-63 | §2.6 · 461 | "Monotonic entry ids \| The new entry's number is exactly the previous one plus one" | **MACHINE-CHECKED** | `agent_commit.sh`:158–171 reading `chain_last_entry_num` across the whole chain (`policy.sh`:232–240); `check_journals.sh`:165–181 and the chain-contiguity sweep :245–251. Self-test S7, S15, S30. |
| C-64 | §2.6 · 462 | "Trailers \| The fixed metadata block must be present and well-formed; protected keys cannot be shadowed or duplicated" | **MACHINE-CHECKED** | `agent_commit.sh`:33–38 (protected keys rejected as extra trailers); `check_journals.sh`:62–66 (duplicate refusal) and :58–62 (final trailer block only). Self-test S21, S23, S26. |
| C-65 | §2.6 · 463 | "Path isolation \| Every staged non-journal path must be in the committing agent's scope" | **MACHINE-CHECKED** | C-47. |
| C-66 | §2.6 · 464 | "Foreign journal seeding only \| Another agent's journal may be staged only as a newly created, entry-free file (onboarding); modifying an existing one is always refused" | **MACHINE-CHECKED** | C-43. |
| C-67 | §2.6 · 465 | "Serialized history \| One working branch, no per-agent branches, no rebases of pushed history, no force pushes; merges to the trunk must be trivial and are verified as such" | **FALSE** (as attributed) | The row sits under "The commit script enforces a small numbered set" (452). Merge triviality is verified — but in **CI**, not the commit script (`check_journals.sh`:41–56); and **no force-push, no-rebase and one-branch are enforced by no script at all** — they rest entirely on the out-of-repo branch protection of C-58. Two of the row's four clauses are enforced somewhere other than where the sentence puts them, and one is enforced outside the repository. |
| C-68 | §2.6 · 467–470 | "**The files-list rule deserves its own note** … The check is set equality: an entry cannot claim files it did not touch, nor silently touch files it did not claim. Deletions count as touches." | **MACHINE-CHECKED** | C-62; deletions counted because `--name-status --no-renames` feeds the set on both surfaces (`agent_commit.sh`:53, `check_journals.sh`:88–91). |
| C-69 | §2.7 · 479–486 | "Any change to the constitution, to a charter, or to the enforcement scripts requires three things: 1. a **numbered decision record** … 2. an orchestrator journal entry … 3. if the change alters enforcement semantics, an updated case in the enforcement self-test" | **REVIEW-ENFORCED** | No script tests any of the three. Item 2 is machine-adjacent (R2 forces *an* entry, never that it accepts anything). The record shows the procedure working (ADR-0016/0017 → PROTOCOL diffs → self-test cases S27–S39) and shows its debt: ADR-0019 §7 diffs and §8 test cases are owed and unapplied while the rule is in force. |

### §3 — The artifact grammar

| # | Section · lines | Exact quote | Posture | Evidence |
|---|---|---|---|---|
| C-70 | §3 · 508–509 | "Everything that moves between seats is a versioned file. Nothing that matters happens only in conversation." | **FALSE** | WO-0048, WO-0051, WO-0052 and WO-0053 have **no packet file at any commit** — verified: `git log --all -- 'agents/handoffs/WO-0048*'` (and 0051/0052/0053) returns empty — while being live ids in journal `task:` headers and board rows. WO-0048 was a repo-wide cascade; WO-0051/0052 were the ADR-0016/0017 constitutional-amendment rounds; WO-0053 the first journal rotation. This audit round is itself dispatch-only. The dispatch-only class is institutionalized and unnamed. |
| C-71 | §3.1 · 519–520 | "Its structure is machine-checked; the quality of its narrative is enforced by audit sampling." | **PLANNED** (second limb) | First limb true and machine-checked: header line, one-entry-per-append, monotonic id, `Files-in-this-commit` presence and set-equality (C-62, C-63, C-73, C-74). Second limb is the posture of this row: narrative sampling ran once, `AUD-0001` §4 (2026-08-01), and never since — C-23. The sentence is exactly right about the split and silently wrong about the tense of its second half. |
| C-72 | §3.1 · 523–539 | the eight named sections — "**Trigger** … **Inputs** … **Reasoning** … **Actions** … **Evidence** … **Outcome** … **Open-questions** … **Files-in-this-commit**" | **REVIEW-ENFORCED** (seven of eight) | `grep -n "Reasoning\|Trigger\|Open-questions\|### Inputs\|Evidence" scripts/policy.sh scripts/agent_commit.sh scripts/check_journals.sh` → **no hit**. Only `### Files-in-this-commit` is machine-checked (`policy.sh`:262–266). An entry with no Reasoning section commits clean. `PROTOCOL.md`:102–108 states this correctly; PROCESS's presentation does not repeat the caveat at the list. |
| C-73 | §3.1 · 541 | "Entry ids are strictly monotonic per journal." | **MACHINE-CHECKED** | C-63 — and stronger than the sentence claims: monotonic per **chain**, across volumes (`policy.sh`:232–240, ADR-0017 §6.3). |
| C-74 | §3.1 · 541–544 | "An entry body may never contain a line that looks like its own journal's entry header at the start of a line … because the parsers are deliberately simple and would count such a line as a new entry." | **MACHINE-CHECKED** | Enforced as a side effect of the exactly-one-header rule: `agent_commit.sh`:162–164, `check_journals.sh`:168–170. Self-test S15. |
| C-75 | §3.1 · 557–560 | "*Anonymized pattern.* The rule that citations must be re-executable was reinforced by an audit that re-ran a sample of them and found a small number false — not fabricated, but decayed" | **PERFORMED-ONCE** | `AUD-0001-g0-retro.md` §5 (RX-1…RX-5) and finding AUD-0001-F5 ("Journal Evidence cites artifacts that do not survive in git"), 2026-08-01, `J-auditor-0001`. |
| C-76 | §3.2 · 578–579 | "Packet numbers are allocated by the sole committer at first commit; drafts in flight use a placeholder." | **REVIEW-ENFORCED** | No instrument allocates or checks numbers. Outcome contradicts the "by construction" gloss — C-08. |
| C-77 | §3.2 · 574–576 | "The review verdict itself is a packet (accept, or a numbered defect list with file, line, and the specification clause violated) signed with the reviewer's journal entry id." | **FALSE** | No `RV-*.md` file exists in `agents/handoffs/` or anywhere in history (`git log --all -- 'agents/handoffs/RV-*'` → empty; 0 files in tree), though `PROTOCOL.md`:56 defines the type. The practice is a `RV-XXXX-VERDICT` section appended to the work order's own Return log (e.g. `WO-0040_tb-m03-family-d-fcs.md`). The practice is sound; the described form is fictional. |
| C-78 | §3.2 · 590–592 | "**The context section is a control, not a convenience.** Because blinding is enforced by what a packet contains, the packet states what was handed over. A packet that must omit something says so." | **REVIEW-ENFORCED** | Evidenced: `WO-0040_tb-m03-family-d-fcs.md`:254 "## 7. What you may NOT read". The control is real and the enforcement is the packet's own text plus audit — the audit leg being C-23. |
| C-79 | §3.3 · 604–610 | "**a seal is a file in the commit that claims it, or it is not a seal.** … unless that same commit stages the artifact holding the withheld result, so that the seal appears in the commit's own declared file list." | **REVIEW-ENFORCED** | Deliberately so, and the constitution says it in its own clause: `PROTOCOL.md`:427–429 — "*Enforcement*: **review-enforced** … it is deliberately **not** an `R1`–`R9` commit rule, because distinguishing a claim from a quotation is not a lexical test." Thirteen `*-SEALED-predictions.md` files in `agents/handoffs/` are the practice. |
| C-80 | §3.3 · 621–624 | "A sealed prediction file carries: … the commit at which it was frozen, **and its own hash at that commit** — so that byte equality between freeze and unsealing is checkable by anyone." | **FALSE** | The record's seals neither have nor could have the field. `agents/handoffs/WO-0077_family-k-mutation-campaign-SEALED-predictions.md` states it outright: "**Frozen against**: the commit that stages this seal and its packet … **I cannot state its hash: I never run git (PROTOCOL §2), and it has none until the orchestrator creates it.**" `WO-0039_…-SEALED-predictions.md` carries base bench SHA `6bd7e5a` + freezing entry `J-dv_lead-0035`, no freeze-commit id, no self-hash — and names the real mechanism: "`git diff` against the freeze commit is the check", plus the undocumented **second-copy discipline** ("Everything committed here is also committed, in substance, in `J-dv_lead-0035` … if either is later edited to fit a result, the other exposes it", §0). The document invents a field the grammar cannot have and omits the two mechanisms that actually do the work. |
| C-81 | §3.3 · 624–626 | "Nothing below its header is ever edited: a wrong prediction is not amended, it is adjudicated, and it dies on the record." | **REVIEW-ENFORCED** | No instrument; R3 protects journals, not packets. Practice is exact and self-disclosing: `WO-0039_…-SEALED-predictions.md` — "**This state line is the only line of this file that has been altered since the freeze**". |
| C-82 | §3.4 · 646 | "Severities are fixed — critical, major, minor — and the grading is part of the filing, not of the response." | **FALSE** | Four grades are in use. `docs/reports/audit/AUD-0001-g0-retro.md`:19 — "Tally: **1 CRITICAL, 7 MAJOR, 7 MINOR, 2 NOTE** (17 findings)". *(Bob F9 quoted "1 CRITICAL, 5 MAJOR, 7 MINOR, 4 NOTE" — that is the superseded pre-correction line, corrected in-file at `J-auditor-0002`; the count of grades, which is what the claim turns on, is four either way.)* |
| C-83 | §3.4 · 647–648 | "Critical findings from the auditor reach the sponsor verbatim as their own escalation class (§4.6)." | **PERFORMED-ONCE** | AUD-0001-F17 (CRITICAL) was routed as E4 and dispositioned: `claude_orchestrator_agent.md`:362–373 (`J-orchestrator-0009`, 2026-08-01, "G0 BLOCKED on F17"), closed at `J-auditor-0003`/AUD-0002. One instance in the program's history; the class is real and lightly exercised. |
| C-84 | §3.5 · 676 | "Every normative change is signed by a seat that did not write it." | **REVIEW-ENFORCED** | No instrument. Practised for ADR-0016/0017/0018/0020 (countersignature rounds `J-auditor-0021`, `J-auditor-0022`, dv_lead and rtl_lead chains). Not practised for `docs/PROCESS.md` itself (C-20) — the document asserting the rule is the counterexample to it. |
| C-85 | §3.5 · 698–702 | "The remedy is a **delta-signature**: the moved clauses are named, the seats they re-owe are named, and the traffic is recorded as *owed* until it is paid. … the accepting seat may proceed with the traffic recorded as owed, and **may not record owed traffic as paid**." | **REVIEW-ENFORCED**, performed | `J-auditor-0022` (2026-08-11T19:00Z) — "The delta-signature paid on the limb that binds sixty-one dispositions". The rule is carried by the accepting seat's own discipline; no instrument reads an owed ledger. |
| C-86 | §3.5 · 710–715 | "*Anonymized pattern…* In one exchange the constrained party signed and, in the same entry, filed a major finding against the clause it was signing — and separately offered a limb that applied the amendment's own premise to a case the amendment had exempted, at its own cost." | **PERFORMED-ONCE** | `J-auditor-0021` (2026-08-11T17:50Z): "Both clauses countersigned and neither blocked", carrying `FINDING F-0021-3` ("The one thing (b.3) does not say, which its two neighbours both say") and `FINDING F-0021-1` in the same entry. |
| C-87 | §3.6 · 738–743 | "**The instrument does not edit the file it governs.** Where a record amends the constitution, the new constitutional text is written *in the record* as source text, and applied to the constitution by the seat that owns that file, in its own commit, citing the record." | **MACHINE-CHECKED** (the ownership half) | Only the orchestrator can stage `agents/PROTOCOL.md` (C-35), so an ADR author physically cannot apply its own constitutional diff. The *writing-it-in-the-record* half is review-enforced and practised — ADR-0019 §7.1–§7.3 hold the owed diffs as source text. |
| C-88 | §3.6 · 746–749 | "**Status is dated.** A record states, per clause, what is in force at its own landing and what act would change that." | **REVIEW-ENFORCED**, with a live instance | Practised well by ADR-0016/0017/0020. ADR-0019 is the live test: "**Status**: **PROPOSED**, and the rule it records **has been in force since `J-orchestrator-0218`** (2026-08-10)" — the form is honoured exactly while the instrument stays unaccepted, which is what makes C-07 and C-100 measurable at all. |
| C-89 | §3.7 · 763–765 | "Every signature is a reference to a journal entry, so governance itself is diffable, and each entry must state in the signer's own log that it signs that item." | **REVIEW-ENFORCED**, evidenced | `PROTOCOL.md`:258–262. Practised: `docs/gates/P1-spec-freeze-checklist.md`:28–31 — every batch row signed "**SIGNED** (J-dv_lead-0003 …)". No script parses a checklist. |
| C-90 | §3.7 · 770–771 | "Their preconditions are stated in the constitution as clauses, and the checklist quotes those clauses verbatim rather than paraphrasing them." | **REVIEW-ENFORCED**, with a recorded failure | The failure is the exhibit at C-92; the repair is `docs/gates/P1-module-ready-checklist.md` §0.2. |
| C-91 | §3.7 · 775–777 | "**A gate file states no condition its cited source does not contain.** This is written at the top of the checklist itself, because the family has failed exactly there." | **PERFORMED-ONCE**, verified in place | `docs/gates/P1-module-ready-checklist.md`:41 — heading "### 0.2 This file states no condition its cited source does not contain", and :58 "**This file adds no condition of its own.**" Landed at `61e0c76` (2026-08-11, `Agent: architect_docs_lead`). |
| C-92 | §3.7 · 779–784 | "*Anonymized pattern, and it is the program's most-cited conviction.* A reusable gate block extended a constitutional gate condition to a second kind of artifact *while citing the constitution for the extension*. … **the packet quoted its source accurately; the source was wrong.**" | **PERFORMED-ONCE** | `docs/gates/P1-module-ready-checklist.md`:46 — "The over-reach produced `FINDING SO-5`, cost a sign-off two…"; repair narrated at `J-architect_docs_lead-0037` (2026-08-11T17:05Z, `claude_architect_docs_lead_agent.v03.md`:965, :1263 "**The over-reach is gone from line 5 and PROTOCOL is untouched**"), landed `61e0c76`. |
| C-93 | §3.7 · 786–788 | "**Signers cannot stage the checklist.** Because write scopes forbid it, the orchestrator transcribes every signature." | **FALSE** | Mechanically: `policy.sh`:174–178 gives `architect_docs_lead` all of `docs/*` with only `docs/reports/audit/*` and `docs/reports/latency/*` carved out — probed live, `architect_docs_lead→docs/gates/P1-module-ready-checklist.md` **ALLOW** — and the architect is a gate signer. In practice: four commits trailered `Agent: architect_docs_lead` stage files under `docs/gates/` — `61e0c76` (which stages `P1-module-ready-checklist.md` **itself**), `43c0087`, `8734c10`, `ec5d906`. The real control is a convention written inside the checklist ("**no box in this file is checked by its author**", `P1-module-ready-checklist.md`:14) — review-enforced, not scope-enforced. |
| C-94 | §3.8 · 808–811 | "A **sign-off** is the verification line's verdict on one artifact: pass or fail, with the suite named, the exact commands to reproduce it, the requirement-to-test mapping with gaps declared, the stress-test results, the seeded-defect dispositions, and open defects. It is a merge precondition and it is relayed verbatim." | **PERFORMED-ONCE** | One sign-off exists: `agents/handoffs/SO-xgmii_rx_64.md` (2026-08-11), and it carries every named element — §2.1 row census, §2.2 mutation era, §2.6 unreachable-instrument register, §2.7 open defects, §2.8 traceability matrix, §2.9 CI evidence, §2.10 line-rate stress. The described form is real; the sample size is one. |
| C-95 | §3.8 · 812–814 | "**A sign-off may say FAIL, and a FAIL is preserved.** Failing verdicts are not withdrawn when the defect is fixed; the repair is recorded beside the verdict." | **PERFORMED-ONCE** | `SO-xgmii_rx_64.md`:14 — "*(Round 2's verdict was `FAIL` on **two** — `SC-2` and `SC-12`. Round 3's was `FAIL` on…)*" preserved inside the round-4 PASS. Four `BUG-000{1,2,3,4}` packets carry the defect side. |
| C-96 | §3.8 · 822–828 | "*Anonymized pattern.* A verification lead reported a campaign in five columns rather than the ratio the constitution asked for … The packet was right and the rule was wrong; the rule moved to where the practice already was." | **PERFORMED-ONCE** | `docs/adr/ADR-0020-the-gate-asks-the-suite-not-the-scoreboard.md`:249 — row **G1-c**: "§10's *\"reports kills N/N\"* becomes *reports the disposition of every seeded mutation…* … **ADOPTED** (§4). The rule moves to where the practice already is." ACCEPTED at `J-orchestrator-0261`. |
| C-97 | §3.9 · 842–845 | "So, on a fixed cadence, an independent seat authors **defect manifests** … the orchestrator applies them transiently and runs the suite" | **FALSE** (both limbs) | *Cadence*: the record's control is per-module event sequencing — `PROTOCOL.md`:403–406, "for each module, the campaign runs **after rtl_lead's `RV-` ACCEPT and before dv_lead may issue `SO-` PASS**". *Transient application*: ADR-0019 §1.1, measured — the campaigns run as plain `git commit` + push of never-merged `mut/*` refs, "**85 transient refs across 17 prefixes**", "because the CI-only toolchain makes a local run impossible" (ADR-0005). Verified independently: 85 `mut/*` heads on origin. PROCESS contradicts itself 24 lines later at 866–870, which describes the pushed-ref model correctly. |
| C-98 | §3.9 · 849–851 | "**The subject under test is the test suite, not the artifact.** The campaign brief says so explicitly" | **REVIEW-ENFORCED**, evidenced | Carried in every campaign packet and its seal (e.g. `WO-0039_…-SEALED-predictions.md` §0). No instrument. |
| C-99 | §3.9 · 853–857 | "**The seeder never operates the repository; the operator never authors the evidence.** … because it does not push." | **REVIEW-ENFORCED**, in force 2026-08-10 | ADR-0019, **still PROPOSED**, is the authorizing instrument; the rule became standing at `J-orchestrator-0218` after `FINDING WO-0074-A1` (MAJOR, auditor) was ruled ACCEPTED against the orchestrator's own dispatches. Before that: WO-0073 plus three prior deviations (C-07). PROCESS presents a one-day-old, not-yet-ratified rule as standing discipline. |
| C-100 | §3.9 · 866–870 | "**Mutated artifacts never enter history.** … the permanent history contains no commit in which the artifact is deliberately wrong. Where infrastructure forces a pushed ref … the ref is marked and never merged" | **REVIEW-ENFORCED**, and re-executed true today | No instrument prevents a `mut/*` merge. Measured this round: of 92 `mut/*` refs visible to this checkout, **0 are ancestors of HEAD** (`git merge-base --is-ancestor` over each). ADR-0019 §1.1: "**None has ever been merged**". The property holds; nothing but discipline holds it. |
| C-101 | §3.9 · 872–874 | "**No agent in the graded line is running while a manifest is applied.** The \"report, never repair a suspected seeded defect\" clauses in the builder charters are the safety net for a sequencing error, not the normal case." | **REVIEW-ENFORCED** | Orchestrator sequencing discipline; charter clauses are the net (`agents/charters/auditor.md`:100 names the same residue). No instrument. |
| C-102 | §3.9 · 876–878 | "**The seeder reads from an allowlist.** The campaign names the complete set of paths the seeder may read; everything else is out of bounds by construction." | **REVIEW-ENFORCED** | "by construction" is the overstatement — no read denial exists (C-22). The allowlist is real and packet-borne: `WO-0077_…-SEALED-predictions.md` header — "under `WO-0077` §9's allowlist, **all of `agents/**` is out of bounds for the campaign's duration**". |
| C-103 | §3.9 · 883–886 | "**What is sealed is not the existence of the campaign but the discriminating part**: which units must go red, which must stay green, and the exact expected failure messages." | **REVIEW-ENFORCED**, evidenced | `WO-0077_…-SEALED-predictions.md` standing rules 2–4 (first-assertion-to-speak message derivation; inequality-with-direction; GREEN BY BLINDNESS). |
| C-104 | §3.9 · 890–936 | the thirteen scoring bullets, from "**The question is present-tense.**" through "**A floor on the number of seeded classes** — at least three, spanning distinct defect classes — measured before any equivalence exclusion" | **REVIEW-ENFORCED** (block) | These restate `PROTOCOL.md` §7 **Mutation record** (b.1)–(b.4), lines 268–330, and §10's floor at 407–409. The constitution declares their posture in the clause itself: `PROTOCOL.md`:329–330 — "*Enforcement*: review-enforced, like §10 — no `R`-rule is minted and no script changes, so §11(3) owes no test case." **No script reads a mutation tally, a sealed column, an equivalence proof or the floor.** The architect may stamp all thirteen with one citation. |
| C-105 | §3.10 · 953–954 | "Every sign-off and every gate carries a **lessons harvest**, and it is a precondition of the gate rather than a follow-up to it." | **REVIEW-ENFORCED**, performed | `PROTOCOL.md`:357–359 declares the same posture in-clause ("review-enforced, like §10 — no `R`-rule is minted and no script changes"). Practised: `SO-xgmii_rx_64.md`:18, :50, :59 (four harvest notes, dv_lead's first harvest walked `J-dv_lead-0001`→`-0165`); `J-auditor-0019` (the auditor's first, 64 statements); `docs/gates/lessons-harvest-block.md` carries 11 unchecked boxes gating P1-module-ready. |
| C-106 | §3.10 · 979–980 | "Collation is clerical. The collating seat may bounce a defective statement back to its author and may not improve one." | **REVIEW-ENFORCED** | `PROTOCOL.md`:350–356. No instrument. |

### §4 — The operating disciplines

| # | Section · lines | Exact quote | Posture | Evidence |
|---|---|---|---|---|
| C-107 | §4.1 · 1009–1013 | "Before opening a single file for editing, an agent checks the state of the working tree and the current commit … If the tree is dirty in a way the dispatch did not declare, or the commit is not the expected one or a descendant of it, the agent **stops and returns a refusal with the forensic detail**" | **REVIEW-ENFORCED**, performed | Carried in dispatch text and journal `Trigger`/`Actions`. Performed this round: `git status --short` empty, `git rev-parse HEAD` = `6c02f5b`, both recorded above and in `J-auditor-0023`. No instrument enforces it. |
| C-108 | §4.2 · 1026–1032 | "**Outward:** a dispatch names every other agent that may be writing concurrently … **Inward:** if the current commit moves while an agent is working, the agent verifies rather than assumes" | **REVIEW-ENFORCED**, performed | This round's dispatch declared two siblings (dv_lead WO-0082; orchestrator journal/board/site) by name and path. No instrument. |
| C-109 | §4.3 · 1044–1047 | "Protected classes — sign-off packets, defect packets, and every auditor finding — are relayed **unedited** … **The auditor spot-checks relay fidelity on the protected classes.**" | **PLANNED** | Zero spot-checks in the program's history. The auditor's own record: `AUD-0001-g0-retro.md`:247 — "**relay fidelity could not be spot-checked**" (no verbatim-class packet existed yet), and `claude_auditor_agent.md`:252 — "Relay fidelity is untestable so far — no verbatim-class packet has ever been relayed." Verbatim-class packets have existed since (`BUG-0001`…`-0004`, `SO-xgmii_rx_64`) and **no spot-check followed**. The charter duty (`agents/charters/auditor.md`:27) is unpaid. |
| C-110 | §4.3 · 1064–1068 | "*Anonymized pattern, and it is the sharpest one in the record.* A finding about record fidelity was relayed with one word dropped — the relay of a fidelity complaint itself demonstrating the fidelity hazard." | **PERFORMED-ONCE** | `claude_dv_lead_agent.v10.md`:2892 — "**On the dropped word.** The relay wrote *\"dispositioned UNSCOREABLE\"* where I wrote…"; corroborated at `claude_orchestrator_agent.v02.md`:4783 and `claude_architect_docs_lead_agent.v04.md`:2846 ("so the relay could be checked (faithful, one word)"). |
| C-111 | §4.4 · 1071–1073 | "Committed is not safe. Work is durable only once it is pushed, and the discipline is to push at every landing rather than at the end of a session." | **REVIEW-ENFORCED** | No instrument; the orchestrator's habit. Not independently measurable from a checkout without remote comparison, which I did not perform (sampling frame §0.2). |
| C-112 | §4.5 · 1083–1091 | "1. **Preserve the partial as evidence**, outside the working tree. 2. **Discard it from the tree.** … 3. **Derive fresh.** … 4. **Record the incident** in the round's journal entry" | **REVIEW-ENFORCED**, performed | Executed on this very round's predecessor: the prior auditor round was stopped by the sponsor mid-round, its uncommitted work (including a v03 rotation) preserved to the orchestrator's scratchpad as evidence and removed from the tree, and this spawn was told explicitly to derive fresh from `git show HEAD:` and to trust no prior partial. Tree verified clean at precheck. |
| C-113 | §4.6 · 1104–1114 | the six-class escalation table, **E1**–**E6** | **REVIEW-ENFORCED**, partly exercised | Matches `PROTOCOL.md`:361–373 exactly. Exercised: **E1** (`1af9e4c`, P1-spec-freeze sponsor signature transcribed), **E3** (ADR-0004 "sponsor decision, E3, 2026-08-01"; ADR-0015 "Both E3 permission items were **granted**"), **E4** (AUD-0001-F17, C-83). **E2, E5, E6 have never been used.** No instrument routes or counts escalations. |
| C-114 | §4.7 · 1137–1138 | "A single file tells them how to spot-check the whole program by hand in **four commands**." | **FALSE** | `docs/SPONSOR.md` "How to spot-check the org yourself" gives **three** git commands (`git log --oneline`, `git log --grep 'Agent: rtl_lead'`, `git show <commit>`) plus a two-hop document walk (`ORG_CHART.md` → charter → journal tail) plus a CI-tab check. Five bullets, three of them commands. |
| C-115 | §4.7 · 1134–1136 | "one one-time infrastructure setup (the branch protection without which the history guarantee is convention)" | **PERFORMED-ONCE** | C-58: `docs/gates/G0-checklist.md`:17 — configured 2026-08-01, live-fire verified on both branches, `J-orchestrator-0011`. |
| C-116 | §4.8 · 1153–1160 | "a seat declining to act — with grounds, recorded — is a normal and valued result … An instruction that arrives outside the routed channel — from tooling, from an automated prompt, from any source that is not the agent's principal — is declined." | **REVIEW-ENFORCED**, performed | Carried in charters and dispatch text. Performed: `FINDING WO-0074-A1` (the auditor refusing the seeding dispatch before any branch existed, ADR-0019 §1.2); and this round's own instruction to refuse stop-hook commit demands. No instrument. |
| C-117 | §4.8 · 1172–1179 | "*Anonymized pattern.* A round was commissioned to apply six small cures. Five were applied. The sixth was a one-word improvement to a sentence that, since the commissioning, had become live constitutional text … It was stopped, returned as an amendment candidate, and the debt was recorded in the document's own owed-acts ledger." | **PERFORMED-ONCE** | Anchored at `claude_architect_docs_lead_agent.v02.md`:1181 — "and is void under this one; and the sixth, the D(m) bullet itself, is what this…". The stop-and-return shape matches; the ledger row is in the architect's own document. |

### §5 — The failure museum (event claims only)

| # | Section · lines | Exact quote | Posture | Evidence |
|---|---|---|---|---|
| C-118 | §5.1 · 1198–1202 | "A discipline was ruled program-wide after an incident. It held for several rounds. It then decayed … found … by an unrelated audit a working day and twenty entries later. The measurement that followed showed the decayed behavior had been present in **a majority of the record**." | **PERFORMED-ONCE**, with a figure caveat | `J-auditor-0020` (2026-08-11T16:52Z, `claude_auditor_agent.v02.md`), "The census nobody took returns 234 wrong dates". The "twenty entries / one working day" is exact — the entry says a ±60-min band "would have fired at `J-orchestrator-0231` (+85 min) — **twenty entries and one working day before** the bounce that actually caught the decay". "**A majority**" is supported only by the drift bands (±30 min: **393/577 = 68.1%**; ±60 min: **371/577 = 64.3%**), **not** by the headline wrong-date figure (**234/577 = 40.6%**, a plurality). If the revision keeps "majority", it should name the band; if it keeps the 234, it should say plurality. |
| C-119 | §5.1 · 1204–1208 | "the honest framing is: the warning does not buy honesty, it buys **latency** — the next decay is visible in three entries instead of twenty-four." | **PLANNED** | The arithmetic is verbatim from the record (`J-auditor-0020`: "survived three entries and was back to three and a half hours wrong twenty-four…" and "three entries instead of twenty-four"). **The warning does not exist.** `WARN-STAMP` was specified with measured bands and a 0-of-16 false-positive rate in that same entry and never built; `scripts/` is unchanged since `678948b` (2026-08-04), and the census is 2026-08-11. PROCESS states the corollary in the indicative. |
| C-120 | §5.2 · 1220–1229 | "A tally published a column labelled *sealed*. It excluded an item the record itself had declared sealed, and included one that had never been rendered at all … The verdict lines used a qualifier (\"of the *scoreable* classes\") that appeared in no normative document. … It then happened a second time, at a third item, in the same round." | **PERFORMED-ONCE** | `docs/adr/ADR-0020-the-gate-asks-the-suite-not-the-scoreboard.md`:704 — "*appearing in none of the five columns*" and "*a reader of '63 sealed' cannot…*"; the whole ADR is the codification round that found it. ACCEPTED at `J-orchestrator-0261`. |
| C-121 | §5.3 · 1245–1249 | "A finding about record fidelity was relayed accurately but for one dropped word." | **PERFORMED-ONCE** | Same exhibit as C-110. |
| C-122 | §5.4 · 1267–1273 | "Dated rows in a frozen record were measured against the commit dates of the entries they cited. **Eight disagreed** — by a day, by two days, by four. … **No row was edited**: a frozen record is not repaired by rewriting it." | **PERFORMED-ONCE**, and independently reproduced | `J-auditor-0020`: "its §13 note's eight misdated rows reproduce **row for row** — three citing `-0011` and three citing `-0013` off by one day, the `-0023` row by two, the `-0031` row by four, and no ninth." The "by a day, by two days, by four" is exact. The no-edit remedy is the census's own conclusion. |
| C-123 | §5.5 · 1305–1308 | "The rule that came out of it is stated in the constitution as a posture declaration: **each clause says whether it is machine-enforced or review-enforced**, and where it is review-enforced, it says so in its own text rather than in a footnote." | **FALSE** as "each clause" | Exactly **three** clauses in `agents/PROTOCOL.md` carry an in-clause posture declaration: :329–330 (§7 Mutation record), :357–359 (§7 Lessons harvest), :427–429 (§10 R-SEAL-1). Every other clause — including R1's honesty note, §6's read-access residue and all of §5 — states its posture in prose or not at all. The practice is a good one applied three times, described as universal. This is the same over-generalization the council's edit 2 asks PROCESS to fix in itself. |
| C-124 | §5.6 · 1322–1327 | "A long repair arc produced, among other things, a measurement whose instance was underivable until a table landed later in the same arc." | **PERFORMED-ONCE** | `claude_orchestrator_agent.v02.md`:4745 — "The mutual-load-bearing measurement (Q-6's instance underivable…". |
| C-125 | §5.7 · 1348–1364 | the six disguises of self-assessment, "**The graded party as its own reviewer** … **The document that reads its own source into compliance** … **The author of an exclusion being the party the exclusion benefits** … **The permission slip** … **The self-inherited signature** … **The measurement that grades the measurer**" | **PERFORMED-ONCE** (four of six anchored) | Anchored: disguise 2 → C-92 (`FINDING SO-5`, `61e0c76`); disguise 4 → C-87 (ADR-0019 §7 writes diffs the orchestrator applies); disguise 5 → C-85 (`J-auditor-0022` delta-signature); disguise 6 → C-98/ADR-0019 §1.1. Disguise 1 is C-24's episode, **not anchored**. Disguise 3 (the equivalence exclusion recorded by the benefiting party) is codified at `PROTOCOL.md`:312–320 but I did not anchor its incident within this round's frame. |

### §6 — Adopting this

| # | Section · lines | Exact quote | Posture | Evidence |
|---|---|---|---|---|
| C-126 | §6.1 · 1407–1409 | "**The one thing that must not be imported as a claim:** any statement in this document that a control is mechanically enforced. Check it in your own machinery before you repeat it." | **PERFORMED-ONCE** — by this report | The instruction had never been executed against its own machinery before `6c02f5b`. Executing it returns 12 FALSE and 4 PLANNED (§1). The document's own rule, applied to the document, is the finding. |
| C-127 | §6.2 · 1418–1421 | "**Turn on the mechanical layer before the first real work.** Coupling, append-only, path isolation, files-list equality, and continuous-integration re-verification." | **PERFORMED-ONCE** | All five existed before the first module work order: `.github/workflows/journal-check.yml` and `scripts/` land in the M0 range (root `7f54130`..`ef543b0`, audited by AUD-0001 2026-08-01); the first RTL work order is WO-0006 (2026-08-02). The order the document prescribes is the order this program actually used. |
| C-128 | §6.2 · 1422–1424 | "**Configure the out-of-repository dependency and verify it by live fire** — an attempted violation that actually bounces. An unverified protective setting is a belief." | **PERFORMED-ONCE** (twice) | `docs/gates/G0-checklist.md`:17 — "rejection verified by live fire on both branches — J-orchestrator-0011" (2026-08-01); and again in anger, ADR-0019 §1.2 — a `git push --force-with-lease` on a transient ref, "**the repository rules refused it**", `J-auditor-0015`. The document demands this of adopters and never cites its own two instances. |

---

## 3. The fifteen FALSE claims, collected

For the architect's edit 1, in document order. Each is FALSE against a named
artifact, not against an opinion. Two rows (C-67, C-97) carry two false limbs
each and are given one line per limb.

| # | Section | The false part | Contradicting artifact |
|---|---|---|---|
| C-07 | §1.1 | "no other agent runs a commit or a push" | ADR-0019 §1.2 (`J-auditor-0015`, WO-0073) + three prior deviations |
| C-08 | §1.1 | "monotonic by construction" | `WO-0063A`, `WO-0063B`; gaps at WO-0048/0051/0052/0053 |
| C-32 | §1.6 | the journal index as a maintained aid | `agents/journals/INDEX.md` frozen at `550df53` (2026-08-01) |
| C-33 | §1.6 | "This is exercised once mid-program as a drill" | zero occurrences in 26 volumes, BOARD, gates; `PROTOCOL.md`:387 is future tense |
| C-40 | §2.1 | "a commit physically cannot mix two scoped agents' files" | `policy.sh`:174–213 — `agents/handoffs/*`, `libs/*`, `test/*`, `tools/*` are each shared by 2–4 seats |
| C-56 | §2.5 | "Every rule the commit script enforces is re-verified by continuous integration" | `agent_commit.sh`:177–182 vs `check_journals.sh` (no size check) |
| C-67a | §2.6 | "the commit script enforces … merges … verified as such" | the merge check is in `check_journals.sh`:41–56 — CI, not the commit script |
| C-67b | §2.6 | "the commit script enforces … no force pushes" | no script anywhere; branch protection only (C-58) |
| C-70 | §3 | "Everything that moves between seats is a versioned file" | WO-0048/0051/0052/0053 — no packet file at any commit |
| C-77 | §3.2 | "The review verdict itself is a packet" | no `RV-*.md` in the tree or in history |
| C-80 | §3.3 | the seal carries "its own hash at that commit" | `WO-0077_…-SEALED-predictions.md` header: "I cannot state its hash" |
| C-82 | §3.4 | "Severities are fixed — critical, major, minor" | `AUD-0001-g0-retro.md`:19 — four grades incl. NOTE |
| C-93 | §3.7 | "Because write scopes forbid it" | `policy.sh`:174–178 (architect ALLOW on `docs/gates/`); `61e0c76`, `43c0087`, `8734c10`, `ec5d906` |
| C-97a | §3.9 | "on a fixed cadence" | `PROTOCOL.md`:403–406 — per-module event sequencing, after `RV-` ACCEPT, before `SO-` PASS |
| C-97b | §3.9 | "the orchestrator applies them transiently" | ADR-0019 §1.1 — 85 pushed `mut/*` refs; verified independently this round |
| C-114 | §4.7 | "in four commands" | `docs/SPONSOR.md` — three commands + a document walk + a CI-tab check |
| C-123 | §5.5 | "each clause says whether it is machine-enforced or review-enforced" | only `PROTOCOL.md`:329, :358, :428 carry in-clause postures |

**Four of these are new to the record** — they were not among the council's
proven four and were found by this sweep: **C-40** (the scope-disjointness
claim, which is the load-bearing justification for R1 being emergent),
**C-67** (the commit script credited with two enforcements it does not
perform), **C-114**, and **C-123**. C-40 is the most consequential: it is the
sentence that tells an adopter it need not audit attribution for scoped seats.

## 4. The eight PLANNED claims

These are the ones a stateless agent will read as operating reality at every
spawn. Six of the eight route to one unbuilt practice — audit sampling — and
two to unbuilt warnings.

| # | Section | Owed | Where it was promised |
|---|---|---|---|
| C-23 | §1.4(c) | audit of the "inputs" section of each reasoning log | `agents/charters/auditor.md`:24, :100 |
| C-41 | §2.1 | the audit that enforces orchestrator commit-splitting | `PROTOCOL.md`:165–171; `agents/charters/auditor.md`:20 |
| C-51 | §2.3 | "an auditor that samples both" (packet content + recorded reading) | `agents/charters/auditor.md`:24 |
| C-53 | §2.4(a) | the advisory note — `WARN-SEAL` | `PROTOCOL.md`:430–431; `ADR-0016`:484 |
| C-54 | §2.4(b) | the testimony warning — `WARN-STAMP` | `J-auditor-0020`, specified with measured bands, unbuilt |
| C-71 | §3.1 | narrative-quality audit sampling | `PROTOCOL.md`:102–108; `agents/charters/auditor.md`:20 |
| C-109 | §4.3 | relay-fidelity spot-checks on the protected classes | `agents/charters/auditor.md`:27 |
| C-119 | §5.1 | the latency-buying warning the corollary is stated about | `J-auditor-0020` |

**The single fact under six of these rows**: the auditor performed evidence
re-execution, Inputs sampling, vacuity sampling and orchestrator-attribution
audit exactly once, on 2026-08-01, in `AUD-0001-g0-retro.md`, and spent the
entire build phase as a mutation seeder (`J-auditor-0004`…`-0018`). Every
non-mechanical control in `docs/PROCESS.md` routes its residue to that practice.
This report is the second time it has run. That is not a finding against the
seat — the seeding rounds were commissioned — but it is the reason the document's
false claims survived ten days and roughly 85% of the record uncaught, and the
revision should not restate any of these six in the present indicative.

---

## 5. The calibration set: Bob's four, re-executed rather than adopted

The dispatch named four claims proven false by the council's record auditor and
required that I verify them myself.

| Bob | My row | Reproduces? | Difference found |
|---|---|---|---|
| F1 — §3.7 write scopes | **C-93** | **Yes** | None. I probed `agent_may_write architect_docs_lead docs/gates/P1-module-ready-checklist.md` → ALLOW, and confirmed all four architect-trailered `docs/gates/` commits. |
| F3 — §2.5 every-rule-CI | **C-56** | **Yes** | None. `grep JOURNAL_HARD_MAX scripts/check_journals.sh` → no hit. |
| F4 — §1.6 recovery drill | **C-33** | **Yes** | None. |
| F7 — §3.3 seal self-hash | **C-80** | **Yes** | One addition: the record's real mechanism is **two** mechanisms, not one — `git diff` against the freeze commit *and* the second-copy discipline (`WO-0039 …SEALED` §0), which the document omits entirely. |

One of Bob's supporting citations does **not** reproduce as quoted: F9 quotes
`AUD-0001` as "1 CRITICAL, 5 MAJOR, 7 MINOR, **4 NOTE**". The file at `6c02f5b`
reads "**1 CRITICAL, 7 MAJOR, 7 MINOR, 2 NOTE**" — Bob quoted the superseded
pre-correction line, which the report itself flags as corrected at
`J-auditor-0002`. The finding (four grades, not three) stands; the citation
should be updated. This is exactly the decay class C-75 describes: true when
written somewhere, false at the state cited.

---

## 6. What this round did not do, stated so the sample is reconstructible

1. **No severities, no finding numbers** (§0).
2. **C-24 has no posture** — the §1.4(d) residual-risk episode is unanchored.
3. **Disguise 3 of §5.7** (the equivalence exclusion) is codified but its
   incident is unanchored.
4. **§4.4 (push at every landing)** was not measured against the remote.
5. **No re-execution of dv_lead, rtl_lead or architect Evidence sections** — the
   charter's per-phase ≥10% reproduction duty (`agents/charters/auditor.md`:65)
   remains owed and is **not** discharged by this report. This round re-executed
   the *document's* claims, not the *record's* evidence.
6. **The D-M3 note and the ADR-0020 countersignature record remain owed** and
   were outside this round's scope by dispatch.

---

*Committed by the orchestrator under `Agent: auditor`; write scope
`docs/reports/audit/**` (PROTOCOL §6). The auditor ran no git write command in
producing it.*

---

## 7. APPENDED DATED NOTES

**Why these are appended and not applied to the cells.** Everything above is a
**frozen measurement of `docs/PROCESS.md` at `6c02f5b`**. Two of the four notes
below correct errors in my own rows and two re-measure rows whose referent has
grown since. None of them edits a cell, a figure or a citation above this line.
The rule is the document's own — a frozen record is not repaired by rewriting it
(`docs/PROCESS.md` §5.4) — and the record's own instance is `de85393`, where a
findings tally was corrected **in place** by its author and §1.7 lists that
in-place correction among the weaknesses still owed. A posture list that cured
its own arithmetic by silently rewriting a cell would reproduce, in the file that
measures this program's honesty, the exact weakness it measures.

Each note carries the date it was written, the SHA every re-measurement was taken
at, and the command or the citation that decides it.

### Note 1 — 2026-08-12 — `C-126`'s evidence cell carries the wrong two figures

**The row says** *"Executing it returns 12 FALSE and 4 PLANNED (§1)."*
**The figures are wrong. The true figures are 15 FALSE and 8 PLANNED**, and the
error is confined to that one cell.

Recounted mechanically, posture cell by posture cell, over all 128 rows:
**MACHINE-CHECKED 34, REVIEW-ENFORCED 44, PERFORMED-ONCE 26, PLANNED 8, FALSE 15,
NOT SAMPLED 1 — total 128**, 127 carrying a posture (`C-24` has none, §6 item 2).

- FALSE (15): `C-07, C-08, C-32, C-33, C-40, C-56, C-67, C-70, C-77, C-80, C-82,
  C-93, C-97, C-114, C-123`.
- PLANNED (8): `C-23, C-41, C-51, C-53, C-54, C-71, C-109, C-119`.

**Every other statement of these figures in this report and in the document is
already right**, which is what makes the cell an isolated slip rather than a
miscount running through the work: §0 at :67 says *"Fifteen rows are marked
FALSE"*; the summary table, the per-section table, the collected-FALSE table and
the PLANNED table all close on 15 and 8 with the row-total identity at 128; and
`docs/PROCESS.md` carries 15/8 at :21–25, :667, :2430, :2437 and :2454 at
`2f32e45`, and nowhere carries 12/4 outside Annex `B.5`'s own flag of this
discrepancy.

**Where `12/4` came from is not established.** I could not recover it within the
frame of the round that found it, it does not bear on the resolution, and I would
rather leave a hole than construct a provenance. Filed by the seat that wrote the
cell. (`B.5` resolved for 15/8 at `J-auditor-0025`; this note is the cure that
entry said was owed and could not stage.)

### Note 2 — 2026-08-12 — `C-117`'s anchor is wrong; the stamp it grades is right

**The row anchors** §4.8's six-cure exhibit at
`agents/journals/claude_architect_docs_lead_agent.v02.md`:1181. **That anchor is
wrong.** Line 1181 sits inside `J-architect_docs_lead-0025`
(2026-08-04T18:40Z, `task:BUG-0002`), and its *"sixth"* is the sixth item of a
**countersignature's** narrowing — *"and the sixth, the D(m) bullet itself, is
what this diff replaces"* — not the sixth cure of a cure basket. It is a
text-similarity match that I did not falsify when I made it.

**The true anchor is `J-architect_docs_lead-0047`** (2026-08-11T19:34Z),
`agents/journals/claude_architect_docs_lead_agent.v05.md`:684, whose title names
the shape the exhibit describes (*"the cure basket pays four of six — one stopped
at the constitution's edge because the word it would fix is now applied text"*)
and whose disposition table carries **six numbered rows**, rows 1–5 landed /
sustained / cured and **row 6 `F-0022-2` STOPPED — returned as an Amendment `A1`
candidate**, with the re-owes cell naming the countersignature the `A1` round owes.

**The consequence runs in the document's favour.** The row's posture
(**PERFORMED-ONCE**) is unchanged, the episode is real, and the document's
`[P1 · 2026-08-11 · C-117]` stamp is **correct** — it was my citation that was
wrong, not the claim it graded. Recorded because a posture list whose anchors are
not falsifiable is the defect it was written to measure, and because a reader who
checks the cited line and finds a countersignature must not conclude the exhibit
is unanchored.

### Note 3 — 2026-08-12 — `C-104`: the referent grew from twelve bullets to fifteen, and the row's own count was off by one

Re-measured against the **committed fourth edition, `docs/PROCESS.md` at
`9362aef`** (5,044 lines), because the document is under revision again as this
note is written and *"current text"* would be false within the hour; a SHA-pinned
statement stays checkable (`git show 9362aef:docs/PROCESS.md`).

**Two corrections, one against the row and one against the world.**

1. **The row says *"the thirteen scoring bullets"*. At the audited SHA there were
   twelve.** `git show 6c02f5b:docs/PROCESS.md | sed -n '890,936p'` carries
   exactly **12** top-level bullets, first *"The question is present-tense."*
   (:890), last *"A floor on the number of seeded classes"* (:934). My count was
   off by one at the moment of measurement.
2. **The block now carries fifteen.** At `9362aef` the same block runs :2964–3054
   with **15** top-level bullets. The growth is one bullet becoming four: the
   compressed *"known grounds"* bullet at `6c02f5b`:898 is now that bullet plus
   three flat bullets of its own — **`Ground 1 — never rendered`** (:2975),
   **`Ground 2 — unscoreable`** (:2979), **`Ground 3 — negative control`**
   (:2985). The remaining eleven map one-to-one, in order, onto the eleven of
   `6c02f5b`.

**The posture is unchanged and re-executes true at HEAD.** All fifteen restate
`agents/PROTOCOL.md` §7 **Mutation record** (b.1)–(b.4) and §10's floor, none
mints a mechanical claim, and the constitution declares the posture in the clause
itself (`PROTOCOL.md`:329–330). Re-executed rather than carried forward:
`grep -rniE 'seeded|sealed|mutat|unreachab|equivalen|kill|tally|denominator|floor'
scripts/ .github/` returns **3** hits, all unrelated (two `R8` foreign-volume-*seed*
refusals at `check_journals.sh`:117 and `agent_commit.sh`:113, one workflow step
name). And `git diff 6c02f5b HEAD -- agents/PROTOCOL.md scripts/ .github/` is
**empty**: the machinery this row measures has not moved, so **`REVIEW-ENFORCED`
(block) stands over fifteen bullets exactly as it stood over twelve.**

### Note 4 — 2026-08-12 — `C-94`: §3.8's element list grew by one element, and the sign-off carries it

Re-measured at `9362aef`, same pinning ground as Note 3.

**The row's claim was measured over a six-element list.** At `6c02f5b`:808–811 a
sign-off is *"pass or fail, with the suite named, the exact commands to reproduce
it, the requirement-to-test mapping with gaps declared, the stress-test results,
the seeded-defect dispositions, and open defects"*.

**At `9362aef`:2733–2739 the list carries a seventh element**: *"**the external
anchor's disposition per stimulus class — with what the anchor does not cover
named beside what it does, and no artifact-level claim assembled out of passing
classes (§1.4(e))**"*. The section also now declares the list **a floor, not a
description of any packet**, and discloses in its own stamp text that the element
was added **after** the measurement my row recorded.

**Re-measured rather than adopted, because the disclosure is the drafting seat's
and the row is mine.** `agents/handoffs/SO-xgmii_rx_64.md` carries the seventh
element: §2.3 (:1047–1089) states the anchor **per class** — five classes, each
at its own `build` run id and `cosim` job id, with its *"does NOT anchor"* list
**in the same cell** — and the packet states in terms that the charter §3 anchor
is **UNDISCHARGED as a module-level anchor**; `SC-6` is scored MET at all four
read-backs (:281, :352, :512), the last recording that the barred sentence *"the
co-simulation anchors this module"* occurs four times in the file and **all four
inside a statement of the prohibition itself**. That is the seventh element's
positive half and its negative half both present.

**So the row's evidence sentence — *"it carries every named element"* — survives
the list's growth, now as a measurement over seven elements rather than six.
Posture unchanged: PERFORMED-ONCE, sample size one.**

### Note 5 — 2026-08-12 — what these four notes do NOT do: the list as a whole still measures a superseded edition

The four notes above cure two errors of mine and re-measure two rows whose
referent grew. **They do not re-measure the list.** Every one of the 128 rows
above was measured against `docs/PROCESS.md` at **`6c02f5b`, 1,445 lines**. The
committed document at `9362aef` is **5,044 lines** — 3.5× — and a fifth edition
is in flight as this note is written (commissioned this hour against
`docs/reports/process-council/sponsor-report-card-2026-08-12.md`, landed
`1b684c7`).

**Three classes of row are therefore stale by construction**, and no reader should
take this file's silence for a clean bill on any of them: (a) every row's
line-range citation, which the growth guarantees is wrong; (b) rows whose *claim
text* grew, of which this round found **two** by accident rather than by
enumeration (`C-104`, `C-94`) — a row whose claim grew has a posture measured over
a smaller claim; (c) claims the third, fourth and fifth editions **add**, which
have no row here at all.

**The full re-measurement is SCHEDULED, not performed, and the grounds are in
`J-auditor-0026`.** It is named there as its own round with its own scope, to be
run against a committed edition after the current revision cycle stops moving —
because a census pinned to an edition that is superseded before it lands would
reproduce row `C-75`'s own decay class, and because a rushed census is worse than
an owed one. **This file stays what it is: the measurement of `6c02f5b`.**
