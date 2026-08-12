# HALT LOG — first with-shell adoption run (probe-5-2)

**Run:** a cold adopter, handed PROCESS.md (seventh edition, core) and
PROCESS-MEMOIR.md (companion), executing the adoption procedure literally —
§6.0/§6.2 including the precedence rule — with, for the first time, network
reach to the shell. One permitted network act: `git clone` (read-only, https)
of the repository §6.0 names, `github.com/renatom11/generic-agentic-fpga-org`.

**World constraints, declared up front:** no human sponsor exists or can be
recruited; no hosting platform is reachable (no Actions, no rulesets, no issue
tracker); no CI surface can run; the adopter is one actor. The clone is the
only network act.

**Shell observation:** cloned at `main` = `2ad82c3`, observed 2026-08-12 —
**exactly the commit §6.0's pin names** (2ad82c3, 2026-08-11). Zero drift since
the pin. The founded copy is at `probe-5-2/org` (46 commits, all green under
the shell's own full-history re-check), its protected origin at
`probe-5-2/org-remote.git`.

**Which order governed:** per §6.0's precedence rule, the shell's own order.
In practice that order is three files, not one — README "Getting started"
(founding topology), CLAUDE.md "First session" (boot + role determination),
BOOTSTRAP.md (Stage 0 / Stage 1 / Stage 2) — and the rule that decided this
run's entire path (no project material → found as **org generic**, decided
never asked) lives in CLAUDE.md, not in the file §6.0 names. §6.2 governed
four things the shell's order does not contain: the Step −1 preflight, the
Step 0 trace, the residue list, and the Definition of Done.

**Outcome in one line:** a founded org generic — role recorded, freeze
re-scoped, defect channel seeded, enforcement verified by own hands and by
live fire — with the sponsor-owned and independence-owed rows OPEN and
declared, deferred by the shell's own law to the first project fork's G0.

---

## RAN-CLEAN — steps executable exactly as written

- **RC-1** (§6.2 Step −1, limb 4 — core volume): fetch the shell, pin to a
  stated commit. Cloned; observed head equals §6.0's pin. Recorded in
  J-orchestrator-0045.
- **RC-2** (§6.0 precedence rule — core volume): decidable at minute one and
  applied — shell in hand, shell's order governs, §6.2 read for grounds.
