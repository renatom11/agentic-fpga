# HALT LOG — cold adoption run 2, against the revised §6.2 (fourth-edition PROCESS.md)

Run: 2026-08-12, one actor, one day. World: `cold-boot-run-2/` only; the one
received artifact is `received/PROCESS.md` (5,044 lines, fourth edition,
anchor 2026-08-12). Executed: §6.2 "The order that works", literally, step by
step, into a fresh repository at `cold-boot-run-2/adoption/` (branch `work`,
bare origin at `cold-boot-run-2/origin.git`). This run is the document's own
dated condition **B.0.2** ("cold adoption run number two"), executed by a
seat that did not write it.

**Terminal state:** organization founded and mechanically gated; 18 commits,
all pushed (2 declared founding + 16 through the gate under 3 seat
identities: orchestrator ×10, spec_lead ×4, auditor ×2);
full-history re-check GREEN on every push; enforcement self-test 19/19 from a
clean clone; founding gate instantiated with rows G5 (ratification) and G6b
(independence) **OPEN**; no work order issued — which the received Step 5/6
text names as the honest result, not a failure.

**Disposition vocabulary** (kept binary per the run charter): **STOPPED** =
the step's required act was not performed and the text offered no way
through; **PROCEEDED-BY-IMPROVISATION** = the run continued, with what was
invented stated exactly (entries where the text's own fallback carried the
run say "invented: nothing beyond X").

---

## RAN-CLEAN — executable from the text alone, executed as written

- **Act 1c** (onboard each remaining seat: charter + scope row + launcher +
  seeded entry-free journal + roster flip, one gated commit per seat) — five
  commits, all through the gate, foreign-seed rule (R8) exactly as §2.2 gives
  it.
- **Act 1d** (author the constitution from what the scripts refuse, posture
  declared per clause, scope table restated, rule set printed) — the
  instruction is self-contained and was followed to the letter.
- **Step 2's solo-adopter pattern** (write all three lenses, declare the
  non-independence inside the review artifact, file it as a critical finding
  against one's own founding, carry it to the retro-audit) — now embedded in
  the step; executed as written (10 findings, 1 critical, all dispositioned).
- **Step 4's two warnings** — both came true exactly as predicted: one
  construction was intercepted by a different rule (R1a intercepted by R8;
  kept and recorded), and the R9 branch limb admitted no construction and was
  recorded as discharged by Step 3's live-fire bounce, said in the suite.
- **Step 5's honest-result block** — found the organization self-signed,
  ratification and independence rows left open in the gate file, limitation
  declared in the file itself, both named evasions refused, retro-audit
  performed in persona with its weakness declared in its own text, refusal
  recorded in a decision record (ADR-0002). Run 1's HALT-14/15/16 are fully
  discharged by the new text: no improvisation was needed here at all.
- **§4.7's sponsor-signing route** (act outside the repository, orchestrator
  transcribes, authority in the transcriber's entry) — used verbatim for the
  gate's G5 annotation.
- **The DoD residue facsimile** (open the file at Step 0 with routing columns
  empty; fill them at Step 2) — executed exactly; no blank cadence cells.
- **Every grammar facsimile consumed as given**: trailer block and protected
  keys (§2.1), entry header + eight sections + `- (none)` marker (§3.1),
  volume-header fields (§2.2), scope-table shape (§2.3), rule ids R1–R11 and
  both thresholds (§2.6, A.3, A.7), packet/identifier tokens (§3), roster and
  program-state shapes (§1.6), gate-checklist shape (§3.7). In run 1 every
  one of these was invention; in this run none was.

---

## Halts

### HALT-01 — §6.0 (the pin) / §6.2 Step 0
- **What the text says:** "Before adopting anything, take this document's
  mechanically-enforced claims and check them in the shell (§6.0 names it):
  for each `[MC]` stamp, find the refusal, and for each numbered rule, find
  the self-test case… Anything you cannot find is `[RE]` in your hands
  whatever it is stamped here, and belongs in your own residue list." And the
  pin: "Fetch before you rely on anything below."