- **RC-3** (shell: CLAUDE.md "First session"): identity check (`origin` vs the
  board's This-repository line) detected the unfounded copy; the pre-founding
  `check_journals.sh --all` returned the **designed** R-ROLE-1 red as the stop
  signal; role determination ran decided-never-asked (no project material →
  org-generic).
- **RC-4** (shell: BOOTSTRAP Stage 0 step 3): "Verify the enforcement with
  your own hands" — `test_protocol.sh` 52/52; `check_journals.sh --all` green
  through R10 then the designed founding stop.
- **RC-5** (shell: Stage 0 steps 4–6, board-edit substance): role line →
  `org-generic`; freeze bullet re-scoped verbatim to the prescribed end
  condition; defect log seeded empty with the channel confirmed.
- **RC-6** (shell: PROTOCOL §5 / `agent_commit.sh`): both adoption commits
  (e8e593a founding, 98cb9ed Step 0 artifacts) passed the gate first try, with
  journal coupling, trailers, files-list equality; pushed at every landing;
  full-history re-check green after each (45, then 46 commits).
- **RC-7** (§6.2 Step 0, acts 1–2 — core volume, map from companion Annex C):
  trace of the [MC] claims into the shell's machinery using the inherited name
  map; recorded as `org/docs/reports/adoption/adoption-mc-trace.md` (29 claims:
  27 TRACED, 1 TRACED-PARTIAL, 1 NOT-TRACED-HERE).
- **RC-8** (§6.2 Definition of Done, rows 1, 5, 6 — core volume): self-test
  green **from a clean clone** with the suite read against the rule table
  (R1's zero-case and R9's force-push limb land exactly where the text's own
  parentheticals say they will); residue list exists as a file, routed with
  cadences; the recovery sequence walked from the files (board → PROTOCOL →
  ORG_CHART → journal tail), every file present and pointing where it says.
- **RC-9** (§6.2 Step 4's substance, on the governed path): the self-test is
  green and the amendment binding already exists as imported law — shell
  PROTOCOL §11 plus `policy.sh`'s own comment ("Change only via ADR with a
  test_protocol.sh scenario") bind every enforcement-semantics change to a new
  case. Nothing to build; the step collapses to a verification.

---

## HALTS

### HALT-01 — §6.2 Step −1, sponsor limb [core volume]
- **What the text says:** "A human sponsor, recruited and willing. Step 5
  cannot close without them... Recruit the human first."
- **What I attempted:** inventory of the world — no human is reachable from
  this run, ever.
- **What happened / missing:** §6.2 makes the sponsor a preflight blocker. The
  shell's governing order does not: BOOTSTRAP Stage 0 (org-generic founding)
  contains **no sponsor act at all** — every sponsor duty (A6 ratification, A7
  protections, B1–B6 intake) is a *project-fork* G0 row. The two orders
  disagree about when the human becomes load-bearing, and no tiebreaker
  addresses it; §1.7's "ratification is the one act an organization cannot
  perform for itself" sits in tension with a Stage 0 that self-founds with
  zero human signature.
- **Disposition: PROCEEDED-BY-IMPROVISATION.** Invented: the adjudication.
  I followed the shell's order (precedence rule: sequence is the shell's) and
  checked it against §6.2's six invariants — invariant 6 binds work orders,
  and an org generic issues none, so no invariant is violated. The
  sponsor-owed rows are recorded OPEN on the inherited G0 checklist and named
  in residue rows B.3/B.4.

### HALT-02 — §6.2 Step −1 platform limb; BOOTSTRAP Stage 0 steps 1–2 [both volumes/repos]
- **What the text says:** shell: "Enable Actions on the fork... Rulesets:
  configure `protect-history` (Active, empty bypass list...) targeting `main`
  and `fed/**`". Core: "If there is no reachable platform at all, that is a
  different substrate and Annex A.6b says what drops to convention — decide
  that now, not at Step 3."
- **What I attempted:** Stage 0 steps 1–2 as written.
- **What happened / missing:** unexecutable — no platform exists. The shell's
  order has **no fallback whatsoever** for this; it assumes GitHub in every
  founding step. PROCESS.md carried the run here: Annex A.6b prescribes the
  stand-in in outline (bare remote + hook refusing non-fast-forward and
  deletion, two declared differences: no bypass-list analogue, hook removable
  by anyone with filesystem access).
- **Disposition: PROCEEDED-BY-IMPROVISATION.** Invented: the concrete
  ~20-line `pre-receive` hook on `org-remote.git` (covering `main` and
  `fed/**` per the shell's ruleset spec); the board declarations dropping
  every platform-resting claim to convention/PROSE. Live fire performed:
  force-push and deletion both bounced ("pre-receive hook declined"), remote
  head unchanged, cited in J-orchestrator-0046.

### HALT-03 — §6.2 Step −1 CI limb; Stage 0 steps 1 & 7 "green before fork" [both]
- **What the text says:** core: "if it cannot run in your environment, Step
  3's required-check binding is unavailable and §2.5's adjudicator becomes the
  committing seat's self-report. Know which world you are in." Shell: "Stage 0
  is complete only when the default branch carries the founding commit and its
  CI is green."
- **What I attempted:** identify any way to run `journal-check.yml`.
- **What happened / missing:** none exists. The shell's completion condition
  ("CI green") is unevaluable as written.
- **Disposition: PROCEEDED-BY-IMPROVISATION.** Invented: local execution of
  the workflow's exact steps (`test_protocol.sh`, `check_journals.sh --all`,
  `check_requirements.sh`) after every push, recorded in journal Evidence,
  with the self-report status declared on the board and routed as residue B.2
  — using §2.5's own vocabulary for what this costs ("converts the adjudicator
  into the committing seat's self-report").

### HALT-04 — shell README "Getting started", clone-and-push [shell repo]
- **What the text says:** "`git remote set-url origin <your new EMPTY repo's
  URL>` / `git push -u origin main`... the only load-bearing requirement is
  that the commit chain arrives unsquashed."
- **What I attempted:** the three-command founding copy.
- **What happened / missing:** there is no place to host the new empty repo.
  Also, every identity surface (R-ROLE-1's owner/repo-tail comparison, the
  board's This-repository line) assumes a URL shape.
- **Disposition: PROCEEDED-BY-IMPROVISATION.** Invented: a local bare
  repository as the "new EMPTY repo" (its filesystem path recorded as the
  This-repository line, with the deviation declared on the board); cloned from
  the local shell clone rather than a second network fetch (byte-identical
  SHAs — "fork names the relationship" makes this lawful). R-ROLE-1's tail
  comparison worked unmodified against the path.

### HALT-05 — the precedence rule's scope: it adjudicates sequence, not coverage [core §6.0 vs shell]
- **What the text says:** "With the shell in hand, the shell's own
  BOOTSTRAP.md governs the sequence... §6.2 governs as the shell-less
  fallback, and as the reasons underneath either order."
- **What I attempted:** run the shell's sequence while reading §6.2's grounds
  per step.
- **What happened / missing:** the two orders are not two sequences over the
  same steps — they are **different kinds of procedure**. §6.2 constructs
  machinery from prose (acts 1a–1e, authoring a constitution, building a
  founding range); BOOTSTRAP configures machinery that already exists. Most
  §6.2 steps have no shell counterpart to sequence against (Step 0, the
  residue file, the DoD, the preflight), and Stage 0's board surgery has no
  §6.2 counterpart. The precedence rule answers "who wins when both speak";
  it says nothing about **who speaks when only one does**. Also: §6.0 names
  BOOTSTRAP.md as *the* second order, but the operative order spans three
  files, and the role-determination rule that decided this entire run is in
  CLAUDE.md.
- **Disposition: PROCEEDED-BY-IMPROVISATION.** Invented: the meta-rule I ran
  under — *shell text governs wherever it speaks; §6.2 items with no shell
  counterpart still execute, landing as reports (not law, so the freeze
  holds)*. Every §6.2-only item (preflight, Step 0, residue, DoD) ran under
  that invented rule.

### HALT-06 — §6.0's one adjudicated disagreement is stale at the pin [core §6.0 vs shell G0 A7]
- **What the text says:** core: "the shell configures platform protections
  early; §6.2 Step 3 deliberately places them after continuous integration
  has run green once... On this point §6.2 is right." Shell A7 click-path:
  "Do this **only after A3 is green** — the `journal-check` status check must
  have run at least once before GitHub will list it in the picker."
- **What I attempted:** apply §6.2's placement "whichever order you are
  running", as directed.
- **What happened / missing:** there was nothing to apply — the pinned shell
  **already agrees**: Stage 0 step 1 (Actions on, green confirmed) precedes
  step 2 (rulesets), and the picker-dependent ruleset is separately ordered
  after A3 green by the shell's own click-path. The one concrete
  disagreement the precedence rule ships is not a disagreement at `2ad82c3`.
  The instrument that would have caught this — the doc–shell drift check —
  "does not exist" by the document's own admission.
- **Disposition: PROCEEDED-BY-IMPROVISATION.** Invented: nothing to execute —
  the improvisation is the adjudication itself: I read both texts, concluded
  the conflict is stale, and continued on the shell's ordering (which
  satisfies §6.2's invariant 3 anyway). Logged so the next edition can retire
  or re-date the bullet.

### HALT-07 — §6.2 Step 0 acts 3–4 are vacuous for a name-preserving shell fork [core + companion Annex C]
- **What the text says:** "Then delete the inherited map, whole. Write your
  own map as Step 1 lands each seat, which is the only point at which you
  have names to map onto."
- **What I attempted:** acts 3 and 4 after the trace.
- **What happened / missing:** the map (companion Annex C) was never *in* my
  repository — the shell does not ship the companion — so there is nothing to
  delete; and a shell fork inherits the shell's names unchanged, so "your own
  map" is the identity mapping, and Step 1 never runs (the seats shipped).
  The four-act sequence was written for the shell-less path and for forks
  that rename.
- **Disposition: PROCEEDED-BY-IMPROVISATION.** Invented: the discharge form —
  the trace artifact records that the map was used and not imported
  ("deletion satisfied by non-import") and declares the identity mapping in
  place of a new Annex C, so the decision is on the record instead of silent.

### HALT-08 — kit artifacts unreachable or absent on the with-shell path [core §6.0 kit table vs shell contents]
- **What the text says:** kit rows: "The posture list... this repository,
  `docs/reports/audit/PROCESS-claims-posture.md`"; "The golden tally... this
  repository, `docs/process-golden-tally.json`"; "The chain verifier: the
  fifth enforcement script... this repository, enforcement directory". Step
  0's kit line: "*kit: the self-test, the commit script, the policy module,
  the posture list, the inherited name map.*"
- **What I attempted:** locate all Step 0 kit artifacts in the clone.
- **What happened / missing:** "this repository" means the **origin
  program's** repository — a third repository the export unit neither ships
  nor licenses the adopter to fetch. The shell carries neither the posture
  list nor the golden tally, and has no `verify_journal_chain.sh` file (the
  chain walk lives inside `check_journals.sh` — function present, artifact
  shape divergent, trace item D-3). Step 0 names the posture list as a trace
  input the governed path cannot obtain.
- **Disposition: PROCEEDED-BY-IMPROVISATION.** Invented: traced directly
  against the scripts without the posture list, and seeded my own posture
  record (the trace table is its first form). The golden tally's absence
  costs nothing — the fork contract orders it started empty anyway.

### HALT-09 — the kit table's divergence column describes the origin's copies, not the shell's [core §6.0 vs shell files]
- **What the text says:** auditor-charter row: "Its body contradicts current
  law in two places: it obliges the outlawed N/N ratio at four sites, and it
  teaches the superseded transient mutation model." Constitution-template
  row: "its campaign clause mandates the transient apply-and-revert model."
  Packet-forms row: "The sign-off skeleton still teaches the ratio the
  constitution outlaws — kills N/N."
- **What I attempted:** verified each cited divergence against the pinned
  shell, cell by cell.
- **What happened / missing:** two of three are **stale against the shell**:
  its auditor charter and campaign template carry the current branch-based
  `mut/` model with per-class SEALED adjudication and no ratio. One is
  **live**: `agents/handoffs/templates/SO-template.md:17` still teaches
  "kills N/N". The column "an importer reads first" is measured against a
  repository the with-shell importer never opens, while §6.0 simultaneously
  says "the shell is the normative source of every grammar" — the fourth
  column and the mechanism-placement rule point at different repositories,
  and nothing arbitrates.
- **Disposition: PROCEEDED-BY-IMPROVISATION.** Invented: the cell-by-cell
  re-verification protocol against the shell. The live defect is logged on
  the founded board's local defect log (upstream channel blocked — HALT-11)
  and routed as residue B.9 with the corrective form named (§3's facsimile,
  exactly as the kit row directs).

### HALT-10 — Stage 0's board surgery is under-determined for everything it does not name [shell BOOTSTRAP Stage 0]
- **What the text says:** step 4: "set the board's Repo role line to
  `org-generic` and re-record the This repository line"; step 5: "rewrite the
  board's feature-freeze bullet"; step 6: "the local defect log starts
  empty."
- **What I attempted:** the three named edits.
- **What happened / missing:** the shipped board carries ~150 further lines
  of the shell's own history — closed overrides, five field-trial findings,
  sponsor proposals P1–P3, queued law-debt, an independent claims audit —
  which now sit on a fork's board describing another repository's events,
  with no strip-or-keep rule. PROCESS.md §6.1's fork contract solves exactly
  this problem *for the document* ("strip, or keep as history and say so");
  nobody wrote the equivalent for the board.
- **Disposition: PROCEEDED-BY-IMPROVISATION.** Invented: minimal-touch — only
  the three mandated edits, each annotated in place to mark the inherited
  material as the shell's own history (e.g. "the seeding-era entries were the
  shell's own and closed at its C44"), everything else left verbatim under
  CLAUDE.md's "take the tree's most conservative reading".

### HALT-11 — the defect channel is a network act this world cannot perform [shell CLAUDE.md iron rule / Stage 0 step 6]
- **What the text says:** "A wrong claim, broken step, or gap in the shell
  found while operating any copy is filed as a GitHub issue on the canonical
  shell... and appended to the BOARD's defect-log line."
- **What I attempted:** file the SO-template N/N defect upstream.
- **What happened / missing:** no route — the single permitted network act
  was the clone. The channel is confirmed (pointer correct) and unusable.
  Neither volume covers a world with clone-reach but no write-reach; Annex
  A.6b covers platform absence generally, not the defect channel.
- **Disposition: PROCEEDED-BY-IMPROVISATION.** Invented: the board-declared
  carry — defects logged locally on the defect-log line with "upstream issue:
  BLOCKED, no route", forwarded when a route or a sponsor hand-relay exists.

### HALT-12 — DoD row 4 (retro-audit) vs the shell's spawn-ordering law [core §6.2 DoD vs shell G0 A9 + CLAUDE.md]
- **What the text says:** core: "The founding range has been retro-audited by
  a seat that did not write it... (Or: the independence is declared
  unachievable in your environment... and this row stays open. An open row is
  a true row.)" Shell: "Until intake is on the BOARD, the orchestrator spawns
  no agent"; A9 is "the org's first spawn... **after** Section B is recorded."
- **What I attempted:** determine whether any lawful retro-audit of the seed +
  founding range can happen at org-generic founding.
- **What happened / missing:** it cannot: the shell's law forbids any spawn
  before intake, and an org generic never has intake — the retro-audit is
  structurally deferred to the first project fork's G0 A9 (whose mandate does
  cover the inherited seed range). §6.2 wants the audit before founding
  closes; the shell schedules it a repository later. No tiebreaker speaks to
  this. I also declined §6.2's in-persona fallback (performing the audit
  myself as orchestrator) because it would counterfeit the shell's first-spawn
  design — the trace artifact carries the in-persona declaration for the
  verification work that *was* done in persona.
- **Disposition: STOPPED** (for this row). A9 and DoD row 4 stand OPEN and
  declared, routed as residue B.4 to the first project's G0. That is the
  design working, by the core's own words.

### HALT-13 — no founding gate artifact exists for an org generic [core §6.2 Step 5 vs shell Stage 0]
- **What the text says:** core: "found the organization self-signed, with the
  ratification and independence rows left open **in the gate record** and the
  limitation declared **in the gate file itself**."
- **What I attempted:** find the gate record in which to leave rows open.
- **What happened / missing:** there is none — G0's checklist belongs to the
  project stage; Stage 0 has no gate artifact, no signature rows, no
  checklist of its own. §6.2's whole Step 5 vocabulary (gate file, rows,
  self-signing) has no org-generic counterpart, and fabricating a gate file
  would be new law under the freeze.
- **Disposition: PROCEEDED-BY-IMPROVISATION.** Invented: the founding
  declaration lives in the journal entries (J-orchestrator-0045/0046) and the
  annotated board — the two places the shell's law already makes
  authoritative — with the open sponsor/independence rows carried on the
  inherited G0 checklist where they already exist as OPEN.

### HALT-14 — the shell ships the stale rehydration aid the core forbids [core §6.2 act 1e vs shell `agents/journals/INDEX.md`]
- **What the text says:** core: "either derive it mechanically at read time or
  write into the file itself the date it was last true... a stale aid is worse
  than a missing one." Shell INDEX: last orchestrator entry "J-orchestrator-
  0026" — the chain's real tail at seeding was 0044, and is 0046 now.
- **What I attempted:** decide whether to refresh it during founding.
- **What happened / missing:** the exporter's own shipped artifact violates
  the exporter's own rule (partially mitigated: the INDEX header carries a
  "best-effort" disclaimer and a regeneration recipe, which is a form of the
  derive-at-read-time discharge). Stage 0 does not ask for a refresh;
  CLAUDE.md schedules INDEX updates "at gate boundaries" and no gate closed
  here.
- **Disposition: STOPPED** (deliberate non-repair). Left stale by the shell's
  own cadence rule; recorded as residue B.7 with cadence (every gate
  boundary) and closing event (mechanical derivation or a dated-truth line).
  The recovery walk itself (DoD row 6) does not depend on it — the board's
  rehydration order never consults the INDEX, which is its own small
  duplication finding.

### HALT-15 — the shell's A2 wording vs the core's zero-case license for R1 [shell G0 A2 vs core §6.2 Step 4/DoD]
- **What the text says:** shell A2: "Enforcement self-test green in CI (every
  rejection asserting its rule, R1–R10 + WARN-SEAL)". Core DoD: "rows are not
  rules... cases are not rows, since one rule can need several constructions
  and one can admit none at all."
- **What I attempted:** DoD row 1's per-rule reading of the suite.
- **What happened / missing:** no rejection anywhere in the suite or scripts
  asserts R1 — the mixed-agent construction is intercepted by R7/R8, exactly
  as the core predicts. The shell's "R1–R10" is true only under the charitable
  reading (the rule *set* covered, each *fired* rejection naming its rule);
  under the literal reading it overstates. The core's DoD parenthetical is
  the better instrument and pre-adjudicates the fact.
- **Disposition: PROCEEDED-BY-IMPROVISATION.** Invented: the choice of the
  charitable reading, recorded here and in the trace's R1 row rather than
  filed as an upstream defect (the claim is not false under its natural
  reading; filing it would spend the blocked defect channel on a wording
  quibble).

### HALT-16 — invariant 5 is unsatisfiable as written on the governed path [core §6.2 invariants vs the shell's shipped constitution]
- **What the text says:** "The constitution is authored from your own
  machinery, before any step quotes it... a constitution written from a
  description is a second copy that drifts from the machine on its first
  amendment."
- **What I attempted:** conformance check of the shell's order against the six
  invariants, as the core directs for anyone running somebody else's sequence.
- **What happened / missing:** on the with-shell path the constitution is
  **imported, not authored** — the letter of invariant 5 cannot be met and no
  step of any order authors one. Its spirit holds by construction at the pin:
  the machinery and PROTOCOL arrived from the same source and the self-test
  binds them (52/52), and PROTOCOL §11 couples every future semantic change
  to a new scenario, which is the anti-drift property the invariant protects.
  Invariants 1 and 2 similarly dissolve rather than get satisfied: my
  founding commits were gated from the first byte (no founding range of
  ungated commits exists at all — the bootstrap paradox is the one §6.2
  problem the shell removes outright), and the machinery preceded any review
  trivially. Invariant 3: shell agrees (HALT-06). Invariant 4: met at
  convention grade (HALT-02). Invariant 6: binds work orders; none issue.
- **Disposition: PROCEEDED-BY-IMPROVISATION.** Invented: the reading that
  import-plus-green-self-test-plus-§11-binding discharges invariant 5's
  purpose, recorded here because the invariant's own text provides no
  with-shell form.

---

## Definition of Done — evaluated (core §6.2; the shell's order has no DoD)

| Row | Result |
|---|---|
| 1. Self-test green from a clean clone, ≥1 case per numbered rule, read against the rule table | **PASS** — fresh clone: 52 passed, 0 failed; full-history re-check green (46 commits). Per-rule reading in the trace artifact: R2–R10, WARN-SEAL, R-ROLE-1, REQ-FORM, Session all covered; R1 admits no case (licensed by this row's own parenthetical); R9's force-push limb discharged by the live fire, recorded in the suite's stead in the trace (HALT-15, RC-8). |
| 2. Every [MC] claim traced to a refusal in my machinery; untraceable ones re-stamped | **PASS, form deviation declared** — trace table beside the document (the row's named acceptable form), not stamp-by-stamp edits: 29 claims — 27 TRACED with script-line citations, 1 TRACED-PARTIAL (C-21: one direction of the impl/verif isolation has no named scenario), 1 NOT-TRACED-HERE (C-57, CI-fails-before-merge: no CI exists here; re-postured convention in my copy, declared on the board). The trace also found defects in the *exporting document* (D-1: §6.0's kit table contradicts §2.2 on the size thresholds — the soft threshold is a hard-coded literal on one surface, not env-read on both) — the outcome the row itself predicts, left open and declared. |
| 3. Platform dependency bounced a real attempted violation, cited in the founding gate record | **PASS AT CONVENTION GRADE, declared** — force-push and deletion both bounced against the protected origin, remote head unchanged, cited in J-orchestrator-0046 (the founding record this org-generic path has — HALT-13). Material differences declared per Annex A.6b: no bypass-list analogue; hook removable by filesystem access. Not a platform guarantee; residue B.1. |
| 4. Founding range retro-audited by a seat that did not write it | **OPEN, declared** — structurally deferred by the shell's spawn-ordering law to the first project fork's G0 row A9, whose mandate covers the seed range (HALT-12). "An open row is a true row." |
| 5. Residue list exists as a file, routed, with cadences | **PASS** — `org/docs/reports/adoption/residue-list.md`: nine rows, every one routed to a seat with an interval and a closing event. |
| 6. Recovery sequence walked from the files | **PASS** — board → PROTOCOL → ORG_CHART → journal tail of the seat with open work; every file exists and points where it says. One aid (journal INDEX) is stale as shipped and is deliberately not on the board's own rehydration path (HALT-14). |

**The falsifiable adoption claim this run supports:** a founded org generic,
enforcement imported and verified (machine-grade locally, convention-grade at
the boundary), with ratification and audit independence OPEN, declared, and
routed to the first project fork's G0 — no work order may issue from this
repository, and by its own role none ever will.

---

## SUMMARY

**Total halts: 16.** STOPPED: **2** (HALT-12 retro-audit row left open by law;
HALT-14 stale INDEX left unrepaired by cadence rule). PROCEEDED-BY-
IMPROVISATION: **14**. Steps run clean: **9** (RC-1..RC-9), including the
entire enforcement layer, which prior runs had to write from nothing.

**Three most expensive halts:**
1. **HALT-02/03 (platform + CI absence)** — the only halts that consumed
   building time: the pre-receive stand-in, the live fire, and the
   posture-drop declarations across board, journal, and residue. Annex A.6b
   paid for itself here; the shell's order contributed nothing.
2. **HALT-05 (the precedence rule's coverage gap)** — the most expensive
   *judgment*: discovering that the two orders barely overlap, that the
   shell's real order spans three files, and inventing the meta-rule that
   §6.2-only steps still run. Every §6.2-only artifact (preflight, trace,
   residue, DoD) executed under an adjudication no text supplied.
3. **HALT-08/09 (kit table vs shell contents)** — the most expensive
   *verification*: three kit artifacts absent or reshaped in the shell, and a
   divergence column whose cells describe the origin's copies (two stale, one
   live), forcing a cell-by-cell re-check of the "normative source" against
   the document that warrants it.

**Which order actually governed, and the precedence rule's keep:** the shell's
order governed every step it contains — founding topology (README), boot and
role determination (CLAUDE.md), Stage 0 (BOOTSTRAP) — and it is materially
better on its own ground than §6.2 is on the same ground: identity checks are
mechanical (R-ROLE-1's designed red), the role decision is decided-never-asked,
and the bootstrap paradox that §6.2 spends a page on simply does not exist
because the gate predates the adopter's first commit. §6.2 governed everything
outside the shell's frame: the preflight (which alone diagnosed the platform,
CI, and sponsor absences before they were mid-founding surprises), Step 0's
trace, the residue discipline, the DoD, and Annex A's substrate fallbacks. The
precedence rule **earned its keep once** — at minute one it routed this run
correctly and cheaply — and **failed twice**: its only concrete adjudication is
stale against the pinned shell (HALT-06), and it is silent on the actual hard
problem, which is coverage rather than conflict (HALT-05). The six invariants
were the better instrument for cross-checking the shell's order than the
adjudication bullet was; three of the six dissolve on the with-shell path
rather than needing satisfaction (HALT-16).

**Could a blank adopter replicate this, and what fraction was invented?** Yes —
and this run is the first evidence for the half of the unit's bet that was
untested: **the machine half transfers**. Run two (shell-less) invented ~850
lines of enforcement; this run invented **zero lines of enforcement** — every
script, rule, form, seat, charter, and the constitution arrived working, and
the suite proved them at 52/52 from a clean clone before anything was trusted.
What still had to be invented is small in volume and specific in kind: one
~20-line hook (whose outline Annex A.6b dictated), a founded board's worth of
declarations, two per-adopter artifacts (trace, residue) that are *designed*
to be written fresh, and — the part no volume ships — the adjudications at
every seam where the two halves disagree, duplicate, or fall silent: perhaps a
dozen judgment calls, each logged above. Call it **~95% imported by weight of
machinery, with the remaining ~5% almost entirely judgment rather than code**
— and that judgment concentrated precisely at the handoff between the volumes,
which is where the owed doc–shell drift check and an org-generic-shaped
founding record (a Stage 0 gate artifact, a board fork-contract) would convert
most of this log's improvisations into next edition's RAN-CLEAN rows.