- **What I attempted:** one ref-listing probe of
  `github.com/renatom11/generic-agentic-fpga-org` (`git ls-remote`). It
  returned refs: `HEAD`/`main` = `2ad82c3…` — **byte-identical to the pin in
  §6.0** — plus an inbox branch and a PR ref, consistent with §6.0's
  federation description. The run charter (this world's substrate) forbids
  reading any outside repository, so no file of the shell was fetched; the
  shell's *contents* are unreachable here by construction.
- **What happened / missing:** the verification act of Step 0 — 34 distinct
  `[MC]` rows traced to refusals, self-test cases located per rule — could
  not be performed. The pin itself verified at ref level, which is the one
  fact about the shell this run can attest.
- **Disposition: PROCEEDED-BY-IMPROVISATION.** Invented: nothing beyond the
  form — the step's own fallback sentence was executed wholesale (all 34 rows
  `[RE]`-in-our-hands, residue row R-01), recorded as a **trace table beside
  the document** (`adoption/docs/step0/TRACE-TABLE.md`), the form deviation
  the DoD explicitly licenses and asks to be declared. Contrast run 1's
  HALT-01 (STOPPED: nothing named the shell). The naming repair worked; the
  verification act remains structurally unperformable in any world that
  cannot read the shell, and the residue carries it.

### HALT-02 — §6.0 kit table, consumed by every "→ kit:" line of Steps 0–5
- **What the text says:** thirteen kit artifacts ("The commit script… The
  history re-check… The policy module… The enforcement self-test… The
  continuous-integration workflow… The constitution template… The charter
  template… The launcher prompts… The packet forms… The sponsor guide… The
  chain verifier… The posture list… The anonymized auditor charter"), each
  step keyed to the kit artifact that performs it.
- **What I attempted:** obtain any of them. All live in the unreachable
  shell.
- **What happened / missing:** every kit consumption became authorship. The
  **implementation** of the executable layer was invented end to end
  (~850 lines: `policy.sh`, `commit_gate.sh`, `history_recheck.sh`,
  `chain_verify.sh`, `selftest.sh`, the pre-receive hook), plus the charter
  template, launcher prompts, sponsor guide, and packet forms (the last
  consumed only as constitution text — no packet ever issued, the gate being
  open). **What did NOT have to be invented, against run 1's "roughly one
  hundred percent"**: every interface the scripts implement — trailer keys,
  entry grammar, chain header fields, scope-table semantics, rule numbering,
  refusal-names-the-rule contract, both size thresholds, the large-file
  figure — came from the facsimiles.
- **Disposition: PROCEEDED-BY-IMPROVISATION.** Invented: all script logic,
  language and CLI choices, error texts, the fixture strategy of the
  self-test, and the hook design. The document constrained all of it and
  determined none of it — exactly the division §6.0 predicts for a shell-less
  adopter.

### HALT-03 — §6.1 (fork contract) against §6.2 (adoption order)
- **What the text says:** §6.1 defines per-mark acts for "a fork" (strip or
  re-anchor ~135 stamps; "Annex C: Delete whole and write your own, as the
  first act of Step 0"; delete Annex B; replace the edition anchor). §6.2's
  DoD asks only that `[MC]` claims be re-stamped "in your copy".
- **What I attempted:** determine whether a cold adoption executing §6.2 *is*
  a fork owing the whole contract. The text never says.
- **What happened / missing:** no rule connects the two sections for an
  adopter who keeps the received document as a received artifact rather than
  republishing it as their own.
- **Disposition: PROCEEDED-BY-IMPROVISATION.** Invented: the split — executed
  the two fork-contract acts that §6.2 itself references (own name map
  written as the first act of Step 0: `adoption/docs/NAME-MAP.md`; `[MC]`
  re-stamping via the trace table), and kept the received document
  byte-identical at `adoption/docs/received/PROCESS.md` as history, stamps
  unstripped, on the reading that this run adopts the process without
  republishing the description.

### HALT-04 — §6.2 act 1a against the §1.6 roster facsimile it cites
- **What the text says:** act 1a: "one row per seat with its function, tier,
  charter path, journal path, the scope it will hold, and a **Status** column
  (§1.6's facsimile)". The §1.6 facsimile's columns are: Seat, Tier, Reports
  to, Charter, Journal, Status — **no scope column, no function column, and a
  Reports-to column 1a never mentions**.
- **What I attempted:** build the roster from the facsimile as instructed.
- **What happened / missing:** the two column lists disagree; "the scope
  table is the roster's scope column made executable" (1a) is unbuildable
  from a facsimile that has no scope column.
- **Disposition: PROCEEDED-BY-IMPROVISATION.** Invented: the union of both
  column sets (`adoption/ROSTER.md`, column note in the file).

### HALT-05 — §6.2 Step 1 preamble
- **What the text says:** "…in four ordered acts, **before the first commit
  you intend to keep**."
- **What I attempted:** parse it literally. All four acts are themselves
  commits, and all are kept.
- **What happened / missing:** the phrase is unsatisfiable as written; no
  definition of "the first commit you intend to keep" exists anywhere in the
  document.
- **Disposition: PROCEEDED-BY-IMPROVISATION.** Invented: the reading "before
  the first commit of real (post-founding) work", consistent with §1.7's
  "before the first real work order".

### HALT-06 — §6.2 Step 1 second bullet: the founding range vs the full-history re-check
- **What the text says:** "land the machinery in a named, minimal founding
  range, declare that range self-signed in your founding gate (§1.7 act 1),
  and have the retro-audit of Step 5 examine it specifically. What you may
  not do is exempt it from the re-check quietly." And of run 1: "The
  adopter's cure was a recorded baseline exempting the founding range,
  *which is the very thing §1.7 act 1 exists to prevent*. The order is now
  machinery-first, so that no literal executor needs that improvisation."
- **What I attempted:** run the full-history re-check over a history whose
  first two commits (acts 1a, 1b) carry no journals and no trailers — as the
  machinery-first order itself produces.
- **What happened / missing:** the re-check convicts them unless it knows the
  range; the text forbids a *quiet* exemption and prescribes declaration +
  retro-audit, but **specifies no mechanism by which the re-check tolerates
  the declared range**. The claim that machinery-first removes the need for
  the improvisation is wrong: acts 1a/1b still cannot pass the gate they
  install, so *some* recorded boundary is still required. The contradiction
  run 1 hit survives the reordering; only its size shrank (2 commits instead
  of a review's worth).
- **Disposition: PROCEEDED-BY-IMPROVISATION.** Invented: `FOUNDING.md`
  (`FOUNDING-RANGE-COMMITS: 2`), read by the re-check **from committed
  state**, announced loudly in a banner on every run ("This is a declaration,
  not a quiet exemption"), quoted in gate row G1, and examined by retro-audit
  finding AF-2 (which verified no third ungated commit exists). This is still
  a recorded baseline; I contend it is the *loud* one the text demands, but
  the text should say what "not quietly" looks like mechanically, because the
  thing it brands forbidden and the thing it demands are one mechanism apart.

### HALT-07 — §6.2 act 1b/1c: the committing seat's roster row is never activated
- **What the text says:** act 1c flips "the roster row … *planned → active*
  in the same commit" for **every remaining seat**; act 1b onboards the
  committing seat and names **no roster flip**; 1a says a row "stays
  *planned* until 1b or 1c makes it real".
- **What I attempted:** follow the letter. The orchestrator's row stayed
  *planned* while it made ten gated commits.
- **What happened / missing:** by the letter, the sole committer is never
  activated; the roster misdescribes the live seat indefinitely.
- **Disposition: PROCEEDED-BY-IMPROVISATION.** Invented: flip at the gate
  commit, routed through review finding F-REV-4 / audit finding AF-4 so the
  cure is cited rather than silent.

### HALT-08 — Annex A.3: "measure yours before copying"
- **What the text says:** journal thresholds are "anchored to a **measured
  substrate fact** — the largest file the agents' own reading tool will
  return in one call… measure yours before copying them."
- **What I attempted:** measure this world's reader limit. The reading tool
  here is line-based (2,000-line default, per-line truncation); it has no
  clean single-call byte figure.
- **What happened / missing:** the anchor's *quantity* does not exist in this
  substrate's terms; the instruction cannot be executed as written.
- **Disposition: PROCEEDED-BY-IMPROVISATION.** Invented: adopted the received
  figures (262,144 / 524,288) **declared unmeasured** in the policy module's
  own comment, residue row R-02 with owner and cadence, and gate open item 5
  requiring re-anchoring before the first sign-off.

### HALT-09 — §6.2 act 1a / §1.2: which seats a fresh adoption must roster
- **What the text says:** "Decide the seats by function (§1.2)". §1.2 names
  functions, deliberately not a required set; run 1's worker-role invention
  was routed (B.8 refusal 5) to "a kit template with the roles left as
  slots" — in the unreachable shell.
- **What I attempted:** derive a seat set from §1.2 alone.
- **What happened / missing:** the number of worker roles, their line
  assignment, and whether a contingent seat is mandatory are all
  undetermined.
- **Disposition: PROCEEDED-BY-IMPROVISATION.** Invented: five core seats +
  one worker role (`generic_worker`, implementation line); **no** contingent
  seat, on §1.2's own ground that no stateable activation trigger exists yet;
  the missing verification-line worker filed as review finding F-REV-2 and
  gate open item 3.

### HALT-10 — §6.2 Step 2: where the review lives and what "dispose" looks like
- **What the text says:** "run the review **into the repository** … Dispose
  of every finding in a committed artifact."
- **What I attempted:** find a path, an owning seat, or a disposition form
  for review artifacts. None is given anywhere (the packet forms that might
  carry a review verdict are kit items; §3.2 says review verdicts have zero
  file instances even at the origin).
- **Disposition: PROCEEDED-BY-IMPROVISATION.** Invented:
  `docs/reviews/founding-adversarial-review.md` under spec_lead's scope, with
  a per-finding disposition line inside the artifact itself.

### HALT-11 — §6.2 Step 3 as written fails against this platform
- **What the text says:** "Branch protection on every protected branch, with
  an empty bypass list… **Use rulesets rather than classic branch
  protection**… the required-status-check half cannot be configured before
  the check has run once."
- **What I attempted:** none of it is executable — no hosting platform is
  reachable in this world. Annex **A.6b** (added from run 1's HALT-08/09)
  covers exactly this substrate and prescribes the stand-in.
- **What happened:** built the A.6b stand-in: bare origin + pre-receive hook
  (non-fast-forward and deletion refusal on `work`/`trunk`, plus the
  full-history re-check on every push). First push GREEN (satisfying "after
  your continuous integration has run green at least once"); then live fire:
  force push → **BOUNCE**, branch deletion → **BOUNCE**, gate-bypassing raw
  commit → **RECHECK FAIL [R6] + BOUNCE**. All three cited in gate row G3 via
  J-orchestrator-0008. The two material differences A.6b demands declared
  (no bypass-list analogue; hook deletable by anyone with filesystem access);
  posture recorded as convention-grade (residue R-06).
- **Disposition: PROCEEDED-BY-IMPROVISATION.** Invented beyond A.6b's script:
  merging the CI surface and the protection surface into one hook, and
  creating `trunk` so "every protected branch" is plural in fact. A.6b is a
  run-1 repair that worked: it turned a dead end into a bounded build.

### HALT-12 — the run's own machinery failed against the real platform (pre-receive environment)
- **What the text says:** nothing — no step covers repairing one's own
  just-landed machinery mid-adoption, and §2.7/CONSTITUTION §6 make
  enforcement-script changes amendment-weight.
- **What I attempted:** first sandbox push through the committed hook.
- **What happened:** `fatal: not a git repository: '.'` — git runs
  pre-receive hooks with a relative `GIT_DIR` and quarantined object dirs;
  the re-check, running from a temp extraction dir, could not see the
  repository. The adjudicator was blind at its first live contact.
- **Disposition: PROCEEDED-BY-IMPROVISATION.** Invented: the fix
  (absolutize `GIT_DIR`, `GIT_OBJECT_DIRECTORY`,
  `GIT_ALTERNATE_OBJECT_DIRECTORIES`), proven in a sandbox **outside** the
  repository, then landed through this organization's own amendment
  procedure: ADR-0001 (spec_lead proposes, with the §6.4 **logged waiver**
  since enforcement semantics are unchanged) + the orchestrator's accepting
  and applying commit. The adoption order should expect this class: the first
  live fire is as likely to find the adopter's machinery wrong as the
  platform working.

### HALT-13 — DoD bullet 1 against §2.6's own counting note
- **What the text says:** DoD: "carries **at least one case per numbered
  rule**". §2.6: "*one rule has no script to name it at all* — the branch
  limb of `R9` — so the self-test's own form … **cannot be written for it**."
- **What I attempted:** satisfy both.
- **What happened / missing:** satisfiable only under the reading "per
  numbered id, any limb" (R9's merge limb has a case; its branch limb has the
  discharge note citing the live-fire bounce). The text supplies the
  ingredients of that reading ("thirteen rows, eleven numbers", "cases are
  not rows") but never states it against the DoD checkbox.
- **Disposition: PROCEEDED-BY-IMPROVISATION.** Invented: the per-number
  reading, said out loud in the suite output and here.

### HALT-14 — §6.2 Step 5: "the whole bootstrap range" is undefined
- **What the text says:** "the retro-audit of the whole bootstrap range by a
  seat that did not exist during it".
- **What I attempted:** bound the range. Candidates: the declared founding
  range (2 commits) or everything up to the gate (14 commits). Also: the
  auditor seat *did* exist from the fifth commit — created during the very
  range it audits — so "did not exist during it" is unsatisfiable even
  apart from the solo-run fiction.
- **Disposition: PROCEEDED-BY-IMPROVISATION.** Invented: range = root through
  the last pre-gate commit, stated in the audit's own text; the existence
  overlap folded into the declared weakness ("its author witnessed everything
  it audits"), which Step 5's honest-result block licenses.

### HALT-15 — §3.7's gate declarations against a solo gate whose transcriber owns rows
- **What the text says:** every gate file carries "no box in this file is
  checked by its author"; the orchestrator transcribes all signatures; three
  founding-gate items (G1, G3, G4) are the orchestrator's own.
- **What I attempted:** write the declaration truthfully into a file whose
  author-transcriber is also the owner-signer of three rows.
- **What happened / missing:** read literally the declaration is false in
  every solo founding; the clerical/authority split (§3.7, §4.7) rescues it
  only if glossed.
- **Disposition: PROCEEDED-BY-IMPROVISATION.** Invented: the gate file
  carries the declaration **plus an in-run gloss** stating exactly what it
  means here (signature = resolvable entry reference; the deeper fiction is
  declared in ADR-0002 and the open rows).

### HALT-16 — the program-state file is required by §1.6 and produced by no step
- **What the text says:** §1.6 makes the program-state file one of the six
  memory artifacts and the first file of the recovery sequence; the roster
  facsimile ships beside its facsimile. §6.2 schedules the roster (act 1a)
  and **never schedules the program-state file**.
- **What I attempted:** find its creation step. There is none.
- **What happened:** the whole bootstrap ran with no STATE.md; the
  retro-audit filed it (AF-5).
- **Disposition: PROCEEDED-BY-IMPROVISATION.** Invented: created at the gate
  commit (first moment there is program state worth recording), cure cited
  to AF-5.

### HALT-17 — §6.2 Step 6's day-one decision is attached to a step that (correctly) never runs
- **What the text says:** "Step 6 — only then start the work, and start the
  harvest cadence with it … with the harvest's destination decided on day
  one (§3.10)".
- **What I attempted:** Step 6 does not run — the gate is open, and the text
  itself says of run 1's equivalent, "the first work order never issued,
  because the gate never closed. That is the design working." But its inner
  clause ("destination decided on day one") is dated to day one, which is
  over before Step 6 is reachable in any honest solo run.
- **Disposition: PROCEEDED-BY-IMPROVISATION.** Invented: the relocation — the
  destination was decided in the constitution at act 1d (§10:
  `docs/harvest/`), restated in `docs/harvest/README.md` at the gate commit
  with the nil-yield-so-far declared. Step 6 itself: **not performed, per the
  text.**

---

## The document's own Definition of Done, evaluated

| # | DoD item | Result |
|---|---|---|
| 1 | Self-test green from a clean clone, ≥1 case per numbered rule, verified by reading the suite against the rule table | **MET.** Fresh clone of the origin: `selftest.sh` → 19 passed, 0 failed; read-off against CONSTITUTION §3: R1–R11 all cased (R9 via its merge limb; branch limb discharged by live fire, said in the suite); plus 1 amendment since founding (ADR-0001) which changed no semantics (logged waiver, no case owed). |
| 2 | Every `[MC]` claim traced or re-stamped, Step 0 recorded | **MET, form deviation declared** (trace table beside the document, as the DoD licenses): 34/34 rows NOT TRACED against the shell → `[RE]`-in-our-hands; re-anchored at Step 4 to refusals in our own machinery, with 4 defects found in our own machinery left open and declared — exactly the outcome the DoD predicts. |
| 3 | Platform dependency bounced a real attempted violation, cited in the gate record | **MET at convention grade** (Annex A.6b substrate): three real bounces (force push, deletion, gate-bypass), transcripts in J-orchestrator-0008, cited in gate row G3; the two A.6b material differences declared; posture drop recorded (residue R-06). |
| 4 | Bootstrap range retro-audited by a seat that did not write it… *or* independence declared unachievable, audit performed with weakness in text, row stays open | **MET via the "or" branch.** Retro-audit performed in persona, weakness first in its own text, 6 findings (1 critical), critical dispositioned by ADR-0002 and re-verified in a second report; G6b **OPEN**. An open row is a true row. |
| 5 | Residue list exists as a file, every review-enforced control named, routed, with a cadence | **MET.** `docs/RESIDUE.md`: 13 rows, opened at Step 0 empty-routed, filled at Step 2; no blank cadence cell (the column the received text says an adopter will leave blank). |

**Overall:** the adoption meets its own definition of done in the exact shape
the fourth edition says a solo run should: everything internal green and
signed, the two rows only an external party can close left open, and no work
started.

---

## SUMMARY

- **Total halts: 17.**
- **STOPPED: 0. PROCEEDED-BY-IMPROVISATION: 17** (of which 3 — HALT-01,
  HALT-11, HALT-17 — carried improvisation only in form, the substance being
  the text's own fallback).
- **Run 1 → run 2 trend (the number B.0.2 says is the claim):** 18 halts /
  3 stops → **17 halts / 0 stops**. The raw count is barely lower; the
  composition changed completely. Run 1's stops were world-reconstruction
  failures (no shell named, no numbers printed, no thresholds stated); run
  2's halts are bounded local improvisations, and several are *new* only
  because this run got deep enough to touch machinery run 1 never reached
  (the amendment procedure live-fired, gate signature mechanics, pre-receive
  environments).
- **Three most expensive halts:**
  1. **HALT-02** (kit unreachable): the entire executable layer's
     *implementation* — ~850 lines across five enforcement scripts plus the
     hook — remained pure invention; the shell is the half of the export unit
     that was supposed to supply it.
  2. **HALT-06** (founding range vs re-check): the one place the revised
     order still contradicts itself — it brands run 1's recorded baseline
     forbidden while prescribing no mechanism that isn't one; every future
     adopter will reinvent FOUNDING.md or equivalent.
  3. **HALT-12** (pre-receive environment failure): the first live fire found
     the adopter's own machinery broken, and repairing enforcement scripts
     mid-adoption under the just-authored amendment procedure is a real cost
     (sandbox proof + ADR + acceptance commit) the order never budgets.

**Could a blank adopter replicate this process from this document alone?**
Substantially yes — which could not be said of the edition run 1 executed.
The order now runs in sequence without manufacturing illegal states; every
solo-adopter dead end (three reviewers, sponsor signature, ratification,
independence) has a scripted honest path that was followed here without
invention; and the grammars, identifiers, thresholds and rule numbering that
run 1 reported as "roughly one hundred percent invention" transferred this
time as facsimiles, so the two machineries are comparable artifacts rather
than coincidences. What still had to be invented splits cleanly in two: the
**implementation** of the executable layer (all script logic and the CI/hook
engineering — the shell's job, and a shell-less adopter should budget most of
a day for it, plus one live-fire failure of their own machinery), and a
residue of **order defects** (the founding-range mechanism, the unactivated
committing seat, the unscheduled program-state file, the roster-column
mismatch, the undefined bootstrap range) that are each an hour's improvisation
but should be zero. By weight: the process layer — order, forms, postures,
disciplines, honest-failure handling — is now perhaps ninety percent
determined by the text; the executable layer remains near one hundred percent
invention in its logic while dropping to near zero invention in its
interfaces. The document's own bet — ship the reasons here, ship the machine
in the shell — is therefore half-vindicated and half-untested: this run
proves the reasons half now transfers; nothing about the machine half was
verifiable from this world, and every claim about it remains, as the document
itself insists, something to check before repeating.

---

*Artifacts of this run:* repository `cold-boot-run-2/adoption/` (18 commits
on `work`, pushed; bare origin with live hooks at `cold-boot-run-2/origin.git`;
attack clone evidence at `cold-boot-run-2/attack/`; composition tooling at
`cold-boot-run-2/run-tooling/`, outside the repository — audit finding AF-6); trace table
`adoption/docs/step0/TRACE-TABLE.md`; residue `adoption/docs/RESIDUE.md`;
review `adoption/docs/reviews/founding-adversarial-review.md`; decisions
`adoption/docs/decisions/ADR-0001…, ADR-0002…`; retro-audit and
re-verification under `adoption/docs/reports/audit/`; founding gate
`adoption/docs/gates/GATE-founding.md` (rows G5, G6b OPEN).*
